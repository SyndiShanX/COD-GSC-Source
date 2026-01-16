/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\ai\state.gsc
***********************************************/

#namespace ai_state;

function_e9b061a8(state, start, update_goal, end, update_enemy, var_edc20efd, attack_origin, update_debug) {
  level.extra_screen_electricity_.functions[state] = {
    #start: start, 
    #update_goal: update_goal, 
    #end: end, 
    #update_enemy: update_enemy, 
    #var_edc20efd: var_edc20efd, 
    #attack_origin: attack_origin, 
    #update_debug: update_debug
  };
}

callback_start() {
  if(isDefined(self.ai.state) && isDefined(level.extra_screen_electricity_.functions[self.ai.state].start)) {
    self thread[[level.extra_screen_electricity_.functions[self.ai.state].start]]();
  }
}

callback_end() {
  if(isDefined(self.ai.state) && isDefined(level.extra_screen_electricity_.functions[self.ai.state].end)) {
    self thread[[level.extra_screen_electricity_.functions[self.ai.state].end]]();
  }
}

function_e8e7cf45() {
  if(isDefined(self.ai.state) && isDefined(level.extra_screen_electricity_.functions[self.ai.state].update_goal)) {
    self[[level.extra_screen_electricity_.functions[self.ai.state].update_goal]]();
  }
}

function_e0e1a7fc() {
  if(isDefined(self.ai.state) && isDefined(level.extra_screen_electricity_.functions[self.ai.state].update_enemy)) {
    self[[level.extra_screen_electricity_.functions[self.ai.state].update_enemy]]();
  }
}

function_4af1ff64() {
  if(isDefined(self.ai.state) && isDefined(level.extra_screen_electricity_.functions[self.ai.state].var_edc20efd)) {
    return self[[level.extra_screen_electricity_.functions[self.ai.state].var_edc20efd]]();
  }

  return 0;
}

function_a78474f2() {
  if(isDefined(self.ai.state) && isDefined(level.extra_screen_electricity_.functions[self.ai.state].attack_origin)) {
    return self[[level.extra_screen_electricity_.functions[self.ai.state].attack_origin]]();
  }

  return undefined;
}

set_state(state) {
  if(!isDefined(self.ai)) {
    self.ai = {
      #state: undefined
    };
  }

  if(!isDefined(self.ai.state) || self.ai.state != state) {
    if(isDefined(self.ai.state)) {
      callback_end();
    }

    self.ai.state = state;
    callback_start();
    self notify(#"state_changed", state);

    self thread function_3a57bb58();

  }
}

is_state(state) {
  return self.ai.state == state;
}

function_c1d2ede8() {
  if(isDefined(level.extra_screen_electricity_.functions[self.ai.state].update_debug)) {
    self[[level.extra_screen_electricity_.functions[self.ai.state].update_debug]]();
  }
}

function_3a57bb58() {
  self notify("<dev string:x38>");
  self endon("<dev string:x38>");
  self endon(#"death");

  while(true) {
    self function_c1d2ede8();
    waitframe(1);
  }
}

