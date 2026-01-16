/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\icbm_aud.gsc
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
  soundscripts\_audio_mix_manager::mm_add_submix("mix_icbm_global");
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
  soundscripts\_snd::snd_register_message("start_landed_checkpoint", ::start_landed_checkpoint);
  soundscripts\_snd::snd_register_message("start_basement_checkpoint", ::start_basement_checkpoint);
  soundscripts\_snd::snd_register_message("start_house2_checkpoint", ::start_house2_checkpoint);
  soundscripts\_snd::snd_register_message("start_rescued_checkpoint", ::start_rescued_checkpoint);
  soundscripts\_snd::snd_register_message("start_tower_checkpoint", ::start_tower_checkpoint);
  soundscripts\_snd::snd_register_message("start_fense_checkpoint", ::start_fense_checkpoint);
  soundscripts\_snd::snd_register_message("start_base_checkpoint", ::start_base_checkpoint);
  soundscripts\_snd::snd_register_message("start_base2_checkpoint", ::start_base2_checkpoint);
  soundscripts\_snd::snd_register_message("start_launch_checkpoint", ::start_launch_checkpoint);
  soundscripts\_snd::snd_register_message("aud_open_fisrt_door", ::aud_open_fisrt_door);
  soundscripts\_snd::snd_register_message("first_house_mix", ::first_house_mix);
  soundscripts\_snd::snd_register_message("start_tower_first_choppers_fly_by", ::start_tower_first_choppers_fly_by);
  soundscripts\_snd::snd_register_message("start_missile_launch_mix", ::start_missile_launch_mix);
  soundscripts\_snd::snd_register_message("aud_start_bm21_scripted_sfx", ::aud_start_bm21_scripted_sfx);
}

zone_handler(var_0, var_1) {}

music_handler(var_0, var_1) {}

start_default_checkpoint(var_0) {
  disable_azm_trigger_open_door_first_house();
  soundscripts\_audio_zone_manager::azm_start_zone("exterior_wood");
}

start_landed_checkpoint(var_0) {
  disable_azm_trigger_open_door_first_house();
  soundscripts\_audio_zone_manager::azm_start_zone("exterior_wood");
}

start_basement_checkpoint(var_0) {
  disable_azm_trigger_open_door_first_house();
  soundscripts\_audio_zone_manager::azm_start_zone("exterior_wood");
}

start_house2_checkpoint(var_0) {
  aud_open_fisrt_door();
  soundscripts\_audio_zone_manager::azm_start_zone("exterior_wood");
}

start_rescued_checkpoint(var_0) {
  aud_open_fisrt_door();
  soundscripts\_audio_zone_manager::azm_start_zone("exterior_wood");
}

start_tower_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("field");
}

start_fense_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("field");
}

start_base_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior_wood");
}

start_base2_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("warehouse");
}

start_launch_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior_wood_end");
}

aud_open_fisrt_door() {
  if(isdefined(level.aud.door_first_house_trigger)) {
    wait 1.5;
    level.aud.door_first_house_trigger common_scripts\utility::trigger_on();
  }

  var_0 = getent("first_door_ambient_emitter_01", "targetname");
  var_0 thread common_scripts\utility::play_loop_sound_on_entity("emt_icbm_ambient_door_transition");
  var_1 = getent("footstep_amb_emitter_02", "targetname");
  var_1 thread common_scripts\utility::play_loop_sound_on_entity("emt_overhead_footsteps");
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_first_house_search");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_rescue_griggs");
  common_scripts\utility::flag_wait_either("breach_started", "player_shooting_interogators");
  var_1 thread common_scripts\utility::stop_loop_sound_on_entity("emt_overhead_footsteps");
}

first_house_mix() {
  var_0 = getent("footstep_amb_emitter_01", "targetname");
  var_0 thread common_scripts\utility::play_loop_sound_on_entity("emt_overhead_footsteps");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_first_house_search");
  common_scripts\utility::flag_wait_either("house1_cleared", "_stealth_spotted");
  var_0 thread common_scripts\utility::stop_loop_sound_on_entity("emt_overhead_footsteps");
}

start_missile_launch_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_tower_destruction");
  soundscripts\_audio_mix_manager::mm_add_submix("missile_launch_mix");
  common_scripts\utility::flag_wait("launch_01");
  soundscripts\_audio_mix_manager::mm_clear_submix("missile_launch_mix");
}

start_tower_first_choppers_fly_by() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_rescue_griggs");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_tower_destruction");
}

start_first_truck_audio() {
  self vehicle_turnengineoff();
  self playsound("scn_icbm_first_jeep_scripted_sequence");
  uaz_monitor_death();
}

handle_first_truck_stop() {
  thread common_scripts\utility::play_loop_sound_on_entity("veh_uaz_idle_low", undefined, 0.5, 0.2);
}

uaz_monitor_death() {
  self waittill("death");
  self stoploopsound("veh_uaz_idle_low");
  self stopsounds();
}

aud_start_bm21_scripted_sfx() {
  var_0 = getvehiclenode("auto2648", "targetname");
  var_1 = getvehiclenode("auto2649", "targetname");
  var_0 thread handle_start_vehicle("h1_scn_icbm_bm21_01_arrival", 7.1);
  var_1 thread handle_start_vehicle("h1_scn_icbm_bm21_02_arrival", 11.7);
}

handle_start_vehicle(var_0, var_1) {
  self waittill("trigger", var_2);
  var_2 endon("death");
  var_2 vehicle_turnengineoff();
  var_2 thread maps\_utility::play_sound_on_tag_endon_death(var_0);
  wait(var_1);
  var_2 vehicle_turnengineon();
}

disable_azm_trigger_open_door_first_house() {
  level.aud.door_first_house_trigger = getent("flag_before_open_door_first_house", "script_noteworthy");
  level.aud.door_first_house_trigger common_scripts\utility::trigger_off();
}