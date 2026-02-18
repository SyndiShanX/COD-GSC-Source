/*************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\player_hemtt.gsc
*************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#namespace player_hemtt;

function private autoexec __init__system__() {
  system::register(#"hash_5b215c4eff8f5759", &preinit, undefined, undefined, #"player_vehicle");
}

function private preinit() {
  vehicle::add_main_callback("hemtt_wz", &function_7cb966e4);
}

function private function_7cb966e4() {
  callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_3fbda54b);
  callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &function_4a8e844a);
  self.var_93dc9da9 = "veh_truck_wall_imp";
  self.var_4ca92b57 = 30;
  self.var_57371c71 = 60;
  self.var_84fed14b = 30;
  self.var_d6691161 = 150;
  self.var_5d662124 = 2;
}

function private function_3fbda54b(params) {
  player = params.player;
  seatindex = params.eventstruct.seat_index;

  if(seatindex == 0) {
    playFXOnTag("vehicle/fx8_exhaust_truck_cargo_startup_os", self, "tag_fx_exhaust");

    if(isDefined(player)) {
      player playrumbleonentity("jet_rumble");
    }
  }
}

function private function_4a8e844a(params) {
  player = params.player;
  seatindex = params.eventstruct.seat_index;

  if(seatindex == 0) {
    playFXOnTag("vehicle/fx8_exhaust_truck_cargo_startup_os", self, "tag_fx_exhaust");

    if(isDefined(player)) {
      player playrumbleonentity("jet_rumble");
    }
  }
}