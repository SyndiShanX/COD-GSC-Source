/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_impatient.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_impatient;

function autoexec __init__sytem__() {
  system::register("zm_bgb_impatient", & __init__, undefined, "bgb");
}

function __init__() {
  if(!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_impatient", "event", & event, undefined, undefined, undefined);
}

function event() {
  self endon("disconnect");
  self endon("bgb_update");
  self waittill("bgb_about_to_take_on_bled_out");
  self thread special_revive();
}

function special_revive() {
  self endon("disconnect");
  wait(1);
  while (level.zombie_total > 0) {
    wait(0.05);
  }
  self zm::spectator_respawn_player();
  self bgb::do_one_shot_use();
}