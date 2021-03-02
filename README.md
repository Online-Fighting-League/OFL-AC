# OFL Anti-Cheat
This is a modified version of Cow Anti-Cheat. It is a drag and drop sourcemod plugin designed for use on tournament servers. Due to its designed purpose some features that are available in Cow Anti-Cheat have been taken out.

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
	Profile Checks

# Commands
- sm_bhopcheck / !bhopcheck

# Useage
Install OFLAntiCheat.smx into the `/plugins/` folder inside of Sourcemod on your game server
Load the plugin manually, change maps or restart the server
You can edit the config and change threshholds in the config `/cfg/OFLAntiCheat/OFLAntiCheat.cfg` (we advise against this)
You can view detection logs at `/addons/sourcemod/logs/OFLAC_Log.txt`

# ChangeLog

## [1.2.1] - 03-03-2021
### Added
- Re-added profile checks and hours played checks due to new fix.
- Added SourceBans++ integration
- Improved logging system

## [1.2] - 26-02-2021
### Added
- Removed profile checks and hours played checks.
- Changed threshholds based off testing.
