/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2627.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("flamethrower", ::_id_F77F);
}

_id_F77F(var_0) {
  level endon("game_ended");
  self endon("disconnect");

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

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return 0;
  }

  return 1;
}

_id_EC3B() {}