/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42945.gsc
**************************************/

init() {
  level._effect["emp_third_person_sparks"] = loadfx("vfx/explosion/electrical_sparks_small_emp_runner");

  if(level.multiteambased) {
    for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
      level.teamemped[level.teamnamelist[var_0]] = 0;
    }
  } else {
    level.teamemped["allies"] = 0;
    level.teamemped["axis"] = 0;
  }

  level.empowner = undefined;
  level.empplayer = undefined;
  level.empstreaksdisabled = 0;
  level.empequipmentdisabled = 0;
  level.empassistpoints = 0;
  level.empexodisabled = 0;
  level.emptimeremaining = 0;
  level thread emp_playertracker();
  level.killstreakfuncs["emp"] = ::emp_use;
  level thread onplayerconnect();
}

getmodulelineemp(var_0) {
  var_1 = common_scripts\utility::array_contains(var_0, "emp_streak_kill");
  var_2 = common_scripts\utility::array_contains(var_0, "emp_equipment_kill");
  var_3 = common_scripts\utility::array_contains(var_0, "emp_exo_kill");

  if(!var_1 && !var_2 && !var_3) {
    return "_01";
  }

  if(var_1 && !var_2 && !var_3) {
    return "_02";
  }

  if(!var_1 && var_2 && !var_3) {
    return "_03";
  }

  if(!var_1 && !var_2 && var_3) {
    return "_04";
  }

  if(var_1 && var_2 && !var_3) {
    return "_05";
  }

  if(var_1 && !var_2 && var_3) {
    return "_06";
  }

  if(!var_1 && var_2 && var_3) {
    return "_07";
  }

  return "_08";
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

    if(issystemhacked() && !maps\mp\_utility::_hasperk("specialty_empimmune")) {
      applyemp();
    }

    self waittill("death");

    if(self.team == "spectator" || issystemhacked()) {
      removeemp();
    }
  }
}

issystemhacked() {
  return level.teambased && level.teamemped[self.team] || !level.teambased && isDefined(level.empplayer) && level.empplayer != self;
}

applyemp(var_0) {
  var_1 = 2;

  if(level.empexodisabled) {
    var_1 = 1;

    if(maps\mp\_utility::isaugmentedgamemode()) {
      maps\mp\_utility::playerallowhighjump(0, "emp");
      maps\mp\_utility::playerallowhighjumpdrop(0, "emp");
      maps\mp\_utility::playerallowboostjump(0, "emp");
      maps\mp\_utility::playerallowpowerslide(0, "emp");
      maps\mp\_utility::playerallowdodge(0, "emp");
    }
  }

  self.empscrambleid = maps\mp\gametypes\_scrambler::playersethudempscrambled(level.empendtime, var_1, "emp");
  self digitaldistortsetmaterial("digital_distort_mp");
  self digitaldistortsetparams(1.0, 1.0);
  self.empon = 1;
  self notify("applyEMPkillstreak");
  self setempjammed(1, level.empequipmentdisabled);

  if(isDefined(var_0) && var_0 == "emp_update") {
    self playsoundtoplayer("emp_system_hacked", self);
  }

  thread dynamicdistortion();
  thread playerdelaystartsparkseffect();
}

playerdelaystartsparkseffect() {
  self endon("death");
  self endon("disconnect");
  level endon("emp_update");

  if(!isDefined(self.costume)) {
    self waittill("player_model_set");
  }

  if(!isDefined(self.empfx)) {
    self.empfx = spawnlinkedfx(common_scripts\utility::getfx("emp_third_person_sparks"), self, "j_shoulder_ri");
    triggerfx(self.empfx);
    setfxkillondelete(self.empfx, 1);
  }
}

dynamicdistortion() {
  self notify("dynamicDistortion");
  self endon("death");
  self endon("disconnect");
  self endon("dynamicDistortion");
  wait 0.1;
  var_0 = 0;
  var_1 = 0.55;
  var_2 = 0.2;
  var_3 = var_1 - var_2;
  var_4 = 0.2;
  var_5 = (level.empendtime - gettime()) / 1000 - 0.2;

  while(var_0 < var_5) {
    if(isDefined(self.empon) && !self.empon) {
      break;
    }

    var_6 = (var_5 - var_0) / var_5;
    self digitaldistortsetparams(var_6 * var_3 + var_2, 1.0);
    var_0 = var_0 + var_4;
    wait(var_4);
  }

  self digitaldistortsetparams(0.0, 0.0);
}

removeemp(var_0) {
  if(maps\mp\_utility::isaugmentedgamemode()) {
    maps\mp\_utility::playerallowhighjump(1, "emp");
    maps\mp\_utility::playerallowhighjumpdrop(1, "emp");
    maps\mp\_utility::playerallowboostjump(1, "emp");
    maps\mp\_utility::playerallowpowerslide(1, "emp");
    maps\mp\_utility::playerallowdodge(1, "emp");
  }

  if(isDefined(self.empscrambleid)) {
    maps\mp\gametypes\_scrambler::playersethudempscrambledoff(self.empscrambleid);
    self.empscrambleid = undefined;
  } else if(self.team == "spectator") {
    self setclientomnvar("ui_exo_reboot_end_time", 0);
    self setclientomnvar("ui_exo_reboot_type", 0);
  }

  self digitaldistortsetparams(0.0, 0.0);
  self.empon = undefined;
  self notify("removeEMPkillstreak");
  self setempjammed(0);

  if(isDefined(var_0) && var_0 == "emp_update") {
    self playsoundtoplayer("emp_system_reboot", self);
  }

  if(isDefined(self.empfx)) {
    self.empfx delete();
  }
}

emp_use(var_0, var_1) {
  var_2 = self.pers["team"];

  if(level.teambased) {
    var_3 = level.otherteam[var_2];
    thread emp_jamteam(var_3, var_1);
  } else {
    thread emp_jamplayers(self, var_1);
  }

  maps\mp\_matchdata::logkillstreakevent("emp", self.origin);
  maps\mp\gametypes\_missions::processchallenge("ch_streak_emp", 1);
  return 1;
}

emp_gettimeoutfrommodules(var_0) {
  var_1 = 20.0;

  if(common_scripts\utility::array_contains(var_0, "emp_time_1") && common_scripts\utility::array_contains(var_0, "emp_time_2")) {
    var_1 = 40.0;
  } else if(common_scripts\utility::array_contains(var_0, "emp_time_1") || common_scripts\utility::array_contains(var_0, "emp_time_2")) {
    var_1 = 30.0;
  }

  if(isDefined(level.ishorde) && level.ishorde) {
    return 60.0;
  }

  return var_1;
}

emp_artifacts(var_0) {
  self endon("disconnect");
  self notify("EMP_Artifacts");
  self endon("EMP_Artifacts");

  if(isDefined(level.ishorde) && level.ishorde) {
    wait 0.1;
  }

  self setclientomnvar("ui_hud_static", 2);
  wait(var_0);
  self setclientomnvar("ui_hud_static", 0);
}

emp_jamteam(var_0, var_1) {
  level endon("game_ended");

  if(!isDefined(level.ishorde)) {
    thread maps\mp\_utility::teamplayercardsplash("used_emp", self);
  }

  level notify("EMP_JamTeam" + var_0);
  level endon("EMP_JamTeam" + var_0);
  level.empowner = self;
  var_2 = emp_gettimeoutfrommodules(var_1);

  foreach(var_4 in level.players) {
    var_4 playlocalsound("emp_big_activate");

    if(var_4.team != var_0) {
      continue;
    }
    if(var_4 maps\mp\_utility::_hasperk("specialty_empimmune")) {
      continue;
    }
    if(var_4 maps\mp\_utility::_hasperk("specialty_localjammer")) {
      var_4 setmotiontrackervisible(1);
    }

    var_4 thread emp_artifacts(var_2);
  }

  visionsetnaked("coup_sunblind", 0.1);

  if(common_scripts\utility::array_contains(var_1, "emp_flash")) {
    foreach(var_4 in level.players) {
      if(var_4.team != var_0 || !maps\mp\_utility::isreallyalive(var_4) || isDefined(var_4.usingremote)) {
        continue;
      }
      if(var_4 maps\mp\_utility::_hasperk("specialty_empimmune")) {
        continue;
      }
      var_4 thread maps\mp\_flashgrenades::applyflash(2.5, 0.75);
    }
  }

  wait 0.1;
  visionsetnaked("coup_sunblind", 0);

  if(isDefined(level.nukedetonated)) {
    visionsetnaked(level.nukevisionset, 3.0);
  } else {
    visionsetnaked("", 3.0);
  }

  level.teamemped[var_0] = 1;
  level.empstreaksdisabled = common_scripts\utility::array_contains(var_1, "emp_streak_kill");
  level.empequipmentdisabled = common_scripts\utility::array_contains(var_1, "emp_equipment_kill");
  level.empassistpoints = common_scripts\utility::array_contains(var_1, "emp_assist");
  level.empexodisabled = common_scripts\utility::array_contains(var_1, "emp_exo_kill");
  level notify("emp_update");
  level.empendtime = gettime() + int(var_2 * 1000);

  if(level.empstreaksdisabled) {
    level destroyactivestreakvehicles(self, var_0);
  }

  if(level.empequipmentdisabled) {
    level destroyactiveequipmentvehicles(self, var_0);
  }

  level thread keepemptimeremaining(var_2);
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_2);
  level.teamemped[var_0] = 0;

  foreach(var_4 in level.players) {
    if(var_4.team != var_0) {
      continue;
    }
    if(var_4 maps\mp\_utility::_hasperk("specialty_localjammer")) {
      var_4 setmotiontrackervisible(0);
    }
  }

  level.empowner = undefined;
  level.empstreaksdisabled = 0;
  level.empequipmentdisabled = 0;
  level.empassistpoints = 0;
  level.empexodisabled = 0;
  level notify("emp_update");
}

emp_jamplayers(var_0, var_1) {
  level notify("EMP_JamPlayers");
  level endon("EMP_JamPlayers");
  level.empowner = var_0;
  var_2 = emp_gettimeoutfrommodules(var_1);

  foreach(var_4 in level.players) {
    var_4 playlocalsound("emp_big_activate");

    if(var_4 == var_0) {
      continue;
    }
    if(var_4 maps\mp\_utility::_hasperk("specialty_localjammer")) {
      var_4 setmotiontrackervisible(1);
    }

    var_4 thread emp_artifacts(var_2);
  }

  visionsetnaked("coup_sunblind", 0.1);

  if(common_scripts\utility::array_contains(var_1, "emp_flash")) {
    foreach(var_4 in level.players) {
      if(var_4 == var_0 || !maps\mp\_utility::isreallyalive(var_4) || isDefined(var_4.usingremote)) {
        continue;
      }
      var_4 thread maps\mp\_flashgrenades::applyflash(2.5, 0.75);
    }
  }

  wait 0.1;
  visionsetnaked("coup_sunblind", 0);

  if(isDefined(level.nukedetonated)) {
    visionsetnaked(level.nukevisionset, 3.0);
  } else {
    visionsetnaked("", 3.0);
  }

  level notify("emp_update");
  level.empplayer = var_0;
  level.empplayer thread empplayerffadisconnect();
  level.empstreaksdisabled = common_scripts\utility::array_contains(var_1, "emp_streak_kill");
  level.empequipmentdisabled = common_scripts\utility::array_contains(var_1, "emp_equipment_kill");
  level.empassistpoints = common_scripts\utility::array_contains(var_1, "emp_assist");
  level.empexodisabled = common_scripts\utility::array_contains(var_1, "emp_exo_kill");
  level.empendtime = gettime() + int(var_2 * 1000);

  if(level.empstreaksdisabled) {
    level destroyactivestreakvehicles(var_0);
  }

  if(level.empequipmentdisabled) {
    level destroyactiveequipmentvehicles(var_0);
  }

  level notify("emp_update");
  level thread keepemptimeremaining(var_2);
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_2);

  foreach(var_4 in level.players) {
    if(var_4 == var_0) {
      continue;
    }
    if(var_4 maps\mp\_utility::_hasperk("specialty_localjammer")) {
      var_4 setmotiontrackervisible(0);
    }
  }

  level.empplayer = undefined;
  level.empowner = undefined;
  level.empstreaksdisabled = 0;
  level.empequipmentdisabled = 0;
  level.empassistpoints = 0;
  level.empexodisabled = 0;
  level notify("emp_update");
  level notify("emp_ended");
}

keepemptimeremaining(var_0) {
  level notify("keepEMPTimeRemaining");
  level endon("keepEMPTimeRemaining");
  level endon("emp_ended");

  for(level.emptimeremaining = int(var_0); level.emptimeremaining; level.emptimeremaining--) {
    wait 1.0;
  }
}

empplayerffadisconnect() {
  level endon("EMP_JamPlayers");
  level endon("emp_ended");
  self waittill("disconnect");
  level notify("emp_update");
}

emp_playertracker() {
  for(;;) {
    var_0 = level common_scripts\utility::waittill_any_return_no_endon_death("joined_team", "emp_update", "game_ended");

    foreach(var_2 in level.players) {
      if(var_2.team == "spectator") {
        var_3 = var_2 getspectatingplayer();

        if(!isDefined(var_3) || !var_3 issystemhacked()) {
          var_2 removeemp(var_0);
        }

        continue;
      }

      if(var_2 maps\mp\_utility::_hasperk("specialty_empimmune")) {
        continue;
      }
      if(maps\mp\_utility::isreallyalive(var_2) && var_2 issystemhacked() && !level.gameended) {
        var_2 applyemp(var_0);
        continue;
      }

      var_2 removeemp(var_0);
    }

    if(level.gameended) {
      return;
    }
  }
}

destroyactivevehicles(var_0, var_1) {
  thread destroyactivestreakvehicles(var_0, var_1);
  thread destroyactiveequipmentvehicles(var_0, var_1);
}

destroyactivestreakvehicles(var_0, var_1) {
  thread destroyactivehelis(var_0, var_1);
  thread destroyactivelittlebirds(var_0, var_1);
  thread destroyactiveturrets(var_0, var_1);
  thread destroyactiverockets(var_0, var_1);
  thread destroyactiveuavs(var_0, var_1);
  thread destroyactiveugvs(var_0, var_1);
  thread destroyactiveorbitallasers(var_0, var_1);
  thread destroyactivegoliaths(var_0, var_1);
}

destroyactiveequipmentvehicles(var_0, var_1) {
  thread destroyactivedrones(var_0, var_1);
}

destroyempobjectsinradius(var_0, var_1, var_2, var_3) {
  thread destroyactivehelis(var_0, var_1, var_2, var_3);
  thread destroyactivelittlebirds(var_0, var_1, var_2, var_3);
  thread destroyactiveturrets(var_0, var_1, var_2, var_3);
  thread destroyactiverockets(var_0, var_1, var_2, var_3);
  thread destroyactiveuavs(var_0, var_1, var_2, var_3);
  thread destroyactiveugvs(var_0, var_1, var_2, var_3);
  thread destroyactiveorbitallasers(var_0, var_1, var_2, var_3);
  thread destroyactivedrones(var_0, var_1, var_2, var_3);
}

destroyactivehelis(var_0, var_1, var_2, var_3) {
  var_4 = "MOD_EXPLOSIVE";
  var_5 = "killstreak_emp_mp";
  var_6 = 5000;
  var_7 = level.helis;

  if(isDefined(level.orbitalsupport_planemodel)) {
    var_7[var_7.size] = level.orbitalsupport_planemodel;
  }

  foreach(var_9 in var_7) {
    if(level.teambased && isDefined(var_1)) {
      if(isDefined(var_9.team) && var_9.team != var_1) {
        continue;
      }
    } else if(isDefined(var_9.owner) && var_9.owner == var_0) {
      continue;
    }
    if(isDefined(var_2) && isDefined(var_3)) {
      var_10 = var_2;

      if(distancesquared(var_9.origin, var_2) > var_3 * var_3) {
        continue;
      }
    }

    var_6 = var_9.maxhealth + 1;
    var_9 dodamage(var_6, var_9.origin, var_0, var_0, var_4, var_5);
    wait 0.05;
  }
}

destroyactivelittlebirds(var_0, var_1, var_2, var_3) {
  var_4 = "MOD_EXPLOSIVE";
  var_5 = "killstreak_emp_mp";
  var_6 = 5000;
  var_7 = common_scripts\utility::array_combine(level.planes, level.littlebirds);

  foreach(var_9 in level.carepackagedrones) {
    if(isDefined(var_9.crate)) {
      var_7[var_7.size] = var_9.crate;
    }
  }

  foreach(var_12 in var_7) {
    if(level.teambased && isDefined(var_1)) {
      if(isDefined(var_12.team) && var_12.team != var_1) {
        continue;
      }
    } else if(isDefined(var_12.owner) && var_12.owner == var_0) {
      continue;
    }
    if(isDefined(var_2) && isDefined(var_3)) {
      var_13 = var_2;

      if(distancesquared(var_12.origin, var_2) > var_3 * var_3) {
        continue;
      }
    }

    var_6 = var_12.maxhealth + 1;

    if(isDefined(var_12.cratetype)) {
      var_12 = var_12.enemymodel;
    }

    var_12 dodamage(var_6, var_12.origin, var_0, var_0, var_4, var_5);
    wait 0.05;
  }
}

destroyactiveturrets(var_0, var_1, var_2, var_3) {
  var_4 = "MOD_EXPLOSIVE";
  var_5 = "killstreak_emp_mp";
  var_6 = 5000;

  foreach(var_8 in level.turrets) {
    if(level.teambased && isDefined(var_1)) {
      if(isDefined(var_8.team) && var_8.team != var_1) {
        continue;
      }
    } else if(isDefined(var_8.owner) && var_8.owner == var_0) {
      continue;
    }
    if(isDefined(var_2) && isDefined(var_3)) {
      var_9 = var_2;

      if(distancesquared(var_8.origin, var_2) > var_3 * var_3) {
        continue;
      }
    }

    var_6 = var_8.maxhealth + 1;
    var_8 dodamage(var_6, var_8.origin, var_0, var_0, var_4, var_5);
  }

  if(isDefined(level.ishorde) && level.ishorde) {
    foreach(var_12 in level.players) {
      if(isDefined(var_12.iscarrying) && var_12.iscarrying) {
        var_12 notify("force_cancel_placement");
      }
    }
  }
}

destroyactiverockets(var_0, var_1, var_2, var_3) {
  var_4 = "MOD_EXPLOSIVE";
  var_5 = "killstreak_emp_mp";
  var_6 = 5000;

  foreach(var_8 in level.rockets) {
    if(isDefined(var_8.weaponname) && skiprocketemp(var_8.weaponname)) {
      continue;
    }
    if(level.teambased && isDefined(var_1)) {
      if(isDefined(var_8.team) && var_8.team != var_1) {
        continue;
      }
    } else if(isDefined(var_8.owner) && var_8.owner == var_0) {
      continue;
    }
    if(isDefined(var_2) && isDefined(var_3)) {
      var_9 = var_2;

      if(distancesquared(var_8.origin, var_2) > var_3 * var_3) {
        continue;
      }
    }

    if(shoulddamagerocket(var_8)) {
      var_6 = var_8.maxhealth + 1;
      var_8 dodamage(var_6, var_8.origin, var_0, var_0, var_4, var_5);
    } else {
      playFX(level.remotemissile_fx["explode"], var_8.origin);
      var_8 delete();
    }

    wait 0.05;
  }
}

shoulddamagerocket(var_0) {
  return isDefined(var_0.damagecallback);
}

skiprocketemp(var_0) {
  return var_0 == "orbital_carepackage_pod_mp";
}

destroyactiveuavs(var_0, var_1, var_2, var_3) {
  var_4 = "MOD_EXPLOSIVE";
  var_5 = "killstreak_emp_mp";
  var_6 = 5000;
  var_7 = level.uavmodels;

  if(level.teambased && isDefined(var_1)) {
    var_7 = level.uavmodels[var_1];
  }

  foreach(var_9 in var_7) {
    if(level.teambased && isDefined(var_1)) {} else if(isDefined(var_9.owner) && var_9.owner == var_0) {
      continue;
    }
    if(isDefined(var_2) && isDefined(var_3)) {
      var_10 = var_2;

      if(distancesquared(var_9.origin, var_2) > var_3 * var_3) {
        continue;
      }
    }

    var_6 = var_9.maxhealth + 1;
    var_9 dodamage(var_6, var_9.origin, var_0, var_0, var_4, var_5);
    wait 0.05;
  }
}

destroyactiveugvs(var_0, var_1, var_2, var_3) {
  var_4 = "MOD_EXPLOSIVE";
  var_5 = "killstreak_emp_mp";
  var_6 = 5000;

  foreach(var_8 in level.ugvs) {
    if(level.teambased && isDefined(var_1)) {
      if(isDefined(var_8.team) && var_8.team != var_1) {
        continue;
      }
    } else if(isDefined(var_8.owner) && var_8.owner == var_0) {
      continue;
    }
    if(isDefined(var_2) && isDefined(var_3)) {
      var_9 = var_2;

      if(distancesquared(var_8.origin, var_2) > var_3 * var_3) {
        continue;
      }
    }

    var_6 = var_8.maxhealth + 1;
    var_8 dodamage(var_6, var_8.origin, var_0, var_0, var_4, var_5);
    wait 0.05;
  }
}

destroyactivedrones(var_0, var_1, var_2, var_3) {
  var_4 = "MOD_EXPLOSIVE";
  var_5 = "killstreak_emp_mp";
  var_6 = 5000;
  var_7 = common_scripts\utility::array_combine(level.trackingdrones, level.explosivedrones);

  foreach(var_9 in var_7) {
    if(level.teambased && isDefined(var_1)) {
      if(isDefined(var_9.team) && var_9.team != var_1) {
        continue;
      }
    } else if(isDefined(var_9.owner) && var_9.owner == var_0) {
      continue;
    }
    if(isDefined(var_2) && isDefined(var_3)) {
      var_10 = var_2;

      if(distancesquared(var_9.origin, var_2) > var_3 * var_3) {
        continue;
      }
    }

    var_6 = var_9.maxhealth + 1;
    var_9 dodamage(var_6, var_9.origin, var_0, var_0, var_4, var_5);
  }

  foreach(var_13 in level.grenades) {
    if(!isDefined(var_13.weaponname) || !issubstr(var_13.weaponname, "explosive_drone_mp")) {
      continue;
    }
    if(level.teambased && isDefined(var_1)) {
      if(isDefined(var_13.team) && var_13.team != var_1) {
        continue;
      }
    } else if(isDefined(var_13.owner) && var_13.owner == var_0) {
      continue;
    }
    if(isDefined(var_2) && isDefined(var_3)) {
      var_10 = var_2;

      if(distancesquared(var_13.origin, var_2) > var_3 * var_3) {
        continue;
      }
    }

    var_13 thread maps\mp\_explosive_drone::explosivegrenadedeath();
  }
}

destroyactiveorbitallasers(var_0, var_1, var_2, var_3) {
  var_4 = "MOD_EXPLOSIVE";
  var_5 = "killstreak_emp_mp";
  var_6 = 5000;
  var_7 = (0, 0, 0);
  var_8 = (0, 0, 0);
  var_9 = "";
  var_10 = "";
  var_11 = "";
  var_12 = undefined;

  foreach(var_14 in level.orbital_lasers) {
    if(level.teambased && isDefined(var_1)) {
      if(isDefined(var_14.team) && var_14.team != var_1) {
        continue;
      }
    } else if(isDefined(var_14.owner) && var_14.owner == var_0) {
      continue;
    }
    var_14 notify("death", var_0, var_4, var_5);
    wait 0.05;
  }
}

destroyactivegoliaths(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3 maps\mp\_utility::isjuggernaut()) {
      if(level.teambased && isDefined(var_1)) {
        if(isDefined(var_3.team) && var_3.team != var_1) {
          continue;
        }
      }

      if(isDefined(level.ishorde) && level.ishorde) {
        var_3 maps\mp\_snd_common_mp::snd_message("goliath_self_destruct");
        playFX(common_scripts\utility::getfx("goliath_self_destruct"), var_3.origin, anglestoup(var_3.angles));
        var_3 thread[[level.hordehandlejuggdeath]]();
        continue;
      }

      var_3 thread maps\mp\killstreaks\_juggernaut::playerkillheavyexo(var_3.origin, var_0, "MOD_EXPLOSIVE", "killstreak_goliathsd_mp");
    }
  }
}