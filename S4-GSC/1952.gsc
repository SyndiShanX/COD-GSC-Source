/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1952.gsc
*************************************************/

_id_178B(var_0, var_1) {
  return _func_0002(vectordot(var_0, var_1) / (length(var_0) * length(var_1)));
}

_id_178E(var_0, var_1) {
  return _func_0002(vectordot(var_0, var_1));
}

_id_178D(var_0, var_1, var_2) {
  var_3 = vectornormalize(var_0);
  var_4 = vectornormalize(var_1);
  var_5 = _func_0002(clamp(vectordot(var_3, var_4), -1, 1));
  var_6 = _func_025B(var_3, var_4);

  if(vectordot(var_6, var_2) < 0) {
    var_5 = var_5 * -1;
  }

  return var_5;
}

_id_91A9(var_0, var_1, var_2) {
  return var_0 + (var_1 - var_0) * var_2;
}

_id_91B2(var_0, var_1, var_2) {
  return (var_2 - var_0) / (var_1 - var_0);
}

_id_5902(var_0, var_1, var_2) {
  return (_id_1786(var_0[0], var_1[0], var_2), _id_1786(var_0[1], var_1[1], var_2), _id_1786(var_0[2], var_1[2], var_2));
}

_id_1786(var_0, var_1, var_2) {
  return _func_000A(var_0 + _func_000B(var_1 - var_0) * var_2);
}

_id_645E(var_0, var_1, var_2) {
  var_3 = vectornormalize(var_2 - var_0);
  var_4 = anglesToForward(var_1);
  var_5 = vectordot(var_4, var_3);
  return var_5;
}

_id_FFDC(var_0, var_1) {
  return vectornormalize(var_0 - vectordot(var_1, var_0) * var_1);
}

_id_FFDB(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_1);
  var_3 = var_3 * var_2;
  var_4 = var_0 + var_3;
  return var_4;
}

_id_FFDD(var_0, var_1) {
  return vectornormalize(2 * _id_FFDC(var_0, var_1) - var_0);
}

_id_FFD9(var_0, var_1, var_2) {
  return var_1[0] * var_2[1] - var_1[1] * var_2[0] + (var_2[0] * var_0[1] - var_0[0] * var_2[1]) + (var_0[0] * var_1[1] - var_1[0] * var_0[1]);
}

_id_CB75(var_0, var_1) {
  return vectordot(vectornormalize(var_0), var_1);
}

_id_66AE(var_0, var_1, var_2, var_3) {
  var_4 = var_3 * 2 - 1;
  var_5 = var_1 - var_0;
  var_6 = (0, 0, 1);
  var_7 = var_0 + var_3 * var_5;
  var_7 = var_7 + (var_4 * var_4 * -1 + 1) * var_2 * var_6;
  return var_7;
}

_id_65A3(var_0, var_1) {
  return ((var_0[0] + var_1[0]) * 0.5, (var_0[1] + var_1[1]) * 0.5, (var_0[2] + var_1[2]) * 0.5);
}

_id_C938(var_0, var_1, var_2) {
  var_3 = _id_C933(var_0[0], var_1, var_2);
  var_4 = _id_C933(var_0[1], var_1, var_2);
  var_5 = _id_C933(var_0[2], var_1, var_2);
  return (var_3, var_4, var_5);
}

_id_C933(var_0, var_1, var_2) {
  var_1 = int(var_1);

  if(var_1 < 0 || var_1 > 4) {
    return var_0;
  }

  var_3 = 1;

  for(var_4 = 1; var_4 <= var_1; var_4++) {
    var_3 = var_3 * 10;
  }

  var_5 = var_0 * var_3;

  if(!isDefined(var_2) || var_2) {
    var_5 = floor(var_5);
  } else {
    var_5 = _func_0037(var_5);
  }

  var_0 = var_5 / var_3;
  return var_0;
}

_id_C934(var_0, var_1, var_2) {
  var_3 = var_0 / 1000;
  var_3 = _id_C933(var_3, var_1, var_2);
  var_0 = var_3 * 1000;
  return int(var_0);
}

_id_C322(var_0, var_1, var_2, var_3, var_4) {
  return var_3 + (var_0 - var_1) * (var_4 - var_3) / (var_2 - var_1);
}

_id_A5C5(var_0, var_1, var_2) {
  if(var_0 > var_1) {
    var_3 = var_0;
    var_0 = var_1;
    var_1 = var_3;
  }

  if(var_2 > var_1) {
    return 1.0;
  } else if(var_2 < var_0) {
    return 0.0;
  } else if(var_0 == var_1) {}

  return (var_2 - var_0) / (var_1 - var_0);
}

_id_A5D1(var_0, var_1, var_2) {
  return (var_1 - var_0) * _func_0219(var_2) + var_0;
}

_id_A5D0(var_0, var_1, var_2) {
  return _id_A5D1(var_0, var_1, 1 - var_2);
}

_id_A5CD(var_0) {
  return -1 * _func_0219(2 * var_0 - 1) + 1;
}

_id_A5CE(var_0) {
  var_1 = var_0 * 2 * 3.14159 - 1.5708;
  var_1 = (sin(_id_BF1A(var_1)) + 1) * 0.5;
  return var_1;
}

_id_A5C7(var_0) {
  var_1 = var_0 * 2 * 3.14159;
  var_1 = (cos(_id_BF1A(var_1)) + 1) * 0.5;
  return var_1;
}

_id_BF1A(var_0) {
  return var_0 * 57.2958;
}

_id_4647(var_0) {
  return var_0 * 0.0174533;
}

_id_5898(var_0, var_1, var_2) {
  return var_1 * var_2 + var_0 * (1 - var_2);
}

_id_A5CB(var_0) {
  if(var_0 < 0.5) {
    var_0 = var_0 * 2;
    var_0 = _id_A5C9(var_0);
    var_0 = var_0 * 0.5;
  } else {
    var_0 = (var_0 - 0.5) * 2;
    var_0 = _id_A5CA(var_0);
    var_0 = var_0 * 0.5 + 0.5;
  }

  return var_0;
}

_id_A5C9(var_0) {
  return var_0 * var_0;
}

_id_A5CA(var_0) {
  var_0 = 1 - var_0;
  var_0 = var_0 * var_0;
  var_0 = 1 - var_0;
  return var_0;
}

_id_94E2(var_0, var_1, var_2, var_3) {
  var_4 = vectordot(var_3, var_2);
  var_5 = var_1 - var_0;
  var_6 = vectordot(var_3, var_5);

  if(var_6 == 0) {
    return undefined;
  }

  var_7 = (var_4 - vectordot(var_3, var_0)) / var_6;
  var_8 = var_0 + var_5 * var_7;
  return var_8;
}

project_point_onto_line_segment(var_0, var_1, var_2) {
  var_3 = distancesquared(var_0, var_1);

  if(var_3 == 0.0) {
    return var_0;
  }

  var_4 = max(0, min(1, vectordot(var_2 - var_0, var_1 - var_0) / var_3));
  return var_0 + var_4 * (var_1 - var_0);
}

distance_from_line_segment(var_0, var_1, var_2) {
  var_3 = distancesquared(var_0, var_1);

  if(var_3 == 0.0) {
    return distance(var_0, var_2);
  }

  var_4 = max(0, min(1, vectordot(var_2 - var_0, var_1 - var_0) / var_3));
  var_5 = var_0 + var_4 * (var_1 - var_0);
  return distance(var_2, var_5);
}

_id_C04F(var_0, var_1, var_2, var_3) {
  return vectordot(var_2 - var_0, var_3) / vectordot(var_1, var_3);
}

_id_D031(var_0, var_1, var_2, var_3) {
  if(var_0 == var_1) {
    return 0;
  }

  var_4 = var_2 - var_0;
  var_5 = var_1 - var_0;
  var_6 = clamp(vectordot(var_4, var_5) / vectordot(var_5, var_5), 0, 1);
  var_7 = var_0 + var_5 * var_6;
  return _func_0135(var_2 - var_7) <= var_3 * var_3;
}

_id_B9C2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = var_0 - var_1;
  var_9 = vectordot(var_8, var_2);
  var_10 = vectordot(var_8, var_3);

  if(var_9 > var_4) {
    return 0;
  }

  if(var_9 < var_5) {
    return 0;
  }

  if(isDefined(var_7)) {
    if(abs(var_10) > var_7) {
      return 0;
    }
  }

  if(_id_178B(var_2, var_8) > var_6) {
    return 0;
  }

  return 1;
}

_id_B9C3(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0 - var_3;
  var_6 = vectordot(var_5, var_4);

  if(var_6 < 0 || var_6 > var_2) {
    return 0;
  }

  var_5 = var_5 - var_6 * var_4;
  var_7 = _func_0135(var_5);

  if(var_7 > var_1) {
    return 0;
  }

  return 1;
}

_id_B9B1(var_0, var_1, var_2) {
  var_3 = _id_FFD9(var_0, var_1, var_2);

  if(var_3 > 0.0) {
    return "left";
  }

  return "right";
}

_id_10FA2(var_0, var_1, var_2) {
  var_3 = var_1 - var_0 + 1;

  if(var_2 < var_0) {
    var_2 = var_2 + var_3 * int((var_0 - var_2) / var_3 + 1);
  }

  return var_0 + (var_2 - var_0) % var_3;
}

_id_B9AB(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 0.766;
  }

  if(isPlayer(self)) {
    var_3 = anglesToForward(self getplayerangles(!istrue(var_2)));
  } else {
    var_3 = anglesToForward(self.angles);
  }

  var_4 = vectornormalize(var_0 - self.origin);
  var_5 = vectordot(var_3, var_4);
  return var_5 > var_1;
}

_id_10E77(var_0, var_1, var_2, var_3) {
  var_4 = vectornormalize((var_2[0], var_2[1], 0) - (var_0[0], var_0[1], 0));
  var_5 = anglesToForward((0, var_1[1], 0));
  return vectordot(var_5, var_4) >= var_3;
}

_id_867F(var_0) {
  var_1 = 0;

  if(isent(self) && isPlayer(self)) {
    var_2 = var_0 - self _meth_8169();
    var_3 = anglesToForward(self getplayerangles(1));
    var_1 = vectordot(var_2, var_3);
  } else {
    var_2 = var_0 - self.origin;
    var_3 = anglesToForward(self.angles);
    var_1 = vectordot(var_2, var_3);
  }

  return var_1 > 0;
}

_id_8680(var_0) {
  var_1 = 0;

  if(isPlayer(self)) {
    var_2 = var_0 - self _meth_8169();
    var_3 = anglestoright(self getplayerangles(1));
    var_1 = vectordot(var_2, var_3);
  } else {
    var_2 = var_0 - self.origin;
    var_3 = anglestoright(self.angles);
    var_1 = vectordot(var_2, var_3);
  }

  return var_1 > 0;
}

_id_BFF0() {
  var_0 = randomfloat(360);
  return (cos(var_0), sin(var_0), 0.0);
}

_id_D289(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = _func_025B(var_1, var_0);
  var_3 = _func_025B(var_0, var_2);
  self.angles = _func_0017(var_3, var_2, var_0);
}

_id_D28A(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self.angles;
  }

  self.angles = _id_2CCE(var_0, var_1);
}

_id_2CCE(var_0, var_1) {
  var_2 = _func_0002(-1 * vectordot(anglesToForward(var_1), var_0));
  var_3 = anglestoup(var_1 + (var_2, 0, 0));
  var_4 = _func_025B(var_3, var_0);
  var_3 = _func_025B(var_0, var_4);
  return _func_0017(var_3, var_4, var_0);
}

_id_4091(var_0, var_1, var_2) {
  thread _id_4092(var_0, var_1, var_2);
}

_id_4092(var_0, var_1, var_2) {
  self endon("death");
  self endon("stop_spring");

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = _id_E453(var_1, self.origin, anglesToForward(self.angles) * var_2);

  while(distancesquared(self.origin, var_0) > _func_0219(0.1)) {
    self.origin = _id_E458(var_3, var_0);
    wait 0.05;
  }

  self notify("movedone");
  _id_E44F(var_3);
}

_id_408F(var_0, var_1, var_2) {
  thread _id_4090(var_0, var_1, var_2);
}

_id_4090(var_0, var_1, var_2) {
  self endon("death");
  self endon("stop_spring");

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = _id_E453(var_1, self.origin, anglesToForward(self.angles) * var_2);

  while(distancesquared(self.origin, var_0) > _func_0219(0.1)) {
    self.origin = _id_E458(var_3, var_0);
    self.angles = vectortoangles(_id_E451(var_3));
    wait 0.05;
  }

  self notify("movedone");
  _id_E44F(var_3);
}

_id_AD1B(var_0, var_1, var_2, var_3) {
  thread _id_AD1C(var_0, var_1, var_2, var_3);
}

_id_AD1C(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("stop_spring");

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  var_4 = _id_E454(var_1, var_2, self.origin, anglesToForward(self.angles) * var_3);

  while(distancesquared(self.origin, var_0) > _func_0219(0.1)) {
    self.origin = _id_E458(var_4, var_0);
    wait 0.05;
  }

  self notify("movedone");
  _id_E44F(var_4);
}

_id_F93A(var_0, var_1, var_2, var_3) {
  thread _id_F93B(var_0, var_1, var_2, var_3);
}

_id_F93B(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("stop_spring");

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  var_4 = _id_E455(var_1, var_2, self.origin, anglesToForward(self.angles) * var_3);

  while(distancesquared(self.origin, var_0) > _func_0219(0.1) || length(_id_E451(var_4)) < _func_0219(0.1)) {
    self.origin = _id_E458(var_4, var_0);
    wait 0.05;
  }

  self notify("movedone");
  _id_E44F(var_4);
}

_id_E453(var_0, var_1, var_2) {
  var_3 = _id_E44D(var_1, var_2);
  var_4 = var_0 * 0.05;
  var_5 = _func_0065(-1 * var_4);
  level._id_E459[var_3]._id_2DF7 = (var_4 + 1) * var_5;
  level._id_E459[var_3]._id_2DF8 = var_5;
  level._id_E459[var_3]._id_2E3F = -1 * var_4 * var_4 * var_5;
  level._id_E459[var_3]._id_2E40 = (1 - var_4) * var_5;
  _id_E456(var_3, var_1);
  _id_E457(var_3, var_2);
  return var_3;
}

_id_E454(var_0, var_1, var_2, var_3) {
  var_4 = _id_E44D(var_2, var_3);
  var_5 = var_0 * var_0;
  var_6 = -1 * _func_0218(var_1 * var_1 + 4.0 * var_5);
  var_7 = 0.5 * (var_6 + var_1);
  var_8 = 0.5 * (var_6 - var_1);
  var_9 = var_8 - var_7;
  var_10 = 1.0 / var_9;
  var_11 = _func_0065(var_7 * 0.05);
  var_12 = _func_0065(var_8 * 0.05);
  var_13 = var_12 - var_11;
  level._id_E459[var_4]._id_2DF8 = var_13 * var_10;
  level._id_E459[var_4]._id_2DF7 = var_11 - var_7 * level._id_E459[var_4]._id_2DF8;
  level._id_E459[var_4]._id_2E40 = (var_8 * var_12 - var_7 * var_11) * var_10;
  level._id_E459[var_4]._id_2E3F = var_7 * (var_11 - level._id_E459[var_4]._id_2E40);
  _id_E456(var_4, var_2);
  _id_E457(var_4, var_3);
  return var_4;
}

_id_E455(var_0, var_1, var_2, var_3) {
  var_4 = _id_E44D(var_2, var_3);
  var_5 = -0.5 * var_1;
  var_6 = var_0;
  var_7 = _func_0065(var_5 * 0.05) / var_6;
  var_8 = _func_000A(var_6 * 0.05);
  var_9 = sin(var_8);
  var_10 = cos(var_8);
  var_11 = var_6 * var_10;
  var_12 = var_5 * var_9;
  level._id_E459[var_4]._id_2DF7 = var_7 * (var_11 - var_12);
  level._id_E459[var_4]._id_2DF8 = var_7 * var_9;
  level._id_E459[var_4]._id_2E3F = var_7 * -1 * var_9 * (var_5 * var_5 + var_6 * var_6);
  level._id_E459[var_4]._id_2E40 = var_7 * (var_11 + var_12);
  _id_E456(var_4, var_2);
  _id_E457(var_4, var_3);
  return var_4;
}

_id_E458(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2)) {
    _id_E456(var_0, var_2);
  }

  if(isDefined(var_3)) {
    _id_E457(var_0, var_3);
  }

  var_4 = level._id_E459[var_0]._id_B9FE - var_1;
  var_5 = level._id_E459[var_0]._id_2DF7 * var_4 + level._id_E459[var_0]._id_2DF8 * level._id_E459[var_0]._id_10399;
  var_6 = level._id_E459[var_0]._id_2E3F * var_4 + level._id_E459[var_0]._id_2E40 * level._id_E459[var_0]._id_10399;
  level._id_E459[var_0]._id_B9FE = var_5 + var_1;
  level._id_E459[var_0]._id_10399 = var_6;
  return level._id_E459[var_0]._id_B9FE;
}

_id_E44F(var_0) {
  level._id_E459[var_0] = undefined;
}

_id_E450(var_0) {
  return level._id_E459[var_0]._id_B9FE;
}

_id_E451(var_0) {
  return level._id_E459[var_0]._id_10399;
}

_id_E452() {
  if(!isDefined(level._id_E459)) {
    level._id_E459 = [];
    level._id_E44E = 0;
  }
}

_id_E44D(var_0, var_1) {
  _id_E452();
  var_2 = level._id_E44E;
  level._id_E44E++;
  level._id_E459[var_2] = spawnStruct();
  level._id_E459[var_2]._id_B9FE = var_0;
  level._id_E459[var_2]._id_10399 = var_1;
  level._id_E459[var_2]._id_2DF7 = 0;
  level._id_E459[var_2]._id_2DF8 = 0;
  level._id_E459[var_2]._id_2E3F = 0;
  level._id_E459[var_2]._id_2E40 = 0;
  return var_2;
}

_id_E456(var_0, var_1) {
  level._id_E459[var_0]._id_B9FE = var_1;
}

_id_E457(var_0, var_1) {
  level._id_E459[var_0]._id_10399 = var_1;
}

_id_870D(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0.001;
  }

  return abs(var_0[0] - var_1[0]) < var_2 && abs(var_0[1] - var_1[1]) < var_2 && abs(var_0[2] - var_1[2]) < var_2;
}

_id_85D6(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0.001;
  }

  return abs(var_0 - var_1) < 0.001;
}