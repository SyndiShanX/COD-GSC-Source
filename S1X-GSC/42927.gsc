/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42927.gsc
**************************************/

init() {
  level.killstreakspawnshield = 5000;
  level.forcebuddyspawn = 0;
  level.supportbuddyspawn = 0;
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  level.clienttracespawnclass = undefined;
  level.disableclientspawntraces = 0;
  level.numplayerswaitingtospawn = 0;
  level.numplayerswaitingtoenterkillcam = 0;
  level.players = [];
  level.participants = [];
  level.characters = [];
  level.spawnpointarray = [];
  level.grenades = [];
  level.missiles = [];
  level.carepackages = [];
  level.turrets = [];
  level.scramblers = [];
  level.ugvs = [];
  level.trackingdrones = [];
  level.explosivedrones = [];
  level thread onplayerconnect();
  level thread spawnpointupdate();
  level thread trackgrenades();
  level thread trackmissiles();
  level thread trackcarepackages();
  level thread trackhostmigrationend();

  for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
    level.teamspawnpoints[level.teamnamelist[var_0]] = [];
  }
}

trackhostmigrationend() {
  for(;;) {
    self waittill("host_migration_end");

    foreach(var_1 in level.participants) {
      var_1.canperformclienttraces = canperformclienttraces(var_1);
    }
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    level thread startclientspawnpointtraces(var_0);
  }
}

startclientspawnpointtraces(var_0) {
  var_0 endon("disconnect");
  var_0.canperformclienttraces = canperformclienttraces(var_0);

  if(!var_0.canperformclienttraces) {
    return;
  }
  wait 0.05;
  var_0 setclientspawnsighttraces(level.clienttracespawnclass);
}

canperformclienttraces(var_0) {
  if(level.disableclientspawntraces || isDefined(level.skipspawnsighttraces) && level.skipspawnsighttraces) {
    return 0;
  }

  if(!isDefined(level.clienttracespawnclass)) {
    return 0;
  }

  if(isai(var_0) || istestclient(var_0)) {
    return 0;
  }

  if(var_0 ishost()) {
    if(getdvarint("enableS1TUSpawnSightTraces") > 0) {
      return 1;
    } else {
      return 0;
    }
  }

  return 1;
}

addstartspawnpoints(var_0) {
  var_1 = getspawnpointarray(var_0);

  if(!var_1.size) {
    return;
  }
  if(!isDefined(level.startspawnpoints)) {
    level.startspawnpoints = [];
  }

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_1[var_2] spawnpointinit();
    var_1[var_2].selected = 0;
    level.startspawnpoints[level.startspawnpoints.size] = var_1[var_2];
  }

  foreach(var_4 in var_1) {
    var_4.infront = 1;
    var_5 = anglesToForward(var_4.angles);

    foreach(var_7 in var_1) {
      if(var_4 == var_7) {
        continue;
      }
      var_8 = vectornormalize(var_7.origin - var_4.origin);
      var_9 = vectordot(var_5, var_8);

      if(var_9 > 0.86) {
        var_4.infront = 0;
        break;
      }
    }
  }
}

addspawnpoints(var_0, var_1) {
  if(!isDefined(level.spawnpoints)) {
    level.spawnpoints = [];
  }

  if(!isDefined(level.teamspawnpoints[var_0])) {
    level.teamspawnpoints[var_0] = [];
  }

  var_2 = [];
  var_2 = getspawnpointarray(var_1);

  if(!isDefined(level.clienttracespawnclass)) {
    level.clienttracespawnclass = var_1;
  }

  if(!var_2.size) {
    return;
  }
  foreach(var_4 in var_2) {
    if(!isDefined(var_4.inited)) {
      var_4 spawnpointinit();
      level.spawnpoints[level.spawnpoints.size] = var_4;
    }

    level.teamspawnpoints[var_0][level.teamspawnpoints[var_0].size] = var_4;
  }
}

spawnpointinit() {
  var_0 = self;
  level.spawnmins = expandmins(level.spawnmins, var_0.origin);
  level.spawnmaxs = expandmaxs(level.spawnmaxs, var_0.origin);
  var_0.forward = anglesToForward(var_0.angles);
  var_0.sighttracepoint = var_0.origin + (0, 0, 50);
  var_0.lastspawntime = gettime();
  var_0.outside = 1;
  var_0.inited = 1;
  var_0.alternates = [];
  var_1 = 1024;

  if(!bullettracepassed(var_0.sighttracepoint, var_0.sighttracepoint + (0, 0, var_1), 0, undefined)) {
    var_2 = var_0.sighttracepoint + var_0.forward * 100;

    if(!bullettracepassed(var_2, var_2 + (0, 0, var_1), 0, undefined)) {
      var_0.outside = 0;
    }
  }

  var_3 = anglestoright(var_0.angles);
  addalternatespawnpoint(var_0, var_0.origin + var_3 * 45);
  addalternatespawnpoint(var_0, var_0.origin - var_3 * 45);
  initspawnpointvalues(var_0);
}

addalternatespawnpoint(var_0, var_1) {
  var_2 = playerphysicstrace(var_0.origin, var_0.origin + (0, 0, 18));
  var_3 = var_2[2] - var_0.origin[2];
  var_4 = (var_1[0], var_1[1], var_1[2] + var_3);
  var_5 = playerphysicstrace(var_2, var_4);

  if(var_5 != var_4) {
    return;
  }
  var_6 = droptoground(var_4);

  if(abs(var_6[2] - var_1[2]) > 128) {
    return;
  }
  var_0.alternates[var_0.alternates.size] = var_6;
}

getspawnpointarray(var_0) {
  if(!isDefined(level.spawnpointarray)) {
    level.spawnpointarray = [];
  }

  if(!isDefined(level.spawnpointarray[var_0])) {
    level.spawnpointarray[var_0] = [];
    level.spawnpointarray[var_0] = getspawnarray(var_0);

    foreach(var_2 in level.spawnpointarray[var_0]) {
      var_2.classname = var_0;
    }
  }

  return level.spawnpointarray[var_0];
}

getspawnpoint_random(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = undefined;
  var_0 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns(var_0);
  var_0 = common_scripts\utility::array_randomize(var_0);

  foreach(var_3 in var_0) {
    var_1 = var_3;

    if(canspawn(var_1.origin) && !positionwouldtelefrag(var_1.origin)) {
      break;
    }
  }

  return var_1;
}

getspawnpoint_startspawn(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = undefined;
  var_0 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns(var_0);

  foreach(var_3 in var_0) {
    if(var_3.selected) {
      continue;
    }
    if(var_3.infront) {
      var_1 = var_3;
      break;
    }

    var_1 = var_3;
  }

  if(!isDefined(var_1)) {
    var_1 = getspawnpoint_random(var_0);
  }

  var_1.selected = 1;
  return var_1;
}

getspawnpoint_nearteam(var_0, var_1) {
  for(;;) {
    wait 5;
  }
}

trackgrenades() {
  for(;;) {
    level.grenades = getEntArray("grenade", "classname");
    wait 0.05;
  }
}

trackmissiles() {
  for(;;) {
    level.missiles = getEntArray("rocket", "classname");
    wait 0.05;
  }
}

trackcarepackages() {
  for(;;) {
    level.carepackages = getEntArray("care_package", "targetname");
    wait 0.05;
  }
}

getteamspawnpoints(var_0) {
  return level.teamspawnpoints[var_0];
}

ispathdataavailable() {
  if(!isDefined(level.pathdataavailable)) {
    var_0 = getallnodes();
    level.pathdataavailable = isDefined(var_0) && var_0.size > 150;
  }

  return level.pathdataavailable;
}

addtoparticipantsarray() {
  if(isDefined(level.ishorde) && level.ishorde) {
    level notify("participant_added", self);
  }

  level.participants[level.participants.size] = self;
}

removefromparticipantsarray() {
  var_0 = 0;

  for(var_1 = 0; var_1 < level.participants.size; var_1++) {
    if(level.participants[var_1] == self) {
      for(var_0 = 1; var_1 < level.participants.size - 1; var_1++) {
        level.participants[var_1] = level.participants[var_1 + 1];
      }

      level.participants[var_1] = undefined;
      break;
    }
  }
}

addtocharactersarray() {
  level.characters[level.characters.size] = self;
}

removefromcharactersarray() {
  var_0 = 0;

  for(var_1 = 0; var_1 < level.characters.size; var_1++) {
    if(level.characters[var_1] == self) {
      for(var_0 = 1; var_1 < level.characters.size - 1; var_1++) {
        level.characters[var_1] = level.characters[var_1 + 1];
      }

      level.characters[var_1] = undefined;
      break;
    }
  }
}

spawnpointupdate() {
  while(!isDefined(level.spawnpoints) || level.spawnpoints.size == 0) {
    wait 0.05;
  }

  level thread spawnpointsightupdate();
  level thread spawnpointdistanceupdate();

  for(;;) {
    level.disableclientspawntraces = getdvarint("scr_disableClientSpawnTraces") > 0;
    wait 0.05;
  }
}

getactiveplayerlist() {
  var_0 = [];
  level.active_ffa_players = 0;
  var_1 = level.gametype;
  var_2 = 0;

  if(var_1 == "dm" || var_1 == "gun") {
    var_2 = 1;
  }

  foreach(var_4 in level.characters) {
    if(isplayer(var_4) && var_2 && (var_4.sessionstate == "playing" || var_4.sessionstate == "dead")) {
      level.active_ffa_players++;
    }

    if(!maps\mp\_utility::isreallyalive(var_4)) {
      continue;
    }
    if(isplayer(var_4) && var_4.sessionstate != "playing") {
      continue;
    }
    var_4.spawnlogicteam = getspawnteam(var_4);

    if(var_4.spawnlogicteam == "spectator") {
      continue;
    }
    if(isagent(var_4) && var_4.agent_type == "dog") {
      var_4.spawnlogictraceheight = getplayertraceheight(var_4, 1);
      var_4.spawntracelocation = var_4.origin + (0, 0, var_4.spawnlogictraceheight);
    } else if(!var_4.canperformclienttraces) {
      var_5 = "";

      if(var_4 maps\mp\_utility::isusingremote()) {
        var_5 = var_4 maps\mp\_utility::getremotename();
      }

      if(!(var_5 == "orbitalsupport" || var_5 == "Warbird")) {
        var_6 = getplayertraceheight(var_4);
        var_7 = var_4 getEye();
        var_7 = (var_7[0], var_7[1], var_4.origin[2] + var_6);
        var_4.spawnlogictraceheight = var_6;
        var_4.spawntracelocation = var_7;
      }
    }

    var_0[var_0.size] = var_4;
  }

  return var_0;
}

spawnpointsightupdate() {
  if(isDefined(level.skipspawnsighttraces) && level.skipspawnsighttraces) {
    return;
  }
  var_0 = 18;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 3;
  var_5 = getdvarint("enableS1TUSpawnSightTraces");
  var_6 = _func_2DD();
  var_7 = getactiveplayerlist();

  for(;;) {
    if(var_2) {
      wait 0.05;
      var_1 = 0;
      var_2 = 0;
      var_7 = getactiveplayerlist();
    }

    var_8 = getdvarint("enableS1TUSpawnSightTraces");

    if(var_8) {
      level.spawnsighttracesused_posts1tu = 1;
    } else {
      level.spawnsighttracesused_pres1tu = 1;
    }

    if(var_8 != var_5) {
      foreach(var_10 in level.participants) {
        var_10.canperformclienttraces = canperformclienttraces(var_10);

        if(var_10.canperformclienttraces) {
          var_10 setclientspawnsighttraces(level.clienttracespawnclass);
          continue;
        }

        var_10 setclientspawnsighttraces();
      }

      var_5 = var_8;
    }

    var_13 = level.spawnpoints;
    var_13 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns(var_13);
    var_2 = 1;

    foreach(var_15 in var_13) {
      var_15.lastupdatetime = gettime();
      clearspawnpointsightdata(var_15);

      foreach(var_10 in var_7) {
        if(!isDefined(var_10.spawnlogictraceheight) || !isDefined(var_10.spawntracelocation)) {
          var_10.spawnlogictraceheight = getplayertraceheight(var_10);
          var_17 = var_10.origin;
          var_10.spawntracelocation = (var_17[0], var_17[1], var_17[2] + var_10.spawnlogictraceheight);
        }

        if(var_15.fullsights[var_10.spawnlogicteam]) {
          continue;
        }
        if(var_10.canperformclienttraces) {
          var_18 = var_10 clientspawnsighttracepassed(var_15.index);
        } else {
          if(var_8) {
            if(var_3 % 3 == 1) {
              var_19 = (0, 0, 0);
            } else {
              var_19 = (randomfloatrange(-16, 16), randomfloatrange(-16, 16), 0);
            }

            var_20 = var_15.origin + var_19;
            var_20 = var_20 + (0, 0, var_3 % 3 * 36);
            var_21 = var_10.spawntracelocation + var_19;
          } else {
            var_20 = var_15.origin + (0, 0, var_10.spawnlogictraceheight);
            var_21 = var_10.spawntracelocation;
          }

          var_18 = spawnsighttrace(var_15, var_20, var_21, var_15.index);
          var_1++;
        }

        if(var_8) {
          var_22 = var_10 getentitynumber();

          if(!isDefined(var_15.fullsightdelay) || !isDefined(var_15.fullsightdelay[var_22])) {
            var_15.fullsightdelay[var_22] = 0;
          }

          if(!isDefined(var_15.cornersightdelay) || !isDefined(var_15.cornersightdelay[var_22])) {
            var_15.cornersightdelay[var_22] = 0;
          }
        } else {
          var_22 = 0;
        }

        if(!var_18) {
          if(var_8) {
            if(var_15.fullsightdelay[var_22]) {
              var_15.fullsightdelay[var_22]--;
            }

            if(var_15.cornersightdelay[var_22]) {
              var_15.cornersightdelay[var_22]--;
            }

            if(var_15.fullsightdelay[var_22]) {
              var_15.fullsights[var_10.spawnlogicteam]++;
            } else if(var_15.cornersightdelay[var_22]) {
              var_15.cornersights[var_10.spawnlogicteam]++;
            }
          }

          continue;
        }

        if(var_18 > 0.95) {
          if(var_8) {
            var_15.fullsightdelay[var_22] = var_4;

            if(var_15.cornersightdelay[var_22]) {
              var_15.cornersightdelay[var_22]--;
            }
          }

          var_15.fullsights[var_10.spawnlogicteam]++;
          continue;
        }

        if(level.active_ffa_players > 8) {
          continue;
        }
        if(var_8) {
          if(var_15.fullsightdelay[var_22]) {
            var_15.fullsightdelay[var_22]--;
          }

          var_15.cornersightdelay[var_22] = var_4;

          if(var_15.fullsightdelay[var_22]) {
            var_15.fullsights[var_10.spawnlogicteam]++;
          } else {
            var_15.cornersights[var_10.spawnlogicteam]++;
          }

          continue;
        }

        var_15.cornersights[var_10.spawnlogicteam]++;
      }

      additionalsighttraceentities(var_15, level.turrets);
      additionalsighttraceentities(var_15, level.ugvs);

      if(shouldsighttracewait(var_0, var_1)) {
        wait 0.05;
        var_1 = 0;
        var_2 = 0;
        var_7 = getactiveplayerlist();
      }
    }

    var_3++;
  }
}

shouldsighttracewait(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in level.participants) {
    if(!var_4.canperformclienttraces) {
      var_2++;
    }
  }

  if(var_1 + var_2 > var_0) {
    return 1;
  }

  return 0;
}

spawnpointdistanceupdate() {
  var_0 = getactiveplayerlist();
  var_1 = gettime();
  var_2 = 4;
  var_3 = 0;

  for(;;) {
    var_4 = level.spawnpoints;
    var_4 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns(var_4);
    var_5 = 0;

    foreach(var_7 in var_4) {
      clearspawnpointdistancedata(var_7);
      var_3++;

      foreach(var_9 in var_0) {
        if(var_9.spawnlogicteam == "spectator") {
          continue;
        }
        if(isDefined(level.spawndistanceteamskip) && var_9.spawnlogicteam == level.spawndistanceteamskip) {
          continue;
        }
        var_10 = distancesquared(var_9.origin, var_7.origin);

        if(var_10 < var_7.mindistsquared[var_9.spawnlogicteam]) {
          var_7.mindistsquared[var_9.spawnlogicteam] = var_10;
        }

        var_7.distsumsquared[var_9.spawnlogicteam] = var_7.distsumsquared[var_9.spawnlogicteam] + var_10;
        var_7.totalplayers[var_9.spawnlogicteam]++;

        if(var_10 < 1638400) {
          if(maps\mp\_utility::isreallyalive(var_9)) {
            var_7.nearbyplayers[var_9.spawnlogicteam]++;
          }
        }
      }

      if(var_3 == var_2) {
        var_5 = 1;
        wait 0.05;
        var_0 = getactiveplayerlist();
        var_1 = gettime();
        var_3 = 0;
      }
    }

    if(!var_5) {
      wait 0.05;
      var_0 = getactiveplayerlist();
      var_1 = gettime();
      var_3 = 0;
    }
  }
}

getspawnteam(var_0) {
  var_1 = "all";

  if(level.teambased) {
    var_1 = var_0.team;
  }

  return var_1;
}

initspawnpointvalues(var_0) {
  clearspawnpointsightdata(var_0);
  clearspawnpointdistancedata(var_0);
}

clearspawnpointsightdata(var_0) {
  if(level.teambased) {
    foreach(var_2 in level.teamnamelist) {
      clearteamspawnpointsightdata(var_0, var_2);
    }
  } else {
    clearteamspawnpointsightdata(var_0, "all");
  }
}

clearspawnpointdistancedata(var_0) {
  if(level.teambased) {
    foreach(var_2 in level.teamnamelist) {
      clearteamspawnpointdistancedata(var_0, var_2);
    }
  } else {
    clearteamspawnpointdistancedata(var_0, "all");
  }
}

clearteamspawnpointsightdata(var_0, var_1) {
  var_0.fullsights[var_1] = 0;
  var_0.cornersights[var_1] = 0;
}

clearteamspawnpointdistancedata(var_0, var_1) {
  var_0.distsumsquared[var_1] = 0;
  var_0.mindistsquared[var_1] = 9999999;
  var_0.totalplayers[var_1] = 0;
  var_0.nearbyplayers[var_1] = 0;
}

getplayertraceheight(var_0, var_1) {
  if(isDefined(var_1) && var_1) {
    return 64;
  }

  var_2 = var_0 getstance();

  if(var_2 == "stand") {
    return 64;
  }

  if(var_2 == "crouch") {
    return 44;
  }

  return 32;
}

additionalsighttraceentities(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = getspawnteam(var_3);

    if(var_0.fullsights[var_4]) {
      continue;
    }
    var_5 = spawnsighttrace(var_0, var_0.sighttracepoint, var_3.origin + (0, 0, 50), var_0.index);

    if(!var_5) {
      continue;
    }
    if(var_5 > 0.95) {
      var_0.fullsights[var_4]++;
      continue;
    }

    var_0.cornersights[var_4]++;
  }
}

finalizespawnpointchoice(var_0) {
  var_1 = gettime();
  self.lastspawnpoint = var_0;
  self.lastspawntime = var_1;
  var_0.lastspawntime = var_1;
  var_0.lastspawnteam = self.team;
}

expandspawnpointbounds(var_0) {
  var_1 = getspawnpointarray(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    level.spawnmins = expandmins(level.spawnmins, var_1[var_2].origin);
    level.spawnmaxs = expandmaxs(level.spawnmaxs, var_1[var_2].origin);
  }
}

expandmins(var_0, var_1) {
  if(var_0[0] > var_1[0]) {
    var_0 = (var_1[0], var_0[1], var_0[2]);
  }

  if(var_0[1] > var_1[1]) {
    var_0 = (var_0[0], var_1[1], var_0[2]);
  }

  if(var_0[2] > var_1[2]) {
    var_0 = (var_0[0], var_0[1], var_1[2]);
  }

  return var_0;
}

expandmaxs(var_0, var_1) {
  if(var_0[0] < var_1[0]) {
    var_0 = (var_1[0], var_0[1], var_0[2]);
  }

  if(var_0[1] < var_1[1]) {
    var_0 = (var_0[0], var_1[1], var_0[2]);
  }

  if(var_0[2] < var_1[2]) {
    var_0 = (var_0[0], var_0[1], var_1[2]);
  }

  return var_0;
}

findboxcenter(var_0, var_1) {
  var_2 = (0, 0, 0);
  var_2 = var_1 - var_0;
  var_2 = (var_2[0] / 2, var_2[1] / 2, var_2[2] / 2) + var_0;
  return var_2;
}

setmapcenterfordev() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  expandspawnpointbounds("mp_tdm_spawn_allies_start");
  expandspawnpointbounds("mp_tdm_spawn_axis_start");
  level.mapcenter = findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

shoulduseteamstartspawn() {
  return level.ingraceperiod && (!isDefined(level.numkills) || level.numkills == 0);
}

recon_set_spawnpoint(var_0) {
  if(!isDefined(self.spawninfo)) {
    self.spawninfo = spawnStruct();
  }

  if(isDefined(self.spawninfo.badspawn) && self.spawninfo.badspawn) {
    if(!isDefined(self.spawninfo.pastbadspawns)) {
      self.spawninfo.pastbadspawns = [];
      self.spawninfo.pastbadspawncount = 0;
    }

    self.spawninfo.pastbadspawns[self.spawninfo.pastbadspawncount] = self.spawninfo.spawnpoint;
    self.spawninfo.pastbadspawncount++;
  } else {
    self.spawninfo.pastbadspawns = [];
    self.spawninfo.pastbadspawncount = 0;
  }

  self.spawninfo.spawnpoint = var_0;
}