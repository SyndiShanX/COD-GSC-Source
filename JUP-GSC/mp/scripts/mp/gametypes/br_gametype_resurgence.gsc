/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_gametype_resurgence.gsc
**************************************************************/

#using script_128d1a71fc850b8a;
#using script_1c47017ba325709a;
#using script_26ccbfe3954cacf4;
#using script_4cdabcd91a92977;
#using script_548072087c9fd504;
#using script_5bab271917698dc4;
#using script_640cf1641c03e2a0;
#using script_64acb6ce534155b7;
#using script_697b7ae06ba9b28c;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\omnvar_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_heli_reinforce;
#using scripts\mp\class;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_ai_encounters;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_deployable_kiosk;
#using scripts\mp\gametypes\br_dev;
#using scripts\mp\gametypes\br_gametype_resurgence;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\gametypes\br_spectate;
#using scripts\mp\gametypes\br_utility;
#using scripts\mp\gametypes\dmz_ai;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\perks\perks;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\utility\connect_event_aggregator;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace br_gametype_resurgence;

function main() {
  level.var_cdc15ee14362fbf = &scripts\mp\gametypes\br_gametype_resurgence::init;
  scripts\mp\gametypes\br::main();
}

function init() {
  function_528570ceb9dc7bf4();
  thread function_7269c88a927e7937();
  function_dbe2065974832286();
  level thread function_8af96d3889f46280();
  level thread function_d7a7aa9ee1cc1071();
  function_67caacec6ddd6a25();
  setdvarifuninitialized(@ "hash_98fad011285f3011", 0);
  setdvarifuninitialized(@ "scr_br_project_kick", 2000);

  setdevdvarifuninitialized(@ "hash_5a1dae481ef5d089", 0);
}

function initloadouts(table, forcereset) {
  if(!isDefined(level.var_c04b5edf3f9ea340) || istrue(forcereset)) {
    level.var_c04b5edf3f9ea340 = [];
  }

  newloadoutindex = level.var_c04b5edf3f9ea340.size;
  var_7d958726e11b327 = scripts\mp\class::function_df2933f96d726d71(table);
  level.var_c04b5edf3f9ea340[newloadoutindex] = [];

  for(classindex = 0; classindex < var_7d958726e11b327; classindex++) {
    level.var_c04b5edf3f9ea340[newloadoutindex][level.var_c04b5edf3f9ea340[newloadoutindex].size] = function_aa8a954d66bf39b4(classindex, table);
  }

  level.var_77c121d31e587ba8 = [];

  foreach(circleindex, circleloadout in level.var_c04b5edf3f9ea340) {
    if(isDefined(level.var_c04b5edf3f9ea340[circleindex]) && level.var_c04b5edf3f9ea340[circleindex].size > 0) {
      level.var_77c121d31e587ba8[circleindex] = randomintrange(0, level.var_c04b5edf3f9ea340[circleindex].size);
    }
  }
}

function function_aa8a954d66bf39b4(classindex, table) {
  var_cfa6985254954fb3 = scripts\mp\class::function_c7a0b640c398497(table, classindex);
  loadout["loadoutArchetype"] = "archetype_assault";
  loadout["loadoutPrimary"] = var_cfa6985254954fb3.primaryweapon.weapon;
  loadout["loadoutPrimaryAttachment"] = var_cfa6985254954fb3.primaryweapon.attachment1;
  loadout["loadoutPrimaryAttachment2"] = var_cfa6985254954fb3.primaryweapon.attachment2;
  loadout["loadoutPrimaryAttachment3"] = var_cfa6985254954fb3.primaryweapon.attachment3;
  loadout["loadoutPrimaryAttachment4"] = var_cfa6985254954fb3.primaryweapon.attachment4;
  loadout["loadoutPrimaryAttachment5"] = var_cfa6985254954fb3.primaryweapon.attachment5;
  loadout["loadoutPrimaryCamo"] = var_cfa6985254954fb3.primaryweapon.camo;
  loadout["loadoutPrimaryReticle"] = var_cfa6985254954fb3.primaryweapon.reticle;
  loadout["loadoutSecondary"] = var_cfa6985254954fb3.secondaryweapon.weapon;
  loadout["loadoutSecondaryAttachment"] = var_cfa6985254954fb3.secondaryweapon.attachment1;
  loadout["loadoutSecondaryAttachment2"] = var_cfa6985254954fb3.secondaryweapon.attachment2;
  loadout["loadoutSecondaryAttachment3"] = var_cfa6985254954fb3.secondaryweapon.attachment3;
  loadout["loadoutSecondaryAttachment4"] = var_cfa6985254954fb3.secondaryweapon.attachment4;
  loadout["loadoutSecondaryAttachment5"] = var_cfa6985254954fb3.secondaryweapon.attachment5;
  loadout["loadoutSecondaryCamo"] = var_cfa6985254954fb3.secondaryweapon.camo;
  loadout["loadoutSecondaryReticle"] = var_cfa6985254954fb3.secondaryweapon.reticle;
  loadout["loadoutMeleeSlot"] = "none";
  loadout["loadoutEquipmentPrimary"] = var_cfa6985254954fb3.equipment.primary;
  loadout["loadoutEquipmentSecondary"] = var_cfa6985254954fb3.equipment.secondary;
  loadout["loadoutStreakType"] = "assault";
  loadout["loadoutKillstreak1"] = "none";
  loadout["loadoutKillstreak2"] = "none";
  loadout["loadoutKillstreak3"] = "none";
  loadout["loadoutSuper"] = "super_br_extract";
  loadout["loadoutPerks"] = [var_cfa6985254954fb3.perks.perk1, var_cfa6985254954fb3.perks.perk2, var_cfa6985254954fb3.perks.perk3, var_cfa6985254954fb3.extraperks.perk1, var_cfa6985254954fb3.extraperks.perk2, var_cfa6985254954fb3.extraperks.perk3];
  loadout["loadoutGesture"] = "playerData";
  loadout["tableColumn"] = classindex;
  return loadout;
}

function function_d7a7aa9ee1cc1071() {
  level.brgametype.var_8e52126aeaaf8ab8 = scripts\cp_mp\utility\game_utility::function_17314ce12820727a(level.gametypebundle.var_4c371bf313812c95);
  setomnvar("ui_br_resurgence_respawn_enabled", 1);

  if(getdvarint(@ "hash_b06743df480e3bb6", 0) == 1) {
    function_e793259b8f9d5b2d();
  } else {
    scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("circleTimer", &circletimer);
  }

  level.brgametype.issolos = scripts\cp_mp\utility\game_utility::function_4fb37368ae3585bb() == 1;
  level.brgametype.var_9524142eb719a321 = !istrue(level.brgametype.var_b43745b85f249e68) && getdvarint(@ "hash_13ba9ee48d08ee48", 1) == 1;
  level.brgametype.var_bb9b77186cb79ae6 = getdvarint(@ "hash_f1ef637b3ab006fb", 1) == 1;
  level.brgametype.var_bbde847aed85512a = !level.brgametype.issolos && !istrue(level.brgametype.var_b43745b85f249e68) && getdvarint(@ "hash_effcc0523bc99bb9", 1) == 1;
  level.brgametype.var_836c1fc36b00559d = getdvarint(@ "hash_dddfb37f0d106b0f", 1) == 1;
  level.brgametype.var_574951d2eff9c094 = !level.brgametype.issolos && getdvarint(@ "hash_5a17d3c422c65887", 0) == 1;
  level.brgametype.var_36dbca9d337b4930 = getdvarint(@ "hash_7f1cabf5a72f2647", 1) == 1;
  level.brgametype.var_8947d8f4e61494fa = getdvarint(@ "hash_4abdfd8d72cdf072", 1) == 1 && level.brgametype.var_bb9b77186cb79ae6;
  level.brgametype.var_fb997d1846bd5cf4 = getdvarint(@ "hash_fb2c9f57e35f736", 1) == 1 && level.brgametype.var_9524142eb719a321;

  scripts\engine\utility::registersharedfunc("<dev string:x1c>", "<dev string:x2a>", &function_98609987fbc9bcc3);

  if(level.brgametype.var_bbde847aed85512a) {
    level.brgametype.var_523779ad4c01fd7c = getdvarint(@ "hash_d514b6128f4be10d", 1) == 1;
    level.brgametype.var_f8da748df2368691 = getdvarint(@ "hash_23641e104db7afc6", 3);
    level.brgametype.var_8f48d3f93ac1204c = getdvarint(@ "hash_bce5ae6c10bb74cb", 60);
    level.brgametype.var_74427b8346a538df = getdvarint(@ "hash_8aacc13e4663f7e5", 15);
  }

  function_e30bfec8b3d65b77();
  level.brgametype.var_6420b42c7add53cc = getdvarint(@ "hash_d2891d4180de0553", 1);
  level.brgametype.var_840b848760f488a4 = getdvarint(@ "hash_96c8e4682ff85b5f", 0);
  level.brgametype.var_428c736511619824 = getdvarfloat(@ "scr_br_tracked_teams_clear_delay", 2.5);
  level.brgametype.var_6ee71092be57820c = getdvarfloat(@ "hash_8217b0dfa2d04c31", 10);
  level.brgametype.usevengeance = getmatchrulesdata("brData", "resurgenceUseVengeance");
  level.brgametype.vengeanceuseanykill = getmatchrulesdata("brData", "resurgenceVengeanceUseAnyKill");
  level.brgametype.usevengeancedecreaserespawntimer = getmatchrulesdata("brData", "resurgenceUseVengeanceDecreaseRespawnTimer");
  level.brgametype.usepointstoreducerespawntime = getmatchrulesdata("brData", "resurgenceUsePointsToReduceRespawnTime");
  level.respawnheightoverride = getdvarint(@ "scr_bmo_respawnheightoverride", 7500);
  level.brgametype.var_2cfdc1d6e92251bf = getmatchrulesdata("brData", "resurgenceVengeanceDecreaseRespawnDelay");
  level.brgametype.var_b30e180b0b50d598 = getdvarint(@ "hash_5dc7ba56c5253ee8", 1);
  level.brgametype.var_14afb82aa29bc57c = getdvarint(@ "hash_77028b51cd3d0a56", -1);
  level.brgametype.var_f439c17a413f05c3 = getdvarint(@ "hash_e77b23156a69cbc1", 1) == 1;
  level.brgametype.var_b8a3736f232f201a = level.brgametype.var_8e52126aeaaf8ab8.var_48ac18e1bc53712b.movedist;
  level.brgametype.var_4af675f2894744ae = squared(level.brgametype.var_b8a3736f232f201a);
  level.brgametype.var_76ba167fab191869 = level.brgametype.var_8e52126aeaaf8ab8.var_48ac18e1bc53712b.var_a5db0b3d50ceba8e;
  level.brgametype.var_4c9d8cddc19303ed = squared(level.brgametype.var_76ba167fab191869);
  level.brgametype.var_a11c00bd12593a72 = getdvarfloat(@ "hash_7652a62713e7e3d", 15);
  level.brgametype.var_cf8a4ef13ed2f5ba = getdvarint(@ "hash_ed51351f11220d40", 1) == 1;

  if(level.brgametype.var_cf8a4ef13ed2f5ba) {
    function_213349d38bdbacc7();
  }

  level.brgametype.var_f9623a041e743669 = level.brgametype.var_f439c17a413f05c3 && getdvarint(@ "hash_4c1efe20b495c492", 0) == 1;

  if(level.brgametype.var_f9623a041e743669) {
    level.brgametype.var_87d4766b5816bbf5 = getdvarint(@ "hash_44552acab369e55b", 2);
    level.brgametype.var_3de07078c89e05f0 = getdvarint(@ "hash_a5958c5664ccb954", 3);
    level.brgametype.var_96e126d983a6bcb = getdvarint(@ "hash_5093e1a58adbb3ea", 4);
  }

  level.brgametype.var_4a73ad987e2857e1 = getdvarint(@ "hash_4d634ba058318a25", -1);
  level.brgametype.var_ed0962f69d72e5b1 = getdvarint(@ "hash_8a84225861f51e28", -1);
  level.brgametype.var_12d3d7f14586d634 = getdvarint(@ "hash_129e6244045a81b6", -1);
  level.brgametype.var_dd674d15153f7aab = getdvarint(@ "hash_85db29695ad16662", -1);
  level.brgametype.var_bc6456d93d2e9053 = getdvarint(@ "hash_717b2ab5fd9216df", -1);
  level.brgametype.var_a922c322aa7d8e27 = getdvarint(@ "hash_59be9f022aae99b1", -1);
  level.brgametype.var_dca0e6fef4e95fa9 = getdvarint(@ "hash_c11e2240978a14ab", -1);
  level.brgametype.var_4a10a8dd79fb5ab4 = getdvarint(@ "hash_4f0bcedaa99a517f", -1);
  level.brgametype.var_a8ffbf7c6f0e152b = getdvarint(@ "hash_398cc06dc285f5b6", -1);
  level.brgametype.var_53911fa2d60ccb40 = getdvarint(@ "hash_4928f88cf598f176", -1);
  level.brgametype.var_79155a61db265b6e = getdvarint(@ "hash_b49ec960bcba14bc", -1);
  level.brgametype.var_e3c11803759b1678 = getdvarint(@ "hash_76fa3ffc4eb3f38c", -1);
  level.brgametype.var_eac57b0b307ab1ef = getdvarint(@ "hash_af651e107ec02598", -1);
  level.brgametype.aircraftmaxallowed = getdvarfloat(@ "hash_6772e6c744d1d962", 30);
  level.brgametype.var_59af2e5140d3fed7 = getdvarfloat(@ "hash_e9b60187d57107b9", 1);
  level.brgametype.var_a916b204f027af6b = getdvarint(@ "hash_a91b489383d89274", 0);
  level.brgametype.var_6f3c4d74a8c614ab = getdvarint(@ "hash_38aff65bda44b82a", 1);
  level.brgametype.var_be0c10911fec189f = 1;
  level.brgametype.resurgencepoi_militarybase = getdvarint(@ "hash_6072057c2f747227", 0);
  level.brgametype.resurgencepoi_popovpower = getdvarint(@ "hash_268ddaf57143b953", 0);
  level.brgametype.resurgencepoi_suburbs = getdvarint(@ "hash_1d4ec9141e6b4a64", 0);
  level.brgametype.resurgencepoi_superstore = getdvarint(@ "hash_8a8ca71828503aba", 0);
  level.brgametype.var_3fc59bce0c73b8cf = getdvarint(@ "hash_25f058368af3bc5a", 400);
  level.brgametype.var_eaa971da207c8bb5 = getdvarint(@ "hash_590ae68d2c03b69b", 5);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("mayConsiderPlayerDead", &function_411af8132ca77d3a);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("triggerRespawnOverlay", &function_2e712bc64fde7);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerNakedDropLoadout", &function_6ab3fa08604ded12);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("getDefaultLoadout", &function_b0fc27ec6e239628);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerDropBonuses", &function_decd4293c451c70);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerKilledSpawn", &function_f99a079543f11bf7);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("markPlayerAsEliminatedOnKilled", &function_4001b05bdb048819);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("assignLastStandAttacker", &function_f39fa02f6ed912fc);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("kioskRevivePlayer", &function_f9a2b6ae09e7a00);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("dropOnPlayerDeath", &function_59e26a5b68b2b39a);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("vipRespawnPlayer", &function_f9d21088ed2c3306);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onPlayerKilled", &function_277c5d414a129608);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("getPlacementXPShareValues", &function_b0bb8889afbb0c83);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("getBRBonusXPperMillisecond", &function_843d05502816cbce);
  waittillframeend();

  if(level.brgametype.usepointstoreducerespawntime) {
    level.var_5dfd73c97bf5d03d = &function_3709903d7ad3f711;
  }

  thread function_c3aa670d2773db51();
  thread function_aa202a5e20886406();
  thread function_9f61893413e0093c();
  thread function_3ee5f100eb900caf();
  thread function_809485f51d59ebb();
  thread function_797b21b78b5e0a26();
  thread function_4f5568cf15d60b8();
  thread function_90507e372a40c684();
  thread function_22ef1cd58a8d87e8();
  thread namespace_fc28fc5402338af6::init();
  scripts\mp\utility\connect_event_aggregator::registeronconnectcallback(&function_f13ec0f9fbe36171);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&function_7ea88dd9bc483463);
  thread function_81baad6d96ff2130();
}

function function_e30bfec8b3d65b77() {
  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("initResurgenceLoadouts")) {
    scripts\mp\gametypes\br_gametypes::runbrgametypefunc("initResurgenceLoadouts");
    return;
  }

  initloadouts("classtable:classtable_br_resurgence");
  initloadouts("classtable:classtable_br_resurgence_circle2");
  initloadouts("classtable:classtable_br_resurgence_circle3");
}

function function_528570ceb9dc7bf4() {
  if(getdvarint(@ "hash_5a1dae481ef5d089", 0) == 1) {
    scripts\mp\gametypes\br_gametypes::enablefeature("allowLateJoiners");
  }

  scripts\mp\gametypes\br_gametypes::disablefeature("gulag");
  scripts\mp\gametypes\br_gametypes::disablefeature("randomizeCircleCenter");

  if(getdvarint(@ "hash_32bd10766631266f", 0) != 0) {
    if(getdvarint(@ "hash_6a54f6ff93e297ba", 1) == 1) {
      scripts\mp\gametypes\br_gametypes::disablefeature("planeSnapToOOB");
    }

    scripts\mp\gametypes\br_gametypes::enablefeature("planeUseCircleRadius");
    scripts\mp\gametypes\br_gametypes::enablefeature("circleEarlyStart");
  }

  scripts\mp\gametypes\br_gametypes::enablefeature("infilParachuteVfx");
}

function function_67caacec6ddd6a25() {
  scripts\mp\gametypes\br_ai_encounters::init();

  if(istrue(level.brgametype.var_8e52126aeaaf8ab8.var_3be45bb85d4a5df0)) {
    level.var_428703950599c9e9 = &scripts\mp\gametypes\dmz_ai::function_428703950599c9e9;
    level thread namespace_43bf74a2ee9234c0::function_7f4d3080c6e8748b();
    level thread scripts\mp\ai_heli_reinforce::function_d0ffcd08e0870cf2();
    level thread namespace_885300a47c2b51e6::function_ca39a413ace3c168();
    scripts\engine\utility::registersharedfunc("paraReinforce", "onChutePull", &namespace_885300a47c2b51e6::function_6a8ad55c5a4036d1);
  }
}

function function_8af96d3889f46280() {
  scripts\engine\utility::registersharedfunc("resurgence", "packClientMatchData", &function_ece0d8ae46d230c8);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerWelcomeSplashes", &playerwelcomesplashes);
  level.brgametype.var_396232b093a1fb3d = getdvarint(@ "hash_77bbf25011ef743c", 1);
  level.brgametype.var_34555edfbd2e0e3a = [ &namespace_1eb3c4e0e28fac71::function_40cb2b7beb4efff1];

  if(level.brgametype.var_396232b093a1fb3d) {
    scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("getContractManagerFilter", &function_635472137de2fc6a);
  }

  waittillframeend();

  if(getdvarint(@ "hash_32bd10766631266f", 0) != 0 || getdvarint(@ "hash_6c0e9a2ac5ece4b5", 1)) {
    scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("createC130PathStruct", &function_38a46a469c73dc2c);
    scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("addToC130Infil", &function_c338e39db41d9374);

    if(getdvarint(@ "hash_bb3cfa989a77b2c5", 1) == 1) {
      function_10870c1a437402b();
    }
  }

  if(getdvarint(@ "hash_82dd678ebec737e0", 0) == 1) {
    level thread function_9680317afd0e4558();
  }

  level thread function_721a7410f27c2d8f();

  level.ontimelimit = &function_60a9f05beb5e480;
  function_171e7f7d10b8131();

  if(getdvarint(@ "hash_b3eb77522192e559", 1) != 0) {
    scripts\mp\gametypes\br_circle::registercirclecallbacks(13, undefined, undefined, undefined, &function_cee78f828e373996);
  }
}

function function_cee78f828e373996() {
  level.br_circle.dangercircleui.origin = scripts\mp\gametypes\br_circle::getdangercircleorigin() + (0, 0, scripts\mp\gametypes\br_circle::getdangercircleradius());
  scripts\mp\gametypes\br_circle::setstaticuicircles(500, level.br_circle.safecircleui, level.br_circle.dangercircleui, 0);
}

function function_b79b55c5a0aaa08(player_ref, state, missionid, var_c08e41851ed100e8) {
  player = player_ref getentitynumber();

  if(!isDefined(state)) {
    state = 0;
  }

  if(!isDefined(player)) {
    player = 0;
  }

  if(!isDefined(missionid)) {
    missionid = 0;
  }

  statebits = 4;
  playershift = statebits;
  playerbits = 8;
  var_d8354a49cc36aa44 = playershift + playerbits;
  var_d950a79d86f32708 = 16;
  var_d5f8c4084a83331b = 0;
  var_3faa24937366bd8c = var_d8354a49cc36aa44 + var_d950a79d86f32708;

  foreach(reviveplayer in var_c08e41851ed100e8) {
    var_d5f8c4084a83331b |= reviveplayer << var_3faa24937366bd8c;
    var_3faa24937366bd8c++;
  }

  value = 0;
  value = var_d5f8c4084a83331b | missionid << var_d8354a49cc36aa44 | player << playershift | state;
  self setclientomnvar("ui_br_expanded_obit_message", value);
}

function function_4bb3153d2bc88c04(team, player_ref, state, missionid, var_c08e41851ed100e8) {
  foreach(player in getteamdata(team, "players")) {
    player function_b79b55c5a0aaa08(player_ref, state, missionid, var_c08e41851ed100e8);
  }
}

function function_5367b756a0eeb9db(attacker, killedtarget, var_73cacd5a645aab1f) {
  if(getdvarint(@ "hash_5b0a580d2ed6f60e", 1) == 0) {
    return;
  }

  killedtargetentnum = killedtarget getentitynumber();
  attackerentnum = attacker getentitynumber();
  var_af9cbb6cb7344131 = [];
  index = 1;
  teamplayers = getteamdata(level.players[attackerentnum].team, "players");

  foreach(entry in teamplayers) {
    if(entry == level.players[attackerentnum]) {
      var_af9cbb6cb7344131[index] = 0;
      index++;
      continue;
    }

    var_af9cbb6cb7344131[index] = 0;

    foreach(playerrevived in var_73cacd5a645aab1f) {
      if(entry == playerrevived) {
        var_af9cbb6cb7344131[index] = 1;
        break;
      }
    }

    index++;
  }

  for(var_ac61d946afdba08b = index; var_ac61d946afdba08b < 4; var_ac61d946afdba08b++) {
    var_af9cbb6cb7344131[var_ac61d946afdba08b] = 0;
  }

  function_4bb3153d2bc88c04(level.players[attackerentnum].team, level.players[attackerentnum], 15, killedtargetentnum, var_af9cbb6cb7344131);
}

function function_7269c88a927e7937() {
  level endon("game_ended");
  waitframe();
  game["dialog"]["match_start"] = "rsrg_grav_gmtr";
  game["dialog"]["primary_objective_solo"] = "rsrg_grav_rdsl";
  game["dialog"]["primary_objective"] = "rsrg_grav_gmdr";
  game["dialog"]["resurgence_redeploy"] = "rsrg_grav_rdpl";
  game["dialog"]["resurgence_disabled"] = "rsrg_grav_rnfd";
  game["dialog"]["resurgence_ending"] = "rsrg_grav_rnfn";
  game["dialog"]["last_man_standing"] = "rsrg_grav_rsla";
  game["dialog"]["resurgence_avenge_teammate"] = "rsrg_grav_vngt";
  game["dialog"]["resurgence_teammate_respawn"] = "rsrg_grav_tmrs";
  game["dialog"]["resurgence_hunt_reminder"] = "rsrg_grav_hnsp";
  game["dialog"]["resurgence_on_player_disconnect"] = "rsrg_grav_tmrd";
}

function function_683452dfa2b09ccd() {
  game["dialog"]["last_man_standing"] = "rsrg_grav_rnfd";
}

function function_171e7f7d10b8131() {
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("me_electrical_box_street_01", 1);
}

function function_c3aa670d2773db51() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level.brgametype.respawnenable = 1;
  level.var_843573804b98eb7e = 1;
}

function function_aa202a5e20886406() {
  waittillframeend();
  allteam = level.allteamnamelist;

  foreach(index, team in allteam) {
    level.teamdata[team]["index"] = index;
  }

  if(istrue(level.brgametype.var_840b848760f488a4)) {
    foreach(name, team in level.teamdata) {
      level.teamdata[name]["trackedTeams"] = [];
    }

    return;
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  foreach(player in level.players) {
    player.trackedteams = [];
  }
}

function function_9f61893413e0093c() {
  foreach(name, team in level.teamdata) {
    level.teamdata[name]["deadPlayers"] = [];
  }

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    player.waskilledby = [];
  }
}

function function_60a9f05beb5e480() {
  if(isDefined(level.numendgame)) {
    level thread scripts\mp\gametypes\br::startendgame(1);
  }

  level.numendgame = undefined;
}

function function_411af8132ca77d3a(player) {
  if(scripts\mp\flags::gameflag("prematch_done") && scripts\mp\flags::gameflag("prematch_fade_done")) {
    result = namespace_95d8d8ec67e3e074::function_fb4771e79218146b(player);

    if(isDefined(result)) {
      return result;
    }

    if(istrue(player.issolo)) {
      return function_afb309407c44fc11(player);
    } else {
      return function_c76781b1d95bb338(player);
    }
  }

  return 1;
}

function function_c76781b1d95bb338(player) {
  if(scripts\mp\gametypes\br_public::hasrespawntoken() && !scripts\mp\gametypes\br_pickups::respawntokendisabled()) {
    player function_f9a2b6ae09e7a00(undefined, 1);
    return false;
  }

  player thread function_b1dfe6c6434fc16c();
  return true;
}

function function_afb309407c44fc11(player) {
  if(scripts\mp\gametypes\br_public::hasrespawntoken() && !scripts\mp\gametypes\br_pickups::respawntokendisabled()) {
    player.respawndelay = 0;
    player.respawngranted = 1;
    player scripts\mp\gametypes\br_pickups::removerespawntoken();
    return false;
  } else if(istrue(level.brgametype.respawnenable) || istrue(self.var_8a52130c321aa8a)) {
    if(!isDefined(player.respawndelay)) {
      player.respawndelay = 0;
    }

    if(player.respawndelay <= 0) {
      player.respawngranted = 1;
      return false;
    }
  }

  player function_bbee565c7645ea29();
  player notify("squad_wiped");
  return true;
}

function function_2ffb02751eba32df(deadplayer) {
  if(istrue(level.brgametype.var_b43745b85f249e68)) {
    return;
  }

  if(!istrue(level.brgametype.respawnenable)) {
    return;
  }

  foreach(player in getteamdata(deadplayer.team, "players")) {
    if(!istrue(player.var_6f75c711f7773c67) && isalive(player) && deadplayer != player) {
      player.var_6f75c711f7773c67 = 1;
      player thread scripts\mp\hud_message::showsplash("br_resurgence_first_dead_improvement", undefined, undefined, undefined, undefined, "splash_list_iw9_br_resurgence_mp");
    }
  }
}

function function_ece0d8ae46d230c8() {
  if(!isDefined(self.var_9efaa5d4f566b9d8)) {
    self.var_9efaa5d4f566b9d8 = 0;
  }

  packedvalue = self.var_9efaa5d4f566b9d8;

  if(packedvalue > 255) {
    packedvalue = 255;
  }

  self.extrascore0 = packedvalue;
  self.pers["extrascore0"] = packedvalue;
  missionvalue = 0;

  if(isDefined(self.brmissionscompleted)) {
    missionvalue += self.brmissionscompleted;
  }

  if(missionvalue > 15) {
    missionvalue = 15;
  }

  packedvalue += missionvalue << 8;
  return packedvalue;
}

function function_fb9ed4b8a0e55bfc(teamdata, var_75c8cc005e7e9f3) {
  if(scripts\mp\gametypes\br_gametypes::isfeaturedisabled("registerReviveCount")) {
    return;
  }

  if(!istrue(self.issolo)) {
    var_2f945dac0cd1edcb = !istrue(level.teamdata[self.team]["teamHadFirstRevive"]);

    if(var_2f945dac0cd1edcb) {
      level.teamdata[self.team]["teamHadFirstRevive"] = 1;
    }

    foreach(aliveteammate in teamdata) {
      if(isDefined(aliveteammate) && !isDefined(aliveteammate.var_9efaa5d4f566b9d8)) {
        aliveteammate.var_9efaa5d4f566b9d8 = 0;
      }

      aliveteammate.var_9efaa5d4f566b9d8++;
      aliveteammate scripts\mp\gametypes\br_public::updatebrscoreboardstat("reviveCount", aliveteammate.var_9efaa5d4f566b9d8);
      aliveteammate function_ece0d8ae46d230c8();
      var_75a087e96d31ddc5 = !isDefined(var_75c8cc005e7e9f3) || aliveteammate != var_75c8cc005e7e9f3;
      var_4b59e709fd5bcc45 = var_2f945dac0cd1edcb && var_75a087e96d31ddc5;

      if(var_4b59e709fd5bcc45) {
        aliveteammate thread scripts\mp\hud_message::showsplash("br_resurgence_first_revive_improvement", undefined, undefined, undefined, undefined, "splash_list_iw9_br_resurgence_mp");
      }
    }

    return;
  }

  if(!isDefined(self.var_9efaa5d4f566b9d8)) {
    self.var_9efaa5d4f566b9d8 = 0;
  }

  self.var_9efaa5d4f566b9d8++;
  scripts\mp\gametypes\br_public::updatebrscoreboardstat("reviveCount", self.var_9efaa5d4f566b9d8);
}

function function_4001b05bdb048819() {
  hasforcerespawn = istrue(self.var_8a52130c321aa8a);
  self.var_8a52130c321aa8a = undefined;

  if(!istrue(self.issolo)) {
    return true;
  }

  var_838d3619fb1ff27b = isDefined(self.respawndelay) && self.respawndelay > 0;
  return scripts\mp\flags::gameflag("prematch_fade_done") && (var_838d3619fb1ff27b || !istrue(level.brgametype.respawnenable) && !hasforcerespawn);
}

function function_f9d21088ed2c3306(var_84e2123aaca9a965) {
  if(isalive(self)) {
    return;
  }

  function_f9a2b6ae09e7a00(var_84e2123aaca9a965);
}

function function_f9a2b6ae09e7a00(var_84e2123aaca9a965, tokenused) {
  if(istrue(self.issolo)) {
    return;
  }

  var_c7869d69dbcf7fd3 = self;
  var_c7869d69dbcf7fd3 thread scripts\mp\gametypes\br_gulag::playergulagautowin("resurgenceEarlyRevive", var_84e2123aaca9a965, tokenused);
  var_c7869d69dbcf7fd3 function_fb9ed4b8a0e55bfc(level.teamdata[var_c7869d69dbcf7fd3.team]["alivePlayers"], var_84e2123aaca9a965);
  function_c3c91f0dfbf4f683();
}

function function_59e26a5b68b2b39a(attacker) {
  if(istrue(level.brgametype.var_574951d2eff9c094) || istrue(level.brgametype.loadoutrestore) && !isDefined(self.savedloadout)) {
    scripts\mp\gametypes\br::function_10ffa1071b1c2681();
  }

  if(istrue(self.issolo)) {
    return;
  }

  return 0;
}

function function_277c5d414a129608(deathdata) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }

  if(level.gameended) {
    return;
  }

  if(!isDefined(deathdata.victim)) {
    return;
  }

  thread scripts\mp\gametypes\br_gametypes::runbrgametypefunc("preOnPlayerKilled", deathdata);
  thread function_2ffb02751eba32df(deathdata.victim);

  if(!isDefined(deathdata.attacker) || !isPlayer(deathdata.attacker) || deathdata.attacker == deathdata.victim) {
    if(!istrue(deathdata.victim.issolo)) {
      function_28fe2aed2424b8f(deathdata.victim);
    }

    return;
  }

  if(istrue(level.brgametype.var_f9623a041e743669)) {
    deathdata.victim.var_3b90a1ee7a57f5b1 = undefined;
    deathdata.victim.obtainedperks = 0;
  }

  alivecount = getteamdata(deathdata.attacker.team, "aliveCount");

  if(alivecount <= 0) {
    return;
  }

  deathdata.attacker function_266b9fb5e9453ef1(deathdata.victim);
  deathdata.attacker function_2a897cd68a200cb2();
  deathdata.attacker function_1ee2942f2a3ba7b();
  function_60f89ea387e4fd31(deathdata.victim);
  deathdata.victim thread function_183e83cf14bfeb7a(deathdata.attacker);

  if(istrue(deathdata.victim.issolo)) {
    function_140be6f794c627c9(deathdata);

    if(!isDefined(deathdata.victim.waskilledby)) {
      deathdata.victim.waskilledby = [];
    }

    if(!array_contains(deathdata.victim.waskilledby, deathdata.attacker)) {
      array_add(deathdata.victim.waskilledby, deathdata.attacker);
    }

    deathdata.attacker thread function_d17aa77ca39e8d00(deathdata.victim);
    deathdata.attacker thread function_d0262f6a0c49edbb(deathdata.victim);
  } else {
    deathdata.attacker function_778d96c94679909c(deathdata.attacker.team, deathdata.victim.team);
    function_28fe2aed2424b8f(deathdata.victim);
  }

  if(istrue(deathdata.attacker.issolo)) {
    deathdata.attacker thread function_2c7bb4c045e81497(deathdata.victim);
  } else {
    deathdata.attacker thread function_8cc833b706d330bf(deathdata.attacker.team, deathdata.victim);
  }

  deathdata.attacker thread function_2d3b9a726feb5dc2(deathdata.attacker.team, deathdata.objweapon);
}

function function_28fe2aed2424b8f(victim) {
  victim.var_9470762801d7ebd9 = 0;

  if(!istrue(level.brgametype.var_f439c17a413f05c3)) {
    return;
  }

  if(!istrue(level.brgametype.respawnenable)) {
    return;
  }

  foreach(player in getteamdata(victim.team, "players")) {
    if(!istrue(player.var_9470762801d7ebd9)) {
      player thread function_5a5bb23fc0b48595();
    }
  }
}

function function_5a5bb23fc0b48595() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self.var_9470762801d7ebd9 = 1;

  while(!isalive(self) || !self isonground() && !self isswimming() && !scripts\cp_mp\utility\player_utility::isinvehicle()) {
    wait 1;
  }

  self.var_9470762801d7ebd9 = function_240527b0a85a24b();
  self.var_3a570a6d7cea7826 = self.origin;
  self.var_bfba4165ebae7169 = 0;

  if(scripts\cp_mp\utility\player_utility::isinvehicle()) {
    self.var_b3d3d6102f5b1bcb = 1;
    self.var_42bd6dc51ab8c2b0 = level.brgametype.var_76ba167fab191869;
    self.var_71359c6a4ceab6d1 = level.brgametype.var_4c9d8cddc19303ed;
  } else {
    self.var_b3d3d6102f5b1bcb = 0;
    self.var_42bd6dc51ab8c2b0 = level.brgametype.var_b8a3736f232f201a;
    self.var_71359c6a4ceab6d1 = level.brgametype.var_4af675f2894744ae;
  }

  while(istrue(self.var_9470762801d7ebd9)) {
    playerinvehicle = scripts\cp_mp\utility\player_utility::isinvehicle();

    if(self.var_b3d3d6102f5b1bcb != playerinvehicle) {
      self.var_b3d3d6102f5b1bcb = playerinvehicle;
      var_234f5a6c3524f185 = distance2d(self.var_3a570a6d7cea7826, self.origin);
      var_41668e7944a5e5e = ter_op(playerinvehicle, level.brgametype.var_76ba167fab191869, level.brgametype.var_b8a3736f232f201a);
      self.var_bfba4165ebae7169 = var_234f5a6c3524f185 / self.var_42bd6dc51ab8c2b0;
      self.var_42bd6dc51ab8c2b0 = var_234f5a6c3524f185 + (1 - self.var_bfba4165ebae7169) * var_41668e7944a5e5e;
      self.var_71359c6a4ceab6d1 = squared(self.var_42bd6dc51ab8c2b0);
    }

    if(distance2dsquared(self.var_3a570a6d7cea7826, self.origin) > self.var_71359c6a4ceab6d1) {
      scripts\mp\utility\points::doscoreevent(#"resurgence_on_the_move");
      self.var_3a570a6d7cea7826 = self.origin;
    }

    wait 1;
    self.var_9470762801d7ebd9 = function_240527b0a85a24b();
  }
}

function function_240527b0a85a24b() {
  foreach(player in level.teamdata[self.team]["players"]) {
    if(!isalive(player) && !istrue(player.var_632bad3edb4e449e)) {
      return true;
    }
  }

  return false;
}

function function_778d96c94679909c(trackerteam, trackedteam) {
  if(!level.brgametype.var_6420b42c7add53cc) {
    return;
  }

  function_63c057f27dc906b5(trackerteam, trackedteam, level.brgametype.var_428c736511619824);
}

function function_8cc833b706d330bf(team, potentialkiller) {
  level endon("game_ended");

  if(!level.brgametype.usevengeance) {
    return;
  }

  if(!istrue(level.brgametype.respawnenable)) {
    return;
  }

  alivecount = getteamdata(team, "aliveCount");

  if(alivecount <= 0) {
    return;
  }

  var_d0b996fde8bfc937 = level.teamdata[team]["deadPlayers"];

  if(var_d0b996fde8bfc937.size <= 0) {
    return;
  }

  var_4e776a22240ff174 = function_d99ec654fcd96cc6(var_d0b996fde8bfc937, potentialkiller);
  function_ffcd45c1b7a5355a(var_4e776a22240ff174, potentialkiller);
}

function function_d99ec654fcd96cc6(var_d0b996fde8bfc937, potentialkiller) {
  var_4e776a22240ff174 = [];

  if(istrue(level.brgametype.vengeanceuseanykill)) {
    foreach(item in var_d0b996fde8bfc937) {
      if(!isDefined(item)) {
        continue;
      }

      var_4e776a22240ff174 = array_add(var_4e776a22240ff174, item);
      break;
    }
  } else {
    foreach(item in var_d0b996fde8bfc937) {
      if(!isDefined(item)) {
        continue;
      }

      if(isDefined(item.killer) && item.killer == potentialkiller && isDefined(item.player)) {
        var_4e776a22240ff174 = array_add(var_4e776a22240ff174, item.player);
      }
    }
  }

  return var_4e776a22240ff174;
}

function function_2d3b9a726feb5dc2(team, weaponused) {
  level endon("game_ended");

  switch (weaponused.basename) {
    case #"hash_97a0f357d729e163":
      if(!istrue(level.brgametype.var_b7b9228fd4af172f)) {
        return;
      }

      deadteammates = level.teamdata[team]["deadPlayers"];

      if(deadteammates.size <= 0) {
        return;
      }

      assert(isDefined(level.brgametype.var_9ecf3b1626f1599a), "<dev string:x3c>");
      function_366c394e9dc1e32d(self, level.brgametype.var_9ecf3b1626f1599a);
      break;
    default:
      return;
  }
}

function function_a045bcdb0d1bebf9(victim, attacker) {
  if(isDefined(attacker) && (!isDefined(victim) || victim != attacker || isDefined(victim.team) && victim.team != attacker.team)) {
    attacker scripts\mp\utility\points::doscoreevent(#"resurgence_armor_break");
  }
}

function function_266b9fb5e9453ef1(victim) {
  if(!istrue(level.brgametype.var_f439c17a413f05c3)) {
    return;
  }

  if(!isDefined(self.var_f968dc3adf6c967e)) {
    self.var_f968dc3adf6c967e = [];
    return;
  }

  trackedteams = function_f6686365221e78cb();
  trackedteamindex = function_85fee305e2d829c1(trackedteams, victim.team);

  if(trackedteamindex < 0 || trackedteamindex >= 4) {
    return;
  }

  trackedteam = trackedteams[trackedteamindex];
  nowtime = gettime();
  elapsedtime = nowtime - trackedteam["startTime"];

  if(elapsedtime < level.brgametype.var_a11c00bd12593a72 * 1000) {
    if(isDefined(self.var_f968dc3adf6c967e[victim.team])) {
      self.var_f968dc3adf6c967e[victim.team]++;
    } else {
      self.var_f968dc3adf6c967e[victim.team] = 1;
    }

    function_4e3aa4dbe97c98c4(victim);
    return;
  }

  self.var_f968dc3adf6c967e[victim.team] = undefined;
}

function function_4e3aa4dbe97c98c4(victim) {
  huntstreak = self.var_f968dc3adf6c967e[victim.team];

  if(huntstreak == 1) {
    scripts\mp\utility\points::doscoreevent(#"resurgence_hunter");
    return;
  }

  if(huntstreak == 2) {
    scripts\mp\utility\points::doscoreevent(#"resurgence_hunter_double");
    return;
  }

  scripts\mp\utility\points::doscoreevent(#"resurgence_hunter_spree");
}

function function_2a897cd68a200cb2() {
  if(!istrue(level.brgametype.var_f439c17a413f05c3) || istrue(self.issolo)) {
    return;
  }

  alivecount = getteamcount(self.team, 1);

  if(alivecount == 1) {
    scripts\mp\utility\points::doscoreevent(#"resurgence_fearless_kill");
  }
}

function function_1ee2942f2a3ba7b() {
  if(!istrue(level.brgametype.var_f9623a041e743669)) {
    return;
  }

  if(!isDefined(self.obtainedperks)) {
    self.obtainedperks = 0;
  }

  if(self.obtainedperks >= level.brgametype.var_96e126d983a6bcb) {
    return;
  }

  if(!isDefined(self.var_3b90a1ee7a57f5b1)) {
    self.var_3b90a1ee7a57f5b1 = level.brgametype.var_3b90a1ee7a57f5b1;
  }

  perktier = 1;

  if(self.obtainedperks >= level.brgametype.var_3de07078c89e05f0) {
    perktier = 3;
  } else if(self.obtainedperks >= level.brgametype.var_87d4766b5816bbf5) {
    perktier = 2;
  }

  newperk = undefined;
  hasperk = 1;

  while(hasperk && self.var_3b90a1ee7a57f5b1[perktier].size > 0) {
    newperk = random(self.var_3b90a1ee7a57f5b1[perktier]);
    hasperk = _hasperk(newperk);
    self.var_3b90a1ee7a57f5b1[perktier] = array_remove(self.var_3b90a1ee7a57f5b1[perktier], newperk);
  }

  if(!hasperk) {
    br_pickups::function_e8fc4167d33ed55d(newperk);
    self.obtainedperks++;
  }
}

function function_213349d38bdbacc7() {
  perkpackagelist = getscriptbundle("perkpackagelist:" + "perkpackagelist_wz").packages;
  var_80d47ea42b5b5224 = [];
  var_e1b3cae1b85922bd = ["jup_perkpackage_wz_specialist"];

  foreach(package in perkpackagelist) {
    if(isDefined(package.package) && !array_contains(var_e1b3cae1b85922bd, package.package)) {
      tokens = strtok(package.package, "_");
      packagename = tokens[tokens.size - 1];
      var_80d47ea42b5b5224[var_80d47ea42b5b5224.size] = packagename;
    }
  }

  level.brgametype.var_80d47ea42b5b5224 = var_80d47ea42b5b5224;
}

function function_60f89ea387e4fd31(victim) {
  if(!istrue(level.brgametype.var_cf8a4ef13ed2f5ba) || getteamdata(victim.team, "aliveCount") > 0) {
    return;
  }

  package = array_random(level.brgametype.var_80d47ea42b5b5224);
  dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
  droporigin = victim.origin;
  dropangles = victim.angles;
  dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, droporigin, dropangles, victim);
  lootitemname = "br_loot_perkpack_" + package + "_jup";
  itemdef = getscriptbundle("loot_item_def:" + lootitemname);

  if(isDefined(itemdef)) {
    scripts\mp\gametypes\br_pickups::spawnpickup(itemdef.name, dropinfo, 1, 1);
  }
}

function function_183e83cf14bfeb7a(nemesis) {
  if(!istrue(level.brgametype.var_36dbca9d337b4930) || !isDefined(nemesis) || !isPlayer(nemesis)) {
    return;
  }

  level endon("game_ended");
  teamplayers = getteamdata(self.team, "players");
  squadmemberindex = self.sessionuimemberindex;

  if(!isDefined(squadmemberindex) || squadmemberindex == -1) {
    return;
  }

  foreach(player in teamplayers) {
    if(isDefined(player)) {
      nemesisentnum = nemesis getentitynumber();
      assert(nemesisentnum < 255, "<dev string:x76>");
      nemesisvalue = int(clamp(nemesisentnum + 1, 1, 255));
      player scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc("ui_resurgence_team_nemeses", squadmemberindex * 8, 8, nemesisvalue);
    }
  }

  waittill_any_3("disconnect", "started_spawnPlayer", "avenged");

  foreach(player in teamplayers) {
    if(isDefined(player)) {
      player scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc("ui_resurgence_team_nemeses", squadmemberindex * 8, 8, 0);
    }
  }
}

function function_2c7bb4c045e81497(victim) {
  level endon("game_ended");

  if(!level.brgametype.usevengeance) {
    return;
  }

  if(!istrue(level.brgametype.respawnenable)) {
    return;
  }

  function_c86eefdaf13d0d81(victim);
}

function function_d0262f6a0c49edbb(victim) {
  level endon("game_ended");
  self endon("disconnect");
  victim endon("disconnect");
  victim endon("squad_wiped");

  if(!level.brgametype.var_6420b42c7add53cc) {
    return;
  }

  if(!isDefined(victim)) {
    return;
  }

  victim waittill("respawn_done");
  function_63c057f27dc906b5(self.team, victim.team, level.brgametype.var_6ee71092be57820c);
}

function function_d17aa77ca39e8d00(victim) {
  attacker = self;

  if(istrue(victim.br_iseliminated)) {
    attacker thread scripts\mp\events::killeventtextpopup("enemy_wiped", 0);
    attacker thread scripts\mp\utility\points::giveunifiedpoints("enemy_wiped", attacker.wipeweapon);
    attacker thread function_58d39d7db7e05d7a(victim);
  }
}

function function_58d39d7db7e05d7a(victim) {
  lastweapon = scripts\mp\gametypes\br::brchooselaststandweapon();
  scripts\mp\gametypes\br::teamwipedobituary(victim, self, lastweapon);
  var_6a9853a7ef309b8f = [];

  if(!isDefined(var_6a9853a7ef309b8f[self.team])) {
    var_6a9853a7ef309b8f[self.team] = 1;
    self playsoundtoteam("ui_team_wipe_splash", self.team);
  }
}

function function_ffcd45c1b7a5355a(var_4e776a22240ff174, killedtarget) {
  if(var_4e776a22240ff174.size <= 0) {
    return;
  }

  foreach(teammate in var_4e776a22240ff174) {
    if(!isDefined(teammate)) {
      continue;
    }

    function_d33f6589a1c04ee9(teammate);
  }

  if(!istrue(level.brgametype.usevengeancedecreaserespawntimer)) {
    function_5367b756a0eeb9db(self, killedtarget, var_4e776a22240ff174);
  }

  thread scripts\mp\events::killeventtextpopup("br_resurgence_vengeance", 0, 0);
  scripts\mp\gametypes\br_public::brleaderdialogplayer("resurgence_avenge_teammate", self);
  scripts\cp_mp\challenges::function_8359cadd253f9604(self, "avenge_teammate", 1);
}

function function_d33f6589a1c04ee9(var_92a674d94df29e77) {
  if(istrue(level.brgametype.var_574951d2eff9c094)) {
    var_92a674d94df29e77.avenged = 1;
  }

  var_92a674d94df29e77 notify("avenged");

  if(istrue(level.brgametype.usevengeancedecreaserespawntimer)) {
    var_92a674d94df29e77.respawndelay = int(max(0, var_92a674d94df29e77.respawndelay - level.brgametype.var_2cfdc1d6e92251bf));

    if(!isDefined(var_92a674d94df29e77.respawndelta)) {
      var_92a674d94df29e77.respawndelta = 0;
    }

    var_92a674d94df29e77.respawndelta += level.brgametype.var_2cfdc1d6e92251bf;
    scripts\mp\gametypes\br_gametypes::runbrgametypefunc("updateRespawnDelay", var_92a674d94df29e77);
    return;
  }

  var_92a674d94df29e77 thread function_7cb9398c136b6a50(1, level.teamdata[var_92a674d94df29e77.team]["alivePlayers"]);
}

function function_c86eefdaf13d0d81(victim) {
  if(self.respawndelay <= 0) {
    return;
  }

  if(!isDefined(self.waskilledby)) {
    self.waskilledby = [];
  }

  if(isDefined(self.waskilledby) && array_contains(self.waskilledby, victim)) {
    if(istrue(level.brgametype.usevengeancedecreaserespawntimer)) {
      function_366c394e9dc1e32d(self, level.brgametype.var_2cfdc1d6e92251bf);
      scripts\mp\gametypes\br_gametypes::runbrgametypefunc("updateRespawnDelay", self);
      function_aae3ac84b3ff8e6d();
      wait 1;
      function_1f013990c19fcd88();
    }

    array_remove(self.waskilledby, victim);
    thread scripts\mp\events::killeventtextpopup("br_resurgence_vengeance", 0, 0);
    scripts\cp_mp\challenges::function_8359cadd253f9604(self, "avenge_teammate", 1);
  }
}

function function_6f0f4e7b3ff7b57c(trackedteams) {
  oldestindex = -1;
  oldesttime = 2147483647;

  foreach(arrayindex, trackedteam in trackedteams) {
    if(trackedteam["startTime"] < oldesttime) {
      oldestindex = arrayindex;
      oldesttime = trackedteam["startTime"];
    }
  }

  return oldestindex;
}

function function_85fee305e2d829c1(array, teamname) {
  foundindex = -1;

  foreach(index, team in array) {
    if(team["name"] == teamname) {
      foundindex = index;
      break;
    }
  }

  return foundindex;
}

function function_611500f4751aaf1(bitfield, teamindex, arrayindex) {
  var_5ba62be302f54d98 = int(pow(2, 8));
  assertex(level.teamdata.size < var_5ba62be302f54d98, "<dev string:x9b>" + level.teamdata.size + "<dev string:xa7>" + 8 + "<dev string:xc7>");
  assertex(teamindex < var_5ba62be302f54d98, "<dev string:xdf>" + var_5ba62be302f54d98 - 1 + "<dev string:x113>" + level.teamdata.size + "<dev string:x122>");
  assertex(arrayindex >= 0 && arrayindex < 4, "<dev string:x12c>");
  leftshift = 8 * arrayindex;
  bitmask = var_5ba62be302f54d98 - 1;
  bitmask <<= leftshift;
  var_f8f977081d3da8b4 = ~bitmask;
  bitfield &= var_f8f977081d3da8b4;
  var_1cc902f24ef7cc11 = teamindex << leftshift;
  bitfield |= var_1cc902f24ef7cc11;
  return bitfield;
}

function function_d6d795db2cae2c1b(var_29412b34af141c29, var_38678fa9bdc12fdf, trackedteamindex, var_8db0c8d0a8da2329, tracktime) {
  bitfield = -1;
  shouldshow = !trackedteamindex == 0;

  foreach(player in var_29412b34af141c29) {
    if(isDefined(player)) {
      if(bitfield < 0) {
        bitfield = player getclientomnvar("ui_br_resurgence_tracked_teams");
        bitfield = function_611500f4751aaf1(bitfield, trackedteamindex, var_8db0c8d0a8da2329);
      }

      player setclientomnvar("ui_br_resurgence_tracked_teams", bitfield);
      player setclientomnvar("ui_br_interrogate_tracking_other_team", shouldshow);

      if(shouldshow) {
        foreach(trackedplayer in var_38678fa9bdc12fdf) {
          if(isDefined(trackedplayer)) {
            triggerportableradarpingteam(trackedplayer.origin, player.team, 16, int(tracktime));
          }
        }
      }
    }
  }

  if(istrue(level.brgametype.var_836c1fc36b00559d)) {
    foreach(trackedplayer in var_38678fa9bdc12fdf) {
      if(isDefined(trackedplayer)) {
        trackedplayer setclientomnvar("ui_br_interrogate_team_is_being_tracked", shouldshow);
      }
    }
  }
}

function function_f6686365221e78cb() {
  trackedteams = [];

  if(istrue(level.brgametype.var_840b848760f488a4)) {
    trackedteams = getteamdata(self.team, "trackedTeams");
  } else {
    if(!isDefined(self.trackedteams)) {
      self.trackedteams = [];
    }

    trackedteams = self.trackedteams;
  }

  return trackedteams;
}

function function_63c057f27dc906b5(trackerteam, trackedteam, tracktime) {
  if(!istrue(level.brgametype.respawnenable)) {
    return;
  }

  addindex = -1;
  trackedteams = function_f6686365221e78cb();
  addindex = function_85fee305e2d829c1(trackedteams, trackedteam);

  if(addindex < 0) {
    if(trackedteams.size == 4) {
      addindex = function_6f0f4e7b3ff7b57c(trackedteams);
    } else {
      addindex = trackedteams.size;
    }
  }

  if(addindex < 0 || addindex >= 4) {
    return;
  }

  thread function_7278f9076c781224(trackerteam, trackedteam, addindex, tracktime);
}

function function_7278f9076c781224(trackerteam, trackedteam, addindex, tracktime) {
  if(addindex < 0 || addindex >= 4) {
    return;
  }

  notifyname = "trackTeam" + trackerteam + addindex;
  var_29412b34af141c29 = [];
  var_5b1596320df748c = [];
  var_5b1596320df748c["name"] = trackedteam;
  var_5b1596320df748c["startTime"] = gettime();

  if(getteamdata(trackedteam, "players").size > 1 && getteamdata(trackedteam, "aliveCount") >= 1 && !istrue(level.var_c65376f0e1b8e893)) {
    scripts\mp\gametypes\br_public::brleaderdialogplayer("resurgence_hunt_reminder", self);
  }

  if(istrue(level.brgametype.var_840b848760f488a4)) {
    level notify(notifyname);
    level endon(notifyname);
    level.teamdata[trackerteam]["trackedTeams"][addindex] = var_5b1596320df748c;
    var_29412b34af141c29 = getteamdata(trackerteam, "players");
  } else {
    self notify(notifyname);
    self endon(notifyname);
    self.trackedteams[addindex] = var_5b1596320df748c;
    var_29412b34af141c29 = [self];
  }

  trackedteamindex = scripts\cp_mp\utility\player_utility::getteamindex(trackedteam);
  var_38678fa9bdc12fdf = getteamdata(trackedteam, "players");
  function_d6d795db2cae2c1b(var_29412b34af141c29, var_38678fa9bdc12fdf, trackedteamindex, addindex, tracktime);
  wait tracktime;
  function_d6d795db2cae2c1b(var_29412b34af141c29, var_38678fa9bdc12fdf, 0, addindex);
}

function function_3ee5f100eb900caf() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  if(istrue(level.brgametype.var_b43745b85f249e68)) {
    return;
  }

  if(getdvarint(@ "hash_32bd10766631266f", 0) == 0) {
    level waittill("infils_ready");
  }

  var_10b5c13c81db5079 = function_b398acc9ba21ecb5();
  totaltime = 0;

  if(getdvarint(@ "hash_32bd10766631266f", 0)) {
    totaltime = 1;
  }

  for(i = 0; i < var_10b5c13c81db5079; i++) {
    totaltime += level.br_level.br_circleclosetimes[i] + level.br_level.br_circledelaytimes[i];
  }

  totaltimems = int(totaltime * 1000);
  starttimems = gettime();
  var_3112e3de7bf7f005 = starttimems + totaltimems;
  setomnvarforallclients("ui_br_timed_feature_end_time", var_3112e3de7bf7f005);
  level.var_1fcba68efd8d4bf = totaltime;
  level._resurgence_respawn_end_time = var_3112e3de7bf7f005;

  if(level.brgametype.var_9524142eb719a321) {
    level.brgametype.var_d851832a0f677c60 = getdvarint(@ "hash_d83ff6d2e0647bc5", totaltime);
    thread function_5a44c88bdf9b01ae(level.brgametype.var_d851832a0f677c60);
  }

  remainingtimems = totaltimems;
  maxtimems = getdvarint(@ "hash_342776b421ce99fa", 90000);
  thread function_852d53966b46f329(remainingtimems / 1000);

  while(remainingtimems > maxtimems) {
    wait(remainingtimems - maxtimems) / 1000;
    elapsedtimems = gettime() - starttimems;
    remainingtimems = totaltimems - elapsedtimems;
  }

  setomnvarforallclients("ui_br_timed_feature_end_time", int(gettime() + remainingtimems) - 1);

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(istrue(scripts\mp\gametypes\br_gametypes::runbrgametypefunc("resurgenceDisableSkipForPlayer", player))) {
      continue;
    }

    player thread scripts\mp\hud_message::showsplash("br_resurgence_reinforcement_closing_improvement", undefined, undefined, undefined, undefined, "splash_list_iw9_br_resurgence_mp");
  }
}

function function_5a44c88bdf9b01ae(remainingtime) {
  level endon("game_ended");
  wait remainingtime;
  level.brgametype.var_9524142eb719a321 = 0;
}

function function_852d53966b46f329(remainingtime) {
  level endon("game_ended");
  wait remainingtime - 90;
  scripts\mp\gametypes\br_public::brleaderdialog("resurgence_ending", undefined, undefined, undefined, undefined, undefined);
}

function function_809485f51d59ebb() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level.brgametype.respawndelay = [];
  level.brgametype.var_34af112c77c2c381 = ["_solos", "_duos", "_trios", "_quads"];
  function_e6ca3c2ca24b16f();
  var_10b5c13c81db5079 = function_b398acc9ba21ecb5();
  assertex(var_10b5c13c81db5079 < 10, "<dev string:x158>");

  foreach(var_53a4a1c920def4bd in level.brgametype.var_34af112c77c2c381) {
    for(i = 0; i < var_10b5c13c81db5079; i++) {
      overridedelay = getdvarint(hashcat(@ "hash_fa5f73966eb446d7", i + 1, var_53a4a1c920def4bd), -1);

      if(overridedelay >= 0) {
        level.brgametype.respawndelay[var_53a4a1c920def4bd][i] = overridedelay;
        continue;
      }

      if(i >= level.brgametype.respawndelay[var_53a4a1c920def4bd].size) {
        level.brgametype.respawndelay[var_53a4a1c920def4bd][i] = level.brgametype.respawndelay[var_53a4a1c920def4bd][i - 1];
      }
    }
  }
}

function function_e6ca3c2ca24b16f() {
  var_8e52126aeaaf8ab8 = level.brgametype.var_8e52126aeaaf8ab8;

  for(i = 0; i < var_8e52126aeaaf8ab8.percircle.size; i++) {
    level.brgametype.respawndelay["_solos"][i] = var_8e52126aeaaf8ab8.percircle[i].var_a85640a8d2256218;
    level.brgametype.respawndelay["_duos"][i] = var_8e52126aeaaf8ab8.percircle[i].var_88414606541a6379;
    level.brgametype.respawndelay["_trios"][i] = var_8e52126aeaaf8ab8.percircle[i].var_d626a1e8c8874d8f;
    level.brgametype.respawndelay["_quads"][i] = var_8e52126aeaaf8ab8.percircle[i].forquads;
  }
}

function function_bbee565c7645ea29() {
  currentvalue = self getclientomnvar("ui_resurgenceRespawnTimer");
  newvalue = currentvalue &~16384;
  self setclientomnvar("ui_resurgenceRespawnTimer", newvalue);
}

function function_fff107d76eb56064() {
  currentvalue = self getclientomnvar("ui_resurgenceRespawnTimer");
  newvalue = currentvalue | 16384;
  self setclientomnvar("ui_resurgenceRespawnTimer", newvalue);
}

function function_aae3ac84b3ff8e6d() {
  currentvalue = self getclientomnvar("ui_resurgenceRespawnTimer");
  newvalue = currentvalue | 32768;
  self setclientomnvar("ui_resurgenceRespawnTimer", newvalue);
}

function function_1f013990c19fcd88() {
  currentvalue = self getclientomnvar("ui_resurgenceRespawnTimer");
  newvalue = currentvalue &~32768;
  self setclientomnvar("ui_resurgenceRespawnTimer", newvalue);
}

function function_b12988fdf64efe98(value) {
  assert(value <= 16384 - 1);
  currentvalue = self getclientomnvar("ui_resurgenceRespawnTimer");
  otherbits = currentvalue &~(16384 - 1);
  newvalue = otherbits | value;
  self setclientomnvar("ui_resurgenceRespawnTimer", newvalue);
}

function function_230ea867cd69c598(value) {
  assert(value <= 16384 - 1);
  haspenalty = 0;

  if(istrue(self.var_14afb82aa29bc57c)) {
    haspenalty = 2147483648;
    self.var_14afb82aa29bc57c = 0;
  }

  currentvalue = self getclientomnvar("ui_resurgenceRespawnTimer");
  otherbits = currentvalue &~(1073741824 - 65536 + 1073741824 + 2147483648);
  forceupdate = currentvalue & 1073741824;

  if(forceupdate != 0) {
    forceupdate = 0;
  } else {
    forceupdate = 1073741824;
  }

  newvalue = otherbits | value << 16 | forceupdate | haspenalty;
  self setclientomnvar("ui_resurgenceRespawnTimer", newvalue);
}

function function_77b9dedb0b66ca96(data) {
  if(!isDefined(data)) {
    self setclientomnvar("ui_resurgence_action_feedback", 0);
    return;
  }

  var_e47695ef0b8f3142 = 0;
  actionplayer = undefined;
  bestaction = undefined;

  foreach(playerid, actionfeedback in data) {
    if(actionfeedback.totaldelay > var_e47695ef0b8f3142) {
      var_e47695ef0b8f3142 = actionfeedback.totaldelay;
      actionplayer = playerid;
      bestaction = actionfeedback;
    }
  }

  eventid = 0;
  isscriptbundlesplash = 0;

  if(isDefined(bestaction.event)) {
    eventid = scripts\mp\rank::function_1e00d01d19fde519(bestaction.event);

    if(!isDefined(eventid) || eventid < 0) {
      eventid = getscoreinfocategory(bestaction.event, #"hash_edd89bb2cc2d506");
    } else {
      isscriptbundlesplash = 1;
    }
  }

  value = actionplayer + 1 + (isscriptbundlesplash << 3) + (eventid << 4);
  self setclientomnvar("ui_resurgence_action_feedback", value);
  self.var_c1e15642efb69421 = undefined;
}

function function_d04daab64ea0d3df(player) {
  teamplayers = getteamdata(player.team, "players");

  foreach(teammate in teamplayers) {
    goingtogulag = teammate scripts\mp\gametypes\br_public::isplayerinorgoingtogulag();
    var_73409c2edfa9e4f9 = isalive(teammate) && !istrue(teammate.inlaststand);

    if(teammate != player && var_73409c2edfa9e4f9 && !goingtogulag) {
      return true;
    }
  }

  return false;
}

function function_eb172b91a9fdf684() {
  player = self;

  if(player scripts\mp\gametypes\br_gulag::function_4a25d64251fab1b7()) {
    player function_fb9ed4b8a0e55bfc(level.teamdata[player.team]["alivePlayers"]);
    function_c3c91f0dfbf4f683();
    player scripts\mp\playerlogic::addtoalivecount("resurgence1");
    scripts\mp\gametypes\br_utility::unmarkplayeraseliminated(player);
    var_4911936f026c8e38 = scripts\mp\gametypes\br::brmayconsiderplayerdead(player);

    if(!var_4911936f026c8e38) {
      scripts\mp\gametypes\br_gulag::entergulag(player);
    }

    self.waitingtospawn = 0;
  }
}

function function_2310e5a630ab167c() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("doingRespawn");

  if(istrue(level.brgametype.var_55f0d9f2a10553c4)) {
    while(function_d04daab64ea0d3df(self)) {
      waitframe();
    }

    function_bbee565c7645ea29();
    self notify("squad_wiped");
    waitframe();
    function_eb172b91a9fdf684();
    return;
  }

  for(var_849d01afb2fc0f0a = getteamdata(self.team, "aliveCount"); var_849d01afb2fc0f0a > 0; var_849d01afb2fc0f0a = getteamdata(self.team, "aliveCount")) {
    waitframe();
  }

  function_bbee565c7645ea29();
  scripts\mp\gametypes\br_public::updatebrscoreboardstat("respawnInSeconds", 0);
  self notify("squad_wiped");
}

function function_140be6f794c627c9(deathdata) {
  if(!isDefined(deathdata.victim) || !isDefined(deathdata.attacker)) {
    return;
  }

  if(deathdata.victim == deathdata.attacker || !isPlayer(deathdata.attacker) && !isagent(deathdata.attacker)) {
    return;
  }

  var_849d01afb2fc0f0a = getteamdata(deathdata.victim.team, "aliveCount");

  if(var_849d01afb2fc0f0a == 0) {
    deathdata.attacker scripts\cp_mp\challenges::oncollectitem("t_wipe");
  }
}

function function_3709903d7ad3f711(player, evictim, event, points, var_645b1a1d2a1ddfb7) {
  if(!isDefined(player)) {
    return;
  }

  if(!isalive(player)) {
    return;
  }

  if(points <= 0) {
    return;
  }

  if(!scripts\mp\flags::gameflag("prematch_done") || !scripts\mp\flags::gameflag("prematch_fade_done")) {
    return;
  }

  if(is_equal(event, "br_kioskBuy") && is_equal(var_645b1a1d2a1ddfb7, "br_team_revive")) {
    var_780d8a24242378d5 = scripts\mp\utility\teams::getteamdata(player.team, "aliveCount");
    squadsize = scripts\mp\utility\teams::getteamdata(player.team, "teamCount");
    var_de1f625722d92973 = squadsize - var_780d8a24242378d5;

    if(var_de1f625722d92973 == 1) {
      return;
    }
  }

  var_9a5e708d6675417 = getmatchrulesdata("brData", "resurgencePointsToSecondRatio");
  firstsecondoffset = getmatchrulesdata("brData", "resurgencePointsToFirstSecondOffset");
  delaymodifier = int(floor((points + firstsecondoffset) * var_9a5e708d6675417));

  if(isDefined(event)) {
    if(event == "br_kioskBuy") {
      kioskbuyratio = getmatchrulesdata("brData", "resurgencePointsToSecondKioskBuyRatio");
      delaymodifier = int(ceil(delaymodifier * kioskbuyratio));
    } else if(event == "kill") {
      if(isPlayer(evictim)) {
        if(level.brgametype.var_ed0962f69d72e5b1 >= 0) {
          delaymodifier = level.brgametype.var_ed0962f69d72e5b1;
        } else {
          delaymodifier = int(floor((250 + firstsecondoffset) * var_9a5e708d6675417));
        }
      } else if(level.brgametype.var_12d3d7f14586d634 >= 0) {
        delaymodifier = level.brgametype.var_12d3d7f14586d634;
      } else {
        delaymodifier = int(floor((150 + firstsecondoffset) * var_9a5e708d6675417));
      }
    } else if(event == "headshot") {
      if(level.brgametype.var_dd674d15153f7aab >= 0) {
        delaymodifier = level.brgametype.var_dd674d15153f7aab;
      }
    } else if(event == "team_wiped") {
      if(level.brgametype.var_a922c322aa7d8e27 >= 0) {
        delaymodifier = level.brgametype.var_a922c322aa7d8e27;
      }
    } else if(event == "br_cacheOpen") {
      if(level.brgametype.var_dca0e6fef4e95fa9 >= 0) {
        delaymodifier = level.brgametype.var_dca0e6fef4e95fa9;
      } else {
        delaymodifier = int(floor((100 + firstsecondoffset) * var_9a5e708d6675417));
      }
    } else if(event == "br_pe_capNode") {
      delaymodifier = int(floor((700 + firstsecondoffset) * var_9a5e708d6675417));
    } else if(event == "resurgence_on_the_move") {
      if(level.brgametype.var_4a10a8dd79fb5ab4 >= 0) {
        delaymodifier = level.brgametype.var_4a10a8dd79fb5ab4;
      }
    } else if(event == "resurgence_hunter") {
      if(level.brgametype.var_a8ffbf7c6f0e152b >= 0) {
        delaymodifier = level.brgametype.var_a8ffbf7c6f0e152b;
      }
    } else if(event == "resurgence_hunter_double") {
      if(level.brgametype.var_53911fa2d60ccb40 >= 0) {
        delaymodifier = level.brgametype.var_53911fa2d60ccb40;
      }
    } else if(event == "resurgence_hunter_spree") {
      if(level.brgametype.var_79155a61db265b6e >= 0) {
        delaymodifier = level.brgametype.var_79155a61db265b6e;
      }
    } else if(event == "resurgence_armor_break") {
      if(level.brgametype.var_bc6456d93d2e9053 >= 0) {
        delaymodifier = level.brgametype.var_bc6456d93d2e9053;
      }
    } else if(event == "resurgence_fearless_kill") {
      if(level.brgametype.var_e3c11803759b1678 >= 0) {
        delaymodifier = level.brgametype.var_e3c11803759b1678;
      }
    } else if(event == #"hash_607cd099425b81c7") {
      if(level.brgametype.var_eac57b0b307ab1ef >= 0) {
        delaymodifier = level.brgametype.var_eac57b0b307ab1ef;
      } else {
        delaymodifier = int(floor((200 + firstsecondoffset) * var_9a5e708d6675417));
      }
    } else if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
      circle = min(max(1, level.br_circle.circleindex), 6);
      strcmp = "br_downEnemy_circle_" + string(circle);

      if(event == strcmp) {
        if(level.brgametype.var_4a73ad987e2857e1 >= 0) {
          delaymodifier = level.brgametype.var_4a73ad987e2857e1;
        }
      }
    }
  }

  function_366c394e9dc1e32d(player, delaymodifier, event);
}

function function_366c394e9dc1e32d(player, delaymodifier, event) {
  if(delaymodifier <= 0) {
    return;
  }

  modifierstruct = spawnStruct();
  modifierstruct.delaymodifier = delaymodifier;

  if(scoreeventhastext(event)) {
    modifierstruct.event = event;
  }

  scripts\mp\gametypes\br_gametypes::runbrgametypefunc("onResurgenceScoreworthyModifier", player, modifierstruct);

  if(istrue(player.issolo)) {
    function_4e47f37a50cbac36(player, delaymodifier);
    return;
  }

  function_249ed663848b0e5f(player, delaymodifier, event);
}

function function_4e47f37a50cbac36(player, delaymodifier) {
  if(isDefined(player.respawndelay) && player.respawndelay > 0) {
    player.respawndelay = int(max(0, player.respawndelay - delaymodifier));
    scripts\mp\gametypes\br_gametypes::runbrgametypefunc("updateRespawnDelay", player);

    if(!isDefined(player.respawndelta)) {
      player.respawndelta = 0;
    }

    player.respawndelta += delaymodifier;
    player scripts\cp_mp\challenges::function_fb73a02201f647ba(delaymodifier);
  }
}

function function_249ed663848b0e5f(player, delaymodifier, event) {
  if(!isDefined(player.team)) {
    return;
  }

  playerteam = level.teamdata[player.team];

  if(!isDefined(playerteam)) {
    return;
  }

  deadplayers = playerteam["deadPlayers"];

  if(!isDefined(deadplayers)) {
    return;
  }

  var_7cd081d8bbc27830 = 0;

  foreach(dead in deadplayers) {
    if(isDefined(dead) && isDefined(dead.player) && dead.player != player) {
      if(dead.player.respawndelay > 0) {
        dead.player.respawndelay = int(max(0, dead.player.respawndelay - delaymodifier));
        scripts\mp\gametypes\br_gametypes::runbrgametypefunc("updateRespawnDelay", dead.player);

        if(!isDefined(dead.player.respawndelta)) {
          dead.player.respawndelta = 0;
        }

        dead.player.respawndelta += delaymodifier;
        var_7cd081d8bbc27830 = 1;
        playerid = player.sessionuimemberindex;

        if(!isDefined(playerid) || playerid == -1) {
          continue;
        }

        if(!isDefined(dead.player.var_c1e15642efb69421)) {
          dead.player.var_c1e15642efb69421 = [];
        }

        if(!isDefined(dead.player.var_c1e15642efb69421[playerid])) {
          dead.player.var_c1e15642efb69421[playerid] = spawnStruct();
          dead.player.var_c1e15642efb69421[playerid].totaldelay = 0;
        }

        dead.player.var_c1e15642efb69421[playerid].totaldelay += delaymodifier;

        if(isDefined(event)) {
          if(scoreeventhastext(event)) {
            bestdelay = dead.player.var_c1e15642efb69421[playerid].bestdelay;

            if(!isDefined(bestdelay) || delaymodifier > bestdelay) {
              dead.player.var_c1e15642efb69421[playerid].bestdelay = delaymodifier;
              dead.player.var_c1e15642efb69421[playerid].event = event;
            }
          }
        }
      }
    }
  }

  if(var_7cd081d8bbc27830) {
    if(istrue(player.var_5c3b157495f480a2)) {
      player.var_5449b5708779ee8e += delaymodifier;
    } else {
      player.var_5c3b157495f480a2 = 1;
      player.var_5449b5708779ee8e = delaymodifier;
      player thread function_5d3d825b6d78b130();
    }

    player scripts\cp_mp\challenges::function_fb73a02201f647ba(delaymodifier);
  }
}

function function_5d3d825b6d78b130() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("squad_wiped");

  if(!isPlayer(self)) {
    return;
  }

  wait 0.5;

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.var_5449b5708779ee8e) && self.var_5449b5708779ee8e > 0) {
    function_230ea867cd69c598(self.var_5449b5708779ee8e);
  }

  self.var_5449b5708779ee8e = undefined;
  self.var_5c3b157495f480a2 = 0;
}

function function_b1dfe6c6434fc16c() {
  if(!istrue(level.brgametype.respawnenable) && !istrue(self.var_8a52130c321aa8a)) {
    return;
  }

  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player endon("squad_wiped");
  player endon("force_stop_respawn");

  if(!istrue(level.brgametype.var_b43745b85f249e68)) {
    player thread function_2310e5a630ab167c();
  }

  player thread function_f1262ab9b4bf1697();

  if(level.brgametype.var_bbde847aed85512a) {
    if(level.brgametype.var_523779ad4c01fd7c) {
      player thread function_263e1e65ec02113b();
    } else {
      player thread function_b3b332f4d23eb080();
    }
  }

  player.respawndelay = player getrespawndelay();

  if(level.brgametype.var_14afb82aa29bc57c > 0 && self.attacker == self) {
    player thread function_46261e8da3c3005e();
  }

  if(!isDefined(player.respawndelay)) {
    errormsg = "";
    gameflags = "\n";
    flagnames = getarraykeys(game["flags"]);

    foreach(name in flagnames) {
      gameflags += name + " -> " + game["flags"][name] + "\n";
    }

    errormsg += gameflags;
    scripts\mp\utility\script::demoforcesre(errormsg);
    player.respawndelay = 30;
  }

  if(getdvarint(@ "hash_d31b1c01a86089c2", 1) == 1 && isalive(player)) {
    scripts\mp\utility\script::demoforcesre("Alive player added to resurgence countdown. IsAlive: " + isalive(player) + ". Sessionstate: " + player.sessionstate);
    waitframe();
    scripts\mp\utility\script::demoforcesre("Alive player added to resurgence countdown - after waitframe. IsAlive: " + isalive(player) + ". Sessionstate: " + player.sessionstate);
  }

  player function_1f013990c19fcd88();
  player function_fff107d76eb56064();
  player function_b12988fdf64efe98(player.respawndelay);
  player.respawndelta = 0;

  while(player.respawndelay > 0) {
    if(isalive(player)) {
      player.respawndelay = 0;
    } else {
      player function_b12988fdf64efe98(player.respawndelay);
    }

    player function_230ea867cd69c598(player.respawndelta);
    player function_77b9dedb0b66ca96(player.var_c1e15642efb69421);
    player scripts\mp\gametypes\br_public::updatebrscoreboardstat("respawnInSeconds", player.respawndelay);
    player.respawndelta = 0;
    wait 1;
    player.respawndelay--;
  }

  player.var_c1e15642efb69421 = undefined;
  player function_bbee565c7645ea29();
  player function_b12988fdf64efe98(0);
  player function_230ea867cd69c598(0);
  player scripts\mp\gametypes\br_public::updatebrscoreboardstat("respawnInSeconds", 0);

  if(istrue(player.var_632bad3edb4e449e)) {
    self waittill("resurgence_rejoin_successful");
  }

  if(!isalive(player)) {
    if(isDefined(player.team)) {
      displaysquadmessagetoteam(player.team, player, 14, 1);

      foreach(teammate in level.teamdata[player.team]["alivePlayers"]) {
        if(!istrue(teammate.var_24278e2ec4540e)) {
          teammate thread function_4c5ae16ac1a3265f();
        }
      }
    }

    player thread function_7cb9398c136b6a50(0, level.teamdata[player.team]["alivePlayers"]);
  }
}

function function_46261e8da3c3005e() {
  level endon("game_ended");
  self endon("disconnect");

  while(self.sessionstate != "intermission") {
    waitframe();
  }

  self.var_14afb82aa29bc57c = 1;
  function_230ea867cd69c598(level.brgametype.var_14afb82aa29bc57c);
}

function function_8d7079499b5b7d01() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("squad_wiped");
  self endon("force_stop_respawn");
  self endon("force_stop_respawn_dmr");
  self endon("started_spawnPlayer");
  scripts\mp\gametypes\br_spectate::waittillspectating(self);

  while(true) {
    if(istrue(self.var_4d92a54b804bafc)) {
      function_123793b0882ec6fb(2);
      self waittill("team_care_request_cooldown_clear");
    }

    teamdata = level.teamdata[self.team];
    teammates = teamdata["players"];

    if(teamdata["aliveCount"] > int(getteamcount(self.team) * 0.5)) {
      function_123793b0882ec6fb(0);
      waittill_any_ents_array(teammates, "death");
      continue;
    }

    function_123793b0882ec6fb(1);
    request = waittill_any_return_3("request_care", "team_care_request_sent", "alive_count_change");

    if(request == "request_care") {
      alivecount = level.teamdata[self.team]["aliveCount"];

      foreach(teammate in teammates) {
        teammate thread function_4744bb1db1b48f9a(alivecount);
      }

      wait level.brgametype.var_8f48d3f93ac1204c;
    }
  }
}

function function_4744bb1db1b48f9a(alivecount) {
  level endon("game_ended");
  self endon("disconnect");
  function_bd49896ab411c64c(alivecount);
  function_123793b0882ec6fb(2);

  if(!level.brgametype.var_523779ad4c01fd7c) {
    thread function_dd82fe8b8e1d0ecb();
  }

  wait level.brgametype.var_f8da748df2368691;
  function_123793b0882ec6fb(0);
}

function function_dd82fe8b8e1d0ecb() {
  level endon("game_ended");
  self endon("disconnect");
  self.var_4d92a54b804bafc = 1;
  self notify("team_care_request_sent");
  wait level.brgametype.var_74427b8346a538df;
  self.var_4d92a54b804bafc = 0;
  self notify("team_care_request_cooldown_clear");
}

function function_b3b332f4d23eb080() {
  level endon("game_ended");
  self endon("disconnect");

  if(!isbot(self)) {
    self notifyonplayercommand("request_care", "+ping");
    self notifyonplayercommand("request_care", "+actionslot 1");
  }

  function_8d7079499b5b7d01();
  function_123793b0882ec6fb(0);

  if(!isbot(self)) {
    self notifyonplayercommandremove("request_care", "+ping");
    self notifyonplayercommandremove("request_care", "+actionslot 1");
  }

  foreach(teammate in level.teamdata[self.team]["players"]) {
    teammate notify("alive_count_change");
  }
}

function function_263e1e65ec02113b() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("squad_wiped");
  self endon("force_stop_respawn");
  self endon("force_stop_respawn_dmr");
  self endon("started_spawnPlayer");
  waitframe();
  teamdata = level.teamdata[self.team];
  teammates = teamdata["players"];
  alivecount = teamdata["aliveCount"];

  if(alivecount <= int(getteamcount(self.team) * 0.5) && !istrue(self.var_b9c8734ebc34ee6c)) {
    foreach(teammate in teammates) {
      if(isalive(teammate)) {
        teammate thread function_4744bb1db1b48f9a(alivecount);
      }
    }

    thread function_9dd5db08596c6a71(teammates);
  }
}

function function_9dd5db08596c6a71(teammates) {
  foreach(teammate in teammates) {
    if(isDefined(teammate)) {
      teammate.var_b9c8734ebc34ee6c = 1;
    }
  }

  wait level.brgametype.var_74427b8346a538df;

  foreach(teammate in teammates) {
    if(isDefined(teammate)) {
      teammate.var_b9c8734ebc34ee6c = undefined;
    }
  }
}

function function_4c5ae16ac1a3265f() {
  level endon("game_ended");
  self.var_24278e2ec4540e = 1;
  thread scripts\mp\gametypes\br_public::brleaderdialogplayer("resurgence_teammate_respawn", self);
  wait 5;
  self.var_24278e2ec4540e = undefined;
}

function function_f1262ab9b4bf1697() {
  level endon("game_ended");
  self endon("disconnect");
  waitframe();
  function_65114ae4a91a1013();
}

function function_65114ae4a91a1013() {
  if(istrue(level.brgametype.var_ad3c825b1dd7d9a8)) {
    return;
  }

  newentry = self;

  if(!istrue(level.brgametype.vengeanceuseanykill)) {
    newentry = spawnStruct();
    newentry.player = self;
    newentry.killer = self.lastkilledby;
  }

  var_7193e062042f638d = [];
  deadplayers = level.teamdata[self.team]["deadPlayers"];

  foreach(dead in deadplayers) {
    if(isDefined(dead)) {
      var_7193e062042f638d[var_7193e062042f638d.size] = dead.player.name;
    }
  }

  assertex(!array_contains(var_7193e062042f638d, newentry.player.name), "<dev string:x199>");
  level.teamdata[self.team]["deadPlayers"] = array_add(level.teamdata[self.team]["deadPlayers"], newentry);
}

function function_c3c91f0dfbf4f683() {
  if(istrue(level.brgametype.var_ad3c825b1dd7d9a8)) {
    return;
  }

  deadplayers = level.teamdata[self.team]["deadPlayers"];

  if(istrue(level.brgametype.vengeanceuseanykill)) {
    deadplayers = array_remove(deadplayers, self);
  } else {
    newents = [];

    foreach(item in deadplayers) {
      if(isDefined(item) && item.player != self) {
        newents[newents.size] = item;
      }
    }

    deadplayers = newents;
  }

  level.teamdata[self.team]["deadPlayers"] = deadplayers;
}

function function_cd4132b03ffcf8cf() {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player endon("squad_wiped");
  player endon("respawn_disabled");

  while(player.respawndelay > 0) {
    if(player.respawndelay <= 5) {
      player playsoundtoplayer("ui_mp_resurgence_timer_quarter_sec", player);
    } else if(player.respawndelay <= 10) {
      player playsoundtoplayer("ui_mp_resurgence_timer_half_sec", player);
    } else if(player.respawndelay % 4 == 2) {
      player playsoundtoplayer("ui_mp_resurgence_timer", player);
    } else {
      player playsoundtoplayer("ui_mp_resurgence_timer_tick", player);
    }

    player function_b12988fdf64efe98(player.respawndelay);
    player function_230ea867cd69c598(player.respawndelta);
    player.respawndelta = 0;
    wait 1;
    player.respawndelay--;
  }

  player function_bbee565c7645ea29();
  player thread scripts\mp\hud_message::showsplash("br_resurgence_respawn_active_improvement", undefined, undefined, undefined, undefined, "splash_list_iw9_br_resurgence_mp");
}

function function_e37ac9f8cbed03eb() {
  if(!istrue(level.brgametype.respawnenable)) {
    return;
  }

  player = self;
  level endon("game_ended");
  player endon("squad_wiped");
  player endon("respawn_disabled");
  player endon("death_or_disconnect");
  player.respawndelay = player getrespawndelay();
  player waittill("respawn_done");
  player function_b12988fdf64efe98(player.respawndelay);
  player function_fff107d76eb56064();
  player.respawndelta = 0;

  while(!player isonground() && !player isswimming()) {
    waitframe();
  }

  player thread function_cd4132b03ffcf8cf();
}

function function_f99a079543f11bf7(deathdata, finaldeath) {
  if(!istrue(self.issolo)) {
    return;
  }

  if(!istrue(level.br_prematchstarted)) {
    return undefined;
  }

  player = self;

  if(istrue(player.respawngranted)) {
    player.alreadyaddedtoalivecount = 1;
    player thread function_7cb9398c136b6a50();
    player thread function_e37ac9f8cbed03eb();
  } else {
    deathdata.victim thread scripts\mp\gametypes\br_spectate::spawnspectator(deathdata, finaldeath);
  }

  player.respawngranted = undefined;
  return 1;
}

function function_7cb9398c136b6a50(var_cb5ba4c3282c39c1, aliveteammates) {
  assertex(isDefined(self), "<dev string:x1b6>");
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player notify("doingRespawn");
  respawnstruct = function_2d7ef4d534930df4(var_cb5ba4c3282c39c1, aliveteammates);
  player namespace_8bfdb6eb5a3df67a::function_d5ee3d3fad992d43(undefined, respawnstruct);
}

function function_2e712bc64fde7() {
  wait 0.5;
  return true;
}

function function_8a747fed5fdc31ed(spawnpoint, streamtimeout) {
  if(level.br_circle.circleindex < 2) {
    snappedpoint = getclosestpointonnavmesh(spawnpoint.origin);
    maxdistance = getdvarint(@ "hash_cd6b7daed2ab5024", 2500);

    if(distance2d(snappedpoint, spawnpoint.origin) > maxdistance) {
      targetpos = getrandomnavpoint(snappedpoint, randomfloat(maxdistance));
      spawnpoint.origin = (targetpos[0], targetpos[1], spawnpoint.origin[2]);
    }
  }

  if(isDefined(self.lastdeathpos)) {
    maxdistance = getdvarint(@ "hash_cd6b7daed2ab5024", 2500);
    var_ac55bc4e66da14a7 = maxdistance * maxdistance;

    if(distance2dsquared(self.lastdeathpos, spawnpoint.origin) > var_ac55bc4e66da14a7) {
      offset = spawnpoint.origin - self.lastdeathpos;
      offset = vectorNormalize(offset);
      offset = (offset[0] * maxdistance, offset[1] * maxdistance, offset[2]);
      targetpos = (self.lastdeathpos[0] + offset[0], self.lastdeathpos[1] + offset[1], offset[2]);
      targetpos = getclosestpointonnavmesh(targetpos);
      spawnpoint.origin = (targetpos[0], targetpos[1], spawnpoint.origin[2]);
    }
  }

  if(namespace_8bfdb6eb5a3df67a::function_61b5424aa3fe974e(spawnpoint.origin, streamtimeout)) {
    safeorigin = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    saferadius = scripts\mp\gametypes\br_circle::getsafecircleradius();
    offset = spawnpoint.origin - safeorigin;
    offset = vectorNormalize(offset);
    offset = (offset[0] * saferadius, offset[1] * saferadius, offset[2]);
    targetpos = safeorigin + offset;
    spawnpoint.origin = (targetpos[0], targetpos[1], spawnpoint.origin[2]);
  }
}

function function_2d7ef4d534930df4(var_cb5ba4c3282c39c1, aliveteammates) {
  rs = namespace_8bfdb6eb5a3df67a::function_ade48af7c782e202(&function_179991a5f6040f91, "br_ac130_flyby", undefined);
  rs namespace_8bfdb6eb5a3df67a::function_9fd565bcd654ed48(&function_47f3ced79ed3a338);
  rs namespace_8bfdb6eb5a3df67a::function_b4c313df5d7fb216(&function_777d7ef570638306, 20);
  rs namespace_8bfdb6eb5a3df67a::function_8cb232cdf47da79c(&function_ff75bbd246d432ec, 20);
  rs namespace_8bfdb6eb5a3df67a::function_2556973693d6315(&function_e762446073ac085, "br_resurgence_redeploy_improvement", 20, "splash_list_iw9_br_resurgence_mp", "resurgence_redeploy");
  rs.optparams.var_cb5ba4c3282c39c1 = var_cb5ba4c3282c39c1;
  rs.optparams.aliveteammates = aliveteammates;
  return rs;
}

function function_ff75bbd246d432ec(optparams) {
  if(!istrue(self.issolo)) {
    scripts\mp\gametypes\br_pickups::removerespawntoken();
  }
}

function function_e762446073ac085(optparams) {
  if(istrue(level.brgametype.respawnenable)) {
    if(istrue(self.issolo) && !istrue(self.var_36a7cb5e6f04de78)) {
      thread scripts\mp\hud_message::showsplash("br_resurgence_survive_countdown_improvement", undefined, undefined, undefined, undefined, "splash_list_iw9_br_resurgence_mp");
      self.var_36a7cb5e6f04de78 = 1;
    }
  } else if(istrue(self.issolo)) {
    thread scripts\mp\hud_message::showsplash("br_resurgence_reinforcement_closed_improvement", undefined, undefined, undefined, undefined, "splash_list_iw9_br_resurgence_mp");
  }

  if(istrue(self.issolo)) {
    self notify("respawn_done");
  }
}

function function_777d7ef570638306(optparams) {
  player = self;

  if(istrue(player.issolo)) {
    player function_fff107d76eb56064();
  } else {
    player function_bbee565c7645ea29();
  }

  if(!istrue(player.issolo)) {
    player function_1f013990c19fcd88();
  }

  println("<dev string:x1dd>" + self.name);
  function_c04b5edf3f9ea340();
  respawndone = 0;
  return respawndone;
}

function function_47f3ced79ed3a338(optparams) {
  player = self;

  if(!istrue(player.issolo)) {
    if(istrue(player.respawningfromtoken)) {
      return false;
    }

    player.respawningfromtoken = 1;

    if(istrue(optparams.var_cb5ba4c3282c39c1)) {
      player function_aae3ac84b3ff8e6d();
      player thread scripts\mp\events::killeventtextpopup("br_resurgence_vengeance", 0, 0);
      wait 1.5;
    }

    player function_fb9ed4b8a0e55bfc(optparams.aliveteammates);
    function_c3c91f0dfbf4f683();
    player scripts\mp\playerlogic::addtoalivecount("resurgence2");
    scripts\mp\gametypes\br_utility::unmarkplayeraseliminated(player);
    player scripts\mp\gametypes\br_pickups::addrespawntoken(1);
  } else {
    player function_fb9ed4b8a0e55bfc();
  }

  return true;
}

function function_179991a5f6040f91(optparams) {
  self notify("resurgenceRespawn");
  self.health = self.maxhealth;
  val::set("resurgenceRespawn", "player_for_spawn_logic", 0);
  scripts\mp\gametypes\br_public::updatebrscoreboardstat("isRespawning", 0);
}

function function_c04b5edf3f9ea340() {
  if(isDefined(level.br_standard_loadout) || getdvarint(@ "hash_f97d261e2f377ad9", 1) != 0) {
    self.gulagtableloadout = 1;
  }
}

function function_b0fc27ec6e239628() {
  respawnloadout = namespace_8bfdb6eb5a3df67a::function_eee8abc18302f5ef();
  return respawnloadout[0];
}

function function_6ab3fa08604ded12() {
  var_a0c010617b88d7bc = istrue(level.brgametype.var_574951d2eff9c094) && istrue(self.avenged);

  if((var_a0c010617b88d7bc || istrue(level.brgametype.loadoutrestore)) && isDefined(self.savedloadout)) {
    scripts\mp\gametypes\br::playerloadoutrestore();

    if(var_a0c010617b88d7bc) {
      thread scripts\mp\hud_message::showsplash("br_resurgence_vengeance_loadout", undefined, undefined, undefined, undefined, "splash_list_iw9_br_resurgence_mp");
    }
  } else {
    respawnloadout = namespace_8bfdb6eb5a3df67a::function_eee8abc18302f5ef();
    level.br_standard_loadout = respawnloadout[0];
    noextraammo = respawnloadout[1];

    if(istrue(getdvarint(@ "hash_5c757e0c9c8827c4")) && istrue(self.br_isininfil)) {
      function_b1eaa06eea44951b();
      self.br_isininfil = 0;
    } else {
      scripts\mp\gametypes\br::givestandardtableloadout(0, 1, noextraammo);
    }
  }

  if(!isDefined(self.equipment) || !isDefined(self.equipment["health"])) {
    scripts\cp_mp\armor::function_be5c0cdfa0202544();
  }

  self.avenged = undefined;
  return false;
}

function function_decd4293c451c70() {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }

  if(!isDefined(self.firstspawndone)) {
    self.firstspawndone = 1;
    var_ce214afc7b96a3a7 = getdvarint(@ "hash_e67c864263196598", 1);

    if(var_ce214afc7b96a3a7) {
      scripts\mp\gametypes\br_pickups::addselfrevivetoken(1);
    }

    givespecialist = getdvarint(@ "hash_5868a46b12b1b4dd", 0);

    if(givespecialist) {
      scripts\mp\perks\perks::addspecialistbonus();
    }
  } else {
    var_ce214afc7b96a3a7 = getdvarint(@ "scr_br_give_self_revive_on_respawn", 0);

    if(var_ce214afc7b96a3a7) {
      scripts\mp\gametypes\br_pickups::addselfrevivetoken(1);
    }

    givespecialist = getdvarint(@ "hash_5868a46b12b1b4dd", 0);

    if(givespecialist) {
      scripts\mp\perks\perks::addspecialistbonus();
    }
  }

  if(!isDefined(self.equipment) || !isDefined(self.equipment["health"])) {
    scripts\cp_mp\armor::function_be5c0cdfa0202544();
  }

  return 0;
}

function function_b1eaa06eea44951b() {
  struct = scripts\mp\class::loadout_getclassstruct();
  struct.loadoutarchetype = "archetype_assault";
  struct.loadoutequipmentprimary = "equip_snowball";
  struct.loadoutstreaktype = "assault";
  scripts\mp\class::preloadandqueueclassstruct(struct, 1);
  scripts\mp\gametypes\br::br_giveselectedclass(self, 0, 0);
}

function function_53382489ff523151() {
  poweritems = ["brloot_self_revive", "brloot_equip_gasmask", "brloot_equip_gasmask_durable"];
  return array_random(poweritems);
}

function getrandomkillstreak(raritymax) {
  return pickscriptablelootitem("killstreak", 0, raritymax, "mp/loot/br/default/lootset_cache_base.csv");
}

function function_b398acc9ba21ecb5() {
  if(!isDefined(level.brgametype.var_f0f5747f8d5bed77)) {
    level.brgametype.var_f0f5747f8d5bed77 = function_ee26a62ef3d1372d(@ "hash_5c872af62541d1d", 3, level.brgametype.var_8e52126aeaaf8ab8.stopcircleindex);
  }

  return level.brgametype.var_f0f5747f8d5bed77;
}

function circletimer(circleindex) {
  if(istrue(level.brgametype.respawnenable)) {
    var_10b5c13c81db5079 = function_b398acc9ba21ecb5();

    if(circleindex >= var_10b5c13c81db5079) {
      disablerespawn();
    }
  }
}

function function_338ba9b353a9a78b() {
  suffixindex = 0;

  if(level.brgametype.var_bb9b77186cb79ae6) {
    players = getteamarray(self.team);
    suffixindex = players.size - 1;

    foreach(player in players) {
      if(isDefined(player) && istrue(player.var_632bad3edb4e449e)) {
        suffixindex--;
      }
    }
  } else {
    suffixindex = scripts\cp_mp\utility\game_utility::function_4fb37368ae3585bb() - 1;
  }

  suffixindex = int(max(min(suffixindex, level.brgametype.var_34af112c77c2c381.size - 1), 0));
  return level.brgametype.var_34af112c77c2c381[suffixindex];
}

function getrespawndelay() {
  var_53a4a1c920def4bd = function_338ba9b353a9a78b();

  if(isDefined(level.brgametype.var_88a254227da87c7f) && isDefined(level.brgametype.var_88a254227da87c7f[self.team])) {
    respawndelay = level.brgametype.var_88a254227da87c7f[self.team].respawntimes[var_53a4a1c920def4bd];
  } else if(isDefined(level.brgametype.var_c655c38108f1827f)) {
    respawndelay = level.brgametype.var_c655c38108f1827f;
  } else {
    if(!br_gametypes::isfeatureenabled("circle") && scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "limbo") {
      circleindex = 0;
    } else {
      circleindex = int(max(0, int(min(level.br_circle.circleindex, level.brgametype.respawndelay[var_53a4a1c920def4bd].size - 1))));
    }

    respawndelay = level.brgametype.respawndelay[var_53a4a1c920def4bd][circleindex];
  }

  if(level.brgametype.var_14afb82aa29bc57c > 0 && self.attacker == self) {
    respawndelay += level.brgametype.var_14afb82aa29bc57c;
  }

  return respawndelay;
}

function function_f39fa02f6ed912fc(attackers) {
  if(!istrue(self.issolo)) {
    return;
  }

  victim = self;

  if(!isDefined(victim.respawndelay)) {
    victim.respawndelay = 0;
  }

  if(victim.respawndelay > 0 || !istrue(level.brgametype.respawnenable)) {
    attackers[attackers.size] = victim.laststandattacker;
  }
}

function disablerespawn() {
  level.brgametype.respawnenable = 0;
  level.brgametype.var_bbde847aed85512a = 0;

  if(!level.brgametype.issolos) {
    function_683452dfa2b09ccd();
    scripts\mp\gametypes\br_gametypes::runbrgametypefunc("resurgenceDisable");
  }

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(istrue(scripts\mp\gametypes\br_gametypes::runbrgametypefunc("resurgenceDisableSkipForPlayer", player))) {
      continue;
    }

    if(isinlaststand(player)) {
      player.var_8a52130c321aa8a = 1;
      player thread function_3d8918359e1b33c5();
    }

    player thread scripts\mp\hud_message::showsplash("br_resurgence_reinforcement_closed_improvement", undefined, undefined, undefined, undefined, "splash_list_iw9_br_resurgence_mp");
    player setclientomnvar("ui_br_timed_feature_end_time", 0);

    if(player iscodcaster()) {
      namespace_f5675568ccc8acc6::function_7d42d3f8dd68280c(2);
    }

    if(istrue(level.br_pickups.var_a181de0ed6a505d5) && player scripts\mp\gametypes\br_public::hasrespawntoken()) {
      player scripts\mp\gametypes\br_pickups::removerespawntoken();

      if(level.brgametype.var_3fc59bce0c73b8cf > 0) {
        player scripts\mp\gametypes\br_plunder::playerplunderpickup(level.brgametype.var_3fc59bce0c73b8cf);
        player scripts\mp\utility\lower_message::setlowermessageomnvar("br_redeploy_conversion", undefined, level.brgametype.var_eaa971da207c8bb5);
      }
    }

    if(istrue(player.issolo)) {
      player notify("respawn_disabled");
      continue;
    }

    player scripts\mp\gametypes\br_gametypes::runbrgametypefunc("playerResurgenceDisable");
  }

  scripts\mp\gametypes\br_public::brleaderdialog("resurgence_disabled", undefined, undefined, undefined, undefined, undefined);
}

function function_3d8918359e1b33c5() {
  self endon("death_or_disconnect");
  self waittill("last_stand_revived");
  self.var_8a52130c321aa8a = undefined;
}

function function_38a46a469c73dc2c() {
  assertex(isDefined(level.br_level) && isDefined(level.br_level.br_circlecenters) && isDefined(level.br_level.br_circleradii), "<dev string:x218>");
  originoverride = (level.br_level.br_circlecenters[1][0], level.br_level.br_circlecenters[1][1], 0);
  radiusoverride = level.br_level.br_circleradii[1];
  c130pathstruct = scripts\mp\gametypes\br_c130::createtestc130path(originoverride, radiusoverride, level.brgametype.mapcenteroverride, level.brgametype.var_92fcc390c4c0acd7);
  return c130pathstruct;
}

function function_c338e39db41d9374() {
  thread scripts\mp\gametypes\br_public::kickplayersatcircleedge();
}

function function_f13ec0f9fbe36171() {
  if(isDefined(level._resurgence_respawn_end_time)) {
    self setclientomnvar("ui_br_timed_feature_end_time", level._resurgence_respawn_end_time);
  }
}

function function_7ea88dd9bc483463(player) {
  if(!scripts\mp\flags::gameflag("prematch_fade_done")) {
    return;
  }

  if(istrue(level.gameended)) {
    return;
  }

  if(level.brgametype.issolos) {
    return;
  }

  if(!istrue(level.brgametype.respawnenable)) {
    return;
  }

  if(scripts\mp\gametypes\br::isbrteameliminated(player.team) && !istrue(level.brgametype.var_b43745b85f249e68)) {
    return;
  }

  remainingplayers = getteamarray(player.team);

  foreach(remainingplayer in remainingplayers) {
    function_c17a21e7020df4c(remainingplayer, 0, player);
  }

  if(istrue(level.brgametype.var_bb9b77186cb79ae6) && istrue(level.brgametype.respawnenable) && !istrue(level.brgametype.var_2b5ee6212b58e7a6)) {
    scripts\mp\gametypes\br_public::brleaderdialog("resurgence_on_player_disconnect", 1, remainingplayers, undefined, 0, undefined);
  }
}

function function_9bf15d9bf66ead8d(player, aeeventname) {
  if(!istrue(player.var_632bad3edb4e449e)) {
    thread function_c4d09e34eb4d8e2b(player, 1);
  }

  if(level.var_77907d733abe8b63) {
    return namespace_2c7976a64ea24d6a::ondisconnect(player, aeeventname);
  }

  return [];
}

function function_e60ebcdf4083532e(player) {
  thread function_c4d09e34eb4d8e2b(player, 0);
}

function function_c4d09e34eb4d8e2b(player, isdisconnect) {
  level endon("game_ended");

  if(!scripts\mp\flags::gameflag("prematch_fade_done")) {
    return;
  }

  if(istrue(level.gameended)) {
    return;
  }

  if(level.brgametype.issolos) {
    return;
  }

  if(!istrue(level.brgametype.respawnenable)) {
    return;
  }

  if(scripts\mp\gametypes\br::isbrteameliminated(player.team) && !istrue(level.brgametype.var_b43745b85f249e68)) {
    return;
  }

  if(istrue(isdisconnect)) {
    player notify("force_stop_respawn_dmr");
  } else {
    player notify("resurgence_rejoin_successful");
  }

  remainingplayers = getteamarray(player.team);

  if(istrue(level.brgametype.var_bb9b77186cb79ae6)) {
    if(level.brgametype.var_8947d8f4e61494fa) {
      foreach(remainingplayer in remainingplayers) {
        splashref = "br_resurgence_ally_rejoin_improvement";

        if(istrue(isdisconnect)) {
          splashref = "br_resurgence_ally_left_improvement";
        }

        remainingplayer thread scripts\mp\hud_message::showsplash(splashref, undefined, player, undefined, undefined, "splash_list_iw9_br_resurgence_mp");
      }
    }

    if(isdisconnect) {
      scripts\mp\gametypes\br_public::brleaderdialog("resurgence_on_player_disconnect", 1, remainingplayers, undefined, 0, undefined);
    }
  }
}

function function_cc9995519d9cee6(player, initialupdate) {
  level endon("game_ended");
  self endon("disconnect");

  while(!isalive(player) || !player isonground() && !player isswimming()) {
    wait 1;
  }

  if(!initialupdate && istrue(level.brgametype.var_fb997d1846bd5cf4)) {
    player thread scripts\mp\hud_message::showsplash("br_resurgence_left_behind_improvement", undefined, undefined, undefined, undefined, "splash_list_iw9_br_resurgence_mp");
  }

  player.respawndelay = 0;
  player.issolo = 1;
  player setclientomnvar("ui_br_resurgence_respawn_type", 1);
}

function function_22ef1cd58a8d87e8() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  teamsize = scripts\cp_mp\utility\game_utility::function_4fb37368ae3585bb();

  foreach(team in level.teamnamelist) {
    if(getteamcount(team) < teamsize) {
      teamplayers = getteamarray(team);

      foreach(player in teamplayers) {
        if(isDefined(player)) {
          function_c17a21e7020df4c(player, 1);
        }
      }
    }
  }
}

function function_c17a21e7020df4c(player, initialupdate, leavingplayer) {
  if(getteamcount(player.team) == 1 && istrue(level.brgametype.var_9524142eb719a321)) {
    thread function_cc9995519d9cee6(player, initialupdate);
    return;
  }

  if(!initialupdate && istrue(level.brgametype.var_8947d8f4e61494fa) && !istrue(level.brgametype.var_2b5ee6212b58e7a6)) {
    player thread scripts\mp\hud_message::showsplash("br_resurgence_ally_left_improvement", undefined, leavingplayer, undefined, 1, "splash_list_iw9_br_resurgence_mp");
  }
}

function function_81baad6d96ff2130() {
  level endon("game_ended");
  level waittill("prematch_started");
  level.brgametype.var_2b5ee6212b58e7a6 = namespace_bf9ffd2b22c7d819::function_e3bd94413509bc25() && getdvarint(@ "hash_b14d64e76f160241", 1);

  if(istrue(level.brgametype.var_2b5ee6212b58e7a6)) {
    namespace_bf9ffd2b22c7d819::function_8ce5b106fbba9e9f(&function_9bf15d9bf66ead8d);
    namespace_bf9ffd2b22c7d819::function_8fe6d6539ed31a88(&function_e60ebcdf4083532e);
  }
}

function function_797b21b78b5e0a26(respawntype) {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  foreach(player in level.players) {
    if(isDefined(player)) {
      var_ec0fc26262ef7791 = level.brgametype.issolos || level.brgametype.var_9524142eb719a321 && getteamcount(player.team) == 1;

      if(var_ec0fc26262ef7791) {
        player.respawndelay = 0;
        player.issolo = 1;
        player setclientomnvar("ui_br_resurgence_respawn_type", 1);
        continue;
      }

      player.issolo = 0;
      player setclientomnvar("ui_br_resurgence_respawn_type", 0);
    }
  }
}

function function_4f5568cf15d60b8() {
  if(!istrue(level.brgametype.var_f439c17a413f05c3)) {
    return;
  }

  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  foreach(player in level.players) {
    if(isDefined(player)) {
      assert(!isDefined(player.var_8c5c47f81a1869e5), "<dev string:x291>");
      player.var_8c5c47f81a1869e5 = &function_a045bcdb0d1bebf9;
    }
  }
}

function function_90507e372a40c684() {
  if(!istrue(level.brgametype.var_f9623a041e743669)) {
    return;
  }

  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  var_3b90a1ee7a57f5b1 = [];

  foreach(perkref in level.cacperks) {
    if(function_793956fb93de9504(perkref)) {
      menuslot = level.perkbundles[perkref].menuslot;

      if(!isDefined(var_3b90a1ee7a57f5b1[menuslot])) {
        var_3b90a1ee7a57f5b1[menuslot] = [];
      }

      addindex = var_3b90a1ee7a57f5b1[menuslot].size;
      var_3b90a1ee7a57f5b1[menuslot][addindex] = perkref;
    }
  }

  level.brgametype.var_3b90a1ee7a57f5b1 = var_3b90a1ee7a57f5b1;
}

function function_793956fb93de9504(perkref) {
  return isDefined(level.perkbundles[perkref]) && istrue(level.perkbundles[perkref].var_594af43597023062) && istrue(level.perkbundles[perkref].specialistbr) && !istrue(level.perkbundles[perkref].brdisabled);
}

function function_10870c1a437402b() {
  var_faeedaf859fd76f6 = [];
  deltatime = -15;
  circleindex = getdvarint(@ "scr_br_dropbag_circle_index", 1);
  closetime = scripts\mp\gametypes\br_circle::getcircleclosetime(circleindex);
  defaultval = max(0, closetime + deltatime);
  dropdelay = getdvarfloat(@ "hash_b81b25bcd8c7d749", defaultval);

  if(dropdelay == -1) {
    dropdelay = defaultval;
  }

  var_faeedaf859fd76f6[var_faeedaf859fd76f6.size] = dropdelay;
  circleindex = getdvarint(@ "hash_ddcef5da1224b559", -1);

  if(circleindex > 0) {
    closetime = scripts\mp\gametypes\br_circle::getcircleclosetime(circleindex);
    defaultval = max(0, closetime + deltatime);
    dropdelay = getdvarfloat(@ "hash_3771b5264b3f0789", defaultval);

    if(dropdelay == -1) {
      dropdelay = defaultval;
    }

    var_faeedaf859fd76f6[var_faeedaf859fd76f6.size] = dropdelay;
  }

  scripts\mp\gametypes\br_gametypes::registerbrgametypedata("dropBagDelay", var_faeedaf859fd76f6);
}

function function_9680317afd0e4558() {
  level endon("game_ended");
  circleindex = getdvarint(@ "hash_18ddb1ff66d76c3e", 5);
  closetime = scripts\mp\gametypes\br_circle::getcircleclosetime(circleindex);
  level waittill("prematch_started");
  wait closetime;
  circlecenter = level.br_level.br_circlecenters[circleindex];
  radius = level.br_level.br_circleradii[circleindex];
  count = getdvarint(@ "hash_d56a2151b61e380c", 3);
  step = 360 / count;
  yaw = 0;

  for(i = 0; i < count; i++) {
    yaw += step;
    var_f7d73ac7e17aa57e = (0, yaw, 0);
    dropcenter = circlecenter + anglesToForward(var_f7d73ac7e17aa57e) * radius * 0.5;
    randompoint = scripts\mp\gametypes\br_circle::getrandompointinboundscircle(dropcenter, radius * 0.5, 0.25, 0.75, 1, 0, 1);

    level thread scripts\cp_mp\utility\debug_utility::drawline(circlecenter, dropcenter, 999, (1, 1, 0));

    scripts\mp\gametypes\br_deployable_kiosk::function_590979ef771686a8(undefined, randompoint);
  }
}

function function_721a7410f27c2d8f() {
  level endon("<dev string:x2ba>");

  while(true) {
    circleindex = getdvarint(@ "hash_14d4db7faf2d7cd1", -1);

    if(circleindex > 0) {
      setDvar(@ "hash_14d4db7faf2d7cd1", -1);
      circlecenter = level.br_level.br_circlecenters[circleindex];
      radius = level.br_level.br_circleradii[circleindex];
      count = getdvarint(@ "hash_ac62a62c1d7f665d", 3);
      step = 360 / count;
      yaw = 0;

      for(i = 0; i < count; i++) {
        yaw += step;
        var_f7d73ac7e17aa57e = (0, yaw, 0);
        dropcenter = circlecenter + anglesToForward(var_f7d73ac7e17aa57e) * radius * 0.5;
        randompoint = scripts\mp\gametypes\br_circle::getrandompointinboundscircle(dropcenter, radius * 0.5, 0, 0.9, 1, 0, 1);
        level thread scripts\cp_mp\utility\debug_utility::drawline(circlecenter, dropcenter, 999, (1, 1, 0));
        scripts\mp\gametypes\br_deployable_kiosk::function_590979ef771686a8(undefined, randompoint);
      }
    }

    waitframe();
  }
}

function function_c2e48f2200bd249b() {
  circlecenter = getdvarvector(@ "hash_eb589c6bd2884bbb", level.var_e6bdefd8842bdd49);
  return circlecenter;
}

function function_98609987fbc9bcc3(args) {
  if(args.size == 0) {
    return;
  }

  command = args[0];
  host = scripts\mp\gamelogic::gethostplayer();

  switch (command) {
    case #"hash_a172f0299633692c":
      forceshow = 0;

      if(isDefined(args[1]) && int(args[1]) == 1) {
        forceshow = 1;
      }

      host function_9e3c77b199d3c8c8(forceshow);
      break;
    case #"hash_e56d45470c871021":
      host function_cb7114374c912a6f();
      break;
    case #"hash_2c58990905f03e75":
      event = "<dev string:x2e3>";

      if(isDefined(args[1])) {
        event = args[1];
      }

      host function_927f6139e79412c1(event);
      break;
  }
}

function function_9e3c77b199d3c8c8(forceshow) {
  assert(level.brgametype.var_bbde847aed85512a, "<dev string:x2eb>");
  teamdata = level.teamdata[self.team];
  alivecount = teamdata["<dev string:x308>"];
  assert(alivecount > 0, "<dev string:x316>");

  if(forceshow) {
    function_4744bb1db1b48f9a(alivecount);
    return;
  }

  teammates = array_remove(teamdata["<dev string:x32a>"], self);
  spectated = undefined;

  foreach(teammate in teammates) {
    spectated = teammate getspectatingplayer();

    if(isDefined(spectated) && spectated.team == self.team) {
      teammate notify("<dev string:x335>");
      break;
    }
  }

  assert(isDefined(spectated), "<dev string:x345>");
}

function function_cb7114374c912a6f() {
  if(istrue(self.issolo)) {
    return;
  }

  aliveplayers = getteamdata(self.team, "<dev string:x35c>");
  var_d0b996fde8bfc937 = level.teamdata[self.team]["<dev string:x36c>"];

  if(var_d0b996fde8bfc937.size <= 0 || aliveplayers.size <= 0) {
    assertmsg("<dev string:x37b>");
    return;
  }

  foreach(item in var_d0b996fde8bfc937) {
    if(!isDefined(item)) {
      continue;
    }

    if(isDefined(item.killer) && item.killer != item && isDefined(item.player)) {
      attackername = scripts\mp\gametypes\br_dev::function_5d92949cc218ebdd(item.killer.name);
      victimname = scripts\mp\gametypes\br_dev::function_5d92949cc218ebdd(aliveplayers[0].name);
      scripts\mp\gametypes\br_dev::function_5b5ab8ab53c49d4d(attackername, victimname);
    }
  }
}

function function_927f6139e79412c1(event) {
  aliveplayers = getteamdata(self.team, "<dev string:x35c>");
  event = function_1823ff50bb28148d(event);
  aliveplayers[0] scripts\mp\utility\points::doscoreevent(event);
}

function function_e793259b8f9d5b2d() {
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("isTeamEliminated", &function_ed345d3efb37c25c);
  level.checkforlaststandwipe = &function_7657b6775b05e1b9;
  level.brgametype.var_b43745b85f249e68 = 1;
  level.var_9f2c0d537922a861 = 1;
}

function function_ed345d3efb37c25c(teamname) {
  return false;
}

function function_7657b6775b05e1b9(victim, islaststanddeath) {
  return false;
}

function private function_123793b0882ec6fb(newstate) {
  scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc("ui_resurgence_care_request", 0, 2, newstate);
}

function private function_bd49896ab411c64c(alivecount) {
  scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc("ui_resurgence_care_request", 2, 3, alivecount);
}

function playerwelcomesplashes(data) {
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("infil_animatic_complete");

  if(istrue(self.issolo)) {
    scripts\mp\gametypes\br_public::brleaderdialogplayer("primary_objective_solo", self, undefined, undefined, 1.5);
    return;
  }

  scripts\mp\gametypes\br_public::brleaderdialogplayer("primary_objective", self, undefined, undefined, 1.5);

  if(istrue(self.isbrsquadleader)) {
    scripts\mp\gametypes\br_public::brleaderdialogplayer("deploy_squad_leader", self, 1, 0, 4.5);
  }
}

function private function_dbe2065974832286() {
  if(getdvarint(@ "hash_ff0013edaa24f162", 0)) {
    level callback::add("register_team_data", &register_team_data);
    level callback::add("on_squad_wiped", &on_squad_wiped);
  }

  level callback::add("on_squad_eliminated", &function_8882e0941c41b8ce);
  function_f94d1138d1114c5d();

  debug_init();
}

function private function_f94d1138d1114c5d() {
  game["dialog"]["squad_wipe_streak_" + "leader"] = "rsec_grav_rwsl_01";
  game["dialog"]["squad_wipe_streak_" + "kill_leader"] = "rsec_grav_rwsk";
  game["dialog"]["squad_wipe_streak_" + "fun_killer"] = "rses_grav_rwsf";
  game["dialog"]["squad_wipe_streak_" + "milestone"] = "rses_grav_rwsm";
  game["dialog"]["squad_count_" + "ten_squads"] = "rsre_grav_rtsr";
  game["dialog"]["squad_count_" + "five_squads"] = "rsre_grav_rfsr";
  game["dialog"]["squad_count_" + "three_squads"] = "rsre_grav_rtss";
}

function on_squad_wiped(params) {
  victim = params.victim;

  if(!isDefined(victim)) {
    if(getdvarint(@ "hash_30bdc56c2a2ef592", 1)) {
      logstring("[SQUAD WIPE] There was no victim.");
    }

    return;
  }

  if(!isDefined(victim.attacker)) {
    if(getdvarint(@ "hash_30bdc56c2a2ef592", 1)) {
      logstring("[SQUAD WIPE] There was no attacker on the victim.");
    }

    return;
  }

  if(!isPlayer(victim.attacker)) {
    if(getdvarint(@ "hash_30bdc56c2a2ef592", 1)) {
      logstring("[SQUAD WIPE] Attacker wasn't a player it was: " + (isDefined(victim.attacker.classname) ? victim.attacker.classname : "undefined"));
    }

    return;
  }

  if(victim.attacker == victim) {
    if(getdvarint(@ "hash_30bdc56c2a2ef592", 1)) {
      logstring("[SQUAD WIPE] Attacker was the victim, it was a suicide? Player: " + victim.name + " Team: " + victim.team);
    }

    return;
  }

  params = {
    #notification: "team_wiped", #victim: victim, #attacker: victim.attacker, #var_e6b4a44e236fd54f: "squad_wipes"};
  level function_c2154554e89d5e91(params);
  attacker_streak = level teams::getteamdata(victim.attacker.team, "squad_wipes");

  if(getdvarint(@ "hash_30bdc56c2a2ef592", 1)) {
    logstring("[SQUAD WIPE] Attacker: " + victim.attacker.name + " | Victim: " + victim.name + " | Attacker Wipe Count: " + attacker_streak);
  }
}

function function_8882e0941c41b8ce(params) {
  switch (params.remaining_teams.size) {
    case 10:
      dialog = "squad_count_" + "ten_squads";
      break;
    case 5:
      dialog = "squad_count_" + "five_squads";
      break;
    case 3:
      dialog = "squad_count_" + "three_squads";
      break;
    default:
      dialog = undefined;
      break;
  }

  if(isDefined(dialog)) {
    br_public::brleaderdialog(dialog, 1, undefined, undefined, 1, undefined, "dx_br_smis_");
  }
}

function private function_c2154554e89d5e91(params) {
  var_e6b4a44e236fd54f = params.var_e6b4a44e236fd54f;
  attacker = params.attacker;
  victim = params.victim;
  notification = params.notification;
  dialogues = [];
  level teams::modifyteamdata(attacker.team, var_e6b4a44e236fd54f, 1);
  victim_streak = level teams::getteamdata(victim.team, "curr_" + var_e6b4a44e236fd54f);

  if(victim_streak > 0) {
    dialogues[dialogues.size] = {
      #priority: 50, #dialog: "fun_killer"};

    if(getdvarint(@ "hash_30bdc56c2a2ef592", 1)) {
      logstring("[SQUAD WIPE COMMON] " + attacker.team + " stopped team " + victim.team + " that was on a streak of " + victim_streak);
    }
  }

  best_team = function_1e1cf28c03396eb0(var_e6b4a44e236fd54f);

  if(isDefined(best_team)) {
    if(best_team.team == victim.team) {
      dialogues[dialogues.size] = {
        #priority: 75, #dialog: "kill_leader"};

      if(getdvarint(@ "hash_30bdc56c2a2ef592", 1)) {
        logstring("[SQUAD WIPE COMMON] " + attacker.team + " eliminated the best team " + victim.team);
      }
    }
  }

  level teams::setteamdata(victim.team, "curr_" + var_e6b4a44e236fd54f, 0);
  level teams::modifyteamdata(attacker.team, "curr_" + var_e6b4a44e236fd54f, 1);
  attacker_streak = level teams::getteamdata(attacker.team, "curr_" + var_e6b4a44e236fd54f);
  var_4cc70810cb57584a = level teams::getteamdata(attacker.team, "best_" + var_e6b4a44e236fd54f);

  if(attacker_streak > var_4cc70810cb57584a) {
    level teams::setteamdata(attacker.team, "best_" + var_e6b4a44e236fd54f, attacker_streak);
  }

  level function_541b1f28c772eb1f(attacker.team, attacker_streak, var_e6b4a44e236fd54f, notification);
  level notify(notification + "_" + victim.team);
  prev_best = best_team;
  best_team = function_1e1cf28c03396eb0(var_e6b4a44e236fd54f);

  if(isDefined(best_team)) {
    if(!isDefined(prev_best) || isDefined(prev_best) && prev_best.team != best_team.team) {
      dialogues[dialogues.size] = {
        #priority: 100, #dialog: "leader"};

      if(getdvarint(@ "hash_30bdc56c2a2ef592", 1)) {
        logstring("[SQUAD WIPE COMMON] " + best_team.team + " became the best team beating team " + (isDefined(prev_best) ? prev_best.team : "none") + " with count of " + best_team.streak);
      }
    }
  }

  if(attacker_streak > 1 && attacker_streak % 2 == 1) {
    dialogues[dialogues.size] = {
      #priority: 25, #dialog: "milestone"};

    if(getdvarint(@ "hash_30bdc56c2a2ef592", 1)) {
      logstring("[SQUAD WIPE COMMON] " + attacker.team + " is on a consecutive streak at " + attacker_streak);
    }
  }

  if(dialogues.size > 0) {
    selected_entry = dialogues[0];

    if(dialogues.size > 1) {
      foreach(entry in dialogues) {
        if(entry.priority >= selected_entry.priority) {
          selected_entry = entry;
        }
      }
    }

    if(getdvarint(@ "hash_898f9c951ebe309d", 1)) {
      br_public::brleaderdialogteam("squad_wipe_streak_" + selected_entry.dialog, attacker.team, 1, 2.5, undefined, "dx_br_smis_");

      if(getdvarint(@ "hash_30bdc56c2a2ef592", 1)) {
        logstring("[SQUAD WIPE COMMON] Playing dialog: " + selected_entry.dialog + " to " + attacker.team);
      }
    }
  }

  if(getdvarint(@ "hash_a6bf6be37dfd1198", 1)) {
    trace_height = 5000;
    var_ba4f4b9b7988606f = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();

    if(isDefined(var_ba4f4b9b7988606f)) {
      trace_height = var_ba4f4b9b7988606f.origin[2];
    }

    contents = trace::create_contents(0, 1, 1);
    trace = trace::ray_trace((victim.origin[0], victim.origin[1], trace_height), victim.origin, [victim], contents);
    outpos = isDefined(trace["position"]) ? trace["position"] : victim.origin;
    utility::delaythread(0.2, &function_36a7e4c6cbac83d6, outpos);
  }

  scripts\cp_mp\challenges::function_b8e86c6dea0ac027(params.attacker, attacker_streak);
  function_234b304f15f0399a(attacker_streak, victim_streak);
}

function private function_1e1cf28c03396eb0(var_e6b4a44e236fd54f) {
  best_team = {
    #team: undefined, #streak: 0
  };

  foreach(team in level.teamnamelist) {
    streak = level teams::getteamdata(team, "curr_" + var_e6b4a44e236fd54f);

    if(streak > 0 && streak > best_team.streak) {
      best_team.streak = streak;
      best_team.team = team;
    }
  }

  return best_team.streak > 0 ? best_team : undefined;
}

function private function_36a7e4c6cbac83d6(outpos) {
  level endon("game_ended");
  namespace_c133516bfc1d803c::utilflare_shootflare(outpos, "elimination_flare");
}

function private function_dbbb1cb5b53ea9e5(a, b) {
  if(!isDefined(a.var_14110ad8d5069e7)) {
    a.var_14110ad8d5069e7 = -1;
  }

  if(!isDefined(b.var_14110ad8d5069e7)) {
    b.var_14110ad8d5069e7 = -1;
  }

  return a.var_14110ad8d5069e7 <= b.var_14110ad8d5069e7;
}

function private function_541b1f28c772eb1f(team, streak, var_e6b4a44e236fd54f, notification) {
  level endon("game_ended");
  timer = function_3e57da11d0b56753(team, streak);

  if(getdvarint(@ "hash_4cff443e8f01394f", 0) && streak > 1) {
    timer += function_9c7dc3a5c44b7ab5(team);
  }

  level thread function_15795adcb3808397(team, timer, var_e6b4a44e236fd54f, notification);
  timer = int(gettime() + timer * 1000);

  foreach(player in teams::getteamdata(team, "players")) {
    player setclientomnvar("ui_br_squad_wipe_streak_timer_end_ms", timer);
    player setclientomnvar("ui_br_squad_wipe_streak_count", streak);
  }
}

function private function_3e57da11d0b56753(team, streak) {
  return getdvarint(@ "hash_980df9696fd73176", 90);
}

function private function_9c7dc3a5c44b7ab5(team) {
  timer = 0;

  foreach(player in teams::getteamdata(team, "players")) {
    timer = player getclientomnvar("ui_br_squad_wipe_streak_timer_end_ms");

    if(timer > 0) {
      timer -= gettime();
      timer *= 0.001;
      break;
    }
  }

  assertex(timer > 0, "<dev string:x394>");
  return timer;
}

function private function_15795adcb3808397(team, time, var_e6b4a44e236fd54f, notification) {
  level endon("game_ended");
  level endon(notification + "_" + team);
  level endon("wipestreak_ended_" + team);
  level notify("wipestreak_timer_" + team);
  level endon("wipestreak_timer_" + team);
  wait time;

  foreach(player in teams::getteamdata(team, "players")) {
    player setclientomnvar("ui_br_squad_wipe_streak_timer_end_ms", 0);
    player setclientomnvar("ui_br_squad_wipe_streak_count", 0);
  }

  level teams::setteamdata(team, "curr_" + var_e6b4a44e236fd54f, 0);
  level notify("wipestreak_ended_" + team);
}

function private register_team_data(params) {
  foreach(team in level.teamnamelist) {
    level.teamdata[team]["squad_wipes"] = 0;
    level.teamdata[team]["curr_squad_wipes"] = 0;
    level.teamdata[team]["best_squad_wipes"] = 0;
  }
}

function private function_234b304f15f0399a(attacker_streak, victim_streak) {
  eventparams = ["attacker_streak", attacker_streak, "victim_streak", victim_streak];
  dlog_recordevent("dlog_event_br_squad_wipe", eventparams);
}

function function_b0bb8889afbb0c83() {
  var_e0f4d3685ff5c5bc = 50000;
  var_2121aa51c2c8132e = 80;
  var_409d356961c27474 = 15;
  return [var_e0f4d3685ff5c5bc, var_2121aa51c2c8132e, var_409d356961c27474];
}

function function_843d05502816cbce() {
  return 0.001;
}

function function_635472137de2fc6a(player) {
  if(istrue(player.issolo)) {
    return level.brgametype.var_34555edfbd2e0e3a;
  }

  return undefined;
}

function function_68890b211f0ae411() {
  name = undefined;

  if(istrue(level.brgametype.resurgencepoi_militarybase)) {
    name = "resurgencepoi_militarybase";
  } else if(istrue(level.brgametype.resurgencepoi_popovpower)) {
    name = "resurgencepoi_popovpower";
  } else if(istrue(level.brgametype.resurgencepoi_suburbs)) {
    name = "resurgencepoi_suburbs";
  } else if(istrue(level.brgametype.resurgencepoi_superstore)) {
    name = "resurgencepoi_superstore";
  }

  return name;
}

function debug_init() {
  setdvarifuninitialized(@ "hash_980df9696fd73176", function_3e57da11d0b56753());
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x3cf>");
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x3e4>", "<dev string:x3ff>", &function_cec96fed16a6d8e8);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x41e>", "<dev string:x439>", &function_eaf6e107769f9877);
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:x450>", "<dev string:x464>");
  scripts\common\devgui::function_fe953f000498048f();
}

function function_cec96fed16a6d8e8() {
  shoot_pos = level.players[0].origin + anglesToForward(level.players[0].angles) * 240;
  namespace_1eb3c4e0e28fac71::utilflare_shootflare(shoot_pos, "<dev string:x487>");
}

function function_eaf6e107769f9877() {
  if(!isDefined(level.teamdata[level.players[0].team]["<dev string:x49c>"])) {
    setDvar(@ "hash_6ffa7b0113bccfb7", 0);
    register_team_data();
  }

  player = level.players[0];

  foreach(player in level.players) {
    if(!player ishost()) {
      break;
    }
  }

  assertex(!player ishost(), "<dev string:x4ab>");
  player.attacker = level.players[0];
  params = {
    #victim: player
  };
  on_squad_wiped(params);
}

# /