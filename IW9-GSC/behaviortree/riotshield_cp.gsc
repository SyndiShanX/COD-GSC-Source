/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: behaviortree\riotshield_cp.gsc
***********************************************/

bindactionscripts() {
  if(isDefined(level._btactions["riotshield_cp"])) {
    return;
  }
  bt = spawnStruct();
  bt.actionfn = [];
  bt.actionfn[0] = scripts\aitypes\riotshield\riotshield::_id_97DBC630C790BFB3;
  bt.actionfn[1] = scripts\aitypes\riotshield\riotshield::_id_A43626A85E6614F0;
  bt.actionfn[2] = _id_0210CAA060373B6A::setupagent;
  bt.actionfn[3] = scripts\aitypes\melee::initmeleefunctions;
  bt.actionfn[4] = scripts\aitypes\riotshield\riotshield::riotshield_init_cp;
  level._btactions["riotshield_cp"] = bt;
}

registerbehaviortree() {
  bindactionscripts();
  _func_866EF0680E03FE86("riotshield_cp");
}