/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3778.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 0;
  var_0._id_EBEA["idle"] = [%shipcrib_stand_stationary_talk_idle_03_xo, %shipcrib_stand_idle03_vig_01_xo, %shipcrib_stand_idle03_vig_02_xo, %shipcrib_stand_idle03_vig_03_xo, %shipcrib_stand_idle03_vig_04_xo, %shipcrib_stand_idle03_vig_large_xo];
  var_0._id_EBEA["angles"] = [180, 270];
  var_0._id_EBEA[180] = [%shipcrib_stand_idle03_letsgo_left_02];
  var_0._id_EBEA[270] = [%shipcrib_stand_idle03_letsgo_right_02];
  var_0._id_EBEA["lastanim"] = [%shipcrib_stand_idle03_letsgo_right_02];
  var_0._id_EBEA["trigger_radius"] = 164;
  scripts\sp\interaction::register_interaction("stand_idle_3_back_reaction_xo", var_0);
}