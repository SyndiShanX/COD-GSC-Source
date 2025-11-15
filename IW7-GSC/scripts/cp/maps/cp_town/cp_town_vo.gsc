/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_town\cp_town_vo.gsc
**************************************************/

town_vo_init() {
  level.recent_vo = [];
  level.announcer_vo_playing = 0;
  level.elvira_playing = 0;
  level.player_vo_playing = 0;
  level.level_specific_vo_callouts = ::rave_vo_callouts;
  level.pap_vo_approve_func = ::is_vo_in_pap;
  level.get_alias_2d_func = ::scripts\cp\cp_vo::get_alias_2d_version;
  level.spawn_vo_func = ::town_starting_vo;
  level thread rave_vo_callouts();
  level.dialogue_playing_queue = [];
  level thread update_vo_cooldown_list();
  level waittill("activate_power");
}

rave_vo_callouts(param_00) {
  level.vo_functions["rave_announcer_vo"] = ::announcer_vo;
  level.vo_functions["rave_ww_vo"] = ::ww_vo;
  level.vo_functions["zmb_powerup_vo"] = ::play_vo_for_powerup;
  level.vo_functions["zmb_afterlife_vo"] = ::afterlife_vo_handler;
  level.vo_functions["rave_pap_vo"] = ::pap_vo_handler;
  level.vo_functions["rave_dialogue_vo"] = ::dialogue_vo_handler;
  level.vo_functions["elvira_player_dialogue_vo"] = ::one_to_one_dialogue_vo_handler;
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

one_to_one_dialogue_vo_handler(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = self;
  var_08 = isDefined(level.vo_alias_data[param_00]);
  var_09 = 0;
  level.pause_nag_vo = 1;
  scripts\cp\cp_vo::set_vo_system_busy(1);
  var_0A = scripts\cp\cp_music_and_dialog::getarrayofdialoguealiases(param_00, var_08);
  level.dialogue_arr = var_0A;
  while(scripts\cp\cp_music_and_dialog::vo_is_playing()) {
    wait(0.1);
  }

  level.elvira_playing = 1;
  foreach(var_13, var_0C in var_0A) {
    var_0D = 0;
    var_0E = undefined;
    var_09 = 0;
    if(var_08 && isDefined(level.vo_alias_data[var_0C].dialogueprefix)) {
      var_0E = level.vo_alias_data[var_0C].dialogueprefix;
      var_0F = var_0E + var_0C;
    } else if(issubstr(var_0C, "ww_") || issubstr(var_0C, "el_")) {
      var_0F = var_0C;
      var_0D = 1;
      var_09 = 1;
    } else {
      continue;
    }

    if((isDefined(var_0E) && var_07.vo_prefix == var_0E) || var_0D || getdvarint("scr_solo_dialogue", 0) == 1) {
      var_10 = scripts\cp\cp_vo::create_vo_data(var_0F, param_03, param_05, param_06);
      var_07 scripts\cp\cp_vo::set_vo_system_playing(1);
      var_07 scripts\cp\cp_vo::set_vo_currently_playing(var_10);
      if(isDefined(var_10.alias) && scripts\engine\utility::istrue(var_09)) {
        if(isDefined(level.elvira)) {
          scripts\engine\utility::play_sound_in_space(var_10.alias, level.elvira.origin, 0, level.elvira);
          var_11 = scripts\cp\cp_vo::get_sound_length(var_10.alias);
          var_12 = scripts\engine\utility::getstruct("elvira_talk", "script_noteworthy");
          var_12 thread scripts\cp\maps\cp_town\cp_town_elvira::elvira_talks(var_11, 1);
          wait(scripts\cp\cp_vo::get_sound_length(var_10.alias));
        } else {
          var_07 scripts\cp\cp_vo::play_vo(var_10);
        }
      } else {
        var_07 scripts\cp\cp_vo::play_vo(var_10);
      }

      var_07 scripts\cp\cp_vo::pause_between_vo(var_10);
      var_07 scripts\cp\cp_vo::unset_vo_currently_playing();
    }

    scripts\engine\utility::waitframe();
  }

  var_07 scripts\cp\cp_vo::set_vo_system_playing(0);
  scripts\cp\cp_vo::set_vo_system_busy(0);
  level.pause_nag_vo = 0;
  level.elvira_playing = 0;
  level notify("dialogue_done", param_00);
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
    announcer_vo("el_" + param_00, "rave_ww_vo", "highest", 60, 0, 0, 1);
    if(randomint(100) > 50) {
      announcer_vo("ww_powerup_elvira", "rave_ww_vo", "highest", 60, 0, 0, 1);
      wait(3);
    }
  } else {
    announcer_vo("ww_" + param_00, "rave_ww_vo", "highest", 60, 0, 0, 1);
  }

  param_00 = convert_alias_string_for_players(param_00);
  foreach(var_08 in level.players) {
    if(isDefined(var_08) && isalive(var_08)) {
      var_08 thread scripts\cp\cp_vo::try_to_play_vo(param_00, "rave_comment_vo");
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
  level waittill("wave_start_sound_done");
  if(level.players.size > 1) {
    level thread scripts\cp\cp_vo::try_to_play_vo("ww_intro", "rave_ww_vo", "highest", 30, 0, 0, 1, 100);
    return;
  }

  if(level.players[0].vo_prefix == "p5_") {
    if(randomint(100) > 50) {
      level.players[0] thread scripts\cp\cp_vo::try_to_play_vo("ww_intro_p5_solo", "rave_ww_vo", "highest", 30, 0, 0, 1, 100);
      return;
    }

    level.players[0] thread scripts\cp\cp_vo::try_to_play_vo("ww_intro" + level.players[0].vo_suffix, "rave_ww_vo", "highest", 30, 0, 0, 1, 100);
    return;
  }

  level.players[0] thread scripts\cp\cp_vo::try_to_play_vo("ww_intro" + level.players[0].vo_suffix, "rave_ww_vo", "highest", 30, 0, 0, 1, 100);
}

power_nag() {
  level endon("game_ended");
  level endon("found_power");
  for(;;) {
    level waittill("wave_start_sound_done");
    if(level.wave_num > 0 && level.wave_num % 3 == 0) {
      scripts\cp\cp_vo::try_to_play_vo_on_all_players("nag_activate_power");
      continue;
    }
  }
}

purchase_area_vo(param_00, param_01) {
  if(!isDefined(level.played_area_vos)) {
    level.played_area_vos = [];
  }

  if(scripts\engine\utility::istrue(level.open_sesame)) {
    return;
  }

  if(scripts\engine\utility::istrue(param_01.played_vo)) {
    param_01.played_vo = 0;
    return;
  }

  param_01.played_vo = 1;
  if(randomint(100) < 50) {
    level thread scripts\cp\cp_vo::try_to_play_vo("ww_access_area", "rave_announcer_vo", "highest", 70, 0, 0, 1);
  } else {
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area_misc", "rave_comment_vo", "low", 10, 0, 2, 1, 40);
  }

  param_01.played_vo = 1;
}

town_starting_vo() {
  scripts\engine\utility::flag_wait("intro_gesture_done");
  if(scripts\cp\cp_music_and_dialog::can_play_dialogue_system()) {
    var_00 = randomint(100);
    if(var_00 <= 30) {
      scripts\cp\cp_vo::try_to_play_vo_on_all_players("spawn_team_first");
      level thread willard_intro_vo();
      return;
    }

    var_01 = scripts\engine\utility::random(level.players);
    if(isDefined(var_01.vo_prefix)) {
      switch (var_01.vo_prefix) {
        case "p1_":
          if(randomint(100) > 50) {
            level thread scripts\cp\cp_vo::try_to_play_vo("sally_spawn_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["sally_spawn_1"] = 1;
          } else {
            level thread scripts\cp\cp_vo::try_to_play_vo("sally_spawn_alt_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["sally_spawn_alt_1"] = 1;
          }
          break;

        case "p2_":
          if(randomint(100) > 50) {
            level thread scripts\cp\cp_vo::try_to_play_vo("pdex_spawn_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["pdex_spawn_1"] = 1;
          } else {
            level thread scripts\cp\cp_vo::try_to_play_vo("pdex_spawn_alt_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["pdex_spawn_alt_1"] = 1;
          }
          break;

        case "p3_":
          if(randomint(100) > 50) {
            level thread scripts\cp\cp_vo::try_to_play_vo("andre_spawn_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["andre_spawn_1"] = 1;
          } else {
            level thread scripts\cp\cp_vo::try_to_play_vo("andre_spawn_alt_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["andre_spawn_alt_1"] = 1;
          }
          break;

        case "p4_":
          if(randomint(100) > 50) {
            level thread scripts\cp\cp_vo::try_to_play_vo("aj_spawn_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["aj_spawn_1"] = 1;
          } else {
            level thread scripts\cp\cp_vo::try_to_play_vo("aj_spawn_alt_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["aj_spawn_alt_1"] = 1;
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
    foreach(var_03 in level.players) {
      if(var_03 issplitscreenplayer()) {
        if(var_03 issplitscreenplayerprimary()) {
          if(isDefined(var_03.vo_prefix)) {
            if(var_03.vo_prefix == "p5_") {
              var_03 multiple_elviras_intro_vo(var_03);
            } else {
              var_03 thread scripts\cp\cp_vo::try_to_play_vo("spawn_team_first", "rave_comment_vo", "high", 20, 0, 0, 1);
            }
          }
        }

        continue;
      }

      if(isDefined(var_03.vo_prefix)) {
        if(var_03.vo_prefix == "p5_") {
          var_03 multiple_elviras_intro_vo(var_03);
          continue;
        }

        var_03 thread scripts\cp\cp_vo::try_to_play_vo("spawn_team_first", "rave_comment_vo", "high", 20, 0, 0, 1);
      }
    }

    level thread willard_intro_vo();
    return;
  }

  level.players[0] thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(["spawn_intro", "spawn_solo_first"]), "rave_comment_vo", "high", 20, 0, 0, 1);
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
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("spawn_intro", "town_comment_vo");
      break;

    case 2:
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("p5_players_3", "town_comment_vo");
      break;

    case 3:
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("p5_players_3", "town_comment_vo");
      break;

    case 4:
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("p5_players_4", "town_comment_vo");
      break;

    default:
      break;
  }
}