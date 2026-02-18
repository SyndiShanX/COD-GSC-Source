/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: abilities\zm\abilities.csc
***********************************************/

#using scripts\abilities\ability_gadgets;
#using scripts\abilities\ability_player;
#using scripts\abilities\ability_power;
#using scripts\abilities\ability_util;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;
#namespace abilities;

function private autoexec __init__system__() {
  system::register(#"abilities", &preinit, undefined, undefined, undefined);
}

function private preinit() {}