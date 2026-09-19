/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1414.gsc
**************************************/

_id_AC73() {
  level._id_ABE4 = [];
  level.zm_grenade_funcs = [];
  level.weaponmaxammofuncs = [];
  level._id_6092 = 2;
  level._id_6B83 = ::_id_AC75;

  if(isDefined(level._id_AC71))
    [[level._id_AC71]]();

  _id_0547::_id_7BA9(::_id_ABD7);
  thread _id_AC74();
  level._id_61E0 = 0.3;
  level._id_61E2 = 100;
  level._id_61E1 = 20;
  level._id_61DE = 256;
  level._id_61DC = 350;
  level._id_61DB = 1000;
  level._id_61D9 = 46;
  level._id_61EF = -1;
  level._id_61CC = common_scripts\utility::_id_44F5("mine_launch");
  level._id_61CF = common_scripts\utility::_id_44F5("mine_spin");
  level._id_61C8 = common_scripts\utility::_id_44F5("mine_explode");
  level._id_61C2["enemy"] = common_scripts\utility::_id_44F5("mine_beacon_enemy");
  level._id_61C2["friendly"] = common_scripts\utility::_id_44F5("mine_beacon_friendly");
  level thread maps\mp\zombies\weapons\_zombie_type_38::init();
  level thread maps\mp\zombies\weapons\_zombie_funderbuss::init();
  level thread maps\mp\zombies\weapons\_zombie_de_lisle_carbine::init();
  level thread maps\mp\zombies\weapons\_zombies_scripted_lmg_upgrades::init();
  level thread maps\mp\zombies\weapons\_zombies_scripted_mtx_9_paps::init();
  level thread maps\mp\zombies\weapons\_zombies_scripted_mtx_20_paps::init();
}

_id_AC74() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_A92B();
    var_0 thread _id_A918();
    var_0 thread _id_A926();
    var_0 thread _id_5371();
    var_0 thread _id_4AAA();
  }
}

_id_AC75() {
  if(isDefined(level._id_AC72))
    [[level._id_AC72]]();
}

_id_09E0(var_0) {
  level._id_ABE4[level._id_ABE4.size] = var_0;
}

_id_5776(var_0) {
  if(!isDefined(var_0))
    return 0;

  foreach(var_2 in level._id_ABE4) {
    if(var_2 == var_0)
      return 1;
  }

  return 0;
}

_id_478A(var_0) {
  if(isDefined(var_0))
    var_1 = [var_0];
  else
    var_1 = level.players;

  foreach(var_0 in var_1) {
    var_3 = var_0 getlethalweapon();
    var_4 = var_0 getoffhandsecondaryclass();

    if(0)
      var_5 = [var_3, var_4];
    else
      var_5 = [var_3];

    foreach(var_7 in var_5) {
      if(var_7 == "none" || _id_0548::is_grenadier_immune_weapon(var_7)) {
        continue;
      }
      var_0 setweaponammoclip(var_7, var_0 getweaponammoclip(var_7) + 1);
    }
  }
}

_id_A92B() {
  self endon("disconnect");

  for(;;) {
    self waittill("missile_fire", var_0, var_1);
    var_0._id_3C1D = self getstance();
  }
}

_id_A918() {
  self endon("disconnect");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(isDefined(level.zm_grenade_funcs[var_1])) {
      var_2 = [[level.zm_grenade_funcs[var_1]]](var_0);

      if(var_2)
        continue;
    }

    if(!isDefined(self.equipmentused))
      self.equipmentused = 0;

    if(_id_0547::_id_585C(var_1))
      self.equipmentused++;

    var_0._id_3BE1 = self._id_569F;
  }
}

_id_0667(var_0) {
  var_1 = weaponinventorytype(var_0);

  if(var_1 != "primary" && var_1 != "altmode")
    return 0;

  if(maps\mp\_utility::_id_5670(var_0))
    return 1;

  if(var_0 == self _meth_82D5())
    return 1;

  var_2 = _getweaponbasename(var_0);

  if(_id_0547::_id_5865(var_2))
    return 1;

  if(_id_0547::_id_585B(var_2))
    return 1;

  if(_id_0547::iszombieconsumableweapon(var_2))
    return 1;

  return 0;
}

_id_0639() {
  var_0 = _id_063A();
  return var_0.size;
}

_id_063A() {
  var_0 = [];
  var_1 = self getweaponlistprimaries();

  foreach(var_3 in var_1) {
    if(!_id_0667(var_3))
      var_0[var_0.size] = var_3;
  }

  return var_0;
}

_id_0635() {
  if(_id_0547::_id_4BA7("specialty_class_mule_kick_zm"))
    return 3;

  return 2;
}

_id_05DF(var_0) {
  if(_id_0667(var_0))
    return 1;

  return _id_0635() > _id_0639();
}

_id_0637() {
  var_0 = _id_063A();
  var_1 = self getcurrentprimaryweapon();

  if(common_scripts\utility::_id_0F79(var_0, var_1))
    return var_1;

  if(var_0.size == 0)
    return "none";

  var_2 = common_scripts\utility::_id_4550();

  if(common_scripts\utility::_id_0F79(var_0, var_2))
    return var_2;

  return var_0[0];
}

_id_A926() {
  self endon("disconnect");
  _id_0556::_id_A6B8();

  for(;;) {
    var_0 = self _meth_82D5();

    if(!isDefined(var_0) || var_0 == "none") {
      _id_0556::_id_5F16("melee");
      maps\mp\_utility::_setactionslot(4, "");
    } else {
      _id_0556::_id_5F16(var_0);
      _id_0556::_id_24DD(var_0, var_0, "melee");
      maps\mp\_utility::_setactionslot(4, "weapon", var_0);
    }

    common_scripts\utility::_id_A70A("weapon_given", "weapon_taken", "zombie_player_spawn_finished", "melee_weapon_change");
  }
}

_id_5371() {
  var_0 = spawnStruct();
  self._id_AB4A = var_0;
  var_0._id_08DF = [];
  var_0.weapons = [];
  thread clear_weapon_inventory_on_death();
  thread _id_A88C();
}

clear_weapon_inventory_on_death() {
  var_0 = self;
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("death");

    if(!isDefined(var_0._id_AB4A)) {
      continue;
    }
    var_0._id_AB4A.weapons = [];
  }
}

_id_A88C() {
  self endon("disconnect");

  for(;;) {
    common_scripts\utility::_id_A70A("weapon_given", "weapon_taken");

    if(self.sessionstate == "spectator" || self.sessionstate == "dead") {
      continue;
    }
    var_0 = _id_063A();

    foreach(var_2 in var_0) {
      var_3 = _weapontype(var_2);

      if(var_3 == "melee") {
        continue;
      }
      var_4 = _id_0547::_id_AAF9(var_2);
      var_5 = self._id_AB4A.weapons[var_4];

      if(!isDefined(var_5)) {
        _id_078D(var_2);
        continue;
      }

      var_6 = var_5._id_5B9F;

      if(!isDefined(var_6))
        var_6 = "(removed) " + var_5.currentweapon;

      if(_stricmp(var_2, var_6) != 0) {
        if(isDefined(var_5._id_5B9F))
          self takeweapon(var_5._id_5B9F);

        _id_078D(var_2);
      }
    }

    var_8 = [];

    foreach(var_10, var_5 in self._id_AB4A.weapons) {
      if(isDefined(var_5._id_5B9F) && !self hasweapon(var_5._id_5B9F))
        var_8[var_8.size] = var_10;
    }

    foreach(var_12 in var_8)
    self._id_AB4A.weapons[var_12] = undefined;
  }
}

_id_7BDB(var_0, var_1, var_2) {
  if(!isDefined(level._id_AB4B))
    level._id_AB4B = [];

  var_3 = spawnStruct();
  level._id_AB4B[var_0] = var_3;
  var_3._id_09AF = var_1;
  var_3._id_2381 = var_2;
}

_id_0680(var_0) {
  var_1 = spawnStruct();
  var_1._id_6C57 = var_0;
  var_1._id_0F20 = [];
  var_1.currentweapon = var_0;
  var_1._id_5B9F = undefined;
  return var_1;
}

_id_4129(var_0) {
  var_1 = spawnStruct();
  var_2 = var_0;
  var_3 = _id_0547::_id_AAF9(var_0);
  var_4 = self._id_AB4A.weapons[var_3];

  if(isDefined(var_4))
    var_2 = var_4._id_5B9F;
  else
    _id_AC13("get_current_ammo_info: pulling ammo from weapon that isn't in our inventory!Double-check that this weapon was given to the player through _zm_give_weapon: " + var_0);

  var_1._id_0DB3 = self getweaponammoclip(var_2);

  if(issubstr(var_2, "akimbo"))
    var_1._id_0DB4 = self getweaponammoclip(var_2, "left");

  if(!_isweaponcliponly(var_0))
    var_1._id_0DBB = self getweaponammostock(var_2);

  return var_1;
}

_id_0F21(var_0, var_1) {
  var_2 = _id_0547::_id_AAF9(var_0);
  var_3 = self._id_AB4A.weapons[var_2];
  var_4 = var_0;

  if(isDefined(var_3))
    var_4 = var_3._id_5B9F;
  else
    _id_AC13("apply_ammo_info: setting ammo on weapon that isn't in our inventory!Double-check that this weapon was given to the player through _zm_give_weapon: " + var_0);

  var_5 = 0;
  var_6 = 0;
  var_7 = _weaponclipsize(var_4, self);
  var_5 = int(max(0, var_1._id_0DB3 - var_7));
  var_6 = var_6 + var_5;
  self setweaponammoclip(var_4, var_1._id_0DB3 - var_5, "right");

  if(issubstr(var_4, "akimbo")) {
    if(isDefined(var_1._id_0DB4)) {
      var_5 = int(max(0, var_1._id_0DB4 - var_7));
      var_6 = var_6 + var_5;
      self setweaponammoclip(var_4, var_1._id_0DB4 - var_5, "left");
    } else
      self setweaponammoclip(var_4, 0, "left");
  } else if(isDefined(var_1._id_0DB4)) {
    var_5 = var_1._id_0DB4;
    var_6 = var_6 + var_5;
  }

  if(isDefined(var_1._id_0DBB)) {
    var_8 = var_1._id_0DBB + var_6;
    var_9 = _weaponmaxammo(var_4, self);

    if(var_8 > var_9) {
      _id_AC13("^3apply_ammo_info: Weapon max ammo isn't large enough to hold stored ammo bullets! Losing some ammo.");
      var_8 = var_9;
    }

    self setweaponammostock(var_4, var_8);
  }
}

_id_0736(var_0, var_1) {
  var_2 = 0;
  var_3 = undefined;

  if(isDefined(var_0._id_5B9F)) {
    if(var_0.currentweapon == var_0._id_5B9F) {
      return;
    }
    var_3 = _id_4129(var_0._id_5B9F);
    self notify("zm_weap_take_" + var_0._id_5B9F);
    self takeweapon(var_0._id_5B9F);
  } else {}

  thread _id_0641(var_0.currentweapon, var_1, var_0._id_A6DF, var_0.weaponcharmguid);
  var_0._id_5B9F = var_0.currentweapon;

  if(isDefined(var_3))
    _id_0F21(var_0.currentweapon, var_3);
}

_id_078D(var_0) {
  _id_078C(var_0, undefined, 0);
}

_zm_give_weapon_mp_api(var_0, var_1, var_2, var_3) {
  _id_078C(var_0, var_1, undefined, var_3);
}

_id_078C(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    var_2 = 0;

  var_5 = weaponinventorytype(var_0);
  var_6 = _weapontype(var_0);
  var_7 = _id_0547::_id_AAF9(var_0);
  self notify("zm_stream_cancel_" + var_7);

  if(var_5 != "primary" && var_5 != "altmode" || var_6 == "melee") {
    thread _id_0641(var_0, var_7, var_2, var_3, var_4);

    if(common_scripts\utility::_id_562E(var_2))
      common_scripts\utility::_id_A70A("zm_stream_cancel_" + var_7, "zm_stream_finish_" + var_7);

    return;
  }

  var_8 = self._id_AB4A.weapons[var_7];

  if(isDefined(var_8)) {
    _id_0790(var_8._id_5B9F);
    var_8 = undefined;
  }

  if(!isDefined(var_8)) {
    var_8 = _id_0680(var_0);
    self._id_AB4A.weapons[var_7] = var_8;
  }

  var_8._id_A6DF = var_2;
  var_8.weaponcharmguid = var_3;

  foreach(var_12, var_10 in self._id_AB4A._id_08DF) {
    var_11 = level._id_AB4B[var_12];

    if(isDefined(var_11._id_09AF))
      self[[var_11._id_09AF]](var_8);
  }

  _id_0736(var_8, var_7);

  if(var_2)
    common_scripts\utility::_id_A70A("zm_stream_cancel_" + var_7, "zm_stream_finish_" + var_7);
}

_id_AC13(var_0) {}

_id_0632(var_0) {
  var_1 = _id_0547::_id_AAF9(var_0);
  var_2 = self._id_AB4A.weapons[var_1];

  if(isDefined(var_2))
    return var_2._id_6C57;

  return var_0;
}

_id_078F() {
  var_0 = getarraykeys(self._id_AB4A.weapons);

  foreach(var_2 in var_0)
  _id_0790(var_2);

  self takeallweapons();
}

_id_0641(var_0, var_1, var_2, var_3, var_4) {
  self notify("zm_stream_change_" + var_1);
  self endon("zm_stream_cancel_" + var_1);
  self endon("zm_stream_change_" + var_1);

  if(!isDefined(var_2))
    var_2 = 0;

  var_5 = 0;
  var_5 = self loadweapons([var_0]);

  if(var_2) {
    wait 0;

    while(!var_5) {
      waitframe();
      var_5 = self loadweapons([var_0]);
    }
  }

  var_6 = 0;
  var_7 = undefined;

  if(!common_scripts\utility::_id_562E(var_4))
    var_7 = _id_056C::getzombiepaintjob(self, var_0);

  maps\mp\_utility::_giveweapon(var_0, var_6, var_7, var_3);

  if(!var_2 && !var_5)
    childthread _id_A8C2(var_0, var_1);
  else
    self notify("zm_stream_finish_" + var_1);
}

_id_A8C2(var_0, var_1) {
  for(;;) {
    var_2 = self loadweapons([var_0]);

    if(var_2) {
      break;
    }

    waitframe();
  }

  self notify("zm_stream_finish_" + var_1);
}

_id_0790(var_0) {
  if(!isDefined(var_0) || var_0 == "none") {
    return;
  }
  var_1 = weaponinventorytype(var_0);
  var_2 = _weapontype(var_0);
  var_3 = _id_0547::_id_AAF9(var_0);

  if(var_1 != "primary" && var_1 != "altmode" || var_2 == "melee") {
    self notify("zm_stream_cancel_" + var_3);
    self takeweapon(var_0);
    return;
  }

  var_4 = [];

  if(isDefined(self._id_AB4A.weapons[var_3]))
    var_4[var_3] = 1;

  if(var_4.size != 1) {}

  foreach(var_17, var_15 in var_4) {
    var_16 = self._id_AB4A.weapons[var_17];

    if(isDefined(var_16._id_5B9F))
      self takeweapon(var_16._id_5B9F);

    self._id_AB4A.weapons[var_17] = undefined;
  }

  self notify("zm_stream_cancel_" + var_3);
}

_id_098F(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = level._id_AB4B[var_3];

    if(!isDefined(var_4)) {
      continue;
    }
    var_1[var_1.size] = var_4;
    self._id_AB4A._id_08DF[var_3] = 1;
  }

  var_6 = self getcurrentprimaryweapon();

  foreach(var_11, var_8 in self._id_AB4A.weapons) {
    foreach(var_4 in var_1) {
      if(isDefined(var_4._id_09AF))
        self[[var_4._id_09AF]](var_8);
    }

    _id_0736(var_8, var_11);
  }

  _id_11BB(var_6);
}

_id_098E(var_0) {
  _id_098F([var_0]);
}

_id_7CC9(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = level._id_AB4B[var_3];

    if(!isDefined(var_4)) {
      continue;
    }
    var_1[var_1.size] = var_4;
    self._id_AB4A._id_08DF[var_3] = undefined;
  }

  var_6 = self getcurrentprimaryweapon();

  foreach(var_11, var_8 in self._id_AB4A.weapons) {
    foreach(var_4 in var_1) {
      if(isDefined(var_4._id_2381))
        self[[var_4._id_2381]](var_8);
    }

    _id_0736(var_8, var_11);
  }

  _id_11BB(var_6);
}

_id_11BB(var_0) {
  var_1 = self getcurrentprimaryweapon();

  if((!isDefined(var_1) || var_1 == "none") && (isDefined(var_0) && var_0 != "none"))
    _id_078E(var_0, 1);
}

_id_7CC8(var_0) {
  _id_7CC9([var_0]);
}

_id_078E(var_0, var_1, var_2) {
  var_3 = _id_0547::_id_AAF9(var_0);
  var_4 = self._id_AB4A.weapons[var_3];

  if(isDefined(var_4))
    var_0 = var_4._id_5B9F;

  if(common_scripts\utility::_id_562E(var_2))
    self _meth_86A5(var_0);
  else if(common_scripts\utility::_id_562E(var_1))
    self switchtoweaponimmediate(var_0);
  else
    self switchtoweapon(var_0);
}

_id_2BA2(var_0) {
  if(!self adsbuttonpressed())
    return 0;

  return 1;
}

_id_0791(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_3))
    var_3 = 1;

  if(!isDefined(var_4))
    var_4 = 1;

  if(!isDefined(var_5))
    var_5 = 1;

  if(!var_2 && !var_3 && !var_4 && !var_5)
    return _stricmp(var_0, var_1) == 0;

  if((var_0 == "none" || var_1 == "none") && _stricmp(var_0, var_1) != 0)
    return 0;

  var_6 = _func_3A5(var_0);
  var_7 = _func_3A5(var_1);

  if(var_4) {
    var_6["weapon"] = _id_0569::_id_40BD(var_6["weapon"]);
    var_7["weapon"] = _id_0569::_id_40BD(var_7["weapon"]);
  }

  if(var_3) {
    var_6["weapon"] = _id_0547::_id_9469(var_6["weapon"]);
    var_7["weapon"] = _id_0547::_id_9469(var_7["weapon"]);
  }

  if(var_5) {
    var_6["weapon"] = _id_0547::_id_9475(var_6["weapon"]);
    var_7["weapon"] = _id_0547::_id_9475(var_7["weapon"]);
  }

  if(var_2)
    return _stricmp(var_6["weapon"], var_7["weapon"]) == 0;
  else {
    var_0 = _id_0547::_id_062F(var_6);
    var_1 = _id_0547::_id_062F(var_7);
    return _stricmp(var_0, var_1) == 0;
  }
}

_id_078A(var_0) {
  if(self hasweapon(var_0))
    return var_0;

  var_1 = _id_0547::_id_AAF9(var_0);
  var_2 = self._id_AB4A.weapons[var_1];

  if(isDefined(var_2) && isDefined(var_2._id_5B9F))
    return var_2._id_5B9F;

  var_3 = self getweaponlistall();

  foreach(var_5 in var_3) {
    if(_id_0791(var_0, var_5))
      return var_5;
  }

  return undefined;
}

_id_078B(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_2))
    var_2 = 0;

  var_4 = self;

  if(var_1)
    var_4 = undefined;

  if(!isDefined(var_0)) {
    return;
  }
  if(issubstr(var_0, "_pap_zm"))
    return var_0;

  var_5 = _id_0547::_id_AAF9(var_0, undefined, 1);
  var_6 = _id_0547::_id_9475(var_5) + "_pap_zm";

  if(!var_2) {
    if(var_0 == "zom_dlc2_1_zm" || var_0 == "zom_dlc2_2_zm" || var_0 == "zom_dlc2_3_zm") {
      if(!common_scripts\utility::_id_3C83("dlc2_melee_packable")) {
        return;
      }
      if(common_scripts\utility::_id_3C83("dlc2_melee_packable") && !common_scripts\utility::_id_3C77("dlc2_melee_packable")) {
        return;
      }
      var_6 = _id_0547::_id_9475(var_0) + "hc_zm";
    }
  }

  if(!_id_0547::_id_5843(var_6)) {
    return;
  }
  if(!var_2) {
    if(issubstr(var_0, "razergun_zm") && !common_scripts\utility::_id_3C77("ripsaw_punch_active")) {
      return;
    }
    if(issubstr(var_0, "teslagun")) {
      if(!common_scripts\utility::_id_3C83("teslagun_punch_active")) {
        return;
      }
      if(!common_scripts\utility::_id_3C77("teslagun_punch_active"))
        return;
    }

    if(issubstr(var_0, "zom_dlc2_1")) {
      if(!common_scripts\utility::_id_3C83("dlc2_melee_packable")) {
        return;
      }
      if(!common_scripts\utility::_id_3C77("dlc2_melee_packable"))
        return;
    }
  }

  var_7 = "pap";

  if(isDefined(level.pap_camo_ref_override))
    var_7 = level.pap_camo_ref_override;

  if(common_scripts\utility::_id_562E(level.iszombiesshotgun)) {
    var_8 = _id_0547::_id_AAF9(var_0, 0, 0);
    var_9 = _func_2FF(var_8, "_zm") + "_mp";

    if(isDefined(level._id_A9CB[var_9]) && isDefined(var_4) && isPlayer(var_4)) {
      var_10 = var_4 getplayerdata(common_scripts\utility::_id_46A8(), "weaponBuildKits", var_9, "bossupgrade");

      if(common_scripts\utility::_id_562E(var_10) && isDefined(level.loot_pap_camo_ref_override))
        var_7 = level.loot_pap_camo_ref_override;
    }
  }

  var_11 = _func_310(var_7);
  var_12 = [];
  var_13 = undefined;
  var_14 = undefined;
  var_15 = undefined;

  if(issubstr(var_0, "classic")) {
    var_11 = _func_310("chrome");
    var_16 = _id_056C::getattachmentforzombieweapon(var_6, "extended_mag");
    var_17 = _func_310(var_16);
    var_12 = common_scripts\utility::_id_0F6F(var_12, var_17);
  }

  if(issubstr(var_0, "vintage")) {
    var_11 = _func_310("chrome");
    var_16 = _id_056C::getattachmentforzombieweapon(var_6, "extended_mag_mg42_zm");
    var_17 = _func_310(var_16);
    var_12 = common_scripts\utility::_id_0F6F(var_12, var_17);
  }

  if(issubstr(var_0, "m1911")) {
    var_18 = _id_056C::getattachmentforzombieweapon(var_6, "akimbo");
    var_19 = _func_310(var_18);
    var_12 = common_scripts\utility::_id_0F6F(var_12, var_19);
  }

  if(!var_1) {
    var_20 = _id_056C::_id_4735(var_4, var_0);

    if(isDefined(var_20)) {
      if(var_20._id_A9F8) {
        var_13 = _func_314(var_20._id_A9F8);
        var_6 = _func_311(var_20._id_A9F8);
        var_6 = _func_2FF(var_6, "_mp");
        var_6 = var_6 + "_pap_zm";
      }

      if(var_20._id_7E18)
        var_14 = var_20._id_7E18;

      if(var_20._id_297C)
        var_15 = var_20._id_297C;

      var_12 = common_scripts\utility::_id_0F73(var_12, var_20._id_114C);
    }

    if(common_scripts\utility::_id_562E(var_3) && isDefined(var_20) && isDefined(var_20._id_1EC0))
      var_11 = var_20._id_1EC0;
  }

  while(var_12.size < 6)
    var_12 = common_scripts\utility::_id_0F6F(var_12, 0);

  var_21 = maps\mp\gametypes\_class::_id_1D66(var_6, var_12[0], var_12[1], var_12[2], var_12[3], var_12[4], var_12[5], var_13, var_11, 0, var_14, var_15, var_4, undefined);
  return var_21;
}

_id_AB31(var_0) {
  if(!isDefined(var_0))
    return 0;

  switch (var_0) {
    case "neck":
    case "helmet":
    case "head":
      return 1;
  }

  return 0;
}

_id_ABD6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = _id_43EE(var_1, var_4);

  if(_id_176D(var_8, 8)) {
    if(_id_AB31(var_7))
      var_2 = _id_0975(1, var_2, var_4, var_7, var_1);
    else if(var_7 != "none")
      var_2 = _id_0975(-0.2, var_2, var_4, var_7, var_1);
  }

  if(_id_176D(var_8, 16)) {
    if(_id_AB31(var_7))
      var_2 = _id_0975(-1, var_2, var_4, var_7, var_1);
    else if(var_7 != "none")
      var_2 = _id_0975(0.2, var_2, var_4, var_7, var_1);
  }

  if(_id_176D(var_8, 64))
    var_2 = var_2 * 1.75;

  return var_2;
}

_id_0975(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_4 _meth_850B(var_2, var_3);

  if(var_5 == 0)
    return 0;

  var_1 = var_1 / var_5 * max(var_5 + var_0, 0);
  return var_1;
}

_id_ABD5(var_0, var_1) {
  _id_054B::_id_6B84(var_0, var_1);
}

_id_ABD7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(var_4) && var_4 == "drag_explosive_zombie_zm") {
    var_1 = level._id_ABA1._id_0117;

    if(!isDefined(var_1) || !isPlayer(var_1) || !isDefined(level._id_ABA1._id_9DBF)) {
      return;
    }
    var_4 = level._id_ABA1._id_9DBF;
  }

  if(!isPlayer(var_1) || !isDefined(var_4)) {
    return;
  }
  var_9 = var_1 _meth_82D5();

  if(var_4 == "frag_skull_zm")
    var_4 = var_1 getcurrentprimaryweapon();

  if(var_4 == var_9)
    var_4 = var_1 getcurrentprimaryweapon();

  var_10 = _id_43EE(var_1, var_4);

  if(maps\mp\_utility::_id_5755(var_3)) {
    if(_id_176D(var_10, 2))
      var_1 _id_ABD5(20, "rip_and_tear");
  } else {
    if(_id_176D(var_10, 1)) {
      if(_id_AB31(var_6))
        var_1 _id_ABD5(10, "head_hunter");
    }

    if(_id_176D(var_10, 128)) {
      if(_id_054D::_id_2EF2())
        var_1 maps\mp\gametypes\zombies::_id_47AE("one_shot_one_kill");
    }

    if(_id_176D(var_10, 4))
      _id_9B91(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }

  if(_id_176D(var_10, 256))
    var_1 _id_50FA(var_4, self);
}

_id_176D(var_0, var_1) {
  return (var_0 &var_1) != 0;
}

_id_43EE(var_0, var_1) {
  var_2 = _id_0547::_id_AAF9(var_1, 0, 1);
  var_3 = var_0._id_AC30[var_2];

  if(!isDefined(var_3)) {
    level.promisenottogiveweapon = 1;
    var_4 = _id_056C::_id_4735(var_0, var_2);
    level.promisenottogiveweapon = undefined;

    if(isDefined(var_4)) {
      if(var_4._id_A9F8) {
        var_5 = _func_31A(var_4._id_A9F8, 43);

        if(isDefined(var_5))
          var_3 = int(var_5);
        else
          var_3 = 0;

        var_0._id_AC30[var_2] = var_3;
      }
    }
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
    var_0._id_AC30[var_2] = 0;
  }

  return var_3;
}

_id_9B91(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = var_1._id_5BDC;
  var_10 = gettime();

  if(isDefined(self._id_6730))
    var_10 = self._id_6730;

  if(!isDefined(var_9)) {
    var_9 = spawnStruct();
    var_1._id_5BDC = var_9;
    var_9._id_8B34 = [];
  }

  var_11 = undefined;

  foreach(var_13 in var_9._id_8B34) {
    if(var_1 == var_13._id_356A && var_10 == var_13._id_2AB8 && _id_054D::_id_5574(var_4, var_13._id_953E)) {
      var_11 = var_13;
      break;
    }
  }

  if(!isDefined(var_11)) {
    var_11 = spawnStruct();
    var_9._id_8B34[var_9._id_8B34.size] = var_11;
    var_11._id_356A = var_1;
    var_11._id_2AB8 = var_10;
    var_11._id_953E = var_4;
    var_11._id_005C = 1;
  } else
    var_11._id_005C++;

  var_1 thread _id_1453();
}

_id_1453() {
  self notify("efficient_kill");
  self endon("death");
  self endon("disconnect");
  self endon("efficient_kill");
  waittillframeend;

  while(isDefined(level._id_AB27) && level._id_AB29 > 0)
    waitframe();

  if(!isDefined(self._id_5BDC)) {
    return;
  }
  foreach(var_1 in self._id_5BDC._id_8B34) {
    if(var_1._id_005C == 2) {
      _id_ABD5(50, "efficient");
      continue;
    }

    if(var_1._id_005C > 2) {
      var_2 = var_1._id_005C * 30;
      _id_ABD5(var_2, "efficient");
    }
  }

  self._id_5BDC = undefined;
}

_id_4AAA() {
  self endon("disconnect");

  for(;;) {
    self._id_18AD = [];
    common_scripts\utility::_id_A70A("death", "begin_last_stand");
  }
}

_id_50FA(var_0, var_1) {
  var_2 = _id_0547::_id_AAF9(var_0, 0);
  var_3 = self._id_18AD[var_2];

  if(!isDefined(var_3))
    var_3 = 0;

  var_3++;

  if(var_3 >= 150) {
    var_3 = var_3 - 150;
    var_4 = anglesToForward(self.angles) * 60;
    var_5 = _getgroundposition(self.origin + var_4, 16);
    var_5 = _func_2E1(var_5, self);
    var_6 = _func_2DC(self.origin, var_5, self, 1);

    if(var_6["fraction"] < 1.0)
      var_5 = self.origin + anglesToForward(self.angles);

    var_7 = maps\mp\gametypes\zombies::_id_3B9B(var_5);
    maps\mp\gametypes\zombies::_id_281C("nuke", var_7, "body_count", 1, 0);
  }

  self._id_18AD[var_2] = var_3;
}

_id_72C3() {
  return isPlayer(self) && (common_scripts\utility::_id_562E(self._id_56A5) || common_scripts\utility::_id_562E(self.isswitchingtoblimppart)) && self hasweapon("blimp_battery_zm");
}

player_is_holding_baby_statue() {
  return isPlayer(self) && self hasweapon("stone_baby_zm");
}

zombies_hit_by_melee_cone(var_0, var_1, var_2) {
  var_3 = self getEye();
  var_4 = self _meth_8566();
  var_5 = _min(90 - var_1 / 2, var_4[0]);
  var_6 = anglesToForward((var_5, var_4[1], var_4[2]));
  var_7 = _id_43F1(var_3, var_6, var_0, var_1, var_2);
  return var_7;
}

_id_43F1(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4))
    var_4 = _id_0547::_id_408F();

  var_5 = [];
  var_6 = _cos(var_3 / 2);

  foreach(var_8 in var_4) {
    var_9 = var_8._id_8302;
    var_10 = var_8._id_8303;
    var_11 = var_8.origin + (0, 0, var_9 * 0.5);
    var_12 = _func_3A2(var_0, -1.0 * var_1, var_6, var_2, var_11);

    if(_distance2dsquared(var_12, var_11) > var_10 * var_10 || _abs(var_11[2] - var_12[2]) > var_9 * 0.5) {
      continue;
    }
    if(var_8 damageconetrace(var_0, self) == 0) {
      continue;
    }
    var_5[var_5.size] = var_8;
  }

  return var_5;
}

create_streamed_world_weapon_model(var_0, var_1) {
  var_2 = spawn("weapon_" + var_0, var_1, 1);
  var_2._id_A9E0 = var_0;
  var_2 makeunusable();
  var_2 _meth_86B3(0);
  var_2 endon("entitydeleted");
  var_2 endon("death");
  var_2 endon("streamed_world_weapon_changed");
  childthread maps\mp\_utility::_id_6F74(::show_streamed_world_weapon_to_player, var_2);
  return var_2;
}

change_streamed_world_weapon_model(var_0) {
  var_1 = self;
  var_1 setpickupweapon(var_0);
  var_1 makeunusable();
  var_1._id_A9E0 = var_0;
  var_1 notify("streamed_world_weapon_changed");
  var_1 endon("entitydeleted");
  var_1 endon("death");
  var_1 endon("streamed_world_weapon_changed");
  childthread maps\mp\_utility::_id_6F74(::show_streamed_world_weapon_to_player, var_1);
}

show_streamed_world_weapon_to_player(var_0) {
  var_1 = self;
  var_0 endon("entitydeleted");
  var_0 endon("death");
  var_0 endon("streamed_world_weapon_changed");
  var_1 endon("disconnect");

  if(var_1 worldweaponsloaded(var_0._id_A9E0)) {
    return;
  }
  var_0 _meth_8006(var_1);
  var_2 = spawn("weapon_" + var_0._id_A9E0, var_0.origin, 1);
  var_2._id_A9E0 = var_0._id_A9E0;
  var_2 makeunusable();
  var_2 _meth_86B3(0);
  var_2 ghost();
  var_1 thread cleanup_streamed_world_weapon(var_2, var_0);

  while(!var_1 worldweaponsloaded(var_2._id_A9E0)) {
    waitframe();
    var_2.origin = var_0.origin;
  }

  var_0 showtoplayer(var_1);
  var_2 notify("streamed_world_weapon");
  var_2 delete();
}

cleanup_streamed_world_weapon(var_0, var_1) {
  var_2 = self;
  var_0 endon("streamed_world_weapon");
  common_scripts\utility::_id_A70C(var_2, "disconnect", var_1, "entitydeleted", var_1, "death", var_1, "streamed_world_weapon_changed");
  var_0 delete();
}