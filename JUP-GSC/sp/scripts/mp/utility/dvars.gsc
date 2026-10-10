/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\mp\utility\dvars.gsc
***********************************************/

#namespace dvars;

function dvarintvalue(dvar, defval, minval, maxval) {
  dvar = hashcat(@ "scr_", level.gametype, "_", dvar);

  if(getDvar(dvar) == "") {
    setDvar(dvar, defval);
    return defval;
  }

  value = getdvarint(dvar);

  if(value > maxval) {
    value = maxval;
  } else if(value < minval) {
    value = minval;
  } else {
    return value;
  }

  setDvar(dvar, value);
  return value;
}

function dvarfloatvalue(dvar, defval, minval, maxval) {
  dvar = hashcat(@ "scr_", level.gametype, "_", dvar);

  if(getDvar(dvar) == "") {
    setDvar(dvar, defval);
    return defval;
  }

  value = getdvarfloat(dvar);

  if(value > maxval) {
    value = maxval;
  } else if(value < minval) {
    value = minval;
  } else {
    return value;
  }

  setDvar(dvar, value);
  return value;
}

function registerwatchdvarint(namestring, defaultvalue) {
  dvarstring = hashcat(@ "scr_", level.gametype, "_", namestring);

  if(getdvarint(dvarstring, -1) == -1) {
    setDvar(dvarstring, defaultvalue);
  }

  level.watchdvars[dvarstring] = spawnStruct();
  level.watchdvars[dvarstring].value = getdvarint(dvarstring, defaultvalue);
  level.watchdvars[dvarstring].type = "int";
  level.watchdvars[dvarstring].notifystring = "update_" + namestring;
}

function registerwatchdvarfloat(namestring, defaultvalue) {
  dvarstring = hashcat(@ "scr_", level.gametype, "_", namestring);

  if(getdvarfloat(dvarstring, -1) == -1) {
    setDvar(dvarstring, defaultvalue);
  }

  level.watchdvars[dvarstring] = spawnStruct();
  level.watchdvars[dvarstring].value = getdvarfloat(dvarstring, defaultvalue);
  level.watchdvars[dvarstring].type = "float";
  level.watchdvars[dvarstring].notifystring = "update_" + namestring;
}

function registerwatchdvar(namestring, defaultvalue) {
  dvarstring = hashcat(@ "scr_", level.gametype, "_", namestring);

  if(getDvar(dvarstring, "") == "") {
    setDvar(dvarstring, defaultvalue);
  }

  level.watchdvars[dvarstring] = spawnStruct();
  level.watchdvars[dvarstring].value = getDvar(dvarstring, defaultvalue);
  level.watchdvars[dvarstring].type = "string";
  level.watchdvars[dvarstring].notifystring = "update_" + namestring;
}

function setoverridewatchdvar(dvarstring, value) {
  dvarhash = hashcat(@ "scr_", level.gametype, "_", dvarstring);
  level.overridewatchdvars[dvarhash] = value;
}

function getwatcheddvar(dvarstring) {
  dvarhash = function_3514ae5d09f47ed2(dvarstring);

  if(isDefined(level.overridewatchdvars) && isDefined(level.overridewatchdvars[dvarhash])) {
    return level.overridewatchdvars[dvarhash];
  }

  if(isDefined(level.watchdvars) && isDefined(level.watchdvars[dvarhash]) && isDefined(level.watchdvars[dvarhash].value)) {
    return level.watchdvars[dvarhash].value;
  }

  return undefined;
}

function function_3514ae5d09f47ed2(dvarstring) {
  return hashcat(@ "scr_", level.gametype, "_", dvarstring);
}

function updatewatcheddvarsexecute() {
  watchdvars = getarraykeys(level.watchdvars);

  foreach(dvarstring in watchdvars) {
    if(level.watchdvars[dvarstring].type == "string") {
      dvarvalue = getproperty(dvarstring, level.watchdvars[dvarstring].value);
    } else if(level.watchdvars[dvarstring].type == "float") {
      dvarvalue = getfloatproperty(dvarstring, level.watchdvars[dvarstring].value);
    } else {
      dvarvalue = getintproperty(dvarstring, level.watchdvars[dvarstring].value);
    }

    if(dvarvalue != level.watchdvars[dvarstring].value) {
      level.watchdvars[dvarstring].value = dvarvalue;
      level notify(level.watchdvars[dvarstring].notifystring, dvarvalue);
    }
  }
}

function updatewatcheddvars() {
  while(game["state"] == "playing") {
    updatewatcheddvarsexecute();
    wait 1;
  }
}

function getproperty(dvar, defvalue) {
  value = defvalue;

  setdevdvarifuninitialized(dvar, defvalue);

  value = getDvar(dvar, defvalue);
  return value;
}

function getintproperty(dvar, defvalue) {
  value = defvalue;

  setdevdvarifuninitialized(dvar, defvalue);

  value = getdvarint(dvar, defvalue);
  return value;
}

function getfloatproperty(dvar, defvalue) {
  value = defvalue;

  setdevdvarifuninitialized(dvar, defvalue);

  value = getdvarfloat(dvar, defvalue);
  return value;
}

function getoverridedvarintexceptmatchrulesvalues(override, fallback) {
  return getdvarint(override, getdvarint(fallback));
}

function getoverridedvarfloatexceptmatchrulesvalues(override, fallback) {
  return getdvarfloat(override, getdvarfloat(fallback));
}

function getoverridedvarexceptmatchrulesvalues(override, fallback) {
  return getDvar(override, getDvar(fallback));
}

function function_18581799c48cc262(class, member) {
  assert(isusingmatchrulesdata());
  var_671cacea46ac6a97 = 0;

  var_671cacea46ac6a97 = 1;

  dvar = hashcat(@ "scr_", level.gametype, "_", member);
  data = getmatchrulesdata(class, member);

  if(!var_671cacea46ac6a97) {
    setdynamicdvar(dvar, data);
    return;
  }

  setdevdvarifuninitialized(dvar, data);
}

function function_29227adb79acc568(member, defvalue) {
  dvar = hashcat(@ "scr_", level.gametype, "_", member);
  return getdvarint(dvar, defvalue);
}

function function_ef4d323f56385843(member, defvalue) {
  dvar = hashcat(@ "scr_", level.gametype, "_", member);
  return getdvarfloat(dvar, defvalue);
}

function function_36fd7e50e2a25847(member, defvalue) {
  dvar = hashcat(@ "scr_", level.gametype, "_", member);
  return getDvar(dvar, defvalue);
}

function function_a972e013c8f2f2d4() {
  level notify("<dev string:x1c>");
  level endon("<dev string:x1c>");

  while(true) {
    level waittill("<dev string:x3c>");
    setdevdvarifuninitialized(@ "hash_7ae9abc841dc9c4b", 15);
    setdevdvarifuninitialized(@ "hash_fe0a46289ab091e1", level.radarviewtime);
    setdevdvarifuninitialized(@ "hash_5bded6d7c75e5248", "<dev string:x51>");
    setdevdvarifuninitialized(@ "scr_devchangetimelimit", -1);
    setdevdvarifuninitialized(@ "hash_681596f27a5e0f7a", 30);
    setdevdvarifuninitialized(@ "hash_9d27a693c0c7d81b", 60);
  }
}

# /