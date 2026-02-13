/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1903.gsc
*************************************************/

_id_8172() {
  level._id_105F7 = ["highest", "high", "medium", "low"];
  level._id_1043A = [];
  level._id_104C2 = [];
  level._id_104C3 = [];
  level._id_10508 = [];
  level._id_10649 = "cp/" + getDvar("#x36d16f02578d0ee10") + "_vo_table.csv";
  level thread _id_AE6A();
  level thread _id_A3B8();
}

_id_812E() {
  _id_8109();
  thread _id_E671();
  level thread _id_60AB();
}

_id_8109() {
  var_0 = spawnStruct();
  var_0._id_10506 = undefined;
  var_0._id_8418 = undefined;
  var_0._id_8679 = 0;
  var_1 = [];

  if(isDefined(level._id_105F7)) {
    foreach(var_4, var_3 in level._id_105F7) {
      var_1[var_3] = [];
    }
  }

  var_0._id_105FC = var_1;
  self._id_10646 = var_0;
  scripts\engine\utility::_id_5C11("vo_system_busy");
}

_id_AE6A() {
  var_0 = level._id_10649;
  var_1 = 0;

  if(!_func_0221(var_0)) {
    return;
  }
  for(;;) {
    var_2 = tablelookupbyrow(var_0, var_1, 0);

    if(var_2 == "") {
      break;
    }

    var_3 = tablelookupbyrow(var_0, var_1, 1);
    var_4 = int(tablelookupbyrow(var_0, var_1, 2));
    var_5 = int(tablelookupbyrow(var_0, var_1, 3));
    var_6 = int(tablelookupbyrow(var_0, var_1, 4));
    var_7 = tablelookupbyrow(var_0, var_1, 5);
    var_8 = tablelookupbyrow(var_0, var_1, 6);
    var_9 = tablelookupbyrow(var_0, var_1, 7);
    var_10 = tablelookupbyrow(var_0, var_1, 8);
    var_11 = tablelookupbyrow(var_0, var_1, 9);
    var_12 = int(tablelookupbyrow(var_0, var_1, 10));
    var_13 = int(tablelookupbyrow(var_0, var_1, 11));
    var_14 = tablelookupbyrow(var_0, var_1, 12);
    var_15 = int(tablelookupbyrow(var_0, var_1, 13));
    var_16 = tablelookupbyrow(var_0, var_1, 15);
    _id_C231(var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16);

    if(var_1 % 5 == 1) {
      wait 0.05;
    }

    var_1++;
  }
}

_id_C231(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  var_15 = spawnStruct();

  if(isDefined(var_2) && var_2 > 0) {
    var_15._id_3D06 = var_2;
    var_15._id_9029 = 0;
  }

  if(isDefined(var_14)) {
    var_15._id_9F85 = var_14;
  }

  if(isDefined(var_13) && var_13 > 0) {
    var_15._id_AF62 = var_13;
  }

  if(istrue(var_10)) {
    var_15._id_AB35 = 1;
  } else {
    var_15._id_AB35 = 0;
  }

  if(isDefined(var_11) && var_11 > 0) {
    var_15._id_F224 = var_11;
  }

  if(isDefined(var_12)) {
    var_15._id_BD27 = var_12;
  }

  if(isDefined(var_4) && var_4 > 0) {
    var_15._id_9C2C = var_4;
  }

  if(isDefined(var_3) && var_3 > 0) {
    var_15._id_33BE = var_3;
  }

  if(isDefined(var_7) && var_7 != "") {
    var_15._id_10961 = var_7;
  }

  if(isDefined(var_5) && var_5 != "") {
    if(!isDefined(level._id_104C2[var_5])) {
      level._id_104C2[var_5] = [];
    }

    var_15._id_3330 = var_5;
    level._id_104C2[var_5][level._id_104C2[var_5].size] = var_1;

    if(!isDefined(level._id_104C3[var_5])) {
      level._id_104C3[var_5] = 0;
    }
  }

  if(isDefined(var_6) && var_6 != "") {
    if(!isDefined(level._id_104C2[var_6])) {
      level._id_104C2[var_6] = [];
    }

    var_15._id_3331 = var_6;
    level._id_104C2[var_6][level._id_104C2[var_6].size] = var_1;

    if(!isDefined(level._id_104C3[var_6])) {
      level._id_104C3[var_6] = 0;
    }
  }

  if(isDefined(var_8) && var_8 != "") {
    if(!isDefined(level._id_10508[var_8])) {
      level._id_10508[var_8] = [];
    }

    var_15._id_4965 = var_8;
    level._id_10508[var_1] = var_8;
  }

  if(isDefined(var_9) && var_9 != "") {
    var_15._id_A49C = var_9;
  }

  level._id_1043A[var_1] = var_15;
}

_id_E671() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(_id_8716()) {
      if(scripts\engine\utility::_id_5C0C("vo_system_busy")) {
        scripts\engine\utility::_id_5C30("vo_system_busy");
      }
    }

    var_0 = _id_6826();

    if(!isDefined(var_0)) {
      _id_D43B(0);
      self waittill("play_VO_system");

      if(_id_8717()) {
        self waittill("unpause_VO_system");
      }

      continue;
    }

    _id_B307(var_0);
  }
}

_id_B307(var_0) {
  self endon("disconnect");
  _id_D43B(1);
  _id_D437(var_0);
  _id_B2FB(var_0);
  _id_AF55(var_0);
  _id_FA46();
}

_id_6826() {
  var_0 = _id_C767();

  if(isDefined(var_0)) {
    return var_0;
  }

  if(isDefined(level._id_105F7)) {
    foreach(var_3, var_2 in level._id_105F7) {
      var_0 = _id_C768(var_2);

      if(isDefined(var_0)) {
        return var_0;
      }
    }
  }

  return undefined;
}

_id_C767() {
  var_0 = self._id_10646._id_8418;
  _id_C5C4();
  return var_0;
}

_id_C5C4() {
  self._id_10646._id_8418 = undefined;
}

_id_C768(var_0) {
  _id_C3B5(var_0);
  return _id_B9E0(var_0);
}

_id_B9E0(var_0) {
  var_1 = self._id_10646._id_105FC[var_0][0];

  if(!isDefined(var_1)) {
    return var_1;
  }

  var_2 = [];

  for(var_3 = 1; var_3 < self._id_10646._id_105FC[var_0].size; var_3++) {
    if(!isDefined(self._id_10646._id_105FC[var_0][var_3])) {
      break;
    }

    var_2[var_3 - 1] = self._id_10646._id_105FC[var_0][var_3];
  }

  self._id_10646._id_105FC[var_0] = var_2;
  return var_1;
}

_id_C3B5(var_0) {
  var_1 = gettime();
  var_2 = [];

  foreach(var_5, var_4 in self._id_10646._id_105FC[var_0]) {
    if(!_id_10529(var_4, var_1)) {
      var_2[var_2.size] = self._id_10646._id_105FC[var_0][var_5];
      continue;
    }
  }

  self._id_10646._id_105FC[var_0] = var_2;
}

_id_10529(var_0, var_1) {
  return var_1 > var_0._id_57A6;
}

_id_D43B(var_0) {
  if(!isPlayer(self) || !isDefined(self._id_10646)) {
    return;
  }
  self._id_10646._id_8679 = var_0;
}

_id_8717() {
  return istrue(self._id_AF65);
}

_id_8716() {
  return scripts\engine\utility::_id_5C00("vo_system_busy");
}

_id_D43A(var_0) {
  level._id_10647 = var_0;

  if(!var_0) {
    scripts\engine\utility::_id_5C04("vo_system_busy");
  } else {
    scripts\engine\utility::_id_5C1B("vo_system_busy");
  }
}

_id_D437(var_0) {
  self._id_10646._id_10506 = var_0;
}

_id_60AB() {
  var_0 = "";
  level waittill("game_ended");

  foreach(var_2 in level.players) {
    foreach(var_4 in level._id_105F7) {
      if(isDefined(var_2._id_10646._id_105FC[var_4]) && var_2._id_10646._id_105FC[var_4].size > 0) {
        foreach(var_6 in var_2._id_10646._id_105FC[var_4]) {
          if(isDefined(var_6)) {
            if(_func_0205(var_6._id_1446)) {
              var_2 _meth_83EF(var_6._id_1446);
            }
          }
        }

        var_2._id_10646._id_105FC[var_4] = [];
      }
    }

    if(isDefined(level._id_4917) && level._id_4917.size > 0) {
      foreach(var_10 in level._id_4917) {
        if(issubstr(var_10, "pg_")) {
          var_2 _meth_83EF(var_10);
        }

        if(_func_0205(var_2._id_105F0 + var_10)) {
          var_2 _meth_83EF(var_2._id_105F0 + var_10);
        }

        if(_func_0205(var_2._id_105F0 + "plr_" + var_10)) {
          var_2 _meth_83EF(var_2._id_105F0 + "plr_" + var_10);
        }
      }
    }

    if(isDefined(var_2._id_41A9) && var_2._id_41A9.size > 0) {
      foreach(var_13 in var_2._id_41A9) {
        if(isDefined(var_13)) {
          if(_func_0205(var_13)) {
            var_2 _meth_83EF(var_13);
            continue;
          }

          if(_func_0205(var_2._id_105F0 + var_13)) {
            var_2 _meth_83EF(var_2._id_105F0 + var_13);
            continue;
          }

          if(_func_0205(var_2._id_105F0 + "plr_" + var_13)) {
            var_2 _meth_83EF(var_2._id_105F0 + "plr_" + var_13);
          }
        }
      }
    }

    if(!isDefined(var_2._id_105F0)) {
      return;
    }
    switch (var_2._id_105F0) {
      case "p1_":
        var_0 = "_valley_girl";
        break;
      case "p2_":
        var_0 = "_nerd";
        break;
      case "p3_":
        var_0 = "_rapper";
        break;
      case "p4_":
        var_0 = "_jock";
        break;
      case "p5_":
        var_0 = "_jock";
        break;
    }

    var_15 = "mus_zombies" + var_0;

    if(_func_0205(var_15)) {
      var_2 _meth_83EF("mus_zombies" + var_0);
    }

    var_15 = "mus_zombies" + var_0 + "_lsrs";

    if(_func_0205(var_15)) {
      var_2 _meth_83EF("mus_zombies" + var_0 + "_lsrs");
    }
  }
}

_id_B2FB(var_0) {
  self endon("interrupt_current_VO");
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  if(self.sessionstate != "playing") {
    return;
  }
  var_1 = var_0._id_1446;

  if(!_func_0205(var_1)) {
    if(isDefined(level._id_1043A[var_1]) && isDefined("level.vo_alias_data[alias].missingStub")) {} else {}

    wait 0.1;
    return;
  }

  self._id_10648 = 1;

  if(scripts\cp\utility::_id_867B(self)) {
    var_2 = scripts\cp\utility::_id_6637(self);

    if(isDefined(var_2)) {
      self _meth_83EF(var_2);
    }
  }

  if(isDefined(var_0._id_22AD)) {
    var_3 = var_0._id_22AD;
  } else {
    var_3 = var_1;
  }

  foreach(var_5 in level.players) {
    if(var_5 _meth_81E2() && !var_5 _meth_81E3()) {
      continue;
    }
    if(isDefined(var_5._id_41A9)) {
      var_5._id_41A9 = scripts\engine\utility::array_add(var_5._id_41A9, var_3);
    }

    if(var_5 == self) {
      if(isDefined(level._id_631C)) {
        var_6 = [[level._id_631C]](var_5, var_1, var_3);
      } else {
        var_6 = _id_631D(var_5, var_1, var_3);
      }

      if(isDefined(var_6)) {
        var_5 scripts\cp\utility::_id_B877(var_6);
      } else {
        var_5 scripts\cp\utility::_id_B877(var_1);
      }

      continue;
    }

    if(!istrue(var_0._id_AB2F) && _func_0205(var_1)) {
      self playsoundtoplayer(var_1, var_5);
    }
  }

  foreach(var_9 in var_0._id_332E) {
    level._id_104C3[var_9] = gettime();
  }

  if(!isDefined(self._id_A759[var_3])) {
    self._id_A759[var_3] = 1;
  } else {
    self._id_A759[var_3]++;
  }

  wait(_id_6763(var_1));
  self._id_10648 = 0;
}

_id_1447(var_0, var_1) {
  var_2 = _id_631D(var_0, var_1);
  return _func_0205(var_2);
}

_id_631D(var_0, var_1, var_2) {
  var_3 = strtok(var_1, "_");

  if(var_3[0] == "ww" || var_3[0] == "dj" || var_3[0] == "ks") {
    return var_1;
  } else {
    if(isDefined(var_0._id_105F0)) {
      var_4 = var_0._id_105F0 + "plr_" + var_2;
    } else {
      var_4 = "plr_" + var_2;
    }

    if(_func_0205(var_4)) {
      return var_4;
    }

    return undefined;
  }
}

_id_631E(var_0, var_1) {
  if(issubstr(var_1, "ww_") || issubstr(var_1, "dj_") || issubstr(var_1, "p1_") || issubstr(var_1, "p2_") || issubstr(var_1, "p3_") || issubstr(var_1, "p4_") || issubstr(var_1, "jaroslav_anc")) {
    return var_1;
  }

  var_2 = _func_00D6(var_1, var_0._id_105F0.size);
  return var_0._id_105F0 + var_2;
}

_id_6763(var_0) {
  if(!_func_0205(var_0)) {
    return 0;
  }

  var_1 = _func_0142(var_0) / 1000 + 0.4;

  if(getdvarint("#x3ad67579137c951a9") != 0 && getdvarint("#x3ad67579137c951a9") != 1) {
    var_1 = var_1 + 1.5;
  }

  var_2 = _id_654D(var_0);

  if(isDefined(var_2)) {
    var_1 = var_2;
  }

  return var_1;
}

_id_AF55(var_0) {
  if(_id_8717()) {
    self waittill("unpause_VO_system");
  }

  if(var_0._id_AF62 > 0) {
    wait(var_0._id_AF62);
  }
}

_id_FA46() {
  self._id_10646._id_10506 = undefined;
}

_id_F730(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\cp\utility::_id_6C61(var_1);

  if(!isDefined(var_0)) {
    return;
  }
  if(var_5.size <= 0) {
    return;
  }
  if(!istrue(var_2)) {
    level._id_8A9B = 1;

    if(isPlayer(self) || self == level || !isent(self)) {
      foreach(var_7 in var_5) {
        var_7 thread _id_B213(var_0, "cp_comment_vo", "highest", 10, 0, 0, 1);
      }
    } else
      thread scripts\cp\utility::_id_B8ED(self.origin, var_0);

    wait(_id_6763(var_0));
    level._id_8A9B = 0;
  } else {
    var_9 = 45;

    if(isDefined(var_4)) {
      var_9 = var_4;
    }

    var_10 = 60;

    if(isDefined(var_3)) {
      var_10 = var_3;
    }

    foreach(var_7 in var_5) {
      var_7 thread _id_1048(var_0, "cp_comment_vo", var_10, var_9, 6, 1);
    }
  }
}

_id_F72E(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(!istrue(var_2)) {
    var_1 thread _id_F72D(var_0, "cp_comment_vo", "highest", 10, 0, 0, 1, 100);
  } else {
    var_5 = 45;

    if(isDefined(var_4)) {
      var_5 = var_4;
    }

    var_6 = 60;

    if(isDefined(var_3)) {
      var_6 = var_3;
    }

    var_1 thread _id_1048(var_0, "cp_comment_vo", var_6, var_5, 6, 1);
  }
}

_id_F72F(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(level.players)) {
    return;
  }
  if(!istrue(var_1)) {
    foreach(var_3 in level.players) {
      var_3 thread _id_F72D(var_0, "zmb_comment_vo", "highest", 10, 0, 0, 1, 100);
    }
  } else {
    foreach(var_3 in level.players) {
      var_3 thread _id_1048(var_0, "zmb_comment_vo", 60, 45, 6, 1);
    }
  }
}

_id_F72D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = isDefined(level._id_1043A[var_0]);
  var_9 = scripts\engine\utility::ter_op(var_8, level._id_1043A[var_0], undefined);

  if(!isDefined(var_7)) {
    if(var_8) {
      if(isDefined(var_9._id_33BE)) {
        var_7 = var_9._id_33BE;
      }
    } else
      var_7 = 100;
  }

  if(randomint(100) > var_7) {
    return;
  }
  if(_id_DAC0(var_0)) {
    if(!isDefined(var_5) && var_8 && isDefined(var_9._id_AF62)) {
      var_5 = var_9._id_AF62;
    }

    if(!isDefined(var_6) && var_8 && isDefined(var_9._id_AB2F)) {
      var_6 = var_9._id_AB35;
    }

    if(!isDefined(var_3) && var_8 && isDefined(var_9._id_F224)) {
      var_3 = var_9._id_F224;
    }

    if(!isDefined(var_2) && var_8 && isDefined(var_9._id_BD27)) {
      var_2 = var_9._id_BD27;
    }

    var_10 = _id_63B9(var_0);

    foreach(var_12 in var_10) {
      level._id_104C3[var_12] = gettime();
    }

    if(var_8 && isDefined(var_9._id_9029)) {
      var_9._id_9029 = gettime();
    }

    thread _id_105F(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  }
}

_id_DAC0(var_0) {
  if(!isDefined(level._id_1043A[var_0])) {
    return 1;
  }

  var_1 = gettime();

  if(isDefined(level._id_1043A[var_0]._id_3D06) && isDefined(level._id_1043A[var_0]._id_9029)) {
    if(var_1 < level._id_1043A[var_0]._id_9029 + level._id_1043A[var_0]._id_3D06 * 1000) {
      return 0;
    }
  }

  var_2 = _id_63B9(var_0);

  foreach(var_4 in var_2) {
    var_5 = scripts\engine\utility::ter_op(isDefined(level._id_1043A[var_0]._id_3D06), level._id_1043A[var_0]._id_3D06, 30);

    if(var_1 < level._id_104C3[var_4] + var_5 * 1000) {
      return 0;
    }
  }

  if(isDefined(level._id_1043A[var_0]._id_9C2C)) {
    if(!isDefined(self._id_A759)) {
      self._id_A759 = [];
    }

    if(!isDefined(self._id_A759[var_0])) {
      self._id_A759[var_0] = 0;
    }

    if(self._id_A759[var_0] < level._id_1043A[var_0]._id_9C2C) {
      return 1;
    } else {
      return 0;
    }
  } else
    return 1;
}

_id_63B9(var_0) {
  if(!isDefined(level._id_104C2)) {
    return [];
  }

  var_1 = getarraykeys(level._id_104C2);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(scripts\engine\utility::array_contains(level._id_104C2[var_4], var_0)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_DA75(var_0) {
  if(issubstr(var_0, "ww_") || issubstr(var_0, "dj_") || issubstr(var_0, "jaroslav_anc")) {
    return 0;
  } else {
    return 1;
  }
}

_id_DA76(var_0, var_1) {
  if(istrue(var_1)) {
    if(issubstr(var_0, "ww_") && issubstr(var_0, "_p")) {
      return 1;
    } else {
      return 0;
    }
  }

  return 0;
}

_id_B213(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon("game_ended");
  level._id_18F9 = 1;
  var_7 = level.players;

  if(isPlayer(self)) {
    var_7 = [self];
  }

  foreach(var_9 in var_7) {
    if(!isDefined(var_9)) {
      continue;
    }
    if(var_9 _meth_81E2() && !var_9 _meth_81E3()) {
      continue;
    }
    var_10 = _id_3F8F(var_0, var_3, var_5, var_6);
    var_9 thread _id_B307(var_10);
  }

  wait(_id_6763(var_0));

  foreach(var_9 in var_7) {
    var_9 _id_D43B(0);
  }

  level._id_18F9 = 0;
}

_id_105F(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_1) && isDefined(level._id_10552[var_1])) {
    self thread[[level._id_10552[var_1]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  } else if(isDefined(var_1) && var_1 == "cp_comment_vo") {
    _id_B213(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  } else if(isPlayer(self)) {
    if(isDefined(self._id_105F0)) {
      var_7 = self._id_105F0 + var_0;
    } else {
      return;
    }

    thread _id_B305(var_7, var_2, var_3, var_4, var_5, var_6, var_0);
  } else {
    var_7 = var_0;
    level thread _id_B302(var_7, var_2, var_3, var_4, var_5, var_6, var_0);
  }
}

_id_B302(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  foreach(var_8 in level.players) {
    var_8 _id_1060(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  }
}

_id_B305(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  _id_1060(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_1060(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(self._id_41A9)) {
    self._id_41A9 = [];
  }

  thread _id_1061(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_1061(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_1 = _id_6806(var_1);
  var_7 = _id_3F8F(var_0, var_2, var_4, var_5, var_6);

  if(_id_DAB1(var_3)) {
    _id_1041(var_7);

    if(_id_8718()) {
      _id_8414();
    }
  } else
    _id_1051(var_7, var_1);

  if(!_id_8718()) {
    _id_A686();
  }
}

_id_6806(var_0) {
  if(!isDefined(var_0)) {
    return level._id_105F7[level._id_105F7.size - 1];
  }

  return var_0;
}

_id_3F8F(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 999;
  var_6 = 1.5;
  var_7 = 3;
  var_8 = spawnStruct();
  var_8._id_1446 = var_0;
  var_8._id_332E = _id_63B9(var_0);
  var_8._id_22AD = var_4;

  if(!isDefined(var_1)) {
    var_1 = var_5;
  }

  var_8._id_57A6 = gettime() + var_1 * 1000;

  if(!isDefined(var_2)) {
    var_2 = randomfloatrange(var_6, var_7);
  }

  var_8._id_AF62 = var_2;

  if(istrue(var_3)) {
    var_8._id_AB2F = 1;
  } else {
    var_8._id_AB2F = 0;
  }

  return var_8;
}

_id_DAB1(var_0) {
  return isDefined(var_0) && var_0;
}

_id_1041(var_0) {
  self._id_10646._id_8418 = var_0;
}

_id_8718() {
  return istrue(self._id_10646._id_8679);
}

_id_8414() {
  var_0 = _id_642C();

  if(isDefined(var_0)) {
    self _meth_83EF(var_0);
  }

  self notify("interrupt_current_VO");
}

_id_642C() {
  if(isDefined(self._id_10646)) {
    if(isDefined(self._id_10646._id_10506)) {
      if(isDefined(self._id_10646._id_10506._id_1446)) {
        return self._id_10646._id_10506._id_1446;
      }
    }
  }

  return undefined;
}

_id_1051(var_0, var_1) {
  self._id_10646._id_105FC[var_1][self._id_10646._id_105FC[var_1].size] = var_0;
}

_id_A686() {
  self notify("play_VO_system");
}

_id_C45E(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in self._id_10646._id_105FC[var_1]) {
    if(!(var_4._id_1446 == self._id_105F0 + var_0 || var_4._id_1446 == self._id_105F0 + "plr_" + var_0)) {
      var_2[var_2.size] = self._id_10646._id_105FC[var_1][var_5];
    }
  }

  self._id_10646._id_105FC[var_1] = var_2;
}

_id_AF65(var_0) {
  if(var_0.size == 1) {
    var_0[0]._id_AF65 = 1;
  } else {
    foreach(var_2 in var_0) {
      var_2._id_AF65 = 1;
    }
  }
}

_id_F99D(var_0) {
  foreach(var_2 in var_0) {
    var_2._id_AF65 = 0;
  }

  foreach(var_2 in var_0) {
    var_2 notify("unpause_VO_system");
  }
}

_id_A3B8() {
  level endon("game_ended");

  if(!isDefined(level._id_A3B7)) {
    level._id_A3B7 = [];
    level._id_A3B9 = [];
    level._id_AF5E = 0;
  }

  var_0 = 60;

  for(;;) {
    while(level._id_AF5E) {
      wait 0.1;
    }

    var_1 = gettime();

    foreach(var_4, var_3 in level._id_A3B7) {
      if(var_1 > var_3._id_A479) {
        if(isDefined(var_3._id_0389)) {
          var_3._id_0389 _id_F72D(var_4, var_3._id_10653, "low", 3, 0, 0, var_3._id_AB2F);
        } else {
          level _id_F72D(var_4, var_3._id_10653, "low", 3, 0, 0, var_3._id_AB2F);
        }

        var_3._id_F26A++;

        if(var_3._id_9C3B != -1 && var_3._id_9C3B <= var_3._id_F26A) {
          _id_C3D1(var_4);
        }

        var_3._id_A479 = var_1 + var_3._id_3D06 * min(var_3._id_F26A, 3) * 1000;
        wait(var_0);
      }
    }

    wait 1;
  }
}

_id_1048(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level._id_A3B7)) {
    level._id_A3B7 = [];
    level._id_A3B9 = [];
    level._id_AF5E = 0;
  }

  if(isDefined(level._id_A3B7[var_0])) {
    return;
  }
  if(isDefined(level._id_A3B9[var_0])) {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = 60;
  }

  if(!isDefined(var_1)) {
    var_1 = "zmb_comment_vo";
  }

  var_6 = undefined;

  if(isPlayer(self)) {
    var_6 = self;
  }

  var_7 = spawnStruct();
  var_7._id_F26A = 0;
  var_7._id_3D06 = var_2;
  var_7._id_10653 = var_1;

  if(isDefined(var_6)) {
    var_7._id_0389 = var_6;
  }

  if(isDefined(var_5)) {
    var_7._id_AB2F = var_5;
  } else {
    var_7._id_AB2F = 0;
  }

  if(isDefined(var_3)) {
    var_7._id_A479 = gettime() + var_3 * 1000;
  } else {
    var_7._id_A479 = 0;
  }

  if(isDefined(var_4)) {
    var_7._id_9C3B = var_4;
  } else {
    var_7._id_9C3B = -1;
  }

  level._id_A3B7[var_0] = var_7;
}

_id_C3D1(var_0, var_1) {
  level._id_A3B7 = scripts\engine\utility::array_remove_index(level._id_A3B7, var_0, 1);

  if(istrue(var_1)) {
    level._id_A3B9[var_0] = 1;
  }
}

_id_F239(var_0, var_1) {
  level endon(var_0 + "_about_to_play");
  wait(var_1);
  level notify(var_0 + "_timed_out");
}

_id_654D(var_0) {
  var_1 = _func_0222("cp/cp_vo_lookup.csv", 0, var_0, 1);

  if(isDefined(var_1)) {
    var_1 = float(var_1);
    return var_1;
  }

  return undefined;
}