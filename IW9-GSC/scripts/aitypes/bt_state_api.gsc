/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\bt_state_api.gsc
***********************************************/

btstate_setupstate(name, fnbegin, fntick, fnend) {
  state = spawnStruct();
  state.name = name;
  state.fnbegin = fnbegin;
  state.fntick = fntick;
  state.fnend = fnend;
  state.substates = [];
  state.currentsubstate = undefined;
  state.taskid = -1;
  return state;
}

btstate_addsubstate(parentstate, state) {
  parentstate.substates[state.name] = state;
}

btstate_getsubstate(parentstate, _id_56C87A7D3E2F91E9) {
  return parentstate.substates[_id_56C87A7D3E2F91E9];
}

btstate_clearsubstates(parentstate) {
  if(!isDefined(parentstate.substates)) {
    return;
  }
  keys = getarraykeys(parentstate.substates);

  foreach(key in keys) {
    btstate_clearsubstates(parentstate.substates[key]);
    parentstate.substates[key] = undefined;
  }

  parentstate.substates = undefined;
  parentstate.action = undefined;
  parentstate.currentsubstate = undefined;
  parentstate.parentstate = undefined;
}

btstate_getcurrentsubstate(parentstate) {
  return parentstate.currentsubstate;
}

btstate_tickstates(parentstate) {
  if(!isDefined(parentstate.currentsubstate))
    return anim.failure;

  if(isDefined(parentstate.currentsubstate.fntick)) {
    currentstatename = parentstate.currentsubstate.name;
    _id_62563A3AB1624A5A = [[parentstate.currentsubstate.fntick]](parentstate.currentsubstate);

    if(isDefined(parentstate.currentsubstate.timeouttime) && gettime() > parentstate.currentsubstate.timeouttime) {
      _id_62563A3AB1624A5A = anim.failure;
      parentstate.currentsubstate.timeouttime = undefined;
    }

    if(isDefined(parentstate.currentsubstate) && parentstate.currentsubstate.name != currentstatename)
      return btstate_tickstates(parentstate);

    if(_id_62563A3AB1624A5A != anim.running)
      btstate_endcurrentsubstate(parentstate);

    return _id_62563A3AB1624A5A;
  } else if(isDefined(parentstate.currentsubstate.timeouttime) && gettime() > parentstate.currentsubstate.timeouttime) {
    parentstate.currentsubstate.timeouttime = undefined;
    return anim.failure;
  }

  return anim.failure;
}

btstate_endstates(taskid, parentstate) {
  if(isDefined(parentstate.currentsubstate)) {
    if(isDefined(parentstate.currentsubstate.fnend))
      [[parentstate.currentsubstate.fnend]](parentstate.currentsubstate, undefined);

    btstate_endstates(taskid, parentstate.currentsubstate);
    parentstate.currentsubstate.parentstate = undefined;
    parentstate.currentsubstate.action = undefined;
    parentstate.currentsubstate.taskid = -1;
    parentstate.currentsubstate = undefined;
  }
}

btstate_endcurrentsubstate(parentstate) {
  if(isDefined(parentstate.currentsubstate)) {
    if(isDefined(parentstate.currentsubstate.fnend))
      self[[parentstate.currentsubstate.fnend]](parentstate.currentsubstate, undefined);

    _id_69625714F6A90A62 = parentstate.currentsubstate;
    parentstate.currentsubstate.parentstate = undefined;
    parentstate.currentsubstate.action = undefined;
    parentstate.currentsubstate = undefined;

    if(isDefined(_id_69625714F6A90A62.currentsubstate))
      btstate_endcurrentsubstate(_id_69625714F6A90A62);
  }
}

btstate_transitionstate(currentstate, _id_56C87A7D3E2F91E9, duration) {
  previousstatename = undefined;
  _id_9B1941CB7354665E = currentstate.substates[_id_56C87A7D3E2F91E9];

  if(isDefined(currentstate.currentsubstate)) {
    previousstatename = currentstate.currentsubstate.name;

    if(isDefined(currentstate.currentsubstate.fnend))
      [[currentstate.currentsubstate.fnend]](currentstate, _id_56C87A7D3E2F91E9);
  }

  currentstate.currentsubstate = _id_9B1941CB7354665E;
  _id_9B1941CB7354665E.parentstate = currentstate;
  _id_9B1941CB7354665E.taskid = currentstate.taskid;

  if(isDefined(duration))
    _id_9B1941CB7354665E.timeouttime = gettime() + duration;
  else
    _id_9B1941CB7354665E.timeouttime = undefined;

  if(isDefined(currentstate.action))
    _id_9B1941CB7354665E.action = currentstate.action;
  else
    _id_9B1941CB7354665E.action = currentstate;

  if(isDefined(_id_9B1941CB7354665E.fnbegin))
    self[[_id_9B1941CB7354665E.fnbegin]](_id_9B1941CB7354665E, previousstatename);
}