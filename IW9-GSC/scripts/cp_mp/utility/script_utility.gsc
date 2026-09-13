/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\script_utility.gsc
****************************************************/

registersharedfunc(category, _id_EA847593E957F2B0, function) {
  if(!isDefined(level.sharedfuncs))
    level.sharedfuncs = [];

  if(!isDefined(level.sharedfuncs[category]))
    level.sharedfuncs[category] = [];

  level.sharedfuncs[category][_id_EA847593E957F2B0] = function;
}

issharedfuncdefined(category, _id_EA847593E957F2B0, _id_74E2CB47254BC22C) {
  if(!isDefined(level.sharedfuncs))
    return 0;

  if(!isDefined(level.sharedfuncs[category]))
    return 0;

  func = level.sharedfuncs[category][_id_EA847593E957F2B0];

  if(!isDefined(func)) {
    if(istrue(_id_74E2CB47254BC22C)) {}

    return 0;
  }

  return 1;
}

getsharedfunc(category, _id_EA847593E957F2B0) {
  return level.sharedfuncs[category][_id_EA847593E957F2B0];
}

_id_F3BB4F4911A1BEB2(category, _id_EA847593E957F2B0, _id_F3CB1D51D632B4BA, param1, param2, param3, param4, param5, param6, param7, param8) {
  if(!isDefined(category) || !isDefined(_id_EA847593E957F2B0)) {
    return;
  }
  if(!issharedfuncdefined(category, _id_EA847593E957F2B0)) {
    return;
  }
  func = getsharedfunc(category, _id_EA847593E957F2B0);

  if(isDefined(param8))
    return self[[func]](_id_F3CB1D51D632B4BA, param1, param2, param3, param4, param5, param6, param7, param8);

  if(isDefined(param7))
    return self[[func]](_id_F3CB1D51D632B4BA, param1, param2, param3, param4, param5, param6, param7);

  if(isDefined(param6))
    return self[[func]](_id_F3CB1D51D632B4BA, param1, param2, param3, param4, param5, param6);

  if(isDefined(param5))
    return self[[func]](_id_F3CB1D51D632B4BA, param1, param2, param3, param4, param5);
  else if(isDefined(param4))
    return self[[func]](_id_F3CB1D51D632B4BA, param1, param2, param3, param4);
  else if(isDefined(param3))
    return self[[func]](_id_F3CB1D51D632B4BA, param1, param2, param3);
  else if(isDefined(param2))
    return self[[func]](_id_F3CB1D51D632B4BA, param1, param2);
  else if(isDefined(param1))
    return self[[func]](_id_F3CB1D51D632B4BA, param1);
  else if(isDefined(_id_F3CB1D51D632B4BA))
    return self[[func]](_id_F3CB1D51D632B4BA);
  else
    return self[[func]]();
}