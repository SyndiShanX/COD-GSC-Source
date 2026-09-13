/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\quaked\script_struct_mp_iw9_hummer.gsc
**********************************************************/

main() {
  scripts\cp_mp\vehicles\vehicle::_id_C0B3DDC9A6BDCC46("veh9_hummer", ::_id_454851D382CD4752);
}

_id_454851D382CD4752() {
  if(!scripts\cp_mp\vehicles\vehicle::_id_9697379150687859("veh9_hummer")) {
    return;
  }
  scripts\cp_mp\vehicles\vehicle::_id_08497E7E46B5E397("veh9_hummer");
}