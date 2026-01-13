/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 2559.gsc
*********************************************/

func_006E(var_0, var_1, var_2, var_3) {
  var_4 = level.invalid;
  var_5 = undefined;
  var_6 = level.var_119E[var_0];
  var_7 = var_6.var_1581[var_1];
  var_4 = [[var_7]](var_2);
  if(!isDefined(var_4)) {
    var_4 = 3;
  }

  return var_4;
}

bt_nativesetregistrar(var_0) {
  _func_2BA(var_0);
}

bt_nativeregistertree(var_0, var_1, var_2, var_3) {
  _func_2B8(var_0, var_1, var_2, var_3);
}

bt_nativeistreeregistered(var_0) {
  return _func_2BC(var_0);
}

bt_nativeregisterbehavior(var_0, var_1, var_2, var_3, var_4) {
  _func_2B9(var_0, var_1, var_2, var_3, var_4);
}

bt_nativeregisterbehaviortotree(var_0, var_1, var_2, var_3, var_4) {
  _func_2B9(var_0, var_1, var_2, var_3, var_4);
}

bt_nativefinalizeregistrar() {
  _func_2BB();
}

bt_nativetick() {
  self _meth_84B3();
}

bt_nativeregisteraction(var_0, var_1, var_2, var_3, var_4, var_5) {
  _func_2BD(var_0, var_1, var_2, var_3, var_4, var_5);
}

bt_nativeexecaction(var_0, var_1, var_2, var_3) {
  var_4 = level.invalid;
  var_5 = gettime();
  if(isDefined(var_3)) {
    var_6 = [[var_3]]();
    var_4 = [[var_1]](var_2, var_6);
  } else {
    var_4 = [[var_1]](var_2);
  }

  if(!isDefined(var_4)) {
    return 3;
  }

  if(var_4 == level.failure) {
    return 0;
  }

  if(var_4 == level.success) {
    return 1;
  }

  if(var_4 == level.running) {
    return 2;
  }

  return 3;
}

bt_nativecopyaction(var_0) {}

bt_nativecopybehavior(var_0) {}