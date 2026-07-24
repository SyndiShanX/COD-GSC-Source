/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2607.gsc
**************************************/

_id_7AF1(var_0, var_1) {
  var_2 = ["yard", "mars", "heist", "prisoner", "rogue", "titan", "sa_moon", "moon_port", "pearlharbor", "europa"];
  var_3 = ["sa_assassination", "sa_empambush", "sa_vips", "sa_wounded", "ja_spacestation", "ja_asteroid", "ja_mining", "ja_titan", "ja_wreckage"];
  var_4 = ["shipcrib_epilogue", "shipcrib_titan", "shipcrib_europa", "shipcrib_moon", "shipcrib_rogue", "shipcrib_prisoner", "phparade", "phspace", "phstreets", "marscrash", "marscrib", "marsbase", "moonjackal", "titanjackal", "heistspace"];

  if(isDefined(var_0) && var_0 == "main" || isDefined(var_1) && var_1 == "main")
    var_2 = [];

  if(isDefined(var_0) && var_0 == "sa" || isDefined(var_1) && var_1 == "sa")
    var_3 = [];

  if(isDefined(var_0) && var_0 == "sub" || isDefined(var_1) && var_1 == "sub")
    var_4 = [];

  var_5 = [];
  var_5 = scripts\engine\utility::array_combine(var_3, var_2);
  var_5 = scripts\engine\utility::array_combine(var_5, var_4);
  var_5 = scripts\engine\utility::array_remove_duplicates(var_5);
  return var_5;
}

_id_7AEB() {
  var_0 = ["dh_test", "dk_test", "jku_test", "ma_test", "vr_firing_range"];
  return var_0;
}

_id_9CBB(var_0) {
  var_1 = ["shipcrib_epilogue", "shipcrib_titan", "shipcrib_europa", "shipcrib_moon", "shipcrib_rogue", "shipcrib_prisoner", "marscrib"];
  return scripts\engine\utility::array_contains(var_1, var_0);
}

is_jackal_arena_level(var_0) {
  var_1 = ["ja_spacestation", "ja_asteroid", "ja_mining", "ja_titan", "ja_wreckage"];
  return scripts\engine\utility::array_contains(var_1, var_0);
}

_id_DA17(var_0, var_1) {
  var_2 = ["iw7_fhr", "iw7_crb", "iw7_ripper", "iw7_ar57", "iw7_m4", "iw7_devastator", "iw7_kbs", "iw7_steeldragon", "iw7_mauler", "iw7_lockon", "iw7_g18", "iw7_m1", "iw7_ake_gold"];
  var_3 = ["iw7_emc", "iw7_ake", "iw7_nrg", "iw7_erad", "iw7_m8", "iw7_fmg", "iw7_sonic", "iw7_sdfshotty", "iw7_sdfar", "iw7_sdflmg", "iw7_lmg03", "iw7_chargeshot", "iw7_penetrationrail", "iw7_ump45", "iw7_atomizer"];
  var_4 = ["iw7_ar57", "iw7_fhr", "iw7_g18", "iw7_devastator", "iw7_kbs", "iw7_ake", "iw7_sdflmg", "iw7_steeldragon"];

  if(isDefined(var_0) && var_0 == "un" || isDefined(var_1) && var_1 == "un")
    var_2 = [];

  if(isDefined(var_0) && var_0 == "sdf" || isDefined(var_1) && var_1 == "sdf")
    var_3 = [];

  var_5 = [];
  var_5 = scripts\engine\utility::array_combine(var_2, var_3);
  var_5 = scripts\engine\utility::array_remove_duplicates(var_5);

  if(var_5.size < 1)
    var_5 = var_4;

  return var_5;
}

_id_D9F7() {
  var_0 = ["iw7_g18", "iw7_m4", "iw7_ripper"];
  return var_0;
}

_id_D9F8(var_0) {
  var_1 = ["frag", "emp", "seeker", "antigrav"];
  var_2 = ["supportdrone", "offhandshield", "hackingdevice", "coverwall"];

  if(isDefined(var_0) && var_0 == "offhands")
    var_1 = [];

  if(isDefined(var_0) && var_0 == "items")
    var_2 = [];

  var_3 = scripts\engine\utility::array_combine(var_1, var_2);
  return var_3;
}

_id_D9FA() {
  var_0 = ["iw7_steeldragon", "iw7_chargeshot", "iw7_lockon", "iw7_atomizer", "iw7_penetrationrail"];
  return var_0;
}

_id_DA40(var_0) {
  if(scripts\engine\utility::array_contains(_id_D9FA(), getweaponbasename(var_0)))
    return 1;
  else
    return 0;
}

_id_DA0A() {
  var_0 = ["iw7_stasis", "iw7_repeater", "iw7_gambit", "iw7_counterweight"];
  return var_0;
}

_id_DA10() {
  var_0 = ["iw7_m1", "iw7_ake_gold"];
  return var_0;
}

_id_DA41(var_0) {
  if(scripts\engine\utility::array_contains(_id_DA0A(), getweaponbasename(var_0)))
    return 1;
  else
    return 0;
}

_id_DA43(var_0) {
  if(scripts\engine\utility::array_contains(_id_DA10(), getweaponbasename(var_0)))
    return 1;
  else
    return 0;
}

_id_DA42(var_0) {
  if(_id_9B44(var_0))
    return 0;

  if(scripts\engine\utility::weaponclass(var_0) != "rifle" && scripts\engine\utility::weaponclass(var_0) != "mg")
    return 0;

  return !_id_DA40(var_0);
}

_id_DA12() {
  var_0 = ["steadyaim", "quickdraw", "blastshield", "quickswap", "agility", "fastreload", "extraequipment", "fastregen", "focus", "slasher", "shocker"];
  return var_0;
}

_id_D9FF() {
  var_0 = ["primary_default", "primary_upgrade_1", "primary_upgrade_2"];
  return var_0;
}

_id_DA01() {
  var_0 = ["secondary_default", "secondary_upgrade_1", "secondary_upgrade_2"];
  return var_0;
}

_id_DA03() {
  var_0 = ["weapons", "thrusters", "hull"];
  return var_0;
}

_id_D9FC() {
  var_0 = ["veh_mil_air_un_jackal_livery_shell_01", "veh_mil_air_un_jackal_livery_shell_02", "veh_mil_air_un_jackal_livery_shell_03", "veh_mil_air_un_jackal_livery_shell_04", "veh_mil_air_un_jackal_livery_shell_05", "veh_mil_air_un_jackal_livery_shell_06", "veh_mil_air_un_jackal_livery_shell_07", "veh_mil_air_un_jackal_livery_shell_08", "veh_mil_air_un_jackal_livery_shell_09", "veh_mil_air_un_jackal_livery_shell_10", "veh_mil_air_un_jackal_livery_shell_11", "veh_mil_air_un_jackal_livery_shell_12", "veh_mil_air_un_jackal_livery_shell_13", "veh_mil_air_un_jackal_livery_shell_14", "veh_mil_air_un_jackal_livery_shell_15", "veh_mil_air_un_jackal_livery_shell_16", "veh_mil_air_un_jackal_livery_shell_17", "veh_mil_air_un_jackal_livery_shell_18", "veh_mil_air_un_jackal_livery_shell_19", "veh_mil_air_un_jackal_livery_shell_20", "veh_mil_air_un_jackal_livery_shell_21", "veh_mil_air_un_jackal_livery_shell_22"];
  return var_0;
}

_id_DA15() {
  var_0 = ["salenKoch", "riah", "captain0", "captain1", "captain2", "captain3", "captain4", "captain5", "captain6", "captain7", "captain8", "captain9", "acepilot0", "acepilot1", "acepilot2", "acepilot3", "acepilot4", "acepilot5", "acepilot6", "acepilot7", "acepilot8", "acepilot9", "acepilot10", "acepilot11", "acepilot12", "acepilot13", "acepilot14", "acepilot15", "acepilot16", "acepilot17", "acepilot18", "acepilot19"];
  return var_0;
}

_id_DA09() {
  var_0 = ["europa", "pearlharbor", "phparade", "phstreets", "phspace", "shipcrib_moon", "moon_port", "moonjackal", "sa_moon", "shipcrib_europa", "sa_vips", "sa_empambush", "sa_wounded", "sa_assassination", "shipcrib_titan", "titan", "titanjackal", "ja_spacestation", "ja_asteroid", "ja_wreckage", "shipcrib_rogue", "ja_titan", "rogue", "shipcrib_prisoner", "ja_mining", "prisoner", "heist", "heistspace", "mars", "marscrash", "marscrib", "marsbase", "yard", "shipcrib_epilogue"];
  return var_0;
}

_id_D9F2(var_0) {
  var_1 = ["acog", "elo", "smart", "akimbo", "oscope", "reflect", "xmags", "reflex", "phase", "thermal", "hybrid", "vzscope", "silencer", "barrelrange", "grip", "cpu", "rof", "fastaim", "scope", "nodualfov", "snproverlay"];

  if(isDefined(var_0) && !var_0)
    return var_1;

  var_2 = ["epicar57", "epicm4", "epicake", "epicsdfar", "epicfmg", "epicmauler", "epicsdflmg", "epiclmg03", "epicerad", "epiccrb", "epicripper", "epicfhr", "epicm8", "epickbs", "epicsdfshotty", "epicdevastator", "epicsonic", "epicemc", "epicnrg", "epicg18", "epicump45"];
  return scripts\engine\utility::array_combine(var_1, var_2);
}

_id_D9F1() {
  var_0 = ["acog", "acogake", "acogake_gold", "acogsmg", "acogsmgnoalt", "acogpistol", "acoglmg", "acogarnoalt", "acogkbs", "acogm8", "acogm4", "acoglmgnoalt", "reflex", "reflexake_gold", "reflexake", "reflexfmg", "reflexshotgun", "reflexsmg", "reflexlmg", "reflexpstl", "reflexnrg", "phase_sp", "phaseake_sp", "phaseake_spgold", "phasefmg_sp", "phaseshotgun_sp", "phasesmg_sp", "phaselmg_sp", "phasepstl_sp", "phasenrg_sp", "thermal", "thermalake", "thermalake_gold", "thermalfmg", "thermalsmg", "thermallmg", "thermalkbs", "thermalm8", "thermalm4", "hybrid", "hybridake", "hybridake_gold", "hybridarnoalt", "hybridsmg", "hybridsmgnoalt", "hybridlmg", "elo", "eloake", "eloake_gold", "elofmg", "elodmr", "elolmg", "elopstl", "elonrg", "eloshtgn", "elosmg", "elokbs", "elom8", "vzscope", "kbsvzscope", "oscope", "kbsoscope", "smart", "silencer", "silencersmg", "silencerpstl", "silencershtgn", "silencerdmr", "silencersnpr", "silencersniperhide", "silencersniperhidee", "silencere", "silencere_gold", "silencerefmg", "silencersmge", "silencerpstle", "silencershtgne", "silencersnpre", "silencershtgns", "barrelrange", "barrelrangesmg", "barrelrangepstl", "barrelrangeshtgn", "barrelrangedmr", "barrelrangesmge", "barrelrangee", "barrelrangepstle", "barrelrangeshtgne", "barrelrangeshtgns_sp", "grip", "griphide", "griphide", "gripake", "gripake_gold", "gripar57", "gripm4", "gripsdfar", "gripcrbl", "gripripperr", "gripump45l", "gripsnpr", "gripsnpr", "gripfmg", "gripshtgn", "gripsdfshotty", "gripdevastator", "cpu", "akimbo", "akimboemc", "akimbonrg", "akimbog18", "akimbofmg_sp", "reflect", "rof", "rof", "rofar", "rofar", "rofshtgn", "rofshtgn", "roflmg", "roflmg", "rofdmr", "rofsnpr", "rofsnpr", "rofburst", "xmags", "xmagse", "xmagsepstl", "xmagsenrg", "xmagselmg", "xmagseshtgn", "xmagseshtgnpump", "fastaim", "fastaimsnpr", "fastaimdmr", "chargeshotscope", "ripperrscope_sp", "eradscope", "ump45lscope", "crblscope", "ar57scope", "fmgscope", "kbsscope", "kbsscope", "m8scope_sp", "lockonscope", "arm8_sp", "arripper_sp", "shotgunerad_sp", "atomizerscope", "lmg03scope", "sonicscope", "sdfshottyscope", "penetrationrailscope_sp", "epicar57", "epicm4", "epicake", "epicsdfar", "epicfmg", "epicmauler", "epicsdflmg", "epiclmg03", "epicerad", "epiccrb", "epicripper", "epicump45", "epicfhr", "epicm8", "epickbs", "epicsdfshotty", "epicdevastator", "epicsonic", "epicemc", "epicnrg", "epicg18"];
  return var_0;
}

_id_DA0F() {
  var_0 = ["acog", "elo", "smart", "oscope", "reflex", "phase", "thermal", "scope", "hybrid", "vzscope"];
  return var_0;
}

_id_DA0D() {
  var_0 = ["scope1", "scope2", "scope3", "scope4", "scope5", "scope6", "scope7", "scope8", "scope9", "scope10"];
  return var_0;
}

_id_D9F3() {
  var_0 = ["snow", "camo02", "camo03", "camo04", "camo05", "camo07", "camo08", "camo09", "camo10", "camo11", "camo12", "camo13", "camo14", "camo15", "camo17", "camo18", "camo19", "camo20", "camo21", "camo22", "camo23", "camo24", "camo25", "camo27", "camo28", "camo29", "camo30"];
  return var_0;
}

_id_7BB5(var_0) {
  if(!isDefined(var_0))
    return undefined;

  switch (var_0) {
    case "frag":
      if(_id_0E42::_hasperk("upgrade_frag_1") || _id_0E42::_hasperk("upgrade_frag_2"))
        return "frag_up1";

      break;
    case "offhandshield":
      if(_id_0E42::_hasperk("upgrade_shield_1"))
        return "offhandshield_up1";

      break;
    case "supportdrone":
      if(_id_0E42::_hasperk("upgrade_drone_1"))
        return "supportdrone_up2";

      break;
  }

  return var_0;
}

_id_82FE(var_0, var_1) {
  if(!isDefined(var_1))
    return 0;

  if(var_1 == "upgrade1")
    var_2 = "1";
  else if(var_1 == "upgrade2")
    var_2 = "2";
  else
    return 0;

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

  if(isDefined(var_3))
    level.player _id_0E42::_id_83B6(var_3);

  return 1;
}

_id_82FF() {
  var_0 = _id_D9F8();

  foreach(var_2 in var_0) {
    var_3 = level.player _meth_84C6("equipmentState", var_2);
    _id_82FE(var_2, var_3);
  }
}

_id_8315() {
  var_0 = _id_DA12();
  var_1 = [];
  var_2 = undefined;

  foreach(var_4 in var_0) {
    var_2 = level.player _meth_84C6("suitUpgradeState", var_4);

    if(isDefined(var_2) && var_2 == "unlocked") {
      var_5 = "specialty_" + var_4;
      var_1 = scripts\engine\utility::array_add(var_1, var_5);
    }
  }

  if(scripts\sp\utility::_id_93A6() && !scripts\engine\utility::array_contains(var_1, "specialty_extraequipment"))
    var_1 = scripts\engine\utility::array_add(var_1, "specialty_extraequipment");

  level.player _id_0E42::giveperks(var_1);
}

_id_DA19() {
  if(level.player _meth_84C6("suitUpgradeState", "slasher") != "locked")
    return 1;

  return level.player _meth_84C6("suitUpgradeState", "shocker") != "locked";
}

_id_D9FB() {
  var_0 = level.player _meth_84C6("selectedLoadout");
  var_1 = level.player _meth_84C6("loadouts", var_0, "jackalSetup", "jackalDecal");

  if(!isDefined(var_1) || var_1 == "none" || var_1 == "")
    var_1 = "veh_mil_air_un_jackal_livery_shell_01";

  return var_1;
}

_id_DA02() {
  var_0 = level.player _meth_84C6("selectedLoadout");
  var_1 = level.player _meth_84C6("loadouts", var_0, "jackalSetup", "jackalUpgrade");

  if(!isDefined(var_1))
    var_1 = "none";

  return var_1;
}

_id_D9FE() {
  var_0 = level.player _meth_84C6("selectedLoadout");
  var_1 = level.player _meth_84C6("loadouts", var_0, "jackalSetup", "jackalPrimary");

  if(!isDefined(var_1))
    var_1 = "primary_default";

  return var_1;
}

_id_DA00() {
  var_0 = level.player _meth_84C6("selectedLoadout");
  var_1 = level.player _meth_84C6("loadouts", var_0, "jackalSetup", "jackalSecondary");

  if(!isDefined(var_1))
    var_1 = "secondary_default";

  return var_1;
}

_id_DA46() {
  var_0 = scripts\engine\utility::array_combine(getspawnerarray(), getaiarray("allies", "axis"));
  var_1 = 0;

  if(var_0.size > 0)
    var_1 = 1;

  if(var_1) {
    level._id_D9E5["default_weapon_transients"] = [];
    var_2 = undefined;
    var_3 = _id_DA17("sdf", "un");

    foreach(var_5 in var_3) {
      var_2 = "weapon_" + var_5 + "_tr";
      level._id_D9E5["default_weapon_transients"] = scripts\engine\utility::array_add(level._id_D9E5["default_weapon_transients"], var_2);
      precacheitem(var_5);
      precachemodel(getweaponviewmodel(var_5));
    }
  }
}

_id_9789() {
  var_0 = _id_DA17();
  var_0 = scripts\engine\utility::array_add(var_0, "iw7_knife_perk");
  var_0 = scripts\engine\utility::array_add(var_0, "iw7_knife_upgrade1");
  var_0 = _id_D9E7(var_0);

  foreach(var_2 in var_0) {
    scripts\sp\utility::_id_1263F("weapon_" + var_2 + "_tr");
    precacheitem(var_2);
    precachemodel(getweaponviewmodel(var_2));
  }

  var_4 = _id_D9FC();

  foreach(var_6 in var_4) {
    precachemodel(var_6);
    var_7 = strtok(var_6, "_");
    var_8 = var_7.size - 1;
    var_9 = "livery_" + var_7[var_8 - 1] + "_" + var_7[var_8];
    scripts\sp\utility::_id_1263F(var_9 + "_" + "tr");
  }
}

_id_96FD() {
  scripts\engine\utility::flag_init("weapon_scanning_off");
  scripts\engine\utility::flag_init("flag_armory_weapons_loaded");

  if(isDefined(level._id_D9E5))
    return;
  else {
    level._id_D9E5 = [];
    level._id_D9E5["weaponstates"] = [];
    level._id_D9E5["fakedata"] = 0;
  }

  setdvarifuninitialized("E3", 0);
  setdvarifuninitialized("GI", 0);
  setdvarifuninitialized("E3WEAPONS", 0);
  setdvarifuninitialized("progression_on", "1");
  var_0 = scripts\engine\utility::array_combine(_id_7AF1(), _id_7AEB());
  _id_DA1D();
  _id_DA52();
  level._id_D9E5["unlocked_attachments"] = _id_DA1E();
  _id_DA3D();

  if(!isDefined(level.template_script) || isDefined(level.template_script) && !scripts\engine\utility::array_contains(var_0, level.template_script)) {
    _id_DA46();
    return;
  }

  _id_492B();
  var_1 = scripts\engine\utility::get_template_script_MAYBE();
  var_1 = _id_7BDE(var_1);
  _id_DA33(var_1);
  _id_DA3E(var_1);
  level._id_D9E5["equip_upgrades"] = _id_DA22(var_1);
  level._id_D9E5["suit_upgrades"] = _id_DA3B();
  level._id_D9E5["jackal_decals"] = _id_DA25();
  level._id_D9E5["mandatory_suit_upgrades"] = _id_DA2E(var_1);
  level._id_D9E5["mandatory_jackal_primaries"] = _id_DA2A(var_1);
  level._id_D9E5["mandatory_jackal_secondaries"] = _id_DA2B(var_1);
  level._id_D9E5["mandatory_jackal_upgrades"] = _id_DA2C(var_1);
  level._id_D9E5["mandatory_jackal_decals"] = _id_DA29(var_1);
  level._id_D9E5["ace_pilots"] = _id_DA1A(var_1);
  level._id_D9E5["mission_specific_weapons"] = _id_DA30(var_1);
  level._id_D9E5["mandatoryunlocks"] = _id_DA2F(var_1);
  level._id_D9E5["optionalunlocks"] = _id_DA32(var_1);
  level._id_D9E5["armoryweapons"] = [];
  level._id_D9E5["loaded_weapons"] = _id_DA27(var_1);
  level._id_D9E5["loaded_weapon_types"] = _id_DA3F();
  level._id_D9E5["loaded_equipment_types"] = _id_DA21();
  level._id_D9E5["primaryweapons"] = _id_DA34();
  level._id_D9E5["secondaryweapons"] = _id_DA39();
  level._id_D9E5["offhand"] = _id_DA31(var_1);
  level._id_D9E5["items"] = _id_DA24(var_1);
  level._id_D9E5["scanned_items"] = _id_DA0E();
  level._id_D9E5["wanted_cards"] = _id_DA3C();
  level._id_D9E5["achievementDoorPeek"] = _id_DA1B();

  if(_id_9CBB(level.template_script))
    scripts\sp\endmission::_id_12F24();

  if(scripts\engine\utility::array_contains(var_0, var_1) || getdvarint("force_weapon_scan") == 1) {
    if(var_1 != "e3_phstreets") {
      thread _id_EBB9();
      thread _id_13C35();
    }
  }
}

_id_13C43() {
  self endon("death");

  for(;;) {
    if(isDefined(self.disableautoreload) && self.disableautoreload > 0 && self _meth_843C()) {}

    wait 0.05;
  }
}

_id_DA33(var_0) {}

_id_DA3E(var_0) {
  var_1 = _id_DA17();
  var_2 = _id_7AF1("sub");
  var_3 = [];
  var_4 = 0;

  foreach(var_6 in var_2) {
    if(var_6 != var_0 && !var_4)
      continue;
    else if(!var_4)
      var_4 = 1;

    var_7 = strtok(tablelookup("sp/progression_unlocks.csv", 0, var_6, 2), ", ");
    var_3 = scripts\engine\utility::array_combine(var_3, var_7);
    var_8 = strtok(tablelookup("sp/progression_unlocks.csv", 0, var_6, 3), ", ");
    var_3 = scripts\engine\utility::array_combine(var_3, var_8);
  }

  foreach(var_11 in var_1) {
    var_12 = level.player _meth_84C6("weaponsScanned", var_11);

    if(isDefined(var_12) && var_12 != "") {
      level._id_D9E5["weaponstates"][var_11] = var_12;
      continue;
    }

    level._id_D9E5["weaponstates"][var_11] = "locked";
  }
}

_id_DA1D() {
  var_0 = ["phspace", "sa_moon", "titanjackal", "rogue", "marscrash", "sa_assassination", "sa_empambush", "sa_vips", "sa_wounded", "ja_asteroid", "ja_spacestation", "ja_titan", "ja_wreckage", "ja_mining"];
  var_1 = 0;

  foreach(var_3 in var_0) {
    var_4 = scripts\sp\endmission::_id_7F6B(var_3);

    if(scripts\sp\endmission::_id_7F69(var_4))
      var_1++;
  }

  level.player _meth_84C7("scrapCount", var_1);
  _id_DA4F();
}

_id_DA22(var_0) {
  var_1 = int(tablelookup("sp/progression_unlocks.csv", 0, var_0, 7));
  return var_1;
}

_id_DA28(var_0) {
  var_1 = [];
  var_1["terminals"] = [];
  var_1["discovered"] = [];

  if(var_0 != "all_weapons") {
    for(var_2 = 0; var_2 < 2; var_2++) {
      for(var_3 = 0; var_3 < 2; var_3++) {
        var_4 = var_2 * 2 + var_3;
        var_5 = level.player _meth_84C6("missionLootRooms", var_0, "terminal", var_4);
        var_1["terminals"] = scripts\engine\utility::array_add(var_1["terminals"], var_5);
      }

      var_6 = level.player _meth_84C6("missionLootRooms", var_0, "discovered", var_2);
      var_1["discovered"] = scripts\engine\utility::array_add(var_1["discovered"], var_6);
    }
  }

  return var_1;
}

_id_D9ED(var_0) {
  var_1 = scripts\engine\utility::get_template_script_MAYBE();
  var_1 = _id_7BDE(var_1);
  var_2 = level.player _meth_84C6("missionLootRooms", var_1, "discovered", var_0);
  return var_2;
}

_id_DA49(var_0, var_1) {
  var_2 = scripts\engine\utility::get_template_script_MAYBE();
  var_2 = _id_7BDE(var_2);
  level.player _meth_84C7("missionLootRooms", var_2, "discovered", var_0, var_1);
}

_id_DA44(var_0, var_1) {
  var_2 = scripts\engine\utility::get_template_script_MAYBE();
  var_2 = _id_7BDE(var_2);
  var_3 = var_0 * 2 + var_1;
  var_4 = level.player _meth_84C6("missionLootRooms", var_2, "terminal", var_3);
  return var_4;
}

_id_DA4D(var_0, var_1) {
  var_2 = scripts\engine\utility::get_template_script_MAYBE();
  var_2 = _id_7BDE(var_2);
  var_3 = var_0 * 2 + var_1;
  level.player _meth_84C7("missionLootRooms", var_2, "terminal", var_3, 1);
}

_id_DA3B() {
  var_0 = _id_DA12();
  return _id_D9F0("suitUpgradeState", var_0);
}

_id_DA25() {
  var_0 = _id_D9FC();
  return _id_D9F0("jackalDecals", var_0);
}

_id_DA2E(var_0) {
  var_1 = scripts\engine\utility::get_template_script_MAYBE();

  if(var_0 == "pearlharbor" && var_1 != "phspace")
    return [];

  if(var_0 == "titan" && var_1 != "titanjackal")
    return [];

  if(var_0 == "heist")
    return [];

  if(var_1 == "marscrash")
    var_0 = "heist";

  var_2 = strtok(tablelookup("sp/progression_unlocks.csv", 0, var_0, 8), ", ");
  var_2 = scripts\engine\utility::array_remove(var_2, "");
  return var_2;
}

_id_DA2A(var_0) {
  var_1 = strtok(tablelookup("sp/progression_unlocks.csv", 0, var_0, 9), ", ");
  var_1 = scripts\engine\utility::array_remove(var_1, "");
  return var_1;
}

_id_DA2B(var_0) {
  var_1 = strtok(tablelookup("sp/progression_unlocks.csv", 0, var_0, 10), ", ");
  var_1 = scripts\engine\utility::array_remove(var_1, "");
  return var_1;
}

_id_DA2C(var_0) {
  var_1 = strtok(tablelookup("sp/progression_unlocks.csv", 0, var_0, 11), ", ");
  var_1 = scripts\engine\utility::array_remove(var_1, "");
  return var_1;
}

_id_DA29(var_0) {
  var_1 = strtok(tablelookup("sp/progression_unlocks.csv", 0, var_0, 12), ", ");
  var_1 = scripts\engine\utility::array_remove(var_1, "");
  return var_1;
}

_id_DA1A(var_0) {
  var_1 = strtok(tablelookup("sp/progression_unlocks.csv", 0, var_0, 13), ", ");
  var_1 = scripts\engine\utility::array_remove(var_1, "");
  return var_1;
}

_id_DA30(var_0) {
  return strtok(tablelookup("sp/progression_unlocks.csv", 0, var_0, 14), ", ");
}

_id_DA2F(var_0) {
  var_1 = _id_7AF1("sub", "sa");
  var_2 = [];
  var_3 = [];
  var_4 = 0;

  foreach(var_6 in var_1) {
    if(var_6 != var_0 && !var_4)
      continue;
    else if(!var_4) {
      var_4 = 1;

      if(var_6 != "all_weapons") {
        var_7 = strtok(tablelookup("sp/progression_unlocks.csv", 0, var_6, 2), ", ");
        var_2 = scripts\engine\utility::array_combine(var_2, var_7);
        var_8 = strtok(tablelookup("sp/progression_unlocks.csv", 0, var_6, 3), ", ");
        var_2 = scripts\engine\utility::array_combine(var_2, var_8);
        continue;
      }
    }

    var_9 = strtok(tablelookup("sp/progression_unlocks.csv", 0, var_6, 2), ", ");
    var_3 = scripts\engine\utility::array_combine(var_3, var_9);
    var_10 = strtok(tablelookup("sp/progression_unlocks.csv", 0, var_6, 3), ", ");
    var_3 = scripts\engine\utility::array_combine(var_3, var_10);
  }

  foreach(var_13 in var_3) {
    var_14 = level.player _meth_84C6("weaponsScanned", var_13);

    if(!isDefined(var_14) || var_14 == "locked") {
      level.player _meth_84C7("weaponsScanned", var_13, "unlocked");
      level._id_D9E5["weaponstates"][var_13] = "unlocked";
    }
  }

  return var_2;
}

_id_DA32(var_0) {
  var_1 = strtok(tablelookup("sp/progression_unlocks.csv", 0, var_0, 4), ", ");
  var_1 = _id_D9E7(var_1);

  if(var_0 != "europa" && var_0 != "pearlharbor") {
    var_2 = level.player _meth_84C6("weaponsScanned", "iw7_steeldragon");

    if(isDefined(var_2) && var_2 == "locked")
      var_1 = scripts\engine\utility::array_add(var_1, "iw7_steeldragon");
  }

  foreach(var_4 in var_1) {
    var_5 = level.player _meth_84C6("weaponsScanned", var_4);

    if(isDefined(var_5) && var_5 == "unlocked") {
      var_1 = scripts\engine\utility::array_remove(var_1, var_4);
      continue;
    }

    if(isDefined(var_5) && var_5 == "scanned") {
      var_1 = scripts\engine\utility::array_remove(var_1, var_4);
      continue;
    }

    if(isDefined(level._id_D9E5["weaponstates"][var_4]) && level._id_D9E5["weaponstates"][var_4] != "locked")
      var_1 = scripts\engine\utility::array_remove(var_1, var_4);
  }

  return var_1;
}

_id_DA27(var_0) {
  if(isDefined(level.template_script))
    var_1 = level.template_script;
  else
    var_1 = var_0;

  if(scripts\engine\utility::string_starts_with(var_1, "shipcrib"))
    var_2 = 1;
  else
    var_2 = 0;

  if(scripts\engine\utility::string_starts_with(var_1, "ja_"))
    var_3 = 1;
  else
    var_3 = 0;

  return _id_DA18(var_0, var_2, 0, undefined, var_3);
}

_id_DA34() {
  var_0 = [];

  foreach(var_2 in level._id_D9E5["loaded_weapons"]) {
    if(_id_9B44(var_2)) {
      continue;
    }
    if(_id_DA42(var_2))
      var_0 = scripts\engine\utility::array_add(var_0, var_2);
  }

  return var_0;
}

_id_DA39() {
  var_0 = [];

  foreach(var_2 in level._id_D9E5["loaded_weapons"]) {
    if(_id_9B44(var_2)) {
      continue;
    }
    if(!_id_DA42(var_2))
      var_0 = scripts\engine\utility::array_add(var_0, var_2);
  }

  return var_0;
}

_id_DA31(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = [];

  if(!level._id_D9E5["fakedata"]) {
    foreach(var_5 in level._id_D9E5["loaded_equipment_types"]) {
      if(isDefined(level._id_D9E5["weaponstates"][var_5]) && level._id_D9E5["weaponstates"][var_5] == "unlocked")
        var_1 = scripts\engine\utility::array_add(var_1, var_5);
    }
  } else if(var_0 == "all_weapons") {
    var_3 = strtok(tablelookup("sp/progression_unlocks.csv", 0, var_0, 5), ", ");

    for(var_7 = 0; var_7 < var_3.size; var_7++) {
      if(var_3[var_7] != "")
        var_1 = scripts\engine\utility::array_add(var_1, var_3[var_7]);
    }
  } else {
    var_8 = _id_7AF1("sub");
    var_9 = 0;

    foreach(var_11 in var_8) {
      if(var_11 != var_0 && !var_9)
        continue;
      else if(!var_9)
        var_9 = 1;

      var_3 = strtok(tablelookup("sp/progression_unlocks.csv", 0, var_11, 5), ", ");

      for(var_7 = 0; var_7 < var_3.size; var_7++) {
        if(var_3[var_7] != "")
          var_1 = scripts\engine\utility::array_add(var_1, var_3[var_7]);
      }
    }
  }

  return var_1;
}

_id_DA24(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = [];

  if(!level._id_D9E5["fakedata"]) {
    foreach(var_5 in level._id_D9E5["loaded_equipment_types"]) {
      if(isDefined(level._id_D9E5["weaponstates"][var_5]) && level._id_D9E5["weaponstates"][var_5] == "unlocked")
        var_1 = scripts\engine\utility::array_add(var_1, var_5);
    }
  } else if(var_0 == "all_weapons") {
    var_3 = strtok(tablelookup("sp/progression_unlocks.csv", 0, var_0, 6), ", ");

    for(var_7 = 0; var_7 < var_3.size; var_7++) {
      if(var_3[var_7] != "")
        var_1 = scripts\engine\utility::array_add(var_1, var_3[var_7]);
    }
  } else {
    var_8 = _id_7AF1("sub");
    var_9 = 0;

    foreach(var_11 in var_8) {
      if(var_11 != var_0 && !var_9)
        continue;
      else if(!var_9)
        var_9 = 1;

      var_3 = strtok(tablelookup("sp/progression_unlocks.csv", 0, var_11, 6), ", ");

      for(var_7 = 0; var_7 < var_3.size; var_7++) {
        if(var_3[var_7] != "")
          var_1 = scripts\engine\utility::array_add(var_1, var_3[var_7]);
      }
    }
  }

  return var_1;
}

_id_DA3F() {
  if(!_id_3DDC("weapon")) {
    return;
  }
  var_0 = level._id_D9E5["loaded_weapons"];
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
    if(!_id_9B49(var_3)) {
      continue;
    }
    if(_id_DA41(var_3)) {
      continue;
    }
    if(scripts\engine\utility::array_contains(level._id_D9E5["mandatoryunlocks"], var_3) || scripts\engine\utility::array_contains(level._id_D9E5["optionalunlocks"], var_3) || scripts\engine\utility::array_contains(level._id_D9E5["mission_specific_weapons"], var_3) || scripts\engine\utility::array_contains(_id_D9F7(), var_3) && _id_9CBB(level.template_script) || isDefined(level._id_D9E5["weaponstates"][var_3]) && level._id_D9E5["weaponstates"][var_3] != "locked") {
      var_4 = spawnStruct();
      var_4.weapon_name = var_3;
      var_4._id_13C13 = _id_7D5F(var_3);
      var_5 = scripts\engine\utility::weaponclass(var_3);
      var_1[var_5] = scripts\engine\utility::array_add(var_1[var_5], var_4);
    }
  }

  return var_1;
}

_id_DA21() {
  if(!_id_3DDC("offhand")) {
    return;
  }
  var_0 = _id_D9F8();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!scripts\engine\utility::array_contains(level._id_D9E5["mandatoryunlocks"], var_3) || isDefined(level._id_D9E5["weaponstates"][var_3]) && level._id_D9E5["weaponstates"][var_3] == "unlocked")
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
  }

  return var_1;
}

_id_DA38() {
  var_0 = [];
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow("sp/scrap_unlocks.csv", var_1, 0);

    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    var_3 = tablelookupbyrow("sp/scrap_unlocks.csv", var_1, 2);

    if(!isDefined(var_0[var_3]))
      var_0[var_3] = [];

    var_4 = tablelookupbyrow("sp/scrap_unlocks.csv", var_1, 1);
    var_5 = tablelookupbyrow("sp/scrap_unlocks.csv", var_1, 3);
    var_0[var_3][var_4] = var_5;
    var_1++;
  }

  return var_0;
}

_id_DA1E() {
  var_0 = _id_D9F2(0);
  var_1 = _id_D9F1();

  foreach(var_3 in var_1) {
    var_4 = tablelookuprownum("sp/attachmenttable.csv", 4, var_3);
    var_5 = tablelookupbyrow("sp/attachmenttable.csv", var_4, 8);

    if(isDefined(var_5) && var_5 != "")
      precachemodel(var_5);
  }

  return _id_D9F0("attachmentsState", var_0);
}

_id_D9E6(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0[var_2]))
    var_0[var_2] = [];

  var_0[var_2][var_1] = var_3;
  return var_0;
}

_id_7AEC(var_0) {
  switch (var_0) {
    case "pearlharbor":
      return "phspace";
    case "mars":
      return "marsbase";
    default:
      return var_0;
  }
}

_id_7BDE(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  if(var_1)
    level._id_D9E5["submission"] = "submission";

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

      if(var_1)
        level._id_D9E5["submission"] = var_0;

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

      if(var_1)
        level._id_D9E5["submission"] = var_0;

      break;
    case "moon_port":
      var_0 = "moon_port";
      break;
    case "moonjackal":
      var_0 = "moon_port";

      if(var_1)
        level._id_D9E5["submission"] = var_0;

      break;
    case "titanjackal":
      var_0 = "titan";

      if(var_1)
        level._id_D9E5["submission"] = var_0;

      break;
    case "heistspace":
      var_0 = "heist";

      if(var_1)
        level._id_D9E5["submission"] = var_0;

      break;
    case "rogue_dropship":
      var_0 = "rogue";
      break;
    case "dk_test":
      var_0 = "sa_assassination";
      break;
    default:
      if(var_1)
        level._id_D9E5["submission"] = var_0;
  }

  if(getdvarint("progression_on") == 0 || scripts\engine\utility::array_contains(_id_7AEB(), var_0))
    var_0 = "all_weapons";

  return var_0;
}

_id_492B(var_0) {
  var_1 = level.player _meth_84C6("weaponsScanned", "iw7_g18");

  if(!isDefined(var_1) || var_1 != "unlocked" || isDefined(var_0)) {
    var_2 = ["iw7_g18", "iw7_m8", "iw7_m4", "iw7_fhr"];

    foreach(var_4 in var_2)
    level.player _meth_84C7("weaponsScanned", var_4, "unlocked");

    var_6 = ["seeker", "antigrav"];

    foreach(var_8 in var_6)
    level.player _meth_84C7("equipmentState", var_8, "unlocked");

    var_10 = ["reflex", "acog", "silencer"];

    foreach(var_12 in var_10)
    level.player _meth_84C7("attachmentsState", var_12, "unlocked");

    var_14 = "primary_default";
    level.player _meth_84C7("jackalPrimaryState", var_14, "unlocked");
    var_15 = "secondary_default";
    level.player _meth_84C7("jackalSecondaryState", var_15, "unlocked");
    var_16 = ["weapons", "hull"];

    foreach(var_18 in var_16)
    level.player _meth_84C7("jackalUpgradeState", var_18, "unlocked");

    var_20 = ["veh_mil_air_un_jackal_livery_shell_01"];

    foreach(var_22 in var_20)
    level.player _meth_84C7("jackalDecals", var_22, "unlocked");

    level.player _meth_84C8("loadouts", 0, "name", "MENU_SP_GRIFFS_RECOMMENDED");
    level.player _meth_84C8("loadouts", 1, "name", "MENU_SP_LOADOUT_1");
    level.player _meth_84C8("loadouts", 2, "name", "MENU_SP_LOADOUT_2");
    level.player _meth_84C8("loadouts", 3, "name", "MENU_SP_LOADOUT_3");
    scripts\sp\loadout::_id_F56D("loadout1", 0, 1);
    scripts\sp\loadout::_id_F56D("loadout2", 0, 2);
    scripts\sp\loadout::_id_F56D("loadout3", 0, 3);
    level.player _meth_84C7("missionStateData", "europa", "incomplete");
  }

  if(scripts\sp\utility::_id_93A6()) {
    var_24 = ["nanoshot", "helmet"];

    foreach(var_8 in var_24) {
      var_26 = level.player _meth_84C6("equipmentState", var_8);

      if(var_26 == "locked")
        level.player _meth_84C7("equipmentState", var_8, "scanned");
    }
  }
}

_id_DA57(var_0) {
  var_1 = level.player _meth_84C6("weaponsScanned", var_0);

  if(!isDefined(var_1))
    return 0;

  return level.player _meth_84C6("weaponsScanned", var_0) != "locked";
}

_id_DA55(var_0, var_1) {
  if(isDefined(level._id_D9E5["weaponstates"][var_0])) {
    if(!scripts\engine\utility::array_contains(var_1, var_0)) {
      if(_id_9B49(var_0)) {
        if(!scripts\engine\utility::array_contains(level._id_D9E5["optionalunlocks"], var_0)) {
          if(level._id_D9E5["weaponstates"][var_0] != "scanned") {
            if(level._id_D9E5["weaponstates"][var_0] != "unlocked")
              return 0;
          }
        }
      }
    }

    return 1;
  } else if(_id_9B49(var_0)) {
    if(!scripts\engine\utility::array_contains(_id_DA17(), var_0)) {} else
      return 1;
  }

  return 0;
}

_id_DA18(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 14;

  if(!isDefined(var_2))
    var_2 = 0;

  if(!var_2)
    var_6 = _id_7F7B(level.template_script);
  else if(isDefined(var_3))
    var_6 = var_3;
  else
    var_6 = [];

  if(!var_2) {
    if(var_6.size > 0) {
      var_7 = scripts\engine\utility::array_combine(level._id_D9E5["mission_specific_weapons"], var_6);

      foreach(var_9 in level._id_D9E5["weapon_pickups"]) {
        if(!isstring(var_9))
          var_9 = getsubstr(var_9.classname, 7);
      }
    }
  }

  var_11 = [];
  var_11["rifle"] = -1;
  var_11["smg"] = -1;
  var_11["spread"] = -1;
  var_11["sniper"] = -1;
  var_11["mg"] = -1;
  var_11["pistol"] = -1;
  var_11["rocketlauncher"] = -1;
  var_12 = [];
  var_13 = [];
  var_14 = undefined;
  var_15 = [];

  if(!var_1) {
    if(!var_2) {
      var_16 = level.player _meth_84C6("lastWeaponPreload");

      if(isDefined(var_16) && var_16 == level.template_script) {
        var_17 = _id_DA17();

        foreach(var_9 in var_17) {
          var_19 = level.player _meth_84C6("weaponsLoaded", var_9);

          if(isDefined(var_19) && var_19)
            var_15 = scripts\engine\utility::array_add(var_15, var_9);
        }
      }

      level.player _meth_84C7("lastWeaponPreload", "nodata");
    }

    if(var_15.size == 0) {
      if(!var_2)
        var_14 = level._id_D9E5["mission_specific_weapons"];
      else
        var_14 = _id_DA30(var_0);

      if(!var_2)
        var_13 = level._id_D9E5["mandatoryunlocks"];
      else
        var_13 = _id_DA2F(var_0);
    }
  }

  if(var_15.size == 0) {
    if(!isDefined(var_14))
      var_14 = [];

    foreach(var_9 in var_6) {
      if(!isstring(var_9)) {
        var_22 = getsubstr(var_9.classname, 7);
        var_22 = getweaponbasename(var_22);
      } else
        var_22 = var_9;

      if(!_id_DA55(var_22, var_13)) {
        if(!_id_9B49(var_22))
          continue;
      }

      var_14 = scripts\engine\utility::array_add(var_14, var_22);
    }

    if(!var_1) {
      var_24 = level.player getweaponslist("primary");
      var_25 = [];

      foreach(var_9 in var_24) {
        var_27 = getweaponbasename(var_9);

        if(scripts\engine\utility::array_contains(_id_DA17(), var_27))
          var_25 = scripts\engine\utility::array_add(var_25, var_27);
      }

      var_25 = scripts\engine\utility::array_remove_duplicates(var_25);
      var_25 = scripts\engine\utility::array_removeundefined(var_25);

      foreach(var_9 in var_25) {
        if(!scripts\engine\utility::array_contains(var_14, var_9)) {
          if(scripts\engine\utility::array_contains(_id_DA17(), var_9))
            var_14 = scripts\engine\utility::array_add(var_14, var_9);
        }
      }

      if(!isDefined(var_4) || isDefined(var_4) && !var_4) {
        var_14 = scripts\sp\utility::_id_22A2(var_14, var_13);
        var_31 = strtok(tablelookup("sp/progression_unlocks.csv", 0, var_0, 5), ", ");
        level._id_D9E5["mandatoryunlocks"] = scripts\engine\utility::array_combine(level._id_D9E5["mandatoryunlocks"], var_31);

        foreach(var_9, var_33 in level._id_D9E5["weaponstates"]) {
          if(_id_9B49(var_9)) {
            if(!scripts\engine\utility::array_contains(var_14, var_9)) {
              if(var_33 == "unlocked" && var_9 != "none")
                var_12 = scripts\engine\utility::array_add(var_12, var_9);
            }
          }
        }

        var_14 = scripts\engine\utility::array_remove_duplicates(var_14);
        var_14 = _id_D9E7(var_14);
        var_12 = scripts\engine\utility::array_remove_array(var_12, var_14);

        if(!var_2)
          var_34 = level._id_D9E5["optionalunlocks"];
        else
          var_34 = _id_DA32(var_0);

        var_34 = scripts\engine\utility::array_remove_array(var_34, var_14);
        var_12 = scripts\engine\utility::array_combine_unique(var_12, var_34);

        foreach(var_9 in var_14) {
          var_36 = scripts\engine\utility::weaponclass(var_9);

          if(!isDefined(var_11[var_36])) {
            if(var_36 == "beam") {
              continue;
            }
            var_14 = scripts\engine\utility::array_remove(var_14, var_9);
            continue;
          }

          if(var_11[var_36] > 0) {
            var_11[var_36]++;
            continue;
          }

          var_11[var_36] = 0;
        }

        var_12 = scripts\engine\utility::array_randomize(var_12);

        for(var_38 = 1; var_14.size < var_5 && var_12.size > 0 && var_38 < 3; var_38++) {
          foreach(var_9 in var_12) {
            var_36 = scripts\engine\utility::weaponclass(var_9);

            if(_id_DA40(var_9)) {
              continue;
            }
            if(_id_DA41(var_9)) {
              continue;
            }
            if(_id_DA43(var_9)) {
              continue;
            }
            if(level.template_script == "europa" && var_9 == "iw7_fmg") {
              continue;
            }
            if(var_11[var_36] >= 0 && _id_13C4A(var_11)) {
              continue;
            }
            if(var_11[var_36] <= var_38) {
              var_14 = scripts\engine\utility::array_add(var_14, var_9);
              var_12 = scripts\engine\utility::array_remove(var_12, var_9);
              var_11[var_36]++;
            }

            if(var_14.size == var_5) {
              break;
            }
          }
        }

        if(var_14.size < var_5) {
          foreach(var_9 in var_12) {
            if(_id_DA40(var_9)) {
              continue;
            }
            if(_id_DA41(var_9)) {
              continue;
            }
            if(_id_DA43(var_9)) {
              continue;
            }
            if(level.template_script == "europa" && var_9 == "iw7_fmg") {
              continue;
            }
            if(var_14.size < var_5) {
              var_14 = scripts\engine\utility::array_add(var_14, var_9);
              continue;
            }

            if(var_14.size == var_5) {
              break;
            }
          }
        }
      }
    } else {
      var_46 = _id_D9F7();
      var_14 = scripts\sp\utility::_id_22A2(var_14, var_46);
      var_14 = scripts\engine\utility::array_remove_duplicates(var_14);
    }
  } else
    var_14 = var_15;

  if(!var_2) {
    var_47 = "weaponsScanned";

    foreach(var_9 in var_14) {
      if(!_id_9B49(var_9)) {
        continue;
      }
      precacheitem(var_9);
      precachemodel(getweaponviewmodel(var_9));
      var_49 = level.player _meth_84C6(var_47, var_9);

      if(isDefined(var_49)) {
        level._id_D9E5["weaponstates"][var_9] = var_49;
        continue;
      }

      level._id_D9E5["weaponstates"][var_9] = "unlocked";
    }

    var_47 = "equipmentState";
    var_51 = _id_D9F8();

    foreach(var_53 in var_51) {
      precacheitem(var_53);
      var_54 = level.player _meth_84C6(var_47, var_53);

      if(isDefined(var_54)) {
        level._id_D9E5["weaponstates"][var_53] = var_54;
        continue;
      }

      level._id_D9E5["weaponstates"][var_53] = "unlocked";
    }
  }

  var_56 = _id_D9FB();

  if(!var_2)
    precachemodel(var_56);

  var_57 = strtok(var_56, "_");
  var_58 = var_57.size - 1;
  var_59 = "livery_" + var_57[var_58 - 1] + "_" + var_57[var_58];
  var_14 = scripts\engine\utility::array_add(var_14, var_59);
  return var_14;
}

_id_13C4A(var_0) {
  foreach(var_3, var_2 in var_0) {
    if(var_3 == "beam") {
      continue;
    }
    if(var_3 == "rocketlauncher") {
      continue;
    }
    if(var_2 == -1)
      return 1;
  }

  return 0;
}

_id_DA14(var_0, var_1) {}

_id_7F7B(var_0) {
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
  }

  return var_1;
}

_id_DA4C(var_0) {
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  return var_0;
}

_id_12642() {
  scripts\sp\utility::_id_13705();
  var_0 = ["vr_firing_range"];
  var_1 = 0;

  if(isDefined(level.template_script)) {
    var_2 = level.template_script;

    if(scripts\engine\utility::array_contains(var_0, var_2))
      var_1 = 1;
  }

  var_3 = [];
  var_4 = _id_DA17();

  foreach(var_6 in var_4) {
    if(!_id_9B49(var_6)) {
      continue;
    }
    level.player _meth_84C7("weaponsLoaded", var_6, 0);
  }

  if(level._id_D9E5["loaded_weapons"].size > 0)
    var_4 = scripts\engine\utility::array_remove_array(var_4, level._id_D9E5["loaded_weapons"]);

  foreach(var_6 in var_4) {
    if(scripts\engine\utility::array_contains(_id_DA17(), var_6)) {
      var_9 = "weapon_" + var_6 + "_tr";

      if(!istransientloaded(var_9)) {
        var_3 = scripts\engine\utility::array_add(var_3, var_6);
        loadtransient(var_9);
      }

      if(var_1)
        level.player _meth_84C7("weaponsScanned", var_6, "unlocked");
    }
  }

  var_3 = scripts\engine\utility::array_remove_duplicates(var_3);

  for(;;) {
    var_11 = 1;

    foreach(var_6 in var_3) {
      var_13 = "weapon_" + var_6 + "_tr";

      if(!istransientloaded(var_13)) {
        var_11 = 0;
        break;
      } else {
        var_14 = spawnStruct();
        var_15 = _id_7D5F(var_6);
        var_14._id_13C13 = var_15;
        var_14.weapon_name = var_6;
        var_16 = scripts\engine\utility::weaponclass(var_6);

        if(!scripts\engine\utility::array_contains(level._id_D9E5["loaded_weapons"], var_6)) {
          level._id_D9E5["loaded_weapons"] = scripts\engine\utility::array_add(level._id_D9E5["loaded_weapons"], var_6);
          level._id_D9E5["loaded_weapon_types"][var_16] = scripts\engine\utility::array_add(level._id_D9E5["loaded_weapon_types"][var_16], var_14);
          level.player _meth_84C7("weaponsLoaded", var_6, 1);
        }
      }
    }

    if(var_11) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  level scripts\engine\utility::flag_set("flag_armory_weapons_loaded");
}

_id_12644() {
  var_0 = _id_D9FB();
  var_1 = strtok(var_0, "_");
  var_2 = var_1[5] + "_" + var_1[6] + "_" + var_1[7] + "_tr";

  if(!istransientloaded(var_2))
    loadtransient(var_2);
}

_id_1264F() {
  level notify("armory_weapons_unload");
}

_id_12650() {
  level waittill("armory_weapons_unload");
  var_0 = level._id_D9E5["loaded_weapons"];
  var_1 = undefined;
  var_2 = undefined;
  var_3 = [];
  var_4 = [];
  var_5 = ["iw7_g18", "iw7_m4", "iw7_ripper"];
  var_6 = level.player getweaponslist("primary");
  var_7 = [];

  foreach(var_9 in var_6) {
    var_10 = getweaponbasename(var_9);

    if(scripts\engine\utility::array_contains(_id_DA17(), var_10))
      var_7 = scripts\engine\utility::array_add(var_7, var_10);
  }

  var_7 = scripts\engine\utility::array_remove_duplicates(var_7);
  var_12 = scripts\engine\utility::array_removeundefined(var_7);

  foreach(var_15, var_14 in level._id_B8D2._id_ABFA) {
    if(var_14.name == level.template_script) {
      var_2 = var_15;
      break;
    }
  }

  var_16 = var_2 + 1;
  var_17 = level._id_B8D2._id_ABFA[var_16].name;
  var_18 = _id_DA30(var_17);
  var_19 = _id_7F7B(var_17);
  var_20 = _id_DA2F(var_17);
  var_12 = scripts\engine\utility::array_combine_unique(var_12, var_18);
  var_12 = scripts\engine\utility::array_combine_unique(var_12, var_19);
  var_12 = scripts\engine\utility::array_combine_unique(var_12, var_20);
  var_12 = scripts\engine\utility::array_combine_unique(var_12, var_5);
  var_0 = scripts\engine\utility::array_remove_array(var_0, var_12);

  foreach(var_9 in var_0) {
    if(!_id_9B49(var_9)) {
      continue;
    }
    if(level._id_D9E5["loaded_weapons"].size > 18) {
      var_22 = getweaponbasename(var_9);
      var_23 = "weapon_" + var_9 + "_tr";
      scripts\sp\utility::_id_1264E(var_23);
      level._id_D9E5["loaded_weapons"] = scripts\engine\utility::array_remove(level._id_D9E5["loaded_weapons"], var_22);
      level.player _meth_84C7("weaponsLoaded", var_22, 0);
      continue;
    }

    break;
  }

  _id_DA54();
  _id_DA53();
  level notify("armory_weapons_unloaded");
}

_id_12646(var_0) {
  var_0 = getweaponbasename(var_0);
  var_1 = "weapon_" + var_0 + "_tr";

  if(istransientloaded(var_1)) {
    return;
  }
  scripts\sp\utility::_id_12641(var_1);

  if(isDefined(level._id_D9E5))
    level._id_D9E5["loaded_weapons"] = scripts\engine\utility::array_add(level._id_D9E5["loaded_weapons"], var_0);
  else
    return;

  var_2 = spawnStruct();
  var_3 = _id_7D5F(var_0);
  var_2._id_13C13 = var_3;
  var_2.weapon_name = var_0;
  var_4 = scripts\engine\utility::weaponclass(var_0);
  level._id_D9E5["loaded_weapon_types"][var_4] = scripts\engine\utility::array_add(level._id_D9E5["loaded_weapon_types"][var_4], var_2);
}

_id_12652(var_0) {
  var_1 = strtok(var_0, "+");

  if(var_1.size > 1)
    var_2 = "weapon_" + var_1[0] + "_tr";
  else
    var_2 = "weapon_" + var_0 + "_tr";

  scripts\sp\utility::_id_1264E(var_2);
}

_id_DA0C() {
  var_0 = level.player _meth_84C6("selectedLoadout");
  var_1 = level.player _meth_84C6("loadouts", var_0, "weaponSetups", 0, "weapon");
  var_2 = level.player _meth_84C6("loadouts", var_0, "weaponSetups", 1, "weapon");
  var_3 = [var_1, var_2];
  var_3 = scripts\engine\utility::array_remove_duplicates(var_3);

  foreach(var_5 in var_3) {
    if(!isDefined(var_5) || var_5 == "")
      var_3 = scripts\engine\utility::array_remove(var_3, var_5);
  }

  return var_3;
}

_id_DA54() {
  foreach(var_2, var_1 in level._id_D9E5["weaponstates"]) {
    if(_id_9B49(var_2))
      level._id_D9E5["weaponstates"][var_2] = level.player _meth_84C6("weaponsScanned", var_2);
  }
}

_id_DA53() {
  foreach(var_2, var_1 in level._id_D9E5["weaponstates"]) {
    if(!_id_9B49(var_2))
      level._id_D9E5["weaponstates"][var_2] = level.player _meth_84C6("equipmentState", var_2);
  }
}

_id_DA52(var_0) {
  var_1 = [];
  var_2 = 0;

  if(isDefined(level._id_D9E5) && isDefined(level._id_D9E5["attachments"]))
    var_3 = level._id_D9E5["attachments"].size;
  else
    var_3 = 0;

  var_4 = 1;

  for(;;) {
    var_5 = tablelookupbyrow("sp/attachmenttable.csv", var_4, 4);
    var_6 = tablelookupbyrow("sp/attachmenttable.csv", var_4, 5);

    if(var_5 != "" && var_6 != "") {
      var_7 = strtok(tablelookupbyrow("sp/attachmenttable.csv", var_4, 12), ",");

      foreach(var_9 in var_7) {
        var_10 = strtok(tablelookupbyrow("sp/attachmenttable.csv", var_4, 13), ",");

        if(var_10.size == 0)
          var_10[0] = "";

        foreach(var_12 in var_10) {
          var_13 = spawnStruct();
          var_13.location = tablelookupbyrow("sp/attachmenttable.csv", var_4, 2);
          var_13.name = tablelookupbyrow("sp/attachmenttable.csv", var_4, 3);
          var_13._id_24A2 = var_5;
          var_13._id_9338 = tablelookupbyrow("sp/attachmenttable.csv", var_4, 6);
          var_13._id_9337 = tablelookupbyrow("sp/attachmenttable.csv", var_4, 20);
          var_13.type = var_6;
          var_13._id_9ECE = int(tablelookupbyrow("sp/attachmenttable.csv", var_4, 9));
          var_13._id_657B = int(tablelookupbyrow("sp/attachmenttable.csv", var_4, 10));
          var_13.baseangles = tablelookupbyrow("sp/attachmenttable.csv", var_4, 5);
          var_13._id_13CDE = var_9;
          var_13._id_13CCE = var_12;
          var_1[var_9][var_13.type][var_12][var_13._id_657B] = var_13;

          if(isDefined(var_0) && !var_0) {
            level.player _meth_84C7("attachmentsState", var_13.type, "locked");
            continue;
          }

          if(isDefined(var_0) && var_0)
            level.player _meth_84C7("attachmentsState", var_13.type, "unlocked");
        }
      }
    } else
      break;

    var_4++;
  }

  if(!isDefined(level._id_D9E5))
    return var_1;
  else
    level._id_D9E5["attachments"] = var_1;
}

_id_DA3D() {
  var_0 = scripts\sp\utility::_id_7DB7();
  level._id_D9E5["weapon_pickups"] = [];

  foreach(var_2 in var_0) {
    var_3 = getsubstr(var_2.classname, 7);
    var_4 = weaponinventorytype(var_3);

    if(var_4 != "primary") {
      level._id_D9E5["weapon_pickups"] = scripts\engine\utility::array_add(level._id_D9E5["weapon_pickups"], var_2);
      continue;
    }

    var_5 = getweaponbasename(var_3);
    var_6 = getweaponattachments(var_3);

    if(var_6.size > 0) {
      level._id_D9E5["weapon_pickups"] = scripts\engine\utility::array_add(level._id_D9E5["weapon_pickups"], var_2);
      continue;
    }

    var_6 = build_attach_models(var_5, "random");

    if(var_5 == "iw7_gambit")
      var_6 = build_attach_models(var_5, "random", undefined, 0, 0, 20);

    if(isDefined(var_6) && var_6.size > 0) {
      var_12 = spawn("weapon_" + var_5 + "+" + var_6, var_2.origin, var_2.spawnflags);
      var_12.angles = var_2.angles;
      var_12.targetname = var_2.targetname;
      var_12.target = var_2.target;
      level._id_D9E5["weapon_pickups"] = scripts\engine\utility::array_add(level._id_D9E5["weapon_pickups"], var_12);
      var_2 delete();
    }
  }
}

_id_13BFC(var_0) {
  return _id_13C05(var_0, 1);
}

_id_13C44(var_0) {
  return _id_13C05(var_0, 0);
}

_id_13C05(var_0, var_1) {
  var_2 = [];
  var_2["weapon"] = var_0;
  var_2["weapon_changed"] = 0;

  if(isDefined(level._id_D9E5)) {
    var_3 = level._id_D9E5["attachments"];
    var_4 = getweaponbasename(var_0);
    var_5 = getsubstr(var_4, 4);
    var_6 = undefined;

    if(isDefined(var_3["zerog"]["zerog"][var_5]))
      var_6 = var_3["zerog"]["zerog"][var_5][0]._id_24A2;

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

        foreach(var_10 in var_7)
        var_8 = var_8 + ("+" + var_10);

        var_2["weapon"] = var_4 + var_8;
      }
    }
  }

  return var_2;
}

_id_13E80(var_0, var_1) {
  var_2 = level.player getcurrentprimaryweapon();
  var_3 = level.player _meth_8519(var_2, 1);
  var_4 = getweaponbasename(var_2);
  var_5 = undefined;
  var_6 = undefined;
  var_7 = 0;
  var_8 = 0;
  var_9 = level.player getweaponslistall();

  foreach(var_11 in var_9) {
    var_12 = weaponinventorytype(var_11);

    if(var_12 != "primary") {
      continue;
    }
    var_13 = _id_13C05(var_11, var_0);

    if(var_13["weapon_changed"]) {
      var_13 = var_13["weapon"];
      var_7 = level.player getweaponammostock(var_11);
      var_8 = level.player getweaponammoclip(var_11);
      level.player giveweapon(var_13);
      level.player setweaponammostock(var_13, var_7);
      level.player setweaponammoclip(var_13, var_8);
      var_14 = getweaponbasename(var_11);

      if(isDefined(var_4) && isDefined(var_14) && var_4 == var_14) {
        var_6 = var_11;
        var_5 = var_13;
      } else
        level.player takeweapon(var_11);
    }
  }

  if(isDefined(var_5)) {
    level.player scripts\sp\utility::_id_1C72(0);

    if(var_3)
      var_5 = "alt_" + var_5;

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

    level.player scripts\sp\utility::_id_1C72(1);
  }
}

_id_B149(var_0) {
  switch (var_0) {
    case "iw7_erad":
      return (0, 0, 0);
    case "iw7_m4":
      return (15, 25, -10);
  }

  return (0, 0, 0);
}

_id_B148(var_0) {
  switch (var_0) {
    case "iw7_erad":
      return (0, 0, 0);
    case "iw7_m4":
      return (10, 200, -10);
  }

  return (0, 0, 0);
}

_id_4EB7() {
  self endon("death");

  for(;;)
    scripts\engine\utility::waitframe();
}

_id_13E76() {
  level endon("stop_zero_g_magazine_throw");

  for(;;) {
    level.player waittill("reload_start");
    var_0 = level.player getcurrentweapon();
    var_1 = getweaponbasename(var_0);

    if(level.player isreloading()) {
      wait 1.9;
      var_2 = getweaponclipmodel(var_1);

      if(var_2 != "") {
        var_2 = var_2 + "_zerog";
        var_3 = level.player getplayerangles();
        var_4 = _id_B149(var_1);
        var_5 = level.player getEye() + rotatevector(var_4, var_3);
        var_6 = spawn("script_model", var_5);
        var_6 setModel(var_2);
        var_6 thread _id_4EB7();
        var_7 = _id_B148(var_1);
        var_8 = rotatevector(var_7, var_3);
        var_6 _meth_841C(1, var_5 + (0, 0, randomfloatrange(-1, -0.5)), var_8);
        var_6 scripts\engine\utility::delaythread(60, scripts\sp\utility::_id_F1DE);
      }
    }

    while(level.player isreloading())
      wait 0.05;
  }
}

_id_D9E7(var_0) {
  var_1 = ["launcher_05"];

  foreach(var_3 in var_0) {
    if(scripts\engine\utility::array_contains(var_1, var_3))
      var_0 = scripts\engine\utility::array_remove(var_0, var_3);
  }

  if(isDefined(level._id_E052))
    var_0 = scripts\engine\utility::array_remove_array(var_0, level._id_E052);

  return var_0;
}

_id_13C35() {
  level.player endon("death");
  level endon("weapon_outline_disable");
  scripts\sp\utility::_id_9189("new_weapon", 1, "default");

  if(level.template_script == "europa") {
    return;
  }
  level scripts\engine\utility::waittill_notify_or_timeout("starting_weapons_scanned", 2);

  foreach(var_1 in level._id_D9E5["mandatoryunlocks"]) {
    if(_id_9B49(var_1)) {
      var_2 = level.player _meth_84C6("weaponsScanned", var_1);

      if(isDefined(var_2) && var_2 != "locked")
        level._id_D9E5["mandatoryunlocks"] = scripts\engine\utility::array_remove(level._id_D9E5["mandatoryunlocks"], var_1);
    }
  }

  var_4 = level._id_D9E5["weapon_pickups"];
  var_5 = level._id_D9E5["optionalunlocks"];
  thread _id_13C34(var_4);

  foreach(var_1 in var_4) {
    if(isDefined(var_1)) {
      var_7 = getsubstr(var_1.classname, 7);
      var_7 = getweaponbasename(var_7);

      if(scripts\engine\utility::array_contains(var_5, var_7))
        var_1 scripts\sp\utility::_id_9196(4, 1, 0, "new_weapon");
    }
  }

  var_9 = [];
  var_10 = [];
  var_11 = [];

  for(var_12 = []; var_5.size > 0; var_5 = scripts\engine\utility::array_combine(level._id_D9E5["mandatoryunlocks"], level._id_D9E5["optionalunlocks"])) {
    var_9 = getweaponarray();

    if(!scripts\sp\utility::array_compare(var_10, var_9)) {
      var_11 = scripts\engine\utility::array_remove_array(var_9, var_10);

      foreach(var_1 in var_11) {
        var_7 = getsubstr(var_1.classname, 7);
        var_7 = getweaponbasename(var_7);

        if(scripts\engine\utility::array_contains(var_5, var_7))
          var_1 scripts\sp\utility::_id_9196(4, 1, 0, "new_weapon");
      }

      var_11 = [];
    }

    wait 0.5;
    var_10 = var_9;
  }
}

_id_13C34(var_0) {
  level.player endon("death");
  level endon("weapon_outline_disable");

  for(;;) {
    level waittill("weapon_scan_complete", var_1);
    var_2 = getweaponarray();
    var_0 = scripts\engine\utility::array_combine(var_2, var_0);
    var_0 = scripts\engine\utility::array_combine(var_0, level._id_D9E5["armoryweapons"]);
    var_3 = level._id_D9E5["optionalunlocks"];

    foreach(var_5 in var_0) {
      if(isDefined(var_5)) {
        var_6 = getsubstr(var_5.classname, 7);
        var_6 = getweaponbasename(var_6);

        if(var_1 == var_6)
          var_5 scripts\sp\utility::_id_9193("new_weapon");
      }
    }
  }
}

_id_13C33() {
  level notify("weapon_outline_disable");
  var_0 = scripts\sp\utility::_id_7DB7();

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_3 = getsubstr(var_2.classname, 7);
      var_3 = getweaponbasename(var_3);

      if(_id_9B49(var_3))
        var_2 scripts\sp\utility::_id_9193();
    }
  }
}

_id_EBB9() {
  level.player endon("death");
  level endon("stop_scan_weapon_update");
  setdvarifuninitialized("force_weapon_scan", 0);

  if(level.template_script == "europa") {
    return;
  }
  var_0 = level._id_D9E5["attachments"];
  level.player scripts\engine\utility::waittill_notify_or_timeout("weapon_change", 2);
  var_1 = level.player getweaponslist("primary");
  var_2 = getweaponbasename(level.player getcurrentprimaryweapon());
  var_3 = undefined;

  foreach(var_5 in var_1) {
    if(level.player scripts\sp\utility::_id_65DF("zero_gravity") && level.player scripts\sp\utility::_id_65DB("zero_gravity")) {
      var_6 = _id_13BFC(var_5);

      if(var_6["weapon_changed"]) {
        var_7 = level.player getweaponammostock(var_5);
        var_8 = level.player getweaponammoclip(var_5);
        level.player takeweapon(var_5);
        var_5 = var_6["weapon"];
        level.player giveweapon(var_5);
        level.player setweaponammostock(var_5, var_7);
        level.player setweaponammoclip(var_5, var_8);
        var_9 = getweaponbasename(var_5);

        if(var_2 == var_9)
          var_3 = var_5;
      }
    }

    var_5 = getweaponbasename(var_5);

    if(!scripts\engine\utility::array_contains(_id_DA17(), var_5) || issubstr(var_5, "snow")) {
      continue;
    }
    level._id_D9E5["weaponstates"][var_5] = "unlocked";
    level._id_D9E5["optionalunlocks"] = scripts\engine\utility::array_remove(level._id_D9E5["optionalunlocks"], var_5);
    level._id_D9E5["mandatoryunlocks"] = scripts\engine\utility::array_remove(level._id_D9E5["mandatoryunlocks"], var_5);
    var_10 = level.player _meth_84C6("weaponsScanned", var_5);

    if(!isDefined(var_10) || var_10 == "locked")
      level.player _meth_84C7("weaponsScanned", var_5, "unlocked");
  }

  if(isDefined(var_3))
    level.player switchtoweapon(var_3);

  level notify("starting_weapons_scanned");
  childthread watch_weapon_taken_thread();

  for(;;) {
    level.player waittill("weapon_change", var_12);
    var_9 = getweaponbasename(var_12);
    var_13 = undefined;
    var_14 = undefined;
    var_15 = 0;

    if(!isDefined(var_9) || !scripts\engine\utility::array_contains(_id_DA17(), var_9))
      var_15 = 1;

    if(!var_15 && !scripts\engine\utility::flag("weapon_scanning_off")) {
      var_16 = _id_13C46();

      if(level.player scripts\sp\utility::_id_65DF("zero_gravity") && level.player scripts\sp\utility::_id_65DB("zero_gravity")) {
        var_6 = _id_13BFC(var_12);

        if(var_6["weapon_changed"]) {
          var_13 = level.player getweaponammostock(var_12);
          var_14 = level.player getweaponammoclip(var_12);
          level.player takeweapon(var_12);
          var_12 = var_6["weapon"];
          level.player giveweapon(var_12);
          level.player switchtoweapon(var_12);
        }
      } else {
        var_6 = _id_13C44(var_12);

        if(var_6["weapon_changed"]) {
          var_13 = level.player getweaponammostock(var_12);
          var_14 = level.player getweaponammoclip(var_12);
          level.player takeweapon(var_12);
          var_12 = var_6["weapon"];
          level.player giveweapon(var_12);
          level.player switchtoweapon(var_12);
        }
      }

      if(_id_9D1A(var_9) || getdvarint("force_weapon_scan") == 1) {
        thread _id_EBB6(var_9);

        if(!var_16) {
          var_17 = scripts\engine\utility::weaponclass(var_9);

          switch (var_17) {
            case "pistol":
              var_18 = "ges_scan_light";
              break;
            case "sniper":
            case "rocketlauncher":
            case "mg":
              var_18 = "ges_scan_heavy";
              break;
            case "beam":
              var_18 = "ges_scan_steeldragon";
              break;
            default:
              var_18 = "ges_scan";
          }

          level.player thread scripts\sp\utility::_id_D090(var_18);
        }

        level thread _id_F618(var_9);

        if(getdvarint("force_weapon_scan") == 1)
          continue;
      }

      if(isDefined(var_13))
        level.player setweaponammostock(var_12, var_13);

      if(isDefined(var_14))
        level.player setweaponammoclip(var_12, var_14);
    }
  }
}

watch_weapon_taken_thread() {
  for(;;) {
    level.player waittill("weapon_taken");
    wait 0.2;
    _id_3DDF(1);
  }
}

_id_EBB5() {
  level.player playSound("weap_pickup_scan_plr");
  var_0 = level.player getcurrentweapon();
  var_1 = getweaponbasename(var_0);

  if(var_1 == "iw7_erad" || var_1 == "iw7_fhr" || var_1 == "iw7_counterweight" || var_1 == "iw7_sonic" || var_1 == "iw7_penetrationrail" || var_1 == "iw7_lockon" || var_1 == "iw7_sdfar" || var_1 == "iw7_gambit" || var_1 == "iw7_sdfshotty" || var_1 == "iw7_glr" || var_1 == "iw7_claw") {
    if(_id_13C46())
      self setscriptablepartstate("weaponscan", "weaponscan_lg_on_combat");
    else
      self setscriptablepartstate("weaponscan", "weaponscan_lg_on");
  } else if(var_1 == "iw7_kbs" || var_1 == "iw7_stasis" || var_1 == "iw7_m8" || var_1 == "iw7_cheytac" || var_1 == "iw7_lmg03" || var_1 == "iw7_sdflmg" || var_1 == "iw7_repeater" || var_1 == "iw7_m1") {
    if(_id_13C46())
      self setscriptablepartstate("weaponscan", "weaponscan_long_on_combat");
    else
      self setscriptablepartstate("weaponscan", "weaponscan_long_on");
  } else if(var_1 == "iw7_g18" || var_1 == "iw7_emc" || var_1 == "iw7_revolver" || var_1 == "iw7_nrg") {
    if(_id_13C46())
      self setscriptablepartstate("weaponscan", "weaponscan_short_on_combat");
    else
      self setscriptablepartstate("weaponscan", "weaponscan_short_on");
  } else if(var_1 == "iw7_steeldragon" || var_1 == "iw7_chargeshot" || var_1 == "iw7_mauler") {
    if(_id_13C46())
      self setscriptablepartstate("weaponscan", "weaponscan_heavy_on_combat");
    else if(var_1 == "iw7_chargeshot")
      self setscriptablepartstate("weaponscan", "weaponscan_lg_on");
    else
      self setscriptablepartstate("weaponscan", "weaponscan_heavy_on");
  } else if(_id_13C46())
    self setscriptablepartstate("weaponscan", "weaponscan_on_combat");
  else
    self setscriptablepartstate("weaponscan", "weaponscan_on");

  wait 4.35;
  self setscriptablepartstate("weaponscan", "weaponscan_off");
  scripts\sp\utility::_id_9193();
}

_id_EBB6(var_0) {
  level.player thread _id_EBB5();
  wait 0.5;
  var_1 = strtok(var_0, "_");
  var_2 = undefined;

  if(isDefined(var_1[1]))
    var_2 = "weapon_" + var_1[1];
  else
    return;

  if(isDefined(var_2)) {
    setomnvar("ui_weapon_scanned", var_2);
    level notify("pc_weapon_scanned");
    thread _id_EBB8();
  }
}

_id_EBB8() {
  level endon("pc_weapon_scanned");
  wait 5.5;
  setomnvar("ui_weapon_scanned", "none");
}

_id_9D1A(var_0) {
  if(!isDefined(level._id_D9E5) || !isDefined(level._id_D9E5["weaponstates"]) || !isDefined(level._id_D9E5["weaponstates"][var_0]))
    return 0;

  var_1 = level._id_D9E5["mission_specific_weapons"];

  if(level._id_D9E5["weaponstates"][var_0] == "locked")
    return 1;

  return 0;
}

_id_3D6E() {
  var_0 = _id_DA08();
  var_1 = 0;
  var_2 = _id_D9F8();

  foreach(var_4 in var_2) {
    var_5 = level.player _meth_84C6("equipmentState", var_4);

    if(!isDefined(var_5)) {
      continue;
    }
    if(var_5 == "upgrade2") {
      var_1 = var_1 + 2;
      continue;
    }

    if(var_5 == "upgrade1")
      var_1 = var_1 + 1;
  }

  if(var_1 > 0)
    scripts\sp\utility::_id_834F("FIRST_EQUIP_UPGRADE");

  if(var_1 == var_0) {
    scripts\sp\utility::_id_834F("ALL_EQUIP_UPGRADES");
    _id_EBB3("veh_mil_air_un_jackal_livery_shell_19");
  }
}

_id_3DAE() {
  var_0 = 0;
  var_1 = 0;
  var_2 = _id_D9FF();

  foreach(var_4 in var_2) {
    if(var_4 == "primary_default") {
      continue;
    }
    var_1++;
    var_5 = level.player _meth_84C6("jackalPrimaryState", var_4);

    if(var_5 != "locked")
      var_0++;
  }

  var_7 = _id_DA01();

  foreach(var_9 in var_7) {
    if(var_9 == "secondary_default") {
      continue;
    }
    var_1++;
    var_5 = level.player _meth_84C6("jackalSecondaryState", var_9);

    if(var_5 != "locked")
      var_0++;
  }

  var_11 = _id_DA03();

  foreach(var_13 in var_11) {
    if(var_13 == "weapons" || var_13 == "hull") {
      continue;
    }
    var_1++;
    var_5 = level.player _meth_84C6("jackalUpgradeState", var_13);

    if(var_5 != "locked")
      var_0++;
  }

  if(var_0 > 0)
    scripts\sp\utility::_id_834F("FIRST_JACKAL_ITEM");

  if(var_0 == var_1)
    scripts\sp\utility::_id_834F("ALL_JACKAL_ITEMS");
}

_id_7D70(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  var_1 = _id_DA17();
  var_2 = ["iw7_m4", "iw7_fhr", "iw7_m8", "iw7_g18"];
  var_2 = scripts\engine\utility::array_combine(var_2, _id_DA0A());
  var_2 = scripts\engine\utility::array_combine(var_2, _id_DA10());

  if(var_0) {
    var_3 = level.player _meth_84C6("weaponsScanned", "iw7_ake");

    if(!isDefined(var_3))
      var_3 = "locked";

    if(var_3 != "locked")
      var_2 = scripts\engine\utility::array_add(var_2, "iw7_ake");
  }

  var_1 = scripts\engine\utility::array_remove_array(var_1, var_2);
  var_4 = var_1.size;
  var_5 = 0;

  foreach(var_7 in var_1) {
    var_3 = level.player _meth_84C6("weaponsScanned", var_7);

    if(!isDefined(var_3))
      var_3 = "locked";

    if(var_3 != "locked")
      var_5++;
  }

  return [var_5, var_4];
}

_id_3DDF(var_0) {
  var_1 = _id_7D70(var_0);

  if(var_1[0] > 0)
    scripts\sp\utility::_id_834F("SCAN_1_WEAPON");

  if(var_1[0] >= 10)
    scripts\sp\utility::_id_834F("SCAN_10_WEAPONS");

  if(var_1[0] == var_1[1]) {
    scripts\sp\utility::_id_834F("SCAN_ALL_WEAPONS");
    _id_EBB3("veh_mil_air_un_jackal_livery_shell_18");
  }

  return var_1;
}

_id_3DDD() {
  var_0 = _id_DA15();
  var_1 = 0;
  var_2 = 0;
  var_3 = scripts\sp\endmission::_id_7F6B("heist");
  var_4 = scripts\sp\endmission::_id_7F69(var_3);

  foreach(var_6 in var_0) {
    var_2++;

    if(tolower(var_6) == "salenkoch" || var_6 == "riah") {
      if(var_4)
        var_1++;

      continue;
    }

    var_7 = level.player _meth_84C6("wantedBoardDataState", var_6);

    if(!isDefined(var_7)) {
      continue;
    }
    if(var_7 == "obtained" || var_7 == "viewed")
      var_1++;
  }

  if(var_1 > 0)
    scripts\sp\utility::_id_834F("FIRST_WANTED_BOARD");

  if(var_1 > 15)
    scripts\sp\utility::_id_834F("HALF_WANTED_BOARD");

  if(var_1 == var_2) {
    scripts\sp\utility::_id_834F("ALL_WANTED_BOARD");
    _id_EBB3("veh_mil_air_un_jackal_livery_shell_17");
  }
}

_id_3D6A(var_0) {
  if(!isDefined(var_0) || !var_0)
    var_1 = _id_DA1B();
  else
    var_1 = level._id_D9E5["achievementDoorPeek"];

  var_2 = 1;

  foreach(var_5, var_4 in var_1) {
    if(!var_4)
      var_2 = 0;
  }

  if(var_2) {
    scripts\sp\utility::_id_834F("DOOR_PEEK");

    if(isDefined(var_0) && var_0) {
      foreach(var_5, var_4 in level._id_D9E5["achievementDoorPeek"])
      level.player _meth_84C7(var_5, var_4);
    }
  }
}

_id_3D61() {
  var_0 = level.player _meth_84C6("achievementBootsOnGround");

  if(isDefined(var_0) && var_0) {
    return;
  }
  var_1 = 120.0;
  level._id_C538 = 0.0;
  var_2 = 0.0;
  var_3 = 0;

  for(;;) {
    var_4 = level.player.origin;
    wait 0.05;
    var_5 = level.player.origin;
    var_6 = length(var_5 - var_4);

    if(level.player iswallrunning()) {
      level._id_C538 = 0;
      var_2 = 0;
      var_3 = 0;
    } else if(level.player scripts\engine\utility::get_doublejumpenergy() < 390.0 && level.player isjumping()) {
      level._id_C538 = 0;
      var_2 = 0;
      var_3 = 0;
    } else if(level.player scripts\engine\utility::get_doublejumpenergy() >= 390.0 && !level.player isjumping() && var_6 > 1.5 && !scripts\sp\utility::_id_93AC() && !level.player islinked()) {
      if(var_2 == 0)
        var_2 = gettime() / 1000;

      level._id_C538 = var_3 + gettime() / 1000 - var_2;
    } else {
      var_2 = 0;
      var_3 = level._id_C538;
    }

    if(level._id_C538 >= var_1) {
      scripts\sp\utility::_id_834F("NO_JUMPING");
      level.player _meth_84C7("achievementBootsOnGround", 1);
      break;
    }

    wait 0.05;
  }
}

_id_F618(var_0) {
  if(!isDefined(level._id_D9E5) || !isDefined(level._id_D9E5["weaponstates"]) || !isDefined(level._id_D9E5["weaponstates"][var_0]))
    return 0;

  level._id_D9E5["weaponstates"][var_0] = "scanned";
  level.player _meth_84C7("weaponsScanned", var_0, "scanned");
  _id_DA50(var_0);
  var_1 = _id_3DDF();

  if(scripts\engine\utility::array_contains(level._id_D9E5["optionalunlocks"], var_0))
    level._id_D9E5["optionalunlocks"] = scripts\engine\utility::array_remove(level._id_D9E5["optionalunlocks"], var_0);

  if(scripts\engine\utility::array_contains(level._id_D9E5["mandatoryunlocks"], var_0))
    level._id_D9E5["mandatoryunlocks"] = scripts\engine\utility::array_remove(level._id_D9E5["mandatoryunlocks"], var_0);

  level notify("weapon_scan_complete", var_0);

  if(var_1[0] <= 2) {
    wait 1.5;
    scripts\sp\utility::_id_914C("fluff_messages_new_scan", "fluff_messages_new_scan_body", "scan_intel");
  }
}

_id_DA50(var_0) {
  if(!_id_DA41(var_0)) {
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
      return;
  }
}

_id_13C46() {
  var_0 = 1000;
  var_1 = getaiarray("axis");

  foreach(var_3 in var_1) {
    if(distancesquared(var_3.origin, level.player.origin) < squared(var_0))
      return 1;
  }

  if(level.player issprinting())
    return 1;

  if(level.player scripts\sp\utility::_id_9F59())
    return 1;

  if(level.player isthrowinggrenade())
    return 1;

  if(level.player.health < 100)
    return 1;

  if(level.player scripts\engine\utility::isflashed())
    return 1;

  if(level.player isgestureplaying()) {
    if(!level.player isgestureplaying("ges_demeanor_safe") && !level.player isgestureplaying("ges_demeanor_relaxed"))
      return 1;
  }

  if(level.player scripts\sp\utility::_id_D121())
    return 1;

  return 0;
}

_id_12BD8(var_0) {
  level._id_D9E5["mandatoryunlocks"] = scripts\engine\utility::array_remove(level._id_D9E5["mandatoryunlocks"], var_0);
  level._id_D9E5["loaded_weapon_types"] = _id_DA3F();
}

_id_13C61(var_0) {
  level._id_D9E5["weaponstates"][var_0] = "unlocked";

  if(scripts\engine\utility::array_contains(level._id_D9E5["optionalunlocks"], var_0))
    level._id_D9E5["optionalunlocks"] = scripts\engine\utility::array_remove(level._id_D9E5["optionalunlocks"], var_0);

  if(!level._id_D9E5["fakedata"])
    level.player _meth_84C7("weaponsScanned", var_0, "unlocked");

  level._id_D9E5["loaded_weapon_types"] = _id_DA3F();
}

_id_66A4(var_0, var_1) {
  var_2 = level.player _meth_84C6("equipmentState", var_0);

  if(isDefined(var_2) && var_2 != "locked") {
    level._id_D9E5["weaponstates"][var_0] = var_2;
    return;
  }

  if(isDefined(var_1) && var_1)
    var_3 = "unlocked";
  else
    var_3 = "scanned";

  level._id_D9E5["weaponstates"][var_0] = var_3;
  level.player _meth_84C7("equipmentState", var_0, var_3);
}

_id_7D5F(var_0) {
  var_1 = _id_DA17("sdf");
  var_2 = _id_DA17("un");
  var_3 = undefined;

  if(scripts\engine\utility::array_contains(var_1, var_0))
    var_3 = "allies";
  else if(scripts\engine\utility::array_contains(var_2, var_0))
    var_3 = "axis";
  else
    var_3 = "other";

  return var_3;
}

_id_7BEC(var_0, var_1) {
  if(!isDefined(var_1)) {
    if(var_0 == "rpg") {
      var_1 = 1;
      var_0 = "rocketlauncher";
    } else
      var_1 = 0;
  }

  var_2 = undefined;
  var_3 = undefined;

  if(isDefined(level._id_D9E5) && isDefined(level._id_D9E5["loaded_weapon_types"])) {
    var_4 = level._id_D9E5["loaded_weapon_types"][var_0];
    var_4 = scripts\engine\utility::array_randomize(var_4);

    foreach(var_6 in var_4) {
      if(_id_DA41(var_6.weapon_name)) {
        continue;
      }
      if(_id_DA43(var_6.weapon_name)) {
        continue;
      }
      if(var_1 || !_id_DA40(var_6.weapon_name)) {
        if(var_6._id_13C13 != self.team) {
          var_2 = var_6.weapon_name;
          continue;
        }

        var_2 = var_6.weapon_name;
        break;
      }
    }
  }

  if(!isDefined(var_2)) {
    var_4 = _id_DA17("un", "sdf");
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

  if(isDefined(var_3))
    var_2 = var_2 + "+" + var_3;

  return var_2;
}

_id_7BEB() {
  var_0 = undefined;

  if(isDefined(level._id_D9E5) && isDefined(level._id_D9E5["loaded_equipment_types"])) {
    var_1 = level._id_D9E5["loaded_equipment_types"];

    if(var_1.size > 0)
      var_0 = scripts\engine\utility::random(var_1);
  }

  if(!isDefined(var_0))
    var_0 = "frag";

  if(var_0 == "offhandshield" || var_0 == "coverwall" || var_0 == "supportdrone" || var_0 == "hackingdevice")
    var_0 = "frag";

  if(var_0 == "seeker")
    var_0 = "frag";

  if(var_0 == "antigrav" || var_0 == "emp") {
    if(randomint(100) < 95)
      var_0 = "frag";
  }

  return var_0;
}

_id_7AEA(var_0) {
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
    if(isDefined(level._id_D9E5["attachments"]["default"]["scope"][var_2])) {
      foreach(var_10 in level._id_D9E5["attachments"]["default"]["scope"][var_2]) {
        if(!scripts\engine\utility::array_contains(var_3, var_10._id_24A2))
          var_4 = scripts\engine\utility::array_add(var_4, var_10._id_24A2);
      }
    }
  } else if(var_2 == "m8") {
    if(!scripts\engine\utility::array_contains(var_3, "arm8_sp"))
      scripts\engine\utility::array_add(var_4, "arm8_sp");
  } else if(var_2 == "ripper") {
    if(!scripts\engine\utility::array_contains(var_3, "arripper_sp"))
      scripts\engine\utility::array_add(var_4, "arripper_sp");
  }

  if(var_2 == "fmg") {
    if(!scripts\engine\utility::array_contains(var_3, "akimbofmg_sp"))
      scripts\engine\utility::array_add(var_4, "akimbofmg_sp");
  }

  return var_4;
}

build_attach_models(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_0)) {}

  if(!isDefined(var_2))
    var_2 = scripts\engine\utility::weaponclass(var_0);

  if(!isDefined(var_5))
    var_5 = 1;

  if(!isDefined(var_6))
    var_6 = 0;

  var_8 = getsubstr(var_0, 4);
  var_9 = undefined;
  var_10 = 0;
  var_11 = 1;
  var_12 = [];
  var_13 = undefined;
  var_14 = undefined;
  var_15 = 0;
  var_16 = 0;

  if(isDefined(level._id_D9E5)) {
    if(isDefined(level._id_D9E5["unlocked_attachments"]))
      var_14 = level._id_D9E5["unlocked_attachments"];
  } else if(!isDefined(level._id_D9E5) || isDefined(level._id_D9E5) && !isDefined(level._id_D9E5["attachments"])) {
    var_13 = _id_DA52();
    var_14 = _id_DA1E();
  }

  if(!isDefined(var_14))
    var_14 = ["reflex", "acog"];

  if(!isDefined(var_13) && isDefined(level._id_D9E5)) {
    var_13 = level._id_D9E5["attachments"];

    if(isDefined(level._id_D9E5["attachment_overrides"])) {
      var_14 = level._id_D9E5["attachment_overrides"];
      var_1 = "random";
    }
  } else if(!isDefined(var_13)) {
    if(var_8 == "ar57")
      return "ar57scope";
    else if(var_8 == "atomizer")
      return "atomizerscope";
    else if(var_8 == "chargeshot")
      return "chargeshotscope";
    else if(var_8 == "crb")
      return "crblscope";
    else if(var_8 == "erad")
      return "eradscope";
    else if(var_8 == "fmg")
      return "akimbofmg_sp+fmgscope";
    else if(var_8 == "kbs")
      return "kbsscope";
    else if(var_8 == "lmg03")
      return "lmg03scope";
    else if(var_8 == "lockon")
      return "lockonscope";
    else if(var_8 == "m8")
      return "m8scope_sp";
    else if(var_8 == "penetrationrail")
      return "penetrationrailscope";
    else if(var_8 == "ripper")
      return "ripperrscope_sp";
    else if(var_8 == "sonic")
      return "sonicscope";
    else if(var_8 == "sdfshotty")
      return "sdfshottyscope";
    else
      return;
  }

  if(!isDefined(var_13[var_2]))
    var_1 = "default";

  if(var_1 == "default")
    var_5 = 0;

  if(var_0 == "iw7_gambit")
    var_14 = _id_D9F2(0);

  if(_id_DA40(var_0) || var_0 == "iw7_m1") {
    var_1 = "default";
    var_5 = 0;
  } else if(var_1 == "random") {
    var_14 = scripts\engine\utility::array_remove(var_14, "silencer");

    if(var_14.size > 1)
      var_14 = scripts\engine\utility::array_add(var_14, "none");

    if(isDefined(level._id_72A6)) {
      var_1 = level._id_72A6;

      if(var_5 < 3)
        var_5++;
    } else if(var_14.size > 0)
      var_1 = var_14[randomint(var_14.size)];
    else
      var_5 = 0;
  } else if(isDefined(var_7)) {
    var_1 = var_7[0];
    var_5 = var_7.size;
  }

  var_17 = 3;

  if(isDefined(var_7))
    var_17 = var_7.size;
  else if(var_0 == "iw7_gambit")
    var_17 = 4;

  var_18 = 0;
  var_19 = 0;

  for(var_20 = 0; var_20 < var_5; var_20++) {
    var_21 = undefined;
    var_22 = undefined;
    var_23 = undefined;

    if(isDefined(var_1) && var_1 != "default") {
      if(isDefined(var_13[var_2]) && isDefined(var_13[var_2][var_1])) {
        if(isDefined(var_13[var_2][var_1][var_8])) {
          var_21 = var_13[var_2][var_1][var_8][0].location;
          var_22 = var_13[var_2][var_1][var_8][0]._id_24A2;
          var_23 = var_13[var_2][var_1][var_8][0]._id_9ECE;
        } else if(weaponusesenergybullets(var_0) && isDefined(var_13[var_2][var_1][""][1])) {
          var_21 = var_13[var_2][var_1][""][1].location;
          var_22 = var_13[var_2][var_1][""][1]._id_24A2;
          var_23 = var_13[var_2][var_1][""][1]._id_9ECE;
        } else if(isDefined(var_13[var_2][var_1][""][0])) {
          var_21 = var_13[var_2][var_1][""][0].location;
          var_22 = var_13[var_2][var_1][""][0]._id_24A2;
          var_23 = var_13[var_2][var_1][""][0]._id_9ECE;
        }
      }
    }

    if(isDefined(var_22)) {
      if(var_21 == "rail") {
        if(!var_15) {
          var_9 = var_21;
          var_12 = scripts\engine\utility::array_add(var_12, var_22);
          var_15 = 1;
          var_18++;

          if(var_23)
            var_10 = 1;
        }
      } else if(var_21 == "undermount") {
        if(!var_16) {
          var_9 = var_21;
          var_12 = scripts\engine\utility::array_add(var_12, var_22);
          var_16 = 1;
          var_18++;
        }
      } else {
        var_9 = var_21;
        var_12 = scripts\engine\utility::array_add(var_12, var_22);
        var_18++;
      }
    }

    if(var_18 == var_17) {
      break;
    }

    if(isDefined(var_7)) {
      var_19++;

      if(var_19 >= var_7.size) {
        break;
      }

      var_1 = var_7[var_19];
      continue;
    }

    var_14 = scripts\engine\utility::array_remove(var_14, var_1);

    if(var_14.size == 0) {
      break;
    }

    var_1 = var_14[randomint(var_14.size)];
  }

  if(var_6) {
    var_24 = "epic" + var_8;

    if(isDefined(var_13[var_2][var_24]) && isDefined(var_13[var_2][var_24][var_8]))
      var_12 = scripts\engine\utility::array_add(var_12, var_13[var_2][var_24][var_8][0]._id_24A2);
  }

  if(!isDefined(var_3) || isDefined(var_3) && !var_3 || var_10) {
    if(var_12.size > 0) {
      if(var_15 && !var_10)
        var_11 = 0;
    }

    if(!getdvarint("r_reflectionProbeGenerate")) {
      if(var_11 && isDefined(var_13["default"]["scope"][var_8])) {
        var_22 = var_13["default"]["scope"][var_8][0]._id_24A2;
        var_9 = var_13["default"]["scope"][var_8][0].location;
        var_12 = scripts\engine\utility::array_add(var_12, var_22);
        var_15 = 1;
      } else if(var_8 == "m8")
        var_12 = scripts\engine\utility::array_add(var_12, "arm8_sp");
      else if(var_8 == "ripper")
        var_12 = scripts\engine\utility::array_add(var_12, "arripper_sp");

      if(var_8 == "fmg" && !scripts\engine\utility::array_contains(var_12, "epicfmg"))
        var_12 = scripts\engine\utility::array_add(var_12, "akimbofmg_sp");
      else if(var_8 == "erad") {
        if(scripts\engine\utility::array_contains(var_12, "epicerad"))
          var_12 = scripts\engine\utility::array_add(var_12, "epicshotgunerad_sp");
        else
          var_12 = scripts\engine\utility::array_add(var_12, "shotgunerad_sp");
      } else if(var_8 == "repeater")
        var_12 = scripts\engine\utility::array_add(var_12, "mod_ammo");
      else if(var_8 == "stasis")
        var_12 = scripts\engine\utility::array_add(var_12, "mod_ads_stability_sniper");
      else if(var_8 == "counterweight")
        var_12 = scripts\engine\utility::array_add(var_12, "mod_recoil");
    }
  }

  if(var_8 == "devastator" && scripts\engine\utility::array_contains(var_12, "epicdevastator")) {
    if(scripts\engine\utility::array_contains(var_12, "smart")) {
      var_12 = scripts\engine\utility::array_remove(var_12, "smart");
      var_12 = scripts\engine\utility::array_add(var_12, "smartar");
    } else if(scripts\engine\utility::array_contains(var_12, "eloshtgn")) {
      var_12 = scripts\engine\utility::array_remove(var_12, "eloshtgn");
      var_12 = scripts\engine\utility::array_add(var_12, "eloshtgnepicdev");
    } else if(scripts\engine\utility::array_contains(var_12, "phaseshotgun_sp")) {
      var_12 = scripts\engine\utility::array_remove(var_12, "phaseshotgun_sp");
      var_12 = scripts\engine\utility::array_add(var_12, "phaseshotgunepicdev_sp");
    } else if(scripts\engine\utility::array_contains(var_12, "reflexshotgun")) {
      var_12 = scripts\engine\utility::array_remove(var_12, "reflexshotgun");
      var_12 = scripts\engine\utility::array_add(var_12, "reflexshotgunepicdev");
    } else
      var_12 = scripts\engine\utility::array_add(var_12, "epicdevastatorads");
  } else if(var_8 == "emc" && scripts\engine\utility::array_contains(var_12, "epicemc")) {
    if(scripts\engine\utility::array_contains(var_12, "elopstl")) {
      var_12 = scripts\engine\utility::array_remove(var_12, "elopstl");
      var_12 = scripts\engine\utility::array_add(var_12, "elopstlepicemc");
    } else if(scripts\engine\utility::array_contains(var_12, "phasepstl_sp")) {
      var_12 = scripts\engine\utility::array_remove(var_12, "phasepstl_sp");
      var_12 = scripts\engine\utility::array_add(var_12, "phasepstlepicemc_sp");
    } else if(scripts\engine\utility::array_contains(var_12, "reflexpstl")) {
      var_12 = scripts\engine\utility::array_remove(var_12, "reflexpstl");
      var_12 = scripts\engine\utility::array_add(var_12, "reflexpstlepicemc");
    } else
      var_12 = scripts\engine\utility::array_add(var_12, "epicemcads");
  }

  var_25 = undefined;

  if(var_12.size > 0) {
    var_12 = scripts\engine\utility::alphabetize(var_12);
    var_25 = var_12[0];

    for(var_20 = 1; var_20 < var_12.size; var_20++)
      var_25 = var_25 + "+" + var_12[var_20];
  }

  if(isDefined(var_4) && var_4)
    return [var_25, var_15];
  else
    return var_25;
}

_id_3DDC(var_0) {
  if(var_0 == "weapon")
    var_1 = "loaded_weapons";
  else
    var_1 = "weaponstates";

  if(!isDefined(level._id_D9E5))
    return 0;

  if(!isDefined(level._id_D9E5[var_1]))
    return 0;

  if(level._id_D9E5[var_1].size < 1)
    return 0;

  if(!isDefined(level._id_D9E5["weaponstates"]))
    return 0;

  return 1;
}

_id_D9E8(var_0) {
  if(!isDefined(var_0)) {
    if(isDefined(level._id_D9E5["attachment_overrides"]))
      level._id_D9E5["attachment_overrides"] = undefined;
  } else
    level._id_D9E5["attachment_overrides"] = var_0;
}

_id_7808() {
  var_0 = strtok(tablelookup("sp/progression_unlocks.csv", 0, "all_weapons", 2), ", ");
  var_1 = strtok(tablelookup("sp/progression_unlocks.csv", 0, "all_weapons", 3), ", ");
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  return var_2;
}

_id_7807() {
  var_0 = strtok(tablelookup("sp/progression_unlocks.csv", 0, "all_weapons", 5), ", ");
  return var_0;
}

_id_7806() {
  var_0 = strtok(tablelookup("sp/progression_unlocks.csv", 0, "all_weapons", 6), ", ");
  return var_0;
}

_id_D9EF(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = level.player _meth_84C6(var_0, var_4);

    if(!isDefined(level.player _meth_84C6(var_0, var_4))) {
      continue;
    }
    if(level.player _meth_84C6(var_0, var_4) == "scanned")
      var_2 = scripts\engine\utility::array_add(var_2, var_4);
  }

  return var_2;
}

_id_DA0E() {
  var_0 = [];
  var_1 = _id_DA12();
  var_0["suit_upgrades"] = _id_D9EF("suitUpgradeState", var_1);
  var_2 = _id_D9FC();
  var_0["jackal_decals"] = _id_D9EF("jackalDecals", var_2);
  var_3 = _id_D9FF();
  var_0["jackal_primaries"] = _id_D9EF("jackalPrimaryState", var_3);
  var_4 = _id_DA01();
  var_0["jackal_secondaries"] = _id_D9EF("jackalSecondaryState", var_4);
  var_5 = _id_DA03();
  var_0["jackal_upgrades"] = _id_D9EF("jackalUpgradeState", var_5);
  var_6 = _id_D9F2();
  var_0["attachments"] = _id_D9EF("attachmentsState", var_6);
  var_7 = _id_DA0D();
  var_0["reticles"] = _id_D9EF("reticlesState", var_7);
  var_8 = _id_D9F3();
  var_0["camos"] = _id_D9EF("camosState", var_8);
  return var_0;
}

_id_DA3C() {
  var_0 = _id_DA15();
  var_1 = 1;
  var_2 = [];

  foreach(var_4 in var_0) {
    var_5 = level.player _meth_84C6("wantedBoardDataState", var_4);

    if(!isDefined(var_5) || var_5 != "obtained" && var_5 != "viewed")
      var_1 = 0;

    var_2[var_4] = var_5;
  }

  return var_2;
}

_id_DA56(var_0, var_1) {
  level._id_D9E5["wanted_cards"][var_0] = var_1;
}

_id_DA1B() {
  var_0 = [];
  var_0["achievementDoorPeekOpen"] = level.player _meth_84C6("achievementDoorPeekOpen");
  var_0["achievementDoorPeekKick"] = level.player _meth_84C6("achievementDoorPeekKick");
  var_0["achievementDoorPeekGrenade"] = level.player _meth_84C6("achievementDoorPeekGrenade");
  return var_0;
}

_id_DA08() {
  return 12;
}

_id_DA4F() {
  var_0 = level.player _meth_84C6("scrapCount");

  if(!isDefined(var_0))
    var_0 = 0;

  var_1 = _id_DA38();

  foreach(var_8, var_3 in var_1) {
    foreach(var_7, var_5 in var_3) {
      if(int(var_5) <= var_0) {
        if(var_8 == "attachment") {
          var_6 = level.player _meth_84C6("attachmentsState", var_7);

          if(var_6 == "locked")
            level.player _meth_84C7("attachmentsState", var_7, "scanned");

          continue;
        }

        if(var_8 == "reticle") {
          var_6 = level.player _meth_84C6("reticlesState", var_7);

          if(var_6 == "locked")
            level.player _meth_84C7("reticlesState", var_7, "scanned");
        }
      }
    }
  }

  _id_DA0E();
}

_id_DA4E() {
  foreach(var_1 in level._id_D9E5["scanned_items"]["suit_upgrades"])
  level.player _meth_84C7("suitUpgradeState", var_1, "unlocked");
}

_id_DA48() {
  foreach(var_1 in level._id_D9E5["scanned_items"]["suit_upgrades"])
  level.player _meth_84C7("suitUpgradeState", var_1, "unlocked");

  foreach(var_1 in level._id_D9E5["scanned_items"]["jackal_decals"])
  level.player _meth_84C7("jackalDecals", var_1, "unlocked");

  foreach(var_1 in level._id_D9E5["scanned_items"]["jackal_primaries"])
  level.player _meth_84C7("jackalPrimaryState", var_1, "unlocked");

  foreach(var_1 in level._id_D9E5["scanned_items"]["jackal_secondaries"])
  level.player _meth_84C7("jackalSecondaryState", var_1, "unlocked");

  foreach(var_1 in level._id_D9E5["scanned_items"]["jackal_upgrades"])
  level.player _meth_84C7("jackalUpgradeState", var_1, "unlocked");

  foreach(var_1 in level._id_D9E5["scanned_items"]["attachments"])
  level.player _meth_84C7("attachmentsState", var_1, "unlocked");

  foreach(var_1 in level._id_D9E5["scanned_items"]["reticles"])
  level.player _meth_84C7("reticlesState", var_1, "unlocked");

  foreach(var_1 in level._id_D9E5["scanned_items"]["camos"])
  level.player _meth_84C7("camosState", var_1, "unlocked");

  foreach(var_19, var_18 in level._id_D9E5["weaponstates"]) {
    if(_id_9B49(var_19) && var_18 == "scanned") {
      level._id_D9E5["weaponstates"][var_19] = "unlocked";
      level.player _meth_84C7("weaponsScanned", var_19, "unlocked");
    }
  }
}

_id_D9F0(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_1) {
    if(!isDefined(level.player)) {
      continue;
    }
    var_5 = level.player _meth_84C6(var_0, var_4);

    if(!isDefined(var_5)) {
      continue;
    }
    if(isstring(var_5) && level.player _meth_84C6(var_0, var_4) == "unlocked" || !isstring(var_5) && level.player _meth_84C6(var_0, var_4) == 1)
      var_2 = scripts\engine\utility::array_add(var_2, var_4);
  }

  return var_2;
}

_id_D9EC(var_0) {
  if(!isDefined(level._id_D9E5["ace_pilots"]))
    return "acepilot0";

  if(!isDefined(level._id_D9E5["ace_pilots"][var_0]))
    return "acepilot0";

  return level._id_D9E5["ace_pilots"][var_0];
}

_id_DA45(var_0, var_1) {
  if(!isDefined(level._id_D9E5)) {
    return;
  }
  if(!isDefined(level._id_D9E5["wanted_cards"])) {
    return;
  }
  if(!isDefined(level._id_D9E5["wanted_cards"][var_0])) {
    return;
  }
  var_2 = level._id_D9E5["wanted_cards"][var_0];

  if(var_2 == "locked")
    level._id_D9E5["wanted_cards"][var_0] = "obtained";

  if(isDefined(var_1))
    wait(var_1);

  var_3 = "most_wanted_portait_" + var_0;
  scripts\sp\utility::_id_914C("mostwanted_target_killed", "mostwanted_" + var_0 + "_killed", "intel_" + var_0);
}

_id_12E18() {
  if(!isDefined(level._id_D9E5)) {
    return;
  }
  if(_id_9CBB(level.template_script))
    _id_DA48();

  foreach(var_1 in level._id_D9E5["suit_upgrades"])
  level.player _meth_84C7("suitUpgradeState", var_1, "unlocked");

  foreach(var_1 in level._id_D9E5["mandatory_suit_upgrades"]) {
    var_4 = level.player _meth_84C6("suitUpgradeState", var_1);

    if(var_4 == "locked")
      level.player _meth_84C7("suitUpgradeState", var_1, "scanned");
  }

  foreach(var_7 in level._id_D9E5["mandatory_jackal_primaries"]) {
    var_4 = level.player _meth_84C6("jackalPrimaryState", var_7);

    if(var_4 == "locked")
      level.player _meth_84C7("jackalPrimaryState", var_7, "scanned");
  }

  foreach(var_10 in level._id_D9E5["mandatory_jackal_secondaries"]) {
    var_4 = level.player _meth_84C6("jackalSecondaryState", var_10);

    if(var_4 == "locked")
      level.player _meth_84C7("jackalSecondaryState", var_10, "scanned");
  }

  foreach(var_13 in level._id_D9E5["mandatory_jackal_upgrades"]) {
    var_4 = level.player _meth_84C6("jackalUpgradeState", var_13);

    if(var_4 == "locked")
      level.player _meth_84C7("jackalUpgradeState", var_13, "scanned");
  }

  foreach(var_16 in level._id_D9E5["mandatory_jackal_decals"]) {
    var_4 = level.player _meth_84C6("jackalDecals", var_16);

    if(var_4 == "locked")
      level.player _meth_84C7("jackalDecals", var_16, "scanned");
  }

  _id_3DAE();

  foreach(var_19, var_4 in level._id_D9E5["wanted_cards"])
  level.player _meth_84C7("wantedBoardDataState", var_19, var_4);

  _id_3DDD();

  foreach(var_22, var_21 in level._id_D9E5["achievementDoorPeek"])
  level.player _meth_84C7(var_22, var_21);

  _id_3D6A();

  foreach(var_24, var_4 in level._id_D9E5["weaponstates"]) {
    if(_id_9B49(var_24))
      level.player _meth_84C7("weaponsScanned", var_24, var_4);
  }

  if(isDefined(level.template_script)) {
    level.player _meth_84C7("lastCompletedMission", level.template_script);
    game["lastcompletedmission"] = level.template_script;
  }

  if(level._id_D9E5["submission"] != "submission") {
    level.player _meth_84C7("missionStateData", level._id_D9E5["submission"], "complete");
    level.player _meth_84C7("opsmapMissionStateData", level._id_D9E5["submission"], "complete");
  }
}

_id_9B49(var_0) {
  var_1 = _id_D9F8();

  if(_id_9B44(var_0))
    return 0;

  if(var_0 == "none")
    return 0;

  return !scripts\engine\utility::array_contains(var_1, var_0);
}

_id_9B44(var_0) {
  var_1 = _id_D9FC();

  foreach(var_3 in var_1) {
    if(issubstr(var_3, var_0))
      return 1;
  }

  return 0;
}

_id_EBB7(var_0) {
  if(level.player _meth_84C6("weaponsScanned", var_0) == "locked") {
    level.player _meth_84C7("weaponsScanned", var_0, "scanned");
    _id_DA50(var_0);
  }
}

_id_EBB3(var_0) {
  if(level.player _meth_84C6("jackalDecals", var_0) == "locked")
    level.player _meth_84C7("jackalDecals", var_0, "scanned");
}

_id_5F2F() {
  for(var_0 = 0; var_0 < level._id_B8D2._id_ABFA.size; var_0++) {
    if(scripts\sp\endmission::getitemslot(var_0)) {
      continue;
    }
    var_1 = scripts\sp\endmission::_id_7F69(var_0);
    var_2 = level.player _meth_84C6("missionStateData", scripts\sp\endmission::_id_7F6D(var_0));

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

    if(var_1 == 6)
      var_2 = "COMPLETE - YOLO";
  }

  foreach(var_4 in _id_DA17()) {
    if(_id_9B49(var_4)) {
      if(!_id_DA41(var_4) && !_id_DA43(var_4)) {}
    }
  }

  foreach(var_4 in _id_DA17()) {
    if(_id_9B49(var_4)) {
      if(_id_DA41(var_4)) {}
    }
  }

  foreach(var_4 in _id_DA17()) {
    if(_id_9B49(var_4)) {
      if(_id_DA43(var_4)) {}
    }
  }

  foreach(var_11 in _id_D9F2()) {}

  foreach(var_14 in _id_D9F8()) {
    if(!_id_9B49(var_14)) {}
  }

  foreach(var_17 in _id_DA15()) {}

  foreach(var_20 in _id_DA12()) {}

  foreach(var_23 in _id_D9FF()) {}

  foreach(var_23 in _id_DA01()) {}

  foreach(var_23 in _id_DA03()) {}

  foreach(var_30 in _id_D9FC()) {}

  var_32 = _id_7AF1("sub");

  foreach(var_34 in var_32) {
    var_35 = _id_DA22(var_34);

    if(var_35 == 0 && var_34 != "rogue") {
      continue;
    }
    var_36 = 1;

    if(var_34 == "sa_wounded")
      var_36 = 2;

    var_35 = var_35 / var_36;

    for(var_37 = 0; var_37 < var_36; var_37++) {
      var_38 = level.player _meth_84C6("missionLootRooms", var_34, "discovered", var_37);

      if(var_38) {} else {}

      for(var_39 = 0; var_39 < 1; var_39++) {
        var_40 = var_37 * 2 + var_39;
        var_41 = level.player _meth_84C6("missionLootRooms", var_34, "terminal", var_40);

        if(var_41)
          continue;
      }
    }
  }

  for(var_43 = 0; var_43 < 4; var_43++) {
    var_44 = level.player _meth_84C6("loadouts", var_43, "name");
    var_45 = level.player _meth_84C6("loadouts", var_43, "weaponSetups", 0, "weapon");
    var_46[0] = level.player _meth_84C6("loadouts", var_43, "weaponSetups", 0, "attachment", 0);
    var_46[1] = level.player _meth_84C6("loadouts", var_43, "weaponSetups", 0, "attachment", 1);
    var_46[2] = level.player _meth_84C6("loadouts", var_43, "weaponSetups", 0, "attachment", 2);
    var_47 = level.player _meth_84C6("loadouts", var_43, "weaponSetups", 1, "weapon");
    var_48[0] = level.player _meth_84C6("loadouts", var_43, "weaponSetups", 1, "attachment", 0);
    var_48[1] = level.player _meth_84C6("loadouts", var_43, "weaponSetups", 1, "attachment", 1);
    var_48[2] = level.player _meth_84C6("loadouts", var_43, "weaponSetups", 1, "attachment", 2);
    var_49 = level.player _meth_84C6("loadouts", var_43, "equipment", 0);
    var_50 = level.player _meth_84C6("loadouts", var_43, "offhandEquipment", 0);
    var_51 = level.player _meth_84C6("loadouts", var_43, "equipment", 1);
    var_52 = level.player _meth_84C6("loadouts", var_43, "offhandEquipment", 1);
  }

  if(level.player _meth_84C6("unlockedRealism")) {} else {}

  if(level.player _meth_84C6("beatRealism")) {} else {}

  if(level.player _meth_84C6("achievementDoorPeekOpen")) {} else {}

  if(level.player _meth_84C6("achievementDoorPeekKick")) {} else {}

  if(level.player _meth_84C6("achievementDoorPeekGrenade")) {} else {}
}

_id_E222() {
  level.player _meth_84C7("scrapCount", 0);

  foreach(var_1 in _id_DA12())
  level.player _meth_84C7("suitUpgradeState", var_1, "locked");

  foreach(var_4 in _id_D9FF())
  level.player _meth_84C7("jackalPrimaryState", var_4, "locked");

  foreach(var_7 in _id_DA01())
  level.player _meth_84C7("jackalSecondaryState", var_7, "locked");

  foreach(var_10 in _id_DA03())
  level.player _meth_84C7("jackalUpgradeState", var_10, "locked");

  foreach(var_13 in _id_D9FC())
  level.player _meth_84C7("jackalDecals", var_13, "locked");

  foreach(var_16 in _id_DA15())
  level.player _meth_84C7("wantedBoardDataState", var_16, "locked");

  foreach(var_19 in _id_DA17()) {
    if(_id_DA41(var_19)) {
      continue;
    }
    if(_id_DA43(var_19)) {
      continue;
    }
    if(_id_9B49(var_19)) {
      level.player _meth_84C7("weaponsScanned", var_19, "locked");
      continue;
    }

    level.player _meth_84C7("equipmentState", var_19, "locked");
  }

  var_21 = _id_D9F2(1);

  foreach(var_23 in var_21)
  level.player _meth_84C7("attachmentsState", var_23, "locked");

  var_25 = _id_DA0D();

  foreach(var_27 in var_25)
  level.player _meth_84C7("reticlesState", var_27, "locked");

  var_29 = _id_D9F3();

  foreach(var_31 in var_29)
  level.player _meth_84C7("camosState", var_31, "locked");

  var_33 = _id_DA15();

  foreach(var_35 in var_33)
  level.player _meth_84C7("wantedBoardDataState", var_35, "locked");

  level.player _meth_84C7("currentLoadout", "levelCreated", 0);
  level.player _meth_84C7("currentLoadout", "heldWeapon", "none");

  for(var_37 = 0; var_37 < 2; var_37++) {
    level.player _meth_84C7("currentLoadout", "weaponSetups", var_37, "weapon", "none");
    level.player _meth_84C7("currentLoadout", "weaponSetups", var_37, "reticle", "none");
    level.player _meth_84C7("currentLoadout", "weaponClipAmmo", var_37, 0);
    level.player _meth_84C7("currentLoadout", "weaponStockAmmo", var_37, 0);

    for(var_38 = 0; var_38 < 3; var_38++)
      level.player _meth_84C7("currentLoadout", "weaponSetups", var_37, "attachment", var_38, "none");
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
  var_39 = _id_7AF1("sub");

  foreach(var_41 in var_39) {
    for(var_42 = 0; var_42 < 2; var_42++) {
      level.player _meth_84C7("missionLootRooms", var_41, "discovered", var_42, 0);

      for(var_43 = 0; var_43 < 2; var_43++) {
        var_44 = var_42 * 2 + var_43;
        level.player _meth_84C7("missionLootRooms", var_41, "terminal", var_43, 0);
      }
    }

    level.player _meth_84C7("missionStateData", var_41, "locked");
    level.player _meth_84C7("opsmapMissionStateData", var_41, "locked");
  }

  var_46 = _id_7AF1("main", "sub");

  foreach(var_48 in var_46)
  level.player _meth_84C7("shipAssaultStateData", var_48, "locked");

  _id_492B(1);
  _id_5F2F();
}