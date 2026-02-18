/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\spawner_shared.csc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace spawner;

function private autoexec __init__system__() {
  system::register(#"spawner", &preinit, undefined, undefined, undefined);
}

function private preinit() {}