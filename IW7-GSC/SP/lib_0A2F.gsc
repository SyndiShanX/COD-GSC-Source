/***************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\lib_0A2F.gsc
***************************/

func_7AF1(param_00, param_01) {
  var_02 = ["yard", "mars", "heist", "prisoner", "rogue", "titan", "sa_moon", "moon_port", "pearlharbor", "europa"];
  var_03 = ["sa_assassination", "sa_empambush", "sa_vips", "sa_wounded", "ja_spacestation", "ja_asteroid", "ja_mining", "ja_titan", "ja_wreckage"];
  var_04 = ["shipcrib_epilogue", "shipcrib_titan", "shipcrib_europa", "shipcrib_moon", "shipcrib_rogue", "shipcrib_prisoner", "phparade", "phspace", "phstreets", "marscrash", "marscrib", "marsbase", "moonjackal", "titanjackal", "heistspace"];
  if((isDefined(param_00) && param_00 == "main") || isDefined(param_01) && param_01 == "main") {
    var_02 = [];
  }

  if((isDefined(param_00) && param_00 == "sa") || isDefined(param_01) && param_01 == "sa") {
    var_03 = [];
  }

  if((isDefined(param_00) && param_00 == "sub") || isDefined(param_01) && param_01 == "sub") {
    var_04 = [];
  }

  var_05 = [];
  var_05 = scripts\engine\utility::array_combine(var_03, var_02);
  var_05 = scripts\engine\utility::array_combine(var_05, var_04);
  var_05 = scripts\engine\utility::array_remove_duplicates(var_05);
  return var_05;
}

func_7AEB() {
  var_00 = ["dh_test", "dk_test", "jku_test", "ma_test", "vr_firing_range"];
  return var_00;
}

func_9CBB(param_00) {
  var_01 = ["shipcrib_epilogue", "shipcrib_titan", "shipcrib_europa", "shipcrib_moon", "shipcrib_rogue", "shipcrib_prisoner", "marscrib"];
  return scripts\engine\utility::array_contains(var_01, param_00);
}

is_jackal_arena_level(param_00) {
  var_01 = ["ja_spacestation", "ja_asteroid", "ja_mining", "ja_titan", "ja_wreckage"];
  return scripts\engine\utility::array_contains(var_01, param_00);
}

func_DA17(param_00, param_01) {
  var_02 = ["iw7_fhr", "iw7_crb", "iw7_ripper", "iw7_ar57", "iw7_m4", "iw7_devastator", "iw7_kbs", "iw7_steeldragon", "iw7_mauler", "iw7_lockon", "iw7_g18", "iw7_m1", "iw7_ake_gold"];
  var_03 = ["iw7_emc", "iw7_ake", "iw7_nrg", "iw7_erad", "iw7_m8", "iw7_fmg", "iw7_sonic", "iw7_sdfshotty", "iw7_sdfar", "iw7_sdflmg", "iw7_lmg03", "iw7_chargeshot", "iw7_penetrationrail", "iw7_ump45", "iw7_atomizer"];
  var_04 = ["iw7_ar57", "iw7_fhr", "iw7_g18", "iw7_devastator", "iw7_kbs", "iw7_ake", "iw7_sdflmg", "iw7_steeldragon"];
  if((isDefined(param_00) && param_00 == "un") || isDefined(param_01) && param_01 == "un") {
    var_02 = [];
  }

  if((isDefined(param_00) && param_00 == "sdf") || isDefined(param_01) && param_01 == "sdf") {
    var_03 = [];
  }

  var_05 = [];
  var_05 = scripts\engine\utility::array_combine(var_02, var_03);
  var_05 = scripts\engine\utility::array_remove_duplicates(var_05);
  if(var_05.size < 1) {
    var_05 = var_04;
  }

  return var_05;
}

func_D9F7() {
  var_00 = ["iw7_g18", "iw7_m4", "iw7_ripper"];
  return var_00;
}

func_D9F8(param_00) {
  var_01 = ["frag", "emp", "seeker", "antigrav"];
  var_02 = ["supportdrone", "offhandshield", "hackingdevice", "coverwall"];
  if(isDefined(param_00) && param_00 == "offhands") {
    var_01 = [];
  }

  if(isDefined(param_00) && param_00 == "items") {
    var_02 = [];
  }

  var_03 = scripts\engine\utility::array_combine(var_01, var_02);
  return var_03;
}

func_D9FA() {
  var_00 = ["iw7_steeldragon", "iw7_chargeshot", "iw7_lockon", "iw7_atomizer", "iw7_penetrationrail"];
  return var_00;
}

func_DA40(param_00) {
  if(scripts\engine\utility::array_contains(func_D9FA(), getweaponbasename(param_00))) {
    return 1;
  }

  return 0;
}

func_DA0A() {
  var_00 = ["iw7_stasis", "iw7_repeater", "iw7_gambit", "iw7_counterweight"];
  return var_00;
}

func_DA10() {
  var_00 = ["iw7_m1", "iw7_ake_gold"];
  return var_00;
}

func_DA41(param_00) {
  if(scripts\engine\utility::array_contains(func_DA0A(), getweaponbasename(param_00))) {
    return 1;
  }

  return 0;
}

func_DA43(param_00) {
  if(scripts\engine\utility::array_contains(func_DA10(), getweaponbasename(param_00))) {
    return 1;
  }

  return 0;
}

func_DA42(param_00) {
  if(func_9B44(param_00)) {
    return 0;
  }

  if(scripts\engine\utility::weaponclass(param_00) != "rifle" && scripts\engine\utility::weaponclass(param_00) != "mg") {
    return 0;
  }

  return !func_DA40(param_00);
}

func_DA12() {
  var_00 = ["steadyaim", "quickdraw", "blastshield", "quickswap", "agility", "fastreload", "extraequipment", "fastregen", "focus", "slasher", "shocker"];
  return var_00;
}

func_D9FF() {
  var_00 = ["primary_default", "primary_upgrade_1", "primary_upgrade_2"];
  return var_00;
}

func_DA01() {
  var_00 = ["secondary_default", "secondary_upgrade_1", "secondary_upgrade_2"];
  return var_00;
}

func_DA03() {
  var_00 = ["weapons", "thrusters", "hull"];
  return var_00;
}

func_D9FC() {
  var_00 = ["veh_mil_air_un_jackal_livery_shell_01", "veh_mil_air_un_jackal_livery_shell_02", "veh_mil_air_un_jackal_livery_shell_03", "veh_mil_air_un_jackal_livery_shell_04", "veh_mil_air_un_jackal_livery_shell_05", "veh_mil_air_un_jackal_livery_shell_06", "veh_mil_air_un_jackal_livery_shell_07", "veh_mil_air_un_jackal_livery_shell_08", "veh_mil_air_un_jackal_livery_shell_09", "veh_mil_air_un_jackal_livery_shell_10", "veh_mil_air_un_jackal_livery_shell_11", "veh_mil_air_un_jackal_livery_shell_12", "veh_mil_air_un_jackal_livery_shell_13", "veh_mil_air_un_jackal_livery_shell_14", "veh_mil_air_un_jackal_livery_shell_15", "veh_mil_air_un_jackal_livery_shell_16", "veh_mil_air_un_jackal_livery_shell_17", "veh_mil_air_un_jackal_livery_shell_18", "veh_mil_air_un_jackal_livery_shell_19", "veh_mil_air_un_jackal_livery_shell_20", "veh_mil_air_un_jackal_livery_shell_21", "veh_mil_air_un_jackal_livery_shell_22"];
  return var_00;
}

func_DA15() {
  var_00 = ["salenKoch", "riah", "captain0", "captain1", "captain2", "captain3", "captain4", "captain5", "captain6", "captain7", "captain8", "captain9", "acepilot0", "acepilot1", "acepilot2", "acepilot3", "acepilot4", "acepilot5", "acepilot6", "acepilot7", "acepilot8", "acepilot9", "acepilot10", "acepilot11", "acepilot12", "acepilot13", "acepilot14", "acepilot15", "acepilot16", "acepilot17", "acepilot18", "acepilot19"];
  return var_00;
}

func_DA09() {
  var_00 = ["europa", "pearlharbor", "phparade", "phstreets", "phspace", "shipcrib_moon", "moon_port", "moonjackal", "sa_moon", "shipcrib_europa", "sa_vips", "sa_empambush", "sa_wounded", "sa_assassination", "shipcrib_titan", "titan", "titanjackal", "ja_spacestation", "ja_asteroid", "ja_wreckage", "shipcrib_rogue", "ja_titan", "rogue", "shipcrib_prisoner", "ja_mining", "prisoner", "heist", "heistspace", "mars", "marscrash", "marscrib", "marsbase", "yard", "shipcrib_epilogue"];
  return var_00;
}

func_D9F2(param_00) {
  var_01 = ["acog", "elo", "smart", "akimbo", "oscope", "reflect", "xmags", "reflex", "phase", "thermal", "hybrid", "vzscope", "silencer", "barrelrange", "grip", "cpu", "rof", "fastaim", "scope", "nodualfov", "snproverlay"];
  if(isDefined(param_00) && !param_00) {
    return var_01;
  }

  var_02 = ["epicar57", "epicm4", "epicake", "epicsdfar", "epicfmg", "epicmauler", "epicsdflmg", "epiclmg03", "epicerad", "epiccrb", "epicripper", "epicfhr", "epicm8", "epickbs", "epicsdfshotty", "epicdevastator", "epicsonic", "epicemc", "epicnrg", "epicg18", "epicump45"];
  return scripts\engine\utility::array_combine(var_01, var_02);
}

func_D9F1() {
  var_00 = ["acog", "acogake", "acogake_gold", "acogsmg", "acogsmgnoalt", "acogpistol", "acoglmg", "acogarnoalt", "acogkbs", "acogm8", "acogm4", "acoglmgnoalt", "reflex", "reflexake_gold", "reflexake", "reflexfmg", "reflexshotgun", "reflexsmg", "reflexlmg", "reflexpstl", "reflexnrg", "phase_sp", "phaseake_sp", "phaseake_spgold", "phasefmg_sp", "phaseshotgun_sp", "phasesmg_sp", "phaselmg_sp", "phasepstl_sp", "phasenrg_sp", "thermal", "thermalake", "thermalake_gold", "thermalfmg", "thermalsmg", "thermallmg", "thermalkbs", "thermalm8", "thermalm4", "hybrid", "hybridake", "hybridake_gold", "hybridarnoalt", "hybridsmg", "hybridsmgnoalt", "hybridlmg", "elo", "eloake", "eloake_gold", "elofmg", "elodmr", "elolmg", "elopstl", "elonrg", "eloshtgn", "elosmg", "elokbs", "elom8", "vzscope", "kbsvzscope", "oscope", "kbsoscope", "smart", "silencer", "silencersmg", "silencerpstl", "silencershtgn", "silencerdmr", "silencersnpr", "silencersniperhide", "silencersniperhidee", "silencere", "silencere_gold", "silencerefmg", "silencersmge", "silencerpstle", "silencershtgne", "silencersnpre", "silencershtgns", "barrelrange", "barrelrangesmg", "barrelrangepstl", "barrelrangeshtgn", "barrelrangedmr", "barrelrangesmge", "barrelrangee", "barrelrangepstle", "barrelrangeshtgne", "barrelrangeshtgns_sp", "grip", "griphide", "griphide", "gripake", "gripake_gold", "gripar57", "gripm4", "gripsdfar", "gripcrbl", "gripripperr", "gripump45l", "gripsnpr", "gripsnpr", "gripfmg", "gripshtgn", "gripsdfshotty", "gripdevastator", "cpu", "akimbo", "akimboemc", "akimbonrg", "akimbog18", "akimbofmg_sp", "reflect", "rof", "rof", "rofar", "rofar", "rofshtgn", "rofshtgn", "roflmg", "roflmg", "rofdmr", "rofsnpr", "rofsnpr", "rofburst", "xmags", "xmagse", "xmagsepstl", "xmagsenrg", "xmagselmg", "xmagseshtgn", "xmagseshtgnpump", "fastaim", "fastaimsnpr", "fastaimdmr", "chargeshotscope", "ripperrscope_sp", "eradscope", "ump45lscope", "crblscope", "ar57scope", "fmgscope", "kbsscope", "kbsscope", "m8scope_sp", "lockonscope", "arm8_sp", "arripper_sp", "shotgunerad_sp", "atomizerscope", "lmg03scope", "sonicscope", "sdfshottyscope", "penetrationrailscope_sp", "epicar57", "epicm4", "epicake", "epicsdfar", "epicfmg", "epicmauler", "epicsdflmg", "epiclmg03", "epicerad", "epiccrb", "epicripper", "epicump45", "epicfhr", "epicm8", "epickbs", "epicsdfshotty", "epicdevastator", "epicsonic", "epicemc", "epicnrg", "epicg18"];
  return var_00;
}

func_DA0F() {
  var_00 = ["acog", "elo", "smart", "oscope", "reflex", "phase", "thermal", "scope", "hybrid", "vzscope"];
  return var_00;
}

func_DA0D() {
  var_00 = ["scope1", "scope2", "scope3", "scope4", "scope5", "scope6", "scope7", "scope8", "scope9", "scope10"];
  return var_00;
}

func_D9F3() {
  var_00 = ["snow", "camo02", "camo03", "camo04", "camo05", "camo07", "camo08", "camo09", "camo10", "camo11", "camo12", "camo13", "camo14", "camo15", "camo17", "camo18", "camo19", "camo20", "camo21", "camo22", "camo23", "camo24", "camo25", "camo27", "camo28", "camo29", "camo30"];
  return var_00;
}

func_7BB5(param_00) {
  if(!isDefined(param_00)) {
    return undefined;
  }

  switch (param_00) {
    case "frag":
      if(lib_0E42::_hasperk("upgrade_frag_1") || lib_0E42::_hasperk("upgrade_frag_2")) {
        return "frag_up1";
      }
      break;

    case "offhandshield":
      if(lib_0E42::_hasperk("upgrade_shield_1")) {
        return "offhandshield_up1";
      }
      break;

    case "supportdrone":
      if(lib_0E42::_hasperk("upgrade_drone_1")) {
        return "supportdrone_up2";
      }
      break;
  }

  return param_00;
}

setlightintensity(param_00, param_01) {
  if(!isDefined(param_01)) {
    return 0;
  }

  if(param_01 == "upgrade1") {
    var_02 = "1";
  } else if(var_02 == "upgrade2") {
    var_02 = "2";
  } else {
    return 0;
  }

  var_03 = undefined;
  switch (param_00) {
    case "frag":
      var_03 = "upgrade_frag_" + var_02;
      break;

    case "emp":
      var_03 = "upgrade_shock_" + var_02;
      break;

    case "seeker":
      var_03 = "upgrade_seeker_" + var_02;
      break;

    case "antigrav":
      var_03 = "upgrade_antigrav_" + var_02;
      break;

    case "supportdrone":
      var_03 = "upgrade_drone_" + var_02;
      break;

    case "offhandshield":
      var_03 = "upgrade_shield_" + var_02;
      break;

    case "hackingdevice":
      var_03 = "upgrade_hack_" + var_02;
      break;

    case "coverwall":
      var_03 = "upgrade_cover_" + var_02;
      break;
  }

  if(isDefined(var_03)) {
    level.player lib_0E42::switchtoweaponimmediate(var_03);
  }

  return 1;
}

_meth_82FF() {
  var_00 = func_D9F8();
  foreach(var_02 in var_00) {
    var_03 = level.player _meth_84C6("equipmentState", var_02);
    setlightintensity(var_02, var_03);
  }
}

_meth_8315() {
  var_00 = func_DA12();
  var_01 = [];
  var_02 = undefined;
  foreach(var_04 in var_00) {
    var_02 = level.player _meth_84C6("suitUpgradeState", var_04);
    if(isDefined(var_02) && var_02 == "unlocked") {
      var_05 = "specialty_" + var_04;
      var_01 = scripts\engine\utility::array_add(var_01, var_05);
    }
  }

  if(scripts\sp\utility::func_93A6() && !scripts\engine\utility::array_contains(var_01, "specialty_extraequipment")) {
    var_01 = scripts\engine\utility::array_add(var_01, "specialty_extraequipment");
  }

  level.player lib_0E42::giveperks(var_01);
}

func_DA19() {
  if(level.player _meth_84C6("suitUpgradeState", "slasher") != "locked") {
    return 1;
  }

  return level.player _meth_84C6("suitUpgradeState", "shocker") != "locked";
}

func_D9FB() {
  var_00 = level.player _meth_84C6("selectedLoadout");
  var_01 = level.player _meth_84C6("loadouts", var_00, "jackalSetup", "jackalDecal");
  if(!isDefined(var_01) || var_01 == "none" || var_01 == "") {
    var_01 = "veh_mil_air_un_jackal_livery_shell_01";
  }

  return var_01;
}

func_DA02() {
  var_00 = level.player _meth_84C6("selectedLoadout");
  var_01 = level.player _meth_84C6("loadouts", var_00, "jackalSetup", "jackalUpgrade");
  if(!isDefined(var_01)) {
    var_01 = "none";
  }

  return var_01;
}

func_D9FE() {
  var_00 = level.player _meth_84C6("selectedLoadout");
  var_01 = level.player _meth_84C6("loadouts", var_00, "jackalSetup", "jackalPrimary");
  if(!isDefined(var_01)) {
    var_01 = "primary_default";
  }

  return var_01;
}

func_DA00() {
  var_00 = level.player _meth_84C6("selectedLoadout");
  var_01 = level.player _meth_84C6("loadouts", var_00, "jackalSetup", "jackalSecondary");
  if(!isDefined(var_01)) {
    var_01 = "secondary_default";
  }

  return var_01;
}

func_DA46() {
  var_00 = scripts\engine\utility::array_combine(getspawnerarray(), getaiarray("allies", "axis"));
  var_01 = 0;
  if(var_00.size > 0) {
    var_01 = 1;
  }

  if(var_01) {
    level.var_D9E5["default_weapon_transients"] = [];
    var_02 = undefined;
    var_03 = func_DA17("sdf", "un");
    foreach(var_05 in var_03) {
      var_02 = "weapon_" + var_05 + "_tr";
      level.var_D9E5["default_weapon_transients"] = scripts\engine\utility::array_add(level.var_D9E5["default_weapon_transients"], var_02);
      precacheitem(var_05);
      precachemodel(getweaponviewmodel(var_05));
    }
  }
}

func_9789() {
  var_00 = func_DA17();
  var_00 = scripts\engine\utility::array_add(var_00, "iw7_knife_perk");
  var_00 = scripts\engine\utility::array_add(var_00, "iw7_knife_upgrade1");
  var_00 = func_D9E7(var_00);
  foreach(var_02 in var_00) {
    scripts\sp\utility::func_1263F("weapon_" + var_02 + "_tr");
    precacheitem(var_02);
    precachemodel(getweaponviewmodel(var_02));
  }

  var_04 = func_D9FC();
  foreach(var_06 in var_04) {
    precachemodel(var_06);
    var_07 = strtok(var_06, "_");
    var_08 = var_07.size - 1;
    var_09 = "livery_" + var_07[var_08 - 1] + "_" + var_07[var_08];
    scripts\sp\utility::func_1263F(var_09 + "_" + "tr");
  }
}

func_96FD() {
  scripts\engine\utility::flag_init("weapon_scanning_off");
  scripts\engine\utility::flag_init("flag_armory_weapons_loaded");
  if(isDefined(level.var_D9E5)) {
    return;
  } else {
    level.var_D9E5 = [];
    level.var_D9E5["weaponstates"] = [];
    level.var_D9E5["fakedata"] = 0;
  }

  setdvarifuninitialized("E3", 0);
  setdvarifuninitialized("GI", 0);
  setdvarifuninitialized("E3WEAPONS", 0);
  setdvarifuninitialized("progression_on", "1");
  var_00 = scripts\engine\utility::array_combine(func_7AF1(), func_7AEB());
  func_DA1D();
  func_DA52();
  level.var_D9E5["unlocked_attachments"] = func_DA1E();
  func_DA3D();
  if(!isDefined(level.template_script) || isDefined(level.template_script) && !scripts\engine\utility::array_contains(var_00, level.template_script)) {
    func_DA46();
    return;
  }

  func_492B();
  var_01 = scripts\engine\utility::get_template_script_MAYBE();
  var_01 = func_7BDE(var_01);
  func_DA33(var_01);
  func_DA3E(var_01);
  level.var_D9E5["equip_upgrades"] = func_DA22(var_01);
  level.var_D9E5["suit_upgrades"] = func_DA3B();
  level.var_D9E5["jackal_decals"] = func_DA25();
  level.var_D9E5["mandatory_suit_upgrades"] = func_DA2E(var_01);
  level.var_D9E5["mandatory_jackal_primaries"] = func_DA2A(var_01);
  level.var_D9E5["mandatory_jackal_secondaries"] = func_DA2B(var_01);
  level.var_D9E5["mandatory_jackal_upgrades"] = func_DA2C(var_01);
  level.var_D9E5["mandatory_jackal_decals"] = func_DA29(var_01);
  level.var_D9E5["ace_pilots"] = func_DA1A(var_01);
  level.var_D9E5["mission_specific_weapons"] = func_DA30(var_01);
  level.var_D9E5["mandatoryunlocks"] = func_DA2F(var_01);
  level.var_D9E5["optionalunlocks"] = func_DA32(var_01);
  level.var_D9E5["armoryweapons"] = [];
  level.var_D9E5["loaded_weapons"] = func_DA27(var_01);
  level.var_D9E5["loaded_weapon_types"] = func_DA3F();
  level.var_D9E5["loaded_equipment_types"] = func_DA21();
  level.var_D9E5["primaryweapons"] = func_DA34();
  level.var_D9E5["secondaryweapons"] = func_DA39();
  level.var_D9E5["offhand"] = func_DA31(var_01);
  level.var_D9E5["items"] = func_DA24(var_01);
  level.var_D9E5["scanned_items"] = func_DA0E();
  level.var_D9E5["wanted_cards"] = func_DA3C();
  level.var_D9E5["achievementDoorPeek"] = func_DA1B();
  if(func_9CBB(level.template_script)) {
    scripts\sp\endmission::func_12F24();
  }

  if(scripts\engine\utility::array_contains(var_00, var_01) || getdvarint("force_weapon_scan") == 1) {
    if(var_01 != "e3_phstreets") {
      thread func_EBB9();
      thread func_13C35();
    }
  }
}

func_13C43() {
  self endon("death");
  for(;;) {
    if(isDefined(self.disableautoreload) && self.disableautoreload > 0 && self _meth_843C()) {}

    wait(0.05);
  }
}

func_DA33(param_00) {}

func_DA3E(param_00) {
  var_01 = func_DA17();
  var_02 = func_7AF1("sub");
  var_03 = [];
  var_04 = 0;
  foreach(var_06 in var_02) {
    if(var_06 != param_00 && !var_04) {
      continue;
    } else if(!var_04) {
      var_04 = 1;
    }

    var_07 = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_06, 2), ", ");
    var_03 = scripts\engine\utility::array_combine(var_03, var_07);
    var_08 = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_06, 3), ", ");
    var_03 = scripts\engine\utility::array_combine(var_03, var_08);
  }

  foreach(var_0B in var_01) {
    var_0C = level.player _meth_84C6("weaponsScanned", var_0B);
    if(isDefined(var_0C) && var_0C != "") {
      level.var_D9E5["weaponstates"][var_0B] = var_0C;
      continue;
    }

    level.var_D9E5["weaponstates"][var_0B] = "locked";
  }
}

func_DA1D() {
  var_00 = ["phspace", "sa_moon", "titanjackal", "rogue", "marscrash", "sa_assassination", "sa_empambush", "sa_vips", "sa_wounded", "ja_asteroid", "ja_spacestation", "ja_titan", "ja_wreckage", "ja_mining"];
  var_01 = 0;
  foreach(var_03 in var_00) {
    var_04 = scripts\sp\endmission::func_7F6B(var_03);
    if(scripts\sp\endmission::func_7F69(var_04)) {
      var_01++;
    }
  }

  level.player _meth_84C7("scrapCount", var_01);
  func_DA4F();
}

func_DA22(param_00) {
  var_01 = int(tablelookup("sp\progression_unlocks.csv", 0, param_00, 7));
  return var_01;
}

func_DA28(param_00) {
  var_01 = [];
  var_01["terminals"] = [];
  var_01["discovered"] = [];
  if(param_00 != "all_weapons") {
    for(var_02 = 0; var_02 < 2; var_02++) {
      for(var_03 = 0; var_03 < 2; var_03++) {
        var_04 = var_02 * 2 + var_03;
        var_05 = level.player _meth_84C6("missionLootRooms", param_00, "terminal", var_04);
        var_01["terminals"] = scripts\engine\utility::array_add(var_01["terminals"], var_05);
      }

      var_06 = level.player _meth_84C6("missionLootRooms", param_00, "discovered", var_02);
      var_01["discovered"] = scripts\engine\utility::array_add(var_01["discovered"], var_06);
    }
  }

  return var_01;
}

func_D9ED(param_00) {
  var_01 = scripts\engine\utility::get_template_script_MAYBE();
  var_01 = func_7BDE(var_01);
  var_02 = level.player _meth_84C6("missionLootRooms", var_01, "discovered", param_00);
  return var_02;
}

func_DA49(param_00, param_01) {
  var_02 = scripts\engine\utility::get_template_script_MAYBE();
  var_02 = func_7BDE(var_02);
  level.player _meth_84C7("missionLootRooms", var_02, "discovered", param_00, param_01);
}

func_DA44(param_00, param_01) {
  var_02 = scripts\engine\utility::get_template_script_MAYBE();
  var_02 = func_7BDE(var_02);
  var_03 = param_00 * 2 + param_01;
  var_04 = level.player _meth_84C6("missionLootRooms", var_02, "terminal", var_03);
  return var_04;
}

func_DA4D(param_00, param_01) {
  var_02 = scripts\engine\utility::get_template_script_MAYBE();
  var_02 = func_7BDE(var_02);
  var_03 = param_00 * 2 + param_01;
  level.player _meth_84C7("missionLootRooms", var_02, "terminal", var_03, 1);
}

func_DA3B() {
  var_00 = func_DA12();
  return func_D9F0("suitUpgradeState", var_00);
}

func_DA25() {
  var_00 = func_D9FC();
  return func_D9F0("jackalDecals", var_00);
}

func_DA2E(param_00) {
  var_01 = scripts\engine\utility::get_template_script_MAYBE();
  if(param_00 == "pearlharbor" && var_01 != "phspace") {
    return [];
  }

  if(param_00 == "titan" && var_01 != "titanjackal") {
    return [];
  }

  if(param_00 == "heist") {
    return [];
  }

  if(var_01 == "marscrash") {
    param_00 = "heist";
  }

  var_02 = strtok(tablelookup("sp\progression_unlocks.csv", 0, param_00, 8), ", ");
  var_02 = scripts\engine\utility::array_remove(var_02, "");
  return var_02;
}

func_DA2A(param_00) {
  var_01 = strtok(tablelookup("sp\progression_unlocks.csv", 0, param_00, 9), ", ");
  var_01 = scripts\engine\utility::array_remove(var_01, "");
  return var_01;
}

func_DA2B(param_00) {
  var_01 = strtok(tablelookup("sp\progression_unlocks.csv", 0, param_00, 10), ", ");
  var_01 = scripts\engine\utility::array_remove(var_01, "");
  return var_01;
}

func_DA2C(param_00) {
  var_01 = strtok(tablelookup("sp\progression_unlocks.csv", 0, param_00, 11), ", ");
  var_01 = scripts\engine\utility::array_remove(var_01, "");
  return var_01;
}

func_DA29(param_00) {
  var_01 = strtok(tablelookup("sp\progression_unlocks.csv", 0, param_00, 12), ", ");
  var_01 = scripts\engine\utility::array_remove(var_01, "");
  return var_01;
}

func_DA1A(param_00) {
  var_01 = strtok(tablelookup("sp\progression_unlocks.csv", 0, param_00, 13), ", ");
  var_01 = scripts\engine\utility::array_remove(var_01, "");
  return var_01;
}

func_DA30(param_00) {
  return strtok(tablelookup("sp\progression_unlocks.csv", 0, param_00, 14), ", ");
}

func_DA2F(param_00) {
  var_01 = func_7AF1("sub", "sa");
  var_02 = [];
  var_03 = [];
  var_04 = 0;
  foreach(var_06 in var_01) {
    if(var_06 != param_00 && !var_04) {
      continue;
    } else if(!var_04) {
      var_04 = 1;
      if(var_06 != "all_weapons") {
        var_07 = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_06, 2), ", ");
        var_02 = scripts\engine\utility::array_combine(var_02, var_07);
        var_08 = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_06, 3), ", ");
        var_02 = scripts\engine\utility::array_combine(var_02, var_08);
        continue;
      }
    }

    var_09 = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_06, 2), ", ");
    var_03 = scripts\engine\utility::array_combine(var_03, var_09);
    var_0A = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_06, 3), ", ");
    var_03 = scripts\engine\utility::array_combine(var_03, var_0A);
  }

  foreach(var_0D in var_03) {
    var_0E = level.player _meth_84C6("weaponsScanned", var_0D);
    if(!isDefined(var_0E) || var_0E == "locked") {
      level.player _meth_84C7("weaponsScanned", var_0D, "unlocked");
      level.var_D9E5["weaponstates"][var_0D] = "unlocked";
    }
  }

  return var_02;
}

func_DA32(param_00) {
  var_01 = strtok(tablelookup("sp\progression_unlocks.csv", 0, param_00, 4), ", ");
  var_01 = func_D9E7(var_01);
  if(param_00 != "europa" && param_00 != "pearlharbor") {
    var_02 = level.player _meth_84C6("weaponsScanned", "iw7_steeldragon");
    if(isDefined(var_02) && var_02 == "locked") {
      var_01 = scripts\engine\utility::array_add(var_01, "iw7_steeldragon");
    }
  }

  foreach(var_04 in var_01) {
    var_05 = level.player _meth_84C6("weaponsScanned", var_04);
    if(isDefined(var_05) && var_05 == "unlocked") {
      var_01 = scripts\engine\utility::array_remove(var_01, var_04);
      continue;
    }

    if(isDefined(var_05) && var_05 == "scanned") {
      var_01 = scripts\engine\utility::array_remove(var_01, var_04);
      continue;
    }

    if(isDefined(level.var_D9E5["weaponstates"][var_04]) && level.var_D9E5["weaponstates"][var_04] != "locked") {
      var_01 = scripts\engine\utility::array_remove(var_01, var_04);
    }
  }

  return var_01;
}

func_DA27(param_00) {
  if(isDefined(level.template_script)) {
    var_01 = level.template_script;
  } else {
    var_01 = var_01;
  }

  if(scripts\engine\utility::string_starts_with(var_01, "shipcrib")) {
    var_02 = 1;
  } else {
    var_02 = 0;
  }

  if(scripts\engine\utility::string_starts_with(var_01, "ja_")) {
    var_03 = 1;
  } else {
    var_03 = 0;
  }

  return func_DA18(param_00, var_02, 0, undefined, var_03);
}

func_DA34() {
  var_00 = [];
  foreach(var_02 in level.var_D9E5["loaded_weapons"]) {
    if(func_9B44(var_02)) {
      continue;
    }

    if(func_DA42(var_02)) {
      var_00 = scripts\engine\utility::array_add(var_00, var_02);
    }
  }

  return var_00;
}

func_DA39() {
  var_00 = [];
  foreach(var_02 in level.var_D9E5["loaded_weapons"]) {
    if(func_9B44(var_02)) {
      continue;
    }

    if(!func_DA42(var_02)) {
      var_00 = scripts\engine\utility::array_add(var_00, var_02);
    }
  }

  return var_00;
}

func_DA31(param_00) {
  var_01 = [];
  var_02 = [];
  var_03 = [];
  if(!level.var_D9E5["fakedata"]) {
    foreach(var_05 in level.var_D9E5["loaded_equipment_types"]) {
      if(isDefined(level.var_D9E5["weaponstates"][var_05]) && level.var_D9E5["weaponstates"][var_05] == "unlocked") {
        var_01 = scripts\engine\utility::array_add(var_01, var_05);
      }
    }
  } else if(param_00 == "all_weapons") {
    var_03 = strtok(tablelookup("sp\progression_unlocks.csv", 0, param_00, 5), ", ");
    for(var_07 = 0; var_07 < var_03.size; var_07++) {
      if(var_03[var_07] != "") {
        var_01 = scripts\engine\utility::array_add(var_01, var_03[var_07]);
      }
    }
  } else {
    var_08 = func_7AF1("sub");
    var_09 = 0;
    foreach(var_0B in var_08) {
      if(var_0B != param_00 && !var_09) {
        continue;
      } else if(!var_09) {
        var_09 = 1;
      }

      var_03 = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_0B, 5), ", ");
      for(var_07 = 0; var_07 < var_03.size; var_07++) {
        if(var_03[var_07] != "") {
          var_01 = scripts\engine\utility::array_add(var_01, var_03[var_07]);
        }
      }
    }
  }

  return var_01;
}

func_DA24(param_00) {
  var_01 = [];
  var_02 = [];
  var_03 = [];
  if(!level.var_D9E5["fakedata"]) {
    foreach(var_05 in level.var_D9E5["loaded_equipment_types"]) {
      if(isDefined(level.var_D9E5["weaponstates"][var_05]) && level.var_D9E5["weaponstates"][var_05] == "unlocked") {
        var_01 = scripts\engine\utility::array_add(var_01, var_05);
      }
    }
  } else if(param_00 == "all_weapons") {
    var_03 = strtok(tablelookup("sp\progression_unlocks.csv", 0, param_00, 6), ", ");
    for(var_07 = 0; var_07 < var_03.size; var_07++) {
      if(var_03[var_07] != "") {
        var_01 = scripts\engine\utility::array_add(var_01, var_03[var_07]);
      }
    }
  } else {
    var_08 = func_7AF1("sub");
    var_09 = 0;
    foreach(var_0B in var_08) {
      if(var_0B != param_00 && !var_09) {
        continue;
      } else if(!var_09) {
        var_09 = 1;
      }

      var_03 = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_0B, 6), ", ");
      for(var_07 = 0; var_07 < var_03.size; var_07++) {
        if(var_03[var_07] != "") {
          var_01 = scripts\engine\utility::array_add(var_01, var_03[var_07]);
        }
      }
    }
  }

  return var_01;
}

func_DA3F() {
  if(!func_3DDC("weapon")) {
    return;
  }

  var_00 = level.var_D9E5["loaded_weapons"];
  var_01 = [];
  var_01["rifle"] = [];
  var_01["smg"] = [];
  var_01["spread"] = [];
  var_01["sniper"] = [];
  var_01["mg"] = [];
  var_01["pistol"] = [];
  var_01["beam"] = [];
  var_01["rocketlauncher"] = [];
  foreach(var_03 in var_00) {
    if(!func_9B49(var_03)) {
      continue;
    }

    if(func_DA41(var_03)) {
      continue;
    }

    if(scripts\engine\utility::array_contains(level.var_D9E5["mandatoryunlocks"], var_03) || scripts\engine\utility::array_contains(level.var_D9E5["optionalunlocks"], var_03) || scripts\engine\utility::array_contains(level.var_D9E5["mission_specific_weapons"], var_03) || scripts\engine\utility::array_contains(func_D9F7(), var_03) && func_9CBB(level.template_script) || isDefined(level.var_D9E5["weaponstates"][var_03]) && level.var_D9E5["weaponstates"][var_03] != "locked") {
      var_04 = spawnStruct();
      var_04.weapon_name = var_03;
      var_04.var_13C13 = func_7D5F(var_03);
      var_05 = scripts\engine\utility::weaponclass(var_03);
      var_01[var_05] = scripts\engine\utility::array_add(var_01[var_05], var_04);
    }
  }

  return var_01;
}

func_DA21() {
  if(!func_3DDC("offhand")) {
    return;
  }

  var_00 = func_D9F8();
  var_01 = [];
  foreach(var_03 in var_00) {
    if(!scripts\engine\utility::array_contains(level.var_D9E5["mandatoryunlocks"], var_03) || isDefined(level.var_D9E5["weaponstates"][var_03]) && level.var_D9E5["weaponstates"][var_03] == "unlocked") {
      var_01 = scripts\engine\utility::array_add(var_01, var_03);
    }
  }

  return var_01;
}

func_DA38() {
  var_00 = [];
  var_01 = 0;
  for(;;) {
    var_02 = tablelookupbyrow("sp\scrap_unlocks.csv", var_01, 0);
    if(!isDefined(var_02) || var_02 == "") {
      break;
    }

    var_03 = tablelookupbyrow("sp\scrap_unlocks.csv", var_01, 2);
    if(!isDefined(var_00[var_03])) {
      var_00[var_03] = [];
    }

    var_04 = tablelookupbyrow("sp\scrap_unlocks.csv", var_01, 1);
    var_05 = tablelookupbyrow("sp\scrap_unlocks.csv", var_01, 3);
    var_00[var_03][var_04] = var_05;
    var_01++;
  }

  return var_00;
}

func_DA1E() {
  var_00 = func_D9F2(0);
  var_01 = func_D9F1();
  foreach(var_03 in var_01) {
    var_04 = tablelookuprownum("sp\attachmenttable.csv", 4, var_03);
    var_05 = tablelookupbyrow("sp\attachmenttable.csv", var_04, 8);
    if(isDefined(var_05) && var_05 != "") {
      precachemodel(var_05);
    }
  }

  return func_D9F0("attachmentsState", var_00);
}

func_D9E6(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_00[param_02])) {
    param_00[param_02] = [];
  }

  param_00[param_02][param_01] = param_03;
  return param_00;
}

func_7AEC(param_00) {
  switch (param_00) {
    case "pearlharbor":
      return "phspace";

    case "mars":
      return "marsbase";

    default:
      return param_00;
  }
}

func_7BDE(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(param_01) {
    level.var_D9E5["submission"] = "submission";
  }

  switch (param_00) {
    case "shipcrib_epilogue":
      param_00 = "yard";
      break;

    case "shipcrib_titan":
      param_00 = "titan";
      break;

    case "shipcrib_europa":
      param_00 = "moon_port";
      break;

    case "shipcrib_moon":
      param_00 = "moon_port";
      break;

    case "shipcrib_rogue":
      param_00 = "rogue";
      break;

    case "shipcrib_prisoner":
      param_00 = "prisoner";
      break;

    case "phparade":
      param_00 = "pearlharbor";
      break;

    case "phspace":
      param_00 = "pearlharbor";
      if(param_01) {
        level.var_D9E5["submission"] = param_00;
      }
      break;

    case "phstreets":
      param_00 = "pearlharbor";
      break;

    case "marscrash":
      param_00 = "mars";
      break;

    case "marscrib":
      param_00 = "mars";
      break;

    case "marsbase":
      param_00 = "mars";
      if(param_01) {
        level.var_D9E5["submission"] = param_00;
      }
      break;

    case "moon_port":
      param_00 = "moon_port";
      break;

    case "moonjackal":
      param_00 = "moon_port";
      if(param_01) {
        level.var_D9E5["submission"] = param_00;
      }
      break;

    case "titanjackal":
      param_00 = "titan";
      if(param_01) {
        level.var_D9E5["submission"] = param_00;
      }
      break;

    case "heistspace":
      param_00 = "heist";
      if(param_01) {
        level.var_D9E5["submission"] = param_00;
      }
      break;

    case "rogue_dropship":
      param_00 = "rogue";
      break;

    case "dk_test":
      param_00 = "sa_assassination";
      break;

    default:
      if(param_01) {
        level.var_D9E5["submission"] = param_00;
      }

      break;
  }

  if(getdvarint("progression_on") == 0 || scripts\engine\utility::array_contains(func_7AEB(), param_00)) {
    param_00 = "all_weapons";
  }

  return param_00;
}

func_492B(param_00) {
  var_01 = level.player _meth_84C6("weaponsScanned", "iw7_g18");
  if(!isDefined(var_01) || var_01 != "unlocked" || isDefined(param_00)) {
    var_02 = ["iw7_g18", "iw7_m8", "iw7_m4", "iw7_fhr"];
    foreach(var_04 in var_02) {
      level.player _meth_84C7("weaponsScanned", var_04, "unlocked");
    }

    var_06 = ["seeker", "antigrav"];
    foreach(var_08 in var_06) {
      level.player _meth_84C7("equipmentState", var_08, "unlocked");
    }

    var_0A = ["reflex", "acog", "silencer"];
    foreach(var_0C in var_0A) {
      level.player _meth_84C7("attachmentsState", var_0C, "unlocked");
    }

    var_0E = "primary_default";
    level.player _meth_84C7("jackalPrimaryState", var_0E, "unlocked");
    var_0F = "secondary_default";
    level.player _meth_84C7("jackalSecondaryState", var_0F, "unlocked");
    var_10 = ["weapons", "hull"];
    foreach(var_12 in var_10) {
      level.player _meth_84C7("jackalUpgradeState", var_12, "unlocked");
    }

    var_14 = ["veh_mil_air_un_jackal_livery_shell_01"];
    foreach(var_16 in var_14) {
      level.player _meth_84C7("jackalDecals", var_16, "unlocked");
    }

    level.player _meth_84C8("loadouts", 0, "name", "MENU_SP_GRIFFS_RECOMMENDED");
    level.player _meth_84C8("loadouts", 1, "name", "MENU_SP_LOADOUT_1");
    level.player _meth_84C8("loadouts", 2, "name", "MENU_SP_LOADOUT_2");
    level.player _meth_84C8("loadouts", 3, "name", "MENU_SP_LOADOUT_3");
    scripts\sp\loadout::func_F56D("loadout1", 0, 1);
    scripts\sp\loadout::func_F56D("loadout2", 0, 2);
    scripts\sp\loadout::func_F56D("loadout3", 0, 3);
    level.player _meth_84C7("missionStateData", "europa", "incomplete");
  }

  if(scripts\sp\utility::func_93A6()) {
    var_18 = ["nanoshot", "helmet"];
    foreach(var_08 in var_18) {
      var_1A = level.player _meth_84C6("equipmentState", var_08);
      if(var_1A == "locked") {
        level.player _meth_84C7("equipmentState", var_08, "scanned");
      }
    }
  }
}

func_DA57(param_00) {
  var_01 = level.player _meth_84C6("weaponsScanned", param_00);
  if(!isDefined(var_01)) {
    return 0;
  }

  return level.player _meth_84C6("weaponsScanned", param_00) != "locked";
}

func_DA55(param_00, param_01) {
  if(isDefined(level.var_D9E5["weaponstates"][param_00])) {
    if(!scripts\engine\utility::array_contains(param_01, param_00)) {
      if(func_9B49(param_00)) {
        if(!scripts\engine\utility::array_contains(level.var_D9E5["optionalunlocks"], param_00)) {
          if(level.var_D9E5["weaponstates"][param_00] != "scanned") {
            if(level.var_D9E5["weaponstates"][param_00] != "unlocked") {
              return 0;
            }
          }
        }
      }
    }

    return 1;
  } else if(func_9B49(param_00)) {
    if(!scripts\engine\utility::array_contains(func_DA17(), param_00)) {} else {
      return 1;
    }
  }

  return 0;
}

func_DA18(param_00, param_01, param_02, param_03, param_04) {
  var_05 = 14;
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!param_02) {
    var_06 = func_7F7B(level.template_script);
  } else if(isDefined(param_04)) {
    var_06 = param_04;
  } else {
    var_06 = [];
  }

  if(!param_02) {
    if(var_06.size > 0) {
      var_07 = scripts\engine\utility::array_combine(level.var_D9E5["mission_specific_weapons"], var_06);
      foreach(var_09 in level.var_D9E5["weapon_pickups"]) {
        if(!isstring(var_09)) {
          var_09 = getsubstr(var_09.classname, 7);
        }
      }
    }
  }

  var_0B = [];
  var_0B["rifle"] = -1;
  var_0B["smg"] = -1;
  var_0B["spread"] = -1;
  var_0B["sniper"] = -1;
  var_0B["mg"] = -1;
  var_0B["pistol"] = -1;
  var_0B["rocketlauncher"] = -1;
  var_0C = [];
  var_0D = [];
  var_0E = undefined;
  var_0F = [];
  if(!param_01) {
    if(!param_02) {
      var_10 = level.player _meth_84C6("lastWeaponPreload");
      if(isDefined(var_10) && var_10 == level.template_script) {
        var_11 = func_DA17();
        foreach(var_09 in var_11) {
          var_13 = level.player _meth_84C6("weaponsLoaded", var_09);
          if(isDefined(var_13) && var_13) {
            var_0F = scripts\engine\utility::array_add(var_0F, var_09);
          }
        }
      }

      level.player _meth_84C7("lastWeaponPreload", "nodata");
    }

    if(var_0F.size == 0) {
      if(!param_02) {
        var_0E = level.var_D9E5["mission_specific_weapons"];
      } else {
        var_0E = func_DA30(param_00);
      }

      if(!param_02) {
        var_0D = level.var_D9E5["mandatoryunlocks"];
      } else {
        var_0D = func_DA2F(param_00);
      }
    }
  }

  if(var_0F.size == 0) {
    if(!isDefined(var_0E)) {
      var_0E = [];
    }

    foreach(var_09 in var_06) {
      if(!isstring(var_09)) {
        var_16 = getsubstr(var_09.classname, 7);
        var_16 = getweaponbasename(var_16);
      } else {
        var_16 = var_09;
      }

      if(!func_DA55(var_16, var_0D)) {
        if(!func_9B49(var_16)) {
          continue;
        }
      }

      var_0E = scripts\engine\utility::array_add(var_0E, var_16);
    }

    if(!param_01) {
      var_18 = level.player getweaponslist("primary");
      var_19 = [];
      foreach(var_09 in var_18) {
        var_1B = getweaponbasename(var_09);
        if(scripts\engine\utility::array_contains(func_DA17(), var_1B)) {
          var_19 = scripts\engine\utility::array_add(var_19, var_1B);
        }
      }

      var_19 = scripts\engine\utility::array_remove_duplicates(var_19);
      var_19 = scripts\engine\utility::array_removeundefined(var_19);
      foreach(var_09 in var_19) {
        if(!scripts\engine\utility::array_contains(var_0E, var_09)) {
          if(scripts\engine\utility::array_contains(func_DA17(), var_09)) {
            var_0E = scripts\engine\utility::array_add(var_0E, var_09);
          }
        }
      }

      if(!isDefined(param_04) || isDefined(param_04) && !param_04) {
        var_0E = scripts\sp\utility::func_22A2(var_0E, var_0D);
        var_1F = strtok(tablelookup("sp\progression_unlocks.csv", 0, param_00, 5), ", ");
        level.var_D9E5["mandatoryunlocks"] = scripts\engine\utility::array_combine(level.var_D9E5["mandatoryunlocks"], var_1F);
        foreach(var_09, var_21 in level.var_D9E5["weaponstates"]) {
          if(func_9B49(var_09)) {
            if(!scripts\engine\utility::array_contains(var_0E, var_09)) {
              if(var_21 == "unlocked" && var_09 != "none") {
                var_0C = scripts\engine\utility::array_add(var_0C, var_09);
              }
            }
          }
        }

        var_0E = scripts\engine\utility::array_remove_duplicates(var_0E);
        var_0E = func_D9E7(var_0E);
        var_0C = scripts\engine\utility::array_remove_array(var_0C, var_0E);
        if(!param_02) {
          var_22 = level.var_D9E5["optionalunlocks"];
        } else {
          var_22 = func_DA32(param_01);
        }

        var_22 = scripts\engine\utility::array_remove_array(var_22, var_0E);
        var_0C = scripts\engine\utility::array_combine_unique(var_0C, var_22);
        foreach(var_09 in var_0E) {
          var_24 = scripts\engine\utility::weaponclass(var_09);
          if(!isDefined(var_0B[var_24])) {
            if(var_24 == "beam") {
              continue;
            }

            var_0E = scripts\engine\utility::array_remove(var_0E, var_09);
            continue;
          }

          if(var_0B[var_24] > 0) {
            var_0B[var_24]++;
            continue;
          }

          var_0B[var_24] = 0;
        }

        var_0C = scripts\engine\utility::array_randomize(var_0C);
        for(var_26 = 1; var_0E.size < var_05 && var_0C.size > 0 && var_26 < 3; var_26++) {
          foreach(var_09 in var_0C) {
            var_24 = scripts\engine\utility::weaponclass(var_09);
            if(func_DA40(var_09)) {
              continue;
            }

            if(func_DA41(var_09)) {
              continue;
            }

            if(func_DA43(var_09)) {
              continue;
            }

            if(level.template_script == "europa" && var_09 == "iw7_fmg") {
              continue;
            }

            if(var_0B[var_24] >= 0 && func_13C4A(var_0B)) {
              continue;
            }

            if(var_0B[var_24] <= var_26) {
              var_0E = scripts\engine\utility::array_add(var_0E, var_09);
              var_0C = scripts\engine\utility::array_remove(var_0C, var_09);
              var_0B[var_24]++;
            }

            if(var_0E.size == var_05) {
              break;
            }
          }
        }

        if(var_0E.size < var_05) {
          foreach(var_09 in var_0C) {
            if(func_DA40(var_09)) {
              continue;
            }

            if(func_DA41(var_09)) {
              continue;
            }

            if(func_DA43(var_09)) {
              continue;
            }

            if(level.template_script == "europa" && var_09 == "iw7_fmg") {
              continue;
            }

            if(var_0E.size < var_05) {
              var_0E = scripts\engine\utility::array_add(var_0E, var_09);
              continue;
            }

            if(var_0E.size == var_05) {
              break;
            }
          }
        }
      }
    } else {
      var_2E = func_D9F7();
      var_0E = scripts\sp\utility::func_22A2(var_0E, var_2E);
      var_0E = scripts\engine\utility::array_remove_duplicates(var_0E);
    }
  } else {
    var_0E = var_0F;
  }

  if(!param_02) {
    var_2F = "weaponsScanned";
    foreach(var_09 in var_0E) {
      if(!func_9B49(var_09)) {
        continue;
      }

      precacheitem(var_09);
      precachemodel(getweaponviewmodel(var_09));
      var_31 = level.player _meth_84C6(var_2F, var_09);
      if(isDefined(var_31)) {
        level.var_D9E5["weaponstates"][var_09] = var_31;
        continue;
      }

      level.var_D9E5["weaponstates"][var_09] = "unlocked";
    }

    var_2F = "equipmentState";
    var_33 = func_D9F8();
    foreach(var_35 in var_33) {
      precacheitem(var_35);
      var_36 = level.player _meth_84C6(var_2F, var_35);
      if(isDefined(var_36)) {
        level.var_D9E5["weaponstates"][var_35] = var_36;
        continue;
      }

      level.var_D9E5["weaponstates"][var_35] = "unlocked";
    }
  }

  var_38 = func_D9FB();
  if(!param_02) {
    precachemodel(var_38);
  }

  var_39 = strtok(var_38, "_");
  var_3A = var_39.size - 1;
  var_3B = "livery_" + var_39[var_3A - 1] + "_" + var_39[var_3A];
  var_0E = scripts\engine\utility::array_add(var_0E, var_3B);
  return var_0E;
}

func_13C4A(param_00) {
  foreach(var_03, var_02 in param_00) {
    if(var_03 == "beam") {
      continue;
    }

    if(var_03 == "rocketlauncher") {
      continue;
    }

    if(var_02 == -1) {
      return 1;
    }
  }

  return 0;
}

func_DA14(param_00, param_01) {}

func_7F7B(param_00) {
  var_01 = [];
  switch (param_00) {
    case "phparade":
      var_01 = [];
      break;

    case "phspace":
      var_01 = [];
      break;

    case "phstreets":
      var_01 = ["iw7_ar57", "iw7_m8", "iw7_m4", "iw7_crb", "iw7_sdflmg"];
      break;

    case "marscrash":
      var_01 = [];
      break;

    case "marscrib":
      var_01 = ["iw7_ake"];
      break;

    case "marsbase":
      var_01 = ["iw7_lockon", "iw7_m8"];
      break;

    case "moonjackal":
      var_01 = [];
      break;

    case "titanjackal":
      var_01 = [];
      break;

    case "heistspace":
      var_01 = [];
      break;

    case "sa_assassination":
      var_01 = ["iw7_atomizer", "iw7_sdfar", "iw7_sdflmg", "iw7_sdfshotty"];
      break;

    case "sa_empambush":
      var_01 = ["iw7_m8"];
      break;

    case "sa_vips":
      var_01 = ["iw7_sdfar", "iw7_sdflmg", "iw7_sdfshotty"];
      break;

    case "sa_wounded":
      var_01 = [];
      break;

    case "heist":
      var_01 = ["iw7_sdfshotty", "iw7_lockon", "iw7_lmg03"];
      break;

    case "prisoner":
      var_01 = ["iw7_sdfshotty", "iw7_kbs", "iw7_erad"];
      break;

    case "rogue":
      var_01 = ["iw7_m4", "iw7_devastator", "iw7_erad", "iw7_ar57", "iw7_steeldragon"];
      break;

    case "titan":
      var_01 = ["iw7_lockon"];
      break;

    case "sa_moon":
      var_01 = ["iw7_m4"];
      break;

    case "moon_port":
      var_01 = ["iw7_ar57"];
      break;

    case "yard":
      var_01 = ["iw7_lockon", "iw7_sdflmg", "iw7_sdfshotty", "iw7_m8"];
      break;

    case "europa":
      var_01 = [];
      break;
  }

  return var_01;
}

func_DA4C(param_00) {
  param_00 = scripts\engine\utility::array_removeundefined(param_00);
  return param_00;
}

func_12642() {
  scripts\sp\utility::func_13705();
  var_00 = ["vr_firing_range"];
  var_01 = 0;
  if(isDefined(level.template_script)) {
    var_02 = level.template_script;
    if(scripts\engine\utility::array_contains(var_00, var_02)) {
      var_01 = 1;
    }
  }

  var_03 = [];
  var_04 = func_DA17();
  foreach(var_06 in var_04) {
    if(!func_9B49(var_06)) {
      continue;
    }

    level.player _meth_84C7("weaponsLoaded", var_06, 0);
  }

  if(level.var_D9E5["loaded_weapons"].size > 0) {
    var_04 = scripts\engine\utility::array_remove_array(var_04, level.var_D9E5["loaded_weapons"]);
  }

  foreach(var_06 in var_04) {
    if(scripts\engine\utility::array_contains(func_DA17(), var_06)) {
      var_09 = "weapon_" + var_06 + "_tr";
      if(!istransientloaded(var_09)) {
        var_03 = scripts\engine\utility::array_add(var_03, var_06);
        loadtransient(var_09);
      }

      if(var_01) {
        level.player _meth_84C7("weaponsScanned", var_06, "unlocked");
      }
    }
  }

  var_03 = scripts\engine\utility::array_remove_duplicates(var_03);
  for(;;) {
    var_0B = 1;
    foreach(var_06 in var_03) {
      var_0D = "weapon_" + var_06 + "_tr";
      if(!istransientloaded(var_0D)) {
        var_0B = 0;
        break;
      } else {
        var_0E = spawnStruct();
        var_0F = func_7D5F(var_06);
        var_0E.var_13C13 = var_0F;
        var_0E.weapon_name = var_06;
        var_10 = scripts\engine\utility::weaponclass(var_06);
        if(!scripts\engine\utility::array_contains(level.var_D9E5["loaded_weapons"], var_06)) {
          level.var_D9E5["loaded_weapons"] = scripts\engine\utility::array_add(level.var_D9E5["loaded_weapons"], var_06);
          level.var_D9E5["loaded_weapon_types"][var_10] = scripts\engine\utility::array_add(level.var_D9E5["loaded_weapon_types"][var_10], var_0E);
          level.player _meth_84C7("weaponsLoaded", var_06, 1);
        }
      }
    }

    if(var_0B) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  level scripts\engine\utility::flag_set("flag_armory_weapons_loaded");
}

func_12644() {
  var_00 = func_D9FB();
  var_01 = strtok(var_00, "_");
  var_02 = var_01[5] + "_" + var_01[6] + "_" + var_01[7] + "_tr";
  if(!istransientloaded(var_02)) {
    loadtransient(var_02);
  }
}

func_1264F() {
  level notify("armory_weapons_unload");
}

func_12650() {
  level waittill("armory_weapons_unload");
  var_00 = level.var_D9E5["loaded_weapons"];
  var_01 = undefined;
  var_02 = undefined;
  var_03 = [];
  var_04 = [];
  var_05 = ["iw7_g18", "iw7_m4", "iw7_ripper"];
  var_06 = level.player getweaponslist("primary");
  var_07 = [];
  foreach(var_09 in var_06) {
    var_0A = getweaponbasename(var_09);
    if(scripts\engine\utility::array_contains(func_DA17(), var_0A)) {
      var_07 = scripts\engine\utility::array_add(var_07, var_0A);
    }
  }

  var_07 = scripts\engine\utility::array_remove_duplicates(var_07);
  var_0C = scripts\engine\utility::array_removeundefined(var_07);
  foreach(var_0F, var_0E in level.var_B8D2.var_ABFA) {
    if(var_0E.name == level.template_script) {
      var_02 = var_0F;
      break;
    }
  }

  var_10 = var_02 + 1;
  var_11 = level.var_B8D2.var_ABFA[var_10].name;
  var_12 = func_DA30(var_11);
  var_13 = func_7F7B(var_11);
  var_14 = func_DA2F(var_11);
  var_0C = scripts\engine\utility::array_combine_unique(var_0C, var_12);
  var_0C = scripts\engine\utility::array_combine_unique(var_0C, var_13);
  var_0C = scripts\engine\utility::array_combine_unique(var_0C, var_14);
  var_0C = scripts\engine\utility::array_combine_unique(var_0C, var_05);
  var_00 = scripts\engine\utility::array_remove_array(var_00, var_0C);
  foreach(var_09 in var_00) {
    if(!func_9B49(var_09)) {
      continue;
    }

    if(level.var_D9E5["loaded_weapons"].size > 18) {
      var_16 = getweaponbasename(var_09);
      var_17 = "weapon_" + var_09 + "_tr";
      scripts\sp\utility::func_1264E(var_17);
      level.var_D9E5["loaded_weapons"] = scripts\engine\utility::array_remove(level.var_D9E5["loaded_weapons"], var_16);
      level.player _meth_84C7("weaponsLoaded", var_16, 0);
      continue;
    }

    break;
  }

  func_DA54();
  func_DA53();
  level notify("armory_weapons_unloaded");
}

func_12646(param_00) {
  param_00 = getweaponbasename(param_00);
  var_01 = "weapon_" + param_00 + "_tr";
  if(istransientloaded(var_01)) {
    return;
  }

  scripts\sp\utility::func_12641(var_01);
  if(isDefined(level.var_D9E5)) {
    level.var_D9E5["loaded_weapons"] = scripts\engine\utility::array_add(level.var_D9E5["loaded_weapons"], param_00);
  } else {
    return;
  }

  var_02 = spawnStruct();
  var_03 = func_7D5F(param_00);
  var_02.var_13C13 = var_03;
  var_02.weapon_name = param_00;
  var_04 = scripts\engine\utility::weaponclass(param_00);
  level.var_D9E5["loaded_weapon_types"][var_04] = scripts\engine\utility::array_add(level.var_D9E5["loaded_weapon_types"][var_04], var_02);
}

func_12652(param_00) {
  var_01 = strtok(param_00, "+");
  if(var_01.size > 1) {
    var_02 = "weapon_" + var_01[0] + "_tr";
  } else {
    var_02 = "weapon_" + var_01 + "_tr";
  }

  scripts\sp\utility::func_1264E(var_02);
}

func_DA0C() {
  var_00 = level.player _meth_84C6("selectedLoadout");
  var_01 = level.player _meth_84C6("loadouts", var_00, "weaponSetups", 0, "weapon");
  var_02 = level.player _meth_84C6("loadouts", var_00, "weaponSetups", 1, "weapon");
  var_03 = [var_01, var_02];
  var_03 = scripts\engine\utility::array_remove_duplicates(var_03);
  foreach(var_05 in var_03) {
    if(!isDefined(var_05) || var_05 == "") {
      var_03 = scripts\engine\utility::array_remove(var_03, var_05);
    }
  }

  return var_03;
}

func_DA54() {
  foreach(var_02, var_01 in level.var_D9E5["weaponstates"]) {
    if(func_9B49(var_02)) {
      level.var_D9E5["weaponstates"][var_02] = level.player _meth_84C6("weaponsScanned", var_02);
    }
  }
}

func_DA53() {
  foreach(var_02, var_01 in level.var_D9E5["weaponstates"]) {
    if(!func_9B49(var_02)) {
      level.var_D9E5["weaponstates"][var_02] = level.player _meth_84C6("equipmentState", var_02);
    }
  }
}

func_DA52(param_00) {
  var_01 = [];
  var_02 = 0;
  if(isDefined(level.var_D9E5) && isDefined(level.var_D9E5["attachments"])) {
    var_03 = level.var_D9E5["attachments"].size;
  } else {
    var_03 = 0;
  }

  var_04 = 1;
  for(;;) {
    var_05 = tablelookupbyrow("sp\attachmenttable.csv", var_04, 4);
    var_06 = tablelookupbyrow("sp\attachmenttable.csv", var_04, 5);
    if(var_05 != "" && var_06 != "") {
      var_07 = strtok(tablelookupbyrow("sp\attachmenttable.csv", var_04, 12), ",");
      foreach(var_09 in var_07) {
        var_0A = strtok(tablelookupbyrow("sp\attachmenttable.csv", var_04, 13), ",");
        if(var_0A.size == 0) {
          var_0A[0] = "";
        }

        foreach(var_0C in var_0A) {
          var_0D = spawnStruct();
          var_0D.location = tablelookupbyrow("sp\attachmenttable.csv", var_04, 2);
          var_0D.name = tablelookupbyrow("sp\attachmenttable.csv", var_04, 3);
          var_0D.var_24A2 = var_05;
          var_0D.var_9338 = tablelookupbyrow("sp\attachmenttable.csv", var_04, 6);
          var_0D.var_9337 = tablelookupbyrow("sp\attachmenttable.csv", var_04, 20);
          var_0D.type = var_06;
          var_0D.var_9ECE = int(tablelookupbyrow("sp\attachmenttable.csv", var_04, 9));
          var_0D.var_657B = int(tablelookupbyrow("sp\attachmenttable.csv", var_04, 10));
          var_0D.baseangles = tablelookupbyrow("sp\attachmenttable.csv", var_04, 5);
          var_0D.var_13CDE = var_09;
          var_0D.var_13CCE = var_0C;
          var_01[var_09][var_0D.type][var_0C][var_0D.var_657B] = var_0D;
          if(isDefined(param_00) && !param_00) {
            level.player _meth_84C7("attachmentsState", var_0D.type, "locked");
            continue;
          }

          if(isDefined(param_00) && param_00) {
            level.player _meth_84C7("attachmentsState", var_0D.type, "unlocked");
          }
        }
      }
    } else {
      break;
    }

    var_04++;
  }

  if(!isDefined(level.var_D9E5)) {
    return var_01;
  }

  level.var_D9E5["attachments"] = var_01;
}

func_DA3D() {
  var_00 = scripts\sp\utility::func_7DB7();
  level.var_D9E5["weapon_pickups"] = [];
  foreach(var_02 in var_00) {
    var_03 = getsubstr(var_02.classname, 7);
    var_04 = weaponinventorytype(var_03);
    if(var_04 != "primary") {
      level.var_D9E5["weapon_pickups"] = scripts\engine\utility::array_add(level.var_D9E5["weapon_pickups"], var_02);
      continue;
    }

    var_05 = getweaponbasename(var_03);
    var_06 = getweaponattachments(var_03);
    if(var_06.size > 0) {
      level.var_D9E5["weapon_pickups"] = scripts\engine\utility::array_add(level.var_D9E5["weapon_pickups"], var_02);
      continue;
    }

    var_06 = build_attach_models(var_05, "random");
    if(var_05 == "iw7_gambit") {
      var_06 = build_attach_models(var_05, "random", undefined, 0, 0, 20);
    }

    if(isDefined(var_06) && var_06.size > 0) {
      var_0C = spawn("weapon_" + var_05 + "+" + var_06, var_02.origin, var_02.spawnimpulsefield);
      var_0C.angles = var_02.angles;
      var_0C.var_336 = var_02.var_336;
      var_0C.target = var_02.target;
      level.var_D9E5["weapon_pickups"] = scripts\engine\utility::array_add(level.var_D9E5["weapon_pickups"], var_0C);
      var_02 delete();
    }
  }
}

func_13BFC(param_00) {
  return func_13C05(param_00, 1);
}

func_13C44(param_00) {
  return func_13C05(param_00, 0);
}

func_13C05(param_00, param_01) {
  var_02 = [];
  var_02["weapon"] = param_00;
  var_02["weapon_changed"] = 0;
  if(isDefined(level.var_D9E5)) {
    var_03 = level.var_D9E5["attachments"];
    var_04 = getweaponbasename(param_00);
    var_05 = getsubstr(var_04, 4);
    var_06 = undefined;
    if(isDefined(var_03["zerog"]["zerog"][var_05])) {
      var_06 = var_03["zerog"]["zerog"][var_05][0].var_24A2;
    }

    if(isDefined(var_06)) {
      var_07 = getweaponattachments(param_00);
      if(param_01 && !scripts\engine\utility::array_contains(var_07, var_06)) {
        var_07 = scripts\engine\utility::array_add(var_07, var_06);
        var_07 = scripts\engine\utility::alphabetize(var_07);
        var_02["weapon_changed"] = 1;
      } else if(!param_01 && scripts\engine\utility::array_contains(var_07, var_06)) {
        var_07 = scripts\engine\utility::array_remove(var_07, var_06);
        var_07 = scripts\engine\utility::alphabetize(var_07);
        var_02["weapon_changed"] = 1;
      }

      if(var_02["weapon_changed"]) {
        var_08 = "";
        foreach(var_0A in var_07) {
          var_08 = var_08 + "+" + var_0A;
        }

        var_02["weapon"] = var_04 + var_08;
      }
    }
  }

  return var_02;
}

func_13E80(param_00, param_01) {
  var_02 = level.player getcurrentprimaryweapon();
  var_03 = level.player _meth_8519(var_02, 1);
  var_04 = getweaponbasename(var_02);
  var_05 = undefined;
  var_06 = undefined;
  var_07 = 0;
  var_08 = 0;
  var_09 = level.player getweaponslistall();
  foreach(var_0B in var_09) {
    var_0C = weaponinventorytype(var_0B);
    if(var_0C != "primary") {
      continue;
    }

    var_0D = func_13C05(var_0B, param_00);
    if(var_0D["weapon_changed"]) {
      var_0D = var_0D["weapon"];
      var_07 = level.player getweaponammostock(var_0B);
      var_08 = level.player getweaponammoclip(var_0B);
      level.player giveweapon(var_0D);
      level.player setweaponammostock(var_0D, var_07);
      level.player setweaponammoclip(var_0D, var_08);
      var_0E = getweaponbasename(var_0B);
      if(isDefined(var_04) && isDefined(var_0E) && var_04 == var_0E) {
        var_06 = var_0B;
        var_05 = var_0D;
      } else {
        level.player takeweapon(var_0B);
      }
    }
  }

  if(isDefined(var_05)) {
    level.player scripts\sp\utility::func_1C72(0);
    if(var_03) {
      var_05 = "alt_" + var_05;
    }

    if(isDefined(param_01) && param_01) {
      level.player takeweapon(var_06);
      level.player switchtoweaponimmediate(var_05);
    } else {
      level.player scripts\engine\utility::allow_weapon_switch(0);
      level.player switchtoweapon(var_05);
      level.player waittill("weapon_change");
      level.player takeweapon(var_06);
      level.player scripts\engine\utility::allow_weapon_switch(1);
    }

    level.player scripts\sp\utility::func_1C72(1);
  }
}

func_B149(param_00) {
  switch (param_00) {
    case "iw7_erad":
      return (0, 0, 0);

    case "iw7_m4":
      return (15, 25, -10);
  }

  return (0, 0, 0);
}

func_B148(param_00) {
  switch (param_00) {
    case "iw7_erad":
      return (0, 0, 0);

    case "iw7_m4":
      return (10, 200, -10);
  }

  return (0, 0, 0);
}

func_4EB7() {
  self endon("death");
  scripts\engine\utility::waitframe();
}

func_13E76() {
  level endon("stop_zero_g_magazine_throw");
  for(;;) {
    level.player waittill("reload_start");
    var_00 = level.player getcurrentweapon();
    var_01 = getweaponbasename(var_00);
    if(level.player getteamsize()) {
      wait(1.9);
      var_02 = getweaponclipmodel(var_01);
      if(var_02 != "") {
        var_02 = var_02 + "_zerog";
        var_03 = level.player getplayerangles();
        var_04 = func_B149(var_01);
        var_05 = level.player getEye() + rotatevector(var_04, var_03);
        var_06 = spawn("script_model", var_05);
        var_06 setModel(var_02);
        var_06 thread func_4EB7();
        var_07 = func_B148(var_01);
        var_08 = rotatevector(var_07, var_03);
        var_06 physics_takecontrol(1, var_05 + (0, 0, randomfloatrange(-1, -0.5)), var_08);
        var_06 scripts\engine\utility::delaythread(60, ::scripts\sp\utility::func_F1DE);
      }
    }

    while(level.player getteamsize()) {
      wait(0.05);
    }
  }
}

func_D9E7(param_00) {
  var_01 = ["launcher_05"];
  foreach(var_03 in param_00) {
    if(scripts\engine\utility::array_contains(var_01, var_03)) {
      param_00 = scripts\engine\utility::array_remove(param_00, var_03);
    }
  }

  if(isDefined(level.var_E052)) {
    param_00 = scripts\engine\utility::array_remove_array(param_00, level.var_E052);
  }

  return param_00;
}

func_13C35() {
  level.player endon("death");
  level endon("weapon_outline_disable");
  scripts\sp\utility::func_9189("new_weapon", 1, "default");
  if(level.template_script == "europa") {
    return;
  }

  level scripts\engine\utility::waittill_notify_or_timeout("starting_weapons_scanned", 2);
  foreach(var_01 in level.var_D9E5["mandatoryunlocks"]) {
    if(func_9B49(var_01)) {
      var_02 = level.player _meth_84C6("weaponsScanned", var_01);
      if(isDefined(var_02) && var_02 != "locked") {
        level.var_D9E5["mandatoryunlocks"] = scripts\engine\utility::array_remove(level.var_D9E5["mandatoryunlocks"], var_01);
      }
    }
  }

  var_04 = level.var_D9E5["weapon_pickups"];
  var_05 = level.var_D9E5["optionalunlocks"];
  thread func_13C34(var_04);
  foreach(var_01 in var_04) {
    if(isDefined(var_01)) {
      var_07 = getsubstr(var_01.classname, 7);
      var_07 = getweaponbasename(var_07);
      if(scripts\engine\utility::array_contains(var_05, var_07)) {
        var_01 scripts\sp\utility::func_9196(4, 1, 0, "new_weapon");
      }
    }
  }

  var_09 = [];
  var_0A = [];
  var_0B = [];
  var_0C = [];
  while(var_05.size > 0) {
    var_09 = getweaponarray();
    if(!scripts\sp\utility::array_compare(var_0A, var_09)) {
      var_0B = scripts\engine\utility::array_remove_array(var_09, var_0A);
      foreach(var_01 in var_0B) {
        var_07 = getsubstr(var_01.classname, 7);
        var_07 = getweaponbasename(var_07);
        if(scripts\engine\utility::array_contains(var_05, var_07)) {
          var_01 scripts\sp\utility::func_9196(4, 1, 0, "new_weapon");
        }
      }

      var_0B = [];
    }

    wait(0.5);
    var_0A = var_09;
    var_05 = scripts\engine\utility::array_combine(level.var_D9E5["mandatoryunlocks"], level.var_D9E5["optionalunlocks"]);
  }
}

func_13C34(param_00) {
  level.player endon("death");
  level endon("weapon_outline_disable");
  for(;;) {
    level waittill("weapon_scan_complete", var_01);
    var_02 = getweaponarray();
    param_00 = scripts\engine\utility::array_combine(var_02, param_00);
    param_00 = scripts\engine\utility::array_combine(param_00, level.var_D9E5["armoryweapons"]);
    var_03 = level.var_D9E5["optionalunlocks"];
    foreach(var_05 in param_00) {
      if(isDefined(var_05)) {
        var_06 = getsubstr(var_05.classname, 7);
        var_06 = getweaponbasename(var_06);
        if(var_01 == var_06) {
          var_05 scripts\sp\utility::func_9193("new_weapon");
        }
      }
    }
  }
}

func_13C33() {
  level notify("weapon_outline_disable");
  var_00 = scripts\sp\utility::func_7DB7();
  foreach(var_02 in var_00) {
    if(isDefined(var_02)) {
      var_03 = getsubstr(var_02.classname, 7);
      var_03 = getweaponbasename(var_03);
      if(func_9B49(var_03)) {
        var_02 scripts\sp\utility::func_9193();
      }
    }
  }
}

func_EBB9() {
  level.player endon("death");
  level endon("stop_scan_weapon_update");
  setdvarifuninitialized("force_weapon_scan", 0);
  if(level.template_script == "europa") {
    return;
  }

  var_00 = level.var_D9E5["attachments"];
  level.player scripts\engine\utility::waittill_notify_or_timeout("weapon_change", 2);
  var_01 = level.player getweaponslist("primary");
  var_02 = getweaponbasename(level.player getcurrentprimaryweapon());
  var_03 = undefined;
  foreach(var_05 in var_01) {
    if(level.player scripts\sp\utility::func_65DF("zero_gravity") && level.player scripts\sp\utility::func_65DB("zero_gravity")) {
      var_06 = func_13BFC(var_05);
      if(var_06["weapon_changed"]) {
        var_07 = level.player getweaponammostock(var_05);
        var_08 = level.player getweaponammoclip(var_05);
        level.player takeweapon(var_05);
        var_05 = var_06["weapon"];
        level.player giveweapon(var_05);
        level.player setweaponammostock(var_05, var_07);
        level.player setweaponammoclip(var_05, var_08);
        var_09 = getweaponbasename(var_05);
        if(var_02 == var_09) {
          var_03 = var_05;
        }
      }
    }

    var_05 = getweaponbasename(var_05);
    if(!scripts\engine\utility::array_contains(func_DA17(), var_05) || issubstr(var_05, "snow")) {
      continue;
    }

    level.var_D9E5["weaponstates"][var_05] = "unlocked";
    level.var_D9E5["optionalunlocks"] = scripts\engine\utility::array_remove(level.var_D9E5["optionalunlocks"], var_05);
    level.var_D9E5["mandatoryunlocks"] = scripts\engine\utility::array_remove(level.var_D9E5["mandatoryunlocks"], var_05);
    var_0A = level.player _meth_84C6("weaponsScanned", var_05);
    if(!isDefined(var_0A) || var_0A == "locked") {
      level.player _meth_84C7("weaponsScanned", var_05, "unlocked");
    }
  }

  if(isDefined(var_03)) {
    level.player switchtoweapon(var_03);
  }

  level notify("starting_weapons_scanned");
  childthread watch_weapon_taken_thread();
  for(;;) {
    level.player waittill("weapon_change", var_0C);
    var_09 = getweaponbasename(var_0C);
    var_0D = undefined;
    var_0E = undefined;
    var_0F = 0;
    if(!isDefined(var_09) || !scripts\engine\utility::array_contains(func_DA17(), var_09)) {
      var_0F = 1;
    }

    if(!var_0F && !scripts\engine\utility::flag("weapon_scanning_off")) {
      var_10 = func_13C46();
      if(level.player scripts\sp\utility::func_65DF("zero_gravity") && level.player scripts\sp\utility::func_65DB("zero_gravity")) {
        var_06 = func_13BFC(var_0C);
        if(var_06["weapon_changed"]) {
          var_0D = level.player getweaponammostock(var_0C);
          var_0E = level.player getweaponammoclip(var_0C);
          level.player takeweapon(var_0C);
          var_0C = var_06["weapon"];
          level.player giveweapon(var_0C);
          level.player switchtoweapon(var_0C);
        }
      } else {
        var_06 = func_13C44(var_0C);
        if(var_06["weapon_changed"]) {
          var_0D = level.player getweaponammostock(var_0C);
          var_0E = level.player getweaponammoclip(var_0C);
          level.player takeweapon(var_0C);
          var_0C = var_06["weapon"];
          level.player giveweapon(var_0C);
          level.player switchtoweapon(var_0C);
        }
      }

      if(func_9D1A(var_09) || getdvarint("force_weapon_scan") == 1) {
        thread func_EBB6(var_09);
        if(!var_10) {
          var_11 = scripts\engine\utility::weaponclass(var_09);
          switch (var_11) {
            case "pistol":
              var_12 = "ges_scan_light";
              break;

            case "sniper":
            case "rocketlauncher":
            case "mg":
              var_12 = "ges_scan_heavy";
              break;

            case "beam":
              var_12 = "ges_scan_steeldragon";
              break;

            default:
              var_12 = "ges_scan";
              break;
          }

          level.player thread scripts\sp\utility::func_D090(var_12);
        }

        level thread func_F618(var_09);
        if(getdvarint("force_weapon_scan") == 1) {
          continue;
        }
      }

      if(isDefined(var_0D)) {
        level.player setweaponammostock(var_0C, var_0D);
      }

      if(isDefined(var_0E)) {
        level.player setweaponammoclip(var_0C, var_0E);
      }
    }
  }
}

watch_weapon_taken_thread() {
  for(;;) {
    level.player waittill("weapon_taken");
    wait(0.2);
    func_3DDF(1);
  }
}

func_EBB5() {
  level.player playSound("weap_pickup_scan_plr");
  var_00 = level.player getcurrentweapon();
  var_01 = getweaponbasename(var_00);
  if(var_01 == "iw7_erad" || var_01 == "iw7_fhr" || var_01 == "iw7_counterweight" || var_01 == "iw7_sonic" || var_01 == "iw7_penetrationrail" || var_01 == "iw7_lockon" || var_01 == "iw7_sdfar" || var_01 == "iw7_gambit" || var_01 == "iw7_sdfshotty" || var_01 == "iw7_glr" || var_01 == "iw7_claw") {
    if(func_13C46()) {
      self setscriptablepartstate("weaponscan", "weaponscan_lg_on_combat");
    } else {
      self setscriptablepartstate("weaponscan", "weaponscan_lg_on");
    }
  } else if(var_01 == "iw7_kbs" || var_01 == "iw7_stasis" || var_01 == "iw7_m8" || var_01 == "iw7_cheytac" || var_01 == "iw7_lmg03" || var_01 == "iw7_sdflmg" || var_01 == "iw7_repeater" || var_01 == "iw7_m1") {
    if(func_13C46()) {
      self setscriptablepartstate("weaponscan", "weaponscan_long_on_combat");
    } else {
      self setscriptablepartstate("weaponscan", "weaponscan_long_on");
    }
  } else if(var_01 == "iw7_g18" || var_01 == "iw7_emc" || var_01 == "iw7_revolver" || var_01 == "iw7_nrg") {
    if(func_13C46()) {
      self setscriptablepartstate("weaponscan", "weaponscan_short_on_combat");
    } else {
      self setscriptablepartstate("weaponscan", "weaponscan_short_on");
    }
  } else if(var_01 == "iw7_steeldragon" || var_01 == "iw7_chargeshot" || var_01 == "iw7_mauler") {
    if(func_13C46()) {
      self setscriptablepartstate("weaponscan", "weaponscan_heavy_on_combat");
    } else if(var_01 == "iw7_chargeshot") {
      self setscriptablepartstate("weaponscan", "weaponscan_lg_on");
    } else {
      self setscriptablepartstate("weaponscan", "weaponscan_heavy_on");
    }
  } else if(func_13C46()) {
    self setscriptablepartstate("weaponscan", "weaponscan_on_combat");
  } else {
    self setscriptablepartstate("weaponscan", "weaponscan_on");
  }

  wait(4.35);
  self setscriptablepartstate("weaponscan", "weaponscan_off");
  scripts\sp\utility::func_9193();
}

func_EBB6(param_00) {
  level.player thread func_EBB5();
  wait(0.5);
  var_01 = strtok(param_00, "_");
  var_02 = undefined;
  if(isDefined(var_01[1])) {
    var_02 = "weapon_" + var_01[1];
  } else {
    return;
  }

  if(isDefined(var_02)) {
    setomnvar("ui_weapon_scanned", var_02);
    level notify("pc_weapon_scanned");
    thread func_EBB8();
  }
}

func_EBB8() {
  level endon("pc_weapon_scanned");
  wait(5.5);
  setomnvar("ui_weapon_scanned", "none");
}

func_9D1A(param_00) {
  if(!isDefined(level.var_D9E5) || !isDefined(level.var_D9E5["weaponstates"]) || !isDefined(level.var_D9E5["weaponstates"][param_00])) {
    return 0;
  }

  var_01 = level.var_D9E5["mission_specific_weapons"];
  if(level.var_D9E5["weaponstates"][param_00] == "locked") {
    return 1;
  }

  return 0;
}

func_3D6E() {
  var_00 = func_DA08();
  var_01 = 0;
  var_02 = func_D9F8();
  foreach(var_04 in var_02) {
    var_05 = level.player _meth_84C6("equipmentState", var_04);
    if(!isDefined(var_05)) {
      continue;
    }

    if(var_05 == "upgrade2") {
      var_01 = var_01 + 2;
      continue;
    }

    if(var_05 == "upgrade1") {
      var_01 = var_01 + 1;
    }
  }

  if(var_01 > 0) {
    scripts\sp\utility::settimer("FIRST_EQUIP_UPGRADE");
  }

  if(var_01 == var_00) {
    scripts\sp\utility::settimer("ALL_EQUIP_UPGRADES");
    func_EBB3("veh_mil_air_un_jackal_livery_shell_19");
  }
}

func_3DAE() {
  var_00 = 0;
  var_01 = 0;
  var_02 = func_D9FF();
  foreach(var_04 in var_02) {
    if(var_04 == "primary_default") {
      continue;
    }

    var_01++;
    var_05 = level.player _meth_84C6("jackalPrimaryState", var_04);
    if(var_05 != "locked") {
      var_00++;
    }
  }

  var_07 = func_DA01();
  foreach(var_09 in var_07) {
    if(var_09 == "secondary_default") {
      continue;
    }

    var_01++;
    var_05 = level.player _meth_84C6("jackalSecondaryState", var_09);
    if(var_05 != "locked") {
      var_00++;
    }
  }

  var_0B = func_DA03();
  foreach(var_0D in var_0B) {
    if(var_0D == "weapons" || var_0D == "hull") {
      continue;
    }

    var_01++;
    var_05 = level.player _meth_84C6("jackalUpgradeState", var_0D);
    if(var_05 != "locked") {
      var_00++;
    }
  }

  if(var_00 > 0) {
    scripts\sp\utility::settimer("FIRST_JACKAL_ITEM");
  }

  if(var_00 == var_01) {
    scripts\sp\utility::settimer("ALL_JACKAL_ITEMS");
  }
}

func_7D70(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  var_01 = func_DA17();
  var_02 = ["iw7_m4", "iw7_fhr", "iw7_m8", "iw7_g18"];
  var_02 = scripts\engine\utility::array_combine(var_02, func_DA0A());
  var_02 = scripts\engine\utility::array_combine(var_02, func_DA10());
  if(param_00) {
    var_03 = level.player _meth_84C6("weaponsScanned", "iw7_ake");
    if(!isDefined(var_03)) {
      var_03 = "locked";
    }

    if(var_03 != "locked") {
      var_02 = scripts\engine\utility::array_add(var_02, "iw7_ake");
    }
  }

  var_01 = scripts\engine\utility::array_remove_array(var_01, var_02);
  var_04 = var_01.size;
  var_05 = 0;
  foreach(var_07 in var_01) {
    var_03 = level.player _meth_84C6("weaponsScanned", var_07);
    if(!isDefined(var_03)) {
      var_03 = "locked";
    }

    if(var_03 != "locked") {
      var_05++;
    }
  }

  return [var_05, var_04];
}

func_3DDF(param_00) {
  var_01 = func_7D70(param_00);
  if(var_01[0] > 0) {
    scripts\sp\utility::settimer("SCAN_1_WEAPON");
  }

  if(var_01[0] >= 10) {
    scripts\sp\utility::settimer("SCAN_10_WEAPONS");
  }

  if(var_01[0] == var_01[1]) {
    scripts\sp\utility::settimer("SCAN_ALL_WEAPONS");
    func_EBB3("veh_mil_air_un_jackal_livery_shell_18");
  }

  return var_01;
}

func_3DDD() {
  var_00 = func_DA15();
  var_01 = 0;
  var_02 = 0;
  var_03 = scripts\sp\endmission::func_7F6B("heist");
  var_04 = scripts\sp\endmission::func_7F69(var_03);
  foreach(var_06 in var_00) {
    var_02++;
    if(tolower(var_06) == "salenkoch" || var_06 == "riah") {
      if(var_04) {
        var_01++;
      }

      continue;
    }

    var_07 = level.player _meth_84C6("wantedBoardDataState", var_06);
    if(!isDefined(var_07)) {
      continue;
    }

    if(var_07 == "obtained" || var_07 == "viewed") {
      var_01++;
    }
  }

  if(var_01 > 0) {
    scripts\sp\utility::settimer("FIRST_WANTED_BOARD");
  }

  if(var_01 > 15) {
    scripts\sp\utility::settimer("HALF_WANTED_BOARD");
  }

  if(var_01 == var_02) {
    scripts\sp\utility::settimer("ALL_WANTED_BOARD");
    func_EBB3("veh_mil_air_un_jackal_livery_shell_17");
  }
}

func_3D6A(param_00) {
  if(!isDefined(param_00) || !param_00) {
    var_01 = func_DA1B();
  } else {
    var_01 = level.var_D9E5["achievementDoorPeek"];
  }

  var_02 = 1;
  foreach(var_04 in var_01) {
    if(!var_04) {
      var_02 = 0;
    }
  }

  if(var_02) {
    scripts\sp\utility::settimer("DOOR_PEEK");
    if(isDefined(param_00) && param_00) {
      foreach(var_05, var_04 in level.var_D9E5["achievementDoorPeek"]) {
        level.player _meth_84C7(var_05, var_04);
      }
    }
  }
}

func_3D61() {
  var_00 = level.player _meth_84C6("achievementBootsOnGround");
  if(isDefined(var_00) && var_00) {
    return;
  }

  var_01 = 120;
  level.var_C538 = 0;
  var_02 = 0;
  var_03 = 0;
  for(;;) {
    var_04 = level.player.origin;
    wait(0.05);
    var_05 = level.player.origin;
    var_06 = length(var_05 - var_04);
    if(level.player iswallrunning()) {
      level.var_C538 = 0;
      var_02 = 0;
      var_03 = 0;
    } else if(level.player scripts\engine\utility::get_doublejumpenergy() < 390 && level.player isjumping()) {
      level.var_C538 = 0;
      var_02 = 0;
      var_03 = 0;
    } else if(level.player scripts\engine\utility::get_doublejumpenergy() >= 390 && !level.player isjumping() && var_06 > 1.5 && !scripts\sp\utility::func_93AC() && !level.player islinked()) {
      if(var_02 == 0) {
        var_02 = gettime() / 1000;
      }

      level.var_C538 = var_03 + gettime() / 1000 - var_02;
    } else {
      var_02 = 0;
      var_03 = level.var_C538;
    }

    if(level.var_C538 >= var_01) {
      scripts\sp\utility::settimer("NO_JUMPING");
      level.player _meth_84C7("achievementBootsOnGround", 1);
      break;
    }

    wait(0.05);
  }
}

func_F618(param_00) {
  if(!isDefined(level.var_D9E5) || !isDefined(level.var_D9E5["weaponstates"]) || !isDefined(level.var_D9E5["weaponstates"][param_00])) {
    return 0;
  }

  level.var_D9E5["weaponstates"][param_00] = "scanned";
  level.player _meth_84C7("weaponsScanned", param_00, "scanned");
  func_DA50(param_00);
  var_01 = func_3DDF();
  if(scripts\engine\utility::array_contains(level.var_D9E5["optionalunlocks"], param_00)) {
    level.var_D9E5["optionalunlocks"] = scripts\engine\utility::array_remove(level.var_D9E5["optionalunlocks"], param_00);
  }

  if(scripts\engine\utility::array_contains(level.var_D9E5["mandatoryunlocks"], param_00)) {
    level.var_D9E5["mandatoryunlocks"] = scripts\engine\utility::array_remove(level.var_D9E5["mandatoryunlocks"], param_00);
  }

  level notify("weapon_scan_complete", param_00);
  if(var_01[0] <= 2) {
    wait(1.5);
    scripts\sp\utility::func_914C("fluff_messages_new_scan", "fluff_messages_new_scan_body", "scan_intel");
  }
}

func_DA50(param_00) {
  if(!func_DA41(param_00)) {
    return;
  }

  var_01 = "";
  switch (param_00) {
    case "iw7_counterweight":
      var_01 = "mp_weapon1";
      break;

    case "iw7_gambit":
      var_01 = "mp_weapon2";
      break;

    case "iw7_repeater":
      var_01 = "mp_weapon3";
      break;

    default:
      break;
  }
}

func_13C46() {
  var_00 = 1000;
  var_01 = getaiarray("axis");
  foreach(var_03 in var_01) {
    if(distancesquared(var_03.origin, level.player.origin) < squared(var_00)) {
      return 1;
    }
  }

  if(level.player issprinting()) {
    return 1;
  }

  if(level.player scripts\sp\utility::func_9F59()) {
    return 1;
  }

  if(level.player isthrowinggrenade()) {
    return 1;
  }

  if(level.player.health < 100) {
    return 1;
  }

  if(level.player scripts\engine\utility::isflashed()) {
    return 1;
  }

  if(level.player isgestureplaying()) {
    if(!level.player isgestureplaying("ges_demeanor_safe") && !level.player isgestureplaying("ges_demeanor_relaxed")) {
      return 1;
    }
  }

  if(level.player scripts\sp\utility::func_D121()) {
    return 1;
  }

  return 0;
}

func_12BD8(param_00) {
  level.var_D9E5["mandatoryunlocks"] = scripts\engine\utility::array_remove(level.var_D9E5["mandatoryunlocks"], param_00);
  level.var_D9E5["loaded_weapon_types"] = func_DA3F();
}

func_13C61(param_00) {
  level.var_D9E5["weaponstates"][param_00] = "unlocked";
  if(scripts\engine\utility::array_contains(level.var_D9E5["optionalunlocks"], param_00)) {
    level.var_D9E5["optionalunlocks"] = scripts\engine\utility::array_remove(level.var_D9E5["optionalunlocks"], param_00);
  }

  if(!level.var_D9E5["fakedata"]) {
    level.player _meth_84C7("weaponsScanned", param_00, "unlocked");
  }

  level.var_D9E5["loaded_weapon_types"] = func_DA3F();
}

func_66A4(param_00, param_01) {
  var_02 = level.player _meth_84C6("equipmentState", param_00);
  if(isDefined(var_02) && var_02 != "locked") {
    level.var_D9E5["weaponstates"][param_00] = var_02;
    return;
  }

  if(isDefined(param_01) && param_01) {
    var_03 = "unlocked";
  } else {
    var_03 = "scanned";
  }

  level.var_D9E5["weaponstates"][param_00] = var_03;
  level.player _meth_84C7("equipmentState", param_00, var_03);
}

func_7D5F(param_00) {
  var_01 = func_DA17("sdf");
  var_02 = func_DA17("un");
  var_03 = undefined;
  if(scripts\engine\utility::array_contains(var_01, param_00)) {
    var_03 = "allies";
  } else if(scripts\engine\utility::array_contains(var_02, param_00)) {
    var_03 = "axis";
  } else {
    var_03 = "other";
  }

  return var_03;
}

func_7BEC(param_00, param_01) {
  if(!isDefined(param_01)) {
    if(param_00 == "rpg") {
      param_01 = 1;
      param_00 = "rocketlauncher";
    } else {
      param_01 = 0;
    }
  }

  var_02 = undefined;
  var_03 = undefined;
  if(isDefined(level.var_D9E5) && isDefined(level.var_D9E5["loaded_weapon_types"])) {
    var_04 = level.var_D9E5["loaded_weapon_types"][param_00];
    var_04 = scripts\engine\utility::array_randomize(var_04);
    foreach(var_06 in var_04) {
      if(func_DA41(var_06.weapon_name)) {
        continue;
      }

      if(func_DA43(var_06.weapon_name)) {
        continue;
      }

      if(param_01 || !func_DA40(var_06.weapon_name)) {
        if(var_06.var_13C13 != self.team) {
          var_02 = var_06.weapon_name;
          continue;
        }

        var_02 = var_06.weapon_name;
        break;
      }
    }
  }

  if(!isDefined(var_02)) {
    var_04 = func_DA17("un", "sdf");
    var_04 = scripts\engine\utility::array_randomize(var_04);
    foreach(var_06 in var_04) {
      var_09 = scripts\engine\utility::weaponclass(var_06);
      if(var_09 == param_00) {
        var_02 = var_06;
        break;
      }
    }
  }

  var_03 = build_attach_models(var_02, "random", param_00);
  if(isDefined(var_03)) {
    var_02 = var_02 + "+" + var_03;
  }

  return var_02;
}

func_7BEB() {
  var_00 = undefined;
  if(isDefined(level.var_D9E5) && isDefined(level.var_D9E5["loaded_equipment_types"])) {
    var_01 = level.var_D9E5["loaded_equipment_types"];
    if(var_01.size > 0) {
      var_00 = scripts\engine\utility::random(var_01);
    }
  }

  if(!isDefined(var_00)) {
    var_00 = "frag";
  }

  if(var_00 == "offhandshield" || var_00 == "coverwall" || var_00 == "supportdrone" || var_00 == "hackingdevice") {
    var_00 = "frag";
  }

  if(var_00 == "seeker") {
    var_00 = "frag";
  }

  if(var_00 == "antigrav" || var_00 == "emp") {
    if(randomint(100) < 95) {
      var_00 = "frag";
    }
  }

  return var_00;
}

func_7AEA(param_00) {
  var_01 = getweaponbasename(param_00);
  var_02 = getsubstr(var_01, 4);
  var_03 = getweaponattachments(param_00);
  var_04 = [];
  var_05 = 0;
  foreach(var_07 in var_03) {
    if(issubstr(var_07, "acog") || issubstr(var_07, "elo") || issubstr(var_07, "smart") || issubstr(var_07, "reflex") || issubstr(var_07, "phase") || issubstr(var_07, "thermal") || issubstr(var_07, "hybrid") || issubstr(var_07, "vzscope") || issubstr(var_07, "oscope") || issubstr(var_07, "snproverlay") || issubstr(var_07, "nodualfov")) {
      var_05 = 1;
      break;
    }
  }

  if(!var_05) {
    if(isDefined(level.var_D9E5["attachments"]["default"]["scope"][var_02])) {
      foreach(var_0A in level.var_D9E5["attachments"]["default"]["scope"][var_02]) {
        if(!scripts\engine\utility::array_contains(var_03, var_0A.var_24A2)) {
          var_04 = scripts\engine\utility::array_add(var_04, var_0A.var_24A2);
        }
      }
    }
  } else if(var_02 == "m8") {
    if(!scripts\engine\utility::array_contains(var_03, "arm8_sp")) {
      scripts\engine\utility::array_add(var_04, "arm8_sp");
    }
  } else if(var_02 == "ripper") {
    if(!scripts\engine\utility::array_contains(var_03, "arripper_sp")) {
      scripts\engine\utility::array_add(var_04, "arripper_sp");
    }
  }

  if(var_02 == "fmg") {
    if(!scripts\engine\utility::array_contains(var_03, "akimbofmg_sp")) {
      scripts\engine\utility::array_add(var_04, "akimbofmg_sp");
    }
  }

  return var_04;
}

build_attach_models(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(!isDefined(param_00)) {}

  if(!isDefined(param_02)) {
    param_02 = scripts\engine\utility::weaponclass(param_00);
  }

  if(!isDefined(param_05)) {
    param_05 = 1;
  }

  if(!isDefined(param_06)) {
    param_06 = 0;
  }

  var_08 = getsubstr(param_00, 4);
  var_09 = undefined;
  var_0A = 0;
  var_0B = 1;
  var_0C = [];
  var_0D = undefined;
  var_0E = undefined;
  var_0F = 0;
  var_10 = 0;
  if(isDefined(level.var_D9E5)) {
    if(isDefined(level.var_D9E5["unlocked_attachments"])) {
      var_0E = level.var_D9E5["unlocked_attachments"];
    }
  } else if(!isDefined(level.var_D9E5) || isDefined(level.var_D9E5) && !isDefined(level.var_D9E5["attachments"])) {
    var_0D = func_DA52();
    var_0E = func_DA1E();
  }

  if(!isDefined(var_0E)) {
    var_0E = ["reflex", "acog"];
  }

  if(!isDefined(var_0D) && isDefined(level.var_D9E5)) {
    var_0D = level.var_D9E5["attachments"];
    if(isDefined(level.var_D9E5["attachment_overrides"])) {
      var_0E = level.var_D9E5["attachment_overrides"];
      param_01 = "random";
    }
  } else if(!isDefined(var_0D)) {
    if(var_08 == "ar57") {
      return "ar57scope";
    } else if(var_08 == "atomizer") {
      return "atomizerscope";
    } else if(var_08 == "chargeshot") {
      return "chargeshotscope";
    } else if(var_08 == "crb") {
      return "crblscope";
    } else if(var_08 == "erad") {
      return "eradscope";
    } else if(var_08 == "fmg") {
      return "akimbofmg_sp+fmgscope";
    } else if(var_08 == "kbs") {
      return "kbsscope";
    } else if(var_08 == "lmg03") {
      return "lmg03scope";
    } else if(var_08 == "lockon") {
      return "lockonscope";
    } else if(var_08 == "m8") {
      return "m8scope_sp";
    } else if(var_08 == "penetrationrail") {
      return "penetrationrailscope";
    } else if(var_08 == "ripper") {
      return "ripperrscope_sp";
    } else if(var_08 == "sonic") {
      return "sonicscope";
    } else if(var_08 == "sdfshotty") {
      return "sdfshottyscope";
    } else {
      return;
    }
  }

  if(!isDefined(var_0D[param_02])) {
    param_01 = "default";
  }

  if(param_01 == "default") {
    param_05 = 0;
  }

  if(param_00 == "iw7_gambit") {
    var_0E = func_D9F2(0);
  }

  if(func_DA40(param_00) || param_00 == "iw7_m1") {
    param_01 = "default";
    param_05 = 0;
  } else if(param_01 == "random") {
    var_0E = scripts\engine\utility::array_remove(var_0E, "silencer");
    if(var_0E.size > 1) {
      var_0E = scripts\engine\utility::array_add(var_0E, "none");
    }

    if(isDefined(level.var_72A6)) {
      param_01 = level.var_72A6;
      if(param_05 < 3) {
        param_05++;
      }
    } else if(var_0E.size > 0) {
      param_01 = var_0E[randomint(var_0E.size)];
    } else {
      param_05 = 0;
    }
  } else if(isDefined(param_07)) {
    param_01 = param_07[0];
    param_05 = param_07.size;
  }

  var_11 = 3;
  if(isDefined(param_07)) {
    var_11 = param_07.size;
  } else if(param_00 == "iw7_gambit") {
    var_11 = 4;
  }

  var_12 = 0;
  var_13 = 0;
  for(var_14 = 0; var_14 < param_05; var_14++) {
    var_15 = undefined;
    var_16 = undefined;
    var_17 = undefined;
    if(isDefined(param_01) && param_01 != "default") {
      if(isDefined(var_0D[param_02]) && isDefined(var_0D[param_02][param_01])) {
        if(isDefined(var_0D[param_02][param_01][var_08])) {
          var_15 = var_0D[param_02][param_01][var_08][0].location;
          var_16 = var_0D[param_02][param_01][var_08][0].var_24A2;
          var_17 = var_0D[param_02][param_01][var_08][0].var_9ECE;
        } else if(weaponusesenergybullets(param_00) && isDefined(var_0D[param_02][param_01][""][1])) {
          var_15 = var_0D[param_02][param_01][""][1].location;
          var_16 = var_0D[param_02][param_01][""][1].var_24A2;
          var_17 = var_0D[param_02][param_01][""][1].var_9ECE;
        } else if(isDefined(var_0D[param_02][param_01][""][0])) {
          var_15 = var_0D[param_02][param_01][""][0].location;
          var_16 = var_0D[param_02][param_01][""][0].var_24A2;
          var_17 = var_0D[param_02][param_01][""][0].var_9ECE;
        }
      }
    }

    if(isDefined(var_16)) {
      if(var_15 == "rail") {
        if(!var_0F) {
          var_09 = var_15;
          var_0C = scripts\engine\utility::array_add(var_0C, var_16);
          var_0F = 1;
          var_12++;
          if(var_17) {
            var_0A = 1;
          }
        }
      } else if(var_15 == "undermount") {
        if(!var_10) {
          var_09 = var_15;
          var_0C = scripts\engine\utility::array_add(var_0C, var_16);
          var_10 = 1;
          var_12++;
        }
      } else {
        var_09 = var_15;
        var_0C = scripts\engine\utility::array_add(var_0C, var_16);
        var_12++;
      }
    }

    if(var_12 == var_11) {
      break;
    }

    if(isDefined(param_07)) {
      var_13++;
      if(var_13 >= param_07.size) {
        break;
      }

      param_01 = param_07[var_13];
      continue;
    }

    var_0E = scripts\engine\utility::array_remove(var_0E, param_01);
    if(var_0E.size == 0) {
      break;
    }

    param_01 = var_0E[randomint(var_0E.size)];
  }

  if(param_06) {
    var_18 = "epic" + var_08;
    if(isDefined(var_0D[param_02][var_18]) && isDefined(var_0D[param_02][var_18][var_08])) {
      var_0C = scripts\engine\utility::array_add(var_0C, var_0D[param_02][var_18][var_08][0].var_24A2);
    }
  }

  if(!isDefined(param_03) || isDefined(param_03) && !param_03 || var_0A) {
    if(var_0C.size > 0) {
      if(var_0F && !var_0A) {
        var_0B = 0;
      }
    }

    if(!getdvarint("r_reflectionProbeGenerate")) {
      if(var_0B && isDefined(var_0D["default"]["scope"][var_08])) {
        var_16 = var_0D["default"]["scope"][var_08][0].var_24A2;
        var_09 = var_0D["default"]["scope"][var_08][0].location;
        var_0C = scripts\engine\utility::array_add(var_0C, var_16);
        var_0F = 1;
      } else if(var_08 == "m8") {
        var_0C = scripts\engine\utility::array_add(var_0C, "arm8_sp");
      } else if(var_08 == "ripper") {
        var_0C = scripts\engine\utility::array_add(var_0C, "arripper_sp");
      }

      if(var_08 == "fmg" && !scripts\engine\utility::array_contains(var_0C, "epicfmg")) {
        var_0C = scripts\engine\utility::array_add(var_0C, "akimbofmg_sp");
      } else if(var_08 == "erad") {
        if(scripts\engine\utility::array_contains(var_0C, "epicerad")) {
          var_0C = scripts\engine\utility::array_add(var_0C, "epicshotgunerad_sp");
        } else {
          var_0C = scripts\engine\utility::array_add(var_0C, "shotgunerad_sp");
        }
      } else if(var_08 == "repeater") {
        var_0C = scripts\engine\utility::array_add(var_0C, "mod_ammo");
      } else if(var_08 == "stasis") {
        var_0C = scripts\engine\utility::array_add(var_0C, "mod_ads_stability_sniper");
      } else if(var_08 == "counterweight") {
        var_0C = scripts\engine\utility::array_add(var_0C, "mod_recoil");
      }
    }
  }

  if(var_08 == "devastator" && scripts\engine\utility::array_contains(var_0C, "epicdevastator")) {
    if(scripts\engine\utility::array_contains(var_0C, "smart")) {
      var_0C = scripts\engine\utility::array_remove(var_0C, "smart");
      var_0C = scripts\engine\utility::array_add(var_0C, "smartar");
    } else if(scripts\engine\utility::array_contains(var_0C, "eloshtgn")) {
      var_0C = scripts\engine\utility::array_remove(var_0C, "eloshtgn");
      var_0C = scripts\engine\utility::array_add(var_0C, "eloshtgnepicdev");
    } else if(scripts\engine\utility::array_contains(var_0C, "phaseshotgun_sp")) {
      var_0C = scripts\engine\utility::array_remove(var_0C, "phaseshotgun_sp");
      var_0C = scripts\engine\utility::array_add(var_0C, "phaseshotgunepicdev_sp");
    } else if(scripts\engine\utility::array_contains(var_0C, "reflexshotgun")) {
      var_0C = scripts\engine\utility::array_remove(var_0C, "reflexshotgun");
      var_0C = scripts\engine\utility::array_add(var_0C, "reflexshotgunepicdev");
    } else {
      var_0C = scripts\engine\utility::array_add(var_0C, "epicdevastatorads");
    }
  } else if(var_08 == "emc" && scripts\engine\utility::array_contains(var_0C, "epicemc")) {
    if(scripts\engine\utility::array_contains(var_0C, "elopstl")) {
      var_0C = scripts\engine\utility::array_remove(var_0C, "elopstl");
      var_0C = scripts\engine\utility::array_add(var_0C, "elopstlepicemc");
    } else if(scripts\engine\utility::array_contains(var_0C, "phasepstl_sp")) {
      var_0C = scripts\engine\utility::array_remove(var_0C, "phasepstl_sp");
      var_0C = scripts\engine\utility::array_add(var_0C, "phasepstlepicemc_sp");
    } else if(scripts\engine\utility::array_contains(var_0C, "reflexpstl")) {
      var_0C = scripts\engine\utility::array_remove(var_0C, "reflexpstl");
      var_0C = scripts\engine\utility::array_add(var_0C, "reflexpstlepicemc");
    } else {
      var_0C = scripts\engine\utility::array_add(var_0C, "epicemcads");
    }
  }

  var_19 = undefined;
  if(var_0C.size > 0) {
    var_0C = scripts\engine\utility::alphabetize(var_0C);
    var_19 = var_0C[0];
    for(var_14 = 1; var_14 < var_0C.size; var_14++) {
      var_19 = var_19 + "+" + var_0C[var_14];
    }
  }

  if(isDefined(param_04) && param_04) {
    return [var_19, var_0F];
  }

  return var_19;
}

func_3DDC(param_00) {
  if(param_00 == "weapon") {
    var_01 = "loaded_weapons";
  } else {
    var_01 = "weaponstates";
  }

  if(!isDefined(level.var_D9E5)) {
    return 0;
  }

  if(!isDefined(level.var_D9E5[var_01])) {
    return 0;
  }

  if(level.var_D9E5[var_01].size < 1) {
    return 0;
  }

  if(!isDefined(level.var_D9E5["weaponstates"])) {
    return 0;
  }

  return 1;
}

func_D9E8(param_00) {
  if(!isDefined(param_00)) {
    if(isDefined(level.var_D9E5["attachment_overrides"])) {
      level.var_D9E5["attachment_overrides"] = undefined;
      return;
    }

    return;
  }

  level.var_D9E5["attachment_overrides"] = param_00;
}

func_7808() {
  var_00 = strtok(tablelookup("sp\progression_unlocks.csv", 0, "all_weapons", 2), ", ");
  var_01 = strtok(tablelookup("sp\progression_unlocks.csv", 0, "all_weapons", 3), ", ");
  var_02 = scripts\engine\utility::array_combine(var_00, var_01);
  return var_02;
}

func_7807() {
  var_00 = strtok(tablelookup("sp\progression_unlocks.csv", 0, "all_weapons", 5), ", ");
  return var_00;
}

func_7806() {
  var_00 = strtok(tablelookup("sp\progression_unlocks.csv", 0, "all_weapons", 6), ", ");
  return var_00;
}

func_D9EF(param_00, param_01) {
  var_02 = [];
  foreach(var_04 in param_01) {
    var_05 = level.player _meth_84C6(param_00, var_04);
    if(!isDefined(level.player _meth_84C6(param_00, var_04))) {
      continue;
    }

    if(level.player _meth_84C6(param_00, var_04) == "scanned") {
      var_02 = scripts\engine\utility::array_add(var_02, var_04);
    }
  }

  return var_02;
}

func_DA0E() {
  var_00 = [];
  var_01 = func_DA12();
  var_00["suit_upgrades"] = func_D9EF("suitUpgradeState", var_01);
  var_02 = func_D9FC();
  var_00["jackal_decals"] = func_D9EF("jackalDecals", var_02);
  var_03 = func_D9FF();
  var_00["jackal_primaries"] = func_D9EF("jackalPrimaryState", var_03);
  var_04 = func_DA01();
  var_00["jackal_secondaries"] = func_D9EF("jackalSecondaryState", var_04);
  var_05 = func_DA03();
  var_00["jackal_upgrades"] = func_D9EF("jackalUpgradeState", var_05);
  var_06 = func_D9F2();
  var_00["attachments"] = func_D9EF("attachmentsState", var_06);
  var_07 = func_DA0D();
  var_00["reticles"] = func_D9EF("reticlesState", var_07);
  var_08 = func_D9F3();
  var_00["camos"] = func_D9EF("camosState", var_08);
  return var_00;
}

func_DA3C() {
  var_00 = func_DA15();
  var_01 = 1;
  var_02 = [];
  foreach(var_04 in var_00) {
    var_05 = level.player _meth_84C6("wantedBoardDataState", var_04);
    if(!isDefined(var_05) || var_05 != "obtained" && var_05 != "viewed") {
      var_01 = 0;
    }

    var_02[var_04] = var_05;
  }

  return var_02;
}

func_DA56(param_00, param_01) {
  level.var_D9E5["wanted_cards"][param_00] = param_01;
}

func_DA1B() {
  var_00 = [];
  var_00["achievementDoorPeekOpen"] = level.player _meth_84C6("achievementDoorPeekOpen");
  var_00["achievementDoorPeekKick"] = level.player _meth_84C6("achievementDoorPeekKick");
  var_00["achievementDoorPeekGrenade"] = level.player _meth_84C6("achievementDoorPeekGrenade");
  return var_00;
}

func_DA08() {
  return 12;
}

func_DA4F() {
  var_00 = level.player _meth_84C6("scrapCount");
  if(!isDefined(var_00)) {
    var_00 = 0;
  }

  var_01 = func_DA38();
  foreach(var_08, var_03 in var_01) {
    foreach(var_07, var_05 in var_03) {
      if(int(var_05) <= var_00) {
        if(var_08 == "attachment") {
          var_06 = level.player _meth_84C6("attachmentsState", var_07);
          if(var_06 == "locked") {
            level.player _meth_84C7("attachmentsState", var_07, "scanned");
          }

          continue;
        }

        if(var_08 == "reticle") {
          var_06 = level.player _meth_84C6("reticlesState", var_07);
          if(var_06 == "locked") {
            level.player _meth_84C7("reticlesState", var_07, "scanned");
          }
        }
      }
    }
  }

  func_DA0E();
}

func_DA4E() {
  foreach(var_01 in level.var_D9E5["scanned_items"]["suit_upgrades"]) {
    level.player _meth_84C7("suitUpgradeState", var_01, "unlocked");
  }
}

func_DA48() {
  foreach(var_01 in level.var_D9E5["scanned_items"]["suit_upgrades"]) {
    level.player _meth_84C7("suitUpgradeState", var_01, "unlocked");
  }

  foreach(var_01 in level.var_D9E5["scanned_items"]["jackal_decals"]) {
    level.player _meth_84C7("jackalDecals", var_01, "unlocked");
  }

  foreach(var_01 in level.var_D9E5["scanned_items"]["jackal_primaries"]) {
    level.player _meth_84C7("jackalPrimaryState", var_01, "unlocked");
  }

  foreach(var_01 in level.var_D9E5["scanned_items"]["jackal_secondaries"]) {
    level.player _meth_84C7("jackalSecondaryState", var_01, "unlocked");
  }

  foreach(var_01 in level.var_D9E5["scanned_items"]["jackal_upgrades"]) {
    level.player _meth_84C7("jackalUpgradeState", var_01, "unlocked");
  }

  foreach(var_01 in level.var_D9E5["scanned_items"]["attachments"]) {
    level.player _meth_84C7("attachmentsState", var_01, "unlocked");
  }

  foreach(var_01 in level.var_D9E5["scanned_items"]["reticles"]) {
    level.player _meth_84C7("reticlesState", var_01, "unlocked");
  }

  foreach(var_01 in level.var_D9E5["scanned_items"]["camos"]) {
    level.player _meth_84C7("camosState", var_01, "unlocked");
  }

  foreach(var_13, var_12 in level.var_D9E5["weaponstates"]) {
    if(func_9B49(var_13) && var_12 == "scanned") {
      level.var_D9E5["weaponstates"][var_13] = "unlocked";
      level.player _meth_84C7("weaponsScanned", var_13, "unlocked");
    }
  }
}

func_D9F0(param_00, param_01) {
  var_02 = [];
  foreach(var_04 in param_01) {
    if(!isDefined(level.player)) {
      continue;
    }

    var_05 = level.player _meth_84C6(param_00, var_04);
    if(!isDefined(var_05)) {
      continue;
    }

    if((isstring(var_05) && level.player _meth_84C6(param_00, var_04) == "unlocked") || !isstring(var_05) && level.player _meth_84C6(param_00, var_04) == 1) {
      var_02 = scripts\engine\utility::array_add(var_02, var_04);
    }
  }

  return var_02;
}

func_D9EC(param_00) {
  if(!isDefined(level.var_D9E5["ace_pilots"])) {
    return "acepilot0";
  }

  if(!isDefined(level.var_D9E5["ace_pilots"][param_00])) {
    return "acepilot0";
  }

  return level.var_D9E5["ace_pilots"][param_00];
}

func_DA45(param_00, param_01) {
  if(!isDefined(level.var_D9E5)) {
    return;
  }

  if(!isDefined(level.var_D9E5["wanted_cards"])) {
    return;
  }

  if(!isDefined(level.var_D9E5["wanted_cards"][param_00])) {
    return;
  }

  var_02 = level.var_D9E5["wanted_cards"][param_00];
  if(var_02 == "locked") {
    level.var_D9E5["wanted_cards"][param_00] = "obtained";
  }

  if(isDefined(param_01)) {
    wait(param_01);
  }

  var_03 = "most_wanted_portait_" + param_00;
  scripts\sp\utility::func_914C("mostwanted_target_killed", "mostwanted_" + param_00 + "_killed", "intel_" + param_00);
}

func_12E18() {
  if(!isDefined(level.var_D9E5)) {
    return;
  }

  if(func_9CBB(level.template_script)) {
    func_DA48();
  }

  foreach(var_01 in level.var_D9E5["suit_upgrades"]) {
    level.player _meth_84C7("suitUpgradeState", var_01, "unlocked");
  }

  foreach(var_01 in level.var_D9E5["mandatory_suit_upgrades"]) {
    var_04 = level.player _meth_84C6("suitUpgradeState", var_01);
    if(var_04 == "locked") {
      level.player _meth_84C7("suitUpgradeState", var_01, "scanned");
    }
  }

  foreach(var_07 in level.var_D9E5["mandatory_jackal_primaries"]) {
    var_04 = level.player _meth_84C6("jackalPrimaryState", var_07);
    if(var_04 == "locked") {
      level.player _meth_84C7("jackalPrimaryState", var_07, "scanned");
    }
  }

  foreach(var_0A in level.var_D9E5["mandatory_jackal_secondaries"]) {
    var_04 = level.player _meth_84C6("jackalSecondaryState", var_0A);
    if(var_04 == "locked") {
      level.player _meth_84C7("jackalSecondaryState", var_0A, "scanned");
    }
  }

  foreach(var_0D in level.var_D9E5["mandatory_jackal_upgrades"]) {
    var_04 = level.player _meth_84C6("jackalUpgradeState", var_0D);
    if(var_04 == "locked") {
      level.player _meth_84C7("jackalUpgradeState", var_0D, "scanned");
    }
  }

  foreach(var_10 in level.var_D9E5["mandatory_jackal_decals"]) {
    var_04 = level.player _meth_84C6("jackalDecals", var_10);
    if(var_04 == "locked") {
      level.player _meth_84C7("jackalDecals", var_10, "scanned");
    }
  }

  func_3DAE();
  foreach(var_13, var_04 in level.var_D9E5["wanted_cards"]) {
    level.player _meth_84C7("wantedBoardDataState", var_13, var_04);
  }

  func_3DDD();
  foreach(var_16, var_15 in level.var_D9E5["achievementDoorPeek"]) {
    level.player _meth_84C7(var_16, var_15);
  }

  func_3D6A();
  foreach(var_18, var_04 in level.var_D9E5["weaponstates"]) {
    if(func_9B49(var_18)) {
      level.player _meth_84C7("weaponsScanned", var_18, var_04);
    }
  }

  if(isDefined(level.template_script)) {
    level.player _meth_84C7("lastCompletedMission", level.template_script);
    game["lastcompletedmission"] = level.template_script;
  }

  if(level.var_D9E5["submission"] != "submission") {
    level.player _meth_84C7("missionStateData", level.var_D9E5["submission"], "complete");
    level.player _meth_84C7("opsmapMissionStateData", level.var_D9E5["submission"], "complete");
  }
}

func_9B49(param_00) {
  var_01 = func_D9F8();
  if(func_9B44(param_00)) {
    return 0;
  }

  if(param_00 == "none") {
    return 0;
  }

  return !scripts\engine\utility::array_contains(var_01, param_00);
}

func_9B44(param_00) {
  var_01 = func_D9FC();
  foreach(var_03 in var_01) {
    if(issubstr(var_03, param_00)) {
      return 1;
    }
  }

  return 0;
}

func_EBB7(param_00) {
  if(level.player _meth_84C6("weaponsScanned", param_00) == "locked") {
    level.player _meth_84C7("weaponsScanned", param_00, "scanned");
    func_DA50(param_00);
  }
}

func_EBB3(param_00) {
  if(level.player _meth_84C6("jackalDecals", param_00) == "locked") {
    level.player _meth_84C7("jackalDecals", param_00, "scanned");
  }
}

func_5F2F() {
  for(var_00 = 0; var_00 < level.var_B8D2.var_ABFA.size; var_00++) {
    if(scripts\sp\endmission::getitemslot(var_00)) {
      continue;
    }

    var_01 = scripts\sp\endmission::func_7F69(var_00);
    var_02 = level.player _meth_84C6("missionStateData", scripts\sp\endmission::func_7F6D(var_00));
    if(var_01 == 1) {
      var_02 = "COMPLETE - Recruit";
      continue;
    }

    if(var_01 == 2) {
      var_02 = "COMPLETE - Regular";
      continue;
    }

    if(var_01 == 3) {
      var_02 = "COMPLETE - Hardened";
      continue;
    }

    if(var_01 == 4) {
      var_02 = "COMPLETE - Veteran";
      continue;
    }

    if(var_01 == 5) {
      var_02 = "COMPLETE - Specialist";
      continue;
    }

    if(var_01 == 6) {
      var_02 = "COMPLETE - YOLO";
    }
  }

  foreach(var_04 in func_DA17()) {
    if(func_9B49(var_04)) {
      if(!func_DA41(var_04) && !func_DA43(var_04)) {}
    }
  }

  foreach(var_04 in func_DA17()) {
    if(func_9B49(var_04)) {
      if(func_DA41(var_04)) {}
    }
  }

  foreach(var_04 in func_DA17()) {
    if(func_9B49(var_04)) {
      if(func_DA43(var_04)) {}
    }
  }

  foreach(var_0B in func_D9F2()) {}

  foreach(var_0E in func_D9F8()) {
    if(!func_9B49(var_0E)) {}
  }

  foreach(var_11 in func_DA15()) {}

  foreach(var_14 in func_DA12()) {}

  foreach(var_17 in func_D9FF()) {}

  foreach(var_17 in func_DA01()) {}

  foreach(var_17 in func_DA03()) {}

  foreach(var_1E in func_D9FC()) {}

  var_20 = func_7AF1("sub");
  foreach(var_22 in var_20) {
    var_23 = func_DA22(var_22);
    if(var_23 == 0 && var_22 != "rogue") {
      continue;
    }

    var_24 = 1;
    if(var_22 == "sa_wounded") {
      var_24 = 2;
    }

    var_23 = var_23 / var_24;
    for(var_25 = 0; var_25 < var_24; var_25++) {
      var_26 = level.player _meth_84C6("missionLootRooms", var_22, "discovered", var_25);
      if(var_26) {} else {}

      for(var_27 = 0; var_27 < 1; var_27++) {
        var_28 = var_25 * 2 + var_27;
        var_29 = level.player _meth_84C6("missionLootRooms", var_22, "terminal", var_28);
        if(var_29) {
          continue;
        }
      }
    }
  }

  for(var_2B = 0; var_2B < 4; var_2B++) {
    var_2C = level.player _meth_84C6("loadouts", var_2B, "name");
    var_2D = level.player _meth_84C6("loadouts", var_2B, "weaponSetups", 0, "weapon");
    var_2E[0] = level.player _meth_84C6("loadouts", var_2B, "weaponSetups", 0, "attachment", 0);
    var_2E[1] = level.player _meth_84C6("loadouts", var_2B, "weaponSetups", 0, "attachment", 1);
    var_2E[2] = level.player _meth_84C6("loadouts", var_2B, "weaponSetups", 0, "attachment", 2);
    var_2F = level.player _meth_84C6("loadouts", var_2B, "weaponSetups", 1, "weapon");
    var_30[0] = level.player _meth_84C6("loadouts", var_2B, "weaponSetups", 1, "attachment", 0);
    var_30[1] = level.player _meth_84C6("loadouts", var_2B, "weaponSetups", 1, "attachment", 1);
    var_30[2] = level.player _meth_84C6("loadouts", var_2B, "weaponSetups", 1, "attachment", 2);
    var_31 = level.player _meth_84C6("loadouts", var_2B, "equipment", 0);
    var_32 = level.player _meth_84C6("loadouts", var_2B, "offhandEquipment", 0);
    var_33 = level.player _meth_84C6("loadouts", var_2B, "equipment", 1);
    var_34 = level.player _meth_84C6("loadouts", var_2B, "offhandEquipment", 1);
  }

  if(level.player _meth_84C6("unlockedRealism")) {} else {}

  if(level.player _meth_84C6("beatRealism")) {} else {}

  if(level.player _meth_84C6("achievementDoorPeekOpen")) {} else {}

  if(level.player _meth_84C6("achievementDoorPeekKick")) {} else {}

  if(level.player _meth_84C6("achievementDoorPeekGrenade")) {} else {}
}

func_E222() {
  level.player _meth_84C7("scrapCount", 0);
  foreach(var_01 in func_DA12()) {
    level.player _meth_84C7("suitUpgradeState", var_01, "locked");
  }

  foreach(var_04 in func_D9FF()) {
    level.player _meth_84C7("jackalPrimaryState", var_04, "locked");
  }

  foreach(var_07 in func_DA01()) {
    level.player _meth_84C7("jackalSecondaryState", var_07, "locked");
  }

  foreach(var_0A in func_DA03()) {
    level.player _meth_84C7("jackalUpgradeState", var_0A, "locked");
  }

  foreach(var_0D in func_D9FC()) {
    level.player _meth_84C7("jackalDecals", var_0D, "locked");
  }

  foreach(var_10 in func_DA15()) {
    level.player _meth_84C7("wantedBoardDataState", var_10, "locked");
  }

  foreach(var_13 in func_DA17()) {
    if(func_DA41(var_13)) {
      continue;
    }

    if(func_DA43(var_13)) {
      continue;
    }

    if(func_9B49(var_13)) {
      level.player _meth_84C7("weaponsScanned", var_13, "locked");
      continue;
    }

    level.player _meth_84C7("equipmentState", var_13, "locked");
  }

  var_15 = func_D9F2(1);
  foreach(var_17 in var_15) {
    level.player _meth_84C7("attachmentsState", var_17, "locked");
  }

  var_19 = func_DA0D();
  foreach(var_1B in var_19) {
    level.player _meth_84C7("reticlesState", var_1B, "locked");
  }

  var_1D = func_D9F3();
  foreach(var_1F in var_1D) {
    level.player _meth_84C7("camosState", var_1F, "locked");
  }

  var_21 = func_DA15();
  foreach(var_23 in var_21) {
    level.player _meth_84C7("wantedBoardDataState", var_23, "locked");
  }

  level.player _meth_84C7("currentLoadout", "levelCreated", 0);
  level.player _meth_84C7("currentLoadout", "heldWeapon", "none");
  for(var_25 = 0; var_25 < 2; var_25++) {
    level.player _meth_84C7("currentLoadout", "weaponSetups", var_25, "weapon", "none");
    level.player _meth_84C7("currentLoadout", "weaponSetups", var_25, "reticle", "none");
    level.player _meth_84C7("currentLoadout", "weaponClipAmmo", var_25, 0);
    level.player _meth_84C7("currentLoadout", "weaponStockAmmo", var_25, 0);
    for(var_26 = 0; var_26 < 3; var_26++) {
      level.player _meth_84C7("currentLoadout", "weaponSetups", var_25, "attachment", var_26, "none");
    }
  }

  level.player _meth_84C7("currentLoadout", "offhandEquipment", 0, "none");
  level.player _meth_84C7("currentLoadout", "offhandEquipmentAmmo", 0, 0);
  level.player _meth_84C7("currentLoadout", "offhandEquipment", 1, "none");
  level.player _meth_84C7("currentLoadout", "offhandEquipmentAmmo", 1, 0);
  level.player _meth_84C7("currentLoadout", "equipment", 0, "none");
  level.player _meth_84C7("currentLoadout", "equipmentAmmo", 0, 0);
  level.player _meth_84C7("currentLoadout", "equipment", 1, "none");
  level.player _meth_84C7("currentLoadout", "equipmentAmmo", 1, 0);
  level.player _meth_84C7("lastCompletedMission", "");
  level.player _meth_84C7("lastShipcribMission", "");
  level.player _meth_84C7("lastWeaponPreload", "");
  level.player _meth_84C7("currentViewModel", "");
  level.player _meth_84C7("currentSelectedWeapon", "");
  level.player _meth_84C7("jackalDecal", "none");
  level.player _meth_84C7("selectedLoadout", 0);
  level.player _meth_84C7("forcedAttachment", "none");
  level.player _meth_84C7("scTitanFirstPlay", 0);
  level.player _meth_84C7("scPrisonerFirstPlay", 0);
  level.player _meth_84C7("scTaughtVR", 0);
  level.player _meth_84C7("scTaughtVREnergy", 0);
  level.player _meth_84C7("scTaughtVRMenu", 0);
  level.player _meth_84C7("scTaughtWantedBoard", 0);
  level.player _meth_84C7("scTaughtOpsmap", 0);
  level.player _meth_84C7("c12AchievementRodeoLeft", 0);
  level.player _meth_84C7("c12AchievementRodeoRight", 0);
  level.player _meth_84C7("c12AchievementSelfdestruct", 0);
  level.player _meth_84C7("hintAltM8", 0);
  level.player _meth_84C7("hintAltFMG", 0);
  level.player _meth_84C7("hintAltRipper", 0);
  level.player _meth_84C7("hintAltERAD", 0);
  var_27 = func_7AF1("sub");
  foreach(var_29 in var_27) {
    for(var_2A = 0; var_2A < 2; var_2A++) {
      level.player _meth_84C7("missionLootRooms", var_29, "discovered", var_2A, 0);
      for(var_2B = 0; var_2B < 2; var_2B++) {
        var_2C = var_2A * 2 + var_2B;
        level.player _meth_84C7("missionLootRooms", var_29, "terminal", var_2B, 0);
      }
    }

    level.player _meth_84C7("missionStateData", var_29, "locked");
    level.player _meth_84C7("opsmapMissionStateData", var_29, "locked");
  }

  var_2E = func_7AF1("main", "sub");
  foreach(var_30 in var_2E) {
    level.player _meth_84C7("shipAssaultStateData", var_30, "locked");
  }

  func_492B(1);
  func_5F2F();
}