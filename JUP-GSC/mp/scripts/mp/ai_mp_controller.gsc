/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\ai_mp_controller.gsc
***********************************************/

#using script_1174abedbefe9ada;
#using script_15ca41a3fbb0e379;
#using script_1c47017ba325709a;
#using script_24fbedba9a7a1ef4;
#using script_34874c98ab154f37;
#using script_41ba451876d0900c;
#using script_4948cdf739393d2d;
#using script_4a6760982b403bad;
#using script_53da3333b83b3527;
#using script_6153e980b3eb0e1b;
#using script_640cf1641c03e2a0;
#using scripts\anim\battlechatter;
#using scripts\anim\squadmanager;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_juggernaut;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\killstreaks\airstrike;
#using scripts\cp_mp\killstreaks\toma_strike;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\stealth\manager;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_heli_reinforce;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\gametypes\dmz_ai;
#using scripts\mp\gametypes\dmz_dog_tag;
#using scripts\mp\locksandkeys;
#using scripts\mp\loot;
#using scripts\mp\mp_agent;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\mp_dialogue;
#using scripts\mp\overseer;
#using scripts\mp\poi;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\script;
#using scripts\mp\utility\teams;
#using scripts\mp\weapons;
#using scripts\stealth\debug;
#using scripts\stealth\enemy;
#using scripts\stealth\utility;
#namespace ai_mp_controller;

function init() {
  if(istrue(level.supportsai)) {
    return;
  }

  level.supportsai = 1;
  level.var_bdb4d0cd41b1c39d = getdvarint(@ "hash_acf59b5e363165c0", scripts\cp_mp\utility\game_utility::isbrstylegametype());
  level.var_3a89274682239c28 = gettime();
  level.var_7318150d8dc474ea = -1;
  scripts\anim\battlechatter::init_battlechatter();
  scripts\mp\mp_dialogue::main();
  level.hiddenranges["prone"] = 1200;
  level.hiddenranges["crouch"] = 1800;
  level.hiddenranges["stand"] = 2400;
  level.spottedranges["prone"] = 2000;
  level.spottedranges["crouch"] = 3200;
  level.spottedranges["stand"] = 6000;
  level.var_8f3f480583606401["prone"] = 1.2;
  level.var_8f3f480583606401["crouch"] = 1.25;
  level.var_8f3f480583606401["stand"] = 1.3;
  level.var_33cf4079b4096eb8 = getdvarint(@ "hash_935057b8878ca60c", 1);
  level.var_1bdf3af6b78dc2ca = getdvarint(@ "hash_db81671bbb108b36", 2);
  level.var_8912ccad342445f7 = getdvarint(@ "hash_f34e4fbaeb441e24", 2048);
  level.gametypebundle = getgametypescriptbundle();
  level.agentmaxdamage = function_ee26a62ef3d1372d(@ "scr_agent_maxdamage", 45, level.gametypebundle.agentmaxdamage);
  level.var_6ba4985b66d62a71 = function_ee26a62ef3d1372d(@ "hash_7632dab7786bd590", 33, level.gametypebundle.var_23274688e75c2144);
  level.var_7eb56682f591ea8d = function_ee26a62ef3d1372d(@ "hash_81420364ea25c1ea", 80, level.gametypebundle.var_f0c2629e2aa93ace);
  level.var_9cf526926a72864c = function_ee26a62ef3d1372d(@ "hash_7ace3f07ae09faa9", 17, level.gametypebundle.var_12ed9627baf65e6d);
  level.var_e2fbc9e65108b1e = function_ee26a62ef3d1372d(@ "hash_a3642102f1c5f0af", 75, level.gametypebundle.var_799e41b0533da323);
  level.var_47aedb539717aea5 = function_ee26a62ef3d1372d(@ "hash_ccb7c4b155a770f8", 60, level.gametypebundle.var_870beb3e28d5013c);
  level.var_4899061e2e21dd13 = function_370c5539313daf66(@ "hash_b98593547931ba38", 0.6, level.gametypebundle.var_408bfdb7015c4ba3);
  level.var_3e6588e7a225a933 = getdvarint(@ "hash_9ad5dbdd1dfb3fac", 3);
  level.var_1b4461e4447da676 = 0;
  level.var_58ac9ebcf7b87b73 = 0;
  level.var_2ef1c744d35b6312 = getdvarint(@ "hash_bbb1bddaa8b9b5e3", 45);
  level.var_d362d0481275de02 = getdvarint(@ "hash_a28fc6fefeca8d04", 30) * 1000;
  level.var_ec80e35c609c1533 = getdvarint(@ "hash_8a59524527d46b22", 15);
  level.var_8a7245a12448052f = getdvarint(@ "hash_61a7de4b7ed90249", 35);
  level.var_a3a884994e83cdba = getdvarint(@ "hash_f7d2f280613a39d", 50);
  level.var_18c5fa4fdebe1971 = getdvarint(@ "hash_63dce1152bb58b16", 65);
  level.var_69173c5e957cccff = getdvarint(@ "hash_d3907cde9245b595", 1);
  level.var_ef668b618c1c7ec0 = getdvarint(@ "hash_fb2f8a1043ba19ae", 3);
  level.var_9c981303803aeab3 = getdvarint(@ "hash_c50d996d34978b41", 25);
  level.var_5dcccc815e25c8e2 = getdvarint(@ "hash_65c413f748899d7f", 10);
  level.var_96abdb45aee491fc = getdvarint(@ "hash_9a629aeb212fa5eb", 10);
  level.var_9d28d5b70aa9f5e4 = &function_9d28d5b70aa9f5e4;
  function_3bdeb9edd6c6f0a();
  reinforce_init();
  function_b04c0433e8107615();
  aibudget_init();
  function_9a7305ea8ee1e807();
  dialog_init();
  function_346dc7f701823dc();
  function_a09756b37f2e0681();
  function_1e3a27c2e002ca8();
  function_bd14655b29f9a64();
  function_a09c0a759d909dc9();
  level thread function_d2d3ddd52666dcf0();
  level thread function_44b2bad96489df87();
  function_75425e32a1700c73();

  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  if(getdvarint(@ "hash_98d02294a9885211", 0) > 0) {
    level thread function_63bc1945791044c9();
  }

  level thread function_576ed049f93d9496();
  level thread function_644e1e38d1b39a41();
  level thread function_5397fa12cf5b1665();
  level thread debug_categories();
  level thread function_e1c5cdebd8e4628a();

  level thread function_3ee960c1c0c8e4();

  registersharedfunc("ai_mp_controller", "agentPers_getAgentPersData", &agentpers_getagentpersdata);
  registersharedfunc("ai_mp_controller", "agentPers_setAgentPersData", &agentpers_setagentpersdata);
  registersharedfunc("ai_mp_controller", "subArea_removeAgentFrom", &subarea_removeagentfrom);
  registersharedfunc("ai_mp_controller", "ai_deregisterAgent", &function_1e5307c0d848a9ca);
  registersharedfunc("ai_mp_controller", "ai_registerAgent", &function_157c2000284999eb);
  registersharedfunc("ai_mp_controller", "priority_removeByDormancyId", &priority_removebydormancyid);
  registersharedfunc("ai_mp_controller", "priority_setByDormancyId", &priority_setbydormancyid);
  registersharedfunc("ai_mp_controller", "subArea_findAndAssignForDormancyID", &subarea_findandassignfordormancyid);
  registersharedfunc("ai_mp_controller", "processAgentSpawned", &processagentspawned);
  registersharedfunc("ai_mp_controller", "behavior_executeBehaviorPackage", &scripts\mp\ai_behavior::behavior_executebehaviorpackage);
  registersharedfunc("ai_mp_controller", "ai_mp_requestSpawnAgent", &ai_mp_requestspawnagent);
  registersharedfunc("ai_mp_controller", "handleDamageFeedback", &scripts\mp\damage::handledamagefeedback);
  function_2585b1944b7884c0();

  if(getdvarint(@ "hash_5a01142d62d08a10", 1) == 1) {
    function_401d0838f4f47c3e(1);
  }

  if(isDefined(level.var_1a6233bc0d61faf) && getdvarint(@ "hash_d1fa0a1f136eadfb", 0) == 1) {
    level thread function_b510c28e573d0be6();
  }

  level thread function_1efa739f9e55871f();
  level thread function_49d965cff987ed32();

  level thread function_bc423135571b28c1();
}

function function_35bae74232ff8b77(val) {
  assert(isDefined(val));
  level.var_bdb4d0cd41b1c39d = val;

  foreach(agent in level.agentarray) {
    if(isDefined(agent)) {
      agent.ignoreall = val;
    }
  }
}

function function_2b36368b8b1b2b30(val) {
  assert(isDefined(val));
  level.var_ed524ae7534d93e6 = val;
}

function function_3c44b8551d08ac1d() {
  level.var_ed524ae7534d93e6 = undefined;
}

function private function_3ee960c1c0c8e4() {
  while(!isDefined(level.stealth)) {
    waitframe();
  }

  setsaveddvar(@ "hash_ae9c969df88e37e1", 3000);
  setsaveddvar(@ "hash_f72ce39dd23b00d1", 3000);
  setsaveddvar(@ "hash_cda36d9770cf5189", 128);
  level.stealth.var_792e4b9a380ade11 = 3000;
  level.stealth.var_94f8771062f2161 = 3000;
  level.stealth.var_e2e3c78d7dc88605 = 16384;
  scripts\stealth\utility::set_detect_ranges(level.hiddenranges, level.spottedranges, level.var_8f3f480583606401);
}

function function_bd14655b29f9a64() {
  level.spawnset = [];
  level.var_3b54adcd8ed5b8c0 = [];
  level.var_c0e1de2e14e458bf = "guard";

  if(isDefined(level.gamemodebundle)) {
    if(isDefined(level.gamemodebundle.var_6924ab7bf88a3afe)) {
      level.var_bbc459244382ae0f = getDvar(@ "hash_63c67beb18bd058d", level.gamemodebundle.var_6924ab7bf88a3afe);
    }
  }

  if(!isDefined(level.var_bbc459244382ae0f)) {
    level.var_bbc459244382ae0f = getDvar(@ "hash_63c67beb18bd058d", "mp/spawnset_tuning_base.csv");
  }

  if(!tableexists(level.var_bbc459244382ae0f)) {
    println("<dev string:x1c>" + level.var_bbc459244382ae0f + "<dev string:x5f>");
    return;
  }

  table = level.var_bbc459244382ae0f;
  numrows = tablelookupgetnumrows(table);

  for(i = 0; istrue(i < numrows); i++) {
    var_fcdc7f62624c71ff = tolower(tablelookupbyrow(table, i, 0));

    if(!isDefined(level.spawnset[var_fcdc7f62624c71ff])) {
      level.spawnset[var_fcdc7f62624c71ff] = [];
    }

    aitype = tolower(tablelookupbyrow(table, i, 1));
    typechance = tablelookupbyrow(table, i, 2);

    if(typechance == "0") {
      continue;
    }

    if(isDefined(typechance)) {
      if(!isDefined(level.var_3b54adcd8ed5b8c0[var_fcdc7f62624c71ff])) {
        level.var_3b54adcd8ed5b8c0[var_fcdc7f62624c71ff] = [];
      }

      level.var_3b54adcd8ed5b8c0[var_fcdc7f62624c71ff][aitype] = int(typechance);
    }

    level.spawnset[var_fcdc7f62624c71ff][level.spawnset[var_fcdc7f62624c71ff].size] = aitype;
  }

  foreach(index, var_d562339438cec85c in level.var_3b54adcd8ed5b8c0) {
    var_bf63953d990800d2 = 0;

    foreach(chance in var_d562339438cec85c) {
      if(chance != 0) {
        var_bf63953d990800d2 = 1;
      }
    }

    if(!var_bf63953d990800d2) {
      level.var_3b54adcd8ed5b8c0[index] = undefined;
    }
  }
}

function isvalidboss(aitype) {
  if(isDefined(level.gamemodebundle.var_fe5571ec7d7bbfe6)) {
    if(!issubstr(aitype, "boss")) {
      return false;
    }

    if(issubstr(aitype, "jugg_minigun")) {
      return istrue(level.gamemodebundle.var_1a33770ee84f49e6);
    }

    if(issubstr(aitype, "jugg_grenade")) {
      return istrue(level.gamemodebundle.var_24831563e72cb3cb);
    }
  }

  return false;
}

function function_7f1a2e2ebe0c1693(basetype, tiernum, nationality) {
  if(!isDefined(basetype)) {
    basetype = "ar";
  }

  if(!isDefined(tiernum)) {
    tiernum = 1;
  }

  if(tiernum > 3) {
    tiernum = 3;
  } else if(tiernum < 1) {
    tiernum = 1;
  }

  if(!isDefined(nationality)) {
    nationality = function_f851a2f41cffa860();
  }

  if(basetype == "jugg") {
    return ("jup_enemy_mp_" + basetype + "_" + nationality);
  }

  return "jup_enemy_mp_" + basetype + "_tier" + tiernum + "_" + nationality;
}

function private function_1e3a27c2e002ca8() {
  level.agent_funcs["soldier"]["on_damaged"] = &namespace_daa149ca485fd50a::callbacksoldieragentdamaged;
  level.agent_funcs["soldier"]["gametype_on_killed"] = &scripts\mp\mp_agent_damage::callbacksoldieragentgametypekilled;
  level.agent_funcs["juggernaut"]["on_damaged"] = &scripts\cp_mp\agents\agent_juggernaut::function_1ab798a528080db2;
  level.agent_funcs["juggernaut"]["gametype_on_killed"] = &scripts\mp\mp_agent_damage::callbacksoldieragentgametypekilled;
  level.agent_funcs["zombie"]["on_damaged"] = &namespace_daa149ca485fd50a::callbacksoldieragentdamaged;
  level.agent_funcs["zombie"]["gametype_on_killed"] = &scripts\mp\mp_agent_damage::callbacksoldieragentgametypekilled;
}

function ai_mp_requestspawnagent(agenttype, groundspawnorigin, spawnangles, priority, category, subcategory, groupname, team, destination, poiname, skipstealth, var_5a6a87fa3f95753f, var_5f0c541b305bf851, var_80f4bde7090a4773, forcedormant, subarea, threatbiasgroup) {
  if(!istrue(level.supportsai)) {
    return;
  }

  assert(isDefined(agenttype) && isDefined(groundspawnorigin) && isDefined(priority) && isDefined(category), "<dev string:x71>");

  if(isDefined(poiname) && scripts\mp\poi::poi_issystemactive()) {
    assert(scripts\mp\poi::poi_ispoiactive(poiname), "<dev string:xc7>" + poiname + "<dev string:xf3>");
  }

  if(!isDefined(category)) {
    category = "unassigned";
  }

  if(!isDefined(subcategory)) {
    subcategory = "unassigned";
  }

  if(!isDefined(team)) {
    team = scripts\cp_mp\agents\agent_utils::function_30a0d7ca3fae40cc(undefined, agenttype);
  }

  spawndormant = !istrue(var_5a6a87fa3f95753f) && istrue(level.var_fe093e9b2b6c3751) && (!isDefined(var_5f0c541b305bf851) || var_5f0c541b305bf851);

  if(spawndormant && !istrue(forcedormant)) {
    spawndormant = !scripts\mp\flags::gameflagexists("prematch_done") || scripts\mp\flags::gameflagexists("prematch_done") && !scripts\mp\flags::gameflag("prematch_done");
  }

  if(poi_issystemactive() && !isDefined(poiname)) {
    poiname = poi_findpoioriginisin(groundspawnorigin);
  }

  if(!isDefined(subarea)) {
    subarea = subarea_findfromorigin(groundspawnorigin, poiname);
  }

  var_644d90de7685f75 = function_8c6dbb64c8e1603c(1, category, groundspawnorigin, poiname, spawndormant, subarea);
  var_1848056a38b1cca8 = 0;

  if(isDefined(subarea) && !isDefined(subarea.var_f27d7498eb54dd99)) {
    subarea.var_f27d7498eb54dd99 = 0;
  }

  success = 0;

  if(!var_644d90de7685f75) {
    [success, var_c9cb5ceef8c11eea] = function_559886efcd7d1a19(priority, groundspawnorigin, spawndormant);

    if(!success) {
      return undefined;
    }

    if(isDefined(subarea)) {
      var_1848056a38b1cca8 = 1;
      subarea.var_f27d7498eb54dd99++;
    }

    if(!var_c9cb5ceef8c11eea) {
      waittillframeend();
    }
  } else if(isDefined(subarea)) {
    var_1848056a38b1cca8 = 1;
    subarea.var_f27d7498eb54dd99++;
  }

  if(istrue(level.var_45ca3cfb9dca4f97)) {
    level thread scripts\mp\utility\debug::drawsphere(groundspawnorigin, 128, 500, (0, 1, 0));
  }

  if(isDefined(level.var_e354254e70a6b849) && !isDefined(threatbiasgroup)) {
    nationality = function_b71d8f69e7f63ed(agenttype);

    if(isDefined(nationality) && isDefined(level.var_5d6209c724cfeac7) && isDefined(level.var_5d6209c724cfeac7[nationality])) {
      threatbiasgroup = level.var_5d6209c724cfeac7[nationality];
    } else {
      threatbiasgroup = "enemy";
    }
  }

  if(spawndormant) {
    level.var_53db9bacadef066d.var_d4053e1a1d2983ce++;
    dormancyid = function_e2fa9b378bbf03a6(agenttype, groundspawnorigin, spawnangles, priority, category, subcategory, groupname, team, destination, poiname, skipstealth, undefined, threatbiasgroup);
    processagentspawned(dormancyid, var_80f4bde7090a4773);
    subarea_findandassignfordormancyid(groundspawnorigin, poiname, destination, dormancyid);
    priority_setbydormancyid(dormancyid, priority);
    function_157c2000284999eb(dormancyid, category, subcategory, poiname);

    if(var_1848056a38b1cca8) {
      subarea.var_f27d7498eb54dd99--;
    }

    if(scripts\engine\utility::issharedfuncdefined("analytics", "agent_alloc")) {
      [[scripts\engine\utility::getsharedfunc("analytics", "agent_alloc")]](groundspawnorigin, agenttype);
    }

    return dormancyid;
  }

  if(level.var_3a89274682239c28 > gettime()) {
    level.var_3a89274682239c28 += level.frameduration;
    wait(level.var_3a89274682239c28 - gettime() - level.frameduration) / 1000;
  }

  if(issubstr(agenttype, "riot")) {
    skipstealth = 1;
  }

  agent = function_eea40a1b6180f90a(agenttype, groundspawnorigin, spawnangles, priority, category, subcategory, groupname, team, destination, poiname, skipstealth);

  if(!isDefined(agent)) {
    return undefined;
  }

  if(isDefined(threatbiasgroup)) {
    scripts\cp_mp\agents\agent_utils::function_58203c3739d2d0c6(agent, threatbiasgroup);
  }

  if(scripts\mp\gametypes\br_gametype_dmz::function_7a7aa3b5455f0412(poiname)) {
    agent scripts\stealth\enemy::bt_event_combat();
  }

  if(istrue(skipstealth)) {
    agent.script_groupname = groupname;
  }

  if(var_1848056a38b1cca8) {
    subarea.var_f27d7498eb54dd99--;
  }

  var_840a2eec4405f2f4 = isDefined(level.var_796e20f059a611d1) && [[level.var_796e20f059a611d1]]();

  if(scripts\engine\utility::issharedfuncdefined("analytics", "agent_spawn") && !var_840a2eec4405f2f4) {
    [[scripts\engine\utility::getsharedfunc("analytics", "agent_spawn")]](agent);
  }

  if(0 && category == "<dev string:x106>") {
    thread scripts\mp\utility\debug::drawsphere(groundspawnorigin, 64, 500, (0, 1, 0));
  }

  namespace_d1a9ca87d78d9813::function_9533653868e59fb6("<dev string:x111>", "<dev string:x120>" + priority, category + "<dev string:x12d>" + subcategory, undefined, undefined, undefined, poiname, groundspawnorigin);

  if(!var_644d90de7685f75 && getdvarint(@ "hash_bcbe3309344bb6d2", 0) == 1) {
    level thread draw_arrow_time(agent.origin + (0, 0, 250), agent.origin + (0, 0, 5000), (0, 1, 0), 120);
    print3d(agent.origin + (0, 0, 105), "<dev string:x132>", (0, 1, 0), 1, 0.6, 6000);
    print3d(agent.origin + (0, 0, 90), "<dev string:x151>" + priority, (0, 1, 0), 1, 0.4, 6000);
    print3d(agent.origin + (0, 0, 80), "<dev string:x15f>" + category, (0, 1, 0), 1, 0.4, 6000);
    print3d(agent.origin + (0, 0, 70), "<dev string:x16d>" + subcategory, (0, 1, 0), 1, 0.4, 6000);
    println("<dev string:x17e>" + priority + "<dev string:x1a6>" + category + "<dev string:x1b8>" + subcategory);
  }

  if(level.var_3a89274682239c28 <= gettime()) {
    level.var_3a89274682239c28 = gettime() + level.frameduration;
  }

  if(gettime() != level.var_7318150d8dc474ea) {
    println("<dev string:x1cd>");
  }

  level.var_7318150d8dc474ea = gettime();
  processagentspawned(agent, var_80f4bde7090a4773);
  scripts\cp_mp\agents\agent_utils::function_c26ef480e88413bf(agent, agenttype);

  if(isDefined(agent.grenadeweapon)) {
    agentpers_setagentpersdata(agent, "grenadeType", agent.grenadeweapon.basename);
  }

  if(isDefined(level.var_37dafe68077318f5)) {
    scaleddist = agent.var_57956d515cda7d03 * level.var_37dafe68077318f5;
    agent function_9215ce6fc83759b9(scaleddist);
  }

  agent.var_8e3405ac46c40e0f = 1;
  agent.var_d5e499e7fe2c490b = 1;
  agent.revive_bleedouttime = 12000;
  function_caf96a86ca85140f(agent);
  function_b893eeceef3ac7a(agent);
  agent.var_c8e1b804e2c8f23f = 1000;
  agent.disableescalation = 1;
  return agent;
}

function private function_eea40a1b6180f90a(agenttype, groundspawnorigin, spawnangles, priority, category, subcategory, groupname, team, destination, poiname, skipstealth) {
  if(!isDefined(groundspawnorigin)) {
    return;
  }

  var_94d391b4017fe505 = agenttype;

  if(!string_starts_with(agenttype, "actor_")) {
    var_94d391b4017fe505 = "actor_" + agenttype;
  }

  if(!isDefined(level.agent_definition[var_94d391b4017fe505])) {
    println("<dev string:x26d>" + agenttype + "<dev string:x29c>");
    return undefined;
  }

  agent = scripts\mp\mp_agent::spawnnewagentaitype(agenttype, groundspawnorigin, spawnangles, team);

  if(!isDefined(agent)) {
    return undefined;
  }

  agent.baseaccuracy = getdvarfloat(@ "hash_8aa5333ca3f377e5", 0.66);
  agent.accuracy = agent.baseaccuracy;

  if(agent.behaviortreeasset != "rusher") {
    agent.pathenemylookahead = 120;
    agent.pathenemyfightdist = 512;
    agent.maxsightdistsqrd = 64000000;
    agent.meleechargedistvsplayer = 50;
  }

  agent pushplayer(1);

  if(!getdvarint(@ "hash_cb7e65d3dff416a6", 0)) {
    agent setplayeradvanceduavdot(1);
  }

  if(poi_issystemactive()) {
    poiname = function_80dd9d6a6bf6bbc1(agent, poiname, destination);
    subarea_findandassignforagent(agent, poiname, destination);
  }

  function_e04dbe0bd8a25be7(agent, function_5cc0c507e92f7b47(poiname));
  agent initplayerscriptvariables(1);
  agent.var_599b158d152c358d = getdvarint(@ "hash_45a2b4489e57d085", 0);
  agent.category = category;
  agent.subcategory = subcategory;
  function_157c2000284999eb(agent, category, subcategory);
  priority_set(agent, priority);
  agent agentpers_setagentpersdata(agent, "weapon", agent.weapon);
  agent agentpers_setagentpersdata(agent, "agenttype", agenttype);
  overridehealth = gethealthmax(agenttype);

  if(isDefined(overridehealth) && overridehealth > 0) {
    agent scripts\mp\mp_agent::set_agent_health(overridehealth);
  }

  if(!istrue(level.var_b21aafd3e06b203d)) {
    agent thread function_7e69553f058c867b(agent);
  }

  if(!issubstr(agenttype, "civilian")) {
    if(!istrue(skipstealth)) {
      function_5d07b6ef455e7876(agent, groupname);
    } else {
      agent thread function_c1d2c66c8b74b50();
    }

    if(randomint(100) >= level.var_18c5fa4fdebe1971) {
      agent.disablesuppressingfire = 1;
    }

    function_1920867ddf76810c(agent, 0);
    agent thread scripts\anim\squadmanager::addtosquad();
    agent thread scripts\mp\weapons::watchgrenadeusage();

    if(scripts\engine\utility::issharedfuncdefined("ai", "dropLootOnAgentDeath")) {
      agent thread[[scripts\engine\utility::getsharedfunc("ai", "dropLootOnAgentDeath")]](agent, agenttype, groupname);
    }
  }

  agent thread function_7ee4a8954b638ed3(agent);
  agenttier = agentpers_getagentpersdata(agent, "tier");

  if(!isDefined(agenttier)) {
    agenttier = "undefined";
  }

  dlog_recordevent("dlog_event_dmz_ai_spawn", ["spawn_id", agent.var_8aa9efe6383c1d5a, "ai_pos_x", groundspawnorigin[0], "ai_pos_y", groundspawnorigin[1], "ai_pos_z", groundspawnorigin[2], "ai_type", agenttype, "ai_tier", agenttier, "ai_status", "unknown", "ai_category", category, "ai_subcat", subcategory, "priority", priority, "ai_weapon_primary", agent.primaryweapon.basename, "ai_weapon_secondary", agent.secondaryweapon.basename, "ai_weapon_grenade", agent.grenadeweapon.basename, "match_time_elapsed", gettime()]);
  return agent;
}

function function_d5bc07eabf352abb(node, poiname, var_fcdc7f62624c71ff, basetype, tier, nationality) {
  if(!isDefined(tier)) {
    tier = function_8af522ada68b6477(node, poiname);
  }

  if(!isDefined(nationality)) {
    nationality = function_7722db2014c7dfbd(node, poiname);
  }

  if(!isDefined(basetype)) {
    if(!isDefined(node) || !isDefined(node.script_noteworthy)) {
      basetype = function_ed108ff3eb578327(var_fcdc7f62624c71ff, tier);
    } else {
      basetype = function_ca51dd295e82f280(node, tier);
    }
  }

  [basetype, tier] = function_bd5c9a8459875e7a(basetype, tier);
  aitype = function_7f1a2e2ebe0c1693(basetype, tier, nationality);
  var_94d391b4017fe505 = aitype;

  if(!string_starts_with(aitype, "actor_")) {
    var_94d391b4017fe505 = "actor_" + aitype;
  }

  if(!isDefined(level.agent_definition[var_94d391b4017fe505])) {
    basetype = function_ed108ff3eb578327("medium_range", tier);
    aitype = function_7f1a2e2ebe0c1693(basetype, tier, nationality);
  }

  return aitype;
}

function function_ca51dd295e82f280(node, tier) {
  if(!isDefined(node.script_noteworthy)) {
    return function_ed108ff3eb578327(undefined, tier);
  }

  tokens = strtok(tolower(node.script_noteworthy), "_");

  if(tokens.size == 1 || tokens.size == 2 && tokens[1] == "stationary") {
    return function_ed108ff3eb578327(undefined, tier);
  } else if(tolower(tokens[0]) == "spawnset" || tolower(tokens[1]) == "spawnset") {
    var_fcdc7f62624c71ff = function_f213e61932acbb15(node);
    return function_ed108ff3eb578327(var_fcdc7f62624c71ff, tier);
  } else if(tokens.size >= 3 && tokens[1] == "stationary") {
    if(tolower(tokens[2]) == "spawnset") {
      var_fcdc7f62624c71ff = function_f213e61932acbb15(node);
      return function_ed108ff3eb578327(var_fcdc7f62624c71ff, tier);
    } else {
      return tokens[2];
    }
  }

  return tokens[1];
}

function function_bd5c9a8459875e7a(type, tier) {
  if(!isDefined(type) || !isDefined(tier)) {
    return [type, tier];
  }

  if(type == "firebug" && tier != 1) {
    return ["firebug", 1];
  }

  if(type == "strikeunit" && tier != 3) {
    return ["ar", 1];
  }

  return [type, tier];
}

function function_f213e61932acbb15(node) {
  if(!isDefined(node.script_noteworthy)) {
    return;
  }

  tokens = strtok(node.script_noteworthy, "_");
  stringstart = 15;

  if(tokens[0] == "spawnset") {
    stringstart = 9;
  } else if(tokens[1] == "stationary") {
    stringstart = 26;
  }

  return getsubstr(node.script_noteworthy, stringstart, node.script_noteworthy.size);
}

function function_8af522ada68b6477(node, poiname, origin) {
  if(isDefined(node)) {
    if(is_equal(node.poi, level.recalculatepoi)) {
      poiname = scripts\mp\poi::poi_findpoioriginisin(node.origin);
      node.poi = poiname;
    }

    if(istrue(level.var_7a36d824da6087ef)) {
      if(!isDefined(poiname)) {
        poiname = scripts\mp\poi::poi_findpoioriginisin(node.origin);
      }

      tieroverride = tieroverride_checkorigin(node.origin, poiname);

      if(isDefined(tieroverride)) {
        return tieroverride;
      }
    }

    if(!isDefined(node.agent_type) || isDefined(node.agent_type) && !issubstr(tolower(node.agent_type), "toptier") && !issubstr(tolower(node.agent_type), "elite")) {
      return 1;
    }

    if(!isDefined(node.var_71ad22c5d093d90b)) {
      var_3a6b42ab825a103e = ter_op(isDefined(origin), origin, node.origin);
      subarea = subarea_findfromorigin(var_3a6b42ab825a103e, poiname);
      node.var_71ad22c5d093d90b = subarea.var_71ad22c5d093d90b;

      if(!isDefined(poiname) && !isDefined(node.poi)) {
        poiname = subarea.poi;
      }
    }

    if(isDefined(node.var_71ad22c5d093d90b)) {
      var_99461dbf0e248572 = ter_op(isDefined(node.poi), node.poi, poiname);

      if(isDefined(var_99461dbf0e248572) && isDefined(node.var_71ad22c5d093d90b)) {
        tier = level.poi[var_99461dbf0e248572]["subAreas"][node.var_71ad22c5d093d90b].var_7da9883d4168b7f1.var_84ecaeab58167d39;
      } else {
        return 1;
      }
    } else {
      return 1;
    }

    if(!isDefined(tier) || tier != 1 && tier != 2 && tier != 3) {
      tier = 1;
    }

    return tier;
  }

  if(!isDefined(poiname)) {
    if(!isDefined(origin)) {
      println("<dev string:x2b4>");
      return 1;
    }

    poiname = poi_findpoioriginisin(origin);
  }

  if(isDefined(poiname)) {
    if(istrue(level.var_7a36d824da6087ef)) {
      tieroverride = tieroverride_checkorigin(origin, poiname);

      if(isDefined(tieroverride)) {
        return tieroverride;
      }
    }

    tier = function_aa34a142b7664dd1(function_5cc0c507e92f7b47(poiname));

    if(tier != 1 && tier != 2 && tier != 3) {
      tier = 1;
    }

    return tier;
  }

  return 1;
}

function function_aa34a142b7664dd1(starlevel) {
  switch (starlevel) {
    case 0:
    case 1:
      return 1;
    case 2:
    case 3:
      return 2;
    case 4:
      return 3;
  }

  return 1;
}

function function_7722db2014c7dfbd(node, poiname) {
  if(isDefined(node)) {
    if(isDefined(node.nationality)) {
      return node.nationality;
    }

    if(!isDefined(poiname)) {
      if(isDefined(node.poi)) {
        poiname = node.poi;
      } else {
        poiname = poi_findpoioriginisin(node.origin);
      }
    }

    if(!isDefined(node.var_71ad22c5d093d90b)) {
      node.var_71ad22c5d093d90b = subarea_findfromorigin(node.origin, poiname).var_71ad22c5d093d90b;
    }

    if(isDefined(node.var_71ad22c5d093d90b)) {
      if(isDefined(level.poi[poiname]["subAreas"][node.var_71ad22c5d093d90b]) && isDefined(level.poi[poiname]["subAreas"][node.var_71ad22c5d093d90b].var_7da9883d4168b7f1)) {
        return level.poi[poiname]["subAreas"][node.var_71ad22c5d093d90b].var_7da9883d4168b7f1.nationalityoverride;
      }

      return function_f851a2f41cffa860();
    }
  }
}

function function_b71d8f69e7f63ed(agenttype) {
  if(issubstr(agenttype, "_aq")) {
    return "aq";
  }

  if(issubstr(agenttype, "_cartel")) {
    return "cartel";
  }

  if(issubstr(agenttype, "_merc")) {
    return "merc";
  }

  if(issubstr(agenttype, "_ru")) {
    return "ru";
  }
}

function function_cb53e3abd2b63e1d(spawnset, tier) {
  var_6186300af3be06d6 = [];
  var_80bf10a2ded77927 = [];

  foreach(tierkey, tiertypes in level.var_c7796321c3d97413) {
    if(tierkey == tier) {
      continue;
    }

    var_80bf10a2ded77927 = array_combine(var_80bf10a2ded77927, tiertypes);
  }

  foreach(aitype in spawnset) {
    if(!array_contains(var_80bf10a2ded77927, aitype)) {
      var_6186300af3be06d6[var_6186300af3be06d6.size] = aitype;
    }
  }

  return var_6186300af3be06d6;
}

function function_ed108ff3eb578327(var_fcdc7f62624c71ff, tier) {
  if(!isDefined(var_fcdc7f62624c71ff) || !isDefined(level.spawnset[var_fcdc7f62624c71ff])) {
    var_fcdc7f62624c71ff = level.var_c0e1de2e14e458bf;
  }

  spawnset = level.spawnset[var_fcdc7f62624c71ff];

  if(isDefined(tier)) {
    spawnset = function_cb53e3abd2b63e1d(spawnset, tier);
  }

  if(isDefined(level.var_3b54adcd8ed5b8c0[var_fcdc7f62624c71ff])) {
    var_50f2ee11200531a9 = [];

    foreach(index, itemtickets in level.var_3b54adcd8ed5b8c0[var_fcdc7f62624c71ff]) {
      if(array_contains(spawnset, index)) {
        var_50f2ee11200531a9[index] = itemtickets;
      }
    }

    totaltickets = 0;

    foreach(index, itemtickets in var_50f2ee11200531a9) {
      totaltickets += itemtickets;
    }

    roll = randomint(totaltickets);
    chancetotal = 0;

    foreach(index, itemtickets in var_50f2ee11200531a9) {
      chancetotal += itemtickets;

      if(roll <= chancetotal) {
        return index;
      }
    }
  }

  return spawnset[randomint(spawnset.size)];
}

function function_59cdfe39e161a336(node) {
  stealth_group = getDvar(@ "hash_a839371d8b7bad64", "<dev string:x313>");

  if(stealth_group != "<dev string:x313>") {
    return stealth_group;
  }

  if(istrue(level.var_6827e5668ebc95c0) && isDefined(node.script_stealthgroup)) {
    return node.script_stealthgroup;
  }

  return undefined;
}

function function_6d1e55c48e2c12f() {
  return function_ed108ff3eb578327("guard");
}

function function_f851a2f41cffa860() {
  if(isDefined(level.var_75041b516b3785c6)) {
    return level.var_75041b516b3785c6;
  }

  return "rus";
}

function function_346dc7f701823dc(nationalityid) {
  if(!isDefined(nationalityid)) {
    if(issubstr(level.mapname, "cruce")) {
      nationalityid = "mx";
    } else if(issubstr(level.mapname, "saba")) {
      nationalityid = "aq";
    } else if(issubstr(level.mapname, "bio_lab")) {
      nationalityid = "biolab";
    } else if(issubstr(level.mapname, "delta")) {
      nationalityid = "rus";
    } else if(issubstr(level.mapname, "sealion")) {
      nationalityid = "merc";
    } else if(issubstr(level.mapname, "escape5_hell") || issubstr(level.mapname, "br_wb_fun_modes")) {
      nationalityid = "pmc";
    } else {
      nationalityid = "rus";
    }
  }

  level.var_75041b516b3785c6 = nationalityid;
}

function function_559886efcd7d1a19(priority, requestedspawnorigin, spawndormant) {
  [success, var_c9cb5ceef8c11eea] = function_56e8fd646957529c(priority, 0, requestedspawnorigin, spawndormant);

  if(!success) {
    [success, var_c9cb5ceef8c11eea] = function_56e8fd646957529c(priority, 1, requestedspawnorigin, spawndormant);
  }

  return [success, var_c9cb5ceef8c11eea];
}

function private function_56e8fd646957529c(priority, ruthless, requestedspawnorigin, spawndormant) {
  numchecked = 0;
  priorityint = array_find(level.var_41670c1c65f3d3cf.priorities, priority);
  assert(isDefined(priorityint), "<dev string:x317>");
  var_2231df82d7283c43 = 0;
  subarea = subarea_findfromorigin(requestedspawnorigin);

  if(isDefined(subarea)) {
    var_ef017ff00ebc23ce = ter_op(isDefined(subarea.var_f27d7498eb54dd99), subarea.var_f27d7498eb54dd99, 0);
  } else {
    var_ef017ff00ebc23ce = 0;
  }

  if(isDefined(subarea) && isDefined(subarea.var_7da9883d4168b7f1) && isDefined(subarea.var_7da9883d4168b7f1.var_63e6c2f5f608f74e) && isarray(subarea.var_3ebb6024e3f220ca) && subarea.var_3ebb6024e3f220ca.size + 1 + var_ef017ff00ebc23ce <= subarea.var_7da9883d4168b7f1.var_63e6c2f5f608f74e) {
    var_2231df82d7283c43 = 1;
  }

  foreach(testpriority in level.var_41670c1c65f3d3cf.var_1d7de2571d2c82a7) {
    if(array_find(level.var_41670c1c65f3d3cf.priorities, testpriority) <= priorityint) {
      break;
    }

    agentlist = [];

    if(!istrue(spawndormant)) {
      if(isDefined(subarea) && !var_2231df82d7283c43) {
        var_27d81dc45e0b6d94 = [];

        foreach(agent in subarea.var_3ebb6024e3f220ca) {
          if(isagent(agent)) {
            agentpriority = agentpers_getagentpersdata(agent, "priority");

            if(array_find(level.var_41670c1c65f3d3cf.priorities, agentpriority) <= priorityint) {
              continue;
            }

            agentlist[agentlist.size] = agent;
            continue;
          }

          if(isint(agent)) {
            agentpriority = scripts\cp_mp\agents\agent_utils::function_2b0e82156fa6075b(agent).priority;

            if(agentpriority <= priorityint) {
              continue;
            }

            var_27d81dc45e0b6d94[var_27d81dc45e0b6d94.size] = agent;
          }
        }

        agentlist = array_combine(agentlist, var_27d81dc45e0b6d94);

        if(agentlist.size == 0) {
          return [0, undefined];
        }
      } else {
        agentlist = array_randomize(function_44c0059e33f55f00(testpriority));

        if(isDefined(subarea)) {
          agentlist = subarea_orderagentarraysubareafirst(subarea, agentlist);
        }
      }
    } else if(isDefined(subarea) && !var_2231df82d7283c43) {
      foreach(agent in subarea.var_3ebb6024e3f220ca) {
        if(isint(agent)) {
          agentpriority = scripts\cp_mp\agents\agent_utils::function_2b0e82156fa6075b(agent).priority;

          if(agentpriority <= priorityint) {
            continue;
          }

          agentlist[agentlist.size] = agent;
        }
      }

      if(agentlist.size == 0) {
        return [0, undefined];
      }
    } else {
      agentlist = array_randomize(function_72ae84d7068be83f(testpriority));

      if(isDefined(subarea)) {
        agentlist = subarea_orderagentarraysubareafirst(subarea, agentlist);
      }
    }

    foreach(agent in agentlist) {
      if(!isagent(agent)) {
        if(isDefined(subarea) && !var_2231df82d7283c43 && !spawndormant && function_e8c0ac958d093ec2() + 1 == function_3813364e2323b789()) {
          var_6ec0829abbd65125 = function_67224249ba9c2e2e(testpriority, 1, requestedspawnorigin, subarea);

          if(!var_6ec0829abbd65125) {
            return [0, undefined];
          }
        }

        function_4e065f1747aadd51(agent);
        return [1, 1];
      } else if(agent function_f31bfd56e7806afb(ruthless)) {
        agent function_28b90eb2b591003f();
        return [1, 0];
      }

      numchecked++;

      if(numchecked % 30 == 0) {
        waitframe();
      }
    }
  }

  return [0, undefined];
}

function function_67224249ba9c2e2e(priority, ruthless, requestedspawnorigin, subarea) {
  numchecked = 0;
  priorityint = array_find(level.var_41670c1c65f3d3cf.priorities, priority);
  assert(isDefined(priorityint), "<dev string:x341>");

  if(!isDefined(subarea)) {
    subarea = subarea_findfromorigin(requestedspawnorigin);
  }

  foreach(testpriority in level.var_41670c1c65f3d3cf.var_1d7de2571d2c82a7) {
    if(array_find(level.var_41670c1c65f3d3cf.priorities, testpriority) <= priorityint) {
      break;
    }

    agentlist = array_randomize(function_44c0059e33f55f00(testpriority));
    agentlist = subarea_orderagentarraysubareafirst(subarea, agentlist);

    foreach(agent in agentlist) {
      if(agent function_f31bfd56e7806afb(ruthless)) {
        if(istrue(level.var_45ca3cfb9dca4f97)) {
          level thread scripts\mp\utility\debug::drawsphere(agent.origin, 64, 500, (1, 0, 0));
        }

        agent function_28b90eb2b591003f();
        return true;
      }

      numchecked++;

      if(numchecked % 30 == 0) {
        waitframe();
      }
    }
  }

  return false;
}

function function_28b90eb2b591003f() {
  namespace_d1a9ca87d78d9813::function_9533653868e59fb6("<dev string:x37f>", "<dev string:x120>" + priority_get(self), self.category + "<dev string:x12d>" + self.subcategory, undefined, undefined, undefined, agentpers_getagentpersdata(self, "<dev string:x38d>"), self.origin);

  if(getdvarint(@ "hash_bcbe3309344bb6d2", 0) == 1) {
    level thread draw_arrow_time(self.origin + (0, 0, 250), self.origin + (0, 0, 5000), (1, 0, 0), 120);
    print3d(self.origin + (0, 0, 105), "<dev string:x398>", (1, 0, 0), 1, 0.6, 6000);
    print3d(self.origin + (0, 0, 90), "<dev string:x151>" + priority_get(self), (1, 0, 0), 1, 0.4, 6000);
    print3d(self.origin + (0, 0, 80), "<dev string:x15f>" + self.category, (1, 0, 0), 1, 0.4, 6000);
    print3d(self.origin + (0, 0, 70), "<dev string:x16d>" + self.subcategory, (1, 0, 0), 1, 0.4, 6000);
    iprintlnbold("<dev string:x3ad>" + priority_get(self) + "<dev string:x1a6>" + self.category + "<dev string:x1b8>" + self.subcategory);
  }

  agentpers_setagentpersdata(self, "skipDeathCount", 1);
  self.nocorpse = 1;
  self kill();
}

function private function_f31bfd56e7806afb(ruthless) {
  if(!isalive(self)) {
    return false;
  }

  if(self.health < 1) {
    return false;
  }

  if(istrue(self.dontkilloff)) {
    return false;
  }

  if(istrue(self.playing_skit)) {
    return false;
  }

  if(is_specified_unittype("juggernaut")) {
    return false;
  }

  if(is_riding_vehicle()) {
    return false;
  }

  if(!istrue(ruthless)) {
    if(isDefined(self.enemy) && self canshootenemy()) {
      return false;
    }
  }

  if(isDefined(self.birthtime) && self.birthtime >= gettime()) {
    return false;
  }

  if(istrue(ruthless)) {
    return true;
  }

  var_934f2bd9f0e5c04b = get_see_recently_time_overrides();

  if(isDefined(self.group) && istrue(self.group.cqb_module)) {
    var_99189c9718781c5d = 1000000;
  } else {
    var_99189c9718781c5d = 4000000;
  }

  for(i = 0; i < level.players.size; i++) {
    eplayer = level.players[i];

    if(distancesquared(eplayer.origin, self.origin) < var_99189c9718781c5d) {
      return false;
    }

    if(self seerecently(eplayer, var_934f2bd9f0e5c04b)) {
      return false;
    }
  }

  return true;
}

function get_see_recently_time_overrides() {
  if(isDefined(self.see_recently_override)) {
    return self.see_recently_override;
  }

  if(isDefined(self.group)) {
    if(isDefined(self.group.last_seen_time_override)) {
      return self.group.last_seen_time_override;
    } else if(istrue(self.group.cqb_module)) {
      return 2;
    } else {
      return 6;
    }

    return;
  }

  return 6;
}

function is_riding_vehicle() {
  return isDefined(self.ridingvehicle);
}

function function_93add0b65db9f722(function, context) {
  if(!isDefined(level.var_da2aad7af92ce2d0)) {
    level.var_da2aad7af92ce2d0 = [];
  }

  if(!isDefined(context)) {
    context = self;
  }

  info = spawnStruct();
  info.function = function;
  info.context = context;
  level.var_da2aad7af92ce2d0[level.var_da2aad7af92ce2d0.size] = info;
}

function function_66a6064fad612bf3(function, context) {
  if(!isDefined(context)) {
    context = self;
  }

  if(isDefined(level.var_da2aad7af92ce2d0)) {
    for(index = 0; index < level.var_da2aad7af92ce2d0.size; index++) {
      if(isDefined(level.var_da2aad7af92ce2d0[index]) && level.var_da2aad7af92ce2d0[index].function == function && level.var_da2aad7af92ce2d0[index].context == context) {
        level.var_da2aad7af92ce2d0[index] = undefined;
      }
    }
  }
}

function function_be9c6fbd4dc69254(agent, killer) {
  if(isDefined(level.var_da2aad7af92ce2d0)) {
    foreach(info in level.var_da2aad7af92ce2d0) {
      info.context thread[[info.function]](agent, killer);
    }
  }
}

function function_49d965cff987ed32() {
  while(true) {
    waitframe();

    if(getdvarint(@ "hash_d054932c3f2f177b", 0) != 0) {
      tier = getdvarint(@ "hash_d054932c3f2f177b", 0);
      aitype = function_7f1a2e2ebe0c1693("<dev string:x3c7>", tier);
      agent = ai_mp_requestspawnagent(aitype, level.players[0].origin, (0, 0, 0), "<dev string:x3cd>", "<dev string:x3d9>", "<dev string:x3e3>", undefined, undefined, undefined, undefined, 0, 0, 0);
      overridetier3(agent);
      setDvar(@ "hash_d054932c3f2f177b", 0);
    }
  }
}

function function_d2d3ddd52666dcf0() {
  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  function_7b8a64e4ec045a1b();
  brgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype() || brgametype == "dmz" || brgametype == "exgm" || getdvarint(@ "hash_61829d18989706cf", 1) == 0) {
    function_ae8293438b86ca23();
    function_b0bb893f94e993b4();
    function_1d0b1e527bd1bd48();
  }

  function_bebc5768175d5170();
  function_1353821e73926c69();
  level.var_f79746dab56dca8c = getStructArray("para_landingSpot", "script_noteworthy");
}

function function_7b8a64e4ec045a1b() {
  if(!poi_issystemactive()) {
    return;
  }

  temptriggers = [];

  foreach(poiname, poi in level.poi) {
    if(isDefined(poi) && isDefined(poi["subAreas"])) {
      foreach(subarea in poi["subAreas"]) {
        if(isDefined(level.var_7da9883d4168b7f1[poiname]) && isDefined(level.var_7da9883d4168b7f1[poiname][subarea.var_71ad22c5d093d90b])) {
          subarea.var_7da9883d4168b7f1 = level.var_7da9883d4168b7f1[poiname][subarea.var_71ad22c5d093d90b];
        }
      }
    }
  }

  level.var_7da9883d4168b7f1 = undefined;
}

function function_ae8293438b86ca23() {
  var_c034726a93bbff6e = getStructArray("spawnPackage_mainNode", "script_noteworthy");

  foreach(spawnpackagemainnode in var_c034726a93bbff6e) {
    if(!isDefined(spawnpackagemainnode.target)) {
      continue;
    }

    if(poi_issystemactive()) {
      if(!isDefined(spawnpackagemainnode.poi)) {
        spawnpackagemainnode.poi = poi_findpoioriginisin(spawnpackagemainnode.origin);
      }

      if(!poi_ispoiactive(spawnpackagemainnode.poi) && !istrue(level.var_4cfd75aa6ddde156)) {
        continue;
      }
    }

    spawnpackage = spawnStruct();
    spawnpackage.origin = spawnpackagemainnode.origin;
    spawnpackage.guardnodes = [];
    spawnpackage.pathstructs = [];
    spawnpackage.civnodes = [];
    poiname = undefined;
    subarea = undefined;

    if(poi_issystemactive()) {
      poiname = spawnpackagemainnode.poi;
      subarea = subarea_findfromorigin(spawnpackagemainnode.origin, spawnpackagemainnode.poi);
    }

    if(!isDefined(subarea)) {
      if(isDefined(spawnpackagemainnode.poi)) {
        println("<dev string:x3f1>" + spawnpackagemainnode.poi + "<dev string:x46f>");
        return;
      }

      println("<dev string:x482>");

      return;
    } else {
      spawnpackage.var_71ad22c5d093d90b = subarea.var_71ad22c5d093d90b;
      spawnpackage.poi = poiname;
      spawnpackage.nationality = spawnpackagemainnode.nationality;
    }

    connectednodes = getStructArray(spawnpackagemainnode.target, "targetname");

    foreach(node in connectednodes) {
      if(isDefined(node.script_noteworthy)) {
        script_noteworthy = tolower(node.script_noteworthy);
        node.var_71ad22c5d093d90b = spawnpackage.var_71ad22c5d093d90b;
        node.poi = poiname;

        if(issubstr(script_noteworthy, "guard")) {
          spawnpackage.guardnodes[spawnpackage.guardnodes.size] = node;
        } else if(issubstr(script_noteworthy, "patrolstart") || issubstr(script_noteworthy, "patrolpath")) {
          pathstruct = function_9edcf99159abb0b(node, issubstr(script_noteworthy, "looped"));
          spawnpackage.pathstructs[spawnpackage.pathstructs.size] = pathstruct;
        }

        if(issubstr(script_noteworthy, "civ")) {
          spawnpackage.civnodes[spawnpackage.civnodes.size] = node;
        }
      }
    }

    if(isDefined(spawnpackagemainnode.required) && spawnpackagemainnode.required == "1") {
      subarea.var_d276b08c96430bfc[subarea.var_d276b08c96430bfc.size] = spawnpackage;
      continue;
    }

    subarea.var_24a2cd19eed8f75d[subarea.var_24a2cd19eed8f75d.size] = spawnpackage;
  }
}

function function_1d0b1e527bd1bd48() {
  var_c9e457777ce86549 = getStructArray("roofPackage_mainNode", "script_noteworthy");

  foreach(roofpackagemainnode in var_c9e457777ce86549) {
    if(!isDefined(roofpackagemainnode.target)) {
      continue;
    }

    subarea = undefined;

    if(poi_issystemactive()) {
      if(!isDefined(roofpackagemainnode.poi)) {
        roofpackagemainnode.poi = poi_findpoioriginisin(roofpackagemainnode.origin);
      }

      if(!poi_ispoiactive(roofpackagemainnode.poi) && !istrue(level.var_4cfd75aa6ddde156)) {
        continue;
      }

      subarea = subarea_findfromorigin(roofpackagemainnode.origin, roofpackagemainnode.poi);
    }

    if(!isDefined(subarea)) {
      continue;
    }

    subarea.var_78b67865ef2a33d3 = getStructArray(roofpackagemainnode.target, "targetname");
  }
}

function function_b0bb893f94e993b4() {
  var_89028783941c2cb5 = getStructArray("patrolPackage_mainNode", "script_noteworthy");

  foreach(patrolpackagemainnode in var_89028783941c2cb5) {
    if(!isDefined(patrolpackagemainnode.target)) {
      continue;
    }

    subarea = undefined;

    if(poi_issystemactive()) {
      if(!isDefined(patrolpackagemainnode.poi)) {
        patrolpackagemainnode.poi = poi_findpoioriginisin(patrolpackagemainnode.origin);
      }

      if(!poi_ispoiactive(patrolpackagemainnode.poi) && !istrue(level.var_4cfd75aa6ddde156)) {
        continue;
      }

      subarea = subarea_findfromorigin(patrolpackagemainnode.origin, patrolpackagemainnode.poi);
    }

    if(!isDefined(subarea)) {
      continue;
    }

    subarea.var_2976480563de74df = getStructArray(patrolpackagemainnode.target, "targetname");
  }
}

function function_f41c155e991af4f9() {
  var_3ebbac089a29e000 = getStructArray("skit_mainNode", "script_noteworthy");

  foreach(skitmainnode in var_3ebbac089a29e000) {
    skit = spawnStruct();
    skit.origin = skitmainnode.origin;
    skit.guardnodes = [];
    skit.pathstructs = [];
    skit.civnodes = [];
    connectednodes = getStructArray(skitmainnode.target, "targetname");

    foreach(node in connectednodes) {
      if(isDefined(node.script_noteworthy)) {
        script_noteworthy = tolower(node.script_noteworthy);

        if(issubstr(script_noteworthy, "guard")) {
          skit.guardnodes[skit.guardnodes.size] = node;
          continue;
        }

        if(script_noteworthy == "patrolstart" || issubstr(script_noteworthy, "patrolpath")) {
          pathstruct = function_9edcf99159abb0b(node, issubstr(script_noteworthy, "looped"));
          skit.pathstructs[skit.pathstructs.size] = pathstruct;
          continue;
        }

        if(issubstr(script_noteworthy, "civilian")) {
          skit.civnodes[skit.civnodes.size] = node;
        }
      }
    }

    if(poi_issystemactive()) {
      poiname = skitmainnode.poi;
      subarea = subarea_findfromorigin(skitmainnode.origin, poiname);
    } else {
      subarea = subarea_findfromorigin(skitmainnode.origin);
    }

    subarea.skits[subarea.skits.size] = skit;
  }
}

function function_bebc5768175d5170() {
  level.patrolpaths = [];

  if(poi_issystemactive()) {
    function_44739fe1cf82e29a("patrolPaths");
  }

  patrolnodes = getStructArray("patrolPath_Fortress", "script_noteworthy");
  patrolnodes = array_combine(patrolnodes, getStructArray("patrolStart", "script_noteworthy"));

  foreach(node in patrolnodes) {
    pathstruct = function_9edcf99159abb0b(node);

    if(isDefined(pathstruct)) {
      pathstruct.origin = node.origin;
      level.patrolpaths[level.patrolpaths.size] = pathstruct;

      if(poi_issystemactive()) {
        poiname = node.poi;

        if(!isDefined(node.poi)) {
          poiname = poi_findpoioriginisin(node.origin);
        }

        function_d0e7647e5538eb9d(poiname, "patrolPaths", pathstruct);
      }
    }
  }

  if(poi_issystemactive()) {
    level thread function_7132401e09a9ccc7();
  }
}

function function_7132401e09a9ccc7() {
  if(scripts\engine\utility::issharedfuncdefined("fortress", "spawn")) {
    level waittill("infils_ready");
    level.patrolpaths = undefined;
    return;
  }

  while(!scripts\mp\flags::gameflagexists("prematch_done") || scripts\mp\flags::gameflagexists("prematch_done") && !scripts\mp\flags::gameflag("prematch_done")) {
    waitframe();
  }

  level.patrolpaths = undefined;
}

function function_9edcf99159abb0b(node, forcelooped) {
  path = [];
  index = 0;
  path[index] = node;
  var_4437e81f60b6b5a0 = 0;

  if(!isDefined(path[index].target)) {
    return;
  }

  nextnode = getStruct(path[index].target, "targetname");

  if(!isDefined(nextnode)) {
    return;
  }

  while(true) {
    if(!isDefined(path[index].target)) {
      if(!istrue(forcelooped)) {
        var_4437e81f60b6b5a0 = 1;
      }

      break;
    }

    nextnode = getStruct(path[index].target, "targetname");

    if(!isDefined(nextnode) || node == nextnode || path[index] == nextnode) {
      break;
    }

    index++;
    path[index] = nextnode;
  }

  pathstruct = spawnStruct();
  pathstruct.path = path;
  pathstruct.claimed = 0;
  pathstruct.var_4437e81f60b6b5a0 = var_4437e81f60b6b5a0;
  return pathstruct;
}

function function_1353821e73926c69() {
  level.looseguardnodes = [];
  function_44739fe1cf82e29a("looseGuardNodes");
  level.firstkillfoddernodes = [];
  function_44739fe1cf82e29a("firstKillFodderNodes");
  keys = getarraykeys(level.struct_class_names["script_noteworthy"]);

  foreach(key in keys) {
    if(issubstr(key, "guard")) {
      foreach(node in level.struct_class_names["script_noteworthy"][key]) {
        if(!isDefined(node.targetname)) {
          if(!isDefined(node.poi)) {
            node.poi = poi_findpoioriginisin(node.origin);
          }

          if(tolower(key) == "guard" || issubstr(tolower(key), "guard_stationary") || issubstr(tolower(key), "guard_spawnset")) {
            level.looseguardnodes[level.looseguardnodes.size] = node;
            function_d0e7647e5538eb9d(node.poi, "looseGuardNodes", node);
            continue;
          }

          if(issubstr(node.script_noteworthy, "firstKillFodder")) {
            level.firstkillfoddernodes[level.firstkillfoddernodes.size] = node;
            function_d0e7647e5538eb9d(node.poi, "firstKillFodderNodes", node);
            continue;
          }

          if(!isDefined(node.target) && !issubstr(tolower(key), "boss")) {
            level.looseguardnodes[level.looseguardnodes.size] = node;
            function_d0e7647e5538eb9d(node.poi, "looseGuardNodes", node);
          }
        }
      }
    }
  }
}

function function_525668dfdc6f8421() {
  level.var_82e8eb77e9b274e6 = level.looseguardnodes;

  foreach(pathstruct in level.patrolpaths) {
    foreach(node in pathstruct.path) {
      level.var_82e8eb77e9b274e6[level.var_82e8eb77e9b274e6.size] = node;
    }
  }
}

function function_645bfe3907dcc2a0() {
  level.var_f81cb9ead7b61ac1 = [];
  keys = getarraykeys(level.struct_class_names["script_noteworthy"]);

  foreach(key in keys) {
    if(issubstr(key, "spawn_area")) {
      struct = spawnStruct();
      struct.origin = level.struct_class_names["script_noteworthy"][key][0].origin;
      struct.guardnodes = [];
      struct.patrolpaths = [];
      poiname = level.struct_class_names["script_noteworthy"][key][0].poi;

      if(poi_issystemactive() && isDefined(poiname)) {
        function_44739fe1cf82e29a("subAreas");
        function_d0e7647e5538eb9d(poiname, "subAreas", struct, key);
        continue;
      }

      if(!isDefined(level.var_21d3078030950348)) {
        level.var_f81cb9ead7b61ac1 = [];
      }

      level.var_f81cb9ead7b61ac1[key] = struct;
    }
  }

  if(poi_issystemactive()) {
    foreach(poiname, poi in level.poi) {
      function_c1e539c16aeb4bd1(poiname);
    }

    return;
  }

  if(isDefined(level.var_21d3078030950348) && level.var_f81cb9ead7b61ac1.size > 0) {
    level.var_947cc8c185b0ea9c = 1;
    function_c1e539c16aeb4bd1();
  }
}

function function_c1e539c16aeb4bd1(poiname) {
  if(isDefined(poiname)) {
    guardnodes = level.poi[poiname]["looseGuardNodes"];
    areas = level.poi[poiname]["subAreas"];
  } else {
    guardnodes = level.looseguardnodes;
    areas = level.var_f81cb9ead7b61ac1;
  }

  if(areas.size == 0) {
    return;
  }

  foreach(node in guardnodes) {
    var_e6fd13e3873e27fc = undefined;
    closestdist = undefined;

    foreach(key, area in areas) {
      dist = distance2dsquared(node.origin, area.origin);

      if(!isDefined(var_e6fd13e3873e27fc)) {
        var_e6fd13e3873e27fc = key;
        closestdist = dist;
        continue;
      }

      if(dist < closestdist) {
        var_e6fd13e3873e27fc = key;
        closestdist = dist;
      }
    }

    if(isDefined(poiname)) {
      level.poi[poiname]["subAreas"][var_e6fd13e3873e27fc].guardnodes[level.poi[poiname]["subAreas"][var_e6fd13e3873e27fc].guardnodes.size] = node;
      continue;
    }

    level.var_f81cb9ead7b61ac1[var_e6fd13e3873e27fc].guardnodes[level.var_f81cb9ead7b61ac1[var_e6fd13e3873e27fc].guardnodes.size] = node;
  }

  if(isDefined(poiname)) {
    patrolpaths = level.poi[poiname]["patrolPaths"];
  } else {
    patrolpaths = level.patrolpaths;
  }

  foreach(pathstruct in patrolpaths) {
    var_e6fd13e3873e27fc = undefined;
    closestdist = undefined;

    foreach(key, area in areas) {
      dist = distance2dsquared(pathstruct.path[0].origin, area.origin);

      if(!isDefined(var_e6fd13e3873e27fc)) {
        var_e6fd13e3873e27fc = key;
        closestdist = dist;
        continue;
      }

      if(dist < closestdist) {
        var_e6fd13e3873e27fc = key;
        closestdist = dist;
      }
    }

    if(isDefined(poiname)) {
      level.poi[poiname]["subAreas"][var_e6fd13e3873e27fc].patrolpaths[level.poi[poiname]["subAreas"][var_e6fd13e3873e27fc].patrolpaths.size] = pathstruct;
      continue;
    }

    level.var_f81cb9ead7b61ac1[var_e6fd13e3873e27fc].patrolpaths[level.var_f81cb9ead7b61ac1[var_e6fd13e3873e27fc].patrolpaths.size] = pathstruct;
  }
}

function aibudget_init() {
  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  waittillframeend();
  level.var_41670c1c65f3d3cf = spawnStruct();
  level.var_41670c1c65f3d3cf.agentdeaths = 0;
  level.var_41670c1c65f3d3cf.var_ef41bd897f02797b = [];
  function_572838690d80d959("everybody");
  priority_init();

  if(isDefined(level.var_428703950599c9e9)) {
    [[level.var_428703950599c9e9]]();
  } else {
    scripts\mp\gametypes\dmz_ai::function_428703950599c9e9();
  }

  level.var_41670c1c65f3d3cf.maxagents = getmaxagents() - 1;

  if(isDefined(level.poi)) {
    level.var_41670c1c65f3d3cf.poi = [];

    foreach(poiname, poi in level.poi) {
      struct = spawnStruct();
      struct.agentdeaths = 0;
      function_b49cde2a52702967(poiname, "everybody");
      level.var_41670c1c65f3d3cf.poi[poiname] = struct;
    }
  }

  flag_set("aiBudget_init");
}

function function_2fc80954fa70d153() {
  while(!isDefined(level.agentarray)) {
    waitframe();
  }

  while(!isDefined(level.var_41670c1c65f3d3cf)) {
    waitframe();
  }

  while(!isDefined(level.var_41670c1c65f3d3cf.maxagents)) {
    waitframe();
  }

  maxagents = function_3813364e2323b789();

  while(level.agentarray.size < maxagents) {
    waitframe();
  }

  if(poi_issystemactive()) {
    while(!istrue(level.var_9589c5a19c1a71fc)) {
      waitframe();
    }
  }

  waitframe();
}

function function_b1d1e7e3b23e0dfe(var_8dc7c013853f3f4e) {
  assert(isDefined(level.var_41670c1c65f3d3cf), "<dev string:x4f5>");
  level.agentcategories = var_8dc7c013853f3f4e;
  function_1c161b20f0c6c6b5(var_8dc7c013853f3f4e);
}

function function_ba4022744dce59f6(category, maxagents) {
  assert(isDefined(level.var_41670c1c65f3d3cf) && isDefined(level.var_41670c1c65f3d3cf.var_ef41bd897f02797b), "<dev string:x53e>");
  assert(isDefined(category), "<dev string:x585>");

  if(isDefined(maxagents)) {
    level.var_41670c1c65f3d3cf.var_ef41bd897f02797b[category] = maxagents;
  }

  level.agentcategories = array_add_safe(level.agentcategories, category);
  function_572838690d80d959(category);
}

function function_157c2000284999eb(agent, category, subcategory, poiname) {
  assert(isDefined(agent), "<dev string:x59b>");
  assert(isDefined(level.var_41670c1c65f3d3cf), "<dev string:x5c9>");
  assert(isDefined(agent) && isDefined(category) && isDefined(subcategory), "<dev string:x60d>");

  if(isagent(agent)) {
    agentpers_setagentpersdata(agent, "category", category);
    agentpers_setagentpersdata(agent, "subcategory", subcategory);
  }

  function_e812b7065161da79(agent, category);

  if(category != "everybody") {
    function_e812b7065161da79(agent, "everybody");
  }

  if(poi_issystemactive()) {
    if(isagent(agent) && isDefined(agent.poi)) {
      poiname = agent.poi;
    }

    if(!isDefined(poiname)) {
      return;
    }

    function_a0cfb616f44b7907(agent, poiname, category);

    if(category != "everybody") {
      function_a0cfb616f44b7907(agent, poiname, "everybody");
    }
  }
}

function private function_1e5307c0d848a9ca(agent, poiname) {
  if(!isDefined(agent)) {
    return;
  }

  assert(isDefined(level.var_41670c1c65f3d3cf), "<dev string:x643>");
  category = undefined;
  subcategory = undefined;

  if(isagent(agent)) {
    category = agentpers_getagentpersdata(agent, "category");
    subcategory = agentpers_getagentpersdata(agent, "subcategory");
  } else if(isint(agent)) {
    infopackage = level.var_879053468f168806[agent];
    category = infopackage.category;
    subcategory = infopackage.subcategory;
  }

  assert(isDefined(category), "<dev string:x689>");
  assert(isDefined(subcategory), "<dev string:x6d1>");
  function_c36f897d56e28169(agent, category);

  if(category != "everybody") {
    function_c36f897d56e28169(agent, "everybody");
  }

  if(poi_issystemactive() && isDefined(poiname)) {
    function_d57d61c9f7b4aa77(agent, poiname, category);

    if(category != "everybody") {
      function_d57d61c9f7b4aa77(agent, poiname, "everybody");
    }
  }
}

function function_9368fb9261e4cd0a(category) {
  assert(isDefined(level.var_41670c1c65f3d3cf), "<dev string:x71c>");
  assert(isDefined(category), "<dev string:x768>");
  return function_9a83377c98bce82a(category);
}

function private function_5069c21ddc5c2227(category) {
  assert(isDefined(level.var_41670c1c65f3d3cf) && isDefined(level.var_41670c1c65f3d3cf.var_ef41bd897f02797b) && isDefined(level.var_41670c1c65f3d3cf.var_ef41bd897f02797b), "<dev string:x7b0>");
  assert(isDefined(category), "<dev string:x800>");
  var_8728595177092026 = level.var_41670c1c65f3d3cf.var_ef41bd897f02797b[category];

  if(!isDefined(var_8728595177092026)) {
    return undefined;
  }

  return var_8728595177092026 - function_9368fb9261e4cd0a(category);
}

function function_8c6dbb64c8e1603c(number, category, origin, poiname, spawndormant, subarea) {
  assert(isDefined(level.var_41670c1c65f3d3cf) && isDefined(level.var_41670c1c65f3d3cf.var_ef41bd897f02797b) && isDefined(level.var_41670c1c65f3d3cf.var_ef41bd897f02797b), "<dev string:x84c>");
  assert(isDefined(number), "<dev string:x894>");
  var_868c5168078feacf = !istrue(spawndormant) && function_e8c0ac958d093ec2() + number <= function_3813364e2323b789() || istrue(spawndormant) && function_b27fe8a834c5edda() + number <= function_3b45c895d8d984ee();

  if(getdvarint(@ "hash_a0cb2262bebb424b", 0)) {
    return var_868c5168078feacf;
  }

  var_2231df82d7283c43 = undefined;

  if(poi_issystemactive()) {
    var_2231df82d7283c43 = 0;

    if(!isDefined(subarea)) {
      subarea = subarea_findfromorigin(origin, poiname);
    }

    if(isDefined(subarea)) {
      var_ef017ff00ebc23ce = ter_op(isDefined(subarea.var_f27d7498eb54dd99), subarea.var_f27d7498eb54dd99, 0);
    } else {
      var_ef017ff00ebc23ce = 0;
    }

    if(istrue(level.var_cfa897b9ea19cd05) || getdvarint(@ "hash_9f36593603489c07", 0) == 1) {
      var_2231df82d7283c43 = 1;
    }

    if(isint(number) && isDefined(subarea) && isDefined(subarea.var_7da9883d4168b7f1) && isDefined(subarea.var_7da9883d4168b7f1.var_63e6c2f5f608f74e) && isarray(subarea.var_3ebb6024e3f220ca) && subarea.var_3ebb6024e3f220ca.size + number + var_ef017ff00ebc23ce <= subarea.var_7da9883d4168b7f1.var_63e6c2f5f608f74e) {
      var_2231df82d7283c43 = 1;
    }
  }

  var_74f7067d31b382f9 = undefined;

  if(isDefined(category)) {
    var_74f7067d31b382f9 = function_5069c21ddc5c2227(category);
  }

  var_ff9ff42ed5501237 = !isDefined(var_74f7067d31b382f9) || var_74f7067d31b382f9 >= number;
  return var_868c5168078feacf && var_ff9ff42ed5501237 && (!isDefined(var_2231df82d7283c43) || var_2231df82d7283c43);
}

function function_359f24553bdcca92(number, priority) {
  assert(isDefined(priority) && isDefined(number), "<dev string:x8ca>");
  var_944b7bc21500684a = 0;
  priorityint = array_find(level.var_41670c1c65f3d3cf.priorities, priority);
  assert(isDefined(priorityint), "<dev string:x906>");

  foreach(testpriority in level.var_41670c1c65f3d3cf.var_1d7de2571d2c82a7) {
    if(array_find(level.var_41670c1c65f3d3cf.priorities, testpriority) <= priorityint) {
      break;
    }

    var_944b7bc21500684a += function_44c0059e33f55f00(testpriority).size;
  }

  return function_e8c0ac958d093ec2() + number - var_944b7bc21500684a <= function_3813364e2323b789();
}

function function_e884d14c5b07b811() {
  return function_9a83377c98bce82a("everybody");
}

function function_e8c0ac958d093ec2() {
  return function_718d435f9750c1b5("everybody");
}

function function_bd71347864330395(array) {
  if(!isDefined(array)) {
    return function_e8c0ac958d093ec2();
  }

  totalspawned = 0;

  foreach(agent in array) {
    if(isagent(agent)) {
      totalspawned++;
    }
  }

  return totalspawned;
}

function function_3813364e2323b789() {
  return level.var_41670c1c65f3d3cf.maxagents;
}

function function_7ee4a8954b638ed3(agent, var_28173fd6b5a461f) {
  agent waittill("death", killer, meansofdeath);
  agent.var_9e3b0c89066bf153 = 1;
  vehiclekiller = scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata(agent, "vehicleKiller");
  var_8571123198e1b65c = undefined;

  if(isDefined(vehiclekiller)) {
    killer = vehiclekiller;
  }

  if(isDefined(killer) && isPlayer(killer)) {
    var_af65abf8cf095694 = "none";
    var_22caf6654438c835 = 0;

    if(isDefined(meansofdeath)) {
      var_af65abf8cf095694 = meansofdeath;

      if(meansofdeath == "MOD_HEAD_SHOT") {
        var_22caf6654438c835 = 1;
      }
    }

    var_19f06b9a4a523b5f = killer getcurrentweapon();
    var_8571123198e1b65c = var_19f06b9a4a523b5f issilenced();
    killer dlog_recordplayerevent("dlog_event_dmz_player_killed_ai", ["means_of_death", var_af65abf8cf095694, "playerweapon", var_19f06b9a4a523b5f.basename, "isheadshot", var_22caf6654438c835]);
  }

  madedormant = isDefined(meansofdeath) && meansofdeath == "MOD_DESPAWN";
  poiname = agentpers_getagentpersdata(agent, "poiName");
  subarea = agentpers_getagentpersdata(agent, "subArea");
  var_840a2eec4405f2f4 = isDefined(level.var_796e20f059a611d1) && [[level.var_796e20f059a611d1]]();

  if(scripts\engine\utility::issharedfuncdefined("analytics", "agent_killed") && !var_840a2eec4405f2f4) {
    [[scripts\engine\utility::getsharedfunc("analytics", "agent_killed")]](agent, madedormant, killer);
  }

  if(!istrue(agentpers_getagentpersdata(agent, "skipDeathCount")) && !istrue(madedormant)) {
    level.var_41670c1c65f3d3cf.agentdeaths++;

    if(poi_issystemactive() && isDefined(poiname)) {
      level.var_41670c1c65f3d3cf.poi[poiname].agentdeaths++;
    }

    function_3daefb936272829f(poiname, agent.origin, gettime(), subarea);
    thread function_be9c6fbd4dc69254(agent, killer);
    agent thread function_cdcce09b74c7cd1b(meansofdeath);

    if(isDefined(var_28173fd6b5a461f)) {
      var_28173fd6b5a461f.var_13235d60c661e10b--;
    }

    team = agentpers_getagentpersdata(agent, "team");
    assignedobjective = agentpers_getagentpersdata(agent, "assignedObjective");

    if(isDefined(assignedobjective)) {
      assignedobjective.var_99669e1e71dbd643[team] = array_remove(assignedobjective.var_99669e1e71dbd643[team], agent);
    }

    agentstruct = agentpers_getagentpersdata(agent, "agentStruct");

    if(isDefined(agentstruct)) {
      if(isDefined(agentstruct.group)) {
        [[agentstruct.ondeath]](agent, killer);
      } else if(isDefined(level.var_59cffb78293fe83c) && isDefined(level.var_59cffb78293fe83c.ondeath)) {
        [[level.var_59cffb78293fe83c.ondeath]](agent, killer);
      }
    }
  }

  function_1e5307c0d848a9ca(agent, poiname);
  priority_remove(agent);

  if(isDefined(subarea)) {
    subarea_removeagentfrom(agent, subarea);

    if(!istrue(agentpers_getagentpersdata(agent, "skipDeathCount"))) {
      delay = 0;
      lastnonsilenceddamagetime = agentpers_getagentpersdata(self, "lastNonSilencedDamageTime");

      if(istrue(var_8571123198e1b65c) && (!isDefined(lastnonsilenceddamagetime) || isDefined(lastnonsilenceddamagetime) && gettime() - lastnonsilenceddamagetime > level.var_96abdb45aee491fc * 1000)) {
        delay = level.var_5dcccc815e25c8e2;
      }

      level thread function_95c315b1e51bd9c5(subarea, delay);
    }
  }

  cqbnode = agentpers_getagentpersdata(agent, "cqbNode");

  if(isDefined(cqbnode)) {
    cqb_releasenode(cqbnode);
  }

  waittillframeend();
  function_51de6da7b0dcf26f(agent);
  agent.var_9e3b0c89066bf153 = 0;
}

function function_1d52040f64b0d854(poiname) {
  idle = 0;
  investigate = 0;
  combat = 0;
  hunt = 0;

  if(isDefined(poiname) && isDefined(level.poi[poiname]) && isDefined(level.poi[poiname]["subAreas"])) {
    foreach(subarea in level.poi[poiname]["subAreas"]) {
      foreach(agent in subarea.var_3ebb6024e3f220ca) {
        if(!isagent(agent)) {
          idle++;
          continue;
        }

        if(!istrue(agent.stealth_enabled)) {
          if(isDefined(agent.enemy)) {
            combat++;
          } else {
            idle++;
          }

          continue;
        }

        if(agent[[agent.fnisinstealthidle]]()) {
          idle++;
          continue;
        }

        if(agent[[agent.fnisinstealthinvestigate]]()) {
          investigate++;
          continue;
        }

        if(agent[[agent.fnisinstealthcombat]]()) {
          combat++;
          continue;
        }

        if(agent[[agent.fnisinstealthhunt]]()) {
          hunt++;
        }
      }
    }
  } else if(isDefined(level.agentarray)) {
    foreach(agent in level.agentarray) {
      if(!isalive(agent)) {
        continue;
      }

      if(agent[[agent.fnisinstealthidle]]()) {
        idle++;
        continue;
      }

      if(agent[[agent.fnisinstealthinvestigate]]()) {
        investigate++;
        continue;
      }

      if(agent[[agent.fnisinstealthcombat]]()) {
        combat++;
        continue;
      }

      if(agent[[agent.fnisinstealthhunt]]()) {
        hunt++;
      }
    }
  }

  return [idle, investigate, combat, hunt];
}

function function_bc423135571b28c1() {
  level endon("game_ended");

  while(true) {
    if(getdvarint(@ "hash_27877364a9af40a5", 0) == 1) {
      var_fa77d17200596805 = getaicount();
      logstring("Current agent count = " + var_fa77d17200596805);
      wait 30;
      continue;
    }

    wait 1;
  }
}

function private priority_init() {
  level.var_41670c1c65f3d3cf.priorities = ["absolute", "high", "medium", "low", "filler"];
  level.var_41670c1c65f3d3cf.var_1d7de2571d2c82a7 = array_reverse(level.var_41670c1c65f3d3cf.priorities);
  function_1c161b20f0c6c6b5(level.var_41670c1c65f3d3cf.priorities);
}

function private priority_set(agent, priority) {
  assert(isDefined(priority) && array_contains(level.var_41670c1c65f3d3cf.priorities, priority), "<dev string:x941>" + priority);
  assert(isDefined(agent), "<dev string:x980>");
  agent.priority = priority;
  function_e812b7065161da79(agent, priority);
  agentpers_setagentpersdata(agent, "priority", priority);
}

function private priority_setbydormancyid(dormancyid, priority) {
  assert(isDefined(priority) && array_contains(level.var_41670c1c65f3d3cf.priorities, priority), "<dev string:x9b5>" + priority);
  assert(isDefined(dormancyid), "<dev string:xa00>");
  function_e812b7065161da79(dormancyid, priority);
}

function private priority_remove(agent) {
  assert(isDefined(agent), "<dev string:xa40>");
  priority = priority_get(agent);
  assert(isDefined(priority) && array_contains(level.var_41670c1c65f3d3cf.priorities, priority), "<dev string:xa78>" + priority);
  function_c36f897d56e28169(agent, priority);
}

function private priority_removebydormancyid(dormancyid) {
  assert(isDefined(dormancyid), "<dev string:xaba>");
  assert(isDefined(level.var_879053468f168806[dormancyid]), "<dev string:xafd>" + dormancyid);
  priority = function_72d6808216b4d44(level.var_879053468f168806[dormancyid].priority);
  assert(isDefined(priority) && array_contains(level.var_41670c1c65f3d3cf.priorities, priority), "<dev string:xa78>" + priority);
  function_c36f897d56e28169(dormancyid, priority);
}

function priority_get(agent) {
  assert(isDefined(agent), "<dev string:xb44>");
  return agentpers_getagentpersdata(agent, "priority");
}

function function_daeb7849456192a9(priority) {
  assert(isDefined(priority) && array_contains(level.var_41670c1c65f3d3cf.priorities, priority), "<dev string:xb79>" + priority);
  return function_b4b9401715cf98ea(priority);
}

function function_44c0059e33f55f00(priority) {
  assert(isDefined(priority) && array_contains(level.var_41670c1c65f3d3cf.priorities, priority), "<dev string:xb79>" + priority);
  return function_7eb04ca16d045775(priority);
}

function function_72ae84d7068be83f(priority) {
  assert(isDefined(priority) && array_contains(level.var_41670c1c65f3d3cf.priorities, priority), "<dev string:xb79>" + priority);
  return function_5508ddea3a84df39(priority);
}

function debug_categories() {
  while(true) {
    if(getdvarint(@ "hash_9e9be127028294d2", 0) == 1) {
      agents = utility::function_2d7fd59d039fa69b(level.players[0].origin, 3000, 0);

      foreach(agent in agents) {
        if(isDefined(agent) && isagent(agent) && isalive(agent)) {
          print3d(agent.origin + (0, 0, 100), "<dev string:xbc7>" + agent.poi, (1, 0, 1), 1, 0.4);
          print3d(agent.origin + (0, 0, 90), "<dev string:x151>" + priority_get(agent), (1, 0, 1), 1, 0.4);
          print3d(agent.origin + (0, 0, 80), "<dev string:x15f>" + agent.category, (1, 0, 1), 1, 0.4);
          print3d(agent.origin + (0, 0, 70), "<dev string:x16d>" + agent.subcategory, (1, 0, 1), 1, 0.4);
        }
      }
    }

    waitframe();
  }
}

function function_80cd0109b7f5161d() {
  level.var_360542b7ea0d5403 = getdvarint(@ "hash_2ac28fc028bd24f6", 1);

  if(isDefined(level.poi)) {
    foreach(poi in level.poi) {
      foreach(subarea in poi["subAreas"]) {
        if(!istrue(subarea.delayspawn)) {
          subarea_spawnagentpackages(subarea);
        }
      }
    }
  }
}

function function_b4367b762ab15e1f() {
  if(isDefined(level.poi)) {
    function_18076fc4f3fbc0d4();
    return;
  }

  function_271daff60f7d1de3();
}

function spawnguard(node, isstationary, var_ba8b04eb4b683e67, priority, category, subcategory, poiname, subarea) {
  if(!isDefined(poiname)) {
    poiname = node.poi;
  }

  if(!isDefined(poiname)) {
    node.poi = scripts\mp\poi::poi_findpoioriginisin(node.origin);
  }

  aitype = function_d5bc07eabf352abb(node, poiname);
  groupname = function_59cdfe39e161a336(node);
  skipstealth = function_d77aad1a4fff0114(node);
  agent = ai_mp_requestspawnagent(aitype, node.origin, node.angles, priority, category, subcategory, groupname, undefined, undefined, poiname, skipstealth, undefined, undefined, node.agent_type, undefined, subarea);

  if(isDefined(agent)) {
    if(isagent(agent)) {
      if(istrue(isstationary)) {
        agent thread function_b11c1964f528574b(agent, var_ba8b04eb4b683e67);
      } else if(isDefined(level.var_1c8cbd78af4920d0)) {
        agent thread[[level.var_1c8cbd78af4920d0]](agent);
      } else {
        agent thread function_9bbf1713a14fa580(agent);
      }
    } else if(isint(agent)) {
      if(istrue(isstationary)) {
        function_d1e130608e4f8487(agent, node.origin, var_ba8b04eb4b683e67);
      } else {
        function_e786aa52b93833eb(agent, node.origin);
      }
    }
  }

  return agent;
}

function spawnpatrol(pathstruct, minagents, maxagents, var_f28f3885995a439d, priority, category, subcategory) {
  agents = [];
  path = pathstruct.path;
  angles = (0, 0, 0);

  if(isDefined(path[0].angles)) {
    angles = path[0].angles;
  }

  if(isDefined(path[0].minagents)) {
    minagents = path[0].minagents;
  }

  if(!isDefined(minagents)) {
    minagents = 1;
  } else {
    minagents = int(minagents);
  }

  if(isDefined(path[0].maxagents)) {
    maxagents = path[0].maxagents;
  }

  if(!isDefined(maxagents)) {
    maxagents = 1;
  } else {
    maxagents = int(maxagents);
  }

  numagents = minagents;

  if(minagents < maxagents) {
    numagents = randomintrange(minagents, maxagents);
  }

  var_10ac129919e367b5 = [];
  var_10ac129919e367b5[0] = path[0].var_26242e8921ae5b22;
  var_10ac129919e367b5[1] = path[0].var_26242d8921ae58ef;
  var_10ac129919e367b5[2] = path[0].var_26242c8921ae56bc;
  var_10ac129919e367b5[3] = path[0].var_26242b8921ae5489;
  var_10ac129919e367b5[4] = path[0].var_26242a8921ae5256;
  var_10ac129919e367b5[5] = path[0].var_2624298921ae5023;
  skipstealth = function_d77aad1a4fff0114(path[0]);
  groupname = undefined;

  if(isDefined(var_f28f3885995a439d)) {
    groupname = var_f28f3885995a439d.name;
  }

  min = 30;
  max = 31;

  for(i = 0; i < numagents; i++) {
    var_fcdc7f62624c71ff = undefined;
    basetype = undefined;

    if(isDefined(var_10ac129919e367b5[i])) {
      if(issubstr(tolower(var_10ac129919e367b5[i]), "spawnset")) {
        var_fcdc7f62624c71ff = getsubstr(var_10ac129919e367b5[i], 9, var_10ac129919e367b5[i].size);
      } else {
        basetype = var_10ac129919e367b5[i];
      }
    } else {
      var_fcdc7f62624c71ff = "spawnset_patrol_primary";

      if(i > 0) {
        var_fcdc7f62624c71ff = "spawnset_patrol_secondary";
      }
    }

    tempnode = spawnStruct();
    tempnode.agent_type = path[0].agent_type;
    tempnode.poi = path[0].poi;
    tempnode.var_71ad22c5d093d90b = path[0].var_71ad22c5d093d90b;
    tempnode.origin = path[0].origin;
    tempnode.nationality = path[0].nationality;
    tempnode.script_noteworthy = ter_op(isDefined(var_10ac129919e367b5[i]), var_10ac129919e367b5[i], var_fcdc7f62624c71ff);
    aitype = function_d5bc07eabf352abb(tempnode, path[0].poi, var_fcdc7f62624c71ff, basetype);
    angles = (angles[0], randomint(360), angles[2]);
    random_x = randomfloatrange(min, max) * scripts\engine\utility::ter_op(cointoss(), 1, -1);
    random_y = randomfloatrange(min, max) * scripts\engine\utility::ter_op(cointoss(), 1, -1);
    spawnloc = function_61cbc488b27a6e61(path[0].origin + (random_x, random_y, 0));
    agent = ai_mp_requestspawnagent(aitype, spawnloc, angles, priority, category, subcategory, groupname, undefined, undefined, path[0].poi, skipstealth, undefined, undefined, path[0].agent_type);

    if(isDefined(agent)) {
      agents[i] = agent;
    }
  }

  waitframe();
  var_f646efe73aae53dc = 1;

  foreach(agent in agents) {
    if(isint(agent)) {
      var_f646efe73aae53dc = 0;
      break;
    }
  }

  if(var_f646efe73aae53dc) {
    level thread behavior_patrol(agents, pathstruct);
  } else {
    foreach(agent in agents) {
      level thread behavior_patrol([agent], pathstruct);
    }
  }

  return agents;
}

function function_d77aad1a4fff0114(node) {
  if(isDefined(node.script_label)) {
    return issubstr(node.script_label, "isCQB");
  }

  return 0;
}

function function_18076fc4f3fbc0d4() {
  foreach(poiname, poi in level.poi) {
    if(isDefined(poi["subAreas"]) && poi["subAreas"].size > 0) {
      foreach(subarea in poi["subAreas"]) {
        if(!istrue(subarea.delayspawn)) {
          function_b2b01599b30cfe2f(subarea);
        }
      }

      continue;
    }

    numtospawn = 0;

    if(function_abbd4595d76ccc5e(poiname, "everybody") < level.poi[poiname]["tuning"].var_74fd03286daecf85) {
      numtospawn = int(level.poi[poiname]["tuning"].var_74fd03286daecf85 - function_abbd4595d76ccc5e(poiname, "everybody"));
    } else {
      return;
    }

    var_d8fdd5b8b53e1735 = int(numtospawn / 2);
    level.poi[poiname]["looseGuardNodes"] = array_randomize(level.poi[poiname]["looseGuardNodes"]);

    foreach(spawnloc in level.poi[poiname]["looseGuardNodes"]) {
      if(namespace_9823ee6035594d67::function_2cde636a73aead3d(spawnloc.origin)) {
        continue;
      }

      isstationary = issubstr(spawnloc.script_noteworthy, "stationary") || istrue(spawnloc.isstationary);
      agent = spawnguard(spawnloc, isstationary, undefined, "low", "extraGuards", undefined, poiname);

      if(isDefined(agent)) {
        var_d8fdd5b8b53e1735--;
        numtospawn--;

        if(var_d8fdd5b8b53e1735 == 0) {
          break;
        }
      }
    }

    level.poi[poiname]["patrolPaths"] = array_randomize(level.poi[poiname]["patrolPaths"]);

    foreach(pathstruct in level.poi[poiname]["patrolPaths"]) {
      if(istrue(pathstruct.claimed)) {
        continue;
      }

      pathstruct.claimed = 1;
      agents = spawnpatrol(pathstruct, min(numtospawn, level.var_33cf4079b4096eb8), min(numtospawn, level.var_1bdf3af6b78dc2ca), undefined, "low", "extraPatrols");

      if(isDefined(agents)) {
        numtospawn -= agents.size;
      }

      if(numtospawn <= 0) {
        break;
      }
    }
  }
}

function function_b2b01599b30cfe2f(subarea) {
  numtospawn = 0;

  if(subarea.var_3ebb6024e3f220ca.size < subarea.var_7da9883d4168b7f1.var_74fd03286daecf85) {
    numtospawn = int(subarea.var_7da9883d4168b7f1.var_74fd03286daecf85 - subarea.var_3ebb6024e3f220ca.size);
  } else {
    return;
  }

  var_d8fdd5b8b53e1735 = int(numtospawn / 2);
  level.poi[subarea.poi]["looseGuardNodes"] = array_randomize(level.poi[subarea.poi]["looseGuardNodes"]);

  foreach(spawnloc in level.poi[subarea.poi]["looseGuardNodes"]) {
    if(spawnloc.var_71ad22c5d093d90b != subarea.var_71ad22c5d093d90b) {
      continue;
    }

    if(namespace_9823ee6035594d67::function_2cde636a73aead3d(spawnloc.origin)) {
      continue;
    }

    spawnloc.var_1e9d8e53eeec48a = 1;
    isstationary = issubstr(spawnloc.script_noteworthy, "stationary") || istrue(spawnloc.isstationary);
    agent = spawnguard(spawnloc, isstationary, undefined, "low", "extraGuards", undefined, subarea.poi, subarea);

    if(isDefined(agent)) {
      var_d8fdd5b8b53e1735--;
      numtospawn--;

      if(var_d8fdd5b8b53e1735 == 0) {
        break;
      }
    }
  }

  level.poi[subarea.poi]["patrolPaths"] = array_randomize(level.poi[subarea.poi]["patrolPaths"]);

  foreach(pathstruct in level.poi[subarea.poi]["patrolPaths"]) {
    if(pathstruct.var_71ad22c5d093d90b != subarea.var_71ad22c5d093d90b) {
      continue;
    }

    if(istrue(pathstruct.claimed)) {
      continue;
    }

    pathstruct.claimed = 1;
    pathstruct.var_1e9d8e53eeec48a = 1;
    agents = spawnpatrol(pathstruct, min(numtospawn, level.var_33cf4079b4096eb8), min(numtospawn, level.var_1bdf3af6b78dc2ca), undefined, "low", "extraPatrols");

    if(isDefined(agents)) {
      numtospawn -= agents.size;
    }

    if(numtospawn <= 0) {
      break;
    }
  }
}

function function_271daff60f7d1de3() {
  if(istrue(level.var_947cc8c185b0ea9c)) {
    foreach(area in level.var_f81cb9ead7b61ac1) {
      if(!istrue(area.delayspawn)) {
        function_b2b01599b30cfe2f(area);
      }
    }

    return;
  }

  level.looseguardnodes = array_randomize(level.looseguardnodes);

  for(i = 0; i < getdvarint(@ "scr_aibudget_extraguards", 15); i++) {
    if(!isDefined(level.looseguardnodes[i])) {
      continue;
    }

    isstationary = issubstr(level.looseguardnodes[i].script_noteworthy, "stationary") || istrue(level.looseguardnodes[i].isstationary);
    spawnguard(level.looseguardnodes[i], isstationary, undefined, "low", "extraGuards");
  }

  var_3b7047dea3e6835c = getdvarint(@ "scr_aibudget_extrapatrols", 15);
  var_beec4bcf2979ee14 = 0;
  level.patrolpaths = array_randomize(level.patrolpaths);

  foreach(pathstruct in level.patrolpaths) {
    if(istrue(pathstruct.claimed)) {
      continue;
    }

    pathstruct.claimed = 1;
    var_beec4bcf2979ee14++;
    spawnpatrol(pathstruct, level.var_33cf4079b4096eb8, level.var_1bdf3af6b78dc2ca, undefined, "low", "extraPatrols");

    if(var_beec4bcf2979ee14 >= var_3b7047dea3e6835c) {
      return;
    }
  }
}

function function_a767dbcb4dd41ce(startpoints) {
  if(!istrue(level.supportsai)) {
    return;
  }

  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  waitframe();
  tospawn = getdvarint(@ "hash_453f9b238f7679a9", 5);
  spawned = 0;

  foreach(startpoint in startpoints) {
    count = 0;

    if(randomint(100) < 25) {
      count = 2;
    } else if(randomint(100) < 50) {
      count = 1;
    }

    if(count > 0) {
      nodes = function_5649cfac1074189a(count, startpoint);

      foreach(node in nodes) {
        if(isDefined(node) && !istrue(node.used) && (!scripts\mp\poi::poi_issystemactive() || isDefined(node.poi) && scripts\mp\poi::poi_ispoiactive(node.poi))) {
          node.script_noteworthy = "guard";
          spawnguard(node, 1, 1, "low", "firstKillFodder");
          node.used = 1;
          spawned++;
        }
      }
    }

    if(spawned >= tospawn) {
      break;
    }
  }
}

function function_5649cfac1074189a(num, origin) {
  nodes = level.firstkillfoddernodes;
  level.var_62ba049e99d59e0f = origin;
  nodes = array_sort_with_func(nodes, &function_5db95edac4ad7c26);
  level.var_62ba049e99d59e0f = undefined;
  return array_slice(nodes, 0, num);
}

function function_5db95edac4ad7c26(node1, node2) {
  return distance(node1.origin, level.var_62ba049e99d59e0f) < distance(node2.origin, level.var_62ba049e99d59e0f);
}

function spawnspecial() {
  numtospawn = getdvarint(@ "hash_74a83bb7bcb5e738", 2);
  level.var_612698c6d5ab4c3b = array_randomize(level.var_612698c6d5ab4c3b);
  weaponstyle = random(["smg", "shotgun", "sniper"]);

  for(i = 0; i < numtospawn; i++) {
    if(isDefined(level.var_612698c6d5ab4c3b[i])) {
      agent = spawnguard(level.var_612698c6d5ab4c3b[i], undefined, undefined, "medium", "elites");

      if(isDefined(agent)) {
        overridespecial(agent, weaponstyle);
      }
    }
  }
}

function function_a09c0a759d909dc9() {
  level.var_7da9883d4168b7f1 = [];

  if(!isDefined(level.var_9fab40ed3326f8b)) {
    return;
  }

  if(!poi_issystemactive()) {
    return;
  }

  function_f9382e7642d4762();
  function_559f1c9cc3c11793();

  if(istrue(level.var_7a36d824da6087ef)) {
    level thread function_454dee65b310ed1c();
  }

  foreach(poiname, poi in level.poi) {
    level.poi[poiname]["tuning"] = spawnStruct();
    var_6409d4f5f62f669c = 0;
    var_74fd03286daecf85 = 0;
    var_63e6c2f5f608f74e = 0;

    if(isDefined(level.var_7da9883d4168b7f1[poiname])) {
      foreach(subarea in level.var_7da9883d4168b7f1[poiname]) {
        var_6409d4f5f62f669c += subarea.var_6409d4f5f62f669c;
        var_74fd03286daecf85 += subarea.var_74fd03286daecf85;
        var_63e6c2f5f608f74e += subarea.var_63e6c2f5f608f74e;
      }
    }

    level.poi[poiname]["tuning"].var_6409d4f5f62f669c = var_6409d4f5f62f669c;
    level.poi[poiname]["tuning"].var_74fd03286daecf85 = var_74fd03286daecf85;
    level.poi[poiname]["tuning"].var_63e6c2f5f608f74e = var_63e6c2f5f608f74e;
  }

  level.var_9589c5a19c1a71fc = 1;
}

function function_f9382e7642d4762() {
  table = level.var_9fab40ed3326f8b;
  numrows = tablelookupgetnumrows(table);

  for(i = 0; i < numrows; i++) {
    poiname = tablelookupbyrow(table, i, 0);

    if(!isDefined(level.var_7da9883d4168b7f1[poiname])) {
      level.var_7da9883d4168b7f1[poiname] = [];
    }

    var_71ad22c5d093d90b = tolower(tablelookupbyrow(table, i, 1));

    if(issubstr(var_71ad22c5d093d90b, "tieroverride") || var_71ad22c5d093d90b == "minVehicleSpawns") {
      continue;
    }

    minnum = int(tablelookupbyrow(table, i, 2));
    idealnum = int(tablelookupbyrow(table, i, 3));
    maxnum = int(tablelookupbyrow(table, i, 4));

    if(!isDefined(level.var_7da9883d4168b7f1[poiname][var_71ad22c5d093d90b])) {
      level.var_7da9883d4168b7f1[poiname][var_71ad22c5d093d90b] = spawnStruct();
    }

    if(scripts\mp\gametypes\br_gametype_dmz::function_7a7aa3b5455f0412(poiname)) {
      var_fa93bdf94e856f94 = tablelookupbyrow(table, i, 17);

      if(isDefined(var_fa93bdf94e856f94) && var_fa93bdf94e856f94 != "") {
        var_9110fd7b0154b211 = int(var_fa93bdf94e856f94);
      } else {
        var_9110fd7b0154b211 = getdvarfloat(@ "hash_5ac522852d2666d5", 2);
      }

      minnum = int(minnum * var_9110fd7b0154b211);
      idealnum = int(idealnum * var_9110fd7b0154b211);
      maxnum = int(maxnum * var_9110fd7b0154b211);
    }

    level.var_7da9883d4168b7f1[poiname][var_71ad22c5d093d90b].var_6409d4f5f62f669c = minnum;
    level.var_7da9883d4168b7f1[poiname][var_71ad22c5d093d90b].var_74fd03286daecf85 = idealnum;
    level.var_7da9883d4168b7f1[poiname][var_71ad22c5d093d90b].var_63e6c2f5f608f74e = maxnum;
    var_f1bab2a8fa8fe3f0 = int(tablelookupbyrow(table, i, 7));
    level.var_7da9883d4168b7f1[poiname][var_71ad22c5d093d90b].var_f1bab2a8fa8fe3f0 = var_f1bab2a8fa8fe3f0;
    nationalityoverride = tablelookupbyrow(table, i, 8);

    if(isDefined(nationalityoverride) && nationalityoverride != "") {
      level.var_7da9883d4168b7f1[poiname][var_71ad22c5d093d90b].nationalityoverride = nationalityoverride;
    }

    var_cab6f6d27832069a = tablelookupbyrow(table, i, 9);

    if(isDefined(var_cab6f6d27832069a) && var_cab6f6d27832069a != "") {
      level.var_7da9883d4168b7f1[poiname][var_71ad22c5d093d90b].var_cab6f6d27832069a = var_cab6f6d27832069a;
    }

    var_1832752381c598da = tablelookupbyrow(table, i, 13);

    if(isDefined(var_1832752381c598da) && var_1832752381c598da != "") {
      level.var_7da9883d4168b7f1[poiname][var_71ad22c5d093d90b].var_1832752381c598da = int(var_1832752381c598da);
    }

    var_fe9d8027d120b1b6 = tablelookupbyrow(table, i, 14);

    if(isDefined(var_fe9d8027d120b1b6) && var_fe9d8027d120b1b6 != "") {
      level.var_7da9883d4168b7f1[poiname][var_71ad22c5d093d90b].var_fe9d8027d120b1b6 = int(var_fe9d8027d120b1b6);
    }

    var_a766d7c366509879 = tablelookupbyrow(table, i, 15);

    if(isDefined(var_a766d7c366509879) && var_a766d7c366509879 != "") {
      level.var_7da9883d4168b7f1[poiname][var_71ad22c5d093d90b].var_a766d7c366509879 = int(var_a766d7c366509879);
    }

    var_a743e9c3662a7857 = tablelookupbyrow(table, i, 16);

    if(isDefined(var_a743e9c3662a7857) && var_a743e9c3662a7857 != "") {
      level.var_7da9883d4168b7f1[poiname][var_71ad22c5d093d90b].var_a743e9c3662a7857 = int(var_a743e9c3662a7857);
    }
  }
}

function function_559f1c9cc3c11793() {
  table = level.var_9fab40ed3326f8b;
  numrows = tablelookupgetnumrows(table);

  for(i = 0; i < numrows; i++) {
    poiname = tablelookupbyrow(table, i, 0);

    if(poiname == "minVehicleSpawns") {
      continue;
    }

    if(issubstr(poiname, "tieroverride")) {
      if(!isDefined(level.var_28af753def4ab495)) {
        level.var_28af753def4ab495 = [];
      }

      level.var_28af753def4ab495[poiname] = int(tablelookupbyrow(table, i, 5));
      continue;
    }

    if(!isDefined(level.var_7da9883d4168b7f1[poiname])) {
      level.var_7da9883d4168b7f1[poiname] = [];
    }

    var_71ad22c5d093d90b = tolower(tablelookupbyrow(table, i, 1));
    difficultynum = int(tablelookupbyrow(table, i, 5));

    if(!isDefined(level.var_7da9883d4168b7f1[poiname][var_71ad22c5d093d90b])) {
      level.var_7da9883d4168b7f1[poiname][var_71ad22c5d093d90b] = spawnStruct();
    }

    level.var_7da9883d4168b7f1[poiname][var_71ad22c5d093d90b].var_84ecaeab58167d39 = difficultynum;
  }
}

function function_17f07bed46b1496b(subarea) {
  if(isDefined(subarea) && isDefined(subarea.var_7da9883d4168b7f1) && isDefined(subarea.var_7da9883d4168b7f1.var_84ecaeab58167d39)) {
    return subarea.var_7da9883d4168b7f1.var_84ecaeab58167d39;
  }

  return 1;
}

function subarea_getsubareadifficultyfromorigin(origin) {
  poiname = poi_findpoioriginisin(origin);
  return function_17f07bed46b1496b(subarea_findfromorigin(origin, poiname));
}

function subarea_getsubareanationality(origin, subarea, poiname) {
  if(!isDefined(subarea)) {
    if(!isDefined(origin)) {
      return function_f851a2f41cffa860();
    } else {
      subarea = subarea_findfromorigin(origin, poiname);
    }
  }

  if(isDefined(subarea.var_7da9883d4168b7f1.nationalityoverride)) {
    return subarea.var_7da9883d4168b7f1.nationalityoverride;
  }

  return function_f851a2f41cffa860();
}

function function_454dee65b310ed1c() {
  tieroverridevolumes = getnoentvolumearray("tierOverrideVolume", "targetname");

  foreach(volume in tieroverridevolumes) {
    poiname = scripts\mp\poi::poi_findpoioriginisin(volume.origin, 0, 1);

    if(!isDefined(poiname)) {
      continue;
    }

    if(!isDefined(level.poi[poiname]["tierOverrideVolumes"])) {
      level.poi[poiname]["tierOverrideVolumes"] = [];
    }

    level.poi[poiname]["tierOverrideVolumes"][level.poi[poiname]["tierOverrideVolumes"].size] = volume;
  }
}

function tieroverride_checkorigin(origin, poiname) {
  if(!poi_ispoiactive(poiname)) {
    return;
  }

  if(!isDefined(origin)) {
    return;
  }

  if(isDefined(level.poi[poiname]["tierOverrideVolumes"])) {
    foreach(volume in level.poi[poiname]["tierOverrideVolumes"]) {
      if(ispointinvolume(origin, volume)) {
        return level.var_28af753def4ab495[volume.script_label];
      }
    }
  }
}

function subarea_findfromorigin(origin, poiname) {
  if(poi_issystemactive()) {
    if(!isDefined(poiname)) {
      poiname = poi_findpoioriginisin(origin);
    }

    if(isDefined(poiname) && isDefined(level.poi[poiname]) && isDefined(level.poi[poiname]["subAreas"])) {
      subarea = function_d795b532bedd6431(poiname, origin);

      if(isDefined(subarea)) {
        return subarea;
      }
    }

    return function_6a35e8934f78d810(poiname);
  }
}

function function_6a35e8934f78d810(poiname) {
  if(poi_issystemactive()) {
    if(!isDefined(poiname)) {
      return undefined;
    }

    if(isDefined(level.poi[poiname])) {
      foreach(subarea in level.poi[poiname]["subAreas"]) {
        if(subarea.var_71ad22c5d093d90b == "orphan") {
          return subarea;
        }
      }
    }
  }
}

function subarea_findandassignforagent(agent, poiname, destination) {
  origin = agent.origin;

  if(isDefined(destination)) {
    origin = destination;
  }

  subarea = subarea_findfromorigin(origin, poiname);

  if(isDefined(subarea)) {
    subarea.var_3ebb6024e3f220ca[subarea.var_3ebb6024e3f220ca.size] = agent;
    agent.subarea = subarea;
    agentpers_setagentpersdata(agent, "subArea", subarea);
  }
}

function subarea_findandassignfordormancyid(origin, poiname, destination, dormancyid) {
  if(!isDefined(level.var_879053468f168806[dormancyid])) {
    return;
  }

  if(isDefined(destination)) {
    origin = destination;
  }

  subarea = subarea_findfromorigin(origin, poiname);
  level.var_879053468f168806[dormancyid].subarea = subarea;

  if(isDefined(subarea)) {
    subarea.var_3ebb6024e3f220ca[subarea.var_3ebb6024e3f220ca.size] = dormancyid;
  }
}

function subarea_removeagentfrom(agent, subarea) {
  subarea.var_3ebb6024e3f220ca = function_f3d88b5d7353a90(subarea.var_3ebb6024e3f220ca, agent);
}

function subarea_checkforreinforcementshutdown(poiname) {
  if(poi_issystemactive()) {
    if(!isDefined(poiname)) {
      return;
    }

    foreach(subarea in level.poi[poiname]["subAreas"]) {
      var_cab6f6d27832069a = subarea.var_7da9883d4168b7f1.var_cab6f6d27832069a;

      if(isDefined(var_cab6f6d27832069a)) {
        continue;
      }

      if(!isDefined(subarea.shutdowndeathcount)) {
        subarea.shutdowninterval = int(subarea.var_7da9883d4168b7f1.var_63e6c2f5f608f74e * level.var_6d6312580311c77c);
        subarea.shutdowndeathcount = subarea.shutdowninterval;
      }

      if(istrue(subarea.isshutdown)) {
        if(subarea.shutdowntime + level.var_64e7362f9d520136 < gettime()) {
          subarea.isshutdown = 0;
          subarea.shutdowndeathcount = subarea.agentdeaths + subarea.shutdowninterval;
        }

        continue;
      }

      if(subarea.agentdeaths >= subarea.shutdowndeathcount) {
        subarea.isshutdown = 1;
        subarea.shutdowntime = gettime();
      }
    }
  }
}

function subarea_orderagentarraysubareafirst(subarea, array) {
  var_de1ef71d45ad3463 = [];
  var_e293f8f41792af61 = [];

  foreach(agent in array) {
    var_d6a935a3a4e7c7d1 = undefined;

    if(!isagent(agent)) {
      origin = level.var_879053468f168806[agent].origin;
      poiname = level.var_879053468f168806[agent].poi;
      var_d6a935a3a4e7c7d1 = subarea_findfromorigin(origin, poiname);
    } else {
      var_d6a935a3a4e7c7d1 = agentpers_getagentpersdata(agent, "subArea");
    }

    if(!isDefined(var_d6a935a3a4e7c7d1)) {
      continue;
    }

    if(isDefined(subarea) && var_d6a935a3a4e7c7d1 == subarea) {
      var_de1ef71d45ad3463[var_de1ef71d45ad3463.size] = agent;
      continue;
    }

    var_e293f8f41792af61[var_e293f8f41792af61.size] = agent;
  }

  newarray = array_combine(var_de1ef71d45ad3463, var_e293f8f41792af61);
  return newarray;
}

function subarea_spawnagentpackages(subarea) {
  subarea.var_d276b08c96430bfc = array_randomize(subarea.var_d276b08c96430bfc);

  foreach(spawnpackage in subarea.var_d276b08c96430bfc) {
    function_376608277aa1067c(spawnpackage, subarea.var_7da9883d4168b7f1.var_84ecaeab58167d39, undefined, "medium", subarea.poi, subarea);
  }

  function_976521b91d6e7e81(subarea);
  function_e0389c76602a47b5(subarea);
  subarea.var_24a2cd19eed8f75d = array_randomize(subarea.var_24a2cd19eed8f75d);
  var_cc08ce7cbe6143ab = 0;
  continueon = 1;
  var_fd177c6ecc7e47 = subarea.var_7da9883d4168b7f1.var_f1bab2a8fa8fe3f0;

  if(!isDefined(var_fd177c6ecc7e47)) {
    var_fd177c6ecc7e47 = 1;
  }

  while(subarea.var_3ebb6024e3f220ca.size < subarea.var_7da9883d4168b7f1.var_74fd03286daecf85 && continueon) {
    spawnpackage = subarea.var_24a2cd19eed8f75d[var_cc08ce7cbe6143ab];

    if(isDefined(spawnpackage) && !istrue(spawnpackage.spawned)) {
      agents = function_376608277aa1067c(spawnpackage, subarea.var_7da9883d4168b7f1.var_84ecaeab58167d39, undefined, undefined, subarea.poi, subarea);

      if(isDefined(agents) && agents.size > 0) {
        var_cc08ce7cbe6143ab++;
      }

      continue;
    }

    continueon = 0;
  }
}

function function_976521b91d6e7e81(subarea) {
  if(!isDefined(subarea.var_78b67865ef2a33d3)) {
    return;
  }

  numspawned = 0;
  index = 0;
  subarea.var_78b67865ef2a33d3 = array_randomize(subarea.var_78b67865ef2a33d3);

  if(isDefined(subarea.var_7da9883d4168b7f1.var_1832752381c598da)) {
    while(subarea.var_3ebb6024e3f220ca.size < subarea.var_7da9883d4168b7f1.var_74fd03286daecf85 && numspawned < subarea.var_7da9883d4168b7f1.var_1832752381c598da) {
      spawnloc = subarea.var_78b67865ef2a33d3[index];

      if(!isDefined(spawnloc)) {
        return;
      }

      spawnloc.script_noteworthy = "guard_sniper";
      agent = spawnguard(spawnloc, 0, undefined, "medium", "spawnPackage", undefined, subarea.poi, subarea);

      if(isDefined(agent)) {
        numspawned++;
        index++;
      }
    }
  }

  numspawned = 0;

  if(isDefined(subarea.var_7da9883d4168b7f1.var_fe9d8027d120b1b6)) {
    while(subarea.var_3ebb6024e3f220ca.size < subarea.var_7da9883d4168b7f1.var_74fd03286daecf85 && numspawned < subarea.var_7da9883d4168b7f1.var_fe9d8027d120b1b6) {
      spawnloc = subarea.var_78b67865ef2a33d3[index];

      if(!isDefined(spawnloc)) {
        return;
      }

      spawnloc.script_noteworthy = "guard_rpg";
      agent = spawnguard(spawnloc, 0, undefined, "medium", "spawnPackage", undefined, subarea.poi, subarea);

      if(isDefined(agent)) {
        numspawned++;
        index++;
      }
    }
  }
}

function function_e0389c76602a47b5(subarea) {
  if(!isDefined(subarea.var_2976480563de74df)) {
    return;
  }

  if(!isDefined(subarea.var_7da9883d4168b7f1.var_a766d7c366509879) || !isDefined(subarea.var_7da9883d4168b7f1.var_a743e9c3662a7857)) {
    return;
  }

  var_3682d28df3caf8b0 = 0;
  index = 0;
  subarea.var_2976480563de74df = array_randomize(subarea.var_2976480563de74df);
  var_66fe80516790f17d = randomintrange(subarea.var_7da9883d4168b7f1.var_a766d7c366509879, subarea.var_7da9883d4168b7f1.var_a743e9c3662a7857 + 1);

  while(subarea.var_3ebb6024e3f220ca.size < subarea.var_7da9883d4168b7f1.var_74fd03286daecf85 && var_3682d28df3caf8b0 < var_66fe80516790f17d) {
    spawnloc = subarea.var_2976480563de74df[index];

    if(!isDefined(spawnloc)) {
      return;
    }

    patrolstruct = function_9edcf99159abb0b(spawnloc);

    if(!isDefined(patrolstruct)) {
      return;
    }

    patrolstruct.claimed = 1;
    agents = spawnpatrol(patrolstruct, undefined, undefined, undefined, "medium", "spawnPackage");

    if(isDefined(agents)) {
      var_3682d28df3caf8b0++;
      index++;
    }
  }
}

function function_376608277aa1067c(spawnpackage, var_84ecaeab58167d39, var_9e82f18de5c8c18b, priorityoverride, poiname, subarea) {
  if(istrue(spawnpackage.spawned)) {
    return;
  }

  priority = "low";

  if(isDefined(priorityoverride)) {
    priority = priorityoverride;
  }

  spawnednum = 0;
  spawnpackage.spawned = 1;
  var_709ba5ebd730ffae = [];

  foreach(guardnode in spawnpackage.guardnodes) {
    if(isDefined(var_9e82f18de5c8c18b) && spawnednum >= var_9e82f18de5c8c18b) {
      return spawnednum;
    }

    if(!isDefined(guardnode.nationality)) {
      guardnode.nationality = spawnpackage.nationality;
    }

    isstationary = issubstr(guardnode.script_noteworthy, "stationary");
    agent = spawnguard(guardnode, isstationary, undefined, priority, "spawnPackage", undefined, poiname, subarea);

    if(isDefined(agent)) {
      spawnednum++;
      var_709ba5ebd730ffae[var_709ba5ebd730ffae.size] = agent;
    }
  }

  foreach(pathstruct in spawnpackage.pathstructs) {
    if(isDefined(var_9e82f18de5c8c18b) && spawnednum >= var_9e82f18de5c8c18b) {
      return spawnednum;
    }

    if(isDefined(pathstruct.path) && isDefined(pathstruct.path[0]) && !isDefined(pathstruct.path[0].nationality)) {
      pathstruct.path[0].nationality = spawnpackage.nationality;
    }

    agents = spawnpatrol(pathstruct, undefined, undefined, undefined, priority, "spawnPackage");

    if(isDefined(agents)) {
      spawnednum += agents.size;
      var_709ba5ebd730ffae = array_combine(var_709ba5ebd730ffae, agents);
    }
  }

  if(getdvarint(@ "hash_5fc378f6fc9470f7", 0)) {
    foreach(civnode in spawnpackage.civnodes) {
      namespace_c50aac14f506294b::spawn_civilian(civnode, undefined, undefined, undefined, undefined, 1, undefined, "low");
    }
  }

  return var_709ba5ebd730ffae;
}

function function_96b95ad2d758c110() {
  if(isDefined(level.gamemodebundle)) {
    if(istrue(level.gamemodebundle.var_1a33770ee84f49e6)) {
      return true;
    } else if(istrue(level.gamemodebundle.var_24831563e72cb3cb)) {
      return true;
    }
  }

  return false;
}

function processagentspawned(agent, var_80f4bde7090a4773) {
  if(!isDefined(agent)) {
    return;
  }

  function_ea83c1b372e16f6d(agent, var_80f4bde7090a4773);

  if(isint(agent)) {
    function_58aab2edaec2599f(agent, "processSpawnedDormantAgent", &processspawneddormantagent);
    return;
  }

  tier = 1;
  var_f0eff45e6fd10d70 = 1;

  if(issubstr(agent.agent_type, "jugg")) {
    function_e43f4000cac35ba2(agent);
    subtype = undefined;

    if(issubstr(agent.agent_type, "merc")) {
      subtype = "merc";
    }

    agent scripts\cp_mp\agents\agent_juggernaut::function_1cbb19fc0caeab00(subtype);
    agent setscriptablepartstate("loop_sounds", "music", 0);
    var_f0eff45e6fd10d70 = 0;
  }

  if(getDvar(@ "ui_gametype", "") == "gwtdm" || !isDefined(level.gamemodebundle) || istrue(level.gamemodebundle.var_99eef12e9fe7e8f4)) {
    if(issubstr(agent.agent_type, "tier1")) {
      overridetier1(agent);
    } else if(issubstr(agent.agent_type, "tier2")) {
      overridetier2(agent);
      tier = 2;
    } else if(issubstr(agent.agent_type, "tier3")) {
      overridetier3(agent);
      tier = 3;
    }
  } else if(!issubstr(agent.agent_type, "jugg")) {
    function_d0738ca403de13f2(agent);
  }

  if(issubstr(agent.agent_type, "riotshield")) {
    overrideriotshield(agent);
    var_f0eff45e6fd10d70 = 0;
  }

  if(isDefined(var_80f4bde7090a4773) && tolower(var_80f4bde7090a4773) == "elite") {
    function_1828f1e20e52b418(agent, tier);
  }

  if(istrue(var_f0eff45e6fd10d70)) {
    agent function_8bbcaeb23a1512ef("all", 1);
    agent function_859a90c664dba240(1);
  }

  type_token = strtok(agent.agent_type, "_");
  tok = type_token[3];

  if(isDefined(level.var_9f0b40fbeb9cdde2) && array_contains_key(level.var_9f0b40fbeb9cdde2, tok)) {
    var_64c6ced6d550cd33 = level.var_9f0b40fbeb9cdde2[tok];
    agent function_77b8b5af85f319d8(var_64c6ced6d550cd33);
  }

  if(isDefined(level.var_a3941b9965bdd8d2)) {
    [[level.var_a3941b9965bdd8d2]](agent);
  }
}

function function_95c315b1e51bd9c5(subarea, delay) {
  if(!isDefined(subarea)) {
    return;
  }

  if(!isDefined(delay)) {
    delay = 0;
  }

  wait delay;
  subarea.agentdeaths++;
}

function processspawneddormantagent(agent) {}

function set_maxsightdistsquared(value) {
  self.maxsightdistsqrd = value;
}

function function_d0738ca403de13f2(agent) {
  armor = 0;
  agent.var_685390c6753c2cc7 = 1;
  helmet = undefined;

  if(isDefined(agent.subclass)) {
    if(agent.subclass == "tier1") {
      armor = 200;
      agent.var_7cea08b66b2ad878 = 0;
    } else if(agent.subclass == "tier2") {
      armor = 400;
      agent.var_7cea08b66b2ad878 = 0;
      helmet = 1;
    } else if(agent.subclass == "tier3") {
      armor = 600;
      agent.var_7cea08b66b2ad878 = 0;
      helmet = 3;
    }

    if(agent.subclass == "exgm_captain") {
      var_84ecaeab58167d39 = 1;

      if(isDefined(agent.subarea) && isDefined(agent.subarea.var_32c28e2c26896555)) {
        var_84ecaeab58167d39 = agent.subarea.var_7da9883d4168b7f1.var_84ecaeab58167d39;
      }

      switch (var_84ecaeab58167d39) {
        case 3:
          armor = 600;
          agent.var_7cea08b66b2ad878 = 1;
          break;
        case 2:
          armor = 400;
          agent.var_7cea08b66b2ad878 = 1;
          break;
        case 1:
          armor = 200;
          agent.var_7cea08b66b2ad878 = 1;
          break;
        default:
          break;
      }
    }
  }

  agent function_c37c4f9d687074ff(undefined, undefined, undefined, undefined, undefined, armor, helmet);
}

function reinforce_init() {
  setDvar(@ "hash_3c77de36070e314c", 0);
  level.var_ba36989c7e24e4ff = getdvarint(@ "hash_b0cde04af6f25f1a", 0);

  level.reinforcementoptions = spawnStruct();
  level.reinforcementoptions.disablelist = [];

  if(getdvarint(@ "hash_be15dbb5db51168a", 0)) {
    level.reinforcementoptions.disablelist[level.reinforcementoptions.disablelist.size] = "heli";
  }

  if(getdvarint(@ "hash_ef18872f775cbf51", 0)) {
    level.reinforcementoptions.disablelist[level.reinforcementoptions.disablelist.size] = "ground";
  }

  if(getdvarint(@ "hash_af2a5bcfeab0313a", 0)) {
    level.reinforcementoptions.disablelist[level.reinforcementoptions.disablelist.size] = "closet";
  }

  if(getdvarint(@ "hash_5ba4da9311ec46d", 0)) {
    level.reinforcementoptions.disablelist[level.reinforcementoptions.disablelist.size] = "para";
  }

  if(getdvarint(@ "hash_e61c7be770ae9de8", 1)) {
    level.reinforcementoptions.disablelist[level.reinforcementoptions.disablelist.size] = "elevator";
  }

  level.reinforcementoptions.var_445e0eedd2ec048b = [];

  if(getdvarint(@ "hash_a00601dc39bf335d", 0)) {
    level.reinforcementoptions.var_445e0eedd2ec048b[level.reinforcementoptions.var_445e0eedd2ec048b.size] = "sedan";
  }

  if(getdvarint(@ "hash_606c2b2d9e94162d", 0)) {
    level.reinforcementoptions.var_445e0eedd2ec048b[level.reinforcementoptions.var_445e0eedd2ec048b.size] = "overland";
  }

  if(getdvarint(@ "hash_a116a13b4ae556c2", 0)) {
    level.reinforcementoptions.var_445e0eedd2ec048b[level.reinforcementoptions.var_445e0eedd2ec048b.size] = "cargo";
  }

  if(getdvarint(@ "hash_caad3249a4af6b4b", 0)) {
    level.reinforcementoptions.var_445e0eedd2ec048b[level.reinforcementoptions.var_445e0eedd2ec048b.size] = "techo";
  }

  if(getdvarint(@ "hash_c6458de3ac612272", 0)) {
    level.reinforcementoptions.var_445e0eedd2ec048b[level.reinforcementoptions.var_445e0eedd2ec048b.size] = "jltv";
  }

  level.reinforcementoptions.var_8f0798696a41da93 = getdvarint(@ "hash_6cf658b24a4f657", 5);
  level.reinforcementoptions.var_533cfe7944a02b81 = getdvarint(@ "hash_fa2b8ab8386f3df2", 3);
  level.var_f51af0d7efeddf0f = getDvar(@ "hash_a8e4f619345dd4f", "none");
  level.reinforcementoptions.var_1432bd2b78dbed76 = [];
  level.reinforcementoptions.var_1432bd2b78dbed76[0] = ["tier1_ground", "tier1_closet"];
  level.reinforcementoptions.var_1432bd2b78dbed76["0_chance"] = [50, 50];
  level.reinforcementoptions.var_1432bd2b78dbed76[1] = ["tier1_ground", "tier1_closet"];
  level.reinforcementoptions.var_1432bd2b78dbed76["1_chance"] = [50, 50];
  level.reinforcementoptions.var_1432bd2b78dbed76[2] = ["tier1_ground", "tier2_ground", "tier2_heli", "tier1_closet"];
  level.reinforcementoptions.var_1432bd2b78dbed76["2_chance"] = [10, 10, 15, 40];
  level.reinforcementoptions.var_1432bd2b78dbed76[3] = ["tier2_ground", "tier2_heli", "tier2_closet"];
  level.reinforcementoptions.var_1432bd2b78dbed76["3_chance"] = [33, 44, 23];
  level.reinforcementoptions.var_1432bd2b78dbed76[4] = ["tier3_ground", "tier3_heli", "tier3_para_c130", "tier3_closet"];
  level.reinforcementoptions.var_1432bd2b78dbed76["4_chance"] = [10, 10, 40, 25];
  level.reinforcementoptions.bydifficulty = [];
  level.reinforcementoptions.bydifficulty[1] = ["tier1_heli", "tier1_ground", "tier1_closet"];
  level.reinforcementoptions.bydifficulty["1_chance"] = [35, 55, 10];
  level.reinforcementoptions.bydifficulty[2] = ["tier2_ground", "tier2_heli"];
  level.reinforcementoptions.bydifficulty["2_chance"] = [35, 65];
  level.reinforcementoptions.bydifficulty[3] = ["tier3_ground", "tier3_heli", "tier3_para_c130"];
  level.reinforcementoptions.bydifficulty["3_chance"] = [40, 60, 15];
  level.reinforcementoptions.var_5b02052a040e1210 = [];
  level.reinforcementoptions.var_5b02052a040e1210[0] = "tier1_heli";
  level.reinforcementoptions.var_5b02052a040e1210[1] = "tier1_heli";
  level.reinforcementoptions.var_5b02052a040e1210[2] = "tier2_heli";
  level.reinforcementoptions.var_5b02052a040e1210[3] = "tier2_heli";
  level.reinforcementoptions.var_5b02052a040e1210[4] = "tier3_heli";
  level.reinforcementoptions.var_9ff30f8c5842928f = [];
  level.reinforcementoptions.var_9ff30f8c5842928f[1] = "tier1_heli";
  level.reinforcementoptions.var_9ff30f8c5842928f[2] = "tier2_heli";
  level.reinforcementoptions.var_9ff30f8c5842928f[3] = "tier3_heli";
  level.reinforcementoptions.var_87f044eda76ae14a = [];
  level.reinforcementoptions.var_87f044eda76ae14a["tier1"] = ["sedan", "overland"];
  level.reinforcementoptions.var_87f044eda76ae14a["tier2"] = ["overland", "cargo"];
  level.reinforcementoptions.var_87f044eda76ae14a["tier3"] = ["jltv", "techo"];
  level.reinforcementoptions.var_48d4812167fbb628 = [];
  level.reinforcementoptions.var_48d4812167fbb628["veh9_sedan_hatchback_1985"] = ["black"];
  level.reinforcementoptions.var_48d4812167fbb628["veh9_overland_2016"] = ["black"];
  level.reinforcementoptions.var_48d4812167fbb628["veh9_mil_cargo_truck"] = ["black"];
  level.reinforcementoptions.var_48d4812167fbb628["veh9_jltv"] = ["shdw"];
  level.var_28ddeb5728c40aa2 = 1048576;
  level.var_2ceafe81d4233d2b = 7000;
  function_edfc4cc2d317c6c1();
}

function function_edfc4cc2d317c6c1() {
  if(level.reinforcementoptions.disablelist.size == 0) {
    return;
  }

  foreach(starlevel, var_794c60ca9377a38d in level.reinforcementoptions.var_1432bd2b78dbed76) {
    var_34d5caa5c1ff84ce = [];
    var_7033eacc35da81a7 = [];

    if(!isint(starlevel)) {
      continue;
    }

    foreach(index, optiontype in var_794c60ca9377a38d) {
      tokens = strtok(optiontype, "_");

      if(!array_contains(level.reinforcementoptions.disablelist, tokens[1])) {
        var_34d5caa5c1ff84ce[var_34d5caa5c1ff84ce.size] = optiontype;
        var_7033eacc35da81a7[var_7033eacc35da81a7.size] = level.reinforcementoptions.var_1432bd2b78dbed76[starlevel + "_chance"][index];
      }
    }

    level.reinforcementoptions.var_1432bd2b78dbed76[starlevel] = var_34d5caa5c1ff84ce;
    level.reinforcementoptions.var_1432bd2b78dbed76[starlevel + "_chance"] = var_7033eacc35da81a7;
  }

  foreach(difficultylevel, var_ab614b4f9329340c in level.reinforcementoptions.bydifficulty) {
    var_34d5caa5c1ff84ce = [];
    var_7033eacc35da81a7 = [];

    if(!isint(difficultylevel)) {
      continue;
    }

    foreach(index, optiontype in var_ab614b4f9329340c) {
      tokens = strtok(optiontype, "_");

      if(!array_contains(level.reinforcementoptions.disablelist, tokens[1])) {
        var_34d5caa5c1ff84ce[var_34d5caa5c1ff84ce.size] = optiontype;
        var_7033eacc35da81a7[var_7033eacc35da81a7.size] = level.reinforcementoptions.bydifficulty[difficultylevel + "_chance"][index];
      }
    }

    level.reinforcementoptions.bydifficulty[difficultylevel] = var_34d5caa5c1ff84ce;
    level.reinforcementoptions.bydifficulty[difficultylevel + "_chance"] = var_7033eacc35da81a7;
  }
}

function function_77acc10c4823dd8a(numagents, reinforceorigin, priority, category, subcategory, groupname, team, var_93390a6953905fef, poiname, reinforcementtype, goalradius, var_21f24aecb313e479, var_ec862c2c00c7ab5d, nationality) {
  if(!istrue(level.supportsai)) {
    return;
  }

  if(isDefined(level.radiation) && istrue(level.radiation.spreading)) {
    return;
  }

  assert(scripts\mp\flags::gameflagexists("<dev string:xbd0>") && scripts\mp\flags::gameflag("<dev string:xbd0>"), "<dev string:xbe1>");
  agents = [];

  if(!isDefined(team)) {
    if(isDefined(level.var_4b195d3dd0024b9c)) {
      team = level.var_4b195d3dd0024b9c;
    } else {
      team = "team_hundred_ninety_five";
    }
  }

  if(!isDefined(reinforcementtype)) {
    reinforcementtype = "Unknown";
  }

  reinforcementoptions = undefined;
  var_206197e10a7a9e87 = undefined;
  fallback = undefined;

  if(isDefined(var_ec862c2c00c7ab5d)) {
    numagents = var_ec862c2c00c7ab5d.numagents;
    reinforcementtype = var_ec862c2c00c7ab5d.reinforcementtype;
    reinforcementoptions = [var_ec862c2c00c7ab5d.reinforcementtype];
    var_206197e10a7a9e87 = [100];
  } else if(reinforcementtype == "Unknown") {
    var_6b9806915982d089 = undefined;

    if(poi_issystemactive()) {
      if(!isDefined(poiname)) {
        poiname = poi_findpoioriginisin(reinforceorigin);
      }

      subarea = subarea_findfromorigin(reinforceorigin, poiname);

      if(isDefined(subarea)) {
        var_6b9806915982d089 = subarea.var_7da9883d4168b7f1.var_84ecaeab58167d39;
      }
    }

    if(isDefined(nationality) && nationality == "merc" && issubstr(level.mapname, "saba")) {
      reinforcementoptions = ["tier1_heli", "tier2_heli", "tier3_heli", "tier3_para_c130", "tier3_closet"];
      var_206197e10a7a9e87 = [15, 45, 25, 15, 5];
      fallback = "tier1_heli_lbravo";
    } else {
      starlevel = function_5cc0c507e92f7b47(poiname);
      reinforcementoptions = level.reinforcementoptions.var_1432bd2b78dbed76[starlevel];
      var_206197e10a7a9e87 = level.reinforcementoptions.var_1432bd2b78dbed76[starlevel + "_chance"];
      fallback = level.reinforcementoptions.var_5b02052a040e1210[starlevel];

      if(isDefined(var_6b9806915982d089) && var_6b9806915982d089 > starlevel) {
        reinforcementoptions = level.reinforcementoptions.bydifficulty[var_6b9806915982d089];
        var_206197e10a7a9e87 = level.reinforcementoptions.bydifficulty[var_6b9806915982d089 + "_chance"];
        fallback = level.reinforcementoptions.var_9ff30f8c5842928f[var_6b9806915982d089];
      }

      if(scripts\mp\gametypes\br_gametype_dmz::function_7a7aa3b5455f0412(poiname)) {
        reinforcementoptions[reinforcementoptions.size] = "tier3_para_c130";
        var_206197e10a7a9e87[var_206197e10a7a9e87.size] = 60;
      }
    }
  }

  if(reinforcementtype != "Unknown") {
    agents = function_2f3b04fc531b4115(numagents, reinforceorigin, priority, category, subcategory, groupname, team, var_93390a6953905fef, poiname, reinforcementtype, goalradius, var_21f24aecb313e479, var_ec862c2c00c7ab5d, nationality);
  } else {
    while(reinforcementoptions.size > 0 && (!isDefined(agents) || agents.size == 0)) {
      index = function_9b23664358b0ecc2(reinforcementoptions, var_206197e10a7a9e87);
      reinforcementtype = reinforcementoptions[index];

      if(!isDefined(var_ec862c2c00c7ab5d)) {
        tier = int(getsubstr(reinforcementtype, 4, 5));
        var_ec862c2c00c7ab5d = function_ab14d6652e44fda0(numagents, undefined, tier, level.var_c0e1de2e14e458bf);
      }

      agents = function_2f3b04fc531b4115(numagents, reinforceorigin, priority, category, subcategory, groupname, team, var_93390a6953905fef, poiname, reinforcementtype, goalradius, var_21f24aecb313e479, var_ec862c2c00c7ab5d, nationality);

      if(!isDefined(agents) || agents.size == 0) {
        reinforcementoptions = array_remove_index(reinforcementoptions, index);
        var_206197e10a7a9e87 = array_remove_index(var_206197e10a7a9e87, index);

        if(reinforcementoptions.size == 0 && isDefined(fallback)) {
          if(istrue(level.var_ba36989c7e24e4ff)) {
            println("<dev string:xc67>" + poiname + "<dev string:xc7e>");
          }

          reinforcementoptions = [fallback];
          var_206197e10a7a9e87 = [100];
          fallback = undefined;
        }

        continue;
      }

      break;
    }
  }

  if(isDefined(agents) && isarray(agents) && agents.size > 0) {
    if(poi_issystemactive() && !isDefined(poiname) && isDefined(agents[0].poi)) {
      poiname = agents[0].poi;
    }

    function_96b7b6431450dfc0(agents.size, poiname);

    if(isDefined(level.var_d1a95e3c3d6ea9fc)) {
      level thread function_346caf10322931c8(poiname, reinforceorigin);
    }
  }

  if(isDefined(agents) && isDefined(agents[0]) && isai(agents[0])) {
    agents[0].reinforcementtype = reinforcementtype;
  }

  return agents;
}

function function_2f3b04fc531b4115(numagents, reinforceorigin, priority, category, subcategory, groupname, team, var_93390a6953905fef, poiname, reinforcementtype, goalradius, var_21f24aecb313e479, var_ec862c2c00c7ab5d, nationality) {
  agents = undefined;
  vehicle = undefined;

  if(isDefined(nationality)) {
    team = scripts\cp_mp\agents\agent_utils::function_30a0d7ca3fae40cc(nationality);
  }

  if(issubstr(reinforcementtype, "closet") || reinforcementtype == "Monster Closet") {
    agents = function_9ea6eddb437eaca5(numagents, reinforceorigin, priority, category, subcategory, groupname, team, var_93390a6953905fef, poiname, undefined, undefined, undefined, nationality);
  } else if((issubstr(reinforcementtype, "ground") || reinforcementtype == "Ground Vehicle") && istrue(level.var_ce783fc59ea392d1)) {
    if(!istrue(level.reinforcementoptions.var_a0aa36163157d746)) {
      level.reinforcementoptions.var_a0aa36163157d746 = 1;

      foreach(index, tier in level.reinforcementoptions.var_87f044eda76ae14a) {
        level.reinforcementoptions.var_87f044eda76ae14a[index] = array_remove_array(tier, level.reinforcementoptions.var_445e0eedd2ec048b);
      }
    }

    if(isDefined(level.var_f51af0d7efeddf0f) && level.var_f51af0d7efeddf0f != "none") {
      vehicleoverride = level.var_f51af0d7efeddf0f;
    } else {
      vehicletier = getsubstr(reinforcementtype, 0, 5);

      if(!isDefined(level.reinforcementoptions.var_87f044eda76ae14a[vehicletier])) {
        if(isDefined(var_ec862c2c00c7ab5d) && isDefined(var_ec862c2c00c7ab5d.requests[0]) && isDefined(var_ec862c2c00c7ab5d.requests[0].tier)) {
          vehicletier = "tier" + var_ec862c2c00c7ab5d.requests[0].tier;
        } else {
          vehicletier = "tier" + function_8af522ada68b6477(undefined, poiname, reinforceorigin);
        }
      }

      vehicleoverride = random(level.reinforcementoptions.var_87f044eda76ae14a[vehicletier]);
    }

    [vehicle, agents] = namespace_43bf74a2ee9234c0::function_a5b0665e0a814be6(numagents, var_ec862c2c00c7ab5d, reinforceorigin, priority, category, subcategory, groupname, team, var_93390a6953905fef, poiname, nationality, vehicleoverride);
  } else if((issubstr(reinforcementtype, "heli") || reinforcementtype == "Helicopter") && istrue(level.var_425df8e23aaef18c)) {
    agents = scripts\mp\ai_heli_reinforce::function_3779deb97b61a65(numagents, reinforceorigin, priority, category, subcategory, groupname, team, var_93390a6953905fef, poiname, goalradius, var_21f24aecb313e479, var_ec862c2c00c7ab5d, undefined, undefined, nationality, undefined);
  } else if((issubstr(reinforcementtype, "para") || reinforcementtype == "Paratroopers") && isDefined(level.parareinforcestruct)) {
    minagents = level.reinforcementoptions.var_8f0798696a41da93;

    if(scripts\mp\gametypes\br_gametype_dmz::function_7a7aa3b5455f0412(poiname)) {
      minagents = level.reinforcementoptions.var_533cfe7944a02b81;
    }

    if(numagents >= minagents) {
      agents = namespace_885300a47c2b51e6::function_55ab9c6da96226e7(numagents, reinforceorigin, 10000, var_ec862c2c00c7ab5d, priority, category, subcategory, team, var_93390a6953905fef, poiname, undefined, undefined, undefined, undefined, undefined, undefined, nationality);
    }
  } else if((issubstr(reinforcementtype, "elevator") || reinforcementtype == "Elevator") && (istrue(level.var_b212a36bec6cf8da) || isDefined(level.reinforceelevators))) {
    agents = namespace_ab6776a0c2e19905::function_892161ab9ad430e3(numagents, var_ec862c2c00c7ab5d, reinforceorigin, priority, category, subcategory, groupname, team, var_93390a6953905fef, poiname, undefined, undefined, undefined, nationality);
  }

  if(getdvarint(@ "hash_3c77de36070e314c", 0) == 1) {
    if(isDefined(agents) && isDefined(agents[0]) && isalive(agents[0])) {
      startorigin = agents[0].origin;

      if(isDefined(vehicle)) {
        startorigin = vehicle.origin;
        level thread function_e060fb3d7177aea7(vehicle, 30);
      } else if(isDefined(agents[0].vehicle)) {
        startorigin = agents[0].vehicle.origin;
        level thread function_e060fb3d7177aea7(agents[0].vehicle, 30);
      }

      level thread scripts\mp\utility\debug::drawsphere(startorigin, 128, 30, (0, 1, 0));
      level thread scripts\cp_mp\utility\debug_utility::drawline(startorigin, reinforceorigin, 30, (1, 1, 1));
    }

    level thread scripts\mp\utility\debug::drawsphere(reinforceorigin, 128, 30, (1, 0, 0));
  }

  data = spawnStruct();
  data.agents = agents;
  data.poi = poiname;
  data.origin = reinforceorigin;
  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_dmz_on_reinforce", data);
  return agents;
}

function function_9b23664358b0ecc2(reinforcementoptions, var_206197e10a7a9e87) {
  totaltickets = 0;

  foreach(itemtickets in var_206197e10a7a9e87) {
    totaltickets += itemtickets;
  }

  roll = randomint(totaltickets);
  ticketschecked = 0;

  foreach(index, reinforcementtype in reinforcementoptions) {
    ticketschecked += var_206197e10a7a9e87[index];

    if(roll < ticketschecked) {
      return index;
    }
  }
}

function function_9ea6eddb437eaca5(numagents, reinforceorigin, priority, category, subcategory, groupname, team, var_93390a6953905fef, poiname, var_180734f7c2a9866f, var_f03b10101d704759, var_fb59c1ab2600d2f6, nationality, var_15383a2c0ba96765) {
  if(isDefined(level.radiation) && istrue(level.radiation.spreading)) {
    return;
  }

  reinforceorigin = scripts\mp\ai_behavior::function_d378cc95abab583b(reinforceorigin, poiname);
  reinforceorigin = function_61cbc488b27a6e61(reinforceorigin);

  if(!isDefined(poiname)) {
    poiname = scripts\mp\poi::poi_findpoioriginisin(reinforceorigin);
  }

  fortress = function_9c5a68ca1385322e(reinforceorigin, poiname, var_180734f7c2a9866f, var_f03b10101d704759, undefined, var_15383a2c0ba96765);

  if(!isDefined(fortress) || !isDefined(fortress.spawnclosetnodes)) {
    return undefined;
  }

  spawnlocs = fortress.spawnclosetnodes;
  agents = [];
  starlevel = function_5cc0c507e92f7b47(poiname);
  var_fcdc7f62624c71ff = "guard";

  foreach(loc in spawnlocs) {
    loc.script_noteworthy = undefined;
    tier = function_aa34a142b7664dd1(function_5cc0c507e92f7b47(poiname));

    if(tier != 1 && tier != 2 && tier != 3) {
      tier = 1;
    }

    aitype = function_d5bc07eabf352abb(loc, undefined, var_fcdc7f62624c71ff, undefined, tier, nationality);
    agents[agents.size] = ai_mp_requestspawnagent(aitype, loc.origin, loc.angles, "medium", "reinforcements", "closetSpawn", "closetSpawn", team, undefined, poiname);

    if(agents.size >= numagents) {
      break;
    }
  }

  foreach(agent in agents) {
    agent thread function_a5117518725da028(agent, reinforceorigin, var_fb59c1ab2600d2f6, undefined, undefined, 0);
  }

  return agents;
}

function function_9c5a68ca1385322e(origin, poiname, var_5477815d6f43aecf, maxdistfromorigin, var_b1a6a85296574c99, var_15383a2c0ba96765) {
  if(!isDefined(level.var_f1073fbd45b59a06)) {
    return;
  }

  if(!isDefined(level.var_f1073fbd45b59a06.var_7b0fe1ac52dd48e3)) {
    level.var_f1073fbd45b59a06.var_7b0fe1ac52dd48e3 = (getdvarint(@ "hash_5f174bbb593ef9f4", 60) + getdvarint(@ "hash_623de28f7e6a71a2", 10)) * 1000;
  }

  if(!isDefined(origin)) {
    return;
  }

  if(!isDefined(poiname)) {
    poiname = scripts\mp\poi::poi_findpoioriginisin(origin);
  }

  if(!isDefined(level.poi) || !isDefined(level.poi[poiname]) || !isDefined(level.poi[poiname]["players"]) || !isDefined(level.poi[poiname]["players"].size)) {
    return;
  }

  if(!isDefined(var_5477815d6f43aecf)) {
    var_5477815d6f43aecf = 2359296;
  } else {
    var_5477815d6f43aecf *= var_5477815d6f43aecf;
  }

  if(!isDefined(maxdistfromorigin)) {
    maxdistfromorigin = 21233664;
  } else {
    maxdistfromorigin *= maxdistfromorigin;
  }

  if(!isDefined(var_b1a6a85296574c99)) {
    var_b1a6a85296574c99 = 1048576;
  } else {
    var_b1a6a85296574c99 *= var_b1a6a85296574c99;
  }

  var_ce5b743e3b2dd235 = [];

  if(!istrue(var_15383a2c0ba96765)) {
    foreach(fortress in level.var_f1073fbd45b59a06.unusedfortresses) {
      if(!isDefined(fortress.poi)) {
        fortress.poi = scripts\mp\poi::poi_findpoioriginisin(fortress.origin);
      }

      if(fortress.poi == poiname) {
        var_ce5b743e3b2dd235[var_ce5b743e3b2dd235.size] = fortress;
      }
    }
  } else {
    var_ce5b743e3b2dd235 = level.var_f1073fbd45b59a06.unusedfortresses;
  }

  if(var_ce5b743e3b2dd235.size == 0) {
    return undefined;
  }

  var_ce5b743e3b2dd235 = sortbydistance(var_ce5b743e3b2dd235, origin);

  foreach(fortress in var_ce5b743e3b2dd235) {
    playertooclose = 0;

    if(level.poi[poiname]["players"].size == 0) {
      var_ce5b743e3b2dd235[0].var_842600f7224e9a7a = gettime() + level.var_f1073fbd45b59a06.var_7b0fe1ac52dd48e3;
      return var_ce5b743e3b2dd235[0];
    }

    if(function_fd909d6b5cd7d4d7(fortress)) {
      continue;
    }

    var_8c17b4ef1cf1b7e4 = distance2dsquared(origin, fortress.origin);

    if(var_8c17b4ef1cf1b7e4 < var_b1a6a85296574c99) {
      continue;
    } else if(var_8c17b4ef1cf1b7e4 > maxdistfromorigin) {
      break;
    } else {
      foreach(player in level.poi[poiname]["players"]) {
        var_2e6dbad7fb1fe43b = distance2dsquared(player.origin, fortress.origin);

        if(var_2e6dbad7fb1fe43b < var_5477815d6f43aecf) {
          playertooclose = 1;
          continue;
        }

        if(playertooclose) {
          break;
        }
      }
    }

    if(!playertooclose) {
      fortress.var_842600f7224e9a7a = gettime() + level.var_f1073fbd45b59a06.var_7b0fe1ac52dd48e3;
      return fortress;
    }
  }

  return undefined;
}

function function_fd909d6b5cd7d4d7(fortress) {
  if(!isDefined(fortress.var_842600f7224e9a7a)) {
    return false;
  }

  if(fortress.var_842600f7224e9a7a < gettime()) {
    return false;
  }

  return true;
}

function function_51014d65a15cf0f9() {
  if(getdvarint(@ "hash_c121e4a8e6b78c34", 0) == 1) {
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  level.var_d1a95e3c3d6ea9fc = getdvarint(@ "hash_3d859bf85679053c", 200) * 1000;
  level.var_e5fd74b71bdf51fa = [];
  level.var_1171d24dd4142369 = [];
  level.var_64e7362f9d520136 = getdvarint(@ "hash_599c5453cd5cd717", 180) * 1000;
  level.var_6d6312580311c77c = getdvarfloat(@ "hash_90240383479ef5f3", 1);

  if(poi_issystemactive()) {
    foreach(poiname, poi in level.poi) {
      level thread function_eaa1254a3231f38e(poiname);
    }

    return;
  }

  level thread function_30ef4d9086400a2d();
}

function function_eaa1254a3231f38e(poiname) {
  if(istrue(scripts\mp\gametypes\br_gametype_dmz::function_7a7aa3b5455f0412(poiname))) {
    level.var_41670c1c65f3d3cf.poi[poiname].var_5da316fb1c149f28 = 3;
    level.var_41670c1c65f3d3cf.poi[poiname].reinforcedelaytime = 15;
  } else {
    level.var_41670c1c65f3d3cf.poi[poiname].var_5da316fb1c149f28 = getdvarint(@ "hash_69535aa7c07dd140", 5);
  }

  level.var_41670c1c65f3d3cf.poi[poiname].reinforcementqueue = [];
  level.var_41670c1c65f3d3cf.poi[poiname].var_5531002f0448bfaf = [];
  level.var_41670c1c65f3d3cf.poi[poiname].reinforcementlocs = [];
  level.var_41670c1c65f3d3cf.poi[poiname].var_8bcd79921ba8147e = 0;
  level.var_41670c1c65f3d3cf.poi[poiname].var_9d2f71782a11c15c = 0;

  if(getdvarint(@ "hash_8ec821e080a0b50d", 1) == 1) {
    level.var_e5fd74b71bdf51fa[poiname] = gettime();
    level.var_1171d24dd4142369[poiname] = 0;
  }

  level.var_41670c1c65f3d3cf.poi[poiname].var_a87122636ff072d3 = "Initalizing";
  level thread function_e358232a03764c9b(poiname);

  if(istrue(scripts\mp\gametypes\br_gametype_dmz::function_7a7aa3b5455f0412(poiname))) {
    var_2acd3064a749d3bd = 1;
  } else {
    var_2acd3064a749d3bd = getdvarint(@ "hash_3bb3561ddb301247", 180) + randomintrange(0, 7);
  }

  level.var_41670c1c65f3d3cf.poi[poiname].var_a87122636ff072d3 = "Waiting for Initial Delay of " + var_2acd3064a749d3bd + " seconds.";
  wait var_2acd3064a749d3bd;
  level thread function_4bcc15a45628da41(poiname);
}

function function_e358232a03764c9b(poiname) {
  level endon("game_ended");
  level endon("dmz_radiation_started");
  var_d2ca218ea05fa7cc = getdvarint(@ "hash_5f174bbb593ef9f4", 60);
  starting_num = level.var_41670c1c65f3d3cf.poi[poiname].agentdeaths;
  starting_increment = level.var_41670c1c65f3d3cf.poi[poiname].var_5da316fb1c149f28;
  level.var_41670c1c65f3d3cf.poi[poiname].var_8bcd79921ba8147e = starting_num + starting_increment;
  var_745537a1e27d4e8 = 0;

  while(true) {
    if(level.var_41670c1c65f3d3cf.poi[poiname].agentdeaths >= level.var_41670c1c65f3d3cf.poi[poiname].var_8bcd79921ba8147e) {
      incrementvariation = 2;

      if(scripts\mp\gametypes\br_gametype_dmz::function_7a7aa3b5455f0412(poiname)) {
        incrementvariation = 1;
      }

      increment = level.var_41670c1c65f3d3cf.poi[poiname].var_5da316fb1c149f28 + randomintrange(incrementvariation * -1, incrementvariation);
      level.var_41670c1c65f3d3cf.poi[poiname].var_8bcd79921ba8147e += increment;
      level.var_41670c1c65f3d3cf.poi[poiname].reinforcementqueue[level.var_41670c1c65f3d3cf.poi[poiname].reinforcementqueue.size] = increment;
    }

    if(!scripts\mp\gametypes\br_gametype_dmz::function_7a7aa3b5455f0412(poiname) && level.var_41670c1c65f3d3cf.poi[poiname].agentdeaths > 0 && level.var_41670c1c65f3d3cf.poi[poiname].agentdeaths != var_745537a1e27d4e8 && level.var_41670c1c65f3d3cf.poi[poiname].agentdeaths % level.var_8a7245a12448052f == 0) {
      var_745537a1e27d4e8 = level.var_41670c1c65f3d3cf.poi[poiname].agentdeaths;
      function_374ecacad63bb411(level.var_a3a884994e83cdba, poiname, "Full POI Pause");
    }

    wait 1;
  }
}

function function_4bcc15a45628da41(poiname) {
  level endon("game_ended");
  level endon("dmz_radiation_started");
  var_d2ca218ea05fa7cc = getdvarint(@ "hash_5f174bbb593ef9f4", 60);
  var_214efd966bf0021d = getdvarint(@ "hash_623de28f7e6a71a2", 10);

  while(true) {
    if(level.var_41670c1c65f3d3cf.poi[poiname].reinforcementqueue.size > 0) {
      if(poiname != "saba_S5Reveal" && !istrue(scripts\mp\gametypes\br_gametype_dmz::function_7a7aa3b5455f0412(poiname))) {
        subarea_checkforreinforcementshutdown(poiname);
      }

      [reinforceorigin, subarea] = function_8d4c6890cbea3d1(poiname);

      if(isDefined(reinforceorigin)) {
        nextincrement = level.var_41670c1c65f3d3cf.poi[poiname].reinforcementqueue[0];
        level.var_41670c1c65f3d3cf.poi[poiname].var_a87122636ff072d3 = "Queue Activated. Reinforcements requested.";

        if(istrue(scripts\mp\gametypes\br_gametype_dmz::function_7a7aa3b5455f0412(poiname) && isDefined(level.var_c129fa020d92b91))) {
          var_ed62176958dae2ec = [];

          foreach(id in level.var_c129fa020d92b91) {
            var_ed62176958dae2ec[id] = 0;
          }

          foreach(agent in function_7e3f22e620f3f71e(poiname, "everybody")) {
            if(isagent(agent)) {
              foreach(id in level.var_c129fa020d92b91) {
                if(issubstr(agent.agent_type, "_" + id)) {
                  var_ed62176958dae2ec[id]++;
                }
              }

              continue;
            }

            if(isint(agent)) {
              var_824705fcb077e8d6 = function_2b0e82156fa6075b(agent);

              foreach(id in level.var_c129fa020d92b91) {
                if(issubstr(var_824705fcb077e8d6.aitype, "_" + id)) {
                  var_ed62176958dae2ec[id]++;
                }
              }
            }
          }

          nationality = undefined;

          foreach(id, count in var_ed62176958dae2ec) {
            if(!isDefined(nationality)) {
              nationality = id;
            }

            if(count < var_ed62176958dae2ec[nationality]) {
              nationality = id;
            }
          }
        } else {
          nationality = subarea.var_7da9883d4168b7f1.nationalityoverride;

          if(!isDefined(nationality)) {
            nationality = level.var_75041b516b3785c6;
          }
        }

        if(istrue(level.var_ba36989c7e24e4ff)) {
          println("<dev string:xc9b>" + poiname + "<dev string:xcb8>" + gettime());
        }

        reinforcementtype = callsharedfunc("determineReinforceType", poiname);
        reinforceorigin = default_to(callsharedfunc("determineReinforceOrigin", poiname, reinforcementtype), reinforceorigin);
        agents = function_77acc10c4823dd8a(nextincrement, reinforceorigin, "medium", "reinforcements", undefined, undefined, undefined, undefined, poiname, reinforcementtype, undefined, undefined, undefined, nationality);

        if(isDefined(agents) && agents.size > 0) {
          level.var_41670c1c65f3d3cf.poi[poiname].reinforcementqueue = array_remove_index(level.var_41670c1c65f3d3cf.poi[poiname].reinforcementqueue, 0);

          if(isDefined(level.var_41670c1c65f3d3cf.poi[poiname].reinforcedelaytime)) {
            delaytime = level.var_41670c1c65f3d3cf.poi[poiname].reinforcedelaytime;
          } else {
            delaytime = var_d2ca218ea05fa7cc + randomfloatrange(var_214efd966bf0021d * -1, var_214efd966bf0021d);
          }

          if(istrue(level.var_ba36989c7e24e4ff)) {
            println("<dev string:xcbe>" + poiname + "<dev string:xce3>" + delaytime);
          }

          function_374ecacad63bb411(delaytime, poiname, "Success");
        } else {
          if(istrue(level.var_ba36989c7e24e4ff)) {
            println("<dev string:xcf3>" + poiname + "<dev string:xce3>" + 1);
          }

          level.var_41670c1c65f3d3cf.poi[poiname].var_a87122636ff072d3 = "Request Failed: Will Try Again";
          function_374ecacad63bb411(1, poiname);
        }
      } else {
        println("<dev string:xd15>" + poiname);
        level thread function_81b32ea3e7797125(poiname, 5, "No good reinforce loc found.");
        function_374ecacad63bb411(5, poiname);
      }
    } else {
      level.var_41670c1c65f3d3cf.poi[poiname].var_a87122636ff072d3 = "Queue Empty";
      function_374ecacad63bb411(1, poiname);
    }

    function_e332d48077f00441(poiname);
  }
}

function function_81b32ea3e7797125(poiname, time, reason) {
  timeremaining = time;
  interval = 0.1;

  if(!isDefined(reason)) {
    reason = "";
  } else {
    reason += " - ";
  }

  while(timeremaining > 0) {
    displaytime = scripts\mp\utility\script::limitdecimalplaces(timeremaining, 1);
    level.var_41670c1c65f3d3cf.poi[poiname].var_a87122636ff072d3 = reason + "Queue Delay : " + displaytime;
    wait interval;
    timeremaining -= interval;
  }

  level.var_41670c1c65f3d3cf.poi[poiname].var_a87122636ff072d3 = "Delay Complete. New Request Available";
}

function function_8d4c6890cbea3d1(poiname, var_4a5b97d6bbd597a) {
  if(!isDefined(var_4a5b97d6bbd597a)) {
    var_4a5b97d6bbd597a = 1;
  }

  var_be60021f92d78965 = undefined;

  if(poi_issystemactive()) {
    if(!isDefined(poiname)) {
      return [undefined, undefined];
    }

    [origin, subarea] = function_a7f1b9bb31f445f1(poiname);

    if(isDefined(origin)) {
      return [origin, subarea];
    }

    var_be60021f92d78965 = level.poi[poiname]["subAreas"];
  } else {
    return [undefined, undefined];
  }

  var_955568ee845fff79 = [];
  var_c31cd0019ee19fa2 = [];

  foreach(subarea in var_be60021f92d78965) {
    if(istrue(subarea.isshutdown)) {
      continue;
    }

    if(subarea.var_3ebb6024e3f220ca.size + var_4a5b97d6bbd597a <= subarea.var_7da9883d4168b7f1.var_74fd03286daecf85) {
      var_955568ee845fff79[var_955568ee845fff79.size] = subarea;
      continue;
    }

    if(subarea.var_3ebb6024e3f220ca.size + var_4a5b97d6bbd597a <= subarea.var_7da9883d4168b7f1.var_63e6c2f5f608f74e) {
      var_c31cd0019ee19fa2[var_c31cd0019ee19fa2.size] = subarea;
    }
  }

  if(var_955568ee845fff79.size > 0) {
    var_bb61678dce6ae026 = random(var_955568ee845fff79);
    return [function_99b2104c78855a16(var_bb61678dce6ae026), var_bb61678dce6ae026];
  }

  if(var_c31cd0019ee19fa2.size > 0) {
    var_bb61678dce6ae026 = random(var_c31cd0019ee19fa2);
    return [function_99b2104c78855a16(var_bb61678dce6ae026), var_bb61678dce6ae026];
  }

  return [undefined, undefined];
}

function function_99b2104c78855a16(subarea) {
  alllocs = array_combine(level.poi[subarea.poi]["paraReinforceStruct"].landingspots, level.poi[subarea.poi]["heliReinforceStruct"].postlandingdest);

  if(isDefined(level.poi[subarea.poi]["elevatorReinforceLocs"])) {
    alllocs = array_combine(level.poi[subarea.poi]["elevatorReinforceLocs"]);
  }

  if(subarea.var_71ad22c5d093d90b != "orphan") {
    var_abc2b29e98e397c7 = [];

    foreach(loc in alllocs) {
      var_4b70d7484f56a682 = subarea_findfromorigin(loc.origin, subarea.poi);

      if(subarea.var_71ad22c5d093d90b == var_4b70d7484f56a682.var_71ad22c5d093d90b) {
        var_abc2b29e98e397c7[var_abc2b29e98e397c7.size] = loc;
      }
    }

    if(var_abc2b29e98e397c7.size == 0) {
      println("<dev string:xd3b>" + subarea.poi + "<dev string:xd86>" + subarea.var_71ad22c5d093d90b);
      return subarea.trigger.origin;
    }

    return random(var_abc2b29e98e397c7).origin;
  }

  if(alllocs.size == 0) {
    println("<dev string:xd8d>" + subarea.poi + "<dev string:xd86>" + subarea.var_71ad22c5d093d90b);
    return;
  }

  return random(alllocs).origin;
}

function function_3daefb936272829f(poiname, origin, time, subarea) {
  if(scripts\mp\utility\game::getsubgametype() != "dmz") {
    return;
  }

  if(!isDefined(poiname) || !isDefined(level.var_41670c1c65f3d3cf.poi[poiname])) {
    return;
  }

  if(!isDefined(level.var_41670c1c65f3d3cf.poi[poiname].reinforcementlocs)) {
    return;
  }

  if(!isDefined(time)) {
    time = gettime();
  }

  if(isDefined(level.var_41670c1c65f3d3cf.poi[poiname].var_7de558b0868a5d85)) {
    dist = distance2dsquared(origin, level.var_41670c1c65f3d3cf.poi[poiname].var_7de558b0868a5d85.origin);

    if(time - level.var_41670c1c65f3d3cf.poi[poiname].var_7de558b0868a5d85.time < level.var_2ceafe81d4233d2b && dist <= level.var_28ddeb5728c40aa2) {
      return;
    }
  }

  struct = spawnStruct();
  struct.origin = origin;
  struct.time = gettime();
  struct.subarea = subarea;
  level.var_41670c1c65f3d3cf.poi[poiname].reinforcementlocs[level.var_41670c1c65f3d3cf.poi[poiname].reinforcementlocs.size] = struct;
  level.var_41670c1c65f3d3cf.poi[poiname].var_7de558b0868a5d85 = struct;
}

function function_a7f1b9bb31f445f1(poiname) {
  if(!isDefined(poiname) || !isDefined(level.var_41670c1c65f3d3cf.poi[poiname])) {
    return [undefined, undefined];
  }

  currenttime = gettime();
  level.var_41670c1c65f3d3cf.poi[poiname].reinforcementlocs = array_randomize(level.var_41670c1c65f3d3cf.poi[poiname].reinforcementlocs);

  foreach(index, loc in level.var_41670c1c65f3d3cf.poi[poiname].reinforcementlocs) {
    if(currenttime > loc.time + 45000) {
      level.var_41670c1c65f3d3cf.poi[poiname].reinforcementlocs[index] = undefined;
      continue;
    }

    origin = loc.origin;
    subarea = loc.subarea;
    level.var_41670c1c65f3d3cf.poi[poiname].reinforcementlocs[index] = undefined;
    return [origin, subarea];
  }

  return [undefined, undefined];
}

function function_d4e513ab9aae6aa6(poiname) {
  potentialnodes = [];

  foreach(node in level.poi[poiname]["looseGuardNodes"]) {
    if(node.var_71ad22c5d093d90b == "orphan") {
      potentialnodes[potentialnodes.size] = node;
    }
  }

  node = random(potentialnodes);

  if(isDefined(node)) {
    return node.origin;
  }
}

function function_b9d78fce07834c95(agentrequests, reinforcementtype) {
  requestpackage = spawnStruct();
  requestpackage.numagents = agentrequests.size;
  requestpackage.requests = agentrequests;
  requestpackage.reinforcementtype = reinforcementtype;
  return requestpackage;
}

function function_de59d7cb310c1aff(type, tier, nationality) {
  request = spawnStruct();

  if(!isDefined(type)) {
    type = function_ed108ff3eb578327(undefined, tier);
  }

  request.type = type;

  if(!isDefined(tier)) {
    tier = 1;
  }

  request.tier = tier;
  request.nationality = nationality;
  return request;
}

function function_ab14d6652e44fda0(var_df3d07ebcf4abe8a, possibletypes, tier, var_fcdc7f62624c71ff, reinforcementtype) {
  requests = [];

  for(i = 0; i < var_df3d07ebcf4abe8a; i++) {
    if(isDefined(var_fcdc7f62624c71ff)) {
      type = function_ed108ff3eb578327(var_fcdc7f62624c71ff, tier);
    } else {
      type = random(possibletypes);
    }

    requests[requests.size] = function_de59d7cb310c1aff(type, tier);
  }

  return function_b9d78fce07834c95(requests, reinforcementtype);
}

function function_374ecacad63bb411(delaytime, poiname, delayreason) {
  if(!isDefined(poiname) || !isDefined(level.var_41670c1c65f3d3cf.poi[poiname])) {
    return;
  }

  if(!isDefined(level.var_41670c1c65f3d3cf.poi[poiname].var_5531002f0448bfaf)) {
    return;
  }

  delaypackage = spawnStruct();
  delaypackage.delaytime = delaytime;
  delaypackage.delayreason = delayreason;
  level.var_41670c1c65f3d3cf.poi[poiname].var_5531002f0448bfaf[level.var_41670c1c65f3d3cf.poi[poiname].var_5531002f0448bfaf.size] = delaypackage;
  level.var_41670c1c65f3d3cf.poi[poiname].var_9d2f71782a11c15c = 1;
}

function function_e332d48077f00441(poiname) {
  level endon("game_ended");

  if(!isDefined(poiname) || !isDefined(level.var_41670c1c65f3d3cf.poi[poiname])) {
    return;
  }

  while(level.var_41670c1c65f3d3cf.poi[poiname].var_9d2f71782a11c15c) {
    var_70bcbf0ad5028219 = level.var_41670c1c65f3d3cf.poi[poiname].var_5531002f0448bfaf;
    level.var_41670c1c65f3d3cf.poi[poiname].var_5531002f0448bfaf = [];
    level.var_41670c1c65f3d3cf.poi[poiname].var_9d2f71782a11c15c = 0;

    foreach(delaypackage in var_70bcbf0ad5028219) {
      if(istrue(level.var_ba36989c7e24e4ff)) {
        println("<dev string:xdd2>" + poiname + "<dev string:xcb8>" + delaypackage.delaytime);
      }

      level thread function_81b32ea3e7797125(poiname, delaypackage.delaytime, delaypackage.delayreason);
      wait delaypackage.delaytime;
    }
  }
}

function function_346caf10322931c8(poiname, origin) {
  curtime = gettime();

  if(poi_issystemactive()) {
    if(!isDefined(poiname) || !array_contains(getarraykeys(level.poi), poiname)) {
      poiname = poi_findpoioriginisin(origin);
    }

    if(!level.var_1171d24dd4142369[poiname] && curtime - level.var_e5fd74b71bdf51fa[poiname] > level.var_d1a95e3c3d6ea9fc) {
      level.var_1171d24dd4142369[poiname] = 1;
      level.var_e5fd74b71bdf51fa[poiname] = curtime;
      var_600052562a9f7fa4 = [];

      foreach(player in level.players) {
        if(isDefined(player.closestpoi) && player.closestpoi == poiname) {
          var_600052562a9f7fa4[var_600052562a9f7fa4.size] = player;
        }
      }

      scripts\cp_mp\overlord::playevent("poi_ai_reinforce", var_600052562a9f7fa4);
      level.var_1171d24dd4142369[poiname] = 0;
    }

    return;
  }

  if(!level.var_1171d24dd4142369 && (!isDefined(level.var_e5fd74b71bdf51fa) || curtime - level.var_e5fd74b71bdf51fa > level.var_d1a95e3c3d6ea9fc)) {
    level.var_1171d24dd4142369 = 1;
    level.var_e5fd74b71bdf51fa = curtime;
    level.var_1171d24dd4142369 = 0;
  }
}

function function_353fecd1549f5f42(origin, radius, team, var_20291ae8a5f418f1, var_3e7224d25cb04b6, goalradiusoverride, var_3618cbd8ed07704, var_2e2a816782a04d24, var_1b3d1c2f22b62206, targetent) {
  localdebug = 0;

  if(!isDefined(team)) {
    team = "team_hundred_ninety_five";
  }

  if(!isDefined(radius)) {
    radius = 1024;
  }

  agents = scripts\mp\utility\entity::function_d9ce8fb00f0e5fa1(origin, radius, team);
  temparray = [];

  foreach(agent in agents) {
    if(!isPlayer(agent)) {
      temparray[temparray.size] = agent;
    }
  }

  agents = temparray;

  if(!isDefined(var_20291ae8a5f418f1)) {
    var_20291ae8a5f418f1 = 5;
  }

  if(!isDefined(var_3e7224d25cb04b6)) {
    var_3e7224d25cb04b6 = ["extraGuards", "extraPatrols", "reinforcements", "firstKillFodder", "spawnPackage"];
  }

  if(localdebug) {
    foreach(guy in level.agentarray) {
      guy notify("<dev string:xded>");
    }
  }

  agents = sortbydistance(agents, origin);
  var_c5a227521b066bdd = [];

  foreach(agent in agents) {
    if(isPlayer(agent)) {
      continue;
    }

    if(issubstr(agent.agent_type, "jugg")) {
      continue;
    }

    if(var_c5a227521b066bdd.size >= var_20291ae8a5f418f1) {
      break;
    }

    if(!istrue(var_2e2a816782a04d24) && istrue(agent.var_9f78b0c726e807ff) || isDefined(agent.vehicle_position) && isint(agent.vehicle_position)) {
      continue;
    }

    if(!(isstring(var_3e7224d25cb04b6) && var_3e7224d25cb04b6 == "all") && !array_contains(var_3e7224d25cb04b6, agent.category)) {
      if(localdebug) {
        agent thread scripts\mp\utility\debug::drawsphere(agent.origin, 64, 30, (1, 0, 0));
      }

      continue;
    }

    var_c5a227521b066bdd[var_c5a227521b066bdd.size] = agent;
    agent.var_9f78b0c726e807ff = 1;

    if(!isDefined(goalradiusoverride)) {
      goalradiusoverride = 256;
    }

    if(!isDefined(var_3618cbd8ed07704)) {
      var_3618cbd8ed07704 = 512;
    }

    agent thread function_a5117518725da028(agent, origin, var_3618cbd8ed07704, goalradiusoverride, undefined, 1, agents, 0, var_1b3d1c2f22b62206, targetent);

    if(localdebug) {
      agent thread function_96570df5c7d02794(agent, origin);
    }
  }

  return var_c5a227521b066bdd;
}

function function_6214774e8e021663(numagents, reinforceorigin, priority, category, subcategory, groupname, team, poiname, var_b1a6a85296574c99, maxdistfromorigin) {
  if(!isDefined(var_b1a6a85296574c99)) {
    var_b1a6a85296574c99 = 512;
  }

  if(!isDefined(maxdistfromorigin)) {
    maxdistfromorigin = 1024;
  }

  reinforceorigin = function_61cbc488b27a6e61(reinforceorigin);
  degoffset = 360 / numagents;
  agents = [];
  starlevel = function_5cc0c507e92f7b47(poiname);

  for(i = 1; i <= numagents; i++) {
    spawnorigin = (0, randomintrange(var_b1a6a85296574c99, maxdistfromorigin), 0);
    spawnorigin = reinforceorigin + rotatepointaroundvector((0, 0, 1), spawnorigin, degoffset * i);
    spawnorigin = function_61cbc488b27a6e61(spawnorigin);
    aitype = function_d5bc07eabf352abb();
    agents[agents.size] = ai_mp_requestspawnagent(aitype, spawnorigin, (0, 0, 0), priority, category, subcategory, groupname, team, undefined, poiname);
  }

  return agents;
}

function function_30ef4d9086400a2d() {
  level.var_41670c1c65f3d3cf.var_5da316fb1c149f28 = getdvarint(@ "hash_69535aa7c07dd140", 5);
  level.var_41670c1c65f3d3cf.reinforcementqueue = [];
  level.var_41670c1c65f3d3cf.var_5531002f0448bfaf = [];
  level.var_41670c1c65f3d3cf.var_9d2f71782a11c15c = 0;

  if(getdvarint(@ "hash_8ec821e080a0b50d", 1) == 1) {
    level.var_d1a95e3c3d6ea9fc = getdvarint(@ "hash_3d859bf85679053c", 200) * 1000;
    level.var_e5fd74b71bdf51fa = 0;
    level.var_1171d24dd4142369 = 0;
  }

  level.var_a87122636ff072d3 = "Initalizing";
  level thread function_1ddbad36141b379();
  var_2acd3064a749d3bd = getdvarint(@ "hash_3bb3561ddb301247", 180);
  level.var_a87122636ff072d3 = "Waiting for Initial Delay of " + var_2acd3064a749d3bd + " seconds.";
  wait var_2acd3064a749d3bd;
  level thread function_cc76799172c6a0f();
}

function function_1ddbad36141b379() {
  level endon("game_ended");
  level endon("dmz_radiation_started");
  var_d2ca218ea05fa7cc = getdvarint(@ "hash_5f174bbb593ef9f4", 60);
  starting_num = level.var_41670c1c65f3d3cf.agentdeaths;
  starting_increment = level.var_41670c1c65f3d3cf.var_5da316fb1c149f28;
  threshold = starting_num + starting_increment;
  var_745537a1e27d4e8 = 0;

  while(true) {
    if(level.var_41670c1c65f3d3cf.agentdeaths >= threshold) {
      increment = level.var_41670c1c65f3d3cf.var_5da316fb1c149f28 + randomintrange(-2, 2);
      threshold += increment;
      level.var_41670c1c65f3d3cf.reinforcementqueue[level.var_41670c1c65f3d3cf.reinforcementqueue.size] = increment;
    }

    if(level.var_41670c1c65f3d3cf.agentdeaths > 0 && level.var_41670c1c65f3d3cf.agentdeaths != var_745537a1e27d4e8 && level.var_41670c1c65f3d3cf.agentdeaths % level.var_8a7245a12448052f == 0) {
      var_745537a1e27d4e8 = level.var_41670c1c65f3d3cf.agentdeaths;
      function_7bbe6bc34f2e7edf(level.var_a3a884994e83cdba);
    }

    wait 1;
  }
}

function function_cc76799172c6a0f() {
  level endon("game_ended");
  level endon("dmz_radiation_started");
  var_d2ca218ea05fa7cc = getdvarint(@ "hash_5f174bbb593ef9f4", 60);
  var_214efd966bf0021d = getdvarint(@ "hash_623de28f7e6a71a2", 10);
  var_409904714e01634a = undefined;

  while(true) {
    if(level.var_41670c1c65f3d3cf.reinforcementqueue.size > 0) {
      if(!istrue(var_409904714e01634a)) {
        level.var_a87122636ff072d3 = "Queue Activated: Waiting 10-15 secs before request.";
        wait randomintrange(10, 15);
      }

      success = 0;
      timeout = 10000;
      starting_time = gettime();
      nextincrement = level.var_41670c1c65f3d3cf.reinforcementqueue[0];

      while(!success && starting_time + timeout > gettime()) {
        level.var_a87122636ff072d3 = "Queue Activated. Reinforcements requested.";
        agents = function_77acc10c4823dd8a(nextincrement, getrandomnavpoint((0, 0, 0), 10000), "medium", "reinforcements", "maintainPopulation");

        if(isDefined(agents)) {
          success = 1;
        }

        wait 0.25;
      }

      if(success) {
        level.var_41670c1c65f3d3cf.reinforcementqueue = array_remove_index(level.var_41670c1c65f3d3cf.reinforcementqueue, 0);
        delaytime = var_d2ca218ea05fa7cc + randomfloatrange(var_214efd966bf0021d * -1, var_214efd966bf0021d);
        level.var_a87122636ff072d3 = "Request Successful: Delay of " + delaytime + " seconds.";
        var_409904714e01634a = 1;
        wait delaytime;
      }
    } else {
      level.var_a87122636ff072d3 = "Queue Empty";
      var_409904714e01634a = 0;
    }

    function_bfdb4389e23ac40f();
    wait 1;
    function_bfdb4389e23ac40f();
  }
}

function function_7bbe6bc34f2e7edf(delaytime) {
  level.var_41670c1c65f3d3cf.var_5531002f0448bfaf[level.var_41670c1c65f3d3cf.var_5531002f0448bfaf.size] = delaytime;
  level.var_41670c1c65f3d3cf.var_9d2f71782a11c15c = 1;
}

function function_bfdb4389e23ac40f() {
  level endon("game_ended");

  while(level.var_41670c1c65f3d3cf.var_9d2f71782a11c15c) {
    var_70bcbf0ad5028219 = level.var_41670c1c65f3d3cf.var_5531002f0448bfaf;
    level.var_41670c1c65f3d3cf.var_5531002f0448bfaf = [];
    level.var_41670c1c65f3d3cf.var_9d2f71782a11c15c = 0;

    foreach(delaypackage in var_70bcbf0ad5028219) {
      level.var_a87122636ff072d3 = "Queue Paused: Current pause of " + delaypackage.delaytime + " secs.";
      wait delaypackage.delaytime;
    }
  }
}

function function_571151294c1a740b(tier, arrayoptions) {
  while(!isDefined(level.reinforcementoptions) || !isDefined(level.reinforcementoptions.var_87f044eda76ae14a)) {
    waitframe();
  }

  level.reinforcementoptions.var_87f044eda76ae14a["tier" + tier] = arrayoptions;
}

function function_5033963ec182afc1(type, arrayoptions) {
  while(!isDefined(level.reinforcementoptions) || !isDefined(level.reinforcementoptions.var_48d4812167fbb628)) {
    waitframe();
  }

  level.reinforcementoptions.var_48d4812167fbb628[type] = arrayoptions;
}

function function_96570df5c7d02794(agent, origin) {
  agent endon("<dev string:xded>");

  while(true) {
    thread scripts\mp\utility\debug::drawsphere(agent.origin, 64, 0.05, (0, 1, 0));
    thread scripts\cp_mp\utility\debug_utility::drawline(agent.origin, origin, 0.05, (1, 1, 1));
    waitframe();
  }
}

function function_8dd097014829eb21() {
  wait 5;
  player = level.players[0];
  follower = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent(function_7f1a2e2ebe0c1693("ar"), player.origin, player.angles, "mission", undefined, 1, player.team);
  overridetier3(follower);

  if(isDefined(follower)) {
    behavior_followent(follower, player);
  }
}

function behavior_followent(agent, player) {
  level endon("game_ended");
  agent endon("death");

  while(true) {
    agent function_304da84d9a815c01(player.origin, 128, 1);
    agent scripts\stealth\enemy::bt_set_stealth_state("combat", undefined);
    wait 3;
  }
}

function function_654314b2d2451989(agent) {
  while(true) {
    random_x = randomfloatrange(85, 150) * scripts\engine\utility::ter_op(randomint(100) > 50, 1, -1);
    random_y = randomfloatrange(85, 150) * scripts\engine\utility::ter_op(randomint(100) > 50, 1, -1);
    var_b30a6c38cd4fe517 = (agent.origin[0] + random_x, agent.origin[1] + random_y, agent.origin[2]);
    agent _setgoalpos(function_61cbc488b27a6e61(var_b30a6c38cd4fe517), 10);
    wait 5;
  }
}

function function_5d07b6ef455e7876(agent, groupname) {
  if(!isDefined(level.var_455529c46f41b5e9)) {
    level.var_455529c46f41b5e9 = 0;
  }

  if(!isDefined(groupname)) {
    if(isDefined(agent.poi)) {
      groupname = function_d2d6e405db635dc8(agent.poi);
    } else if(poi_issystemactive()) {
      groupname = function_d2d6e405db635dc8(undefined);
    } else {
      groupname = function_1c52f5ede022affe(agent);
    }
  }

  if(isDefined(agent.group) && isDefined(agent.group.group_name)) {
    agent.script_stealthgroup = agent.group.group_name;
  } else if(isDefined(groupname)) {
    agent.script_stealthgroup = groupname;
  } else {
    if(!isDefined(groupname)) {
      groupname = "group_" + level.var_455529c46f41b5e9;
      level.var_455529c46f41b5e9++;
    }

    agent.script_stealthgroup = groupname;
  }

  if(isDefined(agent.spawnpoint)) {
    if(isDefined(agent.spawnpoint.script_stealthgroup)) {
      agent.script_stealthgroup = agent.spawnpoint.script_stealthgroup;
    }

    if(isDefined(agent.spawnpoint.script_sightrange)) {
      agent.stealth.override_damage_auto_range = int(agent.script_sightrange);
    }
  }

  agent thread scripts\stealth\enemy::main();
  agent thread scripts\cp_mp\stealth\manager::monitor_death_thread(level.stealth.damage_auto_range, level.stealth.damage_sight_range);
  agent.var_ba67494935b9726b = 1;
  agent.stealth.funcs["event_combat"] = &function_21014e3c42bcc249;
}

function function_d2d6e405db635dc8(poiname, numagents) {
  if(!isDefined(numagents)) {
    numagents = 1;
  }

  if(isDefined(level.poi) && isDefined(poiname) && isDefined(level.poi[poiname])) {
    if(!isDefined(level.poi[poiname]["stealthGroupIndexing"])) {
      level.poi[poiname]["stealthGroupIndexing"] = spawnStruct();
      level.poi[poiname]["stealthGroupIndexing"].var_455529c46f41b5e9 = 1;
      level.poi[poiname]["stealthGroupIndexing"].var_8c2675f7696d48fc = 0;
    }

    if(level.poi[poiname]["stealthGroupIndexing"].var_8c2675f7696d48fc >= 40) {
      level.poi[poiname]["stealthGroupIndexing"].var_455529c46f41b5e9 = level.poi[poiname]["stealthGroupIndexing"].var_455529c46f41b5e9 + 1;
      level.poi[poiname]["stealthGroupIndexing"].var_8c2675f7696d48fc = 0;
    }

    level.poi[poiname]["stealthGroupIndexing"].var_8c2675f7696d48fc = level.poi[poiname]["stealthGroupIndexing"].var_8c2675f7696d48fc + numagents;
    return (poiname + "_" + level.poi[poiname]["stealthGroupIndexing"].var_455529c46f41b5e9);
  }

  if(!isDefined(level.var_50bd497eb91dc04a)) {
    level.var_50bd497eb91dc04a = 1;
    level.var_ef80e5300d000127 = 0;
  }

  if(level.var_ef80e5300d000127 >= 40) {
    level.var_50bd497eb91dc04a += 1;
    level.var_ef80e5300d000127 = 0;
  }

  level.var_ef80e5300d000127 += numagents;
  return "noProvidedPOIName_" + level.var_50bd497eb91dc04a;
}

function function_1c52f5ede022affe(agent) {
  if(!isDefined(level.var_5a4dba9129517d67)) {
    level.var_5a4dba9129517d67 = [];
    level.var_c316383dd3bc8be6 = [];
  }

  if(!isDefined(level.var_5a4dba9129517d67[agent.team])) {
    level.var_5a4dba9129517d67[agent.team] = 1;
    level.var_c316383dd3bc8be6[agent.team] = 0;
  }

  if(level.var_c316383dd3bc8be6[agent.team] >= 4) {
    level.var_5a4dba9129517d67[agent.team] += 1;
    level.var_c316383dd3bc8be6[agent.team] = 0;
  }

  level.var_c316383dd3bc8be6[agent.team] += 1;
  return "stealthGroup_" + agent.team + "_" + level.var_5a4dba9129517d67[agent.team];
}

function function_c8393014dd7f8ab6() {
  level.default_goalradius = 2048;
  scripts\cp_mp\stealth\manager::main();
  flag_set("level_stealth_initialized");

  if(isDefined(level.var_3eed4e0bc4a30b72)) {
    var_d2126dbdeced47f6 = level.var_3eed4e0bc4a30b72;
  } else {
    var_d2126dbdeced47f6 = "br_saba_aieventlist";
  }

  function_71a28a935629a941(var_d2126dbdeced47f6);
  level.nopathnodes = 1;
  level.brenableagents = 1;
  namespace_310bdaa3cf041c47::init_gameskill();
}

function function_779b9979fd853e26(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(isDefined(self.callbackdamaged)) {
    [[self.callbackdamaged]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
    return;
  }

  namespace_daa149ca485fd50a::function_dffac413ed66bcd0(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

function function_912903818a06c431() {
  agent = ai_mp_requestspawnagent("enemy_mp_jugg_base", (-14, 488, 106), (0, 0, 0), "high", "elites", "debug");

  if(!isDefined(agent)) {
    return;
  }

  function_1828f1e20e52b418(agent);
}

function function_78759441c259f58a(origin, numagents) {
  if(isDefined(origin)) {
    poiname = poi_findpoioriginisin(origin);
    return function_d2d6e405db635dc8(poiname, numagents);
  }

  if(!isDefined(level.reinforceindex)) {
    level.reinforceindex = 1;
  } else {
    level.reinforceindex++;
  }

  return "reinforce_" + level.reinforceindex;
}

function function_8352fd5060043037(origin, radius) {
  if(!isDefined(origin)) {
    return;
  }

  if(!isDefined(radius)) {
    radius = 64;
  }

  pathnodes = getnodesinradius(origin, radius, 0, radius);

  foreach(node in pathnodes) {
    if(node.type == "Begin") {
      destroynavlink(node);
    }
  }
}

function function_c9dad3876b9d8755(agent, var_a938130624194f25) {
  if(!isDefined(agent) || !isDefined(var_a938130624194f25)) {
    return;
  }

  agent function_d493e7fe15e5eaf4(var_a938130624194f25);
}

function function_f55d225b544277e8(agent, time) {
  if(!isDefined(agent) || !isDefined(time)) {
    return;
  }

  agent.var_cc2849446d443fff = time * 1000;
  agent.var_226535b4da429452 = time * 1000;
}

function function_c9b9fe3f7f739586(agent) {
  if(istrue(agent.var_102a9d2cf99ab325)) {
    return;
  }

  agent.radimmune = 1;
  agent.var_102a9d2cf99ab325 = 1;
  agent attach("hat_child_hadir_gas_mask_wm_br", "j_head");
  function_63a043d47490f90d(agent, "brloot_equip_gasmask", undefined, 0.25, 108);
  agent.var_cd6a3a50f09688b9 = &function_85aea9db068bc292;
}

function function_85aea9db068bc292(agent, attacker) {
  agent detach("hat_child_hadir_gas_mask_wm_br", "j_head");
  agent.radimmune = 0;
  namespace_daa149ca485fd50a::function_59ea6b2f800cb082(agent, attacker);
}

function function_caf96a86ca85140f(agent) {
  if(!namespace_7789f919216d38a2::radiation_isinit()) {
    return;
  }

  if(namespace_7789f919216d38a2::function_485b5a399def53d0(agent.origin) > level.radiation.radius + 1500) {
    return;
  }

  if(isDefined(agent.category) && agent.category == "BOSSES") {
    return;
  }

  function_c9b9fe3f7f739586(agent);
}

function function_b893eeceef3ac7a(agent) {
  if(isDefined(level.var_184726567a9f58d8) && isDefined(level.var_808a69414f52f6bc)) {
    if(issubstr(agent.agent_type, "ar") || issubstr(agent.agent_type, "smg") || issubstr(agent.agent_type, "lmg")) {
      agenttier = agentpers_getagentpersdata(agent, "tier");

      if(randomfloat(1) <= level.var_184726567a9f58d8 * agenttier) {
        function_17dcf4b7d0a92bc3(agent);
      }
    }
  }
}

function function_17dcf4b7d0a92bc3(agent) {
  agent scripts\cp_mp\agents\agent_utils::function_c37c4f9d687074ff(undefined, undefined, level.br_lootiteminfo[random(level.var_808a69414f52f6bc)].fullweaponobj);
}

function function_e57289d4e2128a53(pathorigins) {
  if(!namespace_7789f919216d38a2::radiation_isinit()) {
    return false;
  }

  foreach(origin in pathorigins) {
    if(namespace_7789f919216d38a2::function_485b5a399def53d0(origin) < level.radiation.radius + 256) {
      return true;
    }
  }

  return false;
}

function function_8b178e05801f2daf(path) {
  if(!namespace_7789f919216d38a2::radiation_isinit()) {
    return false;
  }

  foreach(loc in path) {
    if(namespace_7789f919216d38a2::function_485b5a399def53d0(loc.origin) < level.radiation.radius + 256) {
      return true;
    }
  }

  return false;
}

function function_75425e32a1700c73() {
  badlocs = getStructArray("traversal_invalid", "script_noteworthy");

  foreach(loc in badlocs) {
    function_8352fd5060043037(loc.origin);
  }
}

function function_af3034a7c69d7edb(team) {
  if(!isDefined(level.var_9f08a58aa6a97f2e)) {
    level.var_9f08a58aa6a97f2e = [];
  }

  level thread spawnhiddenagent(team, (0, 0, 0));

  while(!isDefined(level.var_9f08a58aa6a97f2e[team])) {
    waitframe();
  }

  return level.var_9f08a58aa6a97f2e[team];
}

function spawnhiddenagent(team, hiddenpos) {
  if(isDefined(level.var_9f08a58aa6a97f2e[team])) {
    return;
  }

  level notify("spawn_hidden_agent_" + team);
  level endon("spawn_hidden_agent_" + team);
  scripts\mp\ai_mp_controller::function_2fc80954fa70d153();
  aitype = scripts\mp\ai_mp_controller::function_7f1a2e2ebe0c1693("ar");

  if(!isDefined(level.agent_definition["actor_" + aitype])) {
    aitype = scripts\mp\ai_mp_controller::function_7f1a2e2ebe0c1693("ar", undefined, "ru");
  }

  if(!isDefined(level.agent_definition["actor_" + aitype])) {
    aitype = scripts\mp\ai_mp_controller::function_7f1a2e2ebe0c1693("ar", undefined, "merc");
  }

  poi = undefined;

  if(scripts\mp\poi::poi_ispoiactive("bossArea")) {
    poi = "bossArea";
  }

  agent = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent(aitype, hiddenpos, (0, 0, 0), "absolute", "reinforcements", "hidden", undefined, team, undefined, poi, 1, undefined, 0);

  if(!isDefined(agent)) {
    return;
  }

  agent.ignoreall = 1;
  agent.dontevershoot = 1;
  agent.var_b582b10663b5b2a9 = 0;
  agent.invulnerable = 1;
  agent.speedscalemult = 0;
  agent forceteleport(hiddenpos, (0, 0, 0));
  agent takeallweapons();
  agent hide();
  level.var_9f08a58aa6a97f2e[team] = agent;
}

function function_44b2bad96489df87() {
  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  var_5f6e843fb2c4cb88 = 1;

  if(poi_issystemactive()) {
    function_44739fe1cf82e29a("stealthVolumeCenters");
  } else {
    level.stealthvolumecenters = [];
    var_5f6e843fb2c4cb88 = 0;
  }

  keys = getarraykeys(level.struct_class_names["script_noteworthy"]);

  foreach(key in keys) {
    if(issubstr(key, "_stealthVolume_")) {
      foreach(node in level.struct_class_names["script_noteworthy"][key]) {
        if(var_5f6e843fb2c4cb88) {
          poiname = poi_findpoioriginisin(node.origin, 1, 1);
          function_d0e7647e5538eb9d(poiname, "stealthVolumeCenters", node);
          continue;
        }

        level.stealthvolumecenters[level.stealthvolumecenters.size] = node;
      }
    }
  }
}

function function_e86762be42bb72b0(origin, poiname) {
  if(!isDefined(origin)) {
    return undefined;
  }

  var_a0b3a72bb77aafdd = undefined;

  if(poi_issystemactive()) {
    if(!isDefined(poiname) || poiname == "bossArea") {
      poiname = poi_findpoioriginisin(origin);
    }

    var_a0b3a72bb77aafdd = function_1af8a41e4c1252c7(poiname, "stealthVolumeCenters");
  } else {
    if(!isDefined(level.stealthvolumecenters) || level.stealthvolumecenters.size == 0) {
      return undefined;
    }

    var_a0b3a72bb77aafdd = level.stealthvolumecenters;
  }

  if(!isDefined(var_a0b3a72bb77aafdd) || var_a0b3a72bb77aafdd.size == 0) {
    return undefined;
  }

  sortedvolumes = sortbydistance(var_a0b3a72bb77aafdd, origin);
  return sortedvolumes[0].script_noteworthy;
}

function dialog_init() {}

function function_454a478e5e1fc4f2(alias, poiname) {
  if(!isDefined(poiname) || !isDefined(level.poi[poiname]) || !isDefined(level.poi[poiname]["players"])) {
    return;
  }

  foreach(player in level.poi[poiname]["players"]) {
    player scripts\mp\utility\dialog::leaderdialogonplayer(alias);
  }
}

function function_cdcce09b74c7cd1b(meansofdeath) {
  if(istrue(level.var_9d615a366ec2fb6f) || isDefined(meansofdeath) && meansofdeath == "MOD_EXECUTION" || isDefined(meansofdeath) && meansofdeath == "MOD_MELEE_TAKEDOWN" || isDefined(self.agentteam) && self.agentteam == "civilian") {
    return;
  }

  rand = randomintrange(1, 8);
  type = "generic";

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    type = "female";
  }

  if(isagent(self)) {
    if(isDefined(self.team) && self.team == "allies") {
      self playSound(type + "_death_american_" + rand);
      return;
    }

    self playSound(type + "_death_russian_" + rand);
  }
}

function function_5aee5d819f7dfd1c() {
  if(!isDefined(level.br_pickups)) {
    return;
  }

  level.var_370eed78aa5c01a5 = [];
  level.var_370eed78aa5c01a5["thermite_mp"] = "brloot_offhand_thermite";
  level.var_370eed78aa5c01a5["semtex_mp"] = "brloot_offhand_semtex";
  level.var_370eed78aa5c01a5["frag_grenade_mp"] = "brloot_offhand_frag";
  level.var_370eed78aa5c01a5["molotov_mp"] = "brloot_offhand_molotov";
  level.var_370eed78aa5c01a5["smoke_grenade_mp"] = "brloot_offhand_smoke";
  level.var_370eed78aa5c01a5["concussion_grenade_mp"] = "brloot_offhand_concussion";
  level.var_370eed78aa5c01a5["flash_grenade_mp"] = "brloot_offhand_flash";
  level.var_370eed78aa5c01a5["snapshot_grenade_mp"] = "brloot_offhand_snapshot";
  level.var_370eed78aa5c01a5["gas_mp"] = "brloot_offhand_gas";
  level.var_370eed78aa5c01a5["decoy_grenade_mp"] = "brloot_offhand_decoy";
  level.var_370eed78aa5c01a5["equip_adrenaline"] = "brloot_health_adrenaline";
  level.br_pickups.br_weapontoscriptable["iw9_ar_akilo_mp"] = "brloot_weapon_ar_akilo47_comm";
  level.br_pickups.br_weapontoscriptable["iw9_lm_mkilo3_mp"] = "brloot_weapon_lm_mkilo3_comm";
  level.br_pickups.br_weapontoscriptable["iw9_sh_mbravo_mp"] = "brloot_weapon_sh_romeo870_comm";
  level.br_pickups.br_weapontoscriptable["iw9_sm_mpapa5_mp"] = "brloot_weapon_sm_augolf_comm";
  level.br_pickups.br_weapontoscriptable["iw9_sn_alpha50_mp"] = "brloot_weapon_sn_alpha50_comm";
  level.br_pickups.br_weapontoscriptable["iw9_sm_aviktor_mp"] = "brloot_weapon_sm_uzulu_comm";
  level.br_pickups.br_weapontoscriptable["iw9_dm_mike24_mp"] = "brloot_weapon_sn_mike14_comm";
  level.br_pickups.br_weapontoscriptable["iw9_ar_augolf_mp"] = "brloot_weapon_ar_scharlie_rare";
  level.br_pickups.br_weapontoscriptable["iw9_ar_mike4_mp"] = "brloot_weapon_ar_mike4_epic";
  level.br_pickups.br_weapontoscriptable["iw9_sm_mpapa7_mp"] = "brloot_weapon_sm_mpapa7_epic";
  level.br_pickups.br_weapontoscriptable["iw8_lm_kilo121_mp"] = "brloot_weapon_lm_kilo121_lege";
  level.br_pickups.br_weapontoscriptable["iw9_sh_charlie725_mp"] = "brloot_weapon_sh_charlie725_lege";
  level.br_pickups.br_weapontoscriptable["iw8_sm_uzulu_mpv2"] = "brloot_weapon_sm_uzulu_epic";
  level.br_pickups.br_weapontoscriptable["iw9_la_rpapa7_mp"] = "brloot_weapon_la_rpapa7_rare";
}

function function_63a043d47490f90d(agent, scriptablename, lootid, dropchance, count) {
  function_8c8c6dbf143ab5b2(agent, function_edabf4238e9d70b5(scriptablename, lootid, undefined, dropchance, count));
}

function function_8c8c6dbf143ab5b2(agent, lootstruct) {
  if(!isDefined(lootstruct.lootid)) {
    lootstruct.lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(lootstruct.scriptablename);
  }

  forceddrops = default_to(agentpers_getagentpersdata(agent, "forcedDrops"), []);
  forceddrops[forceddrops.size] = lootstruct;
  agentpers_setagentpersdata(agent, "forcedDrops", forceddrops);
}

function function_82ed67ae79913551(agent, agenttype, groupname) {
  poiname = agent.poi;
  agent notify("endLootDropThread");
  agent endon("endLootDropThread");
  agentid = agent.var_8aa9efe6383c1d5a;
  droppeditems = [];
  droppeditemcount = [];
  backpackitems = [];
  backpackitemcount = [];
  agent.var_d544c62ea2bc64b = [];
  self waittill("death", killer, meansofdeath);

  if(getdvarint(@ "hash_307fc239dc43be41", 0)) {
    return;
  }

  if(isDefined(meansofdeath) && meansofdeath == "MOD_DESPAWN") {
    return;
  }

  if(istrue(agent.nocorpse)) {
    return;
  }

  if(!isDefined(level.var_370eed78aa5c01a5)) {
    return;
  }

  deathcountpers = scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata(agent, "skipDeathCount");

  if(istrue(deathcountpers)) {
    return;
  }

  var_e99fb9eaa6b7c3db = 0;
  dropbackpack = scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata(agent, "dropBackpack");
  var_a31a0baedb971fe5 = istrue(var_e99fb9eaa6b7c3db) && (!isDefined(dropbackpack) || istrue(dropbackpack));
  agentweapon = scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata(agent, "weapon");
  killerweapon = undefined;
  killerclientnum = undefined;

  if(isDefined(killer) && isPlayer(killer)) {
    killerweapon = killer getcurrentweapon();
    killerclientnum = killer getentitynumber();
  }

  agent.contents = [];
  dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();

  if(isDefined(level.var_d3fb932f0373554c)) {
    agent[[level.var_d3fb932f0373554c]](killer, dropstruct);
  }

  function_a29c2459dec85fde(agent, agenttype, agentweapon, killerweapon, !var_a31a0baedb971fe5, dropstruct);
  function_b66240f19684ff3a(agent, killerclientnum, !var_a31a0baedb971fe5, dropstruct);
  dropweapon = scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata(agent, "dropWeapon");
  shoulddropweapon = !isDefined(dropweapon) || istrue(dropweapon);

  if(isDefined(agentweapon) && shoulddropweapon) {
    weapondroporigin = agent.origin;
    persorigin = scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata(agent, "weaponDropOrigin");

    if(isDefined(persorigin)) {
      weapondroporigin = persorigin;
    }

    maxammo = undefined;

    if(issubstr(agentweapon.basename, "lm_dblmg")) {
      maxammo = 1;
    }

    dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, weapondroporigin, agent.angles, agent, undefined, undefined, undefined, 1);
    [ammo, ammoleft, var_35ead47ed0d7507e] = scripts\mp\gametypes\br_gametype_dmz::getdefaultweaponammo(agentweapon, maxammo);

    if(scripts\mp\utility\game::getsubgametype() == "dmz" && ammo < agentweapon.clipsize) {
      ammo = agentweapon.clipsize;
    }

    spawnedweapon = scripts\mp\gametypes\br_pickups::spawnpickup(agentweapon.basename, dropinfo, ammo, undefined, agentweapon, undefined, ammoleft, var_35ead47ed0d7507e);

    if(isDefined(spawnedweapon)) {
      spawnedweapon setscriptablepartstate(spawnedweapon.type, "dropped");
    }

    var_19f6fbd1c4bec7e9 = scripts\cp_mp\utility\game_utility::isbrstylegametype() && dropstruct.dropcount == 1;

    if(var_19f6fbd1c4bec7e9) {
      ammotype = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(agentweapon);

      if(isDefined(ammotype)) {
        dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, weapondroporigin, agent.angles, agent, undefined, undefined, undefined, 1);
        var_e3ab82cffd9e9b66 = int(level.br_pickups.counts[ammotype] * (1 + randomfloat(2)));
        item = scripts\mp\gametypes\br_pickups::spawnpickup(ammotype, dropinfo, var_e3ab82cffd9e9b66);
      }
    }
  }

  forceddrops = scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata(agent, "forcedDrops");

  if(isDefined(forceddrops)) {
    foreach(var_f96a2ea6b07e345c in forceddrops) {
      if(randomfloat(1) <= var_f96a2ea6b07e345c.dropchance) {
        function_305b1ba9c9b7f7b4(!var_a31a0baedb971fe5, var_f96a2ea6b07e345c, agent, dropstruct);
      }
    }
  }

  agentcategory = agent.category;
  var_dddf3a91daabebd2 = !issubstr(agenttype, "biolab") && function_15497e2309bc8671(isDefined(agentcategory) && issubstr(agentcategory, "fortress"));

  if(var_dddf3a91daabebd2) {
    keyname = ter_op(isDefined(level.var_4450f123bd5cd62e), level.var_4450f123bd5cd62e, "loot_key_fortress");

    if(issubstr(agenttype, "merc")) {
      if(scripts\cp_mp\utility\game_utility::function_e21746abaaaf8414()) {
        roll = randomint(100);

        if(roll < level.var_9c981303803aeab3) {
          keyname = scripts\mp\locksandkeys::function_23326c8ac97c60c7(0, 1, 1, 0, 0, 0, 1, 0, 20, 60, 20, "sealion");
        }
      } else if(scripts\cp_mp\utility\game_utility::function_7ee65fae13124702()) {
        roll = randomint(100);

        if(roll < level.var_9c981303803aeab3) {
          agenttier = agentpers_getagentpersdata(agent, "tier");

          switch (agenttier) {
            case 1:
              keyname = scripts\mp\locksandkeys::function_23326c8ac97c60c7(1, 0, 0, 0, 1, 0, 0, 0, 20, 60, 20, "sabacrash");
              break;
            case 2:
              keyname = scripts\mp\locksandkeys::function_23326c8ac97c60c7(0, 1, 0, 1, 0, 80, 0, 10, 20, 60, 20, "sabacrash");
              break;
            case 3:
              keyname = scripts\mp\locksandkeys::function_23326c8ac97c60c7(0, 0, 1, 1, 0, 0, 70, 20, 20, 60, 20, "sabacrash");
              break;
            default:
              keyname = scripts\mp\locksandkeys::function_23326c8ac97c60c7(1, 0, 0, 0, 1, 0, 0, 0, 20, 60, 20, "sabacrash");
              break;
          }
        }
      }
    } else if(issubstr(agenttype, "aq")) {
      if(scripts\cp_mp\utility\game_utility::function_7ee65fae13124702()) {
        roll = randomint(100);

        if(roll < level.var_9c981303803aeab3) {
          keyname = scripts\mp\locksandkeys::function_23326c8ac97c60c7(0, 0, 0, 1, 0, 0, 0, 1, 20, 60, 20);
        }
      }
    } else if(issubstr(agenttype, "cartel")) {
      if(scripts\cp_mp\utility\game_utility::function_7ee65fae13124702()) {
        roll = randomint(100);

        if(roll < level.var_9c981303803aeab3) {
          keyname = scripts\mp\locksandkeys::function_23326c8ac97c60c7(0, 0, 0, 1, 0, 0, 0, 1, 20, 60, 20);
        }
      }
    } else if(issubstr(agenttype, "ru")) {
      if(scripts\cp_mp\utility\game_utility::function_5e0e3a24dbb1fae1()) {
        roll = randomint(100);

        if(roll < level.var_9c981303803aeab3) {
          keyname = scripts\mp\locksandkeys::function_23326c8ac97c60c7(0, 0, 0, 1, 0, 0, 0, 1, 20, 60, 20, "delta");
        }
      }
    }

    keystruct = function_edabf4238e9d70b5(keyname, scripts\cp_mp\utility\loot::getlootidfromref(keyname), keyname);
    function_305b1ba9c9b7f7b4(!var_a31a0baedb971fe5, keystruct, agent, dropstruct);
  }

  if(!scripts\mp\loot::iscontainerempty(agent) && var_a31a0baedb971fe5) {
    dropstruct.dropidx += 2;
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, agent.origin, agent.angles, agent);
    spawnedbackpack = scripts\mp\gametypes\br_pickups::spawnpickup("brloot_backpack", dropinfo, 1);

    if(isDefined(spawnedbackpack)) {
      spawnedbackpack.contents = agent.contents;
      spawnedbackpack.containertype = 2;
    }

    callback = scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata(agent, "dropCallback");

    if(isDefined(callback)) {
      if(!isDefined(spawnedbackpack)) {
        dropinfo = scripts\mp\gametypes\br_pickups::getitemdropinfo(drop_to_ground(agent.origin));
        spawnedbackpack = scripts\mp\gametypes\br_pickups::spawnpickup("brloot_backpack", dropinfo, 1);
        spawnedbackpack.contents = agent.contents;
        spawnedbackpack.containertype = 2;
      }

      mission = scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata(agent, "mission");
      spawnedbackpack.criticalitem = 1;
      thread[[callback]](agent, spawnedbackpack, mission);
    }

    if(isDefined(spawnedbackpack) && isDefined(spawnedbackpack.contents)) {
      foreach(item in spawnedbackpack.contents) {
        if(isDefined(item["lootID"]) && isDefined(item["quantity"])) {
          backpackitems[backpackitems.size] = item["lootID"];
          backpackitemcount[backpackitemcount.size] = item["quantity"];
        }
      }
    }
  }

  agent.contents = undefined;

  if(getdvarint(@ "hash_b79ef01dd49b83d2", 0) || scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm") {
    if(!isDefined(level.var_45e6a8385ed4f50c)) {
      level.var_45e6a8385ed4f50c = getdvarfloat(@ "hash_2cac446c3fbe830f", 0.95);
    }

    if(randomfloat(1) > level.var_45e6a8385ed4f50c && isDefined(agent)) {
      bloodpool = spawnscriptable("vfx_dmz_blood_pool", agent.origin, agent.angles);
      dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, agent.origin, agent.angles, agent);
      agentradio = scripts\mp\gametypes\br_pickups::spawnpickup("brloot_dead_agent_radio", dropinfo);

      if(isDefined(agentradio)) {
        agentradio.entitynumber = agent getentitynumber();
        agentradio.poi = poiname;
        agentradio.droppedteam = agent.agentteam;
        thread scripts\mp\overseer::function_fc9a15646315764c(agentradio);
      }
    }
  }

  if(isDefined(agent) && is_equal(poiname, "saba_S5Reveal") && isDefined(level.var_27acc3a1e116209d) && randomfloat(1) < level.var_27acc3a1e116209d) {
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, agent.origin, agent.angles, agent);
    revealradio = scripts\mp\gametypes\br_pickups::spawnpickup("brloot_reveal_agent_radio", dropinfo);

    if(isDefined(revealradio)) {
      level thread scripts\mp\overseer::function_fc9a15646315764c(revealradio);
    }
  }

  if(isDefined(agent.var_d544c62ea2bc64b)) {
    foreach(item in agent.var_d544c62ea2bc64b) {
      if(!isDefined(item.count)) {
        item.count = 1;
      }

      if(isDefined(item.lootid)) {
        droppeditems[droppeditems.size] = item.lootid;
        droppeditemcount[droppeditemcount.size] = item.count;
      }
    }
  }

  dlog_recordevent("dlog_event_dmz_ai_death", ["spawn_id", agentid, "ai_pos_x", agent.origin[0], "ai_pos_y", agent.origin[1], "ai_pos_z", agent.origin[2], "dropped_weapon", ter_op(isDefined(agentweapon), agentweapon.basename, "undefined"), "dropped_pack_contents", backpackitems, "dropped_pack_item_count", backpackitemcount, "ground_items", droppeditems, "ground_item_count", droppeditemcount, "match_time_elapsed", gettime()]);
  agent.var_d544c62ea2bc64b = undefined;
}

function private function_b66240f19684ff3a(agent, killerclientnum, droponground, dropstruct) {
  if(!isDefined(killerclientnum)) {
    return 0;
  }

  if(!isDefined(level.var_adbe2e8c944c2f1)) {
    level.var_4fc2ab8a1090c195 = 0;
  }

  if(!isDefined(level.var_aeb6974202e8f2db)) {
    level.var_aeb6974202e8f2db = [];
  }

  if(!isDefined(level.var_aeb6974202e8f2db[killerclientnum])) {
    level.var_aeb6974202e8f2db[killerclientnum] = 1;
  } else {
    level.var_aeb6974202e8f2db[killerclientnum] += 1;
  }

  var_4312b985c2b7c9a1 = getdvarint(@ "hash_ed1c109feb095475", 0);
  var_3b73fa3a33104eee = getdvarint(@ "hash_2a74dbbdee7b0dda", 5);
  var_5215312348d094a9 = getdvarint(@ "hash_cc254e298e64f975", 10);
  var_c1569c52e0e8302c = getdvarint(@ "hash_1ce4d184eeef06c8", 20);

  if(var_4312b985c2b7c9a1) {
    var_5298efb8454b371d = level.var_aeb6974202e8f2db[killerclientnum];
    var_526ece09009a248 = undefined;

    if(var_5298efb8454b371d == var_3b73fa3a33104eee) {
      var_526ece09009a248 = function_2958a3067f4af3af("agent_milestone_kills1", level.var_4fc2ab8a1090c195);
    } else if(var_5298efb8454b371d == var_5215312348d094a9) {
      var_526ece09009a248 = function_2958a3067f4af3af("agent_milestone_kills2", level.var_4fc2ab8a1090c195);
    } else if(var_5298efb8454b371d == var_c1569c52e0e8302c) {
      var_526ece09009a248 = function_2958a3067f4af3af("agent_milestone_kills3", level.var_4fc2ab8a1090c195);
    }

    if(isDefined(var_526ece09009a248)) {
      foreach(lootdrop in var_526ece09009a248) {
        function_305b1ba9c9b7f7b4(droponground, lootdrop, agent, dropstruct);
      }

      level.var_4fc2ab8a1090c195 += 1;
    }
  }
}

function private function_a29c2459dec85fde(agent, agenttype, agentweapon, killerweapon, droponground, dropstruct) {
  var_597b60c5387d1344 = function_e266e0dfc04c07a9();
  droppedcount = 0;
  droparmor = scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata(agent, "dropArmor");

  if(!isDefined(droparmor) || istrue(droparmor)) {
    var_dbb496f03bd142a0 = function_bc5d7ff26ad67a45(agent, agenttype);

    if(getdvarint(@ "hash_f262cc542053d01c", 0) == 1) {
      function_305b1ba9c9b7f7b4(droponground, function_4fc5b97f88757e83(var_dbb496f03bd142a0), agent, dropstruct);
      droppedcount++;
    } else {
      var_597b60c5387d1344 = function_6b1dc8167c1c7378(var_597b60c5387d1344, var_dbb496f03bd142a0);
    }
  }

  dropgrenade = scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata(agent, "dropGrenade");

  if(!isDefined(dropgrenade) || istrue(dropgrenade)) {
    var_4a354a51b7352ef8 = scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata(agent, "grenadeType");

    if(isDefined(var_4a354a51b7352ef8)) {
      var_597b60c5387d1344 = function_d0f2ec7f450fcb7(var_597b60c5387d1344, var_4a354a51b7352ef8, agent.grenadeammo);
    }
  }

  dropammo = scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata(agent, "dropAmmo");

  if(!isDefined(dropammo) || istrue(dropammo)) {
    var_597b60c5387d1344 = function_4fd2e36bfd98b4c2(var_597b60c5387d1344, agentweapon, killerweapon);
  }

  if(!isDefined(level.var_b9a2a6440daf029)) {
    level.var_b9a2a6440daf029 = getdvarfloat(@ "hash_3545ca86ff96cb37", 0.34);
  }

  var_2b4dbedaecf1251d = getdvarint(@ "hash_df87d80be0df6f2e", 0);

  if(var_2b4dbedaecf1251d == 0) {
    var_2b4dbedaecf1251d = ter_op(randomfloat(1) > level.var_b9a2a6440daf029, 0, int(ceil(1 / level.var_b9a2a6440daf029)) + ter_op(randomfloat(1) < 0.4, 1, 0));
  }

  while(droppedcount < var_2b4dbedaecf1251d) {
    potentialdrop = random(var_597b60c5387d1344);

    if(!isDefined(potentialdrop)) {
      break;
    }

    if(randomfloat(1) < potentialdrop.dropchance) {
      function_305b1ba9c9b7f7b4(droponground, potentialdrop, agent, dropstruct);
      droppedcount++;
      var_597b60c5387d1344 = array_remove(var_597b60c5387d1344, potentialdrop);
    }
  }
}

function private function_79946c09ebe3b406(var_8051a869c25eb076, var_78ebfe48861e28d8) {
  lootpool = undefined;
  var_a6825f20b535b471 = getscriptcachecontents(var_8051a869c25eb076, var_78ebfe48861e28d8);

  if(isDefined(var_a6825f20b535b471)) {
    lootpool = [];

    foreach(lootscriptable in var_a6825f20b535b471) {
      lootpool[lootpool.size] = function_edabf4238e9d70b5(lootscriptable, scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(lootscriptable), lootscriptable, 1, level.br_pickups.counts[lootscriptable]);
    }
  }

  return lootpool;
}

function private function_2958a3067f4af3af(var_8051a869c25eb076, var_78ebfe48861e28d8) {
  lootpool = function_79946c09ebe3b406(var_8051a869c25eb076, var_78ebfe48861e28d8);

  if(!isDefined(lootpool)) {
    lootpool = [];
  }

  return lootpool;
}

function private function_e266e0dfc04c07a9() {
  if(!isDefined(level.var_8973f9da378e47d)) {
    level.var_8973f9da378e47d = 0;
  }

  lootpool = function_79946c09ebe3b406("agent_backpack", level.var_8973f9da378e47d);

  if(!isDefined(lootpool)) {
    if(level.var_8973f9da378e47d != 0) {
      level.var_8973f9da378e47d = 0;
      lootpool = function_e266e0dfc04c07a9();
      return lootpool;
    } else {
      lootpool = [];
    }
  }

  level.var_8973f9da378e47d += 1;
  return lootpool;
}

function private function_d0f2ec7f450fcb7(lootpool, grenadetype, grenadecount) {
  if(grenadecount > 0) {
    grenadecount = int(min(grenadecount, 2));
    grenaderef = scripts\mp\equipment::function_7f245729fcb6414d(grenadetype);

    if(!isDefined(grenaderef)) {
      return lootpool;
    }

    lootpool[lootpool.size] = function_edabf4238e9d70b5(level.var_370eed78aa5c01a5[grenadetype], scripts\cp_mp\utility\loot::getlootidfromref(grenaderef), grenaderef, 1, grenadecount);
  }

  return lootpool;
}

function private function_4fd2e36bfd98b4c2(lootpool, agentweapon, killerweapon) {
  if(!isDefined(agentweapon)) {
    return lootpool;
  }

  ammoref = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(agentweapon);

  if(isDefined(killerweapon) && (!isDefined(ammoref) || cointoss())) {
    var_5aba2fff7e326f4d = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(killerweapon);

    if(isDefined(var_5aba2fff7e326f4d)) {
      ammoref = var_5aba2fff7e326f4d;
    }
  }

  if(!isDefined(ammoref)) {
    return lootpool;
  }

  lootpool[lootpool.size] = function_edabf4238e9d70b5(ammoref, scripts\cp_mp\utility\loot::getlootidfromref(ammoref), ammoref, 1, level.br_pickups.counts[ammoref] * 2);
  return lootpool;
}

function private function_6b1dc8167c1c7378(lootpool, armorplatecount) {
  lootpool[lootpool.size] = function_4fc5b97f88757e83(armorplatecount);
  return lootpool;
}

function private function_4fc5b97f88757e83(armorplatecount) {
  return function_edabf4238e9d70b5("brloot_armor_plate", scripts\cp_mp\utility\loot::getlootidfromref("armor_plate"), "armor_plate", 1, armorplatecount);
}

function private function_bc5d7ff26ad67a45(agent, agenttype) {
  tier = scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata(agent, "tier");

  if(issubstr(agenttype, "jugg")) {
    return 3;
  } else if(isDefined(tier) && tier > 1) {
    return 2;
  }

  return 1;
}

function function_edabf4238e9d70b5(scriptablename, lootid, ref, dropchance, count, var_b926a393855a8b89, pickupcallback, visibilitycondition, var_69f4f638abf12fbf) {
  struct = spawnStruct();
  struct.scriptablename = scriptablename;
  struct.lootid = lootid;
  struct.ref = ref;
  struct.dropchance = ter_op(isDefined(dropchance), dropchance, 1);
  struct.count = ter_op(isDefined(count), count, 1);
  struct.var_b926a393855a8b89 = var_b926a393855a8b89;
  struct.callback = pickupcallback;
  struct.visibilitycondition = visibilitycondition;
  struct.var_69f4f638abf12fbf = var_69f4f638abf12fbf;
  struct.var_b30d9f22e554e6ee = function_c7663426fbfda6f3(scriptablename);
  return struct;
}

function private function_c7663426fbfda6f3(scriptablename) {
  isequipment = isDefined(scriptablename) && scripts\mp\gametypes\br_public::isequipment(scriptablename);
  isarmor = isDefined(scriptablename) && scripts\mp\gametypes\br_public::isarmor(scriptablename);
  isammo = isDefined(scriptablename) && scripts\mp\gametypes\br_public::isammo(scriptablename);
  return isequipment || isarmor || isammo;
}

function private function_305b1ba9c9b7f7b4(droponground, lootstruct, agent, dropstruct) {
  if(!isDefined(level.droptracking)) {
    level.droptracking = [];
  }

  if(istrue(lootstruct.var_b926a393855a8b89)) {
    if(istrue(level.droptracking[lootstruct.lootid])) {
      return false;
    } else {
      level.droptracking[lootstruct.lootid] = 1;
    }
  }

  if(!isDefined(level.var_7c24540cb1744ad9)) {
    level.var_7c24540cb1744ad9 = getdvarint(@ "scr_dmz_agentdroploadoutlootonground", 1);
  }

  droponground |= level.var_7c24540cb1744ad9 && istrue(lootstruct.var_b30d9f22e554e6ee);
  droponground |= getdvarint(@ "hash_142657a7943b806a", 0);

  if(droponground && isDefined(lootstruct.scriptablename)) {
    count = 1;

    if(isDefined(lootstruct.count)) {
      count = lootstruct.count;
    }

    dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, agent.origin, agent.angles, agent);

    if(scripts\mp\gametypes\dmz_dog_tag::function_3c17a26ce6a4668(lootstruct.lootid)) {
      [itemcount, itemcountlefthand, var_dab81ead77442a10] = scripts\mp\gametypes\dmz_dog_tag::function_379463a84adb07b4(lootstruct.count);
      spawned = scripts\mp\gametypes\br_pickups::spawnpickup(lootstruct.scriptablename, dropinfo, itemcount, 0, undefined, 0, itemcountlefthand, var_dab81ead77442a10);
    } else {
      spawned = scripts\mp\gametypes\br_pickups::spawnpickup(lootstruct.scriptablename, dropinfo, count);
    }

    if(isDefined(spawned)) {
      spawned setscriptablepartstate(spawned.type, "dropped");
    }

    if(!isDefined(agent.var_d544c62ea2bc64b)) {
      agent.var_d544c62ea2bc64b = [];
    }

    agent.var_d544c62ea2bc64b[agent.var_d544c62ea2bc64b.size] = lootstruct;
    return true;
  } else if(!droponground) {
    packitemindex = agent.contents.size;
    agent.contents[packitemindex] = [];
    agent.contents[packitemindex]["lootID"] = lootstruct.lootid;
    agent.contents[packitemindex]["quantity"] = lootstruct.count;
    agent.contents[packitemindex]["visibilityCondition"] = lootstruct.visibilitycondition;

    if(isDefined(lootstruct.callback)) {
      agent.contents[packitemindex]["callback"] = lootstruct.callback;
    }

    if(isDefined(lootstruct.var_69f4f638abf12fbf)) {
      scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata(agent, "dropCallback", lootstruct.var_69f4f638abf12fbf);
    }

    return false;
  }

  return false;
}

function private function_15497e2309bc8671(var_f1aef3eefc117534) {
  result = 0;
  subgametype = scripts\mp\utility\game::getsubgametype();

  switch (subgametype) {
    case #"hash_cfb0c3041d1bdc10":
    case #"hash_f4afff6c03d92aa0":
      result = function_32dc1e6e351c8b4d(var_f1aef3eefc117534);
      break;
    case #"hash_3c1c1566d7b3b870":
    case #"hash_dddecc2751311914":
    case #"hash_fa21c4f6bd5e3815":
      result = function_58681402ec6c855e(var_f1aef3eefc117534);
      break;
    default:
      return 0;
  }

  return result;
}

function private function_32dc1e6e351c8b4d(var_f1aef3eefc117534) {
  if(getdvarint(@ "hash_8fbb625100a40644", 1) == 0) {
    return false;
  }

  if(!isDefined(level.var_fc7f3410261c195)) {
    level.var_fc7f3410261c195 = 1;
  }

  if(!isDefined(level.var_c466cc3233c90122)) {
    level.var_c466cc3233c90122 = function_2234322152162663(level.var_fc7f3410261c195);
  }

  if(istrue(var_f1aef3eefc117534)) {
    level.var_c466cc3233c90122 -= 3;
  } else {
    level.var_c466cc3233c90122 -= 1;
  }

  if(level.var_c466cc3233c90122 <= 0) {
    if(level.var_fc7f3410261c195 < level.var_ef668b618c1c7ec0) {
      level.var_fc7f3410261c195 += 1;
    }

    level.var_c466cc3233c90122 = function_2234322152162663(level.var_fc7f3410261c195);
    return true;
  }

  return false;
}

function private function_58681402ec6c855e(var_f1aef3eefc117534) {
  return false;
}

function private function_2234322152162663(multiplier) {
  return randomintrange(3 * multiplier, 5 * multiplier);
}

function function_46c2d826ebb9e2cc(owner, origin, radius) {
  owner endon("death");
  streakname = "precision_airstrike";
  animname = level.scr_anim["precision_airstrike"]["airstrike_flyby"];
  strikeanimlength = getanimlength(animname);
  var_b333ee8fea365230 = strikeanimlength - 5;

  if(!isDefined(radius)) {
    radius = 0;
  }

  origin += (randomfloatrange(-1 * radius, radius), randomfloatrange(-1 * radius, radius), 0);
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(streakname, owner);
  scripts\cp_mp\utility\killstreak_utility::killstreak_dangernotifyplayersinrange(owner, owner.team, 2048, streakname, origin);
  scripts\cp_mp\killstreaks\airstrike::callstrike(owner, origin, undefined, undefined, streakinfo, animname);
}

function function_4a618b49270cfd25(owner, origin, radius) {
  owner endon("death");
  streakname = "toma_strike";
  var_a3f9130b1d11dffb = randomintrange(3, 6);
  striketype = 1;
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(streakname, owner);
  ownerlookforward = anglesToForward(owner.angles);
  ownerforward = anglesToForward(owner.angles);
  ownerright = anglestoright(owner.angles);

  if(!isDefined(radius)) {
    radius = 0;
  }

  origin += (randomfloatrange(-1 * radius, radius), randomfloatrange(-1 * radius, radius), 0);
  scripts\cp_mp\utility\killstreak_utility::killstreak_dangernotifyplayersinrange(owner, owner.team, 2048, streakname, origin);

  for(j = 0; j < var_a3f9130b1d11dffb; j++) {
    bombinginfo = owner scripts\cp_mp\killstreaks\toma_strike::findunobstructedfiringinfo(origin, 1024, ownerlookforward, ownerforward, ownerright);
    owner thread scripts\cp_mp\killstreaks\toma_strike::tomastrike_firestrike(striketype, bombinginfo, streakinfo);
    timetowait = randomfloatrange(0.25, 1);
    wait timetowait;
  }
}

function function_97f7612a16157077(var_a4e4a71852a83d8f, infiltype) {
  tempstruct = spawnStruct();
  tempstruct.spawnorigin = var_a4e4a71852a83d8f.origin;
  tempstruct.var_1cff9e659279986 = var_a4e4a71852a83d8f.reinforceorigin;
  tempstruct.arrivalorigin = var_a4e4a71852a83d8f.unloadorigin;
  tempstruct.infiltype = infiltype;
  tempstruct.locationsprocessed = 0;
  level.var_a24b3aaa582fe5e3 = tempstruct;
}

function function_63bc1945791044c9() {
  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  wait 1;
  level.var_f43197e4f524c1f7 = getStructArray("<dev string:xe09>", "<dev string:xe1a>");
  numtospawn = getdvarint(@ "hash_98d02294a9885211", 0);

  for(i = 0; i < numtospawn; i++) {
    if(isDefined(level.var_f43197e4f524c1f7[i])) {
      agent = function_a04953ad5de27960(level.var_f43197e4f524c1f7[i]);
    }
  }
}

function function_a04953ad5de27960(node) {
  aitype = function_d5bc07eabf352abb(node);
  agent = ai_mp_requestspawnagent(aitype, node.origin, node.angles, "<dev string:xe2f>", "<dev string:xe37>", "<dev string:xe46>");

  if(isDefined(agent)) {
    agent thread function_9bbf1713a14fa580(agent);
  }

  return agent;
}

function function_316bbc591b24792a() {
  while(true) {
    foreach(agent in level.agentarray) {
      if(!isalive(agent)) {
        continue;
      }

      foreach(player in level.players) {
        if(agent cansee(player)) {
          println("<dev string:xe4f>");
          continue;
        }

        see = 0;
      }
    }

    waitframe();
  }
}

function function_bd78689b17ee5ca5(textx, texty, poiname, enabledcolor) {
  printtoscreen2d(textx, texty, poiname, enabledcolor, 2);
  printtoscreen2d(textx, texty + 20, "<dev string:xe60>", enabledcolor, 1);
  printtoscreen2d(textx, texty + 40, "<dev string:xe82>" + function_abbd4595d76ccc5e(poiname, "<dev string:xe91>"), (0, 0, 1), 1);
  printtoscreen2d(textx, texty + 60, "<dev string:xe9e>" + function_abbd4595d76ccc5e(poiname, "<dev string:xead>"), (0, 1, 1), 1);
  printtoscreen2d(textx, texty + 80, "<dev string:xeb9>" + function_abbd4595d76ccc5e(poiname, "<dev string:x3d9>"), (1, 0.5, 0), 1);
  printtoscreen2d(textx, texty + 100, "<dev string:xec5>" + function_abbd4595d76ccc5e(poiname, "<dev string:xed7>"), (1, 0, 0), 1);
  printtoscreen2d(textx, texty + 120, "<dev string:xee6>" + function_abbd4595d76ccc5e(poiname, "<dev string:xef9>"), (1, 0, 0), 1);
  printtoscreen2d(textx, texty + 140, "<dev string:xf09>" + function_abbd4595d76ccc5e(poiname, "<dev string:xf20>"), (0, 1, 0), 1);
  printtoscreen2d(textx, texty + 160, "<dev string:xf33>" + function_abbd4595d76ccc5e(poiname, "<dev string:xf48>"), (1, 1, 1), 1);
  printtoscreen2d(textx, texty + 180, "<dev string:xf5a>" + function_abbd4595d76ccc5e(poiname, "<dev string:xf70>"), (1, 1, 1), 1);
  printtoscreen2d(textx, texty + 200, "<dev string:xf83>" + function_abbd4595d76ccc5e(poiname, "<dev string:xf97>"), (0, 0, 1), 1);
}

function function_7b85b68e72867306(poiinfo) {
  textx = 100;
  texty = 100;
  var_a2d7918a1c23c968 = [];
  var_a2d7918a1c23c968["<dev string:xead>"] = "<dev string:xfa9>";
  var_a2d7918a1c23c968["<dev string:x3d9>"] = "<dev string:xfc1>";
  var_a2d7918a1c23c968["<dev string:xed7>"] = "<dev string:xfdb>";
  var_a2d7918a1c23c968["<dev string:xef9>"] = "<dev string:xfdb>";
  var_a2d7918a1c23c968["<dev string:xf20>"] = "<dev string:xff2>";
  var_a2d7918a1c23c968["<dev string:xf48>"] = "<dev string:x100b>";
  var_a2d7918a1c23c968["<dev string:xf70>"] = "<dev string:x100b>";
  var_a2d7918a1c23c968["<dev string:xf97>"] = "<dev string:x1024>";
  var_a2d7918a1c23c968["<dev string:x106>"] = "<dev string:x103c>";
  var_a2d7918a1c23c968["<dev string:x1056>"] = "<dev string:x100b>";

  foreach(poiname in level.poi_names) {
    dvarstring = hashcat(@ "hash_831b14ba4dbdd316", poiname, "<dev string:x1066>");

    if(getdvarint(dvarstring, 0) == 1 || getdvarint(@ "hash_6e6e9391065dc426", 0)) {
      assertex(isDefined(level.var_41670c1c65f3d3cf.poi[poiname]), poiname + "<dev string:x1070>");

      if(isDefined(level.var_41670c1c65f3d3cf.poi[poiname])) {
        if(!poiinfo.var_6ad2d5385a612cd5[poiname].outlined) {
          poiinfo.var_6ad2d5385a612cd5[poiname].outlined = 1;

          foreach(agent in function_7e3f22e620f3f71e(poiname, "<dev string:xe91>")) {
            if(isalive(agent)) {
              outlineasset = "<dev string:x10af>";

              if(isDefined(agent.category) && isDefined(var_a2d7918a1c23c968[agent.category])) {
                outlineasset = var_a2d7918a1c23c968[agent.category];
              } else {
                assertmsg("<dev string:x10c8>" + poiname + "<dev string:x10fa>" + agent.category);
              }

              id = scripts\mp\utility\outline::outlineenableforall(agent, outlineasset, "<dev string:x111a>");

              if(!isDefined(poiinfo.var_6ad2d5385a612cd5[poiname].agents[id])) {
                poiinfo.var_6ad2d5385a612cd5[poiname].agents[id] = agent;
                agent.outlined = 1;
              }
            }
          }
        } else if(poiinfo.var_6ad2d5385a612cd5[poiname].numagents != function_abbd4595d76ccc5e(poiname, "<dev string:xe91>")) {
          if(poiinfo.var_6ad2d5385a612cd5[poiname].numagents < function_abbd4595d76ccc5e(poiname, "<dev string:xe91>")) {
            foreach(agent in function_7e3f22e620f3f71e(poiname, "<dev string:xe91>")) {
              if(isalive(agent) && (!isDefined(agent.outlined) || !agent.outlined)) {
                outlineasset = "<dev string:x10af>";

                if(isDefined(agent.category) && isDefined(var_a2d7918a1c23c968[agent.category])) {
                  outlineasset = var_a2d7918a1c23c968[agent.category];
                } else {
                  assertmsg("<dev string:x10c8>" + poiname + "<dev string:x112a>" + agent.category);
                }

                id = scripts\mp\utility\outline::outlineenableforall(agent, outlineasset, "<dev string:x111a>");

                if(!isDefined(poiinfo.var_6ad2d5385a612cd5[poiname].agents[id])) {
                  poiinfo.var_6ad2d5385a612cd5[poiname].agents[id] = agent;
                  agent.outlined = 1;
                }
              }
            }
          }

          poiinfo.var_6ad2d5385a612cd5[poiname].numagents = function_abbd4595d76ccc5e(poiname, "<dev string:xe91>");
        }
      }

      if(array_contains(level.var_ab20b3a256911579, poiname)) {
        enabledcolor = (1, 0, 0);
      } else {
        enabledcolor = (0, 1, 0);
      }

      if(isDefined(level.var_41670c1c65f3d3cf.poi[poiname])) {
        function_bd78689b17ee5ca5(textx, texty, poiname, enabledcolor);
      }

      textx += 200;

      if(textx == 1700) {
        textx = 100;
        texty = 400;
      }

      continue;
    }

    if(isDefined(level.var_41670c1c65f3d3cf.poi[poiname])) {
      if(getdvarint(dvarstring, 0) == 0 && poiinfo.var_6ad2d5385a612cd5[poiname].outlined) {
        foreach(id, agent in poiinfo.var_6ad2d5385a612cd5[poiname].agents) {
          if(isalive(agent)) {
            scripts\mp\utility\outline::outlinedisable(id, agent);
          }

          poiinfo.var_6ad2d5385a612cd5[poiname].agents[id] = undefined;
          poiinfo.var_6ad2d5385a612cd5[poiname].outlined = 0;
          agent.outlined = undefined;
        }
      }
    }
  }
}

function function_116a9a03ed8bebee(aiinfo) {
  aiinfo.disabledoutlines = !getdvarint(@ "hash_ddc16ff13bb547db", 0);

  if(!aiinfo.disabledoutlines) {
    if(!isDefined(level.agentarray)) {
      return;
    }

    foreach(agent in level.agentarray) {
      if(isalive(agent)) {
        if(isDefined(agent.outlines) && agent.outlines.size > 0) {
          continue;
        }

        id = scripts\mp\utility\outline::outlineenableforall(agent, "<dev string:x1148>", "<dev string:x111a>");
        aiinfo.aioutlines[id] = agent;
      }
    }

    return;
  }

  foreach(id, agent in aiinfo.aioutlines) {
    if(isalive(agent)) {
      scripts\mp\utility\outline::outlinedisable(id, agent);
    }

    aiinfo.aioutlines[id] = undefined;
  }
}

function function_f44f49a345c4a1f0(var_ae626a6e4fde83b2) {
  if(getdvarint(@ "hash_eea0b8db6857e8e1", 0) == 1) {
    if(var_ae626a6e4fde83b2.var_4ed3980e80a4c5c9) {
      var_ae626a6e4fde83b2.var_4ed3980e80a4c5c9 = 0;

      foreach(agent in function_7eb04ca16d045775("<dev string:xead>")) {
        if(isalive(agent) && distance(level.player.origin, agent.origin) < getdvarint(@ "hash_354e12ea3dd218ff", 5000)) {
          id = scripts\mp\utility\outline::outlineenableforall(agent, "<dev string:x1166>", "<dev string:x111a>");

          if(!isDefined(var_ae626a6e4fde83b2.var_69a1fe96c22ba481[id])) {
            var_ae626a6e4fde83b2.var_69a1fe96c22ba481[id] = agent;
          }
        }
      }
    }
  } else if(!var_ae626a6e4fde83b2.var_4ed3980e80a4c5c9) {
    var_ae626a6e4fde83b2.var_4ed3980e80a4c5c9 = 1;

    foreach(id, agent in var_ae626a6e4fde83b2.var_69a1fe96c22ba481) {
      if(isalive(agent)) {
        scripts\mp\utility\outline::outlinedisable(id, agent);
      }

      var_ae626a6e4fde83b2.var_69a1fe96c22ba481[id] = undefined;
    }
  }

  if(getdvarint(@ "hash_98991913f1b99ae3", 0) == 1) {
    if(var_ae626a6e4fde83b2.enabledenemies) {
      var_ae626a6e4fde83b2.enabledenemies = 0;

      foreach(agent in function_7eb04ca16d045775("<dev string:xe91>")) {
        if(isalive(agent) && agent.category != "<dev string:xead>" && distance(level.player.origin, agent.origin) < getdvarint(@ "hash_354e12ea3dd218ff", 5000)) {
          id = scripts\mp\utility\outline::outlineenableforall(agent, "<dev string:x1183>", "<dev string:x111a>");

          if(!isDefined(var_ae626a6e4fde83b2.var_69a1fe96c22ba481[id])) {
            var_ae626a6e4fde83b2.var_69a1fe96c22ba481[id] = agent;
          }
        }
      }
    }

    return;
  }

  if(!var_ae626a6e4fde83b2.enabledenemies) {
    var_ae626a6e4fde83b2.enabledenemies = 1;

    foreach(id, agent in var_ae626a6e4fde83b2.var_69a1fe96c22ba481) {
      if(isalive(agent)) {
        scripts\mp\utility\outline::outlinedisable(id, agent);
      }

      var_ae626a6e4fde83b2.var_69a1fe96c22ba481[id] = undefined;
    }
  }
}

function function_8366a665eecd13aa() {
  level endon("<dev string:x119e>");
  setdvarifuninitialized(@ "hash_6e6e9391065dc426", 0);
  poiinfo = spawnStruct();
  poiinfo.var_6ad2d5385a612cd5 = [];
  wait 2;

  foreach(poiname in level.poi_names) {
    if(!isDefined(level.var_41670c1c65f3d3cf.poi[poiname])) {
      continue;
    }

    command = "<dev string:x11ac>" + poiname + "<dev string:x11dd>" + poiname + "<dev string:x11f3>";
    adddebugcommand(command);
    poiinfo.var_6ad2d5385a612cd5[poiname] = spawnStruct();
    poiinfo.var_6ad2d5385a612cd5[poiname].outlined = 0;
    poiinfo.var_6ad2d5385a612cd5[poiname].agents = [];
    poiinfo.var_6ad2d5385a612cd5[poiname].numagents = function_abbd4595d76ccc5e(poiname, "<dev string:xe91>");
    setdvarifuninitialized(hashcat(@ "hash_831b14ba4dbdd316", poiname, "<dev string:x1066>"), 0);
    wait 0.1;
    command = "<dev string:x1202>" + poiname + "<dev string:x11dd>" + poiname + "<dev string:x1242>";
    adddebugcommand(command);
    wait 0.1;
    setdvarifuninitialized(hashcat(@ "hash_831b14ba4dbdd316", poiname, "<dev string:x1259>"), 0);
    command = "<dev string:x126b>" + poiname + "<dev string:x11dd>" + poiname + "<dev string:x12a9>";
    adddebugcommand(command);
    wait 0.1;
    setdvarifuninitialized(hashcat(@ "hash_831b14ba4dbdd316", poiname, "<dev string:x12be>"), 0);
    command = "<dev string:x12ce>" + poiname + "<dev string:x11dd>" + poiname + "<dev string:x130d>";
    adddebugcommand(command);
    wait 0.1;
    setdvarifuninitialized(hashcat(@ "hash_831b14ba4dbdd316", poiname, "<dev string:x1323>"), 0);
    command = "<dev string:x1334>" + poiname + "<dev string:x11dd>" + poiname + "<dev string:x1377>";
    adddebugcommand(command);
    wait 0.1;
    setdvarifuninitialized(hashcat(@ "hash_831b14ba4dbdd316", poiname, "<dev string:x138a>"), 0);
    wait 0.2;
  }

  level thread function_8b97c47b557d1c58();
  level thread function_9fae03fa905ef5ce();
  level thread function_8c74d71ffba1bda8();
  level thread function_389b1801f508c3f0();

  while(true) {
    function_7b85b68e72867306(poiinfo);
    waitframe();
  }
}

function function_4c9c67fd4525f9fe() {
  level endon("<dev string:x119e>");
  setdvarifuninitialized(@ "hash_eea0b8db6857e8e1", 0);
  setdvarifuninitialized(@ "hash_98991913f1b99ae3", 0);
  setdvarifuninitialized(@ "hash_ddc16ff13bb547db", 0);
  setdvarifuninitialized(@ "hash_eea0b8db6857e8e1", 0);
  setdvarifuninitialized(@ "hash_bcbe3309344bb6d2", 0);
  setdvarifuninitialized(@ "hash_9e9be127028294d2", 0);
  setdvarifuninitialized(@ "hash_354e12ea3dd218ff", 5000);
  aiinfo = spawnStruct();
  aiinfo.aioutlines = [];
  aiinfo.disabledoutlines = 1;
  var_ae626a6e4fde83b2 = spawnStruct();
  var_ae626a6e4fde83b2.var_69a1fe96c22ba481 = [];
  var_ae626a6e4fde83b2.var_4ed3980e80a4c5c9 = 1;
  var_ae626a6e4fde83b2.enabledenemies = 1;

  while(true) {
    function_116a9a03ed8bebee(aiinfo);
    function_f44f49a345c4a1f0(var_ae626a6e4fde83b2);
    waitframe();
  }
}

function function_576ed049f93d9496() {
  level endon("<dev string:x119e>");
  setdevdvar(@ "hash_834fda4cebd6161e", 0);

  while(true) {
    if(getdvarint(@ "hash_7e32df0ad3c385c1", 0) == 1) {
      setdevdvar(@ "debug_stealth", 0);
      setdevdvar(@ "hash_3493aa8adc34457e", 0);
      setdevdvar(@ "hash_2b47d7c6e19149b9", 0);
      setdevdvar(@ "hash_834fda4cebd6161e", 0);
      setdevdvar(@ "hash_7f1d33bb4719a3c2", 0);
      setdevdvar(@ "hash_ddc16ff13bb547db", 0);
      setdevdvar(@ "hash_eea0b8db6857e8e1", 0);
      setdevdvar(@ "hash_98991913f1b99ae3", 0);
      setdevdvar(@ "hash_1d8682eb59219492", 0);
      setdevdvar(@ "hash_bcbe3309344bb6d2", 0);
      setdevdvar(@ "hash_9e9be127028294d2", 0);
      setdevdvar(@ "hash_7e32df0ad3c385c1", 0);

      foreach(poiname, poi in level.poi) {
        setdevdvar(hashcat(@ "hash_831b14ba4dbdd316", poiname, "<dev string:x1259>"), 0);
      }
    }

    var_5a77a5f00881f00c = getdvarint(@ "hash_7f1d33bb4719a3c2", 0);

    if(var_5a77a5f00881f00c == 1) {
      if(!istrue(level.supportsai)) {
        printtoscreen2d(1000, 100, "<dev string:x1398>", (0, 0, 1), 2.5);
      } else {
        topxpos = 50;
        printtoscreen2d(topxpos, 54, "<dev string:x13ab>" + function_e884d14c5b07b811(), (0, 0, 1), 2.5);
        topxpos += 250;
        printtoscreen2d(topxpos, 50, "<dev string:x13b6>" + function_e8c0ac958d093ec2() + "<dev string:x13c3>" + level.var_41670c1c65f3d3cf.maxagents, (0, 0, 1), 1.5);
        topxpos += 250;
        printtoscreen2d(topxpos, 50, "<dev string:x13c8>" + function_1c0a768a2d940491(), (0, 0, 1), 1.5);
        topxpos += 200;
        printtoscreen2d(topxpos, 50, "<dev string:x13d5>" + function_9368fb9261e4cd0a("<dev string:x106>"), (0, 0, 1), 1.5);
        topxpos += 200;
        printtoscreen2d(topxpos, 50, "<dev string:x13e2>" + function_9368fb9261e4cd0a("<dev string:xf97>"), (0, 0, 1), 1.5);
        topxpos += 200;
        printtoscreen2d(topxpos, 50, "<dev string:x13f1>" + level.var_41670c1c65f3d3cf.agentdeaths, (0, 0, 1), 1.5);

        if(poi_issystemactive()) {
          printtoscreen2d(topxpos + 300, 50, "<dev string:x1403>" + level.poi_names.size, (0, 0, 1), 1.5);
          numlines = 0;
          x = 50;
          y = 90;

          foreach(poiname, poi in level.poi) {
            if(var_5a77a5f00881f00c == 1 && array_contains(level.var_ab20b3a256911579, poiname)) {
              continue;
            }

            var_fa8640cd2623b8c0 = function_491f405f5622af52(poiname, x, y);

            if(var_fa8640cd2623b8c0 > numlines) {
              numlines = var_fa8640cd2623b8c0;
            }

            x += 230;

            if(x > 1600) {
              y += numlines * 22;
              x = 50;
              numlines = 0;
            }
          }
        } else {
          x = 200;
          pos = 160;
          pos += 10;
          printtoscreen2d(x, pos, "<dev string:x140d>", (0, 0, 1), 1);
          pos += 12;
          printtoscreen2d(x, pos, "<dev string:x142b>", (0, 0, 1), 1);
          pos += 12;
          printtoscreen2d(x, pos, "<dev string:x140d>", (0, 0, 1), 1);
          pos += 16;

          foreach(key in function_d20fe6bad41c065c()) {
            if(key != "<dev string:xe91>") {
              firststring = key + "<dev string:xcb8>";
              secondstring = function_718d435f9750c1b5(key);
              thirdstring = "<dev string:x13c3>" + function_9a83377c98bce82a(key);
              printtoscreen2d(x, pos, firststring, (0, 0, 1), 1);
              tempx = x + firststring.size * 10;
              printtoscreen2d(tempx, pos, secondstring, (0, 1, 0), 1);
              tempx += secondstring * 10;
              printtoscreen2d(tempx, pos, thirdstring, (0, 0, 1), 1);
              pos += 20;
            }
          }

          pos += 10;
          printtoscreen2d(x, pos, "<dev string:x143e>" + level.var_41670c1c65f3d3cf.agentdeaths, (0, 0, 1), 1);
          pos += 12;
          printtoscreen2d(x, pos, "<dev string:x140d>", (0, 0, 1), 1);
          pos += 12;
          printtoscreen2d(x, pos, "<dev string:x1450>" + function_9a83377c98bce82a("<dev string:xe91>") + "<dev string:x145f>" + function_3813364e2323b789(), (0, 0, 1), 1);
          pos += 12;
          printtoscreen2d(x, pos, "<dev string:x140d>", (0, 0, 1), 1);
        }
      }
    }

    if(var_5a77a5f00881f00c == 2) {
      printtoscreen2d(100, 54, "<dev string:x13ab>" + function_e884d14c5b07b811() + "<dev string:x145f>" + level.var_41670c1c65f3d3cf.maxagents, (0, 0, 1), 2.5);
      printtoscreen2d(450, 50, "<dev string:x13d5>" + function_9368fb9261e4cd0a("<dev string:x106>"), (0, 0, 1), 1.5);
      printtoscreen2d(750, 50, "<dev string:x13e2>" + function_9368fb9261e4cd0a("<dev string:xf97>"), (0, 0, 1), 1.5);
      printtoscreen2d(1050, 50, "<dev string:x13f1>" + level.var_41670c1c65f3d3cf.agentdeaths, (0, 0, 1), 1.5);

      if(poi_issystemactive()) {
        printtoscreen2d(1300, 50, "<dev string:x1403>" + level.poi_names.size, (0, 0, 1), 1.5);
        x = 50;
        y = 90;

        foreach(poiname, poi in level.poi) {
          if(array_contains(level.var_ab20b3a256911579, poiname)) {
            continue;
          }

          function_6fb8f59559dfa4a7(poiname, x, y);
          x += 230;

          if(x > 1600) {
            y += 380;
            x = 50;
          }
        }
      }
    }

    if(var_5a77a5f00881f00c == 5) {
      if(!istrue(level.supportsai)) {
        printtoscreen2d(750, 100, "<dev string:x1466>", (0, 0, 1), 2.5);
      } else if(isDefined(level.startracker)) {
        if(poi_issystemactive()) {
          startx = 150;
          starty = 100;
          x = startx;
          y = starty;

          foreach(poiname, poi in level.poi) {
            if(!isDefined(level.startracker[poiname])) {
              continue;
            }

            pos = y;
            printtoscreen2d(x, pos, poiname, (0, 0, 1), 2);
            pos += 12;
            printtoscreen2d(x, pos, "<dev string:xe60>", (0, 0, 1), 1);
            pos += 20;
            color = (0, 1, 0);

            switch (level.startracker[poiname].starlevel) {
              case 1:
                color = (1, 1, 0);
                break;
              case 2:
                color = (1, 0.75, 0);
                break;
              case 3:
                color = (1, 0.35, 0);
                break;
              case 4:
                color = (1, 0, 0);
                break;
            }

            printtoscreen2d(x, pos, "<dev string:x1491>" + level.startracker[poiname].starlevel, color, 1.5);
            pos += 12;
            printtoscreen2d(x, pos, "<dev string:xe60>", (0, 0, 1), 1);
            pos += 16;
            printtoscreen2d(x, pos, "<dev string:x14a1>" + level.startracker[poiname].starmeter, (0, 0, 1), 1);
            pos += 20;
            printtoscreen2d(x, pos, "<dev string:x14b1>" + level.startracker[poiname].var_924d5d49fde54cdd, (0, 0, 1), 1);
            pos += 20;
            printtoscreen2d(x, pos, "<dev string:x14c7>", (0, 0, 1), 1);
            pos += 20;
            printtoscreen2d(x, pos, "<dev string:x14e1>" + level.startracker[poiname].var_19d6896c9e881cc4, (0, 0, 1), 1);
            pos += 20;

            if(level.startracker[poiname].starlevel == 4) {
              requirements = 0;
            } else {
              requirements = level.var_1a6233bc0d61faf.reqreinforcements[level.startracker[poiname].starlevel] - level.startracker[poiname].var_a93671354b676c18;
            }

            printtoscreen2d(x, pos, "<dev string:x14f7>" + requirements, (0, 0, 1), 1);
            pos += 20;
            printtoscreen2d(x, pos, "<dev string:x14c7>", (0, 0, 1), 1);
            pos += 20;
            printtoscreen2d(x, pos, "<dev string:x150f>" + level.startracker[poiname].var_38951249a8cf8968, (0, 0, 1), 1);
            pos += 20;
            printtoscreen2d(x, pos, "<dev string:x1519>" + level.startracker[poiname].var_fe385543116077b5, (0, 0, 1), 1);
            pos += 20;
            printtoscreen2d(x, pos, "<dev string:x152a>" + level.startracker[poiname].var_55cf9e4f74d2f4c2, (0, 0, 1), 1);
            pos += 20;
            printtoscreen2d(x, pos, "<dev string:x1536>" + level.startracker[poiname].var_356bde2b53efa8cf, (0, 0, 1), 1);
            x += 250;

            if(x > 1750) {
              x = startx;
              starty += 325;
              y = starty;
            }
          }
        } else {
          printtoscreen2d(400, 50, "<dev string:x1491>" + level.startracker.starlevel, (1, 1, 1), 1);
          printtoscreen2d(400, 70, "<dev string:x14a1>" + level.startracker.starmeter, (1, 1, 1), 1);
          printtoscreen2d(400, 90, "<dev string:x14b1>" + level.startracker.var_924d5d49fde54cdd, (1, 1, 1), 1);
          printtoscreen2d(400, 110, "<dev string:x14c7>", (1, 1, 1), 1);
          printtoscreen2d(400, 130, "<dev string:x14e1>" + level.startracker.var_19d6896c9e881cc4, (1, 1, 1), 1);
          printtoscreen2d(400, 150, "<dev string:x14f7>" + level.var_1a6233bc0d61faf.reqreinforcements[level.startracker.starlevel] - level.startracker.var_a93671354b676c18, (1, 1, 1), 1);
          printtoscreen2d(400, 170, "<dev string:x14c7>", (0, 0, 1), 1);
          printtoscreen2d(400, 190, "<dev string:x150f>" + level.startracker.var_38951249a8cf8968, (0, 0, 1), 1);
          printtoscreen2d(400, 210, "<dev string:x1519>" + level.startracker.var_fe385543116077b5, (0, 0, 1), 1);
          printtoscreen2d(400, 230, "<dev string:x152a>" + level.startracker.var_55cf9e4f74d2f4c2, (0, 0, 1), 1);
          printtoscreen2d(400, 250, "<dev string:x1536>" + level.startracker.var_356bde2b53efa8cf, (0, 0, 1), 1);
        }
      } else {
        printtoscreen2d(750, 100, "<dev string:x1540>", (0, 0, 1), 2.5);
      }
    }

    if(getdvarint(@ "hash_959247ebc7eac6b5", 0) == 1) {
      println("<dev string:x155a>");
      println("<dev string:x1583>");
      println("<dev string:x155a>");

      if(!poi_issystemactive()) {
        println("<dev string:x15a4>" + function_9a83377c98bce82a("<dev string:xe91>") + "<dev string:x145f>" + level.var_41670c1c65f3d3cf.maxagents);
        println("<dev string:x15b5>" + function_9a83377c98bce82a("<dev string:xead>"));
      } else {
        println("<dev string:x15a4>" + function_9a83377c98bce82a("<dev string:xe91>") + "<dev string:x145f>" + level.var_41670c1c65f3d3cf.maxagents);
        civmax = getdvarint(@ "hash_bd4798a9b7d01479", 8) * level.poi.size;
        println("<dev string:x15b5>" + function_9a83377c98bce82a("<dev string:xead>") + "<dev string:x145f>" + civmax);
      }

      println("<dev string:x155a>");
      println("<dev string:x15c6>");
      println("<dev string:x155a>");
      setdevdvar(@ "hash_959247ebc7eac6b5", 0);
    }

    if(var_5a77a5f00881f00c == 4) {
      if(poi_issystemactive()) {
        x = 250;
        pos = 100;

        foreach(poiname, poi in level.poi) {
          printtoscreen2d(x, pos, poiname, (0, 0, 1), 2);
          pos += 20;

          if(isDefined(level.var_41670c1c65f3d3cf.poi[poiname].var_8bcd79921ba8147e) && isDefined(level.var_41670c1c65f3d3cf.poi[poiname].agentdeaths)) {
            printtoscreen2d(x, pos, "<dev string:x15e5>" + level.var_41670c1c65f3d3cf.poi[poiname].var_8bcd79921ba8147e - level.var_41670c1c65f3d3cf.poi[poiname].agentdeaths, (0, 0, 1), 1.2);
          } else {
            printtoscreen2d(x, pos, "<dev string:x1610>", (0, 0, 1), 1.2);
          }

          pos += 12;
          printtoscreen2d(x, pos, "<dev string:x163e>", (0, 0, 1), 1);
          pos += 20;

          if(!isDefined(level.var_41670c1c65f3d3cf.poi[poiname].var_a87122636ff072d3)) {
            text = "<dev string:x1656>";
          } else {
            text = level.var_41670c1c65f3d3cf.poi[poiname].var_a87122636ff072d3;
          }

          printtoscreen2d(x, pos, text, (0, 0, 1), 1);
          pos += 25;
          printtoscreen2d(x, pos, "<dev string:x1673>", (0, 0, 1), 1.2);
          pos += 12;
          printtoscreen2d(x, pos, "<dev string:x163e>", (0, 0, 1), 1);
          pos += 20;
          reinforcementstring = "<dev string:x313>";

          if(!isDefined(level.var_41670c1c65f3d3cf.poi[poiname].reinforcementqueue) || level.var_41670c1c65f3d3cf.poi[poiname].reinforcementqueue.size == 0) {
            reinforcementstring = "<dev string:x168a>";
          } else {
            foreach(numagents in level.var_41670c1c65f3d3cf.poi[poiname].reinforcementqueue) {
              reinforcementstring = reinforcementstring + "<dev string:x1699>" + numagents;
            }
          }

          printtoscreen2d(x, pos, reinforcementstring, (0, 0, 1), 1);
          pos += 50;

          if(pos > 1000) {
            x += 450;
            pos = 100;
          }
        }
      } else {
        pos = 50;
        printtoscreen2d(700, pos, "<dev string:x169e>", (1, 1, 1), 1);
        pos += 20;
        printtoscreen2d(700, pos, "<dev string:x16af>", (1, 1, 1), 1);
        pos += 20;
        printtoscreen2d(700, pos, level.var_a87122636ff072d3, (1, 1, 1), 1);
        pos += 40;
        printtoscreen2d(700, pos, "<dev string:x1673>", (1, 1, 1), 1);
        pos += 20;
        printtoscreen2d(700, pos, "<dev string:x163e>", (1, 1, 1), 1);
        pos += 20;
        reinforcementstring = "<dev string:x313>";

        if(level.var_41670c1c65f3d3cf.reinforcementqueue.size == 0) {
          reinforcementstring = "<dev string:x168a>";
        } else {
          foreach(numagents in level.var_41670c1c65f3d3cf.reinforcementqueue) {
            reinforcementstring = reinforcementstring + "<dev string:x1699>" + numagents;
          }
        }

        printtoscreen2d(700, pos, reinforcementstring, (1, 1, 1), 1);
      }
    }

    waitframe();
  }
}

function function_491f405f5622af52(poiname, x, y) {
  pos = y;
  numlines = 0;
  colorheading = (0, 0, 1);
  colorbody = (0, 0, 1);

  if(array_contains(level.var_ab20b3a256911579, poiname)) {
    colorheading = (1, 0, 0);
    colorbody = (0, 0, 1);
  }

  pos += 10;
  printtoscreen2d(x, pos, "<dev string:x140d>", colorbody, 1);
  pos += 12;
  printtoscreen2d(x, pos, poiname, colorbody, 1);
  pos += 12;
  printtoscreen2d(x, pos, "<dev string:x140d>", colorbody, 1);
  pos += 16;
  numlines += 3;

  foreach(key in function_d7df76a9938f5871(poiname)) {
    if(key != "<dev string:xe91>") {
      firststring = key + "<dev string:xcb8>";
      secondstring = function_bd71347864330395(function_7e3f22e620f3f71e(poiname, key));
      thirdstring = "<dev string:x13c3>" + function_abbd4595d76ccc5e(poiname, key);
      printtoscreen2d(x, pos, firststring, (0, 0, 1), 1);
      tempx = x + 150;
      printtoscreen2d(tempx, pos, secondstring, (0, 1, 0), 1);
      tempx += "<dev string:x313>" + secondstring.size * 10;
      printtoscreen2d(tempx, pos, thirdstring, (0, 0, 1), 1);
      pos += 20;
      numlines++;
    }
  }

  pos += 10;
  printtoscreen2d(x, pos, "<dev string:x143e>" + level.var_41670c1c65f3d3cf.poi[poiname].agentdeaths, colorbody, 1);
  pos += 12;
  printtoscreen2d(x, pos, "<dev string:x140d>", colorbody, 1);
  pos += 12;
  printtoscreen2d(x, pos, "<dev string:x1450>" + function_abbd4595d76ccc5e(poiname, "<dev string:xe91>"), colorbody, 1);
  pos += 12;
  printtoscreen2d(x, pos, "<dev string:x140d>", colorbody, 1);
  numlines += 4;
  return numlines;
}

function function_6fb8f59559dfa4a7(poiname, x, y) {
  pos = y;
  poi = level.poi[poiname];
  colorheading = (0, 0, 1);
  colorbody = (0, 0, 1);
  pos += 10;
  printtoscreen2d(x, pos, "<dev string:x140d>", colorbody, 1);
  pos += 12;
  printtoscreen2d(x, pos, poiname, colorbody, 1);
  pos += 12;
  printtoscreen2d(x, pos, "<dev string:x140d>", colorbody, 1);
  pos += 16;

  foreach(subarea in poi["<dev string:x16c1>"]) {
    color = colorbody;
    extratext = "<dev string:x313>";

    if(istrue(subarea.isshutdown)) {
      color = (1, 0, 0);
      extratext = "<dev string:x16cd>";
    }

    printtoscreen2d(x, pos, subarea.var_71ad22c5d093d90b + "<dev string:xcb8>" + subarea.var_3ebb6024e3f220ca.size + "<dev string:x1699>" + extratext, colorbody, 1);
    pos += 20;
  }

  pos += 12;
  printtoscreen2d(x, pos, "<dev string:x13ab>" + function_abbd4595d76ccc5e(poiname, "<dev string:xe91>"), colorbody, 1);
  pos += 12;
  printtoscreen2d(x, pos, "<dev string:x140d>", colorbody, 1);
}

function function_7c858505e467de02() {
  level endon("<dev string:x119e>");

  while(true) {
    if(getdvarint(@ "hash_65814f5c10de603d", 0) == 1) {
      foreach(area in level.var_f81cb9ead7b61ac1) {
        thread scripts\mp\utility\debug::drawsphere(area.origin, 128, 1, (1, 0, 1));

        if(!isDefined(area.agents)) {
          continue;
        }

        foreach(agent in area.agents) {
          thread scripts\cp_mp\utility\debug_utility::drawline(agent.origin, area.origin, 1, (1, 1, 1));
        }
      }
    }

    wait 1;
  }
}

function function_644e1e38d1b39a41() {
  level endon("<dev string:x119e>");

  while(true) {
    if(getdvarint(@ "hash_2450e77b0430661c", 0) > 0) {
      if(istrue(level.supportsai)) {
        player = level.players[0];
        team = undefined;

        if(scripts\cp_mp\utility\game_utility::function_42e2dcfd4571b89b()) {
          if(isDefined(level.var_4b195d3dd0024b9c)) {
            team = level.var_4b195d3dd0024b9c;
          } else {
            team = "<dev string:x16d9>";
          }
        } else {
          team = scripts\mp\utility\teams::getenemyteams(player.team)[0];
        }

        if(isDefined(player)) {
          level thread function_27d0336b6b9b60c("<dev string:x16f5>", player.origin, team, player);
        }
      }

      setdevdvar(@ "hash_2450e77b0430661c", 0);
    }

    if(getdvarint(@ "hash_3812148f43182b8", 0) > 0) {
      if(istrue(level.supportsai)) {
        player = level.players[0];

        if(isDefined(player)) {
          level thread function_27d0336b6b9b60c("<dev string:x16f5>", player.origin, player.team);
        }
      }

      setdevdvar(@ "hash_3812148f43182b8", 0);
    }

    if(getdvarint(@ "hash_56e9c6adae23f12b", 0) > 0) {
      if(istrue(level.supportsai)) {
        player = level.players[0];
        team = undefined;

        if(scripts\cp_mp\utility\game_utility::function_42e2dcfd4571b89b()) {
          if(isDefined(level.var_4b195d3dd0024b9c)) {
            team = level.var_4b195d3dd0024b9c;
          } else {
            team = "<dev string:x16d9>";
          }
        } else {
          team = scripts\mp\utility\teams::getenemyteams(player.team)[0];
        }

        if(isDefined(player)) {
          level thread function_27d0336b6b9b60c("<dev string:x16fd>", player.origin, team, player);
        }
      }

      setdevdvar(@ "hash_56e9c6adae23f12b", 0);
    }

    if(getdvarint(@ "hash_e98cb58666dc372d", 0) > 0) {
      if(istrue(level.supportsai)) {
        player = level.players[0];

        if(isDefined(player)) {
          level thread function_27d0336b6b9b60c("<dev string:x16fd>", player.origin, player.team);
        }
      }

      setdevdvar(@ "hash_e98cb58666dc372d", 0);
    }

    if(getdvarint(@ "hash_ab9e351e7bdd4002", 0) > 0) {
      if(istrue(level.supportsai)) {
        player = level.players[0];
        team = undefined;

        if(scripts\cp_mp\utility\game_utility::function_42e2dcfd4571b89b()) {
          if(isDefined(level.var_4b195d3dd0024b9c)) {
            team = level.var_4b195d3dd0024b9c;
          } else {
            team = "<dev string:x16d9>";
          }
        } else {
          team = scripts\mp\utility\teams::getenemyteams(player.team)[0];
        }

        if(isDefined(player)) {
          origin = function_61cbc488b27a6e61(player.origin);
          level thread function_27d0336b6b9b60c("<dev string:x1707>", origin, team);
        }
      }

      setdevdvar(@ "hash_ab9e351e7bdd4002", 0);
    }

    if(getdvarint(@ "hash_534dfd9d53977a3a", 0) > 0) {
      if(istrue(level.supportsai)) {
        player = level.players[0];

        if(isDefined(player)) {
          origin = function_61cbc488b27a6e61(player.origin);
          level thread function_27d0336b6b9b60c("<dev string:x1707>", origin, player.team);
        }
      }

      setdevdvar(@ "hash_534dfd9d53977a3a", 0);
    }

    if(getdvarint(@ "hash_249d0bd1bced7236", 0) > 0) {
      if(istrue(level.supportsai)) {
        player = level.players[0];
        team = undefined;

        if(scripts\cp_mp\utility\game_utility::function_42e2dcfd4571b89b()) {
          if(isDefined(level.var_4b195d3dd0024b9c)) {
            team = level.var_4b195d3dd0024b9c;
          } else {
            team = "<dev string:x16d9>";
          }
        } else {
          team = scripts\mp\utility\teams::getenemyteams(player.team)[0];
        }

        if(isDefined(player)) {
          origin = function_61cbc488b27a6e61(player.origin);
          level thread function_27d0336b6b9b60c("<dev string:x1715>", origin, team, player);
        }
      }

      setdevdvar(@ "hash_249d0bd1bced7236", 0);
    }

    if(getdvarint(@ "hash_867ce306c3674a56", 0) > 0) {
      if(istrue(level.supportsai)) {
        player = level.players[0];

        if(isDefined(player)) {
          origin = function_61cbc488b27a6e61(player.origin);
          team = player.team;
          level thread function_27d0336b6b9b60c("<dev string:x1715>", origin, team, player);
        }
      }

      setdevdvar(@ "hash_867ce306c3674a56", 0);
    }

    if(getdvarint(@ "hash_88ae422170005010", 0) > 0) {
      if(istrue(level.supportsai)) {
        player = level.players[0];

        if(isDefined(player)) {
          origin = function_61cbc488b27a6e61(player.origin);
          level thread scripts\mp\ai_mp_controller::function_77acc10c4823dd8a(2, origin, "<dev string:xe2f>", "<dev string:xf97>", "<dev string:xe46>", undefined, player.team);
        }
      }

      setdevdvar(@ "hash_88ae422170005010", 0);
    }

    if(getdvarint(@ "hash_7882eb2f0ed5ba94", 0) > 0) {
      if(istrue(level.supportsai)) {
        player = level.players[0];
        team = undefined;

        if(scripts\cp_mp\utility\game_utility::function_42e2dcfd4571b89b()) {
          if(isDefined(level.var_4b195d3dd0024b9c)) {
            team = level.var_4b195d3dd0024b9c;
          } else {
            team = "<dev string:x16d9>";
          }
        } else {
          team = scripts\mp\utility\teams::getenemyteams(player.team)[0];
        }

        if(isDefined(player)) {
          origin = function_61cbc488b27a6e61(player.origin);
          level thread scripts\mp\ai_mp_controller::function_77acc10c4823dd8a(5, origin, "<dev string:xe2f>", "<dev string:xf97>", "<dev string:xe46>", undefined, team);
        }
      }

      setdevdvar(@ "hash_7882eb2f0ed5ba94", 0);
    }

    if(getdvarint(@ "hash_dd00a99e0fc8f650", 0) > 0) {
      if(istrue(level.supportsai)) {
        player = level.players[0];
        team = undefined;

        if(scripts\cp_mp\utility\game_utility::function_42e2dcfd4571b89b()) {
          if(isDefined(level.var_4b195d3dd0024b9c)) {
            team = level.var_4b195d3dd0024b9c;
          } else {
            team = "<dev string:x16d9>";
          }
        } else {
          team = scripts\mp\utility\teams::getenemyteams(player.team)[0];
        }

        if(isDefined(player)) {
          level thread function_27d0336b6b9b60c("<dev string:x171d>", player.origin, team, player);
        }
      }

      setdevdvar(@ "hash_dd00a99e0fc8f650", 0);
    }

    if(getdvarint(@ "hash_a880595a62e6c674", 0) > 0) {
      if(istrue(level.supportsai)) {
        player = level.players[0];

        if(isDefined(player)) {
          level thread function_27d0336b6b9b60c("<dev string:x171d>", player.origin, player.team, player);
        }
      }

      setdevdvar(@ "hash_a880595a62e6c674", 0);
    }

    if(getdvarint(@ "hash_61fc4efede6cbbe2", 0) > 0) {
      if(istrue(level.supportsai)) {
        player = level.players[0];
        team = undefined;

        if(scripts\cp_mp\utility\game_utility::function_42e2dcfd4571b89b()) {
          if(isDefined(level.var_4b195d3dd0024b9c)) {
            team = level.var_4b195d3dd0024b9c;
          } else {
            team = "<dev string:x16d9>";
          }
        } else {
          team = scripts\mp\utility\teams::getenemyteams(player.team)[0];
        }

        if(isDefined(player)) {
          level thread function_27d0336b6b9b60c("<dev string:x1727>", player.origin, team, player);
        }
      }

      setdevdvar(@ "hash_61fc4efede6cbbe2", 0);
    }

    if(getdvarint(@ "hash_f823061619fb9d9a", 0) > 0) {
      if(istrue(level.supportsai)) {
        player = level.players[0];

        if(isDefined(player)) {
          level thread function_27d0336b6b9b60c("<dev string:x1727>", player.origin, player.team, player);
        }
      }

      setdevdvar(@ "hash_f823061619fb9d9a", 0);
    }

    wait 1;
  }
}

function function_27d0336b6b9b60c(type, origin, team, player) {
  agents = undefined;
  poiname = undefined;

  if(isDefined(player)) {
    poiname = poi_findpoioriginisin(player.origin);
  }

  switch (type) {
    case #"hash_b111a4547c7d9125":
      agents = function_2f3b04fc531b4115(4, origin, "<dev string:xe2f>", "<dev string:xf97>", "<dev string:xe46>", undefined, team, undefined, poiname, type, undefined, undefined, undefined, subarea_getsubareanationality(origin, undefined, poiname));
      break;
    case #"hash_8d96201d150187de":
      agents = function_2f3b04fc531b4115(4, origin, "<dev string:xe2f>", "<dev string:xf97>", "<dev string:xe46>", undefined, team, undefined, poiname, type);
      break;
    case #"hash_f2a2ef6a2b0d207c":
      function_353fecd1549f5f42(origin, 2048, "<dev string:x16d9>");
      break;
    case #"hash_c72bb484b209c08b":
      agents = function_2f3b04fc531b4115(5, origin, "<dev string:xe2f>", "<dev string:xf97>", "<dev string:xe46>", undefined, team, undefined, poiname, type);
      break;
    case #"hash_f0e5b0c514493855":
      agents = function_2f3b04fc531b4115(4, origin, "<dev string:xe2f>", "<dev string:xf97>", "<dev string:xe46>", undefined, team, undefined, poiname, type);
      break;
    case #"hash_8b66cdb7a2b06217":
      agents = function_2f3b04fc531b4115(4, origin, "<dev string:xe2f>", "<dev string:xf97>", "<dev string:xe46>", undefined, team, undefined, poiname, type);
      break;
  }

  if(!isDefined(origin)) {
    origin = player.origin;
  }

  if(isDefined(agents) && isarray(agents)) {
    poiname = scripts\mp\poi::poi_findpoioriginisin(origin);
    function_96b7b6431450dfc0(agents.size, poiname);

    if(isDefined(level.var_d1a95e3c3d6ea9fc)) {
      level thread function_346caf10322931c8(poiname, origin);
    }
  }
}

function function_5397fa12cf5b1665() {
  level endon("<dev string:x119e>");

  while(true) {
    var_d45c6fe613356b23 = getdvarint(@ "hash_1d8682eb59219492", 0);

    if(var_d45c6fe613356b23 == 1) {
      if(poi_issystemactive()) {
        foreach(poi in level.poi) {
          poiname = level.poi["<dev string:x1733>"];
          poiorigin = poi_getorigin(poiname);

          if(!isDefined(poiorigin)) {
            continue;
          }

          thread scripts\mp\utility\debug::drawsphere(poiorigin, 512, 1, (0, 1, 0));
          print3d(poiorigin + (0, 0, 552), poiname, (1, 1, 1), 1, 10, 20);
        }
      }
    }

    if(var_d45c6fe613356b23 == 2) {
      if(poi_issystemactive()) {
        foreach(poiname, poi in level.poi) {
          foreach(subarea in poi["<dev string:x16c1>"]) {
            if(subarea.var_71ad22c5d093d90b != "<dev string:x173b>") {
              origin = function_ab3b7f9663bc2e89(subarea);

              if(!isDefined(origin)) {
                continue;
              }

              thread scripts\mp\utility\debug::drawsphere(origin, 512, 1, (0, 1, 0));
              print3d(origin + (0, 0, 550), poiname + "<dev string:xcb8>" + subarea.var_71ad22c5d093d90b, (1, 1, 1), 1, 2, 20);
            }
          }
        }
      }
    }

    if(var_d45c6fe613356b23 == 3) {
      if(poi_issystemactive()) {
        foreach(poiname, poi in level.poi) {
          foreach(subarea in poi["<dev string:x16c1>"]) {
            if(subarea.var_71ad22c5d093d90b != "<dev string:x173b>") {
              foreach(spawnpackage in subarea.var_d276b08c96430bfc) {
                function_87edf0678d74d59a(spawnpackage, "<dev string:x1745>", poiname, subarea.var_71ad22c5d093d90b);
              }

              foreach(spawnpackage in subarea.var_24a2cd19eed8f75d) {
                function_87edf0678d74d59a(spawnpackage, "<dev string:x1751>", poiname, subarea.var_71ad22c5d093d90b);
              }

              continue;
            }

            foreach(spawnpackage in subarea.var_d276b08c96430bfc) {
              function_87edf0678d74d59a(spawnpackage, "<dev string:x1745>", poiname, subarea.var_71ad22c5d093d90b);
            }

            foreach(spawnpackage in subarea.var_24a2cd19eed8f75d) {
              function_87edf0678d74d59a(spawnpackage, "<dev string:x1751>", poiname, subarea.var_71ad22c5d093d90b);
            }
          }
        }
      }
    }

    if(var_d45c6fe613356b23 == 4) {
      if(poi_issystemactive()) {
        foreach(poiname, poi in level.poi) {
          foreach(node in poi["<dev string:x175d>"]) {
            size = 32;
            color = (1, 0, 0);

            if(istrue(node.var_1e9d8e53eeec48a)) {
              size = 64;
              color = (0, 1, 0);
            }

            sphere(node.origin, size, color);
          }
        }
      }
    }

    if(var_d45c6fe613356b23 == 5) {
      if(poi_issystemactive()) {
        foreach(poiname, poi in level.poi) {
          foreach(pathstruct in level.poi[poiname]["<dev string:x1770>"]) {
            size = 32;
            color = (1, 0, 0);

            if(istrue(pathstruct.var_1e9d8e53eeec48a)) {
              color = (0, 1, 0);
            } else if(istrue(pathstruct.var_4b0bad4944a4cbc0)) {
              color = (0, 0, 1);
            }

            for(i = 0; i < pathstruct.path.size; i++) {
              node01 = pathstruct.path[i];
              node02 = undefined;
              sphere(node01.origin, size, color);

              if(isDefined(node01.target)) {
                node02 = getStruct(node01.target, "<dev string:x177f>");
              }

              if(isDefined(node02)) {
                line(node01.origin, node02.origin, color);
                continue;
              }

              if(!istrue(pathstruct.var_4437e81f60b6b5a0)) {
                line(node01.origin, pathstruct.path[0].origin, color);
              }
            }
          }
        }
      }
    }

    if(var_d45c6fe613356b23 == 6) {
      foreach(agent in level.agentarray) {
        if(isalive(agent)) {
          str = "<dev string:x178d>" + agent.agent_type;

          if(isDefined(agent.var_80f4bde7090a4773) && agent.var_80f4bde7090a4773 == "<dev string:x179d>") {
            str += "<dev string:x17a6>";
          }

          print3d(agent.origin + (0, 0, 100), str, (1, 0, 1), 1, 0.4);
        }
      }
    }

    waitframe();
  }
}

function function_87edf0678d74d59a(spawnpackage, type, poiname, var_71ad22c5d093d90b) {
  color = undefined;

  if(type == "<dev string:x1745>") {
    color = (0, 1, 0);
  } else if(type == "<dev string:x1751>") {
    color = (0, 0, 1);
  } else {
    color = (1, 0, 0);
  }

  sphere(spawnpackage.origin, 64, color);
  print3d(spawnpackage.origin + (0, 0, 104), type, (1, 1, 1), 1, 2, 20);

  if(isDefined(var_71ad22c5d093d90b)) {
    print3d(spawnpackage.origin + (0, 0, 84), var_71ad22c5d093d90b, (1, 1, 1), 1, 1.25, 20);
  }

  if(isDefined(poiname)) {
    print3d(spawnpackage.origin + (0, 0, 64), poiname, (1, 1, 1), 1, 1.25, 20);
  }

  if(isDefined(spawnpackage.guardnodes)) {
    foreach(spawnloc in spawnpackage.guardnodes) {
      sphere(spawnloc.origin, 32, (1, 1, 0));
      line(spawnpackage.origin, spawnloc.origin, (1, 1, 0));
    }
  }

  if(isDefined(spawnpackage.pathstructs)) {
    foreach(pathstruct in spawnpackage.pathstructs) {
      line(spawnpackage.origin, pathstruct.path[0].origin, (1, 1, 0));

      for(i = 0; i < pathstruct.path.size; i++) {
        node01 = pathstruct.path[i];
        node02 = pathstruct.path[i + 1];
        sphere(node01.origin, 32, (1, 0, 1));

        if(isDefined(node02)) {
          line(node01.origin, node02.origin, (1, 0, 1));
          continue;
        }

        if(!istrue(pathstruct.var_4437e81f60b6b5a0)) {
          line(node01.origin, pathstruct.path[0].origin, (1, 1, 0));
        }
      }
    }
  }

  if(isDefined(spawnpackage.civnodes)) {
    foreach(civnode in spawnpackage.civnodes) {
      sphere(civnode.origin, 32, (1, 1, 0));
      line(spawnpackage.origin, civnode.origin, (1, 1, 0));
    }
  }
}

function function_ddedf124ae1bcf7d() {
  while(true) {
    x = getdvarfloat(@ "hash_cde7d84c0f1d8210", -20051);
    y = getdvarfloat(@ "hash_cde7d94c0f1d8443", 42445.5);
    z = getdvarfloat(@ "hash_cde7da4c0f1d8676", -157.5);
    origin = (x, y, z);
    thread scripts\mp\utility\debug::drawsphere(origin, 512, 1, (0, 1, 0));
    wait 1;
  }
}

function function_6bbeb23006988aae() {
  startorigin = (-18414, 20137, -237);
  xinterval = 128;
  yinterval = 128;

  for(i = 0; i < 20; i++) {
    origin = startorigin + (0, yinterval * (i + 1), 0);

    for(j = 0; j < 20; j++) {
      safeorigin = function_61cbc488b27a6e61(origin + (0, 0, 200));
      safeorigin = drop_to_ground(safeorigin);
      ai_mp_requestspawnagent("<dev string:x17b1>", safeorigin, undefined, "<dev string:xe2f>", "<dev string:xf97>", "<dev string:xe46>");
      origin += (xinterval, 0, 0);
    }
  }
}

function function_36dcf4004d9f5399() {
  while(true) {
    foreach(agent in level.specialforces) {
      if(isDefined(agent) && isalive(agent)) {
        thread scripts\mp\utility\debug::drawsphere(agent.origin, 32, 1, (0, 1, 0));
      }
    }

    wait 1;
  }
}

function function_b510c28e573d0be6() {
  level endon("<dev string:x119e>");

  while(true) {
    foreach(player in level.players) {
      player setclientomnvar("<dev string:x17c5>", function_5cc0c507e92f7b47(player.closestpoi));
    }

    wait 1;
  }
}

function function_8e6e8dadb5526ec0() {
  while(true) {
    foreach(agent in level.agentarray) {
      if(isalive(agent)) {
        print3d(agent.origin + (0, 0, 64), agent.agent_type, (1, 1, 1), 1, 1.25, 1);
      }
    }

    waitframe();
  }
}

function function_8b97c47b557d1c58() {
  level endon("<dev string:x119e>");

  while(true) {
    foreach(poiname, poi in level.poi) {
      if(getdvarint(hashcat(@ "hash_831b14ba4dbdd316", poiname, "<dev string:x1259>"), 0) == 1) {
        foreach(subarea in poi["<dev string:x16c1>"]) {
          if(subarea.var_71ad22c5d093d90b != "<dev string:x173b>") {
            foreach(spawnpackage in subarea.var_d276b08c96430bfc) {
              function_87edf0678d74d59a(spawnpackage, "<dev string:x1745>", poiname, subarea.var_71ad22c5d093d90b);
            }

            foreach(spawnpackage in subarea.var_24a2cd19eed8f75d) {
              function_87edf0678d74d59a(spawnpackage, "<dev string:x1751>", poiname, subarea.var_71ad22c5d093d90b);
            }

            continue;
          }

          foreach(spawnpackage in subarea.var_d276b08c96430bfc) {
            function_87edf0678d74d59a(spawnpackage, "<dev string:x1745>", poiname, subarea.var_71ad22c5d093d90b);
          }

          foreach(spawnpackage in subarea.var_24a2cd19eed8f75d) {
            function_87edf0678d74d59a(spawnpackage, "<dev string:x1751>", poiname, subarea.var_71ad22c5d093d90b);
          }
        }
      }
    }

    waitframe();
  }
}

function function_9fae03fa905ef5ce() {
  level endon("<dev string:x119e>");

  while(true) {
    foreach(poiname, poi in level.poi) {
      if(getdvarint(hashcat(@ "hash_831b14ba4dbdd316", poiname, "<dev string:x12be>"), 0) == 1) {
        foreach(node in level.poi[poiname]["<dev string:x175d>"]) {
          size = 32;
          color = (1, 0, 0);

          if(istrue(node.var_1e9d8e53eeec48a)) {
            size = 64;
            color = (0, 1, 0);
          }

          sphere(node.origin, size, color);
        }
      }
    }

    waitframe();
  }
}

function function_8c74d71ffba1bda8() {
  level endon("<dev string:x119e>");

  while(true) {
    foreach(poiname, poi in level.poi) {
      if(getdvarint(hashcat(@ "hash_831b14ba4dbdd316", poiname, "<dev string:x1323>"), 0) == 1) {
        foreach(pathstruct in level.poi[poiname]["<dev string:x1770>"]) {
          size = 32;
          color = (1, 0, 0);

          if(istrue(pathstruct.var_1e9d8e53eeec48a)) {
            color = (0, 1, 0);
          } else if(istrue(pathstruct.var_4b0bad4944a4cbc0)) {
            color = (0, 0, 1);
          }

          for(i = 0; i < pathstruct.path.size; i++) {
            node01 = pathstruct.path[i];
            node02 = undefined;
            sphere(node01.origin, size, color);

            if(isDefined(node01.target)) {
              node02 = getStruct(node01.target, "<dev string:x177f>");
            }

            if(isDefined(node02)) {
              line(node01.origin, node02.origin, color);
              continue;
            }

            if(!istrue(pathstruct.var_4437e81f60b6b5a0)) {
              line(node01.origin, pathstruct.path[0].origin, color);
            }
          }
        }
      }
    }

    waitframe();
  }
}

function function_389b1801f508c3f0() {
  level endon("<dev string:x119e>");

  while(true) {
    foreach(poiname, poi in level.poi) {
      if(getdvarint(hashcat(@ "hash_831b14ba4dbdd316", poiname, "<dev string:x138a>"), 0) == 1) {
        foreach(agent in function_7e3f22e620f3f71e(poiname, "<dev string:xe91>")) {
          if(isalive(agent)) {
            str = "<dev string:x178d>" + agent.agent_type;

            if(isDefined(agent.var_80f4bde7090a4773) && agent.var_80f4bde7090a4773 == "<dev string:x179d>") {
              str += "<dev string:x17a6>";
            }

            print3d(agent.origin + (0, 0, 100), str, (1, 0, 1), 1, 0.4);
          }
        }
      }
    }

    waitframe();
  }
}

function function_83e7184f6391c36b() {
  while(true) {
    sphere(level.players[0].origin, 512, (1, 0, 0));
    sphere(level.players[0].origin, 1024, (0, 1, 0));
    sphere(level.players[0].origin, 2048, (0, 0, 1));
    waitframe();
  }
}

function function_e060fb3d7177aea7(ent, time, radius, color) {
  if(!isDefined(ent) && !isDefined(time)) {
    return;
  }

  drawframes = int(time / level.framedurationseconds);

  if(!isDefined(radius)) {
    radius = 256;
  }

  if(!isDefined(color)) {
    color = (0, 0, 1);
  }

  for(frame = 0; frame < drawframes; frame++) {
    sphere(ent.origin, radius, color);
    waitframe();
  }
}

function function_e1c5cdebd8e4628a() {
  level endon("<dev string:x119e>");
  setdevdvarifuninitialized(@ "hash_f9e17cb98b253864", 0);
  var_4aedb83e4489153d = 1;

  while(true) {
    if(scripts\stealth\debug::function_159af129de631d3e() && var_4aedb83e4489153d) {
      var_4aedb83e4489153d = 0;
      setDvar(@ "hash_f51f34be092e6691", 1);
      setDvar(@ "debug_stealth", 1);
      setDvar(@ "ai_showpaths", 1);
      setDvar(@ "hash_c7b59c90cd6d06bb", 1);
    }

    if(!scripts\stealth\debug::function_159af129de631d3e() && !var_4aedb83e4489153d) {
      var_4aedb83e4489153d = 1;
      setDvar(@ "hash_f51f34be092e6691", 0);
      setDvar(@ "debug_stealth", 0);
      setDvar(@ "ai_showpaths", 0);
      setDvar(@ "hash_c7b59c90cd6d06bb", 0);
    }

    waitframe();
  }
}

function function_c1d2c66c8b74b50() {
  self endon("<dev string:x17db>");

  while(true) {
    if(scripts\stealth\debug::function_159af129de631d3e()) {
      count = scripts\stealth\debug::function_6ed101071f87cd39();
      print3d(self.origin - (0, 0, count * 20), "<dev string:x17e4>", (1, 1, 0), 1, 1.25);
    }

    waitframe();
  }
}

function function_2ddd97b1f0e64945(player, event, radius) {
  if(isDefined(radius)) {
    function_afe5cda1a4ed9d11(event, player, player.origin, radius);
    return;
  }

  function_afe5cda1a4ed9d11(event, player, player.origin);
}

function function_862dc7729fb4914b(bossname) {
  point = getclosestpointonnavmesh(level.players[0].origin + anglesToForward(level.players[0].angles) * 128);
  nearestnode = level.players[0] getnearestnode();
  aitype = function_7f1a2e2ebe0c1693(bossname);
  boss = ai_mp_requestspawnagent(aitype, point, level.players[0].angles, "<dev string:x3cd>", "<dev string:xe91>", undefined, undefined, undefined, undefined, undefined, 0);
}

# /