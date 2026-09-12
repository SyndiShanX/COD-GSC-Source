/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_spectate.gsc
************************************************/

function spectate_init() {
  thread updateactivespectatorcounts();
}

function initplayer() {
  ref_1252A();
}

function regive_killstreak_after_use(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_0.ref_11E80)) {
    var_2 = reset_use_puzzle_effects(var_0.ref_11E80);
    var_0.ref_11E80 = undefined;
  }

  if(!isDefined(var_2)) {
    var_2 = var_0 scripts\mp\gametypes\br_gulag::ref_12568(undefined, undefined, 1);
  }

  if(!isDefined(var_2)) {
    var_3 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0.team, var_0.squadindex);
    var_2 = registeruniquelootcallback(var_0, var_3);
  }

  if(!isDefined(var_2) && scripts\mp\menus::ref_13733()) {
    var_3 = scripts\mp\utility\teams::getteamdata(var_0.team, "players");
    var_2 = registeruniquelootcallback(var_0, var_3);
  }

  if(!isDefined(var_2)) {
    if(isDefined(var_1) && isPlayer(var_1) && var_1.team != var_0.team) {
      if(isalive(var_1) && !istrue(var_1.gulag) && !istrue(var_1.inlaststand) && !var_1 scripts\mp\gametypes\br_public::ref_125F3()) {
        var_2 = var_1;
      } else {
        var_4 = scripts\mp\utility\teams::getfriendlyplayers(var_1.team);
        var_2 = registeruniquelootcallback(var_0, var_4, 1);
      }
    }
  }

  if(!isDefined(var_2) && isPlayer(var_1) && var_1 != var_0) {
    var_2 = reset_use_puzzle_effects(var_1);

    if(isDefined(var_2) && var_2 scripts\mp\gametypes\br_public::ref_125F3()) {
      var_2 = undefined;
    }
  }

  if(!isDefined(var_2)) {
    var_2 = registeruniquelootcallback(var_0, level.players);
  }

  if(!isDefined(var_2) && level.players.size > 1 && !istrue(level.gameended) && !istrue(level.supportnovalidspectateplayer)) {
    var_5 = 0;

    foreach(var_7 in level.players) {
      if(istrue(var_7.delay_enter_combat_after_investigating_grenade)) {
        var_5++;
      }
    }

    scripts\mp\utility\script::laststand_dogtags("getBestSpectateCandidate - no valid players found (" + var_5 + " of " + level.players.size + ") eliminated");
  }

  return var_2;
}

function issubgametype(var_0, var_1, var_2) {
  var_3 = "player: " + var_0.name + ", candidate: " + var_1.name + ", playersChecked.size: " + var_2.size;
  scripts\mp\utility\script::laststand_dogtags(var_3);
  var_3 = "";
  var_4 = int(min(var_2.size, 3));
  var_5 = 0;

  foreach(var_7 in var_2) {
    var_3 += " - player: " + var_7.name + ", eliminated: " + istrue(var_7.delay_enter_combat_after_investigating_grenade);
    var_5++;

    if(var_5 > var_4) {
      break;
    }
  }

  scripts\mp\utility\script::laststand_dogtags(var_3);
}

function reset_use_puzzle_effects(var_0) {
  var_1 = [];
  var_2 = 0;

  for(var_3 = var_0; isDefined(var_3) && !vandalize_target_think(var_3); var_3 = ref_12580(var_3)) {
    var_2++;
    var_4 = var_3 getentitynumber();

    if(var_2 >= 150 || isDefined(var_1[var_4])) {
      issubgametype(var_0, var_3, var_1);
      return;
    }

    var_1 = var_3;
  }

  return var_3;
}

function registeruniquelootcallback(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = [];
  var_5 = [];
  var_6 = [];
  var_7 = [];

  foreach(var_9 in var_1) {
    if(!isDefined(var_9) || !vandalize_target_think(var_9) || var_9 == var_0) {
      continue;
    }

    if(istrue(var_9.gulag)) {
      var_5 = var_9;
      continue;
    }

    if(istrue(var_9.inlaststand)) {
      var_6 = var_9;
      continue;
    }

    if(var_9 scripts\mp\gametypes\br_public::ref_125F3()) {
      var_7 = var_9;
      continue;
    }

    var_4 = var_9;
  }

  if(var_4.size > 0) {
    var_11 = randomint(var_4.size);
    var_3 = var_4[var_11];
  }

  if(!isDefined(var_3) && var_5.size > 0) {
    var_11 = randomint(var_5.size);
    var_3 = var_5[var_11];
  }

  if(!isDefined(var_3) && var_6.size > 0) {
    var_11 = randomint(var_6.size);
    var_3 = var_6[var_11];
  }

  if(!isDefined(var_3) && var_7.size > 0 && !istrue(var_2)) {
    var_11 = randomint(var_7.size);
    var_3 = var_7[var_11];
  }

  return var_3;
}

function vandalize_target_think(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(istrue(scripts\mp\gametypes\br_gametypes::tutorial_showtext("isValidSpectateTarget"))) {
    return scripts\mp\gametypes\br_gametypes::ref_12E05("isValidSpectateTarget", var_0);
  }

  if(!isalive(var_0) && !istrue(var_0.respawningfromtoken) && (istrue(var_0.gulagarena) || !istrue(var_0.gulag))) {
    return 0;
  }

  return !istrue(var_0.delay_enter_combat_after_investigating_grenade);
}

function ref_13668(var_0) {
  var_1 = spawnStruct();

  if(istrue(level.ref_14603) && level.ref_14603 == 6 && getdvarint("scr_br_x1_intermission_location_enabled", 1)) {
    var_1.origin = getdvarvector("scr_br_x1_intermission_origin", (29247, 1991, 6334));
    var_1.angles = getdvarvector("scr_br_x1_intermission_angles", (85, 135, 0));
  } else if(isDefined(level.ref_12D05) && level.ref_12D05 == 2 && getdvarint("scr_br_dov1_intermission_location_enabled", 1)) {
    var_1.origin = getdvarvector("scr_br_dov1_intermission_origin", (29247, 1991, 6334));
    var_1.angles = getdvarvector("scr_br_dov1_intermission_angles", (85, 135, 0));
  } else if(isDefined(var_0.ref_136DC)) {
    var_1 = var_0.ref_136DC;
    var_0.ref_136DC = undefined;
  } else {
    var_1.origin = var_0.origin + (0, 0, 100);
    var_1.angles = var_0.angles;
  }

  scripts\mp\playerlogic::spawnintermission(var_1, undefined, 0);
}

function spawnspectator(var_0, var_1, var_2) {
  if(scripts\mp\gametypes\br_public::validtousesticker()) {
    return;
  }

  var_3 = self;
  ref_13668(var_3, var_3);

  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("teamSpectate")) {
    return;
  }

  thread scripts\mp\gametypes\br_gulag::ref_126AA();

  if(!istrue(var_2)) {
    thread ref_13DC2();
  }

  var_4 = undefined;

  if(isDefined(var_0.attacker)) {
    var_4 = var_0.attacker;
  }

  var_5 = regive_killstreak_after_use(var_3, var_4);

  if(isDefined(var_5) || !istrue(level.supportnovalidspectateplayer)) {
    assignspectatortospectateplayer(var_3, var_5);
  }

  if(!istrue(var_3.br_spectatorinitialized)) {
    var_3 notify("br_spectatorInitialized");
    var_3.br_spectatorinitialized = 1;
    return;
  }
}

function ref_13DC2() {
  self endon("disconnect");
  self endon("br_team_fully_eliminated");
  var_0 = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);

  if(var_0.size > 0) {
    var_1 = 1;

    switch (scripts\mp\utility\game::round_vehicle_logic()) {
      case "gold_war":
      case "risk":
      case "rat_race":
      case "dmz":
      case "rumble":
        var_1 = 0;
        break;
      case "truckwar":
        var_1 = !isDefined(level.ref_13ACE) || !isDefined(level.ref_13ACE[self.team]);
        break;
    }

    if(var_1) {
      thread ref_13132();
      wait 0.25;
      self setclientomnvar("ui_br_end_game_splash_type", 5);
      wait 1;
      self setclientomnvar("ui_br_end_game_splash_type", 0);
      return;
    }

    return;
  }
}

function ref_125C9() {
  var_0 = 0;
  var_1 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.team, self.squadindex);

  foreach(var_3 in var_1) {
    if(isDefined(var_3) && self != var_3 && isalive(var_3) && !var_3 scripts\mp\gametypes\br_public::ref_125F3()) {
      var_0 = 1;
      break;
    }
  }

  return var_0;
}

function ref_13132() {
  self endon("disconnect");
  self endon("br_team_fully_eliminated");
  self endon("started_spawnPlayer");
  self endon("gulag_auto_win");

  if(!istrue(level.br_plunder_enabled)) {
    return;
  }

  var_0 = istrue(getdvarint("scr_br_resurgence_respawn_enable", 0)) && level.disable_super_in_turret.ref_12CA4;

  if(scripts\mp\utility\game::getgametype() != "dmz" && scripts\mp\utility\game::getgametype() != "rat_race" && scripts\mp\utility\game::getgametype() != "gold_war" && !var_0) {
    ref_143FA(self);

    if(scripts\mp\gametypes\br_public::use_csm(self)) {
      return;
    }

    scripts\mp\utility\lower_message::setlowermessageomnvar(75);

    for(;;) {
      waittillframeend();

      if(isDefined(self.ref_126CC) && istrue(self.ref_126CC.gulag)) {
        scripts\mp\utility\lower_message::setlowermessageomnvar(0);
        waitframe();
        continue;
      }

      scripts\mp\utility\lower_message::setlowermessageomnvar(75);

      if(!ref_125C9()) {
        scripts\mp\utility\lower_message::setlowermessageomnvar(0);
        waitframe();
      }

      var_1 = scripts\engine\utility::ref_143AF("buybackRequested", "br_spectator_end_forced_spectator", "playertospectate_set", "spectating_cycle");

      if(isDefined(self) && isDefined(var_1) && var_1 == "buybackRequested") {
        scripts\mp\utility\lower_message::setlowermessageomnvar(0);
        wait 10;
      }
    }

    return;
  }
}

function istacticalbc(var_0, var_1) {
  var_2 = "player: " + var_0.name;

  if(isDefined(var_1)) {
    var_2 += ", playerToSpectate: " + var_1.name + ", alive: " + isalive(var_1) + ", eliminated: " + istrue(var_1.delay_enter_combat_after_investigating_grenade) + ", gulag: " + istrue(var_1.gulag);
  }

  scripts\mp\utility\script::laststand_dogtags(var_2);
  waitframe();
  var_2 = "waitframe - playerToSpectate: " + var_1.name + ", alive: " + isalive(var_1) + ", eliminated: " + istrue(var_1.delay_enter_combat_after_investigating_grenade) + ", gulag: " + istrue(var_1.gulag);
  scripts\mp\utility\script::laststand_dogtags(var_2);
}

function ref_1252A() {
  self.ref_12876 = undefined;
  self.ref_11E80 = undefined;
  self.ref_126CC = undefined;
  self setclientomnvar("ui_show_spectateHud", -1);
  self notify("forcePlayerSpectateTarget");
  self notify("playerMonitorSpectatorCycle");
}

function ref_126AB() {
  var_0 = self;

  if(var_0.sessionstate != "intermission") {
    var_1 = ref_12580(var_0);

    if(istrue(var_1.ref_14439)) {
      var_0 scripts\mp\gametypes\br_gulag::ref_1268E(1);
      level notify("update_circle_hide");
    }

    ref_13668(var_0, var_1);
    return;
  }
}

function forceplayerspectatetarget(var_0) {
  if(istrue(level.endmatchcameratransitions)) {
    return;
  }

  var_1 = self;
  level endon("brSpawnPlayersEnding");
  var_1 endon("disconnect");
  var_1 notify("forcePlayerSpectateTarget");
  var_1 endon("forcePlayerSpectateTarget");
  var_1.ref_12876 = 1;
  ref_126AB(var_1);

  if(!isDefined(var_0) || !isPlayer(var_0) || !isalive(var_0) && !ref_125ED(var_0)) {
    if(level.gameended || level.players.size == 1) {
      var_1 setclientomnvar("ui_show_spectateHud", var_1 getentitynumber());
      var_1.ref_12876 = undefined;
      return;
    }

    thread istacticalbc(var_1, var_0);
    var_0 = regive_killstreak_after_use(var_1);

    if(!isDefined(var_0)) {
      var_1 setclientomnvar("ui_show_spectateHud", var_1 getentitynumber());
      var_1.ref_12876 = undefined;
      return;
    }
  }

  var_0 endon("disconnect");
  var_2 = var_0 getentitynumber();
  var_1.ref_126CC = var_0;
  var_1 setclientomnvar("ui_show_spectateHud", var_2);

  if(!var_1 isadditionalstreamposready()) {
    var_1 clearadditionalstreampos();
  }

  var_1 calloutmarkerping_getorigin(0);
  var_3 = var_0.origin;

  if(istrue(var_0.respawningfromtoken) && isDefined(var_0.forcespawnorigin)) {
    if(!var_0 scripts\mp\gametypes\br_gulag::ref_125EA()) {
      if(getdvarint("scr_br_bink_overlay_log", 0) == 1) {
        logstring("bnk_forcePlayerSpectateTarget()");
      }

      var_1 thread scripts\mp\gametypes\br_gulag::ref_12523();
    } else if(!var_1 scripts\mp\gametypes\br_gulag::ref_125EA()) {
      var_1 scripts\mp\gametypes\br_gulag::ref_12522();
    }

    var_3 = var_0.forcespawnorigin;
    var_1 setadditionalstreampos(var_3, 1);
  } else if(isDefined(var_0.ref_1391A)) {
    var_3 = var_0.ref_1391A.origin;
    var_1 setadditionalstreampos(var_3, 1);
  } else {
    var_1 setadditionalstreampos(var_3, 1, 0, var_0);
  }

  var_1 loadcustomizationplayerview(var_0);
  var_4 = var_0 getweaponslistprimaries();
  var_1 loadweaponsforplayer(var_4, 1);
  waitframe();
  var_5 = getdvarint("spectate_stream_update_distsq", 2500);
  var_6 = getdvarint("spectate_stream_update_time", 500);
  var_7 = getdvarint("spectate_stream_timeout", 9000);
  var_8 = gettime() + var_6;
  var_9 = gettime() + var_7;

  while((!var_1 isadditionalstreamposready() || isDefined(var_0) && !var_1 hasloadedcustomizationplayerview(var_0) || !var_1 hasloadedviewweapons(var_4)) && gettime() < var_9) {
    if(isDefined(var_0) && !isDefined(var_0.ref_1391A) && gettime() > var_8) {
      var_10 = distance2dsquared(var_0.origin, var_3);

      if(var_10 > var_5) {
        var_3 = var_0.origin;
        var_1 setadditionalstreampos(var_3, 1, 0, var_0);
        var_8 = gettime() + var_6;
      }
    }

    waitframe();
  }

  var_12 = getdvarint("spectate_stream_update_time", 2000);
  var_9 = gettime() + var_7;
  var_13 = 0;

  while((isDefined(var_0.ref_1391A) || !isalive(var_0)) && gettime() < var_9) {
    if(gettime() > var_13) {
      var_1 setadditionalstreampos(var_3, 1);
      var_13 = gettime() + var_12;
    }

    waitframe();
  }

  if(isDefined(var_0)) {
    ref_12563(var_1, var_0);
  }

  thread ref_12603();
  var_1 clearadditionalstreampos();

  if(istrue(var_1.ref_14439)) {
    var_1 scripts\mp\gametypes\br_gulag::ref_1268E(0);
    level notify("update_circle_hide");
    return;
  }
}

function ref_12563(var_0) {
  var_1 = self;

  if(!istrue(var_1.multieventdisabled)) {
    if(!var_0 scripts\mp\gametypes\br_gulag::ref_125EA()) {
      if(getdvarint("scr_br_bink_overlay_log", 0) == 1) {
        logstring("bnk_playerForceSpectatorClientWait()");
      }

      var_1 thread scripts\mp\gametypes\br_gulag::ref_12523();
    } else if(!var_1 scripts\mp\gametypes\br_gulag::ref_125EA()) {
      var_1 scripts\mp\gametypes\br_gulag::ref_12522();
      wait 0.5;
    }
  }

  var_2 = var_0 getentitynumber();
  var_1 scripts\mp\utility\player::updatesessionstate("spectator");
  var_1.forcespectatorclient = var_2;
  var_1 scripts\mp\utility\player::_freezecontrols(0, undefined, "spawnIntermission");
  var_1 calloutmarkerping_getcreatedtime(0);
  var_1 setclientomnvar("ui_show_spectateHud", -1);
  var_3 = var_1 getspectatingplayer();

  while(!isDefined(var_3) || var_2 != var_3 getentitynumber()) {
    waitframe();
    var_3 = var_1 getspectatingplayer();

    if(!isDefined(var_0) || !vandalize_target_think(var_0)) {
      break;
    }
  }

  var_1 notify("br_spectator_end_forced_spectator");
  var_1.forcespectatorclient = -1;

  if(isDefined(var_0) && vandalize_target_think(var_0)) {
    var_1 spectateclientnum(var_2, 1);
  }

  var_1.ref_12876 = undefined;
}

function assignspectatortospectateplayer(var_0, var_1) {
  var_2 = scripts\mp\gametypes\br_gametypes::ref_12E05("assignSpectatorToSpectatePlayer", var_0, var_1);

  if(istrue(var_2)) {
    return;
  }

  var_0 allowspectateteam("freelook", 0);
  var_0 allowspectateteam("none", 0);
  var_0 setmlgmessagesent(0);

  if(level.teambased && isDefined(var_1)) {
    var_0 allowspectateteam(var_1.team, 1);
  }

  thread forceplayerspectatetarget(var_0);
  self notify("playertospectate_set");
}

function ref_12603() {
  self notify("playerMonitorSpectatorCycle");
  self endon("playerMonitorSpectatorCycle");
  self endon("forcePlayerSpectateTarget");
  self endon("disconnect");
  self endon("started_spawnPlayer");
  level endon("br_ending_start");

  for(;;) {
    self waittill("spectating_cycle_start", var_0);

    if(!isDefined(var_0)) {
      continue;
    }

    if(var_0 scripts\mp\gametypes\br_gulag::ref_125EA()) {
      scripts\mp\gametypes\br_gulag::ref_12522();
    }

    var_1 = ref_126EC(var_0);
    var_2 = self getspectatingplayer();

    if(!istrue(var_1) || !isDefined(var_2)) {
      stopspectateplayer(self getentitynumber(), 1);

      if(vandalize_target_think(self.ref_126CC)) {
        ref_12563(self.ref_126CC);
      } else {
        var_0 = regive_killstreak_after_use(self);

        if(isDefined(var_0) && !var_0 scripts\mp\gametypes\br_gulag::ref_125EA()) {
          if(getdvarint("scr_br_bink_overlay_log", 0) == 1) {
            logstring("bnk_playerMonitorSpectatorCycle()");
          }

          thread scripts\mp\gametypes\br_gulag::ref_12523();
        }

        assignspectatortospectateplayer(self, var_0);
      }

      continue;
    }

    self.ref_126CC = var_0;

    if(var_2 != var_0) {
      self.ref_126CC = var_2;
    }

    if(self.ref_126CC scripts\mp\gametypes\br_gulag::ref_125EA()) {
      if(!scripts\mp\gametypes\br_gulag::ref_125EA()) {
        scripts\mp\gametypes\br_gulag::ref_12522();
      }

      continue;
    }

    if(getdvarint("scr_br_bink_overlay_log", 0) == 1) {
      logstring("bnk_playerMonitorSpectatorCycle()");
    }

    thread scripts\mp\gametypes\br_gulag::ref_12523();
  }
}

function ref_126EC(var_0) {
  var_0 endon("death_or_disconnect");
  self waittill("spectating_cycle");
  return true;
}

function ref_12580() {
  var_0 = undefined;

  if(!istrue(self.spectatekillcam)) {
    var_0 = self getspectatingplayer();
  }

  if(!isDefined(var_0) && isDefined(self.ref_11E80)) {
    var_0 = self.ref_11E80;
  }

  if(!isDefined(var_0) && isDefined(self.ref_126CC)) {
    var_0 = self.ref_126CC;
  }

  return var_0;
}

function rotatetocurrentangles(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }

    if(vandalize_target_think(var_3)) {
      continue;
    }

    if(!istrue(var_3.br_spectatorinitialized)) {
      continue;
    }

    var_4 = ref_12580(var_3);

    if(!isDefined(var_4)) {
      continue;
    }

    if(var_4 == var_0) {
      var_1 = var_3;
    }
  }

  return var_1;
}

function ref_11BE2(var_0, var_1, var_2) {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  var_3 = regive_killstreak_after_use(var_0, var_1);

  if(var_2 && !istrue(var_0.gulag)) {
    var_0.ref_11E80 = var_3;
  }

  if(isDefined(var_3) || !istrue(level.supportnovalidspectateplayer)) {
    updateexistingspectatorsofvictim(var_0, var_3);
    return;
  }
}

function ref_125ED() {
  return isDefined(self.ref_1391A) || scripts\mp\gametypes\br_public::ref_125F3() || istrue(self.tut_popup_listener) || istrue(self.respawningfromtoken);
}

function updateexistingspectatorsofvictim(var_0, var_1) {
  var_2 = rotatetocurrentangles(var_0);

  foreach(var_4 in var_2) {
    if(isDefined(var_1) && var_0.team == var_4.team && var_1.team != var_0.team && ref_125ED(var_0)) {
      assignspectatortospectateplayer(var_4, var_0);
      continue;
    }

    if(isDefined(var_4.ref_11E80)) {
      var_4.ref_11E80 = var_1;
      continue;
    }

    assignspectatortospectateplayer(var_4, var_1);
  }
}

function updateactivespectatorcounts() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    var_0 = [];

    foreach(var_2 in level.players) {
      if(isDefined(var_2)) {
        var_3 = var_2 getspectatingplayer();

        if(isDefined(var_3)) {
          var_4 = var_3 getentitynumber();
          var_0 = scripts\mp\gametypes\br::get_int_or_0(var_0[var_4]) + 1;
        }
      }
    }

    var_6 = 0;

    foreach(var_2 in level.players) {
      if(isDefined(var_2)) {
        var_8 = var_2 getentitynumber();
        var_9 = scripts\mp\gametypes\br::get_int_or_0(var_0[var_8]);
        var_10 = var_2 calloutmarkerping_entityzoffset("ui_br_active_spectators");

        if(var_9 != var_10) {
          var_2 setclientomnvar("ui_br_active_spectators", var_9);
        }

        var_6++;

        if(var_6 % 10 == 0) {
          waitframe();
        }
      }
    }

    wait 1;
  }
}

function ref_143FA(var_0) {
  while(var_0.sessionstate != "intermission") {
    waitframe();
  }

  while(var_0.sessionstate == "intermission") {
    waitframe();
  }

  while(var_0.sessionstate != "spectator") {
    waitframe();
  }
}