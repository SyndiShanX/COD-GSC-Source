/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3765.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 0;
  var_0._id_EBEA["idle"] = [%shipcrib_stand_stationary_talk_idle_01, %shipcrib_stand_idle01_vig_01, %shipcrib_stand_idle01_vig_02, %shipcrib_stand_idle01_vig_03, %shipcrib_stand_idle01_vig_04, %shipcrib_stand_idle01_vig_large];
  var_0._id_EBEA["angles"] = [180, 270];
  var_0._id_EBEA[180] = [%shipcrib_stand_idle01_letsgo_left_02];
  var_0._id_EBEA[270] = [%shipcrib_stand_idle01_letsgo_right_02];
  var_0._id_EBEA["lastanim"] = [%shipcrib_stand_idle01_letsgo_right_02];
  var_0._id_EBEA["trigger_radius"] = 164;
  scripts\sp\interaction::register_interaction("stand_idle_1_back_reaction", var_0);
}