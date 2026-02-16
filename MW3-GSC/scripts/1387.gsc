/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1387.gsc
**************************************/

_id_436C() {
  common_scripts\utility::create_dvar("vehicle_spline_debug", 0);
  level._id_436D = -2000;
  level._id_436E = 6;
  level._id_436F = spawn("script_origin", level.player.origin + (0, 0, 88));
  level._id_436F linkto(level.player);
  level._id_2AFC = _id_4371();
  common_scripts\utility::flag_init("ai_snowmobiles_ram_player");
  common_scripts\utility::flag_set("ai_snowmobiles_ram_player");
  var_0 = getEntArray("enable_spline_path", "targetname");
  common_scripts\utility::array_thread(var_0, ::_id_4370);
}

_id_4370() {
  for(;;) {
    self waittill("trigger", var_0);
    var_0 notify("enable_spline_path");
  }
}

_id_4371() {
  level._id_2A50 = ::_id_43A2;
  var_0 = _id_4377();
  common_scripts\utility::flag_init("race_complete");
  level._id_4372 = spawn("script_model", (0, 0, 0));
  level._id_4372 setModel("tag_origin");
  level._id_2AFD = [];
  level._id_4373 = 0;
  level.player thread _id_4374();
  return var_0;
}

_id_4374() {
  self waittill("death");
}

_id_4375() {
  var_0 = getent("spawner", "targetname");
  var_0.count = 1;
  var_0.origin = self.origin;
  var_0.angles = (0, self.angles[1], 0);
  return var_0 stalingradspawn();
}

_id_4376(var_0) {
  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    self orientmode("face angle", var_0);
    wait 0.05;
  }
}

_id_4377() {
  var_0 = _id_4384();
  level._id_2AFC = var_0;
  _id_438B(var_0);
  return var_0;
}

_id_4378(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 = maps\_utility::_id_2281(var_0);
  var_1 = maps\_utility::_id_2281(var_1);
  thread maps\_debug::_id_1A17(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_4379(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_1 = (var_1[0], var_1[1], var_0);
  var_1 = maps\_utility::_id_2281(var_1);
  var_2 = (var_2[0], var_2[1], var_0);
  var_2 = maps\_utility::_id_2281(var_2);
  thread maps\_debug::_id_1A17(var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_437A(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    var_5 = vectortoangles(var_4._id_437B._id_437C - var_4._id_437C);
    var_6 = anglesToForward(var_5) * var_4._id_437D;
    var_7 = var_4._id_437E * 0.5;
    var_8 = _id_43BD(var_4, 0, var_7);
    var_9 = _id_43BD(var_4, var_4._id_437D, var_7);
    _id_4379(var_4.z, var_8, var_9, (0, 0.5, 1), 1, 1, 50000);
    var_10 = _id_43BD(var_4, 0, var_7 * -1);
    var_11 = _id_43BD(var_4, var_4._id_437D, var_7 * -1);
    _id_4379(var_4.z, var_10, var_11, (0, 0.5, 1), 1, 1, 50000);
    _id_4379(var_4.z, var_8, var_10, (0, 0.5, 1), 1, 1, 50000);
    _id_4379(var_4.z, var_9, var_11, (0, 0.5, 1), 1, 1, 50000);

    foreach(var_13 in var_4._id_437F) {}
    var_4 _id_4382(var_4.z, var_13);

    foreach(var_16 in var_4._id_4380) {
      var_17 = var_16.origin;
      var_18 = var_16._id_4381.origin;
      _id_4379(var_4.z, var_17, var_18, (1, 0, 0), 1, 1, 50000);
    }
  }
}

_id_4382(var_0, var_1) {
  var_2 = _id_43BD(self, var_1["min"], var_1["left_offset"]);
  var_3 = _id_43BD(self, var_1["max"], var_1["left_offset"]);
  _id_4379(var_0, var_2, var_3, (0.5, 0, 1), 1, 1, 50000);
  var_2 = _id_43BD(self, var_1["min"], var_1["right_offset"]);
  var_3 = _id_43BD(self, var_1["max"], var_1["right_offset"]);
  _id_4379(var_0, var_2, var_3, (0.5, 0, 1), 1, 1, 50000);
  var_2 = _id_43BD(self, var_1["min"], var_1["right_offset"]);
  var_3 = _id_43BD(self, var_1["min"], var_1["left_offset"]);
  _id_4379(var_0, var_2, var_3, (0.5, 0, 1), 1, 1, 50000);
  var_2 = _id_43BD(self, var_1["max"], var_1["right_offset"]);
  var_3 = _id_43BD(self, var_1["max"], var_1["left_offset"]);
  _id_4379(var_0, var_2, var_3, (0.5, 0, 1), 1, 1, 50000);
}

_id_4383(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;
  var_6 = _id_43BD(var_5, var_1["min"], var_1[var_2]);
  var_7 = _id_43BD(var_5, var_1["max"], var_1[var_2]);
  _id_4379(var_0, var_6, var_7, (0.5, 0, 1), 1, 1, 50000);
}

_id_4384() {
  var_0 = common_scripts\utility::getstruct("road_path_left", "targetname");
  var_1 = [];
  var_0.origin = (var_0.origin[0], var_0.origin[1], 0);
  var_2 = 0;
  var_3 = var_0;

  for(;;) {
    var_4 = var_0;

    if(isDefined(var_0.target)) {
      var_4 = common_scripts\utility::getstruct(var_0.target, "targetname");
    }
    var_4.origin = (var_4.origin[0], var_4.origin[1], 0);
    var_1[var_1.size] = var_0;
    var_0._id_437B = var_4;
    var_0._id_4385 = var_3;
    var_4._id_4386 = var_0;
    var_0._id_4380 = [];
    var_0._id_437F = [];
    var_0._id_4387 = [];
    var_0._id_4388 = [];
    var_0._id_4389 = [];
    var_0._id_4388["left"] = var_0.origin;
    var_0.index = var_2;
    var_2++;

    if(var_0 == var_4) {
      break;
    }

    var_3 = var_0;
    var_0 = var_4;
  }

  var_0 = common_scripts\utility::getstruct("road_path_right", "targetname");
  var_0.origin = (var_0.origin[0], var_0.origin[1], 0);
  var_5 = 0;

  for(;;) {
    var_4 = var_0;

    if(isDefined(var_0.target)) {
      var_4 = common_scripts\utility::getstruct(var_0.target, "targetname");
    }
    var_4.origin = (var_4.origin[0], var_4.origin[1], 0);
    var_6 = var_1[var_5];
    var_6._id_4388["right"] = var_0.origin;
    var_6._id_437E = distance(var_6._id_4388["right"], var_6._id_4388["left"]);
    var_5++;

    if(var_0 == var_4) {
      break;
    }

    var_0 = var_4;
  }

  foreach(var_8 in var_1) {}
  var_8._id_437C = (var_8._id_4388["left"] + var_8._id_4388["right"]) * 0.5;

  foreach(var_8 in var_1) {
    var_11 = var_8._id_437C;
    var_12 = var_8._id_437B._id_437C;
    var_13 = vectortoangles(var_11 - var_12);
    var_14 = anglestoright(var_13);
    var_15 = var_8._id_437E * 0.5;
    var_8._id_4388["left"] = var_8._id_437C + var_14 * var_15;
    var_8._id_4388["right"] = var_8._id_437C + var_14 * var_15 * -1;
  }

  var_8 = var_1[var_1.size - 1]._id_437B;
  var_8._id_437C = (var_8._id_4388["left"] + var_8._id_4388["right"]) * 0.5;

  foreach(var_8 in var_1) {
    var_8._id_437D = distance(var_8._id_437C, var_8._id_437B._id_437C);
    var_8._id_4389["left"] = distance(var_8._id_4388["left"], var_8._id_437B._id_4388["left"]);
    var_8._id_4389["right"] = distance(var_8._id_4388["right"], var_8._id_437B._id_4388["right"]);
  }

  return var_1;
}

_id_438A(var_0) {
  var_1 = self;

  foreach(var_3 in var_0) {
    var_3.origin = var_3.origin + (0, 0, 20);
    var_4 = physicstrace(var_3.origin, var_3.origin + (0, 0, -100));
    var_3.origin = var_4;
  }
}

_id_438B(var_0) {
  var_1 = common_scripts\utility::getStructArray("moto_line", "targetname");

  foreach(var_3 in var_1) {
    var_3.origin = (var_3.origin[0], var_3.origin[1], 0);
    var_4 = common_scripts\utility::getstruct(var_3.target, "targetname");
    var_3._id_4381 = var_4;
    var_4._id_4381 = var_3;
  }

  foreach(var_3 in var_1) {}

  var_8 = self;

  foreach(var_10 in var_0) {
    foreach(var_3 in var_1) {}
    _id_438D(var_10, var_3);
  }

  var_14 = getEntArray("moto_collision", "targetname");

  foreach(var_16 in var_14) {
    var_17 = maps\_utility::_id_0AEC(var_16.origin, var_0, undefined, 2);

    foreach(var_10 in var_17) {}
    var_10._id_4387[var_10._id_4387.size] = var_16;
  }
}

_id_438C(var_0, var_1, var_2, var_3) {
  var_4 = distance(var_0._id_437C, var_1._id_437C);
  var_5 = 1 - var_2 / var_4;
  var_6 = "left";

  if(var_3 > 0) {
    var_6 = "right";
  }
  var_7 = var_0._id_4388[var_6];
  var_8 = var_1._id_4388[var_6];
  var_9 = var_7 * var_5 + var_8 * (1 - var_5);
  var_10 = var_0._id_437C;
  var_11 = var_1._id_437C;
  var_12 = var_10 * var_5 + var_11 * (1 - var_5);
  var_13 = distance(var_12, var_9);
  return var_3 / var_13;
}

_id_438D(var_0, var_1) {
  if(var_0 == var_0._id_437B) {
    return;
  }
  var_2 = var_0._id_437E;

  if(var_0._id_437D > var_2) {
    var_2 = var_0._id_437D;
  }
  if(distance(var_1.origin, var_0._id_437B._id_437C) > var_2 * 1.5) {
    return;
  }
  var_3 = common_scripts\utility::getstruct(var_1.target, "targetname");
  var_4 = _id_4392(var_1.origin, var_0._id_437C, var_0._id_437B._id_437C);
  var_5 = var_4["progress"];
  var_6 = _id_4392(var_3.origin, var_0._id_437C, var_0._id_437B._id_437C);
  var_7 = var_6["progress"];

  if(var_5 < 0 || var_7 < 0) {
    return;
  }
  if(var_5 > var_0._id_437D && var_7 > var_0._id_437D) {
    return;
  }
  var_1._id_2233 = 1;
  var_3._id_2233 = 1;
  var_1._id_3F42 = var_5;
  var_1.offset = var_4["offset"];
  var_1._id_438E = _id_438C(var_0, var_0._id_437B, var_5, var_4["offset"]);
  var_3._id_3F42 = var_7;
  var_3.offset = var_6["offset"];
  var_3._id_438E = _id_438C(var_0, var_0._id_437B, var_7, var_6["offset"]);
  var_1.origin = (var_1.origin[0], var_1.origin[1], var_0._id_437C[2] + 40);
  var_3.origin = (var_3.origin[0], var_3.origin[1], var_0._id_437C[2] + 40);

  if(var_5 < var_7) {
    _id_438F(var_0, var_1, var_3);
    var_0._id_4380[var_0._id_4380.size] = var_1;
  } else {
    _id_438F(var_0, var_3, var_1);
    var_0._id_4380[var_0._id_4380.size] = var_3;
  }
}

_id_438F(var_0, var_1, var_2) {
  var_3 = var_2._id_3F42 + 500;
  var_4 = var_1._id_3F42 - level._id_4390;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;

  if(var_2.offset > var_1.offset) {
    var_5 = var_2.offset;
    var_6 = var_1.offset;
    var_7 = var_2._id_438E;
    var_8 = var_1._id_438E;
  } else {
    var_5 = var_1.offset;
    var_6 = var_2.offset;
    var_7 = var_1._id_438E;
    var_8 = var_2._id_438E;
  }

  var_9 = var_0;
  var_10 = var_3;
  var_11 = var_4;

  for(;;) {
    _id_4391(var_0, var_3, var_4, var_5, var_6, var_7, var_8);

    if(!isDefined(var_0._id_437B)) {
      break;
    }

    if(var_0._id_437D >= var_3) {
      break;
    }

    var_3 = var_3 - var_0._id_437D;
    var_0 = var_0._id_437B;
    var_4 = 0;
  }

  var_0 = var_9;
  var_3 = var_10;
  var_4 = var_11;

  for(;;) {
    if(!isDefined(var_0._id_4386)) {
      break;
    }

    if(var_4 > 0) {
      break;
    }

    var_0 = var_0._id_4386;
    var_3 = var_0._id_437D;
    var_4 = var_0._id_437D + var_4;
    _id_4391(var_0, var_3, var_4, var_5, var_6, var_7, var_8);
  }
}

_id_4391(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = [];
  var_7["max"] = var_1;

  if(var_7["max"] > var_0._id_437D) {
    var_7["max"] = var_0._id_437D;
  }
  var_7["min"] = var_2;

  if(var_7["min"] < 0) {
    var_7["min"] = 0;
  }
  var_7["left_offset"] = var_4;
  var_7["right_offset"] = var_3;
  var_7["left_offset_percent"] = var_6;
  var_7["right_offset_percent"] = var_5;
  var_7["mid_offset"] = (var_3 + var_4) * 0.5;
  var_7["mid_offset_percent"] = (var_5 + var_6) * 0.5;
  var_0._id_437F[var_0._id_437F.size] = var_7;
}

_id_4392(var_0, var_1, var_2) {
  var_1 = (var_1[0], var_1[1], 0);
  var_2 = (var_2[0], var_2[1], 0);
  var_0 = (var_0[0], var_0[1], 0);
  var_3 = [];
  var_4 = vectortoangles(var_2 - var_1);
  var_5 = anglesToForward(var_4);
  var_6 = var_1;
  var_7 = vectornormalize(var_6 - var_0);
  var_8 = vectordot(var_5, var_7);
  var_9 = vectornormalize(var_2 - var_1);
  var_10 = var_0 - var_1;
  var_11 = vectordot(var_10, var_9);
  var_12 = var_1 + var_5 * var_11;
  var_3["progress"] = var_11;
  var_3["offset"] = distance(var_12, var_0);
  var_13 = anglestoright(var_4);
  var_7 = vectornormalize(var_12 - var_0);
  var_8 = vectordot(var_13, var_7);
  var_3["dot"] = var_8;

  if(var_8 > 0) {
    var_3["offset"] = var_3["offset"] * -1;
  }
  return var_3;
}

_id_4393(var_0) {
  foreach(var_2 in self._id_4394._id_4387) {
    var_3 = (self.origin[0], self.origin[1], 0);

    if(distance((var_2.origin[0], var_2.origin[1], 0), var_3) < var_2.radius) {
      return 1;
    }
  }

  if(var_0.health >= 100) {
    return 0;
  }
  level._id_4373++;
  return 1;
}

_id_4395(var_0) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    wait 0.05;
  }
}

_id_4396() {
  waittillframeend;

  if(!isDefined(self._id_0A39)) {
    return;
  }
  var_0 = "axis";

  if(common_scripts\utility::cointoss()) {
    var_0 = "allies";
  }
  foreach(var_2 in self._id_0A39) {}
  var_2.team = var_0;
}

_id_4397(var_0, var_1) {
  var_2 = _id_43BB(var_0, var_1);
  var_3 = var_2._id_3F42;
  var_4 = var_2._id_4394;
  var_5 = var_4._id_437E * 0.5;
  var_6 = undefined;

  if(isDefined(level.player.offset)) {
    var_7 = 500;

    if(common_scripts\utility::cointoss()) {
      var_7 = var_7 * -1;
    }
    var_6 = level.player.offset + var_7;
  } else {
    var_6 = randomfloatrange(var_5 * -1, var_5);
  }
  var_8 = _id_43AC(var_4, var_3, var_6);

  if(isDefined(var_8["dodge"])) {
    var_6 = var_8["dodge"];
  }
  var_9 = _id_43BC(var_4, var_3, var_6);
  var_10 = [];
  var_10["spawn_pos"] = var_9;
  var_10["progress"] = var_3;
  var_10["targ"] = var_4;
  var_10["offset"] = var_6;
  return var_10;
}

_id_4398() {}

_id_4399() {
  self endon("death");
  level endon("stop_debugging_enemy_vehicles");

  for(;;) {
    wait 0.05;
  }
}

_id_439A() {
  if(level._id_2AFD.size >= level._id_436E) {
    return;
  }
  var_0 = _id_43D1();
  var_1 = _id_43D0();
  var_2 = "forward";
  var_3 = _id_4397(var_0, var_1 - 1000 - level._id_439B);
  var_4 = var_3["spawn_pos"];
  var_5 = maps\_utility::within_fov(level.player.origin, level.player.angles, var_4, 0);

  if(var_5) {
    var_3 = _id_4397(var_0, var_1 + 1000);
    var_4 = var_3["spawn_pos"];
    var_2 = "backward";
    var_5 = maps\_utility::within_fov(level.player.origin, level.player.angles, var_4, 0);

    if(var_5) {
      return;
    }
  }

  var_4 = maps\_utility::_id_2281(var_4);
  var_6 = getent("snowmobile_spawner", "targetname");
  var_7 = var_3["targ"];
  var_6.origin = var_4;
  var_6.angles = vectortoangles(var_7._id_437B._id_437C - var_7._id_437C);
  var_8 = var_6 maps\_vehicle::_id_2925();

  foreach(var_10 in var_8) {}
  var_10.origin = var_6.origin;

  var_12 = maps\_vehicle::_id_211F(var_6);
  var_12._id_438E = var_3["offset"];
  var_12 phys_setspeed(90);
  var_12 thread _id_439D();
  var_12._id_439C = gettime() - 3000;
  waittillframeend;

  if(!isalive(var_12)) {
    return;
  }
  var_7 _id_43A2(var_12);
}

_id_439D() {
  self waittill("veh_collision", var_0, var_1);
  _id_439F("collision!");
}

_id_439E(var_0) {
  self waittill("death");

  if(isDefined(var_0)) {
    var_0 _id_439F("driver died!");
  }
}

_id_439F(var_0) {
  self._id_439F = 1;
}

_id_43A0(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_2AFD) {
    if(!isalive(var_3)) {
      continue;
    }
    if(var_3._id_439F) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  level._id_2AFD = var_1;

  if(isalive(var_0) && !var_0._id_439F) {
    var_5 = 0;

    foreach(var_3 in level._id_2AFD) {
      if(var_3 == var_0) {
        var_5 = 1;
        continue;
      }
    }

    if(!var_5) {
      level._id_2AFD[level._id_2AFD.size] = var_0;
    }
  }

  var_8 = 0;

  foreach(var_3 in level._id_2AFD) {
    var_3._id_43A1 = var_8;
    var_8 = var_8 + 75;
  }
}

_id_43A2(var_0) {
  if(!isDefined(var_0._id_439C)) {
    var_0._id_439C = gettime();
  }
  var_0._id_439F = 0;
  _id_43A0(var_0);

  if(!isDefined(var_0._id_43A3)) {
    var_0._id_43A3 = 250;
  }
  var_0._id_24F6 = 0;
  var_1 = randomfloatrange(0, 1);

  if(!isDefined(var_0._id_438E)) {
    var_0._id_438E = var_1 * 2 - 1;
  }
  var_2 = self;
  var_3 = spawnStruct();
  var_3.origin = self._id_437C;
  var_3._id_3F42 = 0;
  var_3._id_43A4 = 0;
  var_3.speed = 100;
  var_3 maps\_utility::_id_1402("biker_reaches_path_end");
  var_0 notify("enable_spline_path");

  if(!var_0._id_0A39.size) {
    var_0 phys_crash();
    return;
  }

  common_scripts\utility::array_thread(var_0._id_0A39, ::_id_439E, var_0);
  var_3._id_43A5 = var_0;
  var_0.health = 100;
  var_4 = 0;
  var_3 thread _id_43BF(var_0);
  var_0._id_43A6 = var_2;
  var_0._id_43A7 = 0;
  var_0._id_43A8 = 0;
  var_0.direction = "forward";
  var_0._id_43A9 = var_0.origin;

  for(;;) {
    if(!isalive(var_0)) {
      break;
    }

    _id_43B8(var_3);

    if(!isalive(var_0)) {
      break;
    }

    if(abs(var_0._id_43AA) > 6000 && gettime() > var_0._id_439C + 4000) {
      var_0 _id_439F("left behind!");
    }
    waittillframeend;

    if(var_0._id_439F) {
      if(isDefined(var_0._id_43AB)) {
        continue;
      }
      var_0 phys_crash();

      foreach(var_6 in var_0._id_0A39) {
        if(isalive(var_6)) {
          var_6 kill();
        }
      }

      wait 5;

      if(isDefined(var_0)) {
        var_0 delete();
      }
      _id_43A0();
      return;
    }

    if(var_3 maps\_utility::_id_1008("biker_reaches_path_end") || common_scripts\utility::flag("race_complete")) {
      break;
    }
  }

  _id_43A0();
  var_3 notify("stop_bike");
  level notify("biker_dies");

  if(var_0._id_439F && !common_scripts\utility::flag("race_complete")) {
    wait 5;
  }
  var_3 maps\_utility::_id_13DE("biker_reaches_path_end");
}

_id_43AC(var_0, var_1, var_2) {
  var_3["near_obstacle"] = 0;

  foreach(var_5 in var_0._id_437F) {
    if(var_1 < var_5["min"]) {
      continue;
    }
    if(var_1 > var_5["max"]) {
      continue;
    }
    var_3["near_obstacle"] = 1;

    if(var_2 < var_5["left_offset"]) {
      continue;
    }
    if(var_2 > var_5["right_offset"]) {
      continue;
    }
    var_6 = (var_0._id_437C + var_0._id_437B._id_437C) * 0.5;

    if(var_2 > var_5["mid_offset"]) {
      var_3["dodge"] = var_5["right_offset"];
    } else {
      var_3["dodge"] = var_5["left_offset"];
    }
    break;
  }

  return var_3;
}

_id_43AD() {
  for(;;) {
    self waittill("trigger", var_0);

    if(!isDefined(var_0.script_noteworthy)) {
      continue;
    }
    if(var_0.script_noteworthy != "sweepable") {
      continue;
    }
    var_1 = randomfloatrange(0, 1);
    var_0 thread maps\_utility::_id_1424("enable_spline_path", var_1);
  }
}

_id_43AE() {
  for(;;) {
    if(isDefined(level.player.vehicle)) {
      var_0 = self vehicle_getspeed();
      var_1 = level.player.vehicle vehicle_getspeed();
      level._id_43AF = var_0 - var_1;
    }

    wait 0.05;
  }
}

_id_43B0() {}

_id_43B1() {
  thread _id_43B0();
  self._id_4394 = maps\_vehicle::_id_2AFB(self.origin);
  self._id_43B2 = 1;
  self endon("stop_modulating_speed");
  var_0 = undefined;

  for(;;) {
    wait 0.05;
    var_1 = self._id_4394;

    if(var_1 == var_1._id_437B) {
      return;
    }
    var_2 = _id_4392(self.origin, self._id_4394._id_437C, self._id_4394._id_437B._id_437C);
    var_3 = var_2["progress"];
    var_3 = var_3 + level._id_439B;
    var_4 = _id_43BB(self._id_4394, var_3);
    var_3 = var_4._id_3F42;
    self._id_4394 = var_4._id_4394;
    self._id_3F42 = var_3;
    var_5 = _id_43D1();
    var_6 = _id_43D0();
    var_7 = _id_43AA(self._id_4394, self._id_3F42, var_5, var_6);
    level._id_43AA = var_7;

    if(!isDefined(level.player.vehicle)) {
      self vehicle_setspeed(65, 1, 1);
      continue;
    }

    if(abs(var_7 > 3500)) {
      var_8 = 65;
      var_7 = var_7 * -1;
      var_7 = var_7 + 750;
      var_8 = level.player.vehicle.veh_speed + var_7 * 0.05;
      var_9 = level.player.vehicle.veh_speed;

      if(var_9 < 100) {
        var_9 = 100;
      }
      if(var_8 > var_9) {
        var_8 = var_9;
      } else if(var_8 < self._id_43B2) {
        var_8 = self._id_43B2;
      }
      level.desired_speed = var_8;
      self vehicle_setspeed(var_8, 90, 20);
      continue;
    }

    _id_43B3(10, 10);
  }
}

_id_43B3(var_0, var_1) {
  var_2 = self.angles;
  var_2 = (0, var_2[1], 0);
  var_3 = anglesToForward(var_2);
  var_4 = _id_4392(level.player.vehicle.origin, self.origin + var_3 * 1, self.origin - var_3 * 1);
  var_5 = var_4["progress"];

  if(var_5 > 4000) {
    self vehicle_setspeed(0, 90, 20);
  } else {
    var_6 = maps\_utility::_id_26AC(self.origin, self.angles, level.player.origin);
    var_7 = 1;

    if(var_5 > 0) {
      var_7 = 1;
    } else {
      if(var_5 > -500) {
        var_7 = 1.25;
      }
      if(var_7 > 0.95 && var_6 > 0.97) {
        var_7 = 0.95;
      }
    }

    var_8 = 70 * var_7;

    if(var_8 < self._id_43B2) {
      var_8 = self._id_43B2;
    }
    if(var_8 < 25) {
      var_8 = 25;
    }
    level._id_43B4 = var_8;
    self vehicle_setspeed(var_8, var_0, var_1);
  }
}

_id_43B5(var_0, var_1) {
  var_2 = self.angles;
  var_2 = (0, var_2[1], 0);
  var_3 = anglesToForward(var_2);
  var_4 = _id_4392(level.player.vehicle.origin, self.origin + var_3 * 1, self.origin - var_3 * 1);
  var_5 = var_4["progress"];

  if(var_5 > 4000) {
    self vehicle_setspeed(0, 90, 20);
  } else {
    if(var_5 < level._id_436D && gettime() > self._id_439C + 4000) {
      _id_439F("low progress!");
    }
    var_5 = var_5 - 750;
    var_5 = var_5 + self._id_43A1;
    var_6 = 1;

    if(var_5 > 150) {
      var_6 = 0.6;
    } else if(var_5 > 100) {
      var_6 = 1.0;
    } else if(var_5 < -100) {
      var_6 = 1.5;
    }
    if(isDefined(level.player.offset)) {
      if(var_5 > 250) {}
    }

    var_7 = level.player.vehicle.veh_speed * var_6;

    if(var_7 < 25) {
      var_7 = 25;
    }
    self vehicle_setspeed(var_7, var_0, var_1);
  }
}

_id_43B6(var_0) {
  self notify("track_player_progress");
  self endon("track_player_progress");
  self._id_4394 = maps\_vehicle::_id_2AFB(var_0);
  self._id_3F42 = 0;
  var_1 = getent("player_sweep_trigger", "targetname");
  var_2 = isDefined(var_1);

  if(var_2) {
    var_1 thread _id_43AD();
  }
  for(;;) {
    if(self._id_4394 == self._id_4394._id_437B) {
      return;
    }
    var_3 = _id_4392(self.origin, self._id_4394._id_437C, self._id_4394._id_437B._id_437C);
    var_4 = var_3["progress"];
    var_4 = var_4 + level._id_439B;
    var_5 = _id_43BB(self._id_4394, var_4);
    var_4 = var_5._id_3F42;
    self._id_4394 = var_5._id_4394;
    self._id_3F42 = var_4;
    self.offset = var_3["offset"];

    if(var_2) {
      var_6 = _id_43BC(self._id_4394, var_4 + 2000, 0);
      var_6 = (var_6[0], var_6[1], self.origin[2] - 500);
      var_1.origin = var_6;
      var_7 = _id_43BC(self._id_4394, var_4 + 3000, 0);
      var_8 = vectortoangles(var_1.origin - var_7);
      var_1.angles = (0, var_8[1], 0);
    }

    if(common_scripts\utility::flag("ai_snowmobiles_ram_player")) {
      level._id_43B7 = maps\_utility::_id_0AE9(self.origin, level._id_2AFD);
    } else {
      level._id_43B7 = undefined;
    }
    wait 0.05;
  }
}

_id_43AA(var_0, var_1, var_2, var_3) {
  while(var_0.index > var_2.index) {
    var_0 = var_0._id_4385;
    var_1 = var_1 + var_0._id_437D;
  }

  while(var_2.index > var_0.index) {
    var_2 = var_2._id_4385;
    var_3 = var_3 + var_2._id_437D;
  }

  return var_1 - var_3;
}

_id_43B8(var_0) {
  var_1 = var_0._id_43A5;
  var_2 = 0.1;
  var_3 = 0;
  var_4 = 0;
  var_5 = var_1._id_43A6;

  if(var_5 == var_5._id_437B) {
    var_1 delete();
    return;
  }

  var_6 = _id_4392(var_1.origin, var_5._id_437C, var_5._id_437B._id_437C);
  var_7 = _id_4392(var_1.origin, var_5._id_437B._id_437C, var_5._id_437B._id_437B._id_437C);

  if(var_7["progress"] > 0 && var_7["progress"] < var_5._id_437B._id_437D) {
    var_6 = var_7;
    var_5 = var_5._id_437B;
  }

  var_4 = var_6["offset"];
  var_8 = 0;
  var_3 = var_6["progress"];
  var_1._id_3F42 = var_3;
  var_9 = _id_43AC(var_5, var_3, var_4);
  var_10 = var_9["near_obstacle"];
  var_11 = _id_43AA(var_5, var_3, _id_43D1(), _id_43D0());
  var_1._id_43AA = var_11;

  if(var_1.direction == "forward") {
    var_3 = var_3 + level._id_439B;
  } else {
    var_3 = var_3 - level._id_439B;

    if(var_11 < 500) {
      var_1.direction = "forward";
    }
  }

  var_12 = 60;
  var_13 = 90;
  var_14 = 100;
  var_15 = 200;

  if(var_11 > var_15) {
    var_16 = var_12;
  } else if(var_11 < var_14) {
    var_16 = var_13;
  } else {
    var_17 = var_15 - var_14;
    var_18 = var_13 - var_12;
    var_16 = var_11 - var_14;
    var_16 = var_17 - var_16;
    var_16 = var_16 * (var_18 / var_17);
    var_16 = var_16 + var_12;
  }

  if(var_16 > 0) {
    if(var_1 vehicle_getspeed() < 2) {
      var_1._id_43A8++;

      if(var_1._id_43A8 > 10) {
        var_1 _id_439F("move fail!");
        return;
      }
    } else {
      var_1._id_43A8 = 0;
    }
  } else {
    var_1._id_43A8 = 0;
  }
  var_19 = randomfloatrange(0, 100);
  var_19 = var_19 * 0.001;
  var_20 = 0;
  var_21 = var_5._id_437E;
  var_0 = _id_43BB(var_5, var_3);
  var_3 = var_0._id_3F42;
  var_5 = var_0._id_4394;
  var_22 = (var_5._id_437C + var_5._id_437B._id_437C) * 0.5;
  var_4 = var_4 * var_5._id_437E / var_21;
  var_9 = _id_43AC(var_5, var_3, var_4);

  if(isDefined(var_9["dodge"])) {
    var_4 = var_9["dodge"];
  } else if(isDefined(var_1._id_43B9)) {
    var_4 = var_1._id_43B9;
  }
  var_23 = 0.95;
  var_24 = var_5._id_437E * 0.5;
  var_24 = var_24 - 50;

  if(var_4 > var_24) {
    var_4 = var_24;
  } else if(var_4 < -1 * var_24) {
    var_4 = -1 * var_24;
  }
  if(var_5 != var_5._id_437B) {
    var_25 = var_1 _id_43BA(var_5, var_3, var_4, var_1.origin[2]);
    var_26 = maps\_utility::_id_26AC(var_1.origin, var_1.angles, var_25);

    if(var_26 < 0.97) {
      var_16 = 50;
    } else if(var_26 < 0.96) {
      var_16 = 25;
    } else if(var_26 < 0.95) {
      var_16 = 15;
    }
    var_1 vehicledriveto(var_25, var_16);

    if(!isDefined(level.player.vehicle)) {
      var_1 vehicle_setspeed(65, 1, 1);
    } else {
      var_1.veh_topspeed = level.player.vehicle.veh_topspeed * 1.3;
      var_1 _id_43B5(45, 30);
    }
  }

  var_1._id_43A6 = var_5;
  var_1.offset = var_4;
  wait(var_2);
}

_id_43BA(var_0, var_1, var_2, var_3) {
  var_4 = _id_43BD(var_0, var_1, var_2);
  var_4 = maps\_utility::_id_27A7(var_4, var_3);
  return physicstrace(var_4 + (0, 0, 200), var_4 + (0, 0, -200));
}

_id_43BB(var_0, var_1) {
  var_2 = spawnStruct();

  for(;;) {
    if(var_0 == var_0._id_437B) {
      break;
    }

    if(var_1 > var_0._id_437D) {
      var_1 = var_1 - var_0._id_437D;
      var_0 = var_0._id_437B;
      continue;
    }

    if(var_1 < 0) {
      var_1 = var_1 + var_0._id_437D;
      var_0 = var_0._id_4385;
      continue;
    }

    break;
  }

  var_2._id_4394 = var_0;
  var_2._id_3F42 = var_1;
  return var_2;
}

_id_43BC(var_0, var_1, var_2) {
  for(;;) {
    if(var_0 == var_0._id_437B) {
      return var_0._id_437C;
    }
    if(var_1 > var_0._id_437D) {
      var_1 = var_1 - var_0._id_437D;
      var_0 = var_0._id_437B;
      continue;
    }

    break;
  }

  return _id_43BD(var_0, var_1, var_2);
}

_id_43BD(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_0._id_437B._id_437C - var_0._id_437C);
  var_4 = anglesToForward(var_3);
  var_5 = anglestoright(var_3);
  return var_0._id_437C + var_4 * var_1 + var_5 * var_2;
}

_id_43BE(var_0, var_1) {
  var_2 = 1 - var_1 / var_0._id_437D;
  return var_0._id_437C * var_2 + var_0._id_437B._id_437C * (1 - var_2);
}

_id_43BF(var_0) {
  self endon("stop_bike");

  for(;;) {
    self._id_439F = 0;

    if(self._id_439F) {
      break;
    }

    wait 0.05;
  }
}

_id_43C0() {
  for(;;) {
    waittillframeend;
    wait 0.05;
  }
}

_id_43C1() {
  self endon("stop_bike");

  for(;;) {
    var_0 = (self.origin[0], self.origin[1], 0);
    var_1 = (self._id_4394._id_437C[0], self._id_4394._id_437C[1], 0);
    var_2 = (self._id_43C2._id_437C[0], self._id_43C2._id_437C[1], 0);
    var_3 = vectornormalize(var_1 - var_0);
    var_4 = anglesToForward(self.angles);
    var_5 = vectordot(var_4, var_3);
    var_6 = vectornormalize(var_2 - var_1);
    var_7 = var_0 - var_1;
    self._id_3F42 = vectordot(var_7, var_6);
    wait 0.05;
  }
}

_id_43C3(var_0) {
  self._id_43C4 = var_0._id_437E * 0.5;
  self._id_43C5 = self._id_43C4 - 100;
}

_id_43C6(var_0) {
  self endon("stop_bike");
  self endon("end_path");
  self._id_43C7 = 0;
  thread _id_43C8();
  _id_43CB();
}

_id_43C8() {
  self endon("stop_bike");
  self endon("end_path");

  for(;;) {
    if(self._id_4394._id_437F.size == 0 && self._id_43C9 == 0) {
      if(common_scripts\utility::cointoss()) {
        self._id_43C7++;
      } else {
        self._id_43C7--;
      }
      if(self._id_43C7 > 1) {
        self._id_43C7 = self._id_43C7 - 3;
      } else if(self._id_43C7 < -1) {
        self._id_43C7 = self._id_43C7 + 3;
      }
    }

    wait(randomfloatrange(1, 3));
  }
}

_id_43CA() {
  if(self._id_43C7 == 0) {
    return 1;
  }
  if(self._id_43C7 == 1 && self.offset > self._id_43C5) {
    return 1;
  }
  if(self._id_43C7 == -1 && self.offset < self._id_43C5 * -1) {
    return 1;
  }
  return 0;
}

_id_43CB() {
  self._id_43A4 = 0;
  var_0 = 12;
  var_1 = 3;
  var_2 = 130;

  for(;;) {
    if(_id_43CA()) {
      if(self._id_43CC > 0) {
        self._id_43A4 = self._id_43A4 - var_1;
      } else if(self._id_43CC < 0) {
        self._id_43A4 = self._id_43A4 + var_1;
      }
    } else if(self._id_43C7 == 1) {
      self._id_43A4 = self._id_43A4 + var_1;
    } else if(self._id_43C7 == -1) {
      self._id_43A4 = self._id_43A4 - var_1;
    }
    if(self._id_43A4 > var_0) {
      self._id_43A4 = var_0;
    } else if(self._id_43A4 < -1 * var_0) {
      self._id_43A4 = -1 * var_0;
    }
    self._id_43CC = self._id_43CC + self._id_43A4;

    if(self._id_43CC > var_2) {
      self._id_43CC = var_2;
      self._id_43A4 = 1;
    } else if(self._id_43CC < var_2 * -1) {
      self._id_43CC = var_2 * -1;
      self._id_43A4 = -1;
    }

    wait 0.05;
  }
}

_id_43CD(var_0, var_1) {
  if(self._id_43CC > 0) {
    self._id_43CC = self._id_43CC - var_1;
  } else {
    self._id_43CC = self._id_43CC + var_1;
  }
  if(abs(self._id_43CC) < var_1) {
    self._id_43CC = var_1;
  }
}

_id_43CE(var_0, var_1) {
  if(self.offset >= self._id_43C5) {
    self._id_43C7 = 0;
    return;
  }

  self._id_43CC = self._id_43CC + var_1;

  if(self._id_43CC >= var_0) {
    self._id_43CC = var_0;
  }
}

_id_43CF(var_0, var_1) {
  if(self.offset < self._id_43C5 * -1) {
    self._id_43C7 = 0;
    return;
  }

  self._id_43CC = self._id_43CC - var_1;

  if(self._id_43CC < var_0 * -1) {
    self._id_43CC = var_0 * -1;
  }
}

_id_43D0() {
  if(isDefined(level.player._id_3F42)) {
    return level.player._id_3F42;
  }
  return 0;
}

_id_43D1() {
  if(isDefined(level.player._id_4394)) {
    return level.player._id_4394;
  }
  return level._id_2AFC[0];
}

_id_43D2() {
  var_0 = (0.2, 0.2, 1);

  if(isDefined(level.player.vehicle) && self.veh_speed > level.player.vehicle.veh_speed) {
    var_0 = (1, 0.2, 0.2);
  }
  self._id_43A9 = self.origin;
}