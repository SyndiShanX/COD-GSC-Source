/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42928.gsc
**************************************/

getspawnpoint_nearteam(var_0) {
  var_0 = checkdynamicspawns(var_0);
  var_1["primary"] = [];
  var_1["secondary"] = [];
  var_1["bad"] = [];

  foreach(var_3 in var_0) {
    initscoredata(var_3);
    var_3.criticalresult = criticalfactors_global(var_3);
    var_1[var_3.criticalresult][var_1[var_3.criticalresult].size] = var_3;
  }

  if(var_1["primary"].size) {
    var_5 = scorespawns_nearteam(var_1["primary"]);
  } else if(var_1["secondary"].size) {
    var_5 = scorespawns_nearteam(var_1["secondary"]);
  } else {
    var_5 = scorespawns_nearteam(var_0);
  }

  foreach(var_3 in var_0) {
    recon_log_spawnpoint_info(var_3);
    var_3.criticalresult = undefined;
  }

  return var_5;
}

scorespawns_nearteam(var_0) {
  var_1 = var_0[0];

  foreach(var_3 in var_0) {
    scorefactors_nearteam(var_3);

    if(var_3.totalscore > var_1.totalscore) {
      var_1 = var_3;
    }
  }

  var_1 = selectbestspawnpoint(var_1, var_0);
  return var_1;
}

getspawnpoint_twar(var_0, var_1) {
  var_0 = checkdynamicspawns(var_0);
  var_2["primary"] = [];
  var_2["secondary"] = [];
  var_2["bad"] = [];

  foreach(var_4 in var_0) {
    initscoredata(var_4);
    var_4.criticalresult = criticalfactors_global(var_4);
    var_2[var_4.criticalresult][var_2[var_4.criticalresult].size] = var_4;
  }

  if(var_2["primary"].size) {
    var_6 = scorespawns_twar(var_2["primary"], var_1);
  } else if(var_2["secondary"].size) {
    var_6 = scorespawns_twar(var_2["secondary"], var_1);
  } else {
    var_6 = scorespawns_twar(var_0, var_1);
  }

  foreach(var_4 in var_0) {
    if(!isagent(self)) {
      recon_log_spawnpoint_info(var_4);
    }

    var_4.criticalresult = undefined;
  }

  return var_6;
}

scorespawns_twar(var_0, var_1) {
  var_2 = var_0[0];

  foreach(var_4 in var_0) {
    scorefactors_twar(var_4, var_1);

    if(var_4.totalscore > var_2.totalscore) {
      var_2 = var_4;
    }
  }

  var_2 = selectbestspawnpoint(var_2, var_0);
  return var_2;
}

checkdynamicspawns(var_0) {
  if(isDefined(level.dynamicspawns)) {
    var_0 = [[level.dynamicspawns]](var_0);
  }

  return var_0;
}

selectbestspawnpoint(var_0, var_1) {
  var_2 = var_0;
  var_3 = 0;
  var_4 = [];

  foreach(var_6 in var_1) {
    if(var_6.totalscore == var_2.totalscore) {
      var_4[var_4.size] = var_6;
    }
  }

  var_2 = var_4[randomint(var_4.size)];

  foreach(var_6 in var_1) {
    if(var_6.totalscore > 0) {
      var_3++;
    }
  }

  if(var_3 == 0) {
    if(var_2.totalscore == 0) {
      var_2 = var_1[randomint(var_1.size)];
      var_2.israndom = 1;
    }
  }

  var_2.numberofpossiblespawnchoices = var_3;
  return var_2;
}

recon_log_spawnpoint_info_wrapper(var_0) {
  recon_log_spawnpoint_info(var_0);
}

recon_log_spawnpoint_info(var_0) {
  if(!isDefined(var_0.israndom)) {
    var_0.israndom = 0;
  }

  if(!isDefined(var_0.teambase)) {
    var_0.teambase = "none";
  }

  if(!isDefined(var_0.lastspawnteam)) {
    var_0.lastspawnteam = "none";
  }

  if(!isDefined(var_0.lastspawntime)) {
    var_0.lastspawntime = -1;
  }

  if(level.teambased) {
    var_1 = var_0.fullsights["allies"];
    var_2 = var_0.fullsights["axis"];
    var_3 = var_0.cornersights["allies"];
    var_4 = var_0.cornersights["axis"];
    var_5 = var_0.mindistsquared["allies"];
    var_6 = var_0.mindistsquared["axis"];
  } else {
    var_1 = var_0.fullsights["all"];
    var_2 = -1;
    var_3 = var_0.cornersights["all"];
    var_4 = -1;
    var_5 = var_0.mindistsquared["all"];
    var_6 = -1;
  }

  var_7 = -1;
  var_8 = -1;
  var_9 = -1;
  var_10 = -1;
  var_11 = -1;
  var_12 = -1;
  var_13 = -1;
  var_14 = -1;
  var_15 = "_spawnscoring.gsc";
  var_16 = gettime();
  var_17 = var_0.classname;
  var_18 = var_0.totalscore;
  var_19 = var_0.criticalresult;
  var_20 = var_0.teambase;
  var_21 = var_0.outside;

  if(isDefined(var_0.debugcriticaldata[0])) {
    var_7 = var_0.debugcriticaldata[0];
  }

  if(isDefined(var_0.debugcriticaldata[1])) {
    var_8 = var_0.debugcriticaldata[1];
  }

  if(isDefined(var_0.debugcriticaldata[2])) {
    var_9 = var_0.debugcriticaldata[2];
  }

  if(isDefined(var_0.debugcriticaldata[3])) {
    var_10 = var_0.debugcriticaldata[3];
  }

  if(isDefined(var_0.debugcriticaldata[4])) {
    var_11 = var_0.debugcriticaldata[4];
  }

  if(isDefined(var_0.debugcriticaldata[5])) {
    var_12 = var_0.debugcriticaldata[5];
  }

  if(isDefined(var_0.debugcriticaldata[6])) {
    var_13 = var_0.debugcriticaldata[6];
  }

  if(isDefined(var_0.debugcriticaldata[7])) {
    var_14 = var_0.debugcriticaldata[7];
  }

  var_22 = var_0.totalpossiblescore;
  var_23 = -1;
  var_24 = -1;
  var_25 = -1;
  var_26 = -1;
  var_27 = -1;
  var_28 = -1;
  var_29 = -1;
  var_30 = -1;

  if(isDefined(var_0.debugscoredata[0])) {
    var_23 = var_0.debugscoredata[0];
  }

  if(isDefined(var_0.debugscoredata[1])) {
    var_24 = var_0.debugscoredata[1];
  }

  if(isDefined(var_0.debugscoredata[2])) {
    var_25 = var_0.debugscoredata[2];
  }

  if(isDefined(var_0.debugscoredata[3])) {
    var_26 = var_0.debugscoredata[3];
  }

  if(isDefined(var_0.debugscoredata[4])) {
    var_27 = var_0.debugscoredata[4];
  }

  if(isDefined(var_0.debugscoredata[5])) {
    var_28 = var_0.debugscoredata[5];
  }

  if(isDefined(var_0.debugscoredata[6])) {
    var_29 = var_0.debugscoredata[6];
  }

  if(isDefined(var_0.debugscoredata[7])) {
    var_30 = var_0.debugscoredata[7];
  }

  reconspatialevent(var_0.origin, "script_mp_spawnpoint_score: player_name %s, life_id %d, script_file %s, gameTime %d, classname %s, totalscore %d, totalPossibleScore %d, score_data0 %d, score_data1 %d, score_data2 %d, score_data3 %d, score_data4 %d, score_data5 %d, score_data6 %d, score_data7 %d, fullsights_allies %d, fullsights_axis %d, cornersights_allies %d, cornersights_axis %d, min_dist_squared_allies %d, min_dist_squared_axis %d, criticalResult %s, critical_data0 %d, critical_data1 %d, critical_data2 %d, critical_data3 %d, critical_data4 %d, critical_data5 %d, critical_data6 %d, critical_data7 %d, teambase %s, outside %d", self.name, self.lifeid, var_15, var_16, var_17, var_18, var_22, var_23, var_24, var_25, var_26, var_27, var_28, var_29, var_30, var_1, var_2, var_3, var_4, var_5, var_6, var_19, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_20, var_21);
}

findsecondhighestspawnscore(var_0, var_1) {
  if(var_1.size < 2) {
    return var_0;
  }

  var_2 = var_1[0];

  if(var_2 == var_0) {
    var_2 = var_1[1];
  }

  foreach(var_4 in var_1) {
    if(var_4 == var_0) {
      continue;
    }
    if(var_4.totalscore > var_2.totalscore) {
      var_2 = var_4;
    }
  }

  return var_2;
}

findbuddyspawn() {
  var_0 = spawnStruct();
  initscoredata(var_0);
  var_1 = getteammatesoutofcombat(self.team);
  var_2 = spawnStruct();
  var_2.maxtracecount = 18;
  var_2.currenttracecount = 0;

  foreach(var_4 in var_1) {
    var_5 = findspawnlocationnearplayer(var_4);

    if(!isDefined(var_5)) {
      continue;
    }
    if(issafetospawnon(var_4, var_5, var_2)) {
      var_0.totalscore = 999;
      var_0.buddyspawn = 1;
      var_0.origin = var_5;
      var_0.angles = getbuddyspawnangles(var_4, var_0.origin);
      break;
    }

    if(var_2.currenttracecount == var_2.maxtracecount) {
      break;
    }
  }

  return var_0;
}

getbuddyspawnangles(var_0, var_1) {
  var_2 = (0, var_0.angles[1], 0);
  var_3 = findentrances(var_1);

  if(isDefined(var_3) && var_3.size > 0) {
    var_2 = vectortoangles(var_3[0].origin - var_1);
  }

  return var_2;
}

getteammatesoutofcombat(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3.team != var_0) {
      continue;
    }
    if(var_3.sessionstate != "playing") {
      continue;
    }
    if(!maps\mp\_utility::isreallyalive(var_3)) {
      continue;
    }
    if(var_3 == self) {
      continue;
    }
    if(isplayerincombat(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return common_scripts\utility::array_randomize(var_1);
}

isplayerincombat(var_0) {
  if(var_0 issighted()) {
    return 1;
  }

  if(!var_0 isonground()) {
    return 1;
  }

  if(var_0 isonladder()) {
    return 1;
  }

  if(var_0 common_scripts\utility::isflashed()) {
    return 1;
  }

  var_1 = 3000;

  if(var_0.health < var_0.maxhealth && isDefined(var_0.lastdamagedtime) && gettime() < var_0.lastdamagedtime + var_1) {
    return 1;
  }

  if(!maps\mp\gametypes\_spawnfactor::avoidgrenades(var_0)) {
    return 1;
  }

  if(!maps\mp\gametypes\_spawnfactor::avoidmines(var_0)) {
    return 1;
  }

  return 0;
}

findspawnlocationnearplayer(var_0) {
  var_1 = maps\mp\gametypes\_spawnlogic::getplayertraceheight(var_0, 1);
  var_2 = findbuddypathnode(var_0, var_1, 0.5);

  if(isDefined(var_2)) {
    return var_2.origin;
  }

  return undefined;
}

findbuddypathnode(var_0, var_1, var_2) {
  var_3 = getnodesinradiussorted(var_0.origin, 192, 64, var_1, "Path");
  var_4 = undefined;

  if(isDefined(var_3) && var_3.size > 0) {
    var_5 = anglesToForward(var_0.angles);

    foreach(var_7 in var_3) {
      var_8 = vectornormalize(var_7.origin - var_0.origin);
      var_9 = vectordot(var_5, var_8);

      if(var_9 <= var_2 && !positionwouldtelefrag(var_7.origin)) {
        if(sighttracepassed(var_0.origin + (0, 0, var_1), var_7.origin + (0, 0, var_1), 0, var_0)) {
          var_4 = var_7;

          if(var_9 <= 0.0) {
            break;
          }
        }
      }
    }
  }

  return var_4;
}

issafetospawnon(var_0, var_1, var_2) {
  if(var_0 issighted()) {
    return 0;
  }

  foreach(var_4 in level.players) {
    if(var_2.currenttracecount == var_2.maxtracecount) {
      return 0;
    }

    if(var_4.team == self.team) {
      continue;
    }
    if(var_4.sessionstate != "playing") {
      continue;
    }
    if(!maps\mp\_utility::isreallyalive(var_4)) {
      continue;
    }
    if(var_4 == self) {
      continue;
    }
    var_2.currenttracecount++;
    var_5 = maps\mp\gametypes\_spawnlogic::getplayertraceheight(var_4);
    var_6 = var_4 getEye();
    var_6 = (var_6[0], var_6[1], var_4.origin[2] + var_5);
    var_7 = spawnsighttrace(var_2, var_1 + (0, 0, var_5), var_6, 0);

    if(var_7 > 0) {
      return 0;
    }
  }

  return 1;
}

initscoredata(var_0) {
  var_0.totalscore = 0;
  var_0.numberofpossiblespawnchoices = 0;
  var_0.buddyspawn = 0;
  var_0.debugscoredata = [];
  var_0.debugcriticaldata = [];
  var_0.totalpossiblescore = 0;
}

criticalfactors_global(var_0) {
  if(!maps\mp\gametypes\_spawnfactor::critical_factor(maps\mp\gametypes\_spawnfactor::avoidfullvisibleenemies, var_0)) {
    return "bad";
  }

  if(!maps\mp\gametypes\_spawnfactor::critical_factor(maps\mp\gametypes\_spawnfactor::avoidgrenades, var_0)) {
    return "bad";
  }

  if(!maps\mp\gametypes\_spawnfactor::critical_factor(maps\mp\gametypes\_spawnfactor::avoidgasclouds, var_0)) {
    return "bad";
  }

  if(!maps\mp\gametypes\_spawnfactor::critical_factor(maps\mp\gametypes\_spawnfactor::avoidmines, var_0)) {
    return "bad";
  }

  if(!maps\mp\gametypes\_spawnfactor::critical_factor(maps\mp\gametypes\_spawnfactor::avoidairstrikelocations, var_0)) {
    return "bad";
  }

  if(!maps\mp\gametypes\_spawnfactor::critical_factor(maps\mp\gametypes\_spawnfactor::avoidcarepackages, var_0)) {
    return "bad";
  }

  if(!maps\mp\gametypes\_spawnfactor::critical_factor(maps\mp\gametypes\_spawnfactor::avoidtelefrag, var_0)) {
    return "bad";
  }

  if(!maps\mp\gametypes\_spawnfactor::critical_factor(maps\mp\gametypes\_spawnfactor::avoidenemyspawn, var_0)) {
    return "bad";
  }

  if(level.gametype == "hp") {
    if(!maps\mp\gametypes\_spawnfactor::critical_factor(maps\mp\gametypes\_spawnfactor::avoidspawninzone, var_0, level.zone)) {
      return "bad";
    }
  }

  if(level.gametype == "twar") {
    if(!maps\mp\gametypes\_spawnfactor::critical_factor(maps\mp\gametypes\_spawnfactor::avoidspawninzone, var_0, level.twar_use_obj.zone)) {
      return "bad";
    }
  }

  if(!maps\mp\gametypes\_spawnfactor::critical_factor(maps\mp\gametypes\_spawnfactor::avoidcornervisibleenemies, var_0)) {
    return "secondary";
  }

  return "primary";
}

scorefactors_nearteam(var_0) {
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(1.25, maps\mp\gametypes\_spawnfactor::preferalliesbydistance, var_0);
  var_0.totalscore = var_0.totalscore + var_1;
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(1.25, maps\mp\gametypes\_spawnfactor::avoidrecentlyused, var_0);
  var_0.totalscore = var_0.totalscore + var_1;
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(1.0, maps\mp\gametypes\_spawnfactor::avoidenemiesbydistance, var_0);
  var_0.totalscore = var_0.totalscore + var_1;
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(0.25, maps\mp\gametypes\_spawnfactor::avoidlastdeathlocation, var_0);
  var_0.totalscore = var_0.totalscore + var_1;
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(0.25, maps\mp\gametypes\_spawnfactor::avoidlastattackerlocation, var_0);
  var_0.totalscore = var_0.totalscore + var_1;
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(0.25, maps\mp\gametypes\_spawnfactor::avoidsamespawn, var_0);
  var_0.totalscore = var_0.totalscore + var_1;
}

scorefactors_twar(var_0, var_1) {
  var_2 = maps\mp\gametypes\_spawnfactor::score_factor(1.5, maps\mp\gametypes\_spawnfactor::avoidzone, var_0, var_1);
  var_0.totalscore = var_0.totalscore + var_2;
  var_2 = maps\mp\gametypes\_spawnfactor::score_factor(1.0, maps\mp\gametypes\_spawnfactor::preferplayeranchors, var_0);
  var_0.totalscore = var_0.totalscore + var_2;
  var_2 = maps\mp\gametypes\_spawnfactor::score_factor(1.0, maps\mp\gametypes\_spawnfactor::avoidenemiesbydistance, var_0);
  var_0.totalscore = var_0.totalscore + var_2;
  var_2 = maps\mp\gametypes\_spawnfactor::score_factor(-100.0, maps\mp\gametypes\_spawnfactor::avoidbadspawns, var_0);
  var_0.totalscore = var_0.totalscore + var_2;
}

getspawnpoint_domination(var_0, var_1) {
  var_0 = checkdynamicspawns(var_0);
  var_2["primary"] = [];
  var_2["secondary"] = [];
  var_2["bad"] = [];

  foreach(var_4 in var_0) {
    initscoredata(var_4);
    var_4.criticalresult = criticalfactors_domination(var_4);
    var_2[var_4.criticalresult][var_2[var_4.criticalresult].size] = var_4;
  }

  if(var_2["primary"].size) {
    var_6 = scorespawns_domination(var_2["primary"], var_1);
  } else if(var_2["secondary"].size) {
    var_6 = scorespawns_domination(var_2["secondary"], var_1);
  } else {
    var_6 = scorespawns_domination(var_0, var_1);
  }

  foreach(var_4 in var_0) {
    recon_log_spawnpoint_info(var_4);
    var_4.criticalresult = undefined;
  }

  return var_6;
}

scorespawns_domination(var_0, var_1) {
  var_2 = var_0[0];

  foreach(var_4 in var_0) {
    scorefactors_domination(var_4, var_1);

    if(var_4.totalscore > var_2.totalscore) {
      var_2 = var_4;
    }
  }

  var_2 = selectbestspawnpoint(var_2, var_0);
  return var_2;
}

criticalfactors_domination(var_0) {
  return criticalfactors_global(var_0);
}

scorefactors_domination(var_0, var_1) {
  var_2 = maps\mp\gametypes\_spawnfactor::score_factor(1.0, maps\mp\gametypes\_spawnfactor::preferdompoints, var_0, var_1);
  var_0.totalscore = var_0.totalscore + var_2;
  var_2 = maps\mp\gametypes\_spawnfactor::score_factor(1.0, maps\mp\gametypes\_spawnfactor::preferplayeranchors, var_0);
  var_0.totalscore = var_0.totalscore + var_2;
  var_2 = maps\mp\gametypes\_spawnfactor::score_factor(0.5, maps\mp\gametypes\_spawnfactor::avoidrecentlyused, var_0);
  var_0.totalscore = var_0.totalscore + var_2;
  var_2 = maps\mp\gametypes\_spawnfactor::score_factor(1.5, maps\mp\gametypes\_spawnfactor::avoidenemiesbydistance, var_0);
  var_0.totalscore = var_0.totalscore + var_2;
  var_2 = maps\mp\gametypes\_spawnfactor::score_factor(0.25, maps\mp\gametypes\_spawnfactor::avoidlastdeathlocation, var_0);
  var_0.totalscore = var_0.totalscore + var_2;
  var_2 = maps\mp\gametypes\_spawnfactor::score_factor(0.25, maps\mp\gametypes\_spawnfactor::avoidsamespawn, var_0);
  var_0.totalscore = var_0.totalscore + var_2;
}

getspawnpoint_freeforall(var_0) {
  var_0 = checkdynamicspawns(var_0);
  var_1["primary"] = [];
  var_1["secondary"] = [];
  var_1["bad"] = [];

  foreach(var_3 in var_0) {
    initscoredata(var_3);
    var_3.criticalresult = criticalfactors_freeforall(var_3);
    var_1[var_3.criticalresult][var_1[var_3.criticalresult].size] = var_3;
  }

  if(var_1["primary"].size) {
    var_5 = scorespawns_freeforall(var_1["primary"]);
  } else if(var_1["secondary"].size) {
    var_5 = scorespawns_freeforall(var_1["secondary"]);
  } else {
    var_5 = scorespawns_freeforall(var_0);
  }

  foreach(var_3 in var_0) {
    recon_log_spawnpoint_info(var_3);
    var_3.criticalresult = undefined;
  }

  return var_5;
}

scorespawns_freeforall(var_0) {
  var_1 = var_0[0];

  foreach(var_3 in var_0) {
    scorefactors_freeforall(var_3);

    if(var_3.totalscore > var_1.totalscore) {
      var_1 = var_3;
    }
  }

  var_1 = selectbestspawnpoint(var_1, var_0);
  return var_1;
}

criticalfactors_freeforall(var_0) {
  return criticalfactors_global(var_0);
}

scorefactors_freeforall(var_0) {
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(1.5, maps\mp\gametypes\_spawnfactor::avoidenemiesbydistance, var_0);
  var_0.totalscore = var_0.totalscore + var_1;
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(1.0, maps\mp\gametypes\_spawnfactor::avoidrecentlyused, var_0);
  var_0.totalscore = var_0.totalscore + var_1;
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(0.25, maps\mp\gametypes\_spawnfactor::avoidlastdeathlocation, var_0);
  var_0.totalscore = var_0.totalscore + var_1;
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(0.25, maps\mp\gametypes\_spawnfactor::avoidlastattackerlocation, var_0);
  var_0.totalscore = var_0.totalscore + var_1;
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(0.25, maps\mp\gametypes\_spawnfactor::avoidsamespawn, var_0);
  var_0.totalscore = var_0.totalscore + var_1;
}

getspawnpoint_searchandrescue(var_0) {
  var_0 = checkdynamicspawns(var_0);
  var_1["primary"] = [];
  var_1["secondary"] = [];
  var_1["bad"] = [];

  foreach(var_3 in var_0) {
    initscoredata(var_3);
    var_3.criticalresult = criticalfactors_searchandrescue(var_3);
    var_1[var_3.criticalresult][var_1[var_3.criticalresult].size] = var_3;
  }

  if(var_1["primary"].size) {
    var_5 = scorespawns_searchandrescue(var_1["primary"]);
  } else if(var_1["secondary"].size) {
    var_5 = scorespawns_searchandrescue(var_1["secondary"]);
  } else {
    var_5 = scorespawns_searchandrescue(var_0);
  }

  foreach(var_3 in var_0) {
    recon_log_spawnpoint_info(var_3);
    var_3.criticalresult = undefined;
  }

  return var_5;
}

scorespawns_searchandrescue(var_0) {
  var_1 = var_0[0];

  foreach(var_3 in var_0) {
    scorefactors_searchandrescue(var_3);

    if(var_3.totalscore > var_1.totalscore) {
      var_1 = var_3;
    }
  }

  var_1 = selectbestspawnpoint(var_1, var_0);
  return var_1;
}

criticalfactors_searchandrescue(var_0) {
  return criticalfactors_global(var_0);
}

scorefactors_searchandrescue(var_0) {
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(3.0, maps\mp\gametypes\_spawnfactor::avoidenemiesbydistance, var_0);
  var_0.totalscore = var_0.totalscore + var_1;
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(1.0, maps\mp\gametypes\_spawnfactor::preferalliesbydistance, var_0);
  var_0.totalscore = var_0.totalscore + var_1;
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(0.5, maps\mp\gametypes\_spawnfactor::avoidlastdeathlocation, var_0);
  var_0.totalscore = var_0.totalscore + var_1;
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(0.5, maps\mp\gametypes\_spawnfactor::avoidlastattackerlocation, var_0);
  var_0.totalscore = var_0.totalscore + var_1;
}

getspawnpoint_hardpoint(var_0) {
  var_0 = checkdynamicspawns(var_0);
  var_1["primary"] = [];
  var_1["secondary"] = [];
  var_1["bad"] = [];
  var_2 = var_0[randomint(var_0.size)];

  foreach(var_4 in var_0) {
    initscoredata(var_4);
    var_4.criticalresult = criticalfactors_global(var_4);

    if(var_4.criticalresult == "bad") {
      continue;
    }
    var_1[var_4.criticalresult][var_1[var_4.criticalresult].size] = var_4;
  }

  if(var_1["primary"].size) {
    var_2 = scorespawns_hardpoint(var_1["primary"]);
  } else if(var_1["secondary"].size) {
    var_2 = scorespawns_hardpoint(var_1["secondary"]);
  } else {
    var_2 = scorespawns_hardpoint(var_0);
  }

  foreach(var_4 in var_0) {
    recon_log_spawnpoint_info(var_4);
    var_4.criticalresult = undefined;
  }

  return var_2;
}

scorespawns_hardpoint(var_0) {
  var_1 = var_0[randomint(var_0.size)];

  foreach(var_3 in var_0) {
    scorefactors_hardpoint(var_3);

    if(var_3.totalscore > var_1.totalscore) {
      var_1 = var_3;
    }
  }

  var_1 = selectbestspawnpoint(var_1, var_0);
  return var_1;
}

scorefactors_hardpoint(var_0) {
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(1.5, maps\mp\gametypes\_spawnfactor::avoidzone, var_0, level.zone);
  var_0.totalscore = var_0.totalscore + var_1;
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(1.0, maps\mp\gametypes\_spawnfactor::preferplayeranchors, var_0);
  var_0.totalscore = var_0.totalscore + var_1;
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(1.0, maps\mp\gametypes\_spawnfactor::avoidenemiesbydistance, var_0);
  var_0.totalscore = var_0.totalscore + var_1;
}

getspawnpoint_ctf(var_0, var_1) {
  var_0 = checkdynamicspawns(var_0);
  var_2["primary"] = [];
  var_2["secondary"] = [];
  var_2["bad"] = [];

  foreach(var_4 in var_0) {
    initscoredata(var_4);
    var_4.criticalresult = criticalfactors_awayfromenemies(var_4);
    var_2[var_4.criticalresult][var_2[var_4.criticalresult].size] = var_4;
  }

  if(var_2["primary"].size) {
    var_6 = scorespawns_ctf(var_2["primary"], var_1);
  } else if(var_2["secondary"].size) {
    var_6 = scorespawns_ctf(var_2["secondary"], var_1);
  } else {
    var_6 = scorespawns_ctf(var_0, var_1);
  }

  foreach(var_4 in var_0) {
    recon_log_spawnpoint_info(var_4);
    var_4.criticalresult = undefined;
  }

  return var_6;
}

scorespawns_ctf(var_0, var_1) {
  var_2 = var_0[0];

  foreach(var_4 in var_0) {
    scorefactors_ctf(var_4, var_1);

    if(var_4.totalscore > var_2.totalscore) {
      var_2 = var_4;
    }
  }

  var_2 = selectbestspawnpoint(var_2, var_0);
  return var_2;
}

scorefactors_ctf(var_0, var_1) {
  var_2 = maps\mp\gametypes\_spawnfactor::score_factor(1.0, maps\mp\gametypes\_spawnfactor::avoidenemiesbydistance, var_0);
  var_0.totalscore = var_0.totalscore + var_2;
  var_2 = maps\mp\gametypes\_spawnfactor::score_factor(0.25, maps\mp\gametypes\_spawnfactor::avoidsamespawn, var_0);
  var_0.totalscore = var_0.totalscore + var_2;
  var_2 = maps\mp\gametypes\_spawnfactor::score_factor(0.75, maps\mp\gametypes\_spawnfactor::avoidflagbydistance, var_0);
  var_0.totalscore = var_0.totalscore + var_2;
}

getspawnpoint_awayfromenemies(var_0, var_1) {
  var_0 = checkdynamicspawns(var_0);
  var_2["primary"] = [];
  var_2["secondary"] = [];
  var_2["bad"] = [];

  foreach(var_4 in var_0) {
    initscoredata(var_4);
    var_4.criticalresult = criticalfactors_awayfromenemies(var_4);
    var_2[var_4.criticalresult][var_2[var_4.criticalresult].size] = var_4;
  }

  if(var_2["primary"].size) {
    var_6 = scorespawns_awayfromenemies(var_2["primary"], var_1);
  } else if(var_2["secondary"].size) {
    var_6 = scorespawns_awayfromenemies(var_2["secondary"], var_1);
  } else {
    var_6 = scorespawns_awayfromenemies(var_0, var_1);
  }

  foreach(var_4 in var_0) {
    recon_log_spawnpoint_info(var_4);
    var_4.criticalresult = undefined;
  }

  return var_6;
}

scorespawns_awayfromenemies(var_0, var_1) {
  var_2 = var_0[0];

  foreach(var_4 in var_0) {
    scorefactors_awayfromenemies(var_4, var_1);

    if(var_4.totalscore > var_2.totalscore) {
      var_2 = var_4;
    }
  }

  var_2 = selectbestspawnpoint(var_2, var_0);
  return var_2;
}

criticalfactors_awayfromenemies(var_0) {
  return criticalfactors_global(var_0);
}

scorefactors_awayfromenemies(var_0, var_1) {
  var_2 = maps\mp\gametypes\_spawnfactor::score_factor(1.0, maps\mp\gametypes\_spawnfactor::avoidenemiesbydistance, var_0);
  var_0.totalscore = var_0.totalscore + var_2;
  var_2 = maps\mp\gametypes\_spawnfactor::score_factor(0.25, maps\mp\gametypes\_spawnfactor::avoidsamespawn, var_0);
  var_0.totalscore = var_0.totalscore + var_2;
}

getspawnpoint_safeguard(var_0) {
  var_0 = checkdynamicspawns(var_0);
  var_1["primary"] = [];
  var_1["secondary"] = [];
  var_1["bad"] = [];

  foreach(var_3 in var_0) {
    initscoredata(var_3);
    var_3.criticalresult = criticalfactors_safeguard(var_3);
    var_1[var_3.criticalresult][var_1[var_3.criticalresult].size] = var_3;
  }

  if(var_1["primary"].size) {
    var_5 = scorespawns_safeguard(var_1["primary"]);
  } else if(var_1["secondary"].size) {
    var_5 = scorespawns_safeguard(var_1["secondary"]);
  } else {
    var_5 = scorespawns_safeguard(var_0);
  }

  foreach(var_3 in var_0) {
    var_3.criticalresult = undefined;
  }

  return var_5;
}

scorespawns_safeguard(var_0) {
  var_1 = var_0[0];

  foreach(var_3 in var_0) {
    scorefactors_safeguard(var_3);

    if(var_3.totalscore > var_1.totalscore) {
      var_1 = var_3;
    }
  }

  var_1 = selectbestspawnpoint(var_1, var_0);
  return var_1;
}

criticalfactors_safeguard(var_0) {
  return criticalfactors_global(var_0);
}

scorefactors_safeguard(var_0) {
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(1.0, maps\mp\gametypes\_spawnfactor::randomspawnscore, var_0);
  var_0.totalscore = var_0.totalscore + var_1;
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(1.0, maps\mp\gametypes\_spawnfactor::preferalliesbydistance, var_0);
  var_0.totalscore = var_0.totalscore + var_1;
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(0.5, maps\mp\gametypes\_spawnfactor::avoidenemiesbydistance, var_0);
  var_0.totalscore = var_0.totalscore + var_1;
}