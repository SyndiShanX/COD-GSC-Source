/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\cargoship_aud.gsc
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
  soundscripts\_audio_mix_manager::mm_add_submix("mix_cargoship_global");
}

init_snd_flags() {
  common_scripts\utility::flag_init("aud_mix_deck_window");
  common_scripts\utility::flag_init("aud_package_door_creaks");
  soundsettraceflags("vehicles", "solid", "glass");
  soundsettraceflags("battlechatter", "solid", "glass");
  soundsettraceflags("voices", "solid", "glass");
  soundsettraceflags("emitters", "solid", "glass");
}

init_globals() {}

launch_threads() {
  thread aud_start_mix_deck_windows();
  thread aud_start_mix_end();
}

launch_loops() {}

launch_line_emitters() {
  wait 0.1;
  thread soundscripts\_audio::aud_play_line_emitter("ocean_emitter_left", "emt_waves_crashing_far", (3649.9, -899.7, -13), (-3582, -899.7, -13), 0.5);
  thread soundscripts\_audio::aud_play_line_emitter("ocean_emitter_right", "emt_waves_crashing_far", (3710.4, 893.8, -13), (-3586.4, 896.9, -13), 0.5);
  thread soundscripts\_audio::aud_play_line_emitter("hangar_emitter_center01 ", "emt_water_drop_metal", (-1894.71, -27.25, -407.875), (-1142.67, -20.391, -407.875), 0.5);
  thread soundscripts\_audio::aud_play_line_emitter("hangar_emitter_center02 ", "emt_water_drop_metal", (-963.804, -5.706, -407.875), (-830.211, 2.213, -407.875), 0.5);
  thread soundscripts\_audio::aud_play_line_emitter("hangar_emitter_center03 ", "emt_water_drop_metal", (-548.97, 8.78, -407.875), (131.804, 11.023, -407.875), 0.5);
  thread soundscripts\_audio::aud_play_line_emitter("hangar_emitter_center04 ", "emt_water_drop_metal", (549.98, 14.846, -407.875), (995.199, 22.681, -407.875), 0.5);
  thread soundscripts\_audio::aud_play_line_emitter("hangar_emitter_center05 ", "emt_water_drop_metal", (1255.19, 11.04, -407.875), (2497.56, 2.806, -407.875), 0.5);
}

create_level_envelop_arrays() {}

precache_presets() {}

register_snd_messages() {
  soundscripts\_snd::snd_register_message("snd_zone_handler", ::zone_handler);
  soundscripts\_snd::snd_register_message("snd_music_handler", ::music_handler);
  soundscripts\_snd::snd_register_message("aud_start_checkpoint", ::aud_start_checkpoint);
  soundscripts\_snd::snd_register_message("aud_bridge_checkpoint", ::aud_bridge_checkpoint);
  soundscripts\_snd::snd_register_message("aud_deck_checkpoint", ::aud_deck_checkpoint);
  soundscripts\_snd::snd_register_message("aud_hallways_checkpoint", ::aud_hallways_checkpoint);
  soundscripts\_snd::snd_register_message("aud_cargohold_checkpoint", ::aud_cargohold_checkpoint);
  soundscripts\_snd::snd_register_message("aud_cargohold2_checkpoint", ::aud_cargohold2_checkpoint);
  soundscripts\_snd::snd_register_message("aud_laststand_checkpoint", ::aud_laststand_checkpoint);
  soundscripts\_snd::snd_register_message("aud_package_checkpoint", ::aud_package_checkpoint);
  soundscripts\_snd::snd_register_message("aud_escape_checkpoint", ::aud_escape_checkpoint);
  soundscripts\_snd::snd_register_message("aud_end_checkpoint", ::aud_end_checkpoint);
  soundscripts\_snd::snd_register_message("aud_get_out_blackhawk", ::aud_get_out_blackhawk);
  soundscripts\_snd::snd_register_message("aud_stop_intro_mix", ::aud_stop_intro_mix);
  soundscripts\_snd::snd_register_message("aud_get_in_seaknight", ::aud_get_in_seaknight);
  soundscripts\_snd::snd_register_message("aud_start_mix_heli_shoot_window", ::aud_start_mix_heli_shoot_window);
  soundscripts\_snd::snd_register_message("aud_stop_mix_heli_shoot_window", ::aud_stop_mix_heli_shoot_window);
  soundscripts\_snd::snd_register_message("aud_stop_mix_moving_to_hallway", ::aud_stop_mix_moving_to_hallway);
  soundscripts\_snd::snd_register_message("aud_start_mix_npc_pre_explosion", ::aud_start_mix_npc_pre_explosion);
  soundscripts\_snd::snd_register_message("aud_start_mix_scn_explosion", ::aud_start_mix_scn_explosion);
  soundscripts\_snd::snd_register_message("aud_start_mix_escape", ::aud_start_mix_escape);
  soundscripts\_snd::snd_register_message("start_mix_final_jump", ::start_mix_final_jump);
  soundscripts\_snd::snd_register_message("start_mix_finale_music", ::start_mix_finale_music);
  soundscripts\_snd::snd_register_message("start_title_logo_mix", ::start_title_logo_mix);
  soundscripts\_snd::snd_register_message("aud_start_sway1", ::aud_start_sway1);
  soundscripts\_snd::snd_register_message("aud_start_sway2", ::aud_start_sway2);
}

zone_handler(var_0, var_1) {}

music_handler(var_0, var_1) {}

aud_start_checkpoint() {
  soundscripts\_audio_mix_manager::mm_add_submix("intro_mix");
  soundscripts\_audio_zone_manager::azm_start_zone("cargoship_inside_blackhawk");
}

aud_bridge_checkpoint() {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_deck_checkpoint() {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_hallways_checkpoint() {
  soundscripts\_audio_mix_manager::mm_add_submix("mix_moving_to_hallway");
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_cargohold_checkpoint() {
  soundscripts\_audio_zone_manager::azm_start_zone("interior_metal");
}

aud_cargohold2_checkpoint() {
  soundscripts\_audio_zone_manager::azm_start_zone("hangar");
}

aud_laststand_checkpoint() {
  soundscripts\_audio_zone_manager::azm_start_zone("hangar");
}

aud_package_checkpoint() {
  soundscripts\_audio_zone_manager::azm_start_zone("hangar");
}

aud_escape_checkpoint() {
  soundscripts\_audio_zone_manager::azm_start_zone("hangar");
}

aud_end_checkpoint() {
  soundscripts\_audio_mix_manager::mm_add_submix("mix_escape");
  soundscripts\_audio_zone_manager::azm_start_zone("interior_metal");
}

intro_start() {
  common_scripts\utility::flag_wait("introscreen_activate");
  soundscripts\_audio_mix_manager::mm_add_submix("cargoship_intro_mute");
  intro_check_end();
}

intro_check_end() {
  common_scripts\utility::flag_wait("introscreen_remove_submix");
  soundscripts\_audio_mix_manager::mm_clear_submix("cargoship_intro_mute", 1.75);
}

aud_get_out_blackhawk() {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior", 0.3);
}

aud_stop_intro_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("intro_mix");
}

aud_get_in_seaknight() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_final_jump");
  soundscripts\_audio_zone_manager::azm_start_zone("cargoship_inside_seaknight", 0.3);
}

aud_start_mix_deck_windows() {
  common_scripts\utility::flag_wait("aud_mix_deck_window");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_deck_windows");
}

aud_start_mix_heli_shoot_window() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_deck_windows");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_heli_shoot_window");
}

aud_stop_mix_heli_shoot_window() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_heli_shoot_window");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_moving_to_hallway");
}

aud_stop_mix_moving_to_hallway() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_moving_to_hallway");
}

aud_start_mix_npc_pre_explosion() {
  soundscripts\_audio_mix_manager::mm_add_submix("mix_npc_pre_explosion");
}

aud_start_mix_scn_explosion() {
  soundscripts\_audio_mix_manager::mm_add_submix("mix_scn_explosion");
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_npc_pre_explosion");
  soundscripts\_audio_zone_manager::azm_set_filter_bypass(1);
  soundscripts\_audio_zone_manager::azm_set_reverb_bypass(1);
  level.player setreverb("snd_enveffectsprio_level", "scn_cargo_explosion", 1, 0.7, 0.5);
  soundscripts\_snd_filters::snd_fade_in_filter("scn_explosion_filter", 0.5);
}

aud_start_mix_escape() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_scn_explosion");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_escape");
  soundscripts\_snd_filters::snd_fade_out_filter(0.5);
  soundscripts\_audio_zone_manager::azm_set_filter_bypass(0);
  level.player deactivatereverb("snd_enveffectsprio_level", 1);
  level.player setreverb("snd_enveffectsprio_level", "hall_metal", 1, 0.4, 0.5);
  thread common_scripts\utility::play_loopsound_in_space("ambient_cargo_escape_rumble", (333.375, -0.75, -99.156));
  thread common_scripts\utility::play_loopsound_in_space("ambient_cargo_escape_rumble_02", (-1762, 103, -123));
  thread aud_alarm_sound();
}

aud_start_mix_end() {
  common_scripts\utility::flag_wait("aud_mix_end");
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_escape");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_end");
  level.player deactivatereverb("snd_enveffectsprio_level", 1);
  soundscripts\_audio_zone_manager::azm_set_reverb_bypass(0);
}

start_mix_final_jump() {
  soundscripts\_audio_mix_manager::mm_add_submix("mix_final_jump");
}

start_mix_finale_music() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_end");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_finale_music");
}

start_title_logo_mix() {
  wait 6;
  soundscripts\_audio_mix_manager::mm_add_submix("start_title_logo_mix");
}

aud_start_sway1() {
  level.player thread maps\_utility::play_sound_on_entity("elm_cargo_metal_stress_l");
  thread common_scripts\utility::play_sound_in_space("elm_metal_crane_creak", (894.75, -254.68, 427.8));
  thread common_scripts\utility::play_sound_in_space("elm_metal_crane_creak", (839.41, 199.43, 465.56));
  thread common_scripts\utility::play_sound_in_space("elm_metal_crane_creak", (-736.85, -175.85, 444.47));
  thread common_scripts\utility::play_sound_in_space("elm_metal_crane_creak", (-736.07, 177.02, 442.77));
  aud_container_doors_creak();
}

aud_start_sway2() {
  level.player thread maps\_utility::play_sound_on_entity("elm_cargo_metal_stress_r");
  thread common_scripts\utility::play_sound_in_space("elm_metal_crane_creak", (894.75, -254.68, 427.8));
  thread common_scripts\utility::play_sound_in_space("elm_metal_crane_creak", (839.41, 199.43, 465.56));
  thread common_scripts\utility::play_sound_in_space("elm_metal_crane_creak", (-736.85, -175.85, 444.47));
  thread common_scripts\utility::play_sound_in_space("elm_metal_crane_creak", (-736.07, 177.02, 442.77));
  aud_container_doors_creak();
}

aud_container_doors_creak() {
  thread common_scripts\utility::play_sound_in_space("cgo_container_door_creaks", (-1380.5, 181, 25));
  thread common_scripts\utility::play_sound_in_space("cgo_container_door_creaks", (-1630.5, 181, 24.5));
  thread common_scripts\utility::play_sound_in_space("cgo_container_door_creaks", (-1636.5, 89, 25));
  thread common_scripts\utility::play_sound_in_space("cgo_container_door_creaks", (-1387, 192.5, 25.5));
  thread common_scripts\utility::play_sound_in_space("cgo_container_door_creaks", (-1630, 285, 25.5));
  thread common_scripts\utility::play_sound_in_space("cgo_container_door_creaks", (-1637, 194, 27));
  thread common_scripts\utility::play_sound_in_space("cgo_container_door_creaks", (-1274.5, 256.5, -350));

  if(common_scripts\utility::flag("aud_package_door_creaks")) {
    thread common_scripts\utility::play_sound_in_space("cgo_container_door_creaks", (2349.5, 254, -306));
    thread common_scripts\utility::play_sound_in_space("cgo_container_door_creaks", (2349.5, 154, -306));
  }
}

start_blackhawk_move(var_0, var_1) {
  if(!isdefined(var_0) || !isdefined(var_1)) {
    return;
  }
  soundscripts\_audio_mix_manager::mm_add_submix("mix_heli_above_deck");
  var_0 thread maps\_utility::play_sound_on_entity(var_1);
}

stop_blackhawk_move() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_heli_above_deck");
}

aud_alarm_sound() {
  for (;;) {
    thread common_scripts\utility::play_sound_in_space("alarm_buzzer_control_room_3", (-2332.8, -96.3121, -84.7888));
    thread common_scripts\utility::play_sound_in_space("alarm_buzzer_control_room_3", (-3082.43, -216.679, 17.2978));
    thread common_scripts\utility::play_sound_in_space("alarm_buzzer_control_room_3", (-2513.76, -36.1929, 159.563));
    thread common_scripts\utility::play_sound_in_space("alarm_buzzer_control_room_3", (-2471.24, -226.825, 180.314));
    thread common_scripts\utility::play_sound_in_space("alarm_buzzer_control_room_3", (-2570.56, -492.694, 169.511));
    wait 2;
  }
}