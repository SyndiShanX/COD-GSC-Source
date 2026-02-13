/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2217.gsc
*************************************************/

_id_7FBC() {
  if(!isDefined(level._id_7BBD)) {
    level._id_7BBD = spawnStruct();
    _id_81B0();
  }

  if(isDefined(level._id_0408)) {
    level._id_0408._id_7BC5 = level._id_7BBD._id_7BC5;
    level._id_7BBD = undefined;
  }
}

_id_5AFC(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  var_4 = var_2;
  var_5 = var_0;
  var_6 = min(var_1._id_24E6, 3);
  var_7 = 48 * (1 + var_6);
  var_8 = 84 * (1 + var_6);

  while(var_3 && var_4 < var_1._id_C94F.size || !var_3 && var_4 >= 0) {
    var_9 = var_1._id_C94F[var_4].origin;
    var_10 = _id_0843::_id_6917(var_5, var_9, var_1, undefined, var_7, var_8, 0);

    if(isDefined(var_10)) {
      var_11 = var_5;

      if(var_3 && var_4 - 1 >= 0) {
        var_11 = var_1._id_C94F[var_4 - 1].origin;
      } else if(!var_3 && var_4 + 1 < var_1._id_C94F.size) {
        var_11 = var_1._id_C94F[var_4 + 1].origin;
      }

      var_12 = var_9 - var_11;
      var_13 = length(var_12);
      var_12 = var_12 / var_13;
      var_14 = var_4 == var_2 && (var_2 == 0 && var_3 || var_2 == var_1._id_C94F.size && !var_3);

      if(var_14 || vectordot(var_12, var_10.origin - var_11) > var_13 - 24) {
        if(var_3) {
          return [var_10, var_4 + 1];
        } else {
          return [var_10, var_4 - 1];
        }
      }

      return [var_10, var_4];
    }

    var_15 = distance2d(var_5, var_9);
    var_7 = max(var_7 - var_15, 0);
    var_8 = max(var_8 - var_15, 0);
    var_5 = var_9;

    if(var_3) {
      var_4++;
      continue;
    }

    var_4--;
  }
}

_id_5AE8(var_0, var_1) {
  var_2 = var_1.size;
  var_3 = 0;
  var_4 = -1;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    var_6 = (var_5 + 1) % var_2;
    var_7 = var_1[var_6].origin - var_1[var_5].origin;
    var_8 = length(var_7);
    var_7 = var_7 / var_8;
    var_9 = var_0 - var_1[var_5].origin;
    var_10 = vectordot(var_7, var_9);

    if(var_3 > 0 && (var_10 < 0 || var_10 > var_8)) {
      continue;
    }
    var_11 = (var_7[1], -1 * var_7[0], 0);
    var_11 = vectornormalize(var_11);
    var_12 = abs(vectordot(var_11, var_9));

    if(var_3 <= 0 || var_12 < var_3) {
      var_3 = var_12;
      var_4 = var_6;
    }
  }

  return var_4;
}

_id_6CE8(var_0) {
  var_1 = 1000000000;
  var_2 = undefined;
  var_3 = level._id_0408._id_7BC5[self._id_CE6D];

  if(!isDefined(var_3)) {
    return undefined;
  }

  foreach(var_5 in var_3._id_7BBE) {
    if(!isDefined(self._id_CE6D) || self._id_CE6D != var_5._id_E7AE) {
      continue;
    }
    if(_func_011A(var_0, var_5._id_106A1)) {
      return var_5;
    }

    var_6 = _func_0135(var_5._id_19FD - self.origin);

    if(var_6 < var_1) {
      var_1 = var_6;
      var_2 = var_5;
    }
  }

  return var_2;
}

_id_6AAE(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = strtok(var_3._id_CE6D, " ");

    foreach(var_6 in var_4) {
      var_1[var_1.size] = var_6;
    }
  }

  return scripts\engine\utility::_id_1BC1(var_1);
}

_id_6AAD() {
  var_0 = [];

  foreach(var_2 in level._id_EA6A) {
    if(isDefined(var_2._id_CE6C) && var_2._id_CE6C == 1) {
      var_3 = var_2;
      var_3._id_F49D = [];
      var_4 = var_0.size;
      var_3.index = var_4;
      var_0[var_4] = var_3;
    }
  }

  return var_0;
}

_id_6AAF(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    var_2[var_4] = [];

    foreach(var_6 in var_1) {
      if(issubstr(var_6._id_CE6D, var_4)) {
        var_7 = var_2[var_4].size;
        var_2[var_4][var_7] = var_6;
      }
    }
  }

  return var_2;
}

_id_2CFF() {
  foreach(var_20, var_1 in level._id_7BBD._id_7BC5) {
    foreach(var_3 in var_1._id_7BBE) {
      var_4 = [];

      foreach(var_16, var_6 in var_3._id_F48E) {
        var_7 = var_3._id_E7AE;
        var_8 = var_6 scripts\engine\utility::_id_655C();

        foreach(var_10 in var_8) {
          foreach(var_12 in var_10._id_3BD6) {
            if(var_12._id_E7AE == var_7) {
              var_13 = var_6._id_F49D.size;
              var_6._id_F49D[var_13] = var_10;

              if(!isDefined(var_10._id_F49D)) {
                var_10._id_F49D = [];
              }

              if(!scripts\engine\utility::array_contains(var_10._id_F49D, var_6)) {
                var_13 = var_10._id_F49D.size;
                var_10._id_F49D[var_13] = var_6;
              }

              if(!scripts\engine\utility::array_contains(var_12._id_F48E, var_10)) {
                var_13 = var_12._id_F48E.size;
                var_12._id_F48E[var_13] = var_10;
              }

              break;
            }
          }
        }

        if(var_6._id_F49D.size == 0) {
          var_4[var_4.size] = var_16;
        }
      }

      foreach(var_16 in var_4) {
        scripts\engine\utility::array_remove_index(var_3._id_F48E, var_16, 0);
      }
    }
  }
}

_id_2CFE() {
  foreach(var_23, var_1 in level._id_7BBD._id_7BC5) {
    foreach(var_3 in var_1._id_7BBE) {
      var_3._id_C1C0 = [];

      foreach(var_5 in var_3._id_F48E) {
        foreach(var_7 in var_5._id_F49D) {
          var_8 = undefined;

          foreach(var_10 in var_7._id_3BD6) {
            if(var_10._id_E7AE == var_3._id_E7AE) {
              var_8 = var_10;
              break;
            }
          }

          if(!isDefined(var_8)) {
            continue;
          }
          var_12 = spawnStruct();
          var_12._id_C1BF = var_8;
          var_12._id_F48D = var_5;
          var_12._id_F48F = var_7;
          var_13 = var_3._id_C1C0.size;
          var_3._id_C1C0[var_13] = var_12;
        }
      }
    }

    foreach(var_3 in var_1._id_7BBE) {
      if(var_3._id_C94F.size == 0) {
        continue;
      }
      if(var_3._id_C94F.size == 1) {
        var_3._id_19FD = var_3._id_C94F[0].origin;
        continue;
      }

      var_18 = 0;
      var_19 = 0;
      var_20 = 1;

      for(var_20 = 1; var_20 < var_3._id_C94F.size; var_20++) {
        var_19 = length(var_3._id_C94F[var_20].origin - var_3._id_C94F[var_20 - 1].origin);
        var_18 = var_18 + var_19;
      }

      var_18 = var_18 * 0.5;

      for(var_20 = 0; var_20 < var_3._id_C94F.size - 1; var_20++) {
        var_19 = length(var_3._id_C94F[var_20].origin - var_3._id_C94F[var_20 + 1].origin);

        if(var_18 - var_19 < 0) {
          break;
        }

        var_18 = var_18 - var_19;
      }

      var_21 = var_18 / var_19;
      var_3._id_19FD = _func_025E(var_3._id_C94F[var_20].origin, var_3._id_C94F[var_20 + 1].origin, var_21);
    }
  }
}

_id_388A(var_0) {
  foreach(var_2 in var_0) {
    var_2._id_3BD6 = undefined;
    var_2._id_F49D = undefined;
  }

  foreach(var_9, var_5 in level._id_7BBD._id_7BC5) {
    foreach(var_7 in var_5._id_7BBE) {
      var_7._id_F48E = undefined;
    }
  }
}

_id_81B0() {
  var_0 = getEntArray("info_volume_stealth_clear", "classname");
  var_1 = _id_6AAE(var_0);
  var_2 = _id_6AAD();
  var_3 = [];
  var_4 = _id_6AAF(var_1, var_0);
  level._id_7BBD._id_7BC5 = [];

  foreach(var_36, var_6 in var_4) {
    level._id_7BBD._id_7BC5[var_36] = spawnStruct();
    level._id_7BBD._id_7BC5[var_36]._id_7BBE = [];
    level._id_7BBD._id_7BC5[var_36]._id_EE8F = 0.0;

    foreach(var_19, var_8 in var_6) {
      var_9 = spawnStruct();
      var_9._id_106A1 = var_8;
      var_9.index = var_19;
      var_9._id_19FD = (0, 0, 0);
      var_9._id_24E6 = 100000;
      var_9._id_24E7 = 100000;
      var_9._id_3D06 = 20000;
      var_10 = var_3[var_8 getentitynumber()];

      if(!isDefined(var_10)) {
        var_10 = spawnStruct();
        var_10._id_24E4 = 0;
        var_10._id_9C19 = 2;
        var_10._id_24E5 = 0;
        var_10._id_7D73 = 0;
        var_10._id_B4F1 = 0;
        var_10._id_1D13 = 0;
        var_3[var_8 getentitynumber()] = var_10;
      }

      var_9._id_D9B3 = var_10;

      if(isDefined(var_8._id_CCEA)) {
        var_10._id_9C19 = var_8._id_CCEA;
      }

      if(isDefined(var_8._id_CE86)) {
        var_10._id_3D06 = var_8._id_CE86;
      }

      var_9._id_E7AE = var_36;
      var_9._id_C94F = [];
      var_9._id_F48E = [];

      foreach(var_12 in var_2) {
        if(_func_011A(var_12.origin, var_8)) {
          var_13 = var_9._id_C94F.size;
          var_9._id_C94F[var_13] = var_12;

          if(!isDefined(var_12._id_3BD6)) {
            var_12._id_3BD6 = [];
          }

          var_13 = var_12._id_3BD6.size;
          var_12._id_3BD6[var_13] = var_9;
          var_14 = var_12 scripts\engine\utility::_id_655C();

          if(var_14.size != 0) {
            var_13 = var_9._id_F48E.size;
            var_9._id_F48E[var_13] = var_12;
          }
        }
      }

      if(var_9._id_C94F.size == 0) {}

      var_9._id_DE15 = [];

      foreach(var_17 in anim._id_DE28) {
        if(_func_011A(var_17.origin, var_8)) {
          var_13 = var_9._id_DE15.size;
          var_9._id_DE15[var_13] = var_17;
        }
      }

      var_13 = level._id_7BBD._id_7BC5[var_36]._id_7BBE.size;
      level._id_7BBD._id_7BC5[var_36]._id_7BBE[var_13] = var_9;
    }

    foreach(var_9 in level._id_7BBD._id_7BC5[var_36]._id_7BBE) {
      if(var_9._id_C94F.size == 0) {
        continue;
      }
      var_21 = -1;

      for(var_22 = 0; var_22 < var_9._id_C94F.size; var_22++) {
        var_12 = var_9._id_C94F[var_22];
        var_23 = var_12._id_0481;

        if(!isDefined(var_23)) {
          if(var_21 != -1) {
            var_24 = var_12.origin;
          }

          var_21 = var_22;
          continue;
        }

        var_25 = undefined;

        foreach(var_27 in var_9._id_C94F) {
          if(isDefined(var_27.target) && var_27.target == var_23) {
            var_25 = var_27;
          }
        }

        if(!isDefined(var_25)) {
          if(var_21 != -1) {}

          var_21 = var_22;
        }
      }

      if(var_21 == -1) {
        var_21 = 0;
      }

      var_29 = [];
      var_30 = var_21;
      var_29[0] = var_9._id_C94F[var_30];

      for(var_22 = 1; var_22 < var_9._id_C94F.size; var_22++) {
        var_12 = var_9._id_C94F[var_30];
        var_31 = var_12.target;
        var_32 = 0;

        for(var_33 = undefined; var_32 < var_9._id_C94F.size; var_32++) {
          var_34 = var_9._id_C94F[var_32];
          var_23 = var_34._id_0481;

          if(isDefined(var_23) && var_31 == var_23) {
            var_33 = var_34;
            break;
          }
        }

        if(!isDefined(var_33)) {}

        var_29[var_22] = var_33;
        var_30 = var_32;
      }

      var_9._id_C94F = var_29;
    }
  }

  var_3 = undefined;

  foreach(var_38 in var_2) {
    if(!isDefined(var_38._id_3BD6)) {}
  }

  _id_2CFF();
  _id_2CFE();
  _id_388A(var_2);
}

_id_7BCD(var_0, var_1) {
  var_2 = var_1._id_7BBE.size;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = var_1._id_7BBE[var_3];
    var_4._id_24E7 = 1;
    var_4._id_D9B3._id_B4F1 = 0;
  }

  foreach(var_6 in level.players) {
    if(!var_6 scripts\engine\utility::_id_5472("stealth_enabled") || !var_6 scripts\engine\utility::_id_546E("stealth_enabled")) {
      continue;
    }
    for(var_3 = 0; var_3 < var_2; var_3++) {
      var_4 = var_1._id_7BBE[var_3];
      var_4._id_24E8 = 0;
    }

    var_7 = undefined;
    var_8 = 100000000000000000000.0;

    for(var_3 = 0; var_3 < var_2; var_3++) {
      var_4 = var_1._id_7BBE[var_3];

      if(_func_011A(var_6.origin, var_4._id_106A1)) {
        var_7 = var_4;
        break;
      }

      var_9 = _func_0135(var_4._id_19FD - var_6.origin);

      if(var_9 < var_8) {
        var_8 = var_9;
        var_7 = var_4;
      }
    }

    var_7._id_D9B3._id_B4F1 = 1;
    var_10 = [var_7];
    var_7._id_24E8 = 1;
    var_9 = 0;

    for(var_11 = 0; var_11 < var_10.size; var_9++) {
      var_12 = var_10.size;

      for(var_13 = var_11; var_13 < var_12; var_13++) {
        var_4 = var_10[var_13];
        var_4._id_24E7 = var_9 * var_4._id_24E7;
        var_4._id_24E8 = 1;
        var_4._id_24E6 = var_9;
        var_14 = var_4._id_C1C0.size;

        for(var_15 = 0; var_15 < var_14; var_15++) {
          var_16 = var_4._id_C1C0[var_15];

          if(!var_16._id_C1BF._id_24E8) {
            var_10[var_10.size] = var_16._id_C1BF;
            var_16._id_C1BF._id_24E8 = 1;
          }
        }
      }

      var_11 = var_12;
    }
  }

  var_18 = 1;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = var_1._id_7BBE[var_3];
    var_18 = max(var_4._id_24E7, var_18);
  }

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = var_1._id_7BBE[var_3];
    var_4._id_24E7 = var_4._id_24E7 / var_18;
    var_4._id_24E8 = undefined;
  }
}

_id_7BCC(var_0) {
  if(isDefined(self._id_0408._id_3936)) {
    self._id_0408._id_3936._id_414A = var_0;
    _id_7BDB(var_0);
  }
}

_id_7BE1(var_0) {
  if(isDefined(self._id_0408._id_3936._id_414A) && self._id_0408._id_3936._id_414A == var_0) {
    _id_7BCE(var_0);
  }
}

_id_7BDB(var_0) {
  var_0._id_D9B3._id_24E4 = var_0._id_D9B3._id_24E4 + 1;
  _id_7BDF(var_0);
}

_id_7BCE(var_0) {
  var_0._id_D9B3._id_24E4 = var_0._id_D9B3._id_24E4 - 1;
  _id_7BE0(var_0);

  if(var_0._id_D9B3._id_7D73 == 0) {
    var_0._id_D9B3._id_24E5 = gettime() + var_0._id_3D06;
  }
}

_id_7BDF(var_0) {
  if(!self._id_0408._id_3936._id_88CD && _func_011A(self.origin, var_0._id_106A1)) {
    var_0._id_D9B3._id_7D73 = var_0._id_D9B3._id_7D73 + 1;
    self._id_0408._id_3936._id_88CD = 1;

    if(var_0._id_D9B3._id_B4F1 && var_0._id_D9B3._id_7D73 == 1) {
      var_1 = 1000;
      var_0._id_D9B3._id_1D13 = gettime() + var_1;
    }
  }
}

_id_7BE0(var_0) {
  if(self._id_0408._id_3936._id_88CD) {
    var_0._id_D9B3._id_7D73 = var_0._id_D9B3._id_7D73 - 1;
    self._id_0408._id_3936._id_88CD = 0;
  }
}

_id_7BD9() {
  var_0 = self._id_0408._id_3936._id_414A;

  if(var_0._id_C1C0.size == 0) {
    return;
  }
  if(!isDefined(self._id_CE6D) || !isDefined(level._id_0408._id_7BC5[self._id_CE6D])) {
    return;
  }
  var_1 = undefined;
  var_2 = gettime();
  var_3 = level._id_0408._id_7BC5[self._id_CE6D]._id_EE8F;
  var_4 = 1.0;

  foreach(var_6 in level._id_0408._id_7BC5[self._id_CE6D]._id_7BBE) {
    if(var_6 == var_0) {
      continue;
    }
    if(var_6._id_D9B3._id_24E5 > gettime()) {
      continue;
    }
    if(var_6._id_D9B3._id_B4F1 && var_6._id_D9B3._id_7D73 > 0 && var_2 > var_6._id_D9B3._id_1D13) {
      continue;
    }
    if(self._id_0408._id_3936._id_BC5B[0] == var_6 || self._id_0408._id_3936._id_BC5B[1] == var_6) {
      continue;
    }
    if(self._id_CE6D != var_6._id_E7AE) {
      continue;
    }
    if(var_6._id_D9B3._id_24E4 >= var_6._id_D9B3._id_9C19) {
      continue;
    }
    var_7 = abs(var_3 - var_6._id_24E7);

    if(var_7 < var_4) {
      var_1 = var_6;
      var_4 = var_7;
    }
  }

  if(!isDefined(var_1)) {
    var_1 = var_0._id_C1C0[0]._id_C1BF;
  }

  _id_7BE1(var_0);
  self._id_0408._id_3936._id_BC5B[0] = self._id_0408._id_3936._id_BC5B[1];
  self._id_0408._id_3936._id_BC5B[1] = self._id_0408._id_3936._id_414A;
  _id_7BCC(var_1);
  var_3 = var_3 + 0.5;

  if(var_3 > 1.0) {
    var_3 = 0.0;
  }

  level._id_0408._id_7BC5[self._id_CE6D]._id_EE8F = var_3;
}