/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\civilian\script_funcs.gsc
***********************************************/

civilian_init(var_0, var_1, var_2) {
  self.asm.frantic = 0;
  self.asm.customdata = spawnStruct();
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.dontsyncmelee = 1;
  self.allowstrafe = 0;

  if(self.asm.archetype == "hadir_yth")
    self.pathsmoothmultiplier = 2.0;
  else if(self.asm.archetype != "farah_civilian")
    scripts\asm\shared\utility::setbasearchetype("civilian");

  initanimspeedthresholds_civilian(self.asm.archetype);
  isnavmeshloaded();

  if(self isscriptable())
    thread initscriptable();

  civilianfocusstartthread();
}

initscriptable() {
  self endon("death");
  scripts\engine\utility::flag_wait("scriptables_ready");
  self setscriptablepartstate("notetrack_handler", "active", 0);
}

initanimspeedthresholds_civilian(var_0) {
  var_1 = scripts\asm\shared\utility::getbasearchetype();

  if(!isDefined(var_1))
    var_1 = var_0;

  if(hasanimspeedthresholdstring(var_1)) {
    return;
  }
  if(var_1 == "farah_civilian") {
    animspeedthresholdsexist(var_1, "walk", 56);
    animspeedthresholdsexist(var_1, "fast", 105);
    animspeedthresholdsexist(var_1, "jog", 170);
    animspeedthresholdsexist(var_1, "run", 220);
    animspeedthresholdsexist(var_1, "sprint", 250);
  } else if(var_1 == "hadir_yth") {
    animspeedthresholdsexist(var_1, "walk", 40);
    animspeedthresholdsexist(var_1, "fast", 102);
    animspeedthresholdsexist(var_1, "jog", 103);
    animspeedthresholdsexist(var_1, "run", 163);
  } else {
    animspeedthresholdsexist(var_1, "walk", 56);
    animspeedthresholdsexist(var_1, "fast", 120);
    animspeedthresholdsexist(var_1, "jog", 170);
    animspeedthresholdsexist(var_1, "run", 220);
  }
}

chooseciviliantransitiontoidleanim(var_0, var_1, var_2) {
  if(isDefined(self.asm.transtoidlealias)) {
    var_3 = self.asm.transtoidlealias;

    if(var_1 == "trans_out_stand_idle")
      self.asm.transtoidlealias = undefined;

    return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  } else {
    var_3 = scripts\asm\asm::asm_getrandomalias(var_1);
    self.asm.transtoidlealias = var_3;
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  }
}

choosecivilianreactidleanim(var_0, var_1, var_2) {
  if(isDefined(self.asm.civilianreactionalias)) {
    var_3 = self.asm.civilianreactionalias;

    if(var_1 == "trans_out_combat_react")
      self.asm.civilianreactionalias = undefined;

    return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  } else {
    var_4 = self.asm.transtoidlealias;

    if(scripts\engine\utility::cointoss())
      var_5 = var_4 + "_a";
    else
      var_5 = var_4 + "_b";

    self.asm.civilianreactionalias = var_5;
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_5);
  }
}

civilian_playexposedloop(var_0, var_1, var_2) {
  scripts\asm\shared\utility::set_aim_and_turn_limits();
  var_3 = self asmgetstatetransitioningfrom(var_0);

  if(isDefined(self.node))
    self._blackboard.lastusednode = self.node;

  scripts\asm\asm::asm_loopanimstate(var_0, var_1, 1.0);
}

civilian_playanim_exit(var_0, var_1, var_2) {
  self.isplayingexitanim = 1;
  scripts\asm\soldier\move::playanim_exit(var_0, var_1, var_2);
}

civilian_exit_cleanup(var_0, var_1, var_2) {
  self.isplayingexitanim = undefined;
  self.asm.customdata.ignoreexitwarp = undefined;
  civilian_move_cleanup(var_0, var_1, var_2);
}

civilian_chooseanim_exit(var_0, var_1, var_2) {
  var_3 = self aigetdesiredspeed();
  var_4 = scripts\asm\shared\utility::getbasearchetype();
  var_5 = getanimspeedbetweenthresholds(var_4, var_3);

  if(!scripts\asm\soldier\move::checktransitionpreconditions())
    return undefined;

  var_6 = undefined;
  var_7 = 0;

  if(isDefined(var_2))
    var_7 = var_2;

  var_6 = scripts\asm\soldier\move::determinestartanim(var_1, var_7, var_5);
  return var_6;
}

civilian_playmoveloop(var_0, var_1, var_2) {
  thread civilian_watchspeed(var_1);
  scripts\asm\shared\utility::playmoveloop(var_0, var_1, var_2);
}

civilian_playmoveloopblendspace(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  thread civilian_watchspeed(var_1);
  thread scripts\asm\shared\utility::waitforcoverapproach(var_0, var_1);
  thread scripts\asm\shared\utility::waitfordooropen(var_0, var_1, 0);
  var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "blank");
  self aisetanim(var_1, var_3);

  for(;;)
    scripts\asm\asm::asm_donotetracks(var_0, var_1);
}

civilian_watchspeed(var_0) {
  self endon(var_0 + "_finished");

  if(isDefined(self.stayahead) && istrue(self.stayahead.active)) {
    return;
  }
  if(isDefined(self._blackboard.requestedspeed))
    self aisetdesiredspeed(self._blackboard.requestedspeed);

  while(!isDefined(self.stayahead) || !istrue(self.stayahead.active)) {
    if(self aigetdesiredspeed() > 170 && self pathdisttogoal() < 200 && !istrue(self.disablearrivals))
      self aisetdesiredspeed(170);

    waitframe();
  }
}

civilian_playsharpturnanim(var_0, var_1, var_2) {
  scripts\asm\soldier\move::playsharpturnanim(var_0, var_1, var_2);
}

civilian_move_cleanup(var_0, var_1, var_2) {
  self motionwarpcancel();
}

iswhizbydetected(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_iswhizbyrequested();
}

civilianstateis(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_getcivilianstate() == var_3;
}

civilianstateisnot(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_getcivilianstate() != var_3;
}

shoulddirectlytransition(var_0, var_1, var_2, var_3) {
  if(iswhizbydetected() || scripts\asm\asm_bb::bb_getcivilianstate() == "combat") {
    var_4 = self.asm.transtoidlealias;

    if(var_4 == "civ02" || var_4 == "civ04" || var_4 == "civ06" || var_4 == "civ07")
      return 1;
  }

  return 0;
}

shouldcustomtransition(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm_bb::bb_getcivilianstate() == "noncombat") {
    var_4 = self.asm.transtoidlealias;

    if(var_4 == "civ02" || var_4 == "civ04" || var_4 == "civ06" || var_4 == "civ07")
      return 1;
  }

  return 0;
}

cleanupcivilianreactionalias(var_0, var_1, var_2) {
  self.asm.civilianreactionalias = undefined;
}

currentsnaptonodeis(var_0, var_1, var_2, var_3) {
  var_4 = var_3;

  if(!isDefined(self.node))
    return var_4 == "Exposed Crouch";

  if(distance2dsquared(self.origin, self.node.origin) > 225) {
    if(scripts\asm\asm_bb::bb_getrequestedstance() == "stand")
      return var_4 == "Exposed";
    else
      return var_4 == "Exposed Crouch";
  }

  if(isDefined(self._blackboard.runpassthroughtype))
    return self._blackboard.runpassthroughtype == var_3;
  else
    return scripts\asm\shared\utility::isarrivaltype(var_0, var_1, var_2, var_3);
}

shouldsnaptocover(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm_bb::bb_moverequested())
    return 0;

  if(!scripts\asm\shared\utility::isatcovernode())
    return 0;

  if(!isDefined(self.node))
    return 0;

  if(isDefined(self.primaryweapon) && scripts\anim\utility_common.gsc::isusingsidearm() && weaponclass(self.primaryweapon) != "mg")
    return 0;

  if(!isDefined(var_3))
    return 1;

  return scripts\asm\shared\utility::isarrivaltype(var_0, var_1, var_2, var_3);
}

checkarrivaltypecivilian(var_0, var_1, var_2, var_3) {
  return scripts\asm\shared\utility::isarrivaltypecivilian(var_0, var_3);
}

enableciviliantargetfocus(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  self._blackboard.civilianfocustargetentity = var_0;
  self._blackboard.civilianfocusstate = 1;

  if(!isDefined(var_1))
    self._blackboard.civilianfocusdirection = "";
  else
    self._blackboard.civilianfocusdirection = var_1;

  self notify("civilian_focus_thread_enabled");
  civilianfocusstartthread();
}

disableciviliantargetfocus() {
  self._blackboard.civilianfocustargetentity = undefined;
  self._blackboard.civilianfocusstate = 2;
}

civilianfocusstartthread() {
  if(isDefined(self._blackboard.civilianfocusthreadrunning)) {
    return;
  }
  self._blackboard.civilianfocusthreadrunning = 1;
  self._blackboard.civilianfocusstate = 0;
  self._blackboard.civilianfocuscurvalue = 0.0;
  thread civilianfocusupdatethread();
}

civilianfocuscomputeyawtotarget() {
  var_0 = self.origin - self._blackboard.civilianfocustargetentity.origin;
  var_0 = (var_0[0], var_0[1], 0.0);
  var_1 = vectortoangles(var_0);
  return angleclamp180(var_1[1] - self.angles[1]);
}

civilianfocusupdatecurrentfocus(var_0) {
  var_1 = 0.5;
  var_2 = 1.0 / var_1;
  var_3 = gettime();
  var_4 = var_3 - self._blackboard.civilianfocuslasttime;
  self._blackboard.civilianfocuslasttime = var_3;
  var_5 = self._blackboard.civilianfocuscurvalue;
  var_6 = var_0 - var_5;

  if(abs(var_6) > 0.01) {
    var_7 = scripts\engine\utility::sign(var_0 - var_5);
    var_8 = self._blackboard.civilianfocuscurvalue + var_4 / 1000.0 * var_2 * var_7;
    var_8 = clamp(var_8, -1.0, 1.0);
    self._blackboard.civilianfocuscurvalue = var_8;
    return 0;
  }

  self._blackboard.civilianfocuscurvalue = var_0;
  return 1;
}

civilianfocusapproachingarrival() {
  var_0 = self aigettargetspeed();

  if(!self codemoverequested() || self pathdisttogoal() < var_0 * 1.3)
    return 1;
  else if(istrue(self.isplayingexitanim))
    return 1;

  return 0;
}

civilianfocusupdateanimparameter(var_0) {
  self setcivilianfocus(var_0);
}

civilianfocusupdatethread() {
  self endon("death");
  var_0 = -1.0;
  var_1 = 1.0;
  var_2 = 170;
  var_3 = -170;
  self._blackboard.civilianfocuslasttime = 0;

  for(;;) {
    var_4 = self._blackboard.civilianfocusstate;
    var_5 = self._blackboard.civilianfocusdirection;

    if(var_4 == 0) {
      self waittill("civilian_focus_thread_enabled");
      self._blackboard.civilianfocuslasttime = gettime();
    } else if(var_4 == 1) {
      var_6 = civilianfocuscomputeyawtotarget();
      var_7 = abs(var_6);

      if(civilianfocusapproachingarrival() || var_7 > 90)
        self._blackboard.civilianfocusstate = 5;
      else if(var_5 == "left")
        self._blackboard.civilianfocusstate = 3;
      else if(var_5 == "right")
        self._blackboard.civilianfocusstate = 4;
      else if(var_6 != 0)
        self._blackboard.civilianfocusstate = 6;
    } else if(var_4 == 2)
      self._blackboard.civilianfocusstate = 7;
    else if(var_4 == 5) {
      civilianfocusupdatecurrentfocus(0.0);

      if(!civilianfocusapproachingarrival() && isalive(self._blackboard.civilianfocustargetentity)) {
        var_6 = civilianfocuscomputeyawtotarget();

        if(abs(var_6) < 90) {
          if(var_5 == "left")
            self._blackboard.civilianfocusstate = 3;
          else if(var_5 == "right")
            self._blackboard.civilianfocusstate = 4;
          else if(var_6 != 0)
            self._blackboard.civilianfocusstate = 6;
        }
      }

      civilianfocusupdateanimparameter(self._blackboard.civilianfocuscurvalue);
    } else if(var_4 == 6) {
      var_6 = civilianfocuscomputeyawtotarget();
      var_8 = clamp(var_6, -45, 45) / 45.0;
      civilianfocusupdatecurrentfocus(var_8);
      civilianfocusupdateanimparameter(self._blackboard.civilianfocuscurvalue);

      if(civilianfocusapproachingarrival())
        self._blackboard.civilianfocusstate = 5;
    } else if(var_4 == 3) {
      civilianfocusupdatecurrentfocus(var_0);
      civilianfocusupdateanimparameter(self._blackboard.civilianfocuscurvalue);

      if(civilianfocusapproachingarrival())
        self._blackboard.civilianfocusstate = 5;
      else {
        var_6 = civilianfocuscomputeyawtotarget();

        if(abs(var_6) < 90)
          self._blackboard.civilianfocusstate = 5;
        else if(var_5 == "right" || var_6 > var_3 && var_6 < -90)
          self._blackboard.civilianfocusstate = 4;
      }
    } else if(var_4 == 4) {
      civilianfocusupdatecurrentfocus(var_1);
      civilianfocusupdateanimparameter(self._blackboard.civilianfocuscurvalue);

      if(civilianfocusapproachingarrival())
        self._blackboard.civilianfocusstate = 5;
      else {
        var_6 = civilianfocuscomputeyawtotarget();

        if(abs(var_6) < 90)
          self._blackboard.civilianfocusstate = 5;
        else if(var_5 == "left" || var_6 > 90 && var_6 < var_2)
          self._blackboard.civilianfocusstate = 3;
      }
    } else if(var_4 == 7) {
      var_9 = civilianfocusupdatecurrentfocus(0.0);
      civilianfocusupdateanimparameter(self._blackboard.civilianfocuscurvalue);

      if(var_9)
        self._blackboard.civilianfocusstate = 0;
    }

    waitframe();
  }
}

civmoverequested(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested() && !istrue(self._blackboard.partialgestureplaying);
}

civarrival_finishearly(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm::asm_eventfired(var_0, "finish_early") && scripts\asm\asm_bb::bb_moverequested();
}

civilian_chooseanim_demeanor(var_0, var_1, var_2) {
  if(isDefined(var_2))
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, scripts\asm\asm_bb::bb_getcivilianstate() + var_2);
  else
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, scripts\asm\asm_bb::bb_getcivilianstate());
}

civilian_chooseanim_playerpushed(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_getephemeraleventdata("player_pushed", "player_pushed");
  var_4 = vectorNormalize(var_3);
  var_5 = vectortoangles(var_4);
  var_6 = angleclamp180(var_5[1] - self.angles[1]);
  var_7 = scripts\asm\soldier\move::yawdiffto2468(var_6);
  var_8 = "pushed_" + var_7;
  var_9 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_8);
  return var_9;
}

civilian_loopidleanim(var_0, var_1, var_2) {
  childthread scripts\asm\shared\utility::setuseanimgoalweight(var_1, 0.2);
  scripts\asm\asm::asm_loopanimstate(var_0, var_1, 1.0);
}