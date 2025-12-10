/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_shrink_ray.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;
#namespace zm_weap_shrink_ray;

function autoexec __init__sytem__() {
  system::register("zm_weap_shrink_ray", &__init__, &__main__, undefined);
}

function __init__() {
  clientfield::register("actor", "fun_size", 5000, 1, "int", &fun_size, 0, 0);
}

function __main__() {}

function fun_size(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self suppressragdollselfcollision(newval);
  self.shrunken = newval;
}