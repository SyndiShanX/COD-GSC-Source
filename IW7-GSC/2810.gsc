/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2810.gsc
***************************************/

validationerror(var_00, var_01, var_02) {
  var_03 = var_00;

  if(isDefined(var_01)) {
    var_03 = var_03 + "_" + var_01;
  }

  if(isDefined(var_02)) {
    var_03 = var_03 + " - " + var_02;
  }

  if(getdvarint("scr_validate_print", 0) == 1) {}

  if(getdvarint("scr_validate_assert", 0) == 1) {}

  if(getdvarint("scr_validate_record", 0) == 1) {
    scripts\mp\class::recordvalidationinfraction();
  }
}

validateloadout(var_00) {
  var_01 = spawnStruct();
  var_1.func_D640 = 0;
  var_1.func_13D1E = [];
  var_1.invaliditems = [];
  var_1.invaliditems[2] = [];
  var_1.invaliditems[5] = [];
  var_1.invaliditems[9] = [];
  func_1314B(var_01, var_0.loadoutprimary, var_0.loadoutprimaryattachments, var_0.loadoutprimarycamo, var_0.loadoutprimaryreticle, var_0.loadoutprimarylootitemid, var_0.loadoutprimaryvariantid, 0);
  func_1314B(var_01, var_0.loadoutsecondary, var_0.loadoutsecondaryattachments, var_0.loadoutsecondarycamo, var_0.loadoutsecondaryreticle, var_0.func_AE9E, var_0.func_AEA5, 1);
  func_13146(var_01, var_0.func_AE7B, "primary", var_0.func_AE69);
  func_13146(var_01, var_0.func_AE7D, "secondary", var_0.func_AE6A);
  func_13145(var_01, var_0.loadoutperks, var_0.loadoutarchetype);
  validatestreaks(var_01, var_0.loadoutkillstreak1, var_0.loadoutkillstreak2, var_0.loadoutkillstreak3);
  func_13148(var_01, var_0.loadoutsuper, var_0.loadoutarchetype);
  validatearchetype(var_01, var_0.loadoutarchetype);

  if(var_1.func_D640 > 10) {
    validationerror("totalPointCost");
    var_1.invaliditems[0] = 1;
  }

  func_1314C(var_01);
  var_00 = fixinvaliditems(var_00, var_1.invaliditems);
  return var_00;
}

func_1314B(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  var_08 = scripts\mp\utility\game::getweaponrootname(var_01);
  var_09 = scripts\mp\utility\game::iscacsecondaryweapon(var_01);
  var_10 = scripts\engine\utility::ter_op(var_07, "secondary", "primary");
  var_11 = scripts\engine\utility::ter_op(var_07, 4, 1);

  if(isDefined(var_01) && var_01 != "none" && var_01 != "iw7_fists") {
    var_0.func_D640++;

    if(var_07) {
      if(!var_09) {
        var_0.func_D640++;
        var_0.func_13D1E["overkill"] = 1;
      }
    } else if(var_09) {
      validationerror("secondaryAsPrimary", undefined, var_01);
      var_0.invaliditems[var_11] = 1;
    }

    var_12 = scripts\mp\utility\game::func_13CAC(var_08);

    if(!isDefined(var_12)) {
      validationerror("unknownWeapon", var_10, var_01);
      var_0.invaliditems[var_11] = 1;
    } else {
      var_13 = tablelookup("mp\statstable.csv", 0, var_12, 41);

      if(int(var_13) < 0) {
        validationerror("unreleasedWeapon", var_10, var_01);
        var_0.invaliditems[var_11] = 1;
      }
    }

    if(!self getteamdompoints(var_08, "weapon") && !weaponunlocksvialoot(var_08)) {
      validationerror("lockedWeapon", var_10, var_01);
      var_0.invaliditems[var_11] = 1;
    }

    if(var_05 == 0) {
      if(var_06 != -1) {
        validationerror("emptyItemIDMismatch", var_10, var_01);
        var_0.invaliditems[var_11] = 1;
      }
    } else if(var_06 == -1) {
      validationerror("emptyVariantIDMismatch", var_10, var_01);
      var_0.invaliditems[var_11] = 1;
    } else {
      if(!scripts\mp\loot::isweaponitem(var_05)) {
        validationerror("nonWeaponLootItemID", var_10, var_01);
        var_0.invaliditems[var_11] = 1;
      }

      var_14 = scripts\mp\loot::getlootweaponref(var_05);

      if(!isDefined(var_14)) {
        validationerror("badLootItemID", var_10, var_01);
        var_0.invaliditems[var_11] = 1;
      } else {
        var_15 = scripts\mp\loot::lookupvariantref(var_01, var_06);

        if(!isDefined(var_15)) {
          validationerror("badVariantRef", var_10, var_01);
          var_0.invaliditems[var_11] = 1;
        } else if(var_15 != var_14) {
          validationerror("lootDataMismatch", var_10, var_01);
          var_0.invaliditems[var_11] = 1;
        }
      }
    }

    validateattachments(var_00, var_02, var_01, var_08, var_10);
  }
}

validateattachments(var_00, var_01, var_02, var_03, var_04) {
  var_05 = scripts\mp\utility\game::weapongroupmap(var_02);
  var_06 = getsubstr(var_05, 7) + "Attach";
  var_07 = scripts\engine\utility::ter_op(var_04 == "primary", 2, 5);
  var_08 = 0;
  var_09 = 0;
  var_10 = scripts\engine\utility::ter_op(var_04 == "primary", 2, 2);

  foreach(var_17, var_12 in var_01) {
    var_13 = 0;

    if(isDefined(var_12) && var_12 != "none") {
      var_14 = scripts\mp\utility\game::getattachmenttype(var_12);

      if(isDefined(var_14) && var_14 != "") {
        var_15 = scripts\mp\utility\game::attachmentmap_tounique(var_12, var_02);

        if(isDefined(var_15)) {
          if(var_14 == "rail") {
            var_13 = 1;
          }
        }
      }

      var_16 = var_03 + "+" + var_12;

      if(!self getteamdompoints(var_16, var_06)) {
        validationerror("lockedAttachment", var_04, var_12);
        var_0.invaliditems[var_07][var_0.invaliditems[var_07].size] = var_17;
      }

      if(!scripts\mp\weapons::func_9F3C(var_03, var_12)) {
        validationerror("nonSelectableAttachment", var_04, var_12);
        var_0.invaliditems[var_07][var_0.invaliditems[var_07].size] = var_17;
      }

      if(var_13) {
        var_8++;
        var_0.func_D640++;
      } else {
        var_9++;

        if(var_09 <= var_10) {
          var_0.func_D640++;
        } else {
          var_0.func_13D1E[var_04 + "_attachment_" + (var_09 + 1)] = 1;
          var_0.func_D640 = var_0.func_D640 + 2;
        }
      }
    }
  }

  if(var_09 > 5) {
    validationerror("tooManyAttachments", var_04, var_09);
    var_0.invaliditems[scripts\engine\utility::ter_op(var_04 == "primary", 3, 6)] = 1;
  }

  if(var_08 > 1) {
    validationerror("tooManyOpticAttachments", var_04, var_08);
    var_0.invaliditems[scripts\engine\utility::ter_op(var_04 == "primary", 3, 6)] = 1;
  }
}

func_13146(var_00, var_01, var_02, var_03) {
  var_04 = scripts\engine\utility::ter_op(var_02 == "primary", 7, 8);

  if(isDefined(var_01) && var_01 != "none") {
    if(!isDefined(level.powers[var_01])) {
      validationerror("unknownPower", var_02, var_01);
      var_0.invaliditems[var_04] = 1;
    }

    if(!self getteamdompoints(var_01, "power")) {
      validationerror("lockedPower", var_02, var_01);
      var_0.invaliditems[var_04] = 1;
    }

    var_05 = lookuppowerslot(var_01);

    if(!isDefined(var_05)) {
      validationerror("unknownMenuPower", var_02, var_01);
      var_0.invaliditems[var_04] = 1;
    } else if(var_05 != var_02) {
      validationerror("powerInWrongSlot", var_02, var_01);
      var_0.invaliditems[var_04] = 1;
    }

    var_0.func_D640++;
  }

  if(scripts\mp\utility\game::istrue(var_03)) {
    var_0.func_D640 = var_0.func_D640 + 2;
    var_06 = scripts\engine\utility::ter_op(var_02 == "primary", "extra_lethal", "extra_tactical");
    var_0.func_13D1E[var_06] = 1;
  }
}

func_13145(var_00, var_01, var_02) {
  var_03 = [];
  var_3[1] = 0;
  var_3[2] = 0;
  var_3[3] = 0;

  foreach(var_05 in var_01) {
    if(isDefined(var_05) && var_05 != "none") {
      if(!isDefined(level.perksuseslot[var_05])) {
        validationerror("invalidPerk", undefined, var_05);
        var_0.invaliditems[9][var_0.invaliditems[9].size] = var_05;
      }

      var_06 = scripts\mp\perks::_meth_805C(var_05);

      if(isDefined(var_06)) {
        var_3[var_06]++;

        if(var_3[var_06] > 2) {
          validationerror("tooManyPerks", var_06, var_05);
          var_0.invaliditems[9][var_0.invaliditems[9].size] = var_05;
        }

        if(!self getteamdompoints(var_05, "perk")) {
          validationerror("lockedPerk", var_06, var_05);
          var_0.invaliditems[9][var_0.invaliditems[9].size] = var_05;
        }

        if(var_3[var_06] == 1) {
          var_0.func_D640++;
        } else {
          var_0.func_13D1E["extra_perk_" + var_06] = 1;
          var_0.func_D640 = var_0.func_D640 + 2;
        }
      } else if(isDefined(level.menurigperks[var_05])) {
        if(level.menurigperks[var_05].archetype != var_02) {
          validationerror("rigPerkOnWrongRig", undefined, var_05);
          var_0.invaliditems[9][var_0.invaliditems[9].size] = var_05;
        }

        if(!self getteamdompoints(var_05, "trait")) {
          validationerror("lockedRigPerk", var_06, var_05);
          var_0.invaliditems[9][var_0.invaliditems[9].size] = var_05;
        }
      } else {
        validationerror("unknownPerkType", undefined, var_05);
        var_0.invaliditems[9][var_0.invaliditems[9].size] = var_05;
      }
    }
  }
}

validatestreaks(var_00, var_01, var_02, var_03) {
  var_04 = [var_01, var_02, var_03];

  foreach(var_06 in var_04) {
    if(var_06 == "none") {
      continue;
    }
    var_07 = scripts\mp\killstreaks\killstreaks::getkillstreaksetupinfo(var_06);

    if(!isDefined(var_07)) {
      validationerror("unknownStreak", undefined, var_06);
      var_0.invaliditems[12] = 1;
    }

    if(!self getteamdompoints(var_06, "killstreak")) {
      validationerror("lockedStreak", undefined, var_06);
      var_0.invaliditems[12] = 1;
    }
  }

  if(var_01 == var_02 && var_01 != "none") {
    validationerror("duplicateStreak", undefined, var_01);
    var_0.invaliditems[12] = 1;
  } else if(var_01 == var_03 && var_01 != "none") {
    validationerror("duplicateStreak", undefined, var_01);
    var_0.invaliditems[12] = 1;
  } else if(var_02 == var_03 && var_02 != "none") {
    validationerror("duplicateStreak", undefined, var_02);
    var_0.invaliditems[12] = 1;
  }
}

validatearchetype(var_00, var_01) {
  if(!isDefined(level.archetypeids[var_01])) {
    validationerror("unknownArchetype", undefined, var_01);
    var_0.invaliditems[10] = 1;
  }

  if(!self getteamdompoints(var_01, "rig")) {
    validationerror("lockedArchetype", undefined, var_01);
    var_0.invaliditems[10] = 1;
  }
}

func_13148(var_00, var_01, var_02) {
  if(!isDefined(var_01) || var_01 == "none") {
    return;
  }
  var_03 = level.func_10E4E[var_01];

  if(!isDefined(var_03)) {
    validationerror("unknownSuper", undefined, var_01);
    var_0.invaliditems[11] = 1;
  } else if(var_3.archetype != var_02) {
    validationerror("superOnWrongRig", undefined, var_01);
    var_0.invaliditems[11] = 1;
  }

  if(!self getteamdompoints(var_01, "super")) {
    validationerror("lockedSuper", undefined, var_01);
    var_0.invaliditems[11] = 1;
  }
}

func_1314C(var_00) {}

fixloadout(var_00) {
  var_01 = scripts\mp\class::loadout_getclassstruct();
  var_1.loadoutarchetype = "archetype_assault";
  var_1.loadoutprimary = "iw7_m4";
  return var_01;
}

fixweapon(var_00, var_01) {
  if(var_01 == "primary") {
    var_0.loadoutprimary = "iw7_m4";
    var_0.loadoutprimarycamo = "none";
    var_0.loadoutprimaryreticle = "none";
    var_0.loadoutprimarylootitemid = 0;
    var_0.loadoutprimaryvariantid = -1;

    for(var_02 = 0; var_02 < scripts\mp\class::getmaxprimaryattachments(); var_2++) {
      var_0.loadoutprimaryattachments[var_02] = "none";
    }
  } else {
    var_0.loadoutsecondary = "none";
    var_0.loadoutsecondarycamo = "none";
    var_0.loadoutsecondaryreticle = "none";
    var_0.func_AE9E = 0;
    var_0.func_AEA5 = -1;

    for(var_02 = 0; var_02 < scripts\mp\class::getmaxsecondaryattachments(); var_2++) {
      var_0.loadoutsecondaryattachments[var_02] = "none";
    }
  }
}

fixattachment(var_00, var_01, var_02) {
  if(var_01 == "primary") {
    var_0.loadoutprimaryattachments[var_02] = "none";
  } else {
    var_0.loadoutsecondaryattachments[var_02] = "none";
  }
}

fixpower(var_00, var_01) {
  if(var_01 == "primary") {
    var_0.func_AE7B = "none";
    var_0.func_AE7C = [];
    var_0.loadoutextrapowerprimary = 0;
  } else {
    var_0.func_AE7D = "none";
    var_0.func_AE7E = [];
    var_0.loadoutextrapowersecondary = 0;
  }
}

fixperk(var_00, var_01) {
  var_0.loadoutperks = scripts\engine\utility::array_remove(var_0.loadoutperks, var_01);
}

fixkillstreaks(var_00) {
  var_0.loadoutkillstreak1 = "none";
  var_0.func_AE6F = [];
  var_0.loadoutkillstreak2 = "none";
  var_0.func_AE71 = [];
  var_0.loadoutkillstreak3 = "none";
  var_0.func_AE73 = [];
}

fixarchetype(var_00) {
  var_0.loadoutarchetype = "archetype_assault";
  fixsuper(var_00);

  foreach(var_02 in var_0.loadoutperks) {
    if(isDefined(level.menurigperks[var_02])) {
      fixperk(var_00, var_02);
      break;
    }
  }
}

fixsuper(var_00) {
  var_0.loadoutsuper = "none";
}

fixinvaliditems(var_00, var_01) {
  if(isDefined(var_1[0])) {
    var_00 = fixloadout(var_00);
    return var_00;
  }

  if(isDefined(var_1[1])) {
    fixweapon(var_00, "primary");
  } else if(isDefined(var_1[3])) {
    for(var_02 = 0; var_02 < scripts\mp\class::getmaxprimaryattachments(); var_2++) {
      fixattachment(var_00, "primary", var_02);
    }
  } else {
    foreach(var_02 in var_1[2]) {
      fixattachment(var_00, "primary", var_02);
    }
  }

  if(isDefined(var_1[4])) {
    fixweapon(var_00, "secondary");
  } else if(isDefined(var_1[6])) {
    for(var_02 = 0; var_02 < scripts\mp\class::getmaxsecondaryattachments(); var_2++) {
      fixattachment(var_00, "secondary", var_02);
    }
  } else {
    foreach(var_02 in var_1[5]) {
      fixattachment(var_00, "secondary", var_02);
    }
  }

  if(isDefined(var_1[7])) {
    fixpower(var_00, "primary");
  }

  if(isDefined(var_1[8])) {
    fixpower(var_00, "secondary");
  }

  foreach(var_08 in var_1[9]) {
    fixperk(var_00, var_08);
  }

  if(isDefined(var_1[10])) {
    fixarchetype(var_00);
  } else if(isDefined(var_1[11])) {
    fixarchetype(var_00);
  }

  if(isDefined(var_1[12])) {
    fixkillstreaks(var_00);
  }

  return var_00;
}

lookuppowerslot(var_00) {
  var_01 = tablelookup("mp\menuPowers.csv", 3, var_00, 2);

  if(!isDefined(var_01) || var_01 != "1" && var_01 != "2") {
    return undefined;
  }

  return scripts\engine\utility::ter_op(var_01 == "1", "primary", "secondary");
}

weaponunlocksvialoot(var_00) {
  switch (var_00) {
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