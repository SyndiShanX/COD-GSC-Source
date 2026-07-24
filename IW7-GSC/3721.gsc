/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3721.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = % shipcrib_bridge_hall_box_repair_idle_01;
  var_0._id_EBEA["angles"] = [195, 225, 255, 285, 315, 345];
  var_0._id_EBEA[195] = % shipcrib_bridge_hall_box_repair_l180_01;
  var_0._id_EBEA[225] = % shipcrib_bridge_hall_box_repair_l150_01;
  var_0._id_EBEA[255] = % shipcrib_bridge_hall_box_repair_l120_01;
  var_0._id_EBEA[285] = % shipcrib_bridge_hall_box_repair_l90_01;
  var_0._id_EBEA[315] = % shipcrib_bridge_hall_box_repair_l60_01;
  var_0._id_EBEA[345] = % shipcrib_bridge_hall_box_repair_l30_01;
  var_0._id_EBEA["lastanim"] = % shipcrib_bridge_hall_box_repair_l00_01;
  var_0._id_EBEA["trigger_radius"] = 128;
  scripts\sp\interaction::register_interaction("shipcrib_hall_box_repair_01", var_0);
}