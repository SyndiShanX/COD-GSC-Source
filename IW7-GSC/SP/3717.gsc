/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3717.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = % shipcrib_crouch_point_idle_01;
  var_0._id_EBEA["angles"] = [105, 135, 160, 200, 220, 250];
  var_0._id_EBEA[105] = [%shipcrib_crouch_point_reaction_r90_02, 0.0, "shipcrib_plr_boattotitan", 0.1, "shipcrib_us1_thatwaysir", 0.25, "shipcrib_plr_thanks"];
  var_0._id_EBEA[135] = [%shipcrib_crouch_point_reaction_r120_02, 0.0, "shipcrib_plr_boattotitan", 0.1, "shipcrib_us1_thatwaysir", 0.25, "shipcrib_plr_thanks"];
  var_0._id_EBEA[160] = [%shipcrib_crouch_point_reaction_r150_02, 0.0, "shipcrib_plr_boattotitan", 0.1, "shipcrib_us1_thatwaysir", 0.25, "shipcrib_plr_thanks"];
  var_0._id_EBEA[200] = [%shipcrib_crouch_point_reaction_r180_02, 0.0, "shipcrib_plr_boattotitan", 0.1, "shipcrib_us1_thatwaysir", 0.25, "shipcrib_plr_thanks"];
  var_0._id_EBEA[220] = [%shipcrib_crouch_point_reaction_l150_02, 0.0, "shipcrib_plr_boattotitan", 0.1, "shipcrib_us1_thatwaysir", 0.25, "shipcrib_plr_thanks"];
  var_0._id_EBEA[250] = [%shipcrib_crouch_point_reaction_l120_02, 0.0, "shipcrib_plr_boattotitan", 0.1, "shipcrib_us1_thatwaysir", 0.25, "shipcrib_plr_thanks"];
  var_0._id_EBEA["lastanim"] = [%shipcrib_crouch_point_reaction_l90_02, 0.0, "shipcrib_plr_boattotitan", 0.1, "shipcrib_us1_thatwaysir", 0.25, "shipcrib_plr_thanks"];
  var_0._id_EBEA["trigger_radius"] = 128;
  scripts\sp\interaction::register_interaction("shipcrib_crouch_point_right_01", var_0);
}