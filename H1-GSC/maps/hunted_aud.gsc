/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\hunted_aud.gsc
********************************/

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
  soundscripts\_audio_mix_manager::mm_add_submix("mix_hunted_global");
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
  soundscripts\_snd::snd_register_message("snd_zone_handler", ::zone_handler);
  soundscripts\_snd::snd_register_message("snd_music_handler", ::music_handler);
  soundscripts\_snd::snd_register_message("aud_start_default_checkpoint", ::aud_start_default_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_crash_checkpoint", ::aud_start_crash_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_path_checkpoint", ::aud_start_path_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_barn_checkpoint", ::aud_start_barn_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_field_checkpoint", ::aud_start_field_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_basement_checkpoint", ::aud_start_basement_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_farm_checkpoint", ::aud_start_farm_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_creek_checkpoint", ::aud_start_creek_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_greenhouse_checkpoint", ::aud_start_greenhouse_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_ac130_checkpoint", ::aud_start_ac130_checkpoint);
  soundscripts\_snd::snd_register_message("aud_set_exterior_level_1", ::aud_set_exterior_level_1);
  soundscripts\_snd::snd_register_message("aud_set_exterior_level_2", ::aud_set_exterior_level_2);
  soundscripts\_snd::snd_register_message("aud_heli_crashing", ::aud_heli_crashing);
  soundscripts\_snd::snd_register_message("aud_heli_crash_fade_out", ::aud_heli_crash_fade_out);
  soundscripts\_snd::snd_register_message("aud_heli_crash_fade_in", ::aud_heli_crash_fade_in);
  soundscripts\_snd::snd_register_message("aud_heli_slomo", ::aud_heli_slomo);
  soundscripts\_snd::snd_register_message("aud_heli_field_pass", ::aud_heli_field_pass);
  soundscripts\_snd::snd_register_message("aud_barnyard_sequence", ::aud_barnyard_sequence);
  soundscripts\_snd::snd_register_message("aud_ac130_sequence", ::aud_ac130_sequence);
}

zone_handler(var_0, var_1) {}

music_handler(var_0, var_1) {}

aud_start_default_checkpoint(var_0) {
  aud_set_exterior_level_0();
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_start_crash_checkpoint(var_0) {
  aud_set_exterior_level_0();
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_start_path_checkpoint(var_0) {
  aud_set_exterior_level_0();
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_start_barn_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_start_field_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_start_basement_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_start_farm_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_start_creek_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_start_greenhouse_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_start_ac130_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

intro_start() {
  common_scripts\utility::flag_wait("introscreen_activate");
  soundscripts\_audio_mix_manager::mm_add_submix("hunted_intro_mute");
  intro_check_end();
}

intro_check_end() {
  common_scripts\utility::flag_wait("introscreen_remove_submix");
  soundscripts\_audio_mix_manager::mm_clear_submix("hunted_intro_mute", 2);
  soundscripts\_audio_mix_manager::mm_add_submix("helicopter_ride_mix");
}

aud_heli_slomo() {
  wait 0.4;
  soundscripts\_audio_mix_manager::mm_clear_submix("helicopter_ride_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("helicopter_slowmo_mix");
  soundscripts\_snd_filters::snd_fade_in_filter("scn_explosion_filter", 0.5);
}

aud_heli_crashing() {
  soundscripts\_snd_filters::snd_fade_out_filter(0.1);
  soundscripts\_audio_mix_manager::mm_clear_submix("helicopter_slowmo_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("helicopter_crashing_mix");
}

aud_heli_crash_fade_out() {
  soundscripts\_audio_mix_manager::mm_clear_submix("helicopter_crashing_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("heli_crash_fade_out");
}

aud_heli_crash_fade_in() {
  soundscripts\_audio_mix_manager::mm_clear_submix("heli_crash_fade_out");
}

aud_heli_field_pass() {
  soundscripts\_audio_mix_manager::mm_add_submix("heli_field_pass_mix");
}

aud_barnyard_sequence() {
  soundscripts\_audio_mix_manager::mm_clear_submix("heli_field_pass_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("barnyard_seq_mix");
}

aud_ac130_sequence() {
  soundscripts\_audio_mix_manager::mm_clear_submix("barnyard_seq_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("ac130_destruction_mix");
}

aud_set_exterior_level_0() {
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("exterior", "ambient_hunted_ext0", 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("tunnel", "ambient_hunted_ext0", 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("interior_wood_open", "ambient_hunted_ext0", 0.8);
}

aud_set_exterior_level_1() {
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("exterior", "ambient_hunted_ext1", 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("tunnel", "ambient_hunted_ext1", 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("interior_wood_open", "ambient_hunted_ext1", 0.8);
}

aud_set_exterior_level_2() {
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("exterior", "ambient_hunted_ext2", 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("tunnel", "ambient_hunted_ext2", 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("interior_wood_open", "ambient_hunted_ext2", 0.8);
}