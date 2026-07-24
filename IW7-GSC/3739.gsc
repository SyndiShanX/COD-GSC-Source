/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3739.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = % shipcrib_stand_stationary_talk_idle_01;
  var_0._id_EBEA["follow"] = % shipcrib_stand_stationary_talk_follow_01;
  var_0._id_EBEA["ring"] = % follow_ring;
  var_0._id_EBEA["trigger_radius"] = 0;
  var_0._id_EBEA["backseam"] = 1;
  var_0._id_EBEA["diff"] = % sh_pri_7_13_elev_xo_diff;
  var_0._id_EBEA["additive"] = % follow_additive;
  var_0._id_EBEA["angles"] = [15, 45, 75, 105, 135, 165, 195, 225, 255, 285, 315];
  var_0._id_EBEA[15] = % shipcrib_stand_stationary_talk_l00_01;
  var_0._id_EBEA[45] = % shipcrib_stand_stationary_talk_r30_01;
  var_0._id_EBEA[75] = % shipcrib_stand_stationary_talk_r60_01;
  var_0._id_EBEA[105] = % shipcrib_stand_stationary_talk_r90_01;
  var_0._id_EBEA[135] = % shipcrib_stand_stationary_talk_r120_01;
  var_0._id_EBEA[165] = % shipcrib_stand_stationary_talk_r150_01;
  var_0._id_EBEA[195] = % shipcrib_stand_stationary_talk_r150_01;
  var_0._id_EBEA[225] = % shipcrib_stand_stationary_talk_l150_01;
  var_0._id_EBEA[255] = % shipcrib_stand_stationary_talk_l120_01;
  var_0._id_EBEA[285] = % shipcrib_stand_stationary_talk_l90_01;
  var_0._id_EBEA[315] = % shipcrib_stand_stationary_talk_l60_01;
  var_0._id_EBEA["lastanim"] = % shipcrib_stand_stationary_talk_l30_01;
  scripts\sp\interaction::register_interaction("prisoner_leaveelevator_react", var_0);
}