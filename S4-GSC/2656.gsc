/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2656.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("steel_bib_crate", ::_id_FED8);
}

_id_FED8(var_0) {
  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      return 0;
    }
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      return 0;
    }
  }

  if(self._id_EB09._id_88D4) {
    self waittill("super_use_finished");
  }

  var_1 = self._id_EB09._id_E76B._id_C189;
  _id_0A6C::_id_AFDE("super_steel_bib_crate");
  _id_0A6C::_id_AFD9();
  self waittill("super_use_finished");
  _id_0A6C::_id_AFDE(var_1);
  return 1;
}