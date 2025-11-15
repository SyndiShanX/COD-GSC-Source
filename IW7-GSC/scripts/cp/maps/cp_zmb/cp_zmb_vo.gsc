/************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zmb\cp_zmb_vo.gsc
************************************************/

zmb_vo_init() {
  level.recent_vo = [];
  level.announcer_vo_playing = 0;
  level.player_vo_playing = 0;
  level.spawn_vo_func = ::starting_vo;
  level.level_specific_vo_callouts = ::zmb_vo_callouts;
  level.pap_vo_approve_func = ::is_vo_in_pap;
  level.get_alias_2d_func = ::scripts\cp\cp_vo::get_alias_2d_version;
  level thread zmb_vo_callouts();
  level.dialogue_playing_queue = [];
  level thread update_vo_cooldown_list();
  level waittill("activate_power");
  level thread volume_activation_check_init();
}

zmb_vo_callouts(param_00) {
  level.vo_functions["zmb_announcer_vo"] = ::announcer_vo;
  level.vo_functions["zmb_ww_vo"] = ::ww_vo;
  level.vo_functions["zmb_powerup_vo"] = ::play_vo_for_powerup;
  level.vo_functions["zmb_afterlife_vo"] = ::afterlife_vo_handler;
  level.vo_functions["zmb_pap_vo"] = ::pap_vo_handler;
  level.vo_functions["zmb_intro_dialogue_vo"] = ::codxp_dialogue_vo_handler;
  level.vo_functions["zmb_dialogue_vo"] = ::dialogue_vo_handler;
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

dialogue_vo_handler(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(!scripts\cp\cp_music_and_dialog::can_play_dialogue_system()) {
    return;
  }

  var_07 = isDefined(level.vo_alias_data[param_00]);
  scripts\cp\cp_vo::set_vo_system_busy(1);
  var_08 = scripts\cp\cp_music_and_dialog::getarrayofdialoguealiases(param_00, var_07);
  level.dialogue_arr = var_08;
  while(scripts\cp\cp_music_and_dialog::vo_is_playing()) {
    wait(0.1);
  }

  foreach(var_0A in var_08) {
    var_0B = 0;
    var_0C = undefined;
    if(var_07 && isDefined(level.vo_alias_data[var_0A].dialogueprefix)) {
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
        var_10 = scripts\cp\cp_vo::create_vo_data(var_0D, param_03, param_05, param_06);
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
  if(isDefined(level.special_character_count_ww) && level.special_character_count_ww > 0 && issubstr(param_00, "powerup")) {
    return;
  }

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
      if(scripts\cp\zombies\zombie_fast_travel::is_in_pap_room(self)) {
        return 1;
      }

      return 0;
    }

    return 1;
  }

  return 1;
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

play_announcer_vo(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  level.announcer_vo_playing = 1;
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
  if(scripts\engine\utility::istrue(level.directors_cut_is_activated) && isDefined(level.special_character_count_ww) && level.special_character_count_ww > 0) {
    announcer_vo("dj_" + param_00, "zmb_ww_vo", "highest", 60, 0, 0, 1);
  } else {
    announcer_vo("ww_" + param_00, "zmb_ww_vo", "highest", 60, 0, 0, 1);
  }

  param_00 = convert_alias_string_for_players(param_00);
  foreach(var_08 in level.players) {
    if(isDefined(var_08) && isalive(var_08)) {
      var_08 thread scripts\cp\cp_vo::try_to_play_vo(param_00, "zmb_comment_vo");
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
    level waittill("volume_activated", var_00);
    switch (var_00) {
      case "moon":
        if(scripts\engine\utility::istrue(level.directors_cut_is_activated) && !scripts\engine\utility::istrue(level.played_once)) {
          level.played_once = 1;
          var_01 = ["dj_dc_dj_hoff", "dj_dc_intro"];
          var_02 = scripts\engine\utility::random(var_01);
          level thread scripts\cp\cp_vo::try_to_play_vo(var_02, "zmb_dj_vo", "high", 20, 0, 0, 1);
          var_03 = scripts\cp\cp_vo::get_sound_length(var_02);
          if(isDefined(var_03)) {
            wait(var_03 + 25);
          }

          if(isDefined(level.special_character_count_ww) && level.special_character_count_ww > 0) {
            foreach(var_05 in level.players) {
              var_05 thread play_willard_dj_exchange(var_05);
            }
          }
        } else {
          var_01 = ["dj_music_next", "dj_music_set", "dj_interup_wave_start"];
          level thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_01), "zmb_dj_vo", "high", 20, 0, 0, 1);
        }

        level thread scripts\cp\cp_vo::try_to_play_vo("spawn_dj_first_1", "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        foreach(var_08 in level.players) {
          var_08 thread scripts\cp\cp_vo::add_to_nag_vo("nag_board_windows", "zmb_comment_vo", 180, 60, 20, 1);
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

play_willard_dj_exchange(param_00) {
  self endon("disconnect");
  clear_up_all_vo(param_00);
  scripts\cp\cp_vo::func_C9CB([param_00]);
  level.dj scripts\cp\maps\cp_zmb\cp_zmb_dj::set_dj_state("approach_mic");
  if(param_00.vo_prefix == "p6_") {
    param_00 playlocalsound("p6_plr_spawn_dj_first_1");
  } else {
    param_00 playlocalsound("p6_spawn_dj_first_1");
  }

  wait(scripts\cp\cp_vo::get_sound_length("p6_spawn_dj_first_1"));
  param_00 playlocalsound("dj_spawn_dj_first_2");
  wait(scripts\cp\cp_vo::get_sound_length("dj_spawn_dj_first_2"));
  if(param_00.vo_prefix == "p6_") {
    param_00 playlocalsound("p6_plr_spawn_dj_first_3");
  } else {
    param_00 playlocalsound("p6_spawn_dj_first_3");
  }

  wait(scripts\cp\cp_vo::get_sound_length("p6_spawn_dj_first_3"));
  param_00 playlocalsound("dj_spawn_dj_first_4");
  wait(scripts\cp\cp_vo::get_sound_length("dj_spawn_dj_first_4"));
  foreach(param_00 in level.players) {
    if(param_00.vo_prefix == "p6_") {
      param_00 playlocalsound("p6_plr_spawn_dj_first_5");
      continue;
    }

    param_00 playlocalsound("p6_spawn_dj_first_5");
  }

  wait(scripts\cp\cp_vo::get_sound_length("p6_spawn_dj_first_5"));
  param_00 playlocalsound("dj_spawn_dj_first_6");
  wait(scripts\cp\cp_vo::get_sound_length("dj_spawn_dj_first_6"));
  scripts\cp\cp_vo::func_12BE3([param_00]);
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
    var_00 = scripts\cp\maps\cp_zmb\cp_zmb_environment_scriptable::is_all_power_on();
    if(var_00) {
      return;
    }

    if(level.wave_num > 0 && level.wave_num % 3 == 0) {
      scripts\cp\cp_vo::try_to_play_vo_on_all_players("nag_activate_power");
      continue;
    }
  }
}

purchase_team_buy_vos(param_00, param_01) {
  switch (param_00.script_side) {
    case "moon":
      if(level.moon_donations == 3) {
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_door_journey", "zmb_comment_vo", "low", 10, 0, 0, 0, 40);
      }
      break;

    case "kepler":
      if(level.kepler_donations == 3) {
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_door_keppler", "zmb_comment_vo", "low", 10, 0, 0, 0, 70);
      }
      break;

    case "triton":
      if(level.triton_donations == 3) {
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_door_triton", "zmb_comment_vo", "low", 10, 0, 0, 0, 70);
      }
      break;
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
    case "moon":
    case "front_gate":
      if(!isDefined(level.played_area_vos[param_00])) {
        level.played_area_vos[param_00] = 1;
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_door_mainstreet", "zmb_comment_vo", "low", 10, 0, 0, 0, 40);
      }
      break;

    case "swamp_stage":
      if(!isDefined(level.played_area_vos[param_00])) {
        level.played_area_vos[param_00] = 1;
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area_underground", "zmb_comment_vo", "low", 10, 0, 0, 0, 40);
      } else {
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "zmb_comment_vo", "low", 10, 0, 0, 1, 40);
      }

      break;

    case "underground_route":
      if(!isDefined(level.played_area_vos[param_00])) {
        level.played_area_vos[param_00] = 1;
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area_underground", "zmb_comment_vo", "low", 10, 0, 0, 0, 40);
      } else {
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "zmb_comment_vo", "low", 10, 0, 0, 1, 40);
      }
      break;

    case "arcade":
      if(!isDefined(level.played_area_vos[param_00])) {
        level.played_area_vos[param_00] = 1;
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area_astrocade", "zmb_comment_vo", "low", 10, 0, 0, 0, 40);
      } else {
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "zmb_comment_vo", "low", 10, 0, 0, 1, 40);
      }
      break;

    default:
      if(level.players.size > 1) {
        param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "zmb_comment_vo", "low", 10, 0, 0, 1, 40);
      } else {
        level.players[0] thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "zmb_comment_vo", "low", 10, 0, 0, 1, 40);
      }
      break;
  }
}

multiple_hoffs_intro_vo(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  if(scripts\engine\utility::istrue(level.directors_cut_is_activated) || getdvarint("scr_solo_ww_dialogue", 0) != 0) {
    if(isDefined(level.special_character_count_ww) && level.special_character_count_ww > 0) {
      if(isDefined(level.special_character_count) && level.special_character_count > 0) {
        var_01 = scripts\engine\utility::random(["spawn_addtl_celebs_1_1", "spawn_addtl_celebs_2_1"]);
        level thread scripts\cp\cp_vo::try_to_play_vo(var_01, "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        return;
      }

      switch (level.special_character_count_ww) {
        case 1:
          if(randomint(100) > 50) {
            param_00 thread scripts\cp\cp_vo::try_to_play_vo("spawn_intro", "zmb_comment_vo");
          } else {
            param_00 thread scripts\cp\cp_vo::try_to_play_vo("spawn_solo_first", "zmb_comment_vo");
          }
          break;

        case 2:
          param_00 thread scripts\cp\cp_vo::try_to_play_vo("extra_willard_2", "zmb_comment_vo");
          break;

        case 3:
          param_00 thread scripts\cp\cp_vo::try_to_play_vo("extra_willard_3", "zmb_comment_vo");
          break;

        case 4:
          param_00 thread scripts\cp\cp_vo::try_to_play_vo("extra_willard_4", "zmb_comment_vo");
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
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("afterlife_first", "zmb_comment_vo");
      break;

    case 2:
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("extra_hasselhoff_2", "zmb_comment_vo");
      break;

    case 3:
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("extra_hasselhoff_3", "zmb_comment_vo");
      break;

    case 4:
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("extra_hasselhoff_4", "zmb_comment_vo");
      break;

    default:
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

    if(var_00 <= 70) {
      level thread scripts\cp\cp_vo::try_to_play_vo("spawn_team_first_1", "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      level thread willard_intro_vo();
      return;
    }

    level thread scripts\cp\cp_vo::try_to_play_vo("ww_spawn_alt_first_1", "zmb_intro_dialogue_vo", "highest", 666, 0, 0, 0, 100);
    return;
  }

  if(level.players.size > 1) {
    foreach(var_02 in level.players) {
      if(var_02 issplitscreenplayer()) {
        if(var_02 issplitscreenplayerprimary()) {
          if(isDefined(var_02.vo_prefix)) {
            if(var_02.vo_prefix == "p5_" || var_02.vo_prefix == "p6_") {
              var_02 multiple_hoffs_intro_vo(var_02);
            } else {
              var_02 thread scripts\cp\cp_vo::try_to_play_vo("spawn_team_first", "zmb_comment_vo", "high", 20, 0, 0, 1);
            }
          }
        }

        continue;
      }

      if(isDefined(var_02.vo_prefix)) {
        if(var_02.vo_prefix == "p5_" || var_02.vo_prefix == "p6_") {
          var_02 multiple_hoffs_intro_vo(var_02);
          continue;
        }

        var_02 thread scripts\cp\cp_vo::try_to_play_vo("spawn_team_first", "zmb_comment_vo", "high", 20, 0, 0, 1);
      }
    }

    level thread willard_intro_vo();
    return;
  }

  var_04 = scripts\engine\utility::random(["spawn_intro", "spawn_solo_first"]);
  level.players[0] thread scripts\cp\cp_vo::try_to_play_vo(var_04, "zmb_comment_vo", "high", 20, 0, 0, 1);
  level thread willard_intro_vo();
}