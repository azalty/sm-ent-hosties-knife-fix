#include <sourcemod>
#include <sdktools>

public Plugin myinfo = 
{
	name = "ENT_Hosties knife fix",
	author = "azalty",
	description = "Fixes a bug in ENT_Hosties that causes players to have 2 knives at spawn, breaking the player's inventory",
	version = "1.0.0",
	url = "github.com/azalty"
}

public void OnPluginStart()
{
	HookEvent("player_spawn", OnPlayerSpawn);
}

void OnPlayerSpawn(Handle event, const char[] name, bool dontBroadcast)
{
	// Hook the next frame to let other plugins do their thing if they need to.
	RequestFrame(OnPostSpawn, GetEventInt(event, "userid"));
}

void OnPostSpawn(any data)
{
	int client = GetClientOfUserId(data);
	if (!client || !IsClientInGame(client) || !IsPlayerAlive(client))
		return;
	
	char classname[32];
	int wepIdx;
	bool knife_removed;
	bool taser_removed;
	while ((wepIdx = GetPlayerWeaponSlot(client, 2)) != -1) // Get the top weapon in the knife slot. It will always be knives first, then potentially a taser.
	{
		GetEdictClassname(wepIdx, classname, sizeof(classname));
		if (!StrEqual(classname, "weapon_knife"))
			taser_removed = true; // We remove the taser because giving a knife when a player only has a taser bugs everything. Always give knife THEN taser!
		
		RemovePlayerItem(client, wepIdx);
		RemoveEntity(wepIdx);
		knife_removed = true;
	}
	
	if (knife_removed)
		GivePlayerItem(client, "weapon_knife");
	if (taser_removed)
		GivePlayerItem(client, "weapon_taser");
}