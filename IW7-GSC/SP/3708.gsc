/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3708.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = % sh_pri_7_17_rs_pu2_eng_idle;
  var_0._id_EBEA["interaction_blend_parent"] = % shipcrib_prisoner;
  var_0._id_EBEA["fwd_anim"] = % sh_pri_7_17_rs_pu2_eng_forward;
  var_0._id_EBEA["right_anim"] = % sh_pri_7_17_rs_pu2_eng_right;
  var_0._id_EBEA["left_anim"] = % sh_pri_7_17_rs_pu2_eng_left;
  var_0._id_EBEA["back_right_anim"] = % sh_pri_7_17_rs_pu2_eng_rightback;
  var_0._id_EBEA["back_left_anim"] = % sh_pri_7_17_rs_pu2_eng_leftback;
  var_0._id_EBEA["trigger_radius"] = 164;
  var_0._id_22E1 = "noclip";
  scripts\sp\interaction::register_interaction("sh_pri_mac_blended_react", var_0);
}