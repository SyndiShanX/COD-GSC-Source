/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\global_fx.csc
***********************************************/

#using scripts\core_common\fx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#namespace global_fx;

function private autoexec __init__system__() {
  system::register(#"global_fx", &preinit, &main, undefined, undefined);
}

function private preinit() {}

function main() {
  function_41acd565();
  check_for_wind_override();
}

function function_41acd565() {
  function_3385d776(#"hash_46067e7dfe6ba0dd", -1);
}

function check_for_wind_override() {
  if(isDefined(level.custom_wind_callback)) {
    level thread[[level.custom_wind_callback]]();
  }
}