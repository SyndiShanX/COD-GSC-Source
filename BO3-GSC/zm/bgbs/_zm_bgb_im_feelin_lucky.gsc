/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_im_feelin_lucky.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_im_feelin_lucky;

function autoexec __init__sytem__() {
  system::register("zm_bgb_im_feelin_lucky", &__init__, undefined, "bgb");
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_im_feelin_lucky", "activated", 2, undefined, undefined, undefined, &activation);
}

function activation() {
  powerup_origin = self bgb::get_player_dropped_powerup_origin();
  var_a8c63b5d = 0.75;
  n_roll = randomfloatrange(0, 1);
  if(n_roll < var_a8c63b5d) {
    var_93eb638b = zm_powerups::specific_powerup_drop(zm_powerups::get_regular_random_powerup_name(), powerup_origin);
  } else {
    if(isDefined(level.var_2d0e5eb6)) {
      str_powerup = [[level.var_2d0e5eb6]]();
    } else {
      str_powerup = function_29a9b9b8();
    }
    if(str_powerup === "free_perk") {
      if(isDefined(level.var_2d0e5eb6)) {
        str_powerup = [[level.var_2d0e5eb6]]();
      } else {
        str_powerup = function_29a9b9b8();
      }
    }
    var_93eb638b = zm_powerups::specific_powerup_drop(str_powerup, powerup_origin, undefined, undefined, undefined, self);
  }
  var_bc1994bd = zm_utility::check_point_in_enabled_zone(var_93eb638b.origin, undefined, undefined);
  wait(1);
  if(!var_bc1994bd) {
    level thread bgb::function_434235f9(var_93eb638b);
  }
}

function function_29a9b9b8() {
  var_d7a75a6e = getarraykeys(level.zombie_powerups);
  var_d7a75a6e = array::randomize(var_d7a75a6e);
  foreach(str_key in var_d7a75a6e) {
    if(level.zombie_powerups[str_key].player_specific === 1) {
      arrayremovevalue(var_d7a75a6e, str_key);
    }
  }
  return var_d7a75a6e[0];
}