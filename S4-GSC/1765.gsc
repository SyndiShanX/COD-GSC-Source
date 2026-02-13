/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1765.gsc
*************************************************/

_id_BB93() {
  _id_C1C1("takedamage", 1, "$self", ::_id_D3D3, "$value");
  _id_456C("takedamage", "$self", ::_id_4595);
  _id_C1C1("allowdeath", 1, "$self", ::_id_D143, "$value");
  _id_456C("allowdeath", "$self", ::_id_455E);
  _id_C1C1("magic_bullet_shield", 1, "$self", ::_id_D285, "$value");
  _id_456C("magic_bullet_shield", "$self", ::_id_4577);
  _id_94E8("magic_bullet_shield", "allowdeath", ::_id_9954);
  _id_94E8("magic_bullet_shield", "attackeraccuracy", ::_id_9955);
  _id_C1C1("attackeraccuracy", 1);
  _id_459C("attackeraccuracy", 1);
  _id_C1C1("ignoreme", 1, "$self", ::_id_D259, "$value");
  _id_459C("ignoreme", 0);
  _id_C1C1("ignoreall", 1, "$self", ::_id_D258, "$value");
  _id_459C("ignoreall", 0);
  _id_C1C1("take_weapons", 1, "$self", ::_id_D3D4, "$value");
  _id_459C("take_weapons", 0);
  _id_C1C1("disable_weapons", 1, "$self", ::_id_D1DB, "$value");
  _id_459C("disable_weapons", 0);
  _id_C1C1("disable_weapon_cycling", 1, "$self", ::_id_D1D7, "$value");
  _id_459C("disable_weapon_cycling", 0);
  _id_C1C1("disable_weapon_reload", 1, "$self", ::_id_D1DA, "$value");
  _id_459C("disable_weapon_reload", 0);
  _id_C1C1("disable_weapon_pickup", 1, "$self", ::_id_D1D9, "$value");
  _id_459C("disable_weapon_pickup", 0);
  _id_C1C1("disable_weapon_fire", 1, "$self", ::_id_D1D8, "$value");
  _id_459C("disable_weapon_fire", 0);
  _id_C1C1("disable_offhand_weapons", 1, "$self", ::_id_D1D5, "$value");
  _id_459C("disable_offhand_weapons", 0);
  _id_C1C1("disable_offhand_special", 1, "$self", ::_id_D1D3, "$value");
  _id_459C("disable_offhand_special", 0);
  _id_C1C1("disable_aim_assist", 1, "$self", ::_id_D1D1, "$value");
  _id_459C("disable_aim_assist", 0);
  _id_C1C1("disable_usability", 1, "$self", ::_id_D1D6, "$value");
  _id_459C("disable_usability", 0);
  _id_C1C1("freezecontrols", 1, "$self", ::_id_D218, "$value");
  _id_459C("freezecontrols", 0);
  _id_C1C1("hide", 1, "$self", ::_id_D246, "$value");
  _id_459C("hide", 0);
  _id_C1C1("health_regen", 1, "$self", ::_id_D243, "$value");
  _id_459C("health_regen", 1);
  _id_C1C1("disable_health_regen_delay", 1, "$self", ::_id_D1D2, "$value");
  _id_459C("disable_health_regen_delay", 0);
  _id_C1C1("ignore_health_regen_delay", 1, "$self", ::_id_D257, "$value");
  _id_459C("ignore_health_regen_delay", 0);
  _id_C1C1("show_hud", 1, "$self", ::set_hud_visible, "$value");
  _id_459C("show_hud", 1);
  _id_C1C1("show_hit_marker", 1, "$self", ::_id_D39F, "$value");
  _id_459C("show_hit_marker", 1);
  _id_C1C1("disable_gestures", 1, "$self", ::_id_D1D4, "$value");
  _id_459C("disable_gestures", 0);
  _id_C1C1("allow_jump", 1, "$self", ::set_allowjump, "$value");
  _id_459C("allow_jump", 1);
  _id_C1C1("allow_double_jump", 1, "$self", ::set_allowdoublejump, "$value");
  _id_459C("allow_double_jump", 1);
  _id_C1C1("allow_crouch", 1, "$self", ::set_allowcrouch, "$value");
  _id_459C("allow_crouch", 1);
  _id_C1C1("allow_prone", 1, "$self", ::set_allowprone, "$value");
  _id_459C("allow_prone", 1);
  _id_C1C1("allow_melee", 1, "$self", ::set_allowmelee, "$value");
  _id_459C("allow_melee", 1);
  _id_C1C1("allow_melee_victim", 1, "$self", ::_id_1555, "$value");
  _id_459C("allow_melee_victim", 1);
  _id_C1C1("allow_mantle", 1, "$self", ::set_allowmantle, "$value");
  _id_459C("allow_mantle", 1);
  _id_C1C1("allow_sprint", 1, "$self", ::set_allowsprint, "$value");
  _id_459C("allow_sprint", 1);
  _id_C1C1("allow_super_sprint", 1, "$self", ::set_allowsupersprint, "$value");
  _id_459C("allow_super_sprint", 1);
  _id_C1C1("allow_ads", 1, "$self", ::set_allowads, "$value");
  _id_459C("allow_ads", 1);
  _id_C1C1("allow_stand", 1, "$self", ::set_allowstand, "$value");
  _id_459C("allow_stand", 1);
  _id_C1C1("allow_movement", 1, "$self", ::set_allowmovement, "$value");
  _id_459C("allow_movement", 1);
  _id_C1C1("move_speed_scale", 1, "$self", ::set_movespeedscale, "$value");
  _id_459C("move_speed_scale", 1);
  _id_C1C1("goalradius", 2048, "$self", ::_id_D232, "$value");
  _id_459C("goalradius", 2048);
  _id_C1C1("push_player", 1, "$self", ::set_pushplayer, "$value");
  _id_459C("push_player", 0);
  _id_C1C1("skip_death", 1, "$self", ::_id_D3A2, "$value");
  _id_459C("skip_death", 0);
  _id_C1C1("skip_scene_death", 1, "$self", ::_id_D3A3, "$value");
  _id_459C("skip_scene_death", 0);
}

_id_C1C1(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level._id_FF6E)) {
    level._id_FF6E = [];
  }

  var_5 = getarraykeys(level._id_FF6E);

  if(scripts\engine\utility::array_contains(var_5, var_0)) {
    return;
  }
  if(isDefined(var_4) && !_func_0107(var_4)) {
    var_4 = [var_4];
  }

  if(!isDefined(var_4)) {
    var_4 = [];
  }

  var_6 = spawnStruct();
  var_6._id_E9E5 = var_0;
  var_6._id_2F14 = var_2;
  var_6._id_6016 = var_3;
  var_6._id_4588 = var_1;
  var_6._id_0DE5 = var_4;
  level._id_FF6E[var_0] = var_6;
}

_id_1CEB(var_0) {
  return 1;
}

_id_456C(var_0, var_1, var_2, var_3) {
  if(_id_1CEB(var_0)) {
    if(isDefined(var_3) && !_func_0107(var_3)) {
      var_3 = [var_3];
    }

    if(!isDefined(var_3)) {
      var_3 = [];
    }

    var_4 = level._id_FF6E[var_0];
    var_4._id_4562 = var_1;
    var_4._id_459C = var_2;
    var_4._id_4560 = var_3;
  }
}

_id_459C(var_0, var_1) {
  if(_id_1CEB(var_0)) {
    var_2 = level._id_FF6E[var_0];
    var_2._id_459C = var_1;
  }
}

_id_94E8(var_0, var_1, var_2) {
  if(_id_1CEB(var_0)) {
    var_3 = level._id_FF6E[var_0];
    var_4 = spawnStruct();
    var_4.name = var_1;
    var_4._id_6016 = var_2;
    var_3._id_9511[var_1] = var_4;
  }
}

_id_D12B(var_0, var_1, var_2) {
  if(_id_1CEB(var_1)) {
    if(!isDefined(var_2)) {
      var_2 = level._id_FF6E[var_1]._id_4588;
    }

    _id_0CA6(var_0, var_1, var_2);
    _id_0CE0(var_1, var_2);
  }

  if(_func_0107(level._id_FF6E[var_1]._id_9511)) {
    foreach(var_4 in level._id_FF6E[var_1]._id_9511) {
      _id_D12B(var_0, var_4.name, [[var_4._id_6016]](var_2));
    }
  }
}

_id_D36C(var_0, var_1) {
  _id_D12B("radiant", var_0, var_1);
}

_id_D20E(var_0, var_1, var_2, var_3) {
  self endon("death");
  _id_D12B(var_1, var_2, var_3);
  wait(var_0);
  _id_C5F9(var_1, var_2);
}

_id_C5F9(var_0, var_1) {
  var_2 = _id_0CB8(var_0, var_1);

  if(!var_2) {
    if(isDefined(self._id_FF6E) && isDefined(self._id_FF6E[var_1]) && self._id_FF6E[var_1].size > 0) {
      _id_0CE0(var_1, self._id_FF6E[var_1][0]._id_04CB);
    } else {
      _id_0CDE(var_1);
    }
  }

  if(_func_0107(level._id_FF6E[var_1]._id_9511)) {
    foreach(var_4 in level._id_FF6E[var_1]._id_9511) {
      _id_C5F9(var_0, var_4.name);
    }
  }
}

_id_C5A1(var_0) {
  if(!isDefined(self._id_FF6E)) {
    return;
  }
  var_1 = _func_0457(self._id_FF6E);

  foreach(var_7, var_3 in var_1) {
    foreach(var_5 in var_3) {
      if(isDefined(var_5._id_E9E3) && var_5._id_E9E3 == var_0) {
        _id_C5F9(var_0, var_7);
      }
    }
  }
}

_id_C5DF(var_0) {
  _id_C5F9("radiant", var_0);
}

_id_A6E5(var_0) {
  self._id_FF6E[var_0] = [];
  _id_0CDE(var_0);
}

_id_0CA6(var_0, var_1, var_2) {
  _id_0CB8(var_0, var_1);

  if(!isDefined(self._id_FF6E)) {
    self._id_FF6E = [];
  }

  if(!isDefined(self._id_FF6E[var_1])) {
    self._id_FF6E[var_1] = [];
  }

  var_3 = spawnStruct();
  var_3._id_E9E3 = var_0;
  var_3._id_04CB = var_2;
  self._id_FF6E[var_1] = ::scripts\engine\utility::_id_1BB3(self._id_FF6E[var_1], var_3, 0);
}

_id_0CB8(var_0, var_1) {
  if(!isDefined(self)) {
    return -1;
  }

  var_2 = undefined;

  if(isDefined(self._id_FF6E) && isDefined(self._id_FF6E[var_1])) {
    for(var_2 = self._id_FF6E[var_1].size - 1; var_2 >= 0; var_2--) {
      if(self._id_FF6E[var_1][var_2]._id_E9E3 == var_0) {
        self._id_FF6E[var_1] = ::scripts\engine\utility::array_remove_index(self._id_FF6E[var_1], var_2);
        break;
      }
    }

    if(!self._id_FF6E[var_1].size) {
      self._id_FF6E[var_1] = undefined;

      if(!self._id_FF6E.size) {
        self._id_FF6E = undefined;
      }
    }
  }

  return scripts\engine\utility::ter_op(isDefined(var_2), var_2, -1);
}

_id_0CE0(var_0, var_1) {
  var_2 = level._id_FF6E[var_0];

  if(isDefined(var_2) && isDefined(var_2._id_6016)) {
    var_3 = scripts\engine\utility::ter_op(_func_0121(var_2._id_2F14) && var_2._id_2F14 == "$self", self, var_2._id_2F14);
    scripts\engine\utility::_id_DD57(var_3, var_2._id_6016, _id_0CBC(var_2._id_0DE5, var_1));
  } else
    _id_0C17(var_0, var_1);
}

_id_0CDE(var_0) {
  var_1 = level._id_FF6E[var_0];

  if(isDefined(var_1._id_459C)) {
    if(_func_03AC(var_1._id_459C)) {
      var_2 = scripts\engine\utility::ter_op(_func_0121(var_1._id_4562) && var_1._id_4562 == "$self", self, var_1._id_4562);
      var_3 = scripts\engine\utility::_id_DD57(var_2, var_1._id_459C, _id_0CBC(var_1._id_4560));
    } else
      var_3 = var_1._id_459C;

    _id_0CE0(var_0, var_3);
  }
}

_id_0CBB(var_0, var_1, var_2) {
  foreach(var_5, var_4 in var_0) {
    if(_func_0121(var_4) && var_4 == var_1) {
      var_0[var_5] = var_2;
    }
  }

  return var_0;
}

_id_0CBC(var_0, var_1) {
  var_0 = _id_0CBB(var_0, "$self", self);
  var_0 = _id_0CBB(var_0, "$value", var_1);
  return var_0;
}

_id_D3D3(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(isPlayer(self)) {
    return;
  }
  self._id_047D = var_0;
  return;
}

_id_4595() {
  return _func_011D(self) || scripts\common\vehicle::_id_8AF5();
}

_id_D143(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self._id_0040 = var_0;
}

_id_455E() {
  return _func_011D(self) || scripts\common\vehicle::_id_8AF5();
}

_id_D285(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self._id_992D = var_0;
}

_id_4577() {
  self._id_992D = undefined;
}

_id_9954(var_0) {
  return !var_0;
}

_id_9955(var_0) {
  return scripts\engine\utility::ter_op(var_0, 0.1, 1);
}

_id_FF3F() {
  if(isPlayer(self)) {
    return !self _meth_854E();
  } else {
    return self._id_047D;
  }
}

_id_D3D4(var_0) {}

_id_D1DB(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0 != 0) {
    self disableweapons(scripts\engine\utility::ter_op(_func_02B7(var_0) && var_0 == 2, 1, 0));
  } else {
    self enableweapons();
  }
}

_id_D1D7(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    self disableweaponswitch();
  } else {
    self enableweaponswitch();
  }
}

_id_D1D8(var_0) {}

_id_D1DA(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    self allowreload(0);
  } else {
    self allowreload(1);
  }
}

_id_D1D9(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    self disableweaponpickup();
  } else {
    self enableweaponpickup();
  }
}

_id_D1D5(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    self disableoffhandweapons();
  } else {
    self enableoffhandweapons();
  }
}

_id_D1D3(var_0) {}

_id_D1D1(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  setsaveddvar("#x32e89d8775345bc4a", var_0);
}

_id_D1D6(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    self disableusability();
  } else {
    self enableusability();
  }
}

_id_D259(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self.ignoreme = var_0;
}

_id_D258(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self._id_0229 = var_0;
}

_id_D39F(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    self._id_A58D = undefined;
  } else {
    self._id_A58D = 1;
  }
}

_id_D1D4(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(isPlayer(self)) {
    self._id_4ABA = var_0;
  }
}

_id_D246(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    if(var_0 == 1) {
      self hide();
    } else {
      self hide();
    }
  } else
    self show();
}

_id_D243(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    self._id_7622._id_523F = 1;
  } else {
    self._id_7622._id_523F = 0;
  }
}

_id_D1D2(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    self._id_4A08 = 1;
  } else {
    self._id_4A08 = 0;
  }
}

_id_D257(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    self._id_7D09 = 1;
  } else {
    self._id_7D09 = 0;
  }
}

_id_D232(var_0) {
  if(isDefined(var_0)) {
    self._id_0201 = var_0;
  } else if(isDefined(self._id_0359)) {
    self._id_0201 = float(self._id_0359);
  } else if(isDefined(self._id_03E9._id_0359)) {
    self._id_0201 = float(self._id_03E9._id_0359);
  } else {
    self._id_0201 = 2048;
  }
}

_id_D3A2(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self._id_DDA5 = scripts\engine\utility::ter_op(var_0, 1, 0);
}

_id_D3A3(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self._id_DDC6 = scripts\engine\utility::ter_op(var_0, 1, undefined);
}

_id_D218(var_0) {
  self freezecontrols(var_0);
}

set_hud_visible(var_0) {
  if(var_0) {
    var_0 = 0;
  } else {
    var_0 = 1;
  }

  self setclientomnvar("ui_hide_hud", var_0);
}

_id_1555(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self._id_314B = scripts\engine\utility::ter_op(var_0, 1, 0);
}

set_allowjump(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self allowjump(var_0);
}

set_allowdoublejump(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self allowdoublejump(var_0);
}

set_allowcrouch(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self allowcrouch(var_0);
}

set_allowprone(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self allowprone(var_0);
}

set_allowmelee(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self allowmelee(var_0);
}

set_allowmantle(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self allowmantle(var_0);
}

set_allowsprint(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self allowsprint(var_0);
}

set_allowsupersprint(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self _meth_86CD(var_0);
}

set_allowads(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self allowads(var_0);
}

set_allowstand(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self allowstand(var_0);
}

set_allowmovement(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self allowmovement(var_0);
}

set_movespeedscale(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self setmovespeedscale(var_0);
}

set_pushplayer(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self _meth_8285(var_0);
}

_id_5F5A(var_0, var_1) {
  if(var_1) {
    _id_D12B(var_0, "disable_weapon_fire", var_1);
    _id_D12B(var_0, "disable_offhand_weapons", var_1);
    _id_D12B(var_0, "allow_movement", !var_1);
    _id_D12B(var_0, "allow_jump", !var_1);
    _id_D12B(var_0, "allow_melee", !var_1);
    _id_D12B(var_0, "allow_sprint", !var_1);
    _id_D12B(var_0, "allow_prone", !var_1);
  } else {
    _id_C5F9(var_0, "disable_weapon_fire");
    _id_C5F9(var_0, "disable_offhand_weapons");
    _id_C5F9(var_0, "allow_movement");
    _id_C5F9(var_0, "allow_jump");
    _id_C5F9(var_0, "allow_melee");
    _id_C5F9(var_0, "allow_sprint");
    _id_C5F9(var_0, "allow_prone");
  }
}

_id_5F5B(var_0, var_1) {
  if(var_1) {
    _id_D12B(var_0, "disable_offhand_weapons", var_1);
    _id_D12B(var_0, "allow_movement", !var_1);
    _id_D12B(var_0, "allow_jump", !var_1);
    _id_D12B(var_0, "allow_melee", !var_1);
    _id_D12B(var_0, "allow_sprint", !var_1);
  } else {
    _id_C5F9(var_0, "disable_offhand_weapons");
    _id_C5F9(var_0, "allow_movement");
    _id_C5F9(var_0, "allow_jump");
    _id_C5F9(var_0, "allow_melee");
    _id_C5F9(var_0, "allow_sprint");
  }
}

_id_0C16(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "allowdeath":
      var_1 = self._id_0040;
      break;
    case "magic_bullet_shield":
      var_1 = self._id_992D;
      break;
    case "attackeraccuracy":
      var_1 = self._id_0074;
      break;
    case "disable_weapons":
      var_1 = self._id_4A72;
      break;
    case "disable_weapon_cycling":
      var_1 = self._id_4A6C;
      break;
    case "disable_weapon_reload":
      var_1 = self._id_4A70;
      break;
    case "freezecontrols":
      var_1 = self._id_5F62;
      break;
    case "ignoreme":
      var_1 = self.ignoreme;
      break;
    case "show_hud":
      var_1 = self._id_DC48;
      break;
    case "disable_weapon_fire":
      var_1 = self._id_4A6D;
      break;
    case "disable_offhand_weapons":
      var_1 = self._id_4A2C;
      break;
    case "allow_movement":
      var_1 = self._id_1559;
      break;
    case "allow_jump":
      var_1 = self._id_154E;
      break;
    case "allow_melee":
      var_1 = self._id_1554;
      break;
    case "allow_sprint":
      var_1 = self._id_1581;
      break;
    case "allow_prone":
      var_1 = self._id_1570;
      break;
    default:
      break;
  }

  return var_1;
}

_id_0C17(var_0, var_1) {
  var_1 = undefined;

  switch (var_0) {
    case "allowdeath":
      self._id_0040 = var_1;
      break;
    case "magic_bullet_shield":
      self._id_992D = var_1;
      break;
    case "attackeraccuracy":
      self._id_0074 = var_1;
      break;
    case "disable_weapons":
      self._id_4A72 = var_1;
      break;
    case "disable_weapon_cycling":
      self._id_4A6C = var_1;
      break;
    case "disable_weapon_reload":
      self._id_4A70 = var_1;
      break;
    case "freezecontrols":
      self._id_5F62 = var_1;
      break;
    case "ignoreme":
      self.ignoreme = var_1;
      break;
    case "show_hud":
      self._id_DC48 = var_1;
      break;
    case "disable_weapon_fire":
      self._id_4A6D = var_1;
      break;
    case "disable_offhand_weapons":
      self._id_4A2C = var_1;
      break;
    case "allow_movement":
      self._id_1559 = var_1;
      break;
    case "allow_jump":
      self._id_154E = var_1;
      break;
    case "allow_melee":
      self._id_1554 = var_1;
      break;
    case "allow_sprint":
      self._id_1581 = var_1;
      break;
    case "allow_prone":
      self._id_1570 = var_1;
      break;
    default:
      break;
  }
}