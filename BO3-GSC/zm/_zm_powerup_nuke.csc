/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_powerup_nuke.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\zm\_zm_powerups;
#namespace zm_powerup_nuke;

function autoexec __init__sytem__() {
  system::register("zm_powerup_nuke", & __init__, undefined, undefined);
}

function __init__() {
  zm_powerups::include_zombie_powerup("nuke");
  zm_powerups::add_zombie_powerup("nuke");
  clientfield::register("actor", "zm_nuked", 1000, 1, "counter", & zombie_nuked, 0, 0);
  clientfield::register("vehicle", "zm_nuked", 1000, 1, "counter", & zombie_nuked, 0, 0);
}

function zombie_nuked(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self zombie_death::flame_death_fx(localclientnum);
}