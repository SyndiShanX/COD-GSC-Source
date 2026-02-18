/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_723ebc06cb1968f2.csc
***********************************************/

#using script_723ebc06cb1968f2;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_c46118a7;

function private autoexec __init__system__() {
  system::register(#"hash_125fc0c0065c7dea", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(util::get_game_type() === # "hash_125fc0c0065c7dea") {
    level.var_e35c191f = 1;
  }
}