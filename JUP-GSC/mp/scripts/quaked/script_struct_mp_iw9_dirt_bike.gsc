/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\quaked\script_struct_mp_iw9_dirt_bike.gsc
*************************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;
#namespace namespace_1fce23c232dc778e;

function main() {
  function_c0b3ddc9a6bdcc46("veh9_civ_lnd_dirt_bike", &function_22e02886ba8d83bf);
}

function private function_22e02886ba8d83bf() {
  if(!function_9697379150687859("veh9_civ_lnd_dirt_bike")) {
    return;
  }

  if(iscp()) {
    return;
  }

  function_8497e7e46b5e397("veh9_civ_lnd_dirt_bike");

  if(getdvarint(@ "hash_12368a7f8188c51e", 1) == 1) {
    data = function_29b4292c92443328("veh9_civ_lnd_dirt_bike");

    foreach(tag, damagedata in data.damage.damageableparts) {
      if(isDefined(damagedata.wheelref)) {
        data.damage.damageableparts[tag] = undefined;
        data.damage.var_9d70f02394c136da[tag] = undefined;
        data.damage.var_ccfde1208ef2964b[tag] = undefined;
      }
    }
  }
}