/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\door.gsc
*********************************************/

func_5A09() {
  self endon("killanimscript");
  if(isDefined(self.var_55DA)) {
    return;
  }

  for(;;) {
    var_0 = self _meth_811E();
    if(isDefined(var_0)) {
      break;
    }

    wait(0.2);
  }

  var_1 = var_0.type == "Door Interior" || self getpotentiallivingplayers(var_0);
  if(var_1) {
    func_5A06(var_0);
  } else {
    func_5A0A(var_0);
  }

  for(;;) {
    var_2 = self _meth_811E();
    if(!isDefined(var_2) || var_2 != var_0) {
      break;
    }

    wait(0.2);
  }

  thread func_5A09();
}

func_115CD() {
  self endon("killanimscript");
  self.var_115CE = 1;
  wait(5);
  self.var_115CE = undefined;
}

func_5817(var_0) {
  thread func_115CD();
  if(self.objective_team == "flash_grenade") {
    self notify("flashbang_thrown");
  }

  self orientmode("face current");
  var_0.var_BF7D = gettime() + 5000;
  self.var_B7B5 = gettime() + 100000;
  self notify("move_interrupt");
  self.var_12DEF = undefined;
  self clearanim( % combatrun, 0.2);
  self.a.movement = "stop";
  self waittill("done_grenade_throw");
  self orientmode("face default");
  self.var_B7B5 = gettime() + 5000;
  self.objective_team = self.var_C3F2;
  self.var_C3F2 = undefined;
  scripts\anim\run::func_6318();
  thread scripts\anim\move::func_C968();
  thread scripts\anim\move::func_E2B4(1);
}

func_5A08(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;
  var_6 = 3;
  var_7 = undefined;
  var_8 = anglesToForward(var_0.angles);
  if(var_0.type == "Door Interior" && !self getpotentiallivingplayers(var_0)) {
    var_8 = -1 * var_8;
  }

  var_9 = (var_0.origin[0], var_0.origin[1], var_0.origin[2] + 64);
  var_0A = var_9;
  if(var_2) {
    var_0B = anglestoright(var_0.angles);
    var_0C = var_0.origin - self.origin;
    var_0D = vectordot(var_0B, var_0C);
    if(var_0D > 20) {
      var_0D = 20;
    } else if(var_0D < -20) {
      var_0D = -20;
    }

    var_0A = var_9 + var_0D * var_0B;
  }

  while(var_6 > 0) {
    if(isDefined(self.objective_position) || !isDefined(self.isnodeoccupied)) {
      return;
    }

    if(func_C586(var_0, var_8)) {
      return;
    }

    if(!self seerecently(self.isnodeoccupied, 0.2) && self.a.pose == "stand" && func_56F2(self.isnodeoccupied.origin - var_0.origin, 360000, 16384)) {
      if(isDefined(var_0.var_BF7D) && var_0.var_BF7D > gettime()) {
        return;
      }

      if(self canshootenemy()) {
        return;
      }

      var_0C = var_0.origin - self.origin;
      if(lengthsquared(var_0C) < var_3) {
        return;
      }

      if(vectordot(var_0C, var_8) < 0) {
        return;
      }

      self.var_C3F2 = self.objective_team;
      self.objective_team = var_1;
      scripts\anim\combat_utility::func_F62B(self.isnodeoccupied);
      if(!var_5) {
        var_0E = var_9 + var_8 * 100;
        if(!self _meth_81A2(self.isnodeoccupied, var_0E, 128)) {
          return;
        }
      }

      var_5 = 1;
      if(scripts\anim\combat_utility::trygrenadethrow(self.isnodeoccupied, var_0A, var_7, scripts\anim\combat_utility::func_7EE8(var_7), 1, 0, 1)) {
        func_5817(var_0);
        return;
      }
    }

    var_6--;
    wait(var_4);
    var_0F = self _meth_811E();
    if(!isDefined(var_0F) || var_0F != var_0) {
      return;
    }
  }
}

func_940A() {
  self endon("killanimscript");
  if(isDefined(self.var_55DA)) {
    return;
  }

  self.var_9E45 = 0;
  for(;;) {
    if(self _meth_81A4() && !self.var_FC) {
      func_5A07();
    } else if(!isDefined(self.var_B7B5) || self.var_B7B5 < gettime()) {
      self.var_B7B5 = undefined;
      func_5A0B();
    }

    wait(0.2);
  }
}

func_5A07() {
  if(!isDefined(self.var_BEF7) && !self.var_FC) {
    self.var_9E45 = 1;
    if(!scripts\anim\utility::func_9D9B()) {
      scripts\sp\utility::func_61E7(1);
    }
  }
}

func_5A0B() {
  if(!isDefined(self.var_4797)) {
    self.var_9E45 = 0;
    if(scripts\anim\utility::func_9D9B()) {
      scripts\sp\utility::func_5514();
    }
  }
}

func_56F2(var_0, var_1, var_2) {
  return var_0[0] * var_0[0] + var_0[1] * var_0[1] < var_1 && var_0[2] * var_0[2] < var_2;
}

func_C586(var_0, var_1) {
  var_2 = var_0.origin - self.origin;
  var_3 = var_0.origin - self.isnodeoccupied.origin;
  return vectordot(var_2, var_1) * vectordot(var_3, var_1) > 0;
}

func_5A06(var_0) {
  for(;;) {
    if(isDefined(self.var_5A0F) && self.var_5A0F == 0 || self.var_5A0F < randomfloat(1)) {
      break;
    }

    if(func_56F2(self.origin - var_0.origin, 562500, 25600)) {
      func_5A08(var_0, "fraggrenade", 0, 302500, 0.3);
      var_0 = self _meth_811E();
      if(!isDefined(var_0)) {
        return;
      }

      break;
    }

    wait(0.1);
  }

  for(;;) {
    if(func_56F2(self.origin - var_0.origin, -28672, 6400)) {
      func_5A07();
      self.var_B7B5 = gettime() + 6000;
      if(isDefined(self.var_5A0E) && self.var_5A0E == 0 || self.var_5A0E < randomfloat(1)) {
        return;
      }

      func_5A08(var_0, "flash_grenade", 1, 4096, 0.2);
      return;
    }

    wait(0.1);
  }
}

func_5A0A(var_0) {
  for(;;) {
    if(!self.var_9E45 || distancesquared(self.origin, var_0.origin) < 1024) {
      return;
    }

    wait(0.1);
  }
}