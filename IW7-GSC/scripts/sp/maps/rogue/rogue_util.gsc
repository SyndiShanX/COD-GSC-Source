/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\rogue\rogue_util.gsc
************************************************/

_id_BE42(var_0, var_1, var_2, var_3) {
  level endon(var_0);
  var_4 = scripts\engine\utility::array_randomize(var_3);

  while(!scripts\engine\utility::flag(var_0)) {
    foreach(var_6 in var_4) {
      if(soundexists(var_6)) {
        scripts\sp\utility::_id_10346(var_6);
      }

      wait(randomintrange(var_1, var_2));
    }

    wait 0.15;
  }
}

_id_13DBE(var_0) {
  if(isDefined(var_0.enemy) && var_0.enemy == self) {
    if(distance2d(var_0.origin, self.origin) < 150) {
      return 1;
    }

    if(var_0._id_164D["c6_worker"]._id_4BC0 == "melee_attack") {
      return 1;
    }

    return 0;
  }

  return 0;
}

_id_D8E9(var_0) {
  self endon("death");
  self notify("stop_print3d");
  self endon("stop_print3d");

  for(;;) {
    wait 0.05;
  }
}

_id_517F(var_0, var_1) {
  scripts\engine\utility::flag_wait(var_1);

  foreach(var_3 in var_0) {
    var_3 delete();
  }
}

_id_EF3D(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    level endon(var_4);
  }

  var_5 = "power_on";
  var_6 = var_2;

  for(;;) {
    scripts\engine\utility::flag_wait(var_5);
    var_0 = scripts\engine\utility::array_removeundefined(var_0);

    if(!var_0.size) {
      return;
    }
    _id_EF40(var_0, var_1, var_6);
    var_5 = scripts\engine\utility::ter_op(var_5 == "power_on", "power_off", "power_on");
    var_6 = scripts\engine\utility::ter_op(var_6 == var_2, var_3, var_2);
  }
}

_id_EF40(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    if(!isDefined(var_4._id_9BB1)) {
      var_4 setscriptablepartstate(var_1, var_2);
    }
  }
}

_id_8258(var_0, var_1) {
  if(isstring(var_0)) {
    var_2 = getspawner(var_0, "targetname");
  } else {
    var_2 = var_0;
  }

  if(!isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_1) && isDefined(var_2.count)) {
    var_1 = var_2.count;
  }

  var_3 = [];

  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_2 scripts\sp\utility::script_delay();
    var_2.count++;
    var_5 = var_2 _id_0B77::_id_12799();

    if(!scripts\sp\utility::_id_106ED(var_5)) {
      var_3[var_3.size] = var_5;
    }

    wait 0.1;
  }

  if(var_3.size < var_1) {}

  return var_3;
}

_id_BC53(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(!isDefined(var_1)) {
    var_1 = getEnt(var_0, "targetname");
  }

  level.player setOrigin(var_1.origin);
  var_2 = undefined;

  if(isDefined(var_1.target)) {
    var_2 = getEnt(var_1.target, "targetname");
  }

  if(isDefined(var_2)) {
    level.player setplayerangles(vectortoangles(var_2.origin - var_1.origin));
  } else {
    level.player setplayerangles(var_1.angles);
  }
}

_id_10626(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = [];
  }

  level.allies = [];
  var_3 = [];
  var_4 = getEntArray("ally_spawner", "targetname");

  foreach(var_6 in var_4) {
    var_7 = 1;

    foreach(var_9 in var_1) {
      if(var_6._id_EDB8 == var_9) {
        var_7 = 0;
        continue;
      }
    }

    if(var_7) {
      var_6.count = 10;
      var_3[var_3.size] = var_6 scripts\sp\utility::_id_10619(1, 1);
    }
  }

  scripts\engine\utility::array_thread(var_3, ::_id_1CCE, var_0, var_2);
  return var_3;
}

_id_1CCE(var_0, var_1) {
  _id_F99A();
  scripts\sp\utility::_id_F3DD(16);

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  self._id_EDB0 = 1;
  self.disableplayeradsloscheck = 1;
  self._id_C381 = self.grenadeawareness;

  if(isDefined(self._id_EDB8)) {
    switch (self._id_EDB8) {
      case "Salter":
        self _meth_8250(0);
        level._id_13E12 = self;
        self._id_1FBB = "xo";
        self._id_111B7 = "_xo";

        if(isDefined(var_0)) {
          var_0 = var_0 + "_xo";
          var_2 = getnode(var_0, "targetname");
          self _meth_80F1(var_2.origin + anglesToForward(var_2.angles) * -16, var_2.angles);

          if(var_1) {
            scripts\sp\utility::_id_7226(var_2);
          }
        }

        scripts\sp\utility::_id_72EC("iw7_devastator", "primary");
        break;
      case "Omar":
        self _meth_8250(0);
        level._id_B4F9 = self;
        self._id_1FBB = "MCO";
        self._id_111B7 = "_mco";

        if(isDefined(var_0)) {
          var_0 = var_0 + "_mco";
          var_2 = getnode(var_0, "targetname");
          self _meth_80F1(var_2.origin + anglesToForward(var_2.angles) * -16, var_2.angles);

          if(var_1) {
            scripts\sp\utility::_id_7226(var_2);
          }
        }

        scripts\sp\utility::_id_72EC("iw7_devastator", "primary");
        break;
      case "Kashima":
        self _meth_8250(0);
        level._id_B33E = self;
        self._id_EDB8 = "Kashima";
        self._id_1FBB = "marine2";
        self._id_111B7 = "_marine2";

        if(isDefined(var_0)) {
          var_0 = var_0 + "_marine2";
          var_2 = getnode(var_0, "targetname");
          self _meth_80F1(var_2.origin + anglesToForward(var_2.angles) * -16, var_2.angles);

          if(var_1) {
            scripts\sp\utility::_id_7226(var_2);
          }
        }

        scripts\sp\utility::_id_72EC("iw7_fhr", "primary");
        break;
      case "Brooks":
        self _meth_8250(0);
        level._id_B33B = self;
        self._id_EDB8 = "Brooks";
        self._id_1FBB = "marine1";
        self._id_111B7 = "_marine1";

        if(isDefined(var_0)) {
          var_0 = var_0 + "_marine1";
          var_2 = getnode(var_0, "targetname");
          self _meth_80F1(var_2.origin + anglesToForward(var_2.angles) * -16, var_2.angles);

          if(var_1) {
            scripts\sp\utility::_id_7226(var_2);
          }
        }

        scripts\sp\utility::_id_72EC("iw7_ake", "primary");
        break;
      default:
        break;
    }

    level.allies[self._id_EDB8] = self;
  }
}

_id_1D1D() {
  _id_111C7();

  for(;;) {
    self waittill("burning");
    var_0 = _id_6C9A();
    scripts\sp\utility::_id_54F7();
    self _meth_82EE(var_0);
    thread _id_C02C(var_0);
    thread _id_12945();
  }
}

_id_12945() {
  self endon("node_is_bad");
  self waittill("goal");
  scripts\sp\utility::_id_61C7();
}

_id_C02C(var_0) {
  self endon("goal");
  var_1 = 1;

  while(var_1 == 1) {
    var_1 = var_0 _id_C03C();
    wait 0.25;
  }

  self notify("node_is_bad");
  wait 0.05;
  self notify("burning");
}

_id_6C9A() {
  var_0 = 1;
  var_1 = 100;
  var_2 = 0;
  var_3 = [];
  var_4 = 0;
  var_5 = undefined;

  while(var_0 == 1) {
    var_3 = getnodesinradiussorted(self.origin, var_1, var_2, 60, "cover");

    foreach(var_7 in var_3) {
      var_4 = var_7 _id_C03C();

      if(var_4 == 1) {
        var_5 = var_7;
        break;
      }
    }

    if(var_4 == 1) {
      break;
    } else {
      wait 0.05;
      var_2 = var_1;
      var_1 = var_1 + 50;
    }
  }

  return var_5;
}

_id_C03C() {
  foreach(var_1 in level._id_111C3._id_11A8C) {
    var_2 = bulletTrace(var_1.origin, var_1.origin + vectorNormalize(self.origin - var_1.origin) * 999999, 1, level._id_111C3._id_10288);

    if(isDefined(var_2["entity"]) && var_2["entity"] == self && scripts\engine\utility::flag("power_on")) {
      return 1;
    } else {
      return 0;
    }
  }
}

_id_1683(var_0, var_1) {
  var_2 = getEnt(var_1, "targetname");

  if(isPlayer(var_0)) {
    var_0 setplayerangles(var_2.angles);
    var_0 setOrigin(var_2.origin);
  } else if(isai(var_0))
    var_0 _meth_80F1(var_2.origin, var_2.angles);
}

_id_1161C(var_0, var_1, var_2) {
  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  if(!isDefined(var_1)) {
    var_1 = level.player.origin;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_0 = sortbydistance(var_0, var_1);

  foreach(var_4 in var_0) {
    if(distancesquared(var_4.origin, self.origin) > distancesquared(var_1, self.origin)) {
      return 0;
    }

    if(!var_2 && level.player scripts\sp\utility::_id_3849(var_4.origin)) {
      continue;
    }
    if(isai(self)) {
      self _meth_80F1(var_4.origin, var_4.angles);
      continue;
    }

    self.origin = var_4.origin;
    self.angles = var_4.angles;
  }
}

_id_16BD(var_0, var_1, var_2) {
  if(getdvarint("loc_warnings", 0)) {
    return;
  }
  if(!isDefined(level._id_4EC3)) {
    level._id_4EC3 = [];
  }

  var_3 = "^3";

  if(isDefined(var_2)) {
    switch (var_2) {
      case "red":
      case "r":
        var_3 = "^1";
        break;
      case "green":
      case "g":
        var_3 = "^2";
        break;
      case "yellow":
      case "y":
        var_3 = "^3";
        break;
      case "blue":
      case "b":
        var_3 = "^4";
        break;
      case "cyan":
      case "c":
        var_3 = "^5";
        break;
      case "purple":
      case "p":
        var_3 = "^6";
        break;
      case "white":
      case "w":
        var_3 = "^7";
        break;
      case "bl":
      case "black":
        var_3 = "^8";
        break;
    }
  }

  var_4 = scripts\sp\hud_util::createfontstring("default", 1.5);
  var_4.location = 0;
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.foreground = 1;
  var_4.sort = 20;
  var_4.alpha = 0;
  var_4 fadeovertime(0.5);
  var_4.alpha = 1;
  var_4.x = 40;
  var_4.y = 325;
  var_4.label = " " + var_3 + "< " + var_0 + " > ^7" + var_1;
  var_4.color = (1, 1, 1);
  level._id_4EC3 = scripts\engine\utility::array_insert(level._id_4EC3, var_4, 0);

  foreach(var_7, var_6 in level._id_4EC3) {
    if(var_7 == 0) {
      continue;
    }
    if(isDefined(var_6)) {
      var_6.y = 325 - var_7 * 18;
    }
  }

  wait 2;
  var_8 = 40;
  var_4 fadeovertime(3);
  var_4.alpha = 0;

  for(var_7 = 0; var_7 < var_8; var_7++) {
    var_4.color = (1, 1, 0 / (var_8 - var_7));
    wait 0.05;
  }

  wait 4;
  var_4 destroy();
  scripts\engine\utility::array_removeundefined(level._id_4EC3);
}

_id_754C(var_0, var_1) {
  setsaveddvar("bg_cinematicFullScreen", "0");
  cinematicingameloopresident(var_0, 1);
  level waittill(var_1);
  stopcinematicingame();
}

_id_10B88(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(level._id_10B87)) {
    var_1 = spawnStruct();
    var_1.ent = scripts\engine\utility::spawn_tag_origin();
    var_1.ent.angles = (0, var_0, 0);
    playFXOnTag(scripts\engine\utility::getfx("rogue_stars_sprite"), var_1.ent, "tag_origin");
    level._id_10B87 = var_1;
  } else
    level._id_10B87.ent.angles = (0, var_0, 0);
}

_id_111ED(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_0)) {
    var_0 = 60.0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0.4;
  }

  if(!isDefined(var_2)) {
    var_2 = 4;
  }

  if(!isDefined(var_3)) {
    var_3 = 30;
  }

  if(!isDefined(var_4)) {
    var_4 = 15;
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  var_7 = [1, 0.775, 0.385];
  setsaveddvar("sm_sunSampleSizeNear", var_1);

  if(!isDefined(level._id_111C3)) {
    var_8 = spawnStruct();
    var_8._id_E6E5 = getEnt("sun_root", "targetname");
    var_8._id_1EF6 = getEnt("sun_anim", "targetname");
    var_8._id_54DA = [];
    var_8._id_C6EA = getEnt("sun_org", "targetname");
    var_8.ent = spawn("script_model", (0, 0, 0));
    var_8.ent._id_1178E = 1;
    var_8._id_11A8C = getEntArray("sun_trace_org", "targetname");
    var_8.targets = [level.player];
    var_8.light = var_0 * vectorNormalize((var_7[0], var_7[1], var_7[2]));
    var_8._id_BB25 = (3.36, 3.36, 3.36);
    var_8._id_BB10 = (-22.8, 18, 0);

    foreach(var_10 in getEntArray("sun_dir", "targetname")) {
      var_10 hide();
      var_8._id_54DA[var_10.script_count] = var_10;
    }

    for(var_12 = 19; var_12 < 30; var_12++) {
      var_8._id_54DA[scripts\engine\utility::mod(var_12, 24)] = var_8._id_54DA[0];
    }

    for(var_12 = 0; var_12 < 24; var_12++) {
      var_8._id_54DA[var_12].angles = var_8._id_54DA[var_12].angles + (0, 0, 180);
    }

    var_8._id_C6EA scripts\sp\utility::_id_23B7("sun_org");
    var_8.ent setModel("tag_origin");
    playFXOnTag(scripts\engine\utility::getfx("rogue_sun_sprite"), var_8.ent, "tag_origin");
    var_8.animation = var_8._id_C6EA scripts\sp\utility::_id_7DC1("sun_rot");
    var_8.ent linkTo(var_8._id_C6EA, "tag_origin", (17000, 40000, 0), (0, 0, 0));

    if(!isDefined(level._id_111EE)) {
      level._id_111EE = spawn("script_origin", (0, -150000, 0));
      level._id_111EE linkTo(var_8.ent, "tag_origin");
      level._id_111EE _meth_8278(0);
    }

    var_8._id_1EF6 linkTo(var_8._id_E6E5, "tag_origin", (0, 0, 0), (0, 0, 260));
    var_8._id_C6EA linkTo(var_8._id_1EF6, "tag_origin", (0, 0, 0), (0, 0, 0));

    foreach(var_14 in var_8._id_11A8C) {
      var_14 linkTo(var_8._id_C6EA);
    }

    level._id_111C3 = var_8;
    level.player thread _id_D2ED();
  }

  level._id_111C3.time = var_2;
  level._id_111C3._id_4DA0 = var_3;
  level._id_111C3._id_4D9F = 6.66667 / level._id_111C3._id_4DA0;
  level._id_111C3._id_BFD0 = var_4;
  level._id_111C3._id_BFCF = 3.33333 / level._id_111C3._id_BFD0;
  level._id_111C3._id_00F2 = var_5;
  level._id_111C3._id_118C3 = var_6;
  level._id_111C3._id_328E = 7;
  level._id_111C3._id_3288 = 16.5;
  level._id_111C3._id_94A3 = undefined;
  thread _id_111CA();
}

_id_111E7(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level notify("init_sun_rotation");

  if(isDefined(var_5)) {
    level endon("init_sun_rotation");
    level waittill("sun_time");
  }

  level._id_111C3._id_C6EA notify("stop_delay_thread");
  level notify("stop_fake_cycle");
  level notify("start_sun_rotation");
  level endon("start_sun_rotation");

  while(!isDefined(level._id_111C3)) {
    wait 0.05;
  }

  if(isDefined(var_0)) {
    level._id_111C3.time = scripts\engine\utility::mod(var_0, 24);
  }

  if(isDefined(var_1)) {
    level._id_111C3._id_4DA0 = var_1;
  }

  if(isDefined(var_2)) {
    level._id_111C3._id_BFD0 = var_2;
  }

  if(isDefined(var_3)) {
    level._id_111C3._id_00F2 = var_3;
  }

  if(isDefined(var_4)) {
    level._id_111C3._id_118C3 = var_4;
  }

  var_7 = scripts\engine\utility::mod(level._id_111C3.time, 0.25);

  if(var_7 > 0) {
    level._id_111C3.time = level._id_111C3.time + (0.25 - var_7);
  }

  level._id_111C3._id_4D9F = 6.66667 / level._id_111C3._id_4DA0;
  level._id_111C3._id_BFCF = 3.33333 / level._id_111C3._id_BFD0;

  if(isDefined(var_6) && var_6) {
    if(!scripts\engine\utility::flag("sun_off")) {
      _id_111E4();
    }
  } else if(!isDefined(var_6) || !var_6) {
    if(scripts\engine\utility::flag("sun_off")) {
      scripts\engine\utility::flag_clear("sun_off");
    }
  }

  if(!scripts\engine\utility::flag("dont_update_sun_on_restart")) {
    level._id_111C3._id_E6E5.angles = (level._id_111C3._id_118C3, level._id_111C3._id_00F2, 0);
  }

  level thread _id_111DE();
}

_id_111E9(var_0, var_1) {
  level._id_111C3._id_94A3 = var_0;

  if(!isDefined(var_1) || !var_1) {
    _id_F5B9();
  }
}

_id_11206(var_0, var_1) {
  level._id_111C3._id_C6EA notify("stop_delay_thread");
  level notify("start_sun_rotation");
  var_2 = 0.05;

  if(isDefined(var_1) && var_1) {
    var_2 = 0;
  }

  level._id_111C3._id_C6EA _meth_82B1(level._id_111C3.animation, var_2);

  if(!isDefined(var_0) || !var_0) {
    lerpsunangles(level._id_111C3._id_54DA[int(level._id_111C3.time)].angles, level._id_111C3._id_54DA[int(level._id_111C3.time)].angles, 0.05);
  } else {
    _id_111E4();
  }

  _id_F5B9(level._id_111C3.time);
}

_id_111E4(var_0) {
  if(isDefined(var_0)) {
    level endon("start_sun_rotation");
    level waittill("sun_time");
  }

  setsunlight(0, 0, 0);
  lerpsunangles(level._id_111C3._id_54DA[0].angles, level._id_111C3._id_54DA[0].angles, 0.1);
  scripts\engine\utility::flag_set("sun_off");
}

_id_111E5(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\engine\utility::flag("sun_off")) {
    scripts\engine\utility::flag_clear("sun_off");
  }

  level thread _id_111E7(var_0, var_1, var_2, var_3, var_4);
}

_id_9A6C(var_0, var_1, var_2, var_3, var_4) {
  level notify("stop_fake_cycle");
  level endon("stop_fake_cycle");
  _id_11206(1);
  var_5 = 1;

  if(isDefined(var_2)) {
    var_6 = 0;

    if(isDefined(level._id_1158[0])) {
      if(level._id_1158[0] == "dorm") {
        var_6 = 1;
      } else if(isDefined(level._id_1158[1])) {
        if(level._id_1158[1] == "dorm") {
          var_6 = 1;
        }
      }
    }

    if(var_2) {
      scripts\engine\utility::flag_set("power_on");
      scripts\engine\utility::flag_clear("power_off");

      if(isDefined(var_3)) {
        level waittill(var_3);
      } else {
        wait(var_0);
      }

      var_5 = 0;
    } else {
      scripts\engine\utility::flag_clear("power_on");
      scripts\engine\utility::flag_set("power_off");

      if(isDefined(var_3)) {
        level waittill(var_3);
      } else {
        wait(var_1);
      }

      var_5 = 1;
    }
  }

  for(;;) {
    var_6 = 0;

    if(isDefined(level._id_1158[0])) {
      if(level._id_1158[0] == "dorm") {
        var_6 = 1;
      } else if(isDefined(level._id_1158[1])) {
        if(level._id_1158[1] == "dorm") {
          var_6 = 1;
        }
      }
    }

    if(var_5) {
      scripts\engine\utility::flag_set("power_on");
      scripts\engine\utility::flag_clear("power_off");

      if(var_6 == 1) {
        scripts\engine\utility::exploder("dorm_room_lights");
        scripts\engine\utility::exploder("day_night_flares");
      }

      wait(var_0);
      var_5 = 0;
      continue;
    }

    scripts\engine\utility::flag_clear("power_on");
    scripts\engine\utility::flag_set("power_off");

    if(var_6 == 1) {
      scripts\sp\utility::_id_10FEC("dorm_room_lights");
      scripts\sp\utility::_id_10FEC("day_night_flares");
    }

    wait(var_1);
    var_5 = 1;
  }
}

_id_E2AF(var_0, var_1, var_2, var_3) {
  level notify("stop_fake_cycle");
  _id_111E7(var_0, var_1, var_2, var_3);
}

_id_111C9() {
  level endon("start_sun_rotation");

  for(;;) {
    var_0 = 15 * level._id_111C3.time;

    if(level._id_111C3.time >= 0 && level._id_111C3.time < 16) {
      var_1 = (level._id_111C3.time - 5.5) / 15.7;
      var_0 = 305 * var_1 - 50;
    } else {
      var_2 = (4.5 - level._id_111C3.time) / 11.0;
      var_0 = 55 * var_2 - 150;
    }

    if(var_0 > 360) {
      var_0 = var_0 - 360;
    }

    if(var_0 > 360) {
      var_0 = var_0 - 360;
    }

    if(var_0 < 0) {
      var_0 = var_0 + 360;
    }

    if(var_0 < 0) {
      var_0 = var_0 + 360;
    }

    if(level._id_111C3.time < 10) {
      _id_111D8((level._id_111C3.time / 24 - 14) * -50, var_0, undefined);
    } else {
      _id_111D8(0, var_0, undefined);
    }

    wait 0.05;
  }
}

_id_111DE() {
  level endon("start_sun_rotation");
  thread _id_111C9();
  _id_F5B9(level._id_111C3.time);
  thread _id_111C5(level._id_111C3.time);
  level._id_111C3._id_C6EA scripts\engine\utility::delaythread(0.05, ::_id_11207);
  _id_111E0();

  for(;;) {
    _id_F5B9(6);
    level._id_111C3._id_1EF6 thread scripts\sp\anim::_id_1F35(level._id_111C3._id_C6EA, "sun_rot");
    level._id_111C3._id_C6EA _meth_82B1(level._id_111C3.animation, level._id_111C3._id_4D9F);
    level thread _id_111DC();

    if(!scripts\engine\utility::flag("sun_off")) {
      lerpsunangles(level._id_111C3._id_54DA[6].angles, level._id_111C3._id_54DA[12].angles, level._id_111C3._id_4DA0 / 2);
      _id_5110(level._id_111C3._id_4DA0 / 2, level._id_111C3._id_54DA[12].angles, level._id_111C3._id_54DA[18].angles, level._id_111C3._id_4DA0 / 2);
      thread scripts\sp\utility::_id_111DA((0, 0, 0), level._id_111C3.light, max(0.05, level._id_111C3._id_4DA0 * 0.125));
    }

    wait(level._id_111C3._id_4DA0);
    var_0 = (level._id_111C3._id_BFCF - level._id_111C3._id_4D9F) / 2;
    var_1 = level._id_111C3._id_BFCF + 2 / level._id_111C3._id_BFD0 * var_0;
    level._id_111C3._id_C6EA _id_AB74("sun_rot", var_1, 2);
    wait(level._id_111C3._id_BFD0 - 2);
    level._id_111C3._id_C6EA _id_AB74("sun_rot", level._id_111C3._id_4D9F, 2);
    level._id_111C3._id_1EF6 waittill("sun_rot");
  }
}

_id_111CC() {
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    wait 0.1;

    if(isDefined(level._id_111C3) && scripts\engine\utility::flag("sun_vision_blend") && level._id_111C3.time > 3 && level._id_111C3.time < 16) {
      if(var_1 == 0) {
        var_1 = level._id_111C3.time;
      }

      while(var_1 < level._id_111C3.time) {
        var_1 = scripts\sp\utility::_id_E753(level._id_111C3.time, 0, 0);
        scripts\engine\utility::exploder("sunrise_" + var_1);
        scripts\engine\utility::exploder("sunrise_front_" + var_1);

        if(var_1 > 5) {
          if(var_1 < 10) {
            var_2 = var_1 - randomintrange(1, 5);
          } else {
            var_2 = 10 - randomintrange(1, 5);
          }

          scripts\engine\utility::exploder("sunrise_" + var_2);
          scripts\engine\utility::exploder("sunrise_front_" + var_2);
        }

        wait 0.5;
      }

      continue;
    }

    var_1 = 0;
    wait 1;
  }
}

_id_11208() {
  var_0 = "";
  wait 0.1;
  var_1 = 0;

  for(;;) {
    var_2 = 0;

    if(isDefined(level._id_1158[0])) {
      if(level._id_1158[0] != "hangar" && level._id_1158[0] != "solararray") {
        var_2 = 1;
      }
    }

    if(scripts\engine\utility::flag("disable_alt_vision_calls")) {
      visionsetalternate(0, 1);
      var_0 = "";
      scripts\engine\utility::flag_waitopen("disable_alt_vision_calls");
    }

    if(scripts\engine\utility::flag("dorm_run_over") && scripts\engine\utility::flag("sun_vision_blend") && var_2 == 1) {
      if(isDefined(level._id_111C3)) {
        if(level._id_111C3.time > 17 || level._id_111C3.time < 1) {
          if(var_0 != "rogue_night_alt") {
            var_0 = "rogue_night_alt";
            visionsetalternate(1, 3);
            wait 3;
          }
        } else if(level._id_111C3.time > 14) {
          if(var_0 != "rogue_sunset_alt") {
            var_0 = "rogue_sunset_alt";
            visionsetalternate(7, 2);
            wait 2;
          }
        } else if(level._id_111C3.time > 8) {
          if(var_0 != "rogue_alt") {
            var_0 = "rogue_alt";
            visionsetalternate(2, 3);

            if(!scripts\engine\utility::flag("dorm_run_over")) {
              scripts\sp\utility::_id_10FEC("hot_catwalk_01");
              scripts\engine\utility::exploder("hot_catwalk_01");
              scripts\sp\utility::_id_10FEC("hot_catwalk_02");
              scripts\engine\utility::exploder("hot_catwalk_02");
            } else if(var_1) {
              thread _id_A5C5();
              var_1 = 1;
            }
          }
        } else if(var_0 != "rogue_sunrise_alt") {
          var_0 = "rogue_sunrise_alt";
          visionsetalternate(3, 3);
          wait 3;
        }

        wait 0.1;
      } else {
        if(var_0 != "") {
          visionsetalternate(0, 1);
          var_0 = "";
          wait 1;
        }

        scripts\engine\utility::flag_wait_any("sun_vision_blend", "disable_alt_vision_calls");
      }

      continue;
    }

    if(isDefined(level._id_111C3) && scripts\engine\utility::flag("sun_vision_blend")) {
      if(level._id_111C3.time > 17 || level._id_111C3.time < 1) {
        if(var_0 != "rogue_night") {
          if(isDefined(level._id_1158[0])) {
            if(level._id_1158[0] == "solararray" && var_0 == "") {
              visionsetalternate(4, 0);
              var_0 = "rogue_night";
            }
          }

          if(var_0 != "rogue_night") {
            var_0 = "rogue_night";
            visionsetalternate(4, 3);
            wait 3;
          }
        }
      } else if(level._id_111C3.time > 14) {
        if(var_0 != "rogue_sunset") {
          var_0 = "rogue_sunset";
          visionsetalternate(5, 2);
          wait 2;
        }
      } else if(level._id_111C3.time > 8) {
        if(var_0 != "rogue") {
          var_0 = "rogue";
          visionsetalternate(0, 3);
          scripts\sp\utility::_id_10FEC("hot_catwalk_01");
          scripts\engine\utility::exploder("hot_catwalk_01");
          scripts\sp\utility::_id_10FEC("hot_catwalk_02");
          scripts\engine\utility::exploder("hot_catwalk_02");
          wait 3;
        }
      } else if(var_0 != "rogue_sunrise") {
        var_0 = "rogue_sunrise";
        visionsetalternate(6, 3);
        wait 3;
      }

      wait 0.1;
      continue;
    }

    if(var_0 != "") {
      visionsetalternate(0, 1);
      var_0 = "";
      wait 1;
    }

    scripts\engine\utility::flag_wait_any("sun_vision_blend", "disable_alt_vision_calls");
  }
}

_id_A5C5() {
  scripts\sp\utility::_id_10FEC("hot_catwalk_01");
  scripts\sp\utility::_id_10FEC("hot_catwalk_02");
}

_id_111E0() {
  level endon("start_sun_rotation");
  level._id_111C3._id_1EF6 thread scripts\sp\anim::_id_1F35(level._id_111C3._id_C6EA, "sun_rot");
  level._id_111C3._id_C6EA _meth_82B0(level._id_111C3.animation, _id_111D1(level._id_111C3.time));

  if(level._id_111C3.time >= 6 && level._id_111C3.time < 18) {
    var_0 = (level._id_111C3.time - 6.0) / 12.0;
    level._id_111C3._id_C6EA _meth_82B1(level._id_111C3.animation, level._id_111C3._id_4D9F);
    level thread _id_111DC();

    if(var_0 < 0.5) {
      var_1 = level._id_111C3._id_4DA0 * (0.5 - var_0);

      if(!scripts\engine\utility::flag("sun_off")) {
        setsunlight(level._id_111C3.light[0], level._id_111C3.light[1], level._id_111C3.light[2]);
        lerpsunangles(level._id_111C3._id_54DA[int(level._id_111C3.time)].angles, level._id_111C3._id_54DA[12].angles, var_1);
        _id_5110(var_1, level._id_111C3._id_54DA[12].angles, level._id_111C3._id_54DA[18].angles, level._id_111C3._id_4DA0 / 2.0);
      }

      wait(level._id_111C3._id_4DA0 / 2.0 + var_1);
    } else {
      var_1 = level._id_111C3._id_4DA0 * (1.0 - var_0);

      if(!scripts\engine\utility::flag("sun_off") && level._id_111C3.time < 16.5) {
        if(level._id_111C3.time < 15) {
          setsunlight(level._id_111C3.light[0], level._id_111C3.light[1], level._id_111C3.light[2]);
        }

        lerpsunangles(level._id_111C3._id_54DA[int(level._id_111C3.time)].angles, level._id_111C3._id_54DA[18].angles, var_1);
      }

      wait(var_1);
    }

    var_2 = (level._id_111C3._id_BFCF - level._id_111C3._id_4D9F) / 2;
    var_3 = level._id_111C3._id_BFCF + 2 / level._id_111C3._id_BFD0 * var_2;
    level._id_111C3._id_C6EA _id_AB74("sun_rot", var_3, 2);
    wait(level._id_111C3._id_BFD0 - 2);
    level._id_111C3._id_C6EA _id_AB74("sun_rot", level._id_111C3._id_4D9F, 2);
  } else {
    var_4 = level._id_111C3._id_BFD0 * (1 - scripts\engine\utility::mod(level._id_111C3.time - 18.0, 24.0) / 12.0);

    if(var_4 < 2) {
      level._id_111C3._id_C6EA _meth_82B1(level._id_111C3.animation, level._id_111C3._id_4D9F);
    } else {
      level._id_111C3._id_C6EA _meth_82B1(level._id_111C3.animation, level._id_111C3._id_BFCF);
      level._id_111C3._id_C6EA scripts\engine\utility::delaythread(var_4 - 2, ::_id_AB74, "sun_rot", level._id_111C3._id_4D9F, 2);
    }

    if(!scripts\engine\utility::flag("sun_off")) {
      lerpsunangles(level._id_111C3._id_BB10, level._id_111C3._id_BB10, 0.05);

      if(level._id_111C3.time < 6 && level._id_111C3.time >= 5.5) {
        setsunlight(0, 0, 0);
      } else if(level._id_111C3.time < 6 && level._id_111C3.time >= 3.5) {
        var_5 = (5.5 - level._id_111C3.time) / 12.0;
        var_6 = (5.5 - level._id_111C3.time) / 2.0;
        thread scripts\sp\utility::_id_111DA(var_6 * level._id_111C3._id_BB25, (0, 0, 0), max(0.05, level._id_111C3._id_BFD0 * var_5));
      } else {
        setsunlight(level._id_111C3._id_BB25[0], level._id_111C3._id_BB25[1], level._id_111C3._id_BB25[2]);
        level waittill("time_4");
        thread scripts\sp\utility::_id_111DA(level._id_111C3._id_BB25, (0, 0, 0), max(0.05, level._id_111C3._id_BFD0 / 7.0));
      }
    }
  }

  level._id_111C3._id_1EF6 waittill("sun_rot");
}

_id_111D8(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    level._id_111C3._id_00F2 = var_0;
  }

  if(isDefined(var_1)) {
    level._id_111C3._id_118C3 = var_1;
  }

  if(!isDefined(var_2)) {
    var_2 = level._id_111C3._id_BFD0 / 2.0;
  }

  level._id_111C3._id_E6E5 rotateTo((level._id_111C3._id_118C3, level._id_111C3._id_00F2, 0), var_2);
}

_id_111DC() {
  level notify("sun_day_night_transistion");
  level endon("sun_day_night_transistion");
  level endon("start_sun_rotation");

  if(level._id_111C3.time >= 15) {
    level thread _id_111DB();
  }

  if(!isDefined(level._id_118D0)) {
    level._id_118D0 = spawnStruct();
    thread _id_118D1(level._id_118D0);
    level waittill("manager_is_ready");
  }

  level waittill(level._id_118D0._id_111CD);

  if(!scripts\engine\utility::flag("sun_off")) {
    thread _id_E674(level._id_111C3.light, (0, 0, 0), max(0.05, level._id_111C3._id_4DA0 * 0.125));
  }

  level waittill(level._id_118D0._id_BB17);
  _id_F5B9(level._id_118D0._id_11205);

  if(!scripts\engine\utility::flag("sun_off")) {
    lerpsunangles(level._id_111C3._id_BB10, level._id_111C3._id_BB10, 0.05);
    thread _id_E674((0, 0, 0), level._id_111C3._id_BB25, max(0.05, level._id_111C3._id_4DA0 * 0.125));
  }

  level waittill(level._id_118D0._id_6C2B);

  if(!scripts\engine\utility::flag("sun_off")) {
    thread _id_E674(level._id_111C3._id_BB25, (0, 0, 0), max(0.05, level._id_111C3._id_BFD0 / 7.0));
  }
}

_id_118D1(var_0) {
  if(scripts\engine\utility::flag("player_stumbled_in_dorm_run")) {
    level._id_118D0._id_111CD = "time_15";
    level._id_118D0._id_BB17 = "time_16.5";
    level._id_118D0._id_6C2B = "time_4";
    level._id_118D0._id_11205 = 16.5;
    level notify("manager_is_ready");
    return;
  } else if(!scripts\engine\utility::flag("player_at_array2_scene")) {
    level._id_118D0._id_111CD = "time_15";
    level._id_118D0._id_BB17 = "time_16.5";
    level._id_118D0._id_6C2B = "time_4";
    level._id_118D0._id_11205 = 16.5;
    level notify("manager_is_ready");
    scripts\engine\utility::flag_wait("player_at_array2_scene");
  }

  level._id_118D0._id_111CD = "time_17";
  level._id_118D0._id_BB17 = "time_18.5";
  level._id_118D0._id_6C2B = "time_6";
  level._id_118D0._id_11205 = 18.5;
  level notify("manager_is_ready");
  scripts\engine\utility::flag_wait("player_stumbled_in_dorm_run");
  level._id_118D0._id_111CD = "time_15";
  level._id_118D0._id_BB17 = "time_16.5";
  level._id_118D0._id_6C2B = "time_4";
  level._id_118D0._id_11205 = 16.5;
  level notify("manager_is_ready");
}

_id_111DB() {
  level notify("sun_day_night_transistion");
  level endon("sun_day_night_transistion");
  level endon("start_sun_rotation");

  if(level._id_111C3.time > 16.5) {
    if(!scripts\engine\utility::flag("sun_off")) {
      var_0 = (18.0 - level._id_111C3.time) / 12.0;
      var_1 = (level._id_111C3.time - 16.5) / 1.5;
      var_2 = var_1 * level._id_111C3._id_BB25;
      lerpsunangles(level._id_111C3._id_BB10, level._id_111C3._id_BB10, 0.05);

      if(level._id_4DA0 != undefined) {
        thread scripts\sp\utility::_id_111DA(var_2, level._id_111C3._id_BB25, max(0.05, level._id_4DA0 * var_0));
      }
    }
  } else {
    var_0 = (16.5 - level._id_111C3.time) / 12.0;
    var_1 = (16.5 - level._id_111C3.time) / 1.5;

    if(!scripts\engine\utility::flag("sun_off")) {
      thread scripts\sp\utility::_id_111DA(level._id_111C3.light * var_1, (0, 0, 0), max(0.05, level._id_111C3._id_4DA0 * var_0));
    }

    level waittill("time_16.5");
    _id_F5B9(16.5);

    if(!scripts\engine\utility::flag("sun_off")) {
      lerpsunangles(level._id_111C3._id_BB10, level._id_111C3._id_BB10, 0.05);

      if(level._id_4DA0 != undefined) {
        thread scripts\sp\utility::_id_111DA((0, 0, 0), level._id_111C3._id_BB25, max(0.05, level._id_111C3._id_4DA0 * 0.125));
      }
    }

    visionsetalternate(1, level._id_111C3._id_4DA0 * 0.125);
  }
}

_id_11207() {
  level notify("start_sun_time_tracking");
  level endon("start_sun_time_tracking");
  level endon("start_sun_rotation");

  for(;;) {
    var_0 = _id_111D2(level._id_111C3._id_C6EA islegacyagent(level._id_111C3._id_C6EA scripts\sp\utility::_id_7DC1("sun_rot")));

    if(level._id_111C3.time != var_0) {
      level._id_111C3.time = var_0;
      level notify("time_" + scripts\sp\utility::string(level._id_111C3.time));

      if(level._id_111C3.time == int(level._id_111C3.time)) {
        level notify("sun_time", level._id_111C3.time);
      }
    }

    wait 0.05;
  }
}

_id_111C5(var_0) {
  level notify("start_sun_burn_state");
  level endon("start_sun_burn_state");
  level endon("start_sun_rotation");

  if(!isDefined(var_0)) {
    var_0 = level._id_111C3.time;
  }

  if(var_0 > level._id_111C3._id_328E && var_0 < level._id_111C3._id_3288) {
    if(!scripts\engine\utility::flag("sun_burn")) {
      scripts\engine\utility::flag_set("sun_burn");
    }

    _id_1120C(level._id_111C3._id_3288, scripts\engine\utility::mod(level._id_111C3._id_3288 + 0.25, 24.0));
    scripts\engine\utility::flag_clear("sun_burn");
  } else if(scripts\engine\utility::flag("sun_burn"))
    scripts\engine\utility::flag_clear("sun_burn");

  thread _id_111C6();
}

_id_111C6() {
  level endon("start_sun_burn_state");
  level endon("start_sun_rotation");

  for(;;) {
    _id_1120C(level._id_111C3._id_328E, scripts\engine\utility::mod(level._id_111C3._id_328E + 0.25, 24.0));

    if(!scripts\engine\utility::flag("sun_burn")) {
      scripts\engine\utility::flag_set("sun_burn");
    }

    _id_1120C(level._id_111C3._id_3288, scripts\engine\utility::mod(level._id_111C3._id_3288 + 0.25, 24.0));

    if(scripts\engine\utility::flag("sun_burn")) {
      scripts\engine\utility::flag_clear("sun_burn");
    }
  }
}

_id_F5B9(var_0) {
  if(!isDefined(var_0)) {
    var_0 = level._id_111C3.time;
  }

  if(var_0 >= 6 && var_0 < 16.5) {
    if(!scripts\engine\utility::flag("power_on") && !isDefined(level._id_C184)) {
      scripts\engine\utility::exploder("day");
      scripts\sp\utility::_id_10FEC("night");
    }

    if(!isDefined(level._id_111C3._id_94A3)) {
      if(scripts\engine\utility::flag("power_off")) {
        scripts\engine\utility::flag_clear("power_off");
      }

      if(!scripts\engine\utility::flag("power_on")) {
        scripts\engine\utility::flag_set("power_on");
      }
    }
  } else {
    if(!scripts\engine\utility::flag("power_off") && !isDefined(level._id_C184)) {
      scripts\sp\utility::_id_10FEC("day");
      scripts\engine\utility::exploder("night");
    }

    if(!isDefined(level._id_111C3._id_94A3)) {
      if(scripts\engine\utility::flag("power_on")) {
        scripts\engine\utility::flag_clear("power_on");
      }

      if(!scripts\engine\utility::flag("power_off")) {
        scripts\engine\utility::flag_set("power_off");
      }
    }
  }

  if(isDefined(level._id_111C3._id_94A3)) {
    if(level._id_111C3._id_94A3 && !scripts\engine\utility::flag("power_on")) {
      scripts\engine\utility::flag_set("power_on");
    }

    if(level._id_111C3._id_94A3 && scripts\engine\utility::flag("power_off")) {
      scripts\engine\utility::flag_clear("power_off");
    }

    if(!level._id_111C3._id_94A3 && scripts\engine\utility::flag("power_on")) {
      scripts\engine\utility::flag_clear("power_on");
    }

    if(!level._id_111C3._id_94A3 && !scripts\engine\utility::flag("power_off")) {
      scripts\engine\utility::flag_set("power_off");
    }
  }
}

_id_111D1(var_0) {
  if(!isDefined(var_0)) {
    var_0 = level._id_111C3.time;
  }

  var_0 = scripts\engine\utility::mod(var_0 + 18.0, 24.0);

  if(var_0 < 12) {
    return var_0 / 12.0 * 0.666667;
  }

  return 0.666667 + (var_0 - 12) / 12.0 * 0.333333;
}

_id_111D2(var_0) {
  if(var_0 < 0.666667) {
    var_1 = 18 * var_0 + 6;
  } else {
    var_1 = scripts\engine\utility::mod(36 * var_0 - 6, 24);
  }

  return var_1 - scripts\engine\utility::mod(var_1, 0.25);
}

_id_AB74(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 2;
  }

  var_3 = scripts\sp\utility::_id_7DC1(var_0);
  var_4 = self _meth_8104(var_3);
  var_5 = var_2 / 0.05;
  var_6 = (var_1 - var_4) / var_5;

  if(var_4 == var_1) {
    return 1;
  }

  thread _id_AB75(var_3, var_4, var_6, var_5 - 1, var_1);
}

_id_AB75(var_0, var_1, var_2, var_3, var_4) {
  for(var_5 = 0; var_5 < var_3; var_5++) {
    var_1 = var_1 + var_2;
    self _meth_82B1(var_0, var_1);
    wait 0.05;
  }

  self _meth_82B1(var_0, var_4);
}

_id_5110(var_0, var_1, var_2, var_3) {
  level endon("start_sun_rotation");
  thread _id_5111(var_0, var_1, var_2, var_3);
}

_id_5111(var_0, var_1, var_2, var_3) {
  level endon("start_sun_rotation");
  wait(var_0);
  lerpsunangles(var_1, var_2, var_3);
}

_id_111EA(var_0) {
  level._id_111C3._id_BB10 = var_0;
}

_id_111E8(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    level._id_111C3._id_328E = var_0;
  }

  if(isDefined(var_1)) {
    level._id_111C3._id_3288 = var_1;
  }

  if(!isDefined(var_2) || !var_2) {
    thread _id_111C5();
  }
}

_id_1120C(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 16.5;
  }

  if(!isDefined(var_1)) {
    var_1 = 19;
  }

  if(var_0 < var_1) {
    while(level._id_111C3.time < var_0 || level._id_111C3.time > var_1) {
      wait 0.05;
    }
  } else {
    while(level._id_111C3.time < var_0 && level._id_111C3.time > var_1) {
      wait 0.05;
    }
  }

  return 1;
}

_id_10403(var_0, var_1) {
  return int(var_1 / (1 - (var_0 - 6.0) / 12.0));
}

_id_D0D6(var_0) {
  if(getdvarint("rogue_hide_helmet", 0) == 1) {
    return;
  }
  level.player _id_0E4B::_id_8E06();
  level.player thread _id_6ED0();
}

_id_D0D5() {
  level.player _id_0E4B::_id_8E04();
}

_id_6ED0() {
  self endon("kill_flashlights");

  if(!isDefined(self._id_AC92)) {
    self._id_AC92 = spawn("script_model", (0, 0, 0));
    self._id_AC92 setModel("tag_origin");
    self._id_AC92 _meth_81E2(self, "tag_flash", (5, 0, -5), (0, 0, 0), 1);
  } else
    killfxontag(level._effect["ra_flashlight"], level.player._id_AC92, "tag_origin");

  wait 0.1;
  thread _id_187F();

  for(;;) {
    if(scripts\engine\utility::flag("force_flashlights_off") || !scripts\engine\utility::flag("flashlight_desired") || scripts\engine\utility::flag("temp_pause_flash")) {
      killfxontag(level._effect["ra_flashlight"], self._id_AC92, "tag_origin");
    } else {
      playFXOnTag(level._effect["ra_flashlight"], self._id_AC92, "tag_origin");
    }

    var_0 = level scripts\engine\utility::waittill_any_return("force_flashlights_off", "flashlight_desired", "temp_pause_flash", "recalc_flashlight");
  }
}

_id_187F() {
  self endon("kill_flashlights");
  var_0 = undefined;
  var_1 = 0;

  for(;;) {
    self waittill("weapon_switch_started");
    scripts\engine\utility::flag_set("temp_pause_flash");
    self waittill("weapon_change");
    scripts\engine\utility::flag_clear("temp_pause_flash");
    level notify("recalc_flashlight");
  }
}

_id_F8B6(var_0, var_1) {
  foreach(var_3 in var_0) {
    var_3 thread _id_6EBA(var_1);
  }
}

_id_6EBA(var_0) {
  self endon("kill_flashlight");
  self endon("death");
  self._id_AC92 = spawn("script_model", (0, 0, 0));
  self._id_AC92 setModel("tag_origin");
  var_1 = "tag_flash";
  self._id_AC92 linkTo(self, var_1, (1, 0, 0), anglesToForward(self gettagangles(var_1)), 1);
  var_2 = 0;

  for(;;) {
    while(scripts\engine\utility::flag("force_flashlights_off")) {
      wait 0.1;
    }

    if(isDefined(self._id_DD82)) {
      playFXOnTag(level._effect[var_0], self._id_AC92, "tag_origin");
      playFXOnTag(level._effect["vfx_ra_flashlight_lensflare"], self._id_AC92, "tag_origin");
    }

    while(!scripts\engine\utility::flag("force_flashlights_off")) {
      wait 0.1;
    }

    killfxontag(level._effect[var_0], self._id_AC92, "tag_origin");
    killfxontag(level._effect["vfx_ra_flashlight_lensflare"], self._id_AC92, "tag_origin");
  }
}

_id_61D3(var_0, var_1, var_2, var_3) {
  while(!isDefined(level._id_10AC8)) {
    wait 0.1;
  }

  _id_54FF();

  if(isDefined(var_0)) {
    foreach(var_5 in level._id_10AC8) {
      if(isDefined(var_2)) {
        if(var_5.name == var_2) {
          var_5._id_DD82 = 1;
        }

        continue;
      }

      var_5._id_DD82 = 1;
    }
  } else {
    foreach(var_5 in level._id_10AC8) {
      var_5._id_DD82 = undefined;
    }
  }

  if(isDefined(var_1)) {
    foreach(var_5 in level._id_10AC8) {
      if(isDefined(var_2)) {
        if(var_5.name == var_2) {
          var_5._id_2ABB = 1;
        }

        continue;
      }

      var_5._id_2ABB = 1;
    }
  } else {
    foreach(var_5 in level._id_10AC8) {
      var_5._id_2ABB = undefined;
    }
  }

  if(isDefined(var_3)) {
    _id_F8B6(level._id_10AC8, var_3);
  } else {
    _id_F8B6(level._id_10AC8, "vfx_ra_flashlight_buddy");
  }
}

_id_54FF() {
  while(!isDefined(level._id_10AC8)) {
    wait 0.1;
  }

  foreach(var_1 in level._id_10AC8) {
    var_1 notify("kill_flashlight");
    waittillframeend;

    if(isDefined(var_1._id_AC92)) {
      killfxontag(level._effect["vfx_ra_flashlight_buddy"], var_1._id_AC92, "tag_origin");
      killfxontag(level._effect["vfx_ra_flashlight_lensflare"], var_1._id_AC92, "tag_origin");
      var_1._id_AC92 delete();
      var_1._id_2ABB = undefined;
      var_1._id_DD82 = undefined;
    }
  }
}

_id_4D9D() {
  for(;;) {
    self waittill("trigger", var_0);

    if(isPlayer(var_0)) {
      break;
    }
  }

  switch (self.script_noteworthy) {
    case "hangar":
      _id_111E7(undefined, 30, 15, 10, 40);
      break;
    case "turret":
      _id_111E7(undefined, 48, 32, 150, -60);
      break;
    case "depot":
      _id_111E7(undefined, 26, 14);
      break;
    case "refinery":
      _id_111E7(undefined, 30, 12);
      break;
    case "shipping":
      _id_111E7(undefined, 30, 12);
      break;
    case "control":
      _id_111E7(9, 30, 30, 235);
      setsaveddvar("sm_sunSampleSizeNear", 2);
      break;
    default:
      break;
  }
}

_id_111C7() {
  if(!isDefined(self)) {}

  self endon("death");
  var_0 = 0;

  for(;;) {
    var_1 = 0;

    foreach(var_3 in level._id_111C3._id_11A8C) {
      if(_id_111C8(var_3) && level._id_111C3.time > 6 && level._id_111C3.time < 18 && !scripts\engine\utility::flag("disable_sun_logic")) {
        var_1 = 1;

        if(getDvar("sun_debug_info", "off") == "on") {}

        break;
      }
    }

    if(!isDefined(self._id_5942) && var_1 == 1 && var_0 == 0 && !scripts\engine\utility::flag("sun_safe_zone") && (level._id_111C3.time > 6 && level._id_111C3.time < 17)) {
      _id_3290();
      self notify("en_fuego");
      wait 0.5;
      level.player playgestureviewmodel("ges_sunblock", level._id_111C3.ent);
      var_0 = 1;
    } else if(var_1 == 0 && var_0 == 1) {
      _id_12B84();
      level.player thread _id_BFF9();
      var_0 = 0;
    }

    wait 0.25;
  }
}

_id_D2ED() {
  level.player.burning = 0;
  level.player thread _id_116CA();
  level.player thread _id_D2EC();

  for(;;) {
    if(scripts\engine\utility::flag("player_is_outside") && !scripts\engine\utility::flag("sun_safe_zone") || scripts\engine\utility::flag("fake_array_burn")) {
      if(scripts\engine\utility::flag("sun_burn")) {
        if(!isDefined(level.player._id_5942) && level.player.burning == 0 && isgodmode(level.player) != 1) {
          level.player.burning = 1;
          _id_3290();
          self notify("en_fuego");
          level.player scripts\engine\utility::delaycall(0.5, ::playgestureviewmodel, "ges_sunblock", level._id_111C3.ent);
        } else {}
      } else if(level.player.burning == 1) {
        level.player _id_12B84();
        level.player.burning = 0;
        level.player thread _id_BFF9();
      }
    } else if(level.player.burning == 1) {
      level.player _id_12B84();
      level.player.burning = 0;
      level.player thread _id_BFF9();
    }

    level scripts\engine\utility::waittill_any("player_is_outside", "sun_burn", "sun_safe_zone", "fake_array_burn");
  }
}

_id_BFF9() {
  self endon("en_fuego");
  wait 1.5;

  if(isalive(self)) {
    self stopgestureviewmodel();
  }
}

_id_1174B() {
  for(;;) {
    wait 1;
  }
}

_id_D2EC() {
  for(;;) {
    _id_0E29::_id_87F3();
    level.player._id_5942 = 1;

    for(;;) {
      var_0 = _id_0E29::_id_87A7();

      if(var_0 == "none" || var_0 == "end") {
        break;
      }

      wait 0.05;
    }

    level.player._id_5942 = undefined;
    wait 0.05;
  }
}

_id_111E6() {
  var_0 = scripts\engine\utility::array_combine(getEntArray("sun_trace_org", "script_noteworthy"), getEntArray("sun_bone_checker", "script_noteworthy"));

  if(!isDefined(level._id_328D)) {
    level._id_328D = [];
  }

  for(;;) {
    scripts\engine\utility::flag_wait("power_on");
    var_1 = 0;
    level._id_328D = scripts\sp\utility::array_removedeadvehicles(level._id_328D);

    foreach(var_3 in level._id_328D) {
      if(!isDefined(var_3) || !isalive(var_3)) {
        level._id_328D = scripts\sp\utility::array_removedeadvehicles(level._id_328D);
        continue;
      }

      var_4 = 0;

      foreach(var_6 in var_0) {
        var_1++;

        if(var_3 _id_111C8(var_6)) {
          var_4 = 1;
          break;
        }
      }

      if(var_4 && !var_3 scripts\sp\utility::_id_65DB("burning")) {
        var_3 thread _id_328C();
      } else if(var_3 scripts\sp\utility::_id_65DB("burning")) {
        var_3 scripts\sp\utility::_id_65DD("burning");
      }

      if(var_1 > 10) {
        wait 0.05;
      }
    }

    wait 0.05;
  }
}

_id_328C() {
  scripts\sp\utility::_id_65E1("burning");
  playFXOnTag(scripts\engine\utility::getfx("vfx_ra_smoke_body_01"), self, "tag_origin");

  while(isalive(self) && scripts\sp\utility::_id_65DB("burning") && scripts\engine\utility::flag("power_on")) {
    wait 0.1;
  }

  scripts\sp\utility::_id_65DD("burning");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_ra_smoke_body_01"), self, "tag_origin");
}

_id_111C8(var_0) {
  var_1 = bulletTrace(var_0.origin, var_0.origin + vectorNormalize(self.origin - var_0.origin) * 999999, 1, level._id_111C3._id_10288);

  if(isDefined(var_1["entity"]) && var_1["entity"] == self && scripts\engine\utility::flag("power_on")) {
    return 1;
  } else {
    return 0;
  }
}

_id_3290() {
  self.burning = 1;

  if(!isDefined(level.player._id_3293)) {
    level.player._id_3293 = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  }

  if(self == level.player) {
    if(getDvar("sun_debug_info", "off") == "on") {
      iprintlnbold("PLAYER IS BURNING");
    }

    self.burning = 1;
    thread _id_3287();
    level.player thread _id_E642();
    playFXOnTag(level._effect["vfx_ra_playerburn_camcentric"], level.player._id_3293, "tag_origin");
  } else {
    self notify("burning");
    var_0 = scripts\engine\utility::spawn_tag_origin();
    var_0.origin = self.origin;
    var_0 linkTo(self);
    var_1 = playFXOnTag(level._effect["RA_burnup_scrnfx"], self, "tag_origin");
    self._id_3292 = var_1;
    self._id_3293 = var_0;
  }
}

_id_E642() {
  var_0 = spawn("script_origin", level.player.origin);
  wait 0.05;
  var_0 playSound("scn_rogue_plr_onfire");
  scripts\engine\utility::waittill_any("stop_burning_sfx", "death");
  var_0 _meth_8278(0, 0.25);
  wait 0.25;
  var_0 stopsounds();
  wait 0.05;
  var_0 delete();
}

_id_3287() {
  self endon("death");
  self endon("burn_stopped");
  var_0 = 3;
  var_1 = 0.25;
  var_2 = 100 / (var_0 / var_1);
  var_2 = var_2 * 3;

  if(scripts\sp\utility::_id_93A6()) {
    var_2 = 0.5;
  }

  for(;;) {
    if(isDefined(level.player.sun_burn_mega_damage)) {
      var_2 = var_2 * 2;
    }

    var_3 = self.origin + (0, 0, 48);

    if(isDefined(level._id_111C3._id_1EF6.origin)) {
      var_3 = level._id_111EE.origin + vectorNormalize(level._id_111C3.ent.origin - level._id_111EE.origin);
    }

    if(getDvar("sun_burn_damage", "on") == "on") {
      if(scripts\engine\utility::flag("fake_burn_player")) {
        if(level.player.health - var_2 <= 25 && level.player.health - var_2 >= 5) {
          if(scripts\sp\utility::_id_93A6()) {
            level.player dodamage(var_2, var_3, level._id_111C3.ent);
          } else {
            level.player dodamage(2, var_3, level._id_111C3.ent);
          }
        } else if(level.player.health - var_2 <= 5) {} else
          level.player dodamage(var_2, var_3, level._id_111C3.ent);
      } else if(scripts\engine\utility::flag("fake_array_burn"))
        level.player dodamage(var_2 * 0.5, var_3, level._id_111C3.ent);
      else {
        level.player dodamage(var_2, var_3, level._id_111C3.ent);
      }
    }

    wait(var_1);
  }
}

_id_E664() {
  level.player waittill("death", var_0, var_1, var_2);

  if(isDefined(var_0._id_1178E)) {
    thread _id_111CB();
  }
}

_id_111CB() {
  if(isDefined(level.player._id_E646)) {
    return;
  }
  _id_0B60::_id_F322("ROGUE_DEATH_MSG_SUN");
}

_id_E675() {
  var_0 = spawn("script_origin", level.player.origin);
  var_0 linkTo(level.player);
  wait 0.05;
  var_0 playSound("ui_rogue_temperature_warning_lp_start");
  wait 0.5;
  var_0 thread rogue_temperature_sfx_lp();
  level.player scripts\engine\utility::waittill_any("stop_temperature_sfx", "death");
  var_0 stoploopsound("ui_rogue_temperature_warning_lp");
  var_0 delete();
  level.player playSound("ui_rogue_temperature_warning_lp_end");
}

rogue_temperature_sfx_lp() {
  level.player endon("stop_temperature_sfx");
  level.player endon("death");
  wait 1.7;
  self playLoopSound("ui_rogue_temperature_warning_lp");
}

_id_116CA() {
  level endon("stop_temp_meter");
  self._id_116C8 = -100;
  var_0 = -100;
  var_1 = 400;
  var_2 = 1;
  var_3 = 1;
  var_4 = 1;
  var_5 = 0;
  var_6 = 0.05;
  level._id_11695 = 0;

  if(!isDefined(self.burning)) {
    self.burning = 0;
  }

  for(;;) {
    if(self.burning) {
      if(!level._id_11695) {
        _id_12992();
        thread _id_1885(var_0, var_1);
        level._id_11695 = 1;
        var_5 = 1;
      }

      if(var_4 == 0) {
        var_4 = 1;
        var_3 = 0;
      }

      if(var_5 == 0 && self._id_116C8 > 90) {
        thread _id_E675();
        var_5 = 1;
      }

      var_3 = var_3 + 1;
      self._id_116C8 = _id_8CD1(var_1, var_0, var_2, var_3);
    } else {
      if(var_4) {
        var_4 = 0;
        var_3 = 0;
      }

      if(var_5 == 1 && self._id_116C8 <= 90) {
        level.player notify("stop_temperature_sfx");
        var_5 = 0;
      }

      var_3 = var_3 - 1;
      self._id_116C8 = _id_8CD1(var_1, var_0, var_2, var_3);
    }

    wait 0.05;
  }
}

_id_1885(var_0, var_1) {
  level notify("temp_gauge_on");
  level endon("temp_gauge_on");
  level.player endon("death");

  for(;;) {
    var_2 = scripts\sp\math::_id_6A8E(-250, 350, scripts\sp\math::_id_C097(var_0, var_1, self._id_116C8));
    level.player setclientomnvar("ui_helmet_meter_temperature", int(var_2));
    scripts\engine\utility::waitframe();

    if(self._id_116C8 == var_0) {
      break;
    }
  }

  wait 1;
  _id_12970();
}

_id_12992() {
  level.player setclientomnvar("ui_show_temperature_gauge", 1);
  level._id_11695 = 1;
  thread _id_E675();
}

_id_12970() {
  level.player setclientomnvar("ui_show_temperature_gauge", 0);
  level._id_11695 = 0;
  level.player notify("stop_temperature_sfx");
}

stop_player_burn() {
  level notify("kill_burner_scripts");
  killfxontag(level._effect["vfx_ra_playerburn_camcentric"], level.player._id_3293, "tag_origin");
  level.player._id_3293 delete();
}

_id_8CD1(var_0, var_1, var_2, var_3) {
  var_4 = self._id_116C8 + var_2 * var_3;

  if(var_4 > var_0) {
    return var_0;
  }

  if(var_4 < var_1) {
    return var_1;
  }

  return var_4;
}

_id_12B84() {
  if(getDvar("sun_debug_info", "off") == "on") {
    iprintlnbold("PLAYER IS COOL");
  }

  if(self == level.player) {
    if(level.player.health > 0) {
      level.player notify("stop_burning_sfx");
    }

    self.burning = 0;
    self notify("burn_stopped");

    if(isDefined(level.player._id_3293)) {
      killfxontag(level._effect["vfx_ra_playerburn_camcentric"], level.player._id_3293, "tag_origin");
    }
  } else if(isDefined(self._id_3293)) {
    self notify("burn_stopped");
    self._id_3293 unlink();
    stopFXOnTag(level._effect["RA_burnup_scrnfx"], self._id_3293, "tag_origin");
    wait 0.05;
    self._id_3293 delete();
  }
}

_id_4F28() {
  for(;;) {
    if(getDvar("sun_debug_time", "off") == "on") {
      iprintlnbold(level._id_111C3.time);
    }

    wait 1;
  }
}

_id_4F23() {
  var_0 = 1;

  for(;;) {
    while(getDvar("sun_debug_pos", "off") == "off") {
      wait 1;
    }

    iprintln("Sun Position Debugging On");

    while(getDvar("sun_debug_pos", "off") == "on") {
      if(level.player buttonPressed("DPAD_LEFT")) {
        _id_111E7(undefined, undefined, undefined, level._id_111C3._id_00F2 + 5);
        iprintln("Ang:" + level._id_111C3._id_00F2);

        if(!var_0) {
          scripts\engine\utility::delaythread(0.05, ::_id_11206);
        }

        wait 0.1;
      } else if(level.player buttonPressed("DPAD_RIGHT")) {
        _id_111E7(undefined, undefined, undefined, level._id_111C3._id_00F2 - 5);
        iprintln("Ang:" + level._id_111C3._id_00F2);

        if(!var_0) {
          scripts\engine\utility::delaythread(0.05, ::_id_11206);
        }

        wait 0.1;
      } else if(level.player buttonPressed("DPAD_DOWN")) {
        if(var_0) {
          iprintln("Pausing sun.");
          iprintln("Ang:" + level._id_111C3._id_00F2 + ", Time: " + level._id_111C3.time);
          var_0 = 0;
          _id_11206();
        } else {
          iprintln("Starting sun.");
          iprintln("Ang:" + level._id_111C3._id_00F2 + ", Time: " + level._id_111C3.time);
          var_0 = 1;
          _id_111E7();
        }

        wait 0.1;
      } else if(level.player buttonPressed("DPAD_UP")) {
        _id_111E7(level._id_111C3.time + 0.25);
        iprintln("Time: " + level._id_111C3.time);

        if(!var_0) {
          scripts\engine\utility::delaythread(0.05, ::_id_11206);
        }

        wait 0.1;
      }

      wait 0.05;
    }

    iprintln("Sun Position Debugging Off");
    wait 0.05;
  }
}

_id_17C3() {
  if(!isDefined(level._id_4055)) {
    level._id_4055 = [];
  }

  level._id_4055[level._id_4055.size] = self;
}

_id_40BF() {
  if(!isDefined(level._id_4055)) {
    return;
  }
  foreach(var_1 in level._id_4055) {
    if(isDefined(var_1)) {
      var_1 delete();
    }
  }

  level._id_4055 = [];
}

_id_EB54() {
  if(!isDefined(level._id_111C3)) {
    return scripts\engine\utility::flag("power_off");
  }

  if(level._id_111C3.time > 20 || level._id_111C3.time < 3) {
    return 1;
  } else {
    return 0;
  }
}

_id_50CA(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_2)) {
    thread _id_C63D(var_0, var_2, var_3);
  }

  scripts\engine\utility::flag_wait_or_timeout(var_3, var_1);

  if(scripts\engine\utility::flag(var_3) && !isDefined(level._id_C63D)) {
    thread _id_E354(var_3, var_4, var_5);
    return;
  }

  thread _id_E354(var_3, var_4, var_5, var_6);
  level._id_C63D = undefined;
}

_id_C63D(var_0, var_1, var_2) {
  level endon(var_2);

  if(!isarray(var_1)) {
    var_1 = [int(min(0, var_1)), int(max(-1, var_1))];
  }

  if(var_1[0] < 0) {
    for(var_3 = var_1[0]; var_3 < 0; var_3++) {
      level waittill("ai_killed", var_4);

      if(!isDefined(var_4._id_ECE7) || var_4._id_ECE7 != var_0) {
        var_3--;
      }
    }
  }

  if(var_1[1] >= 0) {
    while(scripts\sp\utility::_id_77DD(var_0) > var_1[1]) {
      wait 0.1;
    }
  }

  level._id_C63D = 1;
  scripts\engine\utility::flag_set(var_2);
}

_id_E354(var_0, var_1, var_2, var_3) {
  if(!scripts\engine\utility::flag(var_0)) {
    scripts\engine\utility::flag_set(var_0);
  }

  if(isDefined(var_1) && !isarray(var_1)) {
    var_1 = [var_1];
  }

  if(isDefined(var_1)) {
    var_4 = [];

    foreach(var_6 in var_1) {
      var_6 = getEnt(var_6, "targetname");

      if(isDefined(var_6)) {
        var_4[var_4.size] = var_6;
      }
    }

    if(var_4.size > 0) {
      var_1 = var_4;
    } else {
      var_1 = undefined;
    }
  }

  if(isDefined(var_1)) {
    var_1[0] notify("trigger");
    wait 0.05;

    if(isDefined(var_2) && var_2) {
      foreach(var_6 in var_1) {
        if(isDefined(var_6)) {
          var_6 delete();
        }
      }
    }
  }

  if(isDefined(var_3) && !isarray(var_3)) {
    var_3 = [var_3];
  }

  if(isDefined(var_3)) {
    foreach(var_11 in var_3) {
      level notify(var_11);
    }
  }
}

_id_A732(var_0) {
  if(!isDefined(level._id_A660)) {
    return var_0;
  }

  if(level._id_A660 > 2) {
    return var_0 * clamp(level._id_A660 - 1, 1, 5);
  }

  return var_0;
}

_id_33B0() {
  scripts\sp\utility::_id_72EC("iw7_kbs", "primary");
  self _meth_81D6();
}

_id_33AE() {
  scripts\sp\utility::_id_72EC("iw7_spas", "primary");
}

_id_33AF() {}

_id_106D3() {
  self._id_1FBB = "security_bot";
  self.a.disablelongdeath = 1;
  scripts\engine\utility::array_add(level._id_328D, self);
  thread _id_EBDC();
  thread _id_EBD6();
  thread _id_EBDA();
}

_id_C63F(var_0) {
  self endon("death");
  level._id_649C[level._id_649C.size] = self;
  scripts\sp\utility::_id_F3E6(0);
  self._id_1FBB = "security_bot";
  self.a.disablelongdeath = 1;
  thread _id_EBDC();
  thread _id_EBD6();
  thread _id_EBDA();
  thread _id_EBE8();

  if(var_0) {
    thread _id_E662();
  } else {
    self.dontmelee = 1;

    if(isDefined(level._id_8425)) {
      self waittill("follow_path");
    }

    if(isDefined(self.goal)) {
      _id_0B77::_id_8409(self.goal);
    } else {
      _id_0B77::_id_8409();
    }
  }
}

_id_E597() {
  var_0 = spawn("script_model", self gettagorigin("tag_flash"));
  var_0.angles = self gettagangles("tag_flash");
  var_0 linkTo(self, "tag_flash");
  var_0 setModel("tag_laser");
  self._id_A865 = var_0;
  var_0 _meth_81D6();
  self waittill("death");
  var_0 delete();
}

_id_EBE8() {
  scripts\sp\utility::_id_65E0("newly_spawned");
  wait 0.05;
  scripts\sp\utility::_id_65E1("newly_spawned");
  wait 0.5;
  scripts\sp\utility::_id_65DD("newly_spawned");
}

_id_E662() {
  self endon("death");
  scripts\sp\utility::_id_F3E6(0);
  self.a.disablelongdeath = 1;
  _id_F3FD();

  if(isDefined(self.script_parameters) && !scripts\engine\utility::flag(self.script_parameters)) {
    self orientmode("face current");
    self setgoalpos(self.origin);
    _id_0A03::_id_13DC1(0);
    self.ignoreall = 1;
    self.ignoreme = 1;
    self.pacifist = 1;
    scripts\engine\utility::flag_wait(self.script_parameters);
    wait 0.05;
    _id_0A03::_id_13DC1(1);
    self.ignoreall = 0;
    self.ignoreme = 0;
    self.pacifist = 0;
  }

  if(isDefined(self.target) || isDefined(level._id_8425)) {
    _id_0A03::_id_13DC1(0);

    if(isDefined(level._id_8425)) {
      self waittill("follow_path");
    }

    if(isDefined(self.goal)) {
      _id_0B77::_id_8409(self.goal);
    } else {
      _id_0B77::_id_8409();
    }

    _id_0A03::_id_13DC1(1);
  }

  self orientmode("face enemy or motion", self.angles);
  self.fixednode = 0;
}

_id_F3FD() {
  var_0 = scripts\sp\utility::_id_7E72();
  var_1 = undefined;

  switch (var_0) {
    case "easy":
      self._id_12B7F = 30;
      var_1 = 1.5;
      break;
    case "medium":
      self._id_12B7F = 50;
      var_1 = 1.65;
      break;
    case "hard":
      self._id_12B7F = 55;
      var_1 = 1.95;
      break;
    case "fu":
      self._id_12B7F = 110;
      var_1 = 2.05;
      break;
  }

  self.health = int(floor(self.health * var_1));
  self.maxhealth = int(floor(self.health * var_1));
}

_id_B0DA(var_0) {
  self waittill("death");
  var_0._id_F175--;
}

_id_F117(var_0, var_1) {
  return var_0._id_F175 < var_1._id_F175;
}

_id_EBDC() {
  self endon("death");
  scripts\sp\utility::_id_65E0("power_on");

  if(self.script_noteworthy == "melee_c6") {
    if(!scripts\engine\utility::flag("power_on")) {
      thread _id_EBE0(1);
    }

    for(;;) {
      scripts\engine\utility::flag_wait("power_on");
      thread _id_EBE3();
      scripts\engine\utility::flag_wait("power_off");
      thread _id_EBE0();
    }
  } else {
    if(!scripts\engine\utility::flag("power_on")) {
      thread _id_EBDF(1);
    }

    for(;;) {
      scripts\engine\utility::flag_wait("power_on");
      thread _id_EBE2();
      scripts\engine\utility::flag_wait("power_off");
      thread _id_EBDF();
    }
  }
}

_id_EBE0(var_0) {
  self endon("death");

  if(!isDefined(var_0) || !var_0) {
    thread scripts\sp\utility::_id_65DE("power_on", 0.5);
    var_1 = randomfloatrange(2.0, 4.0);
    thread _id_B5E2();
    thread _id_EBD5();
    wait(var_1);
  } else
    thread _id_EBD5();

  thread _id_B5E2();
  scripts\sp\utility::_id_65DD("power_on");
}

_id_EBE3() {
  self endon("death");

  if(isDefined(self._id_74D1)) {
    [[self._id_74D1]]();
    return;
  }

  wait(randomfloat(0.25));
  var_0 = randomfloatrange(1.5, 3.0);
  thread _id_B5E3();
  thread _id_EBE6();
  wait(var_0);
  scripts\sp\utility::_id_65E1("power_on");
}

_id_B5E3() {
  self endon("death");
  level endon("power_off");
}

_id_B5E2() {
  self endon("death");
  level endon("power_on");
}

_id_EBD5(var_0) {
  self endon("death");
  self endon("stop_lights");
  self notify("scbt_blue_light");
  self endon("scbt_blue_light");
  var_1 = scripts\engine\utility::getfx("vfx_ra_glow_c6_head_inital_a");
  var_2 = scripts\engine\utility::getfx("vfx_ra_glow_c6_head_inital_b");

  if(!isDefined(var_0) || !var_0) {
    thread _id_EBDE();
  }

  var_3 = 1;

  if(!isDefined(self.light_tag)) {
    self.light_tag = scripts\engine\utility::spawn_tag_origin(self gettagorigin("TAG_EYE"));
    self.light_tag linkTo(self, "TAG_EYE");
  }

  for(;;) {
    var_3 = randomfloatrange(0.5, 1);
    playFXOnTag(var_1, self.light_tag, "tag_origin");
    wait(var_3);

    for(;;) {
      var_3 = randomfloatrange(0.5, 1);
      killfxontag(var_1, self.light_tag, "tag_origin");
      playFXOnTag(var_2, self.light_tag, "tag_origin");
      wait(var_3);

      if(scripts\engine\utility::flag("power_on")) {
        killfxontag(var_2, self.light_tag, "tag_origin");
        return;
      }

      var_3 = randomfloatrange(0.5, 1);
      killfxontag(var_2, self.light_tag, "tag_origin");
      playFXOnTag(var_1, self.light_tag, "tag_origin");
      wait(var_3);

      if(scripts\engine\utility::flag("power_on")) {
        killfxontag(var_1, self.light_tag, "tag_origin");
        return;
      }
    }
  }
}

_id_EBE5() {
  self endon("death");
  wait 0.05;

  if(scripts\sp\utility::_id_65DB("newly_spawned")) {
    return;
  }
  wait(randomfloatrange(0.05, 0.15));
  scripts\sp\utility::play_sound_on_entity("c6_power_up");
}

_id_EBDE() {
  self endon("death");
  wait 0.05;

  if(scripts\sp\utility::_id_65DB("newly_spawned")) {
    return;
  }
  wait(randomfloatrange(0.05, 0.15));
  scripts\sp\utility::play_sound_on_entity("c6_power_down");
}

_id_EBD7() {
  self notify("stop_lights");

  if(isDefined(self.light_tag)) {
    self.light_tag delete();
  }
}

_id_EBE6(var_0) {
  self endon("death");
  self endon("stop_lights");
  self endon("entitydeleted");
  self notify("scbt_red_light");
  self endon("scbt_red_light");
  var_1 = scripts\engine\utility::getfx("vfx_ra_glow_c6_head_atteck_a");
  var_2 = scripts\engine\utility::getfx("vfx_ra_glow_c6_head_atteck_b");

  if(!isDefined(self.light_tag)) {
    self.light_tag = scripts\engine\utility::spawn_tag_origin(self gettagorigin("TAG_EYE"));
    self.light_tag linkTo(self, "TAG_EYE");
  }

  var_3 = 1;

  if(!isDefined(var_0) || !var_0) {
    thread _id_EBE5();
  }

  for(;;) {
    var_3 = randomfloatrange(0.05, 0.15);
    playFXOnTag(var_1, self.light_tag, "tag_origin");
    wait(var_3);

    for(;;) {
      var_3 = randomfloatrange(0.05, 0.15);
      killfxontag(var_1, self.light_tag, "tag_origin");
      playFXOnTag(var_2, self.light_tag, "tag_origin");
      wait(var_3);

      if(scripts\engine\utility::flag("power_off")) {
        killfxontag(var_2, self.light_tag, "tag_origin");
        return;
      }

      var_3 = randomfloatrange(0.05, 0.15);
      killfxontag(var_2, self.light_tag, "tag_origin");
      playFXOnTag(var_1, self.light_tag, "tag_origin");
      wait(var_3);

      if(scripts\engine\utility::flag("power_off")) {
        killfxontag(var_1, self.light_tag, "tag_origin");
        return;
      }
    }
  }
}

_id_EBD8(var_0, var_1) {
  self endon("death");
  self endon("stop_lights");
  self endon("entitydeleted");

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0.75;
  }

  if(var_0) {
    var_2 = scripts\engine\utility::getfx("vfx_ra_glow_c6_head_atteck_a");
    var_3 = scripts\engine\utility::getfx("vfx_ra_glow_c6_head_atteck_b");
  } else {
    var_2 = scripts\engine\utility::getfx("vfx_ra_glow_c6_head_inital_a");
    var_3 = scripts\engine\utility::getfx("vfx_ra_glow_c6_head_inital_b");
  }

  _id_EBD9(var_2, var_3, var_1, var_0);

  if(!isDefined(self.light_tag)) {
    killfxontag(var_2, self.light_tag, "tag_origin");
    killfxontag(var_3, self.light_tag, "tag_origin");
  }
}

_id_EBD9(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("stop_lights");
  self endon("entitydeleted");

  if(var_3) {
    level endon("power_off");
  } else {
    level endon("power_on");
  }

  if(!isDefined(self.light_tag)) {
    self.light_tag = scripts\engine\utility::spawn_tag_origin(self gettagorigin("TAG_EYE"));
    self.light_tag linkTo(self, "TAG_EYE");
  }

  var_4 = min(randomfloatrange(0.1, 0.2), var_2);
  var_2 = var_2 - var_4;
  playFXOnTag(var_0, self.light_tag, "tag_origin");
  wait(var_4);

  for(;;) {
    var_4 = min(randomfloatrange(0.05, 0.15), var_2);
    var_2 = var_2 - var_4;
    killfxontag(var_0, self.light_tag, "tag_origin");
    playFXOnTag(var_1, self.light_tag, "tag_origin");
    wait(var_4);

    if(var_4 <= 0) {
      break;
    }

    var_4 = min(randomfloatrange(0.05, 0.25), var_2);
    var_2 = var_2 - var_4;
    killfxontag(var_1, self.light_tag, "tag_origin");
    playFXOnTag(var_0, self.light_tag, "tag_origin");
    wait(var_4);
  }
}

_id_EBE2() {
  self endon("death");
  wait(randomfloat(0.25));
  var_0 = randomfloatrange(1.5, 3.0);
  _id_0F3D::_id_2370();
  thread _id_EBE6();
  wait(var_0);
  scripts\sp\utility::_id_65E1("power_on");

  if(!scripts\engine\utility::flag("scbt_ignore_combat")) {
    isgameparticipant(0);
  }
}

_id_EBDF(var_0) {
  self endon("death");

  if(!isDefined(var_0) || !var_0) {
    thread scripts\sp\utility::_id_65DE("power_on", 0.5);
    var_1 = randomfloatrange(2.0, 4.0);
    thread _id_EBD5();
    wait(var_1);
  } else
    thread _id_EBD5();

  _id_0F3D::_id_236F();
  isgameparticipant(1, !scripts\engine\utility::flag("night_kill"));
  scripts\sp\utility::_id_65DD("power_on");
}

_id_EBD6() {
  self waittill("death");

  if(isDefined(self)) {
    _id_EBD7();
  }
}

_id_EBDA() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(var_4 != "MOD_MELEE" || !isPlayer(var_1) || scripts\sp\utility::_id_65DB("power_on")) {
      continue;
    }
    wait 0.1;
    self _meth_81D0();
  }
}

_id_EBDB() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(var_4 == "MOD_MELEE" || scripts\sp\utility::_id_65DB("power_on")) {
      continue;
    }
    self dodamage(var_0, var_3, var_1, var_1, var_4);
  }
}

isgameparticipant(var_0, var_1, var_2, var_3) {
  self notify("toggle_ignore_combat");
  self endon("toggle_ignore_combat");

  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  if(!var_0 && scripts\engine\utility::flag("scbt_ignore_combat") && !isDefined(var_3)) {
    scripts\engine\utility::flag_waitopen("scbt_ignore_combat");
  }

  var_4 = 0.9;
  var_5 = 262144;

  if(!isDefined(var_2) || !var_2) {
    if(isDefined(self._id_85B3)) {
      var_4 = self._id_85B3;
    }

    if(isDefined(self._id_BF21)) {
      var_5 = self._id_BF21;
    }
  }

  self.a._id_5605 = var_0;
  self.allowpain = !var_0;
  self.dodangerreact = var_0;
  self.ignoreall = var_0;
  self.ignoreme = var_1;
  self.ignoreexplosionevents = var_0;
  self.ignorerandombulletdamage = var_0;
  self.ignoresuppression = var_0;
  self.disablebulletwhizbyreaction = _id_12AFC(var_0);
  self._id_55EF = _id_12AFC(var_0);
  self._id_6EC4 = _id_12AFC(var_0);

  if(var_0) {
    self._id_85B3 = self.grenadeawareness;
    self._id_BF21 = self.newenemyreactiondistsq;
    self.grenadeawareness = 0;
    self.newenemyreactiondistsq = 0;
  } else {
    self.grenadeawareness = var_4;
    self.newenemyreactiondistsq = var_5;
    self._id_85B3 = undefined;
    self._id_BF21 = undefined;
  }
}

_id_12AFC(var_0) {
  if(var_0) {
    return var_0;
  } else {
    return undefined;
  }
}

_id_404A(var_0) {
  foreach(var_2 in level._id_649C) {
    if(isDefined(var_2.script_parameters) && var_2.script_parameters == var_0) {
      var_2 _meth_81D0();
    }
  }
}

_id_D26D() {
  var_0 = 1;
  var_1 = 4;
  var_2 = 4;
  var_3 = 12;
  level._id_D273 = scripts\sp\utility::_id_7C23();
  level._id_D273.origin = level.player.origin;
  level._id_D273 scripts\sp\utility::_id_F581(0);
  level._id_D273 linkTo(level.player);

  for(;;) {
    scripts\engine\utility::flag_waitopen("stop_shakes_and_quakes");
    var_4 = 0;

    if(isDefined(level._id_1158[0])) {
      if(level._id_1158[0] == "hangar" && scripts\engine\utility::flag("player_is_outside") == 1) {
        var_4 = 1;
      }
    }

    if(var_4 == 1) {
      wait(randomfloatrange(var_2 / 20, var_3 / 20));
    } else {
      wait(randomfloatrange(var_2, var_3));
    }

    if(!scripts\engine\utility::flag("stop_shakes_and_quakes")) {
      var_5 = randomfloatrange(var_0, var_1);

      if((level._id_111C3.time > 4 && level._id_111C3.time < 22 || scripts\engine\utility::flag("power_on") || var_4 == 1) && var_5 >= 1) {
        if(scripts\engine\utility::flag("player_is_inside")) {
          var_6 = 0.35;
          var_7 = "rogue_quake";
        } else {
          var_6 = 0.5;
          var_7 = "rogue_quake";
        }
      } else {
        var_6 = 0.1;
        var_7 = "rogue_mini_quake";
      }

      if(scripts\engine\utility::flag("civs_small_quakes")) {
        if(var_6 > 0.2) {
          var_6 = randomfloatrange(0.1, 0.2);
        }
      }

      level notify(var_7, var_5);
      thread _id_E669(var_5, var_6, var_7);

      if(var_7 != "rogue_mini_quake") {
        thread _id_E66D(var_5, var_6);
      }

      thread _id_E66C(var_5, var_6);
      wait(var_5 + randomfloatrange(2, 5));
    }
  }
}

_id_D71F() {
  var_0 = 5;
  var_1 = 0.75;
  var_2 = "rogue_quake";
  level notify(var_2, var_0);
  thread _id_E669(var_0, var_1, var_2);

  if(var_2 != "rogue_mini_quake") {
    thread _id_E66D(var_0, var_1);
  }

  thread _id_E66C(var_0, var_1);
}

_id_E669(var_0, var_1, var_2) {
  if(scripts\engine\utility::flag("combat_section_active")) {
    var_3 = var_1 / 2;
  } else if(scripts\engine\utility::flag("interior_quakes")) {
    if(getdvarint("display_rogue_rumbles", 0)) {
      iprintlnbold("indoor_quake");
    }

    var_3 = var_1 / 2;
  } else {
    if(getdvarint("display_rogue_rumbles", 0)) {
      iprintlnbold("outdoor_quake");
    }

    var_3 = var_1;
  }

  level notify(var_2);
  var_4 = level.player getEye();
  var_5 = level.player getplayerangles();
  var_6 = anglesToForward(var_5);

  if(!isDefined(level._id_CB16)) {
    level._id_CB16 = "left";
  }

  switch (level._id_CB16) {
    case "left":
      level._id_CB16 = "right";
      var_7 = anglestoleft(var_5) * 100;
      break;
    case "right":
      level._id_CB16 = "left";
      var_7 = anglestoright(var_5) * 100;
      break;
    default:
      var_7 = anglestoleft(var_5);
      break;
  }

  var_8 = ["dorm", "controlroom", "depot", "finale"];
  var_9 = 20;
  var_10 = 0;

  if(level._id_1158[0] == "finale") {
    var_10 = 1;
  } else if(isDefined(level._id_1158[1])) {
    if(level._id_1158[1] == "finale") {
      var_10 = 1;
    }
  }

  var_11 = 0;

  if(isDefined(level._id_1158[1])) {
    if(level._id_1158[1] == "dorm") {
      var_11 = 1;
    }
  }

  if(scripts\engine\utility::array_contains(var_8, level._id_1158[0]) || var_11) {
    switch (var_2) {
      case "rogue_quake":
        var_9 = 20;
        break;
      case "rogue_mini_quake":
        var_9 = 10;
        break;
      default:
        break;
    }
  } else if(var_10) {
    switch (var_2) {
      case "rogue_quake":
        var_9 = 20;
        break;
      case "rogue_mini_quake":
        var_9 = 10;
        break;
      default:
        break;
    }

    var_3 = var_3 * 0.65;
    var_0 = var_0 * 0.75;
  } else {
    switch (var_2) {
      case "rogue_quake":
        var_9 = 35;
        var_3 = var_3 * 1.3;
        var_0 = var_0 * 1.4;
        break;
      case "rogue_mini_quake":
        var_9 = 10;
        break;
      default:
        break;
    }
  }

  earthquake(var_3, var_0, level.player.origin, 850);
  wait 0.2;
  physicsexplosionsphere(var_4 + var_6 * 100 + var_7 + (0, 0, -200), 400, 1, var_9);
}

_id_E66D(var_0, var_1) {
  if(scripts\engine\utility::flag("interior_quakes")) {
    var_2 = var_1 * 0.067;
  } else {
    var_2 = var_1 * 0.267;
  }

  level._id_D273 thread scripts\sp\utility::_id_E7C9(var_2, var_0 * 0.1);
  wait(var_0 * 0.25);
  level._id_D273 thread scripts\sp\utility::_id_E7C9(0, var_0 * 0.25);
}

_id_E66C(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  if(var_1 > 0.2) {
    if(scripts\engine\utility::flag("player_is_inside")) {
      level.player thread scripts\sp\utility::play_sound_on_entity("elm_quake_mtl_rumble");
    } else {
      level.player thread scripts\sp\utility::play_sound_on_entity("elm_quake_sub_rumble");
    }
  } else if(scripts\engine\utility::flag("player_is_inside"))
    level.player thread scripts\sp\utility::play_sound_on_entity("emt_rogue_sml_mtl_quake");
  else if(!scripts\engine\utility::flag("finale_takeoff_begin")) {
    level.player thread scripts\sp\utility::play_sound_on_entity("emt_rogue_sml_quake");
  }
}

_id_9C6C() {
  return scripts\engine\utility::flag("power_on") && !(isDefined(level.player.burning) && level.player.burning);
}

_id_F943(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_1._id_1FBB = "airlock_door";
  var_1 scripts\sp\anim::_id_F64A();
  return var_1;
}

_id_118CC() {
  var_0 = getEntArray("time_dilation_trig", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _id_118CB();
  }
}

_id_118CB() {
  self waittill("trigger");

  if(level._id_111C3.time >= 6 && level._id_111C3.time <= 12) {
    return;
  }
  if(level._id_111C3.time >= 12 && level._id_111C3.time <= 18) {
    _id_111E7(10);
    return;
  }

  if(level._id_111C3.time >= 18 && level._id_111C3.time <= 24) {
    while(level._id_111C3.time > 18) {
      wait 0.05;
    }

    _id_111E7(4);
    return;
  }

  if(level._id_111C3.time >= 0 && level._id_111C3.time <= 4) {
    while(level._id_111C3.time < 4) {
      wait 0.05;
    }

    return;
  }
}

_id_13809(var_0, var_1, var_2) {
  for(;;) {
    if(level._id_111C3.time > var_0 - 0.5 && level._id_111C3.time < var_0 + 0.5) {
      break;
    } else {
      if(isDefined(var_1) && !scripts\engine\utility::flag("power_on")) {
        break;
      }

      if(isDefined(var_2) && scripts\engine\utility::flag("power_on")) {
        break;
      }
    }

    wait 0.05;
  }
}

_id_83C6() {
  var_0 = scripts\engine\utility::getStructArray("glass_break_trigger", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _id_83C5();
  }
}

_id_83C5() {
  var_0 = scripts\engine\utility::get_target_ent();

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(level.player isjumping() && scripts\sp\utility::_id_7951(level.player.origin, level.player.angles, self.origin) >= 0.2) {
      glassradiusdamage(self.origin, 64, 20, 20);
    }
  }
}

_id_111CA() {
  if(isDefined(level._id_111EE)) {
    wait 0.05;
    level._id_111EE playLoopSound("rogue_sun_sfx");

    if(!scripts\engine\utility::flag("player_is_inside")) {
      level._id_111EE _meth_8278(1, 4);
    }
  }

  wait 1;
  var_0 = (1000, 1000, 500);
  var_1 = "c6_power_down";

  for(;;) {
    scripts\engine\utility::flag_wait("power_on");

    if(scripts\engine\utility::flag("player_is_inside")) {
      if(!scripts\engine\utility::flag("no_power_sfx")) {
        level.player playSound("rogue_gen_poweron");
      }

      if(isDefined(level._id_111EE)) {
        level._id_111EE _meth_8278(0.2, 4);
      }
    } else {
      level.player playSound("rogue_gen_ext_poweron");

      if(isDefined(level._id_111EE)) {
        level._id_111EE _meth_8278(1, 4);
      }
    }

    setaudiotriggerstate("default", "sunup", 4);
    setglobalsoundcontext("rogue_sun", "", 4);
    wait 0.1;
    setaudiotriggerstate("rogue_storm", "sunup", 4);
    scripts\engine\utility::flag_waitopen("power_on");

    if(getDvar("ra_toggle_power_sounds", "on") == "on") {
      if(scripts\engine\utility::flag("player_is_inside")) {
        if(!scripts\engine\utility::flag("no_power_sfx")) {
          level.player playSound("rogue_gen_poweroff");
        }

        if(isDefined(level._id_111EE)) {
          level._id_111EE _meth_8278(0.2, 4);
        }
      } else {
        level.player playSound("rogue_gen_ext_poweroff");

        if(isDefined(level._id_111EE)) {
          level._id_111EE _meth_8278(0.4, 6);
        }
      }

      setaudiotriggerstate("default", "sundown", 6);
      setglobalsoundcontext("rogue_sun", "sundown", 6);
      wait 0.1;
      setaudiotriggerstate("rogue_storm", "sundown", 6);
    }
  }
}

_id_D214(var_0, var_1, var_2) {
  var_3 = scripts\sp\utility::_id_10639("player_rig");
  var_4 = scripts\engine\utility::spawn_tag_origin();
  var_4.origin = var_0 gettagorigin("tag_origin");
  var_4.angles = var_0 gettagangles("tag_origin");
  var_0 = _id_F943(var_0.targetname);
  var_5 = "airlock_open_inside";

  if(!var_1) {
    var_5 = "airlock_open_outside";
  }

  if(isDefined(var_2)) {
    var_5 = var_2;
  }

  var_3 hide();
  var_6 = [];
  var_6[0] = var_3;
  var_6[1] = var_0;
  var_4 scripts\sp\anim::_id_1EC3(var_3, var_5);
  level.player allowcrouch(0);
  level.player freezecontrols(1);
  level.player disableweapons();
  level.player _meth_823C(var_3, "tag_player", 0.75, 0, 0);
  thread _id_FBD5();
  wait 0.75;
  var_3 show();
  scripts\engine\utility::flag_set("player_in_scene");
  level.player playerlinktodelta(var_3, "tag_player", 1, 10, 10, 10, 10, 1);
  var_4 scripts\sp\anim::_id_1F2C(var_6, var_5);
  level.player unlink();
  level.player allowcrouch(1);
  level.player freezecontrols(0);
  level.player enableweapons();
  scripts\engine\utility::flag_clear("player_in_scene");
  var_3 delete();
}

_id_FBD5() {
  level.player playSound("scn_rogue_airlock_door_open");
}

_id_262D(var_0, var_1) {
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = self.origin;
  var_2.angles = self.angles;
  self._id_1FBD = var_2;
  self notify("door_action");

  if(var_0) {
    var_2 scripts\sp\anim::_id_1EC3(self, "airlock_open");
  } else {
    var_2 scripts\sp\anim::_id_1EC3(self, "airlock_close");
  }

  wait 0.05;
  self notify("door_action_finished");

  if(var_1) {
    return;
  }
  self waittill("door_action");

  if(var_0) {
    var_2 scripts\sp\anim::_id_1F35(self, "airlock_open");
    self notify("door_action_finished");
  } else {
    var_2 scripts\sp\anim::_id_1F35(self, "airlock_close");
    self notify("door_action_finished");
  }

  return;
}

_id_A5D8() {
  level endon("fin_stop_night_cleanup");

  for(;;) {
    if(isDefined(level._id_10AC8)) {
      break;
    }

    wait 0.05;
  }

  foreach(var_1 in level._id_10AC8) {
    var_1._id_E610 = var_1.accuracy;
  }

  for(;;) {
    scripts\engine\utility::flag_wait("power_on");

    foreach(var_1 in level._id_10AC8) {
      var_1.accuracy = var_1._id_E610;
      var_1 notify("stop_cleanup");
    }

    scripts\engine\utility::flag_waitopen("power_on");

    foreach(var_1 in level._id_10AC8) {
      var_1 thread _id_FE74();
      var_1.accuracy = 0.8;
    }
  }
}

_id_FE74() {
  self endon("stop_cleanup");
  level endon("fin_stop_night_cleanup");

  while(level._id_649C.size > 0) {
    scripts\engine\utility::flag_wait("night_kill");
    var_0 = scripts\sp\utility::_id_78AA(self.origin, "axis");

    for(;;) {
      if(isalive(var_0) && self canshoot(var_0 gettagorigin("tag_eye"))) {
        break;
      } else
        var_0 = scripts\sp\utility::_id_78AA(self.origin, "axis");

      wait 0.25;
    }

    for(var_1 = 0; var_1 < randomintrange(2, 5); var_1++) {
      if(!isalive(var_0)) {
        break;
      }

      self shoot(1, var_0 gettagorigin("tag_eye"));
      wait(randomfloatrange(0.25, 0.75));
    }

    if(isalive(var_0)) {
      var_0 _meth_81D0();
    }

    wait 1;
  }
}

_id_4A9B() {
  var_0 = getEntArray("ai_crouch_trigger", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _id_192D();
  }
}

_id_192D() {
  for(;;) {
    self waittill("trigger", var_0);

    if(!isai(var_0) || isDefined(var_0._id_7269)) {
      continue;
    }
    var_0._id_7269 = 1;
    var_0 allowedstances("crouch");
    var_0 thread _id_192E(self);
  }
}

_id_192E(var_0) {
  self endon("death");

  while(self istouching(var_0)) {
    wait 0.05;
  }

  self allowedstances("stand", "crouch", "prone");
  self._id_7269 = undefined;
}

is_ent_or_struct(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_3 == var_1) {
      return 1;
    }
  }

  return 0;
}

_id_75D5(var_0) {
  setsaveddvar("bg_cinematicFullScreen", "0");
  cinematicingameloopresident(var_0, 1);
}

_id_75D6() {
  stopcinematicingame();
}

_id_7457(var_0) {
  if(scripts\sp\utility::_id_7951(level.player.origin, level.player.angles, var_0.origin) >= 0.2) {
    return 1;
  } else {
    return 0;
  }
}

_id_F8B1() {
  var_0 = getEntArray("airlock_door_collision", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _id_246E();
  }
}

_id_246E() {
  var_0 = scripts\engine\utility::get_target_ent();
  self linkTo(var_0, "door_jnt");
  thread _id_2631(var_0);
  var_0 waittill("trigger");
  self connectpaths();
}

_id_2631(var_0) {
  while(!isDefined(var_0._id_BFFC)) {
    var_0 waittill("door_action");
    self connectpaths();
    var_0 waittill("door_action_finished");
    wait 0.05;
    self disconnectPaths();
  }
}

_id_F9D4(var_0, var_1, var_2) {
  var_3 = [];

  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_3[var_4] = ::scripts\sp\utility::_id_10639(var_0);
    var_3[var_4] attach(var_2, "j_spine4");
  }

  return var_3;
}

_id_E64A(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = level.player;
  var_7 = 0;

  if(!isDefined(var_4)) {
    var_4 = level._id_10AC8;
  }

  foreach(var_9 in var_4) {
    switch (var_9._id_1FBB) {
      case "xo":
        if(!isDefined(var_1)) {
          break;
        }

        if(!isDefined(var_5)) {
          var_9 thread scripts\sp\utility::_id_61F0(var_1);
        } else {
          var_9 thread _id_E649(var_1, var_6, var_5);
        }

        break;
      case "MCO":
        if(!isDefined(var_0)) {
          break;
        }

        if(!isDefined(var_5)) {
          var_9 thread scripts\sp\utility::_id_61F0(var_0);
        } else {
          var_9 thread _id_E649(var_0, var_6, var_5);
        }

        break;
      case "marine2":
        if(!isDefined(var_2)) {
          break;
        }

        if(!isDefined(var_5)) {
          var_9 thread scripts\sp\utility::_id_61F0(var_2);
        } else {
          var_9 thread _id_E649(var_2, var_6, var_5);
        }

        break;
      case "marine1":
        if(!isDefined(var_3)) {
          break;
        }

        if(!isDefined(var_5)) {
          var_9 thread scripts\sp\utility::_id_61F0(var_3);
        } else {
          var_9 thread _id_E649(var_3, var_6, var_5);
        }

        break;
      default:
        break;
    }

    var_6 = var_9;
  }
}

_id_E649(var_0, var_1, var_2) {
  self notify("disable_dynamic_move");
  self endon("disable_dynamic_move");
  var_3 = var_0;
  self._id_51E4 = undefined;
  scripts\sp\utility::_id_4145();
  _id_0B27::_id_F491("sprint_loop", "sprint_super");

  if(!isDefined(var_1)) {
    var_1 = level.player;
  }

  for(;;) {
    var_4 = distance2d(var_1.origin, var_2);
    var_5 = distance2d(self.origin, var_2);
    var_0 = distance2d(var_1.origin, self.origin);

    if(var_0 > var_3 && var_5 < var_4) {
      scripts\sp\utility::_id_4145();
      thread scripts\sp\utility::_id_F492(0.8);
    } else if(var_0 < var_3 && var_5 < var_4) {
      scripts\sp\utility::_id_51E1("sprint");
      thread scripts\sp\utility::_id_F492(1.2);
    } else if(var_0 < var_3 && var_5 > var_4) {
      scripts\sp\utility::_id_51E1("sprint");
      thread scripts\sp\utility::_id_F492(1.2);
    } else if(var_0 > var_3 && var_5 > var_4) {
      scripts\sp\utility::_id_51E1("sprint");
      thread scripts\sp\utility::_id_F492(1.2);
    } else {
      scripts\sp\utility::_id_4145();
      thread scripts\sp\utility::_id_F492(1);
    }

    wait 0.05;
  }
}

_id_782C() {
  var_0 = getEntArray("generic_door", "script_noteworthy");
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(var_3.script_parameters == "armory") {
      var_3.node = var_3 scripts\sp\utility::_id_7A97();
      return var_3;
    }
  }
}

_id_C855() {
  var_0 = spawnStruct();
  var_0._id_2274 = [];
  var_0._id_2274[0] = ["asteroid_anc_remembertocheckthe_c", "asteroid_anc_remembertocheckthe_r", 0];
  var_0._id_2274[1] = ["asteroid_anc_useextraprecautionaround_c", "asteroid_anc_useextraprecautionaround_r", 0];
  var_0._id_2274[2] = ["asteroid_anc_firstshifthasended_c", "asteroid_anc_firstshifthasended_r", 0];
  var_0._id_2274[3] = ["asteroid_anc_depressurizationdetectedin_c", "asteroid_anc_depressurizationdetectedin_r", 0];
  var_0._id_2274[4] = ["asteroid_anc_asteroiddestabilizationdetected_c", "asteroid_anc_asteroiddestabilizationdetected_r", 0];
  var_0._id_2274[5] = ["asteroid_anc_emergencybeaconactivated_c", "asteroid_anc_emergencybeaconactivated_r", 0];
  var_1 = getEntArray("rogue_pa_speaker", "script_noteworthy");
  thread _id_C857();

  for(;;) {
    while(scripts\engine\utility::flag("pa_active")) {
      scripts\engine\utility::flag_wait("power_on");
      var_2 = _id_6CA7(var_0);
      _id_CDBA(var_0, var_1, var_2);
      wait(randomfloatrange(2, 9));
    }

    wait 0.1;
  }
}

_id_6CA7(var_0) {
  var_1 = [];

  foreach(var_3 in var_0._id_2274) {
    if(var_3[2] == 0) {
      var_1[var_1.size] = var_3;
    }
  }

  if(var_1.size == 0) {
    foreach(var_3 in var_0._id_2274) {
      var_3[2] = 0;
    }

    var_1 = var_0._id_2274;
  }

  var_7 = var_1[randomintrange(0, var_1.size)];

  for(var_8 = 0; var_8 < var_0._id_2274.size; var_8++) {
    if(var_0._id_2274[var_8][0] == var_7[0]) {
      return var_8;
    }
  }
}

_id_C857() {
  for(;;) {
    scripts\engine\utility::flag_wait("pa_active");
    scripts\engine\utility::flag_waitopen("pa_active");
    level notify("stop_pa_queue");
  }
}

_id_CDBA(var_0, var_1, var_2) {
  level endon("stop_pa_queue");
  wait(randomfloatrange(2, 9));
  var_3 = _id_6C7C(var_1);
  thread _id_135F3(var_3);
  var_0._id_2274[var_2][2] = 1;
  _id_CE3C(var_0._id_2274[var_2], var_3);
}

_id_6C7C(var_0) {
  var_1 = scripts\engine\utility::array_sort_with_func(var_0, ::_id_56FC);
  var_2 = [var_1[0], var_1[1], var_1[2]];
  return var_2;
}

_id_56FC(var_0, var_1) {
  return distance(level.player.origin, var_0.origin) < distance(level.player.origin, var_1.origin);
}

_id_135F3(var_0) {
  scripts\engine\utility::flag_waitopen("power_on");
  wait 0.1;

  foreach(var_2 in var_0) {
    var_2 _meth_8277(0.3, 1);
    var_2 _meth_8278(0.75, 1);
    wait 1;
    var_2 stopsounds();
    wait 0.1;
    var_2 _meth_8277(1, 0.1);
    var_2 _meth_8278(1, 0.1);
  }
}

_id_CE3C(var_0, var_1) {
  foreach(var_3 in var_1) {
    var_3 thread _id_CDBB(var_0);
  }

  var_1[0] waittill("done_with_PA");
}

_id_CDBB(var_0) {
  if(distance(level.player.origin, self.origin) >= 1024) {
    self playSound(var_0[1], "done_with_PA");
  } else {
    self playSound(var_0[0], "done_with_PA");
  }
}

_id_12E2F(var_0, var_1) {
  foreach(var_3 in level._id_10AC8) {
    if(!isDefined(var_3._id_1FBD)) {
      var_3._id_1FBD = spawnStruct();
    }

    var_3._id_1FBD.origin = var_0.origin;

    if(isDefined(var_1)) {
      var_3._id_1FBD.angles = var_1;
      continue;
    }

    var_3._id_1FBD.angles = var_0.angles;
  }
}

_id_DB2E(var_0, var_1, var_2, var_3, var_4, var_5) {
  level.player _meth_84FE();
  level.player freezecontrols(1);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player disableweapons();
  level.player _meth_823C(var_0, "tag_player", var_1, 0, 0);
  wait(var_1);
  level.player playerlinktodelta(var_0, "tag_player", 1, var_2, var_3, var_4, var_5, 1);
  scripts\engine\utility::flag_set("player_in_scene");
  var_0 show();
}

_id_DAE1(var_0, var_1) {
  level.player _meth_84FD();
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  var_0 delete();

  if(isDefined(var_1)) {
    _id_0E4B::_id_8DEA();
    wait(var_1);
    _id_0E4B::_id_8E0A();
  }

  level.player enableweapons();
  scripts\engine\utility::flag_clear("player_in_scene");
}

_id_1101C() {
  if(isDefined(self._id_B14F) && self._id_B14F) {
    scripts\sp\utility::_id_1101B();
  }
}

_id_C152(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3)) {
    var_3 = _id_2289(var_3);

    if(isDefined(var_4)) {
      var_4 = _id_2289(var_4);
    }

    for(var_5 = 0; var_5 < var_3.size; var_5++) {
      if(isDefined(var_4)) {
        var_4[var_5] endon(var_3[var_5]);
        continue;
      }

      self endon(var_3[var_5]);
    }
  }

  if(!isDefined(var_2)) {
    var_2 = [];
  } else {
    var_2 = _id_2289(var_2);
  }

  self waittill(var_0);

  switch (var_2.size) {
    case 0:
      self[[var_1]]();
      break;
    case 1:
      self[[var_1]](var_2[0]);
      break;
    case 2:
      self[[var_1]](var_2[0], var_2[1]);
      break;
    case 3:
      self[[var_1]](var_2[0], var_2[1], var_2[2]);
      break;
    case 4:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3]);
      break;
    case 5:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
      break;
    case 6:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5]);
      break;
    case 7:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6]);
      break;
    case 8:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6], var_2[7]);
      break;
    default:
  }
}

_id_118E2(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3)) {
    var_3 = _id_2289(var_3);

    if(isDefined(var_4)) {
      var_4 = _id_2289(var_4);
    }

    for(var_5 = 0; var_5 < var_3.size; var_5++) {
      if(isDefined(var_4)) {
        var_4[var_5] endon(var_3[var_5]);
        continue;
      }

      self endon(var_3[var_5]);
    }
  }

  if(!isDefined(var_2)) {
    var_2 = [];
  } else {
    var_2 = _id_2289(var_2);
  }

  wait(var_0);

  switch (var_2.size) {
    case 0:
      self[[var_1]]();
      break;
    case 1:
      self[[var_1]](var_2[0]);
      break;
    case 2:
      self[[var_1]](var_2[0], var_2[1]);
      break;
    case 3:
      self[[var_1]](var_2[0], var_2[1], var_2[2]);
      break;
    case 4:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3]);
      break;
    case 5:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
      break;
    case 6:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5]);
      break;
    case 7:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6]);
      break;
    case 8:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6], var_2[7]);
      break;
    default:
  }
}

_id_65E5(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3)) {
    var_3 = _id_2289(var_3);

    if(isDefined(var_4)) {
      var_4 = _id_2289(var_4);
    }

    for(var_5 = 0; var_5 < var_3.size; var_5++) {
      if(isDefined(var_4)) {
        var_4[var_5] endon(var_3[var_5]);
        continue;
      }

      self endon(var_3[var_5]);
    }
  }

  if(!isDefined(var_2)) {
    var_2 = [];
  } else {
    var_2 = _id_2289(var_2);
  }

  scripts\sp\utility::_id_65E3(var_0);

  switch (var_2.size) {
    case 0:
      self[[var_1]]();
      break;
    case 1:
      self[[var_1]](var_2[0]);
      break;
    case 2:
      self[[var_1]](var_2[0], var_2[1]);
      break;
    case 3:
      self[[var_1]](var_2[0], var_2[1], var_2[2]);
      break;
    case 4:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3]);
      break;
    case 5:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
      break;
    case 6:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5]);
      break;
    case 7:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6]);
      break;
    case 8:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6], var_2[7]);
      break;
    default:
  }
}

_id_6E55(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_3)) {
    var_3 = _id_2289(var_3);

    if(isDefined(var_4)) {
      var_4 = _id_2289(var_4);
    }

    for(var_6 = 0; var_6 < var_3.size; var_6++) {
      if(isDefined(var_4)) {
        var_4[var_6] endon(var_3[var_6]);
        continue;
      }

      self endon(var_3[var_6]);
    }
  }

  if(!isDefined(var_2)) {
    var_2 = [];
  } else {
    var_2 = _id_2289(var_2);
  }

  if(isDefined(var_5) && var_5) {
    var_7 = scripts\sp\utility::_id_7E9C(var_0);

    for(;;) {
      level waittill(var_0, var_8);

      if(var_8 == self) {
        break;
      }
    }

    scripts\engine\utility::flag_set(var_0);
  }

  scripts\engine\utility::flag_wait(var_0);

  switch (var_2.size) {
    case 0:
      self[[var_1]]();
      break;
    case 1:
      self[[var_1]](var_2[0]);
      break;
    case 2:
      self[[var_1]](var_2[0], var_2[1]);
      break;
    case 3:
      self[[var_1]](var_2[0], var_2[1], var_2[2]);
      break;
    case 4:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3]);
      break;
    case 5:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
      break;
    case 6:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5]);
      break;
    case 7:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6]);
      break;
    case 8:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6], var_2[7]);
      break;
    default:
  }
}

_id_6E56(var_0, var_1, var_2, var_3, var_4) {
  _id_6E55(var_0, var_1, var_2, var_3, var_4, 1);
}

flag_waitopen_any(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_3)) {
    var_3 = _id_2289(var_3);

    if(isDefined(var_4)) {
      var_4 = _id_2289(var_4);
    }

    for(var_6 = 0; var_6 < var_3.size; var_6++) {
      if(isDefined(var_4)) {
        var_4[var_6] endon(var_3[var_6]);
        continue;
      }

      self endon(var_3[var_6]);
    }
  }

  if(!isDefined(var_2)) {
    var_2 = [];
  } else {
    var_2 = _id_2289(var_2);
  }

  if(isDefined(var_5) && var_5) {
    var_7 = scripts\sp\utility::_id_7E9C(var_0);

    for(;;) {
      level waittill(var_0, var_8);

      if(var_8 == self) {
        break;
      }
    }

    scripts\engine\utility::flag_set(var_0);
  }

  scripts\engine\utility::flag_waitopen(var_0);

  switch (var_2.size) {
    case 0:
      self[[var_1]]();
      break;
    case 1:
      self[[var_1]](var_2[0]);
      break;
    case 2:
      self[[var_1]](var_2[0], var_2[1]);
      break;
    case 3:
      self[[var_1]](var_2[0], var_2[1], var_2[2]);
      break;
    case 4:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3]);
      break;
    case 5:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
      break;
    case 6:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5]);
      break;
    case 7:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6]);
      break;
    case 8:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6], var_2[7]);
      break;
    default:
  }
}

_id_2289(var_0) {
  return scripts\engine\utility::ter_op(isarray(var_0), var_0, [var_0]);
}

_id_D1D8() {}

_id_D05E() {
  self endon("stop_localized_effects");

  for(;;) {
    scripts\engine\utility::flag_wait("player_is_outside");

    while(scripts\engine\utility::flag("player_is_outside")) {
      if(scripts\engine\utility::flag("power_on")) {
        playFXOnTag(level._effect["day_wind_player"], self, "tag_origin");
      } else {
        playFXOnTag(level._effect["night_wind_player"], self, "tag_origin");
      }

      wait 0.2;
    }
  }
}

_id_83D7() {
  if(scripts\engine\utility::flag("power_on")) {
    for(;;) {
      _id_4D9E();
      scripts\engine\utility::flag_waitopen("power_on");
      _id_BFCE();
      scripts\engine\utility::flag_wait("power_on");
    }
  } else {
    for(;;) {
      _id_BFCE();
      scripts\engine\utility::flag_wait("power_on");
      _id_4D9E();
      scripts\engine\utility::flag_waitopen("power_on");
    }
  }
}

_id_4D9E(var_0) {
  switch (var_0) {
    case "defend":
      break;
    default:
      break;
  }
}

_id_BFCE() {}

_id_13D27() {
  for(;;) {
    if(scripts\engine\utility::flag("power_on")) {
      if(scripts\engine\utility::flag("player_is_outside")) {
        _id_1104D("101", "200", "201");
        scripts\engine\utility::exploder("100");
      } else {
        _id_1104D("101", "100", "201");
        scripts\engine\utility::exploder("200");
      }
    } else if(scripts\engine\utility::flag("player_is_outside")) {
      _id_1104D("100", "200", "201");
      scripts\engine\utility::exploder("101");
    } else {
      _id_1104D("101", "200", "100");
      scripts\engine\utility::exploder("201");
    }

    level scripts\engine\utility::waittill_any("power_on", "player_is_outside");
  }
}

_id_1104D(var_0, var_1, var_2) {
  scripts\sp\utility::_id_10FEC(var_0);
  waittillframeend;
  scripts\sp\utility::_id_10FEC(var_1);
  waittillframeend;
  scripts\sp\utility::_id_10FEC(var_2);
  waittillframeend;
}

_id_D726() {
  scripts\engine\utility::flag_init("rogue_scriptables_ready");
  scripts\engine\scriptable::_id_EF33(::_id_847C);
  level._id_13C6 = ["hangar", "run1", "solararray", "run2", "dorm", "shippinghall", "shippingdefend", "controlroom", "depot", "finale"];
  level._id_1158 = [];
  level._id_11CB = spawnStruct();
  level._id_11CB._id_9B0A = [];
  level._id_11CB._id_ACD2 = [];
  level._id_1305 = [];
  level._id_13C2 = [];

  foreach(var_1 in level._id_13C6) {
    level._id_1305[var_1] = spawnStruct();
    level._id_1305[var_1]._id_10DCC = "light_" + var_1 + "_on";
    level._id_1305[var_1]._id_11081 = "light_" + var_1 + "_off";
    level._id_1305[var_1].lights = [];
    level._id_13C2[var_1] = [];
  }

  scripts\engine\utility::flag_wait("rogue_scriptables_ready");
  _id_847B("light_omni");
  _id_847B("light_spot");
  _id_847D();

  for(;;) {
    scripts\engine\utility::flag_wait("power_on");

    foreach(var_4 in level._id_1158) {
      _id_F0D0(var_4);
    }

    scripts\engine\utility::flag_waitopen("power_on");

    foreach(var_4 in level._id_1158) {
      if(var_4 != "controlroom") {
        _id_F0CF(var_4);
      }
    }
  }
}

_id_F0D0(var_0) {
  if(isDefined(level._id_1305[var_0])) {
    level notify(level._id_1305[var_0]._id_10DCC);
  } else {}

  foreach(var_2 in level._id_13C2[var_0]) {
    if(!isDefined(var_2._id_9BB1) && isDefined(var_2.part)) {
      var_2 setscriptablepartstate(var_2.part, "on");
    }
  }
}

_id_F0CF(var_0) {
  if(isDefined(level._id_1305[var_0])) {
    level notify(level._id_1305[var_0]._id_11081);
  } else {}

  foreach(var_2 in level._id_13C2[var_0]) {
    if(!isDefined(var_2._id_9BB1) && isDefined(var_2.part)) {
      var_2 setscriptablepartstate(var_2.part, "off");
    }
  }
}

_id_1730(var_0) {
  level._id_1158 = scripts\engine\utility::array_add(level._id_1158, var_0);

  if(scripts\engine\utility::flag("power_on")) {
    _id_F0D0(var_0);
  }
}

_id_E078(var_0, var_1) {
  level._id_1158 = scripts\engine\utility::array_remove(level._id_1158, var_0);
  _id_F0CF(var_0);

  if(!isDefined(var_1) || !var_1) {
    level notify(level._id_1305[var_0]._id_11081);

    foreach(var_3 in level._id_1305[var_0].lights) {
      var_3 scripts\engine\utility::delaycall(0.05, ::delete);
    }
  }
}

_id_847C() {
  scripts\engine\utility::waitframe();

  foreach(var_1 in level._id_13C6) {
    level._id_13C2[var_1] = getscriptablearray("scriptable_" + var_1, "script_noteworthy");

    foreach(var_3 in level._id_13C2[var_1]) {
      var_3 thread _id_EF2A();
      var_3.part = _id_7C32(var_3);
    }
  }

  level._id_6C41 = getscriptablearray("finale_fuel_tank", "targetname");
  level._id_6C4E = getscriptablearray("finale_fuel_tank_run", "targetname");
  scripts\engine\utility::flag_set("rogue_scriptables_ready");
}

_id_7C32(var_0) {
  var_1 = undefined;

  switch (var_0.model) {
    case "electrical_monitor_screen_plane_3":
    case "electrical_monitor_screen_plane_2":
    case "electrical_monitor_screen_plane_1":
    case "curved_screen_television_01":
    case "equipment_computer_screen_02_on":
      var_1 = "screen";
      break;
    case "misc_coffee_machine":
      var_1 = "coffee_machine";
      break;
    default:
      var_1 = "onoff";
  }

  return var_1;
}

_id_EF2A(var_0) {
  self endon("entitydeleted");
  self waittill("death");
  self._id_9BB1 = 1;

  if(isDefined(var_0)) {
    var_1 = var_0._id_F0C9;

    if(isDefined(var_0._id_1021E)) {
      foreach(var_3 in var_0._id_1021E) {
        level._id_1305[var_1].lights = scripts\engine\utility::array_remove(level._id_1305[var_1].lights, var_3);
        var_3 notify("stop_flicker_loop");
        var_3 scripts\sp\lights::_id_ACA3(undefined, 1);
        var_3 scripts\engine\utility::delaycall(0.1, ::delete);
      }
    }

    level._id_1305[var_1].lights = scripts\engine\utility::array_remove(level._id_1305[var_1].lights, var_0);
    var_0 notify("stop_flicker_loop");
    var_0 scripts\sp\lights::_id_ACA3(undefined, 1);
    var_0 scripts\engine\utility::delaycall(0.1, ::delete);
  }
}

_id_EF28() {
  scripts\engine\utility::array_thread(self._id_EF3C, ::_id_EF2A, self);
  self endon("death");

  for(;;) {
    scripts\sp\utility::_id_65E3("light_on");

    foreach(var_1 in self._id_EF3C) {
      if(!isDefined(var_1._id_9BB1) && isDefined(var_1.part)) {
        var_1 setscriptablepartstate(var_1.part, "on");
      }
    }

    scripts\sp\utility::_id_65E8("light_on");

    foreach(var_1 in self._id_EF3C) {
      if(!isDefined(var_1._id_9BB1) && isDefined(var_1.part)) {
        var_1 setscriptablepartstate(var_1.part, "off");
      }
    }
  }
}

_id_847B(var_0) {
  foreach(var_2 in getEntArray(var_0, "classname")) {
    if(isDefined(var_2._id_EDFF) || isDefined(var_2._id_EE00)) {
      var_3 = undefined;
      var_4 = undefined;

      if(!isDefined(var_2._id_EDFF) || !isDefined(var_2._id_EE00)) {
        level._id_11CB._id_9B0A[level._id_11CB._id_9B0A.size] = var_2;
        continue;
      }

      var_5 = tolower(var_2._id_EDFF);
      var_6 = strtok(var_5, "_");

      if(var_6[0] == "int" || var_6[0] == "ext") {
        continue;
      }
      if(var_6.size != 3 || var_6[2] != "on") {
        level._id_11CB._id_9B0A[level._id_11CB._id_9B0A.size] = var_2;
        continue;
      }

      if(isDefined(var_6[0]) && var_6[0] == "light") {
        var_3 = var_6[1];
      }

      var_7 = tolower(var_2._id_EE00);
      var_8 = strtok(var_7, "_");

      if(var_8.size != 3 || var_8[2] != "off") {
        level._id_11CB._id_9B0A[level._id_11CB._id_9B0A.size] = var_2;
        continue;
      }

      if(isDefined(var_8[0]) && var_8[0] == "light") {
        var_4 = var_8[1];
      }

      if(!isDefined(var_3) || !isDefined(var_4)) {
        level._id_11CB._id_9B0A[level._id_11CB._id_9B0A.size] = var_2;
        continue;
      }

      if(var_3 != var_4) {
        level._id_11CB._id_9B0A[level._id_11CB._id_9B0A.size] = var_2;
        continue;
      }

      if(!isDefined(level._id_1305[var_3])) {
        level._id_11CB._id_9B0A[level._id_11CB._id_9B0A.size] = var_2;
        continue;
      }

      if(isDefined(var_2.target)) {
        var_2._id_EF3C = getscriptablearray(var_2.target, "targetname");

        if(var_2._id_EF3C.size > 0) {
          foreach(var_10 in var_2._id_EF3C) {
            var_10.part = _id_7C32(var_10);
          }

          var_2 thread _id_EF28();
        }

        if(var_2._id_EF3C.size > 0) {
          if(!isDefined(level._id_11CB._id_ACD2[var_3])) {
            level._id_11CB._id_ACD2[var_3] = [];
          }

          level._id_11CB._id_ACD2[var_3][var_2.target] = var_2;
        }
      }

      var_2._id_F0C9 = var_3;
      level._id_1305[var_3].lights[level._id_1305[var_3].lights.size] = var_2;
    }
  }
}

_id_847D() {
  foreach(var_11, var_1 in level._id_1305) {
    for(var_2 = 0; var_2 < var_1.lights.size; var_2++) {
      if(var_1.lights[var_2]._id_EF3C.size > 0) {
        foreach(var_4 in var_1.lights[var_2]._id_EF3C) {
          var_5 = scripts\engine\utility::getStruct(var_1.lights[var_2].target, "targetname");

          if(isDefined(var_5) && isDefined(var_5.radius)) {
            var_1.lights[var_2]._id_1021E = [];
            var_6 = squared(var_5.radius);

            foreach(var_8 in level._id_1305[var_11].lights) {
              if(var_8 != var_1.lights[var_2] && distancesquared(var_8.origin, var_5.origin) <= var_6) {
                var_1.lights[var_2]._id_1021E[var_1.lights[var_2]._id_1021E.size] = var_8;
              }
            }
          }
        }
      }
    }
  }
}

_id_59C8(var_0, var_1, var_2) {
  while(_id_0B1E::_id_794C(var_0) <= var_1) {
    wait 0.05;
  }

  scripts\engine\utility::exploder(var_2);
}

_id_12984() {
  if(!isDefined(self._id_9067)) {
    return;
  }
  self._id_9067 setlightintensity(self._id_9067._id_C4BC);
  self._id_9067.state = "on";
}

_id_12958() {
  if(!isDefined(self._id_9067)) {
    return;
  }
  self._id_9067 setlightintensity(0);
  self._id_9067.state = "off";
}

_id_F99A() {
  if(isDefined(self._id_9067)) {
    return;
  }
  switch (self._id_EDB8) {
    case "Salter":
      self._id_9067 = getEnt("xo_light", "targetname");
      self._id_9067.origin = self gettagorigin("tag_helmetlight");
      self._id_9067.angles = self gettagangles("tag_helmetlight") + (68, 180, 0);
      break;
    case "Omar":
      self._id_9067 = getEnt("mco_light", "targetname");
      self._id_9067.origin = self gettagorigin("tag_helmetlight");
      self._id_9067.angles = self gettagangles("tag_helmetlight") + (68, 180, 0);
      break;
    case "Kashima":
      self._id_9067 = getEnt("kashima_light", "targetname");
      self._id_9067.origin = self gettagorigin("tag_helmetlight");
      self._id_9067.angles = self gettagangles("tag_helmetlight") + (68, 180, 0);
      break;
    case "Brooks":
      self._id_9067 = getEnt("brooks_light", "targetname");
      self._id_9067.origin = self gettagorigin("tag_helmetlight");
      self._id_9067.angles = self gettagangles("tag_helmetlight") + (68, 180, 0);
      break;
    case "MCO":
      self._id_9067 = getEnt("mco_light", "targetname");
      self._id_9067.origin = self gettagorigin("tag_helmetlight");
      self._id_9067.angles = self gettagangles("tag_helmetlight") + (68, 180, 0);
      break;
    default:
      break;
  }

  if(!isDefined(self._id_9067._id_C4BC)) {
    self._id_9067._id_C4BC = self._id_9067 _meth_8134();
  }

  self._id_9067 linkTo(self, "tag_helmetlight");
  self._id_9067 setlightintensity(0);
}

_id_1E94(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 notify("stop_anim_ai");
  var_0 endon("stop_anim_ai");
  var_0 endon("death");
  self endon("death");

  if(isDefined(var_4)) {
    self endon(var_4);
  }

  if(!isDefined(var_5)) {
    var_5 = "stop_loop";
  }

  if(isDefined(var_0._id_1EEF)) {
    var_0._id_1EEF notify("stop_loop");
    var_0._id_1EEF delete();
  }

  var_0 notify("stop_loop");
  var_0._id_1EEF = scripts\engine\utility::spawn_tag_origin();

  if(!isstruct(self) && !isai(self)) {
    var_0._id_1EEF linkTo(self);
  }

  var_0 linkTo(var_0._id_1EEF);

  if(isDefined(var_1)) {
    var_1 = _id_2289(var_1);

    foreach(var_8 in var_1) {
      var_0 notify(var_8 + "_start");
      var_0._id_1EEF notify(var_8 + "_start");
      var_0._id_1EEF scripts\sp\anim::_id_1F35(var_0, var_8);
    }
  }

  if(isDefined(var_2)) {
    var_0 notify(var_2 + "_start");
    var_0._id_1EEF notify(var_2 + "_start");
    thread _id_1E99(var_0, var_5);
    var_0._id_1EEF thread scripts\sp\anim::_id_1EEA(var_0, var_2, var_5);
    scripts\engine\utility::waittill_any_ents(var_0._id_1EEF, "stop_loop", var_0, "stop_loop");
    var_0._id_1EEF notify("stop_loop");
  }

  if(isDefined(var_3)) {
    var_3 = _id_2289(var_3);

    foreach(var_8 in var_3) {
      var_0 notify(var_8 + "_start");
      var_0._id_1EEF notify(var_8 + "_start");
      var_0._id_1EEF scripts\sp\anim::_id_1F35(var_0, var_8);
    }
  }

  var_0 _id_1E95();

  if(isDefined(var_6)) {
    var_0[[var_6]]();
  }
}

_id_1E99(var_0, var_1) {
  var_0 endon("stop_anim_ai");
  var_0 endon("death");
  self endon("death");
  self waittill(var_1);

  if(!isDefined(var_0._id_1EEF)) {
    return;
  }
  var_0._id_1EEF notify(var_1);
}

_id_1E95() {
  self unlink();

  if(isDefined(self._id_1EEF)) {
    self._id_1EEF delete();
  }
}

_id_1EFA(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(level.player._id_E505)) {
    level.player._id_E505 hide();
  }

  if(isDefined(level.player._id_1EEF)) {
    level.player._id_1EEF delete();
  }

  level.player._id_1EEF = scripts\engine\utility::spawn_tag_origin();
  level.player._id_1EEF linkTo(self);

  if(!isDefined(level.player._id_E505)) {
    level.player._id_E505 = scripts\sp\utility::_id_10639("player_rig");
  }

  level.player._id_E505 hide();
  level.player._id_1EEF scripts\sp\anim::_id_1EC3(level.player._id_E505, var_0);
  scripts\engine\utility::flag_set("player_in_scene");
  level.player disableweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player _meth_84FE();

  if(isDefined(var_2)) {
    level.player _meth_823C(level.player._id_E505, "tag_player", var_2);
    level.player scripts\engine\utility::delaycall(var_2, ::playerlinktodelta, level.player._id_E505, "tag_player", 1, 0, 0, 0, 0, 1);
  } else
    level.player playerlinktodelta(level.player._id_E505, "tag_player", 1, 0, 0, 0, 0, 1);

  if(isDefined(var_2)) {
    wait(var_2);
  }

  level.player._id_E505 show();

  if(isDefined(var_0)) {
    var_0 = _id_2289(var_0);

    foreach(var_8 in var_0) {
      level.player._id_1EEF scripts\sp\anim::_id_1F35(level.player._id_E505, var_8);
    }
  }

  if(isDefined(var_1)) {
    level.player._id_1EEF thread scripts\sp\anim::_id_1EEA(level.player._id_E505, var_1);
    level.player._id_1EEF waittill("stop_loop");
  }

  if(!isDefined(var_3) || !var_3) {
    if(!isDefined(var_5)) {
      _id_1EFB();
    } else {
      _id_1EFB(var_5, var_6);
    }
  }

  if(isDefined(var_4)) {
    level.player[[var_4]]();
  }

  scripts\engine\utility::flag_clear("player_in_scene");
}

_id_1EFB(var_0, var_1) {
  level.player unlink();

  if(!isDefined(var_0)) {
    level.player scripts\engine\utility::delaycall(0.05, ::enableweapons);
  } else {
    thread _id_9A8A(var_0, var_1);
  }

  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player _meth_84FD();

  if(isDefined(level.player._id_E505)) {
    level.player._id_E505 delete();
  }

  if(isDefined(level.player._id_1EEF)) {
    level.player._id_1EEF delete();
  }
}

_id_9A8A(var_0, var_1) {
  if(isDefined(var_1)) {
    level endon(var_1);
  } else {
    level endon("player_in_scene");
  }

  wait(var_0);
  level.player enableweapons();
}

_id_EBDD(var_0, var_1, var_2) {
  self endon("death");
  scripts\sp\utility::_id_65E0("power_on");
  thread _id_EBD6();
  thread _id_EBE8();
  thread _id_EBD7();
  thread _id_EBE7();

  if(!scripts\engine\utility::flag("power_on")) {
    thread _id_EBE1(var_0, var_2, 1);
  }

  for(;;) {
    scripts\engine\utility::flag_wait("power_on");
    childthread _id_EBE4(var_0, var_1);
    scripts\engine\utility::flag_wait("power_off");
    childthread _id_EBE1(var_0, var_2);
  }
}

_id_EBE1(var_0, var_1, var_2) {
  self endon("death");
  self notify("stop_scbt_power_scripted");
  self endon("stop_scbt_power_scripted");

  if(!isDefined(var_0)) {
    var_0 = [];
  }

  _id_EBD7();

  if(!scripts\sp\utility::_id_65DB("head_destroyed")) {
    childthread _id_EBD5(var_2);
  }

  if(isDefined(var_1)) {
    self thread[[var_1]]();
  }

  scripts\sp\utility::_id_65DD("power_on");
  thread scripts\sp\utility::_id_77B9(0.7);

  if(!isDefined(var_0["node"])) {
    var_0["node"] = self;
  }

  if(isDefined(var_0["off"])) {
    var_0["node"] notify("stop_loop");
    var_0["node"] scripts\sp\anim::_id_1F35(self, var_0["off"]);
  }

  if(isDefined(var_0["off_idle"])) {
    var_0["node"] thread scripts\sp\anim::_id_1EEA(self, var_0["off_idle"]);
  }
}

_id_EBE4(var_0, var_1, var_2) {
  self endon("death");
  self notify("stop_scbt_power_scripted");
  self endon("stop_scbt_power_scripted");

  if(!isDefined(var_0)) {
    var_0 = [];
  }

  _id_EBD7();

  if(!scripts\sp\utility::_id_65DB("head_destroyed")) {
    childthread _id_EBE6(var_2);
  }

  if(isDefined(var_1)) {
    self thread[[var_1]]();
  }

  var_3 = 0;

  if(isDefined(self._id_74D1)) {
    [[self._id_74D1]]();
  } else {
    wait(randomfloat(0.25));
    var_3 = randomfloatrange(1.5, 3.0);
  }

  wait(var_3);
  scripts\sp\utility::_id_65E1("power_on");

  if(!isDefined(var_0["node"])) {
    var_0["node"] = self;
  }

  if(isDefined(var_0["on"])) {
    var_0["node"] notify("stop_loop");
    var_0["node"] scripts\sp\anim::_id_1F35(self, var_0["on"]);
  }

  if(isDefined(var_0["on_idle"])) {
    var_0["node"] thread scripts\sp\anim::_id_1EEA(self, var_0["on_idle"]);
  }

  thread scripts\sp\utility::_id_7799(level.player);
}

_id_EBE7() {
  self endon("death");
  level endon("creep_vo_wait_5");
  self._id_9119 = 200;
  self._id_911C = 200;
  self._id_911A = 200;
  self._id_911D = 200;
  self.a.nodeath = 1;
  scripts\sp\utility::_id_65E0("head_destroyed");
  scripts\sp\utility::_id_65E0("arm_r_destroyed");
  scripts\sp\utility::_id_65E0("arm_l_destroyed");
  scripts\sp\utility::_id_65E0("leg_r_destroyed");
  scripts\sp\utility::_id_65E0("leg_l_destroyed");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    self.health = self.health + var_0;

    if(isDefined(var_5)) {
      if(issubstr(var_5, "head")) {
        _id_EBD7();
        _id_0A0B::_id_98C9("head");
        _id_0A0B::_id_F591("head", "dismember");
        self setscriptablepartstate("head", "dismember");
        scripts\sp\utility::_id_65E1("head_destroyed");
        continue;
      }

      if(issubstr(var_5, "arm_r")) {
        self._id_911C = self._id_911C - var_0;

        if(self._id_911C <= 0) {
          _id_0A0B::_id_98C9("right_arm");
          _id_0A0B::_id_F591("right_arm", "dismember");
          self setscriptablepartstate("right_arm", "dismember");
          scripts\sp\utility::_id_65E1("arm_r_destroyed");
        }

        continue;
      }

      if(issubstr(var_5, "arm_l")) {
        if(isDefined(self._id_BFF8)) {
          continue;
        }
        self._id_9119 = self._id_9119 - var_0;

        if(self._id_9119 <= 0) {
          _id_0A0B::_id_98C9("left_arm");
          _id_0A0B::_id_F591("left_arm", "dismember");
          self setscriptablepartstate("left_arm", "dismember");
          scripts\sp\utility::_id_65E1("arm_l_destroyed");
        }

        continue;
      }

      if(issubstr(var_5, "leg_r")) {
        self._id_911D = self._id_911D - var_0;

        if(self._id_911D <= 0) {
          _id_0A0B::_id_98C9("right_leg");
          _id_0A0B::_id_F591("right_leg", "dismember");
          self setscriptablepartstate("right_leg", "dismember");
          scripts\sp\utility::_id_65E1("leg_r_destroyed");
        }

        continue;
      }

      if(issubstr(var_5, "leg_l")) {
        self._id_911A = self._id_911A - var_0;

        if(self._id_911A <= 0) {
          _id_0A0B::_id_98C9("left_leg");
          _id_0A0B::_id_F591("left_leg", "dismember");
          self setscriptablepartstate("left_leg", "dismember");
          scripts\sp\utility::_id_65E1("leg_l_destroyed");
        }
      }
    }
  }
}

_id_59C6() {
  for(;;) {
    var_0 = level scripts\engine\utility::waittill_any_return("door_peek_blend_complete", "door_peek_finished", "buddydoor_player_intro", "buddydoor_player_done", "armory_door_start_open", "armory_door_open");

    switch (var_0) {
      case "door_intro_done":
        scripts\engine\utility::flag_set("player_in_scene");
        break;
      case "buddydoor_player_intro":
        scripts\engine\utility::flag_set("player_in_scene");
        break;
      case "armory_door_start_open":
        scripts\engine\utility::flag_set("player_in_scene");
        break;
      default:
        scripts\engine\utility::flag_clear("player_in_scene");
        break;
    }
  }
}

_id_1AC5(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "unknown";
  }

  if(var_0 == "red") {
    var_1 = getEntArray("airlock_beacon_light_green", "targetname");
    scripts\engine\utility::array_call(var_1, ::hide);
    var_1 = getEntArray("airlock_beacon_light_red", "targetname");
    scripts\engine\utility::array_call(var_1, ::show);
    var_2 = getEntArray("rogue_lights_airlock_green", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC86);
    var_2 = getEntArray("rogue_lights_airlock_green_2", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC86);
    var_2 = getEntArray("rogue_lights_airlock_red", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 15);
    var_2 = getEntArray("rogue_lights_airlock_red_2", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 4);
  } else if(var_0 == "instant_green") {
    var_1 = getEntArray("airlock_beacon_light_red", "targetname");
    scripts\engine\utility::array_call(var_1, ::hide);
    var_1 = getEntArray("airlock_beacon_light_green", "targetname");
    scripts\engine\utility::array_call(var_1, ::show);
    var_2 = getEntArray("rogue_lights_airlock_red", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC86);
    var_2 = getEntArray("rogue_lights_airlock_red_2", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC86);
    var_2 = getEntArray("rogue_lights_airlock_green", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 50);
    var_2 = getEntArray("rogue_lights_airlock_green_2", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 6);
  } else {
    var_1 = getEntArray("airlock_beacon_light_green", "targetname");
    scripts\engine\utility::array_call(var_1, ::hide);
    var_1 = getEntArray("airlock_beacon_light_red", "targetname");
    scripts\engine\utility::array_call(var_1, ::show);
    var_2 = getEntArray("rogue_lights_airlock_red", "targetname");
    var_3 = getEntArray("rogue_lights_airlock_red_2", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 15);
    scripts\engine\utility::array_thread(var_3, ::_id_AC87, 4);
    wait 0.5;
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 13.5);
    scripts\engine\utility::array_thread(var_3, ::_id_AC87, 3.5);
    wait 0.5;
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 11.5);
    scripts\engine\utility::array_thread(var_3, ::_id_AC87, 3);
    wait 0.5;
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 9.5);
    scripts\engine\utility::array_thread(var_3, ::_id_AC87, 2.5);
    wait 0.5;
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 7.5);
    scripts\engine\utility::array_thread(var_3, ::_id_AC87, 2);
    wait 0.5;
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 5.5);
    scripts\engine\utility::array_thread(var_3, ::_id_AC87, 1.5);
    wait 0.5;
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 3);
    scripts\engine\utility::array_thread(var_3, ::_id_AC87, 1);
    wait 0.5;
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 0.5);
    scripts\engine\utility::array_thread(var_3, ::_id_AC87, 0.5);
    wait 0.5;
    var_1 = getEntArray("airlock_beacon_light_red", "targetname");
    scripts\engine\utility::array_call(var_1, ::hide);
    var_1 = getEntArray("airlock_beacon_light_green", "targetname");
    scripts\engine\utility::array_call(var_1, ::show);
    var_2 = getEntArray("rogue_lights_airlock_red", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC86);
    var_2 = getEntArray("rogue_lights_airlock_red_2", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC86);
    var_2 = getEntArray("rogue_lights_airlock_green", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 50);
    var_2 = getEntArray("rogue_lights_airlock_green_2", "targetname");
    scripts\engine\utility::array_thread(var_2, ::_id_AC87, 6);
  }
}

_id_AC87(var_0) {
  _id_AC90(var_0, 0.5);
}

_id_AC86() {
  _id_AC90(0.0, 0.5);
}

_id_AC90(var_0, var_1) {
  var_2 = int(var_1 * 20);
  var_3 = self _meth_8134();
  var_4 = (var_0 - var_3) / var_2;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    thread _id_AC91(var_0);
    self setlightintensity(var_3 + var_5 * var_4);
    wait 0.05;
  }

  var_6[0] = self;

  if(isDefined(self._id_AD22)) {
    var_6 = scripts\engine\utility::array_combine(var_6, self._id_AD22);
  }

  foreach(var_8 in var_6) {
    var_8 thread _id_AC91(var_0);
    var_8 setlightintensity(var_0);
  }
}

_id_AC91(var_0) {
  if(!isDefined(self.script_threshold)) {
    return;
  }
  var_1 = var_0 > self.script_threshold;

  foreach(var_3 in self._id_AD83) {
    if(var_1 && !var_3._id_13438) {
      var_3._id_13438 = var_1;
      var_3 show();

      if(isDefined(var_3.effect)) {
        var_3.effect thread scripts\sp\utility::_id_E2B0();
      }

      continue;
    }

    if(!var_1 && var_3._id_13438) {
      var_3._id_13438 = var_1;
      var_3 hide();

      if(isDefined(var_3.effect)) {
        var_3.effect thread scripts\engine\utility::pauseeffect();
      }
    }
  }

  foreach(var_3 in self._id_12BB6) {
    if(!var_1 && !var_3._id_13438) {
      var_3._id_13438 = 1;
      var_3 show();
      continue;
    }

    if(var_1 && var_3._id_13438) {
      var_3._id_13438 = 0;
      var_3 hide();
    }
  }
}

_id_E643(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "hangar";
  }

  var_1 = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));

  while(istransientloaded("rogue_base_tr") == 0) {
    wait 0.05;
  }

  wait 1;

  switch (var_0) {
    case "hangar":
      _id_3794("HANGAR");
      wait 0.5;
      playFXOnTag(level._effect["vfx_ra_camcentr_hangar_calm"], var_1, "tag_origin");
      scripts\engine\utility::flag_wait("hangar_door_open");
    case "surface":
      _id_3794("SURFACE");
      killfxontag(level._effect["vfx_ra_camcentr_hangar_calm"], var_1, "tag_origin");
      wait 0.05;
      playFXOnTag(level._effect["vfx_ra_camcentr_outdoors1"], var_1, "tag_origin");
      level waittill("dorm_airlock_door_shut");
    case "dorms":
      _id_3794("DORMS");
      killfxontag(level._effect["vfx_ra_camcentr_outdoors1"], var_1, "tag_origin");
      wait 0.05;
      playFXOnTag(level._effect["vfx_ra_camcentr_crewqt_dusty"], var_1, "tag_origin");
      level waittill("creep_hall_airlockdoor_script_disabled");
    case "creep_hallway":
      _id_3794("CREEP HALL");
      killfxontag(level._effect["vfx_ra_camcentr_crewqt_dusty"], var_1, "tag_origin");
      wait 0.05;
      playFXOnTag(level._effect["vfx_ra_camcentr_creephallway"], var_1, "tag_origin");
      scripts\engine\utility::flag_wait("flag_lgt_shipping_start");
    case "shipping_hall":
      _id_3794("SHIPPING HALL");
      killfxontag(level._effect["vfx_ra_camcentr_creephallway"], var_1, "tag_origin");
      wait 0.05;
      playFXOnTag(level._effect["vfx_ra_camcentr_glassroofhallway"], var_1, "tag_origin");
      scripts\engine\utility::flag_wait("flag_defend_a_start");
    case "shipping_defend":
      _id_3794("SHIPPING");
      killfxontag(level._effect["vfx_ra_camcentr_glassroofhallway"], var_1, "tag_origin");
      wait 0.05;
      var_2 = getnode("allystart_defend_a_xo", "targetname");
      var_3 = spawn("trigger_radius", var_2.origin, 0, 215, 384);
      var_4 = "none";

      for(;;) {
        wait 0.25;

        if(!level.player istouching(var_3)) {
          if(var_4 == "none") {
            var_4 = "outdoor";
            playFXOnTag(level._effect["vfx_ra_camcentr_outdoors2"], var_1, "tag_origin");
          }
        } else if(var_4 == "outdoor") {
          var_4 = "none";
          killfxontag(level._effect["vfx_ra_camcentr_outdoors2"], var_1, "tag_origin");
        }

        if(scripts\engine\utility::flag("control_cam_effects_go")) {
          break;
        }
      }
    case "control_room":
      _id_3794("CONTROL ROOM");
      killfxontag(level._effect["vfx_ra_camcentr_outdoors2"], var_1, "tag_origin");
      wait 0.05;
      playFXOnTag(level._effect["vfx_ra_camcentr_coltrolcomplex"], var_1, "tag_origin");
      scripts\engine\utility::flag_wait("player_in_depot");
    case "depot":
      _id_3794("DEPOT");
      killfxontag(level._effect["vfx_ra_camcentr_coltrolcomplex"], var_1, "tag_origin");
      wait 0.05;
      playFXOnTag(level._effect["vfx_ra_camcentr_lavahallway"], var_1, "tag_origin");
      var_5 = "depot";
      thread _id_10941();

      while(!scripts\engine\utility::flag("stop_depot_cam_fx")) {
        if(scripts\engine\utility::flag("player_in_depot_pit")) {
          if(var_5 == "depot") {
            killfxontag(level._effect["vfx_ra_camcentr_lavahallway"], var_1, "tag_origin");
            wait 0.05;
            playFXOnTag(level._effect["vfx_ra_camcentr_lavacatwalk"], var_1, "tag_origin");
            var_5 = "pit";
          }
        } else if(var_5 == "pit") {
          killfxontag(level._effect["vfx_ra_camcentr_lavacatwalk"], var_1, "tag_origin");
          wait 0.05;
          playFXOnTag(level._effect["vfx_ra_camcentr_lavahallway"], var_1, "tag_origin");
          var_5 = "depot";
        }

        wait 0.1;
      }
    case "civilians":
      _id_3794("CIVILIANS");
      killfxontag(level._effect["vfx_ra_camcentr_lavahallway"], var_1, "tag_origin");
      wait 0.05;
      playFXOnTag(level._effect["vfx_ra_camcentr_lastcontrolroom"], var_1, "tag_origin");
      scripts\engine\utility::flag_wait("civs_over");
      killfxontag(level._effect["vfx_ra_camcentr_lastcontrolroom"], var_1, "tag_origin");
    default:
      break;
  }
}

_id_3794(var_0) {}

_id_10941() {
  level.doors["civilian_buddydoor"] waittill("buddydoor_pull_complete");
  scripts\engine\utility::flag_set("stop_depot_cam_fx");
}

toggle_convoy_wheel_outlines(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon(var_0);
  var_6 = "first";
  var_7 = [var_1, var_2, var_3, var_4, var_5];
  var_8 = undefined;
  thread _id_A5E0(var_7, var_0);
  var_9 = "BLANK";

  for(;;) {
    switch (var_6) {
      case "first":
        var_8 = var_1;
        playFXOnTag(level._effect[var_1], self, "tag_origin");
        break;
      case "inside_on":
        if(isDefined(var_2) && var_2 == "nuke") {
          stopFXOnTag(level._effect[var_8], self, "tag_origin");
        } else if(isDefined(var_2) && var_8 != var_2) {
          stopFXOnTag(level._effect[var_8], self, "tag_origin");
          var_8 = var_2;
          playFXOnTag(level._effect[var_2], self, "tag_origin");
        }

        break;
      case "outside_on":
        if(isDefined(var_3) && var_3 == "nuke") {
          stopFXOnTag(level._effect[var_8], self, "tag_origin");
        } else if(isDefined(var_3) && var_8 != var_3) {
          stopFXOnTag(level._effect[var_8], self, "tag_origin");
          var_8 = var_3;
          playFXOnTag(level._effect[var_3], self, "tag_origin");
        }

        break;
      case "inside_off":
        if(isDefined(var_4) && var_4 == "nuke") {
          stopFXOnTag(level._effect[var_8], self, "tag_origin");
        } else if(isDefined(var_4) && var_8 != var_4) {
          stopFXOnTag(level._effect[var_8], self, "tag_origin");
          var_8 = var_4;
          playFXOnTag(level._effect[var_4], self, "tag_origin");
        }

        break;
      case "outside_off":
        if(isDefined(var_5) && var_5 == "nuke") {
          stopFXOnTag(level._effect[var_8], self, "tag_origin");
        } else if(isDefined(var_5) && var_8 != var_5) {
          stopFXOnTag(level._effect[var_8], self, "tag_origin");
          var_8 = var_5;
          playFXOnTag(level._effect[var_5], self, "tag_origin");
        }

        break;
      default:
        break;
    }

    wait 0.1;

    for(;;) {
      var_6 = level scripts\engine\utility::waittill_any_return("sun_safe_zone", "player_is_inside", "player_is_outside", "power_on", "power_off");
      var_6 = _id_53B8();

      if(var_6 != var_9) {
        var_9 = var_6;
        break;
      }
    }
  }
}

_id_A5E0(var_0, var_1) {
  level waittill(var_1);

  foreach(var_3 in var_0) {
    if(isDefined(var_3) && var_3 != "nuke") {
      stopFXOnTag(scripts\engine\utility::getfx(var_3), self, "tag_origin");
    }
  }
}

_id_53B8() {
  var_0 = undefined;

  if(scripts\engine\utility::flag("power_on")) {
    if(scripts\engine\utility::flag("player_is_inside") || scripts\engine\utility::flag("sun_safe_zone")) {
      var_0 = "inside_on";
    } else {
      var_0 = "outside_on";
    }
  } else if(scripts\engine\utility::flag("player_is_inside") || scripts\engine\utility::flag("sun_safe_zone"))
    var_0 = "inside_off";
  else {
    var_0 = "outside_off";
  }

  return var_0;
}

_id_43E1() {
  level.player endon("death");

  for(;;) {
    if(scripts\engine\utility::flag("combat_section_active")) {
      update_rogue_post_fx(2, 0.1, 0.8, 0, 0.88, 0.004, 0.88, 0.004);
      scripts\engine\utility::flag_waitopen("combat_section_active");
    }

    if(scripts\engine\utility::flag("hangar_door_open") && !scripts\engine\utility::flag("player_at_array2_scene")) {
      scripts\engine\utility::flag_wait("player_is_outside");
      update_rogue_post_fx(2, 0.1, 0.8, 0, 0.88, 0.003, 0.88, 0.003);
      scripts\engine\utility::flag_wait("player_at_array2_scene");
    }

    if(scripts\engine\utility::flag("player_at_array2_scene") && !scripts\engine\utility::flag("dorm_run_started")) {
      update_rogue_post_fx(0, 0.1, 0.8, 0, 0.88, 0.0015, 0.3, 0.008);
      scripts\engine\utility::flag_wait("dorm_run_started");
    }

    if(scripts\engine\utility::flag("dorm_run_started") && !scripts\engine\utility::flag("dorm_airlock_door_shut")) {
      update_rogue_post_fx(2, 0.1, 0.8, 0, 0.88, 0.003, 0.88, 0.003);
      scripts\engine\utility::flag_wait("dorm_airlock_door_shut");
    }

    if(scripts\engine\utility::flag("in_creep_hallway")) {
      update_rogue_post_fx(0, 0.1, 0.8, 0, 0.3, 0.008, 0.3, 0.008);
      scripts\engine\utility::flag_waitopen("disable_alt_vision_calls");
    }

    if(!scripts\engine\utility::flag("hangar_door_open") || !scripts\engine\utility::flag("in_creep_hallway") && scripts\engine\utility::flag("disable_alt_vision_calls")) {
      update_rogue_post_fx(0, 0.1, 0.8, 0, 0.88, 0.0015, 0.3, 0.008);
    } else {
      update_rogue_post_fx(2, 0.1, 0.8, 0, 0.88, 0.0015, 0.88, 0.0015);
    }

    level scripts\engine\utility::waittill_any("dorm_run_started", "power_on", "power_off", "player_at_array2_scene", "hangar_door_open", "combat_section_active", "in_creep_hallway", "disable_alt_vision_calls");
  }
}

update_rogue_post_fx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  setsaveddvar("r_mbenable", var_0);
  setsaveddvar("r_mbvelocityscale", var_1);
  setsaveddvar("r_mbradialoverridechromaticaberration", var_2);
  setsaveddvar("r_mbradialoverridedistortion", var_3);

  if(scripts\engine\utility::flag("flashlight_desired") && scripts\engine\utility::flag("power_off")) {
    setsaveddvar("r_mbradialoverrideradius", var_6);
    setsaveddvar("r_mbradialoverridestrength", var_7);
  } else {
    setsaveddvar("r_mbradialoverrideradius", var_4);
    setsaveddvar("r_mbradialoverridestrength", var_5);
  }
}

_id_B344(var_0, var_1, var_2, var_3, var_4, var_5) {
  level._id_B33B._id_C26B = [];
  level._id_B33B._id_C26B["civilians"] = ["rogue_brk_objectivenag1", "rogue_brk_objectivenag2"];
  level._id_B33B._id_C26B["stratcom"] = ["rogue_brk_objectivenag3", "rogue_brk_objectivenag4", "rogue_brk_objectivenag5"];
  level._id_B33B._id_C26B["resources"] = ["rogue_brk_objectivenag7", "rogue_brk_objectivenag8", "rogue_brk_objectivenag10"];
  level._id_B33B._id_C26B["mines"] = ["rogue_brk_objectivenag6", "rogue_brk_objectivenag9"];
  var_6 = level._id_B33B._id_C26B[var_2];

  if(isDefined(var_3)) {
    var_6 = scripts\engine\utility::array_combine(var_6, level._id_B33B._id_C26B[var_3]);
  }

  if(isDefined(var_4)) {
    var_6 = scripts\engine\utility::array_combine(var_6, level._id_B33B._id_C26B[var_4]);
  }

  var_6 = scripts\engine\utility::array_removeundefined(var_6);

  if(var_6.size == 0) {
    return;
  }
  if(isDefined(var_1)) {
    level endon(var_1);
  }

  wait(var_0);
  var_7 = var_6[randomintrange(0, var_6.size)];

  foreach(var_9 in level._id_B33B._id_C26B) {
    for(var_10 = 0; var_10 < var_9.size; var_10++) {
      if(var_9[var_10] == var_7) {
        var_9[var_10] = undefined;
      }
    }
  }

  if(distance2d(level._id_B33B.origin, level.player.origin) >= 1024) {
    level.player playSound(var_7);
  } else {
    level._id_B33B scripts\sp\utility::_id_10346(var_7);
  }
}

_id_D74A() {
  level.player endon("death");

  for(;;) {
    level scripts\engine\utility::waittill_any("power_on", "power_off");

    if(scripts\engine\utility::flag("power_on")) {
      _id_0A03::_id_F728(0, 2);

      if(getdvarint("rogue_power_watcher", 0) == 1) {
        iprintlnbold("power_on");
      }

      continue;
    }

    _id_0A03::_id_F727(1, 1);

    if(getdvarint("rogue_power_watcher", 0) == 1) {
      iprintlnbold("power_off");
    }
  }
}

_id_404C() {
  thread _id_0E26::_id_DFC1();
  thread _id_0E25::_id_DFBE();
  thread _id_0E21::_id_DFBA();
  thread scripts\sp\coverwall::_id_DFBD();
  thread _id_0B1D::_id_DFBF();
  thread _id_0E2D::_id_A5B9();
}

remove_navigating_equipment() {
  thread _id_0E26::_id_DFC1();
  thread _id_0E2D::_id_A5B9();
}

_id_119AF(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(var_0) {
    foreach(var_2 in level._id_10AC8) {
      var_2.grenadeawareness = 0;
    }

    scripts\sp\utility::_id_200D("allies", 1);
    var_0 = 0;
  } else {
    foreach(var_2 in level._id_10AC8) {
      var_2.grenadeawareness = var_2._id_C381;
    }

    scripts\sp\utility::_id_200D("allies", 0);
    var_0 = 1;
  }

  foreach(var_2 in level._id_10AC8) {
    var_2 thread scripts\sp\utility::_id_2011(var_0);
  }
}

_id_E666() {
  var_0 = getEntArray("rogue_player_nudge_volume", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _id_E665();
  }
}

_id_E665() {
  if(isDefined(self.script_parameters)) {
    thread _id_409D(self.script_parameters);
    self endon("kill_nudge_trig");
  }

  var_0 = scripts\engine\utility::getStruct(self.target, "targetname");

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
    var_1 = vectorNormalize(anglesToForward(var_0.angles) * 200 - var_0.origin);
  } else {
    var_1 = vectorNormalize(anglesToForward(var_0.angles) * 200 - var_0.origin);
    var_1 = var_1 * -1;
  }

  var_2 = 10;

  for(;;) {
    scripts\engine\utility::flag_wait(self._id_ED9A);

    while(scripts\engine\utility::flag(self._id_ED9A)) {
      earthquake(1 - var_2 * 0.01, 1, var_0.origin, 256);
      wait 0.5;
      level.player _meth_8251(var_1 * var_2, 0);
      var_2 = min(30, var_2 + 10);
    }

    level.player _meth_8251((0, 0, 0), 0);
  }
}

_id_409D(var_0) {
  level waittill(var_0);
  self notify("kill_nudge_trig");
  level.player _meth_8251((0, 0, 0), 0);
  self delete();
}

_id_4073(var_0) {
  scripts\engine\utility::flag_wait(var_0);

  if(isDefined(self)) {
    self delete();
  }
}

_id_E674(var_0, var_1, var_2) {
  level notify("rogue_fade_called");
  level endon("rogue_fade_called");
  level endon("sun_day_night_transistion");
  var_2 = int(var_2 * 20);
  var_3 = [];

  for(var_4 = 0; var_4 < 3; var_4++) {
    var_3[var_4] = (var_0[var_4] - var_1[var_4]) / var_2;
  }

  var_5 = [];

  for(var_4 = 0; var_4 < var_2; var_4++) {
    wait 0.05;

    for(var_6 = 0; var_6 < 3; var_6++) {
      var_5[var_6] = var_0[var_6] - var_3[var_6] * var_4;
    }

    setsunlight(var_5[0], var_5[1], var_5[2]);
  }

  setsunlight(var_1[0], var_1[1], var_1[2]);
}

setup_rogue_back_blockers() {
  var_0 = getEntArray("rogue_back_blocker", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 thread back_blocker_logic();
  }
}

back_blocker_logic() {
  var_0 = scripts\engine\utility::get_target_ent();
  var_0 notsolid();
  self waittill("trigger");
  var_0 solid();
  level.player notify("rogue_back_blocker_set");
}

_id_117FF(var_0) {
  var_1 = level.player getweaponslist("primary");

  if(var_1.size > 1) {
    var_2 = level.player getcurrentprimaryweapon();

    foreach(var_4 in var_1) {
      if(var_2 == var_4) {
        var_5 = level.player getweaponammoclip(var_4);
        var_6 = level.player getweaponammostock(var_4);
        level.player takeweapon(var_4);
        _id_11801(var_4, var_0, undefined, var_5, var_6);
        break;
      }
    }
  }
}

_id_11801(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = level.player getEye();
  }

  if(!isDefined(var_1)) {
    var_1 = 500;
  }

  var_5 = anglesToForward(level.player getplayerangles());
  var_6 = var_2 + (0, 0, -10) + var_5 * 16;
  var_7 = spawn("weapon_" + var_0, var_6);
  var_7 itemweaponsetammo(var_3, var_4);
  var_5 = anglesToForward(level.player getplayerangles() + (-20, 0, 0));
  var_8 = var_5 * var_1;
  var_7 _meth_8226(var_7.origin, var_8);
}

set_rogue_suicide_drone_values() {
  var_0 = scripts\sp\utility::_id_7E72();
  var_1 = 400;
  var_2 = 200;

  switch (var_0) {
    case "easy":
      level.override_hack_eplo_dmg_max = var_1 * 1.75;
      level.override_hack_eplo_dmg_min = var_2 * 1.65;
      break;
    case "medium":
      level.override_hack_eplo_dmg_max = var_1 * 1.95;
      level.override_hack_eplo_dmg_min = var_2 * 1.85;
      break;
    case "hard":
      level.override_hack_eplo_dmg_max = var_1 * 2.2;
      level.override_hack_eplo_dmg_min = var_2 * 2.1;
      break;
    case "fu":
      level.override_hack_eplo_dmg_max = var_1 * 2.6;
      level.override_hack_eplo_dmg_min = var_2 * 2.5;
      break;
  }
}

rogue_gameskill_watcher() {
  var_0 = "";

  for(;;) {
    if(var_0 != scripts\sp\utility::_id_7E72()) {
      set_rogue_suicide_drone_values();
      var_0 = scripts\sp\utility::_id_7E72();
    }

    wait 4;
  }
}