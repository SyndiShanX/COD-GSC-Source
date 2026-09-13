/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_10fb43bd7474c909.gsc
***********************************************/

bindactionscripts() {
  if(isDefined(level._btactions["mummy"])) {
    return;
  }
  bt = spawnStruct();
  bt.actionfn = [];
  bt.actionfn[0] = _id_4F7C27D4FEF4BC09::_id_8225E9DBF1FD31A5;
  bt.actionfn[1] = _id_2C9A25CE78CD6B1F::_id_B9D0D115A6559D4A;
  bt.actionfn[2] = _id_2C9A25CE78CD6B1F::_id_C2722633BBCEFA50;
  bt.actionfn[3] = _id_2C9A25CE78CD6B1F::_id_999A3D8ADBC6CAAD;
  bt.actionfn[4] = _id_0210CAA060373B6A::setupagent;
  bt.actionfn[5] = _id_2C9A25CE78CD6B1F::_id_0C246708D1C79189;
  level._btactions["mummy"] = bt;
}

registerbehaviortree() {
  bindactionscripts();
  _func_866EF0680E03FE86("mummy");
}