/*****************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_alchemical_antithesis.gsc
*****************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_alchemical_antithesis;

function autoexec __init__sytem__() {
  system::register("zm_bgb_alchemical_antithesis", &__init__, undefined, "bgb");
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_alchemical_antithesis", "activated", 2, undefined, undefined, &validation, &activation);
  bgb::function_336ffc4e("zm_bgb_alchemical_antithesis");
  bgb::function_ff4b2998("zm_bgb_alchemical_antithesis", &add_to_player_score_override, 0);
}

function validation() {
  return !(isDefined(self bgb::get_active()) && self bgb::get_active());
}

function activation() {
  self.ready_for_score_events = 0;
  self bgb::run_timer(60);
  self.ready_for_score_events = 1;
}

function add_to_player_score_override(points, str_awarded_by, var_1ed9bd9b) {
  if(!(isDefined(self.bgb_active) && self.bgb_active)) {
    return points;
  }
  var_4375ef8a = int(points / 10);
  current_weapon = self getcurrentweapon();
  if(zm_utility::is_offhand_weapon(current_weapon)) {
    return points;
  }
  if(isDefined(self.is_drinking) && self.is_drinking) {
    return points;
  }
  if(current_weapon == level.weaponrevivetool) {
    return points;
  }
  var_b8f62d73 = self getweaponammostock(current_weapon);
  var_b8f62d73 = var_b8f62d73 + var_4375ef8a;
  self setweaponammostock(current_weapon, var_b8f62d73);
  self thread function_a6bf711f();
  self zm_stats::increment_challenge_stat("GUM_GOBBLER_ALCHEMICAL_ANTITHESIS", var_4375ef8a);
  return 0;
}

function function_a6bf711f() {
  if(!isDefined(self.var_82764e33)) {
    self.var_82764e33 = 0;
  }
  if(!self.var_82764e33) {
    self.var_82764e33 = 1;
    self playsoundtoplayer("zmb_bgb_alchemical_ammoget", self);
    wait(0.5);
    if(isDefined(self)) {
      self.var_82764e33 = 0;
    }
  }
}