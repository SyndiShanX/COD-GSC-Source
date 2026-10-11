/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\utility\trigger.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\interaction;
#using scripts\engine\utility;
#namespace trigger;

function triggerutilityinit() {
  var_559b1c2dc581f10c = getEntArray("trigger_multiple_mp_enterexit", "classname");

  foreach(trigger in var_559b1c2dc581f10c) {
    makeenterexittrigger(trigger);
  }
}

function makeenterexittrigger(trigger, enterfunc, exitfunc, var_1fa4e076aba70ab9, var_768b0479668f27b, filterfunc) {
  trigger thread triggerenterthink(enterfunc, exitfunc, var_1fa4e076aba70ab9, var_768b0479668f27b, filterfunc);
}

function triggerenterthink(enterfunc, exitfunc, var_1fa4e076aba70ab9, var_768b0479668f27b, filterfunc) {
  level endon("game_ended");
  self endon("death");
  self.triggerenterents = [];
  self.triggerinsidetimes = [];
  thread triggerexitthink(exitfunc, var_768b0479668f27b);

  while(true) {
    self waittill("trigger", triggeringent);

    if(isDefined(filterfunc) && [[filterfunc]](triggeringent, self)) {
      continue;
    }

    var_6b6f0d5308b1ceab = triggeringent getentitynumber();

    if(!isDefined(self.triggerenterents[var_6b6f0d5308b1ceab])) {
      self notify("trigger_enter", triggeringent);

      if(isDefined(enterfunc)) {
        triggeringent thread[[enterfunc]](triggeringent, self);
      }

      if(isDefined(var_1fa4e076aba70ab9)) {
        triggeringent notify(var_1fa4e076aba70ab9, self);
      }

      self.triggerenterents[var_6b6f0d5308b1ceab] = triggeringent;
      self.triggerinsidetimes[var_6b6f0d5308b1ceab] = gettime();
    } else {
      self.triggerinsidetimes[var_6b6f0d5308b1ceab] = gettime();
    }

    assert(self.triggerenterents.size == self.triggerinsidetimes.size);
  }
}

function triggerexitthink(exitfunc, var_768b0479668f27b) {
  level endon("game_ended");
  self endon("death");

  while(true) {
    waittillframeend();
    assert(self.triggerenterents.size == self.triggerinsidetimes.size);
    var_291148d7c3e8d5e3 = gettime();

    foreach(entid, ent in self.triggerenterents) {
      if(!isDefined(ent)) {
        self.triggerenterents[entid] = undefined;
        self.triggerinsidetimes[entid] = undefined;
        continue;
      }

      assert(isDefined(self.triggerinsidetimes[entid]));

      if(self.triggerinsidetimes[entid] < var_291148d7c3e8d5e3) {
        self notify("trigger_exit", ent);

        if(isDefined(exitfunc)) {
          ent thread[[exitfunc]](ent, self);
        }

        if(isDefined(var_768b0479668f27b)) {
          ent notify(var_768b0479668f27b, self);
        }

        self.triggerenterents[entid] = undefined;
        self.triggerinsidetimes[entid] = undefined;
      }
    }

    waitframe();
  }
}

function function_d7f524cd920e0c79() {
  flag_wait("StartGameTypeCallbackFinished");
  waitframe();
  var_c85c96521b9fa174 = getEntArray("gesture_trigger", "script_noteworthy");

  if(!isDefined(var_c85c96521b9fa174)) {
    return;
  }

  foreach(gesture_trigger in var_c85c96521b9fa174) {
    function_32645103f7520635(gesture_trigger, undefined, undefined, &function_81b4c641c1611463);
  }
}

function function_643debdd070d5477(var_6001320cbfd4d138) {
  if(!isDefined(var_6001320cbfd4d138)) {
    return;
  }

  self giveandfireoffhand(makeweapon(var_6001320cbfd4d138));
}

function function_81b4c641c1611463(player) {
  grenadename = "";

  if(isDefined(self.targetname)) {
    grenadename = self.targetname;
  }

  player function_643debdd070d5477(grenadename);
}