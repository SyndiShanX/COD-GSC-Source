/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1963.gsc
*************************************************/

main() {
  if(!isDefined(level._id_1802)) {
    level._id_1802 = [];
  }

  var_0 = getarraykeys(level._id_1802);

  foreach(var_2 in var_0) {
    var_3 = getarraykeys(level._id_1802[var_2]);

    foreach(var_5 in var_3) {
      _func_01AF(level._id_1802[var_2][var_5]);
    }
  }

  waittillframeend;
  level._id_7ED0 = [];
  var_8 = getEntArray("animated_model", "targetname");
  scripts\engine\utility::_id_1BE3(var_8, ::_id_187F, 0.05);
  level._id_7ED0 = undefined;
}

_id_187F() {
  if(isDefined(self._id_1883)) {
    var_0 = self._id_1883;
  } else {
    var_1 = getarraykeys(level._id_1802[self.model]);
    var_2 = var_1[randomint(var_1.size)];
    var_0 = level._id_1802[self.model][var_2];
  }

  self _meth_82CB(var_0);
  self _meth_845D();
}