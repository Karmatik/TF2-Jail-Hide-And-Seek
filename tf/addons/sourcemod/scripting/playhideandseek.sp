#pragma semicolon 1 

#include <sourcemod>
#include <sdktools>  
#define PA "Elpapuh"
#define PV "1.5.5"
#define PN "Hide and Seek"
#define PDESC "Play a better hide and seek mode in tf2 jailbreak server"
#define PURL "https://forums.alliedmods.net/showthread.php?t=300720"


public Plugin myinfo = 
{
	name = PN,
	author = PA,
	description = PDESC,
	version = PV,
	url = PURL
};

public void OnPluginStart()
{
	HookEvent("round_end", OnRoundEnd, EventHookMode_Post);
	HookEvent("teamplay_round_win", OnRoundEnd, EventHookMode_Post);
	CreateTimer(60.0, Timer_Callback);
	//(In progress) RegAdminCmd("sm_playhas", Command_PlayWithoutLr, ADMFLAG_CHEATS ,"Play Hide 'n seek without having to choose a lr");
}

public void OnPluginEnd()
{
	PrintToChatAll("Hide and seek day has ended");
}
			
public void OnMapStart()
{
	ServerCommand("sm_freeze @blue 59");
	ServerCommand("sm_powerplay @blue 1");
	ServerCommand("sm_opencells");
	PrecacheSound("haseek/start.wav", true);
	AddFileToDownloadsTable("sound/haseek/start.wav");
	//If you want to change for example, the time before blues go for catch, 
	//change the time, for example:
	//CreateTimer(30.0), Timer_Callback, _, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE)
	//ServerCommand("sm_freeze @blue 30");
	//ServerCommand("sm_powerplay @blue 1");
}

public Action OnRoundEnd(Handle event, const char[] name, bool dontBroadcast)
{
	//LEAVE THAT ALONE; DONT TOUCH THAT; WARNING: DANGER
	ServerCommand("sm plugins unload playhideandseek");
}

public Action Timer_Callback(Handle timer)
{
	//Commands to be executed nex-to 60 seconds
	ServerCommand("sm_freeze @red 560");
	ServerCommand("sm_powerplay @blue 0");
	EmitSoundToAll("haseek/start.wav");
	return Plugin_Continue;
}

//FUTURE PLUGIN DEV\\

//public Action:Command_PlayWithoutLr (client, args)
//{
//	Comming soon
//	Comming soon
//	Comming soon
//	Comming soon
//}