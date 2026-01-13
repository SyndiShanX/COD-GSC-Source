/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\2857.gsc
*********************************************/

init() {
  level.var_66A3 = [];
  level.var_66AC = 1000;
  level.var_66AB = 1000;
  level.player.var_110BD = "";
  level.player.var_110BE = 0;
  level.player.var_110BA = "";
  level.player.var_110BB = 0;
  level.player.curobjid = "";
  level.player.var_4B21 = "";
  level.player.var_110C0 = 0;
  thread func_11B9();
  level.player thread func_13FF();
  func_135F();
  thread func_1271();
}

func_F391(var_0, var_1) {
  var_2 = strtok(var_0, "_");
  var_3 = undefined;
  var_4 = undefined;
  var_5 = level.player getweaponslistoffhands();
  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    if(func_12F5(var_5[var_6])) {
      var_3 = strtok(var_5[var_6], "_");
    }

    if(func_12F1(var_5[var_6])) {
      var_4 = strtok(var_5[var_6], "_");
    }
  }

  var_7 = _freeze_until_phototaken(var_1, 0, 1, -1, 1000);
  var_8 = 0;
  if(isDefined(var_3) && var_2[0] == var_3[0]) {
    if(level.var_66AC > var_7) {
      var_8 = 1;
    }

    setomnvar("ui_power_recharge", int(var_7));
    setomnvar("ui_power_consume", var_8);
    level.var_66AC = var_7;
    return;
  }

  if(isDefined(var_4) && var_2[0] == var_4[0]) {
    if(level.var_66AB > var_7) {
      var_8 = 1;
    }

    setomnvar("ui_power_secondary_recharge", int(var_7));
    setomnvar("ui_power_secondary_consume", var_8);
    level.var_66AB = var_7;
    return;
  }
}

func_F392(var_0, var_1) {
  var_2 = strtok(var_0, "_");
  var_3 = undefined;
  var_4 = undefined;
  var_5 = level.player getweaponslistoffhands();
  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    if(func_12F5(var_5[var_6])) {
      var_3 = strtok(var_5[var_6], "_");
    }

    if(func_12F1(var_5[var_6])) {
      var_4 = strtok(var_5[var_6], "_");
    }
  }

  if(isDefined(var_3) && var_2[0] == var_3[0]) {
    setomnvar("ui_power_disabled", var_1);
    return;
  }

  if(isDefined(var_4) && var_2[0] == var_4[0]) {
    setomnvar("ui_power_secondary_disabled", var_1);
    return;
  }
}

func_11456(var_0) {
  if(self.var_110BD == var_0) {
    self.var_110BD = "";
    self.var_110BE = 0;
  }

  if(self.var_110BA == var_0) {
    self.var_110BA = "";
    self.var_110BB = 0;
  }
}

func_11427() {
  self.var_110BD = "";
  self.var_110BE = 0;
  self.var_110BA = "";
  self.var_110BB = 0;
}

func_135F() {
  level.var_D79A = [];
  var_0 = 0;
  for(;;) {
    var_1 = tablelookupbyrow("sp\powertable.csv", var_0, 0);
    if(var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("sp\powertable.csv", var_0, 1);
    level.var_D79A[var_2] = spawnStruct();
    level.var_D79A[var_2].id = var_1;
    level.var_D79A[var_2].cooldown = tablelookupbyrow("sp\powertable.csv", var_0, 6);
    level.var_D79A[var_2].maxcharges = tablelookupbyrow("sp\powertable.csv", var_0, 7);
    level.var_D79A[var_2].var_1030F = tablelookupbyrow("sp\powertable.csv", var_0, 8);
    level.var_D79A[var_2].var_1E4E = tablelookupbyrow("sp\powertable.csv", var_0, 9);
    var_0++;
  }
}

func_129C(var_0) {
  return func_12A4(var_0).var_1E4E;
}

func_12A4(var_0) {
  var_1 = strtok(var_0, "_");
  if(!isDefined(level.var_D79A[var_1[0]])) {
    level.var_D79A[var_1[0]] = level.var_D79A["none"];
    return level.var_D79A[var_1[0]];
  }

  return level.var_D79A[var_1[0]];
}

func_12A3(var_0) {
  var_1 = func_12A4(var_0);
  return var_1.var_1030F;
}

func_12F5(var_0) {
  return func_12A3(var_0) == "0";
}

func_12F1(var_0) {
  return func_12A3(var_0) == "1";
}

func_11B9() {
  level.player endon("death");
  var_0 = "none";
  var_1 = 0;
  for(;;) {
    var_2 = level.player getcurrentprimaryweapon();
    if(!isDefined(var_2)) {
      wait(0.05);
      continue;
    }

    var_3 = level.player getweaponammostock(var_2);
    if(var_2 != var_0) {
      var_0 = var_2;
      var_1 = var_3;
      wait(0.05);
      continue;
    }

    if(var_3 != var_1) {
      if(var_3 > var_1) {
        level.player notify("current_primary_ammo");
      }

      var_1 = var_3;
    }

    wait(0.05);
  }
}

func_1270(var_0) {
  var_1 = [];
  foreach(var_3 in var_0) {
    var_4 = level.player func_854C(var_3);
    if(var_4 != "scriptoffhand") {
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  if(isDefined(level.player.var_1180A) && level.player.var_1180A == 1) {
    var_6 = level.player.var_127C1;
    if(var_6 != level.player.curobjid && var_6 != level.player.var_4B21) {
      level.player takeweapon(var_6);
      var_1 = scripts\engine\utility::array_remove(var_1, var_6);
    }

    level.player.var_1180A = 0;
    level.player.var_127C1 = "none";
    level.player.var_1180B = "none";
    level.player.var_AA2B = "none";
  } else if(level.player.var_1180B != level.player.var_AA2B && level.player.var_AA2B != "none") {
    if(level.player.var_AA2B != level.player.curobjid && level.player.var_AA2B != level.player.var_4B21) {
      level.player takeweapon(level.player.var_AA2B);
      var_1 = scripts\engine\utility::array_remove(var_1, level.player.var_AA2B);
    }
  } else if(level.player.var_1180B != "none") {
    if(level.player.var_1180B != level.player.curobjid && level.player.var_1180B != level.player.var_4B21) {
      var_1 = scripts\engine\utility::array_remove(var_1, level.player.var_1180B);
    }
  }

  return var_1;
}

func_1271() {
  level.player endon("death");
  level.player.var_1180B = "none";
  var_0 = level.player getweaponslistoffhands();
  var_1 = "";
  var_2 = "";
  var_3 = 0;
  var_4 = 0;
  var_5 = "";
  var_6 = "";
  var_7 = 0;
  var_8 = 0;
  var_9 = [];
  var_0A = "";
  var_0B = "";
  var_0C = "";
  var_0D = "";
  for(;;) {
    waittillframeend;
    level.player.var_AA2B = level.player.var_1180B;
    level.player.var_1180B = level.player func_8556();
    if(level.player func_8448()) {
      level.player.var_1180A = 1;
      level.player.var_127C1 = level.player func_8556();
      wait(0.05);
      continue;
    }

    var_9 = level.player getweaponslistoffhands();
    var_9 = func_1270(var_9);
    func_142E(var_9, var_0);
    var_9 = level.player getweaponslistoffhands();
    var_9 = func_1270(var_9);
    var_0A = "";
    var_0B = "";
    var_0E = 0;
    var_0F = 0;
    var_10 = 0;
    var_11 = 0;
    for(var_12 = 0; var_12 < var_9.size; var_12++) {
      if(func_12F5(var_9[var_12])) {
        var_0A = var_9[var_12];
      }

      if(func_12F1(var_9[var_12])) {
        var_0B = var_9[var_12];
      }
    }

    var_0C = level.player.var_110BD;
    var_0D = level.player.var_110BA;
    level.player.curobjid = var_0A;
    level.player.var_4B21 = var_0B;
    if(var_0A != var_1) {
      var_0E = 1;
      level.player notify("primary_equipment_change", var_0A);
    }

    if(var_0B != var_2) {
      var_0F = 1;
      level.player notify("secondary_equipment_change", var_0B);
    }

    if(var_0C != var_5) {
      var_10 = 1;
      level.player notify("stored_primary_equipment_change", var_0C);
    }

    if(var_0D != var_6) {
      var_11 = 1;
      level.player notify("stored_secondary_equipment_change", var_0D);
    }

    if(var_0E == 1 || var_0F == 1) {
      level.player notify("equipment_change");
    }

    if(var_0A == "") {
      func_11A6();
    } else {
      var_13 = level.player getrunningforwardpainanim(var_0A);
      if(var_0E == 0 && var_13 != var_3) {
        level.player notify("offhand_ammo");
        var_3 = var_13;
      }

      func_1434(var_0A, var_13, var_0E);
    }

    if(var_0B == "") {
      func_11A5();
    } else {
      var_13 = level.player getrunningforwardpainanim(var_0B);
      if(var_0F == 0 && var_13 != var_4) {
        level.player notify("item_ammo");
        var_4 = var_13;
      }

      func_1433(var_0B, var_13, var_0F);
    }

    if(var_0C == "") {
      func_11A8();
    } else {
      func_1436(var_0C, level.player.var_110BE, var_10);
    }

    if(var_0D == "") {
      func_11A7();
    } else {
      func_1435(var_0D, level.player.var_110BB, var_11);
    }

    var_0 = var_9;
    var_1 = var_0A;
    var_2 = var_0B;
    var_5 = var_0C;
    var_6 = var_0D;
    wait(0.05);
  }
}

func_142E(var_0, var_1) {
  var_2 = [];
  var_3 = [];
  var_4 = 0;
  var_5 = 0;
  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    if(func_12F5(var_0[var_6])) {
      var_4 = 1;
    }

    if(func_12F1(var_0[var_6])) {
      var_5 = 1;
    }
  }

  if(level.player.var_110C0 && var_4 == 0 && level.player.var_110BD != "") {
    level.player giveweapon(level.player.var_110BD);
    level.player assignweaponoffhandprimary(level.player.var_110BD);
    level.player setweaponammoclip(level.player.var_110BD, level.player.var_110BE);
    level.player.var_110BD = "";
    level.player.var_110BE = 0;
  }

  if(level.player.var_110C0 && var_5 == 0 && level.player.var_110BA != "") {
    level.player giveweapon(level.player.var_110BA);
    level.player assignweaponoffhandsecondary(level.player.var_110BA);
    level.player setweaponammoclip(level.player.var_110BA, level.player.var_110BB);
    level.player.var_110BA = "";
    level.player.var_110BB = 0;
  }

  foreach(var_8 in var_0) {
    if(!scripts\engine\utility::array_contains(var_1, var_8)) {
      if(func_12F5(var_8)) {
        if(var_2.size > 1) {
          level.player takeweapon(var_2[1]);
          var_2[1] = var_8;
          continue;
        }

        var_2[var_2.size] = var_8;
        continue;
      }

      if(func_12F1(var_8)) {
        if(var_3.size > 1) {
          level.player takeweapon(var_3[1]);
          var_3[1] = var_8;
          continue;
        }

        var_3[var_3.size] = var_8;
      }
    }
  }

  var_0A = undefined;
  var_0B = undefined;
  foreach(var_8 in var_1) {
    if(!scripts\engine\utility::array_contains(var_0, var_8)) {
      continue;
    }

    if(func_12F5(var_8)) {
      var_0A = var_8;
      continue;
    }

    if(func_12F1(var_8)) {
      var_0B = var_8;
    }
  }

  if(var_2.size > 0) {
    if(isDefined(var_0A) && level.player.var_110C0) {
      if(level.player.var_110BD == "") {
        level.player.var_110BE = level.player getrunningforwardpainanim(var_0A);
        level.player.var_110BD = var_0A;
        level.player takeweapon(var_0A);
      } else if(var_2[0] == level.player.var_110BD) {
        level.player.var_110BE = level.player getrunningforwardpainanim(var_0A);
        level.player.var_110BD = var_0A;
        level.player takeweapon(var_0A);
      }

      level.player takeweapon(var_0A);
    } else if(isDefined(var_0A)) {
      level.player takeweapon(var_0A);
    }

    level.player func_844D();
    level.player assignweaponoffhandprimary(var_2[0]);
    if(var_2.size > 1) {
      if(level.player.var_110C0) {
        level.player.var_110BE = level.player getrunningforwardpainanim(var_2[1]);
        level.player.var_110BD = var_2[1];
        level.player takeweapon(var_2[1]);
      } else {
        level.player takeweapon(var_2[1]);
      }
    }
  }

  if(var_3.size > 0) {
    if(isDefined(var_0B) && level.player.var_110C0) {
      if(level.player.var_110BA == "") {
        level.player.var_110BB = level.player getrunningforwardpainanim(var_0B);
        level.player.var_110BA = var_0B;
        level.player takeweapon(var_0B);
      } else if(var_3[0] == level.player.var_110BA) {
        level.player.var_110BB = level.player getrunningforwardpainanim(var_0B);
        level.player.var_110BA = var_0B;
        level.player takeweapon(var_0B);
      }

      level.player takeweapon(var_0B);
    } else if(isDefined(var_0B)) {
      level.player takeweapon(var_0B);
    }

    level.player gonevo();
    level.player assignweaponoffhandsecondary(var_3[0]);
    if(var_3.size > 1) {
      if(level.player.var_110C0) {
        level.player.var_110BB = level.player getrunningforwardpainanim(var_3[1]);
        level.player.var_110BA = var_3[1];
        level.player takeweapon(var_3[1]);
      } else {
        level.player takeweapon(var_3[1]);
      }
    }
  }

  if(!level.player.var_110C0 && level.player.var_110BD != "") {
    level.player.var_110BD = "";
    level.player.var_110BE = 0;
  }

  if(!level.player.var_110C0 && level.player.var_110BA != "") {
    level.player.var_110BA = "";
    level.player.var_110BB = 0;
  }
}

func_1434(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  setomnvar("ui_power_num_charges", int(var_1));
  setomnvar("ui_power_id", int(func_12A4(var_0).id));
  setomnvar("ui_power_disabled", 0);
  if(var_2 == 1) {
    setomnvar("ui_power_recharge", int(1000));
    setomnvar("ui_power_consume", 0);
  }
}

func_1436(var_0, var_1, var_2) {
  setomnvar("ui_power_stored_show", 1);
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  setomnvar("ui_power_stored_num_charges", int(var_1));
  setomnvar("ui_powerfunc_stored", int(func_12A4(var_0).id));
  setomnvar("ui_power_stored_disabled", 0);
  setomnvar("ui_power_stored_recharge", int(1000));
  setomnvar("ui_power_stored_consume", 0);
}

func_1433(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  setomnvar("ui_power_secondary_num_charges", int(var_1));
  setomnvar("ui_powerfunc_secondary", int(func_12A4(var_0).id));
  setomnvar("ui_power_secondary_disabled", 0);
  if(var_2 == 1) {
    setomnvar("ui_power_secondary_recharge", int(1000));
    setomnvar("ui_power_secondary_consume", 0);
  }
}

func_1435(var_0, var_1, var_2) {
  setomnvar("ui_power_secondary_stored_show", 1);
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  setomnvar("ui_power_secondary_stored_num_charges", int(var_1));
  setomnvar("ui_powerfunc_secondary_stored", int(func_12A4(var_0).id));
  setomnvar("ui_power_secondary_stored_disabled", 0);
  setomnvar("ui_power_secondary_stored_recharge", int(1000));
  setomnvar("ui_power_secondary_stored_consume", 0);
}

func_11A6() {
  setomnvar("ui_power_num_charges", 0);
  setomnvar("ui_power_id", 0);
  setomnvar("ui_power_disabled", 0);
  setomnvar("ui_power_recharge", 0);
  setomnvar("ui_power_consume", 0);
}

func_11A8() {
  setomnvar("ui_power_stored_show", 0);
  setomnvar("ui_power_stored_num_charges", 0);
  setomnvar("ui_powerfunc_stored", 0);
  setomnvar("ui_power_stored_disabled", 0);
  setomnvar("ui_power_stored_recharge", 0);
  setomnvar("ui_power_stored_consume", 0);
}

func_11A5() {
  setomnvar("ui_power_secondary_num_charges", 0);
  setomnvar("ui_powerfunc_secondary", 0);
  setomnvar("ui_power_secondary_disabled", 0);
  setomnvar("ui_power_secondary_recharge", 0);
  setomnvar("ui_power_secondary_consume", 0);
}

func_11A7() {
  setomnvar("ui_power_secondary_stored_show", 0);
  setomnvar("ui_power_secondary_stored_num_charges", 0);
  setomnvar("ui_powerfunc_secondary_stored", 0);
  setomnvar("ui_power_secondary_stored_disabled", 0);
  setomnvar("ui_power_secondary_stored_recharge", 0);
  setomnvar("ui_power_secondary_stored_consume", 0);
}

func_13FF() {
  self endon("death");
  thread func_1400();
  thread func_12E3();
  thread func_11A0();
  for(;;) {
    scripts\engine\utility::waittill_any_3("weapon_fired", "aim", "melee", "reload_start", "stand", "weapon_change", "weapon_swap", "hide_hud_omnvar_changed");
    func_1401();
  }
}

func_1400() {
  self endon("death");
  for(;;) {
    scripts\engine\utility::waittill_any_3("equipment_change", "current_primary_ammo", "offhand_ammo", "item_ammo", "sprint_begin", "offhandshield_retract");
    func_1401();
  }
}

func_1401() {
  var_0 = scripts\sp\utility::func_7B8C();
  var_1 = self getcurrentprimaryweapon();
  if(var_0 != "safe" && var_1 != "iw7_gunless") {
    setomnvar("ui_hide_weapon_info", 0);
  }

  self notify("cancel_hide_hud");
  setomnvar("ui_hud_hidden_by_timer", 0);
  wait(1);
  thread func_12E3();
}

func_12E3() {
  self endon("death");
  self endon("cancel_hide_hud");
  wait(30);
  setomnvar("ui_hide_weapon_info", 1);
  setomnvar("ui_hud_hidden_by_timer", 1);
  thread func_12E0();
}

func_12E0() {
  self endon("death");
  var_0 = getomnvar("ui_hide_hud");
  var_1 = getomnvar("ui_hide_weapon_info");
  while(getomnvar("ui_hide_hud") == var_0 && getomnvar("ui_hide_weapon_info") == var_1) {
    scripts\engine\utility::waitframe();
  }

  self notify("hide_hud_omnvar_changed");
}

func_11A0() {
  self endon("death");
  for(;;) {
    if(self adsbuttonpressed()) {
      self notify("aim");
    }

    if(self meleebuttonpressed()) {
      self notify("melee");
    }

    scripts\engine\utility::waitframe();
  }
}

_freeze_until_phototaken(var_0, var_1, var_2, var_3, var_4) {
  return var_0 - var_1 / var_2 - var_1 * var_4 - var_3 + var_3;
}

func_1295(var_0) {
  var_1 = strtok(var_0, "_");
  var_2 = var_1[var_1.size - 1];
  if(issubstr(var_2, "up1") || issubstr(var_2, "up2")) {
    var_3 = "";
    for(var_4 = 0; var_4 < var_1.size - 1; var_4++) {
      var_3 = var_3 + var_1[var_4];
    }

    return var_3;
  }

  return var_2;
}