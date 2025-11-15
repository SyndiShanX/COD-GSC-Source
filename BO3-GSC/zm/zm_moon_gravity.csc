/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_moon_gravity.csc
*************************************************/

#namespace zm_moon_gravity;

function init() {}

function zombie_low_gravity(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon("death");
  self endon("entityshutdown");
  if(newval) {
    self.in_low_g = 1;
  } else {
    self.in_low_g = 0;
  }
}

function function_20286238(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon("death");
  self endon("entityshutdown");
  if(newval) {
    if(!isDefined(self.var_9f5aac3e)) {
      self.var_9f5aac3e = self playLoopSound("zmb_moon_bg_airless");
    }
  } else if(isDefined(self.var_9f5aac3e)) {
    self stoploopsound(self.var_9f5aac3e);
    self.var_9f5aac3e = undefined;
  }
}