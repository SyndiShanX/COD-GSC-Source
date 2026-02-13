/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_weapons.gsc
*************************************************/

_id_4053(var_0, var_1, var_2) {
  var_3 = scripts\engine\trace::ray_trace(var_0, (var_0[0], var_0[1], var_0[2] - 60));
  var_4 = var_0;

  if(var_3["fraction"] < 1.0) {
    var_4 = var_3["position"] + (0, 0, 2);
  }

  if(!isDefined(var_1)) {
    var_1 = (0, 0, 90);
  }

  var_0 = var_4;

  if(isDefined(var_1)) {
    var_1 = var_1;
  } else {
    var_1 = (0, 0, 90);
  }

  return _id_3FC1(var_2, var_4, var_1, 1);
}

_id_4054(var_0, var_1) {
  var_2 = var_0;
  var_3 = scripts\engine\trace::ray_trace(var_0, (var_0[0], var_0[1], var_0[2] - 60));

  if(var_3["fraction"] < 1.0) {
    var_2 = var_3["position"] + (0, 0, 2);
  }

  return _id_3FC1(var_1, var_2, (0, 0, 90), 1);
}

_id_EA65() {
  var_0 = undefined;
  var_1 = undefined;

  foreach(var_3 in self._id_019F) {
    var_4 = scripts\mp\utility\weapon::getweaponrootname(var_3.basename);

    if(var_4 != "s4_me_fists" && var_4 != "iw8_knifestab") {
      if(isweapon(var_3) && var_3._id_0241 == "primary") {
        var_5 = scripts\mp\utility\weapon::getweaponrootname(self._id_0132);

        if(var_4 == var_5) {
          var_0 = var_3;
        } else {
          var_1 = var_3;
        }
      }
    }
  }

  if(isDefined(var_0)) {
    var_7 = scripts\mp\utility\weapon::getweaponrootname(var_0.basename);
  }

  if(isDefined(var_1)) {
    var_8 = scripts\mp\utility\weapon::getweaponrootname(var_1.basename);
  }

  if(isDefined(var_0) || isDefined(var_1)) {
    if(isDefined(var_0)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    }

    if(isDefined(var_1)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);
    }

    scripts\cp_mp\utility\inventory_utility::_giveweapon("s4_me_fists_mp");
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("s4_me_fists_mp");
  }
}

_id_B69E(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in self._id_019F) {
    var_5 = scripts\mp\utility\weapon::getweaponrootname(var_4.basename);

    if(var_5 != "s4_me_fists" && var_5 != "iw8_knifestab") {
      if(isweapon(var_4) && var_4._id_0241 == "primary") {
        var_6 = scripts\mp\utility\weapon::getweaponrootname(self._id_0132);

        if(var_5 == var_6) {
          iprintln("PRIMARY IS " + var_5);
          var_1 = var_4;
        } else
          var_2 = var_4;
      }
    }
  }

  var_8 = undefined;
  var_9 = undefined;
  var_10 = "";
  var_11 = "";

  if(isDefined(var_1)) {
    var_10 = scripts\mp\utility\weapon::getweaponrootname(var_1.basename);
  }

  if(isDefined(var_2)) {
    var_11 = scripts\mp\utility\weapon::getweaponrootname(var_2.basename);
  }

  if(var_0 == var_10) {
    var_8 = var_1;
    var_9 = var_2;
  } else if(var_0 == var_11) {
    var_8 = var_2;
    var_9 = var_1;
  }

  var_12 = 0;

  if(isDefined(var_8)) {
    var_13 = self getweaponammoclip(var_8);
    [var_15, var_16, var_17] = ::scripts\mp\gametypes\br_pickups::_id_6ACD(0, self.origin, self.angles, self);
    var_18 = _id_3FC1(var_8, var_15, var_16, 0);
    var_18._id_011A = var_13;
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_8);

    if(isDefined(var_9)) {
      scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_9);
    } else {
      scripts\cp_mp\utility\inventory_utility::_giveweapon("s4_me_fists_mp");
      scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("s4_me_fists_mp");
    }

    _id_2A0C(self);
  }
}

_id_3FC1(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_0.basename == "s4_me_rindigo_mp") {
    var_2 = (var_2[0] - 90, var_2[1], var_2[2]);
  }

  return _id_10DD7(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_10DD7(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_1 == (0, 0, 0)) {
    return;
  }
  var_6 = getcompleteweaponname(var_0);
  return scripts\mp\gametypes\br_pickups::_id_E336(var_6, var_1, var_2, 0, var_4, var_5, var_0);
}

_id_EDDC(var_0) {
  var_1 = self.primaryweapons.size;

  if(!isDefined(var_0._id_04F6)) {
    var_2 = [];
    var_3 = undefined;

    if(isDefined(var_0._id_427F)) {
      var_4 = var_0._id_427F;
      var_3 = makeweaponfromstring(var_4);
    } else if(!isDefined(var_0._id_3B38)) {
      var_3 = scripts\mp\gametypes\br_pickups::_id_6A5D(var_0, self);
      var_4 = getcompleteweaponname(var_3);
    } else {
      var_3 = scripts\mp\class::buildweapon(var_0._id_9688, var_2, "none", "none", -1);
      var_4 = var_0._id_9688;
    }

    var_5 = scripts\mp\utility\weapon::getweaponrootname(var_4);
    var_6 = var_4;
  } else {
    var_3 = var_0._id_04F6;

    if(isDefined(var_0._id_9688)) {
      var_6 = var_0._id_9688;
    } else {
      var_6 = _func_00D6(var_3.classname, 7, var_3.classname.size);
    }

    var_5 = scripts\mp\utility\weapon::getweaponrootname(var_6);
  }

  var_7 = 0;
  var_8 = undefined;

  foreach(var_10 in self.primaryweapons) {
    if(isnullweapon(var_10)) {
      var_1--;
      continue;
    }

    if(issameweapon(var_10, var_3) && !scripts\mp\utility\game::_id_875D()) {
      var_7 = 1;
      var_8 = var_10;
    }
  }

  if(var_1 > 1) {
    if(!self hasweapon("s4_me_fists_mp")) {
      var_7 = 1;
    } else {
      self takeweapon("s4_me_fists_mp");
    }
  }

  if(scripts\mp\utility\game::_id_875D()) {
    var_12 = scripts\mp\gametypes\arena_evo_tourney_weapon_util::_id_1A9D(var_3);

    if(var_12) {
      var_7 = 0;
    }
  }

  if(var_7) {
    if(!isDefined(var_8)) {
      var_8 = self._id_8FC2;
    }

    if(var_8.basename != "none") {
      var_13 = self getweaponammoclip(var_8);

      if(!_id_080B::_id_8A09(var_8)) {
        var_14 = self getweaponammostock(var_8);
        var_15 = _id_2A07(var_8);

        if(isDefined(var_15)) {
          self._id_29F9[var_15] = var_14;
        }
      }

      var_16 = var_0.origin - self.origin;
      var_17 = _func_0261(var_16);
      var_18 = _id_3FC1(var_8, var_0.origin, (0, var_17, 0), 0);

      if(isDefined(var_18)) {
        var_18._id_011A = var_13;
        var_19 = 1;
        scripts\mp\gametypes\br_analytics::_id_2AFC(self, var_8.basename, var_19, var_13);
      }

      scripts\cp_mp\utility\inventory_utility::_takeweapon(var_8);
    }
  }

  self giveweapon(var_6);
  self notify("pickedupweapon", var_6);

  if(istrue(var_3._id_8B06) || istrue(var_0._id_8B06)) {
    var_20 = _id_2A07(var_5);

    if(isDefined(var_20)) {
      var_21 = weaponclipsize(var_3);
      _id_29FB(self, var_20, var_21);
    }
  } else {
    var_22 = var_0._id_011A;
    var_21 = weaponclipsize(var_3);

    if(istrue(level._id_2ACE)) {
      var_22 = var_21;
    }

    var_23 = 0;

    if(var_22 > var_21) {
      var_23 = var_22 - var_21;
      var_22 = var_21;
    }

    self setweaponammoclip(var_6, var_22);

    if(var_23 > 0) {
      var_20 = _id_2A07(var_3);

      if(isDefined(var_20)) {
        _id_29FB(self, var_20, var_23);
      }
    }
  }

  _id_2A0C(self);
  self _meth_84A1(var_6);
  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_6);
  scripts\mp\weapons::_id_5BFC(self, var_6);
  scripts\mp\weapons::_id_FCA1(var_3);

  if(isDefined(var_0._id_04F6) && isent(var_0._id_04F6)) {
    var_0._id_04F6 delete();
  }

  var_24 = undefined;

  foreach(var_26 in self._id_019F) {
    if(isweapon(var_26) && var_26._id_0241 == "primary") {
      var_4 = getcompleteweaponname(var_26);

      if(var_4 == var_6) {
        var_24 = var_26;
        break;
      }
    }
  }

  thread scripts\mp\gametypes\br_respawn::_id_7008(var_6);
}

_id_EDA7(var_0) {
  var_1 = 0;

  if(var_0._id_CF22 == "Ammo_Crate") {
    var_2 = self getcurrentweapon().basename;
    var_3 = scripts\mp\utility\weapon::getweaponrootname(var_2);
    var_4 = weaponclipsize(var_2);
    var_5 = _id_2A07(var_2);

    if(isDefined(var_5)) {
      var_1 = _id_29FB(self, var_5, var_4);
    }
  } else
    var_1 = _id_29FB(self, var_0._id_CF22, var_0._id_011A, 1);

  if(var_1) {
    var_0._id_011A = var_1;
    var_6 = 1;
  } else
    var_6 = 0;

  return var_6;
}

_id_2A48(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3._id_9688 = var_0;
  var_3._id_CF22 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_3._id_3B38 = var_2;
  var_3._id_011A = 0;
  var_1 _id_EDDC(var_3);
}

_id_2A4B(var_0) {
  var_1 = weaponclipsize(var_0);
  return int(var_1);
}

_id_2A47(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_0 hasweapon(var_1)) {
    var_0 scripts\mp\hud_message::_id_DCA2("MP/BR_ALREADY_HOLDING_WEAPON");
    return 0;
  }

  var_6 = var_1 _meth_8624("maxammo", 1);
  var_7 = spawnStruct();
  var_7._id_04F6 = var_1;
  var_7._id_9688 = var_2;
  var_7._id_CF22 = var_3;
  var_7.origin = var_0.origin;
  var_7._id_011A = _id_2A4B(var_1);

  if(var_6) {
    var_7._id_011A = 999;
  }

  if(isDefined(var_4) && isDefined(var_5)) {
    var_8 = weaponclipsize(var_1);
    var_9 = int(_func_0037(var_8 * var_4));
    var_7._id_011A = int(min(var_9, var_5));
  }

  if(getdvarint("#x3b6d5d3b0a41fd0fa", 0) > 0) {
    var_0 loadweaponsforplayer([var_7._id_9688]);
  }

  var_0 _id_EDDC(var_7);

  if(var_1._id_0216) {
    var_10 = var_1 getaltweapon();

    if(var_10._id_0245 && scripts\mp\utility\weapon::_id_1DA5(var_10._id_04B7) == "ubshtgn") {
      var_11 = weaponclipsize(var_10);
      var_12 = int(var_11);
      var_0 setweaponammoclip(var_10, var_12);
    }
  }

  return 1;
}

_id_29FC() {
  level._id_2A09 = [];
  level._id_2A09[0] = "brloot_ammo_919";
  level._id_2A09[1] = "brloot_ammo_12g";
  level._id_2A09[2] = "brloot_ammo_762";
  level._id_2A09[3] = "brloot_ammo_50cal";
  level._id_2A09[4] = "brloot_ammo_rocket";
  level._id_29FA["brloot_ammo_919"] = 30;
  level._id_29FA["brloot_ammo_12g"] = 8;
  level._id_29FA["brloot_ammo_762"] = 30;
  level._id_29FA["brloot_ammo_50cal"] = 8;
  level._id_29FA["brloot_ammo_rocket"] = 1;
  level._id_29FD = [];
  level._id_29FE = [];
  level._id_29FE["brloot_ammo_919"] = "ui_br_smallarms_ammo";
  level._id_29FE["brloot_ammo_12g"] = "ui_br_shotgun_ammo";
  level._id_29FE["brloot_ammo_762"] = "ui_br_assault_ammo";
  level._id_29FE["brloot_ammo_50cal"] = "ui_br_sniper_ammo";
  level._id_29FE["brloot_ammo_rocket"] = "ui_br_rocket_ammo";
}

_id_2A02() {
  self endon("disconnect");
  thread _id_2A05();
  thread _id_2A00();

  for(;;) {
    self waittill("br_spawned");

    if(!_id_07D1::_id_60BE("prematch_done")) {
      var_0 = self getweaponslistprimaries();

      foreach(var_2 in var_0) {
        var_3 = weaponclipsize(var_2);

        if(isDefined(var_3)) {
          self setweaponammoclip(var_2, var_3);
        }
      }
    }

    foreach(var_6 in level._id_2A09) {
      if(!_id_07D1::_id_60BE("prematch_done")) {
        self._id_29F9[var_6] = level._id_29FD[var_6];
        continue;
      }

      self._id_29F9[var_6] = 0;
    }

    _id_2A0C(self);
    _id_2A01("brloot_ammo_919");
    _id_2A01("brloot_ammo_12g");
    _id_2A01("brloot_ammo_762");
    _id_2A01("brloot_ammo_50cal");
    _id_2A01("brloot_ammo_rocket");
  }
}

_id_2A4C() {
  _id_29FB(self, "brloot_ammo_919", 30, 0);
}

_id_29FF() {
  foreach(var_1 in level._id_2A09) {
    self._id_29F9[var_1] = 0;
  }

  self notify("ammo_update");
}

_id_2A03() {
  var_0 = self;
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_4 = _id_2A07(var_3);

    if(isDefined(var_4)) {
      var_5 = var_0 getweaponammoclip(var_3, "right");
      var_6 = weaponclipsize(var_3);

      if(var_5 < var_6) {
        return 0;
      }

      if(var_3 _meth_8624("akimbo", 1)) {
        var_7 = var_0 getweaponammoclip(var_3, "left");

        if(var_7 < var_6) {
          return 0;
        }
      }

      if(!_id_2A08(var_0, var_4)) {
        return 0;
      }
    }
  }

  return 1;
}

_id_2A04() {
  var_0 = self;
  var_1 = [];
  var_2 = var_0 getweaponslistprimaries();

  foreach(var_4 in var_2) {
    var_5 = _id_2A07(var_4);

    if(isDefined(var_5)) {
      var_1[var_5] = "dummy_value";
      var_6 = weaponclipsize(var_4);
      var_0 setweaponammoclip(var_4, var_6);
    }
  }

  foreach(var_5, var_9 in var_1) {
    var_0._id_29F9[var_5] = level._id_29FD[var_5];
    var_0 _id_2A01(var_5);
  }

  _id_2A0C(var_0);
}

_id_2A08(var_0, var_1) {
  if(!isDefined(var_0._id_29F9) || !isDefined(var_0._id_29F9[var_1])) {
    return 0;
  }

  if(!isDefined(level._id_29FD[var_1])) {
    return 0;
  }

  return scripts\mp\gametypes\br::_id_6516(var_0._id_29F9[var_1]) >= level._id_29FD[var_1];
}

_id_29FB(var_0, var_1, var_2, var_3) {
  if(_id_2A08(var_0, var_1)) {
    return var_2;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_4 = 0;
  var_0._id_29F9[var_1] = var_0._id_29F9[var_1] + var_2;

  if(var_0._id_29F9[var_1] > level._id_29FD[var_1]) {
    if(var_3) {
      var_4 = var_0._id_29F9[var_1] - level._id_29FD[var_1];

      if(var_4 < level._id_29FA[var_1]) {
        var_4 = 0;
      }
    }

    var_0._id_29F9[var_1] = level._id_29FD[var_1];
  }

  var_0 _id_2A01(var_1);
  _id_2A0C(var_0);
  return var_4;
}

_id_2A06(var_0, var_1, var_2) {
  if(var_0._id_29F9[var_1] <= 0) {
    return 0;
  }

  var_0._id_29F9[var_1] = var_0._id_29F9[var_1] - var_2;

  if(var_0._id_29F9[var_1] < 0) {
    var_0._id_29F9[var_1] = 0;
  }

  var_0 _id_2A01(var_1);
  _id_2A0C(var_0);
  return 1;
}

_id_2A00() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    scripts\engine\utility::_id_10883("ammo_update", "pickedupweapon", "weapon_switch_done", "weapon_change", "weapon_change_complete");
    _id_2A01("brloot_ammo_919");
    _id_2A01("brloot_ammo_12g");
    _id_2A01("brloot_ammo_762");
    _id_2A01("brloot_ammo_50cal");
    _id_2A01("brloot_ammo_rocket");
  }
}

_id_2A01(var_0, var_1) {
  if(isDefined(level._id_29FE[var_0])) {
    self setclientomnvar(level._id_29FE[var_0], self._id_29F9[var_0]);
  }
}

_id_2A0C(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_4 = _id_2A07(var_3);

    if(isDefined(var_4)) {
      var_5 = scripts\mp\gametypes\br::_id_6516(var_0._id_29F9[var_4]);
      var_0 setweaponammostock(var_3, var_5);
    }
  }

  var_0 notify("ammo_update");
}

_id_2A0A(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  var_2 = self getweaponslistprimaries();

  foreach(var_4 in var_2) {
    var_5 = _id_2A07(var_4);

    if(isDefined(var_5) && var_1 == var_5) {
      var_6 = scripts\mp\gametypes\br::_id_6516(var_0._id_29F9[var_1]);
      var_0 setweaponammostock(var_4, var_6);
    }
  }

  var_0 notify("ammo_update");
}

_id_2A07(var_0) {
  var_1 = undefined;
  var_2 = ["selectsemi", "selectsemi_falpha"];
  var_3 = ["ubshtgn", "ubshtgn02", "ubshtgn_mike4"];

  if(var_0._id_0245 && isDefined(var_0._id_04B7) && !scripts\engine\utility::array_contains(var_2, var_0._id_04B7)) {
    if(scripts\engine\utility::array_contains(var_3, var_0._id_04B7)) {
      return undefined;
    } else {
      var_1 = "weapon_projectile";
    }
  } else
    var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);

  switch (var_1) {
    case "weapon_machine_pistol":
    case "weapon_pistol":
    case "weapon_smg":
      return "brloot_ammo_919";
    case "weapon_shotgun":
      return "brloot_ammo_12g";
    case "weapon_lmg":
    case "weapon_assault":
      return "brloot_ammo_762";
    case "weapon_dmr":
    case "weapon_sniper":
      return "brloot_ammo_50cal";
    case "weapon_projectile":
      return "brloot_ammo_rocket";
  }

  return undefined;
}

_id_2A05() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("reload_start");

    if(!isDefined(self)) {
      return;
    }
    if(scripts\mp\gametypes\br_public::_id_8990()) {
      continue;
    }
    var_0 = self getcurrentweapon();
    var_1 = _id_2A07(var_0);

    if(!isDefined(var_1)) {
      continue;
    }
    _id_2ACD(var_0);

    if(!isDefined(self)) {
      return;
    }
    if(var_0 != self getcurrentweapon()) {
      continue;
    }
    if(!getdvarint("#x36280fc940ba0355f", istrue(level._id_BBA6)) || _id_07D1::_id_60BE("prematch_done")) {
      self._id_29F9[var_1] = self getweaponammostock(var_0);
    }

    _id_2A0A(self, var_1);
  }
}

_id_2ACD(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("weapon_fired");

  while(self _meth_81E0()) {
    waitframe();
  }
}

_id_2A4D(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_3 = _id_2A07(var_0);

  if(isDefined(var_3)) {
    var_4 = int(level._id_29FA[var_3] * var_1);
    var_2._id_29F9[var_3] = int(clamp(var_2._id_29F9[var_3] + var_4, 0, level._id_29FD[var_3]));
  }

  _id_2A0A(var_2, var_3);
}

_id_8AE2(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isweapon(var_0)) {
    return 0;
  }

  if(isnullweapon(var_0)) {
    return 0;
  }

  if(scripts\mp\weapons::_id_885E(var_0) || scripts\mp\utility\weapon::_id_8888(var_0)) {
    return 0;
  }

  return 1;
}