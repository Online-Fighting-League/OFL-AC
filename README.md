# OFL Anti-Cheat
[![Version](https://img.shields.io/github/v/release/Online-Fighting-League/OFL-AC?color=98FB98&style=for-the-badge)](https://onlinefightingleague.com/ac)
[![Downloads](https://img.shields.io/github/downloads/Online-Fighting-League/OFL-AC/total?color=%239370D8&label=Downloads&style=for-the-badge)](https://onlinefightingleague.com/ac)
[![Dev discord](https://img.shields.io/badge/Dev%20discord-%23OFL-7289DA?style=for-the-badge&logo=discord)](https://discord.gg/JdXxEmw)

This is a modified version of Cow Anti-Cheat. It is a drag and drop sourcemod plugin designed for use on tournament servers but is equally applicable for community servers due to its SourceBans integration.

Download latest stable build from the OFL website: https://onlinefightingleague.com/ac

# Dependencies
- Sourcebans (optional)
- Sourcebans++ (optional)
- SteamWorks (required)

# Detects
    Aimbot
    Triggerbot
    Silent-Strafe
    Bhop
    Macro/Hyperscroll
    AutoShoot
    Instant Plant and Defuse
    Perfect Strafe
    AHK/MSL Strafe
    Latency Manipulation
    Clan Tag Binds

# Checks
	Profile Checks
	Playtime Checks

# Usage
Detect and automatically ban players that hack and script on your server. Additionally close your server off to players who don't match profile or playtime requirements.
Customisable ban times, chose what is detected and if you dare... edit thresholds.


# Deploy
    Extract the zip in your `/csgo/` folder.
    Restart the server to load the plugin and generate config files.
    You can edit the config and change threshholds in the config `/cfg/sourcemod/ofl_anticheat.cfg`
	You can view detection logs at `/addons/sourcemod/logs/oflac_log.txt`

# ChangeLog

## [1.2.3] Emu - 06-07-2021
### Added
- Added detection for 
- File restructuting to standardise along with future products
