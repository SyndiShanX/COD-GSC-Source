/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2559.gsc
************************/

func_006E(param_00, param_01, param_02, param_03) {
  var_04 = level.invalid;
  var_05 = undefined;
  var_06 = level.var_119E[param_00];
  var_07 = var_06.var_1581[param_01];
  var_04 = [[var_07]](param_02);
  if(!isDefined(var_04)) {
    var_04 = 3;
  }

  return var_04;
}

bt_nativesetregistrar(param_00) {
  _func_2BA(param_00);
}

bt_nativeregistertree(param_00, param_01, param_02, param_03) {
  _func_2B8(param_00, param_01, param_02, param_03);
}

bt_nativeistreeregistered(param_00) {
  return _func_2BC(param_00);
}

bt_nativeregisterbehavior(param_00, param_01, param_02, param_03, param_04) {
  _func_2B9(param_00, param_01, param_02, param_03, param_04);
}

bt_nativeregisterbehaviortotree(param_00, param_01, param_02, param_03, param_04) {
  _func_2B9(param_00, param_01, param_02, param_03, param_04);
}

bt_nativefinalizeregistrar() {
  _func_2BB();
}

bt_nativetick() {
  self _meth_84B3();
}

bt_nativeregisteraction(param_00, param_01, param_02, param_03, param_04, param_05) {
  _func_2BD(param_00, param_01, param_02, param_03, param_04, param_05);
}

bt_nativeexecaction(param_00, param_01, param_02, param_03) {
  var_04 = level.invalid;
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

  if(var_04 == level.failure) {
    return 0;
  }

  if(var_04 == level.success) {
    return 1;
  }

  if(var_04 == level.running) {
    return 2;
  }

  return 3;
}

bt_nativecopyaction(param_00) {}

bt_nativecopybehavior(param_00) {}