/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_claymore.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\util_shared;
#namespace _claymore;

function init(localclientnum) {
  level._effect["fx_claymore_laser"] = "_t6/weapon/claymore/fx_claymore_laser";
}

function spawned(localclientnum) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  while(true) {
    if(isDefined(self.stunned) && self.stunned) {
      wait(0.1);
      continue;
    }
    self.claymorelaserfxid = playFXOnTag(localclientnum, level._effect["fx_claymore_laser"], self, "tag_fx");
    self waittill("stunned");
    stopfx(localclientnum, self.claymorelaserfxid);
  }
}