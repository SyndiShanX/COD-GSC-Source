/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_72f8a3c40978a2de.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\powerup\zm_powerup_cranked_pause;
#namespace namespace_9be1ab53;

function private autoexec __init__system__() {
  system::register(#"hash_5aa4949e75ab9d9c", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(util::get_game_type() === # "hash_5aa4949e75ab9d9c") {
    level.var_2d41db66 = 1;
  }
}