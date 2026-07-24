/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2968.gsc
**************************************/

_id_845A(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  var_0 endon("death");

  if(isDefined(var_0._id_8C2D)) {
    return;
  } else {
    var_0._id_8C2D = 1;
  }

  var_0 scripts\sp\utility::script_delay();
  var_0 notify("start_vehiclepath");

  if(isaircraft(var_0)) {
    if(isDefined(var_0._id_10A47)) {
      var_0[[var_0._id_10A47]](scripts\sp\utility::_id_7C9A(var_0.target));
    }
  } else if(var_0 scripts\sp\vehicle_code::_id_12F8())
    var_0 notify("start_dynamicpath");
  else {
    var_0 startpath();
  }
}

_id_1442(var_0, var_1, var_2) {
  if(scripts\sp\vehicle_code::_id_12F8()) {
    _id_1321B(var_0, var_1, var_2);
  } else {
    _id_1321C(var_0);
  }
}

_id_12783(var_0) {
  if(isDefined(var_0._id_ED9E)) {
    scripts\engine\utility::flag_set(var_0._id_ED9E);
  }

  if(isDefined(var_0._id_ED9B)) {
    scripts\engine\utility::flag_clear(var_0._id_ED9B);
  }

  if(isDefined(var_0.script_prefab_exploder)) {
    var_0.script_exploder = var_0.script_prefab_exploder;
    var_0.script_prefab_exploder = undefined;
  }

  if(isDefined(var_0.script_exploder)) {
    var_1 = var_0._id_ED85;

    if(isDefined(var_1)) {
      level scripts\engine\utility::delaythread(var_1, scripts\engine\utility::exploder, var_0.script_exploder);
    } else {
      level scripts\engine\utility::exploder(var_0.script_exploder);
    }
  }

  if(isDefined(var_0._id_ED9E)) {
    scripts\engine\utility::flag_set(var_0._id_ED9E);
  }

  if(isDefined(var_0._id_ED80)) {
    scripts\sp\utility::_id_65E1(var_0._id_ED80);
  }

  if(isDefined(var_0._id_ED7F)) {
    scripts\sp\utility::_id_65DD(var_0._id_ED7F);
  }

  if(isDefined(var_0._id_ED9B)) {
    scripts\engine\utility::flag_clear(var_0._id_ED9B);
  }

  if(isDefined(var_0.script_noteworthy)) {
    if(var_0.script_noteworthy == "deleteme") {
      self delete();
      return;
    } else if(var_0.script_noteworthy == "engineoff")
      self _meth_83E8();
    else {
      self notify(var_0.script_noteworthy);
      self notify("noteworthy", var_0.script_noteworthy);
    }
  }

  if(isDefined(var_0._id_ED12)) {
    self._id_ED12 = var_0._id_ED12;
  }

  if(isDefined(var_0._id_EEF8)) {
    if(var_0._id_EEF8) {
      scripts\sp\vehicle_code::_id_134D();
    } else {
      scripts\sp\vehicle_code::_id_134C();
    }
  }
}

_id_9E71(var_0) {
  if(!isDefined(var_0.target)) {
    return 1;
  }

  if(!isDefined(getvehiclenode(var_0.target, "targetname")) && !isDefined(scripts\sp\vehicle_code::_id_7D48(var_0.target))) {
    return 1;
  }

  return 0;
}

_id_13235(var_0, var_1) {
  if(isDefined(var_1._id_EEFB)) {
    return 1;
  }

  if(var_0 != ::_id_C041) {
    return 0;
  }

  if(!_id_9E71(var_1)) {
    return 0;
  }

  if(isDefined(self._id_5971)) {
    return 0;
  }

  if(self.vehicletype == "empty" || self.vehicletype == "empty_heli") {
    return 0;
  }

  return !(isDefined(self._id_EF05) && self._id_EF05);
}

_id_C82A(var_0) {}

_id_13222() {
  if(!scripts\sp\vehicle_code::_id_12F8()) {
    self resumespeed(35);
    return;
  }

  var_0 = undefined;

  if(isDefined(self._id_4BF7.target)) {
    var_0 = scripts\sp\vehicle_code::_id_7D48(self._id_4BF7.target);
  }

  if(!isDefined(var_0)) {
    return;
  }
  _id_1442(var_0);
}

_id_7B6F(var_0) {
  var_1 = scripts\sp\vehicle_code::_id_79D7;

  if(scripts\sp\vehicle_code::_id_12F8() && isDefined(var_0.target)) {
    if(isDefined(scripts\sp\vehicle_code::_id_79D3(var_0.target))) {
      var_1 = scripts\sp\vehicle_code::_id_79D3;
    }

    if(isDefined(scripts\sp\vehicle_code::_id_79D5(var_0.target))) {
      var_1 = scripts\sp\vehicle_code::_id_79D5;
    }
  }

  return var_1;
}

_id_C041(var_0, var_1, var_2) {
  if(isDefined(self.unique_id)) {
    var_3 = "node_flag_triggered" + self.unique_id;
  } else {
    var_3 = "node_flag_triggered";
  }

  _id_C055(var_3, var_0, var_2);

  if(self._id_247E == var_0) {
    self notify("node_wait_terminated");
    waittillframeend;
    return;
  }

  var_0 scripts\sp\utility::_id_65E7(var_3);
  var_0 scripts\sp\utility::_id_65DD(var_3, 1);
  var_0 notify("processed_node" + var_3);
}

_id_C055(var_0, var_1, var_2) {
  for(var_3 = 0; isDefined(var_1) && var_3 < 3; var_1 = [[var_2]](var_1.target)) {
    var_3++;
    thread _id_C032(var_0, var_1);

    if(!isDefined(var_1.target)) {
      return;
    }
  }
}

_id_C032(var_0, var_1) {
  if(var_1 scripts\sp\utility::_id_65DF(var_0)) {
    return;
  }
  var_1 scripts\sp\utility::_id_65E0(var_0);
  thread _id_C033(var_1, var_0);
  var_1 endon("processed_node" + var_0);
  self endon("death");
  self endon("newpath");
  self endon("node_wait_terminated");
  var_1 waittill("trigger");
  var_1 scripts\sp\utility::_id_65E1(var_0);
}

_id_C033(var_0, var_1) {
  var_0 endon("processed_node" + var_1);
  scripts\engine\utility::waittill_any("death", "newpath", "node_wait_terminated");
  var_0 scripts\sp\utility::_id_65DD(var_1, 1);
}

_id_1321C(var_0) {
  self notify("newpath");

  if(isDefined(var_0)) {
    self._id_247E = var_0;
  }

  var_1 = self._id_247E;
  self._id_4BF7 = self._id_247E;

  if(!isDefined(var_1)) {
    return;
  }
  self endon("newpath");
  self endon("death");
  var_2 = var_1;
  var_3 = undefined;
  var_4 = var_1;
  var_5 = _id_7B6F(var_1);

  while(isDefined(var_4)) {
    _id_C041(var_4, var_3, var_5);

    if(!isDefined(self)) {
      return;
    }
    _id_12783(var_4);
    self._id_4BF7 = var_4;

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(var_4.script_team)) {
      self.script_team = var_4.script_team;
    }

    if(isDefined(var_4._id_EEF1)) {
      self notify("turning", var_4._id_EEF1);
    }

    if(isDefined(var_4._id_ED4A)) {
      if(var_4._id_ED4A == 0) {
        thread scripts\sp\vehicle_code::_id_4E5B();
      } else {
        thread scripts\sp\vehicle_code::_id_4E5C();
      }
    }

    if(isDefined(var_4._id_EF1E)) {
      scripts\sp\vehicle_code::_id_13D03(var_4._id_EF1E);
    }

    if(_id_13235(::_id_C041, var_4)) {
      thread _id_12BC7(var_4);
    }

    if(isDefined(var_4._id_EEED)) {
      self.veh_transmission = var_4._id_EEED;

      if(self.veh_transmission == "forward") {
        scripts\sp\vehicle_code::_id_13D03(1);
      } else {
        scripts\sp\vehicle_code::_id_13D03(0);
      }
    }

    if(isDefined(var_4._id_ED1F)) {
      self.veh_brake = var_4._id_ED1F;
    }

    if(isDefined(var_4._id_EE7C)) {
      self.veh_pathtype = var_4._id_EE7C;
    }

    if(isDefined(var_4._id_ED81)) {
      var_6 = 35;

      if(isDefined(var_4._id_ED4C)) {
        var_6 = var_4._id_ED4C;
      }

      self vehicle_setspeed(0, var_6);
      scripts\sp\utility::_id_65E3(var_4._id_ED81);

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

      if(isDefined(var_4._id_ED4C)) {
        var_6 = var_4._id_ED4C;
      }

      self vehicle_setspeed(0, var_6);

      if(isDefined(var_4.target)) {
        thread _id_C82A([[var_5]](var_4.target));
      }

      var_4 scripts\sp\utility::script_delay();
      self notify("delay_passed");
      var_7 = 60;

      if(isDefined(var_4.script_accel)) {
        var_7 = var_4.script_accel;
      }

      self resumespeed(var_7);
    }

    if(isDefined(var_4._id_EDA0)) {
      var_8 = 0;

      if(!scripts\engine\utility::flag(var_4._id_EDA0) || isDefined(var_4.script_delay_post)) {
        var_8 = 1;
        var_7 = 5;
        var_6 = 35;

        if(isDefined(var_4.script_accel)) {
          var_7 = var_4.script_accel;
        }

        if(isDefined(var_4._id_ED4C)) {
          var_6 = var_4._id_ED4C;
        }

        _id_1445("script_flag_wait_" + var_4._id_EDA0, var_7, var_6);
        thread _id_C82A([[var_5]](var_4.target));
      }

      scripts\engine\utility::flag_wait(var_4._id_EDA0);

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
        _id_1443("script_flag_wait_" + var_4._id_EDA0);
      }

      self notify("delay_passed");
    }

    if(isDefined(self._id_F472)) {
      self._id_F472 = undefined;
      self clearlookatent();
    }

    if(isDefined(var_4._id_EF03)) {
      thread scripts\sp\vehicle_lights::lights_off(var_4._id_EF03);
    }

    if(isDefined(var_4._id_EF04)) {
      thread scripts\sp\vehicle_lights::lights_on(var_4._id_EF04);
    }

    if(isDefined(var_4._id_EDAD)) {
      thread scripts\sp\vehicle_code::_id_1322D(var_4._id_EDAD);
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

  if(isDefined(self._id_EF05)) {
    self notify("delete");
    self delete();
  }
}

_id_1321B(var_0, var_1, var_2) {
  self notify("newpath");
  self endon("newpath");
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(isDefined(var_0)) {
    self._id_247E = var_0;
  }

  var_3 = self._id_247E;
  self._id_4BF7 = self._id_247E;

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = var_3;

  if(var_1) {
    self waittill("start_dynamicpath");
  }

  if(isDefined(var_2)) {
    var_5 = spawnStruct();
    var_5.origin = scripts\sp\utility::_id_1796(self.origin, var_2);
    _id_8DA3(var_5, undefined);
  }

  var_6 = undefined;
  var_7 = var_3;
  var_8 = _id_7B6F(var_3);

  while(isDefined(var_7)) {
    if(isDefined(var_7.script_linkto)) {
      scripts\sp\vehicle_code::_id_F471(var_7);
    }

    if(isDefined(var_7._id_EDFA)) {
      var_9 = 0;

      if(isDefined(var_7.target)) {
        var_9 = isDefined([[var_8]](var_7.target));
      }

      thread scripts\sp\vehicle_code::_id_13200(var_7._id_EEFB, var_9);
    }

    _id_8DA3(var_7, var_6, var_2);

    if(!isDefined(self)) {
      return;
    }
    self._id_4BF7 = var_7;
    var_7 notify("trigger", self);

    if(isDefined(var_7._id_EDD8)) {
      self setyawspeedbyname(var_7._id_EDD8);

      if(var_7._id_EDD8 == "faster") {
        self setmaxpitchroll(25, 50);
      }
    }

    _id_12783(var_7);

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(var_7.script_team)) {
      self.script_team = var_7.script_team;
    }

    if(_id_13235(::_id_8DA3, var_7)) {
      thread _id_12BC7(var_7);
    }

    if(self _meth_83E2()) {
      if(isDefined(var_7._id_EE7C)) {
        self.veh_pathtype = var_7._id_EE7C;
      }
    }

    if(isDefined(var_7._id_EDA0)) {
      scripts\engine\utility::flag_wait(var_7._id_EDA0);

      if(isDefined(var_7.script_delay_post)) {
        wait(var_7.script_delay_post);
      }

      self notify("delay_passed");
    }

    if(isDefined(self._id_F472)) {
      self._id_F472 = undefined;
      self clearlookatent();
    }

    if(isDefined(var_7._id_EF03)) {
      thread scripts\sp\vehicle_lights::lights_off(var_7._id_EF03);
    }

    if(isDefined(var_7._id_EF04)) {
      thread scripts\sp\vehicle_lights::lights_on(var_7._id_EF04);
    }

    if(isDefined(var_7._id_EDAD)) {
      thread scripts\sp\vehicle_code::_id_1322D(var_7._id_EDAD);
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

  if(isDefined(self._id_EF05)) {
    self delete();
  }
}

_id_8DA3(var_0, var_1, var_2) {
  self endon("newpath");

  if(isDefined(var_0._id_EEFB) || isDefined(var_0._id_EDFA)) {
    var_3 = 0;

    if(isDefined(var_0._id_EDFA)) {
      scripts\sp\utility::_id_65E1("landed");

      if(isDefined(self._id_12BC2)) {
        var_3 = self._id_12BC2;
      }
    } else if(isDefined(var_0._id_EEFB) && isDefined(self._id_12BC0))
      var_3 = self._id_12BC0;
    else if(isDefined(var_0._id_EEFB) && isDefined(self._id_12BC1)) {
      var_4 = scripts\sp\utility::_id_864C(var_0.origin);
      var_3 = var_0.origin[2] - var_4[2];

      if(var_3 >= self._id_12BC1) {
        var_3 = self._id_12BC1;
      } else if(isDefined(self._id_12BBF) && var_3 < self._id_12BBF) {
        var_3 = self._id_12BBF;
      }
    }

    var_0.radius = 2;

    if(isDefined(var_0._id_8630)) {
      var_0.origin = var_0._id_8630 + (0, 0, var_3);
    } else {
      var_5 = scripts\sp\utility::_id_864C(var_0.origin) + (0, 0, var_3);

      if(var_5[2] > var_0.origin[2] - 2000) {
        var_0.origin = scripts\sp\utility::_id_864C(var_0.origin) + (0, 0, var_3);
      }
    }

    self sethoverparams(0, 0, 0);
  }

  if(isDefined(var_1)) {
    var_6 = var_1._id_ECE9;
    var_7 = var_1.speed;
    var_8 = var_1.script_accel;
    var_9 = var_1._id_ED4C;
  } else {
    var_6 = undefined;
    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;
  }

  var_10 = isDefined(var_0._id_EED2) && var_0._id_EED2;
  var_11 = isDefined(var_0._id_EEFB);
  var_12 = isDefined(var_0._id_EDA0) && !scripts\engine\utility::flag(var_0._id_EDA0);
  var_13 = !isDefined(var_0.target);
  var_14 = isDefined(var_0.script_delay);

  if(isDefined(var_0.angles)) {
    var_15 = var_0.angles[1];
  } else {
    var_15 = 0;
  }

  if(self.health <= 0) {
    return;
  }
  var_16 = var_0.origin;

  if(isDefined(var_2)) {
    var_16 = scripts\sp\utility::_id_1796(var_16, var_2);
  }

  if(isDefined(self.heliheightoverride)) {
    var_16 = (var_16[0], var_16[1], self.heliheightoverride);
  }

  self _meth_83E1(var_16, var_7, var_8, var_9, var_0._id_EDD0, var_0.script_anglevehicle, var_15, var_6, var_14, var_10, var_11, var_12, var_13);

  if(isDefined(var_0.radius)) {
    self setneargoalnotifydist(var_0.radius);
    scripts\engine\utility::waittill_any("near_goal", "goal");
  } else
    self waittill("goal");

  _id_12783(var_0);

  if(isDefined(var_0._id_ED97)) {
    if(!isDefined(level._id_8DAF)) {}

    thread[[level._id_8DAF]](var_0);
  }

  var_0 scripts\sp\utility::script_delay();

  if(isDefined(self._id_C95D)) {
    scripts\sp\utility::_id_51D4(var_0);
  }

  self notify("continuepath");
}

_id_8023(var_0) {
  var_1 = undefined;
  var_2 = self.vehicletype;

  if(isaircraft(self)) {
    if(isDefined(self.target)) {
      var_3 = getcsplineid(self.target);

      if(isDefined(var_3)) {
        self _meth_8479(var_3);
      }
    }

    return;
  }

  if(isDefined(self._id_1323C)) {
    if(isDefined(self._id_1323C._id_5961) && self._id_5961) {
      return;
    }
  }

  if(isDefined(self.target)) {
    var_1 = getvehiclenode(self.target, "targetname");

    if(!isDefined(var_1)) {
      var_4 = getEntArray(self.target, "targetname");

      foreach(var_6 in var_4) {
        if(var_6.code_classname == "script_origin") {
          var_1 = var_6;
          break;
        }
      }
    }

    if(!isDefined(var_1)) {
      var_1 = scripts\engine\utility::getStruct(self.target, "targetname");
    }
  }

  if(!isDefined(var_1)) {
    if(scripts\sp\vehicle_code::_id_12F8()) {
      self vehicle_setspeed(60, 20, 10);
    }

    return;
  }

  self._id_247E = var_1;

  if(!scripts\sp\vehicle_code::_id_12F8()) {
    self.origin = var_1.origin;

    if(!isDefined(var_0)) {
      self attachpath(var_1);
    }
  } else if(isDefined(self.speed))
    self vehicle_setspeedimmediate(self.speed, 20);
  else if(isDefined(var_1.speed)) {
    var_8 = 20;
    var_9 = 10;

    if(isDefined(var_1.script_accel)) {
      var_8 = var_1.script_accel;
    }

    if(isDefined(var_1._id_ED4C)) {
      var_8 = var_1._id_ED4C;
    }

    self vehicle_setspeedimmediate(var_1.speed, var_8, var_9);
  } else
    self vehicle_setspeed(60, 20, 10);

  thread _id_1442(undefined, scripts\sp\vehicle_code::_id_12F8());
}

_id_1443(var_0) {
  var_1 = self._id_13244[var_0];
  self._id_13244[var_0] = undefined;

  if(self._id_13244.size) {
    return;
  }
  self resumespeed(var_1);
}

_id_1445(var_0, var_1, var_2) {
  if(!isDefined(self._id_13244)) {
    self._id_13244 = [];
  }

  self vehicle_setspeed(0, var_1, var_2);
  self._id_13244[var_0] = var_1;
}

_id_12BC7(var_0) {
  self endon("death");

  if(isDefined(self._id_65DB["prep_unload"]) && scripts\sp\utility::_id_65DB("prep_unload")) {
    return;
  }
  if(!isDefined(var_0._id_EDA0) && !isDefined(var_0.script_delay)) {
    self notify("newpath");
  }

  var_1 = getnode(var_0.targetname, "target");

  if(isDefined(var_1) && self._id_E4FB.size) {
    foreach(var_3 in self._id_E4FB) {
      if(isai(var_3)) {
        var_3 thread _id_0B77::_id_8409(var_1);
      }
    }
  }

  if(scripts\sp\vehicle_code::_id_12F8()) {
    self sethoverparams(0, 0, 0);
    scripts\sp\vehicle_code::_id_13804(var_0);
  }

  if(isDefined(var_0.script_noteworthy)) {
    if(var_0.script_noteworthy == "wait_for_flag") {
      scripts\engine\utility::flag_wait(var_0._id_ED9A);
    }
  }

  scripts\sp\vehicle_code::_id_1446(var_0._id_EEFB);

  if(scripts\sp\vehicle_aianim::_id_E4FC(var_0._id_EEFB)) {
    self waittill("unloaded");
  }

  if(isDefined(var_0._id_EDA0) || isDefined(var_0.script_delay)) {
    return;
  }
  if(isDefined(self)) {
    thread _id_13222();
  }
}