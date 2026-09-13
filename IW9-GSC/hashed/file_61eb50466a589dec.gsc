/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_61eb50466a589dec.gsc
***********************************************/

main() {
  _id_15047AF555F1F9A0::_id_94461E6FD9196C6A(::_id_230B60EF0852DCB8);

  while(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("aggregator", "registerOnPlayerSpawnCallback"))
    waitframe();

  [[scripts\cp_mp\utility\script_utility::getsharedfunc("aggregator", "registerOnPlayerSpawnCallback")]](::_id_767EFE0110BFA73A);
}

_id_767EFE0110BFA73A() {
  thread _id_15047AF555F1F9A0::_id_A9C6F7587066CE13();
}

_id_230B60EF0852DCB8(_id_78264A131B0E70AC) {
  self playsoundtoplayer(_id_78264A131B0E70AC, self);
}