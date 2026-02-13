/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2310.gsc
*************************************************/

_id_3630(var_0, var_1, var_2, var_3) {
  var_4 = getdamagetaken();

  if(!isDefined(self._id_0150)) {
    self._id_0150 = 0;
  }

  var_5 = "left";

  if(self._id_0150 > 135 || self._id_0150 <= -135) {
    var_5 = "forward";
  } else if(self._id_0150 > 45 && self._id_0150 <= 135) {
    var_5 = "right";
  } else if(self._id_0150 > -45 && self._id_0150 <= 45) {
    var_5 = "backward";
  }

  if(var_4 != "light") {
    var_5 = var_5 + ("_" + var_4);
  }

  var_6 = _id_0009::_id_1C7D(var_1, var_5);
  return var_6;
}

_id_B383(var_0, var_1, var_2) {
  if(self _meth_85EC()) {
    self _meth_82C2("gravity");
    self _meth_82B9("anim deltas");
  } else {
    self _meth_8019("gravity");
    self _meth_8019("angle deltas");
  }

  _id_08F1::_id_B31C(var_0, var_1);
}

_id_3606(var_0, var_1, var_2) {
  return _id_3630(var_0, var_1, var_2, 1);
}

choosecrawlingdeathanim(var_0, var_1, var_2) {
  return _id_3630(var_0, var_1, var_2, 0);
}

getdamagetaken() {
  var_0 = "light";

  if(isDefined(self.damagemod) && _func_010F(self.damagemod)) {
    var_0 = "explosive";
  } else {
    var_1 = self._id_014E;
    var_2 = self.maxhealth;
    var_3 = var_1 / 100.0;

    if(var_3 > 0.7) {
      var_0 = "heavy";
    }
  }

  if(isalive(self)) {
    self._id_8FB6 = gettime();
  }

  return var_0;
}