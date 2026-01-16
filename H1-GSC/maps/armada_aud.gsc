/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\armada_aud.gsc
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
  soundscripts\_audio_mix_manager::mm_add_submix("mix_armada_global");
  soundsettraceflags("vehicles", "solid", "glass");
  soundsettraceflags("battlechatter", "solid", "glass");
  soundsettraceflags("voices", "solid", "glass");
  soundsettraceflags("emitters", "solid", "glass");
  soundsettraceflags("weapons", "solid", "glass");
  soundsettraceflags("explosions", "solid", "glass");
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
  soundscripts\_snd::snd_register_message("snd_zone_handler", ::zone_handler);
  soundscripts\_snd::snd_register_message("snd_music_handler", ::music_handler);
  soundscripts\_snd::snd_register_message("start_default_checkpoint", ::start_default_checkpoint);
  soundscripts\_snd::snd_register_message("start_ride_checkpoint", ::start_ride_checkpoint);
  soundscripts\_snd::snd_register_message("start_landed_checkpoint", ::start_landed_checkpoint);
  soundscripts\_snd::snd_register_message("start_hq2tv_checkpoint", ::start_hq2tv_checkpoint);
  soundscripts\_snd::snd_register_message("start_intel_checkpoint", ::start_intel_checkpoint);
  soundscripts\_snd::snd_register_message("start_tv_checkpoint", ::start_tv_checkpoint);
  soundscripts\_snd::snd_register_message("start_tank_checkpoint", ::start_tank_checkpoint);
  soundscripts\_snd::snd_register_message("start_end_checkpoint", ::start_end_checkpoint);
  soundscripts\_snd::snd_register_message("stop_inside_blackhawk_mix", ::stop_inside_blackhawk_mix);
  soundscripts\_snd::snd_register_message("stop_intro_mix", ::stop_intro_mix);
  soundscripts\_snd::snd_register_message("set_ambiance_level_01", ::set_ambiance_level_01);
  soundscripts\_snd::snd_register_message("set_ambiance_level_03", ::set_ambiance_level_03);
  soundscripts\_snd::snd_register_message("start_last_mig29_mix", ::start_last_mig29_mix);
}

zone_handler(var_0, var_1) {}

music_handler(var_0, var_1) {}

start_default_checkpoint(var_0) {
  set_ambiance_level_00();
  soundscripts\_audio_zone_manager::azm_start_zone("inside_blackhawk");
  soundscripts\_audio_mix_manager::mm_add_submix("Intro_mix");
}

start_ride_checkpoint(var_0) {
  set_ambiance_level_00();
  soundscripts\_audio_zone_manager::azm_start_zone("inside_blackhawk");
  soundscripts\_audio_mix_manager::mm_add_submix("Intro_mix");
}

start_landed_checkpoint(var_0) {
  set_ambiance_level_00();
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_hq2tv_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("bunker");
}

start_intel_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("bunker");
}

start_tv_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

start_tank_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("interior_stone");
}

start_end_checkpoint(var_0) {
  soundscripts\_audio_zone_manager::azm_start_zone("interior_before_studio");
}

stop_intro_mix() {
  wait 1.0;
  soundscripts\_audio_mix_manager::mm_clear_submix("Intro_mix");
}

stop_inside_blackhawk_mix() {
  soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

set_ambiance_level_00() {
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("exterior", "ambient_armada_ext0", 0.05);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("inside_blackhawk", "ambient_armada_ext0", 0.05);
  soundscripts\_audio_zone_manager::azm_set_zone_dynamic_ambience("exterior", "exterior", 0.05);
  soundscripts\_audio_zone_manager::azm_set_zone_dynamic_ambience("inside_blackhawk", "exterior", 0.05);
}

set_ambiance_level_01() {
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("exterior", "ambient_armada_ext1", 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("inside_blackhawk", "ambient_armada_ext1", 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_dynamic_ambience("exterior", "exterior1", 0.05);
  soundscripts\_audio_zone_manager::azm_set_zone_dynamic_ambience("inside_blackhawk", "exterior1", 0.05);
}

set_ambiance_level_03() {
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("exterior", "ambient_armada_ext3", 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("inside_blackhawk", "ambient_armada_ext3", 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_dynamic_ambience("exterior", "exterior3", 0.05);
  soundscripts\_audio_zone_manager::azm_set_zone_dynamic_ambience("inside_blackhawk", "exterior3", 0.05);
  soundscripts\_audio_zone_manager::azm_set_zone_mix("exterior", "exterior_parking", 1.2);
}

start_last_mig29_mix() {
  soundscripts\_audio_mix_manager::mm_add_submix("last_mig29_mix");
  wait 5.0;
  soundscripts\_audio_mix_manager::mm_clear_submix("last_mig29_mix");
}

play_technical_scripted_sfx_sequence() {
  var_0 = getentarray("script_vehicle_pickup_technical", "classname");

  foreach(var_2 in var_0) {
    if(var_2.script_vehiclespawngroup == 5)
      var_2.script_disablevehicleaudio = 1;
  }

  var_4 = getvehiclenode("auto2665", "targetname");
  var_4 thread play_scripted_technical_sfx("scn_armada_jeep_scripted_track");
  var_5 = getvehiclenode("auto2711", "targetname");
  var_5 thread play_scripted_technical_sfx("scn_armada_jeep_scripted_track_02");
  var_5 = getvehiclenode("auto2713", "targetname");
  var_5 thread play_scripted_technical_sfx("scn_armada_jeep_scripted_track_03");
}

play_scripted_technical_sfx(var_0) {
  self waittill("trigger", var_1);
  var_1 playsound(var_0);
  var_1 common_scripts\utility::waittill_either("driver dead", "death");
  var_1 stopsounds();
}