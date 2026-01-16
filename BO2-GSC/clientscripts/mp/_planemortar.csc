/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\_planemortar.csc
*********************************************/

#include clientscripts\mp\_utility;

init() {
  level.planemortarexhaustfx = loadfx("vehicle/exhaust/fx_exhaust_f35_afterburner");
  registerclientfield("scriptmover", "planemortar_contrail", 1, 1, "int", ::planemortar_contrail, 0);
}

planemortar_contrail(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon("death");
  self endon("entityshutdown");

  if(newval)
    self.fx = playfxontag(localclientnum, level.planemortarexhaustfx, self, "tag_origin");
}