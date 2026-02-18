/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\player_pbr.csc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\player_vehicle;
#namespace player_pbr;

function private autoexec __init__system__() {
  system::register(#"player_pbr", &preinit, undefined, undefined, #"player_vehicle");
}

function private preinit(localclientnum) {
  vehicle::add_vehicletype_callback("player_pbr", &function_cc0af45d);
  setDvar(#"phys_buoyancy", 1);
}

function private function_cc0af45d(localclientnum) {
  self.var_917cf8e3 = &player_vehicle::function_b0d51c9;
  self.var_1a6ef836 = 0;
}