/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\airlift_aud.gsc
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
  soundscripts\_audio_mix_manager::mm_add_submix("mix_airlift_global");
}

init_snd_flags() {
  soundsettraceflags("vehicles", "solid", "glass");
  soundsettraceflags("battlechatter", "solid", "glass");
  soundsettraceflags("voices", "solid", "glass");
  soundsettraceflags("emitters", "solid", "glass");
  soundsettraceflags("weapons", "solid", "glass");
  soundsettraceflags("explosions", "solid", "glass");
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
  soundscripts\_snd::snd_register_message("start_smoketown_checkpoint", ::start_smoketown_checkpoint);
  soundscripts\_snd::snd_register_message("start_cobraflight_checkpoint", ::start_cobraflight_checkpoint);
  soundscripts\_snd::snd_register_message("start_cobrastreets_checkpoint", ::start_cobrastreets_checkpoint);
  soundscripts\_snd::snd_register_message("start_nuke_checkpoint", ::start_nuke_checkpoint);
  soundscripts\_snd::snd_register_message("aud_add_gun_overheat_mix", ::aud_add_gun_overheat_mix);
  soundscripts\_snd::snd_register_message("aud_remove_gun_overheat_mix", ::aud_remove_gun_overheat_mix);
  soundscripts\_snd::snd_register_message("aud_seaknight_sound_node_spawner", ::aud_seaknight_sound_node_spawner);
  soundscripts\_snd::snd_register_message("aud_seaknight_leaves_smoketown", ::aud_seaknight_leaves_smoketown);
  soundscripts\_snd::snd_register_message("aud_add_smoketown_operation_mix", ::aud_add_smoketown_operation_mix);
  soundscripts\_snd::snd_register_message("aud_add_leave_smoketown_mix", ::aud_add_leave_smoketown_mix);
  soundscripts\_snd::snd_register_message("aud_add_drag_pilot_mix", ::aud_add_drag_pilot_mix);
  soundscripts\_snd::snd_register_message("aud_add_escape_crash_mix", ::aud_add_escape_crash_mix);
  soundscripts\_snd::snd_register_message("aud_add_failure_mix", ::aud_add_failure_mix);
  soundscripts\_snd::snd_register_message("aud_add_nuke_heli_spin_mix", ::aud_add_nuke_heli_spin_mix);
  soundscripts\_snd::snd_register_message("aud_add_nuke_blackscreen_mix", ::aud_add_nuke_blackscreen_mix);
  soundscripts\_snd::snd_register_message("player_outside_seaknight", ::player_outside_seaknight);
  soundscripts\_snd::snd_register_message("set_ambient_helicopter", ::set_ambient_helicopter);
  soundscripts\_snd::snd_register_message("start_cobra_crash_mix", ::start_cobra_crash_mix);
  soundscripts\_snd::snd_register_message("start_pilot_rescue_mix", ::start_pilot_rescue_mix);
  soundscripts\_snd::snd_register_message("start_nuke_mix", ::start_nuke_mix);
  soundscripts\_snd::snd_register_message("set_context_int_for_seaknight", ::set_context_int_for_seaknight);
  soundscripts\_snd::snd_register_message("set_context_ext_for_seaknight", ::set_context_ext_for_seaknight);
}

zone_handler(var_0, var_1) {}

music_handler(var_0, var_1) {}

start_default_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("inside_seaknight_ext");
  soundscripts\_audio_mix_manager::mm_add_submix("intro_chopper_mix");
}

start_smoketown_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("inside_seaknight_ext");
  soundscripts\_audio_mix_manager::mm_add_submix("heli_landing_field_mix");
}

start_cobraflight_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
  soundscripts\_audio_mix_manager::mm_add_submix("smoketown_operation_mix");
}

start_cobrastreets_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("inside_seaknight_ext");
  soundscripts\_audio_mix_manager::mm_add_submix("pilot_rescue_mix");
}

start_nuke_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
  soundscripts\_audio_mix_manager::mm_add_submix("escape_crash_mix");
}

intro_start() {
  common_scripts\utility::flag_wait("introscreen_activate");
  soundscripts\_audio_mix_manager::mm_add_submix("airlift_intro_mute");
  intro_check_end();
}

intro_check_end() {
  common_scripts\utility::flag_wait("introscreen_remove_submix");
  soundscripts\_audio_mix_manager::mm_clear_submix("airlift_intro_mute");
  soundscripts\_audio_mix_manager::mm_add_submix("intro_chopper_mix");
  soundscripts\_audio_zone_manager::azm_start_zone("inside_seaknight_ext");
}

set_ambient_helicopter() {
  soundscripts\_audio_zone_manager::azm_start_zone("inside_seaknight_int");
}

player_outside_seaknight() {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

aud_add_smoketown_operation_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("seaknight_taking_off_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("smoketown_operation_mix");
}

aud_add_leave_smoketown_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("smoketown_operation_mix", 0.5);
  soundscripts\_audio_mix_manager::mm_add_submix("leaving_smoketown_mix");
}

start_cobra_crash_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("leaving_smoketown_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("cobra_crash_mix");
}

start_pilot_rescue_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("landing_crash_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("pilot_rescue_mix");
}

aud_add_drag_pilot_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("pilot_rescue_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("drag_pilot_mix");
}

aud_add_escape_crash_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("drag_pilot_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("escape_crash_mix");
}

start_nuke_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("escape_crash_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("nuke_mix");
}

aud_add_nuke_heli_spin_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("nuke_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("nuke_heli_spin_mix");
}

aud_add_nuke_blackscreen_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("nuke_heli_spin_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("nuke_blackscreen_mix");
}

aud_add_gun_overheat_mix() {
  soundscripts\_audio_mix_manager::mm_add_submix("gun_overheat_mix");
}

aud_remove_gun_overheat_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("gun_overheat_mix");
}

aud_add_failure_mix() {
  soundscripts\_audio_mix_manager::mm_add_submix("failure_mix");
}

set_context_int_for_seaknight() {
  soundscripts\_audio_zone_manager::azm_start_zone("inside_seaknight_int", 0.5);
}

set_context_ext_for_seaknight() {
  soundscripts\_audio_zone_manager::azm_start_zone("inside_seaknight_ext", 0.5);
}

aud_seaknight_sound_node_spawner() {
  level.seaknight_engine_sound_node = spawn("script_origin", level.seaknight.origin);
  level.seaknight_engine_sound_node linkto(level.seaknight);
}

aud_seaknight_event_handler(var_0, var_1, var_2, var_3, var_4) {
  if(isdefined(var_3) && isdefined(var_4)) {
    soundscripts\_audio_mix_manager::mm_clear_submix(var_3, 0.5);
    soundscripts\_audio_mix_manager::mm_add_submix(var_4, 0.5);
  }

  self scalepitch(var_0, var_2);
  self scalevolume(var_1, var_2);
}

aud_seaknight_audio_event(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread maps\_utility::play_sound_on_entity(var_0);
  self scalepitch(var_1, var_2);
  wait(var_3 + var_2);
  self scalepitch(var_4, var_5);
}

aud_seaknight_leaves_smoketown() {
  soundscripts\_audio_mix_manager::mm_clear_submix("heli_landing_field_mix", 0.5);
  soundscripts\_audio_mix_manager::mm_add_submix("seaknight_taking_off_mix", 0.5);
  level.seaknight_engine_sound_node thread maps\_utility::play_sound_on_entity("scn_airlift_seaknight_liftoff_smoketown");
}

aud_convoy_passby_manager(var_0, var_1, var_2, var_3) {
  wait(var_3);
  var_4 = getentarray(var_0, var_1);

  foreach(var_6 in var_4)
  var_6 playsound(var_2);
}

aud_cobra_passby_manager(var_0, var_1, var_2) {
  var_3 = getent(var_0, "targetname");
  var_3 waittill("trigger", var_4);
  wait(var_2);
  var_4 thread maps\_utility::play_sound_on_entity(var_1);
}

aud_abrams_passby_manager(var_0) {
  var_1 = 0;

  for (;;) {
    self waittill("trigger", var_2);
    wait 0.1;
    var_1 = var_1 + 1;

    switch (var_0) {
      case "lead":
        var_2 thread maps\_utility::play_sound_on_entity("scn_airlift_abrams_lead");
        break;
      case "follow":
        var_3 = "scn_airlift_abrams_follow_0" + var_1;
        var_2 thread maps\_utility::play_sound_on_entity(var_3);
        break;
    }

    wait 0.05;
  }
}

play_player_heli_land_sfx(var_0, var_1) {
  var_0 waittill("trigger", var_2);
  thread maps\_utility::play_sound_on_entity(var_1);
}