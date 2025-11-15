/****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_final\cp_final_vo.gsc
****************************************************/

final_vo_init() {
  level.recent_vo = [];
  level.announcer_vo_playing = 0;
  level.elvira_playing = 0;
  level.player_vo_playing = 0;
  level.level_specific_vo_callouts = ::rave_vo_callouts;
  level.pap_vo_approve_func = ::is_vo_in_pap;
  level.get_alias_2d_func = ::scripts\cp\cp_vo::get_alias_2d_version;
  level.spawn_vo_func = ::final_starting_vo;
  level thread rave_vo_callouts();
  level.dialogue_playing_queue = [];
  level thread update_vo_cooldown_list();
  level waittill("activate_power");
}

rave_vo_callouts(param_00) {
  level.vo_functions["final_announcer_vo"] = ::announcer_vo;
  level.vo_functions["final_ww_vo"] = ::ww_vo;
  level.vo_functions["zmb_powerup_vo"] = ::play_vo_for_powerup;
  level.vo_functions["zmb_afterlife_vo"] = ::afterlife_vo_handler;
  level.vo_functions["rave_pap_vo"] = ::pap_vo_handler;
  level.vo_functions["rave_dialogue_vo"] = ::dialogue_vo_handler;
  level.vo_functions["final_backstory_vo"] = ::backstory_vo_handler;
}

add_to_recent_vo(param_00) {
  level.recent_vo[param_00] = get_recent_vo_time(param_00);
}

add_to_recent_player_vo(param_00) {
  self.recent_vo[param_00] = get_recent_vo_time(param_00);
}

get_recent_vo_time(param_00) {
  if(!isDefined(level.vo_alias_data[param_00].cooldown)) {
    return 0;
  }

  return level.vo_alias_data[param_00].cooldown;
}

update_vo_cooldown_list() {
  level endon("game_ended");
  for(;;) {
    foreach(var_02, var_01 in level.recent_vo) {
      if(scripts\engine\utility::istrue(level.recent_vo[var_02])) {
        level.recent_vo[var_02] = level.recent_vo[var_02] - 1;
      }
    }

    wait(1);
  }
}

update_self_vo_cooldown_list() {
  self endon("disconnect");
  for(;;) {
    foreach(var_02, var_01 in self.recent_vo) {
      if(scripts\engine\utility::istrue(self.recent_vo[var_02])) {
        self.recent_vo[var_02] = self.recent_vo[var_02] - 1;
      }
    }

    wait(1);
  }
}

dialogue_vo_handler(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(!scripts\cp\cp_music_and_dialog::can_play_dialogue_system()) {
    return;
  }

  var_08 = isDefined(level.vo_alias_data[param_00]);
  scripts\cp\cp_vo::set_vo_system_busy(1);
  var_09 = scripts\cp\cp_music_and_dialog::getarrayofdialoguealiases(param_00, var_08);
  level.dialogue_arr = var_09;
  while(scripts\cp\cp_music_and_dialog::vo_is_playing()) {
    wait(0.1);
  }

  level.dialogues_playing = 1;
  if(isDefined(level.masterpcinteraction)) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(level.masterpcinteraction);
  }

  if(isDefined(level.backstoryinteraction)) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(level.backstoryinteraction);
  }

  if(scripts\engine\utility::istrue(param_07)) {
    var_0A = self;
    var_0A play_special_vo_dialogue(var_09, var_08, param_03, param_05, param_06);
    scripts\engine\utility::waitframe();
  } else {
    foreach(var_13, var_0C in var_0A) {
      var_0D = 0;
      var_0E = undefined;
      if(var_08 && isDefined(level.vo_alias_data[var_0C].dialogueprefix)) {
        var_0E = level.vo_alias_data[var_0C].dialogueprefix;
        var_0F = var_0E + var_0C;
      } else if(issubstr(var_0C, "ww_") || issubstr(var_0C, "ks_")) {
        var_0F = var_0C;
        var_0D = 1;
      } else {
        continue;
      }

      foreach(var_0A in level.players) {
        if((isDefined(var_0E) && var_0A.vo_prefix == var_0E) || var_0D || getdvarint("scr_solo_dialogue", 0) == 1) {
          var_11 = scripts\cp\cp_vo::create_vo_data(var_0F, param_03, param_05, param_06);
          var_0A scripts\cp\cp_vo::set_vo_system_playing(1);
          var_0A scripts\cp\cp_vo::set_vo_currently_playing(var_11);
          var_0A scripts\cp\cp_vo::play_vo(var_11);
          var_0A scripts\cp\cp_vo::pause_between_vo(var_11);
          var_0A scripts\cp\cp_vo::unset_vo_currently_playing();
          break;
        }
      }

      scripts\engine\utility::waitframe();
    }
  }

  foreach(var_0A in level.players) {
    var_0A scripts\cp\cp_vo::set_vo_system_playing(0);
  }

  level.dialogues_playing = 0;
  if(isDefined(level.masterpcinteraction)) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(level.masterpcinteraction);
  }

  if(isDefined(level.backstoryinteraction)) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(level.backstoryinteraction);
  }

  scripts\cp\cp_vo::set_vo_system_busy(0);
}

play_special_vo_dialogue(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = 0;
  var_07 = "";
  while(var_06 < param_00.size) {
    var_08 = 1;
    var_09 = undefined;
    if(param_01 && isDefined(level.vo_alias_data[param_00[var_06]].dialogueprefix)) {
      var_09 = level.vo_alias_data[param_00[var_06]].dialogueprefix;
      var_07 = var_09 + param_00[var_06];
    } else if(issubstr(param_00[var_06], "ks_")) {
      var_07 = param_00[var_06];
      var_08 = 1;
      if(isDefined(level.survivor)) {
        if(isDefined(level.boat_survivor)) {
          scripts\engine\utility::play_sound_in_space(var_07, level.boat_survivor.origin, 0, level.boat_survivor);
        } else {
          scripts\engine\utility::play_sound_in_space(var_07, level.survivor.origin, 0, level.survivor);
        }

        wait(scripts\cp\cp_vo::get_sound_length(var_07));
      } else if(isDefined(level.boat_survivor)) {
        scripts\engine\utility::play_sound_in_space(var_07, level.boat_survivor.origin, 0, level.boat_survivor);
        wait(scripts\cp\cp_vo::get_sound_length(var_07));
      } else {
        var_0A = scripts\cp\cp_vo::create_vo_data(var_07, param_02, param_03, param_04, param_00[var_06]);
        scripts\cp\cp_vo::play_vo_system(var_0A, param_05);
      }

      var_06++;
      continue;
    } else {
      continue;
      scripts\engine\utility::waitframe();
    }

    if(((isDefined(var_09) && self.vo_prefix == var_09) || var_08 || getdvarint("scr_solo_dialogue", 0) == 1) && !issubstr(var_07, "ks_")) {
      var_0A = scripts\cp\cp_vo::create_vo_data(var_07, param_02, param_03, param_04, param_00[var_06]);
      scripts\cp\cp_vo::play_vo_system(var_0A);
      var_06++;
    }

    scripts\engine\utility::waitframe();
  }
}

pap_vo_handler(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(!scripts\cp\cp_vo::should_append_player_prefix(param_00)) {
    thread scripts\cp\cp_vo::play_vo_on_player(param_00, param_02, param_03, param_04, param_05, param_06, param_00);
    return;
  }

  var_07 = self.vo_prefix + param_00;
  thread scripts\cp\cp_vo::play_vo_on_player(var_07, param_02, param_03, param_04, param_05, param_06, param_00);
}

afterlife_vo_handler(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(!scripts\cp\cp_vo::should_append_player_prefix(param_00)) {
    thread scripts\cp\cp_vo::play_vo_on_player(param_00, param_02, param_03, param_04, param_05, param_06, param_00);
    return;
  }

  var_07 = self.vo_prefix + param_00;
  thread scripts\cp\cp_vo::play_vo_on_player(var_07, param_02, param_03, param_04, param_05, param_06, param_00);
}

ww_vo(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  level endon(param_00 + "_timed_out");
  level thread scripts\cp\cp_vo::timeoutvofunction(param_00, param_03);
  while(scripts\cp\cp_vo::is_vo_system_busy()) {
    wait(0.1);
  }

  scripts\cp\cp_vo::set_vo_system_busy(1);
  while(scripts\cp\cp_music_and_dialog::vo_is_playing()) {
    wait(0.1);
  }

  level notify(param_00 + "_about_to_play");
  foreach(var_08 in level.players) {
    if(!isDefined(var_08)) {
      continue;
    }

    if(var_08 issplitscreenplayer() && !var_08 issplitscreenplayerprimary()) {
      continue;
    }

    var_09 = scripts\cp\cp_vo::create_vo_data(param_00, param_03, param_05, param_06);
    var_08 thread scripts\cp\cp_vo::play_vo_system(var_09);
  }

  wait(scripts\cp\cp_vo::get_sound_length(param_00));
  foreach(var_08 in level.players) {
    var_08 scripts\cp\cp_vo::set_vo_system_playing(0);
  }

  scripts\cp\cp_vo::set_vo_system_busy(0);
}

announcer_vo(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  play_announcer_vo(param_00, param_01, param_02, param_03, param_04, param_05, param_06);
}

is_vo_in_pap(param_00) {
  if(isDefined(level.vo_alias_data[param_00].pap_approval)) {
    if(level.vo_alias_data[param_00].pap_approval == 1) {
      return 0;
    }

    return 1;
  }

  return 1;
}

play_announcer_vo(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(scripts\cp\cp_vo::is_vo_system_busy()) {
    wait(5);
    if(scripts\cp\cp_vo::is_vo_system_busy()) {
      return;
    }
  }

  if(scripts\cp\cp_vo::func_9D14()) {
    return;
  }

  level.announcer_vo_playing = 1;
  scripts\cp\cp_vo::set_vo_system_busy(1);
  if(isDefined(param_07)) {
    param_00 = param_07 + param_00;
  }

  if(!soundexists(param_00)) {
    wait(0.1);
    level.announcer_vo_playing = 0;
    return;
  }

  foreach(var_09 in level.players) {
    if(!isDefined(var_09)) {
      continue;
    }

    if(var_09 issplitscreenplayer() && !var_09 issplitscreenplayerprimary()) {
      continue;
    } else {
      var_0A = scripts\cp\cp_vo::create_vo_data(param_00, param_03, param_05, param_06);
      var_09 thread scripts\cp\cp_vo::play_vo_system(var_0A);
    }
  }

  wait(scripts\cp\cp_vo::get_sound_length(param_00));
  foreach(var_09 in level.players) {
    var_09 scripts\cp\cp_vo::set_vo_system_playing(0);
  }

  scripts\cp\cp_vo::set_vo_system_busy(0);
  special_vo_notify_watcher(param_00);
  level.announcer_vo_playing = 0;
}

special_vo_notify_watcher(param_00) {
  if(param_00 == "dj_jingle_intro") {
    level notify("jukebox_start");
  }
}

play_vo_for_powerup(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  wait(0.5);
  if(level.script == "cp_town") {
    announcer_vo("el_" + param_00, "final_ww_vo", "highest", 60, 0, 0, 1);
    if(randomint(100) > 50) {
      announcer_vo("ww_powerup_elvira", "final_ww_vo", "highest", 60, 0, 0, 1);
      wait(3);
    }
  } else {
    announcer_vo("ww_" + param_00, "final_ww_vo", "highest", 60, 0, 0, 1);
  }

  param_00 = convert_alias_string_for_players(param_00);
  foreach(var_08 in level.players) {
    if(isDefined(var_08) && isalive(var_08)) {
      var_08 thread scripts\cp\cp_vo::try_to_play_vo(param_00, "final_comment_vo");
    }
  }
}

convert_alias_string_for_players(param_00) {
  switch (param_00) {
    case "powerup_carpenter":
    case "powerup_maxammo":
    case "powerup_instakill":
    case "powerup_nuke":
    case "powerup_firesale":
      return param_00;

    case "powerup_doublemoney":
      return "powerup_2xmoney";

    case "powerup_infiniteammo":
      return "powerup_ammo";

    case "powerup_infinitegrenades":
      return "powerup_grenade";

    default:
      return param_00;
  }
}

willard_intro_vo() {
  level endon("game_ended");
  level scripts\engine\utility::waittill_any_3("regular_wave_starting", "event_wave_starting");
  if(scripts\engine\utility::istrue(level.directors_cut_is_activated)) {
    level thread scripts\cp\cp_vo::try_to_play_vo("ww_zmb_dc_intro", "zmb_ww_vo", "highest", 30, 0, 0, 1, 100);
    return;
  }

  if(level.players.size > 1) {
    level thread scripts\cp\cp_vo::try_to_play_vo("ww_intro", "final_ww_vo", "highest", 30, 0, 0, 1, 100);
    return;
  }

  if(level.players[0].vo_prefix == "p5_") {
    if(randomint(100) > 50) {
      level.players[0] thread scripts\cp\cp_vo::try_to_play_vo("ww_intro_p5_solo", "final_ww_vo", "highest", 30, 0, 0, 1, 100);
      return;
    }

    level.players[0] thread scripts\cp\cp_vo::try_to_play_vo("ww_intro" + level.players[0].vo_suffix, "final_ww_vo", "highest", 30, 0, 0, 1, 100);
    return;
  }

  level.players[0] thread scripts\cp\cp_vo::try_to_play_vo("ww_intro" + level.players[0].vo_suffix, "final_ww_vo", "highest", 30, 0, 0, 1, 100);
}

power_nag() {
  level endon("game_ended");
  level endon("found_power");
  var_00 = 0;
  for(;;) {
    level waittill("wave_start_sound_done");
    if(level.wave_num > 0 && level.wave_num % 3 == 0) {
      if(!var_00) {
        var_00 = 1;
        foreach(var_02 in level.players) {
          var_02 thread scripts\cp\cp_vo::add_to_nag_vo("nag_find_pap", "zmb_comment_vo", 200, 200, 3, 1);
        }
      }

      continue;
    }
  }
}

purchase_area_vo(param_00, param_01) {
  if(scripts\engine\utility::istrue(level.open_sesame)) {
    return;
  }

  if(scripts\engine\utility::istrue(param_01.played_vo)) {
    param_01.played_vo = 0;
    return;
  }

  param_01.played_vo = 1;
  if(randomint(100) < 50) {
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "final_comment_vo", "highest", 70, 0, 0, 1);
  }

  param_01.played_vo = 1;
}

final_starting_vo() {
  scripts\engine\utility::flag_wait("intro_gesture_done");
  if(scripts\cp\cp_music_and_dialog::can_play_dialogue_system()) {
    var_00 = randomint(100);
    if(var_00 <= 30) {
      scripts\cp\cp_vo::try_to_play_vo_on_all_players("spawn_team_first");
      foreach(var_02 in level.players) {
        var_03 = scripts\cp\cp_vo::get_sound_length(var_02.vo_prefix + "spawn_team_first");
        wait(var_03);
      }

      level thread willard_intro_vo();
      return;
    }

    var_05 = scripts\engine\utility::random(level.players);
    if(isDefined(var_05.vo_prefix)) {
      switch (var_05.vo_prefix) {
        case "p1_":
          if(randomint(100) > 50) {
            level thread scripts\cp\cp_vo::try_to_play_vo("conv_spawn_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["conv_spawn_1_1"] = 1;
          } else {
            level thread scripts\cp\cp_vo::try_to_play_vo("conv_spawn_alt_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["conv_spawn_alt_1_1"] = 1;
          }
          break;

        case "p2_":
          if(randomint(100) > 50) {
            level thread scripts\cp\cp_vo::try_to_play_vo("conv_spawn_3_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["conv_spawn_3_1"] = 1;
          } else {
            level thread scripts\cp\cp_vo::try_to_play_vo("conv_spawn_alt_3_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["conv_spawn_alt_3_1"] = 1;
          }
          break;

        case "p3_":
          if(randomint(100) > 50) {
            level thread scripts\cp\cp_vo::try_to_play_vo("conv_spawn_alt_2_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["conv_spawn_alt_2_1"] = 1;
          }
          break;

        case "p4_":
          if(randomint(100) > 60) {
            level thread scripts\cp\cp_vo::try_to_play_vo("conv_spawn_2_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["conv_spawn_2_1"] = 1;
          } else {
            var_06 = randomint(100);
            if(var_06 <= 60 && var_06 > 30) {
              level thread scripts\cp\cp_vo::try_to_play_vo("conv_spawn_4_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["conv_spawn_4_1"] = 1;
            } else {
              level thread scripts\cp\cp_vo::try_to_play_vo("conv_spawn_alt_4_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
              level.completed_dialogues["conv_spawn_alt_4_1"] = 1;
            }
          }
          break;

        default:
          break;
      }
    }

    level thread willard_intro_vo();
    return;
  }

  if(level.players.size > 1) {
    foreach(var_08 in level.players) {
      if(var_08 issplitscreenplayer()) {
        if(var_08 issplitscreenplayerprimary()) {
          if(isDefined(var_08.vo_prefix)) {
            if(var_08.vo_prefix == "p5_") {
              var_08 multiple_elviras_intro_vo(var_08);
            } else {
              var_08 thread scripts\cp\cp_vo::try_to_play_vo("spawn_team_first", "final_comment_vo", "high", 20, 0, 0, 1);
            }
          }
        }

        continue;
      }

      if(isDefined(var_08.vo_prefix)) {
        if(var_08.vo_prefix == "p5_") {
          var_08 multiple_elviras_intro_vo(var_08);
          continue;
        }

        var_08 thread scripts\cp\cp_vo::try_to_play_vo("spawn_team_first", "final_comment_vo", "high", 20, 0, 0, 1);
      }
    }

    foreach(var_0B in level.players) {
      var_03 = scripts\cp\cp_vo::get_sound_length(var_0B.vo_prefix + "spawn_team_first");
      wait(var_03);
    }

    level thread willard_intro_vo();
    return;
  }

  var_0D = scripts\engine\utility::random(["spawn_intro", "spawn_solo_first"]);
  level.players[0] thread scripts\cp\cp_vo::try_to_play_vo(var_0D, "final_comment_vo", "high", 20, 0, 0, 1);
  var_03 = scripts\cp\cp_vo::get_sound_length(level.players[0].vo_prefix + var_0D);
  if(isDefined(var_03)) {
    wait(var_03);
  }

  level thread willard_intro_vo();
}

multiple_elviras_intro_vo(param_00) {
  if(!isDefined(level.special_character_count)) {
    return;
  }

  if(!isDefined(param_00)) {
    return;
  }

  switch (level.special_character_count) {
    case 1:
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("spawn_intro", "final_comment_vo");
      break;

    case 2:
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("p5_players_3", "final_comment_vo");
      break;

    case 3:
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("p5_players_3", "final_comment_vo");
      break;

    case 4:
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("p5_players_4", "final_comment_vo");
      break;

    default:
      break;
  }
}

can_play_backstory_vo() {
  if(scripts\engine\utility::istrue(level.started_backstory_dialogue)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(level.dialogues_playing)) {
    return 0;
  }

  return 1;
}

clear_up_all_vo(param_00) {
  foreach(var_02 in level.vo_priority_level) {
    if(isDefined(param_00.vo_system.vo_queue[var_02]) && param_00.vo_system.vo_queue[var_02].size > 0) {
      foreach(var_04 in param_00.vo_system.vo_queue[var_02]) {
        if(isDefined(var_04)) {
          param_00 stoplocalsound(var_04.alias);
        }
      }
    }
  }

  var_07 = undefined;
  if(isDefined(param_00.vo_system)) {
    if(isDefined(param_00.vo_system.vo_currently_playing)) {
      if(isDefined(param_00.vo_system.vo_currently_playing.alias)) {
        var_07 = param_00.vo_system.vo_currently_playing.alias;
      }
    }
  }

  if(isDefined(var_07)) {
    param_00 stoplocalsound(var_07);
  }
}

backstory_vo_handler(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(!can_play_backstory_vo()) {
    return;
  }

  clear_up_all_vo(self);
  scripts\cp\cp_vo::func_C9CB([self]);
  self.started_backstory_dialogue = 1;
  if(isDefined(level.masterpcinteraction)) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(level.masterpcinteraction);
  }

  if(isDefined(level.backstoryinteraction)) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(level.backstoryinteraction);
  }

  var_07 = scripts\cp\cp_vo::create_vo_data(param_00, param_03, param_05, param_06);
  scripts\cp\cp_vo::set_vo_system_playing(1);
  scripts\cp\cp_vo::set_vo_currently_playing(var_07);
  scripts\cp\cp_vo::play_vo(var_07);
  scripts\cp\cp_vo::unset_vo_currently_playing();
  self.started_backstory_dialogue = 0;
  if(isDefined(self.samcrossvoarr)) {
    self.samcrossvoarr = scripts\engine\utility::array_remove(self.samcrossvoarr, param_00);
  }

  if(isDefined(self.backstoryvoarr)) {
    self.backstoryvoarr = scripts\engine\utility::array_remove(self.backstoryvoarr, param_00);
  }

  scripts\cp\cp_vo::func_12BE3([self]);
  if(isDefined(level.masterpcinteraction)) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(level.masterpcinteraction);
  }

  if(isDefined(level.backstoryinteraction)) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(level.backstoryinteraction);
  }
}