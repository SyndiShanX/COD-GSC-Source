/******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\player_snowmobile.gsc
******************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\player_vehicle;
#namespace player_snowmobile;

function private autoexec __init__system__() {
  system::register(#"player_snowmobile", &preinit, undefined, undefined, #"player_vehicle");
}

function private preinit() {
  vehicle::add_main_callback("player_snowmobile", &function_13ea784);
}

function private function_13ea784() {
  callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_4099f945);
  callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &function_dfba6306);
  self.var_93dc9da9 = "veh_atv_wall_imp";
  self.var_d6691161 = 200;
  self.var_5002d77c = 0.6;
  self player_vehicle::function_cc30c4bb(#"hash_22c22a196fd2cc77", 6);
}

function private function_f176e7d2(player) {
  player endon(#"death");
  self endon(#"death");
  player endon(#"exit_vehicle");
  self notify("76a2a54cd8cbe9ce");
  self endon("76a2a54cd8cbe9ce");

  while(true) {
    seatindex = self getoccupantseat(player);

    if(seatindex != 0 && seatindex != 6) {
      return;
    }

    speed = abs(self getspeedmph());

    if(speed >= 10) {
      var_9687e67e = array("front_right", "front_left", "back_right", "back_left");
      var_79ca7c96 = array("snow", "ice", "water", "none");
      var_118c8c16 = 0;

      foreach(wheel in var_9687e67e) {
        var_b0029690 = self getwheelsurface(wheel);

        if(!isinarray(var_79ca7c96, var_b0029690)) {
          var_118c8c16++;
        }
      }

      if(var_118c8c16 > 0) {
        self dodamage(1 * var_118c8c16, self.origin);
      }
    }

    wait 1;
  }
}

function private function_4099f945(params) {
  player = params.player;
  eventstruct = params.eventstruct;

  if(!isDefined(player)) {
    return;
  }

  if(eventstruct.seat_index === 0) {
    self thread function_f176e7d2(player);
  }
}

function function_dfba6306(params) {
  player = params.player;
  eventstruct = params.eventstruct;

  if(!isDefined(player)) {
    return;
  }

  if(eventstruct.seat_index === 0) {
    self thread function_f176e7d2(player);
  }
}