/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2563.gsc
**************************************/

_id_13DC1(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self._id_290A = var_0;

  if(!var_0) {
    self _meth_8484();
    self clearpath();
  }
}

_id_F728(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = anim._id_13DC2;
  }

  _id_1154(var_0, var_1, anim._id_13DC3, var_2, 1);
}

_id_F727(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = anim._id_13DC3;
  }

  _id_1154(var_0, var_1, var_2, anim._id_13DC2, 0);
}

_id_7EDC() {
  return anim._id_13DBF;
}

_id_1154(var_0, var_1, var_2, var_3, var_4) {
  var_0 = clamp(var_0, 0, 1);
  var_1 = max(var_1, 0.05);
  anim._id_13DBF = var_0;

  if(!isDefined(var_2) || var_2 < 0) {
    var_2 = 0;
  }

  if(!isDefined(var_3) || var_3 > 1) {
    var_3 = 1;
  }

  anim._id_13DC3 = var_2;
  anim._id_13DC2 = var_3;

  if(var_4) {
    anim._id_13DC0 = (1 - var_0) / var_1 / 20;
  } else {
    anim._id_13DC0 = -1 * var_0 / var_1 / 20;
  }

  anim thread _id_114E();
}

_id_114E() {
  self notify("killC6PowerUpdate");
  self endon("killC6PowerUpdate");

  for(;;) {
    anim._id_13DBF = anim._id_13DBF + anim._id_13DC0;
    anim._id_13DBF = clamp(anim._id_13DBF, anim._id_13DC3, anim._id_13DC2);
    wait 0.05;
  }
}