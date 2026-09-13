/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\battlechatter_wrapper.gsc
**************************************************/

evaluatemoveevent(_id_76AF5757C71B312C) {}

evaluatereloadevent() {}

_id_F56C2DE6DB70455F(_id_C5B28F88D9B3BFD7, enemy) {
  _id_35DE402EFC5ACFB3::_id_C0DA17570A24346C("spotted", [_id_C5B28F88D9B3BFD7, enemy]);
}

evaluateattackevent(type) {
  _id_35DE402EFC5ACFB3::_id_C0DA17570A24346C("attack", type);
}