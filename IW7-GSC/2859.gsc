/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2859.gsc
**************************************/

_id_6B44() {
  setdvarifuninitialized("debug_fakeactor", 0);
  setdvarifuninitialized("debug_fakeactor_accuracy", 0);
  level._effect["fakeactor_muzflash"] = loadfx("vfx/core/muzflash/ak47_flash_wv");

  if(!isDefined(level._id_B438)) {
    level._id_B438 = [];
  }

  if(!isDefined(level._id_B438["allies"])) {
    level._id_B438["allies"] = 9999;
  }

  if(!isDefined(level._id_B438["axis"])) {
    level._id_B438["axis"] = 9999;
  }

  if(!isDefined(level._id_B438["team3"])) {
    level._id_B438["team3"] = 9999;
  }

  if(!isDefined(level._id_B438["neutral"])) {
    level._id_B438["neutral"] = 9999;
  }

  if(!isDefined(level._id_6B46)) {
    level._id_6B46 = [];
  }

  if(!isDefined(level._id_6B46["allies"])) {
    level._id_6B46["allies"] = ::scripts\sp\utility::_id_1115A();
  }

  if(!isDefined(level._id_6B46["axis"])) {
    level._id_6B46["axis"] = ::scripts\sp\utility::_id_1115A();
  }

  if(!isDefined(level._id_6B46["team3"])) {
    level._id_6B46["team3"] = ::scripts\sp\utility::_id_1115A();
  }

  if(!isDefined(level._id_6B46["neutral"])) {
    level._id_6B46["neutral"] = ::scripts\sp\utility::_id_1115A();
  }

  if(!isDefined(level._id_6A65)) {
    _id_174C("default", "anim", ::_id_CC8A, ::_id_CC86, 30);
    _id_174C("default", "move", ::_id_BC82, ::_id_BC1C, 10);
    _id_174C("default", "traverse", ::_id_126D9, ::_id_126D0, 20);
    _id_174C("default", "idle", ::_id_92EE, ::_id_92D9, 40);
  }

  level._id_6B43 = ::_id_6B16;

  if(!isDefined(anim._id_6A64)) {
    var_0 = [];
    var_0["Cover Left"] = 0;
    var_0["Cover Right"] = -90;
    var_0["Cover Crouch"] = -90;
    var_0["Cover Stand"] = -90;
    var_0["Cover Stand 3D"] = -90;
    anim._id_6A64 = var_0;
    var_0 = [];
    var_0["Cover Left"] = 180;
    var_0["Cover Left Crouch"] = 0;
    var_0["Cover Right"] = 180;
    var_0["Cover Crouch"] = 180;
    var_0["Cover Stand"] = 180;
    anim._id_6A63 = var_0;
  }
}

_id_79AF(var_0) {
  return level._id_6B46[var_0]._id_2274;
}

_id_9BDF() {
  return isDefined(self._id_ED8A) && self._id_ED8A;
}

_id_6B16() {
  if(level._id_6B46[self.team]._id_2274.size >= level._id_B438[self.team]) {
    self delete();
    return;
  }

  thread _id_2294(self);
  level notify("new_fakeactor");
  self._id_EDB3 = undefined;
  self.flags = 0;
  self.upaimlimit = -45;
  self.downaimlimit = 45;
  self.rightaimlimit = -45;
  self.leftaimlimit = 45;
  self._id_2894 = 1;
  self._id_AFED = 200;
  self._id_B04E = 0.5;
  _id_F2C3(["exposed"]);

  if(isDefined(self._id_ED56)) {
    if(self._id_ED56 == "frantic") {
      _id_F3BE(1);
    }

    self._id_ED56 = undefined;
  }

  if(isDefined(self._id_ED61)) {
    _id_F35C(self._id_ED61);
    self._id_ED61 = undefined;
  }

  if(isDefined(self._id_ED62)) {
    _id_F35D(self._id_ED62);
    self._id_ED62 = undefined;
  }

  if(isDefined(self._id_EDE1)) {
    _id_F410(self._id_EDE1);
    self._id_EDE1 = undefined;
  }

  if(isDefined(self._id_ECF9)) {
    _id_F2C6(self._id_ECF9);
    self._id_ECF9 = undefined;
  }

  if(isDefined(self._id_EEFF)) {
    _id_F568(self._id_EEFF);
    self._id_EEFF = undefined;
  }

  if(isDefined(self._id_EEFE)) {
    _id_F5F9(self._id_EEFE);
    self._id_EEFE = undefined;
  }

  _id_6B15();
  self hide();
  scripts\engine\utility::delaycall(0.05, ::show);

  if(self.team == "axis") {
    self enableaimassist();
  }

  self setCanDamage(1);
  self.health = 150;
  thread _id_6B45();
}

_id_495A(var_0) {
  if(!isDefined(level._id_6A65)) {
    level._id_6A65 = [];
  }

  level._id_6A65[var_0] = [];
}

_id_7CA8(var_0) {
  return level._id_6A65[var_0];
}

_id_174C(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level._id_6A65)) {
    level._id_6A65 = [];
  }

  if(!isDefined(level._id_6A65[var_0])) {
    _id_495A(var_0);
  }

  var_5 = level._id_6A65[var_0].size;
  level._id_6A65[var_0][var_5] = [];
  level._id_6A65[var_0][var_5]["priority"] = var_4;
  level._id_6A65[var_0][var_5]["stateName"] = var_1;
  level._id_6A65[var_0][var_5]["thinkFunc"] = var_2;
  level._id_6A65[var_0][var_5]["changeFunc"] = var_3;
  level._id_6A65[var_0] = ::scripts\engine\utility::array_sort_with_func(level._id_6A65[var_0], ::is_higher_priority);
}

_id_E092(var_0, var_1) {
  if(!isDefined(level._id_6A65[var_0])) {
    return;
  }
  var_2 = [];

  foreach(var_4 in level._id_6A65[var_0]) {
    if(var_4["stateName"] != var_1) {
      var_2[var_2.size] = var_4;
    }
  }

  level._id_6A65[var_0] = var_2;
}

_id_6B15() {
  _id_F8BE();

  if(self.team == "allies" && isDefined(self.name)) {
    scripts\sp\names::_id_7B05();
    self _meth_8307(self.name, &"");
  } else if(self.team == "axis")
    self _meth_8307("enemy", &"");

  if(isDefined(self._id_EE2C)) {
    self.moveplaybackrate = self._id_EE2C;
  } else {
    self.moveplaybackrate = 1;
  }

  if(!isDefined(self._id_EDB7) || !self._id_EDB7) {
    level thread scripts\sp\friendlyfire::_id_73B1(self);
  }

  self _meth_839E();

  if(isDefined(self.target)) {
    var_0 = scripts\engine\utility::getStruct(self.target, "targetname");

    if(isDefined(var_0) && var_0 scripts\sp\fakeactor_node_MAYBE::_id_9BE0()) {
      if(_id_9B69()) {
        _id_1164B(var_0);
      } else {
        _id_F31D(var_0);
      }
    }
  }
}

_id_6B45() {
  waittillframeend;
  thread _id_12E30();
  thread _id_BC42();
  thread _id_13924();
  thread _id_B282();
  thread _id_4E22();
}

_id_B282() {
  self endon("death");
  thread _id_DD7E();
  self waittill("make_real_ai");
  scripts\sp\utility::_id_1101B();
  var_0 = self.weapon;
  var_1 = "";

  if(isDefined(self._id_4B94) && isDefined(self._id_4B94.target)) {
    var_1 = self._id_4B94.target;
  }

  var_2 = _id_0B77::_id_10869(self, var_1);
  var_2 scripts\anim\shared::placeweaponon(var_0, "right");

  if(isDefined(self)) {
    self delete();
  }
}

_id_13949() {
  self endon("death");
  self endon("goal");
  var_0 = squared(128);

  for(;;) {
    if(distancesquared(level.player getorigin(), self.origin) < var_0) {
      _id_C2C9(1);
    } else {
      _id_C2C9(0);
    }

    wait 0.05;
  }
}

_id_DD7E() {
  self endon("death");
  self endon("make_real_ai");

  if(!isDefined(self.radius) || self.radius <= 0) {
    return;
  }
  for(;;) {
    if(distancesquared(level.player getEye(), self.origin) < squared(self.radius)) {
      self notify("make_real_ai");
      return;
    }

    wait 0.05;
  }
}

_id_3DBA() {
  if(_id_9C0B()) {
    return 0;
  }

  return self._id_4B94 scripts\sp\fakeactor_node_MAYBE::_id_6B2B(self);
}

_id_3C4D(var_0) {
  self._id_D8A6 = self.current_state;
  self notify("change_state");
  _id_40C8();
  self.current_state = var_0["stateName"];
  self thread[[var_0["thinkFunc"]]]();
}

_id_174D(var_0) {
  if(!isDefined(self._id_4BBF)) {
    self._id_4BBF = [];
  }

  self._id_4BBF[self._id_4BBF.size] = var_0;
}

_id_40C8() {
  if(isDefined(self._id_4BBF)) {
    foreach(var_1 in self._id_4BBF) {
      if(isDefined(var_1)) {
        var_1 delete();
      }
    }
  }
}

_id_12E30() {
  self endon("death");
  self endon("make_real_ai");
  self._id_D8A6 = "";
  var_0 = "default";

  if(isDefined(self._id_10E1D)) {
    var_0 = self._id_10E1D;
  }

  for(;;) {
    wait 0.05;

    if(_id_9BA1()) {
      continue;
    }
    foreach(var_2 in _id_7CA8(var_0)) {
      if(isDefined(self.current_state) && self.current_state == var_2["stateName"]) {
        continue;
      }
      if([[var_2["changeFunc"]]]()) {
        _id_3C4D(var_2);
        break;
      }
    }
  }
}

_id_92D9() {
  if(!isDefined(self.current_state)) {
    return 1;
  }

  if(self._id_4B94 scripts\sp\fakeactor_node_MAYBE::_id_6B2B(self)) {
    return 1;
  }

  return 0;
}

_id_92EE() {
  self endon("death");
  self endon("change_state");
  _id_6B11();
  self notify("goal");

  while(isDefined(self)) {
    if(isDefined(self._id_92D2)) {
      _id_CE00(_id_7A2A());
      continue;
    }

    childthread _id_6BDE();
    self waittill("start_next_fight");
  }
}

_id_6BDE() {
  self endon("death");
  self endon("change_state");

  if(!isDefined(self.ignoreall)) {
    if(isDefined(self._id_4B94)) {
      var_0 = self._id_4B94 scripts\sp\utility::_id_7A8F();
      var_0 = scripts\engine\utility::array_combine(var_0, self._id_4B94 scripts\sp\utility::_id_7A97());

      if(var_0.size) {
        var_1 = scripts\engine\utility::random(var_0);
        var_2 = (0, 0, 0);

        if(isDefined(var_1.radius)) {
          var_3 = randomfloatrange(var_1.radius * -1, var_1.radius);
          var_4 = randomfloatrange(var_1.radius * -1, var_1.radius);
          var_2 = (var_3, var_4, 0);
        }

        _id_F297(var_1, var_2);
      }
    }

    var_5 = _id_7A04();
    var_6 = _id_77E9();
    var_7 = self.origin;

    if(isDefined(var_5) && isDefined(var_6)) {
      _id_CE00(var_5);
    }

    self notify("start_aim");
    _id_6D53(_id_7C63());
    self notify("end_aim");

    if(isDefined(var_5) && isDefined(var_6)) {
      _id_CE00(var_6);
    }

    if(_id_FF45()) {
      var_8 = _id_7C03();

      if(isDefined(var_8)) {
        _id_CE00(var_8);
      }
    }

    if(scripts\engine\utility::cointoss()) {
      var_9 = self._id_1FD0;
      _id_CB1F();

      if(self._id_1FD0 != var_9) {
        _id_CE00(_id_7C9F());
      }
    }
  }

  _id_CE00(_id_7A2A());
  _id_F613(1);
  self notify("start_next_fight");
}

_id_126D0() {
  if(isDefined(self._id_4B94) && self._id_4B94 scripts\sp\fakeactor_node_MAYBE::_id_6B2B(self) && self._id_4B94 scripts\sp\fakeactor_node_MAYBE::_id_6B32()) {
    return 1;
  }

  return 0;
}

_id_126D9() {
  self endon("death");
  _id_F30A(1);
  var_0 = _id_57D2(self._id_4B94._id_126CD);
  _id_F30A(0);
  _id_F613(1);
}

_id_12944() {
  if(self._id_4B94 scripts\sp\fakeactor_node_MAYBE::_id_6B2B(self) && self._id_4B94 scripts\sp\fakeactor_node_MAYBE::_id_6B33()) {
    return 1;
  }

  return 0;
}

_id_12999() {
  self endon("death");
  _id_F30A(1);
  var_0 = self._id_4B94 scripts\sp\fakeactor_node_MAYBE::_id_6B20();
  _id_CE00(_id_7D21(self.angles, self.origin, var_0.origin));
  _id_F30A(0);
  _id_F613(1);
}

_id_CC86() {
  if(isDefined(self._id_4B94) && self._id_4B94 scripts\sp\fakeactor_node_MAYBE::_id_6B2B(self) && self._id_4B94 scripts\sp\fakeactor_node_MAYBE::_id_6B2A()) {
    if(!isDefined(self._id_4B94._id_A880) || self._id_4B94._id_A880 != self) {
      return 1;
    }
  }

  return 0;
}

_id_CC8A() {
  self endon("death");
  _id_F30A(1);
  self._id_4B94._id_1EEF scripts\sp\anim::_id_1ED1(self, self._id_4B94.animation);
  self._id_4B94._id_A880 = self;
  _id_F30A(0);
  _id_F613(1);
  self notify("played_anim");
}

_id_57D2(var_0) {
  var_1 = _id_7D19(var_0);
  _id_CE00(var_1, undefined, scripts\anim\traverse\shared::_id_89F8, "traverseAnim", self._id_4B94);
}

_id_BC42() {
  self endon("death");
  self endon("make_real_ai");

  for(;;) {
    self waittill("move");
    _id_F613(1);
  }
}

_id_BC1C() {
  if(isDefined(self._id_72A9)) {
    self._id_C039 = self._id_72A9;
    self._id_72A9 = undefined;
    return 1;
  }

  if(!isDefined(self._id_4B94)) {
    return 0;
  }

  var_0 = _id_582B();
  var_1 = undefined;

  if(!isDefined(self.current_state) && isDefined(self._id_4B94)) {
    var_1 = scripts\sp\fakeactor_node_MAYBE::_id_6B21(self._id_4B94, self.origin, _id_9BE8(), var_0);
  }

  if(self._id_4B94 scripts\sp\fakeactor_node_MAYBE::_id_6B2B(self) && !self._id_4B94 scripts\sp\fakeactor_node_MAYBE::_id_6B2D(var_0)) {
    var_2 = self._id_4B94 scripts\sp\fakeactor_node_MAYBE::_id_6B20();
    var_1 = scripts\sp\fakeactor_node_MAYBE::_id_6B21(var_2, self.origin, _id_9BE8(), var_0);
  }

  if(isDefined(var_1)) {
    foreach(var_4 in var_1) {
      if(var_4["dist"] > 0) {
        self._id_C039 = var_1;
        return 1;
      }
    }
  }

  return 0;
}

_id_CDEB() {
  self endon("death");
  self endon("change_state");
  self notify("stop_running_anim");
  self endon("stop_running_anim");
  var_0 = 1;

  if(isDefined(self._id_E812) && isDefined(self._id_E811)) {
    var_0 = randomfloatrange(self._id_E812, self._id_E811);
  }

  for(;;) {
    var_1 = _id_7AFA();
    var_2 = _id_7816(var_1);
    var_3 = var_2._id_E81C;
    var_4 = var_2._id_1F1D;
    play_looping_breath_sound(var_1, var_0);
    wait(getanimlength(var_1));
  }
}

_id_BC82() {
  self endon("death");
  self endon("change_state");
  self notify("exit_node");
  var_0 = self.origin;
  var_1 = _id_582B();

  if(self._id_C039.size == 0) {}

  self._id_4B94 scripts\sp\fakeactor_node_MAYBE::_id_6B36(self);
  var_2 = _id_7AFA();
  var_3 = _id_7816(var_2);
  var_4 = var_3._id_E81C;
  var_5 = var_3._id_1F1D;

  if(!var_5) {
    childthread _id_AEE8(var_4);
  }

  var_6 = self._id_C039[self._id_C039.size - 1];

  if(self._id_C039[0]["total_dist"] < 64) {
    thread _id_CE00(_id_7A2A());
    var_7 = scripts\engine\utility::spawn_script_origin(self.origin, self.angles);
    _id_174D(var_7);
    self linkTo(var_7);
    var_8 = 0.2;
    var_7 moveTo(var_6["origin"], var_8);
    var_7 rotateTo(var_6["angles"], var_8);
    scripts\engine\utility::waittill_notify_or_timeout("death", var_8);
    self unlink();
    var_7 delete();

    if(self._id_4B94 != var_6["node"]) {
      self._id_4B94 = var_6["node"];
    }

    self._id_4B94 scripts\sp\fakeactor_node_MAYBE::_id_6B37(self);
    _id_6B12(self._id_4B94);
    _id_F613(0);
    self notify("arrive_node");
    return;
  }

  var_9 = 0;
  var_10 = undefined;

  if(_id_FF2F()) {
    var_11 = 0;

    foreach(var_13 in self._id_C039) {
      if(var_11) {
        var_10 = var_13["origin"];
        break;
      }

      if(var_13["dist"] > 0) {
        var_11 = 1;
      }
    }

    if(isDefined(var_10)) {
      var_15 = _id_79A4(var_10);
      _id_CE00(var_15);
    }
  }

  var_16 = undefined;
  var_17 = scripts\engine\utility::random(var_6["node"] scripts\sp\fakeactor_node_MAYBE::_id_6B1F());

  if(_id_FF2C() && !var_6["node"] scripts\sp\fakeactor_node_MAYBE::_id_6B32() && !var_6["node"] scripts\sp\fakeactor_node_MAYBE::_id_6B33() && var_6["node"] scripts\sp\fakeactor_node_MAYBE::_id_6B18()) {
    var_18 = self;

    if(isDefined(self._id_C039[self._id_C039.size - 2]["node"])) {
      var_18 = self._id_C039[self._id_C039.size - 2]["node"];
    }

    var_16 = _id_7836(var_6["node"], var_18, var_17);

    if(isDefined(var_16)) {
      var_19 = getmovedelta(var_16, 0, 1);
      var_20 = getangledelta3d(var_16, 0, 1);
      var_21 = invertangles(var_20);
      var_22 = combineangles(var_6["angles"], var_21);
      var_23 = var_6["origin"] - rotatevector(var_19, var_22);
      var_6["anim_node"] = ::scripts\engine\utility::spawn_script_origin(var_23, var_22);
      _id_174D(var_6["anim_node"]);
      var_6["origin"] = var_23;
      var_6["angles"] = var_22;
    }
  }

  thread _id_CDEB();
  thread _id_13949();
  self._id_4B94 = self._id_C039[var_9 + 1]["node"];
  var_24 = 1;

  if(isDefined(self._id_BC68)) {
    var_24 = self._id_BC68;
  }

  for(;;) {
    var_25 = self._id_C039[var_9]["to_next_node"];
    var_26 = self.origin - self._id_C039[var_9]["origin"];
    var_27 = vectordot(var_25, var_26);

    if(var_9 == self._id_C039.size) {
      break;
    }

    var_28 = var_27 + self._id_AFED;

    while(var_28 > self._id_C039[var_9]["dist"]) {
      var_28 = var_28 - self._id_C039[var_9]["dist"];
      var_9++;

      if(var_9 == self._id_C039.size) {
        if(self._id_4B94 != var_6["node"]) {
          self._id_4B94 = var_6["node"];
        }

        var_8 = 0;
        var_29 = (0, 0, 0);
        var_30 = (0, 0, 0);
        var_31 = (0, 0, 0);

        if(_id_9B69()) {
          var_32 = self._id_C039[self._id_C039.size - 1]["origin"] - self.origin;
          var_33 = length(var_32);
          var_30 = anglestoup(self.angles);
          var_29 = vectorNormalize(var_32);
          var_31 = vectorcross(var_29, var_30);
          var_29 = vectorcross(var_30, var_31);

          if(var_33 > 0) {
            var_8 = var_33 / (var_4 * var_24);
          }
        } else {
          var_32 = var_6["origin"] - self.origin;
          var_29 = vectortoangles(var_32);
          var_33 = length(var_32);
          var_8 = var_33 / (var_4 * var_24);
        }

        if(var_8 > 0) {
          if(var_5) {
            self moveTo(var_6["origin"], var_8);

            if(_id_9B69()) {
              self rotateTo(axistoangles(var_29, var_31, var_30), var_8);
            } else {
              self rotateTo(var_29, var_8 * 0.25);
            }

            wait(var_8);
          } else {
            var_7 = scripts\engine\utility::spawn_script_origin(self.origin, self.angles);
            _id_174D(var_7);
            self linkTo(var_7);
            var_7 moveTo(var_6["origin"], var_8);

            if(_id_9B69()) {
              var_7 rotateTo(axistoangles(var_29, var_31, var_30), var_8);
            } else {
              var_7 rotateTo(var_29, var_8 * 0.25);
            }

            scripts\engine\utility::waittill_notify_or_timeout("death", var_8);
            self unlink();
            var_7 delete();
          }
        }

        if(isDefined(var_16)) {
          self notify("stop_running_anim");
          _id_CE00(var_16, undefined, undefined, undefined, var_6["anim_node"], 0);
          var_6["anim_node"] delete();
          _id_F2C3([var_17]);
        } else {
          self.angles = var_6["angles"];
          _id_F2C3(self._id_4B94 scripts\sp\fakeactor_node_MAYBE::_id_6B1F());
        }

        self._id_4B94 scripts\sp\fakeactor_node_MAYBE::_id_6B37(self);
        _id_6B12(self._id_4B94);
        self notify("stop_running_anim");
        _id_F613(0);
        self notify("arrive_node");
        self notify("reached_path_end");
        self notify("goal");
        return;
      } else if(self._id_4B94 != self._id_C039[var_9]["node"]) {
        self._id_4B94 = self._id_C039[var_9]["node"];
        _id_F2C3(self._id_4B94 scripts\sp\fakeactor_node_MAYBE::_id_6B1F());
        _id_6B12(self._id_4B94);
      }
    }

    var_34 = self._id_C039[var_9]["to_next_node"] * var_28;
    var_34 = var_34 + self._id_C039[var_9]["origin"];
    var_35 = var_34;

    if(!var_5) {
      self._id_AFEC = var_35;
    }

    if(_id_9B69()) {
      var_30 = anglestoup(self.angles);
      var_29 = vectorNormalize(var_35 - self.origin);
      var_31 = vectorcross(var_29, var_30);
      var_29 = vectorcross(var_30, var_31);
      self rotateTo(axistoangles(var_29, var_31, var_30), self._id_B04E);
    } else {
      var_22 = vectortoangles(var_35 - self.origin);
      childthread _id_6B40(var_22, self._id_B04E);
    }

    if(var_5) {
      var_36 = var_4 * self._id_B04E * self._id_BC68;
      var_37 = vectorNormalize(var_35 - self.origin);
      var_34 = var_37 * var_36;
      var_34 = var_34 + self.origin;
      self moveTo(var_34, self._id_B04E);
    }

    if(getDvar("debug_fakeactor") == "1") {}

    wait(self._id_B04E);
  }

  self._id_C039 = undefined;
  _id_F613(0);
  self notify("arrive_node");
  self notify("reached_path_end");
  self notify("goal");
}

_id_6B40(var_0, var_1) {
  var_2 = anglesToForward(self.angles);
  var_3 = anglesToForward(var_0);
  var_4 = 0;
  var_5 = 1 / var_1;

  for(;;) {
    var_6 = var_4 * var_5;
    var_7 = vectorlerp(var_2, var_3, var_6);
    self.angles = vectortoangles(var_7);
    var_4 = var_4 + 0.05;
    wait 0.05;

    if(var_4 >= var_1) {
      break;
    }
  }

  self.angles = var_0;
}

_id_6B11() {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.script_noteworthy)) {
    return;
  }
  switch (self.script_noteworthy) {
    case "delete_on_goal":
      if(isDefined(self._id_B14F)) {
        scripts\sp\utility::_id_1101B();
      }

      self delete();
      break;
    case "die_on_goal":
      self _meth_81D0();
      break;
  }
}

_id_6B12(var_0) {
  if(isDefined(var_0.script_noteworthy)) {
    switch (var_0.script_noteworthy) {
      case "delete_on_goal":
        if(isDefined(self._id_B14F)) {
          scripts\sp\utility::_id_1101B();
        }

        self delete();
        break;
      case "die_on_goal":
        self _meth_81D0();
        break;
    }
  }

  if(isDefined(var_0._id_ED9E)) {
    scripts\engine\utility::flag_set(var_0._id_ED9E);
  }

  if(isDefined(var_0._id_ED9B)) {
    scripts\engine\utility::flag_clear(var_0._id_ED9B);
  }

  if(isDefined(var_0._id_ED80)) {
    scripts\sp\utility::_id_65E1(var_0._id_ED80);
  }

  if(isDefined(self._id_ED7F)) {
    scripts\sp\utility::_id_65E1(var_0._id_ED7F);
  }

  if(isDefined(var_0._id_ED56)) {
    if(var_0._id_ED56 == "frantic") {
      _id_F3BE(1);
    }
  }

  if(isDefined(var_0._id_ED60)) {
    _id_F35C(var_0._id_ED60);
  }

  if(isDefined(var_0._id_ED62)) {
    _id_F35D(var_0._id_ED62);
  }

  if(isDefined(var_0._id_ECF9)) {
    _id_F2C6(var_0._id_ECF9);
  }

  if(isDefined(var_0._id_EEFF)) {
    _id_F568(var_0._id_EEFF);
  }

  if(isDefined(var_0._id_EEFE)) {
    _id_F5F9(var_0._id_EEFE);
  }
}

_id_AEE8(var_0) {
  self endon("death");
  self endon("change_state");
  self notify("drone_move_z");
  self endon("drone_move_z");
  var_1 = 0.05;

  for(;;) {
    if(isDefined(self._id_AFEC) && var_0 > 0) {
      if(_id_9B69()) {
        var_2 = anglestoup(self.angles);
        var_3 = scripts\common\trace::ray_trace(self.origin + var_2 * 40, self.origin + var_2 * -40, self, scripts\common\trace::create_solid_ai_contents(1));

        if(var_3["hittype"] != "hittype_none") {
          self.origin = var_3["position"];
        }
      } else {
        var_4 = self._id_AFEC[2] - self.origin[2];
        var_5 = distance2d(self._id_AFEC, self.origin);
        var_6 = var_5 / var_0;

        if(var_6 > 0 && var_4 != 0) {
          var_7 = abs(var_4) / var_6;
          var_8 = var_7 * var_1;

          if(var_4 >= var_7) {
            self.origin = (self.origin[0], self.origin[1], self.origin[2] + var_8);
          } else if(var_4 <= var_7 * -1) {
            self.origin = (self.origin[0], self.origin[1], self.origin[2] - var_8);
          }
        }
      }
    }

    wait(var_1);
  }
}

_id_F31D(var_0) {
  if(isDefined(self._id_4B94)) {
    self._id_4B94 scripts\sp\fakeactor_node_MAYBE::_id_6B36(self);
  }

  self._id_72A9 = undefined;
  self._id_4B94 = var_0;
  _id_F2C3(self._id_4B94 scripts\sp\fakeactor_node_MAYBE::_id_6B1F());
}

_id_1164B(var_0) {
  _id_F31D(var_0);
  self._id_4B94 scripts\sp\fakeactor_node_MAYBE::_id_6B37(self);
  _id_6B12(self._id_4B94);
  self dontinterpolate();
  self.origin = self._id_4B94.origin;
  self.angles = self._id_4B94 scripts\sp\fakeactor_node_MAYBE::_id_6B1E(_id_9BE8());
}

_id_416B() {
  if(isDefined(self._id_C039)) {
    foreach(var_1 in self._id_C039) {
      if(isDefined(var_1["node"])) {
        var_1["node"] scripts\sp\fakeactor_node_MAYBE::_id_6B36(self);
      }
    }
  }
}

_id_FF45() {
  if(self._id_1FD0 == "exposed") {
    return 0;
  }

  if(isDefined(self._id_1A2C)) {
    return _id_9CE3();
  }

  return 1;
}

_id_6D53(var_0) {
  self endon("death");
  childthread _id_1A2E();
  wait 0.25;
  var_1 = weaponclipsize(self.weapon);
  var_2 = weaponfiretime(self.weapon);
  var_3 = weaponburstcount(self.weapon);
  var_4 = weaponclass(self.weapon);
  var_5 = var_1;

  if(var_4 == "sniper") {
    var_5 = 5;
  } else if(var_3 > 0) {
    var_5 = var_3;
  }

  while(var_5 > 0) {
    if(_id_FF45()) {
      var_6 = self gettagorigin("tag_flash");
      var_7 = self gettagangles("tag_flash");
      var_8 = anglesToForward(var_7);
      var_9 = var_6 + var_8 * 1000;

      if(isDefined(self._id_1A2C)) {
        var_10 = scripts\common\trace::ray_trace(var_6, var_9, self);

        if(isDefined(var_10["entity"]) && var_10["entity"] == self._id_1A2C) {
          var_11 = _id_77C8();

          if(randomfloat(1) > var_11) {
            var_12 = self._id_1A2C physics_getcharactercollisioncapsule();
            var_13 = anglestoup(self._id_1A2C.angles);
            var_14 = randomfloatrange(0, var_12["half_height"] * 2);
            var_15 = anglestoright(self._id_1A2C.angles);
            var_16 = var_12["radius"] * randomfloatrange(1, 2);

            if(scripts\engine\utility::cointoss()) {
              var_16 = var_16 * -1;
            }

            var_17 = self._id_1A2C.origin + var_13 * var_14 + var_15 * var_16;
            var_8 = vectorNormalize(var_17 - var_6);
            var_9 = var_6 + var_8 * 1000;
          }
        }
      }

      if(_id_FF81()) {
        magicbullet(self.weapon, var_6, var_9);
      } else {
        _id_6ADC(self.weapon, var_6, var_9, self._id_C01E);
      }

      self _meth_82AB(var_0, 1, 0.2, 1.0);
      scripts\engine\utility::delaycall(0.15, ::clearanim, var_0, 0);
    }

    var_5--;
    wait(max(var_2, 0.1));
  }
}

_id_77C8(var_0) {
  var_1 = self._id_2894;
  var_2 = 1.0;

  if(isDefined(self._id_1A2C) && isDefined(self._id_1A2C.attackeraccuracy)) {
    var_2 = self._id_1A2C.attackeraccuracy;
  }

  var_3 = distance(self.origin, self._id_1A2C.origin);
  var_4 = getaccuracyfraction(self.weapon, var_3, isPlayer(self._id_1A2C));
  var_5 = "stand";

  if(isPlayer(self._id_1A2C)) {
    var_5 = self._id_1A2C getstance();
  } else if(isai(self._id_1A2C)) {
    var_5 = self._id_1A2C.a.pose;
  }

  var_6 = 1;

  if(var_5 == "crouch") {
    var_6 = 0.75;
  } else if(var_5 == "prone") {
    var_6 = 0.5;
  }

  var_7 = 1;

  if(isPlayer(self._id_1A2C)) {
    var_8 = level.player getnormalizedmovement();
    var_7 = 1 - length(var_8) * 0.3;
  } else if(isai(self._id_1A2C)) {}

  var_9 = 0.75;
  var_10 = var_1 * var_2 * var_4 * var_6 * var_7 * var_9;
  return var_10;
}

_id_6ADC(var_0, var_1, var_2, var_3) {
  bullettracer(var_1, var_2, var_0);
  playFXOnTag(scripts\engine\utility::getfx("fakeactor_muzflash"), self, "tag_flash");

  if(!isDefined(var_3) || !var_3) {
    return;
  }
}

_id_7CDD(var_0) {
  if(isPlayer(var_0)) {
    if(_id_9C07()) {
      var_1 = 50;
    } else {
      var_1 = 50;
    }

    var_2 = var_0 getplayerangles();
    var_3 = var_0 getorigin() + anglestoup(var_2) * var_1;
    return var_3;
  } else if(isai(var_0))
    return var_0 gettagorigin("j_SpineUpper");
  else {
    var_3 = var_0.origin;

    if(isDefined(self._id_1A2D)) {
      var_3 = var_3 + self._id_1A2D;
    }

    return var_3;
  }
}

_id_1A2E() {
  self endon("end_aim");
  var_0 = 0.2;
  var_1 = _id_77E7("aim_5");

  if(isDefined(var_1)) {
    self _meth_82A5(var_1, self._id_1EA4["body"], 1, var_0);
  }

  self _meth_82AC(_id_77E7("aim_2"), 1, var_0);
  self _meth_82AC(_id_77E7("aim_4"), 1, var_0);
  self _meth_82AC(_id_77E7("aim_6"), 1, var_0);
  self _meth_82AC(_id_77E7("aim_8"), 1, var_0);
  var_2 = 10;
  var_3 = 0;
  var_4 = 0;
  var_5 = 1;

  while(isDefined(self._id_1A2C)) {
    var_6 = self gettagorigin("tag_flash");
    var_7 = _id_7CDD(self._id_1A2C);
    var_8 = scripts\sp\utility::_id_13DCC(var_7) - scripts\sp\utility::_id_13DCC(var_6);
    var_9 = vectortoangles(var_8);
    var_10 = angleclamp180(var_9[0]);
    var_11 = angleclamp180(var_9[1]);

    if(var_10 < self.upaimlimit || var_10 > self.downaimlimit || var_11 < self.rightaimlimit || var_11 > self.leftaimlimit) {
      _id_F5BF(0);
      var_10 = 0;
      var_11 = 0;
    } else
      _id_F5BF(1);

    if(getDvar("debug_fakeactor") == "1") {
      var_12 = self gettagangles("tag_origin");
      scripts\engine\utility::draw_angles(var_12, self gettagorigin("tag_origin"));
    }

    if(!var_5) {
      var_13 = var_11 - var_3;

      if(abs(var_13) > var_2) {
        var_11 = var_3 + clamp(var_13, -1 * var_2, var_2);
      }

      var_14 = var_10 - var_4;

      if(abs(var_14) > var_2) {
        var_10 = var_4 + clamp(var_14, -1 * var_2, var_2);
      }
    }

    var_10 = clamp(var_10, self.upaimlimit, self.downaimlimit);
    var_11 = clamp(var_11, self.rightaimlimit, self.leftaimlimit);
    var_5 = 0;
    var_3 = var_11;
    var_4 = var_10;
    _id_1A31(self._id_1EA4["aim_2"], self._id_1EA4["aim_4"], self._id_1EA4["aim_6"], self._id_1EA4["aim_8"], var_10, var_11);
    wait 0.05;
  }
}

_id_7821(var_0, var_1, var_2, var_3) {
  var_4 = _func_2EE(var_0, var_1, var_2, var_3);

  if(isDefined(var_4)) {
    if(isarray(var_4.anims)) {
      if(isDefined(var_4._id_039E)) {
        var_5 = randomfloat(1);
        var_6 = 0;

        for(var_7 = 0; var_7 < var_4.anims.size; var_7++) {
          var_6 = var_6 + var_4._id_039E[var_7];

          if(var_6 >= var_5) {
            return var_4.anims[var_7];
          }
        }

        return;
      }

      var_5 = randomint(var_4.anims.size);
      return var_4.anims[var_5];
      return;
      return;
    }

    return var_4.anims;
    return;
  } else {}
}

_id_7820(var_0, var_1) {
  var_2 = _id_7821(self._id_1FA8, var_0, var_1, _id_9BE8());

  if(isarray(var_2)) {
    var_2 = scripts\engine\utility::random(var_2);
  }

  return var_2;
}

_id_7A2A() {
  if(isDefined(self._id_92D2)) {
    return self._id_92D2;
  }

  if(scripts\engine\utility::cointoss()) {
    if(self._id_1FD0 == "exposed") {
      if(self._id_1FA8 == "zero_gravity") {
        return _id_7820("NonCombat_Stand_Idle", "noncombat_stand_idle");
      } else {
        return _id_7820("noncombat_stand_idle", "noncombat_stand_idle");
      }
    } else
      return _id_7820(self._id_1FD0, "hide_loop");
  } else {
    switch (self._id_1FD0) {
      case "cover_right_crouch":
      case "cover_left":
      case "cover_right":
        return _id_7820(self._id_1FD0, "hide_loop");
      case "exposed":
        return _id_7820("noncombat_stand_idle", "noncombat_stand_idle_twitch");
      case "cover_left_crouch":
      case "cover_stand":
      case "cover_crouch":
        return _id_7820(self._id_1FD0 + "_peek", "peek");
    }
  }
}

_id_7AFA() {
  if(isDefined(self._id_E7DA)) {
    return self._id_E7DA;
  }

  return _id_7820("stand_run_loop", "default");
}

_id_7D21(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_2 - var_1);
  var_4 = var_0[1] - var_3[1];
  var_4 = var_4 + 360;
  var_4 = int(var_4) % 360;
  var_5 = "";

  if(var_4 > 315 || var_4 < 45) {
    return undefined;
  } else if(var_4 >= 150 && var_4 <= 210) {
    var_5 = "2";
  } else if(var_4 < 90) {
    var_5 = "9";
  } else if(var_4 > 270) {
    var_5 = "7";
  } else if(var_4 < 135) {
    var_5 = "6";
  } else if(var_4 > 225) {
    var_5 = "4";
  } else if(var_4 < 150) {
    var_5 = "3";
  } else if(var_4 > 210) {
    var_5 = "1";
  }

  return _id_7820("run_turn", "left" + var_5);
}

_id_7C63() {
  switch (self._id_1FD0) {
    case "cover_left_crouch":
    case "cover_right_crouch":
    case "cover_crouch":
      return _id_7820("crouch_shoot_full", "fire");
    case "cover_stand":
    case "cover_left":
    case "cover_right":
      return _id_7820("shoot_full", "fire");
    case "exposed":
      return _id_7820("shoot_full", "fire");
  }
}

_id_77E7(var_0) {
  switch (self._id_1FD0) {
    case "cover_crouch":
      return _id_7820("cover_crouch_aim", "rifle_" + var_0);
    case "cover_left_crouch":
      if(var_0 == "aim_5") {
        return undefined;
      }

      return _id_7820("cover_crouch_exposed_left", "rifle_" + var_0);
    case "cover_right_crouch":
      if(var_0 == "aim_5") {
        return undefined;
      }

      return _id_7820("cover_crouch_exposed_right", "rifle_" + var_0);
    case "cover_stand":
      return _id_7820("cover_stand_exposed", "rifle_" + var_0);
    case "cover_left":
      if(var_0 == "aim_5") {
        return undefined;
      }

      return _id_7820("cover_left_exposed_B", "rifle_" + var_0);
    case "cover_right":
      if(var_0 == "aim_5") {
        return undefined;
      }

      return _id_7820("cover_right_exposed_B", "rifle_" + var_0);
    case "exposed":
      return _id_7820("exposed_idle", "rifle_" + var_0);
  }
}

_id_7A04() {
  switch (self._id_1FD0) {
    case "cover_crouch":
      return _id_7820("cover_crouch_hide_to_aim", "hide_to_aim");
    case "cover_stand":
      return _id_7820("cover_stand_hide_to_exposed", "hide_to_exposed");
    case "cover_left":
      return _id_7820("cover_left_hide_to_B", "hide_to_exposed");
    case "cover_right":
      return _id_7820("cover_right_hide_to_B", "hide_to_exposed");
    case "cover_left_crouch":
      return _id_7820("cover_left_crouch_hide_to_B", "hide_to_B");
    case "cover_right_crouch":
      return _id_7820("cover_right_crouch_hide_to_B", "hide_to_B");
  }

  return undefined;
}

_id_77E9() {
  switch (self._id_1FD0) {
    case "cover_crouch":
      return _id_7820("cover_crouch_aim_to_hide", "aim_to_hide");
    case "cover_stand":
      return _id_7820("cover_stand_exposed_to_hide", "exposed_to_hide");
    case "cover_left":
      return _id_7820("cover_left_B_to_hide", "exposed_to_hide");
    case "cover_right":
      return _id_7820("cover_right_B_to_hide", "exposed_to_hide");
    case "cover_left_crouch":
      return _id_7820("cover_left_crouch_B_to_hide", "B_to_hide");
    case "cover_right_crouch":
      return _id_7820("cover_right_crouch_B_to_hide", "B_to_hide");
  }

  return undefined;
}

_id_7836(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = self._id_1FD0;
  }

  if(!isDefined(var_1)) {
    var_1 = self;
  }

  var_3 = var_2 + "_arrival";
  var_4 = scripts\sp\utility::_id_793C(var_0.angles, var_0.origin, var_1.origin);

  switch (var_2) {
    case "cover_crouch":
      if(var_4 == "9") {
        var_4 = "6";
      } else if(var_4 == "7" || var_4 == "8") {
        var_4 = "4";
      }

      break;
    case "cover_stand":
      if(var_4 == "9") {
        var_4 = "6";
      } else if(var_4 == "7" || var_4 == "8") {
        var_4 = "4";
      }

      break;
    case "cover_left":
      if(var_4 == "9") {
        var_4 = "8";
      }

      break;
    case "cover_right":
      if(var_4 == "7") {
        var_4 = "8";
      }

      break;
    case "cover_left_crouch":
      if(var_4 == "9") {
        var_4 = "8";
      }

      break;
    case "cover_right_crouch":
      if(var_4 == "7") {
        var_4 = "8";
      }

      break;
    case "exposed":
      break;
    default:
      return undefined;
  }

  if(_id_9C07()) {
    var_5 = "left" + var_4;
  } else {
    var_5 = var_4;
  }

  return _id_7820(var_3, var_5);
}

_id_79A4(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = self.origin;
  }

  if(!isDefined(var_2)) {
    var_2 = self.angles;
  }

  if(!isDefined(var_3)) {
    var_3 = self._id_1FD0;
  }

  var_4 = var_3 + "_exit";
  var_5 = scripts\sp\utility::_id_793C(var_2, var_1, var_0);

  switch (var_3) {
    case "cover_crouch":
      if(var_5 == "9") {
        var_5 = "6";
      } else if(var_5 == "7" || var_5 == "8") {
        var_5 = "4";
      }

      return _id_7820(var_4, var_5);
    case "cover_stand":
      if(var_5 == "9") {
        var_5 = "6";
      } else if(var_5 == "7" || var_5 == "8") {
        var_5 = "4";
      }

      return _id_7820(var_4, var_5);
    case "cover_left":
      if(var_5 == "9") {
        var_5 = "8";
      }

      return _id_7820(var_4, var_5);
    case "cover_right":
      if(var_5 == "7") {
        var_5 = "8";
      }

      return _id_7820(var_4, var_5);
    case "cover_left_crouch":
      if(var_5 == "9") {
        var_5 = "8";
      }

      return _id_7820(var_4, var_5);
    case "cover_right_crouch":
      if(var_5 == "7") {
        var_5 = "8";
      }

      return _id_7820(var_4, var_5);
    case "exposed":
      return _id_7820(var_4, var_5);
    default:
      return undefined;
  }
}

_id_7C03() {
  if(self._id_1FD0 == "exposed") {
    return _id_7820("Exposed_Reload", "rifle");
  } else {
    var_0 = self._id_1FD0 + "_reload";
    return _id_7820(var_0, "reload");
  }
}

_id_7C9F() {
  switch (self._id_1FD0) {
    case "cover_crouch":
      return _id_7820("exposed_stand_to_crouch", "stand_to_crouch");
    case "cover_stand":
      return _id_7820("exposed_crouch_to_stand", "crouch_to_stand");
    case "cover_left":
      return _id_7820("cover_left_crouch_to_stand", "crouch_to_stand");
    case "cover_left_crouch":
      return _id_7820("cover_left_stand_to_crouch", "stand_to_crouch");
    case "cover_right":
      return _id_7820("cover_right_crouch_to_stand", "crouch_to_stand");
    case "cover_right_crouch":
      return _id_7820("cover_right_stand_to_crouch", "stand_to_crouch");
  }

  return undefined;
}

_id_7B62() {
  if(_id_9C44()) {
    var_0 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "short", "medium");
    return _id_7820("pain_run_default", var_0);
  } else {
    switch (self._id_1FD0) {
      case "cover_crouch":
        return _id_7820("pain_cover_crouch_default", "crouch");
      case "cover_stand":
        return _id_7820("pain_cover_stand_default", "stand");
      case "cover_left":
        return _id_7820("pain_cover_left_default", "stand");
      case "cover_right":
        return _id_7820("pain_cover_right_default", "stand");
      case "cover_left_crouch":
        return _id_7820("pain_cover_left_default", "crouch");
      case "cover_right_crouch":
        return _id_7820("pain_cover_right_default", "crouch");
      default:
        return _id_7820("pain_stand_torso", "default");
    }
  }
}

_id_7927() {
  if(isDefined(self._id_A8A3) && self._id_A8A3 == "MOD_EXPLOSIVE") {
    var_0 = scripts\engine\utility::random(["explosive_f", "explosive_l", "explosive_r"]);

    if(_id_9C44()) {
      return _id_7820("death_moving_explosive", var_0);
      return;
    }

    return _id_7820("death_explosive", var_0);
    return;
  } else if(_id_9C44()) {
    if(scripts\engine\utility::cointoss()) {
      var_0 = scripts\engine\utility::random(["death_pain_stand_head", "death_pain_stand_l_arm", "death_pain_stand_r_arm", "death_pain_stand_torso"]);
      return _id_7820(var_0, "default");
    } else {
      var_1 = scripts\engine\utility::random(["running_forward_2", "running_forward_4", "running_forward_6", "running_forward_8"]);
      return _id_7820("death_moving_default", var_1);
    }
  } else {
    switch (self._id_1FD0) {
      case "cover_crouch":
        return _id_7820("death_cover_default", "crouch_default");
      case "cover_stand":
        return _id_7820("death_cover_default", "stand");
      case "cover_left":
        return _id_7820("death_cover_default", "left_stand");
      case "cover_right":
        return _id_7820("death_cover_default", "right_stand");
      case "cover_left_crouch":
        return _id_7820("death_cover_default", "left_crouch");
      case "cover_right_crouch":
        return _id_7820("death_cover_default", "right_crouch_default");
      default:
        var_0 = scripts\engine\utility::random(["death_pain_stand_head", "death_pain_stand_l_arm", "death_pain_stand_r_arm", "death_pain_stand_torso"]);
        return _id_7820(var_0, "default");
    }
  }
}

_id_7D19(var_0) {
  if(issubstr(var_0, "jumpdown")) {
    return _id_7820(var_0, "jumpdown");
  } else if(issubstr(var_0, "jumpover")) {
    return _id_7820(var_0, "jumpover");
  } else if(issubstr(var_0, "jumpup")) {
    return _id_7820(var_0, "jumpup");
  } else {
    return _id_7820(var_0, var_0);
  }
}

_id_4E22() {
  self endon("entitydeleted");
  _id_4D23();

  if(!isDefined(self)) {
    return;
  }
  _id_416B();

  if(isDefined(self._id_4E46)) {
    var_0 = self[[self._id_4E46]]();

    if(!isDefined(var_0) || var_0) {
      return;
    }
  }

  var_1 = self._id_4E2A;

  if(!isDefined(var_1)) {
    var_1 = _id_7927();
  }

  self notify("death");
  _id_40C8();
  _id_5D16();
  scripts\anim\face::saygenericdialogue("death");

  if(isDefined(self.noragdoll) && self.noragdoll) {
    if(!isDefined(self._id_10265) || !self._id_10265) {
      _id_CE00(var_1, "deathplant");
    }
  } else if(isDefined(self._id_10265) && self._id_10265)
    self startragdoll();
  else {
    _id_CE00(var_1, "deathplant");
    self startragdoll();
  }

  self notsolid();

  if(isDefined(self) && isDefined(self.nocorpsedelete)) {
    return;
  }
  wait 10;

  while(isDefined(self)) {
    self delete();
    wait 5;
  }
}

_id_5D16() {
  var_0 = getweaponmodel(self.weapon);

  if(isDefined(var_0) && var_0 != "") {
    self detach(var_0, "tag_weapon_right");

    if(!isDefined(self._id_C05C)) {
      var_1 = spawn("weapon_" + self.weapon, self gettagorigin("tag_weapon_right"));
      var_1.angles = self gettagangles("tag_weapon_right");
      _id_ACDC(var_1);
    }
  }
}

_id_ACDC(var_0) {
  if(!isDefined(level._id_6B13)) {
    level._id_6B13 = [];
  }

  var_1 = scripts\engine\utility::array_removeundefined(level._id_6B13);
  var_2 = var_1.size;

  if(var_1.size >= 4) {
    var_1 = sortbydistance(var_1, level.player.origin);
    var_2 = var_2 - 1;
    var_1[var_2] delete();
  }

  var_1[var_2] = var_0;
  level._id_6B13 = var_1;
}

_id_4D23() {
  self endon("entitydeleted");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);
    self._id_A8A3 = var_4;

    if(isDefined(var_1) && isPlayer(var_1)) {
      var_1 setclientomnvar("damage_feedback_notify", gettime());
    }

    if(isDefined(self.damageshield) && self.damageshield) {
      self.health = 100000;
      continue;
    }

    if(self.health <= 0) {
      break;
    }

    scripts\anim\face::saygenericdialogue("pain");

    if(!_id_13903() && _id_FF35()) {
      thread _id_57AD();
    }
  }
}

_id_57AD() {
  self notify("change_state");
  self notify("stop_damage_pain_anim");
  self endon("stop_damage_pain_anim");
  self endon("death");
  _id_F56C(1);
  scripts\engine\utility::delaythread(1.5, ::_id_F56C, 0);
  _id_416B();
  _id_CE00(_id_7B62());
  self.current_state = "";
  self._id_72A9 = scripts\sp\fakeactor_node_MAYBE::_id_6B21(self._id_4B94, self.origin, _id_9BE8(), 1);
}

_id_4EC6() {}

_id_2294(var_0) {
  var_1 = var_0.team;
  scripts\sp\utility::_id_11161(level._id_6B46[var_1], var_0);
  var_0 waittill("death");
  var_0 _id_40C8();

  if(isDefined(var_0) && isDefined(var_0._id_11159)) {
    scripts\sp\utility::_id_11163(level._id_6B46[var_1], var_0._id_11159);
  } else {
    scripts\sp\utility::_id_11164(level._id_6B46[var_1]);
  }
}

play_looping_breath_sound(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(isDefined(self._id_6B17)) {
    self[[self._id_6B17]](var_0, var_1);
  } else {
    self clearanim(self._id_1EA4["body"], 0.2);
    self _meth_83A1();
    self _meth_82E4("fakeactor_anim", var_0, self._id_1EA4["body"], 1, 0.2, var_1);
  }
}

_id_CE00(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(self._id_6B41)) {
    self[[self._id_6B41]](var_0, var_1);
  } else {
    self clearanim(self._id_1EA4["body"], 0.2);
    self _meth_83A1();
    var_6 = "normal";

    if(isDefined(var_1)) {
      var_6 = "deathplant";
    }

    var_7 = self.origin;
    var_8 = self.angles;

    if(isDefined(var_4)) {
      var_7 = var_4.origin;
      var_8 = var_4.angles;
    }

    if(!isDefined(var_5)) {
      var_5 = 0.2;
    }

    self animScripted("fakeactor_anim", var_7, var_8, var_0, var_6);

    if(isDefined(var_2)) {
      thread scripts\anim\shared::donotetracks(var_3, var_2);
    }

    var_9 = "end";

    if(animhasnotetrack(var_0, "finish")) {
      var_9 = "finish";
    } else if(animhasnotetrack(var_0, "stop anim")) {
      var_9 = "stop anim";
    }

    var_10 = getanimlength(var_0) - var_5;

    if(var_5 > 0 && var_10 > 0) {
      scripts\sp\utility::_id_137A3("fakeactor_anim", var_9, var_10);
    } else {
      self waittillmatch("fakeactor_anim", var_9);
    }
  }
}

_id_7816(var_0) {
  var_1 = spawnStruct();
  var_1._id_1F5A = getanimlength(var_0);
  var_2 = getmovedelta(var_0, 0, 1);
  var_3 = length(var_2);

  if(var_1._id_1F5A > 0 && var_3 > 0) {
    var_1._id_E81C = var_3 / var_1._id_1F5A;
    var_1._id_1F1D = 0;
  } else {
    var_1._id_E81C = 170;
    var_1._id_1F1D = 1;
  }

  return var_1;
}

_id_F297(var_0, var_1) {
  self._id_1A2C = var_0;
  self._id_1A2D = var_1;
}

_id_77E8() {
  return self._id_1A2C;
}

_id_13924() {
  self endon("death");

  for(;;) {
    if(isai(self._id_1A2C) && !isalive(self._id_1A2C)) {
      _id_F297(undefined);
    }

    wait 0.05;
  }
}

_id_9C07() {
  return self.unittype == "C6i" || self.unittype == "soldier" || self.unittype == "civilian";
}

_id_F8BE() {
  scripts\sp\utility::_id_23B9();

  switch (self.unittype) {
    case "C6":
      _id_F8EE();
      break;
    case "C8":
      _id_F8F1();
      break;
    case "C6i":
    case "soldier":
    case "civilian":
      _id_F98E();
      break;
    case "C12":
      break;
    default:
      break;
  }
}

#using_animtree("generic_human");

_id_F98E() {
  self._id_1EA4["root"] = % root;
  self._id_1EA4["body"] = % body;
  self._id_1EA4["aim_2"] = % aim_2;
  self._id_1EA4["aim_4"] = % aim_4;
  self._id_1EA4["aim_6"] = % aim_6;
  self._id_1EA4["aim_8"] = % aim_8;
}

#using_animtree("c6");

_id_F8EE() {
  self._id_1EA4["root"] = % root;
  self._id_1EA4["body"] = % body;
  self._id_1EA4["aim_2"] = % aim_2;
  self._id_1EA4["aim_4"] = % aim_4;
  self._id_1EA4["aim_6"] = % aim_6;
  self._id_1EA4["aim_8"] = % aim_8;
}

#using_animtree("c8");

_id_F8F1() {
  self._id_1EA4["root"] = % root;
  self._id_1EA4["body"] = % body;
  self._id_1EA4["aim_2"] = % aim_2;
  self._id_1EA4["aim_4"] = % aim_4;
  self._id_1EA4["aim_6"] = % aim_6;
  self._id_1EA4["aim_8"] = % aim_8;
}

_id_1A31(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0.1;
  var_7 = 1;

  if(var_5 < 0) {
    var_8 = var_5 / self.rightaimlimit * var_7;
    self _meth_82AC(var_1, 0, var_6, 1, 1);
    self _meth_82AC(var_2, var_8, var_6, 1, 1);
  } else if(var_5 > 0) {
    var_8 = var_5 / self.leftaimlimit * var_7;
    self _meth_82AC(var_1, var_8, var_6, 1, 1);
    self _meth_82AC(var_2, 0, var_6, 1, 1);
  }

  if(var_4 < 0) {
    var_8 = var_4 / self.upaimlimit * var_7;
    self _meth_82AC(var_0, 0, var_6, 1, 1);
    self _meth_82AC(var_3, var_8, var_6, 1, 1);
  } else if(var_4 > 0) {
    var_8 = var_4 / self.downaimlimit * var_7;
    self _meth_82AC(var_0, var_8, var_6, 1, 1);
    self _meth_82AC(var_3, 0, var_6, 1, 1);
  }
}

_id_F2C3(var_0) {
  self._id_1FD1 = var_0;
  _id_CB1F();
}

_id_CB1F() {
  var_0 = randomint(self._id_1FD1.size);
  self._id_1FD0 = self._id_1FD1[var_0];
}

_id_F584(var_0) {
  self._id_E7DA = var_0;
}

_id_417B() {
  self._id_E7DA = undefined;
}

_id_F40F(var_0) {
  self._id_92D2 = var_0;
}

_id_415E() {
  self._id_92D2 = undefined;
}

_id_9C08() {
  return self.current_state == "idle";
}

_id_9C44() {
  return self.current_state == "move";
}

_id_9BA1() {
  return self.flags & 256;
}

_id_F30A(var_0) {
  if(var_0) {
    self.flags = self.flags | 256;
  } else {
    self.flags = self.flags &~256;
  }
}

_id_1142F() {
  self notify("change_state");
  self._id_D88C = self._id_4B94;
  _id_416B();
  self._id_C039 = undefined;
  _id_F30A(1);
}

_id_DF38(var_0) {
  _id_F30A(0);

  if(isDefined(var_0)) {
    _id_F31D(var_0);
    _id_F613(1);
  } else if(isDefined(self._id_D88C)) {
    _id_F31D(self._id_D88C);
    _id_F613(1);
    self._id_D88C = undefined;
  }

  self.current_state = undefined;
}

_id_F35C(var_0) {
  if(var_0) {
    self.flags = self.flags | 8;
  } else {
    self.flags = self.flags &~8;
  }
}

_id_FF2C() {
  return self.flags & 8;
}

_id_F35D(var_0) {
  if(var_0) {
    self.flags = self.flags | 16;
  } else {
    self.flags = self.flags &~16;
  }
}

_id_FF2F() {
  if(isDefined(self._id_D8A6)) {
    if(self._id_D8A6 == "traverse" || self._id_D8A6 == "turn") {
      return 0;
    }
  }

  return self.flags & 16;
}

_id_F2C6(var_0) {
  if(var_0) {
    self.flags = self.flags | 4;
  } else {
    self.flags = self.flags &~4;
  }
}

_id_9B69() {
  return self.flags & 4;
}

_id_F613(var_0) {
  if(var_0) {
    self.flags = self.flags | 2;
  } else {
    self.flags = self.flags &~2;
  }
}

_id_582B() {
  return self.flags & 2;
}

_id_F5BF(var_0) {
  if(var_0) {
    self.flags = self.flags | 1;
  } else {
    self.flags = self.flags &~1;
  }
}

_id_9CE3() {
  return self.flags & 1;
}

_id_F568(var_0) {
  if(var_0) {
    self.flags = self.flags | 32;
  } else {
    self.flags = self.flags &~32;
  }
}

_id_FF81() {
  return self.flags & 32;
}

_id_F410(var_0) {
  if(var_0) {
    self.flags = self.flags | 64;
  } else {
    self.flags = self.flags &~64;
  }
}

_id_9C0B() {
  return self.flags & 64;
}

_id_C2C9(var_0) {
  if(var_0) {
    self.flags = self.flags | 128;
  } else {
    self.flags = self.flags &~128;
  }
}

_id_9C53() {
  return self.flags & 128;
}

_id_FF35() {
  return self.flags & 512;
}

_id_F5F9(var_0) {
  if(var_0) {
    self.flags = self.flags | 512;
  } else {
    self.flags = self.flags &~512;
  }
}

_id_13903() {
  return self.flags & 2048;
}

_id_F56C(var_0) {
  if(var_0) {
    self.flags = self.flags | 2048;
  } else {
    self.flags = self.flags &~2048;
  }
}

_id_9BE8() {
  return self.flags & 1024;
}

_id_F3BE(var_0) {
  if(var_0) {
    self.flags = self.flags | 1024;
  } else {
    self.flags = self.flags &~1024;
  }
}

_id_12735(var_0) {
  if(!isDefined(self.targetname)) {
    return;
  }
  var_1 = getEnt("target", self.targetname);

  for(;;) {
    var_0 waittill("trigger", var_2);
    var_1 _id_F613(1);
  }
}

_id_12736(var_0) {
  if(!isDefined(var_0.targetname)) {
    return;
  }
  var_1 = scripts\engine\utility::getStructArray(var_0.targetname, "target");

  if(var_1.size == 0) {
    return;
  }
  for(;;) {
    var_0 waittill("trigger", var_2);

    foreach(var_4 in var_1) {
      var_4 scripts\sp\fakeactor_node_MAYBE::_id_6B38(1);
    }
  }
}

_id_12738(var_0) {
  if(!isDefined(var_0.targetname)) {
    return;
  }
  var_1 = scripts\engine\utility::getStructArray(var_0.targetname, "target");

  if(var_1.size == 0) {
    return;
  }
  for(;;) {
    var_0 waittill("trigger", var_2);

    foreach(var_4 in var_1) {
      var_4 scripts\sp\fakeactor_node_MAYBE::_id_6B38(0);
    }
  }
}

_id_12739(var_0) {
  if(!isDefined(var_0.script_parameters)) {
    return;
  }
  for(;;) {
    var_0 waittill("trigger", var_1);
    scripts\sp\fakeactor_node_MAYBE::_id_6B24(var_0.script_parameters, 0);
  }
}

_id_12737(var_0) {
  if(!isDefined(var_0.script_parameters)) {
    return;
  }
  for(;;) {
    var_0 waittill("trigger", var_1);
    scripts\sp\fakeactor_node_MAYBE::_id_6B24(var_0.script_parameters, 1);
  }
}

_id_1273B(var_0) {
  if(!isDefined(var_0.targetname)) {
    return;
  }
  var_1 = scripts\engine\utility::getStructArray(var_0.targetname, "target");

  if(var_1.size == 0) {
    return;
  }
  for(;;) {
    var_0 waittill("trigger", var_2);

    foreach(var_4 in var_1) {
      var_4 scripts\sp\fakeactor_node_MAYBE::_id_6B3A();
    }
  }
}

_id_1273A(var_0) {
  if(!isDefined(var_0.targetname)) {
    return;
  }
  var_1 = scripts\engine\utility::getStructArray(var_0.targetname, "target");

  if(var_1.size == 0) {
    return;
  }
  for(;;) {
    var_0 waittill("trigger", var_2);

    foreach(var_4 in var_1) {
      var_4 scripts\sp\fakeactor_node_MAYBE::_id_6B39();
    }
  }
}

is_higher_priority(var_0, var_1) {
  return var_0["priority"] < var_1["priority"];
}