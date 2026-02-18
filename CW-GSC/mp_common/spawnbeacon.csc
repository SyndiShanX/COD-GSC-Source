/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\spawnbeacon.csc
***********************************************/

#using scripts\core_common\spawnbeacon_shared;
#using scripts\core_common\system_shared;
#namespace spawn_beacon;

function private autoexec __init__system__() {
  system::register(#"spawnbeacon", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  init_shared();
}