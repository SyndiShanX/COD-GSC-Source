/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\engine\scriptable_ascender.gsc
**************************************************/

#using scripts\common\values;
#namespace scriptable_ascender;

function function_959621fba91be23a(var_3ae5eb2fb5d3efbb) {
  level.var_bb575808409344ee = var_3ae5eb2fb5d3efbb;
}

function function_432ef320b0c53fcd(canusecallback) {
  level.ascender_can_use = canusecallback;
}

function function_784813a62abce5fe(usedcallback) {
  if(!isDefined(level.var_79d0243547ca5195)) {
    level.var_79d0243547ca5195 = [];
  }

  level.var_79d0243547ca5195[level.var_79d0243547ca5195.size] = usedcallback;
}

function function_4b79d00966274afd(instance, player, edgeindex, isvertical, isinverted, isgoingup) {
  if(instance.forcedisabled || !player val::get("ascender_use")) {
    s = spawnStruct();
    s.type = "HINT_NOBUTTON";
    s.string = &"";
    return s;
  }

  if(isDefined(level.var_bb575808409344ee)) {
    return [[level.var_bb575808409344ee]](instance, player, edgeindex, isvertical, isinverted, isgoingup);
  }

  return undefined;
}

function function_3964a642425ff608(instance, player, edgeindex, isinverted, isvertical) {
  if(instance.forcedisabled || !player val::get("ascender_use")) {
    return 0;
  }

  if(isDefined(level.ascender_can_use)) {
    return [[level.ascender_can_use]](instance, player, edgeindex, isinverted, isvertical);
  }

  return 1;
}

function event_handler[event_89502489b930db54] function_89502489b930db54(instance, player, edgeindex, isinverted, isvertical, ascendervec) {
  if(isDefined(level.var_79d0243547ca5195)) {
    foreach(used_func in level.var_79d0243547ca5195) {
      [[used_func]](instance, player, edgeindex, isinverted, isvertical, ascendervec);
    }
  }
}