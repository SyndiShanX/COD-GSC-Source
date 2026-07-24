/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3747.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = % shipcrib_standing_console_idle_01;
  var_0._id_EBEA["angles"] = [15, 45, 75, 105, 135, 165, 195, 225, 255, 285, 315, 345];
  var_0._id_EBEA[15] = % shipcrib_standing_console_l00_02;
  var_0._id_EBEA[45] = % shipcrib_standing_console_r30_02;
  var_0._id_EBEA[75] = % shipcrib_standing_console_r60_02;
  var_0._id_EBEA[105] = % shipcrib_standing_console_r90_02;
  var_0._id_EBEA[135] = % shipcrib_standing_console_r120_02;
  var_0._id_EBEA[165] = % shipcrib_standing_console_r150_02;
  var_0._id_EBEA[195] = % shipcrib_standing_console_l180_02;
  var_0._id_EBEA[225] = % shipcrib_standing_console_l150_02;
  var_0._id_EBEA[255] = % shipcrib_standing_console_l120_02;
  var_0._id_EBEA[285] = % shipcrib_standing_console_l90_02;
  var_0._id_EBEA[315] = % shipcrib_standing_console_l60_02;
  var_0._id_EBEA[345] = % shipcrib_standing_console_l30_02;
  var_0._id_EBEA["lastanim"] = % shipcrib_standing_console_l00_02;
  var_0._id_EBEA["trigger_radius"] = 164;
  scripts\sp\interaction::register_interaction("shipcrib_standing_console_react_2", var_0);
}