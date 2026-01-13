/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2562.gsc
************************/

init() {
  if(isDefined(level._btactions)) {
    return;
  }

  level._btactions = [];
  level.var_119E = [];
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
    self.bt.var_E87F = [];
    self.bt.var_D8BE = [];
    self.bt.var_BE5D = 0;
    self.var_C9D9 = level._btactions[self.behavior];
    self[[self.var_C9D9.var_71AD]]();
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
    case "human\ally_combatant":
    case "human\enemy_combatant":
      lib_09FD::soldier();
      break;

    case "c6\base":
      lib_09FD::func_3353();
      break;

    case "c12\c12":
      lib_09FD::func_3508();
      break;

    case "seeker\seeker":
      lib_09FD::func_F10A();
      break;
  }
}

bt_istreeregistered(var_0) {
  return isDefined(level._btactions) && isDefined(level._btactions[var_0]);
}

bt_getchildtaskid(var_0, var_1) {
  return self.var_C9D9.var_11591[var_0] + var_1;
}

func_0076(var_0) {
  return [[self.var_C9D9.var_1158E[var_0]]]();
}

bt_terminateprevrunningaction(var_0, var_1, var_2, var_3) {
  var_4 = var_0.var_D8BE[var_2];
  if(!isDefined(var_4)) {
    return;
  }

  if(var_4 <= var_3) {
    return;
  }

  var_5 = spawnStruct();
  var_5.var_71D2 = var_1;
  var_5.taskid = var_2;
  for(;;) {
    self[[var_5.var_71D2]](var_0, var_5.taskid, var_5);
    if(!isDefined(var_5.var_71D2)) {
      break;
    }
  }
}

bt_negateresult(var_0) {
  if(var_0 == level.success) {
    return level.failure;
  } else if(var_0 == level.failure) {
    return level.success;
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

  if(isDefined(self._blackboard.var_7366)) {
    return self._blackboard.var_7366;
  }

  return "combat";
}