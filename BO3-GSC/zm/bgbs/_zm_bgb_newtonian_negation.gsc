/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_newtonian_negation.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_newtonian_negation;

function autoexec __init__sytem__() {
  system::register("zm_bgb_newtonian_negation", & __init__, undefined, "bgb");
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_newtonian_negation", "time", 1500, & enable, & disable, undefined);
}

function enable() {
  function_2b4ff13a(1);
  self thread function_7d6ddd3a();
}

function function_7d6ddd3a() {
  self endon("hash_7e8cbf8f");
  self waittill("disconnect");
  thread disable();
}

function disable() {
  if(isDefined(self)) {
    self notify("hash_7e8cbf8f");
  }
  foreach(player in level.players) {
    if(player !== self && player bgb::is_enabled("zm_bgb_newtonian_negation")) {
      return;
    }
  }
  function_2b4ff13a(0);
  zombie_utility::clear_all_corpses();
}

function function_2b4ff13a(var_365c612) {
  if(var_365c612) {
    setdvar("phys_gravity_dir", (0, 0, -1));
  } else {
    setdvar("phys_gravity_dir", (0, 0, 1));
  }
}