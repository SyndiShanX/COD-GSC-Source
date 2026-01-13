/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2573.gsc
**************************************/

func_A00E(var_0, var_1) {
  var_2 = var_1 * var_1;

  if(distancesquared(self.origin, self.enemy.origin) < var_2) {
    return anim.success;
  }

  return anim.failure;
}

func_2529(var_0) {
  return anim.success;
}

func_8C3A(var_0) {
  if(isalive(self.enemy)) {
    return anim.success;
  }

  return anim.failure;
}

func_BCA7(var_0) {
  return anim.success;
}

func_FFBE(var_0) {
  self._blackboard.var_2521 = 0;
  var_1 = self.enemy.origin - self.origin;
  var_2 = anglesToForward(self.angles);
  var_3 = vectordot(var_1, var_2);
  var_4 = distancesquared(self.enemy.origin, self.origin);

  if(var_4 < 16000000 && var_3 < 0.8) {
    return anim.failure;
  }

  if(func_9D6A(var_0) == anim.success && isDefined(self.var_DB08) && self.var_DB08 > 20.0) {
    return anim.failure;
  }

  if(var_3 < 0.3) {
    return anim.failure;
  }

  return anim.success;
}

func_1006C(var_0) {
  return anim.success;
}

func_593B(var_0) {
  return anim.success;
}

func_7FDA(var_0, var_1) {
  return var_0;
}

func_1815(var_0, var_1) {
  var_2 = var_1 * -1;
  var_3 = randomfloatrange(var_2, var_1);
  var_4 = randomfloatrange(var_2, var_1);
  var_5 = randomfloatrange(var_2, var_1);
  var_6 = (var_3, var_4, var_5);
  var_7 = rotatevector(var_0, var_6);
  return var_7;
}

func_370C(var_0) {
  var_1 = var_0.origin - self.origin;
  var_2 = length(var_1);
  var_1 = vectornormalize(var_1);
  var_3 = var_1 * (var_2 + 10000.0);
  var_3 = var_3 + self.origin;
  var_4 = _getclosestpointonnavmesh3d(var_3);
  return var_4;
}

func_7DEB() {
  return anglesToForward(self.angles);
}

func_371B(var_0) {
  var_1 = undefined;

  if(isplayer(var_0)) {
    var_1 = var_0 func_7DEB();
  } else {
    var_1 = anglesToForward(self.angles);
  }

  var_1 = func_1815(var_1, 75);
  var_2 = randomfloatrange(7500.0, 12500.0);
  var_3 = var_1 * var_2;
  var_3 = var_3 + self.origin;
  var_3 = func_7FDA(var_3, 512.0);
  return var_3;
}

settarget() {}

waittillgrenadedrops(var_0) {}

func_F72A(var_0, var_1) {
  self setneargoalnotifydist(var_1);
  return anim.success;
}

func_F7C9(var_0, var_1) {
  func_A299(var_1);
  return anim.success;
}

func_F672(var_0, var_1) {
  self func_8459(var_1);
  return anim.success;
}

func_F706(var_0, var_1) {
  func_0BDC::func_19AE(var_1);
  return anim.success;
}

func_F711(var_0, var_1) {
  if(self._blackboard.var_E1AC == "none" || self._blackboard.var_E1AC == var_1) {
    self func_8491(var_1);
    func_0C21::func_20DD(var_1);
  }

  return anim.success;
}

func_F6C2(var_0, var_1) {
  self func_845F(var_1);
  return anim.success;
}

func_7F23(var_0) {}

func_7E02(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 20000;
  }

  if(!isDefined(var_1)) {
    var_1 = 1500;
  }

  var_2 = undefined;

  if(isDefined(self._blackboard.var_10A4D) && isDefined(self._blackboard.var_10A4A)) {
    var_2 = self func_8486(var_0, var_1, self._blackboard.var_10A4D[self._blackboard.var_10A4A]);
  } else {
    var_2 = self func_8486(var_0, var_1);
  }

  if(!isDefined(var_2) && var_0 < 100000) {
    var_0 = 100000;
    var_2 = func_7E02(var_0, var_1);
  }

  return var_2;
}

func_3713(var_0) {
  var_1 = undefined;

  if(isDefined(self._blackboard.var_90D9)) {
    var_2 = _getclosestpointonnavmesh3d(self._blackboard.var_90D9);
    return var_2;
  } else {
    var_3 = func_0C21::func_814A();
    var_4 = randomfloatrange(2.0, 4.0);

    if(_isaircraft(var_0) && isDefined(var_0.spaceship_vel)) {
      var_5 = var_0.origin + var_0.spaceship_vel * var_4;
    } else {
      var_5 = var_0.origin;
    }

    var_6 = _getclosestpointonnavmesh3d(var_5);
    var_7 = (512, 0, 0);
    var_7 = rotatevector(var_7, var_0.angles);
    var_8 = _navtrace3d(var_6, var_6 + var_7, 1);

    if(var_8["fraction"] < 0.5) {
      return var_0.origin;
    }

    var_9 = 3000.0;
    var_10 = var_8["position"] - self.origin;
    var_11 = length(var_10);

    if(var_11 < var_9) {
      return self.origin;
    }

    var_12 = var_10 * ((var_11 - var_9) / var_11) + self.origin;
    var_12 = func_78C3(var_12, 1200);
    return var_12;
  }
}

func_3714(var_0) {
  var_1 = undefined;

  if(!isDefined(var_0)) {
    return undefined;
  }

  var_2 = 5;
  var_3 = 30;

  if(var_0 == level.var_D127 && var_0.owner == level.player) {
    var_4 = level.player func_848A();

    if(isDefined(var_4) && var_4[0] == self) {
      var_2 = 10;
      var_3 = 60;
    }
  }

  var_5 = _getclosestpointonnavmesh3d(var_0.origin, self);
  var_6 = self.origin - var_5;
  var_7 = vectornormalize(var_6);
  var_8 = vectortoangles(var_6);
  var_9 = 0;

  while(var_9 < 3) {
    var_10 = randomfloatrange(-1 * var_2, var_2);
    var_11 = randomfloatrange(-1 * var_3, var_3);
    var_12 = 0;
    var_13 = var_8 + (var_10, var_11, var_12);
    var_14 = anglesToForward(var_13) * randomfloatrange(3000.0, 5000.0);
    var_15 = var_5 + var_14;
    var_15 = func_78C3(var_15, 1700);
    var_15 = _getclosestpointonnavmesh3d(var_15, self);
    return var_15;
  }

  return undefined;
}

func_78C3(var_0, var_1) {
  var_2 = lib_0BCE::func_7DB5();
  var_3 = var_1 * var_1;

  for(var_4 = 3; var_4 > 0; var_4--) {
    foreach(var_6 in var_2) {
      if(var_6 == self) {
        continue;
      }
      var_7 = var_6 func_8579();

      if(distancesquared(var_7, var_0) < var_3) {
        var_0 = var_0 + vectornormalize(var_0 - var_7) * var_1;
        continue;
      }
    }

    return var_0;
  }

  return var_0;
}

func_13D94(var_0) {
  var_1 = distancesquared(self.origin, var_0.origin);

  if(var_1 > 144000000) {
    return 0;
  }

  if(var_1 < 16000000) {
    return 0;
  }

  return 1;
}

func_13D95(var_0) {
  var_1 = distancesquared(self.origin, var_0.origin);

  if(var_1 > 256000000) {
    return 0;
  }

  if(var_1 < 81000000) {
    return 0;
  }

  return 1;
}

func_10E63(var_0) {
  if(self._blackboard.var_2CCD) {
    return;
  }
  var_1 = vectornormalize(var_0.spaceship_vel);
  var_2 = vectornormalize(self.spaceship_vel);
  var_3 = vectordot(var_1, var_2);
  var_4 = var_0.origin - self.origin;

  if(var_3 < 0.8 || vectordot(var_4, var_2) < 0) {
    func_0C21::func_20DE(1.0);
    return;
  }

  var_5 = distance(self.origin, var_0.origin);
  var_6 = clamp((var_5 - 4000) / 8000, 0.0, 1.0);
  var_7 = 1.4 * var_6 + 0.6 * (1 - var_6);
  func_0C21::func_20DE(var_7);
}

func_E7B7(var_0) {
  if(self.team != "axis") {
    return;
  }
  var_1 = level.var_D127.origin - self.origin;
  var_2 = length(var_1);

  if(self.bt.var_5870) {
    var_0 = 1.0;
    func_0C21::func_20DE(var_0);
    return;
  }

  if(var_2 > 25000) {
    func_0C21::func_20DE(var_0);
    return;
  }

  var_3 = vectornormalize(var_1);
  var_4 = vectornormalize(self.spaceship_vel);
  var_5 = vectordot(var_3, var_4);

  if(var_5 > 0) {
    var_6 = scripts\sp\math::func_6A8E(1.9, 0.7, var_5);
  } else {
    var_5 = var_5 * -1;

    if(var_2 < 9000) {
      var_7 = scripts\sp\math::func_C097(3500, 9000, var_2);
      var_8 = scripts\sp\math::func_6A8E(2.5, 1, var_7);
    } else {
      var_7 = scripts\sp\math::func_C097(9000, 13000, var_2);
      var_8 = scripts\sp\math::func_6A8E(1, 0.3, var_7);
    }

    var_6 = scripts\sp\math::func_6A8E(1.9, var_8, var_5);
  }

  var_7 = scripts\sp\math::func_C097(20000, 25000, var_2);
  var_6 = scripts\sp\math::func_6A8E(var_6, 1, var_7);
  func_0C21::func_20DE(var_6 * var_0);
}

func_10029(var_0, var_1) {
  var_2 = func_13D95(self.enemy);
  var_3 = anglesToForward(self.enemy.angles);
  var_4 = vectornormalize(self.origin - self.enemy.origin);
  var_5 = vectordot(var_3, var_4);
  var_6 = func_9D6A(var_0);

  if(var_2 && var_5 > 0.7 && !var_6) {
    return anim.success;
  }

  return anim.failure;
}

func_FFD6(var_0, var_1) {
  if(!isalive(self.enemy)) {
    return anim.failure;
  }

  if(func_10027(var_0) == anim.success || func_10015(var_0) == anim.success || func_8C2C(var_0) == anim.success) {
    return anim.failure;
  }

  if(!self._blackboard.var_2521) {
    var_2 = distancesquared(self.origin, self.enemy.origin);

    if(var_2 < 144000000) {
      self._blackboard.var_2521 = 1;
      self._blackboard.var_2531 = gettime();
    }
  }

  if(self._blackboard.var_2521) {
    if(self._blackboard.var_2531 + 4000 < gettime()) {
      return anim.failure;
    }

    if(!func_13D94(self.enemy)) {
      return anim.failure;
    }

    if(vectordot(anglesToForward(self.angles), self.enemy.origin - self.origin) < 0.0) {
      return anim.failure;
    }
  }

  return anim.success;
}

func_1003E(var_0, var_1) {
  if(!isalive(self.enemy)) {
    return anim.failure;
  }

  var_2 = anglesToForward(self.enemy.angles);
  var_3 = vectornormalize(self.enemy.origin - self.origin);

  if(vectordot(var_2, var_3) < 0) {
    return anim.failure;
  }

  var_4 = anglesToForward(self.angles);

  if(vectordot(var_4, var_3) < 0.7) {
    return anim.failure;
  }

  return anim.success;
}

func_10E66(var_0, var_1) {
  if(_isaircraft(self.enemy)) {
    func_10E63(self.enemy);
  }

  return anim.success;
}

func_E7B8(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = 1;
  }

  if(isDefined(level.var_D127)) {
    func_E7B7(var_2);
  }

  return anim.success;
}

func_419A(var_0, var_1) {
  self._blackboard.var_2521 = 0;
  return anim.success;
}

func_C936(var_0, var_1) {
  if(!isalive(self.enemy)) {
    return anim.success;
  }

  self._blackboard.var_2CCF = 1;
  return anim.success;
}

func_6CAB(var_0, var_1) {
  var_2 = undefined;

  switch (var_1) {
    case "attack":
      if(self.bt.var_BFA2 > gettime()) {
        return anim.success;
      }

      self.enemy.var_A941 = gettime();
      self.bt.var_BFA2 = gettime() + 400;
      var_2 = func_370C(self.enemy);
      break;
    case "retreat":
      if(self.bt.var_BFA2 > gettime()) {
        return anim.success;
      }

      self.bt.var_BFA2 = gettime() + 400;
      var_2 = func_371B(self.enemy);
      break;
    case "hover_approach":
      if(self.bt.var_BFA2 > gettime()) {
        return anim.success;
      }

      self.bt.var_BFA2 = gettime() + 400;
      var_2 = func_3713(self.enemy);
      break;
    case "escape":
      self.bt.var_3F28 = func_7E02();

      if(!isDefined(self.bt.var_3F28)) {
        return anim.failure;
      }
    case "spline":
      var_2 = getcsplinepointposition(self.bt.var_3F28["spline"], self.bt.var_3F28["node"]);
      self setneargoalnotifydist(2048);
      self func_8479(self.bt.var_3F28["spline"]);
      self func_8455(var_2, 0);
      return anim.success;
  }

  self func_8455(var_2, 0);
  return anim.success;
}

func_9D44(var_0) {
  if(self._blackboard.var_EF72) {
    return anim.success;
  }

  return anim.failure;
}

func_98E0(var_0) {
  self.bt.instancedata[var_0] = [];
  self.bt.instancedata[var_0]["wait_finished"] = 0;
  thread func_136C1(var_0);
}

func_136C1(var_0) {
  self endon("Task Terminate " + var_0);
  scripts\engine\utility::waittill_any("near_goal", "bt_state_changed");
  self.bt.instancedata[var_0]["wait_finished"] = 1;
}

func_136C0(var_0) {
  if(self.bt.instancedata[var_0]["wait_finished"] == 1) {
    return anim.success;
  }

  return anim.running;
}

func_11704(var_0) {
  self notify("Task Terminate " + var_0);
  self.bt.instancedata[var_0] = undefined;
}

func_98DF(var_0) {
  self._blackboard.var_2534 = self.enemy;
  func_98E0(var_0);
}

func_11703(var_0) {
  self._blackboard.var_2534 = undefined;
  func_11704(var_0);
}

func_9D6A(var_0) {
  if(isalive(self.bt.var_DB05) && !isDefined(self.var_932F)) {
    return anim.success;
  }

  if(isDefined(self.var_DB08) && self.var_DB08 > 20.0) {
    return anim.success;
  }

  return anim.failure;
}

func_F85B(var_0, var_1) {
  var_2 = var_1;

  if(isDefined(self._blackboard.var_10A4D[var_2])) {
    self._blackboard.var_10A4A = var_2;
  }

  return anim.success;
}

func_9CE7(var_0) {
  var_1 = 0;

  if(isDefined(var_0.var_A941)) {
    var_1 = var_0.var_A941;
  }

  return var_1 + 3500 < gettime();
}

func_B4DB(var_0) {
  if(!isalive(self.enemy)) {
    return anim.failure;
  }

  if(self._blackboard.var_C97C) {
    return anim.failure;
  }

  var_1 = _ispointonnavmesh3d(self.origin, self);

  if(!var_1) {
    return anim.failure;
  }

  var_2 = isplayer(self.enemy.owner);
  var_3 = func_9CE7(self.enemy);
  var_4 = distancesquared(self.origin, self.enemy.origin) > 49000000;

  if(var_3 && var_4) {
    var_5 = vectornormalize(self.origin - self.enemy.origin);

    if(var_2) {
      if(vectordot(anglesToForward(self.enemy.angles), self.origin - self.enemy.origin) < 0.34202) {
        self.bt.var_3F28 = undefined;
        return anim.success;
      }
    }

    if(vectordot(anglesToForward(self.angles), var_5 * -1.0) > 0.6) {
      self.bt.var_3F28 = undefined;
      return anim.success;
    }
  }

  return anim.failure;
}

func_724A(var_0) {
  if(isDefined(self.bt.var_3F28)) {
    self func_8479(self.bt.var_3F28["spline"]);
    self func_847B(1.0, getcsplinepointposition(self.bt.var_3F28["spline"], self.bt.var_3F28["node"]));

    if(!self._blackboard.var_2CCD) {
      if(isDefined(self.bt.var_DB05)) {
        func_0C21::func_20DE(1.25);
      } else {
        func_0C21::func_20DE(1.0);
      }
    }

    self.bt.instancedata[var_0] = [];
    self.bt.instancedata[var_0]["new_spline"] = 0;
  }
}

func_7248(var_0) {
  if(!isDefined(self.bt.var_3F28) || self.bt.instancedata[var_0]["new_spline"]) {
    return anim.success;
  }

  var_1 = _getcsplinepointcount(self.bt.var_3F28["spline"]);
  var_2 = distancesquared(self.origin, getcsplinepointposition(self.bt.var_3F28["spline"], var_1 - 1));

  if(var_2 < 4194304) {
    func_0C24::func_10A44(self.bt.var_3F28["spline"]);
    self.bt.var_3F28 = undefined;
    return anim.success;
  }

  return anim.running;
}

func_D3B2(var_0) {
  if(!scripts\sp\utility::func_D123()) {
    return anim.failure;
  }

  var_1 = level.player func_848A();

  if(isDefined(var_1)) {
    var_2 = var_1[0];
  } else {
    return anim.failure;
  }

  if(var_2 != self) {
    return anim.failure;
  }

  if(!level.var_D127.var_4C15.var_9DF4) {
    return anim.failure;
  }

  return anim.success;
}

func_D3B5(var_0) {
  if(!scripts\sp\utility::func_D123()) {
    return anim.failure;
  }

  var_1 = level.player func_848A();

  if(isDefined(var_1)) {
    var_2 = var_1[0];
  } else {
    return anim.failure;
  }

  if(var_2 != self) {
    return anim.failure;
  }

  if(var_1[1] <= 0.01) {
    return anim.failure;
  }

  return anim.success;
}

func_1289A(var_0) {
  var_1 = 0;

  if(isDefined(self.var_67C7) && self.var_67C7) {
    return anim.success;
  }

  if(func_A533() == anim.success) {
    var_1 = 1;
  }

  if(func_D3B2() == anim.success) {
    var_1 = 1;
  }

  if(var_1) {
    thread func_0C1B::func_12899();
  }

  return anim.success;
}

func_724B(var_0) {
  self notify("Task Terminate " + var_0);
  self.bt.var_3F28 = undefined;
}

func_8C2C(var_0) {
  if(isDefined(self.bt.var_3F28)) {
    return anim.success;
  }

  return anim.failure;
}

func_10017(var_0) {
  if(!isDefined(self.bt.var_3F28)) {
    return anim.failure;
  }

  var_1 = func_0BDC::func_1996();
  var_2 = var_1.speed;
  var_3 = 1.0 * scripts\engine\utility::mph_to_ips(var_2);
  var_4 = distancesquared(self.origin, getcsplinepointposition(self.bt.var_3F28["spline"], self.bt.var_3F28["node"]));

  if(var_4 < var_3 * var_3) {
    return anim.success;
  }

  return anim.failure;
}

func_10015(var_0) {
  var_1 = self._blackboard.var_7235.target;

  if(!isDefined(var_1)) {
    return anim.failure;
  }

  if(issentient(var_1) && !isalive(var_1)) {
    return anim.failure;
  }

  return anim.success;
}

func_7221(var_0) {
  if(!self._blackboard.var_7235.var_7237) {
    self notify("in_follow_position");

    if(isDefined(self._blackboard.var_7235.var_98F9)) {
      self func_848D(self._blackboard.var_7235.target, self._blackboard.var_7235.offset, 1.0, self._blackboard.var_7235.var_98F9, self._blackboard.var_7235.var_98FE, self._blackboard.var_7235.var_C760, self._blackboard.var_7235.var_C765);
    } else {
      self func_848D(self._blackboard.var_7235.target, self._blackboard.var_7235.offset, 1.0);
    }

    self._blackboard.var_7235.var_7237 = 1;
  }
}

func_7231(var_0) {
  if(!isalive(self._blackboard.var_7235.target) && !self._blackboard.animscriptedactive) {
    self func_8455(self.origin, 1);
  }

  self._blackboard.var_7235.var_7237 = 0;
}

follow(var_0) {
  if(isalive(self._blackboard.var_7235.target) && self._blackboard.var_7235.var_7237) {
    if(isDefined(self._blackboard.var_7235.target.bt) && self._blackboard.var_7235.target.bt.var_673F) {
      return anim.success;
    }

    var_1 = self func_8493();
    return anim.running;
  }

  return anim.success;
}

func_7EC1() {
  var_0 = self._blackboard.var_7235.target;
  var_1 = self._blackboard.var_7235.offset;
  var_2 = rotatevector(var_1, var_0.angles);
  var_3 = var_0.origin + var_2;
  return var_3;
}

func_10016(var_0) {
  var_1 = func_7EC1();
  var_2 = self._blackboard.var_7235.target;
  var_3 = length(var_2.spaceship_vel);
  var_4 = var_3 * 1.0;
  var_4 = max(16000000, var_4);

  if(distancesquared(self.origin, var_1) > var_4) {
    return anim.success;
  }

  return anim.failure;
}

func_A299(var_0, var_1) {
  if(isDefined(self._blackboard.var_C705)) {
    var_0 = self._blackboard.var_C705;

    if(isDefined(self._blackboard.var_C702)) {
      var_1 = self._blackboard.var_C702;
    }
  }

  self goon_spawners(var_0, var_1);
}

func_7233(var_0) {
  func_A299("face motion");
  self func_8459("face motion");
}

func_7232(var_0) {
  var_1 = self._blackboard.var_7235.target;
  var_2 = self._blackboard.var_7235.offset;
  var_3 = rotatevector(var_2, var_1.angles);
  var_4 = func_7EC1();
  self func_8455(var_4, 0);
  self setneargoalnotifydist(3000.0);

  if(_isaircraft(var_1)) {
    var_5 = func_0C21::func_814A();
    var_6 = var_5.speed;
    var_7 = getdvarint("spaceshipAiBoostSpeedScale");
    var_8 = length(var_1.spaceship_vel);
    var_9 = vectordot(var_1.spaceship_vel, self.spaceship_vel);

    if(var_9 > 0 && var_8 * 1.5 > var_6 * var_7) {
      var_6 = var_8 * 1.5 / var_7;
      self func_8459("always");
    }

    if(var_9 > 0 && var_8 * 1.5 > var_6) {
      self func_8459("always");
    } else {
      self func_8459("never");
    }

    self func_845F(var_6);
  }

  return anim.success;
}

func_7234(var_0) {
  var_1 = _getdvarvector("spaceshipAiBoostSpeed");
  self func_845F(var_1[0]);
}

func_7E67(var_0) {
  var_1 = scripts\engine\utility::array_find(level.var_90E2.var_5084, var_0);
  return var_1;
}

func_10027(var_0) {
  if(self._blackboard.var_90F3) {
    return anim.success;
  }

  if(func_D3B5()) {
    return anim.failure;
  }

  if(isalive(self._blackboard.var_90EE) && isalive(self.enemy) && self._blackboard.var_90EE == self.enemy) {
    return anim.success;
  }

  return anim.failure;
}

func_10075(var_0) {
  if(!isalive(self.enemy)) {
    return anim.failure;
  }

  if(!isDefined(self._blackboard.var_90DC)) {
    return anim.success;
  }

  if(!isalive(self._blackboard.var_90DA) || self.enemy != self._blackboard.var_90DA) {
    return anim.success;
  }

  if(distancesquared(self._blackboard.var_90DB, self._blackboard.var_90DA.origin) > 1000000) {
    return anim.success;
  }

  return anim.failure;
}

func_F748(var_0) {
  if(self.bt.var_BFA2 > gettime()) {
    return anim.success;
  }

  self.bt.var_BFA2 = gettime() + 400;
  self._blackboard.var_90DB = self.enemy.origin;
  self._blackboard.var_90DA = self.enemy;
  var_1 = func_3713(self.enemy);

  if(distancesquared(self.origin, var_1) <= 9000000) {
    return anim.failure;
  }

  self._blackboard.var_90DC = var_1;
  self setneargoalnotifydist(3000);
  self func_8455(var_1, 1);
  self.bt.var_3F28 = undefined;
  return anim.success;
}

func_41B6(var_0) {
  self._blackboard.var_90DB = undefined;
  self._blackboard.var_90DA = undefined;
  self._blackboard.var_90DC = undefined;
  return anim.success;
}

func_10028(var_0) {
  if(!isalive(self.enemy)) {
    return anim.failure;
  }

  var_1 = distancesquared(self.origin, self.enemy.origin);
  var_2 = distance(self.origin, self.enemy.origin);

  if(var_1 > 100000000) {
    return anim.success;
  }

  return anim.failure;
}

func_1002B(var_0) {
  var_1 = 2000;
  var_2 = 4000;

  if(!isalive(self.enemy)) {
    return anim.failure;
  }

  var_3 = level.player func_8473();

  if(self.enemy == level.var_D127 && isDefined(var_3) && var_3 == self.enemy) {
    var_4 = level.player func_848A();

    if(isDefined(var_4) && var_4[0] == self) {
      var_1 = 1300;
      var_2 = 1300;
    }
  }

  if(!isDefined(self.bt.instancedata[var_0])) {
    self.bt.instancedata[var_0] = [];
    self.bt.instancedata[var_0]["nextRepositionTime"] = gettime() + randomintrange(2000, 4000);
    return anim.failure;
  }

  if(gettime() >= self.bt.instancedata[var_0]["nextRepositionTime"]) {
    self.bt.instancedata[var_0]["nextRepositionTime"] = gettime() + randomintrange(2000, 4000);
    return anim.success;
  }

  return anim.failure;
}

func_90F2(var_0) {
  var_1 = func_3714(self.enemy);

  if(isDefined(var_1)) {
    if(distancesquared(self.origin, var_1) > 3000) {
      self func_8491("fly");
      func_0C21::func_20DD("fly");
    } else {
      self func_8491("hover");
      func_0C21::func_20DD("hover");
    }

    self._blackboard.var_90DC = var_1;
    self setneargoalnotifydist(512);
    self func_8455(var_1, 1);
  }

  return anim.success;
}

func_9E00(var_0) {
  var_1 = self func_8493();
  var_2 = var_1 == "follow" && self._blackboard.var_7235.var_7237;

  if(var_2) {
    return anim.success;
  }

  return anim.failure;
}

func_61C4(var_0) {
  return anim.success;
}

func_9E77(var_0) {
  if(_isaircraft(self._blackboard.var_7235.target) && self._blackboard.var_7235.target.spaceship_mode == "hover") {
    return anim.success;
  }

  return anim.failure;
}

func_9DE3(var_0) {
  if(self.bt.var_673F) {
    return anim.success;
  } else {
    return anim.failure;
  }
}

func_9F39() {
  if(self.bt.var_EF78) {
    return anim.success;
  } else {
    return anim.failure;
  }
}

func_9F74(var_0) {
  if(!isDefined(self.var_A420)) {
    return anim.failure;
  }

  foreach(var_2 in self.var_A420) {
    if(isalive(var_2) && var_2 func_9FBB() == anim.success) {
      return anim.success;
    }
  }

  return anim.failure;
}

func_9FBB(var_0) {
  if(self.bt.attackerdata.var_24D3 && func_9FD0() == anim.success) {
    return anim.success;
  }

  return anim.failure;
}

func_9EE9(var_0) {
  if(self.bt.var_5870) {
    return anim.success;
  }

  return anim.failure;
}

func_A533(var_0) {
  if(self.bt.var_A533) {
    return anim.success;
  }

  return anim.failure;
}

func_9E76(var_0) {
  if(_isaircraft(self._blackboard.var_7235.target) && isDefined(self._blackboard.var_7235.target.bt) && self._blackboard.var_7235.target.bt.var_673F) {
    return anim.success;
  }

  return anim.failure;
}

func_1000C(var_0) {
  if(func_9DE3(var_0) == anim.success && func_673D() == anim.success) {
    return anim.success;
  }

  if(func_9FBB() == anim.success) {
    return anim.success;
  }

  if(func_9F39() == anim.success) {
    return anim.success;
  }

  if(func_A533() == anim.success) {
    return anim.success;
  }

  if(func_9EE9() == anim.success) {
    return anim.success;
  }

  if(func_9F74() == anim.success) {
    return anim.success;
  }

  func_1106C();
  return anim.failure;
}

func_673D(var_0) {
  if(func_118CD(self.bt.var_673E) < 4) {
    return anim.success;
  }

  return anim.failure;
}

func_9FD0(var_0) {
  if(!isDefined(self.bt.attackerdata.attacker)) {
    return anim.failure;
  }

  if(isDefined(level.var_D127) && self.bt.attackerdata.attacker == level.var_D127) {
    return anim.success;
  }

  return anim.failure;
}

func_1106C(var_0) {
  if(self.bt.var_673F) {
    self.bt.var_673F = 0;
  }

  return anim.success;
}

func_F6EC(var_0) {
  self.bt.var_673F = 1;
  self.bt.var_673E = gettime();
  return anim.success;
}

validatehighpriorityflag(var_0) {
  self.bt.var_673E = gettime();
  return anim.success;
}

func_1003F(var_0) {
  if(!isalive(self.enemy)) {
    return anim.success;
  }

  if(isDefined(self._blackboard.var_7002)) {
    return anim.failure;
  }

  if(self._blackboard.var_C97C) {
    return anim.success;
  }

  return anim.failure;
}

func_118CD(var_0) {
  var_1 = gettime() - var_0;
  return var_1 / 1000;
}

func_24D5(var_0) {
  if(func_118CD(self.bt.attackerdata.var_2535) < 6) {
    return anim.success;
  }

  return anim.failure;
}

func_FFD7(var_0) {
  if(func_9D6A() == anim.success) {
    return anim.success;
  }

  if(func_24D5() == anim.success) {
    return anim.success;
  }

  func_1106C(var_0);
  return anim.failure;
}

func_FFD8(var_0) {
  if(!isalive(self.enemy)) {
    return anim.success;
  }

  if(isDefined(self._blackboard.var_7002)) {
    return anim.failure;
  }

  if(self._blackboard.var_C97C) {
    return anim.success;
  }

  return anim.failure;
}

func_41E4(var_0) {
  if(isDefined(self._blackboard.var_10A4B)) {
    self._blackboard.var_10A4A = self._blackboard.var_10A4B;
  } else {
    self._blackboard.var_10A4A = undefined;
  }

  return anim.success;
}

func_8BEC(var_0) {
  if(isDefined(self.enemy)) {
    return anim.success;
  }

  return anim.failure;
}