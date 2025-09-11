-- ========================================
-- ZS BANKING SERVER FUNCTIONS v1.0.0
-- Server-seitige Hilfsfunktionen
-- ========================================

-- Globale Variablen
local ESX = nil
local playerData = {}
local transactionCache = {}
local lastUpdate = 0

-- ========================================
-- INITIALISIERUNG
-- ========================================

function InitializeServerFunctions()
    print('^2[ZS Banking]^7 Initialisiere Server-Funktionen...')
    
    -- ESX laden
    while ESX == nil do
        ESX = exports['es_extended']:getSharedObject()
        Citizen.Wait(100)
    end
    
    -- Datenbank initialisieren
    InitializeDatabase()
    
    -- Cache leeren
    ClearCache()
    
    print('^2[ZS Banking]^7 Server-Funktionen erfolgreich initialisiert')
end

-- ========================================
-- DATENBANK-FUNKTIONEN
-- ========================================

function InitializeDatabase()
    if not Config.Server.Database.useMySQL or not MySQL then
        print('^3[ZS Banking]^7 WARNUNG: MySQL nicht verfügbar, verwende lokalen Speicher')
        return
    end
    
    if Config.Server.Database.autoCreateTables then
        CreateTables()
    end
end

function CreateTables()
    if not MySQL then return end
    
    -- Banking-Tabelle
    MySQL.Async.execute([[
        CREATE TABLE IF NOT EXISTS zs_banking_accounts (
            identifier VARCHAR(50) PRIMARY KEY,
            balance DECIMAL(15,2) DEFAULT 0,
            last_transaction TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        )
    ]], {})
    
    -- Transaktions-Tabelle
    MySQL.Async.execute([[
        CREATE TABLE IF NOT EXISTS zs_banking_transactions (
            id INT AUTO_INCREMENT PRIMARY KEY,
            identifier VARCHAR(50) NOT NULL,
            type VARCHAR(20) NOT NULL,
            amount DECIMAL(15,2) NOT NULL,
            balance_after DECIMAL(15,2) NOT NULL,
            description TEXT,
            target_identifier VARCHAR(50),
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            INDEX idx_identifier (identifier),
            INDEX idx_type (type),
            INDEX idx_created_at (created_at)
        )
    ]], {})
    
    print('^2[ZS Banking]^7 Datenbank-Tabellen erstellt')
end

-- ========================================
-- SPIELER-DATEN-FUNKTIONEN
-- ========================================

function GetPlayerData(identifier)
    if not identifier then return nil end
    
    -- Cache prüfen
    if playerData[identifier] and Config.Server.Performance.enableCaching then
        return playerData[identifier]
    end
    
    -- Aus Datenbank laden
    LoadPlayerData(identifier)
    return playerData[identifier]
end

function LoadPlayerData(identifier)
    if not MySQL then
        -- Fallback: Lokaler Speicher
        playerData[identifier] = {
            balance = 0,
            last_transaction = os.time()
        }
        return
    end
    
    MySQL.Async.fetchAll(
        'SELECT * FROM zs_banking_accounts WHERE identifier = @identifier',
        { ['@identifier'] = identifier },
        function(result)
            if result[1] then
                playerData[identifier] = {
                    balance = result[1].balance or 0,
                    last_transaction = result[1].last_transaction or os.time()
                }
            else
                -- Neues Konto erstellen
                playerData[identifier] = {
                    balance = 0,
                    last_transaction = os.time()
                }
                CreatePlayerAccount(identifier)
            end
        end
    )
end

function CreatePlayerAccount(identifier)
    if not MySQL then return end
    
    MySQL.Async.execute(
        'INSERT INTO zs_banking_accounts (identifier, balance) VALUES (@identifier, @balance)',
        {
            ['@identifier'] = identifier,
            ['@balance'] = 0
        }
    )
end

function SavePlayerData(identifier, data)
    if not MySQL then return end
    
    MySQL.Async.execute(
        'UPDATE zs_banking_accounts SET balance = @balance, last_transaction = @last_transaction WHERE identifier = @identifier',
        {
            ['@identifier'] = identifier,
            ['@balance'] = data.balance,
            ['@last_transaction'] = data.last_transaction
        }
    )
end

-- ========================================
-- TRANSAKTIONS-FUNKTIONEN
-- ========================================

function GetPlayerTransactions(identifier, limit)
    limit = limit or 50
    
    if not MySQL then
        return transactionCache[identifier] or {}
    end
    
    MySQL.Async.fetchAll(
        'SELECT * FROM zs_banking_transactions WHERE identifier = @identifier ORDER BY created_at DESC LIMIT @limit',
        {
            ['@identifier'] = identifier,
            ['@limit'] = limit
        },
        function(result)
            transactionCache[identifier] = result or {}
        end
    )
    
    return transactionCache[identifier] or {}
end

function AddTransaction(identifier, type, amount, balanceAfter, description, targetIdentifier)
    local transaction = {
        identifier = identifier,
        type = type,
        amount = amount,
        balance_after = balanceAfter,
        description = description or '',
        target_identifier = targetIdentifier,
        created_at = os.date('%Y-%m-%d %H:%M:%S')
    }
    
    -- In Datenbank speichern
    if MySQL then
        MySQL.Async.execute(
            'INSERT INTO zs_banking_transactions (identifier, type, amount, balance_after, description, target_identifier) VALUES (@identifier, @type, @amount, @balance_after, @description, @target_identifier)',
            {
                ['@identifier'] = identifier,
                ['@type'] = type,
                ['@amount'] = amount,
                ['@balance_after'] = balanceAfter,
                ['@description'] = description or '',
                ['@target_identifier'] = targetIdentifier
            }
        )
    end
    
    -- Cache aktualisieren
    if not transactionCache[identifier] then
        transactionCache[identifier] = {}
    end
    table.insert(transactionCache[identifier], 1, transaction)
    
    -- Cache begrenzen
    if #transactionCache[identifier] > 100 then
        table.remove(transactionCache[identifier], #transactionCache[identifier])
    end
end

-- ========================================
-- BANKING-FUNKTIONEN
-- ========================================

function DepositMoney(identifier, amount)
    local isValid, validAmount = Config.Server.Security.validateAmount(amount)
    if not isValid then
        return false, validAmount
    end
    
    local playerData = GetPlayerData(identifier)
    if not playerData then
        return false, 'Spielerdaten nicht gefunden'
    end
    
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    if not xPlayer then
        return false, 'Spieler nicht online'
    end
    
    local cashMoney = xPlayer.getMoney()
    if cashMoney < validAmount then
        return false, 'Nicht genügend Bargeld'
    end
    
    -- Geld transferieren
    xPlayer.removeMoney(validAmount)
    playerData.balance = playerData.balance + validAmount
    playerData.last_transaction = os.time()
    
    -- Speichern
    SavePlayerData(identifier, playerData)
    AddTransaction(identifier, 'deposit', validAmount, playerData.balance, 'Geld eingezahlt')
    
    return true, 'Geld erfolgreich eingezahlt'
end

function WithdrawMoney(identifier, amount)
    local isValid, validAmount = Config.Server.Security.validateAmount(amount)
    if not isValid then
        return false, validAmount
    end
    
    local playerData = GetPlayerData(identifier)
    if not playerData then
        return false, 'Spielerdaten nicht gefunden'
    end
    
    if playerData.balance < validAmount then
        return false, 'Nicht genügend Geld auf dem Konto'
    end
    
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    if not xPlayer then
        return false, 'Spieler nicht online'
    end
    
    -- Geld transferieren
    xPlayer.addMoney(validAmount)
    playerData.balance = playerData.balance - validAmount
    playerData.last_transaction = os.time()
    
    -- Speichern
    SavePlayerData(identifier, playerData)
    AddTransaction(identifier, 'withdraw', validAmount, playerData.balance, 'Geld abgehoben')
    
    return true, 'Geld erfolgreich abgehoben'
end

function TransferMoney(sourceIdentifier, targetIdentifier, amount)
    local isValid, validAmount = Config.Server.Security.validateAmount(amount)
    if not isValid then
        return false, validAmount
    end
    
    local sourceData = GetPlayerData(sourceIdentifier)
    local targetData = GetPlayerData(targetIdentifier)
    
    if not sourceData or not targetData then
        return false, 'Spielerdaten nicht gefunden'
    end
    
    if sourceData.balance < validAmount then
        return false, 'Nicht genügend Geld auf dem Konto'
    end
    
    -- Geld transferieren
    sourceData.balance = sourceData.balance - validAmount
    targetData.balance = targetData.balance + validAmount
    
    sourceData.last_transaction = os.time()
    targetData.last_transaction = os.time()
    
    -- Speichern
    SavePlayerData(sourceIdentifier, sourceData)
    SavePlayerData(targetIdentifier, targetData)
    
    -- Transaktionen hinzufügen
    AddTransaction(sourceIdentifier, 'transfer_out', validAmount, sourceData.balance, 'Geld überwiesen an ' .. targetIdentifier, targetIdentifier)
    AddTransaction(targetIdentifier, 'transfer_in', validAmount, targetData.balance, 'Geld erhalten von ' .. sourceIdentifier, sourceIdentifier)
    
    return true, 'Geld erfolgreich überwiesen'
end

-- ========================================
-- VALIDIERUNGS-FUNKTIONEN
-- ========================================

function ValidatePlayer(identifier)
    if not identifier or identifier == '' then
        return false, 'Ungültige Spieler-ID'
    end
    
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    if not xPlayer then
        return false, 'Spieler nicht gefunden'
    end
    
    return true, xPlayer
end

function ValidateTransaction(amount, type)
    local isValid, validAmount = Config.Server.Security.validateAmount(amount)
    if not isValid then
        return false, validAmount
    end
    
    if type and type ~= 'deposit' and type ~= 'withdraw' and type ~= 'transfer' then
        return false, 'Ungültiger Transaktionstyp'
    end
    
    return true, validAmount
end

-- ========================================
-- CACHE-FUNKTIONEN
-- ========================================

function ClearCache()
    playerData = {}
    transactionCache = {}
    lastUpdate = 0
    print('^2[ZS Banking]^7 Cache geleert')
end

function UpdateCache()
    if not Config.Server.Performance.shouldUpdate() then
        return
    end
    
    local currentTime = GetGameTimer()
    if currentTime - lastUpdate < Config.Server.Performance.updateInterval then
        return
    end
    
    lastUpdate = currentTime
    
    -- Hier könnten periodische Cache-Updates implementiert werden
    Config.Server.Debug.log('Cache aktualisiert', 'showAutoUpdateLogs')
end

-- ========================================
-- ADMIN-FUNKTIONEN
-- ========================================

function ResetPlayerData(identifier)
    if not Config.Server.Admin.canResetPlayerData then
        return false, 'Keine Berechtigung'
    end
    
    playerData[identifier] = {
        balance = 0,
        last_transaction = os.time()
    }
    
    SavePlayerData(identifier, playerData[identifier])
    
    if MySQL then
        MySQL.Async.execute(
            'DELETE FROM zs_banking_transactions WHERE identifier = @identifier',
            { ['@identifier'] = identifier }
        )
    end
    
    transactionCache[identifier] = {}
    
    return true, 'Spielerdaten zurückgesetzt'
end

function ModifyPlayerBalance(identifier, amount)
    if not Config.Server.Admin.canModifyBalances then
        return false, 'Keine Berechtigung'
    end
    
    local playerData = GetPlayerData(identifier)
    if not playerData then
        return false, 'Spielerdaten nicht gefunden'
    end
    
    playerData.balance = playerData.balance + amount
    playerData.last_transaction = os.time()
    
    SavePlayerData(identifier, playerData)
    AddTransaction(identifier, 'admin_modify', amount, playerData.balance, 'Admin-Modifikation')
    
    return true, 'Kontostand geändert'
end

-- ========================================
-- UTILITY-FUNKTIONEN
-- ========================================

function FormatMoney(amount)
    return string.format('%.2f', amount)
end

function GetPlayerName(identifier)
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    if xPlayer then
        return xPlayer.getName()
    end
    return 'Unbekannt'
end

function IsPlayerOnline(identifier)
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    return xPlayer ~= nil
end

-- ========================================
-- EXPORT-FUNKTIONEN
-- ========================================

-- Diese Funktionen werden von anderen Scripts verwendet
function GetPlayerBalance(identifier)
    local playerData = GetPlayerData(identifier)
    return playerData and playerData.balance or 0
end

function AddPlayerMoney(identifier, amount)
    local playerData = GetPlayerData(identifier)
    if not playerData then return false end
    
    playerData.balance = playerData.balance + amount
    playerData.last_transaction = os.time()
    
    SavePlayerData(identifier, playerData)
    AddTransaction(identifier, 'external_add', amount, playerData.balance, 'Externe Einzahlung')
    
    return true
end

function RemovePlayerMoney(identifier, amount)
    local playerData = GetPlayerData(identifier)
    if not playerData then return false end
    
    if playerData.balance < amount then return false end
    
    playerData.balance = playerData.balance - amount
    playerData.last_transaction = os.time()
    
    SavePlayerData(identifier, playerData)
    AddTransaction(identifier, 'external_remove', amount, playerData.balance, 'Externe Abhebung')
    
    return true
end

print('^2[ZS Banking]^7 Server-Funktionen geladen v1.0.0')
