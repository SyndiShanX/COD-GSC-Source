/******************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_immolation_liquidation.gsc
******************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_immolation_liquidation;

function autoexec __init__sytem__() {
  system::register("zm_bgb_immolation_liquidation", &__init__, undefined, "bgb");
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_immolation_liquidation", "activated", 3, undefined, undefined, &function_3d1f600e, &activation);
}

function activation() {
  self thread bgb::function_dea74fb0("fire_sale");
}

function function_3d1f600e() {
  if(level.zombie_vars["zombie_powerup_fire_sale_on"] === 1 || (isDefined(level.disable_firesale_drop) && level.disable_firesale_drop)) {
    return false;
  }
  return true;
}