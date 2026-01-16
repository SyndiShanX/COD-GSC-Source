/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\blackout_aud.gsc
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
  soundscripts\_audio_mix_manager::mm_add_submix("mix_blackout_global");
}

init_snd_flags() {
  common_scripts\utility::flag_init("enemy_heli_departs");
}

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
  soundscripts\_snd::snd_register_message("start_chess_checkpoint", ::start_chess_checkpoint);
  soundscripts\_snd::snd_register_message("start_field_checkpoint", ::start_field_checkpoint);
  soundscripts\_snd::snd_register_message("start_overlook_checkpoint", ::start_overlook_checkpoint);
  soundscripts\_snd::snd_register_message("start_cliff_checkpoint", ::start_cliff_checkpoint);
  soundscripts\_snd::snd_register_message("start_rappel_checkpoint", ::start_rappel_checkpoint);
  soundscripts\_snd::snd_register_message("start_farmhouse_checkpoint", ::start_farmhouse_checkpoint);
  soundscripts\_snd::snd_register_message("start_blackout_checkpoint", ::start_blackout_checkpoint);
  soundscripts\_snd::snd_register_message("start_rescue_checkpoint", ::start_rescue_checkpoint);
  soundscripts\_snd::snd_register_message("aud_open_door_meeting", ::aud_open_door_meeting);
  soundscripts\_snd::snd_register_message("aud_start_meeting", ::aud_start_meeting);
  soundscripts\_snd::snd_register_message("aud_stop_meeting", ::aud_stop_meeting);
  soundscripts\_snd::snd_register_message("aud_start_enemy_heli_mix", ::aud_start_enemy_heli_mix);
  soundscripts\_snd::snd_register_message("aud_start_sniping_mix", ::aud_start_sniping_mix);
  soundscripts\_snd::snd_register_message("aud_stop_sniping_mix", ::aud_stop_sniping_mix);
  soundscripts\_snd::snd_register_message("start_gaz_kam_fight_mix", ::start_gaz_kam_fight_mix);
  soundscripts\_snd::snd_register_message("stop_gaz_kam_fight_mix", ::stop_gaz_kam_fight_mix);
  soundscripts\_snd::snd_register_message("aud_start_post_rappel_mix", ::aud_start_post_rappel_mix);
  soundscripts\_snd::snd_register_message("aud_stop_post_rappel_mix", ::aud_stop_post_rappel_mix);
  soundscripts\_snd::snd_register_message("aud_start_power_off_sfx", ::aud_start_power_off_sfx);
  soundscripts\_snd::snd_register_message("aud_gaz_open_door_rescue", ::aud_gaz_open_door_rescue);
  soundscripts\_snd::snd_register_message("start_player_gets_on_heli_mix", ::start_player_gets_on_heli_mix);
}

zone_handler(var_0, var_1) {}

music_handler(var_0, var_1) {}

start_default_checkpoint(var_0) {
  set_all_audio_zone_streamed_ambiance("ambient_blackout_ext0");
  disable_azm_trigger_before_meeting_door_open();
  disable_azm_trigger_before_gaz_open_door_for_rescue();
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_chess_checkpoint(var_0) {
  set_all_audio_zone_streamed_ambiance("ambient_blackout_ext0");
  disable_azm_trigger_before_meeting_door_open();
  disable_azm_trigger_before_gaz_open_door_for_rescue();
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_field_checkpoint(var_0) {
  aud_open_door_meeting();
  disable_azm_trigger_before_gaz_open_door_for_rescue();
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_overlook_checkpoint(var_0) {
  aud_open_door_meeting();
  disable_azm_trigger_before_gaz_open_door_for_rescue();
  soundscripts\_audio_mix_manager::mm_add_submix("sniping_mix");
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_cliff_checkpoint(var_0) {
  aud_open_door_meeting();
  disable_azm_trigger_before_gaz_open_door_for_rescue();
  soundscripts\_audio_mix_manager::mm_add_submix("sniping_mix");
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_rappel_checkpoint(var_0) {
  aud_open_door_meeting();
  disable_azm_trigger_before_gaz_open_door_for_rescue();
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_farmhouse_checkpoint(var_0) {
  disable_azm_trigger_before_gaz_open_door_for_rescue();
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_blackout_checkpoint(var_0) {
  disable_azm_trigger_before_gaz_open_door_for_rescue();
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_rescue_checkpoint(var_0) {
  aud_gaz_open_door_rescue();
  soundscripts\_audio_zone_manager::azm_start_zone("interior_wood");
}

aud_open_door_meeting() {
  if(isdefined(level.aud.first_door_open_trigger)) {
    wait 1.5;
    common_scripts\utility::array_thread(level.aud.first_door_open_trigger, common_scripts\utility::trigger_on);
  }

  var_0 = getent("ambient_emitter_01", "targetname");
  var_0 thread common_scripts\utility::play_loop_sound_on_entity("emt_blackout_ambient_transition");
}

aud_start_meeting() {
  soundscripts\_audio_mix_manager::mm_add_submix("meeting_mix");
  common_scripts\utility::flag_wait("go_up_hill");
  soundscripts\_audio_mix_manager::mm_add_submix("allies_climbing_up_the_hill_mix");
}

aud_stop_meeting() {
  soundscripts\_audio_mix_manager::mm_clear_submix("meeting_mix");
}

aud_start_enemy_heli_mix() {
  wait 15.0;
  soundscripts\_audio_mix_manager::mm_add_submix("enemy_heli_mix");
  aud_stop_enemy_heli_mix();
}

aud_stop_enemy_heli_mix() {
  common_scripts\utility::flag_wait("enemy_heli_unloaded");
  wait 8.0;
  soundscripts\_audio_mix_manager::mm_clear_submix("enemy_heli_mix");
}

aud_start_sniping_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("allies_climbing_up_the_hill_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("sniping_mix");
}

aud_stop_sniping_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("sniping_mix");
}

start_gaz_kam_fight_mix() {
  soundscripts\_audio_mix_manager::mm_add_submix("gaz_kam_fight_mix");
}

stop_gaz_kam_fight_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("gaz_kam_fight_mix");
}

aud_start_post_rappel_mix() {
  soundscripts\_audio_mix_manager::mm_add_submix("post_rappel_mix");
}

aud_stop_post_rappel_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("post_rappel_mix");
}

aud_gaz_open_door_rescue() {
  if(isdefined(level.aud.gaz_door_open_trigger)) {
    wait 1.5;
    level.aud.gaz_door_open_trigger common_scripts\utility::trigger_on();
  }

  var_0 = getent("ambient_emitter_02", "targetname");
  var_0 thread common_scripts\utility::play_loop_sound_on_entity("emt_blackout_ambient_transition");
}

start_player_gets_on_heli_mix() {
  wait 0.8;
  soundscripts\_audio_zone_manager::azm_start_zone("inside_blackhawk");
  wait 18.5;
  soundscripts\_audio_mix_manager::mm_add_submix("end_black_screen_mix");
}

aud_start_power_off_sfx() {
  var_0 = getent("exterior_light_turn_power_off_sfx", "targetname");

  if(isdefined(var_0)) {
    var_0 thread maps\_utility::play_sound_on_entity("scn_blackout_power_down");
    var_0 maps\_utility::play_sound_on_entity("scn_light_power_off");
  }
}

start_scripted_uaz_audio() {
  var_0 = getvehiclenode("auto2259", "targetname");
  var_0 thread play_uaz_scripted_sfx();
  var_1 = getvehiclenode("auto2246", "targetname");
  var_1 thread play_uaz_rock_falling_sfx();
}

play_uaz_scripted_sfx() {
  for (var_0 = 1; var_0 <= 2; var_0++) {
    self waittill("trigger", var_1);
    var_1 vehicle_turnengineoff();
    var_1.script_disablevehicleaudio = 1;
    var_1 playsound("scn_blackout_uaz_" + var_0 + "_scripted_track");
  }
}

play_uaz_rock_falling_sfx() {
  for (var_0 = 1; var_0 <= 2; var_0++) {
    self waittill("trigger", var_1);
    wait 2;
    var_1 thread common_scripts\utility::play_sound_in_space("emt_truck_rock_rubble", var_1.origin + (0, 0, -100));
    wait 1;
    var_1 thread common_scripts\utility::play_sound_in_space("emt_truck_rock_rubble", var_1.origin + (0, 0, -100));
  }
}

set_all_audio_zone_streamed_ambiance(var_0) {
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("exterior", var_0, 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("under_stone_bridge", var_0, 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("interior_wood_open", var_0, 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("interior_stone_open", var_0, 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("interior_burning_house", var_0, 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("interior_small_destructed_shack", var_0, 0.8);
}

disable_azm_trigger_before_meeting_door_open() {
  level.aud.first_door_open_trigger = getentarray("flag_before_first_door_open", "script_noteworthy");
  common_scripts\utility::array_thread(level.aud.first_door_open_trigger, common_scripts\utility::trigger_off);
}

disable_azm_trigger_before_gaz_open_door_for_rescue() {
  level.aud.gaz_door_open_trigger = getent("flag_before_gaz_open_door_for_rescue", "script_noteworthy");
  level.aud.gaz_door_open_trigger common_scripts\utility::trigger_off();
}