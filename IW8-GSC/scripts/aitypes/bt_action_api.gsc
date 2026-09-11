/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\bt_action_api.gsc
***********************************************/

function setupbtaction(var0, var1, var2, var3) {
  var4 = scripts\aitypes\bt_state_api::btstate_setupstate(var0, var1, var2, var3);
  self._btactions[var0] = var4;
  return var4;
}

function cleanupbtactions() {
  if(!isDefined(self._btactions)) {
    return;
  }

  var0 = getarraykeys(self._btactions);

  foreach(var2 in var0) {
    scripts\aitypes\bt_state_api::btstate_clearsubstates(self._btactions[var2]);
    self._btactions[var2] = undefined;
  }

  self._btactions = undefined;
}

function getbtaction(var0) {
  if(!isDefined(self._btactions)) {
    return undefined;
  }

  return self._btactions[var0];
}

function setdesiredbtaction(var0, var1) {
  if(isDefined(var1) && !isDefined(self._btactions[var1])) {
    return false;
  }

  var2 = getcurrentdesiredbtactionname(var0);
  self.desiredaction = var1;

  if(isDefined(var2) && var2 != var1) {
    self notify("newaction");
  }

  return true;
}

function getcurrentdesiredbtactionname(var0) {
  if(!isDefined(self.bt.currentaction)) {
    return undefined;
  }

  return self.bt.currentaction;
}

function getcurrentbtaction(var0) {
  var1 = getcurrentdesiredbtactionname(var0);

  if(!isDefined(var1)) {
    return undefined;
  }

  var2 = getbtaction(var1);
  return var2;
}

function doaction_begin(var0) {
  self.bt.instancedata[var0] = spawnStruct();
  self.bt.currentaction = self.desiredaction;
  var1 = self._btactions[self.desiredaction];
  var1.taskid = var0;
  var2 = var1.fnbegin;
  self.desiredaction = undefined;

  if(isDefined(var2)) {
    [[var2]](var1);
    return;
  }
}

function doaction_tick(var0) {
  var1 = getcurrentdesiredbtactionname(var0);
  var2 = self._btactions[var1];
  var3 = var2.fntick;

  if(isDefined(var3)) {
    var4 = [[var3]](var2);

    if(!isDefined(self.desiredaction)) {
      if(isDefined(var4)) {
        return var4;
      }

      return anim.failure;
    }
  }

  if(isDefined(self.desiredaction)) {
    doaction_end(var0);
    doaction_begin(var0);
    return anim.running;
  }

  return anim.failure;
}

function doaction_end(var0) {
  var1 = getcurrentdesiredbtactionname(var0);
  var2 = self._btactions[var1];
  var3 = var2.fnend;

  if(isDefined(var3)) {
    [[var3]](var2);
  }

  scripts\aitypes\bt_state_api::btstate_endstates(var0, var2);
  self.bt.instancedata[var0] = undefined;
}