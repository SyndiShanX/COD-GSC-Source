/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3c24a56641a03789.gsc
***********************************************/

init() {
  if(!getdvarint("dvar_8BFDC77E20414F2A", 0)) {
    return;
  }
  thread _id_38317B48D412B1D5();
}

_id_38317B48D412B1D5() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  _id_623FDB51B75D53EB = getentitylessscriptablearray("scriptablecaralarm", "script_noteworthy");

  if(_id_623FDB51B75D53EB.size <= 0) {
    return;
  }
  level waittill("prematch_fade_done");

  foreach(_id_9E85FD38C09D58DE in _id_623FDB51B75D53EB)
  _id_9E85FD38C09D58DE setscriptablepartstate("base", "alive");
}