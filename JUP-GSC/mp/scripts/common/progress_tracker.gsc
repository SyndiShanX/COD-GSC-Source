/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\progress_tracker.gsc
**************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace progress_tracker;

function createprogresstracker(startingprogressvalue, finalprogressvalue) {
  progresstracker = spawnStruct();
  progresstracker.progresscomplete = 0;
  progresstracker.callbacks = [];
  progresstracker.startingprogressvalue = startingprogressvalue;
  progresstracker.currentprogressvalue = startingprogressvalue;
  progresstracker.finalprogressvalue = finalprogressvalue;

  if(isDefined(finalprogressvalue) && startingprogressvalue == finalprogressvalue) {
    assertmsg("<dev string:x1c>");
  }

  return progresstracker;
}

function function_cfeb21bf93c30dae() {
  assertex(isDefined(self.finalprogressvalue), "<dev string:x8c>");
  return abs(self.finalprogressvalue - self.currentprogressvalue);
}

function setuniquename(uniquename) {
  self.uniquename = uniquename;
}

function getuniquename() {
  if(!isDefined(self.uniquename) || self.uniquename == "<dev string:xd3>") {
    assertmsg("<dev string:xd7>");
  }

  return self.uniquename;
}

function iscomplete() {
  return self.progresscomplete;
}

function addcallback(callonobject, callbackfunction) {
  newcallback = spawnStruct();
  newcallback.callon = callonobject;
  newcallback.callbackfunction = callbackfunction;
  self.callbacks[self.callbacks.size] = newcallback;
}

function function_e619a5f97879fa4a() {
  var_9eb651441b8f9d6f = 0;

  foreach(callback in self.callbacks) {
    if(isDefined(callback)) {
      callback.callon[[callback.callbackfunction]](self);
      continue;
    }

    var_9eb651441b8f9d6f = 1;
  }

  if(var_9eb651441b8f9d6f) {
    self.callbacks = array_removeundefined(self.callbacks);
  }
}

function incrementcurrentprogress(incrementvalue) {
  if(iscomplete()) {
    return;
  }

  if(!isDefined(incrementvalue)) {
    incrementvalue = 1;
  }

  var_8ccf1248fb22534c = self.currentprogressvalue + incrementvalue;
  function_c664e1d4584b1dcd(var_8ccf1248fb22534c);
}

function decrementcurrentprogress(decrementvalue) {
  if(iscomplete()) {
    return;
  }

  if(!isDefined(decrementvalue)) {
    decrementvalue = 1;
  }

  decrementedprogress = self.currentprogressvalue - decrementvalue;
  decrementedprogress = max(decrementedprogress, 0);
  function_c664e1d4584b1dcd(decrementedprogress);
}

function setcurrentprogress(progressvalue) {
  if(progressvalue < self.currentprogressvalue) {
    decrementcurrentprogress(self.currentprogressvalue - progressvalue);
    return;
  }

  incrementcurrentprogress(progressvalue - self.currentprogressvalue);
}

function setfinalvalue(finalvalue) {
  if(iscomplete()) {
    return;
  }

  assertex(isDefined(finalvalue), "<dev string:x112>");
  self.finalprogressvalue = finalvalue;
  function_c664e1d4584b1dcd(self.currentprogressvalue);
}

function private function_c664e1d4584b1dcd(newprogressvalue) {
  self.progresscomplete = function_c076b6b5c85274d8(newprogressvalue);

  if(self.progresscomplete) {
    self.currentprogressvalue = self.finalprogressvalue;
  } else {
    self.currentprogressvalue = newprogressvalue;
  }

  function_e619a5f97879fa4a();
}

function private function_c076b6b5c85274d8(newprogressvalue) {
  if(!isDefined(self.finalprogressvalue)) {
    return false;
  }

  var_47378a790f40bbe2 = self.startingprogressvalue < self.finalprogressvalue && newprogressvalue >= self.finalprogressvalue;
  var_e1836bac44cbf54a = self.startingprogressvalue > self.finalprogressvalue && newprogressvalue <= self.finalprogressvalue;
  var_feef1209b8b0a9ea = self.startingprogressvalue == self.finalprogressvalue || iscomplete();
  var_d49232a821579d29 = isfloat(newprogressvalue) && abs(newprogressvalue - self.finalprogressvalue) <= 0.25;

  if(var_47378a790f40bbe2 || var_e1836bac44cbf54a || var_feef1209b8b0a9ea || var_d49232a821579d29) {
    return true;
  }

  return false;
}