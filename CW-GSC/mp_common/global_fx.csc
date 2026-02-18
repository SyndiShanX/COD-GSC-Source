/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\global_fx.csc
***********************************************/

#using scripts\core_common\system_shared;
#namespace global_fx;

function private autoexec __init__system__() {
  system::register(#"global_fx", &preinit, &main, undefined, undefined);
}

function private preinit() {
  if(isDefined(getgametypesetting(#"hash_7e6ef41f5c3db213")) ? getgametypesetting(#"hash_7e6ef41f5c3db213") : 0) {
    function_414dfa79(#"hash_d1294b74c50a865", #"hash_d1294b74c50a865");
    function_5aeb01e6(#"hash_659a504a8160a9ac", #"hash_659a504a8160a9ac");
    setsoundcontext("ltm", "paintball");
    level.var_87c6c648 = 1;
  }
}

function main() {
  function_94923bb0();
  function_41acd565();
  check_for_wind_override();
}

function function_94923bb0() {
  function_3385d776(#"hash_14608c97d9d192a1", -1);
}

function function_41acd565() {
  function_3385d776(#"hash_46067e7dfe6ba0dd", -1);
}

function check_for_wind_override() {
  if(isDefined(level.custom_wind_callback)) {
    level thread[[level.custom_wind_callback]]();
  }
}