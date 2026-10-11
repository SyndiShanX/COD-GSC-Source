/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\statemachine.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\utility;
#namespace statemachine;

function begin_fsm(statearray, var_59c66fcdd3beb7d7) {
  self.previousstate = undefined;
  self.currentstate = undefined;
  self.permanentnotifyhandlers = undefined;
  self.currentnotifyhandlers = undefined;
  self.states = statearray;
  assertex(isDefined(self.states) && self.states.size > 0, "No states defined for FSM");

  if(isDefined(var_59c66fcdd3beb7d7)) {
    self.initialstate = var_59c66fcdd3beb7d7;
  } else if(isDefined(self.states[0][0])) {
    self.initialstate = self.states[0][0];
  }

  goto_state(self.initialstate);
}

function goto_state(newstatename) {
  thread perform_state_change(newstatename);
}

function perform_state_change(newstatename) {
  newstate = get_state(newstatename);

  if(isDefined(newstate)) {
    if(isDefined(self.currentstate)) {
      self.previousstate = self.currentstate;
    }

    self notify("changed_state");
    self.currentnotifyhandlers = [];

    if(isDefined(self.previousstate)) {
      if(isDefined(self.previousstate[3])) {
        exitfunction = self.previousstate[3];
        [[exitfunction]]();
      }
    }

    self.currentstate = newstate;

    if(isDefined(self.currentstate[1])) {
      var_63d751a32b8eb335 = self.currentstate[1];
      set_enter_function(var_63d751a32b8eb335);
    }

    if(isDefined(self.currentstate[2])) {
      updatefunction = self.currentstate[2];
      thread set_update_function(updatefunction);
    }

    return;
  }

  assertex(isDefined(newstate), "State: " + newstatename + ", is not defined");
}

function goto_state_previous() {
  if(isDefined(self.previousstate)) {
    goto_state(self.previousstate[0]);
  }
}

function get_state(statename) {
  foreach(state in self.states) {
    if(state[0] == statename) {
      return state;
    }
  }

  return undefined;
}

function set_enter_function(function) {
  self endon("death");
  self endon("changed_state");
  self childthread[[function]]();
}

function set_update_function(function) {
  self endon("death");
  self endon("changed_state");

  while(true) {
    [[function]]();
    waitframe();
  }
}

function set_notify_handlers(var_baf55632c23b48b4) {
  self.currentnotifyhandlers = var_baf55632c23b48b4;

  foreach(handler in var_baf55632c23b48b4) {
    var_107f1d5307246e8e = -1;

    if(isDefined(handler[2])) {
      var_107f1d5307246e8e = handler[2];
    }

    thread state_nofity_handler(handler[0], handler[1], var_107f1d5307246e8e);
  }
}

function set_permanent_notify_handlers(var_baf55632c23b48b4) {
  self.permanentnotifyhandlers = var_baf55632c23b48b4;

  foreach(handler in var_baf55632c23b48b4) {
    var_107f1d5307246e8e = -1;

    if(isDefined(handler[2])) {
      var_107f1d5307246e8e = handler[2];
    }

    thread permanent_notify_handler(handler[0], handler[1], var_107f1d5307246e8e);
  }
}

function state_nofity_handler(notifystring, handlerfunction, var_107f1d5307246e8e) {
  self endon("death");
  self endon("changed_state");
  start_handler(notifystring, handlerfunction, var_107f1d5307246e8e);
}

function permanent_notify_handler(notifystring, handlerfunction, var_107f1d5307246e8e) {
  self endon("death");
  start_handler(notifystring, handlerfunction, var_107f1d5307246e8e);
}

function start_handler(notifystring, handlerfunction, var_107f1d5307246e8e) {
  self notify("new_handler");

  for(var_4cd932b295f4ca3c = 1; var_4cd932b295f4ca3c; var_4cd932b295f4ca3c = 0) {
    self waittill(notifystring, params);

    if(isDefined(params)) {
      [[handlerfunction]](params);
    } else {
      [[handlerfunction]]();
    }

    if(var_107f1d5307246e8e >= 0) {
      var_107f1d5307246e8e--;

      if(var_107f1d5307246e8e == 0) {}
    }
  }
}

function get_current_state() {
  if(isDefined(self.currentstate)) {
    return self.currentstate[0];
  }

  assertex(isDefined(self.currentstate), "Current state does not exist");
}