/*************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_gw_fallout\mp_jup_gw_fallout_ob.gsc
*************************************************************************/

#using script_2047cdbf5176ba0;
#using script_222f62686867436a;
#using script_36b7b4e4089e73a3;
#using script_62a4f7a62643fe8;
#using script_6c49326fa248a5f;
#using script_92b815b18f0ba61;
#using scripts\common\callbacks;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\engine\utility;
#namespace mp_jup_gw_fallout_ob;

function autoexec init() {
  level.var_42f9d919e49a0633 = &main;
}

function main() {
  function_eb7f544259415a09("mp_jup_bigmap_ob");
  namespace_c670458343d549::main();
  function_74fd375468d1ae4();

  if(getdvarint(@ "hash_f0651d120dc93cc7", 0)) {
    namespace_25a0f0fe5a85d32b::main();
    namespace_609a40b1d504a670::quest_act3_init();
    level thread namespace_6776e8e74ed64842::init(1, undefined, 1);
    return;
  } else {
    namespace_609a40b1d504a670::function_aa1b5db86c89322d(0);
  }

  level thread namespace_6776e8e74ed64842::init(1, undefined, 1);
  level thread function_969adf7620768917();
}

function function_969adf7620768917() {
  level flag_wait("ai_spawn_director_initialized");
  scripts\cp_mp\agents\ai_spawn_director::process_create_script();
}