/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\cp\weaponobjects.csc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\weapons\weaponobjects;
#namespace weaponobjects;

function private autoexec __init__system__() {
  system::register(#"weaponobjects", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
}