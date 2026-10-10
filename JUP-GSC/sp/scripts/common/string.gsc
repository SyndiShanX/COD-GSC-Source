/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\common\string.gsc
***********************************************/

#namespace string;

function to_string(var) {
  if(isDefined(var)) {
    return ("" + var);
  }

  return "";
}

function function_46b9c00bb0535aa3(str) {
  return !isDefined(str) || str == "";
}

function rjust(str_input, n_length, str_fill) {
  if(!isDefined(str_fill)) {
    str_fill = "<dev string:x1c>";
  }

  str_input = to_string(str_input);
  n_fill_length = n_length - str_input.size;
  str_fill = fill(n_fill_length, str_fill);
  return str_fill + str_input;
}

function ljust(str_input, n_length, str_fill) {
  if(!isDefined(str_fill)) {
    str_fill = "<dev string:x1c>";
  }

  str_input = to_string(str_input);
  n_fill_length = n_length - str_input.size;
  str_fill = fill(n_fill_length, str_fill);
  return str_input + str_fill;
}

function fill(n_length, str_fill) {
  if(!isDefined(str_fill) || str_fill == "<dev string:x1e>") {
    str_fill = "<dev string:x1c>";
  }

  str_return = "<dev string:x1e>";

  while(n_length > 0) {
    str = getsubstr(str_fill, 0, n_length);
    n_length -= str.size;
    str_return += str;
  }

  return str_return;
}

# /