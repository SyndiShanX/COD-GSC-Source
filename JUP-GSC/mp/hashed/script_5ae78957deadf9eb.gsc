/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5ae78957deadf9eb.gsc
*************************************************/

#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\gametypes\br_bosses;
#namespace namespace_de071cd40cea8c48;

function pyro_register() {
  bossdetails = spawnStruct();
  bossdetails.armor = getdvarfloat(@ "hash_60a6f859cc67b71b", 5000);
  bossdetails.maxdamage = getdvarint(@ "hash_c35de7777481df06", 100);
  bossdetails.name = "pyro";
  bossdetails.uiname = "MP_INGAME_ONLY/OBJ_NEMESIS_CAPS";
  bossdetails.initfunc = &pyro_init;
  bossdetails.spawnfunc = &function_4108074415abc816;
  bossdetails.var_e68429b39c75b6ee = &function_4108074415abc816;
  bossdetails.var_4ea49a8926593523 = &function_b08878702405e6b8;
  scripts\mp\gametypes\br_bosses::registerboss(bossdetails);
}

function pyro_init(bossdetails) {}

function function_4108074415abc816(node) {
  boss = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent("enemy_mp_boss_pyro", node.origin, node.angles, "absolute", "elites", "pyroBoss", undefined, undefined, undefined, undefined, 1, 0, 0);

  if(!isDefined(boss)) {
    return;
  }

  function_fb62bcef7fab15fb(boss);
  return boss;
}

function function_fb62bcef7fab15fb(agent) {
  if(!isDefined(agent)) {
    return;
  }

  grenade_type = "molotov_mp";
  grenadeammo = getdvarint(@ "hash_537fa443ce212a8a", 12);
  armor = 3000;
  helmet = 1;
  agent.baseaccuracy = getdvarfloat(@ "hash_298d4ea8b0934e31", 1.2);
  agent scripts\cp_mp\agents\agent_utils::function_c37c4f9d687074ff(undefined, undefined, undefined, grenade_type, grenadeammo, armor, helmet);
  agent scripts\mp\gametypes\br_bosses::function_720c3b7abf4baac8("pyro");
  agent thread scripts\cp_mp\agents\agent_utils::function_36613ffb5ebe56(agent);
  agent thread scripts\mp\ai_behavior::behavior_cqb(agent);
}

function function_b08878702405e6b8() {
  level endon("game_ended");
  scripts\mp\gametypes\br_bosses::function_c0d4fda4400b5a08("pyro");
}