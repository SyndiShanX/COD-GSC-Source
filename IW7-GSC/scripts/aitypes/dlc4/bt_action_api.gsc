/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\dlc4\bt_action_api.gsc
**************************************************/

setupbtaction(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.fnbegin = var_1;
  var_4.fntick = var_2;
  var_4.fnend = var_3;
  if(!isDefined(self.actions)) {
    self.actions = [];
  }

  self.actions[var_0] = var_4;
}

setdesiredbtaction(var_0, var_1) {
  if(isDefined(var_1) && !isDefined(self.actions[var_1])) {
    return 0;
  }

  var_2 = getcurrentdesiredbtaction(var_0);
  self.desiredaction = var_1;
  if(isDefined(var_2) && var_2 != var_1) {
    self notify("newaction");
  }

  return 1;
}

getcurrentdesiredbtaction(var_0) {
  if(!isDefined(self.bt.instancedata[var_0])) {
    return undefined;
  }

  return self.bt.instancedata[var_0].currentaction;
}

doaction_begin(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0].currentaction = self.desiredaction;
  var_1 = self.actions[self.desiredaction].fnbegin;
  self.desiredaction = undefined;
  if(isDefined(var_1)) {
    [[var_1]](var_0);
  }
}

doaction_tick(var_0) {
  var_1 = getcurrentdesiredbtaction(var_0);
  var_2 = self.actions[var_1].fntick;
  if(isDefined(var_2)) {
    var_3 = [[var_2]](var_0);
    if(!isDefined(self.desiredaction)) {
      if(isDefined(var_3)) {
        return var_3;
      }

      return level.failure;
    }
  }

  if(isDefined(self.desiredaction)) {
    doaction_end(var_0);
    doaction_begin(var_0);
    return level.running;
  }

  return level.failure;
}

doaction_end(var_0) {
  var_1 = getcurrentdesiredbtaction(var_0);
  var_2 = self.actions[var_1].fnend;
  if(isDefined(var_2)) {
    [[var_2]](var_0);
  }

  scripts\aitypes\dlc4\bt_state_api::btstate_endstates(var_0);
  self.bt.instancedata[var_0] = undefined;
}