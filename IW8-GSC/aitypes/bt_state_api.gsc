/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitypes\bt_state_api.gsc
***********************************************/

btstate_setupstate(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.name = var_0;
  var_4.fnbegin = var_1;
  var_4.fntick = var_2;
  var_4.fnend = var_3;
  var_4.substates = [];
  var_4.currentsubstate = undefined;
  var_4.taskid = -1;
  return var_4;
}

btstate_addsubstate(var_0, var_1) {
  var_0.substates[var_1.name] = var_1;
}

btstate_getsubstate(var_0, var_1) {
  return var_0.substates[var_1];
}

btstate_clearsubstates(var_0) {
  if(!isDefined(var_0.substates)) {
    return;
  }
  var_1 = getarraykeys(var_0.substates);

  foreach(var_3 in var_1) {
    btstate_clearsubstates(var_0.substates[var_3]);
    var_0.substates[var_3] = undefined;
  }

  var_0.substates = undefined;
  var_0.action = undefined;
  var_0.currentsubstate = undefined;
  var_0.parentstate = undefined;
}

btstate_getcurrentsubstate(var_0) {
  return var_0.currentsubstate;
}

btstate_tickstates(var_0) {
  if(!isDefined(var_0.currentsubstate))
    return anim.failure;

  if(isDefined(var_0.currentsubstate.fntick)) {
    var_1 = var_0.currentsubstate.name;
    var_2 = [[var_0.currentsubstate.fntick]](var_0.currentsubstate);

    if(isDefined(var_0.currentsubstate.timeouttime) && gettime() > var_0.currentsubstate.timeouttime) {
      var_2 = anim.failure;
      var_0.currentsubstate.timeouttime = undefined;
    }

    if(isDefined(var_0.currentsubstate) && var_0.currentsubstate.name != var_1)
      return btstate_tickstates(var_0);

    if(var_2 != anim.running)
      btstate_endcurrentsubstate(var_0);

    return var_2;
  } else if(isDefined(var_0.currentsubstate.timeouttime) && gettime() > var_0.currentsubstate.timeouttime) {
    var_0.currentsubstate.timeouttime = undefined;
    return anim.failure;
  }

  return anim.failure;
}

btstate_endstates(var_0, var_1) {
  if(isDefined(var_1.currentsubstate)) {
    if(isDefined(var_1.currentsubstate.fnend))
      [[var_1.currentsubstate.fnend]](var_1.currentsubstate, undefined);

    btstate_endstates(var_0, var_1.currentsubstate);
    var_1.currentsubstate.parentstate = undefined;
    var_1.currentsubstate.action = undefined;
    var_1.currentsubstate.taskid = -1;
    var_1.currentsubstate = undefined;
  }
}

btstate_endcurrentsubstate(var_0) {
  if(isDefined(var_0.currentsubstate)) {
    if(isDefined(var_0.currentsubstate.fnend))
      self[[var_0.currentsubstate.fnend]](var_0.currentsubstate, undefined);

    var_1 = var_0.currentsubstate;
    var_0.currentsubstate.parentstate = undefined;
    var_0.currentsubstate.action = undefined;
    var_0.currentsubstate = undefined;

    if(isDefined(var_1.currentsubstate))
      btstate_endcurrentsubstate(var_1);
  }
}

btstate_transitionstate(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = var_0.substates[var_1];

  if(isDefined(var_0.currentsubstate)) {
    var_3 = var_0.currentsubstate.name;

    if(isDefined(var_0.currentsubstate.fnend))
      [[var_0.currentsubstate.fnend]](var_0, var_1);
  }

  var_0.currentsubstate = var_4;
  var_4.parentstate = var_0;
  var_4.taskid = var_0.taskid;

  if(isDefined(var_2))
    var_4.timeouttime = gettime() + var_2;
  else
    var_4.timeouttime = undefined;

  if(isDefined(var_0.action))
    var_4.action = var_0.action;
  else
    var_4.action = var_0;

  if(isDefined(var_4.fnbegin))
    self[[var_4.fnbegin]](var_4, var_3);
}