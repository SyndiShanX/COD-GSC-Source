/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_claymore.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace claymore;

function autoexec __init__sytem__() {
  system::register("claymore", & __init__, undefined, undefined);
}

function __init__(localclientnum) {
  level._effect["fx_claymore_laser"] = "_t6/weapon/claymore/fx_claymore_laser";
  callback::add_weapon_type("claymore", & spawned);
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