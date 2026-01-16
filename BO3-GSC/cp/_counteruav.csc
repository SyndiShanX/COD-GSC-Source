/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_counteruav.csc
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
  clientfield::register("scriptmover", "counteruav", 1, 1, "int", & spawned, 0, 0);
}

function spawned(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isdefined(level.counteruavs)) {
    level.counteruavs = [];
  }
  if(!isdefined(level.counteruavs[localclientnum])) {
    level.counteruavs[localclientnum] = 0;
  }
  player = getlocalplayer(localclientnum);
  assert(isdefined(player));
  if(newval) {
    level.counteruavs[localclientnum]++;
    self thread counteruav_think(localclientnum);
    player setenemyglobalscrambler(1);
  } else {
    self notify("counteruav_off");
  }
}

function counteruav_think(localclientnum) {
  self util::waittill_any("entityshutdown", "counteruav_off");
  level.counteruavs[localclientnum]--;
  if(level.counteruavs[localclientnum] < 0) {
    level.counteruavs[localclientnum] = 0;
  }
  player = getlocalplayer(localclientnum);
  assert(isdefined(player));
  if(level.counteruavs[localclientnum] == 0) {
    player setenemyglobalscrambler(0);
  }
}