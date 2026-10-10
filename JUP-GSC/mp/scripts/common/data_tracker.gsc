/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\data_tracker.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace data_tracker;

function function_b205b5926c02717f() {
  return function_9c7053f2799c3238();
}

function function_4d1de11b1a5630ec(var_fc27cf5aa6482417) {
  if(!isstruct(var_fc27cf5aa6482417)) {
    assertmsg("<dev string:x1c>");
  }

  function_9c7053f2799c3238(var_fc27cf5aa6482417);
}

function function_3234a152a64387c7(dataobject) {
  if(!isDefined(dataobject.uniquename)) {
    assertmsg("<dev string:x5f>");
    return;
  }

  self.dataobjects[dataobject.uniquename] = dataobject;
}

function adddata(var_f22b51105fa16a29, datatype, value, callbackfunction) {
  if(isDefined(self.dataobjects[var_f22b51105fa16a29])) {
    assertmsg("<dev string:xc2>" + var_f22b51105fa16a29 + "<dev string:xee>");
    return;
  }

  dataobject = function_29564ce8dc854f53(var_f22b51105fa16a29, datatype, value, callbackfunction);
  function_3234a152a64387c7(dataobject);
}

function function_b584ae8dddb33821(var_f22b51105fa16a29, value, callbackfunction) {
  if(!isint(value)) {
    assertmsg("<dev string:x11d>" + var_f22b51105fa16a29 + "<dev string:x150>");
    return;
  }

  adddata(var_f22b51105fa16a29, "Integer", value, callbackfunction);
}

function function_a5bdec253a251d2a(var_f22b51105fa16a29, value, callbackfunction) {
  if(!isfloat(value)) {
    assertmsg("<dev string:x189>" + var_f22b51105fa16a29 + "<dev string:x1be>");
    return;
  }

  adddata(var_f22b51105fa16a29, "Float", value, callbackfunction);
}

function function_e39de66971de6959(var_f22b51105fa16a29, value, callbackfunction) {
  if(!isstring(value)) {
    assertmsg("<dev string:x1f4>" + var_f22b51105fa16a29 + "<dev string:x22a>");
    return;
  }

  adddata(var_f22b51105fa16a29, "String", value, callbackfunction);
}

function function_e4b4be816ed43365(var_f22b51105fa16a29, value, callbackfunction) {
  adddata(var_f22b51105fa16a29, "ProgressTracker", value, callbackfunction);
}

function removedata(var_f22b51105fa16a29) {
  self.dataobjects[var_f22b51105fa16a29] = undefined;
}

function updatedata(var_9e5a064a346c5b42, updatedvalue) {
  dataobject = self.dataobjects[var_9e5a064a346c5b42];

  if(!isDefined(dataobject)) {
    assertmsg("<dev string:x261>" + var_9e5a064a346c5b42 + "<dev string:x290>");
    return;
  }

  dataobject.value = updatedvalue;
  function_5aa098a0e2a91e3e(var_9e5a064a346c5b42);
}

function function_5aa098a0e2a91e3e(var_9e5a064a346c5b42) {
  dataobject = self.dataobjects[var_9e5a064a346c5b42];

  if(!isDefined(dataobject)) {
    assertmsg("<dev string:x2ba>" + var_9e5a064a346c5b42 + "<dev string:x290>");
    return;
  }

  function_755936e0aeeb43f6(var_9e5a064a346c5b42);
}

function addcallback(callbackfunction, var_1fd2df2315da3137) {
  newcallback = function_72504163d8901997(callbackfunction, var_1fd2df2315da3137);
  self.var_6b6f2974d8fc8810[self.var_6b6f2974d8fc8810.size] = newcallback;
}

function function_c0a81a4aa88ede55(callbackfunction, var_9e5a064a346c5b42, var_1fd2df2315da3137) {
  dataobject = self.dataobjects[var_9e5a064a346c5b42];

  if(!isDefined(dataobject)) {
    assertmsg("<dev string:x2f7>" + var_9e5a064a346c5b42 + "<dev string:x290>");
    return;
  }

  function_18c71d7e16a8c68c(dataobject, callbackfunction, var_1fd2df2315da3137);
}

function removecallback(callbackfunction) {
  for(callbackid = 0; callbackid < self.var_6b6f2974d8fc8810.size; callbackid++) {
    if(self.var_6b6f2974d8fc8810[callbackid].callbackfunction == callbackfunction) {
      self.var_6b6f2974d8fc8810[callbackid] = undefined;
    }
  }

  self.var_6b6f2974d8fc8810 = array_removeundefined(self.callbacks);
}

function function_d6f2becdeb4c29be(callbackfunction, var_9e5a064a346c5b42) {
  dataobject = self.dataobjects[var_9e5a064a346c5b42];

  if(!isDefined(dataobject)) {
    assertmsg("<dev string:x332>" + var_9e5a064a346c5b42 + "<dev string:x290>");
    return;
  }

  for(callbackid = 0; callbackid < dataobject.callbacks.size; callbackid++) {
    if(dataobject.callbacks[callbackid].callbackfunction == callbackfunction) {
      dataobject.callbacks[callbackid] = undefined;
    }
  }

  dataobject.callbacks = array_removeundefined(dataobject.callbacks);
}

function function_e989e3f023f50368(var_9e5a064a346c5b42) {
  dataobject = self.dataobjects[var_9e5a064a346c5b42];

  if(!isDefined(dataobject)) {
    assertmsg("<dev string:x370>" + var_9e5a064a346c5b42 + "<dev string:x290>");
    return;
  }

  return dataobject.value;
}

function function_f709e958aa6900(var_9e5a064a346c5b42) {
  dataobject = self.dataobjects[var_9e5a064a346c5b42];

  if(!isDefined(dataobject)) {
    assertmsg("<dev string:x370>" + var_9e5a064a346c5b42 + "<dev string:x290>");
    return;
  }

  return dataobject;
}

function function_6a26856f16c6a207(var_9e5a064a346c5b42) {
  return isDefined(self.dataobjects[var_9e5a064a346c5b42]);
}

function function_755936e0aeeb43f6(var_9e5a064a346c5b42) {
  dataobject = self.dataobjects[var_9e5a064a346c5b42];

  if(!isDefined(dataobject)) {
    assertmsg("<dev string:x3a0>" + var_9e5a064a346c5b42 + "<dev string:x290>");
    return;
  }

  foreach(callback in dataobject.callbacks) {
    if(isDefined(callback)) {
      callback.callon thread[[callback.callbackfunction]](self, dataobject);
    }
  }

  foreach(callback in self.var_6b6f2974d8fc8810) {
    if(isDefined(callback)) {
      callback.callon thread[[callback.callbackfunction]](self, dataobject);
    }
  }
}

function function_71667164a3e75714(dataobject) {
  return dataobject.uniquename;
}

function private function_9c7053f2799c3238(var_9bc4f97e08bcc10e) {
  var_9bc4f97e08bcc10e = default_to(var_9bc4f97e08bcc10e, spawnStruct());
  var_9bc4f97e08bcc10e.dataobjects = [];
  var_9bc4f97e08bcc10e.var_6b6f2974d8fc8810 = [];
  return var_9bc4f97e08bcc10e;
}

function private function_29564ce8dc854f53(uniquename, datatype, value, callbackfunction) {
  dataobject = spawnStruct();
  dataobject.uniquename = uniquename;
  dataobject.datatype = datatype;
  dataobject.value = value;
  dataobject.callbacks = [];

  if(isDefined(callbackfunction)) {
    function_18c71d7e16a8c68c(dataobject, callbackfunction);
  }

  return dataobject;
}

function private function_72504163d8901997(callbackfunction, var_1fd2df2315da3137) {
  newcallback = spawnStruct();
  newcallback.callon = default_to(var_1fd2df2315da3137, level);
  newcallback.callbackfunction = callbackfunction;
  return newcallback;
}

function private function_18c71d7e16a8c68c(dataobject, callbackfunction, var_1fd2df2315da3137) {
  newcallback = function_72504163d8901997(callbackfunction, var_1fd2df2315da3137);
  dataobject.callbacks[dataobject.callbacks.size] = newcallback;
}