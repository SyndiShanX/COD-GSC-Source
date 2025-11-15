/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\dlc4\bt_action_api.gsc
**************************************************/

setupbtaction(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  var_04.fnbegin = param_01;
  var_04.fntick = param_02;
  var_04.fnend = param_03;
  if(!isDefined(self.actions)) {
    self.actions = [];
  }

  self.actions[param_00] = var_04;
}

setdesiredbtaction(param_00, param_01) {
  if(isDefined(param_01) && !isDefined(self.actions[param_01])) {
    return 0;
  }

  var_02 = getcurrentdesiredbtaction(param_00);
  self.desiredaction = param_01;
  if(isDefined(var_02) && var_02 != param_01) {
    self notify("newaction");
  }

  return 1;
}

getcurrentdesiredbtaction(param_00) {
  if(!isDefined(self.var_3135.instancedata[param_00])) {
    return undefined;
  }

  return self.var_3135.instancedata[param_00].currentaction;
}

doaction_begin(param_00) {
  self.var_3135.instancedata[param_00] = spawnStruct();
  self.var_3135.instancedata[param_00].currentaction = self.desiredaction;
  var_01 = self.actions[self.desiredaction].fnbegin;
  self.desiredaction = undefined;
  if(isDefined(var_01)) {
    [[var_01]](param_00);
  }
}

doaction_tick(param_00) {
  var_01 = getcurrentdesiredbtaction(param_00);
  var_02 = self.actions[var_01].fntick;
  if(isDefined(var_02)) {
    var_03 = [[var_02]](param_00);
    if(!isDefined(self.desiredaction)) {
      if(isDefined(var_03)) {
        return var_03;
      }

      return level.failure;
    }
  }

  if(isDefined(self.desiredaction)) {
    doaction_end(param_00);
    doaction_begin(param_00);
    return level.running;
  }

  return level.failure;
}

doaction_end(param_00) {
  var_01 = getcurrentdesiredbtaction(param_00);
  var_02 = self.actions[var_01].fnend;
  if(isDefined(var_02)) {
    [[var_02]](param_00);
  }

  scripts\aitypes\dlc4\bt_state_api::btstate_endstates(param_00);
  self.var_3135.instancedata[param_00] = undefined;
}