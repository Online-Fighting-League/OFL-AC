# OFL Anti-Cheat
[![Version](https://img.shields.io/github/v/release/Online-Fighting-League/OFL-AC?color=98FB98&style=for-the-badge)](https://onlinefightingleague.com/ac)
[![Dev discord](https://img.shields.io/badge/Dev%20discord-OFL-7289DA?style=for-the-badge&logo=discord)](https://discord.gg/JdXxEmw)
[![Twitter](https://img.shields.io/twitter/follow/ofl_esports?style=for-the-badge)](https://twitter.com/ofl_esports)

Designed for community servers and league servers. A drag and drop solution to support admins in keeping your server clean of hackers.
This being a server-side plugin it is not (and will never be) a catch all solution. You should always have some method of human intervention to investigate those that fall through the net.

Latest builds and auto updates are hosted on: https://onlinefightingleague.com/

# What is OFL?
The Online Fighting League was and still is an esport event organiser. But is slowly moving towards hosting an online matchmaking system and league automation system for third-party organisers to utilise, allowing them to focus on what is important in an event. If you wish to help us then you can join our discord or contact us through our [Support Site](https://support.onlinefigthingleague.com). We currently do not accept donations but will be opening a donation portal to support us soon.

All our products, open source, free, proprietary and whatever else, are made with <3 from the UK 🇬🇧

# Dependencies
- Sourcebans (optional)
- Sourcebans++ (optional)
- Updater (included)
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

# Updates
OFL Anti-Cheat will automatically install the latest version on server restart or every 24hours.
If you don't wish to have automatic updates then you can use 'sm_updater 1' and you will only get a notice to the updater log file.

# Changes
## [1.3.0] Koala - 06-07-2021
This update included a lot of quality of life updates. Mainly making it easier for people to code their own improvements. We are always open to pull requests that improve the plugin.
We like naming major releases with an animal. We will try to link a major release to a relevant animal and you can guess the link.
### Changes
+ Automatic plugin updating 
+ Added some includes to the file to make your life compiling the plugin easier
+ Some more code comments
+ Fixed some spelling errors
