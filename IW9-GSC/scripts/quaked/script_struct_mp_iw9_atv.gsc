/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\quaked\script_struct_mp_iw9_atv.gsc
*******************************************************/

main() {
  scripts\cp_mp\vehicles\vehicle::_id_C0B3DDC9A6BDCC46("atv", ::atv_init);
}

atv_init() {
  if(!scripts\cp_mp\vehicles\vehicle::_id_9697379150687859("atv")) {
    return;
  }
  scripts\cp_mp\vehicles\vehicle::_id_08497E7E46B5E397("atv");
}