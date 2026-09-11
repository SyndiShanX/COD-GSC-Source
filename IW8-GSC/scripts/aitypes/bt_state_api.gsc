/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\bt_state_api.gsc
***********************************************/

function btstate_setupstate(var0, var1, var2, var3) {
  var4 = spawnStruct();
  var4.name = var0;
  var4.fnbegin = var1;
  var4.fntick = var2;
  var4.fnend = var3;
  var4.substates = [];
  var4.currentsubstate = undefined;
  var4.taskid = -1;
  return var4;
}

function btstate_addsubstate(var0, var1) {
  var0.substates[var1.name] = var1;
}

function btstate_getsubstate(var0, var1) {
  return var0.substates[var1];
}

function btstate_clearsubstates(var0) {
  if(!isDefined(var0.substates)) {
    return;
  }

  var1 = getarraykeys(var0.substates);

  foreach(var3 in var1) {
    btstate_clearsubstates(var0.substates[var3]);
    var0.substates[var3] = undefined;
  }

  var0.substates = undefined;
  var0.action = undefined;
  var0.currentsubstate = undefined;
  var0.parentstate = undefined;
}

function btstate_getcurrentsubstate(var0) {
  return var0.currentsubstate;
}

function btstate_tickstates(var0) {
  if(!isDefined(var0.currentsubstate)) {
    return anim.failure;
  }

  if(isDefined(var0.currentsubstate.fntick)) {
    var1 = var0.currentsubstate.name;
    var2 = [[var0.currentsubstate.fntick]](var0.currentsubstate);

    if(isDefined(var0.currentsubstate.timeouttime) && gettime() > var0.currentsubstate.timeouttime) {
      var2 = anim.failure;
      var0.currentsubstate.timeouttime = undefined;
    }

    if(isDefined(var0.currentsubstate) && var0.currentsubstate.name != var1) {
      return btstate_tickstates(var0);
    }

    if(var2 != anim.running) {
      btstate_endcurrentsubstate(var0);
    }

    return var2;
  } else if(isDefined(var2.currentsubstate.timeouttime) && gettime() > var2.currentsubstate.timeouttime) {
    var2.currentsubstate.timeouttime = undefined;
    return anim.failure;
  }

  return anim.failure;
}

function btstate_endstates(var0, var1) {
  if(isDefined(var1.currentsubstate)) {
    if(isDefined(var1.currentsubstate.fnend)) {
      [[var1.currentsubstate.fnend]](var1.currentsubstate, undefined);
    }

    btstate_endstates(var0, var1.currentsubstate);
    var1.currentsubstate.parentstate = undefined;
    var1.currentsubstate.action = undefined;
    var1.currentsubstate.taskid = -1;
    var1.currentsubstate = undefined;
    return;
  }
}

function btstate_endcurrentsubstate(var0) {
  if(isDefined(var0.currentsubstate)) {
    if(isDefined(var0.currentsubstate.fnend)) {
      self[[var0.currentsubstate.fnend]](var0.currentsubstate, undefined);
    }

    var1 = var0.currentsubstate;
    var0.currentsubstate.parentstate = undefined;
    var0.currentsubstate.action = undefined;
    var0.currentsubstate = undefined;

    if(isDefined(var1.currentsubstate)) {
      btstate_endcurrentsubstate(var1);
      return;
    }

    return;
  }
}

function btstate_transitionstate(var0, var1, var2) {
  var3 = undefined;
  var4 = var0.substates[var1];

  if(isDefined(var0.currentsubstate)) {
    var3 = var0.currentsubstate.name;

    if(isDefined(var0.currentsubstate.fnend)) {
      [[var0.currentsubstate.fnend]](var0, var1);
    }
  }

  var0.currentsubstate = var4;
  var4.parentstate = var0;
  var4.taskid = var0.taskid;

  if(isDefined(var2)) {
    var4.timeouttime = gettime() + var2;
  } else {
    var4.timeouttime = undefined;
  }

  if(isDefined(var0.action)) {
    var4.action = var0.action;
  } else {
    var4.action = var0;
  }

  if(isDefined(var4.fnbegin)) {
    self[[var4.fnbegin]](var4, var3);
    return;
  }
}