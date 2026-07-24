/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3674.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = % sh4_2_10b_arm_hall_jack_idle;
  var_0._id_EBEA["interaction_blend_parent"] = % shipcrib_titan;
  var_0._id_EBEA["fwd_anim"] = % sh4_2_10b_arm_hall_rs_jack_forward_01;
  var_0._id_EBEA["right_anim"] = % sh4_2_10b_arm_hall_rs_jack_right_01;
  var_0._id_EBEA["left_anim"] = % sh4_2_10b_arm_hall_rs_jack_left_01;
  var_0._id_EBEA["back_right_anim"] = % sh4_2_10b_arm_hall_rs_jack_rightback_01;
  var_0._id_EBEA["back_left_anim"] = % sh4_2_10b_arm_hall_rs_jack_leftback_01;
  var_0._id_EBEA["trigger_radius"] = 164;
  var_0._id_22E1 = "noclip";
  scripts\sp\interaction::register_interaction("hallway_jack_blended_react", var_0);
}