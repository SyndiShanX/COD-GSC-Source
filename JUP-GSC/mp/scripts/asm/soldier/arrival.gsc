/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\asm\soldier\arrival.gsc
***********************************************/

#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\cover;
#using scripts\asm\soldier\script_funcs;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace arrival;

function notshouldstartarrival(asmname, statename, tostatename, params) {
  return !shouldstartarrival(asmname, statename, params);
}

function getmaxarrivaldistfornodetype(nodetype) {
  return 256;
}

function shouldstartarrival(asmname, statename, tostatename, params) {
  if(!self shoulddoarrival()) {
    return false;
  }

  if(!isDefined(self.pathgoalpos)) {
    return false;
  }

  node = getarrivalnode();

  if(!asm_eventfired(asmname, "cover_approach")) {
    return false;
  }

  if(isDefined(params)) {
    if(!isarray(params)) {
      nodetype = params;
    } else if(params.size < 1) {
      nodetype = "Exposed";
    } else {
      nodetype = params[0];
    }
  } else {
    nodetype = "Exposed";
  }

  if(!isarrivaltype(asmname, statename, tostatename, nodetype)) {
    return false;
  }

  dist_to_goal = distance(self.origin, self.pathgoalpos);
  var_1047326b5402e964 = getmaxarrivaldistfornodetype(nodetype);

  if(dist_to_goal > var_1047326b5402e964) {
    return false;
  }

  var_5217df91f13c7c48 = 0;

  if(isDefined(params) && params.size > 1) {
    var_5217df91f13c7c48 = int(params[1]);
  }

  prefixstr = undefined;
  startnotetrack = undefined;
  endnotetrack = undefined;

  if(nodetype == "Exposed Moving") {
    endnotetrack = "code_move";
  }

  demeanor = asm_getdemeanor();

  if(demeanor == "casual" || demeanor == "casual_gun" || demeanor == "patrol") {
    var_ae21c8641e5e4f38 = 0.053;

    if(self pathdisttogoal() < 25) {
      var_ae21c8641e5e4f38 = 2;
    }

    self.asm.stopdata = calculatestopdata(asmname, statename, tostatename, nodetype, var_5217df91f13c7c48, undefined, prefixstr, var_ae21c8641e5e4f38, undefined, startnotetrack, endnotetrack);
  } else {
    self.asm.stopdata = calculatestopdata(asmname, statename, tostatename, nodetype, var_5217df91f13c7c48, undefined, prefixstr, undefined, undefined, startnotetrack, endnotetrack);
  }

  if(!isDefined(self.asm.stopdata)) {
    return false;
  }

  return true;
}

function shouldstartcasualarrivalaftercodemove(asmname, statename, tostatename, params) {
  if(!asm_eventfired(asmname, "code_move")) {
    return 0;
  }

  return shouldstartcasualarrival(asmname, statename, tostatename, params);
}

function shouldstartcasualarrival(asmname, statename, tostatename, params) {
  demeanor = asm_getdemeanor();

  if(!isDefined(params) || demeanor != params[2]) {
    return false;
  }

  return shouldstartarrival(asmname, statename, tostatename, params);
}

function shouldstartcasualarrivalwithgunaftercodemove(asmname, statename, tostatename, params) {
  if(!asm_eventfired(asmname, "code_move")) {
    return 0;
  }

  return shouldstartcasualarrivalwithgun(asmname, statename, tostatename, params);
}

function shouldstartcasualarrivalwithgun(asmname, statename, tostatename, params) {
  demeanor = asm_getdemeanor();

  if(!isDefined(params) || demeanor != params[2]) {
    return false;
  }

  return shouldstartarrival(asmname, statename, tostatename, params);
}

function chooseanim_arrival(asmname, statename, params) {
  assert(isDefined(self.asm.stopdata));
  return self.asm.stopdata;
}

function function_cf21d79464e005d2(node) {
  nodepos = node.origin;

  if(shouldinitiallyattackfromexposed() && self._blackboard.shouldarrivetocoverexposedstepouttype != "none" && isDefined(node.type)) {
    switch (node.type) {
      case #"hash_667bc7e605903a6c":
      case #"hash_cd3ffe799551db82":
        if(self._blackboard.shouldarrivetocoverexposedstepouttype == "full_exposed") {
          offset = (-15, -44, 0);
          nodepos += rotatevector(offset, node.angles);
        } else if(self._blackboard.shouldarrivetocoverexposedstepouttype == "lean") {
          offset = (-6, -10, 0);
          nodepos += rotatevector(offset, node.angles);
        }

        break;
      case #"hash_55ed607005f12d49":
      case #"hash_e1d8e1adebed5a61":
        if(self._blackboard.shouldarrivetocoverexposedstepouttype == "full_exposed") {
          offset = (-15, 44, 0);
          nodepos += rotatevector(offset, node.angles);
        } else if(self._blackboard.shouldarrivetocoverexposedstepouttype == "lean") {
          offset = (-6, 10, 0);
          nodepos += rotatevector(offset, node.angles);
        }

        break;
      case #"hash_78b110033ccb68b0":
      case #"hash_c3b74422dec48736":
        assert(self._blackboard.shouldarrivetocoverexposedstepouttype == "<dev string:x1c>");
        offset = (-8, 0, 0);
        nodepos += rotatevector(offset, node.angles);
        break;
      case #"hash_961a09cded5ffc80":
        break;
      default:
        assertmsg("<dev string:x2c>" + node.type);
        break;
    }
  }

  return nodepos;
}

function calculatestopdata(asmname, statename, tostatename, nodetype, var_5217df91f13c7c48, codeapproachdir, optionalprefix, var_a9d2a260c9698ff4, overshootratio, startnotetrack, endnotetrack, speedstring) {
  node = getarrivalnode();
  toanimset = undefined;

  if(isDefined(node) && !self btgoalvalid() && isDefined(self.scriptedarrivalent) && self.scriptedarrivalent == node) {
    if(distance2dsquared(self.scriptedarrivalent.origin, self.pathgoalpos) > 4096) {
      if(!isDefined(self.scriptedarrivalent.calculatestopdatawarningtime) || self.scriptedarrivalent.calculatestopdatawarningtime < gettime() - level.frameduration) {
        self.scriptedarrivalent.calculatestopdatawarningtime = gettime();
      } else {
        assertmsg("<dev string:x83>");
        self.scriptedarrivalent delete();
        self.scriptedarrivalent = undefined;
        node = getarrivalnode();
      }
    }
  }

  goalpos = undefined;

  if(isDefined(node)) {
    goalpos = function_cf21d79464e005d2(node);
  } else {
    goalpos = self.pathgoalpos;
  }

  flatdir = goalpos - self.origin;
  flatdir = vectorNormalize((flatdir[0], flatdir[1], 0));

  if(vectordot(flatdir, anglesToForward(self.angles)) < 0.707) {
    return undefined;
  }

  if(nodetype == "Custom") {
    tostatename = self.customarrivalstate;

    if(isDefined(self.customarrivalanimset)) {
      toanimset = self.customarrivalanimset;
    }

    var_5217df91f13c7c48 = self.var_171120e99df3e286;
  }

  if(!isDefined(optionalprefix)) {
    optionalprefix = "";
  }

  prefixfoot = "";

  if(var_5217df91f13c7c48) {
    foot = "left";

    if(asm_eventfiredrecently(asmname, "pass_left")) {
      foot = "left";
    } else if(asm_eventfiredrecently(asmname, "pass_right")) {
      foot = "right";
    } else if(self.asm.footsteps.foot == "right") {
      foot = "right";
    }

    if(isDefined(optionalprefix)) {
      prefixfoot = optionalprefix + foot;
    } else {
      prefixfoot = foot;
    }
  } else {
    prefixfoot = optionalprefix;
  }

  nodefaceangles = nodeshouldfaceangles(node);
  yaw = undefined;
  angles = undefined;

  if((nodetype == "Exposed" || nodetype == "Exposed Crouch") && (recentlysawenemy() || shouldinitiallyattackfromexposed())) {
    if(!self bb_shootparamsvalid() && !isDefined(self.smartfacingpos)) {
      if(isDefined(node) && isDefined(node.angles)) {
        yaw = node.angles[1];
        angles = node.angles;
        nodefaceangles = 1;
      } else {
        nodefaceangles = 0;
      }
    } else {
      rotateamount = getturndesiredyaw();
      angles = (0, self.angles[1] + rotateamount, 0);
      yaw = angles[1];
      nodefaceangles = 1;
    }
  } else if(nodefaceangles) {
    yaw = getnodeforwardyaw(node, undefined, 0);
    angles = node.angles;
  }

  result = self actorcalcstopdata(goalpos, angles, getcustomarrivalangles(), codeapproachdir, nodefaceangles, tostatename, yaw, prefixfoot, optionalprefix, var_a9d2a260c9698ff4, overshootratio, nodetype, startnotetrack, endnotetrack, speedstring, toanimset);

  if(isDefined(result) && isDefined(node)) {
    result.var_e411f4722cf5136a = self._blackboard.shouldarrivetocoverexposedstepouttype != "none";
  }

  return result;
}

function playanim_waitforpathset(asmname, statename) {
  self endon("runto_arrived");
  self endon(statename + "_finished");
  self waittill("path_set");
  asm_fireevent(asmname, "abort");
}

function playanim_waitforpathclear(asmname, statename) {
  self endon("runto_arrived");
  self endon(statename + "_finished");

  while(true) {
    if(!isDefined(self.pathgoalpos)) {
      break;
    }

    wait 0.05;
  }

  asm_fireevent(asmname, "abort");
}

function arrivalterminatewait(statename) {
  self endon("death");
  self.asm.arriving = statename;
  self waittill(statename + "_finished");
  self.asm.arriving = undefined;
}

function playanim_arrival_handlestandevent(asmname, statename, xanim, finalrate) {
  self endon(statename + "_finished");
  self.asm.arrivalstopfired = 0;
  movedelta = getmovedelta(xanim, 0, 1);
  animtime = getanimlength(xanim);
  decrement = 0.05 / animtime;
  currenttime = 1 - decrement;

  while(currenttime > 0) {
    partialmovedelta = getmovedelta(xanim, 0, currenttime);

    if(lengthsquared(movedelta - partialmovedelta) >= 64) {
      break;
    }

    currenttime -= decrement;
  }

  waittime = currenttime * animtime / finalrate;

  if(waittime > 0) {
    wait waittime;
  }

  self.asm.arrivalstopfired = 1;
}

function returnoncorner(note) {
  if(note == "corner") {
    return 1;
  }
}

function returnonwarpstart(note) {
  if(note == "warp_arrival_start") {
    return 1;
  }
}

function calculateadjustedspeedforshortpath(desiredspeed, pathdist) {
  var_87e7a006522a7fa3 = 64;
  var_a0bbb0351fa8ec9d = 110;

  if(pathdist >= var_87e7a006522a7fa3 && pathdist <= var_a0bbb0351fa8ec9d) {
    t = (pathdist - var_87e7a006522a7fa3) / (var_a0bbb0351fa8ec9d - var_87e7a006522a7fa3);
    targetspeed = self aigettargetspeed();
    return ((1 - t) * targetspeed + t * desiredspeed);
  }

  return desiredspeed;
}

function playanim_arrival(asmname, statename, params) {
  self endon(statename + "_finished");
  arrival_rate = 1;

  if(isDefined(params)) {
    arrival_rate = params;
  }

  self.asm.arrivalasmstatename = statename;
  self.a.arrivalasmstatename = statename;
  thread arrivalterminatewait(statename);
  stopdata = asm_getanim(asmname, statename);
  assertex(isDefined(stopdata), "<dev string:x129>");

  if(!isDefined(stopdata)) {
    self orientmode("face motion");
    asm_fireevent(asmname, "abort", undefined);
    return;
  }

  self orientmode("face angle", self.angles[1]);
  facingangles = stopdata.finalangles;
  angleindex = stopdata.angleindex;
  facingyaw = (0, facingangles[1] - stopdata.angledelta, 0);
  var_55644d08241b1a7b = stopdata.startpos;
  coverarrivalyaw = facingyaw[1];

  if(isDefined(stopdata.parentpos) && isDefined(stopdata.parentangles)) {
    localdelta = stopdata.startpos - stopdata.parentpos;
    localdelta = rotatevectorinverted(localdelta, stopdata.parentangles);
    invangles = invertangles(stopdata.parentangles);
    localangles = combineangles(facingyaw, invangles);
    parentent = self getnavspaceent();
    assertex(isDefined(parentent), "<dev string:x144>");
    localdelta = rotatevector(localdelta, parentent.angles);
    var_55644d08241b1a7b = localdelta + parentent.origin;
    newangles = combineangles(localangles, parentent.angles);
    coverarrivalyaw = newangles[1];
  }

  arrivalstatename = statename;

  if(isDefined(self.customarrivalstate)) {
    arrivalstatename = self.customarrivalstate;
  }

  stopanim = stopdata.stopanim;

  if(isDefined(self.asm.customdata) && isDefined(self.customarrivalanimset)) {
    self setoverridearchetype("animscript", self.customarrivalanimset, 1);
  }

  stopxanim = asm_getxanim(arrivalstatename, stopanim);
  arrival_node = getarrivalnode();

  if(isDefined(stopdata.customtargetpos)) {
    goalpos = stopdata.customtargetpos;
  } else {
    if(isDefined(arrival_node)) {
      goalpos = function_cf21d79464e005d2(arrival_node);
    } else {
      goalpos = self.pathgoalpos;
    }

    self._blackboard.arrivingtocoverexposed = istrue(stopdata.var_e411f4722cf5136a);
  }

  if(!istrue(stopdata.bskipstartcoverarrival)) {
    self startcoverarrival();
  }

  if(animhasnotetrack(stopxanim, "code_move")) {
    self animmode("zonly_physics", 0);
    animrate = motionwarpwithnotetracks(stopxanim, goalpos, stopdata.finalangles, undefined, "corner", undefined);
    self aisetanim(arrivalstatename, stopanim, animrate);
    asm_donotetracks(asmname, statename, &returnoncorner, undefined, arrivalstatename);
    self aisetanim(arrivalstatename, stopanim, 1);
    asm_donotetracks(asmname, statename, undefined, undefined, arrivalstatename);
    return;
  }

  if(isDefined(self.customarrivalanimmode)) {
    anim_mode = self.customarrivalanimmode;
    self animmode(anim_mode);
  } else {
    self animmode("zonly_physics", 0);
  }

  asm_playfacialanim(asmname, statename, stopxanim);
  stoprate = 1;

  if(isDefined(goalpos)) {
    animdist = length(stopdata.movedelta);
    disttogoal = length(self.origin - goalpos);

    if(disttogoal > 1) {
      stoprate = animdist / length(self.origin - goalpos);
    }

    stoprate = clamp(stoprate, 0.8, 1.3);
  }

  finalrate = arrival_rate * stoprate;

  if(isDefined(self.asm.arrivalspeed)) {
    finalrate *= self.asm.arrivalspeed;
  }

  if(isDefined(self.arrivalspeedtarget) && isDefined(self.arrivaldesiredspeed) && isentasoldier() && demeanorhasblendspace()) {
    finalrate = self.arrivaldesiredspeed / self.arrivalspeedtarget;
    self.arrivaldesiredspeed = undefined;
    var_42d8ce9773183805 = 0.8;
    finalrate = max(var_42d8ce9773183805, finalrate);
  }

  thread playanim_arrival_handlestandevent(asmname, statename, stopxanim, finalrate);
  self aisetanim(arrivalstatename, stopanim, finalrate);
  end_time = 1;

  if(animhasnotetrack(stopxanim, "warp_arrival_start")) {
    assert(animhasnotetrack(stopxanim, "<dev string:x1bd>"));
    startnote = getnotetracktimes(stopxanim, "warp_arrival_start");
    endnote = getnotetracktimes(stopxanim, "warp_arrival_end");

    if(startnote[0] > 0) {
      asm_donotetracks(asmname, statename, &returnonwarpstart, undefined, arrivalstatename, 0);
    }

    animlength = getanimlength(stopxanim);
    warpstarttime = startnote[0];

    if(warpstarttime > 0) {
      warpstarttime = startnote[0] * animlength * 1000;
      warpstarttime -= mod(int(warpstarttime), level.frameduration);
      warpstarttime = warpstarttime / animlength / 1000;
    }

    end_time = endnote[0];
    duration = int((end_time - warpstarttime) * animlength / finalrate * 1000);
    duration += level.frameduration - mod(duration, level.frameduration);
    motionwarpwithtimes(stopxanim, goalpos, stopdata.finalangles, warpstarttime, 1, duration, 0);
  } else {
    warpduration = 500;

    if(animhasnotetrack(stopxanim, "start_aim")) {
      end_time = getnotetracktimes(stopxanim, "start_aim")[0];
      anim_length = getanimlength(stopxanim);
      warpduration = int(end_time * anim_length / finalrate * 1000);

      if(warpduration < 300 && anim_length / finalrate >= 0.15) {
        warpduration = 300;
      }
    }

    self motionwarpwithanim(var_55644d08241b1a7b, facingyaw, goalpos, stopdata.finalangles, warpduration);
  }

  if(!isagent(self)) {
    anime = asm_lookupanimfromaliasifexists(statename, "conceal_add");

    if(isDefined(anime) && isDefined(arrival_node) && isDefined(arrival_node.type) && (arrival_node.type == "Conceal Crouch" || arrival_node.type == "Conceal Stand")) {
      conceal_xanim = asm_getxanim(statename, anime);
      animlength = getanimlength(stopxanim);
      var_5ea036af2c7394cb = animlength * end_time * 0.3;
      thread scripts\asm\soldier\cover::start_conceal_add(statename, conceal_xanim, var_5ea036af2c7394cb);
    }
  }

  asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename), undefined, arrivalstatename);
  self.a.movement = "stop";
}

function getcustomarrivalangles() {
  if(isDefined(self.customarrivalangles)) {
    return self.customarrivalangles;
  }

  return undefined;
}

function getstopanims(asmname, statename, approachtype, var_5217df91f13c7c48, optionalprefix) {
  assert(!asm_hasalias(statename, "<dev string:x1d1>"));
  assert(!asm_hasalias(statename, "<dev string:x1d6>"));
  stopanims = [];
  stopanims[5] = asm_lookupdirectionalfootanim(1, asmname, statename, var_5217df91f13c7c48, optionalprefix);
  stopanims[4] = asm_lookupdirectionalfootanim(2, asmname, statename, var_5217df91f13c7c48, optionalprefix);
  stopanims[3] = asm_lookupdirectionalfootanim(3, asmname, statename, var_5217df91f13c7c48, optionalprefix);
  stopanims[6] = asm_lookupdirectionalfootanim(4, asmname, statename, var_5217df91f13c7c48, optionalprefix);
  stopanims[2] = asm_lookupdirectionalfootanim(6, asmname, statename, var_5217df91f13c7c48, optionalprefix);
  stopanims[7] = asm_lookupdirectionalfootanim(7, asmname, statename, var_5217df91f13c7c48, optionalprefix);
  stopanims[0] = asm_lookupdirectionalfootanim(8, asmname, statename, var_5217df91f13c7c48, optionalprefix);
  stopanims[1] = asm_lookupdirectionalfootanim(9, asmname, statename, var_5217df91f13c7c48, optionalprefix);
  stopanims[8] = stopanims[0];
  return stopanims;
}

function function_a6a36944d51a88a0(optimalstartpos, tracestartpos, finalpos, fraction, color, frames) {
  if(!scripts\asm\asm::debug_arrivals_on_actor()) {
    return;
  }

  line(optimalstartpos, optimalstartpos + (0, 0, 64), color, 1, 1, frames);
  midpoint = vectorlerp(tracestartpos, finalpos, fraction);
  line(tracestartpos, midpoint, (0, 1, 0), 1, 1, frames);
  line(midpoint, finalpos, (1, 0, 0), 1, 1, frames);
}

function function_51eac561da90b300(goal_origin, arrival_angles) {
  if(scripts\asm\asm::debug_arrivals_on_actor()) {
    forward = anglesToForward(arrival_angles);
    line(goal_origin, goal_origin + forward * 16, (1, 0.4, 0), 1, 0, 1);
    line(goal_origin, goal_origin + (0, 0, 64), (1, 0.4, 0), 1, 0, 1);
  }
}

function shouldstartarrivalpassthrough(asmname, statename, tostatename, params) {
  assertmsg("<dev string:x1db>");
  return false;
}