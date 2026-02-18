/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_black_sea_vehicle_oob.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\util_shared;
#namespace namespace_a208feb2;

function autoexec __init__() {
  var_c34e1dc2 = strtok("war12v12", " ");
  gametype = util::get_game_type();

  if(!isinarray(var_c34e1dc2, gametype) || !getdvarint(#"hash_360035890f73b515", 0)) {
    return;
  }

  callback::on_spawned(&on_spawned);
}

function event_handler[gametype_start] main(eventstruct) {
  var_c34e1dc2 = strtok("war12v12", " ");
  gametype = util::get_game_type();

  if(!isinarray(var_c34e1dc2, gametype) || !getdvarint(#"hash_360035890f73b515", 0)) {
    array::delete_all(getEntArray("vehicle_oob", "targetname"));
  }
}

function on_spawned() {
  player = self;

  if(!isDefined(player.var_c41d6d5b)) {
    player.var_c41d6d5b = getEntArray("vehicle_oob", "targetname");
  }

  foreach(vehicle_oob in player.var_c41d6d5b) {
    vehicle_oob setinvisibletoplayer(player, 1);
  }
}

function event_handler[enter_vehicle] codecallback_vehicleenter(eventstruct) {
  vehicle = eventstruct.vehicle;
  player = self;

  if(!isvehicle(vehicle)) {
    vehicle = self;
    player = eventstruct.player;
  }

  if(!isalive(player) || !isalive(vehicle) || vehicle.vehicletype !== # "hash_2c0e11a1e87bbcd5") {
    return;
  }

  if(!isDefined(player.var_c41d6d5b)) {
    player.var_c41d6d5b = getEntArray("vehicle_oob", "targetname");
  }

  foreach(vehicle_oob in player.var_c41d6d5b) {
    vehicle_oob setinvisibletoplayer(player, 0);
  }
}

function event_handler[exit_vehicle] codecallback_vehicleexit(eventstruct) {
  vehicle = eventstruct.vehicle;
  player = self;

  if(!isvehicle(vehicle)) {
    vehicle = self;
    player = eventstruct.player;
  }

  if(!isalive(player) || !isalive(vehicle)) {
    return;
  }

  if(!isDefined(player.var_c41d6d5b)) {
    player.var_c41d6d5b = getEntArray("vehicle_oob", "targetname");
  }

  foreach(vehicle_oob in player.var_c41d6d5b) {
    vehicle_oob setinvisibletoplayer(player, 1);
  }
}