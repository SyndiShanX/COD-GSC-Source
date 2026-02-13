/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1753.gsc
*************************************************/

allow_input_internal(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  if(!isDefined(self._id_15D1)) {
    self._id_15D1 = [];
  }

  if(var_1) {
    if(var_4) {} else {
      if(!isDefined(self._id_15D1[var_0])) {
        self._id_15D1[var_0] = 0;
      }

      if(istrue(var_3)) {
        return 1;
      }

      self._id_15D1[var_0]--;

      if(!self._id_15D1[var_0]) {
        self._id_15D1[var_0] = undefined;
        return 1;
      }
    }
  } else if(var_4) {} else {
    if(!isDefined(self._id_15D1[var_0])) {
      self._id_15D1[var_0] = 0;
    }

    if(istrue(var_3)) {
      return 0;
    }

    self._id_15D1[var_0]++;

    if(self._id_15D1[var_0] == 1) {
      return 0;
    }
  }

  return undefined;
}

_id_860C(var_0) {
  if(!isDefined(self._id_15D1)) {
    self._id_15D1 = [];
  }

  if(!isDefined(self._id_15D1) || !isDefined(self._id_15D1[var_0]) || !self._id_15D1[var_0]) {
    return 1;
  } else {
    return 0;
  }
}

_id_38B0(var_0) {
  if(isDefined(self._id_15D1) && isDefined(self._id_15D1[var_0])) {
    self._id_15D1[var_0] = undefined;
  }
}

_id_38AB() {
  self notify("clear_all_allow_info");

  if(isDefined(self._id_15D1)) {
    foreach(var_1 in self._id_15D1) {
      var_1 = undefined;
    }

    self._id_15D1 = undefined;
  }
}