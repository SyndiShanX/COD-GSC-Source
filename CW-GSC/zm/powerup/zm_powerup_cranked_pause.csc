/***************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_cranked_pause.csc
***************************************************/

#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;
#namespace namespace_65320816;

function private autoexec __init__system__() {
  system::register(#"hash_2209575d9ead0b63", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  zm_powerups::include_zombie_powerup("cranked_pause");

  if(zm_powerups::function_cc33adc8()) {
    zm_powerups::add_zombie_powerup("cranked_pause", "powerup_cranked_pause");
  }
}