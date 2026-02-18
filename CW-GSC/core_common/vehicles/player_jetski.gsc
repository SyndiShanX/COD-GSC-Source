/**************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\player_jetski.gsc
**************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\player_vehicle;
#namespace player_jetski;

function private autoexec __init__system__() {
  system::register(#"player_jetski", &preinit, undefined, undefined, #"player_vehicle");
}

function private preinit() {
  vehicle::add_main_callback("player_jetski", &function_966d6664);
  setDvar(#"phys_buoyancy", 1);
}

function private function_966d6664() {
  self.var_84fed14b = 40;
  self.var_4ca92b57 = 20;
  self.var_d6691161 = 175;
  self.var_5d662124 = 2;
  callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_4fc75987);
  self player_vehicle::function_cc30c4bb(#"hash_22c22a196fd2cc77", 6);
}

function private function_4fc75987(params) {
  self thread player_vehicle::function_e8e41bbb();
}