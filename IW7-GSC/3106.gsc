/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3106.gsc
**************************************/

func_DF13() {
  func_0C23::func_BE5C();

  if(scripts\aitypes\bt_util::bt_istreeregistered("jackal\jackal")) {
    return;
  }
  scripts\aitypes\bt_util::init();
  var_0 = func_0070();
  var_0.var_71AD = ::bt_initroot;
  scripts\aitypes\bt_util::bt_registertree("jackal\jackal", var_0);
}

bt_initroot() {
  var_0 = spawnStruct();
  var_0.var_71D4 = ::func_70B7;
  var_0.id = 0;
  var_0.var_4B1B = 0;
  var_0.var_C21E = 8;
  var_0.var_273F = 0;
  self.bt.var_E6E5 = var_0;
  self.bt.var_BE5D = self _meth_84B1("jackal\jackal_native_api");
}

func_0070() {
  var_0 = spawnStruct();
  var_0.var_11591 = [];
  var_0.var_1158E = [];
  var_0.var_11591[0] = 1;
  var_0.var_11591[1] = 9;
  var_0.var_11591[2] = 11;
  var_0.var_11591[12] = 13;
  var_0.var_11591[13] = 17;
  var_0.var_11591[14] = 19;
  var_0.var_11591[15] = 22;
  var_0.var_11591[3] = 25;
  var_0.var_11591[26] = 27;
  var_0.var_11591[27] = 29;
  var_0.var_11591[30] = 32;
  var_0.var_11591[28] = 35;
  var_0.var_11591[38] = 39;
  var_0.var_11591[39] = 41;
  var_0.var_11591[40] = 43;
  var_0.var_11591[4] = 46;
  var_0.var_11591[47] = 48;
  var_0.var_11591[48] = 50;
  var_0.var_11591[51] = 52;
  var_0.var_11591[49] = 54;
  var_0.var_11591[5] = 56;
  var_0.var_11591[6] = 58;
  var_0.var_11591[60] = 61;
  var_0.var_11591[61] = 64;
  var_0.var_11591[65] = 66;
  var_0.var_11591[66] = 68;
  var_0.var_11591[67] = 74;
  var_0.var_11591[62] = 81;
  var_0.var_11591[63] = 85;
  var_0.var_11591[7] = 87;
  var_1 = func_0C1D::bt_registerprefabtaskids(var_0, 57, 89);
  var_1 = func_0C1D::bt_registerprefabtaskids(var_0, 86, var_1);
  var_1 = func_0C1D::bt_registerprefabtaskids(var_0, 88, var_1);
  bt_registertaskargs(var_0);
  return var_0;
}

func_70B7(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_4 = var_1.var_10B3A[var_1.var_0348];
          var_4.id = var_0;
          var_5 = var_1.var_D8BE[var_4.id];

          if(isDefined(var_5)) {
            var_4.var_4B1B = var_5;
          } else {
            var_4.var_4B1B = 0;
          }

          var_4.var_C21E = 2;
          var_4.var_71D4 = ::func_704C;
          return;
        case 1:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_4 = var_1.var_10B3A[var_1.var_0348];
          var_4.id = var_0 + 1;
          var_5 = var_1.var_D8BE[var_4.id];

          if(isDefined(var_5)) {
            var_4.var_4B1B = var_5;
          } else {
            var_4.var_4B1B = 0;
          }

          var_4.var_C21E = 2;
          var_4.var_71D4 = ::func_70CE;
          return;
        case 2:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_4 = var_1.var_10B3A[var_1.var_0348];
          var_4.id = var_0 + 2;
          var_5 = var_1.var_D8BE[var_4.id];

          if(isDefined(var_5)) {
            var_4.var_4B1B = var_5;
          } else {
            var_4.var_4B1B = 0;
          }

          var_4.var_C21E = 2;
          var_4.var_71D4 = ::func_70D1;
          return;
        case 3:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_4 = var_1.var_10B3A[var_1.var_0348];
          var_4.id = var_0 + 3;
          var_5 = var_1.var_D8BE[var_4.id];

          if(isDefined(var_5)) {
            var_4.var_4B1B = var_5;
          } else {
            var_4.var_4B1B = 0;
          }

          var_4.var_C21E = 2;
          var_4.var_71D4 = ::func_70D0;
          return;
        case 4:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_4 = var_1.var_10B3A[var_1.var_0348];
          var_4.id = var_0 + 4;
          var_5 = var_1.var_D8BE[var_4.id];

          if(isDefined(var_5)) {
            var_4.var_4B1B = var_5;
          } else {
            var_4.var_4B1B = 0;
          }

          var_4.var_C21E = 2;
          var_4.var_71D4 = ::func_70CD;
          return;
        case 5:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_4 = var_1.var_10B3A[var_1.var_0348];
          var_4.id = var_0 + 5;
          var_5 = var_1.var_D8BE[var_4.id];

          if(isDefined(var_5)) {
            var_4.var_4B1B = var_5;
          } else {
            var_4.var_4B1B = 0;
          }

          var_4.var_C21E = 3;
          var_4.var_71D4 = ::func_70CC;
          return;
        case 6:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_4 = var_1.var_10B3A[var_1.var_0348];
          var_4.id = var_0 + 6;
          var_5 = var_1.var_D8BE[var_4.id];

          if(isDefined(var_5)) {
            var_4.var_4B1B = var_5;
          } else {
            var_4.var_4B1B = 0;
          }

          var_4.var_C21E = 2;
          var_4.var_71D4 = ::func_70D3;
          return;
        case 7:
          var_6 = var_0 + 7;
          var_3 = func_0A0D::func_593B(var_6);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_6] = -1;
          }

          break;
      }
    }

    if(var_3 != anim.failure) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.failure;
}

func_7131(var_0, var_1, var_2) {
  var_3 = var_0.var_D8BE[var_1];

  if(isDefined(var_3) && var_3 != -1) {
    if(var_3 == 1) {
      var_2.var_71D2 = ::func_7143;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 1);
      return;
    } else if(var_3 == 2) {
      var_2.var_71D2 = ::func_7146;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 2);
      return;
    } else if(var_3 == 3) {
      var_2.var_71D2 = ::func_7145;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 3);
      return;
    } else if(var_3 == 4) {
      var_2.var_71D2 = ::func_7142;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 4);
      return;
    } else if(var_3 == 5) {
      var_2.var_71D2 = ::func_7141;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 5);
      return;
    } else if(var_3 == 6) {
      var_2.var_71D2 = ::func_7148;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 6);
      return;
    }
  }

  var_2.var_71D2 = undefined;
}

func_704C(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_4 = var_0;
          var_3 = func_0A0D::func_9D44(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 1:
          var_4 = var_0 + 1;
          var_3 = func_0A0D::func_593B(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
      }
    }

    if(var_3 != anim.success) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.success;
}

func_70CE(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_4 = var_0;
          var_3 = func_0A0D::func_10015(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 1:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_5 = var_1.var_10B3A[var_1.var_0348];
          var_5.id = var_0 + 1;
          var_6 = var_1.var_D8BE[var_5.id];

          if(isDefined(var_6)) {
            var_5.var_4B1B = var_6;
          } else {
            var_5.var_4B1B = 0;
          }

          var_5.var_C21E = 4;
          var_5.var_71D4 = ::func_7083;
          return;
      }
    }

    if(var_3 != anim.success) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.success;
}

func_7143(var_0, var_1, var_2) {
  var_3 = var_0.var_D8BE[var_1];

  if(isDefined(var_3) && var_3 != -1) {
    if(var_3 == 1) {
      var_2.var_71D2 = ::func_710E;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 1);
      return;
    }
  }

  var_2.var_71D2 = undefined;
}

func_7083(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_4 = var_1.var_10B3A[var_1.var_0348];
          var_4.id = var_0;
          var_5 = var_1.var_D8BE[var_4.id];

          if(isDefined(var_5)) {
            var_4.var_4B1B = var_5;
          } else {
            var_4.var_4B1B = 0;
          }

          var_4.var_C21E = 2;
          var_4.var_71D4 = ::func_7086;
          return;
        case 1:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_4 = var_1.var_10B3A[var_1.var_0348];
          var_4.id = var_0 + 1;
          var_5 = var_1.var_D8BE[var_4.id];

          if(isDefined(var_5)) {
            var_4.var_4B1B = var_5;
          } else {
            var_4.var_4B1B = 0;
          }

          var_4.var_C21E = 3;
          var_4.var_71D4 = ::func_7084;
          return;
        case 2:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_4 = var_1.var_10B3A[var_1.var_0348];
          var_4.id = var_0 + 2;
          var_5 = var_1.var_D8BE[var_4.id];

          if(isDefined(var_5)) {
            var_4.var_4B1B = var_5;
          } else {
            var_4.var_4B1B = 0;
          }

          var_4.var_C21E = 3;
          var_4.var_71D4 = ::func_7085;
          return;
        case 3:
          var_6 = var_0 + 3;

          if(!isDefined(var_1.var_D8BE[var_6])) {
            func_0A0D::func_7221(var_6);
          }

          var_3 = func_0A0D::follow(var_6);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_6] = -1;
          } else {
            func_0A0D::func_7231(var_6);
          }

          break;
      }
    }

    if(var_3 != anim.failure) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.failure;
}

func_710E(var_0, var_1, var_2) {
  var_3 = var_0.var_D8BE[var_1];

  if(isDefined(var_3) && var_3 != -1) {
    if(var_3 == 1) {
      var_2.var_71D2 = ::func_710F;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 1);
      return;
    } else if(var_3 == 2) {
      var_2.var_71D2 = ::func_7110;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 2);
      return;
    } else if(var_3 == 3)
      func_0A0D::func_7231(scripts\aitypes\bt_util::bt_getchildtaskid(var_1, var_3));
  }

  var_2.var_71D2 = undefined;
}

func_7086(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_4 = var_0;
          var_3 = func_0A0D::func_9E00(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 1:
          var_4 = var_0 + 1;
          var_3 = func_0A0D::func_61C4(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
      }
    }

    if(var_3 != anim.success) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.success;
}

func_7084(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_4 = var_0;
          var_3 = func_0A0D::func_10016(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 1:
          var_4 = var_0 + 1;
          var_3 = func_0A0D::func_F711(var_4, scripts\aitypes\bt_util::func_0076(var_4));

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 2:
          var_4 = var_0 + 2;
          var_3 = func_0A0D::func_7232(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          } else {
            func_0A0D::func_7234(var_4);
          }

          break;
      }
    }

    if(var_3 != anim.success) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.success;
}

func_710F(var_0, var_1, var_2) {
  var_3 = var_0.var_D8BE[var_1];

  if(isDefined(var_3) && var_3 != -1) {
    if(var_3 == 2) {
      func_0A0D::func_7234(scripts\aitypes\bt_util::bt_getchildtaskid(var_1, var_3));
    }
  }

  var_2.var_71D2 = undefined;
}

func_7085(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_4 = var_0;
          var_3 = func_0A0D::func_9E77(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 1:
          var_4 = var_0 + 1;
          var_3 = func_0A0D::func_F711(var_4, scripts\aitypes\bt_util::func_0076(var_4));

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 2:
          var_4 = var_0 + 2;

          if(!isDefined(var_1.var_D8BE[var_4])) {
            func_0A0D::func_7221(var_4);
          }

          var_3 = func_0A0D::follow(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          } else {
            func_0A0D::func_7231(var_4);
          }

          break;
      }
    }

    if(var_3 != anim.success) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.success;
}

func_7110(var_0, var_1, var_2) {
  var_3 = var_0.var_D8BE[var_1];

  if(isDefined(var_3) && var_3 != -1) {
    if(var_3 == 2) {
      func_0A0D::func_7231(scripts\aitypes\bt_util::bt_getchildtaskid(var_1, var_3));
    }
  }

  var_2.var_71D2 = undefined;
}

func_70D1(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_4 = var_0;
          var_3 = func_0A0D::func_10027(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 1:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_5 = var_1.var_10B3A[var_1.var_0348];
          var_5.id = var_0 + 1;
          var_6 = var_1.var_D8BE[var_5.id];

          if(isDefined(var_6)) {
            var_5.var_4B1B = var_6;
          } else {
            var_5.var_4B1B = 0;
          }

          var_5.var_C21E = 2;
          var_5.var_71D4 = ::func_7092;
          return;
      }
    }

    if(var_3 != anim.success) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.success;
}

func_7146(var_0, var_1, var_2) {
  var_3 = var_0.var_D8BE[var_1];

  if(isDefined(var_3) && var_3 != -1) {
    if(var_3 == 1) {
      var_2.var_71D2 = ::func_7119;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 1);
      return;
    }
  }

  var_2.var_71D2 = undefined;
}

func_7092(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_4 = var_1.var_10B3A[var_1.var_0348];
          var_4.id = var_0;
          var_4.var_4B1B = 0;
          var_4.var_C21E = 3;
          var_4.var_71D4 = ::func_70D2;
          return;
        case 1:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_4 = var_1.var_10B3A[var_1.var_0348];
          var_4.id = var_0 + 1;
          var_5 = var_1.var_D8BE[var_4.id];

          if(isDefined(var_5)) {
            var_4.var_4B1B = var_5;
          } else {
            var_4.var_4B1B = 0;
          }

          var_4.var_C21E = 4;
          var_4.var_71D4 = ::func_7093;
          return;
      }
    }

    if(var_3 != anim.failure) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.failure;
}

func_7119(var_0, var_1, var_2) {
  var_3 = var_0.var_D8BE[var_1];

  if(isDefined(var_3) && var_3 != -1) {
    if(var_3 == 0) {
      var_2.var_71D2 = ::func_7147;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 0);
      return;
    }
  }

  var_2.var_71D2 = undefined;
}

func_70D2(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_4 = var_0;
          var_3 = func_0A0D::func_10028(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 1:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_5 = var_1.var_10B3A[var_1.var_0348];
          var_5.id = var_0 + 1;
          var_5.var_4B1B = 0;
          var_5.var_C21E = 3;
          var_5.var_71D4 = ::func_7094;
          return;
        case 2:
          var_4 = var_0 + 2;
          var_3 = func_0A0D::func_41B6(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
      }
    }

    if(var_3 != anim.success) {
      scripts\aitypes\bt_util::bt_terminateprevrunningaction(var_1, ::func_7147, var_2.id, var_2.var_4B1B);
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.success;
}

func_7147(var_0, var_1, var_2) {
  var_3 = var_0.var_D8BE[var_1];

  if(isDefined(var_3) && var_3 != -1) {
    if(var_3 == 1) {
      var_2.var_71D2 = ::func_711A;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 1);
      return;
    }
  }

  var_2.var_71D2 = undefined;
}

func_7094(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_4 = var_0;
          var_3 = func_0A0D::func_10075(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 1:
          var_4 = var_0 + 1;
          var_3 = func_0A0D::func_F748(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 2:
          var_4 = var_0 + 2;

          if(!isDefined(var_1.var_D8BE[var_4])) {
            func_0A0D::func_98E0(var_4);
          }

          var_3 = func_0A0D::func_136C0(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          } else {
            func_0A0D::func_11704(var_4);
          }

          break;
      }
    }

    if(var_3 != anim.success) {
      scripts\aitypes\bt_util::bt_terminateprevrunningaction(var_1, ::func_711A, var_2.id, var_2.var_4B1B);
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.success;
}

func_711A(var_0, var_1, var_2) {
  var_3 = var_0.var_D8BE[var_1];

  if(isDefined(var_3) && var_3 != -1) {
    if(var_3 == 2) {
      func_0A0D::func_11704(scripts\aitypes\bt_util::bt_getchildtaskid(var_1, var_3));
    }
  }

  var_2.var_71D2 = undefined;
}

func_7093(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_4 = var_0;
          var_3 = func_0A0D::func_F711(var_4, scripts\aitypes\bt_util::func_0076(var_4));

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 1:
          var_4 = var_0 + 1;
          var_3 = func_0A0D::func_F706(var_4, scripts\aitypes\bt_util::func_0076(var_4));

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 2:
          var_4 = var_0 + 2;
          var_3 = func_0A0D::func_F7C9(var_4, scripts\aitypes\bt_util::func_0076(var_4));

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 3:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_5 = var_1.var_10B3A[var_1.var_0348];
          var_5.id = var_0 + 3;
          var_6 = var_1.var_D8BE[var_5.id];

          if(isDefined(var_6)) {
            var_5.var_4B1B = var_6;
          } else {
            var_5.var_4B1B = 0;
          }

          var_5.var_C21E = 2;
          var_5.var_71D4 = ::func_7095;
          return;
      }
    }

    if(var_3 != anim.success) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.success;
}

func_7095(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_4 = var_1.var_10B3A[var_1.var_0348];
          var_4.id = var_0;
          var_5 = var_1.var_D8BE[var_4.id];

          if(isDefined(var_5)) {
            var_4.var_4B1B = var_5;
          } else {
            var_4.var_4B1B = 0;
          }

          var_4.var_C21E = 2;
          var_4.var_71D4 = ::func_7096;
          return;
        case 1:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_4 = var_1.var_10B3A[var_1.var_0348];
          var_4.id = var_0 + 1;
          var_5 = var_1.var_D8BE[var_4.id];

          if(isDefined(var_5)) {
            var_4.var_4B1B = var_5;
          } else {
            var_4.var_4B1B = 0;
          }

          var_4.var_C21E = 3;
          var_4.var_71D4 = ::func_7097;
          return;
      }
    }

    if(var_3 != anim.failure) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.failure;
}

func_7096(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_4 = var_0;
          var_3 = func_0A0D::func_1002B(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 1:
          var_4 = var_0 + 1;
          var_3 = func_0A0D::func_90F2(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
      }
    }

    if(var_3 != anim.success) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.success;
}

func_7097(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_4 = var_0;
          var_3 = func_0A0D::func_F706(var_4, scripts\aitypes\bt_util::func_0076(var_4));

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 1:
          var_4 = var_0 + 1;
          var_3 = func_0A0D::func_F7C9(var_4, scripts\aitypes\bt_util::func_0076(var_4));

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 2:
          var_4 = var_0 + 2;

          if(!isDefined(var_1.var_D8BE[var_4])) {
            func_0A09::func_FAF6(var_4);
          }

          var_3 = func_0A09::func_5AEA(var_4, scripts\aitypes\bt_util::func_0076(var_4));

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
      }
    }

    if(var_3 != anim.success) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.success;
}

func_70D0(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_4 = var_0;
          var_3 = func_0A0D::func_8C2C(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 1:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_5 = var_1.var_10B3A[var_1.var_0348];
          var_5.id = var_0 + 1;
          var_6 = var_1.var_D8BE[var_5.id];

          if(isDefined(var_6)) {
            var_5.var_4B1B = var_6;
          } else {
            var_5.var_4B1B = 0;
          }

          var_5.var_C21E = 2;
          var_5.var_71D4 = ::func_708A;
          return;
      }
    }

    if(var_3 != anim.success) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.success;
}

func_7145(var_0, var_1, var_2) {
  var_3 = var_0.var_D8BE[var_1];

  if(isDefined(var_3) && var_3 != -1) {
    if(var_3 == 1) {
      var_2.var_71D2 = ::func_7112;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 1);
      return;
    }
  }

  var_2.var_71D2 = undefined;
}

func_708A(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_4 = var_1.var_10B3A[var_1.var_0348];
          var_4.id = var_0;
          var_5 = var_1.var_D8BE[var_4.id];

          if(isDefined(var_5)) {
            var_4.var_4B1B = var_5;
          } else {
            var_4.var_4B1B = 0;
          }

          var_4.var_C21E = 2;
          var_4.var_71D4 = ::func_70CF;
          return;
        case 1:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_4 = var_1.var_10B3A[var_1.var_0348];
          var_4.id = var_0 + 1;
          var_5 = var_1.var_D8BE[var_4.id];

          if(isDefined(var_5)) {
            var_4.var_4B1B = var_5;
          } else {
            var_4.var_4B1B = 0;
          }

          var_4.var_C21E = 2;
          var_4.var_71D4 = ::func_708B;
          return;
      }
    }

    if(var_3 != anim.failure) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.failure;
}

func_7112(var_0, var_1, var_2) {
  var_3 = var_0.var_D8BE[var_1];

  if(isDefined(var_3) && var_3 != -1) {
    if(var_3 == 0) {
      var_2.var_71D2 = ::func_7144;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 0);
      return;
    } else if(var_3 == 1) {
      var_2.var_71D2 = ::func_7113;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 1);
      return;
    }
  }

  var_2.var_71D2 = undefined;
}

func_70CF(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_4 = var_0;
          var_3 = func_0A0D::func_10017(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 1:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_5 = var_1.var_10B3A[var_1.var_0348];
          var_5.id = var_0 + 1;
          var_5.var_4B1B = 0;
          var_5.var_C21E = 2;
          var_5.var_71D4 = ::func_7087;
          return;
      }
    }

    if(var_3 != anim.success) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.success;
}

func_7144(var_0, var_1, var_2) {
  var_3 = var_0.var_D8BE[var_1];

  if(isDefined(var_3) && var_3 != -1) {
    if(var_3 == 1) {
      var_2.var_71D2 = ::func_7111;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 1);
      return;
    }
  }

  var_2.var_71D2 = undefined;
}

func_7087(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_4 = var_0;
          var_3 = func_0A0D::func_B4DB(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 1:
          var_4 = var_0 + 1;

          if(!isDefined(var_1.var_D8BE[var_4])) {
            func_0A0D::func_724A(var_4);
          }

          var_3 = func_0A0D::func_7248(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          } else {
            func_0A0D::func_724B(var_4);
          }

          break;
      }
    }

    if(var_3 != anim.failure) {
      scripts\aitypes\bt_util::bt_terminateprevrunningaction(var_1, ::func_7111, var_2.id, var_2.var_4B1B);
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.failure;
}

func_7111(var_0, var_1, var_2) {
  var_3 = var_0.var_D8BE[var_1];

  if(isDefined(var_3) && var_3 != -1) {
    if(var_3 == 1) {
      func_0A0D::func_724B(scripts\aitypes\bt_util::bt_getchildtaskid(var_1, var_3));
    }
  }

  var_2.var_71D2 = undefined;
}

func_708B(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_4 = var_0;
          var_3 = func_0A0D::func_6CAB(var_4, scripts\aitypes\bt_util::func_0076(var_4));

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 1:
          var_4 = var_0 + 1;

          if(!isDefined(var_1.var_D8BE[var_4])) {
            func_0A0D::func_98E0(var_4);
          }

          var_3 = func_0A0D::func_136C0(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          } else {
            func_0A0D::func_11704(var_4);
          }

          break;
      }
    }

    if(var_3 != anim.success) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.success;
}

func_7113(var_0, var_1, var_2) {
  var_3 = var_0.var_D8BE[var_1];

  if(isDefined(var_3) && var_3 != -1) {
    if(var_3 == 1) {
      func_0A0D::func_11704(scripts\aitypes\bt_util::bt_getchildtaskid(var_1, var_3));
    }
  }

  var_2.var_71D2 = undefined;
}

func_70CD(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_4 = var_0;
          var_3 = func_0A0D::func_9D6A(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 1:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_5 = var_1.var_10B3A[var_1.var_0348];
          var_5.id = var_0 + 1;
          var_6 = var_1.var_D8BE[var_5.id];

          if(isDefined(var_6)) {
            var_5.var_4B1B = var_6;
          } else {
            var_5.var_4B1B = 0;
          }

          var_5.var_C21E = 7;
          var_5.var_71D4 = func_0C1D::func_707F;
          return;
      }
    }

    if(var_3 != anim.success) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.success;
}

func_7142(var_0, var_1, var_2) {
  var_3 = var_0.var_D8BE[var_1];

  if(isDefined(var_3) && var_3 != -1) {
    if(var_3 == 1) {
      var_2.var_71D2 = func_0C1D::func_710A;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 1);
      return;
    }
  }

  var_2.var_71D2 = undefined;
}

func_70CC(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_4 = var_0;
          var_3 = func_0A0D::func_8C3A(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 1:
          var_4 = var_0 + 1;
          var_3 = func_0A0D::func_8C2C(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 2:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_5 = var_1.var_10B3A[var_1.var_0348];
          var_5.id = var_0 + 2;
          var_6 = var_1.var_D8BE[var_5.id];

          if(isDefined(var_6)) {
            var_5.var_4B1B = var_6;
          } else {
            var_5.var_4B1B = 0;
          }

          var_5.var_C21E = 3;
          var_5.var_71D4 = ::func_7062;
          return;
      }
    }

    if(var_2.var_4B1B == 1) {
      var_3 = scripts\aitypes\bt_util::bt_negateresult(var_3);
    }

    if(var_3 != anim.success) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.success;
}

func_7141(var_0, var_1, var_2) {
  var_3 = var_0.var_D8BE[var_1];

  if(isDefined(var_3) && var_3 != -1) {
    if(var_3 == 2) {
      var_2.var_71D2 = ::func_70F2;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 2);
      return;
    }
  }

  var_2.var_71D2 = undefined;
}

func_7062(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_4 = var_1.var_10B3A[var_1.var_0348];
          var_4.id = var_0;
          var_5 = var_1.var_D8BE[var_4.id];

          if(isDefined(var_5)) {
            var_4.var_4B1B = var_5;
          } else {
            var_4.var_4B1B = 0;
          }

          var_4.var_C21E = 2;
          var_4.var_71D4 = ::func_704D;
          return;
        case 1:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_4 = var_1.var_10B3A[var_1.var_0348];
          var_4.id = var_0 + 1;
          var_5 = var_1.var_D8BE[var_4.id];

          if(isDefined(var_5)) {
            var_4.var_4B1B = var_5;
          } else {
            var_4.var_4B1B = 0;
          }

          var_4.var_C21E = 4;
          var_4.var_71D4 = ::func_70A6;
          return;
        case 2:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_4 = var_1.var_10B3A[var_1.var_0348];
          var_4.id = var_0 + 2;
          var_5 = var_1.var_D8BE[var_4.id];

          if(isDefined(var_5)) {
            var_4.var_4B1B = var_5;
          } else {
            var_4.var_4B1B = 0;
          }

          var_4.var_C21E = 2;
          var_4.var_71D4 = ::func_70B5;
          return;
      }
    }

    if(var_3 != anim.failure) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.failure;
}

func_70F2(var_0, var_1, var_2) {
  var_3 = var_0.var_D8BE[var_1];

  if(isDefined(var_3) && var_3 != -1) {
    if(var_3 == 0) {
      var_2.var_71D2 = ::func_70E2;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 0);
      return;
    } else if(var_3 == 1) {
      var_2.var_71D2 = ::func_7126;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 1);
      return;
    } else if(var_3 == 2) {
      var_2.var_71D2 = ::func_7130;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 2);
      return;
    }
  }

  var_2.var_71D2 = undefined;
}

func_704D(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_4 = var_0;
          var_3 = func_0A0D::func_FFBE(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 1:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_5 = var_1.var_10B3A[var_1.var_0348];
          var_5.id = var_0 + 1;
          var_6 = var_1.var_D8BE[var_5.id];

          if(isDefined(var_6)) {
            var_5.var_4B1B = var_6;
          } else {
            var_5.var_4B1B = 0;
          }

          var_5.var_C21E = 2;
          var_5.var_71D4 = ::func_716F;
          return;
      }
    }

    if(var_3 != anim.success) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.success;
}

func_70E2(var_0, var_1, var_2) {
  var_3 = var_0.var_D8BE[var_1];

  if(isDefined(var_3) && var_3 != -1) {
    if(var_3 == 1) {
      var_2.var_71D2 = ::func_715E;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 1);
      return;
    }
  }

  var_2.var_71D2 = undefined;
}

func_716F(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_4 = var_1.var_10B3A[var_1.var_0348];
          var_4.id = var_0;
          var_5 = var_1.var_D8BE[var_4.id];

          if(isDefined(var_5)) {
            var_4.var_4B1B = var_5;
          } else {
            var_4.var_4B1B = 0;
          }

          var_4.var_C21E = 6;
          var_4.var_71D4 = ::func_704E;
          return;
        case 1:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_4 = var_1.var_10B3A[var_1.var_0348];
          var_4.id = var_0 + 1;
          var_4.var_4B1B = 0;
          var_4.var_C21E = 7;
          var_4.var_71D4 = ::func_704F;
          return;
      }
    }

    if(var_3 != anim.failure) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.failure;
}

func_715E(var_0, var_1, var_2) {
  var_3 = var_0.var_D8BE[var_1];

  if(isDefined(var_3) && var_3 != -1) {
    if(var_3 == 1) {
      var_2.var_71D2 = ::func_70E3;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 1);
      return;
    }
  }

  var_2.var_71D2 = undefined;
}

func_704E(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_4 = var_0;
          var_3 = func_0A0D::func_10029(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 1:
          var_4 = var_0 + 1;
          var_3 = func_0A0D::func_F748(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 2:
          var_4 = var_0 + 2;
          var_3 = func_0A0D::func_C936(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 3:
          var_4 = var_0 + 3;
          var_3 = func_0A0D::func_F7C9(var_4, scripts\aitypes\bt_util::func_0076(var_4));

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 4:
          var_4 = var_0 + 4;
          var_3 = func_0A0D::func_F706(var_4, scripts\aitypes\bt_util::func_0076(var_4));

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 5:
          var_4 = var_0 + 5;

          if(!isDefined(var_1.var_D8BE[var_4])) {
            func_0A09::func_FAF6(var_4);
          }

          var_3 = func_0A09::func_5AEA(var_4, scripts\aitypes\bt_util::func_0076(var_4));

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
      }
    }

    if(var_3 != anim.success) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.success;
}

func_704F(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_4 = var_0;
          var_3 = func_0A0D::func_FFD6(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 1:
          var_4 = var_0 + 1;
          var_3 = func_0A0D::func_10E66(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 2:
          var_4 = var_0 + 2;
          var_3 = func_0A0D::func_6CAB(var_4, scripts\aitypes\bt_util::func_0076(var_4));

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 3:
          var_4 = var_0 + 3;
          var_3 = func_0A0D::func_F672(var_4, scripts\aitypes\bt_util::func_0076(var_4));

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 4:
          var_4 = var_0 + 4;
          var_3 = func_0A0D::func_F72A(var_4, scripts\aitypes\bt_util::func_0076(var_4));

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 5:
          var_4 = var_0 + 5;
          var_3 = func_0A0D::func_F706(var_4, scripts\aitypes\bt_util::func_0076(var_4));

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 6:
          var_4 = var_0 + 6;

          if(!isDefined(var_1.var_D8BE[var_4])) {
            func_0A0D::func_98E0(var_4);
          }

          var_3 = func_0A0D::func_136C0(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          } else {
            func_0A0D::func_11704(var_4);
          }

          break;
      }
    }

    if(var_3 != anim.success) {
      scripts\aitypes\bt_util::bt_terminateprevrunningaction(var_1, ::func_70E3, var_2.id, var_2.var_4B1B);
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.success;
}

func_70E3(var_0, var_1, var_2) {
  var_3 = var_0.var_D8BE[var_1];

  if(isDefined(var_3) && var_3 != -1) {
    if(var_3 == 6) {
      func_0A0D::func_11704(scripts\aitypes\bt_util::bt_getchildtaskid(var_1, var_3));
    }
  }

  var_2.var_71D2 = undefined;
}

func_70A6(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_4 = var_0;
          var_3 = func_0A0D::func_1003E(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 1:
          var_4 = var_0 + 1;
          var_3 = func_0A0D::func_F748(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 2:
          var_4 = var_0 + 2;
          var_3 = func_0A0D::func_C936(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 3:
          var_4 = var_0 + 3;

          if(!isDefined(var_1.var_D8BE[var_4])) {
            func_0A0D::func_98E0(var_4);
          }

          var_3 = func_0A0D::func_136C0(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          } else {
            func_0A0D::func_11704(var_4);
          }

          break;
      }
    }

    if(var_3 != anim.success) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.success;
}

func_7126(var_0, var_1, var_2) {
  var_3 = var_0.var_D8BE[var_1];

  if(isDefined(var_3) && var_3 != -1) {
    if(var_3 == 3) {
      func_0A0D::func_11704(scripts\aitypes\bt_util::bt_getchildtaskid(var_1, var_3));
    }
  }

  var_2.var_71D2 = undefined;
}

func_70B5(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_4 = var_0;
          var_3 = func_0A0D::func_1006C(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 1:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_5 = var_1.var_10B3A[var_1.var_0348];
          var_5.id = var_0 + 1;
          var_6 = var_1.var_D8BE[var_5.id];

          if(isDefined(var_6)) {
            var_5.var_4B1B = var_6;
          } else {
            var_5.var_4B1B = 0;
          }

          var_5.var_C21E = 7;
          var_5.var_71D4 = func_0C1D::func_707F;
          return;
      }
    }

    if(var_3 != anim.success) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.success;
}

func_7130(var_0, var_1, var_2) {
  var_3 = var_0.var_D8BE[var_1];

  if(isDefined(var_3) && var_3 != -1) {
    if(var_3 == 1) {
      var_2.var_71D2 = func_0C1D::func_710A;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 1);
      return;
    }
  }

  var_2.var_71D2 = undefined;
}

func_70D3(var_0, var_1, var_2, var_3) {
  while(var_2.var_4B1B < var_2.var_C21E) {
    if(!isDefined(var_3)) {
      switch (var_2.var_4B1B) {
        case 0:
          var_4 = var_0;
          var_3 = func_0A0D::func_1003F(var_4);

          if(var_3 == anim.running) {
            var_1.var_E87F[var_4] = -1;
          }

          break;
        case 1:
          var_1.var_0348 = var_1.var_0348 + 1;
          var_5 = var_1.var_10B3A[var_1.var_0348];
          var_5.id = var_0 + 1;
          var_6 = var_1.var_D8BE[var_5.id];

          if(isDefined(var_6)) {
            var_5.var_4B1B = var_6;
          } else {
            var_5.var_4B1B = 0;
          }

          var_5.var_C21E = 7;
          var_5.var_71D4 = func_0C1D::func_707F;
          return;
      }
    }

    if(var_3 != anim.success) {
      return var_3;
    }

    var_2.var_4B1B++;
    var_3 = undefined;
  }

  return anim.success;
}

func_7148(var_0, var_1, var_2) {
  var_3 = var_0.var_D8BE[var_1];

  if(isDefined(var_3) && var_3 != -1) {
    if(var_3 == 1) {
      var_2.var_71D2 = func_0C1D::func_710A;
      var_2.taskid = scripts\aitypes\bt_util::bt_getchildtaskid(var_1, 1);
      return;
    }
  }

  var_2.var_71D2 = undefined;
}

bt_registertaskargs(var_0) {
  var_0.var_1158E[20] = ::func_7171;
  var_0.var_1158E[23] = ::func_7172;
  var_0.var_1158E[35] = ::func_7172;
  var_0.var_1158E[36] = ::func_7173;
  var_0.var_1158E[37] = ::func_7174;
  var_0.var_1158E[43] = ::func_7173;
  var_0.var_1158E[44] = ::func_7174;
  var_0.var_1158E[45] = ::func_7175;
  var_0.var_1158E[54] = ::func_7176;
  var_0.var_1158E[71] = ::func_7174;
  var_0.var_1158E[72] = ::func_7173;
  var_0.var_1158E[73] = ::func_7177;
  var_0.var_1158E[76] = ::func_7178;
  var_0.var_1158E[77] = ::func_7179;
  var_0.var_1158E[78] = ::func_717A;
  var_0.var_1158E[79] = ::func_7173;
}

func_7171() {
  var_0 = [];
  var_0[0] = "fly";
  return var_0;
}

func_7172() {
  var_0 = [];
  var_0[0] = "hover";
  return var_0;
}

func_7173() {
  var_0 = [];
  var_0[0] = "shoot_at_will";
  return var_0;
}

func_7174() {
  var_0 = [];
  var_0[0] = "face enemy";
  return var_0;
}

func_7175() {
  var_0 = [];
  var_0[0] = 1500;
  return var_0;
}

func_7176() {
  var_0 = [];
  var_0[0] = "spline";
  return var_0;
}

func_7177() {
  var_0 = [];
  var_0[0] = 5000;
  return var_0;
}

func_7178() {
  var_0 = [];
  var_0[0] = "attack";
  return var_0;
}

func_7179() {
  var_0 = [];
  var_0[0] = "face motion";
  return var_0;
}

func_717A() {
  var_0 = [];
  var_0[0] = 2048;
  return var_0;
}