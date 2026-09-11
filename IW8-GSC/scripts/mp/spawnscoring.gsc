/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\spawnscoring.gsc
***********************************************/

function checkdynamicspawns(var0) {
  if(isDefined(level.dynamicspawns)) {
    var0 = [[level.dynamicspawns]](var0);
  }

  return var0;
}

function selectbestspawnpoint(var0, var1) {
  var2 = var0;
  return var2;
}

function findbuddyspawn() {
  if(!level.teambased || istrue(level.disablebuddyspawn)) {
    return undefined;
  }

  if(!scripts\mp\spawnlogic::arespawnviewersvalid()) {
    scripts\mp\spawnlogic::updatespawnviewers();
  }

  var0 = getteammatesoutofcombat(scripts\mp\spawnlogic::getactivespawnquerycontext().team);
  var1 = [];

  foreach(var3 in var0) {
    var4 = findspawnlocationnearplayer(var3);

    if(!isDefined(var4)) {
      continue;
    }

    var5 = spawnStruct();
    var5.origin = var4;
    var5.angles = getbuddyspawnangles(var3, var5.origin);
    var5.index = -1;
    var5.buddyspawn = 1;
    var5.isdynamicspawn = 1;
    var5.owner = var3;
    var5 scripts\mp\spawnlogic::spawnpointinit();

    if(isDefined(var3.analyticslog) && isDefined(var3.analyticslog.playerid)) {
      var5.buddyplayerid = var3.analyticslog.playerid;
    }

    var1 = var5;
  }

  var7 = [];
  updatespawnpoints(var1, 1);

  foreach(var5 in var1) {
    if(!testbuddyspawncriticalfactors(var5)) {
      continue;
    }

    scorebuddyspawn(var5);
    var7 = var5;
  }

  var10 = undefined;

  foreach(var5 in var7) {
    if(!isDefined(var10) || var5.totalscore > var10.totalscore) {
      var10 = var5;
    }
  }

  return var10;
}

function findteammatebuddyspawn(var0) {
  if(!level.teambased || istrue(level.disablebuddyspawn)) {
    return undefined;
  }

  if(!scripts\mp\spawnlogic::arespawnviewersvalid()) {
    scripts\mp\spawnlogic::updatespawnviewers();
  }

  var1 = spawnStruct();
  var1.ref_1368a = undefined;
  var1.ref_13606 = (0, var0.angles[1], 0);
  var1 = get_cumulative_damage_expire_time(var1, var0);

  if(!isDefined(var1.ref_1368a)) {
    var1.ref_1368a = var0.origin;
    var1.ref_13606 = var0.angles;
  }

  if(isDefined(var0.vehicle)) {
    var2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getavailablevehicleseats(var0.vehicle, 1);

    if(var2.size > 0 && istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(var0.vehicle))) {
      var3 = spawnStruct();
      var3.useonspawn = 1;
      var3.enterstartwaitmsg = "spawned_player";
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var0.vehicle, var2[0], self, var3);
      var1.ref_1368a = var0.vehicle.origin;
      var1.ref_13606 = var0.vehicle.angles;
      self.spawningintovehicle = 1;
      scripts\mp\utility\stats::incpersstat("spawnSelectVehicle", 1);
    } else if(!isDefined(var1.ref_1368a)) {
      var1.ref_1368a = var0.vehicle.origin + anglesToForward(var0.vehicle.angles) * -200 + (0, 0, 64);
      var1.ref_13606 = (0, var0.vehicle.angles[1], 0);
    }
  }

  var4 = spawnStruct();
  var4.origin = var1.ref_1368a;
  var4.angles = var1.ref_13606;
  var4.index = -1;
  var4.buddyspawn = 1;
  var4.isdynamicspawn = 1;
  var4.owner = var0;
  var4 scripts\mp\spawnlogic::spawnpointinit();

  if(isDefined(var0.analyticslog) && isDefined(var0.analyticslog.playerid)) {
    var4.buddyplayerid = var0.analyticslog.playerid;
  }

  return var4;
}

function get_cumulative_damage_expire_time(var0, var1) {
  var2 = 16;
  var3 = 64;
  var4 = 64;
  var5 = 30;
  var6 = 30;
  var7 = 180 / var6;
  var8 = 1;
  var9 = 1;
  var10 = var2 / (80 - var2);
  var11 = var1.angles;
  var12 = 1;
  var13 = undefined;
  var14 = var1.origin;

  if(var1 haslastgroundorigin()) {
    var14 = var1 getlastgroundorigin();
  }

  var15 = var14 + (0, 0, var5);
  var16 = physics_createcontents(["physicscontents_solid", "physicscontents_item", "physicscontents_water", "physicscontents_sky", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_playerclip"]);
  var17 = [var1];

  while(var8 < var7) {
    if(var12) {
      var12 = 0;
      var13 = anglesToForward(var11);
    } else {
      var13 = anglesToForward(var11 + (0, scripts\engine\utility::ter_op(var9, var6, var6 * -1) * var8, 0));
      var9 = !var9;

      if(var9 == 1) {
        var8++;
      }
    }

    var18 = var14 - var13 * var3 + (0, 0, var5);
    var19 = var15 - var13 * var2 * 0.5;
    var20 = scripts\engine\trace::player_trace(var19, var18, (0, 0, 0), var17, var16);
    var21 = var20["shape_position"];
    var22 = 0;

    if(var20["fraction"] < 1 && var20["fraction"] > var2 / var3) {
      var21 += var13 * var2 - (0, 0, var3 / 2);
      var22 = 1;
    }

    if(var20["fraction"] > var2 / var3) {
      var23 = 0;
      var19 = var21;
      var24 = var19 + (0, 0, -80);
      var25 = scripts\engine\trace::player_trace(var19, var24, (0, 0, 0), var17, var16);

      if(var25["fraction"] < 1) {
        var26 = vectortoangles(var13);
        var19 = var25["shape_position"] + (0, 0, 10);
        var27 = var19 + anglesToForward(var26) * -32;
        var28 = var27 + (0, 0, -80);
        var29 = scripts\engine\trace::ray_trace(var27, var28, var17, var16);

        if(var29["fraction"] == 1) {
          continue;
        }

        var30 = var19 + anglestoright(var26) * -32;
        var31 = var30 + (0, 0, -80);
        var32 = scripts\engine\trace::ray_trace(var30, var31, var17, var16);

        if(var32["fraction"] == 1) {
          continue;
        }

        var33 = var19 + anglestoright(var26) * 32;
        var34 = var33 + (0, 0, -80);
        var35 = scripts\engine\trace::ray_trace(var33, var28, var17, var16);

        if(var35["fraction"] == 1) {
          continue;
        }

        var0.ref_1368a = var25["shape_position"];
        var0.ref_13606 = var26;
        break;
      }
    }
  }

  return var0;
}

function scorebuddyspawn(var0) {
  scripts\mp\spawnfactor::calculatefactorscore(var0, "avoidShortTimeToEnemySight", 1);
  scripts\mp\spawnfactor::calculatefactorscore(var0, "avoidClosestEnemy", 1);
}

function getbuddyspawnangles(var0, var1) {
  var2 = (0, var0.angles[1], 0);
  return var2;
}

function getteammatesoutofcombat(var0) {
  var1 = [];

  foreach(var3 in level.players) {
    if(var3.team != var0) {
      continue;
    }

    if(var3 == self) {
      continue;
    }

    if(!canplayerbebuddyspawnedon(var3)) {
      continue;
    }

    if(!var3 scripts\mp\utility\player::isplayerallowedforspawnlogic()) {
      continue;
    }

    var1 = var3;
  }

  return scripts\engine\utility::array_randomize(var1);
}

function canplayerbebuddyspawnedon(var0) {
  if(var0.sessionstate != "playing") {
    return false;
  }

  if(!scripts\mp\utility\player::isreallyalive(var0)) {
    return false;
  }

  if(!var0 isonground()) {
    return false;
  }

  if(var0 isonladder()) {
    return false;
  }

  if(var0 scripts\engine\utility::isflashed()) {
    return false;
  }

  if(var0.health < var0.maxhealth && (!isDefined(var0.lastdamagedtime) || gettime() < var0.lastdamagedtime + 3000)) {
    return false;
  }

  return true;
}

function findspawnlocationnearplayer(var0) {
  var1 = scripts\mp\spawnlogic::getplayertraceheight(var0, 1);
  var2 = findbuddypathnode(var0, var1, 0.5);

  if(isDefined(var2)) {
    return var2.origin;
  }

  return undefined;
}

function findbuddypathnode(var0, var1, var2) {
  var3 = getnodesinradiussorted(var0.origin, 192, 64, var1, "Path", 1);
  var4 = undefined;

  if(isDefined(var3) && var3.size > 0) {
    var5 = anglesToForward(var0.angles);

    foreach(var7 in var3) {
      if(isDefined(level.chopper_gunner_assignedtargetmarkers_onnewai) && scripts\engine\utility::array_contains(level.chopper_gunner_assignedtargetmarkers_onnewai, var7)) {
        continue;
      }

      var8 = vectorNormalize(var7.origin - var0.origin);
      var9 = vectordot(var5, var8);

      if(var9 <= var2 && !positionwouldtelefrag(var7.origin)) {
        var4 = var7;

        if(var9 <= 0) {
          break;
        }
      }
    }
  }

  return var4;
}

function initscoredata(var0) {
  var0.totalscore = 0;
  var0.totalpossiblescore = 0;
  var0.isbadspawn = 0;
  var0.lastscore = [];
  var0.lastscore["allies"] = 0;
  var0.lastscore["axis"] = 0;
  var0.analytics = spawnStruct();
  var0.analytics.allyaveragedist = 0;
  var0.analytics.enemyaveragedist = 0;
  var0.analytics.timesincelastspawn = 0;
  var0.analytics.maxenemysightfraction = 0;
  var0.analytics.randomscore = 0;
  var0.analytics.maxjumpingenemysightfraction = 0;
  var0.analytics.spawnusedbyenemies = 0;
  var0.analytics.spawntype = 0;
}

function updatespawnpoints(var0, var1) {
  var2 = scripts\mp\spawnlogic::getspawnteam(self);
  var1 = istrue(var1);
  var3 = "all";

  if(level.teambased) {
    var3 = scripts\mp\utility\teams::getenemyteams(var2)[0];
  }

  foreach(var5 in var0) {
    initscoredata(var5);
    scripts\mp\spawnlogic::initspawnpointvalues(var5);
    scripts\mp\spawnlogic::spawnpointdistanceupdate(var5);
    scripts\mp\spawnlogic::evaluateprecomputedlos(var5, var2);

    if(!var1) {
      scripts\mp\spawnlogic::evaluateprecomputedlos(var5, var3);
    }
  }

  if(!var1) {
    scripts\mp\spawnfactor::updatefrontline(var2);
    return;
  }
}

function criticalfactors_callback(var0) {
  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidbradleys, var0)) {
    var0.badspawnreason = 8;
    return "bad";
  }

  return "primary";
}

function testcriticalfactors(var0) {
  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidfullvisibleenemies, var0)) {
    var0.badspawnreason = 0;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidgrenades, var0)) {
    var0.badspawnreason = 1;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidmines, var0)) {
    var0.badspawnreason = 2;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidcarepackages, var0)) {
    var0.badspawnreason = 4;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidbradleys, var0)) {
    var0.badspawnreason = 8;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidtelefrag, var0)) {
    var0.badspawnreason = 5;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidenemyspawn, var0)) {
    var0.badspawnreason = 6;
    return "bad";
  }

  if(isDefined(var0.frontlineteam) && level.frontlineinfo.isactive[self.team] && var0.frontlineteam != self.team) {
    var0.badspawnreason = 7;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidcornervisibleenemies, var0)) {
    return "secondary";
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidcloseenemies, var0)) {
    return "secondary";
  }

  return "primary";
}

function testbuddyspawncriticalfactors(var0) {
  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidfullvisibleenemies, var0)) {
    return false;
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidgrenades, var0)) {
    return false;
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidmines, var0)) {
    return false;
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidcarepackages, var0)) {
    return false;
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidbradleys, var0)) {
    return false;
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidtelefrag, var0)) {
    return false;
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidcloseenemies, var0)) {
    return false;
  }

  return true;
}

function getstartspawnpoint_freeforall(var0) {
  if(!isDefined(var0)) {
    return undefined;
  }

  var1 = undefined;
  var2 = scripts\mp\spawnlogic::getactiveplayerlist();
  var0 = checkdynamicspawns(var0);

  if(!isDefined(var2) || var2.size == 0) {
    return scripts\mp\spawnlogic::getspawnpoint_random(var0);
  }

  var3 = 0;

  foreach(var5 in var0) {
    if(canspawn(var5.origin) && !positionwouldtelefrag(var5.origin)) {
      var6 = undefined;

      foreach(var8 in var2) {
        var9 = distancesquared(var5.origin, var8.origin);

        if(!isDefined(var6) || var9 < var6) {
          var6 = var9;
        }
      }

      if(!isDefined(var1) || var6 > var3) {
        var1 = var5;
        var3 = var6;
      }
    }
  }

  if(!isDefined(var1)) {
    return scripts\mp\spawnlogic::getspawnpoint_random(var0);
  }

  return var1;
}

function logbadspawn(var0, var1) {
  if(isDefined(var1) && isDefined(var1.disablespawnwarnings) && var1.disablespawnwarnings) {
    return;
  }

  if(!isDefined(var0)) {
    var0 = "";
  } else {
    var0 = var0;
  }

  if(isDefined(level.matchrecording_logeventmsg)) {
    [[level.matchrecording_logeventmsg]]("LOG_BAD_SPAWN", gettime(), var0);
    return;
  }
}

function getspawnpoint_legacy(var0, var1, var2, var3, var4) {
  level.spawnglobals.spawnpointslist = var0;
  var5 = scripts\mp\spawnlogic::createspawnquerycontext(self, self.pers["team"]);
  scripts\mp\spawnlogic::setactivespawnquerycontext(var5);
  resetperupdatespawnglobals();
  getspawnpointpreprocess();

  if(level.forcebuddyspawn) {
    var6 = findbuddyspawn();

    if(isDefined(var6)) {
      return var6;
    }
  }

  var7 = undefined;
  level.spawnglobals.spawn_type = 0;
  var8 = getspawnpointfromlist(var0, 0);

  if(isDefined(var8)) {
    if(!istrue(var8.isbadspawn)) {
      return var8;
    } else {
      var7 = var8;
    }
  }

  if(isDefined(var1)) {
    var9 = getspawnpointfromlist(var1, 3);

    if(isDefined(var9)) {
      if(istrue(var9.isbadspawn)) {
        if(!isDefined(var7) || var9.totalscore > var7.totalscore) {
          var7 = var9;
        }
      } else {
        logbadspawn("Using a fallback spawn.", self);
        return var9;
      }
    }
  }

  if(istrue(var3)) {
    return undefined;
  }

  logbadspawn("Using a LastResort spawn point.", self);

  if(!istrue(var4)) {
    var10 = findbuddyspawn();

    if(isDefined(var10)) {
      var10.spawntype = 7;
      level.spawnglobals.buddyspawnid = 0;

      if(isDefined(var10.buddyplayerid)) {
        level.spawnglobals.buddyplayerid = var10.buddyplayerid;
      }

      return var10;
    }

    logbadspawn("UNABLE TO BUDDY SPAWN. EXTREMELY BAD", self);
  }

  if(level.teambased && !scripts\mp\utility\game::isanymlgmatch()) {
    var11 = level.spawnglobals.lastbadspawntime[self.team];

    if(isDefined(var11) && gettime() - var11 < 5000) {
      var7 = var0[randomint(var0.size)];
    } else {
      level.spawnglobals.lastbadspawntime[self.team] = gettime();
    }
  }

  return var7;
}

function getspawnpointfromlist(var0, var1) {
  var0 = checkdynamicspawns(var0);
  GscBinSkip1(0x45, "primary", []);
}

function resetperupdatespawnglobals() {
  var0 = level.spawnglobals;
  var0.hasclusterdata = 0;
  var0.haslanedata = 0;
}

function getspawnpointpreprocess() {
  var0 = scripts\mp\spawnlogic::getspawnteam(self);
  scripts\mp\spawnlogic::updatespawnviewers();
  var1 = level.spawnglobals;

  if(scripts\mp\spawnlogic::isfactorinuse("preferNearGroupsOfTeamMates")) {
    var1.teamclusters = [];
    var1.teamclusters[var0] = scripts\mp\spawnlogic::calculateteamclusters(var0);
  }

  if(scripts\mp\spawnlogic::isfactorinuse("preferOccupiedLanes") || scripts\mp\spawnlogic::isfactorinuse("preferToBalanceLanes")) {
    var1.occupiedlanemasks = [];

    foreach(var3 in level.spawnglobals.lanetriggers) {
      foreach(var5 in level.players) {
        var6 = scripts\mp\spawnlogic::getspawnteam(var5);

        if(!scripts\mp\utility\player::isreallyalive(var5)) {
          continue;
        }

        if(!var5 scripts\mp\utility\player::isplayerallowedforspawnlogic()) {
          continue;
        }

        if(ispointinvolume(var5.origin, var3)) {
          if(!isDefined(var1.occupiedlanemasks[var6])) {
            var1.occupiedlanemasks[var6] = 0;
          }

          var1.occupiedlanemasks[var6] |= var3.indexflag;
        }
      }
    }

    return;
  }
}

function gethighestscoringspawn(var0) {
  var1 = var0[0];

  foreach(var3 in var0) {
    scripts\mp\spawnlogic::scorespawnpoint(var3);

    if(var3.totalscore > var1.totalscore) {
      var1 = var3;
    }
  }

  var1 = selectbestspawnpoint(var1, var0);
  return var1;
}

function ref_13747() {
  self endon("death_or_disconnect");
  var0 = spawnStruct();

  for(;;) {
    var0.ref_1368a = undefined;
    var0.ref_13606 = undefined;
    var0 = get_cumulative_damage_expire_time(var0, self);
    var1 = 0;

    if(!isDefined(var0.ref_1368a)) {
      var0.ref_1368a = self.origin;
      var0.ref_13606 = self.angles;
      var1 = 1;
    }

    thread scripts\cp_mp\utility\debug_utility::drawsphere(var0.ref_1368a, 16, 0.1, scripts\engine\utility::ter_op(var1, (1, 0, 0), (0, 1, 0)));
    thread scripts\cp_mp\utility\debug_utility::drawangles(var0.ref_1368a, var0.ref_13606, 0.1, 1);
    wait 0.1;
  }
}