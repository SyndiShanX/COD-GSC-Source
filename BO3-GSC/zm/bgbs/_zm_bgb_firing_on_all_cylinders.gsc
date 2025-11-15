/*******************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_firing_on_all_cylinders.gsc
*******************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_firing_on_all_cylinders;

function autoexec __init__sytem__() {
  system::register("zm_bgb_firing_on_all_cylinders", & __init__, undefined, "bgb");
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_firing_on_all_cylinders", "rounds", 3, & enable, & disable, undefined);
}

function enable() {
  self setperk("specialty_sprintfire");
}

function disable() {
  self unsetperk("specialty_sprintfire");
}