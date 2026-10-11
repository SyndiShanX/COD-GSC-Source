/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_744cad313ed0a87e.gsc
*************************************************/

#using script_15ca41a3fbb0e379;
#using script_24fbedba9a7a1ef4;
#using script_2d9d24f7c63ac143;
#using script_367c2e5a914658d7;
#using script_4948cdf739393d2d;
#using script_64acb6ce534155b7;
#using script_744cad313ed0a87e;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;
#using scripts\mp\ai_heli_reinforce;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_bosses;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\hud_message;
#using scripts\mp\locksandkeys;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\poi;
#using scripts\mp\team_assimilation;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#namespace namespace_c62d39d6e6afb119;

function init() {
  function_8e61cd66a8bf3a15();
  var_f21aee017029a303 = scripts\cp_mp\utility\game_utility::function_17314ce12820727a(level.gametypebundle.var_6615fee3cfcc9303);
  var_f21aee017029a303 = default_to(var_f21aee017029a303, spawnStruct());
  level.var_ae1d349936f03e25 = getdvarint(@ "hash_a548f73a693dc467", 1);
  level.var_533a7509e21859e7 = getdvarint(@ "hash_9a75b66731024fc5", 0);
  level.var_869fc47ee0767fb6 = getdvarint(@ "hash_c38245340783c038", 0);
  level.var_b8cb2593401fd2a = getdvarint(@ "hash_f1490edf7243e578", 1);
  level.var_c40b3245a2c38005 = getdvarint(@ "hash_9b83f219dbcdd103", 3);
  level.var_9b17b74fa23ad4e7 = getdvarint(@ "hash_772660b4939094ed", 0);
  level.var_3a56dc9f81b0ccf3 = getdvarint(@ "hash_ebe66eedd5a40e2d", 125);
  level.var_f45f69ff57434c35 = getdvarint(@ "hash_89b383cbd3e0b74f", 0);
  level.var_b25f34fe30b345d6 = getdvarint(@ "hash_c9b74ec39ec8ea00", 1);
  level.var_53f26aece124345a = getdvarint(@ "hash_f63f442574298198", 1);
  level.var_216890f92cb91c6e = function_ee26a62ef3d1372d(@ "hash_4e23a23e5741d450", 5000, var_f21aee017029a303.uavpingradius);
  level.var_313687786f342b97 = getdvarint(@ "hash_6f77a6f42b116ea5", 1);
  level.var_9876d350e8206107 = getdvarint(@ "hash_ab03e9221c1e794d", 1);
  level.var_8484c417e9016033 = getdvarint(@ "hash_f9d5124be749fbdd", 0);
  level.var_29e2409cb4899e54 = getdvarint(@ "hash_f2f0c39275318f92", 0);
  level.var_e352d252847915ab = getdvarint(@ "hash_1d510c110e24122d", 1);
  level.var_94d533fb4f4e5728 = getdvarint(@ "hash_2609ca4ecfdbf87a", 0);
  level.var_ccbb1eb445b88cc0 = getdvarint(@ "hash_e13a9a03b22ad23a", 0);
  level.var_be265257b0c58303 = getdvarint(@ "hash_6329defa0aceadc9", 1);
  level.var_f20f4dd3b7825826 = getdvarint(@ "hash_922ffe5a5e9d97a0", 1);
  level.var_ac683c8b10600fbe = getdvarint(@ "hash_a18d4377d94eae9c", 0);
  level.var_392e6097df364a4b = getdvarint(@ "hash_3960b3967d47fc25", 1);
  level.var_b2a3e71c256922ac = getdvarint(@ "hash_36fa70534f7c71be", 1);
  level.var_f7e7f7a251965b3b = getdvarint(@ "hash_ef904bc4f9b7199e", 1);
  level.var_2639f3fc464bef6d = getdvarint(@ "hash_dbd7f1c05e9d1ac3", 0);
  level.var_c1bd59bc77e5ab37 = getdvarint(@ "hash_f7c2fb38c808f6d1", 1);
  level.var_4fe32157adc88b9c = getdvarfloat(@ "hash_d678f89c56394436", 1);
  level.var_dd1138d16246e714 = getdvarint(@ "hash_fea3783342891633", 0);
  level.var_8ab39bbb40bf6536 = getdvarint(@ "hash_90075aa97a84d864", 1);
  level.var_7b64ce476358728a = getdvarint(@ "hash_57b2dfb79db9e538", 1);
  level.var_59db4040670349de = getdvarint(@ "hash_b1d94b8465ec5dcc", 1);
  level.var_25e8b4afe5e06169 = getdvarint(@ "hash_17e125a3d0d93c4f", 1);
  level.var_ac1bfebb54363b49 = getdvarint(@ "hash_8d5822a6fa00079f", 1);
  level.var_702998e8e05d126f = getdvarint(@ "hash_ec24e29b82825225", 1);
  level.var_9c099ce9c9abf6a6 = getdvarint(@ "hash_daae63568e0de834", 1969);
  level.var_56031a60fe206063 = getdvarint(@ "hash_f3184910235e876d", 2952);
  level.var_10171e70e51c0380 = function_ee26a62ef3d1372d(@ "hash_2d4baa06ee8ca9fa", 0, level.gametypebundle.var_f68a98ed3087ea80);
  level.var_b098cf330b024cb9 = function_ee26a62ef3d1372d(@ "hash_5933328d445119e3", 4, var_f21aee017029a303.var_868d2bc3e494da83);
  level.var_153bec2ca80c491a = getdvarint(@ "hash_8b41cf6a1579ea8", 1);
  level.var_88dbaed1222dcd10 = function_ee26a62ef3d1372d(@ "hash_f499fce58dc0cafe", 0, level.gametypebundle.var_9719f1289ae30e63);
  level.var_e87dd990ed2a494c = function_ee26a62ef3d1372d(@ "hash_e7aa3e625a6850d6", 0, level.gametypebundle.var_ecae0490a5f1f04c);
  level.var_316321eb17328d69 = function_ee26a62ef3d1372d(@ "hash_b8e93bd4183a1e27", 7500, var_f21aee017029a303.var_7f373afdfc903327);
  level.var_7c75865525573b26 = getdvarint(@ "hash_60010b42c3a74948", 0);
  level.var_7e293d1e9b987629 = getdvarint(@ "hash_53dc64d271853c47", 3);
  level.var_60fdd9e24d99e3ce = getdvarint(@ "hash_594dd9af844f40f4", 0);
  level.var_3d652c7cd2f573b8 = getdvarint(@ "hash_f669e5988839677a", 1);
  level.var_521e69d9c1e570d0 = getdvarint(@ "hash_ce03b41bc950b246", 1);
  level.var_5e111662782c87bc = getdvarint(@ "hash_8f2d97abb6413856", 1);
  level.var_af0f258868936569 = getdvarfloat(@ "hash_aeda1ef39b3022cf", 0);
  level.var_97430573e62d0760 = getdvarint(@ "hash_1e00631d1cf758ee", 0);
  level.var_63d0544474ed373 = getdvarint(@ "hash_1a0e3a39d254e599", 1);
  level.var_48d50c4fdd3feb83 = getdvarint(@ "hash_561a5ad6c44a2fe1", 1);
  level.var_8a45fbdabac853fd = getdvarint(@ "hash_cd3c6597c91fb18b", 1);
  level.var_e34d534debb61eda = getdvarint(@ "hash_1f19a9018aa681ac", 500);
  level.var_2e0a0145252b7f6a = getdvarint(@ "hash_adee62adf53adaa4", 4700);
  level.var_134d393a2d69b578 = getdvarint(@ "hash_1f1ef634cce458c2", 3380);
  level.var_1f6bf7cc2543812 = getdvarint(@ "hash_f42d99267f21a948", 1);
  level.var_2f77bc06c763e3f = getdvarint(@ "hash_5c7d3a0d96cdcddd", 0);
  level.var_1e0470dbb6cf1859 = function_ee26a62ef3d1372d(@ "hash_7f93e7a0c51e45d3", 1, level.gametypebundle.var_4f0cbe70f227a6);
  level.var_e1d6de991e0a323c = function_ee26a62ef3d1372d(@ "hash_cc4306417464f5ea", 1, level.gametypebundle.var_b0cf1d2333d80742);
  level.var_187b57dd871ec189 = getdvarint(@ "hash_e313a0c044380b83", 0);
  level.var_6e53394b95fde2bf = getdvarint(@ "hash_b4f229cf01daff3d", 1);
  level.var_870abcbf773fbd8c = getdvarint(@ "hash_773f65c9738bbd46", 0);
  level.var_4094a9c5b998313d = getdvarint(@ "hash_3b30dfc93362b5e7", 0);
  level.var_2c04b8bf908257a4 = getdvarint(@ "hash_601d9436fd9cbd67", 0);
  level.var_d9cb3757eeb88258 = getdvarint(@ "hash_79981e39b4ab53a2", 0);
  level.var_9e4101a579ae1680 = getdvarint(@ "hash_dba490fd2fc2dbf6", 0);
  level.var_53e7795f958213 = getdvarint(@ "hash_3872377777565d5d", 1);

  if(istrue(level.var_d9cb3757eeb88258) && istrue(level.var_53e7795f958213)) {
    level.var_adc6d9da6cadf81d = getdvarint(@ "hash_2e6e5c7e5795edd7", 1);
    level.var_c77adbf64b306ab = getdvarint(@ "hash_40eb0bbe08ebac21", 1);
    level.var_b689ba1b4a0c1f5d = getdvarint(@ "hash_5db5111d9c19dfff", 2);
    level.var_156c5b503b29e858 = getdvarint(@ "hash_dbddd7abcb0013c6", 1);
    level.var_bc42d1a8badab89d = getdvarint(@ "hash_b52aabf1eb3553d7", 1);
    level.var_5c2392ebd13a33c = getdvarint(@ "hash_e08951362dcea2ba", 1);
    level.var_9315a2b45ca76f29 = getdvarint(@ "hash_37b3893d7c81aa93", 2);
    level.var_4ad06d80f390745e = getdvarint(@ "hash_40fc928ac44a028c", 1);
    level.var_6565786392240cdf = getdvarint(@ "hash_21c2f52d8f791439", 2);
    level.var_7b9b32e96c4127e2 = getdvarint(@ "hash_6dd965af7059d908", 1);
    level.var_d449a1c1585aa2eb = getdvarint(@ "hash_a914e51d9f83180d", 2);
    level.var_10378f84ce5d051 = getdvarint(@ "hash_fc5f26eba90002cf", 1);
    level.var_d87d73c3d6ff6705 = getdvarint(@ "hash_29910585f576de7", 120);
    level.var_bd092c2beee1c8c = getdvarint(@ "hash_9cfad7502cfe3dfa", 5);
    level.var_8d0436f6f57eda69 = getdvarint(@ "hash_dab1b2ce871be59f", 7);
    level.var_b419b238d63cdfc6 = getdvarint(@ "hash_eafaa01b1d2aea88", 1);
  }

  level.var_7c680177b019802c = getdvarint(@ "hash_9b00cb399771cd0e", 1);
  level.var_3f29c197a71f3be9 = function_ee26a62ef3d1372d(@ "hash_4af62e57f66d060b", 1, level.gametypebundle.var_58ce8dd08856f8be);
  level.var_e9fc3d6a8bde490d = function_ee26a62ef3d1372d(@ "hash_8749c165c9b43a93", 5, level.gametypebundle.var_b0dc7f556e9bb994);

  level.var_5d89e32b0b1d5e91 = getdvarint(@ "hash_db36f5e1c5dbda4b", 0);
  level.var_1be05623f95c1ecb = getdvarint(@ "hash_90652373649d1199", 0);

  if(level.mapname == "<dev string:x1c>" || level.mapname == "<dev string:x2f>" || level.mapname == "<dev string:x46>") {
    level.var_796c2a6da634b24 = getdvarint(@ "hash_26de70cd80710cae", 0);
    level.var_b9acfc4a678e5661 = getdvarint(@ "hash_4509a9a66cf96b33", 1);
  }

  level.var_2c82c974f7e53094 = getdvarfloat(@ "hash_61c9225a3e410ede", 1);
  level.var_86fcb3b210c000b6 = getdvarint(@ "hash_e2eeaeee36606ddc", 650);
  level.var_abfb14890546e79b = getdvarint(@ "hash_c280c69506f5857d", 5);
  squadsize = scripts\cp_mp\utility\game_utility::function_4fb37368ae3585bb();
  level.var_af6b6798e49e6f50 = function_370c5539313daf66(@ "hash_675cda2ce24e3c49", 1.75, var_f21aee017029a303.var_5cc7c0ac7c987878);

  if(isDefined(squadsize)) {
    if(squadsize >= 4) {
      level.var_af6b6798e49e6f50 = function_370c5539313daf66(@ "hash_657353b7b97e54fc", 2, var_f21aee017029a303.var_ef03ff215527e41d);
    } else if(squadsize == 3) {
      level.var_af6b6798e49e6f50 = function_370c5539313daf66(@ "hash_675cda2ce24e3c49", 1.75, var_f21aee017029a303.var_5cc7c0ac7c987878);
    } else if(squadsize == 2) {
      level.var_af6b6798e49e6f50 = function_370c5539313daf66(@ "hash_52304b9243159d05", 1.75, var_f21aee017029a303.var_d118a0f7eb2829da);
    } else if(squadsize == 1) {
      level.var_af6b6798e49e6f50 = function_370c5539313daf66(@ "hash_34b15491aa693b3c", 1.5, var_f21aee017029a303.var_a66e8def7a471969);
    }
  }

  scripts\mp\ai_mp_controller::function_c8393014dd7f8ab6();
  level.var_428703950599c9e9 = &function_428703950599c9e9;
  scripts\engine\utility::registersharedfunc("fortress", "acknowledge", &function_401ab3dde070adde);
  scripts\engine\utility::registersharedfunc("fortress", "spawn", &function_e2488f451ea1f1e7);
  scripts\engine\utility::registersharedfunc("br_loot_cache", "spawnLoot", &function_60523e441e1a1346);
  scripts\engine\utility::registersharedfunc("br_loot_cache_lege", "spawnLoot", &function_60523e441e1a1346);
  scripts\engine\utility::registersharedfunc("br_reusable_loot_cache", "spawnLoot", &function_60523e441e1a1346);

  if(!isDefined(level.supportsai)) {
    thread scripts\mp\ai_mp_controller::init();
  }

  scripts\mp\gametypes\br::function_15fa5f9b3a2b7a52();

  level thread function_595371fc4dfe389e();

  level waittill("br_prematchEnded");
  level thread namespace_9823ee6035594d67::fortress_init();
  level thread scripts\mp\locksandkeys::init();

  if(istrue(getdvarint(@ "hash_72ae262a8559256", 0))) {
    level thread namespace_2ffd685c7e2d86a3::activewarzoneinit();
  } else {
    logstring("Active Warzone Disabled - Not Init");
  }

  if(level.var_d9cb3757eeb88258) {
    level thread scripts\mp\ai_heli_reinforce::function_d0ffcd08e0870cf2();
  }

  function_c67a23fd0b31a4f7();

  if(level.var_392e6097df364a4b) {
    level thread scripts\mp\gametypes\br_bosses::initbosses();
  }

  if(scripts\mp\team_assimilation::function_6934349b7823d888()) {
    scripts\mp\team_assimilation::registerteamassimilatecallback(&function_24d72130103d8922);
  }

  game["dialog"]["strongholds_active"] = "pblc_grav_strr";
  game["dialog"]["br_mission_bomb_assigned"] = "strn_grav_dvdf";
  game["dialog"]["blacksite_reveal"] = "blck_wzan_rval";
  game["dialog"]["blacksite_clear"] = "blck_grav_cler";
  game["dialog"]["blacksite_jugg_engage"] = "bsbo_jugg_enga";
  game["dialog"]["blacksite_jugg_defend"] = "bsbo_jugg_defe";
  game["dialog"]["blacksite_jugg_warn"] = "bsbo_jugg_warn";
  game["dialog"]["blacksite_jugg_single_kill"] = "bsbo_jugg_siki";
  game["dialog"]["blacksite_jugg_team_kill"] = "bsbo_jugg_teki";

  if(getdvarint(@ "hash_ec7375cc2a0ca633", 1)) {
    thread scripts\mp\gametypes\br_analytics::function_97ec7995c587bf25();
  }

  level thread function_de1bd18e889bf4cf();

  if(getdvarint(@ "hash_8dc6aa0c1cad2eb2", 0)) {
    level thread function_2e05a3e6a13f7f41();
  }
}

function function_c67a23fd0b31a4f7() {
  if(getdvarint(@ "hash_738b7382a23ac132", 0)) {
    return;
  }

  scripts\engine\utility::registersharedfunc("ai", "dropLootOnAgentDeath", &scripts\mp\ai_mp_controller::function_82ed67ae79913551);
  scripts\mp\ai_mp_controller::function_5aee5d819f7dfd1c();
}

function function_428703950599c9e9() {
  scripts\mp\ai_mp_controller::function_b1d1e7e3b23e0dfe(["mission", "perfTesting", "fortressGuards", "fortressPatrols", "reinforcements", "elites", "extraGuards", "extraPatrols", "firstKillFodder", "spawnPackage", "civilian", "vehiclePatrol"]);
}

function function_401ab3dde070adde() {
  level.var_f1073fbd45b59a06.var_df987907a483df89 = [];
  level.var_f1073fbd45b59a06.unusedfortresses = level.var_f1073fbd45b59a06.var_8a40ff9ed07bd5f3;
  level.var_d295f7b9a28a5a53 = function_91a28c56c45a736f();

  if(!isDefined(level.var_d295f7b9a28a5a53)) {
    return;
  }

  foreach(zoneindex in level.var_d295f7b9a28a5a53) {
    zonename = function_aae8b5dc22c12d2c(zoneindex);
    zonebounds = function_6a9090e74fd4e90a(zoneindex);
    println("<dev string:x60>" + zoneindex + "<dev string:x6d>" + zonename + "<dev string:x74>" + zonebounds.midpoint);
    fortress = undefined;
    poiname = undefined;

    if(isDefined(zonename)) {
      poiname = scripts\mp\poi::poi_findpoioriginisin(zonebounds.midpoint, 1);

      if(isDefined(level.var_ab20b3a256911579) && array_contains(level.var_ab20b3a256911579, poiname)) {
        continue;
      }

      if(!function_fed261f698d76763(zoneindex, "fortress")) {
        continue;
      }

      fortress = function_baef4910acea00f0(zonebounds.midpoint);
    }

    if(isDefined(fortress)) {
      fortress.name = zoneindex;
      fortress.var_6a9a1aeeaa7c25df = "mainFortress";
      level.var_f1073fbd45b59a06.var_df987907a483df89[level.var_f1073fbd45b59a06.var_df987907a483df89.size] = fortress;
      level.var_f1073fbd45b59a06.unusedfortresses = array_remove(level.var_f1073fbd45b59a06.unusedfortresses, fortress);

      namespace_d1a9ca87d78d9813::function_9533653868e59fb6("<dev string:x7a>", fortress.var_6a9a1aeeaa7c25df, undefined, undefined, undefined, undefined, poiname, fortress.origin);
    }
  }
}

function function_8e61cd66a8bf3a15() {
  level.var_8b96eb6b6159e33b = ["fort_hotzone_04", "airport_hotzone_03", "fishtwn_hotzone_05", "lone_hotzone_03", "marshland_hotzone_01", "marshland_hotzone_02", "moderncity_hotzone_01", "oldtwn_hotzone_01", "sira_hotzone_04", "sunken_hotzone_01", "caves_hotzone_01", "mp_stronghold_test_area_03", "mp_stronghold_test_area_01", "me_mc_postoffice_01", "saba_embassy", "mp_fort_gw_sewers_01", "sira_mall_01_art", "me_resort_consite_01", "me_mc_police_academy_01", "lone_cargoship", "exhume_warehouse", "me_controltower_01", "sunken_hotzone_06", "cruce_compound", "oilfield_hotzone_05", "jup_industrial_powerplant_02", "rural_hotzone_07", "manor_hotzone_01", "resort_hotzone_01", "base_hotzone_04", "industrial_hotzone_01", "base_hotzone_05", "marina_hotzone_01", "gal_hotzone_blacksite_1", "gal_hotzone_blacksite_2", "resort_hotzone_13", "industrial_hotzone_04", "industrial_hotzone_07", "cargo_hotzone_01", "city_hotzone_02", "rural_hotzone_07"];
  level.var_6a9278e0ae8f035a = ["oilfield_hotzone_01", "oilfield_hotzone_02", "oilfield_hotzone_03", "oilfield_hotzone_04", "airport_hotzone_01", "airport_hotzone_02", "wartorn_hotzone_01", "wartorn_hotzone_02", "wartorn_hotzone_03", "wartorn_hotzone_04", "lone_hotzone_01", "lone_hotzone_02", "observatory_hotzone_01", "observatory_hotzone_02", "observatory_hotzone_03", "oldtwn_hotzone_02", "oldtwn_hotzone_03", "oldtwn_hotzone_04", "mtntwn_hotzone_01", "mtntwn_hotzone_02", "mtntwn_hotzone_03", "mtntwn_hotzone_04", "marshland_hotzone_03", "marshland_hotzone_04", "marshland_hotzone_05", "marshland_hotzone_06", "sira_hotzone_01", "sira_hotzone_02", "sira_hotzone_03", "sira_hotzone_05", "hydro_hotzone_01", "hydro_hotzone_02", "hydro_hotzone_03", "hydro_hotzone_04", "hydro_hotzone_05", "hydro_hotzone_06", "hydro_hotzone_07", "hydro_hotzone_08", "hydro_hotzone_09", "hydro_hotzone_10", "fort_hotzone_01", "fort_hotzone_02", "fort_hotzone_03", "moderncity_hotzone_02", "moderncity_hotzone_03", "moderncity_hotzone_04", "moderncity_hotzone_05", "moderncity_hotzone_06", "moderncity_hotzone_07", "moderncity_hotzone_08", "moderncity_hotzone_09", "moderncity_hotzone_10", "moderncity_hotzone_11", "moderncity_hotzone_12", "moderncity_hotzone_13", "moderncity_hotzone_14", "moderncity_hotzone_15", "moderncity_hotzone_16", "moderncity_hotzone_17", "moderncity_hotzone_18", "moderncity_hotzone_19", "moderncity_hotzone_20", "moderncity_hotzone_21", "moderncity_hotzone_22", "moderncity_hotzone_23", "moderncity_hotzone_24", "moderncity_hotzone_25", "sunken_hotzone_02", "sunken_hotzone_03", "sunken_hotzone_04", "sunken_hotzone_05", "sunken_hotzone_06", "me_village_house_02", "me_mc_civiccenter_bldg_06", "me_resort_consite_01", "fishtwn_hotzone_01", "fishtwn_hotzone_02", "fishtwn_hotzone_03", "fishtwn_hotzone_04", "fishtwn_hotzone_05", "fishtwn_hotzone_06", "caves_hotzone_02", "caves_hotzone_03", "caves_hotzone_04", "caves_hotzone_05", "exhume_hotzone_01", "exhume_hotzone_03", "exhume_hotzone_04", "mp_stronghold_test_area_02", "mp_stronghold_test_area_04", "cruce_compound", "jup_Residential_Lowtown_18", "jup_residential_apartment_17", "jup_residential_apartment_18", "jup_residential_apartment_21", "resort_hotzone_02", "resort_hotzone_03", "resort_hotzone_04", "industrial_hotzone_02", "industrial_hotzone_03", "lowtown_hotzone_01", "lowtown_hotzone_02", "lowtown_hotzone_03", "marina_hotzone_02", "marina_hotzone_03", "rural_hotzone_01", "rural_hotzone_02", "rural_hotzone_03", "cargo_hotzone_01", "cargo_hotzone_02", "cargo_hotzone_03", "base_hotzone_01", "base_hotzone_02", "base_hotzone_03"];
  level.var_39f9e8588d3d9832 = [];
  level.var_fca1cceb2ea53f9e = [];
  level.var_3f257583a3d3d122 = [];
}

function function_485340cc9569a658() {
  fortress = self;
  size = fortress.var_c8c070d7375ef1e;
  icon = undefined;
  fortress.missioncount = undefined;
  fortress.var_f1fcdfe0cfdf8c16 = undefined;
  tier = fortress function_b7a9796c95aa8e8d();
  assertex(isDefined(tier), "<dev string:x86>" + function_aae8b5dc22c12d2c(fortress.name) + "<dev string:x98>");

  switch (tier) {
    case #"hash_a4324aac758f0a84":
      fortress.missioncount = 0;
      fortress.tieroverride = 1;
      fortress.var_2ea336a7ebdede49 = "ui_map_icon_blacksite_default";
      fortress.var_cef34adbe3f8caab = "ui_map_icon_blacksite_inprogress";
      fortress.var_9b65e6a548478e7c = "ui_map_icon_blacksite_inactive";
      fortress.var_2253390a6ba835c3 = "ui_map_icon_blacksite_captured_blue";
      fortress.var_395a039bdc0591e2 = "ui_map_icon_blacksite_contest_default";
      fortress.var_c4b85c30a02a19f8 = "stronghold_black";
      fortress.tierkeys = 1;
      fortress.loadoutchance = 1;

      if(istrue(level.var_e1d6de991e0a323c)) {
        fortress.activities = ["poi", "poi", "poi"];
      } else {
        fortress.activities = [];
      }

      fortress.var_cab871d72c8eb111 = [360];
      fortress.shouldspawnboss = 1;
      fortress.isblacksite = 1;
      break;
    case #"hash_7e89154a96f625d":
      fortress.missioncount = 3;
      fortress.tieroverride = 1;
      fortress.var_2ea336a7ebdede49 = "ui_map_icon_stronghold";
      fortress.var_cef34adbe3f8caab = "ui_map_icon_stronghold_inprogress";
      fortress.var_9b65e6a548478e7c = "ui_map_icon_stronghold_inactive";
      fortress.var_2253390a6ba835c3 = "ui_map_icon_stronghold_captured";
      fortress.var_395a039bdc0591e2 = "ui_map_icon_obj_stronghold_contest_ping";
      fortress.var_c4b85c30a02a19f8 = "stronghold_mid";
      fortress.loadoutchance = 1;

      if(istrue(level.var_7b64ce476358728a)) {
        if(istrue(level.var_59db4040670349de)) {
          fortress.activities = ["hold", "hold", "hold", "hold"];
        } else {
          fortress.activities = ["hold", "hold", "hold", "bomb"];
        }
      } else {
        fortress.activities = ["bomb", "bomb", "bomb", "bomb"];
      }

      fortress.var_cab871d72c8eb111 = [160];
      fortress.shouldspawnboss = 0;
      break;
    case #"hash_2881ce6c1efb40c5":
      fortress.missioncount = 2;
      fortress.tieroverride = 1;
      fortress.var_2ea336a7ebdede49 = "ui_map_icon_stronghold";
      fortress.var_cef34adbe3f8caab = "ui_map_icon_stronghold_inprogress";
      fortress.var_9b65e6a548478e7c = "ui_map_icon_stronghold";
      fortress.var_2253390a6ba835c3 = "ui_map_icon_stronghold_captured";
      fortress.var_c4b85c30a02a19f8 = "stronghold_mid";
      fortress.loadoutchance = 0.5;
      fortress.activities = ["hold", "hold", "hold", "bomb"];
      fortress.var_cab871d72c8eb111 = [160];
      fortress.shouldspawnboss = 0;
      break;
    case #"hash_2f27546c22430661":
      fortress.missioncount = 1;
      fortress.tieroverride = 1;
      fortress.var_2ea336a7ebdede49 = "ui_map_icon_stronghold";
      fortress.var_cef34adbe3f8caab = "ui_map_icon_stronghold_inprogress";
      fortress.var_9b65e6a548478e7c = "ui_map_icon_stronghold";
      fortress.var_2253390a6ba835c3 = "ui_map_icon_stronghold_captured";
      fortress.var_c4b85c30a02a19f8 = "stronghold_low";
      fortress.loadoutchance = 0.1;
      fortress.activities = ["hold", "hold", "hold", "bomb"];
      fortress.var_cab871d72c8eb111 = [160];
      fortress.shouldspawnboss = 0;
      break;
  }

  if(tier != "black") {
    fortress.tieroverride = getdvarint(@ "hash_fab22f8e089aa79f", fortress.tieroverride);
  }
}

function function_b7a9796c95aa8e8d() {
  fortress = self;
  zonename = function_aae8b5dc22c12d2c(fortress.name);

  if(istrue(level.var_796c2a6da634b24)) {
    if(!istrue(level.var_1b2f85b0ae4ac35a)) {
      level.var_1b2f85b0ae4ac35a = 1;
      return "<dev string:xe0>";
    } else {
      level.var_1b2f85b0ae4ac35a = 0;
      return "<dev string:xe8>";
    }
  }

  tier = getDvar(@ "hash_783c94fc1fa40619", "<dev string:xe0>");

  if(array_contains(level.var_8b96eb6b6159e33b, zonename)) {
    return "black";
  }

  if(array_contains(level.var_6a9278e0ae8f035a, zonename)) {
    return "high";
  }

  if(array_contains(level.var_39f9e8588d3d9832, zonename)) {
    return "mid";
  }

  if(array_contains(level.var_fca1cceb2ea53f9e, zonename)) {
    return "low";
  }

  if(array_contains(level.var_3f257583a3d3d122, zonename)) {
    tier = getDvar(@ "hash_783c94fc1fa40619", "black");
    return tier;
  }

  return "high";
}

function function_dacf98a6e7acadeb(owner, team) {
  fortress = self;

  if(isDefined(fortress.crate)) {
    return;
  }

  if(istrue(fortress.var_67587a308d2aa143)) {
    return;
  }

  if(!isDefined(level.var_4e6c65a229188ca9)) {
    level.var_4e6c65a229188ca9 = 0;
  }

  assertex(isDefined(fortress.loadout[0]), "<dev string:xf1>" + array_find(level.var_f1073fbd45b59a06.var_df987907a483df89, fortress) + "<dev string:x103>");
  assertex(isDefined(fortress.locker[0]), "<dev string:xf1>" + array_find(level.var_f1073fbd45b59a06.var_df987907a483df89, fortress) + "<dev string:x129>");
  assertex(!isDefined(fortress.crate), "<dev string:xf1>" + array_find(level.var_f1073fbd45b59a06.var_df987907a483df89, fortress) + "<dev string:x14b>");
  kiosk = spawnscriptable("br_plunder_box_stronghold", fortress.locker[0].origin, fortress.locker[0].angles);
  kiosk.var_4261eb2ab67db6f7 = [];
  kiosk function_1e0c0f3914e139ea(0);
  kiosk.strongholdcrate = 1;
  fortress.crate = kiosk;
  kiosk.fortress = fortress;
  level.var_4e6c65a229188ca9++;
  kiosk setscriptablepartstate("br_plunder_box_stronghold", "visible_locked");
  logstring("BR STRONGHOLD " + array_find(level.var_f1073fbd45b59a06.var_df987907a483df89, fortress) + ": Initializing Fortress Kiosk for a new map total of " + level.var_4e6c65a229188ca9 + ".");
  scripts\mp\gametypes\br_analytics::function_5e512f1540e0e8a3(kiosk.origin, level.var_4e6c65a229188ca9);
}

function function_5c9be3af66670c2a() {
  level endon("game_ended");
  crate = self;

  while(!isDefined(crate) && !isDefined(crate.fortress) && !isDefined(crate.fortress.proximitytrigger)) {
    wait 0.75;
  }

  offsetorigin = crate.origin + (0, 0, 45);
  var_2e229a31b3a524cc = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  var_5ecc0917fa700c7e = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  var_beb6f3ab2870c871 = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(var_2e229a31b3a524cc != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_2e229a31b3a524cc, "current", offsetorigin, "ui_map_icon_drop_loadout_unavailable");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_2e229a31b3a524cc, 1);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_2e229a31b3a524cc);
    scripts\mp\objidpoolmanager::objective_set_play_intro(var_2e229a31b3a524cc, 1);
    scripts\mp\objidpoolmanager::function_f21e9b2e78de984b(var_2e229a31b3a524cc, level.var_9c099ce9c9abf6a6, level.var_56031a60fe206063);
  }

  if(var_5ecc0917fa700c7e != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_5ecc0917fa700c7e, "current", offsetorigin, "ui_map_icon_drop_loadout_locked");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_5ecc0917fa700c7e, 1);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_5ecc0917fa700c7e);
    scripts\mp\objidpoolmanager::objective_set_play_intro(var_5ecc0917fa700c7e, 1);
    scripts\mp\objidpoolmanager::function_f21e9b2e78de984b(var_5ecc0917fa700c7e, level.var_9c099ce9c9abf6a6, level.var_56031a60fe206063);
  }

  if(var_beb6f3ab2870c871 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_beb6f3ab2870c871, "current", offsetorigin, "ui_map_icon_drop_loadout_blue");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_beb6f3ab2870c871, 1);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_beb6f3ab2870c871);
    scripts\mp\objidpoolmanager::objective_set_play_intro(var_beb6f3ab2870c871, 1);
    scripts\mp\objidpoolmanager::function_f21e9b2e78de984b(var_beb6f3ab2870c871, level.var_9c099ce9c9abf6a6, level.var_56031a60fe206063);
    function_ebd13ec754e9f503(var_beb6f3ab2870c871, &"MP/LOADOUT");
    objective_setlabel(var_beb6f3ab2870c871, &"MP/LOADOUT");
    scripts\mp\objidpoolmanager::update_objective_setneutrallabel(var_beb6f3ab2870c871, &"MP/LOADOUT");
    scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(var_beb6f3ab2870c871, &"MP/LOADOUT");
    scripts\mp\objidpoolmanager::update_objective_setenemylabel(var_beb6f3ab2870c871, &"MP/LOADOUT");
  }

  crate.var_2e229a31b3a524cc = var_2e229a31b3a524cc;
  crate.var_5ecc0917fa700c7e = var_5ecc0917fa700c7e;
  crate.var_beb6f3ab2870c871 = var_beb6f3ab2870c871;
  crate thread function_398fdd42ae2caf98();
}

function function_398fdd42ae2caf98() {
  level endon("game_ended");
  crate = self;
  crate.var_5d4efada59c61b13 = [];

  if(!isDefined(crate)) {
    return;
  }

  var_e15b3e08dd34fa1b = [crate.var_2e229a31b3a524cc, crate.var_5ecc0917fa700c7e, crate.var_beb6f3ab2870c871];

  while(isDefined(crate)) {
    if(!isDefined(crate.fortress) && !isDefined(crate.fortress) && !isDefined(crate.fortress.proximitytrigger) && !isDefined(crate.fortress.proximitytrigger.touchents)) {
      crate function_d11f5ca845be025();
      break;
    }

    foreach(player in crate.fortress.proximitytrigger.touchents) {
      if(!isDefined(player) || !isPlayer(player)) {
        continue;
      }

      dist = distance2d(player.origin, crate.origin);

      if(!isDefined(player.var_5086072cabb9ae78)) {
        player.var_5086072cabb9ae78 = 0;
      }

      if(dist <= 7875) {
        if(!istrue(player.var_5086072cabb9ae78)) {
          if(isDefined(player.var_b357c3564f6f7be3) && player.var_b357c3564f6f7be3 == "ui_map_icon_drop_loadout_unavailable" || !isDefined(player.var_b357c3564f6f7be3)) {
            player.var_b357c3564f6f7be3 = "ui_map_icon_drop_loadout_unavailable";
            scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(crate.var_2e229a31b3a524cc, player);
            scripts\mp\objidpoolmanager::objective_playermask_hidefrom(crate.var_5ecc0917fa700c7e, player);
            scripts\mp\objidpoolmanager::objective_playermask_hidefrom(crate.var_beb6f3ab2870c871, player);
            player setclientomnvar("ui_br_stronghold_mission_loadout_crate", 2);
          } else if(player.var_b357c3564f6f7be3 == "ui_map_icon_drop_loadout_locked") {
            scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(crate.var_5ecc0917fa700c7e, player);
            scripts\mp\objidpoolmanager::objective_playermask_hidefrom(crate.var_2e229a31b3a524cc, player);
            scripts\mp\objidpoolmanager::objective_playermask_hidefrom(crate.var_beb6f3ab2870c871, player);
            player setclientomnvar("ui_br_stronghold_mission_loadout_crate", 1);
          } else if(player.var_b357c3564f6f7be3 == "ui_map_icon_drop_loadout_blue") {
            scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(crate.var_beb6f3ab2870c871, player);
            scripts\mp\objidpoolmanager::objective_playermask_hidefrom(crate.var_2e229a31b3a524cc, player);
            scripts\mp\objidpoolmanager::objective_playermask_hidefrom(crate.var_5ecc0917fa700c7e, player);
            player setclientomnvar("ui_br_stronghold_mission_loadout_crate", 3);
          }
        }

        if(!array_contains(crate.var_5d4efada59c61b13, player)) {
          crate.var_5d4efada59c61b13 = array_add(crate.var_5d4efada59c61b13, player);
        }

        player.var_5086072cabb9ae78 = 1;
      }
    }

    crate function_d11f5ca845be025();
    wait 0.75;
  }

  foreach(objid in var_e15b3e08dd34fa1b) {
    scripts\mp\objidpoolmanager::returnobjectiveid(objid);
  }
}

function function_d11f5ca845be025(player) {
  level endon("game_ended");
  crate = self;
  crate.var_5d4efada59c61b13 = array_removeundefined(crate.var_5d4efada59c61b13);
  temparr = [];
  temparr = crate.var_5d4efada59c61b13;

  foreach(player in crate.var_5d4efada59c61b13) {
    if(!isreallyalive(player) || player isplayeringulag()) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(crate.var_2e229a31b3a524cc, player);
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(crate.var_5ecc0917fa700c7e, player);
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(crate.var_beb6f3ab2870c871, player);
      player.var_5086072cabb9ae78 = 0;
      temparr = array_remove(temparr, player);
      continue;
    }

    dist = distance2d(player.origin, crate.origin);

    if(dist > 7875) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(crate.var_2e229a31b3a524cc, player);
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(crate.var_5ecc0917fa700c7e, player);
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(crate.var_beb6f3ab2870c871, player);
      player.var_5086072cabb9ae78 = 0;
    }
  }

  crate.var_5d4efada59c61b13 = temparr;
}

function function_f344712dff7facb6(player) {
  proximitytrigger = self;

  if(!isPlayer(player) && !isagent(player)) {
    return;
  }

  if(!isDefined(proximitytrigger.fortress) || !isDefined(proximitytrigger.fortress.crate) || !isDefined(player.team)) {
    return;
  }

  fortress = proximitytrigger.fortress;
  crate = fortress.crate;

  if(!istrue(crate.captured)) {
    return;
  }

  if(!isDefined(crate.trackedteams)) {
    crate.trackedteams = [];
  }

  foreach(teamdata in crate.trackedteams) {
    if(teamdata.teamname == player.team) {
      if(isPlayer(player) && !istrue(teamdata.captured) && !function_58931f9d0a83f414(player, crate) && !istrue(level.var_25e8b4afe5e06169)) {
        player.var_b357c3564f6f7be3 = "ui_map_icon_drop_loadout_locked";
        player.var_5086072cabb9ae78 = 0;
        player function_94a7b2d653c87e13("ui_br_stronghold_mission_progress", teamdata.var_bc0c909d40ee5b6f, 0, 4, 0);
        player function_94a7b2d653c87e13("ui_br_stronghold_mission_progress", teamdata.snapshotentcount, 4, 4, 0);
      }

      return;
    }
  }

  entcount = 0;

  if(isDefined(proximitytrigger.touchents)) {
    var_56e0a69db9b32032 = array_remove(proximitytrigger.touchents, player);
    entcount = var_56e0a69db9b32032.size;

    if(entcount > level.var_abfb14890546e79b) {
      entcount = level.var_abfb14890546e79b;
    }
  }

  teamdata = spawnStruct();
  teamdata.teamname = player.team;
  teamdata.var_bc0c909d40ee5b6f = entcount;
  teamdata.snapshotentcount = 0;
  teamdata.var_5469d4c525994ba2 = undefined;
  var_16387d822c991074 = isDefined(crate.capturedteam) && isDefined(player.team) && crate.capturedteam == player.team;

  if(isPlayer(player) && !istrue(var_16387d822c991074) && !function_58931f9d0a83f414(player, crate) && !istrue(level.var_25e8b4afe5e06169)) {
    player.var_b357c3564f6f7be3 = "ui_map_icon_drop_loadout_locked";
    player.var_5086072cabb9ae78 = 0;
    player function_94a7b2d653c87e13("ui_br_stronghold_mission_progress", teamdata.var_bc0c909d40ee5b6f, 0, 4, 1);
    player function_94a7b2d653c87e13("ui_br_stronghold_mission_progress", teamdata.snapshotentcount, 4, 4, 0);
  }

  if(istrue(var_16387d822c991074)) {
    teamdata.captured = 1;
  } else {
    teamdata.captured = 0;
  }

  if((!isDefined(teamdata.var_5469d4c525994ba2) || !istrue(teamdata.var_5469d4c525994ba2)) && !istrue(level.var_25e8b4afe5e06169)) {
    cratecaptured = isDefined(crate.capturedteam) && isDefined(player.team) && crate.capturedteam == player.team;

    if(!istrue(cratecaptured)) {
      teamplayers = getteamarray(player.team, 0);

      foreach(teammember in teamplayers) {
        entnum = teammember getentitynumber();
        var_efd412d96a7c016f = isDefined(proximitytrigger.touchents[entnum]);

        if(!function_58931f9d0a83f414(teammember, crate) && istrue(var_efd412d96a7c016f)) {
          teammember thread function_6ca398c1be38d376();
        }
      }

      teamdata.var_5469d4c525994ba2 = 1;
    }
  }

  crate.trackedteams = array_add(crate.trackedteams, teamdata);
}

function function_e9183e4cbb12da33(player) {
  proximitytrigger = self;

  if(!isPlayer(player) && !isagent(player)) {
    return;
  }

  teamname = undefined;

  if(isDefined(player.team)) {
    teamname = player.team;
  } else if(isDefined(player.agentteam)) {
    teamname = player.agentteam;
  } else {
    return;
  }

  if(!isDefined(proximitytrigger.fortress) || !isDefined(proximitytrigger.fortress.crate)) {
    return;
  }

  fortress = proximitytrigger.fortress;
  crate = fortress.crate;

  if(!istrue(crate.captured) || !isDefined(crate.trackedteams)) {
    return;
  }

  foreach(teamdata in crate.trackedteams) {
    if(istrue(teamdata.captured)) {
      continue;
    }

    validsnapshot = isDefined(teamdata.snapshotentcount) && isDefined(teamdata.var_bc0c909d40ee5b6f);
    teammembers = getteamarray(teamdata.teamname);

    if(!istrue(validsnapshot)) {
      if(isDefined(teammembers)) {
        foreach(teammember in teammembers) {
          if(isDefined(teammember.team)) {
            teammember function_f344712dff7facb6(player);
          }
        }
      }

      continue;
    }

    if(isDefined(teamname) && teamdata.teamname != teamname && !istrue(level.var_25e8b4afe5e06169)) {
      if(istrue(validsnapshot) && teamdata.snapshotentcount != teamdata.var_bc0c909d40ee5b6f) {
        teamdata.snapshotentcount += 1;

        foreach(teammember in teammembers) {
          teammember.var_b357c3564f6f7be3 = "ui_map_icon_drop_loadout_locked";
          teammember.var_5086072cabb9ae78 = 0;

          if(isPlayer(teammember) && !function_58931f9d0a83f414(teammember, crate)) {
            teammember function_94a7b2d653c87e13("ui_br_stronghold_mission_progress", teamdata.snapshotentcount, 4, 4, 0);
          }
        }
      }
    }

    if(istrue(validsnapshot) && teamdata.snapshotentcount == teamdata.var_bc0c909d40ee5b6f) {
      if(!istrue(teamdata.var_38030cb5e847ffa3)) {
        if(isDefined(level.var_e17717792ade97b2)) {
          fortress[[level.var_e17717792ade97b2]](teamdata.teamname, 1);
        }

        foreach(teammember in teammembers) {
          entnum = teammember getentitynumber();
          var_efd412d96a7c016f = isDefined(proximitytrigger.touchents[entnum]);

          if(isPlayer(teammember) && isreallyalive(teammember) && !function_58931f9d0a83f414(teammember, crate) && istrue(var_efd412d96a7c016f)) {
            teammember thread scripts\mp\hud_message::showsplash("stronghold_complete");
          }
        }

        teamdata.var_38030cb5e847ffa3 = 1;
      }

      foreach(teammember in teammembers) {
        if(isPlayer(teammember) && isreallyalive(teammember) && !function_58931f9d0a83f414(teammember, crate) && !istrue(level.var_25e8b4afe5e06169)) {
          crate function_faa1ecbc7f0bed85(teammember);
          teamdata.captured = 1;
          break;
        }
      }

      if(istrue(level.var_7b9b32e96c4127e2)) {
        thread function_182cb0e167ad745a(fortress, "high", level.var_d449a1c1585aa2eb, 0, 1);
      }
    }
  }
}

function function_6ca398c1be38d376() {
  player = self;
  wait 3;
  player thread scripts\mp\hud_message::showsplash("stronghold_reinforcement");
}

function function_ec5e700fa41093a4(fortress, lootcache) {
  if(!isDefined(fortress)) {
    return;
  }

  if(fortress function_225c272a97fcdd14()) {
    function_4b46f435c6058ed3(fortress, lootcache);
    return;
  }

  function_61f63df08a4cb570(fortress, lootcache);
}

function function_df20d77fc7d6103c(fortress, lootcache) {
  if(!isDefined(fortress)) {
    return;
  }

  if(fortress function_225c272a97fcdd14()) {}

  function_66ae1afd7157a8e9(fortress, 1);
}

function function_faa1ecbc7f0bed85(player, missionreward, missionfail, bdelay, var_3f45228e0b9cd155) {
  kiosk = self;

  if(!isDefined(kiosk.players)) {
    kiosk.players = [];
  }

  if(!istrue(kiosk.visible)) {
    if(istrue(missionreward)) {
      if(istrue(var_3f45228e0b9cd155) && getdvarint(@ "hash_13c3754911cca521", 1)) {
        kiosk setscriptablepartstate("br_plunder_box_stronghold", "opening");
      } else {
        kiosk setscriptablepartstate("br_plunder_box_stronghold", "visible_disarmed");
      }
    } else {
      kiosk setscriptablepartstate("br_plunder_box_stronghold", "visible_blank");
    }

    kiosk.visible = 1;
    kiosk.var_a84a6acb3c2edcae = 1;

    if(isDefined(player) && isDefined(player.team)) {
      logstring("BR STRONGHOLD " + array_find(level.var_f1073fbd45b59a06.var_df987907a483df89, kiosk.fortress) + ": Fortress Kiosk made usable for team for " + player.team + ".");
    }
  }

  if(!istrue(missionfail) && isDefined(player) && isDefined(player.team)) {
    teamplayers = getteamarray(player.team, 0);

    if(isDefined(teamplayers)) {
      if(istrue(level.var_25e8b4afe5e06169)) {
        kiosk.players = [];

        foreach(matchplayer in level.players) {
          kiosk namespace_bd614c3c2275579a::function_648d8f21bd9dc5c4(matchplayer);
        }
      }

      foreach(player in teamplayers) {
        if(!function_58931f9d0a83f414(player, kiosk)) {
          if(istrue(level.var_25e8b4afe5e06169)) {
            kiosk enablescriptablepartplayeruse("br_plunder_box_stronghold", player);
          }

          kiosk.players = array_add(kiosk.players, player);
          player setclientomnvar("ui_br_stronghold_mission_progress", 0);
          player.var_b357c3564f6f7be3 = "ui_map_icon_drop_loadout_blue";
          player.var_5086072cabb9ae78 = 0;
        }
      }
    }
  }

  if(istrue(missionreward) || istrue(missionfail)) {
    if(istrue(missionfail) && istrue(bdelay)) {
      wait 0.5 * 1.5;
    }

    if(!isDefined(kiosk)) {
      return;
    }

    if(!istrue(level.var_25e8b4afe5e06169) || !istrue(kiosk.captured)) {
      kiosk thread function_5c9be3af66670c2a();
    }

    kiosk.captured = 1;
    kiosk.trackedteams = [];
  }

  if(istrue(missionreward)) {
    kiosk.capturedteam = player.team;
  }
}

function function_648d8f21bd9dc5c4(player) {
  kiosk = self;

  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }

  player.var_b357c3564f6f7be3 = "ui_map_icon_drop_loadout_unavailable";
  player.var_5086072cabb9ae78 = 0;
  kiosk disablescriptablepartplayeruse("br_plunder_box_stronghold", player);

  if(!istrue(level.var_25e8b4afe5e06169)) {
    kiosk setscriptablepartstate("br_plunder_box_stronghold", "visible_blank");
  }

  scripts\mp\gametypes\br_analytics::function_a82f819fddc8e099(kiosk.origin, player.team, player);
}

function function_1e0c0f3914e139ea(cleanup) {
  kiosk = self;
  kiosk.players = [];
  kiosk.var_4261eb2ab67db6f7 = [];
  kiosk.visible = 0;
  kiosk.trackedteams = [];

  if(istrue(cleanup)) {
    level.var_4e6c65a229188ca9--;
    logstring("BR STRONGHOLD " + array_find(level.var_f1073fbd45b59a06.var_df987907a483df89, kiosk.fortress) + ": Removing Fortress Kiosk for a new map total of " + level.var_4e6c65a229188ca9 + ".");
    scripts\mp\gametypes\br_analytics::function_1fe361a65f4321b1(kiosk.fortress.origin, level.var_4e6c65a229188ca9);
    kiosk.fortress.crate = undefined;
    kiosk freescriptable();
  }
}

function function_94a7b2d653c87e13(omnvarref, value, bitoffset, bitwidth, breset) {
  player = self;
  mask = int(pow(2, bitwidth)) - 1;
  var_a463992091f1d483 = (value &mask) << bitoffset;
  invertedmask = ~(mask << bitoffset);
  prevvalue = self getclientomnvar(omnvarref);

  if(istrue(breset)) {
    self setclientomnvar(omnvarref, var_a463992091f1d483);
    return;
  } else if(!isDefined(prevvalue)) {
    prevvalue = invertedmask;
  }

  cleanedbase = prevvalue &invertedmask;

  if(!isDefined(var_a463992091f1d483)) {
    return;
  }

  repackedvalue = cleanedbase + var_a463992091f1d483;

  if(repackedvalue != prevvalue) {
    self setclientomnvar(omnvarref, repackedvalue);
  }
}

function function_d752e208b56fa7e(fortress) {
  if(!isDefined(fortress.crate)) {
    return;
  }

  fortress.crate scripts\cp_mp\killstreaks\airdrop::overridecapturestring(&"MP_BR_INGAME/STRONGHOLD_AI_COUNT");
  triggerobject = fortress.crate scripts\cp_mp\killstreaks\airdrop::gettriggerobject(fortress.crate.useobject);
  triggerobject makeusable();
  triggerobject sethintstringparams(fortress.var_fa8d978e0f21c38a, fortress.elites.size);
  triggerobject sethintrequiresholding(1);
  triggerobject sethintinoperable(1);
  fortress.crate.triggerobject = triggerobject;
  thread function_b9a38b13c9566550(fortress);
}

function function_b9a38b13c9566550(fortress) {
  if(!isDefined(fortress.crate)) {
    return;
  }

  cratetriggerobject = fortress.crate.triggerobject;

  while(!istrue(fortress.cleared)) {
    if(isDefined(cratetriggerobject) && cratetriggerobject isusable()) {
      cratetriggerobject sethintstringparams(fortress.elites.size - fortress.var_fa8d978e0f21c38a, fortress.elites.size);
      cratetriggerobject sethintinoperable(1);
    }

    wait 0.5;
  }

  fortress.crate thread function_78ca6709ee2d6dd3();
  cratetriggerobject sethintinoperable(0);
  cratetriggerobject makeusable();
  leveldata = scripts\cp_mp\killstreaks\airdrop::getleveldata(fortress.crate.cratetype);
  fortress.crate scripts\cp_mp\killstreaks\airdrop::overridecapturestring(leveldata.capturestring);
}

function function_78ca6709ee2d6dd3() {
  level endon("game_ended");
  crate = self;
  crate.var_5d4efada59c61b13 = [];

  while(isDefined(crate)) {
    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      if(!isreallyalive(player) || player isplayeringulag()) {
        if(array_contains(crate.var_5d4efada59c61b13, player)) {
          crate.var_5d4efada59c61b13 = array_remove(crate.var_5d4efada59c61b13, player);
        }

        continue;
      }

      dist = distance2d(player.origin, crate.origin);

      if(dist <= level.var_86fcb3b210c000b6 && !array_contains(crate.var_5d4efada59c61b13, player)) {
        crate hudoutlineenableforclient(player, "outlinefill_nodepth_cyan");
        crate.var_5d4efada59c61b13 = array_add(crate.var_5d4efada59c61b13, player);
        continue;
      }

      if(dist > level.var_86fcb3b210c000b6 && array_contains(crate.var_5d4efada59c61b13, player)) {
        crate hudoutlinedisableforclient(player);
        crate.var_5d4efada59c61b13 = array_remove(crate.var_5d4efada59c61b13, player);
      }
    }

    wait 0.5;
  }
}

function function_e2488f451ea1f1e7() {
  level endon("game_ended");

  if(!isDefined(level.var_f1073fbd45b59a06)) {
    return;
  }

  if(istrue(getdvarint(@ "hash_72ae262a8559256", 0))) {
    thread namespace_2ffd685c7e2d86a3::function_a9eaf2243763094d();
  } else {
    logstring("Active Warzone Disabled - Not Spawning");
  }

  if(function_a9b26d3ed078e149()) {
    thread function_8e3d435b914013f9();
  }

  logstring("BR STRONGHOLD: " + level.var_f1073fbd45b59a06.var_df987907a483df89.size + " total chosen fortresses.");
  level.var_48b78732538d26e7 = [];
  level.var_f1073fbd45b59a06.var_f1ab12c7e26976db = [];

  foreach(fortress in level.var_f1073fbd45b59a06.var_df987907a483df89) {
    fortress.poi = scripts\mp\poi::poi_findpoioriginisin(fortress.origin);
    fortress function_485340cc9569a658();
    fortress thread function_dca4a820d6cf615b(1);
    waitframe();
  }

  timestart = gettime();

  while(isDefined(level.var_48b78732538d26e7) && isDefined(level.var_48b78732538d26e7.size) && level.var_48b78732538d26e7.size > 0) {
    wait 0.1;
    currenttime = gettime();
    timewaiting = currenttime - timestart;

    if(timewaiting >= 10000) {
      logstring("BR STRONGHOLD: " + level.var_f1073fbd45b59a06.var_df987907a483df89.size + " lockdown timeout as single fortress or bad arr procs blocked beyond maxtime: " + 10000 + "(ms).");
      break;
    }
  }

  foreach(var_bd0667e2d3d7766b in level.var_f1073fbd45b59a06.var_f1ab12c7e26976db) {
    level.var_f1073fbd45b59a06.var_df987907a483df89 = array_remove(level.var_f1073fbd45b59a06.var_df987907a483df89, var_bd0667e2d3d7766b);
  }

  thread namespace_1eb3c4e0e28fac71::function_1c1f9f1aa4944459();

  if(level.var_1e0470dbb6cf1859) {
    level scripts\mp\gametypes\activity_manager::function_df15f72187363229();
  }

  spawnarray = level.var_f1073fbd45b59a06.var_df987907a483df89;
  var_d5219a4431706c04 = isDefined(level.var_b098cf330b024cb9) || isDefined(level.var_153bec2ca80c491a);

  if(var_d5219a4431706c04) {
    spawnarray = array_randomize(spawnarray);
  }

  foreach(fortress in spawnarray) {
    if(!function_a9b26d3ed078e149()) {
      fortress thread function_405d3047ee9c2b3f();
    }

    if(function_a9b26d3ed078e149()) {
      thread function_f1c512308725b212(fortress);
      continue;
    }

    thread function_19d154af48491507(fortress);
  }

  thread function_d22331ad0e8789ea();

  if(!function_a9b26d3ed078e149()) {
    if(istrue(level.var_533a7509e21859e7 >= 30) || istrue(level.var_ae1d349936f03e25 == 1)) {
      scripts\mp\gametypes\br_publicevents::showsplashtoall("stronghold_active_normal");
    }
  }

  thread function_b5625038519fb301();
  scripts\mp\gametypes\br::function_84e10866b5154784();
}

function function_a9b26d3ed078e149() {
  if(istrue(level.var_b9acfc4a678e5661)) {
    return 1;
  }

  var_afbdb5b031e355f9 = istrue(level.var_ae1d349936f03e25) && isDefined(level.var_533a7509e21859e7);
  circledelay = istrue(level.var_869fc47ee0767fb6);
  alivecountdelay = istrue(level.var_9b17b74fa23ad4e7) && scripts\mp\gametypes\br::getalivecount(1) > level.var_3a56dc9f81b0ccf3;
  shoulddelay = var_afbdb5b031e355f9 || circledelay || alivecountdelay;
  return shoulddelay;
}

function function_397209b257df87a() {
  return !function_a9b26d3ed078e149() || istrue(level.var_b318a940ef47517e);
}

function function_c08d24aae85741a4(usesplash) {
  if(!isDefined(usesplash)) {
    usesplash = 1;
  }

  level.var_b318a940ef47517e = 1;
  level notify("spawn_brStrongholdSpawn");

  if(istrue(level.var_533a7509e21859e7 >= 30) || istrue(level.var_ae1d349936f03e25 == 1)) {
    if(!istrue(level.var_88dbaed1222dcd10) && istrue(usesplash)) {
      scripts\mp\gametypes\br_publicevents::showsplashtoall("stronghold_active_normal");
      scripts\mp\gametypes\br_public::brleaderdialog("strongholds_active", undefined, undefined, undefined, 1);
    }
  }
}

function function_8e3d435b914013f9() {
  level endon("brStrongholdEarlySpawn");

  if(isDefined(level.br_pe_data) && isDefined(level.br_pe_data[%"stronghold"]) && level.br_pe_data[%"stronghold"].weight > 0) {
    level waittill("br_stronghold_pe_start");

    if(isDefined(level.var_a926065139739a2d[%"stronghold"]) && level.var_a926065139739a2d[%"stronghold"] > 0) {
      function_c08d24aae85741a4();
      return;
    }

    function_c08d24aae85741a4(0);
    return;
  }

  if(istrue(level.var_b9acfc4a678e5661)) {
    wait 8;
    waitframe();
    function_c08d24aae85741a4();
    return;
  }

  if(level.var_869fc47ee0767fb6 && !level.br_circle_disabled) {
    level waittill("br_circle_set");

    while(level.br_circle.circleindex < level.var_b8cb2593401fd2a) {
      level waittill("br_circle_set");
    }
  } else {
    var_afbdb5b031e355f9 = istrue(level.var_ae1d349936f03e25) && isDefined(level.var_533a7509e21859e7);

    if(var_afbdb5b031e355f9) {
      level waittill("br_c130_in_bounds");
      wait level.var_533a7509e21859e7;
    }
  }

  if(level.var_9b17b74fa23ad4e7) {
    while(scripts\mp\gametypes\br::getalivecount(1) > level.var_3a56dc9f81b0ccf3) {
      wait 3;
    }
  }

  waitframe();
  usesplash = level.var_b098cf330b024cb9 > 0;
  function_c08d24aae85741a4(usesplash);
}

function function_b5625038519fb301() {
  if(function_a9b26d3ed078e149()) {
    level waittill("spawn_brStrongholdSpawn");
  }

  tabletsshown = 0;

  foreach(tablet in level.contractmanager.hiddentablets) {
    if(istrue(tablet.strongholdcontract)) {
      tablet namespace_1eb3c4e0e28fac71::tabletshow();
      tabletsshown++;

      if(tabletsshown >= 40) {
        return;
      }
    }
  }
}

function function_f1c512308725b212(fortress) {
  fortress.unspawned = 1;
  level waittill("spawn_brStrongholdSpawn");
  wait 0.3;
  function_19d154af48491507(fortress);
  waitframe();
  level notify("spawn_brStrongholdDelayedSpawn");
}

function function_19d154af48491507(fortress, blacksitespawn, teamplayers) {
  fortress.unspawned = 1;
  var_283ea286b3ac3158 = !istrue(level.br_circle_disabled) && istrue(level.var_f45f69ff57434c35) && !ispointindangercircle(fortress.origin);
  var_d4c69cee7eea9bd8 = istrue(level.var_b2a3e71c256922ac) && istrue(blacksitespawn);
  invalidspawn = !fortress function_f1c08b6e7a66d560();
  dangerspawn = !var_d4c69cee7eea9bd8 && !istrue(level.var_b25f34fe30b345d6) && !ispointindangercircle(fortress.origin) || var_283ea286b3ac3158;

  if(invalidspawn || dangerspawn) {
    if(!isDefined(level.var_f1073fbd45b59a06.var_83e48c8a03aed37d)) {
      level.var_f1073fbd45b59a06.var_83e48c8a03aed37d = 1;
    } else {
      level.var_f1073fbd45b59a06.var_83e48c8a03aed37d++;
    }

    if(!istrue(fortress.var_826fd6df38b2a6ad)) {
      rejectedfortress = array_find(level.var_f1073fbd45b59a06.var_df987907a483df89, fortress);

      if(isDefined(rejectedfortress)) {
        logstring("BR STRONGHOLD " + rejectedfortress + ": Fortress rejected for a total of " + level.var_f1073fbd45b59a06.var_83e48c8a03aed37d + ".");
      } else {
        logstring("BR STRONGHOLD Unknown(Not found in chosen list)" + ": Fortress rejected for a total of " + level.var_f1073fbd45b59a06.var_83e48c8a03aed37d + ".");
      }
    }

    scripts\mp\gametypes\br_analytics::function_d647f8b91ee72e68(fortress.origin, level.var_f1073fbd45b59a06.var_83e48c8a03aed37d);
    fortress function_cfed3680a85e161d(blacksitespawn);
    return 0;
  }

  if(istrue(fortress.isblacksite) && !istrue(blacksitespawn)) {
    if(!isDefined(level.var_f1073fbd45b59a06.blacksites)) {
      level.var_f1073fbd45b59a06.blacksites = [];
    }

    if(!array_contains(level.var_f1073fbd45b59a06.blacksites, fortress)) {
      level.var_f1073fbd45b59a06.blacksites[level.var_f1073fbd45b59a06.blacksites.size] = fortress;
      return;
    } else {
      return;
    }
  }

  if(istrue(fortress.isblacksite) && istrue(blacksitespawn)) {
    if(!isDefined(level.var_f1073fbd45b59a06.var_ebfd05cb5f552e56)) {
      level.var_f1073fbd45b59a06.var_ebfd05cb5f552e56 = 1;
    } else {
      level.var_f1073fbd45b59a06.var_ebfd05cb5f552e56++;
    }

    logstring("BR STRONGHOLD " + array_find(level.var_f1073fbd45b59a06.var_df987907a483df89, fortress) + ": Spawning Blacksite Fortress for a total of " + level.var_f1073fbd45b59a06.var_ebfd05cb5f552e56 + ".");
    scripts\mp\gametypes\br_analytics::function_cdf333517613e68d(fortress.origin, level.var_f1073fbd45b59a06.var_ebfd05cb5f552e56);
  } else {
    if(!isDefined(level.var_f1073fbd45b59a06.var_568d1aedd5bc31ca)) {
      level.var_f1073fbd45b59a06.var_568d1aedd5bc31ca = 0;
    }

    if(level.var_f1073fbd45b59a06.var_568d1aedd5bc31ca < level.var_b098cf330b024cb9 && !level.var_88dbaed1222dcd10) {
      level.var_f1073fbd45b59a06.var_568d1aedd5bc31ca++;
      fortress.infiltrated = 1;
      logstring("BR STRONGHOLD " + array_find(level.var_f1073fbd45b59a06.var_df987907a483df89, fortress) + ": Spawning Normal Fortress for a total of " + level.var_f1073fbd45b59a06.var_568d1aedd5bc31ca + ".");
      scripts\mp\gametypes\br_analytics::function_a9fe2bed8ed8b965(fortress.origin, level.var_f1073fbd45b59a06.var_568d1aedd5bc31ca);
    } else {
      if(!isDefined(level.var_f1073fbd45b59a06.var_83e48c8a03aed37d)) {
        level.var_f1073fbd45b59a06.var_83e48c8a03aed37d = 1;
      } else {
        level.var_f1073fbd45b59a06.var_83e48c8a03aed37d++;
      }

      var_dfeaae7539235b0d = array_find(level.var_f1073fbd45b59a06.var_df987907a483df89, fortress);
      fortress function_cfed3680a85e161d(blacksitespawn);
      logstring("BR STRONGHOLD " + var_dfeaae7539235b0d + ": Max spawend - Fortress rejected for a total of " + level.var_f1073fbd45b59a06.var_83e48c8a03aed37d + ".");
      return 0;
    }
  }

  fortress function_e395843d541e402b(teamplayers);
  return 1;
}

function function_e395843d541e402b(teamplayers) {
  fortress = self;
  fortress.unspawned = undefined;
  function_fb256f37d5e18aeb(fortress, teamplayers);
  function_d95dbf57b47734d9(fortress, 0);
  function_ee79d34ce223abaf(fortress);
  function_d67f15dc6097606d(fortress);
  function_2e6a3f3e4d2731ea(0, fortress);

  if(istrue(level.var_d9cb3757eeb88258)) {
    if(istrue(level.var_53e7795f958213)) {
      thread function_33cab8a7ca7c51c0(fortress, "high");
    } else {
      thread function_6162d039fd0cdbd4(fortress, "high");
    }
  }

  if(level.var_8484c417e9016033) {
    fortress thread function_7f70094a3538a5fc();
  }

  if(level.var_f20f4dd3b7825826) {
    fortress thread function_2cac20d9f1d15e9f();
  }

  if(!istrue(level.br_circle_disabled)) {
    fortress thread function_975b0130f3e125e6();
    fortress thread function_a35b99e2b0e4b68c();
  }
}

function function_d65373448bf46a1b(fortress, origin, angles) {
  if(!isDefined(origin)) {
    origin = (0, 0, 0);
  }

  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  var_cb2499e4e9d175a2 = "br_loot_cache_stronghold";

  if(istrue(fortress.isblacksite)) {
    var_cb2499e4e9d175a2 = "br_loot_cache_blacksite";
  }

  cache = spawnscriptable(var_cb2499e4e9d175a2, origin, angles);
  cache.fortress = fortress;

  if(cache getscriptableparthasstate("body", "closed_usable")) {
    cache setscriptablepartstate("body", "closed_usable");
  }

  return cache;
}

function function_2838d9d823bc09f(fortress) {
  cachepoints = getunusedlootcachepoints(fortress.origin, 7000, 0, 1);

  if(cachepoints.size == 0) {
    return;
  }

  cachepoint = undefined;

  while(cachepoints.size > 0) {
    cachepoint = random(cachepoints);
    array_remove(cachepoints, cachepoint);

    if(namespace_9823ee6035594d67::function_20f6e9317b1baf3d(cachepoint.origin, fortress)) {
      break;
    }
  }

  if(!isDefined(cachepoint)) {
    return;
  }

  disablelootspawnpoint(cachepoint.index);
  return function_d65373448bf46a1b(fortress, cachepoint.origin, cachepoint.angles);
}

function function_61f63df08a4cb570(fortress, lootcache) {
  if(isDefined(lootcache)) {
    fortress.var_6ba14538e6db83c6 = array_remove(fortress.var_6ba14538e6db83c6, lootcache);
  }

  if(scripts\mp\utility\game::getsubgametype() != "plunder") {
    return;
  }

  if(fortress.var_6ba14538e6db83c6.size <= 0) {
    fortress function_50aa951ab3c71fa4();
    fortress.objectiveiconid = undefined;
  }
}

function function_d22331ad0e8789ea(var_16ebcc11d83b81e) {
  level endon("game_ended");

  while(true) {
    checktime = undefined;

    foreach(fortress in level.var_f1073fbd45b59a06.var_df987907a483df89) {
      tier = fortress function_b7a9796c95aa8e8d();

      if(istrue(fortress.unspawned) && tier != "black") {
        checktime = 1;
        break;
      }
    }

    if(isDefined(checktime)) {
      wait checktime;
      continue;
    }

    break;
  }

  function_9a8bd260dcce74be();
}

function function_9a8bd260dcce74be() {
  var_c691fefd64ac826 = getlootscriptablearray("br_loot_cache_stronghold");
  var_465076fa32fe932 = getlootscriptablearray("br_loot_cache_blacksite");
  var_b098d8a727cf5053 = array_combine(var_c691fefd64ac826, var_465076fa32fe932);

  foreach(cache in var_b098d8a727cf5053) {
    var_5db3250d89b1056f = undefined;

    if(level.var_7e293d1e9b987629 > 0) {
      fortressessorted = function_22e481ecb8fc7bf1(cache.origin);
      maxchecks = int(min(level.var_7e293d1e9b987629, fortressessorted.size));
      var_dfeaae7539235b0d = 0;

      while(var_dfeaae7539235b0d < maxchecks) {
        fortress = fortressessorted[var_dfeaae7539235b0d];

        if(isDefined(fortress) && namespace_6c6c9cbca3ea8e6e::function_20f6e9317b1baf3d(cache.origin, fortress)) {
          var_5db3250d89b1056f = fortress;
          break;
        }

        var_dfeaae7539235b0d += 1;
      }
    }

    if(!isDefined(var_5db3250d89b1056f)) {
      var_5db3250d89b1056f = function_baef4910acea00f0(cache.origin);
    }

    cache.fortress = var_5db3250d89b1056f;

    if(var_5db3250d89b1056f function_225c272a97fcdd14()) {
      if(!isDefined(var_5db3250d89b1056f.var_d5f2ca0ab65d0652)) {
        var_5db3250d89b1056f.var_d5f2ca0ab65d0652 = [];
      }

      var_5db3250d89b1056f.var_d5f2ca0ab65d0652[var_5db3250d89b1056f.var_d5f2ca0ab65d0652.size] = cache;
      continue;
    }

    if(!istrue(var_5db3250d89b1056f.isblacksite) && !istrue(level.var_7c75865525573b26)) {
      cache setscriptablepartstate("body", "hidden");
      continue;
    }

    if(!isDefined(var_5db3250d89b1056f.var_6ba14538e6db83c6)) {
      var_5db3250d89b1056f.var_6ba14538e6db83c6 = [];
    }

    var_5db3250d89b1056f.var_6ba14538e6db83c6[var_5db3250d89b1056f.var_6ba14538e6db83c6.size] = cache;
  }
}

function function_cfed3680a85e161d(blacksitespawn) {
  fortress = self;

  if(!istrue(level.var_8ab39bbb40bf6536) || !isDefined(fortress)) {
    return;
  }

  if(istrue(blacksitespawn)) {
    return;
  }

  level.var_f1073fbd45b59a06.var_df987907a483df89 = array_remove(level.var_f1073fbd45b59a06.var_df987907a483df89, fortress);
  level.var_f1073fbd45b59a06.var_f1ab12c7e26976db = function_6d6af8144a5131f1(level.var_f1073fbd45b59a06.var_f1ab12c7e26976db, fortress);
  function_ee79d34ce223abaf(fortress, &function_61c532e87e5f8c48, 0, 1);

  if(istrue(level.var_3f29c197a71f3be9)) {
    if(!isDefined(level.var_f1073fbd45b59a06.var_c5f13f0671bbb2b9)) {
      level.var_f1073fbd45b59a06.var_c5f13f0671bbb2b9 = 0;
    }

    if(level.var_f1073fbd45b59a06.var_c5f13f0671bbb2b9 < level.var_e9fc3d6a8bde490d) {
      fortress function_8ecf1e2437cb4ff5();
    }
  }
}

function function_8ecf1e2437cb4ff5() {
  fortress = self;
  fortress.abandoned = 1;
  level.var_f1073fbd45b59a06.var_c5f13f0671bbb2b9++;
  fortress.var_c4b85c30a02a19f8 = "stronghold_low";

  if(!getdvarint(@ "hash_ef50fad6149001b6", 0) && isDefined(fortress.stronghold_fx)) {
    fortress.stronghold_fx setscriptablepartstate("name_fx", fortress.var_c4b85c30a02a19f8, 0);
  }

  function_fb256f37d5e18aeb(fortress);
  function_6cddcdcac12962ff(fortress, 1);
}

function function_225c272a97fcdd14() {
  fortress = self;
  return istrue(fortress.abandoned);
}

function function_4b46f435c6058ed3(fortress, lootcache) {
  if(isDefined(lootcache)) {
    fortress.var_d5f2ca0ab65d0652 = array_remove(fortress.var_d5f2ca0ab65d0652, lootcache);
  }

  if(!level.var_7c680177b019802c) {
    return;
  }

  if(fortress.var_d5f2ca0ab65d0652.size <= 0) {
    function_6cddcdcac12962ff(fortress, 0);
  }
}

function function_6cddcdcac12962ff(fortress, active) {
  if(istrue(active)) {
    scripts\mp\objidpoolmanager::function_a28e8535e00d34f3(fortress.var_192f741c1625715e);
    return;
  }

  scripts\mp\objidpoolmanager::function_9cad42ac02eff950(fortress.var_192f741c1625715e);
}

function function_66ae1afd7157a8e9(fortress, active) {
  if(fortress function_225c272a97fcdd14()) {
    function_6cddcdcac12962ff(fortress, active);
    return;
  }

  if(!isDefined(fortress.objectiveiconid)) {
    function_fb256f37d5e18aeb(fortress);
    return;
  }

  function_d95dbf57b47734d9(fortress, active);
}

function function_9d216f4cd30f141d(dropstruct, teamplayers, originalteam, var_80e8221bfc39ac63, dropinfo) {
  player = self;

  if(!isDefined(level.var_f1073fbd45b59a06.blacksites) || isDefined(level.var_f1073fbd45b59a06.blacksites) && level.var_f1073fbd45b59a06.blacksites.size < 0) {
    return;
  }

  spawned = 0;
  blacksite = undefined;

  if(isDefined(level.var_153bec2ca80c491a) && !isDefined(level.var_f1073fbd45b59a06.var_9a3603fc71c8c69d)) {
    level.var_f1073fbd45b59a06.var_9a3603fc71c8c69d = [];
  }

  while(!istrue(spawned)) {
    if(isDefined(level.var_153bec2ca80c491a) && isDefined(level.var_f1073fbd45b59a06.var_9a3603fc71c8c69d)) {
      if(level.var_f1073fbd45b59a06.var_9a3603fc71c8c69d.size >= level.var_153bec2ca80c491a) {
        spawned = 1;
        blacksite = random(level.var_f1073fbd45b59a06.var_9a3603fc71c8c69d);
        logstring("BR STRONGHOLD " + array_find(level.var_f1073fbd45b59a06.var_df987907a483df89, blacksite) + ": Claiming Blacksite Fortress for spawn AGAIN, " + level.var_f1073fbd45b59a06.blacksites.size + " black sites remaining.");
        scripts\mp\gametypes\br_analytics::function_cdf333517613e68d(blacksite.origin, level.var_f1073fbd45b59a06.blacksites.size);
        continue;
      }
    }

    if(isDefined(level.br_circle) && istrue(level.var_b2a3e71c256922ac)) {
      bestvalue = undefined;
      currentvalue = undefined;
      finalcirclecenter = undefined;

      if(isDefined(level.br_circle.br_finalcircleoverride)) {
        finalcirclecenter = level.br_circle.br_finalcircleoverride;
      } else {
        finalcircleindex = level.br_level.br_circlecenters.size - 1;
        var_8547d5a9c92abb8d = scripts\mp\gametypes\br_circle::function_6249dca788e0dff0();

        if(isDefined(var_8547d5a9c92abb8d)) {
          finalcircleindex = var_8547d5a9c92abb8d;
        }

        finalcirclecenter = level.br_level.br_circlecenters[finalcircleindex];
      }

      foreach(site in level.var_f1073fbd45b59a06.blacksites) {
        if(level.var_e87dd990ed2a494c) {
          currentvalue = scripts\mp\gametypes\br_circle::getmintimetillpointindangercircle(site.origin);

          if(isDefined(bestvalue) && isDefined(currentvalue) && bestvalue > currentvalue) {
            continue;
          }
        } else {
          currentvalue = distance2d(finalcirclecenter, site.origin);

          if(isDefined(bestvalue) && isDefined(currentvalue) && bestvalue < currentvalue) {
            continue;
          }
        }

        bestvalue = currentvalue;
        blacksite = site;
      }
    } else {
      blacksite = random(level.var_f1073fbd45b59a06.blacksites);
    }

    if(!isDefined(blacksite)) {
      return;
    }

    level.var_f1073fbd45b59a06.blacksites = array_remove(level.var_f1073fbd45b59a06.blacksites, blacksite);
    logstring("BR STRONGHOLD " + array_find(level.var_f1073fbd45b59a06.var_df987907a483df89, blacksite) + ": Claiming Blacksite Fortress for spawn " + level.var_f1073fbd45b59a06.blacksites.size + " black sites remaining.");
    scripts\mp\gametypes\br_analytics::function_cdf333517613e68d(blacksite.origin, level.var_f1073fbd45b59a06.blacksites.size);
    spawned = function_19d154af48491507(blacksite, 1, teamplayers);
  }

  if(isDefined(blacksite)) {
    level.var_f1073fbd45b59a06.var_9a3603fc71c8c69d = array_add(level.var_f1073fbd45b59a06.var_9a3603fc71c8c69d, blacksite);
    return player namespace_bd614c3c2275579a::function_f9ff7c89b3792ccc(dropstruct, blacksite, undefined, originalteam, var_80e8221bfc39ac63, dropinfo);
  }
}

function function_7bc622d2fe4b2017(fortress, revealall, teamplayers, originalteam, currentteam) {
  if(istrue(revealall)) {
    if(isDefined(fortress.objectiveiconid)) {
      foreach(player in level.players) {
        notcurrentteam = isDefined(player.team) && isDefined(currentteam) && player.team != currentteam;

        if(isreallyalive(player) && !player isplayeringulag() && notcurrentteam) {
          player scripts\mp\hud_message::showsplash("stronghold_active_blacksite_enemy");
        }

        function_6d6af8144a5131f1(player.var_17ff8aa2629a12c1, fortress);
      }

      namespace_1eb3c4e0e28fac71::showquestobjicontoall(fortress.objectiveiconid);
    }

    return;
  }

  if(istrue(fortress.captured)) {
    return;
  }

  if(isDefined(originalteam) && isDefined(currentteam) && originalteam != currentteam) {
    originalteamplayers = getteamarray(originalteam, 0);

    foreach(teamplayer in originalteamplayers) {
      teamplayer setclientomnvar("ui_br_stronghold_mission", 35);
    }
  }

  foreach(teamplayer in teamplayers) {
    function_ed5dd045e2e3dc5b(fortress, teamplayer, 1);
    thread scripts\mp\gametypes\br_public::brleaderdialogplayer("blacksite_reveal", teamplayer, undefined, undefined, 2);
  }

  objective_showtoplayersinmask(fortress.objectiveiconid);
}

function private function_ed5dd045e2e3dc5b(fortress, player, shouldshowsplash) {
  if(isDefined(player.var_17ff8aa2629a12c1) && array_contains(player.var_17ff8aa2629a12c1, fortress)) {
    return;
  }

  if(istrue(shouldshowsplash) && isreallyalive(player) && !player isplayeringulag()) {
    var_197a2c34da548026 = "stronghold_active_blacksite";

    if(isDefined(level.var_a105981a14beacc6)) {
      var_197a2c34da548026 = level.var_a105981a14beacc6;
    }

    player scripts\mp\hud_message::showsplash(var_197a2c34da548026);
  }

  namespace_9823ee6035594d67::function_7ee5340d1a5a2ca9(fortress, player);
  player scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout(11, (0, 0, 0), fortress.objectiveiconid);
  player function_cab68f487d41de86(fortress);

  if(!isDefined(player.var_17ff8aa2629a12c1)) {
    player.var_17ff8aa2629a12c1 = [];
  }

  player.var_17ff8aa2629a12c1 = array_add(player.var_17ff8aa2629a12c1, fortress);
}

function function_cab68f487d41de86(blacksite) {
  player = self;
  omnvarstate = player getclientomnvar("ui_br_stronghold_mission");
  isonmission = isDefined(blacksite.missiontrigger) && isDefined(blacksite.missiontrigger.touchents) && array_contains(blacksite.missiontrigger.touchents, player);

  if(!isDefined(blacksite.var_e2bdca417396359)) {
    blacksite.var_e2bdca417396359 = [];
  }

  blacksite.var_e2bdca417396359 = function_6d6af8144a5131f1(blacksite.var_e2bdca417396359, player.team);

  if(isDefined(omnvarstate)) {
    isprevstate = omnvarstate == 17;
    isnextstate = omnvarstate == 20;
  } else {
    player setclientomnvar("ui_br_stronghold_mission", 19);
    return;
  }

  if(!istrue(isonmission) && isDefined(omnvarstate) && !isprevstate && !isnextstate) {
    player setclientomnvar("ui_br_stronghold_mission", 19);
  }
}

function function_33cab8a7ca7c51c0(fortress, priorityoverride) {
  level endon("game_ended");

  if(istrue(level.var_adc6d9da6cadf81d)) {
    thread function_6162d039fd0cdbd4(fortress);
  }

  while(isDefined(fortress)) {
    if(istrue(level.var_156c5b503b29e858) && istrue(fortress.infiltrated) && !istrue(fortress.var_a19b5fa72225ff10)) {
      thread function_182cb0e167ad745a(fortress, "high", level.var_bc42d1a8badab89d, 0);
      fortress.var_a19b5fa72225ff10 = 1;

      if(istrue(level.var_10378f84ce5d051)) {}
    }

    if(istrue(level.var_5c2392ebd13a33c) && istrue(fortress.captured) && !istrue(fortress.var_43be1844df7cf380)) {
      thread function_182cb0e167ad745a(fortress, "high", level.var_9315a2b45ca76f29, 0);
      fortress.var_43be1844df7cf380 = 1;

      if(istrue(level.var_10378f84ce5d051)) {}
    }

    wait level.var_bd092c2beee1c8c;
  }
}

function function_6162d039fd0cdbd4(fortress, priorityoverride, var_d7a79bc8f833cdc7, var_9bdc7bc3ebb53c19) {
  level endon("game_ended");

  if(!isDefined(fortress.missiontrigger)) {
    return;
  }

  if(!isDefined(priorityoverride)) {
    priorityoverride = "high";
  }

  numtospawn = 0;
  var_482cb8d9b47a8520 = 1;

  if(!istrue(var_9bdc7bc3ebb53c19)) {
    var_482cb8d9b47a8520 = level.var_af6b6798e49e6f50;
  }

  if(isDefined(var_d7a79bc8f833cdc7)) {
    numtospawn = fortress.tieroverride * var_d7a79bc8f833cdc7 * var_482cb8d9b47a8520;
  } else {
    numtospawn = fortress.tieroverride * level.var_9e4101a579ae1680 * var_482cb8d9b47a8520;
  }

  agents = [];
  agentpackage = scripts\mp\ai_mp_controller::function_ab14d6652e44fda0(numtospawn, level.spawnset["guard"], 2);
  agentpackage.reinforcementtype = "Helicopter";
  scripts\mp\gametypes\br_analytics::function_5bd0a2d95d2e42a5(fortress.origin, int(numtospawn));
  infildestination = fortress.missiontrigger.origin;

  if(isDefined(fortress.crate)) {
    infildestination = fortress.crate.origin;
  }

  scripts\mp\gametypes\br_analytics::function_5bd0a2d95d2e42a5(fortress.origin, int(numtospawn));
  scripts\mp\ai_mp_controller::function_77acc10c4823dd8a(numtospawn, infildestination, priorityoverride, fortress.uniquename, "fortressDoorOpened", undefined, undefined, 1, fortress.poi, undefined, fortress.missiontrigger.radius / 2, fortress.missiontrigger.radius / 4, agentpackage);
  logstring("BR STRONGHOLD " + array_find(level.var_f1073fbd45b59a06.var_df987907a483df89, fortress) + ": Spawning reinforcements.");
}

function function_182cb0e167ad745a(fortress, priorityoverride, var_d7a79bc8f833cdc7, var_6b9856eb5ad29852, var_9bdc7bc3ebb53c19) {
  level endon("game_ended");

  if(isDefined(fortress.proximitytrigger) && !istrue(fortress.proximitytrigger.reinforce)) {
    return;
  }

  skipspawn = 0;

  if(istrue(fortress.var_264ce6266987c0e6) || istrue(var_6b9856eb5ad29852)) {
    fortress.var_264ce6266987c0e6 = 0;
    fortress.var_9fc7ddc62156e49e = 0;
    skipspawn = 1;
    thread function_6162d039fd0cdbd4(fortress, priorityoverride, var_d7a79bc8f833cdc7, var_9bdc7bc3ebb53c19);
  }

  if(isDefined(fortress.var_9fc7ddc62156e49e) && fortress.var_9fc7ddc62156e49e > 0) {
    return;
  }

  if(!isDefined(fortress.var_9fc7ddc62156e49e)) {
    fortress.var_9fc7ddc62156e49e = 0;
    thread function_6162d039fd0cdbd4(fortress, priorityoverride, var_d7a79bc8f833cdc7, var_9bdc7bc3ebb53c19);
    skipspawn = 1;
  }

  while(isDefined(fortress)) {
    if(fortress.var_9fc7ddc62156e49e < level.var_d87d73c3d6ff6705) {
      fortress.var_9fc7ddc62156e49e += level.var_bd092c2beee1c8c;
      wait level.var_bd092c2beee1c8c;
      continue;
    }

    if(!skipspawn) {
      fortress.var_9fc7ddc62156e49e = 0;
      thread function_6162d039fd0cdbd4(fortress, priorityoverride, var_d7a79bc8f833cdc7, var_9bdc7bc3ebb53c19);
    } else {
      fortress.var_264ce6266987c0e6 = 1;
    }

    break;
  }
}

function function_ee79d34ce223abaf(fortress, var_14dcea3d745e5b2b, var_d4bd121a94842df3, unspawned) {
  if(!istrue(fortress.isblacksite) || istrue(fortress.isblacksite) && istrue(var_d4bd121a94842df3)) {
    if(isDefined(fortress.lockeddoors)) {
      foreach(door in fortress.lockeddoors) {
        function_68d521a180f0031c(door, var_14dcea3d745e5b2b);
      }

      if(!istrue(unspawned)) {
        logstring("BR STRONGHOLD " + array_find(level.var_f1073fbd45b59a06.var_df987907a483df89, fortress) + " :ALL " + fortress.lockeddoors.size + " lockedDoors of Blacksite Unlocked.");
        scripts\mp\gametypes\br_analytics::function_ce58220fbd0824be(fortress.origin, fortress.lockeddoors.size);
      }
    }
  }

  if(isDefined(fortress.var_511459d6509633b1)) {
    foreach(door in fortress.var_511459d6509633b1) {
      function_68d521a180f0031c(door, var_14dcea3d745e5b2b);
    }

    if(!istrue(unspawned)) {
      logstring("BR STRONGHOLD " + array_find(level.var_f1073fbd45b59a06.var_df987907a483df89, fortress) + " :ALL " + fortress.var_511459d6509633b1.size + " lockedDoors_interior of fortress Unlocked.");
      scripts\mp\gametypes\br_analytics::function_31406a57e628c3fe(fortress.origin, fortress.var_511459d6509633b1.size);
    }
  }
}

function function_68d521a180f0031c(door, var_14dcea3d745e5b2b) {
  scripts\mp\locksandkeys::function_b092780f9ec4496e(door);

  if(isDefined(door.connecteddoor)) {
    door.connecteddoor scriptabledoorfreeze(0);
  }

  if(isDefined(var_14dcea3d745e5b2b)) {
    door thread[[var_14dcea3d745e5b2b]](door, undefined);
    return;
  }

  if(isDefined(door.var_def557e8fd5c6763)) {
    door thread[[door.var_def557e8fd5c6763]](door, undefined);
  }
}

function function_dca4a820d6cf615b(var_ea7f19952edd93a6) {
  level endon("game_ended");
  fortress = self;
  fortress endon("brStronghold_circleWatch");
  fortress.var_ea7f19952edd93a6 = var_ea7f19952edd93a6 && level.var_e352d252847915ab;
  activatetraps = level.var_ac683c8b10600fbe;
  keynameoverride = undefined;

  if(istrue(fortress.isblacksite)) {
    keynameoverride = "blacksite";
  } else {
    keynameoverride = "br_fortress";
  }

  foreach(door in fortress.lockeddoors) {
    timestart = gettime();

    while(!door scriptabledoorisclosed()) {
      level.var_48b78732538d26e7 = array_add(level.var_48b78732538d26e7, fortress);
      wait 0.1;
      currenttime = gettime();
      timewaiting = currenttime - timestart;

      if(timewaiting >= 8000) {
        level.var_48b78732538d26e7 = array_remove(level.var_48b78732538d26e7, fortress);
        level.var_f1073fbd45b59a06.var_f1ab12c7e26976db = array_add(level.var_f1073fbd45b59a06.var_f1ab12c7e26976db, fortress);
        logstring("BR STRONGHOLD " + array_find(level.var_f1073fbd45b59a06.var_df987907a483df89, fortress) + ": Stronghold could not close open door in time - not activated.");
        return;
      }
    }

    if(array_contains(level.var_48b78732538d26e7, fortress)) {
      level.var_48b78732538d26e7 = array_remove(level.var_48b78732538d26e7, fortress);
    }
  }

  namespace_9823ee6035594d67::function_5d8264355db47371(fortress, fortress.var_ea7f19952edd93a6, 1, 0, 0, keynameoverride, &function_3d34980ea9dfd41, &function_d67f15dc6097606d, activatetraps, undefined, 1);

  if(fortress.var_ea7f19952edd93a6) {
    namespace_9823ee6035594d67::function_f01e587e03e81414();
    return;
  }

  fortress.unlocked = 1;
}

function function_d67f15dc6097606d(fortress) {
  if(!istrue(level.var_2c04b8bf908257a4) && !istrue(fortress.isblacksite)) {
    return;
  }

  if(istrue(fortress.isblacksite)) {
    fortress.var_20861e45b600c6da = array_combine(fortress.guardnodes, fortress.elites, fortress.boss);
  }

  var_11c25efd0614391a = level.var_521e69d9c1e570d0 && istrue(fortress.shouldspawnboss);

  if(level.var_392e6097df364a4b && var_11c25efd0614391a) {
    bosscount = 1;

    if(level.var_5e111662782c87bc) {
      bosscount = level.var_5e111662782c87bc;
    }

    for(spawned = 0; spawned < bosscount; spawned++) {
      thread function_610d7a61f61e81e5(fortress);
    }
  }

  if(fortress.elites.size > 0) {
    numtospawn = fortress.elites.size * fortress.tieroverride / 1 * level.var_af6b6798e49e6f50;

    while(fortress.elites.size > numtospawn) {
      nodetoremove = fortress.elites[randomint(fortress.elites.size)];
      fortress.elites = array_remove(fortress.elites, nodetoremove);
    }
  } else if(fortress.guardnodes.size > 0) {
    numtospawn = fortress.guardnodes.size * fortress.tieroverride / 1 * level.var_af6b6798e49e6f50;

    while(fortress.guardnodes.size > numtospawn) {
      nodetoremove = fortress.guardnodes[randomint(fortress.guardnodes.size)];
      fortress.guardnodes = array_remove(fortress.guardnodes, nodetoremove);
    }
  }

  if(isDefined(fortress.tieroverride) && (fortress.tieroverride == 1 || fortress.tieroverride == 1) && !istrue(level.var_4094a9c5b998313d)) {
    fortress.elites = scripts\engine\utility::array_combine(fortress.elites, fortress.guardnodes);
    fortress.guardnodes = [];

    if(isDefined(fortress.patrolpaths) && isarray(fortress.patrolpaths)) {
      for(i = 0; i < fortress.patrolpaths.size; i++) {
        if(isDefined(fortress.patrolpaths[i].path) && isarray(fortress.patrolpaths[i].path)) {
          fortress.patrolpaths[i].path[0].agent_type = "elite";
        }
      }
    }
  } else if(istrue(fortress.isblacksite) && istrue(level.var_4094a9c5b998313d)) {
    fortress.elites = [];
    fortress.guardnodes = scripts\engine\utility::array_combine(fortress.elites, fortress.guardnodes);

    if(isDefined(fortress.patrolpaths) && isarray(fortress.patrolpaths)) {
      for(i = 0; i < fortress.patrolpaths.size; i++) {
        if(isDefined(fortress.patrolpaths[i].path) && isarray(fortress.patrolpaths[i].path)) {
          if(mod(i, 2) == 0) {
            fortress.patrolpaths[i].path[0].agent_type = "tier1";
            continue;
          }

          fortress.patrolpaths[i].path[0].agent_type = "tier2";
        }
      }
    }
  }

  namespace_9823ee6035594d67::function_dec2a213ee64b9d(fortress, undefined);
}

function function_610d7a61f61e81e5(fortress) {
  bossnode = undefined;
  fortress waittill("brStronghold_spawnBoss");

  if(fortress.elites.size > 0) {
    bossnode = fortress.elites[randomint(fortress.elites.size)];
    fortress.elites = array_remove(fortress.elites, bossnode);
  } else if(fortress.guardnodes.size > 0) {
    bossnode = fortress.guardnodes[randomint(fortress.guardnodes.size)];
    fortress.guardnodes = array_remove(fortress.guardnodes, bossnode);
  } else if(istrue(level.var_2f77bc06c763e3f) && isDefined(fortress.var_20861e45b600c6da) && fortress.var_20861e45b600c6da.size > 0) {
    bossnode = fortress.var_20861e45b600c6da[randomint(fortress.var_20861e45b600c6da.size)];
  }

  if(isDefined(bossnode)) {
    bossname = function_2c2eddf9f503acd1();

    if(isDefined(bossname)) {
      bossnode.var_19d2f5d851348e8e = fortress;
      boss = scripts\mp\gametypes\br_bosses::spawnboss(bossname, bossnode);

      if(isDefined(boss)) {
        scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata(boss, "dropWeapon", istrue(level.var_1f6bf7cc2543812));
        logstring("BR STRONGHOLD " + array_find(level.var_f1073fbd45b59a06.var_df987907a483df89, fortress) + " :Boss " + bossname + " spawned.");
        scripts\mp\gametypes\br_analytics::function_aaf1156bacf6654e(fortress.origin, bossname);
        boss.var_2d670e4d288c86fb = 1;
        boss.var_7d606bec79308eb5 = 350;
        boss.pursuestopdistance = 150;
        boss.goalheight = 80;
        boss.allowlongdeath = 1;
        boss.maxhealth = int(level.var_e34d534debb61eda * level.var_63d0544474ed373);
        boss.health = int(level.var_e34d534debb61eda * level.var_63d0544474ed373);
        boss.maxarmorhealth = int(level.var_2e0a0145252b7f6a * level.var_48d50c4fdd3feb83);
        boss.armorhealth = int(level.var_2e0a0145252b7f6a * level.var_48d50c4fdd3feb83);
        boss.var_cfc69e5588a5bed6 = int(level.var_134d393a2d69b578 * level.var_8a45fbdabac853fd);
        boss.helmethealth = int(level.var_134d393a2d69b578 * level.var_8a45fbdabac853fd);

        if(!isDefined(fortress.var_837c4b569aa8a376)) {
          fortress.var_837c4b569aa8a376 = [];
        }

        fortress.var_837c4b569aa8a376[fortress.var_837c4b569aa8a376.size] = boss;
        boss.fortress = fortress;

        if(bossname == "pyro") {
          boss.maxarmorhealth = 3000 * level.var_c8890f4cd4fcb1c0;
          boss.var_8c5c47f81a1869e5 = &namespace_daa149ca485fd50a::function_7d0d24665d72f13c;
        }
      }
    }
  }

  if(level.var_1be05623f95c1ecb) {
    level thread scripts\mp\gametypes\br_bosses::function_41684af1362b3f50(boss);
  }

  fortress.spawnedboss = 1;
  fortress notify("brStronghold_spawnedBoss");
}

function function_2c2eddf9f503acd1() {
  if(getdvarint(@ "hash_c3ad6b4640ed1b6c", 0)) {
    return "zombie_santa";
  }

  if(randomfloat(1) <= level.var_af0f258868936569) {
    return "pyro";
  }

  return "mi8jugg";
}

function function_3d34980ea9dfd41(door, player) {
  if(isDefined(door.fortress) && !istrue(door.fortress.unlocked) && !istrue(door.fortress.unspawned)) {
    door.fortress.unlocked = 1;

    if(istrue(door.fortress.isblacksite)) {
      if(!istrue(door.fortress.infiltrated)) {
        door.fortress.infiltrated = 1;
        function_ee79d34ce223abaf(door.fortress, undefined, 1);
        function_7bc622d2fe4b2017(door.fortress, 1, undefined, undefined, player.team);
        lootid = scripts\cp_mp\utility\loot::getlootidfromref("loot_multi_key_fortress");

        foreach(player in level.players) {
          while(player namespace_aead94004cf4c147::function_d63a7299c6203bf9(lootid)) {
            player namespace_aead94004cf4c147::function_6f39f9916649ac48(lootid);
          }
        }

        keys = getlootscriptablearray("loot_multi_key_fortress");

        foreach(key in keys) {
          key freescriptable();
        }

        if(!isDefined(level.var_f1073fbd45b59a06.var_68693acbfbb8f4f5)) {
          level.var_f1073fbd45b59a06.var_68693acbfbb8f4f5 = 1;
        } else {
          level.var_f1073fbd45b59a06.var_68693acbfbb8f4f5 += 1;
        }

        logstring("BR STRONGHOLD " + array_find(level.var_f1073fbd45b59a06.var_df987907a483df89, door.fortress) + ": First blacksite fortress door unlocked.");
        scripts\mp\gametypes\br_analytics::function_5c71b11655c95436(door.fortress.origin);
      }
    }

    wait randomfloatrange(1, 3);

    if(isDefined(player)) {
      function_fdd0934f1a32f70d(player.origin, 128, "dmz_stronghold_unlock", player.team, undefined, "dmz_stronghold_unlock_classic");
    }

    subarea = door.fortress.subarea;

    if(isDefined(subarea) && isDefined(subarea.var_3ebb6024e3f220ca)) {
      foreach(agent in subarea.var_3ebb6024e3f220ca) {
        if(isagent(agent)) {
          agent.ignoreall = 0;
          continue;
        }

        if(isint(agent)) {
          scripts\cp_mp\agents\agent_utils::function_97fbd14bbcf19d9c(agent, "fortressAgent_setIgnoreAgentPostSpawn", &namespace_9823ee6035594d67::fortressagent_setignoreagentpostspawn);
        }
      }
    }
  }

  if(istrue(door.fortress.unspawned)) {
    scripts\mp\locksandkeys::function_fbbfe6f05eda5eb1(door);

    if(isDefined(door.connecteddoor)) {
      scripts\mp\locksandkeys::function_fbbfe6f05eda5eb1(door.connecteddoor);
    }
  }
}

function function_61c532e87e5f8c48(door, player) {
  if(isDefined(door.fortress) && !istrue(door.fortress.unlocked)) {
    door.fortress.unlocked = 1;
  }
}

function function_7f70094a3538a5fc() {
  level endon("game_ended");
  fortress = self;
  crate = fortress.crate;

  if(!isDefined(crate)) {
    return;
  }

  crate endon("death");

  while(true) {
    crate waittill("brLoadoutCapture", player);

    if(!isPlayer(player) || !isalive(player)) {
      continue;
    }

    fortress childthread function_b0024e6de3a39a5a();
  }
}

function function_b0024e6de3a39a5a() {
  level endon("game_ended");
  fortress = self;

  if(!isDefined(fortress.subarea) || !isDefined(fortress.subarea.trigger)) {
    return;
  }

  trigger = fortress.subarea.trigger;
  trigger endon("death");
  level endon("game_ended");
  self notify("brStronghold_restock");
  self endon("brStronghold_restock");

  while(true) {
    playersgone = 1;

    foreach(player in level.players) {
      if(isPlayer(player) && isalive(player) && ispointinvolume(player.origin, trigger)) {
        playersgone = 0;
        break;
      }

      waitframe();
    }

    if(istrue(playersgone)) {
      fortress function_790363161f332f0a();
      wait 1;

      if(fortress.var_ea7f19952edd93a6) {
        namespace_9823ee6035594d67::function_5bcf13b1577b232c(fortress, &function_3d34980ea9dfd41);
        fortress namespace_9823ee6035594d67::function_f01e587e03e81414();
        function_d95dbf57b47734d9(fortress, 0);
      }

      thread namespace_9823ee6035594d67::function_dec2a213ee64b9d(fortress, undefined);
      return;
    }

    wait 5;
  }
}

function function_975b0130f3e125e6() {
  fortress = self;
  level endon("endingSceneStop");
  fortress endon("fortressCleaned");
  level waittill("br_ending_start");
  fortress function_2cac20d9f1d15e9f(1);
}

function function_a35b99e2b0e4b68c() {
  fortress = self;
  level endon("br_ending_start");
  fortress endon("fortressCleaned");

  if(!isDefined(level.var_c40b3245a2c38005) || !isDefined(level.br_level.br_circleradii) || !isDefined(level.br_level.br_circleradii.size)) {
    return;
  }

  if(level.var_c40b3245a2c38005 < 1 || level.br_level.br_circleradii.size - 1 <= level.var_c40b3245a2c38005) {
    return;
  }

  level waittill("br_circle_set");

  while(level.br_circle.circleindex < level.br_level.br_circleradii.size - 1 - level.var_c40b3245a2c38005) {
    level waittill("br_circle_set");
  }

  fortress function_2cac20d9f1d15e9f(1);
}

function function_2cac20d9f1d15e9f(forcekill) {
  level endon("game_ended");
  fortress = self;
  fortress notify("brStronghold_circleWatch");
  fortress endon("brStronghold_circleWatch");

  if(istrue(level.var_cb8bc435cfe43c4c) && istrue(fortress.isblacksite) && !istrue(forcekill)) {
    return;
  }

  while(true) {
    if(!istrue(level.br_circle_disabled) && !ispointindangercircle(fortress.origin) || istrue(forcekill)) {
      if(istrue(level.var_1e0470dbb6cf1859)) {
        fortress function_89fcd9fd496706ad(fortress.missiontrigger);
      }

      if(istrue(level.var_6bc4952f4af08981)) {
        fortress function_89fcd9fd496706ad(fortress.proximitytrigger);
      }

      fortress.isactive = 0;
      scripts\mp\gametypes\br_analytics::function_f3cff8f31f5cdbf4(fortress.origin);
      fortress function_790363161f332f0a();

      if(isDefined(fortress.crate)) {
        fortress.crate function_1e0c0f3914e139ea(1);
      }

      fortress function_50aa951ab3c71fa4();

      if(istrue(level.var_9876d350e8206107)) {
        fortress notify("fortressDisabled");
      }

      if(!istrue(forcekill)) {
        fortress notify("fortressCleaned");
      }

      if(istrue(fortress.isblacksite)) {
        if(isDefined(level.var_f1073fbd45b59a06.var_ebfd05cb5f552e56)) {
          level.var_f1073fbd45b59a06.var_ebfd05cb5f552e56--;

          if(level.var_f1073fbd45b59a06.var_ebfd05cb5f552e56 <= 0) {
            lootid = scripts\cp_mp\utility\loot::getlootidfromref("loot_multi_key_fortress");

            foreach(player in level.players) {
              while(player namespace_aead94004cf4c147::function_d63a7299c6203bf9(lootid)) {
                player namespace_aead94004cf4c147::function_6f39f9916649ac48(lootid);
              }
            }

            keys = getlootscriptablearray("loot_multi_key_fortress");

            foreach(key in keys) {
              key freescriptable();
            }

            if(!isDefined(level.var_f1073fbd45b59a06.var_68693acbfbb8f4f5)) {
              level.var_f1073fbd45b59a06.var_68693acbfbb8f4f5 = 1;
              return;
            }

            level.var_f1073fbd45b59a06.var_68693acbfbb8f4f5 += 1;
          }
        }
      }

      return;
    }

    wait 5;
  }
}

function function_790363161f332f0a() {
  fortress = self;

  if(!istrue(fortress.spawnedagents)) {
    return;
  }

  subarea = fortress.subarea;

  if(!isDefined(subarea) || !isDefined(subarea.var_3ebb6024e3f220ca)) {
    return;
  }

  foreach(agent in subarea.var_3ebb6024e3f220ca) {
    if(!isDefined(agent)) {
      continue;
    }

    if(isagent(agent)) {
      agent scripts\mp\ai_mp_controller::function_28b90eb2b591003f();
    } else if(isint(agent)) {
      scripts\cp_mp\agents\agent_utils::function_4e065f1747aadd51(agent);
    }

    waitframe();
  }

  if(isDefined(fortress.var_fdbe1a2317a6a37d)) {
    fortress.var_fdbe1a2317a6a37d.var_13235d60c661e10b = 0;
  }

  foreach(patrol in fortress.patrolpaths) {
    if(isDefined(patrol)) {
      patrol.claimed = undefined;
    }
  }

  fortress.var_837c4b569aa8a376 = undefined;
  fortress notify("cleanup_agents");
  fortress.spawnedagents = 0;
}

function function_feb4d2d9c23e581c() {
  level endon("game_ended");

  foreach(fortress in level.var_f1073fbd45b59a06.var_df987907a483df89) {
    subarea = fortress.subarea;

    if(!isDefined(subarea) || !isDefined(subarea.var_3ebb6024e3f220ca)) {
      continue;
    }

    foreach(agent in subarea.var_3ebb6024e3f220ca) {
      if(!isDefined(agent)) {
        continue;
      }

      if(isagent(agent)) {
        agent.accuracy = 0.4;
        continue;
      }

      if(isint(agent)) {
        scripts\cp_mp\agents\agent_utils::function_58aab2edaec2599f(agent, "brStronghold_publicEventAgentPostSpawn", &brstronghold_publiceventagentpostspawn);
      }
    }
  }

  wait 90;

  foreach(fortress in level.var_f1073fbd45b59a06.var_df987907a483df89) {
    subarea = fortress.subarea;

    if(!isDefined(subarea) || !isDefined(subarea.var_3ebb6024e3f220ca)) {
      continue;
    }

    foreach(agent in subarea.var_3ebb6024e3f220ca) {
      if(!isDefined(agent)) {
        continue;
      }

      if(isagent(agent)) {
        agent.accuracy = agent.baseaccuracy;
        continue;
      }

      if(isint(agent)) {
        scripts\cp_mp\agents\agent_utils::function_97fbd14bbcf19d9c(agent, "brStronghold_publicEventAgentPostSpawn", &brstronghold_publiceventagentpostspawn);
      }
    }
  }
}

function brstronghold_publiceventagentpostspawn(agent) {
  agent.accuracy = 0.4;
}

function defaulttrue() {
  return true;
}

function function_405d3047ee9c2b3f() {
  if(getdvarint(@ "hash_ef50fad6149001b6", 0) != 0) {
    return;
  }

  while(!isDefined(level.br_ac130)) {
    wait 0.1;
  }

  fwd_ang = level.br_ac130.angles;
  fwd_ang += (0, -90, 0);
  fortress = self;
  fortress function_dc34a21ff66578cf(fortress.var_c4b85c30a02a19f8, fortress.origin, fwd_ang);
  fortress thread function_39bb860db14e2d9();
}

function function_dc34a21ff66578cf(scriptablestate, pos, fwd_ang) {
  fortress = self;

  if(istrue(self.isblacksite) && getdvarint(@ "hash_634e713979b0981a", 1)) {
    return;
  }

  fx_model = function_c5587aca56db730e();
  pos += (0, 0, 1000);
  var_6db960044e337f44 = spawn("script_model", pos);
  var_6db960044e337f44 setModel(fx_model);
  var_6db960044e337f44.angles = fwd_ang;
  var_6db960044e337f44 setscriptablepartstate("name_fx", scriptablestate, 0);
  var_6db960044e337f44 forcenetfieldhighlod(1);
  fortress.stronghold_fx = var_6db960044e337f44;
}

function function_39bb860db14e2d9() {
  fortress = self;

  if(isDefined(level.br_ac130)) {
    level.br_ac130 waittill("death");
  }

  wait 90;

  if(isDefined(fortress.stronghold_fx)) {
    fortress.stronghold_fx delete();
  }
}

function function_c5587aca56db730e() {
  if(scripts\cp_mp\utility\game_utility::function_eb4bce9b222e36ac()) {
    return "jup_tag_origin_name_fx";
  } else if(scripts\cp_mp\utility\game_utility::function_7ee65fae13124702()) {
    return "iw9_tag_origin_name_fx";
  } else if(scripts\cp_mp\utility\game_utility::function_5e0e3a24dbb1fae1()) {
    return "iw9_tag_origin_name_fx_delta";
  }

  return "jup_tag_origin_name_fx";
}

function function_5c26662d5381e975(player, duration, uavtype, var_3f45228e0b9cd155) {
  fortress = self;
  fortress.captured = 1;
  fortress.capturedteam = player.team;
  timetoadd = fortress.tieroverride * 15;

  if(isDefined(fortress.crate)) {
    fortress.crate function_faa1ecbc7f0bed85(player, 1, undefined, undefined, var_3f45228e0b9cd155);
    fortress.crate.teams = [];
  }

  if(!isDefined(uavtype)) {
    uavtype = "uav";
  }

  if(!isDefined(duration)) {
    duration = level.uavsettings[uavtype].timeout + timetoadd;
  }

  if(istrue(fortress.isblacksite)) {
    player scripts\mp\utility\stats::incpersstat("blacksitesCaptured", 1);
    player scripts\cp_mp\challenges::function_38e2bca264061aa0();
  } else {
    player scripts\mp\utility\stats::incpersstat("strongholdsCaptured", 1);
    player scripts\cp_mp\challenges::function_45ab928fbc73f76c();
  }

  if(level.var_58adce74179ab9ef) {
    player scripts\mp\utility\stats::incpersstat("objectivesCompleted", 1);
    player scripts\mp\gametypes\br_public::updatebrscoreboardstat("missionsCompleted", player scripts\mp\utility\stats::getpersstat("objectivesCompleted"));
  }

  namespace_9823ee6035594d67::function_b663f29079a15c71(fortress, 1, player);
  level thread namespace_1eb3c4e0e28fac71::utilflare_shootflare(fortress.origin, "dom", 0);
  logstring("BR STRONGHOLD " + array_find(level.var_f1073fbd45b59a06.var_df987907a483df89, fortress) + ": Stronghold Captured!");
  scripts\mp\gametypes\br_analytics::function_257618a8537d8d10(fortress.origin);

  if(istrue(level.var_25e8b4afe5e06169)) {
    namespace_9823ee6035594d67::function_d95dbf57b47734d9(fortress, 1);
    fortress notify("fortressTaken");
    waitframe();
  }

  player thread function_bc8c42a438ada1fc(duration, fortress, uavtype);
  fortress thread function_33c923257f7205cc(player, duration);
}

function function_bc8c42a438ada1fc(duration, fortress, uavtype) {
  fortress endon("fortressDisabled");
  fortress endon("fortressTaken");
  fortress endon("fortressNeutralized");
  player = self;
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(uavtype, player);
  streakinfo.skipequippedstreakcheck = 1;
  uavradius = level.var_216890f92cb91c6e;
  var_ec00e2b85c91da0c = 3;
  var_6c3716013ea4f716 = 6;

  if(istrue(fortress.isblacksite)) {
    uavradius = level.var_316321eb17328d69;
    var_ec00e2b85c91da0c = 4;
    var_6c3716013ea4f716 = 4;
  }

  team = player.pers["team"];
  launchorigin = fortress.origin;
  function_f6161fa6a1d6d9b4(player, team, streakinfo);

  if(istrue(level.var_313687786f342b97)) {
    fortress function_8cb09621e37113a5(team, uavradius);
  }

  timepassed = 0;

  while(timepassed < duration && isDefined(fortress) && istrue(fortress.captured)) {
    if(!isDefined(team)) {
      break;
    }

    triggerportableradarpingteam(launchorigin, team, uavradius, var_ec00e2b85c91da0c * 1000);
    wait var_6c3716013ea4f716;

    if(istrue(level.var_53f26aece124345a)) {
      continue;
    }

    timepassed += var_6c3716013ea4f716;
  }
}

function function_f6161fa6a1d6d9b4(player, team, streakinfo) {
  vostreakname = streakinfo.streakname;
  var_52a5be2e2f91d710 = undefined;
  scripts\cp_mp\utility\killstreak_utility::killstreak_dangernotifyplayersinrange(player, team, level.var_216890f92cb91c6e, vostreakname);
}

function function_33c923257f7205cc(player, duration) {
  fortress = self;
  wait duration;
}

function function_f1c08b6e7a66d560() {
  fortress = self;
  zonename = function_aae8b5dc22c12d2c(fortress.name);

  if(!isDefined(zonename)) {
    fortress.var_826fd6df38b2a6ad = 1;
    logstring("BR STRONGHOLD: Fortress Name - " + fortress.name + " does not have a valid zone. Rejecting...");
    return false;
  }

  if(!isDefined(fortress.loadout) || fortress.loadout.size <= 0) {
    logstring("BR STRONGHOLD: Fortress Name - " + fortress.name + " does not have a valid loadout node. Rejecting...");
    return false;
  }

  if(!array_contains(level.var_f1073fbd45b59a06.var_df987907a483df89, fortress)) {
    fortress.var_826fd6df38b2a6ad = 1;
    logstring("BR STRONGHOLD: Zone Name - " + zonename + " is not contained within the chosenFortresses array. Rejecting...");
    return false;
  }

  logstring("BR STRONGHOLD " + array_find(level.var_f1073fbd45b59a06.var_df987907a483df89, fortress) + ": Zone Name - " + zonename + ".");
  scripts\mp\gametypes\br_analytics::function_2cc353fdc725f4b4(fortress.origin, string(fortress.name) + ": Zone Name - " + zonename);
  fortress.bounds = function_6a9090e74fd4e90a(fortress.name);

  if(!isDefined(fortress.bounds)) {
    logstring("BR STRONGHOLD " + array_find(level.var_f1073fbd45b59a06.var_df987907a483df89, fortress) + ": Zone Name - " + zonename + " has undefined zone bounds. Rejecting...");
    scripts\mp\gametypes\br_analytics::function_ea157b4b9615b2df(fortress.origin, string(fortress.name) + ": Zone Name - " + zonename + " has undefined zone bounds. Rejecting.");
    return false;
  }

  halfsize = fortress.bounds.halfsize;
  avghalfsize = (halfsize[0] + halfsize[1]) / 2;
  midpoint = fortress.bounds.midpoint;
  startpoint = (midpoint[0], midpoint[1], midpoint[2] - halfsize[2] * 2.975);
  radius = avghalfsize * 2.975;
  var_56946a63f73ad524 = distance2d(fortress.origin, startpoint);

  if(var_56946a63f73ad524 >= radius) {
    logstring("BR STRONGHOLD " + array_find(level.var_f1073fbd45b59a06.var_df987907a483df89, fortress) + ": Zone Name - " + zonename + " has a mismatched zone bounds. Rejecting...");
    scripts\mp\gametypes\br_analytics::function_41082d2a8cf1ee28(fortress.origin, string(fortress.name) + ": Zone Name - " + zonename + "has a mismatched zone bounds. Rejecting.");
    return false;
  }

  return true;
}

function function_60523e441e1a1346(player, dropstruct) {
  if(level.var_153bec2ca80c491a > 0 && isDefined(player)) {
    if(randomfloatrange(0, 100) <= level.var_4fe32157adc88b9c) {
      if(!isDefined(level.var_f1073fbd45b59a06.var_68693acbfbb8f4f5)) {
        keys = player namespace_bd614c3c2275579a::function_9d216f4cd30f141d(dropstruct, scripts\mp\utility\player::getteamarray(player.team, 0), player.team, 1, self);
        return keys;
      } else if(level.var_f1073fbd45b59a06.var_68693acbfbb8f4f5 < level.var_153bec2ca80c491a) {
        keys = player namespace_bd614c3c2275579a::function_9d216f4cd30f141d(dropstruct, scripts\mp\utility\player::getteamarray(player.team, 0), player.team, 1, self);
        return keys;
      }
    }

    return undefined;
  }
}

function function_f9ff7c89b3792ccc(dropstruct, blacksite, keyent, originalteam, var_80e8221bfc39ac63, dropinfo) {
  player = self;

  if(!isDefined(blacksite)) {
    return;
  }

  teamplayers = getteamarray(player.team, 0);

  foreach(teamplayer in teamplayers) {
    omnvarstate = teamplayer getclientomnvar("ui_br_stronghold_mission");

    if(isDefined(omnvarstate) && omnvarstate == 19) {
      teamplayer setclientomnvar("ui_br_stronghold_mission", 34);
    }

    if(isDefined(teamplayer.var_17ff8aa2629a12c1) && array_contains(teamplayer.var_17ff8aa2629a12c1, blacksite)) {
      teamplayer.var_17ff8aa2629a12c1 = array_remove(teamplayer.var_17ff8aa2629a12c1, blacksite);
    }

    if(istrue(blacksite.infiltrated)) {}
  }

  var_f733605b98e86f2 = undefined;

  if(istrue(blacksite.captured)) {
    teamplayers = getteamarray(player.team, 0);

    foreach(teamplayer in teamplayers) {
      omnvarstate = teamplayer getclientomnvar("ui_br_stronghold_mission");

      if(isDefined(omnvarstate) && (omnvarstate != 20 || omnvarstate != 36 || omnvarstate != 21)) {
        teamplayer setclientomnvar("ui_br_stronghold_mission", 255);
      }
    }

    return;
  }

  keys = undefined;

  if(isDefined(keyent)) {
    var_f733605b98e86f2 = keyent;
  } else if(istrue(var_80e8221bfc39ac63)) {
    keys = [];

    if(!isDefined(dropinfo)) {
      dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, player.origin, player.angles, self);
    } else {
      dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, dropinfo.origin, dropinfo.angles, self);
    }

    var_f733605b98e86f2 = scripts\mp\gametypes\br_pickups::spawnpickup("loot_multi_key_fortress", dropinfo, 1, 1);
    var_f733605b98e86f2.originalteam = originalteam;
    keys[keys.size] = var_f733605b98e86f2;
  } else {
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, player.origin, player.angles, self);
    var_f733605b98e86f2 = scripts\mp\gametypes\br_pickups::spawnpickup("loot_multi_key_fortress", dropinfo, 1, 1);
    var_f733605b98e86f2.originalteam = originalteam;
    var_f733605b98e86f2.var_a88417917d64076c = namespace_9823ee6035594d67::function_c0a211a69f5f8f2f(var_f733605b98e86f2.origin);
  }

  var_f733605b98e86f2.blacksite = blacksite;

  if(isDefined(dropstruct.tree)) {
    var_f733605b98e86f2.tree = dropstruct.tree;
  }

  var_f733605b98e86f2 thread function_af2a03d93a590c6f();
}

function function_af2a03d93a590c6f() {
  var_f733605b98e86f2 = self;
  objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  wait 1;

  if(!isDefined(var_f733605b98e86f2)) {
    return;
  }

  if(objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "current", var_f733605b98e86f2.origin, "ui_map_icon_obj_jailkey");
    scripts\mp\objidpoolmanager::function_79a1a16de6b22b2d(objectiveiconid, 19);
    scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 1);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objectiveiconid);
    scripts\mp\objidpoolmanager::objective_set_play_intro(objectiveiconid, 1);
    objective_sethideelevation(objectiveiconid, 1);
  }

  var_f733605b98e86f2.objectiveiconid = objectiveiconid;
  var_f733605b98e86f2 thread function_a9fc7c37845ae22b();
}

function function_a9fc7c37845ae22b() {
  level endon("game_ended");
  var_f733605b98e86f2 = self;
  var_f733605b98e86f2.var_5d4efada59c61b13 = [];
  objid = var_f733605b98e86f2.objectiveiconid;

  while(isDefined(var_f733605b98e86f2)) {
    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      var_efd412d96a7c016f = 1;

      if(istrue(level.var_c1bd59bc77e5ab37)) {
        dist = distance2d(player.origin, var_f733605b98e86f2.origin);
        var_efd412d96a7c016f = dist <= 7875;
      }

      if(var_efd412d96a7c016f && !array_contains(var_f733605b98e86f2.var_5d4efada59c61b13, player)) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(objid, player);
        var_f733605b98e86f2.var_5d4efada59c61b13 = array_add(var_f733605b98e86f2.var_5d4efada59c61b13, player);
      }
    }

    var_f733605b98e86f2 function_65899a750d87184();
    wait 0.5;
  }

  scripts\mp\objidpoolmanager::returnobjectiveid(objid);
}

function function_65899a750d87184() {
  level endon("game_ended");
  var_f733605b98e86f2 = self;
  objid = var_f733605b98e86f2.objectiveiconid;
  var_84efe8e0d0ee4347 = [];

  foreach(player in var_f733605b98e86f2.var_5d4efada59c61b13) {
    if(!isDefined(player)) {
      continue;
    }

    if(!isreallyalive(player) || player isplayeringulag()) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(objid, player);
      continue;
    }

    if(istrue(level.var_c1bd59bc77e5ab37)) {
      dist = distance2d(player.origin, var_f733605b98e86f2.origin);

      if(dist > 7875) {
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom(objid, player);
        continue;
      }
    }

    var_84efe8e0d0ee4347[var_84efe8e0d0ee4347.size] = player;
  }

  var_f733605b98e86f2.var_5d4efada59c61b13 = var_84efe8e0d0ee4347;
}

function function_2e6a3f3e4d2731ea(var_2dc8d4d47e9254b3, var_91a6a98fa0d577b) {
  if(istrue(var_2dc8d4d47e9254b3)) {
    foreach(fortress in level.var_f1073fbd45b59a06.var_df987907a483df89) {
      fortress.bounds = function_6a9090e74fd4e90a(fortress.name);
      halfsize = fortress.bounds.halfsize;
      avghalfsize = (halfsize[0] + halfsize[1]) / 2;
      midpoint = fortress.bounds.midpoint;
      startpoint = (midpoint[0], midpoint[1], midpoint[2] - halfsize[2] * 2.975);
      height = 2 * halfsize[2] * 2.975;
      radius = avghalfsize * 2.975;
      fortress.missiontrigger = spawn("trigger_radius", startpoint, 0, int(radius), int(height));
      fortress.missiontrigger.radius = radius;
      fortress.missiontrigger.height = height;
      fortress.missiontrigger.entnum = fortress.missiontrigger getentitynumber();
      fortress.missiontrigger.fortress = fortress;
      fortress.missiontrigger.var_51785c3dce118d4b = 3000;
      fortress.activity = fortress.activities[randomint(fortress.activities.size)];

      if(fortress.activity == "poi") {
        fortress.shouldspawnboss = 1;
      }

      fortress thread scripts\mp\gametypes\activity_manager::function_821fa443949531c9(fortress.missiontrigger, fortress.activity);
    }

    return;
  }

  if(isDefined(var_91a6a98fa0d577b)) {
    var_91a6a98fa0d577b.bounds = function_6a9090e74fd4e90a(var_91a6a98fa0d577b.name);
    halfsize = var_91a6a98fa0d577b.bounds.halfsize;
    avghalfsize = (halfsize[0] + halfsize[1]) / 2;
    midpoint = var_91a6a98fa0d577b.bounds.midpoint;
    startpoint = (midpoint[0], midpoint[1], midpoint[2] - halfsize[2] * 3);
    height = 2 * halfsize[2] * 3;
    radius = avghalfsize * 3;
    var_91a6a98fa0d577b.proximitytrigger = spawn("trigger_radius", startpoint, 0, int(radius), int(height));
    var_91a6a98fa0d577b.proximitytrigger.radius = radius;
    var_91a6a98fa0d577b.proximitytrigger.height = height;
    var_91a6a98fa0d577b.proximitytrigger.entnum = var_91a6a98fa0d577b.proximitytrigger getentitynumber();
    var_91a6a98fa0d577b.proximitytrigger.fortress = var_91a6a98fa0d577b;
    var_91a6a98fa0d577b.proximitytrigger.var_51785c3dce118d4b = 500;
    var_91a6a98fa0d577b thread function_677d53dd4de3ffa0(var_91a6a98fa0d577b.proximitytrigger);
  }
}

function function_89fcd9fd496706ad(trigger) {
  fortress = self;

  if(!isDefined(trigger)) {
    return;
  }

  entitynumber = trigger.entnum;
  trigger notify("deleted");
  trigger delete();
  trigger = undefined;
}

function function_677d53dd4de3ffa0(proximitytrigger) {
  triggerowner = self;
  level endon("game_ended");
  proximitytrigger endon("deleted");
  proximitytrigger.touchents = [];
  proximitytrigger.var_3551befc72f03b2d = [];
  triggerowner thread function_3af1473d439d8c32(proximitytrigger, 500);
  triggerowner thread function_c086af0092ccae2a(proximitytrigger);

  while(true) {
    validenter = 0;
    proximitytrigger waittill("trigger", ent);

    if(!istrue(triggerowner.unlocked)) {
      continue;
    }

    if(ent scripts\cp_mp\vehicles\vehicle::isvehicle() && !isDefined(ent.streakinfo)) {
      occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(ent);

      if(!isDefined(occupants)) {
        continue;
      }

      foreach(occupant in occupants) {
        if(proximitytrigger function_10d6ec90ef72ae7c(occupant)) {
          validenter = proximitytrigger function_314ea7c011b7cec2(occupant, proximitytrigger.entnum, triggerowner);

          if(validenter) {
            proximitytrigger function_56864189ff63887d(occupant);
            proximitytrigger function_f344712dff7facb6(occupant);

            if(isDefined(level.var_d127a6a056d31d74) && isPlayer(ent)) {
              proximitytrigger[[level.var_d127a6a056d31d74]](occupant);
            }
          }
        }
      }

      continue;
    }

    if(proximitytrigger function_10d6ec90ef72ae7c(ent)) {
      validenter = proximitytrigger function_314ea7c011b7cec2(ent, proximitytrigger.entnum, triggerowner);

      if(validenter) {
        proximitytrigger function_56864189ff63887d(ent);
        proximitytrigger function_f344712dff7facb6(ent);

        if(isDefined(level.var_d127a6a056d31d74) && isPlayer(ent)) {
          proximitytrigger[[level.var_d127a6a056d31d74]](ent);
        }
      }
    }
  }
}

function function_56864189ff63887d(player) {
  proximitytrigger = self;
  playerentnum = player getentitynumber();

  if(!isDefined(proximitytrigger.touchents[playerentnum])) {
    proximitytrigger notify("trigger_enter", player);
    proximitytrigger.touchents[playerentnum] = player;
    proximitytrigger.var_3551befc72f03b2d[playerentnum] = gettime();
    return;
  }

  proximitytrigger.var_3551befc72f03b2d[playerentnum] = gettime();
}

function function_10d6ec90ef72ae7c(player) {
  triggervol = self;

  if(!isPlayer(player) && !isagent(player)) {
    return false;
  }

  if(!isreallyalive(player)) {
    return false;
  }

  if(istrue(triggervol.trigger_off)) {
    return false;
  }

  if(isDefined(player.classname) && player.classname == "script_vehicle") {
    return false;
  }

  return true;
}

function function_314ea7c011b7cec2(player, triggerentnum, triggerowner) {
  if(isDefined(triggerowner) && isDefined(triggerowner.proximitytrigger)) {
    return player function_e51ecdf790ee27b4(triggerowner);
  }

  return 0;
}

function function_e51ecdf790ee27b4(triggerowner) {
  player = self;

  if(!isPlayer(player) && isagent(player)) {
    return true;
  }

  playerentnum = player getentitynumber();

  if(isDefined(triggerowner.proximitytrigger.touchents) && !array_contains(triggerowner.proximitytrigger.touchents, player)) {
    if(istrue(level.var_c77adbf64b306ab) && istrue(triggerowner.cleared)) {
      thread function_182cb0e167ad745a(triggerowner, "high", level.var_b689ba1b4a0c1f5d, 0);
    }
  }

  return true;
}

function function_3af1473d439d8c32(proximitytrigger, var_9399bf62b66519d1) {
  assertex(isDefined(proximitytrigger), "<dev string:x17d>");
  triggerowner = self;
  level endon("game_ended");
  proximitytrigger endon("deleted");
  proximitytrigger endon("activity_ended");

  if(!isDefined(var_9399bf62b66519d1)) {
    var_9399bf62b66519d1 = 9000;
  }

  var_51785c3dce118d4b = 0;

  if(!isDefined(proximitytrigger.var_51785c3dce118d4b)) {
    var_51785c3dce118d4b = 300;
  } else {
    var_51785c3dce118d4b = proximitytrigger.var_51785c3dce118d4b;
  }

  resolutions = var_51785c3dce118d4b / 1000;
  assertex(resolutions > 0, "<dev string:x1b7>");

  while(true) {
    wait resolutions;

    foreach(playerentnum, touchent in proximitytrigger.touchents) {
      if(!isDefined(touchent)) {
        proximitytrigger.touchents[playerentnum] = undefined;
        proximitytrigger.var_3551befc72f03b2d[playerentnum] = undefined;
        continue;
      }

      assertex(isDefined(proximitytrigger.var_3551befc72f03b2d[playerentnum]), "<dev string:x1dd>");
      currenttime = gettime();
      var_ca63cbdf2251b4af = currenttime - proximitytrigger.var_3551befc72f03b2d[playerentnum];

      if(var_ca63cbdf2251b4af > var_9399bf62b66519d1) {
        proximitytrigger notify("trigger_exit", touchent);
        proximitytrigger.touchents[playerentnum] = undefined;
        proximitytrigger.var_3551befc72f03b2d[playerentnum] = undefined;

        if(isDefined(level.var_18889818bace4953) && isPlayer(touchent)) {
          proximitytrigger[[level.var_18889818bace4953]](touchent);
        }

        proximitytrigger function_e9183e4cbb12da33(touchent);

        if(isDefined(proximitytrigger.touchents.size) && proximitytrigger.touchents.size == 0) {
          if(isDefined(triggerowner.objectiveiconid)) {
            if(!istrue(level.var_25e8b4afe5e06169) || !isDefined(triggerowner.capturedteam)) {
              function_d95dbf57b47734d9(triggerowner, 0);
            }
          }
        }
      }
    }
  }
}

function function_c086af0092ccae2a(proximitytrigger) {
  assertex(isDefined(proximitytrigger), "<dev string:x17d>");
  var_51785c3dce118d4b = 0;

  if(!isDefined(proximitytrigger.var_51785c3dce118d4b)) {
    var_51785c3dce118d4b = 300;
  } else {
    var_51785c3dce118d4b = proximitytrigger.var_51785c3dce118d4b;
  }

  resolutions = var_51785c3dce118d4b / 1000;
  assertex(resolutions > 0, "<dev string:x1b7>");

  while(true) {
    wait resolutions;
    proximitytrigger.aicount = 0;
    proximitytrigger.playercount = 0;
    proximitytrigger.reinforce = 1;

    foreach(touchent in proximitytrigger.touchents) {
      if(!isDefined(touchent)) {
        continue;
      }

      if(!isPlayer(touchent) && isagent(touchent)) {
        proximitytrigger.aicount++;
        continue;
      }

      if(isPlayer(touchent)) {
        proximitytrigger.playercount++;
      }
    }

    if(isDefined(level.var_8d0436f6f57eda69) && level.var_8d0436f6f57eda69 > 0) {
      if(proximitytrigger.aicount >= level.var_8d0436f6f57eda69) {
        proximitytrigger.reinforce = 0;
      } else {
        proximitytrigger.reinforce = 1;
      }

      if(isDefined(level.var_b419b238d63cdfc6) && level.var_b419b238d63cdfc6 > 0) {
        if(!istrue(proximitytrigger.reinforce)) {
          if(proximitytrigger.aicount + proximitytrigger.playercount >= level.var_8d0436f6f57eda69 + level.var_b419b238d63cdfc6) {
            proximitytrigger.reinforce = 0;
            continue;
          }

          proximitytrigger.reinforce = 1;
        }
      }
    }
  }
}

function private function_24d72130103d8922(playerassimilated, oldteam, newteam) {
  if(isDefined(playerassimilated.var_17ff8aa2629a12c1)) {
    foreach(blacksite in playerassimilated.var_17ff8aa2629a12c1) {
      namespace_9823ee6035594d67::function_c7dcbb4c3ac66791(blacksite, playerassimilated);
    }

    playerassimilated.var_17ff8aa2629a12c1 = undefined;
  }

  var_c727f8cad48224f7 = playerassimilated namespace_aead94004cf4c147::function_5915bdbc5f6302b6([8525]);

  foreach(var_b9f48d832d75ef66 in var_c727f8cad48224f7) {
    playerassimilated thread scripts\mp\gametypes\br_pickups::quickdropitem(10, var_b9f48d832d75ef66, 0);
  }

  playerassimilated setclientomnvar("ui_br_stronghold_mission_progress", 0);
  newteammembers = getteamarray(newteam, 0);

  foreach(teammember in newteammembers) {
    if(teammember != playerassimilated) {
      if(isDefined(teammember.var_17ff8aa2629a12c1)) {
        foreach(blacksite in teammember.var_17ff8aa2629a12c1) {
          function_ed5dd045e2e3dc5b(blacksite, playerassimilated, 0);
        }
      }

      var_f141a9dc5e77efcb = teammember getclientomnvar("ui_br_stronghold_mission");

      switch (var_f141a9dc5e77efcb) {
        case 0:
        case 21:
        case 36:
          var_f141a9dc5e77efcb = 255;
          break;
        default:
          break;
      }

      playerassimilated setclientomnvar("ui_br_stronghold_mission", var_f141a9dc5e77efcb);
      break;
    }
  }

  if(isDefined(level.var_f1073fbd45b59a06) && isDefined(level.var_f1073fbd45b59a06.var_df987907a483df89)) {
    foreach(fortress in level.var_f1073fbd45b59a06.var_df987907a483df89) {
      if(isDefined(fortress.capturedteam)) {
        if(fortress.capturedteam == oldteam && !istrue(fortress.isblacksite)) {
          namespace_9823ee6035594d67::function_7ee5340d1a5a2ca9(fortress, playerassimilated);

          if(istrue(level.var_313687786f342b97)) {
            fortress function_cfd53c8f6878014f(playerassimilated);
          }

          continue;
        }

        if(fortress.capturedteam == newteam) {
          namespace_9823ee6035594d67::function_917d94cc077ca94e(fortress, playerassimilated);

          if(istrue(level.var_313687786f342b97)) {
            fortress function_d7d113d56ef0ef5b(playerassimilated);
          }
        }
      }
    }
  }

  if(isDefined(level.var_895e881b2f784bcc)) {
    [[level.var_895e881b2f784bcc]](playerassimilated, oldteam, newteam);
  }
}

function function_58931f9d0a83f414(player, crate) {
  if(isDefined(crate.players) && array_contains(crate.players, player)) {
    return true;
  }

  if(isDefined(crate.var_4261eb2ab67db6f7) && array_contains(crate.var_4261eb2ab67db6f7, player)) {
    return true;
  }

  return false;
}

function function_8cb09621e37113a5(team, circleradius) {
  function_6b6b6273f8180522("active_uav_tower_radius", self.origin, circleradius);
  function_6988310081de7b45();

  if(isDefined(team)) {
    foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
      function_d7d113d56ef0ef5b(player);
    }
  }

  thread function_fd201112c20529a2();
}

function function_fd201112c20529a2() {
  waittill_any_3("fortressDisabled", "fortressTaken", "fortressNeutralized");

  if(function_acaa75ca8754452e()) {
    function_af5604ce591768e1();
  }
}

function function_3e91787ae694d5c1(alias) {
  if(!istrue(self.isplayingvo)) {
    self.isplayingvo = 1;
    soundname = "dx_br_jpbm_" + game["dialog"][alias];
    self playsoundonmovingent(soundname);
    length = lookupsoundlength(soundname);
    wait length / 1000 + 1;
    self.isplayingvo = 0;
    return;
  }
}

function function_ac7dce0a21508d6e(alias, players) {
  scripts\mp\gametypes\br_public::brleaderdialog(alias, 0, players, 1, undefined, undefined, "dx_br_jpbm_");
}

function function_20ade7ff2a106977(fortress, var_66b192f273029832, newstate) {
  player = self;
  eventparams = [];
  eventparams[eventparams.size] = "player_xuid";

  if(!isDefined(player)) {
    playerxuid = "";
  } else {
    playerxuid = player getxuid();
  }

  eventparams[eventparams.size] = playerxuid;
  eventparams[eventparams.size] = "team_name";

  if(!isDefined(player)) {
    playerteam = "";
  } else {
    playerteam = player.team;
  }

  eventparams[eventparams.size] = playerteam;
  eventparams[eventparams.size] = "stronghold_identifier";
  strongholdidentifier = fortress.script_noteworthy;
  eventparams[eventparams.size] = strongholdidentifier;
  eventparams[eventparams.size] = "stronghold_type";
  strongholdidentifier = fortress.var_6a9a1aeeaa7c25df;
  eventparams[eventparams.size] = strongholdidentifier;
  eventparams[eventparams.size] = "previous_state";

  switch (newstate) {
    case #"hash_4f37b2e4955fbc1f":
      previousstate = "neutral";
      break;
    case #"hash_748816eb741534fa":
      previousstate = "captured";
      break;
    default:
      previousstate = "neutral";
      break;
  }

  eventparams[eventparams.size] = previousstate;
  eventparams[eventparams.size] = "new_state";
  eventparams[eventparams.size] = newstate;
  eventparams[eventparams.size] = "cause_of_state_change";
  eventparams[eventparams.size] = var_66b192f273029832;
  eventparams[eventparams.size] = "time_since_last_change";

  if(isDefined(fortress.var_e6bc46f229e08219)) {
    timesincelastchange = int((gettime() - fortress.var_e6bc46f229e08219) / 1000);
  } else {
    timesincelastchange = -1;
    fortress.var_e6bc46f229e08219 = gettime();
  }

  eventparams[eventparams.size] = timesincelastchange;
  eventparams[eventparams.size] = "is_blacksite";
  eventparams[eventparams.size] = string(istrue(fortress.isblacksite));

  if(!isDefined(player)) {
    player = scripts\mp\gamelogic::gethostplayer();
  }

  player dlog_recordplayerevent("dlog_event_br_stronghold_event", eventparams);
}

function function_c3bc424d680ab470(fortress, point) {
  if(!isDefined(fortress) || !isDefined(fortress.bounds)) {
    return false;
  }

  largesthalfsize = max(fortress.bounds.halfsize[0], fortress.bounds.halfsize[1]);
  largesthalfsize *= largesthalfsize;

  if(distance2dsquared(point, fortress.bounds.midpoint) > largesthalfsize) {
    return false;
  }

  if(abs(point[2] - fortress.bounds.midpoint[2]) > fortress.bounds.halfsize[2]) {
    return false;
  }

  return true;
}

function function_20a22133815385f8(point) {
  if(!isDefined(level.var_f1073fbd45b59a06)) {
    return false;
  }

  foreach(blacksite in level.var_f1073fbd45b59a06.blacksites) {
    if(function_c3bc424d680ab470(blacksite, point)) {
      return true;
    }
  }

  return false;
}

function function_de1bd18e889bf4cf() {
  level endon("<dev string:x20f>");

  while(!scripts\mp\flags::gameflagexists("<dev string:x21d>")) {
    waitframe();
  }

  scripts\mp\flags::gameflagwait("<dev string:x21d>");

  while(true) {
    if(getdvarint(@ "hash_b4c88bd48b0a11df", 0)) {
      foreach(fortress in level.var_f1073fbd45b59a06.var_df987907a483df89) {
        fortress childthread function_b0024e6de3a39a5a();
      }

      setDvar(@ "hash_b4c88bd48b0a11df", 0);
    } else if(getdvarint(@ "hash_f73acffeb6f8f97a", 0)) {
      level thread function_feb4d2d9c23e581c();
      setDvar(@ "hash_f73acffeb6f8f97a", 0);
    }

    wait 1;
  }
}

function function_595371fc4dfe389e() {
  level endon("<dev string:x20f>");

  if(level.var_5d89e32b0b1d5e91) {
    while(!isDefined(level.struct_class_names)) {
      waitframe();
    }

    level.buildingslist = spawnStruct();
    level.buildingslist.var_b7e45754fc79e080 = [];
    var_b7e45754fc79e080 = getStructArray("<dev string:x7a>", "<dev string:x22e>");
    assertex(isDefined(var_b7e45754fc79e080), "<dev string:x23c>");
    level.buildingslist.var_b7e45754fc79e080 = var_b7e45754fc79e080;

    if(level.buildingslist.size <= 0) {
      assertex(isDefined(level.buildingslist), "<dev string:x260>");
      println("<dev string:x281>");
      println("<dev string:x29b>");
      println("<dev string:x2a4>");
      return;
    }

    function_5edce2f3bff589aa();

    while(true) {
      if(isDefined(level.buildingslist.var_b7e45754fc79e080)) {
        foreach(building in level.buildingslist.var_b7e45754fc79e080) {
          if(!isDefined(building.circledeployed)) {
            building.circledeployed = 0;
          }

          if(!isDefined(building.targetname)) {
            continue;
          }

          if(isDefined(building.loadout)) {
            building.var_5dfdfd9369ac6229 = 1;
          }

          if(istrue(building.var_5dfdfd9369ac6229) && building.targetname == "<dev string:x7a>") {
            line(building.origin, building.origin + (0, 0, building.buildingnumber * 15 + 2500), (0.9, 0.45, 0.16), 1, 1, 1);

            if(isDefined(building.details)) {
              debugstar(building.origin + (0, 0, building.buildingnumber * 15 + 2500), (0.9, 0.45, 0.16), 1, building.details, 8);
            } else {
              debugstar(building.origin + (0, 0, building.buildingnumber * 15 + 2500), (0.9, 0.45, 0.16), 1, "<dev string:x2c2>", 8);
            }

            continue;
          }

          if(building.targetname == "<dev string:x7a>") {
            line(building.origin, building.origin + (0, 0, building.buildingnumber * 15 + 1500), (0, 0.53, 1), 1, 1, 1);

            if(isDefined(building.details)) {
              debugstar(building.origin + (0, 0, building.buildingnumber * 15 + 1500), (0, 0.53, 1), 1, building.details, 8);
              continue;
            }

            debugstar(building.origin + (0, 0, building.buildingnumber * 15 + 1500), (0, 0.53, 1), 1, "<dev string:x2de>", 8);
          }
        }
      }

      waitframe();
    }
  }
}

function function_5edce2f3bff589aa() {
  buildingnumber = 1;
  println("<dev string:x281>");

  foreach(building in level.buildingslist.var_b7e45754fc79e080) {
    building.buildingnumber = buildingnumber;
    building.details = building.targetname + "<dev string:x2fc>" + building.buildingnumber + "<dev string:x301>" + building.origin + "<dev string:x301>" + building.script_noteworthy;
    println(building.targetname + "<dev string:x2fc>" + buildingnumber + "<dev string:x301>" + building.origin + "<dev string:x301>" + building.script_noteworthy);
    buildingnumber++;
  }

  println("<dev string:x2a4>");
  buildingnumber = undefined;
}

function function_2e05a3e6a13f7f41() {
  level.var_a26603334c1c6a92 = getDvar(@ "hash_cdeb1ca71e6be198", "<dev string:x308>");
  level.var_9ae90712d17712c9 = getDvar(@ "hash_b35fcff8546c9263", "<dev string:x346>");
  level.var_6ff106c0b1a35216 = getDvar(@ "hash_6d1915e851755f48", "<dev string:x38c>");
  level.var_b058b2f92388e765 = getDvar(@ "hash_13bcb7740a523cb3", "<dev string:x3cb>");
  var_a29c86dde2b7dd80 = function_f34eafaf99a10ee5();
  lootzones = [];

  for(zoneindex = 0; zoneindex < var_a29c86dde2b7dd80; zoneindex++) {
    lootzones[lootzones.size] = function_aae8b5dc22c12d2c(zoneindex);
  }

  hotzones = spawnStruct();
  hotzones.blacksites = [];
  hotzones.strongholds = [];

  if(lootzones.size <= 0) {
    println("<dev string:x410>");
    return;
  }

  var_a56e56094f484add = [];

  foreach(lootzone in lootzones) {
    if(issubstr(lootzone, "<dev string:x458>")) {
      var_a56e56094f484add[var_a56e56094f484add.size] = lootzone;
    }
  }

  poinames = [];

  foreach(lootzone in var_a56e56094f484add) {
    [poi] = strtoksubstr(lootzone, "<dev string:x463>");

    if(isDefined(poi)) {
      if(!array_contains(poinames, poi)) {
        poinames[poinames.size] = poi;
      }

      if(array_contains(level.var_8b96eb6b6159e33b, lootzone)) {
        if(!isDefined(hotzones.blacksites[poi])) {
          hotzones.blacksites[poi] = [];
        }

        hotzones.blacksites[poi][hotzones.blacksites[poi].size] = lootzone;
        continue;
      }

      if(!isDefined(hotzones.strongholds[poi])) {
        hotzones.strongholds[poi] = [];
      }

      hotzones.strongholds[poi][hotzones.strongholds[poi].size] = lootzone;
    }
  }

  var_d83669c828e2321f = getDvar(@ "hash_5b99e4cd7a9e446", "<dev string:x468>");
  var_bd14353e6a3cf288 = openfile(var_d83669c828e2321f, "<dev string:x48e>");
  var_9b0694d51cc06f60 = "<dev string:x497>";
  var_9b0694d51cc06f60 += "<dev string:x4e5>";
  fprintln(var_bd14353e6a3cf288, var_9b0694d51cc06f60);
  var_9b0694d51cc06f60 = "<dev string:x4ff>";

  foreach(poi in poinames) {
    if(isDefined(hotzones.blacksites[poi]) && hotzones.blacksites[poi].size > 0) {
      var_9b0694d51cc06f60 += "<dev string:x503>";

      foreach(hotzone in hotzones.blacksites[poi]) {
        var_9b0694d51cc06f60 += function_a2d65f1e8991513f(hotzone, 1);
      }

      var_9b0694d51cc06f60 += "<dev string:x510>";
      fprintln(var_bd14353e6a3cf288, var_9b0694d51cc06f60);
      var_9b0694d51cc06f60 = "<dev string:x4ff>";
    }
  }

  var_9b0694d51cc06f60 += "<dev string:x510>";
  var_9b0694d51cc06f60 += "<dev string:x515>";
  fprintln(var_bd14353e6a3cf288, var_9b0694d51cc06f60);
  var_9b0694d51cc06f60 = "<dev string:x4ff>";

  foreach(poi in poinames) {
    if(isDefined(hotzones.strongholds[poi]) && hotzones.strongholds[poi].size > 0) {
      var_9b0694d51cc06f60 += "<dev string:x503>";

      foreach(hotzone in hotzones.strongholds[poi]) {
        var_9b0694d51cc06f60 += function_a2d65f1e8991513f(hotzone, 0);
      }

      var_9b0694d51cc06f60 += "<dev string:x510>";
      fprintln(var_bd14353e6a3cf288, var_9b0694d51cc06f60);
      var_9b0694d51cc06f60 = "<dev string:x4ff>";
    }
  }

  closefile(var_bd14353e6a3cf288);
}

function function_a2d65f1e8991513f(hotzonename, isblacksite) {
  var_b6f0e58e86c6362c = "<dev string:x52f>" + hotzonename + "<dev string:x538>";

  if(isblacksite) {
    var_b6f0e58e86c6362c += level.var_6ff106c0b1a35216 + "<dev string:x546>" + level.var_b058b2f92388e765 + "<dev string:x54b>";
  } else {
    var_b6f0e58e86c6362c += level.var_a26603334c1c6a92 + "<dev string:x546>" + level.var_9ae90712d17712c9 + "<dev string:x54b>";
  }

  return var_b6f0e58e86c6362c;
}

# /