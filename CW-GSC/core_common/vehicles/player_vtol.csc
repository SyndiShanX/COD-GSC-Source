/************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\player_vtol.csc
************************************************/

#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#namespace player_vtol;

function private autoexec __init__system__() {
  system::register(#"player_vtol", &preinit, undefined, undefined, #"player_vehicle");
}

function private preinit(localclientnum) {
  vehicle::add_vehicletype_callback("player_vtol", &function_1b39ded0);
}

function private function_1b39ded0(localclientnum) {}