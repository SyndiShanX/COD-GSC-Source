/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\ambush_aud.gsc
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
  soundscripts\_audio_mix_manager::mm_add_submix("mix_ambush_global");
}

init_snd_flags() {
  soundsettraceflags("emitters", "solid", "glass");
  soundsettraceflags("vehicles", "solid", "glass");
  soundsettraceflags("battlechatter", "solid", "glass");
  soundsettraceflags("voices", "solid", "glass");
  soundsettraceflags("weapons", "solid", "glass");
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
  soundscripts\_snd::snd_register_message("snd_zone_handler", ::zone_handler);
  soundscripts\_snd::snd_register_message("start_default_checkpoint", ::start_default_checkpoint);
  soundscripts\_snd::snd_register_message("start_ambush_checkpoint", ::start_ambush_checkpoint);
  soundscripts\_snd::snd_register_message("start_village_checkpoint", ::start_village_checkpoint);
  soundscripts\_snd::snd_register_message("start_morpheus_checkpoint", ::start_morpheus_checkpoint);
  soundscripts\_snd::snd_register_message("start_apartment_checkpoint", ::start_apartment_checkpoint);
  soundscripts\_snd::snd_register_message("aud_stop_mix_stealth_ambush", ::aud_stop_mix_stealth_ambush);
  soundscripts\_snd::snd_register_message("aud_start_mix_fade_to_black", ::aud_start_mix_fade_to_black);
  soundscripts\_snd::snd_register_message("aud_stop_mix_fade_to_black", ::aud_stop_mix_fade_to_black);
  soundscripts\_snd::snd_register_message("aud_start_mix_ambush", ::aud_start_mix_ambush);
  soundscripts\_snd::snd_register_message("aud_start_mix_tower_crash", ::aud_start_mix_tower_crash);
  soundscripts\_snd::snd_register_message("aud_start_mix_tower_crash_stunned", ::aud_start_mix_tower_crash_stunned);
  soundscripts\_snd::snd_register_message("aud_start_mix_zak_son_escape", ::aud_start_mix_zak_son_escape);
  soundscripts\_snd::snd_register_message("aud_start_mix_mission_failed", ::aud_start_mix_mission_failed);
  soundscripts\_snd::snd_register_message("aud_start_mix_heli_1st_turret", ::aud_start_mix_heli_1st_turret);
  soundscripts\_snd::snd_register_message("aud_stop_mix_heli_1st_turret", ::aud_stop_mix_heli_1st_turret);
  soundscripts\_snd::snd_register_message("aud_start_mix_heli_2nd_turret", ::aud_start_mix_heli_2nd_turret);
  soundscripts\_snd::snd_register_message("aud_stop_mix_heli_2nd_turret", ::aud_stop_mix_heli_2nd_turret);
  soundscripts\_snd::snd_register_message("aud_start_mix_drop_bloody_gun", ::aud_start_mix_drop_bloody_gun);
  soundscripts\_snd::snd_register_message("aud_start_mix_suicide_slowmo", ::aud_start_mix_suicide_slowmo);
  soundscripts\_snd::snd_register_message("aud_start_mix_ending", ::aud_start_mix_ending);
  soundscripts\_snd::snd_register_message("aud_start_ambience_morning", ::aud_start_ambience_morning);
  soundscripts\_snd::snd_register_message("aud_start_ambience_war", ::aud_start_ambience_war);
  soundscripts\_snd::snd_register_message("aud_russian_battle_chatter", ::aud_russian_battle_chatter);
}

zone_handler(var_0, var_1) {}

music_handler(var_0, var_1) {}

start_default_checkpoint(var_0) {}

start_ambush_checkpoint(var_0) {
  aud_start_ambience_morning();
}

start_village_checkpoint(var_0) {
  aud_start_ambience_morning();
  soundscripts\_audio_mix_manager::mm_add_submix("mix_zak_son_escape");
}

start_morpheus_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
  aud_start_ambience_war();
  soundscripts\_audio_mix_manager::mm_add_submix("mix_zak_son_escape");
}

start_apartment_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
  aud_start_ambience_war();
  soundscripts\_audio_mix_manager::mm_add_submix("mix_zak_son_escape");
}

intro_start() {
  common_scripts\utility::flag_wait("introscreen_activate");
  soundscripts\_audio_mix_manager::mm_add_submix("ambush_intro_mute");
  intro_check_end();
}

intro_check_end() {
  common_scripts\utility::flag_wait("introscreen_remove_submix");
  soundscripts\_audio_mix_manager::mm_clear_submix("ambush_intro_mute");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_stealth");
  soundscripts\_audio_zone_manager::azm_start_zone("junkyard");
}

aud_stop_mix_stealth_ambush() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_stealth");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_takeover");
}

aud_start_mix_fade_to_black() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_takeover");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_fade_to_black");
}

aud_stop_mix_fade_to_black() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_fade_to_black");
}

aud_start_mix_ambush() {
  soundscripts\_audio_mix_manager::mm_add_submix("mix_ambush");
}

aud_start_mix_tower_crash() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_ambush");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_tower_crash");
}

aud_start_mix_tower_crash_stunned() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_tower_crash");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_tower_crash_stunned");
  soundscripts\_snd_filters::snd_fade_in_filter("tower_crashed_stunned_filter", 0.5);
}

aud_start_mix_zak_son_escape() {
  soundscripts\_snd_filters::snd_fade_out_filter(0.5);
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_tower_crash_stunned");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_zak_son_escape");
}

aud_start_mix_mission_failed() {
  soundscripts\_audio_mix_manager::mm_add_submix("mix_mission_failed");
}

aud_start_mix_heli_1st_turret() {
  soundscripts\_audio_mix_manager::mm_add_submix("mix_heli_1st_turret");
}

aud_stop_mix_heli_1st_turret() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_heli_1st_turret");
}

aud_start_mix_heli_2nd_turret() {
  soundscripts\_audio_mix_manager::mm_add_submix("mix_heli_2nd_turret");
}

aud_stop_mix_heli_2nd_turret() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_heli_2nd_turret");
}

aud_start_mix_drop_bloody_gun() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_zak_son_escape");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_drop_bloody_gun");
}

aud_start_mix_suicide_slowmo() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_drop_bloody_gun");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_suicide_slowmo");
  soundscripts\_audio_zone_manager::azm_set_reverb_bypass(1);
  level.player setreverb("snd_enveffectsprio_level", "underwater", 1, 0.7, 0.5);
}

aud_start_mix_ending() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_suicide_slowmo");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_ending");
  level.player deactivatereverb("snd_enveffectsprio_level", 1);
  soundscripts\_audio_zone_manager::azm_set_reverb_bypass(0);
}

aud_start_ambience_morning() {
  soundscripts\_audio_zone_manager::azm_stop_zones(0.5);
  wait 0.5;
  soundscripts\_audio_zone_manager::azm_set_zone_dynamic_ambience("gas_station", "exterior_morning", 0.5);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("gas_station", "ambient_ambush_morning_ext", 0.5);
  soundscripts\_audio_zone_manager::azm_start_zone("gas_station");
  soundscripts\_audio_zone_manager::azm_set_zone_dynamic_ambience("junkyard", "exterior_morning", 0.05);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("junkyard", "ambient_ambush_morning_ext", 0.05);
  soundscripts\_audio_zone_manager::azm_set_zone_dynamic_ambience("interior_vehicle", "exterior_morning", 0.05);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("interior_vehicle", "ambient_ambush_morning_ext", 0.05);
  soundscripts\_audio_zone_manager::azm_set_zone_dynamic_ambience("interior_stone_open", "exterior_morning", 0.05);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("interior_stone_open", "ambient_ambush_int", 0.05);
}

aud_start_ambience_war() {
  soundscripts\_audio_zone_manager::azm_stop_zones();
  soundscripts\_audio_zone_manager::azm_set_zone_dynamic_ambience("interior_stone_open", "exterior_war", 0.05);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("interior_stone_open", "ambient_ambush_int", 0.05);
}

aud_russian_battle_chatter() {
  var_0 = getent("battlechatter_node", "targetname");
  wait 0.5;
  thread common_scripts\utility::play_sound_in_space("ambush_ru_bchatter_threat", var_0.origin);
  var_1 = randomfloatrange(0.5, 1.5);
  wait(var_1);
  thread common_scripts\utility::play_sound_in_space("ambush_ru_bchatter_move", var_0.origin);
  var_1 = randomfloatrange(0.5, 1.5);
  wait(var_1);
  thread common_scripts\utility::play_sound_in_space("ambush_ru_bchatter_attack", var_0.origin);
}

aud_start_ambush_heli_scripted_sequence(var_0) {
  soundscripts\_audio_mix_manager::mm_add_submix("mix_ambush_heli");
  maps\_utility::play_sound_on_entity("scn_ambush_convoy_heli_reveal");
  var_0 thread monitor_end_node_reached();
  common_scripts\utility::waittill_any("end_node_reached");
  wait 2;
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_ambush_heli");
  wait 2;
  self stopsound("scn_ambush_convoy_heli_reveal");
}

aud_vehicle_engine_linear(var_0, var_1, var_2) {
  var_3 = maps\_utility::getent_or_struct_or_node(var_1, "script_noteworthy");
  thread maps\_utility::play_sound_on_entity(var_0);
  var_3 waittill("trigger", var_4);
  var_4 endon("death");
  var_4 maps\_utility::play_sound_on_entity(var_2);
}

monitor_end_node_reached() {
  self waittill("trigger", var_0);
  var_0 endon("death");
  var_0 notify("end_node_reached");
}

snd_heli_missile_shoot(var_0, var_1) {
  var_0 thread maps\_utility::play_sound_on_entity("scn_ambush_heli_missile_shoot");
  var_1 thread common_scripts\utility::play_loop_sound_on_entity("scn_ambush_heli_missile_lp");
}

aud_dog_sequence() {
  self waittill("trigger", var_0);
  var_0 playsound("scn_ambush_junkyard_dog_atk");
  var_0 waittill("death");
  var_0 stopsound("scn_ambush_junkyard_dog_atk");
}