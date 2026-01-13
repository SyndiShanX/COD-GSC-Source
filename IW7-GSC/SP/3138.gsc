/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3138.gsc
*********************************************/

func_35A6(var_0, var_1, var_2, var_3) {
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
  self._blackboard.movetype = "combat";
  self._blackboard.var_A983 = 0;
  self._blackboard.timeoff = -99999;
  self.var_358 = 0.1;
  self.iscinematicplaying = 0;
  self.var_27F7 = 1;
  if(isDefined(self.var_13CC3)) {
    self.var_13C83 = [];
    foreach(var_6, var_5 in self.var_13CC3) {
      self.var_13C83[var_6] = 1;
      self.bt.var_13C83[var_6] = 1;
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
      foreach(var_1 in level.player.var_4759.var_19) {
        if(distance2dsquared(self.origin, var_1.origin) <= squared(180)) {
          scripts\sp\coverwall::func_475C(var_1, 1);
          wait(0.05);
        }
      }

      wait(0.5);
    }

    wait(0.25);
  }
}

func_6C00() {}

draw_axis(var_0, var_1) {
  var_2 = 25;
  var_3 = anglesToForward(var_1) * var_2;
  var_4 = anglestoright(var_1) * var_2;
  var_5 = anglestoup(var_1) * var_2;
  func_1215(var_0, var_0 + var_3, (1, 0, 0));
  func_1215(var_0, var_0 + var_5, (0, 1, 0));
  func_1215(var_0, var_0 + var_4, (0, 0, 1));
}

func_1215(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_1 - var_0);
  var_4 = length(var_1 - var_0);
  var_5 = anglesToForward(var_3);
  var_6 = var_5 * var_4;
  var_7 = 5;
  var_8 = var_5 * var_4 - var_7;
  var_9 = anglestoright(var_3);
  var_0A = var_9 * var_7 * -1;
  var_0B = var_9 * var_7;
}

func_E75A(var_0, var_1) {
  return (func_E756(var_0[0], var_1), func_E756(var_0[1], var_1), func_E756(var_0[2], var_1));
}

func_E756(var_0, var_1) {
  return int(var_0 * var_1) / var_1;
}

func_35E3(var_0, var_1, var_2, var_3) {
  if(issubstr(var_0, "_left")) {
    self.var_164D[var_0].slot = "left";
    return;
  }

  if(issubstr(var_0, "_right")) {
    self.var_164D[var_0].slot = "right";
    return;
  }
}

func_3514(var_0, var_1, var_2, var_3) {
  var_4 = self.var_164D[var_0].slot;
  if(!isDefined(var_4)) {
    return 0;
  }

  if(!isDefined(self.var_13CC3[var_4])) {
    return 0;
  }

  return self.var_13CC3[var_4] == var_3;
}

func_3518(var_0) {
  var_1 = self._blackboard.shootparams;
  if(!isDefined(var_1)) {
    return 0;
  }

  foreach(var_4, var_3 in self.var_13CC3) {
    if(var_4 == var_0) {
      return isDefined(var_1.var_13CC3[var_4]);
    }
  }

  return 0;
}

func_3519(var_0, var_1, var_2, var_3) {
  return !func_351A(var_0, var_1, var_2, var_3);
}

func_351A(var_0, var_1, var_2, var_3) {
  var_4 = self._blackboard.shootparams;
  if(!isDefined(var_4)) {
    return 0;
  }

  var_5 = self.var_164D[var_0].slot;
  if(var_5 == "left") {
    var_6 = "left_arm";
  } else {
    var_6 = "right_arm";
  }

  if(scripts\asm\asm_bb::ispartdismembered(var_6)) {
    return 0;
  }

  if(!isDefined(self.var_13CC3[var_5]) || self.var_13CC3[var_5] != var_3) {
    return 0;
  }

  return lib_0C08::func_10079(var_5);
}

func_3515(var_0, var_1, var_2, var_3) {
  return !func_3516(var_0, var_1, var_2, var_3);
}

func_3516(var_0, var_1, var_2, var_3) {
  var_4 = self._blackboard.shootparams;
  if(!isDefined(var_4)) {
    return 0;
  }

  var_5 = self.var_164D[var_0].slot;
  if(var_5 == "left") {
    var_6 = "left_arm";
  } else {
    var_6 = "right_arm";
  }

  if(scripts\asm\asm_bb::ispartdismembered(var_6)) {
    return 0;
  }

  if(!isDefined(self.var_13CC3[var_5]) || self.var_13CC3[var_5] != var_3) {
    return 0;
  }

  return lib_0C08::func_A004(var_5);
}

func_3517(var_0, var_1, var_2, var_3) {
  var_4 = self.var_164D[var_0].var_4C1A;
  return !isDefined(var_4) || isDefined(var_4.var_2720);
}

func_35AE(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::ispartdismembered(var_3);
}