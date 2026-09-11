/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\trigger.gsc
***********************************************/

function triggerutilityinit() {
  var0 = getEntArray("trigger_multiple_mp_enterexit", "classname");

  foreach(var2 in var0) {
    makeenterexittrigger(var2);
  }
}

function makeenterexittrigger(var0, var1, var2, var3, var4, var5) {
  thread triggerenterthink(var0, var1, var2, var3, var4);
}

function triggerenterthink(var0, var1, var2, var3, var4) {
  level endon("game_ended");
  self endon("death");
  self.triggerenterents = [];
  self.triggerinsidetimes = [];
  thread triggerexitthink(var1, var3);

  for(;;) {
    self waittill("trigger", var5);

    if(isDefined(var4) && [[var4]](var5, self)) {
      continue;
    }

    var6 = var5 getentitynumber();

    if(!isDefined(self.triggerenterents[var6])) {
      self notify("trigger_enter", var5);

      if(isDefined(var0)) {
        var5 thread[[var0]](var5, self);
      }

      if(isDefined(var2)) {
        var5 notify(var2, self);
      }

      self.triggerenterents[var6] = var5;
      self.triggerinsidetimes[var6] = gettime();
      continue;
    }

    self.triggerinsidetimes[var6] = gettime();
  }
}

function triggerexitthink(var0, var1) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    waittillframeend();
    var2 = gettime();

    foreach(var5, var4 in self.triggerenterents) {
      if(!isDefined(var4)) {
        self.triggerenterents[var5] = undefined;
        self.triggerinsidetimes[var5] = undefined;
        continue;
      }

      if(self.triggerinsidetimes[var5] < var2) {
        self notify("trigger_exit", var4);

        if(isDefined(var0)) {
          var4 thread[[var0]](var4, self);
        }

        if(isDefined(var1)) {
          var4 notify(var1, self);
        }

        self.triggerenterents[var5] = undefined;
        self.triggerinsidetimes[var5] = undefined;
      }
    }

    waitframe();
  }
}