/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_55be1b5e4c717fc1.gsc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\cp_common\gamedifficulty;
#namespace gadget_health_regen;

function private autoexec __init__system__() {
  system::register(#"hash_282f48d36d893e20", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.var_f71267dc = &function_71343595;
  level.var_11e731d7 = &function_3211c56a;
}

function function_71343595(var_b16fafc9, weapon) {
  return int(gamedifficulty::function_b5b7d60e() * 1000);
}

function function_3211c56a(var_337562a8) {
  return int(gamedifficulty::function_5151f9d0() * 1000);
}