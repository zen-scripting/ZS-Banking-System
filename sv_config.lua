-- ========================================
-- ZS BANKING SERVER CONFIG v1.0.0.0
-- Server-spezifische Konfiguration
-- ========================================

Config.Server = {
    -- System-Einstellungen
    Version = '1.0.0.0',
    Debug = {
        enabled = true,
        showBankingLogs = false,
        showTransactionLogs = false,
        showPlayerDataLogs = false,
        showAutoUpdateLogs = false,
        showBlipLogs = false,
        showMarkerLogs = false,
        showCryptoStatus = true
    },
    
    -- Datenbank-Einstellungen
    Database = {
        useMySQL = true,
        autoCreateTables = true,
        saveInterval = 300000, -- 5 Minuten
        maxRetries = 3
    },
    
    -- Performance-Einstellungen
    Performance = {
        updateInterval = 1000, -- 1 Sekunde
        maxPlayersPerUpdate = 20,
        enableCaching = true,
        cacheTimeout = 300000 -- 5 Minuten
    },
    
    -- Sicherheits-Einstellungen
    Security = {
        maxTransactionAmount = 1000000, -- 1 Million
        minTransactionAmount = 1,
        maxDailyTransactions = 100,
        requireConfirmation = true,
        enableAntiCheat = true
    },
    
    -- Admin-Einstellungen
    Admin = {
        groups = { 'admin', 'superadmin', 'moderator', 'owner' },
        canResetPlayerData = true,
        canViewAllTransactions = true,
        canModifyBalances = true
    },
    
    -- Crypto-Addon Einstellungen
    Crypto = {
        enabled = true,
        updateInterval = 30000, -- 30 Sekunden
        maxTradingAmount = 100000,
        minTradingAmount = 0.001,
        tradingFee = 0.001, -- 0.1%
        withdrawalFee = 0.005 -- 0.5%
    },
    
    -- Event-Einstellungen
    Events = {
        enableNotifications = true,
        enableSounds = true,
        enableAnimations = true,
        notificationDuration = 5000 -- 5 Sekunden
    }
}

-- Debug-Funktionen
function Config.Server.Debug.log(message, category)
    if Config.Server.Debug.enabled and Config.Server.Debug[category] then
        print('^3[ZS Banking Debug]^7 [' .. category .. '] ' .. message)
    end
end

-- Validierungs-Funktionen
function Config.Server.Security.validateAmount(amount)
    local numAmount = tonumber(amount)
    if not numAmount or numAmount < Config.Server.Security.minTransactionAmount then
        return false, 'Betrag zu niedrig'
    end
    if numAmount > Config.Server.Security.maxTransactionAmount then
        return false, 'Betrag zu hoch'
    end
    return true, numAmount
end

function Config.Server.Admin.isAdmin(xPlayer)
    if not xPlayer then return false end
    local playerGroup = xPlayer.getGroup()
    for _, group in ipairs(Config.Server.Admin.groups) do
        if playerGroup == group then
            return true
        end
    end
    return false
end

-- Performance-Funktionen
function Config.Server.Performance.shouldUpdate()
    -- Hier könnten komplexere Logik für Update-Timing implementiert werden
    return true
end

print('^2[ZS Banking]^7 Server Config geladen v' .. Config.Server.Version)
