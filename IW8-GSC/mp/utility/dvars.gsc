/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\dvars.gsc
***********************************************/

dvarintvalue(var_0, var_1, var_2, var_3) {
  var_0 = "_encstr_AF1805EFE726E9" + level.gametype + "_encstr_BA4C02DF" + var_0;

  if(getDvar(var_0) == "_encstr_B40101") {
    setDvar(var_0, var_1);
    return var_1;
  }

  var_4 = getdvarint(var_0);

  if(var_4 > var_3)
    var_4 = var_3;
  else if(var_4 < var_2)
    var_4 = var_2;
  else
    return var_4;

  setDvar(var_0, var_4);
  return var_4;
}

dvarfloatvalue(var_0, var_1, var_2, var_3) {
  var_0 = "_encstr_AF1805EFE726E9" + level.gametype + "_encstr_BA4C02DF" + var_0;

  if(getDvar(var_0) == "_encstr_B40101") {
    setDvar(var_0, var_1);
    return var_1;
  }

  var_4 = getdvarfloat(var_0);

  if(var_4 > var_3)
    var_4 = var_3;
  else if(var_4 < var_2)
    var_4 = var_2;
  else
    return var_4;

  setDvar(var_0, var_4);
  return var_4;
}

registerwatchdvarint(var_0, var_1) {
  var_2 = "_encstr_AF1805EFE726E9" + level.gametype + "_encstr_BA4C02DF" + var_0;

  if(getdvarint(var_2, -1) == -1)
    setDvar(var_2, var_1);

  level.watchdvars[var_2] = spawnStruct();
  level.watchdvars[var_2].value = getdvarint(var_2, var_1);
  level.watchdvars[var_2].type = "_encstr_921904C3DEF8";
  level.watchdvars[var_2].notifystring = "_encstr_AA8A088D2A72F3A34D5F" + var_0;
}

registerwatchdvarfloat(var_0, var_1) {
  var_2 = "_encstr_AF1805EFE726E9" + level.gametype + "_encstr_BA4C02DF" + var_0;

  if(getdvarfloat(var_2, -1) == -1)
    setDvar(var_2, var_1);

  level.watchdvars[var_2] = spawnStruct();
  level.watchdvars[var_2].value = getdvarfloat(var_2, var_1);
  level.watchdvars[var_2].type = "_encstr_8AA9066663F62C3A";
  level.watchdvars[var_2].notifystring = "_encstr_AA8A088D2A72F3A34D5F" + var_0;
}

registerwatchdvar(var_0, var_1) {
  var_2 = "_encstr_AF1805EFE726E9" + level.gametype + "_encstr_BA4C02DF" + var_0;

  if(getDvar(var_2, "_encstr_B40101") == "_encstr_B40101")
    setDvar(var_2, var_1);

  level.watchdvars[var_2] = spawnStruct();
  level.watchdvars[var_2].value = getDvar(var_2, var_1);
  level.watchdvars[var_2].type = "_encstr_A1D80717112333A5D4";
  level.watchdvars[var_2].notifystring = "_encstr_AA8A088D2A72F3A34D5F" + var_0;
}

setoverridewatchdvar(var_0, var_1) {
  var_0 = "_encstr_AF1805EFE726E9" + level.gametype + "_encstr_BA4C02DF" + var_0;
  level.overridewatchdvars[var_0] = var_1;
}

getwatcheddvar(var_0) {
  var_0 = getwatcheddvarstring(var_0);

  if(isDefined(level.overridewatchdvars) && isDefined(level.overridewatchdvars[var_0]))
    return level.overridewatchdvars[var_0];
  else if(isDefined(level.watchdvars) && isDefined(level.watchdvars[var_0]) && isDefined(level.watchdvars[var_0].value))
    return level.watchdvars[var_0].value;
  else
    return undefined;
}

getwatcheddvarstring(var_0) {
  return "_encstr_AF1805EFE726E9" + level.gametype + "_encstr_BA4C02DF" + var_0;
}

updatewatcheddvarsexecute() {
  var_0 = getarraykeys(level.watchdvars);

  foreach(var_2 in var_0) {
    if(level.watchdvars[var_2].type == "_encstr_A1D80717112333A5D4")
      var_3 = getproperty(var_2, level.watchdvars[var_2].value);
    else if(level.watchdvars[var_2].type == "_encstr_8AA9066663F62C3A")
      var_3 = getfloatproperty(var_2, level.watchdvars[var_2].value);
    else
      var_3 = getintproperty(var_2, level.watchdvars[var_2].value);

    if(var_3 != level.watchdvars[var_2].value) {
      level.watchdvars[var_2].value = var_3;
      level notify(level.watchdvars[var_2].notifystring, var_3);
    }
  }
}

updatewatcheddvars() {
  while(game["_encstr_A1AD062E09D98338"] == "_encstr_877508C1D8C22F2DDC3B") {
    updatewatcheddvarsexecute();
    wait 1.0;
  }
}

getproperty(var_0, var_1) {
  var_2 = var_1;
  var_2 = getDvar(var_0, var_1);
  return var_2;
}

getintproperty(var_0, var_1) {
  var_2 = var_1;
  var_2 = getdvarint(var_0, var_1);
  return var_2;
}

getfloatproperty(var_0, var_1) {
  var_2 = var_1;
  var_2 = getdvarfloat(var_0, var_1);
  return var_2;
}

respawn_players_into_plane(var_0, var_1) {
  return getdvarint(var_0, getdvarint(var_1));
}

respawn_locations(var_0, var_1) {
  return getdvarfloat(var_0, getdvarfloat(var_1));
}

respawn_index(var_0, var_1) {
  return getDvar(var_0, getDvar(var_1));
}