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
      var_00 = 0;
      var_01 = lib_0A2F::func_7AF1();
      if(level.template_script == "europa" || !scripts\engine\utility::array_contains(var_01, level.template_script)) {
        var_00 = 1;
      }

      func_F56D(level.template_script, 1, 0, var_00);
      if(!var_00) {
        level.player _meth_84C7("selectedLoadout", 0);
        setleftarc();
      }
    }
  }

  scripts\sp\loadout_code::func_AE27();
}

func_7AA7(param_00) {
  switch (param_00) {
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
      return param_00;

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

func_F56D(param_00, param_01, param_02, param_03) {
  param_00 = func_7AA7(param_00);
  var_04 = tablelookup("sp\recommended_loadouts.csv", 0, param_00, 1);
  var_05 = tablelookup("sp\recommended_loadouts.csv", 0, param_00, 2);
  var_06 = strtok(tablelookup("sp\recommended_loadouts.csv", 0, param_00, 4), ", ");
  var_07 = strtok(tablelookup("sp\recommended_loadouts.csv", 0, param_00, 5), ", ");
  var_08 = tablelookup("sp\recommended_loadouts.csv", 0, param_00, 6);
  var_09 = tablelookup("sp\recommended_loadouts.csv", 0, param_00, 7);
  var_0A = tablelookup("sp\recommended_loadouts.csv", 0, param_00, 8);
  if(scripts\sp\utility::func_93A6() && !scripts\sp\specialist_MAYBE::func_2C91()) {
    var_06[1] = var_06[0];
    var_07[1] = var_07[0];
    var_06[0] = "helmet";
    var_07[0] = "nanoshot";
  }

  fix_specialist_loadouts();
  if(isDefined(param_03) && param_03) {
    setlookatent(var_04, var_05, var_06[0], var_07[0], var_06[1], var_07[1]);
    return;
  }

  if(param_00 == "default") {
    setlookatent(var_04);
    return;
  }

  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(param_01) {
    var_04 = func_79B0(var_04);
    var_05 = func_79B0(var_05);
  }

  func_F467(param_02, var_04, var_05, var_07[0], var_06[0], var_07[1], var_06[1], var_08, var_09, var_0A);
  var_0B = int(tablelookup("sp\recommended_loadouts.csv", 0, param_00, 9));
  if(var_0B == 1) {
    setomnvar("ui_loadouts_disabled", 1);
    return;
  }

  setomnvar("ui_loadouts_disabled", 0);
}

func_F3BA(param_00) {
  param_00 = func_7AA7(param_00);
  var_01 = tablelookup("sp\recommended_loadouts.csv", 0, param_00, 3);
  if(var_01 != "") {
    level.var_72A6 = var_01;
  }
}

func_31CE(param_00, param_01) {
  var_02 = level.player _meth_84C6("loadouts", param_01, "weaponSetups", param_00, "weapon");
  if(!isDefined(var_02) || var_02 == "none" || var_02 == "") {
    return undefined;
  }

  var_03[0] = level.player _meth_84C6("loadouts", param_01, "weaponSetups", param_00, "attachment", 0);
  var_03[1] = level.player _meth_84C6("loadouts", param_01, "weaponSetups", param_00, "attachment", 1);
  var_03[2] = level.player _meth_84C6("loadouts", param_01, "weaponSetups", param_00, "attachment", 2);
  return func_31CD(var_02, var_03);
}

func_31CD(param_00, param_01, param_02) {
  if(!isDefined(param_00) || param_00 == "none" || param_00 == "") {
    return "none";
  }

  if(isDefined(level.var_72A6)) {
    if(!scripts\engine\utility::array_contains(param_01, level.var_72A6)) {
      param_01 = scripts\engine\utility::array_add(param_01, level.var_72A6);
    }
  }

  var_03 = func_7874(param_00, param_01);
  if(isDefined(var_03)) {
    param_01 = scripts\engine\utility::array_add(param_01, level.var_2C81);
    level.var_7655 = param_01;
  }

  var_04 = lib_0A2F::build_attach_models(param_00, "array", undefined, 0, 0, 3, 0, param_01);
  if(isDefined(var_04)) {
    param_00 = param_00 + "+" + var_04;
  }

  return param_00;
}

func_AE39() {
  scripts\engine\utility::waitframe();
  setomnvar("ui_open_loadout_menu", 1);
  setsaveddvar("selectingLoadout", "1");
  level.player _meth_84C7("selectedLoadout", 0);
  for(;;) {
    level.player waittill("luinotifyserver", var_00, var_01);
    if(var_00 == "give_player_loadout" || issubstr(var_00, "give_player_loadout_vr_")) {
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

func_7874(param_00, param_01) {
  if(param_00 != "iw7_gambit") {
    return undefined;
  }

  var_02 = lib_0A2F::func_D9F2(0);
  var_02 = scripts\engine\utility::array_remove(var_02, "silencer");
  var_02 = scripts\engine\utility::array_remove(var_02, "akimbo");
  var_02 = scripts\engine\utility::array_remove(var_02, "fastaim");
  var_02 = scripts\engine\utility::array_remove(var_02, "nodualfov");
  var_02 = scripts\engine\utility::array_remove(var_02, "snproverlay");
  var_02 = scripts\engine\utility::array_remove(var_02, "cpu");
  if(isDefined(param_01[0]) && param_01[0] != "none") {
    var_03 = lib_0A2F::func_DA0F();
    var_02 = scripts\engine\utility::array_remove_array(var_02, var_03);
  }

  var_02 = scripts\engine\utility::array_remove_array(var_02, param_01);
  if(var_02.size == 0) {
    return undefined;
  }

  return var_02[randomint(var_02.size)];
}

_meth_82FA() {
  var_00 = level.player _meth_84C6("currentLoadout", "levelCreated");
  if(!isDefined(var_00)) {
    return 0;
  }

  if(isDefined(level.script)) {
    var_01 = scripts\sp\endmission::func_7F6B(level.script);
  } else {
    var_01 = undefined;
  }

  if(!isDefined(var_01) || var_01 != var_00) {
    return 0;
  }

  var_02 = level.player _meth_84C6("currentLoadout", "weaponSetups", 0, "weapon");
  if(getdvarint("skip_loadout") > 0 || !isDefined(var_02) || var_02 == "none") {
    return 0;
  }

  var_03[0] = level.player _meth_84C6("currentLoadout", "weaponSetups", 0, "attachment", 0);
  var_03[1] = level.player _meth_84C6("currentLoadout", "weaponSetups", 0, "attachment", 1);
  var_03[2] = level.player _meth_84C6("currentLoadout", "weaponSetups", 0, "attachment", 2);
  var_04 = level.player _meth_84C6("currentLoadout", "weaponSetups", 1, "weapon");
  var_05[0] = level.player _meth_84C6("currentLoadout", "weaponSetups", 1, "attachment", 0);
  var_05[1] = level.player _meth_84C6("currentLoadout", "weaponSetups", 1, "attachment", 1);
  var_05[2] = level.player _meth_84C6("currentLoadout", "weaponSetups", 1, "attachment", 2);
  var_06 = level.player _meth_84C6("currentLoadout", "equipment", 0);
  var_07 = level.player _meth_84C6("currentLoadout", "offhandEquipment", 0);
  var_08 = level.player _meth_84C6("currentLoadout", "equipment", 1);
  var_09 = level.player _meth_84C6("currentLoadout", "offhandEquipment", 1);
  var_0A = func_31CD(var_02, var_03);
  var_0B = func_31CD(var_04, var_05);
  setlookatent(var_0A, var_0B, var_06, var_07, var_08, var_09);
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
  level.player setweaponammoclip(var_06, var_11);
  level.player setweaponammoclip(var_08, var_13);
  level.player setweaponammoclip(var_07, var_10);
  level.player setweaponammoclip(var_09, var_12);
  return 1;
}

func_7C27(param_00, param_01) {
  if(!isDefined(param_00)) {
    return undefined;
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  switch (param_00) {
    case "grapplingdevice":
      if(param_01) {
        return "grapplingdevice";
      } else {
        return undefined;
      }

      break;

    case "trackingfragzerog":
      if(param_01) {
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
      return param_00;
  }
}

func_EB5B() {
  var_00 = scripts\sp\endmission::func_7F6B(level.script);
  if(!isDefined(var_00)) {
    return;
  }

  if(level.script == "europa" || level.script == "marscrash" || level.script == "shipcrib_epilogue") {
    level.player _meth_84C7("currentLoadout", "weaponSetups", 0, "weapon", "none");
    level.player _meth_84C7("currentLoadout", "weaponSetups", 1, "weapon", "none");
    return;
  }

  var_01 = level.player getweaponslistall();
  var_02 = getweaponbasename(level.player getcurrentprimaryweapon());
  if(!isDefined(var_02) || !scripts\engine\utility::array_contains(lib_0A2F::func_DA17(), var_02)) {
    var_02 = "none";
  }

  foreach(var_04 in var_01) {
    var_05 = weaponinventorytype(var_04);
    if(var_05 != "primary") {
      continue;
    }

    var_06 = level.player getweaponammostock(var_04);
    var_07 = level.player getweaponammoclip(var_04);
    var_08 = func_7D6A(var_04);
    var_09 = var_08[0];
    var_0A[0] = var_08[1];
    var_0A[1] = var_08[2];
    var_0A[2] = var_08[3];
    if(!scripts\engine\utility::array_contains(lib_0A2F::func_DA17(), var_09)) {
      continue;
    }

    if(var_02 == var_09 || var_02 == "none") {
      var_0B = 0;
      var_02 = var_09;
      level.player _meth_84C7("currentLoadout", "heldWeapon", var_02);
    } else {
      var_0B = 1;
    }

    level.player _meth_84C7("currentLoadout", "weaponSetups", var_0B, "weapon", var_09);
    level.player _meth_84C7("currentLoadout", "weaponClipAmmo", var_0B, var_07);
    level.player _meth_84C7("currentLoadout", "weaponStockAmmo", var_0B, var_06);
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

func_79B0(param_00) {
  var_01 = [];
  var_02 = getweaponbasename(param_00);
  if(!isDefined(var_02)) {
    return param_00;
  }

  if(lib_0A2F::func_DA57(var_02)) {
    return param_00;
  }

  var_03 = getsubstr(param_00, var_02.size);
  switch (var_02) {
    case "iw7_ar57":
      var_01 = ["iw7_m4"];
      break;

    case "iw7_ake":
      var_01 = ["iw7_sdfar", "iw7_fmg", "iw7_m4"];
      break;

    case "iw7_sdfar":
      var_01 = ["iw7_ake", "iw7_fmg", "iw7_m4"];
      break;

    case "iw7_fmg":
      var_01 = ["iw7_ake", "iw7_sdfar", "iw7_m4"];
      break;

    case "iw7_lmg03":
      var_01 = ["iw7_sdflmg", "iw7_mauler", "iw7_ake", "iw7_m4"];
      break;

    case "iw7_sdflmg":
      var_01 = ["iw7_lmg03", "iw7_mauler", "iw7_ake", "iw7_m4"];
      break;

    case "iw7_mauler":
      var_01 = ["iw7_m4"];
      break;

    case "iw7_kbs":
      var_01 = ["iw7_m8"];
      break;

    case "iw7_crb":
      var_01 = ["iw7_ripper", "iw7_fhr"];
      break;

    case "iw7_ump45":
      var_01 = ["iw7_crb", "iw7_erad", "iw7_ripper", "iw7_fhr"];
      break;

    case "iw7_ripper":
    case "iw7_erad":
      var_01 = ["iw7_crb", "iw7_fhr"];
      break;

    case "iw7_devastator":
      var_01 = ["iw7_sdfshotty", "iw7_sonic", "iw7_fhr"];
      break;

    case "iw7_sonic":
      var_01 = ["iw7_sdfshotty", "iw7_devastator", "iw7_fhr"];
      break;

    case "iw7_sdfshotty":
      var_01 = ["iw7_sonic", "iw7_devastator", "iw7_fhr"];
      break;

    case "iw7_emc":
      var_01 = ["iw7_nrg", "iw7_g18"];
      break;

    case "iw7_nrg":
      var_01 = ["iw7_emc", "iw7_g18"];
      break;

    case "iw7_steeldragon":
      var_01 = ["iw7_chargeshot", "iw7_lockon", "iw7_penetrationrail", "iw7_fhr"];
      break;

    case "iw7_lockon":
      var_01 = ["iw7_chargeshot", "iw7_steeldragon", "iw7_penetrationrail", "iw7_fhr"];
      break;

    case "iw7_chargeshot":
      var_01 = ["iw7_lockon", "iw7_steeldragon", "iw7_penetrationrail", "iw7_fhr"];
      break;

    case "iw7_penetrationrail":
      var_01 = ["iw7_penetrationrail", "iw7_steeldragon", "iw7_chargeshot", "iw7_lockon", "iw7_fhr"];
      break;

    case "iw7_atomizer":
      var_01 = ["iw7_penetrationrail", "iw7_steeldragon", "iw7_chargeshot", "iw7_lockon", "iw7_fhr"];
      break;

    default:
      return param_00;
  }

  foreach(var_05 in var_01) {
    if(lib_0A2F::func_DA57(var_05)) {
      return var_05 + var_03;
    }
  }

  return param_00;
}

fix_specialist_loadouts() {
  if(!scripts\sp\utility::func_93A6()) {
    for(var_00 = 1; var_00 < 4; var_00++) {
      var_01 = level.player _meth_84C6("loadouts", var_00, "equipment", 0);
      var_02 = level.player _meth_84C6("loadouts", var_00, "equipment", 1);
      if(isDefined(var_01) && var_01 == "helmet") {
        if(isDefined(var_02) && var_02 == "hackingdevice") {
          level.player _meth_84C7("loadouts", var_00, "equipment", 0, "offhandshield");
          var_01 = "offhandshield";
        } else {
          level.player _meth_84C7("loadouts", var_00, "equipment", 0, "hackingdevice");
          var_01 = "hackingdevice";
        }
      }

      if(isDefined(var_02) && var_02 == "helmet") {
        if(isDefined(var_01) && var_01 == "hackingdevice") {
          level.player _meth_84C7("loadouts", var_00, "equipment", 1, "offhandshield");
        } else {
          level.player _meth_84C7("loadouts", var_00, "equipment", 1, "hackingdevice");
        }
      }

      var_03 = level.player _meth_84C6("loadouts", var_00, "offhandEquipment", 0);
      var_04 = level.player _meth_84C6("loadouts", var_00, "offhandEquipment", 1);
      if(isDefined(var_03) && var_03 == "nanoshot") {
        if(isDefined(var_04) && var_04 == "frag") {
          level.player _meth_84C7("loadouts", var_00, "offhandEquipment", 0, "seeker");
          var_03 = "seeker";
        } else {
          level.player _meth_84C7("loadouts", var_00, "offhandEquipment", 0, "frag");
          var_03 = "frag";
        }
      }

      if(isDefined(var_04) && var_04 == "nanoshot") {
        if(isDefined(var_03) && var_03 == "frag") {
          level.player _meth_84C7("loadouts", var_00, "offhandEquipment", 1, "seeker");
          continue;
        }

        level.player _meth_84C7("loadouts", var_00, "offhandEquipment", 1, "frag");
      }
    }
  }
}

setleftarc() {
  var_00 = level.player _meth_84C6("selectedLoadout");
  if(getdvarint("skip_loadout") > 0 || !isDefined(level.player _meth_84C6("selectedLoadout"))) {
    var_00 = 0;
  } else {
    var_00 = level.player _meth_84C6("selectedLoadout");
  }

  var_01 = level.player _meth_84C6("loadouts", var_00, "weaponSetups", 0, "weapon");
  var_02 = level.player _meth_84C6("loadouts", var_00, "weaponSetups", 1, "weapon");
  var_03 = func_31CE(0, var_00);
  var_04 = func_31CE(1, var_00);
  var_05 = level.player _meth_84C6("loadouts", var_00, "equipment", 0);
  var_06 = level.player _meth_84C6("loadouts", var_00, "offhandEquipment", 0);
  var_07 = level.player _meth_84C6("loadouts", var_00, "equipment", 1);
  var_08 = level.player _meth_84C6("loadouts", var_00, "offhandEquipment", 1);
  setlookatent(var_03, var_04, var_05, var_06, var_07, var_08);
}

setlookatent(param_00, param_01, param_02, param_03, param_04, param_05) {
  level.player takeallweapons();
  var_06 = undefined;
  if(isDefined(param_00) && param_00 != "none" && param_00 != "") {
    var_06 = param_00;
    level.player giveweapon(param_00);
    level.player givemaxammo(param_00);
    if(lib_0A2F::func_DA40(param_00)) {
      level.player setweaponammoclip(param_00, weaponclipsize(param_00));
    }
  }

  if(isDefined(param_01) && param_01 != "none" && param_01 != "") {
    level.player giveweapon(param_01);
    level.player givemaxammo(param_01);
    if(lib_0A2F::func_DA40(param_01)) {
      level.player setweaponammoclip(param_01, weaponclipsize(param_01));
    }
  }

  if(isDefined(param_02) && param_02 != "none") {
    level.player give_player_xp("flash");
    level.player giveweapon(param_02);
    level.player assignweaponoffhandsecondary(param_02);
  }

  if(isDefined(param_03) && param_03 != "none") {
    level.player giveweapon(param_03);
    level.player assignweaponoffhandprimary(param_03);
  }

  if(isDefined(param_04) && param_04 != "none") {
    level.player give_player_xp("flash");
    level.player giveweapon(param_04);
    level.player assignweaponoffhandsecondary(param_04);
  }

  if(isDefined(param_05) && param_05 != "none") {
    level.player giveweapon(param_05);
    level.player assignweaponoffhandprimary(param_05);
  }

  if(!isDefined(var_06)) {
    level.player giveweapon("iw7_ake");
    return;
  }

  level.player enableweapons();
  level.player switchtoweapon(var_06);
}

func_10A4F(param_00) {
  var_01 = "none";
  var_02 = "none";
  var_03 = "none";
  var_04 = strtok(param_00, "+");
  var_05 = var_04[0];
  if(isDefined(var_05) && var_04.size > 1) {
    var_06 = scripts\engine\utility::array_remove(var_04, var_05);
    var_07 = lib_0A2F::func_DA0F();
    foreach(var_09 in var_06) {
      if(scripts\engine\utility::array_contains(var_07, var_09)) {
        var_01 = var_09;
        continue;
      }

      if(var_02 == "none") {
        var_02 = var_09;
        continue;
      }

      if(var_03 == "none") {
        var_03 = var_09;
      }
    }
  }

  return [var_05, var_01, var_02, var_03];
}

func_783F(param_00) {
  if(!isDefined(level.var_D9E5) || isDefined(level.var_D9E5) && !isDefined(level.var_D9E5["attachments"])) {
    var_01 = lib_0A2F::func_DA52();
  } else {
    var_01 = level.var_D9E5["attachments"];
  }

  foreach(var_03 in var_01) {
    foreach(var_05 in var_03) {
      foreach(var_07 in var_05) {
        foreach(var_09 in var_07) {
          if(var_09.var_24A2 == param_00) {
            return var_09;
          }
        }
      }
    }
  }

  return undefined;
}

func_7D6A(param_00) {
  var_01 = "none";
  var_02 = "none";
  var_03 = "none";
  var_04 = getweaponbasename(param_00);
  var_05 = strtok(param_00, "+");
  var_06 = [];
  if(isDefined(var_04) && isDefined(var_05)) {
    var_05 = scripts\engine\utility::array_remove(var_05, var_04);
    foreach(var_08 in var_05) {
      if(var_08 == "smartar") {
        var_08 = "smart";
      } else if(var_08 == "eloshtgnepicdev") {
        var_08 = "eloshtgn";
      } else if(var_08 == "phaseshotgunepicdev_sp") {
        var_08 = "phaseshotgun_sp";
      } else if(var_08 == "reflexshotgunepicdev") {
        var_08 = "reflexshotgun";
      } else if(var_08 == "epicdevastatorads") {
        continue;
      } else if(var_08 == "elopstlepicemc") {
        var_08 = "elopstl";
      } else if(var_08 == "phasepstlepicemc_sp") {
        var_08 = "phasepstl_sp";
      } else if(var_08 == "reflexpstlepicemc") {
        var_08 = "reflexpstl";
      } else if(var_08 == "epicemcads") {
        continue;
      }

      var_09 = func_783F(var_08);
      if(!isDefined(var_09)) {
        continue;
      }

      if(var_04 == "iw7_gambit" && isDefined(level.var_7655) && level.var_7655 == var_08) {
        continue;
      }

      if(var_09.var_13CDE == "default" || var_09.baseangles == "zerog") {
        continue;
      } else {
        if(var_09.location == "rail") {
          var_01 = var_09.baseangles;
          continue;
        }

        var_06 = scripts\engine\utility::array_add(var_06, var_09.baseangles);
      }
    }
  }

  if(var_06.size > 2) {
    if(isDefined(level.var_72A6)) {
      var_06 = scripts\engine\utility::array_remove(var_06, level.var_72A6);
    }
  }

  foreach(var_0C in var_06) {
    if(var_02 == "none") {
      var_02 = var_0C;
      continue;
    }

    if(var_03 == "none") {
      var_03 = var_0C;
    }
  }

  return [var_04, var_01, var_02, var_03];
}

func_F33B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  func_F467(0, param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
}

func_F467(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  var_0A = func_10A4F(param_01);
  param_01 = var_0A[0];
  var_0B = var_0A[1];
  var_0C = var_0A[2];
  var_0D = var_0A[3];
  var_0A = func_10A4F(param_02);
  param_02 = var_0A[0];
  var_0E = var_0A[1];
  var_0F = var_0A[2];
  var_10 = var_0A[3];
  if(isDefined(param_01) && param_01 != "") {
    level.player _meth_84C7("loadouts", param_00, "weaponSetups", 0, "weapon", param_01);
  } else {
    level.player _meth_84C7("loadouts", param_00, "weaponSetups", 0, "weapon", "none");
  }

  if(isDefined(param_01) && param_01 != "" && isDefined(var_0B)) {
    level.player _meth_84C7("loadouts", param_00, "weaponSetups", 0, "attachment", 0, var_0B);
  } else {
    level.player _meth_84C7("loadouts", param_00, "weaponSetups", 0, "attachment", 0, "none");
  }

  if(isDefined(param_01) && param_01 != "" && isDefined(var_0C)) {
    level.player _meth_84C7("loadouts", param_00, "weaponSetups", 0, "attachment", 1, var_0C);
  } else {
    level.player _meth_84C7("loadouts", param_00, "weaponSetups", 0, "attachment", 1, "none");
  }

  if(isDefined(param_01) && param_01 != "" && isDefined(var_0D)) {
    level.player _meth_84C7("loadouts", param_00, "weaponSetups", 0, "attachment", 2, var_0D);
  } else {
    level.player _meth_84C7("loadouts", param_00, "weaponSetups", 0, "attachment", 2, "none");
  }

  if(isDefined(param_02) && param_02 != "") {
    level.player _meth_84C7("loadouts", param_00, "weaponSetups", 1, "weapon", param_02);
  } else {
    level.player _meth_84C7("loadouts", param_00, "weaponSetups", 1, "weapon", "none");
  }

  if(isDefined(param_02) && param_02 != "" && isDefined(var_0E)) {
    level.player _meth_84C7("loadouts", param_00, "weaponSetups", 1, "attachment", 0, var_0E);
  } else {
    level.player _meth_84C7("loadouts", param_00, "weaponSetups", 1, "attachment", 0, "none");
  }

  if(isDefined(param_02) && param_02 != "" && isDefined(var_0F)) {
    level.player _meth_84C7("loadouts", param_00, "weaponSetups", 1, "attachment", 1, var_0F);
  } else {
    level.player _meth_84C7("loadouts", param_00, "weaponSetups", 1, "attachment", 1, "none");
  }

  if(isDefined(param_02) && param_02 != "" && isDefined(var_10)) {
    level.player _meth_84C7("loadouts", param_00, "weaponSetups", 1, "attachment", 2, var_10);
  } else {
    level.player _meth_84C7("loadouts", param_00, "weaponSetups", 1, "attachment", 2, "none");
  }

  if(isDefined(param_04) && param_04 != "") {
    level.player _meth_84C7("loadouts", param_00, "equipment", 0, param_04);
  } else {
    level.player _meth_84C7("loadouts", param_00, "equipment", 0, "none");
  }

  if(isDefined(param_03) && param_03 != "") {
    level.player _meth_84C7("loadouts", param_00, "offhandEquipment", 0, param_03);
  } else {
    level.player _meth_84C7("loadouts", param_00, "offhandEquipment", 0, "none");
  }

  if(isDefined(param_06) && param_06 != "") {
    level.player _meth_84C7("loadouts", param_00, "equipment", 1, param_06);
  } else {
    level.player _meth_84C7("loadouts", param_00, "equipment", 1, "none");
  }

  if(isDefined(param_05) && param_05 != "") {
    level.player _meth_84C7("loadouts", param_00, "offhandEquipment", 1, param_05);
  } else {
    level.player _meth_84C7("loadouts", param_00, "offhandEquipment", 1, "none");
  }

  var_11 = level.player _meth_84C6("loadouts", param_00, "jackalSetup", "jackalDecal");
  if(!isDefined(var_11) || var_11 == "" || var_11 == "none") {
    level.player _meth_84C7("loadouts", param_00, "jackalSetup", "jackalDecal", "veh_mil_air_un_jackal_livery_shell_01");
    if(isDefined(param_07) && param_07 != "") {
      level.player _meth_84C7("loadouts", param_00, "jackalSetup", "jackalPrimary", param_07);
    } else {
      level.player _meth_84C7("loadouts", param_00, "jackalSetup", "jackalPrimary", "primary_default");
    }

    if(isDefined(param_08) && param_08 != "") {
      level.player _meth_84C7("loadouts", param_00, "jackalSetup", "jackalSecondary", param_08);
    } else {
      level.player _meth_84C7("loadouts", param_00, "jackalSetup", "jackalSecondary", "secondary_default");
    }

    if(isDefined(param_09) && param_09 != "") {
      level.player _meth_84C7("loadouts", param_00, "jackalSetup", "jackalUpgrade", param_09);
      return;
    }

    level.player _meth_84C7("loadouts", param_00, "jackalSetup", "jackalUpgrade", "hull");
  }
}