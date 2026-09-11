/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: behaviortree\suicidebomber_agent.gsc
************************************************/

function bindactionscripts() {
  if(isDefined(level._btactions["suicidebomber_agent"])) {
    return;
  }

  var_0 = spawnStruct();
  var_0.actionfn = [];
  var_0.actionfn[0] = &scripts\aitypes\suicidebomber\combat::bomber_init;
  var_0.actionfn[1] = &scripts\aitypes\suicidebomber\combat::bomber_updateeveryframe;
  var_0.actionfn[2] = &scripts\aitypes\suicidebomber\combat::bomber_shouldmove;
  var_0.actionfn[3] = &scripts\aitypes\suicidebomber\combat::bomber_move;
  var_0.actionfn[4] = &scripts\aitypes\suicidebomber\combat::bomber_moveinit;
  var_0.actionfn[5] = &scripts\aitypes\suicidebomber\combat::bomber_moveterminate;
  var_0.actionfn[6] = &scripts\aitypes\suicidebomber\combat::bomber_terminate;
  var_0.actionfn[7] = &scripts\aitypes\soldier_agent\setup::setupagent;
  level._btactions["suicidebomber_agent"] = var_0;
}

function registerbehaviortree() {
  bindactionscripts();
  btregistertree("suicidebomber_agent");
}