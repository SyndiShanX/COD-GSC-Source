/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\bt_util.gsc
***********************************************/

init() {
  if(isDefined(level._btactions)) {
    return;
  }
  level._btactions = [];
  anim.failure = 0;
  anim.success = 1;
  anim.running = 2;
  anim.invalid = 3;
  anim.aborted = 3;
}

bt_init() {
  self.bt = spawnStruct();

  if(isDefined(self.behaviortreeasset))
    self btregistertreeinstance(self.behaviortreeasset);

  self.bt.instancedata = [];
  thread bt_eventlistener();
}

bt_terminateandreplace(_id_99252870276D5B3E) {
  self btterminatetreeinstance();

  if(isDefined(_id_99252870276D5B3E)) {
    self.behaviortreeasset = _id_99252870276D5B3E;
    self btregistertreeinstance(self.behaviortreeasset);
  }
}

bt_getfunction(_id_F1E97E25D634A2EB, _id_D375EB81BF6535AE) {
  return level._btactions[_id_F1E97E25D634A2EB].actionfn[_id_D375EB81BF6535AE];
}

bt_eventlistener() {
  self endon("death");
  self endon("terminate_ai_threads");

  for(;;) {
    self waittill("ai_notify", e, params);
    scripts\asm\asm::asm_fireephemeralevent("ai_notify", e, params);
  }
}