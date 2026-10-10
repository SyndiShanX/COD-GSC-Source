/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_df078f814c869a1.gsc
************************************************/

#using script_2047cdbf5176ba0;
#using script_20ec388dddf52c04;
#using script_358f9185e1be9115;
#using script_62a4f7a62643fe8;
#using script_6dc57213a3e095eb;
#using script_7ff1c5399d2d9500;
#using script_91e5727a9d1442d;
#using script_92b815b18f0ba61;
#using scripts\common\callbacks;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\engine\utility;
#namespace namespace_aef4d3fd3f9d2917;

function autoexec init() {
  level.var_de0ea044921d6935 = &main;
}

function main() {
  function_eb7f544259415a09("mp_jup_bigmap_ob");
  level thread function_e7e3dc27ef29d346();
  namespace_d5ad875f8028fe1d::main();
  namespace_db64ae640647c5cd::main();
  scripts\engine\utility::flag_set("gas_station_create_script_initialized");
  level callback::add("register_activities", &function_98dcde43b7f26032);
  level callback::add("register_objectives", &function_ecace4e0ca8ebad);
  function_3c4615aaf1b28ae3();
  namespace_bf8452379047a828::main();
  thread namespace_6776e8e74ed64842::init();

  if(getDvar(@ "hash_6ffd9adb060c50c9", "0") == "1") {
    namespace_215b3df3d99b060f::main();
    thread namespace_d7e80b14e1130dc4::init();
  }

  thread function_62312814dab1b7d9();
}

function function_e7e3dc27ef29d346() {
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

function function_62312814dab1b7d9() {
  function_ff6d5421a485cc11();
  scripts\cp_mp\agents\ai_spawn_director::process_create_script();
}

function function_ff6d5421a485cc11() {
  flag_wait("mp_jup_st_h_ob_contracts_merc_defend_cs_completed");
}