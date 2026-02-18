/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6b238dc371917fc1.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#namespace namespace_ef91ed26;

function private autoexec __init__system__() {
  system::register(#"hash_f64d155dd9c41bd", &preinit, undefined, undefined, #"player_vehicle");
}

function private preinit() {
  vehicle::add_main_callback("gaz66_wz", &function_f9bdbd82);
}

function private function_f9bdbd82() {
  callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_8a413afb);
  callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &function_f7158176);
  self.var_93dc9da9 = "veh_truck_wall_imp";
  self.var_4ca92b57 = 30;
  self.var_57371c71 = 60;
  self.var_84fed14b = 30;
  self.var_d6691161 = 150;
  self.var_5d662124 = 2;
}

function private function_8a413afb(params) {
  player = params.player;
  seatindex = params.eventstruct.seat_index;

  if(seatindex == 0) {
    playFXOnTag("vehicle/fx8_exhaust_truck_cargo_startup_os", self, "tag_fx_exhaust");

    if(isDefined(player)) {
      player playrumbleonentity("jet_rumble");
    }
  }
}

function private function_f7158176(params) {
  player = params.player;
  seatindex = params.eventstruct.seat_index;

  if(seatindex == 0) {
    playFXOnTag("vehicle/fx8_exhaust_truck_cargo_startup_os", self, "tag_fx_exhaust");

    if(isDefined(player)) {
      player playrumbleonentity("jet_rumble");
    }
  }
}