/*******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: abilities\mp\gadgets\gadget_smart_cover.csc
*******************************************************/

#using scripts\abilities\ability_player;
#using scripts\abilities\ability_power;
#using scripts\abilities\ability_util;
#using scripts\abilities\gadgets\gadget_smart_cover;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace smart_cover;

function private autoexec __init__system__() {
  system::register(#"gadget_smart_cover", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
}