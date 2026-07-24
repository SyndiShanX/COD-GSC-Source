/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3846.gsc
**************************************/

_id_F95F() {
  var_0 = _id_239A();
  var_1 = undefined;
  var_2 = undefined;

  switch (var_0) {
    case "elevator":
      var_2 = spawnStruct();
      var_2._id_116C0 = "ELEVATOR";
      var_2._id_116AD = "ELEVATOR";
      var_2._id_113AC = var_0;
      var_2.icon = "icon_ks_air_super";
      var_2.origin = self.origin;
      var_2._id_113A8 = level._id_FD5B.size;
      var_2.struct = self;
      level._id_FD5B[level._id_FD5B.size] = var_2;
      break;
    case "breach_forced":
      var_2 = spawnStruct();
      var_2._id_116C0 = "BREACH POINT";
      var_2._id_116AD = "BREACH POINT";
      var_2.icon = "breach_icon";
      var_2._id_113AC = var_0;
      var_2.origin = self.origin;
      var_2._id_113A8 = level._id_FD5B.size;
      var_2.struct = self;
      level._id_FD5B[level._id_FD5B.size] = var_2;
      break;
    case "breach_window":
      var_2 = spawnStruct();
      var_2._id_116C0 = "BREACH POINT";
      var_2._id_116AD = "BREACH POINT";
      var_2.icon = "breach_icon";
      var_2._id_113AC = var_0;
      var_2.origin = self.origin;
      var_2._id_113A8 = level._id_FD5B.size;
      var_2.struct = self;
      level._id_FD5B[level._id_FD5B.size] = var_2;
      break;
  }

  if(isDefined(var_2))
    return var_2;
}

_id_239A() {
  var_0 = self;
  var_1 = undefined;
  var_2 = 0;

  if(self.spawnflags & 1) {
    var_1 = "breach_forced";
    var_2 = 1;
  }

  if(self.spawnflags & 2) {
    var_1 = "breach_window";
    var_2 = 1;
  }

  if(self.spawnflags & 8) {
    var_1 = "elevator";
    var_2 = 1;
  }

  return var_1;
}

_id_6661() {
  level notify("window_vents_unlocked");
}

_id_6662(var_0) {
  if(level._id_FD5C)
    level waittill("window_vents_unlocked");

  thread _id_FD29(var_0);
}

_id_FD29(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = spawnStruct();
  var_3._id_4F9D = [];
  var_3._id_4F9A = [];
  var_3._id_C624 = undefined;
  var_3._id_4F92 = undefined;
  var_3._id_4FAD = undefined;
  var_3._id_4F9C = undefined;
  var_3._id_4F96 = undefined;
  var_3.radius = self.radius;
  var_3._id_11391 = self;
  var_4 = scripts\engine\utility::get_links();
  var_3._id_4F9C = getglass(self.target);

  foreach(var_6 in var_4) {
    var_7 = getEntArray(var_6, "script_linkname");

    if(var_7.size > 0)
      var_1 = scripts\engine\utility::array_combine(var_1, var_7);
  }

  foreach(var_6 in var_4) {
    var_10 = scripts\engine\utility::getStructArray(var_6, "script_linkname");

    if(var_10.size > 0)
      var_2 = scripts\engine\utility::array_combine(var_2, var_10);
  }

  foreach(var_13 in var_1) {
    if(var_13.classname == "trigger_multiple") {
      if(isDefined(var_13.targetname) && var_13.targetname == "decompress_open_door")
        var_3._id_C624 = var_13;
      else
        var_3._id_4F94 = var_13;
    }

    if(isDefined(var_13.targetname)) {
      if(var_13.classname == "func_glass")
        var_3._id_4F9C = var_13;

      if(var_13.targetname == "decompress_door") {
        var_3._id_4F96 = var_13;
        var_14 = var_3._id_4F96 scripts\sp\utility::_id_7A8F();

        if(var_14.size > 0) {
          foreach(var_16 in var_14)
          var_16 linkTo(var_3._id_4F96);
        }
      }

      continue;
    }

    if(var_13.classname == "script_brushmodel")
      var_3._id_4F9D = scripts\engine\utility::array_add(var_3._id_4F9D, var_13);

    if(var_13.classname == "script_model")
      var_3._id_4F9D = scripts\engine\utility::array_add(var_3._id_4F9D, var_13);
  }

  foreach(var_20 in var_2) {
    if(var_20.targetname == "decompress_bottom_left")
      var_3._id_4F92 = var_20;

    if(var_20.targetname == "decompress_top_right")
      var_3._id_4FAD = var_20;

    if(var_20.targetname == "decompress_fx")
      var_3._id_4F9A = scripts\engine\utility::array_add(var_3._id_4F9A, var_20);
  }

  var_22 = [];
  var_23 = distance2d(var_3._id_4F92.origin, var_3._id_4FAD.origin);
  var_24 = var_23 / 2;
  var_25 = var_24 - var_24 / 2;
  var_26 = var_24 + var_24 / 2;
  var_27 = distance((0, 0, var_3._id_4F92.origin[2]), (0, 0, var_3._id_4FAD.origin[2]));
  var_28 = var_27 / 2;
  var_29 = var_3._id_4F92.origin + (var_24, 0, var_28);
  var_30 = var_3._id_4F92.origin + (var_25, 0, var_28);
  var_31 = var_3._id_4F92.origin + (var_26, 0, var_28);
  var_3._id_C036 = var_27;
  var_3._id_6959 = [var_29, var_30, var_31];
  var_3._id_753F = anglesToForward(var_3._id_4F92.angles);
  var_3.up = vectortoangles((var_3._id_4F92.origin[0], var_3._id_4F92.origin[1], var_3._id_4FAD.origin[2]) - var_3._id_4F92.origin);
  var_3.right = vectortoangles((var_3._id_4FAD.origin[0], var_3._id_4FAD.origin[1], var_3._id_4F92.origin[2]) - var_3._id_4F92.origin);
  var_3 thread _id_FCE1();
  var_3 waittill("window_open");

  while(!isglassdestroyed(var_3._id_4F9C))
    scripts\engine\utility::waitframe();

  wait 0.5;
  var_3 notify("window_breached");
  var_3 thread _id_FCE4();
  var_3 thread _id_FCE3();
  var_3 thread _id_FCE7();
  var_3 thread _id_FCE8();
  var_3 thread _id_FCE5();
  var_3 waittill("door_closing");
}

_id_FCE1() {
  var_0 = self;
  var_1 = 2;
  var_2 = 5;

  if(level._id_FD5C)
    var_0._id_C624 waittill("trigger");

  var_3 = var_0._id_4FAD.origin[2] - var_0._id_4F92.origin[2] - var_2;
  var_0._id_4F96 movez(var_3, var_1);
  wait(var_1);
  var_0 notify("window_open");
  var_0 waittill("window_breached");
  wait 2.0;
  var_0 notify("door_closing");
  var_0._id_4F96 movez(-1 * var_3, var_1);
  wait(var_1);
  var_0 notify("window_closed");
}

_id_FCE3() {
  var_0 = self;
  var_1 = getDvar("glass_angular_vel");
  var_2 = getDvar("glass_linear_vel");
  var_3 = getdvarint("glass_fall_gravity");
  var_4 = getdvarint("glass_simple_duration");
  setsaveddvar("glass_angular_vel", "1 5");
  setsaveddvar("glass_linear_vel", "2000 4000");
  setsaveddvar("glass_fall_gravity", 0);
  setsaveddvar("glass_simple_duration", 100000);
  physics_setgravity((0, 0, 0));
  var_5 = axistoangles(var_0.up, var_0.right, var_0._id_753F);
  var_6 = scripts\engine\utility::spawn_tag_origin(var_0._id_6959[0], var_5);
  playFXOnTag(scripts\engine\utility::getfx("window_decompression"), var_6, "tag_origin");
  level.player shellshock("default_nosound", 1);
  playrumbleonposition("grenade_rumble", level.player.origin);
  var_0 waittill("window_closed");
  setsaveddvar("glass_angular_vel", var_1);
  setsaveddvar("glass_linear_vel", var_2);
  setsaveddvar("glass_fall_gravity", var_3);
  physics_setgravity((0, 0, -386.09));
  stopFXOnTag(scripts\engine\utility::getfx("window_decompression"), var_6, "tag_origin");
  wait 5.0;
  deleteglass(var_0._id_4F9C);
  setsaveddvar("glass_simple_duration", var_4);
}

_id_FCE7() {
  var_0 = self;

  foreach(var_2 in var_0._id_4F9D)
  var_0 thread _id_FCE9(var_2);
}

_id_FCE9(var_0) {
  var_1 = self;
  var_2 = vectorNormalize(var_1._id_753F);
  var_3 = distance(var_0.origin, var_1._id_4F92.origin);
  var_4 = var_0.origin + var_2 * var_3 + (0, 0, var_1._id_C036 / 2);
  var_5 = undefined;

  if(scripts\common\trace::ray_trace_passed(var_0.origin, var_4))
    var_5 = var_0.origin + var_2 * 10000 + (0, 0, var_1._id_C036 / 2);
  else {
    var_6 = 500000;

    foreach(var_8 in var_1._id_6959) {
      var_9 = distance(var_0.origin, var_8);

      if(var_9 >= var_6) {
        continue;
      }
      var_6 = var_9;
      var_5 = var_8;
    }

    var_5 = var_5 + var_2 * 10000 + (0, 0, var_1._id_C036 / 2);
  }

  wait(randomfloatrange(0, 0.5));
  var_0 moveTo(var_5, 2, 1);
  var_0 rotateby((randomfloatrange(0, 360), randomfloatrange(0, 360), randomfloatrange(0, 360)), 2, 1);
}

_id_FCE8() {
  var_0 = self;
  var_1 = 20;
  var_2 = vectorNormalize(var_0._id_753F);
  level.player _meth_8251(var_2 * var_1, 1);
  var_0 waittill("window_closed");
  level.player _meth_8251((0, 0, 0), 0);
}

_id_FCE4() {
  var_0 = self;
  var_1 = vectorNormalize(var_0._id_753F);
  var_2 = vectortoangles(var_0._id_11391.origin - level.player.origin);
  var_0 endon("door_closing");

  for(;;) {
    if(isDefined(var_0.radius) && distance(level.player.origin, var_0._id_11391.origin) < var_0.radius || isDefined(var_0._id_4F94) && level.player istouching(var_0._id_4F94)) {
      level.player _meth_8251(var_1 * 100, 1);
      level.player scripts\sp\vehicle::_id_8441();
      level.player takeallweapons();
      level.player playRumbleOnEntity("damage_heavy");
      thread _id_FCE2();
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_FCE2() {
  wait 0.5;
  level.player shellshock("flashbang", 2);
  wait 0.5;
  missionfailed();
}

_id_FCE5() {
  var_0 = self;
  var_1 = getaiarray("axis");

  foreach(var_3 in var_1) {
    if(isDefined(var_0.radius) && distance(var_3.origin, var_0._id_11391.origin) < var_0.radius || isDefined(var_0._id_4F94) && level.player istouching(var_0._id_4F94)) {
      var_3._id_DC1A = 1;
      var_3 _meth_81D0();
      var_3 thread _id_FCE6();
    }
  }
}

_id_FCE6() {
  var_0 = self;
  wait 5;

  if(isDefined(var_0))
    var_0 delete();
}