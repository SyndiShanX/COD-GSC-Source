/***************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombie_entrances.gsc
***************************************************/

init_zombie_entrances() {
  level.var_13D37 = [];
  level.window_entrances = scripts\engine\utility::getstructarray("window_entrance", "targetname");
  scripts\engine\utility::array_thread(level.window_entrances, ::func_97A8);
}

func_4F32() {
  wait(5);
  for(;;) {
    var_00 = scripts\engine\utility::getclosest(level.players[0].origin, level.window_entrances);
    var_01 = scripts\engine\utility::getstructarray(var_00.target, "targetname");
    var_01 = scripts\engine\utility::array_add_safe(var_01, var_00);
    foreach(var_03 in var_01) {
      var_04 = 0;
      if(isDefined(var_03.angles)) {
        var_04 = var_03.angles[1];
      }

      var_05 = (0, 1, 0);
      if(func_9CD3(var_03)) {
        var_05 = (1, 0, 0);
      }
    }

    wait(0.25);
  }
}

func_97A8() {
  self.enabled = 0;
  self.var_C2D0 = undefined;
  var_00 = getEntArray(self.target, "targetname");
  if(var_00.size) {
    foreach(var_02 in var_00) {
      if(isDefined(var_02.script_noteworthy) && var_02.script_noteworthy == "clip") {
        self.clip = var_02;
        continue;
      }

      self.barrier = var_02;
    }
  }

  self.barrier.var_C1DE = 6;
  self.barrier.var_2BEB = [];
  self.barrier.var_2BEB[0] = "boarded";
  self.barrier.var_2BEB[1] = "boarded";
  self.barrier.var_2BEB[2] = "boarded";
  self.barrier.var_2BEB[3] = "boarded";
  self.barrier.var_2BEB[4] = "boarded";
  self.barrier.var_2BEB[5] = "boarded";
  var_04 = scripts\engine\utility::getstructarray(self.target, "targetname");
  foreach(var_06 in var_04) {
    if(isDefined(var_06.script_noteworthy) && var_06.script_noteworthy == "attack_spot") {
      self.attack_position = var_06;
      continue;
    }

    var_06.var_C2D0 = undefined;
    var_06.enabled = 0;
    level.var_13D37[level.var_13D37.size] = var_06;
  }

  level.var_13D37[level.var_13D37.size] = self;
  var_08 = scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getstructarray("secure_window", "script_noteworthy"));
  self.script_noteworthy = func_7D7E(var_08);
  self.script_label = "mid";
  if(isDefined(self.var_EED9) && self.var_EED9 == "extended") {
    self.var_2A9F = 1;
  }

  var_09 = anglestoright(self.angles);
  foreach(var_06 in var_04) {
    var_0B = var_06.origin - self.origin;
    var_0C = vectordot(var_0B, var_09);
    if(var_0C > 0) {
      var_06.script_label = "left";
    } else {
      var_06.script_label = "right";
    }

    if(scripts\engine\utility::istrue(self.var_2A9F)) {
      var_06.var_2A9F = 1;
    }
  }
}

func_7D7E(param_00) {
  var_01 = getEntArray("spawn_volume", "targetname");
  foreach(var_03 in var_01) {
    if(ispointinvolume(param_00.origin, var_03)) {
      return var_03.destroynavobstacle;
    }
  }

  return undefined;
}

func_6259(param_00) {
  param_00.enabled = 1;
  param_00.var_C2D0 = undefined;
  var_01 = scripts\engine\utility::getstructarray(param_00.target, "targetname");
  foreach(var_03 in var_01) {
    var_03.var_C2D0 = undefined;
    var_03.enabled = 1;
  }
}

func_55A8(param_00) {
  param_00.enabled = 0;
  param_00.var_C2D0 = undefined;
  var_01 = scripts\engine\utility::getstructarray(param_00.target, "targetname");
  foreach(var_03 in var_01) {
    var_03.var_C2D0 = undefined;
    var_03.enabled = 0;
  }
}

enable_windows_in_area(param_00) {
  var_01 = scripts\engine\utility::getstructarray(param_00, "script_noteworthy");
  foreach(var_03 in var_01) {
    func_6259(var_03);
  }
}

func_7998(param_00, param_01) {
  for(var_02 = 0; var_02 < param_00.var_130C8; var_02++) {
    if(param_00.var_130D0[var_02] == param_01) {
      return var_02;
    }
  }

  return undefined;
}

func_E005(param_00) {
  if(!isDefined(param_00.var_130D0)) {
    return;
  }

  var_01 = func_7998(param_00, self);
  if(!isDefined(var_01)) {
    return;
  }

  if(param_00.var_130C8 == 1) {
    param_00.var_130D0 = [];
    param_00.var_130C8 = 0;
    return;
  }

  param_00.var_130D0[var_01] = param_00.var_130D0[param_00.var_130C8 - 1];
  param_00.var_130D0[param_00.var_130C8 - 1] = undefined;
  param_00.var_130C8--;
}

func_16D1(param_00) {
  func_E005(param_00);
  if(!isDefined(param_00.var_130D0)) {
    param_00.var_130D0 = [];
    param_00.var_130C8 = 0;
  }

  var_01 = param_00.var_130C8;
  param_00.var_130D0[var_01] = self;
  param_00.var_130C8++;
}

func_61D1() {
  foreach(var_01 in level.window_entrances) {
    func_6259(var_01);
  }
}

func_7B4D(param_00) {
  var_01 = scripts\engine\utility::get_array_of_closest(param_00, level.window_entrances);
  foreach(var_03 in var_01) {
    if(!entrance_has_barriers(var_03)) {
      return var_03;
    }
  }

  return undefined;
}

func_7B14(param_00, param_01) {
  var_02 = sortbydistance(level.window_entrances, param_00);
  foreach(var_04 in var_02) {
    if(isDefined(param_01)) {
      if(var_04 == param_01) {
        param_01 = undefined;
      }

      continue;
    }

    if(var_04.enabled) {
      return var_04;
    }
  }

  return undefined;
}

func_9BD6(param_00) {
  return param_00.enabled;
}

entrance_has_barriers(param_00) {
  if(isDefined(param_00.barrier) && param_00.barrier.var_C1DE > 0) {
    return 1;
  }

  return 0;
}

release_attack_spot(param_00) {
  param_00.var_C2D0 = undefined;
}

func_3FF0(param_00) {
  param_00.var_C2D0 = self;
}

func_9CD3(param_00) {
  if(isDefined(param_00.var_C2D0) && isalive(param_00.var_C2D0)) {
    return 1;
  }

  return 0;
}

func_9CD2(param_00) {
  return !func_9CD3(param_00);
}

func_F95E() {
  var_00 = anglestoright(self.angles);
  var_01 = scripts\engine\utility::getstructarray(self.target, "targetname");
  foreach(var_03 in var_01) {
    var_04 = var_03.origin - self.origin;
    var_05 = vectordot(var_04, var_00);
    if(var_05 > 0) {
      self.var_E529 = var_03;
      continue;
    }

    self.var_AB4E = var_03;
  }
}

func_36CF() {
  var_00 = (0, 0, 0);
  foreach(var_02 in self.var_130D0) {
    var_00 = var_00 + var_02.origin;
  }

  var_04 = (var_00[0] / self.var_130C8, var_00[1] / self.var_130C8, var_00[2] / self.var_130C8);
  var_05 = sortbydistance(self.var_130D0, var_04);
  return var_05[0];
}

func_9CF6(param_00, param_01) {
  var_02 = self.origin - param_00.origin;
  var_03 = (var_02[0], var_02[1], 0);
  var_04 = vectordot(var_03, param_01);
  if(var_04 > 0) {
    return 1;
  }

  return 0;
}

func_7A29(param_00) {
  if(!isDefined(param_00.var_AB4E) && !isDefined(param_00.var_E529)) {
    param_00 func_F95E();
  }

  if(param_00.var_130C8 <= 1) {
    return param_00;
  }

  if(param_00.var_130C8 > 1) {
    var_02 = param_00 func_36CF();
    var_03 = anglestoright(param_00.angles);
    var_04 = anglestoleft(param_00.angles);
    if(self == var_02) {
      return param_00;
    }

    if(isDefined(param_00.var_E529) && func_9CF6(var_02, var_03)) {
      return param_00.var_E529;
    }

    if(isDefined(param_00.var_AB4E) && func_9CF6(var_02, var_04)) {
      return param_00.var_AB4E;
    }
  }

  var_05 = scripts\engine\utility::getstructarray(param_00.target, "targetname");
  var_05 = scripts\engine\utility::array_add_safe(var_05, param_00);
  var_06 = sortbydistance(var_05, self.origin);
  return var_06[0];
}

get_open_attack_spot(param_00) {
  var_01 = func_7A29(param_00);
  if(isDefined(var_01) && func_9CD2(var_01)) {
    return var_01;
  }

  var_02 = scripts\engine\utility::getstructarray(param_00.target, "targetname");
  var_02 = scripts\engine\utility::array_add_safe(var_02, param_00);
  var_02 = scripts\engine\utility::array_randomize(var_02);
  foreach(var_04 in var_02) {
    if(func_9CD2(var_04)) {
      return var_04;
    }
  }

  if(isDefined(var_01)) {
    return var_01;
  }

  return scripts\engine\utility::random(var_02);
}

func_F2E3(param_00, param_01, param_02) {
  param_00.barrier.var_2BEB[param_01] = param_02;
}

func_7872(param_00, param_01) {
  return param_00.barrier.var_2BEB[param_01];
}

func_7B12(param_00) {
  for(var_01 = 0; var_01 < 6; var_01++) {
    if(param_00.barrier.var_2BEB[var_01] == "boarded") {
      return var_01 + 1;
    }
  }
}

func_7B13(param_00) {
  for(var_01 = 5; var_01 >= 0; var_01--) {
    if(param_00.barrier.var_2BEB[var_01] == "destroyed") {
      return var_01 + 1;
    }
  }
}

remove_barrier_from_entrance(param_00, param_01) {
  if(!entrance_has_barriers(param_00)) {
    return;
  }

  var_02 = scripts\engine\utility::getstructarray("secure_window", "script_noteworthy");
  var_03 = scripts\engine\utility::getclosest(param_00.origin, var_02);
  if(!isDefined(param_01)) {
    param_01 = param_00.barrier.var_C1DE;
    if(param_01 > 6) {
      param_01 = 6;
    } else if(param_01 < 1) {
      param_01 = 1;
    }
  }

  param_00.barrier func_F2D7("board_" + param_01, "destroy");
  param_00.barrier.var_C1DE--;
  if(!scripts\engine\utility::array_contains(level.current_interaction_structs, var_03)) {
    level.current_interaction_structs = scripts\engine\utility::array_add(level.current_interaction_structs, var_03);
  }

  var_03.disabled = 0;
  if(param_00.barrier.var_C1DE < 1) {
    var_03.disabled = 0;
  }
}

func_F2D7(param_00, param_01) {
  if(param_00 == "all" && param_01 == "rebuild") {
    self setscriptablepartstate("board_1", "instant_rebuild");
    self setscriptablepartstate("board_2", "instant_rebuild");
    self setscriptablepartstate("board_3", "instant_rebuild");
    self setscriptablepartstate("board_4", "instant_rebuild");
    self setscriptablepartstate("board_5", "instant_rebuild");
    self setscriptablepartstate("board_6", "instant_rebuild");
    return;
  }

  self setscriptablepartstate(param_00, param_01);
}