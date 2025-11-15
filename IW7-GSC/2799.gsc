/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2799.gsc
***************************************/

checkdynamicspawns(var_00) {
  if(isDefined(level.dynamicspawns))
    var_00 = [[level.dynamicspawns]](var_00);

  return var_00;
}

selectbestspawnpoint(var_00, var_01) {
  var_02 = var_00;
  return var_02;
}

func_6CB1() {
  if(!level.teambased || isDefined(level.func_112BF) && !level.func_112BF)
    return undefined;

  var_00 = isonground(self.team);
  var_01 = [];

  foreach(var_03 in var_00) {
    var_04 = findspawnlocationnearplayer(var_03);

    if(!isDefined(var_04)) {
      continue;
    }
    var_05 = spawnStruct();
    var_5.origin = var_04;
    var_5.angles = func_7E0F(var_03, var_5.origin);
    var_5.index = -1;
    var_5.budgetedents = 1;
    var_5.isdynamicspawn = 1;
    var_05 scripts\mp\spawnlogic::func_108FA();

    if(isDefined(var_3.analyticslog) && isDefined(var_3.analyticslog.playerid))
      var_5.buddyspawnid = var_3.analyticslog.playerid;

    var_1[var_1.size] = var_05;
  }

  var_07 = [];
  func_12F1E(var_01);

  foreach(var_05 in var_01) {
    if(!func_11746(var_05)) {
      continue;
    }
    scorebuddyspawn(var_05);
    var_7[var_7.size] = var_05;
  }

  var_10 = undefined;

  foreach(var_05 in var_07) {
    if(!isDefined(var_10) || var_5.totalscore > var_10.totalscore)
      var_10 = var_05;
  }

  return var_10;
}

scorebuddyspawn(var_00) {
  scripts\mp\spawnfactor::calculatefactorscore(var_00, "avoidShortTimeToEnemySight", 1.0);
  scripts\mp\spawnfactor::calculatefactorscore(var_00, "avoidClosestEnemy", 1.0);
}

func_7E0F(var_00, var_01) {
  var_02 = (0, var_0.angles[1], 0);
  var_03 = findentrances(var_01);

  if(isDefined(var_03) && var_3.size > 0)
    var_02 = vectortoangles(var_3[0].origin - var_01);

  return var_02;
}

isonground(var_00) {
  var_01 = [];

  foreach(var_03 in level.players) {
    if(var_3.team != var_00) {
      continue;
    }
    if(var_03 == self) {
      continue;
    }
    if(!canplayerbebuddyspawnedon(var_03)) {
      continue;
    }
    var_1[var_1.size] = var_03;
  }

  return scripts\engine\utility::array_randomize(var_01);
}

canplayerbebuddyspawnedon(var_00) {
  if(var_0.sessionstate != "playing")
    return 0;

  if(!scripts\mp\utility\game::isreallyalive(var_00))
    return 0;

  if(!var_00 isonground())
    return 0;

  if(var_00 isonladder())
    return 0;

  if(var_00 scripts\engine\utility::isflashed())
    return 0;

  if(var_0.health < var_0.maxhealth && (!isDefined(var_0.lastdamagedtime) || gettime() < var_0.lastdamagedtime + 3000))
    return 0;

  return 1;
}

findspawnlocationnearplayer(var_00) {
  var_01 = scripts\mp\spawnlogic::getplayertraceheight(var_00, 1);
  var_02 = findbuddypathnode(var_00, var_01, 0.5);

  if(isDefined(var_02))
    return var_2.origin;

  return undefined;
}

findbuddypathnode(var_00, var_01, var_02) {
  var_03 = getnodesinradiussorted(var_0.origin, 192, 64, var_01, "Path");
  var_04 = undefined;

  if(isDefined(var_03) && var_3.size > 0) {
    var_05 = anglesToForward(var_0.angles);

    foreach(var_07 in var_03) {
      var_08 = vectornormalize(var_7.origin - var_0.origin);
      var_09 = vectordot(var_05, var_08);

      if(var_09 <= var_02 && !positionwouldtelefrag(var_7.origin)) {
        var_04 = var_07;

        if(var_09 <= 0.0) {
          break;
        }
      }
    }
  }

  return var_04;
}

func_6CB5(var_00, var_01, var_02, var_03) {
  var_04 = getnodesinradiussorted(var_0.origin, var_03, 32, var_01, "Path");
  var_05 = undefined;

  if(isDefined(var_04) && var_4.size > 0) {
    var_06 = anglesToForward(var_0.angles);

    foreach(var_08 in var_04) {
      var_09 = var_8.origin + (0, 0, var_01);

      if(capsuletracepassed(var_09, var_02, var_02 * 2 + 0.01, undefined, 1, 1)) {
        if(bullettracepassed(var_00 getEye(), var_09, 0, var_00)) {
          var_05 = var_09;
          break;
        }
      }
    }
  }

  return var_05;
}

func_98C8(var_00) {
  var_0.totalscore = 0;
  var_0.func_11A3A = 0;
  var_0.func_9D60 = 0;
  var_0.func_A9E9 = [];
  var_0.func_A9E9["allies"] = 0;
  var_0.func_A9E9["axis"] = 0;
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

func_12F1E(var_00) {
  var_01 = scripts\mp\spawnlogic::getspawnteam(self);
  scripts\mp\spawnlogic::func_12F1F();
  var_02 = scripts\mp\spawnlogic::getactiveplayerlist();

  foreach(var_04 in var_00) {
    func_98C8(var_04);
    scripts\mp\spawnlogic::func_108F9(var_04, var_02);
    scripts\mp\spawnlogic::func_67D3(var_04, var_01);
  }

  scripts\mp\spawnfactor::updatefrontline(var_01);
}

func_11748(var_00) {
  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26B7, var_00)) {
    var_0.badspawnreason = 0;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26B8, var_00)) {
    var_0.badspawnreason = 1;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26BC, var_00)) {
    var_0.badspawnreason = 2;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26AB, var_00)) {
    var_0.badspawnreason = 3;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::avoidcarepackages, var_00)) {
    var_0.badspawnreason = 4;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26C4, var_00)) {
    var_0.badspawnreason = 5;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26B6, var_00)) {
    var_0.badspawnreason = 6;
    return "bad";
  }

  if(isDefined(var_0.func_7450) && level.func_744D.isactive[self.team] && var_0.func_7450 != self.team) {
    var_0.badspawnreason = 7;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26B3, var_00))
    return "secondary";

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26AE, var_00))
    return "secondary";

  return "primary";
}

func_11746(var_00) {
  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26B7, var_00))
    return 0;

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26B8, var_00))
    return 0;

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26BC, var_00))
    return 0;

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26AB, var_00))
    return 0;

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::avoidcarepackages, var_00))
    return 0;

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26C4, var_00))
    return 0;

  if(!scripts\mp\spawnfactor::critical_factor(scripts\mp\spawnfactor::func_26AE, var_00))
    return 0;

  return 1;
}

getstartspawnpoint_freeforall(var_00) {
  if(!isDefined(var_00))
    return undefined;

  var_01 = undefined;
  var_02 = scripts\mp\spawnlogic::getactiveplayerlist();
  var_00 = checkdynamicspawns(var_00);

  if(!isDefined(var_02) || var_2.size == 0)
    return scripts\mp\spawnlogic::getspawnpoint_random(var_00);

  var_03 = 0;

  foreach(var_05 in var_00) {
    if(canspawn(var_5.origin) && !positionwouldtelefrag(var_5.origin)) {
      var_06 = undefined;

      foreach(var_08 in var_02) {
        var_09 = distancesquared(var_5.origin, var_8.origin);

        if(!isDefined(var_06) || var_09 < var_06)
          var_06 = var_09;
      }

      if(!isDefined(var_01) || var_06 > var_03) {
        var_01 = var_05;
        var_03 = var_06;
      }
    }
  }

  if(!isDefined(var_01))
    return scripts\mp\spawnlogic::getspawnpoint_random(var_00);

  return var_01;
}

logbadspawn(var_00, var_01) {
  if(isDefined(var_01) && isDefined(var_1.disablespawnwarnings) && var_1.disablespawnwarnings) {
    return;
  }
  if(!isDefined(var_00))
    var_00 = "";
  else
    var_00 = var_00;

  if(isDefined(level.matchrecording_logeventmsg))
    [[level.matchrecording_logeventmsg]]("LOG_BAD_SPAWN", gettime(), var_00);
}

getspawnpoint(var_00, var_01, var_02, var_03) {
  level.spawnglobals.spawnpointslist = var_00;

  if(level.func_72A2) {
    var_04 = func_6CB1();

    if(isDefined(var_04))
      return var_04;
  }

  var_05 = undefined;
  level.spawnglobals.spawn_type = 0;
  var_06 = getmuzzlepos(var_00, var_02, 0);

  if(isDefined(var_06)) {
    if(!scripts\mp\utility\game::istrue(var_6.func_9D60))
      return var_06;
    else
      var_05 = var_06;
  }

  if(isDefined(var_01)) {
    var_07 = getmuzzlepos(var_01, var_02, 3);

    if(isDefined(var_07)) {
      if(scripts\mp\utility\game::istrue(var_7.func_9D60)) {
        if(!isDefined(var_05) || var_7.totalscore > var_5.totalscore)
          var_05 = var_07;
      } else {
        logbadspawn("Using a fallback spawn.", self);
        return var_07;
      }
    }
  }

  if(scripts\mp\utility\game::istrue(var_03))
    return undefined;

  logbadspawn("Using a LastResort spawn point.", self);
  var_08 = func_6CB1();

  if(isDefined(var_08)) {
    var_8.spawntype = 7;
    level.spawnglobals.budy_death_watcher = 0;

    if(isDefined(var_8.buddyspawnid))
      level.spawnglobals.buddyspawnid = var_8.buddyspawnid;

    return var_08;
  }

  logbadspawn("UNABLE TO BUDDY SPAWN. EXTREMELY BAD", self);

  if(level.teambased && !scripts\mp\utility\game::isanymlgmatch()) {
    var_09 = level.spawnglobals.lastbadspawntime[self.team];

    if(isDefined(var_09) && gettime() - var_09 < 5000)
      var_05 = var_0[randomint(var_0.size)];
    else
      level.spawnglobals.lastbadspawntime[self.team] = gettime();
  }

  return var_05;
}

getmuzzlepos(var_00, var_01, var_02) {
  var_00 = checkdynamicspawns(var_00);
  var_3["primary"] = [];
  var_3["secondary"] = [];
  var_3["bad"] = [];

  if(scripts\mp\spawnlogic::shoulduseprecomputedlos() && !scripts\mp\spawnlogic::isttlosdataavailable()) {
    if(isDefined(level.matchrecording_logeventmsg))
      [[level.matchrecording_logeventmsg]]("LOG_GENERIC_MESSAGE", gettime(), "ERROR: TTLOS System disabled! Could not access visDistData");

    if(!isDefined(level.func_8C28))
      level.func_8C28 = 1;

    level.func_560C = 1;
    scripts\mp\spawnlogic::func_E2B6();
  }

  func_12F1E(var_00);

  foreach(var_05 in var_00) {
    var_06 = func_11748(var_05);
    var_3[var_06][var_3[var_06].size] = var_05;
    var_5.lastbucket[scripts\engine\utility::ter_op(isDefined(self.func_108DF), self.func_108DF, self.team)] = var_06;

    if(isDefined(var_5.analytics) && isDefined(var_5.analytics.spawntype)) {
      if(var_06 == "primary") {
        var_5.analytics.spawntype = var_02 + 1;
        continue;
      }

      if(var_06 == "secondary") {
        var_5.analytics.spawntype = var_02 + 2;
        continue;
      }

      var_5.analytics.spawntype = var_02 + 3;
    }
  }

  if(var_3["primary"].size) {
    var_06 = func_7F01(var_3["primary"], var_01);
    var_6.spawn_type = 1;
    return var_06;
  }

  if(var_3["secondary"].size) {
    var_06 = func_7F01(var_3["secondary"], var_01);
    var_6.spawn_type = 2;
    return var_06;
  }

  if(var_3["bad"].size) {
    logbadspawn("Using Bad Spawn", self);
    var_06 = func_7F01(var_3["bad"], var_01);

    if(isDefined(var_06))
      var_6.func_9D60 = 1;

    return var_06;
  }

  return undefined;
}

func_7F01(var_00, var_01) {
  var_02 = var_0[0];

  foreach(var_04 in var_00) {
    scripts\mp\spawnlogic::func_EC46(var_04, var_01);

    if(var_4.totalscore > var_2.totalscore)
      var_02 = var_04;
  }

  var_02 = selectbestspawnpoint(var_02, var_00);
  return var_02;
}