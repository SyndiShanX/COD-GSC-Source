/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\engine\easing.gsc
***********************************************/

#using scripts\engine\utility;
#namespace easing;

function ease_init() {
  level.ease_funcs = [];
  level.ease_funcs["linear"] = &ease_linear;
  level.ease_funcs["power"] = &ease_power;
  level.ease_funcs["quadratic"] = &function_5076f55422e87aca;
  level.ease_funcs["cubic"] = &ease_cubic;
  level.ease_funcs["quartic"] = &function_651839ae5c237167;
  level.ease_funcs["quintic"] = &function_8ed1dfbb99ebbffb;
  level.ease_funcs["exponential"] = &function_7c81847ebfb3f5b3;
  level.ease_funcs["logarithmic"] = &function_26eb6629640c404b;
  level.ease_funcs["sine"] = &ease_sine;
  level.ease_funcs["back"] = &ease_back;
  level.ease_funcs["elastic"] = &function_d66c45282cb1cbcf;
  level.ease_funcs["bounce"] = &ease_bounce;
}

function ease_linear(start, end, pct, ease_in, ease_out) {
  return (1 - pct) * start + pct * end;
}

function ease_power(start, end, pct, ease_in, ease_out, power) {
  pct = easepower(pct, power, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function function_5076f55422e87aca(start, end, pct, ease_in, ease_out) {
  pct = easepower(pct, 2, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function ease_cubic(start, end, pct, ease_in, ease_out) {
  pct = easepower(pct, 3, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function function_651839ae5c237167(start, end, pct, ease_in, ease_out) {
  pct = easepower(pct, 4, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function function_8ed1dfbb99ebbffb(start, end, pct, ease_in, ease_out) {
  pct = easepower(pct, 5, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function function_7c81847ebfb3f5b3(start, end, pct, ease_in, ease_out, scale) {
  pct = easeexponential(pct, scale, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function function_26eb6629640c404b(start, end, pct, ease_in, ease_out, log_base) {
  pct = easelogarithmic(pct, log_base, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function ease_sine(start, end, pct, ease_in, ease_out) {
  pct = easesine(pct, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function ease_back(start, end, pct, ease_in, ease_out, var_210d57017070b86f, power) {
  pct = easeback(pct, var_210d57017070b86f, power, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function function_d66c45282cb1cbcf(start, end, pct, ease_in, ease_out, amplitude, frequency, fade_scalar) {
  pct = easeelastic(pct, amplitude, frequency, fade_scalar, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function ease_bounce(start, end, pct, ease_in, ease_out, bounces, decay_scalar) {
  pct = easebounce(pct, bounces, decay_scalar, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function ease_dvar(dvar, value, time, ease_type, ease_in, ease_out, ease_param1, ease_param2, ease_param3) {
  function_5a51a4e5eec18b00(&setdvar, dvar, value, time, ease_type, ease_in, ease_out, ease_param1, ease_param2, ease_param3);
}

function function_106f0697ee4d2c55(dvar, value, time, ease_type, ease_in, ease_out, ease_param1, ease_param2, ease_param3) {
  function_5a51a4e5eec18b00(&setsaveddvar, dvar, value, time, ease_type, ease_in, ease_out, ease_param1, ease_param2, ease_param3);
}

function private function_5a51a4e5eec18b00(dvar_func, dvar, value, time, ease_type, ease_in, ease_out, ease_param1, ease_param2, ease_param3) {
  assert(isDefined(level.ease_funcs));
  assert(isDefined(level.ease_funcs[ease_type]));
  dvar_name = function_f28fd66285fa2c9(dvar);
  level notify("ease_dvar_" + dvar_name);
  level endon("ease_dvar_" + dvar_name);
  start_value = getdvarfloat(dvar);
  cur_value = start_value;
  cur_time = 0;

  while(cur_time < time) {
    cur_time += level.framedurationseconds;
    pct = min(1, cur_time / time);

    if(isDefined(ease_param3)) {
      cur_value = [[level.ease_funcs[ease_type]]](start_value, value, pct, ease_in, ease_out, ease_param1, ease_param2, ease_param3);
    } else if(isDefined(ease_param2)) {
      cur_value = [[level.ease_funcs[ease_type]]](start_value, value, pct, ease_in, ease_out, ease_param1, ease_param2);
    } else if(isDefined(ease_param1)) {
      cur_value = [[level.ease_funcs[ease_type]]](start_value, value, pct, ease_in, ease_out, ease_param1);
    } else {
      cur_value = [[level.ease_funcs[ease_type]]](start_value, value, pct, ease_in, ease_out);
    }

    builtin[[dvar_func]](dvar, cur_value);
    waitframe();
  }

  builtin[[dvar_func]](dvar, value);
}