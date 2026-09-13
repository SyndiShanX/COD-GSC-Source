/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\quaked\script_struct_mp_iw9_cargo_truck.gsc
***************************************************************/

main() {
  scripts\cp_mp\vehicles\vehicle::_id_C0B3DDC9A6BDCC46("veh9_mil_cargo_truck", ::_id_07D644F73E8A967D);
}

_id_07D644F73E8A967D() {
  if(!scripts\cp_mp\vehicles\vehicle::_id_9697379150687859("veh9_mil_cargo_truck")) {
    return;
  }
  scripts\cp_mp\vehicles\vehicle::_id_08497E7E46B5E397("veh9_mil_cargo_truck");
}