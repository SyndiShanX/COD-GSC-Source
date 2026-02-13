/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1760.gsc
*************************************************/

_id_5056(var_0, var_1) {
  var_2 = 15;
  var_3 = 45;

  if(isDefined(self._id_0359)) {
    var_2 = self._id_0359;
  }

  if(isDefined(self.height)) {
    var_3 = self.height;
  }

  if(!isDefined(var_1)) {
    var_1 = 18;
  }

  var_4 = var_0 + (0, 0, var_1);
  var_5 = var_0 + (0, 0, var_1 * -1);
  var_6 = self _meth_8008(var_4, var_5, self._id_0359, self.height, 1);

  if(abs(var_6[2] - var_4[2]) < 0.1) {
    return undefined;
  }

  if(abs(var_6[2] - var_5[2]) < 0.1) {
    return undefined;
  }

  return var_6;
}

_id_3199(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = 6;
  }

  if(!isDefined(var_3)) {
    var_3 = scripts\engine\utility::ter_op(isDefined(self._id_0359), self._id_0359, 15);
  }

  if(!isDefined(var_4)) {
    var_4 = scripts\engine\utility::ter_op(isDefined(self.height), self.height, 40);
  }

  var_5 = (0, 0, 1) * var_2;
  var_6 = var_0 + var_5;
  var_7 = var_1 + var_5;
  return self _meth_8009(var_6, var_7, var_3, var_4 - var_2, 1);
}

_id_68E7(var_0) {
  var_1 = var_0.origin - self.origin;
  var_1 = vectornormalize(var_1);
  var_2 = self._id_1DF5;

  if(!isDefined(var_2)) {
    var_2 = 40;
  }

  var_3 = var_0.origin - var_1 * var_2;
  var_3 = _id_5056(var_3);

  if(!isDefined(var_3)) {
    return var_0.origin;
  }

  if(!_id_3199(var_0.origin, var_3)) {
    var_4 = anglesToForward(var_0.angles);
    var_3 = var_0.origin + var_4 * var_2;

    if(!_id_3199(var_0.origin, var_3)) {
      return var_0.origin;
    }
  }

  return var_3;
}

_id_31A9(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = self _meth_847B(var_0, var_1);

  if(!isDefined(var_3)) {
    var_2._id_31A8 = 0;
    return var_2;
  }

  var_4 = var_3[var_3.size - 1];
  var_5 = distancesquared(var_4, var_1);
  var_2 = spawnStruct();
  var_2._id_31A8 = var_5 < 900;
  var_2._id_AEC7 = var_3;
  return var_2;
}