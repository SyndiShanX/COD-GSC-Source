/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_zones.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_load;
#namespace zm_island_zones;

function init() {
  clientfield::register("scriptmover", "vine_door_play_fx", 9000, 1, "int", & vine_door_play_fx, 0, 0);
}

function vine_door_play_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playfxontag(localclientnum, level._effect["door_vine_fx"], self, "tag_fx_origin");
}

function main() {}