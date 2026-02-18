/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_carpenter.csc
***********************************************/

#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;
#namespace zm_powerup_carpenter;

function private autoexec __init__system__() {
  system::register(#"zm_powerup_carpenter", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  zm_powerups::include_zombie_powerup("carpenter");
  zm_powerups::add_zombie_powerup("carpenter");
}