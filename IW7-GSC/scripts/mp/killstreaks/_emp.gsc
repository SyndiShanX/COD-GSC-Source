/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_emp.gsc
*********************************************/

init() {}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
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

func_618B(var_0, var_1) {
  var_2 = self.pers["team"];
  if(level.multiteambased) {
    thread func_6166(var_2);
  } else if(level.teambased) {
    var_3 = level.otherteam[var_2];
    thread func_6165(var_3);
  } else {
    thread func_6164(self);
  }

  scripts\mp\matchdata::logkillstreakevent("emp", self.origin);
  self notify("used_emp");
  return 1;
}

func_6166(var_0) {
  level endon("game_ended");
  thread scripts\mp\utility::teamplayercardsplash("used_emp", self);
  level notify("EMP_JamTeam" + var_0);
  level endon("EMP_JamTeam" + var_0);
  foreach(var_2 in level.players) {
    var_2 playlocalsound("emp_activate");
    if(var_2.team == var_0) {
      continue;
    }

    if(var_2 scripts\mp\utility::_hasperk("specialty_localjammer")) {
      var_2 clearscrambler();
    }
  }

  visionsetnaked("coup_sunblind", 0.1);
  thread func_619F();
  wait(0.1);
  visionsetnaked("coup_sunblind", 0);
  visionsetnaked("", 3);
  for(var_4 = 0; var_4 < level.teamnamelist.size; var_4++) {
    if(var_0 != level.teamnamelist[var_4]) {
      level.teamemped[level.teamnamelist[var_4]] = 1;
    }
  }

  level notify("emp_update");
  for(var_4 = 0; var_4 < level.teamnamelist.size; var_4++) {
    if(var_0 != level.teamnamelist[var_4]) {
      level func_52CA(self, level.teamnamelist[var_4]);
    }
  }

  level thread func_A577();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level.empstuntime);
  for(var_4 = 0; var_4 < level.teamnamelist.size; var_4++) {
    if(var_0 != level.teamnamelist[var_4]) {
      level.teamemped[level.teamnamelist[var_4]] = 0;
    }
  }

  foreach(var_2 in level.players) {
    if(var_2.team == var_0) {
      continue;
    }

    if(var_2 scripts\mp\utility::_hasperk("specialty_localjammer")) {
      var_2 makescrambler();
    }
  }

  level notify("emp_update");
}

func_6165(var_0) {
  level endon("game_ended");
  thread scripts\mp\utility::teamplayercardsplash("used_emp", self);
  level notify("EMP_JamTeam" + var_0);
  level endon("EMP_JamTeam" + var_0);
  foreach(var_2 in level.players) {
    var_2 playlocalsound("emp_activate");
    if(var_2.team != var_0) {
      continue;
    }

    if(var_2 scripts\mp\utility::_hasperk("specialty_localjammer")) {
      var_2 clearscrambler();
    }

    var_2 visionsetnakedforplayer("coup_sunblind", 0.1);
  }

  thread func_619F();
  wait(0.1);
  visionsetnaked("coup_sunblind", 0);
  visionsetnaked("", 3);
  level.teamemped[var_0] = 1;
  level notify("emp_update");
  level func_52CA(self, var_0);
  level thread func_A577();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level.empstuntime);
  level.teamemped[var_0] = 0;
  foreach(var_2 in level.players) {
    if(var_2.team != var_0) {
      continue;
    }

    if(var_2 scripts\mp\utility::_hasperk("specialty_localjammer")) {
      var_2 makescrambler();
    }
  }

  level notify("emp_update");
}

func_6164(var_0) {
  level notify("EMP_JamPlayers");
  level endon("EMP_JamPlayers");
  foreach(var_2 in level.players) {
    var_2 playlocalsound("emp_activate");
    if(var_2 == var_0) {
      continue;
    }

    if(var_2 scripts\mp\utility::_hasperk("specialty_localjammer")) {
      var_2 clearscrambler();
    }
  }

  visionsetnaked("coup_sunblind", 0.1);
  thread func_619F();
  wait(0.1);
  visionsetnaked("coup_sunblind", 0);
  visionsetnaked("", 3);
  level notify("emp_update");
  level.empplayer = var_0;
  level.empplayer thread empradarwatcher();
  level func_52CA(var_0);
  level notify("emp_update");
  level thread func_A577();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level.empstuntime);
  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      continue;
    }

    if(var_2 scripts\mp\utility::_hasperk("specialty_localjammer")) {
      var_2 makescrambler();
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
  foreach(var_1 in level.players) {
    var_2 = anglesToForward(var_1.angles);
    var_2 = (var_2[0], var_2[1], 0);
    var_2 = vectornormalize(var_2);
    var_3 = 20000;
    var_4 = spawn("script_model", var_1.origin + (0, 0, 8000) + var_2 * var_3);
    var_4 setModel("tag_origin");
    var_4.angles = var_4.angles + (270, 0, 0);
    var_4 thread func_619E(var_1);
  }
}

func_619E(var_0) {
  var_0 endon("disconnect");
  wait(0.5);
  playfxontagforclients(level._effect["emp_flash"], self, "tag_origin", var_0);
}

func_6187() {
  level endon("game_ended");
  for(;;) {
    level scripts\engine\utility::waittill_either("joined_team", "emp_update");
    foreach(var_1 in level.players) {
      if(var_1.team == "spectator") {
        continue;
      }

      if(!level.teamemped[var_1.team] && !var_1 scripts\mp\killstreaks\_emp_common::isemped()) {
        var_1 func_626B(0);
        continue;
      }

      var_1 func_626B(1);
    }
  }
}

func_617C() {
  level endon("game_ended");
  for(;;) {
    level scripts\engine\utility::waittill_either("joined_team", "emp_update");
    foreach(var_1 in level.players) {
      if(var_1.team == "spectator") {
        continue;
      }

      if(isDefined(level.empplayer) && level.empplayer != var_1) {
        var_1 func_626B(1);
        continue;
      }

      if(!var_1 scripts\mp\killstreaks\_emp_common::isemped()) {
        var_1 func_626B(0);
      }
    }
  }
}

func_52CA(var_0, var_1) {
  thread func_52C2(var_0, var_1);
  thread func_52C4(var_0, var_1);
  thread func_52C7(var_0, var_1);
  thread func_52C6(var_0, var_1);
  thread func_52C8(var_0, var_1);
  thread func_52C3(var_0, var_1);
  thread func_52C9(var_0, var_1);
  thread func_52C0(var_0, var_1);
  thread func_52C1(var_0, var_1);
  thread func_532B(var_0, var_1, level.remote_uav);
  thread func_532B(var_0, var_1, level.uplinks);
}

func_532B(var_0, var_1, var_2) {
  var_3 = "MOD_EXPLOSIVE";
  var_4 = "killstreak_emp_mp";
  var_5 = 5000;
  var_6 = (0, 0, 0);
  var_7 = (0, 0, 0);
  var_8 = "";
  var_9 = "";
  var_0A = "";
  var_0B = undefined;
  foreach(var_0D in var_2) {
    if(level.teambased && isDefined(var_1)) {
      if(isDefined(var_0D.team) && var_0D.team != var_1) {
        continue;
      }
    } else if(isDefined(var_0D.triggerportableradarping) && var_0D.triggerportableradarping == var_0) {
      continue;
    }

    var_0D notify("damage", var_5, var_0, var_6, var_7, var_3, var_8, var_9, var_0A, var_0B, var_4);
    wait(0.05);
  }
}

func_52C2(var_0, var_1) {
  func_532B(var_0, var_1, level.helis);
}

func_52C4(var_0, var_1) {
  func_532B(var_0, var_1, level.littlebirds);
}

func_52C7(var_0, var_1) {
  func_532B(var_0, var_1, level.turrets);
}

func_52C6(var_0, var_1) {
  var_2 = "MOD_EXPLOSIVE";
  var_3 = "killstreak_emp_mp";
  var_4 = 5000;
  var_5 = (0, 0, 0);
  var_6 = (0, 0, 0);
  var_7 = "";
  var_8 = "";
  var_9 = "";
  var_0A = undefined;
  foreach(var_0C in level.rockets) {
    if(level.teambased && isDefined(var_1)) {
      if(isDefined(var_0C.team) && var_0C.team != var_1) {
        continue;
      }
    } else if(isDefined(var_0C.triggerportableradarping) && var_0C.triggerportableradarping == var_0) {
      continue;
    }

    playFX(level.remotekillstreaks["explode"], var_0C.origin);
    var_0C delete();
    wait(0.05);
  }
}

func_52C8(var_0, var_1) {
  var_2 = level.uavmodels;
  if(level.teambased && isDefined(var_1)) {
    var_2 = level.uavmodels[var_1];
  }

  func_532B(var_0, var_1, var_2);
}

func_52C3(var_0, var_1) {
  func_532B(var_0, var_1, level.var_935F);
}

func_52C9(var_0, var_1) {
  func_532B(var_0, var_1, level.ugvs);
}

func_52C0(var_0, var_1) {
  var_2 = "MOD_EXPLOSIVE";
  var_3 = "killstreak_emp_mp";
  var_4 = 5000;
  var_5 = (0, 0, 0);
  var_6 = (0, 0, 0);
  var_7 = "";
  var_8 = "";
  var_9 = "";
  var_0A = undefined;
  if(level.teambased && isDefined(var_1)) {
    if(isDefined(level.ac130player) && isDefined(level.ac130player.team) && level.ac130player.team == var_1) {
      level.ac130.planemodel notify("damage", var_4, var_0, var_5, var_6, var_2, var_7, var_8, var_9, var_0A, var_3);
      return;
    }

    return;
  }

  if(isDefined(level.ac130player)) {
    if(!isDefined(level.ac130.triggerportableradarping) || isDefined(level.ac130.triggerportableradarping) && level.ac130.triggerportableradarping != var_0) {
      level.ac130.planemodel notify("damage", var_4, var_0, var_5, var_6, var_2, var_7, var_8, var_9, var_0A, var_3);
      return;
    }
  }
}

func_52C1(var_0, var_1) {
  func_532B(var_0, var_1, level.balldrones);
}

func_626B(var_0) {
  self give_infinite_grenade(var_0);
  var_1 = 0;
  if(var_0) {
    var_1 = 1;
  }

  thread scripts\mp\killstreaks\_emp_common::func_10D95();
}