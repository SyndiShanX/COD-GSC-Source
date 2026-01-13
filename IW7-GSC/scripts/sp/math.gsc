/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\sp\math.gsc
*********************************************/

func_AB6F(var_0, var_1, var_2) {
  return var_0 + var_1 - var_0 * var_2;
}

func_AB7D(var_0, var_1, var_2) {
  return var_2 - var_0 / var_1 - var_0;
}

func_13198(var_0, var_1) {
  return vectornormalize(var_0 - vectordot(var_1, var_0) * var_1);
}

func_13199(var_0, var_1) {
  return vectornormalize(2 * func_13198(var_0, var_1) - var_0);
}

func_7BC5(var_0, var_1, var_2, var_3) {
  var_4 = var_3 * 2 - 1;
  var_5 = var_1 - var_0;
  var_6 = (0, 0, 1);
  var_7 = var_0 + var_3 * var_5;
  var_7 = var_7 + var_4 * var_4 * -1 + 1 * var_2 * var_6;
  return var_7;
}

func_DF68(var_0, var_1, var_2, var_3, var_4) {
  return var_3 + var_0 - var_1 * var_4 - var_3 / var_2 - var_1;
}

func_C097(var_0, var_1, var_2) {
  if(var_0 > var_1) {
    var_3 = var_0;
    var_0 = var_1;
    var_1 = var_3;
  }

  if(var_2 > var_1) {
    return 1;
  } else if(var_2 < var_0) {
    return 0;
  } else if(var_0 == var_1) {}

  return var_2 - var_0 / var_1 - var_0;
}

func_6A8E(var_0, var_1, var_2) {
  return var_1 * var_2 + var_0 * 1 - var_2;
}

func_C09C(var_0) {
  if(var_0 < 0.5) {
    var_0 = var_0 * 2;
    var_0 = func_C09A(var_0);
    var_0 = var_0 * 0.5;
  } else {
    var_0 = var_0 - 0.5 * 2;
    var_0 = func_C09B(var_0);
    var_0 = var_0 * 0.5 + 0.5;
  }

  return var_0;
}

func_C09A(var_0) {
  return var_0 * var_0;
}

func_C09B(var_0) {
  var_0 = 1 - var_0;
  var_0 = var_0 * var_0;
  var_0 = 1 - var_0;
  return var_0;
}

func_ACE9(var_0, var_1, var_2, var_3) {
  var_4 = vectordot(var_3, var_2);
  var_5 = var_1 - var_0;
  var_6 = vectordot(var_3, var_5);
  if(var_6 == 0) {
    return undefined;
  }

  var_7 = var_4 - vectordot(var_3, var_0) / var_6;
  var_8 = var_0 + var_5 * var_7;
  return var_8;
}

func_13DE5(var_0, var_1, var_2) {
  while(var_2 > var_1) {
    var_2 = var_2 - var_1 - var_0 + 1;
  }

  return var_2;
}

func_6B04(var_0, var_1, var_2) {
  return (func_1E78(var_0[0], var_1[0], var_2), func_1E78(var_0[1], var_1[1], var_2), func_1E78(var_0[2], var_1[2], var_2));
}

func_1E78(var_0, var_1, var_2) {
  return angleclamp(var_0 + angleclamp180(var_1 - var_0) * var_2);
}

func_9C85(var_0) {
  var_1 = 0;
  if(isplayer(self)) {
    var_2 = var_0 - self getorigin();
    var_3 = anglesToForward(self getplayerangles(1));
    var_1 = vectordot(var_2, var_3);
  } else {
    var_2 = var_2 - self.origin;
    var_3 = anglesToForward(self.angles);
    var_1 = vectordot(var_2, var_3);
  }

  return var_1 > 0;
}

func_9C86(var_0) {
  var_1 = 0;
  if(isplayer(self)) {
    var_2 = var_0 - self getorigin();
    var_3 = anglestoright(self getplayerangles(1));
    var_1 = vectordot(var_2, var_3);
  } else {
    var_2 = var_2 - self.origin;
    var_3 = anglestoright(self.angles);
    var_1 = vectordot(var_2, var_3);
  }

  return var_1 > 0;
}

func_7ADE(var_0, var_1) {
  return (var_0[0] + var_1[0] * 0.5, var_0[1] + var_1[1] * 0.5, var_0[2] + var_1[2] * 0.5);
}

func_F47E(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = vectorcross(var_1, var_0);
  var_3 = vectorcross(var_0, var_2);
  self.angles = axistoangles(var_3, var_2, var_0);
}

func_DCA0() {
  var_0 = randomfloat(360);
  return (cos(var_0), sin(var_0), 0);
}

func_F47F(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self.angles;
  }

  self.angles = func_31AB(var_0, var_1);
}

func_31AB(var_0, var_1) {
  var_2 = acos(-1 * vectordot(anglesToForward(var_1), var_0));
  var_3 = anglestoup(var_1 + (var_2, 0, 0));
  var_4 = vectorcross(var_3, var_0);
  var_3 = vectorcross(var_0, var_4);
  return axistoangles(var_3, var_4, var_0);
}

func_4A7B(var_0, var_1, var_2) {
  thread func_4A7C(var_0, var_1, var_2);
}

func_4A7C(var_0, var_1, var_2) {
  self endon("death");
  self endon("stop_spring");
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = func_10AAE(var_1, self.origin, anglesToForward(self.angles) * var_2);
  while(distancesquared(self.origin, var_0) > squared(0.1)) {
    self.origin = func_10AB4(var_3, var_0);
    wait(0.05);
  }

  self notify("movedone");
  func_10AAA(var_3);
}

func_4A79(var_0, var_1, var_2) {
  thread func_4A7A(var_0, var_1, var_2);
}

func_4A7A(var_0, var_1, var_2) {
  self endon("death");
  self endon("stop_spring");
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = func_10AAE(var_1, self.origin, anglesToForward(self.angles) * var_2);
  while(distancesquared(self.origin, var_0) > squared(0.1)) {
    self.origin = func_10AB4(var_3, var_0);
    self.angles = vectortoangles(func_10AAC(var_3));
    wait(0.05);
  }

  self notify("movedone");
  func_10AAA(var_3);
}

func_C7E2(var_0, var_1, var_2, var_3) {
  thread func_C7E3(var_0, var_1, var_2, var_3);
}

func_C7E3(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("stop_spring");
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  var_4 = func_10AAF(var_1, var_2, self.origin, anglesToForward(self.angles) * var_3);
  while(distancesquared(self.origin, var_0) > squared(0.1)) {
    self.origin = func_10AB4(var_4, var_0);
    wait(0.05);
  }

  self notify("movedone");
  func_10AAA(var_4);
}

func_12B88(var_0, var_1, var_2, var_3) {
  thread func_12B89(var_0, var_1, var_2, var_3);
}

func_12B89(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("stop_spring");
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  var_4 = func_10AB0(var_1, var_2, self.origin, anglesToForward(self.angles) * var_3);
  while(distancesquared(self.origin, var_0) > squared(0.1) || length(func_10AAC(var_4)) < squared(0.1)) {
    self.origin = func_10AB4(var_4, var_0);
    wait(0.05);
  }

  self notify("movedone");
  func_10AAA(var_4);
}

func_10AAE(var_0, var_1, var_2) {
  var_3 = func_10AA8(var_1, var_2);
  var_4 = var_0 * 0.05;
  var_5 = exp(-1 * var_4);
  level.var_10AB5[var_3].var_332A = var_4 + 1 * var_5;
  level.var_10AB5[var_3].var_332B = var_5;
  level.var_10AB5[var_3].var_332C = -1 * var_4 * var_4 * var_5;
  level.var_10AB5[var_3].var_332D = 1 - var_4 * var_5;
  func_10AB2(var_3, var_1);
  func_10AB3(var_3, var_2);
  return var_3;
}

func_10AAF(var_0, var_1, var_2, var_3) {
  var_4 = func_10AA8(var_2, var_3);
  var_5 = var_0 * var_0;
  var_6 = -1 * sqrt(var_1 * var_1 + 4 * var_5);
  var_7 = 0.5 * var_6 + var_1;
  var_8 = 0.5 * var_6 - var_1;
  var_9 = var_8 - var_7;
  var_0A = 1 / var_9;
  var_0B = exp(var_7 * 0.05);
  var_0C = exp(var_8 * 0.05);
  var_0D = var_0C - var_0B;
  level.var_10AB5[var_4].var_332B = var_0D * var_0A;
  level.var_10AB5[var_4].var_332A = var_0B - var_7 * level.var_10AB5[var_4].var_332B;
  level.var_10AB5[var_4].var_332D = var_8 * var_0C - var_7 * var_0B * var_0A;
  level.var_10AB5[var_4].var_332C = var_7 * var_0B - level.var_10AB5[var_4].var_332D;
  func_10AB2(var_4, var_2);
  func_10AB3(var_4, var_3);
  return var_4;
}

func_10AB0(var_0, var_1, var_2, var_3) {
  var_4 = func_10AA8(var_2, var_3);
  var_5 = -0.5 * var_1;
  var_6 = var_0;
  var_7 = exp(var_5 * 0.05) / var_6;
  var_8 = angleclamp(var_6 * 0.05);
  var_9 = sin(var_8);
  var_0A = cos(var_8);
  var_0B = var_6 * var_0A;
  var_0C = var_5 * var_9;
  level.var_10AB5[var_4].var_332A = var_7 * var_0B - var_0C;
  level.var_10AB5[var_4].var_332B = var_7 * var_9;
  level.var_10AB5[var_4].var_332C = var_7 * -1 * var_9 * var_5 * var_5 + var_6 * var_6;
  level.var_10AB5[var_4].var_332D = var_7 * var_0B + var_0C;
  func_10AB2(var_4, var_2);
  func_10AB3(var_4, var_3);
  return var_4;
}

func_10AB4(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2)) {
    func_10AB2(var_0, var_2);
  }

  if(isDefined(var_3)) {
    func_10AB3(var_0, var_3);
  }

  var_4 = level.var_10AB5[var_0].pos - var_1;
  var_5 = level.var_10AB5[var_0].var_332A * var_4 + level.var_10AB5[var_0].var_332B * level.var_10AB5[var_0].var_1326C;
  var_6 = level.var_10AB5[var_0].var_332C * var_4 + level.var_10AB5[var_0].var_332D * level.var_10AB5[var_0].var_1326C;
  level.var_10AB5[var_0].pos = var_5 + var_1;
  level.var_10AB5[var_0].var_1326C = var_6;
  return level.var_10AB5[var_0].pos;
}

func_10AAA(var_0) {
  level.var_10AB5[var_0] = undefined;
}

func_10AAB(var_0) {
  return level.var_10AB5[var_0].pos;
}

func_10AAC(var_0) {
  return level.var_10AB5[var_0].var_1326C;
}

func_10AAD() {
  if(!isDefined(level.var_10AB5)) {
    level.var_10AB5 = [];
    level.var_10AA9 = 0;
  }
}

func_10AA8(var_0, var_1) {
  func_10AAD();
  var_2 = level.var_10AA9;
  level.var_10AA9++;
  level.var_10AB5[var_2] = spawnStruct();
  level.var_10AB5[var_2].pos = var_0;
  level.var_10AB5[var_2].var_1326C = var_1;
  level.var_10AB5[var_2].var_332A = 0;
  level.var_10AB5[var_2].var_332B = 0;
  level.var_10AB5[var_2].var_332C = 0;
  level.var_10AB5[var_2].var_332D = 0;
  return var_2;
}

func_10AB2(var_0, var_1) {
  level.var_10AB5[var_0].pos = var_1;
}

func_10AB3(var_0, var_1) {
  level.var_10AB5[var_0].var_1326C = var_1;
}

func_D638(var_0, var_1, var_2, var_3) {
  return squared(var_0[0] - var_1[0]) / squared(var_2) + squared(var_0[1] - var_1[1]) / squared(var_3) <= 1;
}

func_EB9B(var_0, var_1) {
  return vectordot(vectornormalize(var_0), var_1);
}