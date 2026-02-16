/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1875.gsc
*************************************************/

init() {
  level._id_BADE = [];
  level._id_BAE2 = [];
  level._id_BAF7 = [];
  level._id_BB28 = [];
  level._id_4AE0 = ::_id_BA9F;
  level._id_5267 = ::_id_BAA4;
  level._id_BA96 = ::_id_BA96;
  level._id_BA99 = ::_id_1100F;
  level._id_BAAB = ::_id_759C;
  level._id_396F = ::_id_396F;
  level._id_BAB5 = ::_id_BAB5;
  level._effect["grenade_explode"] = loadfx("vfx/iw8/weap/_explo/vfx_explo_frag_gren.vfx");
  thread _id_079A::_id_BAEC();
  _id_BADA();

  if(isDefined(level._id_BAC2)) {
    level[[level._id_BAC2]]();
  } else {
    _id_BAE3("power_c4", undefined, undefined, undefined, "c4_update", undefined, undefined);
    _id_BAE3("power_flash", undefined, undefined, undefined, undefined, undefined, undefined);
    _id_BAE3("power_dud", undefined, undefined, undefined, undefined, undefined, undefined);
    _id_BAE3("power_ammoCrate", undefined, undefined, undefined, undefined, undefined, undefined);
    _id_BAE3("power_molotov", undefined, undefined, undefined, undefined, undefined, undefined);
    _id_BAE3("power_smokeGrenade", undefined, undefined, undefined, undefined, undefined, undefined);
    _id_BAE3("power_claymore", undefined, undefined, undefined, undefined, undefined, undefined);
    _id_BAE3("power_cover", undefined, ::_id_EDA9, ::_id_6F8C, undefined, undefined, undefined);
    _id_BAE3("power_snapshotGrenade", undefined, undefined, undefined, undefined, undefined, undefined);
    _id_BAE3("power_thermite", undefined, undefined, undefined, undefined, undefined, undefined);
    _id_BAE3("equip_hb_sensor", undefined, undefined, undefined, undefined, undefined, undefined);
    _id_BAE3("equip_radial_sensor", undefined, undefined, undefined, undefined, undefined, undefined);
  }

  if(!isDefined(level._id_3D8F)) {
    level._id_3D8F = [];
    level._id_3D8F["90"] = cos(90);
    level._id_3D8F["89"] = cos(89);
    level._id_3D8F["45"] = cos(45);
    level._id_3D8F["25"] = cos(25);
    level._id_3D8F["15"] = cos(15);
    level._id_3D8F["10"] = cos(10);
    level._id_3D8F["5"] = cos(5);
  }

  level _id_D89C();
  scripts\engine\utility::_id_5C11("powers_init_done");
  scripts\engine\utility::_id_5C1B("powers_init_done");
}

_id_D89C() {
  level._id_AD1E["frag_grenade_mp"] = ::_id_5F35;
}

_id_5F35(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_2 = "power_frag";
  var_0 endon("power_removed_" + var_2);

  if(!isDefined(var_1) || var_1 != "frag_grenade_mp") {
    return;
  }
  if(!var_0 _id_759C(var_2)) {
    return;
  }
  var_3 = var_0.origin;
  playFX(level._effect["grenade_explode"], var_3);
  playsoundatpos(var_3, "frag_grenade_expl_trans");

  if(!isDefined(var_0._id_BADE[var_2])) {
    return;
  }
  var_0 _id_BA96(var_0._id_BADE[var_2]._id_3411 - 1, var_0._id_BADE[var_2]._id_DDEF, 1);
  var_0 _id_BACD(var_2);
  var_0 radiusdamage(var_3, 256, 150, 100, var_0, "MOD_GRENADE", "frag_grenade_mp");
  playrumbleonposition("grenade_rumble", var_3);
  earthquake(0.5, 0.75, var_3, 800);

  foreach(var_5 in level.players) {
    if(var_5 scripts\cp\utility::_id_8ACE()) {
      continue;
    }
    if(distancesquared(var_3, var_5.origin) > 360000) {
      continue;
    }
    if(var_5 _meth_8096(var_3)) {
      var_5 thread scripts\cp\cp_weapon::_id_49CD(var_3);
    }

    var_5 setclientomnvar("ui_hud_shake", 1);
  }

  var_0 thread _id_C5BC();
  var_0 thread _id_4718(var_2);
}

_id_C5BC() {
  self endon("death");
  self disableoffhandweapons();

  while(self fragButtonPressed()) {
    wait 0.1;
  }

  wait 0.1;
  self enableoffhandweapons();
}

_id_4718(var_0) {
  self endon("death");
  self endon("end_last_second_throw_func");
  self notify("starting_delay_last_second_grenade_throws");
  thread _id_529A(0.25);
  self waittill("grenade_fire", var_1, var_2, var_3, var_4);

  if(isDefined(var_1) && var_1.classname == "grenade") {
    var_1 delete();
    _id_BA96(self._id_BADE[var_0]._id_3411 + 1, self._id_BADE[var_0]._id_DDEF, 1);
  }
}

_id_529A(var_0) {
  self endon("death");
  wait(var_0);
  self notify("end_last_second_throw_func");
}

_id_BA9C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = spawnStruct();
  var_10._id_FEED = var_1;
  var_10._id_10DE9 = var_2;
  var_10._id_3D0F = var_4;
  var_10._id_7C8C = var_3;

  if(level.gametype == "cp_pvpve") {
    var_10._id_9C5C = 1;
  } else {
    var_10._id_9C5C = var_5;
  }

  var_10._id_43F9 = var_6;
  var_10._id_FE36 = var_7;
  var_10._id_F924 = var_8;
  var_10._id_45C7 = var_9;
  level._id_BADE[var_0] = var_10;
}

_id_BADA() {
  var_0 = 1;

  if(isDefined(level._id_BAC5)) {
    var_1 = level._id_BAC5;
  } else {
    var_1 = "cp/cp_powerTable.csv";
  }

  for(;;) {
    var_2 = tablelookupbyrow(var_1, var_0, 0);

    if(var_2 == "") {
      break;
    }

    var_3 = tablelookupbyrow(var_1, var_0, 1);
    var_4 = tablelookupbyrow(var_1, var_0, 6);
    var_5 = tablelookupbyrow(var_1, var_0, 7);
    var_6 = tablelookupbyrow(var_1, var_0, 8);
    var_7 = tablelookupbyrow(var_1, var_0, 9);
    var_8 = tablelookupbyrow(var_1, var_0, 10);
    var_9 = tablelookupbyrow(var_1, var_0, 11);
    var_10 = tablelookupbyrow(var_1, var_0, 16);
    var_11 = tablelookupbyrow(var_1, var_0, 13);
    _id_BA9C(var_3, var_4, var_5, int(var_2), float(var_6), int(var_7), int(var_8), int(var_9), var_10, var_11);

    if(isDefined(level._id_BB28[var_5]) && var_5 != "<power_script_generic_weapon>") {
      switch (var_5) {
        case "power_rewind":
          if(var_3 == "power_rewinder") {
            break;
          }
        default:
          break;
      }
    }

    level._id_BB28[var_5] = var_3;
    var_0++;
  }
}

_id_BAE3(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = level._id_BADE[var_0];

  if(!isDefined(var_7)) {
    scripts\engine\utility::_id_5598("No configuration data for " + var_0 + " found! Is it in powertable.csv? Or make sure powerSetupFunctions is called after the table is initialized.");
  }

  level._id_BAE2[var_0] = var_1;
  level._id_BAF7[var_0] = var_2;

  if(isDefined(var_3)) {
    var_7._id_FE73 = var_3;
  }

  if(isDefined(var_4)) {
    var_7._id_FCD0 = var_4;
  }

  if(isDefined(var_5)) {
    var_7._id_FE50 = var_5;
  }

  if(isDefined(var_6)) {
    var_7._id_8420 = var_6;
  }
}

_id_BAC1(var_0, var_1) {
  var_2 = _id_6C7C(var_0);
  var_3 = self._id_BADE[var_2];
  var_4 = level._id_BADE[var_2];
  var_5 = var_3._id_7B94;
  var_6 = var_3._id_3411;

  if(isDefined(var_5) && var_5 == var_1) {
    return;
  }
  if(isDefined(var_5)) {
    _id_BAC6(var_0);
  }

  switch (var_1) {
    case 0:
      _id_079A::_id_BAE7(var_0);
      _id_079A::_id_BAF4(var_0, 1);
      _id_BAEE(var_2, var_0, var_6);
      thread _id_BAD4(var_2);
      break;
    case 1:
      _id_079A::_id_BAE6(var_0, 0);
      _id_BAEE(var_2, var_0, var_6);
      thread _id_BAD3(var_2);
      break;
    case 2:
      _id_079A::_id_BAF0(var_0, 0);
      _id_079A::_id_BAF4(var_0, 1);
      _id_BAEE(var_2, var_0, var_6);
      thread _id_BAD2(var_2);
      break;
    case 3:
      break;
  }

  var_3._id_7B94 = var_1;
  thread _id_BAC7(var_0);
}

_id_BAC6(var_0) {
  var_1 = _id_6C7C(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = self._id_BADE[var_1];
  var_3 = var_2._id_7B94;

  if(!isDefined(var_3)) {
    return;
  }
  switch (var_3) {
    case "unavailable":
      break;
    case 0:
      _id_079A::_id_BAE9(var_0);
      break;
    case 2:
      break;
    case 1:
      _id_079A::_id_BAEA(var_0, 0);
      break;
  }

  var_2._id_7B94 = undefined;
}

_id_BAC7(var_0) {
  self endon("disconnect");
  self notify("power_unsetHudStateOnRemoved_" + var_0);
  self endon("power_unsetHudStateOnRemoved_" + var_0);
  var_1 = _id_6C7C(var_0);
  self waittill("power_removed_" + var_1);
  _id_BAC6(var_0);
}

_id_6FD3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 2;

  if(!isDefined(self._id_BADE)) {
    self._id_BADE = [];
  }

  if(var_0 == "none") {
    return;
  }
  if(var_1 == "scripted") {
    var_8++;
  }

  for(var_9 = self getheldoffhand(); !isnullweapon(var_9); var_9 = self getheldoffhand()) {
    waitframe();
  }

  var_10 = getarraykeys(self._id_BADE);

  foreach(var_12 in var_10) {
    if(self._id_BADE[var_12]._id_DDEF == var_1) {
      self._id_8B37 = var_12;
      _id_C50E(var_12);
      break;
    }
  }

  if(isDefined(level._id_5808)) {
    var_4 = [[level._id_5808]](var_0);
  }

  _id_BA9D(var_0, var_1, var_4, var_5, var_6, var_7);
  var_14 = self._id_BADE[var_0];
  var_15 = level._id_BADE[var_0];
  self notify("delete_equipment " + var_1);
  var_16 = 0.0;

  if(isDefined(self._id_BAD6) && isDefined(self._id_BAD6[var_0])) {
    var_17 = self._id_BAD6[var_0];
    var_18 = _id_BA9A(var_17);

    if(var_18 > 0.0) {
      var_19 = var_14._id_3411 * var_15._id_3D0F;
      var_14._id_3411 = int((var_19 - var_18) / var_15._id_3D0F);

      if(var_14._id_3411 < 0) {
        var_14._id_3411 = 0;
      }

      for(var_16 = var_18; var_16 > var_15._id_3D0F; var_16 = var_16 - var_15._id_3D0F) {}
    }
  }

  if(var_1 == "scripted") {
    return;
  }
  var_14._id_10DE9 = undefined;

  if(var_15._id_10DE9 == "<power_script_generic_weapon>") {
    var_14._id_10DE9 = scripts\engine\utility::ter_op(var_1 == "primary", "power_script_generic_primary_mp", "power_script_generic_secondary_mp");
  } else {
    var_14._id_10DE9 = var_15._id_10DE9;
  }

  var_20 = var_14._id_10DE9;
  var_14._id_10DE9 = var_20;
  var_14.objweapon = makeweapon(var_20);
  self giveweapon(var_14.objweapon);
  self setweaponammoclip(var_14.objweapon, var_14._id_3411);

  if(var_14._id_DDEF == "primary") {
    self _meth_849C(var_14.objweapon);
    self._id_BADD = var_20;
    self setclientomnvar("ui_power_max_charges", var_14._id_3411);
  } else if(var_14._id_DDEF == "secondary") {
    self _meth_849D(var_14.objweapon);
    self._id_BAE1 = var_20;
    self setclientomnvar("ui_power_secondary_max_charges", var_14._id_3411);
  }

  if(isDefined(level._id_BAE2[var_0])) {
    self[[level._id_BAE2[var_0]]](var_0);
  }

  if(isDefined(var_6) && !var_6) {
    thread _id_C45F(var_0);
  }

  if(!isai(self)) {
    thread _id_BAB3(var_0);
    thread _id_BAB2(var_0);
    thread _id_9A2B(var_15, var_0, var_14._id_DDEF, var_15._id_3D0F, var_15._id_FCD0, var_15._id_FE50, var_20, var_16, var_2);
  }
}

_id_C50E(var_0) {
  if(isDefined(level._id_BAF7[var_0])) {
    self[[level._id_BAF7[var_0]]]();
  }

  if(isDefined(self._id_BADE[var_0]._id_10DE9)) {
    self takeweapon(self._id_BADE[var_0]._id_10DE9);
  }

  if(self._id_BADE[var_0]._id_DDEF == "primary") {
    self _meth_849E();
    self._id_BADD = undefined;
  } else if(self._id_BADE[var_0]._id_DDEF == "secondary") {
    self _meth_849F();
    self._id_BAE1 = undefined;
  }

  self notify("power_removed_" + var_0);
  _id_1100F(self._id_BADE[var_0]._id_DDEF);
  self._id_BADE[var_0] = undefined;
}

_id_1100F(var_0) {
  if(var_0 == "scripted") {
    return;
  }
  self setclientomnvar(_id_079A::_id_BAEB(var_0, 2), 0);
  self setclientomnvar(_id_079A::_id_BAEB(var_0, 1), 0);
  self setclientomnvar(_id_079A::_id_BAEB(var_0, 0), -1);
  self setclientomnvar(_id_079A::_id_BAEB(var_0, 3), 0);
}

_id_3843() {
  if(isDefined(self._id_BAD6) && self._id_BAD6.size > 0) {
    var_0 = self._id_BAD6;

    foreach(var_3, var_2 in var_0) {
      if(_id_BA9A(var_2) == 0.0) {
        self._id_BAD6[var_3] = undefined;
      }
    }
  }
}

_id_BA9A(var_0) {
  var_1 = level._id_BADE[var_0._id_BA94];
  var_2 = (var_0._id_9C5C - var_0._id_3411) * var_1._id_3D0F - (var_1._id_3D0F - var_0._id_3D0B);
  var_3 = (gettime() - var_0._id_F27A) / 1000;
  return max(0, var_2 - var_3);
}

_id_396F() {
  self notify("powers_cleanUp");

  if(isDefined(self._id_BADE)) {
    var_0 = self._id_BADE;

    foreach(var_3, var_2 in var_0) {
      _id_C50E(var_3);
    }

    self._id_BADE = [];
  }
}

_id_6C7C(var_0) {
  if(!isDefined(self._id_BADE)) {
    return undefined;
  }

  foreach(var_3, var_2 in self._id_BADE) {
    if(var_2._id_DDEF == var_0) {
      return var_3;
    }
  }

  return undefined;
}

_id_38F8(var_0) {
  var_1 = self._id_BADE;
  var_2 = _id_BAA9();

  foreach(var_4 in var_2) {
    if(var_1[var_4]._id_DDEF == var_0) {
      self._id_BADE[var_4] = undefined;
      self notify("clear_power_slot" + var_4);
      _id_C50E(var_4);
    }
  }

  _id_1100F(var_0);
}

_id_10DF9(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = getarraykeys(self._id_BADE);

  foreach(var_5 in var_3) {
    if(isDefined(self._id_BADE[var_5]._id_DDEF) && self._id_BADE[var_5]._id_DDEF == var_0) {
      var_2 = var_5;
      return var_2;
    }
  }

  return undefined;
}

_id_BAA8(var_0) {
  return scripts\engine\utility::ter_op(self._id_BADE[var_0]._id_DDEF == "primary", "+frag", "+smoke");
}

_id_BA9D(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = level._id_BADE[var_0];
  var_7 = spawnStruct();
  var_7._id_DDEF = var_1;
  var_7._id_3411 = var_6._id_9C5C;

  if(istrue(var_2)) {
    var_7._id_3411++;
  }

  if(isDefined(var_5)) {
    var_7._id_3411 = var_5;
  }

  var_7._id_9C5C = _id_658A(var_0, var_1);
  var_7._id_7DAC = 0;
  var_7._id_0026 = 0;
  var_7._id_3D0B = 0;
  var_7._id_3D0D = 1.0;
  var_7._id_3D06 = var_3;
  var_7._id_B006 = var_4;
  var_7._id_AEAC = [];
  self._id_BADE[var_0] = var_7;
}

_id_658A(var_0, var_1) {
  if(scripts\cp\utility::_id_86C9()) {
    return level._id_BADE[var_0]._id_9C5C;
  }

  return _id_073C::_id_65FC(self, var_1);
}

_id_9A2B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("death");
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var_1);
  level endon("game_ended");

  if(isDefined(var_8) && var_8 || var_1 == "power_copycatGrenade") {
    self endon("start_copycat");
  }

  self endon("clear_power_slot" + var_1);
  _id_079A::_id_BAE5(var_2, int(var_0._id_7C8C), 1, int(self._id_BADE[var_1]._id_3411));
  scripts\cp\utility::_id_60C2("prematch_done");
  _id_BAC1(var_2, 2);

  for(;;) {
    if(_id_073B::_id_B4EF(self)) {
      scripts\engine\utility::_id_10882("revive", "revive_success", "self_revive_success", "challenge_complete_revive");
    }

    _id_BACD(var_1);
    var_9 = var_6 + "_success";
    thread _id_10AD6(var_3, var_1, var_9);
    var_10 = scripts\engine\utility::ter_op(var_0._id_FEED == "weapon_hold", "offhand_pullback", "offhand_fired");
    self waittill(var_10, var_11);

    if(var_11.basename != var_6) {
      continue;
    }
    var_3 = _id_6C7D(var_0);
    self notify(var_9);

    if(self._id_BADE[var_1]._id_3411 != 0 && !self._id_BADE[var_1]._id_0026) {
      var_12 = undefined;

      if(isDefined(var_0._id_FE73)) {
        var_12 = self thread[[var_0._id_FE73]](var_11);

        if(isDefined(var_12) && var_12 == 0) {
          continue;
        }
      }

      if(isDefined(var_5)) {
        self waittill(var_5, var_12);

        if(isDefined(var_12) && var_12 == 0) {
          continue;
        }
      }

      if(!isDefined(self._id_4D96) || self._id_4D96 != var_1) {}
    }

    _id_BA96(-1, self._id_BADE[var_1]._id_DDEF);
    self notify("power_used " + var_1);

    if(isDefined(var_4) && level._id_BADE[var_1]._id_F924 == "drain" && !istrue(self._id_BADE[var_1]._id_7E05)) {
      _id_BAA1(var_1);
    }

    thread _id_BAA0(var_1, var_3, var_8);
  }
}

_id_897D(var_0) {
  switch (var_0) {
    case "power_sentry":
    case "power_clusterGrenade":
    case "power_ammoCrate":
    case "power_frag":
    case "power_smokeGrenade":
    case "power_molotov":
      return 1;
    default:
      return 0;
  }
}

_id_6C7D(var_0) {
  if(istrue(level._id_BAE4)) {
    return 0.1;
  } else if(istrue(level._id_7E88)) {
    return 2.5;
  } else if(scripts\cp\utility::_id_8580("grenade_cooldown")) {
    return var_0._id_3D0F;
  } else {
    return var_0._id_3D0F;
  }
}

_id_BAB3(var_0) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var_0);
  var_1 = self._id_BADE[var_0];
  var_2 = var_1._id_10DE9;
  var_3 = var_1._id_DDEF;

  for(;;) {
    self waittill("scavenged_ammo", var_4);

    if(var_4 == var_2) {
      _id_BA96(var_1._id_9C5C, var_3);
    }

    var_5 = var_1._id_7B94;

    if(var_5 == 1) {
      _id_BAC1(var_3, 2);
    }
  }
}

_id_BAB2(var_0) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var_0);
  var_1 = self._id_BADE[var_0];
  var_2 = var_1._id_10DE9;
  var_3 = var_1._id_DDEF;

  for(;;) {
    self waittill("pickup_equipment", var_4);

    if(var_4 == var_2) {
      _id_BA96(1, var_3);
    }

    var_5 = var_1._id_7B94;

    if(var_5 == 1) {
      _id_BAC1(var_3, 2);
    }
  }
}

_id_C45F(var_0) {
  self endon("disconnect");
  self endon("power_removed_" + var_0);
  level endon("game_ended");
  var_1 = self._id_BADE[var_0];

  while(isDefined(self._id_BADE[var_0])) {
    self waittill("power_used " + var_0);

    if(istrue(level._id_BAE4)) {
      continue;
    }
    if(var_1._id_3411 < 1) {
      while(self isswitchingweapon() || scripts\engine\utility::array_contains(self._id_BADF, var_0)) {
        wait 0.25;
      }

      wait 0.25;
      thread _id_C50E(var_0);
    }
  }
}

_id_BAC3(var_0) {
  if(!isDefined(self._id_BADE[var_0])) {
    return 0;
  }

  if(istrue(self._id_BADE[var_0]._id_3D06)) {
    return 1;
  }

  if(istrue(level._id_BAE4)) {
    return 1;
  }

  if(level._id_BADE[var_0]._id_FE36) {
    return 1;
  }

  if(isDefined(self._id_BADE[var_0]._id_DDEF) && self._id_BADE[var_0]._id_DDEF != "primary") {
    return 0;
  }

  if(scripts\cp\utility::_id_8580("grenade_cooldown") && level._id_BADE[var_0]._id_45C7 != "secondary") {
    return 1;
  }

  if(istrue(level._id_7E88)) {
    return 1;
  }

  return 0;
}

_id_0EFD(var_0) {
  self._id_BADF[self._id_BADF.size] = var_0;
}

_id_4390(var_0) {
  if(scripts\engine\utility::array_contains(self._id_BADF, var_0)) {
    self._id_BADF = scripts\engine\utility::array_remove(self._id_BADF, var_0);
  }
}

_id_BAA0(var_0, var_1, var_2) {
  self endon("death");
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var_0);
  self endon("power_cooldown_ended" + var_0);

  if(isDefined(var_2) && var_2 || var_0 == "power_copycatGrenade") {
    self endon("start_copycat");
  }

  self endon("clear_power_slot" + var_0);
  self notify("power_cooldown_begin_" + var_0);
  self endon("power_cooldown_begin_" + var_0);
  level endon("game_ended");
  var_3 = level._id_BADE[var_0];
  var_4 = self._id_BADE[var_0];
  var_5 = var_4._id_DDEF;
  var_6 = var_0 + "_cooldown_update";
  var_4._id_7DAC = 1;

  if(!isDefined(var_4._id_3D0E)) {
    var_4._id_3D0E = 0;
  }

  var_4._id_3D0E++;

  if(!isDefined(var_4._id_3D0A)) {
    var_4._id_3D0A = 0;
  }

  if(!isDefined(var_4._id_3D0B)) {
    var_4._id_3D0B = 0;
  }

  var_4._id_3D0B = var_4._id_3D0B + var_1;
  var_7 = var_4._id_7B94;

  if(isDefined(var_7) && var_7 != 0 && var_4._id_3411 == 0) {
    _id_BAC1(var_5, 1);
  }

  while(var_4._id_3411 < var_4._id_9C5C) {
    if(_id_BAC3(var_0)) {
      wait 0.1;
    } else {
      level scripts\engine\utility::waittill_any_3("grenade_cooldown activated", "infinite_grenade_active", "start_power_cooldown");
      var_1 = _id_6C7D(var_3);
    }

    if(var_4._id_3D0A > var_1) {
      _id_BA96(1, var_5);
      _id_BACD(var_0);

      if(var_4._id_3411 == var_4._id_9C5C) {
        thread _id_BAA5(var_0, var_2);
      }

      var_4._id_3D0A = var_4._id_3D0A - var_1;
      var_4._id_3D0B = var_4._id_3D0B - var_1;
      var_4._id_3D0E--;

      if(isDefined(var_7) && var_7 != 0) {
        _id_BAC1(var_5, 2);
      }
    } else {
      var_4._id_3D0A = var_4._id_3D0A + 0.1;
      var_4._id_3D0B = var_4._id_3D0B - 0.1;
    }

    var_8 = min(1, var_4._id_3D0A / var_1);
    self notify(var_6, var_8);
  }

  thread _id_BAA5(var_0, var_2);
}

_id_BAA5(var_0, var_1) {
  self notify("power_cooldown_ended" + var_0);
  var_2 = self._id_BADE[var_0];
  var_2._id_7DAC = 0;
  var_2._id_3D0A = 0;
  var_2._id_3D0B = 0;
  var_2._id_3D0E = 0;

  if(isDefined(var_1) && var_1) {
    self notify("copycat_reset");
  }

  var_3 = var_2._id_7B94;
  var_4 = var_2._id_DDEF;

  if(var_3 == 0) {
    return;
  }
  _id_BAC1(var_4, 2);
}

_id_BAA1(var_0) {
  self endon("death");
  self endon("power_drain_ended_" + var_0);
  self notify("power_cooldown_ended_" + var_0);
  var_1 = level._id_BADE[var_0];
  var_2 = self._id_BADE[var_0];
  var_3 = var_1._id_FCD0;
  var_4 = var_1._id_8420;
  var_5 = var_2._id_DDEF;
  var_2._id_7E05 = 1;
  _id_BA9E(var_0);
  _id_BAC1(var_5, 0);

  if(isDefined(var_4)) {
    thread _id_BAA7(var_0, var_5, var_4);
  }

  for(;;) {
    self waittill(var_3, var_6);

    if(var_6 == 0) {
      break;
    }
  }

  thread _id_BAA6(var_0);
}

_id_BAA7(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var_0);
  self endon("power_drain_ended_" + var_0);
  self waittill(var_2);
  thread _id_BAA6(var_0);
}

_id_BAA6(var_0) {
  self notify("power_drain_ended_" + var_0);
  var_1 = self._id_BADE[var_0];
  var_2 = var_1._id_DDEF;
  var_1._id_7E05 = 0;
  _id_BAA3(var_0);

  if(var_1._id_3411 > 0) {
    _id_BAC1(var_2, 2);
  } else {
    _id_BAC1(var_2, 1);
  }
}

_id_759C(var_0) {
  if(!isDefined(self._id_BADE[var_0])) {
    return 0;
  }

  return 1;
}

_id_10856(var_0) {
  self endon("death");
  self endon("disconnect");

  if(var_0 == "primary") {
    var_1 = "power_primary_used";
  } else {
    var_1 = "power_secondary_used";
  }

  for(;;) {
    if(!isDefined(self)) {
      wait 1;
      break;
    }

    self waittill(var_1);
    break;
  }
}

_id_BAB5(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "all";
  }

  var_2 = _id_BAA9();

  foreach(var_4 in var_2) {
    if(isDefined(self._id_BADE[var_4]._id_DDEF) && self._id_BADE[var_4]._id_DDEF == var_1 || var_1 == "all") {
      self._id_BADE[var_4]._id_3D0D = var_0;
    }
  }
}

_id_BA96(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "all";
  }

  var_3 = _id_BAA9();
  var_4 = var_0;

  foreach(var_6 in var_3) {
    if(!isDefined(var_0)) {
      var_4 = self._id_BADE[var_6]._id_9C5C;
    }

    if(self._id_BADE[var_6]._id_DDEF == var_1 || var_1 == "all") {
      if(isDefined(var_2)) {
        self._id_BADE[var_6]._id_3411 = int(min(var_4, self._id_BADE[var_6]._id_9C5C));
      } else if(self._id_BADE[var_6]._id_3411 + var_4 >= 0) {
        self._id_BADE[var_6]._id_3411 = self._id_BADE[var_6]._id_3411 + var_4;
      } else {
        self._id_BADE[var_6]._id_3411 = 0;
      }

      self._id_BADE[var_6]._id_3411 = int(clamp(self._id_BADE[var_6]._id_3411, 0, self._id_BADE[var_6]._id_9C5C));
      self setweaponammoclip(self._id_BADE[var_6]._id_10DE9, self._id_BADE[var_6]._id_3411);
      _id_BAEE(var_6, self._id_BADE[var_6]._id_DDEF, self._id_BADE[var_6]._id_3411);
    }
  }
}

_id_BAA9() {
  var_0 = getarraykeys(level._id_BADE);
  var_1 = getarraykeys(self._id_BADE);
  var_2 = [];
  var_3 = 0;

  foreach(var_5 in var_1) {
    foreach(var_7 in var_0) {
      if(var_5 == var_7) {
        var_2[var_3] = var_5;
        var_3 = var_3 + 1;
        break;
      }
    }
  }

  return var_2;
}

_id_BA9F(var_0) {
  if(scripts\common\utility::_id_8650()) {
    scripts\common\utility::_id_1562(0);
  }
}

_id_BAA4(var_0) {
  if(!scripts\common\utility::_id_8650()) {
    scripts\common\utility::_id_1562(1);
  }
}

_id_4637(var_0) {
  if(!isDefined(self._id_BAD7)) {
    self._id_BAD7 = [];
  }

  if(!isDefined(self._id_BAD7[var_0])) {
    self._id_BAD7[var_0] = 0.0;
  }
}

_id_6C7E(var_0) {
  _id_4637(var_0);
  return self._id_BAD7[var_0];
}

_id_D688(var_0, var_1) {
  _id_4637(var_0);
  self._id_BAD7[var_0] = var_1;
}

_id_10AD6(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var_1);
  self endon(var_2);
  level endon("game_ended");
  self waittill("offhand_fired", var_3);
  var_4 = self._id_BADE[var_1];
  var_5 = getcompleteweaponname(var_3);

  if(var_5 == var_4._id_10DE9) {
    if(!isalive(self)) {
      if(var_4._id_3411 > 0) {
        _id_BA96(-1, var_4._id_DDEF);
      }

      if(!var_4._id_7DAC) {
        var_4._id_3D0B = level._id_BADE[var_1]._id_3D0F;
        thread _id_BAA0(var_1, var_0);
      }
    }
  }
}

_id_89C3(var_0) {
  if(var_0 == "+frag" && self fragButtonPressed() || var_0 == "+smoke" && self secondaryoffhandbuttonPressed()) {
    return 1;
  } else {
    return 0;
  }
}

_id_BAD2(var_0) {
  self endon("power_available_ended_" + var_0);
  var_1 = self._id_BADE[var_0];
  var_2 = var_1._id_DDEF;

  for(;;) {
    self waittill("power_charges_adjusted_" + var_0, var_3);
    _id_BAEE(var_0, var_2, var_3);
  }
}

_id_BAEE(var_0, var_1, var_2) {
  self setclientomnvar(_id_079A::_id_BAEB(var_1, 0), int(var_2));
}

_id_BAD4(var_0) {
  self endon("disconnect");
  self endon("power_removed_" + var_0);
  self endon("power_drain_ended_" + var_0);
  var_1 = self._id_BADE[var_0];
  var_2 = level._id_BADE[var_0];
  var_3 = var_1._id_DDEF;
  var_4 = var_2._id_FCD0;

  if(!isDefined(var_4)) {
    var_4 = var_0 + "_update";
  }

  for(;;) {
    self waittill(var_4, var_5);
    var_5 = max(0, min(1, var_5));
    _id_079A::_id_BAF2(var_3, var_5);
  }
}

_id_BAD3(var_0) {
  self endon("disconnect");
  self endon("power_removed_" + var_0);
  self endon("power_cooldown_ended" + var_0);
  var_1 = self._id_BADE[var_0];
  var_2 = level._id_BADE[var_0];
  var_3 = var_1._id_DDEF;
  var_4 = var_0 + "_cooldown_update";

  for(;;) {
    self waittill(var_4, var_5);
    _id_079A::_id_BAEF(var_3, var_5);
  }
}

_id_BA9E(var_0) {
  var_1 = self._id_BADE[var_0];

  if(!isDefined(var_1._id_4A77)) {
    var_1._id_4A77 = 0;
  }

  var_1._id_4A77++;

  if(var_1._id_4A77 == 1) {
    _id_BACD(var_0);
  }
}

_id_BAA3(var_0) {
  var_1 = self._id_BADE[var_0];
  var_1._id_4A77--;

  if(var_1._id_4A77 == 0) {
    _id_BACD(var_0);
  }
}

_id_BACD(var_0) {
  var_1 = self._id_BADE[var_0];
  var_2 = isDefined(var_1._id_4A77) && var_1._id_4A77;
  var_3 = var_1._id_3411 > 0;

  if(!var_2 && var_3) {
    self setweaponammoclip(var_1._id_10DE9, var_1._id_3411 + 1);
  } else {
    self setweaponammoclip(var_1._id_10DE9, 0);

    if(scripts\cp\utility::_id_871A()) {
      thread _id_BAD5(var_1._id_DDEF);
    }
  }
}

_id_BAD5(var_0) {
  if(var_0 == "primary") {
    self setclientomnvar("reset_wave_loadout", 3);
  } else if(var_0 == "secondary") {
    wait 0.5;
    self setclientomnvar("reset_wave_loadout", 4);
  }
}

_id_BA95(var_0, var_1) {
  var_2 = self._id_BADE[var_0];
  var_3 = isDefined(var_2._id_4A77) && var_2._id_4A77;
  var_4 = var_2._id_3411;

  if(!var_3) {
    if(var_4 + 1 < var_2._id_9C5C) {
      self setweaponammoclip(var_2.objweapon, var_4 + 1);
      self notify("power_charges_adjusted_" + var_0, var_4 + 1);
      var_2._id_3411 = var_2._id_3411 + 1;
    } else {
      self setweaponammoclip(var_2.objweapon, var_2._id_9C5C);
      self notify("power_charges_adjusted_" + var_0, var_2._id_9C5C);
      var_2._id_3411 = var_2._id_9C5C;
    }
  } else
    self setweaponammoclip(var_2._id_10DE9, 0);
}

_id_6511(var_0) {
  var_1 = [];

  foreach(var_3 in getarraykeys(var_0._id_BADE)) {
    var_4 = spawnStruct();
    var_4._id_DDEF = var_0._id_BADE[var_3]._id_DDEF;
    var_4._id_3411 = var_0._id_BADE[var_3]._id_3411;
    var_4._id_3D06 = var_0._id_BADE[var_3]._id_3D06;
    var_4._id_B006 = var_0._id_BADE[var_3]._id_B006;
    var_4._id_9C5C = var_0._id_BADE[var_3]._id_9C5C;
    var_1[var_3] = var_4;
  }

  return var_1;
}

_id_C702(var_0, var_1) {
  foreach(var_6, var_3 in var_1) {
    var_4 = undefined;
    var_5 = 0;

    if(istrue(var_3._id_3D06)) {
      var_4 = 1;
    }

    if(istrue(var_3._id_B006)) {
      var_5 = 1;
    }

    if(var_3._id_DDEF == "secondary") {
      if(var_6 == "power_bait") {
        var_0 _id_6FD3(var_6, var_3._id_DDEF, undefined, undefined, undefined, 1, 1, var_3._id_9C5C);
      } else {
        var_0 _id_6FD3(var_6, var_3._id_DDEF, undefined, undefined, undefined, var_4, var_5, var_3._id_9C5C);
      }

      var_0 _id_BA96(var_3._id_3411, var_3._id_DDEF, 1);
      continue;
    }

    var_0 _id_6FD3(var_6, var_3._id_DDEF, undefined, undefined, undefined, undefined, 1, var_3._id_9C5C);
    var_0 _id_BA96(var_3._id_3411, var_3._id_DDEF, 1);
  }
}

_id_6F8C(var_0) {}

_id_EDA9(var_0) {}