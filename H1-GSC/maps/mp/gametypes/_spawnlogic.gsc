/*********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_spawnlogic.gsc
*********************************************/

init() {
  level.killstreakspawnshield = 0;
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  level.clienttracespawnclass = undefined;
  level.disableclientspawntraces = 0;
  level.numplayerswaitingtospawn = 0;
  level.numplayerswaitingtoenterkillcam = 0;
  level.badspawncount["axis"] = 0;
  level.badspawncount["allies"] = 0;
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
  level.activeplayerlistupdatetime = -1;
  level.activeplayerlist = [];
  maps\mp\gametypes\_legacyspawnlogic::init();
  level thread trackgrenades();

  if(!maps\mp\gametypes\_legacyspawnlogic::uselegacyspawning()) {
    level thread onplayerconnect();
    level thread spawnpointupdate();
    level thread trackmissiles();
    level thread trackcarepackages();
    level thread trackhostmigrationend();
  }

  for (var_0 = 0; var_0 < level.teamnamelist.size; var_0++)
    level.teamspawnpoints[level.teamnamelist[var_0]] = [];
}

trackhostmigrationend() {
  for (;;) {
    self waittill("host_migration_end");

    foreach(var_1 in level.participants)
    var_1.canperformclienttraces = canperformclienttraces(var_1);
  }
}

onplayerconnect() {
  for (;;) {
    level waittill("connected", var_0);
    level thread startclientspawnpointtraces(var_0);
    level thread updatespawnsightsforplayer(var_0);
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

updatespawnsightsforplayer(var_0) {
  while (isdefined(var_0)) {
    var_1 = var_0 common_scripts\utility::waittill_any_return_no_endon_death("death", "disconnect", "joined_spectators", "joined_team");
    removespawnsightsforplayer(var_0);

    if(var_1 == "disconnect") {
      break;
    }
  }
}

calculatespawntospawnsights() {
  var_0 = (0, 0, 64);

  foreach(var_2 in level.spawnpoints) {
    var_2.fullsightspawns = [];
    var_2.cornersightspawns = [];
    var_2.trackplayersights = 1;
  }

  foreach(var_2 in level.spawnpoints) {
    if(!maps\mp\_utility::is_true(var_2.trackplayersights)) {
      continue;
    }
    var_5 = var_2.origin + var_0;

    foreach(var_7 in level.spawnpoints) {
      var_8 = var_7.origin + var_0;
      var_9 = spawnsighttrace(var_2, var_5, var_8, var_2.index);

      if(var_9 > 0.95) {
        var_2.fullsightspawns[var_2.fullsightspawns.size] = var_7;
        continue;
      }

      if(var_9 > 0.0)
        var_2.cornersightspawns[var_2.cornersightspawns.size] = var_7;
    }
  }
}

canperformclienttraces(var_0) {
  if(level.disableclientspawntraces)
    return 0;

  if(!isdefined(level.clienttracespawnclass))
    return 0;

  if(isai(var_0))
    return 0;

  if(var_0 ishost())
    return 0;

  return 1;
}

addstartspawnpoints(var_0, var_1) {
  var_2 = getspawnpointarray(var_0);

  if(!var_2.size) {
    if(!maps\mp\_utility::is_true(var_1)) {

    }

    return;
  }

  if(!isdefined(level.startspawnpoints))
    level.startspawnpoints = [];

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    var_2[var_3] spawnpointinit();
    var_2[var_3].selected = 0;
    level.startspawnpoints[level.startspawnpoints.size] = var_2[var_3];
  }

  foreach(var_5 in var_2) {
    var_5.infront = 1;
    var_6 = anglestoforward(var_5.angles);

    foreach(var_8 in var_2) {
      if(var_5 == var_8) {
        continue;
      }
      var_9 = vectornormalize(var_8.origin - var_5.origin);
      var_10 = vectordot(var_6, var_9);

      if(var_10 > 0.86) {
        var_5.infront = 0;
        break;
      }
    }
  }

  if(!maps\mp\_utility::is_true(var_1)) {
    var_13 = var_2.size;
    var_14 = level.startspawnpoints.size;
    addstartspawnpoints(var_0 + "_overflow", 1);
    var_15 = level.startspawnpoints.size - var_14;
  }
}

addspawnpoints(var_0, var_1) {
  if(!isdefined(level.spawnpoints))
    level.spawnpoints = [];

  if(!isdefined(level.teamspawnpoints[var_0]))
    level.teamspawnpoints[var_0] = [];

  var_2 = [];
  var_2 = getspawnpointarray(var_1);

  if(!isdefined(level.clienttracespawnclass))
    level.clienttracespawnclass = var_1;

  if(!var_2.size) {
    return;
  }
  foreach(var_4 in var_2) {
    if(!isdefined(var_4.inited)) {
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
  var_0.forward = anglestoforward(var_0.angles);
  var_0.sighttracepoint = var_0.origin + (0, 0, 50);
  var_0.lastspawntime = gettime();
  var_0.outside = 1;
  var_0.inited = 1;
  var_0.alternates = [];
  var_1 = 1024;

  if(!bullettracepassed(var_0.sighttracepoint, var_0.sighttracepoint + (0, 0, var_1), 0, undefined)) {
    var_2 = var_0.sighttracepoint + var_0.forward * 100;

    if(!bullettracepassed(var_2, var_2 + (0, 0, var_1), 0, undefined))
      var_0.outside = 0;
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
  if(!isdefined(level.spawnpointarray))
    level.spawnpointarray = [];

  if(!isdefined(level.spawnpointarray[var_0])) {
    level.spawnpointarray[var_0] = [];
    level.spawnpointarray[var_0] = getspawnarray(var_0);

    foreach(var_2 in level.spawnpointarray[var_0])
    var_2.classname = var_0;
  }

  return level.spawnpointarray[var_0];
}

cananyplayerseeffaspawnpoint(var_0) {
  var_1 = (0, 0, 64);
  var_2 = var_0.origin + var_1;

  foreach(var_4 in level.players) {
    if(var_4.sessionstate != "playing") {
      continue;
    }
    if(!maps\mp\_utility::isreallyalive(var_4)) {
      continue;
    }
    if(var_4 == self) {
      continue;
    }
    var_5 = var_4.origin + var_1;

    if(sighttracepassed(var_2, var_5, 0, var_4))
      return 1;
  }

  return 0;
}

getstartspawnffa(var_0) {
  if(!isdefined(level.ffastartspawnpoints))
    level.ffastartspawnpoints = [];

  if(!isdefined(level.ffastartspawnpoints[var_0])) {
    var_1 = getteamspawnpoints(var_0);
    level.ffastartspawnpoints[var_0] = [];

    foreach(var_3 in var_1) {
      if(isdefined(var_3.script_noteworthy) && var_3.script_noteworthy == "start_spawn")
        level.ffastartspawnpoints[var_0][level.ffastartspawnpoints[var_0].size] = var_3;
    }
  }

  var_5 = undefined;

  if(level.ffastartspawnpoints[var_0].size >= level.players.size)
    var_5 = getspawnpoint_random(level.ffastartspawnpoints[var_0], 1);

  if(!isdefined(var_5)) {
    var_6 = getteamspawnpoints(var_0);
    var_6 = common_scripts\utility::array_randomize(var_6);

    foreach(var_8 in var_6) {
      if(!isdefined(var_8.ffastartspawnsighted))
        var_8.ffastartspawnsighted = 0;
      else if(var_8.ffastartspawnsighted) {
        continue;
      }
      if(cananyplayerseeffaspawnpoint(var_8)) {
        var_8.ffastartspawnsighted = 1;
        continue;
      }

      if(canspawn(var_8.origin) && !positionwouldtelefrag(var_8.origin)) {
        var_5 = var_8;
        break;
      }
    }

    if(!isdefined(var_5))
      var_5 = getspawnpoint_random(var_6);
  }

  return var_5;
}

getspawnpoint_random(var_0, var_1) {
  if(!isdefined(var_0))
    return undefined;

  var_0 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns(var_0);
  var_0 = common_scripts\utility::array_randomize(var_0);

  foreach(var_3 in var_0) {
    if(canspawn(var_3.origin) && !positionwouldtelefrag(var_3.origin))
      return var_3;
  }

  if(!maps\mp\_utility::is_true(var_1) && var_0.size > 0)
    return var_0[var_0.size - 1];

  return undefined;
}

getbeststartspawn(var_0) {
  var_1 = getspawnpointarray(var_0);
  var_2 = getspawnpoint_startspawn(var_1);

  if(!isdefined(var_2)) {
    var_3 = getspawnpointarray(var_0 + "_overflow");
    var_2 = getspawnpoint_startspawn(var_3);
  }

  if(!isdefined(var_2)) {
    var_2 = getspawnpoint_random(var_1);
    var_2.selected = 1;
  }

  return var_2;
}

getrandomstartspawn(var_0) {
  var_1 = getspawnpointarray(var_0);
  var_2 = getspawnpoint_random(var_1, 1);

  if(!isdefined(var_2)) {
    var_3 = getspawnpointarray(var_0 + "_overflow");
    var_2 = getspawnpoint_random(var_3, 1);
  }

  if(!isdefined(var_2))
    var_2 = getspawnpoint_random(var_1);

  return var_2;
}

getspawnpoint_startspawn(var_0) {
  if(!isdefined(var_0))
    return undefined;

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

  if(isdefined(var_1))
    var_1.selected = 1;

  return var_1;
}

getspawnpoint_nearteam(var_0, var_1) {
  for (;;)
    wait 5;
}

trackgrenades() {
  for (;;) {
    level.grenades = getentarray("grenade", "classname");
    wait 0.05;
  }
}

trackmissiles() {
  for (;;) {
    level.missiles = getentarray("rocket", "classname");
    wait 0.05;
  }
}

trackcarepackages() {
  for (;;) {
    level.carepackages = getentarray("care_package", "targetname");
    wait 0.05;
  }
}

getteamspawnpoints(var_0) {
  return level.teamspawnpoints[var_0];
}

ispathdataavailable() {
  if(!isdefined(level.pathdataavailable)) {
    var_0 = getallnodes();
    level.pathdataavailable = isdefined(var_0) && var_0.size > 150;
  }

  return level.pathdataavailable;
}

addtoparticipantsarray() {
  if(isdefined(level.ishorde) && level.ishorde)
    level notify("participant_added", self);

  level.participants[level.participants.size] = self;
}

removefromparticipantsarray() {
  var_0 = 0;

  for (var_1 = 0; var_1 < level.participants.size; var_1++) {
    if(level.participants[var_1] == self) {
      for (var_0 = 1; var_1 < level.participants.size - 1; var_1++)
        level.participants[var_1] = level.participants[var_1 + 1];

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

  for (var_1 = 0; var_1 < level.characters.size; var_1++) {
    if(level.characters[var_1] == self) {
      for (var_0 = 1; var_1 < level.characters.size - 1; var_1++)
        level.characters[var_1] = level.characters[var_1 + 1];

      level.characters[var_1] = undefined;
      break;
    }
  }
}

spawnpointupdate() {
  if(maps\mp\_utility::invirtuallobby()) {
    return;
  }
  while (!isdefined(level.spawnpoints) || level.spawnpoints.size == 0)
    wait 0.05;

  calculatespawntospawnsights();
  level thread spawnpointsightupdate();
  level thread spawnpointclientsightupdate();
  level thread spawnpointdistanceupdate();
}

updateactiveplayerlist() {
  var_0 = gettime();

  if(level.activeplayerlistupdatetime == var_0) {
    return;
  }
  level.activeplayerlistupdatetime = var_0;
  level.activeplayerlist = [];
  level.active_ffa_players = 0;
  var_1 = level.gametype;
  var_2 = 0;

  if(var_1 == "dm" || var_1 == "gun")
    var_2 = 1;

  foreach(var_4 in level.characters) {
    var_4.isactiveplayer = 0;

    if(isplayer(var_4) && var_2 && (var_4.sessionstate == "playing" || var_4.sessionstate == "dead"))
      level.active_ffa_players++;

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
    var_5 = getplayertraceheight(var_4);
    var_6 = var_4 geteye();
    var_6 = (var_6[0], var_6[1], var_4.origin[2] + var_5);
    var_4.spawnlogictraceheight = var_5;
    var_4.spawntracelocation = var_6;
    var_4.isactiveplayer = 1;
    level.activeplayerlist[level.activeplayerlist.size] = var_4;
  }
}

spawnpointclientsightupdate() {
  level.maxclientupdatesperframe = 200;
  var_0 = 0;
  var_1 = 0;
  updateactiveplayerlist();

  for (;;) {
    if(var_1) {
      wait 0.05;
      var_0 = 0;
      var_1 = 0;
      updateactiveplayerlist();
    }

    var_2 = level.spawnpoints;
    var_2 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns(var_2);
    var_1 = 1;

    for (var_3 = 0; var_3 < level.characters.size; var_3++) {
      var_4 = level.characters[var_3];

      if(!var_4.canperformclienttraces) {
        continue;
      }
      if(!var_4.isactiveplayer) {
        removespawnsightsforplayer(var_4);
        continue;
      }

      for (var_5 = 0; var_5 < level.spawnpoints.size; var_5++) {
        var_0++;
        var_6 = level.spawnpoints[var_5];
        var_7 = var_4 _meth_857B(var_6.classname);
        var_8 = var_6.fullsightsplayers[var_4.guid];
        var_9 = isdefined(var_8);
        var_10 = var_6.cornersightsplayers[var_4.guid];
        var_11 = isdefined(var_10);
        var_12 = 0;

        if(var_9)
          var_12 = var_8.time;
        else if(var_11)
          var_12 = var_10.time;

        if(var_7 <= var_12) {
          continue;
        }
        var_13 = var_4 clientspawnsighttracepassed(var_6.index, var_6.classname);

        if(var_13 >= 1.0) {
          if(var_9)
            var_8.time = var_7;
          else {
            if(var_11)
              removecornersightsfromspawnforplayer(var_6, var_4);

            addfullsightspawnforplayer(var_6, var_4, var_7);
          }

          continue;
        }

        if(var_13 >= 0.5 && level.active_ffa_players <= 8) {
          if(var_11)
            var_10.time = var_7;
          else {
            if(var_9)
              removefullsightsfromspawnforplayer(var_6, var_4);

            addcornersightspawnforplayer(var_6, var_4, var_7);
          }

          continue;
        }

        if(var_11)
          removecornersightsfromspawnforplayer(var_6, var_4);

        if(var_9)
          removefullsightsfromspawnforplayer(var_6, var_4);
      }

      if(var_0 + level.spawnpoints.size > level.maxclientupdatesperframe) {
        wait 0.05;
        var_0 = 0;
        var_1 = 0;
        updateactiveplayerlist();
      }
    }
  }
}

spawnpointsightupdate() {
  if(isdefined(level.skipspawnsighttraces) && level.skipspawnsighttraces) {
    return;
  }
  level.maxtraceperframe = 36;
  var_0 = 0;
  var_1 = 0;

  for (;;) {
    if(var_1) {
      wait 0.05;
      var_0 = 0;
      var_1 = 0;
      updateactiveplayerlist();
    }

    var_2 = level.spawnpoints;
    var_2 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns(var_2);
    var_1 = 1;

    foreach(var_4 in var_2) {
      var_4.lastupdatetime = gettime();
      var_5 = 0;

      foreach(var_7 in level.activeplayerlist) {
        var_8 = var_4.origin + (0, 0, var_7.spawnlogictraceheight);
        var_9 = var_7.spawntracelocation;
        removespawnsightsfromspawnforplayer(var_4, var_7);
        var_10 = spawnsighttrace(var_4, var_8, var_9, var_4.index);
        var_0++;
        var_5++;

        if(!var_10) {
          continue;
        }
        if(var_10 > 0.95) {
          addfullsightspawnforplayer(var_4, var_7, gettime());
          continue;
        }

        if(level.active_ffa_players > 8) {
          continue;
        }
        addcornersightspawnforplayer(var_4, var_7, gettime());
      }

      if(var_0 + var_5 > level.maxtraceperframe) {
        wait 0.05;
        var_0 = 0;
        var_1 = 0;
        updateactiveplayerlist();
      }
    }
  }
}

spawnpointdistanceupdate() {
  var_0 = gettime();
  var_1 = 4;
  var_2 = 0;
  updateactiveplayerlist();

  for (;;) {
    var_3 = level.spawnpoints;
    var_3 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns(var_3);
    var_4 = 0;

    foreach(var_6 in var_3) {
      clearspawnpointdistancedata(var_6);
      var_2++;

      foreach(var_8 in level.activeplayerlist) {
        if(var_8.spawnlogicteam == "spectator") {
          continue;
        }
        if(isdefined(level.spawndistanceteamskip) && var_8.spawnlogicteam == level.spawndistanceteamskip) {
          continue;
        }
        var_9 = distancesquared(var_8.origin, var_6.origin);

        if(var_9 < var_6.mindistsquared[var_8.spawnlogicteam])
          var_6.mindistsquared[var_8.spawnlogicteam] = var_9;

        var_6.distsumsquared[var_8.spawnlogicteam] = var_6.distsumsquared[var_8.spawnlogicteam] + var_9;
        var_6.totalplayers[var_8.spawnlogicteam]++;

        if(var_9 < 1638400) {
          if(maps\mp\_utility::isreallyalive(var_8))
            var_6.nearbyplayers[var_8.spawnlogicteam]++;
        }
      }

      if(var_2 == var_1) {
        var_4 = 1;
        wait 0.05;
        updateactiveplayerlist();
        var_0 = gettime();
        var_2 = 0;
      }
    }

    if(!var_4) {
      wait 0.05;
      updateactiveplayerlist();
      var_0 = gettime();
      var_2 = 0;
    }
  }
}

getspawnteam(var_0) {
  var_1 = "all";

  if(level.teambased)
    var_1 = var_0.team;

  return var_1;
}

initspawnpointvalues(var_0) {
  clearspawnpointsightdata(var_0);
  clearspawnpointdistancedata(var_0);
}

clearspawnpointsightdata(var_0) {
  if(level.teambased) {
    foreach(var_2 in level.teamnamelist)
    clearteamspawnpointsightdata(var_0, var_2);
  } else
    clearteamspawnpointsightdata(var_0, "all");
}

clearspawnpointdistancedata(var_0) {
  if(level.teambased) {
    foreach(var_2 in level.teamnamelist)
    clearteamspawnpointdistancedata(var_0, var_2);
  } else
    clearteamspawnpointdistancedata(var_0, "all");
}

clearteamspawnpointsightdata(var_0, var_1) {
  var_0.fullsights[var_1] = 0;
  var_0.fullsightsplayers = [];
  var_0.cornersights[var_1] = 0;
  var_0.cornersightsplayers = [];
}

clearteamspawnpointdistancedata(var_0, var_1) {
  var_0.distsumsquared[var_1] = 0;
  var_0.mindistsquared[var_1] = 9999999;
  var_0.totalplayers[var_1] = 0;
  var_0.nearbyplayers[var_1] = 0;
}

removespawnsightsfromspawnforplayer(var_0, var_1) {
  removefullsightsfromspawnforplayer(var_0, var_1);
  removecornersightsfromspawnforplayer(var_0, var_1);
}

removefullsightsfromspawnforplayer(var_0, var_1) {
  var_2 = var_0.fullsightsplayers[var_1.guid];

  if(isdefined(var_2)) {
    var_0.fullsights[var_2.team]--;
    var_0.fullsightsplayers[var_1.guid] = undefined;
  }
}

removecornersightsfromspawnforplayer(var_0, var_1) {
  var_2 = var_0.cornersightsplayers[var_1.guid];

  if(isdefined(var_2)) {
    var_0.cornersights[var_2.team]--;
    var_0.cornersightsplayers[var_1.guid] = undefined;
  }
}

removespawnsightsforplayer(var_0) {
  if(!isdefined(level.spawnpoints)) {
    return;
  }
  foreach(var_2 in level.spawnpoints) {
    if(!maps\mp\_utility::is_true(var_2.trackplayersights)) {
      continue;
    }
    removespawnsightsfromspawnforplayer(var_2, var_0);
  }
}

addspawnsights(var_0, var_1) {
  if(!maps\mp\_utility::is_true(var_0.trackplayersights)) {
    return;
  }
  foreach(var_3 in var_0.fullsightspawns)
  addfullsightspawnforplayer(var_3, var_1, gettime());

  foreach(var_6 in var_0.cornersightspawns)
  addcornersightspawnforplayer(var_6, var_1, gettime());
}

addfullsightspawnforplayer(var_0, var_1, var_2) {
  if(!maps\mp\_utility::is_true(var_0.trackplayersights)) {
    return;
  }
  var_1.spawnlogicteam = getspawnteam(var_1);
  var_0.fullsights[var_1.spawnlogicteam]++;
  var_3 = spawnstruct();
  var_3.player = var_1;
  var_3.time = var_2;
  var_3.team = var_1.spawnlogicteam;
  var_0.fullsightsplayers[var_1.guid] = var_3;
}

addcornersightspawnforplayer(var_0, var_1, var_2) {
  if(!maps\mp\_utility::is_true(var_0.trackplayersights)) {
    return;
  }
  var_1.spawnlogicteam = getspawnteam(var_1);
  var_0.cornersights[var_1.spawnlogicteam]++;
  var_3 = spawnstruct();
  var_3.player = var_1;
  var_3.time = var_2;
  var_3.team = var_1.spawnlogicteam;
  var_0.cornersightsplayers[var_1.guid] = var_3;
}

getplayertraceheight(var_0, var_1) {
  if(isdefined(var_1) && var_1)
    return 64.0;

  var_2 = var_0 getstance();

  if(var_2 == "stand")
    return 64.0;

  if(var_2 == "crouch")
    return 44.0;

  return 32.0;
}

additionalsighttraceentities(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(!isdefined(var_3)) {
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

  if(maps\mp\gametypes\_legacyspawnlogic::uselegacyspawning())
    var_0.lastspawnedplayer = self;
  else {
    removespawnsightsforplayer(self);
    addspawnsights(var_0, self);
  }
}

expandspawnpointbounds(var_0) {
  var_1 = getspawnpointarray(var_0);

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    level.spawnmins = expandmins(level.spawnmins, var_1[var_2].origin);
    level.spawnmaxs = expandmaxs(level.spawnmaxs, var_1[var_2].origin);
  }
}

expandmins(var_0, var_1) {
  if(var_0[0] > var_1[0])
    var_0 = (var_1[0], var_0[1], var_0[2]);

  if(var_0[1] > var_1[1])
    var_0 = (var_0[0], var_1[1], var_0[2]);

  if(var_0[2] > var_1[2])
    var_0 = (var_0[0], var_0[1], var_1[2]);

  return var_0;
}

expandmaxs(var_0, var_1) {
  if(var_0[0] < var_1[0])
    var_0 = (var_1[0], var_0[1], var_0[2]);

  if(var_0[1] < var_1[1])
    var_0 = (var_0[0], var_1[1], var_0[2]);

  if(var_0[2] < var_1[2])
    var_0 = (var_0[0], var_0[1], var_1[2]);

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
  return level.ingraceperiod && (!isdefined(level.numkills) || level.numkills == 0);
}

recon_set_spawnpoint(var_0) {
  if(!isdefined(self.spawninfo))
    self.spawninfo = spawnstruct();

  self.spawninfo.spawnpoint = var_0;
}