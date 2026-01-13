/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2890.gsc
************************/

func_12867() {
  level.player scripts\sp\loadout_code::func_F6B5();
  if(!isDefined(level.var_37E7)) {
    level.var_37E7 = "american";
  }

  if(!lib_0A2F::func_9CBB(level.template_script) && !lib_0A2F::is_jackal_arena_level(level.template_script)) {
    func_F3BA(level.template_script);
    if(!_meth_82FA()) {
      var_0 = 0;
      var_1 = lib_0A2F::func_7AF1();
      if(level.template_script == "europa" || !scripts\engine\utility::array_contains(var_1, level.template_script)) {
        var_0 = 1;
      }

      func_F56D(level.template_script, 1, 0, var_0);
      if(!var_0) {
        level.player _meth_84C7("selectedLoadout", 0);
        setleftarc();
      }
    }
  }

  scripts\sp\loadout_code::func_AE27();
}

func_7AA7(var_0) {
  switch (var_0) {
    case "loadout3":
    case "loadout2":
    case "loadout1":
    case "loadout5":
    case "loadout4":
    case "sa_vips":
    case "ja_mining":
    case "ja_asteroid":
    case "ja_wreckage":
    case "ja_titan":
    case "ja_spacestation":
    case "sa_assassination":
    case "sa_wounded":
    case "sa_empambush":
    case "europa":
    case "rogue":
      return var_0;

    case "shipcrib_moon":
    case "shipcrib_epilogue":
    case "marscrib":
    case "shipcrib_prisoner":
    case "shipcrib_rogue":
    case "shipcrib_titan":
    case "shipcrib_europa":
      return "shipcrib";

    case "phstreets":
    case "phparade":
    case "phspace":
      return "pearlharbor";

    case "sa_moon":
    case "moonjackal":
    case "moon_port":
      return "moon_port";

    case "titanjackal":
    case "titan":
      return "titan";

    case "prisoner":
    case "marscrash":
      return "prisoner";

    case "heistspace":
    case "heist":
      return "heist_dev";

    case "yard":
    case "marsbase":
      return "mars";

    default:
      return "default";
  }

  return "default";
}

func_F56D(var_0, var_1, var_2, var_3) {
  var_0 = func_7AA7(var_0);
  var_4 = tablelookup("sp\recommended_loadouts.csv", 0, var_0, 1);
  var_5 = tablelookup("sp\recommended_loadouts.csv", 0, var_0, 2);
  var_6 = strtok(tablelookup("sp\recommended_loadouts.csv", 0, var_0, 4), ", ");
  var_7 = strtok(tablelookup("sp\recommended_loadouts.csv", 0, var_0, 5), ", ");
  var_8 = tablelookup("sp\recommended_loadouts.csv", 0, var_0, 6);
  var_9 = tablelookup("sp\recommended_loadouts.csv", 0, var_0, 7);
  var_0A = tablelookup("sp\recommended_loadouts.csv", 0, var_0, 8);
  if(scripts\sp\utility::func_93A6() && !scripts\sp\specialist_MAYBE::func_2C91()) {
    var_6[1] = var_6[0];
    var_7[1] = var_7[0];
    var_6[0] = "helmet";
    var_7[0] = "nanoshot";
  }

  fix_specialist_loadouts();
  if(isDefined(var_3) && var_3) {
    setlookatent(var_4, var_5, var_6[0], var_7[0], var_6[1], var_7[1]);
    return;
  }

  if(var_0 == "default") {
    setlookatent(var_4);
    return;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(var_1) {
    var_4 = func_79B0(var_4);
    var_5 = func_79B0(var_5);
  }

  func_F467(var_2, var_4, var_5, var_7[0], var_6[0], var_7[1], var_6[1], var_8, var_9, var_0A);
  var_0B = int(tablelookup("sp\recommended_loadouts.csv", 0, var_0, 9));
  if(var_0B == 1) {
    setomnvar("ui_loadouts_disabled", 1);
    return;
  }

  setomnvar("ui_loadouts_disabled", 0);
}

func_F3BA(var_0) {
  var_0 = func_7AA7(var_0);
  var_1 = tablelookup("sp\recommended_loadouts.csv", 0, var_0, 3);
  if(var_1 != "") {
    level.var_72A6 = var_1;
  }
}

func_31CE(var_0, var_1) {
  var_2 = level.player _meth_84C6("loadouts", var_1, "weaponSetups", var_0, "weapon");
  if(!isDefined(var_2) || var_2 == "none" || var_2 == "") {
    return undefined;
  }

  var_3[0] = level.player _meth_84C6("loadouts", var_1, "weaponSetups", var_0, "attachment", 0);
  var_3[1] = level.player _meth_84C6("loadouts", var_1, "weaponSetups", var_0, "attachment", 1);
  var_3[2] = level.player _meth_84C6("loadouts", var_1, "weaponSetups", var_0, "attachment", 2);
  return func_31CD(var_2, var_3);
}

func_31CD(var_0, var_1, var_2) {
  if(!isDefined(var_0) || var_0 == "none" || var_0 == "") {
    return "none";
  }

  if(isDefined(level.var_72A6)) {
    if(!scripts\engine\utility::array_contains(var_1, level.var_72A6)) {
      var_1 = scripts\engine\utility::array_add(var_1, level.var_72A6);
    }
  }

  var_3 = func_7874(var_0, var_1);
  if(isDefined(var_3)) {
    var_1 = scripts\engine\utility::array_add(var_1, level.var_2C81);
    level.var_7655 = var_1;
  }

  var_4 = lib_0A2F::build_attach_models(var_0, "array", undefined, 0, 0, 3, 0, var_1);
  if(isDefined(var_4)) {
    var_0 = var_0 + "+" + var_4;
  }

  return var_0;
}

func_AE39() {
  scripts\engine\utility::waitframe();
  setomnvar("ui_open_loadout_menu", 1);
  setsaveddvar("selectingLoadout", "1");
  level.player _meth_84C7("selectedLoadout", 0);
  for(;;) {
    level.player waittill("luinotifyserver", var_0, var_1);
    if(var_0 == "give_player_loadout" || issubstr(var_0, "give_player_loadout_vr_")) {
      break;
    }
  }

  setomnvar("ui_open_loadout_menu", 0);
  setsaveddvar("selectingLoadout", "0");
  setdvar("loadout_chosen", 1);
  setdvar("loadout_level_name", level.script);
  setdvar("loadout_start_point", level.var_10CDA);
  scripts\engine\utility::waitframe();
  map_restart();
  wait(3);
}

func_7874(var_0, var_1) {
  if(var_0 != "iw7_gambit") {
    return undefined;
  }

  var_2 = lib_0A2F::func_D9F2(0);
  var_2 = scripts\engine\utility::array_remove(var_2, "silencer");
  var_2 = scripts\engine\utility::array_remove(var_2, "akimbo");
  var_2 = scripts\engine\utility::array_remove(var_2, "fastaim");
  var_2 = scripts\engine\utility::array_remove(var_2, "nodualfov");
  var_2 = scripts\engine\utility::array_remove(var_2, "snproverlay");
  var_2 = scripts\engine\utility::array_remove(var_2, "cpu");
  if(isDefined(var_1[0]) && var_1[0] != "none") {
    var_3 = lib_0A2F::func_DA0F();
    var_2 = scripts\engine\utility::array_remove_array(var_2, var_3);
  }

  var_2 = scripts\engine\utility::array_remove_array(var_2, var_1);
  if(var_2.size == 0) {
    return undefined;
  }

  return var_2[randomint(var_2.size)];
}

_meth_82FA() {
  var_0 = level.player _meth_84C6("currentLoadout", "levelCreated");
  if(!isDefined(var_0)) {
    return 0;
  }

  if(isDefined(level.script)) {
    var_1 = scripts\sp\endmission::func_7F6B(level.script);
  } else {
    var_1 = undefined;
  }

  if(!isDefined(var_1) || var_1 != var_0) {
    return 0;
  }

  var_2 = level.player _meth_84C6("currentLoadout", "weaponSetups", 0, "weapon");
  if(getdvarint("skip_loadout") > 0 || !isDefined(var_2) || var_2 == "none") {
    return 0;
  }

  var_3[0] = level.player _meth_84C6("currentLoadout", "weaponSetups", 0, "attachment", 0);
  var_3[1] = level.player _meth_84C6("currentLoadout", "weaponSetups", 0, "attachment", 1);
  var_3[2] = level.player _meth_84C6("currentLoadout", "weaponSetups", 0, "attachment", 2);
  var_4 = level.player _meth_84C6("currentLoadout", "weaponSetups", 1, "weapon");
  var_5[0] = level.player _meth_84C6("currentLoadout", "weaponSetups", 1, "attachment", 0);
  var_5[1] = level.player _meth_84C6("currentLoadout", "weaponSetups", 1, "attachment", 1);
  var_5[2] = level.player _meth_84C6("currentLoadout", "weaponSetups", 1, "attachment", 2);
  var_6 = level.player _meth_84C6("currentLoadout", "equipment", 0);
  var_7 = level.player _meth_84C6("currentLoadout", "offhandEquipment", 0);
  var_8 = level.player _meth_84C6("currentLoadout", "equipment", 1);
  var_9 = level.player _meth_84C6("currentLoadout", "offhandEquipment", 1);
  var_0A = func_31CD(var_2, var_3);
  var_0B = func_31CD(var_4, var_5);
  setlookatent(var_0A, var_0B, var_6, var_7, var_8, var_9);
  var_0C = level.player _meth_84C6("currentLoadout", "weaponClipAmmo", 0);
  var_0D = level.player _meth_84C6("currentLoadout", "weaponStockAmmo", 0);
  var_0E = level.player _meth_84C6("currentLoadout", "weaponClipAmmo", 1);
  var_0F = level.player _meth_84C6("currentLoadout", "weaponStockAmmo", 1);
  level.player setweaponammostock(var_0A, var_0D);
  level.player setweaponammostock(var_0B, var_0F);
  level.player setweaponammoclip(var_0A, var_0C);
  level.player setweaponammoclip(var_0B, var_0E);
  var_10 = level.player _meth_84C6("currentLoadout", "offhandEquipmentAmmo", 0);
  var_11 = level.player _meth_84C6("currentLoadout", "equipmentAmmo", 0);
  var_12 = level.player _meth_84C6("currentLoadout", "offhandEquipmentAmmo", 1);
  var_13 = level.player _meth_84C6("currentLoadout", "equipmentAmmo", 1);
  level.player setweaponammoclip(var_6, var_11);
  level.player setweaponammoclip(var_8, var_13);
  level.player setweaponammoclip(var_7, var_10);
  level.player setweaponammoclip(var_9, var_12);
  return 1;
}

func_7C27(var_0, var_1) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  switch (var_0) {
    case "grapplingdevice":
      if(var_1) {
        return "grapplingdevice";
      } else {
        return undefined;
      }

      break;

    case "trackingfragzerog":
      if(var_1) {
        return "trackingfragzerog";
      } else {
        return undefined;
      }

      break;

    case "frag_up1":
      return "frag";

    case "offhandshield_up1":
      return "offhandshield";

    case "seeker_autohold":
      return "seeker";

    case "supportdrone_up2":
      return "supportdrone";

    default:
      return var_0;
  }
}

func_EB5B() {
  var_0 = scripts\sp\endmission::func_7F6B(level.script);
  if(!isDefined(var_0)) {
    return;
  }

  if(level.script == "europa" || level.script == "marscrash" || level.script == "shipcrib_epilogue") {
    level.player _meth_84C7("currentLoadout", "weaponSetups", 0, "weapon", "none");
    level.player _meth_84C7("currentLoadout", "weaponSetups", 1, "weapon", "none");
    return;
  }

  var_1 = level.player getweaponslistall();
  var_2 = getweaponbasename(level.player getcurrentprimaryweapon());
  if(!isDefined(var_2) || !scripts\engine\utility::array_contains(lib_0A2F::func_DA17(), var_2)) {
    var_2 = "none";
  }

  foreach(var_4 in var_1) {
    var_5 = weaponinventorytype(var_4);
    if(var_5 != "primary") {
      continue;
    }

    var_6 = level.player getweaponammostock(var_4);
    var_7 = level.player getweaponammoclip(var_4);
    var_8 = func_7D6A(var_4);
    var_9 = var_8[0];
    var_0A[0] = var_8[1];
    var_0A[1] = var_8[2];
    var_0A[2] = var_8[3];
    if(!scripts\engine\utility::array_contains(lib_0A2F::func_DA17(), var_9)) {
      continue;
    }

    if(var_2 == var_9 || var_2 == "none") {
      var_0B = 0;
      var_2 = var_9;
      level.player _meth_84C7("currentLoadout", "heldWeapon", var_2);
    } else {
      var_0B = 1;
    }

    level.player _meth_84C7("currentLoadout", "weaponSetups", var_0B, "weapon", var_9);
    level.player _meth_84C7("currentLoadout", "weaponClipAmmo", var_0B, var_7);
    level.player _meth_84C7("currentLoadout", "weaponStockAmmo", var_0B, var_6);
    foreach(var_0E, var_0D in var_0A) {
      level.player _meth_84C7("currentLoadout", "weaponSetups", var_0B, "attachment", var_0E, var_0A[var_0E]);
    }
  }

  var_10 = scripts\sp\utility::func_7BD6();
  var_10 = func_7C27(var_10);
  if(isDefined(var_10)) {
    level.player _meth_84C7("currentLoadout", "offhandEquipment", 0, var_10);
    level.player _meth_84C7("currentLoadout", "offhandEquipmentAmmo", 0, scripts\sp\utility::func_7BD7());
  } else {
    level.player _meth_84C7("currentLoadout", "offhandEquipment", 0, "none");
    level.player _meth_84C7("currentLoadout", "offhandEquipmentAmmo", 0, 0);
  }

  var_10 = scripts\sp\utility::func_7CAF();
  var_10 = func_7C27(var_10);
  if(isDefined(var_10)) {
    level.player _meth_84C7("currentLoadout", "offhandEquipment", 1, var_10);
    level.player _meth_84C7("currentLoadout", "offhandEquipmentAmmo", 1, scripts\sp\utility::func_7CB0());
  } else {
    level.player _meth_84C7("currentLoadout", "offhandEquipment", 1, "none");
    level.player _meth_84C7("currentLoadout", "offhandEquipmentAmmo", 1, 0);
  }

  var_10 = scripts\sp\utility::func_7C3D();
  var_10 = func_7C27(var_10);
  if(isDefined(var_10)) {
    level.player _meth_84C7("currentLoadout", "equipment", 0, var_10);
    level.player _meth_84C7("currentLoadout", "equipmentAmmo", 0, scripts\sp\utility::func_7C3E());
  } else {
    level.player _meth_84C7("currentLoadout", "equipment", 0, "none");
    level.player _meth_84C7("currentLoadout", "equipmentAmmo", 0, 0);
  }

  var_10 = scripts\sp\utility::func_7CB1();
  var_10 = func_7C27(var_10);
  if(isDefined(var_10)) {
    level.player _meth_84C7("currentLoadout", "equipment", 1, var_10);
    level.player _meth_84C7("currentLoadout", "equipmentAmmo", 1, scripts\sp\utility::func_7CB2());
    return;
  }

  level.player _meth_84C7("currentLoadout", "equipment", 1, "none");
  level.player _meth_84C7("currentLoadout", "equipmentAmmo", 1, 0);
}

func_79B0(var_0) {
  var_1 = [];
  var_2 = getweaponbasename(var_0);
  if(!isDefined(var_2)) {
    return var_0;
  }

  if(lib_0A2F::func_DA57(var_2)) {
    return var_0;
  }

  var_3 = getsubstr(var_0, var_2.size);
  switch (var_2) {
    case "iw7_ar57":
      var_1 = ["iw7_m4"];
      break;

    case "iw7_ake":
      var_1 = ["iw7_sdfar", "iw7_fmg", "iw7_m4"];
      break;

    case "iw7_sdfar":
      var_1 = ["iw7_ake", "iw7_fmg", "iw7_m4"];
      break;

    case "iw7_fmg":
      var_1 = ["iw7_ake", "iw7_sdfar", "iw7_m4"];
      break;

    case "iw7_lmg03":
      var_1 = ["iw7_sdflmg", "iw7_mauler", "iw7_ake", "iw7_m4"];
      break;

    case "iw7_sdflmg":
      var_1 = ["iw7_lmg03", "iw7_mauler", "iw7_ake", "iw7_m4"];
      break;

    case "iw7_mauler":
      var_1 = ["iw7_m4"];
      break;

    case "iw7_kbs":
      var_1 = ["iw7_m8"];
      break;

    case "iw7_crb":
      var_1 = ["iw7_ripper", "iw7_fhr"];
      break;

    case "iw7_ump45":
      var_1 = ["iw7_crb", "iw7_erad", "iw7_ripper", "iw7_fhr"];
      break;

    case "iw7_ripper":
    case "iw7_erad":
      var_1 = ["iw7_crb", "iw7_fhr"];
      break;

    case "iw7_devastator":
      var_1 = ["iw7_sdfshotty", "iw7_sonic", "iw7_fhr"];
      break;

    case "iw7_sonic":
      var_1 = ["iw7_sdfshotty", "iw7_devastator", "iw7_fhr"];
      break;

    case "iw7_sdfshotty":
      var_1 = ["iw7_sonic", "iw7_devastator", "iw7_fhr"];
      break;

    case "iw7_emc":
      var_1 = ["iw7_nrg", "iw7_g18"];
      break;

    case "iw7_nrg":
      var_1 = ["iw7_emc", "iw7_g18"];
      break;

    case "iw7_steeldragon":
      var_1 = ["iw7_chargeshot", "iw7_lockon", "iw7_penetrationrail", "iw7_fhr"];
      break;

    case "iw7_lockon":
      var_1 = ["iw7_chargeshot", "iw7_steeldragon", "iw7_penetrationrail", "iw7_fhr"];
      break;

    case "iw7_chargeshot":
      var_1 = ["iw7_lockon", "iw7_steeldragon", "iw7_penetrationrail", "iw7_fhr"];
      break;

    case "iw7_penetrationrail":
      var_1 = ["iw7_penetrationrail", "iw7_steeldragon", "iw7_chargeshot", "iw7_lockon", "iw7_fhr"];
      break;

    case "iw7_atomizer":
      var_1 = ["iw7_penetrationrail", "iw7_steeldragon", "iw7_chargeshot", "iw7_lockon", "iw7_fhr"];
      break;

    default:
      return var_0;
  }

  foreach(var_5 in var_1) {
    if(lib_0A2F::func_DA57(var_5)) {
      return var_5 + var_3;
    }
  }

  return var_0;
}

fix_specialist_loadouts() {
  if(!scripts\sp\utility::func_93A6()) {
    for(var_0 = 1; var_0 < 4; var_0++) {
      var_1 = level.player _meth_84C6("loadouts", var_0, "equipment", 0);
      var_2 = level.player _meth_84C6("loadouts", var_0, "equipment", 1);
      if(isDefined(var_1) && var_1 == "helmet") {
        if(isDefined(var_2) && var_2 == "hackingdevice") {
          level.player _meth_84C7("loadouts", var_0, "equipment", 0, "offhandshield");
          var_1 = "offhandshield";
        } else {
          level.player _meth_84C7("loadouts", var_0, "equipment", 0, "hackingdevice");
          var_1 = "hackingdevice";
        }
      }

      if(isDefined(var_2) && var_2 == "helmet") {
        if(isDefined(var_1) && var_1 == "hackingdevice") {
          level.player _meth_84C7("loadouts", var_0, "equipment", 1, "offhandshield");
        } else {
          level.player _meth_84C7("loadouts", var_0, "equipment", 1, "hackingdevice");
        }
      }

      var_3 = level.player _meth_84C6("loadouts", var_0, "offhandEquipment", 0);
      var_4 = level.player _meth_84C6("loadouts", var_0, "offhandEquipment", 1);
      if(isDefined(var_3) && var_3 == "nanoshot") {
        if(isDefined(var_4) && var_4 == "frag") {
          level.player _meth_84C7("loadouts", var_0, "offhandEquipment", 0, "seeker");
          var_3 = "seeker";
        } else {
          level.player _meth_84C7("loadouts", var_0, "offhandEquipment", 0, "frag");
          var_3 = "frag";
        }
      }

      if(isDefined(var_4) && var_4 == "nanoshot") {
        if(isDefined(var_3) && var_3 == "frag") {
          level.player _meth_84C7("loadouts", var_0, "offhandEquipment", 1, "seeker");
          continue;
        }

        level.player _meth_84C7("loadouts", var_0, "offhandEquipment", 1, "frag");
      }
    }
  }
}

setleftarc() {
  var_0 = level.player _meth_84C6("selectedLoadout");
  if(getdvarint("skip_loadout") > 0 || !isDefined(level.player _meth_84C6("selectedLoadout"))) {
    var_0 = 0;
  } else {
    var_0 = level.player _meth_84C6("selectedLoadout");
  }

  var_1 = level.player _meth_84C6("loadouts", var_0, "weaponSetups", 0, "weapon");
  var_2 = level.player _meth_84C6("loadouts", var_0, "weaponSetups", 1, "weapon");
  var_3 = func_31CE(0, var_0);
  var_4 = func_31CE(1, var_0);
  var_5 = level.player _meth_84C6("loadouts", var_0, "equipment", 0);
  var_6 = level.player _meth_84C6("loadouts", var_0, "offhandEquipment", 0);
  var_7 = level.player _meth_84C6("loadouts", var_0, "equipment", 1);
  var_8 = level.player _meth_84C6("loadouts", var_0, "offhandEquipment", 1);
  setlookatent(var_3, var_4, var_5, var_6, var_7, var_8);
}

setlookatent(var_0, var_1, var_2, var_3, var_4, var_5) {
  level.player takeallweapons();
  var_6 = undefined;
  if(isDefined(var_0) && var_0 != "none" && var_0 != "") {
    var_6 = var_0;
    level.player giveweapon(var_0);
    level.player givemaxammo(var_0);
    if(lib_0A2F::func_DA40(var_0)) {
      level.player setweaponammoclip(var_0, weaponclipsize(var_0));
    }
  }

  if(isDefined(var_1) && var_1 != "none" && var_1 != "") {
    level.player giveweapon(var_1);
    level.player givemaxammo(var_1);
    if(lib_0A2F::func_DA40(var_1)) {
      level.player setweaponammoclip(var_1, weaponclipsize(var_1));
    }
  }

  if(isDefined(var_2) && var_2 != "none") {
    level.player give_player_xp("flash");
    level.player giveweapon(var_2);
    level.player assignweaponoffhandsecondary(var_2);
  }

  if(isDefined(var_3) && var_3 != "none") {
    level.player giveweapon(var_3);
    level.player assignweaponoffhandprimary(var_3);
  }

  if(isDefined(var_4) && var_4 != "none") {
    level.player give_player_xp("flash");
    level.player giveweapon(var_4);
    level.player assignweaponoffhandsecondary(var_4);
  }

  if(isDefined(var_5) && var_5 != "none") {
    level.player giveweapon(var_5);
    level.player assignweaponoffhandprimary(var_5);
  }

  if(!isDefined(var_6)) {
    level.player giveweapon("iw7_ake");
    return;
  }

  level.player enableweapons();
  level.player switchtoweapon(var_6);
}

func_10A4F(var_0) {
  var_1 = "none";
  var_2 = "none";
  var_3 = "none";
  var_4 = strtok(var_0, "+");
  var_5 = var_4[0];
  if(isDefined(var_5) && var_4.size > 1) {
    var_6 = scripts\engine\utility::array_remove(var_4, var_5);
    var_7 = lib_0A2F::func_DA0F();
    foreach(var_9 in var_6) {
      if(scripts\engine\utility::array_contains(var_7, var_9)) {
        var_1 = var_9;
        continue;
      }

      if(var_2 == "none") {
        var_2 = var_9;
        continue;
      }

      if(var_3 == "none") {
        var_3 = var_9;
      }
    }
  }

  return [var_5, var_1, var_2, var_3];
}

func_783F(var_0) {
  if(!isDefined(level.var_D9E5) || isDefined(level.var_D9E5) && !isDefined(level.var_D9E5["attachments"])) {
    var_1 = lib_0A2F::func_DA52();
  } else {
    var_1 = level.var_D9E5["attachments"];
  }

  foreach(var_3 in var_1) {
    foreach(var_5 in var_3) {
      foreach(var_7 in var_5) {
        foreach(var_9 in var_7) {
          if(var_9.var_24A2 == var_0) {
            return var_9;
          }
        }
      }
    }
  }

  return undefined;
}

func_7D6A(var_0) {
  var_1 = "none";
  var_2 = "none";
  var_3 = "none";
  var_4 = getweaponbasename(var_0);
  var_5 = strtok(var_0, "+");
  var_6 = [];
  if(isDefined(var_4) && isDefined(var_5)) {
    var_5 = scripts\engine\utility::array_remove(var_5, var_4);
    foreach(var_8 in var_5) {
      if(var_8 == "smartar") {
        var_8 = "smart";
      } else if(var_8 == "eloshtgnepicdev") {
        var_8 = "eloshtgn";
      } else if(var_8 == "phaseshotgunepicdev_sp") {
        var_8 = "phaseshotgun_sp";
      } else if(var_8 == "reflexshotgunepicdev") {
        var_8 = "reflexshotgun";
      } else if(var_8 == "epicdevastatorads") {
        continue;
      } else if(var_8 == "elopstlepicemc") {
        var_8 = "elopstl";
      } else if(var_8 == "phasepstlepicemc_sp") {
        var_8 = "phasepstl_sp";
      } else if(var_8 == "reflexpstlepicemc") {
        var_8 = "reflexpstl";
      } else if(var_8 == "epicemcads") {
        continue;
      }

      var_9 = func_783F(var_8);
      if(!isDefined(var_9)) {
        continue;
      }

      if(var_4 == "iw7_gambit" && isDefined(level.var_7655) && level.var_7655 == var_8) {
        continue;
      }

      if(var_9.var_13CDE == "default" || var_9.baseangles == "zerog") {
        continue;
      } else {
        if(var_9.location == "rail") {
          var_1 = var_9.baseangles;
          continue;
        }

        var_6 = scripts\engine\utility::array_add(var_6, var_9.baseangles);
      }
    }
  }

  if(var_6.size > 2) {
    if(isDefined(level.var_72A6)) {
      var_6 = scripts\engine\utility::array_remove(var_6, level.var_72A6);
    }
  }

  foreach(var_0C in var_6) {
    if(var_2 == "none") {
      var_2 = var_0C;
      continue;
    }

    if(var_3 == "none") {
      var_3 = var_0C;
    }
  }

  return [var_4, var_1, var_2, var_3];
}

func_F33B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  func_F467(0, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

func_F467(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_0A = func_10A4F(var_1);
  var_1 = var_0A[0];
  var_0B = var_0A[1];
  var_0C = var_0A[2];
  var_0D = var_0A[3];
  var_0A = func_10A4F(var_2);
  var_2 = var_0A[0];
  var_0E = var_0A[1];
  var_0F = var_0A[2];
  var_10 = var_0A[3];
  if(isDefined(var_1) && var_1 != "") {
    level.player _meth_84C7("loadouts", var_0, "weaponSetups", 0, "weapon", var_1);
  } else {
    level.player _meth_84C7("loadouts", var_0, "weaponSetups", 0, "weapon", "none");
  }

  if(isDefined(var_1) && var_1 != "" && isDefined(var_0B)) {
    level.player _meth_84C7("loadouts", var_0, "weaponSetups", 0, "attachment", 0, var_0B);
  } else {
    level.player _meth_84C7("loadouts", var_0, "weaponSetups", 0, "attachment", 0, "none");
  }

  if(isDefined(var_1) && var_1 != "" && isDefined(var_0C)) {
    level.player _meth_84C7("loadouts", var_0, "weaponSetups", 0, "attachment", 1, var_0C);
  } else {
    level.player _meth_84C7("loadouts", var_0, "weaponSetups", 0, "attachment", 1, "none");
  }

  if(isDefined(var_1) && var_1 != "" && isDefined(var_0D)) {
    level.player _meth_84C7("loadouts", var_0, "weaponSetups", 0, "attachment", 2, var_0D);
  } else {
    level.player _meth_84C7("loadouts", var_0, "weaponSetups", 0, "attachment", 2, "none");
  }

  if(isDefined(var_2) && var_2 != "") {
    level.player _meth_84C7("loadouts", var_0, "weaponSetups", 1, "weapon", var_2);
  } else {
    level.player _meth_84C7("loadouts", var_0, "weaponSetups", 1, "weapon", "none");
  }

  if(isDefined(var_2) && var_2 != "" && isDefined(var_0E)) {
    level.player _meth_84C7("loadouts", var_0, "weaponSetups", 1, "attachment", 0, var_0E);
  } else {
    level.player _meth_84C7("loadouts", var_0, "weaponSetups", 1, "attachment", 0, "none");
  }

  if(isDefined(var_2) && var_2 != "" && isDefined(var_0F)) {
    level.player _meth_84C7("loadouts", var_0, "weaponSetups", 1, "attachment", 1, var_0F);
  } else {
    level.player _meth_84C7("loadouts", var_0, "weaponSetups", 1, "attachment", 1, "none");
  }

  if(isDefined(var_2) && var_2 != "" && isDefined(var_10)) {
    level.player _meth_84C7("loadouts", var_0, "weaponSetups", 1, "attachment", 2, var_10);
  } else {
    level.player _meth_84C7("loadouts", var_0, "weaponSetups", 1, "attachment", 2, "none");
  }

  if(isDefined(var_4) && var_4 != "") {
    level.player _meth_84C7("loadouts", var_0, "equipment", 0, var_4);
  } else {
    level.player _meth_84C7("loadouts", var_0, "equipment", 0, "none");
  }

  if(isDefined(var_3) && var_3 != "") {
    level.player _meth_84C7("loadouts", var_0, "offhandEquipment", 0, var_3);
  } else {
    level.player _meth_84C7("loadouts", var_0, "offhandEquipment", 0, "none");
  }

  if(isDefined(var_6) && var_6 != "") {
    level.player _meth_84C7("loadouts", var_0, "equipment", 1, var_6);
  } else {
    level.player _meth_84C7("loadouts", var_0, "equipment", 1, "none");
  }

  if(isDefined(var_5) && var_5 != "") {
    level.player _meth_84C7("loadouts", var_0, "offhandEquipment", 1, var_5);
  } else {
    level.player _meth_84C7("loadouts", var_0, "offhandEquipment", 1, "none");
  }

  var_11 = level.player _meth_84C6("loadouts", var_0, "jackalSetup", "jackalDecal");
  if(!isDefined(var_11) || var_11 == "" || var_11 == "none") {
    level.player _meth_84C7("loadouts", var_0, "jackalSetup", "jackalDecal", "veh_mil_air_un_jackal_livery_shell_01");
    if(isDefined(var_7) && var_7 != "") {
      level.player _meth_84C7("loadouts", var_0, "jackalSetup", "jackalPrimary", var_7);
    } else {
      level.player _meth_84C7("loadouts", var_0, "jackalSetup", "jackalPrimary", "primary_default");
    }

    if(isDefined(var_8) && var_8 != "") {
      level.player _meth_84C7("loadouts", var_0, "jackalSetup", "jackalSecondary", var_8);
    } else {
      level.player _meth_84C7("loadouts", var_0, "jackalSetup", "jackalSecondary", "secondary_default");
    }

    if(isDefined(var_9) && var_9 != "") {
      level.player _meth_84C7("loadouts", var_0, "jackalSetup", "jackalUpgrade", var_9);
      return;
    }

    level.player _meth_84C7("loadouts", var_0, "jackalSetup", "jackalUpgrade", "hull");
  }
}