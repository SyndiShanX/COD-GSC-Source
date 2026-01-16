/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_planemortar.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#namespace planemortar;

function autoexec __init__sytem__() {
  system::register("planemortar", & __init__, undefined, undefined);
}

function __init__() {
  level.planemortarexhaustfx = "killstreaks/fx_ls_exhaust_afterburner";
  clientfield::register("scriptmover", "planemortar_contrail", 1, 1, "int", & planemortar_contrail, 0, 0);
}

function planemortar_contrail(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("death");
  self endon("entityshutdown");
  if(newval) {
    self.fx = playfxontag(localclientnum, level.planemortarexhaustfx, self, "tag_fx");
  }
}