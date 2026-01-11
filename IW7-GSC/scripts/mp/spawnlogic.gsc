/*************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\spawnlogic.gsc
*************************************/

init() {
  level.spawnglobals = spawnStruct();
  if(scripts\mp\utility::isanymlgmatch()) {
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
  for(var_00 = 0; var_00 < level.teamnamelist.size; var_00++) {
    level.teamspawnpoints[level.teamnamelist[var_00]] = [];
    level.teamfallbackspawnpoints[level.teamnamelist[var_00]] = [];
  }

  scripts\mp\spawnfactor::func_9758();
  func_AEAE();
}

func_11ADD() {
  self waittill("host_migration_end");
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    func_FAD6(var_00);
  }
}

func_FAD6(param_00) {
  if(isDefined(level.var_C7B3)) {
    foreach(var_02 in level.var_C7B3) {
      param_00 thread func_139B5(var_02);
    }
  }
}

func_139B5(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(var_01 != self) {
      continue;
    }

    if(!scripts\mp\utility::isreallyalive(var_01)) {
      continue;
    }

    if(scripts\mp\utility::func_9FAE(var_01)) {
      continue;
    }

    if(scripts\mp\utility::istouchingboundsnullify(var_01)) {
      continue;
    }

    var_01 thread func_13B84(param_00);
  }
}

func_13B84(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  if(!isDefined(self.lastboundstimelimit)) {
    self.lastboundstimelimit = scripts\mp\utility::func_7F9B();
  }

  var_01 = gettime() + int(self.lastboundstimelimit * 1000);
  self.var_1D44 = 1;
  self setclientomnvar("ui_out_of_bounds_countdown", var_01);
  self _meth_859E("mp_out_of_bounds");
  var_02 = 0;
  var_03 = self.lastboundstimelimit;
  while(self istouching(param_00)) {
    if(!scripts\mp\utility::isreallyalive(self) || scripts\mp\utility::istrue(level.gameended)) {
      break;
    }

    if(var_03 <= 0) {
      var_02 = 1;
      break;
    }

    scripts\engine\utility::waitframe();
    var_03 = var_03 - 0.05;
  }

  self setclientomnvar("ui_out_of_bounds_countdown", 0);
  self _meth_859E("");
  self.var_1D44 = undefined;
  if(scripts\mp\utility::istrue(var_02)) {
    self.lastboundstimelimit = undefined;
    scripts\mp\utility::_suicide();
  } else {
    self.lastboundstimelimit = var_03;
    thread watchtimelimitcooldown();
  }

  if(scripts\mp\utility::isreallyalive(self) && scripts\mp\utility::istrue(level.nukedetonated) && !scripts\mp\utility::istrue(level.var_C1B2)) {
    thread scripts\mp\killstreaks\_nuke::func_FB0F(0.05);
  }
}

watchtimelimitcooldown() {
  self endon("disconnect");
  self notify("start_time_limit_cooldown");
  self endon("start_time_limit_cooldown");
  var_00 = scripts\mp\utility::getmaxoutofboundscooldown();
  while(var_00 > 0) {
    scripts\engine\utility::waitframe();
    var_00 = var_00 - 0.05;
  }

  self.lastboundstimelimit = undefined;
}

setactivespawnlogic(param_00) {
  var_01 = [param_00];
  var_02 = [0];
  foreach(var_04 in level.spawnglobals.var_AFBF) {
    var_05 = strtok(var_04, "_");
    if(var_05.size == 3 && var_05[0] == param_00 && var_05[1] == "v") {
      var_01[var_01.size] = var_04;
      var_02[var_02.size] = int(var_05[2]);
    }
  }

  var_07 = randomint(var_01.size);
  param_00 = var_01[var_07];
  level.spawnglobals.logicvariantid = var_02[var_07];
  level.spawnglobals.var_1677 = param_00;
}

func_AEAE() {
  level.spawnglobals.var_10882 = [];
  level.spawnglobals.var_AFBF = [];
  var_00 = -1;
  for(;;) {
    var_00++;
    var_01 = tablelookupbyrow("mp\spawnweights.csv", var_00, 0);
    if(!isDefined(var_01) || var_01 == "") {
      break;
    }

    if(!isDefined(level.spawnglobals.var_10882[var_01])) {
      level.spawnglobals.var_10882[var_01] = [];
      level.spawnglobals.var_AFBF[level.spawnglobals.var_AFBF.size] = var_01;
    }

    var_02 = tablelookupbyrow("mp\spawnweights.csv", var_00, 1);
    var_03 = tablelookupbyrow("mp\spawnweights.csv", var_00, 2);
    var_03 = float(var_03);
    level.spawnglobals.var_10882[var_01][var_02] = var_03;
  }
}

func_EC46(param_00, param_01) {
  foreach(var_04, var_03 in level.spawnglobals.var_10882[level.spawnglobals.var_1677]) {
    scripts\mp\spawnfactor::calculatefactorscore(param_00, var_04, var_03, param_01);
  }
}

addstartspawnpoints(param_00, param_01) {
  var_02 = getspawnpointarray(param_00);
  var_03 = [];
  if(isDefined(level.modifiedspawnpoints)) {
    for(var_04 = 0; var_04 < var_02.size; var_04++) {
      if(checkmodifiedspawnpoint(var_02[var_04])) {
        continue;
      }

      var_03[var_03.size] = var_02[var_04];
    }
  } else {
    var_03 = var_02;
  }

  if(!var_03.size) {
    if(!scripts\mp\utility::istrue(param_01)) {}

    return;
  }

  if(!isDefined(level.var_10DF1)) {
    level.var_10DF1 = [];
  }

  for(var_04 = 0; var_04 < var_03.size; var_04++) {
    var_03[var_04] func_108FA();
    var_03[var_04].selected = 0;
    var_03[var_04].infront = 0;
    level.var_10DF1[level.var_10DF1.size] = var_03[var_04];
  }

  if(level.teambased) {
    foreach(var_06 in var_03) {
      var_06.infront = 1;
      var_07 = anglesToForward(var_06.angles);
      foreach(var_09 in var_03) {
        if(var_06 == var_09) {
          continue;
        }

        var_0A = vectornormalize(var_09.origin - var_06.origin);
        var_0B = vectordot(var_07, var_0A);
        if(var_0B > 0.86) {
          var_06.infront = 0;
          break;
        }
      }
    }
  }
}

addspawnpoints(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  var_04 = getspawnpointarray(param_01);
  if(!var_04.size) {
    return;
  }

  registerspawnpoints(param_00, var_04, param_03);
}

registerspawnpoints(param_00, param_01, param_02) {
  if(!isDefined(level.spawnpoints)) {
    level.spawnpoints = [];
  }

  if(!isDefined(level.teamspawnpoints[param_00])) {
    level.teamspawnpoints[param_00] = [];
  }

  if(!isDefined(level.teamfallbackspawnpoints[param_00])) {
    level.teamfallbackspawnpoints[param_00] = [];
  }

  foreach(var_04 in param_01) {
    if(checkmodifiedspawnpoint(var_04)) {
      continue;
    }

    if(!isDefined(var_04.var_9800)) {
      var_04 func_108FA();
      level.spawnpoints[level.spawnpoints.size] = var_04;
    }

    if(scripts\mp\utility::istrue(param_02)) {
      level.teamfallbackspawnpoints[param_00][level.teamfallbackspawnpoints[param_00].size] = var_04;
      var_04.var_9DF0 = 1;
      continue;
    }

    level.teamspawnpoints[param_00][level.teamspawnpoints[param_00].size] = var_04;
  }
}

func_108FA() {
  var_00 = self;
  level.spawnmins = expandmins(level.spawnmins, var_00.origin);
  level.spawnmaxs = expandmaxs(level.spawnmaxs, var_00.origin);
  var_00.missionfailed = anglesToForward(var_00.angles);
  var_00.var_101E9 = var_00.origin + (0, 0, 50);
  var_00.lastspawntime = gettime();
  var_00.var_C7DA = 1;
  var_00.var_9800 = 1;
  var_00.alternates = [];
  var_00.var_A9E9 = [];
  var_01 = 1024;
  if(!bullettracepassed(var_00.var_101E9, var_00.var_101E9 + (0, 0, var_01), 0, undefined)) {
    var_02 = var_00.var_101E9 + var_00.missionfailed * 100;
    if(!bullettracepassed(var_02, var_02 + (0, 0, var_01), 0, undefined)) {
      var_00.var_C7DA = 0;
    }
  }

  var_03 = anglestoright(var_00.angles);
  var_04 = 1;
  if(scripts\mp\utility::istrue(var_00.noalternates)) {
    var_04 = 0;
  }

  if(var_04) {
    func_17A7(var_00, var_00.origin + var_03 * 45);
    func_17A7(var_00, var_00.origin - var_03 * 45);
  }

  if(shoulduseprecomputedlos() || getdvarint("sv_generateLOSData", 0) == 1) {
    var_00.radiuspathnodes = getradiuspathsighttestnodes(var_00.origin);
    if(var_00.radiuspathnodes.size <= 0) {}
  }

  initspawnpointvalues(var_00);
}

func_17A7(param_00, param_01) {
  var_02 = playerphysicstrace(param_00.origin, param_00.origin + (0, 0, 18));
  var_03 = var_02[2] - param_00.origin[2];
  var_04 = (param_01[0], param_01[1], param_01[2] + var_03);
  var_05 = playerphysicstrace(var_02, var_04);
  if(var_05 != var_04) {
    return;
  }

  var_06 = playerphysicstrace(var_04, param_01);
  param_00.alternates[param_00.alternates.size] = var_06;
}

getspawnpointarray(param_00) {
  if(!isDefined(level.var_108F8)) {
    level.var_108F8 = [];
  }

  if(!isDefined(level.var_108F8[param_00])) {
    level.var_108F8[param_00] = [];
    level.var_108F8[param_00] = getspawnarray(param_00);
    foreach(var_02 in level.var_108F8[param_00]) {
      var_02.classname = param_00;
    }
  }

  return level.var_108F8[param_00];
}

getspawnpoint_random(param_00) {
  if(!isDefined(param_00)) {
    return undefined;
  }

  var_01 = undefined;
  param_00 = scripts\mp\spawnscoring::checkdynamicspawns(param_00);
  param_00 = scripts\engine\utility::array_randomize(param_00);
  foreach(var_03 in param_00) {
    var_01 = var_03;
    if(canspawn(var_01.origin) && !positionwouldtelefrag(var_01.origin)) {
      break;
    }
  }

  return var_01;
}

getspawnpoint_startspawn(param_00, param_01) {
  if(!isDefined(param_00)) {
    return undefined;
  }

  var_02 = undefined;
  param_00 = scripts\mp\spawnscoring::checkdynamicspawns(param_00);
  foreach(var_04 in param_00) {
    if(!isDefined(var_04.selected)) {
      continue;
    }

    if(var_04.selected) {
      continue;
    }

    if(var_04.infront) {
      var_02 = var_04;
      break;
    }

    var_02 = var_04;
  }

  if(!isDefined(var_02)) {
    if(scripts\mp\utility::istrue(param_01)) {
      return undefined;
    }

    var_02 = getspawnpoint_random(param_00);
  }

  if(isDefined(var_02)) {
    var_02.selected = 1;
  }

  return var_02;
}

trackgrenades() {
  for(;;) {
    level.grenades = getEntArray("grenade", "classname");
    wait(0.05);
  }
}

trackmissiles() {
  for(;;) {
    level.missiles = getEntArray("rocket", "classname");
    wait(0.05);
  }
}

trackcarepackages() {
  for(;;) {
    level.carepackages = getEntArray("care_package", "targetname");
    wait(0.05);
  }
}

getteamspawnpoints(param_00) {
  return level.teamspawnpoints[param_00];
}

getteamfallbackspawnpoints(param_00) {
  return level.teamfallbackspawnpoints[param_00];
}

ispathdataavailable() {
  if(!isDefined(level.var_C96A)) {
    var_00 = getallnodes();
    level.var_C96A = isDefined(var_00) && var_00.size > 150;
  }

  return level.var_C96A;
}

addtoparticipantsarray() {
  level.participants[level.participants.size] = self;
}

removefromparticipantsarray() {
  var_00 = 0;
  for(var_01 = 0; var_01 < level.participants.size; var_01++) {
    if(level.participants[var_01] == self) {
      var_00 = 1;
      while(var_01 < level.participants.size - 1) {
        level.participants[var_01] = level.participants[var_01 + 1];
        var_01++;
      }

      level.participants[var_01] = undefined;
      break;
    }
  }
}

addtocharactersarray() {
  level.characters[level.characters.size] = self;
}

removefromcharactersarray() {
  var_00 = 0;
  for(var_01 = 0; var_01 < level.characters.size; var_01++) {
    if(level.characters[var_01] == self) {
      var_00 = 1;
      while(var_01 < level.characters.size - 1) {
        level.characters[var_01] = level.characters[var_01 + 1];
        var_01++;
      }

      level.characters[var_01] = undefined;
      break;
    }
  }
}

func_108FE() {
  while(!isDefined(level.spawnpoints) || level.spawnpoints.size == 0) {
    wait(0.05);
  }

  level thread func_108FC();
  if(shoulduseprecomputedlos() || getdvarint("sv_generateLOSData", 0) == 1) {
    var_00 = [];
    if(level.spawnpoints.size == 0) {
      scripts\engine\utility::error("Spawn System Failure. No Spawnpoints found.");
    }

    for(var_01 = 0; var_01 < level.spawnpoints.size; var_01++) {
      for(var_02 = 0; var_02 < level.spawnpoints[var_01].radiuspathnodes.size; var_02++) {
        var_00[var_00.size] = level.spawnpoints[var_01].radiuspathnodes[var_02];
      }
    }

    if(var_00.size > 0) {
      cachespawnpathnodesincode(var_00);
    } else {
      scripts\engine\utility::error("Spawn System Failure. There are no pathnodes near any spawnpoints.");
    }
  }

  for(;;) {
    level.disablebutton = getdvarint("scr_disableClientSpawnTraces") > 0;
    wait(0.05);
  }
}

getactiveplayerlist() {
  var_00 = [];
  foreach(var_02 in level.characters) {
    if(!scripts\mp\utility::isreallyalive(var_02)) {
      continue;
    }

    if(isplayer(var_02) && var_02.sessionstate != "playing") {
      continue;
    }

    if(var_02 scripts\mp\killstreaks\_killstreaks::isusinggunship() && isDefined(var_02.chopper) && !isDefined(var_02.chopper.var_BCB4) || !var_02.chopper.var_BCB4) {
      continue;
    }

    if(var_02 scripts\mp\killstreaks\_killstreaks::func_9FC4()) {
      continue;
    }

    var_02.var_108DF = getspawnteam(var_02);
    if(var_02.var_108DF == "spectator") {
      continue;
    }

    if(isagent(var_02) && var_02.agent_type == "seeker") {
      continue;
    }

    var_03 = getplayertraceheight(var_02);
    var_04 = var_02 getEye();
    var_04 = (var_04[0], var_04[1], var_02.origin[2] + var_03);
    var_02.var_108E0 = var_03;
    var_02.var_10917 = var_04;
    var_00[var_00.size] = var_02;
  }

  return var_00;
}

func_12F1F() {
  level.var_1091D = getactiveplayerlist();
  foreach(var_01 in level.var_1091D) {
    var_01.spawnviewpathnodes = undefined;
  }

  foreach(var_04 in level.turrets) {
    if(!isDefined(var_04)) {
      continue;
    }

    var_04.var_108DF = getspawnteam(var_04);
    level.var_1091D[level.var_1091D.size] = var_04;
    var_04.spawnviewpathnodes = undefined;
  }

  foreach(var_07 in level.ugvs) {
    if(!isDefined(var_07)) {
      continue;
    }

    var_07.var_108DF = getspawnteam(var_07);
    level.var_1091D[level.var_1091D.size] = var_07;
    var_07.spawnviewpathnodes = undefined;
  }

  foreach(var_0A in level.var_105EA) {
    if(!isDefined(var_0A)) {
      continue;
    }

    var_0A.var_108DF = getspawnteam(var_0A);
    level.var_1091D[level.var_1091D.size] = var_0A;
    var_0A.spawnviewpathnodes = undefined;
  }

  foreach(var_0D in level.balldrones) {
    if(!isDefined(var_0D)) {
      continue;
    }

    var_0D.var_108DF = getspawnteam(var_0D);
    level.var_1091D[level.var_1091D.size] = var_0D;
    var_0D.spawnviewpathnodes = undefined;
  }
}

func_108FC() {
  if(shoulduseprecomputedlos()) {
    level waittill("spawn_restart_trace_system");
  }

  var_00 = 18;
  var_01 = 0;
  var_02 = 0;
  var_03 = getactiveplayerlist();
  for(;;) {
    if(var_02) {
      wait(0.05);
      var_01 = 0;
      var_02 = 0;
      var_03 = getactiveplayerlist();
    }

    var_04 = level.spawnpoints;
    var_04 = scripts\mp\spawnscoring::checkdynamicspawns(var_04);
    var_02 = 1;
    foreach(var_06 in var_04) {
      clearspawnpointsightdata(var_06);
      foreach(var_08 in var_03) {
        if(var_06.var_74BC[var_08.var_108DF]) {
          continue;
        }

        var_09 = spawnsighttrace(var_06, var_06.var_101E9, var_08.var_10917);
        var_01++;
        if(!var_09) {
          continue;
        }

        if(var_09 > 0.95) {
          var_06.var_74BC[var_08.var_108DF]++;
          var_06.var_AFD9[var_08.var_108DF]++;
          continue;
        }

        var_06.var_466B[var_08.var_108DF]++;
      }

      func_17DC(var_06, level.turrets);
      func_17DC(var_06, level.ugvs);
      func_17DC(var_06, level.var_105EA);
      func_17DC(var_06, level.balldrones);
      func_AFDA(var_06);
      if(var_00 < var_01) {
        wait(0.05);
        var_01 = 0;
        var_02 = 0;
        var_03 = getactiveplayerlist();
      }
    }
  }
}

func_AFDA(param_00) {
  if(scripts\mp\utility::istrue(param_00.budgetedents) || scripts\mp\utility::istrue(param_00.isdynamicspawn)) {
    return;
  }

  if(isDefined(level.matchrecording_logevent)) {
    if(isDefined(level.matchrecording_generateid) && !isDefined(param_00.logid)) {
      param_00.logid = [
        [level.matchrecording_generateid]
      ]();
    }

    if(isDefined(param_00.logid)) {
      var_01 = 3;
      if(level.teambased) {
        var_02 = param_00.var_AFD9["allies"] == 0;
        var_03 = param_00.var_AFD9["axis"] == 0;
        if(var_02 && var_03) {
          var_01 = 0;
        } else if(var_02) {
          var_01 = 1;
        } else if(var_03) {
          var_01 = 2;
        }
      } else {
        var_01 = scripts\engine\utility::ter_op(param_00.var_74BC["all"] == 0, 0, 3);
      }

      if(!isDefined(param_00.var_AFBB) || param_00.var_AFBB != var_01) {
        [[level.matchrecording_logevent]](param_00.logid, "allies", "SPAWN_ENTITY", param_00.origin[0], param_00.origin[1], gettime(), var_01);
        param_00.var_AFBB = var_01;
        return;
      }
    }
  }
}

func_108F9(param_00, param_01) {
  clearspawnpointdistancedata(param_00);
  foreach(var_03 in param_01) {
    var_04 = distancesquared(var_03.origin, param_00.origin);
    if(var_04 < param_00.mindistsquared[var_03.var_108DF]) {
      param_00.mindistsquared[var_03.var_108DF] = var_04;
    }

    if(var_03.var_108DF == "spectator") {
      continue;
    }

    param_00.distsumsquared[var_03.var_108DF] = param_00.distsumsquared[var_03.var_108DF] + var_04;
    param_00.distsumsquaredcapped[var_03.var_108DF] = param_00.distsumsquaredcapped[var_03.var_108DF] + min(var_04, scripts\mp\spawnfactor::maxplayerspawninfluencedistsquared());
    param_00.totalplayers[var_03.var_108DF]++;
    param_00.var_5721[var_03.var_108DF][var_03 getentitynumber()] = var_04;
  }
}

getspawnteam(param_00) {
  var_01 = "all";
  if(level.teambased) {
    var_01 = param_00.team;
  }

  return var_01;
}

initspawnpointvalues(param_00) {
  clearspawnpointsightdata(param_00);
  clearspawnpointdistancedata(param_00);
}

clearspawnpointsightdata(param_00) {
  if(level.teambased) {
    foreach(var_02 in level.teamnamelist) {
      func_41E6(param_00, var_02);
    }

    return;
  }

  func_41E6(param_00, "all");
}

func_FADD(param_00) {}

clearspawnpointdistancedata(param_00) {
  if(level.teambased) {
    foreach(var_02 in level.teamnamelist) {
      func_41E5(param_00, var_02);
    }

    return;
  }

  func_41E5(param_00, "all");
}

func_41E6(param_00, param_01) {
  param_00.var_74BC[param_01] = 0;
  param_00.var_466B[param_01] = 0;
  param_00.var_AFD9[param_01] = 0;
  param_00.var_B4C4[param_01] = 0;
  param_00.var_B4A6[param_01] = 0;
}

func_41E5(param_00, param_01) {
  param_00.distsumsquared[param_01] = 0;
  param_00.distsumsquaredcapped[param_01] = 0;
  param_00.mindistsquared[param_01] = 9999999;
  param_00.totalplayers[param_01] = 0;
  param_00.var_5721[param_01] = [];
}

getplayertraceheight(param_00, param_01) {
  if(isDefined(param_01) && param_01) {
    return 64;
  }

  var_02 = param_00 getstance();
  if(var_02 == "stand") {
    return 64;
  }

  if(var_02 == "crouch") {
    return 44;
  }

  return 32;
}

func_17DC(param_00, param_01) {
  foreach(var_03 in param_01) {
    if(!isDefined(var_03)) {
      continue;
    }

    var_04 = getspawnteam(var_03);
    if(param_00.var_74BC[var_04]) {
      continue;
    }

    var_05 = var_03.origin + (0, 0, 50);
    var_06 = 0;
    if(!var_06) {
      var_06 = spawnsighttrace(param_00, param_00.var_101E9, var_05);
    }

    if(!var_06) {
      continue;
    }

    if(var_06 > 0.95) {
      param_00.var_74BC[var_04]++;
      continue;
    }

    param_00.var_466B[var_04]++;
  }
}

finalizespawnpointchoice(param_00) {
  if(!isplayer(self)) {
    return;
  }

  var_01 = gettime();
  self.lastspawnpoint = param_00;
  self.lastspawntime = var_01;
  param_00.lastspawntime = var_01;
  param_00.lastspawnteam = self.team;
  level.spawnglobals.lastteamspawnpoints[self.team] = param_00;
}

expandspawnpointbounds(param_00) {
  var_01 = getspawnpointarray(param_00);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    level.spawnmins = expandmins(level.spawnmins, var_01[var_02].origin);
    level.spawnmaxs = expandmaxs(level.spawnmaxs, var_01[var_02].origin);
  }
}

expandmins(param_00, param_01) {
  if(param_00[0] > param_01[0]) {
    param_00 = (param_01[0], param_00[1], param_00[2]);
  }

  if(param_00[1] > param_01[1]) {
    param_00 = (param_00[0], param_01[1], param_00[2]);
  }

  if(param_00[2] > param_01[2]) {
    param_00 = (param_00[0], param_00[1], param_01[2]);
  }

  return param_00;
}

expandmaxs(param_00, param_01) {
  if(param_00[0] < param_01[0]) {
    param_00 = (param_01[0], param_00[1], param_00[2]);
  }

  if(param_00[1] < param_01[1]) {
    param_00 = (param_00[0], param_01[1], param_00[2]);
  }

  if(param_00[2] < param_01[2]) {
    param_00 = (param_00[0], param_00[1], param_01[2]);
  }

  return param_00;
}

findboxcenter(param_00, param_01) {
  var_02 = (0, 0, 0);
  var_02 = param_01 - param_00;
  var_02 = (var_02[0] / 2, var_02[1] / 2, var_02[2] / 2) + param_00;
  return var_02;
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

  if(scripts\mp\utility::istrue(level.var_5614)) {
    return 0;
  }

  return level.ingraceperiod && !isDefined(level.numkills) || level.numkills == 0;
}

getpathsighttestnodes(param_00, param_01) {
  if(param_01) {
    var_02 = 0;
    var_03 = getclosenoderadiusdist();
  } else {
    var_02 = getclosenoderadiusdist();
    var_03 = 250;
  }

  return getnodesinradius(param_00, var_03, var_02, 512, "path");
}

getradiuspathsighttestnodes(param_00) {
  var_01 = [];
  var_02 = getclosestnodeinsight(param_00);
  if(isDefined(var_02)) {
    var_01[0] = var_02;
  }

  if(!isDefined(var_02)) {
    var_01 = getnodesinradius(param_00, getclosenoderadiusdist(), 0, 256, "path");
    if(var_01.size == 0) {
      var_01 = getnodesinradius(param_00, 250, 0, 256, "path");
    }
  }

  return var_01;
}

func_67D3(param_00, param_01) {
  if(!shoulduseprecomputedlos()) {
    return;
  }

  var_02 = "all";
  if(level.teambased) {
    var_02 = scripts\mp\gameobjects::getenemyteam(param_01);
  }

  func_41E6(param_00, var_02);
  var_03 = 0.95;
  var_04 = 0;
  var_05 = undefined;
  var_06 = undefined;
  var_07 = isttlosdataavailable();
  var_03 = level.spawnglobals.lowerlimitfullsights;
  var_04 = level.spawnglobals.lowerlimitcornersights;
  foreach(var_09 in level.var_1091D) {
    if(level.teambased && var_09.var_108DF != var_02) {
      continue;
    }

    if(param_00.var_74BC[var_09.var_108DF]) {
      break;
    }

    if(!isDefined(var_09.spawnviewpathnodes)) {
      var_09.spawnviewpathnodes = var_09 _meth_8480(getfarnoderadiusdist());
      if(!isDefined(var_09.spawnviewpathnodes) || var_09.spawnviewpathnodes.size == 0) {
        if(isDefined(level.matchrecording_logeventmsg) && var_07 && isplayer(var_09)) {
          if(!isDefined(var_09.var_A9CC) || var_09.var_A9CC != gettime()) {
            [
              [level.matchrecording_logeventmsg]
            ]("LOG_GENERIC_MESSAGE", gettime(), "WARNING: Could not use TTLOS data for player " + var_09.name);
            var_09.var_A9CC = gettime();
          }
        }
      }
    }

    if(var_07 && isDefined(var_09.spawnviewpathnodes) && var_09.spawnviewpathnodes.size > 0) {
      var_0A = _precomputedlosdatatest(var_09, param_00);
      var_05 = var_0A[0];
      var_06 = var_0A[1];
    }

    if(!isDefined(var_05)) {
      var_0B = undefined;
      if(isplayer(var_09)) {
        var_0B = var_09 getEye();
      } else {
        var_0B = var_09.origin + (0, 0, 50);
      }

      var_05 = func_54EC(param_00, var_09, var_0B);
      var_06 = var_05;
    }

    if(!isDefined(param_00.var_B4C4[var_09.var_108DF]) || var_05 > param_00.var_B4C4[var_09.var_108DF]) {
      param_00.var_B4C4[var_09.var_108DF] = var_05;
    }

    if(isDefined(var_06) && isplayer(var_09)) {
      if(!isDefined(param_00.var_B4A6[var_09.var_108DF]) || var_05 > param_00.var_B4A6[var_09.var_108DF]) {
        param_00.var_B4A6[var_09.var_108DF] = var_06;
      }
    }

    if(var_05 > var_03) {
      param_00.var_74BC[var_09.var_108DF]++;
      param_00.var_AFD9[var_09.var_108DF]++;
      continue;
    }

    if(var_05 > var_04) {
      param_00.var_466B[var_09.var_108DF]++;
    }
  }

  func_AFDA(param_00);
}

_precomputedlosdatatest(param_00, param_01) {
  var_02 = checkttlosoverrides(param_00, param_01);
  if(!isDefined(var_02)) {
    var_02 = precomputedlosdatatest(param_00.spawnviewpathnodes, param_01.radiuspathnodes);
  }

  return var_02;
}

checkttlosoverrides(param_00, param_01) {
  if(!isDefined(level.spawnglobals.ttlosoverrides)) {
    return;
  }

  foreach(var_03 in param_00.spawnviewpathnodes) {
    var_04 = var_03 getnodenumber();
    if(isDefined(level.spawnglobals.ttlosoverrides[var_04])) {
      foreach(var_06 in param_01.radiuspathnodes) {
        var_07 = var_06 getnodenumber();
        if(isDefined(level.spawnglobals.ttlosoverrides[var_04][var_07])) {
          return level.spawnglobals.ttlosoverrides[var_04][var_07];
        }
      }
    }
  }
}

addttlosoverride(param_00, param_01, param_02, param_03) {
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

  if(!isDefined(level.spawnglobals.ttlosoverrides[param_00])) {
    level.spawnglobals.ttlosoverrides[param_00] = [];
  }

  level.spawnglobals.ttlosoverrides[param_00][param_01] = [param_02, param_03];
  if(!isDefined(level.spawnglobals.ttlosoverrides[param_01])) {
    level.spawnglobals.ttlosoverrides[param_01] = [];
  }

  level.spawnglobals.ttlosoverrides[param_01][param_00] = [param_02, param_03];
}

getclosenoderadiusdist() {
  return 130;
}

getfarnoderadiusdist() {
  return 250;
}

func_54EC(param_00, param_01, param_02) {
  var_03 = param_00.var_101E9;
  var_04 = param_02;
  var_05 = physics_createcontents(["physicscontents_aiavoid", "physicscontents_solid", "physicscontents_structural"]);
  var_06 = physics_raycast(var_03, var_04, var_05, param_01, 0, "physicsquery_any");
  return scripts\engine\utility::ter_op(var_06, 0, 1);
}

getmaxdistancetolos() {
  return 2550;
}

shoulduseprecomputedlos() {
  return getdvarint("sv_usePrecomputedLOSData", 0) == 1 && !isDefined(level.var_560C) && getdvarint("sv_generateLOSData", 0) != 1;
}

isttlosdataavailable() {
  return getislosdatafileloaded();
}

func_D91D() {
  level waittill("prematch_done");
  if(getdvarint("scr_playtest", 0) == 1 && isDefined(level.players)) {
    foreach(var_01 in level.players) {
      if(var_01 ishost()) {
        if(shoulduseprecomputedlos()) {
          var_01 iprintlnbold("Attempting to use NEW Spawn System...");
        } else {
          var_01 iprintlnbold("Using OLD Spawn System...");
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
      return;
    }

    [[level.matchrecording_logeventmsg]]("LOG_GENERIC_MESSAGE", gettime(), "Using Corner-Trace Spawning System...");
  }
}

func_E2B6() {
  level notify("spawn_restart_trace_system");
}

func_9DF1(param_00) {
  return scripts\mp\utility::istrue(param_00.var_9DF0);
}

logextraspawninfothink() {
  if(getdvarint("scr_extra_spawn_logging", 0) != 1) {
    return;
  }

  level waittill("prematch_done");
  var_00 = undefined;
  var_01 = undefined;
  if(isDefined(level.matchrecording_generateid)) {
    var_00 = [[level.matchrecording_generateid]]();
    var_01 = [[level.matchrecording_generateid]]();
  }

  for(;;) {
    if(!shoulduseprecomputedlos()) {
      break;
    }

    logextraspawn("allies", var_00);
    wait(0.5);
    logextraspawn("axis", var_01);
    wait(0.5);
  }
}

logextraspawn(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.team = param_00;
  var_02.pers = [];
  var_02.pers["team"] = param_00;
  var_02.disablespawnwarnings = 1;
  var_02.isdynamicspawn = 1;
  var_03 = var_02[[level.getspawnpoint]]();
  if(isDefined(level.matchrecording_logevent) && isDefined(var_03) && isDefined(param_01)) {
    var_04 = scripts\engine\utility::ter_op(param_00 == "allies", "BEST_SPAWN_ALLIES", "BEST_SPAWN_AXIS");
    [[level.matchrecording_logevent]](param_01, param_00, var_04, var_03.origin[0], var_03.origin[1], gettime());
  }
}

clearlastteamspawns() {
  level.spawnglobals.lastteamspawnpoints = [];
}

getoriginidentifierstring(param_00) {
  return int(param_00.origin[0]) + " " + int(param_00.origin[1]) + " " + int(param_00.origin[2]);
}

checkmodifiedspawnpoint(param_00) {
  if(!isDefined(level.modifiedspawnpoints)) {
    return 0;
  }

  var_01 = undefined;
  var_02 = getoriginidentifierstring(param_00);
  if(isDefined(level.modifiedspawnpoints[var_02])) {
    var_01 = level.modifiedspawnpoints[var_02][param_00.classname];
  }

  if(!isDefined(var_01)) {
    return 0;
  }

  if(scripts\mp\utility::istrue(var_01["remove"])) {
    return 1;
  }

  if(isDefined(var_01["origin"])) {
    param_00.origin = var_01["origin"];
  }

  if(isDefined(var_01["angles"])) {
    param_00.angles = var_01["angles"];
  }

  if(scripts\mp\utility::istrue(var_01["no_alternates"])) {
    param_00.noalternates = 1;
  }

  return 0;
}