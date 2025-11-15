/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_crate_power.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_crate_power;

function autoexec __init__sytem__() {
  system::register("zm_bgb_crate_power", & __init__, undefined, "bgb");
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_crate_power", "event", & event, undefined, undefined, undefined);
}

function event() {
  self endon("disconnect");
  self endon("bgb_update");
  self waittill("zm_bgb_crate_power_used");
  self playsoundtoplayer("zmb_bgb_crate_power", self);
  self bgb::do_one_shot_use();
}