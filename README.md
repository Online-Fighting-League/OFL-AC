# OFL Anti-Cheat
[![Version](https://img.shields.io/github/v/release/ABR-Hosting/OFL-AC?color=98FB98&style=for-the-badge)](https://abrhosting.com/)
[![Dev discord](https://img.shields.io/badge/Dev%20discord-OFL-7289DA?style=for-the-badge&logo=discord)](https://discord.gg/kxqSuPQpr3)


Designed for community servers and league servers. A drag-and-drop solution to support admins in keeping your server clean of hackers. This being a server-side plugin, it is not (and will never be) a catch-all solution. You should always have some method of human intervention to investigate those that fall through the net.


This plugin is designed to work on source servers. Originally being created for CSGO and TF2. There are no expected future updates.


Support for this plugin is maintained by ABR Hosting.


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
Detect and automatically ban players that hack and script on your server. Additionally, close your server off to players who don't match profile or playtime requirements.
Customisable ban times: choose what is detected and, if you dare... edit thresholds.


# Deploy
    Extract the zip in your `/csgo/` folder. Or other source game.
    Restart the server to load the plugin and generate config files.
  You can edit the config and change thresholds in the config `/cfg/sourcemod/ofl_anticheat.cfg`
    You can view detection logs at `/addons/sourcemod/logs/oflac_log.txt`


# Updates
OFL Anti-Cheat will automatically install the latest version on server restart or every 24 hours.
If you don't wish to have automatic updates, then you can use 'sm_updater 1' and you will only get a notice in the updater log file.


# Changes
## [1.3.1] Koala - 29-01-2025
Yes, an update. As requested, an update has been put in place to fix the issue with the updater error in the console. The OFL servers were shut down years ago, but we have moved the anti-cheat website and file hosting of all versions onto the ABR Hosting legacy file system due to public interest. We would like to say a thank you to people who still find this plugin helpful.


## [1.3.0] Koala - 06-07-2021
This update included a lot of quality of life updates. Mainly making it easier for people to code their own improvements. We are always open to pull requests that improve the plugin.
We like naming major releases with an animal. We will try to link a major release to a relevant animal, and you can guess the link.
### Changes
+ Automatic plugin updating
+ Added some includes to the file to make your life compiling the plugin easier
+ Some more code comments
+ Fixed some spelling errors

