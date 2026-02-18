/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7a8059ca02b7b09e.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#namespace telemetry;

function add_callback(callback_id, callback_func) {
  callback::add_callback(callback_id, callback_func);
}

function function_98df8818(callback, func) {
  if(!isDefined(level.var_1bebdc8e)) {
    level.var_1bebdc8e = [];
  }

  if(!isDefined(level.var_1bebdc8e[callback])) {
    level.var_1bebdc8e[callback] = [];
  }

  level.var_1bebdc8e[callback][level.var_1bebdc8e[callback].size] = func;
}

function function_18135b72(callback, data) {
  if(!isDefined(level.var_1bebdc8e)) {
    return;
  }

  if(!isDefined(level.var_1bebdc8e[callback])) {
    return;
  }

  if(isDefined(data)) {
    for(i = 0; i < level.var_1bebdc8e[callback].size; i++) {
      thread[[level.var_1bebdc8e[callback][i]]](data);
    }

    return;
  }

  for(i = 0; i < level.var_1bebdc8e[callback].size; i++) {
    thread[[level.var_1bebdc8e[callback][i]]]();
  }
}

function function_f397069a() {
  while(level.var_d3427749 === gettime()) {
    waitframe(1);
  }

  level.var_d3427749 = gettime();
}