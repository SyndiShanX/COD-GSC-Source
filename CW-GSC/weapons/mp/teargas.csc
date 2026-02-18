/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\mp\teargas.csc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\weapons\teargas;
#namespace teargas;

function private autoexec __init__system__() {
  system::register(#"teargas", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
}