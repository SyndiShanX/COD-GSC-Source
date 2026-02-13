/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\asm\zombie_common\stun.gsc
*************************************************/

play_stunned(var_0) {
  self._id_1C30._id_8A6C = 1;
  self._id_1C30.stunalias = var_0;
  _id_0009::_id_1CA1("start_stun");
}

stop_stunned() {
  self._id_1C30._id_8A6C = 0;
  self._id_1C30.stunalias = undefined;
}

_id_8A6C(var_0, var_1, var_2, var_3) {
  return istrue(self._id_1C30._id_8A6C);
}

choosestunanim(var_0, var_1, var_2) {
  return _id_0009::_id_1C7D(var_1, self._id_1C30.stunalias);
}