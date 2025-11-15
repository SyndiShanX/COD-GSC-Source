/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_woods.gsc
************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\item_world;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;
#include scripts\wz_common\character_unlock_woods_fixup;

#namespace character_unlock_woods;

autoexec __init__system__() {
  system::register(#"character_unlock_woods", &__init__, undefined, #"character_unlock_woods_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"woods_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
    callback::add_callback(#"on_last_alive", &function_4ac25840);
    level.var_e1b226fb = 1;
    level thread function_6cba9a1a();
  }
}

function_6cba9a1a() {
  item_world::function_4de3ca98();
  var_e32947b9 = function_91b29d2a(#"cu22_spawn");

  if(!isDefined(var_e32947b9[0])) {
    return;
  }

  var_f93e4ee2 = 0;
  vehicles = getvehiclearray();

  foreach(vehicle in vehicles) {
    if(isairborne(vehicle)) {
      if(distance2d(vehicle.origin, var_e32947b9[0].origin) < 800) {
        var_f93e4ee2 = 1;
        break;
      }
    }
  }

  if(!var_f93e4ee2) {
    foreach(item in var_e32947b9) {
      item_world::consume_item(item);
    }
  }
}

event_handler[enter_vehicle] codecallback_vehicleenter(eventstruct) {
  if(!(isDefined(level.var_e1b226fb) && level.var_e1b226fb)) {
    return;
  }

  if(!isplayer(self)) {
    return;
  }

  vehicle = eventstruct.vehicle;
  seatindex = eventstruct.seat_index;

  if(isairborne(vehicle) && seatindex === 0 && character_unlock::function_f0406288(#"woods_unlock")) {
    self thread function_6a61388f(vehicle);
  }
}

event_handler[change_seat] function_2aa4e6cf(eventstruct) {
  if(!(isDefined(level.var_e1b226fb) && level.var_e1b226fb)) {
    return;
  }

  if(!isplayer(self)) {
    return;
  }

  vehicle = eventstruct.vehicle;
  seatindex = eventstruct.seat_index;

  if(isairborne(vehicle) && seatindex === 0 && character_unlock::function_f0406288(#"woods_unlock")) {
    self thread function_6a61388f(vehicle);
  }
}

function_6a61388f(vehicle) {
  self notify("3609f878877561c6");
  self endon("3609f878877561c6");
  self endon(#"death", #"disconnect", #"exit_vehicle", #"change_seat");
  vehicle endon(#"death");

  if(!isDefined(self.var_1e8d9480)) {
    self.var_1e8d9480 = 0;
  }

  while(true) {
    if(self.var_1e8d9480 >= 60 && self character_unlock::function_f0406288(#"woods_unlock")) {
      self character_unlock::function_c8beca5e(#"woods_unlock", #"hash_17a4baf5ec553be7", 1);
      return;
    }

    self.var_1e8d9480 += 0.5;
    wait 0.5;
  }
}

function_1c4b5097(item) {
  itementry = item.itementry;

  if(itementry.name === #"cu22_item") {
    if(self character_unlock::function_f0406288(#"woods_unlock") && (self.deaths !== 0 || self.suicides !== 0)) {
      self character_unlock::function_c8beca5e(#"woods_unlock", #"hash_17a4bbf5ec553d9a", 2);
    }
  }
}

function_4ac25840(params) {
  foreach(team in params.teams_alive) {
    players = getplayers(team);

    foreach(player in players) {
      if(isalive(player) && player character_unlock::function_f0406288(#"woods_unlock") && player.deaths === 0 && player.suicides === 0) {
        player character_unlock::function_c8beca5e(#"woods_unlock", #"hash_17a4bbf5ec553d9a", 1);
      }
    }
  }
}