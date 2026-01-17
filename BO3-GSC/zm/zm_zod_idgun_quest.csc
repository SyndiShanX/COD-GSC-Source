/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_zod_idgun_quest.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_load;
#using_animtree("generic");
#namespace zm_zod_idgun_quest;

function autoexec __init__sytem__() {
  system::register("zm_zod_idgun_quest", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("world", "add_idgun_to_box", 1, 4, "int", &add_idgun_to_box, 0, 0);
  clientfield::register("world", "remove_idgun_from_box", 1, 4, "int", &remove_idgun_from_box, 0, 0);
}

function add_idgun_to_box(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  weapon_idgun = getweapon(("idgun" + "_") + newval);
  addzombieboxweapon(weapon_idgun, weapon_idgun.worldmodel, weapon_idgun.isdualwield);
}

function remove_idgun_from_box(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  weapon_idgun = getweapon(("idgun" + "_") + newval);
  removezombieboxweapon(weapon_idgun);
}