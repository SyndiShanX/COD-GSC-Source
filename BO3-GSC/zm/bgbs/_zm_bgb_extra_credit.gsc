/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_extra_credit.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_extra_credit;

function autoexec __init__sytem__() {
  system::register("zm_bgb_extra_credit", &__init__, undefined, "bgb");
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_extra_credit", "activated", 4, undefined, undefined, undefined, &activation);
}

function activation() {
  powerup_origin = self bgb::get_player_dropped_powerup_origin();
  self thread function_b18c3b2d(powerup_origin);
}

function function_b18c3b2d(origin) {
  self endon("disconnect");
  self endon("bled_out");
  var_93eb638b = zm_powerups::specific_powerup_drop("bonus_points_player", origin, undefined, undefined, 0.1);
  var_93eb638b.bonus_points_powerup_override = &function_3258dd42;
  wait(1);
  if(isDefined(var_93eb638b) && (!var_93eb638b zm::in_enabled_playable_area() && !var_93eb638b zm::in_life_brush())) {
    level thread bgb::function_434235f9(var_93eb638b);
  }
}

function function_3258dd42() {
  return 1250;
}