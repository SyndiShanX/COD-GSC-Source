/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\civilian\script_funcs.gsc
*************************************************/

#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\cap;
#using scripts\engine\utility;
#namespace script_funcs;

function civilian_init(asmname, statename, params) {
  if(asmname == "civilian") {
    msgpt1 = "Using an aitype with the old 'civilian.asm'. ";
    msgpt2 = "All civilians should be using 'civilian_react' now. ";
    msgpt3 = "AIType: '" + self.classname + "' Location: " + self.origin;
    assertmsg(msgpt1 + msgpt2 + msgpt3);
  }

  if(!isDefined(self.asm.customdata)) {
    self.asm.customdata = spawnStruct();
  }

  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.anglelerprate = 100;
  self.dontsyncmelee = 1;
  self.allowstrafe = 0;
  self.maystumble = 1;
  self.shouldstumble = 0;
  self.stumbledelay = 1000;
  self.stumblechance = 0.2;
  self.var_5dc982e3f3b58ba0 = 10000;
  self.var_8dc39eff3b814ee1 = 30000;
  thread function_f2343b622bbbac5c();

  if(self.animsetname == "hadir_yth") {
    self.pathsmoothmultiplier = 2;
  }

  initanimspeedthresholds_civilian(self.animsetname);
  initmaxspeedforpathlengthtable();

  if(self isscriptable()) {
    thread initscriptable();
  }

  scripts\common\cap::init_cap();
  civilianfocusstartthread();
}

function initscriptable() {
  self endon("death");
  scripts\engine\utility::flag_wait("scriptables_ready");
  self setscriptablepartstate("notetrack_handler", "active", 0);
}

function initanimspeedthresholds_civilian(animsetname) {
  thresholdlabel = self getbasearchetype();

  if(!isDefined(thresholdlabel)) {
    thresholdlabel = animsetname;
  }

  if(animspeedthresholdsexist(thresholdlabel)) {
    return;
  }

  if(thresholdlabel == "farah_civilian") {
    setspeedthreshold(thresholdlabel, "walk", 56);
    setspeedthreshold(thresholdlabel, "fast", 105);
    setspeedthreshold(thresholdlabel, "jog", 170);
    setspeedthreshold(thresholdlabel, "run", 220);
    setspeedthreshold(thresholdlabel, "sprint", 250);
    return;
  }

  if(thresholdlabel == "hadir_yth") {
    setspeedthreshold(thresholdlabel, "walk", 40);
    setspeedthreshold(thresholdlabel, "fast", 102);
    setspeedthreshold(thresholdlabel, "jog", 103);
    setspeedthreshold(thresholdlabel, "run", 163);
    return;
  }

  setspeedthreshold(thresholdlabel, "walk", 52);
  setspeedthreshold(thresholdlabel, "fast", 127);
  setspeedthreshold(thresholdlabel, "jog", 153);
  setspeedthreshold(thresholdlabel, "run", 220);
}

function chooseciviliantransitiontoidleanim(asmname, statename, params) {
  if(isDefined(self.asm.transtoidlealias)) {
    randomalias = self.asm.transtoidlealias;

    if(statename == "trans_out_stand_idle") {
      self.asm.transtoidlealias = undefined;
    }

    return asm_lookupanimfromalias(statename, randomalias);
  }

  randomalias = asm_getrandomalias(statename);
  self.asm.transtoidlealias = randomalias;
  return asm_lookupanimfromalias(statename, randomalias);
}

function choosecivilianreactidleanim(asmname, statename, params) {
  if(isDefined(self.asm.civilianreactionalias)) {
    reactalias = self.asm.civilianreactionalias;

    if(statename == "trans_out_combat_react") {
      self.asm.civilianreactionalias = undefined;
    }

    return asm_lookupanimfromalias(statename, reactalias);
  }

  assertex(isDefined(self.asm.transtoidlealias), "<dev string:x1c>");
  currentalias = self.asm.transtoidlealias;

  if(scripts\engine\utility::cointoss()) {
    alias = currentalias + "_a";
  } else {
    alias = currentalias + "_b";
  }

  assertex(asm_hasalias(statename, alias), "<dev string:x1c>");
  self.asm.civilianreactionalias = alias;
  return asm_lookupanimfromalias(statename, alias);
}

function civilian_playexposedloop(asmname, statename, params) {
  self function_62004d7561fd321e();
  var_4fbb46e48f524506 = self asmgetstatetransitioningfrom(asmname);

  if(isDefined(self.node)) {
    self._blackboard.lastusednode = self.node;
  }

  function_fb56c9527636713f(asmname, statename, 1);
}

function civilian_exit_cleanup(asmname, statename, params) {
  self._blackboard.var_9fbdce5fa10f8964 = 0;
  civilian_move_cleanup(asmname, statename, params);
}

function civilian_playmoveloop(asmname, statename, params) {
  thread civilian_watchspeed(statename);
  scripts\asm\shared\utility::playmoveloop(asmname, statename, params);
}

function function_f2343b622bbbac5c() {
  self endon("death");
  stumbletimer = gettime() + randomint(1000);

  while(true) {
    waitframe();

    if(!istrue(self.maystumble) && !istrue(self.shouldstumble)) {
      continue;
    }

    if(!isDefined(self.pathgoalpos)) {
      continue;
    }

    if(gettime() < stumbletimer) {
      continue;
    }

    if(randomfloat(1) > self.stumblechance) {
      stumbletimer = gettime() + self.var_5dc982e3f3b58ba0;
      continue;
    }

    stumbletimer = gettime() + randomint(1000) + self.var_8dc39eff3b814ee1;
    self.shouldstumble = 1;
  }
}

function civilian_stumblechooseanim(asmname, statename, params) {
  archetype = self getbasearchetype();
  speed = length(self.velocity);
  alias = "stumble_jog";

  if(speed > 153) {
    alias = "stumble_sprint";
  }

  if(speed > 220) {
    alias = "stumble_run";
  }

  return asm_chooseanim(asmname, statename, alias);
}

function civilian_playmoveloopblendspace(asmname, statename, param) {
  self endon(statename + "_finished");
  thread civilian_watchspeed(statename);
  self.requestarrivalnotify = 1;
  self.var_5185accfc2476d43 = 1;
  self.var_1f91d3da0786a2 = 0;
  blankindex = asm_lookupanimfromalias(statename, "blank");
  self aisetanim(statename, blankindex);

  if(istrue(param)) {
    if(isDefined(self._blackboard.var_610cb18ecc1af719)) {
      self._blackboard.civilianfocustargetentity = self._blackboard.var_610cb18ecc1af719;
      var_6c542b356d086308 = civilianfocuscomputeyawtotarget();
      var_6c542b356d086308 /= 180;
      civilianfocusupdateanimparameter(var_6c542b356d086308);
    }
  }

  while(true) {
    asm_donotetracks(asmname, statename);
  }
}

function civilian_watchspeed(statename) {
  self endon(statename + "_finished");

  if(isDefined(self.stayahead) && istrue(self.stayahead.active)) {
    return;
  }

  if(isDefined(self._blackboard.requestedspeed)) {
    self aisetdesiredspeed(self._blackboard.requestedspeed);
  }

  while(!isDefined(self.stayahead) || !istrue(self.stayahead.active)) {
    if(self aigetdesiredspeed() > 153 && self pathdisttogoal() < 200 && !istrue(self.disablearrivals)) {
      self aisetdesiredspeed(153);
    }

    waitframe();
  }
}

function civilian_playsharpturnanim(asmname, statename, params) {
  self endon(statename + "_finished");
  turnanim = asm_getanim(asmname, statename);
  assert(isDefined(turnanim));
  turnxanim = asm_getxanim(statename, turnanim);
  self animmode("zonly_physics", 0);
  self orientmode("face angle", self.angles[1]);
  turnrate = self.moveplaybackrate;
  asm_playfacialanim(asmname, statename, turnxanim);
  self aisetanim(statename, turnanim, turnrate);
  childthread function_f350cd100563acaf(turnxanim, turnrate);
  note = asm_donotetracks(asmname, statename, &function_acfe95f0c8655298, turnxanim, undefined, 0);
  self motionwarpcancel();
  self orientmode("face enemy or motion");
  self animmode("normal", 0);

  if(note == "code_move") {
    self.requestarrivalnotify = 1;
    finishtimes = getnotetracktimes(turnxanim, "finish");

    if(finishtimes.size > 0) {
      asm_donotetracks(asmname, statename);
    }
  }
}

function function_f350cd100563acaf(turnxanim, turnrate) {
  waitframe();
  cornernotes = getnotetracktimes(turnxanim, "corner");

  if(cornernotes.size > 0) {
    cornertime = cornernotes[0];
    animlength = getanimlength(turnxanim);
    curtime = level.frameduration / 1000 / animlength;
    animtrans = getmovedelta(turnxanim, curtime, cornertime);
    animrot = (0, getangledelta(turnxanim, curtime, cornertime), 0);
    animduration = animlength * cornertime / turnrate;

    if(animduration > 0.05) {
      self.useanimgoalweight = 1;
      self function_2664ab4a4ab7100c(animtrans, animrot, animduration);
    }
  }
}

function function_acfe95f0c8655298(note, params) {
  if(note == "corner") {
    self motionwarpcancel();

    if(!isDefined(self.pathgoalpos)) {
      return;
    }

    if(self.lookaheaddist > 4) {
      lookaheadangle = vectortoyaw(self.lookaheaddir);
    } else {
      return;
    }

    turnxanim = params;
    cornertimes = getnotetracktimes(turnxanim, "corner");
    codemovetimes = getnotetracktimes(turnxanim, "code_move");
    assert(cornertimes.size > 0);
    endtime = 1;

    if(codemovetimes.size > 0) {
      endtime = codemovetimes[0];
    }

    duration = (endtime - cornertimes[0]) * getanimlength(turnxanim) * 1000;

    if(duration < level.frameduration) {
      return;
    }

    animdelta = getmovedelta(turnxanim, cornertimes[0], endtime);
    animrot = getangledelta(turnxanim, cornertimes[0], endtime);
    anglediff = angleclamp180(lookaheadangle - self.angles[1] - animrot);

    if(abs(anglediff) > 60) {
      return;
    }

    idealstartangles = (0, lookaheadangle - animrot, 0);
    targetpos = self.origin + rotatevector(animdelta, self.angles);
    targetpos = getclosestpointonnavmesh(targetpos, self, 0, 1);
    idealstartpos = targetpos - rotatevector(animdelta, idealstartangles);
    self motionwarpwithanim(idealstartpos, idealstartangles, targetpos, (0, lookaheadangle, 0), int(duration));
  }
}

function civilian_move_cleanup(asmname, statename, params) {
  self motionwarpcancel();
}

function iswhizbydetected(asmname, statename, tostatename, params) {
  return bb_iswhizbyrequested();
}

function function_49eab317ab73356(asmname, statename, tostatename, params) {
  return istrue(self.disableexits);
}

function shoulddirectlytransition(asmname, statename, tostatename, params) {
  if(iswhizbydetected() || bb_getcivilianstate() == "combat") {
    alias = self.asm.transtoidlealias;

    if(alias == "civ02" || alias == "civ04" || alias == "civ06" || alias == "civ07") {
      return true;
    }
  }

  return false;
}

function shouldcustomtransition(asmname, statename, tostatename, params) {
  if(bb_getcivilianstate() == "noncombat") {
    alias = self.asm.transtoidlealias;

    if(alias == "civ02" || alias == "civ04" || alias == "civ06" || alias == "civ07") {
      return true;
    }
  }

  return false;
}

function cleanupcivilianreactionalias(asmname, statename, params) {
  self.asm.civilianreactionalias = undefined;
}

function shouldsnaptocover(asmname, statename, tostatename, params) {
  if(bb_moverequested()) {
    return 0;
  }

  if(!isatcovernode()) {
    return 0;
  }

  if(!isDefined(self.node)) {
    return 0;
  }

  if(isDefined(self.primaryweapon) && scripts\anim\utility_common::isusingsidearm() && weaponclass(self.primaryweapon) != "mg") {
    return 0;
  }

  if(!isDefined(params)) {
    return 1;
  }

  return isarrivaltype(asmname, statename, tostatename, params);
}

function enableciviliantargetfocus(ent, direction) {
  if(!isDefined(ent)) {
    return;
  }

  self._blackboard.civilianfocustargetentity = ent;
  self._blackboard.civilianfocusstate = 1;

  if(!isDefined(direction)) {
    self._blackboard.civilianfocusdirection = "";
  } else {
    self._blackboard.civilianfocusdirection = direction;
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
  var_a5106610ad76d39b = self._blackboard.civilianfocustargetentity.origin - self.origin;
  var_a5106610ad76d39b = (var_a5106610ad76d39b[0], var_a5106610ad76d39b[1], 0);
  var_5290b84b388b75d7 = vectortoangles(var_a5106610ad76d39b);
  return angleclamp180(var_5290b84b388b75d7[1] - self.angles[1]);
}

function civilianfocusupdatecurrentfocus(targetvalue) {
  var_b1dbabba77c6a3f1 = 0.5;
  var_128b23694d81a9b7 = 1 / var_b1dbabba77c6a3f1;
  curtime = gettime();
  timedelt = curtime - self._blackboard.civilianfocuslasttime;
  self._blackboard.civilianfocuslasttime = curtime;
  currentvalue = self._blackboard.civilianfocuscurvalue;
  diff = targetvalue - currentvalue;

  if(abs(diff) > 0.01) {
    signtotarget = sign(targetvalue - currentvalue);
    newvalue = self._blackboard.civilianfocuscurvalue + timedelt / 1000 * var_128b23694d81a9b7 * signtotarget;
    newvalue = clamp(newvalue, -1, 1);
    self._blackboard.civilianfocuscurvalue = newvalue;
    return false;
  }

  self._blackboard.civilianfocuscurvalue = targetvalue;
  return true;
}

function civilianfocusapproachingarrival() {
  target_speed = self aigettargetspeed();

  if(!self codemoverequested() || self pathdisttogoal() < target_speed * 1.3) {
    return true;
  } else if(istrue(self._blackboard.var_9fbdce5fa10f8964)) {
    return true;
  }

  return false;
}

function civilianfocusupdateanimparameter(paramvalue) {
  self setcivilianfocus(paramvalue);
}

function civilianfocusupdatethread() {
  self endon("death");
  assert(isDefined(self._blackboard.civilianfocusstate));
  var_185be4b1e6feb6 = -1;
  var_9ae98138a32c9405 = 1;
  var_146b23f5a71e5333 = 170;
  var_df301aacf68898c7 = -170;
  self._blackboard.civilianfocuslasttime = 0;

  while(true) {
    state = self._blackboard.civilianfocusstate;
    direction = self._blackboard.civilianfocusdirection;

    if(state == 0) {
      self waittill("civilian_focus_thread_enabled");
      self._blackboard.civilianfocuslasttime = gettime();
    } else if(state == 1) {
      var_6c542b356d086308 = civilianfocuscomputeyawtotarget();
      var_91f3f4366e4d2f1c = abs(var_6c542b356d086308);

      if(civilianfocusapproachingarrival() || var_91f3f4366e4d2f1c > 90) {
        self._blackboard.civilianfocusstate = 5;
      } else if(direction == "left") {
        self._blackboard.civilianfocusstate = 3;
      } else if(direction == "right") {
        self._blackboard.civilianfocusstate = 4;
      } else if(var_6c542b356d086308 != 0) {
        self._blackboard.civilianfocusstate = 6;
      }
    } else if(state == 2) {
      self._blackboard.civilianfocusstate = 7;
    } else if(state == 5) {
      civilianfocusupdatecurrentfocus(0);

      if(!civilianfocusapproachingarrival() && isalive(self._blackboard.civilianfocustargetentity)) {
        var_6c542b356d086308 = civilianfocuscomputeyawtotarget();

        if(abs(var_6c542b356d086308) < 90) {
          if(direction == "left") {
            self._blackboard.civilianfocusstate = 3;
          } else if(direction == "right") {
            self._blackboard.civilianfocusstate = 4;
          } else if(var_6c542b356d086308 != 0) {
            self._blackboard.civilianfocusstate = 6;
          }
        }
      }

      civilianfocusupdateanimparameter(self._blackboard.civilianfocuscurvalue);
    } else if(state == 6) {
      var_6c542b356d086308 = civilianfocuscomputeyawtotarget();
      curtarget = clamp(var_6c542b356d086308, -45, 45) / 45;
      assert(curtarget >= -1 && curtarget <= 1);
      civilianfocusupdatecurrentfocus(curtarget);
      civilianfocusupdateanimparameter(self._blackboard.civilianfocuscurvalue);

      if(civilianfocusapproachingarrival()) {
        self._blackboard.civilianfocusstate = 5;
      }
    } else if(state == 3) {
      civilianfocusupdatecurrentfocus(var_185be4b1e6feb6);
      civilianfocusupdateanimparameter(self._blackboard.civilianfocuscurvalue);

      if(civilianfocusapproachingarrival()) {
        self._blackboard.civilianfocusstate = 5;
      } else {
        var_6c542b356d086308 = civilianfocuscomputeyawtotarget();

        if(abs(var_6c542b356d086308) < 90) {
          self._blackboard.civilianfocusstate = 5;
        } else if(direction == "right" || var_6c542b356d086308 > var_df301aacf68898c7 && var_6c542b356d086308 < -90) {
          self._blackboard.civilianfocusstate = 4;
        }
      }
    } else if(state == 4) {
      civilianfocusupdatecurrentfocus(var_9ae98138a32c9405);
      civilianfocusupdateanimparameter(self._blackboard.civilianfocuscurvalue);

      if(civilianfocusapproachingarrival()) {
        self._blackboard.civilianfocusstate = 5;
      } else {
        var_6c542b356d086308 = civilianfocuscomputeyawtotarget();

        if(abs(var_6c542b356d086308) < 90) {
          self._blackboard.civilianfocusstate = 5;
        } else if(direction == "left" || var_6c542b356d086308 > 90 && var_6c542b356d086308 < var_146b23f5a71e5333) {
          self._blackboard.civilianfocusstate = 3;
        }
      }
    } else if(state == 7) {
      done = civilianfocusupdatecurrentfocus(0);
      civilianfocusupdateanimparameter(self._blackboard.civilianfocuscurvalue);

      if(done) {
        self._blackboard.civilianfocusstate = 0;
      }
    }

    waitframe();
  }
}

function civmoverequested(asmname, statename, tostatename, params) {
  return bb_moverequested() && !istrue(self._blackboard.partialgestureplaying);
}

function civilian_chooseanim_demeanor(asmname, statename, params) {
  if(isDefined(params)) {
    return asm_lookupanimfromalias(statename, bb_getcivilianstate() + params);
  }

  return asm_lookupanimfromalias(statename, bb_getcivilianstate());
}

function civilian_chooseanim_playerpushed(asmname, statename, params) {
  movedir = asm_getephemeraleventdata("player_pushed", "player_pushed");
  movedirnormalized = vectorNormalize(movedir);
  targetangles = vectortoangles(movedirnormalized);
  targetyaw = angleclamp180(targetangles[1] - self.angles[1]);
  angleindex = scripts\asm\asm::yawdiffto2468(targetyaw);
  aliasname = "pushed_" + angleindex;
  turnanim = asm_lookupanimfromalias(statename, aliasname);
  return turnanim;
}

function function_b1bbe0dc316f2efa(asmname, statename, tostatename, params) {
  if(!isDefined(self.var_c4242158adaeadd2)) {
    return false;
  }

  return bb_getcivilianstate() == "casual";
}

function function_c41de664204e9824(asmname, statename, tostatename, params) {
  toplayer = level.player.origin - self.origin;
  setdvarifuninitialized(@ "hash_e423c827ca27e5c4", 120);
  dist = getdvarfloat(@ "hash_e423c827ca27e5c4", 120);
  dist *= dist;

  if(lengthsquared(toplayer) > dist) {
    return false;
  }

  selfforward = anglesToForward(self.angles);

  if(vectordot(toplayer, selfforward) < 0) {
    return false;
  }

  playerforward = anglesToForward(level.player.angles);

  if(vectordot(playerforward, selfforward) > 0) {
    return false;
  }

  return true;
}

function function_7bd81efb0abdbc44(asmname, statename, tostatename, params) {
  var_db51c3e732a073b4 = 100;
  closeai = getaiarrayinradius(self.origin, var_db51c3e732a073b4);

  if(!isDefined(closeai)) {
    return false;
  }

  topath = self getposonpath(100);
  selfforward = vectorNormalize(topath - self.origin);
  bestai = undefined;
  distsq = var_db51c3e732a073b4 * var_db51c3e732a073b4;

  for(i = 0; i < closeai.size; i++) {
    if(self == closeai[i]) {
      continue;
    }

    toai = closeai[i].origin - self.origin;
    dot = vectordot(toai, selfforward);

    if(dot < 0) {
      continue;
    }

    aiforward = anglesToForward(closeai[i].angles);

    if(vectordot(selfforward, aiforward) > 0) {
      continue;
    }

    toforward = toai - selfforward * dot;

    if(length2dsquared(toforward) > 625) {
      continue;
    }

    var_70bbcc66e8971969 = lengthsquared(toai);

    if(var_70bbcc66e8971969 < distsq) {
      distsq = var_70bbcc66e8971969;
      bestai = closeai[i];
    }
  }

  if(!isDefined(bestai)) {
    return false;
  }

  self.var_ae59f0b817468ed7 = bestai;
  return true;
}

function function_e481d310d5cb87c(asmname, statename, tostatename, params) {
  assert(isDefined(self.var_ae59f0b817468ed7));
  assert(isai(self.var_ae59f0b817468ed7));
  assert(isalive(self.var_ae59f0b817468ed7));
  closeai = self.var_ae59f0b817468ed7;
  toai = closeai.origin - self.origin;
  forward = anglesToForward(self.angles);

  if(length(toai) > 200) {
    return 1;
  }

  beyondthreshold = vectordot(toai, forward) < -20;
  return beyondthreshold;
}

function function_ae83a6295a6675c8(asmname, statename, params) {
  if(isDefined(self.var_b5780490703ab4d1)) {
    idx = self.var_b5780490703ab4d1;
  } else {
    idx = randomint(7) + 1;
  }

  self.var_b18d004bee7ca764 = idx;
  return asm_lookupanimfromalias(statename, "walk_" + idx);
}

function function_d13115c5f7b949e6(asmname, statename, params) {
  toplayer = level.player.origin - self.origin;
  forward = anglesToForward(self.angles);
  cross = vectorcross(forward, toplayer);
  idx = 1;

  if(isDefined(self.var_b18d004bee7ca764)) {
    idx = self.var_b18d004bee7ca764;
  }

  alias = undefined;

  if(cross[2] < 0) {
    alias = "avoid_" + idx + "_l";
  } else {
    alias = "avoid_" + idx + "_r";
  }

  return asm_lookupanimfromalias(statename, alias);
}

function function_d98f49aeb63edce4(asmname, statename, params) {
  assert(isDefined(self.var_ae59f0b817468ed7));
  assert(isai(self.var_ae59f0b817468ed7));
  assert(isalive(self.var_ae59f0b817468ed7));
  closeai = self.var_ae59f0b817468ed7;
  toai = closeai.origin - self.origin;
  forward = anglesToForward(self.angles);
  cross = vectorcross(forward, toai);
  idx = 1;

  if(isDefined(self.var_b18d004bee7ca764)) {
    idx = self.var_b18d004bee7ca764;
  }

  alias = undefined;

  if(cross[2] < 0) {
    alias = "avoid_" + idx + "_l";
  } else {
    alias = "avoid_" + idx + "_r";
  }

  return asm_lookupanimfromalias(statename, alias);
}

function function_c4d5a733f656507f(asmname, statename, params) {
  self.var_ae59f0b817468ed7 = undefined;
}

function function_7490810d9786cc51(asmname, statename, tostatename, params) {
  return isDefined(self.customarrivalstate);
}

function civplayturnanim(asmname, statename, tostatename, params) {
  self endon(statename + "_finished");
  turnanim = asm_getanim(asmname, statename);
  turnxanim = asm_getxanim(statename, turnanim);
  self.useanimgoalweight = 1;
  assert(!isDefined(params) || isarray(params) && params.size == 3);
  rate = 1;

  if(!isDefined(params) || params[2]) {
    rate_adjust = randomfloatrange(-0.2, 0.2);
    rate += rate_adjust;
  }

  if(isai(self)) {
    self aisetanim(statename, turnanim, rate);
  } else {
    bodyanimid = asm_lookupanimfromalias("knobs", "body");
    bodyxanim = asm_getxanim("knobs", bodyanimid);
    self setflaggedanimknoballrestart(statename, turnxanim, bodyxanim, 1, 0.2, 1);
  }

  if(!isDefined(params) || params[1]) {
    thread function_44224a1150c6d2c9(turnxanim, statename);
  }

  notehandler = asm_getnotehandler(asmname, statename);
  asm_donotetracks(asmname, statename, notehandler);
}

function function_44224a1150c6d2c9(turnxanim, statename) {
  self endon("death");
  self endon(statename + "_finished");
  player = undefined;
  animlength = getanimlength(turnxanim);

  if(animhasnotetrack(turnxanim, "start_aim")) {
    finish_time = getnotetracktimes(turnxanim, "start_aim");
    animlength *= finish_time[0];
  } else if(animhasnotetrack(turnxanim, "finish")) {
    finish_time = getnotetracktimes(turnxanim, "finish");
    animlength *= finish_time[0];
  }

  numframes = int(animlength * 20);
  remainingframes = numframes;
  lookpoint = function_75996a8dac6970f2(1024);

  if(isai(self)) {
    while(remainingframes > 0) {
      lerpfraction = 1 / remainingframes;
      yawtoenemy = angleclamp180(vectortoyaw(lookpoint - self.origin) - self.angles[1]);
      currentanimtime = self aigetanimtime(turnxanim);
      animyawdelta = getangledelta(turnxanim, currentanimtime, 1);
      remainingyaw = angleclamp180(yawtoenemy - animyawdelta);
      self orientmode("face angle", angleclamp(self.angles[1] + remainingyaw * lerpfraction));
      remainingframes--;
      wait 0.05;
    }

    return;
  }

  while(remainingframes > 0) {
    lerpfraction = 1 / remainingframes;
    yawtoenemy = angleclamp180(vectortoyaw(lookpoint - self.origin) - self.angles[1]);
    currentanimtime = self getanimtime(turnxanim);
    animyawdelta = getangledelta(turnxanim, currentanimtime, 1);
    remainingyaw = angleclamp180(yawtoenemy - animyawdelta);
    yaw = angleclamp(self.angles[1] + remainingyaw * lerpfraction);
    self.angles = (0, yaw, 0);
    remainingframes--;
    wait 0.05;
  }
}

function civchooseturnanim(asmname, statename, params) {
  target = function_75996a8dac6970f2(1024);

  if(isDefined(params) &isstring(params) && params == "return" && isDefined(self.interaction_origin)) {
    target = self.interaction_origin + (0, 0, 55) + anglesToForward(self.interaction_angles) * 10;
  }

  yawtotarget = vectortoyaw(target - self.origin);
  anglediff = angleclamp180(yawtotarget - self.angles[1]);
  turnanim = undefined;

  if(isDefined(params) && params == "cardinal") {
    absanglediff = abs(anglediff);
    animindex = "2";

    if(absanglediff > 135) {
      animindex = "8";
    } else if(anglediff > 45 && anglediff <= 135) {
      animindex = "6";
    } else if(anglediff >= -135 && anglediff < -45) {
      animindex = "4";
    }

    turnanim = asm_lookupanimfromalias(statename, animindex);
    assertex(isDefined(turnanim), "<dev string:x3a>" + animindex + "<dev string:x57>" + self.animsetname);
  } else {
    animmap = ["2", "3", "6", "9", "8", "7", "4", "1", "2"];
    animindex = getangleindex(anglediff, 22.5);
    turnanim = asm_lookupanimfromalias(statename, animmap[animindex]);
    assertex(isDefined(turnanim), "<dev string:x71>" + animmap[animindex] + "<dev string:x57>" + self.animsetname);
  }

  return turnanim;
}

function function_4be295e4306dc70c(asmname, statename, tostatename, params) {
  assertex(isDefined(params), "<dev string:x85>");
  return distancesquared(self.goalpos, self.origin) < params * params;
}

function function_89007ae298fb4b15(asmname, statename, params) {
  set_movement_speed(52);
}

function function_e7fc2fe7dda8fc2c(asmname, statename, params) {
  set_movement_speed(127);
}

function function_94ec448629b086c8(asmname, statename, params) {
  set_movement_speed(153);
}

function function_d45457463f7a8eab(asmname, statename, params) {
  set_movement_speed(220);
}

function function_92c056ec351f2f6e(asmname, statename, param) {
  if(isDefined(self._blackboard.requestedspeed) && self._blackboard.requestedspeed < 70) {
    set_movement_speed(70);
  }
}