/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1362.gsc
**************************************/

init() {
  level._id_ABD1 = [];

  for(var_0 = 0; var_0 < 4; var_0++) {
    var_1 = spawnStruct();
    var_1._id_4DBA = 0;
    var_1._id_2903 = undefined;
    var_1._id_A902 = [];
    level._id_ABD1 = common_scripts\utility::_id_0F6F(level._id_ABD1, var_1);
  }

  level._id_47DF = [];
  level thread _id_540F();
}

_id_540F() {
  for(;;) {
    level waittill("connected", var_0);
    level thread _id_09B1(var_0);
    level thread _id_A151(var_0);
    level thread _id_540E(var_0);
  }
}

_id_09B1(var_0) {
  var_1 = var_0 getentitynumber();
  var_2 = level._id_ABD1[var_1];

  foreach(var_4 in level._id_47DF)
  var_2._id_A902 = common_scripts\utility::_id_0F6F(var_2._id_A902, var_4);
}

_id_540E(var_0) {
  var_1 = var_0 getentitynumber();
  var_0 waittill("disconnect");
  _id_2391(var_1);
}

_id_2391(var_0) {
  var_1 = level._id_ABD1[var_0];
  var_1._id_4DBA = 0;
  var_1._id_2903 = undefined;
  var_1._id_A902 = [];

  foreach(var_3 in level._id_47DF) {
    var_3._id_9FD3.refresh_internal_times_per_player[var_0] = undefined;
    var_3._id_9FD3.disabled_internal_per_player[var_0] = undefined;
  }
}

_id_7BFE(var_0, var_1, var_2, var_3) {
  return _id_7BF4(var_0, 1, var_1, var_2, var_3);
}

_id_7BF3(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 1;

  return _id_7BF4(var_0, 2, var_1, var_2, var_3);
}

_id_7BED(var_0, var_1) {
  return _id_7BF4(var_0, 3, var_1, 0);
}

_id_7BFC(var_0) {
  return _id_7BE4(4, var_0, 0);
}

_id_7BDD(var_0) {
  return _id_7BE4(5, var_0, 0);
}

_id_7BE1(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    var_2 = 0;

  if(isDefined(var_0))
    return _id_7BF4(var_0, 6, var_1, var_2, var_3, var_4);
  else
    return _id_7BE4(6, var_1, var_2, var_3, var_4);
}

_id_7BE4(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_2823(var_0, var_1, var_2, var_3, var_4);
  level._id_47DF = common_scripts\utility::_id_0F6F(level._id_47DF, var_5);
  level thread maps\mp\_utility::_id_6F74(::_id_09E2, var_5);
  return var_5._id_9FD3;
}

_id_09E2(var_0) {
  var_1 = self getentitynumber();
  var_2 = level._id_ABD1[var_1];
  var_2._id_A902 = common_scripts\utility::_id_0F6F(var_2._id_A902, var_0);
}

_id_7BF4(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_2823(var_1, var_2, var_3, var_4, var_5);
  var_0 _id_09E2(var_6);
  return var_6._id_9FD3;
}

_id_2823(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.type = var_0;
  var_5._id_9D65 = var_1;
  var_5._id_6641 = var_2;

  if(!isDefined(var_3))
    var_3 = var_1.origin;

  if(!isDefined(var_4))
    var_4 = 250;

  var_5._id_5EB5 = var_3;
  var_5.radial_progress_time = var_4;
  var_6 = spawnStruct();

  if(var_0 == 1) {
    var_6._id_A9B4 = undefined;
    var_6._id_A9A5 = 0;
  } else if(var_0 == 2) {
    var_6._id_6F58 = undefined;
    var_6._id_6F56 = 0;
  } else if(var_0 == 3) {
    var_6._id_1B73 = 0;
    var_6._id_1B74 = undefined;
    var_6._id_1B6F = 0;
    var_6._id_1B72 = undefined;
  } else if(var_0 == 4) {
    var_6._id_9CCA = 0;
    var_6._id_9C9D = 0;
    var_6._id_9CBE = 0;
    var_6._id_9C9B = 0;
  } else if(var_0 == 5) {
    var_6._id_3264 = 0;
    var_6._id_3259 = 0;
  } else if(var_0 == 6) {
    var_6._id_4028 = 0;
    var_6._id_401E = 0;
  }

  var_6._id_6642 = 0;
  var_6._id_2F74 = 0;
  var_6._id_0C13 = 0;
  var_6.refresh_internal_time = 0;
  var_6.refresh_internal_times_per_player = [];
  var_6.disabled_internal_per_player = [];
  var_5._id_9FD3 = var_6;
  return var_5;
}

_id_44FF(var_0) {
  var_1 = tablelookup("mp/zombieInteractTable.csv", 2, var_0, 1);
  return int(var_1);
}

_id_267D(var_0, var_1) {
  if(isDefined(var_1))
    return var_1;

  return var_0;
}

_id_8C05(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = 0;
  var_5 = var_0 getentitynumber();
  markrefreshed(var_5, var_1);

  if(var_1.type == 1 && isDefined(var_1._id_9FD3._id_A9B4)) {
    var_6 = _func_1B1("mp/zombieInteractTable.csv", 2, var_1._id_9FD3._id_A9B4);
    var_7 = int(_func_1AE("mp/zombieInteractTable.csv", var_6, 0));
    var_8 = int(_func_1AE("mp/zombieInteractTable.csv", var_6, 1));
    var_3 = var_7 | var_8 << 4;
    var_4 = _id_267D(var_1._id_9FD3._id_A9A5, var_2);
  } else if(var_1.type == 2 && isDefined(var_1._id_9FD3._id_6F58)) {
    var_6 = _func_1B1("mp/zombieInteractTable.csv", 2, var_1._id_9FD3._id_6F58);
    var_7 = int(_func_1AE("mp/zombieInteractTable.csv", var_6, 0));
    var_8 = int(_func_1AE("mp/zombieInteractTable.csv", var_6, 1));
    var_3 = var_7 | var_8 << 4;
    var_4 = _id_267D(var_1._id_9FD3._id_6F56, var_2);
  } else if(var_1.type == 3 && var_1._id_9FD3._id_1B73 != 0) {
    var_6 = _func_1B1("mp/zombieInteractTable.csv", 2, "mysterybox");
    var_7 = int(_func_1AE("mp/zombieInteractTable.csv", var_6, 0));
    var_8 = 0;

    if(var_1._id_9FD3._id_1B73 == 2) {
      var_9 = _func_1B1("mp/zombieInteractTable.csv", 2, var_1._id_9FD3._id_1B74);
      var_8 = int(_func_1AE("mp/zombieInteractTable.csv", var_9, 1));
    }

    var_3 = var_7 | var_8 << 4;
    var_4 = _id_267D(var_1._id_9FD3._id_1B6F, var_2) | var_1._id_9FD3._id_1B73 << 16;
  } else if(var_1.type == 4) {
    var_7 = 4;
    var_10 = var_1._id_9FD3._id_9CCA;
    var_11 = var_1._id_9FD3._id_9CBE;
    var_12 = var_1._id_9FD3._id_9C9B;
    var_3 = var_7 | var_10 << 4 | var_11 << 8;
    var_4 = _id_267D(var_1._id_9FD3._id_9C9D, var_2) | var_12 << 16;
  } else if(var_1.type == 5) {
    var_7 = 5;
    var_3 = var_7 | var_1._id_9FD3._id_3264 << 4;
    var_4 = _id_267D(var_1._id_9FD3._id_3259, var_2);
  } else if(var_1.type == 6) {
    var_7 = 6;
    var_3 = var_7 | var_1._id_9FD3._id_4028 << 4;
    var_4 = _id_267D(var_1._id_9FD3._id_401E, var_2);
  }

  var_0 _meth_82FF("ui_zm_interaction_flags", var_3);
  var_0 _meth_82FF("ui_zm_interaction_data", var_4);
}

hideinteractprompt(var_0, var_1) {
  var_0 _meth_866C(&"stop_progressive_interact", 0);
  var_0 _meth_866C(&"remove_progressive_interact", 0);
  var_1._id_4DBA = 0;
  var_1._id_4DB6 = undefined;
  var_0 _meth_82FF("ui_zm_interaction_flags", 0);
}

_id_4205(var_0, var_1, var_2) {
  if(isDefined(var_2))
    var_3 = var_2 - var_0 getEye();
  else
    var_3 = var_1.origin - var_0 getEye();

  var_4 = vectorNormalize((var_3[0], var_3[1], 0));
  var_5 = anglesToForward(var_0.angles);
  var_6 = vectorNormalize((var_5[0], var_5[1], 0));
  var_7 = vectordot(var_4, var_6);
  var_8 = _func_0AA(clamp(var_7, -1, 1));
  return var_8;
}

_id_990A(var_0) {
  var_1 = var_0 < 60;
  return var_1;
}

_id_55E2(var_0, var_1, var_2) {
  var_3 = _id_4205(var_0, var_1, var_2);
  var_4 = _id_990A(var_3);
  return var_4;
}

_id_21B8(var_0, var_1) {
  if(var_1.type == 3) {
    var_2 = var_1._id_9FD3._id_1B72 _id_0548::_id_43FF(var_0);

    if(var_1._id_9FD3._id_1B6F != var_2)
      return int(var_2);
  } else if(var_1.type == 5) {
    var_3 = var_0 _id_0577::_id_4687();

    if(var_3 != 1)
      return int(var_3 * var_1._id_9FD3._id_3259);
  }

  return undefined;
}

check_for_door_power(var_0, var_1) {
  while(var_0._id_4DBA) {
    var_2 = var_1._id_3276 _id_053F::_id_3278() && !var_1._id_3276 _id_053F::_id_3262();

    if(var_2) {
      wait 0.25;
      continue;
    }

    break;
  }
}

check_if_perk_empty(var_0, var_1) {
  while(var_0._id_4DBA) {
    var_2 = var_1._id_9FD3._id_6F58;

    if(var_2 == "lost_and_found_empty") {
      wait 0.25;
      continue;
    }

    break;
  }
}

check_if_trap_ready(var_0, var_1) {
  while(var_0._id_4DBA) {
    var_2 = var_1._id_9FD3._id_9CCA;

    if(var_2 != 3) {
      wait 0.25;
      continue;
    }

    break;
  }
}

check_progressive_interact_input(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = 1;
  var_5 = var_1._id_9D65;

  while(var_0._id_4DBA) {
    if(common_scripts\utility::_id_562E(var_1._id_9FD3.interact_disabled)) {
      if(var_2 == 1) {
        self _meth_866C(&"stop_progressive_interact", 0);
        self _meth_866C(&"remove_progressive_interact", 0);
        var_2 = 0;
      }

      waitframe();
      continue;
    }

    if(!isDefined(self.interactneedrelease) || !self _meth_8341())
      self.interactneedrelease = 0;

    var_4 = self _meth_8341() && !self.interactneedrelease;

    if(!var_3) {
      if(var_4) {
        self _meth_866C(&"start_progressive_interact", 1, var_1.radial_progress_time);
        var_3 = 1;
        var_2 = 1;
      }
    } else if(!var_4) {
      self _meth_866C(&"stop_progressive_interact", 0);
      var_3 = 0;
    }

    waitframe();
  }

  self _meth_866C(&"stop_progressive_interact", 0);
  self _meth_866C(&"remove_progressive_interact", 0);
}

_id_A151(var_0) {
  var_0 endon("disconnect");
  var_1 = var_0 getentitynumber();
  var_2 = level._id_ABD1[var_1];

  for(;;) {
    refreshplayerinteractprompts(var_0, var_2);
    var_3 = var_0 _meth_84D1(1);

    if(var_2._id_4DBA) {
      if(!isDefined(var_3) || var_2._id_2903._id_9D65 != var_3)
        hideinteractprompt(var_0, var_2);
      else {
        var_4 = _id_21B8(var_0, var_2._id_2903);
        var_5 = needsrefresh(var_1, var_2._id_2903);

        if(var_5 || isDefined(var_4)) {
          var_0 _meth_866C(&"add_progressive_interact", 1, var_2._id_2903._id_9D65);
          _id_8C05(var_0, var_2._id_2903, var_4);
        }
      }
    } else if(isDefined(var_3)) {
      for(var_6 = 0; var_6 < var_2._id_A902.size; var_6++) {
        var_7 = var_2._id_A902[var_6];

        if(var_7._id_9D65 == var_3) {
          var_2._id_4DBA = 1;
          var_2._id_2903 = var_7;
          var_4 = _id_21B8(var_0, var_2._id_2903);
          var_0 _meth_866C(&"add_progressive_interact", 1, var_7._id_9D65);
          _id_8C05(var_0, var_7, var_4);
          var_0 childthread check_progressive_interact_input(var_2, var_7);
          break;
        }
      }
    }

    waitframe();
  }
}

needsrefresh(var_0, var_1) {
  var_2 = var_1._id_9FD3.refresh_internal_times_per_player[var_0];

  if(!isDefined(var_2) || var_2 < var_1._id_9FD3.refresh_internal_time)
    return 1;

  return 0;
}

markrefreshed(var_0, var_1) {
  var_1._id_9FD3.refresh_internal_times_per_player[var_0] = var_1.refresh_internal_time;
}

refreshplayerinteractprompts(var_0, var_1) {
  var_2 = var_0 getentitynumber();

  for(var_3 = 0; var_3 < var_1._id_A902.size; var_3++) {
    var_4 = var_1._id_A902[var_3];

    if(var_4._id_9FD3._id_6642) {
      var_4._id_9FD3._id_6642 = 0;
      var_4._id_9FD3.refresh_internal_time = gettime();
    }

    var_5 = needsrefresh(var_2, var_4);
    var_6 = 0;
    var_6 = var_6 | common_scripts\utility::_id_562E(var_4._id_9FD3._id_2F74);

    if(var_5) {
      if(common_scripts\utility::_id_562E(var_4._id_6641)) {
        var_4._id_9D65 _meth_8660(1, var_4._id_5EB5);
        var_4._id_9D65 _meth_8177(0);
      }

      if(!isDefined(var_1._id_2903) || var_4 != var_1._id_2903)
        markrefreshed(var_2, var_4);
    }

    if(common_scripts\utility::_id_562E(var_4._id_9FD3.require_standing)) {
      switch (var_0 _meth_8178()) {
        case "crouch":
        case "prone":
          var_6 = var_6 | 1;
          break;
      }
    }

    if(!_id_0547::_id_5565(var_4._id_9FD3.disabled_internal_per_player[var_2], var_6)) {
      var_4._id_9FD3.disabled_internal_per_player[var_2] = var_6;

      if(var_6) {
        var_4._id_9D65 disableplayeruse(var_0);
        continue;
      }

      var_4._id_9D65 enableplayeruse(var_0);
    }
  }
}