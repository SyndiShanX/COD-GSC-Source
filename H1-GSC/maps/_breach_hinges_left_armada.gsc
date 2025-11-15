/***********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_breach_hinges_left_armada.gsc
***********************************************/

#using_animtree("generic_human");

main() {
  level.door_objmodel = "com_door_breach_left_obj";
  precachemodel(level.door_objmodel);
  level.scr_anim["generic"]["shotgunhinges_breach_left_stack_start_01"] = % breach_sh_breacherl1_idle;
  level.scr_anim["generic"]["shotgunhinges_breach_left_stack_start_02"] = % breach_sh_stackr1_idle;
  level.scr_anim["generic"]["shotgunhinges_breach_left_stack_idle_01"][0] = % breach_sh_breacherl1_idle;
  level.scr_anim["generic"]["shotgunhinges_breach_left_stack_idle_02"][0] = % breach_sh_stackr1_idle;
  level.scr_anim["generic"]["shotgunhinges_breach_left_stack_breach_01"] = % h1_armada_03_shotgunhinges_soldiera;
  level.scr_anim["generic"]["shotgunhinges_breach_left_stack_breach_02"] = % h1_armada_03_shotgunhinges_soldierb;
  maps\_anim::addnotetrack_customfunction("generic", "custom_audio_fire", ::custom_audio_fire, "shotgunhinges_breach_left_stack_breach_01");
}

custom_audio_fire(var_0) {
  var_0 thread maps\_utility::play_sound_on_entity("armada_doorbreach_scripted_gun");
}