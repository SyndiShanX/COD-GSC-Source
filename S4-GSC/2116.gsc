/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2116.gsc
*************************************************/

_id_C04D() {}

_id_0BC5(var_0, var_1) {
  return 0;
}

_id_0C03(var_0, var_1, var_2) {
  return undefined;
}

_id_CAA0(var_0) {
  level._id_0B47[var_0] = var_0;
}

_id_0C0E() {
  var_0 = [];
  var_0[0] = "soundtables/" + level.script + ".csv";

  if(isDefined(level._id_89D6) == 1 && level._id_89D6 == 1 && isDefined(level._id_BF5C) == 1) {
    var_0[var_0.size] = "soundtables/mp_raid_defaults.csv";
  }

  if(scripts\common\utility::issp() == 1) {
    var_0[var_0.size] = "soundtables/sp_defaults.csv";
  } else {
    var_0[var_0.size] = "soundtables/mp_defaults.csv";
  }

  if(isDefined(level._id_0B47)) {
    foreach(var_2 in level._id_0B47) {
      var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

_id_0C0D(var_0, var_1) {
  var_2 = _id_0C0E();
  var_3 = [];

  foreach(var_5 in var_2) {
    var_3[var_3.size] = _id_0C03(var_5, var_0, var_1);
  }

  if(var_3.size > 0) {
    return var_3;
  }

  return undefined;
}

_id_EABB(var_0) {
  var_1 = _id_0BC5("mix_name", var_0);
  return var_1;
}

_id_6D9F(var_0) {
  var_1 = ["mix_name", "volmod", "volume", "fade"];
  return _id_0C0D(var_1, var_0);
}

_id_0D5F(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;
  var_5 notify("snd_submix_envelope_" + var_0);
  var_5 endon("death");
  var_5 endon("disconnect");
  var_5 endon("snd_submix_envelope_" + var_0);

  if(isDefined(var_4) == 0) {
    var_4 = 1.0;
  }
}

_id_DF26(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_5) == 0) {
    if(scripts\common\utility::issp() == 1) {
      var_5 = [level.player];
    } else if(isDefined(level.players) == 1) {
      var_5 = level.players;
    }
  }

  foreach(var_7 in var_5) {
    var_7 _id_0D5F(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_66D2(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 2;
  }

  if(!isDefined(level._id_0B46)) {
    level._id_0B46 = [];
  }

  if(!isDefined(level._id_0B46[var_1])) {
    level._id_0B46[var_1] = ::scripts\engine\utility::array_randomize(getarraykeys(var_0));
  }

  if(level._id_0B46[var_1].size <= var_2) {
    var_3 = scripts\engine\utility::array_randomize(scripts\engine\utility::_id_1BBF(getarraykeys(var_0), level._id_0B46[var_1]));
    level._id_0B46[var_1] = ::scripts\engine\utility::array_combine(var_3, level._id_0B46[var_1]);
  }

  var_4 = level._id_0B46[var_1][level._id_0B46[var_1].size - 1];
  level._id_0B46[var_1][level._id_0B46[var_1].size - 1] = undefined;
  return var_0[var_4];
}

_id_CAA3(var_0, var_1) {
  var_2 = self.origin;
  var_3 = self.angles;
  var_4 = "r";
  var_5 = "default";

  if(isDefined(var_0) && var_0) {
    var_4 = "l";
  }

  var_6 = "step_";

  if(isDefined(var_1) && var_1) {
    var_6 = var_6 + "run_";
  } else {
    var_6 = var_6 + "walk_";
  }

  if(isPlayer(self) == 1) {
    var_6 = var_6 + "plr_";
  } else {
    var_7 = "J_Ball_RI";
    var_8 = 180;

    if(var_0) {
      var_7 = "J_Ball_LE";
      var_8 = 0;
    }

    if(self gettagorigin(var_7) != undefined) {
      var_2 = self gettagorigin(var_7);
    }
  }

  var_9 = scripts\engine\trace::_bullet_trace(var_2 + (0, 0, 0), var_2 + (0, 0, -64), 0, undefined);

  if(var_9["fraction"] < 1 && var_9["fraction"] > 0 && var_9["surfacetype"] != "none") {
    var_5 = var_9["surfacetype"];
    var_2 = var_9["position"];
    var_10 = var_6 + var_5;

    if(isPlayer(self) == 1) {
      var_10 = var_10 + ("_" + var_4);
    }

    if(_func_0205(var_10) == 0) {
      var_5 = "default";
    }
  }

  var_6 = var_6 + var_5;

  if(isPlayer(self) == 1) {
    var_6 = var_6 + ("_" + var_4);
  }

  if(_func_0205(var_6) == 0) {
    return;
  }
  _id_0847::_id_DF08(var_6, var_2);
  return;
}

_id_0D3A(var_0, var_1, var_2, var_3, var_4) {}

_id_0D39(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = getdvarint("#x3de130160b6d36133", 0);
  var_8 = self._id_0C8B._id_F3C8;
  var_9 = self._id_0C8B._id_83C8;
  var_10 = self._id_0C8B._id_AE7A;
  var_11 = self._id_0C8B._id_19FE;
  var_12 = self._id_0C8B._id_4B94;
  var_13 = self._id_0C8B._id_4B91;
  var_14 = self._id_0C8B._id_DE5D;
  var_15 = self._id_0C8B._id_DE5E;
  var_16 = self._id_0C8B._id_EBCC;
  var_17 = self._id_0C8B._id_EBCB;
  var_18 = self._id_0C8B._id_EBCD;
  var_19 = var_9 / var_8;
  var_20 = var_10 / var_8;
  var_21 = int(var_11[0] / 12.0 * 10) / 10.0;
  var_22 = int(var_11[1] / 12.0 * 10) / 10.0;
  var_23 = int(var_11[2] / 12.0 * 10) / 10.0;
  var_24 = int(var_21 * var_22 * 10) / 10.0;
  var_25 = int(var_21 * var_22 * var_23 * 10) / 10.0;
  var_26 = (var_21 * 0.5 + var_22 * 0.5) * 0.5;

  if(var_7 > 3) {
    var_27 = _id_0850::_id_FF25(var_8);
    var_28 = _id_0850::_id_FF26(var_8);
    var_29 = _id_0850::_id_FF25(var_9);
    var_30 = _id_0850::_id_FF26(var_9);
    _id_0850::_id_BCE5(var_0, var_1, " tracedist: " + var_27 + " ft (" + var_28 + "m) " + var_5 + "traces", var_3, var_2, 1);
    var_1 = var_1 + 16 * var_2;
    _id_0850::_id_BCE5(var_0, var_1, " int. dist: " + var_29 + " ft (" + var_30 + "m)", var_3, var_2, 1);
    var_1 = var_1 + 16 * var_2;
    _id_0850::_id_BCE5(var_0, var_1, " area dist: " + var_26 + "ft (" + var_26 * 0.0254 + "m)", (0.666, 1, 0.666), var_2, 1);
    var_1 = var_1 + 16 * var_2;
    _id_0850::_id_BCE5(var_0, var_1, "heightdist: " + var_23 + "ft (" + var_23 * 0.0254 + "m)", (0.666, 1, 0.666), var_2, 1);
    var_1 = var_1 + 16 * var_2;
    _id_0850::_id_BCE5(var_0, var_1, " avg. dist: " + var_14 * var_8 / 12.0 + "ft smooth'd " + " " + var_13 * var_8 / 12.0 + " ft (" + var_13 * var_8 * 0.0254 + "m)", (0.666, 1, 0.666), var_2, 1);
    var_1 = var_1 + 16 * var_2;
    _id_0850::_id_BCE5(var_0, var_1, "total frac: " + var_15 + " smooth'd" + " " + var_12, (1, 0.666, 0.666), var_2, 1);
    var_1 = var_1 + 16 * var_2;
    var_31 = "exterior";

    if(var_15 <= var_20) {
      var_31 = "partial";
    }

    if(var_15 <= var_19) {
      var_31 = "interior";
    }

    _id_0850::_id_BCE5(var_0, var_1, "status: " + var_31, (0.666, 0.666, 1), var_2, 1);
    var_1 = var_1 + 16 * var_2;
    _id_0850::_id_BCE5(var_0, var_1, " surface: " + var_18, var_3, var_2, 1);
    var_1 = var_1 + 16 * var_2;
    var_1 = var_1 + 16 * var_2;
    _id_0850::_id_BCE5(var_0, var_1, "dimensions: " + var_21 + "'w x " + var_22 + "'l x " + var_23 + "'h", var_3, var_2, 1);
    var_1 = var_1 + 16 * var_2;
    _id_0850::_id_BCE5(var_0, var_1, "area: " + var_24 + " ft2 (" + var_24 * 0.3048 + " m2)", var_3, var_2, 1);
    var_1 = var_1 + 16 * var_2;
    _id_0850::_id_BCE5(var_0, var_1, "volume: " + var_25 + " ft3 (" + var_25 * 0.3048 + " m3)", var_3, var_2, 1);
    var_1 = var_1 + 16 * var_2;
  }

  if(var_7 > 5) {
    var_1 = var_1 + 16 * var_2;
    var_1 = var_1 + 16 * var_2;
    var_1 = var_1 + 16 * var_2;
    var_1 = var_1 + 16 * var_2;
    var_2 = 1.0;
    var_32 = var_0;

    foreach(var_34 in var_4) {
      var_35 = var_34["fraction"];

      if(isDefined(var_35) == 0) {
        var_35 = 1.0;
      }

      var_0 = var_32;
      _id_0850::_id_BCE5(var_0, var_1, " seq: " + var_34["counter"], var_3, var_2, 1);
      var_0 = var_0 + 12 * (8 * var_2);
      _id_0850::_id_BCE5(var_0, var_1, "time: " + var_34["time"], var_3, var_2, 1);
      var_0 = var_0 + 20 * (8 * var_2);
      _id_0850::_id_BCE5(var_0, var_1, "dist: " + var_34["distance"] / 12.0 + "'", var_3, var_2, 1);
      var_0 = var_0 + 16 * (8 * var_2);
      _id_0850::_id_BCE5(var_0, var_1, "azim: " + var_34["azimuth"], var_3, var_2, 1);
      var_0 = var_0 + 12 * (8 * var_2);
      _id_0850::_id_BCE5(var_0, var_1, "elev: " + var_34["elevation"], var_3, var_2, 1);
      var_0 = var_0 + 12 * (8 * var_2);
      _id_0850::_id_BCE5(var_0, var_1, " mat: " + _func_00D6(var_34["surfacetype"], 9), var_3, var_2, 1);
      var_1 = var_1 + 16 * var_2;
    }

    var_0 = var_32;

    foreach(var_39, var_38 in var_17) {
      var_0 = var_32;
      _id_0850::_id_BCE5(var_0, var_1, "surfaces: " + var_39, var_3, var_2, 1);
      var_0 = var_0 + 32 * (8 * var_2);
      _id_0850::_id_BCE5(var_0, var_1, " " + var_38 / var_16.size, var_3, var_2, 1);
      var_1 = var_1 + 16 * var_2;
    }
  }
}

_id_0D38(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_0.origin;

  if(isPlayer(var_0) || isai(var_0)) {
    var_6 = var_0 getEye();
  }

  var_6 = var_6 + var_1;
  var_7 = _id_0850::_id_AC5D(var_6, var_2, var_3, var_4);
  var_8 = scripts\engine\trace::ray_trace(var_6, var_7, level.players, var_5, 1, 1);
  var_8["traceStart"] = var_6;
  var_8["traceEnd"] = var_7;
  var_8["azimuth"] = _id_0850::_id_5BE9(var_3);
  var_8["elevation"] = _id_0850::_id_5BE9(var_4);
  var_8["distance"] = var_8["fraction"] * var_2;
  var_8["time"] = gettime();
  var_8["counter"] = self._id_0C8B._id_3D9D;
  return var_8;
}

_id_0D3D(var_0) {
  var_1 = self._id_0C8B._id_F3C6;
  var_2 = self._id_0C8B._id_1FF5;
  var_3 = self._id_0C8B._id_5123;
  var_4 = self._id_0C8B._id_F3C5;
  var_5 = getdvarint("#x3856118b6122a671d");
  var_6 = int(20.0 * getdvarfloat("#x322353bdd6f028d9d"));
  var_7 = getdvarint("#x3242af77e96691365");
  var_8 = getdvarint("#x3bc4a012123f42795");
  var_9 = getdvarint("#x3a6df96b270853211");
  var_10 = getdvarfloat("#x3ee02dd0a41430047");
  var_11 = getdvarfloat("#x3f1e1aa65be254554");
  var_12 = getdvarint("#x3175db763174f0cbc");
  var_13 = getdvarint("#x386a31aa51c34d92f");
  var_14 = getdvarint("#x39999f7ccf1cc1d99");
  var_15 = getdvarint("#x36fda88878fd82144");
  var_16 = getdvarfloat("#x37b4a1372cf4725c1");
  var_17 = [];
  var_4 = [];
  var_18 = _func_0037(360.0 / var_5 / var_10);
  var_19 = _func_0037(360.0 / var_5 / var_11);
  var_20 = var_18 + var_19;
  var_21 = var_2;
  var_22 = var_3;

  if(self._id_0C8B._id_3D9D < var_19) {
    if(self._id_0C8B._id_5123 == 0 || self._id_0C8B._id_5123 == -180 || self._id_0C8B._id_5123 == 180) {
      self._id_0C8B._id_5123 = -90;
    }

    var_2 = 0.0;
    var_10 = 0.0;
    var_3 = self._id_0C8B._id_5123;
  } else {
    var_2 = self._id_0C8B._id_1FF5;
    var_3 = 0.0;
    var_11 = 0.0;
  }

  self._id_0C8B._id_F3C8 = var_7;
  self._id_0C8B._id_83C8 = var_8;
  self._id_0C8B._id_AE7A = var_9;

  if(isDefined(self) == 1 && _func_0458(self) == 0) {
    var_23 = 0;

    if(var_5 > 1) {
      var_23 = 360.0 / var_5;
    }

    for(var_24 = 0; var_24 < var_5; var_24++) {
      var_17 = _id_0D38(self, (0, 0, var_15), var_7, var_2 + var_12, var_3 + var_13, var_1);
      var_4[var_4.size] = var_17;
      var_3 = var_3 + var_23;
    }

    var_2 = _id_0850::_id_5BE9((var_21 + var_10) % 360);
    var_3 = _id_0850::_id_5BE9((var_3 + var_11) % var_14);
    self._id_0C8B._id_5141 = self._id_0C8B._id_5141 + var_11;
    self._id_0C8B._id_3D9D = self._id_0C8B._id_3D9D + 1;
    self._id_0C8B._id_3D9D = self._id_0C8B._id_3D9D % var_20;
  }

  var_25 = var_6 * var_5;

  for(var_24 = 0; var_24 < var_25 - var_5; var_24++) {
    if(isDefined(var_4[var_24])) {
      var_4[var_4.size] = self._id_0C8B._id_F3C5[var_24];
    }
  }

  self._id_0C8B._id_1FF5 = var_2;
  self._id_0C8B._id_5123 = var_3;
  self._id_0C8B._id_F3C5 = var_4;
  var_26 = 0;
  var_27 = 0;
  var_28 = 0;
  var_29 = 0;
  var_30 = 0;
  var_31 = 0;
  var_32 = 0.0;
  var_33 = 0.0;
  var_34 = [];
  var_35 = [];
  var_36 = [];

  foreach(var_17 in var_4) {
    var_38 = var_17["azimuth"];
    var_39 = var_17["elevation"];
    var_40 = var_17["distance"];
    var_41 = var_17["fraction"];
    var_42 = var_17["surfacetype"];

    if(_func_0121(var_42) == 1 && issubstr(var_42, "surftype_")) {
      var_42 = _func_00D6(var_42, 9);
    }

    var_43 = _id_0850::_id_8AF3(var_39, -90, 45);
    var_44 = _id_0850::_id_8AF3(var_39, 90, 45);

    if(var_43) {
      if(var_40 > var_30) {
        var_30 = var_40;
      }

      if(_func_0121(var_42) == 1) {
        var_35[var_35.size] = var_42;
      }
    } else if(var_44) {
      if(var_40 > var_31) {
        var_31 = var_40;
      }

      if(_func_0121(var_42) == 1) {
        var_36[var_36.size] = var_42;
      }
    } else {
      if(_id_0850::_id_8AF3(var_38, 0, 45) && var_40 > var_26) {
        var_26 = var_40;
      } else if(_id_0850::_id_8AF3(var_38, 90, 45) && var_40 > var_28) {
        var_28 = var_40;
      } else if((_id_0850::_id_8AF3(var_38, 180, 45) || _id_0850::_id_8AF3(var_38, -180, 45)) && var_40 > var_27) {
        var_27 = var_40;
      } else if((_id_0850::_id_8AF3(var_38, -90, 45) || _id_0850::_id_8AF3(var_38, 270, 45)) && var_40 > var_29) {
        var_29 = var_40;
      }

      if(_func_0121(var_42) == 1) {
        var_34[var_34.size] = var_42;
      }
    }

    var_45 = var_41;

    if(isDefined(var_45) == 0) {
      var_41 = 1.0;
      var_45 = 1.0;
    } else if(var_40 < var_8)
      var_45 = 0.0;

    var_32 = var_32 + var_41;
    var_33 = var_33 + var_45;
  }

  self._id_0C8B._id_19FE = (_id_0850::_id_DE60(var_28 + var_29, self._id_0C8B._id_19FE[0], var_16), _id_0850::_id_DE60(var_26 + var_27, self._id_0C8B._id_19FE[1], var_16), _id_0850::_id_DE60(var_30 + var_31, self._id_0C8B._id_19FE[2], var_16));
  var_47 = [];

  foreach(var_17 in var_4) {
    var_49 = "none";

    if(_func_0121(var_17["surfacetype"]) == 1) {
      var_49 = var_17["surfacetype"];
    }

    if(issubstr(var_49, "surftype_")) {
      var_49 = _func_00D6(var_49, 9);
    }

    var_47[var_47.size] = var_49;
  }

  var_51 = [];

  foreach(var_49 in var_47) {
    if(isDefined(var_51[var_49]) == 0) {
      var_51[var_49] = 0;
    }

    var_51[var_49] = var_51[var_49] + 1;
  }

  var_54 = "none";
  var_55 = 0;

  foreach(var_49, var_57 in var_51) {
    if(var_57 > var_55) {
      var_55 = var_57;
      var_54 = var_49;
    }
  }

  self._id_0C8B._id_EBCC = var_47;
  self._id_0C8B._id_EBCB = var_51;
  self._id_0C8B._id_EBCD = var_54;

  if(var_4.size > 0) {
    var_32 = var_32 / var_4.size;
    var_33 = var_33 / var_4.size;
    self._id_0C8B._id_DE5D = _id_0850::_id_DE60(var_32, self._id_0C8B._id_DE5D, var_16);
    var_58 = var_17["fraction"];

    if(var_17["distance"] < var_8) {
      var_58 = 0.0;
    }

    self._id_0C8B._id_DE5E = _id_0850::_id_DE60(var_33, self._id_0C8B._id_DE5E, var_16);

    if(self._id_0C8B._id_DE5E < 0.001) {
      self._id_0C8B._id_DE5E = 0.0;
    }
  }

  self._id_0C8B._id_4B91 = var_32;
  self._id_0C8B._id_4B94 = var_33;
  _id_0D3A(self._id_0C8B.color, self._id_0C8B._id_47FC, var_4, var_5, self._id_0C8B._id_A97D);
  _id_0D39(160, 160, 2.0, (1, 1, 1), var_4, var_5, self._id_0C8B._id_A97D);
  return self._id_0C8B._id_DE5E;
}

_id_0D40(var_0, var_1) {
  var_2 = self;

  if(isPlayer(var_2) == 0) {
    return;
  }
  var_3 = var_0 * var_2._id_0C8B._id_F3C8;
  var_4 = "exterior";

  if(var_3 <= var_2._id_0C8B._id_83C8) {
    var_4 = "interior";
  }

  if(var_2._id_0C8B._id_3BF0 != var_4) {
    var_2 _meth_82FA(level.script + "_" + var_4, 0.1);
    var_2._id_0C8B._id_3BF0 = var_4;
  }
}

_id_0D44(var_0) {
  var_1 = self;

  if(isPlayer(var_1) == 1) {
    var_1 _meth_8078(0.1);
  }
}

_id_DEC9(var_0, var_1, var_2, var_3, var_4) {
  var_0 = scripts\engine\utility::_id_FF6C(var_0, level.players);
  var_1 = scripts\engine\utility::_id_FF6C(var_1, (0, 1, 0));
  var_2 = scripts\engine\utility::_id_FF6C(var_2, 0);
  var_3 = scripts\engine\utility::_id_FF6C(var_3, 0.5);
  var_4 = scripts\engine\utility::_id_FF6C(var_4, (0, 0, 0));
  var_3 = int(20.0 * var_3);
  setdvarifuninitialized("#x3ee02dd0a41430047", "48");
  setdvarifuninitialized("#x3175db763174f0cbc", "0");
  setdvarifuninitialized("#x322353bdd6f028d9d", "0.6");
  setdvarifuninitialized("#x3f1e1aa65be254554", "180");
  setdvarifuninitialized("#x386a31aa51c34d92f", "0");
  setdvarifuninitialized("#x39999f7ccf1cc1d99", "180");
  setdvarifuninitialized("#x3bc4a012123f42795", "240");
  setdvarifuninitialized("#x36fda88878fd82144", "0");
  setdvarifuninitialized("#x3a6df96b270853211", "480");
  setdvarifuninitialized("#x37b4a1372cf4725c1", "0.1");
  setdvarifuninitialized("#x3856118b6122a671d", "2");
  setdvarifuninitialized("#x3242af77e96691365", "2400");

  foreach(var_6 in _id_0850::_id_1BF3(var_0)) {
    if(var_6 _id_0847::_id_DEFE("autozone") == 1) {
      var_6 _id_0847::_id_DF07("autozone");
    }

    var_6._id_0C8B = spawnStruct();
    var_6._id_0C8B._id_3D9D = 0;
    var_6._id_0C8B._id_5141 = 0;
    var_6._id_0C8B._id_19FE = (0, 0, 0);
    var_6._id_0C8B._id_3BF0 = "";
    var_6._id_0C8B.color = var_1;
    var_6._id_0C8B._id_47FC = var_2;
    var_6._id_0C8B._id_5090 = var_3;
    var_6._id_0C8B._id_A97D = var_4;
    var_6._id_0C8B._id_1FF5 = 0;
    var_6._id_0C8B._id_5123 = 0;
    var_6._id_0C8B._id_F3C5 = [];
    var_6._id_0C8B._id_DE5D = 0;
    var_6._id_0C8B._id_DE5E = 0;
    var_6._id_0C8B._id_F3C6 = physics_createcontents(["physicscontents_soundclip", "physicscontents_glass", "physicscontents_water"]);
    var_6 _id_0847::_id_DEFD("autozone", undefined, ::_id_0D3D, ::_id_0D40, ::_id_0D44, var_6);
  }
}

_id_DECA(var_0) {
  foreach(var_2 in _id_0850::_id_1BF3(var_0)) {
    var_2 _id_0847::_id_DF07("autozone");
  }
}