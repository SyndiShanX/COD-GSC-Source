/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7d73cdeff61cc871.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;
#namespace namespace_de92d13bf94092d8;

function autoexec main() {
  level.var_7bf42d565645a485 = 1;
  function_c0b3ddc9a6bdcc46("veh_jup_polaris_utv", &function_9df60b8a7fd8c292);
}

function private function_9df60b8a7fd8c292() {
  if(!function_9697379150687859("veh_jup_polaris_utv")) {
    return;
  }

  callbacks = [];
  callbacks["spawn"] = &function_9cfc57059604bb3f;
  function_8497e7e46b5e397("veh_jup_polaris_utv", callbacks);
}

function private function_9cfc57059604bb3f(spawndata, faildata) {
  function_6991f5ef2ba63535(spawndata);
  vehicle = function_bba34cf920370ff4("veh_jup_polaris_utv", spawndata, faildata);
  return vehicle;
}

function private function_6991f5ef2ba63535(spawndata) {
  if(isDefined(spawndata.var_14cde247ac3313a4)) {
    switch (spawndata.var_14cde247ac3313a4) {
      case #"hash_22ce3b03c1e51a9c":
        spawndata.var_14cde247ac3313a4 = "tan";
        break;
      case #"hash_a1e9b77432f55b0e":
        spawndata.var_14cde247ac3313a4 = "green";
        break;
    }
  }
}