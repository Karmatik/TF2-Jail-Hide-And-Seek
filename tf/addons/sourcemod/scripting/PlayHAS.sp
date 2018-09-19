//Stropy
#define PN "Hide and Seek [NPDU]" //NPDU = No plugins dependencies update
#define PA "Elpapuh"
#define PDESC "Play a better hide and seek mode in tf2 jailbreak server"
#define PV "1.6.5"
#define PURL "https://forums.alliedmods.net/showthread.php?t=300720"

public Plugin myinfo = 
{
	name = PN,
	author = PA,
	description = PDESC,
	version = PV,
	url = PURL
};

#pragma semicolon 1

#include <sourcemod>
#include <sdkhooks>
#include <tf2_stocks>
#include <tf2items>
#include <morecolors>
#include <smlib>
#include <tf2jail>
#include <tf2_advanced>

new Handle:StartSearchTimer = INVALID_HANDLE;
new Handle:FreezeTimer = INVALID_HANDLE;
new Handle:HP = INVALID_HANDLE;
new Handle:HP1 = INVALID_HANDLE;
new Handle:HP2 = INVALID_HANDLE;
new Handle:HP3 = INVALID_HANDLE;
new Handle:HP4 = INVALID_HANDLE;
new Handle:HP5 = INVALID_HANDLE;
new Handle:NoUber = INVALID_HANDLE;

new bool:g_bLateLoad = false;
new bool:g_bFallDamage = false;

public TF2Jail_OnLastRequestExecute(const String:Handler[])
{	

	if (StrEqual(Handler, "PlayHAS"))
	{
		ServerCommand("sm_freeze @blue 29");
		
		TF2Jail_ManageCells(OPEN);
		
		for (new i = 1; i <= MaxClients; i++)
		{
			if (IsClientInGame(i) && IsPlayerAlive(i))
			{
				switch (GetClientTeam(i))
				{
				
					case TFTeam_Red:
					{
						CPrintToChat(i, "{haunted}[{magenta}HideAndSeek{haunted}] {orange}You have to hide faster as you can, before you get 'tired'");
					}
				
					case TFTeam_Blue:
					{
						TF2_SetPlayerPowerPlay(i, true);
						CPrintToChat(i, "{haunted}[{magenta}HideAndSeek{haunted}] {orange}You have to catch (kill) reds before round ends");
					}
				}
			}
		}
		ClearTimer(StartSearchTimer);
		ClearTimer(FreezeTimer);
		ClearTimer(HP);
		ClearTimer(HP1);
		ClearTimer(HP2);
		ClearTimer(HP3);
		ClearTimer(HP4);
		ClearTimer(HP5);
		ClearTimer(NoUber);
		StartSearchTimer = CreateTimer(30.0, StunReds, INVALID_HANDLE, TIMER_FLAG_NO_MAPCHANGE);
		FreezeTimer = CreateTimer(60.0, FreezeReds, INVALID_HANDLE, TIMER_FLAG_NO_MAPCHANGE);
		HP = CreateTimer(4.0, MuchHp, INVALID_HANDLE, TIMER_FLAG_NO_MAPCHANGE);
		HP1 = CreateTimer(9.0, MuchHp1, INVALID_HANDLE, TIMER_FLAG_NO_MAPCHANGE);
		HP2 = CreateTimer(14.0, MuchHp2, INVALID_HANDLE, TIMER_FLAG_NO_MAPCHANGE);
		HP3 = CreateTimer(19.0, MuchHp3, INVALID_HANDLE, TIMER_FLAG_NO_MAPCHANGE);
		HP4 = CreateTimer(24.0, MuchHp4, INVALID_HANDLE, TIMER_FLAG_NO_MAPCHANGE);
		HP5 = CreateTimer(29.0, MuchHp5, INVALID_HANDLE, TIMER_FLAG_NO_MAPCHANGE);
		NoUber = CreateTimer(30.0, NoUbers, INVALID_HANDLE, TIMER_REPEAT);
	}
}

public OnPluginStart()
{
	HookEvent("teamplay_round_win", RoundEnd);
	CreateDirectory("cfg/sourcemod/haseek", 3);
}

public OnMapStart()
{
	PrecacheSound("haseek/start.wav", true);
	
	AddFileToDownloadsTable("sound/haseek/start.wav");
}

public OnConfigsExecuted()
{
	if (g_bLateLoad)
	{
		for (new i = 1; i <= MaxClients; i++)
		{
			if (IsClientInGame(i))
			{
				SDKHook(i, SDKHook_OnTakeDamage, OnTakeDamage);
			}
		}
		g_bLateLoad = false;
	}
}

public OnClientPutInServer(client)
{
	SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
}

public Action:NoUbers(Handle:hTimer)
{
	NoUber = INVALID_HANDLE;
	for (new i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i))
		{
			switch (GetClientTeam(i))
			{
				case TFTeam_Red: 
				{
				TF2_SetPlayerUberLevel(i, 1);
				}
			}
		}
	}
}

public Action:MuchHp(Handle:hTimer)
{
	HP = INVALID_HANDLE;
	for (new i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i))
		{
			switch (GetClientTeam(i))
			{
				case TFTeam_Blue: 
				{
				SetEntityHealth(i, 500);
				TF2_SetPlayerPowerPlay(i, true);
				}
			}
		}
	}
}

public Action:MuchHp1(Handle:hTimer)
{
	HP1 = INVALID_HANDLE;
	for (new i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i))
		{
			switch (GetClientTeam(i))
			{
				case TFTeam_Blue: 
				{
				SetEntityHealth(i, 500);
				TF2_SetPlayerPowerPlay(i, true);
				}
			}
		}
	}
}


public Action:MuchHp2(Handle:hTimer)
{
	HP2 = INVALID_HANDLE;
	for (new i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i))
		{
			switch (GetClientTeam(i))
			{
				case TFTeam_Blue: 
				{
				SetEntityHealth(i, 500);
				TF2_SetPlayerPowerPlay(i, true);
				}
			}
		}
	}
}

public Action:MuchHp3(Handle:hTimer)
{
	HP3 = INVALID_HANDLE;
	for (new i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i))
		{
			switch (GetClientTeam(i))
			{
				case TFTeam_Blue: 
				{
				SetEntityHealth(i, 500);
				TF2_SetPlayerPowerPlay(i, true);
				}
			}
		}
	}
}

public Action:MuchHp4(Handle:hTimer)
{
	HP4 = INVALID_HANDLE;
	for (new i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i))
		{
			switch (GetClientTeam(i))
			{
				case TFTeam_Blue: 
				{
				SetEntityHealth(i, 500);
				TF2_SetPlayerPowerPlay(i, true);
				}
			}
		}
	}
}

public Action:MuchHp5(Handle:hTimer)
{
	HP5 = INVALID_HANDLE;
	for (new i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i))
		{
			switch (GetClientTeam(i))
			{
				case TFTeam_Blue: 
				{
				SetEntityHealth(i, 500);
				TF2_SetPlayerPowerPlay(i, true);
				}
			}
		}
	}
}

public Action:StunReds(Handle:hTimer)
{
	StartSearchTimer = INVALID_HANDLE;
	for (new i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i))
		{
			switch (GetClientTeam(i))
			{
				case TFTeam_Red: 
				{
				TF2_SetPlayerSpeed(i, Float:100);
				CPrintToChat(i, "{gray}[{orange}HideAndSeek{gray}] {red}You got stunned, your speed has been slowed");
				}
				
				case TFTeam_Blue: 
				{
				CPrintToChat(i, "{gray}[{orange}HideAndSeek{gray}] {cyan}Reds got stunned, their speed has been slowed");
				}
			}
		}
	}
}

public Action:FreezeReds(Handle:hTimer)
{
	FreezeTimer = INVALID_HANDLE;
	for (new i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i))
		{
			switch (GetClientTeam(i))
			{
				case TFTeam_Red: 
				{
				TF2_SetPlayerSpeed(i, Float:1);
				EmitSoundToClient(i, "haseek/start.wav");
				SetEntityHealth(i, 1);
				CPrintToChat(i, "{gray}[{orange}HideAndSeek{gray}] {red}You're tired, so..., you can't move");
				}
				
				case TFTeam_Blue:
				{
				CPrintToChat(i, "{red}[{gray}HideAndSeek{red}] {orange}Reds are tired, so..., they can't move");
				}
			}
		}
	}
}

public RoundEnd(Handle:hEvent, const String:strName[], bool:bBroadcast)
{
	ClearTimer(StartSearchTimer);
	ClearTimer(FreezeTimer);
	ClearTimer(HP);
	ClearTimer(HP1);
	ClearTimer(HP2);
	ClearTimer(HP3);
	ClearTimer(HP4);
	ClearTimer(HP5);
	ClearTimer(NoUber);
		
	g_bFallDamage = false;
}

public Action:OnTakeDamage(victim, &attacker, &inflictor, &Float:damage, &damagetype, &weapon, Float:damageForce[3], Float:damagePosition[3], damagecustom)
{
	if (g_bFallDamage && (damagetype & DMG_FALL))
	{
		damage = damage * 3.0;
		return Plugin_Changed;
	}
	return Plugin_Continue;
}

stock ClearTimer(&Handle:timer)
{
	if (timer != INVALID_HANDLE)
	{
		KillTimer(timer);
		timer = INVALID_HANDLE;
	}
}

//Stropy
