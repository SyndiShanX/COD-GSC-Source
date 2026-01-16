/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_temple_ai_monkey.csc
*************************************************/

#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace zm_temple_ai_monkey;

function autoexec __init__sytem__() {
  system::register("zm_temple_ai_monkey", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "monkey_ragdoll", 21000, 1, "int", & monkey_ragdoll, 1, 0);
}

function monkey_ragdoll(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self suppressragdollselfcollision(1);
  }
}