/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\common\cap.gsc
***********************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\cap;
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
    msg2 = "but is currently playing a scripted anim. This is not supported - you either need to avoid starting";
    msg3 = " a CAP when the AI is scripted, or first clear the scripted state using the normal method.";
    assertmsg(msg1 + msg2 + msg3);
    return;
  }

  self.caporigin = self.origin;
  self.capangles = self.angles;
  self notify("cap_start");

  if(!isai(self)) {
    self._blackboard = spawnStruct();
    self._blackboard.bfire = 0;
    function_b69db84955df12e5(capname, animset);
    return;
  } else {
    self._blackboard.bseqphase = undefined;
  }

  assert(isalive(self) && isDefined(self.asm));
  self setoverridearchetype("animscript", animset, 0);
  self function_24eb7f77bc5e5950(capname);
  cap_terminateandreplace(capname);

  if(istrue(animscripted)) {
    bb_setanimScripted();
  }
}

function function_b69db84955df12e5(baseasmname, archetypename) {
  if(archetypename == "hero_salter" || archetypename == "farah" || archetypename == "soldier_female") {
    scripts\asm\asm_bb::bb_setshort(1);
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
    level thread function_896667bf7f3ed3dc();
  }

  if(!array_contains(level.capscriptmodels, self)) {
    level.capscriptmodels[level.capscriptmodels.size] = self;
  }
}

function function_896667bf7f3ed3dc() {
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

    if(array_contains(level.capscriptmodels, self)) {
      level.capscriptmodels = array_remove(level.capscriptmodels, self);
    }

    return;
  }

  assert(self.asmname != self.defaultasm, "Calling cap_exit when in default asm: " + self.defaultasm);

  if(self.asmname == self.defaultasm) {
    return;
  }

  if(bb_isanimScripted()) {
    bb_clearanimScripted();
  }

  self.asmtrackasm = undefined;
  self clearcap();
  self.var_30452ad282afcd76 = undefined;

  if(isDefined(self.capgroup)) {
    function_5a9987f1e5bbd641();
  }

  function_3327078daa3ecd38();
  self notify("cap_exit_completed");
}

function function_a996f137b4ef05ed() {
  self endon("entitydeleted");
  self endon("cap_exit_completed");

  if(self.team == "axis") {
    waittill_either("death", utility::function_a1260c3b5f229f69());
  } else {
    self waittill("death");
  }

  if(bb_isanimScripted()) {
    bb_clearanimScripted();
  }

  self stopanimScripted();
  self clearoverridearchetype("animscript");
  self function_24eb7f77bc5e5950(undefined);
  cap_terminateandreplace(self.defaultasm);

  if(isDefined(self.capgroup)) {
    function_5a9987f1e5bbd641();
  }

  function_3327078daa3ecd38();
  self notify("cap_exit_completed");
}

function function_b58f0a57adf2948e(origin, capname, animset, var_9e6dcf179d658229) {
  self endon("death");

  if(isDefined(var_9e6dcf179d658229) && var_9e6dcf179d658229) {
    self.oldscriptgoalpos = self.scriptgoalpos;
    self.oldgoalradius = self.goalradius;
  }

  self setgoalpos(origin, 1);
  self waittill("goal");
  scripts\common\cap::cap_start(capname, animset);
  self waittill("cap_exit_completed");

  if(isDefined(self.oldscriptgoalpos)) {
    self setgoalpos(self.oldscriptgoalpos, self.oldgoalradius);
    self.oldscriptgoalpos = undefined;
    self.oldgoalradius = undefined;
  }
}

function function_3a8bc84c604f9755() {
  msg = waittill_any_return_2("cap_reach_and_arrive", "bseq_user_deleted");

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

function cap_reach_and_arrive(scriptednode, capname, animset, var_26b7b68bee5a2349) {
  assert(isDefined(scriptednode.origin));
  self notify("cap_reach_and_arrive");
  self endon("cap_reach_and_arrive");
  thread function_3a8bc84c604f9755();
  self endon("bseq_user_deleted");

  if(!isDefined(self.scriptedarrivalent)) {
    self.scriptedarrivalent = spawn("script_origin", scriptednode.origin);
  }

  self.scriptedarrivalent.angles = scriptednode.angles;
  self.scriptedarrivalent.origin = scriptednode.origin;
  self.scriptedarrivalent.type = "Custom";
  arrival_state = "cap_arrival";

  if(isDefined(var_26b7b68bee5a2349)) {
    arrival_state = var_26b7b68bee5a2349;
  }

  oldpushable = self.pushable;
  self.pushable = 0;
  goalpos = getclosestpointonnavmesh(scriptednode.origin, self);
  distancesq = distancesquared(goalpos, scriptednode.origin);

  if(distancesq >= 10000) {
    goalrad = 32;
    self setbtgoalRadius(1, goalrad);
    self setbtgoalpos(1, scriptednode.origin);
  } else {
    goalrad = 4;
    self setbtgoalRadius(1, goalrad);
    self setbtgoalpos(1, goalpos);
  }

  asm_fireephemeralevent("path_chosen", "end");
  assertex(archetypehasstate(animset, arrival_state), "Cap Arc (" + animset + ") has no arrival state (" + arrival_state + ")!");
  self.customarrivalstate = arrival_state;
  self.customarrivalanimset = animset;
  self.customarrivalangles = scriptednode.angles;
  self.var_171120e99df3e286 = 1;
  self.customarrivalhandler = &function_e1c21b37d95134a;
  self.capdata = spawnStruct();
  self.capdata.arrivalangles = scriptednode.angles;
  self.capdata.asmname = capname;
  self.capdata.var_74c9b1f78857273d = 0;
  self waittill("bt_goal");

  if(istrue(self.capdata.var_74c9b1f78857273d)) {
    self waittill("custom_arrival_handler_done");
    self notify("lerp_arrive_finished");
  } else {
    self notify("lerp_arrive_finished");
    cap_start(capname, animset);
  }

  asm_fireephemeralevent("move", "end");
  self.pushable = oldpushable;
  self.capdata = undefined;
  self notify("cap_reach_and_arrive");
}

function private function_e1c21b37d95134a() {
  self endon("death");
  self endon("cap_exit_completed");
  assert(isDefined(self.capdata));
  self.capdata.var_74c9b1f78857273d = 1;
  cap_start(self.capdata.asmname, self.customarrivalanimset);
  initstate = self asmgetcurrentstate(self.asmname);
  self asmsetstate(self.asmname, self.customarrivalstate);
  timeouttime = gettime() + 5000;

  while(!asm_eventfired(self.asmname, "end") && gettime() < timeouttime) {
    waitframe();
  }

  if(isDefined(self.capdata) && isDefined(self.capdata.var_74c9b1f78857273d)) {
    self.capdata.var_74c9b1f78857273d = 0;
  }

  self asmsetstate(self.asmname, initstate);
  self notify("custom_arrival_handler_done");
}

function function_a1ed6ae80ed92596(group) {
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

function function_5a9987f1e5bbd641() {
  assert(isDefined(self.capgroup) && isDefined(level.capgroups) && isDefined(level.capgroups[self.capgroup]));
  level.capgroups[self.capgroup] array_remove(level.capgroups[self.capgroup], self);

  if(level.capgroups[self.capgroup].size == 0) {
    array_remove(self.capgroup, level.capgroups);
  }
}

function function_3327078daa3ecd38() {
  if(isDefined(level.sight_trace_queue) && function_a6025442a4e1c649(level.sight_trace_queue, self)) {
    level notify("player_look_at_process");

    if(isDefined(level.civreactdata.lookatlock)) {
      level.civreactdata.lookatlock = 0;
    }

    if(isDefined(level.sight_trace_queue)) {
      level.sight_trace_queue = undefined;
    }
  }

  if(isDefined(level.var_3fe0abfd459c8d0) && function_a6025442a4e1c649(level.var_3fe0abfd459c8d0, self)) {
    level notify("civilian_process_eye_look_at");

    if(isDefined(level.civreactdata.civilianlookatlock)) {
      level.civreactdata.civilianlookatlock = 0;
    }

    if(isDefined(level.var_3fe0abfd459c8d0)) {
      level.var_3fe0abfd459c8d0 = undefined;
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

function function_882c76a8f1f5f9a6(states, var_b4c3697a9d2ed329) {
  self.resumestatetime = [];

  if(!isarray(states)) {
    states = [states];
  }

  foreach(state in states) {
    self.resumestatetime[state] = 0;
  }

  if(isDefined(var_b4c3697a9d2ed329)) {
    self.var_dcf5e86549620338 = var_b4c3697a9d2ed329;
  }
}

function function_a05f4d85f33e9eea(states) {
  if(!isarray(states)) {
    states = [states];
  }

  self.relativestates = states;
}