/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1342099cdbdb5641.gsc
*************************************************/

#using script_2047cdbf5176ba0;
#using script_221e4f7ccdd70004;
#using script_2816a042b9f7996;
#using script_2d28a28173247bad;
#using script_3351a966a784edc0;
#using script_4112b9259c9e0b23;
#using script_62a4f7a62643fe8;
#using script_65d738fd8a2862a5;
#using script_732954a6c48898ac;
#using script_7ff1c5399d2d9500;
#using script_893e61d2d5b599;
#using script_92b815b18f0ba61;
#using scripts\common\callbacks;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\engine\utility;
#namespace namespace_b4c8e0f55ba8c71c;

function autoexec init() {
  level.var_efcc16c5e7fc5a6c = &main;
}

function main() {
  function_eb7f544259415a09("mp_jup_bigmap_ob");
  level thread function_3e48493972223605();
  namespace_644f62ff38e6df05::main();
  namespace_2469fcf354bc890d::main();
  scripts\engine\utility::flag_set("gas_station_create_script_initialized");
  function_3c461eaaf1b29eae();
  namespace_2fd4af9f8020b5a0::main();
  thread namespace_6776e8e74ed64842::init();

  if(getdvarint(@ "hash_f0651f120dc9412d", 0)) {
    namespace_8f52b12ca3af49b1::main();
    namespace_609a42b1d504aad6::quest_init();
    return;
  }

  if(getDvar(@ "hash_6ffd9adb060c50c9", "0") == "1") {
    namespace_e8816c886fe0a5f7::main();
    thread namespace_d7e80b14e1130dc4::init();
  }

  level callback::add("register_activities", &function_98dce543b7f26f97);
  level callback::add("register_objectives", &function_ecac34e0ca8d37c);
  level callback::add("register_features", &function_78d877de4d174d9);
  thread function_8716ff985c51f50c();
  namespace_1aa66c587558caa6::main();
  var_21af84bdbe252659 = getStructArray("vehicle_group_c", "script_noteworthy");
  level thread namespace_f9b6a4254d2d8100::function_63c6d4fbc0bc4d94(var_21af84bdbe252659);
}

function function_3e48493972223605() {
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

function function_8716ff985c51f50c() {
  function_23e93ef99a6c16e2();
  scripts\cp_mp\agents\ai_spawn_director::process_create_script();
}

function function_23e93ef99a6c16e2() {
  flag_wait("mp_jup_st_c_ob_contracts_merc_defend_cs_completed");
}