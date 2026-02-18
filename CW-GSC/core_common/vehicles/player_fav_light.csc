/*****************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\player_fav_light.csc
*****************************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#namespace player_fav_light;

function private autoexec __init__system__() {
  system::register(#"player_fav_light", &preinit, undefined, undefined, #"player_vehicle");
}

function private preinit(localclientnum) {
  vehicle::add_vehicletype_callback("player_fav_light", &function_6e6e0d52);
}

function private function_6e6e0d52(localclientnum) {}