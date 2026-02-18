/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\spawning_shared.csc
***********************************************/

#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#namespace spawning;

function private autoexec __init__system__() {
  system::register(#"spawning_shared", &preinit, undefined, undefined, undefined);
}

function private preinit() {}