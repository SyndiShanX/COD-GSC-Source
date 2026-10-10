/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_261b1fbee02cb0e8.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;
#namespace namespace_243a54064fe38311;

function autoexec main() {
  level.var_7bf42d565645a485 = 1;
  function_c0b3ddc9a6bdcc46("veh_jup_mil_cargo_truck", &function_c9c6d4d13a396d8d);
}

function private function_c9c6d4d13a396d8d() {
  if(!function_9697379150687859("veh_jup_mil_cargo_truck")) {
    return;
  }

  function_8497e7e46b5e397("veh_jup_mil_cargo_truck");
}