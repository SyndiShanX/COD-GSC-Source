/****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\village_assault_aud.gsc
****************************************/

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
  soundscripts\_audio_mix_manager::mm_add_submix("mix_village_assault_global");
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
  soundscripts\_snd::snd_register_message("start_town_checkpoint", ::start_town_checkpoint);
  soundscripts\_snd::snd_register_message("start_alasad_barn_checkpoint", ::start_alasad_barn_checkpoint);
  soundscripts\_snd::snd_register_message("start_alasad_house_checkpoint", ::start_alasad_house_checkpoint);
  soundscripts\_snd::snd_register_message("increase_ambient", ::increase_ambient);
  soundscripts\_snd::snd_register_message("settle_ambient", ::settle_ambient);
  soundscripts\_snd::snd_register_message("start_air_support_mix", ::start_air_support_mix);
  soundscripts\_snd::snd_register_message("stop_air_support_mix", ::stop_air_support_mix);
  soundscripts\_snd::snd_register_message("start_interrogationA_black_screen_mix", ::start_interrogationa_black_screen_mix);
  soundscripts\_snd::snd_register_message("start_interrogation_mix", ::start_interrogation_mix);
  soundscripts\_snd::snd_register_message("start_interrogationA_mix", ::start_interrogationa_mix);
  soundscripts\_snd::snd_register_message("start_interrogationB_black_screen_mix", ::start_interrogationb_black_screen_mix);
}

zone_handler(var_0, var_1) {}

music_handler(var_0, var_1) {}

start_default_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_town_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_alasad_barn_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_alasad_house_checkpoint(var_0) {
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
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("exterior", "ambient_village_assault_ext2", 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("trainstation_attic", "ambient_village_assault_ext2", 0.8);
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

increase_ambient() {
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("exterior", "ambient_village_assault_ext3", 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_dynamic_ambience("exterior", "exterior3", 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("trainstation_attic", "ambient_village_assault_ext3", 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_dynamic_ambience("trainstation_attic", "exterior3", 0.8);
}

settle_ambient() {
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("exterior", "ambient_village_assault_ext1", 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_dynamic_ambience("exterior", "exterior1", 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("trainstation_attic", "ambient_village_assault_ext1", 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_dynamic_ambience("trainstation_attic", "exterior1", 0.8);
}

start_air_support_mix() {
  soundscripts\_audio_mix_manager::mm_add_submix("air_support_mix");
}

stop_air_support_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("air_support_mix");
}

start_interrogation_mix() {
  soundscripts\_audio_mix_manager::mm_add_submix("interrogation_mix");
}

start_interrogationa_black_screen_mix() {
  soundscripts\_audio_mix_manager::mm_add_submix("interrogationA_black_screen_mix");
}

start_interrogationa_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("interrogationA_black_screen_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("interrogationA_mix");
}

start_interrogationb_black_screen_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("interrogationA_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("interrogationB_black_screen_mix");
}