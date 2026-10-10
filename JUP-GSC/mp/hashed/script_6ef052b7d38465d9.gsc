/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6ef052b7d38465d9.gsc
*************************************************/

#using script_422801cfe4074e05;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_5b79e0098b7edf4d;

function init() {
  assert(flag("<dev string:x1c>"));
  callback::add("player_spawned", &on_player_spawn);
}

function private on_player_spawn(params) {
  player = self;

  if(!isDefined(player)) {
    return;
  }

  analytics::addevent("player_spawned", player getorigin(), 0, "", player);
}