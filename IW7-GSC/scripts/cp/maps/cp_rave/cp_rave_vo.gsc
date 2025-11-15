/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_rave\cp_rave_vo.gsc
**************************************************/

rave_vo_init() {
  level.recent_vo = [];
  level.announcer_vo_playing = 0;
  level.player_vo_playing = 0;
  level.spawn_vo_func = ::starting_vo;
  level.level_specific_vo_callouts = ::rave_vo_callouts;
  level.pap_vo_approve_func = ::is_vo_in_pap;
  level.get_alias_2d_func = ::scripts\cp\cp_vo::get_alias_2d_version;
  level.rave_vo_approve_func = ::is_vo_in_rave;
  level thread rave_vo_callouts();
  level.dialogue_playing_queue = [];
  level thread update_vo_cooldown_list();
  level waittill("activate_power");
  level thread volume_activation_check_init();
}

rave_vo_callouts(param_00) {
  level.vo_functions["rave_announcer_vo"] = ::announcer_vo;
  level.vo_functions["rave_ww_vo"] = ::ww_vo;
  level.vo_functions["zmb_powerup_vo"] = ::play_vo_for_powerup;
  level.vo_functions["zmb_afterlife_vo"] = ::afterlife_vo_handler;
  level.vo_functions["rave_pap_vo"] = ::pap_vo_handler;
  level.vo_functions["rave_mode_vo"] = ::rave_vo_handler;
  level.vo_functions["rave_intro_dialogue_vo"] = ::codxp_dialogue_vo_handler;
  level.vo_functions["rave_dialogue_vo"] = ::dialogue_vo_handler;
  level.vo_functions["rave_kevin_smith_dialogue_vo"] = ::one_to_one_dialogue_vo_handler;
  level.vo_functions["rave_ks_vo"] = ::ks_vo_handler;
  level.vo_functions["rave_memory_vo"] = ::memory_vo_handler;
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

one_to_one_dialogue_vo_handler(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  var_08 = self;
  var_09 = isDefined(level.vo_alias_data[param_00]);
  scripts\cp\cp_vo::set_vo_system_busy(1);
  var_0A = scripts\cp\cp_music_and_dialog::getarrayofdialoguealiases(param_00, var_09);
  level.dialogue_arr = var_0A;
  while(scripts\cp\cp_music_and_dialog::vo_is_playing()) {
    wait(0.1);
  }

  if(scripts\engine\utility::istrue(param_07)) {
    var_08 play_special_vo_dialogue(var_0A, var_09, param_03, param_05, param_06, param_07);
    scripts\engine\utility::waitframe();
  } else {
    foreach(var_13, var_0C in var_0A) {
      var_0D = 0;
      var_0E = undefined;
      if(var_09 && isDefined(level.vo_alias_data[var_0C].dialogueprefix)) {
        var_0E = level.vo_alias_data[var_0C].dialogueprefix;
        var_0F = var_0E + var_0C;
      } else if(issubstr(var_0C, "ww_") || issubstr(var_0C, "ks_")) {
        var_0F = var_0C;
        var_0D = 1;
      } else {
        continue;
      }

      foreach(var_08 in level.players) {
        if((isDefined(var_0E) && var_08.vo_prefix == var_0E) || var_0D || getdvarint("scr_solo_dialogue", 0) == 1) {
          var_11 = scripts\cp\cp_vo::create_vo_data(var_0F, param_03, param_05, param_06);
          var_08 scripts\cp\cp_vo::set_vo_system_playing(1);
          var_08 scripts\cp\cp_vo::set_vo_currently_playing(var_11);
          var_08 scripts\cp\cp_vo::play_vo(var_11);
          var_08 scripts\cp\cp_vo::pause_between_vo(var_11);
          var_08 scripts\cp\cp_vo::unset_vo_currently_playing();
          break;
        }
      }

      scripts\engine\utility::waitframe();
    }
  }

  foreach(var_08 in level.players) {
    var_08 scripts\cp\cp_vo::set_vo_system_playing(0);
  }

  scripts\cp\cp_vo::set_vo_system_busy(0);
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

codxp_dialogue_vo_handler(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  wait(6);
  scripts\cp\cp_vo::set_vo_system_busy(1);
  foreach(var_08 in level.players) {
    var_08 thread play_ww_on_each_player(var_08);
  }

  scripts\engine\utility::flag_wait("dialogue_done");
  scripts\cp\cp_vo::set_vo_system_busy(0);
}

play_ww_on_each_player(param_00) {
  param_00 playwillardvo("ww_spawn_alt_first_1", param_00);
  param_00 playplayervo("plr_spawn_alt_first_2", param_00);
  param_00 playwillardvo("ww_spawn_alt_first_6", param_00);
  if(param_00.vo_prefix == "p4_") {
    param_00 playplayervo("plr_spawn_alt_first_7", param_00);
  } else {
    param_00 playlocalsound("p4_spawn_alt_first_7");
    wait(scripts\cp\cp_vo::get_sound_length("p4_spawn_alt_first_7"));
  }

  param_00 playwillardvo("ww_spawn_alt_first_8", param_00);
  scripts\engine\utility::flag_set("dialogue_done");
}

playwillardvo(param_00, param_01) {
  param_01 playlocalsound(param_00);
  wait(scripts\cp\cp_vo::get_sound_length(param_00));
}

playplayervo(param_00, param_01) {
  if(isDefined(param_01)) {
    if(isDefined(param_01.vo_prefix)) {
      param_01 playlocalsound(param_01.vo_prefix + param_00);
    }
  }

  wait(scripts\cp\cp_vo::get_sound_length(param_01.vo_prefix + param_00));
}

pap_vo_handler(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(!scripts\cp\cp_vo::should_append_player_prefix(param_00)) {
    thread scripts\cp\cp_vo::play_vo_on_player(param_00, param_02, param_03, param_04, param_05, param_06, param_00);
    return;
  }

  var_07 = self.vo_prefix + param_00;
  thread scripts\cp\cp_vo::play_vo_on_player(var_07, param_02, param_03, param_04, param_05, param_06, param_00);
}

rave_vo_handler(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
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

ww_vo(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
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
  foreach(var_09 in level.players) {
    if(!isDefined(var_09)) {
      continue;
    }

    if(var_09 issplitscreenplayer() && !var_09 issplitscreenplayerprimary()) {
      continue;
    }

    var_0A = scripts\cp\cp_vo::create_vo_data(param_00, param_03, param_05, param_06);
    var_09 thread scripts\cp\cp_vo::play_vo_system(var_0A, param_07);
  }

  wait(scripts\cp\cp_vo::get_sound_length(param_00));
  foreach(var_09 in level.players) {
    var_09 scripts\cp\cp_vo::set_vo_system_playing(0);
  }

  scripts\cp\cp_vo::set_vo_system_busy(0);
}

announcer_vo(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  play_announcer_vo(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07);
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

is_vo_in_rave(param_00) {
  if(isDefined(level.vo_alias_data[param_00].rave_approval)) {
    if(level.vo_alias_data[param_00].rave_approval == 1) {
      return 1;
    }

    return 0;
  }

  return 0;
}

minigame_vo(param_00, param_01) {
  if(!isDefined(param_00)) {
    var_02 = scripts\cp\utility::get_array_of_valid_players();
    if(var_02.size < 1) {
      return;
    }

    param_00 = var_02[0];
  }

  if(self == param_00) {
    if(!isDefined(param_00.recent_vo)) {
      self.recent_vo = [];
      thread update_self_vo_cooldown_list();
    }

    if(scripts\engine\utility::istrue(param_00.recent_vo[param_01])) {
      return;
    }

    param_00 add_to_recent_player_vo(param_01);
    play_minigame_vo(param_00, param_01);
    return;
  }

  if(scripts\engine\utility::istrue(level.recent_vo[param_01])) {
    return;
  }

  add_to_recent_vo(param_01);
  play_minigame_vo(param_00, param_01);
}

play_minigame_vo(param_00, param_01, param_02) {
  if(!soundexists(param_01)) {
    wait(0.1);
    return;
  }

  param_00 playlocalsound(param_01);
}

play_announcer_vo(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  level.announcer_vo_playing = 1;
  if(isDefined(param_07)) {
    param_00 = param_07 + param_00;
  }

  if(!soundexists(param_00)) {
    wait(0.1);
    level.announcer_vo_playing = 0;
    return;
  }

  foreach(var_0A in level.players) {
    if(!isDefined(var_0A)) {
      continue;
    }

    if(var_0A issplitscreenplayer() && !var_0A issplitscreenplayerprimary()) {
      continue;
    }

    if(isDefined(param_08) && var_0A.vo_prefix == param_08) {
      var_0B = param_08 + param_00;
      if(soundexists(var_0B)) {
        var_0A playlocalsound(var_0B);
      }

      continue;
    } else {
      var_0C = scripts\cp\cp_vo::create_vo_data(param_00, param_03, param_05, param_06);
      var_0A thread scripts\cp\cp_vo::play_vo_system(var_0C);
    }
  }

  wait(scripts\cp\cp_vo::get_sound_length(param_00));
  foreach(var_0A in level.players) {
    var_0A scripts\cp\cp_vo::set_vo_system_playing(0);
  }

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
  announcer_vo("ww_" + param_00, "rave_ww_vo", "highest", 60, 0, 0, 1);
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

player_volume_activation_check_init() {
  for(;;) {
    level waittill("volume_activated", var_00);
    switch (var_00) {
      case "moon":
        break;

      case "mars_3":
      case "europa_tunnel":
      case "arcade":
      case "moon_rocket_space":
        break;
    }
  }
}

volume_activation_check_init() {
  for(;;) {
    level waittill("volume_activated", var_00);
    switch (var_00) {
      case "moon":
        foreach(var_02 in level.players) {
          var_02 thread scripts\cp\cp_vo::add_to_nag_vo("nag_board_windows", "rave_comment_vo", 180, 60, 20, 1);
        }
        break;

      case "mars_3":
      case "arcade":
      case "moon_rocket_space":
        break;

      case "europa_tunnel":
        break;
    }
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

  switch (param_00) {
    case "front_gate":
      if(!isDefined(level.played_area_vos[param_00])) {
        level.played_area_vos[param_00] = 1;
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_door_cabins", "rave_comment_vo", "low", 10, 0, 2, 0, 40);
      } else {
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "rave_comment_vo", "low", 10, 0, 2, 1, 40);
      }
      break;

    case "camper_to_lake":
    case "lake_shore":
    case "cabin_to_lake":
      if(!isDefined(level.played_area_vos[param_00])) {
        level.played_area_vos[param_00] = 1;
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_door_lake", "rave_comment_vo", "low", 10, 0, 2, 0, 40);
      } else {
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "rave_comment_vo", "low", 10, 0, 2, 1, 40);
      }

      break;

    case "obstacle_course":
      if(!isDefined(level.played_area_vos[param_00])) {
        level.played_area_vos[param_00] = 1;
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_door_obcourse", "rave_comment_vo", "low", 10, 0, 2, 0, 40);
      } else {
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "rave_comment_vo", "low", 10, 0, 2, 1, 40);
      }

      break;

    case "cave":
      if(!isDefined(level.played_area_vos[param_00])) {
        level.played_area_vos[param_00] = 1;
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_door_caves", "rave_comment_vo", "low", 10, 0, 2, 0, 40);
      } else {
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "rave_comment_vo", "low", 10, 0, 2, 1, 40);
      }
      break;

    case "rave":
      if(!isDefined(level.played_area_vos[param_00])) {
        level.played_area_vos[param_00] = 1;
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area_rave", "rave_comment_vo", "low", 10, 0, 2, 0, 40);
      } else {
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "rave_comment_vo", "low", 10, 0, 2, 1, 40);
      }
      break;

    default:
      if(level.players.size > 1) {
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "rave_comment_vo", "low", 10, 0, 2, 1, 40);
      } else {
        level.players[0] thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "rave_comment_vo", "low", 10, 0, 2, 1, 40);
      }
      break;
  }
}

starting_vo() {
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
            level thread scripts\cp\cp_vo::try_to_play_vo("spawn_team_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["spawn_team_1_1"] = 1;
          } else {
            level thread scripts\cp\cp_vo::try_to_play_vo("spawn_cabin_20_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["spawn_cabin_20_1"] = 1;
          }
          break;

        case "p4_":
          if(randomint(100) > 50) {
            level thread scripts\cp\cp_vo::try_to_play_vo("spawn_alt_2_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["spawn_alt_2_1"] = 1;
          } else {
            level thread scripts\cp\cp_vo::try_to_play_vo("spawn_alt_3_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["spawn_alt_3_1"] = 1;
          }
          break;

        case "p3_":
          if(randomint(100) > 50) {
            level thread scripts\cp\cp_vo::try_to_play_vo("spawn_alt_4_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["spawn_alt_4_1"] = 1;
          } else {
            level thread scripts\cp\cp_vo::try_to_play_vo("spawn_cabin_18_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["spawn_cabin_18_1"] = 1;
          }
          break;

        case "p2_":
          if(randomint(100) > 50) {
            level thread scripts\cp\cp_vo::try_to_play_vo("spawn_alt_5_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["spawn_alt_5_1"] = 1;
          } else {
            level thread scripts\cp\cp_vo::try_to_play_vo("spawn_cabin_19_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
            level.completed_dialogues["spawn_cabin_19_1"] = 1;
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
              var_03 multiple_kevinsmith_intro_vo(var_03);
            } else {
              var_03 thread scripts\cp\cp_vo::try_to_play_vo("spawn_team_first", "rave_comment_vo", "high", 20, 0, 0, 1);
            }
          }
        }

        continue;
      }

      if(isDefined(var_03.vo_prefix)) {
        if(var_03.vo_prefix == "p5_") {
          var_03 multiple_kevinsmith_intro_vo(var_03);
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

multiple_kevinsmith_intro_vo(param_00) {
  if(!isDefined(level.special_character_count)) {
    return;
  }

  if(!isDefined(param_00)) {
    return;
  }

  switch (level.special_character_count) {
    case 1:
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("spawn_team_first", "rave_comment_vo");
      break;

    case 2:
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("extra_ksmith_2", "rave_comment_vo");
      break;

    case 3:
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("extra_ksmith_3", "rave_comment_vo");
      break;

    case 4:
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("extra_ksmith_4", "rave_comment_vo");
      break;

    default:
      break;
  }
}

memory_vo_handler(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self endon("disconnect");
  var_07 = self;
  if(!isDefined(var_07)) {
    return;
  }

  if(var_07 issplitscreenplayer() && !var_07 issplitscreenplayerprimary()) {
    return;
  }

  var_08 = scripts\cp\cp_vo::create_vo_data(param_00, param_03, param_05, param_06);
  var_07 scripts\cp\cp_vo::set_vo_system_playing(1);
  var_07 scripts\cp\cp_vo::set_vo_currently_playing(var_08);
  var_07 scripts\cp\cp_vo::play_vo(var_08);
  var_07 scripts\cp\cp_vo::pause_between_vo(var_08);
  var_07 scripts\cp\cp_vo::set_vo_system_playing(0);
  var_07 scripts\cp\cp_vo::unset_vo_currently_playing();
}

ks_vo_handler(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  while(scripts\cp\cp_vo::is_vo_system_busy()) {
    wait(0.1);
  }

  if(scripts\engine\utility::istrue(param_04)) {
    foreach(var_08 in level.players) {
      var_08 scripts\cp\cp_vo::set_vo_system_playing(0);
      var_08.vo_system_playing_vo = 0;
    }
  }

  scripts\cp\cp_vo::set_vo_system_busy(1);
  while(scripts\cp\cp_music_and_dialog::vo_is_playing()) {
    wait(0.1);
  }

  play_ks_vo(param_00, param_01, param_02, param_03, param_04, param_05, param_06);
  scripts\cp\cp_vo::set_vo_system_busy(0);
  foreach(var_08 in level.players) {
    var_08 scripts\cp\cp_vo::set_vo_system_playing(0);
  }
}

play_ks_vo(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = scripts\cp\cp_vo::create_vo_data(param_00, param_03, param_05, param_06);
  if(self == level) {
    foreach(var_09 in level.players) {
      if(!isDefined(var_09)) {
        continue;
      }

      if(var_09 issplitscreenplayer() && !var_09 issplitscreenplayerprimary()) {
        continue;
      }

      if(isDefined(level.survivor)) {
        if(isDefined(level.boat_survivor)) {
          scripts\engine\utility::play_sound_in_space(param_00, level.boat_survivor.origin, 0, level.boat_survivor);
        } else {
          scripts\engine\utility::play_sound_in_space(param_00, level.survivor.origin, 0, level.survivor);
        }

        continue;
      }

      if(isDefined(level.boat_survivor)) {
        scripts\engine\utility::play_sound_in_space(param_00, level.boat_survivor.origin, 0, level.boat_survivor);
        continue;
      }

      var_09 thread scripts\cp\cp_vo::play_vo_system(var_07);
    }

    wait(scripts\cp\cp_vo::get_sound_length(param_00));
    return;
  }

  if(isDefined(level.survivor)) {
    if(isDefined(level.boat_survivor)) {
      scripts\engine\utility::play_sound_in_space(param_00, level.boat_survivor.origin, 0, level.boat_survivor);
    } else {
      scripts\engine\utility::play_sound_in_space(param_00, level.survivor.origin, 0, level.survivor);
    }
  } else if(isDefined(level.boat_survivor)) {
    scripts\engine\utility::play_sound_in_space(param_00, level.boat_survivor.origin, 0, level.boat_survivor);
  } else if(isplayer(self)) {
    if(isDefined(self.vo_prefix)) {
      thread scripts\cp\cp_vo::play_vo_system(var_07);
    }
  }

  wait(scripts\cp\cp_vo::get_sound_length(param_00));
}