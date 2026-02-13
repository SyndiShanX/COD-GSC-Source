/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2290.gsc
*************************************************/

_id_828B(var_0, var_1, var_2) {
  self._id_0B67._id_DA37 = _id_0009::_id_1C5F(self._id_1CB8);
  self._id_0B67._id_D9FF = 0;
  self._id_0B67._id_D9F7 = undefined;

  if(weaponclass(self._id_04F6) == "rocketlauncher" && !isDefined(self._id_011F)) {
    self._id_0B67._id_03BF = 0;
  }
}

_id_DB09(var_0, var_1, var_2, var_3) {
  if(!_id_06BD::_id_23B9()) {
    return 0;
  }

  var_4 = istrue(self._id_0B67._id_03BF) || _id_0009::_id_1C50(var_0, "burst_delay_finished");
  return var_4;
}

_id_7419(var_0, var_1) {
  self endon(var_1 + "_finished");

  if(_id_06E3::_id_FEF9() || _id_0009::_id_1C82()) {
    var_2 = self _meth_8182();

    if(!isDefined(var_2)) {
      var_2 = _id_06BD::_id_23C8();
    }

    var_3 = var_2 _meth_8810("yaw");
    var_4 = var_2 _meth_8810("pitch");

    if(var_4 > var_3) {
      var_3 = var_4;
    }

    var_3 = var_3 * 0.75;
    wait(var_3);
  } else if(!istrue(self._id_7D15)) {
    var_5 = self._id_04F6.classname;

    if(isDefined(self._id_10D1F) && isDefined(self._id_10D1F[var_5])) {
      var_6 = self._id_10D1F[var_5]._id_9F48;
      var_7 = self._id_10D1F[var_5]._id_9CBE;

      if(var_6 > var_7) {}

      var_3 = randomfloatrange(var_6, var_7);
      wait(var_3);
    }
  }

  self._id_0B67._id_03BF = 1;
}

_id_7425(var_0, var_1) {
  self endon(var_1 + "_finished");

  if(!istrue(self._id_7D1A)) {
    _id_2DAC();
  } else {}

  _id_0009::_id_1C53(var_0, "burst_delay_finished");
}

_id_3622(var_0, var_1, var_2) {
  var_3 = self _meth_8644();
  var_4 = "shoot_idle";

  if(!isalive(self._id_0192) || var_3 <= 120 || istrue(self._id_FDA8)) {
    if(_id_0009::_id_1C72(var_1, "cqb_shoot_idle")) {
      var_4 = "cqb_shoot_idle";
    }
  }

  return _id_0009::_id_1C7D(var_1, var_4);
}

_id_DA11(var_0, var_1, var_2) {
  if(!self._id_0B67._id_D9FF) {
    thread _id_7419(var_0, var_1);
  } else {
    thread _id_7425(var_0, var_1);
  }

  if(scripts\anim\utility_common::_id_8766()) {
    return;
  }
  if(_id_06BD::_id_23E5()) {
    return;
  }
  self._id_2C4F = 1;
  self _meth_86EF(1, 0);
}

_id_DA3B(var_0, var_1, var_2, var_3) {
  return self._id_0B67._id_03CA == 1;
}

_id_4E74(var_0) {
  var_1 = self _meth_8182();
  var_1 _meth_83DB();
  var_1 endon("death");
  var_1 endon("turretstatechange");
  var_2 = _id_06E3::_id_2DAA(var_1, self, var_0);

  while(var_2 > 0) {
    if(isDefined(var_1._id_DA18)) {
      var_1 _meth_83C1(var_1._id_DA18);
    } else {
      var_1 _meth_83C1();
    }

    var_2--;
    self._id_0DDF._id_9041 = gettime();
    wait(var_0);
  }

  var_1 _meth_83EE();
}

_id_4E73(var_0, var_1, var_2) {
  var_3 = self._id_0B67._id_03CA;
  var_4 = _id_0009::_id_1C5C(var_0, var_1);
  var_5 = _id_0009::_id_1C6E(var_1, var_4);
  var_6 = _func_0079(var_5);
  var_6 = var_6 / var_2;
  var_7 = 0.2;
  self _meth_841C();

  while(var_3 > 0) {
    var_3--;
    scripts\anim\utility_common::_id_DA26(0);

    if(!isagent(self)) {
      self _meth_831D(var_1, var_5, 1, var_7, var_6);
    }

    _id_08F1::_id_4555();
    wait(var_2);
  }

  self _meth_83C0();
}

_id_DA3A(var_0, var_1, var_2, var_3) {
  return self._id_0B67._id_03CC == "mg" && (isDefined(self _meth_8182()) || istrue(self._id_8C36));
}

_id_DA08(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self._id_0B67._id_03BF = 0;
  self._id_0B67._id_D9FF = 1;
  self._id_0B67._id_D9F7 = undefined;
  var_3 = _id_DA02();

  if(_id_06E3::_id_FEF9() || _id_0009::_id_1C82()) {
    _id_06E3::set_turret_shoot_params();
  }

  if(isDefined(self _meth_8182())) {
    _id_4E74(var_3);
  } else {
    _id_0900::_id_DA14();
    _id_4E73(var_0, var_1, var_3);
  }

  self._id_0B67._id_03C6--;
  _id_0009::_id_1C52("shoot", "shoot_finished");
  _id_0009::_id_1C53(var_0, "shoot_finished");
}

_id_DA0A(var_0, var_1, var_2) {
  self _meth_83C0();
}

_id_DA16(var_0) {
  var_1 = var_0 + "_shotgun_sound";
  var_2 = var_0 + "kill_shotgun_sound";
  thread _id_DA1A(var_1, var_2, 2);
  self endon(var_1);
  self waittillmatch(var_0, "rechamber");
  self notify(var_2);
}

_id_DA17(var_0) {
  self endon("terminate_ai_threads");
  wait(var_0);
  self _meth_83C0();
}

_id_D9FB(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1 + "_timeout";
  var_6 = var_1 + "_timeout_end";
  childthread _id_DA1A(var_5, var_6, var_3);
  self endon(var_5);
  var_7 = _func_00BB(var_2, "fire");
  var_8 = var_7.size > 0;
  var_9 = weaponclass(self._id_04F6) == "rocketlauncher";

  if(var_8) {
    if(var_7.size == 1 && var_7[0] == 0) {
      var_8 = 0;
    }
  }

  var_10 = 0;
  var_11 = self._id_0B67._id_03CA;
  var_12 = var_11 == 1 || self._id_0B67._id_03CC == "semi";
  var_13 = isPlayer(self._id_0192) && self._id_0192 _meth_854E();
  var_14 = scripts\anim\utility_common::_id_10D12();

  if(self._id_0B67._id_03CC == "rack") {
    var_11 = 1;
  }

  var_15 = var_1;

  if(isDefined(var_4)) {
    var_15 = var_4;
  }

  while(var_10 < var_11 && var_11 > 0) {
    if(var_8) {
      self waittillmatch(var_15, "fire");
    }

    if(!self._id_00CC) {
      break;
    }

    _id_DA22(var_12);

    if(!self._id_016A) {
      var_16 = self._id_04F6.classname;

      if(isDefined(self._id_10D1F[var_16])) {
        if(self._id_10D1F[var_16]._id_5811 > 0) {
          self._id_10D1F[var_16]._id_5811--;
        } else if(self._id_10D1F[var_16]._id_3DEF != 0) {
          self._id_00CC--;
        }
      } else if(var_16 != "beam")
        self._id_00CC--;
    }

    if(var_9) {
      if(self._id_037B > 0) {
        self._id_037B--;
      }

      if(weaponclass(self._id_04F6) == "rocketlauncher" && self tagexists("tag_rocket")) {
        self hidepart("tag_rocket");
      }
    }

    var_10++;

    if(var_14) {
      childthread _id_DA16(var_15);
    }

    if(self._id_0B67._id_03C4 && var_10 == var_11) {
      break;
    }

    if(!var_8 || var_11 == 1 && self._id_0B67._id_03CC == "single" || var_14 && self._id_0B67._id_03CC == "rack") {
      self waittillmatch(var_15, "end");
    }
  }

  self notify(var_6);
}

_id_DA22(var_0) {
  if(isDefined(self._id_0B67._id_03C3) && self._id_0B67._id_03C2) {
    if(isDefined(self._id_0192) && self._id_0B67._id_03C3 == self._id_0192) {
      self[[anim._id_DA27]](var_0);
    }
  } else
    self[[anim._id_DA34]](self._id_0B67._id_03C8, var_0);
}

_id_DA1A(var_0, var_1, var_2) {
  self endon(var_1);
  wait(var_2);
  self notify(var_0);
}

_id_DA02() {
  var_0 = self._id_0B67._id_03CC;
  var_1 = 1.0;

  if(isDefined(self._id_DA35)) {
    var_1 = self._id_DA35;
  } else if(var_0 == "mg") {
    var_1 = _id_06E3::_id_2DA9(self _meth_8182());
  } else if(var_0 == "full") {
    var_1 = scripts\anim\weaponlist::_id_1F7E() * randomfloatrange(0.5, 1.0);
  } else if(var_0 == "burst") {
    var_1 = scripts\anim\weaponlist::_id_2DB3();
  } else if(scripts\anim\utility_common::_id_8AD4()) {
    var_1 = 3.0;
  } else if(scripts\anim\utility_common::_id_8AD3()) {
    var_1 = _id_08F1::_id_DA58();
  } else if(scripts\anim\utility_common::_id_10CF9()) {
    var_1 = _id_08F1::_id_716B();
  }

  return var_1;
}

_id_DA1B(var_0, var_1, var_2) {
  self._id_0B67._id_03C9 = self._id_0B67._id_03CF;

  if(!isDefined(self._id_0B67._id_03C6)) {
    self._id_0B67._id_03C6 = self._id_0B67._id_03C1;
  }

  _id_06C3::_id_3609();
}

_id_2DAC() {
  if(_id_06BD::_id_240E() && self._id_0B67._id_03CC == "full" && !self._id_0B67._id_03C4) {
    if(self._id_0DDF._id_9041 == gettime()) {
      waitframe();
    }

    return;
  }

  var_0 = _id_6CEB();

  if(var_0) {
    wait(var_0);
  }
}

_id_FC1F() {
  var_0 = (gettime() - self._id_0DDF._id_9041) / 1000;
  self._id_0B67._id_D9F7 = _id_6937();

  if(self._id_0B67._id_D9F7 > var_0) {
    self._id_0B67._id_D9F7 = self._id_0B67._id_D9F7 - var_0;
  }
}

_id_6CEB() {
  var_0 = (gettime() - self._id_0DDF._id_9041) / 1000;

  if(!isDefined(self._id_0B67._id_D9F7)) {
    self._id_0B67._id_D9F7 = _id_6937();
  }

  if(self._id_0B67._id_D9F7 > var_0) {
    return self._id_0B67._id_D9F7 - var_0;
  }

  return 0;
}

_id_6938() {
  [var_1, var_2] = _id_06E3::_id_2DA5(self _meth_8182());
  var_3 = var_1 + randomfloat(var_2);
  return var_3;
}

_id_6937() {
  if(_id_06E3::_id_FEF9() || _id_0009::_id_1C82()) {
    return _id_6938();
  }

  if(scripts\anim\utility_common::_id_8AD4()) {
    return randomfloatrange(0.1, 0.45);
  }

  if(scripts\anim\utility_common::_id_10D12()) {
    return randomfloatrange(2.0, 2.7);
  } else if(scripts\anim\utility_common::_id_10CF9()) {
    return _id_08F1::_id_716B();
  } else if(weaponclass(self._id_04F6) == "rocketlauncher") {
    return randomfloatrange(6, 8);
  }

  if(scripts\anim\utility_common::_id_8766()) {
    return _id_08F1::_id_6D38();
  }

  var_0 = self._id_04F6.classname;

  if(isDefined(self._id_10D1F[var_0])) {
    if(istrue(self._id_4E6C)) {
      var_1 = self._id_10D1F[var_0]._id_9F38;
      var_2 = self._id_10D1F[var_0]._id_9C9D;
    } else {
      var_1 = self._id_10D1F[var_0]._id_9EAF;
      var_2 = self._id_10D1F[var_0]._id_9C59;
    }

    if(var_1 > var_2) {}

    return randomfloatrange(var_1, var_2);
  }

  if(_id_06BD::_id_240E()) {
    if(self._id_0B67._id_03C4) {
      if(isDefined(self._id_0B67._id_03C3)) {
        return randomfloatrange(0.1, 0.35);
      } else {
        return randomfloatrange(0.6, 1.0);
      }
    }

    if(isDefined(self._id_0B67._id_03C3)) {
      return randomfloatrange(0.4, 0.9);
    } else {
      return randomfloatrange(0.8, 1.2);
    }
  }

  return randomfloatrange(0.8, 1.2);
}