/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_4a2005cdcbf64b88.gsc
*****************************************************/

#using script_157e7fec25404847;
#using script_1aae2eb1ef28b239;
#using script_50cece4fabbdcc75;
#using scripts\engine\utility;
#namespace activity_scriptables;

function function_a58ff6224d7732ee(activityinstance, scriptablename, origin = namespace_59dbf6a1bb28a43f::function_c1c44508d7539941(activityinstance), destructionmoment = "\x94\xe6n\x8e\v\xdclYEsd") {
  scriptable = spawnscriptable(scriptablename, origin);

  if(isDefined(scriptable)) {
    function_e51b53dcb984fb5f(activityinstance, scriptable, destructionmoment);
    return scriptable;
  }

  return undefined;
}

function function_e51b53dcb984fb5f(activityinstance, scriptable, destructionmoment = "\f+x5") {
  if(isDefined(scriptable)) {
    function_fd4f6ff2b460748f(activityinstance, scriptable, destructionmoment);
    function_7d404d1dd017f6de(activityinstance, scriptable);
  }
}

function function_8c8d3c96acf6a37e(activityinstance, scriptables, destructionmoment) {
  foreach(scriptable in scriptables) {
    function_e51b53dcb984fb5f(activityinstance, scriptable, destructionmoment);
  }
}

function function_4ce9e4679dd6f585(activityinstance, interactscriptables, var_e5f2c6a3054e571d) {
  if(!isarray(interactscriptables)) {
    interactscriptables = [interactscriptables];
  }

  activity_common::function_116071a5270d02cb(interactscriptables, activityinstance);

  if(istrue(var_e5f2c6a3054e571d)) {
    function_8c8d3c96acf6a37e(activityinstance, interactscriptables, "(\xbd%\xa1\x18I\xd2xur\xcb");
  }

  activity_participation::function_46b002f5d82470b3(activityinstance);
}

function function_5d1e6dbfa0adaf31(activityinstance, activitymoment, scriptable, partname, statename) {
  var_d4eedac130c0e45b = function_fd4f6ff2b460748f(activityinstance, scriptable);

  if(!scriptable getscriptablehaspart(partname)) {
    assertmsg("<dev string:x24>" + partname + "<dev string:x3d>" + scriptable.index);
    return;
  }

  if(!isDefined(var_d4eedac130c0e45b.partnames[partname])) {
    var_d4eedac130c0e45b.partnames[partname] = [];
  }

  if(isDefined(statename)) {
    if(!scriptable getscriptableparthasstate(partname, statename)) {
      assertmsg("<dev string:x81>" + statename + "<dev string:x9b>" + partname + "<dev string:xd9>" + scriptable.index);
      return;
    }

    var_d4eedac130c0e45b.partnames[partname][activitymoment] = statename;
    return;
  }

  if(!scriptable getscriptableparthasstate(partname, activitymoment)) {
    assertmsg("<dev string:x81>" + activitymoment + "<dev string:x9b>" + partname + "<dev string:xd9>" + scriptable.index);
    return;
  }

  var_d4eedac130c0e45b.partnames[partname][activitymoment] = activitymoment;
}

function function_a4982ac9a822db4f(activityinstance, activitymoment) {
  var_641f5b13fe17168f = 0;

  foreach(scriptableid, var_d4eedac130c0e45b in activityinstance.var_a324b9679c13e3e2) {
    if(!isDefined(var_d4eedac130c0e45b.scriptable)) {
      activityinstance.var_a324b9679c13e3e2[scriptableid] = undefined;
      var_641f5b13fe17168f = 1;
      continue;
    }

    if(var_d4eedac130c0e45b.destructionmoment == activitymoment) {
      if(isDefined(var_d4eedac130c0e45b.scriptable.origin)) {
        level notify("\xae\x8c\x95\x93\xbd\x85\xb3\x94M\f\x95\xd31\x9f\x89\xbe\xf8\x96\xa5PT\x14\x12\xc6\x9f\xf5\xb5s\x93" + var_d4eedac130c0e45b.scriptable.origin);
      }

      var_d4eedac130c0e45b.scriptable freescriptable();
      activityinstance.var_a324b9679c13e3e2[scriptableid] = undefined;
      var_641f5b13fe17168f = 1;
      continue;
    }

    foreach(partinfo in var_d4eedac130c0e45b.partnames) {
      if(isDefined(partinfo[activitymoment])) {
        var_d4eedac130c0e45b.scriptable setscriptablepartstate(partname, activitymoment);
      }
    }
  }

  if(var_641f5b13fe17168f) {
    activityinstance.var_a324b9679c13e3e2 = utility::array_removeundefined(activityinstance.var_a324b9679c13e3e2, 1);
    activity_common::function_8186d519c4482354(activityinstance);
  }
}

function function_23734599f0f0e1da(activityinstance) {
  varianttag = activityinstance.varianttag;
  var_bd20273044c885ff = getentitylessscriptablearray(varianttag, #script_noteworthy);
  var_bd20273044c885ff = utility::array_combine(var_bd20273044c885ff, getscriptablearray(varianttag, #script_noteworthy));
  return var_bd20273044c885ff;
}

function activityscriptablecleanup(activityinstance) {
  foreach(var_d4eedac130c0e45b in activityinstance.var_a324b9679c13e3e2) {
    if(isDefined(var_d4eedac130c0e45b.scriptable)) {
      var_7ee80ecab22a13e0 = isDefined(var_d4eedac130c0e45b.destructionmoment) && var_d4eedac130c0e45b.destructionmoment == "\f+x5";
      var_9eed07c27a2fd18a = !var_7ee80ecab22a13e0;

      if(var_9eed07c27a2fd18a) {
        if(isDefined(var_d4eedac130c0e45b.scriptable.origin)) {
          level notify("\xae\x8c\x95\x93\xbd\x85\xb3\x94M\f\x95\xd31\x9f\x89\xbe\xf8\x96\xa5PT\x14\x12\xc6\x9f\xf5\xb5s\x93" + var_d4eedac130c0e45b.scriptable.origin);
        }

        var_d4eedac130c0e45b.scriptable freescriptable();
      }
    }
  }
}

function private function_d3a9f4e2a3c57742(scriptable, destructionmoment = "\f+x5") {
  var_d4eedac130c0e45b = spawnStruct();
  var_d4eedac130c0e45b.scriptable = scriptable;
  var_d4eedac130c0e45b.partnames = [];
  var_d4eedac130c0e45b.destructionmoment = destructionmoment;
  return var_d4eedac130c0e45b;
}

function private function_fd4f6ff2b460748f(activityinstance, scriptable, destructionmoment = "\f+x5") {
  if(isDefined(activityinstance.var_a324b9679c13e3e2[scriptable.index])) {
    return activityinstance.var_a324b9679c13e3e2[scriptable.index];
  }

  var_d4eedac130c0e45b = function_d3a9f4e2a3c57742(scriptable, destructionmoment);
  activityinstance.var_a324b9679c13e3e2[scriptable.index] = var_d4eedac130c0e45b;
  return var_d4eedac130c0e45b;
}

function private function_7d404d1dd017f6de(activityinstance, scriptable) {
  scriptablepartnames = scriptable function_e03b690683313e36();

  foreach(partname in scriptablepartnames) {
    if(isstartstr(toupper(partname), "\x93T,\xaa\x9aM\x059\xa0t\xa2\x88\xd44%R\xa0\xa8P!bT(\x14\x92Q")) {
      var_a696fa955c795aef = level.activities.activitymoments;

      foreach(activitymoment in var_a696fa955c795aef) {
        if(scriptable getscriptableparthasstate(partname, activitymoment)) {
          function_5d1e6dbfa0adaf31(activityinstance, activitymoment, scriptable, partname);
        }
      }
    }
  }
}