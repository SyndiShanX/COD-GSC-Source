/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\player_atv.gsc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#namespace player_atv;

function private autoexec __init__system__() {
  system::register(#"player_atv", &preinit, undefined, undefined, #"player_vehicle");
}

function private preinit() {
  vehicle::add_main_callback("player_atv", &function_500291c4);
}

function private function_500291c4() {
  self.var_93dc9da9 = "veh_atv_wall_imp";
  self.var_d6691161 = 200;
  self.var_5002d77c = 0.6;
}