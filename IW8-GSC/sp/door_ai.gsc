/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\door_ai.gsc
***********************************************/

get_closed_door_closest_to_nav_modifier(var_0) {
  var_1 = scripts\sp\door::get_all_doors_ai_should_open();

  if(var_1.size > 0) {
    var_1 = sortbydistance(var_1, var_0);
    var_2 = distancesquared(var_0, var_1[0].origin);

    if(var_2 < 5041)
      return var_1[0];
  }
}

door_manage_openers() {
  self endon("entitydeleted");
  self notify("new_door_opener");
  self endon("new_door_opener");
  var_0 = scripts\sp\door_internal::get_door_center();
  var_1 = (randomfloat(1), randomfloat(1), randomfloat(1));
  var_2 = 72;

  for(;;) {
    if(scripts\sp\door_internal::door_is_at_max_yaw(1) || !self.active) {
      return;
    }
    self.openers = scripts\engine\utility::array_removedead_or_dying(self.openers);

    if(!self.openers.size) {
      return;
    }
    self.openers = sortbydistance(self.openers, self.origin);
    var_3 = self.openers[0];
    var_4 = distance2d(var_0, var_3.origin);
    var_5 = 110;

    if(var_3 aigettargetspeed() > 90)
      var_5 = 180;

    if(var_4 <= var_5 && abs(var_0[2] - var_3.origin[2]) < var_2 && !self.breached && length2dsquared(var_3.velocity) > 0) {
      if(!isDefined(self.tryingopener) || self.opener == var_3 && !isDefined(var_3._blackboard.doortoopen)) {
        if(isDefined(var_3 getmodifierlocationonpath("door", var_5 + 50)))
          thread door_manager_try_ai_opener(var_3);
      }
    }

    foreach(var_7 in self.openers) {
      if(var_7 == var_3 && !self.breached) {
        if(isDefined(var_7.waitingfordoor))
          var_7 stop_waiting_for_door();

        continue;
      }
    }

    waitframe();
  }
}

door_manager_try_ai_opener(var_0) {
  if(istrue(self.lockedforai)) {
    return;
  }
  self.tryingopener = 1;
  var_1 = var_0 ai_open_try_animated(self);

  if(!istrue(var_1)) {
    scripts\engine\sp\utility::array_notify(self.openers, "reset_door_check");
    self.tryingopener = undefined;
    return;
  }
}

ai_open_try_animated(var_0) {
  self endon("death");
  var_0 endon("entitydeleted");
  var_0 notify("unusable");

  if(isDefined(self.waitingfordoor))
    stop_waiting_for_door();

  var_0.opener = self;
  self._blackboard.doortoopen = var_0;
  var_1 = scripts\engine\utility::waittill_notify_or_timeout_return("opening_door", 6);
  var_2 = var_1 != "timeout";

  if(var_2) {
    var_0 thread scripts\sp\door::remove_open_ability();
    scripts\engine\utility::waittill_notify_or_timeout("opening_door_done", 4);
  }

  if(isDefined(self._blackboard.doortoopen) && self._blackboard.doortoopen == var_0) {
    self._blackboard.doortoopen = undefined;
    self.isopeningdoor = undefined;
  }

  return var_2;
}

door_add_opener(var_0) {
  if(isDefined(self.currentdoor) && self.currentdoor != var_0)
    self.currentdoor.openers = scripts\engine\utility::array_remove(self.currentdoor.openers, self);

  self.currentdoor = var_0;
  var_0.openers[var_0.openers.size] = self;
  thread door_speed_modifier_monitor();
}

remove_as_opener() {
  if(isDefined(self.currentdoor)) {
    self.currentdoor.openers = scripts\engine\utility::array_remove(self.currentdoor.openers, self);
    self.currentdoor = undefined;
  }

  self notify("add_door_speed_monitor");
  remove_door_speed_modifiers();
}

add_door_speed_modifiers() {
  var_0 = self aigetdesiredspeed();
  self.saveddoorspeed = var_0;
  var_1 = 0.15;
  var_2 = max(0.5, 1 - var_1 * self.currentdoor.openers.size);
  var_3 = var_0 * var_2;
  self aisetdesiredspeed(var_3);
  self.old_doavoidanceblocking = self.doavoidanceblocking;
  self.doavoidanceblocking = 0;
}

door_speed_modifier_monitor() {
  self endon("death");
  self notify("add_door_speed_monitor");
  self endon("add_door_speed_monitor");
  var_0 = 160000;
  var_1 = self.currentdoor.origin;
  var_2 = anglesToForward(self.currentdoor.angles);
  remove_door_speed_modifiers();

  for(;;) {
    if(lengthsquared(self.origin - var_1) < var_0) {
      break;
    }

    waitframe();
  }

  if(!isDefined(self.currentdoor)) {
    return;
  }
  if(self.currentdoor.openers.size > 1)
    add_door_speed_modifiers();

  var_3 = gettime() + 5000;
  var_4 = vectorNormalize(var_1 - self.origin);
  var_5 = vectordot(var_2, var_4) > 0;

  for(;;) {
    var_6 = vectorNormalize(var_1 - self.origin);
    var_7 = vectordot(var_2, var_6) > 0;

    if(var_7 != var_5) {
      break;
    }

    if(gettime() > var_3) {
      break;
    }

    wait 0.1;
  }

  remove_door_speed_modifiers();
}

remove_door_speed_modifiers() {
  if(isDefined(self.saveddoorspeed)) {
    self aisetdesiredspeed(self.saveddoorspeed);
    self.saveddoorspeed = undefined;
  }

  if(isDefined(self.old_doavoidanceblocking)) {
    self.doavoidanceblocking = self.old_doavoidanceblocking;
    self.old_doavoidanceblocking = undefined;
  }
}

stop_waiting_for_door() {
  self.waitingfordoor = undefined;
}

draw_node_line(var_0, var_1, var_2) {
  self endon("death");
  var_3 = gettime() + var_1 * 1000;

  while(gettime() < var_3)
    wait 0.05;
}