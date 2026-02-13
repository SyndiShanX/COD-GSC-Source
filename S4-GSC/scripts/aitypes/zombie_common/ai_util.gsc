/*****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\aitypes\zombie_common\ai_util.gsc
*****************************************************/

init() {
  level._id_11056 = "axis";
}

_id_5A9A() {}

get_door_in_path() {
  var_0 = self _meth_841A();

  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = var_0 _id_0722::is_destroyed();
  return scripts\engine\utility::ter_op(!var_1, var_0, undefined);
}

set_scripted(var_0) {
  self._id_CF4A = var_0;
}

_id_8AAE(var_0) {
  return scripts\engine\utility::ter_op(istrue(self._id_86ED), anim._id_EACB, anim._id_58E3);
}

isarriving(var_0) {
  return scripts\engine\utility::ter_op(istrue(self._id_0063), anim._id_EACB, anim._id_58E3);
}

_id_3558(var_0) {
  if(!istrue(self._id_CF4A)) {
    return anim._id_58E3;
  }

  self _meth_84C0(0);
  return anim._id_CA5F;
}

haslegs(var_0) {
  return scripts\engine\utility::ter_op(istrue(self._id_4B40), anim._id_58E3, anim._id_EACB);
}