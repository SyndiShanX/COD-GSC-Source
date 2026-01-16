/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_perkaholic.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_perkaholic;

function autoexec __init__sytem__() {
  system::register("zm_bgb_perkaholic", & __init__, undefined, "bgb");
}

function __init__() {
  if(!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_perkaholic", "event", & event, undefined, undefined, undefined);
}

function event() {
  self endon("disconnect");
  self endon("bgb_update");
  self zm_utility::give_player_all_perks();
  self bgb::do_one_shot_use(1);
  wait(0.05);
}