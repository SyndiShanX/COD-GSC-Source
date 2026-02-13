/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1962.gsc
*************************************************/

init() {
  _id_06C6::_id_812F();

  if(!isDefined(level._id_CC49)) {
    level._id_CC49 = [];
  }

  if(!isDefined(level._id_CC3B)) {
    level._id_CC3B = [];
  }

  anim._id_2F52["PlaySoundAtViewHeight"] = ::_id_B2D8;
  anim._id_2F52["TeleportEnt"] = ::_id_F023;
  anim._id_2F52["ShouldDoAnim"] = ::_id_DA85;
  anim._id_2F52["DoAnimation"] = ::_id_4BDE;
  anim._id_2F52["DoFacialAnim"] = ::_id_4BF7;
  anim._id_2F52["AnimHandleNotetrack"] = ::_id_A28C;
  anim._id_2F52["EntityHandleNotetrack"] = ::_id_A298;
  anim._id_2F52["EntityHandleNotetrackAnimEnd"] = ::entity_handle_anim_end;
  anim._id_2F52["EntityHandleAnimScriptedEnd"] = ::entity_handle_animscripted_end;
  anim._id_2F52["AIAnimFirstFrame"] = undefined;
}

_id_B2D8(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!_func_0205(var_0)) {
    return;
  }
  self playSound(var_0);
}

_id_DA85() {
  return 1;
}

_id_F023(var_0, var_1) {
  if(self._id_00EC == "script_vehicle") {
    self _meth_8439(var_0, var_1);
    self dontinterpolate();
  } else if(isPlayer(self)) {
    self setorigin(var_0);
    self setplayerangles(var_1);
  } else {
    self.origin = var_0;
    self.angles = var_1;
    self dontinterpolate();
  }
}

_id_4BF7(var_0, var_1, var_2, var_3, var_4, var_5) {
  return 0;
}

_id_4BDE(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;

  if(isDefined(var_5)) {
    var_6 = level._id_CC31[var_2][var_3][var_5];
  } else {
    var_6 = level._id_CC31[var_2][var_3];
  }

  var_7 = _id_06C6::_id_17D5(var_2, var_3);
  _id_06C6::_id_8F09();

  if(!isDefined(var_5)) {
    self._id_0C46 = var_3;
  }

  if(self._id_00EC == "script_vehicle") {
    self _meth_8620(var_6);
  }

  var_8 = undefined;

  if(isDefined(self._id_17D6)) {
    var_8 = [[self._id_17D6]]();
  }

  self _meth_801B(var_4, var_0, var_1, var_6, undefined, var_8, var_7);
  thread _id_06DC::_id_E617(self, var_4, var_3, var_2, var_6);
  return _func_0079(var_6);
}

_id_A28C(var_0, var_1, var_2, var_3) {
  _id_06DC::_id_17DB(var_0, var_1, var_2, var_3);

  if(isDefined(var_0["flag"])) {
    _id_07D1::_id_60C1(var_0["flag"]);
  }

  if(isDefined(var_0["flag_clear"])) {
    _id_07D1::_id_60BF(var_0["flag_clear"]);
  }

  if(isDefined(var_0["sound"])) {
    var_4 = undefined;

    if(!isDefined(var_0["sound_stays_death"])) {
      var_4 = 1;
    }

    var_5 = undefined;

    if(isDefined(var_0["sound_on_tag"])) {
      var_5 = var_0["sound_on_tag"];
    }

    var_1 thread _id_0AA2::_id_B2DE(var_0["sound"], var_5);
  }
}

_id_A298(var_0, var_1) {
  if(var_0 _id_A2A3(var_1)) {
    return;
  }
}

entity_handle_anim_end(var_0, var_1) {}

entity_handle_animscripted_end(var_0) {}

_id_A2A3(var_0) {
  var_1 = _func_00D6(var_0, 0, 3);

  if(var_1 == "as_") {
    var_2 = _func_00D6(var_0, 3);

    if(isDefined(self._id_17FE)) {
      self thread[[self._id_17FE]](var_2);
    }

    return 1;
  }

  if(var_1 == "vm_") {
    var_3 = _func_00D6(var_0, 3);

    if(isDefined(self._id_17FF)) {
      self thread[[self._id_17FF]](var_3);
    }

    return 1;
  }

  if(var_1 == "ws_") {
    var_4 = _func_00D6(var_0, 3);

    if(isDefined(self._id_10D19)) {
      self thread[[self._id_10D19]](var_4);
    }

    return 1;
  }

  if(var_1 == "cm_") {
    var_5 = _func_00D6(var_0, 3);

    if(isDefined(self._id_3717)) {
      self thread[[self._id_3717]](var_5);
    }

    return 1;
  }

  if(var_1 == "df_") {
    var_6 = _func_00D6(var_0, 3);

    if(isDefined(self._id_4C9C)) {
      self thread[[self._id_4C9C]](var_6);
    }

    return 1;
  }

  return 0;
}

_id_17FD(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  var_6[0] = var_0;
  var_7[0] = var_1;

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  _id_17FB(var_6, var_7, var_2, var_3, var_4, var_5);
}

_id_17FB(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  _id_17FC(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_17FC(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0;

  foreach(var_8 in var_0) {
    var_9 = undefined;

    if(isDefined(var_5)) {
      var_9 = var_5;
    } else {
      var_9 = var_8._id_18AF;
    }

    if(isDefined(level._id_CC3B[var_9]) && isDefined(level._id_CC3B[var_9][var_2])) {
      var_6 = var_8 _meth_84FF("scripted_scene", level._id_CC3B[var_9][var_2]);
    }

    if(isDefined(level._id_CC49[var_9]) && isDefined(level._id_CC49[var_9][var_2]) && !istrue(var_8._id_25A7)) {
      var_8 _meth_861F(level._id_CC49[var_9][var_2]);
    }
  }

  if(isDefined(var_1)) {
    _id_06C6::_id_183B(var_1, var_2, var_3, var_4, var_5);
  }
}