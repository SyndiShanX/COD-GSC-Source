/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\gesture.gsc
***********************************************/

ai_request_gesture(gesture, target_obj, _id_025163A76776676D, _id_34FB06C037BE3746) {
  if(!isDefined(_id_025163A76776676D))
    _id_025163A76776676D = 1000;

  ai_request_gesture_internal(gesture, target_obj, _id_025163A76776676D, _id_34FB06C037BE3746);
}

ai_cancel_gesture() {
  if(!isDefined(self._blackboard.gesturerequest)) {
    return;
  }
  if(isDefined(self._blackboard.gesturerequest.notifyname))
    self notify(self._blackboard.gesturerequest.notifyname, "gesture_cancel");

  self._blackboard.gesturerequest = undefined;
}

handlegesturenotetrack(flagname) {
  self waittill(flagname, notes);

  if(!isDefined(notes))
    notes = ["undefined"];

  if(!isarray(notes))
    notes = [notes];

  _id_FC9A12FE1F57542A = undefined;

  foreach(_id_A234A65C378F3289 in notes) {
    if(_id_A234A65C378F3289 == "start_gundown") {
      self.gunposeoverride_internal = undefined;
      continue;
    } else if(_id_A234A65C378F3289 == "finish_early") {
      self._blackboard.partialgestureplaying = 0;
      continue;
    } else
      val = [[self.fnasm_handlenotetrack]](_id_A234A65C378F3289, flagname);

    if(isDefined(val))
      _id_FC9A12FE1F57542A = val;
  }

  return _id_FC9A12FE1F57542A;
}

gesturedonotetracks(animlength) {
  self endon("gesture_timeout");
  thread gesturenotetracktimeoutthread(animlength);

  for(;;) {
    val = handlegesturenotetrack("gesture");

    if(isDefined(val))
      return val;
  }

  self notify("gesture_finished");
}

gesturenotetracktimeoutthread(_id_CF54C5297431FEF6) {
  self endon("gesture_finished");
  wait(_id_CF54C5297431FEF6);
  self notify("gesture_timeout");
}

gesture(asmname) {
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
        _id_CC40BDDE3E81B83C = self aigettargetspeed();

        if(!istrue(self.allowrunninggesture) && _id_CC40BDDE3E81B83C > 135) {
          wait 0.1;
          continue;
        }

        if(self pathdisttogoal() < _id_CC40BDDE3E81B83C * 2.5) {
          wait 0.1;
          continue;
        }
      }

      self._blackboard.gesturerequest.latestalias = get_gesture_alias(self._blackboard.gesturerequest.gesture, self._blackboard.gesturerequest.target);
      _id_4EDB516A81E6B468 = self aiplaygesture(self._blackboard.gesturerequest.latestalias);

      if(!isDefined(_id_4EDB516A81E6B468)) {
        wait 0.1;
        continue;
      }

      self.gunposeoverride_internal = "disable";
      self.baimedataimtarget = 0;

      if(self._blackboard.gesturerequest.disablelookat) {
        self.disableautolookat = 1;
        self stoplookat();
      }

      _id_34FB06C037BE3746 = self._blackboard.gesturerequest.notifyname;
      self._blackboard.gesturerequest = undefined;
      self._blackboard.partialgestureplaying = 1;
      gesturedonotetracks(getanimlength(_id_4EDB516A81E6B468));
      self._blackboard.partialgestureplaying = 0;

      if(isDefined(_id_34FB06C037BE3746)) {
        self notify(_id_34FB06C037BE3746, "gesture_finish");
        self asmfireephemeralevent("gesture", "end");
      }

      self.disableautolookat = 0;
      self.gunposeoverride_internal = undefined;
      self aicleargesture();
      wait 0.4;
    }
  }
}

gesture_should_disable_lookat(gesture) {
  _id_A0AC7796B5ECE550 = ["casual_point", "military_point", "beckon", "nvg_on", "nvg_off", "wrist_com_lower", "wrist_com_raise"];

  if(isDefined(self._blackboard.civilianfocuscurvalue) && gesture == "beckon")
    return 0;

  if(scripts\engine\utility::array_contains(_id_A0AC7796B5ECE550, gesture))
    return 1;

  return 0;
}

ai_request_gesture_internal(gesture, _id_5110585BD4E933FE, _id_025163A76776676D, _id_34FB06C037BE3746) {
  if(isDefined(self._blackboard.gesturerequest))
    ai_cancel_gesture();

  self._blackboard.gesturerequest = spawnStruct();
  self._blackboard.gesturerequest.gesture = gesture;
  self._blackboard.gesturerequest.target = _id_5110585BD4E933FE;
  self._blackboard.gesturerequest.timeoutms = gettime() + _id_025163A76776676D;
  self._blackboard.gesturerequest.notifyname = _id_34FB06C037BE3746;
  self._blackboard.gesturerequest.disablelookat = gesture_should_disable_lookat(gesture);
  self notify("gesture_requested");
}

civisfocusingleft() {
  return self._blackboard.civilianfocusstate == 3;
}

civisfocusingright() {
  return self._blackboard.civilianfocusstate == 4;
}

get_gesture_alias(gesture, gesture_target) {
  if(isDefined(self._blackboard.civilianfocuscurvalue)) {
    if(gesture == "beckon") {
      _id_034DF158B62B8D82 = randomint(3) + 1;

      if(civisfocusingleft())
        gesture = gesture + "_" + _id_034DF158B62B8D82 + "_l";
      else if(civisfocusingright())
        gesture = gesture + "_" + _id_034DF158B62B8D82 + "_r";
    } else if(gesture == "glance") {
      _id_034DF158B62B8D82 = randomint(2) + 1;

      if(civisfocusingleft())
        gesture = gesture + "_" + _id_034DF158B62B8D82 + "_l";
      else if(civisfocusingright())
        gesture = gesture + "_" + _id_034DF158B62B8D82 + "_r";
    }
  }

  if(isDefined(gesture_target) && (gesture == "casual_point" || gesture == "military_point" || gesture == "beckon" || gesture == "stop" || gesture == "look" || gesture == "hide")) {
    if(isvector(gesture_target))
      targetorigin = gesture_target;
    else
      targetorigin = gesture_target.origin;

    _id_935CE979BB3EF270 = vectortoyaw(targetorigin - self.origin);
    _id_077B9E4B599269EB = angleclamp180(_id_935CE979BB3EF270 - self.angles[1]);
    angleindex = getangleindex(_id_077B9E4B599269EB, 22.5);
    angleindex = scripts\asm\shared\utility::mapangleindextonumpad(angleindex);
    return gesture + angleindex;
  }

  return gesture;
}

ai_finish_gesture() {
  if(isDefined(self._blackboard.gesturerequest.notifyname))
    self notify(self._blackboard.gesturerequest.notifyname, "gesture_finished");

  self._blackboard.gesturerequest = undefined;
}

chooseanim_gesture(asmname, statename, params) {
  _id_4EDB516A81E6B468 = scripts\asm\asm::asm_lookupanimfromalias(statename, self._blackboard.gesturerequest.latestalias);
  return _id_4EDB516A81E6B468;
}

playcoveranim_gesture(asmname, statename, params) {
  self endon(statename + "_finished");
  self._blackboard.activegesturenotify = self._blackboard.gesturerequest.notifyname;
  self setuseanimgoalweight(0.2);
  _id_0D6DD63CEFB3C4EE = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_066AEBE1D33F3B18 = scripts\asm\asm::asm_getxanim(statename, _id_0D6DD63CEFB3C4EE);
  self orientmode("face current");

  if(scripts\asm\asm::asm_currentstatehasflag(asmname, "notetrackAim")) {
    angledelta = getangledelta(_id_066AEBE1D33F3B18, 0.0, 1.0);
    self.stepoutyaw = self.angles[1] + angledelta;
  }

  self._blackboard.gesturerequest = undefined;
  self aisetanim(statename, _id_0D6DD63CEFB3C4EE);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, _id_066AEBE1D33F3B18);
  scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));
  self orientmode("face current");

  if(isDefined(self._blackboard.activegesturenotify)) {
    self notify(self._blackboard.activegesturenotify, "gesture_finished");
    self._blackboard.activegesturenotify = undefined;
  }
}

cleargestureanim(asmname, statename, params) {
  if(isDefined(self._blackboard.activegesturenotify)) {
    self notify(self._blackboard.activegesturenotify, "gesture_cancel");
    self._blackboard.activegesturenotify = undefined;
  }
}

gesture_finishearly(asmname, statename, _id_F2B19B25D457C2A6, gesture) {
  if(scripts\asm\asm_bb::bb_moverequested() && istrue(self.gestureinterruptible)) {
    if(isDefined(self.gestureinterruptibleifplayerwithindist)) {
      if(distancesquared(self.origin, level.player.origin) < self.gestureinterruptibleifplayerwithindist * self.gestureinterruptibleifplayerwithindist) {
        self asmfireephemeralevent("gesture", "end");
        return 1;
      }
    } else {
      self asmfireephemeralevent("gesture", "end");
      return 1;
    }
  }

  if(scripts\asm\asm::asm_eventfired(asmname, "finish_early") && scripts\asm\asm_bb::bb_moverequested())
    self asmfireephemeralevent("gesture", "end");

  return scripts\asm\asm::asm_eventfired(asmname, "finish_early") && scripts\asm\asm_bb::bb_moverequested();
}