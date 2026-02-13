/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1915.gsc
*************************************************/

_id_5181() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp", "getPlayerEMPImmune", ::_id_6C4B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp", "setPlayerEMPImmune", ::_id_D660);
}

_id_6C4B() {
  return isDefined(self._id_51B9);
}

_id_D660(var_0) {
  if(!isDefined(self._id_51B9)) {
    self._id_51B9 = 0;
  }

  if(var_0) {
    self._id_51B9--;

    if(self._id_51B9 == 0) {
      self._id_51B9 = undefined;
    }
  } else
    self._id_51B9++;
}