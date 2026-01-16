/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\bog_a_aud.gsc
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
  soundscripts\_audio_mix_manager::mm_add_submix("mix_bog_a_global");
}

init_snd_flags() {}

init_globals() {
  level.aud.bog_faked_ambience_ent = getent("amb_damb_bog_01", "targetname");
}

launch_threads() {
  common_scripts\utility::array_thread(getentarray("trigger_sound_emitter", "script_noteworthy"), ::trigger_sound_emitter);
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
  soundscripts\_snd::snd_register_message("start_ambush_checkpoint", ::start_ambush_checkpoint);
  soundscripts\_snd::snd_register_message("start_melee_checkpoint", ::start_melee_checkpoint);
  soundscripts\_snd::snd_register_message("start_breach_checkpoint", ::start_breach_checkpoint);
  soundscripts\_snd::snd_register_message("start_alley_checkpoint", ::start_alley_checkpoint);
  soundscripts\_snd::snd_register_message("start_shanty_checkpoint", ::start_shanty_checkpoint);
  soundscripts\_snd::snd_register_message("start_bog_checkpoint", ::start_bog_checkpoint);
  soundscripts\_snd::snd_register_message("start_zpu_checkpoint", ::start_zpu_checkpoint);
  soundscripts\_snd::snd_register_message("start_cobra_checkpoint", ::start_cobra_checkpoint);
  soundscripts\_snd::snd_register_message("start_end_checkpoint", ::start_end_checkpoint);
  soundscripts\_snd::snd_register_message("play_intro_scripted_cobra_pass_by", ::play_intro_scripted_cobra_pass_by);
  soundscripts\_snd::snd_register_message("start_cobra_crash_sequence", ::start_cobra_crash_sequence);
  soundscripts\_snd::snd_register_message("stop_cobra_crash_sequence", ::stop_cobra_crash_sequence);
  soundscripts\_snd::snd_register_message("start_shanty_open_audio", ::start_shanty_open_audio);
  soundscripts\_snd::snd_register_message("start_cobra_support_mix", ::start_cobra_support_mix);
  soundscripts\_snd::snd_register_message("set_bog_ambience_to_bog_end_ext0", ::set_bog_ambience_to_bog_end_ext0);
  soundscripts\_snd::snd_register_message("stop_cobra_support_mix", ::stop_cobra_support_mix);
  soundscripts\_snd::snd_register_message("start_ending_area_mix", ::start_ending_area_mix);
  soundscripts\_snd::snd_register_message("start_tank_mission_failure", ::start_tank_mission_failure);
  soundscripts\_snd::snd_register_message("start_end_black_screen_mix", ::start_end_black_screen_mix);
}

zone_handler(var_0, var_1) {}

music_handler(var_0, var_1) {}

start_ambush_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
  start_gunfire_damb_first_war_zone();
  start_gunfire_damb_bog();
  start_distant_alarm_sfx();
}

start_melee_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
  start_gunfire_damb_first_war_zone();
  start_gunfire_damb_bog();
}

start_breach_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("interior_stone_open");
  start_gunfire_damb_first_war_zone();
  start_gunfire_damb_bog();
}

start_alley_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("interior_stone");
  start_gunfire_damb_first_war_zone();
  start_gunfire_damb_bog();
}

start_shanty_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("interior_stone");
  start_gunfire_damb_first_war_zone();
  start_gunfire_damb_bog();
}

start_bog_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("underpass");
  start_bog_combat_emitter();
  start_gunfire_damb_bog();
}

start_zpu_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior_bog");
  start_gunfire_damb_bog();
}

start_cobra_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior_bog");
  start_gunfire_damb_bog();
}

start_end_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior_bog");
}

play_intro_scripted_cobra_pass_by() {
  var_0 = common_scripts\utility::getstruct("auto9", "targetname");
  var_1 = common_scripts\utility::getstruct("auto3112", "targetname");
  var_0 thread play_scripted_pass_by_sfx("scn_intro_cobra_passby_01");
  var_1 thread play_scripted_pass_by_sfx("scn_intro_cobra_passby_02");
}

start_cobra_crash_sequence() {
  soundscripts\_audio_mix_manager::mm_add_submix("cobra_crash_sequence");
  level.alarm_ent common_scripts\utility::stop_loop_sound_on_entity("emt_air_raid_alarm");
}

stop_cobra_crash_sequence() {
  soundscripts\_audio_mix_manager::mm_clear_submix("cobra_crash_sequence");
}

start_cobra_support_mix() {
  soundscripts\_audio_mix_manager::mm_add_submix("cobra_support_mix");
}

stop_cobra_support_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("cobra_support_mix");
}

set_bog_ambience_to_bog_end_ext0() {
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("exterior_bog", "ambient_bog_end_ext0", 4);
}

start_shanty_open_audio() {
  soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point("bog_gun_fire", "first_war_zone_gunfire", 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("exterior_javelin_square", "ambient_bog_ext0", 1.0);
  start_bog_combat_emitter();
  thread play_chain_link_fence_sfx();
}

play_chain_link_fence_sfx() {
  var_0 = getent("trig_metal_fence_sfx", "targetname");

  for (;;) {
    var_0 waittill("trigger", var_1);
    thread common_scripts\utility::play_sound_in_space("scn_chainlink_fence_rattle", var_1.origin);

    while (var_1 istouching(var_0))
      wait 0.05;
  }
}

play_melee_custom_pistol_fire_sfx(var_0) {
  var_0 thread maps\_utility::play_sound_on_tag("scn_melee_custom_pistol_fire", "tag_flash");
}

play_scripted_pass_by_sfx(var_0) {
  self waittill("trigger", var_1);
  var_1 vehicle_turnengineoff();
  var_1.script_disablevehicleaudio = 1;
  var_1 maps\_utility::play_sound_on_entity(var_0);
}

trigger_sound_emitter() {
  if(isdefined(self.script_parameters) && isdefined(self.target)) {
    self waittill("trigger", var_0);
    var_1 = getent(self.target, "targetname");
    var_1 maps\_utility::play_sound_on_entity(self.script_parameters);
  }
}

start_gunfire_damb_bog() {
  soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("bog_gun_fire", level.aud.bog_faked_ambience_ent.origin);
}

start_gunfire_damb_first_war_zone() {
  var_0 = getent("amb_damb_first_warzone_01", "targetname");
  soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("bog_gun_fire", var_0.origin, "first_war_zone_gunfire");
}

start_bog_combat_emitter() {
  level.aud.bog_faked_ambience_ent thread common_scripts\utility::play_loop_sound_on_entity("emt_bog_a_bog_combat", undefined, 1.0, 5.0);
  thread monitor_stop_bog_combat_emitter();
}

monitor_stop_bog_combat_emitter() {
  var_0 = getent("stop_combat_emitter_sfx", "targetname");
  var_0 waittill("trigger");
  level.aud.bog_faked_ambience_ent common_scripts\utility::stop_loop_sound_on_entity("emt_bog_a_bog_combat");
}

handle_cobra_waypoint_audio(var_0) {
  if(isdefined(var_0.targetname)) {
    switch (var_0.targetname) {
      case "maverick_waypoint1":
        thread maps\_utility::play_sound_on_entity("scn_cobra_support_arrival_01");
        thread maps\_utility::play_loop_sound_on_tag("h1r_bog_a_cobra_helicopter_wind", undefined, 1, 1);
        break;
      case "cobra2_arrival_scripted_sfx":
        thread maps\_utility::play_sound_on_entity("scn_cobra_support_arrival_02");
        thread maps\_utility::play_loop_sound_on_tag("h1r_bog_a_cobra_helicopter_wind", undefined, 1, 1);
        break;
      case "cobra1_start_leaving_sfx":
        thread maps\_utility::play_sound_on_entity("scn_cobra_support_leaving_01");
        break;
      case "cobra2_start_leaving_sfx":
        thread maps\_utility::play_sound_on_entity("scn_cobra_support_leaving_02");
        break;
    }
  }
}

start_distant_alarm_sfx() {
  level.alarm_ent = getent("distant_alarm_sfx", "targetname");
  level.alarm_ent thread common_scripts\utility::play_loop_sound_on_entity("emt_air_raid_alarm", undefined, 0, 20);
}

start_ending_area_mix() {
  soundscripts\_audio_mix_manager::mm_add_submix("ending_area_mix");
}

start_tank_mission_failure() {
  soundscripts\_audio_mix_manager::mm_add_submix("tank_mission_failure_mix");
}

start_end_black_screen_mix() {
  soundscripts\_audio_mix_manager::mm_add_submix("end_black_screen_mix");
}