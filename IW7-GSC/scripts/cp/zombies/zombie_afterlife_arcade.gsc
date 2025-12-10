/**********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombie_afterlife_arcade.gsc
**********************************************************/

enter_afterlife_arcade(param_00) {
  if(isDefined(level.rewind_afterlife_func)) {
    level thread[[level.rewind_afterlife_func]](param_00);
  }

  if(!isDefined(param_00.first_time_in_arcade)) {
    param_00.first_time_in_arcade = 1;
  }

  if(isDefined(level.afterlife_arcade_set_audio_zone_func)) {
    param_00 thread[[level.afterlife_arcade_set_audio_zone_func]](param_00);
  }

  var_01 = get_afterlife_arcade_start_point(param_00);
  clearplayersweaponlevels(param_00);
  level notify("player_entered_ala", param_00);
  param_00 notify("player_entered_ala");
  param_00.exitingafterlifearcade = 0;
  if(isDefined(level.timesinafterlife)) {
    level.timesinafterlife++;
  }

  param_00.timeenteringafterlife = gettime();
  param_00.health = param_00.maxhealth;
  param_00 clearclienttriggeraudiozone(0.02);
  param_00 scripts\cp\utility::stoplocalsound_safe("zmb_laststand_music");
  param_00 setorigin(var_01.origin);
  param_00 laststandrevive();
  param_00 setstance("stand");
  param_00 takeallweapons();
  param_00 playershow();
  param_00 scripts\cp\utility::_giveweapon("iw7_gunless_zm", undefined, undefined, 1);
  param_00 scripts\engine\utility::allow_melee(0);
  param_00 scripts\cp\zombies\zombies_loadout::set_player_photo_status(param_00, "afterlife");
  param_00 scripts\cp\utility::force_usability_enabled();
  param_00 afterlife_enable_player_interaction(param_00);
  param_00 set_has_self_revive_token(param_00, 0);
  param_00 increase_afterlife_count(param_00);
  if(isDefined(param_00)) {
    if(check_self_revive_attempts(param_00)) {
      param_00 scripts\cp\utility::setlowermessage("welcome_to_afterlife", &"CP_ZOMBIE_AFTERLIFE_ARCADE_WELCOME", 6);
    } else {
      param_00 scripts\cp\utility::setlowermessage("welcome_to_afterlife_no_self_revives", &"CP_ZOMBIE_AFTERLIFE_ARCADE_NO_REVIVES", 6);
    }

    scripts\cp\zombies\zombie_analytics::log_enteringafterlifearcade(1, param_00, level.wave_num, param_00.soul_power_earned, int(level.wave_num / 10) + 1 - param_00.times_self_revived);
  }

  if(param_00.first_time_in_arcade) {
    param_00 thread scripts\cp\cp_vo::try_to_play_vo("spawn_arcade_first", "zmb_comment_vo", "highest", 15, 0, 0, 1, 50);
    param_00.first_time_in_arcade = 0;
  } else {
    param_00 thread scripts\cp\cp_vo::try_to_play_vo("spawn_arcade", "zmb_comment_vo", "high", 15, 0, 0, 1, 50);
  }

  param_00 reset_soul_power(param_00);
  param_00 thread player_exit_afterlife_monitor(param_00);
  param_00 thread delay_set_player_angles(param_00, var_01.angles);
  param_00 thread black_screen_fades_in(param_00);
  param_00 thread player_enter_transition_monitor(param_00);
  level thread open_afterlife_door_for_player(param_00, 10);
  param_00 set_in_afterlife_arcade(param_00, 1);
  param_00 afterlife_disable_player_outline(param_00, 1);
  param_00 scripts\cp\utility::hideheadicon(param_00.icons_to_hide_when_in_afterlife);
  param_00 visionsetnakedforplayer("cp_zmb_afterlife", 1);
  param_00 setclientomnvar("zm_ui_player_in_afterlife_arcade", 1);
  param_00 setclientomnvarbit("player_damaged", 1, 0);
  param_00 setclientomnvarbit("player_damaged", 2, 0);
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    scripts\engine\utility::flag_set("pause_wave_progression");
    level.zombies_paused = 1;
    foreach(var_03 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
      if(isDefined(var_03.dont_cleanup)) {
        continue;
      }

      if(isDefined(var_03.agent_type) && var_03.agent_type == "zombie_brute" || var_03.agent_type == "zombie_grey") {
        continue;
      }

      if(isDefined(var_03.agent_type) && var_03.agent_type == "crab_mini" || var_03.agent_type == "crab_brute") {
        var_03.vignette_nocorpse = 1;
      }

      var_03.died_poorly = 1;
      var_03 suicide();
    }

    param_00 thread scripts\cp\cp_hud_message::wait_and_play_tutorial_message("afterlife", 18);
    thread give_solo_self_revive_token(param_00);
  }

  if(isDefined(level.enter_afterlife_clear_player_scriptable_func)) {
    [[level.enter_afterlife_clear_player_scriptable_func]](param_00);
  }

  if(isDefined(level.aa_ww_char_vo)) {
    param_00 thread[[level.aa_ww_char_vo]](param_00);
  } else {
    level thread play_willard_afterlife_vo(param_00);
  }

  if(isDefined(level.aa_memoirs_vo)) {
    param_00 thread[[level.aa_memoirs_vo]](param_00);
  }

  param_00 thread freeze_controls_for_time();
}

play_willard_afterlife_vo(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  while(scripts\engine\utility::istrue(param_00.vo_system_playing_vo)) {
    wait(0.1);
  }

  param_00 thread scripts\cp\cp_vo::try_to_play_vo("ww_afterlife_arrive", "zmb_afterlife_vo", "high", 20, 0, 0, 1);
}

freeze_controls_for_time() {
  self endon("disconnect");
  self allowmovement(0);
  wait(3);
  self allowmovement(1);
}

play_ww_vo_memoirs(param_00) {
  param_00 endon("disconnect");
  param_00 endon("death");
  level endon("game_ended");
  param_00 endon("player_done_exit_afterlife");
  wait(randomintrange(30, 40));
  if(!isDefined(param_00.array_of_memoir_vos)) {
    param_00.array_of_memoir_vos = ["ww_afterlife_memoir_1", "ww_afterlife_memoir_2", "ww_afterlife_memoir_3", "ww_afterlife_memoir_4", "ww_afterlife_memoir_5", "ww_afterlife_memoir_6", "ww_afterlife_memoir_7", "ww_afterlife_memoir_8"];
  }

  while(param_00.array_of_memoir_vos.size > 0) {
    if(randomint(100) < 30) {
      scripts\engine\utility::play_sound_in_space(param_00.array_of_memoir_vos[0], level.willard_speaker.origin);
    }

    param_00.array_of_memoir_vos = scripts\engine\utility::array_remove(param_00.array_of_memoir_vos, param_00.array_of_memoir_vos[0]);
    if(isDefined(param_00.array_of_memoir_vos[0])) {
      if(soundexists(param_00.array_of_memoir_vos[0])) {
        wait(randomfloatrange(80, 110) + scripts\cp\cp_vo::get_sound_length(param_00.array_of_memoir_vos[0]));
      }

      continue;
    }

    wait(randomfloatrange(120, 180));
  }
}

choose_correct_vo_for_player(param_00) {
  wait(10);
  var_01 = "";
  if(param_00.times_self_revived >= param_00.max_self_revive_machine_use) {
    var_01 = "ww_afterlife_p4_notoken";
  } else {
    var_02 = ["ww_afterlife_p1_generic", "ww_afterlife_p5_alt_1", "ww_afterlife_arrive"];
    var_01 = scripts\engine\utility::random(var_02);
  }

  if(var_01 == "ww_afterlife_arrive") {
    param_00 thread scripts\cp\cp_vo::try_to_play_vo(var_01, "zmb_afterlife_vo", "high", 20, 0, 0, 1);
    return;
  }

  var_03 = strtok(var_01, "_");
  var_04 = "";
  var_05 = var_03[3];
  var_06 = param_00.vo_suffix;
  var_07 = strtok(var_06, "_");
  var_08 = var_07[0];
  switch (var_08) {
    case "p5":
    case "p4":
    case "p3":
    case "p2":
    case "p1":
      var_04 = choose_vo_based_on_type(var_08, var_05);
      break;

    default:
      var_04 = var_01;
      break;
  }

  if(soundexists(var_04)) {
    param_00 thread scripts\cp\cp_vo::try_to_play_vo(var_04, "zmb_afterlife_vo", "high", 60, 1, 0, 1);
  }
}

choose_vo_based_on_type(param_00, param_01) {
  var_02 = "ww_afterlife_";
  for(;;) {
    var_02 = "ww_afterlife_";
    switch (param_01) {
      case "generic":
        var_02 = var_02 + param_00 + "_generic";
        break;

      case "notoken":
        var_02 = var_02 + param_00 + "_notoken";
        break;

      case "alt":
        var_02 = var_02 + param_00 + "_alt_1";
        break;

      default:
        break;
    }

    if(!soundexists(var_02)) {
      var_03 = ["ww_afterlife_p1_generic", "ww_afterlife_arrive", "ww_afterlife_p5_alt_1"];
      var_02 = scripts\engine\utility::random(var_03);
      if(var_02 == "ww_afterlife_arrive") {
        return var_02;
      } else {
        var_04 = strtok(var_02, "_");
        param_01 = var_04[3];
        continue;
      }
    } else {
      return var_02;
    }

    scripts\engine\utility::waitframe();
  }

  return var_02;
}

clearplayersweaponlevels(param_00) {
  param_00.pap = [];
}

get_afterlife_arcade_start_point(param_00) {
  var_01 = scripts\engine\utility::getstructarray("afterlife_arcade", "targetname");
  if(isDefined(level.additional_afterlife_arcade_start_point)) {
    var_01 = scripts\engine\utility::array_combine(var_01, level.additional_afterlife_arcade_start_point);
  }

  var_01 = scripts\engine\utility::array_randomize(var_01);
  foreach(var_03 in var_01) {
    if(can_spawn_at_afterlife_arcade_start_point(var_03, param_00)) {
      return var_03;
    }
  }

  return scripts\engine\utility::random(var_01);
}

can_spawn_at_afterlife_arcade_start_point(param_00, param_01) {
  var_02 = 16;
  foreach(var_04 in level.players) {
    if(var_04 == param_01) {
      continue;
    }

    if(distance2d(param_00.origin, var_04.origin) < var_02) {
      return 0;
    }
  }

  return 1;
}

try_exit_afterlife_arcade(param_00) {
  if(is_in_afterlife_arcade(param_00)) {
    exit_afterlife_arcade(param_00);
  }
}

clear_up_all_vo_in_afterlife(param_00) {
  foreach(var_02 in level.vo_priority_level) {
    if(isDefined(param_00.vo_system.vo_queue[var_02]) && param_00.vo_system.vo_queue[var_02].size > 0) {
      foreach(var_04 in param_00.vo_system.vo_queue[var_02]) {
        if(isDefined(var_04)) {
          if(issubstr(var_04.alias, "afterlife")) {
            param_00 stoplocalsound(var_04.alias);
          }
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

exit_afterlife_arcade(param_00) {
  if(param_00.logevent == "wave_complete") {
    param_00.reason = "Wave Complete";
  } else {
    param_00.reason = "Self Revive";
  }

  if(param_00 hasweapon("iw7_gunless_zm")) {
    param_00 takeweapon("iw7_gunless_zm");
  }

  if(isDefined(level.afterlife_arcade_unset_audio_zone_func)) {
    param_00 thread[[level.afterlife_arcade_unset_audio_zone_func]](param_00);
  }

  level thread close_afterlife_door_for_player(param_00);
  level thread clear_up_all_vo_in_afterlife(param_00);
  if(isDefined(param_00.disabledmelee) && param_00.disabledmelee >= 1) {
    param_00 scripts\engine\utility::allow_melee(1);
  }

  param_00.exitingafterlifearcade = 1;
  param_00.timespentinafterlife = gettime() - param_00.timeenteringafterlife / 1000;
  scripts\cp\zombies\zombie_analytics::log_exitingafterlifearcade(1, param_00, level.wave_num, param_00.reason, param_00.timespentinafterlife);
  param_00 scripts\engine\utility::allow_usability(0);
  param_00 set_in_afterlife_arcade(param_00, 0);
  param_00 afterlife_disable_player_outline(param_00, 0);
  param_00 scripts\cp\utility::showheadicon(param_00.icons_to_hide_when_in_afterlife);
  param_00 visionsetnakedforplayer("", 0);
  param_00 setclientomnvar("zm_ui_player_in_afterlife_arcade", 0);
  param_00.is_off_grid = undefined;
  param_00.is_in_pap = undefined;
  param_00 setclientomnvar("zombie_afterlife_soul_power_needed", -1);
  param_00 thread play_exit_afterlife_arcade_vo(param_00);
  param_00 notify("player_done_exit_afterlife");
}

play_exit_afterlife_arcade_vo(param_00) {
  param_00 endon("disconnect");
  if(isDefined(param_00.ignoreselfrevive)) {
    return;
  }

  wait(4);
  if(!isDefined(param_00.num_of_times_exit_afterlife_arcade)) {
    param_00.num_of_times_exit_afterlife_arcade = 0;
  }

  param_00.num_of_times_exit_afterlife_arcade++;
  if(param_00.num_of_times_exit_afterlife_arcade == 1) {
    param_00 thread scripts\cp\cp_vo::try_to_play_vo("arcade_token_revive_first", "zmb_comment_vo", "low", 3, 0, 0, 1);
    return;
  }

  param_00 thread scripts\cp\cp_vo::try_to_play_vo("arcade_token_revive", "zmb_comment_vo", "low", 3, 0, 0, 1);
}

delete_move_ent() {
  wait(0.1);
  self delete();
}

delay_set_player_angles(param_00, param_01) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("player_exit_afterlife");
  scripts\engine\utility::waitframe();
  param_00 setplayerangles(param_01);
}

black_screen_fades_in(param_00) {
  param_00 endon("disconnect");
  var_01 = newclienthudelem(param_00);
  var_01.x = 0;
  var_01.y = 0;
  var_01 setshader("black", 640, 480);
  var_01.alignx = "left";
  var_01.aligny = "top";
  var_01.sort = 1;
  var_01.horzalign = "fullscreen";
  var_01.vertalign = "fullscreen";
  var_01.alpha = 1;
  var_01.foreground = 1;
  var_01 fadeovertime(15);
  var_01.alpha = 0;
  var_01 scripts\cp\utility::waittill_any_ents_or_timeout_return(15, param_00, "player_exit_afterlife", level, "game_ended");
  var_01 destroy();
}

afterlife_enable_player_interaction(param_00) {
  param_00.interaction_trigger = scripts\cp\cp_interaction::get_player_interaction_trigger();
  scripts\cp\cp_interaction::reset_interaction_triggers();
  param_00.last_interaction_point = undefined;
  param_00.interaction_trigger makeunusable();
  param_00 thread afterlife_release_player_interaction_trigger();
  param_00 thread scripts\cp\cp_interaction::player_interaction_monitor();
}

afterlife_release_player_interaction_trigger() {
  var_00 = self.interaction_trigger;
  scripts\engine\utility::waittill_any_3("player_exit_afterlife", "spawned", "disconnect");
  var_00.in_use = 0;
}

set_in_afterlife_arcade(param_00, param_01) {
  param_00.in_afterlife_arcade = param_01;
}

afterlife_disable_player_outline(param_00, param_01) {
  param_00.no_outline = param_01;
  param_00.no_team_outlines = param_01;
}

is_in_afterlife_arcade(param_00) {
  return scripts\engine\utility::istrue(param_00.in_afterlife_arcade);
}

init_spectate_door() {}

init_selfrevive_door() {}

use_spectate_door(param_00, param_01) {
  if(level.players.size == 1) {
    param_01 scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, &"CP_ZOMBIE_AFTERLIFE_ARCADE_CANNOT_SPECTATE");
    return;
  }

  param_01.pre_spectate_pos = param_01.origin;
  param_01.pre_spectate_angles = param_01 getplayerangles();
  param_01 scripts\cp\cp_globallogic::enterspectator();
  param_01 thread exit_spectator_request_monitor(param_01);
}

exit_spectator_request_monitor(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("player_exit_afterlife");
  param_00 endon("spawned");
  param_00 notifyonplayercommand("release_use_button", "-usereload");
  param_00 notifyonplayercommand("release_use_button", "-activate");
  param_00 notifyonplayercommand("press_use_button", "+usereload");
  param_00 notifyonplayercommand("press_use_button", "+activate");
  param_00 waittill("release_use_button");
  param_00 waittill("press_use_button");
  param_00 scripts\cp\utility::updatesessionstate("playing");
  param_00 spawn(param_00.pre_spectate_pos, param_00.pre_spectate_angles);
  param_00 allowdoublejump(0);
  param_00 allowwallrun(0);
}

use_selfrevive_door(param_00, param_01) {
  param_01 endon("disconnect");
  if(param_01 scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    if(!scripts\engine\utility::istrue(level.dont_resume_wave_after_solo_afterlife)) {
      level thread resumespawningaftertime();
    }
  }

  if(!isDefined(param_01.ignoreselfrevive)) {
    param_01 add_white_screen();
  }

  if(isDefined(param_01.disabledmelee) && param_01.disabledmelee >= 1) {
    param_01 scripts\engine\utility::allow_melee(1);
  }

  if(!isDefined(param_01.ignoreselfrevive)) {
    move_through_tube(param_01, "fast_travel_tube_start", "fast_travel_tube_end");
    param_01 thread remove_white_screen(0.1);
  }

  param_01 notify("player_exit_afterlife");
  param_01 scripts\cp\cp_laststand::instant_revive(param_01);
  param_01 setclientomnvar("zombie_afterlife_soul_power_earned", 0);
  param_01 setclientomnvar("zombie_afterlife_soul_power_goal", 0);
  param_01 setclientomnvar("zombie_afterlife_soul_power_needed", -1);
  param_01 set_has_self_revive_token(param_01, 0);
  if(param_01 scripts\cp\utility::is_consumable_active("self_revive")) {
    return;
  }

  if(param_01 scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    param_01.times_self_revived = param_01.self_revives_purchased;
    var_02 = param_01.max_self_revive_machine_use - param_01.times_self_revived;
  } else {
    var_02.times_self_revived = var_02.times_self_revived + 1;
    var_02 = int(level.wave_num / 10) + 1 - var_02.times_self_revived;
  }

  param_01 setclientomnvar("zombie_afterlife_self_revive_count", int(max(var_02, 0)));
  param_01 thread set_spawn_defaults();
}

set_spawn_defaults() {
  self endon("disconnect");
  wait(0.15);
  self allowdoublejump(0);
  self allowslide(1);
  self allowwallrun(0);
  self allowdodge(0);
  self _meth_8426(0);
  self _meth_8425(0);
  self _meth_8454(3);
  if(isDefined(level.player_suit)) {
    self setsuit(level.player_suit);
  } else {
    self setsuit("zom_suit");
  }

  self.suit = "zom_suit";
}

resumespawningaftertime() {
  level endon("game_ended");
  wait(20);
  level.zombies_paused = 0;
  scripts\engine\utility::flag_clear("pause_wave_progression");
}

update_player_revives_every_ten_waves(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  for(var_01 = 0; var_01 < 2; var_01++) {
    level scripts\engine\utility::waittill_any_3("regular_wave_starting", "event_wave_starting");
    if(param_00 scripts\cp\utility::isplayingsolo() || level.only_one_player) {
      continue;
    } else {
      var_02 = int(level.wave_num / 10) + 1 - param_00.times_self_revived;
    }

    param_00 setclientomnvar("zombie_afterlife_self_revive_count", int(max(var_02, 0)));
  }
}

move_through_tube(param_00, param_01, param_02) {
  var_03 = getent(param_01, "targetname");
  var_04 = getent(param_02, "targetname");
  if(!isDefined(var_03) || !isDefined(var_04)) {
    return;
  }

  param_00 earthquakeforplayer(0.3, 0.2, param_00.origin, 200);
  param_00 cancelmantle();
  param_00.no_outline = 1;
  param_00.no_team_outlines = 1;
  var_05 = var_03.origin + (0, 0, -45);
  var_06 = var_04.origin + (0, 0, -45);
  param_00.is_fast_traveling = 1;
  param_00 scripts\cp\utility::allow_player_ignore_me(1);
  param_00 dontinterpolate();
  param_00 setorigin(var_05);
  param_00 setplayerangles(var_03.angles);
  param_00 playlocalsound("zmb_portal_travel_lr");
  var_07 = spawn("script_origin", var_05);
  param_00 playerlinkto(var_07);
  wait(0.1);
  var_07 moveto(var_06, 1);
  param_00 thread remove_white_screen(0.1);
  wait(1);
  param_00.is_fast_traveling = undefined;
  if(param_00 scripts\cp\utility::isignoremeenabled()) {
    param_00 scripts\cp\utility::allow_player_ignore_me(0);
  }

  param_00.no_outline = 0;
  param_00.no_team_outlines = 0;
  if(isDefined(level.portal_exit_fx_org)) {
    var_08 = anglesToForward((0, 90, 0));
    playFX(level._effect["vfx_zmb_portal_exit_burst"], level.portal_exit_fx_org, var_08);
  }

  param_00 add_white_screen();
  var_07 thread delete_move_ent();
}

add_white_screen() {
  if(isDefined(self.white_screen_overlay)) {
    return;
  }

  self.white_screen_overlay = newclienthudelem(self);
  self.white_screen_overlay.x = 0;
  self.white_screen_overlay.y = 0;
  self.white_screen_overlay setshader("white", 640, 480);
  self.white_screen_overlay.alignx = "left";
  self.white_screen_overlay.aligny = "top";
  self.white_screen_overlay.sort = 1;
  self.white_screen_overlay.horzalign = "fullscreen";
  self.white_screen_overlay.vertalign = "fullscreen";
  self.white_screen_overlay.alpha = 1;
  self.white_screen_overlay.foreground = 1;
}

remove_white_screen(param_00) {
  self endon("disconnect");
  if(isDefined(param_00)) {
    wait(param_00);
  }

  if(isDefined(self.white_screen_overlay)) {
    self.white_screen_overlay.alpha = 0;
    wait(0.1);
    if(isDefined(self.white_screen_overlay)) {
      self.white_screen_overlay destroy();
    }
  }
}

can_use_selfrevive_door(param_00, param_01) {
  if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
    return 1;
  }

  if(has_self_revive_token(param_01)) {
    return 1;
  }

  return 0;
}

get_self_revive_door_hint(param_00, param_01) {
  if(check_self_revive_attempts(param_01)) {
    if(has_self_revive_token(param_01) || scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
      return &"CP_ZOMBIE_AFTERLIFE_ARCADE_SELFREVIVE_DOOR";
    }

    return &"CP_ZOMBIE_AFTERLIFE_ARCADE_NEED_SELFREVIVE_TOKEN";
  }

  return &"CP_ZOMBIE_AFTERLIFE_ARCADE_NO_MORE_SELF_REVIVES";
}

give_self_revive_token(param_00) {
  param_00 thread scripts\cp\cp_vo::try_to_play_vo("arcade_token_earn", "zmb_comment_vo", "low", 3, 0, 0, 1);
  param_00 playlocalsound("zmb_ala_soul_meter_filled");
  param_00 set_has_self_revive_token(param_00, 1);
  param_00.soul_power_earned = 0;
  param_00.soul_power_displayed = 0;
  level thread open_afterlife_door_for_player(param_00, 165);
  wait(5);
  param_00 thread scripts\cp\cp_vo::try_to_play_vo("ww_afterlife_overstay", "zmb_afterlife_vo", "high", undefined, undefined, undefined, 1);
}

give_solo_self_revive_token(param_00) {
  param_00 playlocalsound("zmb_ala_soul_meter_filled");
  param_00 set_has_self_revive_token(param_00, 1);
  param_00 setclientomnvar("zombie_afterlife_soul_power_needed", -1);
  param_00.soul_power_earned = 0;
  param_00.soul_power_displayed = 0;
  level thread open_afterlife_door_for_player(param_00, 165);
}

open_afterlife_door_for_player(param_00, param_01) {
  if(!isDefined(level.ala_portal_org)) {
    level.ala_revive_door = getent("ala_revive_door", "targetname");
    var_02 = scripts\engine\utility::getstruct("selfrevive_portal", "targetname");
    level.ala_portal_org = spawn("script_model", var_02.origin);
    level.ala_portal_org setModel("tag_origin");
    level.ala_portal_org.angles = var_02.angles;
    wait(0.1);
  }

  if(!isDefined(param_00.revive_door)) {
    param_00.revive_door = spawn("script_model", level.ala_revive_door.origin + (0, 0, -300));
    param_00.revive_door setModel(level.ala_revive_door.model);
    param_00.revive_door.angles = level.ala_revive_door.angles;
    foreach(var_04 in level.players) {
      if(var_04 != param_00) {
        param_00.revive_door hidefromplayer(var_04);
      }
    }

    wait(0.1);
    param_00.revive_door.origin = param_00.revive_door.origin + (0, 0, 300);
    wait(0.1);
    level.ala_revive_door hidefromplayer(param_00);
  }

  param_00.revive_door rotateyaw(param_01, 0.2);
  var_06 = level._effect["vfx_zmb_portal_centhub"];
  if(isDefined(level.centhub_portal_fx)) {
    var_06 = level.centhub_portal_fx;
  }

  playfxontagforclients(var_06, level.ala_portal_org, "tag_origin", param_00);
}

close_afterlife_door_for_player(param_00) {
  if(isDefined(param_00.revive_door)) {
    param_00.revive_door.angles = level.ala_revive_door.angles;
  }

  stopfxontagforclients(level._effect["vfx_zmb_portal_centhub"], level.ala_portal_org, "tag_origin", param_00);
}

set_has_self_revive_token(param_00, param_01) {
  param_00.has_self_revive_token = param_01;
  if(param_01 == 1) {
    param_00 setclientomnvar("zombie_afterlife_has_self_revive_token", 1);
    return;
  }

  param_00 setclientomnvar("zombie_afterlife_has_self_revive_token", 0);
}

has_self_revive_token(param_00) {
  return scripts\engine\utility::istrue(param_00.has_self_revive_token);
}

check_self_revive_attempts(param_00) {
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return 1;
  }

  if(scripts\engine\utility::istrue(param_00.have_gns_perk)) {
    return 1;
  }

  if(param_00.times_self_revived >= param_00.max_self_revive_machine_use) {
    return 0;
  }

  if(int(level.wave_num / 10) + 1 - param_00.times_self_revived >= 1) {
    return 1;
  }

  return 0;
}

player_exit_afterlife_monitor(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("player_done_exit_afterlife");
  param_00 scripts\engine\utility::waittill_any_return("player_exit_afterlife", "spawned");
  param_00 exit_afterlife_arcade(param_00);
}

init_afterlife_arcade() {
  level.timesinafterlife = 0;
  level.player_bleed_out_func = ::enter_afterlife_arcade;
}

start_afterlife_arcade_music() {
  var_00 = spawn("script_origin", (-10100, 114, -1753));
  var_00 playLoopSound("zmb_afterlife_music");
}

player_enter_transition_monitor(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("player_done_exit_afterlife");
  wait(3);
  if(check_self_revive_attempts(param_00)) {
    turn_on_soul_power_progress_bar(param_00);
  }

  param_00 visionsetnakedforplayer("", 2);
}

turn_on_soul_power_progress_bar(param_00) {
  param_00 setclientomnvar("zombie_afterlife_soul_power_earned", param_00.soul_power_earned);
  param_00 setclientomnvar("zombie_afterlife_soul_power_needed", param_00.soul_power_goal);
  param_00 setclientomnvar("zombie_afterlife_soul_power_goal", param_00.soul_power_goal);
}

player_init_afterlife(param_00) {
  param_00.icons_to_hide_when_in_afterlife = [];
}

add_to_icons_to_hide_in_afterlife(param_00, param_01) {
  param_00.icons_to_hide_when_in_afterlife[param_00.icons_to_hide_when_in_afterlife.size] = param_01;
}

remove_from_icons_to_hide_in_afterlife(param_00, param_01) {
  if(!isDefined(param_00)) {
    return;
  }

  param_00.icons_to_hide_when_in_afterlife = scripts\engine\utility::array_remove(param_00.icons_to_hide_when_in_afterlife, param_01);
  param_00.icons_to_hide_when_in_afterlife = scripts\engine\utility::array_removeundefined(param_00.icons_to_hide_when_in_afterlife);
}

init_soul_power(param_00) {
  param_00.soul_power_earned = 0;
  param_00.soul_power_displayed = 0;
  param_00.times_self_revived = 0;
  param_00.soul_power_goal = get_soul_power_goal(param_00);
}

give_soul_power(param_00, param_01) {
  if(check_self_revive_attempts(param_00) && !has_self_revive_token(param_00)) {
    param_00.soul_power_earned = param_00.soul_power_earned + param_01;
    param_00 thread display_soul_power_earned(param_00);
  }
}

display_soul_power_earned(param_00) {
  param_00 notify("display_soul_power_earned");
  level endon("game_ended");
  param_00 endon("display_soul_power_earned");
  param_00 endon("revive");
  while(param_00.soul_power_displayed < min(param_00.soul_power_earned, param_00.soul_power_goal)) {
    var_01 = min(param_00.soul_power_earned, param_00.soul_power_goal);
    var_02 = param_00.soul_power_displayed + 5;
    param_00.soul_power_displayed = min(var_02, var_01);
    param_00 setclientomnvar("zombie_afterlife_soul_power_earned", int(param_00.soul_power_displayed));
    param_00 setclientomnvar("zombie_afterlife_soul_power_needed", int(param_00.soul_power_goal - param_00.soul_power_displayed));
    scripts\engine\utility::waitframe();
  }

  if(param_00.soul_power_earned >= param_00.soul_power_goal) {
    if(check_self_revive_attempts(param_00)) {
      give_self_revive_token(param_00);
    }
  }
}

increase_afterlife_count(param_00) {
  if(!isDefined(param_00.num_times_in_afterlife)) {
    param_00.num_times_in_afterlife = 0;
  }

  param_00.num_times_in_afterlife++;
}

get_soul_power_goal(param_00) {
  if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
    return 0;
  }

  return 200;
}

register_interactions() {
  level.interaction_hintstrings["afterlife_spectate_door"] = &"CP_ZOMBIE_AFTERLIFE_ARCADE_SPECTATE_DOOR";
  scripts\cp\cp_interaction::register_interaction("afterlife_spectate_door", undefined, undefined, undefined, ::use_spectate_door, 0, 0, ::init_spectate_door);
  scripts\cp\cp_interaction::register_interaction("afterlife_selfrevive_door", undefined, undefined, ::get_self_revive_door_hint, ::use_selfrevive_door, 0, 0, ::init_selfrevive_door, ::can_use_selfrevive_door);
}

reset_soul_power(param_00) {
  param_00.soul_power_earned = 0;
  param_00.soul_power_displayed = 0;
  param_00 setclientomnvar("zombie_afterlife_soul_power_earned", param_00.soul_power_earned);
}