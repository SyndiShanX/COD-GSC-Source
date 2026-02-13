/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2085.gsc
*************************************************/

_id_FF5D(var_0, var_1, var_2) {
  var_3 = var_0;

  if(isDefined(var_1)) {
    var_3 = var_3 + "_" + var_1;
  }

  if(isDefined(var_2)) {
    var_3 = var_3 + " - " + var_2;
  }

  if(getdvarint("#x32159f86a152106b3", 0) == 1) {}

  if(getdvarint("#x37387cb9724b68856", 0) == 1) {}

  if(getdvarint("#x37ef6519734e8e9f1", 0) == 1) {
    scripts\mp\class::_id_C151();
  }
}

_id_8ADD(var_0, var_1) {
  var_2 = getdvarint("#x32fabf9b0576c3e2", 0) == 1;

  if(var_2) {
    return scripts\mp\utility\weapon::_id_1D9C(var_0, var_1);
  }

  return 1;
}

_id_8B16(var_0, var_1) {
  var_2 = 0;

  if(getdvarint("#x391583f1a45eeccda", 1) == 1) {
    return 0;
  } else {
    if(!isDefined(level._id_1D91)) {
      level._id_1D91 = [];
      var_3 = _func_0225("mp/attachmentmap.csv");

      for(var_4 = 1; var_4 < var_3; var_4++) {
        var_5 = tablelookupbyrow("mp/attachmentmap.csv", 0, var_4);
        level._id_1D91[var_5] = var_4;
      }
    }

    var_6 = level._id_1D91[var_1];

    if(!isDefined(var_6)) {
      return 0;
    }

    var_7 = _func_0222("mp/attachmentmap.csv", 0, var_0, var_6);

    if(var_7 == "") {
      var_8 = _func_0222("mp/statstable.csv", 4, var_0, 1);
      var_7 = _func_0222("mp/attachmentmap.csv", 0, var_8, var_6);
    }

    if(var_7 == "") {
      var_7 = var_1;
    }

    if(var_7 != "") {
      var_2 = int(_func_0222("mp/attachmenttable.csv", 4, var_7, 31));
    }
  }

  return var_2 == 1;
}

_id_FF4B(var_0) {
  var_1 = scripts\mp\utility\weapon::_id_10DB4(var_0._id_9683);
  var_2 = 0;

  if(!isDefined(var_1)) {
    var_2 = 1;
  } else if(_id_8B0E(var_0._id_9683)) {
    var_2 = 1;
  } else if(_id_8B10(var_0._id_9683)) {
    var_2 = 1;
  } else if(isweaponbanned(var_0._id_9683, var_0._id_9689)) {
    var_2 = 1;
  }

  if(!scripts\mp\utility\weapon::_id_879A(var_0._id_9683)) {
    var_2 = 1;
  }

  var_3 = scripts\mp\class::loadout_buildloadoutprimaryobject(var_0);
  var_4 = getcompleteweaponname(var_3);
  var_5 = makeweaponfromstring(var_4);

  if(isDefined(var_5)) {
    var_6 = getcompleteweaponname(var_5);

    if(var_4 != var_6) {
      var_2 = 1;
    }
  } else
    var_2 = 1;

  var_7 = 0;
  var_8 = 0;

  if(_func_0417(var_0._id_9683)) {
    var_2 = 1;
    var_7 = 1;
  }

  if(var_2) {
    var_0._id_9683 = "s4_ar_stango44";
    var_0._id_9685 = [];
    var_0._id_9686 = "none";
    var_0._id_968C = "none";
    var_0._id_968E = -1;
    var_0._id_9684 = [];
    var_0._id_9687 = "none";
    var_0._id_968D[0] = "none";
    var_0._id_968D[1] = "none";
    var_0._id_968D[2] = "none";
    var_0._id_968D[3] = "none";

    if(_id_8B10(var_0._id_9683)) {
      var_0._id_9683 = "s4_me_fists";
    }
  } else {
    if(_id_8B0F(var_0._id_9683, var_0._id_968E)) {
      var_0._id_968E = -1;
    }

    var_9 = [];

    for(var_10 = 0; var_10 < var_0._id_9685.size; var_10++) {
      var_11 = var_0._id_9685[var_10];
      var_12 = var_0._id_9684[var_10];

      if(_id_876F(var_0._id_9683, var_11, var_12)) {
        var_0._id_9684[var_10] = 0;
      }

      var_13 = !(self _meth_878F() && getdvarint("#x315cfcaa3e774ac5c", 1) == 1);
      var_14 = scripts\mp\utility\weapon::_id_1DA7(var_11);
      var_15 = undefined;

      if(isDefined(var_14)) {
        var_15 = scripts\engine\utility::_id_1BAB(var_9, var_14);
      }

      if(isDefined(var_15) && var_11 != "none" && var_14 != "gunperk") {
        var_0._id_9685[var_10] = "none";
        var_0._id_9685[var_15] = "none";
        var_8 = 1;
      }

      var_9[var_10] = var_14;

      if(var_11 != "none" && (_func_0418(var_11, var_0._id_9683, var_13) || !_id_8ADD(var_0._id_9683, var_11) || _id_8B16(var_0._id_9683, var_11) || isattachmentbanned(var_0._id_9683, var_11))) {
        var_0._id_9685[var_10] = "none";
        var_8 = 1;
      }
    }
  }

  var_1 = scripts\mp\utility\weapon::_id_10DB4(var_0._id_9692);
  var_2 = 0;

  if(!isDefined(var_1)) {
    var_2 = 1;
  } else if(_id_8B0E(var_0._id_9692)) {
    var_2 = 1;
  } else if(_id_8B10(var_0._id_9692)) {
    var_2 = 1;
  } else if(isweaponbanned(var_0._id_9692, var_0._id_9698)) {
    var_2 = 1;
  }

  var_16 = scripts\mp\class::loadout_buildloadoutsecondaryobject(var_0);
  var_17 = getcompleteweaponname(var_16);
  var_18 = makeweaponfromstring(var_17);

  if(isDefined(var_18)) {
    var_6 = getcompleteweaponname(var_18);

    if(var_17 != var_6) {
      var_2 = 1;
    }
  } else
    var_2 = 1;

  var_19 = "specialty_munitions_2";
  var_20 = !_func_0419(var_19) && scripts\engine\utility::array_contains(var_0._id_967F, var_19);

  if(scripts\mp\utility\weapon::_id_879A(var_0._id_9692) && !var_20) {
    var_2 = 1;
  }

  if(_func_0417(var_0._id_9692)) {
    var_2 = 1;
    var_7 = 1;
  }

  if(var_2) {
    var_0._id_9692 = "s4_pi_mike1911";
    var_0._id_9694 = [];
    var_0._id_9695 = "none";
    var_0._id_969A = "none";
    var_0._id_969C = -1;
    var_0._id_9693 = [];
    var_0._id_9696 = "none";
    var_0._id_969B[0] = "none";
    var_0._id_969B[1] = "none";
    var_0._id_969B[2] = "none";
    var_0._id_969B[3] = "none";

    if(_id_8B10(var_0._id_9692)) {
      var_0._id_9692 = "s4_me_fists";
    }
  } else {
    if(_id_8B0F(var_0._id_9692, var_0._id_969C)) {
      var_0._id_969C = -1;
    }

    var_9 = [];

    for(var_10 = 0; var_10 < var_0._id_9694.size; var_10++) {
      var_11 = var_0._id_9694[var_10];
      var_12 = var_0._id_9693[var_10];

      if(_id_876F(var_0._id_9692, var_11, var_12)) {
        var_0._id_9693[var_10] = 0;
      }

      var_14 = scripts\mp\utility\weapon::_id_1DA7(var_11);
      var_15 = undefined;

      if(isDefined(var_14)) {
        var_15 = scripts\engine\utility::_id_1BAB(var_9, var_14);
      }

      if(isDefined(var_15) && var_11 != "none" && var_14 != "gunperk") {
        var_0._id_9685[var_10] = "none";
        var_0._id_9685[var_15] = "none";
        var_8 = 1;
      }

      var_9[var_10] = var_14;

      if(var_11 != "none" && (_func_0418(var_11, var_0._id_9692) || !_id_8ADD(var_0._id_9692, var_11) || _id_8B16(var_0._id_9692, var_11) || isattachmentbanned(var_0._id_9692, var_11))) {
        var_0._id_9694[var_10] = "none";
        var_8 = 1;
      }
    }
  }

  var_21 = [];
  var_21[1] = 0;
  var_21[2] = 0;
  var_21[3] = 0;
  var_22 = [];
  var_22[0] = "specialty_vanguard";
  var_22[1] = "specialty_asdic";
  var_22[2] = "specialty_hustle";
  var_23 = [];

  foreach(var_27, var_25 in var_0._id_967F) {
    if(!isDefined(level._id_AFFD[var_25])) {
      continue;
    }
    var_26 = scripts\mp\perks\perks::_id_6C27(var_25);

    if(isDefined(var_26)) {
      if(var_27 != var_26 - 1) {
        var_0._id_967F[var_27] = var_22[var_27];
      }

      var_21[var_26]++;
    }

    if(_func_0419(var_25) || isperkbanned(var_25)) {
      var_23[var_23.size] = var_25;
      var_7 = 1;
    }
  }

  foreach(var_25 in var_23) {
    var_26 = scripts\mp\perks\perks::_id_6C27(var_25);

    if(isDefined(var_26)) {
      var_0._id_967F[var_26 - 1] = var_22[var_26 - 1];
    }
  }

  if(var_21[1] != 1 || var_21[2] != 1 || var_21[3] != 1) {
    var_0._id_967F = [];
    var_0._id_967F[0] = var_22[0];
    var_0._id_967F[1] = var_22[1];
    var_0._id_967F[2] = var_22[2];
  }

  var_22 = [];
  var_22[0] = "specialty_hustle";
  var_22[1] = "specialty_guerrilla";
  var_22[2] = "specialty_warhead";
  var_22[3] = "specialty_covert_ops";
  var_22[4] = "specialty_eod";
  var_22[5] = "specialty_scavenger_plus";
  var_30 = 0;
  var_31 = [];

  if(var_0._id_9670.size != 0) {
    foreach(var_34, var_25 in var_0._id_9670) {
      if(!isDefined(level._id_AFFD[var_25])) {
        continue;
      }
      var_26 = scripts\mp\perks\perks::_id_6C27(var_25);

      if(!isDefined(var_26)) {
        continue;
      }
      var_33 = var_25;

      while(_func_0419(var_33) || scripts\engine\utility::array_contains(var_0._id_967F, var_33) || scripts\engine\utility::array_contains(var_31, var_33)) {
        var_33 = var_22[var_30];
        var_30++;

        if(!isDefined(var_33)) {
          break;
        }
      }

      if(!isDefined(var_33)) {
        continue;
      }
      var_31[var_34] = var_33;

      if(_func_0419(var_25)) {
        var_7 = 1;
      }
    }

    var_0._id_9670 = var_31;

    if(var_0._id_9670.size != 3) {
      var_0._id_967F = [];
      var_0._id_967F[0] = var_22[0];
      var_0._id_967F[1] = var_22[1];
      var_0._id_967F[2] = var_22[2];
      var_0._id_9670 = [];
      var_0._id_9670[0] = var_22[3];
      var_0._id_9670[1] = var_22[4];
      var_0._id_9670[2] = var_22[5];
    }
  }

  if(getdvarint("#x391583f1a45eeccda", 1) != 1) {
    foreach(var_25 in var_0._id_967F) {
      if(isDefined(level._id_9DD3[var_25]) && istrue(level._id_9DD3[var_25]._id_8B15)) {
        var_26 = scripts\mp\perks\perks::_id_6C27(var_25);

        if(!isDefined(var_26)) {
          continue;
        }
        var_0._id_967F[var_26 - 1] = "specialty_null";
      }
    }

    foreach(var_38 in var_0._id_9670) {
      if(isDefined(level._id_9DD3[var_38]) && istrue(level._id_9DD3[var_38]._id_8B15)) {
        var_26 = scripts\mp\perks\perks::_id_6C27(var_38);

        if(!isDefined(var_26)) {
          continue;
        }
        var_0._id_9670[var_26 - 1] = "specialty_null";
      }
    }
  }

  foreach(var_25 in var_0._id_967F) {
    if(isitembanned(var_25, 9)) {
      var_26 = scripts\mp\perks\perks::_id_6C27(var_25);

      if(!isDefined(var_26)) {
        continue;
      }
      var_0._id_967F[var_26 - 1] = "specialty_null";
    }
  }

  foreach(var_38 in var_0._id_9670) {
    if(isitembanned(var_38, 9)) {
      var_26 = scripts\mp\perks\perks::_id_6C27(var_38);

      if(!isDefined(var_26)) {
        continue;
      }
      var_0._id_9670[var_26 - 1] = "specialty_null";
    }
  }

  if(_func_041B("specialist_perk_1") || _func_041B("specialist_perk_2") || _func_041B("specialist_perk_3")) {
    var_0._id_96A3 = 0;
  }

  if(!scripts\mp\equipment::_id_8837(var_0._id_966A) || !scripts\mp\equipment::_id_8839(var_0._id_966A) || isitembanned(var_0._id_966A, 13)) {
    var_0._id_966A = "equip_frag";
  } else if(_func_041A(var_0._id_966A)) {
    var_0._id_966A = "equip_frag";
    var_7 = 1;
  }

  if(!scripts\mp\equipment::_id_8838(var_0._id_966B) || !scripts\mp\equipment::_id_8839(var_0._id_966B) || isitembanned(var_0._id_966B, 13)) {
    var_0._id_966B = "equip_concussion";
  } else if(_func_041A(var_0._id_966B)) {
    var_0._id_966B = "equip_concussion";
    var_7 = 1;
  }

  if(getdvarint("#x391583f1a45eeccda", 1) != 1) {
    if(scripts\mp\equipment::_id_883C(var_0._id_966A)) {
      var_0._id_966A = "none";
    }

    if(scripts\mp\equipment::_id_883C(var_0._id_966B)) {
      var_0._id_966B = "none";
    }
  }

  var_44 = weaponclass(var_0._id_9683 + "_mp");

  if(scripts\mp\utility\perk::_hasperk("specialty_van_demolition_mg") && weaponclass(var_0._id_9683 + "_mp") == "mg") {
    switch (var_0._id_966A) {
      case "equip_mills_grenade":
      case "equip_m24_grenade":
      case "equip_gammon_bomb":
      case "equip_frag":
        var_0._id_966A = "equip_bundle_charge";
        break;
    }
  }

  var_45 = 0;
  var_46 = [];
  var_46[0] = "intel";
  var_46[1] = "glide_bomb";
  var_46[2] = "juggernaut";

  if(scripts\mp\utility\game::isanymlgmatch()) {
    var_46[0] = "precision_airstrike";
    var_46[1] = "glide_bomb";
    var_46[2] = "none";
  }

  for(var_10 = 0; var_10 < 3; var_10++) {
    if(_func_041B(var_46[var_10])) {
      var_46[var_10] = "none";
    }
  }

  if(var_0._id_9679 == "none" || var_0._id_967A == "none" || var_0._id_967B == "none") {
    var_45 = 1;
  }

  if(!var_45) {
    if(!isDefined(level._id_8DD5._id_EA18._id_EC74[var_0._id_9679]) || level._id_8DD5._id_EA18._id_EC74[var_0._id_9679]["shownInMenu"] != "1") {
      var_45 = 1;
    }

    if(!isDefined(level._id_8DD5._id_EA18._id_EC74[var_0._id_967A]) || level._id_8DD5._id_EA18._id_EC74[var_0._id_967A]["shownInMenu"] != "1") {
      var_45 = 1;
    }

    if(!isDefined(level._id_8DD5._id_EA18._id_EC74[var_0._id_967B]) || level._id_8DD5._id_EA18._id_EC74[var_0._id_967B]["shownInMenu"] != "1") {
      var_45 = 1;
    }
  }

  if(!var_45) {
    if(_func_041B(var_0._id_9679)) {
      var_0._id_9679 = var_46[0];
      var_7 = 1;
    }

    if(_func_041B(var_0._id_967A)) {
      var_0._id_967A = var_46[1];
      var_7 = 1;
    }

    if(_func_041B(var_0._id_967B)) {
      var_0._id_967B = var_46[2];
      var_7 = 1;
    }
  }

  if(!var_45) {
    if(var_0._id_9679 == var_0._id_967A && var_0._id_9679 != "none") {
      var_45 = 1;
    } else if(var_0._id_9679 == var_0._id_967B && var_0._id_9679 != "none") {
      var_45 = 1;
    } else if(var_0._id_967A == var_0._id_967B && var_0._id_967A != "none") {
      var_45 = 1;
    }
  }

  if(!var_45) {
    if(isDefined(level._id_8DD5._id_EA18._id_EC74[var_0._id_9679])) {
      var_47 = level._id_8DD5._id_EA18._id_EC74[var_0._id_9679]["kills"];
    } else {
      var_47 = 0;
    }

    if(isDefined(level._id_8DD5._id_EA18._id_EC74[var_0._id_967A])) {
      var_48 = level._id_8DD5._id_EA18._id_EC74[var_0._id_967A]["kills"];
    } else {
      var_48 = 0;
    }

    if(isDefined(level._id_8DD5._id_EA18._id_EC74[var_0._id_967B])) {
      var_49 = level._id_8DD5._id_EA18._id_EC74[var_0._id_967B]["kills"];
    } else {
      var_49 = 0;
    }

    if(var_47 != 0 && var_47 == var_48) {
      var_45 = 1;
    } else if(var_47 != 0 && var_47 == var_49) {
      var_45 = 1;
    } else if(var_48 != 0 && var_48 == var_49) {
      var_45 = 1;
    }
  }

  if(var_45) {
    var_0._id_9679 = var_46[0];
    var_0._id_967A = var_46[1];
    var_0._id_967B = var_46[2];
  }

  if(isitembanned(var_0._id_9679, 12)) {
    var_0._id_9679 = "none";
  }

  if(isitembanned(var_0._id_967A, 12)) {
    var_0._id_967A = "none";
  }

  if(isitembanned(var_0._id_967B, 12)) {
    var_0._id_967B = "none";
  }

  if(getdvarint("#x391583f1a45eeccda", 1) != 1) {
    if(!isDefined(level._id_8DD5._id_EA18._id_EC74[var_0._id_9679]) || level._id_8DD5._id_EA18._id_EC74[var_0._id_9679]["workInProgress"] == "1") {
      var_0._id_9679 = "none";
    }

    if(!isDefined(level._id_8DD5._id_EA18._id_EC74[var_0._id_967A]) || level._id_8DD5._id_EA18._id_EC74[var_0._id_967A]["workInProgress"] == "1") {
      var_0._id_967A = "none";
    }

    if(!isDefined(level._id_8DD5._id_EA18._id_EC74[var_0._id_967B]) || level._id_8DD5._id_EA18._id_EC74[var_0._id_967B]["workInProgress"] == "1") {
      var_0._id_967B = "none";
    }
  }

  return var_0;
}

_id_FF5B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = scripts\mp\utility\weapon::getweaponrootname(var_1);
  var_9 = scripts\mp\utility\weapon::_id_879C(var_1);
  var_10 = scripts\engine\utility::ter_op(var_7, "secondary", "primary");
  var_11 = scripts\engine\utility::ter_op(var_7, 4, 1);

  if(isDefined(var_1) && var_1 != "none" && var_1 != "s4_me_fists") {
    var_0._id_B9B5++;

    if(var_7) {
      if(!var_9) {
        var_0._id_B9B5++;
        var_0._id_10E1E["overkill"] = 1;
      }
    } else if(var_9) {
      _id_FF5D("secondaryAsPrimary", undefined, var_1);
      var_0._id_84FA[var_11] = 1;
    }

    var_12 = scripts\mp\utility\weapon::_id_10DB4(var_8);

    if(!isDefined(var_12)) {
      _id_FF5D("unknownWeapon", var_10, var_1);
      var_0._id_84FA[var_11] = 1;
    } else {
      var_13 = _func_0222("mp/statstable.csv", 0, var_12, 41);

      if(int(var_13) < 0) {
        _id_FF5D("unreleasedWeapon", var_10, var_1);
        var_0._id_84FA[var_11] = 1;
      }
    }

    if(!self _meth_81C8(var_8, "weapon") && !_id_10DE8(var_8)) {
      _id_FF5D("lockedWeapon", var_10, var_1);
      var_0._id_84FA[var_11] = 1;
    }

    if(var_5 == 0) {
      if(var_6 != -1) {
        _id_FF5D("emptyItemIDMismatch", var_10, var_1);
        var_0._id_84FA[var_11] = 1;
      }
    } else if(var_6 == -1) {
      _id_FF5D("emptyVariantIDMismatch", var_10, var_1);
      var_0._id_84FA[var_11] = 1;
    } else {
      if(!_id_07ED::_id_8B08(var_5)) {
        _id_FF5D("nonWeaponLootItemID", var_10, var_1);
        var_0._id_84FA[var_11] = 1;
      }

      var_14 = _id_07ED::_id_6B25(var_5);

      if(!isDefined(var_14)) {
        _id_FF5D("badLootItemID", var_10, var_1);
        var_0._id_84FA[var_11] = 1;
      } else {
        var_15 = _id_07ED::_id_981C(var_1, var_6);

        if(!isDefined(var_15)) {
          _id_FF5D("badVariantRef", var_10, var_1);
          var_0._id_84FA[var_11] = 1;
        } else if(var_15 != var_14) {
          _id_FF5D("lootDataMismatch", var_10, var_1);
          var_0._id_84FA[var_11] = 1;
        }
      }
    }

    _id_FF44(var_0, var_2, var_1, var_8, var_10);
  }
}

_id_FF44(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\utility\weapon::_id_10D99(var_2);
  var_6 = _func_00D6(var_5, 7) + "Attach";
  var_7 = scripts\engine\utility::ter_op(var_4 == "primary", 2, 5);
  var_8 = 0;
  var_9 = 0;
  var_10 = scripts\engine\utility::ter_op(var_4 == "primary", 2, 2);

  foreach(var_17, var_12 in var_1) {
    var_13 = 0;

    if(isDefined(var_12) && var_12 != "none") {
      var_14 = scripts\mp\utility\weapon::_id_68E5(var_12);

      if(isDefined(var_14) && var_14 != "") {
        var_15 = scripts\mp\utility\weapon::_id_1DA9(var_12, var_2);

        if(isDefined(var_15)) {
          if(var_14 == "rail") {
            var_13 = 1;
          }
        }
      }

      var_16 = var_3 + "+" + var_12;

      if(!self _meth_81C8(var_16, var_6)) {
        _id_FF5D("lockedAttachment", var_4, var_12);
        var_0._id_84FA[var_7][var_0._id_84FA[var_7].size] = var_17;
      }

      if(!scripts\mp\utility\weapon::_id_1D9B(var_3, var_12)) {
        _id_FF5D("nonSelectableAttachment", var_4, var_12);
        var_0._id_84FA[var_7][var_0._id_84FA[var_7].size] = var_17;
      }

      if(var_13) {
        var_8++;
        var_0._id_B9B5++;
      } else {
        var_9++;

        if(var_9 <= var_10) {
          var_0._id_B9B5++;
        } else {
          var_0._id_10E1E[var_4 + "_attachment_" + (var_9 + 1)] = 1;
          var_0._id_B9B5 = var_0._id_B9B5 + 2;
        }
      }
    }
  }

  if(var_9 > 5) {
    _id_FF5D("tooManyAttachments", var_4, var_9);
    var_0._id_84FA[scripts\engine\utility::ter_op(var_4 == "primary", 3, 6)] = 1;
  }

  if(var_8 > 1) {
    _id_FF5D("tooManyOpticAttachments", var_4, var_8);
    var_0._id_84FA[scripts\engine\utility::ter_op(var_4 == "primary", 3, 6)] = 1;
  }
}

_id_FF54(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::ter_op(var_2 == "primary", 7, 8);

  if(isDefined(var_1) && var_1 != "none") {
    if(!isDefined(level._id_BADE[var_1])) {
      _id_FF5D("unknownPower", var_2, var_1);
      var_0._id_84FA[var_4] = 1;
    }

    if(!self _meth_81C8(var_1, "power")) {
      _id_FF5D("lockedPower", var_2, var_1);
      var_0._id_84FA[var_4] = 1;
    }

    var_5 = _id_981B(var_1);

    if(!isDefined(var_5)) {
      _id_FF5D("unknownMenuPower", var_2, var_1);
      var_0._id_84FA[var_4] = 1;
    } else if(var_5 != var_2) {
      _id_FF5D("powerInWrongSlot", var_2, var_1);
      var_0._id_84FA[var_4] = 1;
    }

    var_0._id_B9B5++;
  }

  if(istrue(var_3)) {
    var_0._id_B9B5 = var_0._id_B9B5 + 2;
    var_6 = scripts\engine\utility::ter_op(var_2 == "primary", "extra_lethal", "extra_tactical");
    var_0._id_10E1E[var_6] = 1;
  }
}

_id_FF51(var_0, var_1, var_2) {
  var_3 = [];
  var_3[1] = 0;
  var_3[2] = 0;
  var_3[3] = 0;

  foreach(var_5 in var_1) {
    if(isDefined(var_5) && var_5 != "none") {
      if(!isDefined(level._id_AFFD[var_5])) {
        _id_FF5D("invalidPerk", undefined, var_5);
        var_0._id_84FA[9][var_0._id_84FA[9].size] = var_5;
      }

      var_6 = scripts\mp\perks\perks::_id_6C27(var_5);

      if(isDefined(var_6)) {
        var_3[var_6]++;

        if(var_3[var_6] > 2) {
          _id_FF5D("tooManyPerks", var_6, var_5);
          var_0._id_84FA[9][var_0._id_84FA[9].size] = var_5;
        }

        if(!self _meth_81C8(var_5, "perk")) {
          _id_FF5D("lockedPerk", var_6, var_5);
          var_0._id_84FA[9][var_0._id_84FA[9].size] = var_5;
        }

        if(var_3[var_6] == 1) {
          var_0._id_B9B5++;
        } else {
          var_0._id_10E1E["extra_perk_" + var_6] = 1;
          var_0._id_B9B5 = var_0._id_B9B5 + 2;
        }
      } else if(isDefined(level._id_9DD5[var_5])) {
        if(level._id_9DD5[var_5]._id_1A35 != var_2) {
          _id_FF5D("rigPerkOnWrongRig", undefined, var_5);
          var_0._id_84FA[9][var_0._id_84FA[9].size] = var_5;
        }

        if(!self _meth_81C8(var_5, "trait")) {
          _id_FF5D("lockedRigPerk", var_6, var_5);
          var_0._id_84FA[9][var_0._id_84FA[9].size] = var_5;
        }
      } else {
        _id_FF5D("unknownPerkType", undefined, var_5);
        var_0._id_84FA[9][var_0._id_84FA[9].size] = var_5;
      }
    }
  }
}

_id_FF58(var_0, var_1, var_2, var_3) {
  var_4 = [var_1, var_2, var_3];

  foreach(var_6 in var_4) {
    if(var_6 == "none") {
      continue;
    }
    var_7 = scripts\mp\killstreaks\killstreaks::_id_6AEA(var_6);

    if(!isDefined(var_7)) {
      _id_FF5D("unknownStreak", undefined, var_6);
      var_0._id_84FA[12] = 1;
    }

    if(!self _meth_81C8(var_6, "killstreak")) {
      _id_FF5D("lockedStreak", undefined, var_6);
      var_0._id_84FA[12] = 1;
    }
  }

  if(var_1 == var_2 && var_1 != "none") {
    _id_FF5D("duplicateStreak", undefined, var_1);
    var_0._id_84FA[12] = 1;
  } else if(var_1 == var_3 && var_1 != "none") {
    _id_FF5D("duplicateStreak", undefined, var_1);
    var_0._id_84FA[12] = 1;
  } else if(var_2 == var_3 && var_2 != "none") {
    _id_FF5D("duplicateStreak", undefined, var_2);
    var_0._id_84FA[12] = 1;
  }
}

_id_FF43(var_0, var_1) {
  if(!isDefined(level._id_1A39[var_1])) {
    _id_FF5D("unknownArchetype", undefined, var_1);
    var_0._id_84FA[10] = 1;
  }

  if(!self _meth_81C8(var_1, "rig")) {
    _id_FF5D("lockedArchetype", undefined, var_1);
    var_0._id_84FA[10] = 1;
  }
}

_id_FF59(var_0, var_1, var_2) {
  if(!isDefined(var_1) || var_1 == "none") {
    return;
  }
  var_3 = level._id_EB2B._id_E76D[var_1];

  if(!isDefined(var_3)) {
    _id_FF5D("unknownSuper", undefined, var_1);
    var_0._id_84FA[11] = 1;
  } else if(var_3._id_1A35 != var_2) {
    _id_FF5D("superOnWrongRig", undefined, var_1);
    var_0._id_84FA[11] = 1;
  }

  if(!self _meth_81C8(var_1, "super")) {
    _id_FF5D("lockedSuper", undefined, var_1);
    var_0._id_84FA[11] = 1;
  }
}

_id_FF5C(var_0) {}

_id_5BF4(var_0) {
  var_1 = scripts\mp\class::_id_962A();
  var_1._id_965F = "archetype_assault";
  var_1._id_9683 = "s4_ar_stango44";
  return var_1;
}

_id_5BFF(var_0, var_1) {
  if(var_1 == "primary") {
    var_0._id_9683 = "s4_ar_stango44";
    var_0._id_9686 = "none";
    var_0._id_968C = "none";
    var_0._id_9689 = 0;
    var_0._id_968E = -1;

    for(var_2 = 0; var_2 < scripts\mp\class::_id_6B49(); var_2++) {
      var_0._id_9685[var_2] = "none";
    }
  } else {
    var_0._id_9692 = "none";
    var_0._id_9695 = "none";
    var_0._id_969A = "none";
    var_0._id_9698 = 0;
    var_0._id_969C = -1;

    for(var_2 = 0; var_2 < scripts\mp\class::_id_6B4B(); var_2++) {
      var_0._id_9694[var_2] = "none";
    }
  }
}

_id_5BEB(var_0, var_1, var_2) {
  if(var_1 == "primary") {
    var_0._id_9685[var_2] = "none";
  } else {
    var_0._id_9694[var_2] = "none";
  }
}

_id_5BF7(var_0, var_1) {
  if(var_1 == "primary") {
    var_0._id_9681 = "none";
    var_0._id_9672 = 0;
  } else {
    var_0._id_9682 = "none";
    var_0._id_9673 = 0;
  }
}

_id_5BF5(var_0, var_1) {
  var_0._id_967F = scripts\engine\utility::array_remove(var_0._id_967F, var_1);
}

_id_5BF3(var_0) {
  var_0._id_9679 = "none";
  var_0._id_967A = "none";
  var_0._id_967B = "none";
}

_id_5BEA(var_0) {
  var_0._id_965F = "archetype_assault";
  _id_5BF8(var_0);

  foreach(var_2 in var_0._id_967F) {
    if(isDefined(level._id_9DD5[var_2])) {
      _id_5BF5(var_0, var_2);
      break;
    }
  }
}

_id_5BF8(var_0) {
  var_0._id_96A2 = "none";
}

_id_5BF2(var_0, var_1) {
  if(isDefined(var_1[0])) {
    var_0 = _id_5BF4(var_0);
    return var_0;
  }

  if(isDefined(var_1[1])) {
    _id_5BFF(var_0, "primary");
  } else if(isDefined(var_1[3])) {
    for(var_2 = 0; var_2 < scripts\mp\class::_id_6B49(); var_2++) {
      _id_5BEB(var_0, "primary", var_2);
    }
  } else {
    foreach(var_2 in var_1[2]) {
      _id_5BEB(var_0, "primary", var_2);
    }
  }

  if(isDefined(var_1[4])) {
    _id_5BFF(var_0, "secondary");
  } else if(isDefined(var_1[6])) {
    for(var_2 = 0; var_2 < scripts\mp\class::_id_6B4B(); var_2++) {
      _id_5BEB(var_0, "secondary", var_2);
    }
  } else {
    foreach(var_2 in var_1[5]) {
      _id_5BEB(var_0, "secondary", var_2);
    }
  }

  if(isDefined(var_1[7])) {
    _id_5BF7(var_0, "primary");
  }

  if(isDefined(var_1[8])) {
    _id_5BF7(var_0, "secondary");
  }

  foreach(var_8 in var_1[9]) {
    _id_5BF5(var_0, var_8);
  }

  if(isDefined(var_1[10])) {
    _id_5BEA(var_0);
  } else if(isDefined(var_1[11])) {
    _id_5BEA(var_0);
  }

  if(isDefined(var_1[12])) {
    _id_5BF3(var_0);
  }

  return var_0;
}

_id_981B(var_0) {
  var_1 = _func_0222("mp/menuPowers.csv", 3, var_0, 2);

  if(!isDefined(var_1) || var_1 != "1" && var_1 != "2") {
    return undefined;
  }

  return scripts\engine\utility::ter_op(var_1 == "1", "primary", "secondary");
}

_id_10DE8(var_0) {
  return 0;
}

_id_8B0E(var_0) {
  return isDefined(level._id_10DB0[var_0]) && istrue(level._id_10DB0[var_0]._id_F91D);
}

_id_8B10(var_0) {
  if(getdvarint("#x391583f1a45eeccda", 1) == 1) {
    return 0;
  }

  return isDefined(level._id_10DB0[var_0]) && istrue(level._id_10DB0[var_0]._id_8B15);
}

issuperwip(var_0) {
  if(getdvarint("#x391583f1a45eeccda", 1) == 1) {
    return 0;
  }

  return isDefined(level._id_EB2B._id_E76D[var_0]) && istrue(level._id_EB2B._id_E76D[var_0]._id_8B15);
}

_id_8B0F(var_0, var_1) {
  if(scripts\mp\utility\game::isanymlgmatch()) {
    return 0;
  }

  if(!isDefined(var_1) || var_1 <= 0) {
    return 0;
  }

  var_2 = var_0 + "|" + var_1;
  return isDefined(level._id_10DAC[var_2]) && istrue(level._id_10DAC[var_2]._id_8912);
}

_id_876F(var_0, var_1, var_2) {
  if(scripts\mp\utility\game::isanymlgmatch()) {
    return 0;
  }

  if(!isDefined(var_2) || var_2 == 0 || var_1 == "none") {
    return 0;
  }

  var_3 = 0;
  var_4 = scripts\mp\utility\weapon::_id_6E93(var_0);
  var_5 = tablelookupgetnumrows(var_4);

  for(var_6 = 1; var_6 < var_5; var_6++) {
    var_7 = var_0 + "|" + var_6;

    if(!isDefined(level._id_10DAC[var_7])) {
      continue;
    }
    if(!level._id_10DAC[var_7]._id_8912) {
      if(isDefined(level._id_10DAC[var_7]._id_1D78)) {
        foreach(var_10, var_9 in level._id_10DAC[var_7]._id_1D78) {
          if(var_2 == var_9 && var_1 == var_10) {
            var_3 = 1;
            break;
          }
        }
      }

      if(var_3) {
        break;
      }
    }
  }

  return !var_3;
}

isperkbanned(var_0) {
  var_1 = getDvar("#x36b0ec516c00230c3");

  if(!isDefined(var_1)) {
    var_1 = "";
  }

  var_2 = strtok(var_1, ",");
  return scripts\engine\utility::array_contains(var_2, var_0);
}

isweaponbanned(var_0, var_1) {
  var_2 = getbanneditems();
  var_3 = undefined;

  if(var_1 == 0) {
    if(var_2.size == 0) {
      return 0;
    }

    var_4 = var_0 + "_variant_0";
    var_3 = _func_0222("loot/weapon_ids.csv", 9, var_4, 0);
  } else
    var_3 = scripts\engine\utility::_id_EA52(var_1);

  return scripts\engine\utility::array_contains(var_2, var_3);
}

isattachmentbanned(var_0, var_1) {
  var_2 = getbanneditems();

  if(var_2.size == 0) {
    return 0;
  }

  var_3 = _func_0222("loot/" + var_0 + "_attachment_ids.csv", 1, var_1, 0);
  return scripts\engine\utility::array_contains(var_2, var_3);
}

issuperbanned(var_0) {
  return isitembanned(var_0, 11);
}

isitembanned(var_0, var_1) {
  var_2 = getbanneditems();

  if(var_2.size == 0) {
    return 0;
  }

  var_3 = getitemid(var_0, var_1);
  return scripts\engine\utility::array_contains(var_2, var_3);
}

getitemid(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  switch (var_1) {
    case 13:
      var_2 = "loot/equipment_ids.csv";
      var_3 = 1;
      var_4 = 0;
      break;
    case 11:
      var_2 = "loot/super_ids.csv";
      var_3 = 1;
      var_4 = 0;
      break;
    case 12:
      var_2 = "loot/killstreak_ids.csv";
      var_3 = 1;
      var_4 = 0;
      break;
    case 9:
      var_2 = "loot/perk_ids.csv";
      var_3 = 1;
      var_4 = 0;
      break;
    default:
      break;
  }

  return _func_0222(var_2, var_3, var_0, var_4);
}

getbanneditems() {
  var_0 = getDvar("#x389a461a5d9957fe5");

  if(!isDefined(var_0)) {
    var_0 = "";
  }

  return strtok(var_0, "|");
}