/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2966.gsc
***************************************/

func_FA79() {
  var_00 = func_12B8();

  foreach(var_02 in var_00)
  var_02 thread func_1323A();
}

func_1323A() {
  self endon("entitydeleted");

  if(isDefined(self.func_ED48))
    thread func_0B77::func_1323D();

  self.count = 1;
  self.func_10708 = [];

  for(;;) {
    var_00 = undefined;
    self waittill("spawned", var_00);
    self.count--;

    if(!isDefined(var_00)) {
      continue;
    }
    var_0.func_10707 = self.func_10708;
    var_0.spawner = self;
    var_00 thread func_0B77::func_E81A();
  }
}

func_A629(var_00) {
  var_00 waittill("trigger");

  foreach(var_02 in vehicle_getspawnerarray()) {
    if(isDefined(var_2.func_EDF5) && var_2.func_EDF5 == self.func_EDF5)
      var_02 delete();
  }
}

#using_animtree("vehicles");

func_1063F(var_00) {
  var_01 = [];
  var_02 = scripts\sp\utility::func_65DF("no_riders_until_unload");

  foreach(var_04 in var_00) {
    var_4.count = 1;
    var_05 = 0;
    var_06 = 0;

    if(isDefined(var_4.func_ED6E)) {
      var_05 = 1;
      var_07 = scripts\sp\utility::func_5CC9(var_04);
      var_07 func_0B24::func_5C21();
    } else if(isDefined(var_4.func_ED8A) || isDefined(var_4.func_ED1B)) {
      var_05 = 1;
      var_07 = scripts\sp\utility::func_2C17(var_04);
      var_07 scripts\sp\fakeactor::func_6B15();
    } else if(isDefined(var_4.code_classname) && var_4.code_classname == "script_vehicle") {
      var_06 = 1;
      var_08 = spawn("script_model", (0, 0, 0));
      var_08 setModel(var_4.model);
      var_08 glinton(#animtree);

      if(isDefined(var_4.func_EEC9))
        var_8.func_EEC9 = var_4.func_EEC9;

      var_8.func_9FEF = 1;
      var_8.func_1356F = var_04;
      var_07 = var_08;
    } else {
      var_09 = (isDefined(var_4.func_EECE) || isDefined(var_4.func_EED1)) && scripts\engine\utility::flag("stealth_enabled") && !scripts\engine\utility::flag("stealth_spotted");
      var_10 = var_04;

      if(isDefined(var_4.func_EEB6))
        var_10 = func_0B77::func_7C86(var_04, 1);

      if(isDefined(var_4.func_EDB3) || var_02)
        var_07 = var_10 _meth_8393(var_09);
      else
        var_07 = var_10 dospawn(var_09);

      if(isDefined(var_4.func_EEB6)) {
        if(isDefined(var_4.func_EEC9))
          var_7.func_EEC9 = var_4.func_EEC9;
      }
    }

    if(!var_05 && !var_06 && !isalive(var_07)) {
      continue;
    }
    var_1[var_1.size] = var_07;
  }

  var_01 = func_E05D(var_01);
  return var_01;
}

func_E05D(var_00) {
  var_01 = [];

  foreach(var_03 in var_00) {
    if(!func_19E4(var_03)) {
      continue;
    }
    var_1[var_1.size] = var_03;
  }

  return var_01;
}

func_19E4(var_00) {
  if(isalive(var_00))
    return 1;

  if(!isDefined(var_00))
    return 0;

  if(!isDefined(var_0.classname))
    return 0;

  return var_0.classname == "script_model";
}

spawn_group() {
  if(scripts\sp\utility::func_65DF("no_riders_until_unload") && !scripts\sp\utility::func_65DB("no_riders_until_unload"))
    return [];

  var_00 = func_7D47();

  if(!var_0.size)
    return [];

  var_01 = [];
  var_02 = func_1063F(var_00);
  var_02 = func_1041B(var_02);

  foreach(var_04 in var_02)
  thread scripts\sp\vehicle_aianim::func_8739(var_04);

  return var_02;
}

func_10805(var_00) {
  if(!isDefined(var_00))
    return spawn_group();

  var_01 = func_7D47();

  if(!var_1.size)
    return [];

  var_02 = [];
  var_03 = self.classname;

  if(isDefined(level.vehicle.func_116CE.func_12BCF[var_03]) && isDefined(level.vehicle.func_116CE.func_12BCF[var_03][var_00])) {
    var_04 = level.vehicle.func_116CE.func_12BCF[var_03][var_00];

    foreach(var_06 in var_04) {
      foreach(var_08 in var_01) {
        if(var_8.func_EEC9 == var_06)
          var_2[var_2.size] = var_08;
      }
    }

    var_11 = func_1063F(var_02);

    for(var_12 = 0; var_12 < var_4.size; var_12++) {
      if(isDefined(var_11[var_12]))
        var_11[var_12].func_EEC9 = var_4[var_12];
    }

    var_11 = func_1041B(var_11);

    foreach(var_14 in var_11)
    thread scripts\sp\vehicle_aianim::func_8739(var_14);

    return var_11;
  } else
    return spawn_group();
}

func_1041B(var_00) {
  var_01 = [];
  var_02 = [];

  foreach(var_04 in var_00) {
    if(isDefined(var_4.func_EEC9)) {
      var_1[var_1.size] = var_04;
      continue;
    }

    var_2[var_2.size] = var_04;
  }

  return scripts\engine\utility::array_combine(var_01, var_02);
}

func_E0A7() {
  wait 0.05;
  self.func_1323B = undefined;
}

func_131F6(var_00) {
  var_01 = var_0.classname;

  if(isDefined(level.vehicle.func_116CE.func_1325B) && isDefined(level.vehicle.func_116CE.func_1325B[var_01])) {
    var_00 thread[[level.vehicle.func_116CE.func_1325B[var_01]]]();
    return;
  }

  if(isDefined(level.vehicle.func_116CE.func_8E9D[var_01])) {
    foreach(var_03 in level.vehicle.func_116CE.func_8E9D[var_01])
    var_00 hidepart(var_03);
  }

  if(var_0.vehicletype == "empty" || var_0.vehicletype == "empty_heli") {
    var_00 thread scripts\sp\vehicle_paths::beginlocationselection();
    return;
  }

  var_00 scripts\sp\utility::func_F294();

  if(!isDefined(var_0.func_B91F))
    var_0.func_B91F = 0;

  var_05 = var_0.vehicletype;
  var_00 func_13203();
  var_00 func_1322F();

  if(!isDefined(level.func_13261[var_0.vehicletype][var_0.classname])) {}

  var_00 thread[[level.func_13261[var_0.vehicletype][var_0.classname]]]();
  var_00 thread func_B248();
  var_00 thread func_D546();

  if(!isDefined(var_0.func_ED10))
    var_0.func_ED10 = 0;

  if(isDefined(level.vehicle.draw_thermal)) {
    if(level.vehicle.draw_thermal)
      var_00 thermaldrawenable();
  }

  var_00 scripts\sp\utility::func_65E0("unloaded");
  var_00 scripts\sp\utility::func_65E0("loaded");
  var_00 scripts\sp\utility::func_65E0("landed");
  var_0.func_E4FB = [];
  var_0.func_12BD0 = [];
  var_0.func_12BBC = "default";
  var_0.func_6B9D = [];

  if(isDefined(level.vehicle.func_116CE.func_247D) && isDefined(level.vehicle.func_116CE.func_247D[var_01])) {
    var_06 = level.vehicle.func_116CE.func_247D[var_01];
    var_07 = getarraykeys(var_06);

    foreach(var_09 in var_07) {
      var_0.func_6B9D[var_09] = undefined;
      var_0.func_6B9E[var_09] = 0;
    }
  }

  var_00 thread vehicle_builds();

  if(isDefined(var_0.func_EF04))
    var_00 thread scripts\sp\vehicle_lights::lights_on(var_0.func_EF04);

  if(isDefined(var_0.func_EDD1))
    var_0._meth_843F = 1;

  var_0.func_4CF5 = [];
  var_00 thread func_740E();
  var_00 thread scripts\sp\vehicle_aianim::func_88AE();

  if(isDefined(var_0.func_EDB8))
    var_00 setvehiclelookattext(var_0.func_EDB8, & "");

  var_00 thread func_131EC();

  if(isDefined(var_0.func_ED6C))
    var_0.func_5971 = 1;

  var_00 thread func_1322A();
  var_00 thread scripts\sp\vehicle_treads::func_1324B();
  var_00 thread func_92D3();
  var_00 thread func_1F6E();

  if(isDefined(var_0.func_ED48))
    var_00 thread func_0B77::func_131C1();

  var_00 thread func_B6B7();

  if(isDefined(level.vehicle.func_1066A))
    level thread[[level.vehicle.func_1066A]](var_00);

  if(isDefined(var_0.script_team))
    var_00 setvehicleteam(var_0.script_team);

  var_00 thread func_5636();
  var_00 thread scripts\sp\vehicle_paths::beginlocationselection();

  if(isDefined(level.func_9334))
    var_11 = level.func_9334;
  else
    var_11 = 0;

  if(var_00 func_8BFC() && !var_11)
    var_00 thread func_1A93();

  if(var_00 _meth_83E2()) {
    var_0.veh_pathtype = "constrained";

    if(isDefined(var_0.func_EE7C))
      var_0.veh_pathtype = var_0.func_EE7C;
  }

  var_00 spawn_group();
  var_00 thread func_131FA();
}

func_A5CB(var_00) {
  if(!isDefined(level.vehicle.func_116CE.func_4E1C) || !isDefined(level.vehicle.func_116CE.func_4E1C[var_00])) {
    return;
  }
  if(isDefined(self.func_4E38))
    var_01 = self.func_4E38;
  else
    var_01 = level.vehicle.func_116CE.func_4E1C[var_00].func_B48B;

  if(isDefined(self.func_4E39))
    var_02 = self.func_4E39;
  else
    var_02 = level.vehicle.func_116CE.func_4E1C[var_00].func_B758;

  if(isDefined(level.vehicle.func_116CE.func_4E1C[var_00].delay))
    wait(level.vehicle.func_116CE.func_4E1C[var_00].delay);

  if(!isDefined(self)) {
    return;
  }
  if(level.vehicle.func_116CE.func_4E1C[var_00].func_2B19)
    level.player _meth_80D0(0);

  self radiusdamage(self.origin + level.vehicle.func_116CE.func_4E1C[var_00].offset, level.vehicle.func_116CE.func_4E1C[var_00].func_DCCA, var_01, var_02, self);

  if(level.vehicle.func_116CE.func_4E1C[var_00].func_2B19)
    level.player _meth_80D0(1);
}

func_131FA() {
  self endon("nodeath_thread");
  var_00 = 0;

  for(;;) {
    self waittill("death", var_01, var_02, var_03);

    if(isDefined(self.func_4C49))
      self thread[[self.func_4C49]]();

    if(!var_00) {
      var_00 = 1;

      if(isDefined(var_01) && isDefined(var_02)) {
        var_01 scripts\sp\player_stats::func_DEBD(self, var_02, var_03);

        if(isDefined(self.func_4D28))
          self.func_4D28 = undefined;
      }
    }

    self notify("clear_c4");

    if(isDefined(self.func_E7D2))
      self.func_E7D2 delete();

    if(isDefined(self.mgturret)) {
      scripts\engine\utility::array_levelthread(self.mgturret, ::func_129E4);
      self.mgturret = undefined;
    }

    if(!isDefined(self) || func_9BA8()) {
      if(isDefined(self.func_E4FB)) {
        foreach(var_05 in self.func_E4FB) {
          if(isDefined(var_05))
            var_05 delete();
        }
      }

      if(func_9BA8()) {
        self.func_E4FB = [];
        continue;
      }

      self notify("delete_destructible");
      return;
    }

    var_07 = undefined;

    if(isDefined(self.func_1322C))
      var_07 = self.func_1322C;
    else if(isDefined(level.vehicle.func_116CE.func_E7BA[self.classname]))
      var_07 = level.vehicle.func_116CE.func_E7BA[self.classname];

    if(isDefined(var_07))
      self stoprumble(var_7.func_E7BA);

    if(isDefined(level.vehicle.func_116CE.func_4E23[self.vehicletype]))
      thread[[level.vehicle.func_116CE.func_4E23[self.vehicletype]]]();

    scripts\engine\utility::array_levelthread(self.func_E4FB, scripts\sp\vehicle_aianim::func_876B, var_01, self.vehicletype);
    thread func_A5CB(self.classname);
    thread func_A5BF(self.classname);
    thread scripts\sp\vehicle_lights::func_A5F2(self.classname);
    func_5144();

    if(isDefined(level.vehicle.func_116CE.func_4E4E[self.classname]))
      thread func_F331(level.vehicle.func_116CE.func_4E4E[self.classname], level.vehicle.func_131C3[self.classname]);
    else if(isDefined(level.vehicle.func_116CE.func_4E4E[self.model]))
      thread func_F331(level.vehicle.func_116CE.func_4E4E[self.model], level.vehicle.func_131C3[self.model]);

    var_08 = func_13233(self.model, var_01, var_02);
    var_09 = self.origin;
    var_10 = undefined;

    if(isDefined(var_01)) {
      var_10 = self.origin - var_1.origin;
      var_10 = vectornormalize(var_10);
    }

    thread func_A5CC(self.classname);
    thread func_12FB(self.model, var_08, var_10);

    if(self.code_classname == "script_vehicle")
      thread func_A5EE(self.classname);

    if(isDefined(self.delete_on_death)) {
      wait 0.05;

      if(!isDefined(self.func_5958) && !self _meth_83E2())
        self disconnectpaths();

      _freezelookcontrols();
      wait 0.05;
      func_131D7(self.model);
      self delete();
      continue;
    }

    if(isDefined(self.func_736A)) {
      self notify("newpath");

      if(!isDefined(self.func_5958))
        self disconnectpaths();

      func_131FB();
      _freezelookcontrols();
      return;
    }

    func_131CE(self.model, var_01, var_02, var_08);

    if(!isDefined(self)) {
      return;
    }
    if(!var_08)
      var_09 = self.origin;

    if(isDefined(level.vehicle.func_116CE.func_4E02[self.classname]))
      earthquake(level.vehicle.func_116CE.func_4E02[self.classname].func_EB9C, level.vehicle.func_116CE.func_4E02[self.classname].func_5F36, var_09, level.vehicle.func_116CE.func_4E02[self.classname].radius);

    wait 0.5;

    if(func_9BA8()) {
      continue;
    }
    if(isDefined(self)) {
      while(isDefined(self.func_5960) && isDefined(self))
        wait 0.05;

      if(!isDefined(self)) {
        continue;
      }
      if(self _meth_83E2()) {
        while(isDefined(self) && self.veh_speed != 0)
          wait 1;

        if(!isDefined(self)) {
          return;
        }
        self disconnectpaths();
        self notify("kill_badplace_forever");
        self _meth_81D0();
        self notify("newpath");
        self _meth_83E8();
        return;
      } else
        _freezelookcontrols();

      if(self.func_B91F)
        self hide();
    }

    if(func_143E()) {
      self delete();
      continue;
    }
  }
}

_freezelookcontrols() {
  self _meth_80F8();
  scripts\engine\utility::delaythread(0.05, ::func_6A4A);
}

func_6A4A() {
  self notify("newpath");
  self.accuracy = undefined;
  self.func_247C = undefined;
  self.func_24D2 = undefined;
  self.func_275B = undefined;
  self.func_275C = undefined;
  self.func_4BF0 = undefined;
  self.func_4BF7 = undefined;
  self.func_4CF5 = undefined;
  self.func_5107 = undefined;
  self.func_6B9D = undefined;
  self.func_7F1A = undefined;
  self.func_8C2D = undefined;
  self.func_8CB6 = undefined;
  self.func_C36E = undefined;
  self.func_C36F = undefined;
  self.func_E7BE = undefined;
  self.func_E7C0 = undefined;
  self.func_E7C6 = undefined;
  self.func_ED10 = undefined;
  self.func_ED22 = undefined;
  self.script_disconnectpaths = undefined;
  self.script_linkname = undefined;
  self.func_EE50 = undefined;
  self.script_team = undefined;
  self.func_EEF2 = undefined;
  self.func_EEF8 = undefined;
  self.func_10707 = undefined;
  self.func_10708 = undefined;
  self.func_114CB = undefined;
  self.target = undefined;
  self.func_1152D = undefined;
  self.func_127FF = undefined;
  self.func_12800 = undefined;
  self.func_129DB = undefined;
  self.func_129DC = undefined;
  self.func_129DE = undefined;
  self.func_2756 = undefined;
  self.func_247E = undefined;
  self.func_2756 = undefined;
  self.func_E7CA = undefined;
  self.func_E7CB = undefined;
  self.func_E7D0 = undefined;
  self.func_E7D2 = undefined;
  self.func_E880 = undefined;
  self.func_EE5E = undefined;
  self.func_EEC8 = undefined;
  self.func_11659 = undefined;
  self.func_129DE = undefined;
  self.func_12A51 = undefined;
  self.func_12A52 = undefined;
  self.func_12A65 = undefined;
  self.func_12A7C = undefined;
  self.func_12A7D = undefined;
  self.unique_id = undefined;
  self.func_12BBC = undefined;
  self.func_12BD0 = undefined;
  self.func_1307E = undefined;
  self.func_1323C = undefined;
  self.func_136FC = undefined;
  self.func_13BB6 = undefined;
  self.func_C373 = undefined;
  self.func_ECE5 = undefined;
  self.func_13D02 = undefined;
  self.func_5971 = undefined;
  self.func_5958 = undefined;
  self.func_EDD1 = undefined;
  self.func_65DB = undefined;
  self.func_6A0B = undefined;
  self._meth_843F = undefined;
  self.vehicletype = undefined;
  self.func_13244 = undefined;
  self.func_6231 = undefined;
  self.func_ED12 = undefined;
}

func_143E() {
  return isDefined(self.func_4828) && self.func_4828 == 1;
}

func_131D7(var_00) {
  if(isDefined(self.func_5946) && self.func_5946) {
    return;
  }
  self notify("death_finished");

  if(!isDefined(self)) {
    return;
  }
  self glinton(#animtree);

  if(isDefined(level.vehicle.func_116CE.func_5BC3[var_00]))
    self clearanim(level.vehicle.func_116CE.func_5BC3[var_00], 0);

  if(isDefined(level.vehicle.func_116CE.func_5BC6[var_00]))
    self clearanim(level.vehicle.func_116CE.func_5BC6[var_00], 0);
}

func_13233(var_00, var_01, var_02) {
  if(!isDefined(self.func_1D63) || self.func_1D63 == 0) {
    if(isDefined(self.func_627C) && self.func_627C == 0)
      return 0;

    if(!isDefined(var_02))
      return 0;

    if(!(var_02 == "MOD_PROJECTILE" || var_02 == "MOD_PROJECTILE_SPLASH"))
      return 0;
  }

  if(isDefined(self.func_9B65) && self.func_9B65)
    return 1;

  return func_131ED(var_00);
}

func_131ED(var_00) {
  return isDefined(level.vehicle.func_116CE.func_131BC["rocket_death" + self.classname]) && isDefined(self.func_627C) && self.func_627C == 1;
}

func_131CE(var_00, var_01, var_02, var_03) {
  var_04 = "tank";

  if(self _meth_83E2())
    var_04 = "physics";
  else if(func_12F8())
    var_04 = "helicopter";
  else if(isDefined(self.func_4BF7))
    var_04 = "none";

  switch (var_04) {
    case "helicopter":
      thread func_8DA7(var_01, var_02, var_03);
      break;
    case "tank":
      if(!isDefined(self.func_E683))
        self vehicle_setspeed(0, 25);
      else {
        self vehicle_setspeed(8, 25);
        self waittill("deathrolloff");
        self vehicle_setspeed(0, 25);
      }

      self notify("deadstop");

      if(!isDefined(self.func_5958))
        self disconnectpaths();

      if(isDefined(self.func_114E0) && self.func_114E0 > 0)
        self waittill("animsdone");

      break;
    case "physics":
      self _meth_83EF();
      self notify("deadstop");

      if(!isDefined(self.func_5958))
        self disconnectpaths();

      if(isDefined(self.func_114E0) && self.func_114E0 > 0)
        self waittill("animsdone");

      break;
  }

  if(isDefined(level.vehicle.func_116CE.func_8B8F[var_00]) && level.vehicle.func_116CE.func_8B8F[var_00])
    self _meth_8080();

  if(func_12F8()) {
    if(isDefined(self.func_4828) && self.func_4828 == 1)
      self waittill("crash_done");
  } else {
    while(!func_9BA8() && isDefined(self) && self vehicle_getspeed() > 0)
      wait 0.1;
  }

  self notify("stop_looping_death_fx");
  func_131D7(var_00);
}

func_9BA8() {
  var_00 = 0;

  if(isDefined(self) && self.classname == "script_vehicle_corpse")
    var_00 = 1;

  return var_00;
}

func_F331(var_00, var_01) {
  if(isDefined(self.func_10268) && self.func_10268) {
    return;
  }
  if(isDefined(var_01) && var_01 > 0)
    wait(var_01);

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.func_412A))
    self clearanim( % root, 0);

  if(isDefined(self))
    self setModel(var_00);
}

func_8DA7(var_00, var_01, var_02) {
  if(isDefined(var_00) && isplayer(var_00))
    self.func_C720 = var_00;

  self.func_4828 = 1;

  if(!isDefined(self)) {
    return;
  }
  func_5389();

  if(!var_02)
    thread func_8DAB(var_00, var_01);
}

func_A60E(var_00) {
  foreach(var_02 in var_00) {
    if(!isalive(var_02)) {
      continue;
    }
    if(!isDefined(var_2.func_E500) && !isDefined(var_2.func_5BD6)) {
      continue;
    }
    if(isDefined(var_2.func_B14F))
      var_02 scripts\sp\utility::func_1101B();

    var_02 _meth_81D0();
  }
}

func_13225(var_00, var_01) {
  if(isDefined(self.func_1321D) && self.func_1321D != 0) {
    return;
  }
  self.health = 1;
  var_00 endon("death");
  self.func_2894 = 0.15;
  self waittill("death");
  var_00 notify("driver_died");
  func_A60E(var_01);
}

vehicle_caps() {
  self endon("death");
  self endon("enable_spline_path");
  waittillframeend;
  self.func_E4FB = scripts\sp\utility::func_DFEB(self.func_E4FB);

  if(self.func_E4FB.size) {
    scripts\engine\utility::array_thread(self.func_E4FB, ::func_13225, self, self.func_E4FB);
    scripts\engine\utility::waittill_either("veh_collision", "driver_died");
    func_A60E(self.func_E4FB);
    wait 0.25;
  }

  self notify("script_crash_vehicle");
  self _meth_83EF();
}

func_143F(var_00, var_01) {
  self endon("death");
  self notify("newpath");

  if(!isDefined(var_00))
    var_00 = 2;

  self setneargoalnotifydist(var_00);
  self sethoverparams(0, 0, 0);
  self getplayerkills();
  self settargetyaw(scripts\engine\utility::flat_angle(self.angles)[1]);

  if(isDefined(self.func_12BC2))
    _setvehgoalpos_wrap(scripts\sp\utility::func_864C(self.origin) + (0, 0, self.func_12BC2), 1);
  else
    _setvehgoalpos_wrap(scripts\sp\utility::func_864C(self.origin), 1);

  self waittill("goal");
}

func_13200(var_00, var_01) {
  self endon("death");

  if(!isDefined(level.vehicle.func_116CE.func_A7C5[self.classname])) {
    return;
  }
  var_02 = level.vehicle.func_116CE.func_A7C5[self.classname];

  foreach(var_04 in var_02)
  self give_attacker_kill_rewards(var_4.land, 1, 0.2, 1);

  if(!var_01) {
    return;
  }
  if(isDefined(var_00))
    self waittill("unloaded");
  else
    self waittill("continuepath");

  foreach(var_04 in var_02) {
    self clearanim(var_4.land, 0);
    self give_attacker_kill_rewards(var_4.func_11472, 1, 0.2, 1);
  }
}

func_13201(var_00, var_01) {
  return func_143F(var_00, var_01);
}

func_10809(var_00) {
  if(level.func_650D.size >= 8) {
    return;
  }
  var_01 = scripts\sp\utility::func_10808();

  if(isDefined(var_00))
    var_01 _meth_83F4(var_00);

  var_01 thread vehicle_caps();
  var_01 endon("death");
  var_1.func_5971 = 1;
  var_01 scripts\sp\vehicle_paths::setsuit(var_01);
  var_01 func_AB23();
}

func_AB23() {
  self endon("script_crash_vehicle");
  scripts\engine\utility::waittill_either("enable_spline_path", "reached_end_node");
  var_00 = func_7B03(self.origin);

  if(isDefined(level.func_5BC2))
    var_00 thread[[level.func_5BC2]](self);
}

func_7B03(var_00) {
  var_00 = (var_0[0], var_0[1], 0);
  var_01 = scripts\engine\utility::get_array_of_closest(var_00, level.func_103D0);
  var_02 = [];

  for(var_03 = 0; var_03 < 3; var_3++)
    var_2[var_03] = var_1[var_03];

  foreach(var_05 in level.func_103D0) {
    foreach(var_07 in var_02) {
      if(var_07 == var_05)
        return var_07;
    }
  }
}

func_13804(var_00) {
  var_01 = 12;
  var_02 = 400;
  var_03 = gettime() + var_02;

  while(isDefined(self)) {
    if(abs(self.angles[0]) > var_01 || abs(self.angles[2]) > var_01)
      var_03 = gettime() + var_02;

    if(gettime() > var_03) {
      break;
    }
    wait 0.05;
  }
}

func_143C() {
  if(!isDefined(self.func_ED12)) {
    return;
  }
  _createnavrepulsor(self.unique_id + "vehicle_badplace", -1, self, "allies", "axis");
}

func_1446(var_00) {
  self notify("unloading");
  var_01 = [];

  if(scripts\sp\utility::func_65DF("no_riders_until_unload")) {
    scripts\sp\utility::func_65E1("no_riders_until_unload");
    var_01 = func_10805(var_00);

    foreach(var_03 in var_01)
    scripts\sp\utility::func_106ED(var_03);

    waittillframeend;
  }

  if(isDefined(var_00))
    self.func_12BBC = var_00;

  foreach(var_06 in self.func_E4FB) {
    if(isalive(var_06))
      var_06 notify("unload");
  }

  var_01 = scripts\sp\vehicle_aianim::func_1F74("unload");
  var_08 = level.vehicle.func_116CE.func_12BCF[self.classname];

  if(isDefined(var_08)) {
    var_01 = [];
    var_09 = scripts\sp\vehicle_aianim::func_7D2F();

    foreach(var_12, var_11 in self.func_E4FB) {
      if(isDefined(var_9[var_11.func_1321D]))
        var_1[var_1.size] = var_11;
    }
  }

  return var_01;
}

_setvehgoalpos_wrap(var_00, var_01) {
  if(self.health <= 0) {
    return;
  }
  if(isDefined(self.func_C737))
    var_00 = var_00 + (0, 0, self.func_C737);

  self setvehgoalpos(var_00, var_01);
}

func_8DAB(var_00, var_01) {
  self endon("in_air_explosion");

  if(isDefined(self.func_CA16))
    var_02 = self.func_CA16;
  else {
    var_03 = func_7D31();
    var_02 = scripts\engine\utility::getclosest(self.origin, var_03);
  }

  var_2.claimed = 1;
  self notify("newpath");
  self notify("deathspin");
  var_04 = 0;
  var_05 = 0;

  if(isDefined(var_2.script_parameters) && var_2.script_parameters == "direct")
    var_05 = 1;

  if(isDefined(self.func_8D3C)) {
    var_05 = 0;
    var_04 = self.func_8D3C;
  }

  if(var_05) {
    var_06 = 60;
    self vehicle_setspeed(var_06, 15, 10);
    self setneargoalnotifydist(var_2.radius);
    self setvehgoalpos(var_2.origin, 0);
    thread func_8DA9(var_2.origin, var_06);
    scripts\engine\utility::waittill_any("goal", "near_goal");
    func_8DAC(var_02);
  } else {
    var_07 = (var_2.origin[0], var_2.origin[1], self.origin[2] + var_04);

    if(isDefined(self.func_8D3D)) {
      var_07 = self.origin + self.func_8D3D * self vehicle_getvelocity();
      var_07 = (var_7[0], var_7[1], var_7[2] + var_04);
    }

    self vehicle_setspeed(40, 10, 10);
    self setneargoalnotifydist(300);
    self setvehgoalpos(var_07, 1);
    thread func_8DA9(var_07, 40);
    var_08 = "blank";

    while(var_08 != "death") {
      var_08 = scripts\engine\utility::waittill_any("goal", "near_goal", "death");

      if(!isDefined(var_08) && !isDefined(self)) {
        var_2.claimed = undefined;
        self notify("crash_done");
        return;
      } else
        var_08 = "death";
    }

    self setvehgoalpos(var_2.origin, 0);
    self waittill("goal");
    func_8DAC(var_02);
  }

  var_2.claimed = undefined;
  self notify("stop_crash_loop_sound");
  self notify("crash_done");
}

func_8DAC(var_00) {
  self endon("death");

  while(isDefined(var_0.target)) {
    var_00 = scripts\engine\utility::getstruct(var_0.target, "targetname");
    var_01 = 56;

    if(isDefined(var_0.radius))
      var_01 = var_0.radius;

    self setneargoalnotifydist(var_01);
    self setvehgoalpos(var_0.origin, 0);
    scripts\engine\utility::waittill_any("goal", "near_goal");
  }
}

func_8DA9(var_00, var_01) {
  self endon("crash_done");
  self getplayerkillstreakcombatmode();
  var_02 = 0;

  if(isDefined(self.func_D831)) {
    var_02 = self.func_D831;

    if(self.func_D831 < 0) {
      var_03 = [1, 2, 2];
      var_04 = 5;
      var_05 = randomint(var_04);
      var_06 = 0;

      foreach(var_09, var_08 in var_03) {
        var_06 = var_06 + var_08;

        if(var_05 < var_06) {
          var_02 = var_09;
          break;
        }
      }
    }
  }

  switch (var_02) {
    case 1:
      thread func_8DAE();
      break;
    case 2:
      thread func_8DA8(var_00, var_01);
      break;
    case 3:
      thread func_8DB0();
      break;
    case 0:
    default:
      thread func_8DAD();
      break;
  }
}

func_8DB0() {
  self notify("crash_done");
  self notify("in_air_explosion");
}

func_8DA8(var_00, var_01) {
  self endon("crash_done");
  self getplayerkillstreakcombatmode();
  self setmaxpitchroll(randomintrange(20, 90), randomintrange(5, 90));
  self setyawspeed(400, 100, 100);
  var_02 = 90 * randomintrange(-2, 3);

  for(;;) {
    var_03 = var_00 - self.origin;
    var_04 = vectortoyaw(var_03);
    var_04 = var_04 + var_02;
    self settargetyaw(var_04);
    wait 0.1;
  }
}

func_8DAE() {
  self endon("crash_done");
  self getplayerkillstreakcombatmode();
  self setyawspeed(400, 100, 100);
  var_00 = randomint(2);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    var_01 = randomintrange(20, 120);

    if(var_00)
      self settargetyaw(self.angles[1] + var_01);
    else
      self settargetyaw(self.angles[1] - var_01);

    var_00 = 1 - var_00;
    var_02 = randomfloatrange(0.5, 1.0);
    wait(var_02);
  }
}

func_8DAD() {
  self endon("crash_done");
  self getplayerkillstreakcombatmode();
  self setyawspeed(400, 100, 100);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    var_00 = randomintrange(90, 120);
    self settargetyaw(self.angles[1] + var_00);
    wait 0.5;
  }
}

func_7D31() {
  var_00 = [];
  level.vehicle.func_8DAA = scripts\engine\utility::array_removeundefined(level.vehicle.func_8DAA);

  foreach(var_02 in level.vehicle.func_8DAA) {
    if(isDefined(var_2.claimed)) {
      continue;
    }
    var_0[var_0.size] = var_02;
  }

  return var_00;
}

func_5389() {
  if(!isDefined(self.func_6B9D)) {
    return;
  }
  if(!self.func_6B9D.size) {
    return;
  }
  var_00 = getarraykeys(self.func_6B9D);

  for(var_01 = 0; var_01 < var_0.size; var_1++)
    self.func_6B9D[var_0[var_01]] unlink();
}

func_131FB() {
  self notify("kill_badplace_forever");
}

func_A5EE(var_00) {
  if(isDefined(level.vehicle.func_116CE.func_4E12[var_00])) {
    self.func_5960 = 1;
    wait(level.vehicle.func_116CE.func_4E12[var_00].delay);
  }

  if(!isDefined(self)) {
    return;
  }
  self gettimeremaining(self.origin + (23, 33, 64), 3);
  wait 2;

  if(!isDefined(self)) {
    return;
  }
  self.func_5960 = undefined;
}

isdestroyed() {
  if(!isDefined(self))
    return 0;

  return isDefined(self.func_00ED);
}

func_12FC(var_00, var_01) {
  if(isDefined(var_00) && isDefined(var_01)) {
    var_02 = self getentityvelocity();
    var_02 = vectornormalize(var_02);
    var_00 = vectornormalize(var_00);
    var_03 = vectorlerp(var_02, var_00, var_01);
    return var_03;
  } else
    return undefined;
}

func_12FB(var_00, var_01, var_02) {
  if(isdestroyed() || isDefined(self.func_9B65) && self.func_9B65) {
    return;
  }
  level notify("vehicle_explosion", self.origin);
  self notify("explode", self.origin);

  if(isDefined(self.func_9310) && self.func_9310) {
    return;
  }
  var_03 = self.vehicletype;
  var_04 = self.classname;

  if(var_01)
    var_04 = "rocket_death" + var_04;

  foreach(var_06 in level.vehicle.func_116CE.func_131BC[var_04])
  thread func_A5E1(var_00, var_06, var_03, var_02);
}

func_A5E1(var_00, var_01, var_02, var_03) {
  if(isDefined(var_1.func_136A1)) {
    if(var_1.func_136A1 >= 0)
      wait(var_1.func_136A1);
    else
      self waittill("death_finished");
  }

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_1.func_C174))
    self notify(var_1.func_C174);

  if(isDefined(var_1.func_F1EA))
    scripts\engine\utility::delaycall(var_1.func_F1EA, ::delete);

  if(isDefined(var_1.effect)) {
    if(var_1.func_2A4E && !isDefined(self.delete_on_death)) {
      if(isDefined(var_1.tag)) {
        if(isDefined(var_1.func_10E6A) && var_1.func_10E6A == 1)
          thread func_B03F(var_1.effect, var_1.delay, var_1.tag);
        else
          thread func_D4C4(var_1.effect, var_1.delay, var_1.tag);
      } else {
        var_04 = self.origin + (0, 0, 100) - self.origin;
        playFX(var_1.effect, self.origin, var_04);
      }
    } else if(isDefined(var_1.tag)) {
      var_04 = func_12FC(var_03, var_1.func_24DF);

      if(isDefined(var_04)) {
        var_05 = func_4E49();
        playFX(var_1.effect, var_05 gettagorigin(var_1.tag), var_04);

        if(isDefined(var_1.func_DFEC))
          var_05 scripts\engine\utility::delaycall(var_1.func_DFEC, ::delete);
      } else {
        playFXOnTag(var_1.effect, func_4E49(), var_1.tag);

        if(isDefined(var_1.func_DFEC))
          func_4E49() scripts\engine\utility::delaycall(var_1.func_DFEC, ::delete);
      }
    } else {
      var_04 = func_12FC(var_03, var_1.func_24DF);

      if(isDefined(var_04))
        playFX(var_1.effect, self.origin, var_04);
      else {
        var_04 = self.origin + (0, 0, 100) - self.origin;
        playFX(var_1.effect, self.origin, var_04);
      }
    }
  }

  if(isDefined(var_1.sound) && !isDefined(self.delete_on_death)) {
    if(var_1.func_312E)
      thread func_4E05(var_1.sound);
    else
      scripts\engine\utility::play_sound_in_space(var_1.sound);
  }
}

func_B03F(var_00, var_01, var_02) {
  self endon("stop_looping_death_fx");

  while(isDefined(self)) {
    playFXOnTag(var_00, func_4E49(), var_02);
    wait(var_01);
  }
}

func_4E05(var_00) {
  thread scripts\sp\utility::play_loop_sound_on_tag(var_00, undefined, 0, 1);
  scripts\engine\utility::waittill_any("fire_extinguish", "stop_crash_loop_sound");

  if(!isDefined(self)) {
    return;
  }
  self notify("stop sound" + var_00);
}

func_4E49() {
  if(isDefined(self.func_4E0A) && self.func_4E0A)
    return self;

  if(!isDefined(self.func_4E49)) {
    var_00 = spawn("script_model", (0, 0, 0));
    var_00 setModel(self.model);
    var_0.origin = self.origin;
    var_0.angles = self.angles;
    var_00 notsolid();
    var_00 hide();
    var_00 linkto(self);
    self.func_4E49 = var_00;
  } else
    self.func_4E49 setModel(self.model);

  return self.func_4E49;
}

func_D4C4(var_00, var_01, var_02) {
  var_03 = spawn("script_origin", self.origin);
  self endon("fire_extinguish");
  thread func_D4C5(var_02, var_03);

  for(;;) {
    playFX(var_00, var_3.origin, var_3.func_12F93);
    wait(var_01);
  }
}

func_D4C5(var_00, var_01) {
  var_1.angles = self gettagangles(var_00);
  var_1.origin = self gettagorigin(var_00);
  var_1.func_7337 = anglesToForward(var_1.angles);
  var_1.func_12F93 = anglestoup(var_1.angles);

  while(isDefined(self) && self.code_classname == "script_vehicle" && self vehicle_getspeed() > 0) {
    var_1.angles = self gettagangles(var_00);
    var_1.origin = self gettagorigin(var_00);
    var_1.func_7337 = anglesToForward(var_1.angles);
    var_1.func_12F93 = anglestoup(var_1.angles);
    wait 0.05;
  }
}

func_A5BF(var_00) {
  if(!isDefined(level.vehicle.func_116CE.func_4DFC[var_00])) {
    return;
  }
  var_01 = level.vehicle.func_116CE.func_4DFC[var_00];

  if(isDefined(var_1.delay))
    wait(var_1.delay);

  if(!isDefined(self)) {
    return;
  }
  badplace_cylinder("vehicle_kill_badplace", var_1.func_5F36, self.origin, var_1.radius, var_1.height, var_1.func_115A4, var_1.func_115A5);
}

func_129E4(var_00) {
  if(isDefined(self)) {
    if(isDefined(var_0.func_51AD))
      wait(var_0.func_51AD);
  }

  if(isDefined(var_00))
    var_00 delete();
}

func_12B8(var_00, var_01) {
  var_02 = [];

  if(isDefined(var_00) && isDefined(var_01)) {
    var_03 = 1;
    var_04 = getEntArray(var_00, var_01);
  } else {
    var_03 = 0;
    var_04 = getEntArray("script_vehicle", "code_classname");
  }

  foreach(var_06 in var_04) {
    if(var_03 && var_6.code_classname != "script_vehicle") {
      continue;
    }
    if(_isspawner(var_06))
      var_2[var_2.size] = var_06;
  }

  return var_02;
}

func_1322D(var_00) {
  foreach(var_02 in self.func_E4FB) {
    if(isai(var_02)) {
      var_02 scripts\sp\utility::func_F3B5(var_00);
      continue;
    }

    if(isDefined(var_2.spawner)) {
      var_2.spawner.func_EDAD = var_00;
      continue;
    }
  }
}

func_12E33(var_00) {
  if(var_0.func_12E3C == gettime())
    return var_0.func_10F82;

  var_0.func_12E3C = gettime();

  if(var_0.func_10F83) {
    var_01 = clamp(0 - var_0.angles[2], 0 - var_0.func_10F85, var_0.func_10F85) / var_0.func_10F85;

    if(isDefined(var_0.func_AAF3) && var_0.func_AAF3) {
      var_02 = var_00 _meth_83DE();
      var_02 = var_02 * -1.0;
      var_01 = var_01 + var_02;

      if(var_01 != 0) {
        var_03 = 1.0 / abs(var_01);

        if(var_03 < 1)
          var_01 = var_01 * var_03;
      }
    }

    var_04 = var_01 - var_0.func_10F82;

    if(var_04 != 0) {
      var_05 = var_0.func_10F84 / abs(var_04);

      if(var_05 < 1)
        var_04 = var_04 * var_05;

      var_0.func_10F82 = var_0.func_10F82 + var_04;
    }
  } else
    var_0.func_10F82 = 0;

  return var_0.func_10F82;
}

func_79D5(var_00) {
  return scripts\engine\utility::getstruct(var_00, "targetname");
}

func_79D3(var_00) {
  var_01 = getEntArray(var_00, "targetname");

  if(isDefined(var_01) && var_1.size > 0)
    return var_1[randomint(var_1.size)];

  return undefined;
}

func_79D7(var_00) {
  return getvehiclenode(var_00, "targetname");
}

func_F471(var_00) {
  var_01 = getent(var_0.script_linkto, "script_linkname");

  if(!isDefined(var_01)) {
    return;
  }
  self setlookatent(var_01);
  self.func_F472 = 1;
}

func_4CFC() {
  level.func_2184 = 0;
  self.func_56DE = 0;
  thread func_4CFE();

  while(isDefined(self)) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04);

    if(!isplayer(var_01)) {
      continue;
    }
    if(isDefined(self.func_8BA9)) {
      continue;
    }
    var_04 = tolower(var_04);

    switch (var_04) {
      case "bullet":
      case "mod_rifle_bullet":
      case "mod_pistol_bullet":
        if(!level.func_2184) {
          if(isDefined(level.func_11829) && level.func_11829 > 0) {
            break;
          }
          level.func_2184 = 1;
          self.func_56DE = 1;
          var_01 scripts\sp\utility::func_56BA("invulerable_bullets");
          wait 4;
          level.func_2184 = 0;

          if(isDefined(self))
            self.func_56DE = 0;

          break;
        }
    }
  }
}

func_4CFD() {
  level.func_2184 = 0;
  self.func_56DE = 0;
  thread func_4CFE();

  while(isDefined(self)) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04);

    if(!isplayer(var_01)) {
      continue;
    }
    if(isDefined(self.func_8BA9)) {
      continue;
    }
    var_04 = tolower(var_04);

    switch (var_04) {
      case "mod_grenade_splash":
      case "mod_grenade":
      case "bullet":
      case "mod_rifle_bullet":
      case "mod_pistol_bullet":
        if(!level.func_2184) {
          if(isDefined(level.func_11829) && level.func_11829 > 0) {
            break;
          }
          level.func_2184 = 1;
          self.func_56DE = 1;

          if(var_04 == "mod_grenade" || var_04 == "mod_grenade_splash")
            var_01 scripts\sp\utility::func_56BA("invulerable_frags");
          else
            var_01 scripts\sp\utility::func_56BA("invulerable_bullets");

          wait 4;
          level.func_2184 = 0;

          if(isDefined(self))
            self.func_56DE = 0;

          break;
        }
    }
  }
}

func_4CFE() {
  self waittill("death");

  if(self.func_56DE)
    level.func_2184 = 0;
}

func_1A93(var_00) {
  self endon("death");
  self endon("death_finished");
  self notify("stop_kicking_up_dust");
  self endon("stop_kicking_up_dust");
  var_01 = 2000;

  if(isDefined(level.func_126F3))
    var_01 = level.func_126F3;

  var_02 = 80 / var_01;
  var_03 = 0.5;

  if(func_12F6())
    var_03 = 0.15;

  var_04 = self;

  if(isDefined(var_00))
    var_04 = var_00;

  var_05 = 3;

  for(;;) {
    wait(var_03);

    if(1) {
      if(isDefined(self.func_55A4) && self.func_55A4) {
        continue;
      }
      if(isDefined(self.func_126F3))
        var_01 = self.func_126F3;

      var_06 = anglestoup(var_4.angles) * -1;
      var_07 = undefined;
      var_5++;

      if(var_05 > 3) {
        var_05 = 3;
        var_07 = scripts\engine\trace::ray_trace(var_4.origin, var_4.origin + var_06 * var_01, var_04, undefined, 1);
      }

      if(var_7["fraction"] == 1 || var_7["fraction"] < var_02) {
        continue;
      }
      var_08 = distance(var_4.origin, var_7["position"]);
      var_09 = func_7D53(self, var_07, var_06, var_08);

      if(!isDefined(var_09)) {
        continue;
      }
      var_03 = (var_08 - 350) / (var_01 - 350) * 0.1 + 0.05;
      var_03 = max(var_03, 0.05);

      if(!isDefined(var_07)) {
        continue;
      }
      if(!isDefined(var_7["position"])) {
        continue;
      }
      var_10 = var_7["position"];
      var_11 = var_7["normal"];
      var_08 = vectordot(var_10 - var_4.origin, var_11);
      var_12 = var_4.origin + (0, 0, var_08);
      var_13 = var_10 - var_12;

      if(isDefined(self.func_126F4))
        var_13 = var_10 - level.player.origin;

      if(vectordot(var_7["normal"], (0, 0, 1)) == -1) {
        continue;
      }
      if(length(var_13) < 1)
        var_13 = var_4.angles + (0, 180, 0);

      playFX(var_09, var_10, var_11, var_13);
    }
  }
}

func_7D53(var_00, var_01, var_02, var_03) {
  var_04 = var_1["surfacetype"];
  var_05 = undefined;
  var_06 = vectordot((0, 0, -1), var_02);

  if(var_06 >= 0.97)
    var_05 = undefined;
  else if(var_06 >= 0.92)
    var_05 = "_bank";
  else
    var_05 = "_bank_lg";

  return func_7D52(var_0.classname, var_04, var_05);
}

func_7D52(var_00, var_01, var_02) {
  if(isDefined(var_02)) {
    var_03 = var_01 + var_02;

    if(!isDefined(level.vehicle.func_116CE.func_112D9[var_00][var_03]) && var_01 != "default")
      return func_7D52(var_00, "default", var_02);
    else
      return level.vehicle.func_116CE.func_112D9[var_00][var_03];
  }

  return func_7D44(var_00, var_01);
}

func_7D44(var_00, var_01) {
  if(!isDefined(level.vehicle.func_116CE.func_112D9[var_00][var_01]) && var_01 != "default")
    return func_7D44(var_00, "default");
  else
    return level.vehicle.func_116CE.func_112D9[var_00][var_01];

  return undefined;
}

func_C018() {
  return func_12F8() || func_12F6();
}

func_12F8() {
  return isDefined(level.vehicle.func_116CE.func_8DB1[self.vehicletype]);
}

func_12F6() {
  return isDefined(level.vehicle.func_116CE.func_1AE5[self.vehicletype]);
}

func_8BFC() {
  if(!func_12F8() && !func_12F6())
    return 0;

  return 1;
}

func_8BFD() {
  if(!isDefined(self.vehicletype))
    return 0;

  if(self.vehicletype == "cobra")
    return 1;

  if(self.vehicletype == "cobra_player")
    return 1;

  if(self.vehicletype == "viper")
    return 1;

  return 0;
}

func_5636() {
  self endon("death");
  var_00 = 0;

  if(isDefined(self.script_disconnectpaths) && !self.script_disconnectpaths)
    var_00 = 1;

  if(var_00) {
    self.func_5958 = 1;
    return;
  }

  wait(randomfloat(1));

  while(isDefined(self)) {
    if(self vehicle_getspeed() < 1) {
      if(!isDefined(self.func_5958))
        self disconnectpaths();
      else {}

      self notify("speed_zero_path_disconnect");

      while(self vehicle_getspeed() < 1) {
        if(isDefined(self.func_5958) && self.func_5958) {
          break;
        }
        wait 0.05;
      }
    }

    self connectpaths();
    wait 1;
  }
}

func_B6B7() {
  var_00 = self.classname;

  if(isDefined(self.func_EE5E) && self.func_EE5E > 0) {
    return;
  }
  if(!isDefined(level.vehicle.func_116CE.mgturret[var_00])) {
    return;
  }
  var_01 = 0;

  if(isDefined(self.func_EE14))
    var_01 = self.func_EE14;

  var_02 = level.vehicle.func_116CE.mgturret[var_00];

  if(!isDefined(var_02)) {
    return;
  }
  var_03 = isDefined(self.script_noteworthy) && self.script_noteworthy == "onemg";
  var_04 = "";

  if(isDefined(self.func_EEF9))
    var_04 = self.func_EEF9;

  foreach(var_08, var_06 in var_02) {
    if(isDefined(var_6.func_DE46) && !issubstr(var_04, var_6.func_DE46)) {
      continue;
    }
    var_07 = spawnturret("misc_turret", (0, 0, 0), var_6.info);

    if(isDefined(var_6.func_C367))
      var_07 linkto(self, var_6.tag, var_6.func_C367, (0, -1 * var_01, 0));
    else
      var_07 linkto(self, var_6.tag, (0, 0, 0), (0, -1 * var_01, 0));

    var_07 setModel(var_6.model);
    var_7.angles = self.angles;
    var_7.func_9FF0 = 1;
    var_7.func_C841 = self;
    var_7.script_team = self.script_team;
    var_07 thread scripts\sp\mgturret::func_32B7();
    var_07 makeunusable();
    func_F5D8(var_07);
    level thread scripts\sp\mgturret::func_B6A7(var_07, scripts\sp\utility::func_7E72());

    if(isDefined(self.func_ED98))
      var_7.func_ED98 = self.func_ED98;

    if(isDefined(var_6.func_51AD))
      var_7.func_51AD = var_6.func_51AD;

    if(isDefined(var_6.func_01D2))
      var_7.func_01D2 = var_6.func_01D2;

    if(isDefined(var_6.func_5035))
      var_07 setdefaultdroppitch(var_6.func_5035);

    if(isDefined(var_6.func_DE46))
      var_7.func_DE46 = var_6.func_DE46;

    self.mgturret[var_08] = var_07;

    if(var_03) {
      break;
    }
  }

  foreach(var_11, var_07 in self.mgturret) {
    var_10 = level.vehicle.func_116CE.mgturret[var_00][var_11].func_5041;

    if(isDefined(var_10))
      var_07 func_12A29(var_10);
  }

  if(!isDefined(self.func_EEF8))
    self.func_EEF8 = 1;

  if(self.func_EEF8 == 0)
    thread func_134C();
  else {
    self.func_EEF8 = 1;
    thread func_134D();
  }
}

func_12A29(var_00) {
  self.func_5041 = var_00;
}

func_F5D8(var_00) {
  switch (self.script_team) {
    case "friendly":
    case "allies":
      var_00 setturretteam("allies");
      break;
    case "enemy":
    case "axis":
      var_00 setturretteam("axis");
      break;
    case "team3":
      var_00 setturretteam("team3");
      break;
    default:
      break;
  }
}

func_1F6E() {
  self endon("suspend_drive_anims");

  if(!isDefined(self.func_13D02))
    self.func_13D02 = 1;

  var_00 = self.model;
  var_01 = -1;
  var_02 = undefined;
  self glinton(#animtree);

  if(!isDefined(level.vehicle.func_116CE.func_5BC3[var_00])) {
    return;
  }
  if(!isDefined(level.vehicle.func_116CE.func_5BC6[var_00]))
    level.vehicle.func_116CE.func_5BC6[var_00] = level.vehicle.func_116CE.func_5BC3[var_00];

  self endon("death");
  var_03 = level.vehicle.func_116CE.func_5BC5[var_00];
  var_04 = 1.0;

  if(isDefined(level.vehicle.func_116CE.func_5BC4) && isDefined(level.vehicle.func_116CE.func_5BC4[var_00]))
    var_04 = level.vehicle.func_116CE.func_5BC4[var_00];

  var_05 = self.func_13D02;
  var_06 = level.vehicle.func_116CE.func_5BC3[var_00];

  for(;;) {
    if(!var_03) {
      if(isDefined(self.func_112FB)) {
        wait 0.05;
        continue;
      }

      self give_attacker_kill_rewards(level.vehicle.func_116CE.func_5BC3[var_00], 1, 0.2, var_04);
      return;
    }

    var_07 = self vehicle_getspeed();

    if(var_05 != self.func_13D02) {
      var_08 = 0;

      if(self.func_13D02) {
        var_06 = level.vehicle.func_116CE.func_5BC3[var_00];
        var_08 = 1 - func_7B21(level.vehicle.func_116CE.func_5BC6[var_00]);
        self clearanim(level.vehicle.func_116CE.func_5BC6[var_00], 0);
      } else {
        var_06 = level.vehicle.func_116CE.func_5BC6[var_00];
        var_08 = 1 - func_7B21(level.vehicle.func_116CE.func_5BC3[var_00]);
        self clearanim(level.vehicle.func_116CE.func_5BC3[var_00], 0);
      }

      var_02 = 0.01;

      if(var_02 >= 1 || var_02 == 0)
        var_02 = 0.01;

      var_05 = self.func_13D02;
    }

    var_09 = var_07 / var_03;

    if(var_09 != var_01) {
      self give_attacker_kill_rewards(var_06, 1, 0.05, var_09);
      var_01 = var_09;
    }

    if(isDefined(var_02)) {
      self _meth_82B0(var_06, var_02);
      var_02 = undefined;
    }

    wait 0.05;
  }
}

func_FA7A(var_00) {
  var_01 = [];

  foreach(var_03 in var_00) {
    if(_isspawner(var_03))
      continue;
    else
      var_1[var_1.size] = var_03;
  }

  foreach(var_06 in var_01)
  thread func_131F6(var_06);
}

func_13203() {
  var_00 = self.classname;

  if(!isDefined(level.vehicle.func_116CE.func_AC4A) || !isDefined(level.vehicle.func_116CE.func_AC4A[var_00]))
    wait 2;

  if(isDefined(self.func_EEC8))
    self.health = self.func_EEC8;
  else if(level.vehicle.func_116CE.func_AC4A[var_00] == -1)
    return;
  else if(isDefined(level.vehicle.func_116CE.func_AC4D[var_00]) && isDefined(level.vehicle.func_116CE.func_AC4C[var_00]))
    self.health = randomint(level.vehicle.func_116CE.func_AC4C[var_00] - level.vehicle.func_116CE.func_AC4D[var_00]) + level.vehicle.func_116CE.func_AC4D[var_00];
  else
    self.health = level.vehicle.func_116CE.func_AC4A[var_00];
}

func_7B21(var_00) {
  var_01 = self islegacyagent(var_00);
  var_02 = getanimlength(var_00);

  if(var_01 == 0)
    return 0;

  return self islegacyagent(var_00) / getanimlength(var_00);
}

func_112FA() {
  self notify("suspend_drive_anims");
  var_00 = self.model;
  self clearanim(level.vehicle.func_116CE.func_5BC3[var_00], 0);
  self clearanim(level.vehicle.func_116CE.func_5BC6[var_00], 0);
}

func_92D3() {
  self glinton(#animtree);

  if(!isDefined(level.vehicle.func_116CE.func_92D0[self.model])) {
    return;
  }
  foreach(var_01 in level.vehicle.func_116CE.func_92D0[self.model])
  self give_attacker_kill_rewards(var_01);
}

func_1322A() {
  self endon("kill_rumble_forever");
  var_00 = self.classname;
  var_01 = undefined;

  if(isDefined(self.func_1322C))
    var_01 = self.func_1322C;
  else if(isDefined(level.vehicle.func_116CE.func_E7BA[var_00]))
    var_01 = level.vehicle.func_116CE.func_E7BA[var_00];

  if(!isDefined(var_01)) {
    return;
  }
  var_02 = var_1.radius * 2;
  var_03 = -1 * var_1.radius;
  var_04 = spawn("trigger_radius", self.origin + (0, 0, var_03), 0, var_1.radius, var_02);
  var_04 getrankxp();
  var_04 linkto(self);
  self.func_E7D2 = var_04;
  self endon("death");

  if(!isDefined(self.func_E7D0))
    self.func_E7D0 = 1;

  if(isDefined(var_1.func_EB9C))
    self.func_E7CB = var_1.func_EB9C;
  else
    self.func_E7CB = 0.15;

  if(isDefined(var_1.func_5F36))
    self.func_E7C0 = var_1.func_5F36;
  else
    self.func_E7C0 = 4.5;

  if(isDefined(var_1.radius))
    self.func_E7C6 = var_1.radius;
  else
    self.func_E7C6 = 600;

  if(isDefined(var_1.func_28AE))
    self.func_E7BE = var_1.func_28AE;
  else
    self.func_E7BE = 1;

  if(isDefined(var_1.func_DCA5))
    self.func_E7CA = var_1.func_DCA5;
  else
    self.func_E7CA = 1;

  var_4.radius = self.func_E7C6;

  for(;;) {
    var_04 waittill("trigger");

    if(self vehicle_getspeed() == 0 && !isDefined(self.func_72DB) || !self.func_E7D0) {
      wait 0.1;
      continue;
    }

    self _meth_8244(var_1.func_E7BA);

    if(isDefined(self.vehicletype)) {
      var_05 = self.vehicletype + "_rumble_sfx";

      if(soundexists(var_05))
        level.player playSound(var_05);
    }

    while(level.player istouching(var_04) && self.func_E7D0 && (self vehicle_getspeed() > 0 || isDefined(self.func_72DB))) {
      earthquake(self.func_E7CB, self.func_E7C0, self.origin, self.func_E7C6);
      wait(self.func_E7BE + randomfloat(self.func_E7CA));
    }

    self stoprumble(var_1.func_E7BA);
  }
}

func_1322F() {
  var_00 = self.classname;

  if(!isDefined(self.script_team) && isDefined(level.vehicle.func_116CE.team[var_00]))
    self.script_team = level.vehicle.func_116CE.team[var_00];
}

func_131EC() {
  self endon("death");
  var_00 = self.vehicletype;

  if(!scripts\sp\utility::func_65DF("unloaded"))
    scripts\sp\utility::func_65E0("unloaded");
}

func_7D48(var_00) {
  var_01 = getvehiclenode(var_00, "targetname");

  if(!isDefined(var_01))
    var_01 = getent(var_00, "targetname");
  else if(func_12F8()) {}

  if(!isDefined(var_01))
    var_01 = scripts\engine\utility::getstruct(var_00, "targetname");

  return var_01;
}

func_8B7F() {
  return isDefined(level.vehicle.func_116CE.func_7448[self.vehicletype]);
}

func_85DA(var_00) {
  if(!isDefined(self.func_EDD3))
    return 0;

  var_00 = tolower(var_00);

  if(!isDefined(var_00) || !issubstr(var_00, "grenade"))
    return 0;

  if(self.func_EDD3)
    return 1;
  else
    return 0;
}

func_324F(var_00) {
  if(!isDefined(self.func_ED22))
    return 0;

  var_00 = tolower(var_00);

  if(!isDefined(var_00) || !issubstr(var_00, "bullet") || issubstr(var_00, "explosive"))
    return 0;

  if(self.func_ED22)
    return 1;
  else
    return 0;
}

func_69F8(var_00) {
  if(!isDefined(self.func_ED87))
    return 0;

  var_00 = tolower(var_00);

  if(!isDefined(var_00) || !issubstr(var_00, "explosive"))
    return 0;

  if(self.func_ED87)
    return 1;
  else
    return 0;
}

func_13234(var_00, var_01) {
  return !isDefined(var_00) && self.script_team != "neutral" || func_24DC(var_00) || func_24DE(var_00) || isdestroyed() || func_9C29(var_00) || func_324F(var_01) || func_69F8(var_01) || func_85DA(var_01) || var_01 == "MOD_MELEE";
}

func_740E() {
  self endon("death");

  if(!isDefined(level.func_12D6B))
    self endon("stop_friendlyfire_shield");

  if(isDefined(level.vehicle.func_116CE.func_323D[self.classname]) && !isDefined(self.func_ED22))
    self.func_ED22 = level.vehicle.func_116CE.func_323D[self.classname];

  if(isDefined(level.vehicle.func_116CE.missileoutline[self.classname]) && !isDefined(self.func_EDD3))
    self.func_EDD3 = level.vehicle.func_116CE.func_323D[self.classname];

  if(isDefined(self.func_EE50)) {
    self.func_EE50 = 1;
    self.func_3233 = 5000;
    self.health = 350;
  } else
    self.func_EE50 = 0;

  self.func_8CB6 = 20000;
  self.health = self.health + self.func_8CB6;
  self.func_4BF0 = self.health;
  var_00 = undefined;
  var_01 = undefined;
  var_02 = undefined;

  while(self.health > 0) {
    self waittill("damage", var_03, var_00, var_04, var_05, var_01, var_06, var_07, var_08, var_09, var_02);

    foreach(var_11 in self.func_4CF5)
    thread[[var_11]](var_03, var_00, var_04, var_05, var_01, var_06, var_07);

    if(isDefined(var_00))
      var_00 scripts\sp\player_stats::func_DED8();

    if(func_13234(var_00, var_01) || func_12F0())
      self.health = self.func_4BF0;
    else if(func_8B7F()) {
      func_DE7F(var_00, var_03);
      self.func_4BF0 = self.health;
    } else if(func_9029(var_01)) {
      self.health = self.func_4BF0;
      self.func_3233 = self.func_3233 - var_03;
    } else
      self.func_4BF0 = self.health;

    if(self.health < self.func_8CB6 && !isDefined(self.func_13243)) {
      break;
    }
  }

  self notify("death", var_00, var_01, var_02);
}

func_9029(var_00) {
  if(!self.func_EE50)
    return 0;

  if(self.func_3233 <= 0)
    return 0;

  if(!isDefined(var_00))
    return 0;

  if(!issubstr(var_00, "BULLET"))
    return 0;
  else
    return 1;
}

func_DE7F(var_00, var_01) {
  var_02 = anglesToForward(self.angles);
  var_03 = vectornormalize(var_0.origin - self.origin);

  if(vectordot(var_02, var_03) > 0.86)
    self.health = self.health + int(var_01 * level.vehicle.func_116CE.func_7448[self.vehicletype]);
}

func_12F0() {
  if(isDefined(self._meth_843F) && self._meth_843F)
    return 1;
  else
    return 0;
}

func_9C29(var_00) {
  if(!isDefined(self.func_ECE6))
    return 0;

  if(isDefined(var_00) && isai(var_00) && self.func_ECE6 == 1)
    return 1;
  else
    return 0;
}

func_24DE(var_00) {
  if(isDefined(self.script_team) && self.script_team == "allies" && isDefined(var_00) && isplayer(var_00))
    return 1;
  else if(isai(var_00) && var_0.team == self.script_team)
    return 1;
  else
    return 0;
}

func_24DC(var_00) {
  if(isDefined(var_00) && isDefined(var_0.script_team) && isDefined(self.script_team) && var_0.script_team == self.script_team)
    return 1;

  return 0;
}

vehicle_builds() {
  return func_143C();
}

func_13D03(var_00) {
  self.func_13D02 = scripts\engine\utility::ter_op(var_00 <= 0, 0, 1);
}

func_B248() {
  if(isDefined(level.func_B249)) {
    thread[[level.func_B249]]();
    return;
  }

  var_00 = self.model;

  if(!isDefined(level.vehicle.func_116CE.func_4F6B[var_00])) {
    return;
  }
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");
    playFXOnTag(level.vehicle.func_116CE.func_4F6B[var_00], self, "tag_engine_exhaust");
    var_01 = self gettagorigin("tag_flash");
    var_02 = _physicstrace(var_01, var_01 + (0, 0, -128));
    physicsexplosionsphere(var_02, 192, 100, 1);
  }
}

func_D546() {
  self endon("death");
  var_00 = self.model;

  if(!isDefined(level.vehicle.func_116CE.func_693A[var_00])) {
    return;
  }
  var_01 = 0.1;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(!isalive(self)) {
      return;
    }
    playFXOnTag(level.vehicle.func_116CE.func_693A[var_00], self, "tag_engine_exhaust");
    wait(var_01);
  }
}

func_13219() {
  self.func_247E = undefined;
  self notify("newpath");
  self setgoalyaw(scripts\engine\utility::flat_angle(self.angles)[1]);
  self setvehgoalpos(self.origin + (0, 0, 4), 1);
}

func_4E5C() {
  if(self.health > 0)
    self.func_E683 = 1;
}

func_4E5B() {
  self.func_E683 = undefined;
  self notify("deathrolloff");
}

func_134C() {
  self.func_EEF8 = 0;

  if(func_12F8() && func_8BFD()) {
    if(isDefined(level.func_3F23)) {
      self thread[[level.func_3F24]]();
      return;
    }
  }

  if(!isDefined(self.mgturret)) {
    return;
  }
  foreach(var_02, var_01 in self.mgturret) {
    if(isDefined(var_1.func_ED98))
      var_1.func_ED98 = 0;

    var_01 give_player_session_tokens("manual");
  }
}

func_134D() {
  self.func_EEF8 = 1;

  if(func_12F8() && func_8BFD()) {
    self thread[[level.func_3F25]]();
    return;
  }

  if(!isDefined(self.mgturret)) {
    return;
  }
  foreach(var_01 in self.mgturret) {
    var_01 show();

    if(isDefined(var_1.func_ED98))
      var_1.func_ED98 = 1;

    if(isDefined(var_1.func_5041)) {
      if(var_1.func_5041 != "sentry")
        var_01 give_player_session_tokens(var_1.func_5041);
    } else
      var_01 give_player_session_tokens("auto_nonai");

    func_F5D8(var_01);
  }
}

func_7D47() {
  var_00 = [];

  if(isDefined(self.target)) {
    var_01 = _getspawnerarray(self.target);

    foreach(var_03 in var_01) {
      if(!issubstr(var_3.code_classname, "actor") && !issubstr(var_3.code_classname, "vehicle")) {
        continue;
      }
      if(issubstr(var_3.code_classname, "actor")) {
        if(!_isspawner(var_03))
          continue;
        else if(issubstr(var_3.code_classname, "vehicle")) {
          if(!(var_3.spawnflags & 2))
            continue;
        }
      }

      if(isDefined(var_3.func_5941)) {
        continue;
      }
      var_0[var_0.size] = var_03;
    }

    if(isDefined(level.func_107A7)) {
      var_01 = scripts\engine\utility::getstructarray(self.target, "targetname");

      foreach(var_03 in var_01) {
        if(isDefined(var_3.func_EEB6))
          var_0[var_0.size] = var_03;
      }
    }
  }

  return var_00;
}

func_1444(var_00) {
  if(isDefined(var_0.func_ED52)) {
    var_00 endon("death");
    wait(var_0.func_ED52);
  }

  var_01 = var_00 global_physics_sound_monitor();

  if(!isDefined(var_0.func_1084E))
    var_0.func_1084E = 0;

  var_0.func_1084E++;
  var_0.func_1323B = var_01;
  var_0.func_A90E = var_01;
  var_00 thread func_E0A7();
  var_1.func_1323C = var_00;

  if(isDefined(var_0.func_12841))
    var_1.func_12841 = var_0.func_12841;

  thread func_131F6(var_01);
  var_00 notify("spawned", var_01);
  return var_01;
}

func_D808() {
  var_00 = [];
  var_01 = getEntArray("script_vehicle", "code_classname");
  level.func_BE91 = [];
  var_02 = [];
  var_00 = [];

  if(!isDefined(level.func_13261))
    level.func_13261 = [];

  foreach(var_04 in var_01) {
    var_4.vehicletype = tolower(var_4.vehicletype);

    if(var_4.vehicletype == "empty" || var_4.vehicletype == "empty_heli") {
      continue;
    }
    if(isDefined(var_4.spawnflags) && var_4.spawnflags & 1)
      var_2[var_2.size] = var_04;

    var_0[var_0.size] = var_04;

    if(!isDefined(level.func_13261[var_4.vehicletype]))
      level.func_13261[var_4.vehicletype] = [];

    var_05 = "classname: " + var_4.classname;
    func_D812(var_05, var_04);
  }

  if(level.func_BE91.size > 0) {
    foreach(var_08 in level.func_BE91) {}

    level waittill("never");
  }

  return var_00;
}

func_D812(var_00, var_01) {
  if(isDefined(level.func_13261[var_1.vehicletype][var_1.classname])) {
    return;
  }
  if(isDefined(level.vehicle.func_116CE.func_1325B) && isDefined(level.vehicle.func_116CE.func_1325B[var_1.classname])) {
    return;
  }
  if(var_1.classname == "script_vehicle") {
    return;
  }
  var_02 = 0;

  foreach(var_04 in level.func_BE91) {
    if(var_04 == var_00)
      var_02 = 1;
  }

  if(!var_02)
    level.func_BE91[level.func_BE91.size] = var_00;
}

func_F9C7() {
  if(!scripts\engine\utility::add_init_script("vehicle_vars", ::func_F9C7)) {
    return;
  }
  scripts\engine\utility::struct_class_init();
  level.vehicle = spawnStruct();
  level.vehicle.func_116CE = spawnStruct();
  level.vehicle.func_8DAA = getEntArray("helicopter_crash_location", "targetname");
  level.vehicle.func_8DAA = scripts\engine\utility::array_combine(level.vehicle.func_8DAA, scripts\sp\utility::_meth_8181("helicopter_crash_location", "targetname"));
  level.vehicle.func_116CE.team = [];
  level.vehicle.func_116CE.func_4E4E = [];
  level.vehicle.func_116CE.func_4E23 = [];
  level.vehicle.func_116CE.func_5BC3 = [];
  level.vehicle.func_116CE.func_5BC6 = [];
  level.vehicle.func_116CE.func_E7BA = [];
  level.vehicle.func_116CE.mgturret = [];
  level.vehicle.func_116CE.func_4E02 = [];
  level.vehicle.func_116CE.func_112D9 = [];
  level.vehicle.func_116CE.func_12BCF = [];
  level.vehicle.func_116CE.func_1A03 = [];
  level.vehicle.func_116CE.func_A7C5 = [];
  level.vehicle.func_116CE.func_693A = [];
  level.vehicle.func_116CE.func_4F6B = [];
  level.vehicle.func_116CE.func_FE7C = [];
  level.vehicle.func_116CE.func_8E9D = [];
  level.vehicle.func_116CE.func_7448 = [];
  level.vehicle.func_116CE.func_535B = [];
  level.vehicle.func_116CE.missileoutline = [];
  level.vehicle.func_116CE.func_323D = [];
  level.vehicle.func_116CE.func_4E12 = [];
  level.vehicle.func_116CE.func_4DFC = [];
  level.vehicle.func_116CE.func_92D0 = [];
  level.vehicle.func_116CE.func_8DB1 = [];
  level.vehicle.func_116CE.func_1AE5 = [];
  level.vehicle.func_116CE.func_1020A = [];
  level.vehicle.func_116CE.func_4DF9 = [];
  level.vehicle.func_116CE.func_131BC = [];

  if(!isDefined(level.vehicle.func_116CE.func_4E1C))
    level.vehicle.func_116CE.func_4E1C = [];

  scripts\sp\vehicle_aianim::func_F8AE();
}

func_FB0A(var_00, var_01) {
  return _setvehgoalpos_wrap(var_00, var_01);
}

func_13207(var_00) {
  if(!isDefined(var_00))
    var_00 = 512;

  var_01 = self.origin + (0, 0, var_00);
  self setneargoalnotifydist(10);
  func_FB0A(var_01, 1);
  self waittill("goal");
}

func_10810(var_00) {
  var_01 = [];
  var_02 = getEntArray(var_00, "targetname");
  var_03 = [];

  foreach(var_05 in var_02) {
    if(!isDefined(var_5.code_classname) || var_5.code_classname != "script_vehicle") {
      continue;
    }
    if(_isspawner(var_05))
      var_1[var_1.size] = func_1444(var_05);
  }

  return var_01;
}

func_A5CC(var_00) {
  if(!isDefined(level.vehicle.func_116CE.func_4DF9[var_00])) {
    return;
  }
  if(isDefined(self.func_10263) && self.func_10263) {
    return;
  }
  if(isarray(level.vehicle.func_116CE.func_4DF9[var_00])) {
    if(isDefined(self.func_D832))
      var_01 = self.func_D832;
    else
      var_01 = scripts\engine\utility::random(level.vehicle.func_116CE.func_4DF9[var_00]);

    return func_A5CD(var_01);
  }

  return func_A5CD(level.vehicle.func_116CE.func_4DF9[var_00]);
}

func_A5CD(var_00) {
  self.func_A648 = 1;
  var_01 = scripts\engine\utility::spawn_tag_origin();
  self _meth_83E3(var_1.origin, var_1.angles, 0, 0);
  self _meth_83E8();
  self notify("kill_death_anim", var_00);

  if(isstring(var_00)) {
    self setCanDamage(0);
    var_01 scripts\sp\anim::func_1F35(self, var_00);
  } else {
    self glinton(#animtree);
    self animscripted("vehicle_death_anim", var_1.origin, var_1.angles, var_00);
    self setneargoalnotifydist(30);
    self setvehgoalpos(var_1.origin, 1);
    self setgoalyaw(var_1.angles[1]);
    self waittillmatch("vehicle_death_anim", "end");
  }

  var_01 delete();
  thread func_50EA(7);
}

func_50EA(var_00) {
  wait 7;

  if(isDefined(self))
    self delete();
}

func_5144() {
  var_00 = self getsecondspassed();
  var_01 = self getpointinbounds(1, 0, 0);
  var_02 = distance(var_01, var_00);
  var_03 = getcorpsearray();

  foreach(var_05 in var_03) {
    if(distance(var_5.origin, var_00) < var_02)
      var_05 delete();
  }
}