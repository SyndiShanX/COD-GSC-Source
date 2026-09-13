/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametypes.gsc
*************************************************/

init() {
  level.brgametype = spawnStruct();
  level.brgametype.funcs = [];
  level.brgametype.disabledfeatures = [];
  level.brgametype.enabledfeatures = [];
  level.brgametype.data = [];
  level.brgametype.name = getDvar("dvar_7611A2790A0BF7FE", "");

  if(level.brgametype.name == "none")
    level.brgametype.name = "";

  if(level.brgametype.name == "dmz")
    _id_4480C6CE37B2BDF3::init();
}

registerbrgametypefunc(_id_EA847593E957F2B0, function) {
  if(isDefined(level.brgametype.funcs[_id_EA847593E957F2B0]))
    scripts\mp\utility\script::demoforcesre("registerBrGametypeFunc already has " + _id_EA847593E957F2B0 + " defined.");

  level.brgametype.funcs[_id_EA847593E957F2B0] = function;
}

_id_EC416FA15D5FA6AF(_id_EA847593E957F2B0) {
  level.brgametype.funcs[_id_EA847593E957F2B0] = undefined;
}

runbrgametypefunc6(_id_EA847593E957F2B0, param1, param2, param3, param4, param5, param6) {
  return [[level.brgametype.funcs[_id_EA847593E957F2B0]]](param1, param2, param3, param4, param5, param6);
}

runbrgametypefunc(_id_EA847593E957F2B0, param1, param2) {
  if(isDefined(level.brgametype) && isDefined(level.brgametype.funcs[_id_EA847593E957F2B0])) {
    if(isDefined(param2))
      return [[level.brgametype.funcs[_id_EA847593E957F2B0]]](param1, param2);
    else if(isDefined(param1))
      return [[level.brgametype.funcs[_id_EA847593E957F2B0]]](param1);
    else
      return [[level.brgametype.funcs[_id_EA847593E957F2B0]]]();
  }
}

_id_D72AFDCCEDFC9B07(_id_EA847593E957F2B0, param1, param2, param3) {
  if(isDefined(level.brgametype.funcs[_id_EA847593E957F2B0]))
    return [[level.brgametype.funcs[_id_EA847593E957F2B0]]](param1, param2, param3);
}

_id_D72AFACCEDFC946E(_id_EA847593E957F2B0, param1, param2, param3, param4) {
  if(isDefined(level.brgametype.funcs[_id_EA847593E957F2B0]))
    return [[level.brgametype.funcs[_id_EA847593E957F2B0]]](param1, param2, param3, param4);
}

_id_D72AF9CCEDFC923B(_id_EA847593E957F2B0, param1, param2, param3, param4, param5, param6, param7) {
  if(isDefined(level.brgametype.funcs[_id_EA847593E957F2B0]))
    return [[level.brgametype.funcs[_id_EA847593E957F2B0]]](param1, param2, param3, param4, param5, param6, param7);
}

isbrgametypefuncdefined(_id_EA847593E957F2B0) {
  return isDefined(level.brgametype) && isDefined(level.brgametype.funcs[_id_EA847593E957F2B0]);
}

disablefeature(_id_3F44C731FDDDD082) {
  level.brgametype.disabledfeatures[_id_3F44C731FDDDD082] = 1;
}

isfeaturedisabled(_id_3F44C731FDDDD082) {
  return !isDefined(level.brgametype) || istrue(level.brgametype.disabledfeatures[_id_3F44C731FDDDD082]);
}

enablefeature(_id_3F44C731FDDDD082) {
  level.brgametype.enabledfeatures[_id_3F44C731FDDDD082] = 1;
}

isfeatureenabled(_id_3F44C731FDDDD082) {
  return isDefined(level.brgametype) && istrue(level.brgametype.enabledfeatures[_id_3F44C731FDDDD082]);
}

registerbrgametypedata(_id_AC85B79DFC4E45C6, data) {
  level.brgametype.data[_id_AC85B79DFC4E45C6] = data;
}

getbrgametypedata(_id_AC85B79DFC4E45C6) {
  return level.brgametype.data[_id_AC85B79DFC4E45C6];
}