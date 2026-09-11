/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\dvars.gsc
***********************************************/

function dvarintvalue(var_0, var_1, var_2, var_3) {
  var_0 = "scr_" + level.gametype + "_" + var_0;

  if(getDvar(var_0) == "") {
    setDvar(var_0, var_1);
    return var_1;
  }

  var_4 = getdvarint(var_0);

  if(var_4 > var_3) {
    var_4 = var_3;
  } else if(var_4 < var_2) {
    var_4 = var_2;
  } else {
    return var_4;
  }

  setDvar(var_0, var_4);
  return var_4;
}

function dvarfloatvalue(var_0, var_1, var_2, var_3) {
  var_0 = "scr_" + level.gametype + "_" + var_0;

  if(getDvar(var_0) == "") {
    setDvar(var_0, var_1);
    return var_1;
  }

  var_4 = getdvarfloat(var_0);

  if(var_4 > var_3) {
    var_4 = var_3;
  } else if(var_4 < var_2) {
    var_4 = var_2;
  } else {
    return var_4;
  }

  setDvar(var_0, var_4);
  return var_4;
}

function registerwatchdvarint(var_0, var_1) {
  var_2 = "scr_" + level.gametype + "_" + var_0;

  if(getdvarint(var_2, -1) == -1) {
    setDvar(var_2, var_1);
  }

  level.watchdvars[var_2] = spawnStruct();
  level.watchdvars[var_2].value = getdvarint(var_2, var_1);
  level.watchdvars[var_2].type = "int";
  level.watchdvars[var_2].notifystring = "update_" + var_0;
}

function registerwatchdvarfloat(var_0, var_1) {
  var_2 = "scr_" + level.gametype + "_" + var_0;

  if(getdvarfloat(var_2, -1) == -1) {
    setDvar(var_2, var_1);
  }

  level.watchdvars[var_2] = spawnStruct();
  level.watchdvars[var_2].value = getdvarfloat(var_2, var_1);
  level.watchdvars[var_2].type = "float";
  level.watchdvars[var_2].notifystring = "update_" + var_0;
}

function registerwatchdvar(var_0, var_1) {
  var_2 = "scr_" + level.gametype + "_" + var_0;

  if(getDvar(var_2, "") == "") {
    setDvar(var_2, var_1);
  }

  level.watchdvars[var_2] = spawnStruct();
  level.watchdvars[var_2].value = getDvar(var_2, var_1);
  level.watchdvars[var_2].type = "string";
  level.watchdvars[var_2].notifystring = "update_" + var_0;
}

function setoverridewatchdvar(var_0, var_1) {
  var_0 = "scr_" + level.gametype + "_" + var_0;
  level.overridewatchdvars[var_0] = var_1;
}

function getwatcheddvar(var_0) {
  var_0 = getwatcheddvarstring(var_0);

  if(isDefined(level.overridewatchdvars) && isDefined(level.overridewatchdvars[var_0])) {
    return level.overridewatchdvars[var_0];
  }

  if(isDefined(level.watchdvars) && isDefined(level.watchdvars[var_0]) && isDefined(level.watchdvars[var_0].value)) {
    return level.watchdvars[var_0].value;
  }

  return undefined;
}

function getwatcheddvarstring(var_0) {
  return "scr_" + level.gametype + "_" + var_0;
}

function updatewatcheddvarsexecute() {
  var_0 = getarraykeys(level.watchdvars);

  foreach(var_2 in var_0) {
    if(level.watchdvars[var_2].type == "string") {
      var_3 = getproperty(var_2, level.watchdvars[var_2].value);
    } else if(level.watchdvars[var_2].type == "float") {
      var_3 = getfloatproperty(var_2, level.watchdvars[var_2].value);
    } else {
      var_3 = getintproperty(var_2, level.watchdvars[var_2].value);
    }

    if(var_3 != level.watchdvars[var_2].value) {
      level.watchdvars[var_2].value = var_3;
      level notify(level.watchdvars[var_2].notifystring, var_3);
    }
  }
}

function updatewatcheddvars() {
  while(game["state"] == "playing") {
    updatewatcheddvarsexecute();
    wait 1;
  }
}

function getproperty(var_0, var_1) {
  var_2 = var_1;
  var_2 = getDvar(var_0, var_1);
  return var_2;
}

function getintproperty(var_0, var_1) {
  var_2 = var_1;
  var_2 = getdvarint(var_0, var_1);
  return var_2;
}

function getfloatproperty(var_0, var_1) {
  var_2 = var_1;
  var_2 = getdvarfloat(var_0, var_1);
  return var_2;
}

function respawn_players_into_plane(var_0, var_1) {
  return getdvarint(var_0, getdvarint(var_1));
}

function respawn_locations(var_0, var_1) {
  return getdvarfloat(var_0, getdvarfloat(var_1));
}

function respawn_index(var_0, var_1) {
  return getDvar(var_0, getDvar(var_1));
}