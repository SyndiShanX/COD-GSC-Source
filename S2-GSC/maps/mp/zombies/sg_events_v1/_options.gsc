/*****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\sg_events_v1\_options.gsc
*****************************************************/

set_option(param_00, param_01) {
  if(!isDefined(level.sg_event_options)) {
    level.sg_event_options = [];
  }

  level.sg_event_options[param_00] = param_01;
}

func_4265(param_00) {
  if(!isDefined(level.sg_event_options)) {
    return undefined;
  }

  return level.sg_event_options[param_00];
}

create_option(param_00, param_01) {
  if(!isDefined(level.sg_event_option_funcs)) {
    level.sg_event_option_funcs = [];
  }

  level.sg_event_option_funcs[param_00] = param_01;
}

apply_option(param_00) {
  var_01 = func_4265(param_00);
  if(isDefined(var_01) && isDefined(level.sg_event_option_funcs[var_01])) {
    level thread[[level.sg_event_option_funcs[var_01]]]();
  }
}