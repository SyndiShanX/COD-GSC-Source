/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2810.gsc
**************************************/

validationerror(var_0, var_1, var_2) {
  var_3 = var_0;

  if(isDefined(var_1)) {
    var_3 = var_3 + "_" + var_1;
  }

  if(isDefined(var_2)) {
    var_3 = var_3 + " - " + var_2;
  }

  if(getdvarint("scr_validate_print", 0) == 1) {}

  if(getdvarint("scr_validate_assert", 0) == 1) {}

  if(getdvarint("scr_validate_record", 0) == 1) {
    scripts\mp\class::recordvalidationinfraction();
  }
}

validateloadout(var_0) {
  var_1 = spawnStruct();
  var_1.var_D640 = 0;
  var_1.var_13D1E = [];
  var_1.invaliditems = [];
  var_1.invaliditems[2] = [];
  var_1.invaliditems[5] = [];
  var_1.invaliditems[9] = [];
  func_1314B(var_1, var_0.loadoutprimary, var_0.loadoutprimaryattachments, var_0.loadoutprimarycamo, var_0.loadoutprimaryreticle, var_0.loadoutprimarylootitemid, var_0.loadoutprimaryvariantid, 0);
  func_1314B(var_1, var_0.loadoutsecondary, var_0.loadoutsecondaryattachments, var_0.loadoutsecondarycamo, var_0.loadoutsecondaryreticle, var_0.var_AE9E, var_0.var_AEA5, 1);
  func_13146(var_1, var_0.var_AE7B, "primary", var_0.var_AE69);
  func_13146(var_1, var_0.var_AE7D, "secondary", var_0.var_AE6A);
  func_13145(var_1, var_0.loadoutperks, var_0.loadoutarchetype);
  validatestreaks(var_1, var_0.loadoutkillstreak1, var_0.loadoutkillstreak2, var_0.loadoutkillstreak3);
  func_13148(var_1, var_0.loadoutsuper, var_0.loadoutarchetype);
  validatearchetype(var_1, var_0.loadoutarchetype);

  if(var_1.var_D640 > 10) {
    validationerror("totalPointCost");
    var_1.invaliditems[0] = 1;
  }

  func_1314C(var_1);
  var_0 = fixinvaliditems(var_0, var_1.invaliditems);
  return var_0;
}

func_1314B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = scripts\mp\utility\game::getweaponrootname(var_1);
  var_9 = scripts\mp\utility\game::iscacsecondaryweapon(var_1);
  var_10 = scripts\engine\utility::ter_op(var_7, "secondary", "primary");
  var_11 = scripts\engine\utility::ter_op(var_7, 4, 1);

  if(isDefined(var_1) && var_1 != "none" && var_1 != "iw7_fists") {
    var_0.var_D640++;

    if(var_7) {
      if(!var_9) {
        var_0.var_D640++;
        var_0.var_13D1E["overkill"] = 1;
      }
    } else if(var_9) {
      validationerror("secondaryAsPrimary", undefined, var_1);
      var_0.invaliditems[var_11] = 1;
    }

    var_12 = scripts\mp\utility\game::func_13CAC(var_8);

    if(!isDefined(var_12)) {
      validationerror("unknownWeapon", var_10, var_1);
      var_0.invaliditems[var_11] = 1;
    } else {
      var_13 = tablelookup("mp\statstable.csv", 0, var_12, 41);

      if(int(var_13) < 0) {
        validationerror("unreleasedWeapon", var_10, var_1);
        var_0.invaliditems[var_11] = 1;
      }
    }

    if(!self getteamdompoints(var_8, "weapon") && !weaponunlocksvialoot(var_8)) {
      validationerror("lockedWeapon", var_10, var_1);
      var_0.invaliditems[var_11] = 1;
    }

    if(var_5 == 0) {
      if(var_6 != -1) {
        validationerror("emptyItemIDMismatch", var_10, var_1);
        var_0.invaliditems[var_11] = 1;
      }
    } else if(var_6 == -1) {
      validationerror("emptyVariantIDMismatch", var_10, var_1);
      var_0.invaliditems[var_11] = 1;
    } else {
      if(!scripts\mp\loot::isweaponitem(var_5)) {
        validationerror("nonWeaponLootItemID", var_10, var_1);
        var_0.invaliditems[var_11] = 1;
      }

      var_14 = scripts\mp\loot::getlootweaponref(var_5);

      if(!isDefined(var_14)) {
        validationerror("badLootItemID", var_10, var_1);
        var_0.invaliditems[var_11] = 1;
      } else {
        var_15 = scripts\mp\loot::lookupvariantref(var_1, var_6);

        if(!isDefined(var_15)) {
          validationerror("badVariantRef", var_10, var_1);
          var_0.invaliditems[var_11] = 1;
        } else if(var_15 != var_14) {
          validationerror("lootDataMismatch", var_10, var_1);
          var_0.invaliditems[var_11] = 1;
        }
      }
    }

    validateattachments(var_0, var_2, var_1, var_8, var_10);
  }
}

validateattachments(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\utility\game::weapongroupmap(var_2);
  var_6 = getsubstr(var_5, 7) + "Attach";
  var_7 = scripts\engine\utility::ter_op(var_4 == "primary", 2, 5);
  var_8 = 0;
  var_9 = 0;
  var_10 = scripts\engine\utility::ter_op(var_4 == "primary", 2, 2);

  foreach(var_17, var_12 in var_1) {
    var_13 = 0;

    if(isDefined(var_12) && var_12 != "none") {
      var_14 = scripts\mp\utility\game::getattachmenttype(var_12);

      if(isDefined(var_14) && var_14 != "") {
        var_15 = scripts\mp\utility\game::attachmentmap_tounique(var_12, var_2);

        if(isDefined(var_15)) {
          if(var_14 == "rail") {
            var_13 = 1;
          }
        }
      }

      var_16 = var_3 + "+" + var_12;

      if(!self getteamdompoints(var_16, var_6)) {
        validationerror("lockedAttachment", var_4, var_12);
        var_0.invaliditems[var_7][var_0.invaliditems[var_7].size] = var_17;
      }

      if(!scripts\mp\weapons::func_9F3C(var_3, var_12)) {
        validationerror("nonSelectableAttachment", var_4, var_12);
        var_0.invaliditems[var_7][var_0.invaliditems[var_7].size] = var_17;
      }

      if(var_13) {
        var_8++;
        var_0.var_D640++;
      } else {
        var_9++;

        if(var_9 <= var_10) {
          var_0.var_D640++;
        } else {
          var_0.var_13D1E[var_4 + "_attachment_" + (var_9 + 1)] = 1;
          var_0.var_D640 = var_0.var_D640 + 2;
        }
      }
    }
  }

  if(var_9 > 5) {
    validationerror("tooManyAttachments", var_4, var_9);
    var_0.invaliditems[scripts\engine\utility::ter_op(var_4 == "primary", 3, 6)] = 1;
  }

  if(var_8 > 1) {
    validationerror("tooManyOpticAttachments", var_4, var_8);
    var_0.invaliditems[scripts\engine\utility::ter_op(var_4 == "primary", 3, 6)] = 1;
  }
}

func_13146(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::ter_op(var_2 == "primary", 7, 8);

  if(isDefined(var_1) && var_1 != "none") {
    if(!isDefined(level.powers[var_1])) {
      validationerror("unknownPower", var_2, var_1);
      var_0.invaliditems[var_4] = 1;
    }

    if(!self getteamdompoints(var_1, "power")) {
      validationerror("lockedPower", var_2, var_1);
      var_0.invaliditems[var_4] = 1;
    }

    var_5 = lookuppowerslot(var_1);

    if(!isDefined(var_5)) {
      validationerror("unknownMenuPower", var_2, var_1);
      var_0.invaliditems[var_4] = 1;
    } else if(var_5 != var_2) {
      validationerror("powerInWrongSlot", var_2, var_1);
      var_0.invaliditems[var_4] = 1;
    }

    var_0.var_D640++;
  }

  if(scripts\mp\utility\game::istrue(var_3)) {
    var_0.var_D640 = var_0.var_D640 + 2;
    var_6 = scripts\engine\utility::ter_op(var_2 == "primary", "extra_lethal", "extra_tactical");
    var_0.var_13D1E[var_6] = 1;
  }
}

func_13145(var_0, var_1, var_2) {
  var_3 = [];
  var_3[1] = 0;
  var_3[2] = 0;
  var_3[3] = 0;

  foreach(var_5 in var_1) {
    if(isDefined(var_5) && var_5 != "none") {
      if(!isDefined(level.perksuseslot[var_5])) {
        validationerror("invalidPerk", undefined, var_5);
        var_0.invaliditems[9][var_0.invaliditems[9].size] = var_5;
      }

      var_6 = scripts\mp\perks::func_805C(var_5);

      if(isDefined(var_6)) {
        var_3[var_6]++;

        if(var_3[var_6] > 2) {
          validationerror("tooManyPerks", var_6, var_5);
          var_0.invaliditems[9][var_0.invaliditems[9].size] = var_5;
        }

        if(!self getteamdompoints(var_5, "perk")) {
          validationerror("lockedPerk", var_6, var_5);
          var_0.invaliditems[9][var_0.invaliditems[9].size] = var_5;
        }

        if(var_3[var_6] == 1) {
          var_0.var_D640++;
        } else {
          var_0.var_13D1E["extra_perk_" + var_6] = 1;
          var_0.var_D640 = var_0.var_D640 + 2;
        }
      } else if(isDefined(level.menurigperks[var_5])) {
        if(level.menurigperks[var_5].archetype != var_2) {
          validationerror("rigPerkOnWrongRig", undefined, var_5);
          var_0.invaliditems[9][var_0.invaliditems[9].size] = var_5;
        }

        if(!self getteamdompoints(var_5, "trait")) {
          validationerror("lockedRigPerk", var_6, var_5);
          var_0.invaliditems[9][var_0.invaliditems[9].size] = var_5;
        }
      } else {
        validationerror("unknownPerkType", undefined, var_5);
        var_0.invaliditems[9][var_0.invaliditems[9].size] = var_5;
      }
    }
  }
}

validatestreaks(var_0, var_1, var_2, var_3) {
  var_4 = [var_1, var_2, var_3];

  foreach(var_6 in var_4) {
    if(var_6 == "none") {
      continue;
    }
    var_7 = scripts\mp\killstreaks\killstreaks::getkillstreaksetupinfo(var_6);

    if(!isDefined(var_7)) {
      validationerror("unknownStreak", undefined, var_6);
      var_0.invaliditems[12] = 1;
    }

    if(!self getteamdompoints(var_6, "killstreak")) {
      validationerror("lockedStreak", undefined, var_6);
      var_0.invaliditems[12] = 1;
    }
  }

  if(var_1 == var_2 && var_1 != "none") {
    validationerror("duplicateStreak", undefined, var_1);
    var_0.invaliditems[12] = 1;
  } else if(var_1 == var_3 && var_1 != "none") {
    validationerror("duplicateStreak", undefined, var_1);
    var_0.invaliditems[12] = 1;
  } else if(var_2 == var_3 && var_2 != "none") {
    validationerror("duplicateStreak", undefined, var_2);
    var_0.invaliditems[12] = 1;
  }
}

validatearchetype(var_0, var_1) {
  if(!isDefined(level.archetypeids[var_1])) {
    validationerror("unknownArchetype", undefined, var_1);
    var_0.invaliditems[10] = 1;
  }

  if(!self getteamdompoints(var_1, "rig")) {
    validationerror("lockedArchetype", undefined, var_1);
    var_0.invaliditems[10] = 1;
  }
}

func_13148(var_0, var_1, var_2) {
  if(!isDefined(var_1) || var_1 == "none") {
    return;
  }
  var_3 = level.var_10E4E[var_1];

  if(!isDefined(var_3)) {
    validationerror("unknownSuper", undefined, var_1);
    var_0.invaliditems[11] = 1;
  } else if(var_3.archetype != var_2) {
    validationerror("superOnWrongRig", undefined, var_1);
    var_0.invaliditems[11] = 1;
  }

  if(!self getteamdompoints(var_1, "super")) {
    validationerror("lockedSuper", undefined, var_1);
    var_0.invaliditems[11] = 1;
  }
}

func_1314C(var_0) {}

fixloadout(var_0) {
  var_1 = scripts\mp\class::loadout_getclassstruct();
  var_1.loadoutarchetype = "archetype_assault";
  var_1.loadoutprimary = "iw7_m4";
  return var_1;
}

fixweapon(var_0, var_1) {
  if(var_1 == "primary") {
    var_0.loadoutprimary = "iw7_m4";
    var_0.loadoutprimarycamo = "none";
    var_0.loadoutprimaryreticle = "none";
    var_0.loadoutprimarylootitemid = 0;
    var_0.loadoutprimaryvariantid = -1;

    for(var_2 = 0; var_2 < scripts\mp\class::getmaxprimaryattachments(); var_2++) {
      var_0.loadoutprimaryattachments[var_2] = "none";
    }
  } else {
    var_0.loadoutsecondary = "none";
    var_0.loadoutsecondarycamo = "none";
    var_0.loadoutsecondaryreticle = "none";
    var_0.var_AE9E = 0;
    var_0.var_AEA5 = -1;

    for(var_2 = 0; var_2 < scripts\mp\class::getmaxsecondaryattachments(); var_2++) {
      var_0.loadoutsecondaryattachments[var_2] = "none";
    }
  }
}

fixattachment(var_0, var_1, var_2) {
  if(var_1 == "primary") {
    var_0.loadoutprimaryattachments[var_2] = "none";
  } else {
    var_0.loadoutsecondaryattachments[var_2] = "none";
  }
}

fixpower(var_0, var_1) {
  if(var_1 == "primary") {
    var_0.var_AE7B = "none";
    var_0.var_AE7C = [];
    var_0.loadoutextrapowerprimary = 0;
  } else {
    var_0.var_AE7D = "none";
    var_0.var_AE7E = [];
    var_0.loadoutextrapowersecondary = 0;
  }
}

fixperk(var_0, var_1) {
  var_0.loadoutperks = scripts\engine\utility::array_remove(var_0.loadoutperks, var_1);
}

fixkillstreaks(var_0) {
  var_0.loadoutkillstreak1 = "none";
  var_0.var_AE6F = [];
  var_0.loadoutkillstreak2 = "none";
  var_0.var_AE71 = [];
  var_0.loadoutkillstreak3 = "none";
  var_0.var_AE73 = [];
}

fixarchetype(var_0) {
  var_0.loadoutarchetype = "archetype_assault";
  fixsuper(var_0);

  foreach(var_2 in var_0.loadoutperks) {
    if(isDefined(level.menurigperks[var_2])) {
      fixperk(var_0, var_2);
      break;
    }
  }
}

fixsuper(var_0) {
  var_0.loadoutsuper = "none";
}

fixinvaliditems(var_0, var_1) {
  if(isDefined(var_1[0])) {
    var_0 = fixloadout(var_0);
    return var_0;
  }

  if(isDefined(var_1[1])) {
    fixweapon(var_0, "primary");
  } else if(isDefined(var_1[3])) {
    for(var_2 = 0; var_2 < scripts\mp\class::getmaxprimaryattachments(); var_2++) {
      fixattachment(var_0, "primary", var_2);
    }
  } else {
    foreach(var_2 in var_1[2]) {
      fixattachment(var_0, "primary", var_2);
    }
  }

  if(isDefined(var_1[4])) {
    fixweapon(var_0, "secondary");
  } else if(isDefined(var_1[6])) {
    for(var_2 = 0; var_2 < scripts\mp\class::getmaxsecondaryattachments(); var_2++) {
      fixattachment(var_0, "secondary", var_2);
    }
  } else {
    foreach(var_2 in var_1[5]) {
      fixattachment(var_0, "secondary", var_2);
    }
  }

  if(isDefined(var_1[7])) {
    fixpower(var_0, "primary");
  }

  if(isDefined(var_1[8])) {
    fixpower(var_0, "secondary");
  }

  foreach(var_8 in var_1[9]) {
    fixperk(var_0, var_8);
  }

  if(isDefined(var_1[10])) {
    fixarchetype(var_0);
  } else if(isDefined(var_1[11])) {
    fixarchetype(var_0);
  }

  if(isDefined(var_1[12])) {
    fixkillstreaks(var_0);
  }

  return var_0;
}

lookuppowerslot(var_0) {
  var_1 = tablelookup("mp\menuPowers.csv", 3, var_0, 2);

  if(!isDefined(var_1) || var_1 != "1" && var_1 != "2") {
    return undefined;
  }

  return scripts\engine\utility::ter_op(var_1 == "1", "primary", "secondary");
}

weaponunlocksvialoot(var_0) {
  switch (var_0) {
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