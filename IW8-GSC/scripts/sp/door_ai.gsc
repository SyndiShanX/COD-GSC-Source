/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\door_ai.gsc
***********************************************/

function get_closed_door_closest_to_nav_modifier(var0) {
  var1 = scripts\sp\door::get_all_doors_ai_should_open();

  if(var1.size > 0) {
    var1 = sortbydistance(var1, var0);
    var2 = distancesquared(var0, var1[0].origin);

    if(var2 < 5041) {
      return var1[0];
    }

    return;
  }
}

function door_manage_openers() {
  self endon("entitydeleted");
  self notify("new_door_opener");
  self endon("new_door_opener");
  var0 = scripts\sp\door_internal::get_door_center();
  var1 = (randomfloat(1), randomfloat(1), randomfloat(1));
  var2 = 72;

  for(;;) {
    if(scripts\sp\door_internal::door_is_at_max_yaw(1) || !self.active) {
      return;
    }

    self.openers = scripts\engine\utility::array_removedead_or_dying(self.openers);

    if(!self.openers.size) {
      return;
    }

    self.openers = sortbydistance(self.openers, self.origin);
    var3 = self.openers[0];
    var4 = distance2d(var0, var3.origin);
    var5 = 110;

    if(var3 aigettargetspeed() > 90) {
      var5 = 180;
    }

    if(var4 <= var5 && abs(var0[2] - var3.origin[2]) < var2 && !self.breached && length2dsquared(var3.velocity) > 0) {
      if(!isDefined(self.tryingopener) || self.opener == var3 && !isDefined(var3._blackboard.doortoopen)) {
        if(isDefined(var3 getmodifierlocationonpath("door", var5 + 50))) {
          thread door_manager_try_ai_opener(var3);
        }
      }
    }

    foreach(var7 in self.openers) {
      if(var7 == var3 && !self.breached) {
        if(isDefined(var7.waitingfordoor)) {
          stop_waiting_for_door(var7);
        }
      }
    }

    waitframe();
  }
}

function door_manager_try_ai_opener(var0) {
  if(istrue(self.lockedforai)) {
    return;
  }

  self.tryingopener = 1;
  var1 = ai_open_try_animated(var0, self);

  if(!istrue(var1)) {
    scripts\engine\sp\utility::array_notify(self.openers, "reset_door_check");
    self.tryingopener = undefined;
    return;
  }
}

function ai_open_try_animated(var0) {
  self endon("death");
  var0 endon("entitydeleted");
  var0 notify("unusable");

  if(isDefined(self.waitingfordoor)) {
    stop_waiting_for_door();
  }

  var0.opener = self;
  self._blackboard.doortoopen = var0;
  var1 = scripts\engine\utility::waittill_notify_or_timeout_return("opening_door", 6);
  var2 = var1 != "timeout";

  if(var2) {
    var0 thread scripts\sp\door::remove_open_ability();
    scripts\engine\utility::waittill_notify_or_timeout("opening_door_done", 4);
  }

  if(isDefined(self._blackboard.doortoopen) && self._blackboard.doortoopen == var0) {
    self._blackboard.doortoopen = undefined;
    self.isopeningdoor = undefined;
  }

  return var2;
}

function door_add_opener(var0) {
  if(isDefined(self.currentdoor) && self.currentdoor != var0) {
    self.currentdoor.openers = scripts\engine\utility::array_remove(self.currentdoor.openers, self);
  }

  self.currentdoor = var0;
  var0.openers[var0.openers.size] = self;
  thread door_speed_modifier_monitor();
}

function remove_as_opener() {
  if(isDefined(self.currentdoor)) {
    self.currentdoor.openers = scripts\engine\utility::array_remove(self.currentdoor.openers, self);
    self.currentdoor = undefined;
  }

  self notify("add_door_speed_monitor");
  remove_door_speed_modifiers();
}

function add_door_speed_modifiers() {
  var0 = self aigetdesiredspeed();
  self.saveddoorspeed = var0;
  var1 = 0.15;
  var2 = max(0.5, 1 - var1 * self.currentdoor.openers.size);
  var3 = var0 * var2;
  self aisetdesiredspeed(var3);
  self.old_doavoidanceblocking = self.doavoidanceblocking;
  self.doavoidanceblocking = 0;
}

function door_speed_modifier_monitor() {
  self endon("death");
  self notify("add_door_speed_monitor");
  self endon("add_door_speed_monitor");
  var0 = 160000;
  var1 = self.currentdoor.origin;
  var2 = anglesToForward(self.currentdoor.angles);
  remove_door_speed_modifiers();

  for(;;) {
    if(lengthsquared(self.origin - var1) < var0) {
      break;
    }

    waitframe();
  }

  if(!isDefined(self.currentdoor)) {
    return;
  }

  if(self.currentdoor.openers.size > 1) {
    add_door_speed_modifiers();
  }

  var3 = gettime() + 5000;
  var4 = vectorNormalize(var1 - self.origin);
  var5 = vectordot(var2, var4) > 0;

  for(;;) {
    var6 = vectorNormalize(var1 - self.origin);
    var7 = vectordot(var2, var6) > 0;

    if(var7 != var5) {
      break;
    }

    if(gettime() > var3) {
      break;
    }

    wait 0.1;
  }

  remove_door_speed_modifiers();
}

function remove_door_speed_modifiers() {
  if(isDefined(self.saveddoorspeed)) {
    self aisetdesiredspeed(self.saveddoorspeed);
    self.saveddoorspeed = undefined;
  }

  if(isDefined(self.old_doavoidanceblocking)) {
    self.doavoidanceblocking = self.old_doavoidanceblocking;
    self.old_doavoidanceblocking = undefined;
    return;
  }
}

function stop_waiting_for_door() {
  self.waitingfordoor = undefined;
}

function draw_node_line(var0, var1, var2) {
  self endon("death");
  var3 = gettime() + var1 * 1000;

  while(gettime() < var3) {
    wait 0.05;
  }
}