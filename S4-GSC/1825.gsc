/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1825.gsc
*************************************************/

_id_3F77(var_0, var_1) {
  var_0._id_7C34 = 0;
  var_0._id_7C36 = 69;

  if(istrue(var_1)) {
    var_0 thread _id_C9F9();
  } else {
    var_0 thread _id_C9F8();
  }
}

_id_C9F7(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_1)) {}

  if(istrue(var_3)) {
    if(istrue(var_4)) {}

    if(istrue(var_5)) {}

    if(istrue(var_6)) {}
  } else if(istrue(var_4)) {
    if(istrue(var_3)) {}

    if(istrue(var_5)) {}

    if(istrue(var_6)) {}
  } else if(istrue(var_5)) {
    if(istrue(var_3)) {}

    if(istrue(var_4)) {}

    if(istrue(var_6)) {}
  } else if(istrue(var_6)) {
    if(istrue(var_3)) {}

    if(istrue(var_4)) {}

    if(istrue(var_5)) {}
  }

  var_7 = spawnStruct();
  var_7._id_186E = var_0;
  var_7._id_50E1 = var_1;
  var_7._id_9831 = var_2;
  var_8 = 69;

  if(istrue(var_3)) {
    var_8 = 3;
  } else if(istrue(var_4)) {
    var_8 = 2;
  } else if(istrue(var_5)) {
    var_8 = 1;
  } else if(istrue(var_6)) {
    var_8 = 0;
  }

  self notify("change_state", var_8, var_7);
}

_id_C9F8() {
  for(;;) {
    self waittill("change_state", var_0, var_1);
    var_2 = var_1._id_186E;
    var_3 = var_1._id_50E1;
    var_4 = var_1._id_9831;

    if(self._id_7C34 == var_0 && var_0 != 0) {
      continue;
    }
    self._id_7C36 = self._id_7C34;
    self._id_7C34 = var_0;

    switch (var_0) {
      case 0:
        thread _id_C9A5(var_2);
        break;
      case 1:
        thread _id_C9A5(var_2);
        break;
      case 2:
        thread _id_C9A5(var_2);
        break;
      case 3:
        _id_C9A5(var_2);
        break;
    }
  }
}

_id_C9F9() {
  for(;;) {
    self waittill("change_state", var_0, var_1);
    var_2 = var_1._id_186E;
    var_3 = var_1._id_50E1;
    var_4 = var_1._id_9831;

    if(self._id_7C34 == var_0 && var_0 != 0) {
      continue;
    }
    self._id_7C36 = self._id_7C34;
    self._id_7C34 = var_0;

    switch (var_0) {
      case 0:
        thread _id_C9A6(var_2);
        break;
      case 1:
        thread _id_C9A6(var_2);
        break;
      case 2:
        thread _id_C9A6(var_2);
        break;
      case 3:
        _id_C9A6(var_2);
        break;
    }
  }
}

_id_C9A6(var_0, var_1, var_2) {
  if(isDefined(var_1)) {}

  if(var_0 == "") {
    return;
  }
  if(!istrue(var_2)) {
    return;
  }
  return;
}

_id_C9A5(var_0, var_1, var_2) {
  if(isDefined(var_1)) {}

  if(var_0 == "") {
    return;
  }
  if(!istrue(var_2)) {
    if(isDefined(var_1)) {
      _id_0AED::_id_18C9(var_0, var_1);
    } else {
      _id_0AED::_id_18C7(var_0);
    }
  } else {
    self endon("change_state");

    if(isDefined(var_1)) {
      _id_0AED::_id_18C3(var_0, var_1);
    } else {
      _id_0AED::_id_18C2(var_0);
    }
  }
}

_id_3903() {
  self._id_0043 = 1;
  _id_0AED::_id_18C1();
  self unlink();

  if(isDefined(self._id_CF39)) {
    self[[self._id_CF39]]();
  }

  if(isDefined(self._id_1772)) {
    self._id_1772 delete();
  }
}

_id_2B86() {
  self notify("break_out_of_disguise_loop");
  self endon("break_out_of_disguise_loop");
  self endon("delete_disguise_threads_on_player");
  self notifyonplayercommand("ads", "+speed_throw");
  self notifyonplayercommand("fire", "+attack");
  self notifyonplayercommand("lethal", "+frag");
  self notifyonplayercommand("tactical", "+smoke");
  self._id_5B67 = [];
  _id_0FA8("ads");
  _id_0FA8("fire");
  _id_0FA8("lethal");
  _id_0FA8("tactical");

  for(;;) {
    var_0 = scripts\engine\utility::_id_10899("ads", "fire", "lethal", "tactical");

    if(scripts\engine\utility::array_contains(level._id_F014[0]._id_A924, self)) {
      continue;
    }
    _id_3AE0(var_0);
  }
}

_id_0FA8(var_0) {
  self._id_5B67[var_0] = 0;
}

_id_3AE0(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("commands_registered_recently");
  self endon("commands_registered_recently");
  self._id_5B67[var_0]++;

  if(self._id_5B67["fire"] > 4 || self._id_5B67["ads"] > 4 || self._id_5B67["lethal"] > 4 || self._id_5B67["tactical"] > 4) {}

  thread _id_C173(3.5, var_0);
}

_id_C173(var_0, var_1) {
  self endon("disconnect");
  self endon("delete_disguise_threads_on_player");
  wait(var_0);
  self._id_5B67[var_1]--;

  if(self._id_5B67[var_1] <= 0) {
    self._id_5B67[var_1] = 0;

    if(self._id_5B67["fire"] <= 0) {
      _id_D1C5("relaxed");
    }
  }
}

_id_D1C9() {
  _id_D1C5("normal");
}

_id_D1C7(var_0) {
  self notify("set_demeanor_for_duration");
  self endon("set_demeanor_for_duration");
  self endon("delete_disguise_threads_on_player");
  _id_D1C5("normal");
  wait(var_0);
  _id_D1C5("relaxed");
}

_id_D1C5(var_0) {
  switch (var_0) {
    case "normal":
      _id_549A();
      break;
    case "safe":
      _id_549C();
      break;
    case "relaxed":
      _id_549B();
      break;
  }
}

_id_549C() {
  thread _id_D1C6("safe", "iw8_ges_demeanor_safe");
  thread _id_47A5(::_id_5741);
}

_id_5741() {}

_id_549B() {
  thread _id_D1C6("relaxed", "iw8_ges_demeanor_relaxed");
  thread _id_47A5(::_id_5740);
}

_id_5740() {}

_id_47A5(var_0) {
  self waittill("entering_new_demeanor");
  self[[var_0]]();
}

_id_D1C6(var_0, var_1) {
  self endon("entering_new_demeanor");
  self endon("death");
  var_2 = 0;

  for(;;) {
    if(isDefined(var_1)) {
      var_2 = self _meth_84AC(var_0, var_1);
    } else {
      var_2 = self _meth_84AC(var_0);
    }

    if(var_2) {
      break;
    }

    wait 0.05;
  }
}

_id_549A() {
  thread _id_D1C6("normal");
  thread _id_47A5(::_id_573F);
}

_id_573F() {}

_id_49FF(var_0) {
  var_0 scripts\common\utility::_id_151F(0);
  var_0 scripts\common\utility::_id_153E(0);
}

_id_51F6(var_0) {
  var_0 scripts\common\utility::_id_151F(1);
  var_0 scripts\common\utility::_id_153E(1);
}