/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_6c710aeafa0388dd.gsc
*************************************************/

#using scripts\cp_mp\vehicles\vehicle;
#namespace namespace_5416028698cc19b4;

function autoexec main() {
  level.shouldinitvehicles = 1;
  function_c0b3ddc9a6bdcc46("veh_jup_ahotel", &function_14b8fe3cf0847a29);
}

function private function_14b8fe3cf0847a29() {
  if(!function_9697379150687859("veh_jup_ahotel")) {
    return;
  }

  function_8497e7e46b5e397("veh_jup_ahotel");
}