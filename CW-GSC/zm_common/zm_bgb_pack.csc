/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_bgb_pack.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\load;
#namespace bgb_pack;

function private autoexec __init__system__() {
  system::register(#"bgb_pack", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  if(!is_true(level.bgb_in_use)) {
    return;
  }
}

function private postinit() {
  if(!is_true(level.bgb_in_use)) {
    return;
  }
}