/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\progress_tracker.gsc
**************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace progress_tracker;

function function_b58813f6489727f2(var_cc3e7fbaface5a17, var_b76b3aee05993635) {
  progresstracker = spawnStruct();
  progresstracker.progresscomplete = 0;
  progresstracker.callbacks = [];
  progresstracker.var_cc3e7fbaface5a17 = var_cc3e7fbaface5a17;
  progresstracker.var_621cb2c0d9b1cdae = var_cc3e7fbaface5a17;
  progresstracker.var_b76b3aee05993635 = var_b76b3aee05993635;

  if(isDefined(var_b76b3aee05993635) && var_cc3e7fbaface5a17 == var_b76b3aee05993635) {
    assertmsg("<dev string:x1c>");
  }

  return progresstracker;
}

function function_cfeb21bf93c30dae() {
  assertex(isDefined(self.var_b76b3aee05993635), "<dev string:x8c>");
  return abs(self.var_b76b3aee05993635 - self.var_621cb2c0d9b1cdae);
}

function function_5cd1865af5a5edcf(uniquename) {
  self.uniquename = uniquename;
}

function function_4f3f1f9cedf2d883() {
  if(!isDefined(self.uniquename) || self.uniquename == "<dev string:xd3>") {
    assertmsg("<dev string:xd7>");
  }

  return self.uniquename;
}

function iscomplete() {
  return self.progresscomplete;
}

function addcallback(var_1fd2df2315da3137, callbackfunction) {
  newcallback = spawnStruct();
  newcallback.callon = var_1fd2df2315da3137;
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

function function_a370b85e4225923c(incrementvalue) {
  if(iscomplete()) {
    return;
  }

  if(!isDefined(incrementvalue)) {
    incrementvalue = 1;
  }

  var_8ccf1248fb22534c = self.var_621cb2c0d9b1cdae + incrementvalue;
  function_c664e1d4584b1dcd(var_8ccf1248fb22534c);
}

function function_1e9e5153831d8c68(decrementvalue) {
  if(iscomplete()) {
    return;
  }

  if(!isDefined(decrementvalue)) {
    decrementvalue = 1;
  }

  var_7b277612b5f42940 = self.var_621cb2c0d9b1cdae - decrementvalue;
  var_7b277612b5f42940 = max(var_7b277612b5f42940, 0);
  function_c664e1d4584b1dcd(var_7b277612b5f42940);
}

function function_7681e7890758b69b(progressvalue) {
  if(progressvalue < self.var_621cb2c0d9b1cdae) {
    function_1e9e5153831d8c68(self.var_621cb2c0d9b1cdae - progressvalue);
    return;
  }

  function_a370b85e4225923c(progressvalue - self.var_621cb2c0d9b1cdae);
}

function function_ea45d380408d2922(finalvalue) {
  if(iscomplete()) {
    return;
  }

  assertex(isDefined(finalvalue), "<dev string:x112>");
  self.var_b76b3aee05993635 = finalvalue;
  function_c664e1d4584b1dcd(self.var_621cb2c0d9b1cdae);
}

function private function_c664e1d4584b1dcd(var_6f4eb8a505d5c52f) {
  self.progresscomplete = function_c076b6b5c85274d8(var_6f4eb8a505d5c52f);

  if(self.progresscomplete) {
    self.var_621cb2c0d9b1cdae = self.var_b76b3aee05993635;
  } else {
    self.var_621cb2c0d9b1cdae = var_6f4eb8a505d5c52f;
  }

  function_e619a5f97879fa4a();
}

function private function_c076b6b5c85274d8(var_6f4eb8a505d5c52f) {
  if(!isDefined(self.var_b76b3aee05993635)) {
    return false;
  }

  var_47378a790f40bbe2 = self.var_cc3e7fbaface5a17 < self.var_b76b3aee05993635 && var_6f4eb8a505d5c52f >= self.var_b76b3aee05993635;
  var_e1836bac44cbf54a = self.var_cc3e7fbaface5a17 > self.var_b76b3aee05993635 && var_6f4eb8a505d5c52f <= self.var_b76b3aee05993635;
  var_feef1209b8b0a9ea = self.var_cc3e7fbaface5a17 == self.var_b76b3aee05993635 || iscomplete();
  var_d49232a821579d29 = isfloat(var_6f4eb8a505d5c52f) && abs(var_6f4eb8a505d5c52f - self.var_b76b3aee05993635) <= 0.25;

  if(var_47378a790f40bbe2 || var_e1836bac44cbf54a || var_feef1209b8b0a9ea || var_d49232a821579d29) {
    return true;
  }

  return false;
}