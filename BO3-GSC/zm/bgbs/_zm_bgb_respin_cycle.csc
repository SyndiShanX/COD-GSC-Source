/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_respin_cycle.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_respin_cycle;

function autoexec __init__sytem__() {
  system::register("zm_bgb_respin_cycle", & __init__, undefined, undefined);
}

function __init__() {
  if(!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_respin_cycle", "activated");
  clientfield::register("zbarrier", "zm_bgb_respin_cycle", 1, 1, "counter", & function_74ecbbd7, 0, 0);
  level._effect["zm_bgb_respin_cycle"] = "zombie/fx_bgb_respin_cycle_box_flash_zmb";
}

function function_74ecbbd7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playfx(localclientnum, level._effect["zm_bgb_respin_cycle"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
}