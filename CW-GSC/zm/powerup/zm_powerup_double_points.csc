/***************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_double_points.csc
***************************************************/

#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;
#namespace zm_powerup_double_points;

function private autoexec __init__system__() {
  system::register(#"zm_powerup_double_points", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  zm_powerups::include_zombie_powerup("double_points");

  if(zm_powerups::function_cc33adc8()) {
    zm_powerups::add_zombie_powerup("double_points", "powerup_double_points");
  }
}