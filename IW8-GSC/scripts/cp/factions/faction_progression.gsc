/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\factions\faction_progression.gsc
*******************************************************/

function faction_progression_init() {}

function give_player_faction(var0) {
  if(isDefined(var0)) {
    self setplayerdata("cp", "zombiePlayerLoadout", "faction_name", var0);
  }

  var1 = self getplayerdata("cp", "zombiePlayerLoadout", "faction_name");
  self.faction = var1;
}

function debug_give_faction(var0) {
  give_player_faction(var0);
}