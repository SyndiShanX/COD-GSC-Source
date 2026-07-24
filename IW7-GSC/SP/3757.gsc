/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3757.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = [%shipcrib_stand_stationary_talk_idle_04, %shipcrib_stand_idle04_vig_01, %shipcrib_stand_idle04_vig_02, %shipcrib_stand_idle04_vig_03, %shipcrib_stand_idle04_vig_04, %shipcrib_stand_idle04_vig_05];
  var_0._id_EBEA["follow"] = % shipcrib_stand_stationary_talk_follow_01;
  var_0._id_EBEA["ring"] = % follow_ring;
  var_0._id_EBEA["trigger_radius"] = 0;
  var_0._id_EBEA["backseam"] = 1;
  var_0._id_EBEA["diff"] = % sh4_4_ttn_deck2_xo_diff;
  var_0._id_EBEA["additive"] = % follow_additive;
  var_0._id_EBEA["angles"] = [15, 45, 75, 105, 135, 165, 195, 225, 255, 285, 315];
  var_0._id_EBEA[15] = % shipcrib_stand_stationary_talk_l00_04;
  var_0._id_EBEA[45] = % shipcrib_stand_stationary_talk_r30_04;
  var_0._id_EBEA[75] = % shipcrib_stand_stationary_talk_r60_04;
  var_0._id_EBEA[105] = % shipcrib_stand_stationary_talk_r90_04;
  var_0._id_EBEA[135] = % shipcrib_stand_stationary_talk_r120_04;
  var_0._id_EBEA[165] = % shipcrib_stand_stationary_talk_r150_04;
  var_0._id_EBEA[195] = % shipcrib_stand_stationary_talk_r150_04;
  var_0._id_EBEA[225] = % shipcrib_stand_stationary_talk_l150_04;
  var_0._id_EBEA[255] = % shipcrib_stand_stationary_talk_l120_04;
  var_0._id_EBEA[285] = % shipcrib_stand_stationary_talk_l90_04;
  var_0._id_EBEA[315] = % shipcrib_stand_stationary_talk_l60_04;
  var_0._id_EBEA["lastanim"] = % shipcrib_stand_stationary_talk_l30_04;
  scripts\sp\interaction::register_interaction("titan_returnelevator_react", var_0);
}