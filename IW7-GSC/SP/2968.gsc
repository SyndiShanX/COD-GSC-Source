/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2968.gsc
************************/

setsuit(param_00) {
  if(!isDefined(param_00)) {
    param_00 = self;
  }

  param_00 endon("death");
  if(isDefined(param_00.var_8C2D)) {
    return;
  } else {
    param_00.var_8C2D = 1;
  }

  param_00 scripts\sp\utility::script_delay();
  param_00 notify("start_vehiclepath");
  if(isaircraft(param_00)) {
    if(isDefined(param_00.var_10A47)) {
      param_00[[param_00.var_10A47]](scripts\sp\utility::func_7C9A(param_00.target));
      return;
    }

    return;
  }

  if(param_00 scripts\sp\vehicle_code::func_12F8()) {
    param_00 notify("start_dynamicpath");
    return;
  }

  param_00 startpath();
}

func_1442(param_00, param_01, param_02) {
  if(scripts\sp\vehicle_code::func_12F8()) {
    func_1321B(param_00, param_01, param_02);
    return;
  }

  func_1321C(param_00);
}

func_12783(param_00) {
  if(isDefined(param_00.var_ED9E)) {
    scripts\engine\utility::flag_set(param_00.var_ED9E);
  }

  if(isDefined(param_00.var_ED9B)) {
    scripts\engine\utility::flag_clear(param_00.var_ED9B);
  }

  if(isDefined(param_00.script_prefab_exploder)) {
    param_00.script_exploder = param_00.script_prefab_exploder;
    param_00.script_prefab_exploder = undefined;
  }

  if(isDefined(param_00.script_exploder)) {
    var_01 = param_00.var_ED85;
    if(isDefined(var_01)) {
      level scripts\engine\utility::delaythread(var_01, ::scripts\engine\utility::exploder, param_00.script_exploder);
    } else {
      level scripts\engine\utility::exploder(param_00.script_exploder);
    }
  }

  if(isDefined(param_00.var_ED9E)) {
    scripts\engine\utility::flag_set(param_00.var_ED9E);
  }

  if(isDefined(param_00.var_ED80)) {
    scripts\sp\utility::func_65E1(param_00.var_ED80);
  }

  if(isDefined(param_00.var_ED7F)) {
    scripts\sp\utility::func_65DD(param_00.var_ED7F);
  }

  if(isDefined(param_00.var_ED9B)) {
    scripts\engine\utility::flag_clear(param_00.var_ED9B);
  }

  if(isDefined(param_00.script_noteworthy)) {
    if(param_00.script_noteworthy == "deleteme") {
      self delete();
      return;
    } else if(param_00.script_noteworthy == "engineoff") {
      self _meth_83E8();
    } else {
      self notify(param_00.script_noteworthy);
      self notify("noteworthy", param_00.script_noteworthy);
    }
  }

  if(isDefined(param_00.var_ED12)) {
    self.var_ED12 = param_00.var_ED12;
  }

  if(isDefined(param_00.var_EEF8)) {
    if(param_00.var_EEF8) {
      scripts\sp\vehicle_code::func_134D();
      return;
    }

    scripts\sp\vehicle_code::func_134C();
  }
}

func_9E71(param_00) {
  if(!isDefined(param_00.target)) {
    return 1;
  }

  if(!isDefined(getvehiclenode(param_00.target, "targetname")) && !isDefined(scripts\sp\vehicle_code::func_7D48(param_00.target))) {
    return 1;
  }

  return 0;
}

func_13235(param_00, param_01) {
  if(isDefined(param_01.var_EEFB)) {
    return 1;
  }

  if(param_00 != ::func_C041) {
    return 0;
  }

  if(!func_9E71(param_01)) {
    return 0;
  }

  if(isDefined(self.var_5971)) {
    return 0;
  }

  if(self.var_380 == "empty" || self.var_380 == "empty_heli") {
    return 0;
  }

  return !isDefined(self.var_EF05) && self.var_EF05;
}

func_C82A(param_00) {}

func_13222() {
  if(!scripts\sp\vehicle_code::func_12F8()) {
    self resumespeed(35);
    return;
  }

  var_00 = undefined;
  if(isDefined(self.var_4BF7.target)) {
    var_00 = scripts\sp\vehicle_code::func_7D48(self.var_4BF7.target);
  }

  if(!isDefined(var_00)) {
    return;
  }

  func_1442(var_00);
}

func_7B6F(param_00) {
  var_01 = ::scripts\sp\vehicle_code::func_79D7;
  if(scripts\sp\vehicle_code::func_12F8() && isDefined(param_00.target)) {
    if(isDefined(scripts\sp\vehicle_code::func_79D3(param_00.target))) {
      var_01 = ::scripts\sp\vehicle_code::func_79D3;
    }

    if(isDefined(scripts\sp\vehicle_code::func_79D5(param_00.target))) {
      var_01 = ::scripts\sp\vehicle_code::func_79D5;
    }
  }

  return var_01;
}

func_C041(param_00, param_01, param_02) {
  if(isDefined(self.unique_id)) {
    var_03 = "node_flag_triggered" + self.unique_id;
  } else {
    var_03 = "node_flag_triggered";
  }

  func_C055(var_03, param_00, param_02);
  if(self.var_247E == param_00) {
    self notify("node_wait_terminated");
    waittillframeend;
    return;
  }

  param_00 scripts\sp\utility::func_65E7(var_03);
  param_00 scripts\sp\utility::func_65DD(var_03, 1);
  param_00 notify("processed_node" + var_03);
}

func_C055(param_00, param_01, param_02) {
  var_03 = 0;
  while(isDefined(param_01) && var_03 < 3) {
    var_03++;
    thread func_C032(param_00, param_01);
    if(!isDefined(param_01.target)) {
      return;
    }

    param_01 = [[param_02]](param_01.target);
  }
}

func_C032(param_00, param_01) {
  if(param_01 scripts\sp\utility::func_65DF(param_00)) {
    return;
  }

  param_01 scripts\sp\utility::func_65E0(param_00);
  thread func_C033(param_01, param_00);
  param_01 endon("processed_node" + param_00);
  self endon("death");
  self endon("newpath");
  self endon("node_wait_terminated");
  param_01 waittill("trigger");
  param_01 scripts\sp\utility::func_65E1(param_00);
}

func_C033(param_00, param_01) {
  param_00 endon("processed_node" + param_01);
  scripts\engine\utility::waittill_any_3("death", "newpath", "node_wait_terminated");
  param_00 scripts\sp\utility::func_65DD(param_01, 1);
}

func_1321C(param_00) {
  self notify("newpath");
  if(isDefined(param_00)) {
    self.var_247E = param_00;
  }

  var_01 = self.var_247E;
  self.var_4BF7 = self.var_247E;
  if(!isDefined(var_01)) {
    return;
  }

  self endon("newpath");
  self endon("death");
  var_02 = var_01;
  var_03 = undefined;
  var_04 = var_01;
  var_05 = func_7B6F(var_01);
  while(isDefined(var_04)) {
    func_C041(var_04, var_03, var_05);
    if(!isDefined(self)) {
      return;
    }

    func_12783(var_04);
    self.var_4BF7 = var_04;
    if(!isDefined(self)) {
      return;
    }

    if(isDefined(var_04.script_team)) {
      self.script_team = var_04.script_team;
    }

    if(isDefined(var_04.var_EEF1)) {
      self notify("turning", var_04.var_EEF1);
    }

    if(isDefined(var_04.var_ED4A)) {
      if(var_04.var_ED4A == 0) {
        thread scripts\sp\vehicle_code::func_4E5B();
      } else {
        thread scripts\sp\vehicle_code::func_4E5C();
      }
    }

    if(isDefined(var_04.var_EF1E)) {
      scripts\sp\vehicle_code::func_13D03(var_04.var_EF1E);
    }

    if(func_13235(::func_C041, var_04)) {
      thread func_12BC7(var_04);
    }

    if(isDefined(var_04.var_EEED)) {
      self.var_37D = var_04.var_EEED;
      if(self.var_37D == "forward") {
        scripts\sp\vehicle_code::func_13D03(1);
      } else {
        scripts\sp\vehicle_code::func_13D03(0);
      }
    }

    if(isDefined(var_04.var_ED1F)) {
      self.var_371 = var_04.var_ED1F;
    }

    if(isDefined(var_04.var_EE7C)) {
      self.var_378 = var_04.var_EE7C;
    }

    if(isDefined(var_04.var_ED81)) {
      var_06 = 35;
      if(isDefined(var_04.var_ED4C)) {
        var_06 = var_04.var_ED4C;
      }

      self vehicle_setspeed(0, var_06);
      scripts\sp\utility::func_65E3(var_04.var_ED81);
      if(!isDefined(self)) {
        return;
      }

      var_07 = 60;
      if(isDefined(var_04.script_accel)) {
        var_07 = var_04.script_accel;
      }

      self resumespeed(var_07);
    }

    if(isDefined(var_04.script_delay)) {
      var_06 = 35;
      if(isDefined(var_04.var_ED4C)) {
        var_06 = var_04.var_ED4C;
      }

      self vehicle_setspeed(0, var_06);
      if(isDefined(var_04.target)) {
        thread func_C82A([[var_05]](var_04.target));
      }

      var_04 scripts\sp\utility::script_delay();
      self notify("delay_passed");
      var_07 = 60;
      if(isDefined(var_04.script_accel)) {
        var_07 = var_04.script_accel;
      }

      self resumespeed(var_07);
    }

    if(isDefined(var_04.var_EDA0)) {
      var_08 = 0;
      if(!scripts\engine\utility::flag(var_04.var_EDA0) || isDefined(var_04.script_delay_post)) {
        var_08 = 1;
        var_07 = 5;
        var_06 = 35;
        if(isDefined(var_04.script_accel)) {
          var_07 = var_04.script_accel;
        }

        if(isDefined(var_04.var_ED4C)) {
          var_06 = var_04.var_ED4C;
        }

        func_1445("script_flag_wait_" + var_04.var_EDA0, var_07, var_06);
        thread func_C82A([[var_05]](var_04.target));
      }

      scripts\engine\utility::flag_wait(var_04.var_EDA0);
      if(!isDefined(self)) {
        return;
      }

      if(isDefined(var_04.script_delay_post)) {
        wait(var_04.script_delay_post);
        if(!isDefined(self)) {
          return;
        }
      }

      var_07 = 10;
      if(isDefined(var_04.script_accel)) {
        var_07 = var_04.script_accel;
      }

      if(var_08) {
        func_1443("script_flag_wait_" + var_04.var_EDA0);
      }

      self notify("delay_passed");
    }

    if(isDefined(self.var_F472)) {
      self.var_F472 = undefined;
      self getplayerkillstreakcombatmode();
    }

    if(isDefined(var_04.var_EF03)) {
      thread scripts\sp\vehicle_lights::lights_off(var_04.var_EF03);
    }

    if(isDefined(var_04.var_EF04)) {
      thread scripts\sp\vehicle_lights::lights_on(var_04.var_EF04);
    }

    if(isDefined(var_04.var_EDAD)) {
      thread scripts\sp\vehicle_code::func_1322D(var_04.var_EDAD);
    }

    var_03 = var_04;
    if(!isDefined(var_04.target)) {
      break;
    }

    var_04 = [[var_05]](var_04.target);
    if(!isDefined(var_04)) {
      var_04 = var_03;
      break;
    }
  }

  self notify("reached_dynamic_path_end");
  if(isDefined(self.var_EF05)) {
    self notify("delete");
    self delete();
  }
}

func_1321B(param_00, param_01, param_02) {
  self notify("newpath");
  self endon("newpath");
  self endon("death");
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(isDefined(param_00)) {
    self.var_247E = param_00;
  }

  var_03 = self.var_247E;
  self.var_4BF7 = self.var_247E;
  if(!isDefined(var_03)) {
    return;
  }

  var_04 = var_03;
  if(param_01) {
    self waittill("start_dynamicpath");
  }

  if(isDefined(param_02)) {
    var_05 = spawnStruct();
    var_05.origin = scripts\sp\utility::func_1796(self.origin, param_02);
    func_8DA3(var_05, undefined);
  }

  var_06 = undefined;
  var_07 = var_03;
  var_08 = func_7B6F(var_03);
  while(isDefined(var_07)) {
    if(isDefined(var_07.script_linkto)) {
      scripts\sp\vehicle_code::func_F471(var_07);
    }

    if(isDefined(var_07.var_EDFA)) {
      var_09 = 0;
      if(isDefined(var_07.target)) {
        var_09 = isDefined([[var_08]](var_07.target));
      }

      thread scripts\sp\vehicle_code::func_13200(var_07.var_EEFB, var_09);
    }

    func_8DA3(var_07, var_06, param_02);
    if(!isDefined(self)) {
      return;
    }

    self.var_4BF7 = var_07;
    var_07 notify("trigger", self);
    if(isDefined(var_07.var_EDD8)) {
      self giveloadout(var_07.var_EDD8);
      if(var_07.var_EDD8 == "faster") {
        self setmaxpitchroll(25, 50);
      }
    }

    func_12783(var_07);
    if(!isDefined(self)) {
      return;
    }

    if(isDefined(var_07.script_team)) {
      self.script_team = var_07.script_team;
    }

    if(func_13235(::func_8DA3, var_07)) {
      thread func_12BC7(var_07);
    }

    if(self _meth_83E2()) {
      if(isDefined(var_07.var_EE7C)) {
        self.var_378 = var_07.var_EE7C;
      }
    }

    if(isDefined(var_07.var_EDA0)) {
      scripts\engine\utility::flag_wait(var_07.var_EDA0);
      if(isDefined(var_07.script_delay_post)) {
        wait(var_07.script_delay_post);
      }

      self notify("delay_passed");
    }

    if(isDefined(self.var_F472)) {
      self.var_F472 = undefined;
      self getplayerkillstreakcombatmode();
    }

    if(isDefined(var_07.var_EF03)) {
      thread scripts\sp\vehicle_lights::lights_off(var_07.var_EF03);
    }

    if(isDefined(var_07.var_EF04)) {
      thread scripts\sp\vehicle_lights::lights_on(var_07.var_EF04);
    }

    if(isDefined(var_07.var_EDAD)) {
      thread scripts\sp\vehicle_code::func_1322D(var_07.var_EDAD);
    }

    var_06 = var_07;
    if(!isDefined(var_07.target)) {
      break;
    }

    var_07 = [[var_08]](var_07.target);
    if(!isDefined(var_07)) {
      var_07 = var_06;
      break;
    }
  }

  self notify("reached_dynamic_path_end");
  if(isDefined(self.var_EF05)) {
    self delete();
  }
}

func_8DA3(param_00, param_01, param_02) {
  self endon("newpath");
  if(isDefined(param_00.var_EEFB) || isDefined(param_00.var_EDFA)) {
    var_03 = 0;
    if(isDefined(param_00.var_EDFA)) {
      scripts\sp\utility::func_65E1("landed");
      if(isDefined(self.var_12BC2)) {
        var_03 = self.var_12BC2;
      }
    } else if(isDefined(param_00.var_EEFB) && isDefined(self.var_12BC0)) {
      var_03 = self.var_12BC0;
    } else if(isDefined(param_00.var_EEFB) && isDefined(self.var_12BC1)) {
      var_04 = scripts\sp\utility::func_864C(param_00.origin);
      var_03 = param_00.origin[2] - var_04[2];
      if(var_03 >= self.var_12BC1) {
        var_03 = self.var_12BC1;
      } else if(isDefined(self.var_12BBF) && var_03 < self.var_12BBF) {
        var_03 = self.var_12BBF;
      }
    }

    param_00.fgetarg = 2;
    if(isDefined(param_00.var_8630)) {
      param_00.origin = param_00.var_8630 + (0, 0, var_03);
    } else {
      var_05 = scripts\sp\utility::func_864C(param_00.origin) + (0, 0, var_03);
      if(var_05[2] > param_00.origin[2] - 2000) {
        param_00.origin = scripts\sp\utility::func_864C(param_00.origin) + (0, 0, var_03);
      }
    }

    self sethoverparams(0, 0, 0);
  }

  if(isDefined(param_01)) {
    var_06 = param_01.var_ECE9;
    var_07 = param_01.getclosestpointonnavmesh3d;
    var_08 = param_01.script_accel;
    var_09 = param_01.var_ED4C;
  } else {
    var_06 = undefined;
    var_07 = undefined;
    var_08 = undefined;
    var_09 = undefined;
  }

  var_0A = isDefined(param_00.var_EED2) && param_00.var_EED2;
  var_0B = isDefined(param_00.var_EEFB);
  var_0C = isDefined(param_00.var_EDA0) && !scripts\engine\utility::flag(param_00.var_EDA0);
  var_0D = !isDefined(param_00.target);
  var_0E = isDefined(param_00.script_delay);
  if(isDefined(param_00.angles)) {
    var_0F = param_00.angles[1];
  } else {
    var_0F = 0;
  }

  if(self.health <= 0) {
    return;
  }

  var_10 = param_00.origin;
  if(isDefined(param_02)) {
    var_10 = scripts\sp\utility::func_1796(var_10, param_02);
  }

  if(isDefined(self.heliheightoverride)) {
    var_10 = (var_10[0], var_10[1], self.heliheightoverride);
  }

  self globtouched(var_10, var_07, var_08, var_09, param_00.var_EDD0, param_00.script_anglevehicle, var_0F, var_06, var_0E, var_0A, var_0B, var_0C, var_0D);
  if(isDefined(param_00.fgetarg)) {
    self setneargoalnotifydist(param_00.fgetarg);
    scripts\engine\utility::waittill_any_3("near_goal", "goal");
  } else {
    self waittill("goal");
  }

  func_12783(param_00);
  if(isDefined(param_00.var_ED97)) {
    if(!isDefined(level.var_8DAF)) {}

    thread[[level.var_8DAF]](param_00);
  }

  param_00 scripts\sp\utility::script_delay();
  if(isDefined(self.var_C95D)) {
    scripts\sp\utility::func_51D4(param_00);
  }

  self notify("continuepath");
}

beginlocationselection(param_00) {
  var_01 = undefined;
  var_02 = self.var_380;
  if(isaircraft(self)) {
    if(isDefined(self.target)) {
      var_03 = getcsplineid(self.target);
      if(isDefined(var_03)) {
        self _meth_8479(var_03);
      }
    }

    return;
  }

  if(isDefined(self.var_1323C)) {
    if(isDefined(self.var_1323C.var_5961) && self.var_5961) {
      return;
    }
  }

  if(isDefined(self.target)) {
    var_01 = getvehiclenode(self.target, "targetname");
    if(!isDefined(var_01)) {
      var_04 = getEntArray(self.target, "targetname");
      foreach(var_06 in var_04) {
        if(var_06.var_9F == "script_origin") {
          var_01 = var_06;
          break;
        }
      }
    }

    if(!isDefined(var_01)) {
      var_01 = scripts\engine\utility::getstruct(self.target, "targetname");
    }
  }

  if(!isDefined(var_01)) {
    if(scripts\sp\vehicle_code::func_12F8()) {
      self vehicle_setspeed(60, 20, 10);
    }

    return;
  }

  self.var_247E = var_01;
  if(!scripts\sp\vehicle_code::func_12F8()) {
    self.origin = var_01.origin;
    if(!isDefined(param_00)) {
      self attachpath(var_01);
    }
  } else if(isDefined(self.getclosestpointonnavmesh3d)) {
    self vehicle_setspeedimmediate(self.getclosestpointonnavmesh3d, 20);
  } else if(isDefined(var_01.getclosestpointonnavmesh3d)) {
    var_08 = 20;
    var_09 = 10;
    if(isDefined(var_01.script_accel)) {
      var_08 = var_01.script_accel;
    }

    if(isDefined(var_01.var_ED4C)) {
      var_08 = var_01.var_ED4C;
    }

    self vehicle_setspeedimmediate(var_01.getclosestpointonnavmesh3d, var_08, var_09);
  } else {
    self vehicle_setspeed(60, 20, 10);
  }

  thread func_1442(undefined, scripts\sp\vehicle_code::func_12F8());
}

func_1443(param_00) {
  var_01 = self.var_13244[param_00];
  self.var_13244[param_00] = undefined;
  if(self.var_13244.size) {
    return;
  }

  self resumespeed(var_01);
}

func_1445(param_00, param_01, param_02) {
  if(!isDefined(self.var_13244)) {
    self.var_13244 = [];
  }

  self vehicle_setspeed(0, param_01, param_02);
  self.var_13244[param_00] = param_01;
}

func_12BC7(param_00) {
  self endon("death");
  if(isDefined(self.var_65DB["prep_unload"]) && scripts\sp\utility::func_65DB("prep_unload")) {
    return;
  }

  if(!isDefined(param_00.var_EDA0) && !isDefined(param_00.script_delay)) {
    self notify("newpath");
  }

  var_01 = getnode(param_00.var_336, "target");
  if(isDefined(var_01) && self.var_E4FB.size) {
    foreach(var_03 in self.var_E4FB) {
      if(isai(var_03)) {
        var_03 thread lib_0B77::worldpointinreticle_circle(var_01);
      }
    }
  }

  if(scripts\sp\vehicle_code::func_12F8()) {
    self sethoverparams(0, 0, 0);
    scripts\sp\vehicle_code::func_13804(param_00);
  }

  if(isDefined(param_00.script_noteworthy)) {
    if(param_00.script_noteworthy == "wait_for_flag") {
      scripts\engine\utility::flag_wait(param_00.var_ED9A);
    }
  }

  scripts\sp\vehicle_code::func_1446(param_00.var_EEFB);
  if(scripts\sp\vehicle_aianim::func_E4FC(param_00.var_EEFB)) {
    self waittill("unloaded");
  }

  if(isDefined(param_00.var_EDA0) || isDefined(param_00.script_delay)) {
    return;
  }

  if(isDefined(self)) {
    thread func_13222();
  }
}