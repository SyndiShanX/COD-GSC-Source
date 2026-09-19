/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\sg_events_v1\_options.gsc
*************************************************************/

set_option(var_0, var_1) {
  if(!isDefined(level.sg_event_options))
    level.sg_event_options = [];

  level.sg_event_options[var_0] = var_1;
}

_id_4265(var_0) {
  if(!isDefined(level.sg_event_options))
    return undefined;

  return level.sg_event_options[var_0];
}

create_option(var_0, var_1) {
  if(!isDefined(level.sg_event_option_funcs))
    level.sg_event_option_funcs = [];

  level.sg_event_option_funcs[var_0] = var_1;
}

apply_option(var_0) {
  var_1 = _id_4265(var_0);

  if(isDefined(var_1) && isDefined(level.sg_event_option_funcs[var_1]))
    level thread[[level.sg_event_option_funcs[var_1]]]();
}