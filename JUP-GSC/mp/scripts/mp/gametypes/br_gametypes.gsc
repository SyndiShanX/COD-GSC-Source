/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametypes.gsc
*************************************************/

#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\utility\script;
#namespace br_gametypes;

function init() {
  level.brgametype = spawnStruct();
  level.brgametype.funcs = [];
  level.brgametype.disabledfeatures = [];
  level.brgametype.enabledfeatures = [];
  level.brgametype.data = [];
  level.brgametype.name = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();

  if(isDefined(level.var_cdc15ee14362fbf)) {
    [[level.var_cdc15ee14362fbf]]();
  }
}

function registerbrgametypefunc(funcname, function) {
  if(isDefined(level.brgametype.funcs[funcname])) {
    scripts\mp\utility\script::demoforcesre("registerBrGametypeFunc already has " + funcname + " defined.");
  }

  level.brgametype.funcs[funcname] = function;
}

function function_ec416fa15d5fa6af(funcname) {
  level.brgametype.funcs[funcname] = undefined;
}

function function_ac438828015a7653(funcname) {
  return level.brgametype.funcs[funcname];
}

function runbrgametypefunc6(funcname, param1, param2, param3, param4, param5, param6) {
  return [[level.brgametype.funcs[funcname]]](param1, param2, param3, param4, param5, param6);
}

function runbrgametypefunc(funcname, param1, param2) {
  if(isDefined(level.brgametype) && isDefined(level.brgametype.funcs[funcname])) {
    if(isDefined(param2)) {
      return [[level.brgametype.funcs[funcname]]](param1, param2);
    }

    if(isDefined(param1)) {
      return [[level.brgametype.funcs[funcname]]](param1);
    }

    return [[level.brgametype.funcs[funcname]]]();
  }
}

function function_d72afdccedfc9b07(funcname, param1, param2, param3) {
  if(isDefined(level.brgametype.funcs[funcname])) {
    return [[level.brgametype.funcs[funcname]]](param1, param2, param3);
  }
}

function function_d72afaccedfc946e(funcname, param1, param2, param3, param4) {
  if(isDefined(level.brgametype.funcs[funcname])) {
    return [[level.brgametype.funcs[funcname]]](param1, param2, param3, param4);
  }
}

function function_d72af9ccedfc923b(funcname, param1, param2, param3, param4, param5, param6, param7) {
  if(isDefined(level.brgametype.funcs[funcname])) {
    return [[level.brgametype.funcs[funcname]]](param1, param2, param3, param4, param5, param6, param7);
  }
}

function isbrgametypefuncdefined(funcname) {
  return isDefined(level.brgametype) && isDefined(level.brgametype.funcs[funcname]);
}

function disablefeature(featurename) {
  level.brgametype.disabledfeatures[featurename] = 1;
}

function isfeaturedisabled(featurename) {
  return !isDefined(level.brgametype) || istrue(level.brgametype.disabledfeatures[featurename]);
}

function enablefeature(featurename) {
  level.brgametype.enabledfeatures[featurename] = 1;
}

function isfeatureenabled(featurename) {
  return isDefined(level.brgametype) && istrue(level.brgametype.enabledfeatures[featurename]);
}

function registerbrgametypedata(dataref, data) {
  level.brgametype.data[dataref] = data;
}

function getbrgametypedata(dataref) {
  return level.brgametype.data[dataref];
}