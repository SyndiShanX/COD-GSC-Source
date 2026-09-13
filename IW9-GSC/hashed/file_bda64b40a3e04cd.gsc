/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_bda64b40a3e04cd.gsc
***********************************************/

bindactionscripts() {
  if(isDefined(level._btactions["jailer_agent"])) {
    return;
  }
  bt = spawnStruct();
  bt.actionfn = [];
  bt.actionfn[0] = scripts\aitypes\juggernaut\behaviors::_id_C082B9EFBF242464;
  bt.actionfn[1] = scripts\aitypes\juggernaut\behaviors::_id_AAD2563E98827B23;
  bt.actionfn[2] = scripts\aitypes\juggernaut\behaviors::_id_E1138CCE8B2F28D4;
  bt.actionfn[3] = _id_0210CAA060373B6A::setupagent;
  bt.actionfn[4] = scripts\aitypes\juggernaut\behaviors::juggernaut_init;
  level._btactions["jailer_agent"] = bt;
}

registerbehaviortree() {
  bindactionscripts();
  _func_866EF0680E03FE86("jailer_agent");
}