/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\factions\faction_progression.gsc
***********************************************/

faction_progression_init() {}

give_player_faction(var_0) {
  if(isDefined(var_0))
    self setplayerdata("_encstr_850703B7D9", "_encstr_8AA214B2256D10B35A53C1E3CF620629373EF968CBDC", "_encstr_87220D7F572FAB9918887FB318B04D", var_0);

  var_1 = self getplayerdata("_encstr_850703B7D9", "_encstr_8AA214B2256D10B35A53C1E3CF620629373EF968CBDC", "_encstr_87220D7F572FAB9918887FB318B04D");
  self.faction = var_1;
}

debug_give_faction(var_0) {
  give_player_faction(var_0);
}