/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\airplane_aud.gsc
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
  soundscripts\_audio_mix_manager::mm_add_submix("mix_airplane_global");
  soundscripts\_audio_mix_manager::mm_add_submix("first_floor_mix");
}

init_snd_flags() {
  common_scripts\utility::flag_init("wind_zone_active");
}

init_globals() {}

launch_threads() {
  thread aud_wind_door_mix_manager();
}

launch_loops() {}

launch_line_emitters() {
  wait 0.1;
}

create_level_envelop_arrays() {}

precache_presets() {}

register_snd_messages() {
  soundscripts\_snd::snd_register_message("snd_zone_handler", ::zone_handler);
  soundscripts\_snd::snd_register_message("snd_music_handler", ::music_handler);
  soundscripts\_snd::snd_register_message("aud_start_intro_checkpoint", ::aud_start_intro_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_breach_checkpoint", ::aud_start_intro_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_vip_checkpoint", ::aud_start_vip_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_freefall_checkpoint", ::aud_start_intro_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_demo_checkpoint", ::aud_start_intro_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_no_game_checkpoint", ::aud_start_intro_checkpoint);
  soundscripts\_snd::snd_register_message("aud_add_wind_door_mix", ::aud_add_wind_door_mix);
  soundscripts\_snd::snd_register_message("aud_remove_wind_door_mix", ::aud_remove_wind_door_mix);
  soundscripts\_snd::snd_register_message("aud_add_armed_bomb_vo_mix", ::aud_add_armed_bomb_vo_mix);
  soundscripts\_snd::snd_register_message("aud_remove_armed_bomb_vo_mix", ::aud_remove_armed_bomb_vo_mix);
  soundscripts\_snd::snd_register_message("aud_add_slowmo_mix", ::aud_add_slowmo_mix);
  soundscripts\_snd::snd_register_message("aud_remove_slowmo_mix", ::aud_remove_slowmo_mix);
  soundscripts\_snd::snd_register_message("mission_failed_fade_out", ::mission_failed_fade_out);
}

zone_handler(var_0, var_1) {}

music_handler(var_0, var_1) {}

aud_start_intro_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("interior_small");
}

aud_start_breach_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("interior_large");
}

aud_start_vip_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("second_floor_corridor");
}

aud_start_freefall_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("second_floor_large");
}

aud_start_demo_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("interior_large");
}

aud_wind_door_mix_manager() {
  common_scripts\utility::flag_wait("wind_zone_active");
  var_0 = getent("zone_wind", "targetname");
  var_0 thread update_wind_mix();
}

update_wind_mix() {
  for (;;) {
    self waittill("trigger", var_0);

    if(var_0 != level.player) {
      continue;
    }
    aud_add_wind_door_mix();

    while (self istouching(level.player))
      wait 0.05;

    aud_remove_wind_door_mix();
  }
}

aud_add_wind_door_mix() {
  soundscripts\_audio_mix_manager::mm_add_submix("wind_door_mix");
}

aud_remove_wind_door_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("wind_door_mix");
}

aud_add_armed_bomb_vo_mix() {
  soundscripts\_audio_mix_manager::mm_add_submix("armed_bomb_vo_mix");
}

aud_remove_armed_bomb_vo_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("armed_bomb_vo_mix");
}

aud_add_slowmo_mix() {
  soundscripts\_audio_mix_manager::mm_add_submix("slowmo_mix");
}

aud_remove_slowmo_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("slowmo_mix");
}

aud_explosion_event() {
  thread common_scripts\utility::play_sound_in_space("emt_engine_rev_left", (-213.481, 1664.53, 57.2619));
  thread common_scripts\utility::play_sound_in_space("emt_engine_rev_right", (-293.822, -439.819, 35.6474));
  thread common_scripts\utility::play_loopsound_in_space("emt_engine_left_lp", (-213.481, 1664.53, 57.2619));
  thread common_scripts\utility::play_loopsound_in_space("emt_engine_right_lp", (-293.822, -439.819, 35.6474));
  thread common_scripts\utility::play_loopsound_in_space("fuselage_breach_wind", (1120.67, 713.839, 177.178));
}

aud_animated_luggage() {
  thread common_scripts\utility::play_loop_sound_on_entity("emt_luggage_rattler_lp");
}

aud_end_breach_sounds() {
  thread maps\_utility::play_sound_on_entity("end_breach_explosion");
  thread maps\_utility::play_sound_on_entity("end_breach_explosion_in");
  thread common_scripts\utility::play_loop_sound_on_entity("end_breach_hole_wind_lp");
  maps\_utility::delaythread(1.4, common_scripts\utility::play_sound_in_space, "scn_container_impact", (-1042.49, 510.675, 289.612));
  maps\_utility::delaythread(2.5, common_scripts\utility::play_sound_in_space, "scn_container_impact", (-1115.57, 395.735, 299.337));
}

aud_final_jump_mix_and_sounds() {
  thread soundscripts\_audio_mix_manager::mm_clear_zone_mix("second_floor_mix");
  thread soundscripts\_audio_mix_manager::mm_clear_submix("armed_bomb_vo_mix");
  thread soundscripts\_audio_mix_manager::mm_add_submix("final_jump_mix");
  level.player thread maps\_utility::play_sound_on_entity("end_jump_plane");
  level.player thread common_scripts\utility::play_loop_sound_on_entity("ext_wind_lp_front");
}

mission_failed_fade_out() {
  soundscripts\_audio_mix_manager::mm_add_submix("fade_to_black_end_mix");
}