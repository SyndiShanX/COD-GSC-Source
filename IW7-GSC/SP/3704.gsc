/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3704.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = % sh6_6_ra_mission_rs_xo_forward;
  var_0._id_EBEA["interaction_blend_parent"] = % shipcrib_rogue;
  var_0._id_EBEA["fwd_anim"] = % sh6_6_ra_mission_rs_xo_forward;
  var_0._id_EBEA["right_anim"] = % sh6_6_ra_mission_rs_xo_right;
  var_0._id_EBEA["left_anim"] = % sh6_6_ra_mission_rs_xo_left;
  var_0._id_EBEA["back_right_anim"] = % sh6_6_ra_mission_rs_xo_backright;
  var_0._id_EBEA["back_left_anim"] = % sh6_6_ra_mission_rs_xo_backleft;
  var_0._id_EBEA["trigger_radius"] = 164;
  var_0._id_22E1 = "noclip";
  scripts\sp\interaction::register_interaction("salter_cic_ra_blended_react", var_0);
}