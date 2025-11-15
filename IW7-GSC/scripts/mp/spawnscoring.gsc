/***************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\spawnscoring.gsc
***************************************/

checkdynamicspawns(param_00) {
  if(isDefined(level.dynamicspawns)) {
    param_00 = [[level.dynamicspawns]](param_00);
  }

  return param_00;
}

selectbestspawnpoint(param_00, param_01) {
  var_02 = param_00;
  return var_02;
}

func_6CB1() {
  if(!level.teambased || isDefined(level.var_112BF) && !level.var_112BF) {
    return undefined;
  }

  var_00 = isonground(self.team);
  var_01 = [];
  foreach(var_03 in var_00) {
    var_04 = findspawnlocationnearplayer(var_03);
    if(!isDefined(var_04)) {
      continue;
    }

    var_05 = spawnStruct();
    var_05.origin = var_04;
    var_05.angles = func_7E0F(var_03, var_05.origin);
    var_05.index = -1;
    var_05.budgetedents = 1;
    var_05.isdynamicspawn = 1;
    var_05 scripts\mp\spawnlogic::func_108FA();
    if(isDefined(var_03.analyticslog) && isDefined(var_03.analyticslog.playerid)) {
      var_05.buddyspawnid = var_03.analyticslog.playerid;
    }

    var_01[var_01.size] = var_05;
  }

  var_07 = [];
  func_12F1E(var_01);
  foreach(var_05 in var_01) {
    if(!func_11746(var_05)) {
      continue;
    }

    scorebuddyspawn(var_05);
    var_07[var_07.size] = var_05;
  }

  var_0A = undefined;
  foreach(var_05 in var_07) {
    if(!isDefined(var_0A) || var_05.totalscore > var_0A.totalscore) {
      var_0A = var_05;
    }
  }

  return var_0A;
}

scorebuddyspawn(param_00) {
  scripts\mp\spawnfactor::calculatefactorscore(param_00, "avoidShortTimeToEnemySight", 1);
  scripts\mp\spawnfactor::calculatefactorscore(param_00, "avoidClosestEnemy", 1);
}

func_7E0F(param_00, param_01) {
  var_02 = (0, param_00.angles[1], 0);
  var_03 = findentrances(param_01);
  if(isDefined(var_03) && var_03.size > 0) {
    var_02 = vectortoangles(var_03[0].origin - param_01);
  }

  return var_02;
}

isonground(param_00) {
  var_01 = [];
  foreach(var_03 in level.players) {
    if(var_03.team != param_00) {
      continue;
    }

    if(var_03 == self) {
      continue;
    }

    if(!canplayerbebuddyspawnedon(var_03)) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  return scripts\engine\utility::array_randomize(var_01);
}

canplayerbebuddyspawnedon(param_00) {
  if(param_00.sessionstate != "playing") {
    return 0;
  }

  if(!scripts\mp\utility::isreallyalive(param_00)) {
    return 0;
  }

  if(!param_00 isonground()) {
    return 0;
  }

  if(param_00 isonladder()) {
    return 0;
  }

  if(param_00 scripts\engine\utility::isflashed()) {
    return 0;
  }

  if(param_00.health < param_00.maxhealth && !isDefined(param_00.lastdamagedtime) || gettime() < param_00.lastdamagedtime + 3000) {
    return 0;
  }

  return 1;
}

findspawnlocationnearplayer(param_00) {
  var_01 = scripts\mp\spawnlogic::getplayertraceheight(param_00, 1);
  var_02 = findbuddypathnode(param_00, var_01, 0.5);
  if(isDefined(var_02)) {
    return var_02.origin;
  }

  return undefined;
}

findbuddypathnode(param_00, param_01, param_02) {
  var_03 = getnodesinradiussorted(param_00.origin, 192, 64, param_01, "Path");
  var_04 = undefined;
  if(isDefined(var_03) && var_03.size > 0) {
    var_05 = anglesToForward(param_00.angles);
    foreach(var_07 in var_03) {
      var_08 = vectornormalize(var_07.origin - param_00.origin);
      var_09 = vectordot(var_05, var_08);
      if(var_09 <= param_02 && !positionwouldtelefrag(var_07.origin)) {
        var_04 = var_07;
        if(var_09 <= 0) {
          break;
        }
      }
    }
  }

  return var_04;
}

func_6CB5(param_00, param_01, param_02, param_03) {
  var_04 = getnodesinradiussorted(param_00.origin, param_03, 32, param_01, "Path");
  var_05 = undefined;
  if(isDefined(var_04) && var_04.size > 0) {
    var_06 = anglesToForward(param_00.angles);
    foreach(var_08 in var_04) {
      var_09 = var_08.origin + (0, 0, param_01);
      if(capsuletracepassed(var_09, param_02, param_02 * 2 + 0.01, undefined, 1, 1)) {
        if(bullettracepassed(param_00 getEye(), var_09, 0, param_00)) {
          var_05 = var_09;
          break;
        }
      }
    }
  }

  return var_05;
}

func_98C8(param_00) {
  param_00.totalscore = 0;
  param_00.var_11A3A = 0;
  param_00.var_9D60 = 0;
  param_00.var_A9E9 = [];
  param_00.var_A9E9["allies"] = 0;
  param_00.var_A9E9["axis"] = 0;
  param_00.lastspawnteam = "";
  param_00.lastspawntime = 0;
  param_00.analytics = spawnStruct();
  param_00.analytics.allyaveragedist = 0;
  param_00.analytics.enemyaveragedist = 0;
  param_00.analytics.timesincelastspawn = 0;
  param_00.analytics.maxenemysightfraction = 0;
  param_00.analytics.randomscore = 0;
  param_00.analytics.maxjumpingenemysightfraction = 0;
  param_00.analytics.spawnusedbyenemies = 0;
  param_00.analytics.spawntype = 0;
}

func_12F1E(param_00) {
  var_01 = scripts\mp\spawnlogic::getspawnteam(self);
  scripts\mp\spawnlogic::func_12F1F();
  var_02 = scripts\mp\spawnlogic::getactiveplayerlist();
  foreach(var_04 in param_00) {
    func_98C8(var_04);
    scripts\mp\spawnlogic::func_108F9(var_04, var_02);
    scripts\mp\spawnlogic::func_67D3(var_04, var_01);
  }

  scripts\mp\spawnfactor::updatefrontline(var_01);
}

func_11748(param_00) {
  if(!scripts\mp\spawnfactor::critical_factor(::scripts\mp\spawnfactor::func_26B7, param_00)) {
    param_00.badspawnreason = 0;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(::scripts\mp\spawnfactor::func_26B8, param_00)) {
    param_00.badspawnreason = 1;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(::scripts\mp\spawnfactor::func_26BC, param_00)) {
    param_00.badspawnreason = 2;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(::scripts\mp\spawnfactor::func_26AB, param_00)) {
    param_00.badspawnreason = 3;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(::scripts\mp\spawnfactor::avoidcarepackages, param_00)) {
    param_00.badspawnreason = 4;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(::scripts\mp\spawnfactor::func_26C4, param_00)) {
    param_00.badspawnreason = 5;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(::scripts\mp\spawnfactor::func_26B6, param_00)) {
    param_00.badspawnreason = 6;
    return "bad";
  }

  if(isDefined(param_00.var_7450) && level.var_744D.isactive[self.team] && param_00.var_7450 != self.team) {
    param_00.badspawnreason = 7;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(::scripts\mp\spawnfactor::func_26B3, param_00)) {
    return "secondary";
  }

  if(!scripts\mp\spawnfactor::critical_factor(::scripts\mp\spawnfactor::func_26AE, param_00)) {
    return "secondary";
  }

  return "primary";
}

func_11746(param_00) {
  if(!scripts\mp\spawnfactor::critical_factor(::scripts\mp\spawnfactor::func_26B7, param_00)) {
    return 0;
  }

  if(!scripts\mp\spawnfactor::critical_factor(::scripts\mp\spawnfactor::func_26B8, param_00)) {
    return 0;
  }

  if(!scripts\mp\spawnfactor::critical_factor(::scripts\mp\spawnfactor::func_26BC, param_00)) {
    return 0;
  }

  if(!scripts\mp\spawnfactor::critical_factor(::scripts\mp\spawnfactor::func_26AB, param_00)) {
    return 0;
  }

  if(!scripts\mp\spawnfactor::critical_factor(::scripts\mp\spawnfactor::avoidcarepackages, param_00)) {
    return 0;
  }

  if(!scripts\mp\spawnfactor::critical_factor(::scripts\mp\spawnfactor::func_26C4, param_00)) {
    return 0;
  }

  if(!scripts\mp\spawnfactor::critical_factor(::scripts\mp\spawnfactor::func_26AE, param_00)) {
    return 0;
  }

  return 1;
}

getstartspawnpoint_freeforall(param_00) {
  if(!isDefined(param_00)) {
    return undefined;
  }

  var_01 = undefined;
  var_02 = scripts\mp\spawnlogic::getactiveplayerlist();
  param_00 = checkdynamicspawns(param_00);
  if(!isDefined(var_02) || var_02.size == 0) {
    return scripts\mp\spawnlogic::getspawnpoint_random(param_00);
  }

  var_03 = 0;
  foreach(var_05 in param_00) {
    if(canspawn(var_05.origin) && !positionwouldtelefrag(var_05.origin)) {
      var_06 = undefined;
      foreach(var_08 in var_02) {
        var_09 = distancesquared(var_05.origin, var_08.origin);
        if(!isDefined(var_06) || var_09 < var_06) {
          var_06 = var_09;
        }
      }

      if(!isDefined(var_01) || var_06 > var_03) {
        var_01 = var_05;
        var_03 = var_06;
      }
    }
  }

  if(!isDefined(var_01)) {
    return scripts\mp\spawnlogic::getspawnpoint_random(param_00);
  }

  return var_01;
}

logbadspawn(param_00, param_01) {
  if(isDefined(param_01) && isDefined(param_01.disablespawnwarnings) && param_01.disablespawnwarnings) {
    return;
  }

  if(!isDefined(param_00)) {
    param_00 = "";
  } else {
    param_00 = param_00;
  }

  if(isDefined(level.matchrecording_logeventmsg)) {
    [[level.matchrecording_logeventmsg]]("LOG_BAD_SPAWN", gettime(), param_00);
  }
}

getspawnpoint(param_00, param_01, param_02, param_03) {
  level.spawnglobals.spawnpointslist = param_00;
  if(level.var_72A2) {
    var_04 = func_6CB1();
    if(isDefined(var_04)) {
      return var_04;
    }
  }

  var_05 = undefined;
  level.spawnglobals.spawn_type = 0;
  var_06 = getmuzzlepos(param_00, param_02, 0);
  if(isDefined(var_06)) {
    if(!scripts\mp\utility::istrue(var_06.var_9D60)) {
      return var_06;
    } else {
      var_05 = var_06;
    }
  }

  if(isDefined(param_01)) {
    var_07 = getmuzzlepos(param_01, param_02, 3);
    if(isDefined(var_07)) {
      if(scripts\mp\utility::istrue(var_07.var_9D60)) {
        if(!isDefined(var_05) || var_07.totalscore > var_05.totalscore) {
          var_05 = var_07;
        }
      } else {
        logbadspawn("Using a fallback spawn.", self);
        return var_07;
      }
    }
  }

  if(scripts\mp\utility::istrue(param_03)) {
    return undefined;
  }

  logbadspawn("Using a LastResort spawn point.", self);
  var_08 = func_6CB1();
  if(isDefined(var_08)) {
    var_08.spawntype = 7;
    level.spawnglobals.budy_death_watcher = 0;
    if(isDefined(var_08.buddyspawnid)) {
      level.spawnglobals.buddyspawnid = var_08.buddyspawnid;
    }

    return var_08;
  }

  logbadspawn("UNABLE TO BUDDY SPAWN. EXTREMELY BAD", self);
  if(level.teambased && !scripts\mp\utility::isanymlgmatch()) {
    var_09 = level.spawnglobals.lastbadspawntime[self.team];
    if(isDefined(var_09) && gettime() - var_09 < 5000) {
      var_05 = param_00[randomint(param_00.size)];
    } else {
      level.spawnglobals.lastbadspawntime[self.team] = gettime();
    }
  }

  return var_05;
}

getmuzzlepos(param_00, param_01, param_02) {
  param_00 = checkdynamicspawns(param_00);
  var_03["primary"] = [];
  var_03["secondary"] = [];
  var_03["bad"] = [];
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

  func_12F1E(param_00);
  foreach(var_05 in param_00) {
    var_06 = func_11748(var_05);
    var_03[var_06][var_03[var_06].size] = var_05;
    var_05.lastbucket[scripts\engine\utility::ter_op(isDefined(self.var_108DF), self.var_108DF, self.team)] = var_06;
    if(isDefined(var_05.analytics) && isDefined(var_05.analytics.spawntype)) {
      if(var_06 == "primary") {
        var_05.analytics.spawntype = param_02 + 1;
        continue;
      }

      if(var_06 == "secondary") {
        var_05.analytics.spawntype = param_02 + 2;
        continue;
      }

      var_05.analytics.spawntype = param_02 + 3;
    }
  }

  if(var_03["primary"].size) {
    var_06 = func_7F01(var_03["primary"], param_01);
    var_06.spawn_type = 1;
    return var_06;
  }

  if(var_03["secondary"].size) {
    var_06 = func_7F01(var_03["secondary"], param_01);
    var_06.spawn_type = 2;
    return var_06;
  }

  if(var_03["bad"].size) {
    logbadspawn("Using Bad Spawn", self);
    var_06 = func_7F01(var_03["bad"], param_01);
    if(isDefined(var_06)) {
      var_06.var_9D60 = 1;
    }

    return var_06;
  }

  return undefined;
}

func_7F01(param_00, param_01) {
  var_02 = param_00[0];
  foreach(var_04 in param_00) {
    scripts\mp\spawnlogic::func_EC46(var_04, param_01);
    if(var_04.totalscore > var_02.totalscore) {
      var_02 = var_04;
    }
  }

  var_02 = selectbestspawnpoint(var_02, param_00);
  return var_02;
}