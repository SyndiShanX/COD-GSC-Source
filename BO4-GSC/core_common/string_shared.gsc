/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\string_shared.gsc
***********************************************/

#namespace string;

rjust(str_input, n_length, str_fill) {
  if(!isDefined(str_fill)) {
    str_fill = "<dev string:x38>";
  }

  str_input = isDefined(str_input) ? "<dev string:x3c>" + str_input : "<dev string:x3c>";
  n_fill_length = n_length - str_input.size;
  str_fill = fill(n_fill_length, str_fill);
  return str_fill + str_input;
}

ljust(str_input, n_length, str_fill) {
  if(!isDefined(str_fill)) {
    str_fill = "<dev string:x38>";
  }

  str_input = isDefined(str_input) ? "<dev string:x3c>" + str_input : "<dev string:x3c>";
  n_fill_length = n_length - str_input.size;
  str_fill = fill(n_fill_length, str_fill);
  return str_input + str_fill;
}

fill(n_length, str_fill) {
  if(!isDefined(str_fill) || str_fill == "<dev string:x3c>") {
    str_fill = "<dev string:x38>";
  }

  str_return = "<dev string:x3c>";

  while(n_length > 0) {
    str = getsubstr(str_fill, 0, n_length);
    n_length -= str.size;
    str_return += str;
  }

  return str_return;
}

