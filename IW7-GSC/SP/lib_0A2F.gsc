/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\lib_0A2F.gsc
*********************************************/

func_7AF1(var_0, var_1) {
  var_2 = ["yard", "mars", "heist", "prisoner", "rogue", "titan", "sa_moon", "moon_port", "pearlharbor", "europa"];
  var_3 = ["sa_assassination", "sa_empambush", "sa_vips", "sa_wounded", "ja_spacestation", "ja_asteroid", "ja_mining", "ja_titan", "ja_wreckage"];
  var_4 = ["shipcrib_epilogue", "shipcrib_titan", "shipcrib_europa", "shipcrib_moon", "shipcrib_rogue", "shipcrib_prisoner", "phparade", "phspace", "phstreets", "marscrash", "marscrib", "marsbase", "moonjackal", "titanjackal", "heistspace"];
  if((isDefined(var_0) && var_0 == "main") || isDefined(var_1) && var_1 == "main") {
    var_2 = [];
  }

  if((isDefined(var_0) && var_0 == "sa") || isDefined(var_1) && var_1 == "sa") {
    var_3 = [];
  }

  if((isDefined(var_0) && var_0 == "sub") || isDefined(var_1) && var_1 == "sub") {
    var_4 = [];
  }

  var_5 = [];
  var_5 = scripts\engine\utility::array_combine(var_3, var_2);
  var_5 = scripts\engine\utility::array_combine(var_5, var_4);
  var_5 = scripts\engine\utility::array_remove_duplicates(var_5);
  return var_5;
}

func_7AEB() {
  var_0 = ["dh_test", "dk_test", "jku_test", "ma_test", "vr_firing_range"];
  return var_0;
}

func_9CBB(var_0) {
  var_1 = ["shipcrib_epilogue", "shipcrib_titan", "shipcrib_europa", "shipcrib_moon", "shipcrib_rogue", "shipcrib_prisoner", "marscrib"];
  return scripts\engine\utility::array_contains(var_1, var_0);
}

is_jackal_arena_level(var_0) {
  var_1 = ["ja_spacestation", "ja_asteroid", "ja_mining", "ja_titan", "ja_wreckage"];
  return scripts\engine\utility::array_contains(var_1, var_0);
}

func_DA17(var_0, var_1) {
  var_2 = ["iw7_fhr", "iw7_crb", "iw7_ripper", "iw7_ar57", "iw7_m4", "iw7_devastator", "iw7_kbs", "iw7_steeldragon", "iw7_mauler", "iw7_lockon", "iw7_g18", "iw7_m1", "iw7_ake_gold"];
  var_3 = ["iw7_emc", "iw7_ake", "iw7_nrg", "iw7_erad", "iw7_m8", "iw7_fmg", "iw7_sonic", "iw7_sdfshotty", "iw7_sdfar", "iw7_sdflmg", "iw7_lmg03", "iw7_chargeshot", "iw7_penetrationrail", "iw7_ump45", "iw7_atomizer"];
  var_4 = ["iw7_ar57", "iw7_fhr", "iw7_g18", "iw7_devastator", "iw7_kbs", "iw7_ake", "iw7_sdflmg", "iw7_steeldragon"];
  if((isDefined(var_0) && var_0 == "un") || isDefined(var_1) && var_1 == "un") {
    var_2 = [];
  }

  if((isDefined(var_0) && var_0 == "sdf") || isDefined(var_1) && var_1 == "sdf") {
    var_3 = [];
  }

  var_5 = [];
  var_5 = scripts\engine\utility::array_combine(var_2, var_3);
  var_5 = scripts\engine\utility::array_remove_duplicates(var_5);
  if(var_5.size < 1) {
    var_5 = var_4;
  }

  return var_5;
}

func_D9F7() {
  var_0 = ["iw7_g18", "iw7_m4", "iw7_ripper"];
  return var_0;
}

func_D9F8(var_0) {
  var_1 = ["frag", "emp", "seeker", "antigrav"];
  var_2 = ["supportdrone", "offhandshield", "hackingdevice", "coverwall"];
  if(isDefined(var_0) && var_0 == "offhands") {
    var_1 = [];
  }

  if(isDefined(var_0) && var_0 == "items") {
    var_2 = [];
  }

  var_3 = scripts\engine\utility::array_combine(var_1, var_2);
  return var_3;
}

func_D9FA() {
  var_0 = ["iw7_steeldragon", "iw7_chargeshot", "iw7_lockon", "iw7_atomizer", "iw7_penetrationrail"];
  return var_0;
}

func_DA40(var_0) {
  if(scripts\engine\utility::array_contains(func_D9FA(), getweaponbasename(var_0))) {
    return 1;
  }

  return 0;
}

func_DA0A() {
  var_0 = ["iw7_stasis", "iw7_repeater", "iw7_gambit", "iw7_counterweight"];
  return var_0;
}

func_DA10() {
  var_0 = ["iw7_m1", "iw7_ake_gold"];
  return var_0;
}

func_DA41(var_0) {
  if(scripts\engine\utility::array_contains(func_DA0A(), getweaponbasename(var_0))) {
    return 1;
  }

  return 0;
}

func_DA43(var_0) {
  if(scripts\engine\utility::array_contains(func_DA10(), getweaponbasename(var_0))) {
    return 1;
  }

  return 0;
}

func_DA42(var_0) {
  if(func_9B44(var_0)) {
    return 0;
  }

  if(scripts\engine\utility::weaponclass(var_0) != "rifle" && scripts\engine\utility::weaponclass(var_0) != "mg") {
    return 0;
  }

  return !func_DA40(var_0);
}

func_DA12() {
  var_0 = ["steadyaim", "quickdraw", "blastshield", "quickswap", "agility", "fastreload", "extraequipment", "fastregen", "focus", "slasher", "shocker"];
  return var_0;
}

func_D9FF() {
  var_0 = ["primary_default", "primary_upgrade_1", "primary_upgrade_2"];
  return var_0;
}

func_DA01() {
  var_0 = ["secondary_default", "secondary_upgrade_1", "secondary_upgrade_2"];
  return var_0;
}

func_DA03() {
  var_0 = ["weapons", "thrusters", "hull"];
  return var_0;
}

func_D9FC() {
  var_0 = ["veh_mil_air_un_jackal_livery_shell_01", "veh_mil_air_un_jackal_livery_shell_02", "veh_mil_air_un_jackal_livery_shell_03", "veh_mil_air_un_jackal_livery_shell_04", "veh_mil_air_un_jackal_livery_shell_05", "veh_mil_air_un_jackal_livery_shell_06", "veh_mil_air_un_jackal_livery_shell_07", "veh_mil_air_un_jackal_livery_shell_08", "veh_mil_air_un_jackal_livery_shell_09", "veh_mil_air_un_jackal_livery_shell_10", "veh_mil_air_un_jackal_livery_shell_11", "veh_mil_air_un_jackal_livery_shell_12", "veh_mil_air_un_jackal_livery_shell_13", "veh_mil_air_un_jackal_livery_shell_14", "veh_mil_air_un_jackal_livery_shell_15", "veh_mil_air_un_jackal_livery_shell_16", "veh_mil_air_un_jackal_livery_shell_17", "veh_mil_air_un_jackal_livery_shell_18", "veh_mil_air_un_jackal_livery_shell_19", "veh_mil_air_un_jackal_livery_shell_20", "veh_mil_air_un_jackal_livery_shell_21", "veh_mil_air_un_jackal_livery_shell_22"];
  return var_0;
}

func_DA15() {
  var_0 = ["salenKoch", "riah", "captain0", "captain1", "captain2", "captain3", "captain4", "captain5", "captain6", "captain7", "captain8", "captain9", "acepilot0", "acepilot1", "acepilot2", "acepilot3", "acepilot4", "acepilot5", "acepilot6", "acepilot7", "acepilot8", "acepilot9", "acepilot10", "acepilot11", "acepilot12", "acepilot13", "acepilot14", "acepilot15", "acepilot16", "acepilot17", "acepilot18", "acepilot19"];
  return var_0;
}

func_DA09() {
  var_0 = ["europa", "pearlharbor", "phparade", "phstreets", "phspace", "shipcrib_moon", "moon_port", "moonjackal", "sa_moon", "shipcrib_europa", "sa_vips", "sa_empambush", "sa_wounded", "sa_assassination", "shipcrib_titan", "titan", "titanjackal", "ja_spacestation", "ja_asteroid", "ja_wreckage", "shipcrib_rogue", "ja_titan", "rogue", "shipcrib_prisoner", "ja_mining", "prisoner", "heist", "heistspace", "mars", "marscrash", "marscrib", "marsbase", "yard", "shipcrib_epilogue"];
  return var_0;
}

func_D9F2(var_0) {
  var_1 = ["acog", "elo", "smart", "akimbo", "oscope", "reflect", "xmags", "reflex", "phase", "thermal", "hybrid", "vzscope", "silencer", "barrelrange", "grip", "cpu", "rof", "fastaim", "scope", "nodualfov", "snproverlay"];
  if(isDefined(var_0) && !var_0) {
    return var_1;
  }

  var_2 = ["epicar57", "epicm4", "epicake", "epicsdfar", "epicfmg", "epicmauler", "epicsdflmg", "epiclmg03", "epicerad", "epiccrb", "epicripper", "epicfhr", "epicm8", "epickbs", "epicsdfshotty", "epicdevastator", "epicsonic", "epicemc", "epicnrg", "epicg18", "epicump45"];
  return scripts\engine\utility::array_combine(var_1, var_2);
}

func_D9F1() {
  var_0 = ["acog", "acogake", "acogake_gold", "acogsmg", "acogsmgnoalt", "acogpistol", "acoglmg", "acogarnoalt", "acogkbs", "acogm8", "acogm4", "acoglmgnoalt", "reflex", "reflexake_gold", "reflexake", "reflexfmg", "reflexshotgun", "reflexsmg", "reflexlmg", "reflexpstl", "reflexnrg", "phase_sp", "phaseake_sp", "phaseake_spgold", "phasefmg_sp", "phaseshotgun_sp", "phasesmg_sp", "phaselmg_sp", "phasepstl_sp", "phasenrg_sp", "thermal", "thermalake", "thermalake_gold", "thermalfmg", "thermalsmg", "thermallmg", "thermalkbs", "thermalm8", "thermalm4", "hybrid", "hybridake", "hybridake_gold", "hybridarnoalt", "hybridsmg", "hybridsmgnoalt", "hybridlmg", "elo", "eloake", "eloake_gold", "elofmg", "elodmr", "elolmg", "elopstl", "elonrg", "eloshtgn", "elosmg", "elokbs", "elom8", "vzscope", "kbsvzscope", "oscope", "kbsoscope", "smart", "silencer", "silencersmg", "silencerpstl", "silencershtgn", "silencerdmr", "silencersnpr", "silencersniperhide", "silencersniperhidee", "silencere", "silencere_gold", "silencerefmg", "silencersmge", "silencerpstle", "silencershtgne", "silencersnpre", "silencershtgns", "barrelrange", "barrelrangesmg", "barrelrangepstl", "barrelrangeshtgn", "barrelrangedmr", "barrelrangesmge", "barrelrangee", "barrelrangepstle", "barrelrangeshtgne", "barrelrangeshtgns_sp", "grip", "griphide", "griphide", "gripake", "gripake_gold", "gripar57", "gripm4", "gripsdfar", "gripcrbl", "gripripperr", "gripump45l", "gripsnpr", "gripsnpr", "gripfmg", "gripshtgn", "gripsdfshotty", "gripdevastator", "cpu", "akimbo", "akimboemc", "akimbonrg", "akimbog18", "akimbofmg_sp", "reflect", "rof", "rof", "rofar", "rofar", "rofshtgn", "rofshtgn", "roflmg", "roflmg", "rofdmr", "rofsnpr", "rofsnpr", "rofburst", "xmags", "xmagse", "xmagsepstl", "xmagsenrg", "xmagselmg", "xmagseshtgn", "xmagseshtgnpump", "fastaim", "fastaimsnpr", "fastaimdmr", "chargeshotscope", "ripperrscope_sp", "eradscope", "ump45lscope", "crblscope", "ar57scope", "fmgscope", "kbsscope", "kbsscope", "m8scope_sp", "lockonscope", "arm8_sp", "arripper_sp", "shotgunerad_sp", "atomizerscope", "lmg03scope", "sonicscope", "sdfshottyscope", "penetrationrailscope_sp", "epicar57", "epicm4", "epicake", "epicsdfar", "epicfmg", "epicmauler", "epicsdflmg", "epiclmg03", "epicerad", "epiccrb", "epicripper", "epicump45", "epicfhr", "epicm8", "epickbs", "epicsdfshotty", "epicdevastator", "epicsonic", "epicemc", "epicnrg", "epicg18"];
  return var_0;
}

func_DA0F() {
  var_0 = ["acog", "elo", "smart", "oscope", "reflex", "phase", "thermal", "scope", "hybrid", "vzscope"];
  return var_0;
}

func_DA0D() {
  var_0 = ["scope1", "scope2", "scope3", "scope4", "scope5", "scope6", "scope7", "scope8", "scope9", "scope10"];
  return var_0;
}

func_D9F3() {
  var_0 = ["snow", "camo02", "camo03", "camo04", "camo05", "camo07", "camo08", "camo09", "camo10", "camo11", "camo12", "camo13", "camo14", "camo15", "camo17", "camo18", "camo19", "camo20", "camo21", "camo22", "camo23", "camo24", "camo25", "camo27", "camo28", "camo29", "camo30"];
  return var_0;
}

func_7BB5(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  switch (var_0) {
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

  return var_0;
}

setlightintensity(var_0, var_1) {
  if(!isDefined(var_1)) {
    return 0;
  }

  if(var_1 == "upgrade1") {
    var_2 = "1";
  } else if(var_2 == "upgrade2") {
    var_2 = "2";
  } else {
    return 0;
  }

  var_3 = undefined;
  switch (var_0) {
    case "frag":
      var_3 = "upgrade_frag_" + var_2;
      break;

    case "emp":
      var_3 = "upgrade_shock_" + var_2;
      break;

    case "seeker":
      var_3 = "upgrade_seeker_" + var_2;
      break;

    case "antigrav":
      var_3 = "upgrade_antigrav_" + var_2;
      break;

    case "supportdrone":
      var_3 = "upgrade_drone_" + var_2;
      break;

    case "offhandshield":
      var_3 = "upgrade_shield_" + var_2;
      break;

    case "hackingdevice":
      var_3 = "upgrade_hack_" + var_2;
      break;

    case "coverwall":
      var_3 = "upgrade_cover_" + var_2;
      break;
  }

  if(isDefined(var_3)) {
    level.player lib_0E42::switchtoweaponimmediate(var_3);
  }

  return 1;
}

func_82FF() {
  var_0 = func_D9F8();
  foreach(var_2 in var_0) {
    var_3 = level.player func_84C6("equipmentState", var_2);
    setlightintensity(var_2, var_3);
  }
}

func_8315() {
  var_0 = func_DA12();
  var_1 = [];
  var_2 = undefined;
  foreach(var_4 in var_0) {
    var_2 = level.player func_84C6("suitUpgradeState", var_4);
    if(isDefined(var_2) && var_2 == "unlocked") {
      var_5 = "specialty_" + var_4;
      var_1 = scripts\engine\utility::array_add(var_1, var_5);
    }
  }

  if(scripts\sp\utility::func_93A6() && !scripts\engine\utility::array_contains(var_1, "specialty_extraequipment")) {
    var_1 = scripts\engine\utility::array_add(var_1, "specialty_extraequipment");
  }

  level.player lib_0E42::giveperks(var_1);
}

func_DA19() {
  if(level.player func_84C6("suitUpgradeState", "slasher") != "locked") {
    return 1;
  }

  return level.player func_84C6("suitUpgradeState", "shocker") != "locked";
}

func_D9FB() {
  var_0 = level.player func_84C6("selectedLoadout");
  var_1 = level.player func_84C6("loadouts", var_0, "jackalSetup", "jackalDecal");
  if(!isDefined(var_1) || var_1 == "none" || var_1 == "") {
    var_1 = "veh_mil_air_un_jackal_livery_shell_01";
  }

  return var_1;
}

func_DA02() {
  var_0 = level.player func_84C6("selectedLoadout");
  var_1 = level.player func_84C6("loadouts", var_0, "jackalSetup", "jackalUpgrade");
  if(!isDefined(var_1)) {
    var_1 = "none";
  }

  return var_1;
}

func_D9FE() {
  var_0 = level.player func_84C6("selectedLoadout");
  var_1 = level.player func_84C6("loadouts", var_0, "jackalSetup", "jackalPrimary");
  if(!isDefined(var_1)) {
    var_1 = "primary_default";
  }

  return var_1;
}

func_DA00() {
  var_0 = level.player func_84C6("selectedLoadout");
  var_1 = level.player func_84C6("loadouts", var_0, "jackalSetup", "jackalSecondary");
  if(!isDefined(var_1)) {
    var_1 = "secondary_default";
  }

  return var_1;
}

func_DA46() {
  var_0 = scripts\engine\utility::array_combine(getspawnerarray(), getaiarray("allies", "axis"));
  var_1 = 0;
  if(var_0.size > 0) {
    var_1 = 1;
  }

  if(var_1) {
    level.var_D9E5["default_weapon_transients"] = [];
    var_2 = undefined;
    var_3 = func_DA17("sdf", "un");
    foreach(var_5 in var_3) {
      var_2 = "weapon_" + var_5 + "_tr";
      level.var_D9E5["default_weapon_transients"] = scripts\engine\utility::array_add(level.var_D9E5["default_weapon_transients"], var_2);
      precacheitem(var_5);
      precachemodel(getweaponviewmodel(var_5));
    }
  }
}

func_9789() {
  var_0 = func_DA17();
  var_0 = scripts\engine\utility::array_add(var_0, "iw7_knife_perk");
  var_0 = scripts\engine\utility::array_add(var_0, "iw7_knife_upgrade1");
  var_0 = func_D9E7(var_0);
  foreach(var_2 in var_0) {
    scripts\sp\utility::func_1263F("weapon_" + var_2 + "_tr");
    precacheitem(var_2);
    precachemodel(getweaponviewmodel(var_2));
  }

  var_4 = func_D9FC();
  foreach(var_6 in var_4) {
    precachemodel(var_6);
    var_7 = strtok(var_6, "_");
    var_8 = var_7.size - 1;
    var_9 = "livery_" + var_7[var_8 - 1] + "_" + var_7[var_8];
    scripts\sp\utility::func_1263F(var_9 + "_" + "tr");
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
  var_0 = scripts\engine\utility::array_combine(func_7AF1(), func_7AEB());
  func_DA1D();
  func_DA52();
  level.var_D9E5["unlocked_attachments"] = func_DA1E();
  func_DA3D();
  if(!isDefined(level.template_script) || isDefined(level.template_script) && !scripts\engine\utility::array_contains(var_0, level.template_script)) {
    func_DA46();
    return;
  }

  func_492B();
  var_1 = scripts\engine\utility::get_template_script_MAYBE();
  var_1 = func_7BDE(var_1);
  func_DA33(var_1);
  func_DA3E(var_1);
  level.var_D9E5["equip_upgrades"] = func_DA22(var_1);
  level.var_D9E5["suit_upgrades"] = func_DA3B();
  level.var_D9E5["jackal_decals"] = func_DA25();
  level.var_D9E5["mandatory_suit_upgrades"] = func_DA2E(var_1);
  level.var_D9E5["mandatory_jackal_primaries"] = func_DA2A(var_1);
  level.var_D9E5["mandatory_jackal_secondaries"] = func_DA2B(var_1);
  level.var_D9E5["mandatory_jackal_upgrades"] = func_DA2C(var_1);
  level.var_D9E5["mandatory_jackal_decals"] = func_DA29(var_1);
  level.var_D9E5["ace_pilots"] = func_DA1A(var_1);
  level.var_D9E5["mission_specific_weapons"] = func_DA30(var_1);
  level.var_D9E5["mandatoryunlocks"] = func_DA2F(var_1);
  level.var_D9E5["optionalunlocks"] = func_DA32(var_1);
  level.var_D9E5["armoryweapons"] = [];
  level.var_D9E5["loaded_weapons"] = func_DA27(var_1);
  level.var_D9E5["loaded_weapon_types"] = func_DA3F();
  level.var_D9E5["loaded_equipment_types"] = func_DA21();
  level.var_D9E5["primaryweapons"] = func_DA34();
  level.var_D9E5["secondaryweapons"] = func_DA39();
  level.var_D9E5["offhand"] = func_DA31(var_1);
  level.var_D9E5["items"] = func_DA24(var_1);
  level.var_D9E5["scanned_items"] = func_DA0E();
  level.var_D9E5["wanted_cards"] = func_DA3C();
  level.var_D9E5["achievementDoorPeek"] = func_DA1B();
  if(func_9CBB(level.template_script)) {
    scripts\sp\endmission::func_12F24();
  }

  if(scripts\engine\utility::array_contains(var_0, var_1) || getdvarint("force_weapon_scan") == 1) {
    if(var_1 != "e3_phstreets") {
      thread func_EBB9();
      thread func_13C35();
    }
  }
}

func_13C43() {
  self endon("death");
  for(;;) {
    if(isDefined(self.disableautoreload) && self.disableautoreload > 0 && self func_843C()) {}

    wait(0.05);
  }
}

func_DA33(var_0) {}

func_DA3E(var_0) {
  var_1 = func_DA17();
  var_2 = func_7AF1("sub");
  var_3 = [];
  var_4 = 0;
  foreach(var_6 in var_2) {
    if(var_6 != var_0 && !var_4) {
      continue;
    } else if(!var_4) {
      var_4 = 1;
    }

    var_7 = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_6, 2), ", ");
    var_3 = scripts\engine\utility::array_combine(var_3, var_7);
    var_8 = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_6, 3), ", ");
    var_3 = scripts\engine\utility::array_combine(var_3, var_8);
  }

  foreach(var_0B in var_1) {
    var_0C = level.player func_84C6("weaponsScanned", var_0B);
    if(isDefined(var_0C) && var_0C != "") {
      level.var_D9E5["weaponstates"][var_0B] = var_0C;
      continue;
    }

    level.var_D9E5["weaponstates"][var_0B] = "locked";
  }
}

func_DA1D() {
  var_0 = ["phspace", "sa_moon", "titanjackal", "rogue", "marscrash", "sa_assassination", "sa_empambush", "sa_vips", "sa_wounded", "ja_asteroid", "ja_spacestation", "ja_titan", "ja_wreckage", "ja_mining"];
  var_1 = 0;
  foreach(var_3 in var_0) {
    var_4 = scripts\sp\endmission::func_7F6B(var_3);
    if(scripts\sp\endmission::func_7F69(var_4)) {
      var_1++;
    }
  }

  level.player func_84C7("scrapCount", var_1);
  func_DA4F();
}

func_DA22(var_0) {
  var_1 = int(tablelookup("sp\progression_unlocks.csv", 0, var_0, 7));
  return var_1;
}

func_DA28(var_0) {
  var_1 = [];
  var_1["terminals"] = [];
  var_1["discovered"] = [];
  if(var_0 != "all_weapons") {
    for(var_2 = 0; var_2 < 2; var_2++) {
      for(var_3 = 0; var_3 < 2; var_3++) {
        var_4 = var_2 * 2 + var_3;
        var_5 = level.player func_84C6("missionLootRooms", var_0, "terminal", var_4);
        var_1["terminals"] = scripts\engine\utility::array_add(var_1["terminals"], var_5);
      }

      var_6 = level.player func_84C6("missionLootRooms", var_0, "discovered", var_2);
      var_1["discovered"] = scripts\engine\utility::array_add(var_1["discovered"], var_6);
    }
  }

  return var_1;
}

func_D9ED(var_0) {
  var_1 = scripts\engine\utility::get_template_script_MAYBE();
  var_1 = func_7BDE(var_1);
  var_2 = level.player func_84C6("missionLootRooms", var_1, "discovered", var_0);
  return var_2;
}

func_DA49(var_0, var_1) {
  var_2 = scripts\engine\utility::get_template_script_MAYBE();
  var_2 = func_7BDE(var_2);
  level.player func_84C7("missionLootRooms", var_2, "discovered", var_0, var_1);
}

func_DA44(var_0, var_1) {
  var_2 = scripts\engine\utility::get_template_script_MAYBE();
  var_2 = func_7BDE(var_2);
  var_3 = var_0 * 2 + var_1;
  var_4 = level.player func_84C6("missionLootRooms", var_2, "terminal", var_3);
  return var_4;
}

func_DA4D(var_0, var_1) {
  var_2 = scripts\engine\utility::get_template_script_MAYBE();
  var_2 = func_7BDE(var_2);
  var_3 = var_0 * 2 + var_1;
  level.player func_84C7("missionLootRooms", var_2, "terminal", var_3, 1);
}

func_DA3B() {
  var_0 = func_DA12();
  return func_D9F0("suitUpgradeState", var_0);
}

func_DA25() {
  var_0 = func_D9FC();
  return func_D9F0("jackalDecals", var_0);
}

func_DA2E(var_0) {
  var_1 = scripts\engine\utility::get_template_script_MAYBE();
  if(var_0 == "pearlharbor" && var_1 != "phspace") {
    return [];
  }

  if(var_0 == "titan" && var_1 != "titanjackal") {
    return [];
  }

  if(var_0 == "heist") {
    return [];
  }

  if(var_1 == "marscrash") {
    var_0 = "heist";
  }

  var_2 = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_0, 8), ", ");
  var_2 = scripts\engine\utility::array_remove(var_2, "");
  return var_2;
}

func_DA2A(var_0) {
  var_1 = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_0, 9), ", ");
  var_1 = scripts\engine\utility::array_remove(var_1, "");
  return var_1;
}

func_DA2B(var_0) {
  var_1 = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_0, 10), ", ");
  var_1 = scripts\engine\utility::array_remove(var_1, "");
  return var_1;
}

func_DA2C(var_0) {
  var_1 = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_0, 11), ", ");
  var_1 = scripts\engine\utility::array_remove(var_1, "");
  return var_1;
}

func_DA29(var_0) {
  var_1 = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_0, 12), ", ");
  var_1 = scripts\engine\utility::array_remove(var_1, "");
  return var_1;
}

func_DA1A(var_0) {
  var_1 = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_0, 13), ", ");
  var_1 = scripts\engine\utility::array_remove(var_1, "");
  return var_1;
}

func_DA30(var_0) {
  return strtok(tablelookup("sp\progression_unlocks.csv", 0, var_0, 14), ", ");
}

func_DA2F(var_0) {
  var_1 = func_7AF1("sub", "sa");
  var_2 = [];
  var_3 = [];
  var_4 = 0;
  foreach(var_6 in var_1) {
    if(var_6 != var_0 && !var_4) {
      continue;
    } else if(!var_4) {
      var_4 = 1;
      if(var_6 != "all_weapons") {
        var_7 = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_6, 2), ", ");
        var_2 = scripts\engine\utility::array_combine(var_2, var_7);
        var_8 = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_6, 3), ", ");
        var_2 = scripts\engine\utility::array_combine(var_2, var_8);
        continue;
      }
    }

    var_9 = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_6, 2), ", ");
    var_3 = scripts\engine\utility::array_combine(var_3, var_9);
    var_0A = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_6, 3), ", ");
    var_3 = scripts\engine\utility::array_combine(var_3, var_0A);
  }

  foreach(var_0D in var_3) {
    var_0E = level.player func_84C6("weaponsScanned", var_0D);
    if(!isDefined(var_0E) || var_0E == "locked") {
      level.player func_84C7("weaponsScanned", var_0D, "unlocked");
      level.var_D9E5["weaponstates"][var_0D] = "unlocked";
    }
  }

  return var_2;
}

func_DA32(var_0) {
  var_1 = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_0, 4), ", ");
  var_1 = func_D9E7(var_1);
  if(var_0 != "europa" && var_0 != "pearlharbor") {
    var_2 = level.player func_84C6("weaponsScanned", "iw7_steeldragon");
    if(isDefined(var_2) && var_2 == "locked") {
      var_1 = scripts\engine\utility::array_add(var_1, "iw7_steeldragon");
    }
  }

  foreach(var_4 in var_1) {
    var_5 = level.player func_84C6("weaponsScanned", var_4);
    if(isDefined(var_5) && var_5 == "unlocked") {
      var_1 = scripts\engine\utility::array_remove(var_1, var_4);
      continue;
    }

    if(isDefined(var_5) && var_5 == "scanned") {
      var_1 = scripts\engine\utility::array_remove(var_1, var_4);
      continue;
    }

    if(isDefined(level.var_D9E5["weaponstates"][var_4]) && level.var_D9E5["weaponstates"][var_4] != "locked") {
      var_1 = scripts\engine\utility::array_remove(var_1, var_4);
    }
  }

  return var_1;
}

func_DA27(var_0) {
  if(isDefined(level.template_script)) {
    var_1 = level.template_script;
  } else {
    var_1 = var_1;
  }

  if(scripts\engine\utility::string_starts_with(var_1, "shipcrib")) {
    var_2 = 1;
  } else {
    var_2 = 0;
  }

  if(scripts\engine\utility::string_starts_with(var_1, "ja_")) {
    var_3 = 1;
  } else {
    var_3 = 0;
  }

  return func_DA18(var_0, var_2, 0, undefined, var_3);
}

func_DA34() {
  var_0 = [];
  foreach(var_2 in level.var_D9E5["loaded_weapons"]) {
    if(func_9B44(var_2)) {
      continue;
    }

    if(func_DA42(var_2)) {
      var_0 = scripts\engine\utility::array_add(var_0, var_2);
    }
  }

  return var_0;
}

func_DA39() {
  var_0 = [];
  foreach(var_2 in level.var_D9E5["loaded_weapons"]) {
    if(func_9B44(var_2)) {
      continue;
    }

    if(!func_DA42(var_2)) {
      var_0 = scripts\engine\utility::array_add(var_0, var_2);
    }
  }

  return var_0;
}

func_DA31(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = [];
  if(!level.var_D9E5["fakedata"]) {
    foreach(var_5 in level.var_D9E5["loaded_equipment_types"]) {
      if(isDefined(level.var_D9E5["weaponstates"][var_5]) && level.var_D9E5["weaponstates"][var_5] == "unlocked") {
        var_1 = scripts\engine\utility::array_add(var_1, var_5);
      }
    }
  } else if(var_0 == "all_weapons") {
    var_3 = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_0, 5), ", ");
    for(var_7 = 0; var_7 < var_3.size; var_7++) {
      if(var_3[var_7] != "") {
        var_1 = scripts\engine\utility::array_add(var_1, var_3[var_7]);
      }
    }
  } else {
    var_8 = func_7AF1("sub");
    var_9 = 0;
    foreach(var_0B in var_8) {
      if(var_0B != var_0 && !var_9) {
        continue;
      } else if(!var_9) {
        var_9 = 1;
      }

      var_3 = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_0B, 5), ", ");
      for(var_7 = 0; var_7 < var_3.size; var_7++) {
        if(var_3[var_7] != "") {
          var_1 = scripts\engine\utility::array_add(var_1, var_3[var_7]);
        }
      }
    }
  }

  return var_1;
}

func_DA24(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = [];
  if(!level.var_D9E5["fakedata"]) {
    foreach(var_5 in level.var_D9E5["loaded_equipment_types"]) {
      if(isDefined(level.var_D9E5["weaponstates"][var_5]) && level.var_D9E5["weaponstates"][var_5] == "unlocked") {
        var_1 = scripts\engine\utility::array_add(var_1, var_5);
      }
    }
  } else if(var_0 == "all_weapons") {
    var_3 = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_0, 6), ", ");
    for(var_7 = 0; var_7 < var_3.size; var_7++) {
      if(var_3[var_7] != "") {
        var_1 = scripts\engine\utility::array_add(var_1, var_3[var_7]);
      }
    }
  } else {
    var_8 = func_7AF1("sub");
    var_9 = 0;
    foreach(var_0B in var_8) {
      if(var_0B != var_0 && !var_9) {
        continue;
      } else if(!var_9) {
        var_9 = 1;
      }

      var_3 = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_0B, 6), ", ");
      for(var_7 = 0; var_7 < var_3.size; var_7++) {
        if(var_3[var_7] != "") {
          var_1 = scripts\engine\utility::array_add(var_1, var_3[var_7]);
        }
      }
    }
  }

  return var_1;
}

func_DA3F() {
  if(!func_3DDC("weapon")) {
    return;
  }

  var_0 = level.var_D9E5["loaded_weapons"];
  var_1 = [];
  var_1["rifle"] = [];
  var_1["smg"] = [];
  var_1["spread"] = [];
  var_1["sniper"] = [];
  var_1["mg"] = [];
  var_1["pistol"] = [];
  var_1["beam"] = [];
  var_1["rocketlauncher"] = [];
  foreach(var_3 in var_0) {
    if(!func_9B49(var_3)) {
      continue;
    }

    if(func_DA41(var_3)) {
      continue;
    }

    if(scripts\engine\utility::array_contains(level.var_D9E5["mandatoryunlocks"], var_3) || scripts\engine\utility::array_contains(level.var_D9E5["optionalunlocks"], var_3) || scripts\engine\utility::array_contains(level.var_D9E5["mission_specific_weapons"], var_3) || scripts\engine\utility::array_contains(func_D9F7(), var_3) && func_9CBB(level.template_script) || isDefined(level.var_D9E5["weaponstates"][var_3]) && level.var_D9E5["weaponstates"][var_3] != "locked") {
      var_4 = spawnStruct();
      var_4.weapon_name = var_3;
      var_4.var_13C13 = func_7D5F(var_3);
      var_5 = scripts\engine\utility::weaponclass(var_3);
      var_1[var_5] = scripts\engine\utility::array_add(var_1[var_5], var_4);
    }
  }

  return var_1;
}

func_DA21() {
  if(!func_3DDC("offhand")) {
    return;
  }

  var_0 = func_D9F8();
  var_1 = [];
  foreach(var_3 in var_0) {
    if(!scripts\engine\utility::array_contains(level.var_D9E5["mandatoryunlocks"], var_3) || isDefined(level.var_D9E5["weaponstates"][var_3]) && level.var_D9E5["weaponstates"][var_3] == "unlocked") {
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  return var_1;
}

func_DA38() {
  var_0 = [];
  var_1 = 0;
  for(;;) {
    var_2 = tablelookupbyrow("sp\scrap_unlocks.csv", var_1, 0);
    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    var_3 = tablelookupbyrow("sp\scrap_unlocks.csv", var_1, 2);
    if(!isDefined(var_0[var_3])) {
      var_0[var_3] = [];
    }

    var_4 = tablelookupbyrow("sp\scrap_unlocks.csv", var_1, 1);
    var_5 = tablelookupbyrow("sp\scrap_unlocks.csv", var_1, 3);
    var_0[var_3][var_4] = var_5;
    var_1++;
  }

  return var_0;
}

func_DA1E() {
  var_0 = func_D9F2(0);
  var_1 = func_D9F1();
  foreach(var_3 in var_1) {
    var_4 = tablelookuprownum("sp\attachmenttable.csv", 4, var_3);
    var_5 = tablelookupbyrow("sp\attachmenttable.csv", var_4, 8);
    if(isDefined(var_5) && var_5 != "") {
      precachemodel(var_5);
    }
  }

  return func_D9F0("attachmentsState", var_0);
}

func_D9E6(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0[var_2])) {
    var_0[var_2] = [];
  }

  var_0[var_2][var_1] = var_3;
  return var_0;
}

func_7AEC(var_0) {
  switch (var_0) {
    case "pearlharbor":
      return "phspace";

    case "mars":
      return "marsbase";

    default:
      return var_0;
  }
}

func_7BDE(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(var_1) {
    level.var_D9E5["submission"] = "submission";
  }

  switch (var_0) {
    case "shipcrib_epilogue":
      var_0 = "yard";
      break;

    case "shipcrib_titan":
      var_0 = "titan";
      break;

    case "shipcrib_europa":
      var_0 = "moon_port";
      break;

    case "shipcrib_moon":
      var_0 = "moon_port";
      break;

    case "shipcrib_rogue":
      var_0 = "rogue";
      break;

    case "shipcrib_prisoner":
      var_0 = "prisoner";
      break;

    case "phparade":
      var_0 = "pearlharbor";
      break;

    case "phspace":
      var_0 = "pearlharbor";
      if(var_1) {
        level.var_D9E5["submission"] = var_0;
      }
      break;

    case "phstreets":
      var_0 = "pearlharbor";
      break;

    case "marscrash":
      var_0 = "mars";
      break;

    case "marscrib":
      var_0 = "mars";
      break;

    case "marsbase":
      var_0 = "mars";
      if(var_1) {
        level.var_D9E5["submission"] = var_0;
      }
      break;

    case "moon_port":
      var_0 = "moon_port";
      break;

    case "moonjackal":
      var_0 = "moon_port";
      if(var_1) {
        level.var_D9E5["submission"] = var_0;
      }
      break;

    case "titanjackal":
      var_0 = "titan";
      if(var_1) {
        level.var_D9E5["submission"] = var_0;
      }
      break;

    case "heistspace":
      var_0 = "heist";
      if(var_1) {
        level.var_D9E5["submission"] = var_0;
      }
      break;

    case "rogue_dropship":
      var_0 = "rogue";
      break;

    case "dk_test":
      var_0 = "sa_assassination";
      break;

    default:
      if(var_1) {
        level.var_D9E5["submission"] = var_0;
      }

      break;
  }

  if(getdvarint("progression_on") == 0 || scripts\engine\utility::array_contains(func_7AEB(), var_0)) {
    var_0 = "all_weapons";
  }

  return var_0;
}

func_492B(var_0) {
  var_1 = level.player func_84C6("weaponsScanned", "iw7_g18");
  if(!isDefined(var_1) || var_1 != "unlocked" || isDefined(var_0)) {
    var_2 = ["iw7_g18", "iw7_m8", "iw7_m4", "iw7_fhr"];
    foreach(var_4 in var_2) {
      level.player func_84C7("weaponsScanned", var_4, "unlocked");
    }

    var_6 = ["seeker", "antigrav"];
    foreach(var_8 in var_6) {
      level.player func_84C7("equipmentState", var_8, "unlocked");
    }

    var_0A = ["reflex", "acog", "silencer"];
    foreach(var_0C in var_0A) {
      level.player func_84C7("attachmentsState", var_0C, "unlocked");
    }

    var_0E = "primary_default";
    level.player func_84C7("jackalPrimaryState", var_0E, "unlocked");
    var_0F = "secondary_default";
    level.player func_84C7("jackalSecondaryState", var_0F, "unlocked");
    var_10 = ["weapons", "hull"];
    foreach(var_12 in var_10) {
      level.player func_84C7("jackalUpgradeState", var_12, "unlocked");
    }

    var_14 = ["veh_mil_air_un_jackal_livery_shell_01"];
    foreach(var_16 in var_14) {
      level.player func_84C7("jackalDecals", var_16, "unlocked");
    }

    level.player func_84C8("loadouts", 0, "name", "MENU_SP_GRIFFS_RECOMMENDED");
    level.player func_84C8("loadouts", 1, "name", "MENU_SP_LOADOUT_1");
    level.player func_84C8("loadouts", 2, "name", "MENU_SP_LOADOUT_2");
    level.player func_84C8("loadouts", 3, "name", "MENU_SP_LOADOUT_3");
    scripts\sp\loadout::func_F56D("loadout1", 0, 1);
    scripts\sp\loadout::func_F56D("loadout2", 0, 2);
    scripts\sp\loadout::func_F56D("loadout3", 0, 3);
    level.player func_84C7("missionStateData", "europa", "incomplete");
  }

  if(scripts\sp\utility::func_93A6()) {
    var_18 = ["nanoshot", "helmet"];
    foreach(var_8 in var_18) {
      var_1A = level.player func_84C6("equipmentState", var_8);
      if(var_1A == "locked") {
        level.player func_84C7("equipmentState", var_8, "scanned");
      }
    }
  }
}

func_DA57(var_0) {
  var_1 = level.player func_84C6("weaponsScanned", var_0);
  if(!isDefined(var_1)) {
    return 0;
  }

  return level.player func_84C6("weaponsScanned", var_0) != "locked";
}

func_DA55(var_0, var_1) {
  if(isDefined(level.var_D9E5["weaponstates"][var_0])) {
    if(!scripts\engine\utility::array_contains(var_1, var_0)) {
      if(func_9B49(var_0)) {
        if(!scripts\engine\utility::array_contains(level.var_D9E5["optionalunlocks"], var_0)) {
          if(level.var_D9E5["weaponstates"][var_0] != "scanned") {
            if(level.var_D9E5["weaponstates"][var_0] != "unlocked") {
              return 0;
            }
          }
        }
      }
    }

    return 1;
  } else if(func_9B49(var_0)) {
    if(!scripts\engine\utility::array_contains(func_DA17(), var_0)) {} else {
      return 1;
    }
  }

  return 0;
}

func_DA18(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 14;
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!var_2) {
    var_6 = func_7F7B(level.template_script);
  } else if(isDefined(var_4)) {
    var_6 = var_4;
  } else {
    var_6 = [];
  }

  if(!var_2) {
    if(var_6.size > 0) {
      var_7 = scripts\engine\utility::array_combine(level.var_D9E5["mission_specific_weapons"], var_6);
      foreach(var_9 in level.var_D9E5["weapon_pickups"]) {
        if(!isstring(var_9)) {
          var_9 = getsubstr(var_9.classname, 7);
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
  if(!var_1) {
    if(!var_2) {
      var_10 = level.player func_84C6("lastWeaponPreload");
      if(isDefined(var_10) && var_10 == level.template_script) {
        var_11 = func_DA17();
        foreach(var_9 in var_11) {
          var_13 = level.player func_84C6("weaponsLoaded", var_9);
          if(isDefined(var_13) && var_13) {
            var_0F = scripts\engine\utility::array_add(var_0F, var_9);
          }
        }
      }

      level.player func_84C7("lastWeaponPreload", "nodata");
    }

    if(var_0F.size == 0) {
      if(!var_2) {
        var_0E = level.var_D9E5["mission_specific_weapons"];
      } else {
        var_0E = func_DA30(var_0);
      }

      if(!var_2) {
        var_0D = level.var_D9E5["mandatoryunlocks"];
      } else {
        var_0D = func_DA2F(var_0);
      }
    }
  }

  if(var_0F.size == 0) {
    if(!isDefined(var_0E)) {
      var_0E = [];
    }

    foreach(var_9 in var_6) {
      if(!isstring(var_9)) {
        var_16 = getsubstr(var_9.classname, 7);
        var_16 = getweaponbasename(var_16);
      } else {
        var_16 = var_9;
      }

      if(!func_DA55(var_16, var_0D)) {
        if(!func_9B49(var_16)) {
          continue;
        }
      }

      var_0E = scripts\engine\utility::array_add(var_0E, var_16);
    }

    if(!var_1) {
      var_18 = level.player getweaponslist("primary");
      var_19 = [];
      foreach(var_9 in var_18) {
        var_1B = getweaponbasename(var_9);
        if(scripts\engine\utility::array_contains(func_DA17(), var_1B)) {
          var_19 = scripts\engine\utility::array_add(var_19, var_1B);
        }
      }

      var_19 = scripts\engine\utility::array_remove_duplicates(var_19);
      var_19 = scripts\engine\utility::array_removeundefined(var_19);
      foreach(var_9 in var_19) {
        if(!scripts\engine\utility::array_contains(var_0E, var_9)) {
          if(scripts\engine\utility::array_contains(func_DA17(), var_9)) {
            var_0E = scripts\engine\utility::array_add(var_0E, var_9);
          }
        }
      }

      if(!isDefined(var_4) || isDefined(var_4) && !var_4) {
        var_0E = scripts\sp\utility::func_22A2(var_0E, var_0D);
        var_1F = strtok(tablelookup("sp\progression_unlocks.csv", 0, var_0, 5), ", ");
        level.var_D9E5["mandatoryunlocks"] = scripts\engine\utility::array_combine(level.var_D9E5["mandatoryunlocks"], var_1F);
        foreach(var_9, var_21 in level.var_D9E5["weaponstates"]) {
          if(func_9B49(var_9)) {
            if(!scripts\engine\utility::array_contains(var_0E, var_9)) {
              if(var_21 == "unlocked" && var_9 != "none") {
                var_0C = scripts\engine\utility::array_add(var_0C, var_9);
              }
            }
          }
        }

        var_0E = scripts\engine\utility::array_remove_duplicates(var_0E);
        var_0E = func_D9E7(var_0E);
        var_0C = scripts\engine\utility::array_remove_array(var_0C, var_0E);
        if(!var_2) {
          var_22 = level.var_D9E5["optionalunlocks"];
        } else {
          var_22 = func_DA32(var_1);
        }

        var_22 = scripts\engine\utility::array_remove_array(var_22, var_0E);
        var_0C = scripts\engine\utility::array_combine_unique(var_0C, var_22);
        foreach(var_9 in var_0E) {
          var_24 = scripts\engine\utility::weaponclass(var_9);
          if(!isDefined(var_0B[var_24])) {
            if(var_24 == "beam") {
              continue;
            }

            var_0E = scripts\engine\utility::array_remove(var_0E, var_9);
            continue;
          }

          if(var_0B[var_24] > 0) {
            var_0B[var_24]++;
            continue;
          }

          var_0B[var_24] = 0;
        }

        var_0C = scripts\engine\utility::array_randomize(var_0C);
        for(var_26 = 1; var_0E.size < var_5 && var_0C.size > 0 && var_26 < 3; var_26++) {
          foreach(var_9 in var_0C) {
            var_24 = scripts\engine\utility::weaponclass(var_9);
            if(func_DA40(var_9)) {
              continue;
            }

            if(func_DA41(var_9)) {
              continue;
            }

            if(func_DA43(var_9)) {
              continue;
            }

            if(level.template_script == "europa" && var_9 == "iw7_fmg") {
              continue;
            }

            if(var_0B[var_24] >= 0 && func_13C4A(var_0B)) {
              continue;
            }

            if(var_0B[var_24] <= var_26) {
              var_0E = scripts\engine\utility::array_add(var_0E, var_9);
              var_0C = scripts\engine\utility::array_remove(var_0C, var_9);
              var_0B[var_24]++;
            }

            if(var_0E.size == var_5) {
              break;
            }
          }
        }

        if(var_0E.size < var_5) {
          foreach(var_9 in var_0C) {
            if(func_DA40(var_9)) {
              continue;
            }

            if(func_DA41(var_9)) {
              continue;
            }

            if(func_DA43(var_9)) {
              continue;
            }

            if(level.template_script == "europa" && var_9 == "iw7_fmg") {
              continue;
            }

            if(var_0E.size < var_5) {
              var_0E = scripts\engine\utility::array_add(var_0E, var_9);
              continue;
            }

            if(var_0E.size == var_5) {
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

  if(!var_2) {
    var_2F = "weaponsScanned";
    foreach(var_9 in var_0E) {
      if(!func_9B49(var_9)) {
        continue;
      }

      precacheitem(var_9);
      precachemodel(getweaponviewmodel(var_9));
      var_31 = level.player func_84C6(var_2F, var_9);
      if(isDefined(var_31)) {
        level.var_D9E5["weaponstates"][var_9] = var_31;
        continue;
      }

      level.var_D9E5["weaponstates"][var_9] = "unlocked";
    }

    var_2F = "equipmentState";
    var_33 = func_D9F8();
    foreach(var_35 in var_33) {
      precacheitem(var_35);
      var_36 = level.player func_84C6(var_2F, var_35);
      if(isDefined(var_36)) {
        level.var_D9E5["weaponstates"][var_35] = var_36;
        continue;
      }

      level.var_D9E5["weaponstates"][var_35] = "unlocked";
    }
  }

  var_38 = func_D9FB();
  if(!var_2) {
    precachemodel(var_38);
  }

  var_39 = strtok(var_38, "_");
  var_3A = var_39.size - 1;
  var_3B = "livery_" + var_39[var_3A - 1] + "_" + var_39[var_3A];
  var_0E = scripts\engine\utility::array_add(var_0E, var_3B);
  return var_0E;
}

func_13C4A(var_0) {
  foreach(var_3, var_2 in var_0) {
    if(var_3 == "beam") {
      continue;
    }

    if(var_3 == "rocketlauncher") {
      continue;
    }

    if(var_2 == -1) {
      return 1;
    }
  }

  return 0;
}

func_DA14(var_0, var_1) {}

func_7F7B(var_0) {
  var_1 = [];
  switch (var_0) {
    case "phparade":
      var_1 = [];
      break;

    case "phspace":
      var_1 = [];
      break;

    case "phstreets":
      var_1 = ["iw7_ar57", "iw7_m8", "iw7_m4", "iw7_crb", "iw7_sdflmg"];
      break;

    case "marscrash":
      var_1 = [];
      break;

    case "marscrib":
      var_1 = ["iw7_ake"];
      break;

    case "marsbase":
      var_1 = ["iw7_lockon", "iw7_m8"];
      break;

    case "moonjackal":
      var_1 = [];
      break;

    case "titanjackal":
      var_1 = [];
      break;

    case "heistspace":
      var_1 = [];
      break;

    case "sa_assassination":
      var_1 = ["iw7_atomizer", "iw7_sdfar", "iw7_sdflmg", "iw7_sdfshotty"];
      break;

    case "sa_empambush":
      var_1 = ["iw7_m8"];
      break;

    case "sa_vips":
      var_1 = ["iw7_sdfar", "iw7_sdflmg", "iw7_sdfshotty"];
      break;

    case "sa_wounded":
      var_1 = [];
      break;

    case "heist":
      var_1 = ["iw7_sdfshotty", "iw7_lockon", "iw7_lmg03"];
      break;

    case "prisoner":
      var_1 = ["iw7_sdfshotty", "iw7_kbs", "iw7_erad"];
      break;

    case "rogue":
      var_1 = ["iw7_m4", "iw7_devastator", "iw7_erad", "iw7_ar57", "iw7_steeldragon"];
      break;

    case "titan":
      var_1 = ["iw7_lockon"];
      break;

    case "sa_moon":
      var_1 = ["iw7_m4"];
      break;

    case "moon_port":
      var_1 = ["iw7_ar57"];
      break;

    case "yard":
      var_1 = ["iw7_lockon", "iw7_sdflmg", "iw7_sdfshotty", "iw7_m8"];
      break;

    case "europa":
      var_1 = [];
      break;
  }

  return var_1;
}

func_DA4C(var_0) {
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  return var_0;
}

func_12642() {
  scripts\sp\utility::func_13705();
  var_0 = ["vr_firing_range"];
  var_1 = 0;
  if(isDefined(level.template_script)) {
    var_2 = level.template_script;
    if(scripts\engine\utility::array_contains(var_0, var_2)) {
      var_1 = 1;
    }
  }

  var_3 = [];
  var_4 = func_DA17();
  foreach(var_6 in var_4) {
    if(!func_9B49(var_6)) {
      continue;
    }

    level.player func_84C7("weaponsLoaded", var_6, 0);
  }

  if(level.var_D9E5["loaded_weapons"].size > 0) {
    var_4 = scripts\engine\utility::array_remove_array(var_4, level.var_D9E5["loaded_weapons"]);
  }

  foreach(var_6 in var_4) {
    if(scripts\engine\utility::array_contains(func_DA17(), var_6)) {
      var_9 = "weapon_" + var_6 + "_tr";
      if(!istransientloaded(var_9)) {
        var_3 = scripts\engine\utility::array_add(var_3, var_6);
        loadtransient(var_9);
      }

      if(var_1) {
        level.player func_84C7("weaponsScanned", var_6, "unlocked");
      }
    }
  }

  var_3 = scripts\engine\utility::array_remove_duplicates(var_3);
  for(;;) {
    var_0B = 1;
    foreach(var_6 in var_3) {
      var_0D = "weapon_" + var_6 + "_tr";
      if(!istransientloaded(var_0D)) {
        var_0B = 0;
        break;
      } else {
        var_0E = spawnStruct();
        var_0F = func_7D5F(var_6);
        var_0E.var_13C13 = var_0F;
        var_0E.weapon_name = var_6;
        var_10 = scripts\engine\utility::weaponclass(var_6);
        if(!scripts\engine\utility::array_contains(level.var_D9E5["loaded_weapons"], var_6)) {
          level.var_D9E5["loaded_weapons"] = scripts\engine\utility::array_add(level.var_D9E5["loaded_weapons"], var_6);
          level.var_D9E5["loaded_weapon_types"][var_10] = scripts\engine\utility::array_add(level.var_D9E5["loaded_weapon_types"][var_10], var_0E);
          level.player func_84C7("weaponsLoaded", var_6, 1);
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
  var_0 = func_D9FB();
  var_1 = strtok(var_0, "_");
  var_2 = var_1[5] + "_" + var_1[6] + "_" + var_1[7] + "_tr";
  if(!istransientloaded(var_2)) {
    loadtransient(var_2);
  }
}

func_1264F() {
  level notify("armory_weapons_unload");
}

func_12650() {
  level waittill("armory_weapons_unload");
  var_0 = level.var_D9E5["loaded_weapons"];
  var_1 = undefined;
  var_2 = undefined;
  var_3 = [];
  var_4 = [];
  var_5 = ["iw7_g18", "iw7_m4", "iw7_ripper"];
  var_6 = level.player getweaponslist("primary");
  var_7 = [];
  foreach(var_9 in var_6) {
    var_0A = getweaponbasename(var_9);
    if(scripts\engine\utility::array_contains(func_DA17(), var_0A)) {
      var_7 = scripts\engine\utility::array_add(var_7, var_0A);
    }
  }

  var_7 = scripts\engine\utility::array_remove_duplicates(var_7);
  var_0C = scripts\engine\utility::array_removeundefined(var_7);
  foreach(var_0F, var_0E in level.var_B8D2.var_ABFA) {
    if(var_0E.name == level.template_script) {
      var_2 = var_0F;
      break;
    }
  }

  var_10 = var_2 + 1;
  var_11 = level.var_B8D2.var_ABFA[var_10].name;
  var_12 = func_DA30(var_11);
  var_13 = func_7F7B(var_11);
  var_14 = func_DA2F(var_11);
  var_0C = scripts\engine\utility::array_combine_unique(var_0C, var_12);
  var_0C = scripts\engine\utility::array_combine_unique(var_0C, var_13);
  var_0C = scripts\engine\utility::array_combine_unique(var_0C, var_14);
  var_0C = scripts\engine\utility::array_combine_unique(var_0C, var_5);
  var_0 = scripts\engine\utility::array_remove_array(var_0, var_0C);
  foreach(var_9 in var_0) {
    if(!func_9B49(var_9)) {
      continue;
    }

    if(level.var_D9E5["loaded_weapons"].size > 18) {
      var_16 = getweaponbasename(var_9);
      var_17 = "weapon_" + var_9 + "_tr";
      scripts\sp\utility::func_1264E(var_17);
      level.var_D9E5["loaded_weapons"] = scripts\engine\utility::array_remove(level.var_D9E5["loaded_weapons"], var_16);
      level.player func_84C7("weaponsLoaded", var_16, 0);
      continue;
    }

    break;
  }

  func_DA54();
  func_DA53();
  level notify("armory_weapons_unloaded");
}

func_12646(var_0) {
  var_0 = getweaponbasename(var_0);
  var_1 = "weapon_" + var_0 + "_tr";
  if(istransientloaded(var_1)) {
    return;
  }

  scripts\sp\utility::func_12641(var_1);
  if(isDefined(level.var_D9E5)) {
    level.var_D9E5["loaded_weapons"] = scripts\engine\utility::array_add(level.var_D9E5["loaded_weapons"], var_0);
  } else {
    return;
  }

  var_2 = spawnStruct();
  var_3 = func_7D5F(var_0);
  var_2.var_13C13 = var_3;
  var_2.weapon_name = var_0;
  var_4 = scripts\engine\utility::weaponclass(var_0);
  level.var_D9E5["loaded_weapon_types"][var_4] = scripts\engine\utility::array_add(level.var_D9E5["loaded_weapon_types"][var_4], var_2);
}

func_12652(var_0) {
  var_1 = strtok(var_0, "+");
  if(var_1.size > 1) {
    var_2 = "weapon_" + var_1[0] + "_tr";
  } else {
    var_2 = "weapon_" + var_1 + "_tr";
  }

  scripts\sp\utility::func_1264E(var_2);
}

func_DA0C() {
  var_0 = level.player func_84C6("selectedLoadout");
  var_1 = level.player func_84C6("loadouts", var_0, "weaponSetups", 0, "weapon");
  var_2 = level.player func_84C6("loadouts", var_0, "weaponSetups", 1, "weapon");
  var_3 = [var_1, var_2];
  var_3 = scripts\engine\utility::array_remove_duplicates(var_3);
  foreach(var_5 in var_3) {
    if(!isDefined(var_5) || var_5 == "") {
      var_3 = scripts\engine\utility::array_remove(var_3, var_5);
    }
  }

  return var_3;
}

func_DA54() {
  foreach(var_2, var_1 in level.var_D9E5["weaponstates"]) {
    if(func_9B49(var_2)) {
      level.var_D9E5["weaponstates"][var_2] = level.player func_84C6("weaponsScanned", var_2);
    }
  }
}

func_DA53() {
  foreach(var_2, var_1 in level.var_D9E5["weaponstates"]) {
    if(!func_9B49(var_2)) {
      level.var_D9E5["weaponstates"][var_2] = level.player func_84C6("equipmentState", var_2);
    }
  }
}

func_DA52(var_0) {
  var_1 = [];
  var_2 = 0;
  if(isDefined(level.var_D9E5) && isDefined(level.var_D9E5["attachments"])) {
    var_3 = level.var_D9E5["attachments"].size;
  } else {
    var_3 = 0;
  }

  var_4 = 1;
  for(;;) {
    var_5 = tablelookupbyrow("sp\attachmenttable.csv", var_4, 4);
    var_6 = tablelookupbyrow("sp\attachmenttable.csv", var_4, 5);
    if(var_5 != "" && var_6 != "") {
      var_7 = strtok(tablelookupbyrow("sp\attachmenttable.csv", var_4, 12), ",");
      foreach(var_9 in var_7) {
        var_0A = strtok(tablelookupbyrow("sp\attachmenttable.csv", var_4, 13), ",");
        if(var_0A.size == 0) {
          var_0A[0] = "";
        }

        foreach(var_0C in var_0A) {
          var_0D = spawnStruct();
          var_0D.location = tablelookupbyrow("sp\attachmenttable.csv", var_4, 2);
          var_0D.name = tablelookupbyrow("sp\attachmenttable.csv", var_4, 3);
          var_0D.var_24A2 = var_5;
          var_0D.var_9338 = tablelookupbyrow("sp\attachmenttable.csv", var_4, 6);
          var_0D.var_9337 = tablelookupbyrow("sp\attachmenttable.csv", var_4, 20);
          var_0D.type = var_6;
          var_0D.var_9ECE = int(tablelookupbyrow("sp\attachmenttable.csv", var_4, 9));
          var_0D.var_657B = int(tablelookupbyrow("sp\attachmenttable.csv", var_4, 10));
          var_0D.baseangles = tablelookupbyrow("sp\attachmenttable.csv", var_4, 5);
          var_0D.var_13CDE = var_9;
          var_0D.var_13CCE = var_0C;
          var_1[var_9][var_0D.type][var_0C][var_0D.var_657B] = var_0D;
          if(isDefined(var_0) && !var_0) {
            level.player func_84C7("attachmentsState", var_0D.type, "locked");
            continue;
          }

          if(isDefined(var_0) && var_0) {
            level.player func_84C7("attachmentsState", var_0D.type, "unlocked");
          }
        }
      }
    } else {
      break;
    }

    var_4++;
  }

  if(!isDefined(level.var_D9E5)) {
    return var_1;
  }

  level.var_D9E5["attachments"] = var_1;
}

func_DA3D() {
  var_0 = scripts\sp\utility::func_7DB7();
  level.var_D9E5["weapon_pickups"] = [];
  foreach(var_2 in var_0) {
    var_3 = getsubstr(var_2.classname, 7);
    var_4 = weaponinventorytype(var_3);
    if(var_4 != "primary") {
      level.var_D9E5["weapon_pickups"] = scripts\engine\utility::array_add(level.var_D9E5["weapon_pickups"], var_2);
      continue;
    }

    var_5 = getweaponbasename(var_3);
    var_6 = getweaponattachments(var_3);
    if(var_6.size > 0) {
      level.var_D9E5["weapon_pickups"] = scripts\engine\utility::array_add(level.var_D9E5["weapon_pickups"], var_2);
      continue;
    }

    var_6 = build_attach_models(var_5, "random");
    if(var_5 == "iw7_gambit") {
      var_6 = build_attach_models(var_5, "random", undefined, 0, 0, 20);
    }

    if(isDefined(var_6) && var_6.size > 0) {
      var_0C = spawn("weapon_" + var_5 + "+" + var_6, var_2.origin, var_2.spawnimpulsefield);
      var_0C.angles = var_2.angles;
      var_0C.var_336 = var_2.var_336;
      var_0C.target = var_2.target;
      level.var_D9E5["weapon_pickups"] = scripts\engine\utility::array_add(level.var_D9E5["weapon_pickups"], var_0C);
      var_2 delete();
    }
  }
}

func_13BFC(var_0) {
  return func_13C05(var_0, 1);
}

func_13C44(var_0) {
  return func_13C05(var_0, 0);
}

func_13C05(var_0, var_1) {
  var_2 = [];
  var_2["weapon"] = var_0;
  var_2["weapon_changed"] = 0;
  if(isDefined(level.var_D9E5)) {
    var_3 = level.var_D9E5["attachments"];
    var_4 = getweaponbasename(var_0);
    var_5 = getsubstr(var_4, 4);
    var_6 = undefined;
    if(isDefined(var_3["zerog"]["zerog"][var_5])) {
      var_6 = var_3["zerog"]["zerog"][var_5][0].var_24A2;
    }

    if(isDefined(var_6)) {
      var_7 = getweaponattachments(var_0);
      if(var_1 && !scripts\engine\utility::array_contains(var_7, var_6)) {
        var_7 = scripts\engine\utility::array_add(var_7, var_6);
        var_7 = scripts\engine\utility::alphabetize(var_7);
        var_2["weapon_changed"] = 1;
      } else if(!var_1 && scripts\engine\utility::array_contains(var_7, var_6)) {
        var_7 = scripts\engine\utility::array_remove(var_7, var_6);
        var_7 = scripts\engine\utility::alphabetize(var_7);
        var_2["weapon_changed"] = 1;
      }

      if(var_2["weapon_changed"]) {
        var_8 = "";
        foreach(var_0A in var_7) {
          var_8 = var_8 + "+" + var_0A;
        }

        var_2["weapon"] = var_4 + var_8;
      }
    }
  }

  return var_2;
}

func_13E80(var_0, var_1) {
  var_2 = level.player getcurrentprimaryweapon();
  var_3 = level.player func_8519(var_2, 1);
  var_4 = getweaponbasename(var_2);
  var_5 = undefined;
  var_6 = undefined;
  var_7 = 0;
  var_8 = 0;
  var_9 = level.player getweaponslistall();
  foreach(var_0B in var_9) {
    var_0C = weaponinventorytype(var_0B);
    if(var_0C != "primary") {
      continue;
    }

    var_0D = func_13C05(var_0B, var_0);
    if(var_0D["weapon_changed"]) {
      var_0D = var_0D["weapon"];
      var_7 = level.player getweaponammostock(var_0B);
      var_8 = level.player getweaponammoclip(var_0B);
      level.player giveweapon(var_0D);
      level.player setweaponammostock(var_0D, var_7);
      level.player setweaponammoclip(var_0D, var_8);
      var_0E = getweaponbasename(var_0B);
      if(isDefined(var_4) && isDefined(var_0E) && var_4 == var_0E) {
        var_6 = var_0B;
        var_5 = var_0D;
      } else {
        level.player takeweapon(var_0B);
      }
    }
  }

  if(isDefined(var_5)) {
    level.player scripts\sp\utility::func_1C72(0);
    if(var_3) {
      var_5 = "alt_" + var_5;
    }

    if(isDefined(var_1) && var_1) {
      level.player takeweapon(var_6);
      level.player switchtoweaponimmediate(var_5);
    } else {
      level.player scripts\engine\utility::allow_weapon_switch(0);
      level.player switchtoweapon(var_5);
      level.player waittill("weapon_change");
      level.player takeweapon(var_6);
      level.player scripts\engine\utility::allow_weapon_switch(1);
    }

    level.player scripts\sp\utility::func_1C72(1);
  }
}

func_B149(var_0) {
  switch (var_0) {
    case "iw7_erad":
      return (0, 0, 0);

    case "iw7_m4":
      return (15, 25, -10);
  }

  return (0, 0, 0);
}

func_B148(var_0) {
  switch (var_0) {
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
    var_0 = level.player getcurrentweapon();
    var_1 = getweaponbasename(var_0);
    if(level.player getteamsize()) {
      wait(1.9);
      var_2 = getweaponclipmodel(var_1);
      if(var_2 != "") {
        var_2 = var_2 + "_zerog";
        var_3 = level.player getplayerangles();
        var_4 = func_B149(var_1);
        var_5 = level.player getEye() + rotatevector(var_4, var_3);
        var_6 = spawn("script_model", var_5);
        var_6 setModel(var_2);
        var_6 thread func_4EB7();
        var_7 = func_B148(var_1);
        var_8 = rotatevector(var_7, var_3);
        var_6 physics_takecontrol(1, var_5 + (0, 0, randomfloatrange(-1, -0.5)), var_8);
        var_6 scripts\engine\utility::delaythread(60, ::scripts\sp\utility::func_F1DE);
      }
    }

    while(level.player getteamsize()) {
      wait(0.05);
    }
  }
}

func_D9E7(var_0) {
  var_1 = ["launcher_05"];
  foreach(var_3 in var_0) {
    if(scripts\engine\utility::array_contains(var_1, var_3)) {
      var_0 = scripts\engine\utility::array_remove(var_0, var_3);
    }
  }

  if(isDefined(level.var_E052)) {
    var_0 = scripts\engine\utility::array_remove_array(var_0, level.var_E052);
  }

  return var_0;
}

func_13C35() {
  level.player endon("death");
  level endon("weapon_outline_disable");
  scripts\sp\utility::func_9189("new_weapon", 1, "default");
  if(level.template_script == "europa") {
    return;
  }

  level scripts\engine\utility::waittill_notify_or_timeout("starting_weapons_scanned", 2);
  foreach(var_1 in level.var_D9E5["mandatoryunlocks"]) {
    if(func_9B49(var_1)) {
      var_2 = level.player func_84C6("weaponsScanned", var_1);
      if(isDefined(var_2) && var_2 != "locked") {
        level.var_D9E5["mandatoryunlocks"] = scripts\engine\utility::array_remove(level.var_D9E5["mandatoryunlocks"], var_1);
      }
    }
  }

  var_4 = level.var_D9E5["weapon_pickups"];
  var_5 = level.var_D9E5["optionalunlocks"];
  thread func_13C34(var_4);
  foreach(var_1 in var_4) {
    if(isDefined(var_1)) {
      var_7 = getsubstr(var_1.classname, 7);
      var_7 = getweaponbasename(var_7);
      if(scripts\engine\utility::array_contains(var_5, var_7)) {
        var_1 scripts\sp\utility::func_9196(4, 1, 0, "new_weapon");
      }
    }
  }

  var_9 = [];
  var_0A = [];
  var_0B = [];
  var_0C = [];
  while(var_5.size > 0) {
    var_9 = getweaponarray();
    if(!scripts\sp\utility::array_compare(var_0A, var_9)) {
      var_0B = scripts\engine\utility::array_remove_array(var_9, var_0A);
      foreach(var_1 in var_0B) {
        var_7 = getsubstr(var_1.classname, 7);
        var_7 = getweaponbasename(var_7);
        if(scripts\engine\utility::array_contains(var_5, var_7)) {
          var_1 scripts\sp\utility::func_9196(4, 1, 0, "new_weapon");
        }
      }

      var_0B = [];
    }

    wait(0.5);
    var_0A = var_9;
    var_5 = scripts\engine\utility::array_combine(level.var_D9E5["mandatoryunlocks"], level.var_D9E5["optionalunlocks"]);
  }
}

func_13C34(var_0) {
  level.player endon("death");
  level endon("weapon_outline_disable");
  for(;;) {
    level waittill("weapon_scan_complete", var_1);
    var_2 = getweaponarray();
    var_0 = scripts\engine\utility::array_combine(var_2, var_0);
    var_0 = scripts\engine\utility::array_combine(var_0, level.var_D9E5["armoryweapons"]);
    var_3 = level.var_D9E5["optionalunlocks"];
    foreach(var_5 in var_0) {
      if(isDefined(var_5)) {
        var_6 = getsubstr(var_5.classname, 7);
        var_6 = getweaponbasename(var_6);
        if(var_1 == var_6) {
          var_5 scripts\sp\utility::func_9193("new_weapon");
        }
      }
    }
  }
}

func_13C33() {
  level notify("weapon_outline_disable");
  var_0 = scripts\sp\utility::func_7DB7();
  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_3 = getsubstr(var_2.classname, 7);
      var_3 = getweaponbasename(var_3);
      if(func_9B49(var_3)) {
        var_2 scripts\sp\utility::func_9193();
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

  var_0 = level.var_D9E5["attachments"];
  level.player scripts\engine\utility::waittill_notify_or_timeout("weapon_change", 2);
  var_1 = level.player getweaponslist("primary");
  var_2 = getweaponbasename(level.player getcurrentprimaryweapon());
  var_3 = undefined;
  foreach(var_5 in var_1) {
    if(level.player scripts\sp\utility::func_65DF("zero_gravity") && level.player scripts\sp\utility::func_65DB("zero_gravity")) {
      var_6 = func_13BFC(var_5);
      if(var_6["weapon_changed"]) {
        var_7 = level.player getweaponammostock(var_5);
        var_8 = level.player getweaponammoclip(var_5);
        level.player takeweapon(var_5);
        var_5 = var_6["weapon"];
        level.player giveweapon(var_5);
        level.player setweaponammostock(var_5, var_7);
        level.player setweaponammoclip(var_5, var_8);
        var_9 = getweaponbasename(var_5);
        if(var_2 == var_9) {
          var_3 = var_5;
        }
      }
    }

    var_5 = getweaponbasename(var_5);
    if(!scripts\engine\utility::array_contains(func_DA17(), var_5) || issubstr(var_5, "snow")) {
      continue;
    }

    level.var_D9E5["weaponstates"][var_5] = "unlocked";
    level.var_D9E5["optionalunlocks"] = scripts\engine\utility::array_remove(level.var_D9E5["optionalunlocks"], var_5);
    level.var_D9E5["mandatoryunlocks"] = scripts\engine\utility::array_remove(level.var_D9E5["mandatoryunlocks"], var_5);
    var_0A = level.player func_84C6("weaponsScanned", var_5);
    if(!isDefined(var_0A) || var_0A == "locked") {
      level.player func_84C7("weaponsScanned", var_5, "unlocked");
    }
  }

  if(isDefined(var_3)) {
    level.player switchtoweapon(var_3);
  }

  level notify("starting_weapons_scanned");
  childthread watch_weapon_taken_thread();
  for(;;) {
    level.player waittill("weapon_change", var_0C);
    var_9 = getweaponbasename(var_0C);
    var_0D = undefined;
    var_0E = undefined;
    var_0F = 0;
    if(!isDefined(var_9) || !scripts\engine\utility::array_contains(func_DA17(), var_9)) {
      var_0F = 1;
    }

    if(!var_0F && !scripts\engine\utility::flag("weapon_scanning_off")) {
      var_10 = func_13C46();
      if(level.player scripts\sp\utility::func_65DF("zero_gravity") && level.player scripts\sp\utility::func_65DB("zero_gravity")) {
        var_6 = func_13BFC(var_0C);
        if(var_6["weapon_changed"]) {
          var_0D = level.player getweaponammostock(var_0C);
          var_0E = level.player getweaponammoclip(var_0C);
          level.player takeweapon(var_0C);
          var_0C = var_6["weapon"];
          level.player giveweapon(var_0C);
          level.player switchtoweapon(var_0C);
        }
      } else {
        var_6 = func_13C44(var_0C);
        if(var_6["weapon_changed"]) {
          var_0D = level.player getweaponammostock(var_0C);
          var_0E = level.player getweaponammoclip(var_0C);
          level.player takeweapon(var_0C);
          var_0C = var_6["weapon"];
          level.player giveweapon(var_0C);
          level.player switchtoweapon(var_0C);
        }
      }

      if(func_9D1A(var_9) || getdvarint("force_weapon_scan") == 1) {
        thread func_EBB6(var_9);
        if(!var_10) {
          var_11 = scripts\engine\utility::weaponclass(var_9);
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

        level thread func_F618(var_9);
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
  var_0 = level.player getcurrentweapon();
  var_1 = getweaponbasename(var_0);
  if(var_1 == "iw7_erad" || var_1 == "iw7_fhr" || var_1 == "iw7_counterweight" || var_1 == "iw7_sonic" || var_1 == "iw7_penetrationrail" || var_1 == "iw7_lockon" || var_1 == "iw7_sdfar" || var_1 == "iw7_gambit" || var_1 == "iw7_sdfshotty" || var_1 == "iw7_glr" || var_1 == "iw7_claw") {
    if(func_13C46()) {
      self setscriptablepartstate("weaponscan", "weaponscan_lg_on_combat");
    } else {
      self setscriptablepartstate("weaponscan", "weaponscan_lg_on");
    }
  } else if(var_1 == "iw7_kbs" || var_1 == "iw7_stasis" || var_1 == "iw7_m8" || var_1 == "iw7_cheytac" || var_1 == "iw7_lmg03" || var_1 == "iw7_sdflmg" || var_1 == "iw7_repeater" || var_1 == "iw7_m1") {
    if(func_13C46()) {
      self setscriptablepartstate("weaponscan", "weaponscan_long_on_combat");
    } else {
      self setscriptablepartstate("weaponscan", "weaponscan_long_on");
    }
  } else if(var_1 == "iw7_g18" || var_1 == "iw7_emc" || var_1 == "iw7_revolver" || var_1 == "iw7_nrg") {
    if(func_13C46()) {
      self setscriptablepartstate("weaponscan", "weaponscan_short_on_combat");
    } else {
      self setscriptablepartstate("weaponscan", "weaponscan_short_on");
    }
  } else if(var_1 == "iw7_steeldragon" || var_1 == "iw7_chargeshot" || var_1 == "iw7_mauler") {
    if(func_13C46()) {
      self setscriptablepartstate("weaponscan", "weaponscan_heavy_on_combat");
    } else if(var_1 == "iw7_chargeshot") {
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

func_EBB6(var_0) {
  level.player thread func_EBB5();
  wait(0.5);
  var_1 = strtok(var_0, "_");
  var_2 = undefined;
  if(isDefined(var_1[1])) {
    var_2 = "weapon_" + var_1[1];
  } else {
    return;
  }

  if(isDefined(var_2)) {
    setomnvar("ui_weapon_scanned", var_2);
    level notify("pc_weapon_scanned");
    thread func_EBB8();
  }
}

func_EBB8() {
  level endon("pc_weapon_scanned");
  wait(5.5);
  setomnvar("ui_weapon_scanned", "none");
}

func_9D1A(var_0) {
  if(!isDefined(level.var_D9E5) || !isDefined(level.var_D9E5["weaponstates"]) || !isDefined(level.var_D9E5["weaponstates"][var_0])) {
    return 0;
  }

  var_1 = level.var_D9E5["mission_specific_weapons"];
  if(level.var_D9E5["weaponstates"][var_0] == "locked") {
    return 1;
  }

  return 0;
}

func_3D6E() {
  var_0 = func_DA08();
  var_1 = 0;
  var_2 = func_D9F8();
  foreach(var_4 in var_2) {
    var_5 = level.player func_84C6("equipmentState", var_4);
    if(!isDefined(var_5)) {
      continue;
    }

    if(var_5 == "upgrade2") {
      var_1 = var_1 + 2;
      continue;
    }

    if(var_5 == "upgrade1") {
      var_1 = var_1 + 1;
    }
  }

  if(var_1 > 0) {
    scripts\sp\utility::settimer("FIRST_EQUIP_UPGRADE");
  }

  if(var_1 == var_0) {
    scripts\sp\utility::settimer("ALL_EQUIP_UPGRADES");
    func_EBB3("veh_mil_air_un_jackal_livery_shell_19");
  }
}

func_3DAE() {
  var_0 = 0;
  var_1 = 0;
  var_2 = func_D9FF();
  foreach(var_4 in var_2) {
    if(var_4 == "primary_default") {
      continue;
    }

    var_1++;
    var_5 = level.player func_84C6("jackalPrimaryState", var_4);
    if(var_5 != "locked") {
      var_0++;
    }
  }

  var_7 = func_DA01();
  foreach(var_9 in var_7) {
    if(var_9 == "secondary_default") {
      continue;
    }

    var_1++;
    var_5 = level.player func_84C6("jackalSecondaryState", var_9);
    if(var_5 != "locked") {
      var_0++;
    }
  }

  var_0B = func_DA03();
  foreach(var_0D in var_0B) {
    if(var_0D == "weapons" || var_0D == "hull") {
      continue;
    }

    var_1++;
    var_5 = level.player func_84C6("jackalUpgradeState", var_0D);
    if(var_5 != "locked") {
      var_0++;
    }
  }

  if(var_0 > 0) {
    scripts\sp\utility::settimer("FIRST_JACKAL_ITEM");
  }

  if(var_0 == var_1) {
    scripts\sp\utility::settimer("ALL_JACKAL_ITEMS");
  }
}

func_7D70(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = func_DA17();
  var_2 = ["iw7_m4", "iw7_fhr", "iw7_m8", "iw7_g18"];
  var_2 = scripts\engine\utility::array_combine(var_2, func_DA0A());
  var_2 = scripts\engine\utility::array_combine(var_2, func_DA10());
  if(var_0) {
    var_3 = level.player func_84C6("weaponsScanned", "iw7_ake");
    if(!isDefined(var_3)) {
      var_3 = "locked";
    }

    if(var_3 != "locked") {
      var_2 = scripts\engine\utility::array_add(var_2, "iw7_ake");
    }
  }

  var_1 = scripts\engine\utility::array_remove_array(var_1, var_2);
  var_4 = var_1.size;
  var_5 = 0;
  foreach(var_7 in var_1) {
    var_3 = level.player func_84C6("weaponsScanned", var_7);
    if(!isDefined(var_3)) {
      var_3 = "locked";
    }

    if(var_3 != "locked") {
      var_5++;
    }
  }

  return [var_5, var_4];
}

func_3DDF(var_0) {
  var_1 = func_7D70(var_0);
  if(var_1[0] > 0) {
    scripts\sp\utility::settimer("SCAN_1_WEAPON");
  }

  if(var_1[0] >= 10) {
    scripts\sp\utility::settimer("SCAN_10_WEAPONS");
  }

  if(var_1[0] == var_1[1]) {
    scripts\sp\utility::settimer("SCAN_ALL_WEAPONS");
    func_EBB3("veh_mil_air_un_jackal_livery_shell_18");
  }

  return var_1;
}

func_3DDD() {
  var_0 = func_DA15();
  var_1 = 0;
  var_2 = 0;
  var_3 = scripts\sp\endmission::func_7F6B("heist");
  var_4 = scripts\sp\endmission::func_7F69(var_3);
  foreach(var_6 in var_0) {
    var_2++;
    if(tolower(var_6) == "salenkoch" || var_6 == "riah") {
      if(var_4) {
        var_1++;
      }

      continue;
    }

    var_7 = level.player func_84C6("wantedBoardDataState", var_6);
    if(!isDefined(var_7)) {
      continue;
    }

    if(var_7 == "obtained" || var_7 == "viewed") {
      var_1++;
    }
  }

  if(var_1 > 0) {
    scripts\sp\utility::settimer("FIRST_WANTED_BOARD");
  }

  if(var_1 > 15) {
    scripts\sp\utility::settimer("HALF_WANTED_BOARD");
  }

  if(var_1 == var_2) {
    scripts\sp\utility::settimer("ALL_WANTED_BOARD");
    func_EBB3("veh_mil_air_un_jackal_livery_shell_17");
  }
}

func_3D6A(var_0) {
  if(!isDefined(var_0) || !var_0) {
    var_1 = func_DA1B();
  } else {
    var_1 = level.var_D9E5["achievementDoorPeek"];
  }

  var_2 = 1;
  foreach(var_4 in var_1) {
    if(!var_4) {
      var_2 = 0;
    }
  }

  if(var_2) {
    scripts\sp\utility::settimer("DOOR_PEEK");
    if(isDefined(var_0) && var_0) {
      foreach(var_5, var_4 in level.var_D9E5["achievementDoorPeek"]) {
        level.player func_84C7(var_5, var_4);
      }
    }
  }
}

func_3D61() {
  var_0 = level.player func_84C6("achievementBootsOnGround");
  if(isDefined(var_0) && var_0) {
    return;
  }

  var_1 = 120;
  level.var_C538 = 0;
  var_2 = 0;
  var_3 = 0;
  for(;;) {
    var_4 = level.player.origin;
    wait(0.05);
    var_5 = level.player.origin;
    var_6 = length(var_5 - var_4);
    if(level.player iswallrunning()) {
      level.var_C538 = 0;
      var_2 = 0;
      var_3 = 0;
    } else if(level.player scripts\engine\utility::get_doublejumpenergy() < 390 && level.player isjumping()) {
      level.var_C538 = 0;
      var_2 = 0;
      var_3 = 0;
    } else if(level.player scripts\engine\utility::get_doublejumpenergy() >= 390 && !level.player isjumping() && var_6 > 1.5 && !scripts\sp\utility::func_93AC() && !level.player islinked()) {
      if(var_2 == 0) {
        var_2 = gettime() / 1000;
      }

      level.var_C538 = var_3 + gettime() / 1000 - var_2;
    } else {
      var_2 = 0;
      var_3 = level.var_C538;
    }

    if(level.var_C538 >= var_1) {
      scripts\sp\utility::settimer("NO_JUMPING");
      level.player func_84C7("achievementBootsOnGround", 1);
      break;
    }

    wait(0.05);
  }
}

func_F618(var_0) {
  if(!isDefined(level.var_D9E5) || !isDefined(level.var_D9E5["weaponstates"]) || !isDefined(level.var_D9E5["weaponstates"][var_0])) {
    return 0;
  }

  level.var_D9E5["weaponstates"][var_0] = "scanned";
  level.player func_84C7("weaponsScanned", var_0, "scanned");
  func_DA50(var_0);
  var_1 = func_3DDF();
  if(scripts\engine\utility::array_contains(level.var_D9E5["optionalunlocks"], var_0)) {
    level.var_D9E5["optionalunlocks"] = scripts\engine\utility::array_remove(level.var_D9E5["optionalunlocks"], var_0);
  }

  if(scripts\engine\utility::array_contains(level.var_D9E5["mandatoryunlocks"], var_0)) {
    level.var_D9E5["mandatoryunlocks"] = scripts\engine\utility::array_remove(level.var_D9E5["mandatoryunlocks"], var_0);
  }

  level notify("weapon_scan_complete", var_0);
  if(var_1[0] <= 2) {
    wait(1.5);
    scripts\sp\utility::func_914C("fluff_messages_new_scan", "fluff_messages_new_scan_body", "scan_intel");
  }
}

func_DA50(var_0) {
  if(!func_DA41(var_0)) {
    return;
  }

  var_1 = "";
  switch (var_0) {
    case "iw7_counterweight":
      var_1 = "mp_weapon1";
      break;

    case "iw7_gambit":
      var_1 = "mp_weapon2";
      break;

    case "iw7_repeater":
      var_1 = "mp_weapon3";
      break;

    default:
      break;
  }
}

func_13C46() {
  var_0 = 1000;
  var_1 = getaiarray("axis");
  foreach(var_3 in var_1) {
    if(distancesquared(var_3.origin, level.player.origin) < squared(var_0)) {
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

func_12BD8(var_0) {
  level.var_D9E5["mandatoryunlocks"] = scripts\engine\utility::array_remove(level.var_D9E5["mandatoryunlocks"], var_0);
  level.var_D9E5["loaded_weapon_types"] = func_DA3F();
}

func_13C61(var_0) {
  level.var_D9E5["weaponstates"][var_0] = "unlocked";
  if(scripts\engine\utility::array_contains(level.var_D9E5["optionalunlocks"], var_0)) {
    level.var_D9E5["optionalunlocks"] = scripts\engine\utility::array_remove(level.var_D9E5["optionalunlocks"], var_0);
  }

  if(!level.var_D9E5["fakedata"]) {
    level.player func_84C7("weaponsScanned", var_0, "unlocked");
  }

  level.var_D9E5["loaded_weapon_types"] = func_DA3F();
}

func_66A4(var_0, var_1) {
  var_2 = level.player func_84C6("equipmentState", var_0);
  if(isDefined(var_2) && var_2 != "locked") {
    level.var_D9E5["weaponstates"][var_0] = var_2;
    return;
  }

  if(isDefined(var_1) && var_1) {
    var_3 = "unlocked";
  } else {
    var_3 = "scanned";
  }

  level.var_D9E5["weaponstates"][var_0] = var_3;
  level.player func_84C7("equipmentState", var_0, var_3);
}

func_7D5F(var_0) {
  var_1 = func_DA17("sdf");
  var_2 = func_DA17("un");
  var_3 = undefined;
  if(scripts\engine\utility::array_contains(var_1, var_0)) {
    var_3 = "allies";
  } else if(scripts\engine\utility::array_contains(var_2, var_0)) {
    var_3 = "axis";
  } else {
    var_3 = "other";
  }

  return var_3;
}

func_7BEC(var_0, var_1) {
  if(!isDefined(var_1)) {
    if(var_0 == "rpg") {
      var_1 = 1;
      var_0 = "rocketlauncher";
    } else {
      var_1 = 0;
    }
  }

  var_2 = undefined;
  var_3 = undefined;
  if(isDefined(level.var_D9E5) && isDefined(level.var_D9E5["loaded_weapon_types"])) {
    var_4 = level.var_D9E5["loaded_weapon_types"][var_0];
    var_4 = scripts\engine\utility::array_randomize(var_4);
    foreach(var_6 in var_4) {
      if(func_DA41(var_6.weapon_name)) {
        continue;
      }

      if(func_DA43(var_6.weapon_name)) {
        continue;
      }

      if(var_1 || !func_DA40(var_6.weapon_name)) {
        if(var_6.var_13C13 != self.team) {
          var_2 = var_6.weapon_name;
          continue;
        }

        var_2 = var_6.weapon_name;
        break;
      }
    }
  }

  if(!isDefined(var_2)) {
    var_4 = func_DA17("un", "sdf");
    var_4 = scripts\engine\utility::array_randomize(var_4);
    foreach(var_6 in var_4) {
      var_9 = scripts\engine\utility::weaponclass(var_6);
      if(var_9 == var_0) {
        var_2 = var_6;
        break;
      }
    }
  }

  var_3 = build_attach_models(var_2, "random", var_0);
  if(isDefined(var_3)) {
    var_2 = var_2 + "+" + var_3;
  }

  return var_2;
}

func_7BEB() {
  var_0 = undefined;
  if(isDefined(level.var_D9E5) && isDefined(level.var_D9E5["loaded_equipment_types"])) {
    var_1 = level.var_D9E5["loaded_equipment_types"];
    if(var_1.size > 0) {
      var_0 = scripts\engine\utility::random(var_1);
    }
  }

  if(!isDefined(var_0)) {
    var_0 = "frag";
  }

  if(var_0 == "offhandshield" || var_0 == "coverwall" || var_0 == "supportdrone" || var_0 == "hackingdevice") {
    var_0 = "frag";
  }

  if(var_0 == "seeker") {
    var_0 = "frag";
  }

  if(var_0 == "antigrav" || var_0 == "emp") {
    if(randomint(100) < 95) {
      var_0 = "frag";
    }
  }

  return var_0;
}

func_7AEA(var_0) {
  var_1 = getweaponbasename(var_0);
  var_2 = getsubstr(var_1, 4);
  var_3 = getweaponattachments(var_0);
  var_4 = [];
  var_5 = 0;
  foreach(var_7 in var_3) {
    if(issubstr(var_7, "acog") || issubstr(var_7, "elo") || issubstr(var_7, "smart") || issubstr(var_7, "reflex") || issubstr(var_7, "phase") || issubstr(var_7, "thermal") || issubstr(var_7, "hybrid") || issubstr(var_7, "vzscope") || issubstr(var_7, "oscope") || issubstr(var_7, "snproverlay") || issubstr(var_7, "nodualfov")) {
      var_5 = 1;
      break;
    }
  }

  if(!var_5) {
    if(isDefined(level.var_D9E5["attachments"]["default"]["scope"][var_2])) {
      foreach(var_0A in level.var_D9E5["attachments"]["default"]["scope"][var_2]) {
        if(!scripts\engine\utility::array_contains(var_3, var_0A.var_24A2)) {
          var_4 = scripts\engine\utility::array_add(var_4, var_0A.var_24A2);
        }
      }
    }
  } else if(var_2 == "m8") {
    if(!scripts\engine\utility::array_contains(var_3, "arm8_sp")) {
      scripts\engine\utility::array_add(var_4, "arm8_sp");
    }
  } else if(var_2 == "ripper") {
    if(!scripts\engine\utility::array_contains(var_3, "arripper_sp")) {
      scripts\engine\utility::array_add(var_4, "arripper_sp");
    }
  }

  if(var_2 == "fmg") {
    if(!scripts\engine\utility::array_contains(var_3, "akimbofmg_sp")) {
      scripts\engine\utility::array_add(var_4, "akimbofmg_sp");
    }
  }

  return var_4;
}

build_attach_models(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_0)) {}

  if(!isDefined(var_2)) {
    var_2 = scripts\engine\utility::weaponclass(var_0);
  }

  if(!isDefined(var_5)) {
    var_5 = 1;
  }

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  var_8 = getsubstr(var_0, 4);
  var_9 = undefined;
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
      var_1 = "random";
    }
  } else if(!isDefined(var_0D)) {
    if(var_8 == "ar57") {
      return "ar57scope";
    } else if(var_8 == "atomizer") {
      return "atomizerscope";
    } else if(var_8 == "chargeshot") {
      return "chargeshotscope";
    } else if(var_8 == "crb") {
      return "crblscope";
    } else if(var_8 == "erad") {
      return "eradscope";
    } else if(var_8 == "fmg") {
      return "akimbofmg_sp+fmgscope";
    } else if(var_8 == "kbs") {
      return "kbsscope";
    } else if(var_8 == "lmg03") {
      return "lmg03scope";
    } else if(var_8 == "lockon") {
      return "lockonscope";
    } else if(var_8 == "m8") {
      return "m8scope_sp";
    } else if(var_8 == "penetrationrail") {
      return "penetrationrailscope";
    } else if(var_8 == "ripper") {
      return "ripperrscope_sp";
    } else if(var_8 == "sonic") {
      return "sonicscope";
    } else if(var_8 == "sdfshotty") {
      return "sdfshottyscope";
    } else {
      return;
    }
  }

  if(!isDefined(var_0D[var_2])) {
    var_1 = "default";
  }

  if(var_1 == "default") {
    var_5 = 0;
  }

  if(var_0 == "iw7_gambit") {
    var_0E = func_D9F2(0);
  }

  if(func_DA40(var_0) || var_0 == "iw7_m1") {
    var_1 = "default";
    var_5 = 0;
  } else if(var_1 == "random") {
    var_0E = scripts\engine\utility::array_remove(var_0E, "silencer");
    if(var_0E.size > 1) {
      var_0E = scripts\engine\utility::array_add(var_0E, "none");
    }

    if(isDefined(level.var_72A6)) {
      var_1 = level.var_72A6;
      if(var_5 < 3) {
        var_5++;
      }
    } else if(var_0E.size > 0) {
      var_1 = var_0E[randomint(var_0E.size)];
    } else {
      var_5 = 0;
    }
  } else if(isDefined(var_7)) {
    var_1 = var_7[0];
    var_5 = var_7.size;
  }

  var_11 = 3;
  if(isDefined(var_7)) {
    var_11 = var_7.size;
  } else if(var_0 == "iw7_gambit") {
    var_11 = 4;
  }

  var_12 = 0;
  var_13 = 0;
  for(var_14 = 0; var_14 < var_5; var_14++) {
    var_15 = undefined;
    var_16 = undefined;
    var_17 = undefined;
    if(isDefined(var_1) && var_1 != "default") {
      if(isDefined(var_0D[var_2]) && isDefined(var_0D[var_2][var_1])) {
        if(isDefined(var_0D[var_2][var_1][var_8])) {
          var_15 = var_0D[var_2][var_1][var_8][0].location;
          var_16 = var_0D[var_2][var_1][var_8][0].var_24A2;
          var_17 = var_0D[var_2][var_1][var_8][0].var_9ECE;
        } else if(weaponusesenergybullets(var_0) && isDefined(var_0D[var_2][var_1][""][1])) {
          var_15 = var_0D[var_2][var_1][""][1].location;
          var_16 = var_0D[var_2][var_1][""][1].var_24A2;
          var_17 = var_0D[var_2][var_1][""][1].var_9ECE;
        } else if(isDefined(var_0D[var_2][var_1][""][0])) {
          var_15 = var_0D[var_2][var_1][""][0].location;
          var_16 = var_0D[var_2][var_1][""][0].var_24A2;
          var_17 = var_0D[var_2][var_1][""][0].var_9ECE;
        }
      }
    }

    if(isDefined(var_16)) {
      if(var_15 == "rail") {
        if(!var_0F) {
          var_9 = var_15;
          var_0C = scripts\engine\utility::array_add(var_0C, var_16);
          var_0F = 1;
          var_12++;
          if(var_17) {
            var_0A = 1;
          }
        }
      } else if(var_15 == "undermount") {
        if(!var_10) {
          var_9 = var_15;
          var_0C = scripts\engine\utility::array_add(var_0C, var_16);
          var_10 = 1;
          var_12++;
        }
      } else {
        var_9 = var_15;
        var_0C = scripts\engine\utility::array_add(var_0C, var_16);
        var_12++;
      }
    }

    if(var_12 == var_11) {
      break;
    }

    if(isDefined(var_7)) {
      var_13++;
      if(var_13 >= var_7.size) {
        break;
      }

      var_1 = var_7[var_13];
      continue;
    }

    var_0E = scripts\engine\utility::array_remove(var_0E, var_1);
    if(var_0E.size == 0) {
      break;
    }

    var_1 = var_0E[randomint(var_0E.size)];
  }

  if(var_6) {
    var_18 = "epic" + var_8;
    if(isDefined(var_0D[var_2][var_18]) && isDefined(var_0D[var_2][var_18][var_8])) {
      var_0C = scripts\engine\utility::array_add(var_0C, var_0D[var_2][var_18][var_8][0].var_24A2);
    }
  }

  if(!isDefined(var_3) || isDefined(var_3) && !var_3 || var_0A) {
    if(var_0C.size > 0) {
      if(var_0F && !var_0A) {
        var_0B = 0;
      }
    }

    if(!getdvarint("r_reflectionProbeGenerate")) {
      if(var_0B && isDefined(var_0D["default"]["scope"][var_8])) {
        var_16 = var_0D["default"]["scope"][var_8][0].var_24A2;
        var_9 = var_0D["default"]["scope"][var_8][0].location;
        var_0C = scripts\engine\utility::array_add(var_0C, var_16);
        var_0F = 1;
      } else if(var_8 == "m8") {
        var_0C = scripts\engine\utility::array_add(var_0C, "arm8_sp");
      } else if(var_8 == "ripper") {
        var_0C = scripts\engine\utility::array_add(var_0C, "arripper_sp");
      }

      if(var_8 == "fmg" && !scripts\engine\utility::array_contains(var_0C, "epicfmg")) {
        var_0C = scripts\engine\utility::array_add(var_0C, "akimbofmg_sp");
      } else if(var_8 == "erad") {
        if(scripts\engine\utility::array_contains(var_0C, "epicerad")) {
          var_0C = scripts\engine\utility::array_add(var_0C, "epicshotgunerad_sp");
        } else {
          var_0C = scripts\engine\utility::array_add(var_0C, "shotgunerad_sp");
        }
      } else if(var_8 == "repeater") {
        var_0C = scripts\engine\utility::array_add(var_0C, "mod_ammo");
      } else if(var_8 == "stasis") {
        var_0C = scripts\engine\utility::array_add(var_0C, "mod_ads_stability_sniper");
      } else if(var_8 == "counterweight") {
        var_0C = scripts\engine\utility::array_add(var_0C, "mod_recoil");
      }
    }
  }

  if(var_8 == "devastator" && scripts\engine\utility::array_contains(var_0C, "epicdevastator")) {
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
  } else if(var_8 == "emc" && scripts\engine\utility::array_contains(var_0C, "epicemc")) {
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

  if(isDefined(var_4) && var_4) {
    return [var_19, var_0F];
  }

  return var_19;
}

func_3DDC(var_0) {
  if(var_0 == "weapon") {
    var_1 = "loaded_weapons";
  } else {
    var_1 = "weaponstates";
  }

  if(!isDefined(level.var_D9E5)) {
    return 0;
  }

  if(!isDefined(level.var_D9E5[var_1])) {
    return 0;
  }

  if(level.var_D9E5[var_1].size < 1) {
    return 0;
  }

  if(!isDefined(level.var_D9E5["weaponstates"])) {
    return 0;
  }

  return 1;
}

func_D9E8(var_0) {
  if(!isDefined(var_0)) {
    if(isDefined(level.var_D9E5["attachment_overrides"])) {
      level.var_D9E5["attachment_overrides"] = undefined;
      return;
    }

    return;
  }

  level.var_D9E5["attachment_overrides"] = var_0;
}

func_7808() {
  var_0 = strtok(tablelookup("sp\progression_unlocks.csv", 0, "all_weapons", 2), ", ");
  var_1 = strtok(tablelookup("sp\progression_unlocks.csv", 0, "all_weapons", 3), ", ");
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  return var_2;
}

func_7807() {
  var_0 = strtok(tablelookup("sp\progression_unlocks.csv", 0, "all_weapons", 5), ", ");
  return var_0;
}

func_7806() {
  var_0 = strtok(tablelookup("sp\progression_unlocks.csv", 0, "all_weapons", 6), ", ");
  return var_0;
}

func_D9EF(var_0, var_1) {
  var_2 = [];
  foreach(var_4 in var_1) {
    var_5 = level.player func_84C6(var_0, var_4);
    if(!isDefined(level.player func_84C6(var_0, var_4))) {
      continue;
    }

    if(level.player func_84C6(var_0, var_4) == "scanned") {
      var_2 = scripts\engine\utility::array_add(var_2, var_4);
    }
  }

  return var_2;
}

func_DA0E() {
  var_0 = [];
  var_1 = func_DA12();
  var_0["suit_upgrades"] = func_D9EF("suitUpgradeState", var_1);
  var_2 = func_D9FC();
  var_0["jackal_decals"] = func_D9EF("jackalDecals", var_2);
  var_3 = func_D9FF();
  var_0["jackal_primaries"] = func_D9EF("jackalPrimaryState", var_3);
  var_4 = func_DA01();
  var_0["jackal_secondaries"] = func_D9EF("jackalSecondaryState", var_4);
  var_5 = func_DA03();
  var_0["jackal_upgrades"] = func_D9EF("jackalUpgradeState", var_5);
  var_6 = func_D9F2();
  var_0["attachments"] = func_D9EF("attachmentsState", var_6);
  var_7 = func_DA0D();
  var_0["reticles"] = func_D9EF("reticlesState", var_7);
  var_8 = func_D9F3();
  var_0["camos"] = func_D9EF("camosState", var_8);
  return var_0;
}

func_DA3C() {
  var_0 = func_DA15();
  var_1 = 1;
  var_2 = [];
  foreach(var_4 in var_0) {
    var_5 = level.player func_84C6("wantedBoardDataState", var_4);
    if(!isDefined(var_5) || var_5 != "obtained" && var_5 != "viewed") {
      var_1 = 0;
    }

    var_2[var_4] = var_5;
  }

  return var_2;
}

func_DA56(var_0, var_1) {
  level.var_D9E5["wanted_cards"][var_0] = var_1;
}

func_DA1B() {
  var_0 = [];
  var_0["achievementDoorPeekOpen"] = level.player func_84C6("achievementDoorPeekOpen");
  var_0["achievementDoorPeekKick"] = level.player func_84C6("achievementDoorPeekKick");
  var_0["achievementDoorPeekGrenade"] = level.player func_84C6("achievementDoorPeekGrenade");
  return var_0;
}

func_DA08() {
  return 12;
}

func_DA4F() {
  var_0 = level.player func_84C6("scrapCount");
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = func_DA38();
  foreach(var_8, var_3 in var_1) {
    foreach(var_7, var_5 in var_3) {
      if(int(var_5) <= var_0) {
        if(var_8 == "attachment") {
          var_6 = level.player func_84C6("attachmentsState", var_7);
          if(var_6 == "locked") {
            level.player func_84C7("attachmentsState", var_7, "scanned");
          }

          continue;
        }

        if(var_8 == "reticle") {
          var_6 = level.player func_84C6("reticlesState", var_7);
          if(var_6 == "locked") {
            level.player func_84C7("reticlesState", var_7, "scanned");
          }
        }
      }
    }
  }

  func_DA0E();
}

func_DA4E() {
  foreach(var_1 in level.var_D9E5["scanned_items"]["suit_upgrades"]) {
    level.player func_84C7("suitUpgradeState", var_1, "unlocked");
  }
}

func_DA48() {
  foreach(var_1 in level.var_D9E5["scanned_items"]["suit_upgrades"]) {
    level.player func_84C7("suitUpgradeState", var_1, "unlocked");
  }

  foreach(var_1 in level.var_D9E5["scanned_items"]["jackal_decals"]) {
    level.player func_84C7("jackalDecals", var_1, "unlocked");
  }

  foreach(var_1 in level.var_D9E5["scanned_items"]["jackal_primaries"]) {
    level.player func_84C7("jackalPrimaryState", var_1, "unlocked");
  }

  foreach(var_1 in level.var_D9E5["scanned_items"]["jackal_secondaries"]) {
    level.player func_84C7("jackalSecondaryState", var_1, "unlocked");
  }

  foreach(var_1 in level.var_D9E5["scanned_items"]["jackal_upgrades"]) {
    level.player func_84C7("jackalUpgradeState", var_1, "unlocked");
  }

  foreach(var_1 in level.var_D9E5["scanned_items"]["attachments"]) {
    level.player func_84C7("attachmentsState", var_1, "unlocked");
  }

  foreach(var_1 in level.var_D9E5["scanned_items"]["reticles"]) {
    level.player func_84C7("reticlesState", var_1, "unlocked");
  }

  foreach(var_1 in level.var_D9E5["scanned_items"]["camos"]) {
    level.player func_84C7("camosState", var_1, "unlocked");
  }

  foreach(var_13, var_12 in level.var_D9E5["weaponstates"]) {
    if(func_9B49(var_13) && var_12 == "scanned") {
      level.var_D9E5["weaponstates"][var_13] = "unlocked";
      level.player func_84C7("weaponsScanned", var_13, "unlocked");
    }
  }
}

func_D9F0(var_0, var_1) {
  var_2 = [];
  foreach(var_4 in var_1) {
    if(!isDefined(level.player)) {
      continue;
    }

    var_5 = level.player func_84C6(var_0, var_4);
    if(!isDefined(var_5)) {
      continue;
    }

    if((isstring(var_5) && level.player func_84C6(var_0, var_4) == "unlocked") || !isstring(var_5) && level.player func_84C6(var_0, var_4) == 1) {
      var_2 = scripts\engine\utility::array_add(var_2, var_4);
    }
  }

  return var_2;
}

func_D9EC(var_0) {
  if(!isDefined(level.var_D9E5["ace_pilots"])) {
    return "acepilot0";
  }

  if(!isDefined(level.var_D9E5["ace_pilots"][var_0])) {
    return "acepilot0";
  }

  return level.var_D9E5["ace_pilots"][var_0];
}

func_DA45(var_0, var_1) {
  if(!isDefined(level.var_D9E5)) {
    return;
  }

  if(!isDefined(level.var_D9E5["wanted_cards"])) {
    return;
  }

  if(!isDefined(level.var_D9E5["wanted_cards"][var_0])) {
    return;
  }

  var_2 = level.var_D9E5["wanted_cards"][var_0];
  if(var_2 == "locked") {
    level.var_D9E5["wanted_cards"][var_0] = "obtained";
  }

  if(isDefined(var_1)) {
    wait(var_1);
  }

  var_3 = "most_wanted_portait_" + var_0;
  scripts\sp\utility::func_914C("mostwanted_target_killed", "mostwanted_" + var_0 + "_killed", "intel_" + var_0);
}

func_12E18() {
  if(!isDefined(level.var_D9E5)) {
    return;
  }

  if(func_9CBB(level.template_script)) {
    func_DA48();
  }

  foreach(var_1 in level.var_D9E5["suit_upgrades"]) {
    level.player func_84C7("suitUpgradeState", var_1, "unlocked");
  }

  foreach(var_1 in level.var_D9E5["mandatory_suit_upgrades"]) {
    var_4 = level.player func_84C6("suitUpgradeState", var_1);
    if(var_4 == "locked") {
      level.player func_84C7("suitUpgradeState", var_1, "scanned");
    }
  }

  foreach(var_7 in level.var_D9E5["mandatory_jackal_primaries"]) {
    var_4 = level.player func_84C6("jackalPrimaryState", var_7);
    if(var_4 == "locked") {
      level.player func_84C7("jackalPrimaryState", var_7, "scanned");
    }
  }

  foreach(var_0A in level.var_D9E5["mandatory_jackal_secondaries"]) {
    var_4 = level.player func_84C6("jackalSecondaryState", var_0A);
    if(var_4 == "locked") {
      level.player func_84C7("jackalSecondaryState", var_0A, "scanned");
    }
  }

  foreach(var_0D in level.var_D9E5["mandatory_jackal_upgrades"]) {
    var_4 = level.player func_84C6("jackalUpgradeState", var_0D);
    if(var_4 == "locked") {
      level.player func_84C7("jackalUpgradeState", var_0D, "scanned");
    }
  }

  foreach(var_10 in level.var_D9E5["mandatory_jackal_decals"]) {
    var_4 = level.player func_84C6("jackalDecals", var_10);
    if(var_4 == "locked") {
      level.player func_84C7("jackalDecals", var_10, "scanned");
    }
  }

  func_3DAE();
  foreach(var_13, var_4 in level.var_D9E5["wanted_cards"]) {
    level.player func_84C7("wantedBoardDataState", var_13, var_4);
  }

  func_3DDD();
  foreach(var_16, var_15 in level.var_D9E5["achievementDoorPeek"]) {
    level.player func_84C7(var_16, var_15);
  }

  func_3D6A();
  foreach(var_18, var_4 in level.var_D9E5["weaponstates"]) {
    if(func_9B49(var_18)) {
      level.player func_84C7("weaponsScanned", var_18, var_4);
    }
  }

  if(isDefined(level.template_script)) {
    level.player func_84C7("lastCompletedMission", level.template_script);
    game["lastcompletedmission"] = level.template_script;
  }

  if(level.var_D9E5["submission"] != "submission") {
    level.player func_84C7("missionStateData", level.var_D9E5["submission"], "complete");
    level.player func_84C7("opsmapMissionStateData", level.var_D9E5["submission"], "complete");
  }
}

func_9B49(var_0) {
  var_1 = func_D9F8();
  if(func_9B44(var_0)) {
    return 0;
  }

  if(var_0 == "none") {
    return 0;
  }

  return !scripts\engine\utility::array_contains(var_1, var_0);
}

func_9B44(var_0) {
  var_1 = func_D9FC();
  foreach(var_3 in var_1) {
    if(issubstr(var_3, var_0)) {
      return 1;
    }
  }

  return 0;
}

func_EBB7(var_0) {
  if(level.player func_84C6("weaponsScanned", var_0) == "locked") {
    level.player func_84C7("weaponsScanned", var_0, "scanned");
    func_DA50(var_0);
  }
}

func_EBB3(var_0) {
  if(level.player func_84C6("jackalDecals", var_0) == "locked") {
    level.player func_84C7("jackalDecals", var_0, "scanned");
  }
}

func_5F2F() {
  for(var_0 = 0; var_0 < level.var_B8D2.var_ABFA.size; var_0++) {
    if(scripts\sp\endmission::getitemslot(var_0)) {
      continue;
    }

    var_1 = scripts\sp\endmission::func_7F69(var_0);
    var_2 = level.player func_84C6("missionStateData", scripts\sp\endmission::func_7F6D(var_0));
    if(var_1 == 1) {
      var_2 = "COMPLETE - Recruit";
      continue;
    }

    if(var_1 == 2) {
      var_2 = "COMPLETE - Regular";
      continue;
    }

    if(var_1 == 3) {
      var_2 = "COMPLETE - Hardened";
      continue;
    }

    if(var_1 == 4) {
      var_2 = "COMPLETE - Veteran";
      continue;
    }

    if(var_1 == 5) {
      var_2 = "COMPLETE - Specialist";
      continue;
    }

    if(var_1 == 6) {
      var_2 = "COMPLETE - YOLO";
    }
  }

  foreach(var_4 in func_DA17()) {
    if(func_9B49(var_4)) {
      if(!func_DA41(var_4) && !func_DA43(var_4)) {}
    }
  }

  foreach(var_4 in func_DA17()) {
    if(func_9B49(var_4)) {
      if(func_DA41(var_4)) {}
    }
  }

  foreach(var_4 in func_DA17()) {
    if(func_9B49(var_4)) {
      if(func_DA43(var_4)) {}
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
      var_26 = level.player func_84C6("missionLootRooms", var_22, "discovered", var_25);
      if(var_26) {}

      for(var_27 = 0; var_27 < 1; var_27++) {
        var_28 = var_25 * 2 + var_27;
        var_29 = level.player func_84C6("missionLootRooms", var_22, "terminal", var_28);
        if(var_29) {
          continue;
        }
      }
    }
  }

  for(var_2B = 0; var_2B < 4; var_2B++) {
    var_2C = level.player func_84C6("loadouts", var_2B, "name");
    var_2D = level.player func_84C6("loadouts", var_2B, "weaponSetups", 0, "weapon");
    var_2E[0] = level.player func_84C6("loadouts", var_2B, "weaponSetups", 0, "attachment", 0);
    var_2E[1] = level.player func_84C6("loadouts", var_2B, "weaponSetups", 0, "attachment", 1);
    var_2E[2] = level.player func_84C6("loadouts", var_2B, "weaponSetups", 0, "attachment", 2);
    var_2F = level.player func_84C6("loadouts", var_2B, "weaponSetups", 1, "weapon");
    var_30[0] = level.player func_84C6("loadouts", var_2B, "weaponSetups", 1, "attachment", 0);
    var_30[1] = level.player func_84C6("loadouts", var_2B, "weaponSetups", 1, "attachment", 1);
    var_30[2] = level.player func_84C6("loadouts", var_2B, "weaponSetups", 1, "attachment", 2);
    var_31 = level.player func_84C6("loadouts", var_2B, "equipment", 0);
    var_32 = level.player func_84C6("loadouts", var_2B, "offhandEquipment", 0);
    var_33 = level.player func_84C6("loadouts", var_2B, "equipment", 1);
    var_34 = level.player func_84C6("loadouts", var_2B, "offhandEquipment", 1);
  }

  if(level.player func_84C6("unlockedRealism")) {}

  if(level.player func_84C6("beatRealism")) {}

  if(level.player func_84C6("achievementDoorPeekOpen")) {}

  if(level.player func_84C6("achievementDoorPeekKick")) {}

  if(level.player func_84C6("achievementDoorPeekGrenade")) {}
}

func_E222() {
  level.player func_84C7("scrapCount", 0);
  foreach(var_1 in func_DA12()) {
    level.player func_84C7("suitUpgradeState", var_1, "locked");
  }

  foreach(var_4 in func_D9FF()) {
    level.player func_84C7("jackalPrimaryState", var_4, "locked");
  }

  foreach(var_7 in func_DA01()) {
    level.player func_84C7("jackalSecondaryState", var_7, "locked");
  }

  foreach(var_0A in func_DA03()) {
    level.player func_84C7("jackalUpgradeState", var_0A, "locked");
  }

  foreach(var_0D in func_D9FC()) {
    level.player func_84C7("jackalDecals", var_0D, "locked");
  }

  foreach(var_10 in func_DA15()) {
    level.player func_84C7("wantedBoardDataState", var_10, "locked");
  }

  foreach(var_13 in func_DA17()) {
    if(func_DA41(var_13)) {
      continue;
    }

    if(func_DA43(var_13)) {
      continue;
    }

    if(func_9B49(var_13)) {
      level.player func_84C7("weaponsScanned", var_13, "locked");
      continue;
    }

    level.player func_84C7("equipmentState", var_13, "locked");
  }

  var_15 = func_D9F2(1);
  foreach(var_17 in var_15) {
    level.player func_84C7("attachmentsState", var_17, "locked");
  }

  var_19 = func_DA0D();
  foreach(var_1B in var_19) {
    level.player func_84C7("reticlesState", var_1B, "locked");
  }

  var_1D = func_D9F3();
  foreach(var_1F in var_1D) {
    level.player func_84C7("camosState", var_1F, "locked");
  }

  var_21 = func_DA15();
  foreach(var_23 in var_21) {
    level.player func_84C7("wantedBoardDataState", var_23, "locked");
  }

  level.player func_84C7("currentLoadout", "levelCreated", 0);
  level.player func_84C7("currentLoadout", "heldWeapon", "none");
  for(var_25 = 0; var_25 < 2; var_25++) {
    level.player func_84C7("currentLoadout", "weaponSetups", var_25, "weapon", "none");
    level.player func_84C7("currentLoadout", "weaponSetups", var_25, "reticle", "none");
    level.player func_84C7("currentLoadout", "weaponClipAmmo", var_25, 0);
    level.player func_84C7("currentLoadout", "weaponStockAmmo", var_25, 0);
    for(var_26 = 0; var_26 < 3; var_26++) {
      level.player func_84C7("currentLoadout", "weaponSetups", var_25, "attachment", var_26, "none");
    }
  }

  level.player func_84C7("currentLoadout", "offhandEquipment", 0, "none");
  level.player func_84C7("currentLoadout", "offhandEquipmentAmmo", 0, 0);
  level.player func_84C7("currentLoadout", "offhandEquipment", 1, "none");
  level.player func_84C7("currentLoadout", "offhandEquipmentAmmo", 1, 0);
  level.player func_84C7("currentLoadout", "equipment", 0, "none");
  level.player func_84C7("currentLoadout", "equipmentAmmo", 0, 0);
  level.player func_84C7("currentLoadout", "equipment", 1, "none");
  level.player func_84C7("currentLoadout", "equipmentAmmo", 1, 0);
  level.player func_84C7("lastCompletedMission", "");
  level.player func_84C7("lastShipcribMission", "");
  level.player func_84C7("lastWeaponPreload", "");
  level.player func_84C7("currentViewModel", "");
  level.player func_84C7("currentSelectedWeapon", "");
  level.player func_84C7("jackalDecal", "none");
  level.player func_84C7("selectedLoadout", 0);
  level.player func_84C7("forcedAttachment", "none");
  level.player func_84C7("scTitanFirstPlay", 0);
  level.player func_84C7("scPrisonerFirstPlay", 0);
  level.player func_84C7("scTaughtVR", 0);
  level.player func_84C7("scTaughtVREnergy", 0);
  level.player func_84C7("scTaughtVRMenu", 0);
  level.player func_84C7("scTaughtWantedBoard", 0);
  level.player func_84C7("scTaughtOpsmap", 0);
  level.player func_84C7("c12AchievementRodeoLeft", 0);
  level.player func_84C7("c12AchievementRodeoRight", 0);
  level.player func_84C7("c12AchievementSelfdestruct", 0);
  level.player func_84C7("hintAltM8", 0);
  level.player func_84C7("hintAltFMG", 0);
  level.player func_84C7("hintAltRipper", 0);
  level.player func_84C7("hintAltERAD", 0);
  var_27 = func_7AF1("sub");
  foreach(var_29 in var_27) {
    for(var_2A = 0; var_2A < 2; var_2A++) {
      level.player func_84C7("missionLootRooms", var_29, "discovered", var_2A, 0);
      for(var_2B = 0; var_2B < 2; var_2B++) {
        var_2C = var_2A * 2 + var_2B;
        level.player func_84C7("missionLootRooms", var_29, "terminal", var_2B, 0);
      }
    }

    level.player func_84C7("missionStateData", var_29, "locked");
    level.player func_84C7("opsmapMissionStateData", var_29, "locked");
  }

  var_2E = func_7AF1("main", "sub");
  foreach(var_30 in var_2E) {
    level.player func_84C7("shipAssaultStateData", var_30, "locked");
  }

  func_492B(1);
  func_5F2F();
}