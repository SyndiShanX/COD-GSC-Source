/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3144ea076c4e15d5.gsc
*************************************************/

#using script_2047cdbf5176ba0;
#using script_360bdc3db602212b;
#using script_5d813d45c6b1b1be;
#using script_62a4f7a62643fe8;
#using script_7479df52350a3e0;
#using script_7d2eb9bc7e01ecaf;
#using script_7ff1c5399d2d9500;
#using script_92b815b18f0ba61;
#using script_9b5cabd1a0468a9;
#using script_bce65b6f60fa5a1;
#using scripts\common\callbacks;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\engine\utility;
#namespace namespace_5fdb1128f67677aa;

function autoexec init() {
  level.var_87cbaa272123525e = &main;
}

function main() {
  function_eb7f544259415a09("mp_jup_bigmap_ob");
  level thread function_939b7ddd9a2592b3();
  namespace_92f8a210c3f60bd9::main();
  namespace_c1984ad5d2c85b81::main();
  scripts\engine\utility::flag_set("gas_station_create_script_initialized");
  level callback::add("register_activities", &function_98dce743b7f273fd);
  level callback::add("register_objectives", &function_ecac54e0ca8d7e2);
  function_3c461caaf1b29a48();
  level callback::add("register_features", &function_78d857de4d17073);
  namespace_981841431137dfcc::main();
  thread namespace_6776e8e74ed64842::init();

  if(getDvar(@ "hash_6ffd9adb060c50c9", "0") == "1") {
    namespace_63e54e5e8c51a163::main();
    thread namespace_d7e80b14e1130dc4::init();
  }

  if(getDvar(@ "hash_6e5464e5ee3bd77d", "0") == "1") {
    namespace_7d12a25cf603c57b::main();
    thread namespace_d0c78bdaf71b04f6::init();
  }

  thread function_5a5276bd989b7d96();
}

function function_939b7ddd9a2592b3() {
  setDvar(@ "hash_f1d095735ac37f33", 1);
  waitframe();
  function_9b8829ab4092a7d7("ob_zombie_ambient", 1);
  a_pos = scripts\engine\utility::getStructArray("s_ob_infil_supress", "targetname");

  foreach(pos in a_pos) {
    function_606642b946a01237("infil_supress", pos.origin, pos.radius, 1);
  }

  var_102014ab68ac4b78 = scripts\engine\utility::getStructArray("s_ambient_blocker", "targetname");

  foreach(pos in var_102014ab68ac4b78) {
    if(isDefined(pos.radius)) {
      function_606642b946a01237("ambient_blocker", pos.origin, pos.radius, 1);
    }
  }
}

function function_5a5276bd989b7d96() {
  function_f2a6094e2bc9028();
  scripts\cp_mp\agents\ai_spawn_director::process_create_script();
}

function function_f2a6094e2bc9028() {
  flag_wait("mp_jup_st_a_ob_contracts_merc_defend_cs_completed");
}