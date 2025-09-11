Config = {}

-- ========================================
-- ADDON INTEGRATION SETTINGS
-- ========================================
Config.AddonIntegration = {
    esx_billing = false,              -- Enable ESX Billing integration
    esx_society = false,              -- Enable ESX Society integration
    esx_jobs = false,                 -- Enable ESX Jobs integration
    zs_crypto = true                  -- Enable zs_cryptoaddon integration
}


-- ========================================
-- BLIP SETTINGS
-- ========================================
Config.ShowBankBlips = true          -- Show bank blips on the map
Config.ShowATMBlips = true           -- Show ATM blips on the map
Config.BankBlipSprite = 500          -- Bank blip sprite ID
Config.BankBlipScale = 0.8           -- Bank blip size
Config.ATMBlipSprite = 500           -- ATM blip sprite ID
Config.ATMBlipScale = 0.5            -- ATM blip size

-- Blip-Konfiguration für Banken
Config.Blipbank = {
    Blip = {
        Sprite = 500,
        Scale = 0.8,
        Colour = 2,  -- Grün
        Name = "BANK"
    }
}

-- Blip-Konfiguration für ATMs
Config.Blipatm = {
    Blip = {
        Sprite = 500,
        Scale = 0.5,
        Colour = 3,  -- Blau
        Name = "ATM"
    }
}

-- Blip-Einstellungen
Config.blipbankon = true             -- Bank-Blips aktivieren
Config.blipatmon = true              -- ATM-Blips aktivieren

-- ========================================
-- MARKER SETTINGS
-- ========================================
Config.ShowBankMarkers = true        -- Show 3D markers at banks
Config.ShowATMMarkers = true        -- Show 3D markers at ATMs
Config.MarkerColor = {r = 0, g = 255, b = 255, a = 100}  -- Marker color (RGBA)
Config.MarkerSize = {x = 1.5, y = 1.5, z = 1.0}          -- Marker size
Config.DrawDistance = 10.0           -- Distance to draw markers

-- Marker-Konfiguration für Banken
Config.Markerbank = {
    Marker = {
        DrawDistance = 10.0,
        Type = 1,
        Size = {x = 1.5, y = 1.5, z = 1.0},
        Color = {r = 0, g = 255, b = 255, a = 100}
    }
}

-- Marker-Konfiguration für ATMs
Config.Markeratm = {
    Marker = {
        DrawDistance = 8.0,
        Type = 1,
        Size = {x = 1.0, y = 1.0, z = 1.0},
        Color = {r = 0, g = 255, b = 255, a = 100}
    }
}

-- ========================================
-- TEXT UI SETTINGS
-- ========================================
Config.TextUIMessage = "Drücke ~INPUT_CONTEXT~ um Banking zu öffnen"  -- Text UI message
Config.TextUIDistance = 1.5          -- Distance to show Text UI
Config.UseESXTextUI = false           -- Use ESX Text UI instead of native

-- ========================================
-- LANGUAGE SETTINGS
-- ========================================
-- Available languages: de, en, cz, fr, pl
-- Verfügbare Sprachen: de, en, cz, fr, pl
Config.Language = "de"               -- Default language (de, en, cz, fr, pl)

-- ========================================
-- BANK SETTINGS
-- ========================================
Config.BankName = "ZS Banking"       -- Bank name displayed in UI

-- ========================================
-- MAIN BANKS (Green Blips) - Vollständige Banken mit Crypto
-- ========================================
Config.Banks = {
	{150.266, -1040.203, 29.374},
	{-1212.980, -330.841, 37.787},
	{-2962.582, 482.627, 15.703},
	{-112.202, 6469.295, 31.626},
	{314.187, -278.621, 54.170},
	{-351.534, -49.529, 49.042},
	{241.727, 220.706, 106.286},
	{1175.0643310547, 2706.6435546875, 38.094036102295}
}

-- ========================================
-- ATMs (Blue Blips) - Nur Bargeld-Transaktionen
-- ========================================
Config.SmallBanks = {
    	{-386.733, 6045.953, 31.501},
	{-284.037, 6224.385, 31.187},
	{-284.037, 6224.385, 31.187},
	{-135.165, 6365.738, 31.101},
	{-110.753, 6467.703, 31.784},
	{-94.9690, 6455.301, 31.784},
	{155.4300, 6641.991, 31.784},
	{174.6720, 6637.218, 31.784},
	{1703.138, 6426.783, 32.730},
	{1735.114, 6411.035, 35.164},
	{1702.842, 4933.593, 42.051},
	{1967.333, 3744.293, 32.272},
	{1821.917, 3683.483, 34.244},
	{1174.532, 2705.278, 38.027},
	{540.0420, 2671.007, 42.177},
	{2564.399, 2585.100, 38.016},
	{2558.683, 349.6010, 108.050},
	{2558.051, 389.4817, 108.660},
	{1077.692, -775.796, 58.218},
	{1139.018, -469.886, 66.789},
	{1168.975, -457.241, 66.641},
	{1153.884, -326.540, 69.245},
	{381.2827, 323.2518, 103.270},
	{236.4638, 217.4718, 106.840},
	{265.0043, 212.1717, 106.780},
	{285.2029, 143.5690, 104.970},
	{157.7698, 233.5450, 106.450},
	{-164.568, 233.5066, 94.919},
	{-1827.04, 785.5159, 138.020},
	{-1409.39, -99.2603, 52.473},
	{-1205.35, -325.579, 37.870},
	{-1215.64, -332.231, 37.881},
	{-2072.41, -316.959, 13.345},
	{-2975.72, 379.7737, 14.992},
	{-2962.60, 482.1914, 15.762},
	{-2955.70, 488.7218, 15.486},
	{-3044.22, 595.2429, 7.595},
	{-3144.13, 1127.415, 20.868},
	{-3241.10, 996.6881, 12.500},
	{-3241.11, 1009.152, 12.877},
	{-1305.40, -706.240, 25.352},
	{-538.225, -854.423, 29.234},
	{-711.156, -818.958, 23.768},
	{-717.614, -915.880, 19.268},
	{-526.566, -1222.90, 18.434},
	{-256.831, -719.646, 33.444},
	{-203.548, -861.588, 30.205},
	{112.4102, -776.162, 31.427},
	{112.9290, -818.710, 31.386},
	{119.9000, -883.826, 31.191},
	{149.4551, -1038.95, 29.366},
	{-846.304, -340.402, 38.687},
	{-1204.35, -324.391, 37.877},
	{-1216.27, -331.461, 37.773},
	{-56.1935, -1752.53, 29.452},
	{-261.692, -2012.64, 30.121},
	{-273.001, -2025.60, 30.197},
	{314.187, -278.621, 54.170},
	{-351.534, -49.529, 49.042},
	{24.589, -946.056, 29.357},
	{-254.112, -692.483, 33.616},
	{-1570.197,-546.651,34.955},
	{-1415.909,-211.825,46.500},
	{-1430.112,-211.014,46.500},
	{33.232,-1347.849,29.497},
	{129.216,-1292.347,29.269},
	{287.645,-1282.646,29.659},
	{289.012,-1256.545,29.440},
	{295.839,-895.640,29.217},
	{1686.753,4815.809,42.008},
	{-302.408,-829.945,32.417},
	{5.134,-919.949,29.557},
	{527.26,-160.76,57.09},
	{-867.19,-186.99,37.84},
	{-821.62,-1081.88,11.13},
	{-1315.32,-835.96,16.96},
	{-660.71,-854.06,24.48},
	{-1109.73,-1690.81,4.37},
	{-1091.5,2708.66,18.95},
	{1171.98,2702.55,38.18},
	{2683.09,3286.53,55.24},
	{89.61,2.37,68.31},
	{-30.3,-723.76,44.23},
	{-28.07,-724.61,44.23},
	{-613.24,-704.84,31.24},
	{-618.84,-707.9,30.5},
	{-1289.23,-226.77,42.45},
	{-1285.6,-224.28,42.45},
	{-1286.24,-213.39,42.45},
	{-1282.54,-210.45,42.45},
}

-- ========================================
-- TRANSACTION SETTINGS
-- ========================================
Config.Transfer = {
    fee = 0.0,                       -- Transfer fee (0.0 = no fee)
    maxAmount = 10000000             -- Maximum transfer amount
}

-- ========================================
-- BANK TYPE SETTINGS
-- ========================================
Config.BankTypes = {
    -- Hauptbanken: Vollständige Banking-Funktionen + Crypto
    mainBanks = {
        locations = Config.Banks,
        features = {
            crypto = true,            -- Crypto-Trading verfügbar
            transfers = true,         -- Überweisungen verfügbar
            history = true,           -- Transaktions-Historie verfügbar
            fullUI = true             -- Vollständige Banking-UI
        }
    },
    
    -- ATMs: Nur Bargeld-Transaktionen
    atms = {
        locations = Config.SmallBanks,
        features = {
            crypto = false,           -- Kein Crypto-Trading
            transfers = false,        -- Keine Überweisungen
            history = false,          -- Keine Transaktions-Historie
            fullUI = false            -- Nur einfache ATM-UI
        }
    }
}

-- ========================================
-- SOUND SETTINGS
-- ========================================
Config.Sounds = {
    enabled = true,                   -- Enable/disable all sounds
    buttonClick = true,               -- Button click sounds
    success = true,                   -- Success transaction sounds
    error = true                      -- Error sounds
}

-- ========================================
-- UI SETTINGS
-- ========================================
Config.UI = {
    autoUpdate = true,                -- Auto-update player data
    updateInterval = 5000,            -- Update interval in milliseconds
    showNotifications = true,         -- Show success/error notifications
    notificationDuration = 5000       -- Notification display time
}

-- ========================================
-- DEBUG SETTINGS
-- ========================================
Config.Debug = {
    enabled = true,                   -- Enable debug mode
    features = {
        showConsoleLogs = true,       -- Show console logs
        showAutoUpdateLogs = true,    -- Show auto-update logs
        showBlipLogs = true,          -- Show blip creation logs
        showMarkerLogs = false        -- Show marker drawing logs
    }
}

-- ========================================
-- SECURITY SETTINGS
-- ========================================
Config.Security = {
    maxTransactionsPerMinute = 10,    -- Maximum transactions per minute
    requireConfirmation = false,      -- Require confirmation for large amounts
    largeAmountThreshold = 100000     -- Amount threshold for confirmation
}

-- ========================================
-- PERFORMANCE SETTINGS
-- ========================================
Config.Performance = {
    enableOptimizations = true,       -- Enable performance optimizations
    reduceDrawCalls = true,           -- Reduce marker draw calls
    optimizeBlips = true              -- Optimize blip rendering
}

-- ========================================
-- COMPATIBILITY SETTINGS
-- ========================================
Config.Compatibility = {
    esxVersion = "legacy",            -- ESX version (legacy, 1.2, 1.3)
    enableLegacyMode = true,          -- Enable legacy ESX compatibility
    useOldNotifications = false       -- Use old notification system
}

-- ========================================
-- CUSTOMIZATION SETTINGS
-- ========================================
Config.Customization = {
    enableCustomThemes = false,       -- Enable custom UI themes
    defaultTheme = "dark",            -- Default theme (dark, light, custom)
    enableAnimations = true,          -- Enable UI animations
    animationSpeed = "normal"         -- Animation speed (slow, normal, fast)
}

-- ========================================
-- NOTIFICATION SETTINGS
-- ========================================
Config.Notifications = {
    position = "top-right",           -- Notification position
    sound = true,                     -- Play notification sounds
    vibration = false,                -- Mobile vibration (if supported)
    autoHide = true,                  -- Auto-hide notifications
    hideDelay = 5000                  -- Hide delay in milliseconds
}

-- ========================================
-- DATA PERSISTENCE SETTINGS
-- ========================================
Config.DataPersistence = {
    saveInterval = 300000,            -- Save interval in milliseconds (5 minutes)
    enableBackup = true,              -- Enable data backup
    backupInterval = 3600000,         -- Backup interval in milliseconds (1 hour)
    maxBackups = 10                   -- Maximum number of backups
}

-- ========================================
-- MONEY FORMAT SETTINGS
-- ========================================
Config.MoneyFormat = {
    currency = "$",                   -- Currency symbol
    thousandSeparator = ",",          -- Thousand separator
    decimalPlaces = 0,                -- Decimal places
    showCents = false                 -- Show cents in display
}

-- ========================================
-- ACCESS CONTROL SETTINGS
-- ========================================
Config.AccessControl = {
    requireJob = false,               -- Require specific job to access
    allowedJobs = {},                 -- List of allowed jobs
    requirePermission = false,        -- Require permission to access
    permissionName = "banking.access" -- Permission name
}

-- ========================================
-- TIMING SETTINGS
-- ========================================
Config.Timing = {
    openDelay = 100,                  -- Delay before opening UI (ms)
    closeDelay = 100,                 -- Delay before closing UI (ms)
    transactionDelay = 500,           -- Delay between transactions (ms)
    uiRefreshRate = 1000              -- UI refresh rate (ms)
}
