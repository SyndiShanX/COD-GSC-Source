/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\gesture.gsc
**************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
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
    self notify(self._blackboard.gesturerequest.notifyname, "\x97\xe9\x15\x96\x1d\xe5\x1b\f3,\xa5&\x90\xf8");
  }

  self._blackboard.gesturerequest = undefined;
}

function handlegesturenotetrack(flagname) {
  self waittill(flagname, notes);

  if(!isDefined(notes)) {
    notes = ["\xed\x1d\va\x1e\xf6\xe5\x88\x8a"];
  }

  if(!isarray(notes)) {
    notes = [notes];
  }

  assert(isDefined(self.fnasm_handlenotetrack));
  defined_val = undefined;

  foreach(note in notes) {
    if(note == "n\xe8a'\x8e\xfa\x9d\xba\xe6\x91\xedw\xb9") {
      self.gunposeoverride_internal = undefined;

      if(getdvarint(@ "hash_7528066c9678d0a0", 0) == 1) {
        print3d(self.origin + (0, 0, 60), "<dev string:x24>", (1, 1, 1), 1, 0.5, 20);
      }

      continue;
    } else if(note == "\x15 z\x02^6&\x15\x02\xec\v\xda") {
      if(getdvarint(@ "hash_7528066c9678d0a0", 0) == 1) {
        print3d(self.origin + (0, 0, 52), "<dev string:x35>", (1, 1, 1), 1, 0.5, 20);
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
  self endon("\xfd\x16\x7f\xbd\x9aa\x81^\xb8\xa0\x03\x1d\x9c\xf6-");
  thread gesturenotetracktimeoutthread(animlength);

  for(;;) {
    val = handlegesturenotetrack("\xd7\xd8\xae\xb6\x0ea\xab");

    if(isDefined(val)) {
      return val;
    }
  }

  self notify("VE\xdf\xea\x1eeb\xe0\x1ckn;\x03\xdb\xde\xd2");
}

function gesturenotetracktimeoutthread(timeout_sec) {
  self endon("VE\xdf\xea\x1eeb\xe0\x1ckn;\x03\xdb\xde\xd2");
  wait timeout_sec;
  self notify("\xfd\x16\x7f\xbd\x9aa\x81^\xb8\xa0\x03\x1d\x9c\xf6-");
}

function gesture(asmname) {
  self endon("&\xe3\x15\x1e\xb9|(01/}\xa1\x13O");
  self endon("\x1e\xfd\xd1\xa2\a");
  assert(!isDefined(self._blackboard.gesturerequest), "<dev string:x45>");

  while(true) {
    if(!isDefined(self._blackboard.gesturerequest)) {
      self waittill("\x04\x85SJu\x952\xdcK,\xad7\xe6\xd3\x875\x95");
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

      if(asm_bb::bb_moverequested()) {
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
        print3d(self.origin + (0, 0, 72), self._blackboard.gesturerequest.gesture + "<dev string:x79>", (1, 1, 1), 1, 1, int(anim_length * 20));
      }

      self.gunposeoverride_internal = "\xf5!\x81\xa3\x97E\x8d";
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
        self notify(notify_name, "\xc4\xc4Vbv\xf5&\xd8G<~UF\xb6");
        self asmfireephemeralevent("\xd7\xd8\xae\xb6\x0ea\xab", "8\xdb\x90");
      }

      self.disableautolookat = 0;
      self.gunposeoverride_internal = undefined;
      self aicleargesture();
      wait 0.4;
    }
  }
}

function gesture_should_disable_lookat(gesture) {
  var_36f53818abb7eab1 = ["\ad\xf0\xdd\xde\xb3\x0f\xdf\xe5@\x01\x9f", "\x13\ft_\x02t\x83\xf5\xcb\xd3\f\xe4\x9f\xc3", "\xf2l\x932\xadh", "\xef\xc2G\xa60\x15", "v\x11=\xedw\xab1", "\xe5\xf5\x03\x9d\xcb\x12fGcA\xac\x16#tQ", "\xec\xb7A\v\xbd[\x1b\x88\xec\xd4y\xc8m[\x86"];

  if(isDefined(self._blackboard.civilianfocuscurvalue) && gesture == "\xf2l\x932\xadh") {
    return false;
  }

  if(arraycontains(var_36f53818abb7eab1, gesture)) {
    return true;
  }

  return false;
}

function ai_request_gesture_internal(gesture, target_object, timeout_ms, notify_name) {
  if(isDefined(self._blackboard.gesturerequest)) {
    ai_cancel_gesture();
  }

  if(getdvarint(@ "hash_7528066c9678d0a0", 0) == 1) {
    print3d(self.origin + (0, 0, 84), gesture + "<dev string:x85>", (1, 1, 1), 1, 1, int(timeout_ms / 50));
  }

  self._blackboard.gesturerequest = spawnStruct();
  self._blackboard.gesturerequest.gesture = gesture;
  self._blackboard.gesturerequest.target = target_object;
  self._blackboard.gesturerequest.timeoutms = gettime() + timeout_ms;
  self._blackboard.gesturerequest.notifyname = notify_name;
  self._blackboard.gesturerequest.disablelookat = gesture_should_disable_lookat(gesture);
  self notify("\x04\x85SJu\x952\xdcK,\xad7\xe6\xd3\x875\x95");
}

function civisfocusingleft() {
  return self._blackboard.civilianfocusstate == 3;
}

function civisfocusingright() {
  return self._blackboard.civilianfocusstate == 4;
}

function get_gesture_alias(gesture, gesture_target) {
  if(isDefined(self._blackboard.civilianfocuscurvalue)) {
    if(gesture == "\xf2l\x932\xadh") {
      var_b43c5654cd6e525f = randomint(3) + 1;

      if(civisfocusingleft()) {
        gesture = gesture + "w" + var_b43c5654cd6e525f + "9\x02";
      } else if(civisfocusingright()) {
        gesture = gesture + "w" + var_b43c5654cd6e525f + "\a}";
      }
    } else if(gesture == "\xf9\x81\xa8\xbbe\r") {
      var_b43c5654cd6e525f = randomint(2) + 1;

      if(civisfocusingleft()) {
        gesture = gesture + "w" + var_b43c5654cd6e525f + "9\x02";
      } else if(civisfocusingright()) {
        gesture = gesture + "w" + var_b43c5654cd6e525f + "\a}";
      }
    }
  }

  if(isDefined(gesture_target) && (gesture == "\ad\xf0\xdd\xde\xb3\x0f\xdf\xe5@\x01\x9f" || gesture == "\x13\ft_\x02t\x83\xf5\xcb\xd3\f\xe4\x9f\xc3" || gesture == "\xf2l\x932\xadh" || gesture == "\x04M\xed\xab" || gesture == "\x96+\x88\xb1" || gesture == "\x19b\xc2y")) {
    if(isvector(gesture_target)) {
      targetorigin = gesture_target;
    } else {
      targetorigin = gesture_target.origin;
    }

    yawtotarget = vectortoyaw(targetorigin - self.origin);
    anglediff = angleclamp180(yawtotarget - self.angles[1]);
    angleindex = getangleindex(anglediff, 22.5);
    angleindex = utility::mapangleindextonumpad(angleindex);
    return (gesture + angleindex);
  }

  return gesture;
}

function ai_finish_gesture() {
  assert(isDefined(self._blackboard.gesturerequest));

  if(isDefined(self._blackboard.gesturerequest.notifyname)) {
    self notify(self._blackboard.gesturerequest.notifyname, "VE\xdf\xea\x1eeb\xe0\x1ckn;\x03\xdb\xde\xd2");
  }

  self._blackboard.gesturerequest = undefined;
}

function chooseanim_gesture(asmname, statename, params) {
  assert(isDefined(self._blackboard.gesturerequest));
  gesture_anim = asm::asm_lookupanimfromalias(statename, self._blackboard.gesturerequest.latestalias);
  assert(isDefined(gesture_anim));
  return gesture_anim;
}

function playcoveranim_gesture(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  self._blackboard.activegesturenotify = self._blackboard.gesturerequest.notifyname;
  self setuseanimgoalweight(0.2);
  myanim = asm::asm_getanim(asmname, statename);
  myxanim = asm::asm_getxanim(statename, myanim);
  self orientmode("\x99\xc2l\xb2\x806\xbaNN\x95\xb9\xa3");

  if(asm::asm_currentstatehasflag(asmname, "\x1e\x97\x86\xd0\xf5\xda\xaf\xf9\xdb\xb7\xc5'")) {
    angledelta = getangledelta(myxanim, 0, 1);
    self.stepoutyaw = self.angles[1] + angledelta;
  }

  if(getdvarint(@ "hash_7528066c9678d0a0", 0) == 1) {
    print3d(self.origin + (0, 0, 72), self._blackboard.gesturerequest.gesture + "<dev string:x79>", (1, 1, 1), 1, 1, 80);
  }

  self._blackboard.gesturerequest = undefined;
  self aisetanim(statename, myanim);
  asm::asm_playfacialanim(asmname, statename, myxanim);
  asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename));
  self orientmode("\x99\xc2l\xb2\x806\xbaNN\x95\xb9\xa3");

  if(isDefined(self._blackboard.activegesturenotify)) {
    self notify(self._blackboard.activegesturenotify, "VE\xdf\xea\x1eeb\xe0\x1ckn;\x03\xdb\xde\xd2");
    self._blackboard.activegesturenotify = undefined;
  }
}

function cleargestureanim(asmname, statename, params) {
  if(isDefined(self._blackboard.activegesturenotify)) {
    self notify(self._blackboard.activegesturenotify, "\x97\xe9\x15\x96\x1d\xe5\x1b\f3,\xa5&\x90\xf8");
    self._blackboard.activegesturenotify = undefined;
  }
}

function gesture_finishearly(asmname, statename, tostatename, gesture) {
  if(asm_bb::bb_moverequested() && istrue(self.gestureinterruptible)) {
    if(isDefined(self.gestureinterruptibleifplayerwithindist)) {
      if(distancesquared(self.origin, level.player.origin) < self.gestureinterruptibleifplayerwithindist * self.gestureinterruptibleifplayerwithindist) {
        self asmfireephemeralevent("\xd7\xd8\xae\xb6\x0ea\xab", "8\xdb\x90");
        return true;
      }
    } else {
      self asmfireephemeralevent("\xd7\xd8\xae\xb6\x0ea\xab", "8\xdb\x90");
      return true;
    }
  }

  if(asm::asm_eventfired(asmname, "\x15 z\x02^6&\x15\x02\xec\v\xda") && asm_bb::bb_moverequested()) {
    self asmfireephemeralevent("\xd7\xd8\xae\xb6\x0ea\xab", "8\xdb\x90");
  }

  return asm::asm_eventfired(asmname, "\x15 z\x02^6&\x15\x02\xec\v\xda") && asm_bb::bb_moverequested();
}