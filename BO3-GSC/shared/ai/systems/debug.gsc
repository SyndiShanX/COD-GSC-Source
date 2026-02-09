/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\systems\debug.gsc
*************************************************/

#using scripts\shared\ai\archetype_utility;
#using scripts\shared\system_shared;
#namespace as_debug;

function autoexec __init__sytem__() {
  system::register("", &__init__, undefined, undefined);
}

function __init__() {
  level thread debugdvars();
}

function debugdvars() {
  while(true) {
    if(getdvarint("", 0)) {
      delete_all_ai_corpses();
    }
    wait(0.05);
  }
}

function isdebugon() {
  return getdvarint("") == 1 || (isDefined(anim.debugent) && anim.debugent == self);
}

function drawdebuglineinternal(frompoint, topoint, color, durationframes) {
  for(i = 0; i < durationframes; i++) {
    line(frompoint, topoint, color);
    wait(0.05);
  }
}

function drawdebugline(frompoint, topoint, color, durationframes) {
  if(isdebugon()) {
    thread drawdebuglineinternal(frompoint, topoint, color, durationframes);
  }
}

function debugline(frompoint, topoint, color, durationframes) {
  for(i = 0; i < (durationframes * 20); i++) {
    line(frompoint, topoint, color);
    wait(0.05);
  }
}

function drawdebugcross(atpoint, radius, color, durationframes) {
  atpoint_high = atpoint + (0, 0, radius);
  atpoint_low = atpoint + (0, 0, -1 * radius);
  atpoint_left = atpoint + (0, radius, 0);
  atpoint_right = atpoint + (0, -1 * radius, 0);
  atpoint_forward = atpoint + (radius, 0, 0);
  atpoint_back = atpoint + (-1 * radius, 0, 0);
  thread debugline(atpoint_high, atpoint_low, color, durationframes);
  thread debugline(atpoint_left, atpoint_right, color, durationframes);
  thread debugline(atpoint_forward, atpoint_back, color, durationframes);
}

function updatedebuginfo() {
  self endon("death");
  self.debuginfo = spawnStruct();
  self.debuginfo.enabled = getdvarint("") > 0;
  debugclearstate();
  while(true) {
    wait(0.05);
    updatedebuginfointernal();
    wait(0.05);
  }
}

function updatedebuginfointernal() {
  if(isDefined(anim.debugent) && anim.debugent == self) {
    doinfo = 1;
  } else {
    doinfo = getdvarint("") > 0;
    if(doinfo) {
      ai_entnum = getdvarint("");
      if(ai_entnum > -1 && ai_entnum != self getentitynumber()) {
        doinfo = 0;
      }
    }
    if(!self.debuginfo.enabled && doinfo) {
      self.debuginfo.shouldclearonanimscriptchange = 1;
    }
    self.debuginfo.enabled = doinfo;
  }
}

function drawdebugenttext(text, ent, color, channel) {
  /
  #
  assert(isDefined(ent));
  if(!getdvarint("")) {
    if(!isDefined(ent.debuganimscripttime) || gettime() > ent.debuganimscripttime) {
      ent.debuganimscriptlevel = 0;
      ent.debuganimscripttime = gettime();
    }
    indentlevel = vectorscale(vectorscale((0, 0, -1), 10), ent.debuganimscriptlevel);
    print3d((self.origin + vectorscale((0, 0, 1), 70)) + indentlevel, text, color);
    ent.debuganimscriptlevel++;
  } else {
    recordenttext(text, ent, color, channel);
  }
}

function debugpushstate(statename, extrainfo) {
  if(!getdvarint("")) {
    return;
  }
  ai_entnum = getdvarint("");
  if(ai_entnum > -1 && ai_entnum != self getentitynumber()) {
    return;
  }
  assert(isDefined(self.debuginfo.states));
  assert(isDefined(statename));
  state = spawnStruct();
  state.statename = statename;
  state.statelevel = self.debuginfo.statelevel;
  state.statetime = gettime();
  state.statevalid = 1;
  self.debuginfo.statelevel++;
  if(isDefined(extrainfo)) {
    state.extrainfo = extrainfo + "";
  }
  self.debuginfo.states[self.debuginfo.states.size] = state;
}

function debugaddstateinfo(statename, extrainfo) {
  if(!getdvarint("")) {
    return;
  }
  ai_entnum = getdvarint("");
  if(ai_entnum > -1 && ai_entnum != self getentitynumber()) {
    return;
  }
  assert(isDefined(self.debuginfo.states));
  if(isDefined(statename)) {
    for(i = self.debuginfo.states.size - 1; i >= 0; i--) {
      assert(isDefined(self.debuginfo.states[i]));
      if(self.debuginfo.states[i].statename == statename) {
        if(!isDefined(self.debuginfo.states[i].extrainfo)) {
          self.debuginfo.states[i].extrainfo = "";
        }
        self.debuginfo.states[i].extrainfo = self.debuginfo.states[i].extrainfo + (extrainfo + "");
        break;
      }
    }
  } else if(self.debuginfo.states.size > 0) {
    lastindex = self.debuginfo.states.size - 1;
    assert(isDefined(self.debuginfo.states[lastindex]));
    if(!isDefined(self.debuginfo.states[lastindex].extrainfo)) {
      self.debuginfo.states[lastindex].extrainfo = "";
    }
    self.debuginfo.states[lastindex].extrainfo = self.debuginfo.states[lastindex].extrainfo + (extrainfo + "");
  }
}

function debugpopstate(statename, exitreason) {
  if(!getdvarint("") || self.debuginfo.states.size <= 0) {
    return;
  }
  ai_entnum = getdvarint("");
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(ai_entnum > -1 && ai_entnum != self getentitynumber()) {
    return;
  }
  assert(isDefined(self.debuginfo.states));
  if(isDefined(statename)) {
    for(i = 0; i < self.debuginfo.states.size; i++) {
      if(self.debuginfo.states[i].statename == statename && self.debuginfo.states[i].statevalid) {
        self.debuginfo.states[i].statevalid = 0;
        self.debuginfo.states[i].exitreason = exitreason;
        self.debuginfo.statelevel = self.debuginfo.states[i].statelevel;
        for(j = i + 1; j < self.debuginfo.states.size && self.debuginfo.states[j].statelevel > self.debuginfo.states[i].statelevel; j++) {
          self.debuginfo.states[j].statevalid = 0;
        }
        break;
      }
    }
  } else {
    for(i = self.debuginfo.states.size - 1; i >= 0; i--) {
      if(self.debuginfo.states[i].statevalid) {
        self.debuginfo.states[i].statevalid = 0;
        self.debuginfo.states[i].exitreason = exitreason;
        self.debuginfo.statelevel--;
        break;
      }
    }
  }
}

function debugclearstate() {
  self.debuginfo.states = [];
  self.debuginfo.statelevel = 0;
  self.debuginfo.shouldclearonanimscriptchange = 0;
}

function debugshouldclearstate() {
  if(isDefined(self.debuginfo) && isDefined(self.debuginfo.shouldclearonanimscriptchange) && self.debuginfo.shouldclearonanimscriptchange) {
    return true;
  }
  return false;
}

function debugcleanstatestack() {
  newarray = [];
  for(i = 0; i < self.debuginfo.states.size; i++) {
    if(self.debuginfo.states[i].statevalid) {
      newarray[newarray.size] = self.debuginfo.states[i];
    }
  }
  self.debuginfo.states = newarray;
}

function indent(depth) {
  indent = "";
  for(i = 0; i < depth; i++) {
    indent = indent + "";
  }
  return indent;
}

function debugdrawweightedpoints(entity, points, weights) {
  lowestvalue = 0;
  highestvalue = 0;
  for(index = 0; index < points.size; index++) {
    if(weights[index] < lowestvalue) {
      lowestvalue = weights[index];
    }
    if(weights[index] > highestvalue) {
      highestvalue = weights[index];
    }
  }
  for(index = 0; index < points.size; index++) {
    debugdrawweightedpoint(entity, points[index], weights[index], lowestvalue, highestvalue);
  }
}

function debugdrawweightedpoint(entity, point, weight, lowestvalue, highestvalue) {
  deltavalue = highestvalue - lowestvalue;
  halfdeltavalue = deltavalue / 2;
  midvalue = lowestvalue + (deltavalue / 2);
  if(halfdeltavalue == 0) {
    halfdeltavalue = 1;
  }
  if(weight <= midvalue) {
    redcolor = 1 - (abs((weight - lowestvalue) / halfdeltavalue));
    recordcircle(point, 2, (redcolor, 0, 0), "", entity);
  } else {
    greencolor = 1 - (abs((highestvalue - weight) / halfdeltavalue));
    recordcircle(point, 2, (0, greencolor, 0), "", entity);
  }
}

function delete_all_ai_corpses() {
  setDvar("", 0);
  corpses = getcorpsearray();
  foreach(corpse in corpses) {
    if(isactorcorpse(corpse)) {
      corpse delete();
    }
  }
}