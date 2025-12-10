/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_ctf.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#namespace client_flag;

function autoexec __init__sytem__() {
  system::register("client_flag", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "ctf_flag_away", 1, 1, "int", &setctfaway, 0, 0);
}

function setctfaway(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  team = self.team;
  setflagasaway(localclientnum, team, newval);
  self thread clearctfaway(localclientnum, team);
}

function clearctfaway(localclientnum, team) {
  self waittill("entityshutdown");
  setflagasaway(localclientnum, team, 0);
}