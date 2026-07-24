/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3775.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 0;
  var_0._id_EBEA["idle"] = [%shipcrib_stand_stationary_talk_idle_02, %shipcrib_stand_idle02_vig_01, %shipcrib_stand_idle02_vig_02, %shipcrib_stand_idle02_vig_03, %shipcrib_stand_idle02_vig_04, %shipcrib_stand_idle02_vig_large];
  var_0._id_EBEA["angles"] = [75, 195, 325];
  var_0._id_EBEA[75] = [%shipcrib_stand_idle02_letsgo_right_01];
  var_0._id_EBEA[195] = [%shipcrib_stand_idle02_letsgo_right_03];
  var_0._id_EBEA[325] = [%shipcrib_stand_idle02_letsgo_right_01];
  var_0._id_EBEA["lastanim"] = [%shipcrib_stand_idle02_letsgo_right_03];
  var_0._id_EBEA["trigger_radius"] = 164;
  scripts\sp\interaction::register_interaction("stand_idle_2_right_reaction", var_0);
}