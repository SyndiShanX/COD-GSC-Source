/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1353.gsc
**************************************/

init() {
  level._id_609C = 50;
  level._id_AAF0 = [];
  level._id_AAEF = [];

  if(!isDefined(level._id_0C11))
    level._id_0C11 = 1;

  level._id_AAF0["boards"] = ::_id_4F8F;
  level._id_AAEF["boards"] = ::_id_4F8E;
  level._id_AAF0["drop_gate"] = ::_id_4F91;
  level._id_AAEF["drop_gate"] = ::_id_4F90;
  level._id_AAF1 = [];
  level._id_AAF1["drop_gate"] = ::_id_345C;
  level._id_AAF2 = [];
  level._id_AAF2["drop_gate"] = ::_id_345D;
  level._id_AA29 = getEntArray("zbarrier_window", "script_noteworthy");

  foreach(var_1 in level._id_AA29)
  var_1 thread _id_5288();

  level._id_346F = common_scripts\utility::_id_46B7("drop_gate", "script_noteworthy");

  foreach(var_4 in level._id_346F)
  var_4 thread _id_51C5();
}

_id_51C6() {
  level._id_3462 = [];
  level._id_3462[0] = "closed";
  level._id_3462[1] = "o1";
  level._id_3462[2] = "o2";
  level._id_3462[3] = "open";
  level._id_3455 = [];
  setdvarifuninitialized("drop_gate_debug", 0);
  level._id_3464 = [];
  level._id_3464[0] = 0;
  level._id_3464[1] = 1;
  level._id_3464[2] = 2;
  level._id_3464[3] = 3;
}

_id_15CF() {
  self._id_17E9 = 1;

  foreach(var_1 in self._id_9D06) {
    _func_329(var_1, 1);
    var_1 notify("barricaded");
  }
}

_id_15DA() {
  self._id_17E9 = 0;

  foreach(var_1 in self._id_9D06)
  _func_329(var_1, 0);
}

_id_15D1() {
  self._id_17EC++;

  if(self._id_17EC == 1)
    _id_15CF();
}

_id_15D0() {
  self._id_17EC--;

  if(self._id_17EC == 0)
    _id_15DA();
}

_id_15DB(var_0) {
  if(common_scripts\utility::_id_562E(self._id_2FAE) && common_scripts\utility::_id_562E(var_0._id_2FDA))
    return undefined;

  if(self._id_1178.size < 1)
    return undefined;

  self._id_1178 = common_scripts\utility::array_randomize(self._id_1178);
  var_1 = self._id_1178[self._id_1178.size - 1];
  self._id_1178[self._id_1178.size - 1] = undefined;
  self._id_1177 = common_scripts\utility::_id_0F6F(self._id_1177, var_1);
  var_0._id_2308 = var_1;
  var_1._id_0117 = var_0;
  var_2 = level._id_AAF1[self._id_15D9];

  if(isDefined(var_2))
    self thread[[var_2]](var_0, var_1);

  return var_1;
}

_id_15DF(var_0) {
  self._id_1178[self._id_1178.size] = var_0._id_2308;
  self._id_1177 = common_scripts\utility::_id_0F93(self._id_1177, var_0._id_2308);
  var_1 = var_0._id_2308;
  var_0._id_2308._id_0117 = undefined;
  var_0._id_2308 = undefined;
  var_2 = level._id_AAF2[self._id_15D9];

  if(isDefined(var_2))
    self thread[[var_2]](var_0, var_1);
}

_id_15DE() {
  return common_scripts\utility::random(self._id_1176)._id_A6E6;
}

_id_42E9() {
  var_0 = common_scripts\utility::array_randomize(self._id_188E);

  foreach(var_2 in var_0) {
    if(!isDefined(var_2._id_0117) && var_2._id_188A == 2)
      return var_2;
  }

  return undefined;
}

_id_42E4() {
  var_0 = common_scripts\utility::array_randomize(self._id_1890);

  foreach(var_2 in var_0) {
    if(var_2._id_188A == 0)
      return var_2;
  }

  return undefined;
}

_id_15DC(var_0) {
  var_1 = _id_42E9();

  if(!isDefined(var_1))
    return undefined;

  var_1._id_0117 = var_0;
  var_0._id_2309 = var_1;
  return var_1;
}

_id_15E0(var_0) {
  var_0._id_2309._id_0117 = undefined;
  var_0._id_2309 = undefined;
}

_id_15D3(var_0) {
  _id_15D8(var_0);
  _id_15D0();
  wait 1.13;
  _id_15D7(var_0);

  if(self._id_1890.size == 1)
    common_scripts\utility::_id_9DA3();
}

_id_15D8(var_0) {
  var_1 = self._id_188D[var_0];
  var_1._id_188A = 3;
  self.issighted setscriptablepartstate(_id_1889(var_1), "opening");
}

_id_15D7(var_0, var_1) {
  var_2 = self._id_188D[var_0];
  self._id_1890[self._id_1890.size] = var_2;

  if(!common_scripts\utility::_id_562E(var_1))
    self._id_188E = common_scripts\utility::_id_0F93(self._id_188E, var_2);

  var_2._id_188A = 0;
  self.issighted setscriptablepartstate(_id_1889(var_2), "open");
}

_id_15D4(var_0) {
  if(self._id_1890.size == 1)
    common_scripts\utility::_id_9D9F();

  _id_15D6(var_0);
  _id_15D1();
  wait 1.13;
  _id_15D5(var_0);
}

_id_15D6(var_0) {
  var_1 = self._id_188D[var_0];
  self._id_1890 = common_scripts\utility::_id_0F93(self._id_1890, var_1);
  var_1._id_188A = 1;
  self.issighted setscriptablepartstate(_id_1889(var_1), "closing");
}

_id_1889(var_0) {
  return "board" + (var_0._id_1887 + 1);
}

_id_15D5(var_0, var_1) {
  var_2 = self._id_188D[var_0];
  self._id_188E[self._id_188E.size] = var_2;
  var_2._id_188A = 2;
  self.issighted setscriptablepartstate(_id_1889(var_2), "closed");
}

_id_4F8F(var_0) {
  var_1 = _id_053C::_id_4F89();

  if(isDefined(var_1)) {
    thread _id_053C::_id_4F83(var_1);
    return 1;
  }

  var_2 = var_0 _id_15DC(self);

  if(isDefined(var_2)) {
    thread _id_053C::_id_4F99(var_0, var_2);
    return 1;
  }

  return 0;
}

_id_4F8E(var_0) {
  self notify("board_pull_interrupted");

  if(isDefined(self._id_15D2)) {
    if(self._id_15D2 == "pulling_board") {
      var_0 _id_15E0(self);
      self._id_15D2 = undefined;

      if(isalive(self)) {
        self scragentsetscripted(0);
        self scragentsetphysicsmode("gravity");
      }
    } else if(self._id_15D2 == "attacking_through_boards")
      self._id_15D2 = undefined;
    else {}
  }
}

_id_15DD(var_0) {
  var_1 = 3600;

  foreach(var_3 in level.players) {
    if(maps\mp\_utility::isreallyalive(var_3) && distancesquared(var_0.origin, var_3.origin) < var_1)
      return var_3;
  }

  var_5 = 500.0;

  if(isDefined(self._id_5B42) && gettime() - self._id_5B42 < var_5)
    return self._id_5B41;

  return undefined;
}

_id_51C5() {
  self._id_2F0F = [];
  self._id_9D06 = [];
  self._id_15D9 = "drop_gate";
  self._id_3FFE = undefined;
  self._id_17EB = undefined;
  self.getweaponlistall = undefined;
  self.getviewkickscale = undefined;
  self._id_9553 = [];
  var_0 = common_scripts\utility::_id_41EE();
  var_1 = common_scripts\utility::_id_46B7(self.target, "targetname");
  var_2 = getEntArray(self.target, "targetname");
  var_3 = common_scripts\utility::_id_41ED();

  foreach(var_5 in var_2) {
    switch (var_5.classname) {
      case "script_model":
        if(isDefined(var_5._id_0165) && var_5._id_0165 == "gate_model")
          self._id_3FFE = var_5;
      case "trigger_use_touch":
        if(isDefined(var_5._id_0165) && var_5._id_0165 == "gate_trigger")
          self._id_2F0F[self._id_2F0F.size] = var_5;

        break;
      case "script_brushmodel":
        if(isDefined(var_5._id_0165) && var_5._id_0165 == "gate_blocking_clip")
          self._id_17EB = var_5;

        break;
      case "script_origin":
        if(isDefined(var_5._id_0165)) {
          switch (var_5._id_0165) {
            case "scripted_node":
              self.getweaponlistall = var_5.origin;
              self.getviewkickscale = var_5.angles;
              break;
            default:
              break;
          }
        }

        break;
      default:
        break;
    }
  }

  foreach(var_5 in var_3) {
    switch (var_5.classname) {
      case "script_model":
        if(isDefined(var_5._id_0165) && var_5._id_0165 == "drop_gate_switch")
          self._id_9553[self._id_9553.size] = var_5;
    }
  }

  foreach(var_10 in self._id_2F0F) {
    var_10._id_15CC = self;
    var_10._id_15D9 = "drop_gate";
    var_10._id_17D8 = 0;
    var_10._id_7E4A = isDefined(var_10.setmovespeedscale) && var_10.setmovespeedscale == 1;
    var_10.getweaponlistall = self.getweaponlistall;
    var_10.getviewkickscale = self.getviewkickscale;

    if(var_10._id_7E4A)
      var_10.getviewkickscale = _combineangles(var_10.getviewkickscale, (0, 180, 0));

    var_11 = common_scripts\utility::_id_44BE(var_10.target, "targetname");
    var_12 = _getnodearray(var_10.target, "targetname");
    var_10 _id_5289(var_11);

    foreach(var_14 in var_10._id_1176) {
      var_14._id_92DE = var_14.origin;
      var_14._id_92DC = var_14.angles;
    }

    var_10._id_9D06 = var_12;
    self._id_9D06[self._id_9D06.size] = var_10._id_9D03;
    var_10._id_9D06[0]._id_15CB = var_10;
    _func_329(var_10._id_9D06[0], 1);
    var_10 thread _id_3468();
  }

  thread _id_3466();
}

_id_3466() {
  self._id_4C0F = 3;
  self._id_4C11 = 0;
  self._id_4C15 = 1;
  self._id_6C05 = 0;
  self._id_931A = 3;
  self._id_5CCB = 0;
  self._id_5CCC = 0;
  self._id_5CCD = undefined;
  thread common_scripts\utility::_id_2CB4(3, ::_id_3469);

  for(;;) {
    switch (self._id_931A) {
      case 3:
        self notify("gate_open");
        self._id_5CCB = 0;
        self._id_4C11 = 0;
        _id_7127("s2_zom_gate_lift_drop_open_idle_gate", 0);
        _id_3469();
        self waittill("gate_purchase");
        thread _id_3461(0);
        thread _id_3460(1);
        _id_3456();
        _id_0378::_id_8D74("drop_gate", "drop", self.getweaponlistall);
        _id_7127("s2_zom_gate_lift_drop_gate", 1);
        _id_84AE(0);
        break;
      case 0:
        self._id_4C11 = self._id_4C11 + self._id_4C0F;
        _id_3457();
        _id_7127("s2_zom_gate_lift_mount_idle_gate", 0);
        thread _id_3467();
        self waittill("pull_state_change");
        self._id_5CCB = 1;
        _id_0378::_id_8D74("drop_gate", "pos1", self.getweaponlistall);
        thread _id_3458();
        _id_7127("s2_zom_gate_lift_position_1_gate", 1);
        _id_84AE(1);
        break;
      case 1:
        self._id_5CCB = 0;
        self._id_4C11 = self._id_4C11 + self._id_4C0F;
        _id_346A();
        _id_7127("s2_zom_gate_lift_position_1_idle_gate", 0);
        thread _id_3467();
        self waittill("pull_state_change");
        self._id_5CCB = 1;
        _id_0378::_id_8D74("drop_gate", "pos2", self.getweaponlistall);
        thread _id_3458();
        _id_7127("s2_zom_gate_lift_position_2_gate", 1);
        _id_84AE(2);
        break;
      case 2:
        self._id_5CCB = 0;
        self._id_4C11 = self._id_4C11 + self._id_4C0F;
        _id_7127("s2_zom_gate_lift_position_2_idle_gate", 0);
        thread _id_3467();
        self waittill("pull_state_change");
        self._id_5CCB = 1;
        _id_0378::_id_8D74("drop_gate", "pos3", self.getweaponlistall);
        thread _id_3458();
        _id_7127("s2_zom_gate_lift_position_3_gate", 1, ::_id_3FFF);
        _id_84AE(3);
        wait 5;
        thread _id_3461(1);
        thread _id_3460(0);
        break;
    }
  }
}

_id_3460(var_0) {
  if(var_0 && !common_scripts\utility::_id_562E(self._id_9554)) {
    foreach(var_2 in self._id_9553)
    var_2 thread _id_3465();

    self._id_9554 = 1;
  } else if(!var_0) {
    foreach(var_2 in self._id_9553)
    var_2 scriptmodelplayanim("s2_gj_zom_drop_gate_lever_up_idle");

    self._id_9554 = 0;
  }
}

_id_3461(var_0) {
  foreach(var_2 in self._id_2F0F) {
    if(var_0) {
      var_2 common_scripts\utility::_id_9DA3();
      continue;
    }

    var_2 common_scripts\utility::_id_9D9F();
  }
}

_id_3465() {
  self scriptmodelplayanim("s2_gj_zom_drop_gate_lever_move_down");
  wait 1;
  self scriptmodelplayanim("s2_gj_zom_drop_gate_lever_down_idle");
}

_id_3458() {
  self._id_5CCC = 1;
  waitframe();
  self._id_5CCC = 0;
}

_id_3457() {
  self._id_2FAE = 1;

  foreach(var_1 in self._id_2F0F)
  var_1._id_2FAE = 1;
}

_id_346A() {
  self._id_2FAE = undefined;

  foreach(var_1 in self._id_2F0F)
  var_1._id_2FAE = undefined;
}

_id_3FFF() {
  self endon("gate_state_changed");

  for(;;) {
    self._id_3FFE waittill("drop_gate", var_0);

    if(var_0 == "unblock")
      _id_3469();
  }
}

_id_7127(var_0, var_1, var_2) {
  var_3 = level._id_3455[var_0];
  self notify("notetrack_timeout");

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = _getanimlength(var_3);
  var_5 = _animhasnotetrack(var_3, "unblock");
  self._id_3FFE scriptmodelplayanimdeltamotionfrompos(var_0, self.getweaponlistall, self.getviewkickscale, "drop_gate");

  if(isDefined(var_2))
    thread _id_4A2C(var_2, var_4);

  if(var_1)
    wait(var_4);
}

_id_4A2C(var_0, var_1) {
  self endon("notetrack_timeout");
  thread common_scripts\utility::_id_67EC(var_1, "notetrack_timeout");
  [[var_0]]();
}

_id_84AE(var_0) {
  self notify("gate_state_changed");
  self._id_931A = var_0;
}

_id_A1E0(var_0) {
  var_1 = self._id_3FFE.origin;
  self._id_3FFE.origin = (var_1[0], var_1[1], var_0.origin[2]);
}

_id_3456() {
  self._id_17EB solid();
  self._id_17EB show();
  self._id_17EB disconnectpaths();
  self._id_17E9 = 1;

  foreach(var_1 in self._id_2F0F) {
    var_1._id_17E9 = 1;

    foreach(var_3 in var_1._id_9D06)
    _func_32B(var_3, 1);
  }
}

_id_3469() {
  self._id_17EB notsolid();
  self._id_17EB hide();
  self._id_17EB connectpaths();
  self._id_17E9 = 0;

  foreach(var_1 in self._id_2F0F) {
    var_1._id_17E9 = 0;

    foreach(var_3 in var_1._id_9D06)
    _func_32B(var_3, 0);
  }
}

_id_4F91(var_0) {
  var_1 = var_0._id_15CC;

  if(common_scripts\utility::_id_562E(self._id_2FDA)) {
    thread _id_053C::_id_4F86(var_0);
    return 1;
  } else if(var_1 _id_3459()) {
    thread _id_053C::_id_4F92(var_0);
    return 1;
  }

  return 0;
}

_id_4F90(var_0) {
  self notify("drop_gate_interact_interrupt");

  if(isDefined(self._id_15D2) && isalive(self)) {
    if(isDefined(self._id_92C9))
      _id_346D();

    self._id_15D2 = undefined;
    self scragentsetscripted(0);
    self scragentsetphysicsmode("gravity");
  }
}

_id_345A() {
  self notify("adjust_speed");
  self._id_6C05 = 0;
  self._id_6C06 = gettime();
  self._id_4C09 = 0;
}

_id_3454(var_0) {
  self._id_6C05 = self._id_6C05 + var_0;
  thread _id_346B();
}

_id_346B() {
  self notify("update_struggle_sound");
  self endon("update_struggle_sound");
  waittillframeend;
  var_0 = 0.15;

  if(isDefined(self._id_5B26)) {
    var_1 = self._id_5B26 + var_0 * 1000 - gettime();

    if(var_1 > 0)
      wait(var_1 / 1000);
  }

  var_2 = 0;
  var_3 = self._id_6C05;

  if(!isDefined(var_3))
    var_3 = 0;

  for(var_4 = level._id_3464.size - 1; var_4 > -1; var_4--) {
    if(var_3 >= level._id_3464[var_4]) {
      var_2 = var_4;
      break;
    }
  }

  _id_0378::_id_8D74("drop_gate_pull_level", self.getweaponlistall, var_2);
  self._id_5B26 = gettime();
}

_id_3467() {
  self endon("gate_state_changed");
  self endon("pull_state_change");
  var_0 = 0;
  var_1 = 0.05;

  for(;;) {
    var_0 = var_0 + self._id_6C05 * var_1;

    if(var_0 > 1) {
      var_0 = var_0 - 1;
      _id_345E(1);
    }

    wait(var_1);
  }
}

_id_346E(var_0) {
  self._id_92C9 = 1;
  var_0 _id_3454(var_0._id_4C15);
  var_0 endon("gate_open");
  common_scripts\utility::_id_A70A("drop_gate_interact_interrupt", "stop_gate_pull");
  var_0 _id_3454(0 - var_0._id_4C15);
}

_id_346D(var_0) {
  self._id_92C9 = undefined;
  self notify("stop_gate_pull");
}

_id_345E(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  self._id_4C11 = self._id_4C11 - var_0;

  if(self._id_4C11 <= 0)
    self notify("pull_state_change");
}

_id_3459() {
  return self._id_931A != 3;
}

_id_3463() {
  return self._id_931A == 0;
}

_id_345B(var_0, var_1) {
  var_2 = level._id_3462[self._id_931A];

  if(var_1 == "mount")
    var_2 = level._id_3462[0];

  return "lift_gate_" + var_1 + "_" + var_0._id_2308._id_0EA5 + "_" + var_2;
}

_id_345C(var_0, var_1) {
  var_2 = self._id_15CC;
  var_3 = var_2 _id_345B(var_0, "mount");
  var_4 = var_0 maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_3);
  var_5 = var_0 getanimentry(var_4, 0);
  var_1.origin = _getstartorigin(self.getweaponlistall, self.getviewkickscale, var_5);
  var_1.angles = _getstartangles(self.getweaponlistall, self.getviewkickscale, var_5);

  if(getdvarint("drop_gate_debug", 0) != 0)
    return;
}

_id_345D(var_0, var_1) {
  var_1.origin = var_1._id_92DE;
  var_1.angles = var_1._id_92DC;
}

_id_5288() {
  self._id_38EB = undefined;
  self._id_188D = [];
  self._id_1890 = [];
  self._id_188E = [];
  self._id_17EC = 0;
  self._id_17E9 = 0;
  self._id_6044 = 6;
  self._id_7D0A = 1;
  self._id_9D06 = [];
  self._id_15D9 = "boards";
  var_0 = common_scripts\utility::_id_44BE(self.target, "targetname");
  var_1 = common_scripts\utility::_id_41EE();
  var_2 = common_scripts\utility::_id_41F0();
  _id_5289(var_0);
  var_3 = _getscriptablearray(self.target, "targetname");
  self.issighted = var_3[0];

  for(var_4 = 0; var_4 < 6; var_4++) {
    var_5 = spawnStruct();
    self._id_188D[var_4] = var_5;
    var_5._id_1887 = var_4;
  }

  self._id_188F = self._id_188D;

  foreach(var_7 in var_0) {
    if(isDefined(var_7._id_0165)) {
      switch (var_7._id_0165) {
        case "exit_point":
          self._id_38EB = var_7;
          break;
      }
    }
  }

  var_9 = [];

  if(isDefined(self._id_0164)) {
    foreach(var_11 in var_1) {
      if(_id_553A(var_11))
        var_9[var_9.size] = var_11;
    }
  } else if(isDefined(self._id_38EB)) {
    var_13 = 60;
    var_14 = 20;
    var_15 = _getnodesinradius(self.origin, var_13, 0, 180);

    if(isDefined(var_15)) {
      foreach(var_11 in var_15) {
        if(_id_553A(var_11)) {
          var_17 = _anglesdelta(var_11.angles, self._id_38EB.angles);

          if(var_17 < var_14)
            var_9[var_9.size] = var_11;
        }
      }
    }
  }

  foreach(var_11 in var_9) {
    self._id_9D06[self._id_9D06.size] = var_11;
    var_11._id_15CB = self;
  }

  _id_885D();
  thread _id_AA28();
}

_id_5289(var_0) {
  self._id_1176 = [];
  self._id_1178 = [];
  self._id_1177 = [];

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_0165)) {
      switch (var_2._id_0165) {
        case "exit_point":
          self._id_38EB = var_2;
          break;
        case "attack_spot":
          var_3 = _func_2E1(var_2.origin);

          if(_distance2d(var_2.origin, var_3) > 1) {
            break;
          }

          var_2.origin = var_3;
          self._id_1176[self._id_1176.size] = var_2;
          var_2._id_1175 = 0;

          if(isDefined(var_2.setmovespeedscale)) {
            switch (var_2.setmovespeedscale) {
              case 0:
                var_2._id_0EA5 = "l";
                break;
              case 1:
                var_2._id_0EA5 = "m";
                break;
              case 2:
                var_2._id_0EA5 = "r";
                break;
              default:
            }
          }

          break;
      }
    }
  }

  foreach(var_6 in self._id_1176) {
    var_7 = var_6.origin - anglesToForward(var_6.angles) * 36;
    var_8 = _func_2E1(var_7);

    if(_distance2d(var_8, var_7) > 1 || !_func_2DE(var_8, var_6.origin)) {
      var_6._id_A6E6 = var_6.origin;
      continue;
    }

    var_6._id_A6E6 = var_8;
  }

  self._id_1178 = self._id_1176;
}

_id_885D() {
  var_0 = self.setanimknobrestart;

  if(!isDefined(var_0))
    var_0 = 6;

  var_1 = common_scripts\utility::array_randomize(self._id_188D);

  if(var_0 == self._id_6044)
    common_scripts\utility::_id_9D9F();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2]._id_1887;

    if(var_2 < var_0) {
      _id_15D5(var_3, 1);
      _id_15D1();
      continue;
    }

    _id_15D7(var_3, 1);
  }
}

_id_563C(var_0) {
  if(!maps\mp\_utility::isreallyalive(var_0))
    return 0;

  var_1 = var_0 playergetuseent();

  if(!isDefined(var_1) || var_1 != self)
    return 0;

  if(!var_0 usebuttonpressed())
    return 0;

  return 1;
}

_id_3468() {
  self sethintstring(&"ZOMBIES_WALL_BUY_GENERIC");

  for(;;) {
    self waittill("trigger", var_0);

    if(!common_scripts\utility::_id_562E(self._id_15CC._id_17E9)) {
      self._id_15CC notify("gate_purchase");
      continue;
    }
  }
}

_id_345F() {
  self._id_17E9 = 1;
}

_id_AA28() {
  self._id_A1F5 = 1;
  var_0 = undefined;

  if(!common_scripts\utility::_id_562E(level._id_0C11))
    self makeunusable();

  self sethintstring(&"ZOMBIES_REPAIR_BOARDS_HINT");

  for(;;) {
    var_1 = 0;

    if(!common_scripts\utility::_id_562E(self._id_9D9F)) {
      foreach(var_3 in level.players) {
        if(_id_563C(var_3) && self istouching(var_3)) {
          var_0 = var_3;
          var_1 = 1;
          break;
        }
      }
    }

    if(!var_1)
      self waittill("trigger", var_0);

    var_5 = common_scripts\utility::array_randomize(self._id_1890);
    var_6 = var_5[0];
    thread _id_15D4(var_6._id_1887);

    if(isDefined(var_0._id_7F11))
      var_0._id_7F11 = var_0._id_7F11 + 1;

    if(var_0._id_7D10 < level._id_609C) {
      var_7 = _min(level._id_609C - var_0._id_7D10, 10);
      var_0 maps\mp\gametypes\zombies::_id_47AE("repair");
      var_0 thread _id_054E::_id_62D9();
      var_0._id_7D10 = var_0._id_7D10 + var_7;
    }

    self._id_5B41 = var_0;
    self._id_5B42 = gettime();
    wait 1.0;
  }
}

_id_553A(var_0) {
  return var_0.type == "Begin" || var_0.type == "Begin 3D";
}