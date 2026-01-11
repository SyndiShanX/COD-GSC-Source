/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2573.gsc
***************************************/

func_A00E(var_00, var_01) {
  var_02 = var_01 * var_01;

  if(distancesquared(self.origin, self.enemy.origin) < var_02) {
    return anim.success;
  }

  return anim.failure;
}

func_2529(var_00) {
  return anim.success;
}

func_8C3A(var_00) {
  if(isalive(self.enemy)) {
    return anim.success;
  }

  return anim.failure;
}

func_BCA7(var_00) {
  return anim.success;
}

func_FFBE(var_00) {
  self.var_1198.func_2521 = 0;
  var_01 = self.enemy.origin - self.origin;
  var_02 = anglesToForward(self.angles);
  var_03 = vectordot(var_01, var_02);
  var_04 = distancesquared(self.enemy.origin, self.origin);

  if(var_04 < 16000000 && var_03 < 0.8) {
    return anim.failure;
  }

  if(func_9D6A(var_00) == anim.success && isDefined(self.func_DB08) && self.func_DB08 > 20.0) {
    return anim.failure;
  }

  if(var_03 < 0.3) {
    return anim.failure;
  }

  return anim.success;
}

func_1006C(var_00) {
  return anim.success;
}

func_593B(var_00) {
  return anim.success;
}

func_7FDA(var_00, var_01) {
  return var_00;
}

func_1815(var_00, var_01) {
  var_02 = var_01 * -1;
  var_03 = randomfloatrange(var_02, var_01);
  var_04 = randomfloatrange(var_02, var_01);
  var_05 = randomfloatrange(var_02, var_01);
  var_06 = (var_03, var_04, var_05);
  var_07 = rotatevector(var_00, var_06);
  return var_07;
}

func_370C(var_00) {
  var_01 = var_0.origin - self.origin;
  var_02 = length(var_01);
  var_01 = vectornormalize(var_01);
  var_03 = var_01 * (var_02 + 10000.0);
  var_03 = var_03 + self.origin;
  var_04 = _getclosestpointonnavmesh3d(var_03);
  return var_04;
}

func_7DEB() {
  return anglesToForward(self.angles);
}

func_371B(var_00) {
  var_01 = undefined;

  if(isplayer(var_00)) {
    var_01 = var_00 func_7DEB();
  }
  else {
    var_01 = anglesToForward(self.angles);
  }

  var_01 = func_1815(var_01, 75);
  var_02 = randomfloatrange(7500.0, 12500.0);
  var_03 = var_01 * var_02;
  var_03 = var_03 + self.origin;
  var_03 = func_7FDA(var_03, 512.0);
  return var_03;
}

settarget() {}

waittillgrenadedrops(var_00) {}

func_F72A(var_00, var_01) {
  self setneargoalnotifydist(var_01);
  return anim.success;
}

func_F7C9(var_00, var_01) {
  func_A299(var_01);
  return anim.success;
}

func_F672(var_00, var_01) {
  self _meth_8459(var_01);
  return anim.success;
}

func_F706(var_00, var_01) {
  func_0BDC::func_19AE(var_01);
  return anim.success;
}

func_F711(var_00, var_01) {
  if(self.var_1198.func_E1AC == "none" || self.var_1198.func_E1AC == var_01) {
    self _meth_8491(var_01);
    func_0C21::func_20DD(var_01);
  }

  return anim.success;
}

func_F6C2(var_00, var_01) {
  self _meth_845F(var_01);
  return anim.success;
}

func_7F23(var_00) {}

func_7E02(var_00, var_01) {
  if(!isDefined(var_00)) {
    var_00 = 20000;
  }

  if(!isDefined(var_01)) {
    var_01 = 1500;
  }

  var_02 = undefined;

  if(isDefined(self.var_1198.func_10A4D) && isDefined(self.var_1198.func_10A4A)) {
    var_02 = self _meth_8486(var_00, var_01, self.var_1198.func_10A4D[self.var_1198.func_10A4A]);
  }
  else {
    var_02 = self _meth_8486(var_00, var_01);
  }

  if(!isDefined(var_02) && var_00 < 100000) {
    var_00 = 100000;
    var_02 = func_7E02(var_00, var_01);
  }

  return var_02;
}

func_3713(var_00) {
  var_01 = undefined;

  if(isDefined(self.var_1198.func_90D9)) {
    var_02 = _getclosestpointonnavmesh3d(self.var_1198.func_90D9);
    return var_02;
  } else {
    var_03 = func_0C21::_meth_814A();
    var_04 = randomfloatrange(2.0, 4.0);

    if(_isaircraft(var_00) && isDefined(var_0.spaceship_vel)) {
      var_05 = var_0.origin + var_0.spaceship_vel * var_04;
    }
    else {
      var_05 = var_0.origin;
    }

    var_06 = _getclosestpointonnavmesh3d(var_05);
    var_07 = (512, 0, 0);
    var_07 = rotatevector(var_07, var_0.angles);
    var_08 = _navtrace3d(var_06, var_06 + var_07, 1);

    if(var_8["fraction"] < 0.5) {
      return var_0.origin;
    }

    var_09 = 3000.0;
    var_10 = var_8["position"] - self.origin;
    var_11 = length(var_10);

    if(var_11 < var_09) {
      return self.origin;
    }

    var_12 = var_10 * ((var_11 - var_09) / var_11) + self.origin;
    var_12 = func_78C3(var_12, 1200);
    return var_12;
  }
}

func_3714(var_00) {
  var_01 = undefined;

  if(!isDefined(var_00)) {
    return undefined;
  }

  var_02 = 5;
  var_03 = 30;

  if(var_00 == level.func_D127 && var_0.owner == level.player) {
    var_04 = level.player _meth_848A();

    if(isDefined(var_04) && var_4[0] == self) {
      var_02 = 10;
      var_03 = 60;
    }
  }

  var_05 = _getclosestpointonnavmesh3d(var_0.origin, self);
  var_06 = self.origin - var_05;
  var_07 = vectornormalize(var_06);
  var_08 = vectortoangles(var_06);
  var_09 = 0;

  while(var_09 < 3) {
    var_10 = randomfloatrange(-1 * var_02, var_02);
    var_11 = randomfloatrange(-1 * var_03, var_03);
    var_12 = 0;
    var_13 = var_08 + (var_10, var_11, var_12);
    var_14 = anglesToForward(var_13) * randomfloatrange(3000.0, 5000.0);
    var_15 = var_05 + var_14;
    var_15 = func_78C3(var_15, 1700);
    var_15 = _getclosestpointonnavmesh3d(var_15, self);
    return var_15;
  }

  return undefined;
}

func_78C3(var_00, var_01) {
  var_02 = func_0BCE::func_7DB5();
  var_03 = var_01 * var_01;

  for(var_04 = 3; var_04 > 0; var_4--) {
    foreach(var_06 in var_02) {
      if(var_06 == self) {
        continue;
      }
      var_07 = var_06 _meth_8579();

      if(distancesquared(var_07, var_00) < var_03) {
        var_00 = var_00 + vectornormalize(var_00 - var_07) * var_01;
        continue;
      }
    }

    return var_00;
  }

  return var_00;
}

func_13D94(var_00) {
  var_01 = distancesquared(self.origin, var_0.origin);

  if(var_01 > 144000000) {
    return 0;
  }

  if(var_01 < 16000000) {
    return 0;
  }

  return 1;
}

func_13D95(var_00) {
  var_01 = distancesquared(self.origin, var_0.origin);

  if(var_01 > 256000000) {
    return 0;
  }

  if(var_01 < 81000000) {
    return 0;
  }

  return 1;
}

func_10E63(var_00) {
  if(self.var_1198.func_2CCD) {
    return;
  }
  var_01 = vectornormalize(var_0.spaceship_vel);
  var_02 = vectornormalize(self.spaceship_vel);
  var_03 = vectordot(var_01, var_02);
  var_04 = var_0.origin - self.origin;

  if(var_03 < 0.8 || vectordot(var_04, var_02) < 0) {
    func_0C21::func_20DE(1.0);
    return;
  }

  var_05 = distance(self.origin, var_0.origin);
  var_06 = clamp((var_05 - 4000) / 8000, 0.0, 1.0);
  var_07 = 1.4 * var_06 + 0.6 * (1 - var_06);
  func_0C21::func_20DE(var_07);
}

func_E7B7(var_00) {
  if(self.team != "axis") {
    return;
  }
  var_01 = level.func_D127.origin - self.origin;
  var_02 = length(var_01);

  if(self.var_3135.func_5870) {
    var_00 = 1.0;
    func_0C21::func_20DE(var_00);
    return;
  }

  if(var_02 > 25000) {
    func_0C21::func_20DE(var_00);
    return;
  }

  var_03 = vectornormalize(var_01);
  var_04 = vectornormalize(self.spaceship_vel);
  var_05 = vectordot(var_03, var_04);

  if(var_05 > 0) {
    var_06 = scripts\sp\math::func_6A8E(1.9, 0.7, var_05);
  }
  else {
    var_05 = var_05 * -1;

    if(var_02 < 9000) {
      var_07 = scripts\sp\math::func_C097(3500, 9000, var_02);
      var_08 = scripts\sp\math::func_6A8E(2.5, 1, var_07);
    } else {
      var_07 = scripts\sp\math::func_C097(9000, 13000, var_02);
      var_08 = scripts\sp\math::func_6A8E(1, 0.3, var_07);
    }

    var_06 = scripts\sp\math::func_6A8E(1.9, var_08, var_05);
  }

  var_07 = scripts\sp\math::func_C097(20000, 25000, var_02);
  var_06 = scripts\sp\math::func_6A8E(var_06, 1, var_07);
  func_0C21::func_20DE(var_06 * var_00);
}

func_10029(var_00, var_01) {
  var_02 = func_13D95(self.enemy);
  var_03 = anglesToForward(self.enemy.angles);
  var_04 = vectornormalize(self.origin - self.enemy.origin);
  var_05 = vectordot(var_03, var_04);
  var_06 = func_9D6A(var_00);

  if(var_02 && var_05 > 0.7 && !var_06) {
    return anim.success;
  }

  return anim.failure;
}

func_FFD6(var_00, var_01) {
  if(!isalive(self.enemy)) {
    return anim.failure;
  }

  if(func_10027(var_00) == anim.success || func_10015(var_00) == anim.success || func_8C2C(var_00) == anim.success) {
    return anim.failure;
  }

  if(!self.var_1198.func_2521) {
    var_02 = distancesquared(self.origin, self.enemy.origin);

    if(var_02 < 144000000) {
      self.var_1198.func_2521 = 1;
      self.var_1198.func_2531 = gettime();
    }
  }

  if(self.var_1198.func_2521) {
    if(self.var_1198.func_2531 + 4000 < gettime()) {
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

func_1003E(var_00, var_01) {
  if(!isalive(self.enemy)) {
    return anim.failure;
  }

  var_02 = anglesToForward(self.enemy.angles);
  var_03 = vectornormalize(self.enemy.origin - self.origin);

  if(vectordot(var_02, var_03) < 0) {
    return anim.failure;
  }

  var_04 = anglesToForward(self.angles);

  if(vectordot(var_04, var_03) < 0.7) {
    return anim.failure;
  }

  return anim.success;
}

func_10E66(var_00, var_01) {
  if(_isaircraft(self.enemy)) {
    func_10E63(self.enemy);
  }

  return anim.success;
}

func_E7B8(var_00, var_01) {
  if(isDefined(var_01)) {
    var_02 = var_01;
  }
  else {
    var_02 = 1;
  }

  if(isDefined(level.func_D127)) {
    func_E7B7(var_02);
  }

  return anim.success;
}

func_419A(var_00, var_01) {
  self.var_1198.func_2521 = 0;
  return anim.success;
}

func_C936(var_00, var_01) {
  if(!isalive(self.enemy)) {
    return anim.success;
  }

  self.var_1198.func_2CCF = 1;
  return anim.success;
}

func_6CAB(var_00, var_01) {
  var_02 = undefined;

  switch (var_01) {
    case "attack":
      if(self.var_3135.func_BFA2 > gettime()) {
        return anim.success;
      }

      self.enemy.func_A941 = gettime();
      self.var_3135.func_BFA2 = gettime() + 400;
      var_02 = func_370C(self.enemy);
      break;
    case "retreat":
      if(self.var_3135.func_BFA2 > gettime()) {
        return anim.success;
      }

      self.var_3135.func_BFA2 = gettime() + 400;
      var_02 = func_371B(self.enemy);
      break;
    case "hover_approach":
      if(self.var_3135.func_BFA2 > gettime()) {
        return anim.success;
      }

      self.var_3135.func_BFA2 = gettime() + 400;
      var_02 = func_3713(self.enemy);
      break;
    case "escape":
      self.var_3135.func_3F28 = func_7E02();

      if(!isDefined(self.var_3135.func_3F28)) {
        return anim.failure;
      }
    case "spline":
      var_02 = getcsplinepointposition(self.var_3135.func_3F28["spline"], self.var_3135.func_3F28["node"]);
      self setneargoalnotifydist(2048);
      self _meth_8479(self.var_3135.func_3F28["spline"]);
      self _meth_8455(var_02, 0);
      return anim.success;
  }

  self _meth_8455(var_02, 0);
  return anim.success;
}

func_9D44(var_00) {
  if(self.var_1198.func_EF72) {
    return anim.success;
  }

  return anim.failure;
}

func_98E0(var_00) {
  self.var_3135.instancedata[var_00] = [];
  self.var_3135.instancedata[var_00]["wait_finished"] = 0;
  thread func_136C1(var_00);
}

func_136C1(var_00) {
  self endon("Task Terminate " + var_00);
  scripts\engine\utility::waittill_any("near_goal", "bt_state_changed");
  self.var_3135.instancedata[var_00]["wait_finished"] = 1;
}

func_136C0(var_00) {
  if(self.var_3135.instancedata[var_00]["wait_finished"] == 1) {
    return anim.success;
  }

  return anim.running;
}

func_11704(var_00) {
  self notify("Task Terminate " + var_00);
  self.var_3135.instancedata[var_00] = undefined;
}

func_98DF(var_00) {
  self.var_1198.func_2534 = self.enemy;
  func_98E0(var_00);
}

func_11703(var_00) {
  self.var_1198.func_2534 = undefined;
  func_11704(var_00);
}

func_9D6A(var_00) {
  if(isalive(self.var_3135.func_DB05) && !isDefined(self.func_932F)) {
    return anim.success;
  }

  if(isDefined(self.func_DB08) && self.func_DB08 > 20.0) {
    return anim.success;
  }

  return anim.failure;
}

func_F85B(var_00, var_01) {
  var_02 = var_01;

  if(isDefined(self.var_1198.func_10A4D[var_02])) {
    self.var_1198.func_10A4A = var_02;
  }

  return anim.success;
}

func_9CE7(var_00) {
  var_01 = 0;

  if(isDefined(var_0.func_A941)) {
    var_01 = var_0.func_A941;
  }

  return var_01 + 3500 < gettime();
}

func_B4DB(var_00) {
  if(!isalive(self.enemy)) {
    return anim.failure;
  }

  if(self.var_1198.func_C97C) {
    return anim.failure;
  }

  var_01 = _ispointonnavmesh3d(self.origin, self);

  if(!var_01) {
    return anim.failure;
  }

  var_02 = isplayer(self.enemy.owner);
  var_03 = func_9CE7(self.enemy);
  var_04 = distancesquared(self.origin, self.enemy.origin) > 49000000;

  if(var_03 && var_04) {
    var_05 = vectornormalize(self.origin - self.enemy.origin);

    if(var_02) {
      if(vectordot(anglesToForward(self.enemy.angles), self.origin - self.enemy.origin) < 0.34202) {
        self.var_3135.func_3F28 = undefined;
        return anim.success;
      }
    }

    if(vectordot(anglesToForward(self.angles), var_05 * -1.0) > 0.6) {
      self.var_3135.func_3F28 = undefined;
      return anim.success;
    }
  }

  return anim.failure;
}

func_724A(var_00) {
  if(isDefined(self.var_3135.func_3F28)) {
    self _meth_8479(self.var_3135.func_3F28["spline"]);
    self _meth_847B(1.0, getcsplinepointposition(self.var_3135.func_3F28["spline"], self.var_3135.func_3F28["node"]));

    if(!self.var_1198.func_2CCD) {
      if(isDefined(self.var_3135.func_DB05)) {
        func_0C21::func_20DE(1.25);
      }
      else {
        func_0C21::func_20DE(1.0);
      }
    }

    self.var_3135.instancedata[var_00] = [];
    self.var_3135.instancedata[var_00]["new_spline"] = 0;
  }
}

func_7248(var_00) {
  if(!isDefined(self.var_3135.func_3F28) || self.var_3135.instancedata[var_00]["new_spline"]) {
    return anim.success;
  }

  var_01 = _getcsplinepointcount(self.var_3135.func_3F28["spline"]);
  var_02 = distancesquared(self.origin, getcsplinepointposition(self.var_3135.func_3F28["spline"], var_01 - 1));

  if(var_02 < 4194304) {
    func_0C24::func_10A44(self.var_3135.func_3F28["spline"]);
    self.var_3135.func_3F28 = undefined;
    return anim.success;
  }

  return anim.running;
}

func_D3B2(var_00) {
  if(!scripts\sp\utility::func_D123()) {
    return anim.failure;
  }

  var_01 = level.player _meth_848A();

  if(isDefined(var_01)) {
    var_02 = var_1[0];
  }
  else {
    return anim.failure;
  }

  if(var_02 != self) {
    return anim.failure;
  }

  if(!level.func_D127.func_4C15.func_9DF4) {
    return anim.failure;
  }

  return anim.success;
}

func_D3B5(var_00) {
  if(!scripts\sp\utility::func_D123()) {
    return anim.failure;
  }

  var_01 = level.player _meth_848A();

  if(isDefined(var_01)) {
    var_02 = var_1[0];
  }
  else {
    return anim.failure;
  }

  if(var_02 != self) {
    return anim.failure;
  }

  if(var_1[1] <= 0.01) {
    return anim.failure;
  }

  return anim.success;
}

func_1289A(var_00) {
  var_01 = 0;

  if(isDefined(self.func_67C7) && self.func_67C7) {
    return anim.success;
  }

  if(func_A533() == anim.success) {
    var_01 = 1;
  }

  if(func_D3B2() == anim.success) {
    var_01 = 1;
  }

  if(var_01) {
    thread func_0C1B::func_12899();
  }

  return anim.success;
}

func_724B(var_00) {
  self notify("Task Terminate " + var_00);
  self.var_3135.func_3F28 = undefined;
}

func_8C2C(var_00) {
  if(isDefined(self.var_3135.func_3F28)) {
    return anim.success;
  }

  return anim.failure;
}

func_10017(var_00) {
  if(!isDefined(self.var_3135.func_3F28)) {
    return anim.failure;
  }

  var_01 = func_0BDC::func_1996();
  var_02 = var_1.speed;
  var_03 = 1.0 * scripts\engine\utility::mph_to_ips(var_02);
  var_04 = distancesquared(self.origin, getcsplinepointposition(self.var_3135.func_3F28["spline"], self.var_3135.func_3F28["node"]));

  if(var_04 < var_03 * var_03) {
    return anim.success;
  }

  return anim.failure;
}

func_10015(var_00) {
  var_01 = self.var_1198.func_7235.target;

  if(!isDefined(var_01)) {
    return anim.failure;
  }

  if(issentient(var_01) && !isalive(var_01)) {
    return anim.failure;
  }

  return anim.success;
}

func_7221(var_00) {
  if(!self.var_1198.func_7235.func_7237) {
    self notify("in_follow_position");

    if(isDefined(self.var_1198.func_7235.func_98F9)) {
      self _meth_848D(self.var_1198.func_7235.target, self.var_1198.func_7235.offset, 1.0, self.var_1198.func_7235.func_98F9, self.var_1198.func_7235.func_98FE, self.var_1198.func_7235.func_C760, self.var_1198.func_7235.func_C765);
    }
    else {
      self _meth_848D(self.var_1198.func_7235.target, self.var_1198.func_7235.offset, 1.0);
    }

    self.var_1198.func_7235.func_7237 = 1;
  }
}

func_7231(var_00) {
  if(!isalive(self.var_1198.func_7235.target) && !self.var_1198.animscriptedactive) {
    self _meth_8455(self.origin, 1);
  }

  self.var_1198.func_7235.func_7237 = 0;
}

follow(var_00) {
  if(isalive(self.var_1198.func_7235.target) && self.var_1198.func_7235.func_7237) {
    if(isDefined(self.var_1198.func_7235.target.bt) && self.var_1198.func_7235.target.var_3135.func_673F) {
      return anim.success;
    }

    var_01 = self _meth_8493();
    return anim.running;
  }

  return anim.success;
}

func_7EC1() {
  var_00 = self.var_1198.func_7235.target;
  var_01 = self.var_1198.func_7235.offset;
  var_02 = rotatevector(var_01, var_0.angles);
  var_03 = var_0.origin + var_02;
  return var_03;
}

func_10016(var_00) {
  var_01 = func_7EC1();
  var_02 = self.var_1198.func_7235.target;
  var_03 = length(var_2.spaceship_vel);
  var_04 = var_03 * 1.0;
  var_04 = max(16000000, var_04);

  if(distancesquared(self.origin, var_01) > var_04) {
    return anim.success;
  }

  return anim.failure;
}

func_A299(var_00, var_01) {
  if(isDefined(self.var_1198.func_C705)) {
    var_00 = self.var_1198.func_C705;

    if(isDefined(self.var_1198.func_C702)) {
      var_01 = self.var_1198.func_C702;
    }
  }

  self goon_spawners(var_00, var_01);
}

func_7233(var_00) {
  func_A299("face motion");
  self _meth_8459("face motion");
}

func_7232(var_00) {
  var_01 = self.var_1198.func_7235.target;
  var_02 = self.var_1198.func_7235.offset;
  var_03 = rotatevector(var_02, var_1.angles);
  var_04 = func_7EC1();
  self _meth_8455(var_04, 0);
  self setneargoalnotifydist(3000.0);

  if(_isaircraft(var_01)) {
    var_05 = func_0C21::_meth_814A();
    var_06 = var_5.speed;
    var_07 = getdvarint("spaceshipAiBoostSpeedScale");
    var_08 = length(var_1.spaceship_vel);
    var_09 = vectordot(var_1.spaceship_vel, self.spaceship_vel);

    if(var_09 > 0 && var_08 * 1.5 > var_06 * var_07) {
      var_06 = var_08 * 1.5 / var_07;
      self _meth_8459("always");
    }

    if(var_09 > 0 && var_08 * 1.5 > var_06) {
      self _meth_8459("always");
    }
    else {
      self _meth_8459("never");
    }

    self _meth_845F(var_06);
  }

  return anim.success;
}

func_7234(var_00) {
  var_01 = _getdvarvector("spaceshipAiBoostSpeed");
  self _meth_845F(var_1[0]);
}

func_7E67(var_00) {
  var_01 = scripts\engine\utility::array_find(level.func_90E2.func_5084, var_00);
  return var_01;
}

func_10027(var_00) {
  if(self.var_1198.func_90F3) {
    return anim.success;
  }

  if(func_D3B5()) {
    return anim.failure;
  }

  if(isalive(self.var_1198.func_90EE) && isalive(self.enemy) && self.var_1198.func_90EE == self.enemy) {
    return anim.success;
  }

  return anim.failure;
}

func_10075(var_00) {
  if(!isalive(self.enemy)) {
    return anim.failure;
  }

  if(!isDefined(self.var_1198.func_90DC)) {
    return anim.success;
  }

  if(!isalive(self.var_1198.func_90DA) || self.enemy != self.var_1198.func_90DA) {
    return anim.success;
  }

  if(distancesquared(self.var_1198.func_90DB, self.var_1198.func_90DA.origin) > 1000000) {
    return anim.success;
  }

  return anim.failure;
}

func_F748(var_00) {
  if(self.var_3135.func_BFA2 > gettime()) {
    return anim.success;
  }

  self.var_3135.func_BFA2 = gettime() + 400;
  self.var_1198.func_90DB = self.enemy.origin;
  self.var_1198.func_90DA = self.enemy;
  var_01 = func_3713(self.enemy);

  if(distancesquared(self.origin, var_01) <= 9000000) {
    return anim.failure;
  }

  self.var_1198.func_90DC = var_01;
  self setneargoalnotifydist(3000);
  self _meth_8455(var_01, 1);
  self.var_3135.func_3F28 = undefined;
  return anim.success;
}

func_41B6(var_00) {
  self.var_1198.func_90DB = undefined;
  self.var_1198.func_90DA = undefined;
  self.var_1198.func_90DC = undefined;
  return anim.success;
}

func_10028(var_00) {
  if(!isalive(self.enemy)) {
    return anim.failure;
  }

  var_01 = distancesquared(self.origin, self.enemy.origin);
  var_02 = distance(self.origin, self.enemy.origin);

  if(var_01 > 100000000) {
    return anim.success;
  }

  return anim.failure;
}

func_1002B(var_00) {
  var_01 = 2000;
  var_02 = 4000;

  if(!isalive(self.enemy)) {
    return anim.failure;
  }

  var_03 = level.player _meth_8473();

  if(self.enemy == level.func_D127 && isDefined(var_03) && var_03 == self.enemy) {
    var_04 = level.player _meth_848A();

    if(isDefined(var_04) && var_4[0] == self) {
      var_01 = 1300;
      var_02 = 1300;
    }
  }

  if(!isDefined(self.var_3135.instancedata[var_00])) {
    self.var_3135.instancedata[var_00] = [];
    self.var_3135.instancedata[var_00]["nextRepositionTime"] = gettime() + randomintrange(2000, 4000);
    return anim.failure;
  }

  if(gettime() >= self.var_3135.instancedata[var_00]["nextRepositionTime"]) {
    self.var_3135.instancedata[var_00]["nextRepositionTime"] = gettime() + randomintrange(2000, 4000);
    return anim.success;
  }

  return anim.failure;
}

func_90F2(var_00) {
  var_01 = func_3714(self.enemy);

  if(isDefined(var_01)) {
    if(distancesquared(self.origin, var_01) > 3000) {
      self _meth_8491("fly");
      func_0C21::func_20DD("fly");
    } else {
      self _meth_8491("hover");
      func_0C21::func_20DD("hover");
    }

    self.var_1198.func_90DC = var_01;
    self setneargoalnotifydist(512);
    self _meth_8455(var_01, 1);
  }

  return anim.success;
}

func_9E00(var_00) {
  var_01 = self _meth_8493();
  var_02 = var_01 == "follow" && self.var_1198.func_7235.func_7237;

  if(var_02) {
    return anim.success;
  }

  return anim.failure;
}

func_61C4(var_00) {
  return anim.success;
}

func_9E77(var_00) {
  if(_isaircraft(self.var_1198.func_7235.target) && self.var_1198.func_7235.target.spaceship_mode == "hover") {
    return anim.success;
  }

  return anim.failure;
}

func_9DE3(var_00) {
  if(self.var_3135.func_673F) {
    return anim.success;
  }
  else {
    return anim.failure;
  }
}

func_9F39() {
  if(self.var_3135.func_EF78) {
    return anim.success;
  }
  else {
    return anim.failure;
  }
}

func_9F74(var_00) {
  if(!isDefined(self.func_A420)) {
    return anim.failure;
  }

  foreach(var_02 in self.func_A420) {
    if(isalive(var_02) && var_02 func_9FBB() == anim.success) {
      return anim.success;
    }
  }

  return anim.failure;
}

func_9FBB(var_00) {
  if(self.var_3135.attackerdata.func_24D3 && func_9FD0() == anim.success) {
    return anim.success;
  }

  return anim.failure;
}

func_9EE9(var_00) {
  if(self.var_3135.func_5870) {
    return anim.success;
  }

  return anim.failure;
}

func_A533(var_00) {
  if(self.var_3135.func_A533) {
    return anim.success;
  }

  return anim.failure;
}

func_9E76(var_00) {
  if(_isaircraft(self.var_1198.func_7235.target) && isDefined(self.var_1198.func_7235.target.bt) && self.var_1198.func_7235.target.var_3135.func_673F) {
    return anim.success;
  }

  return anim.failure;
}

func_1000C(var_00) {
  if(func_9DE3(var_00) == anim.success && func_673D() == anim.success) {
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

func_673D(var_00) {
  if(func_118CD(self.var_3135.func_673E) < 4) {
    return anim.success;
  }

  return anim.failure;
}

func_9FD0(var_00) {
  if(!isDefined(self.var_3135.attackerdata.attacker)) {
    return anim.failure;
  }

  if(isDefined(level.func_D127) && self.var_3135.attackerdata.attacker == level.func_D127) {
    return anim.success;
  }

  return anim.failure;
}

func_1106C(var_00) {
  if(self.var_3135.func_673F) {
    self.var_3135.func_673F = 0;
  }

  return anim.success;
}

func_F6EC(var_00) {
  self.var_3135.func_673F = 1;
  self.var_3135.func_673E = gettime();
  return anim.success;
}

validatehighpriorityflag(var_00) {
  self.var_3135.func_673E = gettime();
  return anim.success;
}

func_1003F(var_00) {
  if(!isalive(self.enemy)) {
    return anim.success;
  }

  if(isDefined(self.var_1198.func_7002)) {
    return anim.failure;
  }

  if(self.var_1198.func_C97C) {
    return anim.success;
  }

  return anim.failure;
}

func_118CD(var_00) {
  var_01 = gettime() - var_00;
  return var_01 / 1000;
}

func_24D5(var_00) {
  if(func_118CD(self.var_3135.attackerdata.func_2535) < 6) {
    return anim.success;
  }

  return anim.failure;
}

func_FFD7(var_00) {
  if(func_9D6A() == anim.success) {
    return anim.success;
  }

  if(func_24D5() == anim.success) {
    return anim.success;
  }

  func_1106C(var_00);
  return anim.failure;
}

func_FFD8(var_00) {
  if(!isalive(self.enemy)) {
    return anim.success;
  }

  if(isDefined(self.var_1198.func_7002)) {
    return anim.failure;
  }

  if(self.var_1198.func_C97C) {
    return anim.success;
  }

  return anim.failure;
}

func_41E4(var_00) {
  if(isDefined(self.var_1198.func_10A4B)) {
    self.var_1198.func_10A4A = self.var_1198.func_10A4B;
  }
  else {
    self.var_1198.func_10A4A = undefined;
  }

  return anim.success;
}

func_8BEC(var_00) {
  if(isDefined(self.enemy)) {
    return anim.success;
  }

  return anim.failure;
}