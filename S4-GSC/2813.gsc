/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2813.gsc
*************************************************/

main() {
  self._id_18E8 = "none";
  _id_D727();
  self._id_F222 = self._id_F222 + 2000;
  self._id_24FF = 0;
  self _meth_82BE(self.origin);
  self _meth_82C1("face angle abs", self.angles);
  self _meth_82B9("anim deltas");
  self _meth_82C2("gravity");
  _id_FD42();
}

_id_0191() {
  if(isDefined(self._id_BC67)) {
    self _meth_82C0(self._id_BC67);
    self._id_BC67 = undefined;
  }
}

_id_FD42() {
  self endon("killanimscript");
  self endon("cancelidleloop");

  for(;;) {
    var_0 = self._id_18E8;
    var_1 = _id_48B2();

    if(var_1 != self._id_18E8) {
      _id_54E6(var_1);
    }

    _id_FBFF();

    switch (self._id_18E8) {
      case "idle_combat":
        wait 0.2;
        break;
      case "idle_noncombat":
        if(var_0 == "none") {
          if(self._id_02D6 == "run" || self._id_02D6 == "sprint") {
            self _meth_827E(scripts\engine\utility::ter_op(self._id_252B, "anml_wolf_pants_mp_fast", "anml_dog_pants_mp_fast"));
          } else {
            self _meth_827E(scripts\engine\utility::ter_op(self._id_252B, "anml_wolf_pants_mp_med", "anml_dog_pants_mp_med"));
          }
        } else {}

        wait 0.5;
        break;
      default:
        wait 1;
        break;
    }
  }
}

_id_48B2() {
  if(_id_DB00()) {
    return "idle_combat";
  } else {
    return "idle_noncombat";
  }
}

_id_54E6(var_0) {
  _id_5792(self._id_18E8);
  self._id_18E8 = var_0;
  _id_B851();
}

_id_5792(var_0) {
  if(isDefined(self._id_BC67)) {
    self _meth_82C0(self._id_BC67);
    self._id_BC67 = undefined;
  }
}

_id_B851() {
  if(self._id_18E8 == "idle_combat") {
    return;
  }
  self _meth_82E6("casual_idle");
  return;
}

_id_FBFF() {
  var_0 = undefined;

  if(isDefined(self._id_0192) && distancesquared(self._id_0192.origin, self.origin) < 1048576) {
    var_0 = self._id_0192;
  } else if(isDefined(self.owner) && distancesquared(self.owner.origin, self.origin) > 576) {
    var_0 = self.owner;
  }

  if(isDefined(var_0)) {
    var_1 = var_0.origin - self.origin;
    var_2 = vectortoangles(var_1);

    if(abs(_func_000B(var_2[1] - self.angles[1])) > 1) {
      _id_F81E(var_2[1]);
    }
  }
}

_id_DB00() {
  return isDefined(self._id_0192) && scripts\mp\utility\player::isreallyalive(self._id_0192) && distancesquared(self.origin, self._id_0192.origin) < 1000000;
}

_id_6E09(var_0) {
  if(_id_DB00()) {
    if(var_0 < -135 || var_0 > 135) {
      return "attack_turn_180";
    } else if(var_0 < 0) {
      return "attack_turn_right_90";
    } else {
      return "attack_turn_left_90";
    }
  } else if(var_0 < -135 || var_0 > 135)
    return "casual_turn_180";
  else if(var_0 < 0) {
    return "casual_turn_right_90";
  } else {
    return "casual_turn_left_90";
  }
}

_id_F81E(var_0) {}

_id_C926(var_0, var_1) {}

_id_D727() {
  self._id_F222 = gettime() + 8000 + randomint(5000);
}

_id_4CF2(var_0) {
  self._id_2596 = 1;
  self._id_0406 = 1;
  self._id_24FF = 1;
  var_1 = _func_000B(var_0 - self.angles[1]);

  if(var_1 > 0) {
    var_2 = 1;
  } else {
    var_2 = 0;
  }

  self notify("cancelidleloop");
  self._id_2596 = 0;
  self._id_0406 = 0;
  self._id_24FF = 0;
  self._id_18E8 = "none";
  thread _id_FD42();
}

_id_AA9A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(self._id_24FF) && self._id_24FF) {
    return;
  }
  var_10 = vectortoangles(var_7);
  var_11 = var_10[1] - 180;
  _id_4CF2(var_11);
}

_id_AAF0(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(self._id_24FF) {
    return;
  }
  _id_4CF2(self.angles[1] + 180);
}