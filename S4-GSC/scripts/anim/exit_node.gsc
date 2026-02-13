/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\anim\exit_node.gsc
*************************************************/

_id_6A1E() {
  var_0 = undefined;
  var_1 = 400;

  if(scripts\engine\utility::_id_0F78()) {
    var_1 = 1024;
  } else if(isDefined(self._id_7656)) {
    var_1 = 4096;
  }

  if(isDefined(self._id_02ED) && distancesquared(self.origin, self._id_02ED.origin) < var_1) {
    var_0 = self._id_02ED;
  } else if(isDefined(self._id_0347) && distancesquared(self.origin, self._id_0347.origin) < var_1) {
    var_0 = self._id_0347;
  }

  if(isDefined(self._id_7656) && !scripts\engine\utility::_id_0F78()) {
    if(isDefined(var_0) && _func_043F(self.angles[1] - var_0.angles[1]) > 30) {
      return undefined;
    }
  }

  return var_0;
}