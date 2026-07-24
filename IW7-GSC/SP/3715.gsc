/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3715.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = % shipcrib_chillwalll_idle_02;
  var_0._id_EBEA["angles"] = [15, 45, 75, 105, 285, 315, 345];
  var_0._id_EBEA[15] = [%shipcrib_chillwalll_l00_02];
  var_0._id_EBEA[45] = [%shipcrib_chillwalll_r30_02];
  var_0._id_EBEA[75] = [%shipcrib_chillwalll_r60_02];
  var_0._id_EBEA[105] = [%shipcrib_chillwalll_r90_02];
  var_0._id_EBEA[285] = [%shipcrib_chillwalll_l90_02];
  var_0._id_EBEA[315] = [%shipcrib_chillwalll_l60_02];
  var_0._id_EBEA[345] = [%shipcrib_chillwalll_l30_02];
  var_0._id_EBEA["lastanim"] = [%shipcrib_chillwalll_l00_02];
  var_0._id_EBEA["trigger_radius"] = 128;
  scripts\sp\interaction::register_interaction("shipcrib_chillwall_2", var_0);
}