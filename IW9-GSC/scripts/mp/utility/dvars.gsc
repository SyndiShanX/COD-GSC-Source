/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\dvars.gsc
***********************************************/

dvarintvalue(dvar, _id_A10706CA944ECD97, _id_BA033AECCA09825A, _id_B8A569BEF8F3AC2C) {
  dvar = _func_2EF675C13CA1C4AF("scr_", level.gametype, "_", dvar);

  if(getDvar(dvar) == "") {
    setDvar(dvar, _id_A10706CA944ECD97);
    return _id_A10706CA944ECD97;
  }

  value = getdvarint(dvar);

  if(value > _id_B8A569BEF8F3AC2C)
    value = _id_B8A569BEF8F3AC2C;
  else if(value < _id_BA033AECCA09825A)
    value = _id_BA033AECCA09825A;
  else
    return value;

  setDvar(dvar, value);
  return value;
}

dvarfloatvalue(dvar, _id_A10706CA944ECD97, _id_BA033AECCA09825A, _id_B8A569BEF8F3AC2C) {
  dvar = _func_2EF675C13CA1C4AF("scr_", level.gametype, "_", dvar);

  if(getDvar(dvar) == "") {
    setDvar(dvar, _id_A10706CA944ECD97);
    return _id_A10706CA944ECD97;
  }

  value = getdvarfloat(dvar);

  if(value > _id_B8A569BEF8F3AC2C)
    value = _id_B8A569BEF8F3AC2C;
  else if(value < _id_BA033AECCA09825A)
    value = _id_BA033AECCA09825A;
  else
    return value;

  setDvar(dvar, value);
  return value;
}

registerwatchdvarint(_id_0F184C2D57255363, _id_FC8AFB765C52482B) {
  _id_CEFFD5A372961F55 = _func_2EF675C13CA1C4AF("scr_", level.gametype, "_", _id_0F184C2D57255363);

  if(getdvarint(_id_CEFFD5A372961F55, -1) == -1)
    setDvar(_id_CEFFD5A372961F55, _id_FC8AFB765C52482B);

  level.watchdvars[_id_CEFFD5A372961F55] = spawnStruct();
  level.watchdvars[_id_CEFFD5A372961F55].value = getdvarint(_id_CEFFD5A372961F55, _id_FC8AFB765C52482B);
  level.watchdvars[_id_CEFFD5A372961F55].type = "int";
  level.watchdvars[_id_CEFFD5A372961F55].notifystring = "update_" + _id_0F184C2D57255363;
}

registerwatchdvarfloat(_id_0F184C2D57255363, _id_FC8AFB765C52482B) {
  _id_CEFFD5A372961F55 = _func_2EF675C13CA1C4AF("scr_", level.gametype, "_", _id_0F184C2D57255363);

  if(getdvarfloat(_id_CEFFD5A372961F55, -1) == -1)
    setDvar(_id_CEFFD5A372961F55, _id_FC8AFB765C52482B);

  level.watchdvars[_id_CEFFD5A372961F55] = spawnStruct();
  level.watchdvars[_id_CEFFD5A372961F55].value = getdvarfloat(_id_CEFFD5A372961F55, _id_FC8AFB765C52482B);
  level.watchdvars[_id_CEFFD5A372961F55].type = "float";
  level.watchdvars[_id_CEFFD5A372961F55].notifystring = "update_" + _id_0F184C2D57255363;
}

registerwatchdvar(_id_0F184C2D57255363, _id_FC8AFB765C52482B) {
  _id_CEFFD5A372961F55 = _func_2EF675C13CA1C4AF("scr_", level.gametype, "_", _id_0F184C2D57255363);

  if(getDvar(_id_CEFFD5A372961F55, "") == "")
    setDvar(_id_CEFFD5A372961F55, _id_FC8AFB765C52482B);

  level.watchdvars[_id_CEFFD5A372961F55] = spawnStruct();
  level.watchdvars[_id_CEFFD5A372961F55].value = getDvar(_id_CEFFD5A372961F55, _id_FC8AFB765C52482B);
  level.watchdvars[_id_CEFFD5A372961F55].type = "string";
  level.watchdvars[_id_CEFFD5A372961F55].notifystring = "update_" + _id_0F184C2D57255363;
}

setoverridewatchdvar(_id_CEFFD5A372961F55, value) {
  _id_EB5F2CFFBF051614 = _func_2EF675C13CA1C4AF("scr_", level.gametype, "_", _id_CEFFD5A372961F55);
  level.overridewatchdvars[_id_EB5F2CFFBF051614] = value;
}

getwatcheddvar(_id_CEFFD5A372961F55) {
  _id_EB5F2CFFBF051614 = _id_3514AE5D09F47ED2(_id_CEFFD5A372961F55);

  if(isDefined(level.overridewatchdvars) && isDefined(level.overridewatchdvars[_id_EB5F2CFFBF051614]))
    return level.overridewatchdvars[_id_EB5F2CFFBF051614];
  else if(isDefined(level.watchdvars) && isDefined(level.watchdvars[_id_EB5F2CFFBF051614]) && isDefined(level.watchdvars[_id_EB5F2CFFBF051614].value))
    return level.watchdvars[_id_EB5F2CFFBF051614].value;
  else
    return undefined;
}

_id_3514AE5D09F47ED2(_id_CEFFD5A372961F55) {
  return _func_2EF675C13CA1C4AF("scr_", level.gametype, "_", _id_CEFFD5A372961F55);
}

updatewatcheddvarsexecute() {
  watchdvars = getarraykeys(level.watchdvars);

  foreach(_id_CEFFD5A372961F55 in watchdvars) {
    if(level.watchdvars[_id_CEFFD5A372961F55].type == "string")
      _id_6686D1519FD59C8D = getproperty(_id_CEFFD5A372961F55, level.watchdvars[_id_CEFFD5A372961F55].value);
    else if(level.watchdvars[_id_CEFFD5A372961F55].type == "float")
      _id_6686D1519FD59C8D = getfloatproperty(_id_CEFFD5A372961F55, level.watchdvars[_id_CEFFD5A372961F55].value);
    else
      _id_6686D1519FD59C8D = getintproperty(_id_CEFFD5A372961F55, level.watchdvars[_id_CEFFD5A372961F55].value);

    if(_id_6686D1519FD59C8D != level.watchdvars[_id_CEFFD5A372961F55].value) {
      level.watchdvars[_id_CEFFD5A372961F55].value = _id_6686D1519FD59C8D;
      level notify(level.watchdvars[_id_CEFFD5A372961F55].notifystring, _id_6686D1519FD59C8D);
    }
  }
}

updatewatcheddvars() {
  while(game["state"] == "playing") {
    updatewatcheddvarsexecute();
    wait 1.0;
  }
}

getproperty(dvar, _id_628828A6D842B1B9) {
  value = _id_628828A6D842B1B9;
  value = getDvar(dvar, _id_628828A6D842B1B9);
  return value;
}

getintproperty(dvar, _id_628828A6D842B1B9) {
  value = _id_628828A6D842B1B9;
  value = getdvarint(dvar, _id_628828A6D842B1B9);
  return value;
}

getfloatproperty(dvar, _id_628828A6D842B1B9) {
  value = _id_628828A6D842B1B9;
  value = getdvarfloat(dvar, _id_628828A6D842B1B9);
  return value;
}

getoverridedvarintexceptmatchrulesvalues(override, _id_EFDC2688D5BFF83F) {
  return getdvarint(override, getdvarint(_id_EFDC2688D5BFF83F));
}

getoverridedvarfloatexceptmatchrulesvalues(override, _id_EFDC2688D5BFF83F) {
  return getdvarfloat(override, getdvarfloat(_id_EFDC2688D5BFF83F));
}

getoverridedvarexceptmatchrulesvalues(override, _id_EFDC2688D5BFF83F) {
  return getDvar(override, getDvar(_id_EFDC2688D5BFF83F));
}