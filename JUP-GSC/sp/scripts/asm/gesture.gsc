/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\gesture.gsc
***********************************************/



#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace gesture;

function ai_request_gesture(gesture, target_obj, timeout_ms, notify_name) {
  if(!isDefined(timeout_ms)) {
    timeout_ms = 1000;
  }

  ai_request_gesture_internal(gesture, target_obj, timeout_ms, notify_name);
}

function ai_cancel_gesture() {
  if(!isDefined(self._blackboard.gesturerequest)) {
    return;
  }

  if(isDefined(self._blackboard.gesturerequest.notifyname)) {
    self notify(self._blackboard.gesturerequest.notifyname, "gesture_cancel");
  }

  self._blackboard.gesturerequest = undefined;
}

function handlegesturenotetrack(flagname) {
  self waittill(flagname, notes);

  if(!isDefined(notes)) {
    notes = ["undefined"];
  }

  if(!isarray(notes)) {
    notes = [notes];
  }

  assert(isDefined(self.fnasm_handlenotetrack));
  defined_val = undefined;

  foreach(note in notes) {
    if(note == "start_gundown") {
      self.gunposeoverride_internal = undefined;

      if(getdvarint(@ "hash_7528066c9678d0a0", 0) == 1) {
        print3d(self.origin + (0, 0, 60), "<dev string:x1c>", (1, 1, 1), 1, 0.5, 20);
      }

      continue;
    } else if(note == "finish_early") {
      if(getdvarint(@ "hash_7528066c9678d0a0", 0) == 1) {
        print3d(self.origin + (0, 0, 52), "<dev string:x2a>", (1, 1, 1), 1, 0.5, 20);
      }

      self._blackboard.partialgestureplaying = 0;
      continue;
    } else {
      val = [[self.fnasm_handlenotetrack]](note, flagname);
    }

    if(isDefined(val)) {
      defined_val = val;
    }
  }

  return defined_val;
}

function gesturedonotetracks(animlength) {
  self endon("gesture_timeout");
  thread gesturenotetracktimeoutthread(animlength);

  for(;;) {
    val = handlegesturenotetrack("gesture");

    if(isDefined(val)) {
      return val;
    }
  }

  self notify("gesture_finished");
}

function gesturenotetracktimeoutthread(timeout_sec) {
  self endon("gesture_finished");
  wait timeout_sec;
  self notify("gesture_timeout");
}

function gesture(asmname) {
  self endon("asm_terminated");
  self endon("death");
  assertex(!isDefined(self._blackboard.gesturerequest), "Gesture requested before gesture service started");

  while(true) {
    if(!isDefined(self._blackboard.gesturerequest)) {
      self waittill("gesture_requested");
    }

    assert(isDefined(self._blackboard.gesturerequest));

    while(true) {
      if(!isDefined(self._blackboard.gesturerequest)) {
        break;
      }

      if(self._blackboard.gesturerequest.timeoutms < gettime()) {
        ai_cancel_gesture();
        break;
      }

      if(scripts\asm\asm_bb::bb_moverequested()) {
        target_speed = self aigettargetspeed();

        if(!istrue(self.allowrunninggesture) && target_speed > 135) {
          wait 0.1;
          continue;
        }

        if(self pathdisttogoal() < target_speed * 2.5) {
          wait 0.1;
          continue;
        }
      }

      self._blackboard.gesturerequest.latestalias = get_gesture_alias(self._blackboard.gesturerequest.gesture, self._blackboard.gesturerequest.target);
      gesture_anim = self aiplaygesture(self._blackboard.gesturerequest.latestalias);

      if(!isDefined(gesture_anim)) {
        wait 0.1;
        continue;
      }

      if(getdvarint(@ "hash_7528066c9678d0a0", 0) == 1) {
        anim_length = getanimlength(gesture_anim);
        print3d(self.origin + (0, 0, 72), self._blackboard.gesturerequest.gesture + "<dev string:x37>", (1, 1, 1), 1, 1, int(anim_length * 20));
      }

      self.gunposeoverride_internal = "disable";
      self.baimedataimtarget = 0;

      if(self._blackboard.gesturerequest.disablelookat) {
        self.disableautolookat = 1;
        self stoplookat();
      }

      notify_name = self._blackboard.gesturerequest.notifyname;
      self._blackboard.gesturerequest = undefined;
      self._blackboard.partialgestureplaying = 1;
      gesturedonotetracks(getanimlength(gesture_anim));
      self._blackboard.partialgestureplaying = 0;

      if(isDefined(notify_name)) {
        self notify(notify_name, "gesture_finish");
        self asmfireephemeralevent("gesture", "end");
      }

      self.disableautolookat = 0;
      self.gunposeoverride_internal = undefined;
      self aicleargesture();
      wait 0.4;
    }
  }
}

function gesture_should_disable_lookat(gesture) {
  var_a0ac7796b5ece550 = ["casual_point", "military_point", "beckon", "nvg_on", "nvg_off", "wrist_com_lower", "wrist_com_raise"];

  if(isDefined(self._blackboard.civilianfocuscurvalue) && gesture == "beckon") {
    return false;
  }

  if(array_contains(var_a0ac7796b5ece550, gesture)) {
    return true;
  }

  return false;
}

function ai_request_gesture_internal(gesture, target_object, timeout_ms, notify_name) {
  if(isDefined(self._blackboard.gesturerequest)) {
    ai_cancel_gesture();
  }

  if(getdvarint(@ "hash_7528066c9678d0a0", 0) == 1) {
    print3d(self.origin + (0, 0, 84), gesture + "<dev string:x40>", (1, 1, 1), 1, 1, int(timeout_ms / 50));
  }

  self._blackboard.gesturerequest = spawnStruct();
  self._blackboard.gesturerequest.gesture = gesture;
  self._blackboard.gesturerequest.target = target_object;
  self._blackboard.gesturerequest.timeoutms = gettime() + timeout_ms;
  self._blackboard.gesturerequest.notifyname = notify_name;
  self._blackboard.gesturerequest.disablelookat = gesture_should_disable_lookat(gesture);
  self notify("gesture_requested");
}

function civisfocusingleft() {
  return self._blackboard.civilianfocusstate == 3;
}

function civisfocusingright() {
  return self._blackboard.civilianfocusstate == 4;
}

function get_gesture_alias(gesture, gesture_target) {
  if(isDefined(self._blackboard.civilianfocuscurvalue)) {
    if(gesture == "beckon") {
      var_34df158b62b8d82 = randomint(3) + 1;

      if(civisfocusingleft()) {
        gesture = gesture + "_" + var_34df158b62b8d82 + "_l";
      } else if(civisfocusingright()) {
        gesture = gesture + "_" + var_34df158b62b8d82 + "_r";
      }
    } else if(gesture == "glance") {
      var_34df158b62b8d82 = randomint(2) + 1;

      if(civisfocusingleft()) {
        gesture = gesture + "_" + var_34df158b62b8d82 + "_l";
      } else if(civisfocusingright()) {
        gesture = gesture + "_" + var_34df158b62b8d82 + "_r";
      }
    }
  }

  if(isDefined(gesture_target) && (gesture == "casual_point" || gesture == "military_point" || gesture == "beckon" || gesture == "stop" || gesture == "look" || gesture == "hide")) {
    if(isvector(gesture_target)) {
      targetorigin = gesture_target;
    } else {
      targetorigin = gesture_target.origin;
    }

    yawtotarget = vectortoyaw(targetorigin - self.origin);
    anglediff = angleclamp180(yawtotarget - self.angles[1]);
    angleindex = getangleindex(anglediff, 22.5);
    angleindex = scripts\asm\shared\utility::mapangleindextonumpad(angleindex);
    return (gesture + angleindex);
  }

  return gesture;
}

function ai_finish_gesture() {
  assert(isDefined(self._blackboard.gesturerequest));

  if(isDefined(self._blackboard.gesturerequest.notifyname)) {
    self notify(self._blackboard.gesturerequest.notifyname, "gesture_finished");
  }

  self._blackboard.gesturerequest = undefined;
}

function chooseanim_gesture(asmname, statename, params) {
  assert(isDefined(self._blackboard.gesturerequest));
  gesture_anim = asm_lookupanimfromalias(statename, self._blackboard.gesturerequest.latestalias);
  assert(isDefined(gesture_anim));
  return gesture_anim;
}

function playcoveranim_gesture(asmname, statename, params) {
  self endon(statename + "_finished");
  self._blackboard.activegesturenotify = self._blackboard.gesturerequest.notifyname;
  self setuseanimgoalweight(0.2);
  myanim = asm_getanim(asmname, statename);
  myxanim = asm_getxanim(statename, myanim);
  self orientmode("face current");

  if(asm_currentstatehasflag(asmname, "notetrackAim")) {
    angledelta = getangledelta(myxanim, 0, 1);
    self.stepoutyaw = self.angles[1] + angledelta;
  }

  if(getdvarint(@ "hash_7528066c9678d0a0", 0) == 1) {
    print3d(self.origin + (0, 0, 72), self._blackboard.gesturerequest.gesture + "<dev string:x37>", (1, 1, 1), 1, 1, 80);
  }

  self._blackboard.gesturerequest = undefined;
  self aisetanim(statename, myanim);
  asm_playfacialanim(asmname, statename, myxanim);
  asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename));
  self orientmode("face current");

  if(isDefined(self._blackboard.activegesturenotify)) {
    self notify(self._blackboard.activegesturenotify, "gesture_finished");
    self._blackboard.activegesturenotify = undefined;
  }
}

function cleargestureanim(asmname, statename, params) {
  if(isDefined(self._blackboard.activegesturenotify)) {
    self notify(self._blackboard.activegesturenotify, "gesture_cancel");
    self._blackboard.activegesturenotify = undefined;
  }
}

function gesture_finishearly(asmname, statename, tostatename, gesture) {
  if(bb_moverequested() && istrue(self.gestureinterruptible)) {
    if(isDefined(self.gestureinterruptibleifplayerwithindist)) {
      if(distancesquared(self.origin, level.player.origin) < self.gestureinterruptibleifplayerwithindist * self.gestureinterruptibleifplayerwithindist) {
        self asmfireephemeralevent("gesture", "end");
        return true;
      }
    } else {
      self asmfireephemeralevent("gesture", "end");
      return true;
    }
  }

  if(asm_eventfired(asmname, "finish_early") && bb_moverequested()) {
    self asmfireephemeralevent("gesture", "end");
  }

  return asm_eventfired(asmname, "finish_early") && bb_moverequested();
}