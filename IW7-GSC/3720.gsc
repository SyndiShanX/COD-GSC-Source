/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3720.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = % shipcrib_guard_reaction_idle_01;
  var_0._id_EBEA["angles"] = [45, 75, 105, 290, 320, 345];
  var_0._id_EBEA[45] = % shipcrib_guard_reaction_r30_01;
  var_0._id_EBEA[75] = % shipcrib_guard_reaction_r60_01;
  var_0._id_EBEA[105] = % shipcrib_guard_reaction_r90_01;
  var_0._id_EBEA[290] = % shipcrib_guard_reaction_l90_01;
  var_0._id_EBEA[320] = % shipcrib_guard_reaction_l60_01;
  var_0._id_EBEA[345] = % shipcrib_guard_reaction_l30_01;
  var_0._id_EBEA["lastanim"] = % shipcrib_guard_reaction_l00_01;
  var_0._id_EBEA["trigger_radius"] = 128;
  scripts\sp\interaction::register_interaction("shipcrib_guard_reaction_idle_01", var_0);
}