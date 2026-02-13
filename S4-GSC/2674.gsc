/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2674.gsc
*************************************************/

_id_E921() {
  var_0 = self._id_9021;
  var_1 = _func_0375();

  if(scripts\mp\utility\weapon::_id_88F9(var_0) || scripts\mp\utility\weapon::_id_8A7D(var_0) || scripts\mp\utility\weapon::_id_88F6(var_0) || scripts\mp\utility\weapon::_id_8876(var_0) || _id_080B::_id_8A09(var_0.basename) || scripts\mp\utility\weapon::_id_8A38(var_0.basename) || !_id_E92C(var_0) || var_0.basename == "s4_gw_flima35_mp" || var_0.basename == "s4_me_fists_mp") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/SUPPORT_BOX_INCOMPAT");
    }

    return 0;
  }

  var_2 = _id_E923();

  if(!istrue(var_2)) {
    return 0;
  }

  if(self _meth_8543(var_0)) {
    var_1 = var_0;
    var_0 = var_0 _meth_8628();
  } else
    var_1 = var_0 getaltweapon();

  var_3 = [];
  var_4 = 0;
  var_5 = 0;

  if(!isnullweapon(var_1)) {
    var_3[var_3.size] = var_1;
  }

  var_3[var_3.size] = var_0;

  foreach(var_7 in var_3) {
    var_8 = 0;

    if(var_7 _meth_8624("akimbo", 1)) {
      var_8 = 1;
    }

    if(issameweapon(var_7, var_0, 0)) {
      var_9 = scripts\mp\weapons::_id_68BB(var_7);
      var_10 = var_9 * 1;

      if(var_8) {
        var_10 = var_10 * 2;
      }

      thread _id_E92A(self, var_7, var_10);

      if(1) {
        if(var_8) {
          var_9 = self getweaponammoclip(var_7, "left") + self getweaponammoclip(var_7, "right");
          var_4 = self getweaponammostock(var_7);
          var_11 = var_9 + var_4;
          var_12 = int(min(weaponmaxammo(var_7), var_11 + var_10));
          self setweaponammostock(var_7, var_12);
          self setweaponammoclip(var_7, 0, "left");
          self setweaponammoclip(var_7, 0, "right");
        } else {
          var_9 = self getweaponammoclip(var_7);
          var_4 = self getweaponammostock(var_7);
          var_11 = var_9 + var_4;
          var_13 = weaponmaxammo(var_7);
          var_14 = var_11 + var_10;
          var_5 = int(var_14 - var_13);
          var_15 = int(min(var_13, var_14));

          if(var_7.basename == "iw8_lm_dblmg_mp") {
            self setweaponammoclip(var_7, var_9 + var_10);
          } else {
            self setweaponammostock(var_7, var_15);
            self setweaponammoclip(var_7, 0);
          }
        }
      }
    }
  }

  thread _id_E931(var_0, var_4, var_5);
  return 1;
}

_id_E92C(var_0) {
  if(!self _meth_8543(var_0)) {
    return 1;
  }

  var_1 = var_0._id_04B7;
  return scripts\mp\weapons::_id_876C(var_1);
}

_id_E931(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  for(;;) {
    if(self getcurrentprimaryweapon() != var_0) {
      break;
    }

    var_3 = self getweaponammoclip(var_0);

    if(var_3 > 0) {
      thread scripts\mp\hud_message::showsplash("stopping_power_loaded");

      if(var_2 > 0) {
        self setweaponammostock(var_0, var_1 + var_2);
      }

      break;
    }

    waitframe();
  }

  var_4 = 0;

  if(self._id_EB09._id_E76B._id_C189 == "super_ammo_resupply_drop") {
    var_4 = 1;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]](undefined, undefined, undefined, var_4);
  }
}

_id_E92A(var_0, var_1, var_2) {
  if(!isDefined(var_0._id_75D9)) {
    var_0._id_75D9 = [];
  } else {
    var_3 = var_0._id_75D9[var_1.basename];

    if(isDefined(var_3)) {
      var_3 thread _id_E92F();
    }
  }

  var_4 = spawnStruct();
  var_4.player = var_0;
  var_4.objweapon = var_1;
  var_4._id_C947 = var_2;
  var_4._id_6280 = 0;
  var_4._id_0267 = 0;
  var_0._id_75D9[var_1.basename] = var_4;
  var_4 thread _id_E926();
  var_4 thread _id_E927();
  var_4 thread _id_E928();
  var_4 thread _id_E929();
  var_0 thread _id_E922();
  var_4 thread _id_E932();
  var_4 thread _id_E933();
  return var_4;
}

_id_E923() {
  self endon("death_or_disconnect");
  self cancelreload();
  wait 0.05;
  return 1;
}

_id_E932() {
  self endon("stoppingPower_removeHCR");
  self.player endon("disconnect");

  while(self.player hasweapon(self.objweapon)) {
    if(_id_E92B(self.player getcurrentweapon())) {
      if(!self._id_6280) {
        self.player scripts\mp\utility\perk::_id_6FC2("specialty_bulletdamage");
        self._id_6280 = 1;
      }
    } else if(self._id_6280) {
      self.player scripts\mp\utility\perk::removeperk("specialty_bulletdamage");
      self._id_6280 = 0;
    }

    self.player waittill("weapon_change");
  }

  thread _id_E92F();
}

_id_E933() {
  self endon("stoppingPower_removeHCR");
  self.player endon("disconnect");

  while(self.player hasweapon(self.objweapon)) {
    self.player waittill("weapon_fired", var_0);

    if(_id_E92B(var_0)) {
      self._id_C947--;

      if(self._id_C947 <= 0) {
        break;
      }
    }
  }

  self.player thread _id_E930(self.objweapon);
  thread _id_E92F();
}

_id_E930(var_0) {
  self endon("disconnect");

  if(!isDefined(self)) {
    return;
  }
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);

  if(var_1 != "s4_ar_stango44") {
    return;
  }
  self._id_8FB4 = 1;
  scripts\engine\utility::_id_108AF(2, "weapon_fired", "weapon_change");
  self._id_8FB4 = undefined;
}

_id_E92F() {
  self notify("stoppingPower_removeHCR");

  if(isDefined(self.player)) {
    if(self._id_6280) {
      self.player scripts\mp\utility\perk::removeperk("specialty_bulletdamage");
    }

    _id_E925();
  }
}

_id_E92D() {
  self notify("stoppingPower_removeHCR");

  if(isDefined(self.player)) {
    _id_E925();
  }
}

_id_E925() {
  if(isDefined(self.player._id_75D9)) {
    var_0 = self.objweapon.basename;
    var_1 = self.player._id_75D9[var_0];

    if(var_1 == self) {
      self.player._id_75D9[var_0] = undefined;
    }

    self.player _id_07BC::_id_AAE7("super_support_box", self._id_0267);
    _id_07A9::_id_9768(self.player, level._id_EB2B._id_E76D["super_support_box"]._id_7C8C, self._id_0267, 0);
  }
}

_id_E92E(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0.basename;
    var_2 = self._id_75D9[var_1];

    if(isDefined(var_2)) {
      scripts\mp\utility\stats::_id_7DAE("stoppingPowerKills", 1);
      scripts\mp\supers::_id_3AC0("super_support_box");
      var_2._id_0267++;
    }
  }
}

_id_E92B(var_0) {
  var_1 = self.player _meth_810A(self.objweapon);
  var_2 = self.player _meth_810A(var_0);
  var_3 = var_1 == var_2;
  return issameweapon(var_0, self.objweapon, 1) && var_3;
}

_id_E926() {
  self.player endon("disconnect");
  self endon("stoppingPower_removeHCR");
  self.player waittill("death");
  thread _id_E92F();
}

_id_E927() {
  self.player endon("disconnect");
  self endon("stoppingPower_removeHCR");
  level waittill("game_ended");
  thread _id_E92F();
}

_id_E928() {
  self.player endon("disconnect");
  self endon("stoppingPower_removeHCR");
  self.player waittill("all_perks_cleared");
  thread _id_E92D();
}

_id_E929() {
  self.player endon("death_or_disconnect");
  self.player scripts\mp\utility\perk::_id_6FC2("specialty_fastreload");
  self.player scripts\engine\utility::waittill_any_3("weapon_fired", "weapon_change", "stoppingPower_removeHCR");
  self.player scripts\mp\utility\perk::removeperk("specialty_fastreload");
}

_id_E922() {
  self endon("death_or_disconnect");
  scripts\common\utility::_id_1581(0);
  wait 0.4;
  scripts\common\utility::_id_1581(1);
}