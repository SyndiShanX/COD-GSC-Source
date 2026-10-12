/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\data_tracker.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace data_tracker;

function createstruct_datatracker() {
  return function_9c7053f2799c3238();
}

function function_4d1de11b1a5630ec(var_fc27cf5aa6482417) {
  if(!isstruct(var_fc27cf5aa6482417)) {
    assertmsg("<dev string:x1c>");
  }

  function_9c7053f2799c3238(var_fc27cf5aa6482417);
}

function adddataobject(dataobject) {
  if(!isDefined(dataobject.uniquename)) {
    assertmsg("<dev string:x5f>");
    return;
  }

  self.dataobjects[dataobject.uniquename] = dataobject;
}

function adddata(datauniquename, datatype, value, callbackfunction) {
  if(isDefined(self.dataobjects[datauniquename])) {
    assertmsg("<dev string:xc2>" + datauniquename + "<dev string:xee>");
    return;
  }

  dataobject = function_29564ce8dc854f53(datauniquename, datatype, value, callbackfunction);
  adddataobject(dataobject);
}

function adddataint(datauniquename, value, callbackfunction) {
  if(!isint(value)) {
    assertmsg("<dev string:x11d>" + datauniquename + "<dev string:x150>");
    return;
  }

  adddata(datauniquename, "Integer", value, callbackfunction);
}

function adddatafloat(datauniquename, value, callbackfunction) {
  if(!isfloat(value)) {
    assertmsg("<dev string:x189>" + datauniquename + "<dev string:x1be>");
    return;
  }

  adddata(datauniquename, "Float", value, callbackfunction);
}

function adddatastring(datauniquename, value, callbackfunction) {
  if(!isstring(value)) {
    assertmsg("<dev string:x1f4>" + datauniquename + "<dev string:x22a>");
    return;
  }

  adddata(datauniquename, "String", value, callbackfunction);
}

function adddataprogresstracker(datauniquename, value, callbackfunction) {
  adddata(datauniquename, "ProgressTracker", value, callbackfunction);
}

function removedata(datauniquename) {
  self.dataobjects[datauniquename] = undefined;
}

function updatedata(dataobjectuniquename, updatedvalue) {
  dataobject = self.dataobjects[dataobjectuniquename];

  if(!isDefined(dataobject)) {
    assertmsg("<dev string:x261>" + dataobjectuniquename + "<dev string:x290>");
    return;
  }

  dataobject.value = updatedvalue;
  function_5aa098a0e2a91e3e(dataobjectuniquename);
}

function function_5aa098a0e2a91e3e(dataobjectuniquename) {
  dataobject = self.dataobjects[dataobjectuniquename];

  if(!isDefined(dataobject)) {
    assertmsg("<dev string:x2ba>" + dataobjectuniquename + "<dev string:x290>");
    return;
  }

  function_755936e0aeeb43f6(dataobjectuniquename);
}

function addcallback(callbackfunction, callonobject) {
  newcallback = function_72504163d8901997(callbackfunction, callonobject);
  self.shareddatacallbacks[self.shareddatacallbacks.size] = newcallback;
}

function function_c0a81a4aa88ede55(callbackfunction, dataobjectuniquename, callonobject) {
  dataobject = self.dataobjects[dataobjectuniquename];

  if(!isDefined(dataobject)) {
    assertmsg("<dev string:x2f7>" + dataobjectuniquename + "<dev string:x290>");
    return;
  }

  function_18c71d7e16a8c68c(dataobject, callbackfunction, callonobject);
}

function removecallback(callbackfunction) {
  for(callbackid = 0; callbackid < self.shareddatacallbacks.size; callbackid++) {
    if(self.shareddatacallbacks[callbackid].callbackfunction == callbackfunction) {
      self.shareddatacallbacks[callbackid] = undefined;
    }
  }

  self.shareddatacallbacks = array_removeundefined(self.callbacks);
}

function function_d6f2becdeb4c29be(callbackfunction, dataobjectuniquename) {
  dataobject = self.dataobjects[dataobjectuniquename];

  if(!isDefined(dataobject)) {
    assertmsg("<dev string:x332>" + dataobjectuniquename + "<dev string:x290>");
    return;
  }

  for(callbackid = 0; callbackid < dataobject.callbacks.size; callbackid++) {
    if(dataobject.callbacks[callbackid].callbackfunction == callbackfunction) {
      dataobject.callbacks[callbackid] = undefined;
    }
  }

  dataobject.callbacks = array_removeundefined(dataobject.callbacks);
}

function getdatavalue(dataobjectuniquename) {
  dataobject = self.dataobjects[dataobjectuniquename];

  if(!isDefined(dataobject)) {
    assertmsg("<dev string:x370>" + dataobjectuniquename + "<dev string:x290>");
    return;
  }

  return dataobject.value;
}

function getdataobject(dataobjectuniquename) {
  dataobject = self.dataobjects[dataobjectuniquename];

  if(!isDefined(dataobject)) {
    assertmsg("<dev string:x370>" + dataobjectuniquename + "<dev string:x290>");
    return;
  }

  return dataobject;
}

function function_6a26856f16c6a207(dataobjectuniquename) {
  return isDefined(self.dataobjects[dataobjectuniquename]);
}

function function_755936e0aeeb43f6(dataobjectuniquename) {
  dataobject = self.dataobjects[dataobjectuniquename];

  if(!isDefined(dataobject)) {
    assertmsg("<dev string:x3a0>" + dataobjectuniquename + "<dev string:x290>");
    return;
  }

  foreach(callback in dataobject.callbacks) {
    if(isDefined(callback)) {
      callback.callon thread[[callback.callbackfunction]](self, dataobject);
    }
  }

  foreach(callback in self.shareddatacallbacks) {
    if(isDefined(callback)) {
      callback.callon thread[[callback.callbackfunction]](self, dataobject);
    }
  }
}

function function_71667164a3e75714(dataobject) {
  return dataobject.uniquename;
}

function private function_9c7053f2799c3238(datatrackerstruct) {
  datatrackerstruct = default_to(datatrackerstruct, spawnStruct());
  datatrackerstruct.dataobjects = [];
  datatrackerstruct.shareddatacallbacks = [];
  return datatrackerstruct;
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

function private function_72504163d8901997(callbackfunction, callonobject) {
  newcallback = spawnStruct();
  newcallback.callon = default_to(callonobject, level);
  newcallback.callbackfunction = callbackfunction;
  return newcallback;
}

function private function_18c71d7e16a8c68c(dataobject, callbackfunction, callonobject) {
  newcallback = function_72504163d8901997(callbackfunction, callonobject);
  dataobject.callbacks[dataobject.callbacks.size] = newcallback;
}