/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_rave\cp_rave_vo.gsc
**************************************************/

rave_vo_init() {
  level.recent_vo = [];
  level.announcer_vo_playing = 0;
  level.player_vo_playing = 0;
  level.spawn_vo_func = ::starting_vo;
  level.level_specific_vo_callouts = ::rave_vo_callouts;
  level.pap_vo_approve_func = ::is_vo_in_pap;
  level.get_alias_2d_func = scripts\cp\cp_vo::get_alias_2d_version;
  level.rave_vo_approve_func = ::is_vo_in_rave;
  level thread rave_vo_callouts();
  level.dialogue_playing_queue = [];
  level thread update_vo_cooldown_list();
  level waittill("activate_power");
  level thread volume_activation_check_init();
}

rave_vo_callouts(var_0) {
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

add_to_recent_vo(var_0) {
  level.recent_vo[var_0] = get_recent_vo_time(var_0);
}

add_to_recent_player_vo(var_0) {
  self.recent_vo[var_0] = get_recent_vo_time(var_0);
}

get_recent_vo_time(var_0) {
  if(!isDefined(level.vo_alias_data[var_0].cooldown)) {
    return 0;
  }

  return level.vo_alias_data[var_0].cooldown;
}

update_vo_cooldown_list() {
  level endon("game_ended");
  for(;;) {
    foreach(var_2, var_1 in level.recent_vo) {
      if(scripts\engine\utility::istrue(level.recent_vo[var_2])) {
        level.recent_vo[var_2] = level.recent_vo[var_2] - 1;
      }
    }

    wait(1);
  }
}

update_self_vo_cooldown_list() {
  self endon("disconnect");
  for(;;) {
    foreach(var_2, var_1 in self.recent_vo) {
      if(scripts\engine\utility::istrue(self.recent_vo[var_2])) {
        self.recent_vo[var_2] = self.recent_vo[var_2] - 1;
      }
    }

    wait(1);
  }
}

one_to_one_dialogue_vo_handler(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = self;
  var_9 = isDefined(level.vo_alias_data[var_0]);
  scripts\cp\cp_vo::set_vo_system_busy(1);
  var_10 = scripts\cp\cp_music_and_dialog::getarrayofdialoguealiases(var_0, var_9);
  level.dialogue_arr = var_10;
  while(scripts\cp\cp_music_and_dialog::vo_is_playing()) {
    wait(0.1);
  }

  if(scripts\engine\utility::istrue(var_7)) {
    var_8 play_special_vo_dialogue(var_10, var_9, var_3, var_5, var_6, var_7);
    scripts\engine\utility::waitframe();
  } else {
    foreach(var_13, var_12 in var_10) {
      var_13 = 0;
      var_14 = undefined;
      if(var_9 && isDefined(level.vo_alias_data[var_12].dialogueprefix)) {
        var_14 = level.vo_alias_data[var_12].dialogueprefix;
        var_15 = var_14 + var_12;
      } else if(issubstr(var_12, "ww_") || issubstr(var_12, "ks_")) {
        var_15 = var_12;
        var_13 = 1;
      } else {
        continue;
      }

      foreach(var_8 in level.players) {
        if((isDefined(var_14) && var_8.vo_prefix == var_14) || var_13 || getdvarint("scr_solo_dialogue", 0) == 1) {
          var_11 = scripts\cp\cp_vo::create_vo_data(var_15, var_3, var_5, var_6);
          var_8 scripts\cp\cp_vo::set_vo_system_playing(1);
          var_8 scripts\cp\cp_vo::set_vo_currently_playing(var_11);
          var_8 scripts\cp\cp_vo::play_vo(var_11);
          var_8 scripts\cp\cp_vo::pause_between_vo(var_11);
          var_8 scripts\cp\cp_vo::unset_vo_currently_playing();
          break;
        }
      }

      scripts\engine\utility::waitframe();
    }
  }

  foreach(var_8 in level.players) {
    var_8 scripts\cp\cp_vo::set_vo_system_playing(0);
  }

  scripts\cp\cp_vo::set_vo_system_busy(0);
}

dialogue_vo_handler(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!scripts\cp\cp_music_and_dialog::can_play_dialogue_system()) {
    return;
  }

  var_8 = isDefined(level.vo_alias_data[var_0]);
  scripts\cp\cp_vo::set_vo_system_busy(1);
  var_9 = scripts\cp\cp_music_and_dialog::getarrayofdialoguealiases(var_0, var_8);
  level.dialogue_arr = var_9;
  while(scripts\cp\cp_music_and_dialog::vo_is_playing()) {
    wait(0.1);
  }

  if(scripts\engine\utility::istrue(var_7)) {
    var_10 = self;
    var_10 play_special_vo_dialogue(var_9, var_8, var_3, var_5, var_6);
    scripts\engine\utility::waitframe();
  } else {
    foreach(var_13, var_12 in var_10) {
      var_13 = 0;
      var_14 = undefined;
      if(var_8 && isDefined(level.vo_alias_data[var_12].dialogueprefix)) {
        var_14 = level.vo_alias_data[var_12].dialogueprefix;
        var_15 = var_14 + var_12;
      } else if(issubstr(var_12, "ww_") || issubstr(var_12, "ks_")) {
        var_15 = var_12;
        var_13 = 1;
      } else {
        continue;
      }

      foreach(var_10 in level.players) {
        if((isDefined(var_14) && var_10.vo_prefix == var_14) || var_13 || getdvarint("scr_solo_dialogue", 0) == 1) {
          var_11 = scripts\cp\cp_vo::create_vo_data(var_15, var_3, var_5, var_6);
          var_10 scripts\cp\cp_vo::set_vo_system_playing(1);
          var_10 scripts\cp\cp_vo::set_vo_currently_playing(var_11);
          var_10 scripts\cp\cp_vo::play_vo(var_11);
          var_10 scripts\cp\cp_vo::pause_between_vo(var_11);
          var_10 scripts\cp\cp_vo::unset_vo_currently_playing();
          break;
        }
      }

      scripts\engine\utility::waitframe();
    }
  }

  foreach(var_10 in level.players) {
    var_10 scripts\cp\cp_vo::set_vo_system_playing(0);
  }

  scripts\cp\cp_vo::set_vo_system_busy(0);
}

play_special_vo_dialogue(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0;
  var_7 = "";
  while(var_6 < var_0.size) {
    var_8 = 1;
    var_9 = undefined;
    if(var_1 && isDefined(level.vo_alias_data[var_0[var_6]].dialogueprefix)) {
      var_9 = level.vo_alias_data[var_0[var_6]].dialogueprefix;
      var_7 = var_9 + var_0[var_6];
    } else if(issubstr(var_0[var_6], "ks_")) {
      var_7 = var_0[var_6];
      var_8 = 1;
      if(isDefined(level.survivor)) {
        if(isDefined(level.boat_survivor)) {
          scripts\engine\utility::play_sound_in_space(var_7, level.boat_survivor.origin, 0, level.boat_survivor);
        } else {
          scripts\engine\utility::play_sound_in_space(var_7, level.survivor.origin, 0, level.survivor);
        }

        wait(scripts\cp\cp_vo::get_sound_length(var_7));
      } else if(isDefined(level.boat_survivor)) {
        scripts\engine\utility::play_sound_in_space(var_7, level.boat_survivor.origin, 0, level.boat_survivor);
        wait(scripts\cp\cp_vo::get_sound_length(var_7));
      } else {
        var_10 = scripts\cp\cp_vo::create_vo_data(var_7, var_2, var_3, var_4, var_0[var_6]);
        scripts\cp\cp_vo::play_vo_system(var_10, var_5);
      }

      var_6++;
      continue;
    } else {
      continue;
      scripts\engine\utility::waitframe();
    }

    if(((isDefined(var_9) && self.vo_prefix == var_9) || var_8 || getdvarint("scr_solo_dialogue", 0) == 1) && !issubstr(var_7, "ks_")) {
      var_10 = scripts\cp\cp_vo::create_vo_data(var_7, var_2, var_3, var_4, var_0[var_6]);
      scripts\cp\cp_vo::play_vo_system(var_10);
      var_6++;
    }

    scripts\engine\utility::waitframe();
  }
}

codxp_dialogue_vo_handler(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  wait(6);
  scripts\cp\cp_vo::set_vo_system_busy(1);
  foreach(var_8 in level.players) {
    var_8 thread play_ww_on_each_player(var_8);
  }

  scripts\engine\utility::flag_wait("dialogue_done");
  scripts\cp\cp_vo::set_vo_system_busy(0);
}

play_ww_on_each_player(var_0) {
  var_0 playwillardvo("ww_spawn_alt_first_1", var_0);
  var_0 playplayervo("plr_spawn_alt_first_2", var_0);
  var_0 playwillardvo("ww_spawn_alt_first_6", var_0);
  if(var_0.vo_prefix == "p4_") {
    var_0 playplayervo("plr_spawn_alt_first_7", var_0);
  } else {
    var_0 playlocalsound("p4_spawn_alt_first_7");
    wait(scripts\cp\cp_vo::get_sound_length("p4_spawn_alt_first_7"));
  }

  var_0 playwillardvo("ww_spawn_alt_first_8", var_0);
  scripts\engine\utility::flag_set("dialogue_done");
}

playwillardvo(var_0, var_1) {
  var_1 playlocalsound(var_0);
  wait(scripts\cp\cp_vo::get_sound_length(var_0));
}

playplayervo(var_0, var_1) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.vo_prefix)) {
      var_1 playlocalsound(var_1.vo_prefix + var_0);
    }
  }

  wait(scripts\cp\cp_vo::get_sound_length(var_1.vo_prefix + var_0));
}

pap_vo_handler(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!scripts\cp\cp_vo::should_append_player_prefix(var_0)) {
    thread scripts\cp\cp_vo::play_vo_on_player(var_0, var_2, var_3, var_4, var_5, var_6, var_0);
    return;
  }

  var_7 = self.vo_prefix + var_0;
  thread scripts\cp\cp_vo::play_vo_on_player(var_7, var_2, var_3, var_4, var_5, var_6, var_0);
}

rave_vo_handler(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!scripts\cp\cp_vo::should_append_player_prefix(var_0)) {
    thread scripts\cp\cp_vo::play_vo_on_player(var_0, var_2, var_3, var_4, var_5, var_6, var_0);
    return;
  }

  var_7 = self.vo_prefix + var_0;
  thread scripts\cp\cp_vo::play_vo_on_player(var_7, var_2, var_3, var_4, var_5, var_6, var_0);
}

afterlife_vo_handler(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!scripts\cp\cp_vo::should_append_player_prefix(var_0)) {
    thread scripts\cp\cp_vo::play_vo_on_player(var_0, var_2, var_3, var_4, var_5, var_6, var_0);
    return;
  }

  var_7 = self.vo_prefix + var_0;
  thread scripts\cp\cp_vo::play_vo_on_player(var_7, var_2, var_3, var_4, var_5, var_6, var_0);
}

ww_vo(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon(var_0 + "_timed_out");
  level thread scripts\cp\cp_vo::timeoutvofunction(var_0, var_3);
  while(scripts\cp\cp_vo::is_vo_system_busy()) {
    wait(0.1);
  }

  scripts\cp\cp_vo::set_vo_system_busy(1);
  while(scripts\cp\cp_music_and_dialog::vo_is_playing()) {
    wait(0.1);
  }

  level notify(var_0 + "_about_to_play");
  foreach(var_9 in level.players) {
    if(!isDefined(var_9)) {
      continue;
    }

    if(var_9 issplitscreenplayer() && !var_9 issplitscreenplayerprimary()) {
      continue;
    }

    var_10 = scripts\cp\cp_vo::create_vo_data(var_0, var_3, var_5, var_6);
    var_9 thread scripts\cp\cp_vo::play_vo_system(var_10, var_7);
  }

  wait(scripts\cp\cp_vo::get_sound_length(var_0));
  foreach(var_9 in level.players) {
    var_9 scripts\cp\cp_vo::set_vo_system_playing(0);
  }

  scripts\cp\cp_vo::set_vo_system_busy(0);
}

announcer_vo(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  play_announcer_vo(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

is_vo_in_pap(var_0) {
  if(isDefined(level.vo_alias_data[var_0].pap_approval)) {
    if(level.vo_alias_data[var_0].pap_approval == 1) {
      return 0;
    }

    return 1;
  }

  return 1;
}

is_vo_in_rave(var_0) {
  if(isDefined(level.vo_alias_data[var_0].rave_approval)) {
    if(level.vo_alias_data[var_0].rave_approval == 1) {
      return 1;
    }

    return 0;
  }

  return 0;
}

minigame_vo(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_2 = scripts\cp\utility::get_array_of_valid_players();
    if(var_2.size < 1) {
      return;
    }

    var_0 = var_2[0];
  }

  if(self == var_0) {
    if(!isDefined(var_0.recent_vo)) {
      self.recent_vo = [];
      thread update_self_vo_cooldown_list();
    }

    if(scripts\engine\utility::istrue(var_0.recent_vo[var_1])) {
      return;
    }

    var_0 add_to_recent_player_vo(var_1);
    play_minigame_vo(var_0, var_1);
    return;
  }

  if(scripts\engine\utility::istrue(level.recent_vo[var_1])) {
    return;
  }

  add_to_recent_vo(var_1);
  play_minigame_vo(var_0, var_1);
}

play_minigame_vo(var_0, var_1, var_2) {
  if(!soundexists(var_1)) {
    wait(0.1);
    return;
  }

  var_0 playlocalsound(var_1);
}

play_announcer_vo(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level.announcer_vo_playing = 1;
  if(isDefined(var_7)) {
    var_0 = var_7 + var_0;
  }

  if(!soundexists(var_0)) {
    wait(0.1);
    level.announcer_vo_playing = 0;
    return;
  }

  foreach(var_10 in level.players) {
    if(!isDefined(var_10)) {
      continue;
    }

    if(var_10 issplitscreenplayer() && !var_10 issplitscreenplayerprimary()) {
      continue;
    }

    if(isDefined(var_8) && var_10.vo_prefix == var_8) {
      var_11 = var_8 + var_0;
      if(soundexists(var_11)) {
        var_10 playlocalsound(var_11);
      }

      continue;
    } else {
      var_12 = scripts\cp\cp_vo::create_vo_data(var_0, var_3, var_5, var_6);
      var_10 thread scripts\cp\cp_vo::play_vo_system(var_12);
    }
  }

  wait(scripts\cp\cp_vo::get_sound_length(var_0));
  foreach(var_10 in level.players) {
    var_10 scripts\cp\cp_vo::set_vo_system_playing(0);
  }

  special_vo_notify_watcher(var_0);
  level.announcer_vo_playing = 0;
}

special_vo_notify_watcher(var_0) {
  if(var_0 == "dj_jingle_intro") {
    level notify("jukebox_start");
  }
}

play_vo_for_powerup(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  wait(0.5);
  announcer_vo("ww_" + var_0, "rave_ww_vo", "highest", 60, 0, 0, 1);
  var_0 = convert_alias_string_for_players(var_0);
  foreach(var_8 in level.players) {
    if(isDefined(var_8) && isalive(var_8)) {
      var_8 thread scripts\cp\cp_vo::try_to_play_vo(var_0, "rave_comment_vo");
    }
  }
}

convert_alias_string_for_players(var_0) {
  switch (var_0) {
    case "powerup_carpenter":
    case "powerup_maxammo":
    case "powerup_instakill":
    case "powerup_nuke":
    case "powerup_firesale":
      return var_0;

    case "powerup_doublemoney":
      return "powerup_2xmoney";

    case "powerup_infiniteammo":
      return "powerup_ammo";

    case "powerup_infinitegrenades":
      return "powerup_grenade";

    default:
      return var_0;
  }
}

player_volume_activation_check_init() {
  for(;;) {
    level waittill("volume_activated", var_0);
    switch (var_0) {
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
    level waittill("volume_activated", var_0);
    switch (var_0) {
      case "moon":
        foreach(var_2 in level.players) {
          var_2 thread scripts\cp\cp_vo::add_to_nag_vo("nag_board_windows", "rave_comment_vo", 180, 60, 20, 1);
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

purchase_area_vo(var_0, var_1) {
  if(!isDefined(level.played_area_vos)) {
    level.played_area_vos = [];
  }

  if(scripts\engine\utility::istrue(level.open_sesame)) {
    return;
  }

  switch (var_0) {
    case "front_gate":
      if(!isDefined(level.played_area_vos[var_0])) {
        level.played_area_vos[var_0] = 1;
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_door_cabins", "rave_comment_vo", "low", 10, 0, 2, 0, 40);
      } else {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "rave_comment_vo", "low", 10, 0, 2, 1, 40);
      }
      break;

    case "camper_to_lake":
    case "lake_shore":
    case "cabin_to_lake":
      if(!isDefined(level.played_area_vos[var_0])) {
        level.played_area_vos[var_0] = 1;
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_door_lake", "rave_comment_vo", "low", 10, 0, 2, 0, 40);
      } else {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "rave_comment_vo", "low", 10, 0, 2, 1, 40);
      }

      break;

    case "obstacle_course":
      if(!isDefined(level.played_area_vos[var_0])) {
        level.played_area_vos[var_0] = 1;
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_door_obcourse", "rave_comment_vo", "low", 10, 0, 2, 0, 40);
      } else {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "rave_comment_vo", "low", 10, 0, 2, 1, 40);
      }

      break;

    case "cave":
      if(!isDefined(level.played_area_vos[var_0])) {
        level.played_area_vos[var_0] = 1;
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_door_caves", "rave_comment_vo", "low", 10, 0, 2, 0, 40);
      } else {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "rave_comment_vo", "low", 10, 0, 2, 1, 40);
      }
      break;

    case "rave":
      if(!isDefined(level.played_area_vos[var_0])) {
        level.played_area_vos[var_0] = 1;
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area_rave", "rave_comment_vo", "low", 10, 0, 2, 0, 40);
      } else {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "rave_comment_vo", "low", 10, 0, 2, 1, 40);
      }
      break;

    default:
      if(level.players.size > 1) {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "rave_comment_vo", "low", 10, 0, 2, 1, 40);
      } else {
        level.players[0] thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "rave_comment_vo", "low", 10, 0, 2, 1, 40);
      }
      break;
  }
}

starting_vo() {
  scripts\engine\utility::flag_wait("intro_gesture_done");
  if(scripts\cp\cp_music_and_dialog::can_play_dialogue_system()) {
    var_0 = randomint(100);
    if(var_0 <= 30) {
      scripts\cp\cp_vo::try_to_play_vo_on_all_players("spawn_team_first");
      level thread willard_intro_vo();
      return;
    }

    var_1 = scripts\engine\utility::random(level.players);
    if(isDefined(var_1.vo_prefix)) {
      switch (var_1.vo_prefix) {
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
    foreach(var_3 in level.players) {
      if(var_3 issplitscreenplayer()) {
        if(var_3 issplitscreenplayerprimary()) {
          if(isDefined(var_3.vo_prefix)) {
            if(var_3.vo_prefix == "p5_") {
              var_3 multiple_kevinsmith_intro_vo(var_3);
            } else {
              var_3 thread scripts\cp\cp_vo::try_to_play_vo("spawn_team_first", "rave_comment_vo", "high", 20, 0, 0, 1);
            }
          }
        }

        continue;
      }

      if(isDefined(var_3.vo_prefix)) {
        if(var_3.vo_prefix == "p5_") {
          var_3 multiple_kevinsmith_intro_vo(var_3);
          continue;
        }

        var_3 thread scripts\cp\cp_vo::try_to_play_vo("spawn_team_first", "rave_comment_vo", "high", 20, 0, 0, 1);
      }
    }

    level thread willard_intro_vo();
    return;
  }

  level.players[0] thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(["spawn_intro", "spawn_solo_first"]), "rave_comment_vo", "high", 20, 0, 0, 1);
  level thread willard_intro_vo();
}

multiple_kevinsmith_intro_vo(var_0) {
  if(!isDefined(level.special_character_count)) {
    return;
  }

  if(!isDefined(var_0)) {
    return;
  }

  switch (level.special_character_count) {
    case 1:
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("spawn_team_first", "rave_comment_vo");
      break;

    case 2:
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("extra_ksmith_2", "rave_comment_vo");
      break;

    case 3:
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("extra_ksmith_3", "rave_comment_vo");
      break;

    case 4:
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("extra_ksmith_4", "rave_comment_vo");
      break;

    default:
      break;
  }
}

memory_vo_handler(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("disconnect");
  var_7 = self;
  if(!isDefined(var_7)) {
    return;
  }

  if(var_7 issplitscreenplayer() && !var_7 issplitscreenplayerprimary()) {
    return;
  }

  var_8 = scripts\cp\cp_vo::create_vo_data(var_0, var_3, var_5, var_6);
  var_7 scripts\cp\cp_vo::set_vo_system_playing(1);
  var_7 scripts\cp\cp_vo::set_vo_currently_playing(var_8);
  var_7 scripts\cp\cp_vo::play_vo(var_8);
  var_7 scripts\cp\cp_vo::pause_between_vo(var_8);
  var_7 scripts\cp\cp_vo::set_vo_system_playing(0);
  var_7 scripts\cp\cp_vo::unset_vo_currently_playing();
}

ks_vo_handler(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  while(scripts\cp\cp_vo::is_vo_system_busy()) {
    wait(0.1);
  }

  if(scripts\engine\utility::istrue(var_4)) {
    foreach(var_8 in level.players) {
      var_8 scripts\cp\cp_vo::set_vo_system_playing(0);
      var_8.vo_system_playing_vo = 0;
    }
  }

  scripts\cp\cp_vo::set_vo_system_busy(1);
  while(scripts\cp\cp_music_and_dialog::vo_is_playing()) {
    wait(0.1);
  }

  play_ks_vo(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  scripts\cp\cp_vo::set_vo_system_busy(0);
  foreach(var_8 in level.players) {
    var_8 scripts\cp\cp_vo::set_vo_system_playing(0);
  }
}

play_ks_vo(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\cp\cp_vo::create_vo_data(var_0, var_3, var_5, var_6);
  if(self == level) {
    foreach(var_9 in level.players) {
      if(!isDefined(var_9)) {
        continue;
      }

      if(var_9 issplitscreenplayer() && !var_9 issplitscreenplayerprimary()) {
        continue;
      }

      if(isDefined(level.survivor)) {
        if(isDefined(level.boat_survivor)) {
          scripts\engine\utility::play_sound_in_space(var_0, level.boat_survivor.origin, 0, level.boat_survivor);
        } else {
          scripts\engine\utility::play_sound_in_space(var_0, level.survivor.origin, 0, level.survivor);
        }

        continue;
      }

      if(isDefined(level.boat_survivor)) {
        scripts\engine\utility::play_sound_in_space(var_0, level.boat_survivor.origin, 0, level.boat_survivor);
        continue;
      }

      var_9 thread scripts\cp\cp_vo::play_vo_system(var_7);
    }

    wait(scripts\cp\cp_vo::get_sound_length(var_0));
    return;
  }

  if(isDefined(level.survivor)) {
    if(isDefined(level.boat_survivor)) {
      scripts\engine\utility::play_sound_in_space(var_0, level.boat_survivor.origin, 0, level.boat_survivor);
    } else {
      scripts\engine\utility::play_sound_in_space(var_0, level.survivor.origin, 0, level.survivor);
    }
  } else if(isDefined(level.boat_survivor)) {
    scripts\engine\utility::play_sound_in_space(var_0, level.boat_survivor.origin, 0, level.boat_survivor);
  } else if(isplayer(self)) {
    if(isDefined(self.vo_prefix)) {
      thread scripts\cp\cp_vo::play_vo_system(var_7);
    }
  }

  wait(scripts\cp\cp_vo::get_sound_length(var_0));
}