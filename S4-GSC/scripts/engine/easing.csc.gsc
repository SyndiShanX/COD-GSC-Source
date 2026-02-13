/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\engine\easing\.csc.gsc
*************************************************/

ease_init() {
  level.ease_funcs = [];
  level.ease_funcs["linear"] = ::ease_linear;
  level.ease_funcs["power"] = ::ease_power;
  level.ease_funcs["quadratic"] = ::ease_quadratic;
  level.ease_funcs["cubic"] = ::ease_cubic;
  level.ease_funcs["quartic"] = ::ease_quartic;
  level.ease_funcs["quintic"] = ::ease_quintic;
  level.ease_funcs["exponential"] = ::ease_exponential;
  level.ease_funcs["logarithmic"] = ::ease_logarithmic;
  level.ease_funcs["sine"] = ::ease_sine;
  level.ease_funcs["back"] = ::ease_back;
  level.ease_funcs["elastic"] = ::ease_elastic;
  level.ease_funcs["bounce"] = ::ease_bounce;
}

ease_linear(var_0, var_1, var_2, var_3, var_4) {
  return (1.0 - var_2) * var_0 + var_2 * var_1;
}

ease_power(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_2 = _func_00BA(var_2, var_5, var_3, var_4);
  return (1.0 - var_2) * var_0 + var_2 * var_1;
}

ease_quadratic(var_0, var_1, var_2, var_3, var_4) {
  var_2 = _func_00BA(var_2, 2, var_3, var_4);
  return (1.0 - var_2) * var_0 + var_2 * var_1;
}

ease_cubic(var_0, var_1, var_2, var_3, var_4) {
  var_2 = _func_00BA(var_2, 3, var_3, var_4);
  return (1.0 - var_2) * var_0 + var_2 * var_1;
}

ease_quartic(var_0, var_1, var_2, var_3, var_4) {
  var_2 = _func_00BA(var_2, 4, var_3, var_4);
  return (1.0 - var_2) * var_0 + var_2 * var_1;
}

ease_quintic(var_0, var_1, var_2, var_3, var_4) {
  var_2 = _func_00BA(var_2, 5, var_3, var_4);
  return (1.0 - var_2) * var_0 + var_2 * var_1;
}

ease_exponential(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_2 = _func_00BB(var_2, var_5, var_3, var_4);
  return (1.0 - var_2) * var_0 + var_2 * var_1;
}

ease_logarithmic(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_2 = _func_00BC(var_2, var_5, var_3, var_4);
  return (1.0 - var_2) * var_0 + var_2 * var_1;
}

ease_sine(var_0, var_1, var_2, var_3, var_4) {
  var_2 = _func_00BD(var_2, var_3, var_4);
  return (1.0 - var_2) * var_0 + var_2 * var_1;
}

ease_back(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_2 = _func_00BE(var_2, var_5, var_6, var_3, var_4);
  return (1.0 - var_2) * var_0 + var_2 * var_1;
}

ease_elastic(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_2 = _func_00BF(var_2, var_5, var_6, var_7, var_3, var_4);
  return (1.0 - var_2) * var_0 + var_2 * var_1;
}

ease_bounce(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_2 = _func_00C0(var_2, var_5, var_6, var_3, var_4);
  return (1.0 - var_2) * var_0 + var_2 * var_1;
}

ease_dvar(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread ease_callback(_func_00E3(var_0), var_1, var_2, ::_set_dvar, var_3, var_4, "ease_dvar_" + var_0, "ease_dvar_" + var_0, var_5, var_6, var_7, var_0);
}

ease_origin(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = undefined;
  var_10 = ::_set_origin;
  var_11 = self.origin;

  if(istrue(var_5)) {
    var_10 = ::_add_origin;
  } else {
    var_9 = ["ease_origin", "ease_origin_x", "ease_origin_y", "ease_origin_z"];
  }

  if(isDefined(var_4)) {
    var_11 = var_11[var_4];
  } else {
    var_4 = -1;
  }

  thread ease_callback(var_11, var_0, var_1, var_10, var_2, var_3, "ease_origin", var_9, var_6, var_7, var_8, var_4);
}

ease_angles(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = undefined;
  var_10 = (0, 0, 0);
  var_11 = ["ease_angles"];
  var_9 = [];
  var_5 = istrue(var_5);

  if(!var_5) {
    var_9[var_9.size] = "ease_angles";
  }

  if(isDefined(var_4)) {
    var_10 = var_10[var_4];

    if(_func_0078(var_0)) {
      var_0 = var_0[var_4];
    }

    if(!var_5) {
      var_0 = _func_0004(var_0 - self.angles[var_4]);
    }

    var_12 = undefined;

    switch (var_4) {
      case 0:
        var_12 = "ease_pitch";
        break;
      case 1:
        var_12 = "ease_yaw";
        break;
      case 2:
        var_12 = "ease_roll";
        break;
    }

    var_11[var_11.size] = var_12;

    if(!var_5) {
      var_9[var_9.size] = var_12;
    }
  } else {
    var_4 = -1;

    if(!var_5) {
      var_0 = _func_0004(var_0 - self.angles);
    }
  }

  thread ease_callback(var_10, var_0, var_1, ::_add_angles, var_2, var_3, var_11, var_9, var_6, var_7, var_8, var_4);
}

ease_callback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(!isDefined(var_4)) {
    var_4 = "linear";
  }

  if(!_func_002E(var_6)) {
    if(isDefined(var_6)) {
      var_6 = [var_6];
    } else {
      var_6 = [];
    }
  }

  var_13 = var_6;

  for(var_15 = _func_0022(var_13); isDefined(var_15); var_15 = _func_0024(var_13, var_15)) {
    var_14 = var_13[var_15];
    self notify(var_14);
  }

  __asm_var_clear(2)
  __asm_var_clear(0)

  if(isDefined(var_7)) {
    if(_func_002E(var_7)) {
      var_16 = var_7;

      for(var_18 = _func_0022(var_16); isDefined(var_18); var_18 = _func_0024(var_16, var_18)) {
        var_17 = var_16[var_18];
        self endon(var_17);
      }

      __asm_var_clear(2)
      __asm_var_clear(0)
    } else
      self endon(var_7);
  }

  if(!_func_002E(var_10)) {
    if(isDefined(var_10)) {
      var_10 = [var_10];
    } else {
      var_10 = [];
    }
  }

  if(isDefined(var_8)) {
    var_8 = _func_002C(var_8);
  }

  if(isDefined(var_9)) {
    var_9 = _func_002C(var_9);
  }

  var_19 = _func_008C();
  var_19.start_value = var_0;
  var_19.target_value = var_1;
  var_19.cur_value = var_0;
  var_19.ease_finished = 0;
  var_20 = var_19.cur_value;

  for(var_21 = 0.0; var_21 < var_2; var_21 = var_21 + _func_0107(var_5)) {
    var_19.pct = _func_003C(1.0, var_21 / var_2);
    var_20 = var_19.cur_value;

    switch (var_10.size) {
      case 3:
        var_19.cur_value = [[level.ease_funcs[var_4]]](var_0, var_1, var_19.pct, var_8, var_9, var_10[0], var_10[1], var_10[2]);
        break;
      case 2:
        var_19.cur_value = [[level.ease_funcs[var_4]]](var_0, var_1, var_19.pct, var_8, var_9, var_10[0], var_10[1]);
        break;
      case 1:
        var_19.cur_value = [[level.ease_funcs[var_4]]](var_0, var_1, var_19.pct, var_8, var_9, var_10[0]);
        break;
      default:
        var_19.cur_value = [[level.ease_funcs[var_4]]](var_0, var_1, var_19.pct, var_8, var_9);
        break;
    }

    var_19.delta = var_19.cur_value - var_20;

    if(isDefined(var_12)) {
      self thread[[var_3]](var_19, var_11, var_12);
    } else if(isDefined(var_11)) {
      self thread[[var_3]](var_19, var_11);
    } else {
      self thread[[var_3]](var_19);
    }

    var_22 = _func_00A6();

    while(var_22 == _func_00A6()) {
      waitframe();
    }
  }

  var_19.cur_value = var_1;
  var_19.delta = var_19.target_value - var_20;
  var_19.ease_finished = 1;

  if(isDefined(var_12)) {
    self thread[[var_3]](var_19, var_11, var_12);
  } else if(isDefined(var_11)) {
    self thread[[var_3]](var_19, var_11);
  } else {
    self thread[[var_3]](var_19);
  }

  if(isDefined(self)) {
    var_23 = _func_008C();
    var_23.start_value = var_0;
    var_23.target_value = var_1;
    var_23._id_F1E8 = var_2;
    var_23.callback_func = var_3;
    var_23.ease_type = var_4;
    self notify("ease_done", var_23);
  }
}

ease_callback_dynamic_target(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(!isDefined(var_5)) {
    var_5 = "linear";
  }

  if(!_func_002E(var_7)) {
    if(isDefined(var_7)) {
      var_7 = [var_7];
    } else {
      var_7 = [];
    }
  }

  var_14 = var_7;

  for(var_16 = _func_0022(var_14); isDefined(var_16); var_16 = _func_0024(var_14, var_16)) {
    var_15 = var_14[var_16];
    self notify(var_15);
  }

  __asm_var_clear(2)
  __asm_var_clear(0)

  if(isDefined(var_8)) {
    if(_func_002E(var_8)) {
      var_17 = var_8;

      for(var_19 = _func_0022(var_17); isDefined(var_19); var_19 = _func_0024(var_17, var_19)) {
        var_18 = var_17[var_19];
        self endon(var_18);
      }

      __asm_var_clear(2)
      __asm_var_clear(0)
    } else
      self endon(var_8);
  }

  if(isDefined(var_1) && _func_0079(var_1)) {
    var_1 endon("death");
  }

  if(!_func_002E(var_11)) {
    if(isDefined(var_11)) {
      var_11 = [var_11];
    } else {
      var_11 = [];
    }
  }

  var_20 = _func_008C();
  var_20.start_value = var_0;
  var_20.target_value = var_0;
  var_20.cur_value = var_0;
  var_20.ease_finished = 0;
  var_21 = var_20.cur_value;

  for(var_22 = 0.0; var_22 < var_3; var_22 = var_22 + _func_0107(var_6)) {
    var_20.target_value = self[[var_2]](var_1, var_20, var_12, var_13);
    var_20.pct = _func_003C(1.0, var_22 / var_3);
    var_21 = var_20.cur_value;

    switch (var_11.size) {
      case 3:
        var_20.cur_value = [[level.ease_funcs[var_5]]](var_0, var_20.target_value, var_20.pct, var_9, var_10, var_11[0], var_11[1], var_11[2]);
        break;
      case 2:
        var_20.cur_value = [[level.ease_funcs[var_5]]](var_0, var_20.target_value, var_20.pct, var_9, var_10, var_11[0], var_11[1]);
        break;
      case 1:
        var_20.cur_value = [[level.ease_funcs[var_5]]](var_0, var_20.target_value, var_20.pct, var_9, var_10, var_11[0]);
        break;
      default:
        var_20.cur_value = [[level.ease_funcs[var_5]]](var_0, var_20.target_value, var_20.pct, var_9, var_10);
        break;
    }

    var_20.delta = var_20.cur_value - var_21;

    if(isDefined(var_13)) {
      self thread[[var_4]](var_20, var_12, var_13);
    } else if(isDefined(var_12)) {
      self thread[[var_4]](var_20, var_12);
    } else {
      self thread[[var_4]](var_20);
    }

    waitframe();
  }

  var_20.target_value = self[[var_2]](var_1, var_20, var_12, var_13);
  var_20.cur_value = var_20.target_value;
  var_20.delta = var_20.target_value - var_21;
  var_20.ease_finished = 1;

  if(isDefined(var_13)) {
    self thread[[var_4]](var_20, var_12, var_13);
  } else if(isDefined(var_12)) {
    self thread[[var_4]](var_20, var_12);
  } else {
    self thread[[var_4]](var_20);
  }

  if(isDefined(self)) {
    var_23 = _func_008C();
    var_23.start_value = var_0;
    var_23.target_value = var_20.target_value;
    var_23._id_F1E8 = var_3;
    var_23.callback_func = var_4;
    var_23.ease_type = var_5;
    self notify("ease_done", var_23);
  }
}

_set_dvar(var_0, var_1) {
  _func_00DF(var_1, var_0.cur_value);
}

_set_origin(var_0, var_1, var_2) {
  switch (var_1) {
    case 0:
      self.origin = (var_0.cur_value, self.origin[1], self.origin[2]);
      break;
    case 1:
      self.origin = (self.origin[0], var_0.cur_value, self.origin[2]);
      break;
    case 2:
      self.origin = (self.origin[0], self.origin[1], var_0.cur_value);
      break;
    default:
      self.origin = var_0.cur_value;
      break;
  }
}

_add_origin(var_0, var_1, var_2) {
  switch (var_1) {
    case 0:
      self.origin = self.origin + (var_0.delta, 0, 0);
      break;
    case 1:
      self.origin = self.origin + (0, var_0.delta, 0);
      break;
    case 2:
      self.origin = self.origin + (0, 0, var_0.delta);
      break;
    default:
      self.origin = self.origin + var_0.delta;
      break;
  }
}

_add_angles(var_0, var_1, var_2) {
  switch (var_1) {
    case 0:
      self.angles = self.angles + (var_0.delta, 0, 0);
      break;
    case 1:
      self.angles = self.angles + (0, var_0.delta, 0);
      break;
    case 2:
      self.angles = self.angles + (0, 0, var_0.delta);
      break;
    default:
      self.angles = self.angles + var_0.delta;
      break;
  }

  if(var_0.ease_finished) {
    self.angles = _func_0004(self.angles);
  }
}