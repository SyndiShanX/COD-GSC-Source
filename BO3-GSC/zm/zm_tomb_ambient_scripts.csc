/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_tomb_ambient_scripts.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#namespace zm_tomb_ambient_scripts;

function main() {
  clientfield::register("scriptmover", "zeppelin_fx", 21000, 1, "int", & zeppelin_fx, 0, 0);
}

function zeppelin_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self.var_1f4bb75 = playfxontag(localclientnum, level._effect["zeppelin_lights"], self, "tag_body");
  } else if(isdefined(self.var_1f4bb75)) {
    stopfx(localclientnum, self.var_1f4bb75);
  }
}