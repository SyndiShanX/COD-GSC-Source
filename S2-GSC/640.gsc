/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 640.gsc
*********************************************/

lib_0280::func_1CE0(param_00) {
  function_02F1(param_00);
}

lib_0280::func_1CDF(param_00, param_01, param_02, param_03) {
  function_02EF(param_00, param_01, param_02, param_03);
}

lib_0280::func_1CDB(param_00) {
  return function_02F3(param_00);
}

lib_0280::func_1CDD(param_00, param_01, param_02, param_03, param_04) {
  function_02F0(param_00, param_01, param_02, param_03, param_04);
}

lib_0280::func_1CDE(param_00, param_01, param_02, param_03, param_04) {
  function_02F0(param_00, param_01, param_02, param_03, param_04);
}

lib_0280::func_1CDA() {
  function_02F2();
}

lib_0280::func_1CE1() {
  self method_858F();
}

lib_0280::func_1CDC(param_00, param_01, param_02, param_03, param_04, param_05) {
  function_02F4(param_00, param_01, param_02, param_03, param_04, param_05);
}

lib_0280::func_002D(param_00, param_01, param_02, param_03) {
  var_04 = level.var_54F7;
  var_05 = gettime();
  if(isDefined(param_03)) {
    var_06 = [[param_03]]();
    var_04 = [[param_01]](param_02, var_06);
  } else {
    var_04 = [[param_01]](param_02);
  }

  if(!isDefined(var_04)) {
    return 3;
  }

  if(var_04 == level.var_39EB) {
    return 0;
  }

  if(var_04 == level.var_94D4) {
    return 1;
  }

  if(var_04 == level.var_7FB8) {
    return 2;
  }

  return 3;
}

lib_0280::func_1CD8(param_00) {}

lib_0280::func_1CD9(param_00) {}