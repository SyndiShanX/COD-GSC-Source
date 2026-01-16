/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_self_medication.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_self_medication;

function autoexec __init__sytem__() {
  system::register("zm_bgb_self_medication", & __init__, undefined, "bgb");
}

function __init__() {
  if(!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_self_medication", "event", & event, undefined, undefined, & validation);
  bgb::register_actor_death_override("zm_bgb_self_medication", & actor_death_override);
  bgb::register_lost_perk_override("zm_bgb_self_medication", & lost_perk_override, 0);
}

function event() {
  self endon("disconnect");
  self endon("bgb_update");
  self endon("bgb_self_medication_complete");
  self.var_25b88da = 3;
  self.w_min_last_stand_pistol_override = getweapon("ray_gun");
  level zm_utility::increment_no_end_game_check();
  self thread function_5816d71a();
  self thread function_cfc2c8d5();
  while (true) {
    self waittill("player_downed");
    self thread function_a8fd61f4();
  }
}

function validation() {
  if(isdefined(self.var_df0decf1) && self.var_df0decf1) {
    return false;
  }
  return true;
}

function function_5816d71a() {
  self util::waittill_any("disconnect", "bgb_update", "bgb_self_medication_complete");
  if(isdefined(self)) {
    self.w_min_last_stand_pistol_override = undefined;
  }
  wait(0.2);
  level zm_utility::decrement_no_end_game_check();
}

function actor_death_override(e_attacker) {
  if(e_attacker laststand::player_is_in_laststand() && (!(isdefined(e_attacker.var_df0decf1) && e_attacker.var_df0decf1))) {
    e_attacker thread bgb::bgb_revive_watcher();
    e_attacker notify("hash_935cc366");
  }
}

function function_cfc2c8d5() {
  self endon("disconnect");
  self endon("bgb_update");
  while (true) {
    self waittill("hash_935cc366");
    while (self getcurrentweapon() !== self.laststandpistol) {
      wait(0.05);
    }
    if(isdefined(self.has_specific_powerup_weapon) && (isdefined(self.has_specific_powerup_weapon["minigun"]) && self.has_specific_powerup_weapon["minigun"])) {
      zm_powerups::weapon_powerup_remove(self, "minigun_time_over", "minigun", 1);
    }
    self bgb::do_one_shot_use();
    self playsoundtoplayer("zmb_bgb_self_medication", self);
    if(isdefined(self.revivetrigger) && isdefined(self.revivetrigger.beingrevived)) {
      self.revivetrigger setinvisibletoall();
      self.revivetrigger.beingrevived = 0;
    }
    self zm_laststand::auto_revive(self, 0);
    self.var_25b88da--;
    self bgb::set_timer(self.var_25b88da, 3);
    if(self.var_25b88da == 0) {
      self notify("bgb_self_medication_complete");
      return;
    }
  }
}

function function_a8fd61f4() {
  self endon("player_revived");
  self endon("disconnect");
  self endon("bled_out");
  self waittill("player_eaten_by_thrasher");
  self.thrasher kill(self.thrasher.origin, self);
}

function lost_perk_override(perk, var_2488e46a = undefined, var_24df4040 = undefined) {
  if(isdefined(var_2488e46a) && isdefined(var_24df4040) && var_2488e46a == var_24df4040) {
    self thread bgb::revive_and_return_perk_on_bgb_activation(perk);
  }
  return false;
}