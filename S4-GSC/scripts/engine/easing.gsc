/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\engine\easing.gsc
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
  var_2 = _func_03C6(var_2, var_5, var_3, var_4);
  return (1.0 - var_2) * var_0 + var_2 * var_1;
}

ease_quadratic(var_0, var_1, var_2, var_3, var_4) {
  var_2 = _func_03C6(var_2, 2, var_3, var_4);
  return (1.0 - var_2) * var_0 + var_2 * var_1;
}

ease_cubic(var_0, var_1, var_2, var_3, var_4) {
  var_2 = _func_03C6(var_2, 3, var_3, var_4);
  return (1.0 - var_2) * var_0 + var_2 * var_1;
}

ease_quartic(var_0, var_1, var_2, var_3, var_4) {
  var_2 = _func_03C6(var_2, 4, var_3, var_4);
  return (1.0 - var_2) * var_0 + var_2 * var_1;
}

ease_quintic(var_0, var_1, var_2, var_3, var_4) {
  var_2 = _func_03C6(var_2, 5, var_3, var_4);
  return (1.0 - var_2) * var_0 + var_2 * var_1;
}

ease_exponential(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_2 = _func_03C7(var_2, var_5, var_3, var_4);
  return (1.0 - var_2) * var_0 + var_2 * var_1;
}

ease_logarithmic(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_2 = _func_03C8(var_2, var_5, var_3, var_4);
  return (1.0 - var_2) * var_0 + var_2 * var_1;
}

ease_sine(var_0, var_1, var_2, var_3, var_4) {
  var_2 = _func_03C9(var_2, var_3, var_4);
  return (1.0 - var_2) * var_0 + var_2 * var_1;
}

ease_back(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_2 = _func_03CA(var_2, var_5, var_6, var_3, var_4);
  return (1.0 - var_2) * var_0 + var_2 * var_1;
}

ease_elastic(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_2 = _func_03CB(var_2, var_5, var_6, var_7, var_3, var_4);
  return (1.0 - var_2) * var_0 + var_2 * var_1;
}

ease_bounce(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_2 = _func_03CC(var_2, var_5, var_6, var_3, var_4);
  return (1.0 - var_2) * var_0 + var_2 * var_1;
}

ease_dvar(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread ease_callback(getdvarfloat(var_0), var_2, var_3, ::_set_dvar, var_4, "ease_dvar_" + var_0, "ease_dvar_" + var_0, var_5, var_6, var_7, var_0, var_1);
}

ease_origin(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = undefined;
  var_9 = ::_set_origin;
  var_10 = self.origin;

  if(istrue(var_4)) {
    var_9 = ::_add_origin;
  } else {
    var_8 = ["ease_origin", "ease_origin_x", "ease_origin_y", "ease_origin_z"];
  }

  if(isDefined(var_3)) {
    var_10 = var_10[var_3];
  } else {
    var_3 = -1;
  }

  thread ease_callback(var_10, var_0, var_1, var_9, var_2, "ease_origin", var_8, var_5, var_6, var_7, var_3);
}

ease_angles(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = undefined;
  var_9 = (0, 0, 0);
  var_10 = ["ease_angles"];
  var_8 = [];
  var_4 = istrue(var_4);

  if(!var_4) {
    var_8[var_8.size] = "ease_angles";
  }

  if(isDefined(var_3)) {
    var_9 = var_9[var_3];

    if(isvector(var_0)) {
      var_0 = var_0[var_3];
    }

    if(!var_4) {
      var_0 = _func_000B(var_0 - self.angles[var_3]);
    }

    var_11 = undefined;

    switch (var_3) {
      case 0:
        var_11 = "ease_pitch";
        break;
      case 1:
        var_11 = "ease_yaw";
        break;
      case 2:
        var_11 = "ease_roll";
        break;
    }

    var_10[var_10.size] = var_11;

    if(!var_4) {
      var_8[var_8.size] = var_11;
    }
  } else {
    var_3 = -1;

    if(!var_4) {
      var_0 = _func_000B(var_0 - self.angles);
    }
  }

  thread ease_callback(var_9, var_0, var_1, ::_add_angles, var_2, var_10, var_8, var_5, var_6, var_7, var_3);
}

ease_angles_to_face_ent(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = undefined;
  var_10 = (0, 0, 0);
  var_11 = ["ease_angles"];
  var_9 = [];
  var_9[var_9.size] = "ease_angles";

  if(isDefined(var_5)) {
    var_10 = var_10[var_5];
    var_12 = undefined;

    switch (var_5) {
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
    var_9[var_9.size] = var_12;
  } else
    var_5 = -1;

  var_13 = spawnStruct();
  var_13._id_E630 = var_0;
  var_13._id_E5A7 = self.angles;
  var_13._id_0427 = var_2;
  thread ease_callback_dynamic_target(var_10, var_1, ::_get_angles_to_ent, var_3, ::_add_angles, var_4, var_11, var_9, var_6, var_7, var_8, var_5, var_13);
}

ease_callback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(var_4)) {
    var_4 = "linear";
  }

  if(!_func_0107(var_5)) {
    if(isDefined(var_5)) {
      var_5 = [var_5];
    } else {
      var_5 = [];
    }
  }

  foreach(var_13 in var_5) {
    self notify(var_13);
  }

  if(isDefined(var_6)) {
    if(_func_0107(var_6)) {
      foreach(var_16 in var_6) {
        self endon(var_16);
      }
    } else
      self endon(var_6);
  }

  if(!_func_0107(var_9)) {
    if(isDefined(var_9)) {
      var_9 = [var_9];
    } else {
      var_9 = [];
    }
  }

  if(isDefined(var_7)) {
    var_7 = int(var_7);
  }

  if(isDefined(var_8)) {
    var_8 = int(var_8);
  }

  var_18 = spawnStruct();
  var_18.start_value = var_0;
  var_18.target_value = var_1;
  var_18.cur_value = var_0;
  var_18.ease_finished = 0;
  var_19 = var_18.cur_value;

  for(var_20 = 0.0; var_20 < var_2; var_20 = var_20 + level._id_5F3A) {
    var_18.pct = min(1.0, var_20 / var_2);
    var_19 = var_18.cur_value;

    switch (var_9.size) {
      case 3:
        var_18.cur_value = [[level.ease_funcs[var_4]]](var_0, var_1, var_18.pct, var_7, var_8, var_9[0], var_9[1], var_9[2]);
        break;
      case 2:
        var_18.cur_value = [[level.ease_funcs[var_4]]](var_0, var_1, var_18.pct, var_7, var_8, var_9[0], var_9[1]);
        break;
      case 1:
        var_18.cur_value = [[level.ease_funcs[var_4]]](var_0, var_1, var_18.pct, var_7, var_8, var_9[0]);
        break;
      default:
        var_18.cur_value = [[level.ease_funcs[var_4]]](var_0, var_1, var_18.pct, var_7, var_8);
        break;
    }

    var_18.delta = var_18.cur_value - var_19;

    if(isDefined(var_11)) {
      self thread[[var_3]](var_18, var_10, var_11);
    } else if(isDefined(var_10)) {
      self thread[[var_3]](var_18, var_10);
    } else {
      self thread[[var_3]](var_18);
    }

    waitframe();
  }

  var_18.cur_value = var_1;
  var_18.delta = var_18.target_value - var_19;
  var_18.ease_finished = 1;

  if(isDefined(var_11)) {
    self thread[[var_3]](var_18, var_10, var_11);
  } else if(isDefined(var_10)) {
    self thread[[var_3]](var_18, var_10);
  } else {
    self thread[[var_3]](var_18);
  }

  if(isDefined(self)) {
    var_21 = spawnStruct();
    var_21.start_value = var_0;
    var_21.target_value = var_1;
    var_21._id_F1E8 = var_2;
    var_21.callback_func = var_3;
    var_21.ease_type = var_4;
    self notify("ease_done", var_21);
  }
}

ease_callback_dynamic_target(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(!isDefined(var_5)) {
    var_5 = "linear";
  }

  if(!_func_0107(var_6)) {
    if(isDefined(var_6)) {
      var_6 = [var_6];
    } else {
      var_6 = [];
    }
  }

  foreach(var_14 in var_6) {
    self notify(var_14);
  }

  if(isDefined(var_7)) {
    if(_func_0107(var_7)) {
      foreach(var_17 in var_7) {
        self endon(var_17);
      }
    } else
      self endon(var_7);
  }

  if(isDefined(var_1) && isent(var_1)) {
    var_1 endon("death");
  }

  if(!_func_0107(var_10)) {
    if(isDefined(var_10)) {
      var_10 = [var_10];
    } else {
      var_10 = [];
    }
  }

  var_19 = spawnStruct();
  var_19.start_value = var_0;
  var_19.target_value = var_0;
  var_19.cur_value = var_0;
  var_19.ease_finished = 0;
  var_20 = var_19.cur_value;

  for(var_21 = 0.0; var_21 < var_3; var_21 = var_21 + level._id_5F3A) {
    var_19.target_value = self[[var_2]](var_1, var_19, var_11, var_12);
    var_19.pct = min(1.0, var_21 / var_3);
    var_20 = var_19.cur_value;

    switch (var_10.size) {
      case 3:
        var_19.cur_value = [[level.ease_funcs[var_5]]](var_0, var_19.target_value, var_19.pct, var_8, var_9, var_10[0], var_10[1], var_10[2]);
        break;
      case 2:
        var_19.cur_value = [[level.ease_funcs[var_5]]](var_0, var_19.target_value, var_19.pct, var_8, var_9, var_10[0], var_10[1]);
        break;
      case 1:
        var_19.cur_value = [[level.ease_funcs[var_5]]](var_0, var_19.target_value, var_19.pct, var_8, var_9, var_10[0]);
        break;
      default:
        var_19.cur_value = [[level.ease_funcs[var_5]]](var_0, var_19.target_value, var_19.pct, var_8, var_9);
        break;
    }

    var_19.delta = var_19.cur_value - var_20;

    if(isDefined(var_12)) {
      self thread[[var_4]](var_19, var_11, var_12);
    } else if(isDefined(var_11)) {
      self thread[[var_4]](var_19, var_11);
    } else {
      self thread[[var_4]](var_19);
    }

    waitframe();
  }

  var_19.target_value = self[[var_2]](var_1, var_19, var_11, var_12);
  var_19.cur_value = var_19.target_value;
  var_19.delta = var_19.target_value - var_20;
  var_19.ease_finished = 1;

  if(isDefined(var_12)) {
    self thread[[var_4]](var_19, var_11, var_12);
  } else if(isDefined(var_11)) {
    self thread[[var_4]](var_19, var_11);
  } else {
    self thread[[var_4]](var_19);
  }

  if(isDefined(self)) {
    var_22 = spawnStruct();
    var_22.start_value = var_0;
    var_22.target_value = var_19.target_value;
    var_22._id_F1E8 = var_3;
    var_22.callback_func = var_4;
    var_22.ease_type = var_5;
    self notify("ease_done", var_22);
  }
}

_set_dvar(var_0, var_1, var_2) {
  if(istrue(var_2)) {
    setsaveddvar(var_1, var_0.cur_value);
  } else {
    setDvar(var_1, var_0.cur_value);
  }
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
    self.angles = _func_000B(self.angles);
  }
}

_get_angles_to_ent(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::ter_op(isDefined(var_3._id_0427), var_0 gettagorigin(var_3._id_0427), var_0.origin);
  var_5 = _func_000B(vectortoangles(var_4 - var_3._id_E630) - var_3._id_E5A7);

  if(var_2 > -1) {
    var_5 = var_5[var_2];
  }

  return var_5;
}