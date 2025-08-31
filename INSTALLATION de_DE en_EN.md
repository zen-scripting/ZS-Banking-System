🔧 Installation Guide - ZS Banking System

📋 Voraussetzungen

ESX Legacy Framework
MySQL Datenbank
FiveM Server
Basic Lua Kenntnisse

---

🇩🇪 Deutsche Installation

📥 Schritt 1: Download

Lade das ZS Banking System von unserem Tebex Shop herunter
Entpacke die Dateien in deinen resources Ordner

📁 Schritt 2: Dateien einrichten

Kopiere den zs_banking Ordner in deinen resources Ordner
Stelle sicher, dass der Ordnername exakt zs_banking ist

🗄️ Schritt 3: Datenbank einrichten

Öffne deine MySQL Datenbank
Führe das SQL-Script aus database/schema.sql aus
Erstelle einen neuen Benutzer für das Banking-System

⚙️ Schritt 4: Konfiguration

Öffne config.lua
Passe die Datenbank-Einstellungen an
Konfiguriere Bank- und ATM-Standorte
Stelle sicher, dass alle Pfade korrekt sind

🔄 Schritt 5: Server starten

Füge zs_banking zu deiner server.cfg hinzu
Starte deinen FiveM Server neu
Überprüfe die Konsole auf Fehlermeldungen

✅ Schritt 6: Testen

Gehe zu einer Bank oder einem ATM
Drücke E um das Banking zu öffnen
Teste alle Funktionen

---

🇺🇸 English Installation

📥 Step 1: Download

Download the ZS Banking System from our Tebex Shop
Extract the files to your resources folder

📁 Step 2: Setup Files

Copy the zs_banking folder to your resources folder
Make sure the folder name is exactly zs_banking

🗄️ Step 3: Database Setup

Open your MySQL database
Run the SQL script from database/schema.sql
Create a new user for the banking system

⚙️ Step 4: Configuration

Open config.lua
Adjust the database settings
Configure bank and ATM locations
Make sure all paths are correct

🔄 Step 5: Start Server

Add zs_banking to your server.cfg
Restart your FiveM server
Check the console for error messages

✅ Step 6: Testing

Go to a bank or ATM
Press E to open banking
Test all functions

---

🔧 Konfiguration / Configuration

📝 Wichtige Einstellungen / Important Settings

Datenbank / Database:
host = "localhost"
user = "banking_user"
password = "your_password"
database = "your_database"

Bank-Standorte / Bank Locations:
Config.Banks = {
    {x, y, z, name, blip}
}

ATM-Standorte / ATM Locations:
Config.ATMs = {
    {x, y, z}
}

---

🚨 Häufige Probleme / Common Issues

❌ Problem: Banking öffnet sich nicht
✅ Lösung: Überprüfe ESX Framework und Datenbank-Verbindung

❌ Problem: Fehler beim Laden der Datenbank
✅ Lösung: Überprüfe MySQL-Berechtigungen und Schema

❌ Problem: UI wird nicht angezeigt
✅ Lösung: Überprüfe NUI-Dateien und Pfade

❌ Problem: Transaktionen werden nicht gespeichert
✅ Lösung: Überprüfe Datenbank-Tabellen und Berechtigungen

---

📚 Zusätzliche Hilfe / Additional Help

💬 Discord Community: https://discord.gg/RNzyXTuepc
📖 Dokumentation: Vollständige Anleitung verfügbar
🎥 Video-Tutorials: Schritt-für-Schritt Anleitung
🆘 Support: Professioneller Support verfügbar

---

⚡ Performance-Tipps / Performance Tips

Verwende MySQL-Indizes für bessere Performance
Reduziere Debug-Ausgaben in der Produktion
Verwende Connection-Pooling für Datenbank-Verbindungen
Optimiere Transaktionsabfragen

---

🔒 Sicherheitshinweise / Security Notes

Ändere Standard-Passwörter
Verwende sichere Datenbank-Benutzer
Aktiviere Firewall-Regeln
Überwache Logs regelmäßig

---

✅ Installation abgeschlossen / Installation Complete

Dein ZS Banking System ist jetzt einsatzbereit!
Your ZS Banking System is now ready to use!

Bei Problemen kontaktiere uns über Discord
For issues contact us via Discord
