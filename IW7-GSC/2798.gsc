/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2798.gsc
***************************************/

init() {
  level.spawnglobals = spawnStruct();

  if(scripts\mp\utility\game::isanymlgmatch())
    level.killstreakspawnshielddelayms = 0;
  else
    level.killstreakspawnshielddelayms = 4000;

  level.func_72A2 = 0;
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  level.disablebutton = 0;
  level.numplayerswaitingtospawn = 0;
  level.func_C23C = 0;
  level.players = [];
  level.participants = [];
  level.characters = [];
  level.func_108F8 = [];
  level.grenades = [];
  level.missiles = [];
  level.carepackages = [];
  level.helis = [];
  level.turrets = [];
  level.func_114E3 = [];
  level.func_EC9F = [];
  level.func_935F = [];
  level.ugvs = [];
  level.balldrones = [];
  level.func_105EA = [];
  level.func_D3CC = [];
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

  for(var_00 = 0; var_00 < level.teamnamelist.size; var_0++) {
    level.teamspawnpoints[level.teamnamelist[var_00]] = [];
    level.teamfallbackspawnpoints[level.teamnamelist[var_00]] = [];
  }

  scripts\mp\spawnfactor::func_9758();
  func_AEAE();
}

func_11ADD() {
  for(;;)
    self waittill("host_migration_end");
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    func_FAD6(var_00);
  }
}

func_FAD6(var_00) {
  if(isDefined(level.func_C7B3)) {
    foreach(var_02 in level.func_C7B3)
    var_00 thread func_139B5(var_02);
  }
}

func_139B5(var_00) {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var_00 waittill("trigger", var_01);

    if(var_01 != self) {
      continue;
    }
    if(!scripts\mp\utility\game::isreallyalive(var_01)) {
      continue;
    }
    if(scripts\mp\utility\game::func_9FAE(var_01)) {
      continue;
    }
    if(scripts\mp\utility\game::istouchingboundsnullify(var_01)) {
      continue;
    }
    var_01 thread func_13B84(var_00);
  }
}

func_13B84(var_00) {
  self endon("disconnect");
  level endon("game_ended");

  if(!isDefined(self.lastboundstimelimit))
    self.lastboundstimelimit = scripts\mp\utility\game::func_7F9B();

  var_01 = gettime() + int(self.lastboundstimelimit * 1000);
  self.func_1D44 = 1;
  self setclientomnvar("ui_out_of_bounds_countdown", var_01);
  self _meth_859E("mp_out_of_bounds");
  var_02 = 0;

  for(var_03 = self.lastboundstimelimit; self istouching(var_00); var_03 = var_03 - 0.05) {
    if(!scripts\mp\utility\game::isreallyalive(self) || scripts\mp\utility\game::istrue(level.gameended)) {
      break;
    }
    if(var_03 <= 0) {
      var_02 = 1;
      break;
    }

    scripts\engine\utility::waitframe();
  }

  self setclientomnvar("ui_out_of_bounds_countdown", 0);
  self _meth_859E("");
  self.func_1D44 = undefined;

  if(scripts\mp\utility\game::istrue(var_02)) {
    self.lastboundstimelimit = undefined;
    scripts\mp\utility\game::_suicide();
  } else {
    self.lastboundstimelimit = var_03;
    thread watchtimelimitcooldown();
  }

  if(scripts\mp\utility\game::isreallyalive(self) && scripts\mp\utility\game::istrue(level.nukedetonated) && !scripts\mp\utility\game::istrue(level.func_C1B2))
    thread scripts\mp\killstreaks\nuke::func_FB0F(0.05);
}

watchtimelimitcooldown() {
  self endon("disconnect");
  self notify("start_time_limit_cooldown");
  self endon("start_time_limit_cooldown");

  for(var_00 = scripts\mp\utility\game::getmaxoutofboundscooldown(); var_00 > 0; var_00 = var_00 - 0.05)
    scripts\engine\utility::waitframe();

  self.lastboundstimelimit = undefined;
}

setactivespawnlogic(var_00) {
  var_01 = [var_00];
  var_02 = [0];

  foreach(var_04 in level.spawnglobals.func_AFBF) {
    var_05 = strtok(var_04, "_");

    if(var_5.size == 3 && var_5[0] == var_00 && var_5[1] == "v") {
      var_1[var_1.size] = var_04;
      var_2[var_2.size] = int(var_5[2]);
    }
  }

  var_07 = randomint(var_1.size);
  var_00 = var_1[var_07];
  level.spawnglobals.logicvariantid = var_2[var_07];
  level.spawnglobals.func_1677 = var_00;
}

func_AEAE() {
  level.spawnglobals.func_10882 = [];
  level.spawnglobals.func_AFBF = [];
  var_00 = -1;

  for(;;) {
    var_0++;
    var_01 = tablelookupbyrow("mp\spawnweights.csv", var_00, 0);

    if(!isDefined(var_01) || var_01 == "") {
      break;
    }
    if(!isDefined(level.spawnglobals.func_10882[var_01])) {
      level.spawnglobals.func_10882[var_01] = [];
      level.spawnglobals.func_AFBF[level.spawnglobals.func_AFBF.size] = var_01;
    }

    var_02 = tablelookupbyrow("mp\spawnweights.csv", var_00, 1);
    var_03 = tablelookupbyrow("mp\spawnweights.csv", var_00, 2);
    var_03 = float(var_03);
    level.spawnglobals.func_10882[var_01][var_02] = var_03;
  }
}

func_EC46(var_00, var_01) {
  foreach(var_04, var_03 in level.spawnglobals.func_10882[level.spawnglobals.func_1677])
  scripts\mp\spawnfactor::calculatefactorscore(var_00, var_04, var_03, var_01);
}

addstartspawnpoints(var_00, var_01) {
  var_02 = getspawnpointarray(var_00);
  var_03 = [];

  if(isDefined(level.modifiedspawnpoints)) {
    for(var_04 = 0; var_04 < var_2.size; var_4++) {
      if(checkmodifiedspawnpoint(var_2[var_04])) {
        continue;
      }
      var_3[var_3.size] = var_2[var_04];
    }
  } else
    var_03 = var_02;

  if(!var_3.size) {
    if(!scripts\mp\utility\game::istrue(var_01)) {}

    return;
  }

  if(!isDefined(level.func_10DF1))
    level.func_10DF1 = [];

  for(var_04 = 0; var_04 < var_3.size; var_4++) {
    var_3[var_04] func_108FA();
    var_3[var_04].selected = 0;
    var_3[var_04].infront = 0;
    level.func_10DF1[level.func_10DF1.size] = var_3[var_04];
  }

  if(level.teambased) {
    foreach(var_06 in var_03) {
      var_6.infront = 1;
      var_07 = anglesToForward(var_6.angles);

      foreach(var_09 in var_03) {
        if(var_06 == var_09) {
          continue;
        }
        var_10 = vectornormalize(var_9.origin - var_6.origin);
        var_11 = vectordot(var_07, var_10);

        if(var_11 > 0.86) {
          var_6.infront = 0;
          break;
        }
      }
    }
  }
}

addspawnpoints(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_02))
    var_02 = 0;

  var_04 = getspawnpointarray(var_01);

  if(!var_4.size) {
    return;
  }
  registerspawnpoints(var_00, var_04, var_03);
}

registerspawnpoints(var_00, var_01, var_02) {
  if(!isDefined(level.spawnpoints))
    level.spawnpoints = [];

  if(!isDefined(level.teamspawnpoints[var_00]))
    level.teamspawnpoints[var_00] = [];

  if(!isDefined(level.teamfallbackspawnpoints[var_00]))
    level.teamfallbackspawnpoints[var_00] = [];

  foreach(var_04 in var_01) {
    if(checkmodifiedspawnpoint(var_04)) {
      continue;
    }
    if(!isDefined(var_4.func_9800)) {
      var_04 func_108FA();
      level.spawnpoints[level.spawnpoints.size] = var_04;
    }

    if(scripts\mp\utility\game::istrue(var_02)) {
      level.teamfallbackspawnpoints[var_00][level.teamfallbackspawnpoints[var_00].size] = var_04;
      var_4.func_9DF0 = 1;
      continue;
    }

    level.teamspawnpoints[var_00][level.teamspawnpoints[var_00].size] = var_04;
  }
}

func_108FA() {
  var_00 = self;
  level.spawnmins = expandmins(level.spawnmins, var_0.origin);
  level.spawnmaxs = expandmaxs(level.spawnmaxs, var_0.origin);
  var_0.forward = anglesToForward(var_0.angles);
  var_0.func_101E9 = var_0.origin + (0, 0, 50);
  var_0.lastspawntime = gettime();
  var_0.func_C7DA = 1;
  var_0.func_9800 = 1;
  var_0.alternates = [];
  var_0.func_A9E9 = [];
  var_01 = 1024;

  if(!bullettracepassed(var_0.func_101E9, var_0.func_101E9 + (0, 0, var_01), 0, undefined)) {
    var_02 = var_0.func_101E9 + var_0.forward * 100;

    if(!bullettracepassed(var_02, var_02 + (0, 0, var_01), 0, undefined))
      var_0.func_C7DA = 0;
  }

  var_03 = anglestoright(var_0.angles);
  var_04 = 1;

  if(scripts\mp\utility\game::istrue(var_0.noalternates))
    var_04 = 0;

  if(var_04) {
    func_17A7(var_00, var_0.origin + var_03 * 45);
    func_17A7(var_00, var_0.origin - var_03 * 45);
  }

  if(shoulduseprecomputedlos() || getdvarint("sv_generateLOSData", 0) == 1) {
    var_0.radiuspathnodes = getradiuspathsighttestnodes(var_0.origin);

    if(var_0.radiuspathnodes.size <= 0) {}
  }

  initspawnpointvalues(var_00);
}

func_17A7(var_00, var_01) {
  var_02 = playerphysicstrace(var_0.origin, var_0.origin + (0, 0, 18));
  var_03 = var_2[2] - var_0.origin[2];
  var_04 = (var_1[0], var_1[1], var_1[2] + var_03);
  var_05 = playerphysicstrace(var_02, var_04);

  if(var_05 != var_04) {
    return;
  }
  var_06 = playerphysicstrace(var_04, var_01);
  var_0.alternates[var_0.alternates.size] = var_06;
}

getspawnpointarray(var_00) {
  if(!isDefined(level.func_108F8))
    level.func_108F8 = [];

  if(!isDefined(level.func_108F8[var_00])) {
    level.func_108F8[var_00] = [];
    level.func_108F8[var_00] = getspawnarray(var_00);

    foreach(var_02 in level.func_108F8[var_00])
    var_2.classname = var_00;
  }

  return level.func_108F8[var_00];
}

getspawnpoint_random(var_00) {
  if(!isDefined(var_00))
    return undefined;

  var_01 = undefined;
  var_00 = scripts\mp\spawnscoring::checkdynamicspawns(var_00);
  var_00 = scripts\engine\utility::array_randomize(var_00);

  foreach(var_03 in var_00) {
    var_01 = var_03;

    if(canspawn(var_1.origin) && !positionwouldtelefrag(var_1.origin)) {
      break;
    }
  }

  return var_01;
}

getspawnpoint_startspawn(var_00, var_01) {
  if(!isDefined(var_00))
    return undefined;

  var_02 = undefined;
  var_00 = scripts\mp\spawnscoring::checkdynamicspawns(var_00);

  foreach(var_04 in var_00) {
    if(!isDefined(var_4.selected)) {
      continue;
    }
    if(var_4.selected) {
      continue;
    }
    if(var_4.infront) {
      var_02 = var_04;
      break;
    }

    var_02 = var_04;
  }

  if(!isDefined(var_02)) {
    if(scripts\mp\utility\game::istrue(var_01))
      return undefined;

    var_02 = getspawnpoint_random(var_00);
  }

  if(isDefined(var_02))
    var_2.selected = 1;

  return var_02;
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

getteamspawnpoints(var_00) {
  return level.teamspawnpoints[var_00];
}

getteamfallbackspawnpoints(var_00) {
  return level.teamfallbackspawnpoints[var_00];
}

ispathdataavailable() {
  if(!isDefined(level.func_C96A)) {
    var_00 = getallnodes();
    level.func_C96A = isDefined(var_00) && var_0.size > 150;
  }

  return level.func_C96A;
}

addtoparticipantsarray() {
  level.participants[level.participants.size] = self;
}

removefromparticipantsarray() {
  var_00 = 0;

  for(var_01 = 0; var_01 < level.participants.size; var_1++) {
    if(level.participants[var_01] == self) {
      for(var_00 = 1; var_01 < level.participants.size - 1; var_1++)
        level.participants[var_01] = level.participants[var_01 + 1];

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

  for(var_01 = 0; var_01 < level.characters.size; var_1++) {
    if(level.characters[var_01] == self) {
      for(var_00 = 1; var_01 < level.characters.size - 1; var_1++)
        level.characters[var_01] = level.characters[var_01 + 1];

      level.characters[var_01] = undefined;
      break;
    }
  }
}

func_108FE() {
  while(!isDefined(level.spawnpoints) || level.spawnpoints.size == 0)
    wait 0.05;

  level thread func_108FC();

  if(shoulduseprecomputedlos() || getdvarint("sv_generateLOSData", 0) == 1) {
    var_00 = [];

    if(level.spawnpoints.size == 0)
      scripts\engine\utility::error("Spawn System Failure. No Spawnpoints found.");

    for(var_01 = 0; var_01 < level.spawnpoints.size; var_1++) {
      for(var_02 = 0; var_02 < level.spawnpoints[var_01].radiuspathnodes.size; var_2++)
        var_0[var_0.size] = level.spawnpoints[var_01].radiuspathnodes[var_02];
    }

    if(var_0.size > 0)
      cachespawnpathnodesincode(var_00);
    else
      scripts\engine\utility::error("Spawn System Failure. There are no pathnodes near any spawnpoints.");
  }

  for(;;) {
    level.disablebutton = getdvarint("scr_disableClientSpawnTraces") > 0;
    wait 0.05;
  }
}

getactiveplayerlist() {
  var_00 = [];

  foreach(var_02 in level.characters) {
    if(!scripts\mp\utility\game::isreallyalive(var_02)) {
      continue;
    }
    if(isplayer(var_02) && var_2.sessionstate != "playing") {
      continue;
    }
    if(var_02 scripts\mp\killstreaks\killstreaks::isusinggunship() && isDefined(var_2.chopper) && (!isDefined(var_2.chopper.func_BCB4) || !var_2.chopper.func_BCB4)) {
      continue;
    }
    if(var_02 scripts\mp\killstreaks\killstreaks::func_9FC4()) {
      continue;
    }
    var_2.func_108DF = getspawnteam(var_02);

    if(var_2.func_108DF == "spectator") {
      continue;
    }
    if(isagent(var_02) && var_2.agent_type == "seeker") {
      continue;
    }
    var_03 = getplayertraceheight(var_02);
    var_04 = var_02 getEye();
    var_04 = (var_4[0], var_4[1], var_2.origin[2] + var_03);
    var_2.func_108E0 = var_03;
    var_2.func_10917 = var_04;
    var_0[var_0.size] = var_02;
  }

  return var_00;
}

func_12F1F() {
  level.func_1091D = getactiveplayerlist();

  foreach(var_01 in level.func_1091D)
  var_1.spawnviewpathnodes = undefined;

  foreach(var_04 in level.turrets) {
    if(!isDefined(var_04)) {
      continue;
    }
    var_4.func_108DF = getspawnteam(var_04);
    level.func_1091D[level.func_1091D.size] = var_04;
    var_4.spawnviewpathnodes = undefined;
  }

  foreach(var_07 in level.ugvs) {
    if(!isDefined(var_07)) {
      continue;
    }
    var_7.func_108DF = getspawnteam(var_07);
    level.func_1091D[level.func_1091D.size] = var_07;
    var_7.spawnviewpathnodes = undefined;
  }

  foreach(var_10 in level.func_105EA) {
    if(!isDefined(var_10)) {
      continue;
    }
    var_10.func_108DF = getspawnteam(var_10);
    level.func_1091D[level.func_1091D.size] = var_10;
    var_10.spawnviewpathnodes = undefined;
  }

  foreach(var_13 in level.balldrones) {
    if(!isDefined(var_13)) {
      continue;
    }
    var_13.func_108DF = getspawnteam(var_13);
    level.func_1091D[level.func_1091D.size] = var_13;
    var_13.spawnviewpathnodes = undefined;
  }
}

func_108FC() {
  if(shoulduseprecomputedlos())
    level waittill("spawn_restart_trace_system");

  var_00 = 18;
  var_01 = 0;
  var_02 = 0;
  var_03 = getactiveplayerlist();

  for(;;) {
    if(var_02) {
      wait 0.05;
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
        if(var_6.func_74BC[var_8.func_108DF]) {
          continue;
        }
        var_09 = spawnsighttrace(var_06, var_6.func_101E9, var_8.func_10917);
        var_1++;

        if(!var_09) {
          continue;
        }
        if(var_09 > 0.95) {
          var_6.func_74BC[var_8.func_108DF]++;
          var_6.func_AFD9[var_8.func_108DF]++;
          continue;
        }

        var_6.func_466B[var_8.func_108DF]++;
      }

      func_17DC(var_06, level.turrets);
      func_17DC(var_06, level.ugvs);
      func_17DC(var_06, level.func_105EA);
      func_17DC(var_06, level.balldrones);
      func_AFDA(var_06);

      if(var_00 < var_01) {
        wait 0.05;
        var_01 = 0;
        var_02 = 0;
        var_03 = getactiveplayerlist();
      }
    }
  }
}

func_AFDA(var_00) {
  if(scripts\mp\utility\game::istrue(var_0.budgetedents) || scripts\mp\utility\game::istrue(var_0.isdynamicspawn)) {
    return;
  }
  if(isDefined(level.matchrecording_logevent)) {
    if(isDefined(level.matchrecording_generateid) && !isDefined(var_0.logid))
      var_0.logid = [
        [level.matchrecording_generateid]
      ]();

    if(isDefined(var_0.logid)) {
      var_01 = 3;

      if(level.teambased) {
        var_02 = var_0.func_AFD9["allies"] == 0;
        var_03 = var_0.func_AFD9["axis"] == 0;

        if(var_02 && var_03)
          var_01 = 0;
        else if(var_02)
          var_01 = 1;
        else if(var_03)
          var_01 = 2;
      } else
        var_01 = scripts\engine\utility::ter_op(var_0.func_74BC["all"] == 0, 0, 3);

      if(!isDefined(var_0.func_AFBB) || var_0.func_AFBB != var_01) {
        [
          [level.matchrecording_logevent]
        ](var_0.logid, "allies", "SPAWN_ENTITY", var_0.origin[0], var_0.origin[1], gettime(), var_01);
        var_0.func_AFBB = var_01;
      }
    }
  }
}

func_108F9(var_00, var_01) {
  clearspawnpointdistancedata(var_00);

  foreach(var_03 in var_01) {
    var_04 = distancesquared(var_3.origin, var_0.origin);

    if(var_04 < var_0.mindistsquared[var_3.func_108DF])
      var_0.mindistsquared[var_3.func_108DF] = var_04;

    if(var_3.func_108DF == "spectator") {
      continue;
    }
    var_0.distsumsquared[var_3.func_108DF] = var_0.distsumsquared[var_3.func_108DF] + var_04;
    var_0.distsumsquaredcapped[var_3.func_108DF] = var_0.distsumsquaredcapped[var_3.func_108DF] + min(var_04, scripts\mp\spawnfactor::maxplayerspawninfluencedistsquared());
    var_0.totalplayers[var_3.func_108DF]++;
    var_0.func_5721[var_3.func_108DF][var_03 getentitynumber()] = var_04;
  }
}

getspawnteam(var_00) {
  var_01 = "all";

  if(level.teambased)
    var_01 = var_0.team;

  return var_01;
}

initspawnpointvalues(var_00) {
  clearspawnpointsightdata(var_00);
  clearspawnpointdistancedata(var_00);
}

clearspawnpointsightdata(var_00) {
  if(level.teambased) {
    foreach(var_02 in level.teamnamelist)
    func_41E6(var_00, var_02);
  } else
    func_41E6(var_00, "all");
}

func_FADD(var_00) {}

clearspawnpointdistancedata(var_00) {
  if(level.teambased) {
    foreach(var_02 in level.teamnamelist)
    func_41E5(var_00, var_02);
  } else
    func_41E5(var_00, "all");
}

func_41E6(var_00, var_01) {
  var_0.func_74BC[var_01] = 0;
  var_0.func_466B[var_01] = 0;
  var_0.func_AFD9[var_01] = 0;
  var_0.func_B4C4[var_01] = 0.0;
  var_0.func_B4A6[var_01] = 0.0;
}

func_41E5(var_00, var_01) {
  var_0.distsumsquared[var_01] = 0;
  var_0.distsumsquaredcapped[var_01] = 0;
  var_0.mindistsquared[var_01] = 9999999;
  var_0.totalplayers[var_01] = 0;
  var_0.func_5721[var_01] = [];
}

getplayertraceheight(var_00, var_01) {
  if(isDefined(var_01) && var_01)
    return 64;

  var_02 = var_00 getstance();

  if(var_02 == "stand")
    return 64;

  if(var_02 == "crouch")
    return 44;

  return 32;
}

func_17DC(var_00, var_01) {
  foreach(var_03 in var_01) {
    if(!isDefined(var_03)) {
      continue;
    }
    var_04 = getspawnteam(var_03);

    if(var_0.func_74BC[var_04]) {
      continue;
    }
    var_05 = var_3.origin + (0, 0, 50);
    var_06 = 0.0;

    if(!var_06)
      var_06 = spawnsighttrace(var_00, var_0.func_101E9, var_05);

    if(!var_06) {
      continue;
    }
    if(var_06 > 0.95) {
      var_0.func_74BC[var_04]++;
      continue;
    }

    var_0.func_466B[var_04]++;
  }
}

finalizespawnpointchoice(var_00) {
  if(!isplayer(self)) {
    return;
  }
  var_01 = gettime();
  self.lastspawnpoint = var_00;
  self.lastspawntime = var_01;
  var_0.lastspawntime = var_01;
  var_0.lastspawnteam = self.team;
  level.spawnglobals.lastteamspawnpoints[self.team] = var_00;
}

expandspawnpointbounds(var_00) {
  var_01 = getspawnpointarray(var_00);

  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    level.spawnmins = expandmins(level.spawnmins, var_1[var_02].origin);
    level.spawnmaxs = expandmaxs(level.spawnmaxs, var_1[var_02].origin);
  }
}

expandmins(var_00, var_01) {
  if(var_0[0] > var_1[0])
    var_00 = (var_1[0], var_0[1], var_0[2]);

  if(var_0[1] > var_1[1])
    var_00 = (var_0[0], var_1[1], var_0[2]);

  if(var_0[2] > var_1[2])
    var_00 = (var_0[0], var_0[1], var_1[2]);

  return var_00;
}

expandmaxs(var_00, var_01) {
  if(var_0[0] < var_1[0])
    var_00 = (var_1[0], var_0[1], var_0[2]);

  if(var_0[1] < var_1[1])
    var_00 = (var_0[0], var_1[1], var_0[2]);

  if(var_0[2] < var_1[2])
    var_00 = (var_0[0], var_0[1], var_1[2]);

  return var_00;
}

findboxcenter(var_00, var_01) {
  var_02 = (0, 0, 0);
  var_02 = var_01 - var_00;
  var_02 = (var_2[0] / 2, var_2[1] / 2, var_2[2] / 2) + var_00;
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
  if(getdvarint("scr_forceStartSpawns", 0) == 1)
    return 1;

  if(scripts\mp\utility\game::istrue(level.func_5614))
    return 0;

  return level.ingraceperiod && (!isDefined(level.numkills) || level.numkills == 0);
}

getpathsighttestnodes(var_00, var_01) {
  if(var_01) {
    var_02 = 0;
    var_03 = getclosenoderadiusdist();
  } else {
    var_02 = getclosenoderadiusdist();
    var_03 = 250;
  }

  return getnodesinradius(var_00, var_03, var_02, 512, "path");
}

getradiuspathsighttestnodes(var_00) {
  var_01 = [];
  var_02 = getclosestnodeinsight(var_00);

  if(isDefined(var_02))
    var_1[0] = var_02;

  if(!isDefined(var_02)) {
    var_01 = getnodesinradius(var_00, getclosenoderadiusdist(), 0, 256, "path");

    if(var_1.size == 0)
      var_01 = getnodesinradius(var_00, 250, 0, 256, "path");
  }

  return var_01;
}

func_67D3(var_00, var_01) {
  if(!shoulduseprecomputedlos()) {
    return;
  }
  var_02 = "all";

  if(level.teambased)
    var_02 = scripts\mp\gameobjects::func_7E93(var_01);

  func_41E6(var_00, var_02);
  var_03 = 0.95;
  var_04 = 0;
  var_05 = undefined;
  var_06 = undefined;
  var_07 = isttlosdataavailable();
  var_03 = level.spawnglobals.lowerlimitfullsights;
  var_04 = level.spawnglobals.lowerlimitcornersights;

  foreach(var_09 in level.func_1091D) {
    if(level.teambased && var_9.func_108DF != var_02) {
      continue;
    }
    if(var_0.func_74BC[var_9.func_108DF]) {
      break;
    }
    if(!isDefined(var_9.spawnviewpathnodes)) {
      var_9.spawnviewpathnodes = var_09 _meth_8480(getfarnoderadiusdist());

      if(!isDefined(var_9.spawnviewpathnodes) || var_9.spawnviewpathnodes.size == 0) {
        if(isDefined(level.matchrecording_logeventmsg) && var_07 && isplayer(var_09)) {
          if(!isDefined(var_9.func_A9CC) || var_9.func_A9CC != gettime()) {
            [
              [level.matchrecording_logeventmsg]
            ]("LOG_GENERIC_MESSAGE", gettime(), "WARNING: Could not use TTLOS data for player " + var_9.name);
            var_9.func_A9CC = gettime();
          }
        }
      }
    }

    if(var_07 && isDefined(var_9.spawnviewpathnodes) && var_9.spawnviewpathnodes.size > 0) {
      var_10 = _precomputedlosdatatest(var_09, var_00);
      var_05 = var_10[0];
      var_06 = var_10[1];
    }

    if(!isDefined(var_05)) {
      var_11 = undefined;

      if(isplayer(var_09))
        var_11 = var_09 getEye();
      else
        var_11 = var_9.origin + (0, 0, 50);

      var_05 = func_54EC(var_00, var_09, var_11);
      var_06 = var_05;
    }

    if(!isDefined(var_0.func_B4C4[var_9.func_108DF]) || var_05 > var_0.func_B4C4[var_9.func_108DF])
      var_0.func_B4C4[var_9.func_108DF] = var_05;

    if(isDefined(var_06) && isplayer(var_09)) {
      if(!isDefined(var_0.func_B4A6[var_9.func_108DF]) || var_05 > var_0.func_B4A6[var_9.func_108DF])
        var_0.func_B4A6[var_9.func_108DF] = var_06;
    }

    if(var_05 > var_03) {
      var_0.func_74BC[var_9.func_108DF]++;
      var_0.func_AFD9[var_9.func_108DF]++;
      continue;
    }

    if(var_05 > var_04)
      var_0.func_466B[var_9.func_108DF]++;
  }

  func_AFDA(var_00);
}

_precomputedlosdatatest(var_00, var_01) {
  var_02 = checkttlosoverrides(var_00, var_01);

  if(!isDefined(var_02))
    var_02 = _precomputedlosdatatest(var_0.spawnviewpathnodes, var_1.radiuspathnodes);

  return var_02;
}

checkttlosoverrides(var_00, var_01) {
  if(!isDefined(level.spawnglobals.ttlosoverrides)) {
    return;
  }
  foreach(var_03 in var_0.spawnviewpathnodes) {
    var_04 = var_03 getnodenumber();

    if(isDefined(level.spawnglobals.ttlosoverrides[var_04])) {
      foreach(var_06 in var_1.radiuspathnodes) {
        var_07 = var_06 getnodenumber();

        if(isDefined(level.spawnglobals.ttlosoverrides[var_04][var_07]))
          return level.spawnglobals.ttlosoverrides[var_04][var_07];
      }
    }
  }
}

addttlosoverride(var_00, var_01, var_02, var_03) {
  level endon("game_ended");

  for(;;) {
    if(isDefined(level.spawnglobals)) {
      break;
    }
    scripts\engine\utility::waitframe();
  }

  if(!isDefined(level.spawnglobals.ttlosoverrides))
    level.spawnglobals.ttlosoverrides = [];

  if(!isDefined(level.spawnglobals.ttlosoverrides[var_00]))
    level.spawnglobals.ttlosoverrides[var_00] = [];

  level.spawnglobals.ttlosoverrides[var_00][var_01] = [var_02, var_03];

  if(!isDefined(level.spawnglobals.ttlosoverrides[var_01]))
    level.spawnglobals.ttlosoverrides[var_01] = [];

  level.spawnglobals.ttlosoverrides[var_01][var_00] = [var_02, var_03];
}

getclosenoderadiusdist() {
  return 130;
}

getfarnoderadiusdist() {
  return 250;
}

func_54EC(var_00, var_01, var_02) {
  var_03 = var_0.func_101E9;
  var_04 = var_02;
  var_05 = physics_createcontents(["physicscontents_aiavoid", "physicscontents_solid", "physicscontents_structural"]);
  var_06 = physics_raycast(var_03, var_04, var_05, var_01, 0, "physicsquery_any");
  return scripts\engine\utility::ter_op(var_06, 0.0, 1.0);
}

getmaxdistancetolos() {
  return 2550;
}

shoulduseprecomputedlos() {
  return getdvarint("sv_usePrecomputedLOSData", 0) == 1 && !isDefined(level.func_560C) && getdvarint("sv_generateLOSData", 0) != 1;
}

isttlosdataavailable() {
  return _getislosdatafileloaded();
}

func_D91D() {
  level waittill("prematch_done");

  if(getdvarint("scr_playtest", 0) == 1 && isDefined(level.players)) {
    foreach(var_01 in level.players) {
      if(var_01 ishost()) {
        if(shoulduseprecomputedlos())
          var_01 iprintlnbold("Attempting to use NEW Spawn System...");
        else
          var_01 iprintlnbold("Using OLD Spawn System...");

        break;
      }
    }
  }

  if(isDefined(level.matchrecording_logeventmsg)) {
    if(shoulduseprecomputedlos())
      [[level.matchrecording_logeventmsg]]("LOG_GENERIC_MESSAGE", gettime(), "Attempting to use TTLOS Spawning Data...");
    else
      [
        [level.matchrecording_logeventmsg]
      ]("LOG_GENERIC_MESSAGE", gettime(), "Using Corner-Trace Spawning System...");
  }
}

func_E2B6() {
  level notify("spawn_restart_trace_system");
}

func_9DF1(var_00) {
  return scripts\mp\utility\game::istrue(var_0.func_9DF0);
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
    wait 0.5;
    logextraspawn("axis", var_01);
    wait 0.5;
  }
}

logextraspawn(var_00, var_01) {
  var_02 = spawnStruct();
  var_2.team = var_00;
  var_2.pers = [];
  var_2.pers["team"] = var_00;
  var_2.disablespawnwarnings = 1;
  var_2.isdynamicspawn = 1;
  var_03 = var_02[[level.getspawnpoint]]();

  if(isDefined(level.matchrecording_logevent) && isDefined(var_03) && isDefined(var_01)) {
    var_04 = scripts\engine\utility::ter_op(var_00 == "allies", "BEST_SPAWN_ALLIES", "BEST_SPAWN_AXIS");
    [[level.matchrecording_logevent]](var_01, var_00, var_04, var_3.origin[0], var_3.origin[1], gettime());
  }
}

clearlastteamspawns() {
  level.spawnglobals.lastteamspawnpoints = [];
}

getoriginidentifierstring(var_00) {
  return int(var_0.origin[0]) + " " + int(var_0.origin[1]) + " " + int(var_0.origin[2]);
}

checkmodifiedspawnpoint(var_00) {
  if(!isDefined(level.modifiedspawnpoints))
    return 0;

  var_01 = undefined;
  var_02 = getoriginidentifierstring(var_00);

  if(isDefined(level.modifiedspawnpoints[var_02]))
    var_01 = level.modifiedspawnpoints[var_02][var_0.classname];

  if(!isDefined(var_01))
    return 0;

  if(scripts\mp\utility\game::istrue(var_1["remove"]))
    return 1;

  if(isDefined(var_1["origin"]))
    var_0.origin = var_1["origin"];

  if(isDefined(var_1["angles"]))
    var_0.angles = var_1["angles"];

  if(scripts\mp\utility\game::istrue(var_1["no_alternates"]))
    var_0.noalternates = 1;

  return 0;
}