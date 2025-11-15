/*****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\launchfacility_a_aud.gsc
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
  thread flying_intro_start();
}

config_system() {
  soundscripts\_audio::set_stringtable_mapname("shg");
  soundscripts\_snd_filters::snd_set_occlusion("med_occlusion");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_launchfacility_a_global");
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
  soundscripts\_snd::snd_register_message("start_container_checkpoint", ::start_container_checkpoint);
  soundscripts\_snd::snd_register_message("start_tarmac_checkpoint", ::start_tarmac_checkpoint);
  soundscripts\_snd::snd_register_message("start_gate_checkpoint", ::start_gate_checkpoint);
  soundscripts\_snd::snd_register_message("start_vents_checkpoint", ::start_vents_checkpoint);
  soundscripts\_snd::snd_register_message("start_gimme_sitrep_music_mix", ::start_gimme_sitrep_music_mix);
  soundscripts\_snd::snd_register_message("start_blow_the_gate_mix", ::start_blow_the_gate_mix);
  soundscripts\_snd::snd_register_message("start_tarmac_mix", ::start_tarmac_mix);
  soundscripts\_snd::snd_register_message("start_vents_mix", ::start_vents_mix);
  soundscripts\_snd::snd_register_message("start_rappel_mix", ::start_rappel_mix);
}

zone_handler(var_0, var_1) {}

music_handler(var_0, var_1) {}

start_default_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_container_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_tarmac_checkpoint(var_0) {
  soundscripts\_audio_mix_manager::mm_add_submix("tarmac_mix");
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_gate_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_vents_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

flying_intro_start() {
  common_scripts\utility::flag_wait("introscreen_activate");
  soundscripts\_audio_mix_manager::mm_add_submix("flying_intro_mute");
  flying_intro_check_end();
}

flying_intro_check_end() {
  common_scripts\utility::flag_wait("introscreen_remove_submix");
  soundscripts\_audio_mix_manager::mm_clear_submix("flying_intro_mute", 1);
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_gimme_sitrep_music_mix() {
  soundscripts\_audio_mix_manager::mm_add_submix("gimme_sitrep_music_mix");
}

start_blow_the_gate_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("gimme_sitrep_music_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("blow_the_gate_mix");
}

start_tarmac_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("blow_the_gate_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("tarmac_mix");
}

start_vents_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("tarmac_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("vents_mix");
}

start_rappel_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("vents_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("rappel_mix");
}

bmp_start_moving() {
  thread common_scripts\utility::stop_loop_sound_on_entity("bmp_idle_low");
  thread common_scripts\utility::play_loop_sound_on_entity("bmp_engine_low", undefined, 0, 0.7);
}

bmp_stop_moving() {
  thread common_scripts\utility::stop_loop_sound_on_entity("bmp_engine_low");
  thread common_scripts\utility::play_loop_sound_on_entity("bmp_idle_low", undefined, 0.3, 0.7);
}