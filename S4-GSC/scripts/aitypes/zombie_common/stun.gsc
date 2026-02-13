/**************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\aitypes\zombie_common\stun.gsc
**************************************************/

is_stunned() {
  if(!isDefined(self.stunendtimems)) {
    return 0;
  }

  return gettime() < self.stunendtimems;
}

stun(var_0, var_1) {
  if(_id_06FE::is_zm_elite()) {
    return;
  }
  var_2 = gettime() + var_0 * 1000;

  if(!isDefined(self.stunendtimems) || self.stunendtimems < var_2) {
    self.stunendtimems = var_2;
  }

  self.stunanimalias = scripts\cp\utility::_id_459B(var_1, "default");
}

_id_8A6C(var_0) {
  return scripts\engine\utility::ter_op(is_stunned(), anim._id_EACB, anim._id_58E3);
}

idleinit(var_0) {
  scripts\asm\zombie_common\stun::play_stunned(self.stunanimalias);
}

_id_7CA9(var_0) {
  if(self._id_1C30.stunalias != self.stunanimalias) {
    scripts\asm\zombie_common\stun::play_stunned(self.stunanimalias);
  }

  self _meth_8474();
  return anim._id_CA5F;
}

idleterminate(var_0) {
  scripts\asm\zombie_common\stun::stop_stunned();
}