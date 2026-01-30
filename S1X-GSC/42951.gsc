/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42951.gsc
**************************************/

init() {
  level._effect["nuke_flash"] = loadfx("vfx/explosion/dna_bomb_flash_mp");
  level._effect["nuke_aftermath"] = loadfx("vfx/dust/nuke_aftermath_mp");
  level._effect["dna_bomb_body_gas"] = loadfx("vfx/explosion/dna_bomb_body_gas");
  game["strings"]["nuclear_strike"] = &"KILLSTREAKS_TACTICAL_NUKE";
  level.killstreakfuncs["nuke"] = ::tryusenuke;
  level.killstreakwieldweapons["nuke_mp"] = "nuke";
  setdvarifuninitialized("scr_nukeTimer", 10);
  setdvarifuninitialized("scr_nukeCancelMode", 0);
  level.nuketimer = getdvarint("scr_nukeTimer");
  level.cancelmode = getdvarint("scr_nukeCancelMode");
  level.nukeemptimeout = 60.0;
  level.nukeemptimeremaining = int(level.nukeemptimeout);
  level.nukeinfo = spawnStruct();
  level.nukeinfo.xpscalar = 2;
  level.nukedetonated = undefined;
  level thread onplayerconnect();
}

tryusenuke(var_0, var_1, var_2) {
  if(isDefined(level.nukeincoming)) {
    self iprintlnbold(&"KILLSTREAKS_NUKE_ALREADY_INBOUND");
    return 0;
  }

  if(maps\mp\_utility::isusingremote()) {
    return 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  thread donuke(var_2);
  maps\mp\_matchdata::logkillstreakevent("nuke", self.origin);
  return 1;
}

delaythread_nuke(var_0, var_1) {
  level endon("nuke_cancelled");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  thread[[var_1]]();
}

donuke(var_0) {
  level endon("nuke_cancelled");
  level.nukeinfo.player = self;
  level.nukeinfo.team = self.pers["team"];
  level.nukeincoming = 1;
  setomnvar("ui_bomb_timer", 4);

  if(level.teambased) {
    thread maps\mp\_utility::teamplayercardsplash("used_nuke", self, self.team);
  } else if(!level.hardcoremode) {
    self iprintlnbold(&"MP_FRIENDLY_TACTICAL_NUKE");
  }

  level thread delaythread_nuke(level.nuketimer - 3.3, ::nukesoundincoming);
  level thread delaythread_nuke(level.nuketimer, ::nukesoundexplosion);
  level thread delaythread_nuke(level.nuketimer, ::nukeslowmo);
  level thread delaythread_nuke(level.nuketimer - 0.32, ::nukeeffects);
  level thread delaythread_nuke(level.nuketimer - 0.1, ::nukevision);
  level thread delaythread_nuke(level.nuketimer + 0.5, ::nukedeath);
  level thread delaythread_nuke(level.nuketimer + 1.5, ::nukeearthquake);
  level thread nukeaftermatheffect();
  level thread update_ui_timers();

  if(level.cancelmode && var_0) {
    level thread cancelnukeondeath(self);
  }

  if(!isDefined(level.nuke_clockobject)) {
    level.nuke_clockobject = spawn("script_origin", (0, 0, 0));
    level.nuke_clockobject hide();
  }

  if(!isDefined(level.nuke_soundobject)) {
    level.nuke_soundobject = spawn("script_origin", (0, 0, 1));
    level.nuke_soundobject hide();
  }

  for(var_1 = level.nuketimer; var_1 > 0; var_1--) {
    level.nuke_clockobject playSound("ks_dna_warn_timer");
    wait 1.0;
  }
}

cancelnukeondeath(var_0) {
  var_0 common_scripts\utility::waittill_any("death", "disconnect");
  setomnvar("ui_bomb_timer", 0);
  level.nukeincoming = undefined;
  level notify("nuke_cancelled");
}

nukesoundincoming() {
  level endon("nuke_cancelled");

  if(isDefined(level.nuke_soundobject)) {
    level.nuke_soundobject playSound("ks_dna_incoming");
  }
}

nukesoundexplosion() {
  level endon("nuke_cancelled");

  if(isDefined(level.nuke_soundobject)) {
    level.nuke_soundobject playSound("ks_dna_explosion");
    level.nuke_soundobject playSound("ks_dna_wave");
  }
}

nukeeffects() {
  level endon("nuke_cancelled");

  foreach(var_1 in level.players) {
    var_2 = anglesToForward(var_1.angles);
    var_2 = (var_2[0], var_2[1], 0);
    var_2 = vectornormalize(var_2);
    var_3 = 300;
    var_4 = spawn("script_model", var_1.origin + var_2 * var_3);
    var_4 setModel("tag_origin");
    var_4.angles = (0, var_1.angles[1] + 180, 90);
    var_4 thread nukeeffect(var_1);
  }
}

nukeeffect(var_0) {
  level endon("nuke_cancelled");
  var_0 endon("disconnect");
  waitframe();
  playfxontagforclients(level._effect["nuke_flash"], self, "tag_origin", var_0);
}

nukeaftermatheffect() {
  level endon("nuke_cancelled");
  level waittill("spawning_intermission");
  var_0 = getEntArray("mp_global_intermission", "classname");
  var_0 = var_0[0];
  var_1 = anglestoup(var_0.angles);
  var_2 = anglestoright(var_0.angles);
  playFX(level._effect["nuke_aftermath"], var_0.origin, var_1, var_2);
}

nukeslowmo() {
  level endon("nuke_cancelled");
  setomnvar("ui_bomb_timer", 0);
  setslowmotion(1.0, 0.25, 0.5);
  level waittill("nuke_death");
  setslowmotion(0.25, 1, 2.0);
}

nukevision() {
  level endon("nuke_cancelled");
  var_0 = "dna_bomb";

  if(isDefined(level.dnavisionset)) {
    var_0 = level.dnavisionset;
  }

  level.nukevisioninprogress = 1;

  foreach(var_2 in level.players) {
    var_2 setclienttriggervisionset(var_0, 0.5);
    var_2 thread maps\mp\_flashgrenades::applyflash(1.6, 0.35);
  }

  level waittill("nuke_death");
  wait 3.0;

  foreach(var_2 in level.players) {
    var_2 setclienttriggervisionset("", 10);
  }

  level.nukevisioninprogress = undefined;
}

nukedeath() {
  level endon("nuke_cancelled");
  level notify("nuke_death");
  maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
  ambientstop(1);
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(level.teambased) {
      if(isDefined(level.nukeinfo.team) && var_2.team == level.nukeinfo.team) {
        continue;
      }
    } else if(isDefined(level.nukeinfo.player) && var_2 == level.nukeinfo.player) {
      continue;
    }
    var_2.nuked = 1;

    if(isalive(var_2)) {
      var_2 thread maps\mp\gametypes\_damage::finishplayerdamagewrapper(level.nukeinfo.player, level.nukeinfo.player, 999999, 0, "MOD_EXPLOSIVE", "nuke_mp", var_2.origin, var_2.origin, "none", 0, 0);

      if(isDefined(var_2.isjuggernaut) && var_2.isjuggernaut == 1) {
        var_2 dodamage(1, var_2.origin, level.nukeinfo.player, level.nukeinfo.player, "MOD_EXPLOSIVE", "nuke_mp");
      }

      maps\mp\_utility::delaythread(var_0 + 1, ::bodygasfx, var_2.body);
      var_0 = var_0 + 0.05;
    }
  }

  level thread nuke_empjam();
  level.nukeincoming = undefined;
}

bodygasfx(var_0) {
  if(isDefined(var_0)) {
    playFXOnTag(common_scripts\utility::getfx("dna_bomb_body_gas"), var_0, "J_SPINELOWER");
  }
}

nukeearthquake() {
  level endon("nuke_cancelled");
  level waittill("nuke_death");
}

nuke_empjam() {
  level endon("game_ended");
  level notify("nuke_EMPJam");
  level endon("nuke_EMPJam");

  if(level.multiteambased) {
    for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
      if(level.nukeinfo.team != level.teamnamelist[var_0]) {
        level maps\mp\killstreaks\_emp::destroyactivevehicles(level.nukeinfo.player, level.teamnamelist[var_0]);
      }
    }
  } else if(level.teambased) {
    level maps\mp\killstreaks\_emp::destroyactivevehicles(level.nukeinfo.player, maps\mp\_utility::getotherteam(level.nukeinfo.team));
  } else {
    level maps\mp\killstreaks\_emp::destroyactivevehicles(level.nukeinfo.player, maps\mp\_utility::getotherteam(level.nukeinfo.team));
  }

  level notify("nuke_emp_update");
  level notify("nuke_emp_update");
  level notify("nuke_emp_ended");
}

keepnukeemptimeremaining() {
  level notify("keepNukeEMPTimeRemaining");
  level endon("keepNukeEMPTimeRemaining");
  level endon("nuke_emp_ended");

  for(level.nukeemptimeremaining = int(level.nukeemptimeout); level.nukeemptimeremaining; level.nukeemptimeremaining--) {
    wait 1.0;
  }
}

nuke_empteamtracker() {
  level endon("game_ended");

  for(;;) {
    level common_scripts\utility::waittill_either("joined_team", "nuke_emp_update");

    foreach(var_1 in level.players) {
      if(var_1.team == "spectator") {
        continue;
      }
      if(level.teambased) {
        if(isDefined(level.nukeinfo.team) && var_1.team == level.nukeinfo.team) {
          continue;
        }
      } else if(isDefined(level.nukeinfo.player) && var_1 == level.nukeinfo.player) {
        continue;
      }
      if(!level.teamnukeemped[var_1.team] && !var_1 maps\mp\_utility::isemped()) {
        var_1 setempjammed(0);
        continue;
      }

      var_1 setempjammed(1);
    }
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");

    if(isDefined(level.nukevisioninprogress)) {
      self setclienttriggervisionset("dna_bomb");
      waitframe();
      self setclienttriggervisionset("", 10);
    }
  }
}

update_ui_timers() {
  level endon("game_ended");
  level endon("disconnect");
  level endon("nuke_cancelled");
  level endon("nuke_death");
  var_0 = level.nuketimer * 1000 + gettime();
  setomnvar("ui_nuke_end_milliseconds", var_0);
  level waittill("host_migration_begin");
  var_1 = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

  if(var_1 > 0) {
    setomnvar("ui_nuke_end_milliseconds", var_0 + var_1);
  }
}