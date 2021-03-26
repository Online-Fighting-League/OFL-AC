# OFL Anti-Cheat
This is a modified version of Cow Anti-Cheat. It is a drag and drop sourcemod plugin designed for use on tournament servers but is equally applicable for community servers due to its SourceBans integration.

Download from the OFL website: https://onlinefightingleague.com/ac

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
    Instant Defuse
    Perfect Strafe
    AHK/MSL Strafe
	Game Hours
	Clan Tag Binds

# Useage
    Install OFLAntiCheat.smx into the `/plugins/` folder inside of Sourcemod on your game server
    Load the plugin manually, change maps or restart the server
    You can edit the config and change threshholds in the config `/cfg/OFLAntiCheat/OFLAntiCheat.cfg`
	You can view detection logs at `/addons/sourcemod/logs/OFLAC_Log.txt`

# ChangeLog

## [1.2.2] - 24-03-2021
### Added
- If enabled, a client can be kicked for changing their clan tag too often.
- Improved 'IsValidClient' checks on mutliple modules.
- CMD Value Rate Checking
- Debugging : sm_ac_debug

## [1.2.1] - 03-03-2021
### Added
- Profile checks and hours played checks due to new fix.
- SourceBans++ integration.
- Improved logging system.

## [1.2] - 26-02-2021
### Added
- Changed threshholds based off testing.
