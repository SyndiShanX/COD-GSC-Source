/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_castle_rocketshield.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_weapons;
#namespace castle_rocketshield;

function autoexec __init__sytem__() {
  system::register("zm_weap_castle_rocketshield", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("allplayers", "rs_ammo", 1, 1, "int", &set_rocketshield_ammo, 0, 0);
}

function set_rocketshield_ammo(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, 0, 0);
  } else {
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 0, 0);
  }
}