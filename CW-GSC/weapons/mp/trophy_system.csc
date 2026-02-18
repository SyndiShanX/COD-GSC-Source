/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\mp\trophy_system.csc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\weapons\trophy_system;
#namespace trophy_system;

function private autoexec __init__system__() {
  system::register(#"trophy_system", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
}