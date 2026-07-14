/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\aitypes\bt_util.gsc
***************************************/

#namespace bt_util;

function init() {
  if(isDefined(level._btactions)) {
    return;
  }

  level._btactions = [];
  anim.failure = 0;
  anim.success = 1;
  anim.running = 2;
  anim.skip = 3;
  anim.invalid = 4;
}

function bt_init() {
  assert(!isDefined(self.bt));
  self.bt = spawnStruct();

  if(isDefined(self.behaviortreeasset)) {
    self btregistertreeinstance(self.behaviortreeasset);
  }

  self.bt.instancedata = [];
}

function bt_terminateandreplace(var_4132cc6dae810507) {
  self btterminatetreeinstance();

  if(isDefined(var_4132cc6dae810507)) {
    self.behaviortreeasset = var_4132cc6dae810507;
    self btregistertreeinstance(self.behaviortreeasset);
  }
}