/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2966.gsc
**************************************/

_id_FA79() {
  var_0 = _id_12B8();

  foreach(var_2 in var_0)
  var_2 thread _id_1323A();
}

_id_1323A() {
  self endon("entitydeleted");

  if(isDefined(self._id_ED48))
    thread _id_0B77::_id_1323D();

  self.count = 1;
  self._id_10708 = [];

  for(;;) {
    var_0 = undefined;
    self waittill("spawned", var_0);
    self.count--;

    if(!isDefined(var_0)) {
      continue;
    }
    var_0._id_10707 = self._id_10708;
    var_0.spawner = self;
    var_0 thread _id_0B77::_id_E81A();
  }
}

_id_A629(var_0) {
  var_0 waittill("trigger");

  foreach(var_2 in vehicle_getspawnerarray()) {
    if(isDefined(var_2._id_EDF5) && var_2._id_EDF5 == self._id_EDF5)
      var_2 delete();
  }
}

#using_animtree("vehicles");

_id_1063F(var_0) {
  var_1 = [];
  var_2 = scripts\sp\utility::_id_65DF("no_riders_until_unload");

  foreach(var_4 in var_0) {
    var_4.count = 1;
    var_5 = 0;
    var_6 = 0;

    if(isDefined(var_4._id_ED6E)) {
      var_5 = 1;
      var_7 = scripts\sp\utility::_id_5CC9(var_4);
      var_7 _id_0B24::_id_5C21();
    } else if(isDefined(var_4._id_ED8A) || isDefined(var_4._id_ED1B)) {
      var_5 = 1;
      var_7 = scripts\sp\utility::_id_2C17(var_4);
      var_7 scripts\sp\fakeactor::_id_6B15();
    } else if(isDefined(var_4.code_classname) && var_4.code_classname == "script_vehicle") {
      var_6 = 1;
      var_8 = spawn("script_model", (0, 0, 0));
      var_8 setModel(var_4.model);
      var_8 _meth_83D0(#animtree);

      if(isDefined(var_4._id_EEC9))
        var_8._id_EEC9 = var_4._id_EEC9;

      var_8._id_9FEF = 1;
      var_8._id_1356F = var_4;
      var_7 = var_8;
    } else {
      var_9 = (isDefined(var_4._id_EECE) || isDefined(var_4._id_EED1)) && scripts\engine\utility::flag("stealth_enabled") && !scripts\engine\utility::flag("stealth_spotted");
      var_10 = var_4;

      if(isDefined(var_4._id_EEB6))
        var_10 = _id_0B77::_id_7C86(var_4, 1);

      if(isDefined(var_4._id_EDB3) || var_2)
        var_7 = var_10 _meth_8393(var_9);
      else
        var_7 = var_10 dospawn(var_9);

      if(isDefined(var_4._id_EEB6)) {
        if(isDefined(var_4._id_EEC9))
          var_7._id_EEC9 = var_4._id_EEC9;
      }
    }

    if(!var_5 && !var_6 && !isalive(var_7)) {
      continue;
    }
    var_1[var_1.size] = var_7;
  }

  var_1 = _id_E05D(var_1);
  return var_1;
}

_id_E05D(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!_id_19E4(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_19E4(var_0) {
  if(isalive(var_0))
    return 1;

  if(!isDefined(var_0))
    return 0;

  if(!isDefined(var_0.classname))
    return 0;

  return var_0.classname == "script_model";
}

spawn_group() {
  if(scripts\sp\utility::_id_65DF("no_riders_until_unload") && !scripts\sp\utility::_id_65DB("no_riders_until_unload"))
    return [];

  var_0 = _id_7D47();

  if(!var_0.size)
    return [];

  var_1 = [];
  var_2 = _id_1063F(var_0);
  var_2 = _id_1041B(var_2);

  foreach(var_4 in var_2)
  thread scripts\sp\vehicle_aianim::_id_8739(var_4);

  return var_2;
}

_id_10805(var_0) {
  if(!isDefined(var_0))
    return spawn_group();

  var_1 = _id_7D47();

  if(!var_1.size)
    return [];

  var_2 = [];
  var_3 = self.classname;

  if(isDefined(level.vehicle._id_116CE._id_12BCF[var_3]) && isDefined(level.vehicle._id_116CE._id_12BCF[var_3][var_0])) {
    var_4 = level.vehicle._id_116CE._id_12BCF[var_3][var_0];

    foreach(var_6 in var_4) {
      foreach(var_8 in var_1) {
        if(var_8._id_EEC9 == var_6)
          var_2[var_2.size] = var_8;
      }
    }

    var_11 = _id_1063F(var_2);

    for(var_12 = 0; var_12 < var_4.size; var_12++) {
      if(isDefined(var_11[var_12]))
        var_11[var_12]._id_EEC9 = var_4[var_12];
    }

    var_11 = _id_1041B(var_11);

    foreach(var_14 in var_11)
    thread scripts\sp\vehicle_aianim::_id_8739(var_14);

    return var_11;
  } else
    return spawn_group();
}

_id_1041B(var_0) {
  var_1 = [];
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(var_4._id_EEC9)) {
      var_1[var_1.size] = var_4;
      continue;
    }

    var_2[var_2.size] = var_4;
  }

  return scripts\engine\utility::array_combine(var_1, var_2);
}

_id_E0A7() {
  wait 0.05;
  self._id_1323B = undefined;
}

_id_131F6(var_0) {
  var_1 = var_0.classname;

  if(isDefined(level.vehicle._id_116CE._id_1325B) && isDefined(level.vehicle._id_116CE._id_1325B[var_1])) {
    var_0 thread[[level.vehicle._id_116CE._id_1325B[var_1]]]();
    return;
  }

  if(isDefined(level.vehicle._id_116CE._id_8E9D[var_1])) {
    foreach(var_3 in level.vehicle._id_116CE._id_8E9D[var_1])
    var_0 hidepart(var_3);
  }

  if(var_0.vehicletype == "empty" || var_0.vehicletype == "empty_heli") {
    var_0 thread scripts\sp\vehicle_paths::_id_8023();
    return;
  }

  var_0 scripts\sp\utility::_id_F294();

  if(!isDefined(var_0._id_B91F))
    var_0._id_B91F = 0;

  var_5 = var_0.vehicletype;
  var_0 _id_13203();
  var_0 _id_1322F();

  if(!isDefined(level._id_13261[var_0.vehicletype][var_0.classname])) {}

  var_0 thread[[level._id_13261[var_0.vehicletype][var_0.classname]]]();
  var_0 thread _id_B248();
  var_0 thread _id_D546();

  if(!isDefined(var_0._id_ED10))
    var_0._id_ED10 = 0;

  if(isDefined(level.vehicle.draw_thermal)) {
    if(level.vehicle.draw_thermal)
      var_0 thermaldrawenable();
  }

  var_0 scripts\sp\utility::_id_65E0("unloaded");
  var_0 scripts\sp\utility::_id_65E0("loaded");
  var_0 scripts\sp\utility::_id_65E0("landed");
  var_0._id_E4FB = [];
  var_0._id_12BD0 = [];
  var_0._id_12BBC = "default";
  var_0._id_6B9D = [];

  if(isDefined(level.vehicle._id_116CE._id_247D) && isDefined(level.vehicle._id_116CE._id_247D[var_1])) {
    var_6 = level.vehicle._id_116CE._id_247D[var_1];
    var_7 = getarraykeys(var_6);

    foreach(var_9 in var_7) {
      var_0._id_6B9D[var_9] = undefined;
      var_0._id_6B9E[var_9] = 0;
    }
  }

  var_0 thread vehicle_builds();

  if(isDefined(var_0._id_EF04))
    var_0 thread scripts\sp\vehicle_lights::lights_on(var_0._id_EF04);

  if(isDefined(var_0._id_EDD1))
    var_0._id_843F = 1;

  var_0._id_4CF5 = [];
  var_0 thread _id_740E();
  var_0 thread scripts\sp\vehicle_aianim::_id_88AE();

  if(isDefined(var_0._id_EDB8))
    var_0 setvehiclelookattext(var_0._id_EDB8, &"");

  var_0 thread _id_131EC();

  if(isDefined(var_0._id_ED6C))
    var_0._id_5971 = 1;

  var_0 thread _id_1322A();
  var_0 thread scripts\sp\vehicle_treads::_id_1324B();
  var_0 thread _id_92D3();
  var_0 thread _id_1F6E();

  if(isDefined(var_0._id_ED48))
    var_0 thread _id_0B77::_id_131C1();

  var_0 thread _id_B6B7();

  if(isDefined(level.vehicle._id_1066A))
    level thread[[level.vehicle._id_1066A]](var_0);

  if(isDefined(var_0.script_team))
    var_0 setvehicleteam(var_0.script_team);

  var_0 thread _id_5636();
  var_0 thread scripts\sp\vehicle_paths::_id_8023();

  if(isDefined(level._id_9334))
    var_11 = level._id_9334;
  else
    var_11 = 0;

  if(var_0 _id_8BFC() && !var_11)
    var_0 thread _id_1A93();

  if(var_0 _meth_83E2()) {
    var_0.veh_pathtype = "constrained";

    if(isDefined(var_0._id_EE7C))
      var_0.veh_pathtype = var_0._id_EE7C;
  }

  var_0 spawn_group();
  var_0 thread _id_131FA();
}

_id_A5CB(var_0) {
  if(!isDefined(level.vehicle._id_116CE._id_4E1C) || !isDefined(level.vehicle._id_116CE._id_4E1C[var_0])) {
    return;
  }
  if(isDefined(self._id_4E38))
    var_1 = self._id_4E38;
  else
    var_1 = level.vehicle._id_116CE._id_4E1C[var_0]._id_B48B;

  if(isDefined(self._id_4E39))
    var_2 = self._id_4E39;
  else
    var_2 = level.vehicle._id_116CE._id_4E1C[var_0]._id_B758;

  if(isDefined(level.vehicle._id_116CE._id_4E1C[var_0].delay))
    wait(level.vehicle._id_116CE._id_4E1C[var_0].delay);

  if(!isDefined(self)) {
    return;
  }
  if(level.vehicle._id_116CE._id_4E1C[var_0]._id_2B19)
    level.player _meth_80D0(0);

  self radiusdamage(self.origin + level.vehicle._id_116CE._id_4E1C[var_0].offset, level.vehicle._id_116CE._id_4E1C[var_0]._id_DCCA, var_1, var_2, self);

  if(level.vehicle._id_116CE._id_4E1C[var_0]._id_2B19)
    level.player _meth_80D0(1);
}

_id_131FA() {
  self endon("nodeath_thread");
  var_0 = 0;

  for(;;) {
    self waittill("death", var_1, var_2, var_3);

    if(isDefined(self._id_4C49))
      self thread[[self._id_4C49]]();

    if(!var_0) {
      var_0 = 1;

      if(isDefined(var_1) && isDefined(var_2)) {
        var_1 scripts\sp\player_stats::_id_DEBD(self, var_2, var_3);

        if(isDefined(self._id_4D28))
          self._id_4D28 = undefined;
      }
    }

    self notify("clear_c4");

    if(isDefined(self._id_E7D2))
      self._id_E7D2 delete();

    if(isDefined(self.mgturret)) {
      scripts\engine\utility::array_levelthread(self.mgturret, ::_id_129E4);
      self.mgturret = undefined;
    }

    if(!isDefined(self) || _id_9BA8()) {
      if(isDefined(self._id_E4FB)) {
        foreach(var_5 in self._id_E4FB) {
          if(isDefined(var_5))
            var_5 delete();
        }
      }

      if(_id_9BA8()) {
        self._id_E4FB = [];
        continue;
      }

      self notify("delete_destructible");
      return;
    }

    var_7 = undefined;

    if(isDefined(self._id_1322C))
      var_7 = self._id_1322C;
    else if(isDefined(level.vehicle._id_116CE._id_E7BA[self.classname]))
      var_7 = level.vehicle._id_116CE._id_E7BA[self.classname];

    if(isDefined(var_7))
      self stoprumble(var_7._id_E7BA);

    if(isDefined(level.vehicle._id_116CE._id_4E23[self.vehicletype]))
      thread[[level.vehicle._id_116CE._id_4E23[self.vehicletype]]]();

    scripts\engine\utility::array_levelthread(self._id_E4FB, scripts\sp\vehicle_aianim::_id_876B, var_1, self.vehicletype);
    thread _id_A5CB(self.classname);
    thread _id_A5BF(self.classname);
    thread scripts\sp\vehicle_lights::_id_A5F2(self.classname);
    _id_5144();

    if(isDefined(level.vehicle._id_116CE._id_4E4E[self.classname]))
      thread _id_F331(level.vehicle._id_116CE._id_4E4E[self.classname], level.vehicle._id_131C3[self.classname]);
    else if(isDefined(level.vehicle._id_116CE._id_4E4E[self.model]))
      thread _id_F331(level.vehicle._id_116CE._id_4E4E[self.model], level.vehicle._id_131C3[self.model]);

    var_8 = _id_13233(self.model, var_1, var_2);
    var_9 = self.origin;
    var_10 = undefined;

    if(isDefined(var_1)) {
      var_10 = self.origin - var_1.origin;
      var_10 = vectorNormalize(var_10);
    }

    thread _id_A5CC(self.classname);
    thread _id_12FB(self.model, var_8, var_10);

    if(self.code_classname == "script_vehicle")
      thread _id_A5EE(self.classname);

    if(isDefined(self.delete_on_death)) {
      wait 0.05;

      if(!isDefined(self._id_5958) && !self _meth_83E2())
        self disconnectPaths();

      _freezelookcontrols();
      wait 0.05;
      _id_131D7(self.model);
      self delete();
      continue;
    }

    if(isDefined(self._id_736A)) {
      self notify("newpath");

      if(!isDefined(self._id_5958))
        self disconnectPaths();

      _id_131FB();
      _freezelookcontrols();
      return;
    }

    _id_131CE(self.model, var_1, var_2, var_8);

    if(!isDefined(self)) {
      return;
    }
    if(!var_8)
      var_9 = self.origin;

    if(isDefined(level.vehicle._id_116CE._id_4E02[self.classname]))
      earthquake(level.vehicle._id_116CE._id_4E02[self.classname]._id_EB9C, level.vehicle._id_116CE._id_4E02[self.classname]._id_5F36, var_9, level.vehicle._id_116CE._id_4E02[self.classname].radius);

    wait 0.5;

    if(_id_9BA8()) {
      continue;
    }
    if(isDefined(self)) {
      while(isDefined(self._id_5960) && isDefined(self))
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
        self disconnectPaths();
        self notify("kill_badplace_forever");
        self _meth_81D0();
        self notify("newpath");
        self _meth_83E8();
        return;
      } else
        _freezelookcontrols();

      if(self._id_B91F)
        self hide();
    }

    if(_id_143E()) {
      self delete();
      continue;
    }
  }
}

_freezelookcontrols() {
  self _meth_80F8();
  scripts\engine\utility::delaythread(0.05, ::_id_6A4A);
}

_id_6A4A() {
  self notify("newpath");
  self.accuracy = undefined;
  self._id_247C = undefined;
  self._id_24D2 = undefined;
  self._id_275B = undefined;
  self._id_275C = undefined;
  self._id_4BF0 = undefined;
  self._id_4BF7 = undefined;
  self._id_4CF5 = undefined;
  self._id_5107 = undefined;
  self._id_6B9D = undefined;
  self._id_7F1A = undefined;
  self._id_8C2D = undefined;
  self._id_8CB6 = undefined;
  self._id_C36E = undefined;
  self._id_C36F = undefined;
  self._id_E7BE = undefined;
  self._id_E7C0 = undefined;
  self._id_E7C6 = undefined;
  self._id_ED10 = undefined;
  self._id_ED22 = undefined;
  self.script_disconnectpaths = undefined;
  self.script_linkname = undefined;
  self._id_EE50 = undefined;
  self.script_team = undefined;
  self._id_EEF2 = undefined;
  self._id_EEF8 = undefined;
  self._id_10707 = undefined;
  self._id_10708 = undefined;
  self._id_114CB = undefined;
  self.target = undefined;
  self._id_1152D = undefined;
  self._id_127FF = undefined;
  self._id_12800 = undefined;
  self._id_129DB = undefined;
  self._id_129DC = undefined;
  self._id_129DE = undefined;
  self._id_2756 = undefined;
  self._id_247E = undefined;
  self._id_2756 = undefined;
  self._id_E7CA = undefined;
  self._id_E7CB = undefined;
  self._id_E7D0 = undefined;
  self._id_E7D2 = undefined;
  self._id_E880 = undefined;
  self._id_EE5E = undefined;
  self._id_EEC8 = undefined;
  self._id_11659 = undefined;
  self._id_129DE = undefined;
  self._id_12A51 = undefined;
  self._id_12A52 = undefined;
  self._id_12A65 = undefined;
  self._id_12A7C = undefined;
  self._id_12A7D = undefined;
  self.unique_id = undefined;
  self._id_12BBC = undefined;
  self._id_12BD0 = undefined;
  self._id_1307E = undefined;
  self._id_1323C = undefined;
  self._id_136FC = undefined;
  self._id_13BB6 = undefined;
  self._id_C373 = undefined;
  self._id_ECE5 = undefined;
  self._id_13D02 = undefined;
  self._id_5971 = undefined;
  self._id_5958 = undefined;
  self._id_EDD1 = undefined;
  self._id_65DB = undefined;
  self._id_6A0B = undefined;
  self._id_843F = undefined;
  self.vehicletype = undefined;
  self._id_13244 = undefined;
  self._id_6231 = undefined;
  self._id_ED12 = undefined;
}

_id_143E() {
  return isDefined(self._id_4828) && self._id_4828 == 1;
}

_id_131D7(var_0) {
  if(isDefined(self._id_5946) && self._id_5946) {
    return;
  }
  self notify("death_finished");

  if(!isDefined(self)) {
    return;
  }
  self _meth_83D0(#animtree);

  if(isDefined(level.vehicle._id_116CE._id_5BC3[var_0]))
    self clearanim(level.vehicle._id_116CE._id_5BC3[var_0], 0);

  if(isDefined(level.vehicle._id_116CE._id_5BC6[var_0]))
    self clearanim(level.vehicle._id_116CE._id_5BC6[var_0], 0);
}

_id_13233(var_0, var_1, var_2) {
  if(!isDefined(self._id_1D63) || self._id_1D63 == 0) {
    if(isDefined(self._id_627C) && self._id_627C == 0)
      return 0;

    if(!isDefined(var_2))
      return 0;

    if(!(var_2 == "MOD_PROJECTILE" || var_2 == "MOD_PROJECTILE_SPLASH"))
      return 0;
  }

  if(isDefined(self._id_9B65) && self._id_9B65)
    return 1;

  return _id_131ED(var_0);
}

_id_131ED(var_0) {
  return isDefined(level.vehicle._id_116CE._id_131BC["rocket_death" + self.classname]) && isDefined(self._id_627C) && self._id_627C == 1;
}

_id_131CE(var_0, var_1, var_2, var_3) {
  var_4 = "tank";

  if(self _meth_83E2())
    var_4 = "physics";
  else if(_id_12F8())
    var_4 = "helicopter";
  else if(isDefined(self._id_4BF7))
    var_4 = "none";

  switch (var_4) {
    case "helicopter":
      thread _id_8DA7(var_1, var_2, var_3);
      break;
    case "tank":
      if(!isDefined(self._id_E683))
        self vehicle_setspeed(0, 25);
      else {
        self vehicle_setspeed(8, 25);
        self waittill("deathrolloff");
        self vehicle_setspeed(0, 25);
      }

      self notify("deadstop");

      if(!isDefined(self._id_5958))
        self disconnectPaths();

      if(isDefined(self._id_114E0) && self._id_114E0 > 0)
        self waittill("animsdone");

      break;
    case "physics":
      self _meth_83EF();
      self notify("deadstop");

      if(!isDefined(self._id_5958))
        self disconnectPaths();

      if(isDefined(self._id_114E0) && self._id_114E0 > 0)
        self waittill("animsdone");

      break;
  }

  if(isDefined(level.vehicle._id_116CE._id_8B8F[var_0]) && level.vehicle._id_116CE._id_8B8F[var_0])
    self _meth_8080();

  if(_id_12F8()) {
    if(isDefined(self._id_4828) && self._id_4828 == 1)
      self waittill("crash_done");
  } else {
    while(!_id_9BA8() && isDefined(self) && self vehicle_getspeed() > 0)
      wait 0.1;
  }

  self notify("stop_looping_death_fx");
  _id_131D7(var_0);
}

_id_9BA8() {
  var_0 = 0;

  if(isDefined(self) && self.classname == "script_vehicle_corpse")
    var_0 = 1;

  return var_0;
}

_id_F331(var_0, var_1) {
  if(isDefined(self._id_10268) && self._id_10268) {
    return;
  }
  if(isDefined(var_1) && var_1 > 0)
    wait(var_1);

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_412A))
    self clearanim(%root, 0);

  if(isDefined(self))
    self setModel(var_0);
}

_id_8DA7(var_0, var_1, var_2) {
  if(isDefined(var_0) && isPlayer(var_0))
    self._id_C720 = var_0;

  self._id_4828 = 1;

  if(!isDefined(self)) {
    return;
  }
  _id_5389();

  if(!var_2)
    thread _id_8DAB(var_0, var_1);
}

_id_A60E(var_0) {
  foreach(var_2 in var_0) {
    if(!isalive(var_2)) {
      continue;
    }
    if(!isDefined(var_2._id_E500) && !isDefined(var_2._id_5BD6)) {
      continue;
    }
    if(isDefined(var_2._id_B14F))
      var_2 scripts\sp\utility::_id_1101B();

    var_2 _meth_81D0();
  }
}

_id_13225(var_0, var_1) {
  if(isDefined(self._id_1321D) && self._id_1321D != 0) {
    return;
  }
  self.health = 1;
  var_0 endon("death");
  self._id_2894 = 0.15;
  self waittill("death");
  var_0 notify("driver_died");
  _id_A60E(var_1);
}

vehicle_caps() {
  self endon("death");
  self endon("enable_spline_path");
  waittillframeend;
  self._id_E4FB = scripts\sp\utility::_id_DFEB(self._id_E4FB);

  if(self._id_E4FB.size) {
    scripts\engine\utility::array_thread(self._id_E4FB, ::_id_13225, self, self._id_E4FB);
    scripts\engine\utility::waittill_either("veh_collision", "driver_died");
    _id_A60E(self._id_E4FB);
    wait 0.25;
  }

  self notify("script_crash_vehicle");
  self _meth_83EF();
}

_id_143F(var_0, var_1) {
  self endon("death");
  self notify("newpath");

  if(!isDefined(var_0))
    var_0 = 2;

  self setneargoalnotifydist(var_0);
  self sethoverparams(0, 0, 0);
  self cleargoalyaw();
  self settargetyaw(scripts\engine\utility::flat_angle(self.angles)[1]);

  if(isDefined(self._id_12BC2))
    _setvehgoalpos_wrap(scripts\sp\utility::_id_864C(self.origin) + (0, 0, self._id_12BC2), 1);
  else
    _setvehgoalpos_wrap(scripts\sp\utility::_id_864C(self.origin), 1);

  self waittill("goal");
}

_id_13200(var_0, var_1) {
  self endon("death");

  if(!isDefined(level.vehicle._id_116CE._id_A7C5[self.classname])) {
    return;
  }
  var_2 = level.vehicle._id_116CE._id_A7C5[self.classname];

  foreach(var_4 in var_2)
  self _meth_82A2(var_4.land, 1, 0.2, 1);

  if(!var_1) {
    return;
  }
  if(isDefined(var_0))
    self waittill("unloaded");
  else
    self waittill("continuepath");

  foreach(var_4 in var_2) {
    self clearanim(var_4.land, 0);
    self _meth_82A2(var_4._id_11472, 1, 0.2, 1);
  }
}

_id_13201(var_0, var_1) {
  return _id_143F(var_0, var_1);
}

_id_10809(var_0) {
  if(level._id_650D.size >= 8) {
    return;
  }
  var_1 = scripts\sp\utility::_id_10808();

  if(isDefined(var_0))
    var_1 _meth_83F4(var_0);

  var_1 thread vehicle_caps();
  var_1 endon("death");
  var_1._id_5971 = 1;
  var_1 scripts\sp\vehicle_paths::_id_845A(var_1);
  var_1 _id_AB23();
}

_id_AB23() {
  self endon("script_crash_vehicle");
  scripts\engine\utility::waittill_either("enable_spline_path", "reached_end_node");
  var_0 = _id_7B03(self.origin);

  if(isDefined(level._id_5BC2))
    var_0 thread[[level._id_5BC2]](self);
}

_id_7B03(var_0) {
  var_0 = (var_0[0], var_0[1], 0);
  var_1 = scripts\engine\utility::get_array_of_closest(var_0, level._id_103D0);
  var_2 = [];

  for(var_3 = 0; var_3 < 3; var_3++)
    var_2[var_3] = var_1[var_3];

  foreach(var_5 in level._id_103D0) {
    foreach(var_7 in var_2) {
      if(var_7 == var_5)
        return var_7;
    }
  }
}

_id_13804(var_0) {
  var_1 = 12;
  var_2 = 400;
  var_3 = gettime() + var_2;

  while(isDefined(self)) {
    if(abs(self.angles[0]) > var_1 || abs(self.angles[2]) > var_1)
      var_3 = gettime() + var_2;

    if(gettime() > var_3) {
      break;
    }

    wait 0.05;
  }
}

_id_143C() {
  if(!isDefined(self._id_ED12)) {
    return;
  }
  createnavrepulsor(self.unique_id + "vehicle_badplace", -1, self, "allies", "axis");
}

_id_1446(var_0) {
  self notify("unloading");
  var_1 = [];

  if(scripts\sp\utility::_id_65DF("no_riders_until_unload")) {
    scripts\sp\utility::_id_65E1("no_riders_until_unload");
    var_1 = _id_10805(var_0);

    foreach(var_3 in var_1)
    scripts\sp\utility::_id_106ED(var_3);

    waittillframeend;
  }

  if(isDefined(var_0))
    self._id_12BBC = var_0;

  foreach(var_6 in self._id_E4FB) {
    if(isalive(var_6))
      var_6 notify("unload");
  }

  var_1 = scripts\sp\vehicle_aianim::_id_1F74("unload");
  var_8 = level.vehicle._id_116CE._id_12BCF[self.classname];

  if(isDefined(var_8)) {
    var_1 = [];
    var_9 = scripts\sp\vehicle_aianim::_id_7D2F();

    foreach(var_12, var_11 in self._id_E4FB) {
      if(isDefined(var_9[var_11._id_1321D]))
        var_1[var_1.size] = var_11;
    }
  }

  return var_1;
}

_setvehgoalpos_wrap(var_0, var_1) {
  if(self.health <= 0) {
    return;
  }
  if(isDefined(self._id_C737))
    var_0 = var_0 + (0, 0, self._id_C737);

  self setvehgoalpos(var_0, var_1);
}

_id_8DAB(var_0, var_1) {
  self endon("in_air_explosion");

  if(isDefined(self._id_CA16))
    var_2 = self._id_CA16;
  else {
    var_3 = _id_7D31();
    var_2 = scripts\engine\utility::getclosest(self.origin, var_3);
  }

  var_2.claimed = 1;
  self notify("newpath");
  self notify("deathspin");
  var_4 = 0;
  var_5 = 0;

  if(isDefined(var_2.script_parameters) && var_2.script_parameters == "direct")
    var_5 = 1;

  if(isDefined(self._id_8D3C)) {
    var_5 = 0;
    var_4 = self._id_8D3C;
  }

  if(var_5) {
    var_6 = 60;
    self vehicle_setspeed(var_6, 15, 10);
    self setneargoalnotifydist(var_2.radius);
    self setvehgoalpos(var_2.origin, 0);
    thread _id_8DA9(var_2.origin, var_6);
    scripts\engine\utility::waittill_any("goal", "near_goal");
    _id_8DAC(var_2);
  } else {
    var_7 = (var_2.origin[0], var_2.origin[1], self.origin[2] + var_4);

    if(isDefined(self._id_8D3D)) {
      var_7 = self.origin + self._id_8D3D * self vehicle_getvelocity();
      var_7 = (var_7[0], var_7[1], var_7[2] + var_4);
    }

    self vehicle_setspeed(40, 10, 10);
    self setneargoalnotifydist(300);
    self setvehgoalpos(var_7, 1);
    thread _id_8DA9(var_7, 40);
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
    _id_8DAC(var_2);
  }

  var_2.claimed = undefined;
  self notify("stop_crash_loop_sound");
  self notify("crash_done");
}

_id_8DAC(var_0) {
  self endon("death");

  while(isDefined(var_0.target)) {
    var_0 = scripts\engine\utility::getStruct(var_0.target, "targetname");
    var_1 = 56;

    if(isDefined(var_0.radius))
      var_1 = var_0.radius;

    self setneargoalnotifydist(var_1);
    self setvehgoalpos(var_0.origin, 0);
    scripts\engine\utility::waittill_any("goal", "near_goal");
  }
}

_id_8DA9(var_0, var_1) {
  self endon("crash_done");
  self clearlookatent();
  var_2 = 0;

  if(isDefined(self._id_D831)) {
    var_2 = self._id_D831;

    if(self._id_D831 < 0) {
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
      thread _id_8DAE();
      break;
    case 2:
      thread _id_8DA8(var_0, var_1);
      break;
    case 3:
      thread _id_8DB0();
      break;
    case 0:
    default:
      thread _id_8DAD();
      break;
  }
}

_id_8DB0() {
  self notify("crash_done");
  self notify("in_air_explosion");
}

_id_8DA8(var_0, var_1) {
  self endon("crash_done");
  self clearlookatent();
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

_id_8DAE() {
  self endon("crash_done");
  self clearlookatent();
  self setyawspeed(400, 100, 100);
  var_0 = randomint(2);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    var_1 = randomintrange(20, 120);

    if(var_0)
      self settargetyaw(self.angles[1] + var_1);
    else
      self settargetyaw(self.angles[1] - var_1);

    var_0 = 1 - var_0;
    var_2 = randomfloatrange(0.5, 1.0);
    wait(var_2);
  }
}

_id_8DAD() {
  self endon("crash_done");
  self clearlookatent();
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

_id_7D31() {
  var_0 = [];
  level.vehicle._id_8DAA = scripts\engine\utility::array_removeundefined(level.vehicle._id_8DAA);

  foreach(var_2 in level.vehicle._id_8DAA) {
    if(isDefined(var_2.claimed)) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

_id_5389() {
  if(!isDefined(self._id_6B9D)) {
    return;
  }
  if(!self._id_6B9D.size) {
    return;
  }
  var_0 = getarraykeys(self._id_6B9D);

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    self._id_6B9D[var_0[var_1]] unlink();
}

_id_131FB() {
  self notify("kill_badplace_forever");
}

_id_A5EE(var_0) {
  if(isDefined(level.vehicle._id_116CE._id_4E12[var_0])) {
    self._id_5960 = 1;
    wait(level.vehicle._id_116CE._id_4E12[var_0].delay);
  }

  if(!isDefined(self)) {
    return;
  }
  self _meth_81CD(self.origin + (23, 33, 64), 3);
  wait 2;

  if(!isDefined(self)) {
    return;
  }
  self._id_5960 = undefined;
}

isdestroyed() {
  if(!isDefined(self))
    return 0;

  return isDefined(self._id_00ED);
}

_id_12FC(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = self getentityvelocity();
    var_2 = vectorNormalize(var_2);
    var_0 = vectorNormalize(var_0);
    var_3 = vectorlerp(var_2, var_0, var_1);
    return var_3;
  } else
    return undefined;
}

_id_12FB(var_0, var_1, var_2) {
  if(isdestroyed() || isDefined(self._id_9B65) && self._id_9B65) {
    return;
  }
  level notify("vehicle_explosion", self.origin);
  self notify("explode", self.origin);

  if(isDefined(self._id_9310) && self._id_9310) {
    return;
  }
  var_3 = self.vehicletype;
  var_4 = self.classname;

  if(var_1)
    var_4 = "rocket_death" + var_4;

  foreach(var_6 in level.vehicle._id_116CE._id_131BC[var_4])
  thread _id_A5E1(var_0, var_6, var_3, var_2);
}

_id_A5E1(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1._id_136A1)) {
    if(var_1._id_136A1 >= 0)
      wait(var_1._id_136A1);
    else
      self waittill("death_finished");
  }

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_1._id_C174))
    self notify(var_1._id_C174);

  if(isDefined(var_1._id_F1EA))
    scripts\engine\utility::delaycall(var_1._id_F1EA, ::delete);

  if(isDefined(var_1.effect)) {
    if(var_1._id_2A4E && !isDefined(self.delete_on_death)) {
      if(isDefined(var_1.tag)) {
        if(isDefined(var_1._id_10E6A) && var_1._id_10E6A == 1)
          thread _id_B03F(var_1.effect, var_1.delay, var_1.tag);
        else
          thread _id_D4C4(var_1.effect, var_1.delay, var_1.tag);
      } else {
        var_4 = self.origin + (0, 0, 100) - self.origin;
        playFX(var_1.effect, self.origin, var_4);
      }
    } else if(isDefined(var_1.tag)) {
      var_4 = _id_12FC(var_3, var_1._id_24DF);

      if(isDefined(var_4)) {
        var_5 = _id_4E49();
        playFX(var_1.effect, var_5 gettagorigin(var_1.tag), var_4);

        if(isDefined(var_1._id_DFEC))
          var_5 scripts\engine\utility::delaycall(var_1._id_DFEC, ::delete);
      } else {
        playFXOnTag(var_1.effect, _id_4E49(), var_1.tag);

        if(isDefined(var_1._id_DFEC))
          _id_4E49() scripts\engine\utility::delaycall(var_1._id_DFEC, ::delete);
      }
    } else {
      var_4 = _id_12FC(var_3, var_1._id_24DF);

      if(isDefined(var_4))
        playFX(var_1.effect, self.origin, var_4);
      else {
        var_4 = self.origin + (0, 0, 100) - self.origin;
        playFX(var_1.effect, self.origin, var_4);
      }
    }
  }

  if(isDefined(var_1.sound) && !isDefined(self.delete_on_death)) {
    if(var_1._id_312E)
      thread _id_4E05(var_1.sound);
    else
      scripts\engine\utility::play_sound_in_space(var_1.sound);
  }
}

_id_B03F(var_0, var_1, var_2) {
  self endon("stop_looping_death_fx");

  while(isDefined(self)) {
    playFXOnTag(var_0, _id_4E49(), var_2);
    wait(var_1);
  }
}

_id_4E05(var_0) {
  thread scripts\sp\utility::play_loop_sound_on_tag(var_0, undefined, 0, 1);
  scripts\engine\utility::waittill_any("fire_extinguish", "stop_crash_loop_sound");

  if(!isDefined(self)) {
    return;
  }
  self notify("stop sound" + var_0);
}

_id_4E49() {
  if(isDefined(self._id_4E0A) && self._id_4E0A)
    return self;

  if(!isDefined(self._id_4E49)) {
    var_0 = spawn("script_model", (0, 0, 0));
    var_0 setModel(self.model);
    var_0.origin = self.origin;
    var_0.angles = self.angles;
    var_0 notsolid();
    var_0 hide();
    var_0 linkTo(self);
    self._id_4E49 = var_0;
  } else
    self._id_4E49 setModel(self.model);

  return self._id_4E49;
}

_id_D4C4(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", self.origin);
  self endon("fire_extinguish");
  thread _id_D4C5(var_2, var_3);

  for(;;) {
    playFX(var_0, var_3.origin, var_3._id_12F93);
    wait(var_1);
  }
}

_id_D4C5(var_0, var_1) {
  var_1.angles = self gettagangles(var_0);
  var_1.origin = self gettagorigin(var_0);
  var_1._id_7337 = anglesToForward(var_1.angles);
  var_1._id_12F93 = anglestoup(var_1.angles);

  while(isDefined(self) && self.code_classname == "script_vehicle" && self vehicle_getspeed() > 0) {
    var_1.angles = self gettagangles(var_0);
    var_1.origin = self gettagorigin(var_0);
    var_1._id_7337 = anglesToForward(var_1.angles);
    var_1._id_12F93 = anglestoup(var_1.angles);
    wait 0.05;
  }
}

_id_A5BF(var_0) {
  if(!isDefined(level.vehicle._id_116CE._id_4DFC[var_0])) {
    return;
  }
  var_1 = level.vehicle._id_116CE._id_4DFC[var_0];

  if(isDefined(var_1.delay))
    wait(var_1.delay);

  if(!isDefined(self)) {
    return;
  }
  badplace_cylinder("vehicle_kill_badplace", var_1._id_5F36, self.origin, var_1.radius, var_1.height, var_1._id_115A4, var_1._id_115A5);
}

_id_129E4(var_0) {
  if(isDefined(self)) {
    if(isDefined(var_0._id_51AD))
      wait(var_0._id_51AD);
  }

  if(isDefined(var_0))
    var_0 delete();
}

_id_12B8(var_0, var_1) {
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
    if(isspawner(var_6))
      var_2[var_2.size] = var_6;
  }

  return var_2;
}

_id_1322D(var_0) {
  foreach(var_2 in self._id_E4FB) {
    if(isai(var_2)) {
      var_2 scripts\sp\utility::_id_F3B5(var_0);
      continue;
    }

    if(isDefined(var_2.spawner)) {
      var_2.spawner._id_EDAD = var_0;
      continue;
    }
  }
}

_id_12E33(var_0) {
  if(var_0._id_12E3C == gettime())
    return var_0._id_10F82;

  var_0._id_12E3C = gettime();

  if(var_0._id_10F83) {
    var_1 = clamp(0 - var_0.angles[2], 0 - var_0._id_10F85, var_0._id_10F85) / var_0._id_10F85;

    if(isDefined(var_0._id_AAF3) && var_0._id_AAF3) {
      var_2 = var_0 _meth_83DE();
      var_2 = var_2 * -1.0;
      var_1 = var_1 + var_2;

      if(var_1 != 0) {
        var_3 = 1.0 / abs(var_1);

        if(var_3 < 1)
          var_1 = var_1 * var_3;
      }
    }

    var_4 = var_1 - var_0._id_10F82;

    if(var_4 != 0) {
      var_5 = var_0._id_10F84 / abs(var_4);

      if(var_5 < 1)
        var_4 = var_4 * var_5;

      var_0._id_10F82 = var_0._id_10F82 + var_4;
    }
  } else
    var_0._id_10F82 = 0;

  return var_0._id_10F82;
}

_id_79D5(var_0) {
  return scripts\engine\utility::getStruct(var_0, "targetname");
}

_id_79D3(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(isDefined(var_1) && var_1.size > 0)
    return var_1[randomint(var_1.size)];

  return undefined;
}

_id_79D7(var_0) {
  return getvehiclenode(var_0, "targetname");
}

_id_F471(var_0) {
  var_1 = getEnt(var_0.script_linkto, "script_linkname");

  if(!isDefined(var_1)) {
    return;
  }
  self setlookatent(var_1);
  self._id_F472 = 1;
}

_id_4CFC() {
  level._id_2184 = 0;
  self._id_56DE = 0;
  thread _id_4CFE();

  while(isDefined(self)) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(isDefined(self._id_8BA9)) {
      continue;
    }
    var_4 = tolower(var_4);

    switch (var_4) {
      case "bullet":
      case "mod_rifle_bullet":
      case "mod_pistol_bullet":
        if(!level._id_2184) {
          if(isDefined(level._id_11829) && level._id_11829 > 0) {
            break;
          }

          level._id_2184 = 1;
          self._id_56DE = 1;
          var_1 scripts\sp\utility::_id_56BA("invulerable_bullets");
          wait 4;
          level._id_2184 = 0;

          if(isDefined(self))
            self._id_56DE = 0;

          break;
        }
    }
  }
}

_id_4CFD() {
  level._id_2184 = 0;
  self._id_56DE = 0;
  thread _id_4CFE();

  while(isDefined(self)) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(isDefined(self._id_8BA9)) {
      continue;
    }
    var_4 = tolower(var_4);

    switch (var_4) {
      case "mod_grenade_splash":
      case "mod_grenade":
      case "bullet":
      case "mod_rifle_bullet":
      case "mod_pistol_bullet":
        if(!level._id_2184) {
          if(isDefined(level._id_11829) && level._id_11829 > 0) {
            break;
          }

          level._id_2184 = 1;
          self._id_56DE = 1;

          if(var_4 == "mod_grenade" || var_4 == "mod_grenade_splash")
            var_1 scripts\sp\utility::_id_56BA("invulerable_frags");
          else
            var_1 scripts\sp\utility::_id_56BA("invulerable_bullets");

          wait 4;
          level._id_2184 = 0;

          if(isDefined(self))
            self._id_56DE = 0;

          break;
        }
    }
  }
}

_id_4CFE() {
  self waittill("death");

  if(self._id_56DE)
    level._id_2184 = 0;
}

_id_1A93(var_0) {
  self endon("death");
  self endon("death_finished");
  self notify("stop_kicking_up_dust");
  self endon("stop_kicking_up_dust");
  var_1 = 2000;

  if(isDefined(level._id_126F3))
    var_1 = level._id_126F3;

  var_2 = 80 / var_1;
  var_3 = 0.5;

  if(_id_12F6())
    var_3 = 0.15;

  var_4 = self;

  if(isDefined(var_0))
    var_4 = var_0;

  var_5 = 3;

  for(;;) {
    wait(var_3);

    if(1) {
      if(isDefined(self._id_55A4) && self._id_55A4) {
        continue;
      }
      if(isDefined(self._id_126F3))
        var_1 = self._id_126F3;

      var_6 = anglestoup(var_4.angles) * -1;
      var_7 = undefined;
      var_5++;

      if(var_5 > 3) {
        var_5 = 3;
        var_7 = scripts\common\trace::ray_trace(var_4.origin, var_4.origin + var_6 * var_1, var_4, undefined, 1);
      }

      if(var_7["fraction"] == 1 || var_7["fraction"] < var_2) {
        continue;
      }
      var_8 = distance(var_4.origin, var_7["position"]);
      var_9 = _id_7D53(self, var_7, var_6, var_8);

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

      if(isDefined(self._id_126F4))
        var_13 = var_10 - level.player.origin;

      if(vectordot(var_7["normal"], (0, 0, 1)) == -1) {
        continue;
      }
      if(length(var_13) < 1)
        var_13 = var_4.angles + (0, 180, 0);

      playFX(var_9, var_10, var_11, var_13);
    }
  }
}

_id_7D53(var_0, var_1, var_2, var_3) {
  var_4 = var_1["surfacetype"];
  var_5 = undefined;
  var_6 = vectordot((0, 0, -1), var_2);

  if(var_6 >= 0.97)
    var_5 = undefined;
  else if(var_6 >= 0.92)
    var_5 = "_bank";
  else
    var_5 = "_bank_lg";

  return _id_7D52(var_0.classname, var_4, var_5);
}

_id_7D52(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = var_1 + var_2;

    if(!isDefined(level.vehicle._id_116CE._id_112D9[var_0][var_3]) && var_1 != "default")
      return _id_7D52(var_0, "default", var_2);
    else
      return level.vehicle._id_116CE._id_112D9[var_0][var_3];
  }

  return _id_7D44(var_0, var_1);
}

_id_7D44(var_0, var_1) {
  if(!isDefined(level.vehicle._id_116CE._id_112D9[var_0][var_1]) && var_1 != "default")
    return _id_7D44(var_0, "default");
  else
    return level.vehicle._id_116CE._id_112D9[var_0][var_1];

  return undefined;
}

_id_C018() {
  return _id_12F8() || _id_12F6();
}

_id_12F8() {
  return isDefined(level.vehicle._id_116CE._id_8DB1[self.vehicletype]);
}

_id_12F6() {
  return isDefined(level.vehicle._id_116CE._id_1AE5[self.vehicletype]);
}

_id_8BFC() {
  if(!_id_12F8() && !_id_12F6())
    return 0;

  return 1;
}

_id_8BFD() {
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

_id_5636() {
  self endon("death");
  var_0 = 0;

  if(isDefined(self.script_disconnectpaths) && !self.script_disconnectpaths)
    var_0 = 1;

  if(var_0) {
    self._id_5958 = 1;
    return;
  }

  wait(randomfloat(1));

  while(isDefined(self)) {
    if(self vehicle_getspeed() < 1) {
      if(!isDefined(self._id_5958))
        self disconnectPaths();
      else {}

      self notify("speed_zero_path_disconnect");

      while(self vehicle_getspeed() < 1) {
        if(isDefined(self._id_5958) && self._id_5958) {
          break;
        }

        wait 0.05;
      }
    }

    self connectpaths();
    wait 1;
  }
}

_id_B6B7() {
  var_0 = self.classname;

  if(isDefined(self._id_EE5E) && self._id_EE5E > 0) {
    return;
  }
  if(!isDefined(level.vehicle._id_116CE.mgturret[var_0])) {
    return;
  }
  var_1 = 0;

  if(isDefined(self._id_EE14))
    var_1 = self._id_EE14;

  var_2 = level.vehicle._id_116CE.mgturret[var_0];

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = isDefined(self.script_noteworthy) && self.script_noteworthy == "onemg";
  var_4 = "";

  if(isDefined(self._id_EEF9))
    var_4 = self._id_EEF9;

  foreach(var_8, var_6 in var_2) {
    if(isDefined(var_6._id_DE46) && !issubstr(var_4, var_6._id_DE46)) {
      continue;
    }
    var_7 = spawnturret("misc_turret", (0, 0, 0), var_6.info);

    if(isDefined(var_6._id_C367))
      var_7 linkTo(self, var_6.tag, var_6._id_C367, (0, -1 * var_1, 0));
    else
      var_7 linkTo(self, var_6.tag, (0, 0, 0), (0, -1 * var_1, 0));

    var_7 setModel(var_6.model);
    var_7.angles = self.angles;
    var_7._id_9FF0 = 1;
    var_7._id_C841 = self;
    var_7.script_team = self.script_team;
    var_7 thread scripts\sp\mgturret::_id_32B7();
    var_7 makeunusable();
    _id_F5D8(var_7);
    level thread scripts\sp\mgturret::_id_B6A7(var_7, scripts\sp\utility::_id_7E72());

    if(isDefined(self._id_ED98))
      var_7._id_ED98 = self._id_ED98;

    if(isDefined(var_6._id_51AD))
      var_7._id_51AD = var_6._id_51AD;

    if(isDefined(var_6._id_01D2))
      var_7._id_01D2 = var_6._id_01D2;

    if(isDefined(var_6._id_5035))
      var_7 setdefaultdroppitch(var_6._id_5035);

    if(isDefined(var_6._id_DE46))
      var_7._id_DE46 = var_6._id_DE46;

    self.mgturret[var_8] = var_7;

    if(var_3) {
      break;
    }
  }

  foreach(var_11, var_7 in self.mgturret) {
    var_10 = level.vehicle._id_116CE.mgturret[var_0][var_11]._id_5041;

    if(isDefined(var_10))
      var_7 _id_12A29(var_10);
  }

  if(!isDefined(self._id_EEF8))
    self._id_EEF8 = 1;

  if(self._id_EEF8 == 0)
    thread _id_134C();
  else {
    self._id_EEF8 = 1;
    thread _id_134D();
  }
}

_id_12A29(var_0) {
  self._id_5041 = var_0;
}

_id_F5D8(var_0) {
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

_id_1F6E() {
  self endon("suspend_drive_anims");

  if(!isDefined(self._id_13D02))
    self._id_13D02 = 1;

  var_0 = self.model;
  var_1 = -1;
  var_2 = undefined;
  self _meth_83D0(#animtree);

  if(!isDefined(level.vehicle._id_116CE._id_5BC3[var_0])) {
    return;
  }
  if(!isDefined(level.vehicle._id_116CE._id_5BC6[var_0]))
    level.vehicle._id_116CE._id_5BC6[var_0] = level.vehicle._id_116CE._id_5BC3[var_0];

  self endon("death");
  var_3 = level.vehicle._id_116CE._id_5BC5[var_0];
  var_4 = 1.0;

  if(isDefined(level.vehicle._id_116CE._id_5BC4) && isDefined(level.vehicle._id_116CE._id_5BC4[var_0]))
    var_4 = level.vehicle._id_116CE._id_5BC4[var_0];

  var_5 = self._id_13D02;
  var_6 = level.vehicle._id_116CE._id_5BC3[var_0];

  for(;;) {
    if(!var_3) {
      if(isDefined(self._id_112FB)) {
        wait 0.05;
        continue;
      }

      self _meth_82A2(level.vehicle._id_116CE._id_5BC3[var_0], 1, 0.2, var_4);
      return;
    }

    var_7 = self vehicle_getspeed();

    if(var_5 != self._id_13D02) {
      var_8 = 0;

      if(self._id_13D02) {
        var_6 = level.vehicle._id_116CE._id_5BC3[var_0];
        var_8 = 1 - _id_7B21(level.vehicle._id_116CE._id_5BC6[var_0]);
        self clearanim(level.vehicle._id_116CE._id_5BC6[var_0], 0);
      } else {
        var_6 = level.vehicle._id_116CE._id_5BC6[var_0];
        var_8 = 1 - _id_7B21(level.vehicle._id_116CE._id_5BC3[var_0]);
        self clearanim(level.vehicle._id_116CE._id_5BC3[var_0], 0);
      }

      var_2 = 0.01;

      if(var_2 >= 1 || var_2 == 0)
        var_2 = 0.01;

      var_5 = self._id_13D02;
    }

    var_9 = var_7 / var_3;

    if(var_9 != var_1) {
      self _meth_82A2(var_6, 1, 0.05, var_9);
      var_1 = var_9;
    }

    if(isDefined(var_2)) {
      self _meth_82B0(var_6, var_2);
      var_2 = undefined;
    }

    wait 0.05;
  }
}

_id_FA7A(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isspawner(var_3))
      continue;
    else
      var_1[var_1.size] = var_3;
  }

  foreach(var_6 in var_1)
  thread _id_131F6(var_6);
}

_id_13203() {
  var_0 = self.classname;

  if(!isDefined(level.vehicle._id_116CE._id_AC4A) || !isDefined(level.vehicle._id_116CE._id_AC4A[var_0]))
    wait 2;

  if(isDefined(self._id_EEC8))
    self.health = self._id_EEC8;
  else if(level.vehicle._id_116CE._id_AC4A[var_0] == -1)
    return;
  else if(isDefined(level.vehicle._id_116CE._id_AC4D[var_0]) && isDefined(level.vehicle._id_116CE._id_AC4C[var_0]))
    self.health = randomint(level.vehicle._id_116CE._id_AC4C[var_0] - level.vehicle._id_116CE._id_AC4D[var_0]) + level.vehicle._id_116CE._id_AC4D[var_0];
  else
    self.health = level.vehicle._id_116CE._id_AC4A[var_0];
}

_id_7B21(var_0) {
  var_1 = self islegacyagent(var_0);
  var_2 = getanimlength(var_0);

  if(var_1 == 0)
    return 0;

  return self islegacyagent(var_0) / getanimlength(var_0);
}

_id_112FA() {
  self notify("suspend_drive_anims");
  var_0 = self.model;
  self clearanim(level.vehicle._id_116CE._id_5BC3[var_0], 0);
  self clearanim(level.vehicle._id_116CE._id_5BC6[var_0], 0);
}

_id_92D3() {
  self _meth_83D0(#animtree);

  if(!isDefined(level.vehicle._id_116CE._id_92D0[self.model])) {
    return;
  }
  foreach(var_1 in level.vehicle._id_116CE._id_92D0[self.model])
  self _meth_82A2(var_1);
}

_id_1322A() {
  self endon("kill_rumble_forever");
  var_0 = self.classname;
  var_1 = undefined;

  if(isDefined(self._id_1322C))
    var_1 = self._id_1322C;
  else if(isDefined(level.vehicle._id_116CE._id_E7BA[var_0]))
    var_1 = level.vehicle._id_116CE._id_E7BA[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_1.radius * 2;
  var_3 = -1 * var_1.radius;
  var_4 = spawn("trigger_radius", self.origin + (0, 0, var_3), 0, var_1.radius, var_2);
  var_4 enablelinkTo();
  var_4 linkTo(self);
  self._id_E7D2 = var_4;
  self endon("death");

  if(!isDefined(self._id_E7D0))
    self._id_E7D0 = 1;

  if(isDefined(var_1._id_EB9C))
    self._id_E7CB = var_1._id_EB9C;
  else
    self._id_E7CB = 0.15;

  if(isDefined(var_1._id_5F36))
    self._id_E7C0 = var_1._id_5F36;
  else
    self._id_E7C0 = 4.5;

  if(isDefined(var_1.radius))
    self._id_E7C6 = var_1.radius;
  else
    self._id_E7C6 = 600;

  if(isDefined(var_1._id_28AE))
    self._id_E7BE = var_1._id_28AE;
  else
    self._id_E7BE = 1;

  if(isDefined(var_1._id_DCA5))
    self._id_E7CA = var_1._id_DCA5;
  else
    self._id_E7CA = 1;

  var_4.radius = self._id_E7C6;

  for(;;) {
    var_4 waittill("trigger");

    if(self vehicle_getspeed() == 0 && !isDefined(self._id_72DB) || !self._id_E7D0) {
      wait 0.1;
      continue;
    }

    self _meth_8244(var_1._id_E7BA);

    if(isDefined(self.vehicletype)) {
      var_5 = self.vehicletype + "_rumble_sfx";

      if(soundexists(var_5))
        level.player playSound(var_5);
    }

    while(level.player istouching(var_4) && self._id_E7D0 && (self vehicle_getspeed() > 0 || isDefined(self._id_72DB))) {
      earthquake(self._id_E7CB, self._id_E7C0, self.origin, self._id_E7C6);
      wait(self._id_E7BE + randomfloat(self._id_E7CA));
    }

    self stoprumble(var_1._id_E7BA);
  }
}

_id_1322F() {
  var_0 = self.classname;

  if(!isDefined(self.script_team) && isDefined(level.vehicle._id_116CE.team[var_0]))
    self.script_team = level.vehicle._id_116CE.team[var_0];
}

_id_131EC() {
  self endon("death");
  var_0 = self.vehicletype;

  if(!scripts\sp\utility::_id_65DF("unloaded"))
    scripts\sp\utility::_id_65E0("unloaded");
}

_id_7D48(var_0) {
  var_1 = getvehiclenode(var_0, "targetname");

  if(!isDefined(var_1))
    var_1 = getEnt(var_0, "targetname");
  else if(_id_12F8()) {}

  if(!isDefined(var_1))
    var_1 = scripts\engine\utility::getStruct(var_0, "targetname");

  return var_1;
}

_id_8B7F() {
  return isDefined(level.vehicle._id_116CE._id_7448[self.vehicletype]);
}

_id_85DA(var_0) {
  if(!isDefined(self._id_EDD3))
    return 0;

  var_0 = tolower(var_0);

  if(!isDefined(var_0) || !issubstr(var_0, "grenade"))
    return 0;

  if(self._id_EDD3)
    return 1;
  else
    return 0;
}

_id_324F(var_0) {
  if(!isDefined(self._id_ED22))
    return 0;

  var_0 = tolower(var_0);

  if(!isDefined(var_0) || !issubstr(var_0, "bullet") || issubstr(var_0, "explosive"))
    return 0;

  if(self._id_ED22)
    return 1;
  else
    return 0;
}

_id_69F8(var_0) {
  if(!isDefined(self._id_ED87))
    return 0;

  var_0 = tolower(var_0);

  if(!isDefined(var_0) || !issubstr(var_0, "explosive"))
    return 0;

  if(self._id_ED87)
    return 1;
  else
    return 0;
}

_id_13234(var_0, var_1) {
  return !isDefined(var_0) && self.script_team != "neutral" || _id_24DC(var_0) || _id_24DE(var_0) || isdestroyed() || _id_9C29(var_0) || _id_324F(var_1) || _id_69F8(var_1) || _id_85DA(var_1) || var_1 == "MOD_MELEE";
}

_id_740E() {
  self endon("death");

  if(!isDefined(level._id_12D6B))
    self endon("stop_friendlyfire_shield");

  if(isDefined(level.vehicle._id_116CE._id_323D[self.classname]) && !isDefined(self._id_ED22))
    self._id_ED22 = level.vehicle._id_116CE._id_323D[self.classname];

  if(isDefined(level.vehicle._id_116CE._id_85A0[self.classname]) && !isDefined(self._id_EDD3))
    self._id_EDD3 = level.vehicle._id_116CE._id_323D[self.classname];

  if(isDefined(self._id_EE50)) {
    self._id_EE50 = 1;
    self._id_3233 = 5000;
    self.health = 350;
  } else
    self._id_EE50 = 0;

  self._id_8CB6 = 20000;
  self.health = self.health + self._id_8CB6;
  self._id_4BF0 = self.health;
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;

  while(self.health > 0) {
    self waittill("damage", var_3, var_0, var_4, var_5, var_1, var_6, var_7, var_8, var_9, var_2);

    foreach(var_11 in self._id_4CF5)
    thread[[var_11]](var_3, var_0, var_4, var_5, var_1, var_6, var_7);

    if(isDefined(var_0))
      var_0 scripts\sp\player_stats::_id_DED8();

    if(_id_13234(var_0, var_1) || _id_12F0())
      self.health = self._id_4BF0;
    else if(_id_8B7F()) {
      _id_DE7F(var_0, var_3);
      self._id_4BF0 = self.health;
    } else if(_id_9029(var_1)) {
      self.health = self._id_4BF0;
      self._id_3233 = self._id_3233 - var_3;
    } else
      self._id_4BF0 = self.health;

    if(self.health < self._id_8CB6 && !isDefined(self._id_13243)) {
      break;
    }
  }

  self notify("death", var_0, var_1, var_2);
}

_id_9029(var_0) {
  if(!self._id_EE50)
    return 0;

  if(self._id_3233 <= 0)
    return 0;

  if(!isDefined(var_0))
    return 0;

  if(!issubstr(var_0, "BULLET"))
    return 0;
  else
    return 1;
}

_id_DE7F(var_0, var_1) {
  var_2 = anglesToForward(self.angles);
  var_3 = vectorNormalize(var_0.origin - self.origin);

  if(vectordot(var_2, var_3) > 0.86)
    self.health = self.health + int(var_1 * level.vehicle._id_116CE._id_7448[self.vehicletype]);
}

_id_12F0() {
  if(isDefined(self._id_843F) && self._id_843F)
    return 1;
  else
    return 0;
}

_id_9C29(var_0) {
  if(!isDefined(self._id_ECE6))
    return 0;

  if(isDefined(var_0) && isai(var_0) && self._id_ECE6 == 1)
    return 1;
  else
    return 0;
}

_id_24DE(var_0) {
  if(isDefined(self.script_team) && self.script_team == "allies" && isDefined(var_0) && isPlayer(var_0))
    return 1;
  else if(isai(var_0) && var_0.team == self.script_team)
    return 1;
  else
    return 0;
}

_id_24DC(var_0) {
  if(isDefined(var_0) && isDefined(var_0.script_team) && isDefined(self.script_team) && var_0.script_team == self.script_team)
    return 1;

  return 0;
}

vehicle_builds() {
  return _id_143C();
}

_id_13D03(var_0) {
  self._id_13D02 = scripts\engine\utility::ter_op(var_0 <= 0, 0, 1);
}

_id_B248() {
  if(isDefined(level._id_B249)) {
    thread[[level._id_B249]]();
    return;
  }

  var_0 = self.model;

  if(!isDefined(level.vehicle._id_116CE._id_4F6B[var_0])) {
    return;
  }
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");
    playFXOnTag(level.vehicle._id_116CE._id_4F6B[var_0], self, "tag_engine_exhaust");
    var_1 = self gettagorigin("tag_flash");
    var_2 = physicstrace(var_1, var_1 + (0, 0, -128));
    physicsexplosionsphere(var_2, 192, 100, 1);
  }
}

_id_D546() {
  self endon("death");
  var_0 = self.model;

  if(!isDefined(level.vehicle._id_116CE._id_693A[var_0])) {
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
    playFXOnTag(level.vehicle._id_116CE._id_693A[var_0], self, "tag_engine_exhaust");
    wait(var_1);
  }
}

_id_13219() {
  self._id_247E = undefined;
  self notify("newpath");
  self setgoalyaw(scripts\engine\utility::flat_angle(self.angles)[1]);
  self setvehgoalpos(self.origin + (0, 0, 4), 1);
}

_id_4E5C() {
  if(self.health > 0)
    self._id_E683 = 1;
}

_id_4E5B() {
  self._id_E683 = undefined;
  self notify("deathrolloff");
}

_id_134C() {
  self._id_EEF8 = 0;

  if(_id_12F8() && _id_8BFD()) {
    if(isDefined(level._id_3F23)) {
      self thread[[level._id_3F24]]();
      return;
    }
  }

  if(!isDefined(self.mgturret)) {
    return;
  }
  foreach(var_2, var_1 in self.mgturret) {
    if(isDefined(var_1._id_ED98))
      var_1._id_ED98 = 0;

    var_1 setmode("manual");
  }
}

_id_134D() {
  self._id_EEF8 = 1;

  if(_id_12F8() && _id_8BFD()) {
    self thread[[level._id_3F25]]();
    return;
  }

  if(!isDefined(self.mgturret)) {
    return;
  }
  foreach(var_1 in self.mgturret) {
    var_1 show();

    if(isDefined(var_1._id_ED98))
      var_1._id_ED98 = 1;

    if(isDefined(var_1._id_5041)) {
      if(var_1._id_5041 != "sentry")
        var_1 setmode(var_1._id_5041);
    } else
      var_1 setmode("auto_nonai");

    _id_F5D8(var_1);
  }
}

_id_7D47() {
  var_0 = [];

  if(isDefined(self.target)) {
    var_1 = getspawnerarray(self.target);

    foreach(var_3 in var_1) {
      if(!issubstr(var_3.code_classname, "actor") && !issubstr(var_3.code_classname, "vehicle")) {
        continue;
      }
      if(issubstr(var_3.code_classname, "actor")) {
        if(!isspawner(var_3))
          continue;
        else if(issubstr(var_3.code_classname, "vehicle")) {
          if(!(var_3.spawnflags & 2))
            continue;
        }
      }

      if(isDefined(var_3._id_5941)) {
        continue;
      }
      var_0[var_0.size] = var_3;
    }

    if(isDefined(level._id_107A7)) {
      var_1 = scripts\engine\utility::getStructArray(self.target, "targetname");

      foreach(var_3 in var_1) {
        if(isDefined(var_3._id_EEB6))
          var_0[var_0.size] = var_3;
      }
    }
  }

  return var_0;
}

_id_1444(var_0) {
  if(isDefined(var_0._id_ED52)) {
    var_0 endon("death");
    wait(var_0._id_ED52);
  }

  var_1 = var_0 _meth_83DA();

  if(!isDefined(var_0._id_1084E))
    var_0._id_1084E = 0;

  var_0._id_1084E++;
  var_0._id_1323B = var_1;
  var_0._id_A90E = var_1;
  var_0 thread _id_E0A7();
  var_1._id_1323C = var_0;

  if(isDefined(var_0._id_12841))
    var_1._id_12841 = var_0._id_12841;

  thread _id_131F6(var_1);
  var_0 notify("spawned", var_1);
  return var_1;
}

_id_D808() {
  var_0 = [];
  var_1 = getEntArray("script_vehicle", "code_classname");
  level._id_BE91 = [];
  var_2 = [];
  var_0 = [];

  if(!isDefined(level._id_13261))
    level._id_13261 = [];

  foreach(var_4 in var_1) {
    var_4.vehicletype = tolower(var_4.vehicletype);

    if(var_4.vehicletype == "empty" || var_4.vehicletype == "empty_heli") {
      continue;
    }
    if(isDefined(var_4.spawnflags) && var_4.spawnflags & 1)
      var_2[var_2.size] = var_4;

    var_0[var_0.size] = var_4;

    if(!isDefined(level._id_13261[var_4.vehicletype]))
      level._id_13261[var_4.vehicletype] = [];

    var_5 = "classname: " + var_4.classname;
    _id_D812(var_5, var_4);
  }

  if(level._id_BE91.size > 0) {
    foreach(var_8 in level._id_BE91) {}

    level waittill("never");
  }

  return var_0;
}

_id_D812(var_0, var_1) {
  if(isDefined(level._id_13261[var_1.vehicletype][var_1.classname])) {
    return;
  }
  if(isDefined(level.vehicle._id_116CE._id_1325B) && isDefined(level.vehicle._id_116CE._id_1325B[var_1.classname])) {
    return;
  }
  if(var_1.classname == "script_vehicle") {
    return;
  }
  var_2 = 0;

  foreach(var_4 in level._id_BE91) {
    if(var_4 == var_0)
      var_2 = 1;
  }

  if(!var_2)
    level._id_BE91[level._id_BE91.size] = var_0;
}

_id_F9C7() {
  if(!scripts\engine\utility::add_init_script("vehicle_vars", ::_id_F9C7)) {
    return;
  }
  scripts\engine\utility::struct_class_init();
  level.vehicle = spawnStruct();
  level.vehicle._id_116CE = spawnStruct();
  level.vehicle._id_8DAA = getEntArray("helicopter_crash_location", "targetname");
  level.vehicle._id_8DAA = scripts\engine\utility::array_combine(level.vehicle._id_8DAA, scripts\sp\utility::_id_8181("helicopter_crash_location", "targetname"));
  level.vehicle._id_116CE.team = [];
  level.vehicle._id_116CE._id_4E4E = [];
  level.vehicle._id_116CE._id_4E23 = [];
  level.vehicle._id_116CE._id_5BC3 = [];
  level.vehicle._id_116CE._id_5BC6 = [];
  level.vehicle._id_116CE._id_E7BA = [];
  level.vehicle._id_116CE.mgturret = [];
  level.vehicle._id_116CE._id_4E02 = [];
  level.vehicle._id_116CE._id_112D9 = [];
  level.vehicle._id_116CE._id_12BCF = [];
  level.vehicle._id_116CE._id_1A03 = [];
  level.vehicle._id_116CE._id_A7C5 = [];
  level.vehicle._id_116CE._id_693A = [];
  level.vehicle._id_116CE._id_4F6B = [];
  level.vehicle._id_116CE._id_FE7C = [];
  level.vehicle._id_116CE._id_8E9D = [];
  level.vehicle._id_116CE._id_7448 = [];
  level.vehicle._id_116CE._id_535B = [];
  level.vehicle._id_116CE._id_85A0 = [];
  level.vehicle._id_116CE._id_323D = [];
  level.vehicle._id_116CE._id_4E12 = [];
  level.vehicle._id_116CE._id_4DFC = [];
  level.vehicle._id_116CE._id_92D0 = [];
  level.vehicle._id_116CE._id_8DB1 = [];
  level.vehicle._id_116CE._id_1AE5 = [];
  level.vehicle._id_116CE._id_1020A = [];
  level.vehicle._id_116CE._id_4DF9 = [];
  level.vehicle._id_116CE._id_131BC = [];

  if(!isDefined(level.vehicle._id_116CE._id_4E1C))
    level.vehicle._id_116CE._id_4E1C = [];

  scripts\sp\vehicle_aianim::_id_F8AE();
}

_id_FB0A(var_0, var_1) {
  return _setvehgoalpos_wrap(var_0, var_1);
}

_id_13207(var_0) {
  if(!isDefined(var_0))
    var_0 = 512;

  var_1 = self.origin + (0, 0, var_0);
  self setneargoalnotifydist(10);
  _id_FB0A(var_1, 1);
  self waittill("goal");
}

_id_10810(var_0) {
  var_1 = [];
  var_2 = getEntArray(var_0, "targetname");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(!isDefined(var_5.code_classname) || var_5.code_classname != "script_vehicle") {
      continue;
    }
    if(isspawner(var_5))
      var_1[var_1.size] = _id_1444(var_5);
  }

  return var_1;
}

_id_A5CC(var_0) {
  if(!isDefined(level.vehicle._id_116CE._id_4DF9[var_0])) {
    return;
  }
  if(isDefined(self._id_10263) && self._id_10263) {
    return;
  }
  if(isarray(level.vehicle._id_116CE._id_4DF9[var_0])) {
    if(isDefined(self._id_D832))
      var_1 = self._id_D832;
    else
      var_1 = scripts\engine\utility::random(level.vehicle._id_116CE._id_4DF9[var_0]);

    return _id_A5CD(var_1);
  }

  return _id_A5CD(level.vehicle._id_116CE._id_4DF9[var_0]);
}

_id_A5CD(var_0) {
  self._id_A648 = 1;
  var_1 = scripts\engine\utility::spawn_tag_origin();
  self _meth_83E3(var_1.origin, var_1.angles, 0, 0);
  self _meth_83E8();
  self notify("kill_death_anim", var_0);

  if(isstring(var_0)) {
    self setCanDamage(0);
    var_1 scripts\sp\anim::_id_1F35(self, var_0);
  } else {
    self _meth_83D0(#animtree);
    self animScripted("vehicle_death_anim", var_1.origin, var_1.angles, var_0);
    self setneargoalnotifydist(30);
    self setvehgoalpos(var_1.origin, 1);
    self setgoalyaw(var_1.angles[1]);
    self waittillmatch("vehicle_death_anim", "end");
  }

  var_1 delete();
  thread _id_50EA(7);
}

_id_50EA(var_0) {
  wait 7;

  if(isDefined(self))
    self delete();
}

_id_5144() {
  var_0 = self _meth_810C();
  var_1 = self getpointinbounds(1, 0, 0);
  var_2 = distance(var_1, var_0);
  var_3 = getcorpsearray();

  foreach(var_5 in var_3) {
    if(distance(var_5.origin, var_0) < var_2)
      var_5 delete();
  }
}