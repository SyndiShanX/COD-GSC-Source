/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\dvars.gsc
***********************************************/

function dvarintvalue(var0, var1, var2, var3) {
  var0 = "scr_" + level.gametype + "_" + var0;

  if(getDvar(var0) == "") {
    setDvar(var0, var1);
    return var1;
  }

  var4 = getdvarint(var0);

  if(var4 > var3) {
    var4 = var3;
  } else if(var4 < var2) {
    var4 = var2;
  } else {
    return var4;
  }

  setDvar(var0, var4);
  return var4;
}

function dvarfloatvalue(var0, var1, var2, var3) {
  var0 = "scr_" + level.gametype + "_" + var0;

  if(getDvar(var0) == "") {
    setDvar(var0, var1);
    return var1;
  }

  var4 = getdvarfloat(var0);

  if(var4 > var3) {
    var4 = var3;
  } else if(var4 < var2) {
    var4 = var2;
  } else {
    return var4;
  }

  setDvar(var0, var4);
  return var4;
}

function registerwatchdvarint(var0, var1) {
  var2 = "scr_" + level.gametype + "_" + var0;

  if(getdvarint(var2, -1) == -1) {
    setDvar(var2, var1);
  }

  level.watchdvars[var2] = spawnStruct();
  level.watchdvars[var2].value = getdvarint(var2, var1);
  level.watchdvars[var2].type = "int";
  level.watchdvars[var2].notifystring = "update_" + var0;
}

function registerwatchdvarfloat(var0, var1) {
  var2 = "scr_" + level.gametype + "_" + var0;

  if(getdvarfloat(var2, -1) == -1) {
    setDvar(var2, var1);
  }

  level.watchdvars[var2] = spawnStruct();
  level.watchdvars[var2].value = getdvarfloat(var2, var1);
  level.watchdvars[var2].type = "float";
  level.watchdvars[var2].notifystring = "update_" + var0;
}

function registerwatchdvar(var0, var1) {
  var2 = "scr_" + level.gametype + "_" + var0;

  if(getDvar(var2, "") == "") {
    setDvar(var2, var1);
  }

  level.watchdvars[var2] = spawnStruct();
  level.watchdvars[var2].value = getDvar(var2, var1);
  level.watchdvars[var2].type = "string";
  level.watchdvars[var2].notifystring = "update_" + var0;
}

function setoverridewatchdvar(var0, var1) {
  var0 = "scr_" + level.gametype + "_" + var0;
  level.overridewatchdvars[var0] = var1;
}

function getwatcheddvar(var0) {
  var0 = getwatcheddvarstring(var0);

  if(isDefined(level.overridewatchdvars) && isDefined(level.overridewatchdvars[var0])) {
    return level.overridewatchdvars[var0];
  }

  if(isDefined(level.watchdvars) && isDefined(level.watchdvars[var0]) && isDefined(level.watchdvars[var0].value)) {
    return level.watchdvars[var0].value;
  }

  return undefined;
}

function getwatcheddvarstring(var0) {
  return "scr_" + level.gametype + "_" + var0;
}

function updatewatcheddvarsexecute() {
  var0 = getarraykeys(level.watchdvars);

  foreach(var2 in var0) {
    if(level.watchdvars[var2].type == "string") {
      var3 = getproperty(var2, level.watchdvars[var2].value);
    } else if(level.watchdvars[var2].type == "float") {
      var3 = getfloatproperty(var2, level.watchdvars[var2].value);
    } else {
      var3 = getintproperty(var2, level.watchdvars[var2].value);
    }

    if(var3 != level.watchdvars[var2].value) {
      level.watchdvars[var2].value = var3;
      level notify(level.watchdvars[var2].notifystring, var3);
    }
  }
}

function updatewatcheddvars() {
  while(game["state"] == "playing") {
    updatewatcheddvarsexecute();
    wait 1;
  }
}

function getproperty(var0, var1) {
  var2 = var1;
  var2 = getDvar(var0, var1);
  return var2;
}

function getintproperty(var0, var1) {
  var2 = var1;
  var2 = getdvarint(var0, var1);
  return var2;
}

function getfloatproperty(var0, var1) {
  var2 = var1;
  var2 = getdvarfloat(var0, var1);
  return var2;
}

function respawn_players_into_plane(var0, var1) {
  return getdvarint(var0, getdvarint(var1));
}

function respawn_locations(var0, var1) {
  return getdvarfloat(var0, getdvarfloat(var1));
}

function respawn_index(var0, var1) {
  return getDvar(var0, getDvar(var1));
}