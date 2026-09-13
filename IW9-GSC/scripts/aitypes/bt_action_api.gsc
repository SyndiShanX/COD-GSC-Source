/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\bt_action_api.gsc
***********************************************/

setupbtaction(name, fnbegin, fntick, fnend) {
  action = scripts\aitypes\bt_state_api::btstate_setupstate(name, fnbegin, fntick, fnend);
  self._btactions[name] = action;
  return action;
}

cleanupbtactions() {
  if(!isDefined(self._btactions)) {
    return;
  }
  keys = getarraykeys(self._btactions);

  foreach(key in keys) {
    scripts\aitypes\bt_state_api::btstate_clearsubstates(self._btactions[key]);
    self._btactions[key] = undefined;
  }

  self._btactions = undefined;
}

getbtaction(_id_D72415E8DDB6F828) {
  if(!isDefined(self._btactions))
    return undefined;

  return self._btactions[_id_D72415E8DDB6F828];
}

setdesiredbtaction(taskid, _id_D776D321D91D6CC4) {
  if(isDefined(_id_D776D321D91D6CC4) && !isDefined(self._btactions[_id_D776D321D91D6CC4]))
    return 0;

  currentaction = getcurrentdesiredbtactionname(taskid);
  self.desiredaction = _id_D776D321D91D6CC4;

  if(isDefined(currentaction) && currentaction != _id_D776D321D91D6CC4)
    self notify("newaction");

  return 1;
}

getcurrentdesiredbtactionname(taskid) {
  if(!isDefined(self.bt.currentaction))
    return undefined;

  return self.bt.currentaction;
}

getcurrentbtaction(taskid) {
  _id_50FF37E0C3A37DFF = getcurrentdesiredbtactionname(taskid);

  if(!isDefined(_id_50FF37E0C3A37DFF))
    return undefined;

  currentaction = getbtaction(_id_50FF37E0C3A37DFF);
  return currentaction;
}

doaction_begin(taskid) {
  self.bt.instancedata[taskid] = spawnStruct();
  self.bt.currentaction = self.desiredaction;
  currentaction = self._btactions[self.desiredaction];
  currentaction.taskid = taskid;
  func = currentaction.fnbegin;
  self.desiredaction = undefined;

  if(isDefined(func))
    [[func]](currentaction);
}

doaction_tick(taskid) {
  desiredaction = getcurrentdesiredbtactionname(taskid);
  currentaction = self._btactions[desiredaction];
  func = currentaction.fntick;

  if(isDefined(func)) {
    _id_62563A3AB1624A5A = [[func]](currentaction);

    if(!isDefined(self.desiredaction)) {
      if(isDefined(_id_62563A3AB1624A5A))
        return _id_62563A3AB1624A5A;

      return anim.failure;
    }
  }

  if(isDefined(self.desiredaction)) {
    doaction_end(taskid);
    doaction_begin(taskid);
    return anim.running;
  }

  return anim.failure;
}

doaction_end(taskid) {
  desiredaction = getcurrentdesiredbtactionname(taskid);
  action = self._btactions[desiredaction];
  func = action.fnend;

  if(isDefined(func))
    [[func]](action);

  scripts\aitypes\bt_state_api::btstate_endstates(taskid, action);
  self.bt.instancedata[taskid] = undefined;
}