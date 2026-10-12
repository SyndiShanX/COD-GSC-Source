/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_st_c_gw\mp_jup_st_c_gw_ob.gsc
****************************************************************/

#using script_2047cdbf5176ba0;
#using script_3351a966a784edc0;
#using script_62a4f7a62643fe8;
#using script_893e61d2d5b599;
#using script_92b815b18f0ba61;
#using scripts\common\callbacks;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\engine\utility;
#namespace mp_jup_st_c_gw_ob;

function autoexec init() {
  level.var_7e1adb313a3b34d3 = &main;
}

function main() {
  function_eb7f544259415a09("mp_jup_bigmap_ob");
  function_738bba992e43ca7e();

  if(getdvarint(@ "hash_f0651f120dc9412d", 0)) {
    namespace_8f52b12ca3af49b1::main();
    namespace_609a42b1d504aad6::quest_init();
    thread namespace_faa32e45e1d64c2::init(1, undefined, 1);
    return;
  }

  level callback::add("register_activities", &function_d0ffb4e404349b30);
  level callback::add("register_objectives", &function_83ecb01b31530309);
  level callback::add("register_features", &function_c4ca7f1cd743b5d2);
  thread function_969adf7620768917();
  thread function_1aaaa2896639517e();
  thread namespace_faa32e45e1d64c2::init(1, undefined, 1);
}

function function_1aaaa2896639517e() {
  waitframe();
  function_9b8829ab4092a7d7("ob_zombie_ambient", 1);
  setDvar(@ "hash_f1d095735ac37f33", 1);
}

function function_969adf7620768917() {
  scripts\cp_mp\agents\ai_spawn_director::process_create_script();
}