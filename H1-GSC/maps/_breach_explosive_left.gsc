/*******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_breach_explosive_left.gsc
*******************************************/

#using_animtree("generic_human");

main() {
  level.maxdetpackdamage = 100;
  level.mindetpackdamage = 50;
  level.detpackstunradius = 250;
  level.door_objmodel = "com_door_breach_left_obj";
  level.stunnedanimnumber = 1;
  precachemodel(level.door_objmodel);
  precachemodel("weapon_detcord");
  level.scr_anim["generic"]["detcord_stack_left_start_01"] = % breach_stackl_approach;
  level.scr_anim["generic"]["detcord_stack_left_start_02"] = % breach_explosive_approach;
  level.scr_anim["generic"]["detcord_stack_left_start_no_approach_01"] = % explosivebreach_v1_stackl_idle;
  level.scr_anim["generic"]["detcord_stack_left_start_no_approach_02"] = % explosivebreach_v1_detcord_idle;
  level.scr_anim["generic"]["detcord_stack_leftidle_01"][0] = % explosivebreach_v1_stackl_idle;
  level.scr_anim["generic"]["detcord_stack_leftidle_02"][0] = % explosivebreach_v1_detcord_idle;
  level.scr_anim["generic"]["detcord_stack_leftbreach_01"] = % explosivebreach_v1_stackl;
  level.scr_anim["generic"]["detcord_stack_leftbreach_02"] = % explosivebreach_v1_detcord;
  level.scr_anim["generic"]["exposed_flashbang_v1"] = % exposed_flashbang_v1;
  level.scr_anim["generic"]["exposed_flashbang_v2"] = % exposed_flashbang_v2;

  if(isdefined(level.override_breach_explosive_left_audio)) {
    maps\_anim::addnotetrack_customfunction("generic", "audio_start_mix", ::audio_start_mix, "detcord_stack_leftbreach_01");
    maps\_anim::addnotetrack_customfunction("generic", "audio_stop_mix", ::audio_stop_mix, "detcord_stack_leftbreach_01");
    maps\_anim::addnotetrack_customfunction("generic", "audio_custom_fire", ::audio_custom_fire, "detcord_stack_leftbreach_01");
    maps\_anim::addnotetrack_customfunction("generic", "audio_custom_fire", ::audio_custom_fire, "detcord_stack_leftbreach_02");
  }

  if(isdefined(level.breach_play_door_animation) && level.breach_play_door_animation)
    setup_door_animation();
}

audio_custom_fire(var_0) {
  if(isdefined(var_0.breachdonotfire)) {
    return;
  }
  var_0 thread maps\_utility::play_sound_on_entity("sp_breach_explosive_left_fire_npc");
}

audio_start_mix(var_0) {
  soundscripts\_audio_mix_manager::mm_add_submix("explosive_breach_left_mix");
}

audio_stop_mix(var_0) {
  soundscripts\_audio_mix_manager::mm_clear_submix("explosive_breach_left_mix");
}

#using_animtree("door");

setup_door_animation() {
  level.scr_animtree["breach_door"] = #animtree;
  level.scr_anim["breach_door"]["explosive_breach_left_door"] = % explosivebreach_v1_door;
}