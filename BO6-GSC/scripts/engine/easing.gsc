/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\engine\easing.gsc
**************************************/

#namespace easing;

function ease_init() {
  level.ease_funcs = [];
  level.ease_funcs["linear"] = &ease_linear;
  level.ease_funcs["power"] = &ease_power;
  level.ease_funcs["quadratic"] = &ease_quadratic;
  level.ease_funcs["cubic"] = &ease_cubic;
  level.ease_funcs["quartic"] = &ease_quartic;
  level.ease_funcs["quintic"] = &ease_quintic;
  level.ease_funcs["exponential"] = &ease_exponential;
  level.ease_funcs["logarithmic"] = &ease_logarithmic;
  level.ease_funcs["sine"] = &ease_sine;
  level.ease_funcs["back"] = &ease_back;
  level.ease_funcs["elastic"] = &ease_elastic;
  level.ease_funcs["bounce"] = &ease_bounce;
}

function ease_linear(start, end, pct, ease_in, ease_out) {
  return (1 - pct) * start + pct * end;
}

function ease_power(start, end, pct, ease_in, ease_out, power) {
  pct = easepower(pct, power, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function ease_quadratic(start, end, pct, ease_in, ease_out) {
  pct = easepower(pct, 2, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function ease_cubic(start, end, pct, ease_in, ease_out) {
  pct = easepower(pct, 3, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function ease_quartic(start, end, pct, ease_in, ease_out) {
  pct = easepower(pct, 4, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function ease_quintic(start, end, pct, ease_in, ease_out) {
  pct = easepower(pct, 5, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function ease_exponential(start, end, pct, ease_in, ease_out, scale) {
  pct = easeexponential(pct, scale, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function ease_logarithmic(start, end, pct, ease_in, ease_out, log_base) {
  pct = easelogarithmic(pct, log_base, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function ease_sine(start, end, pct, ease_in, ease_out) {
  pct = easesine(pct, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function ease_back(start, end, pct, ease_in, ease_out, overshoot_scalar, power) {
  pct = easeback(pct, overshoot_scalar, power, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function ease_elastic(start, end, pct, ease_in, ease_out, amplitude, frequency, fade_scalar) {
  pct = easeelastic(pct, amplitude, frequency, fade_scalar, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function ease_bounce(start, end, pct, ease_in, ease_out, bounces, decay_scalar) {
  pct = easebounce(pct, bounces, decay_scalar, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function ease_dvar(dvar, value, time, ease_type, ease_in, ease_out, ease_param1, ease_param2, ease_param3) {
  function_899e5e0cd171c8e7(&setdvar, dvar, value, time, ease_type, ease_in, ease_out, ease_param1, ease_param2, ease_param3);
}

function ease_saved_dvar(dvar, value, time, ease_type, ease_in, ease_out, ...) {
  function_899e5e0cd171c8e7(&setsaveddvar, dvar, value, time, ease_type, ease_in, ease_out, flat_args(vararg, varargcount));
}

function private function_899e5e0cd171c8e7(dvar_func, dvar, value, time, ease_type, ease_in, ease_out, ...) {
  assert(isDefined(level.ease_funcs));
  assert(isDefined(level.ease_funcs[ease_type]));
  dvar_name = getxhashhexname(dvar);
  level notify("ease_dvar_" + dvar_name);
  level endon("ease_dvar_" + dvar_name);
  start_value = getdvarfloat(dvar);
  cur_value = start_value;
  cur_time = 0;

  while(cur_time < time) {
    cur_time += level.framedurationseconds;
    pct = min(1, cur_time / time);
    cur_value = [[level.ease_funcs[ease_type]]](start_value, value, pct, ease_in, ease_out, flat_args(vararg, varargcount));
    builtin[[dvar_func]](dvar, cur_value);
    waitframe();
  }

  builtin[[dvar_func]](dvar, value);
}