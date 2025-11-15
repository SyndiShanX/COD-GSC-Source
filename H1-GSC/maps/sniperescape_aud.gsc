/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\sniperescape_aud.gsc
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
}

config_system() {
  soundscripts\_audio::set_stringtable_mapname("shg");
  soundscripts\_snd_filters::snd_set_occlusion("med_occlusion");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_sniperescape_global");
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
  soundscripts\_snd::snd_register_message("start_rappel_checkpoint", ::start_rappel_checkpoint);
  soundscripts\_snd::snd_register_message("start_run_checkpoint", ::start_run_checkpoint);
  soundscripts\_snd::snd_register_message("start_apart_checkpoint", ::start_apart_checkpoint);
  soundscripts\_snd::snd_register_message("start_wounding_checkpoint", ::start_wounding_checkpoint);
  soundscripts\_snd::snd_register_message("start_crash_checkpoint", ::start_crash_checkpoint);
  soundscripts\_snd::snd_register_message("start_wounded_checkpoint", ::start_wounded_checkpoint);
  soundscripts\_snd::snd_register_message("start_burnt_checkpoint", ::start_burnt_checkpoint);
  soundscripts\_snd::snd_register_message("start_pool_checkpoint", ::start_pool_checkpoint);
  soundscripts\_snd::snd_register_message("start_fair_checkpoint", ::start_fair_checkpoint);
  soundscripts\_snd::snd_register_message("start_fair_battle_checkpoint", ::start_fair_battle_checkpoint);
  soundscripts\_snd::snd_register_message("start_seaknight_checkpoint", ::start_seaknight_checkpoint);
  soundscripts\_snd::snd_register_message("start_heli_block_sequence", ::start_heli_block_sequence);
  soundscripts\_snd::snd_register_message("start_heli_block_moves", ::start_heli_block_moves);
  soundscripts\_snd::snd_register_message("start_snipe_scoped_in_mix", ::start_snipe_scoped_in_mix);
  soundscripts\_snd::snd_register_message("escape_hotel_mix", ::escape_hotel_mix);
  soundscripts\_snd::snd_register_message("rappel_foley_mix", ::rappel_foley_mix);
  soundscripts\_snd::snd_register_message("havoc_appear_mix", ::havoc_appear_mix);
  soundscripts\_snd::snd_register_message("havoc_explode_mix", ::havoc_explode_mix);
  soundscripts\_snd::snd_register_message("havoc_crashed_mix", ::havoc_crashed_mix);
  soundscripts\_snd::snd_register_message("carrying_macmillan_mix", ::carrying_macmillan_mix);
  soundscripts\_snd::snd_register_message("clear_carrying_mix", ::clear_carrying_mix);
  soundscripts\_snd::snd_register_message("seaknight_rescue_submix", ::seaknight_rescue_submix);
  soundscripts\_snd::snd_register_message("seaknight_rescue_submix_fade_out", ::seaknight_rescue_submix_fade_out);
  soundscripts\_snd::snd_register_message("seaknight_rescue_submix_arrival", ::seaknight_rescue_submix_arrival);
  soundscripts\_snd::snd_register_message("seaknight_rescue_submix_waiting", ::seaknight_rescue_submix_waiting);
}

zone_handler(var_0, var_1) {}

music_handler(var_0, var_1) {}

start_default_checkpoint(var_0) {
  soundscripts\_audio_mix_manager::mm_add_submix("snipe_before_heli_mix");
  soundscripts\_audio_zone_manager::azm_start_zone("interior_snipe_building");
}

start_rappel_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_run_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_apart_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_wounding_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("interior_stone");
}

start_crash_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_wounded_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_burnt_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_pool_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("shower_room");
}

start_fair_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_fair_battle_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_seaknight_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_snipe_scoped_in_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("snipe_before_heli_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("snipe_scoped_in_mix");
}

start_heli_block_sequence() {
  soundscripts\_audio_mix_manager::mm_clear_submix("snipe_scoped_in_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("heli_block_mix");
}

start_heli_block_moves() {
  soundscripts\_audio_mix_manager::mm_clear_submix("heli_block_mix");
}

escape_hotel_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("heli_block_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_hotel_escape");
}

rappel_foley_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_hotel_escape");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_rappel_foley");
  common_scripts\utility::flag_wait("aa_heat");
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_rappel_foley");
}

havoc_appear_mix() {
  soundscripts\_audio_mix_manager::mm_add_submix("mix_havoc_appear");
}

havoc_explode_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_havoc_appear");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_havoc_explode");
}

havoc_crashed_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_havoc_explode");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_havoc_crashed");
}

carrying_macmillan_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_havoc_crashed");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_carrying_macmillan");
}

clear_carrying_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_carrying_macmillan");
}

seaknight_rescue_submix_arrival() {
  soundscripts\_audio_mix_manager::mm_add_submix("mix_seaknight_arrive");
}

seaknight_rescue_submix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_seaknight_arrive");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_seaknight_rescue");
}

seaknight_rescue_submix_waiting() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_seaknight_rescue");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_seaknight_rescue_waiting");
}

seaknight_rescue_submix_fade_out() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_seaknight_rescue_waiting");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_seaknight_rescue_fade");
}