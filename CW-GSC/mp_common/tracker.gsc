/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\tracker.gsc
***********************************************/

#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\tracker_shared;
#using scripts\core_common\util_shared;
#namespace tracker;

function private autoexec __init__system__() {
  system::register(#"tracker", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
}