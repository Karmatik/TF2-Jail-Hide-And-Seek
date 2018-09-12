#pragma semicolon 1 

#include <sourcemod>
#include <sdktools>  
#include <sdkhooks>
#include <tf2>
#include <tf2_stocks>
#define PA "Elpapuh"
#define PV "1.5.7"
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
	HookEvent("player_death", OnPlayerDie, EventHookMode_Post);
	CreateTimer(60.0, Timer_Callback);
	TF2only();
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
	PrecacheSound("haseek/die.wav");
	PrecacheSound("haseek/die2.wav");
	PrecacheSound("sound/haseek/findred.wav");
	PrecacheSound("sound/haseek/blunear.wav");
	AddFileToDownloadsTable("sound/haseek/start.wav");
	AddFileToDownloadsTable("sound/haseek/die.wav");
	AddFileToDownloadsTable("sound/haseek/die2.wav");
	AddFileToDownloadsTable("sound/haseek/findred.wav");
	AddFileToDownloadsTable("sound/haseek/blunear.wav");
}

public Action OnRoundEnd(Handle event, const char[] name, bool dontBroadcast)
{
	//LEAVE THAT ALONE; DONT TOUCH THAT; WARNING: DANGER
	ServerCommand("sm plugins unload playhideandseek");
	ServerCommand("sm_powerplay @blue 0");
}

public Action Timer_Callback(Handle timer)
{
	//Commands to be executed nex-to 60 seconds
	ServerCommand("sm_freeze @red 560");
	ServerCommand("sm_powerplay @blue 0");
	EmitSoundToAll("haseek/start.wav");
	return Plugin_Continue;
}

public Action OnPlayerDie(Handle event, const char[] name, bool dontBroadcast)
{	
	new victimId = GetClientOfUserId(GetEventInt(event, "userid"));
	new attackerId = GetClientOfUserId(GetEventInt(event, "attacker"));


	if(TF2_GetClientTeam(attackerId) == TFTeam_Blue && TF2_GetClientTeam(victimId) == TFTeam_Red)
	{
		EmitSoundToAll("haseek/die2.wav", attackerId);
		EmitSoundToAll("haseek/die.wav", victimId);
	}
}


//FUTURE PLUGIN DEV

//public Action:Command_PlayWithoutLr (client, args)
//{
//	new Handle:hideandseek = CreateMenu(MenuCallBack);
//  SetMenuTitle(hideandseek, "Hide and seek Admin menu");
//  AddMenuItem(hideandseek, "on", "Turn On Hide and seek day");
//  AddMenuItem(hideandseek, "off", "Stop Hide and seek day");
//  AddMenuItem(hideandseek, "", "");
//  AddMenuItem(hideandseek, "", "");
//  AddMenuItem(hideandseek, "", "");
//  AddMenuItem(hideandseek, "", "");
//	SetMenuPagination(hideandseek, 2);
//  SetMenuExitButton(hideandseek, true);
//  DisplayMenu(hideandseek, client, 60);
//}


//public MenuCallBack(Handle:menuhandle, MenuAction:action, Client, Position)
//{
//}















TF2only()
{
	new String:Game[10];
	GetGameFolderName(Game, sizeof(Game));
	if(!StrEqual(Game, "tf"))
	{
		SetFailState("This plugin only works for TF2");
	}
}