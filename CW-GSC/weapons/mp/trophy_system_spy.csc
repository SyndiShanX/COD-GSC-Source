/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\mp\trophy_system_spy.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\weapons\trophy_system;
#namespace trophy_system;

function private autoexec __init__system__() {
  system::register(#"trophy_system_spy", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("missile", "" + # "hash_65fa2e5290be670e", 1, 1, "int", &function_a485f3cf, 0, 0);
  clientfield::register("missile", "" + # "hash_19f94fb667823a5a", 1, 7, "float", &function_799a68b6, 0, 0);
}