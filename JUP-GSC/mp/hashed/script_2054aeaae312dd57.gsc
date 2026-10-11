/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2054aeaae312dd57.gsc
*************************************************/

#using script_2054aeaae312dd57;
#using script_2986aa4b0ff2bddf;
#using script_3d2770dc09c1243;
#using script_59ff79d681bb860c;
#using scripts\engine\dev;
#using scripts\engine\utility;
#namespace namespace_260e96ab038c8919;

function function_66c502dfb1c607b2() {
  if(getdvarint(@ "hash_16a69b03592ae6ea", 0) == 0) {
    return;
  }

  setDvar(@ "hash_a9944abc2f276e96", 1);
  setDvar(@ "hash_824c718cad3c0f17", 0);
  setDvar(@ "hash_a26ae46918350c7", 0);
  setDvar(@ "hash_b0eefb927ba15201", 0);
  setDvar(@ "hash_eb781589d9dabf4f", 0);
  setDvar(@ "hash_a941d4176a868108", 0);
  setDvar(@ "ai_shownavmesh", 2);
  setDvar(@ "hash_e49da8458f06fe4f", 1);
  setDvar(@ "ai_showpaths", 1);
  setDvar(@ "hash_9cb701e1b4aa2385", 5);
  setDvar(@ "hash_2f602ff4fd08630f", 2);
  level thread scripts\engine\dev::devcommandwatcher(@ "hash_f97641d4915507b5", &namespace_9fa112241a70b32b::function_caa3566cb86d5538);
  level thread scripts\engine\dev::devcommandwatcher(@ "hash_b32ed87f6e94907d", &namespace_9fa112241a70b32b::function_4166f565abe2876a);
  level thread scripts\engine\dev::devcommandwatcher(@ "hash_5ad71dff2cbc6584", &namespace_9fa112241a70b32b::function_13c592c4aa8f479f);
  level thread scripts\engine\dev::devcommandwatcher(@ "hash_7d823f893b3e9d9f", &namespace_9fa112241a70b32b::function_78bb9ce9a224428f);
}

function function_caa3566cb86d5538(command, arglist) {
  function_c5fb911b37a009a9(arglist, 2, 3, 1, "<dev string:x1c>");
}

function function_4166f565abe2876a(command, arglist) {
  function_c5fb911b37a009a9(arglist, 2, 3, 1, "<dev string:x44>");
}

function function_13c592c4aa8f479f(command, arglist) {
  function_c5fb911b37a009a9(arglist, 2, 3, 1, "<dev string:x71>");
}

function private function_c5fb911b37a009a9(arglist, startpositionargument, var_de528f4c380636d4, var_d9b34d95d095735, usagestring) {
  cmdargstr = "<dev string:x9c>";

  foreach(arg in arglist) {
    cmdargstr += arg + "<dev string:xa0>";
  }

  startpos = function_c296da4701b1ce9b(cmdargstr, startpositionargument);
  targetpos = function_c296da4701b1ce9b(cmdargstr, var_de528f4c380636d4);
  errorpos = function_c296da4701b1ce9b(cmdargstr, var_d9b34d95d095735);

  if(!isvector(startpos) || !isvector(targetpos) || !isvector(errorpos)) {
    iprintlnbold(usagestring);
    return;
  }

  function_96aa55e08b9d714f(startpos, targetpos);
  thread function_3f27417cba3bd71c(startpos, targetpos, errorpos);
}

function function_96aa55e08b9d714f(startpos, targetpos) {
  level.mit.var_ff4e5b2de820cb1 = spawnStruct();
  level.mit.var_ff4e5b2de820cb1.startpos = startpos;
  level.mit.var_ff4e5b2de820cb1.targetpos = targetpos;

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(isDefined(level.mit.var_fbb0c17bb4e37ee8)) {
      if(level.mit.var_fbb0c17bb4e37ee8 == player.clientid) {
        player kill();
        break;
      }

      continue;
    }

    if(isbot(player)) {
      level.mit.var_fbb0c17bb4e37ee8 = player.clientid;
      player kill();
      break;
    }
  }

  if(!isDefined(level.mit.var_fbb0c17bb4e37ee8)) {
    botinfo = spawnStruct();
    botinfo.name = "<dev string:x9c>";
    botconnected = level spawnbots([botinfo], "<dev string:xa5>", undefined, undefined, "<dev string:xb3>");

    if(isarray(botconnected) && isDefined(botconnected[0])) {
      level.mit.var_fbb0c17bb4e37ee8 = botconnected[0].clientid;
      return;
    }

    assert("<dev string:xc3>");
  }
}

function function_caedac3a0de734d() {
  startpos = level.mit.var_ff4e5b2de820cb1.startpos;
  targetpos = level.mit.var_ff4e5b2de820cb1.targetpos;
  level.mit.var_ff4e5b2de820cb1 = undefined;
  defaultplayer = level.players[0];
  defaultplayer dontinterpolate();

  if(!defaultplayer isnoclip()) {
    defaultplayer noclip();
  }

  defaultplayer setOrigin(startpos + (0, 0, 36));
  defaultplayer setplayerangles(vectortoangles(startpos - defaultplayer.origin));
  wait 0.5;
  var_d22fdca158e266e = 50;
  var_7d2294c58a5c346 = 100;
  failedresult = botteleport(startpos, var_d22fdca158e266e, var_7d2294c58a5c346);

  if(isDefined(failedresult)) {
    assert("<dev string:xeb>");
    return;
  }

  namespace_4dbcecb8aa6160e3::testprocess(targetpos);
}

function function_e1745dae8cdd8388() {
  return isDefined(level.mit.var_ff4e5b2de820cb1) && isDefined(level.mit.var_fbb0c17bb4e37ee8) && self.clientid == level.mit.var_fbb0c17bb4e37ee8;
}

function function_78bb9ce9a224428f(command, args) {
  cmdargstr = "<dev string:x9c>";

  foreach(arg in args) {
    cmdargstr += arg + "<dev string:xa0>";
  }

  pos1 = function_c296da4701b1ce9b(cmdargstr, 1);
  pos2 = function_c296da4701b1ce9b(cmdargstr, 2);

  if(!isvector(pos1) || !isvector(pos2)) {
    iprintlnbold("<dev string:x10d>");
    return;
  }

  thread function_3f27417cba3bd71c(pos1, pos2);
}

function private strtovec3(str) {
  output = undefined;
  values = strtok(str, "<dev string:x13c>");

  if(values.size == 3) {
    output = (float(values[0]), float(values[1]), float(values[2]));
  }

  return output;
}

function private function_1e5dca407ad4bf4a(str, chr, startindex) {
  if(!isDefined(startindex)) {
    startindex = 0;
  }

  for(i = startindex; i < str.size; i++) {
    if(str[i] == chr) {
      return i;
    }
  }

  return -1;
}

function private function_c296da4701b1ce9b(arguments, index) {
  count = 0;
  var_b2f125581538bafc = -1;
  var_53b4c911d83a4925 = -1;

  while(count < index) {
    var_b2f125581538bafc = function_1e5dca407ad4bf4a(arguments, "<dev string:x141>", var_53b4c911d83a4925 + 1);
    var_53b4c911d83a4925 = function_1e5dca407ad4bf4a(arguments, "<dev string:x146>", var_b2f125581538bafc + 1);

    if(var_b2f125581538bafc == -1 || var_53b4c911d83a4925 == -1) {
      return undefined;
    }

    count++;
  }

  return strtovec3(getsubstr(arguments, var_b2f125581538bafc + 1, var_53b4c911d83a4925));
}

function private function_3f27417cba3bd71c(startpos, endpos, errorpos) {
  level notify("<dev string:x14b>");
  level endon("<dev string:x14b>");
  pathpositions = level.players[0] findpath(startpos, endpos);

  if(!isDefined(pathpositions) || pathpositions.size == 0) {
    printtoscreen2d(700, 150, "<dev string:x162>", (1, 0, 0), 3, 100);
  } else if(distance2dsquared(pathpositions[pathpositions.size - 1], endpos) > 2) {
    printtoscreen2d(700, 150, "<dev string:x173>", (1, 0, 0), 3, 100);
  }

  while(true) {
    sphere(startpos, 8, (1, 0, 1), 0, level.var_e117330e38c95d0b);
    sphere(endpos, 8, (0, 0, 1), 0, level.var_e117330e38c95d0b);

    if(isvector(errorpos)) {
      sphere(errorpos, 8, (1, 0, 0), 0, level.var_e117330e38c95d0b);
    }

    foreach(point in pathpositions) {
      sphere(point, 4, (0, 1, 0), 0, level.var_e117330e38c95d0b);
    }

    for(i = 0; i < pathpositions.size - 1; i++) {
      line(pathpositions[i], pathpositions[i + 1], (1, 0.5, 0), 1, 0, level.var_e117330e38c95d0b);
    }

    wait level.var_5683153ad305ce08;
  }
}

# /