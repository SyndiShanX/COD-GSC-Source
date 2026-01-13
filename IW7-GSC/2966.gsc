/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2966.gsc
***************************************/

func_FA79() {
  var_0 = func_12B8();

  foreach(var_2 in var_0) {
    var_2 thread func_1323A();
  }
}

func_1323A() {
  self endon("entitydeleted");

  if(isDefined(self.var_ED48)) {
    thread func_0B77::func_1323D();
  }

  self.count = 1;
  self.var_10708 = [];

  for(;;) {
    var_0 = undefined;
    self waittill("spawned", var_0);
    self.count--;

    if(!isDefined(var_0)) {
      continue;
    }
    var_0.var_10707 = self.var_10708;
    var_0.spawner = self;
    var_0 thread func_0B77::func_E81A();
  }
}

func_A629(var_0) {
  var_0 waittill("trigger");

  foreach(var_2 in vehicle_getspawnerarray()) {
    if(isDefined(var_2.var_EDF5) && var_2.var_EDF5 == self.var_EDF5) {
      var_2 delete();
    }
  }
}

#using_animtree("vehicles");

func_1063F(var_0) {
  var_1 = [];
  var_2 = scripts\sp\utility::func_65DF("no_riders_until_unload");

  foreach(var_4 in var_0) {
    var_4.count = 1;
    var_5 = 0;
    var_6 = 0;

    if(isDefined(var_4.var_ED6E)) {
      var_5 = 1;
      var_7 = scripts\sp\utility::func_5CC9(var_4);
      var_7 func_0B24::func_5C21();
    } else if(isDefined(var_4.var_ED8A) || isDefined(var_4.var_ED1B)) {
      var_5 = 1;
      var_7 = scripts\sp\utility::func_2C17(var_4);
      var_7 scripts\sp\fakeactor::func_6B15();
    } else if(isDefined(var_4.code_classname) && var_4.code_classname == "script_vehicle") {
      var_6 = 1;
      var_8 = spawn("script_model", (0, 0, 0));
      var_8 setModel(var_4.model);
      var_8 glinton(#animtree);

      if(isDefined(var_4.var_EEC9)) {
        var_8.var_EEC9 = var_4.var_EEC9;
      }

      var_8.var_9FEF = 1;
      var_8.var_1356F = var_4;
      var_7 = var_8;
    } else {
      var_9 = (isDefined(var_4.var_EECE) || isDefined(var_4.var_EED1)) && scripts\engine\utility::flag("stealth_enabled") && !scripts\engine\utility::flag("stealth_spotted");
      var_10 = var_4;

      if(isDefined(var_4.var_EEB6)) {
        var_10 = func_0B77::func_7C86(var_4, 1);
      }

      if(isDefined(var_4.var_EDB3) || var_2) {
        var_7 = var_10 _meth_8393(var_9);
      } else {
        var_7 = var_10 dospawn(var_9);
      }

      if(isDefined(var_4.var_EEB6)) {
        if(isDefined(var_4.var_EEC9)) {
          var_7.var_EEC9 = var_4.var_EEC9;
        }
      }
    }

    if(!var_5 && !var_6 && !isalive(var_7)) {
      continue;
    }
    var_1[var_1.size] = var_7;
  }

  var_1 = func_E05D(var_1);
  return var_1;
}

func_E05D(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!func_19E4(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

func_19E4(var_0) {
  if(isalive(var_0)) {
    return 1;
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(var_0.classname)) {
    return 0;
  }

  return var_0.classname == "script_model";
}

spawn_group() {
  if(scripts\sp\utility::func_65DF("no_riders_until_unload") && !scripts\sp\utility::func_65DB("no_riders_until_unload")) {
    return [];
  }

  var_0 = func_7D47();

  if(!var_0.size) {
    return [];
  }

  var_1 = [];
  var_2 = func_1063F(var_0);
  var_2 = func_1041B(var_2);

  foreach(var_4 in var_2) {
    thread scripts\sp\vehicle_aianim::func_8739(var_4);
  }

  return var_2;
}

func_10805(var_0) {
  if(!isDefined(var_0)) {
    return spawn_group();
  }

  var_1 = func_7D47();

  if(!var_1.size) {
    return [];
  }

  var_2 = [];
  var_3 = self.classname;

  if(isDefined(level.vehicle.var_116CE.var_12BCF[var_3]) && isDefined(level.vehicle.var_116CE.var_12BCF[var_3][var_0])) {
    var_4 = level.vehicle.var_116CE.var_12BCF[var_3][var_0];

    foreach(var_6 in var_4) {
      foreach(var_8 in var_1) {
        if(var_8.var_EEC9 == var_6) {
          var_2[var_2.size] = var_8;
        }
      }
    }

    var_11 = func_1063F(var_2);

    for(var_12 = 0; var_12 < var_4.size; var_12++) {
      if(isDefined(var_11[var_12])) {
        var_11[var_12].var_EEC9 = var_4[var_12];
      }
    }

    var_11 = func_1041B(var_11);

    foreach(var_14 in var_11) {
      thread scripts\sp\vehicle_aianim::func_8739(var_14);
    }

    return var_11;
  } else
    return spawn_group();
}

func_1041B(var_0) {
  var_1 = [];
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(var_4.var_EEC9)) {
      var_1[var_1.size] = var_4;
      continue;
    }

    var_2[var_2.size] = var_4;
  }

  return scripts\engine\utility::array_combine(var_1, var_2);
}

func_E0A7() {
  wait 0.05;
  self.var_1323B = undefined;
}

func_131F6(var_0) {
  var_1 = var_0.classname;

  if(isDefined(level.vehicle.var_116CE.var_1325B) && isDefined(level.vehicle.var_116CE.var_1325B[var_1])) {
    var_0 thread[[level.vehicle.var_116CE.var_1325B[var_1]]]();
    return;
  }

  if(isDefined(level.vehicle.var_116CE.var_8E9D[var_1])) {
    foreach(var_3 in level.vehicle.var_116CE.var_8E9D[var_1]) {
      var_0 hidepart(var_3);
    }
  }

  if(var_0.vehicletype == "empty" || var_0.vehicletype == "empty_heli") {
    var_0 thread scripts\sp\vehicle_paths::beginlocationselection();
    return;
  }

  var_0 scripts\sp\utility::func_F294();

  if(!isDefined(var_0.var_B91F)) {
    var_0.var_B91F = 0;
  }

  var_5 = var_0.vehicletype;
  var_0 func_13203();
  var_0 func_1322F();

  if(!isDefined(level.var_13261[var_0.vehicletype][var_0.classname])) {}

  var_0 thread[[level.var_13261[var_0.vehicletype][var_0.classname]]]();
  var_0 thread func_B248();
  var_0 thread func_D546();

  if(!isDefined(var_0.var_ED10)) {
    var_0.var_ED10 = 0;
  }

  if(isDefined(level.vehicle.draw_thermal)) {
    if(level.vehicle.draw_thermal) {
      var_0 thermaldrawenable();
    }
  }

  var_0 scripts\sp\utility::func_65E0("unloaded");
  var_0 scripts\sp\utility::func_65E0("loaded");
  var_0 scripts\sp\utility::func_65E0("landed");
  var_0.var_E4FB = [];
  var_0.var_12BD0 = [];
  var_0.var_12BBC = "default";
  var_0.var_6B9D = [];

  if(isDefined(level.vehicle.var_116CE.var_247D) && isDefined(level.vehicle.var_116CE.var_247D[var_1])) {
    var_6 = level.vehicle.var_116CE.var_247D[var_1];
    var_7 = getarraykeys(var_6);

    foreach(var_9 in var_7) {
      var_0.var_6B9D[var_9] = undefined;
      var_0.var_6B9E[var_9] = 0;
    }
  }

  var_0 thread vehicle_builds();

  if(isDefined(var_0.var_EF04)) {
    var_0 thread scripts\sp\vehicle_lights::lights_on(var_0.var_EF04);
  }

  if(isDefined(var_0.var_EDD1)) {
    var_0._meth_843F = 1;
  }

  var_0.var_4CF5 = [];
  var_0 thread func_740E();
  var_0 thread scripts\sp\vehicle_aianim::func_88AE();

  if(isDefined(var_0.var_EDB8)) {
    var_0 setvehiclelookattext(var_0.var_EDB8, &"");
  }

  var_0 thread func_131EC();

  if(isDefined(var_0.var_ED6C)) {
    var_0.var_5971 = 1;
  }

  var_0 thread func_1322A();
  var_0 thread scripts\sp\vehicle_treads::func_1324B();
  var_0 thread func_92D3();
  var_0 thread func_1F6E();

  if(isDefined(var_0.var_ED48)) {
    var_0 thread func_0B77::func_131C1();
  }

  var_0 thread func_B6B7();

  if(isDefined(level.vehicle.var_1066A)) {
    level thread[[level.vehicle.var_1066A]](var_0);
  }

  if(isDefined(var_0.script_team)) {
    var_0 setvehicleteam(var_0.script_team);
  }

  var_0 thread func_5636();
  var_0 thread scripts\sp\vehicle_paths::beginlocationselection();

  if(isDefined(level.var_9334)) {
    var_11 = level.var_9334;
  } else {
    var_11 = 0;
  }

  if(var_0 func_8BFC() && !var_11) {
    var_0 thread func_1A93();
  }

  if(var_0 _meth_83E2()) {
    var_0.veh_pathtype = "constrained";

    if(isDefined(var_0.var_EE7C)) {
      var_0.veh_pathtype = var_0.var_EE7C;
    }
  }

  var_0 spawn_group();
  var_0 thread func_131FA();
}

func_A5CB(var_0) {
  if(!isDefined(level.vehicle.var_116CE.var_4E1C) || !isDefined(level.vehicle.var_116CE.var_4E1C[var_0])) {
    return;
  }
  if(isDefined(self.var_4E38)) {
    var_1 = self.var_4E38;
  } else {
    var_1 = level.vehicle.var_116CE.var_4E1C[var_0].var_B48B;
  }

  if(isDefined(self.var_4E39)) {
    var_2 = self.var_4E39;
  } else {
    var_2 = level.vehicle.var_116CE.var_4E1C[var_0].var_B758;
  }

  if(isDefined(level.vehicle.var_116CE.var_4E1C[var_0].delay)) {
    wait(level.vehicle.var_116CE.var_4E1C[var_0].delay);
  }

  if(!isDefined(self)) {
    return;
  }
  if(level.vehicle.var_116CE.var_4E1C[var_0].var_2B19) {
    level.player _meth_80D0(0);
  }

  self radiusdamage(self.origin + level.vehicle.var_116CE.var_4E1C[var_0].offset, level.vehicle.var_116CE.var_4E1C[var_0].var_DCCA, var_1, var_2, self);

  if(level.vehicle.var_116CE.var_4E1C[var_0].var_2B19) {
    level.player _meth_80D0(1);
  }
}

func_131FA() {
  self endon("nodeath_thread");
  var_0 = 0;

  for(;;) {
    self waittill("death", var_1, var_2, var_3);

    if(isDefined(self.var_4C49)) {
      self thread[[self.var_4C49]]();
    }

    if(!var_0) {
      var_0 = 1;

      if(isDefined(var_1) && isDefined(var_2)) {
        var_1 scripts\sp\player_stats::func_DEBD(self, var_2, var_3);

        if(isDefined(self.var_4D28)) {
          self.var_4D28 = undefined;
        }
      }
    }

    self notify("clear_c4");

    if(isDefined(self.var_E7D2)) {
      self.var_E7D2 delete();
    }

    if(isDefined(self.mgturret)) {
      scripts\engine\utility::array_levelthread(self.mgturret, ::func_129E4);
      self.mgturret = undefined;
    }

    if(!isDefined(self) || func_9BA8()) {
      if(isDefined(self.var_E4FB)) {
        foreach(var_5 in self.var_E4FB) {
          if(isDefined(var_5)) {
            var_5 delete();
          }
        }
      }

      if(func_9BA8()) {
        self.var_E4FB = [];
        continue;
      }

      self notify("delete_destructible");
      return;
    }

    var_7 = undefined;

    if(isDefined(self.var_1322C)) {
      var_7 = self.var_1322C;
    } else if(isDefined(level.vehicle.var_116CE.var_E7BA[self.classname])) {
      var_7 = level.vehicle.var_116CE.var_E7BA[self.classname];
    }

    if(isDefined(var_7)) {
      self stoprumble(var_7.var_E7BA);
    }

    if(isDefined(level.vehicle.var_116CE.var_4E23[self.vehicletype])) {
      thread[[level.vehicle.var_116CE.var_4E23[self.vehicletype]]]();
    }

    scripts\engine\utility::array_levelthread(self.var_E4FB, scripts\sp\vehicle_aianim::func_876B, var_1, self.vehicletype);
    thread func_A5CB(self.classname);
    thread func_A5BF(self.classname);
    thread scripts\sp\vehicle_lights::func_A5F2(self.classname);
    func_5144();

    if(isDefined(level.vehicle.var_116CE.var_4E4E[self.classname])) {
      thread func_F331(level.vehicle.var_116CE.var_4E4E[self.classname], level.vehicle.var_131C3[self.classname]);
    } else if(isDefined(level.vehicle.var_116CE.var_4E4E[self.model])) {
      thread func_F331(level.vehicle.var_116CE.var_4E4E[self.model], level.vehicle.var_131C3[self.model]);
    }

    var_8 = func_13233(self.model, var_1, var_2);
    var_9 = self.origin;
    var_10 = undefined;

    if(isDefined(var_1)) {
      var_10 = self.origin - var_1.origin;
      var_10 = vectornormalize(var_10);
    }

    thread func_A5CC(self.classname);
    thread func_12FB(self.model, var_8, var_10);

    if(self.code_classname == "script_vehicle") {
      thread func_A5EE(self.classname);
    }

    if(isDefined(self.delete_on_death)) {
      wait 0.05;

      if(!isDefined(self.var_5958) && !self _meth_83E2()) {
        self disconnectpaths();
      }

      _freezelookcontrols();
      wait 0.05;
      func_131D7(self.model);
      self delete();
      continue;
    }

    if(isDefined(self.var_736A)) {
      self notify("newpath");

      if(!isDefined(self.var_5958)) {
        self disconnectpaths();
      }

      func_131FB();
      _freezelookcontrols();
      return;
    }

    func_131CE(self.model, var_1, var_2, var_8);

    if(!isDefined(self)) {
      return;
    }
    if(!var_8) {
      var_9 = self.origin;
    }

    if(isDefined(level.vehicle.var_116CE.var_4E02[self.classname])) {
      earthquake(level.vehicle.var_116CE.var_4E02[self.classname].var_EB9C, level.vehicle.var_116CE.var_4E02[self.classname].var_5F36, var_9, level.vehicle.var_116CE.var_4E02[self.classname].radius);
    }

    wait 0.5;

    if(func_9BA8()) {
      continue;
    }
    if(isDefined(self)) {
      while(isDefined(self.var_5960) && isDefined(self)) {
        wait 0.05;
      }

      if(!isDefined(self)) {
        continue;
      }
      if(self _meth_83E2()) {
        while(isDefined(self) && self.veh_speed != 0) {
          wait 1;
        }

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

      if(self.var_B91F) {
        self hide();
      }
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
  self.var_247C = undefined;
  self.var_24D2 = undefined;
  self.var_275B = undefined;
  self.var_275C = undefined;
  self.var_4BF0 = undefined;
  self.var_4BF7 = undefined;
  self.var_4CF5 = undefined;
  self.var_5107 = undefined;
  self.var_6B9D = undefined;
  self.var_7F1A = undefined;
  self.var_8C2D = undefined;
  self.var_8CB6 = undefined;
  self.var_C36E = undefined;
  self.var_C36F = undefined;
  self.var_E7BE = undefined;
  self.var_E7C0 = undefined;
  self.var_E7C6 = undefined;
  self.var_ED10 = undefined;
  self.var_ED22 = undefined;
  self.script_disconnectpaths = undefined;
  self.script_linkname = undefined;
  self.var_EE50 = undefined;
  self.script_team = undefined;
  self.var_EEF2 = undefined;
  self.var_EEF8 = undefined;
  self.var_10707 = undefined;
  self.var_10708 = undefined;
  self.var_114CB = undefined;
  self.target = undefined;
  self.var_1152D = undefined;
  self.var_127FF = undefined;
  self.var_12800 = undefined;
  self.var_129DB = undefined;
  self.var_129DC = undefined;
  self.var_129DE = undefined;
  self.var_2756 = undefined;
  self.var_247E = undefined;
  self.var_2756 = undefined;
  self.var_E7CA = undefined;
  self.var_E7CB = undefined;
  self.var_E7D0 = undefined;
  self.var_E7D2 = undefined;
  self.var_E880 = undefined;
  self.var_EE5E = undefined;
  self.var_EEC8 = undefined;
  self.var_11659 = undefined;
  self.var_129DE = undefined;
  self.var_12A51 = undefined;
  self.var_12A52 = undefined;
  self.var_12A65 = undefined;
  self.var_12A7C = undefined;
  self.var_12A7D = undefined;
  self.unique_id = undefined;
  self.var_12BBC = undefined;
  self.var_12BD0 = undefined;
  self.var_1307E = undefined;
  self.var_1323C = undefined;
  self.var_136FC = undefined;
  self.var_13BB6 = undefined;
  self.var_C373 = undefined;
  self.var_ECE5 = undefined;
  self.var_13D02 = undefined;
  self.var_5971 = undefined;
  self.var_5958 = undefined;
  self.var_EDD1 = undefined;
  self.var_65DB = undefined;
  self.var_6A0B = undefined;
  self._meth_843F = undefined;
  self.vehicletype = undefined;
  self.var_13244 = undefined;
  self.var_6231 = undefined;
  self.var_ED12 = undefined;
}

func_143E() {
  return isDefined(self.var_4828) && self.var_4828 == 1;
}

func_131D7(var_0) {
  if(isDefined(self.var_5946) && self.var_5946) {
    return;
  }
  self notify("death_finished");

  if(!isDefined(self)) {
    return;
  }
  self glinton(#animtree);

  if(isDefined(level.vehicle.var_116CE.var_5BC3[var_0])) {
    self clearanim(level.vehicle.var_116CE.var_5BC3[var_0], 0);
  }

  if(isDefined(level.vehicle.var_116CE.var_5BC6[var_0])) {
    self clearanim(level.vehicle.var_116CE.var_5BC6[var_0], 0);
  }
}

func_13233(var_0, var_1, var_2) {
  if(!isDefined(self.var_1D63) || self.var_1D63 == 0) {
    if(isDefined(self.var_627C) && self.var_627C == 0) {
      return 0;
    }

    if(!isDefined(var_2)) {
      return 0;
    }

    if(!(var_2 == "MOD_PROJECTILE" || var_2 == "MOD_PROJECTILE_SPLASH")) {
      return 0;
    }
  }

  if(isDefined(self.var_9B65) && self.var_9B65) {
    return 1;
  }

  return func_131ED(var_0);
}

func_131ED(var_0) {
  return isDefined(level.vehicle.var_116CE.var_131BC["rocket_death" + self.classname]) && isDefined(self.var_627C) && self.var_627C == 1;
}

func_131CE(var_0, var_1, var_2, var_3) {
  var_4 = "tank";

  if(self _meth_83E2()) {
    var_4 = "physics";
  } else if(func_12F8()) {
    var_4 = "helicopter";
  } else if(isDefined(self.var_4BF7)) {
    var_4 = "none";
  }

  switch (var_4) {
    case "helicopter":
      thread func_8DA7(var_1, var_2, var_3);
      break;
    case "tank":
      if(!isDefined(self.var_E683)) {
        self vehicle_setspeed(0, 25);
      } else {
        self vehicle_setspeed(8, 25);
        self waittill("deathrolloff");
        self vehicle_setspeed(0, 25);
      }

      self notify("deadstop");

      if(!isDefined(self.var_5958)) {
        self disconnectpaths();
      }

      if(isDefined(self.var_114E0) && self.var_114E0 > 0) {
        self waittill("animsdone");
      }

      break;
    case "physics":
      self _meth_83EF();
      self notify("deadstop");

      if(!isDefined(self.var_5958)) {
        self disconnectpaths();
      }

      if(isDefined(self.var_114E0) && self.var_114E0 > 0) {
        self waittill("animsdone");
      }

      break;
  }

  if(isDefined(level.vehicle.var_116CE.var_8B8F[var_0]) && level.vehicle.var_116CE.var_8B8F[var_0]) {
    self _meth_8080();
  }

  if(func_12F8()) {
    if(isDefined(self.var_4828) && self.var_4828 == 1) {
      self waittill("crash_done");
    }
  } else {
    while(!func_9BA8() && isDefined(self) && self vehicle_getspeed() > 0) {
      wait 0.1;
    }
  }

  self notify("stop_looping_death_fx");
  func_131D7(var_0);
}

func_9BA8() {
  var_0 = 0;

  if(isDefined(self) && self.classname == "script_vehicle_corpse") {
    var_0 = 1;
  }

  return var_0;
}

func_F331(var_0, var_1) {
  if(isDefined(self.var_10268) && self.var_10268) {
    return;
  }
  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);
  }

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.var_412A)) {
    self clearanim( % root, 0);
  }

  if(isDefined(self)) {
    self setModel(var_0);
  }
}

func_8DA7(var_0, var_1, var_2) {
  if(isDefined(var_0) && isplayer(var_0)) {
    self.var_C720 = var_0;
  }

  self.var_4828 = 1;

  if(!isDefined(self)) {
    return;
  }
  func_5389();

  if(!var_2) {
    thread func_8DAB(var_0, var_1);
  }
}

func_A60E(var_0) {
  foreach(var_2 in var_0) {
    if(!isalive(var_2)) {
      continue;
    }
    if(!isDefined(var_2.var_E500) && !isDefined(var_2.var_5BD6)) {
      continue;
    }
    if(isDefined(var_2.var_B14F)) {
      var_2 scripts\sp\utility::func_1101B();
    }

    var_2 _meth_81D0();
  }
}

func_13225(var_0, var_1) {
  if(isDefined(self.var_1321D) && self.var_1321D != 0) {
    return;
  }
  self.health = 1;
  var_0 endon("death");
  self.var_2894 = 0.15;
  self waittill("death");
  var_0 notify("driver_died");
  func_A60E(var_1);
}

vehicle_caps() {
  self endon("death");
  self endon("enable_spline_path");
  waittillframeend;
  self.var_E4FB = scripts\sp\utility::func_DFEB(self.var_E4FB);

  if(self.var_E4FB.size) {
    scripts\engine\utility::array_thread(self.var_E4FB, ::func_13225, self, self.var_E4FB);
    scripts\engine\utility::waittill_either("veh_collision", "driver_died");
    func_A60E(self.var_E4FB);
    wait 0.25;
  }

  self notify("script_crash_vehicle");
  self _meth_83EF();
}

func_143F(var_0, var_1) {
  self endon("death");
  self notify("newpath");

  if(!isDefined(var_0)) {
    var_0 = 2;
  }

  self setneargoalnotifydist(var_0);
  self sethoverparams(0, 0, 0);
  self getplayerkills();
  self settargetyaw(scripts\engine\utility::flat_angle(self.angles)[1]);

  if(isDefined(self.var_12BC2)) {
    _setvehgoalpos_wrap(scripts\sp\utility::func_864C(self.origin) + (0, 0, self.var_12BC2), 1);
  } else {
    _setvehgoalpos_wrap(scripts\sp\utility::func_864C(self.origin), 1);
  }

  self waittill("goal");
}

func_13200(var_0, var_1) {
  self endon("death");

  if(!isDefined(level.vehicle.var_116CE.var_A7C5[self.classname])) {
    return;
  }
  var_2 = level.vehicle.var_116CE.var_A7C5[self.classname];

  foreach(var_4 in var_2) {
    self give_attacker_kill_rewards(var_4.land, 1, 0.2, 1);
  }

  if(!var_1) {
    return;
  }
  if(isDefined(var_0)) {
    self waittill("unloaded");
  } else {
    self waittill("continuepath");
  }

  foreach(var_4 in var_2) {
    self clearanim(var_4.land, 0);
    self give_attacker_kill_rewards(var_4.var_11472, 1, 0.2, 1);
  }
}

func_13201(var_0, var_1) {
  return func_143F(var_0, var_1);
}

func_10809(var_0) {
  if(level.var_650D.size >= 8) {
    return;
  }
  var_1 = scripts\sp\utility::func_10808();

  if(isDefined(var_0)) {
    var_1 _meth_83F4(var_0);
  }

  var_1 thread vehicle_caps();
  var_1 endon("death");
  var_1.var_5971 = 1;
  var_1 scripts\sp\vehicle_paths::setsuit(var_1);
  var_1 func_AB23();
}

func_AB23() {
  self endon("script_crash_vehicle");
  scripts\engine\utility::waittill_either("enable_spline_path", "reached_end_node");
  var_0 = func_7B03(self.origin);

  if(isDefined(level.var_5BC2)) {
    var_0 thread[[level.var_5BC2]](self);
  }
}

func_7B03(var_0) {
  var_0 = (var_0[0], var_0[1], 0);
  var_1 = scripts\engine\utility::get_array_of_closest(var_0, level.var_103D0);
  var_2 = [];

  for(var_3 = 0; var_3 < 3; var_3++) {
    var_2[var_3] = var_1[var_3];
  }

  foreach(var_5 in level.var_103D0) {
    foreach(var_7 in var_2) {
      if(var_7 == var_5) {
        return var_7;
      }
    }
  }
}

func_13804(var_0) {
  var_1 = 12;
  var_2 = 400;
  var_3 = gettime() + var_2;

  while(isDefined(self)) {
    if(abs(self.angles[0]) > var_1 || abs(self.angles[2]) > var_1) {
      var_3 = gettime() + var_2;
    }

    if(gettime() > var_3) {
      break;
    }
    wait 0.05;
  }
}

func_143C() {
  if(!isDefined(self.var_ED12)) {
    return;
  }
  _createnavrepulsor(self.unique_id + "vehicle_badplace", -1, self, "allies", "axis");
}

func_1446(var_0) {
  self notify("unloading");
  var_1 = [];

  if(scripts\sp\utility::func_65DF("no_riders_until_unload")) {
    scripts\sp\utility::func_65E1("no_riders_until_unload");
    var_1 = func_10805(var_0);

    foreach(var_3 in var_1) {
      scripts\sp\utility::func_106ED(var_3);
    }

    waittillframeend;
  }

  if(isDefined(var_0)) {
    self.var_12BBC = var_0;
  }

  foreach(var_6 in self.var_E4FB) {
    if(isalive(var_6)) {
      var_6 notify("unload");
    }
  }

  var_1 = scripts\sp\vehicle_aianim::func_1F74("unload");
  var_8 = level.vehicle.var_116CE.var_12BCF[self.classname];

  if(isDefined(var_8)) {
    var_1 = [];
    var_9 = scripts\sp\vehicle_aianim::func_7D2F();

    foreach(var_12, var_11 in self.var_E4FB) {
      if(isDefined(var_9[var_11.var_1321D])) {
        var_1[var_1.size] = var_11;
      }
    }
  }

  return var_1;
}

_setvehgoalpos_wrap(var_0, var_1) {
  if(self.health <= 0) {
    return;
  }
  if(isDefined(self.var_C737)) {
    var_0 = var_0 + (0, 0, self.var_C737);
  }

  self setvehgoalpos(var_0, var_1);
}

func_8DAB(var_0, var_1) {
  self endon("in_air_explosion");

  if(isDefined(self.var_CA16)) {
    var_2 = self.var_CA16;
  } else {
    var_3 = func_7D31();
    var_2 = scripts\engine\utility::getclosest(self.origin, var_3);
  }

  var_2.claimed = 1;
  self notify("newpath");
  self notify("deathspin");
  var_4 = 0;
  var_5 = 0;

  if(isDefined(var_2.script_parameters) && var_2.script_parameters == "direct") {
    var_5 = 1;
  }

  if(isDefined(self.var_8D3C)) {
    var_5 = 0;
    var_4 = self.var_8D3C;
  }

  if(var_5) {
    var_6 = 60;
    self vehicle_setspeed(var_6, 15, 10);
    self setneargoalnotifydist(var_2.radius);
    self setvehgoalpos(var_2.origin, 0);
    thread func_8DA9(var_2.origin, var_6);
    scripts\engine\utility::waittill_any("goal", "near_goal");
    func_8DAC(var_2);
  } else {
    var_7 = (var_2.origin[0], var_2.origin[1], self.origin[2] + var_4);

    if(isDefined(self.var_8D3D)) {
      var_7 = self.origin + self.var_8D3D * self vehicle_getvelocity();
      var_7 = (var_7[0], var_7[1], var_7[2] + var_4);
    }

    self vehicle_setspeed(40, 10, 10);
    self setneargoalnotifydist(300);
    self setvehgoalpos(var_7, 1);
    thread func_8DA9(var_7, 40);
    var_8 = "blank";

    while(var_8 != "death") {
      var_8 = scripts\engine\utility::waittill_any("goal", "near_goal", "death");

      if(!isDefined(var_8) && !isDefined(self)) {
        var_2.claimed = undefined;
        self notify("crash_done");
        return;
      } else
        var_8 = "death";
    }

    self setvehgoalpos(var_2.origin, 0);
    self waittill("goal");
    func_8DAC(var_2);
  }

  var_2.claimed = undefined;
  self notify("stop_crash_loop_sound");
  self notify("crash_done");
}

func_8DAC(var_0) {
  self endon("death");

  while(isDefined(var_0.target)) {
    var_0 = scripts\engine\utility::getstruct(var_0.target, "targetname");
    var_1 = 56;

    if(isDefined(var_0.radius)) {
      var_1 = var_0.radius;
    }

    self setneargoalnotifydist(var_1);
    self setvehgoalpos(var_0.origin, 0);
    scripts\engine\utility::waittill_any("goal", "near_goal");
  }
}

func_8DA9(var_0, var_1) {
  self endon("crash_done");
  self getplayerkillstreakcombatmode();
  var_2 = 0;

  if(isDefined(self.var_D831)) {
    var_2 = self.var_D831;

    if(self.var_D831 < 0) {
      var_3 = [1, 2, 2];
      var_4 = 5;
      var_5 = randomint(var_4);
      var_6 = 0;

      foreach(var_9, var_8 in var_3) {
        var_6 = var_6 + var_8;

        if(var_5 < var_6) {
          var_2 = var_9;
          break;
        }
      }
    }
  }

  switch (var_2) {
    case 1:
      thread func_8DAE();
      break;
    case 2:
      thread func_8DA8(var_0, var_1);
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

func_8DA8(var_0, var_1) {
  self endon("crash_done");
  self getplayerkillstreakcombatmode();
  self setmaxpitchroll(randomintrange(20, 90), randomintrange(5, 90));
  self setyawspeed(400, 100, 100);
  var_2 = 90 * randomintrange(-2, 3);

  for(;;) {
    var_3 = var_0 - self.origin;
    var_4 = vectortoyaw(var_3);
    var_4 = var_4 + var_2;
    self settargetyaw(var_4);
    wait 0.1;
  }
}

func_8DAE() {
  self endon("crash_done");
  self getplayerkillstreakcombatmode();
  self setyawspeed(400, 100, 100);
  var_0 = randomint(2);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    var_1 = randomintrange(20, 120);

    if(var_0) {
      self settargetyaw(self.angles[1] + var_1);
    } else {
      self settargetyaw(self.angles[1] - var_1);
    }

    var_0 = 1 - var_0;
    var_2 = randomfloatrange(0.5, 1.0);
    wait(var_2);
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
    var_0 = randomintrange(90, 120);
    self settargetyaw(self.angles[1] + var_0);
    wait 0.5;
  }
}

func_7D31() {
  var_0 = [];
  level.vehicle.var_8DAA = scripts\engine\utility::array_removeundefined(level.vehicle.var_8DAA);

  foreach(var_2 in level.vehicle.var_8DAA) {
    if(isDefined(var_2.claimed)) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

func_5389() {
  if(!isDefined(self.var_6B9D)) {
    return;
  }
  if(!self.var_6B9D.size) {
    return;
  }
  var_0 = getarraykeys(self.var_6B9D);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    self.var_6B9D[var_0[var_1]] unlink();
  }
}

func_131FB() {
  self notify("kill_badplace_forever");
}

func_A5EE(var_0) {
  if(isDefined(level.vehicle.var_116CE.var_4E12[var_0])) {
    self.var_5960 = 1;
    wait(level.vehicle.var_116CE.var_4E12[var_0].delay);
  }

  if(!isDefined(self)) {
    return;
  }
  self gettimeremaining(self.origin + (23, 33, 64), 3);
  wait 2;

  if(!isDefined(self)) {
    return;
  }
  self.var_5960 = undefined;
}

isdestroyed() {
  if(!isDefined(self)) {
    return 0;
  }

  return isDefined(self.var_00ED);
}

func_12FC(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = self getentityvelocity();
    var_2 = vectornormalize(var_2);
    var_0 = vectornormalize(var_0);
    var_3 = vectorlerp(var_2, var_0, var_1);
    return var_3;
  } else
    return undefined;
}

func_12FB(var_0, var_1, var_2) {
  if(isdestroyed() || isDefined(self.var_9B65) && self.var_9B65) {
    return;
  }
  level notify("vehicle_explosion", self.origin);
  self notify("explode", self.origin);

  if(isDefined(self.var_9310) && self.var_9310) {
    return;
  }
  var_3 = self.vehicletype;
  var_4 = self.classname;

  if(var_1) {
    var_4 = "rocket_death" + var_4;
  }

  foreach(var_6 in level.vehicle.var_116CE.var_131BC[var_4]) {
    thread func_A5E1(var_0, var_6, var_3, var_2);
  }
}

func_A5E1(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1.var_136A1)) {
    if(var_1.var_136A1 >= 0) {
      wait(var_1.var_136A1);
    } else {
      self waittill("death_finished");
    }
  }

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_1.var_C174)) {
    self notify(var_1.var_C174);
  }

  if(isDefined(var_1.var_F1EA)) {
    scripts\engine\utility::delaycall(var_1.var_F1EA, ::delete);
  }

  if(isDefined(var_1.effect)) {
    if(var_1.var_2A4E && !isDefined(self.delete_on_death)) {
      if(isDefined(var_1.tag)) {
        if(isDefined(var_1.var_10E6A) && var_1.var_10E6A == 1) {
          thread func_B03F(var_1.effect, var_1.delay, var_1.tag);
        } else {
          thread func_D4C4(var_1.effect, var_1.delay, var_1.tag);
        }
      } else {
        var_4 = self.origin + (0, 0, 100) - self.origin;
        playFX(var_1.effect, self.origin, var_4);
      }
    } else if(isDefined(var_1.tag)) {
      var_4 = func_12FC(var_3, var_1.var_24DF);

      if(isDefined(var_4)) {
        var_5 = func_4E49();
        playFX(var_1.effect, var_5 gettagorigin(var_1.tag), var_4);

        if(isDefined(var_1.var_DFEC)) {
          var_5 scripts\engine\utility::delaycall(var_1.var_DFEC, ::delete);
        }
      } else {
        playFXOnTag(var_1.effect, func_4E49(), var_1.tag);

        if(isDefined(var_1.var_DFEC)) {
          func_4E49() scripts\engine\utility::delaycall(var_1.var_DFEC, ::delete);
        }
      }
    } else {
      var_4 = func_12FC(var_3, var_1.var_24DF);

      if(isDefined(var_4)) {
        playFX(var_1.effect, self.origin, var_4);
      } else {
        var_4 = self.origin + (0, 0, 100) - self.origin;
        playFX(var_1.effect, self.origin, var_4);
      }
    }
  }

  if(isDefined(var_1.sound) && !isDefined(self.delete_on_death)) {
    if(var_1.var_312E) {
      thread func_4E05(var_1.sound);
    } else {
      scripts\engine\utility::play_sound_in_space(var_1.sound);
    }
  }
}

func_B03F(var_0, var_1, var_2) {
  self endon("stop_looping_death_fx");

  while(isDefined(self)) {
    playFXOnTag(var_0, func_4E49(), var_2);
    wait(var_1);
  }
}

func_4E05(var_0) {
  thread scripts\sp\utility::play_loop_sound_on_tag(var_0, undefined, 0, 1);
  scripts\engine\utility::waittill_any("fire_extinguish", "stop_crash_loop_sound");

  if(!isDefined(self)) {
    return;
  }
  self notify("stop sound" + var_0);
}

func_4E49() {
  if(isDefined(self.var_4E0A) && self.var_4E0A) {
    return self;
  }

  if(!isDefined(self.var_4E49)) {
    var_0 = spawn("script_model", (0, 0, 0));
    var_0 setModel(self.model);
    var_0.origin = self.origin;
    var_0.angles = self.angles;
    var_0 notsolid();
    var_0 hide();
    var_0 linkto(self);
    self.var_4E49 = var_0;
  } else
    self.var_4E49 setModel(self.model);

  return self.var_4E49;
}

func_D4C4(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", self.origin);
  self endon("fire_extinguish");
  thread func_D4C5(var_2, var_3);

  for(;;) {
    playFX(var_0, var_3.origin, var_3.var_12F93);
    wait(var_1);
  }
}

func_D4C5(var_0, var_1) {
  var_1.angles = self gettagangles(var_0);
  var_1.origin = self gettagorigin(var_0);
  var_1.var_7337 = anglesToForward(var_1.angles);
  var_1.var_12F93 = anglestoup(var_1.angles);

  while(isDefined(self) && self.code_classname == "script_vehicle" && self vehicle_getspeed() > 0) {
    var_1.angles = self gettagangles(var_0);
    var_1.origin = self gettagorigin(var_0);
    var_1.var_7337 = anglesToForward(var_1.angles);
    var_1.var_12F93 = anglestoup(var_1.angles);
    wait 0.05;
  }
}

func_A5BF(var_0) {
  if(!isDefined(level.vehicle.var_116CE.var_4DFC[var_0])) {
    return;
  }
  var_1 = level.vehicle.var_116CE.var_4DFC[var_0];

  if(isDefined(var_1.delay)) {
    wait(var_1.delay);
  }

  if(!isDefined(self)) {
    return;
  }
  badplace_cylinder("vehicle_kill_badplace", var_1.var_5F36, self.origin, var_1.radius, var_1.height, var_1.var_115A4, var_1.var_115A5);
}

func_129E4(var_0) {
  if(isDefined(self)) {
    if(isDefined(var_0.var_51AD)) {
      wait(var_0.var_51AD);
    }
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

func_12B8(var_0, var_1) {
  var_2 = [];

  if(isDefined(var_0) && isDefined(var_1)) {
    var_3 = 1;
    var_4 = getEntArray(var_0, var_1);
  } else {
    var_3 = 0;
    var_4 = getEntArray("script_vehicle", "code_classname");
  }

  foreach(var_6 in var_4) {
    if(var_3 && var_6.code_classname != "script_vehicle") {
      continue;
    }
    if(_isspawner(var_6)) {
      var_2[var_2.size] = var_6;
    }
  }

  return var_2;
}

func_1322D(var_0) {
  foreach(var_2 in self.var_E4FB) {
    if(isai(var_2)) {
      var_2 scripts\sp\utility::func_F3B5(var_0);
      continue;
    }

    if(isDefined(var_2.spawner)) {
      var_2.spawner.var_EDAD = var_0;
      continue;
    }
  }
}

func_12E33(var_0) {
  if(var_0.var_12E3C == gettime()) {
    return var_0.var_10F82;
  }

  var_0.var_12E3C = gettime();

  if(var_0.var_10F83) {
    var_1 = clamp(0 - var_0.angles[2], 0 - var_0.var_10F85, var_0.var_10F85) / var_0.var_10F85;

    if(isDefined(var_0.var_AAF3) && var_0.var_AAF3) {
      var_2 = var_0 _meth_83DE();
      var_2 = var_2 * -1.0;
      var_1 = var_1 + var_2;

      if(var_1 != 0) {
        var_3 = 1.0 / abs(var_1);

        if(var_3 < 1) {
          var_1 = var_1 * var_3;
        }
      }
    }

    var_4 = var_1 - var_0.var_10F82;

    if(var_4 != 0) {
      var_5 = var_0.var_10F84 / abs(var_4);

      if(var_5 < 1) {
        var_4 = var_4 * var_5;
      }

      var_0.var_10F82 = var_0.var_10F82 + var_4;
    }
  } else
    var_0.var_10F82 = 0;

  return var_0.var_10F82;
}

func_79D5(var_0) {
  return scripts\engine\utility::getstruct(var_0, "targetname");
}

func_79D3(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(isDefined(var_1) && var_1.size > 0) {
    return var_1[randomint(var_1.size)];
  }

  return undefined;
}

func_79D7(var_0) {
  return getvehiclenode(var_0, "targetname");
}

func_F471(var_0) {
  var_1 = getent(var_0.script_linkto, "script_linkname");

  if(!isDefined(var_1)) {
    return;
  }
  self setlookatent(var_1);
  self.var_F472 = 1;
}

func_4CFC() {
  level.var_2184 = 0;
  self.var_56DE = 0;
  thread func_4CFE();

  while(isDefined(self)) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(!isplayer(var_1)) {
      continue;
    }
    if(isDefined(self.var_8BA9)) {
      continue;
    }
    var_4 = tolower(var_4);

    switch (var_4) {
      case "bullet":
      case "mod_rifle_bullet":
      case "mod_pistol_bullet":
        if(!level.var_2184) {
          if(isDefined(level.var_11829) && level.var_11829 > 0) {
            break;
          }
          level.var_2184 = 1;
          self.var_56DE = 1;
          var_1 scripts\sp\utility::func_56BA("invulerable_bullets");
          wait 4;
          level.var_2184 = 0;

          if(isDefined(self)) {
            self.var_56DE = 0;
          }

          break;
        }
    }
  }
}

func_4CFD() {
  level.var_2184 = 0;
  self.var_56DE = 0;
  thread func_4CFE();

  while(isDefined(self)) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(!isplayer(var_1)) {
      continue;
    }
    if(isDefined(self.var_8BA9)) {
      continue;
    }
    var_4 = tolower(var_4);

    switch (var_4) {
      case "mod_grenade_splash":
      case "mod_grenade":
      case "bullet":
      case "mod_rifle_bullet":
      case "mod_pistol_bullet":
        if(!level.var_2184) {
          if(isDefined(level.var_11829) && level.var_11829 > 0) {
            break;
          }
          level.var_2184 = 1;
          self.var_56DE = 1;

          if(var_4 == "mod_grenade" || var_4 == "mod_grenade_splash") {
            var_1 scripts\sp\utility::func_56BA("invulerable_frags");
          } else {
            var_1 scripts\sp\utility::func_56BA("invulerable_bullets");
          }

          wait 4;
          level.var_2184 = 0;

          if(isDefined(self)) {
            self.var_56DE = 0;
          }

          break;
        }
    }
  }
}

func_4CFE() {
  self waittill("death");

  if(self.var_56DE) {
    level.var_2184 = 0;
  }
}

func_1A93(var_0) {
  self endon("death");
  self endon("death_finished");
  self notify("stop_kicking_up_dust");
  self endon("stop_kicking_up_dust");
  var_1 = 2000;

  if(isDefined(level.var_126F3)) {
    var_1 = level.var_126F3;
  }

  var_2 = 80 / var_1;
  var_3 = 0.5;

  if(func_12F6()) {
    var_3 = 0.15;
  }

  var_4 = self;

  if(isDefined(var_0)) {
    var_4 = var_0;
  }

  var_5 = 3;

  for(;;) {
    wait(var_3);

    if(1) {
      if(isDefined(self.var_55A4) && self.var_55A4) {
        continue;
      }
      if(isDefined(self.var_126F3)) {
        var_1 = self.var_126F3;
      }

      var_6 = anglestoup(var_4.angles) * -1;
      var_7 = undefined;
      var_5++;

      if(var_5 > 3) {
        var_5 = 3;
        var_7 = scripts\engine\trace::ray_trace(var_4.origin, var_4.origin + var_6 * var_1, var_4, undefined, 1);
      }

      if(var_7["fraction"] == 1 || var_7["fraction"] < var_2) {
        continue;
      }
      var_8 = distance(var_4.origin, var_7["position"]);
      var_9 = func_7D53(self, var_7, var_6, var_8);

      if(!isDefined(var_9)) {
        continue;
      }
      var_3 = (var_8 - 350) / (var_1 - 350) * 0.1 + 0.05;
      var_3 = max(var_3, 0.05);

      if(!isDefined(var_7)) {
        continue;
      }
      if(!isDefined(var_7["position"])) {
        continue;
      }
      var_10 = var_7["position"];
      var_11 = var_7["normal"];
      var_8 = vectordot(var_10 - var_4.origin, var_11);
      var_12 = var_4.origin + (0, 0, var_8);
      var_13 = var_10 - var_12;

      if(isDefined(self.var_126F4)) {
        var_13 = var_10 - level.player.origin;
      }

      if(vectordot(var_7["normal"], (0, 0, 1)) == -1) {
        continue;
      }
      if(length(var_13) < 1) {
        var_13 = var_4.angles + (0, 180, 0);
      }

      playFX(var_9, var_10, var_11, var_13);
    }
  }
}

func_7D53(var_0, var_1, var_2, var_3) {
  var_4 = var_1["surfacetype"];
  var_5 = undefined;
  var_6 = vectordot((0, 0, -1), var_2);

  if(var_6 >= 0.97) {
    var_5 = undefined;
  } else if(var_6 >= 0.92) {
    var_5 = "_bank";
  } else {
    var_5 = "_bank_lg";
  }

  return func_7D52(var_0.classname, var_4, var_5);
}

func_7D52(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = var_1 + var_2;

    if(!isDefined(level.vehicle.var_116CE.var_112D9[var_0][var_3]) && var_1 != "default") {
      return func_7D52(var_0, "default", var_2);
    } else {
      return level.vehicle.var_116CE.var_112D9[var_0][var_3];
    }
  }

  return func_7D44(var_0, var_1);
}

func_7D44(var_0, var_1) {
  if(!isDefined(level.vehicle.var_116CE.var_112D9[var_0][var_1]) && var_1 != "default") {
    return func_7D44(var_0, "default");
  } else {
    return level.vehicle.var_116CE.var_112D9[var_0][var_1];
  }

  return undefined;
}

func_C018() {
  return func_12F8() || func_12F6();
}

func_12F8() {
  return isDefined(level.vehicle.var_116CE.var_8DB1[self.vehicletype]);
}

func_12F6() {
  return isDefined(level.vehicle.var_116CE.var_1AE5[self.vehicletype]);
}

func_8BFC() {
  if(!func_12F8() && !func_12F6()) {
    return 0;
  }

  return 1;
}

func_8BFD() {
  if(!isDefined(self.vehicletype)) {
    return 0;
  }

  if(self.vehicletype == "cobra") {
    return 1;
  }

  if(self.vehicletype == "cobra_player") {
    return 1;
  }

  if(self.vehicletype == "viper") {
    return 1;
  }

  return 0;
}

func_5636() {
  self endon("death");
  var_0 = 0;

  if(isDefined(self.script_disconnectpaths) && !self.script_disconnectpaths) {
    var_0 = 1;
  }

  if(var_0) {
    self.var_5958 = 1;
    return;
  }

  wait(randomfloat(1));

  while(isDefined(self)) {
    if(self vehicle_getspeed() < 1) {
      if(!isDefined(self.var_5958)) {
        self disconnectpaths();
      }

      self notify("speed_zero_path_disconnect");

      while(self vehicle_getspeed() < 1) {
        if(isDefined(self.var_5958) && self.var_5958) {
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
  var_0 = self.classname;

  if(isDefined(self.var_EE5E) && self.var_EE5E > 0) {
    return;
  }
  if(!isDefined(level.vehicle.var_116CE.mgturret[var_0])) {
    return;
  }
  var_1 = 0;

  if(isDefined(self.var_EE14)) {
    var_1 = self.var_EE14;
  }

  var_2 = level.vehicle.var_116CE.mgturret[var_0];

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = isDefined(self.script_noteworthy) && self.script_noteworthy == "onemg";
  var_4 = "";

  if(isDefined(self.var_EEF9)) {
    var_4 = self.var_EEF9;
  }

  foreach(var_8, var_6 in var_2) {
    if(isDefined(var_6.var_DE46) && !issubstr(var_4, var_6.var_DE46)) {
      continue;
    }
    var_7 = spawnturret("misc_turret", (0, 0, 0), var_6.info);

    if(isDefined(var_6.var_C367)) {
      var_7 linkto(self, var_6.tag, var_6.var_C367, (0, -1 * var_1, 0));
    } else {
      var_7 linkto(self, var_6.tag, (0, 0, 0), (0, -1 * var_1, 0));
    }

    var_7 setModel(var_6.model);
    var_7.angles = self.angles;
    var_7.var_9FF0 = 1;
    var_7.var_C841 = self;
    var_7.script_team = self.script_team;
    var_7 thread scripts\sp\mgturret::func_32B7();
    var_7 makeunusable();
    func_F5D8(var_7);
    level thread scripts\sp\mgturret::func_B6A7(var_7, scripts\sp\utility::func_7E72());

    if(isDefined(self.var_ED98)) {
      var_7.var_ED98 = self.var_ED98;
    }

    if(isDefined(var_6.var_51AD)) {
      var_7.var_51AD = var_6.var_51AD;
    }

    if(isDefined(var_6.var_01D2)) {
      var_7.var_01D2 = var_6.var_01D2;
    }

    if(isDefined(var_6.var_5035)) {
      var_7 setdefaultdroppitch(var_6.var_5035);
    }

    if(isDefined(var_6.var_DE46)) {
      var_7.var_DE46 = var_6.var_DE46;
    }

    self.mgturret[var_8] = var_7;

    if(var_3) {
      break;
    }
  }

  foreach(var_11, var_7 in self.mgturret) {
    var_10 = level.vehicle.var_116CE.mgturret[var_0][var_11].var_5041;

    if(isDefined(var_10)) {
      var_7 func_12A29(var_10);
    }
  }

  if(!isDefined(self.var_EEF8)) {
    self.var_EEF8 = 1;
  }

  if(self.var_EEF8 == 0) {
    thread func_134C();
  } else {
    self.var_EEF8 = 1;
    thread func_134D();
  }
}

func_12A29(var_0) {
  self.var_5041 = var_0;
}

func_F5D8(var_0) {
  switch (self.script_team) {
    case "friendly":
    case "allies":
      var_0 setturretteam("allies");
      break;
    case "enemy":
    case "axis":
      var_0 setturretteam("axis");
      break;
    case "team3":
      var_0 setturretteam("team3");
      break;
    default:
      break;
  }
}

func_1F6E() {
  self endon("suspend_drive_anims");

  if(!isDefined(self.var_13D02)) {
    self.var_13D02 = 1;
  }

  var_0 = self.model;
  var_1 = -1;
  var_2 = undefined;
  self glinton(#animtree);

  if(!isDefined(level.vehicle.var_116CE.var_5BC3[var_0])) {
    return;
  }
  if(!isDefined(level.vehicle.var_116CE.var_5BC6[var_0])) {
    level.vehicle.var_116CE.var_5BC6[var_0] = level.vehicle.var_116CE.var_5BC3[var_0];
  }

  self endon("death");
  var_3 = level.vehicle.var_116CE.var_5BC5[var_0];
  var_4 = 1.0;

  if(isDefined(level.vehicle.var_116CE.var_5BC4) && isDefined(level.vehicle.var_116CE.var_5BC4[var_0])) {
    var_4 = level.vehicle.var_116CE.var_5BC4[var_0];
  }

  var_5 = self.var_13D02;
  var_6 = level.vehicle.var_116CE.var_5BC3[var_0];

  for(;;) {
    if(!var_3) {
      if(isDefined(self.var_112FB)) {
        wait 0.05;
        continue;
      }

      self give_attacker_kill_rewards(level.vehicle.var_116CE.var_5BC3[var_0], 1, 0.2, var_4);
      return;
    }

    var_7 = self vehicle_getspeed();

    if(var_5 != self.var_13D02) {
      var_8 = 0;

      if(self.var_13D02) {
        var_6 = level.vehicle.var_116CE.var_5BC3[var_0];
        var_8 = 1 - func_7B21(level.vehicle.var_116CE.var_5BC6[var_0]);
        self clearanim(level.vehicle.var_116CE.var_5BC6[var_0], 0);
      } else {
        var_6 = level.vehicle.var_116CE.var_5BC6[var_0];
        var_8 = 1 - func_7B21(level.vehicle.var_116CE.var_5BC3[var_0]);
        self clearanim(level.vehicle.var_116CE.var_5BC3[var_0], 0);
      }

      var_2 = 0.01;

      if(var_2 >= 1 || var_2 == 0) {
        var_2 = 0.01;
      }

      var_5 = self.var_13D02;
    }

    var_9 = var_7 / var_3;

    if(var_9 != var_1) {
      self give_attacker_kill_rewards(var_6, 1, 0.05, var_9);
      var_1 = var_9;
    }

    if(isDefined(var_2)) {
      self _meth_82B0(var_6, var_2);
      var_2 = undefined;
    }

    wait 0.05;
  }
}

func_FA7A(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(_isspawner(var_3)) {
      continue;
    } else {
      var_1[var_1.size] = var_3;
    }
  }

  foreach(var_6 in var_1) {
    thread func_131F6(var_6);
  }
}

func_13203() {
  var_0 = self.classname;

  if(!isDefined(level.vehicle.var_116CE.var_AC4A) || !isDefined(level.vehicle.var_116CE.var_AC4A[var_0])) {
    wait 2;
  }

  if(isDefined(self.var_EEC8)) {
    self.health = self.var_EEC8;
  } else if(level.vehicle.var_116CE.var_AC4A[var_0] == -1) {
    return;
  } else if(isDefined(level.vehicle.var_116CE.var_AC4D[var_0]) && isDefined(level.vehicle.var_116CE.var_AC4C[var_0])) {
    self.health = randomint(level.vehicle.var_116CE.var_AC4C[var_0] - level.vehicle.var_116CE.var_AC4D[var_0]) + level.vehicle.var_116CE.var_AC4D[var_0];
  } else {
    self.health = level.vehicle.var_116CE.var_AC4A[var_0];
  }
}

func_7B21(var_0) {
  var_1 = self islegacyagent(var_0);
  var_2 = getanimlength(var_0);

  if(var_1 == 0) {
    return 0;
  }

  return self islegacyagent(var_0) / getanimlength(var_0);
}

func_112FA() {
  self notify("suspend_drive_anims");
  var_0 = self.model;
  self clearanim(level.vehicle.var_116CE.var_5BC3[var_0], 0);
  self clearanim(level.vehicle.var_116CE.var_5BC6[var_0], 0);
}

func_92D3() {
  self glinton(#animtree);

  if(!isDefined(level.vehicle.var_116CE.var_92D0[self.model])) {
    return;
  }
  foreach(var_1 in level.vehicle.var_116CE.var_92D0[self.model]) {
    self give_attacker_kill_rewards(var_1);
  }
}

func_1322A() {
  self endon("kill_rumble_forever");
  var_0 = self.classname;
  var_1 = undefined;

  if(isDefined(self.var_1322C)) {
    var_1 = self.var_1322C;
  } else if(isDefined(level.vehicle.var_116CE.var_E7BA[var_0])) {
    var_1 = level.vehicle.var_116CE.var_E7BA[var_0];
  }

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_1.radius * 2;
  var_3 = -1 * var_1.radius;
  var_4 = spawn("trigger_radius", self.origin + (0, 0, var_3), 0, var_1.radius, var_2);
  var_4 getrankxp();
  var_4 linkto(self);
  self.var_E7D2 = var_4;
  self endon("death");

  if(!isDefined(self.var_E7D0)) {
    self.var_E7D0 = 1;
  }

  if(isDefined(var_1.var_EB9C)) {
    self.var_E7CB = var_1.var_EB9C;
  } else {
    self.var_E7CB = 0.15;
  }

  if(isDefined(var_1.var_5F36)) {
    self.var_E7C0 = var_1.var_5F36;
  } else {
    self.var_E7C0 = 4.5;
  }

  if(isDefined(var_1.radius)) {
    self.var_E7C6 = var_1.radius;
  } else {
    self.var_E7C6 = 600;
  }

  if(isDefined(var_1.var_28AE)) {
    self.var_E7BE = var_1.var_28AE;
  } else {
    self.var_E7BE = 1;
  }

  if(isDefined(var_1.var_DCA5)) {
    self.var_E7CA = var_1.var_DCA5;
  } else {
    self.var_E7CA = 1;
  }

  var_4.radius = self.var_E7C6;

  for(;;) {
    var_4 waittill("trigger");

    if(self vehicle_getspeed() == 0 && !isDefined(self.var_72DB) || !self.var_E7D0) {
      wait 0.1;
      continue;
    }

    self _meth_8244(var_1.var_E7BA);

    if(isDefined(self.vehicletype)) {
      var_5 = self.vehicletype + "_rumble_sfx";

      if(soundexists(var_5)) {
        level.player playSound(var_5);
      }
    }

    while(level.player istouching(var_4) && self.var_E7D0 && (self vehicle_getspeed() > 0 || isDefined(self.var_72DB))) {
      earthquake(self.var_E7CB, self.var_E7C0, self.origin, self.var_E7C6);
      wait(self.var_E7BE + randomfloat(self.var_E7CA));
    }

    self stoprumble(var_1.var_E7BA);
  }
}

func_1322F() {
  var_0 = self.classname;

  if(!isDefined(self.script_team) && isDefined(level.vehicle.var_116CE.team[var_0])) {
    self.script_team = level.vehicle.var_116CE.team[var_0];
  }
}

func_131EC() {
  self endon("death");
  var_0 = self.vehicletype;

  if(!scripts\sp\utility::func_65DF("unloaded")) {
    scripts\sp\utility::func_65E0("unloaded");
  }
}

func_7D48(var_0) {
  var_1 = getvehiclenode(var_0, "targetname");

  if(!isDefined(var_1)) {
    var_1 = getent(var_0, "targetname");
  } else if(func_12F8()) {}

  if(!isDefined(var_1)) {
    var_1 = scripts\engine\utility::getstruct(var_0, "targetname");
  }

  return var_1;
}

func_8B7F() {
  return isDefined(level.vehicle.var_116CE.var_7448[self.vehicletype]);
}

func_85DA(var_0) {
  if(!isDefined(self.var_EDD3)) {
    return 0;
  }

  var_0 = tolower(var_0);

  if(!isDefined(var_0) || !issubstr(var_0, "grenade")) {
    return 0;
  }

  if(self.var_EDD3) {
    return 1;
  } else {
    return 0;
  }
}

func_324F(var_0) {
  if(!isDefined(self.var_ED22)) {
    return 0;
  }

  var_0 = tolower(var_0);

  if(!isDefined(var_0) || !issubstr(var_0, "bullet") || issubstr(var_0, "explosive")) {
    return 0;
  }

  if(self.var_ED22) {
    return 1;
  } else {
    return 0;
  }
}

func_69F8(var_0) {
  if(!isDefined(self.var_ED87)) {
    return 0;
  }

  var_0 = tolower(var_0);

  if(!isDefined(var_0) || !issubstr(var_0, "explosive")) {
    return 0;
  }

  if(self.var_ED87) {
    return 1;
  } else {
    return 0;
  }
}

func_13234(var_0, var_1) {
  return !isDefined(var_0) && self.script_team != "neutral" || func_24DC(var_0) || func_24DE(var_0) || isdestroyed() || func_9C29(var_0) || func_324F(var_1) || func_69F8(var_1) || func_85DA(var_1) || var_1 == "MOD_MELEE";
}

func_740E() {
  self endon("death");

  if(!isDefined(level.var_12D6B)) {
    self endon("stop_friendlyfire_shield");
  }

  if(isDefined(level.vehicle.var_116CE.var_323D[self.classname]) && !isDefined(self.var_ED22)) {
    self.var_ED22 = level.vehicle.var_116CE.var_323D[self.classname];
  }

  if(isDefined(level.vehicle.var_116CE.missileoutline[self.classname]) && !isDefined(self.var_EDD3)) {
    self.var_EDD3 = level.vehicle.var_116CE.var_323D[self.classname];
  }

  if(isDefined(self.var_EE50)) {
    self.var_EE50 = 1;
    self.var_3233 = 5000;
    self.health = 350;
  } else
    self.var_EE50 = 0;

  self.var_8CB6 = 20000;
  self.health = self.health + self.var_8CB6;
  self.var_4BF0 = self.health;
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;

  while(self.health > 0) {
    self waittill("damage", var_3, var_0, var_4, var_5, var_1, var_6, var_7, var_8, var_9, var_2);

    foreach(var_11 in self.var_4CF5) {
      thread[[var_11]](var_3, var_0, var_4, var_5, var_1, var_6, var_7);
    }

    if(isDefined(var_0)) {
      var_0 scripts\sp\player_stats::func_DED8();
    }

    if(func_13234(var_0, var_1) || func_12F0()) {
      self.health = self.var_4BF0;
    } else if(func_8B7F()) {
      func_DE7F(var_0, var_3);
      self.var_4BF0 = self.health;
    } else if(func_9029(var_1)) {
      self.health = self.var_4BF0;
      self.var_3233 = self.var_3233 - var_3;
    } else
      self.var_4BF0 = self.health;

    if(self.health < self.var_8CB6 && !isDefined(self.var_13243)) {
      break;
    }
  }

  self notify("death", var_0, var_1, var_2);
}

func_9029(var_0) {
  if(!self.var_EE50) {
    return 0;
  }

  if(self.var_3233 <= 0) {
    return 0;
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  if(!issubstr(var_0, "BULLET")) {
    return 0;
  } else {
    return 1;
  }
}

func_DE7F(var_0, var_1) {
  var_2 = anglesToForward(self.angles);
  var_3 = vectornormalize(var_0.origin - self.origin);

  if(vectordot(var_2, var_3) > 0.86) {
    self.health = self.health + int(var_1 * level.vehicle.var_116CE.var_7448[self.vehicletype]);
  }
}

func_12F0() {
  if(isDefined(self._meth_843F) && self._meth_843F) {
    return 1;
  } else {
    return 0;
  }
}

func_9C29(var_0) {
  if(!isDefined(self.var_ECE6)) {
    return 0;
  }

  if(isDefined(var_0) && isai(var_0) && self.var_ECE6 == 1) {
    return 1;
  } else {
    return 0;
  }
}

func_24DE(var_0) {
  if(isDefined(self.script_team) && self.script_team == "allies" && isDefined(var_0) && isplayer(var_0)) {
    return 1;
  } else if(isai(var_0) && var_0.team == self.script_team) {
    return 1;
  } else {
    return 0;
  }
}

func_24DC(var_0) {
  if(isDefined(var_0) && isDefined(var_0.script_team) && isDefined(self.script_team) && var_0.script_team == self.script_team) {
    return 1;
  }

  return 0;
}

vehicle_builds() {
  return func_143C();
}

func_13D03(var_0) {
  self.var_13D02 = scripts\engine\utility::ter_op(var_0 <= 0, 0, 1);
}

func_B248() {
  if(isDefined(level.var_B249)) {
    thread[[level.var_B249]]();
    return;
  }

  var_0 = self.model;

  if(!isDefined(level.vehicle.var_116CE.var_4F6B[var_0])) {
    return;
  }
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");
    playFXOnTag(level.vehicle.var_116CE.var_4F6B[var_0], self, "tag_engine_exhaust");
    var_1 = self gettagorigin("tag_flash");
    var_2 = _physicstrace(var_1, var_1 + (0, 0, -128));
    physicsexplosionsphere(var_2, 192, 100, 1);
  }
}

func_D546() {
  self endon("death");
  var_0 = self.model;

  if(!isDefined(level.vehicle.var_116CE.var_693A[var_0])) {
    return;
  }
  var_1 = 0.1;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(!isalive(self)) {
      return;
    }
    playFXOnTag(level.vehicle.var_116CE.var_693A[var_0], self, "tag_engine_exhaust");
    wait(var_1);
  }
}

func_13219() {
  self.var_247E = undefined;
  self notify("newpath");
  self setgoalyaw(scripts\engine\utility::flat_angle(self.angles)[1]);
  self setvehgoalpos(self.origin + (0, 0, 4), 1);
}

func_4E5C() {
  if(self.health > 0) {
    self.var_E683 = 1;
  }
}

func_4E5B() {
  self.var_E683 = undefined;
  self notify("deathrolloff");
}

func_134C() {
  self.var_EEF8 = 0;

  if(func_12F8() && func_8BFD()) {
    if(isDefined(level.var_3F23)) {
      self thread[[level.var_3F24]]();
      return;
    }
  }

  if(!isDefined(self.mgturret)) {
    return;
  }
  foreach(var_2, var_1 in self.mgturret) {
    if(isDefined(var_1.var_ED98)) {
      var_1.var_ED98 = 0;
    }

    var_1 give_player_session_tokens("manual");
  }
}

func_134D() {
  self.var_EEF8 = 1;

  if(func_12F8() && func_8BFD()) {
    self thread[[level.var_3F25]]();
    return;
  }

  if(!isDefined(self.mgturret)) {
    return;
  }
  foreach(var_1 in self.mgturret) {
    var_1 show();

    if(isDefined(var_1.var_ED98)) {
      var_1.var_ED98 = 1;
    }

    if(isDefined(var_1.var_5041)) {
      if(var_1.var_5041 != "sentry") {
        var_1 give_player_session_tokens(var_1.var_5041);
      }
    } else
      var_1 give_player_session_tokens("auto_nonai");

    func_F5D8(var_1);
  }
}

func_7D47() {
  var_0 = [];

  if(isDefined(self.target)) {
    var_1 = _getspawnerarray(self.target);

    foreach(var_3 in var_1) {
      if(!issubstr(var_3.code_classname, "actor") && !issubstr(var_3.code_classname, "vehicle")) {
        continue;
      }
      if(issubstr(var_3.code_classname, "actor")) {
        if(!_isspawner(var_3)) {
          continue;
        } else if(issubstr(var_3.code_classname, "vehicle")) {
          if(!(var_3.spawnflags & 2)) {
            continue;
          }
        }
      }

      if(isDefined(var_3.var_5941)) {
        continue;
      }
      var_0[var_0.size] = var_3;
    }

    if(isDefined(level.var_107A7)) {
      var_1 = scripts\engine\utility::getstructarray(self.target, "targetname");

      foreach(var_3 in var_1) {
        if(isDefined(var_3.var_EEB6)) {
          var_0[var_0.size] = var_3;
        }
      }
    }
  }

  return var_0;
}

func_1444(var_0) {
  if(isDefined(var_0.var_ED52)) {
    var_0 endon("death");
    wait(var_0.var_ED52);
  }

  var_1 = var_0 global_physics_sound_monitor();

  if(!isDefined(var_0.var_1084E)) {
    var_0.var_1084E = 0;
  }

  var_0.var_1084E++;
  var_0.var_1323B = var_1;
  var_0.var_A90E = var_1;
  var_0 thread func_E0A7();
  var_1.var_1323C = var_0;

  if(isDefined(var_0.var_12841)) {
    var_1.var_12841 = var_0.var_12841;
  }

  thread func_131F6(var_1);
  var_0 notify("spawned", var_1);
  return var_1;
}

func_D808() {
  var_0 = [];
  var_1 = getEntArray("script_vehicle", "code_classname");
  level.var_BE91 = [];
  var_2 = [];
  var_0 = [];

  if(!isDefined(level.var_13261)) {
    level.var_13261 = [];
  }

  foreach(var_4 in var_1) {
    var_4.vehicletype = tolower(var_4.vehicletype);

    if(var_4.vehicletype == "empty" || var_4.vehicletype == "empty_heli") {
      continue;
    }
    if(isDefined(var_4.spawnflags) && var_4.spawnflags & 1) {
      var_2[var_2.size] = var_4;
    }

    var_0[var_0.size] = var_4;

    if(!isDefined(level.var_13261[var_4.vehicletype])) {
      level.var_13261[var_4.vehicletype] = [];
    }

    var_5 = "classname: " + var_4.classname;
    func_D812(var_5, var_4);
  }

  if(level.var_BE91.size > 0) {
    foreach(var_8 in level.var_BE91) {}

    level waittill("never");
  }

  return var_0;
}

func_D812(var_0, var_1) {
  if(isDefined(level.var_13261[var_1.vehicletype][var_1.classname])) {
    return;
  }
  if(isDefined(level.vehicle.var_116CE.var_1325B) && isDefined(level.vehicle.var_116CE.var_1325B[var_1.classname])) {
    return;
  }
  if(var_1.classname == "script_vehicle") {
    return;
  }
  var_2 = 0;

  foreach(var_4 in level.var_BE91) {
    if(var_4 == var_0) {
      var_2 = 1;
    }
  }

  if(!var_2) {
    level.var_BE91[level.var_BE91.size] = var_0;
  }
}

func_F9C7() {
  if(!scripts\engine\utility::add_init_script("vehicle_vars", ::func_F9C7)) {
    return;
  }
  scripts\engine\utility::struct_class_init();
  level.vehicle = spawnStruct();
  level.vehicle.var_116CE = spawnStruct();
  level.vehicle.var_8DAA = getEntArray("helicopter_crash_location", "targetname");
  level.vehicle.var_8DAA = scripts\engine\utility::array_combine(level.vehicle.var_8DAA, scripts\sp\utility::_meth_8181("helicopter_crash_location", "targetname"));
  level.vehicle.var_116CE.team = [];
  level.vehicle.var_116CE.var_4E4E = [];
  level.vehicle.var_116CE.var_4E23 = [];
  level.vehicle.var_116CE.var_5BC3 = [];
  level.vehicle.var_116CE.var_5BC6 = [];
  level.vehicle.var_116CE.var_E7BA = [];
  level.vehicle.var_116CE.mgturret = [];
  level.vehicle.var_116CE.var_4E02 = [];
  level.vehicle.var_116CE.var_112D9 = [];
  level.vehicle.var_116CE.var_12BCF = [];
  level.vehicle.var_116CE.var_1A03 = [];
  level.vehicle.var_116CE.var_A7C5 = [];
  level.vehicle.var_116CE.var_693A = [];
  level.vehicle.var_116CE.var_4F6B = [];
  level.vehicle.var_116CE.var_FE7C = [];
  level.vehicle.var_116CE.var_8E9D = [];
  level.vehicle.var_116CE.var_7448 = [];
  level.vehicle.var_116CE.var_535B = [];
  level.vehicle.var_116CE.missileoutline = [];
  level.vehicle.var_116CE.var_323D = [];
  level.vehicle.var_116CE.var_4E12 = [];
  level.vehicle.var_116CE.var_4DFC = [];
  level.vehicle.var_116CE.var_92D0 = [];
  level.vehicle.var_116CE.var_8DB1 = [];
  level.vehicle.var_116CE.var_1AE5 = [];
  level.vehicle.var_116CE.var_1020A = [];
  level.vehicle.var_116CE.var_4DF9 = [];
  level.vehicle.var_116CE.var_131BC = [];

  if(!isDefined(level.vehicle.var_116CE.var_4E1C)) {
    level.vehicle.var_116CE.var_4E1C = [];
  }

  scripts\sp\vehicle_aianim::func_F8AE();
}

func_FB0A(var_0, var_1) {
  return _setvehgoalpos_wrap(var_0, var_1);
}

func_13207(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 512;
  }

  var_1 = self.origin + (0, 0, var_0);
  self setneargoalnotifydist(10);
  func_FB0A(var_1, 1);
  self waittill("goal");
}

func_10810(var_0) {
  var_1 = [];
  var_2 = getEntArray(var_0, "targetname");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(!isDefined(var_5.code_classname) || var_5.code_classname != "script_vehicle") {
      continue;
    }
    if(_isspawner(var_5)) {
      var_1[var_1.size] = func_1444(var_5);
    }
  }

  return var_1;
}

func_A5CC(var_0) {
  if(!isDefined(level.vehicle.var_116CE.var_4DF9[var_0])) {
    return;
  }
  if(isDefined(self.var_10263) && self.var_10263) {
    return;
  }
  if(isarray(level.vehicle.var_116CE.var_4DF9[var_0])) {
    if(isDefined(self.var_D832)) {
      var_1 = self.var_D832;
    } else {
      var_1 = scripts\engine\utility::random(level.vehicle.var_116CE.var_4DF9[var_0]);
    }

    return func_A5CD(var_1);
  }

  return func_A5CD(level.vehicle.var_116CE.var_4DF9[var_0]);
}

func_A5CD(var_0) {
  self.var_A648 = 1;
  var_1 = scripts\engine\utility::spawn_tag_origin();
  self _meth_83E3(var_1.origin, var_1.angles, 0, 0);
  self _meth_83E8();
  self notify("kill_death_anim", var_0);

  if(isstring(var_0)) {
    self setCanDamage(0);
    var_1 scripts\sp\anim::func_1F35(self, var_0);
  } else {
    self glinton(#animtree);
    self animscripted("vehicle_death_anim", var_1.origin, var_1.angles, var_0);
    self setneargoalnotifydist(30);
    self setvehgoalpos(var_1.origin, 1);
    self setgoalyaw(var_1.angles[1]);
    self waittillmatch("vehicle_death_anim", "end");
  }

  var_1 delete();
  thread func_50EA(7);
}

func_50EA(var_0) {
  wait 7;

  if(isDefined(self)) {
    self delete();
  }
}

func_5144() {
  var_0 = self getsecondspassed();
  var_1 = self getpointinbounds(1, 0, 0);
  var_2 = distance(var_1, var_0);
  var_3 = getcorpsearray();

  foreach(var_5 in var_3) {
    if(distance(var_5.origin, var_0) < var_2) {
      var_5 delete();
    }
  }
}