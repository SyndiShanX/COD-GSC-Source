/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\trigger.gsc
***********************************************/

function triggerutilityinit() {
  var_0 = getEntArray("trigger_multiple_mp_enterexit", "classname");

  foreach(var_2 in var_0) {
    makeenterexittrigger(var_2);
  }
}

function makeenterexittrigger(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread triggerenterthink(var_0, var_1, var_2, var_3, var_4);
}

function triggerenterthink(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  self endon("death");
  self.triggerenterents = [];
  self.triggerinsidetimes = [];
  thread triggerexitthink(var_1, var_3);

  for(;;) {
    self waittill("trigger", var_5);

    if(isDefined(var_4) && [[var_4]](var_5, self)) {
      continue;
    }

    var_6 = var_5 getentitynumber();

    if(!isDefined(self.triggerenterents[var_6])) {
      self notify("trigger_enter", var_5);

      if(isDefined(var_0)) {
        var_5 thread[[var_0]](var_5, self);
      }

      if(isDefined(var_2)) {
        var_5 notify(var_2, self);
      }

      self.triggerenterents[var_6] = var_5;
      self.triggerinsidetimes[var_6] = gettime();
      continue;
    }

    self.triggerinsidetimes[var_6] = gettime();
  }
}

function triggerexitthink(var_0, var_1) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    waittillframeend();
    var_2 = gettime();

    foreach(var_5, var_4 in self.triggerenterents) {
      if(!isDefined(var_4)) {
        self.triggerenterents[var_5] = undefined;
        self.triggerinsidetimes[var_5] = undefined;
        continue;
      }

      if(self.triggerinsidetimes[var_5] < var_2) {
        self notify("trigger_exit", var_4);

        if(isDefined(var_0)) {
          var_4 thread[[var_0]](var_4, self);
        }

        if(isDefined(var_1)) {
          var_4 notify(var_1, self);
        }

        self.triggerenterents[var_5] = undefined;
        self.triggerinsidetimes[var_5] = undefined;
      }
    }

    waitframe();
  }
}