/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\agents\dog\_dog_think.gsc
*********************************************/

main() {
  func_8A16();
  thread func_9963();
  thread func_A92D();
  thread func_A92E();
  thread func_A92F();
  thread func_A692();
  thread func_A6B1();
  level.var_31F3 = ::func_6ADB;
  level.var_31FB = ::func_A909;
  level.var_31F4 = ::func_6AFF;
  level.var_31F2 = ::init;
  level.var_31F8 = ::func_8A16;
  level.var_31F5 = ::func_7AC0;
  level.var_31B2 = ::func_2EE6;
  level.var_31F1 = ::func_442A;
}

func_8A16() {
  self.var_17E8 = 0;
  self.var_6DAE = 20736;
  self.var_60F2 = 16384;
  self.var_11AB = 25 + self.radius;
  self.var_11AD = 9437184;
  self.var_A85B = 302500;
  self.var_A85C = 96;
  self.var_11B8 = 54;
  self.var_11B9 = -64;
  self.var_6DAB = 2250000;
  self.var_31B1 = 2250000;
  self.var_59DE = 1000000;
  self.var_7673 = 76;
  self.var_621C = 50;
  self.var_3E0B = 0;
  self.ignoreclosefoliage = 1;
  self.vectortoangles = "run";
  self.var_3658 = 1;
  self.var_11B5 = "idle";
  self.var_64CE = "idle";
  self.var_173C = 0;
  self.var_99FC = 0;
  self.allowcrouch = 1;
  self method_8399(24);
}

init() {
  self.var_EAD = spawnStruct();
  self.var_EAD.var_6AFE = [];
  self.var_EAD.var_6AFE["idle"] = ::maps / mp / agents / dog / _dog_idle::main;
  self.var_EAD.var_6AFE["move"] = ::maps / mp / agents / dog / _dog_move::main;
  self.var_EAD.var_6AFE["traverse"] = ::maps / mp / agents / dog / _dog_traverse::main;
  self.var_EAD.var_6AFE["melee"] = ::maps / mp / agents / dog / _dog_melee::main;
  self.var_EAD.var_6B2F = [];
  self.var_EAD.var_6B2F["idle"] = ::maps / mp / agents / dog / _dog_idle::func_85;
  self.var_EAD.var_6B2F["move"] = ::maps / mp / agents / dog / _dog_move::func_85;
  self.var_EAD.var_6B2F["melee"] = ::maps / mp / agents / dog / _dog_melee::func_85;
  self.var_EAD.var_6B2F["traverse"] = ::maps / mp / agents / dog / _dog_traverse::func_85;
  self.var_A8ED = ::func_A8EC;
  self.var_BA4 = "idle";
  self.vectortoangles = "fastwalk";
  self.radius = 15;
  self.height = 40;
}

func_6AFF(param_00, param_01) {
  self notify("killanimscript");
  if(!isDefined(self.var_EAD.var_6AFE[param_01])) {
    return;
  }

  if(param_00 == param_01 && param_01 != "traverse") {
    return;
  }

  if(isDefined(self.var_EAD.var_6B2F[param_00])) {
    self[[self.var_EAD.var_6B2F[param_00]]]();
  }

  func_38ED(self.var_BA4);
  self.var_BA4 = param_01;
  func_37B8(param_01);
  self[[self.var_EAD.var_6AFE[param_01]]]();
}

func_9963() {
  self endon("death");
  level endon("game_ended");
  if(isDefined(self.owner)) {
    self endon("owner_disconnect");
    thread func_2DD5(self.owner);
  }

  self thread[[self.var_A8ED]]();
  thread func_6394();
  for(;;) {
    if(self.var_BA4 != "melee" && !self.statelocked && self[[level.var_31F5]]() && !self[[level.var_31B2]]()) {
      self selected_ent_buttons(self.var_28D2);
    }

    switch (self.var_BA4) {
      case "idle":
        func_A127();
        break;

      case "move":
        func_A13A();
        break;

      case "melee":
        func_A134();
        break;
    }

    wait 0.05;
  }
}

func_2EE7(param_00) {
  if(isDefined(self.var_28D2) && param_00 != self.var_28D2) {
    return 0;
  }

  if(!isDefined(self.var_5BD2) || !isDefined(self.var_5BD1)) {
    return 0;
  }

  if(distance2dsquared(param_00.origin, self.var_5BD2) > 4) {
    return 0;
  }

  if(self.var_1787) {
    return 1;
  }

  if(distancesquared(self.origin, self.var_5BD1) > 4096 && gettime() - self.var_5BD3 > 2000) {
    return 0;
  }

  return 1;
}

func_2EE6() {
  if(isDefined(self.var_5BBF) && isDefined(self.var_5BBE) && distance2dsquared(self.var_28D2.origin, self.var_5BBF) < 4 && distancesquared(self.origin, self.var_5BBE) < 2500) {
    return 1;
  }

  if(func_A7F8(0)) {
    return 1;
  }

  return 0;
}

func_37B8(param_00) {
  func_38ED(self.var_BA4);
  self.var_BA4 = param_00;
  switch (param_00) {
    case "idle":
      self.var_64CE = "idle";
      self.var_173C = 0;
      break;

    case "move":
      self.var_64CE = "follow";
      break;

    case "melee":
      break;

    default:
      break;
  }
}

func_38ED(param_00) {
  switch (param_00) {
    case "move":
      self.var_6DAD = undefined;
      break;

    default:
      break;
  }
}

func_A127() {
  func_A13C();
}

func_A13A() {
  func_A13C();
}

func_A134() {
  self method_8395(self.origin);
}

func_A13C() {
  if(self.var_17E8) {
    return;
  }

  self.var_76E1 = self.var_64CE;
  var_00 = undefined;
  var_01 = 0;
  var_02 = 0;
  var_03 = 500;
  if(self.var_173C && gettime() - self.var_5B75 < var_03) {
    if(isDefined(self.owner)) {
      self.var_64CE = "follow";
      var_01 = 1;
    } else {
      self.var_64CE = "idle";
      self method_8395(self.origin);
    }
  } else {
    self.var_64CE = func_4595();
  }

  if(self.var_64CE == "pursuit") {
    var_00 = self[[level.var_31F1]](self.enemy);
    var_04 = 0;
    if(isDefined(self.var_5B75) && gettime() - self.var_5B75 < 3000) {
      if(distance2dsquared(var_00, self.var_5B73) < 16) {
        var_04 = 1;
      } else if(isDefined(self.var_5B74) && self.var_5B74 == "pursuit" && distance2dsquared(self.var_5B76, self.enemy.origin) < 16) {
        var_04 = 1;
      }
    }

    if(var_04 || func_A7F8(1) || func_2EE7(self.enemy)) {
      if(isDefined(self.owner)) {
        self.var_64CE = "follow";
      } else {
        self.var_64CE = "idle";
        self method_8395(self.origin);
      }

      var_02 = 1;
    }
  }

  func_86F0(var_02);
  if(self.var_64CE == "follow") {
    self.var_28D2 = undefined;
    self.vectortoangles = func_44EA(self.vectortoangles);
    self.var_15E1 = 1;
    var_05 = self method_83E7();
    if(!isDefined(var_05)) {
      var_05 = self.origin;
    }

    if(self.owner.sessionstate == "spectator") {
      return;
    }

    if(gettime() - self.var_99FC < 5000) {
      var_01 = 1;
    }

    var_06 = self.owner getstance();
    if(!isDefined(self.owner.var_76E7) && isDefined(self.owner)) {
      self.owner.var_76E7 = var_06;
    }

    var_07 = !isDefined(self.var_6DAD) || distance2dsquared(self.var_6DAD, self.owner.origin) > 100;
    if(var_07) {
      self.var_6DAD = self.owner.origin;
    }

    var_08 = distance2dsquared(var_05, self.owner.origin);
    if(var_01 || (var_08 > self.var_6DAE && var_07) || self.owner.var_76E7 != var_06 || self.var_76E1 != "idle" && self.var_76E1 != self.var_64CE) {
      self method_8395(func_3B95());
      self.owner.var_76E7 = var_06;
      return;
    }

    return;
  }

  if(self.var_64CE == "pursuit") {
    self.var_28D2 = self.enemy;
    self.vectortoangles = "sprint";
    self.var_15E1 = 0;
    self method_8395(var_00);
  }
}

func_4595(param_00) {
  if(isDefined(self.enemy)) {
    if(isDefined(self.var_94) && self.enemy == self.var_94) {
      return "pursuit";
    }

    if(abs(self.origin[2] - self.enemy.origin[2]) < self.var_A85C && distance2dsquared(self.enemy.origin, self.origin) < self.var_11AD) {
      return "pursuit";
    }

    if(isDefined(self.var_28D2) && self.var_28D2 == self.enemy) {
      if(distance2dsquared(self.var_28D2.origin, self.origin) < self.var_59DE) {
        return "pursuit";
      }
    }
  } else if(isDefined(self.owner)) {
    return "follow";
  }

  return "idle";
}

func_86F0(param_00) {
  if(param_00) {
    if(!isDefined(self.var_5BD2)) {
      self.var_5BD2 = self.enemy.origin;
      self.var_5BD1 = self.origin;
      var_01 = maps / mp / agents / _scriptedagents::func_34A6(self.enemy.origin);
      self.var_1787 = !isDefined(var_01);
      self.var_5BD3 = gettime();
      return;
    }

    return;
  }

  self.var_5BD2 = undefined;
  self.var_5BD1 = undefined;
  self.var_1787 = undefined;
  self.var_5BD3 = undefined;
}

func_A692() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("bad_path", var_00);
    self.var_173C = 1;
    self.var_5B75 = gettime();
    self.var_5B73 = var_00;
    self.var_5B74 = self.var_64CE;
    if(self.var_64CE == "follow" && isDefined(self.owner)) {
      self.var_5B76 = self.owner.origin;
      continue;
    }

    if(self.var_64CE == "pursuit" && isDefined(self.enemy)) {
      self.var_5B76 = self.enemy.origin;
    }
  }
}

func_A6B1() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("path_set");
    self.var_173C = 0;
  }
}

func_44EA(param_00) {
  var_01 = -25536;
  var_02 = 65536;
  var_03 = self method_83E7();
  if(isDefined(var_03)) {
    var_04 = distancesquared(var_03, self.origin);
    if(param_00 == "run" || param_00 == "sprint") {
      if(var_04 < var_01) {
        return "fastwalk";
      } else if(param_00 == "sprint") {
        return "run";
      }
    } else if(param_00 == "fastwalk") {
      if(var_04 > var_02) {
        return "run";
      }
    }
  }

  return param_00;
}

func_5859(param_00) {
  var_01 = param_00[2] - self.origin[2];
  return var_01 <= self.var_11B8 && var_01 >= self.var_11B9;
}

func_A7F8(param_00) {
  if(!isDefined(self.var_28D2)) {
    return 0;
  }

  return !func_5859(self.var_28D2.origin) && distance2dsquared(self.origin, self.var_28D2.origin) < self.var_60F2 * 0.75 * 0.75 && !param_00 || self agentcanseesentient(self.var_28D2);
}

func_7AC0() {
  if(!isDefined(self.var_28D2)) {
    return 0;
  }

  if(!maps\mp\_utility::isreallyalive(self.var_28D2)) {
    return 0;
  }

  if(self.var_BA4 == "traverse") {
    return 0;
  }

  if(distance2dsquared(self.origin, self.var_28D2.origin) > self.var_60F2) {
    return 0;
  }

  if(!func_5859(self.var_28D2.origin)) {
    return 0;
  }

  return 1;
}

func_A7F7() {
  if(!isDefined(self.enemy)) {
    return 0;
  }

  if(abs(self.origin[2] - self.enemy.origin[2]) <= self.var_A85C || self agentcanseesentient(self.enemy)) {
    var_00 = distance2dsquared(self.origin, self.enemy.origin);
    if(var_00 < self.var_A85B) {
      return 1;
    }
  }

  return 0;
}

func_442A(param_00) {
  var_01 = param_00.origin - self.origin;
  var_01 = vectorNormalize(var_01);
  var_02 = self method_83E7();
  var_03 = self.var_11AB + 4;
  if(isDefined(var_02) && distance2dsquared(var_02, param_00.origin) < var_03 * var_03 && maps / mp / agents / _scriptedagents::func_1F5B(param_00.origin, var_02)) {
    return var_02;
  }

  var_04 = param_00.origin - var_01 * self.var_11AB;
  var_04 = maps / mp / agents / _scriptedagents::func_34A6(var_04);
  if(!isDefined(var_04)) {
    return param_00.origin;
  }

  if(!maps / mp / agents / _scriptedagents::func_1F5B(param_00.origin, var_04)) {
    var_05 = anglesToForward(param_00.angles);
    var_04 = param_00.origin + var_05 * self.var_11AB;
    if(!maps / mp / agents / _scriptedagents::func_1F5B(param_00.origin, var_04)) {
      return param_00.origin;
    }
  }

  return var_04;
}

func_285C(param_00, param_01) {
  return param_00[0] * param_01[1] - param_01[0] * param_00[1];
}

func_3B95() {
  var_00 = vectorNormalize(self.origin - self.owner.origin);
  var_01 = anglesToForward(self.owner.angles);
  var_01 = (var_01[0], var_01[1], 0);
  var_01 = vectorNormalize(var_01);
  var_02 = func_285C(var_00, var_01);
  var_03 = function_00BA(self.owner.origin);
  if(!isDefined(var_03)) {
    return self.origin;
  }

  var_04 = function_0204(var_03);
  var_05 = 5;
  var_06 = 10;
  var_07 = 15;
  var_08 = -15;
  var_09 = gettime() - self.var_99FC < 5000;
  var_0A = 0;
  var_0B = 0;
  var_04[var_04.size] = var_03;
  foreach(var_0D in var_04) {
    var_0E = 0;
    var_0F = var_0D.origin - self.owner.origin;
    var_10 = length(var_0F);
    if(var_10 >= self.var_7673) {
      var_0E = var_0E + var_05;
    } else if(var_10 < self.var_621C) {
      var_11 = 1 - self.var_621C - var_10 / self.var_621C;
      var_0E = var_0E + var_05 * var_11 * var_11;
    } else {
      var_0E = var_0E + var_05 * var_10 / self.var_7673;
    }

    if(var_10 == 0) {
      var_10 = 1;
    }

    var_0F = var_0F / var_10;
    var_12 = vectordot(var_01, var_0F);
    var_13 = self.owner getstance();
    switch (var_13) {
      case "stand":
        if(var_12 < cos(35) && var_12 > cos(45)) {
          var_0E = var_0E + var_06;
        }
        break;

      case "crouch":
        if(var_12 < cos(75) && var_12 > cos(90)) {
          var_0E = var_0E + var_06;
        }
        break;

      case "prone":
        if(var_12 < cos(125) && var_12 > cos(135)) {
          var_0E = var_0E + var_06;
        }
        break;
    }

    var_14 = func_285C(var_0F, var_01);
    if(var_14 * var_02 > 0) {
      var_0E = var_0E + var_07;
    }

    if(var_09) {
      var_15 = vectordot(self.var_29BC, var_0F);
      var_0E = var_0E + var_15 * var_08;
    }

    if(var_0E > var_0A) {
      var_0A = var_0E;
      var_0B = var_0D;
    }
  }

  if(!isDefined(var_0B)) {
    return self.origin;
  }

  var_17 = var_0B.origin - self.owner.origin;
  var_18 = length(var_17);
  if(var_18 > self.var_7673) {
    var_19 = var_03.origin - self.owner.origin;
    if(vectordot(var_19, var_17 / var_18) < 0) {
      var_1A = var_0B.origin;
    } else {
      var_1B = vectorNormalize(var_0B.origin - var_03.origin);
      var_1A = var_03.origin + var_1B * self.var_7673;
    }
  } else {
    var_1A = var_0C.origin;
  }

  var_1A = maps / mp / agents / _scriptedagents::func_34A6(var_1A);
  if(!isDefined(var_1A)) {
    return self.origin;
  }

  if(self.var_173C && distance2dsquared(var_1A, self.var_5B73) < 4) {
    return self.origin;
  }

  return var_1A;
}

func_2DD5(param_00) {
  self endon("death");
  param_00 common_scripts\utility::waittill_any("disconnect", "joined_team");
  self notify("owner_disconnect");
  if(maps\mp\gametypes\_hostmigration::func_A782()) {
    wait 0.05;
  }

  self notify("killanimscript");
  if(isDefined(self.var_EAD.var_6B2F[self.var_BA4])) {
    self[[self.var_EAD.var_6B2F[self.var_BA4]]]();
  }

  self suicide();
}

func_A8EC() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    if(self.var_BA4 == "melee") {
      if(self.var_11B5 != "melee") {
        self.var_11B5 = "melee";
        func_8728(undefined);
      }
    } else if(self.var_64CE == "pursuit") {
      if(self.var_11B5 != "attacking") {
        self.var_11B5 = "attacking";
        func_8728("bark", "attacking");
      }
    } else if(self.var_11B5 != "warning") {
      if(func_A7F7()) {
        self.var_11B5 = "warning";
        func_8728("growl", "warning");
      } else {
        self.var_11B5 = self.var_BA4;
        func_8728("pant");
      }
    } else if(!func_A7F7()) {
      self.var_11B5 = self.var_BA4;
      func_8728("pant");
    }

    wait 0.05;
  }
}

func_8728(param_00, param_01) {
  if(!isDefined(param_00)) {
    self notify("end_dog_sound");
    self.var_8F4B = undefined;
    return;
  }

  if(!isDefined(self.var_8F4B) || self.var_8F4B != param_00) {
    self notify("end_dog_sound");
    self.var_8F4B = param_00;
    if(param_00 == "bark") {
      thread func_7202(param_01);
      return;
    }

    if(param_00 == "growl") {
      thread func_74A6(param_01);
      return;
    }

    if(param_00 == "pant") {
      thread func_74CD();
      return;
    }

    return;
  }
}

func_7202(param_00) {
  self endon("death");
  level endon("game_ended");
  self endon("end_dog_sound");
  if(!isDefined(self.var_159D)) {
    self.var_159D = 1;
    thread func_A8EF();
  }
}

func_A8EF() {
  self endon("death");
  level endon("game_ended");
  self endon("end_dog_sound");
  wait(randomintrange(5, 10));
  self.var_159D = undefined;
}

func_74A6(param_00) {
  self endon("death");
  level endon("game_ended");
  self endon("end_dog_sound");
  if(isDefined(self.var_5BA5) && gettime() - self.var_5BA5 < 3000) {
    wait(3);
  }

  for(;;) {
    self.var_5BA5 = gettime();
    wait(randomintrange(3, 6));
  }
}

func_74CD(param_00) {
  self endon("death");
  level endon("game_ended");
  self endon("end_dog_sound");
  if(isDefined(self.var_5BC9) && gettime() - self.var_5BC9 < 3000) {
    wait(3);
  }

  self.var_5BC9 = gettime();
  for(;;) {
    if(self.var_BA4 == "idle") {
      wait(3);
      continue;
    }

    self.var_5BC9 = gettime();
    wait(randomintrange(6, 8));
  }
}

func_A92D() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    if(!isDefined(self.owner)) {
      return;
    }

    self.owner waittill("damage", var_00, var_01);
    if(isPlayer(var_01) && var_01 != self.owner) {
      if(self.var_11B5 == "attacking") {
        continue;
      }

      if(distancesquared(self.owner.origin, self.origin) > self.var_6DAB) {
        continue;
      }

      if(distancesquared(self.owner.origin, var_01.origin) > self.var_6DAB) {
        continue;
      }

      self.var_94 = var_01;
      self.var_3E0B = 1;
      thread func_A909();
    }
  }
}

func_A92E() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    if(!isDefined(self.owner)) {
      return;
    }

    self.owner waittill("death");
    switch (level.gametype) {
      case "sd":
        maps / mp / agents / _agent_utility::func_5A39();
        break;

      case "sr":
        var_00 = level common_scripts\utility::waittill_any_return("sr_player_eliminated", "sr_player_respawned");
        if(isDefined(var_00) && var_00 == "sr_player_eliminated") {
          maps / mp / agents / _agent_utility::func_5A39();
        }
        break;
    }
  }
}

func_A92F() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    if(!isDefined(self.owner)) {
      return;
    }

    var_00 = self.owner common_scripts\utility::waittill_any_return_no_endon_death("joined_team", "joined_spectators");
    if(isDefined(var_00) && var_00 == "joined_team" || var_00 == "joined_spectators") {
      maps / mp / agents / _agent_utility::func_5A39();
    }
  }
}

func_A909() {
  self notify("watchFavoriteEnemyDeath");
  self endon("watchFavoriteEnemyDeath");
  self endon("death");
  self.var_94 common_scripts\utility::func_A71A(5, "death", "disconnect");
  self.var_94 = undefined;
  self.var_3E0B = 0;
}

func_6ADB(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  self.var_99FC = gettime();
  if(isDefined(self.owner)) {
    self.var_29BC = vectorNormalize(self.origin - self.owner.origin);
  }

  if(func_8B9B(param_02, param_05, param_04)) {
    switch (self.var_BA4) {
      case "idle":
        thread maps / mp / agents / dog / _dog_idle::func_6ADB(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
        break;

      case "move":
        thread maps / mp / agents / dog / _dog_move::func_6ADB(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
        break;
    }
  }
}

func_8B9B(param_00, param_01, param_02) {
  if(isDefined(param_01) && function_01AA(param_01) == "sniper") {
    return 1;
  }

  if(isDefined(param_02) && isexplosivedamagemod(param_02) && param_00 >= 10) {
    return 1;
  }

  if(isDefined(param_02) && param_02 == "MOD_MELEE") {
    return 1;
  }

  if(isDefined(param_01) && param_01 == "concussion_grenade_mp") {
    return 1;
  }

  return 0;
}

func_6394() {
  self endon("death");
  for(;;) {
    self waittill("flashbang", var_00, var_01, var_02, var_03, var_04, var_05);
    if(isDefined(var_03) && var_03 == self.owner) {
      continue;
    }

    switch (self.var_BA4) {
      case "idle":
        maps / mp / agents / dog / _dog_idle::func_6B3B();
        break;

      case "move":
        maps / mp / agents / dog / _dog_move::func_6B3B();
        break;
    }
  }
}