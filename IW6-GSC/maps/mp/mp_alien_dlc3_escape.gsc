/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_alien_dlc3_escape.gsc
********************************************/

hide_escape_geo(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 connectpaths();
  var_1 notsolid();
  var_1 hide();
  var_2 = undefined;

  switch (var_0) {
    case "escape_blocker_1_forcefield":
      var_2 = "escape_blocker_1";
      break;
    case "escape_blocker_2_forcefield":
      var_2 = "escape_blocker_2";
      break;
    case "escape_blocker_3_forcefield":
      var_2 = "escape_blocker_3";
      break;
  }

  var_3 = getent(var_2, "targetname");

  if(isDefined(var_3)) {
    var_3 setscriptablepartstate(0, "ff_down");
  }
}

show_escape_geo(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 disconnectpaths();
  var_1 solid();
  var_1 show();
  var_2 = undefined;

  switch (var_0) {
    case "escape_blocker_1_forcefield":
      var_2 = "escape_blocker_3";
      break;
    case "escape_blocker_2_forcefield":
      var_2 = "escape_blocker_2";
      break;
    case "escape_blocker_3_forcefield":
      var_2 = "escape_blocker_1";
      break;
  }

  var_3 = getent(var_2, "targetname");

  if(isDefined(var_3)) {
    var_3 setscriptablepartstate(0, "open");
  }
}

escape_timer() {
  level endon("game_ended");
  common_scripts\utility::exploder(102);
  set_escape_earthquake_values(0.12, 0.18, 3, 5);
  level thread escape_earthquakes();

  foreach(var_1 in level.players) {
    var_1 thread escape_timer_fx();
  }

  wait 300;
  level.escape_timer_expired = 1;

  if(!maps\mp\alien\_utility::is_true(level.final_blocker_finished)) {
    level thread maps\mp\gametypes\aliens::alienendgame("axis", 3);
  }
}

aud_loop_starts() {
  wait 10.5;
  level.aud_shake = spawn("script_origin", (3877, 1877, 1108));
  level.aud_shake playLoopSound("scn_descent_end_shake_lp");

  for(;;) {
    wait(randomfloatrange(4.0, 6.0));
    level.player playSound("scn_descent_end_debris");
  }
}

run_out_music() {
  wait 12;

  foreach(var_1 in level.players) {
    if(common_scripts\utility::flag("alien_music_playing")) {
      var_1 stoplocalsound("mp_suspense_01");
      var_1 stoplocalsound("mp_suspense_02");
      var_1 stoplocalsound("mp_suspense_03");
      var_1 stoplocalsound("mp_suspense_04");
      var_1 stoplocalsound("mp_suspense_05");
      var_1 stoplocalsound("mp_suspense_06");
      var_1 stoplocalsound("mus_alien_newwave");
      common_scripts\utility::flag_clear("alien_music_playing");
    }

    common_scripts\utility::flag_set("alien_music_playing");

    if(maps\mp\_utility::isreallyalive(var_1)) {
      var_1 playlocalsound("mus_alien_dlc3_ark_runout");
    }
  }
}

aud_end_logic() {
  level.aud_alarm = spawn("script_origin", (3631, 1779, 2106));
  level.aud_alarm playLoopSound("scn_descent_end_steam");
  level.aud_gen = spawn("script_origin", (3631, 1779, 2106));
  level.aud_gen playSound("scn_descent_end_gener");
  level.aud_loop = spawn("script_origin", (0, 0, 0));
  level.aud_loop playLoopSound("scn_descent_end_int_lp");
  thread aud_loop_starts();
  level thread quake_and_rumble(10);
}

quake_and_rumble(var_0) {
  wait(var_0);
  earthquake(0.4, 3, level.archer.origin, 2000);
  level thread maps\mp\alien\mp_alien_dlc3_ark::rumble_players("heavy_3s", 0);
}

escape_global_logic() {
  level endon("game_ended");
  maps\mp\alien\_utility::update_player_initial_spawn_info((2692, 1863, 899), (0, 0, 0));
  common_scripts\utility::flag_wait("ark_console_event_done");
  thread run_out_music();
  thread aud_end_logic();
  common_scripts\utility::flag_set("cortex_carryable");
  level.cortex_use_trigger sethintstring(&"MP_ALIEN_DESCENT_PICKUP_CORTEX");
  var_0 = gettime();
  setomnvar("ui_alien_nuke_timer", gettime() + 300000);
  level thread escape_timer();
  level thread nag_players_to_place_cortex();
  level thread nag_players_who_leave_the_drill_behind();
  level.should_use_custom_death_func = 1;
  level notify("dlc_vo_notify", "descent_vo", "escape_level");
  maps\mp\alien\_utility::update_player_initial_spawn_info((2692, 1863, 899), (0, 180, 0));
  escape_blocker_gate("escape_blocker_1_forcefield", 1, 18);
  maps\mp\alien\_utility::update_player_initial_spawn_info((-2167, 616, 1203), (0, -158, 0));
  escape_blocker_gate("escape_blocker_2_forcefield", 2, 18);
  maps\mp\alien\_utility::update_player_initial_spawn_info((-1385, -2506, 918), (0, -57, 0));
  escape_blocker_gate("escape_blocker_3_forcefield", 3, 18);
  level.should_use_custom_death_func = 0;
  level.final_blocker_finished = 1;
  level.current_cortex_spot = undefined;
  common_scripts\utility::flag_set("cortex_carryable");
  level.cortex_use_trigger makeusable();
  level.cortex_use_trigger sethintstring(&"MP_ALIEN_DESCENT_PICKUP_CORTEX");
  maps\mp\alien\_outline_proto::enable_outline_for_players(level.cortex, level.players, 3, 0, "high");
  var_1 = playFX(level._effect["escape_area"], (2368, -7056, 1151.22));
  var_2 = wait_for_players_to_escape();

  if(var_2.size == 0) {
    iprintlnbold(&"ALIEN_COLLECTIBLES_YOU_DIDNT_MAKE_IT");
    var_3 = maps\mp\alien\_hud::get_end_game_string_index("fail_escape");
    level thread maps\mp\gametypes\aliens::alienendgame("axis", var_3);
    return;
  }

  maps\mp\alien\_unlock::update_escape_item_unlock(var_2);

  foreach(var_5 in level.players) {
    if(common_scripts\utility::array_contains(var_2, var_5)) {
      var_5.dlc3_escaped = 1;
      var_5 maps\mp\alien\_persistence::set_player_escaped();
      continue;
    }

    var_5 iprintlnbold(&"ALIEN_COLLECTIBLES_YOU_DIDNT_MAKE_IT");
    var_5.dlc3_escaped = 0;
  }

  foreach(var_5 in level.players) {
    if(maps\mp\alien\_utility::is_true(var_5.dlc3_escaped)) {
      var_5 maps\mp\alien\_persistence::award_completion_tokens();
    }
  }

  thread descent_win_music();
  maps\mp\alien\_achievement_dlc3::update_progression_achievements("awakening_escape");
  var_9 = "all_escape";

  if(var_2.size != level.players.size) {
    var_9 = "some_escape";
  }

  var_10 = gettime() - var_0;
  update_lb_aliensession_dlc3_escape(var_10);
  var_11 = maps\mp\alien\_hud::get_end_game_string_index(var_9);
  level thread maps\mp\gametypes\aliens::alienendgame("allies", var_11);
}

wait_for_players_to_escape() {
  var_0 = 22500;
  var_1 = [];
  var_2 = [];

  while(!maps\mp\alien\_utility::is_true(level.escape_timer_expired)) {
    var_1 = [];
    var_2 = [];
    var_3 = 1;

    foreach(var_5 in level.players) {
      if(isDefined(var_5.laststand) && var_5.laststand) {
        var_1 = common_scripts\utility::add_to_array(var_1, var_5);
        continue;
      }

      if(distancesquared(var_5.origin, (2368, -7056, 1151.22)) <= var_0 && isalive(var_5)) {
        var_2 = common_scripts\utility::add_to_array(var_2, var_5);
        continue;
      }

      var_3 = 0;
    }

    if(var_3 && player_has_cortex_or_cortex_in_position()) {
      break;
    } else if(var_3 && !player_has_cortex_or_cortex_in_position())
      level thread display_cortex_warning();

    wait 0.05;
  }

  return var_2;
}

display_cortex_warning() {
  level endon("game_ended");

  if(maps\mp\alien\_utility::is_true(level.cortex_warning_issued)) {
    return;
  }
  level.cortex_warning_issued = 1;
  iprintlnbold(&"MP_ALIEN_DESCENT_CORTEX_LEFT_BEHIND");
  var_0 = ["descent_gdf_retrievethecortex", "descent_gdf_cortexbacktosurface"];
  maps\mp\_utility::playsoundinspace(common_scripts\utility::random(var_0), (0, 0, 0));
  wait 5;
  level.cortex_warning_issued = 0;
}

player_has_cortex_or_cortex_in_position() {
  foreach(var_1 in level.players) {
    if(var_1 hasweapon("aliencortex_mp")) {
      return 1;
    }
  }

  if(isDefined(level.cortex) && distancesquared(level.cortex.origin, (2368, -7056, 1151.22)) <= 10000) {
    return 1;
  }

  return 0;
}

update_lb_aliensession_dlc3_escape(var_0) {
  var_1 = get_lb_final_escape_rank(var_0);

  foreach(var_3 in level.players) {
    if(maps\mp\alien\_utility::is_true(var_3.dlc3_escaped)) {
      var_3 maps\mp\alien\_persistence::lb_player_update_stat("escapedRank" + var_1, 1, 1);
      var_3 maps\mp\alien\_persistence::lb_player_update_stat("hits", 1, 1);
    }
  }
}

get_lb_final_escape_rank(var_0) {
  var_1 = 210000;
  var_2 = 240000;
  var_3 = 270000;

  if(var_0 <= var_1) {
    return 0;
  } else if(var_0 <= var_2) {
    return 1;
  } else if(var_0 <= var_3) {
    return 2;
  } else {
    return 3;
  }
}

descent_win_music() {
  foreach(var_1 in level.players) {
    if(common_scripts\utility::flag("alien_music_playing")) {
      var_1 stoplocalsound("mp_suspense_01");
      var_1 stoplocalsound("mp_suspense_02");
      var_1 stoplocalsound("mp_suspense_03");
      var_1 stoplocalsound("mp_suspense_04");
      var_1 stoplocalsound("mp_suspense_05");
      var_1 stoplocalsound("mp_suspense_06");
      var_1 stoplocalsound("mus_alien_newwave");
      common_scripts\utility::flag_clear("alien_music_playing");
    }

    common_scripts\utility::flag_set("alien_music_playing");

    if(maps\mp\_utility::isreallyalive(var_1)) {
      var_1 playlocalsound("mus_alien_dlc3_win_screen");
    }
  }
}

escape_blocker_gate(var_0, var_1, var_2) {
  maps\mp\alien\_gamescore::reset_encounter_performance();
  var_3 = gettime();
  show_escape_geo(var_0);
  escape_blocker_logic(var_1, var_2, var_0);
  maps\mp\alien\_gamescore_dlc3::calculate_escape_blocker_score(gettime() - var_3);
}

get_win_condition() {
  foreach(var_1 in level.players) {
    if(maps\mp\alien\_utility::is_true(var_1.inlaststand)) {
      return "some_escape";
    }
  }

  return "all_escape";
}

escape_blocker_logic(var_0, var_1, var_2) {
  wait 1;
  iprintlnbold(&"MP_ALIEN_DESCENT_CORTEX_NEXT_AREA");
  common_scripts\utility::flag_set("cortex_carryable");
  level.cortex_use_trigger makeusable();
  level.cortex_use_trigger sethintstring(&"MP_ALIEN_DESCENT_PICKUP_CORTEX");
  maps\mp\alien\_outline_proto::enable_outline_for_players(level.cortex, level.players, 3, 0, "high");
  wait_for_player_to_place_cortex("escape_blocker_" + var_0 + "_cortex");
  common_scripts\utility::flag_clear("cortex_carryable");
  maps\mp\alien\_spawn_director::start_cycle(var_1);
  clear_cortex_lowermessage();
  setomnvar("ui_alien_boss_status", 2);
  setomnvar("ui_alien_boss_icon", 5);
  setomnvar("ui_alien_boss_progression", 100);
  level.cortex_use_trigger.origin = level.cortex.origin + (0, 0, 30);
  level.cortex_use_trigger sethintstring("");
  maps\mp\alien\_outline_proto::enable_outline_for_players(level.cortex, level.players, 1, 0, "high");
  level thread cortex_charge_monitor(var_0);
  level waittill("escape_forcefield_destroyed");
  wait 1;
  maps\mp\alien\_spawn_director::end_cycle();
  getent(var_2, "targetname") delete();
  var_3 = undefined;

  switch (var_0) {
    case 1:
      var_3 = "escape_blocker_3";
      break;
    case 2:
      var_3 = "escape_blocker_2";
      break;
    case 3:
      var_3 = "escape_blocker_1";
      break;
  }

  var_4 = getent(var_3, "targetname");
  var_4 setscriptablepartstate(0, "ff_down");
  level thread maps\mp\mp_alien_dlc3_vignettes::descent_vo_escape_barrier_down(var_0);
  iprintlnbold(&"MP_ALIEN_DESCENT_CORTEX_FF_DOWN");
  setomnvar("ui_alien_boss_status", 0);
  setomnvar("ui_alien_boss_icon", 5);
  setomnvar("ui_alien_boss_progression", 0);
}

cortex_charge_monitor(var_0) {
  level endon("escape_forcefield_destroyed");
  level endon("game_ended");
  var_1 = 10;
  var_2 = var_1 / 2;
  var_3 = 100 / var_1;

  for(;;) {
    level waittill("alien_killed", var_4, var_5, var_6);

    if(var_5 == "MOD_SUICIDE") {
      continue;
    }
    var_1--;

    if(var_1 < var_2) {
      level thread maps\mp\mp_alien_dlc3_vignettes::descent_vo_escape_cortex_charge_50(var_0);
      var_2 = -1;
    }

    if(var_1 <= 0) {
      setomnvar("ui_alien_boss_progression", var_3 * var_1);
      iprintln(&"MP_ALIEN_DESCENT_USE_THE_CORTEX");
      level thread maps\mp\mp_alien_dlc3_vignettes::descent_vo_escape_cortex_ready(var_0);
      level.cortex_use_trigger makeusable();
      level.cortex_use_trigger sethintstring(&"MP_ALIEN_DESCENT_CORTEX_USE");
      maps\mp\alien\_outline_proto::enable_outline_for_players(level.cortex, level.players, 3, 0, "high");
      level.cortex_use_trigger maps\mp\alien\mp_alien_dlc3_ark::wait_until_player_use_cortex();
      playFX(level._effect["cortex_blast"], level.cortex_use_trigger.origin);
      playsoundatpos(level.cortex_use_trigger.origin, "scn_cortex_activate");
      level thread maps\mp\alien\mp_alien_dlc3_ark::kill_aliens_with_cortex_pulse();
      setomnvar("ui_alien_boss_progression", 100);
      level notify("escape_forcefield_destroyed");
      break;
    }

    setomnvar("ui_alien_boss_progression", var_3 * var_1);
  }
}

escape_timer_fx() {
  self endon("disconnect");
  level endon("game_ended");
  level thread escape_falling_boulders_fx();
  thread escape_falling_debris_fx("escape_falling_debris_pa1", "end_falling_rocks_1");
  self notify("end_falling_rocks_1");
  set_escape_earthquake_values(0.18, 0.28, 2, 4);
  thread escape_falling_debris_fx("escape_falling_debris_pa2", "end_falling_rocks_2");
  wait 120;
  self notify("end_falling_rocks_2");
  set_escape_earthquake_values(0.32, 0.48, 1, 2);
  thread escape_falling_debris_fx("escape_falling_debris_pa3", "end_falling_rocks_3");
}

escape_falling_debris_fx(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  self endon(var_1);

  for(;;) {
    var_2 = spawnfxforclient(level._effect[var_0], self.origin + (0, 0, 750), self, anglestoup(self.angles));
    triggerfx(var_2);
    var_2 thread escape_falling_debris_fx_delete();
    wait(randomfloatrange(2, 3));
  }
}

set_escape_earthquake_values(var_0, var_1, var_2, var_3) {
  level.escape_earthquake_intensity_min = var_0;
  level.escape_earthquake_intensity_max = var_1;
  level.escape_earthquake_len_min = var_2;
  level.escape_earthquake_len_max = var_3;
  level.escape_earthquake_org = (28.4, 5.8, 3951.5);
}

escape_earthquakes() {
  level endon("game_ended");

  for(;;) {
    earthquake(randomfloatrange(level.escape_earthquake_intensity_min, level.escape_earthquake_intensity_max), randomfloatrange(level.escape_earthquake_len_min, level.escape_earthquake_len_max), level.escape_earthquake_org, 20000);
    wait(randomfloatrange(2, 3));
  }
}

escape_falling_debris_fx_delete() {
  wait 10;

  if(isDefined(self)) {
    self delete();
  }
}

escape_falling_boulders_fx() {
  self endon("disconnect");
  level endon("game_ended");
  var_0 = getent("fx_boulders_01", "targetname");
  var_1 = getent("fx_boulders_02", "targetname");
  var_2 = ["default", "rock1", "rock2", "rock3", "rock4", "rock5", "rock6", "rock7"];

  for(;;) {
    wait 0.01;
    wait(randomfloatrange(1.8, 3.3));
    var_0 setscriptablepartstate("base", "default");
    var_1 setscriptablepartstate("base", "default");
    wait 0.1;
    var_3 = common_scripts\utility::random(var_2);
    var_0 setscriptablepartstate("base", var_3);
    var_1 setscriptablepartstate("base", var_3);
  }
}

wait_for_player_to_place_cortex(var_0) {
  foreach(var_2 in level.players) {
    var_2 thread check_for_player_near_spot_with_cortex(var_0);
  }

  var_4 = common_scripts\utility::getstruct(var_0, "targetname");
  var_5 = "waypoint_alien_blocker";
  var_6 = 14;
  var_7 = 14;
  var_8 = 0.75;
  var_9 = var_4.origin + (0, 0, 50);
  var_10 = maps\mp\alien\_hud::make_waypoint(var_5, var_6, var_7, var_8, var_9);
  level thread wait_for_cortex_planted(var_0);
  level waittill("cortex_planted");
  var_10 destroy();
}

alien_death_trail(var_0) {
  playFX(level._effect["bio_trail"], var_0 + (0, 0, 32));
  wait 0.5;
  var_1 = spawnStruct();

  while(!isDefined(level.drill) && !isDefined(level.drill_carrier)) {
    wait 0.1;
  }

  if(isDefined(level.drill)) {
    var_1.origin = level.drill.origin + (0, 0, 0);
  } else if(isDefined(level.drill_carrier)) {
    var_1.origin = level.drill_carrier.origin + (0, 0, 0);
  }

  playFX(level._effect["bio_trail_cap"], var_1.origin);
}

do_trail_death() {
  wait 0.1;
  var_0 = common_scripts\utility::get_array_of_closest(self.origin, common_scripts\utility::getstructarray("bio_path", "targetname"));
  var_1 = distance(self.origin, var_0[0].origin);
  playFXOnTag(level._effect["bio_trail"], self, "tag_origin");
  var_2 = 1500;
  var_3 = var_0[0];
  var_4 = 0;

  if(var_1 > 1000) {
    var_3 = spawnStruct();

    while(!isDefined(level.drill) && !isDefined(level.drill_carrier)) {
      wait 0.1;
    }

    if(isDefined(level.drill)) {
      var_3.origin = level.drill.origin + (0, 0, 70);
    } else if(isDefined(level.drill_carrier)) {
      var_3.origin = level.drill_carrier.origin + (0, 0, 70);
    }

    var_4 = 1;
    var_1 = distance(self.origin, var_3.origin);
  }

  var_5 = var_1 / var_2;

  if(var_5 < 0.05) {
    var_5 = 0.05;
  }

  self moveto(var_3.origin, var_5);
  self waittill("movedone");

  if(var_4) {
    playFX(level._effect["tesla_shock"], self.origin + (0, 0, -50));
    self delete();
    return;
  }

  for(;;) {
    var_6 = common_scripts\utility::getstructarray(var_3.target, "targetname");
    var_7 = common_scripts\utility::random(var_6);
    var_1 = distance(var_3.origin, var_7.origin);
    var_5 = var_1 / var_2;
    self moveto(var_7.origin, var_5);
    self waittill("movedone");

    if(!isDefined(var_7.target)) {
      break;
    }

    var_3 = var_7;
  }

  playFX(level._effect["tesla_shock"], self.origin + (0, 0, -50));
  self delete();
}

clear_cortex_lowermessage() {
  foreach(var_1 in level.players) {
    var_1 maps\mp\_utility::clearlowermessage("plant_cortex");
  }
}

wait_for_cortex_planted(var_0) {
  var_1 = common_scripts\utility::getstruct(var_0, "targetname");

  for(;;) {
    level waittill("cortex_plant");
    level.cortex.origin = var_1.origin;
    level.cortex_use_trigger makeunusable();
    level.cortex_use_trigger sethintstring("");
    level notify("cortex_planted");
    return;
  }
}

check_for_player_near_spot_with_cortex(var_0) {
  self endon("disconnect");
  self endon("death");
  level endon("cortex_planted");
  var_1 = 6400;
  var_2 = common_scripts\utility::getstruct(var_0, "targetname");
  level.current_cortex_spot = var_2;

  for(;;) {
    if(isDefined(self.inlaststand) && self.inlaststand || common_scripts\utility::flag("drill_drilling") || isDefined(self.usingremote) || maps\mp\alien\_utility::is_true(self.iscarrying)) {
      wait 0.05;
      continue;
    }

    if(distancesquared(var_2.origin, self.origin) < var_1) {
      if(!isDefined(level.cortex_carrier) || isDefined(level.cortex_carrier) && level.cortex_carrier != self) {
        maps\mp\_utility::setlowermessage("plant_cortex", &"MP_ALIEN_DESCENT_CORTEX_HINT", undefined, 10);

        while(player_should_see_cortex_hint(var_2, var_1, 1)) {
          wait 0.05;
        }

        maps\mp\_utility::clearlowermessage("plant_cortex");
      } else {
        maps\mp\_utility::setlowermessage("plant_cortex", &"MP_ALIEN_DESCENT_CORTEX_PLANT", undefined, 10);

        while(player_should_see_cortex_hint(var_2, var_1, 0)) {
          wait 0.05;
        }

        maps\mp\_utility::clearlowermessage("plant_cortex");
      }
    }

    wait 0.05;
  }
}

player_should_see_cortex_hint(var_0, var_1, var_2) {
  if(distancesquared(var_0.origin, self.origin) > var_1) {
    return 0;
  }

  if(self.inlaststand) {
    return 0;
  }

  if(isDefined(self.usingremote)) {
    return 0;
  }

  if(maps\mp\alien\_utility::is_true(var_2)) {
    return 1;
  } else if(maps\mp\alien\_utility::is_true(self.iscarrying)) {
    return 0;
  }

  return 1;
}

nag_players_to_place_cortex() {
  level endon("cortex_plant");
  wait 30;
  var_0 = 20;

  for(;;) {
    wait(var_0);
    level thread maps\mp\mp_alien_dlc3_vignettes::descent_vo_escape_cortex_nag();
    var_0 = var_0 + 20;
  }
}

nag_players_who_leave_the_drill_behind() {
  var_0 = 2000;
  var_1 = var_0 * var_0;
  var_2 = 0;
  var_3 = 20;

  for(;;) {
    if(isDefined(level.cortex)) {
      var_2 = 0;

      foreach(var_5 in level.players) {
        if(distancesquared(var_5.origin, level.cortex.origin) < var_1) {
          var_2 = 1;
        }
      }

      if(!var_2) {
        level thread maps\mp\mp_alien_dlc3_vignettes::descent_vo_escape_cortex_left_behind();
      }
    }

    wait(var_3);
    var_3 = var_3 + 20;
  }
}