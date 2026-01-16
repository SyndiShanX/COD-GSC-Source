/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\killhouse_aud.gsc
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
  soundscripts\_audio_mix_manager::mm_add_submix("mix_killhouse_global");
  aud_deactivate_hangar_transition_zone();
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
  soundscripts\_snd::snd_register_message("start_inside_checkpoint", ::start_inside_checkpoint);
  soundscripts\_snd::snd_register_message("start_look_training_checkpoint", ::start_look_training_checkpoint);
  soundscripts\_snd::snd_register_message("start_rifle_start_checkpoint", ::start_rifle_start_checkpoint);
  soundscripts\_snd::snd_register_message("start_rifle_timed_start_checkpoint", ::start_rifle_timed_start_checkpoint);
  soundscripts\_snd::snd_register_message("start_sidearm_start_checkpoint", ::start_sidearm_start_checkpoint);
  soundscripts\_snd::snd_register_message("start_frag_start_checkpoint", ::start_frag_start_checkpoint);
  soundscripts\_snd::snd_register_message("start_launcher_start_checkpoint", ::start_launcher_start_checkpoint);
  soundscripts\_snd::snd_register_message("start_explosives_start_checkpoint", ::start_explosives_start_checkpoint);
  soundscripts\_snd::snd_register_message("start_course_start_checkpoint", ::start_course_start_checkpoint);
  soundscripts\_snd::snd_register_message("start_reveal_start_checkpoint", ::start_reveal_start_checkpoint);
  soundscripts\_snd::snd_register_message("start_cargoship_start_checkpoint", ::start_cargoship_start_checkpoint);
  soundscripts\_snd::snd_register_message("start_debrief_start_checkpoint", ::start_debrief_start_checkpoint);
  soundscripts\_snd::snd_register_message("start_fade_to_black_end", ::start_fade_to_black_end);
}

zone_handler(var_0, var_1) {}

music_handler(var_0, var_1) {}

start_inside_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("hangar1");
}

start_look_training_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("hangar1");
}

start_rifle_start_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("hangar1");
}

start_rifle_timed_start_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("hangar1");
}

start_sidearm_start_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("hangar1");
}

start_frag_start_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_launcher_start_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_explosives_start_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_course_start_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_reveal_start_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_cargoship_start_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("hangar2");
}

start_debrief_start_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("hangar2");
}

aud_deactivate_hangar_transition_zone() {
  var_0 = getent("hangar_audio_transition_zone", "targetname");
  var_0 common_scripts\utility::trigger_off();
}

aud_activate_hangar_transition_zone() {
  maps\_utility::enable_trigger_with_targetname("hangar_audio_transition_zone");
}

aud_disable_bm21_idle() {
  var_0 = getent("bm21_no_sound_01", "targetname");
  var_0 vehicle_turnengineoff();
}

aud_bm21_driveby_snd(var_0) {
  var_0 vehicle_turnengineoff();
  var_1 = aud_entity_link_on_tag("scn_truck_passby_close_tire_left", var_0, "tag_wheel_back_left");
  var_2 = aud_entity_link_on_tag("scn_truck_passby_close_tire_right", var_0, "tag_wheel_back_right");
  var_3 = aud_entity_link_on_tag("scn_truck_passby_engine", var_0, "tag_body");
  var_4 = aud_vehicle_node_handler("vehicle_near_end_node");
  var_5 = aud_entity_link_on_tag("truck_brakesqueal", var_0, "tag_body");
  var_5 scalevolume(0, 0);
  var_5 playloopsound("truck_idle_high");
  var_5 scalevolume(1, 0.2);
  var_1 scalevolume(0, 2);
  var_2 scalevolume(0, 2);
  var_3 scalevolume(0, 0.8);
  var_6 = aud_vehicle_node_handler("vehicle_end_node");
  var_1 stopsounds();
  var_2 stopsounds();
  var_3 stopsounds();
  var_1 delete();
  var_2 delete();
  var_3 delete();
}

aud_entity_link_on_tag(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", (0, 0, 0));
  var_3 linkto(var_1, var_2, (0, 0, 0), (0, 0, 0));
  var_3 playloopsound(var_0);
  return var_3;
}

aud_vehicle_node_handler(var_0) {
  var_1 = maps\_utility::getent_or_struct_or_node(var_0, "script_noteworthy");
  var_1 waittill("trigger", var_2);
}

aud_timer_end() {
  var_0 = getent("timerEntity", "targetname");
  var_0 playsound("scn_timer_end");
}

aud_jet_passby() {
  var_0 = maps\_utility::getent_or_struct_or_node("jet01_sound", "script_noteworthy");
  var_1 = maps\_utility::getent_or_struct_or_node("jet02_sound", "script_noteworthy");
  thread aud_jet_start_node_handler(var_0);
  thread aud_jet_start_node_handler(var_1);
}

aud_jet_start_node_handler(var_0) {
  var_0 waittill("trigger", var_1);
  wait 0.9;
  var_1 thread maps\_utility::play_sound_on_entity("scn_mig29_passby");
  var_1 thread maps\_utility::play_sound_on_entity("veh_mig29_passby_layer");
}

aud_vehicle_driveby_manager() {
  if(self.vehicletype == "bm21_troops") {
    soundscripts\_audio_mix_manager::mm_add_submix("bm21_engine_mute");
    thread maps\_utility::play_sound_on_entity("scn_bm21_break");
    thread maps\_utility::play_sound_on_entity("scn_bm21_horn");
  } else {
    thread maps\_utility::play_sound_on_entity("scn_jeep_break");
    thread maps\_utility::play_sound_on_entity("scn_jeep_horn");
  }
}

aud_vehicle_driveby_reset() {
  if(self.vehicletype == "bm21_troops") {
    soundscripts\_audio_mix_manager::mm_clear_submix("bm21_engine_mute");
    thread maps\_utility::play_sound_on_entity("scn_bm21_start");
  }
}

aud_bm21_tire_sounds() {
  if(self.vehicletype == "bm21_troops") {
    var_0 = aud_entity_link_on_tag("scn_truck_passby_close_tire_left", self, "tag_wheel_back_left");
    var_1 = aud_entity_link_on_tag("scn_truck_passby_close_tire_right", self, "tag_wheel_back_right");
  }
}

aud_fail_mix() {
  level waittill("mission failed");
  soundscripts\_audio_mix_manager::mm_add_submix("fail_mix");
}

aud_hangar_amb_ext() {
  var_0 = spawn("script_origin", (3077.4, -1176.59, 139.321));
  var_1 = spawn("script_origin", (3056.51, -1177.58, 137.088));
  var_0 thread common_scripts\utility::play_loop_sound_on_entity("h1_emt_walla_military_int");
  var_1 thread common_scripts\utility::play_loop_sound_on_entity("amb_hangar_int_windows_outside_lp");
  level waittill("DespawnGuysHangar1");
  wait 3;
  var_0 delete();
  var_1 delete();
}

start_fade_to_black_end() {
  soundscripts\_audio_mix_manager::mm_add_submix("fade_to_black_end_mix");
}