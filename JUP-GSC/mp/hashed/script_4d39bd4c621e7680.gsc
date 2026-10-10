/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4d39bd4c621e7680.gsc
*************************************************/

#using script_185660037b9236c1;
#using script_41387eecc35b88bf;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_688ed4709dca758f;

function function_cb2e672e5fb4f3(activityinstance, scriptablename, origin, var_401b874a8c1c501f) {
  origin = default_to(origin, namespace_68dc261109a9503f::function_8988a4c89289d7f4(activityinstance));
  var_401b874a8c1c501f = default_to(var_401b874a8c1c501f, "InstanceEnd");
  scriptable = spawnscriptable(scriptablename, origin);

  if(isDefined(scriptable)) {
    function_5b71b730bfefd36a(activityinstance, scriptable, var_401b874a8c1c501f);
    return scriptable;
  }

  return undefined;
}

function function_5b71b730bfefd36a(activityinstance, scriptable, var_401b874a8c1c501f) {
  var_401b874a8c1c501f = default_to(var_401b874a8c1c501f, "None");

  if(isDefined(scriptable)) {
    function_a51ade79202d2b36(activityinstance, scriptable, var_401b874a8c1c501f);
    function_2d1d9d6ca99f0047(activityinstance, scriptable);
  }
}

function function_5c4c35644d53846f(activityinstance, scriptables, var_401b874a8c1c501f) {
  foreach(scriptable in scriptables) {
    function_5b71b730bfefd36a(activityinstance, scriptable, var_401b874a8c1c501f);
  }
}

function function_12e90953c7c6cbf4(activityinstance, activitymoment, scriptable, partname, statename) {
  var_c6787d1914826ac6 = function_a51ade79202d2b36(activityinstance, scriptable);

  if(!scriptable getscriptablehaspart(partname)) {
    assertmsg("<dev string:x1c>" + partname + "<dev string:x35>" + scriptable.index);
    return;
  }

  if(!isDefined(var_c6787d1914826ac6.partnames[partname])) {
    var_c6787d1914826ac6.partnames[partname] = [];
  }

  if(isDefined(statename)) {
    if(!scriptable getscriptableparthasstate(partname, statename)) {
      assertmsg("<dev string:x79>" + statename + "<dev string:x93>" + partname + "<dev string:xd1>" + scriptable.index);
      return;
    }

    var_c6787d1914826ac6.partnames[partname][activitymoment] = statename;
    return;
  }

  if(!scriptable getscriptableparthasstate(partname, activitymoment)) {
    assertmsg("<dev string:x79>" + activitymoment + "<dev string:x93>" + partname + "<dev string:xd1>" + scriptable.index);
    return;
  }

  var_c6787d1914826ac6.partnames[partname][activitymoment] = activitymoment;
}

function function_dfe0a21d9848315e(activityinstance, activitymoment) {
  var_a7e550e8ef0bbfe2 = 0;

  foreach(scriptableid, var_c6787d1914826ac6 in activityinstance.var_67c56bf0b03688bf) {
    if(!isDefined(var_c6787d1914826ac6.scriptable)) {
      activityinstance.var_67c56bf0b03688bf[scriptableid] = undefined;
      var_a7e550e8ef0bbfe2 = 1;
      continue;
    }

    if(var_c6787d1914826ac6.var_401b874a8c1c501f == activitymoment) {
      if(isDefined(var_c6787d1914826ac6.scriptable.origin)) {
        level notify("lootcache_opened_kill_callout" + var_c6787d1914826ac6.scriptable.origin);
      }

      var_c6787d1914826ac6.scriptable freescriptable();
      activityinstance.var_67c56bf0b03688bf[scriptableid] = undefined;
      var_a7e550e8ef0bbfe2 = 1;
      continue;
    }

    foreach(partname, partinfo in var_c6787d1914826ac6.partnames) {
      if(isDefined(partinfo[activitymoment])) {
        var_c6787d1914826ac6.scriptable setscriptablepartstate(partname, activitymoment);
      }
    }
  }

  if(var_a7e550e8ef0bbfe2) {
    activityinstance.var_67c56bf0b03688bf = array_removeundefined(activityinstance.var_67c56bf0b03688bf, 1);
    activityinstance.var_17a2361aa0beabb2 = array_removeundefined(activityinstance.var_17a2361aa0beabb2);
  }
}

function function_494bce73f65c6b6f(activityinstance) {
  varianttag = namespace_68dc261109a9503f::function_a4748b32a824c79c(activityinstance);
  var_d7037f8ce7fba1c6 = getentitylessscriptablearray(varianttag, "script_noteworthy");
  var_d7037f8ce7fba1c6 = array_combine(var_d7037f8ce7fba1c6, getscriptablearray(varianttag, "script_noteworthy"));
  return var_d7037f8ce7fba1c6;
}

function function_d81c572daff63cf9(activityinstance) {
  foreach(var_c6787d1914826ac6 in activityinstance.var_67c56bf0b03688bf) {
    if(isDefined(var_c6787d1914826ac6.scriptable)) {
      var_9107f7cc534da975 = isDefined(var_c6787d1914826ac6.var_401b874a8c1c501f) && var_c6787d1914826ac6.var_401b874a8c1c501f == "None";
      var_ae601fd44828f827 = !var_9107f7cc534da975;

      if(var_ae601fd44828f827) {
        if(isDefined(var_c6787d1914826ac6.scriptable.origin)) {
          level notify("lootcache_opened_kill_callout" + var_c6787d1914826ac6.scriptable.origin);
        }

        var_c6787d1914826ac6.scriptable freescriptable();
      }
    }
  }
}

function private function_e9ff3fa066f12d9f(scriptable, var_401b874a8c1c501f) {
  var_401b874a8c1c501f = default_to(var_401b874a8c1c501f, "None");
  var_c6787d1914826ac6 = spawnStruct();
  var_c6787d1914826ac6.scriptable = scriptable;
  var_c6787d1914826ac6.partnames = [];
  var_c6787d1914826ac6.var_401b874a8c1c501f = var_401b874a8c1c501f;
  return var_c6787d1914826ac6;
}

function private function_a51ade79202d2b36(activityinstance, scriptable, var_401b874a8c1c501f) {
  var_401b874a8c1c501f = default_to(var_401b874a8c1c501f, "None");

  if(isDefined(activityinstance.var_67c56bf0b03688bf[scriptable.index])) {
    return activityinstance.var_67c56bf0b03688bf[scriptable.index];
  }

  var_c6787d1914826ac6 = function_e9ff3fa066f12d9f(scriptable, var_401b874a8c1c501f);
  activityinstance.var_67c56bf0b03688bf[scriptable.index] = var_c6787d1914826ac6;
  return var_c6787d1914826ac6;
}

function private function_2d1d9d6ca99f0047(activityinstance, scriptable) {
  var_c09d25aab2388391 = scriptable function_90069777043e7833();

  foreach(partname in var_c09d25aab2388391) {
    if(isstartstr(toupper(partname), "NEXUSMANAGEDSCRIPTABLEPART")) {
      var_ec5849fb65eb261a = namespace_70aa82e7f409bc33::function_c795f9c21a9bc8();

      foreach(activitymoment in var_ec5849fb65eb261a) {
        if(scriptable getscriptableparthasstate(partname, activitymoment)) {
          function_12e90953c7c6cbf4(activityinstance, activitymoment, scriptable, partname);
        }
      }
    }
  }
}