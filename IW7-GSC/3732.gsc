/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3732.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["idle"] = [%shipcrib_stand_stationary_talk_idle_03, %shipcrib_stand_idle03_vig_01, %shipcrib_stand_idle03_vig_02, %shipcrib_stand_idle03_vig_03, %shipcrib_stand_idle03_vig_04];
  var_0._id_EBEA["angles"] = [45, 75, 105, 135, 165, 195, 225, 255, 285];
  var_0._id_EBEA[45] = [%shipcrib_lounge_newsreel_r30_02];
  var_0._id_EBEA[75] = [%shipcrib_lounge_newsreel_r60_02];
  var_0._id_EBEA[105] = [%shipcrib_lounge_newsreel_r90_02];
  var_0._id_EBEA[135] = [%shipcrib_lounge_newsreel_r120_02];
  var_0._id_EBEA[165] = [%shipcrib_lounge_newsreel_r150_02];
  var_0._id_EBEA[195] = [%shipcrib_lounge_newsreel_r150_02];
  var_0._id_EBEA[225] = [%shipcrib_lounge_newsreel_l150_02];
  var_0._id_EBEA[255] = [%shipcrib_lounge_newsreel_l120_02];
  var_0._id_EBEA[285] = [%shipcrib_lounge_newsreel_l90_02];
  var_0._id_EBEA[285] = [%shipcrib_lounge_newsreel_l60_02];
  var_0._id_EBEA["lastanim"] = [%shipcrib_lounge_newsreel_l30_02];
  var_0._id_EBEA["trigger_radius"] = 164;
  scripts\sp\interaction::register_interaction("shipcrib_newsreel_reaction2", var_0);
}