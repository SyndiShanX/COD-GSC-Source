/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\ac130_aud.gsc
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
  thread start_ac130_finish_fadeout();
}

config_system() {
  soundscripts\_audio::set_stringtable_mapname("shg");
  soundscripts\_snd_filters::snd_set_occlusion("med_occlusion");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_ac130_global");
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

register_snd_messages() {}

zone_handler(var_0, var_1) {}

music_handler(var_0, var_1) {}

start_ac130_finish_fadeout() {
  common_scripts\utility::flag_wait("choppers_flew_away");

  if(getdvar("arcademode") != "1")
    soundscripts\_audio_mix_manager::mm_add_submix("ac130_fadeout_mix");
}