/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\statemachine.gsc
***********************************************/

function begin_fsm(var0, var1) {
  self.previousstate = undefined;
  self.currentstate = undefined;
  self.permanentnotifyhandlers = undefined;
  self.currentnotifyhandlers = undefined;
  self.states = var0;

  if(isDefined(var1)) {
    self.initialstate = var1;
  } else if(isDefined(self.states[0][0])) {
    self.initialstate = self.states[0][0];
  }

  goto_state(self.initialstate);
}

function goto_state(var0) {
  thread perform_state_change(var0);
}

function perform_state_change(var0) {
  var1 = get_state(var0);

  if(isDefined(var1)) {
    if(isDefined(self.currentstate)) {
      self.previousstate = self.currentstate;
    }

    self notify("changed_state");
    self.currentnotifyhandlers = [];

    if(isDefined(self.previousstate)) {
      if(isDefined(self.previousstate[3])) {
        var2 = self.previousstate[3];
        [[var2]]();
      }
    }

    self.currentstate = var1;

    if(isDefined(self.currentstate[1])) {
      var3 = self.currentstate[1];
      set_enter_function(var3);
    }

    if(isDefined(self.currentstate[2])) {
      var4 = self.currentstate[2];
      thread set_update_function(var4);
      return;
    }

    return;
  }
}

function goto_state_previous() {
  if(isDefined(self.previousstate)) {
    goto_state(self.previousstate[0]);
    return;
  }
}

function get_state(var0) {
  foreach(var2 in self.states) {
    if(var2[0] == var0) {
      return var2;
    }
  }

  return undefined;
}

function set_enter_function(var0) {
  self endon("death");
  self endon("changed_state");
  self thread[[var0]]();
}

function set_update_function(var0) {
  self endon("death");
  self endon("changed_state");

  for(;;) {
    [[var0]]();
    waitframe();
  }
}

function set_notify_handlers(var0) {
  self.currentnotifyhandlers = var0;

  foreach(var2 in var0) {
    var3 = -1;

    if(isDefined(var2[2])) {
      var3 = var2[2];
    }

    thread state_nofity_handler(var2[0], var2[1], var3);
  }
}

function set_permanent_notify_handlers(var0) {
  self.permanentnotifyhandlers = var0;

  foreach(var2 in var0) {
    var3 = -1;

    if(isDefined(var2[2])) {
      var3 = var2[2];
    }

    thread permanent_notify_handler(var2[0], var2[1], var3);
  }
}

function state_nofity_handler(var0, var1, var2) {
  self endon("death");
  self endon("changed_state");
  start_handler(var0, var1, var2);
}

function permanent_notify_handler(var0, var1, var2) {
  self endon("death");
  start_handler(var0, var1, var2);
}

function start_handler(var0, var1, var2) {
  self notify("new_handler");

  for(var3 = 1; var3; var3 = 0) {
    self waittill(var0, var4);

    if(isDefined(var4)) {
      [[var1]](var4);
    } else {
      [[var1]]();
    }

    if(var2 >= 0) {
      var2--;

      if(var2 == 0) {}
    }
  }
}

function get_current_state() {
  if(isDefined(self.currentstate)) {
    return self.currentstate[0];
  }
}