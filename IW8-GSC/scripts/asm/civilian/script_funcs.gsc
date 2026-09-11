/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\civilian\script_funcs.gsc
*************************************************/

function civilian_init(var0, var1, var2) {
  self.asm.frantic = 0;
  self.asm.customdata = spawnStruct();
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.dontsyncmelee = 1;
  self.allowstrafe = 0;

  if(self.asm.archetype == "hadir_yth") {
    self.pathsmoothmultiplier = 2;
  } else if(self.asm.archetype != "farah_civilian") {
    scripts\asm\shared\utility::setbasearchetype("civilian");
  }

  initanimspeedthresholds_civilian(self.asm.archetype);
  isnavmeshloaded();

  if(self isscriptable()) {
    thread initscriptable();
  }

  civilianfocusstartthread();
}

function initscriptable() {
  self endon("death");
  scripts\engine\utility::flag_wait("scriptables_ready");
  self setscriptablepartstate("notetrack_handler", "active", 0);
}

function initanimspeedthresholds_civilian(var0) {
  var1 = scripts\asm\shared\utility::getbasearchetype();

  if(!isDefined(var1)) {
    var1 = var0;
  }

  if(hasanimspeedthresholdstring(var1)) {
    return;
  }

  if(var1 == "farah_civilian") {
    animspeedthresholdsexist(var1, "walk", 56);
    animspeedthresholdsexist(var1, "fast", 105);
    animspeedthresholdsexist(var1, "jog", 170);
    animspeedthresholdsexist(var1, "run", 220);
    animspeedthresholdsexist(var1, "sprint", 250);
    return;
  }

  if(var1 == "hadir_yth") {
    animspeedthresholdsexist(var1, "walk", 40);
    animspeedthresholdsexist(var1, "fast", 102);
    animspeedthresholdsexist(var1, "jog", 103);
    animspeedthresholdsexist(var1, "run", 163);
    return;
  }

  animspeedthresholdsexist(var1, "walk", 56);
  animspeedthresholdsexist(var1, "fast", 120);
  animspeedthresholdsexist(var1, "jog", 170);
  animspeedthresholdsexist(var1, "run", 220);
}

function chooseciviliantransitiontoidleanim(var0, var1, var2) {
  if(isDefined(self.asm.transtoidlealias)) {
    var3 = self.asm.transtoidlealias;

    if(var1 == "trans_out_stand_idle") {
      self.asm.transtoidlealias = undefined;
    }

    return scripts\asm\asm::asm_lookupanimfromalias(var1, var3);
  }

  var3 = scripts\asm\asm::asm_getrandomalias(var2);
  self.asm.transtoidlealias = var3;
  return scripts\asm\asm::asm_lookupanimfromalias(var2, var3);
}

function choosecivilianreactidleanim(var0, var1, var2) {
  if(isDefined(self.asm.civilianreactionalias)) {
    var3 = self.asm.civilianreactionalias;

    if(var1 == "trans_out_combat_react") {
      self.asm.civilianreactionalias = undefined;
    }

    return scripts\asm\asm::asm_lookupanimfromalias(var1, var3);
  }

  var4 = self.asm.transtoidlealias;

  if(scripts\engine\utility::cointoss()) {
    var5 = var4 + "_a";
  } else {
    var5 += "_b";
  }

  self.asm.civilianreactionalias = var5;
  return scripts\asm\asm::asm_lookupanimfromalias(var3, var5);
}

function civilian_playexposedloop(var0, var1, var2) {
  scripts\asm\shared\utility::set_aim_and_turn_limits();
  var3 = self asmgetstatetransitioningfrom(var0);

  if(isDefined(self.node)) {
    self._blackboard.lastusednode = self.node;
  }

  scripts\asm\asm::asm_loopanimstate(var0, var1, 1);
}

function civilian_playanim_exit(var0, var1, var2) {
  self.isplayingexitanim = 1;
  scripts\asm\soldier\move::playanim_exit(var0, var1, var2);
}

function civilian_exit_cleanup(var0, var1, var2) {
  self.isplayingexitanim = undefined;
  self.asm.customdata.ignoreexitwarp = undefined;
  civilian_move_cleanup(var0, var1, var2);
}

function civilian_chooseanim_exit(var0, var1, var2) {
  var3 = self aigetdesiredspeed();
  var4 = scripts\asm\shared\utility::getbasearchetype();
  var5 = getanimspeedbetweenthresholds(var4, var3);

  if(!scripts\asm\soldier\move::checktransitionpreconditions()) {
    return undefined;
  }

  var6 = undefined;
  var7 = 0;

  if(isDefined(var2)) {
    var7 = var2;
  }

  var6 = scripts\asm\soldier\move::determinestartanim(var1, var7, var5);
  return var6;
}

function civilian_playmoveloop(var0, var1, var2) {
  thread civilian_watchspeed(var1);
  scripts\asm\shared\utility::playmoveloop(var0, var1, var2);
}

function civilian_playmoveloopblendspace(var0, var1, var2) {
  self endon(var1 + "_finished");
  thread civilian_watchspeed(var1);
  thread scripts\asm\shared\utility::waitforcoverapproach(var0, var1);
  thread scripts\asm\shared\utility::waitfordooropen(var0, var1, 0);
  var3 = scripts\asm\asm::asm_lookupanimfromalias(var1, "blank");
  self aisetanim(var1, var3);

  for(;;) {
    scripts\asm\asm::asm_donotetracks(var0, var1);
  }
}

function civilian_watchspeed(var0) {
  self endon(var0 + "_finished");

  if(isDefined(self.stayahead) && istrue(self.stayahead.active)) {
    return;
  }

  if(isDefined(self._blackboard.requestedspeed)) {
    self aisetdesiredspeed(self._blackboard.requestedspeed);
  }

  while(!isDefined(self.stayahead) || !istrue(self.stayahead.active)) {
    if(self aigetdesiredspeed() > 170 && self pathdisttogoal() < 200 && !istrue(self.disablearrivals)) {
      self aisetdesiredspeed(170);
    }

    waitframe();
  }
}

function civilian_playsharpturnanim(var0, var1, var2) {
  scripts\asm\soldier\move::playsharpturnanim(var0, var1, var2);
}

function civilian_move_cleanup(var0, var1, var2) {
  self motionwarpcancel();
}

function iswhizbydetected(var0, var1, var2, var3) {
  return scripts\asm\asm_bb::bb_iswhizbyrequested();
}

function civilianstateis(var0, var1, var2, var3) {
  return scripts\asm\asm_bb::bb_getcivilianstate() == var3;
}

function civilianstateisnot(var0, var1, var2, var3) {
  return scripts\asm\asm_bb::bb_getcivilianstate() != var3;
}

function shoulddirectlytransition(var0, var1, var2, var3) {
  if(iswhizbydetected() || scripts\asm\asm_bb::bb_getcivilianstate() == "combat") {
    var4 = self.asm.transtoidlealias;

    if(var4 == "civ02" || var4 == "civ04" || var4 == "civ06" || var4 == "civ07") {
      return true;
    }
  }

  return false;
}

function shouldcustomtransition(var0, var1, var2, var3) {
  if(scripts\asm\asm_bb::bb_getcivilianstate() == "noncombat") {
    var4 = self.asm.transtoidlealias;

    if(var4 == "civ02" || var4 == "civ04" || var4 == "civ06" || var4 == "civ07") {
      return true;
    }
  }

  return false;
}

function cleanupcivilianreactionalias(var0, var1, var2) {
  self.asm.civilianreactionalias = undefined;
}

function currentsnaptonodeis(var0, var1, var2, var3) {
  var4 = var3;

  if(!isDefined(self.node)) {
    return (var4 == "Exposed Crouch");
  }

  if(distance2dsquared(self.origin, self.node.origin) > 225) {
    if(scripts\asm\asm_bb::bb_getrequestedstance() == "stand") {
      return (var4 == "Exposed");
    } else {
      return (var4 == "Exposed Crouch");
    }
  }

  if(isDefined(self._blackboard.runpassthroughtype)) {
    return (self._blackboard.runpassthroughtype == var3);
  }

  return scripts\asm\shared\utility::isarrivaltype(var0, var1, var2, var3);
}

function shouldsnaptocover(var0, var1, var2, var3) {
  if(scripts\asm\asm_bb::bb_moverequested()) {
    return 0;
  }

  if(!scripts\asm\shared\utility::isatcovernode()) {
    return 0;
  }

  if(!isDefined(self.node)) {
    return 0;
  }

  if(isDefined(self.primaryweapon) && scripts\anim\utility_common::isusingsidearm() && weaponclass(self.primaryweapon) != "mg") {
    return 0;
  }

  if(!isDefined(var3)) {
    return 1;
  }

  return scripts\asm\shared\utility::isarrivaltype(var0, var1, var2, var3);
}

function checkarrivaltypecivilian(var0, var1, var2, var3) {
  return scripts\asm\shared\utility::isarrivaltypecivilian(var0, var3);
}

function enableciviliantargetfocus(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  self._blackboard.civilianfocustargetentity = var0;
  self._blackboard.civilianfocusstate = 1;

  if(!isDefined(var1)) {
    self._blackboard.civilianfocusdirection = "";
  } else {
    self._blackboard.civilianfocusdirection = var1;
  }

  self notify("civilian_focus_thread_enabled");
  civilianfocusstartthread();
}

function disableciviliantargetfocus() {
  self._blackboard.civilianfocustargetentity = undefined;
  self._blackboard.civilianfocusstate = 2;
}

function civilianfocusstartthread() {
  if(isDefined(self._blackboard.civilianfocusthreadrunning)) {
    return;
  }

  self._blackboard.civilianfocusthreadrunning = 1;
  self._blackboard.civilianfocusstate = 0;
  self._blackboard.civilianfocuscurvalue = 0;
  thread civilianfocusupdatethread();
}

function civilianfocuscomputeyawtotarget() {
  var0 = self.origin - self._blackboard.civilianfocustargetentity.origin;
  var0 = (var0[0], var0[1], 0);
  var1 = vectortoangles(var0);
  return angleclamp180(var1[1] - self.angles[1]);
}

function civilianfocusupdatecurrentfocus(var0) {
  var1 = 0.5;
  var2 = 1 / var1;
  var3 = gettime();
  var4 = var3 - self._blackboard.civilianfocuslasttime;
  self._blackboard.civilianfocuslasttime = var3;
  var5 = self._blackboard.civilianfocuscurvalue;
  var6 = var0 - var5;

  if(abs(var6) > 0.01) {
    var7 = scripts\engine\utility::sign(var0 - var5);
    var8 = self._blackboard.civilianfocuscurvalue + var4 / 1000 * var2 * var7;
    var8 = clamp(var8, -1, 1);
    self._blackboard.civilianfocuscurvalue = var8;
    return false;
  }

  self._blackboard.civilianfocuscurvalue = var2;
  return true;
}

function civilianfocusapproachingarrival() {
  var0 = self aigettargetspeed();

  if(!self codemoverequested() || self pathdisttogoal() < var0 * 1.3) {
    return true;
  } else if(istrue(self.isplayingexitanim)) {
    return true;
  }

  return false;
}

function civilianfocusupdateanimparameter(var0) {
  self setcivilianfocus(var0);
}

function civilianfocusupdatethread() {
  self endon("death");
  var0 = -1;
  var1 = 1;
  var2 = 170;
  var3 = -170;
  self._blackboard.civilianfocuslasttime = 0;

  for(;;) {
    var4 = self._blackboard.civilianfocusstate;
    var5 = self._blackboard.civilianfocusdirection;

    if(var4 == 0) {
      self waittill("civilian_focus_thread_enabled");
      self._blackboard.civilianfocuslasttime = gettime();
    } else if(var4 == 1) {
      var6 = civilianfocuscomputeyawtotarget();
      var7 = abs(var6);

      if(civilianfocusapproachingarrival() || var7 > 90) {
        self._blackboard.civilianfocusstate = 5;
      } else if(var5 == "left") {
        self._blackboard.civilianfocusstate = 3;
      } else if(var5 == "right") {
        self._blackboard.civilianfocusstate = 4;
      } else if(var6 != 0) {
        self._blackboard.civilianfocusstate = 6;
      }
    } else if(var4 == 2) {
      self._blackboard.civilianfocusstate = 7;
    } else if(var4 == 5) {
      civilianfocusupdatecurrentfocus(0);

      if(!civilianfocusapproachingarrival() && isalive(self._blackboard.civilianfocustargetentity)) {
        var6 = civilianfocuscomputeyawtotarget();

        if(abs(var6) < 90) {
          if(var5 == "left") {
            self._blackboard.civilianfocusstate = 3;
          } else if(var5 == "right") {
            self._blackboard.civilianfocusstate = 4;
          } else if(var6 != 0) {
            self._blackboard.civilianfocusstate = 6;
          }
        }
      }

      civilianfocusupdateanimparameter(self._blackboard.civilianfocuscurvalue);
    } else if(var4 == 6) {
      var6 = civilianfocuscomputeyawtotarget();
      var8 = clamp(var6, -45, 45) / 45;
      civilianfocusupdatecurrentfocus(var8);
      civilianfocusupdateanimparameter(self._blackboard.civilianfocuscurvalue);

      if(civilianfocusapproachingarrival()) {
        self._blackboard.civilianfocusstate = 5;
      }
    } else if(var4 == 3) {
      civilianfocusupdatecurrentfocus(var0);
      civilianfocusupdateanimparameter(self._blackboard.civilianfocuscurvalue);

      if(civilianfocusapproachingarrival()) {
        self._blackboard.civilianfocusstate = 5;
      } else {
        var6 = civilianfocuscomputeyawtotarget();

        if(abs(var6) < 90) {
          self._blackboard.civilianfocusstate = 5;
        } else if(var5 == "right" || var6 > var3 && var6 < -90) {
          self._blackboard.civilianfocusstate = 4;
        }
      }
    } else if(var4 == 4) {
      civilianfocusupdatecurrentfocus(var1);
      civilianfocusupdateanimparameter(self._blackboard.civilianfocuscurvalue);

      if(civilianfocusapproachingarrival()) {
        self._blackboard.civilianfocusstate = 5;
      } else {
        var6 = civilianfocuscomputeyawtotarget();

        if(abs(var6) < 90) {
          self._blackboard.civilianfocusstate = 5;
        } else if(var5 == "left" || var6 > 90 && var6 < var2) {
          self._blackboard.civilianfocusstate = 3;
        }
      }
    } else if(var4 == 7) {
      var9 = civilianfocusupdatecurrentfocus(0);
      civilianfocusupdateanimparameter(self._blackboard.civilianfocuscurvalue);

      if(var9) {
        self._blackboard.civilianfocusstate = 0;
      }
    }

    waitframe();
  }
}

function civmoverequested(var0, var1, var2, var3) {
  return scripts\asm\asm_bb::bb_moverequested() && !istrue(self._blackboard.partialgestureplaying);
}

function civarrival_finishearly(var0, var1, var2, var3) {
  return scripts\asm\asm::asm_eventfired(var0, "finish_early") && scripts\asm\asm_bb::bb_moverequested();
}

function civilian_chooseanim_demeanor(var0, var1, var2) {
  if(isDefined(var2)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var1, scripts\asm\asm_bb::bb_getcivilianstate() + var2);
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var1, scripts\asm\asm_bb::bb_getcivilianstate());
}

function civilian_chooseanim_playerpushed(var0, var1, var2) {
  var3 = scripts\asm\asm::asm_getephemeraleventdata("player_pushed", "player_pushed");
  var4 = vectorNormalize(var3);
  var5 = vectortoangles(var4);
  var6 = angleclamp180(var5[1] - self.angles[1]);
  var7 = scripts\asm\soldier\move::yawdiffto2468(var6);
  var8 = "pushed_" + var7;
  var9 = scripts\asm\asm::asm_lookupanimfromalias(var1, var8);
  return var9;
}

function civilian_loopidleanim(var0, var1, var2) {
  childthread scripts\asm\shared\utility::setuseanimgoalweight(var1, 0.2);
  scripts\asm\asm::asm_loopanimstate(var0, var1, 1);
}