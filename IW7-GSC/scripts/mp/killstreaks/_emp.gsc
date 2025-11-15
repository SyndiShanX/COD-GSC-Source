/*******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_emp.gsc
*******************************************/

init() {}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    if((level.teambased && level.teamemped[self.team]) || !level.teambased && isDefined(level.empplayer) && level.empplayer != self) {
      self give_infinite_grenade(1);
    }
  }
}

func_618B(param_00, param_01) {
  var_02 = self.pers["team"];
  if(level.multiteambased) {
    thread func_6166(var_02);
  } else if(level.teambased) {
    var_03 = level.otherteam[var_02];
    thread func_6165(var_03);
  } else {
    thread func_6164(self);
  }

  scripts\mp\matchdata::logkillstreakevent("emp", self.origin);
  self notify("used_emp");
  return 1;
}

func_6166(param_00) {
  level endon("game_ended");
  thread scripts\mp\utility::teamplayercardsplash("used_emp", self);
  level notify("EMP_JamTeam" + param_00);
  level endon("EMP_JamTeam" + param_00);
  foreach(var_02 in level.players) {
    var_02 playlocalsound("emp_activate");
    if(var_02.team == param_00) {
      continue;
    }

    if(var_02 scripts\mp\utility::_hasperk("specialty_localjammer")) {
      var_02 clearscrambler();
    }
  }

  visionsetnaked("coup_sunblind", 0.1);
  thread func_619F();
  wait(0.1);
  visionsetnaked("coup_sunblind", 0);
  visionsetnaked("", 3);
  for(var_04 = 0; var_04 < level.teamnamelist.size; var_04++) {
    if(param_00 != level.teamnamelist[var_04]) {
      level.teamemped[level.teamnamelist[var_04]] = 1;
    }
  }

  level notify("emp_update");
  for(var_04 = 0; var_04 < level.teamnamelist.size; var_04++) {
    if(param_00 != level.teamnamelist[var_04]) {
      level func_52CA(self, level.teamnamelist[var_04]);
    }
  }

  level thread func_A577();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level.empstuntime);
  for(var_04 = 0; var_04 < level.teamnamelist.size; var_04++) {
    if(param_00 != level.teamnamelist[var_04]) {
      level.teamemped[level.teamnamelist[var_04]] = 0;
    }
  }

  foreach(var_02 in level.players) {
    if(var_02.team == param_00) {
      continue;
    }

    if(var_02 scripts\mp\utility::_hasperk("specialty_localjammer")) {
      var_02 makescrambler();
    }
  }

  level notify("emp_update");
}

func_6165(param_00) {
  level endon("game_ended");
  thread scripts\mp\utility::teamplayercardsplash("used_emp", self);
  level notify("EMP_JamTeam" + param_00);
  level endon("EMP_JamTeam" + param_00);
  foreach(var_02 in level.players) {
    var_02 playlocalsound("emp_activate");
    if(var_02.team != param_00) {
      continue;
    }

    if(var_02 scripts\mp\utility::_hasperk("specialty_localjammer")) {
      var_02 clearscrambler();
    }

    var_02 visionsetnakedforplayer("coup_sunblind", 0.1);
  }

  thread func_619F();
  wait(0.1);
  visionsetnaked("coup_sunblind", 0);
  visionsetnaked("", 3);
  level.teamemped[param_00] = 1;
  level notify("emp_update");
  level func_52CA(self, param_00);
  level thread func_A577();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level.empstuntime);
  level.teamemped[param_00] = 0;
  foreach(var_02 in level.players) {
    if(var_02.team != param_00) {
      continue;
    }

    if(var_02 scripts\mp\utility::_hasperk("specialty_localjammer")) {
      var_02 makescrambler();
    }
  }

  level notify("emp_update");
}

func_6164(param_00) {
  level notify("EMP_JamPlayers");
  level endon("EMP_JamPlayers");
  foreach(var_02 in level.players) {
    var_02 playlocalsound("emp_activate");
    if(var_02 == param_00) {
      continue;
    }

    if(var_02 scripts\mp\utility::_hasperk("specialty_localjammer")) {
      var_02 clearscrambler();
    }
  }

  visionsetnaked("coup_sunblind", 0.1);
  thread func_619F();
  wait(0.1);
  visionsetnaked("coup_sunblind", 0);
  visionsetnaked("", 3);
  level notify("emp_update");
  level.empplayer = param_00;
  level.empplayer thread empradarwatcher();
  level func_52CA(param_00);
  level notify("emp_update");
  level thread func_A577();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level.empstuntime);
  foreach(var_02 in level.players) {
    if(var_02 == param_00) {
      continue;
    }

    if(var_02 scripts\mp\utility::_hasperk("specialty_localjammer")) {
      var_02 makescrambler();
    }
  }

  level.empplayer = undefined;
  level notify("emp_update");
  level notify("emp_ended");
}

func_A577() {
  level notify("keepEMPTimeRemaining");
  level endon("keepEMPTimeRemaining");
  level endon("emp_ended");
  level.emptriggerholdonuse = int(level.empstuntime);
  while(level.emptriggerholdonuse) {
    wait(1);
    level.emptriggerholdonuse--;
  }
}

empradarwatcher() {
  level endon("EMP_JamPlayers");
  level endon("emp_ended");
  self waittill("disconnect");
  level notify("emp_update");
}

func_619F() {
  foreach(var_01 in level.players) {
    var_02 = anglesToForward(var_01.angles);
    var_02 = (var_02[0], var_02[1], 0);
    var_02 = vectornormalize(var_02);
    var_03 = 20000;
    var_04 = spawn("script_model", var_01.origin + (0, 0, 8000) + var_02 * var_03);
    var_04 setModel("tag_origin");
    var_04.angles = var_04.angles + (270, 0, 0);
    var_04 thread func_619E(var_01);
  }
}

func_619E(param_00) {
  param_00 endon("disconnect");
  wait(0.5);
  playfxontagforclients(level._effect["emp_flash"], self, "tag_origin", param_00);
}

func_6187() {
  level endon("game_ended");
  for(;;) {
    level scripts\engine\utility::waittill_either("joined_team", "emp_update");
    foreach(var_01 in level.players) {
      if(var_01.team == "spectator") {
        continue;
      }

      if(!level.teamemped[var_01.team] && !var_01 scripts\mp\killstreaks\_emp_common::isemped()) {
        var_01 func_626B(0);
        continue;
      }

      var_01 func_626B(1);
    }
  }
}

func_617C() {
  level endon("game_ended");
  for(;;) {
    level scripts\engine\utility::waittill_either("joined_team", "emp_update");
    foreach(var_01 in level.players) {
      if(var_01.team == "spectator") {
        continue;
      }

      if(isDefined(level.empplayer) && level.empplayer != var_01) {
        var_01 func_626B(1);
        continue;
      }

      if(!var_01 scripts\mp\killstreaks\_emp_common::isemped()) {
        var_01 func_626B(0);
      }
    }
  }
}

func_52CA(param_00, param_01) {
  thread func_52C2(param_00, param_01);
  thread func_52C4(param_00, param_01);
  thread func_52C7(param_00, param_01);
  thread func_52C6(param_00, param_01);
  thread func_52C8(param_00, param_01);
  thread func_52C3(param_00, param_01);
  thread func_52C9(param_00, param_01);
  thread func_52C0(param_00, param_01);
  thread func_52C1(param_00, param_01);
  thread func_532B(param_00, param_01, level.remote_uav);
  thread func_532B(param_00, param_01, level.uplinks);
}

func_532B(param_00, param_01, param_02) {
  var_03 = "MOD_EXPLOSIVE";
  var_04 = "killstreak_emp_mp";
  var_05 = 5000;
  var_06 = (0, 0, 0);
  var_07 = (0, 0, 0);
  var_08 = "";
  var_09 = "";
  var_0A = "";
  var_0B = undefined;
  foreach(var_0D in param_02) {
    if(level.teambased && isDefined(param_01)) {
      if(isDefined(var_0D.team) && var_0D.team != param_01) {
        continue;
      }
    } else if(isDefined(var_0D.triggerportableradarping) && var_0D.triggerportableradarping == param_00) {
      continue;
    }

    var_0D notify("damage", var_05, param_00, var_06, var_07, var_03, var_08, var_09, var_0A, var_0B, var_04);
    wait(0.05);
  }
}

func_52C2(param_00, param_01) {
  func_532B(param_00, param_01, level.helis);
}

func_52C4(param_00, param_01) {
  func_532B(param_00, param_01, level.littlebirds);
}

func_52C7(param_00, param_01) {
  func_532B(param_00, param_01, level.turrets);
}

func_52C6(param_00, param_01) {
  var_02 = "MOD_EXPLOSIVE";
  var_03 = "killstreak_emp_mp";
  var_04 = 5000;
  var_05 = (0, 0, 0);
  var_06 = (0, 0, 0);
  var_07 = "";
  var_08 = "";
  var_09 = "";
  var_0A = undefined;
  foreach(var_0C in level.rockets) {
    if(level.teambased && isDefined(param_01)) {
      if(isDefined(var_0C.team) && var_0C.team != param_01) {
        continue;
      }
    } else if(isDefined(var_0C.triggerportableradarping) && var_0C.triggerportableradarping == param_00) {
      continue;
    }

    playFX(level.remotekillstreaks["explode"], var_0C.origin);
    var_0C delete();
    wait(0.05);
  }
}

func_52C8(param_00, param_01) {
  var_02 = level.uavmodels;
  if(level.teambased && isDefined(param_01)) {
    var_02 = level.uavmodels[param_01];
  }

  func_532B(param_00, param_01, var_02);
}

func_52C3(param_00, param_01) {
  func_532B(param_00, param_01, level.var_935F);
}

func_52C9(param_00, param_01) {
  func_532B(param_00, param_01, level.ugvs);
}

func_52C0(param_00, param_01) {
  var_02 = "MOD_EXPLOSIVE";
  var_03 = "killstreak_emp_mp";
  var_04 = 5000;
  var_05 = (0, 0, 0);
  var_06 = (0, 0, 0);
  var_07 = "";
  var_08 = "";
  var_09 = "";
  var_0A = undefined;
  if(level.teambased && isDefined(param_01)) {
    if(isDefined(level.ac130player) && isDefined(level.ac130player.team) && level.ac130player.team == param_01) {
      level.ac130.planemodel notify("damage", var_04, param_00, var_05, var_06, var_02, var_07, var_08, var_09, var_0A, var_03);
      return;
    }

    return;
  }

  if(isDefined(level.ac130player)) {
    if(!isDefined(level.ac130.triggerportableradarping) || isDefined(level.ac130.triggerportableradarping) && level.ac130.triggerportableradarping != param_00) {
      level.ac130.planemodel notify("damage", var_04, param_00, var_05, var_06, var_02, var_07, var_08, var_09, var_0A, var_03);
      return;
    }
  }
}

func_52C1(param_00, param_01) {
  func_532B(param_00, param_01, level.balldrones);
}

func_626B(param_00) {
  self give_infinite_grenade(param_00);
  var_01 = 0;
  if(param_00) {
    var_01 = 1;
  }

  thread scripts\mp\killstreaks\_emp_common::func_10D95();
}