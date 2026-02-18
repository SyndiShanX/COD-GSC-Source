/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\recon_car.csc
***********************************************/

#using script_18b9d0e77614c97;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\killstreak_detect;
#using scripts\killstreaks\killstreak_vehicle;
#namespace recon_car;

function private autoexec __init__system__() {
  system::register(#"recon_car", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  killstreak_detect::init_shared();
  bundle = getscriptbundle("killstreak_recon_car");
  level.var_af161ca6 = bundle;
  killstreak_vehicle::init_killstreak(bundle);
  vehicle::add_vehicletype_callback(bundle.ksvehicle, &spawned);
}

function spawned(localclientnum) {
  self.killstreakbundle = level.var_af161ca6;
}

function private function_3665db4d() {
  function_334b8df9(level.var_af161ca6.var_1c30ba81, -1);
}

function private function_b8d95025() {
  function_58250a30(level.var_af161ca6.var_1c30ba81);
}