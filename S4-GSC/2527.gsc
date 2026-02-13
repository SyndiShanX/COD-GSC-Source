/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2527.gsc
*************************************************/

_id_1006D(var_0) {
  var_1 = self _meth_8150(1);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3._id_00EC) && var_3._id_00EC == "misc_turret") {
        if(var_0) {
          var_3 thread _id_10055(self);
          continue;
        }

        var_3 _id_10056();
      }
    }
  }

  self setCanDamage(var_0);
  _id_1002E(self);
}

_id_10041(var_0, var_1, var_2) {
  var_3 = _id_1003F();
  var_4 = var_3._id_102F6[var_0];

  if(!isDefined(var_4)) {
    if(istrue(var_1)) {
      var_4 = spawnStruct();
      var_3._id_102F6[var_0] = var_4;
      var_4._id_432C = [];
      var_4.class = "none";
      var_4._id_7640 = undefined;
      var_4._id_BD32 = undefined;
      var_4._id_7664 = undefined;
      var_4._id_2D7E = undefined;
      var_4._id_1042F = [];
      var_4._id_1042B = [];
      var_4._id_1042C = [];
      var_4._id_1042E = undefined;
    } else if(!istrue(var_2)) {}
  }

  return var_4;
}

_id_1003E(var_0, var_1, var_2) {
  var_3 = var_0._id_42F0;

  if(!isDefined(var_3)) {
    if(istrue(var_1)) {
      var_3 = spawnStruct();
      var_0._id_42F0 = var_3;
      var_3._id_4861 = undefined;
      var_3._id_4862 = undefined;
      var_3._id_483F = undefined;
      var_3._id_4840 = undefined;
      var_3._id_7662 = undefined;
      var_3._id_7663 = undefined;
      var_3._id_7660 = undefined;
      var_3._id_7661 = undefined;
    } else if(!istrue(var_2)) {}
  }

  return var_3;
}

_id_1006B(var_0) {
  return _id_1003E(var_0, 1);
}

_id_10033(var_0) {
  var_0._id_42F0 = undefined;
}

_id_10040(var_0, var_1, var_2, var_3) {
  var_4 = _id_10041(var_0, var_2, var_3);
  var_5 = var_4._id_432C[var_1];

  if(!isDefined(var_5)) {
    if(istrue(var_2)) {
      var_5 = spawnStruct();
      var_4._id_432C[var_1] = var_5;
      var_5.maxhealth = undefined;
      var_5._id_AAC7 = undefined;
      var_5._id_AADD = undefined;
    } else if(!istrue(var_3)) {}
  }

  return var_5;
}

_id_1006C(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_10041(var_0, 1);
  var_5._id_1042F[var_4] = var_1;
  var_5._id_1042B[var_4] = var_2;
  var_5._id_1042C[var_4] = var_3;
}

_id_10034(var_0, var_1) {
  var_2 = _id_10041(var_0, 0);

  if(isDefined(var_2)) {
    var_2._id_1042F[var_1] = undefined;
    var_2._id_1042B[var_1] = undefined;
    var_2._id_1042C[var_1] = undefined;
  }
}

_id_1006A(var_0) {
  var_1 = _id_10041(var_0, 1);
  var_1._id_1042E = 1;
  _id_1006C(var_0, 0.85, ::_id_10057, ::_id_10058, "light");
  _id_1006C(var_0, 0.5, ::_id_1005C, ::_id_1005D, "medium");
  _id_1006C(var_0, 0.15, ::_id_1004B, ::_id_1004C, "heavy");
  _id_1006C(var_0, 0.15, ::_id_10039, ::_id_1003A, "engine");
}

_id_10032(var_0) {
  var_1 = _id_10041(var_0, 1);
  var_1._id_1042E = undefined;
  _id_10034(var_0, "light");
  _id_10034(var_0, "medium");
  _id_10034(var_0, "heavy");
  _id_10034(var_0, "engine");
}

_id_10030(var_0, var_1, var_2) {
  var_3 = _id_10041(self._id_1031E, 0, 1);

  if(isDefined(var_3)) {
    foreach(var_5 in var_3._id_1042C) {
      self thread[[var_5]](var_0, var_1, var_2);
    }
  }
}

_id_1004D() {
  var_0 = spawnStruct();
  level.vehicle.damage = var_0;
  var_0._id_102F6 = [];
  var_0._id_BD32 = getdvarint("#x31456dd3654bc33cc", 125);
  var_0._id_7664 = getdvarint("#x37c5942ae9fe2b14f", 350);
  var_0._id_9D04 = getdvarfloat("#x34f1d0cd298de5341", 0.5);
  var_0._id_2D7E = getdvarfloat("#x3d1466b0223b8ee72", 8);
  setdvarifuninitialized("#x3a25ea60367a7aeb8", 2000);
  _id_10059();
  _id_1004E();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "init")]]();
  }

  if(level.gametype == "br") {
    _id_10050();
  } else {
    _id_1004F();
  }

  _id_10051();
}

_id_10059() {
  var_0 = _id_1003F();
  var_1 = spawnStruct();
  var_0._id_EC5C = var_1;
  var_1._id_A015 = [];
  var_1._id_A016 = [];
  var_1._id_79BB = [];
  var_1._id_79BC = [];
  var_1._id_DDA2 = [];
  var_1._id_DDA3 = [];
  var_2 = [];
  var_2["class"] = [];
  var_2["vehicle"] = [];
  var_3 = [];
  var_3["weaponMod"] = [];
  var_3["weaponHPA"] = [];
  var_3["weaponSkipBurnDown"] = [];

  if(level.gametype == "br") {
    var_1 = "mp_cp/vehicleDamageTable_br.csv";
  } else {
    var_1 = "mp_cp/vehicleDamageTable.csv";
  }

  var_4 = undefined;
  var_5 = _func_0225(var_1);

  for(var_6 = 1; var_6 < var_5; var_6++) {
    var_7 = tablelookupbyrow(var_1, 0, var_6);

    if(isDefined(var_7) && var_7 != "") {
      if(_func_00D6(var_7, 0, 1) == "*") {
        var_4 = _func_00D6(var_7, 1, var_7.size);
        continue;
      }

      if(isDefined(var_2[var_4])) {
        var_2[var_4][var_7] = var_6;
      }
    }
  }

  var_8 = undefined;
  var_9 = 0;
  var_10 = tablelookupgetnumrows(var_1);

  for(var_9 = 0; var_9 < var_10; var_9++) {
    var_11 = tablelookupbyrow(var_1, var_9, 1);

    if(isDefined(var_11) && var_11 != "") {
      if(_func_00D6(var_11, 0, 1) == "*") {
        var_8 = _func_00D6(var_11, 1, var_11.size);
        continue;
      }

      if(isDefined(var_3[var_8])) {
        var_3[var_8][var_11] = var_9;
      }
    }
  }

  foreach(var_8, var_13 in var_3) {
    foreach(var_11, var_15 in var_13) {
      foreach(var_4, var_17 in var_2) {
        foreach(var_7, var_19 in var_17) {
          var_20 = _func_0222(var_1, 0, var_15, var_19);

          if(isDefined(var_20) && var_20 != "") {
            _id_1005A(var_20, var_11, var_8, var_7, var_4);
          }
        }
      }
    }
  }
}

_id_1005A(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_1003F();
  var_6 = var_5._id_EC5C;

  if(var_2 == "weaponMod") {
    var_7 = float(var_0);

    if(var_4 == "class") {
      if(!isDefined(var_6._id_A015[var_3])) {
        var_6._id_A015[var_3] = [];
      }

      var_6._id_A015[var_3][var_1] = var_7;
    } else if(var_4 == "vehicle") {
      if(!isDefined(var_6._id_A016[var_3])) {
        var_6._id_A016[var_3] = [];
      }

      var_6._id_A016[var_3][var_1] = var_7;
    }
  }

  if(var_2 == "weaponHPA") {
    var_7 = int(var_0);

    if(var_4 == "class") {
      if(!isDefined(var_6._id_79BB[var_3])) {
        var_6._id_79BB[var_3] = [];
      }

      var_6._id_79BB[var_3][var_1] = var_7;
    } else if(var_4 == "vehicle") {
      if(!isDefined(var_6._id_79BC[var_3])) {
        var_6._id_79BC[var_3] = [];
      }

      var_6._id_79BC[var_3][var_1] = var_7;
    }
  }

  if(var_2 == "weaponSkipBurnDown") {
    var_7 = int(var_0) != 0;

    if(var_4 == "class") {
      if(!isDefined(var_6._id_DDA2[var_3])) {
        var_6._id_DDA2[var_3] = [];
      }

      var_6._id_DDA2[var_3][var_1] = var_7;
    } else if(var_4 == "vehicle") {
      if(!isDefined(var_6._id_DDA3[var_3])) {
        var_6._id_DDA3[var_3] = [];
      }

      var_6._id_DDA3[var_3][var_1] = var_7;
    }
  }
}

_id_1002C(var_0, var_1) {
  var_2 = _id_1003F();
  var_3 = var_2._id_EC5C;
  var_4 = _id_10041(var_0, undefined, var_1);

  if(!isDefined(var_4)) {
    return;
  }
  var_5 = var_4.class;

  if(isDefined(var_3._id_A015[var_5])) {
    foreach(var_8, var_7 in var_3._id_A015[var_5]) {
      _id_10075(var_8, var_7, 0, var_0);
    }
  }

  if(isDefined(var_3._id_A016[var_0])) {
    foreach(var_8, var_7 in var_3._id_A016[var_0]) {
      _id_10075(var_8, var_7, 0, var_0);
    }
  }

  if(isDefined(var_3._id_79BB[var_5])) {
    foreach(var_12, var_11 in var_3._id_79BB[var_5]) {
      _id_10077(var_12, var_11, var_0);
      _id_10074(var_0, 100, var_12);
    }
  }

  if(isDefined(var_3._id_79BC[var_0])) {
    foreach(var_12, var_11 in var_3._id_79BC[var_0]) {
      _id_10077(var_12, var_11, var_0);
      _id_10074(var_0, 100, var_12);
    }
  }
}

_id_1004F() {
  _id_10076("iw8_la_gromeo_mp", 5);
  _id_10076("iw8_la_kgolf_mp", 5);
  _id_10076("iw8_la_rpapa7_mp", 5);
  _id_10076("iw8_la_juliet_mp", 6);
  _id_10076("iw8_la_gromeoks_mp", 4);
  _id_10076("s4_la_walpha2_mp", 3);
  _id_10076("s4_ar_stango44_mp", 3);
  _id_10076("s4_ar_stango44_mp", 3);
  _id_10076("s4_la_palpha_mp", 3);
  _id_10076("s4_la_m1bravo_mp", 3);
  _id_10076("s4_frag_usa_mk2_mp", 3);
  _id_10076("s4_sticky_eng_n74_mp", 3);
  _id_10076("s4_semtex_mp", 3);
  _id_10076("s4_c4_mp", 3);
  _id_10076("at_mine_ap_mp", 3);
  _id_10076("at_mine_mp", 3);
  _id_10076("s4_mine_ger_s44_mp", 3);
  _id_10076("claymore_mp", 3);
  _id_10076("s4_molotov_mp", 2);
  _id_10076("s4_thermite_mp", 2);
  _id_10076("thermite_av_mp", 1);
  _id_10076("thermite_bolt_mp", 1);
  _id_10076("semtex_bolt_mp", 4);
  _id_10076("apache_proj_mp", 3);
  _id_10076("s4_ks_ord_ger_mp", 3);
  _id_10076("cruise_proj_mp", 15);
  _id_10076("s4_strafing_run_mp", 3);
  _id_10076("s4_v2_mp", 15);
  _id_10076("ac130_105mm_mp", 15);
  _id_10076("ac130_40mm_mp", 5);
  _id_10076("ac130_25mm_mp", 1);
  _id_10076("hover_jet_proj_mp", 3);
  _id_10076("emp_drone_non_player_mp", 3);
  _id_10076("emp_drone_non_player_direct_mp", 5);
}

_id_10050() {
  _id_10076("iw8_la_gromeo_mp", 10);
  _id_10076("iw8_la_kgolf_mp", 10);
  _id_10076("iw8_la_rpapa7_mp", 10);
  _id_10076("iw8_la_juliet_mp", 20);
  _id_10076("iw8_la_gromeoks_mp", 10);
  _id_10076("s4_la_walpha2_mp", 6);
  _id_10076("s4_ar_stango44_mp", 6);
  _id_10076("s4_ar_stango44_mp", 6);
  _id_10076("s4_c4_mp", 13);
  _id_10076("s4_sticky_eng_n74_mp", 13);
  _id_10076("s4_semtex_mp", 4);
  _id_10076("s4_frag_usa_mk2_mp", 4);
  _id_10076("pop_rocket_mp", 4);
  _id_10076("s4_molotov_mp", 4);
  _id_10076("at_mine_ap_mp", 5);
  _id_10076("at_mine_mp", 13);
  _id_10076("s4_thermite_mp", 1);
  _id_10076("thermite_av_mp", 1);
  _id_10076("emp_grenade_mp", 4);
  _id_10076("claymore_mp", 13);
  _id_10076("apache_proj_mp", 3);
  _id_10076("s4_ks_ord_ger_mp", 12);
  _id_10076("cruise_proj_mp", 15);
  _id_10076("s4_strafing_run_mp", 10);
  _id_10076("s4_v2_mp", 20);
  _id_10076("ac130_105mm_mp", 15);
  _id_10076("ac130_40mm_mp", 6);
  _id_10076("ac130_25mm_mp", 1);
  _id_10076("hover_jet_proj_mp", 3);
  _id_10076("emp_drone_non_player_mp", 3);
  _id_10076("emp_drone_non_player_direct_mp", 5);
}

_id_10051() {
  var_0 = getdvarfloat("#x32816f8d8e01b185b", 0.5);
  _id_1006F("specialty_armorpiercing", var_0, 0);
}

_id_1003F() {
  return level.vehicle.damage;
}

_id_10054(var_0, var_1) {
  if(isDefined(var_1.inflictor)) {
    if(var_1.inflictor == var_0) {
      return 1;
    }

    var_2 = scripts\cp_mp\vehicles\vehicle::_id_100CD(var_0);

    foreach(var_4 in var_2) {
      if(var_1.inflictor == var_4) {
        return 1;
      }
    }

    if(var_1.inflictor.classname == "rocket" && isDefined(var_1.inflictor.vehicle) && var_1.inflictor.vehicle == var_0) {
      return 1;
    }
  }

  return 0;
}

_id_10037(var_0) {
  var_0._id_ADA0 = 1;
}

_id_10053(var_0) {
  return istrue(var_0._id_ADA0);
}

_id_1005B(var_0, var_1) {
  if(!isDefined(var_0._id_42FC)) {
    var_0._id_42FC = [];
  }

  var_0._id_42FC[var_0._id_42FC.size] = var_1;
  thread _id_1002F(var_0);
}

_id_1002E(var_0) {
  var_0 notify("vehicle_damage_clearEventLog");
  var_0._id_42FC = undefined;
}

_id_1002F(var_0) {
  var_0 endon("death");
  var_0 endon("vehicle_damage_clearEventLog");
  var_0 notify("vehicle_damage_clearEventLogAtFrameEnd");
  var_0 endon("vehicle_damage_clearEventLogAtFrameEnd");
  waittillframeend;
  thread _id_1002E(var_0);
}

_id_10068(var_0, var_1, var_2) {
  if(!isDefined(var_2._id_9CD6)) {
    return 0;
  }

  if(!_func_010F(var_2._id_9CD6)) {
    return 0;
  }

  if(!isDefined(var_2._id_56B8)) {
    return 0;
  }

  if(isDefined(var_0._id_42FC)) {
    foreach(var_4 in var_0._id_42FC) {
      if(var_4._id_56B8 == var_2._id_56B8) {
        return 0;
      }
    }
  }

  if(!isDefined(var_2.inflictor)) {
    var_2.inflictor = undefined;
  }

  var_0 endon("death");
  var_0 endon("vehicle_damage_clearEventLog");
  var_0 dodamage(var_2.damage, var_2.point, var_2.attacker, var_2.inflictor, var_2._id_9CD6, var_2.objweapon, var_2._id_79A9);
  _id_1005B(var_0, var_2);
}

_id_10055(var_0) {
  self endon("death");
  self endon("vehicle_damage_keepTurretAliveEnd");
  self setCanDamage(1);
  self.health = 2147483647;
  self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);
  var_16 = _id_09BF::_id_ADCA(var_2, self, var_1, var_10, var_5, var_14, var_4, var_3, var_6, var_8, var_7, var_9, var_15);
  _id_10068(var_0, self, var_16);
  self.health = 2147483647;
}

_id_10056(var_0) {
  self notify("vehicle_damage_keepTurretAliveEnd");
  self setCanDamage(0);
}

_id_10036(var_0) {
  var_1 = _id_10041(self._id_1031E);

  if(isDefined(var_1)) {
    var_2 = self.health / self.maxhealth;
    var_3 = self.health;
    var_4 = 0;

    if(isDefined(var_0) && isDefined(var_0.damage)) {
      var_3 = int(max(0, self.health - var_0.damage));
    }

    var_5 = var_3 / self.maxhealth;
    var_6 = getarraykeys(var_1._id_1042F);

    if(istrue(var_1._id_1042E)) {
      if(var_1._id_1042F.size > 1) {
        var_6 = getarraykeys(var_1._id_1042F);

        for(var_7 = 0; var_7 < var_6.size; var_7++) {
          for(var_8 = var_7 + 1; var_8 < var_6.size; var_8++) {
            var_9 = var_1._id_1042F[var_6[var_7]];
            var_10 = var_1._id_1042F[var_6[var_8]];

            if(var_9 < var_10) {
              var_11 = var_6[var_7];
              var_6[var_7] = var_6[var_8];
              var_6[var_8] = var_11;
            }
          }
        }
      }
    }

    for(var_7 = 0; var_7 < var_6.size; var_7++) {
      var_12 = var_6[var_7];
      var_13 = var_1._id_1042F[var_12];

      if(var_5 > var_13) {
        if(isDefined(var_1._id_1042C[var_12])) {
          var_14 = var_2 <= var_13;
          self thread[[var_1._id_1042C[var_12]]](var_0, var_14);
        }

        continue;
      }

      if(isDefined(var_1._id_1042B[var_12])) {
        var_14 = var_2 > var_13;
        self thread[[var_1._id_1042B[var_12]]](var_0, var_14);
      }
    }
  }
}

_id_1007D(var_0, var_1) {
  self notify("vehicle_damage_visualStopWatchingSpeedChange");
  self endon("vehicle_damage_visualStopWatchingSpeedChange");
  var_2 = undefined;

  while(isDefined(self)) {
    if(!scripts\cp_mp\vehicles\vehicle_tracking::_id_0C41()) {
      var_3 = undefined;
      var_4 = int(self _meth_842E());
      var_5 = istrue(scripts\cp_mp\vehicles\vehicle::_id_102EE());

      if(var_5 && self _meth_8726()) {
        var_3 = 0;
      } else if(!var_5 && var_4 <= 3) {
        var_3 = 0;
      } else if(var_4 <= 25) {
        var_3 = 1;
      } else {
        var_3 = 2;
      }

      if(isDefined(var_2) && var_3 != var_2) {
        var_6 = _id_10040(self._id_1031E, var_0);
        self thread[[var_6._id_AAC7]](var_0, var_1);
        return;
      }

      var_2 = var_3;
    }

    wait 0.1;
  }
}

_id_1007C() {
  self notify("vehicle_damage_visualStopWatchingSpeedChange");
}

_id_10057(var_0, var_1) {
  if(scripts\cp_mp\vehicles\vehicle_tracking::_id_0C41()) {
    self setscriptablepartstate("damageLight", "stopped", 1);
  } else {
    var_2 = int(self _meth_842E());
    var_3 = istrue(scripts\cp_mp\vehicles\vehicle::_id_102EE());

    if(var_3 && self _meth_8726()) {
      self setscriptablepartstate("damageLight", "stopped", 1);
    } else if(!var_3 && var_2 <= 3) {
      self setscriptablepartstate("damageLight", "stopped", 1);
    } else if(var_2 <= 25) {
      self setscriptablepartstate("damageLight", "lowSpeed", 1);
    } else {
      self setscriptablepartstate("damageLight", "highSpeed", 1);
    }
  }

  thread _id_1007D("light", var_0);
}

_id_10058(var_0, var_1, var_2) {
  self setscriptablepartstate("damageLight", "off", 1);
}

_id_1005C(var_0, var_1) {
  if(scripts\cp_mp\vehicles\vehicle_tracking::_id_0C41()) {
    self setscriptablepartstate("damageMedium", "stopped", 1);
  } else {
    var_2 = int(self _meth_842E());
    var_3 = istrue(scripts\cp_mp\vehicles\vehicle::_id_102EE());

    if(var_3 && self _meth_8726()) {
      self setscriptablepartstate("damageMedium", "stopped", 1);
    } else if(!var_3 && var_2 <= 3) {
      self setscriptablepartstate("damageMedium", "stopped", 1);
    } else if(var_2 <= 25) {
      self setscriptablepartstate("damageMedium", "lowSpeed", 1);
    } else {
      self setscriptablepartstate("damageMedium", "highSpeed", 1);
    }
  }

  thread _id_1007D("medium", var_0);
}

_id_1005D(var_0, var_1, var_2) {
  self setscriptablepartstate("damageMedium", "off", 1);
}

_id_1004B(var_0, var_1) {
  if(scripts\cp_mp\vehicles\vehicle_tracking::_id_0C41()) {
    self setscriptablepartstate("damageHeavy", "stopped", 1);
  } else {
    var_2 = int(self _meth_842E());
    var_3 = istrue(scripts\cp_mp\vehicles\vehicle::_id_102EE());

    if(var_3 && self _meth_8726()) {
      self setscriptablepartstate("damageHeavy", "stopped", 1);
    } else if(!var_3 && var_2 <= 3) {
      self setscriptablepartstate("damageHeavy", "stopped", 1);
    } else if(var_2 <= 25) {
      self setscriptablepartstate("damageHeavy", "lowSpeed", 1);
    } else {
      self setscriptablepartstate("damageHeavy", "highSpeed", 1);
    }
  }

  thread _id_1007D("heavy", var_0);
}

_id_1004C(var_0, var_1, var_2) {
  self setscriptablepartstate("damageHeavy", "off", 1);
}

_id_10039(var_0, var_1) {
  self setscriptablepartstate("damageEngine", "explode", 1);
}

_id_1003A(var_0, var_1, var_2) {
  self setscriptablepartstate("damageEngine", "off", 1);
}

_id_10046() {
  if(!isDefined(self._id_432D)) {
    return "pristine";
  }

  return self._id_432D;
}

_id_10072(var_0, var_1, var_2) {
  if(var_1 != "pristine") {
    var_3 = _id_10040(self._id_1031E, var_1);

    if(isDefined(var_3._id_AADD)) {
      self thread[[var_3._id_AADD]](var_0, var_2);
    }
  }

  if(var_0 != "pristine") {
    var_3 = _id_10040(self._id_1031E, var_0);

    if(isDefined(var_3._id_AAC7)) {
      self thread[[var_3._id_AAC7]](var_1, var_2);
    }
  }

  self._id_432D = var_0;
  self notify("damage_state_change");
}

_id_10079(var_0, var_1, var_2) {
  var_3 = _id_10041(self._id_1031E, undefined, var_2);

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = self.health;

  if(isDefined(var_0) && isDefined(var_0.damage)) {
    var_4 = var_4 - int(var_0.damage);
  }

  self._id_90A7 = gettime();
  var_5 = "pristine";
  var_6 = undefined;
  var_7 = undefined;

  foreach(var_10, var_9 in var_3._id_432C) {
    if(!isDefined(var_7) || var_9.maxhealth < var_7) {
      if(var_4 <= var_9.maxhealth) {
        var_5 = var_10;
        var_6 = var_9;
        var_7 = var_9.maxhealth;
      }
    }
  }

  var_11 = _id_10046();

  if(var_5 != var_11) {
    if(!istrue(var_1)) {
      if(var_5 == "heavy" && (!isDefined(var_11) || var_11 != "heavy")) {
        if(!istrue(self._id_4ABD)) {
          var_12 = _id_1003D(undefined, self._id_1031E);

          if(isDefined(var_12)) {
            if(isDefined(var_0) && isDefined(var_0.damage) && var_0.damage != 0) {
              self.health = self.health + (var_12 - var_4);
            }
          }
        }
      }
    }

    _id_10072(var_5, var_11, var_0);
  }
}

_id_1007A(var_0, var_1) {
  var_2 = _id_10041(self._id_1031E, undefined, var_1);

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = self.health;

  if(isDefined(var_0) && isDefined(var_0.damage)) {
    var_3 = var_3 - int(var_0.damage);
  }

  self._id_90A7 = gettime();
  var_4 = var_3 / self.maxhealth;

  if(var_4 <= 0.1) {
    var_5 = "heavy";
  } else if(var_4 <= 0.5) {
    var_5 = "medium";
  } else if(var_4 <= 0.85) {
    var_5 = "light";
  } else {
    var_5 = "pristine";
  }

  var_6 = _id_10046();

  if(var_5 != var_6) {
    _id_10072(var_5, var_6, var_0);
  }
}

_id_10035(var_0) {
  if(var_0) {
    self._id_4ABD = 1;
  } else {
    self._id_4ABD = undefined;
  }
}

_id_10063(var_0, var_1) {
  _id_10057(var_1, 1);
}

_id_10066(var_0, var_1) {
  _id_10058(var_1, 1);
}

_id_10064(var_0, var_1) {
  _id_1005C(var_1, 1);
}

_id_10067(var_0, var_1) {
  _id_1005D(var_1, 1);
}

_id_10061(var_0, var_1) {
  _id_1004B(var_1, 1);
  _id_10039(var_1, 1);

  if(!isDefined(var_0) || var_0 != "heavy") {
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015B(self, 0);
    _id_10062(var_0, var_1);
    thread _id_1002D(var_1);
  }
}

_id_10065(var_0, var_1) {
  _id_1004C(var_1, 1);
  _id_1003A(var_1, 1);

  if(!isDefined(var_0) || var_0 != "heavy") {
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015B(self, 1);
    _id_10038();
  }
}

_id_10069(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_10041(var_0, 1);
  var_6.health = var_1;
  var_6._id_BD32 = var_2;
  var_6._id_7664 = var_3;
  var_6._id_9D04 = var_4;
  var_6._id_2D7E = var_5;
  var_7 = _id_10040(var_0, "light", 1);
  var_7._id_AAC7 = ::_id_10063;
  var_7._id_AADD = ::_id_10066;
  var_7 = _id_10040(var_0, "medium", 1);
  var_7._id_AAC7 = ::_id_10064;
  var_7._id_AADD = ::_id_10067;
  var_7 = _id_10040(var_0, "heavy", 1);
  var_7._id_AAC7 = ::_id_10061;
  var_7._id_AADD = ::_id_10065;
  _id_1007B(var_0);
}

_id_10042(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = var_0._id_1031E;
  }

  var_2 = _id_1003F();
  var_3 = _id_10041(var_1, 1);

  if(!isDefined(var_3)) {
    if(isDefined(var_0)) {
      return var_0.maxhealth;
    }

    return undefined;
  }

  if(!isDefined(var_3.health)) {
    if(isDefined(var_0)) {
      return var_0.maxhealth;
    }

    return undefined;
  }

  var_4 = var_3.health;
  var_5 = _id_10044(var_1);

  if(isDefined(var_5)) {
    var_4 = var_4 + var_5;
  }

  var_6 = _id_1003C(var_1);

  if(isDefined(var_6)) {
    var_4 = var_4 + var_6;
  }

  return int(var_4);
}

_id_10045(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = var_0._id_1031E;
  }

  var_2 = _id_1003F();
  var_3 = _id_10041(var_1, 1);

  if(!isDefined(var_3)) {
    return undefined;
  }

  if(!isDefined(var_3.health)) {
    return undefined;
  }

  var_4 = var_3.health;
  var_5 = _id_1003C(var_1);

  if(isDefined(var_5)) {
    var_4 = var_4 + var_5;
  }

  if(!isDefined(var_4) || var_4 <= 0) {
    return undefined;
  }

  return int(var_4);
}

_id_1003D(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = var_0._id_1031E;
  }

  var_2 = _id_1003F();
  var_3 = _id_10041(var_1);

  if(!isDefined(var_3)) {
    return undefined;
  }

  if(!isDefined(var_3.health)) {
    return undefined;
  }

  var_4 = _id_1003C(var_1);

  if(!isDefined(var_4) || var_4 <= 0) {
    return undefined;
  }

  return int(var_4);
}

_id_1007B(var_0) {
  var_1 = _id_10041(var_0);
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_6, var_5 in var_1._id_432C) {
    if(var_6 == "light") {
      var_5.maxhealth = _id_10045(undefined, var_0);
      var_3 = var_5.maxhealth;
      continue;
    }

    if(var_6 == "heavy") {
      var_5.maxhealth = _id_1003D(undefined, var_0);
      var_2 = var_5.maxhealth;
    }
  }

  var_5 = var_1._id_432C["medium"];

  if(isDefined(var_5)) {
    if(isDefined(var_2) && isDefined(var_3)) {
      var_7 = _id_10043(var_0);

      if(isDefined(var_7)) {
        var_5.maxhealth = int(scripts\engine\math::_id_91A9(var_2, var_3, var_7));
      }
    }
  }
}

_id_10044(var_0) {
  var_1 = _id_1003F();
  var_2 = _id_10041(var_0);
  var_3 = var_2._id_BD32;

  if(!isDefined(var_3)) {
    var_3 = var_1._id_BD32;
  }

  if(!isDefined(var_3) || var_3 <= 0) {
    return undefined;
  }

  return int(var_3);
}

_id_1003C(var_0) {
  var_1 = _id_1003F();
  var_2 = _id_10041(var_0);
  var_3 = var_2._id_7664;

  if(!isDefined(var_3)) {
    var_3 = var_1._id_7664;
  }

  if(!isDefined(var_3) || var_3 <= 0) {
    return undefined;
  }

  return int(var_3);
}

_id_10043(var_0) {
  var_1 = _id_1003F();
  var_2 = _id_10041(var_0);
  var_3 = var_2._id_9D04;

  if(!isDefined(var_3)) {
    var_3 = var_1._id_9D04;
  }

  if(!isDefined(var_3) || var_3 <= 0 || var_3 > 1) {
    return undefined;
  }

  return var_3;
}

_id_1002D(var_0) {
  self endon("death");
  self endon("end_burn_down");

  if(!istrue(self._id_2D8B)) {
    var_1 = scripts\cp_mp\vehicles\vehicle::_id_100C1(self._id_1031E);
    var_2 = var_1._id_4841;
    var_3 = _id_1003B(self._id_1031E);

    if(isDefined(var_3) && isDefined(var_2)) {
      self._id_2D8B = 1;
      var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(self, 0);

      if(isDefined(var_4)) {
        _id_09CA::_id_10390("burningDown", var_4, self._id_1031E);
      }

      self.currentburndowntime = var_3 * 1000;

      for(var_5 = gettime(); self.currentburndowntime > 0; var_5 = var_6) {
        waitframe();
        var_6 = gettime();
        var_7 = var_6 - var_5;
        self.currentburndowntime = self.currentburndowntime - var_7;
      }

      self._id_2D8B = undefined;
      self.currentburndowntime = undefined;
      self thread[[var_2]](var_0, 0);
      return;
    }
  }
}

_id_10038(var_0) {
  if(!istrue(self._id_2D8B)) {
    return;
  }
  if(!istrue(var_0)) {
    var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(self, 0);

    if(isDefined(var_1)) {
      _id_09CA::_id_1037B("burningDown", var_1, self._id_1031E);
    }
  }

  self._id_2D8B = undefined;
}

_id_10052() {
  return istrue(self._id_2D8B);
}

_id_1003B(var_0) {
  var_1 = _id_1003F();
  var_2 = _id_10041(var_0);
  var_3 = var_2._id_2D7E;

  if(!isDefined(var_3)) {
    var_3 = var_1._id_2D7E;
  }

  if(!isDefined(var_3) || var_3 <= 0) {
    return undefined;
  }

  return var_3;
}

_id_10078(var_0) {
  if(isDefined(var_0._id_9CD6)) {
    if(!_func_010F(var_0._id_9CD6) && var_0._id_9CD6 != "MOD_FIRE") {
      return 0;
    }

    if(var_0._id_9CD6 == "MOD_CRUSH") {
      return 1;
    }
  }

  if(isDefined(var_0.objweapon) && !isnullweapon(var_0.objweapon) && isDefined(self._id_1031E)) {
    var_1 = undefined;
    var_2 = self._id_1031E;
    var_3 = var_0.objweapon.basename;
    var_4 = _id_1003F();
    var_5 = var_4._id_EC5C;

    if(isDefined(var_4._id_EC5C._id_DDA3[var_2])) {
      var_1 = var_4._id_EC5C._id_DDA3[var_2][var_3];
    }

    if(isDefined(var_1)) {
      return var_1;
    }

    var_6 = _id_10041(var_2, undefined, 1);

    if(isDefined(var_6)) {
      var_7 = var_6.class;

      if(!isDefined(var_7) || var_7 == "none") {
        return 1;
      }

      if(isDefined(var_4._id_EC5C._id_DDA2[var_7])) {
        var_1 = var_4._id_EC5C._id_DDA2[var_7][var_3];
      }

      if(isDefined(var_1)) {
        return var_1;
      }
    } else
      return 1;
  } else
    return 1;

  return 0;
}

_id_10062(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.attacker)) {
    var_2 = _id_10041(self._id_1031E, undefined, 1);

    if(isDefined(var_2)) {
      var_3 = _id_1003E(self, undefined, 1);
      var_4 = undefined;
      var_5 = undefined;
      var_6 = undefined;
      var_7 = undefined;

      if(isDefined(var_3)) {
        var_4 = var_3._id_7662;
        var_5 = var_3._id_7663;
        var_6 = var_3._id_7660;
        var_7 = var_3._id_7661;
      }

      if(isDefined(var_2.class)) {
        if(!isDefined(var_4)) {
          switch (var_2.class) {
            case "super_light":
            case "light":
              var_4 = "disabled_vehicle_light";
              break;
            case "medium_heavy":
            case "medium_light":
            case "medium":
              var_4 = "disabled_vehicle_medium";
              break;
            case "super_heavy":
            case "heavy":
              var_4 = "disabled_vehicle_heavy";
              break;
          }
        }

        if(!isDefined(var_6)) {}
      }

      if(isDefined(var_4) && var_4 == "none") {
        var_4 = undefined;
      }

      if(isDefined(var_6) && var_6 == "none") {
        var_6 = undefined;
      }

      if(!istrue(var_1._id_6FD2)) {
        var_1._id_6FD2 = scripts\cp_mp\vehicles\vehicle::_id_10122(self, var_1.attacker);
      }

      if(isDefined(var_1.objweapon) && weaponclass(var_1.objweapon.basename) != "rocketlauncher") {
        if(istrue(var_5)) {
          var_1._id_CBFF = 1;
        }

        if(istrue(var_7)) {
          var_1._id_1FCA = 1;
        }
      }

      var_1.attacker thread _id_1004A(var_4, var_6, var_1, self);

      if(isDefined(level._id_6016["createGameTypeChallenegeEvent"])) {
        var_1.attacker thread scripts\engine\utility::_id_CD61("createGameTypeChallenegeEvent", "disabled_vehicle");
      }
    }
  }
}

_id_10060(var_0) {
  if(isDefined(var_0) && isDefined(var_0.attacker)) {
    var_1 = _id_10041(self._id_1031E, undefined, 1);

    if(isDefined(var_1)) {
      var_2 = _id_1003E(self, undefined, 1);
      var_3 = undefined;
      var_4 = undefined;
      var_5 = undefined;
      var_6 = undefined;

      if(isDefined(var_2)) {
        var_3 = var_2._id_4861;
        var_4 = var_2._id_4862;
        var_5 = var_2._id_483F;
        var_6 = var_2._id_4840;
      }

      if(scripts\engine\utility::is_equal(level.gametype, "base")) {
        switch (self._id_1031E) {
          case "s4_tank":
            var_3 = "destroyed_vehicle_tank";
            break;
          case "open_jeep":
            var_3 = "destroyed_vehicle_jeep";
            break;
          case "motorcycle":
            var_3 = "destroyed_vehicle_motorcycle";
            break;
          case "cargo_truck_susp":
            var_3 = "destroyed_vehicle_truck";
            break;
        }
      }

      if(isDefined(var_1.class)) {
        if(!isDefined(var_3)) {
          switch (var_1.class) {
            case "super_light":
            case "light":
              var_3 = "destroyed_vehicle_light";
              break;
            case "medium_heavy":
            case "medium_light":
            case "medium":
              var_3 = "destroyed_vehicle_medium";
              break;
            case "super_heavy":
            case "heavy":
              var_3 = "destroyed_vehicle_heavy";
              break;
            default:
              var_3 = "none";
              break;
          }
        }

        if(!isDefined(var_5)) {}
      }

      if(isDefined(var_3) && var_3 == "none") {
        var_3 = undefined;
      }

      if(isDefined(var_5) && var_5 == "none") {
        var_5 = undefined;
      }

      if(!isDefined(var_0._id_6FD2)) {
        var_0._id_6FD2 = scripts\cp_mp\vehicles\vehicle::_id_10122(self, var_0.attacker);
      } else if(var_0._id_6FD2 && scripts\cp_mp\vehicles\vehicle::_id_10124(self, var_0.attacker)) {
        var_0._id_6FD2 = 0;
      } else if(!var_0._id_6FD2 && scripts\cp_mp\vehicles\vehicle::_id_10122(self, var_0.attacker)) {
        var_0._id_6FD2 = 1;
      }

      if(isDefined(var_0.objweapon) && weaponclass(var_0.objweapon.basename) != "rocketlauncher") {
        if(istrue(var_4)) {
          var_0._id_CBFF = 1;
        }

        if(istrue(var_6)) {
          var_0._id_1FCA = 1;
        }
      }

      if(var_0._id_6FD2 && scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onVehicleKilled")) {
        var_0.attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onVehicleKilled")]](self, var_0.attacker, var_0.damage, var_0.objweapon);
      }

      var_0.attacker _id_10049(var_3, var_5, var_0, self getentitynumber());

      if(scripts\engine\utility::is_equal(level.gametype, "base") && isDefined(level._id_7003)) {
        var_0.attacker thread[[level._id_7003]](var_3, undefined, undefined, undefined, self);
      }
    }
  }
}

_id_1004A(var_0, var_1, var_2, var_3) {
  var_4 = var_3 getentitynumber();
  self endon("disconnect");
  self endon("vehicle_damage_giveScoreAndXP" + var_4);
  waittillframeend;
  thread _id_10049(var_0, var_1, var_3, var_4);
}

_id_10049(var_0, var_1, var_2, var_3) {
  self notify("vehicle_damage_giveScoreAndXP" + var_3);

  if(isDefined(var_0) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "giveScore")) {
    var_4 = scripts\engine\utility::ter_op(istrue(var_2._id_CBFF), undefined, var_2.objweapon);
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "giveScore")]](var_0, var_4, !istrue(var_2._id_6FD2));
  }

  if(isDefined(var_1) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "giveAward")) {
    var_4 = scripts\engine\utility::ter_op(istrue(var_2._id_1FCA), undefined, var_2.objweapon);
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "giveAward")]](var_1, var_4, !istrue(var_2._id_6FD2));
  }
}

_id_10075(var_0, var_1, var_2, var_3) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponClassModDamageForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponClassModDamageForVehicle")]](var_0, var_1, var_2, var_3);
  }
}

_id_1006F(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setPerkModDamage")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setPerkModDamage")]](var_0, var_1, var_2);
  }
}

_id_10076(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageData")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageData")]](var_0, var_1);
  }
}

_id_10073(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageData")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageData")]](var_0, var_1);
  }
}

_id_10074(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]](var_0, var_1, var_2);
  }
}

_id_10077(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]](var_0, var_1, var_2);
  }
}

_id_10071(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setPreModDamageCallback")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setPreModDamageCallback")]](var_0, var_1);
  }
}

_id_10070(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setPostModDamageCallback")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setPostModDamageCallback")]](var_0, var_1);
  }
}

_id_1006E(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setDeathCallback")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setDeathCallback")]](var_0, var_1);
  }
}

_id_1004E() {
  setdvarifuninitialized("#x328326c8a9e3d4fab", 0);
  setdvarifuninitialized("#x3d621d512b064d18", 0);
}