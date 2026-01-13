/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\2968.gsc
*********************************************/

setsuit(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  var_0 endon("death");
  if(isDefined(var_0.var_8C2D)) {
    return;
  } else {
    var_0.var_8C2D = 1;
  }

  var_0 scripts\sp\utility::script_delay();
  var_0 notify("start_vehiclepath");
  if(isaircraft(var_0)) {
    if(isDefined(var_0.var_10A47)) {
      var_0[[var_0.var_10A47]](scripts\sp\utility::func_7C9A(var_0.target));
      return;
    }

    return;
  }

  if(var_0 scripts\sp\vehicle_code::func_12F8()) {
    var_0 notify("start_dynamicpath");
    return;
  }

  var_0 startpath();
}

func_1442(var_0, var_1, var_2) {
  if(scripts\sp\vehicle_code::func_12F8()) {
    func_1321B(var_0, var_1, var_2);
    return;
  }

  func_1321C(var_0);
}

func_12783(var_0) {
  if(isDefined(var_0.var_ED9E)) {
    scripts\engine\utility::flag_set(var_0.var_ED9E);
  }

  if(isDefined(var_0.var_ED9B)) {
    scripts\engine\utility::flag_clear(var_0.var_ED9B);
  }

  if(isDefined(var_0.script_prefab_exploder)) {
    var_0.script_exploder = var_0.script_prefab_exploder;
    var_0.script_prefab_exploder = undefined;
  }

  if(isDefined(var_0.script_exploder)) {
    var_1 = var_0.var_ED85;
    if(isDefined(var_1)) {
      level scripts\engine\utility::delaythread(var_1, ::scripts\engine\utility::exploder, var_0.script_exploder);
    } else {
      level scripts\engine\utility::exploder(var_0.script_exploder);
    }
  }

  if(isDefined(var_0.var_ED9E)) {
    scripts\engine\utility::flag_set(var_0.var_ED9E);
  }

  if(isDefined(var_0.var_ED80)) {
    scripts\sp\utility::func_65E1(var_0.var_ED80);
  }

  if(isDefined(var_0.var_ED7F)) {
    scripts\sp\utility::func_65DD(var_0.var_ED7F);
  }

  if(isDefined(var_0.var_ED9B)) {
    scripts\engine\utility::flag_clear(var_0.var_ED9B);
  }

  if(isDefined(var_0.script_noteworthy)) {
    if(var_0.script_noteworthy == "deleteme") {
      self delete();
      return;
    } else if(var_0.script_noteworthy == "engineoff") {
      self func_83E8();
    } else {
      self notify(var_0.script_noteworthy);
      self notify("noteworthy", var_0.script_noteworthy);
    }
  }

  if(isDefined(var_0.var_ED12)) {
    self.var_ED12 = var_0.var_ED12;
  }

  if(isDefined(var_0.var_EEF8)) {
    if(var_0.var_EEF8) {
      scripts\sp\vehicle_code::func_134D();
      return;
    }

    scripts\sp\vehicle_code::func_134C();
  }
}

func_9E71(var_0) {
  if(!isDefined(var_0.target)) {
    return 1;
  }

  if(!isDefined(getvehiclenode(var_0.target, "targetname")) && !isDefined(scripts\sp\vehicle_code::func_7D48(var_0.target))) {
    return 1;
  }

  return 0;
}

func_13235(var_0, var_1) {
  if(isDefined(var_1.var_EEFB)) {
    return 1;
  }

  if(var_0 != ::func_C041) {
    return 0;
  }

  if(!func_9E71(var_1)) {
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

func_C82A(var_0) {}

func_13222() {
  if(!scripts\sp\vehicle_code::func_12F8()) {
    self resumespeed(35);
    return;
  }

  var_0 = undefined;
  if(isDefined(self.var_4BF7.target)) {
    var_0 = scripts\sp\vehicle_code::func_7D48(self.var_4BF7.target);
  }

  if(!isDefined(var_0)) {
    return;
  }

  func_1442(var_0);
}

func_7B6F(var_0) {
  var_1 = ::scripts\sp\vehicle_code::func_79D7;
  if(scripts\sp\vehicle_code::func_12F8() && isDefined(var_0.target)) {
    if(isDefined(scripts\sp\vehicle_code::func_79D3(var_0.target))) {
      var_1 = ::scripts\sp\vehicle_code::func_79D3;
    }

    if(isDefined(scripts\sp\vehicle_code::func_79D5(var_0.target))) {
      var_1 = ::scripts\sp\vehicle_code::func_79D5;
    }
  }

  return var_1;
}

func_C041(var_0, var_1, var_2) {
  if(isDefined(self.unique_id)) {
    var_3 = "node_flag_triggered" + self.unique_id;
  } else {
    var_3 = "node_flag_triggered";
  }

  func_C055(var_3, var_0, var_2);
  if(self.var_247E == var_0) {
    self notify("node_wait_terminated");
    waittillframeend;
    return;
  }

  var_0 scripts\sp\utility::func_65E7(var_3);
  var_0 scripts\sp\utility::func_65DD(var_3, 1);
  var_0 notify("processed_node" + var_3);
}

func_C055(var_0, var_1, var_2) {
  var_3 = 0;
  while(isDefined(var_1) && var_3 < 3) {
    var_3++;
    thread func_C032(var_0, var_1);
    if(!isDefined(var_1.target)) {
      return;
    }

    var_1 = [[var_2]](var_1.target);
  }
}

func_C032(var_0, var_1) {
  if(var_1 scripts\sp\utility::func_65DF(var_0)) {
    return;
  }

  var_1 scripts\sp\utility::func_65E0(var_0);
  thread func_C033(var_1, var_0);
  var_1 endon("processed_node" + var_0);
  self endon("death");
  self endon("newpath");
  self endon("node_wait_terminated");
  var_1 waittill("trigger");
  var_1 scripts\sp\utility::func_65E1(var_0);
}

func_C033(var_0, var_1) {
  var_0 endon("processed_node" + var_1);
  scripts\engine\utility::waittill_any_3("death", "newpath", "node_wait_terminated");
  var_0 scripts\sp\utility::func_65DD(var_1, 1);
}

func_1321C(var_0) {
  self notify("newpath");
  if(isDefined(var_0)) {
    self.var_247E = var_0;
  }

  var_1 = self.var_247E;
  self.var_4BF7 = self.var_247E;
  if(!isDefined(var_1)) {
    return;
  }

  self endon("newpath");
  self endon("death");
  var_2 = var_1;
  var_3 = undefined;
  var_4 = var_1;
  var_5 = func_7B6F(var_1);
  while(isDefined(var_4)) {
    func_C041(var_4, var_3, var_5);
    if(!isDefined(self)) {
      return;
    }

    func_12783(var_4);
    self.var_4BF7 = var_4;
    if(!isDefined(self)) {
      return;
    }

    if(isDefined(var_4.script_team)) {
      self.script_team = var_4.script_team;
    }

    if(isDefined(var_4.var_EEF1)) {
      self notify("turning", var_4.var_EEF1);
    }

    if(isDefined(var_4.var_ED4A)) {
      if(var_4.var_ED4A == 0) {
        thread scripts\sp\vehicle_code::func_4E5B();
      } else {
        thread scripts\sp\vehicle_code::func_4E5C();
      }
    }

    if(isDefined(var_4.var_EF1E)) {
      scripts\sp\vehicle_code::func_13D03(var_4.var_EF1E);
    }

    if(func_13235(::func_C041, var_4)) {
      thread func_12BC7(var_4);
    }

    if(isDefined(var_4.var_EEED)) {
      self.var_37D = var_4.var_EEED;
      if(self.var_37D == "forward") {
        scripts\sp\vehicle_code::func_13D03(1);
      } else {
        scripts\sp\vehicle_code::func_13D03(0);
      }
    }

    if(isDefined(var_4.var_ED1F)) {
      self.var_371 = var_4.var_ED1F;
    }

    if(isDefined(var_4.var_EE7C)) {
      self.var_378 = var_4.var_EE7C;
    }

    if(isDefined(var_4.var_ED81)) {
      var_6 = 35;
      if(isDefined(var_4.var_ED4C)) {
        var_6 = var_4.var_ED4C;
      }

      self vehicle_setspeed(0, var_6);
      scripts\sp\utility::func_65E3(var_4.var_ED81);
      if(!isDefined(self)) {
        return;
      }

      var_7 = 60;
      if(isDefined(var_4.script_accel)) {
        var_7 = var_4.script_accel;
      }

      self resumespeed(var_7);
    }

    if(isDefined(var_4.script_delay)) {
      var_6 = 35;
      if(isDefined(var_4.var_ED4C)) {
        var_6 = var_4.var_ED4C;
      }

      self vehicle_setspeed(0, var_6);
      if(isDefined(var_4.target)) {
        thread func_C82A([[var_5]](var_4.target));
      }

      var_4 scripts\sp\utility::script_delay();
      self notify("delay_passed");
      var_7 = 60;
      if(isDefined(var_4.script_accel)) {
        var_7 = var_4.script_accel;
      }

      self resumespeed(var_7);
    }

    if(isDefined(var_4.var_EDA0)) {
      var_8 = 0;
      if(!scripts\engine\utility::flag(var_4.var_EDA0) || isDefined(var_4.script_delay_post)) {
        var_8 = 1;
        var_7 = 5;
        var_6 = 35;
        if(isDefined(var_4.script_accel)) {
          var_7 = var_4.script_accel;
        }

        if(isDefined(var_4.var_ED4C)) {
          var_6 = var_4.var_ED4C;
        }

        func_1445("script_flag_wait_" + var_4.var_EDA0, var_7, var_6);
        thread func_C82A([[var_5]](var_4.target));
      }

      scripts\engine\utility::flag_wait(var_4.var_EDA0);
      if(!isDefined(self)) {
        return;
      }

      if(isDefined(var_4.script_delay_post)) {
        wait(var_4.script_delay_post);
        if(!isDefined(self)) {
          return;
        }
      }

      var_7 = 10;
      if(isDefined(var_4.script_accel)) {
        var_7 = var_4.script_accel;
      }

      if(var_8) {
        func_1443("script_flag_wait_" + var_4.var_EDA0);
      }

      self notify("delay_passed");
    }

    if(isDefined(self.var_F472)) {
      self.var_F472 = undefined;
      self getplayerkillstreakcombatmode();
    }

    if(isDefined(var_4.var_EF03)) {
      thread scripts\sp\vehicle_lights::lights_off(var_4.var_EF03);
    }

    if(isDefined(var_4.var_EF04)) {
      thread scripts\sp\vehicle_lights::lights_on(var_4.var_EF04);
    }

    if(isDefined(var_4.var_EDAD)) {
      thread scripts\sp\vehicle_code::func_1322D(var_4.var_EDAD);
    }

    var_3 = var_4;
    if(!isDefined(var_4.target)) {
      break;
    }

    var_4 = [[var_5]](var_4.target);
    if(!isDefined(var_4)) {
      var_4 = var_3;
      break;
    }
  }

  self notify("reached_dynamic_path_end");
  if(isDefined(self.var_EF05)) {
    self notify("delete");
    self delete();
  }
}

func_1321B(var_0, var_1, var_2) {
  self notify("newpath");
  self endon("newpath");
  self endon("death");
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(isDefined(var_0)) {
    self.var_247E = var_0;
  }

  var_3 = self.var_247E;
  self.var_4BF7 = self.var_247E;
  if(!isDefined(var_3)) {
    return;
  }

  var_4 = var_3;
  if(var_1) {
    self waittill("start_dynamicpath");
  }

  if(isDefined(var_2)) {
    var_5 = spawnStruct();
    var_5.origin = scripts\sp\utility::func_1796(self.origin, var_2);
    func_8DA3(var_5, undefined);
  }

  var_6 = undefined;
  var_7 = var_3;
  var_8 = func_7B6F(var_3);
  while(isDefined(var_7)) {
    if(isDefined(var_7.script_linkto)) {
      scripts\sp\vehicle_code::func_F471(var_7);
    }

    if(isDefined(var_7.var_EDFA)) {
      var_9 = 0;
      if(isDefined(var_7.target)) {
        var_9 = isDefined([[var_8]](var_7.target));
      }

      thread scripts\sp\vehicle_code::func_13200(var_7.var_EEFB, var_9);
    }

    func_8DA3(var_7, var_6, var_2);
    if(!isDefined(self)) {
      return;
    }

    self.var_4BF7 = var_7;
    var_7 notify("trigger", self);
    if(isDefined(var_7.var_EDD8)) {
      self giveloadout(var_7.var_EDD8);
      if(var_7.var_EDD8 == "faster") {
        self setmaxpitchroll(25, 50);
      }
    }

    func_12783(var_7);
    if(!isDefined(self)) {
      return;
    }

    if(isDefined(var_7.script_team)) {
      self.script_team = var_7.script_team;
    }

    if(func_13235(::func_8DA3, var_7)) {
      thread func_12BC7(var_7);
    }

    if(self func_83E2()) {
      if(isDefined(var_7.var_EE7C)) {
        self.var_378 = var_7.var_EE7C;
      }
    }

    if(isDefined(var_7.var_EDA0)) {
      scripts\engine\utility::flag_wait(var_7.var_EDA0);
      if(isDefined(var_7.script_delay_post)) {
        wait(var_7.script_delay_post);
      }

      self notify("delay_passed");
    }

    if(isDefined(self.var_F472)) {
      self.var_F472 = undefined;
      self getplayerkillstreakcombatmode();
    }

    if(isDefined(var_7.var_EF03)) {
      thread scripts\sp\vehicle_lights::lights_off(var_7.var_EF03);
    }

    if(isDefined(var_7.var_EF04)) {
      thread scripts\sp\vehicle_lights::lights_on(var_7.var_EF04);
    }

    if(isDefined(var_7.var_EDAD)) {
      thread scripts\sp\vehicle_code::func_1322D(var_7.var_EDAD);
    }

    var_6 = var_7;
    if(!isDefined(var_7.target)) {
      break;
    }

    var_7 = [[var_8]](var_7.target);
    if(!isDefined(var_7)) {
      var_7 = var_6;
      break;
    }
  }

  self notify("reached_dynamic_path_end");
  if(isDefined(self.var_EF05)) {
    self delete();
  }
}

func_8DA3(var_0, var_1, var_2) {
  self endon("newpath");
  if(isDefined(var_0.var_EEFB) || isDefined(var_0.var_EDFA)) {
    var_3 = 0;
    if(isDefined(var_0.var_EDFA)) {
      scripts\sp\utility::func_65E1("landed");
      if(isDefined(self.var_12BC2)) {
        var_3 = self.var_12BC2;
      }
    } else if(isDefined(var_0.var_EEFB) && isDefined(self.var_12BC0)) {
      var_3 = self.var_12BC0;
    } else if(isDefined(var_0.var_EEFB) && isDefined(self.var_12BC1)) {
      var_4 = scripts\sp\utility::func_864C(var_0.origin);
      var_3 = var_0.origin[2] - var_4[2];
      if(var_3 >= self.var_12BC1) {
        var_3 = self.var_12BC1;
      } else if(isDefined(self.var_12BBF) && var_3 < self.var_12BBF) {
        var_3 = self.var_12BBF;
      }
    }

    var_0.fgetarg = 2;
    if(isDefined(var_0.var_8630)) {
      var_0.origin = var_0.var_8630 + (0, 0, var_3);
    } else {
      var_5 = scripts\sp\utility::func_864C(var_0.origin) + (0, 0, var_3);
      if(var_5[2] > var_0.origin[2] - 2000) {
        var_0.origin = scripts\sp\utility::func_864C(var_0.origin) + (0, 0, var_3);
      }
    }

    self sethoverparams(0, 0, 0);
  }

  if(isDefined(var_1)) {
    var_6 = var_1.var_ECE9;
    var_7 = var_1.getclosestpointonnavmesh3d;
    var_8 = var_1.script_accel;
    var_9 = var_1.var_ED4C;
  } else {
    var_6 = undefined;
    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;
  }

  var_0A = isDefined(var_0.var_EED2) && var_0.var_EED2;
  var_0B = isDefined(var_0.var_EEFB);
  var_0C = isDefined(var_0.var_EDA0) && !scripts\engine\utility::flag(var_0.var_EDA0);
  var_0D = !isDefined(var_0.target);
  var_0E = isDefined(var_0.script_delay);
  if(isDefined(var_0.angles)) {
    var_0F = var_0.angles[1];
  } else {
    var_0F = 0;
  }

  if(self.health <= 0) {
    return;
  }

  var_10 = var_0.origin;
  if(isDefined(var_2)) {
    var_10 = scripts\sp\utility::func_1796(var_10, var_2);
  }

  if(isDefined(self.heliheightoverride)) {
    var_10 = (var_10[0], var_10[1], self.heliheightoverride);
  }

  self globtouched(var_10, var_7, var_8, var_9, var_0.var_EDD0, var_0.script_anglevehicle, var_0F, var_6, var_0E, var_0A, var_0B, var_0C, var_0D);
  if(isDefined(var_0.fgetarg)) {
    self setneargoalnotifydist(var_0.fgetarg);
    scripts\engine\utility::waittill_any_3("near_goal", "goal");
  } else {
    self waittill("goal");
  }

  func_12783(var_0);
  if(isDefined(var_0.var_ED97)) {
    if(!isDefined(level.var_8DAF)) {}

    thread[[level.var_8DAF]](var_0);
  }

  var_0 scripts\sp\utility::script_delay();
  if(isDefined(self.var_C95D)) {
    scripts\sp\utility::func_51D4(var_0);
  }

  self notify("continuepath");
}

beginlocationselection(var_0) {
  var_1 = undefined;
  var_2 = self.var_380;
  if(isaircraft(self)) {
    if(isDefined(self.target)) {
      var_3 = getcsplineid(self.target);
      if(isDefined(var_3)) {
        self func_8479(var_3);
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
    var_1 = getvehiclenode(self.target, "targetname");
    if(!isDefined(var_1)) {
      var_4 = getEntArray(self.target, "targetname");
      foreach(var_6 in var_4) {
        if(var_6.var_9F == "script_origin") {
          var_1 = var_6;
          break;
        }
      }
    }

    if(!isDefined(var_1)) {
      var_1 = scripts\engine\utility::getstruct(self.target, "targetname");
    }
  }

  if(!isDefined(var_1)) {
    if(scripts\sp\vehicle_code::func_12F8()) {
      self vehicle_setspeed(60, 20, 10);
    }

    return;
  }

  self.var_247E = var_1;
  if(!scripts\sp\vehicle_code::func_12F8()) {
    self.origin = var_1.origin;
    if(!isDefined(var_0)) {
      self attachpath(var_1);
    }
  } else if(isDefined(self.getclosestpointonnavmesh3d)) {
    self vehicle_setspeedimmediate(self.getclosestpointonnavmesh3d, 20);
  } else if(isDefined(var_1.getclosestpointonnavmesh3d)) {
    var_8 = 20;
    var_9 = 10;
    if(isDefined(var_1.script_accel)) {
      var_8 = var_1.script_accel;
    }

    if(isDefined(var_1.var_ED4C)) {
      var_8 = var_1.var_ED4C;
    }

    self vehicle_setspeedimmediate(var_1.getclosestpointonnavmesh3d, var_8, var_9);
  } else {
    self vehicle_setspeed(60, 20, 10);
  }

  thread func_1442(undefined, scripts\sp\vehicle_code::func_12F8());
}

func_1443(var_0) {
  var_1 = self.var_13244[var_0];
  self.var_13244[var_0] = undefined;
  if(self.var_13244.size) {
    return;
  }

  self resumespeed(var_1);
}

func_1445(var_0, var_1, var_2) {
  if(!isDefined(self.var_13244)) {
    self.var_13244 = [];
  }

  self vehicle_setspeed(0, var_1, var_2);
  self.var_13244[var_0] = var_1;
}

func_12BC7(var_0) {
  self endon("death");
  if(isDefined(self.var_65DB["prep_unload"]) && scripts\sp\utility::func_65DB("prep_unload")) {
    return;
  }

  if(!isDefined(var_0.var_EDA0) && !isDefined(var_0.script_delay)) {
    self notify("newpath");
  }

  var_1 = getnode(var_0.var_336, "target");
  if(isDefined(var_1) && self.var_E4FB.size) {
    foreach(var_3 in self.var_E4FB) {
      if(isai(var_3)) {
        var_3 thread lib_0B77::worldpointinreticle_circle(var_1);
      }
    }
  }

  if(scripts\sp\vehicle_code::func_12F8()) {
    self sethoverparams(0, 0, 0);
    scripts\sp\vehicle_code::func_13804(var_0);
  }

  if(isDefined(var_0.script_noteworthy)) {
    if(var_0.script_noteworthy == "wait_for_flag") {
      scripts\engine\utility::flag_wait(var_0.var_ED9A);
    }
  }

  scripts\sp\vehicle_code::func_1446(var_0.var_EEFB);
  if(scripts\sp\vehicle_aianim::func_E4FC(var_0.var_EEFB)) {
    self waittill("unloaded");
  }

  if(isDefined(var_0.var_EDA0) || isDefined(var_0.script_delay)) {
    return;
  }

  if(isDefined(self)) {
    thread func_13222();
  }
}