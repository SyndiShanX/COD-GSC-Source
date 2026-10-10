/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6388715b7706a618.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;
#namespace namespace_25855beb6219459;

function main() {
  function_c0b3ddc9a6bdcc46("veh9_civ_lnd_motorcycle_cruiser_2008", &function_b103169a6a0515ba);
}

function private function_b103169a6a0515ba() {
  if(!function_9697379150687859("veh9_civ_lnd_motorcycle_cruiser_2008")) {
    return;
  }

  if(iscp()) {
    return;
  }

  function_8497e7e46b5e397("veh9_civ_lnd_motorcycle_cruiser_2008");
}