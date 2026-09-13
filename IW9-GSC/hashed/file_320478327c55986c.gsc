/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_320478327c55986c.gsc
***********************************************/

main() {
  scripts\cp_mp\vehicles\vehicle::_id_C0B3DDC9A6BDCC46("veh9_civ_lnd_scooter_eu", ::_id_9BA16C90D67C5692);
}

_id_9BA16C90D67C5692() {
  if(!scripts\cp_mp\vehicles\vehicle::_id_9697379150687859("veh9_civ_lnd_scooter_eu")) {
    return;
  }
  if(scripts\common\utility::iscp()) {
    return;
  }
  scripts\cp_mp\vehicles\vehicle::_id_08497E7E46B5E397("veh9_civ_lnd_scooter_eu");
}