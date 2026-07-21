/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitypes\bt_util.gsc
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

bt_terminateandreplace(var_0) {
  self btterminatetreeinstance();

  if(isDefined(var_0)) {
    self.behaviortreeasset = var_0;
    self btregistertreeinstance(self.behaviortreeasset);
  }
}

bt_getfunction(var_0, var_1) {
  return level._btactions[var_0].actionfn[var_1];
}

bt_eventlistener() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B2F1150BDFFAE03B721F4963CFAA732994F4B3A14654D8");

  for(;;) {
    self waittill("_encstr_85D10ABF70D62EB2A1FBCF5E", var_0, var_1);
    scripts\asm\asm::asm_fireephemeralevent("_encstr_85D10ABF70D62EB2A1FBCF5E", var_0, var_1);
  }
}

bt_tick() {
  if(isDefined(self.behaviortreeasset))
    self bttick();
}

bt_getdemeanor() {
  if(isDefined(self.demeanoroverride))
    return self.demeanoroverride;

  return "_encstr_AA7C07466F9DA30713";
}