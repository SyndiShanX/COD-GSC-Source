/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\factions\faction_progression.gsc
*******************************************************/

function faction_progression_init() {}

function give_player_faction(var_0) {
  if(isDefined(var_0)) {
    self setplayerdata("cp", "zombiePlayerLoadout", "faction_name", var_0);
  }

  var_1 = self getplayerdata("cp", "zombiePlayerLoadout", "faction_name");
  self.faction = var_1;
}

function debug_give_faction(var_0) {
  give_player_faction(var_0);
}