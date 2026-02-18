/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\clientids.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#namespace clientids;

function private autoexec __init__system__() {
  system::register(#"clientids", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_start_gametype(&init);
  callback::on_connect(&on_player_connect);
}

function init() {
  level.clientid = 0;
}

function on_player_connect() {
  self.clientid = matchrecordnewplayer(self);

  if(!isDefined(self.clientid) || self.clientid == -1) {
    self.clientid = level.clientid;
    level.clientid++;
  }

  println("<dev string:x38>" + self.name + "<dev string:x44>" + self.clientid);
}