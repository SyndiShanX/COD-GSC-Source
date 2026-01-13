/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2798.gsc
**************************************/

init() {
  level.spawnglobals = spawnStruct();

  if(scripts\mp\utility\game::isanymlgmatch()) {
    level.killstreakspawnshielddelayms = 0;
  } else {
    level.killstreakspawnshielddelayms = 4000;
  }

  level.var_72A2 = 0;
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  level.disablebutton = 0;
  level.numplayerswaitingtospawn = 0;
  level.var_C23C = 0;
  level.players = [];
  level.participants = [];
  level.characters = [];
  level.var_108F8 = [];
  level.grenades = [];
  level.missiles = [];
  level.carepackages = [];
  level.helis = [];
  level.turrets = [];
  level.var_114E3 = [];
  level.var_EC9F = [];
  level.var_935F = [];
  level.ugvs = [];
  level.balldrones = [];
  level.var_105EA = [];
  level.var_D3CC = [];
  level.spawnglobals.lowerlimitfullsights = getdvarfloat("scr_lowerLimitFullSights");
  level.spawnglobals.lowerlimitcornersights = getdvarfloat("scr_lowerLimitCornerSights");
  level.spawnglobals.lastteamspawnpoints = [];
  level.spawnglobals.lastbadspawntime = [];
  level thread onplayerconnect();
  level thread func_108FE();
  level thread trackgrenades();
  level thread trackmissiles();
  level thread trackcarepackages();
  level thread func_11ADD();
  thread func_D91D();
  level thread logextraspawninfothink();

  for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
    level.teamspawnpoints[level.teamnamelist[var_0]] = [];
    level.teamfallbackspawnpoints[level.teamnamelist[var_0]] = [];
  }

  scripts\mp\spawnfactor::func_9758();
  func_AEAE();
}

func_11ADD() {
  for(;;) {
    self waittill("host_migration_end");
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    func_FAD6(var_0);
  }
}

func_FAD6(var_0) {
  if(isDefined(level.var_C7B3)) {
    foreach(var_2 in level.var_C7B3) {
      var_0 thread func_139B5(var_2);
    }
  }
}

func_139B5(var_0) {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(var_1 != self) {
      continue;
    }
    if(!scripts\mp\utility\game::isreallyalive(var_1)) {
      continue;
    }
    if(scripts\mp\utility\game::func_9FAE(var_1)) {
      continue;
    }
    if(scripts\mp\utility\game::istouchingboundsnullify(var_1)) {
      continue;
    }
    var_1 thread func_13B84(var_0);
  }
}

func_13B84(var_0) {
  self endon("disconnect");
  level endon("game_ended");

  if(!isDefined(self.lastboundstimelimit)) {
    self.lastboundstimelimit = scripts\mp\utility\game::func_7F9B();
  }

  var_1 = gettime() + int(self.lastboundstimelimit * 1000);
  self.var_1D44 = 1;
  self setclientomnvar("ui_out_of_bounds_countdown", var_1);
  self func_859E("mp_out_of_bounds");
  var_2 = 0;

  for(var_3 = self.lastboundstimelimit; self istouching(var_0); var_3 = var_3 - 0.05) {
    if(!scripts\mp\utility\game::isreallyalive(self) || scripts\mp\utility\game::istrue(level.gameended)) {
      break;
    }
    if(var_3 <= 0) {
      var_2 = 1;
      break;
    }

    scripts\engine\utility::waitframe();
  }

  self setclientomnvar("ui_out_of_bounds_countdown", 0);
  self func_859E("");
  self.var_1D44 = undefined;

  if(scripts\mp\utility\game::istrue(var_2)) {
    self.lastboundstimelimit = undefined;
    scripts\mp\utility\game::_suicide();
  } else {
    self.lastboundstimelimit = var_3;
    thread watchtimelimitcooldown();
  }

  if(scripts\mp\utility\game::isreallyalive(self) && scripts\mp\utility\game::istrue(level.nukedetonated) && !scripts\mp\utility\game::istrue(level.var_C1B2)) {
    thread scripts\mp\killstreaks\nuke::func_FB0F(0.05);
  }
}

watchtimelimitcooldown() {
  self endon("disconnect");
  self notify("start_time_limit_cooldown");
  self endon("start_time_limit_cooldown");

  for(var_0 = scripts\mp\utility\game::getmaxoutofboundscooldown(); var_0 > 0; var_0 = var_0 - 0.05) {
    scripts\engine\utility::waitframe();
  }

  self.lastboundstimelimit = undefined;
}

setactivespawnlogic(var_0) {
  var_1 = [var_0];
  var_2 = [0];

  foreach(var_4 in level.spawnglobals.var_AFBF) {
    var_5 = strtok(var_4, "_");

    if(var_5.size == 3 && var_5[0] == var_0 && var_5[1] == "v") {
      var_1[var_1.size] = var_4;
      var_2[var_2.size] = int(var_5[2]);
    }
  }

  var_7 = randomint(var_1.size);
  var_0 = var_1[var_7];
  level.spawnglobals.logicvariantid = var_2[var_7];
  level.spawnglobals.var_1677 = var_0;
}

func_AEAE() {
  level.spawnglobals.var_10882 = [];
  level.spawnglobals.var_AFBF = [];
  var_0 = -1;

  for(;;) {
    var_0++;
    var_1 = tablelookupbyrow("mp\spawnweights.csv", var_0, 0);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }
    if(!isDefined(level.spawnglobals.var_10882[var_1])) {
      level.spawnglobals.var_10882[var_1] = [];
      level.spawnglobals.var_AFBF[level.spawnglobals.var_AFBF.size] = var_1;
    }

    var_2 = tablelookupbyrow("mp\spawnweights.csv", var_0, 1);
    var_3 = tablelookupbyrow("mp\spawnweights.csv", var_0, 2);
    var_3 = float(var_3);
    level.spawnglobals.var_10882[var_1][var_2] = var_3;
  }
}

func_EC46(var_0, var_1) {
  foreach(var_4, var_3 in level.spawnglobals.var_10882[level.spawnglobals.var_1677]) {
    scripts\mp\spawnfactor::calculatefactorscore(var_0, var_4, var_3, var_1);
  }
}

addstartspawnpoints(var_0, var_1) {
  var_2 = getspawnpointarray(var_0);
  var_3 = [];

  if(isDefined(level.modifiedspawnpoints)) {
    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      if(checkmodifiedspawnpoint(var_2[var_4])) {
        continue;
      }
      var_3[var_3.size] = var_2[var_4];
    }
  } else
    var_3 = var_2;

  if(!var_3.size) {
    if(!scripts\mp\utility\game::istrue(var_1)) {}

    return;
  }

  if(!isDefined(level.var_10DF1)) {
    level.var_10DF1 = [];
  }

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_3[var_4] func_108FA();
    var_3[var_4].selected = 0;
    var_3[var_4].infront = 0;
    level.var_10DF1[level.var_10DF1.size] = var_3[var_4];
  }

  if(level.teambased) {
    foreach(var_6 in var_3) {
      var_6.infront = 1;
      var_7 = anglesToForward(var_6.angles);

      foreach(var_9 in var_3) {
        if(var_6 == var_9) {
          continue;
        }
        var_10 = vectornormalize(var_9.origin - var_6.origin);
        var_11 = vectordot(var_7, var_10);

        if(var_11 > 0.86) {
          var_6.infront = 0;
          break;
        }
      }
    }
  }
}

addspawnpoints(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_4 = getspawnpointarray(var_1);

  if(!var_4.size) {
    return;
  }
  registerspawnpoints(var_0, var_4, var_3);
}

registerspawnpoints(var_0, var_1, var_2) {
  if(!isDefined(level.spawnpoints)) {
    level.spawnpoints = [];
  }

  if(!isDefined(level.teamspawnpoints[var_0])) {
    level.teamspawnpoints[var_0] = [];
  }

  if(!isDefined(level.teamfallbackspawnpoints[var_0])) {
    level.teamfallbackspawnpoints[var_0] = [];
  }

  foreach(var_4 in var_1) {
    if(checkmodifiedspawnpoint(var_4)) {
      continue;
    }
    if(!isDefined(var_4.var_9800)) {
      var_4 func_108FA();
      level.spawnpoints[level.spawnpoints.size] = var_4;
    }

    if(scripts\mp\utility\game::istrue(var_2)) {
      level.teamfallbackspawnpoints[var_0][level.teamfallbackspawnpoints[var_0].size] = var_4;
      var_4.var_9DF0 = 1;
      continue;
    }

    level.teamspawnpoints[var_0][level.teamspawnpoints[var_0].size] = var_4;
  }
}

func_108FA() {
  var_0 = self;
  level.spawnmins = expandmins(level.spawnmins, var_0.origin);
  level.spawnmaxs = expandmaxs(level.spawnmaxs, var_0.origin);
  var_0.forward = anglesToForward(var_0.angles);
  var_0.var_101E9 = var_0.origin + (0, 0, 50);
  var_0.lastspawntime = gettime();
  var_0.var_C7DA = 1;
  var_0.var_9800 = 1;
  var_0.alternates = [];
  var_0.var_A9E9 = [];
  var_1 = 1024;

  if(!bullettracepassed(var_0.var_101E9, var_0.var_101E9 + (0, 0, var_1), 0, undefined)) {
    var_2 = var_0.var_101E9 + var_0.forward * 100;

    if(!bullettracepassed(var_2, var_2 + (0, 0, var_1), 0, undefined)) {
      var_0.var_C7DA = 0;
    }
  }

  var_3 = anglestoright(var_0.angles);
  var_4 = 1;

  if(scripts\mp\utility\game::istrue(var_0.noalternates)) {
    var_4 = 0;
  }

  if(var_4) {
    func_17A7(var_0, var_0.origin + var_3 * 45);
    func_17A7(var_0, var_0.origin - var_3 * 45);
  }

  if(shoulduseprecomputedlos() || getdvarint("sv_generateLOSData", 0) == 1) {
    var_0.radiuspathnodes = getradiuspathsighttestnodes(var_0.origin);

    if(var_0.radiuspathnodes.size <= 0) {}
  }

  initspawnpointvalues(var_0);
}

func_17A7(var_0, var_1) {
  var_2 = playerphysicstrace(var_0.origin, var_0.origin + (0, 0, 18));
  var_3 = var_2[2] - var_0.origin[2];
  var_4 = (var_1[0], var_1[1], var_1[2] + var_3);
  var_5 = playerphysicstrace(var_2, var_4);

  if(var_5 != var_4) {
    return;
  }
  var_6 = playerphysicstrace(var_4, var_1);
  var_0.alternates[var_0.alternates.size] = var_6;
}

getspawnpointarray(var_0) {
  if(!isDefined(level.var_108F8)) {
    level.var_108F8 = [];
  }

  if(!isDefined(level.var_108F8[var_0])) {
    level.var_108F8[var_0] = [];
    level.var_108F8[var_0] = getspawnarray(var_0);

    foreach(var_2 in level.var_108F8[var_0]) {
      var_2.classname = var_0;
    }
  }

  return level.var_108F8[var_0];
}

getspawnpoint_random(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = undefined;
  var_0 = scripts\mp\spawnscoring::checkdynamicspawns(var_0);
  var_0 = scripts\engine\utility::array_randomize(var_0);

  foreach(var_3 in var_0) {
    var_1 = var_3;

    if(canspawn(var_1.origin) && !positionwouldtelefrag(var_1.origin)) {
      break;
    }
  }

  return var_1;
}

getspawnpoint_startspawn(var_0, var_1) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_2 = undefined;
  var_0 = scripts\mp\spawnscoring::checkdynamicspawns(var_0);

  foreach(var_4 in var_0) {
    if(!isDefined(var_4.selected)) {
      continue;
    }
    if(var_4.selected) {
      continue;
    }
    if(var_4.infront) {
      var_2 = var_4;
      break;
    }

    var_2 = var_4;
  }

  if(!isDefined(var_2)) {
    if(scripts\mp\utility\game::istrue(var_1)) {
      return undefined;
    }

    var_2 = getspawnpoint_random(var_0);
  }

  if(isDefined(var_2)) {
    var_2.selected = 1;
  }

  return var_2;
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

getteamfallbackspawnpoints(var_0) {
  return level.teamfallbackspawnpoints[var_0];
}

ispathdataavailable() {
  if(!isDefined(level.var_C96A)) {
    var_0 = getallnodes();
    level.var_C96A = isDefined(var_0) && var_0.size > 150;
  }

  return level.var_C96A;
}

addtoparticipantsarray() {
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

func_108FE() {
  while(!isDefined(level.spawnpoints) || level.spawnpoints.size == 0) {
    wait 0.05;
  }

  level thread func_108FC();

  if(shoulduseprecomputedlos() || getdvarint("sv_generateLOSData", 0) == 1) {
    var_0 = [];

    if(level.spawnpoints.size == 0) {
      scripts\engine\utility::error("Spawn System Failure. No Spawnpoints found.");
    }

    for(var_1 = 0; var_1 < level.spawnpoints.size; var_1++) {
      for(var_2 = 0; var_2 < level.spawnpoints[var_1].radiuspathnodes.size; var_2++) {
        var_0[var_0.size] = level.spawnpoints[var_1].radiuspathnodes[var_2];
      }
    }

    if(var_0.size > 0) {
      cachespawnpathnodesincode(var_0);
    } else {
      scripts\engine\utility::error("Spawn System Failure. There are no pathnodes near any spawnpoints.");
    }
  }

  for(;;) {
    level.disablebutton = getdvarint("scr_disableClientSpawnTraces") > 0;
    wait 0.05;
  }
}

getactiveplayerlist() {
  var_0 = [];

  foreach(var_2 in level.characters) {
    if(!scripts\mp\utility\game::isreallyalive(var_2)) {
      continue;
    }
    if(isplayer(var_2) && var_2.sessionstate != "playing") {
      continue;
    }
    if(var_2 scripts\mp\killstreaks\killstreaks::isusinggunship() && isDefined(var_2.chopper) && (!isDefined(var_2.chopper.var_BCB4) || !var_2.chopper.var_BCB4)) {
      continue;
    }
    if(var_2 scripts\mp\killstreaks\killstreaks::func_9FC4()) {
      continue;
    }
    var_2.var_108DF = getspawnteam(var_2);

    if(var_2.var_108DF == "spectator") {
      continue;
    }
    if(isagent(var_2) && var_2.agent_type == "seeker") {
      continue;
    }
    var_3 = getplayertraceheight(var_2);
    var_4 = var_2 getEye();
    var_4 = (var_4[0], var_4[1], var_2.origin[2] + var_3);
    var_2.var_108E0 = var_3;
    var_2.var_10917 = var_4;
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

func_12F1F() {
  level.var_1091D = getactiveplayerlist();

  foreach(var_1 in level.var_1091D) {
    var_1.spawnviewpathnodes = undefined;
  }

  foreach(var_4 in level.turrets) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_4.var_108DF = getspawnteam(var_4);
    level.var_1091D[level.var_1091D.size] = var_4;
    var_4.spawnviewpathnodes = undefined;
  }

  foreach(var_7 in level.ugvs) {
    if(!isDefined(var_7)) {
      continue;
    }
    var_7.var_108DF = getspawnteam(var_7);
    level.var_1091D[level.var_1091D.size] = var_7;
    var_7.spawnviewpathnodes = undefined;
  }

  foreach(var_10 in level.var_105EA) {
    if(!isDefined(var_10)) {
      continue;
    }
    var_10.var_108DF = getspawnteam(var_10);
    level.var_1091D[level.var_1091D.size] = var_10;
    var_10.spawnviewpathnodes = undefined;
  }

  foreach(var_13 in level.balldrones) {
    if(!isDefined(var_13)) {
      continue;
    }
    var_13.var_108DF = getspawnteam(var_13);
    level.var_1091D[level.var_1091D.size] = var_13;
    var_13.spawnviewpathnodes = undefined;
  }
}

func_108FC() {
  if(shoulduseprecomputedlos()) {
    level waittill("spawn_restart_trace_system");
  }

  var_0 = 18;
  var_1 = 0;
  var_2 = 0;
  var_3 = getactiveplayerlist();

  for(;;) {
    if(var_2) {
      wait 0.05;
      var_1 = 0;
      var_2 = 0;
      var_3 = getactiveplayerlist();
    }

    var_4 = level.spawnpoints;
    var_4 = scripts\mp\spawnscoring::checkdynamicspawns(var_4);
    var_2 = 1;

    foreach(var_6 in var_4) {
      clearspawnpointsightdata(var_6);

      foreach(var_8 in var_3) {
        if(var_6.var_74BC[var_8.var_108DF]) {
          continue;
        }
        var_9 = spawnsighttrace(var_6, var_6.var_101E9, var_8.var_10917);
        var_1++;

        if(!var_9) {
          continue;
        }
        if(var_9 > 0.95) {
          var_6.var_74BC[var_8.var_108DF]++;
          var_6.var_AFD9[var_8.var_108DF]++;
          continue;
        }

        var_6.var_466B[var_8.var_108DF]++;
      }

      func_17DC(var_6, level.turrets);
      func_17DC(var_6, level.ugvs);
      func_17DC(var_6, level.var_105EA);
      func_17DC(var_6, level.balldrones);
      func_AFDA(var_6);

      if(var_0 < var_1) {
        wait 0.05;
        var_1 = 0;
        var_2 = 0;
        var_3 = getactiveplayerlist();
      }
    }
  }
}

func_AFDA(var_0) {
  if(scripts\mp\utility\game::istrue(var_0.budgetedents) || scripts\mp\utility\game::istrue(var_0.isdynamicspawn)) {
    return;
  }
  if(isDefined(level.matchrecording_logevent)) {
    if(isDefined(level.matchrecording_generateid) && !isDefined(var_0.logid)) {
      var_0.logid = [
        }
        [level.matchrecording_generateid]]();

    if(isDefined(var_0.logid)) {
      var_1 = 3;

      if(level.teambased) {
        var_2 = var_0.var_AFD9["allies"] == 0;
        var_3 = var_0.var_AFD9["axis"] == 0;

        if(var_2 && var_3) {
          var_1 = 0;
        } else if(var_2) {
          var_1 = 1;
        } else if(var_3) {
          var_1 = 2;
        }
      } else
        var_1 = scripts\engine\utility::ter_op(var_0.var_74BC["all"] == 0, 0, 3);

      if(!isDefined(var_0.var_AFBB) || var_0.var_AFBB != var_1) {
        [[level.matchrecording_logevent]](var_0.logid, "allies", "SPAWN_ENTITY", var_0.origin[0], var_0.origin[1], gettime(), var_1);
        var_0.var_AFBB = var_1;
      }
    }
  }
}

func_108F9(var_0, var_1) {
  clearspawnpointdistancedata(var_0);

  foreach(var_3 in var_1) {
    var_4 = distancesquared(var_3.origin, var_0.origin);

    if(var_4 < var_0.mindistsquared[var_3.var_108DF]) {
      var_0.mindistsquared[var_3.var_108DF] = var_4;
    }

    if(var_3.var_108DF == "spectator") {
      continue;
    }
    var_0.distsumsquared[var_3.var_108DF] = var_0.distsumsquared[var_3.var_108DF] + var_4;
    var_0.distsumsquaredcapped[var_3.var_108DF] = var_0.distsumsquaredcapped[var_3.var_108DF] + min(var_4, scripts\mp\spawnfactor::maxplayerspawninfluencedistsquared());
    var_0.totalplayers[var_3.var_108DF]++;
    var_0.var_5721[var_3.var_108DF][var_3 getentitynumber()] = var_4;
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
      func_41E6(var_0, var_2);
    }
  } else
    func_41E6(var_0, "all");
}

func_FADD(var_0) {}

clearspawnpointdistancedata(var_0) {
  if(level.teambased) {
    foreach(var_2 in level.teamnamelist) {
      func_41E5(var_0, var_2);
    }
  } else
    func_41E5(var_0, "all");
}

func_41E6(var_0, var_1) {
  var_0.var_74BC[var_1] = 0;
  var_0.var_466B[var_1] = 0;
  var_0.var_AFD9[var_1] = 0;
  var_0.var_B4C4[var_1] = 0.0;
  var_0.var_B4A6[var_1] = 0.0;
}

func_41E5(var_0, var_1) {
  var_0.distsumsquared[var_1] = 0;
  var_0.distsumsquaredcapped[var_1] = 0;
  var_0.mindistsquared[var_1] = 9999999;
  var_0.totalplayers[var_1] = 0;
  var_0.var_5721[var_1] = [];
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

func_17DC(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = getspawnteam(var_3);

    if(var_0.var_74BC[var_4]) {
      continue;
    }
    var_5 = var_3.origin + (0, 0, 50);
    var_6 = 0.0;

    if(!var_6) {
      var_6 = spawnsighttrace(var_0, var_0.var_101E9, var_5);
    }

    if(!var_6) {
      continue;
    }
    if(var_6 > 0.95) {
      var_0.var_74BC[var_4]++;
      continue;
    }

    var_0.var_466B[var_4]++;
  }
}

finalizespawnpointchoice(var_0) {
  if(!isplayer(self)) {
    return;
  }
  var_1 = gettime();
  self.lastspawnpoint = var_0;
  self.lastspawntime = var_1;
  var_0.lastspawntime = var_1;
  var_0.lastspawnteam = self.team;
  level.spawnglobals.lastteamspawnpoints[self.team] = var_0;
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
  if(getdvarint("scr_forceStartSpawns", 0) == 1) {
    return 1;
  }

  if(scripts\mp\utility\game::istrue(level.var_5614)) {
    return 0;
  }

  return level.ingraceperiod && (!isDefined(level.numkills) || level.numkills == 0);
}

getpathsighttestnodes(var_0, var_1) {
  if(var_1) {
    var_2 = 0;
    var_3 = getclosenoderadiusdist();
  } else {
    var_2 = getclosenoderadiusdist();
    var_3 = 250;
  }

  return getnodesinradius(var_0, var_3, var_2, 512, "path");
}

getradiuspathsighttestnodes(var_0) {
  var_1 = [];
  var_2 = getclosestnodeinsight(var_0);

  if(isDefined(var_2)) {
    var_1[0] = var_2;
  }

  if(!isDefined(var_2)) {
    var_1 = getnodesinradius(var_0, getclosenoderadiusdist(), 0, 256, "path");

    if(var_1.size == 0) {
      var_1 = getnodesinradius(var_0, 250, 0, 256, "path");
    }
  }

  return var_1;
}

func_67D3(var_0, var_1) {
  if(!shoulduseprecomputedlos()) {
    return;
  }
  var_2 = "all";

  if(level.teambased) {
    var_2 = scripts\mp\gameobjects::func_7E93(var_1);
  }

  func_41E6(var_0, var_2);
  var_3 = 0.95;
  var_4 = 0;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = isttlosdataavailable();
  var_3 = level.spawnglobals.lowerlimitfullsights;
  var_4 = level.spawnglobals.lowerlimitcornersights;

  foreach(var_9 in level.var_1091D) {
    if(level.teambased && var_9.var_108DF != var_2) {
      continue;
    }
    if(var_0.var_74BC[var_9.var_108DF]) {
      break;
    }
    if(!isDefined(var_9.spawnviewpathnodes)) {
      var_9.spawnviewpathnodes = var_9 func_8480(getfarnoderadiusdist());

      if(!isDefined(var_9.spawnviewpathnodes) || var_9.spawnviewpathnodes.size == 0) {
        if(isDefined(level.matchrecording_logeventmsg) && var_7 && isplayer(var_9)) {
          if(!isDefined(var_9.var_A9CC) || var_9.var_A9CC != gettime()) {
            [
              [level.matchrecording_logeventmsg]
            ]("LOG_GENERIC_MESSAGE", gettime(), "WARNING: Could not use TTLOS data for player " + var_9.name);
            var_9.var_A9CC = gettime();
          }
        }
      }
    }

    if(var_7 && isDefined(var_9.spawnviewpathnodes) && var_9.spawnviewpathnodes.size > 0) {
      var_10 = _precomputedlosdatatest(var_9, var_0);
      var_5 = var_10[0];
      var_6 = var_10[1];
    }

    if(!isDefined(var_5)) {
      var_11 = undefined;

      if(isplayer(var_9)) {
        var_11 = var_9 getEye();
      } else {
        var_11 = var_9.origin + (0, 0, 50);
      }

      var_5 = func_54EC(var_0, var_9, var_11);
      var_6 = var_5;
    }

    if(!isDefined(var_0.var_B4C4[var_9.var_108DF]) || var_5 > var_0.var_B4C4[var_9.var_108DF]) {
      var_0.var_B4C4[var_9.var_108DF] = var_5;
    }

    if(isDefined(var_6) && isplayer(var_9)) {
      if(!isDefined(var_0.var_B4A6[var_9.var_108DF]) || var_5 > var_0.var_B4A6[var_9.var_108DF]) {
        var_0.var_B4A6[var_9.var_108DF] = var_6;
      }
    }

    if(var_5 > var_3) {
      var_0.var_74BC[var_9.var_108DF]++;
      var_0.var_AFD9[var_9.var_108DF]++;
      continue;
    }

    if(var_5 > var_4) {
      var_0.var_466B[var_9.var_108DF]++;
    }
  }

  func_AFDA(var_0);
}

_precomputedlosdatatest(var_0, var_1) {
  var_2 = checkttlosoverrides(var_0, var_1);

  if(!isDefined(var_2)) {
    var_2 = _precomputedlosdatatest(var_0.spawnviewpathnodes, var_1.radiuspathnodes);
  }

  return var_2;
}

checkttlosoverrides(var_0, var_1) {
  if(!isDefined(level.spawnglobals.ttlosoverrides)) {
    return;
  }
  foreach(var_3 in var_0.spawnviewpathnodes) {
    var_4 = var_3 getnodenumber();

    if(isDefined(level.spawnglobals.ttlosoverrides[var_4])) {
      foreach(var_6 in var_1.radiuspathnodes) {
        var_7 = var_6 getnodenumber();

        if(isDefined(level.spawnglobals.ttlosoverrides[var_4][var_7])) {
          return level.spawnglobals.ttlosoverrides[var_4][var_7];
        }
      }
    }
  }
}

addttlosoverride(var_0, var_1, var_2, var_3) {
  level endon("game_ended");

  for(;;) {
    if(isDefined(level.spawnglobals)) {
      break;
    }
    scripts\engine\utility::waitframe();
  }

  if(!isDefined(level.spawnglobals.ttlosoverrides)) {
    level.spawnglobals.ttlosoverrides = [];
  }

  if(!isDefined(level.spawnglobals.ttlosoverrides[var_0])) {
    level.spawnglobals.ttlosoverrides[var_0] = [];
  }

  level.spawnglobals.ttlosoverrides[var_0][var_1] = [var_2, var_3];

  if(!isDefined(level.spawnglobals.ttlosoverrides[var_1])) {
    level.spawnglobals.ttlosoverrides[var_1] = [];
  }

  level.spawnglobals.ttlosoverrides[var_1][var_0] = [var_2, var_3];
}

getclosenoderadiusdist() {
  return 130;
}

getfarnoderadiusdist() {
  return 250;
}

func_54EC(var_0, var_1, var_2) {
  var_3 = var_0.var_101E9;
  var_4 = var_2;
  var_5 = physics_createcontents(["physicscontents_aiavoid", "physicscontents_solid", "physicscontents_structural"]);
  var_6 = physics_raycast(var_3, var_4, var_5, var_1, 0, "physicsquery_any");
  return scripts\engine\utility::ter_op(var_6, 0.0, 1.0);
}

getmaxdistancetolos() {
  return 2550;
}

shoulduseprecomputedlos() {
  return getdvarint("sv_usePrecomputedLOSData", 0) == 1 && !isDefined(level.var_560C) && getdvarint("sv_generateLOSData", 0) != 1;
}

isttlosdataavailable() {
  return _getislosdatafileloaded();
}

func_D91D() {
  level waittill("prematch_done");

  if(getdvarint("scr_playtest", 0) == 1 && isDefined(level.players)) {
    foreach(var_1 in level.players) {
      if(var_1 ishost()) {
        if(shoulduseprecomputedlos()) {
          var_1 iprintlnbold("Attempting to use NEW Spawn System...");
        } else {
          var_1 iprintlnbold("Using OLD Spawn System...");
        }

        break;
      }
    }
  }

  if(isDefined(level.matchrecording_logeventmsg)) {
    if(shoulduseprecomputedlos()) {
      [
        [level.matchrecording_logeventmsg]
      ]("LOG_GENERIC_MESSAGE", gettime(), "Attempting to use TTLOS Spawning Data...");
    } else {
      [
      }
      [level.matchrecording_logeventmsg]]("LOG_GENERIC_MESSAGE", gettime(), "Using Corner-Trace Spawning System...");
  }
}

func_E2B6() {
  level notify("spawn_restart_trace_system");
}

func_9DF1(var_0) {
  return scripts\mp\utility\game::istrue(var_0.var_9DF0);
}

logextraspawninfothink() {
  if(getdvarint("scr_extra_spawn_logging", 0) != 1) {
    return;
  }
  level waittill("prematch_done");
  var_0 = undefined;
  var_1 = undefined;

  if(isDefined(level.matchrecording_generateid)) {
    var_0 = [[level.matchrecording_generateid]]();
    var_1 = [[level.matchrecording_generateid]]();
  }

  for(;;) {
    if(!shoulduseprecomputedlos()) {
      break;
    }
    logextraspawn("allies", var_0);
    wait 0.5;
    logextraspawn("axis", var_1);
    wait 0.5;
  }
}

logextraspawn(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.team = var_0;
  var_2.pers = [];
  var_2.pers["team"] = var_0;
  var_2.disablespawnwarnings = 1;
  var_2.isdynamicspawn = 1;
  var_3 = var_2[[level.getspawnpoint]]();

  if(isDefined(level.matchrecording_logevent) && isDefined(var_3) && isDefined(var_1)) {
    var_4 = scripts\engine\utility::ter_op(var_0 == "allies", "BEST_SPAWN_ALLIES", "BEST_SPAWN_AXIS");
    [[level.matchrecording_logevent]](var_1, var_0, var_4, var_3.origin[0], var_3.origin[1], gettime());
  }
}

clearlastteamspawns() {
  level.spawnglobals.lastteamspawnpoints = [];
}

getoriginidentifierstring(var_0) {
  return int(var_0.origin[0]) + " " + int(var_0.origin[1]) + " " + int(var_0.origin[2]);
}

checkmodifiedspawnpoint(var_0) {
  if(!isDefined(level.modifiedspawnpoints)) {
    return 0;
  }

  var_1 = undefined;
  var_2 = getoriginidentifierstring(var_0);

  if(isDefined(level.modifiedspawnpoints[var_2])) {
    var_1 = level.modifiedspawnpoints[var_2][var_0.classname];
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  if(scripts\mp\utility\game::istrue(var_1["remove"])) {
    return 1;
  }

  if(isDefined(var_1["origin"])) {
    var_0.origin = var_1["origin"];
  }

  if(isDefined(var_1["angles"])) {
    var_0.angles = var_1["angles"];
  }

  if(scripts\mp\utility\game::istrue(var_1["no_alternates"])) {
    var_0.noalternates = 1;
  }

  return 0;
}