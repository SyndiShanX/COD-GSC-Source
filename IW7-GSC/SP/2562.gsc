/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2562.gsc
**************************************/

init() {
  if(isDefined(level._btactions)) {
    return;
  }
  level._btactions = [];
  level._id_119E = [];
  anim.failure = 0;
  anim.success = 1;
  anim.running = 2;
  anim.invalid = 3;
  anim.aborted = 3;
}

bt_init() {
  self.bt = spawnStruct();

  if(isDefined(self.behaviortreeasset)) {
    self btregistertreeinstance(self.behaviortreeasset);
  } else {
    self.bt._id_E87F = [];
    self.bt._id_D8BE = [];
    self.bt._id_BE5D = 0;
    self._id_C9D9 = level._btactions[self.behavior];
    self[[self._id_C9D9._id_71AD]]();
  }

  self.bt.instancedata = [];
  thread bt_eventlistener();
}

bt_eventlistener() {
  self endon("death");
  self endon("terminate_ai_threads");

  for(;;) {
    self waittill("ai_notify", var_0, var_1);
    scripts\asm\asm::asm_fireephemeralevent("ai_notify", var_0, var_1);
  }
}

bt_registertree(var_0, var_1) {
  level._btactions[var_0] = var_1;

  switch (var_0) {
    case "human/ally_combatant":
    case "human/enemy_combatant":
      _id_09FD::soldier();
      break;
    case "c6/base":
      _id_09FD::_id_3353();
      break;
    case "c12/c12":
      _id_09FD::_id_3508();
      break;
    case "seeker/seeker":
      _id_09FD::_id_F10A();
      break;
  }
}

bt_istreeregistered(var_0) {
  return isDefined(level._btactions) && isDefined(level._btactions[var_0]);
}

bt_getchildtaskid(var_0, var_1) {
  return self._id_C9D9._id_11591[var_0] + var_1;
}

_id_0076(var_0) {
  return [[self._id_C9D9._id_1158E[var_0]]]();
}

bt_terminateprevrunningaction(var_0, var_1, var_2, var_3) {
  var_4 = var_0._id_D8BE[var_2];

  if(!isDefined(var_4)) {
    return;
  }
  if(var_4 <= var_3) {
    return;
  }
  var_5 = spawnStruct();
  var_5._id_71D2 = var_1;
  var_5.taskid = var_2;

  for(;;) {
    self[[var_5._id_71D2]](var_0, var_5.taskid, var_5);

    if(!isDefined(var_5._id_71D2)) {
      break;
    }
  }
}

bt_negateresult(var_0) {
  if(var_0 == anim.success) {
    return anim.failure;
  } else if(var_0 == anim.failure) {
    return anim.success;
  }

  return var_0;
}

bt_tick() {
  if(isDefined(self.behaviortreeasset)) {
    self bttick();
  }
}

bt_getdemeanor() {
  if(isDefined(self.demeanoroverride)) {
    return self.demeanoroverride;
  }

  if(isDefined(self._blackboard._id_7366)) {
    return self._blackboard._id_7366;
  }

  return "combat";
}