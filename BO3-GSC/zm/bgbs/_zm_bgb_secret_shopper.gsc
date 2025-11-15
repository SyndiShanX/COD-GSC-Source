/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_secret_shopper.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_bgb_secret_shopper;

function autoexec __init__sytem__() {
  system::register("zm_bgb_secret_shopper", & __init__, undefined, "bgb");
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_secret_shopper", "time", 600, & enable, & disable, undefined, undefined);
}

function enable() {
  self endon("disconnect");
  self endon("bled_out");
  self endon("bgb_update");
  bgb::function_650ca64(7);
  while(true) {
    self waittill("zm_bgb_secret_shopper", var_2757208f);
    var_2757208f thread function_127dc5ca(self);
  }
}

function disable() {
  bgb::function_eabb0903();
}

function function_127dc5ca(player) {
  self notify("hash_127dc5ca");
  self endon("hash_127dc5ca");
  self endon("kill_trigger");
  self endon("hash_a09e2c64");
  player endon("bgb_update");
  while(true) {
    player waittill("bgb_activation_request");
    if(player.useholdent !== self) {
      continue;
    }
    if(!player bgb::is_enabled("zm_bgb_secret_shopper")) {
      continue;
    }
    w_current = player.currentweapon;
    n_ammo_cost = player zm_weapons::get_ammo_cost_for_weapon(w_current);
    var_b2860cb0 = 0;
    if(player zm_score::can_player_purchase(n_ammo_cost) && !zm_weapons::is_wonder_weapon(w_current)) {
      var_b2860cb0 = player zm_weapons::ammo_give(w_current);
    }
    if(var_b2860cb0) {
      player zm_score::minus_to_player_score(n_ammo_cost);
      player bgb::do_one_shot_use(1);
    } else {
      player bgb::function_ca189700();
    }
    wait(0.05);
  }
}