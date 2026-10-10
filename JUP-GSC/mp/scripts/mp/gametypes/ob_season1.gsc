/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\ob_season1.gsc
**************************************************/

#using script_4ee9ddbac96043d;
#using script_4f77311cb9cdbcd8;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#namespace ob_season1;

function autoexec init() {
  level callback::add("ob_season_main", &main);
  level callback::add("ob_register_activities", &register_activities);
  level callback::add("ob_register_objectives", &register_objectives);
  level callback::add("ob_register_features", &register_features);
  level.var_5a66999895b55b96 = getdvarint(@ "hash_bd0a763d48b336f5", 0) > 0;
  level thread function_b7c9f9d63797a2c8();
}

function main(params) {
  mapname = getmapname();

  switch (mapname) {
    case #"hash_2a218509d1620d9d":
    case #"hash_9ae3f9a4f2372775":
      namespace_192f34362585a30c::main();
      namespace_c20fe7cc65d9c979::function_f4c2323079c53ba9();
      break;
  }

  level callback::remove("ob_season_main", &main);
}

function register_activities(params) {
  level callback::remove("ob_register_activities", &register_activities);
}

function register_objectives(params) {
  level callback::remove("ob_register_objectives", &register_objectives);
}

function register_features(params) {
  mapname = getmapname();

  switch (mapname) {
    case #"hash_9ae3f9a4f2372775":
      break;
  }

  level callback::remove("ob_register_features", &register_features);
}

function private function_b7c9f9d63797a2c8() {
  level endon("game_ended");
  level flag_wait("ai_spawn_director_initialized");

  if(function_d415276dab42fc0(0)) {
    level.var_ab4e7a61416509ca = &function_172e297dffe1a7bf;
    function_9b8829ab4092a7d7("codmas", 1);
    return;
  }

  while(true) {
    if(isarray(level.agent_definition)) {
      break;
    }

    waitframe();
  }

  if(function_d415276dab42fc0(1)) {
    function_9b8829ab4092a7d7("codmas", 1);
    level.var_ab4e7a61416509ca = &function_172e297dffe1a7bf;
  }
}

function private function_d415276dab42fc0(check_aitypes) {
  var_f66479931405b0b2 = 0;

  if(istrue(check_aitypes)) {
    aitypes = function_3290e192ac188e2d("zombie_mimic");

    foreach(aitype in aitypes) {
      if(issubstr(aitype, "xmas")) {
        var_f66479931405b0b2 = 1;
      }
    }
  }

  var_edff4b1061421db2 = getdvarint(@ "hash_7019141b37b54155", -1) != 0 && getdvarint(@ "hash_2ae6c0317f5baf93", 0);

  if(var_edff4b1061421db2 != -1) {
    if(var_edff4b1061421db2 > 0 && check_aitypes) {
      assertex(var_f66479931405b0b2, "<dev string:x1c>");

      if(!var_f66479931405b0b2) {
        return 0;
      }
    }

    return (var_edff4b1061421db2 > 0);
  }

  return var_f66479931405b0b2;
}

function private function_172e297dffe1a7bf(aitype) {
  new_aitype = aitype;

  if(issubstr(aitype, "zombie") && getsubstr(aitype, aitype.size - 4, aitype.size) != "xmas") {
    new_aitype = aitype + "_xmas";

    if(isDefined(level.agent_definition[new_aitype])) {
      return new_aitype;
    }
  }

  return aitype;
}