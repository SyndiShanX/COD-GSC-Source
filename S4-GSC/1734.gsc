/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1734.gsc
*************************************************/

_id_17BF(var_0, var_1, var_2) {
  var_3 = _id_6356(var_2);
  var_4 = var_3["origin"];
  var_5 = var_3["angles"];
  scripts\engine\utility::_id_1BB7(var_0, ::_id_17C1, var_1, var_4, var_5);
}

_id_17CD(var_0, var_1, var_2) {
  var_3 = _id_6356(var_2);
  var_4 = var_3["origin"];
  var_5 = var_3["angles"];
  thread _id_17C1(var_0, var_1, var_4, var_5, "generic");
}

_id_17CA(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  _id_183B(var_3, var_1, var_2, 0, "generic");
}

_id_17D3(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[0] = var_0;
  _id_183B(var_4, var_1, var_2, 0.25, "generic", var_3);
}

_id_1847(var_0, var_1, var_2) {
  self endon("death");
  var_3[0] = var_0;
  _id_183B(var_3, var_1, var_2, 0.25);
}

_id_17C2(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  _id_17BF(var_3, var_1, var_2);
}

_id_17C1(var_0, var_1, var_2, var_3, var_4) {
  var_0._id_5BB0 = gettime();
  var_5 = undefined;

  if(isDefined(var_4)) {
    var_5 = var_4;
  } else {
    var_5 = var_0._id_18AF;
  }

  var_6 = 0;

  if(_func_0107(level._id_CC31[var_5][var_1])) {
    var_7 = level._id_CC31[var_5][var_1][0];
    var_6 = 1;
  } else
    var_7 = level._id_CC31[var_5][var_1];

  var_0 _id_D3BD(var_1, var_2, var_3, var_5, var_6);

  if(isai(var_0)) {
    var_0[[anim._id_2F52["AIAnimFirstFrame"]]](var_7, var_5);
  } else {
    var_0 _meth_83EC();
    var_0 _meth_82DB(var_7, 1, 0, 0);

    if(!scripts\common\utility::issp()) {
      if(!isPlayer(var_0) && isDefined(level._id_CC32[var_5]) && isDefined(level._id_CC32[var_5][var_1])) {
        var_0 call[[level._id_6016["scriptModelPlayAnim"]]](level._id_CC32[var_5][var_1], undefined, 0, 0, "none");
      }
    }
  }
}

_id_D3BD(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;

  if(isDefined(var_3)) {
    var_5 = var_3;
  } else {
    var_5 = self._id_18AF;
  }

  if(isDefined(var_4) && var_4) {
    var_6 = level._id_CC31[var_5][var_0][0];
  } else {
    var_6 = level._id_CC31[var_5][var_0];
  }

  var_7 = getstartorigin(var_1, var_2, var_6);
  var_8 = _func_00D2(var_1, var_2, var_6);
  self[[anim._id_2F52["TeleportEnt"]]](var_7, var_8);
}

_id_1858(var_0, var_1, var_2) {
  var_3 = _id_6356(var_2);
  var_4 = var_3["origin"];
  var_5 = var_3["angles"];
  scripts\engine\utility::_id_1BE2(var_0, ::_id_D3BD, var_1, var_4, var_5);
}

_id_1859(var_0, var_1, var_2) {
  var_3[0] = var_0;
  _id_1858(var_3, var_1, var_2);
}

_id_17E9(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  _id_17BF(var_3, var_1, var_2);
  var_4 = var_0 scripts\engine\utility::_id_68BF(var_1);

  if(_func_0107(var_4)) {
    var_4 = var_4[0];
  }

  if(var_0 _meth_82EB(var_4)) {
    _id_1839(var_3, var_1, 0.999999);
  } else {
    _id_1839(var_3, var_1, 1.0);
  }

  var_5 = _func_00B0(var_4);
  var_6 = _func_0078(var_4);
  var_7 = rotatevector(var_5, var_0.angles);
  var_8 = var_0.origin + var_7;
  var_9 = _func_0047(var_0.angles, var_6);
  var_0[[anim._id_2F52["TeleportEnt"]]](var_8, var_9);
}

_id_1845(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5[0] = var_0;

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  _id_183B(var_5, var_1, var_2, var_3, var_4);
}

_id_1842(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = self;

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  foreach(var_9 in var_0) {
    if(!isDefined(var_9)) {
      continue;
    }
    if(!isDefined(var_9._id_0B37)) {
      var_9._id_0B37 = 0;
    }

    var_9._id_0B37++;
  }

  var_11 = _id_6356(var_2);
  var_12 = var_11["origin"];
  var_13 = var_11["angles"];
  var_14 = undefined;

  if(var_6) {
    var_15 = 0;
  } else {
    var_15 = 999999;
  }

  var_16 = undefined;
  var_17 = undefined;
  var_18 = undefined;
  var_19 = undefined;
  var_20 = "single anim";

  foreach(var_32, var_9 in var_0) {
    if(!isDefined(var_9)) {
      continue;
    }
    var_22 = 0;
    var_23 = 0;
    var_24 = 0;
    var_25 = 0;
    var_26 = 0;
    var_27 = undefined;
    var_28 = undefined;
    var_29 = undefined;
    var_30 = undefined;

    if(isDefined(var_4)) {
      var_30 = var_4;
    } else {
      var_30 = var_9._id_18AF;
    }

    if(isDefined(level._id_CC46[var_30]) && isDefined(level._id_CC46[var_30][var_1])) {
      var_24 = 1;
      var_27 = level._id_CC46[var_30][var_1];
    }

    if(isDefined(level._id_CC3C[var_30]) && isDefined(level._id_CC3C[var_30][var_1])) {
      var_22 = 1;
      var_28 = level._id_CC3C[var_30][var_1];
      var_18 = var_28;

      if(var_24) {
        if(_func_0011(var_28, "vo_" + var_27)) {
          var_24 = 0;
          var_27 = undefined;
        }
      }
    }

    if(isDefined(level._id_CC3F[var_30]) && isDefined(level._id_CC3F[var_30][var_1])) {
      var_23 = 1;
      var_29 = level._id_CC3F[var_30][var_1];
      var_19 = var_29;
    }

    if(isDefined(level._id_CC31[var_30]) && isDefined(level._id_CC31[var_30][var_1]) && self[[anim._id_2F52["ShouldDoAnim"]]]()) {
      var_25 = 1;
    }

    if(isDefined(level._id_CC33[var_30]) && isDefined(level._id_CC33[var_30][var_1])) {
      var_9 playSound(level._id_CC33[var_30][var_1]);
    }

    if(var_25) {
      var_9 guy_pre_anim_func();
      var_31 = var_9[[anim._id_2F52["DoAnimation"]]](var_12, var_13, var_30, var_1, var_20, var_5);
      var_9 thread guy_post_anim_func_watcher(var_20, undefined);

      if(var_6) {
        if(var_31 > var_15) {
          var_15 = var_31;
          var_14 = var_32;
        }
      } else if(var_31 < var_15) {
        var_15 = var_31;
        var_14 = var_32;
      }
    }

    if(var_22 || var_24) {
      if(var_9[[anim._id_2F52["DoFacialAnim"]]](var_22, var_24, var_25, var_1, var_30, var_27, 0)) {
        var_17 = var_32;
      }

      var_16 = var_32;
    }

    if(var_23) {
      var_9 thread _id_B1E1(var_9, var_19);
    }

    if(!isPlayer(var_9) && isDefined(level._id_CC32[var_30]) && isDefined(level._id_CC32[var_30][var_1])) {
      var_9 scripts\engine\utility::_id_D07A("scriptModelPlayAnim", level._id_CC32[var_30][var_1]);
    }
  }

  if(isDefined(var_14)) {
    var_33 = spawnStruct();
    var_33 thread _id_17B2(var_0[var_14], var_1);
    var_33 thread _id_17A0(var_0[var_14], var_1, var_15, var_3);
    var_33 waittill(var_1);
  } else if(isDefined(var_17)) {
    var_33 = spawnStruct();
    var_33 thread _id_17B2(var_0[var_17], var_1);
    var_33 thread _id_17BD(var_0[var_17], var_1, var_18);
    var_33 waittill(var_1);
  } else if(isDefined(var_16)) {
    var_33 = spawnStruct();
    var_33 thread _id_17B2(var_0[var_16], var_1);
    var_33 thread _id_17B3(var_0[var_16], var_1);
    var_33 waittill(var_1);
  }

  foreach(var_9 in var_0) {
    if(!isDefined(var_9)) {
      continue;
    }
    var_9._id_0B37--;
    var_9._id_0C47 = gettime();
  }

  self notify(var_1);
}

_id_183B(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  _id_1842(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_17F3(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  var_0 endon("death");
  var_6[0] = var_0;
  _id_17EE(var_6, var_1, var_2, var_3, var_4, var_5);
}

_id_17F4(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_0 endon("death");
  var_4[0] = var_0;
  _id_17EE(var_4, var_1, var_2, var_3);
}

_id_17CF(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4["guy"] = var_0;
  var_4["entity"] = self;
  var_4["tag"] = var_3;
  var_5[0] = var_4;
  _id_17F1(var_5, var_1, var_2, "generic");
}

_id_17EE(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];

  foreach(var_8 in var_0) {
    var_9 = [];
    var_9["guy"] = var_8;
    var_9["entity"] = self;
    var_9["tag"] = var_3;
    var_9["origin_offset"] = var_4;
    var_6[var_6.size] = var_9;
  }

  _id_17F1(var_6, var_1, var_2, var_5);
}

_id_17F2(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[0] = var_0;
  _id_17F1(var_4, var_1, var_2, var_3);
}

_id_B05E(var_0) {
  var_1 = undefined;

  if(var_0._id_A39A.size == 1) {
    var_1 = 0;
  } else if(var_0._id_41D7 == var_0._id_A39A.size - 1) {
    var_1 = 0;
  } else {
    var_1 = var_0._id_41D7 + 1;
  }

  var_0._id_41D7 = var_1;
  var_0._id_8F43 = gettime();
  return var_0._id_41D7;
}

_id_17F1(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    var_6 = var_5["guy"];

    if(!isDefined(var_6)) {
      continue;
    }
    if(!isDefined(var_6._id_0B37)) {
      var_6._id_0B37 = 0;
    }

    var_6 endon("death");
    var_6._id_0B37++;
  }

  var_8 = var_0[0]["guy"];

  if(!isDefined(var_2)) {
    var_2 = "stop_loop";
  }

  thread _id_5336(var_2, var_0);
  self endon(var_2);
  var_9 = "looping anim";
  var_10 = var_1;
  var_11 = undefined;

  if(isDefined(var_3)) {
    var_11 = var_3;
  } else {
    var_11 = var_8._id_18AF;
  }

  var_12 = 0;
  var_13 = 0;
  var_14 = 0;
  var_15 = isDefined(level._id_CC31[var_11][var_1 + "_nags"]);

  if(var_15 && scripts\common\utility::issp()) {
    var_16 = 0;

    foreach(var_18, var_5 in var_0) {
      if(isai(var_5["guy"])) {
        var_16++;
      }
    }

    if(isDefined(level._id_CC31[var_11][var_1 + "_nags_timer"])) {
      var_14 = level._id_CC31[var_11][var_1 + "_nags_timer"];
    } else {
      var_14 = 15;
    }
  }

  var_19 = 0;
  var_20 = undefined;
  var_21 = 0;
  var_22 = 1;

  if(var_15) {
    setdvarifuninitialized("#x3df67786d86ce665a", 0);
    var_20 = spawnStruct();
    var_20._id_8F43 = gettime();
    var_20._id_A39A = level._id_CC31[var_11][var_1 + "_nags"];
    var_20._id_41D7 = 0;
    childthread _id_A3B5(var_14, var_8);
  }

  for(;;) {
    if(!var_19) {
      var_1 = var_10;

      for(var_12 = _id_186D(var_11, var_1); var_12 == var_13 && var_12 != 0; var_12 = _id_186D(var_11, var_1)) {}
    } else {
      var_12 = _id_B05E(var_20);
      var_1 = var_10 + "_nags";
      childthread _id_A3B5(var_14, var_8);
      var_19 = 0;
    }

    var_13 = var_12;
    var_23 = undefined;
    var_24 = 999999;
    var_25 = undefined;
    var_6 = undefined;

    foreach(var_18, var_5 in var_0) {
      var_27 = var_5["entity"];
      var_6 = var_5["guy"];
      var_28 = var_27 _id_6356(var_5["tag"]);
      var_29 = var_28["origin"];
      var_30 = var_28["angles"];

      if(isDefined(var_5["origin_offset"])) {
        var_31 = var_5["origin_offset"];
        var_32 = anglesToForward(var_30);
        var_33 = anglestoright(var_30);
        var_34 = anglestoup(var_30);
        var_29 = var_29 + var_32 * var_31[0];
        var_29 = var_29 + var_33 * var_31[1];
        var_29 = var_29 + var_34 * var_31[2];
      }

      if(isDefined(var_6._id_C3C2)) {
        var_6._id_C3C2 = undefined;
        var_0[var_18] = undefined;
        continue;
      }

      var_35 = 0;
      var_36 = 0;
      var_37 = 0;
      var_38 = 0;
      var_39 = undefined;
      var_40 = undefined;
      var_41 = undefined;

      if(isDefined(var_3)) {
        var_41 = var_3;
      } else {
        var_41 = var_6._id_18AF;
      }

      if(isDefined(level._id_CC3C[var_41]) && isDefined(level._id_CC3C[var_41][var_1]) && isDefined(level._id_CC3C[var_41][var_1][var_12])) {
        var_35 = 1;
        var_39 = level._id_CC3C[var_41][var_1][var_12];
      }

      if(isDefined(level._id_CC46[var_41]) && isDefined(level._id_CC46[var_41][var_1]) && isDefined(level._id_CC46[var_41][var_1][var_12])) {
        var_36 = 1;
        var_40 = level._id_CC46[var_41][var_1][var_12];
      }

      if(isDefined(level._id_CC33[var_41]) && isDefined(level._id_CC33[var_41][var_12 + var_1])) {
        var_6 playSound(level._id_CC33[var_41][var_12 + var_1]);
      }

      if(isDefined(level._id_CC31[var_41]) && isDefined(level._id_CC31[var_41][var_1]) && self[[anim._id_2F52["ShouldDoAnim"]]]()) {
        var_37 = 1;
      }

      if(var_37) {
        if(var_22) {
          var_6 guy_pre_anim_func();
        }

        var_42 = var_6[[anim._id_2F52["DoAnimation"]]](var_29, var_30, var_41, var_1, var_9, var_12);

        if(var_22) {
          var_6 thread guy_post_anim_func_watcher(undefined, var_2);
        }

        if(var_42 < var_24) {
          var_24 = var_42;
          var_23 = var_18;
        }
      }

      if(var_35 || var_36) {
        var_6[[anim._id_2F52["DoFacialAnim"]]](var_35, var_36, var_37, var_1, var_41, var_40, 1);
        var_25 = var_18;
      }
    }

    var_22 = 0;

    if(!isDefined(var_6)) {
      break;
    }

    if(isDefined(var_23)) {
      var_43 = _id_1087E(var_0[var_23]["guy"], var_9);

      if(!isDefined(var_43) && var_15) {
        var_19 = 1;

        if(isDefined(anim._id_2F52["StopAnimscripted"])) {
          var_6[[anim._id_2F52["StopAnimscripted"]]]();
        }
      }
    } else if(isDefined(var_25))
      var_0[var_25]["guy"] waittill(var_9);

    if(var_21) {
      break;
    }
  }
}

_id_1087E(var_0, var_1) {
  self endon("do_nag");
  var_0 waittillmatch(var_1, "end");
  return 1;
}

_id_A3B5(var_0, var_1) {
  self endon("death");
  var_2 = var_0;
  var_3 = gettime();

  while(var_3 + var_0 * 1000 > gettime()) {
    wait 1;
  }

  self notify("do_nag");
}

_id_183A(var_0, var_1, var_2) {
  self endon("death");
  var_3[0] = var_0;
  _id_1839(var_3, var_1, var_2);
}

_id_1839(var_0, var_1, var_2) {
  scripts\engine\utility::_id_1BE2(var_0, ::_id_1833, var_1, var_2);
}

_id_1833(var_0, var_1) {
  var_2 = scripts\engine\utility::_id_68BF(var_0);

  if(_func_0107(var_2)) {
    var_2 = var_2[0];
  }

  self _meth_82E7(var_2, var_1);
}

_id_8F09() {
  if(!isDefined(self._id_8F08)) {
    self._id_8F08 = gettime();
    return;
  }

  var_0 = gettime();

  if(self._id_8F08 == var_0) {
    self endon("death");
    wait 0.05;
  }

  self._id_8F08 = var_0;
}

_id_17F7(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_6356(var_2);
  var_7 = var_6["origin"];
  var_8 = var_6["angles"];

  foreach(var_10 in var_0) {
    var_11 = getstartorigin(var_7, var_8, level._id_CC31[var_10._id_18AF][var_1]);
    var_12 = _func_00D2(var_7, var_8, level._id_CC31[var_10._id_18AF][var_1]);

    if(isai(var_10)) {
      continue;
    }
    var_10 moveto(var_11, var_3, var_4, var_5);
    var_10 rotateto(var_12, var_3, var_4, var_5);
  }
}

_id_185E(var_0, var_1, var_2) {
  self endon("death");
  var_3[0] = var_0;
  _id_185D(var_3, var_1, var_2);
}

_id_185D(var_0, var_1, var_2) {
  var_3 = _id_6356(var_2);
  var_4 = var_3["origin"];
  var_5 = var_3["angles"];

  foreach(var_7 in var_0) {
    var_8 = getstartorigin(var_4, var_5, level._id_CC31[var_7._id_18AF][var_1]);
    var_9 = _func_00D2(var_4, var_5, level._id_CC31[var_7._id_18AF][var_1]);
    var_7[[anim._id_2F52["TeleportEnt"]]](var_8, var_9);
  }
}

_id_17D4(var_0, var_1, var_2) {
  var_3 = _id_6356(var_2);
  var_4 = var_3["origin"];
  var_5 = var_3["angles"];
  var_6 = getstartorigin(var_4, var_5, level._id_CC31["generic"][var_1]);
  var_7 = _func_00D2(var_4, var_5, level._id_CC31["generic"][var_1]);
  var_0[[anim._id_2F52["TeleportEnt"]]](var_6, var_7);
}

_id_184F(var_0, var_1, var_2) {
  return _id_1850(var_0, "generic", var_1, var_2);
}

_id_1850(var_0, var_1, var_2, var_3) {
  var_4 = _id_6356(var_3);
  var_5 = var_4["origin"];
  var_6 = var_4["angles"];
  var_7 = getstartorigin(var_5, var_6, level._id_CC31[var_1][var_2]);
  var_8 = getstartorigin(var_5, var_6, level._id_CC31[var_1][var_2]);
  var_9 = spawn("script_model", var_7);
  var_9 setModel(var_0);
  var_9.angles = var_8;
  return var_9;
}

_id_1851(var_0, var_1) {
  self attach(var_0, var_1);
}

_id_17EB(var_0, var_1) {
  var_2 = self gettagorigin(var_1);
  var_3 = spawn("script_model", var_2);
  var_3 setModel(var_0);
  var_3 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
  return var_3;
}

_id_C4EE(var_0, var_1, var_2, var_3, var_4) {
  var_1 = tolower(var_1);
  var_5 = level._id_CC43[var_0][var_2][var_1];
  var_2 = _id_64C5(var_2);
  var_6 = -1;

  if(!isDefined(var_5) || !_func_0107(var_5) || var_5.size < 1) {
    return;
  }
  for(var_7 = 0; var_7 < var_5.size; var_7++) {
    if(isDefined(var_5[var_7][var_3])) {
      if(!isDefined(var_4) || var_5[var_7][var_3] == var_4) {
        var_6 = var_7;
        break;
      }
    }
  }

  if(var_6 < 0) {
    return;
  }
  if(var_5.size == 1) {
    var_5 = [];
  } else {
    var_5 = scripts\engine\utility::array_remove_index(var_5, var_6);
  }

  level._id_CC43[var_0][var_2][var_1] = var_5;
}

_id_10F5(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_3 = _id_64C5(var_3);
  var_4 = _id_0FFA(var_0, var_1, var_3);
  var_5 = [];
  var_5["flag"] = var_2;
  level._id_CC43[var_0][var_3][var_1][var_4] = var_5;

  if(scripts\common\utility::issp()) {
    if(!isDefined(level._id_5C00) || !isDefined(level._id_5C00[var_2])) {
      scripts\engine\utility::_id_5C11(var_2);
    }
  }
}

_id_10F6(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_3 = _id_64C5(var_3);
  var_4 = _id_0FFA(var_0, var_1, var_3);
  var_5 = [];
  var_5["flag_clear"] = var_2;
  level._id_CC43[var_0][var_3][var_1][var_4] = var_5;

  if(!isDefined(level._id_5C00) || !isDefined(level._id_5C00[var_2])) {
    scripts\engine\utility::_id_5C11(var_2);
  }
}

_id_10F4(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_2 = _id_64C5(var_2);
  var_4 = _id_0FFA(var_0, var_1, var_2);
  level._id_CC43[var_0][var_2][var_1][var_4] = [];
  level._id_CC43[var_0][var_2][var_1][var_4]["dialog"] = var_3;
}

_id_0FFA(var_0, var_1, var_2) {
  var_1 = tolower(var_1);
  _id_0FFB(var_0, var_1, var_2);
  return level._id_CC43[var_0][var_2][var_1].size;
}

_id_0FFB(var_0, var_1, var_2) {
  var_1 = tolower(var_1);

  if(!isDefined(level._id_CC43)) {
    level._id_CC43 = [];
  }

  if(!isDefined(level._id_CC43[var_0])) {
    level._id_CC43[var_0] = [];
  }

  if(!isDefined(level._id_CC43[var_0][var_2])) {
    level._id_CC43[var_0][var_2] = [];
  }

  if(!isDefined(level._id_CC43[var_0][var_2][var_1])) {
    level._id_CC43[var_0][var_2][var_1] = [];
  }
}

_id_10FC(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1 = tolower(var_1);
  var_2 = _id_64C5(var_2);
  var_6 = _id_0FFA(var_0, var_1, var_2);
  level._id_CC43[var_0][var_2][var_1][var_6] = [];
  level._id_CC43[var_0][var_2][var_1][var_6]["sound"] = var_3;

  if(isDefined(var_4)) {
    level._id_CC43[var_0][var_2][var_1][var_6]["sound_stays_death"] = 1;
  }

  if(isDefined(var_5)) {
    level._id_CC43[var_0][var_2][var_1][var_6]["sound_on_tag"] = var_5;
  }
}

_id_A5E9(var_0, var_1, var_2, var_3) {
  var_4 = _id_643C();
  _id_10FC(var_4._id_18AF, var_0, var_4._id_1834, var_1, var_2, var_3);
}

_id_10FB(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_2 = _id_64C5(var_2);
  var_4 = _id_0FFA(var_0, var_1, var_2);
  level._id_CC43[var_0][var_2][var_1][var_4] = [];
  level._id_CC43[var_0][var_2][var_1][var_4]["playersound"] = var_3;
}

_id_64C5(var_0) {
  if(!isDefined(var_0)) {
    return "any";
  }

  return var_0;
}

_id_1105(var_0, var_1, var_2) {
  if(!isDefined(level._id_CC33[var_0])) {
    level._id_CC33[var_0] = [];
  }

  level._id_CC33[var_0][var_1] = var_2;
}

_id_10FA(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_2 = _id_64C5(var_2);
  var_4 = _id_0FFA(var_0, var_1, var_2);
  level._id_CC43[var_0][var_2][var_1][var_4] = [];
  level._id_CC43[var_0][var_2][var_1][var_4]["playerdialogue"] = var_3;
}

_id_10EE(var_0, var_1, var_2, var_3) {
  var_2 = tolower(var_2);
  var_1 = _id_64C5(var_1);
  var_4 = _id_0FFA(var_0, var_2, var_1);
  var_5 = [];
  var_5["sound"] = var_3;
  var_5["created_by_animSound"] = 1;
  level._id_CC43[var_0][var_1][var_2][var_4] = var_5;
}

_id_10EF(var_0, var_1, var_2, var_3, var_4) {
  var_1 = tolower(var_1);
  var_4 = _id_64C5(var_4);
  var_5 = _id_0FFA(var_0, var_1, var_4);
  var_6 = [];
  var_6["attach model"] = var_2;
  var_6["selftag"] = var_3;
  level._id_CC43[var_0][var_4][var_1][var_5] = var_6;
}

_id_10F2(var_0, var_1, var_2, var_3, var_4) {
  var_1 = tolower(var_1);
  var_4 = _id_64C5(var_4);
  var_5 = _id_0FFA(var_0, var_1, var_4);
  var_6 = [];
  var_6["detach model"] = var_2;
  var_6["selftag"] = var_3;
  level._id_CC43[var_0][var_4][var_1][var_5] = var_6;
}

_id_10F3(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_2 = _id_64C5(var_2);
  var_4 = _id_0FFA(var_0, var_1, var_2);
  var_5 = [];
  var_5["detach gun"] = 1;
  var_5["tag"] = "tag_weapon_right";

  if(isDefined(var_3)) {
    var_5["suspend"] = var_3;
  }

  level._id_CC43[var_0][var_2][var_1][var_4] = var_5;
}

_id_10F0(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_2 = _id_64C5(var_2);
  var_4 = _id_0FFA(var_0, var_1, var_2);
  var_5 = [];

  if(isDefined(var_3)) {
    var_5["attach gun " + var_3] = 1;
  } else {
    var_5["attach gun right"] = 1;
  }

  level._id_CC43[var_0][var_2][var_1][var_4] = var_5;
}

_id_10F1(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_3 = _id_64C5(var_3);
  var_4 = _id_0FFA(var_0, var_1, var_3);
  var_5 = [];
  var_5["function"] = var_2;
  level._id_CC43[var_0][var_3][var_1][var_4] = var_5;
}

_id_10FD(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\engine\utility::getfx(var_3);
  var_1 = tolower(var_1);
  var_2 = _id_64C5(var_2);
  var_6 = _id_0FFA(var_0, var_1, var_2);
  var_7 = [];
  var_7["effect"] = var_3;
  var_7["selftag"] = var_4;

  if(isDefined(var_5)) {
    var_7["moreThanThreeHack"] = var_5;
  }

  level._id_CC43[var_0][var_2][var_1][var_6] = var_7;
}

_id_10FE(var_0, var_1, var_2, var_3, var_4) {
  scripts\engine\utility::getfx(var_3);
  var_1 = tolower(var_1);
  var_2 = _id_64C5(var_2);
  var_5 = _id_0FFA(var_0, var_1, var_2);
  var_6 = [];
  var_6["stop_effect"] = var_3;
  var_6["selftag"] = var_4;
  level._id_CC43[var_0][var_2][var_1][var_5] = var_6;
}

_id_10F8(var_0, var_1, var_2, var_3, var_4) {
  var_1 = tolower(var_1);
  var_3 = _id_64C5(var_3);
  var_5 = _id_0FFA(var_0, var_1, var_3);
  var_6 = [];
  var_6["mayhem_start"] = var_2;
  var_6["use_hat_model"] = var_4;
  level._id_CC43[var_0][var_3][var_1][var_5] = var_6;
}

_id_10F7(var_0, var_1, var_2, var_3, var_4) {
  var_1 = tolower(var_1);
  var_3 = _id_64C5(var_3);
  var_5 = _id_0FFA(var_0, var_1, var_3);
  var_6 = [];
  var_6["mayhem_end"] = var_2;
  var_6["use_hat_model"] = var_4;
  level._id_CC43[var_0][var_3][var_1][var_5] = var_6;
}

_id_A5EB(var_0, var_1, var_2) {
  var_3 = _id_643C();
  scripts\engine\utility::_id_0FDC(var_1, var_1);
  _id_10FF(var_3._id_18AF, var_0, var_3._id_18D9, var_1, var_2);
}

_id_A5EA(var_0, var_1, var_2) {
  var_3 = _id_643C();
  scripts\engine\utility::_id_0FDC(var_1, var_1);
  _id_10FE(var_3._id_18AF, var_0, var_3._id_18D9, var_1, var_2);
}

_id_10FF(var_0, var_1, var_2, var_3, var_4) {
  scripts\engine\utility::getfx(var_3);
  var_1 = tolower(var_1);
  var_2 = _id_64C5(var_2);
  var_5 = _id_0FFA(var_0, var_1, var_2);
  var_6 = [];
  var_6["swap_part_to_efx"] = var_3;
  var_6["selftag"] = var_4;
  level._id_CC43[var_0][var_2][var_1][var_5] = var_6;
}

_id_A5EC(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_643C();

  if(var_0 != "start" && !_func_0011(var_6 scripts\engine\utility::_id_68BF(var_6._id_1834), var_0)) {
    return;
  }
  scripts\engine\utility::_id_0FDC(var_3, var_3);

  if(isDefined(var_4)) {
    scripts\engine\utility::_id_0FDC(var_4, var_4);
  }

  _id_1100(var_6._id_18AF, var_0, var_1, var_6._id_1834, var_2, var_3, var_4, var_5);
}

_id_A5E8(var_0, var_1, var_2) {
  var_3 = _id_643C();

  if(var_0 != "start" && !_func_0011(var_3 scripts\engine\utility::_id_68BF(var_3._id_1834), var_0)) {
    return;
  }
  scripts\engine\utility::_id_0FDC(var_2, var_2);
  _id_10FD(var_3._id_18AF, var_0, var_3._id_1834, var_2, var_1, 1);
}

_id_643C() {
  var_0 = level._id_414E;
  return var_0;
}

_id_1100(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  scripts\engine\utility::getfx(var_5);
  var_1 = tolower(var_1);
  var_3 = _id_64C5(var_3);
  var_8 = _id_0FFA(var_0, var_1, var_3);
  var_9 = [];
  var_9["trace_part_for_efx"] = var_5;
  var_9["trace_part_for_efx_water"] = var_6;
  var_9["trace_part_for_efx_cancel"] = var_2;
  var_9["trace_part_for_efx_delete_depth"] = var_7;
  var_9["selftag"] = var_4;
  level._id_CC43[var_0][var_3][var_1][var_8] = var_9;

  if(isDefined(var_2)) {
    var_9 = [];
    var_9["trace_part_for_efx_canceling"] = var_2;
    var_9["selftag"] = var_4;
    var_8 = _id_0FFA(var_0, var_2, var_3);
    level._id_CC43[var_0][var_3][var_2][var_8] = var_9;
  }
}

_id_10F9(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_3 = _id_64C5(var_3);
  var_4 = _id_0FFA(var_0, var_1, var_3);
  var_5 = [];
  var_5["notify"] = var_2;
  level._id_CC43[var_0][var_3][var_1][var_4] = var_5;
}

_id_D47B() {
  self useanimtree(level._id_CC34[self._id_18AF]);
}

_id_812F() {
  if(!isDefined(level._id_CC43)) {
    level._id_CC43 = [];
  }

  if(!isDefined(level._id_CC3C)) {
    level._id_CC3C = [];
  }

  if(!isDefined(level._id_CC3F)) {
    level._id_CC3F = [];
  }

  if(!isDefined(level._id_CC40)) {
    level._id_CC40 = [];
  }

  if(!isDefined(level._id_CC33)) {
    level._id_CC33 = [];
  }

  if(!isDefined(level._id_CC46)) {
    level._id_CC46 = [];
  }

  if(!isDefined(level._id_CC45)) {
    level._id_CC45 = [];
  }

  if(!isDefined(level._id_CC47)) {
    level._id_CC47 = [];
  }

  if(!isDefined(level._id_CC31)) {
    level._id_CC31[0][0] = 0;
  }

  if(!isDefined(level._id_CC32)) {
    level._id_CC32 = [];
  }

  if(!isDefined(level._id_CC45)) {
    level._id_CC45 = [];
  }

  if(!isDefined(level._id_CC44)) {
    level._id_CC44 = [];
  }

  if(!isDefined(level._id_CC3E)) {
    level._id_CC3E = [];
  }

  if(!isDefined(level._id_0C6E)) {
    level._id_0C6E = [];
  }

  if(!isDefined(level._id_CC35)) {
    level._id_CC35 = [];
  }

  thread _id_BB63();
  thread _id_BB65();
  scripts\engine\utility::_id_3F35("moreThanThreeHack", 3);
  scripts\engine\utility::_id_3F35("trace_part_for_efx", 12);
  _id_7EEF();
}

_id_BB63() {
  waittillframeend;

  if(!isDefined(level._id_CC42)) {
    return;
  }
  var_0 = getarraykeys(level._id_CC42);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(_func_0107(level._id_CC42[var_0[var_1]])) {
      for(var_2 = 0; var_2 < level._id_CC42[var_0[var_1]].size; var_2++) {
        precachemodel(level._id_CC42[var_0[var_1]][var_2]);
      }

      continue;
    }

    precachemodel(level._id_CC42[var_0[var_1]]);
  }
}

_id_BB65() {
  waittillframeend;

  if(!isDefined(level._id_CC4A)) {
    return;
  }
  var_0 = getarraykeys(level._id_CC4A);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = [];

    if(isDefined(level._id_CC4A[var_0[var_1]][1])) {
      var_2 = level._id_CC4A[var_0[var_1]][1];
    }

    scripts\common\utility::_id_99D6(level._id_CC4A[var_0[var_1]][0], var_2, 1, 1);
  }
}

_id_7EEF() {
  level._id_18E3 = [];
  level._id_18DC = [];
  var_0 = getarraykeys(level._id_CC43);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    _id_800B(var_0[var_1]);
  }

  var_0 = getarraykeys(level._id_CC33);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    _id_7EF0(var_0[var_1]);
  }
}

_id_7EF0(var_0) {
  var_1 = getarraykeys(level._id_CC33[var_0]);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_4 = level._id_CC33[var_0][var_3];
    level._id_18DC[var_0][var_3]["#" + var_3]["soundalias"] = var_4;
    level._id_18DC[var_0][var_3]["#" + var_3]["created_by_animSound"] = 1;
  }
}

_id_800B(var_0) {
  foreach(var_10, var_2 in level._id_CC43[var_0]) {
    foreach(var_9, var_4 in var_2) {
      foreach(var_6 in var_4) {
        var_7 = var_6["sound"];

        if(!isDefined(var_7)) {
          continue;
        }
        level._id_18DC[var_0][var_10][var_9]["soundalias"] = var_7;

        if(isDefined(var_6["created_by_animSound"])) {
          level._id_18DC[var_0][var_10][var_9]["created_by_animSound"] = 1;
        }
      }
    }
  }
}

_id_5336(var_0, var_1) {
  self waittill(var_0);

  foreach(var_3 in var_1) {
    var_4 = var_3["guy"];

    if(!isDefined(var_4)) {
      continue;
    }
    var_4._id_0B37--;
    var_4._id_0C47 = gettime();
  }
}

_id_17B2(var_0, var_1) {
  self endon(var_1);
  var_0 waittill("death");

  if(isDefined(var_0._id_17E7) && var_0._id_17E7) {
    return;
  }
  self notify(var_1);
}

_id_17BD(var_0, var_1, var_2) {
  self endon(var_1);
  var_3 = _func_0079(var_2);
  wait(var_3);
  self notify(var_1);
}

_id_17B3(var_0, var_1) {
  self endon(var_1);
  var_0 waittill("single dialogue");
  self notify(var_1);
}

_id_17A0(var_0, var_1, var_2, var_3) {
  self endon(var_1);
  var_0 endon("death");
  var_2 = var_2 - var_3;

  if(var_3 > 0 && var_2 > 0) {
    var_0 scripts\engine\utility::_id_108E4("single anim", "end", var_2);
    var_0 _meth_83EC();
  } else
    var_0 waittillmatch("single anim", "end");

  self notify(var_1);
}

_id_186D(var_0, var_1) {
  var_2 = level._id_CC31[var_0][var_1].size;
  var_3 = randomint(var_2);

  if(isDefined(level._id_CC31[var_0][var_1 + "weight"])) {
    var_3 = _id_6860(var_0, var_1, var_2);
  }

  return var_3;
}

_id_6860(var_0, var_1, var_2) {
  var_3 = undefined;

  if(var_2 > 1) {
    var_4 = 0;
    var_5 = 0;

    for(var_6 = 0; var_6 < var_2; var_6++) {
      if(isDefined(level._id_CC31[var_0][var_1 + "weight"])) {
        if(isDefined(level._id_CC31[var_0][var_1 + "weight"][var_6])) {
          var_4++;
          var_5 = var_5 + level._id_CC31[var_0][var_1 + "weight"][var_6];
        }
      }
    }

    if(var_4 == var_2) {
      var_7 = randomfloat(var_5);
      var_5 = 0;

      for(var_6 = 0; var_6 < var_2; var_6++) {
        var_5 = var_5 + level._id_CC31[var_0][var_1 + "weight"][var_6];

        if(var_7 < var_5) {
          var_3 = var_6;
          break;
        }
      }
    }
  }

  return var_3;
}

#using_animtree("generic_human");

_id_B1E1(var_0, var_1) {
  var_0 _meth_82E3(%addtive_head_anims, 1.0, 0.2);
  var_0 _meth_82E3(var_1, 1.0, 0.2);
  wait(_func_0079(var_1));
  var_0 _meth_8077(%addtive_head_anims, 0.2);
  var_0 _meth_8077(var_1, 0.2);
}

_id_6356(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  if(isDefined(var_0)) {
    var_1 = self gettagorigin(var_0);
    var_2 = self gettagangles(var_0);
  } else {
    var_1 = self.origin;
    var_2 = self.angles;

    if(!isDefined(var_2)) {
      var_2 = (0, 0, 0);
    }
  }

  var_3 = [];
  var_3["angles"] = var_2;
  var_3["origin"] = var_1;
  return var_3;
}

_id_17A3(var_0, var_1) {
  var_2 = [];
  var_2["guy"] = self;
  var_2["entity"] = self;
  return var_2;
}

_id_17A2(var_0, var_1) {
  var_2 = [];
  var_2["guy"] = self;
  var_2["entity"] = var_0;
  var_2["tag"] = var_1;
  return var_2;
}

_id_1CE9(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self._id_18AF;
  }

  var_2 = 0;

  if(isDefined(level._id_CC31[var_1])) {
    var_2 = 1;

    if(isDefined(level._id_CC31[var_1][var_0])) {
      return;
    }
  }

  var_3 = 0;

  if(isDefined(level._id_CC3C[var_1])) {
    var_3 = 1;

    if(isDefined(level._id_CC3C[var_1][var_0])) {
      return;
    }
  }

  var_4 = 0;

  if(isDefined(level._id_CC46[var_1])) {
    var_4 = 1;

    if(isDefined(level._id_CC46[var_1][var_0])) {
      return;
    }
  }

  var_5 = 0;

  if(isDefined(level._id_CC35[var_1])) {
    var_5 = 1;

    if(isDefined(level._id_CC35[var_1][var_0])) {
      return;
    }
  }

  if(var_2 || var_4 || var_3 || var_5) {
    if(var_2) {
      var_6 = getarraykeys(level._id_CC31[var_1]);

      foreach(var_8 in var_6) {}
    }

    if(var_4) {
      var_6 = getarraykeys(level._id_CC46[var_1]);

      foreach(var_8 in var_6) {}
    }

    if(var_3) {
      var_6 = getarraykeys(level._id_CC3C[var_1]);

      foreach(var_8 in var_6) {}
    }

    if(var_5) {
      var_6 = getarraykeys(level._id_CC35[var_1]);

      foreach(var_8 in var_6) {}
    }

    return;
  }

  var_16 = getarraykeys(level._id_CC31);
  var_16 = scripts\engine\utility::array_combine(var_16, getarraykeys(level._id_CC46));

  foreach(var_18 in var_16) {}
}

_id_1840(var_0, var_1) {}

_id_183F(var_0, var_1) {
  foreach(var_3 in var_0) {
    var_3 thread _id_1840(self, var_1);
  }
}

_id_17D5(var_0, var_1) {
  if(isDefined(level._id_CC3E[var_0]) && isDefined(level._id_CC3E[var_0][var_1])) {
    return level._id_CC3E[var_0][var_1];
  } else {
    return 0.5;
  }
}

#using_animtree("turret");

guy_pre_anim_func() {
  if(isDefined(self._id_00EC) && self._id_00EC == "misc_turret") {
    self _meth_8849(1);
    self useanimtree(#animtree);
    self.revert_to_code_animtree_when_done = 1;
  }
}

guy_post_anim_func() {
  if(isDefined(self._id_00EC) && self._id_00EC == "misc_turret") {
    self _meth_8849(0);

    if(istrue(self.revert_to_code_animtree_when_done)) {
      self _meth_83F9();
      self.revert_to_code_animtree_when_done = undefined;
    }
  }
}

guy_post_anim_func_watcher(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "dummy_endon_for_anim_loop";
  }

  if(!isDefined(var_0)) {
    var_0 = "dummy_notify_for_anim_single";
  }

  self notify("kill_anim_end_handler");
  self endon("kill_anim_end_handler");
  self endon("entitydeleted");
  var_2 = undefined;

  for(;;) {
    var_3 = scripts\engine\utility::_id_108A4(var_0, var_1, "stopanimscripted");

    if(!isDefined(var_3)) {
      if(!isDefined(self)) {
        return;
      } else {
        break;
      }
    }

    var_2 = var_3["message"];
    var_4 = undefined;

    if(isDefined(var_3[0])) {
      if(_func_0107(var_3[0])) {
        var_4 = var_3[0][0];
      } else {
        var_4 = var_3[0];
      }
    }

    if(var_2 != var_0 || isDefined(var_4) && var_4 == "end") {
      break;
    }
  }

  guy_post_anim_func();

  if(isDefined(anim._id_2F52["EntityHandleAnimScriptedEnd"]) && isDefined(var_2) && var_2 == "stopanimscripted") {
    [[anim._id_2F52["EntityHandleAnimScriptedEnd"]]](self);
  }
}