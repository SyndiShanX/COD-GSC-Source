/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\gesture.gsc
***********************************************/

ai_request_gesture(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 1000;

  ai_request_gesture_internal(var_0, var_1, var_2, var_3);
}

ai_cancel_gesture() {
  if(!isDefined(self._blackboard.gesturerequest)) {
    return;
  }
  if(isDefined(self._blackboard.gesturerequest.notifyname))
    self notify(self._blackboard.gesturerequest.notifyname, "gesture_cancel");

  self._blackboard.gesturerequest = undefined;
}

handlegesturenotetrack(var_0) {
  self waittill(var_0, var_1);

  if(!isDefined(var_1))
    var_1 = ["undefined"];

  if(!isarray(var_1))
    var_1 = [var_1];

  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(var_4 == "start_gundown") {
      self.gunposeoverride_internal = undefined;
      continue;
    } else if(var_4 == "finish_early") {
      self._blackboard.partialgestureplaying = undefined;
      continue;
    } else
      var_5 = [[self.fnasm_handlenotetrack]](var_4, var_0);

    if(isDefined(var_5))
      var_2 = var_5;
  }

  return var_2;
}

gesturedonotetracks(var_0) {
  self endon("gesture_timeout");
  thread gesturenotetracktimeoutthread(var_0);

  for(;;) {
    var_1 = handlegesturenotetrack("gesture");

    if(isDefined(var_1))
      return var_1;
  }

  self notify("gesture_finished");
}

gesturenotetracktimeoutthread(var_0) {
  self endon("gesture_finished");
  wait(var_0);
  self notify("gesture_timeout");
}

gesture(var_0) {
  self endon("asm_terminated");
  self endon("death");

  for(;;) {
    if(!isDefined(self._blackboard.gesturerequest))
      self waittill("gesture_requested");

    for(;;) {
      if(!isDefined(self._blackboard.gesturerequest)) {
        break;
      }

      if(self._blackboard.gesturerequest.timeoutms < gettime()) {
        ai_cancel_gesture();
        break;
      }

      if(scripts\asm\asm_bb::bb_moverequested()) {
        var_1 = self aigettargetspeed();

        if(!istrue(self.allowrunninggesture) && var_1 > 135) {
          wait 0.1;
          continue;
        }

        if(self pathdisttogoal() < var_1 * 2.5) {
          wait 0.1;
          continue;
        }
      }

      self._blackboard.gesturerequest.latestalias = get_gesture_alias(self._blackboard.gesturerequest.gesture, self._blackboard.gesturerequest.target);
      var_2 = self aiplaygesture(self._blackboard.gesturerequest.latestalias);

      if(!isDefined(var_2)) {
        wait 0.1;
        continue;
      }

      self.gunposeoverride_internal = "disable";
      self.baimedataimtarget = 0;

      if(self._blackboard.gesturerequest.disablelookat) {
        self.disableautolookat = 1;
        self stoplookat();
      }

      var_4 = self._blackboard.gesturerequest.notifyname;
      self._blackboard.gesturerequest = undefined;
      self._blackboard.partialgestureplaying = 1;
      gesturedonotetracks(getanimlength(var_2));
      self._blackboard.partialgestureplaying = undefined;

      if(isDefined(var_4))
        self notify(var_4, "gesture_finish");

      self.disableautolookat = 0;
      self.gunposeoverride_internal = undefined;
      self aicleargesture();
      wait 0.4;
    }
  }
}

gesture_should_disable_lookat(var_0) {
  var_1 = ["casual_point", "military_point", "beckon", "nvg_on", "nvg_off"];

  if(isDefined(self._blackboard.civilianfocuscurvalue) && var_0 == "beckon")
    return 0;

  if(scripts\engine\utility::array_contains(var_1, var_0))
    return 1;

  return 0;
}

ai_request_gesture_internal(var_0, var_1, var_2, var_3) {
  if(isDefined(self._blackboard.gesturerequest))
    ai_cancel_gesture();

  self._blackboard.gesturerequest = spawnStruct();
  self._blackboard.gesturerequest.gesture = var_0;
  self._blackboard.gesturerequest.target = var_1;
  self._blackboard.gesturerequest.timeoutms = gettime() + var_2;
  self._blackboard.gesturerequest.notifyname = var_3;
  self._blackboard.gesturerequest.disablelookat = gesture_should_disable_lookat(var_0);
  self notify("gesture_requested");
}

civisfocusingleft() {
  return self._blackboard.civilianfocusstate == 3;
}

civisfocusingright() {
  return self._blackboard.civilianfocusstate == 4;
}

get_gesture_alias(var_0, var_1) {
  if(isDefined(self._blackboard.civilianfocuscurvalue)) {
    if(var_0 == "beckon") {
      var_2 = randomint(3) + 1;

      if(civisfocusingleft())
        var_0 = var_0 + "_" + var_2 + "_l";
      else if(civisfocusingright())
        var_0 = var_0 + "_" + var_2 + "_r";
    } else if(var_0 == "glance") {
      var_2 = randomint(2) + 1;

      if(civisfocusingleft())
        var_0 = var_0 + "_" + var_2 + "_l";
      else if(civisfocusingright())
        var_0 = var_0 + "_" + var_2 + "_r";
    }
  }

  if(isDefined(var_1) && (var_0 == "casual_point" || var_0 == "military_point" || var_0 == "beckon" || var_0 == "stop" || var_0 == "look" || var_0 == "hide")) {
    var_3 = vectortoyaw(var_1.origin - self.origin);
    var_4 = angleclamp180(var_3 - self.angles[1]);
    var_5 = getangleindex(var_4, 22.5);
    var_5 = scripts\asm\shared\utility::mapangleindextonumpad(var_5);
    return var_0 + var_5;
  }

  return var_0;
}

ai_finish_gesture() {
  if(isDefined(self._blackboard.gesturerequest.notifyname))
    self notify(self._blackboard.gesturerequest.notifyname, "gesture_finished");

  self._blackboard.gesturerequest = undefined;
}

chooseanim_gesture(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, self._blackboard.gesturerequest.latestalias);
  return var_3;
}

playcoveranim_gesture(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self._blackboard.activegesturenotify = self._blackboard.gesturerequest.notifyname;
  childthread scripts\asm\shared\utility::setuseanimgoalweight(var_1, 0.2);
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  self orientmode("face current");

  if(scripts\asm\asm::asm_currentstatehasflag(var_0, "notetrackAim")) {
    var_5 = getangledelta(var_4, 0.0, 1.0);
    self.stepoutyaw = self.angles[1] + var_5;
  }

  self._blackboard.gesturerequest = undefined;
  self aisetanim(var_1, var_3);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_4);
  scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
  self orientmode("face current");

  if(isDefined(self._blackboard.activegesturenotify)) {
    self notify(self._blackboard.activegesturenotify, "gesture_finished");
    self._blackboard.activegesturenotify = undefined;
  }
}

cleargestureanim(var_0, var_1, var_2) {
  if(isDefined(self._blackboard.activegesturenotify)) {
    self notify(self._blackboard.activegesturenotify, "gesture_cancel");
    self._blackboard.activegesturenotify = undefined;
  }
}

gesture_finishearly(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm_bb::bb_moverequested() && istrue(self.gestureinterruptible)) {
    if(isDefined(self.gestureinterruptibleifplayerwithindist)) {
      if(distancesquared(self.origin, level.player.origin) < self.gestureinterruptibleifplayerwithindist * self.gestureinterruptibleifplayerwithindist)
        return 1;
    } else
      return 1;
  }

  return scripts\asm\asm::asm_eventfired(var_0, "finish_early") && scripts\asm\asm_bb::bb_moverequested();
}