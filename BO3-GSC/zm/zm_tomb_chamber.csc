/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_tomb_chamber.csc
*************************************************/

#using scripts\shared\clientfield_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\system_shared;
#using scripts\zm\_zm_utility;
#namespace zm_challenges_tomb;

function autoexec __init__sytem__() {
  system::register("zm_tomb_chamber", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "divider_fx", 21000, 1, "counter", & function_fa586bee, 0, 0);
}

function function_fa586bee(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    for(i = 1; i <= 9; i++) {
      playFXOnTag(localclientnum, level._effect["crypt_wall_drop"], self, "tag_fx_dust_0" + i);
    }
  }
}