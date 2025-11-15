/*************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\validation.gsc
*************************************/

validationerror(param_00, param_01, param_02) {
  var_03 = param_00;
  if(isDefined(param_01)) {
    var_03 = var_03 + "_" + param_01;
  }

  if(isDefined(param_02)) {
    var_03 = var_03 + " - " + param_02;
  }

  if(getdvarint("scr_validate_print", 0) == 1) {}

  if(getdvarint("scr_validate_assert", 0) == 1) {}

  if(getdvarint("scr_validate_record", 0) == 1) {
    scripts\mp\class::recordvalidationinfraction();
  }
}

validateloadout(param_00) {
  var_01 = spawnStruct();
  var_01.var_D640 = 0;
  var_01.var_13D1E = [];
  var_01.invaliditems = [];
  var_01.invaliditems[2] = [];
  var_01.invaliditems[5] = [];
  var_01.invaliditems[9] = [];
  func_1314B(var_01, param_00.loadoutprimary, param_00.loadoutprimaryattachments, param_00.loadoutprimarycamo, param_00.loadoutprimaryreticle, param_00.loadoutprimarylootitemid, param_00.loadoutprimaryvariantid, 0);
  func_1314B(var_01, param_00.loadoutsecondary, param_00.loadoutsecondaryattachments, param_00.loadoutsecondarycamo, param_00.loadoutsecondaryreticle, param_00.var_AE9E, param_00.var_AEA5, 1);
  func_13146(var_01, param_00.var_AE7B, "primary", param_00.var_AE69);
  func_13146(var_01, param_00.var_AE7D, "secondary", param_00.var_AE6A);
  func_13145(var_01, param_00.loadoutperks, param_00.loadoutarchetype);
  validatestreaks(var_01, param_00.loadoutkillstreak1, param_00.loadoutkillstreak2, param_00.loadoutkillstreak3);
  func_13148(var_01, param_00.loadoutsuper, param_00.loadoutarchetype);
  validatearchetype(var_01, param_00.loadoutarchetype);
  if(var_01.var_D640 > 10) {
    validationerror("totalPointCost");
    var_01.invaliditems[0] = 1;
  }

  func_1314C(var_01);
  param_00 = fixinvaliditems(param_00, var_01.invaliditems);
  return param_00;
}

func_1314B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  var_08 = scripts\mp\utility::getweaponrootname(param_01);
  var_09 = scripts\mp\utility::iscacsecondaryweapon(param_01);
  var_0A = scripts\engine\utility::ter_op(param_07, "secondary", "primary");
  var_0B = scripts\engine\utility::ter_op(param_07, 4, 1);
  if(isDefined(param_01) && param_01 != "none" && param_01 != "iw7_fists") {
    param_00.var_D640++;
    if(param_07) {
      if(!var_09) {
        param_00.var_D640++;
        param_00.var_13D1E["overkill"] = 1;
      }
    } else if(var_09) {
      validationerror("secondaryAsPrimary", undefined, param_01);
      param_00.invaliditems[var_0B] = 1;
    }

    var_0C = scripts\mp\utility::func_13CAC(var_08);
    if(!isDefined(var_0C)) {
      validationerror("unknownWeapon", var_0A, param_01);
      param_00.invaliditems[var_0B] = 1;
    } else {
      var_0D = tablelookup("mp\statstable.csv", 0, var_0C, 41);
      if(int(var_0D) < 0) {
        validationerror("unreleasedWeapon", var_0A, param_01);
        param_00.invaliditems[var_0B] = 1;
      }
    }

    if(!self isitemunlocked(var_08, "weapon") && !weaponunlocksvialoot(var_08)) {
      validationerror("lockedWeapon", var_0A, param_01);
      param_00.invaliditems[var_0B] = 1;
    }

    if(param_05 == 0) {
      if(param_06 != -1) {
        validationerror("emptyItemIDMismatch", var_0A, param_01);
        param_00.invaliditems[var_0B] = 1;
      }
    } else if(param_06 == -1) {
      validationerror("emptyVariantIDMismatch", var_0A, param_01);
      param_00.invaliditems[var_0B] = 1;
    } else {
      if(!scripts\mp\loot::isweaponitem(param_05)) {
        validationerror("nonWeaponLootItemID", var_0A, param_01);
        param_00.invaliditems[var_0B] = 1;
      }

      var_0E = scripts\mp\loot::getlootweaponref(param_05);
      if(!isDefined(var_0E)) {
        validationerror("badLootItemID", var_0A, param_01);
        param_00.invaliditems[var_0B] = 1;
      } else {
        var_0F = scripts\mp\loot::lookupvariantref(param_01, param_06);
        if(!isDefined(var_0F)) {
          validationerror("badVariantRef", var_0A, param_01);
          param_00.invaliditems[var_0B] = 1;
        } else if(var_0F != var_0E) {
          validationerror("lootDataMismatch", var_0A, param_01);
          param_00.invaliditems[var_0B] = 1;
        }
      }
    }

    validateattachments(param_00, param_02, param_01, var_08, var_0A);
  }
}

validateattachments(param_00, param_01, param_02, param_03, param_04) {
  var_05 = scripts\mp\utility::weapongroupmap(param_02);
  var_06 = getsubstr(var_05, 7) + "Attach";
  var_07 = scripts\engine\utility::ter_op(param_04 == "primary", 2, 5);
  var_08 = 0;
  var_09 = 0;
  var_0A = scripts\engine\utility::ter_op(param_04 == "primary", 2, 2);
  foreach(var_11, var_0C in param_01) {
    var_0D = 0;
    if(isDefined(var_0C) && var_0C != "none") {
      var_0E = scripts\mp\utility::getattachmenttype(var_0C);
      if(isDefined(var_0E) && var_0E != "") {
        var_0F = scripts\mp\utility::attachmentmap_tounique(var_0C, param_02);
        if(isDefined(var_0F)) {
          if(var_0E == "rail") {
            var_0D = 1;
          }
        }
      }

      var_10 = param_03 + "+" + var_0C;
      if(!self isitemunlocked(var_10, var_06)) {
        validationerror("lockedAttachment", param_04, var_0C);
        param_00.invaliditems[var_07][param_00.invaliditems[var_07].size] = var_11;
      }

      if(!scripts\mp\weapons::func_9F3C(param_03, var_0C)) {
        validationerror("nonSelectableAttachment", param_04, var_0C);
        param_00.invaliditems[var_07][param_00.invaliditems[var_07].size] = var_11;
      }

      if(var_0D) {
        var_08++;
        param_00.var_D640++;
      } else {
        var_09++;
        if(var_09 <= var_0A) {
          param_00.var_D640++;
        } else {
          param_00.var_13D1E[param_04 + "_attachment_" + var_09 + 1] = 1;
          param_00.var_D640 = param_00.var_D640 + 2;
        }
      }
    }
  }

  if(var_09 > 5) {
    validationerror("tooManyAttachments", param_04, var_09);
    param_00.invaliditems[scripts\engine\utility::ter_op(param_04 == "primary", 3, 6)] = 1;
  }

  if(var_08 > 1) {
    validationerror("tooManyOpticAttachments", param_04, var_08);
    param_00.invaliditems[scripts\engine\utility::ter_op(param_04 == "primary", 3, 6)] = 1;
  }
}

func_13146(param_00, param_01, param_02, param_03) {
  var_04 = scripts\engine\utility::ter_op(param_02 == "primary", 7, 8);
  if(isDefined(param_01) && param_01 != "none") {
    if(!isDefined(level.powers[param_01])) {
      validationerror("unknownPower", param_02, param_01);
      param_00.invaliditems[var_04] = 1;
    }

    if(!self isitemunlocked(param_01, "power")) {
      validationerror("lockedPower", param_02, param_01);
      param_00.invaliditems[var_04] = 1;
    }

    var_05 = lookuppowerslot(param_01);
    if(!isDefined(var_05)) {
      validationerror("unknownMenuPower", param_02, param_01);
      param_00.invaliditems[var_04] = 1;
    } else if(var_05 != param_02) {
      validationerror("powerInWrongSlot", param_02, param_01);
      param_00.invaliditems[var_04] = 1;
    }

    param_00.var_D640++;
  }

  if(scripts\mp\utility::istrue(param_03)) {
    param_00.var_D640 = param_00.var_D640 + 2;
    var_06 = scripts\engine\utility::ter_op(param_02 == "primary", "extra_lethal", "extra_tactical");
    param_00.var_13D1E[var_06] = 1;
  }
}

func_13145(param_00, param_01, param_02) {
  var_03 = [];
  var_03[1] = 0;
  var_03[2] = 0;
  var_03[3] = 0;
  foreach(var_05 in param_01) {
    if(isDefined(var_05) && var_05 != "none") {
      if(!isDefined(level.perksuseslot[var_05])) {
        validationerror("invalidPerk", undefined, var_05);
        param_00.invaliditems[9][param_00.invaliditems[9].size] = var_05;
      }

      var_06 = scripts\mp\perks\_perks::_meth_805C(var_05);
      if(isDefined(var_06)) {
        var_03[var_06]++;
        if(var_03[var_06] > 2) {
          validationerror("tooManyPerks", var_06, var_05);
          param_00.invaliditems[9][param_00.invaliditems[9].size] = var_05;
        }

        if(!self isitemunlocked(var_05, "perk")) {
          validationerror("lockedPerk", var_06, var_05);
          param_00.invaliditems[9][param_00.invaliditems[9].size] = var_05;
        }

        if(var_03[var_06] == 1) {
          param_00.var_D640++;
        } else {
          param_00.var_13D1E["extra_perk_" + var_06] = 1;
          param_00.var_D640 = param_00.var_D640 + 2;
        }
      } else if(isDefined(level.menurigperks[var_05])) {
        if(level.menurigperks[var_05].archetype != param_02) {
          validationerror("rigPerkOnWrongRig", undefined, var_05);
          param_00.invaliditems[9][param_00.invaliditems[9].size] = var_05;
        }

        if(!self isitemunlocked(var_05, "trait")) {
          validationerror("lockedRigPerk", var_06, var_05);
          param_00.invaliditems[9][param_00.invaliditems[9].size] = var_05;
        }
      } else {
        validationerror("unknownPerkType", undefined, var_05);
        param_00.invaliditems[9][param_00.invaliditems[9].size] = var_05;
      }
    }
  }
}

validatestreaks(param_00, param_01, param_02, param_03) {
  var_04 = [param_01, param_02, param_03];
  foreach(var_06 in var_04) {
    if(var_06 == "none") {
      continue;
    }

    var_07 = scripts\mp\killstreaks\_killstreaks::getkillstreaksetupinfo(var_06);
    if(!isDefined(var_07)) {
      validationerror("unknownStreak", undefined, var_06);
      param_00.invaliditems[12] = 1;
    }

    if(!self isitemunlocked(var_06, "killstreak")) {
      validationerror("lockedStreak", undefined, var_06);
      param_00.invaliditems[12] = 1;
    }
  }

  if(param_01 == param_02 && param_01 != "none") {
    validationerror("duplicateStreak", undefined, param_01);
    param_00.invaliditems[12] = 1;
    return;
  }

  if(param_01 == param_03 && param_01 != "none") {
    validationerror("duplicateStreak", undefined, param_01);
    param_00.invaliditems[12] = 1;
    return;
  }

  if(param_02 == param_03 && param_02 != "none") {
    validationerror("duplicateStreak", undefined, param_02);
    param_00.invaliditems[12] = 1;
    return;
  }
}

validatearchetype(param_00, param_01) {
  if(!isDefined(level.archetypeids[param_01])) {
    validationerror("unknownArchetype", undefined, param_01);
    param_00.invaliditems[10] = 1;
  }

  if(!self isitemunlocked(param_01, "rig")) {
    validationerror("lockedArchetype", undefined, param_01);
    param_00.invaliditems[10] = 1;
  }
}

func_13148(param_00, param_01, param_02) {
  if(!isDefined(param_01) || param_01 == "none") {
    return;
  }

  var_03 = level.var_10E4E[param_01];
  if(!isDefined(var_03)) {
    validationerror("unknownSuper", undefined, param_01);
    param_00.invaliditems[11] = 1;
  } else if(var_03.archetype != param_02) {
    validationerror("superOnWrongRig", undefined, param_01);
    param_00.invaliditems[11] = 1;
  }

  if(!self isitemunlocked(param_01, "super")) {
    validationerror("lockedSuper", undefined, param_01);
    param_00.invaliditems[11] = 1;
  }
}

func_1314C(param_00) {}

fixloadout(param_00) {
  var_01 = scripts\mp\class::loadout_getclassstruct();
  var_01.loadoutarchetype = "archetype_assault";
  var_01.loadoutprimary = "iw7_m4";
  return var_01;
}

fixweapon(param_00, param_01) {
  if(param_01 == "primary") {
    param_00.loadoutprimary = "iw7_m4";
    param_00.loadoutprimarycamo = "none";
    param_00.loadoutprimaryreticle = "none";
    param_00.loadoutprimarylootitemid = 0;
    param_00.loadoutprimaryvariantid = -1;
    for(var_02 = 0; var_02 < scripts\mp\class::getmaxprimaryattachments(); var_02++) {
      param_00.loadoutprimaryattachments[var_02] = "none";
    }

    return;
  }

  param_01.loadoutsecondary = "none";
  param_01.loadoutsecondarycamo = "none";
  param_01.loadoutsecondaryreticle = "none";
  param_01.var_AE9E = 0;
  param_01.var_AEA5 = -1;
  for(var_02 = 0; var_02 < scripts\mp\class::getmaxsecondaryattachments(); var_02++) {
    param_00.loadoutsecondaryattachments[var_02] = "none";
  }
}

fixattachment(param_00, param_01, param_02) {
  if(param_01 == "primary") {
    param_00.loadoutprimaryattachments[param_02] = "none";
    return;
  }

  param_00.loadoutsecondaryattachments[param_02] = "none";
}

fixpower(param_00, param_01) {
  if(param_01 == "primary") {
    param_00.var_AE7B = "none";
    param_00.var_AE7C = [];
    param_00.loadoutextrapowerprimary = 0;
    return;
  }

  param_00.var_AE7D = "none";
  param_00.var_AE7E = [];
  param_00.loadoutextrapowersecondary = 0;
}

fixperk(param_00, param_01) {
  param_00.loadoutperks = scripts\engine\utility::array_remove(param_00.loadoutperks, param_01);
}

fixkillstreaks(param_00) {
  param_00.loadoutkillstreak1 = "none";
  param_00.var_AE6F = [];
  param_00.loadoutkillstreak2 = "none";
  param_00.var_AE71 = [];
  param_00.loadoutkillstreak3 = "none";
  param_00.var_AE73 = [];
}

fixarchetype(param_00) {
  param_00.loadoutarchetype = "archetype_assault";
  fixsuper(param_00);
  foreach(var_02 in param_00.loadoutperks) {
    if(isDefined(level.menurigperks[var_02])) {
      fixperk(param_00, var_02);
      break;
    }
  }
}

fixsuper(param_00) {
  param_00.loadoutsuper = "none";
}

fixinvaliditems(param_00, param_01) {
  if(isDefined(param_01[0])) {
    param_00 = fixloadout(param_00);
    return param_00;
  }

  if(isDefined(param_01[1])) {
    fixweapon(param_00, "primary");
  } else if(isDefined(param_01[3])) {
    for(var_02 = 0; var_02 < scripts\mp\class::getmaxprimaryattachments(); var_02++) {
      fixattachment(param_00, "primary", var_02);
    }
  } else {
    foreach(var_02 in var_02[2]) {
      fixattachment(param_00, "primary", var_02);
    }
  }

  if(isDefined(param_01[4])) {
    fixweapon(param_00, "secondary");
  } else if(isDefined(param_01[6])) {
    for(var_02 = 0; var_02 < scripts\mp\class::getmaxsecondaryattachments(); var_02++) {
      fixattachment(param_00, "secondary", var_02);
    }
  } else {
    foreach(var_02 in var_02[5]) {
      fixattachment(param_00, "secondary", var_02);
    }
  }

  if(isDefined(param_01[7])) {
    fixpower(param_00, "primary");
  }

  if(isDefined(param_01[8])) {
    fixpower(param_00, "secondary");
  }

  foreach(var_08 in param_01[9]) {
    fixperk(param_00, var_08);
  }

  if(isDefined(param_01[10])) {
    fixarchetype(param_00);
  } else if(isDefined(param_01[11])) {
    fixarchetype(param_00);
  }

  if(isDefined(param_01[12])) {
    fixkillstreaks(param_00);
  }

  return param_00;
}

lookuppowerslot(param_00) {
  var_01 = tablelookup("mp\menuPowers.csv", 3, param_00, 2);
  if(!isDefined(var_01) || var_01 != "1" && var_01 != "2") {
    return undefined;
  }

  return scripts\engine\utility::ter_op(var_01 == "1", "primary", "secondary");
}

weaponunlocksvialoot(param_00) {
  switch (param_00) {
    case "iw7_venomx":
    case "iw7_unsalmg":
    case "iw7_mp28":
    case "iw7_crdb":
    case "iw7_udm45":
    case "iw7_katana":
    case "iw7_nunchucks":
    case "iw7_mag":
    case "iw7_mod2187":
    case "iw7_ba50cal":
    case "iw7_vr":
    case "iw7_minilmg":
    case "iw7_longshot":
    case "iw7_axe":
    case "iw7_gauss":
    case "iw7_revolver":
    case "iw7_tacburst":
    case "iw7_rvn":
      return 1;
  }

  return 0;
}