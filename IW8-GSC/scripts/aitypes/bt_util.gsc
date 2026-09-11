/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\bt_util.gsc
***********************************************/

function init() {
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

function bt_init() {
  self.bt = spawnStruct();

  if(isDefined(self.behaviortreeasset)) {
    self btregistertreeinstance(self.behaviortreeasset);
  }

  self.bt.instancedata = [];
  thread bt_eventlistener();
}

function bt_terminateandreplace(var0) {
  self btterminatetreeinstance();

  if(isDefined(var0)) {
    self.behaviortreeasset = var0;
    self btregistertreeinstance(self.behaviortreeasset);
    return;
  }
}

function bt_getfunction(var0, var1) {
  return level._btactions[var0].actionfn[var1];
}

function bt_eventlistener() {
  self endon("death");
  self endon("terminate_ai_threads");

  for(;;) {
    self waittill("ai_notify", var0, var1);
    scripts\asm\asm::asm_fireephemeralevent("ai_notify", var0, var1);
  }
}

function bt_tick() {
  if(isDefined(self.behaviortreeasset)) {
    self bttick();
    return;
  }
}

function bt_getdemeanor() {
  if(isDefined(self.demeanoroverride)) {
    return self.demeanoroverride;
  }

  return "combat";
}