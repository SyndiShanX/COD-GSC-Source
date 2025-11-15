/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_unquenchable.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_unquenchable;

function autoexec __init__sytem__() {
  system::register("zm_bgb_unquenchable", & __init__, undefined, "bgb");
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_unquenchable", "event", & event, undefined, undefined, undefined);
}

function event() {
  self endon("disconnect");
  self endon("bgb_update");
  do {
    self waittill("perk_purchased");
  }
  while(self.num_perks < self zm_utility::get_player_perk_purchase_limit());
  self bgb::do_one_shot_use(1);
}