/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_transport.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_weapons;
#namespace zm_island_transport;

function init() {
  clientfield::register("vehicle", "sewer_current_fx", 9000, 1, "int", &sewer_current_fx, 0, 0);
}

function sewer_current_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(!isDefined(self.var_7e61ace3)) {
      self.var_7e61ace3 = [];
    }
    self thread function_a39e4663(localclientnum);
  } else {
    self notify("hash_ab837d11");
    if(isDefined(self.var_7e61ace3[localclientnum])) {
      deletefx(localclientnum, self.var_7e61ace3[localclientnum], 0);
    }
  }
}

function function_a39e4663(localclientnum) {
  self endon("hash_ab837d11");
  while(true) {
    self.var_7e61ace3[localclientnum] = playFXOnTag(localclientnum, level._effect["current_effect"], self, "tag_origin");
    wait(0.05);
  }
}