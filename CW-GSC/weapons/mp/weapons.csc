/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\mp\weapons.csc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\weapons\weapons;
#namespace weapons;

function private autoexec __init__system__() {
  system::register(#"weapons", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
}