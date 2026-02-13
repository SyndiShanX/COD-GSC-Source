/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2728.gsc
*************************************************/

_id_68E5(var_0) {
  var_1 = _func_0222("mp/attachmenttable.csv", 4, var_0, 2);
  return var_1;
}

_id_6981(var_0) {
  var_1 = getcompleteweaponname(var_0);

  if(istrue(var_0._id_0245)) {
    var_1 = _func_00D6(var_1, 4);
  }

  return var_1;
}

_id_6E90(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(_id_879A(var_0)) {
    return "primary";
  }

  if(_id_879C(var_0)) {
    return "secondary";
  }

  if(_id_88F6(var_0)) {
    return "killstreak";
  }

  if(_id_8A7D(var_0)) {
    return "super";
  }

  if(_id_8876(var_0)) {
    return "gamemode";
  }

  if(var_0 == "iw8_turret_50cal_mp") {
    return "turret";
  }

  if(var_0 == "zeus_turret_m60_tower_mp") {
    return "turret";
  }

  if(_id_890B(var_0)) {
    return "level";
  }

  if(scripts\mp\utility\script::_id_8A68(var_0, "destructible_")) {
    return "destructible";
  }

  if(_id_8AFA(var_0)) {
    return "vehicle";
  }

  if(_id_8A54(var_0) || var_0 == "iw8_defibrillator_mp") {
    return "special_melee";
  }

  if(_id_8834(var_0)) {
    return "environment";
  }

  var_1 = _id_6A18(var_0);

  if(isDefined(var_1)) {
    return var_1;
  }

  if(var_0 == "none") {
    return "worldspawn";
  }

  if(var_0 == "bomb_site_mp") {
    return var_0;
  }

  if(var_0 == "s4_gunless") {
    return "gunless";
  }

  if(var_0 == "zombie_ranged_attack_mp" || var_0 == "zombie_melee_attack_mp") {
    return "zombie";
  }
}

_id_6A18(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "claymore_radial_mp":
    case "s4_molotov_mp":
    case "s4_sticky_eng_n74_mp":
    case "s4_frag_gbr_n82_mp":
    case "at_mine_mp":
    case "thermite_ap_mp":
    case "at_mine_ap_mp":
    case "rock_mp":
    case "snowball_mp":
    case "s4_frag_gbr_n23_mp":
    case "s4_throwing_star_mp":
    case "s4_bundle_charge_mp":
    case "s4_thermite_mp":
    case "s4_frag_ger_m24_mp":
    case "thermite_av_mp":
    case "s4_throwing_knife_mp":
    case "s4_semtex_mp":
    case "s4_frag_usa_mk2_mp":
    case "claymore_mp":
    case "s4_c4_mp":
      var_1 = "lethal";
      break;
    case "snapshot_grenade_mp":
    case "hb_sensor_mp":
    case "pball_mp":
    case "s4_gas_usa_mk5cn_mp":
    case "s4_mine_ger_s44_mp":
    case "s4_adrenaline_mp":
    case "at_mine_stun_mp":
    case "s4_smoke_gbr_n77_mp":
    case "s4_decoy_grenade_mp":
    case "s4_smoke_usa_m18_mp":
    case "flash_grenade_mp":
    case "s4_stun_gbr_n69_mp":
      var_1 = "tactical";
      break;
    case "ks_remote_drone_mp":
    case "adrenaline_br_fake":
    case "bandage_br_fake":
    case "gesture_vest_plate_br":
      if(scripts\mp\utility\game::getgametype() == "br") {
        var_1 = "equipment_other";
      }

      break;
    default:
      break;
  }

  return var_1;
}

_id_8834(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  if(var_1 == "s4_minefield_mp") {
    return 1;
  } else if(var_1 == "danger_circle_br") {
    return 1;
  } else if(var_1 == "barrel_mp") {
    return 1;
  }

  return 0;
}

_id_8A7D(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return isDefined(scripts\mp\supers::_id_6DA7(var_0));
}

_id_8A76(var_0) {
  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  if(_id_8A7D(var_0)) {
    return 1;
  }

  if(var_1 == "chargemode_mp") {
    return 1;
  }

  if(var_1 == "micro_turret_gun_mp") {
    return 1;
  }

  if(var_1 == "super_trophy_mp") {
    return 1;
  }

  return 0;
}

_id_8876(var_0) {
  if(_id_8787(var_0)) {
    return 1;
  }

  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  switch (var_1) {
    case "iw7_tdefball_mp":
    case "iw8_cyberemp_mp":
    case "danger_circle_br":
    case "iw8_lm_kilo121jugg_mp":
    case "iw8_lm_dblmg":
      return 1;
    default:
      return 0;
  }

  return 0;
}

_id_890B(var_0) {
  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  switch (var_1) {
    default:
      return 0;
  }

  return 0;
}

getweapongroup(var_0) {
  if(isweapon(var_0) && isnullweapon(var_0)) {
    return "other";
  }

  if(_func_0121(var_0) && (var_0 == "none" || var_0 == "alt_none")) {
    return "other";
  }

  var_1 = getweaponrootname(var_0);
  var_2 = _id_10D99(var_1);

  if(!isDefined(var_2)) {
    if(_id_8A7D(var_0)) {
      var_2 = "super";
    } else if(_id_88F6(var_0)) {
      var_2 = "killstreak";
    } else if(_id_8876(var_0)) {
      var_2 = "gamemode";
    } else if(_id_87DD(var_0)) {
      var_2 = "weapon_crossbowSpecial";
    } else if(_id_880E(var_0)) {
      var_2 = "weapon_dragonsBreath";
    } else {
      var_2 = "other";
    }
  }

  return var_2;
}

_id_880E(var_0) {
  return 0;
}

_id_87DD(var_0) {
  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  switch (var_1) {
    case "thermite_bolt_radius_mp":
    case "thermite_bolt_mp":
    case "semtex_bolt_splash_mp":
    case "semtex_bolt_mp":
      return 1;
    default:
      return 0;
  }
}

_id_68AC(var_0) {
  var_1 = getweaponrootname(var_0);
  var_2 = level._id_10D64[var_1];

  if(!isDefined(var_2)) {
    var_2 = [];
  }

  return var_2;
}

_id_1DB1(var_0, var_1) {
  if(_id_1D98(var_0) && _id_1D98(var_1)) {
    return 0;
  }

  var_0 = _id_1DA5(var_0);
  var_1 = _id_1DA5(var_1);
  var_2 = 1;

  if(var_0 == var_1) {
    var_2 = 0;
  } else if(isDefined(level._id_1DA3)) {
    var_2 = !(isDefined(level._id_1DA3[var_0]) && isDefined(level._id_1DA3[var_0][var_1]));
  } else if(var_0 != "none" && var_1 != "none") {
    var_3 = tablelookuprownum("mp/attachmentcombos.csv", 0, var_1);

    if(_func_0222("mp/attachmentcombos.csv", 0, var_0, var_3) == "no") {
      var_2 = 0;
    }
  }

  return var_2;
}

_id_1DB2(var_0, var_1, var_2, var_3, var_4) {
  if(_id_1D98(var_0) && _id_1D98(var_1)) {
    return var_0;
  }

  var_5 = undefined;

  if(isweapon(var_2)) {
    var_5 = getcompleteweaponname(var_2);
  } else {
    var_5 = var_2;
  }

  if(!isDefined(var_3)) {
    var_3 = _id_1DA9(var_0, var_5);
  }

  if(!isDefined(var_4)) {
    var_4 = _id_1DA9(var_1, var_5);
  }

  if(_id_0B44(var_3, var_4)) {
    return var_0;
  }

  if(_id_0B44(var_4, var_3)) {
    return var_0;
  }

  var_0 = _id_1DA5(var_0);
  var_1 = _id_1DA5(var_1);
  var_6 = "";

  if(var_0 == var_1) {
    var_6 = var_0;
  } else if(isDefined(level._id_1DA3) && isDefined(level._id_1DA3[var_0])) {
    var_7 = level._id_1DA3[var_0][var_1];

    if(isDefined(var_7)) {
      if(var_7 == "no") {
        var_6 = var_0;
      } else {
        var_6 = var_7;
      }
    }
  }

  return var_6;
}

_id_0B44(var_0, var_1) {
  var_2 = _id_1DA7(var_0);
  var_3 = _id_1DA6(var_1);
  return isDefined(var_2) && isDefined(var_3) && var_3 == var_2;
}

getweaponrootname(var_0) {
  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  var_2 = level._id_10DC8[var_1];

  if(isDefined(var_2)) {
    return var_2;
  }

  var_3 = var_1;
  var_4 = strtok(var_1, "_");
  var_5 = 0;

  if(var_4[0] == "alt") {
    var_5++;
  }

  if(var_4[var_5] == "iw8" || var_4[var_5] == "s4") {
    var_6 = ["ar", "sm", "lm", "sh", "sn", "dm", "pi", "la", "me", "mr", "sr", "mg", "gw"];

    if(scripts\engine\utility::array_contains(var_6, var_4[var_5 + 1])) {
      var_1 = var_4[var_5] + "_" + var_4[var_5 + 1] + "_" + var_4[var_5 + 2];
    } else {
      var_1 = var_4[var_5] + "_" + var_4[var_5 + 1];
    }
  }

  if(level._id_10DC8.size < 100) {
    level._id_10DC8[var_3] = var_1;
  }

  return var_1;
}

_id_69D8(var_0) {
  var_1 = getweaponrootname(var_0);

  if(isDefined(level._id_10DB0[var_1]) && isDefined(level._id_10DB0[var_1]._id_1CED)) {
    var_0 = level._id_10DB0[var_1]._id_1CED;
  }

  return var_0;
}

_id_6E93(var_0) {
  if(scripts\mp\utility\script::_id_8A68(var_0, "iw8_")) {
    var_0 = _func_00D6(var_0, 4);
  }

  return "mp/gunsmith/" + var_0 + "_variants.csv";
}

_id_6E6A(var_0) {
  if(isweapon(var_0)) {
    return var_0.basename;
  }

  if(_func_0121(var_0) && var_0 == "none") {
    return "none";
  }

  return getweaponbasename(var_0);
}

_id_6E77(var_0) {
  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  var_2 = getweaponrootname(var_1);
  return "mp/gunsmith/" + _func_00D6(var_2, 4) + "_attachments.csv";
}

_id_68B4(var_0) {
  foreach(var_2 in var_0._id_0070) {
    var_3 = _id_1DA5(var_2);

    if(var_3 == "gl" || var_3 == "glsmoke" || var_3 == "glgas" || var_3 == "glconc" || var_3 == "glflash" || var_3 == "glincendiary" || var_3 == "glsemtex" || var_3 == "glsnap") {
      return var_3;
    }
  }

  return undefined;
}

_id_874D(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  return _func_0276(var_0) == "altmode";
}

_id_C472(var_0) {
  if(_id_874D(var_0)) {
    var_0 = _func_00D6(var_0, 4);
  }

  return var_0;
}

_id_6E2E() {
  var_0 = [];
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_4 = weaponclass(var_3);

    if(!_id_88F6(var_3) && var_4 != "grenade" && var_4 != "rocketlauncher" && self getweaponammostock(var_3) != 0) {
      var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

_id_897E(var_0) {
  if(_id_8799(var_0)) {
    var_1 = undefined;

    if(isweapon(var_0)) {
      var_1 = getcompleteweaponname(var_0 _meth_8628());
    } else if(_func_0121(var_0)) {
      var_1 = var_0;

      if(issubstr(var_1, "alt_")) {
        var_1 = _func_00D6(var_1, 4, var_0.size);
      }
    }

    var_2 = isDefined(self.pers["primaryWeapon"]) && self.pers["primaryWeapon"] == var_1;
    var_3 = isDefined(self.pers["secondaryWeapon"]) && self.pers["secondaryWeapon"] == var_1;

    if(!var_2 && !var_3) {
      return 1;
    }
  }

  return 0;
}

_id_879A(var_0) {
  return _id_879B(getweapongroup(var_0), var_0);
}

_id_879B(var_0, var_1) {
  switch (var_0) {
    case "weapon_lmg":
    case "weapon_dmr":
    case "weapon_sniper":
    case "weapon_assault":
    case "weapon_melee":
    case "weapon_shotgun":
    case "weapon_smg":
    case "weapon_crossbowSpecial":
    case "weapon_dragonsBreath":
      return 1;
    default:
      return 0;
  }
}

_id_879C(var_0) {
  return _id_879D(getweapongroup(var_0), var_0);
}

_id_879D(var_0, var_1) {
  switch (var_0) {
    case "weapon_pistol":
    case "weapon_projectile":
      return 1;
    case "weapon_melee2":
      return !_id_8A54(var_1);
    default:
      return 0;
  }
}

_id_8799(var_0) {
  var_1 = getweapongroup(var_0);
  return _id_879B(var_1, var_0) || _id_879D(var_1, var_0);
}

_id_8798(var_0) {
  var_1 = getweapongroup(var_0);
  return var_1 == "weapon_melee" || var_1 == "weapon_melee2";
}

_id_5273() {
  if(!isDefined(self._id_10DA8)) {
    self._id_10DA8 = 0;
  }

  self._id_10DA8++;
  self _meth_8203();
}

_id_4AFD() {
  self._id_10DA8--;

  if(self._id_10DA8 == 0) {
    self _meth_8202();
    self._id_10DA8 = undefined;
  }
}

_id_1DA9(var_0, var_1) {
  var_2 = undefined;

  if(isweapon(var_1)) {
    var_2 = getcompleteweaponname(var_1);
  } else {
    var_2 = var_1;
  }

  var_3 = getweaponrootname(var_1);

  if(var_3 != var_2) {
    var_4 = getweaponbasename(var_1);

    if(isDefined(level._id_1DA2[var_4]) && isDefined(level._id_1DAB[var_0]) && isDefined(level._id_1DA2[var_4][level._id_1DAB[var_0]])) {
      var_5 = level._id_1DAB[var_0];
      return level._id_1DA2[var_4][var_5];
    } else if(isDefined(level._id_1DA2[var_4]) && isDefined(level._id_1DA2[var_4][var_0]))
      return level._id_1DA2[var_4][var_0];
    else {
      var_6 = strtok(var_4, "_");

      if(var_6.size > 3) {
        var_7 = var_6[0] + "_" + var_6[1] + "_" + var_6[2];

        if(isDefined(level._id_1DA2[var_7]) && isDefined(level._id_1DA2[var_7][var_0])) {
          return level._id_1DA2[var_7][var_0];
        }
      }
    }
  }

  if(isDefined(level._id_1DA2[var_3]) && isDefined(level._id_1DA2[var_3][var_0])) {
    return level._id_1DA2[var_3][var_0];
  } else {
    var_8 = _id_10D99(var_3);

    if(isDefined(level._id_1DA2[var_8]) && isDefined(level._id_1DA2[var_8][var_0])) {
      return level._id_1DA2[var_8][var_0];
    }
  }

  return var_0;
}

_id_1DA4(var_0, var_1, var_2) {
  var_3 = var_1 + "|" + var_2;

  if(isDefined(level._id_10DAC[var_3]) && isDefined(level._id_10DAC[var_3]._id_1D86) && isDefined(level._id_10DAC[var_3]._id_1D86[var_0])) {
    return level._id_10DAC[var_3]._id_1D86[var_0];
  }

  return 0;
}

_id_1DAD(var_0) {
  if(isDefined(level._id_1DA0[var_0])) {
    return level._id_1DA0[var_0];
  }

  return undefined;
}

_id_1DA6(var_0) {
  if(isDefined(level._id_1D9F[var_0])) {
    return level._id_1D9F[var_0];
  }

  return undefined;
}

_id_1DA7(var_0) {
  if(isDefined(level._id_1DAA[var_0])) {
    return level._id_1DAA[var_0];
  }

  var_1 = _id_1DA5(var_0);

  if(isDefined(level._id_1DA1[var_1])) {
    return level._id_1DA1[var_1];
  }

  return undefined;
}

_id_10D5F(var_0, var_1) {
  if(_id_88F6(var_0)) {
    return var_0;
  }

  if(ispmfweapon(var_0)) {
    return var_0;
  }

  if(isDefined(var_1)) {
    var_2 = var_0 + "|" + var_1;

    if(isDefined(level._id_10DAC[var_2]) && isDefined(level._id_10DAC[var_2]._id_1CEE)) {
      return level._id_10DAC[var_2]._id_1CEE;
    }
  }

  if(isDefined(level._id_10DB0[var_0]) && isDefined(level._id_10DB0[var_0]._id_1CED)) {
    return level._id_10DB0[var_0]._id_1CED;
  }

  return var_0;
}

_id_10DBD(var_0) {
  if(isDefined(level._id_10DB0[var_0]) && isDefined(level._id_10DB0[var_0]._id_AFA5)) {
    return level._id_10DB0[var_0]._id_AFA5;
  }

  return undefined;
}

getrandomweaponfromgroup(var_0) {
  var_1 = randomintrange(0, level._id_10D98[var_0].size);
  return level._id_10D98[var_0][var_1];
}

_id_10D99(var_0) {
  if(isDefined(level._id_10DB0[var_0]) && isDefined(level._id_10DB0[var_0]._id_71F4)) {
    return level._id_10DB0[var_0]._id_71F4;
  }

  return undefined;
}

_id_10DB4(var_0) {
  if(isDefined(level._id_10DB0[var_0]) && isDefined(level._id_10DB0[var_0]._id_A76E)) {
    return level._id_10DB0[var_0]._id_A76E;
  }

  return undefined;
}

_id_10D62(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_0 + "|" + var_1;

    if(isDefined(level._id_10DAC[var_2]) && isDefined(level._id_10DAC[var_2]._id_1D7B)) {
      return level._id_10DAC[var_2]._id_1D7B;
    }
  }

  if(isDefined(level._id_10DB0[var_0]) && isDefined(level._id_10DB0[var_0]._id_1D7B)) {
    return level._id_10DB0[var_0]._id_1D7B;
  }

  return undefined;
}

_id_10D60(var_0, var_1) {
  if(isDefined(var_1) && var_1 >= 0) {
    var_2 = var_0 + "|" + var_1;

    if(isDefined(level._id_10DAC[var_2]) && isDefined(level._id_10DAC[var_2]._id_1D78)) {
      return level._id_10DAC[var_2]._id_1D78;
    }
  }

  return undefined;
}

_id_10D7F(var_0) {
  return isDefined(level._id_10DB0[var_0]);
}

_id_10D65(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(level._id_1D93[var_3])) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_876D(var_0, var_1) {
  var_2 = strtok(var_0, "_");
  return _id_876E(var_2, var_1);
}

_id_876E(var_0, var_1) {
  var_2 = 0;

  if(var_0.size && isDefined(var_1)) {
    var_3 = 0;

    if(var_0[0] == "alt") {
      var_3 = 1;
    }

    if(var_0.size >= 3 + var_3 && (var_0[var_3] == "iw6" || var_0[var_3] == "iw7")) {
      if(weaponclass(var_0[var_3] + "_" + var_0[var_3 + 1] + "_" + var_0[var_3 + 2]) == "sniper") {
        var_2 = var_0[var_3 + 1] + "scope" == var_1;
      }
    }
  }

  return var_2;
}

_id_6E69(var_0) {
  if(_func_0121(var_0)) {
    if(var_0 == "none") {
      return [];
    }
  } else if(var_0.basename == "none")
    return [];

  var_1 = getweaponattachments(var_0);

  foreach(var_4, var_3 in var_1) {
    var_1[var_4] = _id_1DA5(var_3);
  }

  return var_1;
}

_id_68DE(var_0) {
  foreach(var_3, var_2 in var_0) {
    var_0[var_3] = _id_1DA5(var_2);
  }

  return var_0;
}

_id_6BA9() {
  var_0 = [];
  var_1 = tablelookupgetnumrows("mp/attachmenttable.csv");

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = tablelookupbyrow("mp/attachmenttable.csv", var_2, 0);
    var_3 = int(var_3);

    if(var_3 == 0) {
      continue;
    }
    var_4 = _func_0222("mp/attachmenttable.csv", 0, var_3, 5);

    if(var_4 != "") {
      var_5 = _func_0222("mp/attachmenttable.csv", 0, var_3, 2);

      if(var_5 != "none" && var_5 != "rail" && !scripts\engine\utility::array_contains(var_0, var_4)) {
        var_0[var_0.size] = var_4;
      }
    }
  }

  return var_0;
}

_id_6BDC() {
  if(isDefined(level._id_AC48)) {
    return level._id_AC48;
  }

  var_0 = [];
  var_1 = tablelookupgetnumrows("mp/attachmenttable.csv");

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = tablelookupbyrow("mp/attachmenttable.csv", var_2, 0);
    var_3 = int(var_3);

    if(var_3 == 0) {
      continue;
    }
    var_4 = _func_0222("mp/attachmenttable.csv", 0, var_3, 5);

    if(var_4 != "") {
      var_5 = _func_0222("mp/attachmenttable.csv", 0, var_3, 2);

      if(var_5 == "rail" && !scripts\engine\utility::array_contains(var_0, var_4)) {
        var_0[var_0.size] = var_4;
      }
    }
  }

  level._id_AC48 = var_0;
  return level._id_AC48;
}

_id_1DA5(var_0) {
  if(isDefined(level._id_1DAB[var_0])) {
    var_0 = level._id_1DAB[var_0];
  }

  return var_0;
}

_id_1DA8(var_0) {
  var_1 = undefined;

  if(isDefined(level._id_1DAC[var_0])) {
    var_1 = level._id_1DAC[var_0];
  }

  return var_1;
}

_id_9ACB(var_0, var_1, var_2) {
  var_3 = var_0;

  if(!isDefined(var_0)) {
    var_3 = _func_0375();
  }

  var_4 = 0;

  if(var_3.basename != "none") {
    if(isDefined(var_1) && !isPlayer(var_1)) {
      var_5 = _id_68B4(var_0);

      if(isDefined(var_5)) {
        switch (var_5) {
          case "glconc":
            var_3 = makeweapon("s4_stun_gbr_n69_mp");
            break;
          case "glflash":
            var_3 = makeweapon("flash_grenade_mp");
            break;
          case "glsnap":
            var_3 = makeweapon("snapshot_grenade_mp");
            break;
          case "glincendiary":
            var_3 = makeweapon("s4_thermite_mp");
            break;
        }
      }
    }

    switch (var_3.basename) {
      case "pop_rocket_proj_mp":
        var_3 = makeweapon("pop_rocket_mp");
        break;
      case "tur_gun_mp":
      case "tur_gun_faridah_mp":
        var_3 = makeweapon("iw8_turret_50cal_mp");
        break;
      case "tur_gun_lighttank_mp":
      case "tur_bradley_mp":
        var_3 = makeweapon("lighttank_tur_mp");
        break;
      case "tur_bradley_ks_mp":
      case "tur_gun_lighttank_ks_mp":
        var_3 = makeweapon("lighttank_tur_ks_mp");
        break;
      case "s4_tur_mg_gun_tank_mp":
      case "s4_tur_main_tank_mike4_mp":
        var_3 = makeweapon("s4_tank_tur_mp");
        break;
      case "ks_remote_drone_mp":
        var_3 = _func_0375();
        break;
    }
  } else if(isDefined(var_1)) {
    if(isDefined(var_1.objweapon)) {
      var_3 = makeweapon(var_1.objweapon.basename);
      var_4 = 1;
    } else if(isDefined(var_1.weapon_name)) {
      var_3 = makeweapon(var_1.weapon_name);
      var_4 = 1;
    }
  }

  if(var_4 && !istrue(var_2)) {
    var_3 = _id_9ACB(var_3, var_1, 1);
  }

  return var_3;
}

_id_1DB3(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(_id_1D9D(var_4, var_1)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_1D9D(var_0, var_1) {
  if(_id_1D98(var_0)) {
    return 0;
  }

  if(!_id_1D9B(var_1, var_0)) {
    return 0;
  }

  if(scripts\engine\utility::string_starts_with(var_0, "laststand_")) {
    return 0;
  }

  return 1;
}

weaponhasattachment(var_0, var_1) {
  var_2 = _id_6E69(var_0);

  foreach(var_4 in var_2) {
    if(var_4 == var_1) {
      return 1;
    }
  }

  return 0;
}

_id_D69A(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(self._id_C114)) {
    self._id_C114 = var_0;
  } else {
    self._id_C114 = self._id_C114 + var_0;
  }

  if(isDefined(var_1)) {
    if(isDefined(self._id_C114) && var_1 < self._id_C114 && !var_2) {
      var_1 = self._id_C114;
    }

    var_3 = 100 - var_1;
  } else
    var_3 = 100 - self._id_C114;

  var_3 = int(clamp(var_3, 0, 255));

  if(var_3 == 100) {
    self player_recoilscaleoff();
    return;
  }

  self player_recoilscaleon(var_3);
}

_id_0C48(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self launchgrenade(var_0, var_1, var_2, var_3, var_5);

  if(!isDefined(var_4)) {
    var_6._id_A6BF = 1;
  } else {
    var_6._id_A6BF = var_4;
  }

  var_6 setotherent(self);
  return var_6;
}

_id_7169() {
  return !isnullweapon(self getheldoffhand());
}

_id_6A79() {
  var_0 = self getheldoffhand();

  if(isDefined(self._id_62F1) && var_0 == makeweaponfromstring(self._id_62F1)) {
    var_0 = _func_0375();
  }

  return var_0;
}

_id_10DA2(var_0, var_1) {
  var_2 = var_0.basename;

  if(_id_8A7D(var_2)) {
    return 1;
  }

  if(_id_88F6(var_2)) {
    return 1;
  }

  switch (var_2) {
    case "bomb_site_mp":
    case "snapshot_grenade_mp":
    case "s4_gas_usa_mk5cn_mp":
    case "flash_grenade_mp":
    case "s4_stun_gbr_n69_mp":
      return 1;
    default:
      return 0;
  }
}

_id_10DDC(var_0) {
  switch (var_0) {
    case "s4_gw_flima35_mp":
    case "s4_me_rindigo_mp":
    case "s4_mg_streak_mp":
    case "s4_mg_juniform_mp":
    case "s4_me_fists_mp":
    case "s4_me_knife_mp":
      return 0;
  }

  if(_id_88F6(var_0)) {
    return 0;
  }

  var_1 = weaponclass(var_0);
  return var_1 == "rifle" || var_1 == "mg" || var_1 == "sniper" || var_1 == "smg" || var_1 == "spread";
}

_id_6E7C(var_0) {
  return "laserir";
}

_id_8A38(var_0) {
  var_0 = _id_6E6A(var_0);

  switch (var_0) {
    case "s4_la_walpha2_mp":
      return 1;
    default:
      return 0;
  }
}

_id_1D98(var_0) {
  return isDefined(var_0) && scripts\engine\utility::string_starts_with(var_0, "cos_");
}

_id_1D9B(var_0, var_1) {
  var_2 = getweaponrootname(var_0);
  return _id_1D9C(var_2, var_1);
}

_id_1D9C(var_0, var_1) {
  var_2 = level._id_10D64[var_0];
  return isDefined(var_2) && isDefined(var_2[var_1]);
}

_id_C323(var_0) {
  switch (var_0) {
    case "laserRange":
    case "laserbalanced":
    case "laserads":
      var_0 = "laser";
      break;
    case "silencer3":
    case "silencer2":
    case "barsil":
    case "silencer4":
    case "barsil2":
      var_0 = "silencer";
      break;
    case "barshortnoguard":
    case "barshort":
    case "barlong":
    case "barmid":
    case "barcust2":
    case "barcust":
    case "barcustnoguard":
      var_0 = "barlong";
      break;
  }

  return var_0;
}

_id_10D87(var_0) {
  var_1 = "none";
  var_2 = -1;

  if(isDefined(var_0) && !isnullweapon(var_0)) {
    var_1 = weaponclass(var_0);

    switch (var_1) {
      case "pistol":
        var_2 = 1;
        break;
      case "sniper":
        if(getweapongroup(var_0) == "weapon_dmr") {
          var_2 = 3;
        } else {
          var_2 = 4;
        }

        break;
      default:
        var_2 = 0;
    }
  }

  return var_2;
}

_id_8787(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  switch (var_1) {
    case "s4_bomb_remote_mp":
    case "bomb_site_mp":
    case "s4_bomb_remote_vday_mp":
    case "s4_bomb_remote_holiday_mp":
    case "briefcase_bomb_mp":
      return 1;
  }

  return 0;
}

_id_88F6(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  if(isDefined(level._id_8DEE) && isDefined(level._id_8DEE[var_1])) {
    return 1;
  }

  return 0;
}

ispmfweapon(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  if(isDefined(level.postmatchflowweapons) && isDefined(level.postmatchflowweapons[var_1])) {
    return 1;
  }

  return 0;
}

_id_88F4(var_0) {
  return isDefined(var_0) && isDefined(var_0._id_1031E) && isDefined(var_0.streakinfo);
}

_id_10D66(var_0) {
  var_1 = 1;
  var_2 = undefined;

  if(isweapon(var_0)) {
    var_2 = var_0.basename;
  } else {
    var_2 = var_0;
  }

  if(_id_88F6(var_0) && var_2 != "manual_turret_mp" && var_2 != "pac_sentry_turret_mp") {
    var_1 = 0;
  }

  return var_1;
}

_id_8AFA(var_0) {
  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  switch (var_1) {
    case "tur_apc_rus_mp":
    case "apc_rus_mp":
    case "lighttank_tur_mp":
    case "motorcycle_mp":
    case "open_jeep_mp":
    case "technical_mp":
    case "tac_rover_mp":
    case "little_bird_mp":
    case "large_transport_mp":
    case "atv_mp":
    case "s4_tank_tur_mp":
    case "s4_tank_mp":
    case "pickup_truck_mp":
    case "jeep_mp":
    case "big_bird_mp":
    case "cop_car_mp":
    case "van_mp":
    case "cargo_truck_mp":
    case "med_transport_mp":
    case "hoopty_mp":
    case "bradley_tow_proj_mp":
    case "lighttank_mp":
    case "hoopty_truck_mp":
      return 1;
    default:
      return 0;
  }
}

_id_887A(var_0) {
  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  if(issubstr(var_1, "ges_plyr")) {
    return 1;
  } else if(issubstr(var_1, "devilhorns_mp")) {
    return 1;
  } else {
    return 0;
  }
}

getweaponfullname(var_0) {
  if(_func_0121(var_0)) {
    return var_0;
  } else {
    return getcompleteweaponname(var_0);
  }
}

_id_B388(var_0, var_1) {
  var_2[0][0]["org"] = self gettagorigin("j_spineupper");
  var_2[0][0]["angles"] = self gettagangles("j_spineupper");
  var_2[0][1]["org"] = self gettagorigin("j_spinelower");
  var_2[0][1]["angles"] = self gettagangles("j_spinelower");
  var_2[0][2]["org"] = self gettagorigin("j_head");
  var_2[0][2]["angles"] = self gettagangles("j_head");
  var_2[1][0]["org"] = self gettagorigin("j_knee_ri");
  var_2[1][0]["angles"] = self gettagangles("j_knee_ri");
  var_2[1][1]["org"] = self gettagorigin("j_knee_le");
  var_2[1][1]["angles"] = self gettagangles("j_knee_le");
  var_2[1][2]["org"] = self gettagorigin("j_elbow_ri");
  var_2[1][2]["angles"] = self gettagangles("j_elbow_ri");
  var_2[1][3]["org"] = self gettagorigin("j_elbow_le");
  var_2[1][3]["angles"] = self gettagangles("j_elbow_le");
  var_2[2][0]["org"] = self gettagorigin("j_ankle_le");
  var_2[2][0]["angles"] = self gettagangles("j_ankle_le");
  var_2[2][1]["org"] = self gettagorigin("j_ankle_ri");
  var_2[2][1]["angles"] = self gettagangles("j_ankle_ri");
  var_2[2][2]["org"] = self gettagorigin("j_wrist_le");
  var_2[2][2]["angles"] = self gettagangles("j_wrist_le");
  var_2[2][3]["org"] = self gettagorigin("j_wrist_ri");
  var_2[2][3]["angles"] = self gettagangles("j_wrist_ri");
  var_3 = "bullet_atomizer_impact_npc";
  var_4 = (0, 0, 0);

  if(isDefined(var_1)) {
    var_4 = var_1;
  }

  if(isDefined(var_0)) {
    var_3 = var_0;
  }

  self playSound(var_3);

  foreach(var_6 in var_2) {
    foreach(var_8 in var_6) {
      playFX(level._effect["atomize_body"], var_8["org"] + var_4, anglesToForward(var_8["angles"]));
    }

    wait 0.01;
  }
}

_id_89C7(var_0) {
  if(isnullweapon(var_0)) {
    return 0;
  }

  if(var_0._id_0241 != "primary" && var_0._id_0241 != "altmode") {
    return 0;
  }

  switch (var_0.classname) {
    case "rocketlauncher":
    case "pistol":
    case "mg":
    case "spread":
    case "smg":
    case "rifle":
    case "sniper":
      return 1;
    default:
      return 0;
  }
}

_id_8927(var_0) {
  return var_0.basename == "s4_knifestab_mp";
}

_id_88F9(var_0) {
  return getweaponrootname(var_0) == "s4_me_knife_mp";
}

_id_8929(var_0) {
  if(_func_0121(var_0)) {}

  return var_0._id_0249;
}

_id_885D(var_0) {
  return getweaponrootname(var_0) == "s4_me_fists";
}

_id_8778(var_0) {
  return var_0.basename == "iw8_cyberemp_mp" || var_0.basename == "iw7_tdefball_mp";
}

_id_8774(var_0) {
  var_1 = getweaponrootname(var_0);
  return var_1 == "iw7_axe" || var_1 == "s4_me_icepick" || var_1 == "s4_me_axe";
}

isnonthrowablemelee(var_0) {
  var_1 = getweaponrootname(var_0);
  return var_1 == "s4_me_knife" || var_1 == "s4_me_katana" || var_1 == "s4_me_leiomano" || var_1 == "s4_me_sledgehammer";
}

isthrownaxeweapon(var_0, var_1) {
  return _id_8774(var_0) && isDefined(var_1.classname) && var_1.classname == "grenade";
}

_id_8A9F(var_0) {
  var_1 = undefined;

  if(isweapon(var_0)) {
    if(isnullweapon(var_0)) {
      return 0;
    }

    var_1 = var_0.basename;
  } else {
    if(var_0 == "none") {
      return 0;
    }

    var_1 = var_0;
  }

  return issubstr(var_1, "throwing_knife");
}

_id_8A54(var_0) {
  var_1 = undefined;

  if(isweapon(var_0)) {
    if(isnullweapon(var_0)) {
      return 0;
    }

    var_1 = var_0.basename;
  } else {
    if(var_0 == "none") {
      return 0;
    }

    var_1 = var_0;
  }

  return var_1 == "s4_me_fists_mp_ls" || var_1 == "s4_knifestab_mp";
}

_id_8888(var_0) {
  var_1 = undefined;

  if(isweapon(var_0)) {
    if(isnullweapon(var_0)) {
      return 0;
    }

    var_1 = var_0.basename;
  } else {
    if(var_0 == "none") {
      return 0;
    }

    var_1 = var_0;
  }

  return var_1 == "s4_gunless";
}

_id_7E8D(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("stop_infinite_ammo_thread");

  if(!isDefined(var_0)) {
    var_0 = level._id_5F3A;
  }

  for(;;) {
    if(!isDefined(var_1)) {
      var_1 = self._id_019F;
    }

    foreach(var_3 in var_1) {
      self givemaxammo(var_3);
      self setweaponammoclip(var_3, weaponclipsize(var_3));
    }

    wait(var_0);
  }
}

_id_E910() {
  self notify("stop_infinite_ammo_thread");
}

_id_6D27(var_0) {
  var_1 = [];

  if(!_func_0221(var_0)) {
    return var_1;
  }

  var_2 = int(tablelookupgetnumrows("mobile/weapons.csv"));

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = tablelookupbyrow("mobile/weapons.csv", var_3, 1);

    if(var_4 == "") {
      continue;
    }
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  return var_1;
}

_id_6C2B(var_0) {
  var_1 = [];

  for(var_2 = 1; _func_0221(var_0) && _func_0222(var_0, 0, var_2, 0) != ""; var_2++) {
    var_1[var_2 - 1] = spawnStruct();
    var_3 = _func_0222(var_0, 0, var_2, 1);
    var_4 = _func_0222(var_0, 0, var_2, 2);
    var_5 = _func_0222(var_0, 0, var_2, 3);
    var_1[var_2 - 1].origin = (float(var_3), float(var_4), float(var_5));
  }

  return var_1;
}

_id_E3A9(var_0, var_1) {
  while(!isDefined(level._id_10DAC)) {
    waitframe();
  }

  if(!isDefined(var_1)) {
    var_2 = _id_6D27("mobile/weapons.csv");
  } else {
    var_2 = _id_6D27(var_1);
  }

  var_3 = getarraykeys(var_2);
  var_4 = [];
  level._id_10DC0 = [];

  foreach(var_6 in var_3) {
    var_7 = var_2[var_6];
    var_8 = 0;
    var_9 = scripts\mp\class::buildweapon_blueprint(var_7, "none", "none", var_8);
    var_4[var_4.size] = var_9;
  }

  var_11 = _id_6C2B(var_0);
  var_12 = 0;
  var_13 = var_4.size;

  foreach(var_15 in var_11) {
    var_16 = 17;
    var_17 = var_4[var_12 % var_13];
    var_18 = getcompleteweaponname(var_17);
    var_19 = spawn("weapon_" + var_18, var_15.origin, var_16);
    level._id_10DC0[level._id_10DC0.size] = var_19;

    if(var_17.basename != "s4_me_rindigo_mp") {
      var_19.angles = (0, 90, 90);
    } else {
      var_19.angles = (-90, 0, 90);
    }

    var_19 _meth_81F6(weaponclipsize(var_17), weaponmaxammo(var_17));
    var_12++;
  }

  level notify("weapon_pickups_spawned");
}