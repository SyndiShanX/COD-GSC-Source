/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\_zombies_traps.gsc
******************************************************/

init() {
  level._effect["trap_ready"] = loadfx("vfx/zombie/zmb_trap_light_orange");
  level._effect["trap_not_ready"] = loadfx("vfx/zombie/zmb_trap_light_orange_blink");
  level._id_9CD2 = [];
  level._id_9CD2["default"] = [];
  level._id_9CD1 = [];
  level._id_9CD1["ready_to_active"] = "s2_gj_zom_drop_gate_lever_move_down";
  level._id_9CD1["active_to_cooldown"] = "s2_gj_zom_drop_gate_lever_down_idle";
  level._id_9CD1["cooldown_to_active"] = "s2_gj_zom_drop_gate_lever_up_idle";
  level._id_9CCF["no_power"] = ::_id_9CD3;
  level._id_9CCF["ready"] = ::_id_9CD4;
  level._id_9CCF["active"] = ::_id_9CCB;
  level._id_9CCF["cooldown"] = ::_id_9CCD;
  level._id_9CCF["deactivate"] = ::_id_9CCE;
  level._id_5AFF = 0;
  level._id_08C8 = [];
  level thread _id_A8EB();
  level._id_9CFC = common_scripts\utility::_id_46B7("zombie_trap", "targetname");
  common_scripts\utility::_id_0FB2(level._id_9CFC, ::_id_9CAF);
}

_id_9C9E(var_0) {
  var_1 = -1;

  switch (var_0) {
    case "trap_rnd":
      var_1 = 1000;
      break;
    case "trap_roof":
      var_1 = 1000;
      break;
    case "trap_med":
      var_1 = 1000;
      break;
    case "trap_aagun":
      var_1 = 500;
      break;
    case "trap_catacombs":
      var_1 = 1000;
      break;
    case "trap_firewell":
      var_1 = 500;
      break;
    default:
      var_1 = -1;
      break;
  }

  return var_1;
}

_id_9CA6(var_0) {
  var_1 = -1;

  switch (var_0) {
    case "trap_rnd":
      var_1 = 20;
      break;
    case "trap_roof":
      var_1 = 20;
      break;
    case "trap_med":
      var_1 = 20;
      break;
    case "trap_aagun":
      var_1 = 20;
      break;
    case "trap_catacombs":
      var_1 = 20;
      break;
    case "trap_firewell":
      var_1 = 5;
      break;
    default:
      var_1 = -1;
      break;
  }

  return var_1;
}

_id_9C9C(var_0) {
  var_1 = -1;

  switch (var_0) {
    case "trap_rnd":
      var_1 = 30;
      break;
    case "trap_roof":
      var_1 = 30;
      break;
    case "trap_med":
      var_1 = 30;
      break;
    case "trap_aagun":
      var_1 = 30;
      break;
    case "trap_catacombs":
      var_1 = 30;
      break;
    case "trap_firewell":
      var_1 = 20;
      break;
    default:
      var_1 = -1;
      break;
  }

  return var_1;
}

_id_438E() {
  return 25;
}

_id_9CAF(var_0, var_1, var_2, var_3) {
  var_4 = self._id_0165;
  var_5 = _id_9C9E(var_4);

  if(var_5 > 0)
    self._id_267B = var_5;
  else if(isDefined(self._id_8140))
    self._id_267B = self._id_8140;
  else
    self._id_267B = 500;

  var_6 = _id_9C9C(var_4);

  if(var_6 > 0)
    self._id_264F = var_6;
  else if(isDefined(self._id_8260))
    self._id_264F = int(self._id_8260);
  else
    self._id_264F = 40;

  if(!common_scripts\utility::_id_562E(var_0))
    _id_10BB();
  else
    _id_10BC(var_1, var_2, var_3);

  self._id_931A = "none";

  if(_id_9CBF())
    _id_9CC5("no_power");
  else
    _id_9CC5("ready");
}

_id_7BFB(var_0) {
  _id_0559::_id_7BE2(self, var_0._id_9D65, var_0._id_9CBB);
}

_id_10BC(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    thread _id_9C95(var_4);
    thread _id_9CD5(var_4);
  }

  foreach(var_7 in var_1)
  thread _id_9CAD(var_7);

  foreach(var_10 in var_2) {
    thread _id_9C94(var_10);
    self._id_6298 = var_10;
  }
}

_id_10BB() {
  var_0 = getEntArray(self.target, "targetname");
  var_1 = common_scripts\utility::_id_46B7(self.target, "targetname");
  var_2 = common_scripts\utility::_id_0F73(var_0, var_1);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4._id_0165)) {
      continue;
    }
    switch (var_4._id_0165) {
      case "activate_model":
        thread _id_9C94(var_4);
        self._id_6298 = var_4;
        break;
      case "activate":
        thread _id_9C95(var_4);
        thread _id_9CD5(var_4);
        break;
      case "laser":
        thread _id_9CB1(var_4);
        break;
      case "fx_ready":
        thread _id_9CAD(var_4);
        break;
      case "damage":
        thread _id_9CA0(var_4, 0);
        break;
      case "damage_over_time":
        thread _id_9CA0(var_4, 1);
        break;
      case "fx_trap":
        thread _id_9CD0(var_4);
        break;
      case "fx_trap_move":
        thread _id_9CAC(var_4);
        break;
      case "distraction":
        thread _id_9CA4(var_4);
        break;
      case "zomboni":
        thread _id_9CD7(var_4);
        break;
      default:
        break;
    }
  }
}

_id_7BD7(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4))
    var_4 = "default";

  if(!isDefined(level._id_9CD2[var_4]))
    level._id_9CD2[var_4] = [];

  level._id_9CD2[var_4]["no_power"] = var_0;
  level._id_9CD2[var_4]["ready"] = var_1;
  level._id_9CD2[var_4]["active"] = var_2;
  level._id_9CD2[var_4]["cooldown"] = var_3;
  level._id_9CD2[var_4]["deactivate"] = var_0;
}

_id_438F() {
  return 20;
}

_id_9CBF() {
  return isDefined(self._id_81A1);
}

_id_9CAE() {
  if(_id_9CBF())
    return common_scripts\utility::_id_3C77(self._id_81A1);

  return 1;
}

_id_9CC5(var_0) {
  thread _id_0732(var_0);
}

_id_0732(var_0) {
  self notify(var_0);

  if(var_0 != self._id_931A)
    self notify("trap_state_change", var_0);

  self._id_931A = var_0;
  self thread[[level._id_9CCF[var_0]]]();
}

_id_9CD3() {
  self endon("trap_state_change");

  if(!_id_9CAE())
    common_scripts\utility::_id_3C9F(self._id_81A1);

  _id_9CC5("ready");
}

_id_9CCE() {
  self endon("trap_state_change");
  self waittill("trap_reactivated");

  if(!_id_9CAE())
    common_scripts\utility::_id_3C9F(self._id_81A1);

  _id_9CC5("ready");
}

_id_9CD4() {
  self endon("trap_state_change");

  for(;;) {
    self waittill("trap_trigger", var_0, var_1);

    if(var_1 == "token")
      var_0 maps\mp\gametypes\zombies::_id_90F6(self._id_9A84);
    else {
      var_2 = self._id_267B;

      if(isDefined(level._id_6F41)) {
        for(var_3 = 0; var_3 < level._id_6F41; var_3++)
          var_2 = _id_0547::_id_4522(var_2);
      }

      if(!var_0 maps\mp\gametypes\zombies::_id_11C2(var_2)) {
        var_0 thread _id_054E::_id_0695("needmoney");
        continue;
      }

      _id_0547::_id_4AE4(var_0, "trap", var_2, "none", "none");
    }

    var_0._id_9CFF++;
    var_0 thread _id_054E::_id_62D9();
    _id_9C93(var_0, 0);
    break;
  }
}

_id_9C93(var_0, var_1) {
  if(!var_1) {
    _id_0555::_id_83DD("use_trap", var_0);

    if(isDefined(level._id_AAFE))
      level thread[[level._id_AAFE]](self, var_0);
  }

  self._id_0117 = var_0;
  _id_9CC5("active");
}

_id_9CA3() {
  self._id_2A75 = 1;
  _id_9CC5("deactivate");
}

_id_9CBD() {
  self._id_2A75 = undefined;
  self notify("trap_reactivated");
}

_id_9CCB() {
  self endon("trap_state_change");
  self endon("active");
  _id_9CCC();

  if(_id_9CAE())
    _id_9CC5("cooldown");
  else
    _id_9CC5("no_power");
}

_id_9CCC() {
  if(isDefined(self._id_9C96))
    self waittill(self._id_9C96);
  else {
    var_0 = _id_9CA6(self._id_0165);

    if(var_0 > 0)
      var_1 = var_0;
    else if(isDefined(self._id_817A))
      var_1 = self._id_817A;
    else
      var_1 = _id_438F();

    wait(var_1);
  }
}

_id_9CCD() {
  self endon("trap_state_change");
  var_0 = self._id_264F;

  if(isDefined(level._id_9CF6))
    var_0 = level._id_9CF6;

  wait(var_0);

  if(_id_9CAE())
    _id_9CC5("ready");
  else
    _id_9CC5("no_power");
}

_id_9C94(var_0) {
  var_1 = "default";

  for(;;) {
    self waittill("trap_state_change", var_2);
    var_3 = level._id_9CD2[var_1][var_2];

    if(isDefined(var_3))
      var_0 setModel(var_3);

    if(var_2 == "active")
      var_0 thread _id_9CB7();
  }
}

_id_9CB7() {
  if(isDefined(level._id_9CD1["ready_to_active"])) {
    self _meth_8276(level._id_9CD1["ready_to_active"]);
    wait 0.766667;
  }

  if(isDefined(level._id_9CD1["active_to_cooldown"])) {
    self _meth_8276(level._id_9CD1["active_to_cooldown"]);
    wait 1;
  }

  if(isDefined(level._id_9CD1["cooldown_to_active"]))
    self _meth_8276(level._id_9CD1["cooldown_to_active"]);
}

_id_9C95(var_0) {
  for(;;) {
    [var_2, var_3] = var_0 _id_0547::_id_A795();
    self notify("trap_trigger", var_2, var_3);
  }
}

_id_9CD5(var_0) {
  var_1 = self._id_0165;
  var_2 = undefined;

  if(1)
    var_2 = _id_0552::_id_7BFC(var_0);

  var_3 = spawnStruct();
  var_3._id_9CBB = var_1;
  var_3._id_9D65 = var_0;
  level thread maps\mp\_utility::_id_6F74(::_id_7BFB, var_3);

  for(;;) {
    self waittill("trap_state_change", var_4);

    if(1)
      var_2._id_6642 = 1;

    switch (var_4) {
      case "no_power":
        if(0) {
          var_0 _meth_80CE(&"ZOMBIES_REQUIRES_POWER");
          var_0 _meth_80CF(&"ZOMBIES_EMPTY_STRING");
          var_0 _id_0547::_id_9A85(0);
        }

        if(1) {
          var_2._id_9CCA = 0;
          var_2.interact_disabled = 1;
        }

        break;
      case "active":
        if(0) {
          var_0 _meth_80CE(&"ZOMBIES_EMPTY_STRING");
          var_0 _meth_80CF(&"ZOMBIES_EMPTY_STRING");
          var_0 _id_0547::_id_9A85(0);
        }

        if(1) {
          var_2._id_9CCA = 1;
          var_2.interact_disabled = 1;
        }

        break;
      case "cooldown":
        if(0) {
          if(isDefined(self._id_4DAF))
            var_0 _meth_80CE(self._id_4DAF["hint_cooldown"]);
          else
            var_0 _meth_80CE(&"ZOMBIES_TRAP_COOLDOWN");

          var_0 _meth_80CF(&"ZOMBIES_EMPTY_STRING");
          var_0 _id_0547::_id_9A85(0);
        }

        if(1) {
          var_2._id_9C9B = 0;

          if(isDefined(self._id_4DAF))
            var_2._id_9C9B = self._id_4DAF["hint_cooldown_ref"];

          var_2._id_9CCA = 2;
          var_2.interact_disabled = 1;
        }

        break;
      case "ready":
        var_5 = self._id_267B;

        if(isDefined(level._id_6F41)) {
          for(var_6 = 0; var_6 < level._id_6F41; var_6++)
            var_5 = _id_0547::_id_4522(var_5);
        }

        if(0) {
          if(isDefined(self._id_4DAF))
            var_0 _meth_80CE(self._id_4DAF["hint_ready"]);
          else
            var_0 _meth_80CE(&"ZOMBIES_TRAP_BUY_GENERIC");

          var_0 _meth_80CF(_id_0547::_id_4474(var_5));
          var_0 _id_0547::_id_9A85(1);
        }

        if(1) {
          var_2._id_9CBE = 0;

          if(isDefined(self._id_4DAF))
            var_2._id_9CBE = self._id_4DAF["hint_ready_ref"];

          var_2._id_9CCA = 3;
          var_2._id_9C9D = var_5;
          var_2.interact_disabled = undefined;
        }

        break;
      case "deactivate":
        if(0) {
          var_0 _meth_80CE(&"ZOMBIES_REQUIRES_POWER");
          var_0 _meth_80CF(&"ZOMBIES_EMPTY_STRING");
        }

        if(1)
          var_2._id_9CCA = 4;

        break;
      default:
        break;
    }
  }
}

_id_9CAC(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1._id_9255 = var_1.origin;
  var_1._id_9189 = var_1.angles;
  var_1 setModel("tag_origin");
  var_1._id_64AD = [];
  var_2 = [];

  if(isDefined(var_0.target)) {
    var_3 = getEntArray(var_0.target, "targetname");
    var_4 = common_scripts\utility::_id_46B7(var_0.target, "targetname");
    var_2 = common_scripts\utility::_id_0F73(var_3, var_4);
  }

  foreach(var_6 in var_2) {
    if(!isDefined(var_6._id_0165)) {
      continue;
    }
    switch (var_6._id_0165) {
      case "damage_over_time":
      case "damage":
        var_6 _meth_8070();
        var_6 _meth_8055(var_1);
        thread _id_9CA0(var_6, var_6._id_0165 == "damage_over_time", "fx_trap_move");
        break;
      case "moveto":
        var_1 _id_9CB6(var_6);
        break;
      default:
        break;
    }
  }

  for(;;) {
    self waittill("trap_state_change", var_8);
    thread _id_9CBC(var_1, var_8, var_0);

    switch (var_8) {
      case "active":
        thread _id_9CB5(var_1);
        break;
      default:
        break;
    }
  }
}

_id_9CBC(var_0, var_1, var_2) {
  if(isDefined(var_0._id_2935)) {
    _id_0547::_id_9406(var_0._id_2935, var_0, "tag_origin");
    var_0._id_2935 = undefined;
    wait 0.5;
  }

  var_3 = var_2._id_8260 + "_" + var_1;

  if(common_scripts\utility::_id_3F6F(var_3))
    var_0._id_2935 = common_scripts\utility::_id_44F5(var_3);

  if(isDefined(var_0._id_2935))
    _id_0547::_id_74A5(var_0._id_2935, var_0, "tag_origin");
}

_id_9CB6(var_0) {
  while(isDefined(var_0)) {
    self._id_64AD[self._id_64AD.size] = var_0;

    if(isDefined(var_0.target)) {
      var_0 = common_scripts\utility::_id_46B5(var_0.target, "targetname");
      continue;
    }

    var_0 = undefined;
  }
}

_id_9CB1(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1._id_9255 = var_1.origin;
  var_1._id_9189 = var_1.angles;
  var_1 setModel("tag_laser");
  var_1._id_64AD = [];
  var_2 = [];

  if(isDefined(var_0.target)) {
    var_3 = getEntArray(var_0.target, "targetname");
    var_4 = common_scripts\utility::_id_46B7(var_0.target, "targetname");
    var_2 = common_scripts\utility::_id_0F73(var_3, var_4);
  }

  foreach(var_6 in var_2) {
    if(!isDefined(var_6._id_0165)) {
      continue;
    }
    switch (var_6._id_0165) {
      case "damage_over_time":
      case "damage":
        var_6 _meth_8070();
        var_6 _meth_8055(var_1);
        thread _id_9CA0(var_6, var_6._id_0165 == "damage_over_time", "laser");
        break;
      case "moveto":
        var_1 _id_9CB6(var_6);
        break;
      default:
        break;
    }
  }

  for(;;) {
    self waittill("trap_state_change", var_8);

    switch (var_8) {
      case "deactivate":
      case "cooldown":
      case "no_power":
        var_1 _meth_8612("trap_laser_loop");
        var_1 playSound("trap_laser_stop");
        var_1 _meth_80A5();
        break;
      case "active":
        thread _id_9CB5(var_1);
        thread _id_9CB4(var_1);
        break;
      default:
        break;
    }
  }
}

_id_9CB4(var_0) {
  self endon("cooldown");
  self endon("no_power");
  self endon("deactivate");
  self endon("ready");
  var_1 = "trap_warning_zm";

  if(isDefined(level._id_AB15))
    var_1 = level._id_AB15;

  var_2 = "trap_zm";

  if(isDefined(level._id_AB14))
    var_2 = level._id_AB14;

  var_0 _meth_80A4(var_1);
  var_3 = spawn("script_origin", var_0.origin);
  thread _id_9CB2(var_3);
  wait 3;
  thread _id_9CB3(var_3);
  var_0 _meth_80A4(var_2);
  var_0 playSound("trap_laser_start");
  var_0 _meth_861D("trap_laser_loop");
}

_id_9CB2(var_0) {
  if(level._id_5AFF == 0) {
    level._id_5AFF = 1;

    if(isDefined(var_0))
      var_0 _meth_861D("trap_laser_alarm");
  } else {}
}

_id_9CB3(var_0) {
  level._id_5AFF = 0;

  if(isDefined(var_0)) {
    var_0 _meth_8612("trap_laser_alarm");
    var_0 delete();
  }
}

_id_9CB5(var_0) {
  self endon("trap_state_change");

  if(!var_0._id_64AD.size) {
    return;
  }
  var_1 = 60;
  var_2 = 15;
  var_0.origin = var_0._id_9255;
  var_0.angles = var_0._id_9189;
  var_3 = 0;

  for(;;) {
    var_4 = var_0._id_64AD[var_3];
    var_5 = 0;
    var_6 = distance(var_0.origin, var_4.origin);

    if(var_6 > 0)
      var_5 = var_6 / var_1;

    var_7 = 0;

    if(isDefined(var_4.angles)) {
      for(var_8 = 0; var_8 < 3; var_8++) {
        var_9 = _func_0AE(_func_0DC(var_0.angles[var_8]) - _func_0DC(var_4.angles[var_8])) > 0.01;

        if(var_9) {
          var_7 = 0.5 * _func_10F(var_0.angles, var_4.angles);
          break;
        }
      }
    }

    if(!var_5 && var_7)
      var_5 = var_7 / var_2;

    if(var_6 > 0)
      var_0 _meth_82B1(var_4.origin, var_5);

    if(var_7 > 0)
      var_0 _meth_82B8(var_4.angles, var_5);

    if(var_5 > 0)
      wait(var_5);

    var_3++;
    var_3 = var_3 % var_0._id_64AD.size;
  }
}

_id_9CAD(var_0) {
  var_1 = undefined;

  for(;;) {
    self waittill("trap_state_change", var_2);

    switch (var_2) {
      case "no_power":
        if(isDefined(var_1))
          var_1 delete();

        break;
      case "deactivate":
        if(isDefined(var_1))
          var_1 delete();

        break;
      case "ready":
        if(isDefined(var_1))
          var_1 delete();

        var_1 = _func_14B(common_scripts\utility::_id_44F5("trap_ready"), var_0.origin);
        _func_14C(var_1);
        break;
      case "active":
        if(isDefined(var_1))
          var_1 delete();

        var_1 = _func_14B(common_scripts\utility::_id_44F5("trap_not_ready"), var_0.origin);
        _func_14C(var_1);
        break;
      default:
        break;
    }
  }
}

_id_9CA0(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = "default";

  for(;;) {
    self waittill("active");
    _id_9CA2(var_0, var_1, var_2);
  }
}

_id_9CA2(var_0, var_1, var_2) {
  self endon("cooldown");
  self endon("no_power");
  self endon("ready");
  self endon("deactivate");
  var_3 = 1;
  var_4 = 5;

  if(var_2 == "fx_trap_move")
    var_4 = 3;

  var_5 = var_4 / var_3;

  if(isDefined(var_0._id_8140))
    var_5 = var_5 * var_0._id_8140;

  var_6 = 50;

  if(isDefined(var_0._id_8140))
    var_6 = var_6 / var_0._id_8140;

  var_7 = gettime();
  var_8 = "trap_zm_mp";

  if(isDefined(level._id_AB26))
    var_8 = self[[level._id_AB26]](var_0, var_1, var_2);

  for(;;) {
    var_0 waittill("trigger", var_9);
    var_10 = (var_9.origin[0], var_9.origin[1], var_0.origin[2]);

    if(isPlayer(var_9)) {
      if(isDefined(var_0._id_8260) && var_0._id_8260 == "no_player_damage") {
        continue;
      }
      if(isDefined(var_9._id_66D3) && var_9._id_66D3 > gettime()) {
        continue;
      }
      if(var_7 + 3000 > gettime()) {
        continue;
      }
      var_9._id_66D3 = gettime() + 200;

      if(isDefined(level._id_62B5) && isDefined(var_0._id_8140))
        var_9._id_66D3 = gettime() + 200 * var_0._id_8140;

      var_9 _meth_8059(var_6, var_9.origin);
      continue;
    }

    if(isDefined(var_9._id_000A) && var_9._id_000A == level._id_746E) {
      if(isDefined(var_0._id_8260) && var_0._id_8260 == "no_player_damage") {
        continue;
      }
      if(isDefined(var_9._id_66D3) && var_9._id_66D3 > gettime()) {
        continue;
      }
      if(var_7 + 3000 > gettime()) {
        continue;
      }
      var_9._id_66D3 = gettime() + 200;
      var_9 _meth_8059(var_6 * 0.5, var_9.origin);
      continue;
    }

    var_11 = _id_9CA1(var_9, var_10);

    if(var_1) {
      if(!isDefined(var_9.maxhealth)) {
        continue;
      }
      if(isDefined(var_9._id_66D4) && var_9._id_66D4 > gettime()) {
        continue;
      }
      var_9._id_66D4 = gettime() + int(1000 / var_4);
      var_12 = "MOD_TRIGGER_HURT";

      if(isDefined(var_0._id_8140))
        var_12 = "MOD_IMPACT";

      var_13 = int(var_9.maxhealth / var_5);

      if(var_9 _id_0547::_id_580A())
        var_13 = var_13 * 0.1;

      if(_id_0547::_id_5565(self._id_0165, "trap_rnd")) {
        var_9 mark_electrified();
        var_9 _meth_8059(var_13, var_10, level._id_9CC0, level._id_9CC0, var_12, var_8, var_11);
      } else
        var_9 _meth_8059(var_13, var_10, self._id_0117, self._id_0117, var_12, var_8, var_11);
    } else {
      var_13 = var_9.health;

      if(var_9 _id_0547::_id_580A())
        var_13 = var_13 * 0.2;

      var_9 thread mark_electrified();

      if(_id_0547::_id_5565(self._id_0165, "trap_rnd"))
        var_9 _meth_8059(var_13, var_10, level._id_9CC0, level._id_9CC0, "MOD_TRIGGER_HURT", var_8, var_11);
      else
        var_9 _meth_8059(var_13, var_10, self._id_0117, self._id_0117, "MOD_TRIGGER_HURT", var_8, var_11);
    }
  }
}

mark_electrified() {
  self notify("new_mark_electrified");
  self endon("new_mark_electrified");
  self endon("death");
  self.iselectrified = 1;
  childthread unset_zombie_electrified();
}

unset_zombie_electrified() {
  wait 5;
  self.iselectrified = 0;
}

_id_9CA1(var_0, var_1) {
  var_2 = var_1[2] - var_0.origin[2];

  if(var_2 < 32)
    return common_scripts\utility::random(["right_leg_upper", "left_leg_upper"]);
  else if(var_2 < 60)
    return common_scripts\utility::random(["left_arm_upper", "right_arm_upper"]);
  else
    return common_scripts\utility::random(["head", "neck"]);
}

_id_56E6(var_0) {
  return isDefined(var_0) && var_0 == "zombie_trap_barrel";
}

_id_9CD0(var_0) {
  var_1 = undefined;

  for(;;) {
    self waittill("trap_state_change", var_2);

    if(isDefined(var_1))
      var_1 delete();

    var_3 = var_0._id_8260 + "_" + var_2;

    if(common_scripts\utility::_id_3F6F(var_3))
      var_1 = common_scripts\utility::_id_44F5(var_3);

    if(isDefined(var_1)) {
      var_1 = _func_14B(var_1, var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
      _func_14C(var_1);
    }

    thread _id_1365(var_3, var_1, var_0.origin);
  }
}

_id_9CC7(var_0, var_1, var_2, var_3, var_4) {
  var_5 = common_scripts\utility::_id_46B7(var_0, "script_noteworthy");

  foreach(var_7 in var_5) {
    if(!isDefined(var_7._id_4DAF))
      var_7._id_4DAF = [];

    if(0) {
      var_7._id_4DAF["hint_ready"] = var_1;
      var_7._id_4DAF["hint_cooldown"] = var_2;
    }

    if(1 && (isDefined(var_3) || isDefined(var_4))) {
      var_8 = isDefined(var_3);
      var_9 = isDefined(var_4);
      var_7._id_4DAF["hint_ready_ref"] = 0;
      var_7._id_4DAF["hint_cooldown_ref"] = 0;
      var_10 = _func_27A("mp/zombieCustomTrapInteract.csv");

      for(var_11 = 0; var_11 < var_10; var_11++) {
        var_12 = _func_1AE("mp/zombieCustomTrapInteract.csv", var_11, 1);

        if(var_8 && var_12 == var_3) {
          var_7._id_4DAF["hint_ready_ref"] = int(_func_1AE("mp/zombieCustomTrapInteract.csv", var_11, 0));
          var_8 = 0;
        } else if(var_9 && var_12 == var_4) {
          var_7._id_4DAF["hint_cooldown_ref"] = int(_func_1AE("mp/zombieCustomTrapInteract.csv", var_11, 0));
          var_9 = 0;
        }

        if(!var_8 && !var_9) {
          break;
        }
      }
    }
  }
}

_id_9CC6(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::_id_46B7(var_0, "script_noteworthy");

  foreach(var_7, var_5 in var_3)
  var_5 thread _id_9C9F(var_1, var_2);
}

_id_9C9F(var_0, var_1) {
  var_2 = self;

  for(;;) {
    var_2 waittill("trap_state_change", var_3);

    if(var_3 == var_0)
      thread[[var_1]](var_2);
  }
}

_id_9CA4(var_0) {
  for(;;) {
    self waittill("active");
    var_1 = spawn("script_model", var_0.origin);
    var_1._id_4883 = var_1.origin;
    var_1.team = level._id_746E;

    if(isDefined(var_0._id_8260)) {
      if(_func_30D(var_0._id_8260))
        var_1._id_6081 = _func_0DA(int(var_0._id_8260));
    }

    if(isDefined(var_0._id_8140))
      var_1._id_607A = var_0._id_8140;

    var_1._id_5809 = 1;
    var_1._id_0A54 = 0;
    level notify("trap_lure_activated", var_1);
    level._id_08C8[level._id_08C8.size] = var_1;
    common_scripts\utility::_id_A70A("cooldown", "no_power", "ready", "deactivate");

    if(!isDefined(var_1)) {
      continue;
    }
    level._id_08C8 = common_scripts\utility::_id_0F93(level._id_08C8, var_1);
    var_1 delete();
  }
}

_id_A8EB() {
  for(;;) {
    level waittill("spawned_agent", var_0);

    if(isDefined(var_0._id_000A) && isDefined(level._id_746E) && var_0._id_000A == level._id_746E) {
      continue;
    }
    var_0 thread _id_AC6B();
  }
}

_id_AC6B() {
  self endon("death");

  for(;;) {
    while(level._id_08C8.size > 0) {
      var_0 = undefined;

      foreach(var_2 in level._id_08C8) {
        if(!_id_21CB(var_2)) {
          continue;
        }
        var_3 = _func_211(var_2.origin, self.origin);

        if(isDefined(var_2._id_6081))
          var_4 = var_2._id_6081;
        else
          var_4 = 2250000;

        if(var_3 < var_4) {
          var_0 = var_2;
          break;
        }
      }

      if(isDefined(var_0)) {
        self._id_3043 = var_0;
        self._id_3044 = 0;

        if(isDefined(var_0._id_0A54)) {
          var_0._id_0A54++;
          thread _id_5F51(var_0);
        }

        var_0 common_scripts\utility::_id_A70A("death", "stop");
        self._id_3043 = undefined;
        waittillframeend;
        continue;
      }

      self._id_3043 = undefined;
      waitframe();
    }

    level waittill("trap_lure_activated");
  }
}

_id_5F51(var_0) {
  self waittill("death");

  if(isDefined(var_0))
    var_0._id_0A54--;
}

_id_21CB(var_0) {
  if(!isDefined(var_0._id_5809) || !var_0._id_5809)
    return 1;

  var_1 = 4;

  if(isDefined(var_0._id_607A))
    var_1 = var_0._id_607A;

  if(var_0._id_0A54 > var_1)
    return 0;

  if(_id_0547::_id_580A())
    return 0;

  return 1;
}

_id_1365(var_0, var_1, var_2) {
  var_3 = var_0;

  if(isDefined(var_3) && _func_344(var_3)) {
    if(isDefined(var_1))
      _id_046C::_id_8DA2(var_3, var_1);
    else
      _id_046C::_id_8DA0(var_3, var_2);
  }

  var_4 = var_0 + "_lp";

  if(isDefined(var_4) && _func_344(var_4)) {
    if(isDefined(var_1))
      _id_046C::_id_8DA4(var_4, var_1, 0.25);
  }
}

_id_9CEC() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_7382();
  }
}

_id_7382() {
  self endon("disconnect");
  thread _id_7383();

  for(;;) {
    if(self._id_5B66 < gettime())
      self._id_5B45 = self.origin;

    waitframe();
  }
}

_id_7383() {
  self._id_5B66 = 0;

  for(;;) {
    self waittill("unresolved_collision");
    self._id_5B66 = gettime();
  }
}

_id_9CD7(var_0) {
  if(!isDefined(level._id_AC79)) {
    _func_162("zombie_ark_zomboni_trap");
    level._id_AC79 = 1;
    _func_0F8("zomboni");
    level._effect["chompy_churn"] = loadfx("vfx/gameplay/mp/zombie/dlc_chompy_churn");
    level._effect["chompy_lights"] = loadfx("vfx/gameplay/mp/zombie/dlc_chompy_lights");
    level thread _id_9CEC();
  }

  self._id_9C96 = "zomboni_done";
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("vehicle_ind_zomboni_ai");
  var_1.angles = var_0.angles;
  var_1._id_5D96 = 1;
  var_1 _meth_8134(level._id_746E);
  var_1 _meth_8173("zomboni");
  var_1._id_116C = [];
  var_2 = 40;
  var_3 = 150;
  var_4 = 45;
  var_5 = [["tag_zom_attach_1", "left"], ["tag_zom_attach_2", "right"], ["tag_zom_attach_3", "rear"]];

  foreach(var_12, var_7 in var_5) {
    var_8 = var_7[0];
    var_9 = var_7[1];
    var_10 = var_1 gettagorigin(var_8);
    var_11 = spawn("script_model", var_10);
    var_11.angles = var_1 _meth_8181(var_8);
    var_11 setModel("tag_origin");
    var_11 _meth_8055(var_1, var_8);
    var_11._id_4836 = var_2;
    var_11._id_5983 = var_3;
    var_11._id_1173 = var_4;
    var_11._id_116E = var_9;
    var_11._id_0E18 = var_12;
    var_1._id_116C[var_1._id_116C.size] = var_11;
    thread _id_9CDB(var_11);
  }

  var_1._id_5869 = 1;
  var_13 = getEntArray(var_0.target, "targetname");
  var_14 = common_scripts\utility::_id_46B7(var_0.target, "targetname");
  var_15 = common_scripts\utility::_id_0F73(var_13, var_14);
  var_1._id_3290 = [];

  foreach(var_17 in var_15) {
    if(!isDefined(var_17._id_0165)) {
      continue;
    }
    switch (var_17._id_0165) {
      case "clip":
        var_17._id_A045 = ::_id_9CEE;
        var_17._id_AC77 = var_1;
        var_1._id_241F = var_17;
        var_17 _meth_8055(var_1);
        break;
      case "kill_trigger":
        var_17 _meth_8070();
        var_17 _meth_8055(var_1);
        var_1.killtrigger = var_17;
        break;
      case "door":
        var_17._id_2438 = var_17.origin;
        var_17._id_6BED = var_17._id_2438 + (0, 0, 60);
        var_1._id_3290[var_1._id_3290.size] = var_17;
        break;
      default:
        break;
    }
  }

  while(!_func_0FA("zombies"))
    waitframe();

  for(;;) {
    _func_0FF("zomboni", "zombies");
    self waittill("active");
    var_1._id_57E4 = 0;
    _func_147(common_scripts\utility::_id_44F5("chompy_lights"), var_1, "tag_body");
    var_1 _meth_8495("zombie_ark_zomboni_trap", var_0.origin, var_0.angles, "zomboni_anim");
    thread _id_9CE4(var_1);
    thread _id_9CF4(var_1);
    _func_0FD("zomboni", "zombies", 2000);
    thread _id_9CE3(var_1);
    var_1 waittill("end");
    self notify("zomboni_done");
    _func_149(common_scripts\utility::_id_44F5("chompy_lights"), var_1, "tag_body");
    var_1 _meth_8277();
    var_1.origin = var_0.origin;
    var_1.angles = var_0.angles;
  }
}

_id_9CEA(var_0) {
  self endon("zomboni_done");

  for(;;) {
    var_1 = _id_9CE0(var_0);

    foreach(var_3 in var_1) {}

    waitframe();
  }
}

_id_9CE0(var_0, var_1) {
  var_2 = [];
  var_3 = [(-16, 16, 56), (0, 16, 56), (18, 16, 56), (-16, -22, 56), (0, -22, 56), (18, -22, 56), (-16, -60, 56), (0, -60, 56), (18, -60, 56)];
  var_4 = _func_18E("zomboni_room_volume", "targetname");
  var_5 = var_0 gettagorigin("body_animate_jnt");
  var_5 = (var_5[0], var_5[1], var_0.origin[2]);

  foreach(var_7 in var_3) {
    var_8 = spawnStruct();
    var_8.origin = var_5 + _func_112(var_7, var_0.angles + (0, -90, 0));

    if(!isDefined(var_4) || !_func_21B(var_8.origin, var_4))
      var_2[var_2.size] = var_8;
  }

  var_10 = _func_0B8(var_5, 200, 0, 100);
  var_11 = anglesToForward(var_0.angles);

  foreach(var_13 in var_10) {
    var_14 = vectorNormalize(var_13.origin - var_5);

    if(vectordot(var_11, var_14) < 0)
      var_2[var_2.size] = var_13;
  }

  if(isDefined(var_1)) {
    var_8 = spawnStruct();
    var_8.origin = var_1._id_5B45;
    var_2[var_2.size] = var_8;
  }

  return var_2;
}

_id_9CEE(var_0) {
  self._id_A048 = _id_9CE0(self._id_AC77, var_0);
  _id_0488::_id_A047(var_0, 0);
}

_id_9CDB(var_0) {
  level._id_9CDB = 0;

  for(;;) {
    waitframe();

    if(!common_scripts\utility::_id_562E(level._id_9CDB)) {
      continue;
    }
    var_1 = var_0._id_1180;
    var_2 = (1, 1, 0);
    var_3 = (1, 1, 1);

    if(isDefined(var_1)) {
      var_2 = (1, 0, 0);
      var_3 = (1, 0, 0);
    }

    maps\mp\bots\_bots_util::_id_19B8(var_0.origin, var_0._id_4836, var_2, 0, 16);
    maps\mp\bots\_bots_util::_id_19B8(var_0.origin, var_0._id_5983, var_3, 0, 16);
  }
}

_id_9CEB(var_0) {
  self endon("zomboni_done");

  if(!isDefined(var_0._id_241F)) {
    return;
  }
  for(;;) {
    var_1 = 0;

    foreach(var_3 in level.players) {
      var_4 = var_3 _meth_8551();

      if(isDefined(var_4) && var_4 == var_0._id_241F) {
        var_1 = 1;
        break;
      }
    }

    if(var_1 && !var_0._id_57E4) {
      var_0 _meth_84CA(1);
      var_0._id_57E4 = 1;
    } else if(!var_1 && var_0._id_57E4) {
      var_0 _meth_84CA(0);
      var_0._id_57E4 = 0;
    }

    waitframe();
  }
}

_id_9CE1(var_0) {
  foreach(var_2 in level.players) {
    if(_id_9CE2(var_2, var_0))
      return 1;
  }

  return 0;
}

_id_9CE2(var_0, var_1) {
  var_2 = var_0 _meth_8551();

  if(!isDefined(var_2))
    return 0;

  return var_2 == var_1._id_241F;
}

_id_9CF4(var_0) {
  self endon("zomboni_done");
  var_0._id_5985 = 0;

  foreach(var_2 in var_0._id_116C) {
    var_2._id_1180 = undefined;
    var_2._id_66D2 = 0;
  }

  for(;;) {
    waitframe();

    if(!var_0._id_5985) {
      continue;
    }
    foreach(var_5 in _func_2D1()) {
      if(isDefined(var_5._id_66D8) && var_5._id_66D8 > gettime()) {
        continue;
      }
      var_5._id_66D8 = gettime() + _func_0A4(1, 5) * 50;

      if(!isalive(var_5)) {
        continue;
      }
      if(isPlayer(var_5)) {
        continue;
      }
      if(!var_5 _id_0547::_id_4B2C()) {
        continue;
      }
      if(!_func_2BF(var_5) || var_5._id_0A4B == "zombie_dog") {
        continue;
      }
      if(var_5 _id_0547::_id_580A()) {
        continue;
      }
      if(var_5 maps\mp\agents\_scripted_agent_anim_util::_id_57E2()) {
        continue;
      }
      if(!isDefined(var_5._id_0088)) {
        continue;
      }
      if(var_5._id_0088 != var_0) {
        if(!isPlayer(var_5._id_0088)) {
          continue;
        }
        if(!_id_9CE2(var_5._id_0088, var_0))
          continue;
      }

      var_6 = undefined;
      var_7 = undefined;

      foreach(var_2 in var_0._id_116C) {
        if(isDefined(var_2._id_1180)) {
          continue;
        }
        if(var_2._id_66D2 > gettime()) {
          continue;
        }
        var_9 = anglesToForward(var_2.angles);
        var_10 = var_2._id_5983 * var_2._id_5983;
        var_11 = anglesToForward(var_5.angles);

        if(vectordot(var_11, var_9) < 0.1) {
          continue;
        }
        var_12 = vectorNormalize(var_0.origin - var_5.origin);

        if(vectordot(var_12, var_11) < 0.1) {
          continue;
        }
        var_13 = distancesquared(var_2.origin, var_5.origin);

        if(var_13 < var_10) {
          if(!isDefined(var_6) || var_13 < var_7) {
            var_6 = var_2;
            var_7 = var_13;
          }
        }
      }

      if(isDefined(var_6))
        thread _id_9CEF(var_0, var_5, var_6);
    }
  }
}

_id_9CDA(var_0, var_1, var_2) {
  var_1._id_1180 = var_2;
  common_scripts\utility::_id_A70C(self, "zomboni_done", var_2, "death");
  var_1._id_66D2 = gettime() + _func_0A4(1000, 3000);
  var_1._id_1180 = undefined;
}

_id_9CEF(var_0, var_1, var_2) {
  var_1 endon("death");
  thread _id_9CDA(var_0, var_2, var_1);
  var_1 _meth_83A2(1);
  var_1 maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "AttackZomboni");
  var_1 _meth_839D("noclip");
  _id_9CF0(var_0, var_1, var_2);
  var_1 _meth_83A2(0);
  var_1 maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "AttackZomboni");
}

_id_9CF0(var_0, var_1, var_2) {
  self endon("zomboni_done");
  var_1._id_AC77 = var_0;
  var_1._id_1167 = var_2;
  var_3 = "zomboni_attack_get_on";
  var_4 = 0.67;
  var_5 = distance(var_1.origin, var_2.origin);

  if(var_5 > var_2._id_4836)
    var_3 = "zomboni_attack_leap_on";

  var_6 = var_2._id_0E18;
  var_1 _meth_839A(0, 1);
  var_1 _meth_855A(var_4, var_4, var_2, "tag_origin");
  var_1 maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_3, var_6, 1.0, "scripted_anim");
  var_1 _meth_839A(1, 1);

  for(;;) {
    var_3 = "zomboni_attack_zomboni";

    if(_id_9CE1(var_0))
      var_3 = "zomboni_attack_player";

    var_6 = var_2._id_0E18;
    var_1 maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_3, var_6, 1.0, "scripted_anim", undefined, ::_id_9CF1);
    var_3 = "zomboni_attack_idle";
    var_6 = var_2._id_0E18;
    var_1 maps\mp\agents\_scripted_agent_anim_util::_id_8415(var_3, var_6, 1.0);
    wait(_func_0A5(1.0, 2.5));
  }
}

_id_9CF1(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "hit":
      var_4 = [];

      foreach(var_6 in level.players) {
        var_7 = var_6 _meth_8551();

        if(isDefined(var_7) && var_7 == self._id_AC77._id_241F) {
          var_8 = _func_0E1(self._id_1167.origin, var_6.origin);

          if(var_8 < self._id_1167._id_1173)
            var_4[var_4.size] = var_6;
        }
      }

      foreach(var_6 in var_4) {
        self notify("attack_hit", var_6, var_6.origin);
        var_11 = 0;

        if(isDefined(self._id_60E2))
          var_11 = self._id_60E2;

        if(isalive(var_6))
          maps\mp\agents\humanoid\_humanoid_melee::_id_3210(var_6, var_11, "MOD_IMPACT");
      }

      break;
    default:
      break;
  }
}

_id_9CE4(var_0) {
  self endon("zomboni_done");

  for(;;) {
    var_0 waittill("zomboni_anim", var_1);

    switch (var_1) {
      case "door_open":
        foreach(var_3 in var_0._id_3290)
        _id_9CDF(var_3, 1.0);

        break;
      case "door_close":
        foreach(var_3 in var_0._id_3290)
        _id_9CDE(var_3, 1.0);

        break;
      case "tag_hood_left":
        self notify("tag_hood_left");
        break;
      case "end":
        var_0 notify("end");
        break;
      case "enable_jumpon":
        var_0._id_5985 = 1;

        foreach(var_8 in var_0._id_116C)
        var_8._id_66D2 = gettime() + _func_0A4(0, 2000);

        break;
      case "disable_jumpon":
        var_0._id_5985 = 0;
        break;
      case "damage_rear":
      case "damage_left":
      case "damage_right":
      case "damage_sides":
        thread _id_9CDC(var_0, var_1);
        break;
      default:
        break;
    }
  }
}

_id_9CDC(var_0, var_1) {
  var_2 = [];
  var_2["damage_left"] = ["left"];
  var_2["damage_right"] = ["right"];
  var_2["damage_rear"] = ["rear"];
  var_2["damage_sides"] = ["left", "right"];
  var_3 = var_2[var_1];

  foreach(var_5 in var_3) {
    foreach(var_7 in var_0._id_116C) {
      if(isDefined(var_7._id_1180) && var_7._id_116E == var_5) {
        var_8 = var_7._id_1180;
        var_8 _meth_8059(var_8.health, var_8.origin, self._id_0117, var_0, "MOD_TRIGGER_HURT", "trap_zm_mp");
      }
    }
  }
}

_id_9CD9(var_0) {
  self endon("zomboni_done");
  self endon("tag_hood_left");
  wait 2;

  for(;;) {
    var_1 = var_0 gettagorigin("tag_hood");
    thread _id_9CD8(var_1, 7);
    wait 3;
  }
}

_id_9CD8(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2._id_4883 = var_0;
  var_2.team = level._id_746E;
  var_2._id_6081 = 640000;
  var_2._id_607A = 6;
  var_2._id_5809 = 1;
  var_2._id_0A54 = 0;
  var_2._id_08BE = 1;
  level notify("distraction_drone_activated", var_2);
  level._id_AAF4[level._id_AAF4.size] = var_2;
  wait(var_1);
  level._id_AAF4 = common_scripts\utility::_id_0F93(level._id_AAF4, var_2);
  var_2._id_08BE = 0;
  var_2 notify("stop");
}

_id_9CDF(var_0, var_1) {
  var_0 _meth_82B1(var_0._id_6BED, var_1);
}

_id_9CDE(var_0, var_1) {
  var_0 _meth_82B1(var_0._id_2438, var_1);
}

_id_9CE3(var_0) {
  self endon("zomboni_done");

  for(;;) {
    var_0.killtrigger waittill("trigger", var_1);

    if(!isalive(var_1)) {
      continue;
    }
    if(var_1 _id_0547::_id_580A()) {
      continue;
    }
    if(isDefined(var_1._id_66D3) && var_1._id_66D3 > gettime()) {
      continue;
    }
    if(var_0._id_57E4) {
      continue;
    }
    var_1._id_66D3 = gettime() + 200;

    if(isPlayer(var_1)) {
      var_1 _meth_8059(10, var_1.origin, undefined, var_0);
      continue;
    }

    thread _id_9CE8(var_0);

    if(!_func_2BF(var_1) || var_1._id_0A4B == "zombie_dog") {
      var_1 _meth_8059(var_1.health, var_1.origin, self._id_0117, var_0, "MOD_TRIGGER_HURT", "trap_zm_mp");
      continue;
    }

    _id_9CED(var_0, var_1);
  }
}

_id_9CE8(var_0) {
  var_0 notify("play_churn_fx");
  var_0 endon("play_churn_fx");

  if(!common_scripts\utility::_id_562E(var_0._id_22DE))
    _func_147(common_scripts\utility::_id_44F5("chompy_churn"), var_0, "tag_body");

  var_0._id_22DE = 1;
  wait 5;
  var_0._id_22DE = 0;
  _func_148(common_scripts\utility::_id_44F5("chompy_churn"), var_0, "tag_body");
}

_id_9CED(var_0, var_1) {
  if(common_scripts\utility::_id_562E(var_1._id_AC78))
    return 1;

  if(var_1 maps\mp\agents\_scripted_agent_anim_util::_id_57E2())
    return 0;

  thread _id_9CF2(var_0, var_1);
  return 1;
}

_id_9CF2(var_0, var_1) {
  var_1 notify("killanimscript");
  var_1._id_AC78 = 1;
  var_1 _meth_839C("anim deltas");
  var_1 _meth_839A(1, 1);
  var_1 _meth_839D("noclip");
  var_2 = _func_0DD(var_0.angles[1] - var_1.angles[1]);
  var_3 = "zomboni_trap_victim";
  var_4 = var_1 _meth_83DB(var_3);
  var_5 = 0;

  if(_func_0AE(var_2) < 45) {
    var_5 = 3;

    if(var_4 > 3 && common_scripts\utility::_id_24A6())
      var_5 = 4;
  } else if(var_2 < 135)
    var_5 = 2;
  else if(var_2 > -135)
    var_5 = 1;

  var_6 = undefined;
  var_7 = undefined;
  var_8 = ["tag_zom_align_center", "tag_zom_align_right", "tag_zom_align_left"];

  foreach(var_10 in var_8) {
    var_11 = var_0 gettagorigin(var_10);
    var_12 = _func_0E1(var_11, var_1.origin);

    if(!isDefined(var_6) || var_12 < var_7) {
      var_6 = var_10;
      var_7 = var_12;
    }
  }

  var_1._id_480F = 1;
  var_1 _meth_83A2(1);
  var_1 maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "SynchronizedAnim");
  var_1 _meth_839D("noclip");
  var_1 _meth_855A(0.5, 0.5, var_0, var_6);
  var_1 maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_3, var_5, 1.0, "scripted_anim", undefined, ::_id_9CF3);
  var_1._id_480F = 0;
  var_1._id_1DEB = 1;
  var_1 _meth_8059(var_1.health, var_1.origin, self._id_0117, var_0, "MOD_TRIGGER_HURT", "trap_zm_mp");
}

_id_9CF3(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "remove_head":
      var_4 = _id_0541::_id_5E60("head");
      _id_0541::_id_65D0(self._id_6250 | var_4, 1, 1, (0, 0, 1), 0);
      break;
    case "remove_arms":
      var_5 = _id_0541::_id_5E60("right_arm_lower");
      var_6 = _id_0541::_id_5E60("left_arm_lower");
      var_7 = common_scripts\utility::random([var_5, var_6, var_5 | var_6]);
      _id_0541::_id_65D0(self._id_6250 | var_7, 1, 1, (0, 0, 1), 0);
      break;
    case "remove_legs":
      var_8 = _id_0541::_id_5E60("right_leg_lower");
      var_9 = _id_0541::_id_5E60("left_leg_lower");
      var_10 = common_scripts\utility::random([var_8, var_9, var_8 | var_9]);
      _id_0541::_id_65D0(self._id_6250 | var_10, 1, 1, (0, 0, 1), 0);
      break;
    default:
      break;
  }
}

_id_9CE9(var_0, var_1) {
  var_0._id_6ECB = [];
  var_0._id_6801 = [];
  var_2 = var_1.origin;
  var_3 = 0;
  var_4 = undefined;
  var_5 = 0;
  var_6 = undefined;

  while(isDefined(var_1)) {
    var_7 = _id_9CE5(var_1);

    foreach(var_9 in var_7) {
      if(!isDefined(var_9._id_0165)) {
        continue;
      }
      switch (var_9._id_0165) {
        case "door":
          var_9._id_2438 = var_9.origin;
          var_9._id_6BED = var_9._id_2438 + (0, 0, 60);
          break;
        case "distraction":
          var_9._id_08BE = 0;
          break;
        default:
          break;
      }
    }

    var_11 = var_0 _meth_827B(var_1)[0];

    if((!isDefined(var_4) || distance(var_4.origin, var_11) > 400) && distance(var_2, var_11) > 300) {
      var_1._id_3042 = spawnStruct();
      var_1._id_3042.origin = var_11;
      var_4 = var_1._id_3042;
    }

    if(isDefined(var_6))
      var_5 = var_5 + distance(var_1.origin, var_6.origin);

    var_1._id_6ED9 = var_5;
    var_0._id_6ECB[var_0._id_6ECB.size] = var_1;

    if(isDefined(var_1._id_0165)) {
      var_1._id_6764 = strtok(var_1._id_0165, ",");
      var_0._id_6801[var_0._id_6801.size] = var_1;

      foreach(var_13 in var_1._id_6764) {
        switch (var_13) {
          case "door_close":
            var_3 = !var_3;
            break;
          default:
            break;
        }
      }
    }

    if(isDefined(var_1.target)) {
      var_6 = var_1;
      var_1 = _func_1DB(var_1.target, "targetname");
      continue;
    }

    break;
  }

  var_0._id_6ED9 = var_5;
}

_id_9CE6(var_0, var_1) {
  self endon("zomboni_done");
  var_1 waittill("trigger");
  var_1 notify("passed", var_0);
  var_0 notify("passed_node", var_1);
  var_1._id_6EAA = 1;
}

_id_9CE7(var_0, var_1) {
  self endon("zomboni_done");

  for(;;) {
    var_1 waittill("trigger");

    foreach(var_3 in var_1._id_6764) {
      switch (var_3) {
        case "door_open":
          var_4 = 1;
          var_0 _id_AC7B();
          var_5 = _id_9CE5(var_1, "door");

          foreach(var_7 in var_5)
          thread _id_9CDF(var_7, var_4);

          wait(var_4);
          var_0 _id_AC7A();
          break;
        case "door_close":
          var_9 = 1;
          var_5 = _id_9CE5(var_1, "door");

          foreach(var_7 in var_5)
          thread _id_9CDE(var_7, var_9);

          break;
        case "end":
          var_0 notify("end");
          break;
        default:
          break;
      }
    }
  }
}

_id_9CDD(var_0, var_1) {
  var_2 = 2000;

  if(var_0._id_6ED9 > var_2) {
    for(;;) {
      var_1 waittill("passed_node", var_3);

      if(var_0._id_6ED9 - var_3._id_6ED9 < var_2) {
        break;
      }
    }
  }

  self._id_4883 = self.origin;
  self.team = level._id_746E;
  self._id_6081 = 640000;
  self._id_607A = 6;
  self._id_5809 = 1;
  self._id_0A54 = 0;
  self._id_08BE = 1;
  level notify("distraction_drone_activated", self);
  level._id_AAF4[level._id_AAF4.size] = self;
  var_0 waittill("passed");
  level._id_AAF4 = common_scripts\utility::_id_0F93(level._id_AAF4, self);
  self._id_08BE = 0;
  self notify("stop");
}

_id_9CE5(var_0, var_1) {
  var_2 = [];

  if(isDefined(var_0.script_exploder)) {
    var_3 = strtok(var_0.script_exploder, " ");

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_5 = _func_18E(var_3[var_4], "script_linkname");

      if(isDefined(var_5)) {
        if(!isDefined(var_1) || isDefined(var_5._id_0165) && var_5._id_0165 == var_1)
          var_2[var_2.size] = var_5;
      }
    }
  }

  return var_2;
}

_id_AC7B() {
  self _meth_8280(0, 100, 100);
}

_id_AC7A() {
  self _meth_8293(100);
}

_id_0904(var_0) {
  if(!isDefined(level._id_6667))
    level._id_6667 = [];

  level._id_6667 common_scripts\utility::_id_0972(level._id_6667, var_0);
}