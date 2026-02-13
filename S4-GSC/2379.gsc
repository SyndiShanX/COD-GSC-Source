/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2379.gsc
*************************************************/

_id_7EF3() {
  scripts\engine\utility::_id_5C11("armageddon_active");
  _id_C5A5();
  _id_7EF4();
  level._id_9EAC = 0.2;
  level._id_9C3E = 0.4;
  level._id_50EF = 10.0;
  level._id_1B18 = 20;
  level._id_1B19 = 0.15;
}

_id_1B1D() {
  _id_102F(level._id_1B18);
  level thread _id_4BDF(level._id_1B18);

  if(scripts\engine\utility::_id_5C00("armageddon_active")) {
    return;
  }
  scripts\engine\utility::_id_5C1B("armageddon_active");
  level thread _id_1B1C();
  level thread _id_E5A9(self);
}

_id_102F(var_0) {
  level._id_1B1B = level._id_1B1B + var_0;
}

_id_1B1C() {
  level endon("game_ended");

  while(level._id_1B1B > 0) {
    wait 1;
    level._id_1B1B--;
  }

  _id_C5A5();
  scripts\engine\utility::_id_5C04("armageddon_active");
  level notify("armageddon_timeout");
}

_id_E5A9(var_0) {
  level endon("game_ended");
  level endon("armageddon_timeout");

  for(;;) {
    var_1 = _id_C001();

    foreach(var_3 in var_1) {
      _id_4FF3(var_3, var_0);
      wait(randomfloatrange(level._id_9EAC, level._id_9C3E));
    }
  }
}

_id_C001() {
  var_0 = scripts\engine\utility::array_randomize(level._id_1B17);
  var_1 = [];
  var_2 = [];

  foreach(var_4 in var_0) {
    if(_id_1A4D(var_4)) {
      var_1[var_1.size] = var_4;
      continue;
    }

    var_2[var_2.size] = var_4;
  }

  var_0 = scripts\engine\utility::array_combine(var_1, var_2);
  return var_0;
}

_id_1A4D(var_0) {
  var_1 = min(var_0[0][0], var_0[1][0]);
  var_2 = max(var_0[0][0], var_0[1][0]);
  var_3 = min(var_0[0][1], var_0[1][1]);
  var_4 = max(var_0[0][1], var_0[1][1]);

  foreach(var_6 in level._id_E2A4) {
    if(var_1 <= var_6.origin[0] && var_6.origin[0] <= var_2 && (var_3 <= var_6.origin[1] && var_6.origin[1] <= var_4)) {
      return 1;
    }
  }

  return 0;
}

_id_4FF3(var_0, var_1) {
  var_2 = _id_6468(var_0);

  if(isDefined(var_1) && isPlayer(var_1)) {
    _func_0143("iw7_armageddonmeteor_mp", var_2._id_E59D, var_2._id_5284, var_1);
  } else {
    _func_0143("iw7_armageddonmeteor_mp", var_2._id_E59D, var_2._id_5284, level.players[0]);
  }
}

_id_6468(var_0) {
  if(_id_1A4D(var_0)) {
    return _id_647B(var_0);
  } else {
    return _id_66D9(var_0);
  }
}

_id_647B(var_0) {
  var_1 = spawnStruct();
  var_2 = min(var_0[0][0], var_0[1][0]);
  var_3 = max(var_0[0][0], var_0[1][0]);
  var_4 = min(var_0[0][1], var_0[1][1]);
  var_5 = max(var_0[0][1], var_0[1][1]);

  foreach(var_7 in level._id_E2A4) {
    if(var_2 <= var_7.origin[0] && var_7.origin[0] <= var_3 && (var_4 <= var_7.origin[1] && var_7.origin[1] <= var_5)) {
      var_1._id_E59D = (var_7.origin[0] + randomfloatrange(-2000, 2000), var_7.origin[1] + randomfloatrange(-2000, 2000), 8000 + randomfloatrange(-1000, 1000));
      var_1._id_5284 = var_7.origin;
      return var_1;
    }
  }
}

_id_66D9(var_0) {
  var_1 = spawnStruct();
  var_2 = min(var_0[0][0], var_0[1][0]);
  var_3 = max(var_0[0][0], var_0[1][0]);
  var_4 = min(var_0[0][1], var_0[1][1]);
  var_5 = max(var_0[0][1], var_0[1][1]);
  var_6 = randomfloatrange(var_2, var_3);
  var_7 = randomfloatrange(var_4, var_5);
  var_1._id_E59D = (var_6, var_7, 8000 + randomfloatrange(-1000, 1000));
  var_1._id_5284 = scripts\engine\utility::_id_5000((var_6 + randomfloatrange(-2000, 2000), var_7 + randomfloatrange(-2000, 2000), -8000), 72, -100) + (0, 0, 16);
  return var_1;
}

_id_C5A5() {
  level._id_1B1B = 0;
}

_id_885B(var_0) {
  if(!(isDefined(var_0) && var_0.basename == "iw7_armageddonmeteor_mp")) {
    return 0;
  }

  return !istrue(self._id_5CF9);
}

_id_5CFB(var_0, var_1, var_2) {
  if(istrue(self._id_5CF9)) {
    return;
  }
  self endon("death");
  self._id_5CF9 = 1;
  self._id_4C08 = 1;
  self._id_426B = 1;
  var_3 = (self.origin - var_0) * (1, 1, 0);
  var_3 = vectornormalize(var_3);
  var_3 = vectornormalize(var_3 + (0, 0, 1)) * 600;
  self setvelocity(var_3);
  wait 0.5;
  self._id_5CF9 = 0;
  self dodamage(self.maxhealth + 10000, var_1);
}

_id_4BDF(var_0) {
  wait 1.5;
  earthquake(level._id_1B19, var_0 + level._id_50EF, (742, -853, -85), 5000);
}

_id_7EF4() {
  level._id_1B17 = [];
  var_0 = scripts\engine\utility::getstructarray("armageddon_area_marker", "targetname");

  foreach(var_2 in var_0) {
    var_3 = [];
    var_4 = scripts\engine\utility::getstruct(var_2.target, "targetname");
    var_3[var_3.size] = var_2.origin;
    var_3[var_3.size] = var_4.origin;
    level._id_1B17[level._id_1B17.size] = var_3;
  }
}