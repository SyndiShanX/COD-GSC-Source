/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\dog\_dog_idle.gsc
****************************************************/

main() {
  self._id_0EEA = "none";
  _id_8745();
  self._id_99FF = self._id_99FF + 2000;
  self._id_173F = 0;
  self scragentsetgoalpos(self.origin);
  self scragentsetorientmode("face angle abs", self.angles);
  self scragentsetanimmode("anim deltas");
  self scragentsetphysicsmode("gravity");
  _id_A16C();
}

_id_0085() {
  if(isDefined(self._id_76EA)) {
    self scragentsetmaxturnspeed(self._id_76EA);
    self._id_76EA = undefined;
  }
}

_id_A16C() {
  self endon("killanimscript");
  self endon("cancelidleloop");

  for(;;) {
    var_0 = self._id_0EEA;
    var_1 = _id_2E61();

    if(var_1 != self._id_0EEA) {
      _id_37BF(var_1);
    }

    _id_A0DE();

    switch (self._id_0EEA) {
      case "idle_combat":
        wait 0.2;
        break;
      case "idle_noncombat":
        if(var_0 == "none") {} else if(gettime() > self._id_99FF) {
          _id_8745();
        }

        wait 0.5;
        break;
      default:
        wait 1;
        break;
    }
  }
}

_id_2E61() {
  if(_id_8B86()) {
    return "idle_combat";
  } else {
    return "idle_noncombat";
  }
}

_id_37BF(var_0) {
  _id_38F6(self._id_0EEA);
  self._id_0EEA = var_0;
  _id_74A8();
}

_id_38F6(var_0) {
  if(isDefined(self._id_76EA)) {
    self scragentsetmaxturnspeed(self._id_76EA);
    self._id_76EA = undefined;
  }
}

_id_74A8() {
  if(self._id_0EEA == "idle_combat") {
    self setanimstate("attack_idle");
  } else {
    self setanimstate("casual_idle");
  }
}

_id_A0DE() {
  var_0 = undefined;

  if(isDefined(self._id_0088) && distancesquared(self._id_0088.origin, self.origin) < 1048576) {
    var_0 = self._id_0088;
  } else if(isDefined(self._id_0117) && distancesquared(self._id_0117.origin, self.origin) > 576) {
    var_0 = self._id_0117;
  }

  if(isDefined(var_0)) {
    var_1 = var_0.origin - self.origin;
    var_2 = vectortoangles(var_1);

    if(_abs(_angleclamp180(var_2[1] - self.angles[1])) > 1) {
      _id_9ED9(var_2[1]);
    }
  }
}

_id_8B86() {
  return isDefined(self._id_0088) && maps\mp\_utility::isreallyalive(self._id_0088) && distancesquared(self.origin, self._id_0088.origin) < 1000000;
}

_id_46F0(var_0) {
  if(_id_8B86()) {
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

_id_9ED9(var_0) {
  var_1 = self.angles[1];
  var_2 = _angleclamp180(var_0 - var_1);

  if(-0.5 < var_2 && var_2 < 0.5) {
    return;
  }
  if(-10 < var_2 && var_2 < 10) {
    _id_7EEF(var_0, 2);
    return;
  }

  var_3 = _id_46F0(var_2);
  var_4 = self getanimentry(var_3, 0);
  var_5 = _getanimlength(var_4);
  var_6 = _getangledelta3d(var_4);
  self scragentsetanimmode("anim angle delta");

  if(_animhasnotetrack(var_4, "turn_begin") && _animhasnotetrack(var_4, "turn_end")) {
    maps\mp\agents\_scriptedagents::_id_71FC(var_3, 0, "turn_in_place");
    var_7 = _getnotetracktimes(var_4, "turn_begin");
    var_8 = _getnotetracktimes(var_4, "turn_end");
    var_9 = (var_8[0] - var_7[0]) * var_5;
    var_10 = _angleclamp180(var_2 - var_6[1]);
    var_11 = _abs(var_10) / var_9 / 20;
    var_11 = var_11 * 3.14159 / 180;
    var_12 = (0, _angleclamp180(self.angles[1] + var_10), 0);
    self._id_76EA = self scragentgetmaxturnspeed();
    self scragentsetmaxturnspeed(var_11);
    self scragentsetorientmode("face angle abs", var_12);
    maps\mp\agents\_scriptedagents::_id_A79E("turn_in_place", "turn_end");
    self scragentsetmaxturnspeed(self._id_76EA);
    self._id_76EA = undefined;
    maps\mp\agents\_scriptedagents::_id_A79E("turn_in_place", "end");
  } else {
    self._id_76EA = self scragentgetmaxturnspeed();
    var_11 = _abs(_angleclamp180(var_2 - var_6[1])) / var_5 / 20;
    var_11 = var_11 * 3.14159 / 180;
    self scragentsetmaxturnspeed(var_11);
    var_12 = (0, _angleclamp180(var_0 - var_6[1]), 0);
    self scragentsetorientmode("face angle abs", var_12);
    maps\mp\agents\_scriptedagents::_id_71FC(var_3, 0, "turn_in_place");
    self scragentsetmaxturnspeed(self._id_76EA);
    self._id_76EA = undefined;
  }

  self scragentsetanimmode("anim deltas");
  _id_74A8();
}

_id_7EEF(var_0, var_1) {
  if(_abs(_angleclamp180(var_0 - self.angles[1])) <= var_1) {
    return;
  }
  var_2 = (0, var_0, 0);
  self scragentsetorientmode("face angle abs", var_2);

  while(_angleclamp180(var_0 - self.angles[1]) > var_1) {
    wait 0.1;
  }
}

_id_8745() {
  self._id_99FF = gettime() + 8000 + randomint(5000);
}

_id_31FC(var_0) {
  self._id_17E8 = 1;
  self._id_018F = 1;
  self._id_173F = 1;
  var_1 = _angleclamp180(var_0 - self.angles[1]);

  if(var_1 > 0) {
    var_2 = 1;
  } else {
    var_2 = 0;
  }

  self notify("cancelidleloop");
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  maps\mp\agents\_scriptedagents::_id_71FC("stand_pain", var_2, "stand_pain");
  self._id_17E8 = 0;
  self._id_018F = 0;
  self._id_173F = 0;
  self scragentsetorientmode("face angle abs", self.angles);
  self._id_0EEA = "none";
  thread _id_A16C();
}

_id_6ADB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(self._id_173F) {
    return;
  }
  var_10 = vectortoangles(var_7);
  var_11 = var_10[1] - 180;
  _id_31FC(var_11);
}

_id_6B3B(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(self._id_173F) {
    return;
  }
  _id_31FC(self.angles[1] + 180);
}