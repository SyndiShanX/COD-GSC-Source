/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_breach_hinges_left.gsc
********************************************************/

#using_animtree("generic_human");
main() {
  level.scr_anim["generic"]["shotgunhinges_breach_left_stack_start_01"] = % breach_sh_breacherL1_idle;
  level.scr_anim["generic"]["shotgunhinges_breach_left_stack_start_02"] = % breach_sh_stackR1_idle;

  level.scr_anim["generic"]["shotgunhinges_breach_left_stack_idle_01"][0] = % breach_sh_breacherL1_idle;
  level.scr_anim["generic"]["shotgunhinges_breach_left_stack_idle_02"][0] = % breach_sh_stackR1_idle;

  level.scr_anim["generic"]["shotgunhinges_breach_left_stack_breach_01"] = % breach_sh_breacherL1_enter;
  level.scr_anim["generic"]["shotgunhinges_breach_left_stack_breach_02"] = % breach_sh_stackR1_enter;
}