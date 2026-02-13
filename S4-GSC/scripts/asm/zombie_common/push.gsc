/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\asm\zombie_common\push.gsc
*************************************************/

play_knockdown(var_0) {
  self._id_0B67.knockdowndirection = var_0;
  _id_0009::_id_1CA1("start_knockdown");
}

chooseknockdownanim(var_0, var_1, var_2) {
  if(isDefined(self._id_0B67.knockdowndirection)) {
    var_3 = _id_0009::_id_1C7E(var_1, self._id_0B67.knockdowndirection);

    if(isDefined(var_3)) {
      return var_3;
    }
  }

  return _id_0009::_id_1C6C(var_0, var_1);
}

knockdownterminate(var_0, var_1, var_2) {
  _id_0009::_id_1C52("knockdown", "end");
  self._id_0B67.knockdowndirection = undefined;
}