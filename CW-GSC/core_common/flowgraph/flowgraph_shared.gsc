/******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\flowgraph\flowgraph_shared.gsc
******************************************************/

#using scripts\core_common\flowgraph\flowgraph_core;
#namespace flowgraph_logic;

function iffunc(x, b) {
  return array(b, !b);
}

function orfunc(x, b_a, b_b) {
  return array(b_a || b_b, !(b_a || b_b));
}

function andfunc(x, b_a, b_b) {
  return array(b_a && b_b, !(b_a && b_b));
}

function notfunc(b_value) {
  return !b_value;
}

function lessthan(var_a, var_b) {
  return var_a < var_b;
}

function function_b457969e(var_a, var_b) {
  return var_a <= var_b;
}

function greaterthan(var_a, var_b) {
  return var_a > var_b;
}

function function_3743e19e(var_a, var_b) {
  return var_a >= var_b;
}

function equal(var_a, var_b) {
  return var_a == var_b;
}

function function_5cb6d7c8(x, b_1, b_2) {
  if(is_true(b_1)) {
    self flowgraph::kick(array(undefined, 1, 0), 1);
    return;
  }

  if(is_true(b_2)) {
    self flowgraph::kick(array(undefined, 0, 1), 1);
  }
}

function function_4902305f(x, b_1, b_2, b_3) {
  if(is_true(b_1)) {
    self flowgraph::kick(array(undefined, 1, 0, 0), 1);
    return;
  }

  if(is_true(b_2)) {
    self flowgraph::kick(array(undefined, 0, 1, 0), 1);
    return;
  }

  if(is_true(b_3)) {
    self flowgraph::kick(array(undefined, 0, 0, 1), 1);
  }
}

function function_3b225c4(x, b_1, b_2, b_3, b_4) {
  if(is_true(b_1)) {
    self flowgraph::kick(array(undefined, 1, 0, 0, 0), 1);
    return;
  }

  if(is_true(b_2)) {
    self flowgraph::kick(array(undefined, 0, 1, 0, 0), 1);
    return;
  }

  if(is_true(b_3)) {
    self flowgraph::kick(array(undefined, 0, 0, 1, 0), 1);
    return;
  }

  if(is_true(b_4)) {
    self flowgraph::kick(array(undefined, 0, 0, 0, 1), 1);
  }
}

function function_f82f0ebe(x, b_1, b_2, b_3, b_4, b_5) {
  if(is_true(b_1)) {
    self flowgraph::kick(array(undefined, 1, 0, 0, 0, 0), 1);
    return;
  }

  if(is_true(b_2)) {
    self flowgraph::kick(array(undefined, 0, 1, 0, 0, 0), 1);
    return;
  }

  if(is_true(b_3)) {
    self flowgraph::kick(array(undefined, 0, 0, 1, 0, 0), 1);
    return;
  }

  if(is_true(b_4)) {
    self flowgraph::kick(array(undefined, 0, 0, 0, 1, 0), 1);
    return;
  }

  if(is_true(b_5)) {
    self flowgraph::kick(array(undefined, 0, 0, 0, 0, 1), 1);
  }
}

function function_3f431ce5(x, b_1, b_2, b_3, b_4, b_5, b_6) {
  if(is_true(b_1)) {
    self flowgraph::kick(array(undefined, 1, 0, 0, 0, 0, 0), 1);
    return;
  }

  if(is_true(b_2)) {
    self flowgraph::kick(array(undefined, 0, 1, 0, 0, 0, 0), 1);
    return;
  }

  if(is_true(b_3)) {
    self flowgraph::kick(array(undefined, 0, 0, 1, 0, 0, 0), 1);
    return;
  }

  if(is_true(b_4)) {
    self flowgraph::kick(array(undefined, 0, 0, 0, 1, 0, 0), 1);
    return;
  }

  if(is_true(b_5)) {
    self flowgraph::kick(array(undefined, 0, 0, 0, 0, 1, 0), 1);
    return;
  }

  if(is_true(b_6)) {
    self flowgraph::kick(array(undefined, 0, 0, 0, 0, 0, 1), 1);
  }
}

function function_2d817962(x, b_1, b_2, b_3, b_4, b_5, b_6, b_7) {
  if(is_true(b_1)) {
    self flowgraph::kick(array(undefined, 1, 0, 0, 0, 0, 0, 0), 1);
    return;
  }

  if(is_true(b_2)) {
    self flowgraph::kick(array(undefined, 0, 1, 0, 0, 0, 0, 0), 1);
    return;
  }

  if(is_true(b_3)) {
    self flowgraph::kick(array(undefined, 0, 0, 1, 0, 0, 0, 0), 1);
    return;
  }

  if(is_true(b_4)) {
    self flowgraph::kick(array(undefined, 0, 0, 0, 1, 0, 0, 0), 1);
    return;
  }

  if(is_true(b_5)) {
    self flowgraph::kick(array(undefined, 0, 0, 0, 0, 1, 0, 0), 1);
    return;
  }

  if(is_true(b_6)) {
    self flowgraph::kick(array(undefined, 0, 0, 0, 0, 0, 1, 0), 1);
    return;
  }

  if(is_true(b_7)) {
    self flowgraph::kick(array(undefined, 0, 0, 0, 0, 0, 0, 1), 1);
  }
}

function function_c8fcb052(x, b_1, b_2, b_3, b_4, b_5, b_6, b_7, b_8) {
  if(is_true(b_1)) {
    self flowgraph::kick(array(undefined, 1, 0, 0, 0, 0, 0, 0, 0), 1);
    return;
  }

  if(is_true(b_2)) {
    self flowgraph::kick(array(undefined, 0, 1, 0, 0, 0, 0, 0, 0), 1);
    return;
  }

  if(is_true(b_3)) {
    self flowgraph::kick(array(undefined, 0, 0, 1, 0, 0, 0, 0, 0), 1);
    return;
  }

  if(is_true(b_4)) {
    self flowgraph::kick(array(undefined, 0, 0, 0, 1, 0, 0, 0, 0), 1);
    return;
  }

  if(is_true(b_5)) {
    self flowgraph::kick(array(undefined, 0, 0, 0, 0, 1, 0, 0, 0), 1);
    return;
  }

  if(is_true(b_6)) {
    self flowgraph::kick(array(undefined, 0, 0, 0, 0, 0, 1, 0, 0), 1);
    return;
  }

  if(is_true(b_7)) {
    self flowgraph::kick(array(undefined, 0, 0, 0, 0, 0, 0, 1, 0), 1);
    return;
  }

  if(is_true(b_8)) {
    self flowgraph::kick(array(undefined, 0, 0, 0, 0, 0, 0, 0, 1), 1);
  }
}

#namespace flowgraph_loops;

function forloop(x, i_begin, i_end) {
  i_step = 1;

  if(i_end < i_begin) {
    i_step = -1;
  }

  i = i_begin;

  while(i != i_end) {
    self flowgraph::kick(array(1, i), 1);
    i += i_step;
  }
}

function foreachloop(x, a_items) {
  foreach(item in a_items) {
    self flowgraph::kick(array(1, item), 1);
  }
}

function whileloop(x, b_condition) {
  while(b_condition) {
    self flowgraph::kick(1, 1);
    inputs = self flowgraph::collect_inputs();
    b_condition = inputs[1];
  }
}

#namespace flowgraph_sequence;

function sequence2(x) {
  self flowgraph::kick(array(1, 0), 1);
  self flowgraph::kick(array(0, 1), 1);
}

function sequence3(x) {
  self flowgraph::kick(array(1, 0, 0), 1);
  self flowgraph::kick(array(0, 1, 0), 1);
  self flowgraph::kick(array(0, 0, 1), 1);
}

function sequence4(x) {
  self flowgraph::kick(array(1, 0, 0, 0), 1);
  self flowgraph::kick(array(0, 1, 0, 0), 1);
  self flowgraph::kick(array(0, 0, 1, 0), 1);
  self flowgraph::kick(array(0, 0, 0, 1), 1);
}

function sequence5(x) {
  self flowgraph::kick(array(1, 0, 0, 0, 0), 1);
  self flowgraph::kick(array(0, 1, 0, 0, 0), 1);
  self flowgraph::kick(array(0, 0, 1, 0, 0), 1);
  self flowgraph::kick(array(0, 0, 0, 1, 0), 1);
  self flowgraph::kick(array(0, 0, 0, 0, 1), 1);
}

function sequence6(x) {
  self flowgraph::kick(array(1, 0, 0, 0, 0, 0), 1);
  self flowgraph::kick(array(0, 1, 0, 0, 0, 0), 1);
  self flowgraph::kick(array(0, 0, 1, 0, 0, 0), 1);
  self flowgraph::kick(array(0, 0, 0, 1, 0, 0), 1);
  self flowgraph::kick(array(0, 0, 0, 0, 1, 0), 1);
  self flowgraph::kick(array(0, 0, 0, 0, 0, 1), 1);
}

function sequence7(x) {
  self flowgraph::kick(array(1, 0, 0, 0, 0, 0, 0), 1);
  self flowgraph::kick(array(0, 1, 0, 0, 0, 0, 0), 1);
  self flowgraph::kick(array(0, 0, 1, 0, 0, 0, 0), 1);
  self flowgraph::kick(array(0, 0, 0, 1, 0, 0, 0), 1);
  self flowgraph::kick(array(0, 0, 0, 0, 1, 0, 0), 1);
  self flowgraph::kick(array(0, 0, 0, 0, 0, 1, 0), 1);
  self flowgraph::kick(array(0, 0, 0, 0, 0, 0, 1), 1);
}

function sequence8(x) {
  self flowgraph::kick(array(1, 0, 0, 0, 0, 0, 0, 0), 1);
  self flowgraph::kick(array(0, 1, 0, 0, 0, 0, 0, 0), 1);
  self flowgraph::kick(array(0, 0, 1, 0, 0, 0, 0, 0), 1);
  self flowgraph::kick(array(0, 0, 0, 1, 0, 0, 0, 0), 1);
  self flowgraph::kick(array(0, 0, 0, 0, 1, 0, 0, 0), 1);
  self flowgraph::kick(array(0, 0, 0, 0, 0, 1, 0, 0), 1);
  self flowgraph::kick(array(0, 0, 0, 0, 0, 0, 1, 0), 1);
  self flowgraph::kick(array(0, 0, 0, 0, 0, 0, 0, 1), 1);
}

#namespace flowgraph_util;

function onflowgraphrun() {
  self.owner waittill(#"flowgraph_run");
  return true;
}

function waitfunc(x, f_seconds) {
  wait f_seconds;
  return true;
}

function createthread(x) {
  return true;
}

#namespace flowgraph_random;

function randomfloatinrangefunc(f_min, f_max) {
  return randomfloatrange(f_min, f_max);
}

function randomunitvector() {
  return vectornormalize((randomfloat(1), randomfloat(1), randomfloat(1)));
}

#namespace flowgraph_math;

function multiply(var_1, var_2) {
  return var_2 * var_2;
}

function divide(var_1, var_2) {
  return var_1 / var_2;
}

function add(var_1, var_2) {
  return var_1 + var_2;
}

function subtract(var_1, var_2) {
  return var_1 - var_2;
}

function negate(v) {
  return v * -1;
}

function vectordotfunc(v_1, v_2) {
  return vectordot(v_1, v_2);
}

#namespace flowgraph_level;

function function_35dc468d(str_field) {
  return level.(str_field);
}

function function_f9d5c4b0(x, str_field, var_value) {
  level.(str_field) = var_value;
  return true;
}

#namespace namespace_22752a75;

function function_8892c7a6(i_value) {
  return i_value;
}

function function_28c4ae67(f_value) {
  return f_value;
}

function function_36bf9c6c(b_value) {
  return b_value;
}

function function_fe4cf085(str_value) {
  return str_value;
}

function function_3ece9d7e(h_value) {
  return h_value;
}

function function_68a5d644(ea_value) {
  return ea_value;
}

function vectorconstant(v_value) {
  return v_value;
}

function pathnodeconstant(var_f4af12cc) {
  return var_f4af12cc;
}

function function_9ef80b8b(e_value) {
  return e_value;
}

function introduction_minigun(ai_value) {
  return ai_value;
}

function function_513da14e(var_162b6305) {
  return var_162b6305;
}

function function_7cbb60c3(sp_value) {
  return sp_value;
}

function function_f2357a4d(w_value) {
  return w_value;
}

function function_79f7d941(var_value) {
  return var_value;
}

function function_fdafe394(var_e477c3b) {
  return var_e477c3b;
}

function function_28848a6a(mdl_value) {
  return mdl_value;
}

function function_8f5a9b3e(fx_value) {
  return fx_value;
}

function function_a5f771ce(var_e0bddaf5) {
  return var_e0bddaf5;
}

function function_527fa489(var_5ab747e5) {
  return var_5ab747e5;
}