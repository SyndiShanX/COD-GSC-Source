/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2499.gsc
*************************************************/

_giveweapon(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = -1;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  self giveweapon(var_0, var_1, istrue(var_2), -1, var_3);
}

_switchtoweapon(var_0) {
  self switchtoweapon(var_0);
}

_switchtoweaponimmediate(var_0) {
  self switchtoweaponimmediate(var_0);
}

_takeweapon(var_0) {
  var_1 = 0;

  if(isweapon(var_0)) {
    var_1 = self _meth_858A() == var_0;
  } else {
    var_1 = getcompleteweaponname(self _meth_858A()) == var_0;
  }

  if(var_1) {
    var_2 = scripts\engine\utility::ter_op(_func_0121(var_0), var_0, getcompleteweaponname(var_0));
    self _meth_858D(var_0);
  }

  self takeweapon(var_0);
}

_id_EDDF(var_0) {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    var_1 = 0;

    if(!_id_87E0(var_0)) {
      var_2 = self _meth_854D();

      if(!isnullweapon(var_2) && self._id_0133 == var_2) {
        var_1 = 0;
      } else {
        var_1 = 1;
      }
    }

    if(var_1) {
      break;
    }

    waitframe();
  }

  _takeweapon(var_0);
}

_id_69A6() {
  _id_FF49();
  var_0 = self _meth_858A();

  if(isnullweapon(var_0)) {
    return undefined;
  }

  return var_0;
}

_id_8755() {
  return isDefined(_id_69A6());
}

_id_8A86(var_0) {
  if(_func_0121(var_0)) {
    var_0 = makeweaponfromstring(var_0);
  }

  var_1 = _id_69A6();
  return isDefined(var_1) && var_1 == var_0 && !_id_87E0(var_0);
}

_id_317E(var_0, var_1) {
  if(!self hasweapon(var_0)) {
    return 0;
  }

  if(!scripts\common\utility::_id_871C()) {
    return 0;
  }

  if(!istrue(var_1) && !scripts\common\utility::_id_8724() && !scripts\common\utility::_id_86AC()) {
    return 0;
  }

  var_2 = _id_69A6();

  if(isDefined(var_2)) {
    var_3 = getweaponbasename(var_0);
    var_4 = 0;

    if(var_3 == "briefcase_bomb_mp" || var_3 == "briefcase_bomb_defuse_mp" || var_3 == "iw8_cyberemp_mp" || var_3 == "iw7_tdefball_mp" || var_3 == "s4_bomb_remote_mp" || var_3 == "s4_remote_bomb_defuse_mp" || var_3 == "s4_bomb_remote_holiday_mp" || var_3 == "s4_remote_bomb_defuse_holiday_mp" || var_0 == "s4_remote_bomb_defuse_vday_mp") {
      var_4 = 1;
    } else if(_func_0276(var_2) == "primary") {
      var_4 = 1;
    }

    if(!var_4) {
      return 0;
    }
  }

  if(_id_87E0(var_0)) {
    return 0;
  }

  return 1;
}

_id_0E0C(var_0) {
  if(self _meth_858A() == var_0) {
    self _meth_858D(var_0);
  }

  _takeweapon(var_0);
  return;
}

domonitoredweaponswitch(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("death");

  if(!_id_317E(var_0, var_2)) {
    return 0;
  }

  if(_id_8755()) {
    self _meth_858D(_id_69A6());
  }

  self _meth_858C(var_0);

  if(istrue(var_1)) {
    _switchtoweaponimmediate(var_0);
  }

  for(;;) {
    if(_id_87E0(var_0)) {
      _id_FF49();
      return 1;
    }

    if(!self _meth_858B(var_0) || !self hasweapon(var_0)) {
      return 0;
    }

    if(!scripts\common\utility::_id_871C() || !istrue(var_2) && !scripts\common\utility::_id_8724() && !scripts\common\utility::_id_86AC()) {
      self _meth_858D(var_0);
      return 0;
    }

    waitframe();
  }
}

_id_FF49() {
  var_0 = self getcurrentweapon();

  if(self _meth_858B(var_0)) {
    self _meth_858D(var_0);
  }
}

_id_6CF7(var_0, var_1) {
  self endon("death");
  self endon("disconnect");

  if(!self hasweapon(var_0)) {
    return 0;
  }

  if(!_id_87E0(var_0)) {
    _takeweapon(var_0);
    return 1;
  }

  while(_id_8755()) {
    waitframe();
  }

  if(!_id_87E0(var_0)) {
    _takeweapon(var_0);
    return 1;
  }

  var_2 = domonitoredweaponswitch(self._id_8FC2, var_1);

  if(isbot(self)) {
    self switchtoweaponimmediate(_func_0375());
    var_2 = 1;
  }

  _takeweapon(var_0);
  self notify("bomb_allow_offhands");

  if(!var_2) {
    _id_5ED6();
  }

  return 1;
}

_id_5ED6(var_0) {
  self endon("death");
  self endon("disconnect");

  while(isnullweapon(self getcurrentweapon())) {
    if(self isswitchingweapon() || _id_8755()) {
      waitframe();
      continue;
    }

    var_1 = _id_69A9();
    var_2 = var_0;

    if(!isDefined(var_2) || !self hasweapon(var_2)) {
      if(!isDefined(self._id_8FC2) || self._id_8FC2.basename == "none") {
        break;
      }

      if(self hasweapon(self._id_8FC2)) {
        var_2 = self._id_8FC2;
      } else if(var_1.size > 0) {
        var_2 = var_1[0];
      }
    }

    if(isDefined(var_2) && getweaponbasename(var_2) == "iw7_axe_mp" && self getweaponammoclip(var_2) == 0 && var_1.size == 1) {
      var_2.basename = "iw8_fists_mp";
    }

    domonitoredweaponswitch(var_2);
    waitframe();
  }
}

_id_87E0(var_0) {
  if(_func_0121(var_0)) {
    var_0 = makeweaponfromstring(var_0);
  }

  return issameweapon(self getcurrentweapon(), var_0, 1);
}

_id_69A9() {
  var_0 = [];
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(!var_3._id_0245) {
      var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}