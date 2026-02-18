/*********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\player_tactical_raft.csc
*********************************************************/

#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\player_vehicle;
#namespace player_tactical_raft;

function private autoexec __init__system__() {
  system::register(#"player_tactical_raft", &preinit, undefined, undefined, #"player_vehicle");
}

function private preinit(localclientnum) {
  vehicle::add_vehicletype_callback("tactical_raft_wz", &function_9941dc42);
  setDvar(#"phys_buoyancy", 1);
}

function private function_9941dc42(localclientnum) {
  self.var_917cf8e3 = &player_vehicle::function_b0d51c9;
  self.var_1a6ef836 = 0;
}