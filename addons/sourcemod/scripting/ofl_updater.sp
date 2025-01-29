//    {Updater. Edited Updater plugin. Originally created by GoD-Tony. Edited by Neoony.}
//    Copyright (C) {2019}  {Neoony}
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

/* SM Includes */
#include <sourcemod>
#undef REQUIRE_EXTENSIONS
#include <SteamWorks>
#define REQUIRE_EXTENSIONS

//Neat
//#pragma semicolon 1
//#pragma newdecls required

/* Plugin Info */
#define PLUGIN_NAME 		"OFL Updater"
#define PLUGIN_VERSION 		"1.2.5"

public Plugin:myinfo =
{
	name = PLUGIN_NAME,
	author = "OFL & GoD-Tony",
	description = "Automatically updates SourceMod plugins and files",
	version = PLUGIN_VERSION,
	url = "https://abrhosting.com/legeacy/anti-cheat/updater/"
};

ConVar u_debug;


#define STEAMWORKS_AVAILABLE()	(GetFeatureStatus(FeatureType_Native, "SteamWorks_WriteHTTPResponseBodyToFile") == FeatureStatus_Available)

#define EXTENSION_ERROR		"This plugin requires one of the cURL, Socket, SteamTools, or SteamWorks extensions to function."
#define TEMP_FILE_EXT		"temp"		// All files are downloaded with this extension first.
#define MAX_URL_LENGTH		256

#define UPDATE_URL			"https://abrhosting.com/legeacy/anti-cheat/updater/update.txt"

enum UpdateStatus {
	Status_Idle,		
	Status_Checking,		// Checking for updates.
	Status_Downloading,		// Downloading an update.
	Status_Updated,			// Update is complete.
	Status_Error,			// An error occured while downloading.
};

new bool:g_bGetDownload, bool:g_bGetSource;

new Handle:g_hPluginPacks = INVALID_HANDLE;
new Handle:g_hDownloadQueue = INVALID_HANDLE;
new Handle:g_hRemoveQueue = INVALID_HANDLE;
new bool:g_bDownloading = false;

//static Handle:_hUpdateTimer = INVALID_HANDLE;
//static Float:_fLastUpdate = 0.0;
static String:_sDataPath[PLATFORM_MAX_PATH];

//float updinterval = "86400.0";

/* Core Includes */
#include "updater/plugins.sp"
#include "updater/filesys.sp"
#include "updater/download.sp"
#include "updater/api.sp"
#include "updater/download_steamworks.sp"

/* Plugin Functions */
public APLRes:AskPluginLoad2(Handle:myself, bool:late, String:error[], err_max)
{
	// cURL
	//MarkNativeAsOptional("curl_OpenFile");
	//MarkNativeAsOptional("curl_slist");
	//MarkNativeAsOptional("curl_slist_append");
	//MarkNativeAsOptional("curl_easy_init");
	//MarkNativeAsOptional("curl_easy_setopt_int_array");
	//MarkNativeAsOptional("curl_easy_setopt_handle");
	//MarkNativeAsOptional("curl_easy_setopt_string");
	//MarkNativeAsOptional("curl_easy_perform_thread");
	//MarkNativeAsOptional("curl_easy_strerror");
	
	// Socket
	//MarkNativeAsOptional("SocketCreate");
	//MarkNativeAsOptional("SocketSetArg");
	//MarkNativeAsOptional("SocketSetOption");
	//MarkNativeAsOptional("SocketConnect");
	//MarkNativeAsOptional("SocketSend");
	
	// SteamTools
	//MarkNativeAsOptional("Steam_CreateHTTPRequest");
	//MarkNativeAsOptional("Steam_SetHTTPRequestHeaderValue");
	//MarkNativeAsOptional("Steam_SendHTTPRequest");
	//MarkNativeAsOptional("Steam_WriteHTTPResponseBody");
	//MarkNativeAsOptional("Steam_ReleaseHTTPRequest");
	
	API_Init();
	RegPluginLibrary("updater");
	
	return APLRes_Success;
}

public OnPluginStart()
{
	if (!STEAMWORKS_AVAILABLE())
	{
		SetFailState(EXTENSION_ERROR);
	}
	
	LoadTranslations("common.phrases");
	
	// Convars.
	new Handle:hCvar = INVALID_HANDLE;
	
	hCvar = CreateConVar("sm_updater_version", PLUGIN_VERSION, PLUGIN_NAME, FCVAR_NOTIFY|FCVAR_DONTRECORD);
	OnVersionChanged(hCvar, "", "");
	HookConVarChange(hCvar, OnVersionChanged);
	
	hCvar = CreateConVar("sm_updater", "2", "Determines update functionality. (1 = Notify, 2 = Download, 3 = Include source code)", _, true, 1.0, true, 3.0);
	OnSettingsChanged(hCvar, "", "");
	HookConVarChange(hCvar, OnSettingsChanged);
	
	u_debug = CreateConVar("u_debug", "0", "Enable showing debug messages in console");
	
	// Commands.
	RegAdminCmd("sm_updater_check", Command_Check, ADMFLAG_RCON, "Forces Updater to check for updates.");
	RegAdminCmd("sm_updater_status", Command_Status, ADMFLAG_RCON, "View the status of Updater.");
	RegConsoleCmd("u_version", Command_PluginVer, "Updater plugin version");

	// Initialize arrays.
	g_hPluginPacks = CreateArray();
	g_hDownloadQueue = CreateArray();
	g_hRemoveQueue = CreateArray();
	
	// Temp path for checking update files.
	BuildPath(Path_SM, _sDataPath, sizeof(_sDataPath), "data/updater.txt");
	
	// Add this plugin to the autoupdater.
	Updater_AddPlugin(GetMyHandle(), UPDATE_URL);
}

public OnAllPluginsLoaded()
{
	// Check for updates on startup.
	TriggerUpdate();
	if (GetConVarInt(u_debug) == 1)
	{
		PrintToServer("[Updater] Auto checking for Updates");
	}
}

public OnMapEnd()
{
	Updater_FreeMemory();
	
	// Update everything!
	new maxPlugins = GetMaxPlugins();
	for (new i = 0; i < maxPlugins; i++)
	{		
		if (Updater_GetStatus(i) == Status_Idle)
		{
			//new Float:fNextUpdate = _fLastUpdate + 3600.0;
			//
			//if (fNextUpdate > GetTickedTime())
			//{
			//	PrintToServer("[Updater] Updates can only be checked once per hour. %.1f minutes remaining.", (fNextUpdate - GetTickedTime()) / 60.0);
			//}
			//else
			Updater_Check(i);
			if (GetConVarInt(u_debug) == 1)
			{
				PrintToServer("[Updater] Doing update check.");
			}
		}
	}
	
	//_fLastUpdate = GetTickedTime();
	
	//return Plugin_Continue;
}

TriggerUpdate()
{
	Updater_FreeMemory();
	
	// Update everything!
	new maxPlugins = GetMaxPlugins();
	for (new i = 0; i < maxPlugins; i++)
	{		
		if (Updater_GetStatus(i) == Status_Idle)
		{
			//new Float:fNextUpdate = _fLastUpdate + 3600.0;
			//
			//if (fNextUpdate > GetTickedTime())
			//{
			//	PrintToServer("[Updater] Updates can only be checked once per hour. %.1f minutes remaining.", (fNextUpdate - GetTickedTime()) / 60.0);
			//}
			//else
			Updater_Check(i);
			if (GetConVarInt(u_debug) == 1)
			{
				PrintToServer("[Updater] Doing update check.");
			}
		}
	}
	
	//_fLastUpdate = GetTickedTime();
	
	//return Plugin_Continue;
}

public Action:Command_Check(client, args)
{
	{
		ReplyToCommand(client, "[Updater] Checking for updates.");
		TriggerUpdate();
	}

	return Plugin_Handled;
}

public Action:Command_Status(client, args)
{
	decl String:sFilename[64];
	new Handle:hPlugin = INVALID_HANDLE;
	new maxPlugins = GetMaxPlugins();
	
	ReplyToCommand(client, "[Updater] -- Status Begin --");
	ReplyToCommand(client, "Plugins being monitored for updates:");
	
	for (new i = 0; i < maxPlugins; i++)
	{
		hPlugin = IndexToPlugin(i);
		
		if (IsValidPlugin(hPlugin))
		{
			GetPluginFilename(hPlugin, sFilename, sizeof(sFilename));
			ReplyToCommand(client, "  [%i]  %s", i, sFilename);
		}
	}
	
	//ReplyToCommand(client, "Last update check was %.1f minutes ago.", (GetTickedTime() - _fLastUpdate) / 60.0);
	ReplyToCommand(client, "[Updater] --- Status End ---");

	return Plugin_Handled;
}

public OnVersionChanged(Handle:convar, const String:oldValue[], const String:newValue[])
{
	if (!StrEqual(newValue, PLUGIN_VERSION))
	{
		SetConVarString(convar, PLUGIN_VERSION);
	}
}

public OnSettingsChanged(Handle:convar, const String:oldValue[], const String:newValue[])
{
	switch (GetConVarInt(convar))
	{
		case 1: // Notify only.
		{
			g_bGetDownload = false;
			g_bGetSource = false;
		}
		
		case 2: // Download updates.
		{
			g_bGetDownload = true;
			g_bGetSource = false;
		}
		
		case 3: // Download with source code.
		{
			g_bGetDownload = true;
			g_bGetSource = true;
		}
	}
}


public Updater_OnPluginUpdated()
{
	if (GetConVarInt(u_debug) == 1)
	{
		Updater_Log("Reloading Updater plugin... updates will resume automatically.");
	
		// Reload this plugin.
		decl String:filename[64];
		GetPluginFilename(INVALID_HANDLE, filename, sizeof(filename));
		ServerCommand("sm plugins reload %s", filename);
	}
}


Updater_Check(index)
{
	if (Fwd_OnPluginChecking(IndexToPlugin(index)) == Plugin_Continue)
	{
		decl String:url[MAX_URL_LENGTH];
		Updater_GetURL(index, url, sizeof(url));
		Updater_SetStatus(index, Status_Checking);
		AddToDownloadQueue(index, url, _sDataPath);
	}
}

Updater_FreeMemory()
{
	// Make sure that no threads are active.
	if (g_bDownloading || GetArraySize(g_hDownloadQueue))
	{
		return;
	}
	
	// Remove all queued plugins.	
	new index;
	new maxPlugins = GetArraySize(g_hRemoveQueue);
	for (new i = 0; i < maxPlugins; i++)
	{
		index = PluginToIndex(GetArrayCell(g_hRemoveQueue, i));
		
		if (index != -1)
		{
			Updater_RemovePlugin(index);
		}
	}
	
	ClearArray(g_hRemoveQueue);
	
	// Remove plugins that have been unloaded.
	for (new i = 0; i < GetMaxPlugins(); i++)
	{
		if (!IsValidPlugin(IndexToPlugin(i)))
		{
			Updater_RemovePlugin(i);
			i--;
		}
	}
}

Updater_Log(const String:format[], any:...)
{
	decl String:buffer[256], String:path[PLATFORM_MAX_PATH];
	VFormat(buffer, sizeof(buffer), format, 2);
	BuildPath(Path_SM, path, sizeof(path), "logs/Updater.log");
	LogToFileEx(path, "%s", buffer);
}

/*
Updater_DebugLog(const String:format[], any:...)
{
	if (GetConVarInt(u_debug) == 1)
	{
		decl String:buffer[256], String:path[PLATFORM_MAX_PATH];
		VFormat(buffer, sizeof(buffer), format, 2);
		BuildPath(Path_SM, path, sizeof(path), "logs/Updater_Debug.log");
		LogToFileEx(path, "%s", buffer);
	}
}
*/

public Action Command_PluginVer(int client, int args)
{
	PrintToConsole(client,"%s",PLUGIN_VERSION);
}