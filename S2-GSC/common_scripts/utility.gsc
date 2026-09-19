/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\utility.gsc
**************************************/

_id_55BF(var_0) {
  if(_func_296(var_0))
    return _id_55BF(var_0[0]) || _id_55BF(var_0[1]) || _id_55BF(var_0[2]);
  else if(_func_2A2(var_0))
    return !(var_0 < 0 || var_0 > 0 || var_0 == 0);

  return 0;
}

_id_562E(var_0) {
  return isDefined(var_0) && var_0;
}

_id_6756(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level._id_3F02)) {
    return;
  }
  if(!isDefined(level._id_3F02[var_0])) {
    return;
  }
  if(!isDefined(var_1)) {
    call[[level._id_3F02[var_0]]]();
    return;
  }

  if(!isDefined(var_2)) {
    call[[level._id_3F02[var_0]]](var_1);
    return;
  }

  if(!isDefined(var_3)) {
    call[[level._id_3F02[var_0]]](var_1, var_2);
    return;
  }

  if(!isDefined(var_4)) {
    call[[level._id_3F02[var_0]]](var_1, var_2, var_3);
    return;
  }

  call[[level._id_3F02[var_0]]](var_1, var_2, var_3, var_4);
}

_id_83BE(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level._id_3F02[var_0])) {
    return;
  }
  if(!isDefined(var_1)) {
    self call[[level._id_3F02[var_0]]]();
    return;
  }

  if(!isDefined(var_2)) {
    self call[[level._id_3F02[var_0]]](var_1);
    return;
  }

  if(!isDefined(var_3)) {
    self call[[level._id_3F02[var_0]]](var_1, var_2);
    return;
  }

  if(!isDefined(var_4)) {
    self call[[level._id_3F02[var_0]]](var_1, var_2, var_3);
    return;
  }

  self call[[level._id_3F02[var_0]]](var_1, var_2, var_3, var_4);
}

_id_7A5F(var_0) {
  return (_func_0A3(var_0) - var_0 * 0.5, _func_0A3(var_0) - var_0 * 0.5, _func_0A3(var_0) - var_0 * 0.5);
}

_id_7A61(var_0, var_1) {
  var_2 = _func_0A5(var_0, var_1);

  if(randomint(2) == 0)
    var_2 = var_2 * -1;

  var_3 = _func_0A5(var_0, var_1);

  if(randomint(2) == 0)
    var_3 = var_3 * -1;

  var_4 = _func_0A5(var_0, var_1);

  if(randomint(2) == 0)
    var_4 = var_4 * -1;

  return (var_2, var_3, var_4);
}

_id_7A60(var_0, var_1) {
  var_2 = _func_0A3(var_1);
  var_3 = _func_0A3(360);
  var_4 = _func_0A6(var_2);
  var_5 = _func_0A7(var_2);
  var_6 = _func_0A6(var_3);
  var_7 = _func_0A7(var_3);
  var_8 = (var_5, var_7 * var_4, var_6 * var_4);
  return _func_112(var_8, vectortoangles(var_0));
}

_id_8C4F(var_0) {
  if(var_0 >= 0)
    return 1;

  return -1;
}

_id_627D(var_0, var_1) {
  var_2 = int(var_0 / var_1);

  if(var_0 * var_1 < 0)
    var_2 = var_2 - 1;

  return var_0 - var_2 * var_1;
}

_id_9AAD(var_0) {
  return "" + var_0;
}

_id_9B8A(var_0) {
  if(isDefined(self._id_2919)) {
    if(var_0 == self._id_2919)
      return;
  }

  self._id_2919 = var_0;
}

_id_416F(var_0) {
  var_1 = [];
  var_1["axis"] = "allies";
  var_1["allies"] = "axis";
  return var_1[var_0];
}

_id_23B8(var_0) {
  self._id_38CE[var_0] = anim._id_2BC3;
}

_id_8487(var_0, var_1) {
  self._id_38CE[var_0] = var_1;
}

_id_840A(var_0) {
  var_1 = getarraykeys(self._id_38CE);

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    self._id_38CE[var_1[var_2]] = var_0;
}

_id_24A6() {
  return randomint(100) >= 50;
}

_id_2205(var_0, var_1) {
  var_2 = randomint(var_1[var_1.size - 1] + 1);

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(var_2 <= var_1[var_3])
      return var_0[var_3];
  }
}

_id_4127(var_0) {
  var_1 = [];
  var_2 = 0;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_2 = var_2 + var_0[var_3];
    var_1[var_3] = var_2;
  }

  return var_1;
}

_id_67EC(var_0, var_1) {
  wait(var_0);
  self notify(var_1);
}

_id_A75D(var_0, var_1) {
  if(var_0 != "death")
    self endon("death");

  var_1 endon("die");
  self waittill(var_0);
  var_1 notify("returned", var_0, self);
}

_id_A75F(var_0, var_1) {
  if(var_0 != "death")
    self endon("death");

  var_1 endon("die");
  self waittill(var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  var_12 = [];
  var_12[0] = var_0;

  if(isDefined(var_2))
    var_12[1] = var_2;

  if(isDefined(var_3))
    var_12[2] = var_3;

  if(isDefined(var_4))
    var_12[3] = var_4;

  if(isDefined(var_5))
    var_12[4] = var_5;

  if(isDefined(var_6))
    var_12[5] = var_6;

  if(isDefined(var_7))
    var_12[6] = var_7;

  if(isDefined(var_8))
    var_12[7] = var_8;

  if(isDefined(var_9))
    var_12[8] = var_9;

  if(isDefined(var_10))
    var_12[9] = var_10;

  if(isDefined(var_11))
    var_12[10] = var_11;

  var_1 notify("returned", var_12, self);
}

_id_A75E(var_0, var_1) {
  var_1 endon("die");
  self waittill(var_0);
  var_1 notify("returned", var_0);
}

_id_A746(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5 = spawnStruct();
  var_5._id_996E = 0;

  if(isDefined(var_0)) {
    childthread _id_A75D(var_0, var_5);
    var_5._id_996E++;
  }

  if(isDefined(var_1)) {
    childthread _id_A75D(var_1, var_5);
    var_5._id_996E++;
  }

  if(isDefined(var_2)) {
    childthread _id_A75D(var_2, var_5);
    var_5._id_996E++;
  }

  if(isDefined(var_3)) {
    childthread _id_A75D(var_3, var_5);
    var_5._id_996E++;
  }

  if(isDefined(var_4)) {
    childthread _id_A75D(var_4, var_5);
    var_5._id_996E++;
  }

  while(var_5._id_996E) {
    var_5 waittill("returned");
    var_5._id_996E--;
  }

  var_5 notify("die");
}

_id_A747(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  var_8 = spawnStruct();
  var_8._id_996E = 0;

  if(isDefined(var_0)) {
    var_0 childthread _id_A75D(var_1, var_8);
    var_8._id_996E++;
  }

  if(isDefined(var_2)) {
    var_2 childthread _id_A75D(var_3, var_8);
    var_8._id_996E++;
  }

  if(isDefined(var_4)) {
    var_4 childthread _id_A75D(var_5, var_8);
    var_8._id_996E++;
  }

  if(isDefined(var_6)) {
    var_6 childthread _id_A75D(var_7, var_8);
    var_8._id_996E++;
  }

  while(var_8._id_996E) {
    var_8 waittill("returned");
    var_8._id_996E--;
  }

  var_8 notify("die");
}

_id_A748(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("death");
  var_9 = spawnStruct();
  var_9._id_996E = 0;

  if(isDefined(var_1)) {
    var_1 childthread _id_A75E(var_2, var_9);
    var_9._id_996E++;
  }

  if(isDefined(var_3)) {
    var_3 childthread _id_A75E(var_4, var_9);
    var_9._id_996E++;
  }

  if(isDefined(var_5)) {
    var_5 childthread _id_A75E(var_6, var_9);
    var_9._id_996E++;
  }

  if(isDefined(var_7)) {
    var_7 childthread _id_A75E(var_8, var_9);
    var_9._id_996E++;
  }

  var_10 = "ents_notified";

  while(var_9._id_996E) {
    if(isDefined(var_0)) {
      var_11 = var_9 _id_A74D("returned", var_0);

      if(isDefined(var_11) && var_11 == "timeout") {
        var_9._id_996E = 0;
        var_10 = "timeout";
      } else
        var_9._id_996E--;

      continue;
    }

    var_9 waittill("returned");
    var_9._id_996E--;
  }

  var_9 notify("die");
  return var_10;
}

_id_A715(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death") && (!isDefined(var_6) || var_6 != "death") && (!isDefined(var_7) || var_7 != "death") && (!isDefined(var_8) || var_8 != "death"))
    self endon("death");

  var_9 = spawnStruct();

  if(isDefined(var_0))
    childthread _id_A75D(var_0, var_9);

  if(isDefined(var_1))
    childthread _id_A75D(var_1, var_9);

  if(isDefined(var_2))
    childthread _id_A75D(var_2, var_9);

  if(isDefined(var_3))
    childthread _id_A75D(var_3, var_9);

  if(isDefined(var_4))
    childthread _id_A75D(var_4, var_9);

  if(isDefined(var_5))
    childthread _id_A75D(var_5, var_9);

  if(isDefined(var_6))
    childthread _id_A75D(var_6, var_9);

  if(isDefined(var_7))
    childthread _id_A75D(var_7, var_9);

  if(isDefined(var_8))
    childthread _id_A75D(var_8, var_9);

  var_9 waittill("returned", var_10);
  var_9 notify("die");
  return var_10;
}

_id_A717(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death") && (!isDefined(var_6) || var_6 != "death") && (!isDefined(var_7) || var_7 != "death"))
    self endon("death");

  var_8 = spawnStruct();

  if(isDefined(var_0))
    childthread _id_A75F(var_0, var_8);

  if(isDefined(var_1))
    childthread _id_A75F(var_1, var_8);

  if(isDefined(var_2))
    childthread _id_A75F(var_2, var_8);

  if(isDefined(var_3))
    childthread _id_A75F(var_3, var_8);

  if(isDefined(var_4))
    childthread _id_A75F(var_4, var_8);

  if(isDefined(var_5))
    childthread _id_A75F(var_5, var_8);

  if(isDefined(var_6))
    childthread _id_A75F(var_6, var_8);

  if(isDefined(var_7))
    childthread _id_A75F(var_7, var_8);

  var_8 waittill("returned", var_9);
  var_8 notify("die");
  return var_9;
}

_id_A70F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16) {
  self endon("death");
  var_17 = spawnStruct();

  if((!isDefined(var_2) || var_2 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_6) || var_6 != "death") && (!isDefined(var_8) || var_8 != "death") && (!isDefined(var_10) || var_10 != "death") && (!isDefined(var_12) || var_12 != "death") && (!isDefined(var_14) || var_14 != "death") && (!isDefined(var_16) || var_16 != "death"))
    self endon("death");

  if(isDefined(var_1) && isDefined(var_2))
    var_1 childthread _id_A75F(var_2, var_17);

  if(isDefined(var_3) && isDefined(var_4))
    var_3 childthread _id_A75F(var_4, var_17);

  if(isDefined(var_5) && isDefined(var_6))
    var_5 childthread _id_A75F(var_6, var_17);

  if(isDefined(var_7) && isDefined(var_8))
    var_7 childthread _id_A75F(var_8, var_17);

  if(isDefined(var_9) && isDefined(var_10))
    var_9 childthread _id_A75F(var_10, var_17);

  if(isDefined(var_11) && isDefined(var_12))
    var_11 childthread _id_A75F(var_12, var_17);

  if(isDefined(var_13) && isDefined(var_14))
    var_13 childthread _id_A75F(var_14, var_17);

  if(isDefined(var_15) && isDefined(var_16))
    var_15 childthread _id_A75F(var_16, var_17);

  if(var_0 > 0)
    childthread _id_A763(var_17, "returned", var_0);

  var_17 waittill("returned", var_18, var_19);

  if(isDefined(var_18) && !_func_0C0(var_18) && var_18 == "timeout") {
    var_17 notify("die");
    return ["timeout", "timeout"];
  } else {
    var_17 notify("die");
    var_20 = _id_0F73([var_19], var_18);
    return var_20;
  }
}

_id_A719(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("death");

  if((!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death") && (!isDefined(var_6) || var_6 != "death") && (!isDefined(var_7) || var_7 != "death") && (!isDefined(var_8) || var_8 != "death"))
    self endon("death");

  var_9 = spawnStruct();

  if(isDefined(var_1))
    childthread _id_A75F(var_1, var_9);

  if(isDefined(var_2))
    childthread _id_A75F(var_2, var_9);

  if(isDefined(var_3))
    childthread _id_A75F(var_3, var_9);

  if(isDefined(var_4))
    childthread _id_A75F(var_4, var_9);

  if(isDefined(var_5))
    childthread _id_A75F(var_5, var_9);

  if(isDefined(var_6))
    childthread _id_A75F(var_6, var_9);

  if(isDefined(var_7))
    childthread _id_A75F(var_7, var_9);

  if(isDefined(var_8))
    childthread _id_A75F(var_8, var_9);

  childthread _id_A763(var_9, "returned", var_0);
  var_9 waittill("returned", var_10);

  if(isDefined(var_10) && !_func_0C0(var_10) && var_10 == "timeout") {
    var_9 notify("die");
    return ["timeout"];
  } else {
    var_9 notify("die");
    return var_10;
  }
}

_id_A763(var_0, var_1, var_2) {
  self endon(var_1);
  wait(var_2);
  var_0 notify("returned", "timeout");
}

_id_A716(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();

  if(isDefined(var_0))
    childthread _id_A75E(var_0, var_7);

  if(isDefined(var_1))
    childthread _id_A75E(var_1, var_7);

  if(isDefined(var_2))
    childthread _id_A75E(var_2, var_7);

  if(isDefined(var_3))
    childthread _id_A75E(var_3, var_7);

  if(isDefined(var_4))
    childthread _id_A75E(var_4, var_7);

  if(isDefined(var_5))
    childthread _id_A75E(var_5, var_7);

  if(isDefined(var_6))
    childthread _id_A75E(var_6, var_7);

  var_7 waittill("returned", var_8);
  var_7 notify("die");
  return var_8;
}

_id_A712(var_0) {
  var_1 = spawnStruct();
  var_2 = 0;

  foreach(var_4 in var_0) {
    childthread _id_A75D(var_4, var_1);

    if(var_4 == "death")
      var_2 = 1;
  }

  if(!var_2)
    self endon("death");

  var_1 waittill("returned", var_6);
  var_1 notify("die");
  return var_6;
}

_id_A713(var_0) {
  var_1 = spawnStruct();

  foreach(var_3 in var_0)
  childthread _id_A75E(var_3, var_1);

  var_1 waittill("returned", var_5);
  var_1 notify("die");
  return var_5;
}

_id_A710(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = 0;

  foreach(var_5 in var_0) {
    childthread _id_A75D(var_5, var_2);

    if(var_5 == "death")
      var_3 = 1;
  }

  if(!var_3)
    self endon("death");

  var_2 childthread _id_0730(var_1);
  var_2 waittill("returned", var_7);
  var_2 notify("die");
  return var_7;
}

_id_A711(var_0, var_1) {
  var_2 = spawnStruct();

  foreach(var_4 in var_0)
  childthread _id_A75E(var_4, var_2);

  var_2 thread _id_0730(var_1);
  var_2 waittill("returned", var_6);
  var_2 notify("die");
  return var_6;
}

_id_A71A(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if((!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death") && (!isDefined(var_6) || var_6 != "death"))
    self endon("death");

  var_7 = spawnStruct();

  if(isDefined(var_1))
    childthread _id_A75D(var_1, var_7);

  if(isDefined(var_2))
    childthread _id_A75D(var_2, var_7);

  if(isDefined(var_3))
    childthread _id_A75D(var_3, var_7);

  if(isDefined(var_4))
    childthread _id_A75D(var_4, var_7);

  if(isDefined(var_5))
    childthread _id_A75D(var_5, var_7);

  if(isDefined(var_6))
    childthread _id_A75D(var_6, var_7);

  var_7 childthread _id_0730(var_0);
  var_7 waittill("returned", var_8);
  var_7 notify("die");
  return var_8;
}

_id_0730(var_0) {
  self endon("die");
  wait(var_0);
  self notify("returned", "timeout");
}

_id_A71B(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();

  if(isDefined(var_1))
    childthread _id_A75E(var_1, var_6);

  if(isDefined(var_2))
    childthread _id_A75E(var_2, var_6);

  if(isDefined(var_3))
    childthread _id_A75E(var_3, var_6);

  if(isDefined(var_4))
    childthread _id_A75E(var_4, var_6);

  if(isDefined(var_5))
    childthread _id_A75E(var_5, var_6);

  var_6 childthread _id_0730(var_0);
  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

_id_A70A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_1))
    self endon(var_1);

  if(isDefined(var_2))
    self endon(var_2);

  if(isDefined(var_3))
    self endon(var_3);

  if(isDefined(var_4))
    self endon(var_4);

  if(isDefined(var_5))
    self endon(var_5);

  if(isDefined(var_6))
    self endon(var_6);

  if(isDefined(var_7))
    self endon(var_7);

  self waittill(var_0);
}

_id_A63E(var_0, var_1, var_2, var_3) {
  self endon(var_1);

  if(isDefined(var_2))
    self endon(var_2);

  if(isDefined(var_3))
    self endon(var_3);

  wait(var_0);
}

_id_A70C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(isDefined(var_2) && isDefined(var_3))
    var_2 endon(var_3);

  if(isDefined(var_4) && isDefined(var_5))
    var_4 endon(var_5);

  if(isDefined(var_6) && isDefined(var_7))
    var_6 endon(var_7);

  if(isDefined(var_8) && isDefined(var_9))
    var_8 endon(var_9);

  if(isDefined(var_10) && isDefined(var_11))
    var_10 endon(var_11);

  if(isDefined(var_12) && isDefined(var_13))
    var_12 endon(var_13);

  var_0 waittill(var_1);
}

_id_A70E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15) {
  var_16 = spawnStruct();

  if(isDefined(var_1))
    var_0 childthread _id_A75D(var_1, var_16);

  if(isDefined(var_3))
    var_2 childthread _id_A75D(var_3, var_16);

  if(isDefined(var_5))
    var_4 childthread _id_A75D(var_5, var_16);

  if(isDefined(var_7))
    var_6 childthread _id_A75D(var_7, var_16);

  if(isDefined(var_9))
    var_8 childthread _id_A75D(var_9, var_16);

  if(isDefined(var_11))
    var_10 childthread _id_A75D(var_11, var_16);

  if(isDefined(var_13))
    var_12 childthread _id_A75D(var_13, var_16);

  if(isDefined(var_15))
    var_14 childthread _id_A75D(var_15, var_16);

  var_16 waittill("returned", var_17, var_18);
  var_16 notify("die");
  return [var_17, var_18];
}

_id_A70D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(isDefined(var_3) && isDefined(var_4))
    var_3 endon(var_4);

  if(isDefined(var_5) && isDefined(var_6))
    var_5 endon(var_6);

  if(isDefined(var_7) && isDefined(var_8))
    var_7 endon(var_8);

  if(isDefined(var_9) && isDefined(var_10))
    var_9 endon(var_10);

  if(isDefined(var_11) && isDefined(var_12))
    var_11 endon(var_12);

  if(isDefined(var_13) && isDefined(var_14))
    var_13 endon(var_14);

  var_1 waittill_notify_or_timeout(var_2, var_0);
}

_id_A70B(var_0, var_1) {
  var_2 = spawnStruct();

  foreach(var_4 in var_0)
  var_4 childthread _id_A75D(var_1, var_2);

  var_2 waittill("returned", var_6, var_7);
  var_2 notify("die");
  return var_7;
}

script_delay() {
  if(isDefined(self.script_delay) && self.script_delay > 0) {
    wait(self.script_delay);
    return 1;
  } else if(isDefined(self._id_8154) && isDefined(self._id_8153)) {
    wait(_func_0A5(self._id_8154, self._id_8153));
    return 1;
  }

  return 0;
}

_id_4B3F() {
  if(isDefined(self.script_delay))
    return 1;

  if(isDefined(self._id_8154) && isDefined(self._id_8153))
    return 1;

  return 0;
}

_id_8155() {
  if(isDefined(self._id_8155)) {
    wait(self._id_8155);
    return 1;
  } else if(isDefined(self._id_8157) && isDefined(self._id_8156)) {
    wait(_func_0A5(self._id_8157, self._id_8156));
    return 1;
  }

  return 0;
}

_id_82E5() {
  var_0 = gettime();

  if(isDefined(self._id_82E5)) {
    wait(self._id_82E5);

    if(isDefined(self._id_82E6))
      self._id_82E5 = self._id_82E5 + self._id_82E6;
  } else if(isDefined(self._id_82E8) && isDefined(self._id_82E7)) {
    wait(_func_0A5(self._id_82E8, self._id_82E7));

    if(isDefined(self._id_82E6)) {
      self._id_82E8 = self._id_82E8 + self._id_82E6;
      self._id_82E7 = self._id_82E7 + self._id_82E6;
    }
  }

  return gettime() - var_0;
}

_id_0F91(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(self)) {
    self endon("death");
    self endon("array_random_iterate_stop");
  }

  if(isDefined(var_10))
    level endon(var_10);

  var_11 = [];

  foreach(var_14, var_13 in var_0)
  var_11[var_11.size] = var_13;

  var_15 = 0;

  while(!(isDefined(var_9) && var_9 == 1)) {
    if(var_15) {
      waitframe();

      if(var_2 <= var_1)
        wait(var_1);
      else
        wait(_func_0A5(var_1, var_2));
    }

    var_15 = 1;
    var_16 = var_11.size;

    while(var_16 > 0) {
      var_17 = randomint(var_16);
      var_18 = var_11[var_17];
      var_16 = var_16 - 1;
      var_11[var_17] = var_11[var_16];
      var_11[var_16] = var_18;

      if(!isDefined(var_5)) {
        if(!isDefined(var_4))
          var_19 = [[var_3]](var_18);
        else
          var_19 = var_4[[var_3]](var_18);
      } else if(!isDefined(var_6)) {
        if(!isDefined(var_4))
          var_19 = [[var_3]](var_18, var_5);
        else
          var_19 = var_4[[var_3]](var_18, var_5);
      } else if(!isDefined(var_7)) {
        if(!isDefined(var_4))
          var_19 = [[var_3]](var_18, var_5, var_6);
        else
          var_19 = var_4[[var_3]](var_18, var_5, var_6);
      } else if(!isDefined(var_8)) {
        if(!isDefined(var_4))
          var_19 = [[var_3]](var_18, var_5, var_6, var_7);
        else
          var_19 = var_4[[var_3]](var_18, var_5, var_6, var_7);
      } else if(!isDefined(var_4))
        var_19 = [[var_3]](var_18, var_5, var_6, var_7, var_8);
      else
        var_19 = var_4[[var_3]](var_18, var_5, var_6, var_7, var_8);

      if(!isDefined(var_19) || var_19) {
        var_15 = 0;

        if(var_2 <= var_1) {
          wait(var_1);
          continue;
        }

        wait(_func_0A5(var_1, var_2));
      }
    }
  }
}

_id_56F4() {
  var_0 = gettime();

  if(isDefined(self._id_3D48) && var_0 < self._id_3D48)
    return 1;

  return 0;
}

_id_56B5() {
  var_0 = gettime();

  if(isDefined(self._id_2577) && var_0 < self._id_2577)
    return 1;

  return 0;
}

_id_56F2() {
  var_0 = gettime();

  if(isDefined(self._id_3D39) && var_0 < self._id_3D39)
    return 1;

  return 0;
}

_id_5701() {
  var_0 = gettime();

  if(isDefined(self._id_3FE5) && var_0 < self._id_3FE5)
    return 1;

  return 0;
}

_id_57D0() {
  var_0 = gettime();

  if(isDefined(self._id_8C5E) && var_0 < self._id_8C5E)
    return 1;

  if(isDefined(self._id_8C5B) && var_0 < self._id_8C5B)
    return 1;

  return 0;
}

_id_3C83(var_0) {
  return isDefined(level._id_3C77[var_0]);
}

_id_3C77(var_0) {
  return level._id_3C77[var_0];
}

_id_3C89(var_0) {
  if(!_id_3C83(var_0))
    return 0;

  return _id_3C77(var_0);
}

_id_51D1() {
  level._id_3C77 = [];
  level._id_3CC6 = [];
  level._id_402A = 0;

  if(!isDefined(level._id_8F64))
    level._id_8F64 = ::_id_35FA;

  level._id_3C92 = spawnStruct();
  level._id_3C92 _id_10DA();
}

flag_init(var_0) {
  if(!isDefined(level._id_3C77))
    _id_51D1();

  level._id_3C77[var_0] = 0;

  if(!isDefined(level._id_9D7B)) {
    _id_5275();
    level._id_9D7B[var_0] = [];
  } else if(!isDefined(level._id_9D7B[var_0]))
    level._id_9D7B[var_0] = [];

  if(_id_578E(var_0, "aa_"))
    thread[[level._id_8F64]](var_0);
}

_id_35FA(var_0) {}

_id_57E9(var_0, var_1, var_2, var_3) {
  if(var_1.size > var_0.size)
    return 0;

  var_4 = getsubstr(var_0, var_2, var_3);
  return var_4 == var_1;
}

_id_578E(var_0, var_1) {
  return _id_57E9(var_0, var_1, 0, var_1.size);
}

_id_57EF(var_0, var_1) {
  return _id_57E9(var_0, var_1, var_0.size - var_1.size, var_0.size);
}

flag_set(var_0, var_1) {
  level._id_3C77[var_0] = 1;
  _id_85AF(var_0);

  if(isDefined(var_1))
    level notify(var_0, var_1);
  else
    level notify(var_0);
}

_id_10DA() {
  self._id_A01E = "generic" + level._id_402A;
  level._id_402A++;
}

_id_3C9F(var_0) {
  var_1 = undefined;

  while(!_id_3C77(var_0)) {
    var_1 = undefined;
    level waittill(var_0, var_1);
  }

  if(isDefined(var_1))
    return var_1;
}

_id_3C7B(var_0, var_1) {
  if(!_id_3C77(var_0)) {
    return;
  }
  level._id_3C77[var_0] = 0;
  _id_85AF(var_0);

  if(isDefined(var_1))
    level notify(var_0, var_1);
  else
    level notify(var_0);
}

flag_waitopen(var_0) {
  var_1 = undefined;

  while(_id_3C77(var_0)) {
    var_1 = undefined;
    level waittill(var_0, var_1);
  }

  if(isDefined(var_1))
    return var_1;
}

_id_3799(var_0) {
  if(!isDefined(self._id_3794)) {
    self._id_3794 = [];
    self._id_37A3 = [];
  }

  self._id_3794[var_0] = 0;
}

_id_3798(var_0) {
  if(isDefined(self._id_3794) && isDefined(self._id_3794[var_0]))
    return 1;

  return 0;
}

_id_379B(var_0, var_1) {
  self endon("death");
  wait(var_1);
  _id_379A(var_0);
}

_id_379A(var_0) {
  self._id_3794[var_0] = 1;
  self notify(var_0);
}

_id_3796(var_0, var_1) {
  if(self._id_3794[var_0]) {
    self._id_3794[var_0] = 0;
    self notify(var_0);
  }

  if(isDefined(var_1) && var_1)
    self._id_3794[var_0] = undefined;
}

_id_3797(var_0, var_1) {
  wait(var_1);
  _id_3796(var_0);
}

_id_3794(var_0) {
  return self._id_3794[var_0];
}

_id_379C(var_0) {
  while(isDefined(self) && !self._id_3794[var_0])
    self waittill(var_0);
}

_id_37A0(var_0) {
  while(isDefined(self) && !self._id_3794[var_0])
    self waittill(var_0);
}

_id_379E(var_0, var_1) {
  while(isDefined(self)) {
    if(_id_3794(var_0)) {
      return;
    }
    if(_id_3794(var_1)) {
      return;
    }
    _id_A732(var_0, var_1);
  }
}

_id_379F(var_0, var_1) {
  var_2 = gettime();

  while(isDefined(self)) {
    if(self._id_3794[var_0]) {
      break;
    }

    if(gettime() >= var_2 + var_1 * 1000) {
      break;
    }

    _id_37AF(var_0, var_1);
  }
}

_id_37AF(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

_id_37A1(var_0) {
  while(isDefined(self) && self._id_3794[var_0])
    self waittill(var_0);
}

_id_3795(var_0) {}

_id_37A2(var_0, var_1) {
  while(isDefined(self)) {
    if(!_id_3794(var_0)) {
      return;
    }
    if(!_id_3794(var_1)) {
      return;
    }
    _id_A732(var_0, var_1);
  }
}

_id_A732(var_0, var_1) {
  self endon(var_0);
  self waittill(var_1);
}

_id_0FB2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(var_10)) {
    foreach(var_12 in var_0)
    var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  } else {
    if(isDefined(var_9)) {
      foreach(var_12 in var_0)
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

      return;
    }

    if(isDefined(var_8)) {
      foreach(var_12 in var_0)
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);

      return;
    }

    if(isDefined(var_7)) {
      foreach(var_12 in var_0)
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7);

      return;
    }

    if(isDefined(var_6)) {
      foreach(var_12 in var_0)
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6);

      return;
    }

    if(isDefined(var_5)) {
      foreach(var_12 in var_0)
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5);

      return;
    }

    if(isDefined(var_4)) {
      foreach(var_12 in var_0)
      var_12 thread[[var_1]](var_2, var_3, var_4);

      return;
    }

    if(isDefined(var_3)) {
      foreach(var_12 in var_0)
      var_12 thread[[var_1]](var_2, var_3);

      return;
    }

    if(isDefined(var_2)) {
      foreach(var_12 in var_0)
      var_12 thread[[var_1]](var_2);

      return;
    }

    foreach(var_12 in var_0)
    var_12 thread[[var_1]]();
  }
}

_id_0F71(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_5)) {
    foreach(var_7 in var_0)
    var_7 call[[var_1]](var_2, var_3, var_4, var_5);

    return;
  }

  if(isDefined(var_4)) {
    foreach(var_7 in var_0)
    var_7 call[[var_1]](var_2, var_3, var_4);

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_7 in var_0)
    var_7 call[[var_1]](var_2, var_3);

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_7 in var_0)
    var_7 call[[var_1]](var_2);

    return;
  }

  foreach(var_7 in var_0)
  var_7 call[[var_1]]();
}

_id_6753(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    foreach(var_6 in var_0)
    call[[var_1]](var_6, var_2, var_3, var_4);

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_6 in var_0)
    call[[var_1]](var_6, var_2, var_3);

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_6 in var_0)
    call[[var_1]](var_6, var_2);

    return;
  }

  foreach(var_6 in var_0)
  call[[var_1]](var_6);
}

_id_0FB5(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_0FB2(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_0FB6(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  _id_0FB2(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_9DA3(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = getEntArray(var_0, var_1);
    _id_0FB2(var_2, ::_id_9DA4);
  } else
    _id_9DA4();
}

_id_9DA4() {
  if(isDefined(self._id_7AC4))
    self.origin = self._id_7AC4;

  self._id_9D9F = undefined;
}

_id_9D9F(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = getEntArray(var_0, var_1);
    _id_0FB2(var_2, ::_id_9DA1);
  } else
    _id_9DA1();
}

_id_9DA1() {
  if(!isDefined(self._id_7AC4))
    self._id_7AC4 = self.origin;

  if(self.origin == self._id_7AC4)
    self.origin = self.origin + (0, 0, -10000);

  self._id_9D9F = 1;
}

_id_85AF(var_0) {
  if(!isDefined(level._id_9D7B)) {
    return;
  }
  level._id_9D7B[var_0] = _id_0FA0(level._id_9D7B[var_0]);
  _id_0FB2(level._id_9D7B[var_0], ::_id_A0D3);
}

_id_A0D3() {
  var_0 = 1;

  if(isDefined(self._id_81A1)) {
    var_0 = 0;
    var_1 = _id_2798(self._id_81A1);

    foreach(var_3 in var_1) {
      if(_id_3C77(var_3)) {
        var_0 = 1;
        break;
      }
    }
  }

  var_5 = 1;

  if(isDefined(self._id_819E)) {
    var_1 = _id_2798(self._id_819E);

    foreach(var_3 in var_1) {
      if(_id_3C77(var_3)) {
        var_5 = 0;
        break;
      }
    }
  }

  [[level._id_9D81[var_0 && var_5]]]();
}

_id_2798(var_0) {
  var_1 = strtok(var_0, " ");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isDefined(level._id_3C77[var_1[var_2]]))
      flag_init(var_1[var_2]);
  }

  return var_1;
}

_id_5275() {
  level._id_9D7B = [];
  level._id_9D81[1] = ::_id_9DA3;
  level._id_9D81[0] = ::_id_9D9F;
}

_id_4395() {
  if(isDefined(self._id_819A))
    return self._id_819A;
}

_id_46B5(var_0, var_1) {
  var_2 = level._id_947C[var_1][var_0];

  if(!isDefined(var_2))
    return undefined;

  if(var_2.size > 1)
    return undefined;

  return var_2[0];
}

_id_46B7(var_0, var_1) {
  var_2 = level._id_947C[var_1][var_0];

  if(!isDefined(var_2))
    return [];

  return var_2;
}

_id_44BD(var_0, var_1) {
  var_2 = _func_18E(var_0, var_1);

  if(isDefined(var_2))
    return var_2;

  return _id_46B5(var_0, var_1);
}

_id_44BE(var_0, var_1) {
  var_2 = _id_46B7(var_0, var_1);
  var_3 = getEntArray(var_0, var_1);

  if(var_3.size > 0)
    var_2 = _id_0F73(var_2, var_3);

  return var_2;
}

_id_44BF(var_0, var_1) {
  var_2 = _id_44BD(var_0, var_1);

  if(!isDefined(var_2))
    var_2 = _func_0B5(var_0, var_1);

  if(!isDefined(var_2))
    var_2 = _func_1DB(var_0, var_1);

  return var_2;
}

_id_44C0(var_0, var_1) {
  var_2 = _id_46B7(var_0, var_1);
  var_3 = getEntArray(var_0, var_1);

  if(var_3.size > 0)
    var_2 = _id_0F73(var_2, var_3);

  var_3 = _func_0B6(var_0, var_1);

  if(var_3.size > 0)
    var_2 = _id_0F73(var_2, var_3);

  var_3 = _func_1DC(var_0, var_1);

  if(var_3.size > 0)
    var_2 = _id_0F73(var_2, var_3);

  return var_2;
}

_id_947B() {
  level._id_947C = [];
  level._id_947C["target"] = [];
  level._id_947C["targetname"] = [];
  level._id_947C["script_noteworthy"] = [];
  level._id_947C["script_linkname"] = [];

  foreach(var_1 in level.struct)
  _id_096C(var_1);
}

_id_096C(var_0) {
  if(isDefined(var_0.targetname)) {
    if(!isDefined(level._id_947C["targetname"][var_0.targetname]))
      level._id_947C["targetname"][var_0.targetname] = [];

    var_1 = level._id_947C["targetname"][var_0.targetname].size;
    level._id_947C["targetname"][var_0.targetname][var_1] = var_0;
  }

  if(isDefined(var_0.target)) {
    if(!isDefined(level._id_947C["target"][var_0.target]))
      level._id_947C["target"][var_0.target] = [];

    var_1 = level._id_947C["target"][var_0.target].size;
    level._id_947C["target"][var_0.target][var_1] = var_0;
  }

  if(isDefined(var_0._id_0165)) {
    if(!isDefined(level._id_947C["script_noteworthy"][var_0._id_0165]))
      level._id_947C["script_noteworthy"][var_0._id_0165] = [];

    var_1 = level._id_947C["script_noteworthy"][var_0._id_0165].size;
    level._id_947C["script_noteworthy"][var_0._id_0165][var_1] = var_0;
  }

  if(isDefined(var_0._id_0164)) {
    if(!isDefined(level._id_947C["script_linkname"][var_0._id_0164]))
      level._id_947C["script_linkname"][var_0._id_0164] = [];

    var_1 = level._id_947C["script_linkname"][var_0._id_0164].size;
    level._id_947C["script_linkname"][var_0._id_0164][var_1] = var_0;
  }
}

_id_3ABC(var_0) {}

_id_3ABA() {}

_id_3AB8(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;
}

_id_3AB9(var_0, var_1) {}

_id_3AB7() {}

_id_3AB6() {}

_id_3ABB(var_0) {}

_id_0F93(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(var_4 != var_1)
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_0F7D(var_0, var_1) {
  var_2 = var_0;
  var_2 = _id_0F94(var_2, var_1);
  return var_2;
}

_id_0F94(var_0, var_1) {
  foreach(var_3 in var_1)
  var_0 = _id_0F93(var_0, var_3);

  return var_0;
}

_id_0F98(var_0, var_1) {
  if(!isDefined(var_1))
    return undefined;

  var_2 = [];

  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(isDefined(var_0)) {
      if(var_0 != var_4)
        var_2[var_2.size] = var_4;

      continue;
    }

    var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_0FA0(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_0F97(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = 1;

    foreach(var_6 in var_1) {
      if(var_3 == var_6) {
        var_4 = 0;
        break;
      }
    }

    if(var_4)
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_0F8A(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    foreach(var_6 in var_0)
    thread[[var_1]](var_6, var_2, var_3, var_4);

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_6 in var_0)
    thread[[var_1]](var_6, var_2, var_3);

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_6 in var_0)
    thread[[var_1]](var_6, var_2);

    return;
  }

  foreach(var_6 in var_0)
  thread[[var_1]](var_6);
}

_id_0F89(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    foreach(var_6 in var_0)
    call[[var_1]](var_6, var_2, var_3, var_4);

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_6 in var_0)
    call[[var_1]](var_6, var_2, var_3);

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_6 in var_0)
    call[[var_1]](var_6, var_2);

    return;
  }

  foreach(var_6 in var_0)
  call[[var_1]](var_6);
}

_id_0F8C(var_0, var_1) {
  if(var_0.size == 0)
    return var_1;

  if(var_1.size == 0)
    return var_0;

  var_2 = var_0;

  foreach(var_4 in var_1) {
    var_5 = 0;

    foreach(var_7 in var_0) {
      if(var_7 == var_4) {
        var_5 = 1;
        break;
      }
    }

    if(var_5)
      continue;
    else
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_0972(var_0, var_1) {
  if(!isDefined(var_1))
    return var_0;

  if(!isDefined(var_0))
    var_0[0] = var_1;
  else
    var_0[var_0.size] = var_1;

  return var_0;
}

_id_0FA3(var_0, var_1, var_2) {
  if(var_0.size <= 0)
    return [];

  if(!isDefined(var_2) || var_2 > var_0.size)
    var_2 = var_0.size;

  if(var_1 == 0 && var_2 == var_0.size)
    return var_0;

  var_3 = [];

  for(var_4 = var_1; var_4 < var_2; var_4++)
    var_3[var_3.size] = var_0[var_4];

  return var_3;
}

_id_3C78(var_0) {}

_id_3CA5(var_0, var_1) {
  for(;;) {
    if(_id_3C77(var_0)) {
      return;
    }
    if(_id_3C77(var_1)) {
      return;
    }
    level _id_A732(var_0, var_1);
  }
}

_id_3CA6(var_0, var_1) {
  for(;;) {
    if(_id_3C77(var_0))
      return var_0;

    if(_id_3C77(var_1))
      return var_1;

    var_2 = level _id_A715(var_0, var_1);
    return var_2;
  }
}

_id_3CAB(var_0, var_1) {
  for(;;) {
    if(!_id_3C77(var_0))
      return var_0;

    if(!_id_3C77(var_1))
      return var_1;

    level _id_A732(var_0, var_1);
  }
}

_id_3CAC(var_0, var_1) {
  return _id_3CAB(var_0, var_1);
}

_id_3CA3(var_0) {
  foreach(var_2 in var_0) {
    if(_id_3C77(var_2))
      return var_2;
  }

  return level _id_A712(var_0);
}

_id_3CA2(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];

  if(isDefined(var_5)) {
    var_6[var_6.size] = var_0;
    var_6[var_6.size] = var_1;
    var_6[var_6.size] = var_2;
    var_6[var_6.size] = var_3;
    var_6[var_6.size] = var_4;
    var_6[var_6.size] = var_5;
  } else if(isDefined(var_4)) {
    var_6[var_6.size] = var_0;
    var_6[var_6.size] = var_1;
    var_6[var_6.size] = var_2;
    var_6[var_6.size] = var_3;
    var_6[var_6.size] = var_4;
  } else if(isDefined(var_3)) {
    var_6[var_6.size] = var_0;
    var_6[var_6.size] = var_1;
    var_6[var_6.size] = var_2;
    var_6[var_6.size] = var_3;
  } else if(isDefined(var_2)) {
    var_6[var_6.size] = var_0;
    var_6[var_6.size] = var_1;
    var_6[var_6.size] = var_2;
  } else if(isDefined(var_1)) {
    _id_3CA5(var_0, var_1);
    return;
  } else
    return;

  for(;;) {
    for(var_7 = 0; var_7 < var_6.size; var_7++) {
      if(_id_3C77(var_6[var_7]))
        return;
    }

    level _id_A70A(var_0, var_1, var_2, var_3, var_4, var_5);
  }
}

_id_3CA4(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];

  if(isDefined(var_4)) {
    var_5[var_5.size] = var_0;
    var_5[var_5.size] = var_1;
    var_5[var_5.size] = var_2;
    var_5[var_5.size] = var_3;
    var_5[var_5.size] = var_4;
  } else if(isDefined(var_3)) {
    var_5[var_5.size] = var_0;
    var_5[var_5.size] = var_1;
    var_5[var_5.size] = var_2;
    var_5[var_5.size] = var_3;
  } else if(isDefined(var_2)) {
    var_5[var_5.size] = var_0;
    var_5[var_5.size] = var_1;
    var_5[var_5.size] = var_2;
  } else if(isDefined(var_1)) {
    var_6 = _id_3CA6(var_0, var_1);
    return var_6;
  } else
    return;

  for(;;) {
    for(var_7 = 0; var_7 < var_5.size; var_7++) {
      if(_id_3C77(var_5[var_7]))
        return var_5[var_7];
    }

    var_6 = level _id_A715(var_0, var_1, var_2, var_3, var_4);
    return var_6;
  }
}

_id_3CA0(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0))
    _id_3C9F(var_0);

  if(isDefined(var_1))
    _id_3C9F(var_1);

  if(isDefined(var_2))
    _id_3C9F(var_2);

  if(isDefined(var_3))
    _id_3C9F(var_3);
}

_id_3CA1(var_0) {
  var_0 = _id_0FA0(var_0);

  for(;;) {
    foreach(var_2 in var_0)
    _id_3C9F(var_2);

    var_4 = 0;

    foreach(var_2 in var_0) {
      if(_id_3C77(var_2))
        var_4++;
    }

    if(var_4 == var_0.size) {
      break;
    }
  }
}

_id_3CA8(var_0, var_1) {
  var_2 = var_1 * 1000;
  var_3 = gettime();

  for(;;) {
    if(_id_3C77(var_0)) {
      break;
    }

    if(gettime() >= var_3 + var_2) {
      break;
    }

    var_4 = var_2 - (gettime() - var_3);
    var_5 = var_4 / 1000;
    _id_A64B(var_0, var_5);
  }
}

_id_3CAD(var_0, var_1) {
  var_2 = gettime();

  for(;;) {
    if(!_id_3C77(var_0)) {
      break;
    }

    if(gettime() >= var_2 + var_1 * 1000) {
      break;
    }

    _id_A64B(var_0, var_1);
  }
}

_id_A64B(var_0, var_1) {
  level endon(var_0);
  wait(var_1);
}

_id_2CBE(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  thread _id_2CBF(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

_id_2CBF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(issp()) {
    self endon("death");
    self endon("stop_delay_call");
  }

  wait(var_1);

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_10))
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  else if(isDefined(var_9))
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  else if(isDefined(var_8))
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  else if(isDefined(var_7))
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
  else if(isDefined(var_6))
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6);
  else if(isDefined(var_5))
    self call[[var_0]](var_2, var_3, var_4, var_5);
  else if(isDefined(var_4))
    self call[[var_0]](var_2, var_3, var_4);
  else if(isDefined(var_3))
    self call[[var_0]](var_2, var_3);
  else if(isDefined(var_2))
    self call[[var_0]](var_2);
  else
    self call[[var_0]]();
}

_id_2CB7(var_0) {
  self endon("death");
  self notify("cancel_delayed_show");
  self endon("cancel_delayed_show");

  if(isDefined(var_0) && var_0 > 0)
    wait(var_0);

  if(isDefined(self))
    self _meth_805B();
}

_id_2CB4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  thread _id_2CB5(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

_id_2CB5(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  wait(var_1);

  if(isDefined(var_10))
    self[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  else if(isDefined(var_9))
    self[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  else if(isDefined(var_8))
    self[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  else if(isDefined(var_7))
    self[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
  else if(isDefined(var_6))
    self[[var_0]](var_2, var_3, var_4, var_5, var_6);
  else if(isDefined(var_5))
    self[[var_0]](var_2, var_3, var_4, var_5);
  else if(isDefined(var_4))
    self[[var_0]](var_2, var_3, var_4);
  else if(isDefined(var_3))
    self[[var_0]](var_2, var_3);
  else if(isDefined(var_2))
    self[[var_0]](var_2);
  else
    self[[var_0]]();
}

_id_8134(var_0) {
  switch (var_0.size) {
    case 1:
      return self[[var_0[0]]]();
    case 2:
      return self[[var_0[0]]](var_0[1]);
    case 3:
      return self[[var_0[0]]](var_0[1], var_0[2]);
    case 4:
      return self[[var_0[0]]](var_0[1], var_0[2], var_0[3]);
    case 5:
      return self[[var_0[0]]](var_0[1], var_0[2], var_0[3], var_0[4]);
    case 6:
      return self[[var_0[0]]](var_0[1], var_0[2], var_0[3], var_0[4], var_0[5]);
    case 7:
      return self[[var_0[0]]](var_0[1], var_0[2], var_0[3], var_0[4], var_0[5], var_0[6]);
    case 8:
      return self[[var_0[0]]](var_0[1], var_0[2], var_0[3], var_0[4], var_0[5], var_0[6], var_0[7]);
    default:
      return;
  }
}

_id_8133(var_0, var_1) {
  if(!isDefined(var_1) || var_1.size == 0)
    self[[var_0]]();
  else {
    switch (var_1.size) {
      case 1:
        self[[var_0]](var_1[0]);
        break;
      case 2:
        self[[var_0]](var_1[0], var_1[1]);
        break;
      case 3:
        self[[var_0]](var_1[0], var_1[1], var_1[2]);
        break;
      case 4:
        self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3]);
        break;
      case 5:
        self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4]);
        break;
      case 6:
        self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5]);
        break;
      case 7:
        self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6]);
        break;
      case 8:
        self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7]);
        break;
      default:
        break;
    }
  }
}

_id_248D(var_0) {
  switch (var_0.size) {
    case 1:
      return call[[var_0[0]]]();
    case 2:
      return call[[var_0[0]]](var_0[1]);
    case 3:
      return call[[var_0[0]]](var_0[1], var_0[2]);
    case 4:
      return call[[var_0[0]]](var_0[1], var_0[2], var_0[3]);
    case 5:
      return call[[var_0[0]]](var_0[1], var_0[2], var_0[3], var_0[4]);
    case 6:
      return call[[var_0[0]]](var_0[1], var_0[2], var_0[3], var_0[4], var_0[5]);
    case 7:
      return call[[var_0[0]]](var_0[1], var_0[2], var_0[3], var_0[4], var_0[5], var_0[6]);
    case 8:
      return call[[var_0[0]]](var_0[1], var_0[2], var_0[3], var_0[4], var_0[5], var_0[6], var_0[7]);
    default:
      return;
  }
}

_id_6754(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread _id_6755(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_6755(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  wait(var_1);

  if(isDefined(var_7))
    call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
  else if(isDefined(var_6))
    call[[var_0]](var_2, var_3, var_4, var_5, var_6);
  else if(isDefined(var_5))
    call[[var_0]](var_2, var_3, var_4, var_5);
  else if(isDefined(var_4))
    call[[var_0]](var_2, var_3, var_4);
  else if(isDefined(var_3))
    call[[var_0]](var_2, var_3);
  else if(isDefined(var_2))
    call[[var_0]](var_2);
  else
    call[[var_0]]();
}

issp() {
  if(!isDefined(level.issp))
    level.issp = !_id_9467(getDvar("1673"), "mp_");

  return level.issp;
}

_id_57D8() {
  if(!isDefined(level._id_57D8))
    level._id_57D8 = _id_9467(getDvar("1673"), "so_td_");

  return level._id_57D8;
}

_id_9467(var_0, var_1) {
  if(var_0.size < var_1.size)
    return 0;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(_func_117(var_0[var_2]) != _func_117(var_1[var_2]))
      return 0;
  }

  return 1;
}

_id_9462(var_0, var_1) {
  if(var_0.size < var_1.size)
    return -1;

  if(var_1.size == 0)
    return 0;

  var_2 = 0;

  for(var_3 = 0; var_2 < var_0.size; var_2++) {
    if(_func_117(var_0[var_2]) == _func_117(var_1[var_3]))
      var_3++;
    else {
      var_3 = 0;

      if(_func_117(var_0[var_2]) == _func_117(var_1[var_3]))
        var_3++;
      else if(var_2 > var_0.size - var_1.size)
        return -1;
    }

    if(var_3 >= var_1.size)
      return var_2 - var_3 + 1;
  }

  return -1;
}

_id_74F1(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0[0];

  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_3))
    var_3 = 1;

  if(!isDefined(var_4))
    var_4 = 0.05;

  for(var_6 = 1; var_6 < var_0.size; var_6++) {
    thread _id_33BA(var_5, var_0[var_6], var_1, var_2, var_3, var_4);
    var_5 = var_0[var_6];
  }
}

_id_33BA(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_6))
    var_6 = 0;
}

_id_9580(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_0)
  var_2[var_5] = var_4;

  foreach(var_5, var_4 in var_1)
  var_2[var_5] = var_4;

  return var_2;
}

_id_0F73(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = [];

  foreach(var_5 in var_0) {
    if(isDefined(var_5) || var_2)
      var_3[var_3.size] = var_5;
  }

  foreach(var_5 in var_1) {
    if(isDefined(var_5) || var_2)
      var_3[var_3.size] = var_5;
  }

  return var_3;
}

_id_0F76(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_0)
  var_2[var_5] = var_4;

  foreach(var_5, var_4 in var_1)
  var_2[var_5] = var_4;

  return var_2;
}

array_randomize(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = randomint(var_0.size);
    var_3 = var_0[var_1];
    var_0[var_1] = var_0[var_2];
    var_0[var_2] = var_3;
  }

  return var_0;
}

_id_0F6F(var_0, var_1) {
  var_0[var_0.size] = var_1;
  return var_0;
}

_id_0F82(var_0) {
  var_1 = undefined;

  foreach(var_3 in var_0) {
    var_1 = var_3;
    break;
  }

  return var_1;
}

_id_0F88(var_0, var_1) {
  var_2 = [];
  var_3 = 0;

  foreach(var_6, var_5 in var_0) {
    if(var_3 < var_1)
      var_2[var_6] = var_5;
    else
      break;

    var_3++;
  }

  return var_2;
}

_id_0F86(var_0, var_1, var_2) {
  if(var_2 == var_0.size) {
    var_3 = var_0;
    var_3[var_3.size] = var_1;
    return var_3;
  }

  var_3 = [];
  var_4 = 0;

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    if(var_5 == var_2) {
      var_3[var_5] = var_1;
      var_4 = 1;
    }

    var_3[var_5 + var_4] = var_0[var_5];
  }

  return var_3;
}

_id_0F9B(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(var_0[var_3] != var_1)
      var_2[var_2.size] = var_0[var_3];
  }

  return var_2;
}

_id_0F9A(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size - 1; var_2++) {
    if(var_2 == var_1) {
      var_0[var_2] = var_0[var_2 + 1];
      var_1++;
    }
  }

  var_0[var_0.size - 1] = undefined;
  return var_0;
}

_id_0F8E(var_0, var_1, var_2) {
  foreach(var_5, var_4 in var_0)
  var_4 notify(var_1, var_2);
}

_id_0F79(var_0, var_1) {
  if(var_0.size <= 0)
    return 0;

  foreach(var_3 in var_0) {
    if(var_3 == var_1)
      return 1;
  }

  return 0;
}

_id_0F7E(var_0, var_1) {
  foreach(var_4, var_3 in var_0) {
    if(var_3 == var_1)
      return var_4;
  }

  return undefined;
}

_id_0F78(var_0, var_1) {
  if(var_0.size != var_1.size)
    return 0;

  foreach(var_5, var_3 in var_0) {
    if(!isDefined(var_1[var_5]))
      return 0;

    var_4 = var_1[var_5];

    if(var_4 != var_3)
      return 0;
  }

  return 1;
}

_id_3D5C(var_0) {
  var_1 = (0, var_0[1], 0);
  return var_1;
}

_id_3D5D(var_0) {
  var_1 = (var_0[0], var_0[1], 0);
  return var_1;
}

_id_33A0(var_0, var_1, var_2, var_3) {
  level endon("newpath");
  var_4 = [];
  var_5 = vectortoangles(var_0 - var_1);
  var_6 = anglestoright(var_5);
  var_7 = anglesToForward(var_5);
  var_8 = anglestoup(var_5);
  var_9 = distance(var_0, var_1);
  var_10 = [];
  var_11 = 0.1;
  var_10[0] = var_0;
  var_10[1] = var_0 + var_6 * (var_9 * var_11) + var_7 * (var_9 * -0.1);
  var_10[2] = var_1;
  var_10[3] = var_0 + var_6 * (var_9 * (-1 * var_11)) + var_7 * (var_9 * -0.1);
  var_10[4] = var_0;
  var_10[5] = var_0 + var_8 * (var_9 * var_11) + var_7 * (var_9 * -0.1);
  var_10[6] = var_1;
  var_10[7] = var_0 + var_8 * (var_9 * (-1 * var_11)) + var_7 * (var_9 * -0.1);
  var_10[8] = var_0;
  var_12 = var_2[0];
  var_13 = var_2[1];
  var_14 = var_2[2];
  _id_74F1(var_10, var_12, var_13, var_14, var_3);
}

_id_41F0() {
  var_0 = [];

  if(isDefined(self.script_exploder)) {
    var_1 = _id_41F3();

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = _id_46B7(var_1[var_2], "script_linkname");

      if(var_3.size > 0)
        var_0 = _id_0F73(var_0, var_3);
    }
  }

  return var_0;
}

_id_41ED() {
  var_0 = [];

  if(isDefined(self.script_exploder)) {
    var_1 = _id_41F3();

    foreach(var_3 in var_1) {
      var_4 = getEntArray(var_3, "script_linkname");

      if(var_4.size > 0)
        var_0 = _id_0F73(var_0, var_4);
    }
  }

  return var_0;
}

_id_41EE() {
  var_0 = [];

  if(isDefined(self.script_exploder)) {
    var_1 = _id_41F3();

    foreach(var_3 in var_1) {
      var_4 = _func_0B6(var_3, "script_linkname");

      if(var_4.size > 0)
        var_0 = _id_0F73(var_0, var_4);
    }
  }

  return var_0;
}

_id_41F2() {
  var_0 = [];

  if(isDefined(self.script_exploder)) {
    var_1 = _id_41F3();

    foreach(var_3 in var_1) {
      var_4 = _func_1DC(var_3, "script_linkname");

      if(var_4.size > 0)
        var_0 = _id_0F73(var_0, var_4);
    }
  }

  return var_0;
}

_id_41EC() {
  var_0 = _id_41ED();
  return var_0[0];
}

_id_41F1() {
  var_0 = _id_41F2();
  return var_0[0];
}

_id_41F3() {
  return strtok(self.script_exploder, " ");
}

_id_7F77(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEntArray(var_0, "targetname");
  _id_0FB2(var_5, var_1, var_2, var_3, var_4);
  var_5 = _id_46B7(var_0, "targetname");
  _id_0FB2(var_5, var_1, var_2, var_3, var_4);
  var_5 = call[[level._id_45B1]](var_0, "targetname");
  _id_0FB2(var_5, var_1, var_2, var_3, var_4);
  var_5 = _func_1DC(var_0, "targetname");
  _id_0FB2(var_5, var_1, var_2, var_3, var_4);
}

_id_7F76(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEntArray(var_0, "script_noteworthy");
  _id_0FB2(var_5, var_1, var_2, var_3, var_4);
  var_5 = _id_46B7(var_0, "script_noteworthy");
  _id_0FB2(var_5, var_1, var_2, var_3, var_4);
  var_5 = call[[level._id_45B1]](var_0, "script_noteworthy");
  _id_0FB2(var_5, var_1, var_2, var_3, var_4);
  var_5 = _func_1DC(var_0, "script_noteworthy");
  _id_0FB2(var_5, var_1, var_2, var_3, var_4);
}

_id_339D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = -1 * var_4;
  var_9 = undefined;

  for(var_10 = 0; var_10 <= var_5; var_10++) {
    var_11 = vectorNormalize(_func_112(var_3, (0, var_8, 0)));
    var_12 = var_11 * var_1;

    if(var_10 == 0 || var_10 == var_5) {}

    if(isDefined(var_9)) {}

    var_9 = var_12;
    var_8 = var_8 + var_4 * 2 * (1 / var_5);
  }
}

_id_339F(var_0, var_1, var_2) {
  level endon("newpath");
  var_3 = [];
  var_4 = vectortoangles(var_0 - var_1);
  var_5 = anglestoright(var_4);
  var_6 = anglesToForward(var_4);
  var_7 = distance(var_0, var_1);
  var_8 = [];
  var_9 = 0.05;
  var_8[0] = var_0;
  var_8[1] = var_0 + var_5 * (var_7 * var_9) + var_6 * (var_7 * -0.2);
  var_8[2] = var_1;
  var_8[3] = var_0 + var_5 * (var_7 * (-1 * var_9)) + var_6 * (var_7 * -0.2);

  for(var_10 = 0; var_10 < 4; var_10++) {
    var_11 = var_10 + 1;

    if(var_11 >= 4)
      var_11 = 0;
  }
}

_id_33B7(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    var_2 = (0, 1, 0);

  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_4))
    var_4 = 0.05;

  if(var_3)
    var_5 = int(var_4 / 0.05);
  else
    var_5 = int(var_1 / 0.05);

  var_6 = [];
  var_7 = [];
  var_8 = gettime();

  for(var_9 = var_8 + var_1 * 1000; var_8 < var_9 && isDefined(var_0); var_8 = gettime()) {
    var_6[0] = var_0 _meth_8216(1, 1, 1);
    var_6[1] = var_0 _meth_8216(1, 1, -1);
    var_6[2] = var_0 _meth_8216(-1, 1, -1);
    var_6[3] = var_0 _meth_8216(-1, 1, 1);
    var_7[0] = var_0 _meth_8216(1, -1, 1);
    var_7[1] = var_0 _meth_8216(1, -1, -1);
    var_7[2] = var_0 _meth_8216(-1, -1, -1);
    var_7[3] = var_0 _meth_8216(-1, -1, 1);

    for(var_10 = 0; var_10 < 4; var_10++) {
      var_11 = var_10 + 1;

      if(var_11 == 4)
        var_11 = 0;
    }

    if(!var_3) {
      return;
    }
    wait(var_4);
  }
}

_id_33D1(var_0, var_1, var_2, var_3, var_4) {
  _id_33B7(var_0, var_1, var_2, var_3, var_4);
}

_id_33CD(var_0, var_1, var_2, var_3, var_4) {
  _id_33B7(var_0, var_1, var_2, var_3, var_4);
}

_id_339C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = _func_065(var_0);

  if(!isDefined(var_4))
    var_4 = var_7;

  if(!isDefined(var_6))
    var_6 = 1;

  var_8 = 0.05;

  for(var_9 = 0; var_9 <= var_7; var_9 = var_9 + var_8) {
    var_10 = var_6 * _func_083(var_0, 0, var_9 / var_7);
    var_11 = var_6 * _func_083(var_0, 0, _func_0AF((var_9 + 0.05) / var_7, 1));
    var_12 = _func_111(var_1, var_2, (0, 0, 0), (0, 0, 0), var_10, (0, 0, 0))["origin"];
    var_13 = _func_111(var_1, var_2, (0, 0, 0), (0, 0, 0), var_11, (0, 0, 0))["origin"];
    _id_33A0(var_12, var_13, var_3, var_4);

    if(isDefined(var_5) && var_9 + var_8 >= var_7) {}
  }
}

_id_44F5(var_0) {
  return level._effect[var_0];
}

_id_3F6F(var_0) {
  return isDefined(level._effect[var_0]);
}

_id_770A(var_0, var_1) {
  var_2 = var_1 + "," + var_0;

  if(isDefined(level._id_2895[var_2])) {
    return;
  }
  level._id_2895[var_2] = 1;
}

_id_3AB2(var_0) {}

_id_4550() {
  return self._id_8061;
}

_id_747D() {}

_id_5818() {
  return !self._id_2F80;
}

_id_0601() {
  if(!isDefined(self._id_2F80))
    self._id_2F80 = 0;

  self._id_2F80++;
  self _meth_8331();
}

_id_0615() {
  if(!isDefined(self._id_2F80))
    self._id_2F80 = 0;
  else if(self._id_2F80 > 0) {
    self._id_2F80--;

    if(self._id_2F80 == 0)
      self _meth_8332();
  }
}

_id_7D75() {
  self._id_2F80 = 0;
  self _meth_8332();
}

_id_0602() {
  if(!isDefined(self._id_2F81))
    self._id_2F81 = 0;

  self._id_2F81++;
  self _meth_8322();
}

_id_0616() {
  if(!isDefined(self._id_2F81))
    self._id_2F81 = 0;

  self._id_2F81--;

  if(!self._id_2F81)
    self _meth_8323();
}

_id_5851() {
  return !self._id_2F81;
}

_id_0603() {
  if(!isDefined(self._id_2F82))
    self._id_2F82 = 0;

  self._id_2F82++;
  self _meth_8326();
}

_id_0617() {
  if(!isDefined(self._id_2F82))
    self._id_2F82 = 0;

  self._id_2F82--;

  if(!self._id_2F82)
    self _meth_8327();
}

_id_0668() {
  return !self._id_2F82;
}

_disableoffhandweapons() {
  if(!isDefined(self._id_2F7E))
    self._id_2F7E = 0;

  self._id_2F7E++;
  self _meth_8324();
}

_id_0614() {
  if(!isDefined(self._id_2F7E))
    self._id_2F7E = 0;

  self._id_2F7E--;

  if(!self._id_2F7E)
    self _meth_8325();
}

_id_5763() {
  return !self._id_2F7E;
}

_id_0613(var_0, var_1) {
  if(!self _meth_8319(var_0)) {
    return;
  }
  if(self _meth_84D0(var_0) == var_1) {
    return;
  }
  self _meth_84CF(var_0, var_1);

  if(var_1)
    self notify("WeaponDetonateEnabled", var_0);
  else
    self notify("WeaponDetonateDisabled", var_0);
}

random(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0)
  var_1[var_1.size] = var_3;

  if(!var_1.size)
    return undefined;

  return var_1[randomint(var_1.size)];
}

_id_7A46(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0)
  var_1[var_1.size] = var_3;

  if(!var_1.size)
    return undefined;

  var_5 = randomint(var_1.size * var_1.size);
  return var_1[var_1.size - 1 - int(_func_0D9(var_5))];
}

_id_7A45(var_0) {
  var_1 = 0.0;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    var_5 = 1;

    if(isDefined(var_4._id_82E9))
      var_5 = max(1, int(var_4._id_82E9));

    for(var_6 = 0; var_6 < var_5; var_6++) {
      var_1 = var_1 + 1.0;

      if(_func_0A5(0.0, 1.0) <= 1.0 / var_1)
        var_2 = var_4;
    }
  }

  return var_2;
}

_id_8FFC() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("tag_origin");
  var_0 _meth_805C();

  if(isDefined(self.origin))
    var_0.origin = self.origin;

  if(isDefined(self.angles))
    var_0.angles = self.angles;

  return var_0;
}

waittill_notify_or_timeout(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

_id_A74D(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
  return "timeout";
}

fileprint_launcher()
{
  level._id_3ABD = 0;
  level. fileprint_launcher_start_file = 1;
  fileprint_launcher_start_file( "GAMEPRINTSTARTFILE:" );
}

fileprint_launcher_start_file( var_0 )
{
  level._id_3ABD++;

  if(level._id_3ABD > 200) {
    waitframe();
    level._id_3ABD = 0;
  }
}

fileprint_launcher_end_file( var_0, var_1 )
{
  if(!isDefined(var_1))
    var_1 = 0;

  if(var_1)
    fileprint_launcher_start_file( "GAMEPRINTENDFILE:GAMEPRINTP4ENABLED:" + var_0 );
  else
    fileprint_launcher_start_file( "GAMEPRINTENDFILE:" + var_0 );

    var_2 = gettime() + 4000;

  while(getdvarint("LAUNCHER_PRINT_SUCCESS") == 0 && getDvar("LAUNCHER_PRINT_FAIL") == "0" && gettime() < var_2)
    waitframe();

  if(!(gettime() < var_2)) {
    _func_18C("LAUNCHER_PRINT_FAIL:( TIMEOUT ): launcherconflict? restart launcher and try again? ");
    level. fileprint_launcher_start_file = undefined;
    return 0;
  }

  var_3 = getDvar("LAUNCHER_PRINT_FAIL");

  if(var_3 != "0") {
    _func_18C("LAUNCHER_PRINT_FAIL:( " + var_3 + " ): launcherconflict? restart launcher and try again? ");
    level. fileprint_launcher_start_file = undefined;
    return 0;
  }

  level. fileprint_launcher_start_file = undefined;
  return 1;
}

_id_5C25(var_0) {
  level._id_3ABD = 0;
  fileprint_launcher_start_file( "LAUNCHER_CLIP:" + var_0 );
}

_id_56C3() {
  if(!isDefined(self))
    return 0;

  return isDefined(self._id_0075);
}

pauseeffect() {
  common_scripts\_createfx::stop_fx_looper();
}

activate_individual_exploder() {
  common_scripts\_exploder::_id_0895();
}

_id_4375(var_0) {
  if(!isDefined(var_0))
    var_0 = self.target;

  var_1 = _func_18E(var_0, "targetname");

  if(isDefined(var_1))
    return var_1;

  if(issp()) {
    var_1 = call[[level._id_45B4]](var_0, "targetname");

    if(isDefined(var_1))
      return var_1;
  }

  var_1 = _id_46B5(var_0, "targetname");

  if(isDefined(var_1))
    return var_1;

  var_1 = _func_1DB(var_0, "targetname");

  if(isDefined(var_1))
    return var_1;
}

_id_424D(var_0) {
  var_1 = _func_18E(var_0, "script_noteworthy");

  if(isDefined(var_1))
    return var_1;

  if(issp()) {
    var_1 = call[[level._id_45B4]](var_0, "script_noteworthy");

    if(isDefined(var_1))
      return var_1;
  }

  var_1 = _id_46B5(var_0, "script_noteworthy");

  if(isDefined(var_1))
    return var_1;

  var_1 = _func_1DB(var_0, "script_noteworthy");

  if(isDefined(var_1))
    return var_1;
}

_id_30AE(var_0, var_1) {
  var_2 = level._id_353D[var_0];
  _func_17F(var_2["magnitude"], var_2["duration"], var_1, var_2["radius"]);
}

_id_7157(var_0, var_1) {
  if(!_func_344(var_0)) {
    return;
  }
  var_2 = spawn("script_origin", (0, 0, 0));

  if(!isDefined(var_1))
    var_1 = self.origin;

  var_2.origin = var_1;
  var_2 _meth_861D(var_0);
  return var_2;
}

_id_71AA(var_0, var_1, var_2, var_3) {
  if(!_func_344(var_0)) {
    return;
  }
  var_4 = spawn("script_origin", (0, 0, 1));

  if(!isDefined(var_1))
    var_1 = self.origin;

  var_4.origin = var_1;
  var_4.angles = var_2;

  if(isDefined(var_3) && var_3)
    var_4 _meth_861C(var_0, "sounddone");
  else
    var_4 playSound(var_0, "sounddone");

  var_4 waittill("sounddone");
  var_4 delete();
}

_id_71A9(var_0, var_1, var_2) {
  _id_71AA(var_0, var_1, (0, 0, 0), var_2);
}

_id_5EDF(var_0, var_1, var_2, var_3, var_4) {
  if(!_func_344(var_0)) {
    return;
  }
  if(isDefined(var_3))
    var_2 = undefined;

  self.v["snd_ent"] = _id_3F50(var_0, var_1);

  if(isDefined(var_3))
    thread _id_5EE9(var_3);
}

_id_5EE2(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!_func_344(var_0)) {
    return;
  }
  _id_5EDF(var_0, var_1, var_3, var_4, var_5);
}

_id_5EE0(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_5EE1(var_0, var_1, (0, 0, 0), var_2, var_3, var_4, var_5);
}

_id_5EE1(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_3))
    self endon(var_3);

  if(var_5 >= var_6) {
    for(;;)
      waitframe();
  }

  if(!_func_344(var_0)) {
    for(;;)
      waitframe();
  }

  for(;;) {
    wait(_func_0A5(var_5, var_6));
    _id_5E61("createfx_looper");
    _id_3F50(var_0, var_1);
    _id_A038("createfx_looper");
  }
}

_id_3F50(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  if(!_func_344(var_0))
    return undefined;

  if(_func_35C(var_0))
    var_3 = 0.05;

  var_4 = _func_360(var_0, var_1, var_2, var_3);
  return var_4;
}

_id_3F51() {
  if(isDefined(self) && isDefined(self.v["snd_ent"])) {
    self.v["snd_ent"] _meth_863F(0.05);
    self.v["snd_ent"] = undefined;
  }
}

_id_5EE9(var_0) {
  var_1 = self.v["snd_ent"];
  self endon("death");
  self waittill(var_0);

  if(isDefined(var_1))
    var_1 _meth_863F(0.05);
}

_id_2814(var_0) {
  var_1 = common_scripts\_createfx::createeffect("loopfx", var_0);
  var_1.v["delay"] = common_scripts\_createfx::getloopeffectdelaydefault();
  return var_1;
}

_id_281B(var_0) {
  var_1 = common_scripts\_createfx::createeffect("oneshotfx", var_0);
  var_1.v["delay"] = common_scripts\_createfx::getoneshoteffectdelaydefault();
  return var_1;
}

createexploder(var_0) {
  var_1 = common_scripts\_createfx::createeffect("exploder", var_0);
  var_1.v["delay"] = common_scripts\_createfx::getexploderdelaydefault();
  var_1.v["exploder_type"] = "normal";
  return var_1;
}

alphabetize(var_0) {
  if(var_0.size <= 1)
    return var_0;

  var_1 = 0;

  for(var_2 = var_0.size - 1; var_2 >= 1; var_2--) {
    var_3 = var_0[var_2];
    var_4 = var_2;

    for(var_5 = 0; var_5 < var_2; var_5++) {
      var_6 = var_0[var_5];

      if(_func_119(var_6, var_3) > 0) {
        var_3 = var_6;
        var_4 = var_5;
      }
    }

    if(var_4 != var_2) {
      var_0[var_4] = var_0[var_2];
      var_0[var_2] = var_3;
    }
  }

  return var_0;
}

_id_55AF(var_0, var_1) {
  return _func_119(var_0, var_1) > 0;
}

_id_7153(var_0, var_1) {
  if(!_func_344(var_0)) {
    return;
  }
  var_2 = spawn("script_origin", (0, 0, 0));
  var_2 endon("death");
  thread _id_2D18(var_2);

  if(isDefined(var_1)) {
    var_2.origin = self.origin + var_1;
    var_2.angles = self.angles;
    var_2 linktosynchronizedparent(self);
  } else {
    var_2.origin = self.origin;
    var_2.angles = self.angles;
    var_2 linktosynchronizedparent(self);
  }

  var_2 _meth_861D(var_0);
  self waittill("stop sound" + var_0);
  var_2 _meth_8612(var_0);
  var_2 delete();
}

_id_93D5(var_0) {
  self notify("stop sound" + var_0);
}

_id_2D18(var_0) {
  var_0 endon("death");
  _id_A70A("death", "disconnect");

  if(isDefined(var_0))
    var_0 delete();
}

_id_3809(var_0) {}

_id_2793(var_0, var_1) {
  setdvarifuninitialized(var_0, var_1);
}

_id_A60A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {}

_id_95AC(var_0, var_1) {
  var_2 = self gettagorigin(var_0);
  var_3 = self _meth_8181(var_0);
  var_4 = anglesToForward(var_3);
  var_4 = vectorNormalize(var_4) * var_1;
  return var_2 + var_4;
}

_id_98E7(var_0, var_1, var_2) {
  if(var_0)
    return var_1;

  return var_2;
}

_id_27A6(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(level._id_5E61))
    level._id_5E61 = [];

  var_2 = spawnStruct();
  var_2._id_6048 = var_1;
  var_2._id_005C = 0;
  level._id_5E61[var_0] = var_2;
}

_id_5E62(var_0) {
  if(!isDefined(level._id_5E61))
    return 0;

  return isDefined(level._id_5E61[var_0]);
}

_id_5E61(var_0) {
  var_1 = level._id_5E61[var_0];

  while(var_1._id_005C >= var_1._id_6048)
    var_1 waittill("unlocked");

  var_1._id_005C++;
}

_id_55B2(var_0) {
  var_1 = level._id_5E61[var_0];
  return var_1._id_005C > var_1._id_6048;
}

_id_A03A(var_0) {
  thread _id_A039(var_0);
  waitframe();
}

_id_A038(var_0) {
  thread _id_A039(var_0);
}

_id_A039(var_0) {
  waitframe();
  var_1 = level._id_5E61[var_0];
  var_1._id_005C--;
  var_1 notify("unlocked");
}

get_template_level() {
  var_0 = level._id_015D;

  if(isDefined(level._id_98DC))
    var_0 = level._id_98DC;

  return var_0;
}

_id_0FA2(var_0) {
  var_1 = [];
  var_2 = var_0.size > 0 && _func_031(getfirstarraykey(var_0));

  if(var_2) {
    var_3 = getarraykeys(var_0);

    for(var_4 = var_3.size - 1; var_4 >= 0; var_4--) {
      var_5 = var_3[var_4];
      var_1[var_5] = var_0[var_5];
    }
  } else {
    for(var_4 = var_0.size - 1; var_4 >= 0; var_4--)
      var_1[var_1.size] = var_0[var_4];
  }

  return var_1;
}

_id_302B(var_0, var_1) {
  return _func_0E6(var_0 - var_1);
}

_id_40B1(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_40B0(var_0, var_1, var_2, var_3, var_4, var_5);
  var_6 = _id_0FA2(var_6);
  return var_6;
}

_id_40B0(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_3))
    var_3 = var_1.size;

  if(!isDefined(var_2))
    var_2 = [];

  var_6 = undefined;

  if(isDefined(var_4))
    var_6 = var_4 * var_4;

  var_7 = 0;

  if(isDefined(var_5))
    var_7 = var_5 * var_5;

  if(var_2.size == 0 && var_3 >= var_1.size && var_7 == 0 && !isDefined(var_6))
    return _func_1AC(var_1, var_0);

  var_8 = [];

  foreach(var_10 in var_1) {
    var_11 = 0;

    foreach(var_13 in var_2) {
      if(var_10 == var_13) {
        var_11 = 1;
        break;
      }
    }

    if(var_11) {
      continue;
    }
    var_15 = distancesquared(var_0, var_10.origin);

    if(isDefined(var_6) && var_15 > var_6) {
      continue;
    }
    if(var_15 < var_7) {
      continue;
    }
    var_8[var_8.size] = var_10;
  }

  var_8 = _func_1AC(var_8, var_0);

  if(var_3 >= var_8.size)
    return var_8;

  var_17 = [];

  for(var_18 = 0; var_18 < var_3; var_18++)
    var_17[var_18] = var_8[var_18];

  return var_17;
}

_id_55E0() {
  if(!level._id_258F) {
    var_0 = self _meth_834E();

    if(isDefined(var_0))
      return var_0;
    else
      return 0;
  }

  return 1;
}

_id_348B(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = 1500;

  if(!isDefined(var_2))
    var_2 = -12000;

  return _func_080(var_0 + (0, 0, var_1), var_0 + (0, 0, var_2));
}

_id_091E(var_0, var_1) {
  if(!isDefined(level._id_2DFA))
    level._id_2DFA = [];

  level._id_2DFA[var_0] = var_1;
}

_id_091F(var_0, var_1) {
  if(!isDefined(level._id_2E1E))
    level._id_2E1E = [];

  level._id_2E1E[var_0] = var_1;
}

within_fov(var_0, var_1, var_2, var_3) {
  var_4 = vectorNormalize(var_2 - var_0);
  var_5 = anglesToForward(var_1);
  var_6 = vectordot(var_5, var_4);
  return var_6 >= var_3;
}

_id_7237(var_0, var_1, var_2) {
  if(isDefined(self.clientid))
    var_3 = self.clientid;
  else
    var_3 = 0;

  var_4 = gettime();

  if(!isDefined(var_1))
    var_1 = 0;

  var_5 = 0.766;

  if(isDefined(var_2))
    var_5 = _func_0A7(var_2);

  if(!isDefined(var_0._id_7453)) {
    var_0._id_7453 = [];
    var_0._id_7452 = [];
  }

  if(isDefined(var_0._id_7453[var_3]) && var_0._id_7453[var_3] + var_1 >= var_4)
    return var_0._id_7452[var_3];

  var_0._id_7453[var_3] = var_4;

  if(!within_fov(self.origin, self _meth_8566(), var_0.origin, var_5)) {
    var_0._id_7452[var_3] = 0;
    return 0;
  }

  var_6 = self getEye();
  var_7 = var_0.origin;

  if(_func_07F(var_6, var_7, 1, self, var_0)) {
    var_0._id_7452[var_3] = 1;
    return 1;
  }

  var_8 = var_0 getEye();

  if(_func_07F(var_6, var_8, 1, self, var_0)) {
    var_0._id_7452[var_3] = 1;
    return 1;
  }

  var_9 = (var_8 + var_7) * 0.5;

  if(_func_07F(var_6, var_9, 1, self, var_0)) {
    var_0._id_7452[var_3] = 1;
    return 1;
  }

  var_0._id_7452[var_3] = 0;
  return 0;
}

_id_37CE(var_0) {
  self notify("entity_path_disconnect_thread");
  self endon("entity_path_disconnect_thread");
  self endon("death");
  level endon("game_ended");
  var_1 = 0;
  self._id_3E18 = 0;

  for(;;) {
    var_2 = self.origin;
    var_3 = _id_A71A(var_0, "path_disconnect");
    var_4 = 0;
    var_5 = distancesquared(self.origin, var_2) > 0;

    if(var_5)
      var_4 = 1;

    if(isDefined(var_3) && var_3 == "path_disconnect")
      var_4 = 1;

    if(gettime() < self._id_3E18)
      var_4 = 1;

    foreach(var_7 in _func_2D1()) {
      if(_func_0C1(var_7) && distancesquared(self.origin, var_7.origin) < 250000) {
        var_4 = 1;
        self._id_3E18 = max(gettime() + 30000, self._id_3E18);
      }
    }

    if(var_4 != var_1 || var_5) {
      if(var_4)
        self _meth_805F();
      else
        self _meth_8060();

      var_1 = var_4;
    }
  }
}

_id_5FA9(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level._id_19D5) && isDefined(level._id_19D5["bots_make_entity_sentient"]))
    return self[[level._id_19D5["bots_make_entity_sentient"]]](var_0, var_1, var_2, var_3, var_4);
}

free_entity_sentient_mp() {
  if(isDefined(level._id_19D5) && isDefined(level._id_19D5["bots_free_entity_sentient"]))
    return self[[level._id_19D5["bots_free_entity_sentient"]]]();
}

_id_64F3() {
  if(isDefined(level._id_19D5) && isDefined(level._id_19D5["bot_bots_enabled_or_added"]))
    return self[[level._id_19D5["bot_bots_enabled_or_added"]]]();

  return 0;
}

_id_0A63(var_0) {
  if(isDefined(level._id_19D5) && isDefined(level._id_19D5["ai_3d_sighting_model"]))
    return self[[level._id_19D5["ai_3d_sighting_model"]]](var_0);
}

_id_841D(var_0, var_1, var_2) {
  if(!isDefined(level._id_0E2F))
    level._id_0E2F = [];

  var_3 = _func_117(getDvar("1673"));
  var_4 = 1;

  if(_id_9467(var_3, "mp_"))
    var_4 = 0;

  if(var_4)
    level._id_0E2F[var_0]["basic"] = var_1;
  else
    level._id_0E2F[var_0]["basic"] = var_2;
}

_id_4461(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 500000;

  var_3 = undefined;

  foreach(var_5 in var_1) {
    if(!isDefined(var_5)) {
      continue;
    }
    var_6 = distance(var_5.origin, var_0);

    if(var_6 >= var_2) {
      continue;
    }
    var_2 = var_6;
    var_3 = var_5;
  }

  return var_3;
}

_id_4467(var_0, var_1) {
  var_2 = 0;
  var_3 = distance(var_0, var_1[0]);

  for(var_4 = 1; var_4 < var_1.size; var_4++) {
    var_5 = distance(var_0, var_1[var_4]);

    if(var_5 < var_3) {
      var_2 = var_4;
      var_3 = var_5;
    }
  }

  return var_1[var_2];
}

_id_44D6(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 500000;

  var_3 = 0;
  var_4 = undefined;

  foreach(var_6 in var_1) {
    var_7 = distance(var_6.origin, var_0);

    if(var_7 <= var_3 || var_7 >= var_2) {
      continue;
    }
    var_3 = var_7;
    var_4 = var_6;
  }

  return var_4;
}

_id_6240(var_0, var_1, var_2) {
  var_2 = _id_98E7(isDefined(var_2), var_2, (0, 0, 0));
  self _meth_81D9(var_0, var_2);

  switch (var_1) {
    case "direct":
      self _meth_81DC();
      break;
    case "top":
      self _meth_81DD();
      break;
  }
}

_id_38CA(var_0) {
  return _func_0D8(var_0 + 0.000061) / _func_0D8(2.0) + 2.84;
}

_id_5D94(var_0) {
  if(var_0 <= 0.0031308)
    return var_0 * 12.92;
  else
    return _func_1E2(var_0, 0.416667) * 1.055 - 0.055;
}

_id_2617(var_0) {}

_id_2616(var_0) {
  if(isDefined(level._id_38D0)) {
    switch (level._id_38D0) {
      case "alfog":
        break;
      case "normal_fog":
        break;
      default:
    }
  }
}

_id_84A0(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  _id_2617(var_0);
  _id_2616(var_0);

  if(isDefined(var_0._id_1103)) {
    if(level._id_010B) {
      if(var_0._id_1103) {
        if(isPlayer(self))
          self _meth_821D(var_0._id_1103, var_1, var_0._id_1128, var_0._id_1108, var_0._id_110A, var_0._id_1109, var_0._id_1105, var_0._id_1106, var_0._id_1110, var_0._id_1107, var_0._id_1126, var_0._id_1102, int(var_0._id_1112), var_0._id_1111, var_0._id_1114, var_0._id_1113, var_0._id_1127, var_0._id_110C, var_0._id_110B, var_0._id_110D, var_0._id_110E, var_0._id_110F, var_0._id_1104, var_0._id_10FF, var_0._id_1100, var_0._id_1101, var_0._id_111F, var_0._id_1120, var_0._id_1115, var_0._id_1116, var_0._id_1117, var_0._id_111C, var_0._id_111D, var_0._id_111E, var_0._id_1122, var_0._id_1125, var_0._id_1123, var_0._id_111B, var_0._id_1124, var_0._id_1118, var_0._id_1119, var_0._id_111A, var_0._id_1121);
        else
          _func_179(var_0._id_1103, var_1, var_0._id_1128, var_0._id_1108, var_0._id_110A, var_0._id_1109, var_0._id_1105, var_0._id_1106, var_0._id_1110, var_0._id_1107, var_0._id_1126, var_0._id_1102, int(var_0._id_1112), var_0._id_1111, var_0._id_1114, var_0._id_1113, var_0._id_1127, var_0._id_110C, var_0._id_110B, var_0._id_110D, var_0._id_110E, var_0._id_110F, var_0._id_1104, var_0._id_10FF, var_0._id_1100, var_0._id_1101, var_0._id_111F, var_0._id_1120, var_0._id_1115, var_0._id_1116, var_0._id_1117, var_0._id_111C, var_0._id_111D, var_0._id_111E, var_0._id_1122, var_0._id_1125, var_0._id_1123, var_0._id_111B, var_0._id_1124, var_0._id_1118, var_0._id_1119, var_0._id_111A, var_0._id_1121);
      } else if(isPlayer(self))
        self _meth_821D(var_0._id_1103, var_1);
      else
        _func_179(var_0._id_1103, var_1);
    }
  }
}

_id_092C(var_0, var_1) {
  if(!isDefined(level._effect))
    level._effect = [];

  level._effect[var_0] = loadfx(var_1);
}

_id_0FA4(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size - 1; var_2++) {
    for(var_3 = var_2 + 1; var_3 < var_0.size; var_3++) {
      if(var_0[var_3][[var_1]]() < var_0[var_2][[var_1]]()) {
        var_4 = var_0[var_3];
        var_0[var_3] = var_0[var_2];
        var_0[var_2] = var_4;
      }
    }
  }

  return var_0;
}

_id_0FA5(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = -1;

  for(var_3 = 1; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    for(var_5 = var_3 - 1; var_5 >= 0 && ![[var_1]](var_0[var_5], var_4); var_5--)
      var_0[var_5 + 1] = var_0[var_5];

    var_0[var_5 + 1] = var_4;

    if(var_2 > 0 && var_3 % var_2 == 0)
      waitframe();
  }

  return var_0;
}

_id_4CEB() {
  if(!isDefined(self._id_6A55))
    self._id_6A55 = self _meth_80B1();

  self _meth_805C();
}

_id_8BE0() {
  if(!_func_0C1(self))
    self _meth_82C1();

  if(isDefined(self._id_6A55))
    self _meth_80B0(self._id_6A55);

  self _meth_805B();
}

_id_A2BE() {
  return (0, 0, 0);
}

_id_A2BA(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1) || !_func_296(var_1) || !_func_296(var_1))
    return 0;

  return var_0[0] == var_1[0] && var_0[1] == var_1[1] && var_0[2] == var_1[2];
}

_id_A2B9(var_0) {
  var_1 = _id_A2BE();

  if(!isDefined(var_0) || !_func_0C0(var_0))
    return var_1;

  if(var_0.size == 0)
    return var_1;

  foreach(var_3 in var_0)
  var_1 = var_1 + var_3;

  var_1 = var_1 / var_0.size;
  return var_1;
}

_id_6880(var_0) {
  if(!var_0.size)
    return 0;

  var_1 = 0;

  foreach(var_3 in var_0)
  var_1 = var_1 + var_3;

  var_5 = var_1 / var_0.size;
  return var_5;
}

_id_86BE(var_0) {
  var_1 = getEntArray();
  _func_032("lighting_state", var_0);

  if(!getdvarint("233")) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3._id_5D56) && isDefined(var_3.classname) && (var_3.classname == "script_brushmodel" || var_3.classname == "script_model")) {
        if(var_3._id_5D56 == 0) {
          continue;
        }
        if(var_3._id_5D56 == var_0) {
          var_3 _id_8BE0();
          continue;
        }

        var_3 _id_4CEB();
      }
    }
  }
}

_id_46AE() {
  if(_id_562E(level._id_585D))
    return "zombiePlayerStats";

  return "rankedPlayerStats";
}

_id_46A8() {
  return "zombiePlayerStats";
}

_id_46A7() {
  return "commonData";
}

_id_46AF() {
  return "rankedloadouts";
}

_id_46AC() {
  return "privateloadouts";
}

_id_46AD() {
  return "raidData";
}

_id_46AA() {
  return "hubData";
}

_id_46A9() {
  return "costumesData";
}

_id_46AB() {
  return "leaderboardData";
}

_id_ACEE() {
  return "competitiveloadouts";
}

_id_339E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_3))
    var_3 = 180;

  if(!isDefined(var_2))
    var_2 = 100;

  if(!isDefined(var_1) && isDefined(self.angles))
    var_1 = self.angles;

  if(!isDefined(var_0) && isDefined(self.origin))
    var_0 = self.origin;

  var_8 = 16;
  var_9 = 360 / var_8;
  var_10 = var_3;
  var_11 = var_10 - var_3 * 2.0;
  var_12 = var_10;
  var_13 = [];
  var_13[var_13.size] = var_0;
  var_13[var_13.size] = var_0 + anglesToForward(_func_110(var_1, (0, var_12, 0))) * var_2;

  for(var_13[var_13.size] = var_0; var_12 > var_11; var_13[var_13.size - 2] = var_0 + anglesToForward(_func_110(var_1, (0, var_12, 0))) * var_2) {
    var_12 = max(var_11, var_12 - var_9);
    var_13[var_13.size] = var_13[var_13.size - 1];
  }

  thread _id_33A6(var_13, var_4, var_5, var_6, var_7);
}

_id_33A4(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 16;
  var_7 = 360 / var_6;
  var_8 = [];

  for(var_9 = 0; var_9 < var_6; var_9++) {
    var_10 = var_7 * var_9;
    var_11 = _func_0A7(var_10) * var_1;
    var_12 = _func_0A6(var_10) * var_1;
    var_13 = var_0[0] + var_11;
    var_14 = var_0[1] + var_12;
    var_15 = var_0[2];
    var_8[var_8.size] = (var_13, var_14, var_15);
  }

  thread _id_33A6(var_8, var_2, var_3, var_4, var_5);
}

_id_33A6(var_0, var_1, var_2, var_3, var_4) {
  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = var_0[var_5];

    if(var_5 + 1 >= var_0.size)
      var_7 = var_0[0];
    else
      var_7 = var_0[var_5 + 1];

    thread _id_33BA(var_6, var_7, var_1, var_2, var_3, var_4);
  }
}

_id_33A5(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 16;
  var_6 = 360 / var_5;
  var_7 = [];

  for(var_8 = 0; var_8 < var_5; var_8++) {
    var_9 = anglesToForward(var_2);
    var_10 = _func_0E9(var_9, (0, 0, 1));
    var_11 = _func_0E9(var_10, var_9);
    var_12 = var_6 * var_8;
    var_13 = _func_0A7(var_12) * var_1;
    var_14 = _func_0A6(var_12) * var_1;
    var_7[var_7.size] = var_0 + var_10 * var_13 + var_11 * var_14;
  }

  thread _id_33A6(var_7, var_3[0], var_3[1], var_3[2], var_4);
}

_id_33B0(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_4))
    var_4 = (1, 1, 1);

  if(!isDefined(var_5))
    var_5 = 0;

  var_6 = 1;
  var_7 = 0;
  var_1 = vectorNormalize(var_1);

  if(var_1 == (0, 0, 1))
    var_8 = (1, 0, 0);

  var_8 = vectorNormalize(_func_0E9(var_1, (0, 0, 1)));
  var_9 = _func_0E9(var_1, var_8);
  var_10 = var_1 * var_3 * _func_0A7(var_2);
  var_11 = var_3 * _func_0A6(var_2);
  var_12 = (0, 0, 0);
  var_13 = int(20 * var_5);
  var_14 = 16;

  for(var_15 = 0; var_15 <= var_14; var_15++) {
    var_16 = var_15 / var_14 * 360;
    var_17 = var_0 + var_10 + var_11 * (var_8 * _func_0A7(var_16) + var_9 * _func_0A6(var_16));

    if(var_15 > 0) {}

    var_12 = var_17;
  }
}

_id_5D92(var_0, var_1, var_2, var_3, var_4) {
  return var_3 + (var_0 - var_1) * (var_4 - var_3) / (var_2 - var_1);
}

_id_5D93(var_0, var_1, var_2, var_3, var_4) {
  return clamp(_id_5D92(var_0, var_1, var_2, var_3, var_4), _func_0AF(var_3, var_4), max(var_3, var_4));
}

_id_7716(var_0, var_1, var_2, var_3, var_4) {
  level endon(var_0);
  self endon("death");

  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  if(!isDefined(var_2))
    var_2 = "*";

  if(!isDefined(var_3))
    var_3 = (1, 1, 0);

  if(!isDefined(var_4))
    var_4 = 3;

  for(;;) {
    if(_func_279(self)) {
      return;
    }
    waitframe();
  }
}

stringtofloat(var_0) {
  var_1 = strtok(var_0, ".");
  var_2 = int(var_1[0]);

  if(isDefined(var_1[1])) {
    var_3 = 1;

    for(var_4 = 0; var_4 < var_1[1].size; var_4++)
      var_3 = var_3 * 0.1;

    var_2 = var_2 + int(var_1[1]) * var_3;
  }

  return var_2;
}

_id_7F03(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = "nearest";

  var_3 = 1;

  for(var_4 = 0; var_4 < var_1; var_4++)
    var_3 = var_3 * 10;

  var_5 = var_0 * var_3;

  if(var_2 == "up")
    var_6 = _func_0D5(var_5);
  else if(var_2 == "down")
    var_6 = _func_0D4(var_5);
  else
    var_6 = var_5 + 0.5;

  var_5 = int(var_6);
  var_5 = var_5 / var_3;
  return var_5;
}

_id_40B5() {
  var_0 = spawnStruct();
  var_1 = getDvar("r_mode", "1280x720 [16:9]");
  var_2 = strtok(var_1, " ");
  var_3 = strtok(var_2[0], "x");
  var_0._id_01D2 = stringtofloat(var_3[0]);
  var_0._id_00BD = stringtofloat(var_3[1]);
  var_0._id_1083 = _id_7F03(var_0._id_01D2 / var_0._id_00BD, 3);
  return var_0;
}

_id_6FA9(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getdvarint("turret_plant_debug") == 2;
  var_7 = [];
  var_8 = [];
  var_9 = 20;
  var_10 = undefined;

  if(var_3 > 0)
    var_10 = int(var_3 / var_9) + 2;
  else {
    var_9 = -1 * var_9;
    var_10 = int(var_3 / var_9) + 2;
  }

  var_11 = _func_233(var_1);
  var_12 = 0;

  for(var_13 = 0; var_13 < var_10; var_13++) {
    if(var_13 == var_10 - 1)
      var_12 = var_3;
    else
      var_12 = var_13 * var_9;

    if(var_13 == var_10 - 1)
      var_12 = var_3;
    else
      var_12 = var_13 * var_9;

    var_14 = _func_110(var_1, (0, var_12, 0));
    var_15 = anglesToForward(var_14) * var_2;
    var_8[var_13] = var_15 + var_0;
  }

  var_7["is_hit"] = 0;
  var_7["arc_end"] = var_8[var_13];

  for(var_13 = 0; var_13 < var_8.size - 1; var_13++) {
    var_16 = var_8[var_13];
    var_17 = var_8[var_13 + 1];

    if(!isDefined(var_5))
      var_18 = _func_080(var_16, var_17, var_4);
    else {
      var_19 = _func_335(var_16, var_17, var_5, undefined, var_4);

      if(var_19["is_matching_hit_found"])
        var_18 = var_19["position"];
      else
        var_18 = var_17;
    }

    var_20 = undefined;

    if(!_id_5646(var_18, var_17)) {
      var_21 = _func_112(var_18 - var_0, var_11);
      var_20 = _func_0A9(var_21[1] / var_2);

      if(var_7["is_hit"] == 0) {
        var_7["hit_angle"] = var_20;
        var_7["hit_point"] = var_18;
        var_7["is_hit"] = 1;
      } else if(!var_6) {
        break;
      }
    }
  }

  return var_7;
}

_id_5646(var_0, var_1) {
  var_2 = 0.001;
  return _func_0AE(var_0[0] - var_1[0]) < var_2 && _func_0AE(var_0[1] - var_1[1]) < var_2 && _func_0AE(var_0[2] - var_1[2]) < var_2;
}

_id_A087(var_0) {
  var_1 = "0123456789ABCDEF";

  if(var_0 == 0)
    return var_1[0];

  for(var_2 = ""; var_0 > 0; var_0 = _func_0D4(var_0 / 16))
    var_2 = var_1[int(var_0 % 16)] + var_2;

  var_2 = "0x" + var_2;
  return var_2;
}

_id_7897(var_0, var_1) {
  var_2 = _id_789B(var_0, 0, var_0.size - 1, var_1);
  var_3 = [];

  for(var_4 = 0; var_4 < var_2.size; var_4++)
    var_3[var_4] = var_2[var_4];

  return var_3;
}

_id_789B(var_0, var_1, var_2, var_3) {
  var_4 = var_1;
  var_5 = var_2;

  if(!isDefined(var_3))
    var_3 = ::_id_7898;

  if(var_2 - var_1 >= 1) {
    var_6 = var_0[var_1];

    while(var_5 > var_4) {
      while([[var_3]](var_0[var_4], var_6) && var_4 <= var_2 && var_5 > var_4)
        var_4++;

      while(![[var_3]](var_0[var_5], var_6) && var_5 > var_1 && var_5 >= var_4)
        var_5--;

      if(var_5 > var_4)
        var_0 = _id_9530(var_0, var_4, var_5);
    }

    var_0 = _id_9530(var_0, var_1, var_5);
    var_0 = _id_789B(var_0, var_1, var_5 - 1, var_3);
    var_0 = _id_789B(var_0, var_5 + 1, var_2, var_3);
  } else
    return var_0;

  return var_0;
}

_id_7898(var_0, var_1) {
  return var_0 <= var_1;
}

_id_7899(var_0, var_1) {
  return var_0 > var_1;
}

_id_9530(var_0, var_1, var_2) {
  var_3 = var_0[var_1];
  var_0[var_1] = var_0[var_2];
  var_0[var_2] = var_3;
  return var_0;
}

_id_73F5(var_0) {
  foreach(var_2 in var_0.pers["killstreaks"]) {
    if(var_2._id_13AF == 1)
      return 1;
  }

  return 0;
}