/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_shopping_free.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_shopping_free;

function autoexec __init__sytem__() {
  system::register("zm_bgb_shopping_free", &__init__, undefined, "bgb");
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_shopping_free", "time", 60, &enable, &disable, undefined, undefined);
}

function enable() {
  self endon("disconnect");
  self endon("bled_out");
  self endon("bgb_update");
}

function disable() {}