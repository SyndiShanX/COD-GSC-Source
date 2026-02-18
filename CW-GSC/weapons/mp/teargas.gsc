/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\mp\teargas.gsc
***********************************************/

#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\weapons\teargas;
#namespace teargas;

function private autoexec __init__system__() {
  system::register(#"teargas", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
  level.var_c7b2d0ab = getweapon(#"tear_gas");
  globallogic_score::register_kill_callback(level.var_c7b2d0ab, &function_8f5e1a77, 1);
  globallogic_score::function_c1e9b86b(level.var_c7b2d0ab, &function_6703177e);
}

function function_6703177e(params) {
  attacker = params.attacker;
  attacker stats::function_dad108fa(#"hash_38b93f97da20f2e1", 1);
  attacker stats::function_dad108fa(#"hash_38b93c97da20edc8", 1);
  attacker stats::function_dad108fa(#"hash_6e9f9d0d3ae59765", 1);
  attacker stats::function_dad108fa(#"hash_69a54125cf436285", 1);
  attacker stats::function_dad108fa(#"hash_24b8c6ce81fdead6", 1);
  attacker stats::function_dad108fa(#"hash_24b8c5ce81fde923", 1);
  attacker stats::function_bcf9602(#"hash_5a979e436e74441", 1, #"hash_6abe83944d701459");
}

function function_8f5e1a77(attacker, victim, weapon, attackerweapon, meansofdeath) {
  return meansofdeath === level.var_c7b2d0ab;
}