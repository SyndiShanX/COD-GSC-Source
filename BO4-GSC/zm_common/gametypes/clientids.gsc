/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\clientids.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;

#namespace clientids;

autoexec __init__system__() {
  system::register(#"clientids", &__init__, undefined, undefined);
}

__init__() {
  callback::on_start_gametype(&init);
  callback::on_connect(&on_player_connect);
}

init() {
  level.clientid = 0;
}

on_player_connect() {
  self.clientid = matchrecordnewplayer(self);

  if(!isDefined(self.clientid) || self.clientid == -1) {
    self.clientid = level.clientid;
    level.clientid++;
  }

  println("<dev string:x38>" + self.name + "<dev string:x43>" + self.clientid);
}