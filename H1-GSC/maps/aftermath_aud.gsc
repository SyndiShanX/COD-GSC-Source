/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\aftermath_aud.gsc
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
  soundscripts\_audio_mix_manager::mm_add_submix("mix_aftermath_global");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_intro_stinger");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_intro_radio_vo");
  soundscripts\_audio_zone_manager::azm_start_zone("interior_vehicle");
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
  soundscripts\_snd::snd_register_message("aud_start_mix_player_dying", ::aud_start_mix_player_dying);
}

zone_handler(var_0, var_1) {}

music_handler(var_0, var_1) {}

aud_player_falls() {
  soundscripts\_audio_zone_manager::azm_set_filter_bypass(1);
  soundscripts\_snd_filters::snd_fade_in_filter("blur_event_filter", 0.5);

  if(!isdefined(level.heartbeat_ent)) {
    level.heartbeat_ent = spawn("script_origin", level.player.origin);
    level.heartbeat_ent linkto(level.player);
  }

  level.heartbeat_ent stoploopsound();
  level.player playsound("h1_heartbeat_fall");
  level.player thread maps\_utility::play_sound_on_entity("scn_player_fall_impact");
}

aud_player_recover() {
  soundscripts\_snd_filters::snd_fade_out_filter(2);
  soundscripts\_audio_zone_manager::azm_set_filter_bypass(0);
  level.player thread maps\_utility::play_sound_on_entity("breathing_better");
}

aud_player_dying_slowly() {
  level waittill("helicopterfall_bodysense");
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_intro_radio_vo");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_player_dying_slowly");
}

aud_start_mix_player_dying() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_player_dying_slowly");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_player_dying");
  level.heartbeat_ent stoploopsound();
  level.player thread maps\_utility::play_sound_on_entity("h1_aftermath_final_stinger_front");
  level.player thread maps\_utility::play_sound_on_entity("heartbeat_death");
  level.player thread common_scripts\utility::stop_loop_sound_on_entity(level.playerbreathalias);
  wait 0.1;
  level.heartbeat_ent delete();
}

aud_player_walking_foley(var_0) {
  if(var_0 == "crouch")
    level.player maps\_utility::delaythread(0.4, maps\_utility::play_sound_on_entity, "step_prone_gravel_aftermath");
  else if(var_0 == "prone")
    level.player maps\_utility::delaythread(0.4, maps\_utility::play_sound_on_entity, "step_prone_plr_gravel_aftermath");
  else
    level.player maps\_utility::delaythread(0.4, maps\_utility::play_sound_on_entity, "step_crchwalk_plr_gravel_aftermath");
}