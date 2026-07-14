/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\data_tracker.gsc
*******************************************/

#using scripts\engine\utility;
#namespace data_tracker;

function createstruct_datatracker() {
  return function_d9b9d5825e6d2995();
}

function function_821298354fb37251(var_d4c8b803145aafd2) {
  if(!isstruct(var_d4c8b803145aafd2)) {
    assertmsg("<dev string:x24>");
  }

  function_d9b9d5825e6d2995(var_d4c8b803145aafd2);
}

function adddataobject(dataobject) {
  if(!isDefined(dataobject.uniquename)) {
    assertmsg("<dev string:x67>");
    return;
  }

  self.dataobjects[dataobject.uniquename] = dataobject;
}

function adddata(datauniquename, datatype, value, callbackfunction) {
  if(isDefined(self.dataobjects[datauniquename])) {
    assertmsg("<dev string:xca>" + datauniquename + "<dev string:xf6>");
    return;
  }

  dataobject = function_7c755d4d71c999ea(datauniquename, datatype, value, callbackfunction);
  adddataobject(dataobject);
}

function adddataint(datauniquename, value, callbackfunction) {
  if(!isint(value)) {
    assertmsg("<dev string:x125>" + datauniquename + "<dev string:x158>");
    return;
  }

  adddata(datauniquename, "D*\x17-c\xf8\xc7", value, callbackfunction);
}

function adddatafloat(datauniquename, value, callbackfunction) {
  if(!isfloat(value)) {
    assertmsg("<dev string:x191>" + datauniquename + "<dev string:x1c6>");
    return;
  }

  adddata(datauniquename, "\xbe\x93\xa9\aw", value, callbackfunction);
}

function adddatastring(datauniquename, value, callbackfunction) {
  if(!isstring(value)) {
    assertmsg("<dev string:x1fc>" + datauniquename + "<dev string:x232>");
    return;
  }

  adddata(datauniquename, "\x03\xa8}\x1d\xdb/", value, callbackfunction);
}

function adddataprogresstracker(datauniquename, value, callbackfunction) {
  adddata(datauniquename, "gvA@\xe7\xf3\tO\x9e\x82\x94gjD3", value, callbackfunction);
}

function removedata(datauniquename) {
  self.dataobjects[datauniquename] = undefined;
}

function updatedata(dataobjectuniquename, updatedvalue) {
  dataobject = self.dataobjects[dataobjectuniquename];

  if(!isDefined(dataobject)) {
    assertmsg("<dev string:x269>" + dataobjectuniquename + "<dev string:x298>");
    return;
  }

  dataobject.value = updatedvalue;
  function_2f2c2a8e9d8a8e67(dataobjectuniquename);
}

function function_2f2c2a8e9d8a8e67(dataobjectuniquename) {
  dataobject = self.dataobjects[dataobjectuniquename];

  if(!isDefined(dataobject)) {
    assertmsg("<dev string:x2c2>" + dataobjectuniquename + "<dev string:x298>");
    return;
  }

  function_1ee48217500c1b5b(dataobjectuniquename);
}

function addcallback(callbackfunction, callonobject) {
  newcallback = function_ca11ca8f01cf089e(callbackfunction, callonobject);
  self.shareddatacallbacks[self.shareddatacallbacks.size] = newcallback;
}

function function_3e571bc7fc93a418(callbackfunction, dataobjectuniquename, callonobject) {
  dataobject = self.dataobjects[dataobjectuniquename];

  if(!isDefined(dataobject)) {
    assertmsg("<dev string:x2ff>" + dataobjectuniquename + "<dev string:x298>");
    return;
  }

  function_929a806c3a194f11(dataobject, callbackfunction, callonobject);
}

function removecallback(callbackfunction) {
  for(callbackid = 0; callbackid < self.shareddatacallbacks.size; callbackid++) {
    if(self.shareddatacallbacks[callbackid].callbackfunction == callbackfunction) {
      self.shareddatacallbacks[callbackid] = undefined;
    }
  }

  self.shareddatacallbacks = utility::array_removeundefined(self.callbacks);
}

function function_755c85eb59a16263(callbackfunction, dataobjectuniquename) {
  dataobject = self.dataobjects[dataobjectuniquename];

  if(!isDefined(dataobject)) {
    assertmsg("<dev string:x33a>" + dataobjectuniquename + "<dev string:x298>");
    return;
  }

  for(callbackid = 0; callbackid < dataobject.callbacks.size; callbackid++) {
    if(dataobject.callbacks[callbackid].callbackfunction == callbackfunction) {
      dataobject.callbacks[callbackid] = undefined;
    }
  }

  dataobject.callbacks = utility::array_removeundefined(dataobject.callbacks);
}

function getdatavalue(dataobjectuniquename) {
  dataobject = self.dataobjects[dataobjectuniquename];

  if(!isDefined(dataobject)) {
    assertmsg("<dev string:x378>" + dataobjectuniquename + "<dev string:x298>");
    return;
  }

  return dataobject.value;
}

function getdataobject(dataobjectuniquename) {
  dataobject = self.dataobjects[dataobjectuniquename];

  if(!isDefined(dataobject)) {
    assertmsg("<dev string:x378>" + dataobjectuniquename + "<dev string:x298>");
    return;
  }

  return dataobject;
}

function function_fb39513920c37852(dataobjectuniquename) {
  return isDefined(self.dataobjects[dataobjectuniquename]);
}

function function_1ee48217500c1b5b(dataobjectuniquename) {
  dataobject = self.dataobjects[dataobjectuniquename];

  if(!isDefined(dataobject)) {
    assertmsg("<dev string:x3a8>" + dataobjectuniquename + "<dev string:x298>");
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

function function_cea19ed755e885d1(dataobject) {
  return dataobject.uniquename;
}

function private function_d9b9d5825e6d2995(datatrackerstruct = spawnStruct()) {
  datatrackerstruct.dataobjects = [];
  datatrackerstruct.shareddatacallbacks = [];
  return datatrackerstruct;
}

function private function_7c755d4d71c999ea(uniquename, datatype, value, callbackfunction) {
  dataobject = spawnStruct();
  dataobject.uniquename = uniquename;
  dataobject.datatype = datatype;
  dataobject.value = value;
  dataobject.callbacks = [];

  if(isDefined(callbackfunction)) {
    function_929a806c3a194f11(dataobject, callbackfunction);
  }

  return dataobject;
}

function private function_ca11ca8f01cf089e(callbackfunction, callonobject) {
  newcallback = spawnStruct();
  newcallback.callon = callonobject ?? level;
  newcallback.callbackfunction = callbackfunction;
  return newcallback;
}

function private function_929a806c3a194f11(dataobject, callbackfunction, callonobject) {
  newcallback = function_ca11ca8f01cf089e(callbackfunction, callonobject);
  dataobject.callbacks[dataobject.callbacks.size] = newcallback;
}