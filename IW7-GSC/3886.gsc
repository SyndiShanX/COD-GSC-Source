/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3886.gsc
************************/

main() {
  func_EE1D();
  func_91D0();
}

func_EE1D() {
  level.var_EC87["killcounter"] = #animtree;
  level.var_EC85["killcounter"]["update"] = % vr_killcounter_numbers_update;
  level.var_EC87["vr_unfold_left_rig"] = #animtree;
  level.var_EC8C["vr_unfold_left_rig"] = "vr_unfold_left_rig";
  level.var_EC85["vr_unfold_left_rig"]["vr_unfold"] = % vr_unfold_left;
  level.var_EC87["vr_unfold_right_rig"] = #animtree;
  level.var_EC8C["vr_unfold_right_rig"] = "vr_unfold_right_rig";
  level.var_EC85["vr_unfold_right_rig"]["vr_unfold"] = % vr_unfold_right;
  level.var_EC87["ring0"] = #animtree;
  level.var_EC87["ring1"] = #animtree;
  level.var_EC87["ring2"] = #animtree;
  level.var_EC87["ring3"] = #animtree;
  level.var_EC87["ring4"] = #animtree;
  level.var_EC87["ring5"] = #animtree;
  level.var_EC85["ring0"]["vr_intro_part1"] = % vr_intro_part1;
  level.var_EC85["ring1"]["vr_intro_part1"] = % vr_intro_part1;
  level.var_EC85["ring2"]["vr_intro_part1"] = % vr_intro_part1;
  level.var_EC85["ring3"]["vr_intro_part1"] = % vr_intro_part1;
  level.var_EC85["ring4"]["vr_intro_part1"] = % vr_intro_part1;
  level.var_EC85["ring5"]["vr_intro_part1"] = % vr_intro_part1;
  scripts\sp\anim::func_17FC("ring0", "show_geo", "vr_ring0_intro_show_geo", "vr_intro_part1");
  scripts\sp\anim::func_17FC("ring1", "show_geo", "vr_ring1_intro_show_geo", "vr_intro_part1");
  scripts\sp\anim::func_17FC("ring2", "show_geo", "vr_ring2_intro_show_geo", "vr_intro_part1");
  scripts\sp\anim::func_17FC("ring3", "show_geo", "vr_ring3_intro_show_geo", "vr_intro_part1");
  scripts\sp\anim::func_17FC("ring4", "show_geo", "vr_ring4_intro_show_geo", "vr_intro_part1");
  scripts\sp\anim::func_17FC("ring5", "show_geo", "vr_ring5_intro_show_geo", "vr_intro_part1");
}

func_91D0() {}