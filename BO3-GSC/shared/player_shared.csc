/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\player_shared.csc
*************************************************/

#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#namespace player;

function autoexec __init__sytem__() {
  system::register("player", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("world", "gameplay_started", 4000, 1, "int", & gameplay_started_callback, 0, 1);
}

function gameplay_started_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  setdvar("cg_isGameplayActive", newval);
}