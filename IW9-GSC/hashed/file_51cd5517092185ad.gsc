/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_51cd5517092185ad.gsc
***********************************************/

bindactionscripts() {
  if(isDefined(level._btactions["civilian_livingworld"])) {
    return;
  }
  bt = spawnStruct();
  bt.actionfn = [];
  bt.actionfn[0] = scripts\aitypes\human\civilian_logic::_id_FA485278009F93A7;
  bt.actionfn[1] = scripts\aitypes\human\civilian_logic::_id_216B6A27F343C39B;
  level._btactions["civilian_livingworld"] = bt;
}

registerbehaviortree() {
  bindactionscripts();
  _func_866EF0680E03FE86("civilian_livingworld");
}