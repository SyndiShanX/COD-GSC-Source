/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1920.gsc
*************************************************/

_id_7FE3() {
  level._id_4A1D = 1;
  level._id_0F22 = [];
  level._id_1CE5 = ["brloot_weapon_ak47", "brloot_weapon_famas", "brloot_weapon_m4", "brloot_weapon_mcx"];
  level._id_95A5 = ["brloot_weapon_hk121", "brloot_weapon_pkm"];
  level._id_DE30 = ["brloot_weapon_aug", "brloot_weapon_mp5", "brloot_weapon_mp7", "brloot_weapon_p90"];
  level._id_DA55 = ["brloot_weapon_dp12", "brloot_weapon_m870"];
  level._id_DFA3 = ["brloot_weapon_as50", "brloot_weapon_kar98", "brloot_weapon_m14", "brloot_weapon_marlin"];
  level._id_B131 = ["brloot_weapon_g21", "brloot_weapon_python"];
  _id_7FE4();
}

_id_7FE4() {
  _id_07A1::_id_CECB(::_id_985F);
}

_id_985F(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_2 == "visible") {
    var_6 = _id_6F08(var_1, var_3);

    if(istrue(var_6)) {
      level thread _id_985D(var_0, var_1, var_2, var_3);
    } else {}
  }
}

_id_985D(var_0, var_1, var_2, var_3) {
  var_4 = strtok(var_1, "_");
  var_5 = var_4[1];
  var_6 = var_4[2];
  var_3 playsoundtoplayer("scavenger_pack_pickup", var_3);
  var_0 setscriptablepartstate(var_1, "hidden");
  level notify("pickedupweapon_kill_callout_" + var_0.type + var_0.origin);

  if(var_5 == "munition") {
    var_7 = spawn("script_model", var_0.origin);
    var_7 setModel("offhand_wm_supportbox_killstreak");
    var_7.angles = var_0.angles;
    var_7 setscriptablepartstate("effects", "plant");
    var_7 setscriptablepartstate("anims", "open");
    var_3 scripts\cp\utility::_id_B744("iw8_ges_pickup_br");
    wait 1;
    var_7 delete();
  }
}

_id_6F08(var_0, var_1) {
  var_2 = strtok(var_0, "_");
  var_3 = var_2[1];
  var_4 = var_2[2];
  var_5 = 0;

  switch (var_3) {
    case "ammo":
      var_5 = _id_6EBF(var_0, var_1);
      break;
    case "armor":
      break;
    case "attach":
      break;
    case "health":
      break;
    case "offhand":
      var_5 = _id_6F1E(var_4, var_1);
      break;
    case "weapon":
      var_5 = _id_6EC1(var_0, var_1);
      break;
    case "munition":
      var_5 = _id_6F13(var_0, var_1);
      break;
    default:
      return var_5;
  }

  return var_5;
}

_id_6F13(var_0, var_1) {
  var_2 = strtok(var_0, "_");
  var_3 = "";

  for(var_4 = 2; var_4 < var_2.size; var_4++) {
    if(isDefined(var_2[var_4])) {
      if(var_3 == "") {
        var_3 = var_3 + var_2[var_4];
        continue;
      }

      var_3 = var_3 + "_" + var_2[var_4];
    }
  }

  var_5 = undefined;
  var_6 = var_1 getplayerdata("cp", "inventorySlots", "totalSlots");

  if(var_6 < 4) {
    var_5 = var_6;
  } else {
    var_5 = var_1._id_4EC2 - 1;
  }

  var_7 = _id_646F(var_1);

  if(isDefined(var_7)) {
    var_5 = var_7;
  } else {
    var_1 scripts\cp\utility::_id_7970("munition_slots_full", 1, 2);
    return 0;
  }

  switch (var_3) {
    case "grenade_launcher":
      var_1 _id_0745::_id_6F15("grenade_launcher", var_5);
      return 1;
    case "ammo":
      return var_1 _id_F710(var_3, var_5, "ammo_crate");
    case "turret":
      return var_1 _id_F710(var_3, var_5, "manual_turret");
    case "white_phos":
    case "air_drop":
    case "deployable_cover":
    case "cluster_strike":
    case "trophysystem":
    case "cruise_missile":
    case "uav":
    case "manual_turret":
    case "precision_airstrike":
    case "sentry":
    case "juggernaut":
    case "grenade_crate":
    case "armor":
      return var_1 _id_F710(var_3, var_5);
    default:
      break;
  }

  var_1 iprintlnbold("^1 Can't pick this up unknown munition: " + var_0);
  return 0;
}

_id_F710(var_0, var_1, var_2) {
  var_3 = var_0;

  if(isDefined(var_2)) {
    var_3 = var_2;
  }

  _id_0745::_id_6F15(var_3, var_1);
  return 1;
}

_id_5E50(var_0, var_1) {
  self _meth_80FD(var_0);
  wait(var_1);
  self _meth_80FC();
}

_id_646F(var_0) {
  for(var_1 = 0; var_1 < var_0._id_A2FE.size; var_1++) {
    if(var_0 _id_85B4(var_1)) {
      return var_1;
    }
  }
}

_id_85B4(var_0) {
  var_1 = self;

  if(!isDefined(var_1._id_A2FE)) {
    return 1;
  }

  if(var_1._id_A2FE[var_0]._id_C189 == "none" || var_1._id_A2FE[var_0]._id_C189 == "empty1" || var_1._id_A2FE[var_0]._id_C189 == "empty2" || var_1._id_A2FE[var_0]._id_C189 == "empty3") {
    return 1;
  }

  return 0;
}

_id_6EC1(var_0, var_1) {
  var_2 = var_1 getcurrentweapon();
  var_3 = scripts\cp\utility::getweaponrootname(var_2);
  var_4 = scripts\cp\utility::_id_10D99(var_3);

  if(scripts\engine\utility::array_contains(level._id_1CE5, var_0) && var_4 == "weapon_assault") {
    return _id_6EBF(var_0, var_1);
  } else if(scripts\engine\utility::array_contains(level._id_DE30, var_0) && var_4 == "weapon_smg") {
    return _id_6EBF(var_0, var_1);
  } else if(scripts\engine\utility::array_contains(level._id_DFA3, var_0) && (var_4 == "weapon_sniper" || var_4 == "weapon_dmr")) {
    return _id_6EBF(var_0, var_1);
  } else if(scripts\engine\utility::array_contains(level._id_95A5, var_0) && var_4 == "weapon_lmg") {
    return _id_6EBF(var_0, var_1);
  } else if(scripts\engine\utility::array_contains(level._id_DA55, var_0) && var_4 == "weapon_shotgun") {
    return _id_6EBF(var_0, var_1);
  } else if(scripts\engine\utility::array_contains(level._id_B131, var_0) && var_4 == "weapon_pistol") {
    return _id_6EBF(var_0, var_1);
  } else {
    return 0;
  }
}

_id_6F1E(var_0, var_1) {
  var_2 = "primary";

  switch (var_0) {
    case "smoke":
    case "flash":
      var_2 = "secondary";
      break;
  }

  var_3 = _id_0753::_id_BAA9();

  foreach(var_6, var_5 in var_1._id_BADE) {
    if(var_1._id_BADE[var_6]._id_DDEF == var_2) {
      if(var_1._id_BADE[var_6]._id_3411 + 1 > var_1._id_BADE[var_6]._id_9C5C) {
        return 0;
      }
    }
  }

  var_1 _id_0753::_id_BA96(1, var_2);
  var_1 playlocalsound("weap_ammo_pickup");
  return 1;
}

_id_6EBF(var_0, var_1) {
  return var_1 _id_6EC0();
}

_id_6EC0() {
  var_0 = self getcurrentweapon();
  var_1 = scripts\cp\utility::_id_6CE3(var_0);
  var_2 = weaponclipsize(var_0);

  if(weapontype(var_0) == "riotshield" || scripts\cp\cp_weapon::_id_8607(var_0)) {
    var_3 = self getweaponslistprimaries();

    foreach(var_5 in var_3) {
      if(var_5 == var_0) {
        continue;
      }
      if(!scripts\cp\cp_weapon::_id_8795(var_0)) {
        continue;
      }
      var_2 = weaponclipsize(var_5);
      var_1 = scripts\cp\utility::_id_6CE3(var_5);

      if(self getweaponammostock(var_5) < weaponmaxammo(var_5)) {
        var_6 = self getweaponammostock(var_5);
        self setweaponammostock(var_5, var_2 + var_6);
        self._id_8B35 = getcompleteweaponname(var_5);
      } else if(self getweaponammoclip(var_5) < weaponclipsize(var_5))
        self setweaponammoclip(var_5, weaponclipsize(var_5));
      else {
        return 0;
      }

      return 1;
    }
  } else if(self getweaponammostock(var_0) < weaponmaxammo(var_0)) {
    var_6 = self getweaponammostock(var_0);
    self setweaponammostock(var_0, var_2 + var_6);
    self._id_8B35 = getcompleteweaponname(var_0);
  } else if(self getweaponammoclip(var_0) < weaponclipsize(var_0))
    self setweaponammoclip(var_0, weaponclipsize(var_0));
  else {
    return 0;
  }

  self playlocalsound("weap_ammo_pickup");
  return 1;
}