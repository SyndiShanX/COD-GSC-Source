/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\640.gsc
**************************************/

_id_1CE0(var_0) {
  _func_2F1(var_0);
}

_id_1CDF(var_0, var_1, var_2, var_3) {
  _func_2EF(var_0, var_1, var_2, var_3);
}

_id_1CDB(var_0) {
  return _func_2F3(var_0);
}

_id_1CDD(var_0, var_1, var_2, var_3, var_4) {
  _func_2F0(var_0, var_1, var_2, var_3, var_4);
}

_id_1CDE(var_0, var_1, var_2, var_3, var_4) {
  _func_2F0(var_0, var_1, var_2, var_3, var_4);
}

_id_1CDA() {
  _func_2F2();
}

_id_1CE1() {
  self _meth_858F();
}

_id_1CDC(var_0, var_1, var_2, var_3, var_4, var_5) {
  _func_2F4(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_002D(var_0, var_1, var_2, var_3) {
  var_4 = anim._id_54F7;
  var_5 = gettime();

  if(isDefined(var_3)) {
    var_6 = [[var_3]]();
    var_4 = [[var_1]](var_2, var_6);
  } else
    var_4 = [[var_1]](var_2);

  if(!isDefined(var_4)) {
    return 3;
  }

  if(var_4 == anim._id_39EB) {
    return 0;
  } else if(var_4 == anim._id_94D4) {
    return 1;
  } else if(var_4 == anim._id_7FB8) {
    return 2;
  } else {
    return 3;
  }
}

_id_1CD8(var_0) {}

_id_1CD9(var_0) {}