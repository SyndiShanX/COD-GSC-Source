/****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\aitypes\zombie_common\freeze.gsc
****************************************************/

_id_8873(var_0) {
  return scripts\engine\utility::ter_op(istrue(self._id_8873), anim._id_EACB, anim._id_58E3);
}

idleinit(var_0) {
  _id_0908::_id_E90A();

  if(isDefined(self._id_0192)) {
    self _meth_8858(self._id_0192 _meth_8176(), undefined, 0);
    self._id_0212 = "disable";
  }

  self._id_0229 = 1;
  self _meth_8079();
}

_id_7CA9(var_0) {
  self _meth_8251("face current");
  return anim._id_CA5F;
}

idleterminate(var_0) {
  self _meth_8474();
  self _meth_84BC(0, self.origin);

  if(istrue(self._id_0B67._id_03CE)) {
    _id_06BD::_id_23B5();
  }

  self._id_0212 = undefined;
  self._id_0229 = 0;
  self _meth_86DE();
  self _meth_85FC();
  self _meth_8251("face enemy or motion");
}