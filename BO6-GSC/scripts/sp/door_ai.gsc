/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\door_ai.gsc
**************************************/

#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\debug;
#using scripts\sp\door;
#using scripts\sp\door_internal;
#namespace door_ai;

function function_edcd03574c63e911(pos, range) {
  if(!isDefined(range)) {
    range = 71;
  }

  doors = [];

  foreach(door in level.interactive_doors.ents) {
    if(!door utility::ent_flag("-\xb9\x96\xd1ZX\x1b\xd2\xf4Vd")) {
      continue;
    }

    doors[doors.size] = door;
  }

  doors = sortbydistance(doors, pos);
  distsqrd = distancesquared(pos, doors[0].origin);

  if(distsqrd < range * range) {
    return doors[0];
  }
}

function get_closed_door_closest_to_nav_modifier(pos) {
  doors = door_sp::get_all_doors_ai_should_open();

  if(doors.size > 0) {
    doors = sortbydistance(doors, pos);
    distsqrd = distancesquared(pos, doors[0].origin);

    if(distsqrd < 5041) {
      return doors[0];
    }
  }
}

function door_manage_openers() {
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  self notify(".\x9a\x97\xdd\xc54\x8f%\xbb\xfd.\xe3\xfa{\xc8");
  self endon(".\x9a\x97\xdd\xc54\x8f%\xbb\xfd.\xe3\xfa{\xc8");
  mycenter = door_internal::get_door_center();
  var_1c1a2953c0f56f4a = (randomfloat(1), randomfloat(1), randomfloat(1));
  var_49077ef58f38d09b = 72;

  while(true) {
    if(door_internal::door_is_at_max_yaw(1) || !self.active) {
      return;
    }

    self.openers = utility::array_removedead_or_dying(self.openers);

    if(!self.openers.size) {
      return;
    }

    self.openers = sortbydistance(self.openers, self.origin);
    opener = self.openers[0];

    if(getdvarint(@ "hash_e4715899ce74d8ee")) {
      thread function_965489e11c7bde7d(var_1c1a2953c0f56f4a);
    }

    closestdist = distance2d(mycenter, opener.origin);
    dooropendist = 110;

    if(opener aigettargetspeed() > 90) {
      dooropendist = 230;
    }

    if(closestdist <= dooropendist && abs(mycenter[2] - opener.origin[2]) < var_49077ef58f38d09b && !self.breached && length2dsquared(opener.velocity) > 0) {
      if(!isDefined(self.tryingopener) || self.opener == opener && !isDefined(opener._blackboard.doortoopen)) {
        if(isDefined(opener getmodifierlocationonpath("\xe2\xc0Qo", dooropendist + 50))) {
          thread door_manager_try_ai_opener(opener);
        }
      }
    }

    foreach(guy in self.openers) {
      if(guy == opener && !self.breached) {
        if(isDefined(guy.waitingfordoor)) {
          guy stop_waiting_for_door();
        }
      }
    }

    waitframe();
  }
}

function door_manager_try_ai_opener(opener) {
  if(istrue(self.lockedforai)) {
    return;
  }

  self.tryingopener = 1;
  result = opener ai_open_try_animated(self);

  if(!istrue(result)) {
    utility_sp::array_notify(self.openers, "pQ\xcf\x05r\xe1<\xb7\xf7\xc4c\x1f\x952Oj");
    self.tryingopener = undefined;
    return;
  }
}

function function_965489e11c7bde7d(var_1c1a2953c0f56f4a) {
  foreach(g in self.openers) {
    line(self.origin, g getEye(), var_1c1a2953c0f56f4a, 1, 0, 1);

    if(i == 0) {
      self notify("<dev string:x24>", "<dev string:x32>" + self.doorid);
    }
  }
}

function ai_open_try_animated(door) {
  self endon("\x1e\xfd\xd1\xa2\a");
  door endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  door notify("\x83\xa2\x0f\x16\b%>\xb0");

  if(isDefined(self.waitingfordoor)) {
    stop_waiting_for_door();
  }

  door.opener = self;
  self._blackboard.doortoopen = door;
  result = utility::waittill_notify_or_timeout_return("\xe2$\xb4W\x14\xdc\xb3HF\xd7o\a", 6);
  bsuccess = result != "\xb5B\xd7\x904}\x11";

  if(bsuccess) {
    door thread door_sp::remove_open_ability();
    utility::waittill_notify_or_timeout("R\x1f\xa8\xd6\x01\xc0\xf0T\x95\xa4\xb6\xd9]\xf8\xe4\\\x02", 4);
  }

  if(isDefined(self._blackboard.doortoopen) && self._blackboard.doortoopen == door) {
    self._blackboard.doortoopen = undefined;
    self.isopeningdoor = 0;
  }

  return bsuccess;
}

function function_556e49a602b7c736(scene) {
  time = 2;
  num = time * 20;

  for(count = 0; count < num; count++) {
    thread debug::draw_node(scene.origin, scene.angles, (1, 1, 1), 16, 1, 0);
    wait 0.05;
  }
}

function door_add_opener(door) {
  if(isDefined(self.currentdoor) && self.currentdoor != door) {
    self.currentdoor.openers = arrayremove(self.currentdoor.openers, self);
  }

  self.currentdoor = door;
  door.openers[door.openers.size] = self;
  thread door_speed_modifier_monitor();
}

function remove_as_opener() {
  if(isDefined(self.currentdoor)) {
    self.currentdoor.openers = arrayremove(self.currentdoor.openers, self);
    self.currentdoor = undefined;
    self notify("\xdc\xf3\xe7d\xad\x9e\xdc#\xa6\x9a9\x17NA\x12\xf9\x7f\xa9\xbb\xfd}\v");
    remove_door_speed_modifiers();
  }
}

function add_door_speed_modifiers() {
  currentspeed = self aigetdesiredspeed();
  self.saveddoorspeed = currentspeed;
  basemultiplier = 0.15;
  currentmultiplier = max(0.5, 1 - basemultiplier * self.currentdoor.openers.size);
  newspeed = currentspeed * currentmultiplier;
  self aisetdesiredspeed(newspeed);
  self.old_doavoidanceblocking = self.doavoidanceblocking;
  self.doavoidanceblocking = 0;
}

function door_speed_modifier_monitor() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("\xdc\xf3\xe7d\xad\x9e\xdc#\xa6\x9a9\x17NA\x12\xf9\x7f\xa9\xbb\xfd}\v");
  self endon("\xdc\xf3\xe7d\xad\x9e\xdc#\xa6\x9a9\x17NA\x12\xf9\x7f\xa9\xbb\xfd}\v");
  mindistance = 160000;
  doorposition = self.currentdoor.origin;
  doorforward = anglesToForward(self.currentdoor.angles);
  remove_door_speed_modifiers();

  while(true) {
    if(lengthsquared(self.origin - doorposition) < mindistance) {
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

  timeout = gettime() + 5000;
  var_bbbbb4465081c703 = vectorNormalize(doorposition - self.origin);
  var_e7039fc524599f1f = vectordot(doorforward, var_bbbbb4465081c703) > 0;

  while(true) {
    var_4097cccb56853bd8 = vectorNormalize(doorposition - self.origin);
    var_d27f32d1348ddbe0 = vectordot(doorforward, var_4097cccb56853bd8) > 0;

    if(var_d27f32d1348ddbe0 != var_e7039fc524599f1f) {
      break;
    }

    if(gettime() > timeout) {
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
  }
}

function stop_waiting_for_door() {
  self notify("<dev string:x46>");

  self.waitingfordoor = undefined;
}

function draw_node_line(node, time, color) {
  self endon("<dev string:x5f>");
  timer = gettime() + time * 1000;

  while(gettime() < timer) {
    line(self getEye(), node.origin, color, 0.5, 0, 1);
    wait 0.05;
  }
}

function function_80260d52e7e24ff0() {
  self endon("<dev string:x5f>");
  oldmsg = "<dev string:x68>";
  newmsg = "<dev string:x68>";

  while(true) {
    self waittill("<dev string:x24>", msg);
    newmsg = msg;
    childthread update_debug(newmsg, oldmsg);
    oldmsg = newmsg;
  }
}

function update_debug(newmsg, oldmsg) {
  self notify("<dev string:x6c>");
  self endon("<dev string:x6c>");
  oldmsgalpha = 1;
  displaytime = 5;
  steps = displaytime * 20;
  var_71d7da51c6f68d6f = oldmsgalpha / steps;
  time = gettime();

  while(gettime() < time + displaytime * 1000) {
    if(getdvarint(@ "hash_e4715899ce74d8ee")) {
      print3d(self getEye() + (0, 0, 15), newmsg, (1, 1, 1), 1, 0.3, 1);
      print3d(self getEye() + (0, 0, 10), oldmsg, (0.7, 0.7, 0.7), oldmsgalpha, 0.3, 1);
    }

    oldmsgalpha -= var_71d7da51c6f68d6f;
    wait 0.05;
  }
}

# /