/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_projectile_vomiting.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_projectile_vomiting;

function autoexec __init__sytem__() {
  system::register("zm_bgb_projectile_vomiting", & __init__, undefined, "bgb");
}

function __init__() {
  if(!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  clientfield::register("actor", "projectile_vomit", 12000, 1, "counter");
  bgb::register("zm_bgb_projectile_vomiting", "rounds", 5, & enable, & disable, undefined);
  bgb::register_actor_death_override("zm_bgb_projectile_vomiting", & actor_death_override);
}

function enable() {}

function disable() {}

function actor_death_override(attacker) {
  if(isdefined(self.damagemod)) {
    switch (self.damagemod) {
      case "MOD_EXPLOSIVE":
      case "MOD_GRENADE":
      case "MOD_GRENADE_SPLASH":
      case "MOD_PROJECTILE":
      case "MOD_PROJECTILE_SPLASH": {
        clientfield::increment("projectile_vomit", 1);
        break;
      }
    }
  }
}