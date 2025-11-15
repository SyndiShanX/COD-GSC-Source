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
    self.var_3135.var_E87F = [];
    self.var_3135.var_D8BE = [];
    self.var_3135.var_BE5D = 0;
    self.var_C9D9 = level._btactions[self.behavior];
    self[[self.var_C9D9.var_71AD]]();
  }

  self.var_3135.instancedata = [];
  thread bt_eventlistener();
}

bt_eventlistener() {
  self endon("death");
  self endon("terminate_ai_threads");
  for(;;) {
    self waittill("ai_notify", var_00, var_01);
    scripts\asm\asm::asm_fireephemeralevent("ai_notify", var_00, var_01);
  }
}

bt_registertree(param_00, param_01) {
  level._btactions[param_00] = param_01;
  switch (param_00) {
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

bt_istreeregistered(param_00) {
  return isDefined(level._btactions) && isDefined(level._btactions[param_00]);
}

bt_getchildtaskid(param_00, param_01) {
  return self.var_C9D9.var_11591[param_00] + param_01;
}

func_0076(param_00) {
  return [
    [self.var_C9D9.var_1158E[param_00]]
  ]();
}

bt_terminateprevrunningaction(param_00, param_01, param_02, param_03) {
  var_04 = param_00.var_D8BE[param_02];
  if(!isDefined(var_04)) {
    return;
  }

  if(var_04 <= param_03) {
    return;
  }

  var_05 = spawnStruct();
  var_05.var_71D2 = param_01;
  var_05.taskid = param_02;
  for(;;) {
    self[[var_05.var_71D2]](param_00, var_05.taskid, var_05);
    if(!isDefined(var_05.var_71D2)) {
      break;
    }
  }
}

bt_negateresult(param_00) {
  if(param_00 == level.success) {
    return level.failure;
  } else if(param_00 == level.failure) {
    return level.success;
  }

  return param_00;
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

  if(isDefined(self.var_1198.var_7366)) {
    return self.var_1198.var_7366;
  }

  return "combat";
}