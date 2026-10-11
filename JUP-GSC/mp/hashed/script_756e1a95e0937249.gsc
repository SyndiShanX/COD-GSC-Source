/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_756e1a95e0937249.gsc
*************************************************/

#namespace playtest_logger;

function function_223a972e008c4a09(var_2ea903451e753a5f, var_9dfaf49e38b7b10f, var_9113b547554386ba, var_e16ce54aa38571c0, var_1e9d08b8e40c246a, var_7eea86c60c0788e, var_b0b33580058b7f27, logmsgprefix) {
  if(!isDefined(logmsgprefix)) {
    logmsgprefix = "PLAYTEST_LOGGER";
  }

  struct = spawnStruct();
  struct.logmsgprefix = logmsgprefix;
  struct.var_2ea903451e753a5f = var_2ea903451e753a5f;
  struct.var_9dfaf49e38b7b10f = var_9dfaf49e38b7b10f;
  struct.var_9113b547554386ba = var_9113b547554386ba;
  struct.var_e16ce54aa38571c0 = var_e16ce54aa38571c0;
  struct.var_1e9d08b8e40c246a = var_1e9d08b8e40c246a;
  struct.var_7eea86c60c0788e = var_7eea86c60c0788e;
  struct.var_b0b33580058b7f27 = var_b0b33580058b7f27;
  return struct;
}

function logassert(assertmessage, var_c5dab79fa2079db9) {
  function_275c43d7dd5c74d6(assertmessage, 3, var_c5dab79fa2079db9);
}

function logerror(msg, var_c5dab79fa2079db9) {
  function_275c43d7dd5c74d6(msg, 0, var_c5dab79fa2079db9);
}

function logwarning(msg, var_c5dab79fa2079db9) {
  function_275c43d7dd5c74d6(msg, 2, var_c5dab79fa2079db9);
}

function loginfo(msg, var_c5dab79fa2079db9) {
  function_275c43d7dd5c74d6(msg, 1, var_c5dab79fa2079db9);
}

function function_275c43d7dd5c74d6(msg, loglevel, loggerconfig) {
  var_bf4eaca9064fa63f = function_d6a62191d9107d13(loglevel, loggerconfig);

  if(var_bf4eaca9064fa63f) {
    logmsg = function_5c8554b7d485da82(msg, loglevel, loggerconfig);
    logstring(logmsg);
  }

  if(!isDefined(logmsg)) {
    logmsg = function_5c8554b7d485da82(msg, loglevel, loggerconfig);
  }

  if(loglevel == 3 || loglevel == 0 && istrue(getdvarint(loggerconfig.var_b0b33580058b7f27, 0))) {
    assertmsg(logmsg);
    return;
  }

  if(!var_bf4eaca9064fa63f) {
    println(logmsg);
  }
}

function private function_5c8554b7d485da82(msg, loglevel, loggerconfig) {
  if(loglevel == 3) {
    return (loggerconfig.logmsgprefix + "ASSERT: " + msg);
  } else if(loglevel == 1) {
    return (loggerconfig.logmsgprefix + "INFO: " + msg);
  } else if(loglevel == 0) {
    return (loggerconfig.logmsgprefix + "ERROR: " + msg);
  } else if(loglevel == 2) {
    return (loggerconfig.logmsgprefix + "WARNING: " + msg);
  }

  return loggerconfig.logmsgprefix + " [unknown log level]: ";
}

function private function_d6a62191d9107d13(loglevel, loggerconfig) {
  if(!istrue(getdvarint(loggerconfig.var_2ea903451e753a5f, 0))) {
    return false;
  }

  if(istrue(getdvarint(loggerconfig.var_7eea86c60c0788e, 0))) {
    return true;
  } else if(loglevel == 3) {
    return istrue(getdvarint(loggerconfig.var_1e9d08b8e40c246a));
  } else if(loglevel == 1) {
    return istrue(getdvarint(loggerconfig.var_9dfaf49e38b7b10f, 0));
  } else if(loglevel == 0) {
    return istrue(getdvarint(loggerconfig.var_e16ce54aa38571c0, 0));
  } else if(loglevel == 2) {
    return istrue(getdvarint(loggerconfig.var_9113b547554386ba, 0));
  }

  return false;
}