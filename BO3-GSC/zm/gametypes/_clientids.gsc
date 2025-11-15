/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\gametypes\_clientids.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#namespace clientids;

function autoexec __init__sytem__() {
  system::register("clientids", & __init__, undefined, undefined);
}

function __init__() {
  callback::on_start_gametype( & init);
  callback::on_connect( & on_player_connect);
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
  println((("" + self.name) + "") + self.clientid);
}