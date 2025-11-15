/*****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\launchfacility_b_aud.gsc
*****************************************/

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
  soundscripts\_audio_mix_manager::mm_add_submix("mix_launchfacility_b_global");
}

init_snd_flags() {}

init_globals() {}

launch_threads() {}

launch_loops() {}

launch_line_emitters() {
  wait 0.1;
}

create_level_envelop_arrays() {}

precache_presets() {}

register_snd_messages() {
  soundscripts\_snd::snd_register_message("start_default_checkpoint", ::start_default_checkpoint);
  soundscripts\_snd::snd_register_message("start_warehouse_checkpoint", ::start_warehouse_checkpoint);
  soundscripts\_snd::snd_register_message("start_launchtubes_checkpoint", ::start_launchtubes_checkpoint);
  soundscripts\_snd::snd_register_message("start_vaultdoors_checkpoint", ::start_vaultdoors_checkpoint);
  soundscripts\_snd::snd_register_message("start_controlroom_checkpoint", ::start_controlroom_checkpoint);
  soundscripts\_snd::snd_register_message("start_escape_checkpoint", ::start_escape_checkpoint);
  soundscripts\_snd::snd_register_message("start_elevator_checkpoint", ::start_elevator_checkpoint);
  soundscripts\_snd::snd_register_message("start_hallway_combat_mix", ::hallway_fighting_mix);
  soundscripts\_snd::snd_register_message("start_missile_silo_mix", ::missile_silo_mix);
  soundscripts\_snd::snd_register_message("start_vault_doors_mix", ::vault_doors_mix);
  soundscripts\_snd::snd_register_message("start_control_room_mix", ::control_room_mix);
  soundscripts\_snd::snd_register_message("start_code_input_mix", ::code_input_mix);
  soundscripts\_snd::snd_register_message("start_escape_facility_mix", ::escape_facility_mix);
  soundscripts\_snd::snd_register_message("start_missile_stopped_mix", ::missile_stopped_mix);
  soundscripts\_snd::snd_register_message("mission_failed", ::mission_failed);
}

zone_handler(var_0, var_1) {}

music_handler(var_0, var_1) {}

start_default_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("silo");
}

start_warehouse_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("interior_stone");
}

start_launchtubes_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("interior_stone");
}

start_vaultdoors_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("interior_stone");
}

start_controlroom_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("interior_stone");
}

start_escape_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("computer_room");
}

start_elevator_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("medium_room");
}

hallway_fighting_mix() {
  soundscripts\_audio_mix_manager::mm_add_submix("hallway_fighting_mix");
}

missile_silo_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("hallway_fighting_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("missile_silo_mix");
}

vault_doors_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("missile_silo_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("vault_doors_mix");
}

control_room_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("vault_doors_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("control_room_mix");
}

code_input_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("control_room_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("code_input_mix");
}

missile_stopped_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("code_input_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("missile_stopped_mix");
}

escape_facility_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("missile_stopped_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("escape_facility_mix");
}

intro_start() {
  common_scripts\utility::flag_wait("introscreen_activate");
  soundscripts\_audio_mix_manager::mm_add_submix("launch_fb_intro_mute");
  intro_check_end();
}

intro_check_end() {
  soundscripts\_audio_mix_manager::mm_clear_submix("launch_fb_intro_mute");
}

mission_failed() {
  soundscripts\_audio_mix_manager::mm_add_submix("failure_mix");
}