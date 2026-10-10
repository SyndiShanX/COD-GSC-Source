/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\quaked\script_struct_mp_jup_jltv.gsc
***********************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;
#namespace namespace_fd9b98db526befab;

function autoexec main() {
  level.var_7bf42d565645a485 = 1;
  function_c0b3ddc9a6bdcc46("veh_jup_jltv", &function_d3890e30943d672c);
}

function private function_d3890e30943d672c() {
  if(!function_9697379150687859("veh_jup_jltv")) {
    return;
  }

  if(utility::iscp()) {
    registersharedfunc("veh_jup_jltv", "create", &function_770292fe92b71912);
  }

  function_8497e7e46b5e397("veh_jup_jltv");
}

function private function_770292fe92b71912(vehicle) {
  vehicle.vehicle_specific_onentervehicle = &function_f131c851f1c4e709;
  vehicle.vehicle_specific_onexitvehicle = &function_7b4a4367ee409795;
}

#using_animtree("mp_vehicles_always_loaded");

function private function_f131c851f1c4e709(vehicle, var_7558f98f3236963d, player, data) {
  if(istrue(vehicle.door_open)) {
    vehicle vehicleplayanim(%reb_com_veh8_techo_fl_door_close);
    vehicle.door_open = undefined;
  }

  if(istrue(level.var_d39df167f3a996b0)) {
    vehicle setscriptablepartstate("lights", "on");
  }

  if(isDefined(vehicle.var_f24cc3beef01650c)) {
    vehicle.var_1ab6b61153087915 = vehicle.var_f24cc3beef01650c;
  }
}

function private function_7b4a4367ee409795(vehicle, var_7558f98f3236963d, player, data) {
  if(!istrue(data.playerdisconnect)) {
    player.isdrivingvehicle = undefined;
  }

  vehicle.var_1ab6b61153087915 = undefined;
}