/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\spawnscoring.gsc
***********************************************/

function checkdynamicspawns(var_0) {
  if(isDefined(level.dynamicspawns)) {
    var_0 = [[level.dynamicspawns]](var_0);
  }

  return var_0;
}

function selectbestspawnpoint(var_0, var_1) {
  var_2 = var_0;
  return var_2;
}

function findbuddyspawn() {
  if(!level.teambased || istrue(level.disablebuddyspawn)) {
    return undefined;
  }

  if(!scripts\mp\spawnlogic::arespawnviewersvalid()) {
    scripts\mp\spawnlogic::updatespawnviewers();
  }

  var_0 = getteammatesoutofcombat(scripts\mp\spawnlogic::getactivespawnquerycontext().team);
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = findspawnlocationnearplayer(var_3);

    if(!isDefined(var_4)) {
      continue;
    }

    var_5 = spawnStruct();
    var_5.origin = var_4;
    var_5.angles = getbuddyspawnangles(var_3, var_5.origin);
    var_5.index = -1;
    var_5.buddyspawn = 1;
    var_5.isdynamicspawn = 1;
    var_5.owner = var_3;
    var_5 scripts\mp\spawnlogic::spawnpointinit();

    if(isDefined(var_3.analyticslog) && isDefined(var_3.analyticslog.playerid)) {
      var_5.buddyplayerid = var_3.analyticslog.playerid;
    }

    var_1 = var_5;
  }

  var_7 = [];
  updatespawnpoints(var_1, 1);

  foreach(var_5 in var_1) {
    if(!testbuddyspawncriticalfactors(var_5)) {
      continue;
    }

    scorebuddyspawn(var_5);
    var_7 = var_5;
  }

  var_10 = undefined;

  foreach(var_5 in var_7) {
    if(!isDefined(var_10) || var_5.totalscore > var_10.totalscore) {
      var_10 = var_5;
    }
  }

  return var_10;
}

function findteammatebuddyspawn(var_0) {
  if(!level.teambased || istrue(level.disablebuddyspawn)) {
    return undefined;
  }

  if(!scripts\mp\spawnlogic::arespawnviewersvalid()) {
    scripts\mp\spawnlogic::updatespawnviewers();
  }

  var_1 = spawnStruct();
  var_1.ref_1368A = undefined;
  var_1.ref_13606 = (0, var_0.angles[1], 0);
  var_1 = get_cumulative_damage_expire_time(var_1, var_0);

  if(!isDefined(var_1.ref_1368A)) {
    var_1.ref_1368A = var_0.origin;
    var_1.ref_13606 = var_0.angles;
  }

  if(isDefined(var_0.vehicle)) {
    var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getavailablevehicleseats(var_0.vehicle, 1);

    if(var_2.size > 0 && istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(var_0.vehicle))) {
      var_3 = spawnStruct();
      var_3.useonspawn = 1;
      var_3.enterstartwaitmsg = "spawned_player";
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_0.vehicle, var_2[0], self, var_3);
      var_1.ref_1368A = var_0.vehicle.origin;
      var_1.ref_13606 = var_0.vehicle.angles;
      self.spawningintovehicle = 1;
      scripts\mp\utility\stats::incpersstat("spawnSelectVehicle", 1);
    } else if(!isDefined(var_1.ref_1368A)) {
      var_1.ref_1368A = var_0.vehicle.origin + anglesToForward(var_0.vehicle.angles) * -200 + (0, 0, 64);
      var_1.ref_13606 = (0, var_0.vehicle.angles[1], 0);
    }
  }

  var_4 = spawnStruct();
  var_4.origin = var_1.ref_1368A;
  var_4.angles = var_1.ref_13606;
  var_4.index = -1;
  var_4.buddyspawn = 1;
  var_4.isdynamicspawn = 1;
  var_4.owner = var_0;
  var_4 scripts\mp\spawnlogic::spawnpointinit();

  if(isDefined(var_0.analyticslog) && isDefined(var_0.analyticslog.playerid)) {
    var_4.buddyplayerid = var_0.analyticslog.playerid;
  }

  return var_4;
}

function get_cumulative_damage_expire_time(var_0, var_1) {
  var_2 = 16;
  var_3 = 64;
  var_4 = 64;
  var_5 = 30;
  var_6 = 30;
  var_7 = 180 / var_6;
  var_8 = 1;
  var_9 = 1;
  var_10 = var_2 / (80 - var_2);
  var_11 = var_1.angles;
  var_12 = 1;
  var_13 = undefined;
  var_14 = var_1.origin;

  if(var_1 haslastgroundorigin()) {
    var_14 = var_1 getlastgroundorigin();
  }

  var_15 = var_14 + (0, 0, var_5);
  var_16 = physics_createcontents(["physicscontents_solid", "physicscontents_item", "physicscontents_water", "physicscontents_sky", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_playerclip"]);
  var_17 = [var_1];

  while(var_8 < var_7) {
    if(var_12) {
      var_12 = 0;
      var_13 = anglesToForward(var_11);
    } else {
      var_13 = anglesToForward(var_11 + (0, scripts\engine\utility::ter_op(var_9, var_6, var_6 * -1) * var_8, 0));
      var_9 = !var_9;

      if(var_9 == 1) {
        var_8++;
      }
    }

    var_18 = var_14 - var_13 * var_3 + (0, 0, var_5);
    var_19 = var_15 - var_13 * var_2 * 0.5;
    var_20 = scripts\engine\trace::player_trace(var_19, var_18, (0, 0, 0), var_17, var_16);
    var_21 = var_20["shape_position"];
    var_22 = 0;

    if(var_20["fraction"] < 1 && var_20["fraction"] > var_2 / var_3) {
      var_21 += var_13 * var_2 - (0, 0, var_3 / 2);
      var_22 = 1;
    }

    if(var_20["fraction"] > var_2 / var_3) {
      var_23 = 0;
      var_19 = var_21;
      var_24 = var_19 + (0, 0, -80);
      var_25 = scripts\engine\trace::player_trace(var_19, var_24, (0, 0, 0), var_17, var_16);

      if(var_25["fraction"] < 1) {
        var_26 = vectortoangles(var_13);
        var_19 = var_25["shape_position"] + (0, 0, 10);
        var_27 = var_19 + anglesToForward(var_26) * -32;
        var_28 = var_27 + (0, 0, -80);
        var_29 = scripts\engine\trace::ray_trace(var_27, var_28, var_17, var_16);

        if(var_29["fraction"] == 1) {
          continue;
        }

        var_30 = var_19 + anglestoright(var_26) * -32;
        var_31 = var_30 + (0, 0, -80);
        var_32 = scripts\engine\trace::ray_trace(var_30, var_31, var_17, var_16);

        if(var_32["fraction"] == 1) {
          continue;
        }

        var_33 = var_19 + anglestoright(var_26) * 32;
        var_34 = var_33 + (0, 0, -80);
        var_35 = scripts\engine\trace::ray_trace(var_33, var_28, var_17, var_16);

        if(var_35["fraction"] == 1) {
          continue;
        }

        var_0.ref_1368A = var_25["shape_position"];
        var_0.ref_13606 = var_26;
        break;
      }
    }
  }

  return var_0;
}

function scorebuddyspawn(var_0) {
  scripts\mp\spawnfactor::calculatefactorscore(var_0, "avoidShortTimeToEnemySight", 1);
  scripts\mp\spawnfactor::calculatefactorscore(var_0, "avoidClosestEnemy", 1);
}

function getbuddyspawnangles(var_0, var_1) {
  var_2 = (0, var_0.angles[1], 0);
  return var_2;
}

function getteammatesoutofcombat(var_0) {
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

    if(!var_3 scripts\mp\utility\player::isplayerallowedforspawnlogic()) {
      continue;
    }

    var_1 = var_3;
  }

  return scripts\engine\utility::array_randomize(var_1);
}

function canplayerbebuddyspawnedon(var_0) {
  if(var_0.sessionstate != "playing") {
    return false;
  }

  if(!scripts\mp\utility\player::isreallyalive(var_0)) {
    return false;
  }

  if(!var_0 isonground()) {
    return false;
  }

  if(var_0 isonladder()) {
    return false;
  }

  if(var_0 scripts\engine\utility::isflashed()) {
    return false;
  }

  if(var_0.health < var_0.maxhealth && (!isDefined(var_0.lastdamagedtime) || gettime() < var_0.lastdamagedtime + 3000)) {
    return false;
  }

  return true;
}

function findspawnlocationnearplayer(var_0) {
  var_1 = scripts\mp\spawnlogic::getplayertraceheight(var_0, 1);
  var_2 = findbuddypathnode(var_0, var_1, 0.5);

  if(isDefined(var_2)) {
    return var_2.origin;
  }

  return undefined;
}

function findbuddypathnode(var_0, var_1, var_2) {
  var_3 = getnodesinradiussorted(var_0.origin, 192, 64, var_1, "Path", 1);
  var_4 = undefined;

  if(isDefined(var_3) && var_3.size > 0) {
    var_5 = anglesToForward(var_0.angles);

    foreach(var_7 in var_3) {
      if(isDefined(level.chopper_gunner_assignedtargetmarkers_onnewai) && scripts\engine\utility::array_contains(level.chopper_gunner_assignedtargetmarkers_onnewai, var_7)) {
        continue;
      }

      var_8 = vectorNormalize(var_7.origin - var_0.origin);
      var_9 = vectordot(var_5, var_8);

      if(var_9 <= var_2 && !positionwouldtelefrag(var_7.origin)) {
        var_4 = var_7;

        if(var_9 <= 0) {
          break;
        }
      }
    }
  }

  return var_4;
}

function initscoredata(var_0) {
  var_0.totalscore = 0;
  var_0.totalpossiblescore = 0;
  var_0.isbadspawn = 0;
  var_0.lastscore = [];
  var_0.lastscore["allies"] = 0;
  var_0.lastscore["axis"] = 0;
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

function updatespawnpoints(var_0, var_1) {
  var_2 = scripts\mp\spawnlogic::getspawnteam(self);
  var_1 = istrue(var_1);
  var_3 = "all";

  if(level.teambased) {
    var_3 = scripts\mp\utility\teams::getenemyteams(var_2)[0];
  }

  foreach(var_5 in var_0) {
    initscoredata(var_5);
    scripts\mp\spawnlogic::initspawnpointvalues(var_5);
    scripts\mp\spawnlogic::spawnpointdistanceupdate(var_5);
    scripts\mp\spawnlogic::evaluateprecomputedlos(var_5, var_2);

    if(!var_1) {
      scripts\mp\spawnlogic::evaluateprecomputedlos(var_5, var_3);
    }
  }

  if(!var_1) {
    scripts\mp\spawnfactor::updatefrontline(var_2);
    return;
  }
}

function criticalfactors_callback(var_0) {
  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidbradleys, var_0)) {
    var_0.badspawnreason = 8;
    return "bad";
  }

  return "primary";
}

function testcriticalfactors(var_0) {
  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidfullvisibleenemies, var_0)) {
    var_0.badspawnreason = 0;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidgrenades, var_0)) {
    var_0.badspawnreason = 1;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidmines, var_0)) {
    var_0.badspawnreason = 2;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidcarepackages, var_0)) {
    var_0.badspawnreason = 4;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidbradleys, var_0)) {
    var_0.badspawnreason = 8;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidtelefrag, var_0)) {
    var_0.badspawnreason = 5;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidenemyspawn, var_0)) {
    var_0.badspawnreason = 6;
    return "bad";
  }

  if(isDefined(var_0.frontlineteam) && level.frontlineinfo.isactive[self.team] && var_0.frontlineteam != self.team) {
    var_0.badspawnreason = 7;
    return "bad";
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidcornervisibleenemies, var_0)) {
    return "secondary";
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidcloseenemies, var_0)) {
    return "secondary";
  }

  return "primary";
}

function testbuddyspawncriticalfactors(var_0) {
  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidfullvisibleenemies, var_0)) {
    return false;
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidgrenades, var_0)) {
    return false;
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidmines, var_0)) {
    return false;
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidcarepackages, var_0)) {
    return false;
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidbradleys, var_0)) {
    return false;
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidtelefrag, var_0)) {
    return false;
  }

  if(!scripts\mp\spawnfactor::critical_factor(&scripts\mp\spawnfactor::avoidcloseenemies, var_0)) {
    return false;
  }

  return true;
}

function getstartspawnpoint_freeforall(var_0) {
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

function logbadspawn(var_0, var_1) {
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
    return;
  }
}

function getspawnpoint_legacy(var_0, var_1, var_2, var_3, var_4) {
  level.spawnglobals.spawnpointslist = var_0;
  var_5 = scripts\mp\spawnlogic::createspawnquerycontext(self, self.pers["team"]);
  scripts\mp\spawnlogic::setactivespawnquerycontext(var_5);
  resetperupdatespawnglobals();
  getspawnpointpreprocess();

  if(level.forcebuddyspawn) {
    var_6 = findbuddyspawn();

    if(isDefined(var_6)) {
      return var_6;
    }
  }

  var_7 = undefined;
  level.spawnglobals.spawn_type = 0;
  var_8 = getspawnpointfromlist(var_0, 0);

  if(isDefined(var_8)) {
    if(!istrue(var_8.isbadspawn)) {
      return var_8;
    } else {
      var_7 = var_8;
    }
  }

  if(isDefined(var_1)) {
    var_9 = getspawnpointfromlist(var_1, 3);

    if(isDefined(var_9)) {
      if(istrue(var_9.isbadspawn)) {
        if(!isDefined(var_7) || var_9.totalscore > var_7.totalscore) {
          var_7 = var_9;
        }
      } else {
        logbadspawn("Using a fallback spawn.", self);
        return var_9;
      }
    }
  }

  if(istrue(var_3)) {
    return undefined;
  }

  logbadspawn("Using a LastResort spawn point.", self);

  if(!istrue(var_4)) {
    var_10 = findbuddyspawn();

    if(isDefined(var_10)) {
      var_10.spawntype = 7;
      level.spawnglobals.buddyspawnid = 0;

      if(isDefined(var_10.buddyplayerid)) {
        level.spawnglobals.buddyplayerid = var_10.buddyplayerid;
      }

      return var_10;
    }

    logbadspawn("UNABLE TO BUDDY SPAWN. EXTREMELY BAD", self);
  }

  if(level.teambased && !scripts\mp\utility\game::isanymlgmatch()) {
    var_11 = level.spawnglobals.lastbadspawntime[self.team];

    if(isDefined(var_11) && gettime() - var_11 < 5000) {
      var_7 = var_0[randomint(var_0.size)];
    } else {
      level.spawnglobals.lastbadspawntime[self.team] = gettime();
    }
  }

  return var_7;
}

function getspawnpointfromlist(var_0, var_1) {
  var_0 = checkdynamicspawns(var_0);
  GscBinSkip1(0x45, "primary", []);
}

function resetperupdatespawnglobals() {
  var_0 = level.spawnglobals;
  var_0.hasclusterdata = 0;
  var_0.haslanedata = 0;
}

function getspawnpointpreprocess() {
  var_0 = scripts\mp\spawnlogic::getspawnteam(self);
  scripts\mp\spawnlogic::updatespawnviewers();
  var_1 = level.spawnglobals;

  if(scripts\mp\spawnlogic::isfactorinuse("preferNearGroupsOfTeamMates")) {
    var_1.teamclusters = [];
    var_1.teamclusters[var_0] = scripts\mp\spawnlogic::calculateteamclusters(var_0);
  }

  if(scripts\mp\spawnlogic::isfactorinuse("preferOccupiedLanes") || scripts\mp\spawnlogic::isfactorinuse("preferToBalanceLanes")) {
    var_1.occupiedlanemasks = [];

    foreach(var_3 in level.spawnglobals.lanetriggers) {
      foreach(var_5 in level.players) {
        var_6 = scripts\mp\spawnlogic::getspawnteam(var_5);

        if(!scripts\mp\utility\player::isreallyalive(var_5)) {
          continue;
        }

        if(!var_5 scripts\mp\utility\player::isplayerallowedforspawnlogic()) {
          continue;
        }

        if(ispointinvolume(var_5.origin, var_3)) {
          if(!isDefined(var_1.occupiedlanemasks[var_6])) {
            var_1.occupiedlanemasks[var_6] = 0;
          }

          var_1.occupiedlanemasks[var_6] |= var_3.indexflag;
        }
      }
    }

    return;
  }
}

function gethighestscoringspawn(var_0) {
  var_1 = var_0[0];

  foreach(var_3 in var_0) {
    scripts\mp\spawnlogic::scorespawnpoint(var_3);

    if(var_3.totalscore > var_1.totalscore) {
      var_1 = var_3;
    }
  }

  var_1 = selectbestspawnpoint(var_1, var_0);
  return var_1;
}

function ref_13747() {
  self endon("death_or_disconnect");
  var_0 = spawnStruct();

  for(;;) {
    var_0.ref_1368A = undefined;
    var_0.ref_13606 = undefined;
    var_0 = get_cumulative_damage_expire_time(var_0, self);
    var_1 = 0;

    if(!isDefined(var_0.ref_1368A)) {
      var_0.ref_1368A = self.origin;
      var_0.ref_13606 = self.angles;
      var_1 = 1;
    }

    thread scripts\cp_mp\utility\debug_utility::drawsphere(var_0.ref_1368A, 16, 0.1, scripts\engine\utility::ter_op(var_1, (1, 0, 0), (0, 1, 0)));
    thread scripts\cp_mp\utility\debug_utility::drawangles(var_0.ref_1368A, var_0.ref_13606, 0.1, 1);
    wait 0.1;
  }
}