/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\statemachine.gsc
***********************************************/

begin_fsm(var_0, var_1) {
  self.previousstate = undefined;
  self.currentstate = undefined;
  self.permanentnotifyhandlers = undefined;
  self.currentnotifyhandlers = undefined;
  self.states = var_0;

  if(isDefined(var_1))
    self.initialstate = var_1;
  else if(isDefined(self.states[0][0]))
    self.initialstate = self.states[0][0];

  goto_state(self.initialstate);
}

goto_state(var_0) {
  thread perform_state_change(var_0);
}

perform_state_change(var_0) {
  var_1 = get_state(var_0);

  if(isDefined(var_1)) {
    if(isDefined(self.currentstate))
      self.previousstate = self.currentstate;

    self notify("changed_state");
    self.currentnotifyhandlers = [];

    if(isDefined(self.previousstate)) {
      if(isDefined(self.previousstate[3])) {
        var_2 = self.previousstate[3];
        [[var_2]]();
      }
    }

    self.currentstate = var_1;

    if(isDefined(self.currentstate[1])) {
      var_3 = self.currentstate[1];
      set_enter_function(var_3);
    }

    if(isDefined(self.currentstate[2])) {
      var_4 = self.currentstate[2];
      thread set_update_function(var_4);
    }
  } else {}
}

goto_state_previous() {
  if(isDefined(self.previousstate))
    goto_state(self.previousstate[0]);
}

get_state(var_0) {
  foreach(var_2 in self.states) {
    if(var_2[0] == var_0)
      return var_2;
  }

  return undefined;
}

set_enter_function(var_0) {
  self endon("death");
  self endon("changed_state");
  self thread[[var_0]]();
}

set_update_function(var_0) {
  self endon("death");
  self endon("changed_state");

  for(;;) {
    [[var_0]]();
    waitframe();
  }
}

set_notify_handlers(var_0) {
  self.currentnotifyhandlers = var_0;

  foreach(var_2 in var_0) {
    var_3 = -1;

    if(isDefined(var_2[2]))
      var_3 = var_2[2];

    thread state_nofity_handler(var_2[0], var_2[1], var_3);
  }
}

set_permanent_notify_handlers(var_0) {
  self.permanentnotifyhandlers = var_0;

  foreach(var_2 in var_0) {
    var_3 = -1;

    if(isDefined(var_2[2]))
      var_3 = var_2[2];

    thread permanent_notify_handler(var_2[0], var_2[1], var_3);
  }
}

state_nofity_handler(var_0, var_1, var_2) {
  self endon("death");
  self endon("changed_state");
  start_handler(var_0, var_1, var_2);
}

permanent_notify_handler(var_0, var_1, var_2) {
  self endon("death");
  start_handler(var_0, var_1, var_2);
}

start_handler(var_0, var_1, var_2) {
  self notify("new_handler");
  var_3 = 1;

  while(var_3) {
    self waittill(var_0, var_4);

    if(isDefined(var_4))
      [[var_1]](var_4);
    else
      [[var_1]]();

    if(var_2 >= 0) {
      var_2--;

      if(var_2 == 0)
        var_3 = 0;
    }
  }
}

get_current_state() {
  if(isDefined(self.currentstate))
    return self.currentstate[0];
  else {}
}