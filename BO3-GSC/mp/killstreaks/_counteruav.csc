/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_counteruav.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace counteruav;

function autoexec __init__sytem__() {
  system::register("counteruav", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("toplayer", "counteruav", 1, 1, "int", & counteruavchanged, 0, 1);
}

function counteruavchanged(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  player = getlocalplayer(localclientnum);
  assert(isDefined(player));
  player setenemyglobalscrambler(newval);
}