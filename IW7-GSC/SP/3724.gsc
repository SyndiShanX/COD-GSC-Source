/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3724.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["idle"] = % shipcrib_hangar_crate_idlea_01;
  var_0._id_EBEA["angles"] = [15, 45, 75, 105, 135, 165, 195, 225, 255, 285, 315, 345];
  var_0._id_EBEA[15] = % shipcrib_hangar_crate_salute_01_l00;
  var_0._id_EBEA[45] = % shipcrib_hangar_crate_salute_01_r30;
  var_0._id_EBEA[75] = % shipcrib_hangar_crate_salute_01_r60;
  var_0._id_EBEA[105] = % shipcrib_hangar_crate_salute_01_r90;
  var_0._id_EBEA[135] = % shipcrib_hangar_crate_salute_01_r120;
  var_0._id_EBEA[165] = % shipcrib_hangar_crate_salute_01_r150;
  var_0._id_EBEA[195] = % shipcrib_hangar_crate_salute_01_l180;
  var_0._id_EBEA[225] = % shipcrib_hangar_crate_salute_01_l150;
  var_0._id_EBEA[255] = % shipcrib_hangar_crate_salute_01_l120;
  var_0._id_EBEA[285] = % shipcrib_hangar_crate_salute_01_l90;
  var_0._id_EBEA[315] = % shipcrib_hangar_crate_salute_01_l60;
  var_0._id_EBEA[345] = % shipcrib_hangar_crate_salute_01_l30;
  var_0._id_EBEA["lastanim"] = % shipcrib_hangar_crate_salute_01_l00;
  var_0._id_EBEA["trigger_radius"] = 150;
  scripts\sp\interaction::register_interaction("shipcrib_hangar_crate_salute_01", var_0);
}