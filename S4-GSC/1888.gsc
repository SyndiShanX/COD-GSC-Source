/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1888.gsc
*************************************************/

_id_E2D6() {
  scripts\engine\utility::_id_5C11("spawn_point_score_data_init_done");
  level._id_419B = 0;
  level._id_E1E1 = [];
  level._id_F35C = 13;
  level._id_F36C = 3;
  level._id_F366 = 18;
  level._id_E2D5 = [];
  level._id_E2D5["vehicle_spawner"] = ::_id_10298;
  level._id_E2D5["cluster_spawner"] = ::_id_3A03;
  level._id_E2D5["standard_spawner"] = ::_id_E586;
  level._id_E2D3["cluster_spawner"] = 0;
  level._id_E2D4 = [];
  level._id_E2D4["vehicle_spawner"] = ::_id_10299;
  level._id_E2D4["cluster_spawner"] = ::_id_3A04;
  level._id_E2D4["standard_spawner"] = ::_id_E587;
  level._id_3216 = scripts\engine\trace::_id_3F70();
}

_id_10298(var_0, var_1, var_2, var_3) {
  if(_id_2ECA(var_0, level._id_419B)) {
    return var_0;
  } else {
    return undefined;
  }
}

_id_10299(var_0, var_1) {
  if(istrue(var_1)) {
    return 0;
  } else if(scripts\engine\utility::_id_5C0C("disable_vehicle_spawning") && scripts\engine\utility::_id_5C00("disable_vehicle_spawning")) {
    return 0;
  } else if(isDefined(var_0.vehicle) && isDefined(var_0.vehicle._id_1D81) && isDefined(var_0.vehicle._id_FE56)) {
    var_2 = var_0.vehicle._id_FE56.size;
    var_3 = undefined;

    if(isDefined(var_3)) {
      var_2 = var_3;
    }

    if(var_0.vehicle._id_1D81.size >= var_2) {
      return 0;
      return;
    }

    return 1;
    return;
  } else
    return 1;
}

_id_3A01(var_0, var_1, var_2) {
  if(isDefined(var_0._id_3577) && var_0._id_3577.size > 0) {
    var_3 = var_0._id_3577;
  } else {
    var_3 = _func_00B5(var_0.origin, 2048, 0, 256, "cover");
  }

  var_4 = 1;
  var_5 = undefined;

  if(var_4) {
    var_5 = _id_CBDB(var_3, undefined, 1, var_2, 1);
    self._id_BA09 = undefined;
  }

  var_0 _id_0743::_id_D1BD();
  var_0._id_0497 = undefined;
  var_0._id_5D6D = undefined;

  if(isDefined(var_5)) {
    _id_D185(var_0);
    var_0 thread _id_0743::_id_AE56(self, var_5);
  }

  return var_5;
}

_id_3A03(var_0, var_1, var_2, var_3) {
  if(_id_2EC8(var_0, level._id_419B)) {
    return var_0;
  } else {
    return undefined;
  }
}

_id_3A04(var_0, var_1) {
  if(istrue(var_1)) {
    return 0;
  } else {
    return 1;
  }
}

_id_E586(var_0, var_1, var_2, var_3) {
  if(_id_2EC9(var_0, level._id_419B, var_1, var_3)) {
    return var_0;
  }

  return undefined;
}

_id_6697() {
  if(isDefined(self._id_1039E) && self._id_1039E.size > 0) {
    return self._id_1039E;
  }

  return [];
}

_id_E587(var_0, var_1) {
  if(!var_0 _id_0743::_id_E2CB(32)) {
    var_2 = var_0.origin + (0, 0, 6);
    var_3 = scripts\engine\trace::_id_321A(var_2, var_2 + (0, 0, 1), 16, 32, undefined, undefined, level._id_3216);
    var_0 _id_0743::_id_1057(32);

    if(isDefined(var_3) && isDefined(var_3[0])) {
      for(var_4 = 0; var_4 < var_3.size; var_4++) {
        if(isDefined(var_3[var_4])) {
          var_5 = var_3[var_4];

          if(scripts\engine\utility::is_equal(var_5["hittype"], "hittype_world")) {
            var_0 _id_0743::_id_4A51();
            return 0;
          }
        }
      }
    }
  }

  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = 0;
  var_0 _id_0743::_id_E2CD();

  if(!_id_E2CE(var_0)) {
    return 0;
  }

  if(_id_075F::_id_408A(::_id_7525, var_0)) {
    var_10 = 0;

    if(!var_10) {
      var_0 _id_0743::_id_1057(64);
      var_0._id_904F = self._id_41A5 + 10000;
    }
  } else
    var_0 _id_0743::_id_C3DA(64);

  if(getdvarint("#x3d15084d8db81712d", 1) && !istrue(var_0._id_CD58)) {
    var_11 = _id_63C6();

    if(!isDefined(var_0._id_039D)) {
      if(isDefined(var_0._id_CD11)) {
        var_11 = var_0._id_CD11;
      }
    }

    var_12 = scripts\common\utility::_id_B7B6(var_0.origin, var_11);

    if(var_12.size > 0) {
      if(isDefined(var_0._id_CD11)) {
        var_0 thread _id_0743::_id_4A4F(var_0, undefined, self);
      } else {
        var_0._id_904F = self._id_41A5;
      }

      return 0;
    }
  }

  if(isDefined(level._id_E2D2) && level._id_E2D2.size > 0) {
    var_13 = _func_040F(level._id_E2D2, var_0.origin, 5000);

    for(var_4 = 0; var_4 < var_13.size; var_4++) {
      if(distance2d(var_0.origin, var_13[var_4].origin) < _func_0219(var_13[var_4]._id_0359)) {
        return 0;
      }
    }
  }

  if(isDefined(self._id_BA09)) {
    var_14 = _id_67D5(var_0);
    var_15 = distancesquared(self._id_BA09, var_0.origin);
    var_11 = undefined;

    if(var_15 >= var_14) {
      _id_1055(var_8, "^1CRITICAL^0: Too Far", undefined, undefined, 1, var_0);
      return 0;
    } else
      var_0._id_4B88 = var_15;
  }

  return 1;
}

_id_E2C5(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = 0;

  if(istrue(level._id_AF61)) {
    return 0;
  } else if(_id_075F::_id_408A(::_id_86C0, var_0)) {
    return 0;
  }

  if(istrue(var_1)) {
    if(_id_075F::_id_408A(::_id_84F3, var_0)) {
      return 0;
    } else if(istrue(var_0._id_8651) || isDefined(var_0._id_A5EE)) {
      if(istrue(var_0._id_8651)) {} else if(isDefined(var_0._id_A5EE)) {}

      return 0;
    } else if(_id_075F::_id_408A(::_id_8709, var_0))
      return 0;
  }

  if(_id_075F::_id_408A(::_id_8622, var_0)) {
    return 0;
  } else if(_id_075F::_id_408A(::_id_1A4A, var_0)) {
    return 0;
  } else if(!_id_075F::_id_408A(_id_075F::_id_1FBD, var_0)) {
    return 0;
  } else if(!_id_075F::_id_408A(level._id_E2D4[var_0 _id_6768()], var_0)) {
    return 0;
  } else {
    return 1;
  }
}

_id_6768() {
  if(isDefined(self._id_E2CA)) {
    if(self._id_E2CA & 2) {
      return "vehicle_spawner";
    } else if(self._id_E2CA & 4) {
      return "cluster_spawner";
    } else {
      return "standard_spawner";
    }
  } else
    return "standard_spawner";
}

_id_8709(var_0) {
  var_1 = var_0 _id_6768();

  if(isDefined(var_1)) {
    switch (var_1) {
      case "vehicle_spawner":
        return 1;
      case "cluster_spawner":
        return 0;
      case "standard_spawner":
        return 0;
    }
  }

  return 0;
}

_id_30D5(var_0) {
  if(isDefined(self._id_71F4) && isDefined(self._id_71F4._id_BA09)) {
    if(!self _meth_822C(var_0.origin, self._id_71F4._id_BA09)) {
      level thread scripts\engine\utility::_id_4EF3(var_0.origin, 16, 32, undefined, (1, 0, 0), undefined, 1000);
      var_0 _id_0743::_id_1057(512);
      return 0;
    } else
      return 1;
  } else
    return 1;
}

_id_7525(var_0) {
  if(!istrue(var_0._id_CD58)) {
    for(var_1 = 0; var_1 < level.players.size; var_1++) {
      if(level.players[var_1] _meth_861A(var_0.origin, 0, 64, 1)) {
        return 1;
      }
    }
  }

  return 0;
}

_id_8622(var_0) {
  if(isDefined(var_0._id_CD32) && isDefined(level._id_55B0)) {
    if(int(var_0._id_CD32) > int(level._id_55B0)) {
      return 1;
    } else {
      return 0;
    }
  } else
    return 0;
}

_id_1A4A(var_0) {
  if(scripts\engine\utility::_id_5472("weapons_free") && scripts\engine\utility::_id_546E("weapons_free")) {
    if(isDefined(var_0._id_CC9F)) {
      return 1;
    }
  }

  return 0;
}

_id_84F3(var_0) {
  if(var_0 _id_0743::_id_E2CB(512)) {
    return 1;
  }

  if(istrue(var_0._id_8651)) {
    var_0 _id_0743::_id_1057(512);
    return 1;
  }

  var_1 = self._id_BA09;

  if(!isvector(var_1)) {
    var_1 = self._id_BA09.origin;
  }

  if(!_func_02A6(var_0.origin, var_1)) {
    var_0 _id_0743::_id_1057(512);
    return 1;
  }

  return 0;
}

_id_86C0(var_0) {
  if(var_0 _id_0743::_id_E2CB(1024)) {
    return 1;
  } else {
    return 0;
  }
}

_id_CBEB(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_4)) {
    var_6 = [[var_1]](var_2, var_3, var_4);
  } else if(isDefined(var_3)) {
    var_6 = [[var_1]](var_2, var_3);
  } else {
    var_6 = [[var_1]](var_2);
  }

  if(!isDefined(var_6)) {
    return undefined;
  }

  if(!isDefined(var_5)) {
    var_5 = 1000;
  }

  var_7 = var_5 * var_0;
  var_6 = clamp(var_6 * var_0, 0, var_7);
  return var_6;
}

_id_6394(var_0) {
  var_1 = _id_6767();
  var_2 = _id_6429(var_1, var_0);
  level._id_419B = var_2;

  if(isDefined(level._id_419B)) {
    return var_1[level._id_419B];
  } else {
    return level._id_419B;
  }
}

_id_6728(var_0) {
  if(isDefined(level._id_7D0F)) {
    if(scripts\engine\utility::array_contains(level._id_7D0F, self._id_7218)) {
      return undefined;
    }
  }

  if(isDefined(level._id_E1E3) && level._id_E1E3.size > 0) {
    var_1 = undefined;

    if(level._id_E1E3.size > 1) {
      var_2 = _func_0204(level._id_E1E3, var_0);
    } else {
      var_2 = level._id_E1E3;
    }

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      if(distance2dsquared(var_0, var_2[var_3].origin) < var_2[var_3]._id_0F08) {
        return var_2[var_3];
      }
    }
  }

  return undefined;
}

_id_6729(var_0) {
  if(isPlayer(var_0)) {
    if(isDefined(var_0._id_1039D) && var_0 _id_DAF1()) {
      var_1 = var_0._id_1039D;
    } else {
      var_2 = anglesToForward(var_0.angles);
      var_1 = var_0.origin + var_2 * 1024;
    }
  } else
    var_1 = var_0.origin;

  return var_1;
}

_id_63F3(var_0, var_1, var_2) {
  if(!_func_0107(var_1)) {
    return var_1;
  }

  if(isDefined(var_2)) {
    return _func_040F(var_1, var_0, var_2);
  }

  return _func_0204(var_1, var_0);
}

_id_636F(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = 10;

  if(_func_0107(var_0)) {
    self._id_BA09 = self._id_E1D4;
    var_0 = _id_63F3(self._id_BA09, var_0);

    for(var_6 = 0; var_6 < var_0.size; var_6++) {
      var_7 = var_0[var_6];
      var_7 _id_0743::_id_E2CD();

      if(_id_E2C5(var_7, var_1, var_3)) {
        var_4[var_4.size] = var_7;
      }

      if(var_4.size >= var_5) {
        break;
      }
    }
  } else
    var_4[0] = var_0;

  return var_4;
}

_id_6429(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = _id_6767();
  }

  var_2 = var_0.size;

  if(var_2 <= 1) {
    return 0;
  }

  var_3 = undefined;
  var_4 = scripts\engine\utility::_id_1BD6(var_0, ::_id_E021);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = var_4[var_5];

    for(var_7 = 0; var_7 < 2; var_7++) {
      if(var_7 || istrue(var_6._id_E3E5) && !istrue(var_6.inlaststand) && !istrue(var_6.ignoreme)) {
        for(var_8 = 0; var_8 < var_0.size; var_8++) {
          if(var_0[var_8] == var_6) {
            var_3 = var_8;

            if(isPlayer(var_6)) {
              self._id_1D17 = var_3;
            } else {
              self._id_1D17 = undefined;
            }

            break;
          }
        }

        if(isDefined(var_3)) {
          break;
        }
      }
    }

    if(isDefined(var_3)) {
      break;
    }
  }

  if(!isDefined(var_3)) {
    return randomint(level.players.size);
  } else {
    return var_3;
  }
}

_id_65E3(var_0, var_1) {
  var_2 = _id_6767();
  var_3 = var_0;

  if(!istrue(var_1)) {
    var_3 = var_0 + 1;
  }

  if(isDefined(var_2[var_3])) {
    return var_3;
  } else {
    var_3++;

    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      if(isDefined(var_2[var_3])) {
        return var_3;
      }

      if(var_3 >= var_2.size) {
        var_3 = 0;
        continue;
      }

      var_3++;
    }

    return 0;
  }
}

_id_CBDB(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = _id_6394(var_4);
  self._id_DD86 = undefined;

  if(!isDefined(var_6)) {
    return undefined;
  }

  if(istrue(self._id_FDF9)) {
    var_1 = 1;
  }

  self._id_41A5 = gettime();
  var_7 = _id_6729(var_6);
  var_8 = _id_6728(var_7);
  self._id_E1D4 = var_7;
  self._id_E1D5 = var_8;
  var_9 = _id_636F(var_0, var_1, undefined, var_3);

  if(var_9.size < 1) {
    return undefined;
  }

  self._id_41A5 = gettime();
  var_10 = 1;

  if(var_10) {
    var_11 = _id_CBF3(var_9, var_2, var_3, var_0);
  } else {
    var_11 = [var_9[0]];
  }

  if(var_11.size < 1) {
    return undefined;
  }

  var_12 = undefined;

  if(var_11.size > 0) {
    var_5 = var_11[randomint(var_11.size)];
  }

  if(isDefined(var_5)) {
    if(var_5 _id_AE9F(self) && var_5 _id_AE9E() && _id_1FB9(var_5)) {
      for(var_13 = 0; var_13 < var_9.size; var_13++) {
        if(var_5 != var_9[var_13]) {
          var_9[var_13] thread _id_D3B5();
        }
      }

      return var_5;
    } else {
      var_14 = 10000;

      if(isDefined(level._id_D028)) {
        var_14 = level._id_D028;
      }

      var_5._id_904F = self._id_41A5 + var_14;
      level notify("update_spawnpoint_debug_prints");
      return undefined;
    }
  } else {
    level notify("update_spawnpoint_debug_prints");
    return undefined;
  }
}

_id_AE9E() {
  return _func_0036(self.origin + (0, 0, 6), 16, 32, undefined, 1, 1);
}

_id_1FB9(var_0) {
  if(istrue(level._id_DD9A)) {
    return 1;
  }

  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  for(var_4 = 0; var_4 < level.players.size; var_4++) {
    var_5 = level.players[var_4] _id_6697();

    if(isDefined(var_5) && var_5.size > 0) {
      for(var_6 = 0; var_6 < var_5.size; var_6++) {
        if(distance2dsquared(var_5[var_6], var_0.origin) <= 65536) {
          _id_1055(var_3, "Player Cleared", undefined, undefined, 1, var_0);
          return 0;
        }
      }
    }
  }

  return 1;
}

_id_D3B5() {
  self._id_E2C4 = 1;
  wait 2.5;
  self._id_E2C4 = undefined;
}

_id_CBF3(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = undefined;
  var_6 = 0;
  var_7 = [];
  var_8 = 0;
  var_9 = 1;

  for(var_10 = 0; var_10 < var_0.size; var_10++) {
    var_11 = var_0[var_10] _id_6768();

    if(isDefined(level._id_E2D3[var_11]) && !level._id_E2D3[var_11]) {
      var_9 = 0;
      break;
    }
  }

  for(var_10 = 0; var_10 < var_0.size; var_10++) {
    var_11 = var_0[var_10] _id_6768();
    var_12 = [[level._id_E2D5[var_11]]](var_0[var_10], undefined, var_2, var_3);

    if(isDefined(var_12)) {
      if(!isDefined(var_5) || isDefined(var_6) && isDefined(var_12._id_0497) && var_12._id_0497 > var_6) {
        var_5 = var_12;
        var_6 = var_12._id_0497;
      }

      var_8 = isDefined(var_12._id_5D6D);

      if(var_8) {
        var_7[var_7.size] = var_12;
      }

      if(var_9 && var_12._id_0497 >= 950.0) {
        if(!istrue(var_1)) {
          var_12._id_0497 = undefined;
        }

        return [var_12];
      } else if(var_12._id_0497 > 500.0) {
        if(!var_8) {
          var_4[var_4.size] = var_12;
        }

        if(var_9) {
          if(istrue(var_1)) {
            if(var_4.size >= 5) {
              return var_4;
            }
          } else
            var_12._id_0497 = undefined;
        }
      }
    }
  }

  if(var_7.size > 0) {
    var_13 = undefined;
    var_14 = -99999;
    var_15 = undefined;

    for(var_10 = 0; var_10 < var_7.size; var_10++) {
      var_16 = var_7[var_10];

      if(isDefined(var_16._id_0497) && var_16._id_0497 > var_14) {
        var_14 = var_16._id_0497;
        var_13 = var_16;
        var_15 = var_16._id_5D6D;
      }

      if(!istrue(var_1)) {
        var_16._id_0497 = undefined;
        var_16._id_5D6D = undefined;
      }
    }

    if(isDefined(var_13)) {
      var_17 = [[var_15]](var_13, undefined, var_2);

      if(isDefined(var_17)) {
        if(_func_0107(var_17)) {
          for(var_18 = 0; var_18 < var_17.size; var_18++) {
            if(var_17[var_18]._id_0497 > 500.0) {
              var_4[var_4.size] = var_17[var_18];
            }
          }
        } else if(var_17._id_0497 > 500.0)
          var_4[var_4.size] = var_17;
      }
    }
  }

  if(var_4.size > 0) {
    return var_4;
  } else if(isDefined(var_5)) {
    var_11 = var_5 _id_6768();

    if(var_11 == "cluster_spawner") {
      return [];
    } else {
      return [var_5];
    }
  } else
    return [];
}

_id_BD05(var_0, var_1, var_2) {
  self notify("print_spawnpoint_debug");
  self endon("print_spawnpoint_debug");
  var_3 = 16;
  var_4 = 16;
  var_5 = _id_6768();

  if(var_5 == "vehicle_spawner") {
    var_3 = 48;
    var_4 = 48;
  }

  if(istrue(level._id_E344)) {
    if(isDefined(var_2)) {
      level waittill(var_2);
    }

    level endon("update_spawnpoint_debug_prints");
    level endon("end_spawnpoint_debug");

    for(;;) {
      thread scripts\engine\utility::_id_4EF3(self.origin, var_3, var_4, (0, 0, 0), var_1, 0, 1);
      waitframe();
    }
  }
}

_id_AE9F(var_0) {
  if(isDefined(self) && !isvector(self)) {
    if(isDefined(self._id_CD20)) {
      var_1 = int(self._id_CD20) == 1;

      for(var_2 = 0; var_2 < level.players.size; var_2++) {
        if(_id_0762::_id_3E11(level.players[var_2].origin) == var_1) {
          if(isDefined(self._id_CD11)) {
            if(distancesquared(level.players[var_2].origin, self.origin) <= int(self._id_CD11)) {
              thread _id_0743::_id_4A4F(self, undefined, var_0);
              return 0;
            }
          } else {
            thread _id_0743::_id_4A4F(self, undefined, var_0);
            return 0;
          }
        }
      }
    } else if(isDefined(self._id_CD11)) {
      for(var_3 = 0; var_3 < level.players.size; var_3++) {
        if(distancesquared(level.players[var_3].origin, self.origin) <= int(self._id_CD11)) {
          thread _id_0743::_id_4A4F(self, undefined, var_0);
          return 0;
        }
      }
    }
  }

  return 1;
}

_id_2EC8(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = level._id_F35C;
  var_6 = 0;
  var_7 = 8;
  var_8 = _id_CBEB(var_7 / var_5, ::_id_8579, var_0, var_1);

  if(!isDefined(var_8)) {
    return 0;
  }

  var_6 = var_6 + var_8;
  var_9 = 5;
  var_10 = _id_CBEB(var_9 / var_5, ::_id_86C4, var_0, var_1);

  if(!isDefined(var_10)) {
    return 0;
  }

  var_6 = var_6 + var_10;
  var_0._id_0497 = int(var_6);
  var_0._id_5D6D = ::_id_3A01;
  return 1;
}

_id_2ECA(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = level._id_F36C;
  var_6 = 0;
  var_7 = 2;
  var_8 = _id_CBEB(var_7 / var_5, ::_id_870E, var_0, var_1, undefined, 1250);

  if(!isDefined(var_8)) {
    return 0;
  }

  var_6 = var_6 + var_8;
  var_7 = 1;
  var_8 = _id_CBEB(var_7 / var_5, ::_id_86C4, var_0, var_1);

  if(!isDefined(var_8)) {
    return 0;
  }

  var_6 = var_6 + var_8;
  var_0._id_0497 = int(var_6);
  return 1;
}

_id_2EC9(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = level._id_F366;
  var_8 = 0;
  var_9 = scripts\engine\utility::ter_op(level.gametype == "cp_pvpve", 5, 4);
  var_10 = _id_CBEB(var_9 / var_7, ::_id_86C1, var_0, var_1);

  if(!isDefined(var_10)) {
    if(istrue(var_2)) {
      var_10 = -10000;
    } else {
      return 0;
    }
  }

  var_8 = var_8 + var_10;
  var_9 = scripts\engine\utility::ter_op(level.gametype == "cp_pvpve", 10, 4);
  var_10 = _id_CBEB(var_9 / var_7, ::_id_1FA0, var_0);

  if(!isDefined(var_10)) {
    if(istrue(var_2)) {
      var_10 = -10000;
    } else {
      return 0;
    }
  }

  var_8 = var_8 + var_10;
  var_9 = scripts\engine\utility::ter_op(level.gametype == "cp_pvpve", 10, 0);
  var_10 = _id_CBEB(var_9 / var_7, ::_id_1F9F, var_0);

  if(!isDefined(var_10)) {
    if(istrue(var_2)) {
      var_10 = -10000;
    } else {
      return 0;
    }
  }

  var_8 = var_8 + var_10;
  var_9 = 5;
  var_10 = _id_CBEB(var_9 / var_7, ::_id_86C4, var_0, var_1);

  if(!isDefined(var_10)) {
    if(istrue(var_2)) {
      var_10 = -10000;
    } else {
      return 0;
    }
  }

  var_8 = var_8 + var_10;
  var_9 = 5;
  var_10 = _id_CBEB(var_9 / var_7, ::_id_10DF5, var_0);

  if(!isDefined(var_10)) {
    return 0;
  }

  var_8 = var_8 + var_10;
  var_9 = 5;
  var_10 = _id_CBEB(var_9 / var_7, ::_id_7520, var_0);

  if(!isDefined(var_10)) {
    if(istrue(var_2)) {
      var_10 = -10000;
    } else {
      return 0;
    }
  }

  var_8 = var_8 + var_10;
  var_9 = 2;
  var_10 = _id_CBEB(var_9 / var_7, ::_id_8578, var_0, var_1);

  if(!isDefined(var_10)) {
    if(istrue(var_2)) {
      var_10 = -10000;
    } else {
      return 0;
    }
  }

  var_8 = var_8 + var_10;
  var_0._id_0497 = int(var_8);
  return 1;
}

_id_8578(var_0, var_1) {
  var_2 = level.players[var_1];

  if(isDefined(self._id_E1D4)) {
    var_3 = self._id_E1D4[2];
  } else {
    var_3 = var_2.origin[2];
  }

  if(isvector(var_0)) {
    var_4 = int(abs(var_0[2] - var_3));
  } else {
    var_4 = int(abs(var_0.origin[2] - var_3));
  }

  if(var_4 <= 128) {
    return 1000;
  } else {
    return 1000 / int(var_4 / 32);
  }
}

_id_CBF1(var_0, var_1, var_2, var_3) {
  var_4 = 1000;
  var_5 = 0.707;
  var_6 = -0.5;
  var_7 = var_4 * 0.5;
  var_8 = 0;
  var_9 = 1024;
  var_10 = 262144;
  var_11 = var_1 - var_0;
  var_11 = (var_11[0], var_11[1], 0);
  var_12 = length(var_11);

  if(var_12 > 0) {
    var_11 = var_11 / var_12;
  }

  var_13 = vectordot(var_2, var_11);

  if(var_12 > var_9) {
    self._id_1541 = 1;

    if(var_13 < var_8) {
      return 0;
    } else if(var_13 * var_3 > var_12) {
      return 0;
    } else if(var_13 < var_5) {
      var_14 = 1 - (var_5 - var_13) / (var_5 - var_8);
      return var_4 * var_14;
    } else
      return var_4;
  } else {
    self._id_1541 = 0;

    if(var_13 > var_8) {
      return 0;
    } else if(var_13 > var_6) {
      var_14 = 1 - (var_6 - var_13) / (var_6 - var_8);
      return var_4 * var_14;
    } else
      return var_4;
  }

  return 0;
}

_id_86C4(var_0, var_1) {
  if(!isDefined(level._id_0F58) || level._id_0F58.size < 1) {
    self._id_DD86 = undefined;
    return 1000;
  } else {
    var_2 = level.players[var_1];
    var_3 = var_2.origin;
    var_4 = var_0.origin;
    var_5 = var_4 - var_3;
    var_5 = (var_5[0], var_5[1], 0);
    var_6 = length(var_5);

    if(var_6 > 0) {
      var_5 = var_5 / var_6;
    }

    var_7 = undefined;

    for(var_8 = 0; var_8 < level._id_0F58.size; var_8++) {
      var_9 = level._id_0F58[var_8];

      if(isDefined(var_9._id_A8E3) && var_9._id_A8E3.size > 0) {
        for(var_10 = 0; var_10 < var_9._id_A8E3.size; var_10++) {
          var_11 = var_9._id_A8E3[var_10];
          var_12 = _id_CBF1(var_3, var_11, var_5, var_6);

          if(!isDefined(var_7) || var_12 > var_7) {
            if(istrue(self._id_1541)) {
              self._id_DD86 = 1;
            } else {
              self._id_DD86 = undefined;
            }

            var_7 = var_12;
          }

          self._id_1541 = undefined;
        }
      }
    }

    if(isDefined(var_7)) {
      return var_7;
    }
  }

  self._id_DD86 = undefined;
  return 1000;
}

_id_7520(var_0) {
  if(istrue(var_0._id_E2C4)) {
    return 1000;
  } else {
    return 0;
  }
}

_id_1F9F(var_0) {
  if(isDefined(var_0._id_039D) || istrue(var_0._id_CD58) || !isDefined(level.players) || level.players.size < 1) {
    return 1000;
  }

  var_1 = 1000 / level.players.size;
  var_2 = undefined;
  var_3 = _id_6663();

  if(_id_C9CD(::_id_E345, 1, var_0)) {
    var_0._id_904F = self._id_41A5;
    return undefined;
  } else
    return var_1;
}

_id_DAF1() {
  var_0 = self._id_1039D - self.origin;
  var_0 = (var_0[0], var_0[1], 0);
  var_1 = length(var_0);

  if(var_1 > 0) {
    return 1;
  } else {
    return 0;
  }
}

_id_10DF5(var_0, var_1) {
  var_2 = 1000;

  if(isDefined(var_0._id_039D) || istrue(var_0._id_CD58) || !isDefined(level.players) || istrue(self._id_DD86) || level.players.size < 1) {
    return var_2;
  }

  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = _id_6663();

  for(var_7 = 0; var_7 < var_6.size; var_7++) {
    if(isPlayer(var_6[var_7])) {
      var_8 = var_6[var_7] getplayerangles();

      if(isDefined(var_6[var_7]._id_1039D) && var_6[var_7] _id_DAF1()) {
        var_8 = vectortoangles(var_6[var_7]._id_1039D - var_6[var_7].origin);
      }

      var_3 = var_3 + scripts\engine\math::_id_645E(var_6[var_7].origin, var_8, var_0.origin);
    } else {
      var_8 = var_6[var_7].angles;
      var_3 = var_3 + scripts\engine\math::_id_645E(var_6[var_7].origin, var_8, var_0.origin);
    }

    var_5++;
  }

  if(var_5 == 0) {
    return var_2;
  } else {
    var_4 = var_3 / var_5;
    return var_2 * var_4;
  }
}

_id_C9CD(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < level.players.size; var_4++) {
    var_5 = level.players[var_4][[var_0]](var_2, var_3);

    if(isDefined(var_1) && isDefined(var_5) && scripts\engine\utility::is_equal(var_1, var_5)) {
      return 1;
    }
  }

  return 0;
}

_id_E345(var_0, var_1) {
  if(isPlayer(self) && !scripts\cp\utility::_id_8708(1)) {
    return 0;
  }

  var_2 = _id_686C();
  var_3 = self getEye();
  var_4 = var_0.origin + (0, 0, 56);
  var_5 = scripts\engine\utility::_id_10E76(var_3, var_2, var_4, cos(65)) && _func_0202(var_3, var_4, 0, undefined, 1);
  return var_5;
}

_id_C5C9(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_1[var_3]._id_904F = var_2;
  }
}

_id_686C() {
  return self getplayerangles();
}

_id_870E(var_0, var_1) {
  var_2 = level.players;
  var_3 = level.players[var_1];
  var_4 = var_3.origin;
  var_5 = 0;
  var_6 = 1250;
  var_7 = 1250;
  var_8 = 1562500;
  var_9 = 4000;
  var_10 = 16000000;
  var_11 = 30000;
  var_12 = 900000000;
  var_13 = 0.25;

  if(isDefined(var_0._id_CDB3)) {
    var_11 = int(var_0._id_CDB3);
    var_12 = _func_0219(var_11);
  }

  var_14 = distancesquared(var_4, var_0.origin);

  if(var_14 >= var_12) {
    return undefined;
  }

  if(var_14 <= var_8) {
    return var_6;
  } else if(var_14 <= var_10) {
    var_15 = var_9 - var_7;
    var_16 = _func_0218(var_14) - var_7;
    var_17 = 1 - var_16 / var_15;
    return var_6 * var_17;
  } else if(var_14 >= var_10) {
    var_15 = var_11 - var_9;
    var_16 = _func_0218(var_14) - var_9;
    var_17 = 1 - var_16 / var_15;
    return var_6 * var_17 * var_13;
  }

  return var_5;
}

_id_8579(var_0, var_1) {
  var_2 = level.players;

  if(isDefined(self._id_E1D4)) {
    var_3 = self._id_E1D4;
  } else {
    var_3 = scripts\cp\utility::_id_63BD(var_2);
  }

  var_4 = undefined;
  var_5 = 1024;
  var_6 = 1048576;
  var_7 = 0;
  var_8 = 1000 / level.players.size;
  var_9 = 20;
  var_10 = 4194304;
  var_11 = 2048;
  var_12 = 4096;
  var_13 = 16777216;

  if(isDefined(level._id_E1E2)) {
    var_14 = level._id_E1E2;
    var_5 = _id_0743::_id_4633(var_14._id_39BC, var_5);
    var_6 = _id_0743::_id_4633(var_14._id_39BD, var_6);
    var_9 = _id_0743::_id_4633(var_14._id_5975, var_9);
    var_10 = _id_0743::_id_4633(var_14._id_5974, var_10);
    var_11 = _id_0743::_id_4633(var_14._id_5973, var_11);
    var_12 = _id_0743::_id_4633(var_14._id_F338, var_12);
    var_13 = _id_0743::_id_4633(var_14._id_F339, var_13);
  }

  if(isDefined(self._id_E1E2)) {
    var_14 = self._id_E1E2;
    var_5 = _id_0743::_id_4633(var_14._id_39BC, var_5);
    var_6 = _id_0743::_id_4633(var_14._id_39BD, var_6);
    var_9 = _id_0743::_id_4633(var_14._id_5975, var_9);
    var_10 = _id_0743::_id_4633(var_14._id_5974, var_10);
    var_11 = _id_0743::_id_4633(var_14._id_5973, var_11);
    var_12 = _id_0743::_id_4633(var_14._id_F338, var_12);
    var_13 = _id_0743::_id_4633(var_14._id_F339, var_13);
  }

  var_15 = 0.5;

  if(isDefined(var_0._id_CDB3)) {
    var_12 = int(var_0._id_CDB3);
    var_13 = _func_0219(var_12);
  }

  var_16 = distance2dsquared(var_3, var_0.origin);

  if(var_16 >= var_13) {
    return undefined;
  } else if(var_16 <= var_10 && var_16 >= var_6) {
    var_4 = var_8;
  } else if(var_16 >= var_10) {
    var_17 = 1 + var_16 / var_10;
    var_18 = var_9 / var_17;
    var_4 = var_18;
  } else {
    var_18 = var_8 * var_15;
    var_4 = var_18;
  }

  return var_4;
}

_id_86C1(var_0, var_1) {
  if(istrue(var_0._id_CD58)) {
    return 1000;
  }

  var_2 = level.players;

  if(isDefined(self._id_E1D4)) {
    var_3 = self._id_E1D4;
  } else {
    var_3 = scripts\cp\utility::_id_63BD(var_2);
  }

  var_4 = level.players[var_1];
  var_5 = undefined;
  var_6 = 1024;
  var_7 = 1048576;
  var_8 = 0;
  var_9 = 1000 / level.players.size;
  var_10 = 20;
  var_11 = 4194304;
  var_12 = 2048;
  var_13 = 4096;
  var_14 = 16777216;

  if(isDefined(level._id_E1E2)) {
    var_15 = level._id_E1E2;
    var_6 = _id_0743::_id_4633(var_15._id_39BC, var_6);
    var_7 = _id_0743::_id_4633(var_15._id_39BD, var_7);
    var_10 = _id_0743::_id_4633(var_15._id_5975, var_10);
    var_11 = _id_0743::_id_4633(var_15._id_5974, var_11);
    var_12 = _id_0743::_id_4633(var_15._id_5973, var_12);
    var_13 = _id_0743::_id_4633(var_15._id_F338, var_13);
    var_14 = _id_0743::_id_4633(var_15._id_F339, var_14);
  }

  if(isDefined(self._id_E1E2)) {
    var_15 = self._id_E1E2;
    var_6 = _id_0743::_id_4633(var_15._id_39BC, var_6);
    var_7 = _id_0743::_id_4633(var_15._id_39BD, var_7);
    var_10 = _id_0743::_id_4633(var_15._id_5975, var_10);
    var_11 = _id_0743::_id_4633(var_15._id_5974, var_11);
    var_12 = _id_0743::_id_4633(var_15._id_5973, var_12);
    var_13 = _id_0743::_id_4633(var_15._id_F338, var_13);
    var_14 = _id_0743::_id_4633(var_15._id_F339, var_14);
  }

  var_16 = 0.5;

  if(isDefined(var_0._id_CDB3)) {
    var_13 = int(var_0._id_CDB3);
    var_14 = _func_0219(var_13);
  }

  if(isDefined(var_13) && isDefined(var_0)) {
    var_17 = 0;

    if(isvector(var_0)) {
      var_17 = scripts\common\utility::_id_B7C7(var_0, var_13);
    } else {
      var_17 = scripts\common\utility::_id_B7C7(var_0.origin, var_13);
    }

    if(var_17.size < 1) {
      return undefined;
    }
  }

  if(isDefined(var_0._id_7C8F)) {
    var_18 = var_0._id_7C8F;
    var_19 = var_0._id_7C8F * var_0._id_7C8F;
  } else {
    var_18 = (var_12 + var_6) / 2;
    var_19 = var_18 * var_18;
  }

  if(isDefined(var_0._id_4B88)) {
    var_20 = var_0._id_4B88;
    var_0._id_4B88 = undefined;
  } else
    var_20 = distancesquared(var_3, var_0.origin);

  if(var_20 <= var_11 && var_20 >= var_7) {
    return var_9;
  } else if(var_20 >= var_11) {
    var_21 = 1 + var_20 / var_11;
    var_22 = var_10 / var_21;
    return var_22;
  } else {
    var_22 = var_9 * var_16;
    return var_22;
  }

  return var_8;
}

_id_1FA0(var_0) {
  var_1 = 1000;

  if(isDefined(var_0._id_904F)) {
    var_2 = self._id_41A5 - var_0._id_904F;
    var_3 = _id_66F6();

    if(var_2 > var_3) {
      return var_1;
    }

    var_4 = var_2 / var_3;
    return int(var_4 * var_1);
  }

  return var_1;
}

_id_E2CE(var_0, var_1) {
  if(!isDefined(var_0._id_904F)) {
    var_0._id_904F = self._id_41A5;
    return 1;
  }

  var_1 = self._id_41A5 - var_0._id_904F;
  var_2 = _id_66F6();
  var_3 = var_1 / var_2;

  if(var_3 <= 0.5) {
    return 0;
  } else {
    return 1;
  }
}

_id_66F6() {
  if(isDefined(self._id_C0EB)) {
    return self._id_C0EB;
  } else {
    return 20000;
  }
}

_id_E021(var_0, var_1) {
  if(isDefined(var_0._id_1D16) && isDefined(var_1._id_1D16)) {
    return var_0._id_1D16 < var_1._id_1D16;
  } else {
    return 0;
  }
}

_id_6767() {
  if(isDefined(level.players) && level.players.size > 0) {
    return scripts\cp\utility::_id_636E();
  } else {
    return [];
  }
}

_id_63C6(var_0) {
  var_1 = 1024;
  var_2 = 1048576;

  if(isDefined(self._id_E1E2)) {
    if(istrue(var_0)) {
      return _id_0743::_id_4633(self._id_E1E2._id_39BD, var_2);
    } else {
      return _id_0743::_id_4633(self._id_E1E2._id_39BC, var_1);
    }
  } else if(isDefined(level._id_E1E2)) {
    if(istrue(var_0)) {
      return _id_0743::_id_4633(level._id_E1E2._id_39BD, var_2);
    } else {
      return _id_0743::_id_4633(level._id_E1E2._id_39BC, var_1);
    }
  } else if(istrue(self._id_3E30)) {
    if(istrue(var_0)) {
      return 110889;
    } else {
      return 333;
    }
  } else if(istrue(var_0))
    return var_2;
  else {
    return var_1;
  }
}

_id_6663() {
  var_0 = level.players;
  return var_0;
}

_id_BD04(var_0) {
  self._id_CBEF = undefined;
}

_id_3EF4(var_0, var_1) {
  if(getdvarint("#x3a7c5959b8819f775")) {
    var_2 = _id_6768();

    if(var_2 == "vehicle_spawner") {
      return;
    }
    var_3 = spawn("script_model", self.origin);

    if(!isDefined(var_0._id_E2C7)) {
      var_0._id_E2C7 = [];
    }

    var_0._id_E2C7[var_0._id_E2C7.size] = var_3;

    if(isDefined(self.angles)) {
      var_3.angles = self.angles;
    }

    switch (var_2) {
      case "cluster_spawner":
        var_3 setModel("com_teddy_bear");
        break;
      default:
        var_3 setModel("british_pilot_fullbody");
        break;
    }

    _id_074A::_id_5210(var_3, level.players, var_1);
  }
}

_id_1055(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(getdvarint("#x3ea5fc3516afefcbb", 0)) {
    if(isDefined(var_5)) {
      if(!isDefined(var_5._id_F91C)) {
        _id_637D(var_5);
      }

      var_6 = var_5._id_F91C;
    } else
      var_6 = _id_637D();

    if(!isDefined(self._id_CBEF)) {
      _id_3F67();
    }

    self._id_CBF0[var_6] = var_5;

    if(istrue(var_3) || !isDefined(var_0)) {
      var_0 = "";
    }

    if(!isDefined(var_2)) {
      var_2 = "";
    }

    if(!isDefined(var_1)) {
      var_1 = "";
    }

    if(var_0.size > 0 || var_1.size > 0) {
      var_1 = "|" + var_1;
    }

    var_1 = var_0 + "^0" + var_1 + "^5" + var_2;

    if(istrue(var_4)) {
      self._id_CBEF[var_6] = var_1;
    }

    return var_1;
  }
}

_id_3F67() {
  if(getdvarint("#x3ea5fc3516afefcbb", 0)) {
    self._id_CBEF = [];
    self._id_CBF0 = [];
    var_0 = self._id_7218;

    if(!isDefined(var_0)) {
      var_0 = "";
    }

    var_1 = "^7#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#^0" + var_0 + "^7#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#";
    _id_1055(undefined, var_1, undefined, undefined, 1);
  }
}

_id_637D(var_0) {
  if(!isDefined(self._id_41A6)) {
    self._id_41A6 = 0;
  }

  if(isDefined(var_0)) {
    var_0._id_F91C = self._id_41A6;
  }

  var_1 = self._id_41A6;
  self._id_41A6++;
  return var_1;
}

_id_67FB() {
  if(isDefined(self._id_F91C)) {
    return self._id_F91C;
  } else {
    return undefined;
  }
}

_id_D185(var_0) {
  if(getdvarint("#x3ea5fc3516afefcbb", 0)) {
    var_1 = var_0 _id_67FB();
    var_0._id_36EB = 1;

    if(isDefined(var_1)) {
      var_2 = self._id_CBEF[var_1];

      if(isDefined(var_2)) {
        var_2 = "^5CHOSEN: " + var_2;
        self._id_CBEF[var_1] = var_2;
      }
    }
  }
}

_id_67D5(var_0) {
  var_1 = 16777216;

  if(isDefined(level._id_E1E2)) {
    var_2 = level._id_E1E2;
    var_1 = _id_0743::_id_4633(var_2._id_F339, var_1);
  } else if(isDefined(self._id_E1E2)) {
    var_2 = self._id_E1E2;
    var_1 = _id_0743::_id_4633(var_2._id_F339, var_1);
  }

  if(isDefined(var_0._id_CDB3)) {
    var_3 = int(var_0._id_CDB3);
    var_1 = _func_0219(var_3);
  }

  return var_1;
}