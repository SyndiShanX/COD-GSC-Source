/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58223.gsc
***********************************************/

function init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "init")]]();
  }

  level._effect["nuke_rolling_death"] = loadfx("vfx/iw8_mp/killstreak/vfx_nuke_player_death_2.vfx");
  level.nuke_expl_struct = scripts\cp_mp\utility\game_utility::removematchingents_bycodeclassname("nuke_expl_pos");
}

function tryusenuke() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("nuke", self);
  return tryusenukefromstruct(var_0);
}

function tryusenukefromstruct(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      var_0 notify("killstreak_finished_with_deploy_weapon");
      return false;
    }
  }

  if(var_0.streakname == "nuke_select_location") {
    var_1 = 1;
  } else {
    var_1 = 0;
  }

  var_1.nuketype = var_1;
  var_2 = undefined;
  var_3 = undefined;

  if(!isDefined(level.nukeincoming)) {
    level.nukeincoming = 1;
    level.ref_11f14 = self;
  } else {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/NUKE_ALREADY_INBOUND");
    }

    return false;
  }

  if(var_1 == 1) {
    var_4 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(var_1, getcompleteweaponname("iw8_spotter_scope_mp", ["spotterscope"]), "weapon_fired", &weapongivennuke, &weaponswitchendednuke, &weaponfirednuke);
    var_2 = scripts\cp_mp\killstreaks\airstrike::airstrike_getownerlookatpos(self);
    var_3 = 25;
    var_5 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getOtherTeam")) {
      var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getOtherTeam")]](var_1.owner.team);
    }

    if(isDefined(var_5)) {
      thread nuke_warnenemiesnukeincoming(level);
    }
  } else if(!istrue(level.ref_11bd4)) {
    var_4 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var_1, undefined, undefined, undefined, undefined, "ks_remote_nuke_mp", 0);
  } else {
    var_4 = 1;
  }

  if(!istrue(var_4) || level.gameended) {
    level.nukeincoming = undefined;
    level.ref_11f14 = undefined;
    var_2 notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_2)) {
      level.nukeincoming = undefined;
      level.ref_11f14 = undefined;
      var_2 notify("killstreak_finished_with_deploy_weapon");
      return false;
    }
  }

  thread nuke_start(var_2, 0, undefined, undefined, var_4, undefined, var_4);

  if(var_3 != 1 && !istrue(level.ref_11bd4)) {
    scripts\common\utility::ref_13e0a(level.ref_11b2a, "nuke", self.origin);
  }

  return true;
}

function weapongivennuke(var_0) {
  return true;
}

function weaponswitchendednuke(var_0, var_1) {
  if(istrue(var_1)) {
    thread scripts\cp_mp\killstreaks\airstrike::airstrike_watchforads(var_0, "splash_icon_nuke");
    return;
  }
}

function weaponfirednuke(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\killstreaks\airstrike::airstrike_getownerlookatpos(self);

  if(!isDefined(var_3)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/INVALID_POINT");
    }

    return "continue";
  }

  return "success";
}

function nuke_delaythread(var_0, var_1, var_2, var_3) {
  level endon("nuke_cancelled");

  if(isDefined(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "hostmigration_waitLongDurationWithPause")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "hostmigration_waitLongDurationWithPause")]](var_0);
    }
  }

  level thread[[var_1]](var_2, var_3);
}

function nuke_start(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("nuke_cancelled");
  level notify("used_nuke");
  self notify("used_nuke");
  var_0 notify("killstreak_finished_with_deploy_weapon", 1);
  level.nukeinfo = spawnStruct();

  if(isPlayer(self)) {
    level.nukeinfo.player = self;
  }

  level.nukeinfo.team = self.pers["team"];
  level.nukevisionset = "aftermath_post";
  level.cancelmode = 0;
  level.nukegameover = undefined;
  level.nukedetonated = undefined;
  level.nukecancel = undefined;
  var_8 = 0;
  var_9 = self.origin + (0, 0, 30000) + anglesToForward(self.angles) * 30000;
  var_10 = self.origin + anglesToForward(self.angles) * 15000;

  if(isDefined(level.nuke_expl_struct)) {
    var_10 = level.nuke_expl_struct.origin;
    var_11 = vectorNormalize((var_10[0], var_10[1], 0) - (self.origin[0], self.origin[1], 0));
    var_9 = var_10 + var_11 * 15000;
    var_9 = var_9 + (0, 0, 30000) + var_11 * 5000;
  } else if(var_0.streakname != "nuke_select_location") {}

  var_12 = 6;
  var_13 = 10;
  var_14 = 1;

  if(istrue(var_1)) {
    var_8 = var_1;

    if(istrue(var_8)) {
      level.cancelmode = 1;
    }
  }

  if(isDefined(var_3)) {
    var_9 = var_3;
  }

  if(isDefined(var_4)) {
    var_10 = var_4;
  }

  if(istrue(var_5)) {
    var_12 = var_5;
  }

  if(istrue(var_6)) {
    var_13 = var_6;
  }

  if(istrue(var_2)) {
    var_14 = var_2;
  }

  if(!isDefined(level.nuke_clockobject)) {
    level.nuke_clockobject = spawn("script_origin", var_9 + (0, 0, 100));
    level.nuke_clockobject dontinterpolate();
    level.nuke_clockobject hide();
  } else {
    level.nuke_clockobject.origin = var_9 + (0, 0, 100);
  }

  level.nuke_inflictor = spawn("script_model", var_10 + (0, 0, 5000));
  level.nuke_inflictor setModel("tag_origin");
  level.nuke_inflictor.team = self.team;
  level.nuke_inflictor.owner = self;
  level.nuke_inflictor.streakinfo = var_0;

  if(istrue(level.ref_11bd4)) {
    var_12 = 0.7;
  }

  thread nuke_startlaunchsequence(level, self, var_0, var_14, var_9, var_10, var_12, var_13);
  var_0.nukegoalpoint = var_10;
  var_15 = var_12 + var_13;

  if(isDefined(var_0.nuketype) && var_0.nuketype == 1) {
    thread nuke_delaythread(level, var_15, &nuke_createradiationzone, self);
  }

  thread nuke_delaythread(level, var_15, &nuke_slowmo, self);
  thread nuke_delaythread(level, var_15, &nuke_explosion, self);
  thread nuke_delaythread(level, var_15, &nuke_earthquake, self);
  thread nuke_delaythread(level, var_15 + 0.075, &nuke_vision, self);
  thread nuke_delaythread(level, var_15 + 5, &nuke_death, self);

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](var_0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "addTeamRankXPMultiplier")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "addTeamRankXPMultiplier")]](2, level.nukeinfo.team, "nuke");
  }

  if(level.cancelmode && var_8) {
    thread nuke_watchownerdisconnect(level);
    return;
  }
}

function nuke_watchownerdisconnect(var_0) {
  if(!isDefined(level.ref_11ef8)) {
    createheadiconatorigin("nuke");
    level.ref_11ef8 = 1;
  }

  level endon("game_ended");
  var_0 waittill("disconnect");
  ref_11ede();
}

function ref_11ede() {
  level.nukecancel = 1;
  level.nukeincoming = undefined;
  level.ref_11f14 = undefined;
  nuke_cleartimer();
  setslowmotion(1, 1, 0);
  level notify("nuke_cancelled");
}

function nuke_starttimer(var_0) {
  level endon("nuke_cancelled");

  if(istrue(level.ref_11bd4)) {
    _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 9, 2, 2);
  } else {
    _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 9, 2, 1);
  }

  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 11, 1, 1);
  thread nuke_updateuitimers(level);
  var_1 = var_0;
  var_2 = 0;
  var_3 = 0;

  while(var_1 > 0) {
    if(var_1 <= 10) {
      level.nuke_clockobject playSound("iw8_nuke_countdown");

      if(isDefined(level.nuke_missile) && !istrue(var_2)) {
        thread nuke_startmissileflightaudio();
        var_2 = 1;
      }
    }

    if(var_1 <= 4.9) {
      if(isDefined(level.nuke_missile) && !istrue(var_3)) {
        level.nuke_missile playsoundonmovingent("iw8_nuke_incoming");
        var_3 = 1;
      }
    }

    wait 1;
    var_1--;
  }
}

function nuke_startmissileflightaudio() {
  level.nuke_missile endon("death");
  level endon("game_ended");
  level.nuke_missile playLoopSound("iw8_nuke_flight_loop");
  wait 7;
  level.nuke_missile stoploopsound("iw8_nuke_flight_loop");
}

function nuke_cleartimer() {
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 11, 1, 0);
}

function nuke_startlaunchsequence(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread nuke_startprelaunchalarm(level, var_5, var_1);

  if(isPlayer(var_0) && var_0 ispcplayer()) {
    var_0 setclientomnvar("nVidiaHighlights_events", 15);
  }

  if(var_1.streakname != "nuke_select_location") {
    var_8 = "";

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
      var_8 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();
    }

    var_9 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "stopTheClock")) {
      var_9 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "stopTheClock")]](var_8);
    }

    if(isDefined(var_9)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "setOverTimeLimitDvar")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "setOverTimeLimitDvar")]](var_9);
      }
    }

    level.dontendonscore = 1;

    foreach(var_11 in level.players) {
      if(isDefined(var_11)) {
        var_11 notify("abort_killcam");
        var_11.cancelkillcam = 1;
      }
    }

    thread ref_11edc();
    level.loadoutdefaultfiresalediscount = 1;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "hostmigration_waitLongDurationWithPause")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "hostmigration_waitLongDurationWithPause")]](var_5);
  }

  playsoundatpos(var_3, "iw8_nuke_dist_launch");
  thread nuke_launchmissile(level, var_0, var_1, var_3, var_4, var_6);
}

function nuke_startprelaunchalarm(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = 0;

  if(isDefined(var_1) && isDefined(var_2)) {
    var_2 thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var_1.streakname, 1, 1);
  }

  while(var_0 > 0) {
    if(isDefined(level.nuke_clockobject) && !istrue(var_3)) {
      level.nuke_clockobject playSound("iw8_nuke_alarm");
      var_3 = 1;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "hostmigration_waitLongDurationWithPause")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "hostmigration_waitLongDurationWithPause")]](2);
    }

    var_0 -= 2;
  }
}

function nuke_launchmissile(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  var_6 = var_4;
  thread nuke_starttimer(level);

  if(isDefined(var_0) && isPlayer(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_nuke", var_0);
    }
  }

  var_7 = "nuke_mp";

  if(isDefined(var_5)) {
    var_7 = var_5;
  }

  var_8 = (0, 0, -1 * getdvarint("NPOQPMP", 800));
  var_9 = (var_3 - 0.5 * var_8 * squared(var_4) - var_2) / var_4;
  level.nuke_missile = magicgrenademanual(var_7, var_2, var_9, var_4);
  level.nuke_missile setscriptablepartstate("launch", "on", 0);
}

function nuke_findunobstructedfiringinfo(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_4 = physics_createcontents(["physicscontents_solid", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var_5 = -2000;
  var_6 = 2000;
  var_7 = (0, 0, -1 * getdvarint("NPOQPMP", 800));

  for(;;) {
    var_8 = var_0;
    var_9 = var_8 + (0, 0, 5000);

    if(scripts\engine\trace::ray_trace_passed(var_8, var_9, undefined, var_4)) {
      var_10 = (var_1 - 0.5 * var_7 * squared(var_2) - var_8) / var_2;
      var_3.sourcepos = var_8;
      var_3.goalpos = var_1;
      var_3.initvelocity = var_10;
      break;
    }

    var_8 += anglestoright(self.angles) * randomintrange(var_5, var_6);
    var_5 = int(var_5 * 1.3);
    var_6 = int(var_6 * 1.3);
    waitframe();
  }

  return var_3;
}

function nuke_explosion(var_0, var_1) {
  level endon("nuke_cancelled");
  nuke_cleartimer();
  level.nukedetonated = 1;
  level notify("nuke_detonated");
  level.nuke_explosionpos = level.nuke_missile.origin;
  level.nuke_missile setscriptablepartstate("launch", "off", 0);
  level.nuke_missile delete();
  var_2 = spawn("script_model", level.nuke_explosionpos);
  var_2 setModel("ks_nuke_mp");
  var_2 setscriptablepartstate("explode", "on", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("entity", "delayEntDelete")) {
    var_2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "delayEntDelete")]](50);
  }

  thread nuke_startexplosionaudio(level.nuke_explosionpos);
  jumpiffalse(var_1.streakname != "nuke_select_location") LOC_0000012d;

  foreach(var_4 in level.characters) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "cankill")]](var_4, nuke_cankilleverything())) {
      if(isPlayer(var_4)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
          if([[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](var_4)) {
            thread nuke_startnukedeathfx();
          }
        }
      }
    }
  }

  return;
}

function nuke_startexplosionaudio(var_0) {
  foreach(var_2 in level.players) {
    var_2 setsoundsubmix("mp_killstreak_nuke", 6);
  }

  playsoundatpos(var_0, "iw8_nuke_impact_low");
  playsoundatpos(var_0, "iw8_nuke_incoming_blast_wave");
  playsoundatpos(var_0, "iw8_nuke_blast");
}

function nuke_slowmo(var_0, var_1) {
  if(var_1.streakname == "nuke_select_location") {
    return;
  }

  level endon("nuke_cancelled");
  setnuketimescalefactor();
  level waittill("nuke_death");
  setslowmotion(1, 0.25, 0.1);
}

function setnuketimescalefactor() {
  if(!isDefined(level.ref_11ef8)) {
    createheadiconatorigin("nuke");
    level.ref_11ef8 = 1;
    return;
  }
}

function nuke_dof(var_0, var_1) {
  level endon("nuke_cancelled");

  foreach(var_3 in level.players) {
    thread nuke_adjustexplosiondof();
  }
}

function nuke_adjustexplosiondof() {
  self endon("disconnect");
  self setphysicaldepthoffield(2, 1500);
}

function nuke_vision(var_0, var_1) {
  level endon("nuke_cancelled");
  level.nukevisioninprogress = 1;
  visionsetnaked("nuke_global_flash", 0.05);
  setDvar("r_materialBloomHQScriptMasterEnable", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "hostmigration_waitLongDurationWithPause")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "hostmigration_waitLongDurationWithPause")]](0.5);
  }

  level notify("nuke_aftermath_post_started");
  thread nuke_fadeflashvision(level, 1);
  level waittill("nuke_death");
  thread nuke_updatevisiononhostmigration();
  nuke_setaftermathvision(level, 5);
}

function nuke_fadeflashvision(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "hostmigration_waitLongDurationWithPause")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "hostmigration_waitLongDurationWithPause")]](var_0);
  }

  visionsetnaked("", var_1);
}

function nuke_death(var_0, var_1) {
  level endon("nuke_cancelled");
  level endon("game_ended");
  level notify("nuke_death");
  var_2 = level.nukeinfo.player;

  if(level.teambased) {
    var_2 = level.nuke_inflictor.team;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "hostmigration_waitTillHostMigrationDone")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "hostmigration_waitTillHostMigrationDone")]]();
  }

  var_3 = nuke_cankilleverything();

  if(isDefined(level.nukeinfo.player)) {
    jumpiffalse(var_1.streakname != "nuke_select_location") LOC_00000213;

    foreach(var_5 in level.characters) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "cankill")]](var_5, var_3)) {
        if(isPlayer(var_5)) {
          var_5.nuked = 1;

          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
            if([[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](var_5)) {
              if(!istrue(var_5.ref_12e54)) {
                if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "killPlayerWithAttacker")) {
                  [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "killPlayerWithAttacker")]](var_5);
                }
              }
            }
          }
        }
      }
    }

    if(istrue(var_3)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "destroyActiveObjects")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "destroyActiveObjects")]]();
      }
    } else if(!istrue(level.blocknukekills)) {
      var_7 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getEnemyTeams")) {
        var_7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getEnemyTeams")]](level.nuke_inflictor.team);
      }

      foreach(var_9 in var_7) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "destroyActiveObjects")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "destroyActiveObjects")]](var_9);
        }
      }
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - nuke", level.nukeinfo.player);
    }

    goto LOC_000002b7;
  }

  if(istrue(var_5)) {
    level.nukegameover = 1;
    thread nuke_delayendgame(level, 3);
    return;
  }
}

function nuke_delayendgame(var_0, var_1) {
  level endon("game_ended");
  thread ref_11ef1(level);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "delayEndGame")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "delayEndGame")]](var_0, var_1);
    return;
  }
}

function ref_11ef1(var_0) {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  level notify("play_nuke_bnk");
  setomnvarforallclients("post_game_state", 13);
}

function nuke_earthquake(var_0, var_1) {
  level endon("nuke_cancelled");

  if(!isDefined(level.mapcenter)) {
    var_2 = var_1.nukegoalpoint;
  } else {
    var_2 = level.mapcenter;
  }

  earthquake(0.4, 1.5, var_2, 100000);
  thread nuke_playshockwaveearthquake(level);
  level waittill("nuke_death");

  if(var_2.streakname == "nuke_select_location") {
    earthquake(0.3, 1, var_2, 100000);
  } else {
    earthquake(0.7, 3, var_2, 100000);
  }

  foreach(var_4 in level.players) {
    var_4 playRumbleOnEntity("damage_heavy");
  }
}

function nuke_playshockwaveearthquake(var_0) {
  level endon("nuke_cancelled");
  level endon("nuke_death");
  var_1 = 0.01;

  if(!isDefined(level.mapcenter)) {
    var_2 = var_0.nukegoalpoint;
  } else {}

  for(var_2 = level.mapcenter;; var_2 = 0.3) {
    earthquake(var_2, 0.05, var_2, 100000);
    wait 0.05;
    var_2 += 0.0015;

    if(var_2 >= 0.3) {}
  }
}

function onplayerspawned() {
  if(isDefined(level.nukedetonated)) {
    thread nuke_setvisionforplayer(0, 0);
    return;
  }
}

function nuke_setvisionforplayer(var_0, var_1) {
  if(isDefined(var_0) && var_0 > 0) {
    wait var_0;
  }

  self visionsetnakedforplayer("nuke_global_aftermath", var_1);
}

function nuke_updateuitimers(var_0) {
  level endon("game_ended");
  level endon("disconnect");
  level endon("nuke_cancelled");
  level endon("nuke_death");
  var_1 = var_0 * 1000 + gettime();
  setomnvar("ui_nuke_end_milliseconds", var_1);
  level waittill("host_migration_begin");
  var_2 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "hostmigration_waitTillHostMigrationDone")) {
    var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "hostmigration_waitLongDurationWithPause")]]();
  }

  if(var_2 > 0) {
    setomnvar("ui_nuke_end_milliseconds", var_1 + var_2);
    return;
  }
}

function nuke_updatevisiononhostmigration() {
  level endon("game_ended");

  for(;;) {
    level waittill("host_migration_end");
    nuke_setaftermathvision(level, 0);
  }
}

function nuke_setaftermathvision(var_0) {
  var_2 = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "shouldNukeEndGame")) {
    var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "shouldNukeEndGame")]]();
  }

  if(!var_2) {
    return;
  }

  if(isDefined(level.nukedeathvisionfunc)) {
    level thread[[level.nukedeathvisionfunc]]();
  }

  ref_11ef4();
}

function ref_11ef4() {
  setomnvarforallclients("post_game_state", 12);

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var_1, 1);
    var_1 setclientomnvar("ui_world_fade", 1);
    var_1 setclienttriggeraudiozonepartialwithfade("nuke_killstreak", 2, "ambient", "ambient_events");
  }

  thread ref_11ef2();
}

function ref_11ef2() {
  level endon("game_ended");
  level waittill("play_nuke_bnk");

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var_1, 0, 1);
  }
}

function nuke_startnukedeathfx() {
  self endon("disconnect");

  if(!istrue(self.ref_12e54)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "enableBurnFX")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "enableBurnFX")]](1, "nuke_active");
    }
  }

  thread nuke_playrollingdeathfx(3.25);
  level waittill("nuke_death");

  if(isDefined(self.burnfxenabled) && self.burnfxenabled > 0) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "disableBurnFX")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "disableBurnFX")]](1, "nuke_active");
    }
  }

  var_0 = 0;

  if(var_0) {
    return;
  }
}

function nuke_startnukedeathfx_chooselocationversion() {
  self endon("disconnect");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "enableBurnFX")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "enableBurnFX")]](1, "nuke_active");
  }

  thread nuke_playrollingdeathfx(3.25);
  level waittill("nuke_death");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "disableBurnFX")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "disableBurnFX")]](1, "nuke_active");
    return;
  }
}

function nuke_playrollingdeathfx(var_0) {
  self endon("disconnect");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "hostmigration_waitLongDurationWithPause")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "hostmigration_waitLongDurationWithPause")]](var_0);
  }

  if(!scripts\cp_mp\utility\player_utility::isusingremote()) {
    self visionsetnakedforplayer("nuke_deathblur", 4);
  }

  var_1 = self.origin;
  var_2 = level.nuke_explosionpos;
  var_3 = var_1;
  var_4 = "nuke_rolling_death";
  playFX(scripts\engine\utility::getfx(var_4), var_1, var_2 - var_3, undefined, self);
}

function nuke_atomizebody() {
  self endon("disconnect");
  GscBinSkip1(0x45, 0, 0, "org", self gettagorigin("j_spineupper"));
}

function nuke_cankilleverything() {
  var_0 = 1;
  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();
  }

  if(isDefined(var_1) && var_1 == "br") {
    var_0 = 0;
  }

  return var_0;
}

function nuke_createradiationzone(var_0, var_1) {
  if(!scripts\common\utility::iscp()) {
    if(false) {
      wait 10;
      playFX(scripts\engine\utility::getfx("vfx_nuke_zone_5000_static_s"), (0, 0, 0));
      nuke_registerradzone((0, 0, 0));

      if(!isDefined(level.nukedangerzones)) {
        level.nukedangerzones = [];
      }

      level.nukedangerzones[level.nukedangerzones.size] = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_1.nukegoalpoint - (0, 0, 1000), 5000, 15000, "axis", 4000);
      level.nukedangerzones[level.nukedangerzones.size] = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_1.nukegoalpoint - (0, 0, 1000), 5000, 15000, "allies", 4000);
    } else {
      var_1.sealevelorigin = (var_1.nukegoalpoint[0], var_1.nukegoalpoint[1], scripts\cp_mp\parachute::getc130sealevel());
      playFX(scripts\engine\utility::getfx("vfx_nuke_zone_5000_static_s"), var_1.sealevelorigin);
      nuke_registerradzone(var_1.sealevelorigin);

      if(!isDefined(level.nukedangerzones)) {
        level.nukedangerzones = [];
      }

      level.nukedangerzones[level.nukedangerzones.size] = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_1.nukegoalpoint - (0, 0, 1000), 5000, 15000, "axis", 4000);
      level.nukedangerzones[level.nukedangerzones.size] = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_1.nukegoalpoint - (0, 0, 1000), 5000, 15000, "allies", 4000);
    }
  }

  thread nuke_finalizelocationnuke(var_0);
}

function nuke_registerradzone(var_0) {
  if(!isDefined(level.radzones)) {
    level.radzones = [];
    thread nuke_radzones_think();
  }

  level.radzones[level.radzones.size] = var_0;
}

function nuke_removeradzone(var_0) {
  level.radzones = scripts\engine\utility::array_remove(level.radzones, var_0);
}

function nuke_radzones_think() {
  level endon("game_ended");
  var_0 = 10;

  for(;;) {
    foreach(var_2 in level.players) {
      var_2.inradzone = 0;

      foreach(var_4 in level.radzones) {
        var_5 = 0;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "isPlayerInRadZone")) {
          var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "isPlayerInRadZone")]](var_2, var_4, 25000000);
        }

        if(var_5) {
          if(istrue(var_2.gasmaskequipped)) {
            var_2 scripts\cp_mp\gasmask::processdamage(var_0);
          } else {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "tutorialPrint")) {
              var_2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "tutorialPrint")]]("MP/NUKE_RADIATION_HURT", 2);
            }

            var_2 dodamage(var_0, var_2.origin, var_2, undefined, "MOD_TRIGGER_HURT");
          }

          var_2.inradzone = 1;
          break;
        }
      }

      if(var_2.inradzone) {
        continue;
      }

      foreach(var_4 in level.radzones) {
        var_5 = 0;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "isPlayerInRadZone")) {
          var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "isPlayerInRadZone")]](var_2, var_4, 36000000);
        }

        if(var_5) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "tutorialPrint")) {
            var_2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "tutorialPrint")]]("MP/NUKE_RADIATION_WARNING", 2);
          }

          break;
        }
      }
    }

    wait 1;
  }
}

function nuke_warnenemiesnukeincoming(var_0) {
  level endon("nuke_death");

  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2.team == var_0) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "tutorialPrint")) {
          var_2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "tutorialPrint")]]("MP/NUKE_SELECT_LAUNCH_DETECTED", 2);
        }
      }
    }

    wait 1;
  }
}

function nuke_finalizelocationnuke(var_0) {
  wait 20;

  if(istrue(var_0.hasnukeselectks)) {
    var_0.hasnukeselectks = 0;
  }

  if(isDefined(var_0.killcountthislife)) {
    var_0.killcountthislife = 0;
  }

  visionsetnaked("", 1);
}

function ref_11edc() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_0);

    if(isDefined(var_0)) {
      var_0 notify("abort_killcam");
      var_0.cancelkillcam = 1;
    }
  }
}