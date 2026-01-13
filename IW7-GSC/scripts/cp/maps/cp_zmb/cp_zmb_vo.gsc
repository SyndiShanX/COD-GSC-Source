/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zmb\cp_zmb_vo.gsc
************************************************/

zmb_vo_init() {
  level.recent_vo = [];
  level.announcer_vo_playing = 0;
  level.player_vo_playing = 0;
  level.spawn_vo_func = ::starting_vo;
  level.level_specific_vo_callouts = ::zmb_vo_callouts;
  level.pap_vo_approve_func = ::is_vo_in_pap;
  level.get_alias_2d_func = scripts\cp\cp_vo::get_alias_2d_version;
  level thread zmb_vo_callouts();
  level.dialogue_playing_queue = [];
  level thread update_vo_cooldown_list();
  level waittill("activate_power");
  level thread volume_activation_check_init();
}

zmb_vo_callouts(var_0) {
  level.vo_functions["zmb_announcer_vo"] = ::announcer_vo;
  level.vo_functions["zmb_ww_vo"] = ::ww_vo;
  level.vo_functions["zmb_powerup_vo"] = ::play_vo_for_powerup;
  level.vo_functions["zmb_afterlife_vo"] = ::afterlife_vo_handler;
  level.vo_functions["zmb_pap_vo"] = ::pap_vo_handler;
  level.vo_functions["zmb_intro_dialogue_vo"] = ::codxp_dialogue_vo_handler;
  level.vo_functions["zmb_dialogue_vo"] = ::dialogue_vo_handler;
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

dialogue_vo_handler(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!scripts\cp\cp_music_and_dialog::can_play_dialogue_system()) {
    return;
  }

  var_7 = isDefined(level.vo_alias_data[var_0]);
  scripts\cp\cp_vo::set_vo_system_busy(1);
  var_8 = scripts\cp\cp_music_and_dialog::getarrayofdialoguealiases(var_0, var_7);
  level.dialogue_arr = var_8;
  while(scripts\cp\cp_music_and_dialog::vo_is_playing()) {
    wait(0.1);
  }

  foreach(var_0A in var_8) {
    var_0B = 0;
    var_0C = undefined;
    if(var_7 && isDefined(level.vo_alias_data[var_0A].dialogueprefix)) {
      var_0C = level.vo_alias_data[var_0A].dialogueprefix;
      var_0D = var_0C + var_0A;
    } else if(issubstr(var_0A, "ww_")) {
      var_0D = var_0A;
      var_0B = 1;
    } else {
      continue;
    }

    foreach(var_0F in level.players) {
      if((isDefined(var_0C) && var_0F.vo_prefix == var_0C) || var_0B || getdvarint("scr_solo_dialogue", 0) == 1) {
        var_10 = scripts\cp\cp_vo::create_vo_data(var_0D, var_3, var_5, var_6);
        var_0F scripts\cp\cp_vo::set_vo_system_playing(1);
        var_0F scripts\cp\cp_vo::set_vo_currently_playing(var_10);
        var_0F scripts\cp\cp_vo::play_vo(var_10);
        var_0F scripts\cp\cp_vo::pause_between_vo(var_10);
        var_0F scripts\cp\cp_vo::unset_vo_currently_playing();
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }

  foreach(var_0F in level.players) {
    var_0F scripts\cp\cp_vo::set_vo_system_playing(0);
  }

  scripts\cp\cp_vo::set_vo_system_busy(0);
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

afterlife_vo_handler(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!scripts\cp\cp_vo::should_append_player_prefix(var_0)) {
    thread scripts\cp\cp_vo::play_vo_on_player(var_0, var_2, var_3, var_4, var_5, var_6, var_0);
    return;
  }

  var_7 = self.vo_prefix + var_0;
  thread scripts\cp\cp_vo::play_vo_on_player(var_7, var_2, var_3, var_4, var_5, var_6, var_0);
}

ww_vo(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon(var_0 + "_timed_out");
  if(isDefined(level.special_character_count_ww) && level.special_character_count_ww > 0 && issubstr(var_0, "powerup")) {
    return;
  }

  level thread scripts\cp\cp_vo::timeoutvofunction(var_0, var_3);
  while(scripts\cp\cp_vo::is_vo_system_busy()) {
    wait(0.1);
  }

  scripts\cp\cp_vo::set_vo_system_busy(1);
  while(scripts\cp\cp_music_and_dialog::vo_is_playing()) {
    wait(0.1);
  }

  level notify(var_0 + "_about_to_play");
  foreach(var_8 in level.players) {
    if(!isDefined(var_8)) {
      continue;
    }

    if(var_8 issplitscreenplayer() && !var_8 issplitscreenplayerprimary()) {
      continue;
    }

    var_9 = scripts\cp\cp_vo::create_vo_data(var_0, var_3, var_5, var_6);
    var_8 thread scripts\cp\cp_vo::play_vo_system(var_9);
  }

  wait(scripts\cp\cp_vo::get_sound_length(var_0));
  foreach(var_8 in level.players) {
    var_8 scripts\cp\cp_vo::set_vo_system_playing(0);
  }

  scripts\cp\cp_vo::set_vo_system_busy(0);
}

announcer_vo(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  play_announcer_vo(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

is_vo_in_pap(var_0) {
  if(isDefined(level.vo_alias_data[var_0].pap_approval)) {
    if(level.vo_alias_data[var_0].pap_approval == 1) {
      if(scripts\cp\zombies\zombie_fast_travel::is_in_pap_room(self)) {
        return 1;
      }

      return 0;
    }

    return 1;
  }

  return 1;
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

play_announcer_vo(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level.announcer_vo_playing = 1;
  if(isDefined(var_7)) {
    var_0 = var_7 + var_0;
  }

  if(!soundexists(var_0)) {
    wait(0.1);
    level.announcer_vo_playing = 0;
    return;
  }

  foreach(var_9 in level.players) {
    if(!isDefined(var_9)) {
      continue;
    }

    if(var_9 issplitscreenplayer() && !var_9 issplitscreenplayerprimary()) {
      continue;
    } else {
      var_0A = scripts\cp\cp_vo::create_vo_data(var_0, var_3, var_5, var_6);
      var_9 thread scripts\cp\cp_vo::play_vo_system(var_0A);
    }
  }

  wait(scripts\cp\cp_vo::get_sound_length(var_0));
  foreach(var_9 in level.players) {
    var_9 scripts\cp\cp_vo::set_vo_system_playing(0);
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
  if(scripts\engine\utility::istrue(level.directors_cut_is_activated) && isDefined(level.special_character_count_ww) && level.special_character_count_ww > 0) {
    announcer_vo("dj_" + var_0, "zmb_ww_vo", "highest", 60, 0, 0, 1);
  } else {
    announcer_vo("ww_" + var_0, "zmb_ww_vo", "highest", 60, 0, 0, 1);
  }

  var_0 = convert_alias_string_for_players(var_0);
  foreach(var_8 in level.players) {
    if(isDefined(var_8) && isalive(var_8)) {
      var_8 thread scripts\cp\cp_vo::try_to_play_vo(var_0, "zmb_comment_vo");
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

wave_check_init() {
  for(;;) {
    level waittill("wave_starting");
    if(level.wave_num > 3) {
      break;
    }
  }
}

volume_activation_check_init() {
  for(;;) {
    level waittill("volume_activated", var_0);
    switch (var_0) {
      case "moon":
        if(scripts\engine\utility::istrue(level.directors_cut_is_activated) && !scripts\engine\utility::istrue(level.played_once)) {
          level.played_once = 1;
          var_1 = ["dj_dc_dj_hoff", "dj_dc_intro"];
          var_2 = scripts\engine\utility::random(var_1);
          level thread scripts\cp\cp_vo::try_to_play_vo(var_2, "zmb_dj_vo", "high", 20, 0, 0, 1);
          var_3 = scripts\cp\cp_vo::get_sound_length(var_2);
          if(isDefined(var_3)) {
            wait(var_3 + 25);
          }

          if(isDefined(level.special_character_count_ww) && level.special_character_count_ww > 0) {
            foreach(var_5 in level.players) {
              var_5 thread play_willard_dj_exchange(var_5);
            }
          }
        } else {
          var_1 = ["dj_music_next", "dj_music_set", "dj_interup_wave_start"];
          level thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_1), "zmb_dj_vo", "high", 20, 0, 0, 1);
        }

        level thread scripts\cp\cp_vo::try_to_play_vo("spawn_dj_first_1", "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        foreach(var_8 in level.players) {
          var_8 thread scripts\cp\cp_vo::add_to_nag_vo("nag_board_windows", "zmb_comment_vo", 180, 60, 20, 1);
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

clear_up_all_vo(var_0) {
  foreach(var_2 in level.vo_priority_level) {
    if(isDefined(var_0.vo_system.vo_queue[var_2]) && var_0.vo_system.vo_queue[var_2].size > 0) {
      foreach(var_4 in var_0.vo_system.vo_queue[var_2]) {
        if(isDefined(var_4)) {
          var_0 stoplocalsound(var_4.alias);
        }
      }
    }
  }

  var_7 = undefined;
  if(isDefined(var_0.vo_system)) {
    if(isDefined(var_0.vo_system.vo_currently_playing)) {
      if(isDefined(var_0.vo_system.vo_currently_playing.alias)) {
        var_7 = var_0.vo_system.vo_currently_playing.alias;
      }
    }
  }

  if(isDefined(var_7)) {
    var_0 stoplocalsound(var_7);
  }
}

play_willard_dj_exchange(var_0) {
  self endon("disconnect");
  clear_up_all_vo(var_0);
  scripts\cp\cp_vo::func_C9CB([var_0]);
  level.dj scripts\cp\maps\cp_zmb\cp_zmb_dj::set_dj_state("approach_mic");
  if(var_0.vo_prefix == "p6_") {
    var_0 playlocalsound("p6_plr_spawn_dj_first_1");
  } else {
    var_0 playlocalsound("p6_spawn_dj_first_1");
  }

  wait(scripts\cp\cp_vo::get_sound_length("p6_spawn_dj_first_1"));
  var_0 playlocalsound("dj_spawn_dj_first_2");
  wait(scripts\cp\cp_vo::get_sound_length("dj_spawn_dj_first_2"));
  if(var_0.vo_prefix == "p6_") {
    var_0 playlocalsound("p6_plr_spawn_dj_first_3");
  } else {
    var_0 playlocalsound("p6_spawn_dj_first_3");
  }

  wait(scripts\cp\cp_vo::get_sound_length("p6_spawn_dj_first_3"));
  var_0 playlocalsound("dj_spawn_dj_first_4");
  wait(scripts\cp\cp_vo::get_sound_length("dj_spawn_dj_first_4"));
  foreach(var_0 in level.players) {
    if(var_0.vo_prefix == "p6_") {
      var_0 playlocalsound("p6_plr_spawn_dj_first_5");
      continue;
    }

    var_0 playlocalsound("p6_spawn_dj_first_5");
  }

  wait(scripts\cp\cp_vo::get_sound_length("p6_spawn_dj_first_5"));
  var_0 playlocalsound("dj_spawn_dj_first_6");
  wait(scripts\cp\cp_vo::get_sound_length("dj_spawn_dj_first_6"));
  scripts\cp\cp_vo::func_12BE3([var_0]);
  level.dj scripts\cp\maps\cp_zmb\cp_zmb_dj::set_dj_state("open_window");
}

willard_intro_vo() {
  level endon("game_ended");
  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    return;
  }

  level waittill("wave_start_sound_done");
  if(scripts\engine\utility::istrue(level.directors_cut_is_activated)) {
    if(isDefined(level.special_character_count_ww) && level.special_character_count_ww > 0) {
      if(scripts\engine\utility::flag("power_on")) {
        level thread scripts\cp\cp_vo::try_to_play_vo("dj_dc_intro", "zmb_dj_vo", "highest", 30, 0, 0, 1, 100);
        return;
      }

      level.disable_broadcast = 1;
      if(isDefined(level.dj)) {
        playsoundatpos(level.dj.origin, "dj_dc_intro");
      }

      wait(scripts\cp\cp_vo::get_sound_length("dj_dc_intro"));
      level.disable_broadcast = undefined;
      return;
    }

    level thread scripts\cp\cp_vo::try_to_play_vo("ww_zmb_dc_intro", "zmb_ww_vo", "highest", 30, 0, 0, 1, 100);
    return;
  }

  level thread scripts\cp\cp_vo::try_to_play_vo("ww_intro", "zmb_ww_vo", "highest", 30, 0, 0, 1, 100);
}

power_nag() {
  level endon("game_ended");
  for(;;) {
    level waittill("wave_start_sound_done");
    var_0 = scripts\cp\maps\cp_zmb\cp_zmb_environment_scriptable::is_all_power_on();
    if(var_0) {
      return;
    }

    if(level.wave_num > 0 && level.wave_num % 3 == 0) {
      scripts\cp\cp_vo::try_to_play_vo_on_all_players("nag_activate_power");
      continue;
    }
  }
}

purchase_team_buy_vos(var_0, var_1) {
  switch (var_0.script_side) {
    case "moon":
      if(level.moon_donations == 3) {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_door_journey", "zmb_comment_vo", "low", 10, 0, 0, 0, 40);
      }
      break;

    case "kepler":
      if(level.kepler_donations == 3) {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_door_keppler", "zmb_comment_vo", "low", 10, 0, 0, 0, 70);
      }
      break;

    case "triton":
      if(level.triton_donations == 3) {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_door_triton", "zmb_comment_vo", "low", 10, 0, 0, 0, 70);
      }
      break;
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
    case "moon":
    case "front_gate":
      if(!isDefined(level.played_area_vos[var_0])) {
        level.played_area_vos[var_0] = 1;
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_door_mainstreet", "zmb_comment_vo", "low", 10, 0, 0, 0, 40);
      }
      break;

    case "swamp_stage":
      if(!isDefined(level.played_area_vos[var_0])) {
        level.played_area_vos[var_0] = 1;
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area_underground", "zmb_comment_vo", "low", 10, 0, 0, 0, 40);
      } else {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "zmb_comment_vo", "low", 10, 0, 0, 1, 40);
      }

      break;

    case "underground_route":
      if(!isDefined(level.played_area_vos[var_0])) {
        level.played_area_vos[var_0] = 1;
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area_underground", "zmb_comment_vo", "low", 10, 0, 0, 0, 40);
      } else {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "zmb_comment_vo", "low", 10, 0, 0, 1, 40);
      }
      break;

    case "arcade":
      if(!isDefined(level.played_area_vos[var_0])) {
        level.played_area_vos[var_0] = 1;
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area_astrocade", "zmb_comment_vo", "low", 10, 0, 0, 0, 40);
      } else {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "zmb_comment_vo", "low", 10, 0, 0, 1, 40);
      }
      break;

    default:
      if(level.players.size > 1) {
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "zmb_comment_vo", "low", 10, 0, 0, 1, 40);
      } else {
        level.players[0] thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "zmb_comment_vo", "low", 10, 0, 0, 1, 40);
      }
      break;
  }
}

multiple_hoffs_intro_vo(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(scripts\engine\utility::istrue(level.directors_cut_is_activated) || getdvarint("scr_solo_ww_dialogue", 0) != 0) {
    if(isDefined(level.special_character_count_ww) && level.special_character_count_ww > 0) {
      if(isDefined(level.special_character_count) && level.special_character_count > 0) {
        var_1 = scripts\engine\utility::random(["spawn_addtl_celebs_1_1", "spawn_addtl_celebs_2_1"]);
        level thread scripts\cp\cp_vo::try_to_play_vo(var_1, "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        return;
      }

      switch (level.special_character_count_ww) {
        case 1:
          if(randomint(100) > 50) {
            var_0 thread scripts\cp\cp_vo::try_to_play_vo("spawn_intro", "zmb_comment_vo");
          } else {
            var_0 thread scripts\cp\cp_vo::try_to_play_vo("spawn_solo_first", "zmb_comment_vo");
          }
          break;

        case 2:
          var_0 thread scripts\cp\cp_vo::try_to_play_vo("extra_willard_2", "zmb_comment_vo");
          break;

        case 3:
          var_0 thread scripts\cp\cp_vo::try_to_play_vo("extra_willard_3", "zmb_comment_vo");
          break;

        case 4:
          var_0 thread scripts\cp\cp_vo::try_to_play_vo("extra_willard_4", "zmb_comment_vo");
          break;

        default:
          break;
      }

      return;
    }

    return;
  }

  if(!isDefined(level.special_character_count)) {
    return;
  }

  switch (level.special_character_count) {
    case 1:
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("afterlife_first", "zmb_comment_vo");
      break;

    case 2:
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("extra_hasselhoff_2", "zmb_comment_vo");
      break;

    case 3:
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("extra_hasselhoff_3", "zmb_comment_vo");
      break;

    case 4:
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("extra_hasselhoff_4", "zmb_comment_vo");
      break;

    default:
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

    if(var_0 <= 70) {
      level thread scripts\cp\cp_vo::try_to_play_vo("spawn_team_first_1", "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      level thread willard_intro_vo();
      return;
    }

    level thread scripts\cp\cp_vo::try_to_play_vo("ww_spawn_alt_first_1", "zmb_intro_dialogue_vo", "highest", 666, 0, 0, 0, 100);
    return;
  }

  if(level.players.size > 1) {
    foreach(var_2 in level.players) {
      if(var_2 issplitscreenplayer()) {
        if(var_2 issplitscreenplayerprimary()) {
          if(isDefined(var_2.vo_prefix)) {
            if(var_2.vo_prefix == "p5_" || var_2.vo_prefix == "p6_") {
              var_2 multiple_hoffs_intro_vo(var_2);
            } else {
              var_2 thread scripts\cp\cp_vo::try_to_play_vo("spawn_team_first", "zmb_comment_vo", "high", 20, 0, 0, 1);
            }
          }
        }

        continue;
      }

      if(isDefined(var_2.vo_prefix)) {
        if(var_2.vo_prefix == "p5_" || var_2.vo_prefix == "p6_") {
          var_2 multiple_hoffs_intro_vo(var_2);
          continue;
        }

        var_2 thread scripts\cp\cp_vo::try_to_play_vo("spawn_team_first", "zmb_comment_vo", "high", 20, 0, 0, 1);
      }
    }

    level thread willard_intro_vo();
    return;
  }

  var_4 = scripts\engine\utility::random(["spawn_intro", "spawn_solo_first"]);
  level.players[0] thread scripts\cp\cp_vo::try_to_play_vo(var_4, "zmb_comment_vo", "high", 20, 0, 0, 1);
  level thread willard_intro_vo();
}