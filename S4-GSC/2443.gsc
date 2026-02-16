/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2443.gsc
*************************************************/

_id_BB93() {
  _id_7F27();
  _id_D35D("power_on");
  level scripts\engine\utility::_id_5C11("disable_fast_travel");
}

_id_7F27() {}

_id_D35D(var_0) {
  if(!isDefined(level._id_E9E1)) {
    level._id_E9E1 = var_0;
  }
}

_id_BA4E() {
  var_0 = ::_id_59D0;

  if(isDefined(level._id_59D1)) {
    var_0 = level._id_59D1;
  }

  var_1 = scripts\engine\utility::getStructArray("fasttravel_trigger", "targetname");

  foreach(var_3 in var_1) {
    level thread[[var_0]](var_3);
  }

  _id_06CB::_id_AA65(::_id_B44E);

  if(!istrue(level._id_203E)) {
    level thread _id_7F81();
  }

  var_5 = scripts\engine\utility::getstruct("s_teleport_room_1", "targetname");

  if(isDefined(var_5)) {
    level._id_2030 = 1;
  }

  level._id_0DE6 = [];
  level._id_3204 = ::_id_3104;
  level._id_59D5 = ::_id_59CC;
}

_id_10F53(var_0) {
  var_1 = var_0[getfirstarraykey(var_0)];
}

_id_10F54(var_0) {
  var_1 = var_0[getfirstarraykey(var_0)];
}

_id_B44E() {
  self._id_0DED = [];
}

_id_59D0(var_0) {
  var_0._id_F954 = spawnStruct();
  var_0._id_F954.origin = var_0.origin;
  var_0._id_F954.angles = var_0.angles;
  var_0._id_F954._id_CEA4 = "unitrigger_box_use";
  var_0._id_F954._id_4212 = "HINT_NOICON";
  var_0._id_F954._id_C584 = 0;
  var_0._id_F954._id_CE71 = var_0._id_CE71;
  var_0._id_F954._id_039B = var_0._id_039B;
  var_0._id_F954._id_A2F4 = var_0._id_A2F4;
  var_1 = scripts\cp\utility::_id_459B(var_0._id_9243, var_0._id_9242);

  if(isDefined(var_1)) {
    var_0._id_F954._id_9243 = strtok(var_1, " ");
  }

  var_0._id_F954._id_11021 = var_0._id_11021;
  var_0._id_F954._id_2024 = var_0._id_2024;
  var_0._id_F954._id_E9DC = var_0._id_F954._id_CE71;
  var_0._id_F954._id_4649 = var_0._id_4649;
  var_0._id_F954._id_FE3A = 0;

  if(isDefined(var_0._id_F954._id_4649)) {
    var_0._id_F954 scripts\engine\utility::_id_5C11("delayed");
  }

  if(isDefined(level._id_59C5)) {
    var_0[[level._id_59C5]]();
  }

  var_0._id_F954._id_BDA7 = ::_id_59CF;
}

_id_59CF(var_0) {
  self._id_7976 = scripts\cp\utility::_id_459B(self._id_7976, []);
  var_1 = var_0 getentitynumber();
  var_2 = undefined;

  if(!istrue(var_0._id_2031)) {
    self showtoplayer(var_0);
  } else {
    self hidefromplayer(var_0);
  }

  if(isDefined(level._id_59D2)) {
    var_3 = self[[level._id_59D2]](var_0, self._id_EA87._id_E9DC);
  } else {
    var_3 = _id_59CE(var_0, self._id_EA87._id_E9DC);
  }

  if(!istrue(var_0._id_0DED[self._id_EA87._id_E9DC])) {
    if(isDefined(var_0._id_A37A)) {
      var_2 = var_0._id_A37A;
    } else if(isDefined(self._id_EA87)) {
      var_2 = self._id_EA87._id_11021;
    } else {
      var_2 = self._id_11021;
    }
  }

  if(isDefined(self._id_7976[var_1]) && self._id_7976[var_1] != " ") {
    if(isDefined(var_2)) {
      self sethintstring(var_0, self._id_7976[var_1], var_2);
    } else {
      self sethintstring(var_0, self._id_7976[var_1]);
    }
  }

  return var_3;
}

_id_59CE(var_0, var_1) {
  var_2 = 0;
  self._id_7976 = scripts\cp\utility::_id_459B(self._id_7976, []);
  var_3 = var_0 getentitynumber();

  if(!_id_3104(var_0)) {
    self._id_7976[var_3] = "";
  } else if(isDefined(self._id_EA87._id_9243) && !level scripts\cp\utility::_id_5C0E(self._id_EA87._id_9243)) {
    self._id_7976[var_3] = "ZOMBIE/FASTTRAVEL_LOCKED";
    var_2 = 1;
  } else if(istrue(var_0._id_0DED[var_1])) {
    self._id_7976[var_3] = "ZOMBIE/GENERIC_FASTTRAVEL_COOLDOWN";
    var_2 = 1;
  } else if(isDefined(self._id_EA87._id_4649) && !self._id_EA87 scripts\engine\utility::_id_546E("delayed")) {
    self._id_7976[var_3] = "ZOMBIE/FASTTRAVEL_DELAY";
    var_2 = 1;
  } else {
    if(_func_03B3()) {
      self._id_7976[var_3] = "ZOMBIE/FASTTRAVEL_GENERIC_USE_KEYBOARD";
    } else {
      self._id_7976[var_3] = "ZOMBIE/FASTTRAVEL_GENERIC_USE";
    }

    var_2 = 1;
  }

  return var_2;
}

_id_3104(var_0) {
  if(!level scripts\engine\utility::_id_5C00(level._id_E9E1)) {
    return 0;
  } else if(!scripts\cp\utility::_id_8677(var_0)) {
    return 0;
  } else if(istrue(var_0._id_2031) && isDefined(self._id_EA87) && (isDefined(self._id_EA87._id_CE71) && self._id_EA87._id_CE71 != "dropout")) {
    return 0;
  } else if(istrue(var_0._id_2025)) {
    return 0;
  } else if(var_0 _meth_81EF()) {
    return 0;
  } else if(level scripts\engine\utility::_id_5C00("disable_fast_travel")) {
    return 0;
  }

  return 1;
}

_id_59CD() {
  level endon("end_game");
  var_0 = self._id_EA87._id_E9DC;

  for(;;) {
    self waittill("trigger", var_1);

    if(var_1 _meth_81EF()) {
      continue;
    }
    if(istrue(var_1._id_2025)) {
      continue;
    }
    if(istrue(var_1._id_2031)) {
      continue;
    }
    if(!scripts\cp\utility::_id_8677(var_1)) {
      continue;
    }
    if(isDefined(self._id_EA87._id_9243) && !level scripts\cp\utility::_id_5C0E(self._id_EA87._id_9243)) {
      continue;
    }
    if(istrue(var_1._id_0DED[var_0])) {
      continue;
    }
    if(isDefined(self._id_EA87._id_4649) && !self._id_EA87 scripts\engine\utility::_id_546E("delayed")) {
      continue;
    }
    if(isDefined(var_1._id_A37A)) {
      var_2 = var_1._id_A37A;
    } else if(isDefined(self._id_EA87)) {
      var_2 = self._id_EA87._id_11021;
    } else {
      var_2 = self._id_11021;
    }

    if(isDefined(level._id_0BEF)) {
      var_2 = var_1[[level._id_0BEF]](self);
    }

    level notify("fasttravel_bought", var_1);
    var_1 notify("fasttravel_bought");

    if(isDefined(level._id_0BF1)) {
      var_1[[level._id_0BF1]](self);
    }

    if(isDefined(self._id_EA87)) {
      var_1 thread _id_59CC(self._id_EA87, self._id_EA87._id_A2F4);
      continue;
    }

    var_1 thread _id_59CC(self);
  }
}

_id_59CC(var_0, var_1) {
  level endon("end_game");
  self endon("death");
  var_1 = scripts\cp\utility::_id_459B(var_1, 0);
  var_2 = _id_6677(self);
  var_3 = var_0._id_CE71;
  self._id_E9E0 = var_3;
  self._id_59C6 = 0;
  level notify(var_3 + "_start", self, var_0);
  var_4 = var_0._id_039B;
  var_5 = var_0._id_E9DC;
  var_0._id_FE3A = 1;

  switch (var_4) {
    case "traverse":
      if(var_1) {
        if(isDefined(var_3) && var_3 == "dropout") {
          var_6 = self._id_A392;
        } else {
          var_6 = _id_59D3(var_3);

          if(!isDefined(var_6)) {
            return;
          }
          self._id_A392 = var_6;
        }

        var_7 = _func_00E5("fasttravel_" + var_3 + "_start_" + var_6, "targetname");
        var_8 = _func_00E5("fasttravel_" + var_3 + "_zipline_end_" + var_6, "targetname");
        var_9 = "fasttravel_" + var_3 + "_zipline_end_" + var_6;
      } else {
        var_7 = _func_00E5("fasttravel_" + var_3 + "_start", "targetname");
        var_9 = var_3 + "_end";
      }

      var_10 = getent("veh_fasttravel_cam", "targetname");
      _id_59C8(var_10, var_7, undefined, var_9, undefined, var_0, undefined, undefined);
      break;
    case "flinger":
    case "teleport":
      var_6 = _id_59D3(var_3);

      if(!isDefined(var_6)) {
        return;
      }
      self._id_A392 = var_6;
      var_9 = "fasttravel_" + var_3 + "_end_" + var_6;
      _id_59C8(undefined, undefined, undefined, var_9, undefined, var_0, undefined, undefined);
      break;
  }

  if(!var_1) {
    var_11 = _id_67CC(var_3);
  }

  var_12 = 1;
  var_13 = 1;
  var_11 = undefined;

  if(var_4 == "traverse") {
    if(istrue(level._id_202F)) {
      var_12 = 0;
    } else {
      waitframe();

      if(istrue(level._id_202E) || istrue(level._id_202D)) {
        var_13 = 0;
      }
    }
  } else if(var_4 == "flinger")
    var_13 = 0;

  if(var_12) {
    _id_F02A(var_11, var_13);

    if(isDefined(level._id_0BF0)) {
      self thread[[level._id_0BF0]]();
    }
  }

  if(isDefined(self._id_A379)) {
    var_14 = self._id_A379;
  } else if(isDefined(level._id_A379)) {
    var_14 = level._id_A379;
  } else {
    var_14 = 30;
  }

  _id_59C4(var_0, var_14, var_5);
  self notify("fasttravel_cooldown_done", var_0);
}

_id_67CC(var_0) {
  if(self._id_59C6) {
    var_1 = _id_6445(var_0 + "_dropdown_end_");
    var_2 = _id_6720(var_1);
  } else {
    var_1 = _id_6445(var_0 + "_end_");
    var_2 = _id_6720(var_1);
  }

  return var_2;
}

_id_F02A(var_0, var_1) {
  var_1 = scripts\cp\utility::_id_459B(var_1, 1);

  if(!istrue(self._id_E3E5)) {
    self dontinterpolate();
    self setorigin(var_0.origin);
    self setvelocity((0, 0, 0));
  }

  if(var_1 && isDefined(var_0.angles)) {
    self setplayerangles(var_0.angles);
  }

  _id_C5DA();
  self._id_2031 = 0;
  thread _id_7D0C();
}

_id_7D0C() {
  level endon("end_game");
  self endon("death");
  var_0 = 1024;
  var_1 = 1;

  while(var_1) {
    var_2 = scripts\cp\utility::_id_6C5C();

    foreach(var_4 in var_2) {
      if(!isDefined(var_4)) {
        continue;
      }
      var_5 = distance2dsquared(var_4.origin, self.origin);

      if(self != var_4 && !istrue(var_4._id_2031) && var_5 <= var_0) {
        continue;
      }
    }

    var_1 = 0;
    waitframe();
  }

  self._id_2041 = undefined;
}

_id_59D3(var_0) {
  var_1 = level._id_0DE7.size;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = randomint(var_1);

    if(level._id_0DE7[var_3] == 0) {
      level._id_0DE7[var_3] = 1;
      return var_3;
    }
  }

  return undefined;
}

_id_6677(var_0) {
  var_1 = scripts\cp\utility::_id_6C5C(var_0.team);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_0 == var_1[var_2]) {
      return var_2;
    }
  }
}

_id_6445(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < 4; var_2++) {
    var_3 = scripts\engine\utility::getstruct(var_0 + var_2);
    var_1 = scripts\engine\utility::array_add(var_1, var_3);
  }

  return var_1;
}

_id_59C8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  level endon("end_game");
  var_7 = scripts\cp\utility::_id_459B(var_7, 0);
  var_8 = scripts\cp\utility::_id_459B(var_8, 1);
  var_9 = scripts\cp\utility::_id_459B(var_9, 1);
  var_10 = scripts\cp\utility::_id_459B(var_10, 0);
  var_11 = scripts\cp\utility::_id_459B(var_11, 0);
  self._id_2031 = 1;
  self._id_2035 = 1;

  if(var_10) {
    if(istrue(self._id_86E6)) {
      if(isDefined(level._id_2F27)) {
        self[[level._id_2F27]]();
      }
    }
  }

  _id_D355(var_5);
  self._id_2041 = 1;
  _id_06E5::_id_D12B("fasttravel", "freezecontrols", 1);
  _id_06E5::_id_D12B("fasttravel", "show_hud", 0);

  if(scripts\cp_mp\utility\player_utility::isinvehicle() && !isDefined(self._id_FFE7)) {
    self unlink();
    waitframe();
  }

  if(isDefined(var_5)) {
    var_6 = var_5._id_CE71;
    self._id_E9DF = var_6;
    var_12 = var_5._id_E9DE;
  }

  if(!var_7) {
    while(scripts\engine\utility::is_equal(level._id_0DE6[var_6], 1)) {
      waitframe();
    }

    level thread _id_107AA(var_6);
  }

  if(!_id_073B::_id_B4EF(self) && isalive(self)) {
    var_13 = self getstance();

    if(scripts\common\utility::_id_86D0()) {
      switch (var_13) {
        case "crouch":
          self setstance("stand");

          if(var_9) {
            wait 0.2;
          }

          break;
        case "prone":
          self setstance("stand");

          if(var_9) {
            wait 1.0;
          }

          break;
      }
    }
  }

  self notify("player_begin_fasttravel_rail", var_5);

  if(!istrue(self._id_10624)) {
    self _meth_83F8();
  }

  if(!isDefined(var_5) || isDefined(var_5) && !istrue(var_5._id_203B)) {
    self playerhide();
  }

  thread _id_59C7();

  if(istrue(level._id_2030)) {
    var_14 = undefined;
    thread _id_59CB(var_4, var_14, var_11);
  } else
    thread _id_59CA(var_4);

  self waittill("fasttravel_over");
  self._id_2035 = 0;
  scripts\engine\utility::_id_5474("fasttravel_done");

  if(isDefined(var_0)) {
    waitframe();
    self allowcrouch(1);
    self allowprone(1);
  } else
    _id_06E5::_id_C5F9("fasttravel", "freezecontrols");

  self playershow();

  if(isDefined(self._id_A392)) {
    level._id_0DE7[self._id_A392] = 0;
  }

  if(isDefined(var_3)) {
    level notify(var_3);
  }

  self._id_E9DF = undefined;
  self notify("fasttravel_finished", var_5);

  if(istrue(var_8) && isDefined(level._id_59D4)) {
    thread[[level._id_59D4]](self, var_5);
  }

  scripts\engine\utility::_id_5C04("fasttravel_done");
}

_id_107AA(var_0) {
  level endon("end_game");
  level._id_0DE6[var_0] = 1;
  scripts\cp\utility::_id_10839(2);
  level._id_0DE6[var_0] = undefined;
}

_id_D355(var_0) {
  self._id_2036 = 1;
  self._id_203A = 1;
  _id_06E5::_id_D12B("fasttravel", "ignoreme", 1);
  var_1 = 1;

  if(isDefined(var_0) && istrue(var_0._id_2024)) {
    var_1 = 0;
  }

  if(var_1) {
    _id_0728::force_end_offhand();
    _id_06E5::_id_D12B("fasttravel", "disable_weapons", 1);
  }
}

_id_C5DA() {
  if(!isDefined(self) || _func_0458(self)) {
    return;
  }
  self._id_2036 = 0;
  self._id_203A = 0;
  _id_06E5::_id_C5F9("fasttravel", "ignoreme");
  _id_06E5::_id_C5F9("fasttravel", "disable_weapons");
  _id_06E5::_id_C5F9("fasttravel", "show_hud");
}

_id_59C3(var_0) {
  _id_C5DA();
  _id_06E5::_id_C5F9("fasttravel", "freezecontrols");
  self allowcrouch(1);
  self allowprone(1);
  self._id_2041 = undefined;
  self._id_2031 = 0;
  _id_06E5::_id_C5F9("fasttravel", "show_hud");
}

_id_59CA(var_0) {
  var_1 = self.origin;
  wait 0.5;

  if(isDefined(var_0)) {
    if(_func_0107(var_0)) {
      var_2 = _id_6720(var_0);
    } else {
      var_2 = var_0;
    }

    _id_F02A(var_2);
  }

  wait 0.5;
  self notify("fasttravel_over");
}

_id_59C7() {
  level endon("end_game");
  self endon("death");
  self waittill("fasttravel_over");
  var_0 = undefined;

  if(isDefined(level._id_122C)) {
    var_0 = level._id_122C["axis"];
  }

  if(isDefined(var_0) && var_0.size) {
    var_1 = _id_06FE::_id_68A1("axis");

    if(var_1.size > 0) {
      foreach(var_3 in var_1) {
        if(distancesquared(self.origin, var_3.origin) <= 409600) {
          continue;
        }
        if(istrue(var_3._id_3B1C) && _id_8E37(var_3)) {}
      }
    }
  }
}

_id_8E37(var_0) {
  return 0;
}

_id_59C4(var_0, var_1, var_2) {
  level endon("end_game");
  self endon("death");

  if(var_2 == "no_cooldown") {
    return;
  }
  self._id_0DED[var_2] = 1;

  if(isDefined(var_0)) {
    var_0 scripts\engine\utility::_id_108F5("cancel_fasttravel_cooldown", var_1);
  } else {
    wait(var_1);
  }

  self._id_0DED[var_2] = 0;
}

_id_7F81() {
  level endon("end_game");
  level waittill("all_players_spawned");
  level scripts\engine\utility::_id_5C24(level._id_E9E1);
  var_0 = scripts\engine\utility::getStructArray("fasttravel_trigger", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_F954._id_4649)) {
      var_2._id_F954 scripts\cp\utility::_id_5C09(var_2._id_F954._id_4649, "delayed");
    }
  }
}

_id_106AA(var_0) {
  waitframe();

  if(!isDefined(self) || _func_0458(self)) {
    return;
  }
  self._id_50DC = spawn("script_origin", var_0.origin);
  self._id_50DC.angles = var_0.angles;
  self playerlinkto(self._id_50DC);
}

_id_106AB(var_0, var_1, var_2) {
  if(istrue(self._id_E3E5)) {
    return;
  }
  waitframe();
  self dontinterpolate();
  self setorigin(var_1.origin);
  self setplayerangles(var_1.angles);
  childthread _id_106AA(var_1);
  waittillframeend;
  self _meth_8278("steady_rumble");
}

_id_59CB(var_0, var_1, var_2) {
  level endon("end_game");
  var_2 = scripts\cp\utility::_id_459B(var_2, 0);
  var_3 = self.origin;
  self allowstand(1);
  self allowcrouch(0);
  self allowprone(0);
  self allowmelee(0);
  self allowfire(0);
  var_4 = [];

  for(var_5 = 0; var_5 < 4; var_5++) {
    var_6 = "s_teleport_room_" + (var_5 + 1);
    var_4[var_5] = ::scripts\engine\utility::getstruct(var_6, "targetname");
  }

  if(!isDefined(level._id_A38D)) {
    level._id_A38D = 0;
  }

  var_7 = var_4[level._id_A38D];
  level._id_A38D++;
  var_8 = level._id_A38D;

  if(level._id_A38D >= var_4.size) {
    level._id_A38D = 0;
  }

  childthread _id_106AB(var_3, scripts\engine\utility::ter_op(isDefined(var_1), var_1, var_7), var_8);
  var_9 = 1000;
  var_10 = var_7.origin + anglesToForward(var_7.angles) * var_9;
  var_11 = scripts\cp\utility::_id_EA7B(var_10, var_7.angles - (0, 90, 0));
  _id_DC7C(var_11, var_2);

  if(!isDefined(self) || _func_0458(self)) {
    return;
  }
  if(isDefined(self._id_50DC)) {
    self._id_50DC delete();
    self._id_50DC = undefined;
  }

  if(isDefined(var_0)) {
    if(_func_0107(var_0)) {
      var_12 = _id_6720(var_0);
    } else {
      var_12 = var_0;
    }

    _id_F02A(var_12);
  }

  self allowcrouch(1);
  self allowprone(1);
  self allowmelee(1);
  self allowfire(1);
  self notify("fasttravel_over", "vortex");
}

_id_3865(var_0) {
  if(isDefined(self) && isDefined(self._id_50DC)) {
    self._id_50DC delete();
  }
}

_id_6829(var_0) {
  var_0 = scripts\cp\utility::_id_459B(var_0, 0);

  if(var_0) {
    return "p8_fxanim_zm_zod_wormhole_looping_bundle";
  }

  return "p8_fxanim_zm_zod_wormhole_bundle";
}

_id_6828() {
  if(isDefined(level._id_A37B)) {
    return level._id_A37B;
  } else {
    var_0 = _id_6829();
    return _func_0079(var_0);
  }
}

_id_107D0(var_0) {
  var_0 = scripts\cp\utility::_id_459B(var_0, 1);
  wait(var_0);
  level notify("halfway_done_with_vortex_fx");
}

_id_DC7C(var_0, var_1) {
  level endon("end_game");
  var_1 = scripts\cp\utility::_id_459B(var_1, 0);
  var_2 = _id_6829(var_1);
  var_3 = _id_6828();
  var_3 = var_3 / 2;
  level thread _id_107D0(var_3);
  self notify("begin_vortex_fx");

  if(isDefined(level.str_portal_first_person_effect_label_override)) {
    stopFXOnTag(level._effect[level.str_portal_first_person_effect_label_override], self, "j_head");
  } else {
    stopFXOnTag(level._effect["zm_teleport_intro"], self, "j_head");
  }

  _id_072E::close_all_menus();

  if(var_1) {
    self setclientomnvar("ui_cp_bink_overlay_state", 1);
    var_4 = "zm_portal_full_red";

    if(isDefined(level.str_portal_cinematic_override)) {
      var_4 = level.str_portal_cinematic_override;
    }

    if(isDefined(level.b_portal_cinematic_looping) && !level.b_portal_cinematic_looping) {
      self _meth_8766(var_4);
    } else {
      self _meth_8767(var_4);
    }

    var_5 = 3.0;

    if(isDefined(level.n_portal_cinematic_min_time_override)) {
      var_5 = level.n_portal_cinematic_min_time_override;
    }

    var_6 = gettime();
    scripts\cp\cp_destinations::wait_for_current_destination_to_load();
    var_7 = var_5 - scripts\cp\utility::_id_A2B8(gettime() - var_6);

    if(var_7 > 0) {
      wait(var_7);
    }

    level thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 1, 0.6);
    wait 0.85;

    if(!isDefined(self)) {
      return;
    }
    self setclientomnvar("ui_cp_bink_overlay_state", 0);
    self _meth_8769();
    wait 0.3;

    if(!isDefined(self)) {
      return;
    }
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 0, 0.25);
  } else {
    self setclientomnvar("ui_cp_bink_overlay_state", 1);
    self _meth_8767("zm_portal_full_red");
    wait(var_3);
    self setclientomnvar("ui_cp_bink_overlay_state", 0);
    self _meth_8769();
  }

  self _meth_83F4("steady_rumble");
}

_id_6720(var_0) {
  var_1 = _id_6677(self);
  var_2 = scripts\cp\utility::_id_6C5C();

  if(_id_86A7(var_0[var_1], var_2)) {
    return var_0[var_1];
  }

  foreach(var_4 in var_0) {
    if(var_4 == var_0[var_1]) {
      continue;
    }
    if(_id_86A7(var_4, var_2)) {
      return var_4;
    }
  }

  return var_0[var_1];
}

_id_86A7(var_0, var_1) {
  var_2 = 1024;
  var_3 = 1;

  foreach(var_5 in var_1) {
    if(istrue(var_5._id_2031)) {
      continue;
    } else if(abs(var_0.origin[2] - var_5.origin[2]) > 60) {
      continue;
    } else if(distance2dsquared(var_0.origin, var_5.origin) > var_2) {
      continue;
    } else {
      var_3 = 0;
      break;
    }
  }

  return var_3;
}

_id_1100E(var_0) {
  switch (var_0) {
    case "start_looping":
      if(!istrue(level._id_2029)) {
        level._id_2029 = 1;
        level thread _id_4460(0);
      }

      break;
    case "stop_looping":
      if(istrue(level._id_2029)) {
        level._id_2029 = 0;
      }

      break;
    case "play_once":
      if(!istrue(level._id_2029)) {
        level._id_2029 = 1;
        level thread _id_4460(1);
      }

      break;
  }
}

_id_4460(var_0) {
  level endon("end_game");
  var_1 = scripts\cp\utility::_id_EA7B((0, 0, 0));
  var_2 = level.players[0];
  var_2 endon("disconnect");
  var_3 = var_2.origin;
  var_4 = var_2.angles;

  while(istrue(level._id_2029)) {
    var_2 _id_59CB(var_1);

    if(istrue(var_0)) {
      level._id_2029 = 0;
    }
  }

  var_2 setorigin(var_3);
  var_2 setplayerangles(var_4);
}