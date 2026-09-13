/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\quaked\script_struct_mp_iw9_overland_2016.gsc
*****************************************************************/

main() {
  scripts\cp_mp\vehicles\vehicle::_id_C0B3DDC9A6BDCC46("veh9_overland_2016", ::_id_7993E6A0EF6E50D9);
}

_id_7993E6A0EF6E50D9() {
  if(!scripts\cp_mp\vehicles\vehicle::_id_9697379150687859("veh9_overland_2016")) {
    return;
  }
  scripts\cp_mp\vehicles\vehicle::_id_08497E7E46B5E397("veh9_overland_2016");
}