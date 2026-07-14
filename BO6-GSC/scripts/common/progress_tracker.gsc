/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\progress_tracker.gsc
***********************************************/

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
    assertmsg("<dev string:x24>");
  }

  return progresstracker;
}

function function_608d112a3d06ad0b() {
  assert(isDefined(self.finalprogressvalue), "<dev string:x94>");
  return abs(self.finalprogressvalue - self.currentprogressvalue);
}

function setuniquename(uniquename) {
  self.uniquename = uniquename;
}

function getuniquename() {
  if(!isDefined(self.uniquename) || self.uniquename == "<dev string:xdb>") {
    assertmsg("<dev string:xdf>");
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

function function_8c3cb6b333b47c93() {
  var_9b1b704bfdd58aa2 = 0;

  foreach(callback in self.callbacks) {
    if(isDefined(callback)) {
      callback.callon[[callback.callbackfunction]](self);
      continue;
    }

    var_9b1b704bfdd58aa2 = 1;
  }

  if(var_9b1b704bfdd58aa2) {
    self.callbacks = utility::array_removeundefined(self.callbacks);
  }
}

function incrementcurrentprogress(incrementvalue) {
  if(iscomplete()) {
    return;
  }

  if(!isDefined(incrementvalue)) {
    incrementvalue = 1;
  }

  var_d440610ae820414d = self.currentprogressvalue + incrementvalue;
  function_e979392901ce7e08(var_d440610ae820414d);
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
  function_e979392901ce7e08(decrementedprogress);
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

  assert(isDefined(finalvalue), "<dev string:x11a>");
  self.finalprogressvalue = finalvalue;
  function_e979392901ce7e08(self.currentprogressvalue);
}

function private function_e979392901ce7e08(newprogressvalue) {
  self.progresscomplete = function_9038b3d6261b58fd(newprogressvalue);

  if(self.progresscomplete) {
    self.currentprogressvalue = self.finalprogressvalue;
  } else {
    self.currentprogressvalue = newprogressvalue;
  }

  function_8c3cb6b333b47c93();
}

function private function_9038b3d6261b58fd(newprogressvalue) {
  if(!isDefined(self.finalprogressvalue)) {
    return false;
  }

  var_b42e28623817d29b = self.startingprogressvalue < self.finalprogressvalue && newprogressvalue >= self.finalprogressvalue;
  var_2c641b0e3d7c49d7 = self.startingprogressvalue > self.finalprogressvalue && newprogressvalue <= self.finalprogressvalue;
  var_379053ed1f6e599f = self.startingprogressvalue == self.finalprogressvalue || iscomplete();
  var_f68559c7ac8c9a78 = isfloat(newprogressvalue) && abs(newprogressvalue - self.finalprogressvalue) <= 0.25;

  if(var_b42e28623817d29b || var_2c641b0e3d7c49d7 || var_379053ed1f6e599f || var_f68559c7ac8c9a78) {
    return true;
  }

  return false;
}