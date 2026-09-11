/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\gesture.gsc
***********************************************/

function ai_request_gesture(var0, var1, var2, var3) {
  if(!isDefined(var2)) {
    var2 = 1000;
  }

  ai_request_gesture_internal(var0, var1, var2, var3);
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

function handlegesturenotetrack(var0) {
  self waittill(var0, var1);

  if(!isDefined(var1)) {
    var1 = ["undefined"];
  }

  if(!isarray(var1)) {
    var1 = [var1];
  }

  var2 = undefined;

  foreach(var4 in var1) {
    if(var4 == "start_gundown") {
      self.gunposeoverride_internal = undefined;
      continue;
    } else if(var4 == "finish_early") {
      self._blackboard.partialgestureplaying = undefined;
      continue;
    } else {
      var5 = [[self.fnasm_handlenotetrack]](var4, var0);
    }

    if(isDefined(var5)) {
      var2 = var5;
    }
  }

  return var2;
}

function gesturedonotetracks(var0) {
  self endon("gesture_timeout");
  thread gesturenotetracktimeoutthread(var0);

  for(;;) {
    var1 = handlegesturenotetrack("gesture");

    if(isDefined(var1)) {
      return var1;
    }
  }

  self notify("gesture_finished");
}

function gesturenotetracktimeoutthread(var0) {
  self endon("gesture_finished");
  wait var0;
  self notify("gesture_timeout");
}

function gesture(var0) {
  self endon("asm_terminated");
  self endon("death");

  for(;;) {
    if(!isDefined(self._blackboard.gesturerequest)) {
      self waittill("gesture_requested");
    }

    for(;;) {
      if(!isDefined(self._blackboard.gesturerequest)) {
        break;
      }

      if(self._blackboard.gesturerequest.timeoutms < gettime()) {
        ai_cancel_gesture();
        break;
      }

      if(scripts\asm\asm_bb::bb_moverequested()) {
        var1 = self aigettargetspeed();

        if(!istrue(self.allowrunninggesture) && var1 > 135) {
          wait 0.1;
          continue;
        }

        if(self pathdisttogoal() < var1 * 2.5) {
          wait 0.1;
          continue;
        }
      }

      self._blackboard.gesturerequest.latestalias = get_gesture_alias(self._blackboard.gesturerequest.gesture, self._blackboard.gesturerequest.target);
      var2 = self aiplaygesture(self._blackboard.gesturerequest.latestalias);

      if(!isDefined(var2)) {
        wait 0.1;
        continue;
      }

      self.gunposeoverride_internal = "disable";
      self.baimedataimtarget = 0;

      if(self._blackboard.gesturerequest.disablelookat) {
        self.disableautolookat = 1;
        self stoplookat();
      }

      var4 = self._blackboard.gesturerequest.notifyname;
      self._blackboard.gesturerequest = undefined;
      self._blackboard.partialgestureplaying = 1;
      gesturedonotetracks(getanimlength(var2));
      self._blackboard.partialgestureplaying = undefined;

      if(isDefined(var4)) {
        self notify(var4, "gesture_finish");
      }

      self.disableautolookat = 0;
      self.gunposeoverride_internal = undefined;
      self aicleargesture();
      wait 0.4;
    }
  }
}

function gesture_should_disable_lookat(var0) {
  var1 = ["casual_point", "military_point", "beckon", "nvg_on", "nvg_off"];

  if(isDefined(self._blackboard.civilianfocuscurvalue) && var0 == "beckon") {
    return false;
  }

  if(scripts\engine\utility::array_contains(var1, var0)) {
    return true;
  }

  return false;
}

function ai_request_gesture_internal(var0, var1, var2, var3) {
  if(isDefined(self._blackboard.gesturerequest)) {
    ai_cancel_gesture();
  }

  self._blackboard.gesturerequest = spawnStruct();
  self._blackboard.gesturerequest.gesture = var0;
  self._blackboard.gesturerequest.target = var1;
  self._blackboard.gesturerequest.timeoutms = gettime() + var2;
  self._blackboard.gesturerequest.notifyname = var3;
  self._blackboard.gesturerequest.disablelookat = gesture_should_disable_lookat(var0);
  self notify("gesture_requested");
}

function civisfocusingleft() {
  return self._blackboard.civilianfocusstate == 3;
}

function civisfocusingright() {
  return self._blackboard.civilianfocusstate == 4;
}

function get_gesture_alias(var0, var1) {
  if(isDefined(self._blackboard.civilianfocuscurvalue)) {
    if(var0 == "beckon") {
      var2 = randomint(3) + 1;

      if(civisfocusingleft()) {
        var0 = var0 + "_" + var2 + "_l";
      } else if(civisfocusingright()) {
        var0 = var0 + "_" + var2 + "_r";
      }
    } else if(var0 == "glance") {
      var2 = randomint(2) + 1;

      if(civisfocusingleft()) {
        var0 = var0 + "_" + var2 + "_l";
      } else if(civisfocusingright()) {
        var0 = var0 + "_" + var2 + "_r";
      }
    }
  }

  if(isDefined(var1) && (var0 == "casual_point" || var0 == "military_point" || var0 == "beckon" || var0 == "stop" || var0 == "look" || var0 == "hide")) {
    var3 = vectortoyaw(var1.origin - self.origin);
    var4 = angleclamp180(var3 - self.angles[1]);
    var5 = getangleindex(var4, 22.5);
    var5 = scripts\asm\shared\utility::mapangleindextonumpad(var5);
    return (var0 + var5);
  }

  return var4;
}

function ai_finish_gesture() {
  if(isDefined(self._blackboard.gesturerequest.notifyname)) {
    self notify(self._blackboard.gesturerequest.notifyname, "gesture_finished");
  }

  self._blackboard.gesturerequest = undefined;
}

function chooseanim_gesture(var0, var1, var2) {
  var3 = scripts\asm\asm::asm_lookupanimfromalias(var1, self._blackboard.gesturerequest.latestalias);
  return var3;
}

function playcoveranim_gesture(var0, var1, var2) {
  self endon(var1 + "_finished");
  self._blackboard.activegesturenotify = self._blackboard.gesturerequest.notifyname;
  childthread scripts\asm\shared\utility::setuseanimgoalweight(var1, 0.2);
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  self orientmode("face current");

  if(scripts\asm\asm::asm_currentstatehasflag(var0, "notetrackAim")) {
    var5 = getangledelta(var4, 0, 1);
    self.stepoutyaw = self.angles[1] + var5;
  }

  self._blackboard.gesturerequest = undefined;
  self aisetanim(var1, var3);
  scripts\asm\asm::asm_playfacialanim(var0, var1, var4);
  scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1));
  self orientmode("face current");

  if(isDefined(self._blackboard.activegesturenotify)) {
    self notify(self._blackboard.activegesturenotify, "gesture_finished");
    self._blackboard.activegesturenotify = undefined;
    return;
  }
}

function cleargestureanim(var0, var1, var2) {
  if(isDefined(self._blackboard.activegesturenotify)) {
    self notify(self._blackboard.activegesturenotify, "gesture_cancel");
    self._blackboard.activegesturenotify = undefined;
    return;
  }
}

function gesture_finishearly(var0, var1, var2, var3) {
  if(scripts\asm\asm_bb::bb_moverequested() && istrue(self.gestureinterruptible)) {
    if(isDefined(self.gestureinterruptibleifplayerwithindist)) {
      if(distancesquared(self.origin, level.player.origin) < self.gestureinterruptibleifplayerwithindist * self.gestureinterruptibleifplayerwithindist) {
        return true;
      }
    } else {
      return true;
    }
  }

  return scripts\asm\asm::asm_eventfired(var0, "finish_early") && scripts\asm\asm_bb::bb_moverequested();
}