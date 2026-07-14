/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_37a945f9ae16cee7.gsc
*****************************************************/

#using scripts\common\system;
#namespace namespace_c3639b4d4a9c5639;

function private autoexec __init__system__() {
  system::register(#"hash_fbb958c981a70168", undefined, undefined, &init_gameplaysfx);
}

function init_gameplaysfx() {
  if(!isDefined(game["\x9f\xd8\xc3*\x99kf\x9d\x7fs-\\"])) {
    game["\x9f\xd8\xc3*\x99kf\x9d\x7fs-\\"] = [];
  }

  if(isDefined(level.gametypebundle) && isDefined(level.gametypebundle.gameplaysfx)) {
    gametypesfxbundle = getscriptbundle(level.gametypebundle.gameplaysfx);

    if(isDefined(gametypesfxbundle)) {
      setgameplaysfx(gametypesfxbundle);
    }
  }

  if(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.gameplaysfx)) {
    gamemodesfxbundle = getscriptbundle(level.gamemodebundle.gameplaysfx);

    if(isDefined(gamemodesfxbundle)) {
      setgameplaysfx(gamemodesfxbundle);
    }
  }
}

function setgameplaysfx(bundlesfx) {
  foreach(event in bundlesfx.var_fb5d063a34b1f4f7) {
    if(!isDefined(event.soundref)) {
      continue;
    }

    if(!isDefined(game["\x9f\xd8\xc3*\x99kf\x9d\x7fs-\\"][event.soundref])) {
      game["\x9f\xd8\xc3*\x99kf\x9d\x7fs-\\"][event.soundref] = event.alias;
    }
  }
}

function getgameplaysfx(soundref) {
  soundhash = soundref;

  if(!isxhash(soundref)) {
    soundhash = getxhash(soundref);
  }

  if(!isDefined(game["<dev string:x24>"][soundhash])) {
    println("<dev string:x34>" + getxhashsourcename(soundhash) + "<dev string:x55>");
  }

  return game["\x9f\xd8\xc3*\x99kf\x9d\x7fs-\\"][soundhash];
}

function playlocalsoundfx(soundref, notifystring, var_4715aa6f468d5048, var_abd9d54193191e2d) {
  if(!isDefined(soundref)) {
    println("<dev string:x81>");
    return;
  }

  soundalias = getgameplaysfx(soundref);

  if(!isDefined(soundalias)) {
    return;
  }

  self playlocalsound(soundalias, notifystring, var_4715aa6f468d5048, var_abd9d54193191e2d);
}

function stoplocalsoundfx(soundref) {
  if(!isDefined(self) || istrue(self.isdisconnecting)) {
    println("<dev string:xac>");
    return;
  }

  if(!isDefined(soundref)) {
    println("<dev string:xe3>");
    return;
  }

  soundalias = getgameplaysfx(soundref);

  if(!isDefined(soundalias)) {
    return;
  }

  self stoplocalsound(soundalias);
}

function function_9ae296eea511234d(soundref, players, excludeplayer, notifystring, var_4715aa6f468d5048, var_abd9d54193191e2d) {
  if(!isDefined(soundref)) {
    println("<dev string:x10e>");
    return;
  }

  soundalias = getgameplaysfx(soundref);

  if(!isDefined(soundalias)) {
    return;
  }

  if(isarray(players)) {
    foreach(player in players) {
      if(isPlayer(player) && !isagent(player) && (!isDefined(excludeplayer) || player != excludeplayer)) {
        player playlocalsound(soundalias, notifystring, var_4715aa6f468d5048, var_abd9d54193191e2d);
      }
    }

    return;
  }

  assertmsg("<dev string:x143>");
}

function function_f35fbda004f425ed(soundref, team, ignoreplayer, soundsourceent) {
  if(!isDefined(soundref)) {
    println("<dev string:x17b>");
    return;
  }

  soundalias = getgameplaysfx(soundref);

  if(!isDefined(soundalias)) {
    return;
  }

  self playsoundtoteam(soundalias, team, ignoreplayer, soundsourceent);
}

function function_c0bdf0e76ff14ff8(posorigin, soundref) {
  if(!isDefined(soundref)) {
    println("<dev string:x1a7>");
    return;
  }

  if(!isDefined(posorigin)) {
    println("<dev string:x1d2>");
    return;
  }

  soundalias = getgameplaysfx(soundref);

  if(!isDefined(soundalias)) {
    return;
  }

  playsoundatpos(posorigin, soundalias);
}

function function_dab6dc4829c7f3ab(soundref, ignoreplayer, soundsourceent) {
  if(!isDefined(soundref)) {
    println("<dev string:x1fe>");
    return;
  }

  soundalias = getgameplaysfx(soundref);

  if(!isDefined(soundalias)) {
    return;
  }

  self playSound(soundalias, ignoreplayer, soundsourceent);
}

function function_a33e5d0a2e4250c1(soundref) {
  if(!isDefined(soundref)) {
    println("<dev string:x229>");
    return;
  }

  soundalias = getgameplaysfx(soundref);

  if(!isDefined(soundalias)) {
    return;
  }

  self playLoopSound(soundalias);
}