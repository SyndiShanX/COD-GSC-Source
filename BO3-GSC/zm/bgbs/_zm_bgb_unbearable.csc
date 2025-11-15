/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_unbearable.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_unbearable;

function autoexec __init__sytem__() {
  system::register("zm_bgb_unbearable", & __init__, undefined, undefined);
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_unbearable", "event");
  clientfield::register("zbarrier", "zm_bgb_unbearable", 1, 1, "counter", & function_cd297226, 0, 0);
  level._effect["zm_bgb_unbearable"] = "zombie/fx_bgb_unbearable_box_flash_zmb";
}

function function_cd297226(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playFX(localclientnum, level._effect["zm_bgb_unbearable"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
}