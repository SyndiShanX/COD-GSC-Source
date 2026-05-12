/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_loadout.gsc
*********************************************/

func_00D5() {
  func_51B7();
  func_523A();
  func_526C();
  func_517D();
  func_516F();
  func_5172();
  func_5171();
  func_5170();
  level.var_1A7D = [];
  level.var_1A6E = 1;
}

func_517D() {
  var_00 = "mp/botClassTable.csv";
  level.var_1B36 = [];
  var_01 = func_1A64();
  var_02 = 0;
  for(;;) {
    var_02++;
    var_03 = tablelookup(var_00, 0, "botPersonalities", var_02);
    var_04 = tablelookup(var_00, 0, "botDifficulties", var_02);
    if(!isDefined(var_03) || var_03 == "") {
      break;
    }

    if(!isDefined(var_04) || var_04 == "") {
      break;
    }

    var_05 = [];
    foreach(var_07 in var_01) {
      var_05[var_07] = tablelookup(var_00, 0, var_07, var_02);
    }

    var_09 = strtok(var_03, "| ");
    var_0A = strtok(var_04, "| ");
    foreach(var_0C in var_09) {
      foreach(var_0E in var_0A) {
        var_0F = func_1A6B(var_0C, var_0E, 1);
        var_10 = spawnStruct();
        var_10.var_5E0B = var_05;
        var_0F.var_5E01[var_0F.var_5E01.size] = var_10;
      }
    }
  }
}

func_526C() {
  var_00 = "mp/botTemplateTable.csv";
  level.var_1B37 = [];
  var_01 = func_1A64();
  var_02 = 0;
  for(;;) {
    var_02++;
    var_03 = tablelookup(var_00, 0, "template_", var_02);
    if(!isDefined(var_03) || var_03 == "") {
      break;
    }

    var_04 = "template_" + var_03;
    level.var_1B37[var_04] = [];
    foreach(var_06 in var_01) {
      var_07 = tablelookup(var_00, 0, var_06, var_02);
      if(isDefined(var_07) && var_07 != "") {
        level.var_1B37[var_04][var_06] = var_07;
      }
    }
  }
}

func_51B7() {
  var_00 = "mp/botDivisionTable.csv";
  level.var_1B30 = [];
  var_01 = func_1A64();
  var_02 = 0;
  for(;;) {
    var_02++;
    var_03 = tablelookup(var_00, 0, "division_", var_02);
    if(!isDefined(var_03) || var_03 == "") {
      break;
    }

    var_04 = "division_" + var_03;
    level.var_1B30[var_04] = [];
    foreach(var_06 in var_01) {
      var_07 = tablelookup(var_00, 0, var_06, var_02);
      if(isDefined(var_07) && var_07 != "") {
        level.var_1B30[var_04][var_06] = var_07;
      }
    }
  }
}

func_523A() {
  var_00 = "mp/botPerkTable.csv";
  level.var_1B38 = [];
  var_01 = func_1A64();
  var_02 = 0;
  for(;;) {
    var_02++;
    var_03 = tablelookup(var_00, 0, "specialty_class_", var_02);
    if(!isDefined(var_03) || var_03 == "") {
      break;
    }

    var_04 = "specialty_class_" + var_03;
    level.var_1B30[var_04] = [];
    foreach(var_06 in var_01) {
      var_07 = tablelookup(var_00, 0, var_06, var_02);
      if(isDefined(var_07) && var_07 != "") {
        level.var_1B38[var_04][var_06] = var_07;
      }
    }
  }
}

func_1995() {
  if(isusingmatchrulesdata()) {
    if(!getmatchrulesdata("commonOption", "allowCustomClasses")) {
      return 0;
    }
  }

  return 1;
}

func_1A68(param_00, param_01, param_02) {
  if(!isusingmatchrulesdata()) {
    return 1;
  }

  if(!func_1995()) {
    return 0;
  }

  if(!isstring(param_01)) {
    param_01 = maps\mp\_utility::func_452B(param_01);
  }

  if(param_01 == "specialty_null") {
    return 1;
  }

  if(param_01 == "none") {
    return 1;
  }

  var_03 = param_00 + "Restricted";
  var_04 = param_00 + "ClassRestricted";
  var_05 = "";
  switch (param_00) {
    case "weapon":
      var_05 = maps\mp\_utility::func_472A(param_01);
      break;

    case "attachment":
      var_05 = maps\mp\_utility::func_4429(param_01);
      break;

    case "killstreak":
      if(getmatchrulesdata("commonOption", "allStreaksRestricted")) {
        return 0;
      }
      break;

    case "perk":
      var_05 = param_02;
      break;

    default:
      return 0;
  }

  if(getmatchrulesdata("commonOption", var_03, param_01)) {
    return 0;
  }

  if(var_05 != "" && getmatchrulesdata("commonOption", var_04, var_05)) {
    return 0;
  }

  return 1;
}

func_1A5A(param_00) {
  var_01 = 0;
  var_02 = ["veteran", "hardened", "regular", "recruit"];
  var_02 = common_scripts\utility::func_0F92(var_02);
  foreach(var_04 in var_02) {
    var_01 = func_1A61("weap_statstable", param_00, "loadoutPrimaryGUID", self.var_6F7D, var_04);
    if(var_01 != 0) {
      return var_01;
    }
  }

  if(isDefined(level.var_1A91)) {
    var_06 = common_scripts\utility::func_0F92(level.var_1A91);
    foreach(var_08 in var_06) {
      foreach(var_04 in var_02) {
        var_01 = func_1A61("weap_statstable", param_00, "loadoutPrimaryGUID", var_08, var_04);
        if(var_01 != 0) {
          self.var_19C2 = var_08;
          return var_01;
        }
      }
    }
  }

  if(isusingmatchrulesdata()) {
    var_0C = 0;
    var_0D = 0;
    var_0E = 0;
    while(var_0D < 6) {
      if(getmatchrulesdata("defaultClasses", func_1A6C(), "defaultClass", var_0D, "class", "inUse")) {
        var_01 = func_1A5D(var_0D, "loadoutPrimaryGUID");
        if(var_01 != 0) {
          var_0C = var_0C + 1;
          if(randomfloat(1) >= 1 / var_0C) {
            var_0E = var_01;
          }
        }
      }

      var_0D++;
    }

    if(var_0E != 0) {
      self.var_19C2 = "weapon";
      return var_0E;
    }
  }

  self.var_19C2 = "weapon";
  return level.var_19C3;
}

func_1A6C() {
  if(!isDefined(level.var_984D) || !level.var_984D) {
    return "allies";
  }

  return maps\mp\bots\_bots::func_19FD();
}

func_199C() {
  var_00 = ["class1", "class2", "class3", "class4", "class5"];
  if(isusingmatchrulesdata()) {
    for(var_01 = 0; var_01 < var_00.size; var_01++) {
      if(getmatchrulesdata("defaultClasses", func_1A6C(), "defaultClass", var_01, "class", "inUse")) {
        var_00[var_01] = var_01;
      }
    }
  }

  var_02 = common_scripts\utility::func_7A33(var_00);
  var_03 = [];
  foreach(var_05 in level.var_1A64) {
    if(isstring(var_02)) {
      var_03[var_05] = func_1A5E(var_02, var_05);
      continue;
    }

    var_03[var_05] = func_1A5D(var_02, var_05);
  }

  return var_03;
}

func_1A97(param_00) {
  if(isDefined(param_00)) {
    var_01 = param_00 + "";
    var_02 = level.var_1B2C[var_01];
    if(isDefined(var_02)) {
      var_03 = strtok(var_02, "| ");
      if(var_03.size > 0) {
        maps\mp\bots\_bots_util::func_1AD5(common_scripts\utility::func_7A33(var_03));
        return;
      }
    }
  }
}

func_1A64() {
  var_00 = "mp/botClassTable.csv";
  if(!isDefined(level.var_1A64)) {
    level.var_1A64 = [];
    var_01 = 2;
    for(;;) {
      var_02 = tablelookupbyrow(var_00, var_01, 0);
      if(var_02 == "") {
        break;
      }

      if(!issubstr(var_02, "Wildcard")) {
        level.var_1A64[level.var_1A64.size] = var_02;
      }

      var_01++;
    }
  }

  return level.var_1A64;
}

func_1A6B(param_00, param_01, param_02) {
  var_03 = param_01 + "_" + param_00;
  if(!isDefined(level.var_1B36)) {
    level.var_1B36 = [];
  }

  if(!isDefined(level.var_1B36[var_03]) && param_02) {
    level.var_1B36[var_03] = spawnStruct();
    level.var_1B36[var_03].var_5E01 = [];
  }

  if(isDefined(level.var_1B36[var_03])) {
    return level.var_1B36[var_03];
  }
}

func_1A6A(param_00, param_01) {
  var_02 = func_1A6B(param_00, param_01, 0);
  if(isDefined(var_02) && isDefined(var_02.var_5E01) && var_02.var_5E01.size > 0) {
    var_03 = randomint(var_02.var_5E01.size);
    return var_02.var_5E01[var_03].var_5E0B;
  }
}

func_1B1A(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = [];
  var_08 = maps\mp\_utility::func_452B(param_00);
  if(isDefined(param_01) && !isstring(param_01)) {
    param_01 = maps\mp\_utility::func_452B(param_01);
  }

  if(isDefined(param_02) && !isstring(param_02)) {
    param_02 = maps\mp\_utility::func_452B(param_02);
  }

  if(isDefined(param_03) && !isstring(param_03)) {
    param_03 = maps\mp\_utility::func_452B(param_03);
  }

  if(isDefined(param_04) && !isstring(param_04)) {
    param_04 = maps\mp\_utility::func_452B(param_04);
  }

  if(isDefined(param_05) && !isstring(param_05)) {
    param_05 = maps\mp\_utility::func_452B(param_05);
  }

  if(isDefined(param_06) && !isstring(param_06)) {
    param_06 = maps\mp\_utility::func_452B(param_06);
  }

  var_09 = 0;
  if(isDefined(level.var_1B2B[var_08]) && level.var_1B2B[var_08] != "none") {
    var_07[var_07.size] = level.var_1B2B[var_08];
    var_09++;
  }

  if(isDefined(param_01) && param_01 != "none") {
    var_07[var_07.size] = param_01;
  }

  if(isDefined(param_02) && param_02 != "none") {
    var_07[var_07.size] = param_02;
  }

  if(isDefined(param_03) && param_03 != "none") {
    var_07[var_07.size] = param_03;
  }

  if(isDefined(param_04) && param_04 != "none") {
    var_07[var_07.size] = param_04;
  }

  if(isDefined(param_05) && param_05 != "none") {
    var_07[var_07.size] = param_05;
  }

  if(isDefined(param_06) && param_06 != "none") {
    var_07[var_07.size] = param_06;
  }

  var_0A = maps\mp\_utility::func_4723(var_08);
  for(var_0B = var_09; var_0B < var_07.size; var_0B++) {
    var_0C = maps\mp\_utility::func_1150(var_07[var_0B]);
    if(var_0C != var_07[var_0B]) {
      return 0;
    }

    if(!func_1A68("attachment", var_07[var_0B], undefined)) {
      return 0;
    }

    if(!common_scripts\utility::func_0F79(var_0A, var_07[var_0B])) {
      return 0;
    }

    var_0D = 0;
    for(var_0E = var_0B - 1; var_0E >= 0; var_0E--) {
      if(var_07[var_0B] == var_07[var_0E]) {
        var_0D++;
        if(var_0D == 1) {
          if(!isDefined(level.var_0C1A[var_07[var_0B]])) {
            return 0;
          }
        } else if(var_0D > 1) {
          return 0;
        }

        continue;
      }

      if(isDefined(level.var_1A24[var_07[var_0B]])) {
        if(isDefined(level.var_1A24[var_07[var_0B]][var_07[var_0E]])) {
          return 0;
        }
      }
    }
  }

  return 1;
}

func_1B19(param_00, param_01, param_02) {
  if(function_030D(param_02)) {
    var_03 = param_02;
  } else {
    var_03 = maps\mp\_utility::func_452A(var_03);
  }

  if(!maps\mp\gametypes\_class::func_5838(var_03, 1)) {
    return 0;
  }

  var_04 = ["Attachment", "Attachment2", "Attachment3"];
  foreach(var_06 in var_04) {
    var_07 = param_00 + var_06;
    var_08 = param_01[var_07];
    if(isDefined(var_08) && isDefined(level.var_193B[var_08])) {
      return 1;
    }
  }

  return 0;
}

func_5172() {
  level.var_1B2D = [];
  level.var_1B2C = [];
  level.var_1B2B = [];
  level.var_1B2C[getitemguidfromref("combatknife_mp") + ""] = "cqb";
  var_00 = 1;
  for(;;) {
    var_01 = tablelookupbyrow("mp/statstable.csv", var_00, 0);
    if(var_01 == "") {
      break;
    }

    if(tablelookupbyrow("mp/statstable.csv", var_00, 20) != "") {
      var_00++;
      continue;
    }

    var_02 = tablelookupbyrow("mp/statstable.csv", var_00, 18);
    var_03 = tablelookupbyrow("mp/statstable.csv", var_00, 2);
    var_04 = tablelookupbyrow("mp/statstable.csv", var_00, 27);
    var_05 = tablelookupbyrow("mp/statstable.csv", var_00, 26);
    if(var_04 != "" && var_03 != "" && var_05 != "") {
      var_06 = int(var_02);
      var_07 = getbaseweaponguid(var_06);
      var_08 = maps\mp\_utility::func_452B(var_07);
      var_09 = "loadoutPrimaryGUID";
      if(maps\mp\gametypes\_class::func_5839(var_08, 0, 0)) {
        var_09 = "loadoutSecondaryGUID";
      } else if(!maps\mp\gametypes\_class::func_5835(var_08, 0)) {
        var_00++;
        continue;
      }

      var_0A = getweaponconditionid(var_06);
      if(var_0A > 0 && var_0A < 3) {
        var_03 = var_03 + "+cond" + var_0A;
      }

      var_02 = var_06 + "";
      level.var_1B2C[var_02] = var_05;
      if(!isDefined(level.var_1B2D[var_09])) {
        level.var_1B2D[var_09] = [];
      }

      var_10 = strtok(var_05, "| ");
      var_11 = strtok(var_04, "| ");
      foreach(var_13 in var_10) {
        if(!isDefined(level.var_1B2D[var_09][var_13])) {
          level.var_1B2D[var_09][var_13] = [];
        }

        foreach(var_15 in var_11) {
          if(!isDefined(level.var_1B2D[var_09][var_13][var_15])) {
            level.var_1B2D[var_09][var_13][var_15] = [];
          }

          var_16 = level.var_1B2D[var_09][var_13][var_15].size;
          level.var_1B2D[var_09][var_13][var_15][var_16] = var_03;
        }
      }

      var_19 = tablelookupbyrow("mp/statstable.csv", var_00, 9);
      if(var_19 != "") {
        level.var_1B2B[var_03] = var_19;
      }
    }

    var_00++;
  }
}

func_1A61(param_00, param_01, param_02, param_03, param_04) {
  var_05 = 0;
  if(param_03 == "default") {
    param_03 = "run_and_gun";
  }

  var_06 = param_02;
  if(!isDefined(level.var_1B2D)) {
    return var_05;
  }

  if(!isDefined(level.var_1B2D[var_06])) {
    return var_05;
  }

  if(!isDefined(level.var_1B2D[var_06][param_03])) {
    return var_05;
  }

  if(!isDefined(level.var_1B2D[var_06][param_03][param_04])) {
    return var_05;
  }

  var_07 = func_1A60(level.var_1B2D[var_06][param_03][param_04], param_00, param_01, param_02);
  if(isstring(var_07)) {
    var_05 = maps\mp\_utility::func_452A(var_07);
  } else {
    var_05 = var_07;
  }

  return var_05;
}

func_1B18(param_00, param_01, param_02) {
  if(isstring(param_00)) {
    param_00 = maps\mp\_utility::func_452A(param_00);
  }

  if(param_00 == 0) {
    return 1;
  }

  var_03 = "Perk_Slot1";
  if(param_01 == "loadoutPerkGUID4" || param_01 == "loadoutPerkGUID5" || param_01 == "loadoutPerkGUID6") {
    var_03 = "Perk_Slot2";
  } else if(param_01 == "loadoutPerkGUID7" || param_01 == "loadoutPerkGUID8" || param_01 == "loadoutPerkGUID9") {
    var_03 = "Perk_Slot3";
  }

  if(!func_1A68("perk", param_00, var_03)) {
    return 0;
  }

  var_04 = int(getsubstr(param_01, 15));
  for(var_05 = var_04 - 1; var_05 > 0; var_05--) {
    var_06 = "loadoutPerkGUID" + var_05;
    var_07 = param_02[var_06];
    if(!function_030D(var_07)) {
      var_07 = maps\mp\_utility::func_452A(var_07);
    }

    if(var_07 == 0) {
      continue;
    }

    if(param_00 == var_07) {
      return 0;
    }
  }

  return 1;
}

func_1A5E(param_00, param_01) {
  var_02 = int(getsubstr(param_00, 5, 6)) - 1;
  switch (param_01) {
    case "loadoutDivision":
      return maps\mp\gametypes\_class::func_9583(level.var_2324, var_02);

    case "loadoutPrimaryGUID":
      return maps\mp\gametypes\_class::func_9590(level.var_2324, var_02, 0);

    case "loadoutPrimaryAttachmentGUID1":
      return maps\mp\gametypes\_class::func_958B(level.var_2324, var_02, 0, 0);

    case "loadoutPrimaryAttachmentGUID2":
      return maps\mp\gametypes\_class::func_958B(level.var_2324, var_02, 0, 1);

    case "loadoutPrimaryAttachmentGUID3":
      return maps\mp\gametypes\_class::func_958B(level.var_2324, var_02, 0, 2);

    case "loadoutPrimaryAttachmentGUID4":
      return maps\mp\gametypes\_class::func_958B(level.var_2324, var_02, 0, 3);

    case "loadoutPrimaryAttachmentGUID5":
      return maps\mp\gametypes\_class::func_958B(level.var_2324, var_02, 0, 4);

    case "loadoutPrimaryAttachmentGUID6":
      return maps\mp\gametypes\_class::func_958B(level.var_2324, var_02, 0, 5);

    case "loadoutPrimaryCamoGUID":
      return maps\mp\gametypes\_class::func_958E(level.var_2324, var_02, 0);

    case "loadoutPrimaryCamo2GUID":
      return 0;

    case "loadoutPrimaryReticleGUID":
      return maps\mp\gametypes\_class::func_9591(level.var_2324, var_02, 0);

    case "loadoutPrimaryPaintjobId":
      return 0;

    case "loadoutPrimaryCharmGUID":
      return 0;

    case "loadoutSecondaryGUID":
      return maps\mp\gametypes\_class::func_9590(level.var_2324, var_02, 1);

    case "loadoutSecondaryAttachmentGUID1":
      return maps\mp\gametypes\_class::func_958B(level.var_2324, var_02, 1, 0);

    case "loadoutSecondaryAttachmentGUID2":
      return maps\mp\gametypes\_class::func_958B(level.var_2324, var_02, 1, 1);

    case "loadoutSecondaryAttachmentGUID3":
      return maps\mp\gametypes\_class::func_958B(level.var_2324, var_02, 1, 2);

    case "loadoutSecondaryAttachmentGUID4":
      return maps\mp\gametypes\_class::func_958B(level.var_2324, var_02, 1, 3);

    case "loadoutSecondaryAttachmentGUID5":
      return maps\mp\gametypes\_class::func_958B(level.var_2324, var_02, 1, 4);

    case "loadoutSecondaryAttachmentGUID6":
      return maps\mp\gametypes\_class::func_958B(level.var_2324, var_02, 1, 5);

    case "loadoutSecondaryCamoGUID":
      return maps\mp\gametypes\_class::func_958E(level.var_2324, var_02, 1);

    case "loadoutSecondaryCamo2GUID":
      return 0;

    case "loadoutSecondaryReticleGUID":
      return maps\mp\gametypes\_class::func_9591(level.var_2324, var_02, 1);

    case "loadoutSecondaryPaintjobId":
      return 0;

    case "loadoutSecondaryCharmGUID":
      return 0;

    case "loadoutEquipmentGUID":
      return maps\mp\gametypes\_class::func_9584(level.var_2324, var_02);

    case "loadoutEquipmentNumExtra":
      var_03 = maps\mp\gametypes\_class::func_9585(level.var_2324, var_02);
      if(function_030D(var_03) || isstringinteger(var_03)) {
        return var_03;
      } else {
        return 0;
      }

      break;

    case "loadoutOffhandGUID":
      return maps\mp\gametypes\_class::func_9587(level.var_2324, var_03);

    case "loadoutOffhandNumExtra":
      var_04 = maps\mp\gametypes\_class::func_9588(level.var_2324, var_03);
      if(function_030D(var_04) || isstringinteger(var_04)) {
        return var_04;
      } else {
        return 0;
      }

      break;

    case "loadoutStreakGUID1":
      return maps\mp\gametypes\_class::func_9586(level.var_2324, var_04, 0);

    case "loadoutStreakGUID2":
      return maps\mp\gametypes\_class::func_9586(level.var_2324, var_04, 1);

    case "loadoutStreakGUID3":
      return maps\mp\gametypes\_class::func_9586(level.var_2324, var_04, 2);

    case "loadoutStreakGUID4":
      return maps\mp\gametypes\_class::func_9586(level.var_2324, var_04, 3);

    case "loadoutPerkGUID3":
    case "loadoutPerkGUID2":
    case "loadoutPerkGUID1":
    case "loadoutPerkGUID9":
    case "loadoutPerkGUID8":
    case "loadoutPerkGUID7":
    case "loadoutPerkGUID6":
    case "loadoutPerkGUID5":
    case "loadoutPerkGUID4":
      var_05 = int(getsubstr(var_03, 15)) - 1;
      return maps\mp\gametypes\_class::func_9589(level.var_2324, var_04, var_05);
  }

  return var_03;
}

func_1A5D(param_00, param_01) {
  var_02 = func_1A6C();
  switch (param_01) {
    case "loadoutDivsion":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "division");

    case "loadoutPrimaryGUID":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "weaponSetups", 0, "weapon");

    case "loadoutPrimaryAttachmentGUID1":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "weaponSetups", 0, "attachment", 0);

    case "loadoutPrimaryAttachmentGUID2":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "weaponSetups", 0, "attachment", 1);

    case "loadoutPrimaryAttachmentGUID3":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "weaponSetups", 0, "attachment", 2);

    case "loadoutPrimaryAttachmentGUID4":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "weaponSetups", 0, "attachment", 3);

    case "loadoutPrimaryAttachmentGUID5":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "weaponSetups", 0, "attachment", 4);

    case "loadoutPrimaryAttachmentGUID6":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "weaponSetups", 0, "attachment", 5);

    case "loadoutPrimaryCamoGUID":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "weaponSetups", 0, "camo");

    case "loadoutPrimaryCamo2GUID":
      return 0;

    case "loadoutPrimaryReticleGUID":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "weaponSetups", 0, "reticle");

    case "loadoutPrimaryPaintjobId":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "weaponSetups", 0, "paintjob");

    case "loadoutPrimaryCharmGUID":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "weaponSetups", 0, "charm");

    case "loadoutSecondaryGUID":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "weaponSetups", 1, "weapon");

    case "loadoutSecondaryAttachmentGUID1":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "weaponSetups", 1, "attachment", 0);

    case "loadoutSecondaryAttachmentGUID2":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "weaponSetups", 1, "attachment", 1);

    case "loadoutSecondaryAttachmentGUID3":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "weaponSetups", 1, "attachment", 2);

    case "loadoutSecondaryAttachmentGUID4":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "weaponSetups", 1, "attachment", 3);

    case "loadoutSecondaryAttachmentGUID5":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "weaponSetups", 1, "attachment", 4);

    case "loadoutSecondaryAttachmentGUID6":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "weaponSetups", 1, "attachment", 5);

    case "loadoutSecondaryCamoGUID":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "weaponSetups", 1, "camo");

    case "loadoutSecondaryCamo2GUID":
      return 0;

    case "loadoutSecondaryReticleGUID":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "weaponSetups", 1, "reticle");

    case "loadoutSecondaryPaintjobId":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "weaponSetups", 1, "paintjob");

    case "loadoutSecondaryCharmGUID":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "weaponSetups", 1, "charm");

    case "loadoutEquipmentGUID":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "equipmentSetups", 0, "equipment");

    case "loadoutEquipmentNumExtra":
      if(isstringinteger(getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "equipmentSetups", 0, "numExtra"))) {
        return int(getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "equipmentSetups", 0, "numExtra"));
      } else {
        return 0;
      }

      break;

    case "loadoutOffhandGUID":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "equipmentSetups", 1, "equipment");

    case "loadoutOffhandNumExtra":
      return 0;

    case "loadoutStreakGUID1":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "assaultStreaks", 0, "streak");

    case "loadoutStreakGUID2":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "assaultStreaks", 1, "streak");

    case "loadoutStreakGUID3":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "assaultStreaks", 2, "streak");

    case "loadoutStreakGUID4":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "assaultStreaks", 3, "streak");

    case "loadoutPerkGUID1":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "perkSlots", 0);

    case "loadoutPerkGUID2":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "perkSlots", 1);

    case "loadoutPerkGUID3":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "perkSlots", 2);

    case "loadoutPerkGUID4":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "perkSlots", 3);

    case "loadoutPerkGUID5":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "perkSlots", 4);

    case "loadoutPerkGUID6":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "perkSlots", 5);

    case "loadoutPerkGUID7":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "perkSlots", 6);

    case "loadoutPerkGUID8":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "perkSlots", 7);

    case "loadoutPerkGUID9":
      return getmatchrulesdata("defaultClasses", var_02, "defaultClass", param_00, "class", "perkSlots", 8);

    default:
      break;
  }

  return "none";
}

func_516F() {
  level.var_193C = [];
  level.var_193B = [];
  var_00 = 1;
  for(;;) {
    var_01 = tablelookupbyrow("mp/attachmenttable.csv", var_00, 3);
    if(var_01 == "done") {
      break;
    }

    var_02 = tablelookupbyrow("mp/attachmenttable.csv", var_00, 15);
    if(var_01 != "" && var_02 != "") {
      var_03 = tablelookupbyrow("mp/attachmenttable.csv", var_00, 7);
      if(var_03 == "TRUE") {
        level.var_193B[var_01] = 1;
      }

      var_04 = strtok(var_02, "| ");
      foreach(var_06 in var_04) {
        if(!isDefined(level.var_193C[var_06])) {
          level.var_193C[var_06] = [];
        }

        if(!common_scripts\utility::func_0F79(level.var_193C[var_06], var_01)) {
          var_07 = level.var_193C[var_06].size;
          level.var_193C[var_06][var_07] = var_01;
        }
      }
    }

    var_00++;
  }

  level.var_1A24 = [];
  level.var_0C1A = [];
  var_09 = 0;
  for(;;) {
    var_09++;
    var_0A = tablelookupbyrow("mp/attachmentcombos_mtx12.csv", 0, var_09);
    if(var_0A == "") {
      break;
    }

    var_00 = 0;
    for(;;) {
      var_00++;
      var_0B = tablelookupbyrow("mp/attachmentcombos_mtx12.csv", var_00, 0);
      if(var_0B == "") {
        break;
      }

      if(var_0B == var_0A) {
        if(tablelookupbyrow("mp/attachmentcombos_mtx12.csv", var_00, var_09) != "no") {
          level.var_0C1A[var_0B] = 1;
        }

        continue;
      }

      if(tablelookupbyrow("mp/attachmentcombos_mtx12.csv", var_00, var_09) == "no") {
        level.var_1A24[var_0A][var_0B] = 1;
      }
    }
  }
}

func_1A5B(param_00, param_01, param_02, param_03, param_04) {
  var_05 = 0;
  if(!isDefined(level.var_193C)) {
    return var_05;
  }

  if(!isDefined(level.var_193C[param_04])) {
    return var_05;
  }

  var_06 = func_1A60(level.var_193C[param_04], param_00, param_01, param_02);
  if(isstring(var_06)) {
    var_05 = maps\mp\_utility::func_452A(var_06);
  } else {
    var_05 = var_06;
  }

  return var_05;
}

func_5171() {
  var_00 = "mp/reticletable.csv";
  var_01 = 1;
  var_02 = 8;
  level.var_1AB8 = [];
  var_03 = 0;
  for(;;) {
    var_04 = tablelookupbyrow(var_00, var_03, var_01);
    if(!isDefined(var_04) || var_04 == "") {
      break;
    }

    var_05 = maps\mp\_utility::func_452A(var_04);
    var_06 = tablelookupbyrow(var_00, var_03, var_02);
    if(isDefined(var_06) && int(var_06)) {
      level.var_1AB8[level.var_1AB8.size] = var_04;
    }

    var_03++;
  }
}

func_1A5F(param_00, param_01, param_02, param_03, param_04) {
  var_05 = 0;
  if(!isDefined(level.var_1AB8) || level.var_1AB8.size == 0) {
    return var_05;
  }

  var_06 = randomint(100) > 50;
  if(var_06) {
    var_07 = func_1A60(level.var_1AB8, param_00, param_01, param_02);
    if(isstring(var_07)) {
      var_05 = maps\mp\_utility::func_452A(var_07);
    } else {
      var_05 = var_07;
    }
  }

  return var_06;
}

func_5170() {
  var_00 = "mp/camotable.csv";
  var_01 = 1;
  var_02 = 8;
  var_03 = 9;
  var_04 = 11;
  level.var_1953 = [];
  var_05 = 0;
  for(;;) {
    var_06 = tablelookupbyrow(var_00, var_05, var_01);
    if(!isDefined(var_06) || var_06 == "") {
      break;
    }

    var_07 = int(tablelookupbyrow(var_00, var_05, var_04));
    var_08 = tablelookupbyrow(var_00, var_05, var_02);
    if(isDefined(var_08) && var_08 != "" && !var_07) {
      var_09 = maps\mp\_utility::func_452A(var_06);
      var_0A = tablelookupbyrow(var_00, var_05, var_03);
      if(isDefined(var_0A) && int(var_0A)) {
        level.var_1953[level.var_1953.size] = var_06;
      }
    }

    var_05++;
  }
}

func_1A5C(param_00, param_01, param_02, param_03, param_04) {
  var_05 = 0;
  if(!isDefined(level.var_1953) || level.var_1953.size == 0) {
    return var_05;
  }

  var_06 = randomint(100) > 50;
  if(var_06) {
    var_07 = func_1A60(level.var_1953, param_00, param_01, param_02);
    if(isstring(var_07)) {
      var_05 = maps\mp\_utility::func_452A(var_07);
    } else {
      var_05 = var_07;
    }
  }

  return var_06;
}

func_1A69(param_00, param_01, param_02) {
  if(function_01EF(self)) {
    return 1;
  }

  if(!isstring(param_01)) {
    param_01 = maps\mp\_utility::func_452B(param_01);
  }

  if(!isDefined(level.var_1A7D[param_01])) {
    var_03 = "mp/unlockTable.csv";
    var_04 = tablelookuprownum(var_03, 0, param_01);
    level.var_1A7D[param_01] = int(tablelookupbyrow(var_03, var_04, 2));
  }

  if(param_00 == "classtable_any" && param_02 == "recruit") {
    return 1;
  }

  if(!isDefined(self.var_7A66)) {
    self.var_7A66 = self.var_012C["rank"];
    if(!isDefined(self.var_7A66)) {
      self.var_7A66 = level.var_1ABA[param_02][0];
    }
  }

  if(level.var_1A7D[param_01] <= self.var_7A66) {
    return 1;
  }

  return 0;
}

func_1A66(param_00, param_01) {
  if(!isstring(param_00)) {
    param_00 = maps\mp\_utility::func_452B(param_00);
  }

  return maps\mp\gametypes\_class::func_5826(param_00, 0);
}

func_1A67(param_00, param_01) {
  if(!isstring(param_00)) {
    param_00 = maps\mp\_utility::func_452B(param_00);
  }

  return maps\mp\gametypes\_class::func_5833(param_00, 0);
}

func_1A12(param_00, param_01) {
  var_02 = param_00["loadoutPerkGUID4"];
  if(function_030D(var_02)) {
    var_02 = maps\mp\_utility::func_452B(var_02);
  }

  return var_02 == param_01;
}

func_1A6D(param_00, param_01, param_02, param_03) {
  var_04 = 1;
  switch (param_02) {
    case "loadoutDivision":
      if(function_030D(param_03)) {
        var_04 = maps\mp\gametypes\_divisions::func_56CC(param_03);
      } else {
        var_04 = maps\mp\gametypes\_divisions::func_56CB(param_03);
      }
      break;

    case "loadoutPrimaryGUID":
      var_05 = param_03;
      if(maps\mp\_utility::func_5856(var_05)) {
        var_05 = maps\mp\gametypes\_class::func_4432(var_05);
      }

      var_04 = func_1A68("weapon", var_05, undefined);
      var_04 = var_04 && maps\mp\gametypes\_class::func_5835(var_05, func_1A12(param_01, "specialty_class_serrated"));
      var_04 = var_04 && func_1A69(param_00, param_03, self botgetdifficulty());
      break;

    case "loadoutEquipmentGUID":
      var_04 = func_1A68("perk", param_03, "Lethal");
      var_04 = var_04 && func_1A66(param_03, param_01);
      var_04 = var_04 && func_1A69(param_00, param_03, self botgetdifficulty());
      break;

    case "loadoutEquipmentNumExtra":
      var_04 = function_030D(param_03) && param_03 >= 0;
      break;

    case "loadoutOffhandGUID":
      var_04 = func_1A68("perk", param_03, "Tactical");
      var_04 = var_04 && func_1A67(param_03, param_01);
      var_04 = var_04 && func_1A69(param_00, param_03, self botgetdifficulty());
      break;

    case "loadoutOffhandNumExtra":
      var_04 = function_030D(param_03) && param_03 >= 0;
      break;

    case "loadoutPrimaryAttachmentGUID1":
      var_04 = func_1B1A(param_01["loadoutPrimaryGUID"], param_03);
      break;

    case "loadoutPrimaryAttachmentGUID2":
      var_04 = func_1B1A(param_01["loadoutPrimaryGUID"], param_01["loadoutPrimaryAttachmentGUID1"], param_03);
      break;

    case "loadoutPrimaryAttachmentGUID3":
      var_04 = func_1B1A(param_01["loadoutPrimaryGUID"], param_01["loadoutPrimaryAttachmentGUID1"], param_01["loadoutPrimaryAttachmentGUID2"], param_03);
      break;

    case "loadoutPrimaryAttachmentGUID4":
      var_04 = func_1B1A(param_01["loadoutPrimaryGUID"], param_01["loadoutPrimaryAttachmentGUID1"], param_01["loadoutPrimaryAttachmentGUID2"], param_01["loadoutPrimaryAttachmentGUID3"], param_03);
      break;

    case "loadoutPrimaryAttachmentGUID5":
      var_04 = func_1B1A(param_01["loadoutPrimaryGUID"], param_01["loadoutPrimaryAttachmentGUID1"], param_01["loadoutPrimaryAttachmentGUID2"], param_01["loadoutPrimaryAttachmentGUID3"], param_01["loadoutPrimaryAttachmentGUID4"], param_03);
      break;

    case "loadoutPrimaryAttachmentGUID6":
      var_04 = func_1B1A(param_01["loadoutPrimaryGUID"], param_01["loadoutPrimaryAttachmentGUID1"], param_01["loadoutPrimaryAttachmentGUID2"], param_01["loadoutPrimaryAttachmentGUID3"], param_01["loadoutPrimaryAttachmentGUID4"], param_01["loadoutPrimaryAttachmentGUID5"], param_03);
      break;

    case "loadoutPrimaryReticleGUID":
      var_04 = func_1B19("loadoutPrimaryGUID", param_01, param_03);
      break;

    case "loadoutPrimaryCamoGUID":
      if(function_030D(param_03)) {
        var_06 = param_03;
      } else {
        var_06 = maps\mp\_utility::func_452A(var_04);
      }

      var_04 = !isDefined(self.var_1B34) || var_06 == self.var_1B34;
      var_04 = var_04 && maps\mp\gametypes\_class::func_5821(var_06);
      break;

    case "loadoutPrimaryCamo2GUID":
      if(function_030D(param_03)) {
        var_06 = param_03;
      } else {
        var_06 = maps\mp\_utility::func_452A(var_04);
      }

      var_04 = var_06 == 0;
      break;

    case "loadoutPrimaryPaintjobId":
      break;

    case "loadoutPrimaryCharmGUID":
      break;

    case "loadoutSecondaryGUID":
      if(function_030D(param_03)) {
        param_03 = maps\mp\_utility::func_452B(param_03);
      }

      var_04 = param_03 != maps\mp\_utility::func_452B(param_01["loadoutPrimaryGUID"]);
      var_05 = param_03;
      if(maps\mp\_utility::func_5856(var_05)) {
        var_05 = maps\mp\gametypes\_class::func_4432(var_05);
      }

      var_04 = var_04 && func_1A68("weapon", var_05, undefined);
      var_04 = var_04 && maps\mp\gametypes\_class::func_5839(var_05, func_1A12(param_01, "specialty_class_rifleman"), func_1A12(param_01, "specialty_class_launched"));
      var_04 = var_04 && func_1A69(param_00, param_03, self botgetdifficulty());
      break;

    case "loadoutSecondaryAttachmentGUID1":
      var_04 = func_1B1A(param_01["loadoutSecondaryGUID"], param_03, "none");
      break;

    case "loadoutSecondaryAttachmentGUID2":
      var_04 = func_1B1A(param_01["loadoutSecondaryGUID"], param_01["loadoutSecondaryAttachmentGUID1"], param_03);
      break;

    case "loadoutSecondaryAttachmentGUID3":
      var_04 = func_1B1A(param_01["loadoutSecondaryGUID"], param_01["loadoutSecondaryAttachmentGUID1"], param_01["loadoutSecondaryAttachmentGUID2"], param_03);
      break;

    case "loadoutSecondaryAttachmentGUID4":
      var_04 = func_1B1A(param_01["loadoutSecondaryGUID"], param_01["loadoutSecondaryAttachmentGUID1"], param_01["loadoutSecondaryAttachmentGUID2"], param_01["loadoutSecondaryAttachmentGUID3"], param_03);
      break;

    case "loadoutSecondaryAttachmentGUID5":
      var_04 = func_1B1A(param_01["loadoutSecondaryGUID"], param_01["loadoutSecondaryAttachmentGUID1"], param_01["loadoutSecondaryAttachmentGUID2"], param_01["loadoutSecondaryAttachmentGUID3"], param_01["loadoutSecondaryAttachmentGUID4"], param_03);
      break;

    case "loadoutSecondaryAttachmentGUID6":
      var_04 = func_1B1A(param_01["loadoutSecondaryGUID"], param_01["loadoutSecondaryAttachmentGUID1"], param_01["loadoutSecondaryAttachmentGUID2"], param_01["loadoutSecondaryAttachmentGUID3"], param_01["loadoutSecondaryAttachmentGUID4"], param_01["loadoutSecondaryAttachmentGUID5"], param_03);
      break;

    case "loadoutSecondaryReticleGUID":
      var_04 = func_1B19("loadoutSecondaryGUID", param_01, param_03);
      break;

    case "loadoutSecondaryCamoGUID":
      if(function_030D(param_03)) {
        var_06 = param_03;
      } else {
        var_06 = maps\mp\_utility::func_452A(var_04);
      }

      var_04 = !isDefined(self.var_1B35) || var_06 == self.var_1B35;
      var_04 = var_04 && maps\mp\gametypes\_class::func_5821(var_06);
      break;

    case "loadoutSecondaryCamo2GUID":
      if(function_030D(param_03)) {
        var_06 = param_03;
      } else {
        var_06 = maps\mp\_utility::func_452A(var_04);
      }

      var_04 = var_06 == 0;
      break;

    case "loadoutSecondaryPaintjobId":
      break;

    case "loadoutSecondaryCharmGUID":
      break;

    case "loadoutStreakGUID4":
    case "loadoutStreakGUID3":
    case "loadoutStreakGUID2":
    case "loadoutStreakGUID1":
      var_04 = maps\mp\bots\_bots_ks::func_1A49(param_03, "bots", undefined);
      var_04 = var_04 && func_1A68("killstreak", param_03, undefined);
      break;

    case "loadoutPerkGUID3":
    case "loadoutPerkGUID2":
    case "loadoutPerkGUID1":
    case "loadoutPerkGUID9":
    case "loadoutPerkGUID8":
    case "loadoutPerkGUID7":
    case "loadoutPerkGUID6":
    case "loadoutPerkGUID5":
    case "loadoutPerkGUID4":
      var_04 = func_1B18(param_03, param_02, param_01);
      var_04 = var_04 && func_1A69(param_00, param_03, self botgetdifficulty());
      break;

    case "loadoutWildcardGUID3":
    case "loadoutWildcardGUID2":
    case "loadoutWildcardGUID1":
      break;

    default:
      break;
  }

  return var_04;
}

func_1A60(param_00, param_01, param_02, param_03, param_04) {
  var_05 = "none";
  var_06 = undefined;
  var_07 = undefined;
  var_08 = 0;
  if(common_scripts\utility::func_0F79(param_00, "specialty_null")) {
    var_05 = "specialty_null";
  } else if(param_03 == "loadoutEquipmentGUID" || param_03 == "loadoutOffhandGUID" || issubstr(tolower(param_03), "perk")) {
    var_05 = "specialty_null";
  }

  if(param_01 == "classtable_any") {
    if(!isDefined(self.var_2B94)) {
      self.var_2B94 = common_scripts\utility::func_7A33(["class1", "class2", "class3", "class4", "class5"]);
    }

    param_00 = [self.var_2B94];
  }

  foreach(var_0A in param_00) {
    var_0B = undefined;
    var_0C = undefined;
    if(getsubstr(var_0A, 0, 9) == "template_") {
      var_0C = var_0A;
      var_0D = level.var_1B37[var_0A][param_03];
      var_0A = func_1A60(strtok(var_0D, "| "), param_01, param_02, param_03, 1);
      if(isDefined(var_0C) && isDefined(self.var_2217[var_0C])) {
        return var_0A;
      }
    }

    if(isstring(var_0A) && var_0A == "specialty_class_assigned") {
      var_0E = maps\mp\_utility::func_452B(param_02["loadoutPerkGUID4"]);
      if(!isDefined(level.var_1B38[var_0E])) {
        var_0E = "specialty_class_any";
      }

      var_0F = level.var_1B38[var_0E][param_03];
      var_0A = func_1A60(strtok(var_0F, "| "), param_01, param_02, param_03, 0);
    }

    if(isstring(var_0A) && function_02C6(var_0A, "division_")) {
      if(var_0A == "division_assigned") {
        var_0B = "division_" + maps\mp\gametypes\_divisions::func_44A0(param_02["loadoutDivision"]);
        var_10 = level.var_1B30[var_0B][param_03];
        var_0A = func_1A60(strtok(var_10, "| "), param_01, param_02, param_03, 0);
      } else {
        var_0A = pick_division_from_loadout_value(var_0A);
      }
    }

    if(isstring(var_0A)) {
      if(var_0A == "attachmenttable") {
        return func_1A5B(param_01, param_02, param_03, self.var_6F7D, self.var_2F05);
      }

      if(var_0A == "weap_statstable") {
        return func_1A61(param_01, param_02, param_03, self.var_6F7D, self.var_2F05);
      }

      if(var_0A == "reticletable") {
        return func_1A5F(param_01, param_02, param_03, self.var_6F7D, self.var_2F05);
      }

      if(var_0A == "camotable") {
        return func_1A5C(param_01, param_02, param_03, self.var_6F7D, self.var_2F05);
      }

      if(getsubstr(var_0A, 0, 5) == "class" && int(getsubstr(var_0A, 5, 6)) > 0) {
        var_0A = func_1A5E(var_0A, param_03);
      }
    }

    if(issubstr(param_03, "Num")) {
      var_0A = int(var_0A);
    }

    if(func_1A6D(param_01, param_02, param_03, var_0A)) {
      var_08 = var_08 + 1;
      var_11 = randomfloat(1);
      if(var_11 <= 1 / var_08) {
        var_05 = var_0A;
        var_06 = var_0C;
      }
    }
  }

  if(isDefined(var_06)) {
    self.var_2217[var_06] = 1;
  }

  if(isstring(var_05) && var_05 == "none" || var_05 == "specialty_null") {
    return 0;
  }

  return var_05;
}

pick_division_from_loadout_value(param_00) {
  var_01 = level.var_1B30[param_00]["loadoutDivision"];
  var_02 = func_1A60(strtok(var_01, "| "), "", undefined, "loadoutDivision", 0);
  if(!function_030D(var_02) && maps\mp\gametypes\_divisions::func_56CB(var_02)) {
    var_03 = "division_" + var_02;
    var_02 = maps\mp\gametypes\_divisions::func_449C(var_02);
  }

  return var_02;
}

func_1A62(param_00) {
  self.var_2217 = [];
  foreach(var_06, var_02 in param_00) {
    var_03 = undefined;
    if(!isDefined(var_03)) {
      var_05 = strtok(var_02, "| ");
      var_03 = func_1A60(var_05, var_02, param_00, var_06);
    }

    if(isstring(var_03)) {
      var_03 = maps\mp\_utility::func_452A(var_03);
    }

    param_00[var_06] = var_03;
  }

  return param_00;
}

func_1A65() {
  var_00 = self botgetdifficulty();
  if(var_00 == "default") {
    maps\mp\bots\_bots_util::func_1AD3("default");
    var_00 = self botgetdifficulty();
  }

  return var_00;
}

func_19FF() {
  if(isDefined(self.var_012C["botCustomClasses"])) {
    return self.var_012C["botCustomClasses"];
  }

  return [];
}

func_1A00() {
  if(func_19FF().size > 0) {
    if(isDefined(self.var_012C["botLauncherClassIndex"])) {
      var_00 = self.var_012C["botLauncherClassIndex"];
      return self.var_012C["botCustomClasses"][var_00];
    }
  }

  return undefined;
}

func_1936() {
  if(common_scripts\utility::func_562E(self.var_1A95)) {
    return 0;
  } else if(!isDefined(self.var_012C["botLastLoadout"])) {
    return 0;
  } else if(common_scripts\utility::func_562E(self.var_7DB2)) {
    return 0;
  } else if(isDefined(self.var_4B60) && !self.var_4B60) {
    return 0;
  }

  return 1;
}

func_1A63(param_00) {
  while(!isDefined(level.var_1A6E)) {
    wait 0.05;
  }

  while(!isDefined(self.var_6F7D)) {
    wait 0.05;
  }

  var_01 = [];
  var_02 = func_1A65();
  self.var_2F05 = var_02;
  var_03 = self method_8368();
  if(!isDefined(self.var_1A56)) {
    self.var_1994 = 0;
  }

  self.var_1A56 = self.var_1994;
  if(isDefined(self.var_012C["botLastLoadout"]) && common_scripts\utility::func_562E(param_00)) {
    return self.var_012C["botLastLoadout"];
  }

  var_04 = !isDefined(self.var_012C["botLastLoadoutDifficulty"]) || self.var_012C["botLastLoadoutDifficulty"] == var_02;
  var_05 = !isDefined(self.var_012C["botLastLoadoutPersonality"]) || self.var_012C["botLastLoadoutPersonality"] == var_03;
  var_06 = 0;
  if(!var_04 || !var_05) {
    self.var_012C["botLastLoadout"] = undefined;
    self.var_012C["botCustomClasses"] = undefined;
    self.var_012C["botLauncherClassIndex"] = undefined;
    var_06 = 1;
  }

  var_07 = !var_06 && func_1936();
  if(var_07) {
    var_08 = 0.1;
    var_0A = randomfloat(1) > var_08;
    if(var_0A) {
      return self.var_012C["botLastLoadout"];
    }
  }

  self.var_1A95 = undefined;
  if(!var_06) {
    var_0B = func_1A00();
    var_0C = undefined;
    if(isDefined(self.var_7DB2) && isDefined(var_0B)) {
      self.var_7DB2 = undefined;
      self.var_1A95 = 1;
      var_0C = var_0B;
    }

    if(!isDefined(var_0C)) {
      var_0D = func_19FF();
      var_0E = 0;
      if(isDefined(var_0B)) {
        if(var_0D.size < 5) {
          var_0E = 1;
        }
      } else if(isDefined(self.var_7DB2)) {
        var_0E = 1;
      } else if(var_0D.size < 4) {
        var_0E = 1;
      }

      if(!var_0E) {
        var_0C = common_scripts\utility::func_7A33(var_0D);
      }
    }

    if(isDefined(var_0E)) {
      self.var_1994++;
      self.var_012C["botLastLoadout"] = var_0E;
      return var_0E;
    }
  }

  var_0F = undefined;
  var_10 = func_1995();
  if(var_10) {
    var_0F = func_1A6A(var_07, var_06);
    var_05 = func_1A62(var_0F);
    if(isDefined(level.var_19D5["gametype_loadout_modify"])) {
      var_05 = self[[level.var_19D5["gametype_loadout_modify"]]](var_05);
    }

    if(func_1A78(var_05)) {
      var_10 = 0;
    }
  }

  if(!var_10) {
    var_05 = func_199C();
    func_1A97(var_05["loadoutPrimaryGUID"]);
  }

  if(var_05["loadoutPrimaryGUID"] == 0) {
    self.var_19C2 = undefined;
    var_05["loadoutPrimaryGUID"] = func_1A5A(var_05);
    var_05["loadoutPrimaryCamoGUID"] = 0;
    var_05["loadoutPrimaryAttachmentGUID1"] = 0;
    var_05["loadoutPrimaryAttachmentGUID2"] = 0;
    var_05["loadoutPrimaryAttachmentGUID3"] = 0;
    var_05["loadoutPrimaryReticleGUID"] = 0;
    var_05["loadoutPrimaryPaintjobId"] = 0;
    var_05["loadoutPrimaryCharmGUID"] = 0;
    if(isDefined(self.var_19C2)) {
      if(self.var_19C2 == "weapon") {
        func_1A97(var_05["loadoutPrimaryGUID"]);
      } else {
        maps\mp\bots\_bots_util::func_1AD5(self.var_19C2);
      }

      var_07 = self.var_6F7D;
      self.var_19C2 = undefined;
    }
  }

  var_14 = isDefined(self.var_7DB2);
  if(var_10 && maps\mp\bots\_bots::func_1A39()) {
    if(isDefined(var_05["loadoutPrimaryCamoGUID"]) && var_05["loadoutPrimaryCamoGUID"] != 0 && !isDefined(self.var_1B34)) {
      self.var_1B34 = var_05["loadoutPrimaryCamoGUID"];
    }

    if(isDefined(var_05["loadoutSecondaryCamoGUID"]) && var_05["loadoutSecondaryCamoGUID"] != 0 && !isDefined(self.var_1B35)) {
      self.var_1B35 = var_05["loadoutSecondaryCamoGUID"];
    }

    if(var_14) {
      var_15 = level.var_1AB6[self botgetdifficulty()];
      if(func_1A68("weapon", var_15, undefined)) {
        var_05["loadoutSecondaryGUID"] = var_15;
        var_05["loadoutSecondaryAttachmentGUID1"] = 0;
        var_05["loadoutSecondaryAttachmentGUID2"] = 0;
        var_05["loadoutSecondaryAttachmentGUID3"] = 0;
        var_05["loadoutSecondaryAttachmentGUID4"] = 0;
        var_05["loadoutSecondaryAttachmentGUID5"] = 0;
        var_05["loadoutSecondaryAttachmentGUID6"] = 0;
        self.var_1A95 = 1;
      }

      self.var_7DB2 = undefined;
    }
  }

  maps\mp\gametypes\_class::func_582D(var_05["loadoutStreakGUID1"]);
  maps\mp\gametypes\_class::func_582D(var_05["loadoutStreakGUID2"]);
  maps\mp\gametypes\_class::func_582D(var_05["loadoutStreakGUID3"]);
  var_05["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::func_473C(var_05["loadoutPrimaryGUID"], 0);
  var_05["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::func_473C(var_05["loadoutSecondaryGUID"], 0);
  var_05["loadoutEquipmentStruct"] = maps\mp\_utility::func_44CE(var_05["loadoutEquipmentGUID"], 0);
  var_05["loadoutEquipmentNumExtra"] = int(var_05["loadoutEquipmentNumExtra"]);
  var_05["loadoutOffhandStruct"] = maps\mp\_utility::func_44CE(var_05["loadoutOffhandGUID"], 0);
  var_05["loadoutOffhandNumExtra"] = int(var_05["loadoutOffhandNumExtra"]);
  var_05["loadoutPrimaryAttachmentsGUID"] = [];
  var_05["loadoutSecondaryAttachmentsGUID"] = [];
  for(var_16 = 0; var_16 < 6; var_16++) {
    var_05["loadoutPrimaryAttachmentsGUID"][var_16] = var_05["loadoutPrimaryAttachmentGUID" + var_16 + 1];
    var_05["loadoutSecondaryAttachmentsGUID"][var_16] = var_05["loadoutSecondaryAttachmentGUID" + var_16 + 1];
  }

  self.var_1994++;
  self.var_012C["botLastLoadout"] = var_05;
  self.var_012C["botLastLoadoutDifficulty"] = var_06;
  self.var_012C["botLastLoadoutPersonality"] = var_07;
  if(!isDefined(self.var_012C["botCustomClasses"])) {
    self.var_012C["botCustomClasses"] = [];
  }

  var_17 = self.var_012C["botCustomClasses"].size;
  self.var_012C["botCustomClasses"][var_17] = var_05;
  if(var_14) {
    self.var_012C["botLauncherClassIndex"] = var_17;
  }

  return var_05;
}

func_1A78(param_00) {
  if(isusingmatchrulesdata()) {
    if(param_00["loadoutPrimaryGUID"] == 0) {
      return 1;
    }
  }

  return 0;
}

func_1ADE() {
  var_00 = self method_8368();
  var_01 = func_1A65();
  var_02 = func_1A6B(var_00, var_01, 0);
  if(isDefined(var_02) && isDefined(var_02.var_5E01) && var_02.var_5E01.size > 0) {
    self.var_231D = ::func_1A63;
    return 1;
  }

  var_03 = getsubstr(self.var_0109, 0, self.var_0109.size - 10);
  self.var_231D = undefined;
  return 0;
}

func_1A7E() {}