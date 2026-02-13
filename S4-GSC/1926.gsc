/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1926.gsc
*************************************************/

_id_8103() {
  scripts\engine\utility::_id_3F1B("fastrope_anim", ::_id_59BF);
  scripts\engine\utility::_id_3F1B("vehicle_door_anim", ::_id_4DC2);
  scripts\common\vehicle::_id_8103();
}

_id_59BF(var_0, var_1, var_2) {
  var_0 dontinterpolate();
  var_0 _meth_82CA();
  var_0 _meth_853F(_func_00C1(var_1), var_0.origin, var_0.angles, var_2);
}

_id_4DC2(var_0, var_1) {
  if(isDefined(var_0)) {
    var_0 _meth_8620(var_1, 0);
  }
}

_id_102EC() {}