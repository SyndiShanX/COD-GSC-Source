/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6388715b7706a618.gsc
***********************************************/

main() {
  scripts\cp_mp\vehicles\vehicle::_id_C0B3DDC9A6BDCC46("veh9_civ_lnd_motorcycle_cruiser_2008", ::_id_B103169A6A0515BA);
}

_id_B103169A6A0515BA() {
  if(!scripts\cp_mp\vehicles\vehicle::_id_9697379150687859("veh9_civ_lnd_motorcycle_cruiser_2008")) {
    return;
  }
  if(scripts\common\utility::iscp()) {
    return;
  }
  scripts\cp_mp\vehicles\vehicle::_id_08497E7E46B5E397("veh9_civ_lnd_motorcycle_cruiser_2008");
}