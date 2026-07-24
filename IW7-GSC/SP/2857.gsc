/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2857.gsc
**************************************/

init() {
  level._id_66A3 = [];
  level._id_66AC = 1000;
  level._id_66AB = 1000;
  level.player._id_110BD = "";
  level.player._id_110BE = 0;
  level.player._id_110BA = "";
  level.player._id_110BB = 0;
  level.player.curobjid = "";
  level.player._id_4B21 = "";
  level.player._id_110C0 = 0;
  thread _id_11B9();
  level.player thread _id_13FF();
  _id_135F();
  thread _id_1271();
}

_id_F391(var_0, var_1) {
  var_2 = strtok(var_0, "_");
  var_3 = undefined;
  var_4 = undefined;
  var_5 = level.player getweaponslistall();

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    if(_id_12F5(var_5[var_6])) {
      var_3 = strtok(var_5[var_6], "_");
    }

    if(_id_12F1(var_5[var_6])) {
      var_4 = strtok(var_5[var_6], "_");
    }
  }

  var_7 = _freeze_until_phototaken(var_1, 0.0, 1.0, -1, 1000);
  var_8 = 0;

  if(isDefined(var_3) && var_2[0] == var_3[0]) {
    if(level._id_66AC > var_7) {
      var_8 = 1;
    }

    setomnvar("ui_power_recharge", int(var_7));
    setomnvar("ui_power_consume", var_8);
    level._id_66AC = var_7;
  } else if(isDefined(var_4) && var_2[0] == var_4[0]) {
    if(level._id_66AB > var_7) {
      var_8 = 1;
    }

    setomnvar("ui_power_secondary_recharge", int(var_7));
    setomnvar("ui_power_secondary_consume", var_8);
    level._id_66AB = var_7;
  } else {}
}

_id_F392(var_0, var_1) {
  var_2 = strtok(var_0, "_");
  var_3 = undefined;
  var_4 = undefined;
  var_5 = level.player getweaponslistall();

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    if(_id_12F5(var_5[var_6])) {
      var_3 = strtok(var_5[var_6], "_");
    }

    if(_id_12F1(var_5[var_6])) {
      var_4 = strtok(var_5[var_6], "_");
    }
  }

  if(isDefined(var_3) && var_2[0] == var_3[0]) {
    setomnvar("ui_power_disabled", var_1);
  } else if(isDefined(var_4) && var_2[0] == var_4[0]) {
    setomnvar("ui_power_secondary_disabled", var_1);
  } else {}
}

_id_11456(var_0) {
  if(self._id_110BD == var_0) {
    self._id_110BD = "";
    self._id_110BE = 0;
  }

  if(self._id_110BA == var_0) {
    self._id_110BA = "";
    self._id_110BB = 0;
  }
}

_id_11427() {
  self._id_110BD = "";
  self._id_110BE = 0;
  self._id_110BA = "";
  self._id_110BB = 0;
}

_id_135F() {
  level._id_D79A = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("sp/powertable.csv", var_0, 0);

    if(var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("sp/powertable.csv", var_0, 1);
    level._id_D79A[var_2] = spawnStruct();
    level._id_D79A[var_2].id = var_1;
    level._id_D79A[var_2].cooldown = tablelookupbyrow("sp/powertable.csv", var_0, 6);
    level._id_D79A[var_2].maxcharges = tablelookupbyrow("sp/powertable.csv", var_0, 7);
    level._id_D79A[var_2]._id_1030F = tablelookupbyrow("sp/powertable.csv", var_0, 8);
    level._id_D79A[var_2]._id_1E4E = tablelookupbyrow("sp/powertable.csv", var_0, 9);
    var_0++;
  }
}

_id_129C(var_0) {
  return _id_12A4(var_0)._id_1E4E;
}

_id_12A4(var_0) {
  var_1 = strtok(var_0, "_");

  if(!isDefined(level._id_D79A[var_1[0]])) {
    level._id_D79A[var_1[0]] = level._id_D79A["none"];
    return level._id_D79A[var_1[0]];
  }

  return level._id_D79A[var_1[0]];
}

_id_12A3(var_0) {
  var_1 = _id_12A4(var_0);
  return var_1._id_1030F;
}

_id_12F5(var_0) {
  return _id_12A3(var_0) == "0";
}

_id_12F1(var_0) {
  return _id_12A3(var_0) == "1";
}

_id_11B9() {
  level.player endon("death");
  var_0 = "none";
  var_1 = 0;

  for(;;) {
    var_2 = level.player getcurrentprimaryweapon();

    if(!isDefined(var_2)) {
      wait 0.05;
      continue;
    }

    var_3 = level.player getweaponammostock(var_2);

    if(var_2 != var_0) {
      var_0 = var_2;
      var_1 = var_3;
      wait 0.05;
      continue;
    }

    if(var_3 != var_1) {
      if(var_3 > var_1) {
        level.player notify("current_primary_ammo");
      }

      var_1 = var_3;
    }

    wait 0.05;
  }
}

_id_1270(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = level.player _meth_854C(var_3);

    if(var_4 != "scriptoffhand") {
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  if(isDefined(level.player._id_1180A) && level.player._id_1180A == 1) {
    var_6 = level.player._id_127C1;

    if(var_6 != level.player.curobjid && var_6 != level.player._id_4B21) {
      level.player takeweapon(var_6);
      var_1 = scripts\engine\utility::array_remove(var_1, var_6);
    }

    level.player._id_1180A = 0;
    level.player._id_127C1 = "none";
    level.player._id_1180B = "none";
    level.player._id_AA2B = "none";
  } else if(level.player._id_1180B != level.player._id_AA2B && level.player._id_AA2B != "none") {
    if(level.player._id_AA2B != level.player.curobjid && level.player._id_AA2B != level.player._id_4B21) {
      level.player takeweapon(level.player._id_AA2B);
      var_1 = scripts\engine\utility::array_remove(var_1, level.player._id_AA2B);
    }
  } else if(level.player._id_1180B != "none") {
    if(level.player._id_1180B != level.player.curobjid && level.player._id_1180B != level.player._id_4B21) {
      var_1 = scripts\engine\utility::array_remove(var_1, level.player._id_1180B);
    }
  }

  return var_1;
}

_id_1271() {
  level.player endon("death");
  level.player._id_1180B = "none";
  var_0 = level.player getweaponslistall();
  var_1 = "";
  var_2 = "";
  var_3 = 0;
  var_4 = 0;
  var_5 = "";
  var_6 = "";
  var_7 = 0;
  var_8 = 0;
  var_9 = [];
  var_10 = "";
  var_11 = "";
  var_12 = "";
  var_13 = "";

  for(;;) {
    waittillframeend;
    level.player._id_AA2B = level.player._id_1180B;
    level.player._id_1180B = level.player _meth_8556();

    if(level.player _meth_8448()) {
      level.player._id_1180A = 1;
      level.player._id_127C1 = level.player _meth_8556();
      wait 0.05;
      continue;
    }

    var_9 = level.player getweaponslistall();
    var_9 = _id_1270(var_9);
    _id_142E(var_9, var_0);
    var_9 = level.player getweaponslistall();
    var_9 = _id_1270(var_9);
    var_10 = "";
    var_11 = "";
    var_14 = 0;
    var_15 = 0;
    var_16 = 0;
    var_17 = 0;

    for(var_18 = 0; var_18 < var_9.size; var_18++) {
      if(_id_12F5(var_9[var_18])) {
        var_10 = var_9[var_18];
      }

      if(_id_12F1(var_9[var_18])) {
        var_11 = var_9[var_18];
      }
    }

    var_12 = level.player._id_110BD;
    var_13 = level.player._id_110BA;
    level.player.curobjid = var_10;
    level.player._id_4B21 = var_11;

    if(var_10 != var_1) {
      var_14 = 1;
      level.player notify("primary_equipment_change", var_10);
    }

    if(var_11 != var_2) {
      var_15 = 1;
      level.player notify("secondary_equipment_change", var_11);
    }

    if(var_12 != var_5) {
      var_16 = 1;
      level.player notify("stored_primary_equipment_change", var_12);
    }

    if(var_13 != var_6) {
      var_17 = 1;
      level.player notify("stored_secondary_equipment_change", var_13);
    }

    if(var_14 == 1 || var_15 == 1) {
      level.player notify("equipment_change");
    }

    if(var_10 == "") {
      _id_11A6();
    } else {
      var_19 = level.player getammocount(var_10);

      if(var_14 == 0 && var_19 != var_3) {
        level.player notify("offhand_ammo");
        var_3 = var_19;
      }

      _id_1434(var_10, var_19, var_14);
    }

    if(var_11 == "") {
      _id_11A5();
    } else {
      var_19 = level.player getammocount(var_11);

      if(var_15 == 0 && var_19 != var_4) {
        level.player notify("item_ammo");
        var_4 = var_19;
      }

      _id_1433(var_11, var_19, var_15);
    }

    if(var_12 == "") {
      _id_11A8();
    } else {
      _id_1436(var_12, level.player._id_110BE, var_16);
    }

    if(var_13 == "") {
      _id_11A7();
    } else {
      _id_1435(var_13, level.player._id_110BB, var_17);
    }

    var_0 = var_9;
    var_1 = var_10;
    var_2 = var_11;
    var_5 = var_12;
    var_6 = var_13;
    wait 0.05;
  }
}

_id_142E(var_0, var_1) {
  var_2 = [];
  var_3 = [];
  var_4 = 0;
  var_5 = 0;

  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    if(_id_12F5(var_0[var_6])) {
      var_4 = 1;
    }

    if(_id_12F1(var_0[var_6])) {
      var_5 = 1;
    }
  }

  if(level.player._id_110C0 && var_4 == 0 && level.player._id_110BD != "") {
    level.player giveweapon(level.player._id_110BD);
    level.player assignweaponoffhandprimary(level.player._id_110BD);
    level.player setweaponammoclip(level.player._id_110BD, level.player._id_110BE);
    level.player._id_110BD = "";
    level.player._id_110BE = 0;
  }

  if(level.player._id_110C0 && var_5 == 0 && level.player._id_110BA != "") {
    level.player giveweapon(level.player._id_110BA);
    level.player assignweaponoffhandsecondary(level.player._id_110BA);
    level.player setweaponammoclip(level.player._id_110BA, level.player._id_110BB);
    level.player._id_110BA = "";
    level.player._id_110BB = 0;
  }

  foreach(var_8 in var_0) {
    if(!scripts\engine\utility::array_contains(var_1, var_8)) {
      if(_id_12F5(var_8)) {
        if(var_2.size > 1) {
          level.player takeweapon(var_2[1]);
          var_2[1] = var_8;
          continue;
        }

        var_2[var_2.size] = var_8;
        continue;
      }

      if(_id_12F1(var_8)) {
        if(var_3.size > 1) {
          level.player takeweapon(var_3[1]);
          var_3[1] = var_8;
          continue;
        }

        var_3[var_3.size] = var_8;
      }
    }
  }

  var_10 = undefined;
  var_11 = undefined;

  foreach(var_8 in var_1) {
    if(!scripts\engine\utility::array_contains(var_0, var_8)) {
      continue;
    }
    if(_id_12F5(var_8)) {
      var_10 = var_8;
      continue;
    }

    if(_id_12F1(var_8)) {
      var_11 = var_8;
    }
  }

  if(var_2.size > 0) {
    if(isDefined(var_10) && level.player._id_110C0) {
      if(level.player._id_110BD == "") {
        level.player._id_110BE = level.player getammocount(var_10);
        level.player._id_110BD = var_10;
        level.player takeweapon(var_10);
      } else if(var_2[0] == level.player._id_110BD) {
        level.player._id_110BE = level.player getammocount(var_10);
        level.player._id_110BD = var_10;
        level.player takeweapon(var_10);
      }

      level.player takeweapon(var_10);
    } else if(isDefined(var_10))
      level.player takeweapon(var_10);

    level.player _meth_844D();
    level.player assignweaponoffhandprimary(var_2[0]);

    if(var_2.size > 1) {
      if(level.player._id_110C0) {
        level.player._id_110BE = level.player getammocount(var_2[1]);
        level.player._id_110BD = var_2[1];
        level.player takeweapon(var_2[1]);
      } else
        level.player takeweapon(var_2[1]);
    }
  }

  if(var_3.size > 0) {
    if(isDefined(var_11) && level.player._id_110C0) {
      if(level.player._id_110BA == "") {
        level.player._id_110BB = level.player getammocount(var_11);
        level.player._id_110BA = var_11;
        level.player takeweapon(var_11);
      } else if(var_3[0] == level.player._id_110BA) {
        level.player._id_110BB = level.player getammocount(var_11);
        level.player._id_110BA = var_11;
        level.player takeweapon(var_11);
      }

      level.player takeweapon(var_11);
    } else if(isDefined(var_11))
      level.player takeweapon(var_11);

    level.player _meth_844E();
    level.player assignweaponoffhandsecondary(var_3[0]);

    if(var_3.size > 1) {
      if(level.player._id_110C0) {
        level.player._id_110BB = level.player getammocount(var_3[1]);
        level.player._id_110BA = var_3[1];
        level.player takeweapon(var_3[1]);
      } else
        level.player takeweapon(var_3[1]);
    }
  }

  if(!level.player._id_110C0 && level.player._id_110BD != "") {
    level.player._id_110BD = "";
    level.player._id_110BE = 0;
  }

  if(!level.player._id_110C0 && level.player._id_110BA != "") {
    level.player._id_110BA = "";
    level.player._id_110BB = 0;
  }
}

_id_1434(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  setomnvar("ui_power_num_charges", int(var_1));
  setomnvar("ui_power_id", int(_id_12A4(var_0).id));
  setomnvar("ui_power_disabled", 0);

  if(var_2 == 1) {
    setomnvar("ui_power_recharge", int(1000));
    setomnvar("ui_power_consume", 0);
  }
}

_id_1436(var_0, var_1, var_2) {
  setomnvar("ui_power_stored_show", 1);

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  setomnvar("ui_power_stored_num_charges", int(var_1));
  setomnvar("ui_power_id_stored", int(_id_12A4(var_0).id));
  setomnvar("ui_power_stored_disabled", 0);
  setomnvar("ui_power_stored_recharge", int(1000));
  setomnvar("ui_power_stored_consume", 0);
}

_id_1433(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  setomnvar("ui_power_secondary_num_charges", int(var_1));
  setomnvar("ui_power_id_secondary", int(_id_12A4(var_0).id));
  setomnvar("ui_power_secondary_disabled", 0);

  if(var_2 == 1) {
    setomnvar("ui_power_secondary_recharge", int(1000));
    setomnvar("ui_power_secondary_consume", 0);
  }
}

_id_1435(var_0, var_1, var_2) {
  setomnvar("ui_power_secondary_stored_show", 1);

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  setomnvar("ui_power_secondary_stored_num_charges", int(var_1));
  setomnvar("ui_power_id_secondary_stored", int(_id_12A4(var_0).id));
  setomnvar("ui_power_secondary_stored_disabled", 0);
  setomnvar("ui_power_secondary_stored_recharge", int(1000));
  setomnvar("ui_power_secondary_stored_consume", 0);
}

_id_11A6() {
  setomnvar("ui_power_num_charges", 0);
  setomnvar("ui_power_id", 0);
  setomnvar("ui_power_disabled", 0);
  setomnvar("ui_power_recharge", 0);
  setomnvar("ui_power_consume", 0);
}

_id_11A8() {
  setomnvar("ui_power_stored_show", 0);
  setomnvar("ui_power_stored_num_charges", 0);
  setomnvar("ui_power_id_stored", 0);
  setomnvar("ui_power_stored_disabled", 0);
  setomnvar("ui_power_stored_recharge", 0);
  setomnvar("ui_power_stored_consume", 0);
}

_id_11A5() {
  setomnvar("ui_power_secondary_num_charges", 0);
  setomnvar("ui_power_id_secondary", 0);
  setomnvar("ui_power_secondary_disabled", 0);
  setomnvar("ui_power_secondary_recharge", 0);
  setomnvar("ui_power_secondary_consume", 0);
}

_id_11A7() {
  setomnvar("ui_power_secondary_stored_show", 0);
  setomnvar("ui_power_secondary_stored_num_charges", 0);
  setomnvar("ui_power_id_secondary_stored", 0);
  setomnvar("ui_power_secondary_stored_disabled", 0);
  setomnvar("ui_power_secondary_stored_recharge", 0);
  setomnvar("ui_power_secondary_stored_consume", 0);
}

_id_13FF() {
  self endon("death");
  thread _id_1400();
  thread _id_12E3();
  thread _id_11A0();

  for(;;) {
    scripts\engine\utility::waittill_any("weapon_fired", "aim", "melee", "reload_start", "stand", "weapon_change", "weapon_swap", "hide_hud_omnvar_changed");
    _id_1401();
  }
}

_id_1400() {
  self endon("death");

  for(;;) {
    scripts\engine\utility::waittill_any("equipment_change", "current_primary_ammo", "offhand_ammo", "item_ammo", "sprint_begin", "offhandshield_retract");
    _id_1401();
  }
}

_id_1401() {
  var_0 = scripts\sp\utility::_id_7B8C();
  var_1 = self getcurrentprimaryweapon();

  if(var_0 != "safe" && var_1 != "iw7_gunless") {
    setomnvar("ui_hide_weapon_info", 0);
  }

  self notify("cancel_hide_hud");
  setomnvar("ui_hud_hidden_by_timer", 0);
  wait 1.0;
  thread _id_12E3();
}

_id_12E3() {
  self endon("death");
  self endon("cancel_hide_hud");
  wait 30.0;
  setomnvar("ui_hide_weapon_info", 1);
  setomnvar("ui_hud_hidden_by_timer", 1);
  thread _id_12E0();
}

_id_12E0() {
  self endon("death");
  var_0 = getomnvar("ui_hide_hud");
  var_1 = getomnvar("ui_hide_weapon_info");

  while(getomnvar("ui_hide_hud") == var_0 && getomnvar("ui_hide_weapon_info") == var_1) {
    scripts\engine\utility::waitframe();
  }

  self notify("hide_hud_omnvar_changed");
}

_id_11A0() {
  self endon("death");

  for(;;) {
    if(self adsButtonPressed()) {
      self notify("aim");
    }

    if(self meleeButtonPressed()) {
      self notify("melee");
    }

    scripts\engine\utility::waitframe();
  }
}

_freeze_until_phototaken(var_0, var_1, var_2, var_3, var_4) {
  return (var_0 - var_1) / (var_2 - var_1) * (var_4 - var_3) + var_3;
}

_id_1295(var_0) {
  var_1 = strtok(var_0, "_");
  var_2 = var_1[var_1.size - 1];

  if(issubstr(var_2, "up1") || issubstr(var_2, "up2")) {
    var_3 = "";

    for(var_4 = 0; var_4 < var_1.size - 1; var_4++) {
      var_3 = var_3 + var_1[var_4];
    }

    return var_3;
  } else
    return var_0;
}