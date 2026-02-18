/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\cp\smokegrenade.gsc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\weapons\smokegrenade;
#namespace smokegrenade;

function private autoexec __init__system__() {
  system::register(#"smokegrenade", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
}