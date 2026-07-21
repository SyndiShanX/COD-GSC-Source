/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\validation.gsc
***********************************************/

validationerror(var_0, var_1, var_2) {
  var_3 = var_0;

  if(isDefined(var_1))
    var_3 = var_3 + "_encstr_BA4C02DF" + var_1;

  if(isDefined(var_2))
    var_3 = var_3 + "_encstr_8E170401D682" + var_2;

  if(getdvarint("_encstr_9736136ED893EBEC16C65A23B08EB2EBE0C92DE647", 0) == 1) {}

  if(getdvarint("_encstr_AD08146BB0BB81FE6F1010F1B9CB7DF7A8D603851B23", 0) == 1) {}

  if(getdvarint("_encstr_836D14C3675059159F2BB322A7B125217A225E553D84", 0) == 1)
    scripts\mp\class::recordvalidationinfraction();
}

vandalize(var_0, var_1) {
  var_2 = getdvarint("_encstr_BA901FDC36E4FA6C34ACD8B62B0B36B4C80AD1A3C26CD06BB2E6A3AAE6B1F66CB6", 0) == 1;

  if(var_2)
    return scripts\mp\utility\weapon::carrier_cleanup(var_0, var_1);

  return 1;
}

_encstr_877723A5E6EEAC2CE07BB99D85395AB09B1DB1DE73322D474BBD732C36D82F36DED8B52B32(var_0, var_1) {
  if(!isDefined(var_1) || var_1 <= 0)
    return 0;

  if(!isDefined(level._encstr_BDDE1CC9599BA3E42D8D1DF5E6A1D7E643A5AC3691BECEC2E44BB073D19B))
    level._encstr_BDDE1CC9599BA3E42D8D1DF5E6A1D7E643A5AC3691BECEC2E44BB073D19B = getdvarint("_encstr_856E23E68D93D7C4E4FAE456B9A3E496B1D1EB9B867DB90D4BACD88C7DB32C9C4B2CE61DB9", 0);

  if(level._encstr_BDDE1CC9599BA3E42D8D1DF5E6A1D7E643A5AC3691BECEC2E44BB073D19B) {
    if(!isDefined(level._encstr_8D9B13A653B72029B97F10719F76289B83B92E5313)) {
      level._encstr_8D9B13A653B72029B97F10719F76289B83B92E5313 = [];
      level._encstr_8D9B13A653B72029B97F10719F76289B83B92E5313["_encstr_A25C10A877E1E3913F3AFB6004CF995F918F"] = 1;
      level._encstr_8D9B13A653B72029B97F10719F76289B83B92E5313["_encstr_A95C10DC1AEBADCAF5935A9B46A5CEEDC7C8"] = 1;
      level._encstr_8D9B13A653B72029B97F10719F76289B83B92E5313["_encstr_BA5C103768FADA95AF93A57319B49DDB8F33"] = 1;
    }

    var_2 = var_0 + "_encstr_854C021F" + var_1;

    if(isDefined(level._encstr_8D9B13A653B72029B97F10719F76289B83B92E5313[var_2]))
      return 1;
  }

  return 0;
}

validateloadout(var_0) {
  var_1 = scripts\mp\utility\weapon::weaponnumbermap(var_0.loadoutprimary);
  var_2 = 0;

  if(!isDefined(var_1))
    var_2 = 1;
  else if(vehicle_checktrailvfx(var_0.loadoutprimary))
    var_2 = 1;

  if(!scripts\mp\utility\weapon::iscacprimaryweapon(var_0.loadoutprimary))
    var_2 = 1;

  var_3 = 0;
  var_4 = 0;

  if(attachmentisrestricted(var_0.loadoutprimary)) {
    var_2 = 1;
    var_3 = 1;
  }

  if(!scripts\mp\weapons::vehicle_ai_avoidance_cleanup(var_0.loadoutprimary)) {
    var_2 = 1;
    var_3 = 1;
  }

  if(var_2) {
    var_5 = getDvar("_encstr_87B51E63D662E9AC4AA7C9EF83B176701B6BCBB87ECCE0ED01CBC5EBE77ABE68");

    if(var_5 == "_encstr_B40101")
      var_5 = "_encstr_8C160DAFE71BF161681EB5BCB0F8FC";

    var_0.loadoutprimary = var_5;
    var_0.loadoutprimaryattachments = [];
    var_0.loadoutprimarycamo = "_encstr_8BBA05185F8B99";
    var_0.loadoutprimaryreticle = "_encstr_8BBA05185F8B99";
    var_0.loadoutprimaryvariantid = -1;
    var_0.loadoutprimaryattachmentids = [];
    var_0.loadoutprimarycosmeticattachment = "_encstr_8BBA05185F8B99";
    var_0.loadoutprimarystickers[0] = "_encstr_8BBA05185F8B99";
    var_0.loadoutprimarystickers[1] = "_encstr_8BBA05185F8B99";
    var_0.loadoutprimarystickers[2] = "_encstr_8BBA05185F8B99";
    var_0.loadoutprimarystickers[3] = "_encstr_8BBA05185F8B99";
  } else {
    if(vehicle_collision(var_0.loadoutprimary, var_0.loadoutprimaryvariantid) || _encstr_877723A5E6EEAC2CE07BB99D85395AB09B1DB1DE73322D474BBD732C36D82F36DED8B52B32(var_0.loadoutprimary, var_0.loadoutprimaryvariantid))
      var_0.loadoutprimaryvariantid = -1;

    for(var_6 = 0; var_6 < var_0.loadoutprimaryattachments.size; var_6++) {
      var_7 = var_0.loadoutprimaryattachments[var_6];
      var_8 = var_0.loadoutprimaryattachmentids[var_6];

      if(turretparent(var_0.loadoutprimary, var_0.loadoutprimaryvariantid, var_7, var_8))
        var_0.loadoutprimaryattachmentids[var_6] = 0;

      if(var_7 != "_encstr_8BBA05185F8B99" && (perkisrestricted(var_7, var_0.loadoutprimary) || !vandalize(var_0.loadoutprimary, var_7))) {
        var_0.loadoutprimaryattachments[var_6] = "_encstr_8BBA05185F8B99";
        var_4 = 1;
      }
    }
  }

  var_1 = scripts\mp\utility\weapon::weaponnumbermap(var_0.loadoutsecondary);
  var_2 = 0;

  if(!isDefined(var_1))
    var_2 = 1;
  else if(vehicle_checktrailvfx(var_0.loadoutsecondary))
    var_2 = 1;

  var_9 = "_encstr_964616CBE2F359E0193A0BB817C54BF098D340205BB0F765";
  var_10 = !equipmentisrestricted(var_9) && scripts\engine\utility::array_contains(var_0.loadoutperks, var_9);

  if(scripts\mp\utility\weapon::iscacprimaryweapon(var_0.loadoutsecondary) && !var_10)
    var_2 = 1;

  if(attachmentisrestricted(var_0.loadoutsecondary)) {
    var_2 = 1;
    var_3 = 1;
  }

  if(!scripts\mp\weapons::vehicle_ai_avoidance_cleanup(var_0.loadoutprimary)) {
    var_2 = 1;
    var_3 = 1;
  }

  if(var_2) {
    var_11 = getDvar("_encstr_9A9C205B89AA87B7ED379B4FC3D93B11A6531BDFFF3BFF0BA08AD84F477D88194D89");

    if(var_11 == "_encstr_B40101")
      var_11 = "_encstr_9106102387E011DF472978E0722F376ADAB9";

    var_0.loadoutsecondary = var_11;
    var_0.loadoutsecondaryattachments = [];
    var_0.loadoutsecondarycamo = "_encstr_8BBA05185F8B99";
    var_0.loadoutsecondaryreticle = "_encstr_8BBA05185F8B99";
    var_0.loadoutsecondaryvariantid = -1;
    var_0.loadoutsecondaryattachmentids = [];
    var_0.loadoutsecondarycosmeticattachment = "_encstr_8BBA05185F8B99";
    var_0.loadoutsecondarystickers[0] = "_encstr_8BBA05185F8B99";
    var_0.loadoutsecondarystickers[1] = "_encstr_8BBA05185F8B99";
    var_0.loadoutsecondarystickers[2] = "_encstr_8BBA05185F8B99";
    var_0.loadoutsecondarystickers[3] = "_encstr_8BBA05185F8B99";
  } else {
    if(vehicle_collision(var_0.loadoutsecondary, var_0.loadoutsecondaryvariantid) || _encstr_877723A5E6EEAC2CE07BB99D85395AB09B1DB1DE73322D474BBD732C36D82F36DED8B52B32(var_0.loadoutsecondary, var_0.loadoutsecondaryvariantid))
      var_0.loadoutsecondaryvariantid = -1;

    for(var_6 = 0; var_6 < var_0.loadoutsecondaryattachments.size; var_6++) {
      var_7 = var_0.loadoutsecondaryattachments[var_6];
      var_8 = var_0.loadoutsecondaryattachmentids[var_6];

      if(turretparent(var_0.loadoutsecondary, var_0.loadoutsecondaryvariantid, var_7, var_8))
        var_0.loadoutsecondaryattachmentids[var_6] = 0;

      if(var_7 != "_encstr_8BBA05185F8B99" && (perkisrestricted(var_7, var_0.loadoutsecondary) || !vandalize(var_0.loadoutsecondary, var_7))) {
        var_0.loadoutsecondaryattachments[var_6] = "_encstr_8BBA05185F8B99";
        var_4 = 1;
      }
    }
  }

  var_12 = [];
  var_12[1] = 0;
  var_12[2] = 0;
  var_12[3] = 0;
  var_13 = [];
  var_13[0] = "_encstr_963D111F88AFE85B6F2253FA39630D3083FC4B";
  var_13[1] = "_encstr_A94E14B9E0B2D85A2C638E5EEB76AB59E44EA5361BC2";
  var_13[2] = "_encstr_9B4F1243D118EE9F8FC80BC3B6DCF7E2C853C9DC";
  var_14 = [];

  foreach(var_16 in var_0.loadoutperks) {
    if(!isDefined(level.perktable[var_16])) {
      continue;
    }
    var_17 = scripts\mp\perks\perks::getperkslot(var_16);

    if(isDefined(var_17))
      var_12[var_17]++;

    if(equipmentisrestricted(var_16)) {
      var_14[var_14.size] = var_16;
      var_3 = 1;
    }
  }

  foreach(var_16 in var_14) {
    var_17 = scripts\mp\perks\perks::getperkslot(var_16);

    if(isDefined(var_17))
      var_0.loadoutperks[var_17 - 1] = var_13[var_17 - 1];
  }

  if(var_12[1] != 1 || var_12[2] != 1 || var_12[3] != 1) {
    var_0.loadoutperks = [];
    var_0.loadoutperks[0] = var_13[0];
    var_0.loadoutperks[1] = var_13[1];
    var_0.loadoutperks[2] = var_13[2];
  }

  var_13 = [];
  var_13[0] = "_encstr_963D111F88AFE85B6F2253FA39630D3083FC4B";
  var_13[1] = "_encstr_A94E14B9E0B2D85A2C638E5EEB76AB59E44EA5361BC2";
  var_13[2] = "_encstr_9B4F1243D118EE9F8FC80BC3B6DCF7E2C853C9DC";
  var_13[3] = "_encstr_8E0E159E3A72E73079A3A8C8879308359A229530557B8F";
  var_13[4] = "_encstr_9A360EC74F39AA043E1D2333C71D30C3";
  var_13[5] = "_encstr_8882193783958D5A0BC64797D7CD362C6795379D56C9BEC1B1BAE6";
  var_21 = 0;
  var_22 = [];

  if(var_0.loadoutextraperks.size != 0) {
    foreach(var_25, var_16 in var_0.loadoutextraperks) {
      if(!isDefined(level.perktable[var_16])) {
        continue;
      }
      var_17 = scripts\mp\perks\perks::getperkslot(var_16);

      if(!isDefined(var_17)) {
        continue;
      }
      var_24 = var_16;

      while(equipmentisrestricted(var_24) || scripts\engine\utility::array_contains(var_0.loadoutperks, var_24) || scripts\engine\utility::array_contains(var_22, var_24)) {
        var_24 = var_13[var_21];
        var_21++;

        if(!isDefined(var_24)) {
          break;
        }
      }

      if(!isDefined(var_24)) {
        continue;
      }
      var_22[var_25] = var_24;

      if(equipmentisrestricted(var_16))
        var_3 = 1;
    }

    var_0.loadoutextraperks = var_22;

    if(var_0.loadoutextraperks.size != 3) {
      var_0.loadoutperks = [];
      var_0.loadoutperks[0] = var_13[0];
      var_0.loadoutperks[1] = var_13[1];
      var_0.loadoutperks[2] = var_13[2];
      var_0.loadoutextraperks = [];
      var_0.loadoutextraperks[0] = var_13[3];
      var_0.loadoutextraperks[1] = var_13[4];
      var_0.loadoutextraperks[2] = var_13[5];
    }
  }

  if(superisrestricted("_encstr_96AF127BC7026103B6E82B336B116240E3833979") || superisrestricted("_encstr_AAAF12036BFFD628063483AF34E1A8ADDBB21EA3") || superisrestricted("_encstr_81AF120B0297F6342960F003808FB803ED284F33"))
    var_0.loadoutusingspecialist = 0;

  var_26 = 0;

  if(!scripts\mp\equipment::isequipmentprimary(var_0.loadoutequipmentprimary) || !scripts\mp\equipment::unset_force_aitype_suicidebomber(var_0.loadoutequipmentprimary))
    var_26 = 1;
  else if(killstreakisrestricted(var_0.loadoutequipmentprimary)) {
    var_26 = 1;
    var_3 = 1;
  }

  if(var_26) {
    var_27 = getDvar("_encstr_A2BF1DB9C639AFEE59581CED37F5C9ACB91D4EB4368E2B23AF1BCAE834581B");

    if(var_27 == "_encstr_B40101")
      var_27 = "_encstr_8BBB0B9D41E718D9E922D8582A";

    var_0.loadoutequipmentprimary = var_27;
  }

  var_28 = 0;

  if(!scripts\mp\equipment::isequipmentsecondary(var_0.loadoutequipmentsecondary) || !scripts\mp\equipment::unset_force_aitype_suicidebomber(var_0.loadoutequipmentsecondary))
    var_28 = 1;
  else if(killstreakisrestricted(var_0.loadoutequipmentsecondary)) {
    var_28 = 1;
    var_3 = 1;
  }

  if(var_28) {
    var_29 = getDvar("_encstr_95051FE6C627BEBBAC0B38BD73BE39CAE68E4E4BD88E5632D7A3B0B1E8961BC21B");

    if(var_29 == "_encstr_B40101")
      var_29 = "_encstr_BD170C5B689B786221E98009A80C";

    var_0.loadoutequipmentsecondary = var_29;
  }

  var_30 = 0;
  var_31 = [];
  var_31[0] = "_encstr_A2E60C6BC099B7E1A0A93A398F48";
  var_31[1] = "_encstr_8C980A867B3B569CFAA659E8";
  var_31[2] = "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A";

  for(var_6 = 0; var_6 < 3; var_6++) {
    if(superisrestricted(var_31[var_6]))
      var_31[var_6] = "_encstr_8BBA05185F8B99";
  }

  if(var_0.loadoutkillstreak1 == "_encstr_8BBA05185F8B99" || var_0.loadoutkillstreak2 == "_encstr_8BBA05185F8B99" || var_0.loadoutkillstreak3 == "_encstr_8BBA05185F8B99")
    var_30 = 1;

  if(!var_30) {
    if(!isDefined(level.killstreakglobals.streaktable.tabledatabyref[var_0.loadoutkillstreak1]) || level.killstreakglobals.streaktable.tabledatabyref[var_0.loadoutkillstreak1]["_encstr_A60B0C5B60D8AFED315DC5F54508"] != "_encstr_A34C02BB")
      var_30 = 1;

    if(!isDefined(level.killstreakglobals.streaktable.tabledatabyref[var_0.loadoutkillstreak2]) || level.killstreakglobals.streaktable.tabledatabyref[var_0.loadoutkillstreak2]["_encstr_A60B0C5B60D8AFED315DC5F54508"] != "_encstr_A34C02BB")
      var_30 = 1;

    if(!isDefined(level.killstreakglobals.streaktable.tabledatabyref[var_0.loadoutkillstreak3]) || level.killstreakglobals.streaktable.tabledatabyref[var_0.loadoutkillstreak3]["_encstr_A60B0C5B60D8AFED315DC5F54508"] != "_encstr_A34C02BB")
      var_30 = 1;
  }

  if(!var_30) {
    if(superisrestricted(var_0.loadoutkillstreak1)) {
      var_0.loadoutkillstreak1 = var_31[0];
      var_3 = 1;
    }

    if(superisrestricted(var_0.loadoutkillstreak2)) {
      var_0.loadoutkillstreak2 = var_31[1];
      var_3 = 1;
    }

    if(superisrestricted(var_0.loadoutkillstreak3)) {
      var_0.loadoutkillstreak3 = var_31[2];
      var_3 = 1;
    }
  }

  if(!var_30) {
    if(var_0.loadoutkillstreak1 == var_0.loadoutkillstreak2)
      var_30 = 1;
    else if(var_0.loadoutkillstreak1 == var_0.loadoutkillstreak3)
      var_30 = 1;
    else if(var_0.loadoutkillstreak2 == var_0.loadoutkillstreak3)
      var_30 = 1;
  }

  if(!var_30) {
    if(isDefined(level.killstreakglobals.streaktable.tabledatabyref[var_0.loadoutkillstreak1]))
      var_32 = level.killstreakglobals.streaktable.tabledatabyref[var_0.loadoutkillstreak1]["_encstr_8E8D0697EB01F243"];
    else
      var_32 = 0;

    if(isDefined(level.killstreakglobals.streaktable.tabledatabyref[var_0.loadoutkillstreak2]))
      var_33 = level.killstreakglobals.streaktable.tabledatabyref[var_0.loadoutkillstreak2]["_encstr_8E8D0697EB01F243"];
    else
      var_33 = 0;

    if(isDefined(level.killstreakglobals.streaktable.tabledatabyref[var_0.loadoutkillstreak3]))
      var_34 = level.killstreakglobals.streaktable.tabledatabyref[var_0.loadoutkillstreak3]["_encstr_8E8D0697EB01F243"];
    else
      var_34 = 0;

    if(var_32 != 0 && var_32 == var_33)
      var_30 = 1;
    else if(var_32 != 0 && var_32 == var_34)
      var_30 = 1;
    else if(var_33 != 0 && var_33 == var_34)
      var_30 = 1;
  }

  if(var_30) {
    var_0.loadoutkillstreak1 = var_31[0];
    var_0.loadoutkillstreak2 = var_31[1];
    var_0.loadoutkillstreak3 = var_31[2];
  }

  return var_0;
}

validateweapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = scripts\mp\utility\weapon::getweaponrootname(var_1);
  var_9 = scripts\mp\utility\weapon::iscacsecondaryweapon(var_1);
  var_10 = scripts\engine\utility::ter_op(var_7, "_encstr_AC8F0AE74163F85AAA380AD8", "_encstr_BA7F0830B3A7859B60B0");
  var_11 = scripts\engine\utility::ter_op(var_7, 4, 1);

  if(isDefined(var_1) && var_1 != "_encstr_8BBA05185F8B99" && var_1 != "_encstr_A7ED0AD79F73990E28334B92") {
    var_0.pointcost++;

    if(var_7) {
      if(!var_9) {
        var_0.pointcost++;
        var_0.wildcards["_encstr_91AE093D2BC8926A63097B"] = 1;
      }
    } else if(var_9) {
      validationerror("_encstr_95A2136F88C9C74A790722986F3FE182D0609FE3F0", undefined, var_1);
      var_0.invaliditems[var_11] = 1;
    }

    var_12 = scripts\mp\utility\weapon::weaponnumbermap(var_8);

    if(!isDefined(var_12)) {
      validationerror("_encstr_9A350E307A447D4877DE1C0DA9133035", var_10, var_1);
      var_0.invaliditems[var_11] = 1;
    } else {
      var_13 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_12, 41);

      if(int(var_13) < 0) {
        validationerror("_encstr_8D0C11EB306E500C4597D390CBBFDFEBF8B073", var_10, var_1);
        var_0.invaliditems[var_11] = 1;
      }
    }

    if(!self isitemunlocked(var_8, "_encstr_AC20072B9FA9487832") && !weaponunlocksvialoot(var_8)) {
      validationerror("_encstr_99240DE8BD0B30DD32274B4B536A90", var_10, var_1);
      var_0.invaliditems[var_11] = 1;
    }

    if(var_5 == 0) {
      if(var_6 != -1) {
        validationerror("_encstr_B8F914D3AF1B25E861339990141431D3433753493F42", var_10, var_1);
        var_0.invaliditems[var_11] = 1;
      }
    } else if(var_6 == -1) {
      validationerror("_encstr_B8C91787CB374B71B1D16AB4C9A8A45095333F47A3D7132368", var_10, var_1);
      var_0.invaliditems[var_11] = 1;
    } else {
      if(!scripts\mp\loot::isweaponitem(var_5)) {
        validationerror("_encstr_BADC1420571A6F2D2703A245C9FF57E4ACA3905D6110", var_10, var_1);
        var_0.invaliditems[var_11] = 1;
      }

      var_14 = scripts\mp\loot::getlootweaponref(var_5);

      if(!isDefined(var_14)) {
        validationerror("_encstr_83B10E21361411C08A531B790F720B99", var_10, var_1);
        var_0.invaliditems[var_11] = 1;
      } else {
        var_15 = scripts\mp\loot::lookupvariantref(var_1, var_6);

        if(!isDefined(var_15)) {
          validationerror("_encstr_85B10EAE1910663A1EF39FABE1D6A28E", var_10, var_1);
          var_0.invaliditems[var_11] = 1;
        } else if(var_15 != var_14) {
          validationerror("_encstr_B89311B1EDDBE81116E816A69637DA16E86CD0", var_10, var_1);
          var_0.invaliditems[var_11] = 1;
        }
      }
    }

    validateattachments(var_0, var_2, var_1, var_8, var_10);
  }
}

validateattachments(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\utility\weapon::weapongroupmap(var_2);
  var_6 = getsubstr(var_5, 7) + "_encstr_A19A075135838FDED1";
  var_7 = scripts\engine\utility::ter_op(var_4 == "_encstr_BA7F0830B3A7859B60B0", 2, 5);
  var_8 = 0;
  var_9 = 0;
  var_10 = scripts\engine\utility::ter_op(var_4 == "_encstr_BA7F0830B3A7859B60B0", 2, 2);

  foreach(var_17, var_12 in var_1) {
    var_13 = 0;

    if(isDefined(var_12) && var_12 != "_encstr_8BBA05185F8B99") {
      var_14 = scripts\mp\utility\weapon::getattachmenttype(var_12);

      if(isDefined(var_14) && var_14 != "_encstr_B40101") {
        var_15 = scripts\mp\utility\weapon::attachmentmap_tounique(var_12, var_2);

        if(isDefined(var_15)) {
          if(var_14 == "_encstr_851F05E3C813A5")
            var_13 = 1;
        }
      }

      var_16 = var_3 + "_encstr_BE4C0295" + var_12;

      if(!self isitemunlocked(var_16, var_6)) {
        validationerror("_encstr_9AA1114408EEEF936D27DB54FF1A9A10ADF2DB", var_4, var_12);
        var_0.invaliditems[var_7][var_0.invaliditems[var_7].size] = var_17;
      }

      if(!scripts\mp\utility\weapon::carriedpunchcard(var_3, var_12)) {
        validationerror("_encstr_952A186885BAFFF93CDF5898B74A90DB10EBDD671E327B2116B3", var_4, var_12);
        var_0.invaliditems[var_7][var_0.invaliditems[var_7].size] = var_17;
      }

      if(var_13) {
        var_8++;
        var_0.pointcost++;
      } else {
        var_9++;

        if(var_9 <= var_10)
          var_0.pointcost++;
        else {
          var_0.wildcards[var_4 + "_encstr_AC750D492AE48BF12320D791A08B27" + (var_9 + 1)] = 1;
          var_0.pointcost = var_0.pointcost + 2;
        }
      }
    }
  }

  if(var_9 > 5) {
    validationerror("_encstr_B42A131B254031B3EE1B51BBF3207263A73D681BCB", var_4, var_9);
    var_0.invaliditems[scripts\engine\utility::ter_op(var_4 == "_encstr_BA7F0830B3A7859B60B0", 3, 6)] = 1;
  }

  if(var_8 > 1) {
    validationerror("_encstr_AC881803A83895CA3D5B3DEAC5DB2261A398CFD728D0F5425176", var_4, var_8);
    var_0.invaliditems[scripts\engine\utility::ter_op(var_4 == "_encstr_BA7F0830B3A7859B60B0", 3, 6)] = 1;
  }
}

validatepower(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::ter_op(var_2 == "_encstr_BA7F0830B3A7859B60B0", 7, 8);

  if(isDefined(var_1) && var_1 != "_encstr_8BBA05185F8B99") {
    if(!isDefined(level.powers[var_1])) {
      validationerror("_encstr_81A50D7DD55095AFACD021DADB8D83", var_2, var_1);
      var_0.invaliditems[var_4] = 1;
    }

    if(!self isitemunlocked(var_1, "_encstr_8B3506EB985CF71B")) {
      validationerror("_encstr_B1CA0CD99F7F9833E70170A84ABA", var_2, var_1);
      var_0.invaliditems[var_4] = 1;
    }

    var_5 = lookuppowerslot(var_1);

    if(!isDefined(var_5)) {
      validationerror("_encstr_B4F8116B5DA3B878A3637B234BAB2F68577773", var_2, var_1);
      var_0.invaliditems[var_4] = 1;
    } else if(var_5 != var_2) {
      validationerror("_encstr_A7BF11B3C85FF7638CA8CFE230B0EFB281307B", var_2, var_1);
      var_0.invaliditems[var_4] = 1;
    }

    var_0.pointcost++;
  }

  if(istrue(var_3)) {
    var_0.pointcost = var_0.pointcost + 2;
    var_6 = scripts\engine\utility::ter_op(var_2 == "_encstr_BA7F0830B3A7859B60B0", "_encstr_B2560D591E1D9C2C7D36AC3A1A58C6", "_encstr_9A790FACF0A39C16BED10BD8A3D2B1B063");
    var_0.wildcards[var_6] = 1;
  }
}

validateperks(var_0, var_1, var_2) {
  var_3 = [];
  var_3[1] = 0;
  var_3[2] = 0;
  var_3[3] = 0;

  foreach(var_5 in var_1) {
    if(isDefined(var_5) && var_5 != "_encstr_8BBA05185F8B99") {
      if(!isDefined(level.perktable[var_5])) {
        validationerror("_encstr_88480CB49BECC2B12D9114CA93B6", undefined, var_5);
        var_0.invaliditems[9][var_0.invaliditems[9].size] = var_5;
      }

      var_6 = scripts\mp\perks\perks::getperkslot(var_5);

      if(isDefined(var_6)) {
        var_3[var_6]++;

        if(var_3[var_6] > 2) {
          validationerror("_encstr_83CD0D1DF6B7351637E505959C6D6E", var_6, var_5);
          var_0.invaliditems[9][var_0.invaliditems[9].size] = var_5;
        }

        if(!self isitemunlocked(var_5, "_encstr_960D052F10EBF0")) {
          validationerror("_encstr_88B40B36DB6C6D568C41594EB6", var_6, var_5);
          var_0.invaliditems[9][var_0.invaliditems[9].size] = var_5;
        }

        if(var_3[var_6] == 1)
          var_0.pointcost++;
        else {
          var_0.wildcards["_encstr_92AF0CEFAB2B42095870671DB837" + var_6] = 1;
          var_0.pointcost = var_0.pointcost + 2;
        }
      } else if(isDefined(level.menurigperks[var_5])) {
        if(level.menurigperks[var_5].archetype != var_2) {
          validationerror("_encstr_8678126EB3A417F55BE0AFCDE45B20FD97DE707F", undefined, var_5);
          var_0.invaliditems[9][var_0.invaliditems[9].size] = var_5;
        }

        if(!self isitemunlocked(var_5, "_encstr_B1A606A3932C963A")) {
          validationerror("_encstr_87360E3DC8384B4A25B5AF9F595DC3B3", var_6, var_5);
          var_0.invaliditems[9][var_0.invaliditems[9].size] = var_5;
        }
      } else {
        validationerror("_encstr_BE021093CD90A6320465F33F4522C9F9F0C9", undefined, var_5);
        var_0.invaliditems[9][var_0.invaliditems[9].size] = var_5;
      }
    }
  }
}

validatestreaks(var_0, var_1, var_2, var_3) {
  var_4 = [var_1, var_2, var_3];

  foreach(var_6 in var_4) {
    if(var_6 == "_encstr_8BBA05185F8B99") {
      continue;
    }
    var_7 = scripts\mp\killstreaks\killstreaks::getkillstreaksetupinfo(var_6);

    if(!isDefined(var_7)) {
      validationerror("_encstr_A3010E43131A98C8CF25AF434A85E042", undefined, var_6);
      var_0.invaliditems[12] = 1;
    }

    if(!self isitemunlocked(var_6, "_encstr_85CE0B9770B02C73A1760F06D2")) {
      validationerror("_encstr_A1970D7CB861A75FC961B3CBC81B14", undefined, var_6);
      var_0.invaliditems[12] = 1;
    }
  }

  if(var_1 == var_2 && var_1 != "_encstr_8BBA05185F8B99") {
    validationerror("_encstr_A5C210016D0AB2B8A23BEB23B10B136B29FA", undefined, var_1);
    var_0.invaliditems[12] = 1;
  } else if(var_1 == var_3 && var_1 != "_encstr_8BBA05185F8B99") {
    validationerror("_encstr_A5C210016D0AB2B8A23BEB23B10B136B29FA", undefined, var_1);
    var_0.invaliditems[12] = 1;
  } else if(var_2 == var_3 && var_2 != "_encstr_8BBA05185F8B99") {
    validationerror("_encstr_A5C210016D0AB2B8A23BEB23B10B136B29FA", undefined, var_2);
    var_0.invaliditems[12] = 1;
  }
}

validatearchetype(var_0, var_1) {
  if(!isDefined(level.archetypeids[var_1])) {
    validationerror("_encstr_A32511C38AC750188336D3AD232C2B25F70359", undefined, var_1);
    var_0.invaliditems[10] = 1;
  }

  if(!self isitemunlocked(var_1, "_encstr_BA190482772F")) {
    validationerror("_encstr_83AF10E0B51328C53A876D573BF29570B88F", undefined, var_1);
    var_0.invaliditems[10] = 1;
  }
}

validatesuper(var_0, var_1, var_2) {
  if(!isDefined(var_1) || var_1 == "_encstr_8BBA05185F8B99") {
    return;
  }
  var_3 = level.superglobals.staticsuperdata[var_1];

  if(!isDefined(var_3)) {
    validationerror("_encstr_AB550D85A58AE5D84793B9B0D36DB3", undefined, var_1);
    var_0.invaliditems[11] = 1;
  } else if(var_3.archetype != var_2) {
    validationerror("_encstr_878D102703DFB292A1181B5A50C0CFB93B4F", undefined, var_1);
    var_0.invaliditems[11] = 1;
  }

  if(!self isitemunlocked(var_1, "_encstr_BEB406F03B72BB3B")) {
    validationerror("_encstr_96150C7A500E6F9FE877AD902360", undefined, var_1);
    var_0.invaliditems[11] = 1;
  }
}

validatewildcards(var_0) {}

fixloadout(var_0) {
  var_1 = scripts\mp\class::loadout_getclassstruct();
  var_1.loadoutarchetype = "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D";
  var_1.loadoutprimary = "_encstr_8C160DAFE71BF161681EB5BCB0F8FC";
  return var_1;
}

fixweapon(var_0, var_1) {
  if(var_1 == "_encstr_BA7F0830B3A7859B60B0") {
    var_0.loadoutprimary = "_encstr_8C160DAFE71BF161681EB5BCB0F8FC";
    var_0.loadoutprimarycamo = "_encstr_8BBA05185F8B99";
    var_0.loadoutprimaryreticle = "_encstr_8BBA05185F8B99";
    var_0.loadoutprimarylootitemid = 0;
    var_0.loadoutprimaryvariantid = -1;

    for(var_2 = 0; var_2 < scripts\mp\class::getmaxprimaryattachments(); var_2++)
      var_0.loadoutprimaryattachments[var_2] = "_encstr_8BBA05185F8B99";
  } else {
    var_0.loadoutsecondary = "_encstr_8BBA05185F8B99";
    var_0.loadoutsecondarycamo = "_encstr_8BBA05185F8B99";
    var_0.loadoutsecondaryreticle = "_encstr_8BBA05185F8B99";
    var_0.loadoutsecondarylootitemid = 0;
    var_0.loadoutsecondaryvariantid = -1;

    for(var_2 = 0; var_2 < scripts\mp\class::getmaxsecondaryattachments(); var_2++)
      var_0.loadoutsecondaryattachments[var_2] = "_encstr_8BBA05185F8B99";
  }
}

fixattachment(var_0, var_1, var_2) {
  if(var_1 == "_encstr_BA7F0830B3A7859B60B0")
    var_0.loadoutprimaryattachments[var_2] = "_encstr_8BBA05185F8B99";
  else
    var_0.loadoutsecondaryattachments[var_2] = "_encstr_8BBA05185F8B99";
}

fixpower(var_0, var_1) {
  if(var_1 == "_encstr_BA7F0830B3A7859B60B0") {
    var_0.loadoutpowerprimary = "_encstr_8BBA05185F8B99";
    var_0.loadoutextrapowerprimary = 0;
  } else {
    var_0.loadoutpowersecondary = "_encstr_8BBA05185F8B99";
    var_0.loadoutextrapowersecondary = 0;
  }
}

fixperk(var_0, var_1) {
  var_0.loadoutperks = scripts\engine\utility::array_remove(var_0.loadoutperks, var_1);
}

fixkillstreaks(var_0) {
  var_0.loadoutkillstreak1 = "_encstr_8BBA05185F8B99";
  var_0.loadoutkillstreak2 = "_encstr_8BBA05185F8B99";
  var_0.loadoutkillstreak3 = "_encstr_8BBA05185F8B99";
}

fixarchetype(var_0) {
  var_0.loadoutarchetype = "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D";
  fixsuper(var_0);

  foreach(var_2 in var_0.loadoutperks) {
    if(isDefined(level.menurigperks[var_2])) {
      fixperk(var_0, var_2);
      break;
    }
  }
}

fixsuper(var_0) {
  var_0.loadoutsuper = "_encstr_8BBA05185F8B99";
}

fixinvaliditems(var_0, var_1) {
  if(isDefined(var_1[0])) {
    var_0 = fixloadout(var_0);
    return var_0;
  }

  if(isDefined(var_1[1]))
    fixweapon(var_0, "_encstr_BA7F0830B3A7859B60B0");
  else if(isDefined(var_1[3])) {
    for(var_2 = 0; var_2 < scripts\mp\class::getmaxprimaryattachments(); var_2++)
      fixattachment(var_0, "_encstr_BA7F0830B3A7859B60B0", var_2);
  } else {
    foreach(var_2 in var_1[2])
    fixattachment(var_0, "_encstr_BA7F0830B3A7859B60B0", var_2);
  }

  if(isDefined(var_1[4]))
    fixweapon(var_0, "_encstr_AC8F0AE74163F85AAA380AD8");
  else if(isDefined(var_1[6])) {
    for(var_2 = 0; var_2 < scripts\mp\class::getmaxsecondaryattachments(); var_2++)
      fixattachment(var_0, "_encstr_AC8F0AE74163F85AAA380AD8", var_2);
  } else {
    foreach(var_2 in var_1[5])
    fixattachment(var_0, "_encstr_AC8F0AE74163F85AAA380AD8", var_2);
  }

  if(isDefined(var_1[7]))
    fixpower(var_0, "_encstr_BA7F0830B3A7859B60B0");

  if(isDefined(var_1[8]))
    fixpower(var_0, "_encstr_AC8F0AE74163F85AAA380AD8");

  foreach(var_8 in var_1[9])
  fixperk(var_0, var_8);

  if(isDefined(var_1[10]))
    fixarchetype(var_0);
  else if(isDefined(var_1[11]))
    fixarchetype(var_0);

  if(isDefined(var_1[12]))
    fixkillstreaks(var_0);

  return var_0;
}

lookuppowerslot(var_0) {
  var_1 = tablelookup("_encstr_8B9512DDBFD75AF55830E3170811BAE3BD5E2293", 3, var_0, 2);

  if(!isDefined(var_1) || var_1 != "_encstr_A34C02BB" && var_1 != "_encstr_A74C0222")
    return undefined;

  return scripts\engine\utility::ter_op(var_1 == "_encstr_A34C02BB", "_encstr_BA7F0830B3A7859B60B0", "_encstr_AC8F0AE74163F85AAA380AD8");
}

weaponunlocksvialoot(var_0) {
  return 0;
}

vehicle_checktrailvfx(var_0) {
  return isDefined(level.weaponmapdata[var_0]) && istrue(level.weaponmapdata[var_0]._id_13EFC);
}

vehicle_collision(var_0, var_1) {
  if(scripts\mp\utility\game::isanymlgmatch())
    return 1;

  if(!isDefined(var_1) || var_1 <= 0)
    return 0;

  var_2 = var_0 + "_encstr_854C021F" + var_1;
  return isDefined(level.weaponlootmapdata[var_2]) && istrue(level.weaponlootmapdata[var_2].update_focus_fire_objective);
}

turretparent(var_0, var_1, var_2, var_3) {
  if(scripts\mp\utility\game::isanymlgmatch())
    return 1;

  var_4 = isDefined(var_3) && var_3 > 0 && var_2 != "_encstr_8BBA05185F8B99";

  if(!var_4)
    return 0;

  var_5 = getdvarint("_encstr_8ECF1C63506D78FF4C891B969C47AB730D209FE8498F3F95A8066EC9186B", 1);
  var_6 = isDefined(var_1) && var_1 > 0;

  if(!var_5 && !var_6)
    return 1;

  var_7 = var_0 + "_encstr_854C021F" + var_1;
  var_8 = 0;
  var_9 = 1;

  for(;;) {
    var_10 = var_0 + "_encstr_854C021F" + var_9;

    if(!isDefined(level.weaponlootmapdata[var_10])) {
      break;
    }

    if(var_5 || var_10 == var_7) {
      if(!level.weaponlootmapdata[var_10].update_focus_fire_objective) {
        if(isDefined(level.weaponlootmapdata[var_10].attachcustomtoidmap)) {
          foreach(var_13, var_12 in level.weaponlootmapdata[var_10].attachcustomtoidmap) {
            if(var_3 == var_12 && var_2 == var_13) {
              var_8 = 1;
              break;
            }
          }
        }

        if(var_8) {
          break;
        }
      }
    }

    var_9++;
  }

  return !var_8;
}