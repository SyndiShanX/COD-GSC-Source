/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: wz_common\vehicle.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicles\player_vehicle;
#namespace wz_vehicle;

function private autoexec __init__system__() {
  system::register(#"wz_vehicle", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.var_cd8f416a = [];
  level.var_63e0085 = 0;
  level.var_7c6454 = 1;
  callback::add_callback(#"hash_5ca3a1f306039e1e", &function_f565cb50);
  callback::add_callback(#"hash_666d48a558881a36", &function_8307577f);
  callback::add_callback(#"hash_2c1cafe2a67dfef8", &function_6bcb016d);
}

function function_f565cb50() {
  level.var_cd8f416a[level.var_cd8f416a.size] = self;
}

function function_8307577f(params) {
  vehicle = self;
  player = params.player;
  seatindex = params.eventstruct.seat_index;

  if(seatindex === 0) {
    callback::callback("on_driving_wz_vehicle", {
      #vehicle: vehicle, #player: player, #seatindex: seatindex
    });
  }
}

function function_6bcb016d(params) {
  vehicle = self;
  player = params.player;
  seatindex = params.eventstruct.seat_index;
  oldseatindex = params.eventstruct.old_seat_index;

  if(seatindex == 0) {
    callback::callback("on_driving_wz_vehicle", {
      #vehicle: vehicle, #player: self, #seatindex: seatindex
    });
  }
}