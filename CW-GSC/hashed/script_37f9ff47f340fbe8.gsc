/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_37f9ff47f340fbe8.gsc
***********************************************/

#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace easing;

function private autoexec __init__system__() {
  system::register(#"easing", &ease_init, undefined, undefined, undefined);
}

function ease_init() {
  level.ease_funcs = [];
  level.ease_funcs[#"linear"] = &ease_linear;
  level.ease_funcs[#"power"] = &ease_power;
  level.ease_funcs[#"quadratic"] = &function_db98dad1;
  level.ease_funcs[#"cubic"] = &ease_cubic;
  level.ease_funcs[#"hash_7fcb2d60a826eca8"] = &function_79315b1d;
  level.ease_funcs[#"hash_2080bcb1cad7945c"] = &function_858ecd2d;
  level.ease_funcs[#"exponential"] = &function_95a842a;
  level.ease_funcs[#"logarithmic"] = &function_eec2a804;
  level.ease_funcs[#"sine"] = &ease_sine;
  level.ease_funcs[#"back"] = &ease_back;
  level.ease_funcs[#"elastic"] = &function_d912ff48;
  level.ease_funcs[#"bounce"] = &ease_bounce;
}

function ease_linear(start, end, pct, ease_in, ease_out) {
  return (1 - ease_out) * pct + ease_out * ease_in;
}

function ease_power(start, end, pct, ease_in, ease_out, power) {
  pct = easepower(pct, power, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function function_db98dad1(start, end, pct, ease_in, ease_out) {
  pct = easepower(pct, 2, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function ease_cubic(start, end, pct, ease_in, ease_out) {
  pct = easepower(pct, 3, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function function_79315b1d(start, end, pct, ease_in, ease_out) {
  pct = easepower(pct, 4, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function function_858ecd2d(start, end, pct, ease_in, ease_out) {
  pct = easepower(pct, 5, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function function_95a842a(start, end, pct, ease_in, ease_out, scale) {
  pct = easeexponential(pct, scale, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function function_eec2a804(start, end, pct, ease_in, ease_out, log_base) {
  pct = easelogarithmic(pct, log_base, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function ease_sine(start, end, pct, ease_in, ease_out) {
  pct = easesine(pct, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function ease_back(start, end, pct, ease_in, ease_out, var_2d741986, power) {
  pct = easeback(pct, var_2d741986, power, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function function_d912ff48(start, end, pct, ease_in, ease_out, amplitude, frequency, fade_scalar) {
  pct = easeelastic(pct, amplitude, frequency, fade_scalar, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function ease_bounce(start, end, pct, ease_in, ease_out, bounces, decay_scalar) {
  pct = easebounce(pct, bounces, decay_scalar, ease_in, ease_out);
  return (1 - pct) * start + pct * end;
}

function function_8ff186e5(var_b3160f0, dvar, var_c7ec7d60) {
  if(is_true(var_c7ec7d60)) {
    setsaveddvar(dvar, var_b3160f0.cur_value);
    return;
  }

  setDvar(dvar, var_b3160f0.cur_value);
}

function function_54354e4e(var_b3160f0, axis) {
  switch (axis) {
    case 0:
      self.origin = (var_b3160f0.cur_value, self.origin[1], self.origin[2]);
      break;
    case 1:
      self.origin = (self.origin[0], var_b3160f0.cur_value, self.origin[2]);
      break;
    case 2:
      self.origin = (self.origin[0], self.origin[1], var_b3160f0.cur_value);
      break;
    default:
      self.origin = var_b3160f0.cur_value;
      break;
  }
}

function function_92b063ff(var_b3160f0, axis) {
  switch (axis) {
    case 0:
      self.origin += (var_b3160f0.delta, 0, 0);
      break;
    case 1:
      self.origin += (0, var_b3160f0.delta, 0);
      break;
    case 2:
      self.origin += (0, 0, var_b3160f0.delta);
      break;
    default:
      self.origin += var_b3160f0.delta;
      break;
  }
}

function function_3b3f9801(var_b3160f0, axis) {
  var_cad5b24d = float(function_60d95f53()) / 1000;
  angles = var_b3160f0.cur_value;

  switch (axis) {
    case 0:
      angles = (angles, 0, 0);
      break;
    case 1:
      angles = (0, angles, 0);
      break;
    case 2:
      angles = (0, 0, angles);
      break;
  }

  self rotateto(var_b3160f0.cur_value, var_cad5b24d);
}

function function_faea843b(var_b3160f0, axis) {
  switch (axis) {
    case 0:
      self.angles += (var_b3160f0.delta, 0, 0);
      break;
    case 1:
      self.angles += (0, var_b3160f0.delta, 0);
      break;
    case 2:
      self.angles += (0, 0, var_b3160f0.delta);
      break;
    default:
      self.angles += var_b3160f0.delta;
      break;
  }

  if(var_b3160f0.var_37e98bce) {
    self.angles = (angleclamp180(self.angles[0]), angleclamp180(self.angles[1]), angleclamp180(self.angles[2]));
  }
}