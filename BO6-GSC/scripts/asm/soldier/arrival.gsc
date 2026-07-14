/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\soldier\arrival.gsc
*******************************************/

#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\cover;
#using scripts\asm\soldier\script_funcs;
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

  node = utility::getarrivalnode();

  if(!asm::asm_eventfired(asmname, "\x1b\xb7\xd9+\x9c\xbe\xb0\x1c\a'\xbd\vcC")) {
    return false;
  }

  if(isDefined(params)) {
    if(!isarray(params)) {
      nodetype = params;
    } else if(params.size < 1) {
      nodetype = "\xf7\xd5d'hTb";
    } else {
      nodetype = params[0];
    }
  } else {
    nodetype = "\xf7\xd5d'hTb";
  }

  if(!utility::isarrivaltype(asmname, statename, tostatename, nodetype)) {
    return false;
  }

  var_7f06cad5c83fffca = distance(self.origin, self.pathgoalpos);
  var_b05cfbc892ecac31 = getmaxarrivaldistfornodetype(nodetype);

  if(var_7f06cad5c83fffca > var_b05cfbc892ecac31) {
    return false;
  }

  var_6da5aab1b4d0be85 = 0;

  if(isDefined(params) && params.size > 1) {
    var_6da5aab1b4d0be85 = int(params[1]);
  }

  prefixstr = undefined;
  startnotetrack = undefined;
  endnotetrack = undefined;

  if(nodetype == "\xe3\xb6\xb0\xcf\xb8\xfdI?+\x9d^`\xaf\xef") {
    endnotetrack = "f\x97\xb9`\xd1~\x80(\xca";
  }

  demeanor = asm::asm_getdemeanor();

  if(demeanor == "#yDV,\xd6" || demeanor == "4\xb1\xe7\xcd\xb6\xc0\xff\x9f\xd0\xf5" || demeanor == "T\x1d\xd9\x0e L") {
    var_23eef200c3faf7d1 = 0.053;

    if(self pathdisttogoal() < 25) {
      var_23eef200c3faf7d1 = 2;
    }

    self.asm.stopdata = calculatestopdata(asmname, statename, tostatename, nodetype, var_6da5aab1b4d0be85, undefined, prefixstr, var_23eef200c3faf7d1, undefined, startnotetrack, endnotetrack);
  } else {
    self.asm.stopdata = calculatestopdata(asmname, statename, tostatename, nodetype, var_6da5aab1b4d0be85, undefined, prefixstr, undefined, undefined, startnotetrack, endnotetrack);
  }

  if(!isDefined(self.asm.stopdata)) {
    return false;
  }

  return true;
}

function shouldstartcasualarrivalaftercodemove(asmname, statename, tostatename, params) {
  if(!asm::asm_eventfired(asmname, "f\x97\xb9`\xd1~\x80(\xca")) {
    return 0;
  }

  return shouldstartcasualarrival(asmname, statename, tostatename, params);
}

function shouldstartcasualarrival(asmname, statename, tostatename, params) {
  demeanor = asm::asm_getdemeanor();

  if(!isDefined(params) || demeanor != params[2]) {
    return false;
  }

  return shouldstartarrival(asmname, statename, tostatename, params);
}

function shouldstartcasualarrivalwithgunaftercodemove(asmname, statename, tostatename, params) {
  if(!asm::asm_eventfired(asmname, "f\x97\xb9`\xd1~\x80(\xca")) {
    return 0;
  }

  return shouldstartcasualarrivalwithgun(asmname, statename, tostatename, params);
}

function shouldstartcasualarrivalwithgun(asmname, statename, tostatename, params) {
  demeanor = asm::asm_getdemeanor();

  if(!isDefined(params) || demeanor != params[2]) {
    return false;
  }

  return shouldstartarrival(asmname, statename, tostatename, params);
}

function chooseanim_arrival(asmname, statename, params) {
  assert(isDefined(self.asm.stopdata));
  return self.asm.stopdata;
}

function function_55ef720b2ed221ef(node) {
  nodepos = node.origin;

  if(utility::shouldinitiallyattackfromexposed() && self._blackboard.shouldarrivetocoverexposedstepouttype != "\r+x5" && isDefined(node.type)) {
    switch (node.type) {
      case #"hash_667bc7e605903a6c":
      case #"hash_cd3ffe799551db82":
        if(self._blackboard.shouldarrivetocoverexposedstepouttype == "\x88\x97\xead\xae\xdd\x0e\xf4PK\x82\xe4") {
          offset = (-15, -44, 0);
          nodepos += rotatevector(offset, node.angles);
        } else if(self._blackboard.shouldarrivetocoverexposedstepouttype == "\xb7\x10\x05\xc3") {
          offset = (-6, -10, 0);
          nodepos += rotatevector(offset, node.angles);
        }

        break;
      case #"hash_55ed607005f12d49":
      case #"hash_e1d8e1adebed5a61":
        if(self._blackboard.shouldarrivetocoverexposedstepouttype == "\x88\x97\xead\xae\xdd\x0e\xf4PK\x82\xe4") {
          offset = (-15, 44, 0);
          nodepos += rotatevector(offset, node.angles);
        } else if(self._blackboard.shouldarrivetocoverexposedstepouttype == "\xb7\x10\x05\xc3") {
          offset = (-6, 10, 0);
          nodepos += rotatevector(offset, node.angles);
        }

        break;
      case #"hash_78b110033ccb68b0":
      case #"hash_c3b74422dec48736":
        assert(self._blackboard.shouldarrivetocoverexposedstepouttype == "<dev string:x24>");
        offset = (-8, 0, 0);
        nodepos += rotatevector(offset, node.angles);
        break;
      case #"hash_961a09cded5ffc80":
        break;
      default:
        assertmsg("<dev string:x34>" + node.type);
        break;
    }
  }

  return nodepos;
}

function calculatestopdata(asmname, statename, tostatename, nodetype, var_6da5aab1b4d0be85, codeapproachdir, optionalprefix, var_3c5b6ff9c3e47d0d, overshootratio, startnotetrack, endnotetrack, speedstring) {
  node = utility::getarrivalnode();
  toanimset = undefined;

  if(isDefined(node) && !self btgoalvalid() && isDefined(self.scriptedarrivalent) && self.scriptedarrivalent == node) {
    if(distance2dsquared(self.scriptedarrivalent.origin, self.pathgoalpos) > 4096) {
      if(!isDefined(self.scriptedarrivalent.calculatestopdatawarningtime) || self.scriptedarrivalent.calculatestopdatawarningtime < gettime() - level.frameduration) {
        self.scriptedarrivalent.calculatestopdatawarningtime = gettime();
      } else {
        assertmsg("<dev string:x8b>");
        self.scriptedarrivalent delete();
        self.scriptedarrivalent = undefined;
        node = utility::getarrivalnode();
      }
    }
  }

  goalpos = undefined;

  if(isDefined(node)) {
    goalpos = function_55ef720b2ed221ef(node);
  } else {
    goalpos = self.pathgoalpos;
  }

  flatdir = goalpos - self.origin;
  flatdir = vectorNormalize((flatdir[0], flatdir[1], 0));

  if(vectordot(flatdir, anglesToForward(self.angles)) < 0.707) {
    return undefined;
  }

  if(nodetype == "\x1f\x81\xbc\xed\xbf\x02") {
    tostatename = self.customarrivalstate;

    if(isDefined(self.customarrivalanimset)) {
      toanimset = self.customarrivalanimset;
    }

    var_6da5aab1b4d0be85 = self.var_ae2790476708dfb3;
  }

  if(!isDefined(optionalprefix)) {
    optionalprefix = "";
  }

  prefixfoot = "";

  if(var_6da5aab1b4d0be85) {
    foot = "=\xff0b";

    if(asm::asm_eventfiredrecently(asmname, "\xa4\v\xd0\xb3\xc6B\x9f\xae\xef")) {
      foot = "=\xff0b";
    } else if(asm::asm_eventfiredrecently(asmname, "8\x8bWv<9>r\x92\xe7")) {
      foot = "o0\xee\xc1\x8c";
    } else if(self.asm.footsteps.foot == "o0\xee\xc1\x8c") {
      foot = "o0\xee\xc1\x8c";
    }

    if(isDefined(optionalprefix)) {
      prefixfoot = optionalprefix + foot;
    } else {
      prefixfoot = foot;
    }
  } else {
    prefixfoot = optionalprefix;
  }

  nodefaceangles = utility::nodeshouldfaceangles(node);
  yaw = undefined;
  angles = undefined;

  if((nodetype == "\xf7\xd5d'hTb" || nodetype == "\xd6\xc4,\nsG*\a\xaer.\xa4\x11\xe4") && (utility_common::recentlysawenemy() || utility::shouldinitiallyattackfromexposed())) {
    if(!self bb_shootparamsvalid() && !isDefined(self.smartfacingpos)) {
      if(isDefined(node) && isDefined(node.angles)) {
        yaw = node.angles[1];
        angles = node.angles;
        nodefaceangles = 1;
      } else {
        nodefaceangles = 0;
      }
    } else {
      rotateamount = namespace_ad29b7c653247c74::getturndesiredyaw();
      angles = (0, self.angles[1] + rotateamount, 0);
      yaw = angles[1];
      nodefaceangles = 1;
    }
  } else if(nodefaceangles) {
    yaw = utility::getnodeforwardyaw(node, undefined, 0);
    angles = node.angles;
  }

  result = self actorcalcstopdata(goalpos, angles, getcustomarrivalangles(), codeapproachdir, nodefaceangles, tostatename, yaw, prefixfoot, optionalprefix, var_3c5b6ff9c3e47d0d, overshootratio, nodetype, startnotetrack, endnotetrack, speedstring, toanimset);

  if(isDefined(result) && isDefined(node)) {
    result.var_fa28e73df78609e3 = self._blackboard.shouldarrivetocoverexposedstepouttype != "\r+x5";
  }

  return result;
}

function playanim_waitforpathset(asmname, statename) {
  self endon("\xe8Y\xa3WN\xb4J\xd5\xec\x1f\xdaK\x9d");
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  self waittill("\"}nLZ\x9b\xb7w");
  asm::asm_fireevent(asmname, "\v\xc4\xed9\x1d");
}

function playanim_waitforpathclear(asmname, statename) {
  self endon("\xe8Y\xa3WN\xb4J\xd5\xec\x1f\xdaK\x9d");
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");

  while(true) {
    if(!isDefined(self.pathgoalpos)) {
      break;
    }

    wait 0.05;
  }

  asm::asm_fireevent(asmname, "\v\xc4\xed9\x1d");
}

function arrivalterminatewait(statename) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self.asm.arriving = statename;
  self waittill(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  self.asm.arriving = undefined;
}

function playanim_arrival_handlestandevent(asmname, statename, xanim, finalrate) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
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
  if(note == "\x9f\xd3\xfcWM-") {
    return 1;
  }
}

function returnonwarpstart(note) {
  if(note == "F\x8eh\x88\x04\xd7h\xac\xfd\xf4\xbb\xa7\xdf\xe0l\xf6]\xf5") {
    return 1;
  }
}

function calculateadjustedspeedforshortpath(desiredspeed, pathdist) {
  var_b69a48cf6c85168a = 64;
  var_3cbdadf77be5fad4 = 110;

  if(pathdist >= var_b69a48cf6c85168a && pathdist <= var_3cbdadf77be5fad4) {
    t = (pathdist - var_b69a48cf6c85168a) / (var_3cbdadf77be5fad4 - var_b69a48cf6c85168a);
    targetspeed = self aigettargetspeed();
    return ((1 - t) * targetspeed + t * desiredspeed);
  }

  return desiredspeed;
}

function playanim_arrival(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  arrival_rate = 1;

  if(isDefined(params)) {
    arrival_rate = params;
  }

  self.asm.arrivalasmstatename = statename;
  self.a.arrivalasmstatename = statename;
  thread arrivalterminatewait(statename);
  stopdata = asm::asm_getanim(asmname, statename);
  assert(isDefined(stopdata), "<dev string:x131>");

  if(!isDefined(stopdata)) {
    self orientmode("\xa1\xd7\x97\xd7\xf4h\xe0%\xbe \xa1");
    asm::asm_fireevent(asmname, "\v\xc4\xed9\x1d", undefined);
    return;
  }

  self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", self.angles[1]);
  facingangles = stopdata.finalangles;
  angleindex = stopdata.angleindex;
  facingyaw = (0, facingangles[1] - stopdata.angledelta, 0);
  var_a59537f2356aec5a = stopdata.startpos;
  coverarrivalyaw = facingyaw[1];

  if(isDefined(stopdata.parentpos) && isDefined(stopdata.parentangles)) {
    localdelta = stopdata.startpos - stopdata.parentpos;
    localdelta = rotatevectorinverted(localdelta, stopdata.parentangles);
    invangles = invertangles(stopdata.parentangles);
    localangles = combineangles(facingyaw, invangles);
    parentent = self getnavspaceent();
    assert(isDefined(parentent), "<dev string:x14c>");
    localdelta = rotatevector(localdelta, parentent.angles);
    var_a59537f2356aec5a = localdelta + parentent.origin;
    newangles = combineangles(localangles, parentent.angles);
    coverarrivalyaw = newangles[1];
  }

  arrivalstatename = statename;

  if(isDefined(self.customarrivalstate)) {
    arrivalstatename = self.customarrivalstate;
  }

  stopanim = stopdata.stopanim;

  if(isDefined(self.asm.customdata) && isDefined(self.customarrivalanimset)) {
    self setoverridearchetype("\x8cP\xfc\xbc\xb5\x05\n\xfcp\xa3", self.customarrivalanimset, 1);
  }

  stopxanim = asm::asm_getxanim(arrivalstatename, stopanim);
  arrival_node = utility::getarrivalnode();

  if(isDefined(stopdata.customtargetpos)) {
    goalpos = stopdata.customtargetpos;
  } else {
    if(isDefined(arrival_node)) {
      goalpos = function_55ef720b2ed221ef(arrival_node);
    } else {
      goalpos = self.pathgoalpos;
    }

    self._blackboard.arrivingtocoverexposed = istrue(stopdata.var_fa28e73df78609e3);
  }

  if(!istrue(stopdata.bskipstartcoverarrival)) {
    self startcoverarrival();
  }

  if(animhasnotetrack(stopxanim, "f\x97\xb9`\xd1~\x80(\xca")) {
    self animmode("\xee\xedc\xfb\xfa}f\x11y\xb9>\x9f\xaa", 0);
    animrate = utility::motionwarpwithnotetracks(stopxanim, goalpos, stopdata.finalangles, undefined, "\x9f\xd3\xfcWM-", undefined);
    self aisetanim(arrivalstatename, stopanim, animrate);
    asm::asm_donotetracks(asmname, statename, &returnoncorner, undefined, arrivalstatename);
    self aisetanim(arrivalstatename, stopanim, 1);
    asm::asm_donotetracks(asmname, statename, undefined, undefined, arrivalstatename);
    return;
  }

  if(isDefined(self.customarrivalanimmode)) {
    anim_mode = self.customarrivalanimmode;
    self animmode(anim_mode);
  } else {
    self animmode("\xee\xedc\xfb\xfa}f\x11y\xb9>\x9f\xaa", 0);
  }

  asm::asm_playfacialanim(asmname, statename, stopxanim);
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

  if(isDefined(self.arrivalspeedtarget) && isDefined(self.arrivaldesiredspeed) && utility::isentasoldier() && utility::demeanorhasblendspace()) {
    finalrate = self.arrivaldesiredspeed / self.arrivalspeedtarget;
    self.arrivaldesiredspeed = undefined;
    var_7999cf5ab417aef0 = 0.8;
    finalrate = max(var_7999cf5ab417aef0, finalrate);
  }

  thread playanim_arrival_handlestandevent(asmname, statename, stopxanim, finalrate);
  self aisetanim(arrivalstatename, stopanim, finalrate);
  end_time = 1;

  if(animhasnotetrack(stopxanim, "F\x8eh\x88\x04\xd7h\xac\xfd\xf4\xbb\xa7\xdf\xe0l\xf6]\xf5")) {
    assert(animhasnotetrack(stopxanim, "<dev string:x1c5>"));
    startnote = getnotetracktimes(stopxanim, "F\x8eh\x88\x04\xd7h\xac\xfd\xf4\xbb\xa7\xdf\xe0l\xf6]\xf5");
    endnote = getnotetracktimes(stopxanim, "I\n\xbe\xb2\xbcvL\xa2@e\x1c7\r\x7f\xdc\xb4");

    if(startnote[0] > 0) {
      asm::asm_donotetracks(asmname, statename, &returnonwarpstart, undefined, arrivalstatename, 0);
    }

    animlength = getanimlength(stopxanim);
    warpstarttime = startnote[0];

    if(warpstarttime > 0) {
      warpstarttime = startnote[0] * animlength * 1000;
      warpstarttime -= utility::mod(int(warpstarttime), level.frameduration);
      warpstarttime = warpstarttime / animlength / 1000;
    }

    end_time = endnote[0];
    duration = int((end_time - warpstarttime) * animlength / finalrate * 1000);
    duration += level.frameduration - utility::mod(duration, level.frameduration);
    utility::motionwarpwithtimes(stopxanim, goalpos, stopdata.finalangles, warpstarttime, 1, duration, 0);
  } else {
    warpduration = 500;

    if(animhasnotetrack(stopxanim, "\x93{\xdf\xe6\x03#\v-\xc7")) {
      end_time = getnotetracktimes(stopxanim, "\x93{\xdf\xe6\x03#\v-\xc7")[0];
      anim_length = getanimlength(stopxanim);
      warpduration = int(end_time * anim_length / finalrate * 1000);

      if(warpduration < 300 && anim_length / finalrate >= 0.15) {
        warpduration = 300;
      }
    }

    self motionwarpwithanim(var_a59537f2356aec5a, facingyaw, goalpos, stopdata.finalangles, warpduration);
  }

  if(!isagent(self)) {
    anime = asm::asm_lookupanimfromaliasifexists(statename, "k\x8b\xaf\xc7\xf3\xc0\x8a~\xd1{>");

    if(isDefined(arrival_node) && isDefined(anime) && isDefined(arrival_node.type) && (arrival_node.type == "}\xdf+\xcd\xe0@_-\xa3q\xcfpq\xa2" || arrival_node.type == "\xff\x17\xedh\xdd\xef\xa2Y?\v\xc77\b")) {
      conceal_xanim = asm::asm_getxanim(statename, anime);
      animlength = getanimlength(stopxanim);
      var_c6c1ea6b36a019d6 = animlength * end_time * 0.3;
      thread cover::start_conceal_add(statename, conceal_xanim, var_c6c1ea6b36a019d6);
    }
  }

  asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename), undefined, arrivalstatename);
  self.a.movement = "\x04M\xed\xab";
}

function getcustomarrivalangles() {
  if(isDefined(self.customarrivalangles)) {
    return self.customarrivalangles;
  }

  return undefined;
}

function getstopanims(asmname, statename, approachtype, var_6da5aab1b4d0be85, optionalprefix) {
  assert(!asm::asm_hasalias(statename, "<dev string:x1d9>"));
  assert(!asm::asm_hasalias(statename, "<dev string:x1de>"));
  stopanims = [];
  stopanims[5] = asm::asm_lookupdirectionalfootanim(1, asmname, statename, var_6da5aab1b4d0be85, optionalprefix);
  stopanims[4] = asm::asm_lookupdirectionalfootanim(2, asmname, statename, var_6da5aab1b4d0be85, optionalprefix);
  stopanims[3] = asm::asm_lookupdirectionalfootanim(3, asmname, statename, var_6da5aab1b4d0be85, optionalprefix);
  stopanims[6] = asm::asm_lookupdirectionalfootanim(4, asmname, statename, var_6da5aab1b4d0be85, optionalprefix);
  stopanims[2] = asm::asm_lookupdirectionalfootanim(6, asmname, statename, var_6da5aab1b4d0be85, optionalprefix);
  stopanims[7] = asm::asm_lookupdirectionalfootanim(7, asmname, statename, var_6da5aab1b4d0be85, optionalprefix);
  stopanims[0] = asm::asm_lookupdirectionalfootanim(8, asmname, statename, var_6da5aab1b4d0be85, optionalprefix);
  stopanims[1] = asm::asm_lookupdirectionalfootanim(9, asmname, statename, var_6da5aab1b4d0be85, optionalprefix);
  stopanims[8] = stopanims[0];
  return stopanims;
}

function function_90b050b77b02fe45(optimalstartpos, tracestartpos, finalpos, fraction, color, frames) {
  if(!asm::function_7e43b52f5196098a()) {
    return;
  }

  line(optimalstartpos, optimalstartpos + (0, 0, 64), color, 1, 1, frames);
  midpoint = vectorlerp(tracestartpos, finalpos, fraction);
  line(tracestartpos, midpoint, (0, 1, 0), 1, 1, frames);
  line(midpoint, finalpos, (1, 0, 0), 1, 1, frames);
}

function function_17a7a1e57c63bd51(goal_origin, arrival_angles) {
  if(asm::function_7e43b52f5196098a()) {
    forward = anglesToForward(arrival_angles);
    line(goal_origin, goal_origin + forward * 16, (1, 0.4, 0), 1, 0, 1);
    line(goal_origin, goal_origin + (0, 0, 64), (1, 0.4, 0), 1, 0, 1);
  }
}

function shouldstartarrivalpassthrough(asmname, statename, tostatename, params) {
  assertmsg("<dev string:x1e3>");
  return false;
}