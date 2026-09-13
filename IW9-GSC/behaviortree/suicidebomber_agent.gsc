/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: behaviortree\suicidebomber_agent.gsc
************************************************/

bindactionscripts() {
  if(isDefined(level._btactions["suicidebomber_agent"])) {
    return;
  }
  bt = spawnStruct();
  bt.actionfn = [];
  bt.actionfn[0] = scripts\aitypes\suicidebomber\combat::bomber_init;
  bt.actionfn[1] = scripts\aitypes\suicidebomber\combat::bomber_updateeveryframe;
  bt.actionfn[2] = scripts\aitypes\suicidebomber\combat::bomber_shouldmove;
  bt.actionfn[3] = scripts\aitypes\suicidebomber\combat::bomber_move;
  bt.actionfn[4] = scripts\aitypes\suicidebomber\combat::bomber_moveinit;
  bt.actionfn[5] = scripts\aitypes\suicidebomber\combat::bomber_moveterminate;
  bt.actionfn[6] = scripts\aitypes\suicidebomber\combat::bomber_terminate;
  bt.actionfn[7] = _id_0210CAA060373B6A::setupagent;
  level._btactions["suicidebomber_agent"] = bt;
}

registerbehaviortree() {
  bindactionscripts();
  _func_866EF0680E03FE86("suicidebomber_agent");
}