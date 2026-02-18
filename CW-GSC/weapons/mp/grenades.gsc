/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\mp\grenades.gsc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\weapons\grenades;
#namespace grenades;

function private autoexec __init__system__() {
  system::register(#"grenades", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
}