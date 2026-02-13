/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2495.gsc
*************************************************/

_id_10A2(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_2) {
    if(!isDefined(self._id_10D9)) {
      self._id_10D9 = [];
    }

    self._id_10D9[var_0] = var_1;

    if(isDefined(var_3)) {
      if(!isDefined(self._id_10D8)) {
        self._id_10D8 = [];
      }

      self._id_10D8[var_0] = var_3;
    }
  } else {
    if(!isDefined(self._id_A2FB)) {
      self._id_A2FB = [];
    }

    self._id_A2FB[var_0] = var_1;

    if(isDefined(var_3)) {
      if(!isDefined(self._id_A2FA)) {
        self._id_A2FA = [];
      }

      self._id_A2FA[var_0] = var_3;
    }
  }
}

_id_C48A(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(var_1) {
    if(!isDefined(self._id_10D9)) {
      return;
    }
    self._id_10D9[var_0] = undefined;

    if(!isDefined(self._id_10D8)) {
      return;
    }
    self._id_10D8[var_0] = undefined;
  } else {
    if(!isDefined(self._id_A2FB)) {
      return;
    }
    self._id_A2FB[var_0] = undefined;

    if(!isDefined(self._id_A2FA)) {
      return;
    }
    self._id_A2FA[var_0] = undefined;
  }
}

_id_69C1(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 1.0;

  if(isDefined(self._id_10D9)) {
    foreach(var_11, var_9 in self._id_10D9) {
      var_10 = 0;

      if(isDefined(self._id_10D8) && isDefined(self._id_10D8[var_11])) {
        var_10 = [[self._id_10D8[var_11]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
      }

      if(!var_10) {
        var_7 = var_7 + (var_9 - 1.0);
      }
    }
  }

  var_12 = 1.0;

  if(isDefined(self._id_A2FB)) {
    foreach(var_11, var_9 in self._id_A2FB) {
      var_10 = 0;

      if(isDefined(self._id_A2FA) && isDefined(self._id_A2FA[var_11])) {
        var_10 = [[self._id_A2FA[var_11]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
      }

      if(!var_10) {
        var_12 = var_12 * var_9;
      }
    }
  }

  return var_7 * var_12;
}

_id_3935() {
  self._id_10D9 = [];
  self._id_A2FB = [];
  self._id_10D8 = [];
  self._id_A2FA = [];
}

_id_ADCA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = spawnStruct();
  var_13.attacker = var_0;
  var_13._id_103C2 = var_1;
  var_13.damage = var_2;
  var_13.objweapon = var_3;
  var_13._id_9CD6 = var_4;
  var_13.inflictor = var_5;
  var_13.point = var_6;
  var_13._id_49CA = var_7;
  var_13.modelname = var_8;
  var_13._id_031A = var_9;
  var_13._id_047C = var_10;
  var_13._id_7C97 = var_11;
  var_13._id_4304 = var_11;
  var_13._id_56B8 = var_12;

  if(isDefined(var_13.attacker)) {
    var_13.attacker._id_1D2B = 0;
  }

  return var_13;
}

_id_8A6A(var_0, var_1) {
  if(istrue(self._id_5ECC)) {
    return 1;
  }

  if(isDefined(self._id_EA8D)) {
    if(isDefined(var_0.inflictor) && var_0.inflictor == self._id_EA8D) {
      if(istrue(var_1)) {
        return 1;
      } else if(_func_010F(var_0._id_9CD6) || var_0._id_9CD6 == "MOD_FIRE") {
        return 1;
      }
    }
  }

  return 0;
}

_id_8A6B(var_0) {
  if(istrue(self._id_A5DF)) {
    return 0;
  }

  if(!_id_8A6A(var_0, 0)) {
    return 0;
  }

  switch (var_0.objweapon.basename) {
    case "s4_molotov_mp":
    case "thermite_ap_mp":
    case "s4_thermite_mp":
    case "thermite_av_mp":
      return 0;
    default:
      break;
  }

  return 1;
}

_id_5ECC() {
  self._id_5ECC = 1;
}

_id_5ECD() {
  self._id_5ECC = undefined;
}