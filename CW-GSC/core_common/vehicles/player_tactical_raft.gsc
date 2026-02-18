/*********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\player_tactical_raft.gsc
*********************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\player_vehicle;
#namespace player_tactical_raft;

function private autoexec __init__system__() {
  system::register(#"player_tactical_raft", &preinit, undefined, undefined, #"player_vehicle");
}

function private preinit() {
  vehicle::add_main_callback("tactical_raft_wz", &function_9941dc42);
  setDvar(#"phys_buoyancy", 1);
}

function private function_9941dc42() {
  self setmovingplatformenabled(1, 0);
  self.var_93dc9da9 = "veh_zodiac_wall_imp";
  callback::function_d8abfc3d(#"hash_80ab24b716412e1", &function_a41bd019);
  callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_a5838bb7);
  callback::function_d8abfc3d(#"hash_55f29e0747697500", &function_6d4de854);
}

function private function_6d4de854(params) {}

function private function_a5838bb7(params) {
  self thread player_vehicle::function_e8e41bbb();
}

function private function_a41bd019(params) {}