/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_44941c2622ee1f1.gsc
***********************************************/

bindactionscripts() {
  if(isDefined(level._btactions["rusher"])) {
    return;
  }
  bt = spawnStruct();
  bt.actionfn = [];
  bt.actionfn[0] = _id_4F7C27D4FEF4BC09::_id_8225E9DBF1FD31A5;
  bt.actionfn[1] = scripts\aitypes\combat::_id_F7D7F5A416BA048F;
  bt.actionfn[2] = scripts\aitypes\combat::_id_A38AD5564FCAFC54;
  bt.actionfn[3] = scripts\aitypes\stealth::stealth_initfriendly;
  bt.actionfn[4] = scripts\aitypes\stealth::stealth_initneutral;
  bt.actionfn[5] = scripts\aitypes\stealth::_id_E75FF8B7F46A7761;
  bt.actionfn[6] = scripts\aitypes\stealth::_id_2AE6E5FA8AD77612;
  bt.actionfn[7] = scripts\aitypes\stealth::_id_2EEA6ED25456E38D;
  bt.actionfn[8] = scripts\aitypes\stealth::_id_4C41840DA22ED656;
  bt.actionfn[9] = scripts\aitypes\combat::ifshoulddosmartobject;
  bt.actionfn[10] = scripts\aitypes\combat::dosmartobject;
  bt.actionfn[11] = scripts\aitypes\combat::dosmartobject_init;
  bt.actionfn[12] = scripts\aitypes\combat::dosmartobjectterminate;
  bt.actionfn[13] = scripts\aitypes\stealth::hunt_active_terminate;
  bt.actionfn[14] = scripts\aitypes\stealth::idle_init;
  bt.actionfn[15] = scripts\aitypes\stealth::idle_terminate;
  bt.actionfn[16] = _id_0210CAA060373B6A::setupagent;
  bt.actionfn[17] = _id_4F7C27D4FEF4BC09::_id_563C8928520A0086;
  level._btactions["rusher"] = bt;
}

registerbehaviortree() {
  bindactionscripts();
  _func_866EF0680E03FE86("rusher");
}