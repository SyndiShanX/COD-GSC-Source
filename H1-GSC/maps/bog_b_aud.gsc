/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\bog_b_aud.gsc
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
  thread flying_intro_start();
}

config_system() {
  soundscripts\_audio::set_stringtable_mapname("shg");
  soundscripts\_snd_filters::snd_set_occlusion("med_occlusion");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_bogb_global");
}

init_snd_flags() {
  common_scripts\utility::flag_init("first_mi17_gone");
  common_scripts\utility::flag_init("abrams_stop_for_city_fight");
  common_scripts\utility::flag_init("abrams_start_moving_after_city_fight");
  common_scripts\utility::flag_init("truck_crush_player_in_position");
  common_scripts\utility::flag_init("abrams_stop_wait_for_player");
}

init_globals() {
  level.aud.disable_m1a1_audio = 1;
  level.aud.abramsaudio = [];
  level.aud.abramsaudio[level.aud.abramsaudio.size] = getvehiclenode("auto33", "targetname");
  level.aud.abramsaudio[level.aud.abramsaudio.size] = getvehiclenode("auto34", "targetname");
  level.aud.abramsaudio[level.aud.abramsaudio.size] = getvehiclenode("auto70", "targetname");
  level.aud.abramsaudio[level.aud.abramsaudio.size] = getvehiclenode("auto73", "targetname");
  level.aud.abramsaudio[level.aud.abramsaudio.size] = getvehiclenode("auto76", "targetname");
  level.aud.abramsaudio[level.aud.abramsaudio.size] = getvehiclenode("auto87", "targetname");
  level.aud.abramsaudio[level.aud.abramsaudio.size] = getvehiclenode("auto88", "targetname");
  level.aud.abramsaudio[level.aud.abramsaudio.size] = getvehiclenode("auto138", "targetname");
  level.aud.abramsaudio[level.aud.abramsaudio.size] = getvehiclenode("auto183", "targetname");
  level.aud.abramsaudio[level.aud.abramsaudio.size] = getvehiclenode("auto298", "targetname");
  level.aud.abramsaudio[level.aud.abramsaudio.size] = getvehiclenode("tank_path_4", "targetname");
  common_scripts\utility::array_thread(level.aud.abramsaudio, ::abrams_audio_node);
}

launch_threads() {}

launch_loops() {}

launch_line_emitters() {
  wait 0.1;
}

create_level_envelop_arrays() {
  level.aud.envs = [];
  level.aud.envs["example_envelop"] = [[0.0, 0.0],
    [0.082, 0.426],
    [0.238, 0.736],
    [0.408, 0.844],
    [0.756, 0.953],
    [1.0, 1.0]
  ];
}

precache_presets() {}

register_snd_messages() {
  soundscripts\_snd::snd_register_message("snd_zone_handler", ::zone_handler);
  soundscripts\_snd::snd_register_message("start_default_checkpoint", ::start_default_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_arch_checkpoint", ::aud_start_arch_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_alley_checkpoint", ::aud_start_alley_checkpoint);
  soundscripts\_snd::snd_register_message("aud_start_ch46_checkpoint", ::aud_start_ch46_checkpoint);
  soundscripts\_snd::snd_register_message("start_increase_ambiance", ::start_increase_ambiance);
  soundscripts\_snd::snd_register_message("start_decrease_ambiance", ::start_decrease_ambiance);
  soundscripts\_snd::snd_register_message("start_mi17_sequence", ::start_mi17_sequence);
  soundscripts\_snd::snd_register_message("start_t72_wall_explode_mix", ::start_t72_wall_explode_mix);
  soundscripts\_snd::snd_register_message("start_t72_hit_mix", ::start_t72_hit_mix);
  soundscripts\_snd::snd_register_message("start_t72_explode_mix", ::start_t72_explode_mix);
  soundscripts\_snd::snd_register_message("lastSequence_submix", ::lastsequence_submix);
  soundscripts\_snd::snd_register_message("lastSequence_celebration_submix", ::lastsequence_celebration_submix);
  soundscripts\_snd::snd_register_message("seaknight_rescue_submix", ::seaknight_rescue_submix);
}

zone_handler(var_0, var_1) {
  var_2 = "";
  var_3 = "";

  if(getsubstr(var_0, 0, 6) == "enter_")
    var_2 = var_1;
  else if(getsubstr(var_0, 0, 5) == "exit_")
    var_3 = var_1;
}

music_handler(var_0, var_1) {}

start_default_checkpoint(var_0) {
  set_exterior_streamed_ambience("ambient_bog_ext3");
  soundscripts\_audio_zone_manager::azm_start_zone("exterior_field");
}

aud_start_arch_checkpoint(var_0) {
  set_exterior_streamed_ambience("ambient_bog_ext3");
  soundscripts\_audio_zone_manager::azm_start_zone("exterior_field");
}

aud_start_alley_checkpoint(var_0) {
  start_decrease_ambiance();
  soundscripts\_audio_zone_manager::azm_start_zone("exterior_alley");
}

aud_start_ch46_checkpoint(var_0) {
  start_decrease_ambiance();
  soundscripts\_audio_zone_manager::azm_start_zone("exterior_field");
  soundscripts\_audio_mix_manager::mm_add_submix("mix_seaknight_rescue");
}

flying_intro_start() {
  common_scripts\utility::flag_wait("introscreen_activate");
  soundscripts\_audio_mix_manager::mm_add_submix("flying_intro_mute");
  flying_intro_check_end();
}

flying_intro_check_end() {
  common_scripts\utility::flag_wait("introscreen_remove_submix");
  soundscripts\_audio_mix_manager::mm_clear_submix("flying_intro_mute", 1);
  set_exterior_streamed_ambience("ambient_bog_ext3");
  soundscripts\_audio_zone_manager::azm_start_zone("exterior_field");
}

start_increase_ambiance() {
  set_exterior_streamed_ambience("ambient_bog_ext5");
}

start_decrease_ambiance() {
  set_exterior_streamed_ambience("ambient_bog_ext1");
}

lastsequence_submix() {
  soundscripts\_audio_mix_manager::mm_add_submix("mix_lastSequence", 0.8);
}

start_t72_wall_explode_mix() {
  soundscripts\_audio_mix_manager::mm_add_submix("t72_wall_explode_mix");
  thread aud_final_wall_exp_debris();
}

start_t72_hit_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("t72_wall_explode_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("t72_hit_mix");
}

start_t72_explode_mix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("t72_hit_mix");
  soundscripts\_audio_mix_manager::mm_add_submix("t72_explode_mix");
  thread aud_final_tank_exp_debris();
  wait 5;
  soundscripts\_audio_mix_manager::mm_clear_submix("t72_explode_mix");
}

lastsequence_celebration_submix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_lastSequence", 0.8);
  soundscripts\_audio_mix_manager::mm_add_submix("mix_lastSequence_celebration", 0.8);
}

seaknight_rescue_submix() {
  soundscripts\_audio_mix_manager::mm_clear_submix("mix_lastSequence_celebration", 0.8);
  soundscripts\_audio_mix_manager::mm_add_submix("mix_seaknight_rescue", 0.8);
}

play_mi17_unload_ennemies(var_0, var_1, var_2) {
  var_3 = getent(var_0, "targetname");
  var_4 = getent(var_1, "targetname");
  var_3 waittill("trigger", var_5);
  var_5 endon("death");
  var_5 vehicle_turnengineoff();
  var_5.script_disablevehicleaudio = 1;
  var_5 thread handle_single_mi17_sequence_mix();
  var_5 thread maps\_utility::play_sound_on_tag_endon_death("scn_mi17_unload_arrival_0" + var_2);
  var_4 waittill("trigger", var_5);
  var_5 thread maps\_utility::play_loop_sound_on_tag("mi17_close_towards_lp", undefined, 1, 1, 0.5, 0.5);
  var_5 waittill("unloaded");
  var_5 thread common_scripts\utility::stop_loop_sound_on_entity("mi17_close_towards_lp");
  var_5 thread maps\_utility::play_sound_on_tag_endon_death("scn_mi17_unload_leaving_0" + var_2);
}

start_mi17_sequence() {
  thread play_mi17_unload_ennemies("auto8", "auto1", 1);
  thread play_mi17_unload_ennemies("auto10", "auto2", 2);
  wait 5;
  soundscripts\_audio_mix_manager::mm_add_submix("mix_mi17_reinforcement");
}

handle_single_mi17_sequence_mix() {
  var_0 = common_scripts\utility::waittill_any_return("unloaded", "death");
  wait 4;

  if(!common_scripts\utility::flag("first_mi17_gone"))
    common_scripts\utility::flag_set("first_mi17_gone");
  else
    soundscripts\_audio_mix_manager::mm_clear_submix("mix_mi17_reinforcement");
}

abrams_audio_node() {
  self waittill("trigger", var_0);
  var_0 endon("death");

  switch (self.targetname) {
    case "auto33":
      var_0 thread maps\_utility::play_sound_on_entity("bog_b_m1a1_tank_move_01");
      break;
    case "auto34":
      play_abrams_idle_sound(var_0);
      var_0 thread maps\_utility::play_sound_on_entity("bog_b_m1a1_tank_move_02");
      break;
    case "auto70":
      play_abrams_idle_sound(var_0);
      var_0 thread maps\_utility::play_sound_on_entity("bog_b_m1a1_tank_move_03");
      break;
    case "auto73":
      play_abrams_idle_sound(var_0);
      var_0 thread maps\_utility::play_sound_on_entity("bog_b_m1a1_tank_move_04");
      break;
    case "auto76":
      common_scripts\utility::flag_set("abrams_stop_wait_for_player");
      play_abrams_idle_sound(var_0);
      var_0 thread maps\_utility::play_sound_on_entity("bog_b_m1a1_tank_move_04_crush_car");
      break;
    case "auto87":
      var_0 thread maps\_utility::play_sound_on_entity("bog_b_m1a1_tank_move_05");
      break;
    case "auto88":
      common_scripts\utility::flag_set("abrams_stop_for_city_fight");
      play_abrams_idle_sound(var_0);
      var_0 thread maps\_utility::play_sound_on_entity("bog_b_m1a1_tank_move_06");
      break;
    case "auto138":
      common_scripts\utility::flag_set("abrams_stop_for_city_fight");
      play_abrams_idle_sound(var_0);
      var_0 thread maps\_utility::play_sound_on_entity("bog_b_m1a1_tank_move_07");
      break;
    case "auto183":
      common_scripts\utility::flag_set("abrams_stop_for_city_fight");
      play_abrams_idle_sound(var_0);
      var_0 thread maps\_utility::play_sound_on_entity("bog_b_m1a1_tank_move_08");
      break;
    case "auto298":
      common_scripts\utility::flag_set("abrams_stop_for_city_fight");
      play_abrams_idle_sound(var_0);
      var_0 thread maps\_utility::play_sound_on_entity("bog_b_m1a1_tank_move_09");
      break;
    case "tank_path_4":
      var_0 thread common_scripts\utility::play_loop_sound_on_entity("bog_b_m1a1_tank_idle");
      break;
  }
}

play_abrams_idle_sound(var_0) {
  if(isdefined(self.gateopen) && !self.gateopen) {
    var_0 thread common_scripts\utility::play_loop_sound_on_entity("bog_b_m1a1_tank_idle");

    for (;;) {
      if(self.gateopen) {
        break;
      }

      wait 0.05;
    }

    var_0 thread common_scripts\utility::stop_loop_sound_on_entity("bog_b_m1a1_tank_idle");
  } else if(common_scripts\utility::flag("abrams_stop_for_city_fight")) {
    var_0 thread common_scripts\utility::play_loop_sound_on_entity("bog_b_m1a1_tank_idle");
    common_scripts\utility::flag_wait("abrams_start_moving_after_city_fight");
    var_0 thread common_scripts\utility::stop_loop_sound_on_entity("bog_b_m1a1_tank_idle");
    common_scripts\utility::flag_clear("abrams_stop_for_city_fight");
    common_scripts\utility::flag_clear("abrams_start_moving_after_city_fight");
  } else if(common_scripts\utility::flag("abrams_stop_wait_for_player")) {
    var_0 thread common_scripts\utility::play_loop_sound_on_entity("bog_b_m1a1_tank_idle");
    common_scripts\utility::flag_wait("truck_crush_player_in_position");
    var_0 thread common_scripts\utility::stop_loop_sound_on_entity("bog_b_m1a1_tank_idle");
    common_scripts\utility::flag_clear("abrams_stop_wait_for_player");
  }
}

aud_final_wall_exp_debris() {
  soundscripts\_snd_playsound::snd_play_at("bog_b_final_wall_exp_debris", (4779, -3910, -16));
}

aud_final_tank_exp_debris() {
  soundscripts\_snd_playsound::snd_play_at("final_tank_exp_debris", (4859, -4353, 76));
}

set_exterior_streamed_ambience(var_0) {
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("exterior_alley", var_0, 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("exterior_field", var_0, 0.8);
  soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("exterior_city", var_0, 0.8);
}