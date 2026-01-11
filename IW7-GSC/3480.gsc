/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3480.gsc
***************************************/

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

    if(level.teambased && level.teamemped[self.team] || !level.teambased && isDefined(level.empplayer) && level.empplayer != self) {
      self give_infinite_grenade(1);
    }
  }
}

func_618B(var_00, var_01) {
  var_02 = self.pers["team"];

  if(level.multiteambased) {
    thread func_6166(var_02);
  }
  else if(level.teambased) {
    var_03 = level.otherteam[var_02];
    thread func_6165(var_03);
  } else
    thread func_6164(self);

  scripts\mp\matchdata::logkillstreakevent("emp", self.origin);
  self notify("used_emp");
  return 1;
}

func_6166(var_00) {
  level endon("game_ended");
  thread scripts\mp\utility\game::teamplayercardsplash("used_emp", self);
  level notify("EMP_JamTeam" + var_00);
  level endon("EMP_JamTeam" + var_00);

  foreach(var_02 in level.players) {
    var_02 playlocalsound("emp_activate");

    if(var_2.team == var_00) {
      continue;
    }
    if(var_02 scripts\mp\utility\game::_hasperk("specialty_localjammer")) {
      var_02 clearscrambler();
    }
  }

  visionsetnaked("coup_sunblind", 0.1);
  thread func_619F();
  wait 0.1;
  visionsetnaked("coup_sunblind", 0);
  visionsetnaked("", 3.0);

  for(var_04 = 0; var_04 < level.teamnamelist.size; var_4++) {
    if(var_00 != level.teamnamelist[var_04]) {
      level.teamemped[level.teamnamelist[var_04]] = 1;
    }
  }

  level notify("emp_update");

  for(var_04 = 0; var_04 < level.teamnamelist.size; var_4++) {
    if(var_00 != level.teamnamelist[var_04]) {
      level func_52CA(self, level.teamnamelist[var_04]);
    }
  }

  level thread func_A577();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level.empstuntime);

  for(var_04 = 0; var_04 < level.teamnamelist.size; var_4++) {
    if(var_00 != level.teamnamelist[var_04]) {
      level.teamemped[level.teamnamelist[var_04]] = 0;
    }
  }

  foreach(var_02 in level.players) {
    if(var_2.team == var_00) {
      continue;
    }
    if(var_02 scripts\mp\utility\game::_hasperk("specialty_localjammer")) {
      var_02 makescrambler();
    }
  }

  level notify("emp_update");
}

func_6165(var_00) {
  level endon("game_ended");
  thread scripts\mp\utility\game::teamplayercardsplash("used_emp", self);
  level notify("EMP_JamTeam" + var_00);
  level endon("EMP_JamTeam" + var_00);

  foreach(var_02 in level.players) {
    var_02 playlocalsound("emp_activate");

    if(var_2.team != var_00) {
      continue;
    }
    if(var_02 scripts\mp\utility\game::_hasperk("specialty_localjammer")) {
      var_02 clearscrambler();
    }

    var_02 visionsetnakedforplayer("coup_sunblind", 0.1);
  }

  thread func_619F();
  wait 0.1;
  visionsetnaked("coup_sunblind", 0);
  visionsetnaked("", 3.0);
  level.teamemped[var_00] = 1;
  level notify("emp_update");
  level func_52CA(self, var_00);
  level thread func_A577();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level.empstuntime);
  level.teamemped[var_00] = 0;

  foreach(var_02 in level.players) {
    if(var_2.team != var_00) {
      continue;
    }
    if(var_02 scripts\mp\utility\game::_hasperk("specialty_localjammer")) {
      var_02 makescrambler();
    }
  }

  level notify("emp_update");
}

func_6164(var_00) {
  level notify("EMP_JamPlayers");
  level endon("EMP_JamPlayers");

  foreach(var_02 in level.players) {
    var_02 playlocalsound("emp_activate");

    if(var_02 == var_00) {
      continue;
    }
    if(var_02 scripts\mp\utility\game::_hasperk("specialty_localjammer")) {
      var_02 clearscrambler();
    }
  }

  visionsetnaked("coup_sunblind", 0.1);
  thread func_619F();
  wait 0.1;
  visionsetnaked("coup_sunblind", 0);
  visionsetnaked("", 3.0);
  level notify("emp_update");
  level.empplayer = var_00;
  level.empplayer thread empradarwatcher();
  level func_52CA(var_00);
  level notify("emp_update");
  level thread func_A577();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level.empstuntime);

  foreach(var_02 in level.players) {
    if(var_02 == var_00) {
      continue;
    }
    if(var_02 scripts\mp\utility\game::_hasperk("specialty_localjammer")) {
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

  for(level.emptriggerholdonuse = int(level.empstuntime); level.emptriggerholdonuse; level.emptriggerholdonuse--) {
    wait 1.0;
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
    var_02 = anglesToForward(var_1.angles);
    var_02 = (var_2[0], var_2[1], 0);
    var_02 = vectornormalize(var_02);
    var_03 = 20000;
    var_04 = spawn("script_model", var_1.origin + (0, 0, 8000) + var_02 * var_03);
    var_04 setModel("tag_origin");
    var_4.angles = var_4.angles + (270, 0, 0);
    var_04 thread func_619E(var_01);
  }
}

func_619E(var_00) {
  var_00 endon("disconnect");
  wait 0.5;
  playfxontagforclients(level._effect["emp_flash"], self, "tag_origin", var_00);
}

func_6187() {
  level endon("game_ended");

  for(;;) {
    level scripts\engine\utility::waittill_either("joined_team", "emp_update");

    foreach(var_01 in level.players) {
      if(var_1.team == "spectator") {
        continue;
      }
      if(!level.teamemped[var_1.team] && !var_01 scripts\mp\killstreaks\emp_common::isemped()) {
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
      if(var_1.team == "spectator") {
        continue;
      }
      if(isDefined(level.empplayer) && level.empplayer != var_01) {
        var_01 func_626B(1);
        continue;
      }

      if(!var_01 scripts\mp\killstreaks\emp_common::isemped()) {
        var_01 func_626B(0);
      }
    }
  }
}

func_52CA(var_00, var_01) {
  thread func_52C2(var_00, var_01);
  thread func_52C4(var_00, var_01);
  thread func_52C7(var_00, var_01);
  thread func_52C6(var_00, var_01);
  thread func_52C8(var_00, var_01);
  thread func_52C3(var_00, var_01);
  thread func_52C9(var_00, var_01);
  thread func_52C0(var_00, var_01);
  thread func_52C1(var_00, var_01);
  thread func_532B(var_00, var_01, level.remote_uav);
  thread func_532B(var_00, var_01, level.uplinks);
}

func_532B(var_00, var_01, var_02) {
  var_03 = "MOD_EXPLOSIVE";
  var_04 = "killstreak_emp_mp";
  var_05 = 5000;
  var_06 = (0, 0, 0);
  var_07 = (0, 0, 0);
  var_08 = "";
  var_09 = "";
  var_10 = "";
  var_11 = undefined;

  foreach(var_13 in var_02) {
    if(level.teambased && isDefined(var_01)) {
      if(isDefined(var_13.team) && var_13.team != var_01) {
        continue;
      }
    } else if(isDefined(var_13.owner) && var_13.owner == var_00) {
      continue;
    }
    var_13 notify("damage", var_05, var_00, var_06, var_07, var_03, var_08, var_09, var_10, var_11, var_04);
    wait 0.05;
  }
}

func_52C2(var_00, var_01) {
  func_532B(var_00, var_01, level.helis);
}

func_52C4(var_00, var_01) {
  func_532B(var_00, var_01, level.littlebirds);
}

func_52C7(var_00, var_01) {
  func_532B(var_00, var_01, level.turrets);
}

func_52C6(var_00, var_01) {
  var_02 = "MOD_EXPLOSIVE";
  var_03 = "killstreak_emp_mp";
  var_04 = 5000;
  var_05 = (0, 0, 0);
  var_06 = (0, 0, 0);
  var_07 = "";
  var_08 = "";
  var_09 = "";
  var_10 = undefined;

  foreach(var_12 in level.rockets) {
    if(level.teambased && isDefined(var_01)) {
      if(isDefined(var_12.team) && var_12.team != var_01) {
        continue;
      }
    } else if(isDefined(var_12.owner) && var_12.owner == var_00) {
      continue;
    }
    playFX(level.remotekillstreaks["explode"], var_12.origin);
    var_12 delete();
    wait 0.05;
  }
}

func_52C8(var_00, var_01) {
  var_02 = level.uavmodels;

  if(level.teambased && isDefined(var_01)) {
    var_02 = level.uavmodels[var_01];
  }

  func_532B(var_00, var_01, var_02);
}

func_52C3(var_00, var_01) {
  func_532B(var_00, var_01, level.func_935F);
}

func_52C9(var_00, var_01) {
  func_532B(var_00, var_01, level.ugvs);
}

func_52C0(var_00, var_01) {
  var_02 = "MOD_EXPLOSIVE";
  var_03 = "killstreak_emp_mp";
  var_04 = 5000;
  var_05 = (0, 0, 0);
  var_06 = (0, 0, 0);
  var_07 = "";
  var_08 = "";
  var_09 = "";
  var_10 = undefined;

  if(level.teambased && isDefined(var_01)) {
    if(isDefined(level.ac130player) && isDefined(level.ac130player.team) && level.ac130player.team == var_01) {
      level.ac130.planemodel notify("damage", var_04, var_00, var_05, var_06, var_02, var_07, var_08, var_09, var_10, var_03);
    }
  } else if(isDefined(level.ac130player)) {
    if(!isDefined(level.ac130.owner) || isDefined(level.ac130.owner) && level.ac130.owner != var_00) {
      level.ac130.planemodel notify("damage", var_04, var_00, var_05, var_06, var_02, var_07, var_08, var_09, var_10, var_03);
    }
  }
}

func_52C1(var_00, var_01) {
  func_532B(var_00, var_01, level.balldrones);
}

func_626B(var_00) {
  self give_infinite_grenade(var_00);
  var_01 = 0;

  if(var_00) {
    var_01 = 1;
  }

  thread scripts\mp\killstreaks\emp_common::func_10D95();
}