/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3396.gsc
**************************************/

enter_afterlife_arcade(var_0) {
  if(isDefined(level.rewind_afterlife_func)) {
    level thread[[level.rewind_afterlife_func]](var_0);
  }

  if(!isDefined(var_0.first_time_in_arcade)) {
    var_0.first_time_in_arcade = 1;
  }

  var_1 = get_afterlife_arcade_start_point(var_0);
  clearplayersweaponlevels(var_0);
  level notify("player_entered_ala", var_0);
  var_0 notify("player_entered_ala");
  var_0.exitingafterlifearcade = 0;

  if(isDefined(level.timesinafterlife)) {
    level.timesinafterlife++;
  }

  var_0.timeenteringafterlife = gettime();
  var_0.health = var_0.maxhealth;
  var_0 clearclienttriggeraudiozone(0.02);
  var_0 scripts\cp\utility::stoplocalsound_safe("zmb_laststand_music");
  var_0 setorigin(var_1.origin);
  var_0 laststandrevive();
  var_0 setstance("stand");
  var_0 takeallweapons();
  var_0 playershow();
  var_0 scripts\cp\utility::_giveweapon("iw7_gunless_zm", undefined, undefined, 1);
  var_0 scripts\engine\utility::allow_melee(0);
  var_0 scripts\cp\zombies\zombies_loadout::set_player_photo_status(var_0, "afterlife");
  var_0 scripts\cp\utility::force_usability_enabled();
  var_0 afterlife_enable_player_interaction(var_0);
  var_0 set_has_self_revive_token(var_0, 0);
  var_0 increase_afterlife_count(var_0);

  if(isDefined(var_0)) {
    if(check_self_revive_attempts(var_0)) {
      var_0 scripts\cp\utility::setlowermessage("welcome_to_afterlife", &"CP_ZOMBIE_AFTERLIFE_ARCADE_WELCOME", 6.0);
    } else {
      var_0 scripts\cp\utility::setlowermessage("welcome_to_afterlife_no_self_revives", &"CP_ZOMBIE_AFTERLIFE_ARCADE_NO_REVIVES", 6.0);
    }

    scripts\cp\zombies\zombie_analytics::log_enteringafterlifearcade(1, var_0, level.wave_num, var_0.soul_power_earned, int(level.wave_num / 10) + 1 - var_0.times_self_revived);
  }

  if(var_0.first_time_in_arcade) {
    var_0 thread scripts\cp\cp_vo::try_to_play_vo("spawn_arcade_first", "zmb_comment_vo", "highest", 15, 0, 0, 1, 50);
    var_0.first_time_in_arcade = 0;
  } else
    var_0 thread scripts\cp\cp_vo::try_to_play_vo("spawn_arcade", "zmb_comment_vo", "high", 15, 0, 0, 1, 50);

  var_0 reset_soul_power(var_0);
  var_0 thread player_exit_afterlife_monitor(var_0);
  var_0 thread delay_set_player_angles(var_0, var_1.angles);
  var_0 thread black_screen_fades_in(var_0);
  var_0 thread player_enter_transition_monitor(var_0);
  level thread open_afterlife_door_for_player(var_0, 10);
  var_0 set_in_afterlife_arcade(var_0, 1);
  var_0 afterlife_disable_player_outline(var_0, 1);
  var_0 scripts\cp\utility::hideheadicon(var_0.icons_to_hide_when_in_afterlife);
  var_0 visionsetnakedforplayer("cp_zmb_afterlife", 1.0);
  var_0 setclientomnvar("zm_ui_player_in_afterlife_arcade", 1);
  var_0 setclientomnvarbit("player_damaged", 1, 0);
  var_0 setclientomnvarbit("player_damaged", 2, 0);

  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    scripts\engine\utility::flag_set("pause_wave_progression");
    level.zombies_paused = 1;

    foreach(var_3 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
      if(isDefined(var_3.dont_cleanup)) {
        continue;
      }
      if(isDefined(var_3.agent_type) && (var_3.agent_type == "zombie_brute" || var_3.agent_type == "zombie_grey")) {
        continue;
      }
      if(isDefined(var_3.agent_type) && (var_3.agent_type == "crab_mini" || var_3.agent_type == "crab_brute")) {
        var_3.vignette_nocorpse = 1;
      }

      var_3.died_poorly = 1;
      var_3 suicide();
    }

    var_0 thread scripts\cp\cp_hud_message::wait_and_play_tutorial_message("afterlife", 18);
    thread give_solo_self_revive_token(var_0);
  }

  if(isDefined(level.enter_afterlife_clear_player_scriptable_func)) {
    [[level.enter_afterlife_clear_player_scriptable_func]](var_0);
  }

  if(isDefined(level.aa_ww_char_vo)) {
    var_0 thread[[level.aa_ww_char_vo]](var_0);
  } else {
    var_0 thread scripts\cp\cp_vo::try_to_play_vo("ww_afterlife_arrive", "zmb_afterlife_vo", "high", 20, 0, 0, 1);
  }

  if(isDefined(level.aa_memoirs_vo)) {
    var_0 thread[[level.aa_memoirs_vo]](var_0);
  }

  var_0 thread freeze_controls_for_time();
}

freeze_controls_for_time() {
  self endon("disconnect");
  self goal_head_icon(0);
  wait 3;
  self goal_head_icon(1);
}

play_ww_vo_memoirs(var_0) {
  var_0 endon("disconnect");
  var_0 endon("death");
  level endon("game_ended");
  var_0 endon("player_done_exit_afterlife");
  wait(randomintrange(30, 40));

  if(!isDefined(var_0.array_of_memoir_vos)) {
    var_0.array_of_memoir_vos = ["ww_afterlife_memoir_1", "ww_afterlife_memoir_2", "ww_afterlife_memoir_3", "ww_afterlife_memoir_4", "ww_afterlife_memoir_5", "ww_afterlife_memoir_6", "ww_afterlife_memoir_7", "ww_afterlife_memoir_8"];
  }

  while(var_0.array_of_memoir_vos.size > 0) {
    if(randomint(100) < 30) {
      scripts\engine\utility::play_sound_in_space(var_0.array_of_memoir_vos[0], level.willard_speaker.origin);
    }

    var_0.array_of_memoir_vos = scripts\engine\utility::array_remove(var_0.array_of_memoir_vos, var_0.array_of_memoir_vos[0]);

    if(isDefined(var_0.array_of_memoir_vos[0])) {
      if(soundexists(var_0.array_of_memoir_vos[0])) {
        wait(randomfloatrange(80.0, 110.0) + scripts\cp\cp_vo::get_sound_length(var_0.array_of_memoir_vos[0]));
      }

      continue;
    }

    wait(randomfloatrange(120.0, 180.0));
  }
}

choose_correct_vo_for_player(var_0) {
  wait 10;
  var_1 = "";

  if(var_0.times_self_revived >= var_0.max_self_revive_machine_use) {
    var_1 = "ww_afterlife_p4_notoken";
  } else {
    var_2 = ["ww_afterlife_p1_generic", "ww_afterlife_p5_alt_1", "ww_afterlife_arrive"];
    var_1 = scripts\engine\utility::random(var_2);
  }

  if(var_1 == "ww_afterlife_arrive") {
    var_0 thread scripts\cp\cp_vo::try_to_play_vo(var_1, "zmb_afterlife_vo", "high", 20, 0, 0, 1);
    return;
  }

  var_3 = strtok(var_1, "_");
  var_4 = "";
  var_5 = var_3[3];
  var_6 = var_0.vo_suffix;
  var_7 = strtok(var_6, "_");
  var_8 = var_7[0];

  switch (var_8) {
    case "p5":
    case "p4":
    case "p3":
    case "p2":
    case "p1":
      var_4 = choose_vo_based_on_type(var_8, var_5);
      break;
    default:
      var_4 = var_1;
      break;
  }

  if(soundexists(var_4)) {
    var_0 thread scripts\cp\cp_vo::try_to_play_vo(var_4, "zmb_afterlife_vo", "high", 60, 1, 0, 1);
  }
}

choose_vo_based_on_type(var_0, var_1) {
  var_2 = "ww_afterlife_";

  for(;;) {
    var_2 = "ww_afterlife_";

    switch (var_1) {
      case "generic":
        var_2 = var_2 + var_0 + "_generic";
        break;
      case "notoken":
        var_2 = var_2 + var_0 + "_notoken";
        break;
      case "alt":
        var_2 = var_2 + var_0 + "_alt_1";
        break;
      default:
        break;
    }

    if(!soundexists(var_2)) {
      var_3 = ["ww_afterlife_p1_generic", "ww_afterlife_arrive", "ww_afterlife_p5_alt_1"];
      var_2 = scripts\engine\utility::random(var_3);

      if(var_2 == "ww_afterlife_arrive") {
        return var_2;
      } else {
        var_4 = strtok(var_2, "_");
        var_1 = var_4[3];
        continue;
      }
    } else
      return var_2;

    scripts\engine\utility::waitframe();
  }

  return var_2;
}

clearplayersweaponlevels(var_0) {
  var_0.pap = [];
}

get_afterlife_arcade_start_point(var_0) {
  var_1 = scripts\engine\utility::getstructarray("afterlife_arcade", "targetname");

  if(isDefined(level.additional_afterlife_arcade_start_point)) {
    var_1 = scripts\engine\utility::array_combine(var_1, level.additional_afterlife_arcade_start_point);
  }

  var_1 = scripts\engine\utility::array_randomize(var_1);

  foreach(var_3 in var_1) {
    if(can_spawn_at_afterlife_arcade_start_point(var_3, var_0)) {
      return var_3;
    }
  }

  return scripts\engine\utility::random(var_1);
}

can_spawn_at_afterlife_arcade_start_point(var_0, var_1) {
  var_2 = 16;

  foreach(var_4 in level.players) {
    if(var_4 == var_1) {
      continue;
    }
    if(distance2d(var_0.origin, var_4.origin) < var_2) {
      return 0;
    }
  }

  return 1;
}

try_exit_afterlife_arcade(var_0) {
  if(is_in_afterlife_arcade(var_0)) {
    exit_afterlife_arcade(var_0);
  }
}

clear_up_all_vo_in_afterlife(var_0) {
  foreach(var_2 in level.vo_priority_level) {
    if(isDefined(var_0.vo_system.vo_queue[var_2]) && var_0.vo_system.vo_queue[var_2].size > 0) {
      foreach(var_4 in var_0.vo_system.vo_queue[var_2]) {
        if(isDefined(var_4)) {
          if(issubstr(var_4.alias, "afterlife")) {
            var_0 stopolcalsound(var_4.alias);
          }
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
    var_0 stopolcalsound(var_7);
  }
}

exit_afterlife_arcade(var_0) {
  if(var_0.logevent == "wave_complete") {
    var_0.reason = "Wave Complete";
  } else {
    var_0.reason = "Self Revive";
  }

  if(var_0 hasweapon("iw7_gunless_zm")) {
    var_0 giveuponsuppressiontime("iw7_gunless_zm");
  }

  level thread close_afterlife_door_for_player(var_0);
  level thread clear_up_all_vo_in_afterlife(var_0);

  if(isDefined(var_0.disabledmelee) && var_0.disabledmelee >= 1) {
    var_0 scripts\engine\utility::allow_melee(1);
  }

  var_0.exitingafterlifearcade = 1;
  var_0.timespentinafterlife = (gettime() - var_0.timeenteringafterlife) / 1000;
  scripts\cp\zombies\zombie_analytics::log_exitingafterlifearcade(1, var_0, level.wave_num, var_0.reason, var_0.timespentinafterlife);
  var_0 scripts\engine\utility::allow_usability(0);
  var_0 set_in_afterlife_arcade(var_0, 0);
  var_0 afterlife_disable_player_outline(var_0, 0);
  var_0 scripts\cp\utility::showheadicon(var_0.icons_to_hide_when_in_afterlife);
  var_0 visionsetnakedforplayer("", 0);
  var_0 setclientomnvar("zm_ui_player_in_afterlife_arcade", 0);
  var_0.is_off_grid = undefined;
  var_0.is_in_pap = undefined;
  var_0 setclientomnvar("zombie_afterlife_soul_power_needed", -1);
  var_0 thread play_exit_afterlife_arcade_vo(var_0);
  var_0 notify("player_done_exit_afterlife");
}

play_exit_afterlife_arcade_vo(var_0) {
  var_0 endon("disconnect");

  if(isDefined(var_0.ignoreselfrevive)) {
    return;
  }
  wait 4.0;

  if(!isDefined(var_0.num_of_times_exit_afterlife_arcade)) {
    var_0.num_of_times_exit_afterlife_arcade = 0;
  }

  var_0.num_of_times_exit_afterlife_arcade++;

  if(var_0.num_of_times_exit_afterlife_arcade == 1) {
    var_0 thread scripts\cp\cp_vo::try_to_play_vo("arcade_token_revive_first", "zmb_comment_vo", "low", 3, 0, 0, 1);
  } else {
    var_0 thread scripts\cp\cp_vo::try_to_play_vo("arcade_token_revive", "zmb_comment_vo", "low", 3, 0, 0, 1);
  }
}

delete_move_ent() {
  wait 0.1;
  self delete();
}

delay_set_player_angles(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("player_exit_afterlife");
  scripts\engine\utility::waitframe();
  var_0 setplayerangles(var_1);
}

black_screen_fades_in(var_0) {
  var_0 endon("disconnect");
  var_1 = newclienthudelem(var_0);
  var_1.x = 0;
  var_1.y = 0;
  var_1 setshader("black", 640, 480);
  var_1.alignx = "left";
  var_1.aligny = "top";
  var_1.sort = 1;
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1.alpha = 1;
  var_1.foreground = 1;
  var_1 fadeovertime(15.0);
  var_1.alpha = 0;
  var_1 scripts\cp\utility::waittill_any_ents_or_timeout_return(15.0, var_0, "player_exit_afterlife", level, "game_ended");
  var_1 destroy();
}

afterlife_enable_player_interaction(var_0) {
  var_0.interaction_trigger = scripts\cp\cp_interaction::get_player_interaction_trigger();
  scripts\cp\cp_interaction::reset_interaction_triggers();
  var_0.last_interaction_point = undefined;
  var_0.interaction_trigger makeunusable();
  var_0 thread afterlife_release_player_interaction_trigger();
  var_0 thread scripts\cp\cp_interaction::player_interaction_monitor();
}

afterlife_release_player_interaction_trigger() {
  var_0 = self.interaction_trigger;
  scripts\engine\utility::waittill_any("player_exit_afterlife", "spawned", "disconnect");
  var_0.in_use = 0;
}

set_in_afterlife_arcade(var_0, var_1) {
  var_0.in_afterlife_arcade = var_1;
}

afterlife_disable_player_outline(var_0, var_1) {
  var_0.no_outline = var_1;
  var_0.no_team_outlines = var_1;
}

is_in_afterlife_arcade(var_0) {
  return scripts\engine\utility::is_true(var_0.in_afterlife_arcade);
}

init_spectate_door() {}

init_selfrevive_door() {}

use_spectate_door(var_0, var_1) {
  if(level.players.size == 1) {
    var_1 scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"CP_ZOMBIE_AFTERLIFE_ARCADE_CANNOT_SPECTATE");
    return;
  }

  var_1.pre_spectate_pos = var_1.origin;
  var_1.pre_spectate_angles = var_1 getplayerangles();
  var_1 scripts\cp\cp_globallogic::enterspectator();
  var_1 thread exit_spectator_request_monitor(var_1);
}

exit_spectator_request_monitor(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("player_exit_afterlife");
  var_0 endon("spawned");
  var_0 notifyonplayercommand("release_use_button", "-usereload");
  var_0 notifyonplayercommand("release_use_button", "-activate");
  var_0 notifyonplayercommand("press_use_button", "+usereload");
  var_0 notifyonplayercommand("press_use_button", "+activate");
  var_0 waittill("release_use_button");
  var_0 waittill("press_use_button");
  var_0 scripts\cp\utility::updatesessionstate("playing");
  var_0 spawn(var_0.pre_spectate_pos, var_0.pre_spectate_angles);
  var_0 allowdoublejump(0);
  var_0 allowwallrun(0);
}

use_selfrevive_door(var_0, var_1) {
  var_1 endon("disconnect");

  if(var_1 scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    if(!scripts\engine\utility::is_true(level.dont_resume_wave_after_solo_afterlife)) {
      level thread resumespawningaftertime();
    }
  }

  if(!isDefined(var_1.ignoreselfrevive)) {
    var_1 add_white_screen();
  }

  if(isDefined(var_1.disabledmelee) && var_1.disabledmelee >= 1) {
    var_1 scripts\engine\utility::allow_melee(1);
  }

  if(!isDefined(var_1.ignoreselfrevive)) {
    move_through_tube(var_1, "fast_travel_tube_start", "fast_travel_tube_end");
    var_1 thread remove_white_screen(0.1);
  }

  var_1 notify("player_exit_afterlife");
  var_1 scripts\cp\cp_laststand::instant_revive(var_1);
  var_1 setclientomnvar("zombie_afterlife_soul_power_earned", 0);
  var_1 setclientomnvar("zombie_afterlife_soul_power_goal", 0);
  var_1 setclientomnvar("zombie_afterlife_soul_power_needed", -1);
  var_1 set_has_self_revive_token(var_1, 0);

  if(var_1 scripts\cp\utility::is_consumable_active("self_revive")) {
    return;
  }
  if(var_1 scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    var_1.times_self_revived = var_1.self_revives_purchased;
    var_2 = var_1.max_self_revive_machine_use - var_1.times_self_revived;
  } else {
    var_1.times_self_revived = var_1.times_self_revived + 1;
    var_2 = int(level.wave_num / 10) + 1 - var_1.times_self_revived;
  }

  var_1 setclientomnvar("zombie_afterlife_self_revive_count", int(max(var_2, 0)));
  var_1 thread set_spawn_defaults();
}

set_spawn_defaults() {
  self endon("disconnect");
  wait 0.15;
  self allowdoublejump(0);
  self allowslide(1);
  self allowwallrun(0);
  self allowdodge(0);
  self func_8426(0);
  self func_8425(0);
  self func_8454(3);

  if(isDefined(level.player_suit)) {
    self setsuit(level.player_suit);
  } else {
    self setsuit("zom_suit");
  }

  self.suit = "zom_suit";
}

resumespawningaftertime() {
  level endon("game_ended");
  wait 20;
  level.zombies_paused = 0;
  scripts\engine\utility::flag_clear("pause_wave_progression");
}

update_player_revives_every_ten_waves(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_1 = 0;

  while(var_1 < 2) {
    level scripts\engine\utility::waittill_any("regular_wave_starting", "event_wave_starting");

    if(var_0 scripts\cp\utility::isplayingsolo() || level.only_one_player) {
      continue;
    } else {
      var_2 = int(level.wave_num / 10) + 1 - var_0.times_self_revived;
    }

    var_0 setclientomnvar("zombie_afterlife_self_revive_count", int(max(var_2, 0)));
    var_1++;
  }
}

move_through_tube(var_0, var_1, var_2) {
  var_3 = getent(var_1, "targetname");
  var_4 = getent(var_2, "targetname");

  if(!isDefined(var_3) || !isDefined(var_4)) {
    return;
  }
  var_0 earthquakeforplayer(0.3, 0.2, var_0.origin, 200);
  var_0 cancelmantle();
  var_0.no_outline = 1;
  var_0.no_team_outlines = 1;
  var_5 = var_3.origin + (0, 0, -45);
  var_6 = var_4.origin + (0, 0, -45);
  var_0.is_fast_traveling = 1;
  var_0 scripts\cp\utility::allow_player_ignore_me(1);
  var_0 dontinterpolate();
  var_0 setorigin(var_5);
  var_0 setplayerangles(var_3.angles);
  var_0 playlocalsound("zmb_portal_travel_lr");
  var_7 = spawn("script_origin", var_5);
  var_0 getweaponvariantattachments(var_7);
  wait 0.1;
  var_7 moveto(var_6, 1);
  var_0 thread remove_white_screen(0.1);
  wait 1;
  var_0.is_fast_traveling = undefined;

  if(var_0 scripts\cp\utility::isignoremeenabled()) {
    var_0 scripts\cp\utility::allow_player_ignore_me(0);
  }

  var_0.no_outline = 0;
  var_0.no_team_outlines = 0;

  if(isDefined(level.portal_exit_fx_org)) {
    var_8 = anglesToForward((0, 90, 0));
    playFX(level._effect["vfx_zmb_portal_exit_burst"], level.portal_exit_fx_org, var_8);
  }

  var_0 add_white_screen();
  var_7 thread delete_move_ent();
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

remove_white_screen(var_0) {
  self endon("disconnect");

  if(isDefined(var_0)) {
    wait(var_0);
  }

  if(isDefined(self.white_screen_overlay)) {
    self.white_screen_overlay.alpha = 0;
    wait 0.1;

    if(isDefined(self.white_screen_overlay)) {
      self.white_screen_overlay destroy();
    }
  }
}

can_use_selfrevive_door(var_0, var_1) {
  if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::is_true(level.only_one_player)) {
    return 1;
  }

  if(has_self_revive_token(var_1)) {
    return 1;
  }

  return 0;
}

get_self_revive_door_hint(var_0, var_1) {
  if(check_self_revive_attempts(var_1)) {
    if(has_self_revive_token(var_1) || scripts\cp\utility::isplayingsolo() || scripts\engine\utility::is_true(level.only_one_player)) {
      return &"CP_ZOMBIE_AFTERLIFE_ARCADE_SELFREVIVE_DOOR";
    } else {
      return &"CP_ZOMBIE_AFTERLIFE_ARCADE_NEED_SELFREVIVE_TOKEN";
    }
  } else
    return &"CP_ZOMBIE_AFTERLIFE_ARCADE_NO_MORE_SELF_REVIVES";
}

give_self_revive_token(var_0) {
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("arcade_token_earn", "zmb_comment_vo", "low", 3, 0, 0, 1);
  var_0 playlocalsound("zmb_ala_soul_meter_filled");
  var_0 set_has_self_revive_token(var_0, 1);
  var_0.soul_power_earned = 0;
  var_0.soul_power_displayed = 0;
  level thread open_afterlife_door_for_player(var_0, 165);
  wait 5;
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("ww_afterlife_overstay", "zmb_afterlife_vo", "high", undefined, undefined, undefined, 1);
}

give_solo_self_revive_token(var_0) {
  var_0 playlocalsound("zmb_ala_soul_meter_filled");
  var_0 set_has_self_revive_token(var_0, 1);
  var_0 setclientomnvar("zombie_afterlife_soul_power_needed", -1);
  var_0.soul_power_earned = 0;
  var_0.soul_power_displayed = 0;
  level thread open_afterlife_door_for_player(var_0, 165);
}

open_afterlife_door_for_player(var_0, var_1) {
  if(!isDefined(level.ala_portal_org)) {
    level.ala_revive_door = getent("ala_revive_door", "targetname");
    var_2 = scripts\engine\utility::getstruct("selfrevive_portal", "targetname");
    level.ala_portal_org = spawn("script_model", var_2.origin);
    level.ala_portal_org setModel("tag_origin");
    level.ala_portal_org.angles = var_2.angles;
    wait 0.1;
  }

  if(!isDefined(var_0.revive_door)) {
    var_0.revive_door = spawn("script_model", level.ala_revive_door.origin + (0, 0, -300));
    var_0.revive_door setModel(level.ala_revive_door.model);
    var_0.revive_door.angles = level.ala_revive_door.angles;

    foreach(var_4 in level.players) {
      if(var_4 != var_0) {
        var_0.revive_door hidefromplayer(var_4);
      }
    }

    wait 0.1;
    var_0.revive_door.origin = var_0.revive_door.origin + (0, 0, 300);
    wait 0.1;
    level.ala_revive_door hidefromplayer(var_0);
  }

  var_0.revive_door rotateyaw(var_1, 0.2);
  var_6 = level._effect["vfx_zmb_portal_centhub"];

  if(isDefined(level.centhub_portal_fx)) {
    var_6 = level.centhub_portal_fx;
  }

  playfxontagforclients(var_6, level.ala_portal_org, "tag_origin", var_0);
}

close_afterlife_door_for_player(var_0) {
  if(isDefined(var_0.revive_door)) {
    var_0.revive_door.angles = level.ala_revive_door.angles;
  }

  _stopfxontagforclients(level._effect["vfx_zmb_portal_centhub"], level.ala_portal_org, "tag_origin", var_0);
}

set_has_self_revive_token(var_0, var_1) {
  var_0.has_self_revive_token = var_1;

  if(var_1 == 1) {
    var_0 setclientomnvar("zombie_afterlife_has_self_revive_token", 1);
  } else {
    var_0 setclientomnvar("zombie_afterlife_has_self_revive_token", 0);
  }
}

has_self_revive_token(var_0) {
  return scripts\engine\utility::is_true(var_0.has_self_revive_token);
}

check_self_revive_attempts(var_0) {
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    return 1;
  } else if(scripts\engine\utility::is_true(var_0.have_gns_perk)) {
    return 1;
  } else if(var_0.times_self_revived >= var_0.max_self_revive_machine_use) {
    return 0;
  } else if(int(level.wave_num / 10) + 1 - var_0.times_self_revived >= 1) {
    return 1;
  } else {
    return 0;
  }
}

player_exit_afterlife_monitor(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("player_done_exit_afterlife");
  var_0 scripts\engine\utility::waittill_any_return("player_exit_afterlife", "spawned");
  var_0 exit_afterlife_arcade(var_0);
}

init_afterlife_arcade() {
  level.timesinafterlife = 0;
  level.player_bleed_out_func = ::enter_afterlife_arcade;
}

start_afterlife_arcade_music() {
  var_0 = spawn("script_origin", (-10100, 114, -1753));
  var_0 playLoopSound("zmb_afterlife_music");
}

player_enter_transition_monitor(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("player_done_exit_afterlife");
  wait 3.0;

  if(check_self_revive_attempts(var_0)) {
    turn_on_soul_power_progress_bar(var_0);
  }

  var_0 visionsetnakedforplayer("", 2.0);
}

turn_on_soul_power_progress_bar(var_0) {
  var_0 setclientomnvar("zombie_afterlife_soul_power_earned", var_0.soul_power_earned);
  var_0 setclientomnvar("zombie_afterlife_soul_power_needed", var_0.soul_power_goal);
  var_0 setclientomnvar("zombie_afterlife_soul_power_goal", var_0.soul_power_goal);
}

player_init_afterlife(var_0) {
  var_0.icons_to_hide_when_in_afterlife = [];
}

add_to_icons_to_hide_in_afterlife(var_0, var_1) {
  var_0.icons_to_hide_when_in_afterlife[var_0.icons_to_hide_when_in_afterlife.size] = var_1;
}

remove_from_icons_to_hide_in_afterlife(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0.icons_to_hide_when_in_afterlife = scripts\engine\utility::array_remove(var_0.icons_to_hide_when_in_afterlife, var_1);
  var_0.icons_to_hide_when_in_afterlife = scripts\engine\utility::array_removeundefined(var_0.icons_to_hide_when_in_afterlife);
}

init_soul_power(var_0) {
  var_0.soul_power_earned = 0;
  var_0.soul_power_displayed = 0;
  var_0.times_self_revived = 0;
  var_0.soul_power_goal = get_soul_power_goal(var_0);
}

give_soul_power(var_0, var_1) {
  if(check_self_revive_attempts(var_0) && !has_self_revive_token(var_0)) {
    var_0.soul_power_earned = var_0.soul_power_earned + var_1;
    var_0 thread display_soul_power_earned(var_0);
  }
}

display_soul_power_earned(var_0) {
  var_0 notify("display_soul_power_earned");
  level endon("game_ended");
  var_0 endon("display_soul_power_earned");
  var_0 endon("revive");

  while(var_0.soul_power_displayed < min(var_0.soul_power_earned, var_0.soul_power_goal)) {
    var_1 = min(var_0.soul_power_earned, var_0.soul_power_goal);
    var_2 = var_0.soul_power_displayed + 5;
    var_0.soul_power_displayed = min(var_2, var_1);
    var_0 setclientomnvar("zombie_afterlife_soul_power_earned", int(var_0.soul_power_displayed));
    var_0 setclientomnvar("zombie_afterlife_soul_power_needed", int(var_0.soul_power_goal - var_0.soul_power_displayed));
    scripts\engine\utility::waitframe();
  }

  if(var_0.soul_power_earned >= var_0.soul_power_goal) {
    if(check_self_revive_attempts(var_0)) {
      give_self_revive_token(var_0);
    }
  }
}

increase_afterlife_count(var_0) {
  if(!isDefined(var_0.num_times_in_afterlife)) {
    var_0.num_times_in_afterlife = 0;
  }

  var_0.num_times_in_afterlife++;
}

get_soul_power_goal(var_0) {
  if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::is_true(level.only_one_player)) {
    return 0;
  } else {
    return 200;
  }
}

register_interactions() {
  level.interaction_hintstrings["afterlife_spectate_door"] = &"CP_ZOMBIE_AFTERLIFE_ARCADE_SPECTATE_DOOR";
  scripts\cp\cp_interaction::register_interaction("afterlife_spectate_door", undefined, undefined, undefined, ::use_spectate_door, 0, 0, ::init_spectate_door);
  scripts\cp\cp_interaction::register_interaction("afterlife_selfrevive_door", undefined, undefined, ::get_self_revive_door_hint, ::use_selfrevive_door, 0, 0, ::init_selfrevive_door, ::can_use_selfrevive_door);
}

reset_soul_power(var_0) {
  var_0.soul_power_earned = 0;
  var_0.soul_power_displayed = 0;
  var_0 setclientomnvar("zombie_afterlife_soul_power_earned", var_0.soul_power_earned);
}