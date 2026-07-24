/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3689.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = % shipcrib_lounge_lean_idle_02;
  var_0._id_EBEA["angles"] = [45, 75, 105, 285, 315, 345];
  var_0._id_EBEA[45] = [%shipcrib_lounge_lean_r30_02];
  var_0._id_EBEA[75] = [%shipcrib_lounge_lean_r60_02];
  var_0._id_EBEA[105] = [%shipcrib_lounge_lean_r90_02];
  var_0._id_EBEA[285] = [%shipcrib_lounge_lean_l90_02];
  var_0._id_EBEA[315] = [%shipcrib_lounge_lean_l60_02];
  var_0._id_EBEA[345] = [%shipcrib_lounge_lean_l30_02];
  var_0._id_EBEA["lastanim"] = [%shipcrib_lounge_lean_l00_02];
  var_0._id_EBEA["trigger_radius"] = 128;
  scripts\sp\interaction::register_interaction("lounge_lean_2", var_0);
}