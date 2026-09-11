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
  var0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("nuke", self);
  return tryusenukefromstruct(var0);
}

function tryusenukefromstruct(var0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var0)) {
      var0 notify("killstreak_finished_with_deploy_weapon");
      return false;
    }
  }

  if(var0.streakname == "nuke_select_location") {
    var1 = 1;
  } else {
    var1 = 0;
  }

  var1.nuketype = var1;
  var2 = undefined;
  var3 = undefined;

  if(!isDefined(level.nukeincoming)) {
    level.nukeincoming = 1;
    level.ref_11f14 = self;
  } else {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/NUKE_ALREADY_INBOUND");
    }

    return false;
  }

  if(var1 == 1) {
    var4 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(var1, getcompleteweaponname("iw8_spotter_scope_mp", ["spotterscope"]), "weapon_fired", &weapongivennuke, &weaponswitchendednuke, &weaponfirednuke);
    var2 = scripts\cp_mp\killstreaks\airstrike::airstrike_getownerlookatpos(self);
    var3 = 25;
    var5 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getOtherTeam")) {
      var5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getOtherTeam")]](var1.owner.team);
    }

    if(isDefined(var5)) {
      thread nuke_warnenemiesnukeincoming(level);
    }
  } else if(!istrue(level.ref_11bd4)) {
    var4 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var1, undefined, undefined, undefined, undefined, "ks_remote_nuke_mp", 0);
  } else {
    var4 = 1;
  }

  if(!istrue(var4) || level.gameended) {
    level.nukeincoming = undefined;
    level.ref_11f14 = undefined;
    var2 notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var2)) {
      level.nukeincoming = undefined;
      level.ref_11f14 = undefined;
      var2 notify("killstreak_finished_with_deploy_weapon");
      return false;
    }
  }

  thread nuke_start(var2, 0, undefined, undefined, var4, undefined, var4);

  if(var3 != 1 && !istrue(level.ref_11bd4)) {
    scripts\common\utility::ref_13e0a(level.ref_11b2a, "nuke", self.origin);
  }

  return true;
}

function weapongivennuke(var0) {
  return true;
}

function weaponswitchendednuke(var0, var1) {
  if(istrue(var1)) {
    thread scripts\cp_mp\killstreaks\airstrike::airstrike_watchforads(var0, "splash_icon_nuke");
    return;
  }
}

function weaponfirednuke(var0, var1, var2) {
  var3 = scripts\cp_mp\killstreaks\airstrike::airstrike_getownerlookatpos(self);

  if(!isDefined(var3)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/INVALID_POINT");
    }

    return "continue";
  }

  return "success";
}

function nuke_delaythread(var0, var1, var2, var3) {
  level endon("nuke_cancelled");

  if(isDefined(var0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "hostmigration_waitLongDurationWithPause")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "hostmigration_waitLongDurationWithPause")]](var0);
    }
  }

  level thread[[var1]](var2, var3);
}

function nuke_start(var0, var1, var2, var3, var4, var5, var6, var7) {
  level endon("nuke_cancelled");
  level notify("used_nuke");
  self notify("used_nuke");
  var0 notify("killstreak_finished_with_deploy_weapon", 1);
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
  var8 = 0;
  var9 = self.origin + (0, 0, 30000) + anglesToForward(self.angles) * 30000;
  var10 = self.origin + anglesToForward(self.angles) * 15000;

  if(isDefined(level.nuke_expl_struct)) {
    var10 = level.nuke_expl_struct.origin;
    var11 = vectorNormalize((var10[0], var10[1], 0) - (self.origin[0], self.origin[1], 0));
    var9 = var10 + var11 * 15000;
    var9 = var9 + (0, 0, 30000) + var11 * 5000;
  } else if(var0.streakname != "nuke_select_location") {}

  var12 = 6;
  var13 = 10;
  var14 = 1;

  if(istrue(var1)) {
    var8 = var1;

    if(istrue(var8)) {
      level.cancelmode = 1;
    }
  }

  if(isDefined(var3)) {
    var9 = var3;
  }

  if(isDefined(var4)) {
    var10 = var4;
  }

  if(istrue(var5)) {
    var12 = var5;
  }

  if(istrue(var6)) {
    var13 = var6;
  }

  if(istrue(var2)) {
    var14 = var2;
  }

  if(!isDefined(level.nuke_clockobject)) {
    level.nuke_clockobject = spawn("script_origin", var9 + (0, 0, 100));
    level.nuke_clockobject dontinterpolate();
    level.nuke_clockobject hide();
  } else {
    level.nuke_clockobject.origin = var9 + (0, 0, 100);
  }

  level.nuke_inflictor = spawn("script_model", var10 + (0, 0, 5000));
  level.nuke_inflictor setModel("tag_origin");
  level.nuke_inflictor.team = self.team;
  level.nuke_inflictor.owner = self;
  level.nuke_inflictor.streakinfo = var0;

  if(istrue(level.ref_11bd4)) {
    var12 = 0.7;
  }

  thread nuke_startlaunchsequence(level, self, var0, var14, var9, var10, var12, var13);
  var0.nukegoalpoint = var10;
  var15 = var12 + var13;

  if(isDefined(var0.nuketype) && var0.nuketype == 1) {
    thread nuke_delaythread(level, var15, &nuke_createradiationzone, self);
  }

  thread nuke_delaythread(level, var15, &nuke_slowmo, self);
  thread nuke_delaythread(level, var15, &nuke_explosion, self);
  thread nuke_delaythread(level, var15, &nuke_earthquake, self);
  thread nuke_delaythread(level, var15 + 0.075, &nuke_vision, self);
  thread nuke_delaythread(level, var15 + 5, &nuke_death, self);

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](var0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "addTeamRankXPMultiplier")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "addTeamRankXPMultiplier")]](2, level.nukeinfo.team, "nuke");
  }

  if(level.cancelmode && var8) {
    thread nuke_watchownerdisconnect(level);
    return;
  }
}

function nuke_watchownerdisconnect(var0) {
  if(!isDefined(level.ref_11ef8)) {
    createheadiconatorigin("nuke");
    level.ref_11ef8 = 1;
  }

  level endon("game_ended");
  var0 waittill("disconnect");
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

function nuke_starttimer(var0) {
  level endon("nuke_cancelled");

  if(istrue(level.ref_11bd4)) {
    _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 9, 2, 2);
  } else {
    _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 9, 2, 1);
  }

  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 11, 1, 1);
  thread nuke_updateuitimers(level);
  var1 = var0;
  var2 = 0;
  var3 = 0;

  while(var1 > 0) {
    if(var1 <= 10) {
      level.nuke_clockobject playSound("iw8_nuke_countdown");

      if(isDefined(level.nuke_missile) && !istrue(var2)) {
        thread nuke_startmissileflightaudio();
        var2 = 1;
      }
    }

    if(var1 <= 4.9) {
      if(isDefined(level.nuke_missile) && !istrue(var3)) {
        level.nuke_missile playsoundonmovingent("iw8_nuke_incoming");
        var3 = 1;
      }
    }

    wait 1;
    var1--;
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

function nuke_startlaunchsequence(var0, var1, var2, var3, var4, var5, var6, var7) {
  thread nuke_startprelaunchalarm(level, var5, var1);

  if(isPlayer(var0) && var0 ispcplayer()) {
    var0 setclientomnvar("nVidiaHighlights_events", 15);
  }

  if(var1.streakname != "nuke_select_location") {
    var8 = "";

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
      var8 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();
    }

    var9 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "stopTheClock")) {
      var9 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "stopTheClock")]](var8);
    }

    if(isDefined(var9)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "setOverTimeLimitDvar")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "setOverTimeLimitDvar")]](var9);
      }
    }

    level.dontendonscore = 1;

    foreach(var11 in level.players) {
      if(isDefined(var11)) {
        var11 notify("abort_killcam");
        var11.cancelkillcam = 1;
      }
    }

    thread ref_11edc();
    level.loadoutdefaultfiresalediscount = 1;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "hostmigration_waitLongDurationWithPause")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "hostmigration_waitLongDurationWithPause")]](var5);
  }

  playsoundatpos(var3, "iw8_nuke_dist_launch");
  thread nuke_launchmissile(level, var0, var1, var3, var4, var6);
}

function nuke_startprelaunchalarm(var0, var1, var2) {
  level endon("game_ended");
  var3 = 0;

  if(isDefined(var1) && isDefined(var2)) {
    var2 thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var1.streakname, 1, 1);
  }

  while(var0 > 0) {
    if(isDefined(level.nuke_clockobject) && !istrue(var3)) {
      level.nuke_clockobject playSound("iw8_nuke_alarm");
      var3 = 1;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "hostmigration_waitLongDurationWithPause")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "hostmigration_waitLongDurationWithPause")]](2);
    }

    var0 -= 2;
  }
}

function nuke_launchmissile(var0, var1, var2, var3, var4, var5) {
  level endon("game_ended");
  var6 = var4;
  thread nuke_starttimer(level);

  if(isDefined(var0) && isPlayer(var0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_nuke", var0);
    }
  }

  var7 = "nuke_mp";

  if(isDefined(var5)) {
    var7 = var5;
  }

  var8 = (0, 0, -1 * getdvarint("NPOQPMP", 800));
  var9 = (var3 - 0.5 * var8 * squared(var4) - var2) / var4;
  level.nuke_missile = magicgrenademanual(var7, var2, var9, var4);
  level.nuke_missile setscriptablepartstate("launch", "on", 0);
}

function nuke_findunobstructedfiringinfo(var0, var1, var2) {
  var3 = spawnStruct();
  var4 = physics_createcontents(["physicscontents_solid", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var5 = -2000;
  var6 = 2000;
  var7 = (0, 0, -1 * getdvarint("NPOQPMP", 800));

  for(;;) {
    var8 = var0;
    var9 = var8 + (0, 0, 5000);

    if(scripts\engine\trace::ray_trace_passed(var8, var9, undefined, var4)) {
      var10 = (var1 - 0.5 * var7 * squared(var2) - var8) / var2;
      var3.sourcepos = var8;
      var3.goalpos = var1;
      var3.initvelocity = var10;
      break;
    }

    var8 += anglestoright(self.angles) * randomintrange(var5, var6);
    var5 = int(var5 * 1.3);
    var6 = int(var6 * 1.3);
    waitframe();
  }

  return var3;
}

function nuke_explosion(var0, var1) {
  level endon("nuke_cancelled");
  nuke_cleartimer();
  level.nukedetonated = 1;
  level notify("nuke_detonated");
  level.nuke_explosionpos = level.nuke_missile.origin;
  level.nuke_missile setscriptablepartstate("launch", "off", 0);
  level.nuke_missile delete();
  var2 = spawn("script_model", level.nuke_explosionpos);
  var2 setModel("ks_nuke_mp");
  var2 setscriptablepartstate("explode", "on", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("entity", "delayEntDelete")) {
    var2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "delayEntDelete")]](50);
  }

  thread nuke_startexplosionaudio(level.nuke_explosionpos);
  jumpiffalse(var1.streakname != "nuke_select_location") LOC_0000012d;

  foreach(var4 in level.characters) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "cankill")]](var4, nuke_cankilleverything())) {
      if(isPlayer(var4)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
          if([[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](var4)) {
            thread nuke_startnukedeathfx();
          }
        }
      }
    }
  }

  return;
}

function nuke_startexplosionaudio(var0) {
  foreach(var2 in level.players) {
    var2 setsoundsubmix("mp_killstreak_nuke", 6);
  }

  playsoundatpos(var0, "iw8_nuke_impact_low");
  playsoundatpos(var0, "iw8_nuke_incoming_blast_wave");
  playsoundatpos(var0, "iw8_nuke_blast");
}

function nuke_slowmo(var0, var1) {
  if(var1.streakname == "nuke_select_location") {
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

function nuke_dof(var0, var1) {
  level endon("nuke_cancelled");

  foreach(var3 in level.players) {
    thread nuke_adjustexplosiondof();
  }
}

function nuke_adjustexplosiondof() {
  self endon("disconnect");
  self setphysicaldepthoffield(2, 1500);
}

function nuke_vision(var0, var1) {
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

function nuke_fadeflashvision(var0, var1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "hostmigration_waitLongDurationWithPause")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "hostmigration_waitLongDurationWithPause")]](var0);
  }

  visionsetnaked("", var1);
}

function nuke_death(var0, var1) {
  level endon("nuke_cancelled");
  level endon("game_ended");
  level notify("nuke_death");
  var2 = level.nukeinfo.player;

  if(level.teambased) {
    var2 = level.nuke_inflictor.team;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "hostmigration_waitTillHostMigrationDone")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "hostmigration_waitTillHostMigrationDone")]]();
  }

  var3 = nuke_cankilleverything();

  if(isDefined(level.nukeinfo.player)) {
    jumpiffalse(var1.streakname != "nuke_select_location") LOC_00000213;

    foreach(var5 in level.characters) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "cankill")]](var5, var3)) {
        if(isPlayer(var5)) {
          var5.nuked = 1;

          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
            if([[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](var5)) {
              if(!istrue(var5.ref_12e54)) {
                if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "killPlayerWithAttacker")) {
                  [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "killPlayerWithAttacker")]](var5);
                }
              }
            }
          }
        }
      }
    }

    if(istrue(var3)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "destroyActiveObjects")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "destroyActiveObjects")]]();
      }
    } else if(!istrue(level.blocknukekills)) {
      var7 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getEnemyTeams")) {
        var7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getEnemyTeams")]](level.nuke_inflictor.team);
      }

      foreach(var9 in var7) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "destroyActiveObjects")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "destroyActiveObjects")]](var9);
        }
      }
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - nuke", level.nukeinfo.player);
    }

    goto LOC_000002b7;
  }

  if(istrue(var5)) {
    level.nukegameover = 1;
    thread nuke_delayendgame(level, 3);
    return;
  }
}

function nuke_delayendgame(var0, var1) {
  level endon("game_ended");
  thread ref_11ef1(level);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "delayEndGame")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "delayEndGame")]](var0, var1);
    return;
  }
}

function ref_11ef1(var0) {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);
  level notify("play_nuke_bnk");
  setomnvarforallclients("post_game_state", 13);
}

function nuke_earthquake(var0, var1) {
  level endon("nuke_cancelled");

  if(!isDefined(level.mapcenter)) {
    var2 = var1.nukegoalpoint;
  } else {
    var2 = level.mapcenter;
  }

  earthquake(0.4, 1.5, var2, 100000);
  thread nuke_playshockwaveearthquake(level);
  level waittill("nuke_death");

  if(var2.streakname == "nuke_select_location") {
    earthquake(0.3, 1, var2, 100000);
  } else {
    earthquake(0.7, 3, var2, 100000);
  }

  foreach(var4 in level.players) {
    var4 playRumbleOnEntity("damage_heavy");
  }
}

function nuke_playshockwaveearthquake(var0) {
  level endon("nuke_cancelled");
  level endon("nuke_death");
  var1 = 0.01;

  if(!isDefined(level.mapcenter)) {
    var2 = var0.nukegoalpoint;
  } else {}

  for(var2 = level.mapcenter;; var2 = 0.3) {
    earthquake(var2, 0.05, var2, 100000);
    wait 0.05;
    var2 += 0.0015;

    if(var2 >= 0.3) {}
  }
}

function onplayerspawned() {
  if(isDefined(level.nukedetonated)) {
    thread nuke_setvisionforplayer(0, 0);
    return;
  }
}

function nuke_setvisionforplayer(var0, var1) {
  if(isDefined(var0) && var0 > 0) {
    wait var0;
  }

  self visionsetnakedforplayer("nuke_global_aftermath", var1);
}

function nuke_updateuitimers(var0) {
  level endon("game_ended");
  level endon("disconnect");
  level endon("nuke_cancelled");
  level endon("nuke_death");
  var1 = var0 * 1000 + gettime();
  setomnvar("ui_nuke_end_milliseconds", var1);
  level waittill("host_migration_begin");
  var2 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "hostmigration_waitTillHostMigrationDone")) {
    var2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "hostmigration_waitLongDurationWithPause")]]();
  }

  if(var2 > 0) {
    setomnvar("ui_nuke_end_milliseconds", var1 + var2);
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

function nuke_setaftermathvision(var0) {
  var2 = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "shouldNukeEndGame")) {
    var2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "shouldNukeEndGame")]]();
  }

  if(!var2) {
    return;
  }

  if(isDefined(level.nukedeathvisionfunc)) {
    level thread[[level.nukedeathvisionfunc]]();
  }

  ref_11ef4();
}

function ref_11ef4() {
  setomnvarforallclients("post_game_state", 12);

  foreach(var1 in level.players) {
    if(!isDefined(var1)) {
      continue;
    }

    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var1, 1);
    var1 setclientomnvar("ui_world_fade", 1);
    var1 setclienttriggeraudiozonepartialwithfade("nuke_killstreak", 2, "ambient", "ambient_events");
  }

  thread ref_11ef2();
}

function ref_11ef2() {
  level endon("game_ended");
  level waittill("play_nuke_bnk");

  foreach(var1 in level.players) {
    if(!isDefined(var1)) {
      continue;
    }

    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var1, 0, 1);
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

  var0 = 0;

  if(var0) {
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

function nuke_playrollingdeathfx(var0) {
  self endon("disconnect");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "hostmigration_waitLongDurationWithPause")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "hostmigration_waitLongDurationWithPause")]](var0);
  }

  if(!scripts\cp_mp\utility\player_utility::isusingremote()) {
    self visionsetnakedforplayer("nuke_deathblur", 4);
  }

  var1 = self.origin;
  var2 = level.nuke_explosionpos;
  var3 = var1;
  var4 = "nuke_rolling_death";
  playFX(scripts\engine\utility::getfx(var4), var1, var2 - var3, undefined, self);
}

function nuke_atomizebody() {
  self endon("disconnect");
  GscBinSkip1(0x45, 0, 0, "org", self gettagorigin("j_spineupper"));
}

function nuke_cankilleverything() {
  var0 = 1;
  var1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();
  }

  if(isDefined(var1) && var1 == "br") {
    var0 = 0;
  }

  return var0;
}

function nuke_createradiationzone(var0, var1) {
  if(!scripts\common\utility::iscp()) {
    if(false) {
      wait 10;
      playFX(scripts\engine\utility::getfx("vfx_nuke_zone_5000_static_s"), (0, 0, 0));
      nuke_registerradzone((0, 0, 0));

      if(!isDefined(level.nukedangerzones)) {
        level.nukedangerzones = [];
      }

      level.nukedangerzones[level.nukedangerzones.size] = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var1.nukegoalpoint - (0, 0, 1000), 5000, 15000, "axis", 4000);
      level.nukedangerzones[level.nukedangerzones.size] = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var1.nukegoalpoint - (0, 0, 1000), 5000, 15000, "allies", 4000);
    } else {
      var1.sealevelorigin = (var1.nukegoalpoint[0], var1.nukegoalpoint[1], scripts\cp_mp\parachute::getc130sealevel());
      playFX(scripts\engine\utility::getfx("vfx_nuke_zone_5000_static_s"), var1.sealevelorigin);
      nuke_registerradzone(var1.sealevelorigin);

      if(!isDefined(level.nukedangerzones)) {
        level.nukedangerzones = [];
      }

      level.nukedangerzones[level.nukedangerzones.size] = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var1.nukegoalpoint - (0, 0, 1000), 5000, 15000, "axis", 4000);
      level.nukedangerzones[level.nukedangerzones.size] = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var1.nukegoalpoint - (0, 0, 1000), 5000, 15000, "allies", 4000);
    }
  }

  thread nuke_finalizelocationnuke(var0);
}

function nuke_registerradzone(var0) {
  if(!isDefined(level.radzones)) {
    level.radzones = [];
    thread nuke_radzones_think();
  }

  level.radzones[level.radzones.size] = var0;
}

function nuke_removeradzone(var0) {
  level.radzones = scripts\engine\utility::array_remove(level.radzones, var0);
}

function nuke_radzones_think() {
  level endon("game_ended");
  var0 = 10;

  for(;;) {
    foreach(var2 in level.players) {
      var2.inradzone = 0;

      foreach(var4 in level.radzones) {
        var5 = 0;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "isPlayerInRadZone")) {
          var5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "isPlayerInRadZone")]](var2, var4, 25000000);
        }

        if(var5) {
          if(istrue(var2.gasmaskequipped)) {
            var2 scripts\cp_mp\gasmask::processdamage(var0);
          } else {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "tutorialPrint")) {
              var2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "tutorialPrint")]]("MP/NUKE_RADIATION_HURT", 2);
            }

            var2 dodamage(var0, var2.origin, var2, undefined, "MOD_TRIGGER_HURT");
          }

          var2.inradzone = 1;
          break;
        }
      }

      if(var2.inradzone) {
        continue;
      }

      foreach(var4 in level.radzones) {
        var5 = 0;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "isPlayerInRadZone")) {
          var5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "isPlayerInRadZone")]](var2, var4, 36000000);
        }

        if(var5) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "tutorialPrint")) {
            var2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "tutorialPrint")]]("MP/NUKE_RADIATION_WARNING", 2);
          }

          break;
        }
      }
    }

    wait 1;
  }
}

function nuke_warnenemiesnukeincoming(var0) {
  level endon("nuke_death");

  for(;;) {
    foreach(var2 in level.players) {
      if(var2.team == var0) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "tutorialPrint")) {
          var2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "tutorialPrint")]]("MP/NUKE_SELECT_LAUNCH_DETECTED", 2);
        }
      }
    }

    wait 1;
  }
}

function nuke_finalizelocationnuke(var0) {
  wait 20;

  if(istrue(var0.hasnukeselectks)) {
    var0.hasnukeselectks = 0;
  }

  if(isDefined(var0.killcountthislife)) {
    var0.killcountthislife = 0;
  }

  visionsetnaked("", 1);
}

function ref_11edc() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var0);

    if(isDefined(var0)) {
      var0 notify("abort_killcam");
      var0.cancelkillcam = 1;
    }
  }
}