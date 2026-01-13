/****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\aitypes\slasher\bt_state_api.gsc
****************************************************/

btstate_getinstancedata(var_0) {
  return self.bt.instancedata[var_0];
}

btstate_setupstate(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.name = var_0;
  var_4.fnbegin = var_1;
  var_4.fntick = var_2;
  var_4.fnend = var_3;
  if(!isDefined(self.bt_states)) {
    self.bt_states = [];
  }

  self.bt_states[var_0] = var_4;
  return var_4;
}

btstate_getcurrentstatename(var_0) {
  var_1 = btstate_getinstancedata(var_0);
  if(!isDefined(var_1)) {
    return undefined;
  }

  if(!isDefined(var_1.currentstate)) {
    return undefined;
  }

  return var_1.currentstate.name;
}

btstate_tickstates(var_0) {
  var_1 = btstate_getinstancedata(var_0);
  if(!isDefined(var_1.currentstate)) {
    return 0;
  }

  if(isDefined(var_1.currentstate.fntick)) {
    var_2 = var_1.currentstate.name;
    var_3 = self[[var_1.currentstate.fntick]](var_0);
    if(isDefined(var_1.currentstate) && var_1.currentstate.name != var_2) {
      return btstate_tickstates(var_0);
    }

    return var_3;
  }

  return 1;
}

btstate_endstates(var_0) {
  var_1 = btstate_getinstancedata(var_0);
  if(isDefined(var_1.currentstate) && isDefined(var_1.currentstate.fnend)) {
    [[var_1.currentstate.fnend]](var_0, undefined);
    var_1.currentstate = undefined;
  }
}

btstate_destroystates() {
  self.bt_states = undefined;
}

btstate_endcurrentstate(var_0) {
  var_1 = btstate_getinstancedata(var_0);
  if(isDefined(var_1.currentstate) && isDefined(var_1.currentstate.fnend)) {
    self[[var_1.currentstate.fnend]](var_0, undefined);
  }

  var_1.currentstate = undefined;
}

btstate_transitionstate(var_0, var_1) {
  var_2 = btstate_getinstancedata(var_0);
  var_3 = undefined;
  if(isDefined(var_2.currentstate)) {
    var_3 = var_2.currentstate.name;
    if(isDefined(var_2.currentstate.fnend)) {
      [
        [var_2.currentstate.fnend]
      ](var_0, var_1);
    }
  }

  var_4 = self.bt_states[var_1];
  var_2.currentstate = var_4;
  if(isDefined(var_4.fnbegin)) {
    self[[var_4.fnbegin]](var_0, var_3);
  }
}

chase_target_state_setup(var_0, var_1, var_2, var_3, var_4) {
  btstate_setupstate("chase", ::chase_target_state_begin, ::chase_target_state_tick, ::chase_target_state_end);
  var_5 = btstate_getinstancedata(var_0);
  var_5.objective_playermask_showto = var_1;
  var_5.target = var_2;
  var_5.fncallback = var_3;
  var_5.maxchasetime = var_4;
}

chase_target_state_begin(var_0, var_1) {
  var_2 = btstate_getinstancedata(var_0);
  var_2.starttime = gettime();
  self ghosts_attack_logic(var_2.target);
  self ghostskulls_total_waves(var_2.objective_playermask_showto * 0.9);
}

chase_target_state_done(var_0, var_1) {
  var_2 = btstate_getinstancedata(var_0);
  var_3 = var_2.fncallback;
  btstate_endcurrentstate(var_0);
  if(isDefined(var_3)) {
    [[var_3]](var_0, var_1);
  }
}

chase_target_state_tick(var_0) {
  var_1 = btstate_getinstancedata(var_0);
  if(!isalive(var_1.target)) {
    chase_target_state_done(var_0, "aborted");
    return 0;
  }

  if(isDefined(var_1.maxchasetime)) {
    if(gettime() > var_1.starttime + var_1.maxchasetime) {
      chase_target_state_done(var_0, "timeout");
      return 0;
    }
  }

  var_2 = distance2dsquared(self.origin, var_1.target.origin);
  if(var_2 > squared(var_1.objective_playermask_showto)) {
    return 1;
  }

  if(abs(self.origin[2] - var_1.target.origin[2] > 32)) {
    return 1;
  }

  chase_target_state_done(var_0, "arrived");
  return 1;
}

chase_target_state_end(var_0, var_1) {
  var_2 = btstate_getinstancedata(var_0);
  var_2.objective_playermask_showto = undefined;
  var_2.target = undefined;
  var_2.fncallback = undefined;
}

asm_wait_state_setup(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_4)) {
    var_4 = "ASM_Finished";
  }

  btstate_setupstate(var_1, ::asm_wait_state_begin, ::asm_wait_state_tick, ::asm_wait_state_end);
  var_7 = btstate_getinstancedata(var_0);
  var_7.endevent = var_4;
  var_7.asmstate = var_2;
  var_7.fncallback = var_3;
  if(isDefined(var_6)) {
    var_7.timeouttime = gettime() + var_6;
  } else {
    var_7.timeouttime = gettime() + 2000;
  }

  if(isDefined(var_5)) {
    var_7.var_6393 = gettime() + var_5;
  }
}

asm_wait_state_begin(var_0, var_1) {
  var_2 = btstate_getinstancedata(var_0);
  var_2.bisinasmstate = scripts\asm\asm::asm_isinstate(var_2.asmstate);
}

asm_wait_state_tick(var_0) {
  var_1 = btstate_getinstancedata(var_0);
  var_2 = scripts\asm\asm::asm_isinstate(var_1.asmstate);
  if(var_2 && !var_1.bisinasmstate) {
    var_1.bisinasmstate = 1;
  }

  var_3 = 0;
  var_4 = undefined;
  if(!var_2 && var_1.bisinasmstate) {
    var_3 = 1;
    var_4 = "aborted";
  } else if(isDefined(var_1.timeouttime) && !var_2 && !var_1.bisinasmstate) {
    if(gettime() > var_1.timeouttime) {
      var_3 = 1;
      var_4 = "timeout";
    }
  } else if(isDefined(var_1.var_6393)) {
    if(gettime() > var_1.var_6393) {
      var_3 = 1;
      var_4 = "end_time";
    }
  }

  if(!var_3 && scripts\asm\asm::asm_ephemeraleventfired(var_1.asmstate, var_1.endevent)) {
    var_3 = 1;
    var_4 = "end_event";
  }

  if(var_3) {
    var_5 = var_1.fncallback;
    btstate_endcurrentstate(var_0);
    if(isDefined(var_5)) {
      [
        [var_5]
      ](var_0, var_4);
    }
  }

  return !var_3;
}

asm_wait_state_end(var_0, var_1) {
  var_2 = btstate_getinstancedata(var_0);
  var_2.endevent = undefined;
  var_2.asmstate = undefined;
  var_2.fncallback = undefined;
  var_2.bisinasmstate = undefined;
}