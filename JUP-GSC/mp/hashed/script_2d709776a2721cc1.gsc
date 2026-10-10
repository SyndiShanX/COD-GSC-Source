/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2d709776a2721cc1.gsc
*************************************************/

#using script_2047cdbf5176ba0;
#using script_2e0d8cb6cbb13e4d;
#using script_46e6439866901eb5;
#using script_5f1c5742c93821a4;
#using script_627452def335a90b;
#using script_62a4f7a62643fe8;
#using script_7ff1c5399d2d9500;
#using script_92b815b18f0ba61;
#using scripts\common\callbacks;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\engine\utility;
#namespace namespace_cac9b95740fca4e0;

function autoexec init() {
  level.var_6bf302c2c5d67b40 = &main;
}

function main() {
  function_eb7f544259415a09("mp_jup_bigmap_ob");
  level thread function_a966511aed9b0851();
  namespace_68e5e24beb101ffd::main();
  namespace_2ca3dad2d6898e0d::main();
  scripts\engine\utility::flag_set("gas_station_create_script_initialized");
  level callback::add("register_activities", &function_98dce143b7f266cb);
  level callback::add("register_objectives", &function_ecabf4e0ca8cab0);
  function_3c4622aaf1b2a77a();
  namespace_f19749db1ea23f08::main();
  thread namespace_6776e8e74ed64842::init();

  if(getDvar(@ "hash_6ffd9adb060c50c9", "0") == "1") {
    namespace_b543cbaf1e32456f::main();
    thread namespace_d7e80b14e1130dc4::init();
  }

  thread function_a8cb2ad76bdd3bf0();
}

function function_a966511aed9b0851() {
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

function function_a8cb2ad76bdd3bf0() {
  function_95dc47abc9ef28ae();
  scripts\cp_mp\agents\ai_spawn_director::process_create_script();
}

function function_95dc47abc9ef28ae() {
  flag_wait("mp_jup_st_g_ob_contracts_merc_defend_cs_completed");
}