/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_699b0bf58f54f2ea.gsc
***********************************************/

bindactionscripts() {
  if(isDefined(level._btactions["jailer_baton"])) {
    return;
  }
  bt = spawnStruct();
  bt.actionfn = [];
  bt.actionfn[0] = _id_0BA28D36717D7972::_id_3729E5E27DA73905;
  bt.actionfn[1] = _id_0BA28D36717D7972::_id_B90B44351A9D3B87;
  bt.actionfn[2] = _id_0BA28D36717D7972::_id_60CE9F4482409A3B;
  bt.actionfn[3] = _id_0210CAA060373B6A::setupagent;
  bt.actionfn[4] = _id_0BA28D36717D7972::_id_827E9869096F452F;
  level._btactions["jailer_baton"] = bt;
}

registerbehaviortree() {
  bindactionscripts();
  _func_866EF0680E03FE86("jailer_baton");
}