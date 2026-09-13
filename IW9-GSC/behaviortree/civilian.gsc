/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: behaviortree\civilian.gsc
***********************************************/

bindactionscripts() {
  if(isDefined(level._btactions["civilian"])) {
    return;
  }
  bt = spawnStruct();
  bt.actionfn = [];
  bt.actionfn[0] = scripts\aitypes\stealth::stealth_initneutral;
  bt.actionfn[1] = scripts\aitypes\human\civilian_logic::initcivilian;
  level._btactions["civilian"] = bt;
}

registerbehaviortree() {
  bindactionscripts();
  _func_866EF0680E03FE86("civilian");
}