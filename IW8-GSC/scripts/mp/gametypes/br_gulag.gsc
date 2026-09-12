/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gulag.gsc
***********************************************/

function initgulag() {
  level.ref_12ca0 = getdvarfloat("scr_br_respawn_circleInterpPct", 0.75);

  if(!istrue(level.usegulag)) {
    return;
  }

  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("gulag")) {
    level.usegulag = 0;
    return;
  }

  setomnvar("ui_gulag_state", 1);
  setomnvar("ui_gulag_show_closing_state", 0);
  level.gulag = spawnStruct();
  level.gulag.arenaflag = getdvarint("scr_br_fc_flag", 1);
  level.gulag.maxplayers = getmaxplayers();
  level.gulag.maxuses = getdvarint("scr_br_fc_max_uses", 1);
  level.gulag.endonshutdown = getdvarint("scr_br_fc_end_on_shutdown", 3);
  level.gulag.timelimit = getdvarint("scr_br_fc_timelimit", 15);
  level.gulag.maxqueue = getdvarint("scr_br_fc_max_queue_wait", 3);
  level.gulag.onekillwin = getdvarint("scr_br_fc_one_kill_win", 1);
  level.gulag.multiarena = getdvarint("scr_br_fc_multi_arena", 1);
  level.gulag.planerespawn = getdvarint("scr_br_fc_plane_respawn", 0);
  level.gulag.trial_target_civilian_killed_func = getdvarint("scr_br_fc_intro_cinematic", 1);
  level.gulag.ref_14069 = getdvarint("scr_br_fc_useCellSpawns", 1);
  level.gulag.ref_1407f = getdvarint("scr_br_fc_useFloorRocks", 0);
  level.gulag.ref_13672 = getdvarint("scr_br_fc_spawnLoot", 0);
  level.gulag.lethaldelay = getdvarint("scr_br_fc_lethalDelay", 4);
  level.gulag.ref_1391b = getdvarint("scr_br_fc_prestream_geo_timeout", 9);
  level.gulag.ref_11f2d = getdvarint("scr_br_fc_numArmorHealth", 0);
  level.gulag.ref_11f19 = getdvarint("scr_br_gulag_nuketown", 0);
  level.gulag.untrack_enemy = getdvarint("scr_br_gulag_island", 0);
  level.gulag.impairedkill = getdvarint("scr_br_fc_countdownTime", 3);
  level.gulag.juggheli_spawner_jammer5_2 = getdvarint("scr_br_fc_defaultPlunder", 5);
  level.gulag.getaccessorylogicbyindex = getdvarint("scr_br_gulag_chair", 0);
  level.gulag.ref_142fb = getdvarint("scr_br_gulag_voices", 1);
  level.gulag.redeploytokenconvertamount = getdvarint("scr_redeployToken_convertAmount", 40);
  level.gulag.gulagtokenconvertamount = getdvarint("scr_gulagToken_convertAmount", 20);
  level.gulag.tokenconversiontime = getdvarint("scr_tokenConversion_messageDisplayTime", 5);
  _setdomflagiconinfo("waypoint_captureneutral", "neutral", "MP_BR_INGAME/DOM_CAPTURE", 0);
  _setdomflagiconinfo("waypoint_capture", "enemy", "MP_BR_INGAME/DOM_CAPTURE", 0);
  _setdomflagiconinfo("waypoint_defend", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", 0);
  _setdomflagiconinfo("waypoint_defending", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", 0);
  _setdomflagiconinfo("waypoint_contested", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 1);
  _setdomflagiconinfo("waypoint_taking", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", 1);
  _setdomflagiconinfo("waypoint_losing", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", 1);
  level.gulag.watch_for_near_objective_point = [];

  if(istrue(level.gulag.arenaflag)) {
    scripts\mp\gametypes\br_dom_quest::ref_13239();
  }

  level.gulag.arenas = gulaggetarenas();
  gulaggesturesinit();
  gulaginitloadouts();

  if(level.gulag.trial_target_civilian_killed_func) {
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&ref_12521);
  }

  if(level.gulag.ref_1407f) {
    scripts\engine\scriptable::ref_12f5b("brloot_rock", &rockused);
  }

  level.gulag.betting = getdvarint("scr_br_fc_betting", 0);

  if(level.gulag.betting) {
    if(!istrue(level.br_plunder_enabled)) {
      level.gulag.betting = 0;
    }

    if(getdvarint("scr_br_fc_countdownTime", 3) == 3) {
      level.gulag.impairedkill = 15;
    }
  }

  if(!isDefined(level.gulag.arenas[0].jailspawns[0].chair)) {
    level.gulag.getaccessorylogicbyindex = 0;
  }

  foreach(var_1 in level.gulag.arenas) {
    thread monitorgulag(level);
  }

  thread spawnac130();
  tracegroundheightexfil();
  level.playerzombieupdateongamepadchange = &ref_12aa8;
  level.playimpactfx = &ref_12aaa;
}

function _setdomflagiconinfo(var_0, var_1, var_2, var_3) {
  level.waypointcolors[var_0] = var_1;
  level.waypointbgtype[var_0] = 1;
  level.waypointstring[var_0] = var_2;
  level.waypointshader[var_0] = "ui_mp_br_mapmenu_icon_gulag_overtime_objective";
  level.waypointpulses[var_0] = var_3;
}

function tracegroundheightexfil() {
  game["dialog"]["gulag_spawn"] = "gulag_spawn";
  game["dialog"]["gulag_spawn_rules"] = "gulag_spawn_rules";
  game["dialog"]["gulag_objective"] = "gulag_objective";
  game["dialog"]["gulag_next"] = "gulag_next";
  game["dialog"]["gulag_win"] = "gulag_win";
  game["dialog"]["gulag_lose"] = "gulag_lose";
  game["dialog"]["gulag_teammate_gulag"] = "gulag_teammate_gulag";
  game["dialog"]["gulag_teammate_lose"] = "gulag_teammate_lose";
  game["dialog"]["gulag_teammate_win"] = "gulag_teammate_win";
  game["dialog"]["gulag_gulag_active"] = "gulag_gulag_active";
  game["dialog"]["gulag_gulag_close"] = "gulag_gulag_close";
  game["dialog"]["gulag_noenemy"] = "gulag_noenemy";
  game["dialog"]["gulag_timeout"] = "gulag_timeout";
  game["dialog"]["gulag_buyback"] = "gulag_buyback";
  game["dialog"]["gulag_taunt"] = "gulag_taunt";
  game["dialog"]["gulag_obj_wait"] = "gulag_obj_wait";
}

function gulaggetarenas() {
  var_0 = relic_steelballs_dash();

  if(scripts\mp\gametypes\br_public::tutorial_playSound()) {
    var_0 = scripts\engine\utility::getStructArray("gulag_tutorial", "targetname");
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];
    var_2.set_relic_oneclip = var_1;
    setuparena(var_2);
  }

  return var_0;
}

function relic_steelballs_dash() {
  var_0 = scripts\engine\utility::getStructArray("gulag", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "nuketown";

    if(istrue(level.gulag.ref_11f19) && var_4 || !istrue(level.gulag.ref_11f19) && !var_4) {
      var_1 = var_3;
    }
  }

  if(var_1.size > 0) {
    var_0 = var_1;
  }

  if(var_0.size > 1) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}

function setuparena(var_0) {
  var_0.jailspawns = [];
  var_0.fightspawns = [];
  var_0.get_wave_spawn_total = [];
  var_0.gates = [];
  var_0.floor = [];
  var_0.weapons = [];
  var_0.molotovs = [];
  var_0.ref_13b29 = [];
  var_0.getactiveteamcount = [];
  var_0.ref_12d93 = [];
  var_0.jailedplayers = [];
  var_0.arenaplayers = [];
  var_0.matches = [];
  var_0.loadingplayers = [];
  var_0.fightover = 1;
  var_0.ref_11fcf = [];
  var_0.ref_11fcf["ui_br_gulag_players_1"] = 0;
  var_0.ref_11fcf["ui_br_gulag_data"] = 0;
  var_1 = [];
  var_2 = scripts\engine\utility::getStructArray(var_0.target, "targetname");

  foreach(var_4 in var_2) {
    if(var_4.script_noteworthy == "prison_spawn") {
      var_0.jailspawns[var_0.jailspawns.size] = var_4;
      continue;
    }

    if(var_4.script_noteworthy == "fight_spawn") {
      var_0.fightspawns[var_0.fightspawns.size] = var_4;
      continue;
    }

    if(var_4.script_noteworthy == "cell_spawn") {
      var_0.get_wave_spawn_total[var_0.get_wave_spawn_total.size] = var_4;
      continue;
    }

    if(var_4.script_noteworthy == "gulag_center") {
      var_0.center = var_4.origin;
      continue;
    }

    if(var_4.script_noteworthy == "spectator") {
      var_0.ref_136dc = var_4;
      continue;
    }

    if(isDefined(var_4.script_parameters) && var_4.script_parameters == "gulag_loot") {
      var_1 = var_4;
      continue;
    }

    if(var_4.script_noteworthy == "voices") {
      var_0.ref_12d93[var_0.ref_12d93.size] = var_4;
    }
  }

  if(!isDefined(var_0.center)) {
    var_0.center = getgulagcenter(var_0);
  }

  if(getdvarint("scr_br_fc_shifted_spawns", 1) > 0) {
    var_0.fightspawns = scripts\engine\utility::array_sort_with_func(var_0.fightspawns, &hidequestobjiconfromplayer);
  } else {
    var_0.fightspawns = scripts\engine\utility::array_sort_with_func(var_0.fightspawns, &hiderespawntimer);
  }

  foreach(var_7 in var_0.get_wave_spawn_total) {
    ref_1322e(var_0, var_7);
  }

  var_0.get_wave_spawn_total = scripts\engine\utility::array_sort_with_func(var_0.get_wave_spawn_total, &hiderespawntimer);

  foreach(var_10 in var_0.jailspawns) {
    ref_13255(var_0, var_10);
  }

  if(istrue(level.gulag.ref_13672)) {
    var_0.weapons = spawnlootweapons(var_1);
  }

  spawnrocks(var_0);

  if(istrue(level.gulag.arenaflag)) {
    ref_1323a(var_0);
    return;
  }
}

function gulaggesturesinit() {
  level.gulag.gestures_enabled = getdvarint("scr_br_fc_gestures", 0);

  if(!istrue(level.gulag.gestures_enabled)) {
    return;
  }

  level.gulag.gestures = [];
  level.gulag.gestures["fc_gesture_neg"] = ["iw8_ges_plyr_gesture_crush", "iw8_ges_plyr_gesture_rally", "iw8_ges_plyr_gesture_revive"];
  level.gulag.gestures["fc_gesture_pos"] = ["iw8_ges_plyr_gesture_doubletime", "iw8_ges_plyr_gesture_hold", "iw8_ges_plyr_gesture_ok", "iw8_ges_plyr_gesture_thumbs_up"];
  level.gulag.gesturesounds["fc_gesture_neg"] = ["tmp_gulag_gesture_neg_crush", "tmp_gulag_gesture_neg_rally", "tmp_gulag_gesture_neg_revive"];
  level.gulag.gesturesounds["fc_gesture_pos"] = ["tmp_gulag_gesture_pos_doubletime", "tmp_gulag_gesture_pos_hold", "tmp_gulag_gesture_pos_ok", "tmp_gulag_gesture_pos_thumbs_up"];
}

function getmaxplayers() {
  var_0 = int(clamp(getdvarint("scr_br_fc_max_players", 2), 2, 2));

  if(var_0 % 2 != 0) {
    var_0 -= 1;
  }

  return var_0;
}

function hiderespawntimer(var_0, var_1) {
  return var_0.script_index < var_1.script_index;
}

function hidequestobjiconfromplayer(var_0, var_1) {
  if(var_0.script_index == 4) {
    return true;
  } else if(var_0.script_index == 5) {
    return true;
  } else if(var_1.script_index == 4) {
    return false;
  } else if(var_1.script_index == 5) {
    return false;
  }

  return hiderespawntimer(var_0, var_1);
}

function copystructwithoffset(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_0.origin + var_1;
  var_3.angles = var_0.angles;
  var_3.script_index = var_2;
  return var_3;
}

function getgulagcenter(var_0) {
  var_1 = (0, 0, 0);

  foreach(var_3 in var_0.fightspawns) {
    var_1 += var_3.origin;
  }

  var_1 /= var_0.fightspawns.size;
  return var_1;
}

function spawnweapon(var_0, var_1, var_2) {
  var_3 = scripts\mp\gametypes\br_weapons::createspawnweaponatpos(getgroundposition(var_0.origin + (0, 0, 12), 12), var_0.angles + (0, 0, 90), var_1, []);
  thread outlinewatchplayerprox(var_3);
  return var_3;
}

function spawnlootweapons(var_0) {
  var_1 = [];
  var_2 = [];
  GscBinSkip0(0x2e, "none", ["none"]);
}

function ref_125ee(var_0) {
  if(ref_125ef(var_0)) {
    var_1 = var_0.matches[0];

    foreach(var_3 in var_1) {
      if(var_3 == self) {
        continue;
      }

      if(updatelootleadercirclesize(var_3, var_0)) {
        return false;
      }
    }

    return true;
  }

  return false;
}

function ref_125ef(var_0) {
  if(ismatchpending(var_0)) {
    var_1 = var_0.matches[0];

    foreach(var_3 in var_1) {
      if(var_3 == self) {
        return true;
      }
    }
  }

  return false;
}

function ismatchpending(var_0) {
  if(var_0.matches.size == 0) {
    return false;
  }

  var_1 = var_0.matches[0];

  if(var_1.size < 2) {
    return false;
  }

  return true;
}

function isfightready(var_0) {
  if(!ismatchpending(var_0)) {
    return false;
  }

  var_1 = var_0.matches[0];

  foreach(var_3 in var_1) {
    if(istrue(var_3.entergulagwait) || !istrue(var_3.jailed)) {
      return false;
    }
  }

  return true;
}

function set_relic_noregen(var_0) {
  var_1 = 5000;

  if(!isDefined(var_0.ref_11e78)) {
    var_0.ref_11e78 = gettime() + var_1;
    return;
  }

  if(gettime() > var_0.ref_11e78) {
    var_0.jailedplayers = scripts\engine\utility::array_removeundefined(var_0.jailedplayers);
    updatematchqueuepositions(var_0);

    if(var_0.set_relic_oneclip == 0) {
      level.gulag.watch_for_near_objective_point = scripts\engine\utility::array_removeundefined(level.gulag.watch_for_near_objective_point);

      foreach(var_3 in level.gulag.watch_for_near_objective_point) {
        if(!istrue(var_3.inlaststand)) {
          level.gulag.watch_for_near_objective_point = scripts\engine\utility::array_remove(level.gulag.watch_for_near_objective_point, var_3);
        }
      }
    }

    var_0.ref_11e78 = gettime() + var_1;
    return;
  }
}

function monitorgulag(var_0) {
  level endon("game_ended");
  var_1 = relic_amped_paused();

  for(;;) {
    set_relic_noregen(var_0);

    if(istrue(level.br_prematchstarted)) {
      if(istrue(level.gulag.shutdown)) {
        if(var_0.loadingplayers.size != 0) {
          var_0 scripts\engine\utility::waittill_notify_or_timeout("loadingPlayersEmpty", var_1);
        }

        if(level.gulag.endonshutdown == 1) {
          foreach(var_3 in var_0.jailedplayers) {
            var_3.gulagloser = 1;
            var_3 kill();
          }

          var_0.shutdown = 1;
        } else if(level.gulag.endonshutdown == 2) {
          thread dojailbreak(var_0);
        } else if(level.gulag.endonshutdown == 3 && (istrue(var_0.shutdown) || !ismatchpending(var_0) && !c130airdrop_getteamaveragepos())) {
          foreach(var_3 in var_0.jailedplayers) {
            if(isalive(var_3)) {
              playergulagarenaready(var_3);
              thread gulagvictory(var_0, var_3, 1, 0, "shutdown");
            }
          }

          var_0.shutdown = 1;
        }
      }

      if(unset_relic_martyrdom()) {
        waitframe();
        continue;
      }

      if(isfightready(var_0)) {
        beginnewfight(var_0);
      } else {
        ref_13165(var_0);
      }
    }

    waitframe();
  }
}

function ref_12219(var_0) {
  if(!istrue(level.usegulag)) {
    return;
  }

  level.gulag.paused = var_0;
}

function unset_relic_martyrdom() {
  return istrue(level.usegulag) && istrue(level.gulag.paused);
}

function calloutmarkerping_cp_setupcptimeouts() {
  if(!istrue(level.usegulag)) {
    return false;
  }

  foreach(var_1 in level.gulag.arenas) {
    if(!var_1.fightover) {
      return true;
    }
  }

  return false;
}

function vehicle_compass_cp_shouldbevisibletoplayer() {
  if(isDefined(self) && isalive(self)) {
    gulagvictory(self.arena, self, 1, 1, "jailbreakEvent");
    return;
  }
}

function circletimer(var_0) {
  if(istrue(level.usegulag) && !istrue(level.gulag.shutdown)) {
    var_1 = remove_engineer_class();

    if(var_0 >= var_1) {
      shutdowngulag("circle_index", var_0);
      return;
    }

    return;
  }
}

function shutdowngulag(var_0, var_1, var_2) {
  if(!istrue(level.usegulag) || istrue(level.gulag.shutdown)) {
    return;
  }

  setomnvar("ui_gulag_state", 0);
  setomnvar("ui_gulag_show_closing_state", 2);
  level.gulag.shutdown = 1;

  if(isDefined(level.ref_12851)) {
    [[level.ref_12851]]();
  }

  thread makeac130flyaway();

  if(!istrue(var_2)) {
    foreach(var_4 in level.players) {
      resolvetokensongulagshutdown(var_4);

      if(istrue(var_4.inlaststand)) {
        level.gulag.watch_for_near_objective_point[level.gulag.watch_for_near_objective_point.size] = var_4;
        continue;
      }

      if(!isDefined(var_4) || !isalive(var_4) || isDefined(var_4.gulag)) {
        continue;
      }

      playergulagdonesplash(var_4);
      updatecanusegulag(var_4);
    }
  }

  getentitylessscriptablearray("dlog_event_br_gulag_shutdown", ["reason", var_0, "reason_count", var_1]);
}

function resolvetokensongulagshutdown() {
  var_0 = 0;
  var_1 = 0;

  if(istrue(level.br_pickups.ref_12cb5) && scripts\mp\gametypes\br_public::hasrespawntoken() && level.gulag.redeploytokenconvertamount > 0) {
    var_0 = 1;
    scripts\mp\gametypes\br_pickups::removerespawntoken();
    scripts\mp\gametypes\br_plunder::ref_12627(level.gulag.redeploytokenconvertamount);
  }

  if(istrue(level.br_pickups.gulagtokenclosewithgulag) && scripts\mp\gametypes\br_public::hasgulagtoken() && level.gulag.gulagtokenconvertamount > 0) {
    var_1 = 1;
    scripts\mp\gametypes\br_pickups::removegulagtoken();
    scripts\mp\gametypes\br_plunder::ref_12627(level.gulag.gulagtokenconvertamount);
  } else if(istrue(level.br_pickups.gulagtokenclosewithgulag) && checkgulagusecount() && level.gulag.gulagtokenconvertamount > 0) {
    var_1 = 1;
    scripts\mp\gametypes\br_plunder::ref_12627(level.gulag.gulagtokenconvertamount);
  }

  if(var_0 && var_1) {
    scripts\mp\utility\lower_message::ref_1316e("br_redeployGulag_conversion", undefined, level.gulag.tokenconversiontime);
  } else if(var_0) {
    scripts\mp\utility\lower_message::ref_1316e("br_redeploy_conversion", undefined, level.gulag.tokenconversiontime);
  } else if(var_1) {
    scripts\mp\utility\lower_message::ref_1316e("br_gulag_conversion", undefined, level.gulag.tokenconversiontime);
  }

  hidealltokensongulagshutdown();
}

function hidealltokensongulagshutdown() {
  var_0 = getlootscriptablearrayinradius("brloot_redeploy_token", undefined);
  var_1 = getlootscriptablearrayinradius("brloot_gulag_token", undefined);

  foreach(var_3 in var_0) {
    scripts\mp\gametypes\br_pickups::ref_11a21(var_3);
  }

  foreach(var_3 in var_1) {
    scripts\mp\gametypes\br_pickups::ref_11a21(var_3);
  }

  level.br_pickups.hidetokens = 1;
}

function c130airdrop_getteamaveragepos() {
  return level.gulag.watch_for_near_objective_point.size > 0;
}

function ref_125e6() {
  if(!istrue(level.usegulag) || !istrue(level.gulag.shutdown)) {
    return 0;
  }

  return scripts\engine\utility::array_contains(level.gulag.watch_for_near_objective_point, self);
}

function set_relic_steelballs(var_0) {
  if(istrue(level.gulag.shutdown) && c130airdrop_getteamaveragepos()) {
    if(isDefined(var_0) && ref_125e6(var_0)) {
      level.gulag.watch_for_near_objective_point = scripts\engine\utility::array_remove(level.gulag.watch_for_near_objective_point, var_0);
      return true;
    } else {
      level.gulag.watch_for_near_objective_point = scripts\engine\utility::array_removeundefined(level.gulag.watch_for_near_objective_point);
    }
  }

  return false;
}

function onplayerdisconnect(var_0) {
  if(!istrue(level.usegulag)) {
    return;
  }

  set_relic_steelballs(var_0);
}

function ref_12551(var_0) {
  if(!istrue(level.usegulag)) {
    return;
  }

  if(istrue(var_0)) {
    self.watch_for_driver_death = undefined;

    if(set_relic_steelballs(self)) {
      playergulagdonesplash();
      return;
    }

    return;
  }
}

function remove_engineer_class() {
  if(!isDefined(level.br_level) || !isDefined(level.br_level.br_circledelaytimes)) {
    return 0;
  }

  var_0 = level.br_level.delay_start_infiltrate_objective;

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  return level.br_level.br_circledelaytimes.size - 1 - getdvarint("scr_br_fc_circle_disable", 3) - var_0;
}

function ref_13249() {
  var_0 = run_hud_logic();
  var_1 = gettime() + var_0 * 1000;
  setomnvar("ui_gulag_timer", var_1);
  thread ref_13346(var_0);
}

function ref_13346(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  var_1 = getdvarint("scr_br_display_gulag_close_message", 90);
  var_2 = var_0 - var_1;

  if(0 < var_2) {
    wait var_2;
    setomnvar("ui_gulag_show_closing_state", 1);
    return;
  }
}

function run_hud_logic() {
  var_0 = 0;

  if(isDefined(level.br_level) && isDefined(level.br_level.default_class_chosen)) {
    var_1 = remove_engineer_class();

    for(var_2 = 0; var_2 < var_1; var_2++) {
      var_3 = level.br_level.br_circledelaytimes[var_2];
      var_4 = level.br_level.br_circleclosetimes[var_2];
      var_0 = var_0 + var_3 + var_4;
    }
  }

  return int(var_0);
}

function playergulagdonesplash() {
  if(istrue(self.gulagdone)) {
    return;
  }

  self.gulagdone = 1;
  scripts\mp\gametypes\br_killstreaks::isbrsquadleader(self, "gulag_closed", undefined, 2);
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("gulag_gulag_close", self);
}

function dojailbreak(var_0) {
  if(var_0.jailedplayers.size == 0) {
    var_0.shutdown = 1;
    return;
  }

  var_0.isjailbreak = 1;
  var_0.arenaplayers = scripts\engine\utility::array_removeundefined(var_0.jailedplayers);
  jailbreaktimerwait(var_0);
  var_1 = getloadoutindex();

  foreach(var_3 in var_0.arenaplayers) {
    thread set_respawn_points(var_3);
    initplayerarena(var_3, var_0, 1, var_1);

    if(istrue(level.gulag.gestures_enabled) && !isbot(var_3)) {
      playergulaggesturesdisable(var_3);
    }

    if(getdvarint("scr_br_fc_outline_countdown", 1) > 0 && var_0.arenaplayers.size > 0) {
      var_3 hudoutlinedisableforclients(var_0.arenaplayers);
    }
  }

  playsoundatpos(var_0.center, "iw8_mp_snatch_fight_start");
  var_0.fightover = 0;

  if(!isoneteamleft(var_0)) {
    var_0.time = level.gulag.timelimit;
    updatematchtimerhud(var_0, var_0.time);
    waittillgulagmatchend(var_0, 0);
  } else {
    var_0.time = 8;
    updatematchtimerhud(var_0, var_0.time);
    wait var_0.time;
  }

  foreach(var_3 in var_0.arenaplayers) {
    if(isDefined(var_3) && isDefined(var_3.gulagjailbreakhud)) {
      var_3.gulagjailbreakhud destroy();
    }
  }

  handleendarena(var_0);
  var_0.shutdown = 1;
}

function jailbreaktimerwait(var_0) {
  foreach(var_2 in var_0.arenaplayers) {
    if(!isDefined(var_2)) {
      continue;
    }

    var_2 thread scripts\mp\hud_message::showsplash("br_gulag_jail_break");

    if(getdvarint("scr_br_fc_outline_countdown", 1) > 0) {
      var_2 hudoutlineenableforclients(var_0.arenaplayers, "outline_nodepth_red");
    }
  }

  wait 3;

  foreach(var_2 in var_0.arenaplayers) {
    if(!isDefined(var_2)) {
      continue;
    }

    playeraddjailbreaktimer(var_2);
  }

  gulagcountdowntimer(var_0, 0);

  foreach(var_2 in var_0.arenaplayers) {
    if(!isDefined(var_2)) {
      continue;
    }

    var_2 setclientomnvar("ui_match_start_countdown", 0);
    var_2 setclientomnvar("ui_match_in_progress", 1);

    if(isDefined(var_2) && isDefined(var_2.gulagjailbreakhud)) {
      var_2.gulagjailbreakhud.label = &"MP/BR_GULAG_JAILBREAK";
    }
  }
}

function playeraddjailbreaktimer() {
  self.gulagjailbreakhud = scripts\mp\hud_util::createfontstring("default", 2);
  self.gulagjailbreakhud scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -150);
  self.gulagjailbreakhud.label = &"MP/BR_GULAG_JAILBREAK_IN";
}

function resetequipment(var_0) {
  if(!istrue(level.gulag.ref_13672)) {
    return;
  }

  for(var_1 = 0; var_1 < var_0.weapons.size; var_1++) {
    var_2 = var_0.weapons[var_1];
    var_2 setscriptablepartstate(var_2.part, "visible");
  }
}

function validateplayers(var_0) {
  return var_0.arenaplayers.size >= 2;
}

function beginnewfight(var_0) {
  level endon("game_ended");
  var_0 endon("fight_over_early");
  level notify("gulag_begin_new_fight", var_0);
  var_0.fightover = 0;
  resetequipment(var_0);
  ref_12c6b(var_0);
  var_0.arenaplayers = popnextmatch(var_0);
  var_1 = 0;

  foreach(var_3 in var_0.arenaplayers) {
    if(isDefined(var_3)) {
      var_0.jailedplayers = scripts\engine\utility::array_remove(var_0.jailedplayers, var_3);
    }

    if(!isDefined(var_3)) {
      var_1 = 1;
      continue;
    }

    if(var_3.gulag == 0 || var_3.jailed == 0 || var_3.gulagarena == 1) {
      scripts\mp\utility\script::laststand_dogtags("Player: " + var_3.name + " - invalid for gulag - p.gulag = " + var_3.gulag + ", p.jailed = " + var_3.jailed + ", p.gulagArena = " + var_3.gulagarena);
      var_1 = 1;
      continue;
    }

    var_3.fighterindex = var_4;
  }

  foreach(var_6 in var_0.jailedplayers) {
    if(!isDefined(var_6)) {
      continue;
    }

    var_6.gulagposition--;
    var_6 setweaponammoclip("rock_mp", 5);
  }

  if(var_1) {
    var_0.jailedplayers = scripts\engine\utility::array_removeundefined(var_0.jailedplayers);
    var_0.arenaplayers = scripts\engine\utility::array_removeundefined(var_0.arenaplayers);

    if(!validateplayers(var_0)) {
      handleendarena(var_0, undefined, 1);
      return;
    }
  }

  var_8 = startbetting(var_0, var_0.arenaplayers);

  if(getdvarint("scr_br_fc_spectate_outlines", 0)) {
    thread manageoutlines(var_0, var_0.arenaplayers, var_8);
  }

  var_0.arenaspawncounter = 0;
  var_9 = getloadoutindex();

  foreach(var_6 in var_0.arenaplayers) {
    if(!isDefined(var_6)) {
      continue;
    }

    thread set_respawn_points(var_6, var_0);
    thread initplayerarena(var_6, var_0, 0);
  }

  thread watchlethaldelay(var_0);
  wait 2;

  if(!validateplayers(var_0)) {
    handleendarena(var_0, var_8, 1);
    return;
  }

  ref_13fc1(var_0);
  ref_13fc0(var_0);
  var_12 = gulagcountdowntimer(var_0, 1, var_8);

  if(!var_12) {
    return;
  }

  endbetting(var_0, var_8);

  foreach(var_6 in var_0.arenaplayers) {
    playergulagarenaready(var_6);
    thread ref_12692();
  }

  thread ref_13849(var_0);
  var_0.time = level.gulag.timelimit;
  updatematchtimerhud(var_0, var_0.time);
  waittillgulagmatchend(var_0, 1);
  handleendarena(var_0, var_8);

  if(!isfightready(var_0)) {
    ref_14009(var_0);
    return;
  }
}

function watchlethaldelay(var_0) {
  var_0 endon("fight_over");
  var_0 endon("matchEnded");
  level endon("game_ended");

  if(level.gulag.lethaldelay <= 0) {
    return;
  }

  var_0.lethaldelaystarttime = gettime();
  var_0.lethaldelayendtime = var_0.lethaldelaystarttime + level.gulag.lethaldelay * 1000 + level.gulag.impairedkill * 1000 + 2000;

  while(gettime() < var_0.lethaldelayendtime) {
    waitframe();
  }

  var_0 notify("lethal_delay_end");
}

function watchlethaldelayplayer(var_0) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(level.gulag.lethaldelay == 0) {
    return;
  }

  if(!isai(self)) {
    self notifyonplayercommand("lethal_attempt_gulag", "+frag");
    self notifyonplayercommand("lethal_attempt_gulag", "+smoke");
  }

  scripts\mp\equipment::allow_equipment_slot("primary", 0);
  scripts\mp\equipment::allow_equipment_slot("secondary", 0);
  watchlethaldelayfeedbackplayer(var_0, self);
  scripts\mp\equipment::allow_equipment_slot("primary", 1);
  scripts\mp\equipment::allow_equipment_slot("secondary", 1);

  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    self playlocalsound("ui_restock_lethals");
  }

  self setclientomnvar("ui_recharge_notify", 2);

  if(!isai(self)) {
    self notifyonplayercommandremove("lethal_attempt_gulag", "+frag");
    self notifyonplayercommandremove("lethal_attempt_gulag", "+smoke");
    return;
  }
}

function watchlethaldelayfeedbackplayer(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("matchEnded");
  var_0 endon("lethal_delay_end");

  for(;;) {
    self waittill("lethal_attempt_gulag");
    var_2 = (var_0.lethaldelayendtime - gettime()) / 1000;
    var_2 = int(max(0, ceil(var_2)));
    var_1 scripts\mp\hud_message::showerrormessage("MP/LETHALS_UNAVAILABLE_FOR_N", var_2);
  }
}

function ref_13849(var_0) {
  var_0 endon("matchEnded");
  playsoundatpos(var_0.center, "iw8_mp_snatch_fight_start");
  wait 1;
  scripts\mp\gametypes\br_public::brleaderdialog("gulag_gulag_active", 0, var_0.jailedplayers);
  scripts\mp\gametypes\br_public::brleaderdialog("gulag_objective", 0, var_0.arenaplayers);
  wait 2;

  foreach(var_2 in var_0.jailedplayers) {
    if(var_2.gulagposition <= 1) {
      scripts\mp\gametypes\br_public::dmztut_endgamewithreward("gulag_next", var_2, 0);
      continue;
    }

    if(var_2.gulagposition == 2) {
      scripts\mp\gametypes\br_public::dmztut_endgamewithreward("gulag_taunt", var_2, 0);
    }
  }
}

function ref_12692() {
  self endon("disconnect");
  self setclientomnvar("ui_objective_text", 0);
  wait 3;
  self setclientomnvar("ui_objective_text", -1);
}

function handleonekillwin(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2) && isPlayer(var_2) && var_1 != var_2 && isalive(var_2) && scripts\engine\utility::array_contains(var_0.arenaplayers, var_2)) {
    thread gulagvictory(var_0, var_2, 0, 0, "winner");
    payoutbet(var_3, var_2, 1);
  }

  payoutbet(var_3, var_1, 0);
}

function manageoutlines(var_0, var_1, var_2) {
  manageoutlineactive(var_0, var_1, var_2);

  if(istrue(level.gulag.onekillwin)) {
    return;
  }

  manageoutlinecleanup(var_0, var_1);
}

function manageoutlineswatchplayersaddedtojail(var_0) {
  var_0 endon("fight_over");

  for(;;) {
    var_0 waittill("player_added_to_jail");
    updateoutlines(var_0);
  }
}

function manageoutlineactive(var_0, var_1, var_2) {
  var_0 endon("fight_over");
  thread manageoutlineswatchplayersaddedtojail(var_0);

  for(;;) {
    if(var_0.jailedplayers.size) {
      var_3 = scripts\engine\utility::array_removeundefined(var_0.jailedplayers);

      foreach(var_5 in var_1) {
        if(!isDefined(var_5)) {
          continue;
        }

        var_5 hudoutlineenableforclients(var_3, "outline_nodepth_white");
      }
    }

    if(isDefined(var_2)) {
      foreach(var_8 in var_2.bets) {
        if(!isDefined(var_8.owner)) {
          continue;
        }

        var_9 = scripts\engine\utility::ter_op(var_2.bettingopen, var_8.playerfocus, var_8.playerbeton);

        if(var_9 != -1) {
          var_10 = var_2.fighters[var_9];

          if(isDefined(var_10)) {
            var_10 hudoutlineenableforclient(var_8.owner, "outline_nodepth_green");
          }
        }
      }
    }

    var_0 waittill("update_outlines");
  }
}

function manageoutlinecleanup(var_0, var_1) {
  var_2 = scripts\engine\utility::array_removeundefined(var_0.jailedplayers);

  if(!var_2.size) {
    return;
  }

  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }

    var_4 hudoutlinedisableforclients(var_2);
  }
}

function updateoutlines(var_0) {
  var_0 notify("update_outlines");
}

function playergulagarenaready() {
  ref_126b0(1);
  self setclientomnvar("ui_br_infil_started", 1);
  self setclientomnvar("ui_match_start_countdown", 0);
  self setclientomnvar("ui_match_in_progress", 1);

  if(istrue(level.gulag.gestures_enabled) && !isbot(self)) {
    playergulaggesturesdisable();
    return;
  }
}

function gulagcountdowntimer(var_0, var_1, var_2) {
  var_3 = level.gulag.impairedkill;

  while(var_3 > 0) {
    foreach(var_5 in var_0.arenaplayers) {
      var_5 setclientomnvar("ui_match_in_progress", 0);
      var_5 setclientomnvar("ui_match_start_countdown", var_3);
    }

    var_3 -= 1;
    wait 1;

    if(istrue(var_1) && !validateplayers(var_0)) {
      handleendarena(var_0, var_2, 1);
      return false;
    }
  }

  return true;
}

function set_relic_vampire(var_0, var_1, var_2) {
  var_0 endon("matchEnded");

  while(var_1 > 0) {
    if(level.gameended) {
      return;
    }

    var_3 = var_1;

    if(!istrue(var_0.overtime)) {
      var_3 -= var_2;
    }

    if(var_3 <= 5) {
      var_4 = scripts\mp\gamelogic::relic_bang_and_boom_dropfunc(var_3);
      lower_target_when_close(var_0, var_4);
    }

    if(var_1 > 1) {
      var_1 -= 1;
    }

    wait 1;
  }
}

function lower_target_when_close(var_0, var_1) {
  foreach(var_3 in var_0.jailedplayers) {
    if(isDefined(var_3)) {
      var_3 playlocalsound(var_1);
    }
  }

  foreach(var_3 in var_0.arenaplayers) {
    if(isDefined(var_3)) {
      var_3 playlocalsound(var_1);
    }
  }
}

function respawn_scriptible_carriable_wait() {
  return getdvarint("scr_br_fc_overtime", 15);
}

function waittillgulagmatchend(var_0, var_1) {
  var_2 = respawn_scriptible_carriable_wait();
  var_0.time += var_2;
  thread set_relic_vampire(var_0, var_0.time, var_2);

  for(;;) {
    if(!isanyonealive(var_0) || isoneteamleft(var_0)) {
      break;
    }

    var_0.time -= level.framedurationseconds;

    if(istrue(level.gulag.arenaflag) && !istrue(var_0.overtime) && var_0.time <= var_2) {
      var_0.overtime = 1;
      calloutmarkerping_watchwhenobjectivedeleted(var_0.managevehiclehealthui.arenaflag, 1);
      calloutmarkerping_watchwhenobjectivestartsprogress(var_0.managevehiclehealthui.arenaflag, var_0, 1);
      var_0.managevehiclehealthui.arenaflag.flagmodel playsoundonmovingent("flag_spawned");
    }

    if(istrue(var_0.overtime)) {
      var_3 = clamp(var_0.time / var_2, 0, 1);
      ref_13194(var_0, var_3);
    }

    if(var_0.time <= 0) {
      ref_143ef(var_0);

      if(istrue(var_1)) {
        foreach(var_5 in var_0.arenaplayers) {
          thread set_respawn_loc_delayed(var_5);
          var_6 = scripts\mp\music_and_dialog::reset_attack_next_available_time("br_gulag_lose");
          var_5 setplayermusicstate(var_6);
          var_5 playsoundtoplayer("gulag_crowd_boo_loser", var_5);
          var_5 clearclienttriggeraudiozone(2);
        }
      }

      break;
    }

    waitframe();
  }

  var_0 notify("matchEnded");
}

function ref_143ef(var_0) {
  while(isDefined(var_0.managevehiclehealthui.arenaflag.claimteam) && var_0.managevehiclehealthui.arenaflag.claimteam != "none" && !istrue(var_0.managevehiclehealthui.arenaflag.stalemate)) {
    waitframe();
  }
}

function isanyonealive(var_0) {
  foreach(var_2 in var_0.arenaplayers) {
    if(isalive(var_2)) {
      return true;
    }
  }

  return false;
}

function issquadwiped(var_0) {
  foreach(var_2 in level.teamdata[var_0]["players"]) {
    if(isDefined(var_2) && isalive(var_2)) {
      return false;
    }
  }

  return true;
}

function isoneteamleft(var_0) {
  var_1 = undefined;

  foreach(var_3 in var_0.arenaplayers) {
    if(isalive(var_3)) {
      if(!isDefined(var_1)) {
        var_1 = var_3.team;
        continue;
      }

      if(var_1 != var_3.team) {
        return false;
      }
    }
  }

  return true;
}

function handleendarena(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 notify("lethal_delay_end");
  var_0 notify("fight_over");
  var_0.fightover = 1;

  if(!isDefined(var_4)) {
    var_4 = "winner";
  }

  endbetting(var_0, var_1);
  updatematchtimerhud(var_0, 0);
  var_6 = undefined;

  foreach(var_8 in var_0.arenaplayers) {
    if(!isDefined(var_8)) {
      continue;
    }

    if(isalive(var_8)) {
      var_6 = var_8;

      if(istrue(var_2)) {
        playergulagarenaready(var_6);
      }

      if(isDefined(var_5) && var_8.team == var_5.team) {
        thread gulagvictory(var_0, var_8, 0, 0, var_4, 0, var_5, var_3);
        continue;
      }

      thread gulagvictory(var_0, var_8, 0, 0, "winner");
    }
  }

  if(istrue(level.gulag.arenaflag) && istrue(var_0.overtime)) {
    calloutmarkerping_watchwhenobjectivedeleted(var_0.managevehiclehealthui.arenaflag, 0);
  }

  payoutremainingbets(var_6, var_1);
  wait 2;

  if(istrue(level.gulag.arenaflag) && istrue(var_0.overtime)) {
    var_0.overtime = 0;
    calloutmarkerping_watchwhenobjectivestartsprogress(var_0.managevehiclehealthui.arenaflag, var_0, 0);
  }

  handlesoloexclusionils(var_0);
  wait 1;
}

function ref_12642(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("gulag_end");

  if(!isDefined(self.arena)) {
    return;
  }

  var_2 = self.arena;

  if(istrue(self.ref_14439)) {
    self notify("pull_out_of_gulag");

    if(!isalive(self)) {
      thread playergulagautowin("playerPullOutOfGulagWin1", var_0);
      return;
    } else if(istrue(self.delay_enter_combat_after_investigating_grenade)) {
      scripts\mp\gametypes\br::ref_13f21(self, "playerPullOutOfGulagWin2");
      level thread scripts\mp\gametypes\br::ref_14006();
    }
  } else if(istrue(self.gulagarena)) {
    if(!var_2.fightover) {
      var_2 notify("matchEnded");
      var_2 notify("fight_over_early");
      thread handleendarena(var_2, undefined, 1, 1, var_1, var_0);
    }

    return;
  } else {
    var_2.jailedplayers = scripts\engine\utility::array_remove(var_2.jailedplayers, self);
    updatematchqueuepositions(var_2);

    if(istrue(self.gulag) && !istrue(self.jailed)) {
      self waittill("gulag_start");
    }
  }

  thread gulagvictory(var_2, self, 1, 0, var_1, 0, var_0, 1);
}

function getnextjailspawn(var_0) {
  if(isDefined(var_0.jailspawncounter)) {
    var_0.jailspawncounter++;
    var_0.jailspawncounter %= var_0.jailspawns.size;
  } else {
    var_0.jailspawncounter = 0;
  }

  var_1 = var_0.jailspawns[var_0.jailspawncounter];
  return var_1;
}

function ref_13255(var_0, var_1) {
  if(isDefined(var_1.target)) {
    var_2 = scripts\engine\utility::getStruct(var_1.target, "targetname");

    if(isDefined(var_2)) {
      var_1.chair = var_2;
      return;
    }

    return;
  }
}

function outlinewatchplayerprox(var_0) {
  self endon("death");
  self endon("trigger");
  self.outlinedplayers = [];

  switch (var_0) {
    case 0:
    default:
      var_1 = "outline_depth_white";
      break;
    case 1:
      var_1 = "outline_depth_green";
      break;
    case 2:
      var_1 = "outline_depth_cyan";
      break;
    case 3:
      var_1 = "outline_depth_red";
      break;
    case 4:
      var_1 = "outline_depth_orange";
      break;
  }

  for(;;) {
    var_2 = scripts\common\utility::playersinsphere(self.origin, 2000);
    var_3 = scripts\engine\utility::array_difference(level.players, var_2);

    foreach(var_5 in var_2) {
      var_6 = distancesquared(self.origin, var_5.origin);
      var_7 = var_5 getentitynumber();

      if(!isDefined(self.outlinedplayers[var_7])) {
        self.outlinedplayers[var_7] = scripts\mp\utility\outline::outlineenableforplayer(self, var_5, var_1, "level_script");
      }
    }

    foreach(var_5 in var_3) {
      var_7 = var_5 getentitynumber();

      if(isDefined(self.outlinedplayers[var_7])) {
        scripts\mp\utility\outline::outlinedisable(self.outlinedplayers[var_7], self);
        self.outlinedplayers[var_7] = undefined;
      }
    }

    waitframe();
  }
}

function gulagstreamlocationstart(var_0) {
  if((isbot(self) || self calloutmarkerping_getEnt()) && !istrue(self.ref_119d7)) {
    return false;
  }

  self calloutmarkerping_getcreatedtime(10000);
  self setadditionalstreampos(var_0, 1);
  return !self isadditionalstreamposready();
}

function gulagstreamlocationwait() {
  if(!istrue(self.ref_119d7)) {
    self endon("gulagStreamLocationComplete");
    thread gulagstreamlocationwaittimeout(level.gulag.ref_1391b);

    while(!self isadditionalstreamposready()) {
      waitframe();
    }

    self notify("gulagStreamLocationComplete");
    return;
  }

  wait level.gulag.ref_1391b;
}

function gulagstreamlocationwaittimeout(var_0) {
  self endon("disconnect");
  self endon("gulagStreamLocationComplete");
  wait var_0;
  self notify("gulagStreamLocationComplete");
}

function gulagstreamlocationend() {
  self clearadditionalstreampos();
  self notify("gulagStreamLocationComplete");
}

function set_scriptable_states() {
  self calloutmarkerping_getcreatedtime(0);
}

function addloadingplayer(var_0, var_1) {
  var_1.entergulagwait = 1;
  var_0.loadingplayers[var_0.loadingplayers.size] = var_1;
  thread addloadingplayerdisconnectwatch(var_0, var_1);
}

function addloadingplayerdisconnectwatch(var_0, var_1) {
  var_1 endon("removeLoadingPlayer");
  var_1 waittill("disconnect");
  thread removeloadingplayer(var_0, var_1);
}

function removeloadingplayer(var_0, var_1) {
  var_1 notify("removeLoadingPlayer");

  if(isDefined(var_1)) {
    var_0.loadingplayers = scripts\engine\utility::array_remove(var_0.loadingplayers, var_1);
  } else {
    var_0.loadingplayers = scripts\engine\utility::array_removeundefined(var_0.loadingplayers);
  }

  if(var_0.loadingplayers.size == 0) {
    var_0 notify("loadingPlayersEmpty");
    return;
  }
}

function updatelootleadercirclesize(var_0, var_1) {
  return scripts\engine\utility::array_contains(var_1.loadingplayers, var_0);
}

function entergulag(var_0) {
  var_0 notify("enter_gulag");
  var_0.entergulagwait = 0;
  scripts\mp\deathicons::spawn_carriables_from_prefabs_all(var_0);
}

function entergulagwait(var_0) {
  if(var_0.entergulagwait) {
    var_0 waittill("enter_gulag");
    return;
  }
}

function playergetnextarena() {
  if(!istrue(level.gulag.multiarena)) {
    return level.gulag.arenas[0];
  }

  var_1 = undefined;
  var_2 = undefined;

  foreach(var_8, var_4 in level.gulag.arenas) {
    foreach(var_6 in var_4.matches) {
      if(var_6.size == 1 && isDefined(var_6[0]) && var_6[0].team != self.team && (!isDefined(var_1) || var_6[0].vehicle_compass_friendlystatuschangedcallback < var_2)) {
        var_1 = var_4;
        var_2 = var_6[0].vehicle_compass_friendlystatuschangedcallback;
      }
    }
  }

  if(isDefined(var_1)) {
    return var_1;
  }

  var_9 = [];

  for(var_10 = 0; var_10 < level.gulag.arenas.size; var_10++) {
    var_4 = level.gulag.arenas[var_10];

    if(var_4.matches.size > 0 && var_4.matches.size < level.gulag.maxqueue) {
      var_9 = var_4;
    }
  }

  if(var_9.size > 0) {
    foreach(var_17, var_4 in var_9) {
      foreach(var_6 in var_4.matches) {
        foreach(var_14 in var_6) {
          if(isDefined(var_14) && var_14.team == self.team) {
            return var_4;
          }
        }
      }
    }

    var_4 = var_9[randomint(var_9.size)];
    return var_4;
  }

  var_8 = undefined;
  var_18 = undefined;

  for(var_17 = 0; var_17 < level.gulag.arenas.size; var_17++) {
    var_11 = level.gulag.arenas[var_17];

    if(var_11.matches.size == 0) {
      return var_11;
    }

    if(!isDefined(var_18) || var_11.matches.size < var_18) {
      var_8 = var_11;
      var_18 = var_11.matches.size;
    }
  }

  return var_8;
}

function updatelootleadermarks(var_0, var_1) {
  if(!ismatchpending(var_0)) {
    return false;
  }

  var_2 = var_1.gulagposition - 1;

  if(var_2 >= 0 && var_0.matches[var_2].size > 1) {
    return true;
  }

  return false;
}

function ref_13165(var_0) {
  foreach(var_2 in var_0.jailedplayers) {
    if(!updatelootleadermarks(var_0, var_2) && isDefined(var_2.vehicle_compass_getleveldata) && !isDefined(var_2.vehicle_compass_hide)) {
      var_2 setclientomnvar("ui_br_gulag_match_end_time", var_2.vehicle_compass_getleveldata);
      var_2.vehicle_compass_hide = 1;
    }
  }
}

function ref_12527(var_0) {
  self.vehicle_compass_getleveldata = undefined;
  self.vehicle_compass_hide = undefined;
  self setclientomnvar("ui_br_gulag_match_end_time", 0);
}

function ref_125f4(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("initPlayerArena");
  self endon("gulag_end");
  var_1 = getdvarint("scr_br_fc_jailTimeout", 95);

  if(var_1 <= 0) {
    return;
  }

  self.vehicle_compass_getleveldata = gettime() + var_1 * 1000;
  wait var_1;

  if(updatelootleadermarks(var_0, self)) {
    var_2 = self.gulagposition * (level.gulag.timelimit + respawn_scriptible_carriable_wait() + level.gulag.impairedkill + 2 + 2 + 1 + 1);
    var_3 = gettime() + var_2 * 1000;

    while(var_3 > gettime() && updatelootleadermarks(var_0, self)) {
      waitframe();
    }
  }

  while(unset_relic_martyrdom()) {
    waitframe();
  }

  thread gulagvictory(var_0, self, 1, 0, "timeout");
}

function updatecanusegulag() {
  var_0 = self;

  if(!isDefined(var_0.gulaguses)) {
    self.gulaguses = 0;
  }

  var_1 = ref_12517(var_0);
  var_0 scripts\mp\gametypes\br_public::setcanusegulagextrainfo(var_1);
}

function initplayerjail(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("gulag_end");
  self.vehicle_compass_friendlystatuschangedcallback = gettime();
  self.gulagloser = 0;
  self.nosuspensemusic = 1;
  scripts\mp\gametypes\br_analytics::destroyawardlaunchonly(self, scripts\engine\utility::ter_op(istrue(var_0), "default", "debug"));
  ref_1263c();
  var_1 = playergetnextarena();
  self.arena = var_1;

  if(!scripts\engine\utility::array_contains(var_1.jailedplayers, self)) {
    var_1 notify("player_added_to_jail", self);
    var_1.jailedplayers[var_1.jailedplayers.size] = self;
  }

  playergulaghud(var_1);
  thread playerwatchdisconnect(var_1);
  updatematchqueuepositions(var_1);
  addloadingplayer(var_1, self);
  set_relic_steelballs(self);

  if(!isDefined(self.gulaguses)) {
    self.gulaguses = 0;
  }

  self.gulaguses++;
  updatecanusegulag();
  setplayervargulag(1);
  setplayervargulagarena(0);
  ref_131a2(1);
  ref_1319f(var_1);
  scripts\mp\outofbounds::enableoobimmunity(self);

  if(isDefined(level.getinfilplayers)) {
    [[level.getinfilplayers]]();
  }

  var_2 = getnextjailspawn(var_1);
  var_3 = getgroundposition(var_2.origin, 12);
  var_4 = (0, 0, 0);

  if(isDefined(var_2.angles)) {
    var_4 = var_2.angles;
  }

  var_5 = gulagstreamlocationstart(var_3);
  self.set_relic_steelballs_perks = 1;
  self.ref_1391a = spawnStruct();
  self.ref_1391a.origin = var_3;
  self.ref_1391a.angles = var_4;

  if(istrue(var_0)) {
    entergulagwait(self);
  } else {
    entergulag(self);
  }

  scripts\mp\gametypes\br_quest_util::ref_1206c();
  scripts\mp\gametypes\br_alt_mode_escape::obj_hangar_bombs();
  _calloutmarkerping_isvehicleoccupiedbyenemy::loadout_finalizeweapons("gulag");
  var_6 = gettime();

  if(scripts\mp\gametypes\br_public::tutorial_playSound()) {
    self notify("play_gulag_vo");
  }

  if(level.gulag.betting) {
    var_7 = level.gulag.juggheli_spawner_jammer5_2;

    if(isDefined(self.plundercountondeath)) {
      var_7 = int(max(var_7, int(self.plundercountondeath / 2)));
    }

    scripts\mp\gametypes\br_plunder::playersetplundercount(var_7);
  }

  ref_12617();

  if(var_5) {
    scripts\mp\gametypes\br::spawnintermission(var_3 + (0, 0, 100), self.angles);
    scripts\mp\spectating::setdisabled();
    gulagstreamlocationstart(var_3);
  }

  if(var_5) {
    gulagstreamlocationwait();
  }

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("playerPreSpawnGulagJail")) {
    scripts\mp\gametypes\br_gametypes::ref_12e05("playerPreSpawnGulagJail");
  }

  scripts\mp\class::loadout_emptycacheofloadout("gamemode");
  self.pers["gamemodeLoadout"] = level.gulag.vehicle_compass_deregisterinstance;
  self.class = "gamemode";
  self.forcespawnangles = var_4;
  self.forcespawnorigin = var_3;
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  scripts\cp_mp\execution::_clearexecution();
  self setclientomnvar("ui_gulag", 1);
  self.ref_1391a = undefined;
  self.set_relic_steelballs_perks = 0;
  ref_12c7a();

  if(var_5) {
    gulagstreamlocationend();
  }

  ref_12694();
  ref_126ea(var_6);

  if(scripts\mp\gametypes\br_public::tutorial_playSound()) {
    self clearsoundsubmix("iw8_br_gulag_tutorial", 2);
  } else {
    self clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 2);
  }

  self setclientomnvar("ui_br_infil_started", 1);
  var_8 = var_1.fightover && ref_125ee(var_1);
  var_9 = undefined;

  if(level.gulag.getaccessorylogicbyindex) {
    var_9 = 0.5;
  }

  if(!var_8) {
    gulagfadefromblack(var_9);
  }

  gulagloadingtextclear();

  if(!var_8) {
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward("gulag_spawn", self, 0);
    thread ref_1251a(var_1, var_2);
  }

  var_10 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.team, self.squadindex);

  foreach(var_12 in var_10) {
    if(!isDefined(var_12) || !isalive(var_12)) {
      continue;
    }

    if(var_12 != self) {
      var_12 thread scripts\mp\hud_message::showsplash("br_gulag_teammate_in", undefined, self);
      scripts\mp\gametypes\br_public::dmztut_endgamewithreward("gulag_teammate_gulag", var_12);
    }
  }

  if(!istrue(self.jailed)) {
    ref_131aa(1);
    scripts\mp\utility\perk::blockperkfunction("specialty_scavenger");
  }

  removeloadingplayer(var_1, self);
  scripts\mp\gametypes\br_pickups::initplayer(1);

  if(istrue(level.gulag.gestures_enabled) && !isbot(self)) {
    thread playergulaggestures();
  }

  ref_126b3(0);

  if(istrue(level.gulag.arenaflag) && istrue(var_1.overtime)) {
    thread calloutmarkerpingvo_canplaywithspamavoidance(var_1.managevehiclehealthui.arenaflag, 1);
  }

  thread ref_125f4(var_1);
  thread ref_125f5(var_1);
  self notify("gulag_start");
}

function ref_125f5(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("initPlayerArena");
  self endon("gulag_end");
  wait 5;

  if(ismatchpending(var_0)) {
    return;
  }

  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("gulag_obj_wait", self, 0);
}

function ref_126b3(var_0) {
  if(var_0) {
    self enableoffhandthrowback();
    return;
  }

  self disableoffhandthrowback();
}

function playergulaggestures() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("gulag_gestures_stop");
  self enableoffhandweapons();
  self allowfire(0);
  self allowads(0);
  self notifyonplayercommand("fc_gesture_neg", "+attack");
  self notifyonplayercommand("fc_gesture_pos", "+speed_throw");
  var_0 = 0;

  for(;;) {
    var_1 = scripts\engine\utility::ref_143ad("fc_gesture_neg", "fc_gesture_pos");

    if(self isgestureplaying() || self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing()) {
      continue;
    }

    if(getdvarint("scr_br_fc_gestures_test", 0) > 0) {
      if(var_0 >= level.gulag.gestures[var_1].size) {
        var_0 = 0;
      }

      var_2 = level.gulag.gesturesounds[var_1][var_0];
      var_3 = level.gulag.gestures[var_1][var_0];
      var_0++;
    } else {
      var_0 = randomint(level.gulag.gestures[var_1].size);
      var_2 = level.gulag.gesturesounds[var_1][var_0];
      var_3 = level.gulag.gestures[var_1][var_0];
    }

    if(isDefined(var_2) && var_2 != "") {
      self playSound(var_2);
    }

    var_4 = getcompleteweaponname(var_3);

    if(isDefined(var_4) && !nullweapon(var_4)) {
      scripts\cp_mp\gestures::watchradialgesture(var_4);
    }
  }
}

function playergulaggesturesdisable() {
  self notify("gulag_gestures_stop");
  self notifyonplayercommandremove("fc_gesture_neg", "+attack");
  self notifyonplayercommandremove("fc_gesture_pos", "+speed_throw");
  self allowfire(1);
  self allowads(1);
}

function fadeoutin(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  gulagfadetoblack();
  wait var_0;
  gulagfadefromblack();
}

function gulagfadetoblack(var_0) {
  ref_12522();

  if(istrue(var_0)) {
    set_relic_noluck();
    return;
  }
}

function gulagfadefromblack(var_0) {
  thread ref_12523(var_0);
  set_relic_noks();
}

function set_relic_noluck() {
  var_0 = scripts\mp\gametypes\br_spectate::rotatetocurrentangles(self);

  foreach(var_2 in var_0) {
    ref_12522(var_2);
  }
}

function set_relic_noks() {
  var_0 = scripts\mp\gametypes\br_spectate::rotatetocurrentangles(self);

  foreach(var_2 in var_0) {
    if(getdvarint("scr_br_bink_overlay_log", 0) == 1) {
      logstring("bnk_gulagFadeFromBlackSpectatorsOfPlayer()");
    }

    thread ref_12523();
  }
}

function patch_self_check(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  set_relic_noluck();
  wait var_0;
  set_relic_noks();
}

function set_relic_punchbullets() {
  if(ref_125eb()) {
    return true;
  }

  return false;
}

function gulagloadingtext() {
  var_0 = scripts\mp\hud_util::createfontstring("default", 1.5);
  var_0 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -100);
  var_0.label = &"MP/BR_GULAG_TRAVEL";
  self.gulagloadingtext = var_0;
}

function gulagloadingtextclear() {
  if(isDefined(self.gulagloadingtext)) {
    self.gulagloadingtext destroy();
    return;
  }
}

function ref_126c3(var_0, var_1) {
  self cancelmantle();
  self setOrigin(var_0, 1);
  self setplayerangles(var_1);
}

function initplayerarena(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("initPlayerArena");
  ref_1251f();
  scripts\mp\gametypes\br_pickups::initplayer();
  self allowprone(0);
  self allowcrouch(0);
  ref_126b3(1);
  ref_126b0(0);
  playertakeawayrock(var_0);
  ref_12527(var_0);
  scripts\mp\equipment::allow_equipment_slot("primary", 0);
  scripts\mp\equipment::allow_equipment_slot("secondary", 0);
  thread ref_125cc(var_0);

  if(istrue(var_1)) {
    ref_131aa(0);
    setplayervargulagarena(1);
    playergivearenaloadout(var_0, var_2);

    if(level.gulag.lethaldelay > 0) {
      thread watchlethaldelayplayer(var_0);
    }

    return;
  }

  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("gulag_spawn_rules", self, 0);
  var_3 = set_relic_punchbullets();

  if(!var_3) {
    thread fadeoutin();
  }

  thread patch_self_check();
  wait 1;
  playergivearenaloadout(var_0, var_2);
  thread ref_126c8(3);

  if(getdvarint("scr_br_verify_gulag_loadouts", 0) == 1) {
    level.gulag.lethaldelay = 0;
    thread ref_1428f(var_0);
  }

  if(level.gulag.lethaldelay > 0) {
    thread watchlethaldelayplayer(var_0);
  }

  var_4 = getnextarenaspawn(var_0);
  var_5 = getgroundposition(var_4.origin, 1);
  var_6 = var_4.angles;

  if(!isDefined(var_4.angles)) {
    var_6 = (0, 0, 0);
  }

  ref_126c3(var_5, var_6);
  ref_131aa(0);
  setplayervargulagarena(1);
  self.health = self.maxhealth;
  scripts\mp\gametypes\br_armor::scriptablescurid(level.gulag.ref_11f2d);

  if(getdvarint("scr_br_fc_outline_countdown", 1) > 0) {
    self hudoutlineenableforclients(var_0.arenaplayers, "outline_nodepth_red");
  }

  if(var_3) {
    gulagfadefromblack();
  }

  wait 1;
  self allowprone(1);
  self allowcrouch(1);
  wait level.gulag.impairedkill - 1;
  wait 1;

  if(getdvarint("scr_br_fc_outline_countdown", 1) > 0 && var_0.arenaplayers.size > 0) {
    self hudoutlinedisableforclients(var_0.arenaplayers);
    return;
  }
}

function ref_126b0(var_0) {
  if(var_0) {
    self allowmelee(1);
    self allowmovement(1);
    self enableusability();
    self enableoffhandweapons();
    self allowads(1);
    self allowfire(1);
    return;
  }

  self allowmelee(0);
  self allowmovement(0);
  self disableusability();
  self disableoffhandweapons();
  self allowads(0);
  self allowfire(0);
}

function getnextarenaspawn(var_0) {
  if(!isDefined(var_0.arenaspawncounter)) {
    var_0.arenaspawncounter = 0;
  }

  var_1 = undefined;

  if(ref_14069(var_0)) {
    var_1 = var_0.get_wave_spawn_total[var_0.arenaspawncounter];
  } else {
    var_1 = var_0.fightspawns[var_0.arenaspawncounter];
  }

  var_0.arenaspawncounter++;
  var_0.arenaspawncounter %= var_0.fightspawns.size;
  return var_1;
}

function ref_126c8(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self.plotarmor = 1;
  scripts\engine\utility::ref_143c0(var_0, "death", "gulagRespawn");
  self.plotarmor = undefined;
}

function gulagvictory(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("game_ended");
  var_1 endon("death_or_disconnect");
  var_1 notify("gulag_end");

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  thread ref_1251f();
  ref_12527(var_1);
  thread ref_126c8(var_1);
  var_1.gulagloser = 0;

  if(var_0.jailedplayers.size > 0 && getdvarint("scr_br_fc_spectate_outlines", 0)) {
    var_1 hudoutlinedisableforclients(var_0.jailedplayers);
  }

  var_0.arenaplayers = scripts\engine\utility::array_removeundefined(var_0.arenaplayers);

  if(var_0.arenaplayers.size > 0 && getdvarint("scr_br_fc_outline_countdown", 1) > 0) {
    var_1 hudoutlinedisableforclients(var_0.arenaplayers);
  }

  var_0.arenaplayers = scripts\engine\utility::array_remove(var_0.arenaplayers, var_1);
  var_8 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_1.team, var_1.squadindex);

  foreach(var_10 in var_8) {
    if(var_10 != var_1) {
      var_10 thread scripts\mp\hud_message::showsplash("br_gulag_teammate_out", undefined, var_1);
      scripts\mp\gametypes\br_public::dmztut_endgamewithreward("gulag_teammate_win", var_10);
      LOC_00000126:
    }
    LOC_00000126:
  }

  var_12 = "";

  if(isDefined(var_4)) {
    var_12 = var_4;
  }

  if(!isDefined(var_1.ref_145bf)) {
    ref_126f3(var_1, 1);
  }

  if(!istrue(var_3) && !istrue(var_5) && !istrue(var_7)) {
    thread ref_13dcb(var_1);
  }

  if(var_2) {
    if(!istrue(var_3)) {
      if(var_4 == "timeout") {
        scripts\mp\gametypes\br_public::dmztut_endgamewithreward("gulag_timeout", var_1, 0);
      } else {
        scripts\mp\gametypes\br_public::dmztut_endgamewithreward("gulag_noenemy", var_1, 0);
      }
    }

    var_0.jailedplayers = scripts\engine\utility::array_remove(var_0.jailedplayers, var_1);
    updatematchqueuepositions(var_0);
  } else {
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward("gulag_win", var_1, 0);
  }

  var_1 playsoundtoplayer("gulag_crowd_cheer_winner", var_1);
  var_13 = scripts\mp\music_and_dialog::reset_attack_next_available_time("br_gulag_win");
  var_1 setplayermusicstate(var_13);

  if(istrue(level.gulag.onekillwin) && (istrue(var_0.isjailbreak) || level.gulag.maxplayers > 2)) {
    var_1 playerhide();
  }

  ref_126b3(var_1, 1);
  ref_126b0(var_1, 1);
  ref_125bf(var_1, 0);
  var_1 scripts\mp\gametypes\br_public::updatebrscoreboardstat("isRespawning", 1);
  var_1 scripts\mp\weapons::deleteplacedequipment();
  var_14 = scripts\mp\gametypes\br_public::relic_nuketimer_gettimeformission() / 1000;
  var_15 = ref_125be(var_1, 0, var_14);
  var_16 = ref_1263e(var_1, var_15);
  wait 2;

  if(istrue(level.gulag.arenaflag)) {
    thread calloutmarkerpingvo_canplaywithspamavoidance(var_0.managevehiclehealthui.arenaflag, 0);
  }

  var_1 clearclienttriggeraudiozone(2);
  gulagfadetoblack(var_1, 1);
  wait 1;
  gulagwinnerrespawn(var_1, var_5, var_4, var_15, 1, var_16, undefined, var_6, var_3, var_7);
}

function ref_1263e(var_0) {
  var_1 = scripts\mp\gametypes\br_public::ref_126b8(var_0.origin, var_0.height);
  self calloutmarkerping_getinventoryslot(0);
  scripts\mp\gametypes\br_public::ref_126b9(var_1);
  return var_1;
}

function set_respawn_points(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("gulag_end");
  self endon("gulagLost");
  self waittill("death", var_2);

  if(istrue(level.gulag.onekillwin)) {
    handleonekillwin(var_0, self, var_2, var_1);
  }

  thread set_respawn_loc_delayed(var_0);
}

function set_respawn_loc_delayed(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("pull_out_of_gulag");
  self notify("gulagLost");

  if(istrue(self.gulagloser)) {
    return;
  }

  self.gulagloser = 1;
  self.ref_136dc = var_0.ref_136dc;
  thread ref_1268e(1);
  var_0.jailedplayers = scripts\engine\utility::array_removeundefined(var_0.jailedplayers);

  if(var_0.jailedplayers.size > 0 && getdvarint("scr_br_fc_spectate_outlines", 0)) {
    self hudoutlinedisableforclients(var_0.jailedplayers);
  }

  var_0.arenaplayers = scripts\engine\utility::array_removeundefined(var_0.arenaplayers);

  if(var_0.arenaplayers.size > 0 && getdvarint("scr_br_fc_outline_countdown", 1) > 0) {
    self hudoutlinedisableforclients(var_0.arenaplayers);
  }

  var_0.arenaplayers = scripts\engine\utility::array_remove(var_0.arenaplayers, self);

  if(isDefined(self)) {
    var_1 = self.name;
  } else {
    var_1 = "<undefined>";
  }

  var_2 = scripts\mp\music_and_dialog::reset_attack_next_available_time("br_gulag_lose");
  self setplayermusicstate(var_2);
  scripts\mp\weapons::deleteplacedequipment();
  scripts\mp\gametypes\br::ref_11b15(self, "gulagPlayerLost");
  level thread scripts\mp\gametypes\br::ref_14006();
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("gulag_lose", self, 0, 1);
  scripts\mp\gametypes\br_public::dmztutdropcash("gulag_teammate_lose", self.team, self, 0, 0);

  if(isalive(self)) {
    thread scripts\mp\gametypes\br_spectate::ref_13dc2();
    self.plotarmor = 1;
    self freezecontrols(1);
  }

  wait 2;
  self clearclienttriggeraudiozone(2);

  if(istrue(level.gulag.arenaflag)) {
    thread calloutmarkerpingvo_canplaywithspamavoidance(var_1.managevehiclehealthui.arenaflag, 0);
  }

  scripts\cp\vehicles\vehicle_compass_cp::ref_1203c(2);
  scripts\mp\gametypes\br_analytics::destroyaward(self, "loser");
  playerdestroyhud(var_1);
  setplayervargulag(0);
  setplayervargulagarena(0, 1);
  ref_131aa(0);

  if(isalive(self)) {
    if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("teamSpectate")) {
      scripts\mp\gametypes\br_spectate::ref_11be2(self, undefined, 1);
    }

    gulagfadetoblack();
    wait 1;

    if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("teamSpectate")) {
      scripts\mp\gametypes\br_spectate::ref_11be2(self, undefined, 1);
    }

    if(isalive(self)) {
      var_3 = spawnStruct();
      var_3.origin = self.origin;
      var_3.angles = self.angles;
      var_3.attacker = self.lastattacker;
      self.health = 0;
      self notify("death");
      self notify("death_or_disconnect");
      scripts\mp\gametypes\br_spectate::spawnspectator(var_3, 1, 1);
      scripts\mp\playerlogic::removefromalivecount(0, "gulagPlayerLost");
    }

    gulagfadefromblack();
  }

  self.plotarmor = undefined;
}

function ref_1268e(var_0) {
  if(istrue(level.usegulag)) {
    if(var_0) {
      self.ref_14439 = var_0;
      self setclientomnvar("ui_gulag", var_0);
    } else {
      self.ref_14439 = undefined;
      self setclientomnvar("ui_gulag", 0);
    }

    ref_131a1(var_0);
    return;
  }
}

function ref_126aa() {
  if(istrue(level.usegulag) && istrue(self.ref_14439) && scripts\mp\gametypes\br_public::rotationids(self.team, self.squadindex) > 0) {
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward("gulag_buyback", self, 0, 1);
    return;
  }
}

function ref_12aa8(var_0, var_1) {
  if(istrue(var_1.gulagarena)) {
    var_2 = var_1.arena;
    var_2.molotovs[var_2.molotovs.size] = var_0;
    return;
  }
}

function ref_12aaa(var_0, var_1) {
  if(istrue(var_1.gulagarena)) {
    var_2 = var_1.arena;
    var_2.ref_13b29[var_2.ref_13b29.size] = var_0;
    return;
  }
}

function handlesoloexclusionils(var_0) {
  foreach(var_2 in var_0.molotovs) {
    if(isDefined(var_2)) {
      thread scripts\mp\equipment\molotov::ref_11cb5(var_2);
    }
  }

  var_0.molotovs = [];

  foreach(var_5 in var_0.ref_13b29) {
    if(isDefined(var_5)) {
      var_5 thread scripts\mp\equipment\thermite::thermite_destroy();
    }
  }

  var_0.ref_13b29 = [];
}

function set_relic_squadlink(var_0) {
  var_1 = isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent);

  if(!var_1) {
    return true;
  }

  var_2 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  var_3 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  var_4 = distance2d(var_0, var_2);
  return var_4 < var_3;
}

function set_relic_shieldsonly(var_0) {
  var_1 = isDefined(level.br_circle) && isDefined(level.br_circle.dangercircleent);

  if(!var_1) {
    return true;
  }

  var_2 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var_3 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  var_4 = distance2d(var_0, var_2);
  return var_4 < var_3;
}

function set_relic_rocket_kill_ammo(var_0, var_1) {
  if(!scripts\mp\gametypes\br_c130::ispointinbounds(var_0, 1)) {
    return false;
  }

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.safecircleent) || !isDefined(level.br_circle.dangercircleent)) {
    return true;
  }

  if(scripts\mp\utility\game::round_vehicle_logic() == "truckwar") {
    if(set_relic_shieldsonly(var_0)) {
      return true;
    }
  } else {
    if(set_relic_squadlink(var_0)) {
      return true;
    }

    if(!set_relic_shieldsonly(var_0)) {
      return false;
    }
  }

  if(isDefined(var_1)) {
    var_2 = scripts\mp\gametypes\br_circle::getmintimetillpointindangercircle(var_0);

    if(var_1 > var_2) {
      return false;
    }
  }

  var_3 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  var_4 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  var_5 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var_6 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  var_7 = length(var_5 - var_3);
  var_8 = vectorNormalize(var_5 - var_3);
  var_9 = level.ref_12ca0;
  var_10 = var_3 + var_8 * var_7 * var_9;
  var_11 = var_4 + (var_6 - var_4) * var_9;
  var_12 = distance2d(var_0, var_10);
  return var_12 < var_11;
}

function updateplayereliminatedomnvar(var_0, var_1) {
  if(var_0 == self) {
    return false;
  }

  if(!isalive(var_0) || var_0 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() || istrue(var_0.delay_enter_combat_after_investigating_grenade)) {
    return false;
  }

  if(!set_relic_rocket_kill_ammo(var_0.origin, var_1)) {
    return false;
  }

  return true;
}

function ref_12568(var_0, var_1, var_2) {
  var_3 = undefined;

  if(istrue(level.onlinegame) && self getprivatepartysize()) {
    var_4 = undefined;

    foreach(var_6 in self getfireteammembers()) {
      if(!updateplayereliminatedomnvar(var_6, var_1)) {
        continue;
      }

      var_4 = var_6;

      if(var_6 isfireteamleader()) {
        break;
      }
    }

    if(isDefined(var_4) && istrue(var_0)) {
      var_3 = var_4;
      var_4 = undefined;

      foreach(var_6 in self getfireteammembers()) {
        if(isDefined(var_3) && var_3 == var_6) {
          continue;
        }

        if(!updateplayereliminatedomnvar(var_6, var_1)) {
          continue;
        }

        var_4 = var_6;

        if(var_6 isfireteamleader()) {
          break;
        }
      }
    }

    if(isDefined(var_4)) {
      return var_4;
    }
  }

  if(isDefined(self.lastdeathpos)) {
    var_10 = undefined;
    var_11 = undefined;
    var_12 = scripts\mp\gametypes\br_public::rotationrefsbyseatandweapon(self.team, self.squadindex);

    foreach(var_14 in var_12) {
      if(isDefined(var_3) && var_3 == var_14) {
        continue;
      }

      if(!updateplayereliminatedomnvar(var_14, var_1)) {
        continue;
      }

      if(var_14 isparachuting() || var_14 isskydiving()) {
        continue;
      }

      var_15 = distance2dsquared(self.lastdeathpos, var_14.origin);

      if(!isDefined(var_11) || var_15 < var_11) {
        var_10 = var_14;
        var_11 = var_15;
      }
    }

    if(isDefined(var_10) && istrue(var_0) && !isDefined(var_3)) {
      var_3 = var_10;
      var_10 = undefined;
      var_11 = undefined;

      foreach(var_14 in var_12) {
        if(isDefined(var_3) && var_3 == var_14) {
          continue;
        }

        if(!updateplayereliminatedomnvar(var_14, var_1)) {
          continue;
        }

        if(var_14 isparachuting() || var_14 isskydiving()) {
          continue;
        }

        var_15 = distance2dsquared(self.lastdeathpos, var_14.origin);

        if(!isDefined(var_11) || var_15 < var_11) {
          var_10 = var_14;
          var_11 = var_15;
        }
      }
    }

    if(isDefined(var_10)) {
      return var_10;
    }
  }

  var_10 = undefined;
  var_19 = scripts\engine\utility::array_randomize(scripts\mp\gametypes\br_public::rotationrefsbyseatandweapon(self.team, self.squadindex));

  foreach(var_21 in var_19) {
    if(isDefined(var_3) && var_3 == var_21) {
      continue;
    }

    if(!updateplayereliminatedomnvar(var_21, var_1)) {
      continue;
    }

    var_10 = var_21;

    if(istrue(var_21 scripts\mp\gametypes\br_public::updatedragonsbreath())) {
      break;
    }
  }

  if(isDefined(var_10)) {
    return var_10;
  } else if(!istrue(var_2)) {
    if(scripts\mp\utility\game::round_vehicle_logic() == "dmz" || scripts\mp\utility\game::round_vehicle_logic() == "rat_race" || scripts\mp\utility\game::round_vehicle_logic() == "risk" || scripts\mp\utility\game::round_vehicle_logic() == "gold_war") {
      var_23 = scripts\mp\utility\teams::getteamdata(self.team, "teamCount");

      if(var_23 == 1 && !istrue(self.locationtriggersetpaused) && !scripts\mp\outofbounds::ispointinoutofbounds(self.origin)) {
        return self;
      }
    }
  }

  return undefined;
}

function rocket_fuel_stability(var_0, var_1, var_2) {
  var_3 = ai_washitbyvehicle(var_0, var_1, var_2);
  scripts\mp\gametypes\br_analytics::detonatesound(var_0, 0, var_3);
  return var_3;
}

function ai_washitbyvehicle(var_0, var_1, var_2) {
  var_3 = 3.14159;
  var_4 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  var_5 = vectorNormalize(var_0 - var_4);
  var_6 = vectortoangles(var_5);
  var_7 = randomfloatrange(getdvarfloat("scr_br_respawn_rand_ang_min", 10), getdvarfloat("scr_br_respawn_rand_ang_max", 90));
  var_8 = scripts\mp\utility\game::round_vehicle_logic();

  if((var_8 == "dmz" || var_8 == "rat_race") && getdvarint("scr_dmz_respawn_rand_ang", 0) == 1 || var_8 == "rumble_invasion") {
    var_9 = vectorNormalize(anglesToForward(var_6 + (0, scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), var_7, var_7 * -1), 0)));
  } else {
    var_9 = var_6;
  }

  var_10 = var_1 + var_9 * var_2;

  if(set_relic_rocket_kill_ammo(var_10, var_3)) {
    return var_10;
  }

  var_9 *= -1;
  var_10 = var_1 + var_9 * var_2;

  if(set_relic_rocket_kill_ammo(var_10, var_3)) {
    return var_10;
  }

  var_9 = vectorNormalize(var_5 - var_1);
  var_10 = var_1 + var_9 * var_2;

  if(set_relic_rocket_kill_ammo(var_10, var_3)) {
    return var_10;
  }

  var_11 = var_2;
  var_12 = distance2d(var_1, var_5);

  if(var_12 > 0) {
    var_13 = var_11 / var_12;

    if(var_13 > var_4) {
      var_13 = var_4;
    }

    var_14 = var_13 * 180 / var_4;
    var_10 = rotatepointaroundvector((0, 0, 1), var_1 - var_5, var_14) + var_5;

    if(set_relic_rocket_kill_ammo(var_10, var_3)) {
      return var_10;
    }
  }

  var_10 = scripts\mp\gametypes\br_circle::getrandompointincircle(var_1, var_2);

  if(set_relic_rocket_kill_ammo(var_10, var_3)) {
    return var_10;
  }

  return undefined;
}

function ref_12567() {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("missions")) {
    return undefined;
  }

  foreach(var_1 in level.questinfo.quests) {
    foreach(var_3 in var_1.instances) {
      if(var_4 == self.team && !scripts\mp\gametypes\br_quest_util::upper_door_coll(var_3)) {
        switch (var_3.category) {
          case "assassination":
            if(isDefined(var_3.targetplayer)) {
              return var_3.targetplayer.origin;
            }

            break;
          case "domination":
            if(isDefined(var_3.ref_1393b) && isDefined(var_3.ref_1393b.domflag) && isDefined(var_3.ref_1393b.domflag.curorigin)) {
              return var_3.ref_1393b.domflag.curorigin;
            }

            break;
          case "lep":
          case "scavenger_adler":
          case "scavenger":
            if(isDefined(var_3.ref_1393b.force_spawn_all_dead_players.origin) && isDefined(var_3.ref_1393b.force_spawn_all_dead_players)) {
              return var_3.ref_1393b.force_spawn_all_dead_players.origin;
            }

            break;
          case "x2_amb_signal":
          case "x2_stash":
          case "x2_map":
          case "x2_signal":
          case "x2_amb1":
          case "x2_bomb":
          case "x1fin":
          case "history":
          case "x1stash":
          case "smokinggun":
          case "vip":
            break;
          default:
            break;
        }
      }
    }
  }

  return undefined;
}

function ref_12566(var_0) {
  foreach(var_2 in level.br_pickups.crates) {
    if(!isDefined(var_2) || !isDefined(var_2.team) || var_2.team != self.team) {
      continue;
    }

    if(isDefined(var_2.playerscaptured) && isDefined(var_2.playerscaptured[self getentitynumber()])) {
      continue;
    }

    if(set_relic_rocket_kill_ammo(var_2.origin, var_0)) {
      return var_2.origin;
    }
  }
}

function playergetnearbybombsiteorigin(var_0) {
  var_1 = level.disable_super_in_turret.bombsiteteamdeathmaxdistance * level.disable_super_in_turret.bombsiteteamdeathmaxdistance;

  foreach(var_3 in level.disable_super_in_turret.br_activebombsites) {
    if(isDefined(var_3) && distance2dsquared(var_0, var_3.origin) <= var_1) {
      return var_3.origin;
    }
  }
}

function ref_125be(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  var_5 = var_2;
  var_6 = 1;
  var_7 = 0;

  if(isDefined(self.setspawnpoint)) {
    var_3 = self.setspawnpoint.playerspawnpos;
    var_4 = self.setspawnpoint.playerspawnangles;
  }

  var_8 = getdvarfloat("scr_br_respawnMaxLastDeathOffset", -1);

  if(!isDefined(var_3) && var_8 >= 0 && isDefined(self.lastdeathpos)) {
    var_9 = rocket_fuel_stability(self.lastdeathpos, var_8, var_1);

    if(isDefined(var_9)) {
      var_3 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_9);
      var_4 = registercarryobjectpickupcheck(var_3, self.lastdeathpos);
    }
  }

  var_8 = getdvarfloat("scr_br_respawnMaxTeammateOffset", 1000);

  if(!isDefined(var_3) && var_8 >= 0) {
    var_10 = ref_12568(var_0, var_1);

    if(isDefined(var_10)) {
      var_11 = getdvarfloat("scr_bmo_respawn_intermission_time", 5) * 1000;
      var_12 = getdvarfloat("scr_bmo_redeploy_window", 30) * 1000;

      if((getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "kingslayer" || getDvar("scr_br_gametype", "") == "gold_war") && isDefined(level.teamdata[self.team]["lastParachuteTime"]) && level.teamdata[self.team]["lastParachuteTime"] + var_12 > gettime() + var_11 && distance2d(level.teamdata[self.team]["lastParachuteOrigin"], var_10.origin) < getdvarfloat("scr_br_respawnMaxTeammateOffset", 1000) * 1.25) {
        var_3 = level.teamdata[self.team]["lastParachuteOrigin"];
        var_4 = level.teamdata[self.team]["lastParachuteAngles"];
      } else {
        var_3 = rocket_fuel_stability(var_10.origin, var_8, var_1);

        if(isDefined(var_3)) {
          var_3 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_3);
          var_4 = registercarryobjectpickupcheck(var_3, var_10.origin);
          level.teamdata[self.team]["lastParachuteOrigin"] = var_3;
          level.teamdata[self.team]["lastParachuteAngles"] = var_4;
          level.teamdata[self.team]["lastParachuteTime"] = gettime();
        }
      }

      if(isDefined(var_3) && isDefined(level.ref_12ca9) && level.ref_12ca9 >= 0) {
        var_13 = getclosestpointonnavmesh(var_3);
        var_14 = var_13 - var_3;

        if(length2d(var_14) > level.ref_12ca9) {
          var_14 = vectorNormalize(var_14);
          var_14 = (var_14[0] * level.ref_12ca9, var_14[1] * level.ref_12ca9, var_14[2] * level.ref_12ca9);
          var_3 = var_13 + var_14;
        }
      }
    }
  }

  var_8 = getdvarfloat("scr_br_respawnMaxMissionOffset", 3000);

  if(!isDefined(var_3) && var_8 >= 0) {
    var_15 = ref_12567();

    if(isDefined(var_15)) {
      var_3 = rocket_fuel_stability(var_15, var_8, var_1);
      var_4 = registercarryobjectpickupcheck(var_3, var_15);
    }
  }

  var_8 = getdvarfloat("scr_br_respawnMaxCrateOffset", 3000);

  if(!isDefined(var_3) && var_8 >= 0) {
    var_16 = ref_12566(var_1);

    if(isDefined(var_16)) {
      var_3 = rocket_fuel_stability(var_16, var_8, var_1);
      var_4 = registercarryobjectpickupcheck(var_3, var_16);
    }
  }

  if(scripts\mp\utility\game::round_vehicle_logic() == "olaride" && issquadwiped(self.team)) {
    var_17 = self.origin;

    if(isDefined(self.lastdeathpos)) {
      var_17 = self.lastdeathpos;
    }

    var_18 = playergetnearbybombsiteorigin(var_17);

    if(!isDefined(var_18)) {
      var_18 = var_17;
    }

    var_8 = level.disable_super_in_turret.teamdeathrespawnmaxradius;
    var_3 = rocket_fuel_stability(var_18, var_8, var_1);
    var_4 = registercarryobjectpickupcheck(var_3, var_18);
  }

  if(!isDefined(var_3)) {
    if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
      if(getdvarint("scr_br_useClosestSafePointFromSquadmate", 0)) {
        var_19 = getdvarfloat("scr_br_closestSafePointTimeOffset", 2);
        var_3 = scripts\mp\gametypes\br_circle::helibankplunder(self, var_1, var_19);
      }

      if(!isDefined(var_3)) {
        var_20 = getdvarfloat("scr_br_useClosestSafePerimeterPointRadiusPct", 0.9);

        if(getdvarint("scr_br_useClosestSafePerimeterPointFromSquadmate", 1)) {
          var_3 = scripts\mp\gametypes\br_circle::closestsafeperimeterpointfromsquadmate(var_20, var_1);
        }

        if(!isDefined(var_3) && getdvarint("scr_br_useClosestSafePerimeterPointFromLoadout", 1)) {
          var_3 = scripts\mp\gametypes\br_circle::closestsafeperimeterpointfromloadout(var_20, var_1);
        }

        if(isDefined(var_3)) {
          var_4 = registercarryobjectpickupcheck(scripts\mp\gametypes\br_circle::getsafecircleorigin(), var_3);
          var_21 = 0;

          if(getdvarint("scr_br_useClosestSafePerimeterPerpendicularFacing", 1)) {
            var_22 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
            var_23 = randomint(2);
            var_24 = [90, -90];
            var_25 = [-10, 10];
            var_26 = rotatevector(var_3 - var_22, (0, var_25[var_23], 0)) + var_22;
            var_27 = scripts\mp\gametypes\br_circle::vandalize_minigun_speed(var_26, 0, var_1);

            if(var_27 == 0) {
              var_23 = 1 - var_23;
              var_26 = rotatevector(var_3 - var_22, (0, var_25[var_23], 0)) + var_22;
              var_27 = scripts\mp\gametypes\br_circle::vandalize_minigun_speed(var_26, 0, var_1);
            }

            if(var_27) {
              var_3 = var_26;
              var_21 = var_24[var_23];
            }
          }

          var_28 = angleclamp(var_4[1] + var_21);
          var_4 = (0, var_28, 0);
        }
      }

      if(!isDefined(var_3)) {
        var_29 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
        var_30 = scripts\mp\gametypes\br_circle::getsafecircleradius();
        var_31 = getdvarfloat("scr_br_minRespawnRadiusPct", 0.9);
        var_20 = getdvarfloat("scr_br_maxRespawnRadiusPct", 0.9);
        var_32 = getdvarint("scr_br_maxRespawnDropToGround", 1);
        var_33 = getdvarint("scr_br_maxRespawnSnapToNavMesh", 1);

        if(getdvarint("scr_br_respawn_one_circle_fallback", 1) && var_30 == 0) {
          var_34 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
          var_35 = scripts\mp\gametypes\br_circle::getdangercircleradius();

          if(var_35 > 0) {
            var_29 = var_34;
            var_30 = var_35;
            var_31 = getdvarfloat("scr_br_minRespawnRadiusPct_fallback", 0.6);
            var_20 = getdvarfloat("scr_br_maxRespawnRadiusPct_fallback", 0.8);
            var_7 = 1;
          }
        }

        var_3 = scripts\mp\gametypes\br_circle::risk_flagspawnshiftingpercent(var_29, var_30, var_31, var_20, var_32, var_33, 0, var_1);
      }
    } else if(isDefined(level.prematchspawnorigins)) {
      if(isDefined(level.teamdata[self.team]["chosenSpawnWipeOrigin"]) && isDefined(level.teamdata[self.team]["spawnWipeOriginUseStartTime"]) && isDefined(level.checkpoint_objective_id) && level.teamdata[self.team]["spawnWipeOriginUseStartTime"] + level.checkpoint_objective_id * 1000 > gettime()) {
        var_3 = level.teamdata[self.team]["chosenSpawnWipeOrigin"];
      } else {
        var_36 = [];

        foreach(var_38 in level.prematchspawnorigins) {
          if(distance2dsquared(var_38.origin, self.origin) > var_8) {
            var_36 = var_38;
          }
        }

        if(var_36.size == 0) {
          var_36 = level.prematchspawnorigins;
        }

        var_36 = scripts\engine\utility::array_randomize(var_36);

        if((getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "gold_war") && isDefined(level.ref_12ca7) && istrue(self.ref_13749)) {
          var_3 = (var_36[0].origin[0], var_36[0].origin[1], level.ref_12ca7);
        } else {
          var_3 = var_36[0].origin;
        }

        var_3 += scripts\engine\math::random_vector_2d() * randomfloatrange(100, 500);
        level.teamdata[self.team]["chosenSpawnWipeOrigin"] = var_3;
        level.teamdata[self.team]["spawnWipeOriginUseStartTime"] = gettime();
      }

      var_4 = (0, 0, 0);

      if(var_3[2] > 10000 &!isDefined(var_2)) {
        var_6 = 0;
        var_5 = scripts\mp\gametypes\br_public::getinfilspawnoffset();
      }
    } else {
      var_3 = (0, 0, 0);
      var_4 = (0, 0, 0);
    }
  }

  if(!isDefined(var_4)) {
    if(var_7) {
      var_40 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
    } else {
      var_40 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    }

    var_41 = vectortoyaw(var_40 - var_4);
    var_5 = (0, var_41, 0);
  }

  if(var_7) {
    if(!isDefined(var_6)) {
      var_6 = scripts\cp_mp\parachute::getc130height();
    }

    if(isDefined(level.br_circle)) {
      var_42 = level.br_circle.circleindex;
      var_43 = remove_engineer_class();
      var_44 = isDefined(var_42) && var_42 >= var_43;

      if(var_44) {
        var_6 *= getdvarfloat("scr_br_gulagClosedSpawnOffsetScaler", 0.55);
      }
    }

    if(isDefined(level.ref_12ca7)) {
      var_6 = level.ref_12ca7;
    }

    var_45 = (0, 0, var_6);
    var_4 = scripts\mp\gametypes\br::resetcircuitbreakers(var_4, var_45);
  }

  var_46 = spawnStruct();
  var_46.origin = var_4;
  var_46.angles = var_5;
  var_46.height = var_6;
  return var_46;
}

function registercarryobjectpickupcheck(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = vectortoyaw(var_1 - var_0);
    var_3 = (0, var_2, 0);
    return var_3;
  }
}

function gulagwinnerrespawn(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = !istrue(var_0);

  if(!istrue(var_0) && !istrue(var_8)) {
    scripts\cp\vehicles\vehicle_compass_cp::ref_1203c(1);
  }

  if(!isDefined(var_10)) {
    var_10 = 0;
  }

  if(isDefined(var_1)) {
    scripts\mp\gametypes\br_analytics::destroyaward(self, var_1);
  }

  ref_1268e(0);
  setplayervargulag(0);
  setplayervargulagarena(0);

  if(scripts\mp\utility\game::getgametype() == "br") {
    playerdestroyhud(self.arena);
  }

  ref_131aa(0);
  level notify("update_circle_hide");
  self.vehicle_compass_friendlystatuschangedcallback = undefined;
  scripts\mp\gametypes\br::scriptednode(self);
  playertakeawayrock(self.arena);
  set_showing_bomb_wire_pair_to_player(var_0);

  if(isDefined(level.gulag) && istrue(level.gulag.planerespawn)) {
    playerrespawngulagcleanup(var_0);
    set_scriptable_states();
    playersetupac130();

    if(isDefined(self.oobimmunity)) {
      scripts\mp\outofbounds::disableoobimmunity(self);
    }

    return;
  }

  if(!isDefined(var_2)) {
    var_2 = ref_125be();
  }

  var_12 = var_2.origin;
  var_13 = var_2.angles;
  var_14 = var_12;

  if(isDefined(var_4)) {
    var_14 = var_4;
  }

  set_scriptable_states();
  ref_126c3(var_14, var_13);
  var_15 = spawn("script_model", var_14);
  var_15 setModel("tag_origin");
  var_15.angles = var_13;
  var_15 hide();
  var_15 showtoplayer(self);
  self playerlinktoabsolute(var_15, "tag_origin");
  self playerhide();
  thread ref_12524(var_15);
  waitframe();

  if(isDefined(self.oobimmunity)) {
    scripts\mp\outofbounds::disableoobimmunity(self);
  }

  playerrespawngulagcleanup(var_0);

  if(getdvarint("scr_skip_respawn_gate", 1) == 0) {
    scripts\mp\gametypes\br_public::ref_126ed();
  }

  scripts\mp\gametypes\br_public::ref_1252b();

  if(isDefined(var_4)) {
    var_15.origin = var_12;
  }

  var_15 playsoundtoplayer("br_ac130_flyby", self);
  wait 1.5;
  self unlink();
  self clearsoundsubmix("deaths_door_mp");

  if(scripts\mp\gametypes\br_public::tutorial_playSound()) {
    self clearsoundsubmix("iw8_br_gulag_tutorial", 2);
  } else {
    self clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 2);
  }

  self clearclienttriggeraudiozone(1);
  self playershow(1);
  ref_125bf(1);
  var_16 = 0;

  if(isDefined(level.ref_121cc)) {
    var_16 = level.ref_121cc;
  }

  if(!scripts\mp\gametypes\br_public::uniquelootitemid()) {
    if(istrue(level.ref_13678)) {
      self[[level.parachuterestoreweaponscb]]();
    } else {
      thread scripts\cp_mp\parachute::startfreefall(var_16, 0, undefined, undefined, 1);
    }
  }

  if(!istrue(var_3)) {
    thread ref_13dcb(7);
  }

  if(istrue(var_5)) {
    self setclientomnvar("ui_br_transition_type", 0);
  }

  if(scripts\mp\utility\game::getgametype() == "br") {
    self setclientomnvar("ui_show_spectateHud", -1);
  }

  ref_12c7a();
  var_17 = scripts\mp\utility\perk::_hasperk("specialty_br_reinforced");
  scripts\mp\gametypes\br_armor::searchcirclesize(var_17);
  scripts\mp\gametypes\br_quest_util::ref_12072();
  scripts\mp\gametypes\br_rewards::ref_12072();
  scripts\mp\gametypes\br_alt_mode_escape::obj_hangar_juggs();
  scripts\mp\gametypes\br_gametypes::ref_12e05("gulagWinnerRespawn", self);
  wait 0.5;

  if(scripts\mp\utility\game::getgametype() == "br" && !isDefined(self.ref_145bf)) {
    gulagfadefromblack();
  }

  waitframe();
  var_15 delete();
  _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("gulag");

  if(istrue(level.ref_133ef)) {
    scripts\mp\gametypes\br_skydive_protection::toma_strike_munitionused(1);
  }

  if(scripts\mp\gametypes\br_public::tutorial_playSound()) {
    self notify("respawn_from_gulag");
  }

  self notify("can_show_splashes");

  if(istrue(getDvar("scr_br_gametype", "") == "truckwar") && !istrue(var_8)) {
    var_18 = "br_gulag_winner_redeploy_mogulag";
    var_19 = undefined;
  }

  if(istrue(getDvar("scr_br_gametype", "") == "dmz") || istrue(getDvar("scr_br_gametype", "") == "rat_race") || istrue(getDvar("scr_br_gametype", "") == "kingslayer") || istrue(getDvar("scr_br_gametype", "") == "rumble") || istrue(getDvar("scr_br_gametype", "") == "risk") || istrue(getDvar("scr_br_gametype", "") == "sandbox") || istrue(getDvar("scr_br_gametype", "") == "rumble_invasion") || istrue(getDvar("scr_br_gametype", "") == "gold_war")) {
    var_18 = "br_gulag_winner_redeploy_mogulag";
    var_19 = undefined;
  } else if(istrue(var_9)) {
    var_18 = "br_gulag_jailbreak_redeploy";
    var_19 = undefined;
  } else if((istrue(var_4) || istrue(var_12)) && !var_14) {
    var_18 = "br_gulag_kiosk_redeploy";
    var_19 = var_10;
  } else {
    if(istrue(isDefined(level.gulag) && !istrue(level.gulag.shutdown)) && checkgulagusecount()) {
      var_18 = "br_gulag_winner_redeploy_mogulag";
    } else {
      var_18 = "br_gulag_winner_redeploy";
    }

    var_19 = undefined;
  }

  if(!istrue(var_16)) {
    thread scripts\mp\hud_message::showsplash(var_18, undefined, var_19);
  }

  if(istrue(self.ref_145bf) && isDefined(level.br_circle)) {
    self.ref_145bf = undefined;

    if(istrue(self.ref_12c9e)) {
      playerrespawngulagcleanup(var_7);
      set_scriptable_states();
      _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("gulag");

      if(isDefined(self.oobimmunity)) {
        scripts\mp\outofbounds::disableoobimmunity(self);
      }
    }

    ref_1268c();
  }

  if(isDefined(level.gulag) && istrue(level.gulag.shutdown) && !istrue(self.gulagdone)) {
    wait 2;
    playergulagdonesplash();
  }

  if(var_17) {
    scripts\mp\gametypes\br::ref_13f21(self, "gulagWinnerRespawn-token");
    level thread scripts\mp\gametypes\br::ref_14006();
  }

  var_20 = "undefined";

  if(isDefined(self.currentweapon)) {
    var_20 = self.currentweapon.basename;
  }

  var_21 = "undefined";

  if(isDefined(self.name)) {
    var_21 = self.name;
  }

  logstring("[FD] Finished respawning in fd for player: " + var_21 + " with weapon: " + var_20);
}

function ref_12524(var_0) {
  var_0 endon("death");
  self waittill("disconnect");

  if(isDefined(var_0)) {
    var_0 delete();
    return;
  }
}

function ref_125bf(var_0) {
  if(var_0) {
    self enableoffhandweapons();
    self enableusability();
    return;
  }

  self disableoffhandweapons();
  self disableusability();
}

function ref_13dcb(var_0) {
  self endon("disconnect");
  var_1 = scripts\mp\gametypes\br_gametypes::ref_12e05("triggerRespawnOverlay");

  if(istrue(var_1)) {
    return;
  }

  ref_13dcc();
}

function ref_13dcc() {
  wait 0.5;

  if(istrue(self.ref_145bf)) {
    thread scripts\mp\hud_message::showsplash("br_gulag_respawn_in_fd");
    return;
  }

  thread scripts\mp\hud_message::showsplash("br_gulag_winner");
}

function playerrespawngulagcleanup(var_0) {
  self notify("gulagRespawn");
  scripts\mp\equipment\molotov::molotov_clear_burning();

  if(getdvarint("scr_br_gulag_cleanup_killswitch", 0) == 0) {
    self.shouldhumanspawntags = 0;
  }

  self.health = self.maxhealth;
  scripts\mp\healthoverlay::onexitdeathsdoor(1);

  if(!istrue(var_0)) {
    scripts\mp\utility\player::enableplayerforspawnlogic(0);
    self setclientomnvar("ui_gulag", 0);
    scripts\mp\gametypes\br_public::updatebrscoreboardstat("isRespawning", 0);

    if(isDefined(self.arena)) {
      removeloadingplayer(self.arena, self);
    }

    self.arena = undefined;
    return;
  }
}

function set_showing_bomb_wire_pair_to_player(var_0) {
  var_1 = getdvarint("scr_br_fc_keep_gun", 1) != 0;
  var_2 = istrue(level.debug_safehouse_regroup_start) && !istrue(level.debug_show2dvotext);
  var_3 = !istrue(var_0);

  if(var_1 && var_3 && !var_2) {
    return gulagwinnerremembergunandammo();
  }

  var_4 = getdvarint("scr_br_fc_loadouts", 1) != 0 && getdvarint("scr_br_fc_winner_loadout", -1) > -1;

  if(isDefined(level.deletescriptableinstanceaftertime) || var_4) {
    self.set_shouldrespawn = 1;
    return;
  }

  self.set_shouldrespawn = 0;
}

function set_solution() {
  if(!istrue(level.usegulag) && !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("gulagWinnerRestoreLoadoutUseGulag")) {
    return 0;
  }

  var_0 = getdvarint("scr_br_fc_keep_gun", 1) != 0;
  var_1 = !istrue(self.gulagloser);

  if(var_0 && var_1) {
    return set_slow_healthregen();
  }

  var_2 = getdvarint("scr_br_fc_loadouts", 1) != 0 && getdvarint("scr_br_fc_winner_loadout", -1) > -1;

  if(isDefined(level.deletescriptableinstanceaftertime) || var_2) {
    return set_spawn_scoring_params_for_level();
  }

  return 0;
}

function gulagwinnerremembergunandammo() {
  self.br_gulagguncurrent = self getcurrentprimaryweapon();
  var_0 = self getweaponslistprimaries();
  var_0 = scripts\engine\utility::array_remove(var_0, getcompleteweaponname("iw8_knifestab_mp"));
  var_0 = scripts\engine\utility::array_remove(var_0, getcompleteweaponname("iw8_throwingknife_fire_melee_mp"));
  var_0 = scripts\engine\utility::array_remove(var_0, getcompleteweaponname("iw8_throwingknife_electric_melee_mp"));
  var_0 = scripts\engine\utility::array_remove(var_0, getcompleteweaponname("iw8_throwingknife_drill_melee_mp"));
  var_0 = scripts\engine\utility::array_remove(var_0, getcompleteweaponname("iw8_fists_mp"));
  self.br_gulagguns = [];
  self.br_gulagammo = [];

  foreach(var_2 in var_0) {
    var_3 = createheadicon(var_2);

    if(getsubstr(var_3, 0, 4) == "alt_") {
      continue;
    }

    self.br_gulagguns[self.br_gulagguns.size] = var_2;

    if(getdvarint("scr_br_gulag_rememberammo", 0) == 1) {
      self.br_gulagammo[var_3] = self getweaponammoclip(var_2) + self getweaponammostock(var_2);
      continue;
    }

    self.br_gulagammo[var_3] = weaponclipsize(var_2) * 3;
  }

  var_5 = self getweaponslistoffhands();
  var_6 = "primary";
  self.br_gulagoffhands = [];

  foreach(var_8 in var_5) {
    var_9 = self getweaponammoclip(var_8);

    if(var_9 <= 0) {
      scripts\mp\equipment::takeequipment(var_6);
      var_6 = "secondary";
      continue;
    }

    var_6 = "secondary";
    self.br_gulagoffhands[self.br_gulagoffhands.size] = var_8;
    var_10 = createheadicon(var_8);
    self.br_gulagammo[var_10] = weaponstartammo(var_8);
  }
}

function set_slow_healthregen() {
  if(isDefined(self.br_gulagguns) && isDefined(self.br_gulagoffhands) && isDefined(self.br_gulagammo)) {
    var_0 = getdvarint("scr_br_shutdownloadout", 1) == 1;

    if(var_0 && self.br_gulagguns.size < 1) {
      self.set_shouldrespawn = 1;
      set_spawn_scoring_params_for_level();
      return false;
    }

    self takeallweapons();
    scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
    self.equipment["primary"] = undefined;
    self.equipment["secondary"] = undefined;
    self.equipment["health"] = undefined;
    self.equipment["super"] = undefined;
    var_1 = 0;

    foreach(var_3 in self.br_gulagguns) {
      var_4 = createheadicon(var_3);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3);
      self setweaponammostock(var_3, 0);

      if(!var_1) {
        self assignweaponprimaryslot(var_4);
        scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_3);
        var_1 = 1;
      }

      scripts\mp\weapons::fixupplayerweapons(self, var_4);
      thread scripts\mp\gametypes\br_respawn::giveweaponpickup(var_4);
      var_5 = weaponclipsize(var_3);
      var_6 = int(min(var_5, 25));

      if(isDefined(self.br_gulagammo[var_4])) {
        var_6 = int(max(var_6, self.br_gulagammo[var_4]));
      }

      var_7 = 0;

      if(var_6 > var_5) {
        var_7 = var_6 - var_5;
        var_6 = var_5;
      }

      self setweaponammoclip(var_3, var_6);

      if(var_7 > 0) {
        var_8 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(var_3);
        scripts\mp\gametypes\br_weapons::br_ammo_give_type(self, var_8, var_7);
      }
    }

    scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(self);

    if(self.br_gulagguns.size < 2) {
      self giveweapon(getcompleteweaponname("iw8_fists_mp"));
    }

    foreach(var_11 in self.br_gulagoffhands) {
      var_12 = scripts\mp\equipment::getequipmentreffromweapon(var_11);

      if(isDefined(var_12) && isDefined(level.br_pickups.br_equipnametoscriptable[var_12])) {
        var_13 = level.br_pickups.br_equipnametoscriptable[var_12];
        scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(self, var_13, 1);
        var_4 = createheadicon(var_11);

        if(isDefined(self.br_gulagammo[var_4])) {
          var_14 = self.br_gulagammo[var_4];
          self setweaponammoclip(var_11, var_14);
        }
      }
    }

    if(isDefined(self.br_gulagguncurrent)) {
      self switchtoweaponimmediate(self.br_gulagguncurrent);
    }

    if(isDefined(self.executionref)) {
      scripts\cp_mp\execution::_giveexecution(self.executionref);
    }

    self.br_gulaggun = undefined;
    self.br_gulagammo = undefined;
    self.br_gulagoffhands = undefined;
    self.br_gulagguncurrent = undefined;
    return true;
  } else if(istrue(self.gulagloser)) {
    self.shouldhumanspawntags = 0;
  }

  return false;
}

function set_spawn_scoring_params_for_level() {
  if(istrue(self.set_shouldrespawn)) {
    var_0 = getdvarint("scr_br_fc_winner_loadout", -1);

    if(var_0 > -1) {
      self.pers["gamemodeLoadout"] = level.set_relic_thirdperson[var_0];
    } else {
      self.pers["gamemodeLoadout"] = level.deletescriptableinstanceaftertime;
    }

    self.class = "gamemode";
    self.prevweaponobj = undefined;
    var_1 = scripts\mp\class::loadout_getclassstruct();
    var_1 = scripts\mp\class::loadout_updateclass(var_1, "gamemode");
    scripts\mp\class::preloadandqueueclassstruct(var_1, 1, 1);
    scripts\mp\class::giveloadout(self.team, "gamemode", 0, 0);
    self givestartammo(var_1.loadoutprimaryobject);

    if(isDefined(var_1.loadoutsecondaryobject)) {
      self givestartammo(var_1.loadoutsecondaryobject);
    }

    scripts\mp\gametypes\br::scriptednode(self);
    scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
    scripts\mp\gametypes\br_weapons::delay_add_to_chopper_boss_drone_target_array();
    scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(self);
    self notify("ammo_update");
    thread scripts\mp\gametypes\br::defend_wave_2();

    if(isDefined(level.obit_activation) && level.obit_activation.ref_129da == 1) {
      scripts\mp\gametypes\br::disablearmorykiosk();
    }

    self.set_shouldrespawn = undefined;
    return true;
  }

  return false;
}

function popnextmatch(var_0) {
  var_1 = var_0.matches[0];
  var_0.matches = scripts\engine\utility::array_remove_index(var_0.matches, 0);
  return var_1;
}

function checkgulagusecount() {
  if(level.gulag.maxuses >= 0) {
    var_0 = self.gulaguses;

    if(!isDefined(var_0)) {
      var_0 = 0;
    }

    if(var_0 >= level.gulag.maxuses) {
      return false;
    }
  }

  return true;
}

function trygulagspawn() {
  if(!istrue(self.br_infilstarted) || !scripts\mp\flags::gameflag("prematch_done")) {
    return false;
  }

  if(istrue(self.gulag)) {
    return false;
  }

  if(scripts\mp\gametypes\br_public::hasrespawntoken() && !scripts\mp\gametypes\br_pickups::ref_12cb6()) {
    thread playergulagautowin("tryGulagSpawn", undefined, 1, 1);
    return true;
  }

  if(!ref_12517()) {
    return false;
  }

  if(scripts\mp\gametypes\br_public::hasgulagtoken()) {
    scripts\mp\gametypes\br_pickups::removegulagtoken();
  }

  thread initplayerjail(1);
  return true;
}

function ref_12517() {
  if(!istrue(self.br_infilstarted) || !scripts\mp\flags::gameflag("prematch_done")) {
    return false;
  }

  if(istrue(self.gulag)) {
    return false;
  }

  if(!istrue(level.usegulag)) {
    return false;
  }

  if(istrue(level.gulag.shutdown) && !ref_125e6()) {
    return false;
  }

  if(getdvarint("scr_br_all_assassin_version", 0)) {
    return false;
  }

  if(!checkgulagusecount() && !scripts\mp\gametypes\br_public::hasgulagtoken()) {
    return false;
  }

  return true;
}

function playergulaghud(var_0) {
  if(isDefined(var_0.fightover) && !var_0.fightover) {
    ref_1267a(var_0);
  }

  if(isDefined(var_0.fightover) && !var_0.fightover && isDefined(var_0.time) && var_0.time > 0) {
    var_1 = var_0.time;

    if(!istrue(var_0.overtime)) {
      var_2 = respawn_scriptible_carriable_wait();
      var_1 -= var_2;
    }

    self setclientomnvar("ui_br_gulag_match_end_time", gettime() + int(var_1 * 1000));
    return;
  }

  self setclientomnvar("ui_br_gulag_match_end_time", 0);
}

function updatematchtimerhud(var_0, var_1) {
  _updatematchtimerhudinternal(var_0.arenaplayers, var_1);
  _updatematchtimerhudinternal(var_0.jailedplayers, var_1);
}

function _updatematchtimerhudinternal(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }

    if(var_1 > 0) {
      var_3 setclientomnvar("ui_br_gulag_match_end_time", gettime() + int(var_1 * 1000));
      continue;
    }

    var_3 setclientomnvar("ui_br_gulag_match_end_time", 0);
  }
}

function updatematchqueuepositions(var_0) {
  var_1 = 2;

  while(var_1 <= level.gulag.maxplayers) {
    var_2 = [];

    foreach(var_4 in var_0.jailedplayers) {
      if(!isDefined(var_4)) {
        continue;
      }

      var_5 = 0;

      foreach(var_12, var_7 in var_2) {
        if(var_7.size >= var_1) {
          continue;
        }

        var_8 = 0;

        foreach(var_10 in var_7) {
          if(var_10.team == var_4.team) {
            var_8 = 1;
            break;
          }
        }

        if(!var_8) {
          var_5 = 1;
          var_4.gulagposition = var_12 + 1;
          var_2[var_2[var_12].size] = var_4;
          break;
        }
      }

      if(!var_5) {
        var_4.gulagposition = var_2.size + 1;
        var_2 = [var_4];
      }
    }

    var_0.matches = var_2;

    if(var_2.size <= level.gulag.maxqueue) {
      break;
    }

    var_1 += 2;
  }

  ref_13fc1(var_0);
}

function playerwatchdisconnect(var_0) {
  self endon("gulagLost");
  self endon("gulag_end");
  self waittill("death_or_disconnect");

  if(isDefined(self) && istrue(self.gulagarena)) {
    return;
  }

  if(isDefined(self)) {
    if(istrue(self.gulagarena)) {
      var_0.arenaplayers = scripts\engine\utility::array_remove(var_0.arenaplayers, self);
    } else if(istrue(self.jailed)) {
      var_0.jailedplayers = scripts\engine\utility::array_remove(var_0.jailedplayers, self);
    }

    playerdestroyhud(var_0);
  } else {
    var_0.jailedplayers = scripts\engine\utility::array_removeundefined(var_0.jailedplayers);
    var_0.arenaplayers = scripts\engine\utility::array_removeundefined(var_0.arenaplayers);
  }

  updatematchqueuepositions(var_0);
}

function playerdestroyhud(var_0) {
  self setclientomnvar("ui_br_gulag_match_end_time", 0);

  if(isDefined(var_0)) {
    ref_12526(var_0);
  }

  if(isDefined(self.gulagjailbreakhud)) {
    self.gulagjailbreakhud destroy();
  }

  self.set_relic_team_proximity = undefined;
}

function setplayervargulag(var_0) {
  if(isDefined(self.gulag) && self.gulag == var_0) {
    return;
  }

  self.gulag = var_0;
  level notify("update_circle_hide");
}

function setplayervargulagarena(var_0, var_1) {
  if(isDefined(self.gulagarena) && self.gulagarena == var_0) {
    return;
  }

  if(!istrue(var_1)) {
    ref_131a1(var_0);
  }

  self.gulagarena = var_0;
  level notify("update_circle_hide");
}

function ref_131a1(var_0) {
  if(istrue(var_0)) {
    self.game_extrainfo |= 256;
    return;
  }

  self.game_extrainfo &= ~256;
}

function ref_131aa(var_0) {
  if(isDefined(self.jailed) && self.jailed == var_0) {
    return;
  }

  ref_131a2(var_0);
  self.jailed = var_0;
  level notify("update_circle_hide");
}

function ref_131a2(var_0) {
  if(var_0) {
    self.game_extrainfo |= 128;
    return;
  }

  self.game_extrainfo &= ~128;
}

function ref_1319f(var_0) {
  if(var_0.set_relic_oneclip > 7) {
    return;
  }

  var_1 = 3;
  var_2 = 3;
  var_3 = int(pow(2, var_1)) - 1;
  var_4 = (var_0.set_relic_oneclip &var_3) << var_2;
  var_5 = ~(var_3 << var_2);
  var_6 = self.game_extrainfo;
  var_7 = var_6 &var_5;
  var_8 = var_7 + var_4;
  self.game_extrainfo = var_8;
}

function startbetting(var_0, var_1) {
  if(!level.gulag.betting) {
    return undefined;
  }

  var_2 = spawnStruct();
  var_2.fighters = var_1;
  var_2.bets = [];
  var_2.bettingopen = 1;
  thread show_betting_to_players(var_2);
  return var_2;
}

function show_betting_to_players(var_0) {
  self endon("end_betting");

  for(;;) {
    var_1 = getbettingplayers(var_0, self);

    foreach(var_3 in var_1) {
      if(isbot(var_3)) {
        continue;
      }

      if(isDefined(self.bets[var_3.guid])) {
        continue;
      }

      thread showbettinghud(var_0, var_3);
    }

    var_0 waittill("player_added_to_jail");
  }
}

function showbettinghud(var_0, var_1) {
  self endon("end_betting");
  var_2 = spawnStruct();
  var_2.owner = var_1;
  self.bets[var_1.guid] = var_2;
  var_2.ref_125f9 = 0;
  var_2.ref_12652 = 1;
  var_3 = 0;
  var_4 = 50;
  var_2.hudavailable = var_1 scripts\mp\hud_util::createfontstring("default", 1.2);
  var_2.hudavailable scripts\mp\hud_util::setpoint("TOP", "TOP", var_3, var_4);
  var_2.hudavailable.label = &"MP_GULAG_BETTING/AVAILABLE";
  var_2.hudavailable scripts\mp\hud::fontpulseinit();
  var_2.spawn_truck_techo = var_1 scripts\mp\hud_util::createfontstring("default", 1.2);
  var_2.spawn_truck_techo scripts\mp\hud_util::setpoint("TOP", "TOP", var_3, var_4 - 15);
  var_2.spawn_truck_techo.label = &"MP_GULAG_BETTING/BET_CLEAR";
  var_2.spawn_truck_techo.alpha = 0;
  var_5 = -90;
  var_6 = 65;
  var_2.spawn_trap_room_ent = var_1 scripts\mp\hud_util::createfontstring("default", 1.2);
  var_2.spawn_trap_room_ent scripts\mp\hud_util::setpoint("TOP", "TOP", var_5, var_6);
  var_2.spawn_trap_room_ent.label = &"MP_GULAG_BETTING/BET_INCREASE_LEFT";
  var_2.spawn_trap_room_ent.alpha = 1;
  var_2.spawnboardroom_miniguns = var_1 scripts\mp\hud_util::createfontstring("default", 1.25);
  var_2.spawnboardroom_miniguns scripts\mp\hud_util::setpoint("TOP", "TOP", var_5 - 20, var_6 + 12);
  var_2.spawnboardroom_miniguns.label = &"MP_GULAG_BETTING/ODDS_PERCENT";
  var_2.spawnboardroom_miniguns setvalue(randomint(60) + 20);
  var_2.spawnboardroom_miniguns.alpha = 1;
  var_2.spawnboardroomblueprintweapons = var_1 scripts\mp\hud_util::createfontstring("default", 1.25);
  var_2.spawnboardroomblueprintweapons scripts\mp\hud_util::setpoint("TOP", "TOP", var_5 + 20, var_6 + 12);
  var_2.spawnboardroomblueprintweapons.label = &"MP_GULAG_BETTING/ODDS_RATIO";
  var_2.spawnboardroomblueprintweapons setvalue(randomint(10) + 1);
  var_2.spawnboardroomblueprintweapons.alpha = 1;
  var_2.spawnchoppers = var_1 scripts\mp\hud_util::createfontstring("default", 1.5);
  var_2.spawnchoppers scripts\mp\hud_util::setpoint("TOP", "TOP", var_5, var_6 + 25);
  var_2.spawnchoppers.label = &"";

  if(isDefined(self.fighters[var_2.ref_125f9])) {
    var_2.spawnchoppers setplayernamestring(self.fighters[var_2.ref_125f9]);
  }

  var_2.spawnchoppers.alpha = 1;
  var_2.spawn_techo_lmgs = var_1 scripts\mp\hud_util::createfontstring("default", 1.5);
  var_2.spawn_techo_lmgs scripts\mp\hud_util::setpoint("TOP", "TOP", var_5, var_6 + 40);
  var_2.spawn_techo_lmgs.label = &"MP_GULAG_BETTING/CURRENT_BET";
  var_2.spawn_techo_lmgs.alpha = 0;
  var_2.spawn_techo_lmgs scripts\mp\hud::fontpulseinit();
  var_7 = 90;
  var_8 = 65;
  var_2.spawn_truck_group_on_proximity = var_1 scripts\mp\hud_util::createfontstring("default", 1.2);
  var_2.spawn_truck_group_on_proximity scripts\mp\hud_util::setpoint("TOP", "TOP", var_7, var_8);
  var_2.spawn_truck_group_on_proximity.label = &"MP_GULAG_BETTING/BET_INCREASE_RIGHT";
  var_2.spawn_truck_group_on_proximity.alpha = 1;
  var_2.spawnboardroom_specialist = var_1 scripts\mp\hud_util::createfontstring("default", 1.25);
  var_2.spawnboardroom_specialist scripts\mp\hud_util::setpoint("TOP", "TOP", var_7 - 20, var_8 + 12);
  var_2.spawnboardroom_specialist.label = &"MP_GULAG_BETTING/ODDS_PERCENT";
  var_2.spawnboardroom_specialist setvalue(randomint(60) + 20);
  var_2.spawnboardroom_specialist.alpha = 1;
  var_2.spawnbunkerloot = var_1 scripts\mp\hud_util::createfontstring("default", 1.25);
  var_2.spawnbunkerloot scripts\mp\hud_util::setpoint("TOP", "TOP", var_7 + 20, var_8 + 12);
  var_2.spawnbunkerloot.label = &"MP_GULAG_BETTING/ODDS_RATIO";
  var_2.spawnbunkerloot setvalue(randomint(10) + 1);
  var_2.spawnbunkerloot.alpha = 1;
  var_2.spawnclientdevtest = var_1 scripts\mp\hud_util::createfontstring("default", 1.5);
  var_2.spawnclientdevtest scripts\mp\hud_util::setpoint("TOP", "TOP", var_7, var_8 + 25);
  var_2.spawnclientdevtest.label = &"";

  if(isDefined(self.fighters[var_2.ref_12652])) {
    var_2.spawnclientdevtest setplayernamestring(self.fighters[var_2.ref_12652]);
  }

  var_2.spawnclientdevtest.alpha = 1;
  var_2.spawn_techo_turret = var_1 scripts\mp\hud_util::createfontstring("default", 1.5);
  var_2.spawn_techo_turret scripts\mp\hud_util::setpoint("TOP", "TOP", var_7, var_8 + 40);
  var_2.spawn_techo_turret.label = &"MP_GULAG_BETTING/CURRENT_BET";
  var_2.spawn_techo_turret.alpha = 0;
  var_2.spawn_techo_turret scripts\mp\hud::fontpulseinit();
  var_2.playerbeton = -1;
  var_2.amount = 0;
  updatebethud(var_2);
  thread watchbetplaced(var_2);
  thread watchbetclear(var_2);
}

function watchbetclear(var_0) {
  self endon("end_betting");
  var_0.owner endon("disconnect");
  var_1 = "betClear";
  thread notifyonplayercommandbetting(var_0.owner, var_1, "+special");
  thread notifyonplayercommandbetting(var_0.owner, var_1, "+usereload");

  for(;;) {
    var_0.owner waittill(var_1);

    if(var_0.playerbeton == -1) {
      continue;
    }

    var_0.playerbeton = -1;
    var_0.amount = 0;
    updatebethud(var_0);
  }
}

function watchbetplaced(var_0) {
  self endon("end_betting");
  var_0.owner endon("disconnect");
  var_1 = "betPlacedLeft";
  var_2 = "betPlacedRight";
  thread notifyonplayercommandbetting(var_0.owner, var_1, "+smoke");
  thread notifyonplayercommandbetting(var_0.owner, var_2, "+reload");
  thread notifyonplayercommandbetting(var_0.owner, var_2, "+frag");

  for(;;) {
    var_3 = var_0.owner scripts\engine\utility::ref_143ad(var_1, var_2);
    var_4 = -1;

    if(var_3 == var_1) {
      var_4 = var_0.ref_125f9;
    } else if(var_3 == var_2) {
      var_4 = var_0.ref_12652;
    }

    if(var_0.playerbeton == var_4) {
      var_5 = var_0.amount + 1;
    } else {
      var_5 = 1;
    }

    if(var_5 > var_0.owner.plundercount) {
      betchangefail(var_0);
      continue;
    }

    var_0.amount = var_5;
    var_0.playerbeton = var_4;
    updatebethud(var_0);
  }
}

function notifyonplayercommandbetting(var_0, var_1, var_2) {
  var_0 notifyonplayercommand(var_1, var_2);
  self waittill("end_betting");

  if(isDefined(var_0)) {
    var_0 notifyonplayercommandremove(var_1, var_2);
    return;
  }
}

function betchangefail(var_0) {
  var_0.owner playlocalsound("br_pickup_deny");
  var_0.hudavailable thread scripts\mp\hud::fontpulse(var_0.owner);
}

function updatebethud(var_0) {
  var_1 = 100;
  var_0.hudavailable setvalue((var_0.owner.plundercount - var_0.amount) * var_1);

  if(var_0.playerbeton == -1) {
    var_0.spawn_trap_room_ent.label = &"MP_GULAG_BETTING/BET_CHANGE_LEFT";
    var_0.spawn_truck_group_on_proximity.label = &"MP_GULAG_BETTING/BET_CHANGE_RIGHT";
    var_0.spawn_truck_techo.alpha = 0;
    var_0.spawn_techo_lmgs setvalue(0);
    var_0.spawn_techo_turret setvalue(0);
    var_0.spawn_techo_lmgs.alpha = 0;
    var_0.spawn_techo_turret.alpha = 0;
    return;
  }

  if(var_0.playerbeton == var_0.ref_125f9) {
    var_0.spawn_trap_room_ent.label = &"MP_GULAG_BETTING/BET_INCREASE_LEFT";
    var_0.spawn_truck_group_on_proximity.label = &"MP_GULAG_BETTING/BET_CHANGE_RIGHT";
    var_0.spawn_truck_techo.alpha = 1;
    var_0.spawn_techo_lmgs setvalue(var_0.amount * var_1);
    var_0.spawn_techo_lmgs.alpha = 1;
    var_0.spawn_techo_turret.alpha = 0;
    return;
  }

  if(var_0.playerbeton == var_0.ref_12652) {
    var_0.spawn_trap_room_ent.label = &"MP_GULAG_BETTING/BET_CHANGE_LEFT";
    var_0.spawn_truck_group_on_proximity.label = &"MP_GULAG_BETTING/BET_INCREASE_RIGHT";
    var_0.spawn_truck_techo.alpha = 1;
    var_0.spawn_techo_turret setvalue(var_0.amount * var_1);
    var_0.spawn_techo_turret.alpha = 1;
    var_0.spawn_techo_lmgs.alpha = 0;
    return;
  }
}

function cleanupbethud(var_0, var_1) {
  var_0 notify("cleanUpBetHud");

  if(isDefined(var_1)) {
    var_0 endon("cleanUpBetHud");
    wait var_1;
  }

  var_2 = [var_0.spawn_trap_room_ent, var_0.spawn_truck_group_on_proximity, var_0.spawn_techo_lmgs, var_0.spawn_techo_turret, var_0.spawnchoppers, var_0.spawnclientdevtest, var_0.spawnboardroom_miniguns, var_0.spawnboardroomblueprintweapons, var_0.spawnboardroom_specialist, var_0.spawnbunkerloot, var_0.hudavailable, var_0.spawn_truck_techo];

  foreach(var_4 in var_2) {
    if(isDefined(var_4)) {
      var_4 destroy();
    }
  }
}

function watchbetbutton(var_0, var_1, var_2, var_3) {
  self endon("end_betting");

  for(;;) {
    var_1 waittill(var_2);
    var_0 notify("betPlaced", var_3);
  }
}

function endbetting(var_0, var_1) {
  if(!isDefined(var_1) || !istrue(var_1.bettingopen)) {
    return;
  }

  var_1 notify("end_betting");
  var_1.bettingopen = 0;

  foreach(var_3 in var_1.bets) {
    var_4 = [var_3.spawn_truck_techo, var_3.hudavailable, var_3.spawnboardroom_specialist, var_3.spawnboardroom_miniguns, var_3.spawnbunkerloot, var_3.spawnboardroomblueprintweapons, var_3.spawn_trap_room_ent, var_3.spawn_truck_group_on_proximity];

    if(var_3.playerbeton != -1) {
      if(var_3.playerbeton == var_3.ref_125f9) {
        var_4 = var_3.spawnclientdevtest;
        var_4 = var_3.spawn_truck_group_on_proximity;
        var_4 = var_3.spawn_techo_turret;
      } else if(var_3.playerbeton == var_3.ref_12652) {
        var_4 = var_3.spawnchoppers;
        var_4 = var_3.spawn_trap_room_ent;
        var_4 = var_3.spawn_techo_lmgs;
      }
    } else {
      cleanupbethud(var_3, 0);
    }

    foreach(var_6 in var_4) {
      if(isDefined(var_6)) {
        var_6 destroy();
      }
    }
  }

  updateoutlines(var_0);
}

function payoutremainingbets(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }

  var_2 = -1;

  if(isDefined(var_0)) {
    var_2 = var_0.fighterindex;
  }

  foreach(var_4 in var_1.bets) {
    if(var_4.playerbeton != -1 && isDefined(var_4.owner) && !istrue(var_4.paidout)) {
      var_5 = var_4.playerbeton == var_2;
      _completebet(var_1, var_4, var_5);
    }

    thread cleanupbethud(var_4, 2.5);
  }
}

function _completebet(var_0, var_1, var_2) {
  var_3 = (0, 1, 0);
  var_4 = (1, 0, 0);
  var_1.paidout = 1;

  if(var_2) {
    var_1.owner scripts\mp\gametypes\br_plunder::playersetplundercount(var_1.owner.plundercount + var_1.amount);

    if(var_1.playerbeton == var_1.ref_125f9) {
      var_1.spawnchoppers.color = var_3;
      var_1.spawnchoppers.label = &"MP_GULAG_BETTING/FIGHER_WINNER";
      var_1.spawn_techo_lmgs.color = var_3;
      var_1.spawn_techo_lmgs.label = &"MP_GULAG_BETTING/AMOUNT_WON";
      var_1.owner playlocalsound("ammo_crate_use");
      var_1.spawn_techo_lmgs thread scripts\mp\hud::fontpulse(var_1.owner);
    } else if(var_1.playerbeton == var_1.ref_12652) {
      var_1.spawnclientdevtest.color = var_3;
      var_1.spawnclientdevtest.label = &"MP_GULAG_BETTING/FIGHER_WINNER";
      var_1.spawn_techo_turret.color = var_3;
      var_1.spawn_techo_turret.label = &"MP_GULAG_BETTING/AMOUNT_WON";
      var_1.owner playlocalsound("ammo_crate_use");
      var_1.spawn_techo_turret thread scripts\mp\hud::fontpulse(var_1.owner);
    }
  } else {
    if(isalive(var_1.owner)) {
      var_5 = var_1.owner.plundercount - var_1.amount;
      var_5 = int(max(0, var_5));
      var_1.owner scripts\mp\gametypes\br_plunder::playersetplundercount(var_5);
    }

    if(var_1.playerbeton == var_1.ref_125f9) {
      var_1.spawnchoppers.color = var_4;
      var_1.spawnchoppers.label = &"MP_GULAG_BETTING/FIGHER_LOSER";
      var_1.spawn_techo_lmgs.color = var_4;
      var_1.spawn_techo_lmgs.label = &"MP_GULAG_BETTING/AMOUNT_LOST";
      var_1.spawn_techo_lmgs thread scripts\mp\hud::fontpulse(var_1.owner);
    } else if(var_1.playerbeton == var_1.ref_12652) {
      var_1.spawnclientdevtest.color = var_4;
      var_1.spawnclientdevtest.label = &"MP_GULAG_BETTING/FIGHER_LOSER";
      var_1.spawn_techo_turret.color = var_4;
      var_1.spawn_techo_turret.label = &"MP_GULAG_BETTING/AMOUNT_LOST";
      var_1.spawn_techo_turret thread scripts\mp\hud::fontpulse(var_1.owner);
    }
  }

  var_6 = var_0.fighters[var_1.playerbeton];

  if(isDefined(var_6)) {
    var_6 hudoutlinedisableforclient(var_1.owner);
    return;
  }
}

function getbettingplayers(var_0, var_1) {
  var_2 = var_0.jailedplayers;

  if(level.gulag.betting > 1) {
    foreach(var_4 in var_1.fighters) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function payoutbet(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }

  foreach(var_4 in var_0.bets) {
    if(var_4.playerbeton == var_1.fighterindex && isDefined(var_4.owner) && !istrue(var_4.paidout)) {
      _completebet(var_0, var_4, var_2);
      thread cleanupbethud(var_4, 2.5);
    }
  }
}

function rock_used(var_0) {
  var_1 = self.arena;
  var_0 scripts\engine\utility::waittill_notify_or_timeout("missile_stuck", 4);
  wait 2;

  if(isDefined(var_0)) {
    var_0 delete();
  }

  if(istrue(level.usegulag) && level.gulag.ref_1407f) {
    spawnrock(var_1);
    return;
  }
}

function spawnrocks(var_0) {
  var_0.rocks = getentitylessscriptablearrayinradius(var_0.target, "targetname");

  if(var_0.rocks.size == 0 || !level.gulag.ref_1407f) {
    for(var_1 = 0; var_1 < var_0.rocks.size; var_1++) {
      var_2 = var_0.rocks[var_1];
      var_2 setscriptablepartstate("brloot_rock", "hidden");
    }

    return;
  }

  var_3 = 20;

  if(var_2.rocks.size < var_3) {
    var_3 = var_2.rocks.size;
  }

  var_2.rocks = scripts\engine\utility::array_randomize(var_2.rocks);
  var_2.rockcounter = var_3;
  var_4 = getdvarint("scr_br_fc_rocks", 1) == 0;

  for(var_1 = 0; var_1 < var_2.rocks.size; var_1++) {
    var_2 = var_2.rocks[var_1];
    var_2.arena = var_2;

    if(var_1 >= var_3 || var_4) {
      var_2 setscriptablepartstate("brloot_rock", "hidden");
    }
  }
}

function rockused(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0) || !isDefined(var_3)) {
    return;
  }

  var_5 = getcompleteweaponname("rock_mp");

  if(var_3 hasweapon(var_5) && var_3 getammocount(var_5) > 0) {
    return;
  }

  var_0 setscriptablepartstate("brloot_rock", "hidden");
  var_3 thread scripts\mp\gametypes\br_pickups::playerplaypickupanim();
  var_3 scripts\mp\equipment::giveequipment("equip_rock", "primary");
  var_3 playlocalsound("br_rock_pickup");
}

function spawnrock(var_0) {
  if(istrue(var_0.shutdown) || var_0.rocks.size == 0) {
    return;
  }

  var_1 = var_0.rocks[var_0.rockcounter];
  var_1 setscriptablepartstate("brloot_rock", "visible");
  var_0.rockcounter++;

  if(var_0.rockcounter >= var_0.rocks.size) {
    var_0.rockcounter = 0;
    return;
  }
}

function playertakeawayrock(var_0) {
  var_1 = getcompleteweaponname("rock_mp");

  if(self hasweapon(var_1)) {
    self takeweapon(var_1);
    self clearaccessory();

    if(level.gulag.ref_1407f) {
      spawnrock(var_0);
      return;
    }

    return;
  }
}

function ref_126f3(var_0) {
  var_1 = self;

  if(!isDefined(level.pickup_truck_initdamage)) {
    return;
  }

  if(isDefined(level.br_circle.circleindex)) {
    var_2 = level.br_circle.circleindex + 1;

    if(var_2 > level.phase_five_combat) {
      return;
    }
  }

  var_3 = 0;

  if(isDefined(level.vehicle.instances["veh_a10fd"])) {
    var_3 += level.vehicle.instances["veh_a10fd"].size;
  }

  if(isDefined(level.vehicle.instances["veh_bt"])) {
    var_3 += level.vehicle.instances["veh_bt"].size;
  }

  if(var_3 >= level.pickup_truck_initdamage) {
    return;
  }

  if(istrue(var_1.ref_145bf)) {
    return;
  }

  var_4 = "undefined";

  if(isDefined(var_1.currentweapon)) {
    var_4 = var_1.currentweapon.basename;
  }

  var_5 = "undefined";

  if(isDefined(var_1.name)) {
    var_5 = var_1.name;
  }

  if(level.ph_setfinalkillcamwinner > 0 && randomfloat(1) < level.ph_setfinalkillcamwinner) {
    logstring("[FD] Respawning in fd: success - token used: " + var_0 + ", for player: " + var_5 + " with weapon: " + var_4);
    var_1.ref_12c9e = var_0;
    var_1.ref_145bf = 1;
    return;
  }

  logstring("[FD] Respawning in fd: fail - token used: undefined, for player: " + var_5 + " with weapon: " + var_4);
  var_1.ref_12c9e = undefined;
  var_1.ref_145bf = undefined;
}

function ref_1268c() {
  thread gulagfadefromblack(3);

  if(isDefined(level.pilot_tag)) {
    var_0 = [[level.pilot_tag]]();
  } else {
    var_0 = scripts\mp\gametypes\br_circle::risk_modifyflagstieronrespawn(0.9, 0.95);
  }

  var_1 = level.br_circle.circleindex + 1;

  if(!isDefined(level.br_level.default_class_chosen[var_1])) {
    var_1 = level.br_circle.circleindex;
  }

  var_2 = vectortoyaw(level.br_level.default_class_chosen[var_1] - var_0);
  var_3 = spawnStruct();
  var_3.origin = (var_0[0], var_0[1], 11500);
  var_3.angles = (0, var_2, 0);
  var_3.cannotbesuspended = 1;
  var_4 = spawnStruct();

  if(isDefined(self.ref_12c9f)) {
    var_5 = self.ref_12c9f;
  } else {
    var_5 = "veh_a10fd";

    if(randomfloat(1) > level.ph_endgame) {
      var_5 = "veh_bt";
    }
  }

  var_4.targetname = var_5;

  switch (var_5) {
    case "veh_bt":
      var_4.modelname = "veh_s4_mil_air_bomber_wz";
      var_4.vehicletype = "bt_mp";
      var_6 = _calloutmarkerping_handleluinotify_mappingdeletemarker::create_mp_version_of_vehicle(var_4, var_5);
      break;
    case "veh_a10fd":
      var_5.modelname = "veh_s4_mil_air_dalpha_wz";
      var_5.vehicletype = "a10_warthog_fd";
      var_6 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gametype_set_role(var_5, var_5);
      break;
    default:
      return;
  }

  thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_6, "pilot", self);
}

function gettangentoncirclefrompoint(var_0, var_1, var_2) {
  var_3 = var_2[0] - var_0[0];
  var_4 = var_2[1] - var_0[1];
  var_5 = var_1;
  var_6 = var_3 * var_3;
  var_7 = var_4 * var_4;
  var_8 = var_5 * var_5;
  var_9 = var_6 + var_7 - var_8;
  var_10 = undefined;
  var_11 = 1;

  if(var_9 > 0) {
    var_12 = (var_8 * var_3 - var_5 * var_4 * sqrt(var_6 + var_7 - var_8)) / (var_6 + var_7);
    var_13 = (var_8 * var_4 + var_5 * var_3 * sqrt(var_6 + var_7 - var_8)) / (var_6 + var_7);
    var_10 = (var_12, var_13, var_2[2]) + (var_0[0], var_0[1], 0);
  } else {
    var_14 = vectorNormalize((var_3, var_4, 0));
    var_15 = var_0 + var_14 * var_1;
    var_10 = (var_15[0], var_15[1], var_2[2]);
    var_11 = 0;
  }

  return [var_10, var_11];
}

function spawnac130() {
  if(!istrue(level.gulag.planerespawn)) {
    return;
  }

  level waittill("prematch_started");

  if(!istrue(level.br_infils_disabled)) {
    wait 10;
  }

  var_0 = undefined;
  var_1 = undefined;

  if(isDefined(level.br_ac130)) {
    var_0 = level.br_ac130.startpt;
  } else {
    var_2 = scripts\mp\gametypes\br_c130::createtestc130path();
    var_0 = var_2.startpt;
  }

  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
    var_1 = level.br_circle.safecircleent.origin[2];
  } else {
    var_1 = level.br_level.br_circleradii[0];
  }

  var_1 -= 100;
  var_3 = gettangentoncirclefrompoint(level.br_level.br_mapcenter, var_1, var_0);
  var_4 = var_3[0];
  var_5 = var_3[1];
  var_3 = undefined;
  var_6 = 0;
  var_7 = 0;

  if(var_5) {
    var_6 = distance(var_0, var_4);
    var_7 = var_6 / scripts\mp\gametypes\br_c130::getc130speed();
  }

  var_8 = (level.br_level.br_mapcenter[0], level.br_level.br_mapcenter[1], var_0[2]);
  level.gulag.ac130linker = spawn("script_model", var_8);
  level.gulag.ac130linker setModel("tag_origin");
  level.gulag.ac130linker.radius = var_1;
  level.gulag.ac130 = scripts\mp\gametypes\br_c130::gunship_spawn(var_0, var_4, var_7, 0, &ac130handlemovement);
  thread ac130setupanim();
  level.gulag.ac130.riders = [];

  if(var_7 <= 0) {
    var_9 = var_4 - level.br_level.br_mapcenter;
    var_10 = vectorNormalize((var_9[0], var_9[1], 0));
    var_11 = vectortoangles(var_10);
    level.gulag.ac130 unlink();
    level.gulag.ac130.angles = (0, var_11[1] + 90, 0);
    level.gulag.ac130.origin = var_4;
    thread ac130linkandspin();
    return;
  }
}

function ac130setupanim() {
  var_0 = spawnStruct();
  self.animstruct = var_0;
  var_0.movingc130 = self;
  scripts\mp\gametypes\br_infils::spawnplayerpositionparentent(var_0, self);
  scripts\mp\gametypes\br_infils::spawnplayerpositionent(var_0, "j_prop_1");
  scripts\mp\gametypes\br_infils::playac130infilloopanims(var_0);
}

function ac130handlemovement(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self playLoopSound("br_ac130_lp");

  if(var_1 > 0) {
    self moveTo(var_0, var_1, 0, 0);
    wait var_1;
  }

  thread ac130linkandspin();
}

function ac130linkandspin() {
  self notify("ac130LinkAndSpin");
  self endon("ac130LinkAndSpin");
  level.gulag.ac130linker endon("death");
  var_0 = 6.28318;
  var_1 = scripts\mp\gametypes\br_c130::getc130speed();
  var_2 = level.gulag.ac130linker.radius;
  var_3 = var_0 * var_2 / var_1;
  self linkTo(level.gulag.ac130linker, "tag_origin");

  if(var_3 <= 0) {
    return;
  }

  for(;;) {
    level.gulag.ac130linker rotateYaw(360, var_3);
    wait var_3;
  }
}

function waittillallarenasshutdown() {
  var_0 = level.gulag.arenas.size;
  jumpiftrue(istrue(level.gulag.multiarena)) LOC_00000021;
  var_0 = 1;

  for(;;) {
    var_1 = 0;

    for(var_2 = 0; var_2 < var_0; var_2++) {
      var_3 = level.gulag.arenas[var_2];

      if(!istrue(var_3.shutdown)) {
        var_1 = 1;
        break;
      }
    }

    if(!var_1) {
      return;
    }

    waitframe();
  }
}

function makeac130flyaway() {
  if(!istrue(level.gulag.planerespawn)) {
    return;
  }

  var_0 = gettime();
  waittillallarenasshutdown();
  var_1 = gettime();
  wait getdvarint("scr_br_fc_respawn_wait", 15);
  waittillframeend();

  foreach(var_3 in level.gulag.ac130.riders) {
    if(isDefined(var_3)) {
      var_3.jumptype = "solo";
      var_3 notify("halo_kick_c130");
    }
  }

  while(level.gulag.ac130.riders.size > 0) {
    waitframe();
  }

  var_5 = level.gulag.ac130.origin;
  var_6 = anglesToForward(level.gulag.ac130.angles);
  var_7 = level.br_level.br_circleradii[0] * 2;
  var_8 = var_5 + var_6 * var_7;
  var_8 += var_6 * scripts\mp\gametypes\br_c130::getc130speed();
  var_9 = distance(var_5, var_8);
  var_10 = var_9 / scripts\mp\gametypes\br_c130::getc130speed();
  level.gulag.ac130 notify("ac130LinkAndSpin");
  level.gulag.ac130 unlink();
  level.gulag.ac130 moveTo(var_8, var_10, 0, 0);
  wait var_10;
  scripts\mp\gametypes\br_public::cleanac130struct(level.gulag.ac130.animstruct);

  if(isDefined(level.gulag.ac130)) {
    level.gulag.ac130 delete();
  }

  if(isDefined(level.gulag.ac130linker)) {
    level.gulag.ac130linker delete();
    return;
  }
}

function transitioncircle(var_0, var_1) {
  if(!istrue(level.gulag.planerespawn)) {
    return;
  }

  if(!isDefined(level.gulag.ac130) || !isDefined(level.gulag.ac130linker)) {
    return;
  }

  var_2 = (level.br_circle.safecircleent.origin[0], level.br_circle.safecircleent.origin[1], level.gulag.ac130linker.origin[2]);
  var_0 -= 100;

  if(level.gulag.ac130linker.radius != var_0) {
    var_3 = vectorNormalize(level.gulag.ac130linker.origin - level.gulag.ac130.origin);
    var_4 = level.gulag.ac130.origin + var_3 * var_0;
    level.gulag.ac130 unlink();
    level.gulag.ac130linker.origin = var_4;
    level.gulag.ac130linker.radius = var_0;
    level.gulag.ac130linker dontinterpolate();
    thread ac130linkandspin();
  }

  level.gulag.ac130linker moveTo(var_2, var_1);
  wait var_1;
}

function playersetupac130() {
  self.infilanimindex = 1;
  self.isjumpmaster = 0;
  scripts\mp\gametypes\br_infils::playerlinktopositionent(level.gulag.ac130.animstruct);
  thread scripts\mp\gametypes\br_infils::playerplayinfilloopanim(level.gulag.ac130.animstruct);
  thread playerputinc130(level.gulag.ac130);
  scripts\mp\gametypes\br_infils::playersetupcontrolsforinfil(1);
  thread playerac130cleanup();
  thread playerautodeployaftertime();
  thread playerspawnprotectionac130();
  level.gulag.ac130.riders[level.gulag.ac130.riders.size] = self;
}

function playerputinc130(var_0) {
  self.angles = var_0.angles;
  thread listenjump(var_0);
  thread scripts\mp\gametypes\br_c130::listenkick(var_0, 0);
  scripts\mp\utility\game::ref_131a3(self, 1);
  self.br_infil_type = "c130";
  thread scripts\mp\gametypes\br_public::orbitcam(var_0);
}

function listenjump(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("cancel_c130");
  self endon("br_jump");
  self.redeployenabled = 0;
  scripts\engine\utility::waittill_either("halo_jump_c130", "halo_jump_solo_c130");
  self.jumptype = "solo";
  thread scripts\mp\gametypes\br_c130::leaveplane(var_0, 0, self getplayerangles(), 0);
}

function playerspawnprotectionac130() {
  self endon("death_or_disconnect");
  self.plotarmor = 1;
  scripts\mp\gametypes\br_c130::setplayervarinrespawnc130(1);
  waittillplayerdoneskydivingac130(self);
  self.plotarmor = undefined;
  scripts\mp\gametypes\br_c130::setplayervarinrespawnc130(0);
}

function waittillplayerdoneskydivingac130(var_0) {
  var_0 endon("timeout_gulag_ac130");
  thread _waittillplayerdoneskydivingac130timeout(var_0);
  var_0 waittill("infil_jump_done");

  while(!var_0 isparachuting() && !var_0 isonground()) {
    waitframe();
  }
}

function _waittillplayerdoneskydivingac130timeout(var_0) {
  var_0 endon("death_or_disconnect");
  var_0 scripts\engine\utility::ref_143ba(getdvarint("scr_br_fc_respawn_wait", 15), "halo_kick_c130", "halo_jump_solo_c130");
  wait 15;
  var_0 notify("timeout_gulag_ac130");
}

function playerautodeployaftertime() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("cancel_c130");
  self endon("br_jump");
  wait getdvarint("scr_br_fc_respawn_wait", 15);
  self.jumptype = "solo";
  self notify("halo_kick_c130");
}

function playerac130cleanup() {
  level endon("game_ended");
  scripts\engine\utility::ref_143a7("disconnect", "death", "cancel_c130", "infil_jump_done");

  if(!isDefined(level.gulag.ac130.riders)) {
    return;
  }

  if(isDefined(self)) {
    level.gulag.ac130.riders = scripts\engine\utility::array_remove(level.gulag.ac130.riders, self);
    return;
  }

  level.gulag.ac130.riders = scripts\engine\utility::array_removeundefined(level.gulag.ac130.riders);
}

function playergulagautowin(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;
  level endon("game_ended");
  var_5 endon("disconnect");
  var_5 notify("gulag_auto_win");

  if(istrue(var_5.respawningfromtoken)) {
    return;
  }

  var_6 = ref_125c7(var_5, var_1, var_2, var_4, undefined, var_0);
  var_7 = var_6[0];
  var_8 = var_6[1];
  var_6 = undefined;
  var_5.respawningfromtoken = 1;
  var_9 = ref_126e8(var_5);
  var_10 = scripts\mp\gametypes\br_public::relic_nuketimer_gettimeformission() / 1000;
  var_11 = ref_125be(var_5, 0, var_10);
  var_12 = ref_1263e(var_5, var_11);
  self.forcespawnorigin = var_12;
  var_13 = scripts\mp\gametypes\br_gametypes::ref_12e05("playerGulagAutoWinWait", var_1, var_2);

  if(!istrue(var_13)) {
    var_14 = 1;
    wait var_14;
  }

  if(var_9) {
    var_5 scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  }

  var_15 = 1;
  gulagfadetoblack(var_5, 1);
  wait var_15;
  var_5 scripts\mp\hud_message::heartbeat_sensor_pick_up_monitor();
  var_5 scripts\mp\playerlogic::spawnplayer(undefined, 0);
  var_5 scripts\cp_mp\execution::_clearexecution();
  var_5 scripts\mp\gametypes\br_pickups::initplayer();
  var_5 scripts\mp\gametypes\br_spectate::ref_1252a();
  var_5.respawningfromtoken = undefined;

  if(!isDefined(var_1) && !istrue(var_3)) {
    thread ref_13dcb(var_5);
  }

  var_5.plotarmor = undefined;
  var_5.c130 = undefined;

  if(!isDefined(var_5.ref_145bf)) {
    ref_126f3(var_5, var_2);
  }

  gulagwinnerrespawn(var_5, 1, var_8, var_11, 1, var_12, undefined, var_7, var_4, undefined, undefined, var_2);
}

function ref_125c7(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;
  var_6 = var_5;
  var_7 = "token";

  if(isDefined(var_0)) {
    var_8 = istrue(var_5.delay_enter_combat_after_investigating_grenade) && !isalive(var_5) && istrue(var_5.ref_14439);
    var_6 = var_0;
    var_7 = "token_sponsored";

    if(!istrue(var_3)) {
      if(istrue(var_1)) {
        var_9 = 6;
      } else {
        var_9 = 10;
      }

      thread ref_13dcb(var_6);
    }
  }

  if(isDefined(var_1) || istrue(var_3)) {
    var_6 scripts\mp\playerlogic::addtoalivecount(var_5);
    scripts\mp\gametypes\br::ref_13f21(var_6, var_5);
  }

  scripts\mp\gametypes\br_analytics::destroyawardlaunchonly(var_6, var_8);
  scripts\mp\gametypes\br_analytics::devspectatetesthost(self, int(isDefined(var_1)));

  if(istrue(var_7.hasrespawntoken)) {
    var_7 scripts\mp\gametypes\br_pickups::removerespawntoken();
  }

  return [var_7, var_8];
}

function ref_126e8() {
  var_0 = self;
  var_1 = istrue(var_0.ref_12876);

  if(var_1) {
    var_0 scripts\mp\utility\lower_message::setlowermessageomnvar(76);

    while(istrue(var_0.ref_12876)) {
      waitframe();
    }
  }

  return var_1;
}

function gulaginitloadouts() {
  level.gulag.vehicle_compass_deregisterinstance = init_relic_punchbullets();
  init_relic_rocket_kill_ammo();
}

function init_relic_punchbullets() {
  var_0 = [];
  GscBinSkip0(0x2e, "loadoutArchetype", "archetype_assault");
}

function init_relic_rocket_kill_ammo() {
  level.set_relic_thirdperson = [];
  level.set_relic_trex = give_and_switch_to_secondary_weapon();

  if(getDvar("scr_br_gulag_loadout_override") != "") {
    var_0 = strtok(getDvar("scr_br_gulag_loadout_override"), " ");
    var_1 = [];

    for(var_2 = 0; var_2 < var_0.size; var_2++) {
      var_1 = int(var_0[var_1.size]);
    }

    var_3 = var_1.size;

    for(var_4 = 0; var_4 < var_3; var_4++) {
      level.set_relic_thirdperson[level.set_relic_thirdperson.size] = init_relic_oneclip(var_1[var_4]);
    }

    return;
  }

  var_3 = tablelookupgetnumcols(level.set_relic_trex) - 1;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    level.set_relic_thirdperson[level.set_relic_thirdperson.size] = init_relic_oneclip(var_4);
  }
}

function give_and_switch_to_secondary_weapon() {
  var_0 = getdvarint("scr_br_gulag_table_override", 0);

  if(var_0) {
    if(var_0 == 444) {
      if(randomint(2) == 0) {
        return "mp/classtable_br_gulagdbd1.csv";
      } else {
        return "mp/classtable_br_gulagdbd2.csv";
      }
    } else if(var_0 == 445) {
      return "mp/classtable_br_gulagtdbd1.csv";
    } else {
      return ("mp/classtable_br_gulag" + var_0 + ".csv");
    }
  }

  if(getdvarint("scr_br_gulag_melee_override", 0) == 1) {
    return "mp/classtable_br_gulag_melee.csv";
  }

  var_1 = randomint(1337) + 1;

  if(var_1 == 1337) {
    return "mp/classtable_br_gulag99.csv";
  }

  var_2 = randomint(100) + 1;

  if(var_2 > 90) {
    return "mp/classtable_br_gulag4.csv";
  } else if(var_2 > 65) {
    return "mp/classtable_br_gulag2.csv";
  } else if(var_2 > 40) {
    return "mp/classtable_br_gulag3.csv";
  } else {
    return "mp/classtable_br_gulag1.csv";
  }

  return "mp/classtable_br_gulag1.csv";
}

function init_relic_oneclip(var_0) {
  GscBinSkip1(0x45, "loadoutArchetype", "archetype_assault");
}

function playergivearenaloadout(var_0, var_1) {
  if(getdvarint("scr_br_fc_loadouts", 1) == 0) {
    return;
  }

  self.pers["gamemodeLoadout"] = level.set_relic_thirdperson[var_1];
  gethightestpriotiryactiveburnstate(var_1);
  self.class = "gamemode";
  self.prevweaponobj = undefined;
  var_2 = scripts\mp\class::loadout_getclassstruct();
  var_2 = scripts\mp\class::loadout_updateclass(var_2, "gamemode");
  scripts\mp\class::preloadandqueueclassstruct(var_2, 1, 1);
  scripts\mp\class::giveloadout(self.team, "gamemode", 0, 0);
  self givestartammo(var_2.loadoutprimaryobject);

  if(isDefined(var_2.loadoutsecondaryobject)) {
    self givestartammo(var_2.loadoutsecondaryobject);
  }

  self.set_relic_team_proximity = level.set_relic_thirdperson[var_1]["tableColumn"];
  ref_12687(var_0, "loadoutRow", self.set_relic_team_proximity);
}

function gethightestpriotiryactiveburnstate(var_0) {
  if(getdvarint("scr_br_alt_mode_gg", 0)) {
    switch (var_0) {
      case 0:
        var_1 = "iw8_pi_decho";
        break;
      case 1:
        var_1 = "iw8_pi_cpapa";
        break;
      case 2:
        var_1 = "iw8_pi_decho";
        break;
      case 3:
        var_1 = "iw8_pi_cpapa";
        break;
      case 4:
        var_1 = "iw8_pi_decho";
        break;
      case 5:
        var_1 = "iw8_pi_cpapa";
        break;
      case 6:
        var_1 = "iw8_pi_decho";
        break;
      case 7:
        var_1 = "iw8_pi_cpapa";
        break;
      case 8:
        var_1 = "iw8_pi_decho";
        break;
      case 9:
      default:
        var_1 = "iw8_pi_cpapa";
        break;
    }

    self.pers["gamemodeLoadout"]["loadoutPrimary"] = var_1;
    self.pers["gamemodeLoadout"]["loadoutPrimaryAttachment"] = "none";
    self.pers["gamemodeLoadout"]["loadoutPrimaryAttachment2"] = "none";
    self.pers["gamemodeLoadout"]["loadoutPrimaryAttachment3"] = "none";
    self.pers["gamemodeLoadout"]["loadoutPrimaryAttachment4"] = "none";
    self.pers["gamemodeLoadout"]["loadoutPrimaryAttachment5"] = "none";
    self.pers["gamemodeLoadout"]["loadoutSecondary"] = "none";
    self.pers["gamemodeLoadout"]["loadoutSecondaryAttachment"] = "none";
    self.pers["gamemodeLoadout"]["loadoutSecondaryAttachment2"] = "none";
    self.pers["gamemodeLoadout"]["loadoutSecondaryAttachment3"] = "none";
    self.pers["gamemodeLoadout"]["loadoutSecondaryAttachment4"] = "none";
    self.pers["gamemodeLoadout"]["loadoutSecondaryAttachment5"] = "none";
    self.pers["gamemodeLoadout"]["loadoutPerks"] = ["specialty_null"];
    return;
  }
}

function getloadoutindex() {
  if(getdvarint("scr_br_fc_loadouts", 1) == 0) {
    return;
  }

  var_0 = getdvarint("scr_br_fc_loadoutOverride", -1);

  if(var_0 > -1 && var_0 < level.set_relic_thirdperson.size) {
    return var_0;
  }

  if(getDvar("scr_br_gulag_loadout_override") != "") {
    if(!isDefined(level.set_relic_team_proximity) || level.set_relic_team_proximity >= level.set_relic_thirdperson.size) {
      level.set_relic_team_proximity = 0;
    }

    var_1 = level.set_relic_team_proximity;
    level.set_relic_team_proximity += 1;
  } else {
    var_1 = randomint(level.set_relic_thirdperson.size);
  }

  return var_1;
}

function ref_1428f(var_0) {
  var_0 endon("fight_over");
  var_0 endon("matchEnded");
  level endon("game_ended");
  self endon("death_or_disconnect");
  var_1 = level.gulag.timelimit;
  level.gulag.timelimit = 180;
  iprintln("Loadout verification starting in 3 seconds.");
  wait 3;
  iprintln("Verification start!");

  for(var_2 = 0; var_2 < level.set_relic_thirdperson.size; var_2++) {
    iprintln("Loadout: " + var_2);
    playergivearenaloadout(var_0, var_2);
    wait 5;
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.secondaryweapon);
    wait 4;
  }

  playergivearenaloadout(var_0, 0);
  level.gulag.timelimit = var_1;
  iprintln("Verification done!");
}

function ref_1323a(var_0) {
  var_1 = getdvarint("scr_br_fc_flag_radius", 50);
  var_0.managevehiclehealthui = spawnStruct();
  var_2 = getgroundposition(var_0.center, 1);
  var_0.managevehiclehealthui.trigger = spawn("trigger_radius", var_2, 0, int(var_1), int(level.defend_wave_3));
  var_3 = scripts\mp\gametypes\obj_dom::setupobjective(var_0.managevehiclehealthui.trigger, "neutral", undefined, 1);
  var_3.onuse = &arenaflag_onuse;
  var_3.onbeginuse = &arenaflag_onusebegin;
  var_3.onenduse = &arenaflag_onuseend;
  var_3.onuseupdate = &arenaflag_onuseupdate;
  var_3.oncontested = &arenaflag_oncontested;
  var_3.isarena = 1;
  var_3 scripts\mp\gameobjects::pinobjiconontriggertouch();
  var_3.id = "domFlag";
  var_3 scripts\mp\gameobjects::setcapturebehavior("persistent");
  var_3.scriptable delete();
  var_3.ignorestomp = 1;
  var_3 scripts\mp\gameobjects::requestid(0, 1, undefined, 0, 0);
  var_3.visibilitymanuallycontrolled = 1;
  calloutmarkerping_watchwhenobjectivedeleted(var_3, 0);
  calloutmarkerping_watchwhenobjectivestartsprogress(var_3, var_0, 0);
  var_3.arena = var_0;
  var_0.managevehiclehealthui.arenaflag = var_3;
}

function mark_remaining_as_died_poorly(var_0) {
  wait 1;

  if(isDefined(var_0) && isDefined(var_0.managevehiclehealthui) && isDefined(var_0.managevehiclehealthui.arenaflag) && isDefined(var_0.managevehiclehealthui.arenaflag.flagmodel)) {
    return;
  }
}

function calloutmarkerping_watchwhenobjectivedeleted(var_0) {
  if(var_0) {
    scripts\mp\gameobjects::allowuse("any");
    self.trigger scripts\engine\utility::trigger_on();
    return;
  }

  scripts\mp\gameobjects::allowuse("none");
  self.trigger scripts\engine\utility::trigger_off();
  scripts\mp\gameobjects::resetcaptureprogress();
}

function calloutmarkerping_watchwhenobjectivestartsprogress(var_0, var_1, var_2, var_3) {
  self notify("arenaFlag_setVisible");

  if(var_1) {
    var_4 = "waypoint_captureneutral";

    if(istrue(var_2)) {
      var_4 = level.squadspawndebug;
    }

    thread calloutmarkerping_squadleaderbeaconshouldcreate(var_0);
    thread scripts\mp\gameobjects::setobjectivestatusicons(var_4);
    thread scripts\mp\gameobjects::setownerteam("neutral");
    thread scripts\mp\gametypes\obj_dom::updateflagstate("idle", 0, "none");
    self.flagmodel show();
    thread calloutmarkerpingvo_createcalloutbattlechatter(var_0, 1);

    if(!istrue(var_2)) {
      ref_13193(var_0, 1);
      return;
    }

    return;
  }

  thread calloutmarkerpingvo_calculatesounddebouncelength(var_0, var_2, var_3);
}

function calloutmarkerpingvo_calculatesounddebouncelength(var_0, var_1, var_2) {
  self endon("arenaFlag_setVisible");
  self endon("death_or_disconnect");

  if(!istrue(var_2)) {
    objective_setpinned(self.objidnum, 0);
    wait 1;
  }

  thread calloutmarkerpingvo_createcalloutbattlechatter(var_0, 0);
  thread calloutmarkerping_squadleaderbeaconplayerfirstlanded(var_2);
  thread scripts\mp\gametypes\obj_dom::updateflagstate("off", 0, "none");
  self.flagmodel hide(1);

  if(!istrue(var_1)) {
    ref_13193(var_0, 0);
    ref_13194(var_0, 0);
    return;
  }
}

function calloutmarkerpingvo_canplaywithspamavoidance(var_0, var_1) {
  var_1 endon("death_or_disconnect");

  if(var_0) {
    var_1 setclientomnvar("ui_overtime_timer_show", 1);
    objective_addclienttomask(self.objidnum, var_1);
  } else {
    objective_unpinforclient(self.objidnum, var_1);
    wait 1;
    var_1 setclientomnvar("ui_overtime_timer_show", 0);
    objective_removeclientfrommask(self.objidnum, var_1);
  }

  thread calloutmarkerpingvo_debouncegarbagecollector(var_0, var_1);
}

function calloutmarkerping_watchplayerdeathordisconnect(var_0, var_1) {
  thread calloutmarkerping_watchwhenobjectivestartsprogress(var_0, 1, 1);
  wait var_1;
  thread calloutmarkerping_watchwhenobjectivestartsprogress(var_0, 0, 1, 1);
}

function calloutmarkerping_squadleaderbeaconshouldcreate(var_0) {
  objective_removeallfrommask(self.objidnum);

  foreach(var_2 in var_0.jailedplayers) {
    objective_addclienttomask(self.objidnum, var_2);
  }

  foreach(var_2 in var_0.arenaplayers) {
    objective_addclienttomask(self.objidnum, var_2);
  }

  objective_showtoplayersinmask(self.objidnum);
}

function calloutmarkerping_squadleaderbeaconplayerfirstlanded(var_0) {
  objective_setshowprogress(self.objidnum, 0);
  objective_removeallfrommask(self.objidnum);
  objective_showtoplayersinmask(self.objidnum);
}

function calloutmarkerpingvo_createcalloutbattlechatter(var_0, var_1) {
  if(var_1) {
    if(var_0.jailedplayers.size > 0) {
      self.flagmodel hudoutlineenableforclients(var_0.jailedplayers, "outline_nodepth_orange");
    }

    if(var_0.arenaplayers.size > 0) {
      self.flagmodel hudoutlineenableforclients(var_0.arenaplayers, "outline_nodepth_orange");
      return;
    }

    return;
  }

  if(var_0.jailedplayers.size > 0) {
    self.flagmodel hudoutlinedisableforclients(var_0.jailedplayers);
  }

  if(var_0.arenaplayers.size > 0) {
    self.flagmodel hudoutlinedisableforclients(var_0.arenaplayers);
    return;
  }
}

function calloutmarkerpingvo_debouncegarbagecollector(var_0, var_1) {
  if(var_0) {
    self.flagmodel hudoutlineenableforclient(var_1, "outline_nodepth_orange");
    return;
  }

  self.flagmodel hudoutlinedisableforclient(var_1);
}

function arenaflag_onusebegin(var_0) {
  var_1 = getdvarint("scr_br_fc_flag_capture_time", 3);
  var_0.iscapturing = 1;
  var_2 = scripts\mp\gameobjects::getownerteam();

  if(var_2 == "neutral") {
    var_0 setclientomnvar("ui_objective_state", 1);
  }

  self.neutralizing = istrue(level.flagneutralization) && var_2 != "neutral";

  if(!istrue(self.neutralized)) {
    self.didstatusnotify = 0;
  }

  var_3 = var_1;
  scripts\mp\gameobjects::setusetime(var_3);

  if(istrue(level.capturedecay)) {
    thread scripts\mp\gameobjects::useobjectdecay(var_0.team);
  }

  if(var_3 > 0) {
    foreach(var_5 in self.arena.arenaplayers) {
      if(var_5 != var_0 && var_5.team != var_0.team) {
        self.prevownerteam = var_5.team;
        break;
      }
    }

    scripts\mp\gametypes\obj_dom::updateflagcapturestate(var_0.team);
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_taking", "waypoint_losing");
    return;
  }
}

function arenaflag_onuseupdate(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\gameobjects::getownerteam();

  if(var_1 > 0.05 && var_2 && !self.didstatusnotify) {
    self.didstatusnotify = 1;
    return;
  }
}

function arenaflag_onuseend(var_0, var_1, var_2) {
  self.didstatusnotify = 0;

  if(var_2) {
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  }

  if(isPlayer(var_1)) {
    var_1.iscapturing = 0;
    var_1 setclientomnvar("ui_objective_state", 0);
    var_1.ui_dom_securing = undefined;
  }

  var_3 = scripts\mp\gameobjects::getownerteam();

  if(var_3 == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_captureneutral");
    thread scripts\mp\gametypes\obj_dom::updateflagstate("idle", 0);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture");
    thread scripts\mp\gametypes\obj_dom::updateflagstate(var_3, 0);
  }

  if(!var_2) {
    self.neutralized = 0;
    return;
  }
}

function calloutmarkerping_watchwhenmissioncompletes(var_0, var_1) {
  scripts\mp\gameobjects::setownerteam(var_0);
  self notify("capture", var_1);
  self notify("assault", var_1);
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defending", "waypoint_capture");
  self.neutralized = 0;
  thread scripts\mp\gametypes\obj_dom::updateflagstate(var_0, 0, var_0);

  if(self.touchlist[var_0].size == 0 && isDefined(self.oldtouchlist)) {
    self.touchlist = self.oldtouchlist;
  }

  foreach(var_3 in self.arena.arenaplayers) {
    if(var_3 != var_1 && var_3.team != var_0 && isDefined(self.assisttouchlist[var_3.team])) {
      self.assisttouchlist[var_3.team] = [];
      break;
    }
  }
}

function arenaflag_onuse(var_0) {
  var_1 = var_0.team;
  self.capturetime = gettime();
  self.neutralized = 0;
  calloutmarkerping_watchwhenmissioncompletes(var_1, var_0);

  if(!self.neutralized) {
    foreach(var_3 in self.arena.arenaplayers) {
      if(isalive(var_3) && var_3.team != var_1) {
        thread set_respawn_loc_delayed(var_3);
      }
    }

    thread handleendarena(self.arena);
    self.firstcapture = 0;
    return;
  }
}

function arenaflag_oncontested() {
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_contested");
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  thread scripts\mp\gametypes\obj_dom::updateflagstate("contested", 0);
}

function registercontrolledcallback(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = "";

  switch (var_0) {
    case "playerArena0":
      var_5 = [0, 8, "ui_br_gulag_players_1"];
      var_2 = var_5[0];
      var_3 = var_5[1];
      var_4 = var_5[2];
      var_5 = undefined;
      var_1 += 1;
      break;
    case "playerArena1":
      var_6 = [8, 8, "ui_br_gulag_players_1"];
      var_2 = var_6[0];
      var_3 = var_6[1];
      var_4 = var_6[2];
      var_6 = undefined;
      var_1 += 1;
      break;
    case "playerJail0":
      var_7 = [16, 8, "ui_br_gulag_players_1"];
      var_2 = var_7[0];
      var_3 = var_7[1];
      var_4 = var_7[2];
      var_7 = undefined;
      var_1 += 1;
      break;
    case "playerJail1":
      var_8 = [24, 8, "ui_br_gulag_players_1"];
      var_2 = var_8[0];
      var_3 = var_8[1];
      var_4 = var_8[2];
      var_8 = undefined;
      var_1 += 1;
      break;
    case "loadoutRow":
      var_9 = [0, 8, "ui_br_gulag_data"];
      var_2 = var_9[0];
      var_3 = var_9[1];
      var_4 = var_9[2];
      var_9 = undefined;
      var_1 += 1;
      break;
    case "playerHealth0":
      var_10 = [8, 8, "ui_br_gulag_data"];
      var_2 = var_10[0];
      var_3 = var_10[1];
      var_4 = var_10[2];
      var_10 = undefined;
      break;
    case "playerHealth1":
      var_11 = [16, 8, "ui_br_gulag_data"];
      var_2 = var_11[0];
      var_3 = var_11[1];
      var_4 = var_11[2];
      var_11 = undefined;
      break;
    default:
      break;
  }

  return [var_2, var_3, var_4, var_1];
}

function ref_121b3(var_0, var_1, var_2, var_3, var_4) {
  var_5 = int(pow(2, var_4)) - 1;
  var_6 = (var_2 &var_5) << var_3;
  var_7 = ~(var_5 << var_3);
  var_8 = var_0.ref_11fcf[var_1];
  var_9 = var_8 &var_7;
  var_10 = var_9 + var_6;
  var_0.ref_11fcf[var_1] = var_10;
}

function ref_13125(var_0, var_1, var_2) {
  var_3 = registercontrolledcallback(var_1, var_2);
  var_4 = var_3[0];
  var_5 = var_3[1];
  var_6 = var_3[2];
  var_2 = var_3[3];
  var_3 = undefined;

  if(var_6 == "") {
    return;
  }

  ref_121b3(var_0, var_6, var_2, var_4, var_5);
}

function ref_13127(var_0, var_1, var_2) {
  var_3 = -1;

  if(isDefined(var_2)) {
    var_3 = var_2 getentitynumber();
  }

  ref_13125(var_0, var_1, var_3);
}

function ref_13126(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_2)) {
    var_3 = var_2.health;
  }

  ref_13125(var_0, var_1, var_3);
}

function ref_13fc1(var_0) {
  var_0.ref_11fcf["ui_br_gulag_players_1"] = 0;

  for(var_1 = 0; var_1 < level.gulag.maxplayers; var_1++) {
    var_2 = var_0.arenaplayers[var_1];
    ref_13127(var_0, "playerArena" + var_1, var_2);
  }

  var_3 = var_0.matches[0];

  if(!isDefined(var_3)) {
    var_3 = [];
  }

  ref_13127(var_0, "playerJail0", var_3[0]);
  ref_13127(var_0, "playerJail1", var_3[1]);
  var_4 = scripts\engine\utility::array_combine(var_0.jailedplayers, var_0.arenaplayers);

  foreach(var_2 in var_4) {
    var_2 setclientomnvar("ui_br_gulag_players_1", var_0.ref_11fcf["ui_br_gulag_players_1"]);

    foreach(var_7 in var_0.matches) {
      if(isDefined(var_7[0]) && var_2 == var_7[0] || isDefined(var_7[1]) && var_2 == var_7[1]) {
        var_8 = !updatelootleadermarks(var_0, var_2);
        var_9 = var_11 + 1;
        var_10 = var_8 + (var_9 << 1);
        var_2 setclientomnvar("ui_br_gulag_queue_position", var_10);
        break;
      }
    }
  }
}

function ref_1267a(var_0) {
  self setclientomnvar("ui_br_gulag_data", var_0.ref_11fcf["ui_br_gulag_data"]);
}

function ref_13fc0(var_0) {
  ref_12c6b(var_0);

  for(var_1 = 0; var_1 < level.gulag.maxplayers; var_1++) {
    var_2 = var_0.arenaplayers[var_1];
    ref_13126(var_0, "playerHealth" + var_1, var_2);
  }

  foreach(var_2 in var_0.jailedplayers) {
    ref_1267a(var_2, var_0);
  }

  foreach(var_2 in var_0.arenaplayers) {
    ref_1266d(var_2, var_0);
  }
}

function ref_12c6b(var_0) {
  var_0.ref_11fcf["ui_br_gulag_data"] = 0;
}

function ref_1266d(var_0) {
  if(!isDefined(self.set_relic_team_proximity)) {
    self setclientomnvar("ui_br_gulag_data", var_0.ref_11fcf["ui_br_gulag_data"]);
    return;
  }

  ref_12687(var_0, "loadoutRow", self.set_relic_team_proximity);
}

function ref_12687(var_0, var_1, var_2) {
  var_3 = registercontrolledcallback(var_1, var_2);
  var_4 = var_3[0];
  var_5 = var_3[1];
  var_6 = var_3[2];
  var_2 = var_3[3];
  var_3 = undefined;

  if(var_6 == "") {
    return;
  }

  ref_1260f(var_0, var_6, var_2, var_4, var_5);
}

function ref_1260f(var_0, var_1, var_2, var_3, var_4) {
  var_5 = int(pow(2, var_4)) - 1;
  var_6 = (var_2 &var_5) << var_3;
  var_7 = ~(var_5 << var_3);
  var_8 = var_0.ref_11fcf[var_1];
  var_9 = var_8 &var_7;
  var_10 = var_9 + var_6;
  self setclientomnvar(var_1, var_10);
}

function ref_14009(var_0) {
  ref_13fc1(var_0);
  ref_13fc0(var_0);
}

function ref_12526(var_0) {
  var_1 = getarraykeys(var_0.ref_11fcf);

  foreach(var_3 in var_1) {
    self setclientomnvar(var_3, 0);
  }

  self setclientomnvar("ui_overtime_timer", 0);
  self setclientomnvar("ui_overtime_timer_show", 0);
}

function ref_13194(var_0, var_1) {
  foreach(var_3 in var_0.arenaplayers) {
    var_3 setclientomnvar("ui_overtime_timer", var_1);
  }

  foreach(var_3 in var_0.jailedplayers) {
    var_3 setclientomnvar("ui_overtime_timer", var_1);
  }
}

function ref_13193(var_0, var_1) {
  foreach(var_3 in var_0.arenaplayers) {
    var_3 setclientomnvar("ui_overtime_timer_show", var_1);
  }

  foreach(var_3 in var_0.jailedplayers) {
    var_3 setclientomnvar("ui_overtime_timer_show", var_1);
  }
}

function ref_125cc(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("gulag_end");
  var_1 = "playerHealth0";

  if(var_0.arenaplayers[0] != self) {
    var_1 = "playerHealth1";
  }

  for(;;) {
    ref_13fc0(var_0);

    if(self.health <= 0) {
      return;
    }

    scripts\engine\utility::ref_143aa("damage", "force_regeneration", "removeAdrenaline", "healed", "healhRegenThink", "vampirism", "spawned_player");
  }
}

function ref_1263c() {
  if(level.gulag.trial_target_civilian_killed_func && !isbot(self)) {
    var_0 = relic_amped_pick_new_victim();
    self skydive_cutparachuteon(var_0);
    return;
  }
}

function ref_12617() {
  if(level.gulag.trial_target_civilian_killed_func && !isbot(self)) {
    self setclientomnvar("ui_br_bink_overlay_state", 1);
    var_0 = scripts\mp\music_and_dialog::reset_attack_next_available_time("br_gulag_intro");
    self setplayermusicstate(var_0);

    if(scripts\mp\gametypes\br_public::tutorial_playSound()) {
      self setsoundsubmix("iw8_br_gulag_tutorial", 0.5);
    } else {
      self setsoundsubmix("fade_to_black_all_except_music_and_scripted5", 0.5);
    }

    var_1 = relic_amped_pick_new_victim();
    self preloadcinematicforplayer(var_1);
    self.ref_12742 = 1;
    return;
  }

  gulagloadingtext();
}

function ref_12694() {
  self setclientomnvar("ui_br_bink_overlay_state", 2);
}

function ref_126ea(var_0) {
  if(level.gulag.trial_target_civilian_killed_func && !isbot(self) && !self calloutmarkerping_getEnt()) {
    self freezecontrols(1);
    allplayers_setfov(var_0);
    self freezecontrols(0);
    self setclientomnvar("ui_br_bink_overlay_state", 5);
    self skydive_cutparachuteoff();
    self.ref_12742 = undefined;
    return;
  }
}

function allplayers_setfov(var_0) {
  self endon("bink_complete");
  var_1 = relic_amped_paused();

  while(gettime() - var_0 < var_1 && !self crouchbuttonPressed() && !self useButtonPressed() && !self jumpbuttonPressed()) {
    waitframe();
  }
}

function ref_12521(var_0, var_1) {
  if(var_0 == "bink_complete") {
    self notify("bink_complete");
    return;
  }
}

function ref_125eb() {
  if(scripts\mp\utility\game::getgametype() != "br") {
    return false;
  }

  var_0 = self calloutmarkerping_entityzoffset("ui_br_bink_overlay_state");

  if(var_0 != 0 && var_0 != 6) {
    return true;
  }

  return false;
}

function ref_125ea() {
  var_0 = self calloutmarkerping_entityzoffset("ui_br_bink_overlay_state");
  return var_0 == 7;
}

function ref_12522() {
  self setclientomnvar("ui_br_bink_overlay_state", 7);
}

function ref_12523(var_0) {
  self endon("disconnect");
  self endon("playerCinematicFadeOutForceEnd");

  if(ref_125eb()) {
    if(isDefined(var_0)) {
      wait var_0;
    }

    if(getdvarint("scr_br_bink_overlay_log", 0) == 1) {
      logstring("bnk_playerCinematicFadeOut()");
      logstring("bnk_Player " + self.name + " ui_br_bink_overlay_state : " + self calloutmarkerping_entityzoffset("ui_br_bink_overlay_state", 0));
    }

    self setclientomnvar("ui_br_bink_overlay_state", 6);
    wait 1;
    self setclientomnvar("ui_br_bink_overlay_state", 0);
    return;
  }
}

function relic_amped_pick_new_victim() {
  if(level.mapname == "mp_wz_island" || istrue(level.gulag.untrack_enemy)) {
    return "mp_wz_island_gulag_ch3";
  }

  if(scripts\cp_mp\utility\game_utility::turretdisabled()) {
    if(scripts\cp_mp\utility\game_utility::turretlightsonstate()) {
      return "rebirth_pm_gulag_intro";
    }

    return "rebirth_gulag_intro";
  }

  if(istrue(level.gulag.ref_11f19)) {
    return "mp_donetsk_gulag_intro2";
  }

  return "mp_donetsk_gulag_intro";
}

function relic_amped_paused() {
  if(level.mapname == "mp_wz_island") {
    return 28000;
  }

  if(istrue(level.gulag.ref_11f19)) {
    return 35000;
  }

  return 17000;
}

function ref_1322e(var_0, var_1) {
  if(!level.gulag.ref_14069) {
    return;
  }

  if(!isDefined(var_1.target)) {
    return;
  }

  var_2 = getEntArray(var_1.target, "targetname");

  if(var_2.size > 1) {
    level.gulag.ref_14069 = 0;
    return;
  }

  var_1.door = getEnt(var_1.target, "targetname");

  if(isDefined(var_1.door)) {
    var_1.door.closed = 1;
    var_3 = getEnt(var_1.door.target, "targetname");
    var_3 delete();
    var_4 = anglesToForward(var_1.door.angles);
    var_1.door.heli_rpg_enemy_run_away = var_1.door.origin;
    var_1.door.ref_1212b = var_1.door.origin + var_4 * 60;
  }

  return var_1;
}

function ref_14069(var_0) {
  return level.gulag.ref_14069 && var_0.get_wave_spawn_total.size > 0;
}

function ref_12c7a() {
  var_0 = self;
  var_0.fastcrouchspeedmod = 0;
  var_0 scripts\mp\weapons::updatemovespeedscale();
}

#using_animtree("");

function ref_1251a(var_0, var_1) {
  if(!level.gulag.getaccessorylogicbyindex) {
    return;
  }

  self endon("playerChairBreakoutCleanup");
  var_2 = var_1.chair;
  self playerhide();
  self showtoplayer(self);
  var_3 = spawn("script_arms", var_2.origin, 0, 0, self);
  var_3.angles = var_2.angles;
  var_3 useanimtree(#animtree);
  var_3 hide();
  var_3 showtoplayer(self);
  self.ref_12651 = var_3;
  var_4 = spawn("script_model", var_2.origin);
  var_4.angles = var_2.angles;
  var_4 setModel("misc_vm_gulag_cuffs");
  var_4 useanimtree($);
  var_4 hide();
  var_4 showtoplayer(self);
  self.straps = var_4;
  self setOrigin(var_2.origin);
  self playerlinktoabsolute(var_3, "tag_player");
  ref_1251c(1);
  thread ref_1251d(var_3, var_4);
  self playanimscriptsceneevent("scripted_scene", "gulag_chair_breakout_start");
  var_3 animScripted("chair", var_2.origin, var_2.angles, %sdr_mp_gulag_breakout_wz_2_start_plr);
  var_3 scriptmodelplayanim("sdr_mp_gulag_breakout_wz_2_start_plr");
  var_4 animScripted("chair", var_2.origin, var_2.angles, %sdr_mp_gulag_breakout_wz_2_start_straps);
  var_4 scriptmodelplayanim("sdr_mp_gulag_breakout_wz_2_start_straps");
  var_3 waittillmatch("chair", "end");
  thread ref_1251e();
  self playerlinkTo(var_3, "tag_player", 0, 30, 30, 45, 60, 0);
  var_3 hide();
  var_3 showtoplayer(self);
  ref_12600(var_3, var_4, var_2);
  self playanimscriptsceneevent("scripted_scene", "gulag_chair_breakout_exit");
  var_3 animScripted("chair", var_2.origin, var_2.angles, %sdr_mp_gulag_breakout_wz_2_exit_plr);
  var_3 scriptmodelplayanim("sdr_mp_gulag_breakout_wz_2_exit_plr");
  var_4 animScripted("chair", var_2.origin, var_2.angles, %sdr_mp_gulag_breakout_wz_2_exit_straps);
  var_4 scriptmodelplayanim("sdr_mp_gulag_breakout_wz_2_exit_straps");
  var_3 waittillmatch("chair", "end");
  thread ref_1251b(var_3, var_4);
}

function ref_12600(var_0, var_1, var_2) {
  self endon("playerChairBreakoutCleanup");
  self endon("chairBreakout");

  for(;;) {
    self playanimscriptsceneevent("scripted_scene", "gulag_chair_breakout_loop");
    var_0 animScripted("chair", var_2.origin, var_2.angles, %sdr_mp_gulag_breakout_wz_2_loop_plr);
    var_0 scriptmodelplayanim("sdr_mp_gulag_breakout_wz_2_loop_plr");
    var_1 animScripted("chair", var_2.origin, var_2.angles, %sdr_mp_gulag_breakout_wz_2_loop_straps);
    var_1 scriptmodelplayanim("sdr_mp_gulag_breakout_wz_2_loop_straps");
    var_0 waittillmatch("chair", "end");
  }
}

function ref_1251e() {
  self endon("playerChairBreakoutCleanup");
  self endon("disconnect");
  wait 1;

  for(;;) {
    if(isDefined(self)) {
      var_0 = self getnormalizedmovement();

      if(self useButtonPressed() || self jumpbuttonPressed() || var_0[0] > 0.5 || var_0[1] > 0.5) {
        break;
      }
    }

    waitframe();
  }

  self playerlinktoabsolute(self.ref_12651, "tag_player");
  self.ref_12651 hide();
  self.ref_12651 showtoplayer(self);
  self.straps hide();
  self.straps showtoplayer(self);
  self notify("chairBreakout");
}

function ref_1251f() {
  ref_1251b(self.ref_12651, self.straps);
}

function ref_1251b(var_0, var_1) {
  if(!level.gulag.getaccessorylogicbyindex) {
    return;
  }

  if(!isDefined(self.ref_12651)) {
    return;
  }

  if(isDefined(self)) {
    self unlink();
    self stopanimscriptsceneevent();
    self playershow(1);
    ref_1251c(0);
    self.ref_12651 = undefined;
    self.straps = undefined;
    self notify("playerChairBreakoutCleanup");
  }

  var_0 delete();
  var_1 delete();
}

function ref_1251d(var_0, var_1) {
  self endon("playerChairBreakoutCleanup");
  self waittill("death_or_disconnect");
  thread ref_1251b(var_0, var_1);
}

function ref_1251c(var_0) {
  if(var_0) {
    self disableweapons();
  } else {
    self enableweapons();
  }

  var_1 = !var_0;
  self allowmelee(var_1);
  self allowfire(var_1);
}

function reset_minigun_shot_count(var_0) {
  if(isDefined(var_0.getactiveforteam)) {
    var_0.getactiveforteam++;
    var_0.getactiveforteam %= var_0.getactiveteamcount.size;
  } else {
    var_0.getactiveforteam = 0;
  }

  var_1 = var_0.getactiveteamcount[var_0.getactiveforteam];
  return var_1;
}

function ref_1327f() {
  if(!istrue(level.gulag.ref_142fb)) {
    return;
  }

  level.gulag.hud_y_offset = [];
  var_0 = 0;
  level.gulag.hud_y_offset[var_0] = spawnStruct();
  level.gulag.hud_y_offset[var_0].brclampdamagealtmodegg = "dx_brm_rm1_gulag_muffled_chatter_";
  level.gulag.hud_y_offset[var_0].aliases = [10, 20, 30, 40];
  level.gulag.hud_y_offset[var_0].ks_circledelaytime = [1, 1, 1, 0];
  var_0++;
  level.gulag.hud_y_offset[var_0] = spawnStruct();
  level.gulag.hud_y_offset[var_0].brclampdamagealtmodegg = "dx_brm_rm1_gulag_muffled_chatter_";
  level.gulag.hud_y_offset[var_0].aliases = [90, 100, 110];
  level.gulag.hud_y_offset[var_0].ks_circledelaytime = [1, 1, 0];
  var_0++;
  level.gulag.hud_y_offset[var_0] = spawnStruct();
  level.gulag.hud_y_offset[var_0].brclampdamagealtmodegg = "dx_brm_rm2_gulag_announcement_";
  level.gulag.hud_y_offset[var_0].aliases = [10];
  level.gulag.hud_y_offset[var_0].ks_circledelaytime = [0];
  var_0++;
  level.gulag.hud_y_offset[var_0] = spawnStruct();
  level.gulag.hud_y_offset[var_0].brclampdamagealtmodegg = "dx_brm_rm2_gulag_announcement_";
  level.gulag.hud_y_offset[var_0].aliases = [20];
  level.gulag.hud_y_offset[var_0].ks_circledelaytime = [0];
  var_0++;
  level.gulag.hud_y_offset[var_0] = spawnStruct();
  level.gulag.hud_y_offset[var_0].brclampdamagealtmodegg = "dx_brm_rm2_gulag_announcement_";
  level.gulag.hud_y_offset[var_0].aliases = [30];
  level.gulag.hud_y_offset[var_0].ks_circledelaytime = [0];
  var_0++;
  level.gulag.hud_y_offset[var_0] = spawnStruct();
  level.gulag.hud_y_offset[var_0].brclampdamagealtmodegg = "dx_brm_rm2_gulag_announcement_";
  level.gulag.hud_y_offset[var_0].aliases = [40];
  level.gulag.hud_y_offset[var_0].ks_circledelaytime = [0];
  var_0++;
  level.gulag.hud_y_offset[var_0] = spawnStruct();
  level.gulag.hud_y_offset[var_0].brclampdamagealtmodegg = "dx_brm_rm2_gulag_recording_";
  level.gulag.hud_y_offset[var_0].aliases = [10];
  level.gulag.hud_y_offset[var_0].ks_circledelaytime = [0];
  var_0++;
  level.gulag.hud_y_offset[var_0] = spawnStruct();
  level.gulag.hud_y_offset[var_0].brclampdamagealtmodegg = "dx_brm_rm2_gulag_recording_";
  level.gulag.hud_y_offset[var_0].aliases = [20, 30, 40, 50, 60, 20, 70, 80, 90, 80, 20, 30, 100, 110];
  level.gulag.hud_y_offset[var_0].ks_circledelaytime = [0.5, 1, 1.5, 0.7, 0.3, 1, 0.4, 0.8, 1, 0.5, 1, 1.5, 2, 0];
  var_0++;
  level.gulag.hud_y_offset = scripts\engine\utility::array_randomize(level.gulag.hud_y_offset);
}

function ref_13882(var_0) {
  if(!istrue(level.gulag.ref_142fb) || var_0.ref_12d93.size == 0) {
    return;
  }

  var_0.ref_142fa = spawn("script_model", var_0.origin);
  var_0.ref_142fa setModel("tag_origin");
  var_1 = randomint(level.gulag.hud_y_offset.size);
  var_2 = randomint(var_0.ref_12d93.size);

  for(;;) {
    ref_14407();

    while(var_0.jailedplayers.size == 0) {
      waitframe();
    }

    var_5 = var_0.ref_12d93[var_2];
    var_6 = level.gulag.hud_y_offset[var_1];
    var_0.ref_142fa.origin = var_5.origin;
    var_0.ref_142fa dontinterpolate();
    waitframe();

    for(var_7 = 0; var_7 < var_6.aliases.size; var_7++) {
      var_8 = var_6.brclampdamagealtmodegg + var_6.aliases[var_7];
      var_0.ref_142fa playsoundonmovingent(var_8);
      var_9 = lookupsoundlength(var_8, 1) / 1000;
      var_10 = var_6.ks_circledelaytime[var_7] + var_9;
      wait var_10;
    }

    var_2 = randomint(var_0.ref_12d93.size);
    var_1++;

    if(var_1 >= level.gulag.hud_y_offset.size) {
      var_1 = 0;
    }
  }
}

function ref_14407() {
  var_0 = getdvarint("scr_br_gulag_voice_min", 90);
  var_1 = getdvarint("scr_br_gulag_voice_max", 180);
  var_2 = randomfloatrange(var_0, var_1);
  wait var_2;
}