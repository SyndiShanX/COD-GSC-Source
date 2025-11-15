/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3138.gsc
************************/

func_35A6(param_00, param_01, param_02, param_03) {
  if(!isDefined(level.var_362A)) {
    lib_0C41::func_3629();
  }

  self.allowpain = 0;
  self.asm.var_7360 = 0;
  self.asm.var_4C86 = spawnStruct();
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.var_BC = "no_cover";
  self.objective_state_nomessage = 0;
  self.setthermalbodymaterial = 1024;
  self.nodetoentitysighttest = 164;
  scripts\asm\asm::func_237B(1);
  self.var_1A48 = 1;
  self.var_1198.movetype = "combat";
  self.var_1198.var_A983 = 0;
  self.var_1198.timeoff = -99999;
  self.var_358 = 0.1;
  self.iscinematicplaying = 0;
  self.var_27F7 = 1;
  if(isDefined(self.var_13CC3)) {
    self.var_13C83 = [];
    foreach(var_06, var_05 in self.var_13CC3) {
      self.var_13C83[var_06] = 1;
      self.var_3135.var_13C83[var_06] = 1;
    }
  }

  thread lib_0C46::func_3535();
  thread lib_0C46::func_3620();
  thread func_352E();
}

func_352E() {
  self endon("death");
  for(;;) {
    if(!isDefined(level.player.var_4759)) {
      wait(1);
      continue;
    }

    if(isDefined(level.player.var_4759.var_19) && level.player.var_4759.var_19.size) {
      foreach(var_01 in level.player.var_4759.var_19) {
        if(distance2dsquared(self.origin, var_01.origin) <= squared(180)) {
          scripts\sp\coverwall::func_475C(var_01, 1);
          wait(0.05);
        }
      }

      wait(0.5);
    }

    wait(0.25);
  }
}

func_6C00() {}

draw_axis(param_00, param_01) {
  var_02 = 25;
  var_03 = anglesToForward(param_01) * var_02;
  var_04 = anglestoright(param_01) * var_02;
  var_05 = anglestoup(param_01) * var_02;
  func_1215(param_00, param_00 + var_03, (1, 0, 0));
  func_1215(param_00, param_00 + var_05, (0, 1, 0));
  func_1215(param_00, param_00 + var_04, (0, 0, 1));
}

func_1215(param_00, param_01, param_02) {
  var_03 = vectortoangles(param_01 - param_00);
  var_04 = length(param_01 - param_00);
  var_05 = anglesToForward(var_03);
  var_06 = var_05 * var_04;
  var_07 = 5;
  var_08 = var_05 * var_04 - var_07;
  var_09 = anglestoright(var_03);
  var_0A = var_09 * var_07 * -1;
  var_0B = var_09 * var_07;
}

func_E75A(param_00, param_01) {
  return (func_E756(param_00[0], param_01), func_E756(param_00[1], param_01), func_E756(param_00[2], param_01));
}

func_E756(param_00, param_01) {
  return int(param_00 * param_01) / param_01;
}

func_35E3(param_00, param_01, param_02, param_03) {
  if(issubstr(param_00, "_left")) {
    self.var_164D[param_00].slot = "left";
    return;
  }

  if(issubstr(param_00, "_right")) {
    self.var_164D[param_00].slot = "right";
    return;
  }
}

func_3514(param_00, param_01, param_02, param_03) {
  var_04 = self.var_164D[param_00].slot;
  if(!isDefined(var_04)) {
    return 0;
  }

  if(!isDefined(self.var_13CC3[var_04])) {
    return 0;
  }

  return self.var_13CC3[var_04] == param_03;
}

func_3518(param_00) {
  var_01 = self.var_1198.shootparams;
  if(!isDefined(var_01)) {
    return 0;
  }

  foreach(var_04, var_03 in self.var_13CC3) {
    if(var_04 == param_00) {
      return isDefined(var_01.var_13CC3[var_04]);
    }
  }

  return 0;
}

func_3519(param_00, param_01, param_02, param_03) {
  return !func_351A(param_00, param_01, param_02, param_03);
}

func_351A(param_00, param_01, param_02, param_03) {
  var_04 = self.var_1198.shootparams;
  if(!isDefined(var_04)) {
    return 0;
  }

  var_05 = self.var_164D[param_00].slot;
  if(var_05 == "left") {
    var_06 = "left_arm";
  } else {
    var_06 = "right_arm";
  }

  if(scripts\asm\asm_bb::ispartdismembered(var_06)) {
    return 0;
  }

  if(!isDefined(self.var_13CC3[var_05]) || self.var_13CC3[var_05] != param_03) {
    return 0;
  }

  return lib_0C08::func_10079(var_05);
}

func_3515(param_00, param_01, param_02, param_03) {
  return !func_3516(param_00, param_01, param_02, param_03);
}

func_3516(param_00, param_01, param_02, param_03) {
  var_04 = self.var_1198.shootparams;
  if(!isDefined(var_04)) {
    return 0;
  }

  var_05 = self.var_164D[param_00].slot;
  if(var_05 == "left") {
    var_06 = "left_arm";
  } else {
    var_06 = "right_arm";
  }

  if(scripts\asm\asm_bb::ispartdismembered(var_06)) {
    return 0;
  }

  if(!isDefined(self.var_13CC3[var_05]) || self.var_13CC3[var_05] != param_03) {
    return 0;
  }

  return lib_0C08::func_A004(var_05);
}

func_3517(param_00, param_01, param_02, param_03) {
  var_04 = self.var_164D[param_00].var_4C1A;
  return !isDefined(var_04) || isDefined(var_04.var_2720);
}

func_35AE(param_00, param_01, param_02, param_03) {
  return scripts\asm\asm_bb::ispartdismembered(param_03);
}