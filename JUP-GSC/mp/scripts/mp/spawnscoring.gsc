/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\spawnscoring.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\dev;
#using scripts\mp\spawnfactor;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#namespace spawnscoring;

function checkdynamicspawns(spawnpoints) {
  if(isDefined(level.dynamicspawns)) {
    spawnpoints = [[level.dynamicspawns]](spawnpoints);
  }

  return spawnpoints;
}

function selectbestspawnpoint(highestscoringspawn, spawnpoints) {
  bestspawn = highestscoringspawn;
  return bestspawn;
}

function findbuddyspawn() {
  if(!level.teambased || istrue(level.disablebuddyspawn)) {
    return undefined;
  }

  scripts\mp\dev::function_75d2477e56b1aea8(self);

  if(!scripts\mp\spawnlogic::arespawnviewersvalid()) {
    scripts\mp\spawnlogic::updatespawnviewers();
  }

  teammates = getteammatesoutofcombat(scripts\mp\spawnlogic::getactivespawnquerycontext().team);
  spawnpoints = [];

  foreach(player in teammates) {
    spawnposition = findspawnlocationnearplayer(player);

    if(!isDefined(spawnposition)) {
      continue;
    }

    spawnpoint = spawnStruct();
    spawnpoint.origin = spawnposition;
    spawnpoint.angles = getbuddyspawnangles(player, spawnpoint.origin);
    spawnpoint.index = -1;
    spawnpoint.buddyspawn = 1;
    spawnpoint.isdynamicspawn = 1;
    spawnpoint.owner = player;
    spawnpoint scripts\mp\spawnlogic::spawnpointinit();

    if(isDefined(player.analyticslog) && isDefined(player.analyticslog.playerid)) {
      spawnpoint.buddyplayerid = player.analyticslog.playerid;
    }

    spawnpoints[spawnpoints.size] = spawnpoint;
  }

  if(getdvarint(@ "hash_9bffca47d2e56b54") != 0) {
    scripts\mp\dev::function_b1972efe5a8d2a37(spawnpoints);
  }

  validspawnpoints = [];
  updatespawnpoints(spawnpoints, 1);

  foreach(spawnpoint in spawnpoints) {
    if(!testbuddyspawncriticalfactors(spawnpoint)) {
      continue;
    }

    scorebuddyspawn(spawnpoint);
    validspawnpoints[validspawnpoints.size] = spawnpoint;
  }

  bestspawnpoint = undefined;

  foreach(spawnpoint in validspawnpoints) {
    if(!isDefined(bestspawnpoint) || spawnpoint.totalscore > bestspawnpoint.totalscore) {
      bestspawnpoint = spawnpoint;
    }
  }

  scripts\mp\spawnlogic::function_50a59d95bac1964e();

  return bestspawnpoint;
}

function findteammatebuddyspawn(teammate) {
  if(!level.teambased || istrue(level.disablebuddyspawn)) {
    return undefined;
  }

  scripts\mp\dev::function_75d2477e56b1aea8(self);

  if(!scripts\mp\spawnlogic::arespawnviewersvalid()) {
    scripts\mp\spawnlogic::updatespawnviewers();
  }

  spawninfo = spawnStruct();
  spawninfo.spawnposition = undefined;
  spawninfo.spawnangle = (0, teammate.angles[1], 0);
  spawninfo = capsulepass(spawninfo, teammate);

  if(!isDefined(spawninfo.spawnposition)) {
    spawninfo.spawnposition = teammate.origin;
    spawninfo.spawnangle = teammate.angles;
  }

  if(isDefined(teammate.vehicle)) {
    seat = scripts\cp_mp\vehicles\vehicle_occupancy::function_d3d95972f58ad2bc(teammate.vehicle);

    if(isDefined(seat) && istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(teammate.vehicle))) {
      data = spawnStruct();
      data.useonspawn = 1;
      data.enterstartwaitmsg = "spawned_player";
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(teammate.vehicle, seat, self, data);
      spawninfo.spawnposition = teammate.vehicle.origin + anglesToForward(teammate.vehicle.angles) * -200 + (0, 0, 64);
      spawninfo.spawnangle = (0, teammate.vehicle.angles[1], 0);
      self.spawningintovehicle = 1;
      scripts\mp\utility\stats::incpersstat("spawnSelectVehicle", 1);
    } else if(!isDefined(spawninfo.spawnposition)) {
      spawninfo.spawnposition = teammate.vehicle.origin + anglesToForward(teammate.vehicle.angles) * -200 + (0, 0, 64);
      spawninfo.spawnangle = (0, teammate.vehicle.angles[1], 0);
    }
  }

  spawnpoint = spawnStruct();
  spawnpoint.origin = spawninfo.spawnposition;
  spawnpoint.angles = spawninfo.spawnangle;
  spawnpoint.index = -1;
  spawnpoint.buddyspawn = 1;
  spawnpoint.isdynamicspawn = 1;
  spawnpoint.owner = teammate;
  spawnpoint scripts\mp\spawnlogic::spawnpointinit();

  if(isDefined(teammate.analyticslog) && isDefined(teammate.analyticslog.playerid)) {
    spawnpoint.buddyplayerid = teammate.analyticslog.playerid;
  }

  return spawnpoint;
}

function capsulepass(spawninfo, teammate) {
  radius = 16;
  castdist = 64;
  var_68df1837cf28c9f3 = 64;
  var_722e02f3664a23c0 = 30;
  angstep = 30;
  maxsteps = 180 / angstep;
  failcount = 1;
  usepos = 1;
  fracradius = radius / (80 - radius);
  baseang = teammate.angles;
  firstrun = 1;
  dir = undefined;
  groundpos = teammate.origin;

  if(teammate haslastgroundorigin() && !teammate isswimming()) {
    groundpos = teammate getlastgroundorigin();
  }

  startpos = groundpos + (0, 0, var_722e02f3664a23c0);
  var_3bc387e9ae1342aa = ["physicscontents_characterproxy", "physicscontents_item", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_playerclip"];

  if(!teammate isswimming()) {
    var_3bc387e9ae1342aa[var_3bc387e9ae1342aa.size] = "physicscontents_water";
  }

  contents = physics_createcontents(var_3bc387e9ae1342aa);
  var_22d9650d353e4416 = [teammate];

  while(failcount < maxsteps) {
    if(firstrun) {
      firstrun = 0;
      dir = anglesToForward(baseang);
    } else {
      dir = anglesToForward(baseang + (0, ter_op(usepos, angstep, angstep * -1) * failcount, 0));
      usepos = !usepos;

      if(usepos == 1) {
        failcount++;
      }
    }

    endpos = groundpos - dir * castdist + (0, 0, var_722e02f3664a23c0);
    caststart = startpos - dir * radius * 0.5;
    trace = scripts\engine\trace::player_trace(caststart, endpos, (0, 0, 0), var_22d9650d353e4416, contents);
    finalpos = trace["shape_position"];
    adjusted = 0;

    if(trace["fraction"] < 1 && trace["fraction"] > radius / castdist) {
      finalpos += dir * radius - (0, 0, castdist / 2);
      adjusted = 1;
    }

    if(trace["fraction"] > radius / castdist) {
      var_d1d588d0d0b637a3 = 0;
      caststart = finalpos;
      castend = caststart + (0, 0, -80);
      castresults = scripts\engine\trace::player_trace(caststart, castend, (0, 0, 0), var_22d9650d353e4416, contents);

      if(castresults["fraction"] < 1) {
        angles = vectortoangles(dir);
        caststart = castresults["shape_position"] + (0, 0, 10);
        rearstart = caststart + anglesToForward(angles) * -32;
        rearend = rearstart + (0, 0, -80);
        reartrace = scripts\engine\trace::ray_trace(rearstart, rearend, var_22d9650d353e4416, contents);

        if(reartrace["fraction"] == 1) {
          continue;
        }

        leftstart = caststart + anglestoright(angles) * -32;
        leftend = leftstart + (0, 0, -80);
        lefttrace = scripts\engine\trace::ray_trace(leftstart, leftend, var_22d9650d353e4416, contents);

        if(lefttrace["fraction"] == 1) {
          continue;
        }

        rightstart = caststart + anglestoright(angles) * 32;
        rightend = rightstart + (0, 0, -80);
        righttrace = scripts\engine\trace::ray_trace(rightstart, rearend, var_22d9650d353e4416, contents);

        if(righttrace["fraction"] == 1) {
          continue;
        }

        spawninfo.spawnposition = castresults["shape_position"];
        spawninfo.spawnangle = angles;
        break;
      }

      if(teammate isswimming()) {
        spawninfo.spawnposition = finalpos;
        spawninfo.spawnangle = vectortoangles(dir);
        continue;
      }

      continue;
    }
  }

  return spawninfo;
}

function scorebuddyspawn(spawnpoint) {
  scripts\mp\spawnfactor::calculatefactorscore(spawnpoint, "avoidShortTimeToEnemySight", 1);
  scripts\mp\spawnfactor::calculatefactorscore(spawnpoint, "avoidClosestEnemy", 1);
}

function getbuddyspawnangles(buddy, spawnlocation) {
  spawnangles = (0, buddy.angles[1], 0);
  return spawnangles;
}

function getteammatesoutofcombat(team) {
  teammates = [];

  foreach(player in level.players) {
    scripts\mp\dev::function_fe598e0c02fe84ec(player, "<dev string:x1c>");

    if(!isDefined(player.team) || player.team != team) {
      scripts\mp\dev::function_fe598e0c02fe84ec(player, "<dev string:x27>");

      continue;
    }

    if(player == self) {
      scripts\mp\dev::function_fe598e0c02fe84ec(player, "<dev string:x35>");

      continue;
    }

    if(!canplayerbebuddyspawnedon(player)) {
      continue;
    }

    if(!player val::get("player_for_spawn_logic")) {
      scripts\mp\dev::function_fe598e0c02fe84ec(player, "<dev string:x3d>");

      continue;
    }

    teammates[teammates.size] = player;
  }

  return array_randomize(teammates);
}

function canplayerbebuddyspawnedon(player) {
  if(player.sessionstate != "playing") {
    scripts\mp\dev::function_fe598e0c02fe84ec(player, "<dev string:x50>" + player.sessionstate);

    return false;
  }

  if(!isreallyalive(player)) {
    scripts\mp\dev::function_fe598e0c02fe84ec(player, "<dev string:x62>");

    return false;
  }

  if(!player isonground()) {
    scripts\mp\dev::function_fe598e0c02fe84ec(player, "<dev string:x6a>");

    return false;
  }

  if(player isonladder()) {
    scripts\mp\dev::function_fe598e0c02fe84ec(player, "<dev string:x75>");

    return false;
  }

  if(player isflashed()) {
    scripts\mp\dev::function_fe598e0c02fe84ec(player, "<dev string:x7f>");

    return false;
  }

  if(player.health < player.maxhealth && (!isDefined(player.lastdamagedtime) || gettime() < player.lastdamagedtime + 3000)) {
    scripts\mp\dev::function_fe598e0c02fe84ec(player, "<dev string:x8a>");

    return false;
  }

  scripts\mp\dev::function_fe598e0c02fe84ec(player, "<dev string:x94>");

  return true;
}

function findspawnlocationnearplayer(player) {
  playerheight = scripts\mp\spawnlogic::getplayertraceheight(player, 1);
  buddynode = findbuddypathnode(player, playerheight, 0.5);

  if(isDefined(buddynode)) {
    return buddynode.origin;
  }

  return undefined;
}

function findbuddypathnode(buddy, playerheight, cosangle) {
  nodearray = getnodesinradiussorted(buddy.origin, 192, 64, playerheight, "Path", 1);
  bestnode = undefined;

  if(isDefined(nodearray) && nodearray.size > 0) {
    buddydir = anglesToForward(buddy.angles);

    if(getdvarint(@ "hash_9bffca47d2e56b54") != 0) {
      scripts\mp\dev::function_55db94df92c1a7c4(buddy, nodearray);
    }

    foreach(buddynode in nodearray) {
      if(isDefined(level.badpathnodes) && array_contains(level.badpathnodes, buddynode)) {
        continue;
      }

      var_644ab9fda129b92b = vectorNormalize(buddynode.origin - buddy.origin);
      dot = vectordot(buddydir, var_644ab9fda129b92b);

      if(dot <= cosangle && !positionwouldtelefrag(buddynode.origin)) {
        bestnode = buddynode;

        if(dot <= 0) {
          break;
        }
      }
    }
  }

  scripts\mp\dev::function_c06e014cedb53155(buddy, bestnode);

  return bestnode;
}

function initscoredata(spawnpoint) {
  spawnpoint.totalscore = 0;
  spawnpoint.totalpossiblescore = 0;
  spawnpoint.isbadspawn = 0;
  spawnpoint.lastscore = [];
  spawnpoint.lastscore["allies"] = 0;
  spawnpoint.lastscore["axis"] = 0;
  spawnpoint.analytics = spawnStruct();
  spawnpoint.analytics.allyaveragedist = 0;
  spawnpoint.analytics.enemyaveragedist = 0;
  spawnpoint.analytics.timesincelastspawn = 0;
  spawnpoint.analytics.maxenemysightfraction = 0;
  spawnpoint.analytics.randomscore = 0;
  spawnpoint.analytics.maxjumpingenemysightfraction = 0;
  spawnpoint.analytics.spawnusedbyenemies = 0;
  spawnpoint.analytics.spawntype = 0;

  spawnpoint.debugscoredata = [];
  spawnpoint.debugcriticaldata = [];
}

function updatespawnpoints(spawnpoints, skipfrontline) {
  team = scripts\mp\spawnlogic::getspawnteam(self);
  skipfrontline = istrue(skipfrontline);
  enemyteam = "all";

  if(level.teambased) {
    enemyteam = getenemyteams(team)[0];
  }

  foreach(spawnpoint in spawnpoints) {
    initscoredata(spawnpoint);
    scripts\mp\spawnlogic::initspawnpointvalues(spawnpoint);
    scripts\mp\spawnlogic::spawnpointdistanceupdate(spawnpoint);
    scripts\mp\spawnlogic::evaluateprecomputedlos(spawnpoint, team);

    if(!skipfrontline) {
      scripts\mp\spawnlogic::evaluateprecomputedlos(spawnpoint, enemyteam);
    }
  }

  if(!skipfrontline) {
    scripts\mp\spawnfactor::updatefrontline(team);
  }
}

function criticalfactors_callback(spawnpoint) {
  if(!critical_factor(&avoidbradleys, spawnpoint)) {
    spawnpoint.badspawnreason = 8;
    return "bad";
  }

  return "primary";
}

function function_3bf7bd55a835ee3a(spawnpoint) {
  if(getdvarint(@ "hash_88da8d1aa9e42678") > 0) {
    return "<dev string:x9d>";
  }

  if(!critical_factor(&function_22b490a6df990a49, spawnpoint)) {
    spawnpoint.badspawnreason = 0;
    return "bad";
  }

  if(!critical_factor(&function_5fdeed44e6029789, spawnpoint)) {
    spawnpoint.badspawnreason = 1;
    return "bad";
  }

  if(!critical_factor(&function_63d3482ba43b656c, spawnpoint)) {
    spawnpoint.badspawnreason = 2;
    return "bad";
  }

  if(!critical_factor(&avoidcarepackages, spawnpoint)) {
    spawnpoint.badspawnreason = 4;
    return "bad";
  }

  if(!critical_factor(&avoidbradleys, spawnpoint)) {
    spawnpoint.badspawnreason = 8;
    return "bad";
  }

  if(!critical_factor(&avoidtelefrag, spawnpoint)) {
    spawnpoint.badspawnreason = 5;
    return "bad";
  }

  if(!critical_factor(&function_bcea4ae71a95bddd, spawnpoint)) {
    spawnpoint.badspawnreason = 6;
    return "bad";
  }

  assert(!currentspawnlogicsupportsfrontline() || scripts\mp\spawnfactor::getglobalfrontlineinfo().lastupdatetime == gettime());

  if(isDefined(spawnpoint.frontlineteam) && level.frontlineinfo.isactive[self.team] && spawnpoint.frontlineteam != self.team) {
    spawnpoint.badspawnreason = 7;
    return "bad";
  }

  if(!critical_factor(&function_5e47ef2aeed10cf1, spawnpoint)) {
    return "secondary";
  }

  if(!critical_factor(&function_4546108b3957a698, spawnpoint)) {
    return "secondary";
  }

  return "primary";
}

function testbuddyspawncriticalfactors(spawnpoint) {
  if(!critical_factor(&function_22b490a6df990a49, spawnpoint)) {
    scripts\mp\dev::function_41fd2e38468e1538(spawnpoint, "<dev string:xa4>");

    return false;
  }

  if(!critical_factor(&function_5fdeed44e6029789, spawnpoint)) {
    scripts\mp\dev::function_41fd2e38468e1538(spawnpoint, "<dev string:xb0>");

    return false;
  }

  if(!critical_factor(&function_63d3482ba43b656c, spawnpoint)) {
    scripts\mp\dev::function_41fd2e38468e1538(spawnpoint, "<dev string:xc0>");

    return false;
  }

  if(!critical_factor(&avoidcarepackages, spawnpoint)) {
    scripts\mp\dev::function_41fd2e38468e1538(spawnpoint, "<dev string:xcd>");

    return false;
  }

  if(!critical_factor(&avoidbradleys, spawnpoint)) {
    scripts\mp\dev::function_41fd2e38468e1538(spawnpoint, "<dev string:xe2>");

    return false;
  }

  if(!critical_factor(&avoidtelefrag, spawnpoint)) {
    scripts\mp\dev::function_41fd2e38468e1538(spawnpoint, "<dev string:xf4>");

    return false;
  }

  if(!critical_factor(&function_4546108b3957a698, spawnpoint)) {
    scripts\mp\dev::function_41fd2e38468e1538(spawnpoint, "<dev string:x100>");

    return false;
  }

  scripts\mp\dev::function_41fd2e38468e1538(spawnpoint, "<dev string:x10e>");

  return true;
}

function getstartspawnpoint_freeforall(spawnpoints) {
  if(!isDefined(spawnpoints)) {
    return undefined;
  }

  selectedspawnpoint = undefined;
  activeplayerlist = scripts\mp\spawnlogic::getactiveplayerlist();
  spawnpoints = checkdynamicspawns(spawnpoints);

  if(!isDefined(activeplayerlist) || activeplayerlist.size == 0) {
    return scripts\mp\spawnlogic::getspawnpoint_random(spawnpoints);
  }

  furthestdistsq = 0;

  foreach(spawnpoint in spawnpoints) {
    if(canspawn(spawnpoint.origin) && !positionwouldtelefrag(spawnpoint.origin)) {
      var_8b91d828ab5a741 = undefined;

      foreach(player in activeplayerlist) {
        disttoenemysq = distancesquared(spawnpoint.origin, player.origin);

        if(!isDefined(var_8b91d828ab5a741) || disttoenemysq < var_8b91d828ab5a741) {
          var_8b91d828ab5a741 = disttoenemysq;
        }
      }

      if(!isDefined(selectedspawnpoint) || var_8b91d828ab5a741 > furthestdistsq) {
        selectedspawnpoint = spawnpoint;
        furthestdistsq = var_8b91d828ab5a741;
      }
    }
  }

  if(!isDefined(selectedspawnpoint)) {
    return scripts\mp\spawnlogic::getspawnpoint_random(spawnpoints);
  }

  return selectedspawnpoint;
}

function logbadspawn(typestring, spawningentity) {
  if(isDefined(spawningentity) && isDefined(spawningentity.disablespawnwarnings) && spawningentity.disablespawnwarnings) {
    return;
  }

  if(!isDefined(typestring)) {
    typestring = "";
  } else {
    typestring = typestring;
  }

  println("<dev string:x119>" + typestring + "<dev string:x12a>");

  if(isDefined(level.matchrecording_logeventmsg)) {
    [[level.matchrecording_logeventmsg]]("LOG_BAD_SPAWN", gettime(), typestring);
  }
}

function getspawnpoint_legacy(spawnpoints, fallbackspawnpoints, factorparams, var_fcb3e7fed624752a, nobuddyspawns) {
  level.spawnglobals.spawnpointslist = spawnpoints;
  spawncontext = scripts\mp\spawnlogic::createspawnquerycontext(self, self.pers["team"]);
  scripts\mp\spawnlogic::setactivespawnquerycontext(spawncontext);
  resetperupdatespawnglobals();
  function_14ba921001eb3164();

  if(level.forcebuddyspawn) {
    spawnpoint = findbuddyspawn();

    if(isDefined(spawnpoint)) {
      scripts\mp\spawnlogic::function_50a59d95bac1964e();

      return spawnpoint;
    }
  }

  var_e6dd1e4c471aa0f1 = undefined;
  level.spawnglobals.spawn_type = 0;
  normalresult = function_fd731d7880fa8ed6(spawnpoints, 0);

  if(isDefined(normalresult)) {
    if(!istrue(normalresult.isbadspawn)) {
      scripts\mp\spawnlogic::function_50a59d95bac1964e();

      return normalresult;
    } else {
      var_e6dd1e4c471aa0f1 = normalresult;
    }
  }

  if(isDefined(fallbackspawnpoints)) {
    fallbackresult = function_fd731d7880fa8ed6(fallbackspawnpoints, 3);

    if(isDefined(fallbackresult)) {
      if(istrue(fallbackresult.isbadspawn)) {
        if(!isDefined(var_e6dd1e4c471aa0f1) || fallbackresult.totalscore > var_e6dd1e4c471aa0f1.totalscore) {
          var_e6dd1e4c471aa0f1 = fallbackresult;
        }
      } else {
        scripts\mp\spawnlogic::function_50a59d95bac1964e();

        logbadspawn("Using a fallback spawn.", self);
        return fallbackresult;
      }
    }
  }

  if(istrue(var_fcb3e7fed624752a)) {
    scripts\mp\spawnlogic::function_50a59d95bac1964e();

    return undefined;
  }

  logbadspawn("Using a LastResort spawn point.", self);

  if(isDefined(self) && isPlayer(self)) {
    self iprintlnbold("<dev string:x12f>");
  }

  if(!istrue(nobuddyspawns)) {
    buddyspawn = findbuddyspawn();

    if(isDefined(buddyspawn)) {
      buddyspawn.spawntype = 7;
      level.spawnglobals.buddyspawnid = 0;

      if(isDefined(buddyspawn.buddyplayerid)) {
        level.spawnglobals.buddyplayerid = buddyspawn.buddyplayerid;
      }

      scripts\mp\spawnlogic::function_50a59d95bac1964e();

      return buddyspawn;
    }

    logbadspawn("UNABLE TO BUDDY SPAWN. EXTREMELY BAD", self);
  }

  if(level.teambased && !isanymlgmatch()) {
    lastbadspawntime = level.spawnglobals.lastbadspawntime[self.team];

    if(isDefined(lastbadspawntime) && gettime() - lastbadspawntime < 5000) {
      var_e6dd1e4c471aa0f1 = spawnpoints[randomint(spawnpoints.size)];
    } else {
      level.spawnglobals.lastbadspawntime[self.team] = gettime();
    }
  }

  scripts\mp\spawnlogic::function_50a59d95bac1964e();

  return var_e6dd1e4c471aa0f1;
}

function function_fd731d7880fa8ed6(spawnpoints, var_29b92441af87f23f) {
  spawnpoints = checkdynamicspawns(spawnpoints);
  var_db238c057df08dfc["primary"] = [];
  var_db238c057df08dfc["secondary"] = [];
  var_db238c057df08dfc["bad"] = [];
  updatespawnpoints(spawnpoints);

  foreach(spawnpoint in spawnpoints) {
    result = function_3bf7bd55a835ee3a(spawnpoint);
    var_db238c057df08dfc[result][var_db238c057df08dfc[result].size] = spawnpoint;
    spawnpoint.lastbucket[ter_op(isDefined(self.spawnlogicteam), self.spawnlogicteam, self.team)] = result;

    if(isDefined(spawnpoint.analytics) && isDefined(spawnpoint.analytics.spawntype)) {
      if(result == "primary") {
        spawnpoint.analytics.spawntype = var_29b92441af87f23f + 1;
        continue;
      }

      if(result == "secondary") {
        spawnpoint.analytics.spawntype = var_29b92441af87f23f + 2;
        continue;
      }

      spawnpoint.analytics.spawntype = var_29b92441af87f23f + 3;
    }
  }

  if(var_db238c057df08dfc["primary"].size) {
    result = gethighestscoringspawn(var_db238c057df08dfc["primary"]);
    result.spawn_type = 1;
    return result;
  }

  if(var_db238c057df08dfc["secondary"].size) {
    result = gethighestscoringspawn(var_db238c057df08dfc["secondary"]);
    result.spawn_type = 2;
    return result;
  }

  if(var_db238c057df08dfc["bad"].size) {
    logbadspawn("Using Bad Spawn", self);
    result = gethighestscoringspawn(var_db238c057df08dfc["bad"]);

    if(isDefined(result)) {
      result.isbadspawn = 1;
    }

    return result;
  }

  return undefined;
}

function resetperupdatespawnglobals() {
  spawnglobals = level.spawnglobals;
  spawnglobals.hasclusterdata = 0;
  spawnglobals.haslanedata = 0;
}

function function_14ba921001eb3164() {
  team = scripts\mp\spawnlogic::getspawnteam(self);
  scripts\mp\spawnlogic::updatespawnviewers();
  spawnglobals = level.spawnglobals;

  if(scripts\mp\spawnlogic::isfactorinuse("preferNearGroupsOfTeamMates")) {
    spawnglobals.teamclusters = [];
    spawnglobals.teamclusters[team] = scripts\mp\spawnlogic::calculateteamclusters(team);
  }

  if(scripts\mp\spawnlogic::isfactorinuse("preferOccupiedLanes") || scripts\mp\spawnlogic::isfactorinuse("preferToBalanceLanes")) {
    spawnglobals.occupiedlanemasks = [];

    foreach(lanetrigger in level.spawnglobals.lanetriggers) {
      foreach(otherplayer in level.players) {
        otherplayerteam = scripts\mp\spawnlogic::getspawnteam(otherplayer);

        if(!isreallyalive(otherplayer)) {
          continue;
        }

        if(!otherplayer val::get("player_for_spawn_logic")) {
          continue;
        }

        if(ispointinvolume(otherplayer.origin, lanetrigger)) {
          if(!isDefined(spawnglobals.occupiedlanemasks[otherplayerteam])) {
            spawnglobals.occupiedlanemasks[otherplayerteam] = 0;
          }

          spawnglobals.occupiedlanemasks[otherplayerteam] |= lanetrigger.indexflag;
        }
      }
    }
  }
}

function gethighestscoringspawn(spawnpoints) {
  bestspawn = spawnpoints[0];

  foreach(spawnpoint in spawnpoints) {
    scripts\mp\spawnlogic::scorespawnpoint(spawnpoint);

    if(spawnpoint.totalscore > bestspawn.totalscore) {
      bestspawn = spawnpoint;
    }
  }

  bestspawn = selectbestspawnpoint(bestspawn, spawnpoints);
  return bestspawn;
}

function squadspawndebug() {
  self endon("death_or_disconnect");
  spawninfo = spawnStruct();

  while(true) {
    spawninfo.spawnposition = undefined;
    spawninfo.spawnangle = undefined;
    spawninfo = capsulepass(spawninfo, self);
    failed = 0;

    if(!isDefined(spawninfo.spawnposition)) {
      spawninfo.spawnposition = self.origin;
      spawninfo.spawnangle = self.angles;
      failed = 1;
    }

    thread scripts\cp_mp\utility\debug_utility::drawsphere(spawninfo.spawnposition, 16, 0.1, ter_op(failed, (1, 0, 0), (0, 1, 0)));
    thread scripts\cp_mp\utility\debug_utility::drawangles(spawninfo.spawnposition, spawninfo.spawnangle, 0.1, 1);
    wait 0.1;
  }
}