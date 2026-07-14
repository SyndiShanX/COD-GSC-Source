/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\cap.gsc
**************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace cap;

function init_cap() {
  if(isDefined(level.cap)) {
    return;
  }

  level.cap = spawnStruct();
  level.cap.fnstart = &cap_start;
  level.cap.fnexit = &cap_exit;
}

function cap_start(capname, animset, animscripted) {
  if(isai(self) && self isinscriptedstate()) {
    msg1 = "AI $e" + self getentitynumber() + " attempting to start CAP '" + capname + "' with Arc '" + animset + "' ";
    msg2 = "but is currently playing a scripted anim (ASM state: '" + asm::asm_getcurrentstate(self.asmname) + "') ";
    msg3 = "This is not supported - you either need to avoid starting";
    msg4 = " a CAP when the AI is scripted, or first clear the scripted state using the normal method.";
    assertmsg(msg1 + msg2 + msg3 + msg4);
    return false;
  }

  self.caporigin = self.origin;
  self.capangles = self.angles;
  self notify("cap_start");

  if(!isai(self)) {
    self._blackboard = spawnStruct();
    self._blackboard.bfire = 0;
    function_64df1eb8fc59357a(capname, animset);
    return true;
  } else {
    self._blackboard.bseqphase = undefined;
  }

  assert(isalive(self) && isDefined(self.asm));
  self setoverridearchetype("animscript", animset, 0);
  self setcapasm(capname);
  cap_terminateandreplace(capname);

  if(animscripted) {
    asm_bb::bb_setanimScripted();
  }

  return true;
}

function function_64df1eb8fc59357a(baseasmname, archetypename) {
  if(archetypename == "hero_salter" || archetypename == "farah" || archetypename == "soldier_female") {
    asm_bb::bb_setshort(1);
  }

  self.asmname = baseasmname;

  if(!isDefined(self.asm)) {
    self.asm = spawnStruct();
    self.asm.animoverrides = [];
  }

  assert(isDefined(archetypename) || isDefined(self.animsetname));

  if(isDefined(archetypename)) {
    self.animsetname = archetypename;
    self.originalanimationarchetype = self.animationarchetype;
    self.animationarchetype = undefined;
  }

  self.scriptmodelcap = 1;
  self asminstantiate(baseasmname);

  if(!isDefined(level.capscriptmodels)) {
    level.capscriptmodels = [];
    level thread function_804046ad9cf64f5b();
  }

  if(!arraycontains(level.capscriptmodels, self)) {
    level.capscriptmodels[level.capscriptmodels.size] = self;
  }
}

function function_804046ad9cf64f5b() {
  while(true) {
    for(capindex = 0; capindex < level.capscriptmodels.size; capindex++) {
      capent = level.capscriptmodels[capindex];

      if(isalive(capent)) {
        capent asmtick();
      }
    }

    wait 0.05;
  }
}

function cap_terminateandreplace(newasmname, newarchetype) {
  self asmterminate();
  self notify("asm_terminated");
  self.asmtrackasm = undefined;

  if(!isDefined(newarchetype)) {
    newarchetype = self.animsetname;
  }

  self[[self.fnasm_init]](tolower(newasmname), newarchetype);
}

function cap_exit() {
  if(!isai(self)) {
    self.asmname = undefined;
    self.animationarchetype = self.originalanimationarchetype;
    self.originalanimationarchetype = undefined;
    self.scriptmodelcap = undefined;

    if(arraycontains(level.capscriptmodels, self)) {
      level.capscriptmodels = arrayremove(level.capscriptmodels, self);
    }

    return;
  }

  assert(self function_51631ea7d587647d(), "<dev string:x24>" + self.asmname);

  if(!self function_51631ea7d587647d()) {
    return;
  }

  if(asm_bb::bb_isanimScripted()) {
    asm_bb::bb_clearanimScripted();
  }

  self.asmtrackasm = undefined;
  self clearcap();
  self.var_f6cf297cd6c37337 = undefined;

  if(isDefined(self.capgroup)) {
    function_1dc69bd8c64496fc();
  }

  function_82acad1b355efb61();
  self notify("cap_exit_completed");
}

function function_4fe8a1b9dc2d0bbc() {
  self endon("entitydeleted");
  self endon("cap_exit_completed");

  if(self.team == "axis") {
    utility::waittill_any("death", utility::function_215bebaff8aa653c());
  } else {
    self waittill("death");
  }

  if(asm_bb::bb_isanimScripted()) {
    asm_bb::bb_clearanimScripted();
  }

  self stopanimScripted();
  self clearoverridearchetype("animscript");
  self setcapasm(undefined);
  cap_terminateandreplace(self.defaultasm);

  if(isDefined(self.capgroup)) {
    function_1dc69bd8c64496fc();
  }

  function_82acad1b355efb61();
  self notify("cap_exit_completed");
}

function function_b26f782b6bed85d5(origin, capname, animset, var_b9018c9fc0176a5c) {
  self endon("death");

  if(var_b9018c9fc0176a5c) {
    self.oldscriptgoalpos = self.scriptgoalpos;
    self.oldgoalradius = self.goalradius;
  }

  self setgoalpos(origin, 1);
  self waittill("goal");
  cap_start(capname, animset);
  self waittill("cap_exit_completed");

  if(isDefined(self.oldscriptgoalpos)) {
    self setgoalpos(self.oldscriptgoalpos, self.oldgoalradius);
    self.oldscriptgoalpos = undefined;
    self.oldgoalradius = undefined;
  }
}

function cap_reach_and_arrive_terminate() {
  msg = utility::waittill_any_return("cap_reach_and_arrive", "bseq_user_deleted");

  if(isDefined(self.scriptedarrivalent)) {
    self.scriptedarrivalent delete();
  }

  if(isDefined(self.customarrivalhandler)) {
    self.customarrivalhandler = undefined;
  }

  if(isDefined(msg)) {
    self finishcoverarrival("Custom");
    self clearbtgoal(1);

    if(msg == "bseq_user_deleted") {
      if(self.defaultasm != self.asmname) {
        cap_exit();
      }
    }
  }
}

function cap_reach_and_arrive(scriptednode, capname, animset, arrival_state_override) {
  assert(isDefined(scriptednode.origin));
  self notify("cap_reach_and_arrive");
  self endon("cap_reach_and_arrive");
  thread cap_reach_and_arrive_terminate();
  self endon("bseq_user_deleted");
  self endon("death");

  if(!isDefined(self.scriptedarrivalent)) {
    self.scriptedarrivalent = spawn("script_origin", scriptednode.origin);
    self.scriptedarrivalent.targetname = "cap_reach_and_arrive";
  }

  self.scriptedarrivalent.angles = scriptednode.angles;
  self.scriptedarrivalent.origin = scriptednode.origin;
  self.scriptedarrivalent.type = "Custom";
  arrival_state = "cap_arrival";

  if(isDefined(arrival_state_override)) {
    arrival_state = arrival_state_override;
  }

  oldpushable = self.pushable;
  self.pushable = 0;

  if(!self.var_e0bc276499c18875) {
    approachpos = function_82491e1bc74dd239(capname, arrival_state, scriptednode.origin, animset);
    var_e3e28571d43b1f01 = 0;

    if(isarray(approachpos)) {
      var_e3e28571d43b1f01 = 1;
      approachpos = approachpos[1];
    }

    if(isDefined(approachpos)) {
      while(distance2d(self.origin, approachpos) > 40) {
        waitframe();
      }

      if(var_e3e28571d43b1f01) {
        self clearbtgoal(1);
      }
    }
  }

  goalrad = 4;
  self setbtgoalRadius(1, goalrad);
  self setbtgoalpos(1, scriptednode.origin);
  asm::asm_fireephemeralevent("path_chosen", "end");
  assert(archetypehasstate(animset, arrival_state), "<dev string:x5e>" + animset + "<dev string:x6b>" + arrival_state + "<dev string:x87>");
  self.customarrivalstate = arrival_state;
  self.customarrivalanimset = animset;
  self.customarrivalangles = scriptednode.angles;
  self.var_4568897d5b592329 = 1;
  self.customarrivalhandler = &cap_custom_arrival_handler;
  self.capdata = spawnStruct();
  self.capdata.arrivalangles = scriptednode.angles;
  self.capdata.asmname = capname;
  self.capdata.var_ec117174c7bbdce6 = 0;
  self waittill("bt_goal");
  waitforalignment(scriptednode.angles);

  if(self.capdata.var_ec117174c7bbdce6) {
    self waittill("custom_arrival_handler_done");
    self notify("lerp_arrive_finished");
  } else {
    self notify("lerp_arrive_finished");
    cap_start(capname, animset);
  }

  asm::asm_fireephemeralevent("move", "end");
  self.pushable = oldpushable;
  self.capdata = undefined;
  self notify("cap_reach_and_arrive");
}

function waitforalignment(skitangle) {
  timeout = gettime() + 3000;

  while(gettime() < timeout) {
    anglediff = skitangle[1] - self.angles[1];

    if(abs(anglediff) < 2) {
      break;
    }

    waitframe();
  }
}

function private cap_custom_arrival_handler() {
  self endon("death");
  self endon("cap_exit_completed");
  assert(isDefined(self.capdata));
  self.capdata.var_ec117174c7bbdce6 = 1;
  cap_start(self.capdata.asmname, self.customarrivalanimset);
  initstate = self asmgetcurrentstate(self.asmname);
  self asmsetstate(self.asmname, self.customarrivalstate);
  timeouttime = gettime() + 10000;

  while(!asm::asm_eventfired(self.asmname, "end") && gettime() < timeouttime) {
    waitframe();
  }

  if(isDefined(self.capdata) && isDefined(self.capdata.var_ec117174c7bbdce6)) {
    self.capdata.var_ec117174c7bbdce6 = 0;
  }

  self asmsetstate(self.asmname, initstate);
  self notify("custom_arrival_handler_done");
}

function function_f97b52e357e14785(group) {
  assert(isarray(group));

  if(!isDefined(level.capgroups)) {
    level.capgroups = [];
  }

  newcapgroup = level.capgroups.size;
  level.capgroups[newcapgroup] = group;

  foreach(ent in group) {
    ent.capgroup = newcapgroup;
  }
}

function function_1dc69bd8c64496fc() {
  assert(isDefined(level.capgroups) && isDefined(self.capgroup) && isDefined(level.capgroups[self.capgroup]));

  if(level.capgroups[self.capgroup].size == 0) {}
}

function function_82acad1b355efb61() {
  if(isDefined(level.sight_trace_queue) && utility::function_9dac7ef683ed0e52(level.sight_trace_queue, self)) {
    level notify("player_look_at_process");

    if(isDefined(level.civreactdata.lookatlock)) {
      level.civreactdata.lookatlock = 0;
    }

    if(isDefined(level.sight_trace_queue)) {
      level.sight_trace_queue = undefined;
    }
  }

  if(isDefined(level.var_795e84d9e048e019) && utility::function_9dac7ef683ed0e52(level.var_795e84d9e048e019, self)) {
    level notify("civilian_process_eye_look_at");

    if(isDefined(level.civreactdata.civilianlookatlock)) {
      level.civreactdata.civilianlookatlock = 0;
    }

    if(isDefined(level.var_795e84d9e048e019)) {
      level.var_795e84d9e048e019 = undefined;
    }
  }
}

function cap_prop(capname, animset) {
  self.asmname = capname;

  if(!isDefined(self.asm)) {
    self.asm = spawnStruct();
    self.asm.animoverrides = [];
  }

  self.animsetname = animset;
  self.animationarchetype = undefined;
}

function function_bb57e4c61b3b6dbd(states, var_56f54d90816c4970) {
  self.resumestatetime = [];

  if(!isarray(states)) {
    states = [states];
  }

  foreach(state in states) {
    self.resumestatetime[state] = 0;
  }

  if(isDefined(var_56f54d90816c4970)) {
    self.var_2fa91f90efb30033 = var_56f54d90816c4970;
  }
}

function function_61f1ed9cea162fab(states) {
  if(!isarray(states)) {
    states = [states];
  }

  self.relativestates = states;
}

function private function_82491e1bc74dd239(capasmname, arrivalstate, finalpos, animset) {
  path = findpathcustom(self.origin, finalpos);

  if(!isDefined(path) || path.size < 2) {
    assert("<dev string:x8d>");
    return undefined;
  }

  approachang = vectortoangles(finalpos - path[path.size - 2]);
  anglediff = angleclamp180(self.scriptedarrivalent.angles[1] - approachang[1]);
  angleindex = getangleindex(anglediff, 22.5);

  if(angleindex == 8) {
    angleindex = 0;
  }

  nextindexsign = anglediff + getangleoffset(angleindex);

  if(nextindexsign < 0) {
    nextindexsign = -1;
  } else {
    nextindexsign = 1;
  }

  nextindex = nextindexsign;
  array = function_42a823c020248a21(angleindex, nextindexsign);

  for(arrayindex = 0; arrayindex < array.size; arrayindex++) {
    caparrivalanim = function_845718f590c62817(arrivalstate, animset, array[arrayindex]);

    if(isDefined(caparrivalanim)) {
      pos = function_6de1b23288eb153f(finalpos, angleindex, array[arrayindex], nextindexsign, caparrivalanim);

      if(isarray(pos)) {
        self setgoalpath([pos[0], pos[1]]);
        return pos;
      }

      if(isDefined(pos)) {
        self setbtgoalRadius(1, 10);
        self setbtgoalpos(1, pos);
        return pos;
      }
    }
  }

  assert(isDefined(pos), "<dev string:xbb>");
  return pos;
}

function private function_6de1b23288eb153f(goalpos, angleindex, closestangleindex, nextindexsign, xanim) {
  addangle = (0, getangleoffset(closestangleindex), 0);
  newangle = combineangles(self.interaction_angles, addangle);
  movedelta = getmovedelta(xanim, 0, 1);
  arrivalanimdis = distance2d((0, 0, 0), movedelta);
  adddistance = 40;
  approachpos = goalpos - anglesToForward(newangle) * (arrivalanimdis + adddistance);
  navtraceresult = navtrace(goalpos, approachpos, self, 0);

  if(navtraceresult) {
    return undefined;
  }

  diff = angleindex - closestangleindex;

  if(abs(diff) == 4) {
    detourindex = closestangleindex + nextindexsign * -1;

    if(detourindex > 7) {
      detourindex -= 8;
    } else if(detourindex < 0) {
      detourindex += 8;
    }

    addangle = (0, getangleoffset(detourindex), 0);
    newangle = combineangles(self.interaction_angles, addangle);
    detourpos = goalpos - anglesToForward(newangle) * (arrivalanimdis + adddistance);
    navtraceresult = navtrace(detourpos, approachpos, self, 0);

    if(!navtraceresult) {
      listpos = [detourpos, approachpos];
      return listpos;
    }
  }

  return approachpos;
}

function private getangleoffset(index) {
  anglearray = [180, 135, 90, 45, 0, -45, -90, -135];
  return anglearray[index];
}

function private function_845718f590c62817(statename, animset, index) {
  aliasesindex = [8, 9, 6, 3, 2, 1, 4, 7, 8];
  angleindex = aliasesindex[index];

  if(angleindex == 8) {
    angleindex = "8l";
    leftindex = "left" + angleindex;
    leftalias = archetypegetalias(animset, statename, leftindex, 1);
    rightindex = "right" + angleindex;
    rightalias = archetypegetalias(animset, statename, rightindex, 1);

    if(isDefined(leftalias) && isDefined(rightalias)) {
      return leftalias.anims;
    }

    angleindex = "8r";
  }

  leftindex = "left" + angleindex;
  leftalias = archetypegetalias(animset, statename, leftindex, 1);
  rightindex = "right" + angleindex;
  rightalias = archetypegetalias(animset, statename, rightindex, 1);

  if(isDefined(leftalias)) {
    assert(isDefined(rightalias), "<dev string:x119>" + leftindex + "<dev string:x12d>" + rightindex);
  }

  if(isDefined(rightalias)) {
    assert(isDefined(leftalias), "<dev string:x119>" + rightindex + "<dev string:x12d>" + leftindex);
  }

  if(isDefined(leftalias) && isDefined(rightalias)) {
    return leftalias.anims;
  }
}

function private function_42a823c020248a21(angleindex, nextindexsign) {
  closestangleindex = angleindex;
  nextindex = nextindexsign;
  arrayindex = 0;
  array[arrayindex] = closestangleindex;

  for(nextangleindex = 1; nextangleindex < 5; nextangleindex++) {
    for(checkbothsides = 0; checkbothsides < 2; checkbothsides++) {
      arrayindex++;
      closestangleindex = angleindex + nextangleindex * nextindex;

      if(closestangleindex < 0) {
        closestangleindex += 8;
      } else if(closestangleindex > 7) {
        closestangleindex -= 8;
      }

      array[arrayindex] = closestangleindex;
      nextindex *= -1;

      if(nextangleindex == 4) {
        break;
      }
    }
  }

  return array;
}