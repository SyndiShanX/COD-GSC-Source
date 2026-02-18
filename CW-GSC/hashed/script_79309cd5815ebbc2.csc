/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_79309cd5815ebbc2.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_89fd9b3e;

function private autoexec __init__system__() {
  system::register(#"hash_75aa82b3ae89f54e", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(util::get_game_type() === # "hash_75aa82b3ae89f54e") {
    level.var_612d6a21 = 1;
  }
}