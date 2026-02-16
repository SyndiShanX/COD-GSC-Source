/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1742.gsc
*************************************************/

_id_3FC5(var_0, var_1, var_2) {
  var_3 = spawnStruct();

  if(!isDefined(level._id_3FE3)) {
    level._id_3FE3 = [];
  }

  if(!isDefined(var_2)) {
    level._id_3FE3[level._id_3FE3.size] = var_3;
  }

  var_3.v = [];
  var_3.v["type"] = var_0;
  var_3.v["fxid"] = var_1;
  var_3.v["angles"] = (0, 0, 0);
  var_3.v["origin"] = (0, 0, 0);
  return var_3;
}

_id_6B1F() {
  return 0.5;
}

_id_6BCD() {
  return -4;
}

_id_6A22() {
  return 0;
}

_id_6AC6() {
  return 0.75;
}

_id_6AC5() {
  return 2;
}

_id_400F() {
  var_0 = spawnStruct();

  if(!isDefined(level._id_3FE3)) {
    level._id_3FE3 = [];
  }

  level._id_3FE3[level._id_3FE3.size] = var_0;
  var_0.v = [];
  var_0.v["type"] = "soundfx";
  var_0.v["fxid"] = "No FX";
  var_0.v["soundalias"] = "nil";
  var_0.v["angles"] = (0, 0, 0);
  var_0.v["origin"] = (0, 0, 0);
  var_0.v["server_culled"] = 1;

  if(getDvar("#x3fff570c1283682b6") != "1") {
    var_0.v["server_culled"] = 0;
  }

  return var_0;
}

_id_3FFE() {
  var_0 = _id_400F();
  var_0.v["type"] = "soundfx_interval";
  var_0.v["delay_min"] = _id_6AC6();
  var_0.v["delay_max"] = _id_6AC5();
  return var_0;
}

_id_401C() {
  if(!isDefined(level._id_3FE3)) {
    level._id_3FE3 = [];
  }

  var_0 = _id_401D();
  level._id_3FE3[level._id_3FE3.size] = var_0;
  return var_0;
}

_id_0FD6(var_0, var_1) {
  var_2 = [];

  if(isDefined(level._id_3FE4[var_0])) {
    var_2 = level._id_3FE4[var_0];
  }

  var_2[var_2.size] = var_1;
  level._id_3FE4[var_0] = var_2;
}

_id_401D(var_0) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.v = [];
  }

  var_0.v["type"] = "exploder";
  var_0.v["exploder_type"] = "normal";

  if(!isDefined(var_0.v["fxid"])) {
    var_0.v["fxid"] = "No FX";
  }

  if(!isDefined(var_0.v["soundalias"])) {
    var_0.v["soundalias"] = "nil";
  }

  if(!isDefined(var_0.v["loopsound"])) {
    var_0.v["loopsound"] = "nil";
  }

  if(!isDefined(var_0.v["angles"])) {
    var_0.v["angles"] = (0, 0, 0);
  }

  if(!isDefined(var_0.v["origin"])) {
    var_0.v["origin"] = (0, 0, 0);
  }

  if(!isDefined(var_0.v["exploder"])) {
    var_0.v["exploder"] = 1;
  }

  if(!isDefined(var_0.v["flag"])) {
    var_0.v["flag"] = "nil";
  }

  if(!isDefined(var_0.v["delay"]) || var_0.v["delay"] < 0) {
    var_0.v["delay"] = _id_6A22();
  }

  return var_0;
}

_id_3FCA(var_0, var_1) {
  var_2 = scripts\engine\utility::_id_3FC9(var_0);
  var_2.v["exploder"] = var_1;
  return var_2;
}

_id_403B(var_0) {
  var_1 = spawnStruct();

  if(!isDefined(level._id_3FE3)) {
    level._id_3FE3 = [];
  }

  level._id_3FE3[level._id_3FE3.size] = var_1;
  var_1.v = [];
  var_1.v["origin"] = (0, 0, 0);
  var_1.v["reactive_radius"] = 350;

  if(isDefined(var_0)) {
    var_1.v["fxid"] = var_0;
  } else {
    var_1.v["fxid"] = "No FX";
  }

  var_1.v["type"] = "reactive_fx";
  var_1.v["soundalias"] = "nil";
  return var_1;
}

_id_D2B3(var_0, var_1) {
  if(isDefined(level._id_3FDE)) {
    var_0 = var_0 + level._id_3FDE;
  }

  self.v["origin"] = var_0;
  self.v["angles"] = var_1;
}

_id_D216() {
  self.v["up"] = anglestoup(self.v["angles"]);
  self.v["forward"] = anglesToForward(self.v["angles"]);
}

_id_3FD6() {
  _func_01B2("black");
  level._id_0BA7 = spawnStruct();
  level._id_0BA7._id_0203 = spawn("script_origin", (0, 0, 0));
  level._id_0BA7._id_0203._id_605B = loadfx("vfx/core/expl/grenadeexp_default");
  level._id_0BA7._id_0203._id_E050 = "frag_grenade_expl_trans";
  level._id_0BA7._id_0203._id_0359 = 256;
  precachemodel("axis_guide_createfx_rot");
  precachemodel("axis_guide_createfx");
  scripts\engine\utility::_id_5C11("createfx_saving");
  scripts\engine\utility::_id_5C11("createfx_started");

  if(!isDefined(level._id_3FD1)) {
    level._id_3FD1 = [];
  }

  level._id_3FDD = 0;
  waitframe();
  level notify("createfx_common_done");
}

_id_7FD2() {
  level._id_0BA7._id_D062 = 0;
  level._id_0BA7._id_D060 = 0;
  level._id_0BA7._id_D061 = 0;
  level._id_0BA7._id_D063 = 0;
  level._id_0BA7._id_D064 = 0;
  level._id_0BA7._id_D065 = 0;
  level._id_0BA7._id_D056 = [];
  level._id_0BA7._id_D057 = [];
  level._id_0BA7._id_C047 = 1;
  level._id_0BA7._id_DEAC = 0;
  level._id_0BA7._id_DEAA = 0;
  level._id_0BA7._id_DEAB = [0, 90, 45, 15];
  level._id_0BA7._id_1FEA = 0;
  level._id_0BA7._id_D035 = 0;
  level._id_0BA7._id_4F35 = 1;
  level._id_0BA7._id_B5E1 = getdvarfloat("#x364b5ba414a36852d");
  _id_D351();
}

_id_7FE1() {
  level._id_0BA7._id_96F4 = [];
  level._id_0BA7._id_96F4["escape"] = 1;
  level._id_0BA7._id_96F4["BUTTON_LSHLDR"] = 1;
  level._id_0BA7._id_96F4["BUTTON_RSHLDR"] = 1;
  level._id_0BA7._id_96F4["mouse1"] = 1;
  level._id_0BA7._id_96F4["lctrl"] = 1;
  level._id_0BA7._id_96F4["rctrl"] = 1;
}

_id_7F2B() {
  var_0 = [];
  var_0["loopfx"]["selected"] = (1, 1, 0.2);
  var_0["loopfx"]["highlighted"] = (0.4, 0.95, 1);
  var_0["loopfx"]["default"] = (0.3, 0.8, 1);
  var_0["oneshotfx"]["selected"] = (1, 1, 0.2);
  var_0["oneshotfx"]["highlighted"] = (0.4, 0.95, 1);
  var_0["oneshotfx"]["default"] = (0.3, 0.8, 1);
  var_0["exploder"]["selected"] = (1, 1, 0.2);
  var_0["exploder"]["highlighted"] = (1, 0.2, 0.2);
  var_0["exploder"]["default"] = (1, 0.1, 0.1);
  var_0["rainfx"]["selected"] = (1, 1, 0.2);
  var_0["rainfx"]["highlighted"] = (0.95, 0.4, 0.95);
  var_0["rainfx"]["default"] = (0.78, 0, 0.73);
  var_0["soundfx"]["selected"] = (1, 1, 0.2);
  var_0["soundfx"]["highlighted"] = (0.5, 1, 0.75);
  var_0["soundfx"]["default"] = (0.2, 0.9, 0.2);
  var_0["soundfx_interval"]["selected"] = (1, 1, 0.2);
  var_0["soundfx_interval"]["highlighted"] = (0.5, 1, 0.75);
  var_0["soundfx_interval"]["default"] = (0.2, 0.9, 0.2);
  var_0["reactive_fx"]["selected"] = (1, 1, 0.2);
  var_0["reactive_fx"]["highlighted"] = (0.5, 1, 0.75);
  var_0["reactive_fx"]["default"] = (0.2, 0.9, 0.2);
  level._id_0BA7._id_3A8B = var_0;
}

_id_3FE5() {
  waittillframeend;
  waitframe();

  if(!isDefined(level._effect)) {
    level._effect = [];
  }

  if(getDvar("#x3616d911ec20c3123") == "") {} else if(getDvar("#x3616d911ec20c3123") == level.script)
    [[level._id_6028]]();

  _id_7F49();
  _id_06CF::_id_7FF2();
  _id_7FBA();
  _id_80D9();
  _id_7FD2();
  _id_7FE1();
  _id_7F2B();
  level.player setclientomnvar("ui_hide_hud", 1);
  setdvarifuninitialized("#x3a1d18adc553b651d", "");
  setdvarifuninitialized("#x391a72272082bc233", "0");

  if(getDvar("#x3a9ad157d6dd65ae5") == "") {}

  if(getDvar("#x3364abcf570f203d3") == "") {}

  level._id_3FD8 = 1;
  level._id_8F18 = undefined;
  level._id_2DD4 = [];
  var_0 = (0, 0, 0);
  scripts\engine\utility::_id_5C1B("createfx_started");

  if(!level._id_A294) {
    var_0 = level.player.origin;
  }

  var_1 = undefined;
  level._id_6075 = 0;
  _id_06CF::_id_D5F8("none");
  level._id_3FE1 = 0;
  level._id_3FDC = 0;

  foreach(var_3 in level._id_3FE3) {
    var_3 _id_BA24();
  }

  thread _id_4F07();
  var_5 = undefined;
  thread _id_3FD3();

  for(;;) {
    var_6 = 0;
    var_7 = anglestoright(level.player getplayerangles());
    var_8 = anglesToForward(level.player getplayerangles());
    var_9 = anglestoup(level.player getplayerangles());
    var_10 = 0.85;
    var_11 = var_8 * 750;
    level._id_3FE2 = scripts\engine\trace::_bullet_trace(level.player getEye(), level.player getEye() + var_11, 0, undefined);
    var_12 = undefined;
    level._id_2DD0 = [];
    level._id_2DCB = [];
    _id_BD40();
    var_13 = _id_2DCA("lctrl", "rctrl", "BUTTON_LSHLDR");
    var_14 = _id_2DCA("lshift", "rshift");
    var_15 = _id_2DC9("mouse1", "BUTTON_A");
    var_16 = _id_2DCA("mouse1", "BUTTON_A");
    _id_06CF::_id_3F1C();
    var_17 = "F5";

    if(getdvarint("#x3a9ad157d6dd65ae5")) {
      var_17 = "F4";
    }

    if(_id_2DC9(var_17)) {}

    if(getdvarint("#x341c344a603afbde2")) {
      _id_628C();
    }

    if(_id_2DC9("F2")) {
      _id_F2BA();
    }

    if(_id_2DC9("z")) {
      _id_F2B9();
    }

    if(_id_2DC9("ins")) {
      _id_82E4();
    }

    if(_id_2DC9("del")) {
      _id_473F();
    }

    if(_id_2DC9("escape")) {
      _id_3904();
    }

    if(_id_2DC9("space")) {
      _id_D2AB();
    }

    if(_id_2DC9("u")) {
      _id_D036();
    }

    _id_A002();

    if(!var_13 && !var_14 && _id_2DC9("g")) {
      _id_D034("exploder");
      _id_D034("flag");
    }

    if(var_14) {
      if(_id_2DC9("g")) {
        _id_70FC();
      }
    }

    if(_id_2DCA("h", "F1") && !level._id_A294) {
      _id_DC46();
      waitframe();
      continue;
    }

    if(_id_2DC9("BUTTON_LSTICK")) {
      _id_3D55();
    }

    if(_id_2DC9("BUTTON_RSTICK")) {
      _id_AEB8();
    }

    if(var_13) {
      if(_id_2DC9("c")) {
        _id_3D55();
      }

      if(_id_2DC9("v")) {
        _id_AEB8();
      }

      if(_id_2DC9("g")) {
        _id_E150();
      }
    }

    if(isDefined(level._id_0BA7._id_D058)) {
      _id_06CF::_id_9DC2();
    }

    for(var_18 = 0; var_18 < level._id_3FE3.size; var_18++) {
      var_3 = level._id_3FE3[var_18];
      var_19 = vectornormalize(var_3.v["origin"] - (level.player.origin + (0, 0, 55)));
      var_20 = vectordot(var_8, var_19);

      if(var_20 < var_10) {
        continue;
      }
      var_10 = var_20;
      var_12 = var_3;
    }

    level._id_6067 = var_12;

    if(isDefined(var_12)) {
      if(isDefined(var_1)) {
        if(var_1 != var_12) {
          if(!_id_5482(var_1)) {
            var_1 thread _id_54F9();
          }

          if(!_id_5482(var_12)) {
            var_12 thread _id_54FA();
          }
        }
      } else if(!_id_5482(var_12))
        var_12 thread _id_54FA();
    }

    _id_9A39(var_12, var_15, var_16, var_13, var_7);
    var_6 = _id_740C(var_6);
    waitframe();

    if(var_6) {
      _id_FBC5();
    }

    if(!level._id_A294) {
      var_0 = [[level._id_6029]](var_0);
    }

    var_1 = var_12;

    if(_id_8F55(var_5)) {
      level._id_5107 = 0;
      _id_3904();
      _id_06CF::_id_D5F8("none");
    }

    if(level._id_0BA7._id_D057.size) {
      var_5 = level._id_0BA7._id_D057[level._id_0BA7._id_D057.size - 1];
      continue;
    }

    var_5 = undefined;
  }
}

_id_A002() {
  var_0 = 0;
  var_1 = _id_2DCA("lctrl", "rctrl");

  if(_id_2DCA(".")) {
    if(var_1) {
      if(level._id_0BA7._id_B5E1 < 190) {
        level._id_0BA7._id_B5E1 = 190;
      } else {
        level._id_0BA7._id_B5E1 = level._id_0BA7._id_B5E1 + 10;
      }
    } else
      level._id_0BA7._id_B5E1 = level._id_0BA7._id_B5E1 + 5;

    var_0 = 1;
  } else if(_id_2DCA(",")) {
    if(var_1) {
      if(level._id_0BA7._id_B5E1 > 190) {
        level._id_0BA7._id_B5E1 = 190;
      } else {
        level._id_0BA7._id_B5E1 = level._id_0BA7._id_B5E1 - 10;
      }
    } else
      level._id_0BA7._id_B5E1 = level._id_0BA7._id_B5E1 - 5;

    var_0 = 1;
  }

  if(var_0) {
    level._id_0BA7._id_B5E1 = clamp(level._id_0BA7._id_B5E1, 5, 500);
    [[level._id_6026]]();
    _id_D351();
  }
}

_id_D351() {
  if(level._id_A294) {
    return;
  }
  if(!isDefined(level._id_0BA7._id_B5E3)) {
    var_0 = newhudelem();
    var_0.alignx = "right";
    var_0._id_01D6 = 1;
    var_0.fontscale = 1.2;
    var_0.alpha = 0.2;
    var_0.x = 320;
    var_0.y = 420;
    var_1 = newhudelem();
    var_1.alignx = "left";
    var_1._id_01D6 = 1;
    var_1.fontscale = 1.2;
    var_1.alpha = 0.2;
    var_1.x = 320;
    var_1.y = 420;
    var_0._id_7B51 = var_1;
    level._id_0BA7._id_B5E3 = var_0;
  }

  level._id_0BA7._id_B5E3._id_7B51 _meth_83A3(level._id_0BA7._id_B5E1);
}

_id_F2BA() {
  level._id_3FD8 = !level._id_3FD8;
}

_id_82E4() {
  _id_06CF::_id_D5F8("creation");
  level._id_5107 = 0;
  _id_38D5();
  _id_D21D("Pick effect type to create:");
  _id_D21D("1. One Shot FX");

  if(!level._id_A294) {
    _id_D21D("2. Looping FX");
    _id_D21D("3. Looping sound");
    _id_D21D("4. Exploder");
    _id_D21D("5. One Shot Sound");
    _id_D21D("6. Reactive FX");
  } else {
    _id_D21D("2. Looping sound");
    _id_D21D("3. Exploder");
    _id_D21D("4. One Shot Sound");
    _id_D21D("5. Reactive FX");
  }

  _id_D21D("(c) Cancel >");
  _id_D21D("(x) Exit >");
}

_id_85BB(var_0, var_1) {
  if(var_1 != "") {
    if(isDefined(var_0.v["type"]) && issubstr(var_0.v["type"], var_1)) {
      return 0;
    } else if(isDefined(var_0.v["fxid"]) && issubstr(var_0.v["fxid"], var_1)) {
      return 0;
    } else if(isDefined(var_0.v["soundalias"]) && issubstr(var_0.v["soundalias"], var_1)) {
      return 0;
    }

    return 1;
  }

  return 0;
}

_id_9A39(var_0, var_1, var_2, var_3, var_4) {
  if(!level._id_3FD8) {
    return;
  }
  if(level._id_0BA7._id_D035) {
    level._id_0BA7._id_D035 = 0;
    var_0 = undefined;
  } else if(_id_D037())
    var_0 = undefined;

  for(var_5 = 0; var_5 < level._id_3FE3.size; var_5++) {
    var_6 = level._id_3FE3[var_5];

    if(!var_6._id_4F45) {
      continue;
    }
    if(_id_85BB(var_6, getDvar("#x3a1d18adc553b651d"))) {
      continue;
    }
    var_7 = getdvarfloat("#x3f1421f2b8dd03686");

    if(isDefined(var_0) && var_6 == var_0) {
      if(!_id_06CF::_id_54F0()) {
        _id_06CF::_id_4B5C(var_6);
      }

      if(var_1) {
        var_8 = _id_7DFB(var_5);
        level._id_3FE1 = !var_8;

        if(!var_3) {
          var_9 = level._id_0BA7._id_D057.size;
          _id_38CE();

          if(var_8 && var_9 == 1) {
            _id_D03D(var_5, var_6);
          }
        }

        _id_F2BD(var_5, var_6);
      } else if(var_2) {
        if(var_3) {
          if(level._id_3FE1) {
            _id_D03D(var_5, var_6);
          }

          if(!level._id_3FE1) {
            _id_4810(var_5, var_6);
          }
        }
      }

      var_10 = "highlighted";
    } else
      var_10 = "default";

    if(_id_7DFB(var_5)) {
      var_10 = "selected";
    }

    var_6 _id_3FE0(var_10, var_7, var_4);
  }
}

_id_4F21(var_0, var_1) {
  var_2 = level.player getvieworigin();
  var_3 = level.player getplayerangles();
  var_4 = level._id_0BA7._id_3A8B[self.v["type"]][var_1];
  var_5 = 0;
  var_6 = 1;
  var_7 = (0, 0, 0);
  var_8 = distancesquared(var_2, self.v["origin"]) < 36864;

  if(var_8) {
    var_9 = distance(var_2, self.v["origin"]);
    var_10 = var_9 / 176;
    var_5 = 1 - clamp(var_10, 0.0, 1.0);
    var_6 = clamp(var_10, 0.333, 1.0);
    var_11 = anglestoright(var_3) * -4;
    var_12 = anglestoup(var_3) * -4.666;
    var_7 = var_11 + var_12;
  }

  if(var_5 > 0) {
    var_13 = scripts\engine\utility::_id_10E76(var_2, var_3, self.v["origin"], 0.422618);

    if(var_13) {
      var_14 = 2.0;
      var_15 = 4.0;
      var_16 = anglesToForward(self.v["angles"]);
      var_16 = var_16 * (var_15 * var_0);
      var_17 = anglestoright(self.v["angles"]) * -1;
      var_17 = var_17 * (var_15 * var_0);
      var_18 = anglestoup(self.v["angles"]);
      var_18 = var_18 * (var_15 * var_0);
    }
  }
}

_id_3FE0(var_0, var_1, var_2) {
  _id_4F21(var_1, var_0);

  if(self._id_F0E9 > 0) {
    var_3 = _id_66C5();
    var_4 = var_2 * (var_3[0].size * -2.93);
    var_5 = level._id_0BA7._id_3A8B[self.v["type"]][var_0];

    if(isDefined(self._id_8679)) {
      var_5 = (1, 0.5, 0);
    }

    var_6 = 15;

    foreach(var_8 in var_3) {
      var_6 = var_6 - 13;
    }

    if(isDefined(self.v["reactive_radius"])) {
      if(self.v["fxid"] == "No FX" && !getdvarint("#x391a72272082bc233")) {
        return;
      }
    }
  }
}

_id_66C5() {
  switch (self.v["type"]) {
    case "reactive_fx":
      var_0[0] = "reactive sound: " + self.v["soundalias"];

      if(!level._id_A294) {
        var_0[1] = "reactive FX: " + self.v["fxid"];
      }

      return var_0;
    case "soundfx":
    case "soundfx_interval":
      return [self.v["soundalias"]];
    default:
      return [self.v["fxid"]];
  }
}

_id_D036() {
  level._id_5107 = 0;
  _id_38D5();
  _id_06CF::_id_D5F8("select_by_name");
  _id_06CF::_id_4F0A();
}

_id_740C(var_0) {
  if(level._id_0BA7._id_D057.size > 0) {
    var_0 = _id_D055(var_0);

    if(!_id_4180("selected_ents")) {
      _id_A453("selected_ents");
      _id_D3EA("Selected Ent Mode");
      _id_D3EA("Mode:", "move");
      _id_D3EA("Rate:", level._id_0BA7._id_C047);
      _id_D3EA("Snap2Normal:", level._id_0BA7._id_DEAC);
      _id_D3EA("Snap2Angle:", level._id_0BA7._id_DEAB[level._id_0BA7._id_DEAA]);
    }

    if(level._id_0BA7._id_1FEA && level._id_0BA7._id_D057.size > 0) {
      _id_D3EA("Mode:", "rotate");
      thread[[level._id_602A]]();

      if(_id_2DC9("enter", "p")) {
        _id_C5A6();
      }

      if(_id_2DC9("v")) {
        _id_3D52();
      }

      for(var_1 = 0; var_1 < level._id_0BA7._id_D057.size; var_1++) {
        level._id_0BA7._id_D057[var_1] _id_4EF0();
      }

      if(level._id_D063 != 0 || level._id_D065 != 0 || level._id_D064 != 0) {
        var_0 = 1;
      }
    } else {
      _id_D3EA("Mode:", "move");
      var_2 = _id_674B();

      for(var_1 = 0; var_1 < level._id_0BA7._id_D057.size; var_1++) {
        var_3 = level._id_0BA7._id_D057[var_1];

        if(isDefined(var_3.model)) {
          continue;
        }
        var_3 _id_4F03();
        var_3.v["origin"] = var_3.v["origin"] + var_2;
      }

      if(distance((0, 0, 0), var_2) > 0) {
        var_0 = 1;
      }
    }
  } else
    _id_390F();

  return var_0;
}

_id_D055(var_0) {
  if(_id_2DC9("lshift", "rshift", "BUTTON_X")) {
    _id_F2B6();
  }

  _id_A004();

  if(_id_2DC9("s")) {
    _id_F2D0();
  }

  if(_id_2DC9("r")) {
    _id_F2CF();
  }

  if(_id_2DC9("end", "l")) {
    _id_4FFE();
    var_0 = 1;
  }

  if(_id_2DC9("tab", "BUTTON_RSHLDR")) {
    _id_A1F9();
    var_0 = 1;
  }

  if(_id_2DC9("e")) {
    _id_3C7B();
    var_0 = 1;
  }

  return var_0;
}

_id_A004() {
  var_0 = _id_2DCA("lshift", "rshift");
  var_1 = _id_2DCA("lctrl", "rctrl");

  if(_id_2DC9("=")) {
    if(var_0) {
      level._id_0BA7._id_C047 = level._id_0BA7._id_C047 + 1;
    } else if(var_1) {
      if(level._id_0BA7._id_C047 < 1) {
        level._id_0BA7._id_C047 = 1;
      } else {
        level._id_0BA7._id_C047 = level._id_0BA7._id_C047 + 10;
      }
    } else
      level._id_0BA7._id_C047 = level._id_0BA7._id_C047 + 0.1;
  } else if(_id_2DC9("-")) {
    if(var_0) {
      level._id_0BA7._id_C047 = level._id_0BA7._id_C047 - 1;
    } else if(var_1) {
      if(level._id_0BA7._id_C047 > 1) {
        level._id_0BA7._id_C047 = 1;
      } else {
        level._id_0BA7._id_C047 = 0.1;
      }
    } else
      level._id_0BA7._id_C047 = level._id_0BA7._id_C047 - 0.1;
  }

  level._id_0BA7._id_C047 = clamp(level._id_0BA7._id_C047, 0.1, 100);
  _id_D3EA("Rate:", level._id_0BA7._id_C047);
}

_id_F2B6() {
  level._id_0BA7._id_1FEA = !level._id_0BA7._id_1FEA;
}

_id_F2D0() {
  level._id_0BA7._id_DEAC = !level._id_0BA7._id_DEAC;
  _id_D3EA("Snap2Normal:", level._id_0BA7._id_DEAC);
}

_id_F2CF() {
  level._id_0BA7._id_DEAA = level._id_0BA7._id_DEAA + 1;

  if(level._id_0BA7._id_DEAA >= level._id_0BA7._id_DEAB.size) {
    level._id_0BA7._id_DEAA = 0;
  }

  _id_D3EA("Snap2Angle:", level._id_0BA7._id_DEAB[level._id_0BA7._id_DEAA]);
}

_id_3D52() {
  level notify("new_ent_selection");

  for(var_0 = 0; var_0 < level._id_0BA7._id_D057.size; var_0++) {
    var_1 = level._id_0BA7._id_D057[var_0];
    var_1.v["angles"] = level._id_0BA7._id_D057[level._id_0BA7._id_D057.size - 1].v["angles"];
    var_1 _id_D216();
  }

  _id_FBC5();
}

_id_C5A6() {
  level notify("new_ent_selection");

  for(var_0 = 0; var_0 < level._id_0BA7._id_D057.size; var_0++) {
    var_1 = level._id_0BA7._id_D057[var_0];
    var_1.v["angles"] = (0, 0, 0);
    var_1 _id_D216();
  }

  _id_FBC5();
}

_id_8F55(var_0) {
  if(isDefined(var_0)) {
    if(!_id_06CF::_id_54F0()) {
      return 1;
    }
  } else
    return _id_06CF::_id_54F0();

  return var_0 != level._id_0BA7._id_D057[level._id_0BA7._id_D057.size - 1];
}

_id_4FFE() {
  for(var_0 = 0; var_0 < level._id_0BA7._id_D057.size; var_0++) {
    var_1 = level._id_0BA7._id_D057[var_0];
    var_2 = scripts\engine\trace::_bullet_trace(var_1.v["origin"], var_1.v["origin"] + (0, 0, -2048), 0, undefined);
    var_1.v["origin"] = var_2["position"];
  }
}

_id_D2AB() {
  level notify("createfx_exploder_reset");
  var_0 = [];

  foreach(var_2 in level._id_0BA7._id_D057) {
    if(isDefined(var_2.v["exploder"])) {
      var_0[var_2.v["exploder"]] = 1;
    }
  }

  foreach(var_6, var_5 in var_0) {
    scripts\engine\utility::_id_57BA(var_6);
  }
}

_id_4F07() {
  var_0 = 0;

  if(getdvarint("#x3454e4cad73195dd5") == 0) {}

  for(;;) {
    var_1 = getdvarint("#x3454e4cad73195dd5");
    var_1 = var_1 * var_1;

    for(var_2 = 0; var_2 < level._id_3FE3.size; var_2++) {
      var_3 = level._id_3FE3[var_2];
      var_3._id_4F45 = distancesquared(level.player.origin, var_3.v["origin"]) <= var_1;
      var_0++;

      if(var_0 > 100) {
        var_0 = 0;
        waitframe();
      }
    }

    if(level._id_3FE3.size == 0) {
      waitframe();
    }
  }
}

_id_3FD3() {
  setdvarifuninitialized("#x3865cd952f7946ba7", "300");

  for(;;) {
    wait(getdvarint("#x3865cd952f7946ba7"));
    scripts\engine\utility::_id_5C30("createfx_saving");

    if(getdvarint("#x3364abcf570f203d3")) {
      continue;
    }
    _id_628C(1);
  }
}

_id_C91D(var_0, var_1) {
  level endon("new_ent_selection");
  var_2 = 0.1;

  for(var_3 = 0; var_3 < var_2 * 20; var_3++) {
    if(level._id_D063 != 0) {
      var_0 _meth_8002(level._id_D063);
    } else if(level._id_D065 != 0) {
      var_0 _meth_8004(level._id_D065);
    } else {
      var_0 _meth_8003(level._id_D064);
    }

    waitframe();
    var_0 _id_4EF0();

    for(var_4 = 0; var_4 < level._id_0BA7._id_D057.size; var_4++) {
      var_5 = level._id_0BA7._id_D057[var_4];

      if(isDefined(var_5.model)) {
        continue;
      }
      var_5.v["origin"] = var_1[var_4].origin;
      var_5.v["angles"] = var_1[var_4].angles;
    }
  }
}

_id_473F() {
  if(level._id_3FDC) {
    _id_C447();
    return;
  }

  _id_4749();
}

_id_C447() {
  if(!isDefined(level._id_0BA7._id_D058)) {
    return;
  }
  var_0 = level._id_0BA7._id_AC58[level._id_0BA7._id_D058]["name"];

  for(var_1 = 0; var_1 < level._id_3FE3.size; var_1++) {
    var_2 = level._id_3FE3[var_1];

    if(!_id_5482(var_2)) {
      continue;
    }
    var_2 _id_C422(var_0);
  }

  _id_FBC5();
  _id_3904();
}

_id_C422(var_0) {
  self.v[var_0] = undefined;
}

_id_4749() {
  var_0 = [];

  for(var_1 = 0; var_1 < level._id_3FE3.size; var_1++) {
    var_2 = level._id_3FE3[var_1];

    if(_id_5482(var_2)) {
      if(isDefined(var_2._id_9845)) {
        var_2._id_9845 stoploopsound();
        var_2._id_9845 delete();
      }

      if(isDefined(var_2._id_9834)) {
        var_2._id_9834 delete();
      }

      var_2 notify("stop_loop");
      continue;
    }

    var_0[var_0.size] = var_2;
  }

  level._id_3FE3 = var_0;
  level._id_0BA7._id_D056 = [];
  level._id_0BA7._id_D057 = [];
  _id_38D5();
  _id_C380();
}

_id_A1F9() {
  var_0 = level._id_3FE2["position"];

  if(level._id_0BA7._id_D057.size <= 0) {
    return;
  }
  var_1 = _id_63BB(level._id_0BA7._id_D057);
  var_2 = var_1 - var_0;

  for(var_3 = 0; var_3 < level._id_0BA7._id_D057.size; var_3++) {
    var_4 = level._id_0BA7._id_D057[var_3];

    if(isDefined(var_4.model)) {
      continue;
    }
    var_4.v["origin"] = var_4.v["origin"] - var_2;

    if(level._id_0BA7._id_DEAC) {
      if(isDefined(level._id_3FE2["normal"])) {
        var_4.v["angles"] = vectortoangles(level._id_3FE2["normal"]);
      }
    }
  }
}

_id_3C7B() {
  if(level._id_0BA7._id_D057.size < 1) {
    return;
  }
  var_0 = 0;

  foreach(var_2 in level._id_0BA7._id_D057) {
    if(var_2.v["type"] == "oneshotfx") {
      var_0 = 1;
      _id_401D(var_2);
      continue;
    }
  }

  if(var_0) {
    _id_06CF::_id_D5F8("none");
    _id_06CF::_id_4B5C(_id_06CF::_id_6540());
  }
}

_id_D042() {
  _id_D03D(level._id_3FE3.size - 1, level._id_3FE3[level._id_3FE3.size - 1]);
}

_id_D034(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_0BA7._id_D057) {
    if(!isDefined(var_3.v[var_0])) {
      continue;
    }
    var_4 = var_3.v[var_0];
    var_1[var_4] = 1;
  }

  foreach(var_4, var_7 in var_1) {
    foreach(var_9, var_3 in level._id_3FE3) {
      if(_id_7DFB(var_9)) {
        continue;
      }
      if(!isDefined(var_3.v[var_0])) {
        continue;
      }
      if(var_3.v[var_0] != var_4) {
        continue;
      }
      _id_D03D(var_9, var_3);
    }
  }

  _id_FBC5();
}

_id_3D55() {
  if(level._id_0BA7._id_D057.size <= 0) {
    return;
  }
  var_0 = [];

  for(var_1 = 0; var_1 < level._id_0BA7._id_D057.size; var_1++) {
    var_2 = level._id_0BA7._id_D057[var_1];
    var_3 = spawnStruct();
    var_3.v = var_2.v;
    var_3 _id_BA24();
    var_0[var_0.size] = var_3;
  }

  level._id_E9C2 = var_0;
}

_id_BA24() {
  self._id_F0E9 = 0;
  self._id_4F45 = 1;
}

_id_AEB8() {
  if(!isDefined(level._id_E9C2)) {
    return;
  }
  _id_38CE();

  for(var_0 = 0; var_0 < level._id_E9C2.size; var_0++) {
    _id_0F97(level._id_E9C2[var_0]);
  }

  _id_A1F9();
  _id_FBC5();
  level._id_E9C2 = [];
  _id_3D55();
}

_id_0F97(var_0) {
  level._id_3FE3[level._id_3FE3.size] = var_0;
  _id_D042();
}

_id_63BB(var_0) {
  var_1 = (0, 0, 0);

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1 = (var_1[0] + var_0[var_2].v["origin"][0], var_1[1] + var_0[var_2].v["origin"][1], var_1[2] + var_0[var_2].v["origin"][2]);
  }

  return (var_1[0] / var_0.size, var_1[1] / var_0.size, var_1[2] / var_0.size);
}

_id_70FC() {
  var_0 = undefined;

  if(level._id_0BA7._id_D057.size > 0) {
    var_0 = _id_63BB(level._id_0BA7._id_D057);
  } else if(isDefined(level._id_6067)) {
    var_0 = level._id_6067.v["origin"];
  }

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = vectortoangles(level.player.origin - var_0);
  var_2 = var_0 + anglesToForward(var_1) * 200;
  level.player setorigin(var_2 + (0, 0, -60));
  level.player setplayerangles(vectortoangles(var_0 - var_2));
}

_id_546C() {
  self endon("death");

  for(;;) {
    _id_4EF0();
    waitframe();
  }
}

_id_C92A() {
  if(level._id_D064 != 0) {
    return 1;
  }

  if(level._id_D063 != 0) {
    return 1;
  }

  return level._id_D065 != 0;
}

_id_BCF6(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < level._id_0BA7._id_AC58.size; var_3++) {
    var_4 = level._id_0BA7._id_AC58[var_3];
    var_5 = var_4["name"];

    if(!isDefined(var_0.v[var_5])) {
      continue;
    }
    if(!_id_06CF::_id_9B90(var_4["mask"], var_0.v["type"])) {
      continue;
    }
    if(!level._id_A294) {
      if(_id_06CF::_id_9B90("fx", var_0.v["type"]) && var_5 == "fxid") {
        continue;
      }
      if(var_0.v["type"] == "exploder" && var_5 == "exploder") {
        continue;
      }
      var_6 = var_0.v["type"] + "/" + var_5;

      if(isDefined(level._id_0BA7._id_45C6[var_6]) && level._id_0BA7._id_45C6[var_6] == var_0.v[var_5]) {
        continue;
      }
    }

    if(var_4["type"] == "string") {
      var_7 = var_0.v[var_5] + "";

      if(var_7 == "nil") {
        continue;
      }
      _id_3396(var_1 + "ent.v[ \"" + var_5 + "\" ] = \"" + var_0.v[var_5] + "\";");
      continue;
    }

    _id_3396(var_1 + "ent.v[ \"" + var_5 + "\" ] = " + var_0.v[var_5] + ";");
  }
}

_id_54F9() {
  self notify("highlight change");
  self endon("highlight change");

  for(;;) {
    self._id_F0E9 = self._id_F0E9 * 0.85;
    self._id_F0E9 = self._id_F0E9 - 0.05;

    if(self._id_F0E9 < 0) {
      break;
    }

    wait 0.05;
  }

  self._id_F0E9 = 0;
}

_id_54FA() {
  self notify("highlight change");
  self endon("highlight change");

  for(;;) {
    self._id_F0E9 = self._id_F0E9 + 0.05;
    self._id_F0E9 = self._id_F0E9 * 1.25;

    if(self._id_F0E9 > 1) {
      break;
    }

    waitframe();
  }

  self._id_F0E9 = 1;
}

_id_3904() {
  level._id_3FDC = 0;
  level._id_0BA7._id_D058 = undefined;
  _id_C5B9();
}

_id_C5B9() {
  for(var_0 = 0; var_0 < level._id_0BA7._id_7B62; var_0++) {
    level._id_0BA7._id_7B64[var_0][0].color = (1, 1, 1);
  }
}

_id_F2BD(var_0, var_1) {
  if(isDefined(level._id_0BA7._id_D056[var_0])) {
    _id_4810(var_0, var_1);
  } else {
    _id_D03D(var_0, var_1);
  }
}

_id_D03D(var_0, var_1) {
  if(isDefined(level._id_0BA7._id_D056[var_0])) {
    return;
  }
  _id_3904();
  level notify("new_ent_selection");
  var_1 thread _id_54FA();
  level._id_0BA7._id_D056[var_0] = 1;
  level._id_0BA7._id_D057[level._id_0BA7._id_D057.size] = var_1;
}

_id_5480(var_0) {
  if(!isDefined(level._id_6067)) {
    return 0;
  }

  return var_0 == level._id_6067;
}

_id_4810(var_0, var_1) {
  if(!isDefined(level._id_0BA7._id_D056[var_0])) {
    return;
  }
  _id_3904();
  level notify("new_ent_selection");
  level._id_0BA7._id_D056[var_0] = undefined;

  if(!_id_5480(var_1)) {
    var_1 thread _id_54F9();
  }

  var_2 = [];

  for(var_3 = 0; var_3 < level._id_0BA7._id_D057.size; var_3++) {
    if(level._id_0BA7._id_D057[var_3] != var_1) {
      var_2[var_2.size] = level._id_0BA7._id_D057[var_3];
    }
  }

  level._id_0BA7._id_D057 = var_2;
}

_id_7DFB(var_0) {
  return isDefined(level._id_0BA7._id_D056[var_0]);
}

_id_5482(var_0) {
  for(var_1 = 0; var_1 < level._id_0BA7._id_D057.size; var_1++) {
    if(level._id_0BA7._id_D057[var_1] == var_0) {
      return 1;
    }
  }

  return 0;
}

_id_38CE() {
  for(var_0 = 0; var_0 < level._id_0BA7._id_D057.size; var_0++) {
    if(!_id_5480(level._id_0BA7._id_D057[var_0])) {
      level._id_0BA7._id_D057[var_0] thread _id_54F9();
    }
  }

  level._id_0BA7._id_D056 = [];
  level._id_0BA7._id_D057 = [];
}

_id_4EF0() {}

_id_D16C(var_0) {
  if(!isDefined(level._id_0BA7._id_0079)) {
    level._id_0BA7._id_0079 = spawn("script_model", (0, 0, 0));
  } else if(level._id_0BA7._id_0079.model != var_0) {
    level._id_0BA7._id_0079 setModel(var_0);
  }
}

_id_C380() {
  if(!isDefined(level._id_0BA7._id_0079)) {
    return;
  }
  level._id_0BA7._id_0079 delete();
}

_id_4F03() {}

_id_F2B9() {
  level._id_0BA7._id_4F35++;

  if(level._id_0BA7._id_4F35 > 2) {
    level._id_0BA7._id_4F35 = 0;
  }

  if(level._id_0BA7._id_4F35 != 1) {
    _id_C380();
  }
}

_id_3FD4(var_0) {
  thread _id_3FD5(var_0);
}

_id_3FD5(var_0) {
  level notify("new_createfx_centerprint");
  level endon("new_createfx_centerprint");
  wait 4.5;
}

_id_674B() {
  var_0 = level.player getplayerangles()[1];
  var_1 = (0, var_0, 0);
  var_2 = anglestoright(var_1);
  var_3 = anglesToForward(var_1);
  var_4 = anglestoup(var_1);
  var_5 = 0;
  var_6 = level._id_0BA7._id_C047;

  if(_id_2DD2("kp_uparrow", "DPAD_UP")) {
    if(level._id_D060 < 0) {
      level._id_D060 = 0;
    }

    level._id_D060 = level._id_D060 + var_6;
  } else if(_id_2DD2("kp_downarrow", "DPAD_DOWN")) {
    if(level._id_D060 > 0) {
      level._id_D060 = 0;
    }

    level._id_D060 = level._id_D060 - var_6;
  } else
    level._id_D060 = 0;

  if(_id_2DD2("kp_rightarrow", "DPAD_RIGHT")) {
    if(level._id_D061 < 0) {
      level._id_D061 = 0;
    }

    level._id_D061 = level._id_D061 + var_6;
  } else if(_id_2DD2("kp_leftarrow", "DPAD_LEFT")) {
    if(level._id_D061 > 0) {
      level._id_D061 = 0;
    }

    level._id_D061 = level._id_D061 - var_6;
  } else
    level._id_D061 = 0;

  if(_id_2DD2("BUTTON_Y")) {
    if(level._id_D062 < 0) {
      level._id_D062 = 0;
    }

    level._id_D062 = level._id_D062 + var_6;
  } else if(_id_2DD2("BUTTON_B")) {
    if(level._id_D062 > 0) {
      level._id_D062 = 0;
    }

    level._id_D062 = level._id_D062 - var_6;
  } else
    level._id_D062 = 0;

  var_7 = (0, 0, 0);
  var_7 = var_7 + var_3 * level._id_D060;
  var_7 = var_7 + var_2 * level._id_D061;
  var_7 = var_7 + var_4 * level._id_D062;
  return var_7;
}

_id_D14B() {
  var_0 = level._id_0BA7._id_C047;
  var_1 = level._id_0BA7._id_DEAB[level._id_0BA7._id_DEAA];

  if(var_1 != 0) {
    var_0 = 0;
  }

  if(_id_2DD2("kp_uparrow", "DPAD_UP")) {
    if(level._id_D063 < 0) {
      level._id_D063 = 0;
    }

    level._id_D063 = level._id_D063 + var_1 + var_0;
  } else if(_id_2DD2("kp_downarrow", "DPAD_DOWN")) {
    if(level._id_D063 > 0) {
      level._id_D063 = 0;
    }

    level._id_D063 = level._id_D063 - var_1 - var_0;
  } else
    level._id_D063 = 0;

  if(_id_2DD2("kp_leftarrow", "DPAD_LEFT")) {
    if(level._id_D065 < 0) {
      level._id_D065 = 0;
    }

    level._id_D065 = level._id_D065 + var_1 + var_0;
  } else if(_id_2DD2("kp_rightarrow", "DPAD_RIGHT")) {
    if(level._id_D065 > 0) {
      level._id_D065 = 0;
    }

    level._id_D065 = level._id_D065 - var_1 - var_0;
  } else
    level._id_D065 = 0;

  if(_id_2DD2("BUTTON_Y")) {
    if(level._id_D064 < 0) {
      level._id_D064 = 0;
    }

    level._id_D064 = level._id_D064 + var_1 + var_0;
  } else if(_id_2DD2("BUTTON_B")) {
    if(level._id_D064 > 0) {
      level._id_D064 = 0;
    }

    level._id_D064 = level._id_D064 - var_1 - var_0;
  } else
    level._id_D064 = 0;
}

_id_FBC5() {
  var_0 = 0;

  foreach(var_2 in level._id_0BA7._id_D057) {
    if(var_2.v["type"] == "reactive_fx") {
      var_0 = 1;
    }

    var_2[[level._id_6034]]();
  }

  if(var_0) {
    _id_C1A7();
  }
}

_id_E89E() {
  if(isDefined(self._id_9834)) {
    self._id_9834 delete();
  }

  _id_E8B7();
}

_id_E8B7() {
  self notify("stop_loop");
}

_id_601D() {
  if(!isDefined(level._id_0BCD)) {
    var_0 = getarraykeys(level._effect);
  } else {
    var_0 = getarraykeys(level._effect);

    if(var_0.size == level._id_0BCD.size) {
      return level._id_0BCD;
    }
  }

  var_0 = scripts\engine\utility::_id_163E(var_0);
  level._id_0BCD = var_0;
  return var_0;
}

_id_C6DA() {
  _id_E89E();
  _id_D216();

  switch (self.v["type"]) {
    case "oneshotfx":
      _id_06D6::_id_3F7D();
      break;
    case "loopfx":
      _id_06D6::_id_3F39();
      break;
    case "soundfx":
      _id_06D6::_id_3F3A();
      break;
    case "soundfx_interval":
      _id_06D6::_id_3F2B();
      break;
  }
}

_id_C1A7() {
  level._id_0BF2._id_C093 = undefined;

  foreach(var_1 in level._id_3FE3) {
    if(var_1.v["type"] == "reactive_fx") {
      var_1 _id_D216();
      var_1 _id_06D6::_id_100E();
    }
  }
}

_id_BD4F() {
  if(level._id_6075) {
    return;
  }
  _id_D14B();

  if(!_id_C92A()) {
    return;
  }
  level._id_6075 = 1;

  if(level._id_0BA7._id_D057.size > 1) {
    var_0 = _id_63BB(level._id_0BA7._id_D057);
    var_1 = spawn("script_origin", var_0);
    var_1.v["angles"] = level._id_0BA7._id_D057[0].v["angles"];
    var_1.v["origin"] = var_0;
    var_2 = [];

    for(var_3 = 0; var_3 < level._id_0BA7._id_D057.size; var_3++) {
      var_2[var_3] = spawn("script_origin", level._id_0BA7._id_D057[var_3].v["origin"]);
      var_2[var_3].angles = level._id_0BA7._id_D057[var_3].v["angles"];
      var_2[var_3] linkto(var_1);
    }

    _id_C91D(var_1, var_2);
    var_1 delete();

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_2[var_3] delete();
    }
  } else if(level._id_0BA7._id_D057.size == 1) {
    var_4 = level._id_0BA7._id_D057[0];
    var_2 = spawn("script_origin", (0, 0, 0));
    var_2.angles = var_4.v["angles"];

    if(level._id_D063 != 0) {
      var_2 _meth_8002(level._id_D063);
    } else if(level._id_D065 != 0) {
      var_2 _meth_8004(level._id_D065);
    } else {
      var_2 _meth_8003(level._id_D064);
    }

    var_4.v["angles"] = var_2.angles;
    var_2 delete();
    waitframe();
  }

  level._id_6075 = 0;
}

_id_E150() {
  playFX(level._id_0BA7._id_0203._id_605B, level._id_3FE2["position"]);
  level._id_0BA7._id_0203 playSound(level._id_0BA7._id_0203._id_E050);
  _func_01BA(level._id_3FE2["position"], level._id_0BA7._id_0203._id_0359, 50, 5, undefined, "MOD_EXPLOSIVE");
  level notify("code_damageradius", undefined, level._id_0BA7._id_0203._id_0359, level._id_3FE2["position"]);
}

_id_DC46() {
  _id_38D5();
  _id_D21D("Help:");
  _id_D21D("InsertInsert entity");
  _id_D21D("L Drop selected entities to the ground");
  _id_D21D("A Add option to the selected entities");
  _id_D21D("P Reset the rotation of the selected entities");
  _id_D21D("V Copy the angles from the most recently selected fx onto all selected fx.");
  _id_D21D("DeleteKill the selected entities");
  _id_D21D("ESCAPECancel out of option-modify-mode, must have console open");
  _id_D21D("Ctrl-CCopy");
  _id_D21D("Ctrl-VPaste");
  _id_D21D("F2Toggle createfx dot and text drawing");
  _id_D21D("F5SAVES your work");
  _id_D21D("DpadMove selected entitise on X/Y or rotate pitch/yaw");
  _id_D21D("A buttonToggle the selection of the current entity");
  _id_D21D("X buttonToggle entity rotation mode");
  _id_D21D("Y buttonMove selected entites up or rotate roll");
  _id_D21D("B buttonMove selected entites down or rotate roll");
  _id_D21D("R ShoulderMove selected entities to the cursor");
  _id_D21D("L ShoulderHold to select multiple entites");
  _id_D21D("L JoyClickCopy");
  _id_D21D("R JoyClickPaste");
  _id_D21D("N UFO");
  _id_D21D("T Toggle Timescale FAST");
  _id_D21D("Y Toggle Timescale SLOW");
  _id_D21D("[ Toggle FX Visibility");
  _id_D21D("] Toggle ShowTris");
  _id_D21D("F11 Toggle FX Profile");
}

_id_628C(var_0) {}

_id_10FBE(var_0, var_1, var_2, var_3) {
  var_4 = "\t";
  _id_3398();
  _id_3396("");
  _id_3396("#include scripts\\engine\\utility;");
  _id_3396("#include scripts\\common\\utility;");
  _id_3396("#include scripts\\common\\createfx;\n");
  _id_3396("");
  _id_3396("main()");
  _id_3396("{");
  _id_3396(var_4 + "// CreateFX " + var_1 + " entities placed: " + var_0.size);

  foreach(var_6 in var_0) {
    if(level._id_3FDD > 16) {
      level._id_3FDD = 0;
      wait 0.1;
    }

    level._id_3FDD++;

    if(getdvarint("#x380b59b43add14b46")) {
      if(!isDefined(var_6.model)) {
        continue;
      }
    } else if(isDefined(var_6.model)) {
      continue;
    }
    if(var_6.v["type"] == "oneshotfx") {
      _id_3396(var_4 + "ent = createOneshotEffect( \"" + var_6.v["fxid"] + "\" );");
    }

    if(var_6.v["type"] == "loopfx") {
      _id_3396(var_4 + "ent = createLoopEffect( \"" + var_6.v["fxid"] + "\" );");
    }

    if(var_6.v["type"] == "exploder") {
      if(isDefined(var_6.v["exploder"]) && !level._id_A294) {
        _id_3396(var_4 + "ent = createExploderEx( \"" + var_6.v["fxid"] + "\", \"" + var_6.v["exploder"] + "\" );");
      } else {
        _id_3396(var_4 + "ent = createExploder( \"" + var_6.v["fxid"] + "\" );");
      }
    }

    if(var_6.v["type"] == "soundfx") {
      _id_3396(var_4 + "ent = createLoopSound();");
    }

    if(var_6.v["type"] == "soundfx_interval") {
      _id_3396(var_4 + "ent = createIntervalSound();");
    }

    if(var_6.v["type"] == "reactive_fx") {
      if(var_1 == "fx" && var_6.v["fxid"] != "No FX" && !level._id_A294) {
        _id_3396(var_4 + "ent = createReactiveEnt( \"" + var_6.v["fxid"] + "\" );");
      } else if(var_1 == "sound" && var_6.v["fxid"] == "No FX") {
        _id_3396(var_4 + "ent = createReactiveEnt();");
      } else {
        continue;
      }
    }

    _id_3396(var_4 + "ent set_origin_and_angles( " + var_6.v["origin"] + ", " + var_6.v["angles"] + " );");
    _id_BCF6(var_6, var_4, var_2);
    _id_3396("");
  }

  _id_3396("}");
  _id_3396(" ");
  _id_3397(var_2, var_3, var_1);
}

_id_3FD2() {
  var_0 = 0.1;

  foreach(var_2 in level._id_3FE3) {
    var_3 = [];
    var_4 = [];

    for(var_5 = 0; var_5 < 3; var_5++) {
      var_3[var_5] = var_2.v["origin"][var_5];
      var_4[var_5] = var_2.v["angles"][var_5];

      if(var_3[var_5] < var_0 && var_3[var_5] > var_0 * -1) {
        var_3[var_5] = 0;
      }

      if(var_4[var_5] < var_0 && var_4[var_5] > var_0 * -1) {
        var_4[var_5] = 0;
      }
    }

    var_2.v["origin"] = (var_3[0], var_3[1], var_3[2]);
    var_2.v["angles"] = (var_4[0], var_4[1], var_4[2]);
  }
}

_id_641D(var_0) {
  var_1 = _id_641F(var_0);
  var_2 = [];

  foreach(var_5, var_4 in var_1) {
    var_2[var_5] = [];
  }

  foreach(var_7 in level._id_3FE3) {
    var_8 = 0;

    foreach(var_5, var_0 in var_1) {
      if(var_7.v["type"] != var_0) {
        continue;
      }
      var_8 = 1;
      var_2[var_5][var_2[var_5].size] = var_7;
      break;
    }
  }

  var_11 = [];

  for(var_12 = 0; var_12 < var_1.size; var_12++) {
    foreach(var_7 in var_2[var_12]) {
      var_11[var_11.size] = var_7;
    }
  }

  return var_11;
}

_id_641F(var_0) {
  var_1 = [];

  if(var_0 == "fx") {
    var_1[0] = "oneshotfx";
    var_1[1] = "loopfx";
    var_1[2] = "exploder";
    var_1[3] = "reactive_fx";
  } else {
    var_1[0] = "soundfx";
    var_1[1] = "soundfx_interval";
    var_1[2] = "reactive_fx";
  }

  return var_1;
}

_id_34B3(var_0, var_1) {
  if(var_0.v["fxid"] != "No FX" && var_1 == "fx") {
    return 1;
  }

  if(var_0.v["fxid"] == "No FX" && var_1 == "sound") {
    return 1;
  }

  return 0;
}

_id_858C(var_0, var_1) {
  var_2 = _id_641F(var_1);

  if(var_0.v["type"] == "reactive_fx") {
    if(_id_34B3(var_0, var_1)) {
      return 1;
    } else {
      return 0;
    }
  }

  foreach(var_4 in var_2) {
    if(var_0.v["type"] == var_4) {
      return 1;
    }
  }

  return 0;
}

_id_3FDB() {
  var_0 = [];
  var_0[var_0.size] = "soundfx";
  var_0[var_0.size] = "oneshotfx";
  var_0[var_0.size] = "exploder";
  var_0[var_0.size] = "soundfx_interval";
  var_0[var_0.size] = "reactive_fx";

  if(!level._id_A294) {
    var_0[var_0.size] = "loopfx";
  }

  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    var_1[var_4] = [];
  }

  foreach(var_6 in level._id_3FE3) {
    var_7 = 0;

    foreach(var_4, var_9 in var_0) {
      if(var_6.v["type"] != var_9) {
        continue;
      }
      var_7 = 1;
      var_1[var_4][var_1[var_4].size] = var_6;
      break;
    }
  }

  var_11 = [];

  for(var_12 = 0; var_12 < var_0.size; var_12++) {
    foreach(var_6 in var_1[var_12]) {
      var_11[var_11.size] = var_6;
    }
  }

  level._id_3FE3 = var_11;
}

_id_3398() {
  scripts\engine\utility::_id_5A33();
}

_id_3396(var_0) {
  scripts\engine\utility::_id_5A31(var_0);
}

_id_3397(var_0, var_1, var_2) {
  var_3 = 1;

  if(var_1 != "" || var_0) {
    var_3 = 0;
  }

  if(scripts\common\utility::issp()) {
    var_4 = level.script + var_1 + "_" + var_2 + ".gsc";

    if(var_0) {
      var_4 = "backup_" + var_2 + ".gsc";
    }
  } else {
    var_4 = level.script + var_1 + "_" + var_2 + ".gsc";

    if(var_0) {
      var_4 = "backup.gsc";
    }
  }

  var_5 = _id_66F1();
  var_6 = _id_64C0();
  scripts\engine\utility::_id_5A32("/share/" + var_5 + "/scripts/" + var_6 + "/maps/" + level.script + "/gen/" + var_4, var_3);
}

_id_66F1() {
  if(isDefined(level._id_3FD7) && level._id_3FD7) {
    return "devraw";
  } else {
    return "raw";
  }
}

_id_64C0() {
  if(scripts\common\utility::iscp()) {
    return "cp";
  } else if(scripts\common\utility::issp()) {
    return "sp";
  } else {
    return "mp";
  }
}

_id_BD40() {
  _id_0FA2("mouse1");
  _id_0FA2("BUTTON_RSHLDR");
  _id_0FA2("BUTTON_LSHLDR");
  _id_0FA2("BUTTON_RSTICK");
  _id_0FA2("BUTTON_LSTICK");
  _id_0FA2("BUTTON_A");
  _id_0FA2("BUTTON_B");
  _id_0FA2("BUTTON_X");
  _id_0FA2("BUTTON_Y");
  _id_0FA2("DPAD_UP");
  _id_0FA2("DPAD_LEFT");
  _id_0FA2("DPAD_RIGHT");
  _id_0FA2("DPAD_DOWN");
  _id_0FE7("lshift");
  _id_0FE7("rshift");
  _id_0FE7("lctrl");
  _id_0FE7("rctrl");
  _id_0FE7("escape");
  _id_0FE7("F1");
  _id_0FE7("F5");
  _id_0FE7("F4");
  _id_0FE7("F2");
  _id_0FE7("a");
  _id_0FE7("e");
  _id_0FE7("g");
  _id_0FE7("c");
  _id_0FE7("h");
  _id_0FE7("i");
  _id_0FE7("k");
  _id_0FE7("l");
  _id_0FE7("m");
  _id_0FE7("p");
  _id_0FE7("r");
  _id_0FE7("s");
  _id_0FE7("u");
  _id_0FE7("v");
  _id_0FE7("x");
  _id_0FE7("z");
  _id_0FE7("del");
  _id_0FE7("end");
  _id_0FE7("tab");
  _id_0FE7("ins");
  _id_0FE7("add");
  _id_0FE7("space");
  _id_0FE7("enter");
  _id_0FE7("1");
  _id_0FE7("2");
  _id_0FE7("3");
  _id_0FE7("4");
  _id_0FE7("5");
  _id_0FE7("6");
  _id_0FE7("7");
  _id_0FE7("8");
  _id_0FE7("9");
  _id_0FE7("0");
  _id_0FE7("-");
  _id_0FE7("=");
  _id_0FE7(",");
  _id_0FE7(".");
  _id_0FE7("[");
  _id_0FE7("]");
  _id_0FE7("leftarrow");
  _id_0FE7("rightarrow");
  _id_0FE7("uparrow");
  _id_0FE7("downarrow");
}

_id_96EF(var_0) {
  if(isDefined(level._id_0BA7._id_96F4[var_0])) {
    return 0;
  }

  return _id_8CAF(var_0);
}

_id_8CAF(var_0) {
  return level._id_3FDC && isDefined(level._id_2DCB[var_0]);
}

_id_0FA2(var_0) {
  if(_id_96EF(var_0)) {
    return;
  }
  if(!isDefined(level._id_2DD4[var_0])) {
    if(level.player _meth_805E(var_0)) {
      level._id_2DD4[var_0] = 1;
      level._id_2DD0[var_0] = 1;
    }
  } else if(!level.player _meth_805E(var_0))
    level._id_2DD4[var_0] = undefined;
}

_id_0FE7(var_0) {
  level._id_2DCB[var_0] = 1;
  _id_0FA2(var_0);
}

_id_2DD2(var_0, var_1) {
  return _id_2DDB(var_0) || _id_2DDB(var_1);
}

_id_2DDB(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(_id_8CAF(var_0)) {
    return 0;
  }

  return level.player _meth_805E(var_0);
}

_id_2DCA(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    if(isDefined(level._id_2DD4[var_2])) {
      return 1;
    }
  }

  if(isDefined(var_1)) {
    if(isDefined(level._id_2DD4[var_1])) {
      return 1;
    }
  }

  return isDefined(level._id_2DD4[var_0]);
}

_id_2DC9(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    if(isDefined(level._id_2DD0[var_2])) {
      return 1;
    }
  }

  if(isDefined(var_1)) {
    if(isDefined(level._id_2DD0[var_1])) {
      return 1;
    }
  }

  return isDefined(level._id_2DD0[var_0]);
}

_id_7FBA() {
  level._id_0BA7._id_7B64 = [];
  level._id_0BA7._id_7B62 = 30;

  if(level._id_A294) {
    level._id_0BA7._id_7B62 = 16;
  }

  var_0 = [];
  var_1 = [];
  var_0[0] = 0;
  var_1[0] = 0;
  var_0[1] = 1;
  var_1[1] = 1;
  var_0[2] = -2;
  var_1[2] = 1;
  var_0[3] = 1;
  var_1[3] = -1;
  var_0[4] = -2;
  var_1[4] = -1;
  level._id_398E = newhudelem();
  level._id_398E.alpha = 0;
  level._id_398E.archived = 0;

  for(var_2 = 0; var_2 < level._id_0BA7._id_7B62; var_2++) {
    var_3 = [];

    for(var_4 = 0; var_4 < 1; var_4++) {
      var_5 = newhudelem();
      var_5.alignx = "left";
      var_5.archived = 0;
      var_5._id_96CF = 0;
      var_5._id_01D6 = 1;
      var_5.fontscale = 1.4;
      var_5.sort = 20 - var_4;
      var_5.alpha = 1;
      var_5.x = 0 + var_0[var_4];
      var_5.y = 60 + var_1[var_4] + var_2 * 15;

      if(var_4 > 0) {
        var_5.color = (0, 0, 0);
      }

      var_3[var_3.size] = var_5;
    }

    level._id_0BA7._id_7B64[var_2] = var_3;
  }

  var_6 = newhudelem();
  var_6.archived = 0;
  var_6.alignx = "center";
  var_6._id_96CF = 0;
  var_6._id_01D6 = 1;
  var_6.fontscale = 1.4;
  var_6.sort = 20;
  var_6.alpha = 1;
  var_6.x = 320;
  var_6.y = 40;
  level._id_3FD4 = var_6;
}

_id_7F49() {
  var_0 = newhudelem();
  var_0.archived = 0;
  var_0._id_96CF = 0;
  var_0.alignx = "center";
  var_0.aligny = "middle";
  var_0._id_01D6 = 1;
  var_0.fontscale = 1;
  var_0.sort = 20;
  var_0.alpha = 1;
  var_0.x = 320;
  var_0.y = 233;
}

_id_38D5() {
  level._id_398E _meth_8076();

  for(var_0 = 0; var_0 < level._id_0BA7._id_7B62; var_0++) {
    for(var_1 = 0; var_1 < 1; var_1++) {}
  }

  level._id_608D = 0;
}

_id_D21D(var_0) {
  for(var_1 = 0; var_1 < 1; var_1++) {}

  level._id_608D++;
}

_id_80D9() {
  if(!isDefined(level._id_0BA7._id_F33F)) {
    level._id_0BA7._id_F33F = [];
  }

  if(!isDefined(level._id_0BA7._id_F33E)) {
    level._id_0BA7._id_F33E = 1;
  }

  if(!isDefined(level._id_0BA7._id_F33D)) {
    level._id_0BA7._id_F33D = "";
  }
}

_id_A453(var_0) {
  foreach(var_3, var_2 in level._id_0BA7._id_F33F) {
    if(isDefined(var_2._id_FF69)) {
      var_2._id_FF69 destroy();
    }

    var_2 destroy();
    level._id_0BA7._id_F33F[var_3] = undefined;
  }

  level._id_0BA7._id_F33D = var_0;
}

_id_4180(var_0) {
  return level._id_0BA7._id_F33D == var_0;
}

_id_390F() {
  _id_A453("");
}

_id_A454(var_0) {
  var_1 = newhudelem();
  var_1.archived = 0;
  var_1.alignx = "left";
  var_1._id_96CF = 0;
  var_1._id_01D6 = 1;
  var_1.fontscale = 1.2;
  var_1.alpha = 1;
  var_1.x = 0;
  var_1.y = 320 + var_0 * 15;
  return var_1;
}

_id_67D6(var_0) {
  if(isDefined(level._id_0BA7._id_F33F[var_0])) {
    return level._id_0BA7._id_F33F[var_0];
  }

  return undefined;
}

_id_D3EA(var_0, var_1) {
  if(level._id_A294) {
    return;
  }
  var_2 = _id_67D6(var_0);

  if(!isDefined(var_2)) {
    var_2 = _id_A454(level._id_0BA7._id_F33F.size);
    level._id_0BA7._id_F33F[var_0] = var_2;
    var_2._id_F0E8 = var_0;
  }

  if(isDefined(var_1)) {
    if(isDefined(var_2._id_FF69)) {
      var_3 = var_2._id_FF69;
    } else {
      var_3 = _id_A454(level._id_0BA7._id_F33F.size);
      var_3.x = var_3.x + 100;
      var_3.y = var_2.y;
      var_2._id_FF69 = var_3;
    }

    if(isDefined(var_3._id_F0E8) && var_3._id_F0E8 == var_1) {
      return;
    }
    var_3._id_F0E8 = var_1;
  }
}

_id_D037() {
  var_0 = getDvar("#x3ca33775c883a0508");

  if(var_0 == "") {
    return 0;
  }

  setDvar("#x3ca33775c883a0508", "");
  var_1 = [];

  foreach(var_4, var_3 in level._id_3FE3) {
    if(issubstr(var_3.v["fxid"], var_0)) {
      var_1[var_1.size] = var_4;
    }
  }

  if(var_1.size == 0) {
    return 0;
  }

  _id_480F();
  _id_D03F(var_1);

  foreach(var_6 in var_1) {
    var_3 = level._id_3FE3[var_6];
    _id_D03D(var_6, var_3);
  }

  return 1;
}

_id_D03F(var_0) {
  foreach(var_2 in var_0) {
    var_3 = level._id_3FE3[var_2];
    _id_D03D(var_2, var_3);
  }
}

_id_480F() {
  foreach(var_2, var_1 in level._id_0BA7._id_D057) {
    _id_4810(var_2, var_1);
  }
}