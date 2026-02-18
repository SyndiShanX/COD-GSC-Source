/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_65328041a4d0067f.gsc
***********************************************/

#using script_41e8adffbda93483;
#using script_77f51076c7c89596;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#namespace namespace_bb59e7e8;

function function_dccb21b3(str_objective) {
  namespace_534279a::spawn_allies("parapet_start");
  level thread namespace_9e5ef376::function_b7e649c0();
}

function function_f554eb14(str_objective, var_50cc0d4f) {
  level.player namespace_534279a::function_a3c3a2b0();
  level thread function_a7bfc002();
  level thread function_596aab36();
  var_c31a6f62 = getent("aa_parapet", "targetname");

  if(!isDefined(objectives::function_285e460(#"hash_75d3caceed12ab7d", var_c31a6f62))) {
    level objectives::kill(#"hash_75d3caceed12ab7d", var_c31a6f62, #"hash_5c22b5de1fc16f25", undefined, 0, 1);
  }

  function_6ea2cd94();
  objectives::complete(#"hash_75d3caceed12ab7d");
  level thread skipto::function_4e3ab877("parapet");
}

function function_23b06946(str_objective, var_50cc0d4f, var_aa1a6455, player) {}

function function_596aab36() {}

function private function_a7bfc002() {}

function function_6ea2cd94() {
  level thread function_7e171808();
  level flag::wait_till("flg_aa_parapet_destroyed");
}

function function_7e171808() {
  var_80d256bf = getent("aa_parapet", "targetname");
  var_80d256bf namespace_534279a::function_2a8ee50f("parapet");
  level flag::set("flg_aa_parapet_destroyed");
  level notify(#"hash_7797b485016eeeed");
  var_80d256bf notify(#"remove_objective");
}

function function_43222371() {
  level flag::wait_till("flg_parapet_objective_complete");
  var_c3d060a6 = [];
  var_c3d060a6 = arraycombine(var_c3d060a6, spawner::get_ai_group_ai("right_path_catacomb_hallway_group"));
  array::run_all(var_c3d060a6, &deletedelay);
}