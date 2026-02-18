/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\entityheadicons.gsc
***********************************************/

#using scripts\core_common\entityheadicons_shared;
#using scripts\core_common\system_shared;
#namespace entityheadicons;

function private autoexec __init__system__() {
  system::register(#"entityheadicons", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
}