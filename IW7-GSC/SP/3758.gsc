/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3758.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = % shipcrib_stand_window_idle_01;
  var_0._id_EBEA["angles"] = [105, 135, 165, 195, 225, 255];
  var_0._id_EBEA[105] = % shipcrib_stand_window_r90_01;
  var_0._id_EBEA[135] = % shipcrib_stand_window_r120_01;
  var_0._id_EBEA[165] = % shipcrib_stand_window_r150_01;
  var_0._id_EBEA[195] = % shipcrib_stand_window_l180_01;
  var_0._id_EBEA[225] = % shipcrib_stand_window_l150_01;
  var_0._id_EBEA[255] = % shipcrib_stand_window_l120_01;
  var_0._id_EBEA["lastanim"] = % shipcrib_stand_window_l90_01;
  var_0._id_EBEA["trigger_radius"] = 128;
  scripts\sp\interaction::register_interaction("shipcrib_window_stand_pointleft_01", var_0);
}