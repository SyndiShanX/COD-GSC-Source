/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1bed1c59f6ac9525.gsc
*************************************************/

#using script_2047cdbf5176ba0;
#using script_2b15a0bac31ce30;
#using script_369ec26a4522e639;
#using script_5cc103e78831ad9f;
#using script_5d813d45c6b1b1be;
#using script_62a4f7a62643fe8;
#using script_79de05378402bed1;
#using script_7b1a097c3912e1bb;
#using script_7ff1c5399d2d9500;
#using script_92b815b18f0ba61;
#using scripts\common\callbacks;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\engine\utility;
#namespace namespace_6690c1df72f98f32;

function autoexec init() {
  level.var_8bc670aa106fa796 = &main;
}

function main() {
  function_eb7f544259415a09("mp_jup_bigmap_ob");
  level thread function_7efd8a5b87c6c04b();
  namespace_ebb067ffc73349::main();
  namespace_f2713faa50431351::main();
  scripts\engine\utility::flag_set("gas_station_create_script_initialized");
  level callback::add("register_activities", &function_98dcdf43b7f26265);
  level callback::add("register_objectives", &function_ecacd4e0ca8e97a);
  level callback::add("register_features", &function_78d8d7de4d1820b);
  function_3c4614aaf1b288b0();
  namespace_9e7d5c0658c6dddc::main();
  thread namespace_6776e8e74ed64842::init();

  if(getDvar(@ "hash_6ffd9adb060c50c9", "0") == "1") {
    namespace_5b92d94106f62eb3::main();
    thread namespace_d7e80b14e1130dc4::init();
  }

  if(getDvar(@ "hash_6e5464e5ee3bd77d", "0") == "1") {
    namespace_3524338e05fdd14b::main();
    thread namespace_d0c78bdaf71b04f6::init();
  }

  thread function_91dcb17ad9e37fde();
}

function function_7efd8a5b87c6c04b() {
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

function function_91dcb17ad9e37fde() {
  function_699dd374c113c360();
  scripts\cp_mp\agents\ai_spawn_director::process_create_script();
}

function function_699dd374c113c360() {
  flag_wait("mp_jup_st_i_ob_contracts_merc_defend_cs_completed");
}