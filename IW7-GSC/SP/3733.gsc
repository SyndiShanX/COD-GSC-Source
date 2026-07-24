/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3733.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = [%shipcrib_stand_stationary_talk_idle_04, %shipcrib_stand_idle04_vig_01, %shipcrib_stand_idle04_vig_02, %shipcrib_stand_idle04_vig_03, %shipcrib_stand_idle04_vig_04, %shipcrib_stand_idle04_vig_05];
  var_0._id_EBEA["angles"] = [45, 75, 105, 135, 165, 195, 225, 255, 285];
  var_0._id_EBEA[45] = [%shipcrib_lounge_newsreel_r30_03];
  var_0._id_EBEA[75] = [%shipcrib_lounge_newsreel_r60_03];
  var_0._id_EBEA[105] = [%shipcrib_lounge_newsreel_r90_03];
  var_0._id_EBEA[135] = [%shipcrib_lounge_newsreel_r120_03];
  var_0._id_EBEA[165] = [%shipcrib_lounge_newsreel_r150_03];
  var_0._id_EBEA[195] = [%shipcrib_lounge_newsreel_r150_03];
  var_0._id_EBEA[225] = [%shipcrib_lounge_newsreel_l150_03];
  var_0._id_EBEA[255] = [%shipcrib_lounge_newsreel_l120_03];
  var_0._id_EBEA[285] = [%shipcrib_lounge_newsreel_l90_03];
  var_0._id_EBEA[285] = [%shipcrib_lounge_newsreel_l60_03];
  var_0._id_EBEA["lastanim"] = [%shipcrib_lounge_newsreel_l30_03];
  var_0._id_EBEA["trigger_radius"] = 164;
  scripts\sp\interaction::register_interaction("shipcrib_newsreel_reaction3", var_0);
}