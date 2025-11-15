/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\map.gsc
***********************************************/

#namespace map;

init() {
  get_script_bundle();
}

get_script_bundle() {
  if(!isDefined(level.var_427d6976)) {
    level.var_427d6976 = function_2717b55f();
  }

  if(!isDefined(level.var_427d6976)) {
    level.var_179eaba8 = 1;
    level.var_427d6976 = {};
  } else {
    level.var_179eaba8 = 0;
  }

  return level.var_427d6976;
}

is_default() {
  if(!isDefined(level.var_179eaba8)) {
    level.var_179eaba8 = 1;
  }

  return level.var_179eaba8;
}