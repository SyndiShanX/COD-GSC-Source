/****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\ratking\bt_state_api.gsc
****************************************************/

btstate_getinstancedata(param_00) {
  return self.var_3135.instancedata[param_00];
}

btstate_setupstate(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  var_04.name = param_00;
  var_04.fnbegin = param_01;
  var_04.fntick = param_02;
  var_04.fnend = param_03;
  if(!isDefined(self.bt_states)) {
    self.bt_states = [];
  }

  self.bt_states[param_00] = var_04;
  return var_04;
}

btstate_getcurrentstatename(param_00) {
  var_01 = btstate_getinstancedata(param_00);
  if(!isDefined(var_01)) {
    return undefined;
  }

  if(!isDefined(var_01.currentstate)) {
    return undefined;
  }

  return var_01.currentstate.name;
}

btstate_tickstates(param_00) {
  var_01 = btstate_getinstancedata(param_00);
  if(!isDefined(var_01.currentstate)) {
    return 0;
  }

  if(isDefined(var_01.currentstate.fntick)) {
    var_02 = var_01.currentstate.name;
    var_03 = self[[var_01.currentstate.fntick]](param_00);
    if(isDefined(var_01.currentstate) && var_01.currentstate.name != var_02) {
      return btstate_tickstates(param_00);
    }

    return var_03;
  }

  return 1;
}

btstate_endstates(param_00) {
  if(isDefined(self.bt_states)) {
    var_01 = btstate_getinstancedata(param_00);
    if(isDefined(var_01.currentstate) && isDefined(var_01.currentstate.fnend)) {
      [
        [var_01.currentstate.fnend]
      ](param_00, undefined);
      var_01.currentstate = undefined;
    }
  }
}

btstate_destroystates() {
  self.bt_states = undefined;
}

btstate_endcurrentstate(param_00) {
  var_01 = btstate_getinstancedata(param_00);
  if(isDefined(var_01.currentstate) && isDefined(var_01.currentstate.fnend)) {
    self[[var_01.currentstate.fnend]](param_00, undefined);
  }

  var_01.currentstate = undefined;
}

btstate_transitionstate(param_00, param_01) {
  var_02 = btstate_getinstancedata(param_00);
  var_03 = undefined;
  if(isDefined(var_02.currentstate)) {
    var_03 = var_02.currentstate.name;
    if(isDefined(var_02.currentstate.fnend)) {
      [
        [var_02.currentstate.fnend]
      ](param_00, param_01);
    }
  }

  var_04 = self.bt_states[param_01];
  var_02.currentstate = var_04;
  if(isDefined(var_04.fnbegin)) {
    self[[var_04.fnbegin]](param_00, var_03);
  }
}

chase_target_state_setup(param_00, param_01, param_02, param_03, param_04) {
  btstate_setupstate("chase", ::chase_target_state_begin, ::chase_target_state_tick, ::chase_target_state_end);
  var_05 = btstate_getinstancedata(param_00);
  var_05.objective_playermask_showto = param_01;
  var_05.target = param_02;
  var_05.fncallback = param_03;
  var_05.maxchasetime = param_04;
}

chase_target_state_begin(param_00, param_01) {
  var_02 = btstate_getinstancedata(param_00);
  var_02.starttime = gettime();
  self ghosts_attack_logic(var_02.target);
  self ghostskulls_total_waves(var_02.objective_playermask_showto * 0.9);
}

chase_target_state_done(param_00, param_01) {
  var_02 = btstate_getinstancedata(param_00);
  var_03 = var_02.fncallback;
  btstate_endcurrentstate(param_00);
  if(isDefined(var_03)) {
    [[var_03]](param_00, param_01);
  }
}

chase_target_state_tick(param_00) {
  var_01 = btstate_getinstancedata(param_00);
  if(!isalive(var_01.target)) {
    chase_target_state_done(param_00, "aborted");
    return 0;
  }

  if(isDefined(var_01.maxchasetime)) {
    if(gettime() > var_01.starttime + var_01.maxchasetime) {
      chase_target_state_done(param_00, "timeout");
      return 0;
    }
  }

  var_02 = distance2dsquared(self.origin, var_01.target.origin);
  if(var_02 > squared(var_01.objective_playermask_showto)) {
    return 1;
  }

  if(abs(self.origin[2] - var_01.target.origin[2] > 32)) {
    return 1;
  }

  chase_target_state_done(param_00, "arrived");
  return 1;
}

chase_target_state_end(param_00, param_01) {
  var_02 = btstate_getinstancedata(param_00);
  var_02.objective_playermask_showto = undefined;
  var_02.target = undefined;
  var_02.fncallback = undefined;
}

asm_wait_state_setup(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(!isDefined(param_04)) {
    param_04 = "ASM_Finished";
  }

  btstate_setupstate(param_01, ::asm_wait_state_begin, ::asm_wait_state_tick, ::asm_wait_state_end);
  var_07 = btstate_getinstancedata(param_00);
  var_07.endevent = param_04;
  var_07.asmstate = param_02;
  var_07.fncallback = param_03;
  if(isDefined(param_06)) {
    var_07.timeouttime = gettime() + param_06;
  } else {
    var_07.timeouttime = gettime() + 2000;
  }

  if(isDefined(param_05)) {
    var_07.var_6393 = gettime() + param_05;
  }
}

asm_wait_state_begin(param_00, param_01) {
  var_02 = btstate_getinstancedata(param_00);
  var_02.bisinasmstate = scripts\asm\asm::asm_isinstate(var_02.asmstate);
}

asm_wait_state_tick(param_00) {
  var_01 = btstate_getinstancedata(param_00);
  var_02 = scripts\asm\asm::asm_isinstate(var_01.asmstate);
  if(var_02 && !var_01.bisinasmstate) {
    var_01.bisinasmstate = 1;
  }

  var_03 = 0;
  var_04 = undefined;
  if(!var_02 && var_01.bisinasmstate) {
    var_03 = 1;
    var_04 = "aborted";
  } else if(isDefined(var_01.timeouttime) && !var_02 && !var_01.bisinasmstate) {
    if(gettime() > var_01.timeouttime) {
      var_03 = 1;
      var_04 = "timeout";
    }
  } else if(isDefined(var_01.var_6393)) {
    if(gettime() > var_01.var_6393) {
      var_03 = 1;
      var_04 = "end_time";
    }
  }

  if(scripts\asm\asm::asm_ephemeraleventfired(var_01.asmstate, var_01.endevent)) {
    var_03 = 1;
    var_04 = "end_event";
  }

  if(var_03) {
    var_05 = var_01.fncallback;
    btstate_endcurrentstate(param_00);
    if(isDefined(var_05)) {
      [
        [var_05]
      ](param_00, var_04);
    }
  }

  return !var_03;
}

asm_wait_state_end(param_00, param_01) {
  var_02 = btstate_getinstancedata(param_00);
  var_02.endevent = undefined;
  var_02.asmstate = undefined;
  var_02.fncallback = undefined;
  var_02.bisinasmstate = undefined;
}