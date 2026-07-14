/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_507576ed5f2c7201.gsc
*****************************************************/

#namespace playtest_logger;

function function_b89c03b46070f714(var_b6673e62b5cd1fbe, var_1d132ef0e45d8d5e, var_279db5602906e29b, var_61a9992611d9b091, var_d0c130d3143c4cb7, var_9b815530f7c908b3, var_8c3c2ab6e76a5f5e, logmsgprefix = "\x14\x13A\xb2*Q\x9aQ\xf5&OG\xd1\xa8I") {
  struct = spawnStruct();
  struct.logmsgprefix = logmsgprefix;
  struct.var_b6673e62b5cd1fbe = var_b6673e62b5cd1fbe;
  struct.var_1d132ef0e45d8d5e = var_1d132ef0e45d8d5e;
  struct.var_279db5602906e29b = var_279db5602906e29b;
  struct.var_61a9992611d9b091 = var_61a9992611d9b091;
  struct.var_d0c130d3143c4cb7 = var_d0c130d3143c4cb7;
  struct.var_9b815530f7c908b3 = var_9b815530f7c908b3;
  struct.var_8c3c2ab6e76a5f5e = var_8c3c2ab6e76a5f5e;
  return struct;
}

function logassert(assertmessage, var_8ec6601354a23e50) {
  function_38f885efb5ac081b(assertmessage, 3, var_8ec6601354a23e50);
}

function logerror(msg, var_8ec6601354a23e50) {
  function_38f885efb5ac081b(msg, 0, var_8ec6601354a23e50);
}

function logwarning(msg, var_8ec6601354a23e50) {
  function_38f885efb5ac081b(msg, 2, var_8ec6601354a23e50);
}

function loginfo(msg, var_8ec6601354a23e50) {
  function_38f885efb5ac081b(msg, 1, var_8ec6601354a23e50);
}

function function_38f885efb5ac081b(msg, loglevel, loggerconfig) {
  var_b194175a399931ea = function_95356e710b2c848a(loglevel, loggerconfig);

  if(var_b194175a399931ea) {
    logmsg = function_e3fa7a98715b79a3(msg, loglevel, loggerconfig);
    logstring(logmsg);
  }

  if(!isDefined(logmsg)) {
    logmsg = function_e3fa7a98715b79a3(msg, loglevel, loggerconfig);
  }

  if(loglevel == 3 || loglevel == 0 && istrue(getdvarint(loggerconfig.var_8c3c2ab6e76a5f5e, 0))) {
    assertmsg(logmsg);
    return;
  }

  if(!var_b194175a399931ea) {
    println(logmsg);
  }
}

function private function_e3fa7a98715b79a3(msg, loglevel, loggerconfig) {
  if(loglevel == 3) {
    return (loggerconfig.logmsgprefix + "\xb9t\xd1\x0e;;\xef\x8e" + msg);
  } else if(loglevel == 1) {
    return (loggerconfig.logmsgprefix + "\x92\xc9\x91z\x8e\x01" + msg);
  } else if(loglevel == 0) {
    return (loggerconfig.logmsgprefix + "^\xbaQ\xfd\x99\xbeX" + msg);
  } else if(loglevel == 2) {
    return (loggerconfig.logmsgprefix + "_n\x8d\x04C#\x9a\xc2\x8d" + msg);
  }

  return loggerconfig.logmsgprefix + "\xf2`\xcd\x8f>XS\x89\x01\xfc\xa98Ki\xf8\x91\xd9\xfcMf\x91\xaf";
}

function private function_95356e710b2c848a(loglevel, loggerconfig) {
  if(!istrue(getdvarint(loggerconfig.var_b6673e62b5cd1fbe, 0))) {
    return false;
  }

  if(istrue(getdvarint(loggerconfig.var_9b815530f7c908b3, 0))) {
    return true;
  } else if(loglevel == 3) {
    return istrue(getdvarint(loggerconfig.var_d0c130d3143c4cb7));
  } else if(loglevel == 1) {
    return istrue(getdvarint(loggerconfig.var_1d132ef0e45d8d5e, 0));
  } else if(loglevel == 0) {
    return istrue(getdvarint(loggerconfig.var_61a9992611d9b091, 0));
  } else if(loglevel == 2) {
    return istrue(getdvarint(loggerconfig.var_279db5602906e29b, 0));
  }

  return false;
}