#define PA "Elpapuh"
#define PV "1.6"
#define PN "Hide and Seek [NPDU]" //NPDU = No plugins dependencies update
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

#pragma semicolon 1

#include <sourcemod>
#include <sdkhooks>
#include <tf2_stocks>
#include <tf2items>
#include <morecolors>
#include <smlib>
#include <tf2jail>

new Handle:StartSearchTimer = INVALID_HANDLE;
new Handle:FreezeReds = INVALID_HANDLE;

new bool:g_bLateLoad = false;
new bool:g_bFallDamage = false;

public OnPluginStart()
{
	HookEvent("teamplay_round_win", RoundEnd);
}

public OnMapStart()
{
	PrecacheSound("haseek/start.wav", true);
	PrecacheSound("haseek/die.wav", true);
	PrecacheSound("haseek/die2.wav", true);
	
	AddFileToDownloadsTable("sound/haseek/start.wav");
	AddFileToDownloadsTable("sound/haseek/die.wav");
	AddFileToDownloadsTable("sound/haseek/die2.wav");
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

public TF2Jail_OnLastRequestExecute(const String:Handler[])
{

	TF2Jail_ManageCells(OPEN);
	
	HookEvent("player_death", OnPlayerDie, EventHookMode_Post);

	if (StrEqual(Handler, "PlayHAS"))
	{
		ServerCommand("sm_freeze @blue 29");
		for (new i = 1; i <= MaxClients; i++)
		{
			if (IsClientInGame(i) && IsPlayerAlive(i))
			{
				switch (GetClientTeam(i))
				{
				
					case TFTeam_Red:
					{
						TF2Jail_StripToMelee(i);
						TF2_SetPlayerClass(i, TFClass_Scout);
						EmitSoundToClient(i, "haseek/start.wav");
					}
				
					case TFTeam_Blue:
					{
						TF2_SetPlayerPowerPlay(i, true);
					}
				}
			}
		}
		ClearTimer(StartSearchTimer);
		StartSearchTimer = CreateTimer(30.0, StunReds, INVALID_HANDLE, TIMER_FLAG_NO_MAPCHANGE);
	}
	
	CreateTimer(5.0, PowerPlay);
	CreateTimer(10.0, PowerPlays);
	CreateTimer(15.0, PowerPlayss);
	CreateTimer(20.0, PowerPlaysss);
	CreateTimer(23.0, PowerPlayssss);
}

public Action:PowerPlay(Handle timer)
{
	for (new i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i) == _:TFTeam_Blue)
		{
			TF2_SetPlayerPowerPlay(i, true);
		}
	}
}

public Action:PowerPlays(Handle timer)
{
	for (new i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i) == _:TFTeam_Blue)
		{
			TF2_SetPlayerPowerPlay(i, true);
		}
	}
}

public Action:PowerPlayss(Handle timer)
{
	for (new i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i) == _:TFTeam_Blue)
		{
			TF2_SetPlayerPowerPlay(i, true);
		}
	}
}

public Action:PowerPlaysss(Handle timer)
{
	for (new i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i) == _:TFTeam_Blue)
		{
			TF2_SetPlayerPowerPlay(i, true);
		}
	}
}

public Action:PowerPlayssss(Handle timer)
{
	for (new i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i) && GetClientTeam(i) == _:TFTeam_Blue)
		{
			TF2_SetPlayerPowerPlay(i, true);
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
				TF2_StunPlayer(i, 99999.0, 0.90, TF_STUNFLAG_SLOWDOWN, 0);
				TF2_SetPlayerPowerPlay(i, false);
				}
				
				case TFTeam_Blue: 
				{
				SetEntityHealth(i, 300);
				}
			}
		}
	}
	ClearTimer(FreezeReds);
	FreezeReds = CreateTimer(60.0, StartFreezeReds, INVALID_HANDLE, TIMER_FLAG_NO_MAPCHANGE);
}

public Action:StartFreezeReds(Handle:hTimer)
{
	FreezeReds = INVALID_HANDLE;
	for (new i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i))
		{
			switch (GetClientTeam(i))
			{
				case TFTeam_Red:
				{
					ServerCommand("sm_freeze @red -1");
				}
				
				case TFTeam_Blue:
				{
					TF2_SetPlayerPowerPlay(i, false);
				}
			}
		}
	}
}

public RoundEnd(Handle:hEvent, const String:strName[], bool:bBroadcast)
{
	ClearTimer(StartSearchTimer);
	ClearTimer(FreezeReds);
	ClearTimer(StartSearchTimer);
	
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

public Action OnPlayerDie(Handle event, const char[] name, bool dontBroadcast)
{	
	for (new i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i))
		{
			switch (GetClientTeam(i))
			{
				case TFTeam_Red:
				{
					EmitSoundToClient(i, "haseek/die.wav");
				}
				
				case TFTeam_Blue:
				{
					EmitSoundToClient(i, "haseek/die2.wav");
				}
			}
		}
	}	
}
