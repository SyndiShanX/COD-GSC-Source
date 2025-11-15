/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\_counteruav.csc
********************************************/

#include clientscripts\mp\_utility;

init() {
  level._client_flag_callbacks["scriptmover"][11] = ::spawned;
}

spawned(localclientnum, set) {
  if(!isDefined(level.counteruavs))
    level.counteruavs = [];

  if(!isDefined(level.counteruavs[localclientnum]))
    level.counteruavs[localclientnum] = 0;

  player = getlocalplayer(localclientnum);
  assert(isDefined(player));

  if(!isDefined(player)) {
    return;
  }
  if(player getinkillcam(localclientnum)) {
    return;
  }
  if(set) {
    level.counteruavs[localclientnum]++;
    self thread counteruav_think(localclientnum);
    player setenemyglobalscrambler(1);
  } else
    self notify("counteruav_off");
}

counteruav_think(localclientnum) {
  self waittill_any("entityshutdown", "counteruav_off");
  level.counteruavs[localclientnum]--;

  if(level.counteruavs[localclientnum] < 0)
    level.counteruavs[localclientnum] = 0;

  player = getlocalplayer(localclientnum);
  assert(isDefined(player));

  if(level.counteruavs[localclientnum] == 0)
    player setenemyglobalscrambler(0);
}