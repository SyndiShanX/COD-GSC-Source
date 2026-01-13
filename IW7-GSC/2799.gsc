/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2799.gsc
**************************************/

checkdynamicspawns(var_0) {
  if(isDefined(level.dynamicspawns)) {
    var_0 = [[level.dynamicspawns]](var_0);
  }

  return var_0;
}

selectbestspawnpoint(var_0, var_1) {
  var_2 = var_0;
  return var_2;
}

func_6CB1() {
  if(!level.teambased || isDefined(level.var_112BF) && !level.var_112BF) {
    return undefined;
  }

  var_0 = isonground(self.team);
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = findspawnlocationnearplayer(var_3);

    if(!isDefined(var_4)) {
      continue;
    }
    var_5 = spawnStruct();
    var_5.origin = var_4;
    var_5.angles = func_7E0F(var_3, var_5.origin);
    var_5.index = -1;
    var_5.budgetedents = 1;
    var_5.isdynamicspawn = 1;
    var_5 scripts\mp\spawnlogic::func_108FA();

    if(isDefined(var_3.analyticslog) && isDefined(var_3.analyticslog.playerid)) {
      var_5.buddyspawnid = var_3.analyticslog.playerid;
    }

    var_1[var_1.size] = var_5;
  }

  var_7 = [];
  func_12F1E(var_1);

  foreach(var_5 in var_1) {
    if(!func_11746(var_5)) {
      continue;
    }
    scorebuddyspawn(var_5);
    var_7[var_7.size] = var_5;
  }

  var_10 = undefined;

  foreach(var_5 in var_7) {
    if(!isDefined(var_10) || var_5.totalscore > var_10.totalscore) {
      var_10 = var_5;
    }
  }

  return var_10;
}

scorebuddyspawn(var_0) {
  scripts\mp\spawnfactor::calculatefactorscore(var_0, "avoidShortTimeToEnemySight", 1.0);
  scripts\mp\spawnfactor::calculatefactorscore(var_0, "avoidClosestEnemy", 1.0);
}

func_7E0F(var_0, var_1) {
  var_2 = (0, var_0.angles[1], 0);
  var_3 = findentrances(var_1);

  if(isDefined(var_3) && var_3.size > 0) {
    var_2 = vectortoangles(var_3[0].origin - var_1);
  }

  return var_2;
}

isonground(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3.team != var_0) {
      continue;
    }
    if(var_3 == self) {
      continue;
    }
    if(!canplayerbebuddyspawnedon(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return scripts\engine\utility::array_randomize(var_1);
}

canplayerbebuddyspawnedon(var_0) {
  if(var_0.sessionstate != "playing") {
    return 0;
  }

  if(!scripts\mp\utility\game::isreallyalive(var_0)) {
    return 0;
  }

  if(!var_0 isonground()) {
    return 0;
  }

  if(var_0 isonladder()) {
    return 0;
  }

  if(var_0 scripts\engine\utility::isflashed()) {
    return 0;
  }

  if(var_0.health < var_0.maxhealth && (!isDefined(var_0.lastdamagedtime) || gettime() < var_0.lastdamagedtime + 3000)) {
    return 0;
  }

  return 1;
}

findspawnlocationnearplayer(var_0) {
  var_1 = scripts\mp\spawnlogic::getplayertraceheight(var_0, 1);
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
        var_4 = var_7;

        if(var_9 <= 0.0) {
          break;
        }
      }
    }
  }

  return var_4;
}

func_6CB5(var_0, var_1, var_2, var_3) {
  var_4 = getnodesinradiussorted(var_0.origin, var_3, 32, var_1, "Path");
  var_5 = undefined;

  if(isDefined(var_4) && var_4.size > 0) {
    var_6 = anglesToForward(var_0.angles);

    foreach(var_8 in var_4) {
      var_9 = var_8.origin + (0, 0, var_1);

      if(capsuletracepassed(var_9, var_2, var_2 * 2 + 0.01, undefined, 1, 1)) {
        if(bullettracepassed(var_0 getEye(), var_9, 0, var_0)) {
          var_5 = var_9;
          break;
        }
      }
    }
  }

  return var_5;
}

func_98C8(var_0) {
  var_0.totalscore = 0;
  var_0.var_11A3A = 0;
  var_0.var_9D60 = 0;
  var_0.var_A9E9 = [];
  var_0.var_A9E9["allies"] = 0;
  var_0.var_A9E9["axis"] = 0;
  var_0.lastspawnteam = "";
  var_0.lastspawntime = 0;
  var_0.analytics = spawnStruct();
  var_0.analytics.allyaveragedist = 0;
  var_0.analytics.enemyaveragedist = 0;
  var_0.analytics.timesincelastspawn = 0;
  var_0.analytics.maxenemysightfraction = 0;
  var_0.analytics.randomscore = 0;
  var_0.analytics.maxjumpingenemysightfraction = 0;
  var_0.analytics.spawnusedbyenemies = 0;
  var_0.analytics.spawntype = 0;
}

func_12F1E(var_0) {
  var_1 = scripts\mp\spawnlogic::getspawnteam(self);
  scripts\mp\spawnlogic::func_12F1F();
  var_2 = scripts\mp\spawnlogic::getactiveplayerlist();

  foreach(var_4 in var_0) {
    func_98C8(var_4);
    scripts\mp\spawnlogic::func_108F9(var_4, var_2);
    scripts\mp\spawnlogic::func_67D3(var_4, var_1);
  }

  scripts\mp\spawnfactor::updatefrontline(var_1);
}

func_11748(var_0) {
  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26B7, var_0)) {
    var_0.badspawnreason = 0;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26B8, var_0)) {
    var_0.badspawnreason = 1;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26BC, var_0)) {
    var_0.badspawnreason = 2;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26AB, var_0)) {
    var_0.badspawnreason = 3;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::avoidcarepackages, var_0)) {
    var_0.badspawnreason = 4;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26C4, var_0)) {
    var_0.badspawnreason = 5;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26B6, var_0)) {
    var_0.badspawnreason = 6;
    return "bad";
  }

  if(isDefined(var_0.var_7450) && level.var_744D.isactive[self.team] && var_0.var_7450 != self.team) {
    var_0.badspawnreason = 7;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26B3, var_0)) {
    return "secondary";
  }

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26AE, var_0)) {
    return "secondary";
  }

  return "primary";
}

func_11746(var_0) {
  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26B7, var_0)) {
    return 0;
  }

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26B8, var_0)) {
    return 0;
  }

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26BC, var_0)) {
    return 0;
  }

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26AB, var_0)) {
    return 0;
  }

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::avoidcarepackages, var_0)) {
    return 0;
  }

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26C4, var_0)) {
    return 0;
  }

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26AE, var_0)) {
    return 0;
  }

  return 1;
}

getstartspawnpoint_freeforall(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = undefined;
  var_2 = scripts\mp\spawnlogic::getactiveplayerlist();
  var_0 = checkdynamicspawns(var_0);

  if(!isDefined(var_2) || var_2.size == 0) {
    return scripts\mp\spawnlogic::getspawnpoint_random(var_0);
  }

  var_3 = 0;

  foreach(var_5 in var_0) {
    if(canspawn(var_5.origin) && !positionwouldtelefrag(var_5.origin)) {
      var_6 = undefined;

      foreach(var_8 in var_2) {
        var_9 = distancesquared(var_5.origin, var_8.origin);

        if(!isDefined(var_6) || var_9 < var_6) {
          var_6 = var_9;
        }
      }

      if(!isDefined(var_1) || var_6 > var_3) {
        var_1 = var_5;
        var_3 = var_6;
      }
    }
  }

  if(!isDefined(var_1)) {
    return scripts\mp\spawnlogic::getspawnpoint_random(var_0);
  }

  return var_1;
}

logbadspawn(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.disablespawnwarnings) && var_1.disablespawnwarnings) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = "";
  } else {
    var_0 = var_0;
  }

  if(isDefined(level.matchrecording_logeventmsg)) {
    [[level.matchrecording_logeventmsg]]("LOG_BAD_SPAWN", gettime(), var_0);
  }
}

getspawnpoint(var_0, var_1, var_2, var_3) {
  level.spawnglobals.spawnpointslist = var_0;

  if(level.var_72A2) {
    var_4 = func_6CB1();

    if(isDefined(var_4)) {
      return var_4;
    }
  }

  var_5 = undefined;
  level.spawnglobals.spawn_type = 0;
  var_6 = getmuzzlepos(var_0, var_2, 0);

  if(isDefined(var_6)) {
    if(!scripts\mp\utility\game::istrue(var_6.var_9D60)) {
      return var_6;
    } else {
      var_5 = var_6;
    }
  }

  if(isDefined(var_1)) {
    var_7 = getmuzzlepos(var_1, var_2, 3);

    if(isDefined(var_7)) {
      if(scripts\mp\utility\game::istrue(var_7.var_9D60)) {
        if(!isDefined(var_5) || var_7.totalscore > var_5.totalscore) {
          var_5 = var_7;
        }
      } else {
        logbadspawn("Using a fallback spawn.", self);
        return var_7;
      }
    }
  }

  if(scripts\mp\utility\game::istrue(var_3)) {
    return undefined;
  }

  logbadspawn("Using a LastResort spawn point.", self);
  var_8 = func_6CB1();

  if(isDefined(var_8)) {
    var_8.spawntype = 7;
    level.spawnglobals.budy_death_watcher = 0;

    if(isDefined(var_8.buddyspawnid)) {
      level.spawnglobals.buddyspawnid = var_8.buddyspawnid;
    }

    return var_8;
  }

  logbadspawn("UNABLE TO BUDDY SPAWN. EXTREMELY BAD", self);

  if(level.teambased && !scripts\mp\utility\game::isanymlgmatch()) {
    var_9 = level.spawnglobals.lastbadspawntime[self.team];

    if(isDefined(var_9) && gettime() - var_9 < 5000) {
      var_5 = var_0[randomint(var_0.size)];
    } else {
      level.spawnglobals.lastbadspawntime[self.team] = gettime();
    }
  }

  return var_5;
}

getmuzzlepos(var_0, var_1, var_2) {
  var_0 = checkdynamicspawns(var_0);
  var_3["primary"] = [];
  var_3["secondary"] = [];
  var_3["bad"] = [];

  if(scripts\mp\spawnlogic::shoulduseprecomputedlos() && !scripts\mp\spawnlogic::isttlosdataavailable()) {
    if(isDefined(level.matchrecording_logeventmsg)) {
      [
        [level.matchrecording_logeventmsg]
      ]("LOG_GENERIC_MESSAGE", gettime(), "ERROR: TTLOS System disabled! Could not access visDistData");
    }

    if(!isDefined(level.var_8C28)) {
      level.var_8C28 = 1;
    }

    level.var_560C = 1;
    scripts\mp\spawnlogic::func_E2B6();
  }

  func_12F1E(var_0);

  foreach(var_5 in var_0) {
    var_6 = func_11748(var_5);
    var_3[var_6][var_3[var_6].size] = var_5;
    var_5.lastbucket[scripts\engine\utility::ter_op(isDefined(self.var_108DF), self.var_108DF, self.team)] = var_6;

    if(isDefined(var_5.analytics) && isDefined(var_5.analytics.spawntype)) {
      if(var_6 == "primary") {
        var_5.analytics.spawntype = var_2 + 1;
        continue;
      }

      if(var_6 == "secondary") {
        var_5.analytics.spawntype = var_2 + 2;
        continue;
      }

      var_5.analytics.spawntype = var_2 + 3;
    }
  }

  if(var_3["primary"].size) {
    var_6 = func_7F01(var_3["primary"], var_1);
    var_6.spawn_type = 1;
    return var_6;
  }

  if(var_3["secondary"].size) {
    var_6 = func_7F01(var_3["secondary"], var_1);
    var_6.spawn_type = 2;
    return var_6;
  }

  if(var_3["bad"].size) {
    logbadspawn("Using Bad Spawn", self);
    var_6 = func_7F01(var_3["bad"], var_1);

    if(isDefined(var_6)) {
      var_6.var_9D60 = 1;
    }

    return var_6;
  }

  return undefined;
}

func_7F01(var_0, var_1) {
  var_2 = var_0[0];

  foreach(var_4 in var_0) {
    scripts\mp\spawnlogic::func_EC46(var_4, var_1);

    if(var_4.totalscore > var_2.totalscore) {
      var_2 = var_4;
    }
  }

  var_2 = selectbestspawnpoint(var_2, var_0);
  return var_2;
}