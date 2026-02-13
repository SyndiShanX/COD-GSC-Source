/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2577.gsc
*************************************************/

_id_A06C() {
  var_0 = spawnStruct();
  level._id_A02C = var_0;
  var_0._id_9C9A = getdvarint("#x39e8954187fd1d7b0", 100);
  var_0._id_9C5B = getdvarint("#x34c8a7e6c8bfb0fd7", 8);
  var_0._id_7D42 = getdvarint("#x3d2a4e90e4d307a76", 1) > 0;
  var_0._id_F953 = 0;
  var_0._id_B9DB = [];
  var_0._id_CF26 = [];
  var_0._id_F632 = [];
  var_0._id_5F3E = 0;
  var_0._id_3319 = 0;
  _id_A06D();
  _id_A06E();
}

_id_A06D() {
  var_0 = _id_A065();
  var_1 = var_0._id_330B;

  if(!isDefined(var_1)) {
    var_1 = spawnStruct();
    var_0._id_330B = var_1;
  }

  var_1._id_4BA2 = [];
  var_1._id_4BA1 = [];
  var_1._id_4BBF = [];
  var_1._id_9C5A = [];
  var_1._id_9C6F = [];
  var_1._id_9C6B = [];
  var_1._id_5BCE = [];
  var_1._id_5BD0 = [];
  var_1._id_5BD1 = [];
  var_2 = 4;
  var_1._id_4BA2[var_2] = undefined;
  var_1._id_4BA1[var_2] = undefined;
  var_1._id_4BBF[var_2] = undefined;
  var_1._id_9C5A[var_2] = undefined;
  var_1._id_9C6F[var_2] = undefined;
  var_1._id_9C6B[var_2] = 1;
  var_2 = 8;
  var_1._id_4BA2[var_2] = 50;
  var_1._id_4BA1[var_2] = 50;
  var_1._id_4BBF[var_2] = 25;
  var_1._id_9C5A[var_2] = 4;
  var_1._id_9C6F[var_2] = 3;
  var_1._id_9C6B[var_2] = 1;
  var_1._id_4BA3[var_2] = 25;
  var_2 = 16;
  var_1._id_4BA2[var_2] = 15;
  var_1._id_4BA1[var_2] = 50;
  var_1._id_4BBF[var_2] = 25;
  var_1._id_9C5A[var_2] = 17;
  var_1._id_9C6F[var_2] = 3;
  var_1._id_9C6B[var_2] = 3;
  var_1._id_5BCE[var_2] = 85;
  var_1._id_5BD0[var_2] = 8;
  var_1._id_4BA3[var_2] = 8;
  var_1._id_5BCF[var_2] = 44;
}

_id_A06E() {
  var_0 = _id_A065();
  var_1 = var_0._id_B9D9;

  if(!isDefined(var_1)) {
    var_1 = spawnStruct();
    var_0._id_B9D9 = var_1;
  }

  var_1._id_F630 = [];
  var_1._id_F626 = [];
  var_1._id_F62D = [];
  var_1._id_E698 = [];
  var_2 = 4;
  var_1._id_F630[var_2] = 30;
  var_1._id_F626[var_2] = 55;
  var_1._id_F62D[var_2] = 15;
  var_1._id_E698[var_2] = 0;
  var_2 = 8;
  var_1._id_F630[var_2] = 30;
  var_1._id_F626[var_2] = 55;
  var_1._id_F62D[var_2] = 15;
  var_1._id_E698[var_2] = 100;
  var_2 = 16;
  var_1._id_F630[var_2] = 10;
  var_1._id_F626[var_2] = 55;
  var_1._id_F62D[var_2] = 15;
  var_1._id_E698[var_2] = 100;
  _id_A06F();
}

_id_A06F() {
  var_0 = _id_A068();
  var_1 = [];
  var_1[4] = "coreCenter";
  var_1[8] = "core";
  var_1[16] = "tendril";
  var_1[1] = "";
  var_1[2] = "DieDown";
  var_1[32] = "";
  var_1[64] = "Wall";
  var_1[128] = "Ceil";
  var_2 = [];
  var_3 = 1;
  var_4 = 4;
  var_5 = 32;

  for(var_6 = var_3;
    (var_6 & 3) > 0; var_6 = var_6 << 1) {
    for(var_7 = var_4;
      (var_7 & 28) > 0; var_7 = var_7 << 1) {
      for(var_8 = var_5;
        (var_8 & 224) > 0; var_8 = var_8 << 1) {
        var_9 = var_6 | var_7 | var_8;
        var_2[var_9] = var_1[var_7] + var_1[var_6] + var_1[var_8];
        var_9 = var_7 | var_8;
        var_2[var_9] = "neutral";
      }
    }
  }

  var_0._id_CF2E = var_2;
}

_id_A073(var_0, var_1) {
  thread _id_A09B();
}

_id_A075(var_0, var_1) {
  self notify("molotov_taken");
}

_id_A098(var_0) {
  var_0 endon("death");
  var_1 = self _meth_8599();
  var_2 = gettime();
  var_3 = anglesToForward(var_1) * 940 + anglestoup(var_1) * 120;
  thread _id_A042(var_0);
  var_0 waittill("missile_stuck", var_4);

  if(isDefined(level._id_60D2)) {
    [[level._id_60D2]](var_0, self);
  }

  var_5 = (gettime() - var_2) / 1000;
  var_6 = var_3 + (0, 0, -800 * var_5);

  if(isDefined(var_4) && isPlayer(var_4)) {
    thread _id_A08F(var_0, var_4, var_1, var_6);
  } else {
    thread _id_A08E(var_0, var_4, var_1, var_6);
  }
}

_id_A08E(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = vectornormalize(var_3);
  var_6 = anglestoup(var_0.angles);
  var_7 = anglestoright(var_2);

  if(abs(vectordot(var_5, var_6)) >= 0.9848) {
    var_4 = _id_A07B(var_6, var_7);
  } else {
    var_4 = _id_A07A(var_6, var_5);
  }

  var_0.angles = var_4;
  var_0 notify("death");
  var_0._id_57CE = 1;
  var_0 setscriptablepartstate("effects", "explode", 0);
  var_0 _meth_8647();
  _id_A087(var_0, var_0.origin, var_4, var_1, var_3, gettime());
}

_id_A08F(var_0, var_1, var_2, var_3) {
  scripts\mp\weapons::_id_717C(var_0, var_1);
  var_1 thread _id_A037(6, self, var_0, var_0);
  var_0._id_57CE = 1;
  var_0 setscriptablepartstate("effects", "explode", 0);
  var_0 _meth_8647();
  var_3 = var_3 * (0, 0, 1);
  var_4 = var_0.origin;
  var_5 = (0, 0, -1);
  var_6 = var_4 + var_5 * 128;
  var_7 = _id_A060();
  var_8 = _func_02C1(var_4, var_6, var_7, var_0, 0, "physicsquery_closest", 1);

  if(isDefined(var_8) && var_8.size > 0) {
    var_6 = var_8[0]["position"];
    var_9 = var_8[0]["normal"];
    var_10 = var_8[0]["entity"];
    var_6 = var_6 - var_9 * 1;
    var_11 = vectordot(var_6 - var_4, var_5);
    var_12 = _func_0218(2 * var_11 / 800);
    var_13 = var_9;
    var_14 = anglestoright(var_2);
    var_15 = _id_A07B(var_13, var_14);
    thread _id_A087(var_0, var_6, var_15, var_10, var_3, gettime() + var_12 * 1000);
    return;
  }

  var_0 notify("death");
  waitframe();

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_A0A0(var_0) {
  if(!scripts\mp\bots\bots_util::_id_270B()) {
    return;
  }
  var_1 = _func_02B2(var_0, (128, 128, 100), (0, 0, 0));
  return var_1;
}

_id_A087(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_0.owner;

  if(!istrue(level._id_434D)) {
    var_7 = scripts\engine\utility::ter_op(level.players.size > 15, 10, 20);
    _id_0817::_id_1135(var_1 - (0, 0, 128), 225, 256, var_6.team, var_7, var_6, 1);
  }

  var_8 = anglestoup(var_2);
  var_9 = var_1 + var_8 * 1;
  var_10 = var_9 + var_8 * 25;
  var_11 = _id_A060();
  var_12 = _func_02C1(var_9, var_10, var_11, var_0, 0, "physicsquery_closest", 1);

  if(isDefined(var_12) && var_12.size > 0) {
    var_10 = var_12[0]["position"] - var_8 * 1;
  }

  var_13 = var_10;
  var_14 = var_0;
  var_14 thread _id_A03E();
  var_15 = _id_A066();
  var_16 = 0;
  var_17 = vectordot(vectornormalize(var_4), -1 * var_8);

  if(var_17 < 0.96593) {
    var_16 = 1;
  }

  var_18 = _id_A04B(var_6, var_5, var_14, var_15);
  var_18._id_20ED = _id_A0A0(var_1);
  var_18 thread _id_A03C();
  var_19 = 4;
  var_20 = _id_A061(var_19);
  var_21 = _id_A067(var_19);
  var_22 = _id_A048(var_18, var_20, var_21, undefined, var_1, var_2, var_3);
  var_18._id_2B0E[var_18._id_2B0E.size] = var_22;
  var_23 = 25;
  var_24 = 65;
  var_25 = 115;
  var_26 = gettime() + var_21._id_E698;
  var_19 = 8;
  var_20 = _id_A061(var_19);
  var_21 = _id_A067(var_19);
  var_27 = ::_id_A034;

  if(var_16) {
    var_27 = ::_id_A02E;
  }

  var_22 = _id_A048(var_18, var_20, var_21, undefined, var_13, var_2, var_3, 0, var_26, var_27);
  var_18._id_2B0E[var_18._id_2B0E.size] = var_22;
  var_28 = anglesToForward(var_2);
  var_29 = anglestoright(var_2);
  var_30 = anglestoup(var_2);
  var_20 = _id_A061(var_19);
  var_21 = _id_A067(var_19);
  var_31 = var_28 * -1;
  var_32 = var_29 * -1;
  var_33 = var_30;
  var_34 = _func_0017(var_31, var_32, var_33);
  var_27 = ::_id_A034;

  if(var_16) {
    var_27 = undefined;
  }

  var_22 = _id_A048(var_18, var_20, var_21, undefined, var_13, var_34, var_3, 0, var_26, var_27);
  var_18._id_2B0E[var_18._id_2B0E.size] = var_22;
  var_20 = _id_A061(var_19);
  var_21 = _id_A067(var_19);
  var_31 = _func_01C6(var_30, var_28, var_24);
  var_32 = vectornormalize(_func_025B(var_31, var_30));
  var_33 = _func_025B(var_32, var_28);
  var_34 = _func_0017(var_31, var_32, var_33);
  var_27 = ::_id_A034;

  if(var_16) {
    var_27 = ::_id_A032;
  }

  var_22 = _id_A048(var_18, var_20, var_21, undefined, var_13, var_34, var_3, 0, var_26, var_27);
  var_18._id_2B0E[var_18._id_2B0E.size] = var_22;
  var_20 = _id_A061(var_19);
  var_21 = _id_A067(var_19);
  var_31 = _func_01C6(var_30, var_28, -1 * var_24);
  var_32 = vectornormalize(_func_025B(var_31, var_30));
  var_33 = _func_025B(var_32, var_28);
  var_34 = _func_0017(var_31, var_32, var_33);
  var_27 = ::_id_A034;

  if(var_16) {
    var_27 = ::_id_A030;
  }

  var_22 = _id_A048(var_18, var_20, var_21, undefined, var_13, var_34, var_3, 0, var_26, var_27);
  var_18._id_2B0E[var_18._id_2B0E.size] = var_22;
  var_20 = _id_A061(var_19);
  var_21 = _id_A067(var_19);
  var_31 = _func_01C6(var_30, var_28, var_25);
  var_32 = vectornormalize(_func_025B(var_31, var_30));
  var_33 = _func_025B(var_32, var_28);
  var_34 = _func_0017(var_31, var_32, var_33);
  var_27 = ::_id_A034;

  if(var_16) {
    var_27 = undefined;
  }

  var_22 = _id_A048(var_18, var_20, var_21, undefined, var_13, var_34, var_3, 0, var_26, var_27);
  var_18._id_2B0E[var_18._id_2B0E.size] = var_22;
  var_20 = _id_A061(var_19);
  var_21 = _id_A067(var_19);
  var_31 = _func_01C6(var_30, var_28, -1 * var_25);
  var_32 = vectornormalize(_func_025B(var_31, var_30));
  var_33 = _func_025B(var_32, var_28);
  var_34 = _func_0017(var_31, var_32, var_33);
  var_27 = ::_id_A034;

  if(var_16) {
    var_27 = undefined;
  }

  var_22 = _id_A048(var_18, var_20, var_21, undefined, var_13, var_34, var_3, 0, var_26, var_27);
  var_18._id_2B0E[var_18._id_2B0E.size] = var_22;
  _id_A07E(var_18);

  foreach(var_22 in var_18._id_2B0E) {
    var_22 thread _id_A089();
  }
}

_id_A03C() {
  self._id_2D95 scripts\engine\utility::_id_108F5("entitydeleted", 6.75);

  for(;;) {
    var_0 = 1;

    foreach(var_2 in self._id_2B0E) {
      if(!istrue(var_2._id_87B9)) {
        var_0 = 0;
        break;
      }

      if(!var_0) {
        break;
      }
    }

    if(var_0) {
      break;
    }

    waitframe();
  }

  if(isDefined(self._id_20ED)) {
    _func_02B1(self._id_20ED);
  }
}

_id_A04B(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.owner = var_0;
  var_4.team = var_0.team;
  var_4._id_7D57 = var_1;
  var_4._id_2D95 = var_2;
  var_4._id_2D85 = var_3;
  var_4._id_2B0E = [];
  var_4._id_CF21 = 0;
  var_4._id_331A = 0;
  var_4._id_3319 = 0;
  var_4._id_5F3E = gettime();
  var_4._id_330A = physics_createcontents(["physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
  var_2._id_D9B6 = var_4;
  return var_4;
}

_id_A07E(var_0) {
  var_0._id_331A++;
  var_0._id_3319++;
  var_0._id_5F3E = gettime();
  var_1 = _id_A065();
  var_1._id_3319++;
}

_id_A07F(var_0) {
  var_0._id_CF21++;
  var_1 = _id_A065();
  var_1._id_CF26[self._id_7C8C] = self;

  if(var_1._id_CF26.size > var_1._id_9C9A) {
    _id_A04C();
  }
}

_id_A080(var_0) {
  var_1 = _id_A065();
  var_1._id_F632[self._id_7C8C] = self;

  if(var_1._id_F632.size > var_1._id_9C9A) {
    _id_A04D();
  }
}

_id_A04F() {
  var_0 = _id_A065();
  var_0._id_CF26[self._id_7C8C] = undefined;
  var_1 = var_0._id_F632[self._id_7C8C];

  if(!isDefined(var_1)) {
    var_0._id_B9DB = scripts\engine\utility::array_remove(var_0._id_B9DB, self._id_7C8C);
  }

  self notify("death");
  self _meth_86BE();
}

_id_A050() {
  var_0 = _id_A065();
  var_0._id_F632[self._id_7C8C] = undefined;
  var_1 = var_0._id_CF26[self._id_7C8C];

  if(!isDefined(var_1)) {
    var_0._id_B9DB = scripts\engine\utility::array_remove(var_0._id_B9DB, self._id_7C8C);
  }

  self delete();
}

_id_A04C(var_0) {
  var_1 = _id_A065();
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_3 in var_1._id_B9DB) {
    var_2 = var_1._id_CF26[var_3];

    if(isDefined(var_2)) {
      break;
    }
  }

  var_0 = istrue(var_0) || var_1._id_7D42;

  if(!isDefined(var_2)) {
    _id_A04E(var_3, var_0);
  }
}

_id_A04D(var_0) {
  var_1 = _id_A065();
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_3 in var_1._id_B9DB) {
    var_2 = var_1._id_F632[var_3];

    if(isDefined(var_2)) {
      break;
    }
  }

  var_0 = istrue(var_0) || var_1._id_7D42;

  if(isDefined(var_2)) {
    _id_A04E(var_3, var_0);
  }
}

_id_A04E(var_0, var_1) {
  var_2 = _id_A065();
  var_3 = var_2._id_CF26[var_0];

  if(isDefined(var_3)) {
    if(!istrue(var_1)) {
      var_2._id_CF26[var_0] = undefined;
      var_2._id_F632[var_0] = undefined;
      var_2._id_B9DB = scripts\engine\utility::array_remove(var_2._id_B9DB, var_0);
      var_3 thread _id_A077();
      return;
    }

    var_3 thread _id_A04F();
  }

  var_4 = var_2._id_F632[var_0];

  if(isDefined(var_4)) {
    var_4 thread _id_A050();
  }
}

_id_A03B(var_0) {
  if(var_0._id_5F3E < gettime()) {
    var_0._id_5F3E = gettime();
    var_0._id_3319 = 0;
  }

  if(var_0._id_3319 >= 3) {
    return 0;
  }

  var_1 = _id_A065();

  if(var_1._id_5F3E < gettime()) {
    var_1._id_5F3E = gettime();
    var_1._id_3319 = 0;
  }

  if(var_1._id_3319 >= var_1._id_9C5B) {
    return 0;
  }

  return 1;
}

_id_A084(var_0) {
  var_1 = 0;
  var_2 = 60;
  var_3 = 20;

  if(self._id_331A >= var_2) {
    var_1 = 1;
  } else if(self._id_CF21 >= var_3) {
    var_1 = 1;
  } else if(istrue(var_0)) {
    var_4 = 1;

    foreach(var_6 in self._id_2B0E) {
      if(!var_6 _id_A035(1, 1)) {
        var_4 = 0;
        break;
      }
    }

    if(var_4) {
      var_1 = 1;
    }
  }

  if(var_1) {
    self._id_87B9 = 1;
    _id_A08D();
    self._id_2B0E = [];
  }

  return var_1;
}

_id_A08D() {
  var_0 = self;

  if(isDefined(self._id_D9B6)) {
    var_0 = self._id_D9B6;
  }

  if(!isDefined(var_0._id_AA28)) {
    var_0._id_AA28 = [];
  }

  foreach(var_2 in self._id_2B0E) {
    foreach(var_4 in var_2._id_5526) {
      if(isDefined(var_4)) {
        var_0._id_AA28[var_0._id_AA28.size] = var_4;
      }
    }
  }
}

_id_A048(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = spawnStruct();
  var_10._id_D9B6 = var_0;
  var_10._id_330B = var_1;
  var_10._id_B9D9 = var_2;
  var_10._id_E6D5 = var_4;
  var_10._id_E6C9 = var_5;
  var_10._id_E6D7 = var_6;
  var_10._id_E6CA = var_7;
  var_10._id_AA8C = var_9;
  var_10._id_5526 = [];
  var_10._id_2B0E = [];
  var_10._id_79B2 = [];
  var_10._id_79C2 = [];
  var_10._id_3316 = 0;
  var_10._id_3310 = 0;
  var_10._id_BC1D = var_8;
  return var_10;
}

_id_A089() {
  self endon("cleanup_branch");

  if(!isDefined(self._id_BC1D)) {
    self._id_BC1D = gettime();
  }

  if(!isDefined(self._id_E6CA)) {
    if(!self._id_D9B6 _id_A084()) {
      var_0 = _id_A031(self._id_E6D5, self._id_E6C9, self._id_E6D7);
      var_0 = var_0 thread _id_A078();
      self._id_87B9 = 1;
      self._id_D9B6 _id_A084(1);
    }
  } else {
    self._id_3317 = self._id_E6D5;
    self._id_330F = undefined;
    self._id_3309 = self._id_E6C9;
    self._id_330D = undefined;
    self._id_331B = self._id_E6CA;
    self._id_E6D5 = undefined;
    self._id_E6C9 = undefined;
    self._id_E6CA = undefined;

    for(;;) {
      if(self._id_D9B6 _id_A084()) {
        break;
      }

      if(_id_A035(undefined, 1)) {
        break;
      }

      if(!_id_A03B(self._id_D9B6)) {
        waitframe();
        continue;
      }

      if(self._id_331B == 0) {
        var_1 = self._id_330B._id_5BD1;

        if(isDefined(var_1)) {
          self._id_3309 = [[var_1]](self._id_3309);
          self._id_330B._id_5BD1 = undefined;
          self._id_330B._id_8B01 = undefined;
        }
      }

      if(!isDefined(self._id_8B01)) {
        var_2 = vectordot(anglestoup(self._id_3309), (0, 0, 1));
        self._id_8B01 = var_2 > -0.81915 && var_2 <= 0.5;

        if(isDefined(self._id_330B._id_5BCE)) {
          if(self._id_8B01 && isDefined(self._id_330B._id_5BCF)) {
            self._id_330B._id_5BCE = self._id_330B._id_5BCF;
            self._id_330B._id_5BCF = undefined;
          } else
            self._id_330B._id_5BCF = undefined;
        }
      }

      self._id_330D = _id_A062(self._id_3309, self._id_331B);
      self._id_330F = self._id_3317 + self._id_330D * _id_A063(self._id_331B, self._id_330B, self._id_8B01);
      var_3 = undefined;
      var_4 = undefined;
      var_5 = undefined;
      var_6 = undefined;
      var_7 = undefined;
      var_8 = _func_02C1(self._id_3317, self._id_330F, self._id_D9B6._id_330A, undefined, 0, "physicsquery_closest", 1);

      if(isDefined(var_8) && var_8.size > 0) {
        var_3 = 1;
        var_4 = var_8[0]["position"];
        var_5 = var_8[0]["normal"];
        var_6 = var_8[0]["entity"];
      }

      switch (self._id_331B) {
        case 0:
          if(istrue(var_3)) {
            _id_A036(self._id_331B, 0, var_4);
            var_9 = 1;

            if(isDefined(self._id_330B._id_5BCE)) {
              var_10 = var_4 - self._id_3317;
              var_11 = vectordot(var_10, self._id_330D);
              self._id_330B._id_5BCE = self._id_330B._id_5BCE - var_11;

              if(self._id_330B._id_5BCE > self._id_330B._id_5BD0) {
                var_9 = 0;
              } else {
                self._id_330B._id_5BCE = undefined;
              }
            }

            var_7 = _id_A07B(var_5, anglestoright(self._id_3309));

            if(var_9) {
              var_12 = _id_A031(var_4, var_7, var_6);
              var_12 thread _id_A078();
            }

            self._id_331B = 2;
            self._id_3317 = var_4 + var_5 * 1;
            self._id_3309 = var_7;
            self._id_8B01 = undefined;
          } else {
            _id_A036(self._id_331B, undefined, undefined);

            if(isDefined(self._id_330B._id_5BCE)) {
              var_10 = self._id_330F - self._id_3317;
              var_11 = vectordot(var_10, self._id_330D);
              self._id_330B._id_5BCE = self._id_330B._id_5BCE - var_11;

              if(self._id_330B._id_5BCE <= self._id_330B._id_5BD0) {
                self._id_330B._id_5BCE = undefined;
              }
            }

            self._id_331B = 1;
            self._id_3317 = self._id_330F;
          }

          break;
        case 1:
          if(istrue(var_3)) {
            var_7 = _id_A07B(var_5, anglestoright(self._id_3309));
            var_12 = _id_A031(var_4, var_7, var_6);
            var_12 thread _id_A078();
            var_13 = vectordot(anglestoup(self._id_3309), var_5);

            if(var_13 < 0.9848) {
              _id_A036(self._id_331B, 2, var_4);
              self._id_331B = 2;
              self._id_3317 = var_4 + var_5 * 1;
              self._id_3309 = var_7;
            } else {
              _id_A036(self._id_331B, 1, var_4);
              self._id_331B = 0;
            }
          } else {
            _id_A036(self._id_331B, undefined, undefined);
            self._id_3317 = self._id_330F;
          }

          break;
        case 2:
          if(istrue(var_3)) {
            _id_A036(self._id_331B, 3, var_4);
            self._id_331B = 0;
            self._id_3317 = var_4 + var_5 * 1;
          } else {
            _id_A036(self._id_331B, undefined, undefined);
            self._id_331B = 0;
          }

          break;
      }

      waittillframeend;
    }

    self._id_87B9 = 1;
    self._id_D9B6 _id_A084(1);
  }
}

_id_A035(var_0, var_1) {
  var_2 = 0;
  var_3 = undefined;

  if(!istrue(var_1)) {
    var_2 = self._id_D9B6 _id_A084();
  }

  if(!var_2) {
    if(isDefined(self._id_330B) && isDefined(self._id_330B._id_9C6F) && self._id_3310 >= self._id_330B._id_9C6F) {
      var_2 = 1;
    } else if(isDefined(self._id_330B) && isDefined(self._id_330B._id_9C5A) && self._id_3316 >= self._id_330B._id_9C5A) {
      var_2 = 1;
    } else if(isDefined(self._id_330B) && isDefined(self._id_330B._id_9C6B) && self._id_5526.size >= self._id_330B._id_9C6B) {
      var_2 = 1;
    } else if(istrue(var_0) && self._id_2B0E.size > 0) {
      var_3 = 1;

      foreach(var_5 in self._id_2B0E) {
        if(!var_5 _id_A035(var_0, var_1)) {
          var_3 = 0;
          break;
        }
      }

      if(var_3) {
        var_2 = 1;
      }
    }
  }

  if(var_2 && !istrue(self._id_87B9)) {
    var_7 = self._id_AA8C;
    self._id_AA8C = undefined;

    if(isDefined(var_7)) {
      self[[var_7]]();
    }

    if(istrue(var_3)) {
      var_2 = 0;

      foreach(var_5 in self._id_2B0E) {
        if(!var_5 _id_A035(1, var_1)) {
          var_3 = 0;
          break;
        }
      }

      if(var_3) {
        var_2 = 1;
      }
    }
  }

  if(var_2) {
    self._id_87B9 = 1;
    _id_A08D();
    self._id_2B0E = [];
  }

  return var_2;
}

_id_A036(var_0, var_1, var_2) {
  _id_A07E(self._id_D9B6);
  self._id_3316++;

  if(isDefined(var_1)) {
    if(var_1 == 0 || var_1 == 1 || var_1 == 2) {
      self._id_3310 = 0;
    }
  } else if(var_0 == 1)
    self._id_3310++;
}

_id_A049(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = _func_03C5("equip_molotov_pool_mp_p", var_0, var_1);
  var_10._id_EA93 = var_2;
  var_10.owner = var_3;
  var_10._id_2D95 = var_4;
  var_10._id_2D85 = var_5;
  var_10._id_E72D = var_6;
  var_10._id_B9D9 = var_7;
  var_10._id_B9DC = var_8;
  var_10._id_7C8C = var_9;

  if(isDefined(var_2)) {
    var_11 = _func_01C8(var_0 - var_2.origin, var_2.angles);
    var_12 = _func_0047(_func_00FF(var_2.angles), var_1);
    var_10 _meth_8746(var_2, var_11, var_12);
  }

  var_10 thread _id_A099();
  return var_10;
}

_id_A031(var_0, var_1, var_2) {
  var_3 = self._id_B9D9._id_F8E2;
  var_4 = anglestoup(var_1);
  var_5 = vectordot(var_4, (0, 0, 1));

  if(var_5 <= -0.81915) {
    var_3 = var_3 | 128;
  } else if(var_5 <= 0.5) {
    var_3 = var_3 | 64;
  } else {
    var_3 = var_3 | 32;
  }

  var_6 = self._id_BC1D + self._id_B9D9._id_E698;
  var_7 = _id_A049(var_0, var_1, var_2, self._id_D9B6.owner, self._id_D9B6._id_2D95, self._id_D9B6._id_2D85, var_6, self._id_B9D9, var_3);
  self._id_BC1D = var_6;
  self._id_5526[self._id_5526.size] = var_7;
  var_7._id_7C8C = _id_A069();
  var_7 _id_A07F(self._id_D9B6);
  return var_7;
}

_id_A078() {
  if(istrue(self._id_E69C)) {
    return;
  }
  self._id_E69C = 1;
  self endon("death");
  self endon("molotov_pool_end");

  while(gettime() < self._id_E72D) {
    waitframe();
  }

  self._id_52F1 = 0;
  _id_A09C();
  thread _id_A077();
}

_id_A09C() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");

  if(isDefined(self._id_EA93)) {
    self._id_EA93 endon("death");
  }

  self notify("molotov_pool_watch");
  self.trigger = _id_A04A(self._id_B9D9._id_F630, self._id_B9D9._id_F626, self._id_B9D9._id_F62D);
  self._id_B9DC = self._id_B9DC | 1;
  _id_A079();
  var_0 = randomfloatrange(6.5, 6.75);
  wait(var_0);
}

_id_A077(var_0) {
  self endon("death");

  if(istrue(self._id_52F1)) {
    return;
  }
  self notify("molotov_pool_end");
  self._id_52F1 = 1;
  self._id_B9DC = self._id_B9DC &~1;
  self._id_B9DC = self._id_B9DC | 2;
  _id_A079();

  if(!istrue(var_0)) {
    wait 1;
  }

  if(isDefined(self.trigger)) {
    self.trigger thread _id_A050();
  }

  if(!istrue(var_0)) {
    wait 3.5;
  }

  thread _id_A04F();
}

_id_A099() {
  self endon("death");
  _id_A09A();
  thread _id_A04F();
}

_id_A09A() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");

  if(isDefined(self._id_EA93)) {
    self._id_EA93 endon("death");
  }

  self waittill("forever");
}

_id_A04A(var_0, var_1, var_2) {
  var_3 = self.origin - anglestoup(self.angles) * var_2;
  var_4 = spawn("trigger_rotatable_radius", var_3, 0, var_0, var_1);
  var_4.angles = self.angles;
  var_4._id_7C8C = self._id_7C8C;

  if(isDefined(self._id_EA93)) {
    var_4 _meth_80DB();
    var_4 linkto(self._id_EA93);
  }

  var_4 hide();
  var_5 = spawnStruct();
  var_5.trigger = var_4;
  var_5.attacker = self.owner;
  var_5.inflictor = self._id_2D95;
  var_5.killcament = self._id_2D95;
  var_5._id_2D85 = self._id_2D85;
  var_5._id_B7C0 = [];
  var_4._id_EA6A = var_5;
  var_5 thread _id_A09E();
  var_5 thread _id_A09F();
  var_5 thread _id_A044();
  var_4 _id_A080();
  return var_4;
}

_id_A09E() {
  if(isDefined(self.inflictor)) {
    self.inflictor endon("death");
  }

  self.trigger endon("death");
  self.attacker endon("disconnect");
  self.attacker endon("joined_team");

  for(;;) {
    self.trigger waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }
    var_1 = scripts\engine\utility::ter_op(isDefined(var_0.owner), var_0.owner, var_0);

    if(var_1 != self.attacker && !istrue(scripts\cp_mp\utility\player_utility::_id_B78C(var_1, self.attacker))) {
      continue;
    }
    var_2 = var_0 getentitynumber();

    if(isDefined(self._id_B7C0[var_2])) {
      continue;
    }
    self._id_B7C0[var_2] = var_0;
    var_0 _id_A08A(self.attacker, self.inflictor, self.killcament, self._id_2D85);
  }
}

_id_A09F() {
  self.trigger endon("death");

  for(;;) {
    foreach(var_2, var_1 in self._id_B7C0) {
      if(!isDefined(var_1)) {
        continue;
      }
      if(!scripts\mp\utility\player::isreallyalive(var_1)) {
        continue;
      }
      if(var_1 istouching(self.trigger)) {
        continue;
      }
      self._id_B7C0[var_2] = undefined;
      var_1 _id_A08B(self._id_2D85);
    }

    waitframe();
  }
}

_id_A044() {
  _id_A045();

  foreach(var_1 in self._id_B7C0) {
    if(isDefined(var_1)) {
      var_1 _id_A08B(self._id_2D85);
    }
  }

  if(isDefined(self.trigger)) {
    self.trigger thread _id_A050();
  }
}

_id_A045() {
  self.trigger endon("death");
  self.attacker endon("disconnect");
  self.attacker endon("joined_team");

  for(;;) {
    waitframe();
  }
}

_id_A079() {
  var_0 = _id_A068();
  var_1 = var_0._id_CF2E[self._id_B9DC];
  self setscriptablepartstate("effects", var_1, 0);
}

_id_A033(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = self._id_D9B6;
  var_10 = _id_A061(var_0);
  var_11 = _id_A067(var_0);

  if(isDefined(self._id_330B)) {
    if(self._id_3310 > self._id_330B._id_9C6F) {
      return;
    }
    if(self._id_3310 > var_10._id_9C6F) {
      return;
    }
  }

  if(isDefined(var_2)) {
    var_10._id_5BCE = var_2;
  }

  if(isDefined(var_3)) {
    var_10._id_5BD0 = var_3;
  }

  if(isDefined(var_4)) {
    var_10._id_5BD1 = var_4;
  }

  if(isDefined(var_5)) {
    var_10._id_5BCF = var_5;
  }

  if(isDefined(var_6)) {
    var_10._id_9C5A = var_6;
  }

  if(isDefined(var_7)) {
    var_10._id_9C6B = var_7;
  }

  var_12 = _id_A048(var_9, var_10, var_11, self, self._id_3317, self._id_3309, undefined, self._id_331B, self._id_BC1D);
  var_12._id_3310 = self._id_3310;
  self._id_2B0E[self._id_2B0E.size] = var_12;
  var_9._id_2B0E[var_9._id_2B0E.size] = var_12;

  if(istrue(var_8)) {
    var_12 thread _id_A089();
  }

  return var_12;
}

_id_A02E() {
  var_0 = _id_A033(16, self._id_BC1D, 35, 8, undefined, 44, undefined, undefined, 1);
}

_id_A030() {
  var_0 = _id_A033(16, self._id_BC1D, 35, 8, ::_id_A071, 44, undefined, undefined, 1);
}

_id_A032() {
  var_0 = _id_A033(16, self._id_BC1D, 35, 8, ::_id_A081, 44, undefined, undefined, 1);
}

_id_A034() {
  var_0 = _id_A033(16, self._id_BC1D, 35, 8, ::_id_A091, 44, 6, 1, 1);
}

_id_A082(var_0, var_1) {
  var_2 = anglesToForward(var_0);
  var_3 = anglestoup(var_0);
  var_4 = undefined;
  var_2 = _func_01C6(var_3, var_2, var_1);
  var_4 = vectornormalize(_func_025B(var_2, var_3));
  var_3 = _func_025B(var_4, var_2);
  return _func_0017(var_2, var_4, var_3);
}

_id_A071(var_0) {
  var_1 = randomfloatrange(50, 75);
  return _id_A082(var_0, var_1);
}

_id_A081(var_0) {
  var_1 = -1 * randomfloatrange(50, 75);
  return _id_A082(var_0, var_1);
}

_id_A091(var_0) {
  var_1 = randomfloatrange(-60, 60);
  return _id_A082(var_0, var_1);
}

_id_A03E() {
  self endon("death");
  wait 20;
  self delete();
}

_id_A042(var_0) {
  var_0 endon("death");
  scripts\engine\utility::waittill_any_2("disconnect", "joined_team");
  var_0 delete();
}

_id_A065() {
  return level._id_A02C;
}

_id_A068() {
  var_0 = _id_A065();
  var_1 = var_0._id_B9D9;
  return var_1;
}

_id_A064() {
  var_0 = _id_A065();
  var_1 = var_0._id_330B;
  return var_1;
}

_id_A069() {
  var_0 = _id_A065();
  var_1 = var_0._id_F953;
  var_0._id_F953++;
  var_0._id_B9DB = scripts\engine\utility::array_add(var_0._id_B9DB, var_1);
  return var_1;
}

_id_A061(var_0) {
  var_1 = _id_A064();
  var_2 = spawnStruct();
  var_2._id_4BA2 = var_1._id_4BA2[var_0];
  var_2._id_4BA1 = var_1._id_4BA1[var_0];
  var_2._id_4BBF = var_1._id_4BBF[var_0];
  var_2._id_9C5A = var_1._id_9C5A[var_0];
  var_2._id_9C6F = var_1._id_9C6F[var_0];
  var_2._id_9C6B = var_1._id_9C6B[var_0];
  var_2._id_4BA3 = var_1._id_4BA3[var_0];

  if(isDefined(var_1._id_5BCE[var_0])) {
    var_2._id_5BCE = var_1._id_5BCE[var_0];
    var_2._id_5BD0 = var_1._id_5BD0[var_0];
    var_2._id_5BD1 = var_1._id_5BD1[var_0];

    if(isDefined(var_1._id_5BCF[var_0])) {
      var_2._id_5BCF = var_1._id_5BCF[var_0];
    }
  }

  return var_2;
}

_id_A067(var_0) {
  var_1 = _id_A068();
  var_2 = spawnStruct();
  var_2._id_F8E2 = var_0;
  var_2._id_F630 = var_1._id_F630[var_0];
  var_2._id_F626 = var_1._id_F626[var_0];
  var_2._id_F62D = var_1._id_F62D[var_0];
  var_2._id_E698 = var_1._id_E698[var_0];
  return var_2;
}

_id_A062(var_0, var_1) {
  switch (var_1) {
    case 0:
      return anglesToForward(var_0);
    case 1:
      return -1 * anglestoup(var_0);
    case 2:
      return anglestoup(var_0);
  }

  return undefined;
}

_id_A063(var_0, var_1, var_2) {
  switch (var_0) {
    case 0:
      if(isDefined(var_1._id_5BCE)) {
        return var_1._id_5BCE;
      } else if(var_2 && isDefined(var_1._id_4BA3)) {
        return var_1._id_4BA3;
      } else {
        return var_1._id_4BA2;
      }
    case 1:
      return var_1._id_4BA1;
    case 2:
      return var_1._id_4BBF;
  }

  return undefined;
}

_id_A060() {
  return physics_createcontents(["physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
}

_id_A07B(var_0, var_1) {
  var_2 = vectornormalize(_func_025B(var_0, var_1));
  var_1 = _func_025B(var_2, var_0);
  return _func_0017(var_2, var_1, var_0);
}

_id_A07A(var_0, var_1) {
  var_2 = vectornormalize(_func_025B(var_1, var_0));
  var_1 = _func_025B(var_0, var_2);
  return _func_0017(var_1, var_2, var_0);
}

_id_A08A(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {}

  var_4 = _id_A05E(1);

  if(!isDefined(var_3)) {
    var_3 = _id_A066();
  }

  var_5 = _id_A05F(var_0, var_1, var_2, var_4, var_3, 1);
  scripts\mp\utility\player::_id_3A20("fire", -1);
  var_6 = 0;

  if(var_5._id_011A <= 0) {
    var_6 = 1;
  }

  var_5._id_011A++;

  if(var_6) {
    thread _id_A097();
  }
}

_id_A08B(var_0) {
  var_1 = _id_A05E();

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = _id_A05F(undefined, undefined, undefined, var_1, var_0, 0);

  if(isDefined(var_2)) {
    if(var_2._id_011A > 0) {
      var_3 = 0;

      if(var_2._id_011A == 1) {
        var_3 = 1;
      }

      var_2._id_011A--;

      if(var_3) {
        thread _id_A097();
      }
    }
  }
}

_id_A037(var_0, var_1, var_2, var_3) {
  self endon("death_or_disconnect");
  self endon("clear_burning");
  var_4 = _id_A066();
  _id_A08A(var_1, var_2, var_3, var_4);
  wait(var_0);
  _id_A08B(var_4);
}

_id_A046(var_0) {
  self notify("clear_burning");

  if(isDefined(self._id_2D8D) && isDefined(self._id_2D8D._id_E070)) {
    foreach(var_2 in self._id_2D8D._id_E070) {
      self._id_2D8D._id_E070[var_2._id_7C8C] = undefined;
    }
  }

  scripts\mp\utility\player::_id_3A20("fire", 0);
  self._id_2D8D = undefined;
}

_id_A097() {
  self endon("death_or_disconnect");
  self endon("clear_burning");
  level endon("game_ended");
  self notify("update_burning");
  self endon("update_burning");
  thread _id_A03F();
  var_0 = _id_A05E();

  if(gettime() <= var_0._id_FD68) {
    waitframe();
  }

  for(;;) {
    var_0 = _id_A05E();
    var_1 = undefined;

    foreach(var_3 in var_0._id_E070) {
      if(var_3 _id_A03A()) {
        if(!isDefined(var_1) || var_3._id_7C8C > var_1) {
          var_1 = var_3._id_7C8C;
        }

        continue;
      }

      var_0._id_E070[var_3._id_7C8C] = undefined;
    }

    if(isDefined(var_1)) {
      var_0._id_F21E = 0;
      var_0._id_F223 = var_0._id_F223 + 0.05;
      var_3 = var_0._id_E070[var_1];
      var_5 = 10;

      if(var_0._id_F223 > 1.5) {
        var_5 = 10;
      } else if(var_0._id_F223 > 0.5) {
        var_5 = 10;
      }

      var_6 = undefined;
      var_7 = var_3.attacker.origin;

      if(isDefined(var_3.inflictor)) {
        var_6 = var_3.inflictor;
        var_7 = var_3.inflictor.origin;
      }

      if(var_0._id_F27F <= 0) {
        self dodamage(var_5, var_7, var_3.attacker, var_6, "MOD_FIRE", "s4_molotov_mp");
        var_0._id_5BCC = 1;
        var_0._id_F27F = 0.25;
      } else {
        if(!var_0._id_5BCC) {
          self dodamage(var_5, var_7, var_3.attacker, var_6, "MOD_FIRE", "s4_molotov_mp");
          thread _id_A053(var_3.attacker, var_6);
          var_0._id_5BCC = 1;
        }

        var_0._id_F27F = var_0._id_F27F - 0.05;
      }

      self notify("molotov_update_time");
    } else {
      self notify("molotov_trigger_final_tick");
      var_0._id_F21E = var_0._id_F21E + 0.05;

      if(var_0._id_F21E >= 0.25) {
        thread _id_A046();
      }
    }

    var_0._id_FD68 = gettime();
    wait 0.05;
  }
}

_id_A053(var_0, var_1) {
  self notify("monitor_final_tick");
  self endon("monitor_final_tick");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_2 = 0.25;

  for(;;) {
    var_3 = scripts\engine\utility::_id_10897("molotov_trigger_final_tick", "molotov_update_time");

    if(var_3 == "molotov_update_time") {
      if(var_2 <= 0) {
        var_2 = 0.25;
      } else {
        var_2 = var_2 - 0.05;
      }

      continue;
    }

    if(var_3 == "molotov_trigger_final_tick") {
      while(var_2 >= 0) {
        if(var_2 == 0) {
          self dodamage(10, var_0.origin, var_0, var_1, "MOD_FIRE", "s4_molotov_mp");
        }

        var_2 = var_2 - 0.05;
        wait 0.05;
      }

      return;
    }
  }
}

_id_A070() {
  var_0 = _id_A05E();
  return isDefined(var_0) && var_0._id_E070.size > 0;
}

_id_A05E(var_0) {
  var_1 = self._id_2D8D;

  if(!isDefined(var_1) && istrue(var_0)) {
    var_1 = spawnStruct();
    var_1._id_F223 = 0;
    var_1._id_F21E = 0;
    var_1._id_F27F = 0.25;
    var_1._id_FD68 = 0;
    var_1._id_103C2 = self;
    var_1._id_E070 = [];
    var_1._id_5BCC = 0;
    self._id_2D8D = var_1;
  }

  return var_1;
}

_id_A05F(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_3._id_E070[var_4];

  if(!isDefined(var_6)) {
    if(istrue(var_5)) {
      var_6 = spawnStruct();
      var_6.attacker = var_0;
      var_6.inflictor = var_1;
      var_6._id_7576 = isDefined(var_1);
      var_6.killcament = var_2;
      var_6._id_7E9E = var_3;
      var_6._id_7C8C = var_4;
      var_6._id_011A = 0;
      var_3._id_E070[var_4] = var_6;
    }
  }

  return var_6;
}

_id_A03A() {
  if(!isDefined(self.attacker)) {
    return 0;
  }

  if(!isDefined(self._id_7E9E._id_103C2)) {
    return 0;
  }

  if(!scripts\mp\utility\player::isreallyalive(self._id_7E9E._id_103C2)) {
    return 0;
  }

  if(self.attacker != self._id_7E9E._id_103C2 && !istrue(scripts\cp_mp\utility\player_utility::_id_B78C(self.attacker, self._id_7E9E._id_103C2))) {
    return 0;
  }

  if(self._id_7576 && !isDefined(self.inflictor)) {
    return 0;
  }

  if(self._id_011A <= 0) {
    return 0;
  }

  return 1;
}

_id_A066() {
  var_0 = _id_A065();

  if(!isDefined(var_0._id_2D8C)) {
    var_0._id_2D8C = 0;
  }

  var_1 = var_0._id_2D8C;
  var_0._id_2D8C++;
  return var_1;
}

_id_A03F() {
  self notify("cleanup_burning");
  self endon("cleanup_burning");
  childthread _id_A040();
  childthread _id_A041();
}

_id_A040() {
  self endon("disconnect");
  self endon("clear_burning");
  level endon("game_ended");
  self waittill("death");
  thread _id_A046(1);
}

_id_A041() {
  self endon("death_or_disconnect");
  self endon("clear_burning");
  level waittill("game_ended");
  thread _id_A046();
}

_id_A074(var_0) {
  if(var_0._id_9CD6 == "MOD_IMPACT") {
    return 1;
  }

  var_0._id_103C2 thread scripts\mp\weapons::_id_523C(0.5);
  return 1;
}

_id_A09B() {
  self notify("molotov_clear_fx");
  self endon("molotov_clear_fx");
  self endon("death_or_disconnect");
  var_0 = 0;

  for(;;) {
    var_1 = 0;
    var_2 = self getheldoffhand();

    if(!isnullweapon(var_2) && var_2.basename == "s4_molotov_mp") {
      var_1 = 1;
    }

    if(var_1 && !var_0) {
      thread _id_A02D();
    } else if(var_0 && !var_1) {
      thread _id_A051();
    }

    var_0 = var_1;
    waitframe();
  }
}

_id_A02D() {
  self endon("death_or_disconnect");
  self endon("molotov_end_fx");
  self._id_B865 = 1;
  self setscriptablepartstate("equipMtovFXWorld", "neutral", 0);
  self setscriptablepartstate("equipMtovFXView", "active", 0);
  var_0 = 0.4;
  wait(var_0);
  self setscriptablepartstate("equipMtovFXWorld", "active", 0);
}

_id_A051() {
  self notify("molotov_end_fx");

  if(istrue(self._id_B865)) {
    self setscriptablepartstate("equipMtovFXWorld", "neutral", 0);
    self setscriptablepartstate("equipMtovFXView", "neutral", 0);
  }

  self._id_B865 = undefined;
}

_id_A047() {
  self notify("molotov_clear_fx");
  thread _id_A051();
}

_id_A03D(var_0, var_1) {
  var_0 notify("cleanup_branch");

  if(isDefined(var_0._id_5526)) {
    foreach(var_3 in var_0._id_5526) {
      if(isDefined(var_3)) {
        var_3 thread _id_A077(var_1);
      }
    }
  }
}

_id_A043(var_0, var_1) {
  if(isDefined(var_0._id_D9B6)) {
    if(isDefined(var_0._id_D9B6._id_2B0E)) {
      foreach(var_3 in var_0._id_D9B6._id_2B0E) {
        _id_A03D(var_3, var_1);
      }
    }

    if(isDefined(var_0._id_D9B6._id_AA28)) {
      foreach(var_6 in var_0._id_D9B6._id_AA28) {
        if(isDefined(var_6)) {
          var_6 thread _id_A077(var_1);
        }
      }
    }
  }
}