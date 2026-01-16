/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_controllable_spider.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_bouncingbetty;
#using scripts\zm\_util;
#namespace controllable_spider;

function autoexec __init__sytem__() {
  system::register("controllable_spider", & __init__, undefined, undefined);
}

function __init__(localclientnum) {
  clientfield::register("scriptmover", "player_cocooned_fx", 9000, 1, "int", & player_cocooned_fx, 0, 0);
  clientfield::register("allplayers", "player_cocooned_fx", 9000, 1, "int", & player_cocooned_fx, 0, 0);
}

function player_cocooned_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(!isdefined(self.var_e3645e32)) {
      self.var_e3645e32 = [];
    }
    self.var_e3645e32[localclientnum] = playfxontag(localclientnum, level._effect["cocooned_fx"], self, "tag_origin");
  }
}