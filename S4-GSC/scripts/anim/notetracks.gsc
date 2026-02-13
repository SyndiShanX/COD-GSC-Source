/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\anim\notetracks.gsc
*************************************************/

_id_C27C() {
  anim._id_A64F["anim_movement = \"stop\""] = ::_id_A63E;
  anim._id_A64F["anim_movement = \"walk\""] = ::_id_A63F;
  anim._id_A64F["anim_movement = \"run\""] = ::_id_A63D;
  anim._id_A64F["anim_movement = stop"] = ::_id_A63E;
  anim._id_A64F["anim_movement = walk"] = ::_id_A63F;
  anim._id_A64F["anim_movement = run"] = ::_id_A63D;
  anim._id_A64F["anim_movement_gun_pose_override = run_gun_down"] = ::_id_A63C;
  anim._id_A64F["anim_coverpose = cover_left"] = ::_id_A613;
  anim._id_A64F["anim_coverpose = cover_right"] = ::_id_A613;
  anim._id_A64F["anim_coverpose = cover_crouch"] = ::_id_A613;
  anim._id_A64F["anim_coverpose = cover_stand"] = ::_id_A613;
  anim._id_A64F["anim_coverpose = cover_left_crouch"] = ::_id_A613;
  anim._id_A64F["anim_coverpose = cover_right_crouch"] = ::_id_A613;
  anim._id_A64F["anim_coverpose = exposed"] = ::_id_A613;
  anim._id_A64F["anim_coverpose = exposed_crouch"] = ::_id_A613;
  anim._id_A64F["anim_coverpose = prone"] = ::_id_A613;
  anim._id_A64F["anim_aiming = 1"] = ::_id_A60E;
  anim._id_A64F["anim_aiming = 0"] = ::_id_A60F;
  anim._id_A64F["anim_alertness = causal"] = ::_id_A610;
  anim._id_A64F["anim_alertness = alert"] = ::_id_A60F;
  anim._id_A64F["anim_alertness = aiming"] = ::_id_A60E;
  anim._id_A64F["gravity on"] = ::_id_A62A;
  anim._id_A64F["gravity off"] = ::_id_A62A;
  anim._id_A64F["bodyfall large"] = ::_id_A611;
  anim._id_A64F["bodyfall small"] = ::_id_A611;
  anim._id_A64F["code_move"] = ::_id_A612;
  anim._id_A64F["face_enemy"] = ::_id_A617;
  anim._id_A64F["pistol_rechamber"] = ::_id_A642;
  anim._id_A64F["load_shell"] = ::_id_A638;
  anim._id_A64F["fire"] = ::_id_A626;
  anim._id_A64F["fire_spray"] = ::_id_A627;
  anim._id_A64F["gun_2_chest"] = ::_id_A62E;
  anim._id_A64F["gun_2_back"] = ::_id_A62D;
  anim._id_A64F["gun_2_right"] = ::_id_A62F;
  anim._id_A64F["pistol_pickup"] = ::_id_A640;
  anim._id_A64F["pistol_putaway"] = ::_id_A641;
  anim._id_A64F["refill clip"] = ::_id_A64D;
  anim._id_A64F["reload done"] = ::_id_A64D;
  anim._id_A64F["ht_on"] = ::_id_A634;
  anim._id_A64F["ht_on_0"] = ::_id_A634;
  anim._id_A64F["ht_on_1"] = ::_id_A635;
  anim._id_A64F["ht_off"] = ::_id_A633;

  if(isDefined(level._id_0C6E)) {
    var_0 = getarraykeys(level._id_0C6E);

    foreach(var_2 in var_0) {
      anim._id_A64F[var_2] = ::_id_4278;
    }
  }
}

_id_A652(var_0, var_1) {}

_id_A613(var_0, var_1) {
  var_2 = strtok(var_0, " = ")[1];

  switch (var_2) {
    case "cover_left_crouch":
    case "cover_stand":
    case "cover_crouch":
    case "exposed_crouch":
    case "cover_right_crouch":
    case "cover_right":
    case "cover_left":
    case "exposed":
    case "prone":
      self._id_0DDF._id_3DEC = var_2;
      break;
    default:
  }
}

_id_A63E(var_0, var_1) {
  self._id_0DDF._id_A235 = "stop";
}

_id_A63F(var_0, var_1) {
  self._id_0DDF._id_A235 = "walk";
}

_id_A63D(var_0, var_1) {
  self._id_0DDF._id_A235 = "run";
}

_id_A63C(var_0, var_1) {
  self._id_1C30._id_A23A = "run_gun_down";
}

_id_A60E(var_0, var_1) {}

_id_A610(var_0, var_1) {}

_id_A60F(var_0, var_1) {}

_id_A638(var_0, var_1) {}

_id_A642(var_0, var_1) {}

_id_A62A(var_0, var_1) {
  if(issubstr(var_0, "on")) {
    self _meth_8019("gravity");
  } else if(issubstr(var_0, "off")) {
    self _meth_8019("nogravity");
  }
}

_id_4278(var_0, var_1) {
  if(isDefined(self._id_020C)) {
    var_2 = self._id_020C;
  } else {
    var_2 = "dirt";
  }

  var_3 = undefined;

  if(isDefined(level._id_0C6E[var_0][var_2])) {
    var_3 = level._id_0C6E[var_0][var_2];
  } else if(isDefined(level._id_0C6E[var_0]["all"])) {
    var_3 = level._id_0C6E[var_0]["all"];
  }

  if(!isDefined(var_3)) {
    return;
  }
  if(isai(self) && isDefined(var_3._id_605B)) {
    playFXOnTag(var_3._id_605B, self, var_3._id_0427);
  }

  if(!isDefined(var_3._id_E05A) && !isDefined(var_3._id_E05B)) {
    return;
  }
  var_4 = "" + var_3._id_E05A + var_2 + var_3._id_E05B;

  if(_func_0205(var_4)) {
    self playSound(var_4);
  }
}

_id_A612(var_0, var_1) {
  return "code_move";
}

_id_A617(var_0, var_1) {
  self _meth_8251("face enemy");
}

_id_A611(var_0, var_1) {
  var_2 = "_small";

  if(issubstr(var_0, "large")) {
    var_2 = "_large";
  }

  if(isDefined(self._id_020C)) {
    var_3 = self._id_020C;
  } else {
    var_3 = "dirt";
  }

  if(var_2 == "_large") {
    self _meth_8281("bodyfall_torso", var_3);
  } else {
    self _meth_8281("bodyfall_limb_small", var_3);
  }
}

_id_4D62(var_0, var_1, var_2) {
  var_3 = undefined;

  for(;;) {
    self waittill(var_0, var_4);

    if(!isDefined(var_4)) {
      var_4 = ["undefined"];
    }

    if(!_func_0107(var_4)) {
      var_4 = [var_4];
    }

    _id_06DC::_id_FF4D(var_0, var_4);

    foreach(var_6 in var_4) {
      var_7 = _id_7476(var_6, var_0, var_1);

      if(isDefined(var_7)) {
        var_3 = var_7;
      }
    }

    if(isDefined(var_3)) {
      return var_3;
    }
  }
}

_id_7476(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_5D5D)) {
    return [[self._id_5D5D]](var_0, var_1, var_2, var_3);
  } else if(isDefined(level._id_0BB2)) {
    return [[level._id_0BB2]](var_0, var_1, var_2, var_3);
  } else {}
}

_id_7550(var_0) {
  var_1 = anim._id_A64F[var_0];

  if(isDefined(var_1)) {
    return 1;
  }

  if(isDefined(self._id_4279)) {
    return 1;
  }

  return 0;
}

_id_742E(var_0, var_1, var_2, var_3) {
  var_4 = anim._id_A64F[var_0];

  if(isDefined(var_4)) {
    return [[var_4]](var_0, var_1);
  } else if(isDefined(self._id_4279)) {
    if(isDefined(var_3)) {
      return [[self._id_4279]](var_0, var_1, var_2, var_3);
    } else {
      return [[self._id_4279]](var_0, var_1, var_2);
    }
  }
}

_id_742C(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "finish":
    case "end":
    case "undefined":
      return var_0;
    case "finish early":
      if(isDefined(self._id_0192)) {
        return var_0;
      }

      break;
    case "swish small":
      var_4 = self gettagorigin("TAG_WEAPON_RIGHT", 1);

      if(isDefined(var_4)) {
        thread scripts\engine\utility::_id_B2DA("melee_swing_small", var_4);
      }

      break;
    case "swish large":
      var_4 = self gettagorigin("TAG_WEAPON_RIGHT", 1);

      if(isDefined(var_4)) {
        thread scripts\engine\utility::_id_B2DA("melee_swing_large", var_4);
      }

      break;
    case "no death":
      self._id_0DDF._id_A567 = 1;
      break;
    case "no pain":
      self._id_0043 = 0;
      break;
    case "allow pain":
      self._id_0043 = 1;
      break;
    case "anim_melee = \"right\"":
    case "anim_melee = right":
      self._id_0DDF._id_9DA5 = "right";
      break;
    case "anim_melee = \"left\"":
    case "anim_melee = left":
      self._id_0DDF._id_9DA5 = "left";
      break;
    case "swap taghelmet to tagleft":
      if(isDefined(self._id_75C6)) {
        if(isDefined(self._id_780F)) {
          self detach(self._id_780F, "TAG_HELMETSIDE");
          self._id_780F = undefined;
        }

        self detach(self._id_75C6, "");
        self attach(self._id_75C6, "TAG_WEAPON_LEFT");
        self._id_75C6 = undefined;
      }

      break;
    case "break glass":
      level notify("glass_break", self);
      break;
    case "break_glass":
      level notify("glass_break", self);
      break;
    case "start_drift":
      if(!self._id_01C2) {
        self _meth_8019("physics_drift");
      }

      break;
    default:
      return "__unhandled";
  }
}

_id_4D6C(var_0, var_1, var_2) {
  for(;;) {
    self waittill(var_0, var_3);

    if(!isDefined(var_3)) {
      var_3 = ["undefined"];
    }

    if(!_func_0107(var_3)) {
      var_3 = [var_3];
    }

    _id_06DC::_id_FF4D(var_0, var_3);
    var_4 = [[var_1]](var_3);

    if(isDefined(var_4) && var_4) {
      continue;
    }
    var_5 = undefined;

    foreach(var_7 in var_3) {
      var_8 = _id_7476(var_7, var_0);

      if(isDefined(var_8)) {
        var_5 = var_8;
        break;
      }
    }

    if(isDefined(var_5)) {
      return var_5;
    }
  }
}

_id_4D6D(var_0, var_1) {
  for(;;) {
    self waittill(var_0, var_2);

    if(!isDefined(var_2)) {
      var_2 = ["undefined"];
    }

    if(!_func_0107(var_2)) {
      var_2 = [var_2];
    }

    _id_06DC::_id_FF4D(var_0, var_2);
    var_3 = undefined;

    foreach(var_5 in var_2) {
      var_6 = _id_7476(var_5, var_0);

      if(isDefined(var_6)) {
        var_3 = var_6;
        break;
      }
    }

    [[var_1]](var_2);

    if(isDefined(var_3)) {
      return var_3;
    }
  }
}

_id_4D6A(var_0, var_1, var_2, var_3) {
  _id_4D62(var_0, var_2, var_3);
}

_id_4D64(var_0, var_1, var_2, var_3) {
  _id_4D66(::_id_4D62, var_0, var_1, var_2, var_3);
}

_id_4D65(var_0, var_1, var_2, var_3) {
  _id_4D66(::_id_4D6C, var_0, var_1, var_2, var_3);
}

_id_4D66(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2)) {
    self endon(var_2);
  }

  self endon("killanimscript");

  if(!isDefined(var_4)) {
    var_4 = "undefined";
  }

  for(;;) {
    var_5 = gettime();
    var_6 = [[var_0]](var_1, var_3, var_4);
    var_7 = gettime() - var_5;

    if(var_7 < 0.05) {
      var_5 = gettime();
      var_6 = [[var_0]](var_1, var_3, var_4);
      var_7 = gettime() - var_5;

      if(var_7 < 0.05) {
        wait(0.05 - var_7);
      }
    }
  }
}

_id_4D6E(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4 thread _id_4D68(var_1);
  _id_4D6B(::_id_4D6A, var_0, var_2, var_3, var_4);
}

_id_4D67(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4 thread _id_4D68(var_0);
  _id_4D6B(::_id_4D64, var_1, var_2, var_3, var_4);
}

_id_4D69(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4 thread _id_4D68(var_0);
  _id_4D6B(::_id_4D65, var_1, var_2, var_3, var_4);
}

_id_4D6B(var_0, var_1, var_2, var_3, var_4) {
  var_4 endon("stop_notetracks");
  [[var_0]](var_1, undefined, var_2, var_3);
}

_id_4D68(var_0) {
  wait(var_0);
  self notify("stop_notetracks");
}

_id_A604(var_0) {
  return [[level._id_5DAC]](var_0);
}

_id_A605(var_0) {
  var_1 = _func_00D6(var_0, 0, 4);

  if(var_1 == "fsf_") {
    var_2 = strtok(var_0, "_");
    var_3 = float(var_2[1]);
    var_4 = float(var_2[2]);
    level.player _meth_8209(var_3, var_4);
    return 1;
  }

  return 0;
}

_id_DA30() {
  waittillframeend;

  if(isDefined(self) && gettime() > self._id_0DDF._id_9041) {
    if(istrue(self._id_0B67._id_03CE)) {
      var_0 = self._id_0B67._id_03CA == 1;
    } else {
      var_0 = 1;
    }

    scripts\anim\utility_common::_id_DA26(var_0);
    _id_08F1::_id_4555();

    if(weaponclass(self._id_04F6) == "rocketlauncher") {
      self._id_037B--;
    }
  }
}

_id_A626(var_0, var_1) {
  if(isDefined(self.script) && isDefined(anim._id_5B46[self.script])) {
    thread[[anim._id_5B46[self.script]]]();
  } else {
    thread _id_DA30();
  }
}

_id_A627(var_0, var_1) {
  if(!isalive(self) && self _meth_81BA()) {
    if(isDefined(self._id_33D9)) {
      return;
    }
    self._id_33D9 = 1;
    var_2["axis"] = "team3";
    var_2["team3"] = "axis";
    self.team = var_2[self.team];
  }

  if(!_func_011D(self)) {
    self notify("fire");
    return;
  }

  if(_func_0376(self._id_0DDF._id_10DC1["right"])) {
    return;
  }
  var_3 = self _meth_815C();
  var_4 = anglesToForward(self _meth_815B());
  var_5 = 10;

  if(isDefined(self._id_89DA)) {
    var_5 = 20;
  }

  var_6 = 0;

  if(isalive(self._id_0192) && _func_011D(self._id_0192) && self _meth_8069()) {
    var_7 = vectornormalize(self._id_0192 getEye() - var_3);

    if(vectordot(var_4, var_7) > cos(var_5)) {
      var_6 = 1;
    }
  }

  if(var_6) {
    scripts\anim\utility_common::_id_DA26();
  } else {
    var_4 = var_4 + ((randomfloat(2) - 1) * 0.1, (randomfloat(2) - 1) * 0.1, (randomfloat(2) - 1) * 0.1);
    var_8 = var_3 + var_4 * 1000;
    self[[anim._id_DA34]](var_8);
  }

  _id_08F1::_id_4555();
}

_id_A64D(var_0, var_1) {
  scripts\anim\weaponlist::_id_C194();
  self._id_0DDF._id_A411 = 0;
}

_id_6C85() {
  if(isDefined(self._id_109C7) && self._id_109C7) {
    if(scripts\anim\utility_common::_id_8A2E(self._id_034C)) {
      return self._id_034C;
    } else if(scripts\anim\utility_common::_id_8A2E(self._id_03B5)) {
      return self._id_03B5;
    }
  }

  return self._id_034C;
}

_id_A62E(var_0, var_1) {
  if(isDefined(self._id_5DAF)) {
    self[[self._id_5DAF]](self._id_04F6, "chest");
  }
}

_id_A62D(var_0, var_1) {
  if(isDefined(self._id_5DAF)) {
    self[[self._id_5DAF]](self._id_04F6, "back");
  }

  self._id_04F6 = _id_6C85();
  self._id_00CC = weaponclipsize(self._id_04F6);
}

_id_A640(var_0, var_1) {
  if(isDefined(self._id_5DAF)) {
    self[[self._id_5DAF]](self._id_03D6, "right");
  }

  self._id_00CC = weaponclipsize(self._id_04F6);
  self notify("weapon_switch_done");
}

_id_A641(var_0, var_1) {
  if(isDefined(self._id_5DAF)) {
    if(isDefined(self._id_E9D1)) {
      self[[self._id_5DAF]](self._id_04F6, self._id_E9D1);
    } else {
      self[[self._id_5DAF]](self._id_04F6, "none");
    }
  }

  self._id_04F6 = _id_6C85();
  self._id_00CC = weaponclipsize(self._id_04F6);
}

_id_A62F(var_0, var_1) {
  if(isDefined(self._id_5DAF)) {
    self[[self._id_5DAF]](self._id_04F6, "right");
  }

  self._id_00CC = weaponclipsize(self._id_04F6);
}

_id_A634(var_0, var_1) {
  if(!self _meth_81C7()) {
    self _meth_870D(1, 0);
  }
}

_id_A635(var_0, var_1) {
  if(!self _meth_81C7()) {
    self _meth_870D(1, 1);
  }
}

_id_A633(var_0, var_1) {
  if(!self _meth_81C7()) {
    self _meth_870D(0);
  }
}