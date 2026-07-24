/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3729.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = % shipcrib_lounge_sit_idle_03;
  var_0._id_EBEA["angles"] = [15, 45, 75, 105, 135, 165, 195, 225, 255, 285, 315];
  var_0._id_EBEA[15] = [%shipcrib_lounge_sit_l00_03, 0.75, "shipcrib_us1_captain"];
  var_0._id_EBEA[45] = [%shipcrib_lounge_sit_r30_03, 0.75, "shipcrib_us1_captain"];
  var_0._id_EBEA[75] = [%shipcrib_lounge_sit_r60_03, 0.75, "shipcrib_us1_captain"];
  var_0._id_EBEA[105] = [%shipcrib_lounge_sit_r90_03, 0.75, "shipcrib_us1_captain"];
  var_0._id_EBEA[135] = [%shipcrib_lounge_sit_r120_03, 0.75, "shipcrib_us1_captain"];
  var_0._id_EBEA[165] = [%shipcrib_lounge_sit_r150_03, 0.75, "shipcrib_us1_captain"];
  var_0._id_EBEA[195] = [%shipcrib_lounge_sit_l180_03, 0.75, "shipcrib_us1_captain"];
  var_0._id_EBEA[225] = [%shipcrib_lounge_sit_l150_03, 0.75, "shipcrib_us1_captain"];
  var_0._id_EBEA[255] = [%shipcrib_lounge_sit_l120_03, 0.75, "shipcrib_us1_captain"];
  var_0._id_EBEA[285] = [%shipcrib_lounge_sit_l90_03, 0.75, "shipcrib_us1_captain"];
  var_0._id_EBEA[315] = [%shipcrib_lounge_sit_l60_03, 0.75, "shipcrib_us1_captain"];
  var_0._id_EBEA[345] = [%shipcrib_lounge_sit_l30_03, 0.75, "shipcrib_us1_captain"];
  var_0._id_EBEA["lastanim"] = [%shipcrib_lounge_sit_l00_03, 0.75, "shipcrib_us1_captain"];
  var_0._id_EBEA["trigger_radius"] = 164;
  scripts\sp\interaction::register_interaction("shipcrib_lounge_sit_03", var_0);
}