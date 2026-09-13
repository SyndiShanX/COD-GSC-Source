/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: behaviortree\juggernaut_agent.gsc
***********************************************/

bindactionscripts() {
  if(isDefined(level._btactions["juggernaut_agent"])) {
    return;
  }
  bt = spawnStruct();
  bt.actionfn = [];
  bt.actionfn[0] = scripts\aitypes\combat::_id_F7D7F5A416BA048F;
  bt.actionfn[1] = scripts\aitypes\combat::_id_A38AD5564FCAFC54;
  bt.actionfn[2] = scripts\aitypes\stealth::stealth_initfriendly;
  bt.actionfn[3] = scripts\aitypes\stealth::stealth_initneutral;
  bt.actionfn[4] = scripts\aitypes\stealth::_id_E75FF8B7F46A7761;
  bt.actionfn[5] = scripts\aitypes\stealth::_id_2AE6E5FA8AD77612;
  bt.actionfn[6] = scripts\aitypes\stealth::_id_2EEA6ED25456E38D;
  bt.actionfn[7] = scripts\aitypes\stealth::_id_4C41840DA22ED656;
  bt.actionfn[8] = scripts\aitypes\combat::ifshoulddosmartobject;
  bt.actionfn[9] = scripts\aitypes\combat::dosmartobject;
  bt.actionfn[10] = scripts\aitypes\combat::dosmartobject_init;
  bt.actionfn[11] = scripts\aitypes\combat::dosmartobjectterminate;
  bt.actionfn[12] = scripts\aitypes\stealth::hunt_active_terminate;
  bt.actionfn[13] = scripts\aitypes\stealth::idle_init;
  bt.actionfn[14] = scripts\aitypes\stealth::idle_terminate;
  bt.actionfn[15] = _id_0210CAA060373B6A::setupagent;
  bt.actionfn[16] = scripts\aitypes\juggernaut\behaviors::juggernaut_init;
  bt.actionfn[17] = scripts\aitypes\melee::initmeleefunctions;
  level._btactions["juggernaut_agent"] = bt;
}

registerbehaviortree() {
  bindactionscripts();
  _func_866EF0680E03FE86("juggernaut_agent");
}