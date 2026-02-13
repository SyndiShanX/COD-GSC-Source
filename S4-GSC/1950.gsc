/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1950.gsc
*************************************************/

_id_7F83() {
  if(!scripts\engine\utility::_id_0FE2("init_flags", ::_id_7F83)) {
    return;
  }
  level._id_5C00 = [];
  level._id_5C45 = [];
  level._id_629E = 0;
  level._id_5C1F = spawnStruct();
  level._id_5C1F _id_1D10();
}

_id_1D10() {
  self._id_F94F = "generic" + level._id_629E;
  level._id_629E++;
}