/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2611.gsc
*************************************************/

_id_7EF5() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("body_armor", ::_id_F76E);
}

_id_F76E(var_0) {
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

  _id_07EA::_id_D5E2(self, 160, 0);
  thread _id_A120(var_0);
  return 1;
}

_id_A120(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("lightArmor_unset");

  if(isDefined(level._id_8DD3)) {
    level thread[[level._id_8DD3]](var_0);
  }
}