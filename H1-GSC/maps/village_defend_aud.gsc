/***************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\village_defend_aud.gsc
***************************************/

main() {
  config_system();
  init_snd_flags();
  init_globals();
  launch_threads();
  launch_loops();
  thread launch_line_emitters();
  create_level_envelop_arrays();
  precache_presets();
  register_snd_messages();
  thread intro_start();
}

config_system() {
  soundscripts\_audio::set_stringtable_mapname("shg");
  soundscripts\_snd_filters::snd_set_occlusion("med_occlusion");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_village_defend_global");
  soundsettraceflags("emitters", "solid", "glass");
}

init_snd_flags() {}

init_globals() {
  level.override_aud_mi17_dist_treshold = 20000;
}

launch_threads() {
  thread external_ambiance_update();
}

launch_loops() {}

launch_line_emitters() {
  wait 0.1;
}

create_level_envelop_arrays() {}

precache_presets() {}

register_snd_messages() {
  soundscripts\_snd::snd_register_message("snd_zone_handler", ::zone_handler);
  soundscripts\_snd::snd_register_message("aud_start_southern_hill_checkpoint", ::aud_start_southern_hill_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_minigun_fallback_checkpoint", ::aud_start_minigun_fallback_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_minigun_checkpoint", ::aud_start_minigun_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_helidrop_checkpoint", ::aud_start_helidrop_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_clackers_checkpoint", ::aud_start_clackers_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_field_fallback_checkpoint", ::aud_start_field_fallback_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_javelin_checkpoint", ::aud_start_javelin_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_final_battle_checkpoint", ::aud_start_final_battle_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_seaknight_checkpoint", ::aud_start_seaknight_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_default_checkpoint", ::aud_start_default_checkpoint);
  soundscripts\_snd::snd_register_message("start_southern_hill_ambush_mix", ::start_southern_hill_ambush_mix);
  soundscripts\_snd::snd_register_message("start_ambush_smoke_screen_mix", ::start_ambush_smoke_screen_mix);
  soundscripts\_snd::snd_register_message("aud_start_mortar_mix", ::aud_start_mortar_mix);
  soundscripts\_snd::snd_register_message("aud_start_minigun_mix", ::aud_start_minigun_mix);
  soundscripts\_snd::snd_register_message("start_helidrop_mix", ::start_helidrop_mix);
  soundscripts\_snd::snd_register_message("start_clacker_mix", ::start_clacker_mix);
  soundscripts\_snd::snd_register_message("start_fall_back_to_barn_mix", ::start_fall_back_to_barn_mix);
  soundscripts\_snd::snd_register_message("aud_open_door_meeting", ::aud_open_door_meeting);
  soundscripts\_snd::snd_register_message("start_get_to_lz_mix", ::start_get_to_lz_mix);
  soundscripts\_snd::snd_register_message("start_inside_seaknight_mix", ::start_inside_seaknight_mix);
}

zone_handler(var_0, var_1) {
  var_2 = "";
  var_3 = "";

  if(getsubstr(var_0, 0, 6) == "enter_")
    var_2 = var_1;
  else if(getsubstr(var_0, 0, 5) == "exit_")
    var_3 = var_1;
}

music_handler(var_0, var_1) {}

aud_start_default_checkpoint(var_0) {
  start_ambience_0();
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_start_southern_hill_checkpoint(var_0) {
  start_ambience_3();
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_start_minigun_fallback_checkpoint(var_0) {
  start_ambush_smoke_screen_mix();
  start_ambience_4();
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_start_minigun_checkpoint(var_0) {
  aud_start_minigun_mix();
  start_ambience_4();
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_start_helidrop_checkpoint(var_0) {
  start_ambience_5();
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_start_clackers_checkpoint(var_0) {
  start_clacker_mix();
  start_ambience_5();
  soundscripts\_audio_zone_manager::azm_start_zone("interior_stone");
}

aud_start_field_fallback_checkpoint(var_0) {
  start_fall_back_to_barn_mix();
  start_ambience_5();
  soundscripts\_audio_zone_manager::azm_start_zone("interior_stone");
}

aud_start_javelin_checkpoint(var_0) {
  start_fall_back_to_barn_mix();
  start_ambience_5();
  soundscripts\_audio_zone_manager::azm_start_zone("javelin_barn");
}

aud_start_final_battle_checkpoint(var_0) {
  start_fall_back_to_barn_mix();
  start_ambience_5();
  soundscripts\_audio_zone_manager::azm_start_zone("javelin_barn");
}

aud_start_seaknight_checkpoint(var_0) {
  start_get_to_lz_mix();
  start_ambience_5();
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

intro_start() {
  common_scripts\utility::flag_wait("introscreen_activate");
  soundscripts\_audio_mix_manager::mm_add_submix("village_defend_intro_mute");
  intro_check_end();
}

intro_check_end() {
  common_scripts\utility::flag_wait("introscreen_remove_submix");
  soundscripts\_audio_mix_manager::mm_clear_submix("village_defend_intro_mute", 1);
}

start_ambience_0() {
  set_all_ambiences("ambient_village_defend_ext0", "exterior0");
}

start_ambience_3() {
  set_all_ambiences("ambient_village_defend_ext3", "exterior3");
}

start_ambience_4() {
  set_all_ambiences("ambient_village_defend_ext4", "exterior4");
}

start_ambience_5() {
  set_all_ambiences("ambient_village_defend_ext5", "exterior5");
}

set_all_ambiences(var_0, var_1) {
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("exterior", var_0, 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_dynamic_ambience("exterior", var_1, 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("interior_wood_open", var_0, 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_dynamic_ambience("interior_wood_open", var_1, 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("trainstation_attic", var_0, 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_dynamic_ambience("trainstation_attic", var_1, 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("bell_tower", var_0, 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_dynamic_ambience("bell_tower", var_1, 0.8);
}

start_southern_hill_ambush_mix() {
  soundscripts\_audio_mix_manager::mm_add_submix("southern_hill_ambush_mix");
}

start_ambush_smoke_screen_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("southern_hill_ambush_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("ambush_smoke_screen_mix");
}

aud_start_mortar_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("ambush_smoke_screen_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("mortar_mix");
}

aud_start_minigun_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mortar_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("minigun_mix");
}

start_helidrop_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("minigun_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("helidrop_mix");
}

start_clacker_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("helidrop_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("clacker_mix");
}

start_fall_back_to_barn_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("clacker_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("fall_back_to_barn_mix");
}

start_inside_seaknight_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("get_to_lz_mix");
  soundscripts\_audio_zone_manager::azm_start_zone("inside_seaknight");
}

start_get_to_lz_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("fall_back_to_barn_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("get_to_lz_mix");
}

aud_open_door_meeting() {
  if(isdefined(level.aud.javelin_barn_door_open_trigger)) {
    wait 1.5;
    common_scripts\utility::array_thread(level.aud.javelin_barn_door_open_trigger, common_scripts\utility::trigger_on);
  }

  var_0 = getent("javelin_barn_transition_emitter_01", "targetname");
  var_0 thread common_scripts\utility::play_loop_sound_on_entity("emt_village_defend_ambient_transition");
}

external_ambiance_update() {
  level waittill("southern_hill_action_started");
  start_ambience_4();
  level waittill("objective_price_orders_minigun");
  start_ambience_5();
}

disable_azm_trigger_before_javelin_barn_door_open() {
  level.aud.javelin_barn_door_open_trigger = getentarray("flag_before_javelin_barn_door_open", "script_noteworthy");
  common_scripts\utility::array_thread(level.aud.javelin_barn_door_open_trigger, common_scripts\utility::trigger_off);
}