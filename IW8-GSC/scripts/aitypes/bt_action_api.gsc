/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\bt_action_api.gsc
***********************************************/

function setupbtaction(var_0, var_1, var_2, var_3) {
  var_4 = scripts\aitypes\bt_state_api::btstate_setupstate(var_0, var_1, var_2, var_3);
  self._btactions[var_0] = var_4;
  return var_4;
}

function cleanupbtactions() {
  if(!isDefined(self._btactions)) {
    return;
  }

  var_0 = getarraykeys(self._btactions);

  foreach(var_2 in var_0) {
    scripts\aitypes\bt_state_api::btstate_clearsubstates(self._btactions[var_2]);
    self._btactions[var_2] = undefined;
  }

  self._btactions = undefined;
}

function getbtaction(var_0) {
  if(!isDefined(self._btactions)) {
    return undefined;
  }

  return self._btactions[var_0];
}

function setdesiredbtaction(var_0, var_1) {
  if(isDefined(var_1) && !isDefined(self._btactions[var_1])) {
    return false;
  }

  var_2 = getcurrentdesiredbtactionname(var_0);
  self.desiredaction = var_1;

  if(isDefined(var_2) && var_2 != var_1) {
    self notify("newaction");
  }

  return true;
}

function getcurrentdesiredbtactionname(var_0) {
  if(!isDefined(self.bt.currentaction)) {
    return undefined;
  }

  return self.bt.currentaction;
}

function getcurrentbtaction(var_0) {
  var_1 = getcurrentdesiredbtactionname(var_0);

  if(!isDefined(var_1)) {
    return undefined;
  }

  var_2 = getbtaction(var_1);
  return var_2;
}

function doaction_begin(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.currentaction = self.desiredaction;
  var_1 = self._btactions[self.desiredaction];
  var_1.taskid = var_0;
  var_2 = var_1.fnbegin;
  self.desiredaction = undefined;

  if(isDefined(var_2)) {
    [[var_2]](var_1);
    return;
  }
}

function doaction_tick(var_0) {
  var_1 = getcurrentdesiredbtactionname(var_0);
  var_2 = self._btactions[var_1];
  var_3 = var_2.fntick;

  if(isDefined(var_3)) {
    var_4 = [[var_3]](var_2);

    if(!isDefined(self.desiredaction)) {
      if(isDefined(var_4)) {
        return var_4;
      }

      return anim.failure;
    }
  }

  if(isDefined(self.desiredaction)) {
    doaction_end(var_0);
    doaction_begin(var_0);
    return anim.running;
  }

  return anim.failure;
}

function doaction_end(var_0) {
  var_1 = getcurrentdesiredbtactionname(var_0);
  var_2 = self._btactions[var_1];
  var_3 = var_2.fnend;

  if(isDefined(var_3)) {
    [[var_3]](var_2);
  }

  scripts\aitypes\bt_state_api::btstate_endstates(var_0, var_2);
  self.bt.instancedata[var_0] = undefined;
}