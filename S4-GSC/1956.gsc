/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1956.gsc
*************************************************/

_id_A5D9(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level._id_6016)) {
    return;
  }
  if(!isDefined(level._id_6016[var_0])) {
    return;
  }
  if(!isDefined(var_1)) {
    call[[level._id_6016[var_0]]]();
    return;
  }

  if(!isDefined(var_2)) {
    call[[level._id_6016[var_0]]](var_1);
    return;
  }

  if(!isDefined(var_3)) {
    call[[level._id_6016[var_0]]](var_1, var_2);
    return;
  }

  if(!isDefined(var_4)) {
    call[[level._id_6016[var_0]]](var_1, var_2, var_3);
    return;
  }

  if(!isDefined(var_5)) {
    call[[level._id_6016[var_0]]](var_1, var_2, var_3, var_4);
    return;
  }

  call[[level._id_6016[var_0]]](var_1, var_2, var_3, var_4, var_5);
}

_id_A5DA(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level._id_6016)) {
    return undefined;
  }

  if(!isDefined(level._id_6016[var_0])) {
    return undefined;
  }

  if(!isDefined(var_1)) {
    return call[[level._id_6016[var_0]]]();
  }

  if(!isDefined(var_2)) {
    return call[[level._id_6016[var_0]]](var_1);
  }

  if(!isDefined(var_3)) {
    return call[[level._id_6016[var_0]]](var_1, var_2);
  }

  if(!isDefined(var_4)) {
    return call[[level._id_6016[var_0]]](var_1, var_2, var_3);
  }

  if(!isDefined(var_5)) {
    return call[[level._id_6016[var_0]]](var_1, var_2, var_3, var_4);
  }

  return call[[level._id_6016[var_0]]](var_1, var_2, var_3, var_4, var_5);
}

_id_D07A(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level._id_6016[var_0])) {
    return;
  }
  if(!isDefined(var_1)) {
    self call[[level._id_6016[var_0]]]();
    return;
  }

  if(!isDefined(var_2)) {
    self call[[level._id_6016[var_0]]](var_1);
    return;
  }

  if(!isDefined(var_3)) {
    self call[[level._id_6016[var_0]]](var_1, var_2);
    return;
  }

  if(!isDefined(var_4)) {
    self call[[level._id_6016[var_0]]](var_1, var_2, var_3);
    return;
  }

  if(!isDefined(var_5)) {
    self call[[level._id_6016[var_0]]](var_1, var_2, var_3, var_4);
    return;
  }

  self call[[level._id_6016[var_0]]](var_1, var_2, var_3, var_4, var_5);
}

_id_CD61(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level._id_6016[var_0])) {
    return;
  }
  if(!isDefined(var_1)) {
    return self[[level._id_6016[var_0]]]();
  } else if(!isDefined(var_2)) {
    return self[[level._id_6016[var_0]]](var_1);
  } else if(!isDefined(var_3)) {
    return self[[level._id_6016[var_0]]](var_1, var_2);
  } else if(!isDefined(var_4)) {
    return self[[level._id_6016[var_0]]](var_1, var_2, var_3);
  } else if(!isDefined(var_5)) {
    return self[[level._id_6016[var_0]]](var_1, var_2, var_3, var_4);
  }

  return self[[level._id_6016[var_0]]](var_1, var_2, var_3, var_4, var_5);
}

_id_C019(var_0) {
  return (randomfloat(var_0) - var_0 * 0.5, randomfloat(var_0) - var_0 * 0.5, randomfloat(var_0) - var_0 * 0.5);
}

_id_C01A(var_0, var_1) {
  var_2 = randomfloatrange(var_0, var_1);

  if(randomint(2) == 0) {
    var_2 = var_2 * -1;
  }

  var_3 = randomfloatrange(var_0, var_1);

  if(randomint(2) == 0) {
    var_3 = var_3 * -1;
  }

  var_4 = randomfloatrange(var_0, var_1);

  if(randomint(2) == 0) {
    var_4 = var_4 * -1;
  }

  return (var_2, var_3, var_4);
}

_id_DD3F(var_0) {
  if(var_0 >= 0) {
    return 1;
  }

  return -1;
}

_id_C013() {
  var_0 = randomfloat(180);
  var_1 = randomfloat(360);
  var_2 = cos(var_1) * cos(var_0);
  var_3 = cos(var_1) * sin(var_0);
  var_4 = sin(var_1);
  return (var_2, var_3, var_4);
}

_id_9FC4(var_0, var_1) {
  var_2 = int(var_0 / var_1);

  if(var_0 * var_1 < 0) {
    var_2 = var_2 - 1;
  }

  return var_0 - var_2 * var_1;
}

_id_647F(var_0) {
  var_1 = [];
  var_1["axis"] = "allies";
  var_1["allies"] = "axis";
  return var_1[var_0];
}

_id_38D0(var_0) {
  self._id_56D2[var_0] = anim._id_45B1;
}

cointoss() {
  return randomint(100) >= 50;
}

_id_3590(var_0, var_1) {
  var_2 = randomint(var_1[var_1.size - 1] + 1);

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(var_2 <= var_1[var_3]) {
      return var_0[var_3];
    }
  }
}

_id_10927(var_0, var_1) {
  if(var_0 != "death") {
    self endon("death");
  }

  var_1 endon("die");
  self waittill(var_0);
  var_1 notify("returned", var_0, self);
}

_id_1095E(var_0, var_1, var_2) {
  if(var_1 != "death") {
    self endon("death");
  }

  var_2 endon("die");
  self waittillmatch(var_0, var_1);
  var_2 notify("returned", var_1, self);
}

_id_10928(var_0, var_1) {
  var_1 endon("die");
  self waittill(var_0);
  var_1 notify("returned", var_0, self);
}

_id_108EA(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5 = spawnStruct();
  var_5._id_F13E = 0;

  if(isDefined(var_0)) {
    childthread _id_10927(var_0, var_5);
    var_5._id_F13E++;
  }

  if(isDefined(var_1)) {
    childthread _id_10927(var_1, var_5);
    var_5._id_F13E++;
  }

  if(isDefined(var_2)) {
    childthread _id_10927(var_2, var_5);
    var_5._id_F13E++;
  }

  if(isDefined(var_3)) {
    childthread _id_10927(var_3, var_5);
    var_5._id_F13E++;
  }

  if(isDefined(var_4)) {
    childthread _id_10927(var_4, var_5);
    var_5._id_F13E++;
  }

  while(var_5._id_F13E) {
    var_5 waittill("returned");
    var_5._id_F13E--;
  }

  var_5 notify("die");
}

_id_10875(var_0, var_1) {
  self endon("death");
  var_2 = spawnStruct();
  var_2._id_F13E = 0;

  if(isDefined(var_0)) {
    childthread _id_10927(var_0, var_2);
    var_2._id_F13E++;
  }

  if(isDefined(var_1)) {
    childthread _id_10927(var_1, var_2);
    var_2._id_F13E++;
  }

  while(var_2._id_F13E) {
    var_2 waittill("returned");
    var_2._id_F13E--;
  }

  var_2 notify("die");
}

_id_1095D(var_0, var_1, var_2) {
  self endon("death");
  self waittillmatch(var_0, var_1);
  self notify(var_2);
}

_id_10896(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0) || var_0 != "death") {
    self endon("death");
  }

  var_4 = spawnStruct();

  if(isDefined(var_0)) {
    childthread _id_10927(var_0, var_4);
  }

  var_4 waittill("returned", var_5);
  var_4 notify("die");
  return var_5;
}

_id_10897(var_0, var_1, var_2) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death")) {
    self endon("death");
  }

  var_3 = spawnStruct();

  if(isDefined(var_0)) {
    childthread _id_10927(var_0, var_3);
  }

  if(isDefined(var_1)) {
    childthread _id_10927(var_1, var_3);
  }

  var_3 waittill("returned", var_4);
  var_3 notify("die");
  return var_4;
}

_id_10898(var_0, var_1, var_2, var_3) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death")) {
    self endon("death");
  }

  var_4 = spawnStruct();

  if(isDefined(var_0)) {
    childthread _id_10927(var_0, var_4);
  }

  if(isDefined(var_1)) {
    childthread _id_10927(var_1, var_4);
  }

  if(isDefined(var_2)) {
    childthread _id_10927(var_2, var_4);
  }

  var_4 waittill("returned", var_5);
  var_4 notify("die");
  return var_5;
}

_id_10899(var_0, var_1, var_2, var_3, var_4) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death")) {
    self endon("death");
  }

  var_5 = spawnStruct();

  if(isDefined(var_0)) {
    childthread _id_10927(var_0, var_5);
  }

  if(isDefined(var_1)) {
    childthread _id_10927(var_1, var_5);
  }

  if(isDefined(var_2)) {
    childthread _id_10927(var_2, var_5);
  }

  if(isDefined(var_3)) {
    childthread _id_10927(var_3, var_5);
  }

  var_5 waittill("returned", var_6);
  var_5 notify("die");
  return var_6;
}

_id_1089A(var_0, var_1, var_2, var_3, var_4, var_5) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death")) {
    self endon("death");
  }

  var_6 = spawnStruct();

  if(isDefined(var_0)) {
    childthread _id_10927(var_0, var_6);
  }

  if(isDefined(var_1)) {
    childthread _id_10927(var_1, var_6);
  }

  if(isDefined(var_2)) {
    childthread _id_10927(var_2, var_6);
  }

  if(isDefined(var_3)) {
    childthread _id_10927(var_3, var_6);
  }

  if(isDefined(var_4)) {
    childthread _id_10927(var_4, var_6);
  }

  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

_id_1089B(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death")) {
    self endon("death");
  }

  var_7 = spawnStruct();

  if(isDefined(var_0)) {
    childthread _id_10927(var_0, var_7);
  }

  if(isDefined(var_1)) {
    childthread _id_10927(var_1, var_7);
  }

  if(isDefined(var_2)) {
    childthread _id_10927(var_2, var_7);
  }

  if(isDefined(var_3)) {
    childthread _id_10927(var_3, var_7);
  }

  if(isDefined(var_4)) {
    childthread _id_10927(var_4, var_7);
  }

  if(isDefined(var_5)) {
    childthread _id_10927(var_5, var_7);
  }

  var_7 waittill("returned", var_8);
  var_7 notify("die");
  return var_8;
}

_id_1089C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death") && (!isDefined(var_6) || var_6 != "death")) {
    self endon("death");
  }

  var_8 = spawnStruct();

  if(isDefined(var_0)) {
    childthread _id_10927(var_0, var_8);
  }

  if(isDefined(var_1)) {
    childthread _id_10927(var_1, var_8);
  }

  if(isDefined(var_2)) {
    childthread _id_10927(var_2, var_8);
  }

  if(isDefined(var_3)) {
    childthread _id_10927(var_3, var_8);
  }

  if(isDefined(var_4)) {
    childthread _id_10927(var_4, var_8);
  }

  if(isDefined(var_5)) {
    childthread _id_10927(var_5, var_8);
  }

  if(isDefined(var_6)) {
    childthread _id_10927(var_6, var_8);
  }

  var_8 waittill("returned", var_9);
  var_8 notify("die");
  return var_9;
}

waittill_any_return(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death") && (!isDefined(var_6) || var_6 != "death") && (!isDefined(var_7) || var_7 != "death")) {
    self endon("death");
  }

  var_8 = spawnStruct();

  if(isDefined(var_0)) {
    childthread _id_10927(var_0, var_8);
  }

  if(isDefined(var_1)) {
    childthread _id_10927(var_1, var_8);
  }

  if(isDefined(var_2)) {
    childthread _id_10927(var_2, var_8);
  }

  if(isDefined(var_3)) {
    childthread _id_10927(var_3, var_8);
  }

  if(isDefined(var_4)) {
    childthread _id_10927(var_4, var_8);
  }

  if(isDefined(var_5)) {
    childthread _id_10927(var_5, var_8);
  }

  if(isDefined(var_6)) {
    childthread _id_10927(var_6, var_8);
  }

  if(isDefined(var_7)) {
    childthread _id_10927(var_7, var_8);
  }

  var_8 waittill("returned", var_9);
  var_8 notify("die");
  return var_9;
}

_id_1095B(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if((!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death") && (!isDefined(var_6) || var_6 != "death")) {
    self endon("death");
  }

  var_7 = spawnStruct();

  if(isDefined(var_1)) {
    childthread _id_1095E(var_0, var_1, var_7);
  }

  if(isDefined(var_2)) {
    childthread _id_1095E(var_0, var_2, var_7);
  }

  if(isDefined(var_3)) {
    childthread _id_1095E(var_0, var_3, var_7);
  }

  if(isDefined(var_4)) {
    childthread _id_1095E(var_0, var_4, var_7);
  }

  if(isDefined(var_5)) {
    childthread _id_1095E(var_0, var_5, var_7);
  }

  if(isDefined(var_6)) {
    childthread _id_1095E(var_0, var_6, var_7);
  }

  var_7 waittill("returned", var_8);
  var_7 notify("die");
  return var_8;
}

_id_1089E(var_0, var_1) {
  var_2 = spawnStruct();

  if(isDefined(var_0)) {
    childthread _id_10928(var_0, var_2);
  }

  var_2 waittill("returned", var_3);
  var_2 notify("die");
  return var_3;
}

_id_1089F(var_0, var_1, var_2) {
  var_3 = spawnStruct();

  if(isDefined(var_0)) {
    childthread _id_10928(var_0, var_3);
  }

  if(isDefined(var_1)) {
    childthread _id_10928(var_1, var_3);
  }

  var_3 waittill("returned", var_4);
  var_3 notify("die");
  return var_4;
}

_id_108A0(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();

  if(isDefined(var_0)) {
    childthread _id_10928(var_0, var_4);
  }

  if(isDefined(var_1)) {
    childthread _id_10928(var_1, var_4);
  }

  if(isDefined(var_2)) {
    childthread _id_10928(var_2, var_4);
  }

  var_4 waittill("returned", var_5);
  var_4 notify("die");
  return var_5;
}

_id_108A1(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();

  if(isDefined(var_0)) {
    childthread _id_10928(var_0, var_5);
  }

  if(isDefined(var_1)) {
    childthread _id_10928(var_1, var_5);
  }

  if(isDefined(var_2)) {
    childthread _id_10928(var_2, var_5);
  }

  if(isDefined(var_3)) {
    childthread _id_10928(var_3, var_5);
  }

  var_5 waittill("returned", var_6);
  var_5 notify("die");
  return var_6;
}

_id_108A2(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();

  if(isDefined(var_0)) {
    childthread _id_10928(var_0, var_6);
  }

  if(isDefined(var_1)) {
    childthread _id_10928(var_1, var_6);
  }

  if(isDefined(var_2)) {
    childthread _id_10928(var_2, var_6);
  }

  if(isDefined(var_3)) {
    childthread _id_10928(var_3, var_6);
  }

  if(isDefined(var_4)) {
    childthread _id_10928(var_4, var_6);
  }

  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

_id_108A3(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();

  if(isDefined(var_0)) {
    childthread _id_10928(var_0, var_7);
  }

  if(isDefined(var_1)) {
    childthread _id_10928(var_1, var_7);
  }

  if(isDefined(var_2)) {
    childthread _id_10928(var_2, var_7);
  }

  if(isDefined(var_3)) {
    childthread _id_10928(var_3, var_7);
  }

  if(isDefined(var_4)) {
    childthread _id_10928(var_4, var_7);
  }

  if(isDefined(var_5)) {
    childthread _id_10928(var_5, var_7);
  }

  var_7 waittill("returned", var_8);
  var_7 notify("die");
  return var_8;
}

waittill_any_return_no_endon_death_7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = spawnStruct();

  if(isDefined(var_0)) {
    childthread _id_10928(var_0, var_8);
  }

  if(isDefined(var_1)) {
    childthread _id_10928(var_1, var_8);
  }

  if(isDefined(var_2)) {
    childthread _id_10928(var_2, var_8);
  }

  if(isDefined(var_3)) {
    childthread _id_10928(var_3, var_8);
  }

  if(isDefined(var_4)) {
    childthread _id_10928(var_4, var_8);
  }

  if(isDefined(var_5)) {
    childthread _id_10928(var_5, var_8);
  }

  if(isDefined(var_6)) {
    childthread _id_10928(var_6, var_8);
  }

  var_8 waittill("returned", var_9);
  var_8 notify("die");
  return var_9;
}

_id_1089D(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();

  if(isDefined(var_0)) {
    childthread _id_10928(var_0, var_6);
  }

  if(isDefined(var_1)) {
    childthread _id_10928(var_1, var_6);
  }

  if(isDefined(var_2)) {
    childthread _id_10928(var_2, var_6);
  }

  if(isDefined(var_3)) {
    childthread _id_10928(var_3, var_6);
  }

  if(isDefined(var_4)) {
    childthread _id_10928(var_4, var_6);
  }

  if(isDefined(var_5)) {
    childthread _id_10928(var_5, var_6);
  }

  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

_id_10892(var_0) {
  var_1 = spawnStruct();
  var_2 = 0;

  foreach(var_4 in var_0) {
    childthread _id_10927(var_4, var_1);

    if(var_4 == "death") {
      var_2 = 1;
    }
  }

  if(!var_2) {
    self endon("death");
  }

  var_1 waittill("returned", var_6);
  var_1 notify("die");
  return var_6;
}

_id_10893(var_0) {
  var_1 = spawnStruct();

  foreach(var_3 in var_0) {
    childthread _id_10928(var_3, var_1);
  }

  var_1 waittill("returned", var_5);
  var_1 notify("die");
  return var_5;
}

_id_10890(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = 0;

  foreach(var_5 in var_0) {
    childthread _id_10927(var_5, var_2);

    if(var_5 == "death") {
      var_3 = 1;
    }
  }

  if(!var_3) {
    self endon("death");
  }

  var_2 childthread _id_0D95(var_1);
  var_2 waittill("returned", var_7);
  var_2 notify("die");
  return var_7;
}

_id_10891(var_0, var_1) {
  var_2 = spawnStruct();

  foreach(var_4 in var_0) {
    childthread _id_10928(var_4, var_2);
  }

  var_2 thread _id_0D95(var_1);
  var_2 waittill("returned", var_6);
  var_2 notify("die");
  return var_6;
}

_id_10879(var_0) {
  while(var_0.size) {
    var_1 = _id_10892(var_0);
    var_0 = array_remove(var_0, var_1);
  }
}

_id_108EC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("death");
  var_9 = spawnStruct();
  var_9._id_F13E = 0;

  if(isDefined(var_1)) {
    var_1 childthread _id_10928(var_2, var_9);
    var_9._id_F13E++;
  }

  if(isDefined(var_3)) {
    var_3 childthread _id_10928(var_4, var_9);
    var_9._id_F13E++;
  }

  if(isDefined(var_5)) {
    var_5 childthread _id_10928(var_6, var_9);
    var_9._id_F13E++;
  }

  if(isDefined(var_7)) {
    var_7 childthread _id_10928(var_8, var_9);
    var_9._id_F13E++;
  }

  var_10 = "ents_notified";

  while(var_9._id_F13E) {
    if(isDefined(var_0)) {
      var_11 = var_9 _id_108F7("returned", var_0);

      if(isDefined(var_11) && var_11 == "timeout") {
        var_9._id_F13E = 0;
        var_10 = "timeout";
      } else
        var_9._id_F13E--;

      continue;
    }

    var_9 waittill("returned");
    var_9._id_F13E--;
  }

  var_9 notify("die");
  return var_10;
}

_id_108A7(var_0, var_1, var_2) {
  if(!isDefined(var_1) || var_1 != "death") {
    self endon("death");
  }

  var_3 = spawnStruct();

  if(isDefined(var_1)) {
    childthread _id_10927(var_1, var_3);
  }

  var_3 childthread _id_0D95(var_0);
  var_3 waittill("returned", var_4);
  var_3 notify("die");
  return var_4;
}

_id_108A8(var_0, var_1, var_2, var_3) {
  if((!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death")) {
    self endon("death");
  }

  var_4 = spawnStruct();

  if(isDefined(var_1)) {
    childthread _id_10927(var_1, var_4);
  }

  if(isDefined(var_2)) {
    childthread _id_10927(var_2, var_4);
  }

  var_4 childthread _id_0D95(var_0);
  var_4 waittill("returned", var_5);
  var_4 notify("die");
  return var_5;
}

_id_108A9(var_0, var_1, var_2, var_3, var_4) {
  if((!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death")) {
    self endon("death");
  }

  var_5 = spawnStruct();

  if(isDefined(var_1)) {
    childthread _id_10927(var_1, var_5);
  }

  if(isDefined(var_2)) {
    childthread _id_10927(var_2, var_5);
  }

  if(isDefined(var_3)) {
    childthread _id_10927(var_3, var_5);
  }

  var_5 childthread _id_0D95(var_0);
  var_5 waittill("returned", var_6);
  var_5 notify("die");
  return var_6;
}

_id_108AA(var_0, var_1, var_2, var_3, var_4, var_5) {
  if((!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death")) {
    self endon("death");
  }

  var_6 = spawnStruct();

  if(isDefined(var_1)) {
    childthread _id_10927(var_1, var_6);
  }

  if(isDefined(var_2)) {
    childthread _id_10927(var_2, var_6);
  }

  if(isDefined(var_3)) {
    childthread _id_10927(var_3, var_6);
  }

  if(isDefined(var_4)) {
    childthread _id_10927(var_4, var_6);
  }

  var_6 childthread _id_0D95(var_0);
  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

_id_108AB(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if((!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death")) {
    self endon("death");
  }

  var_7 = spawnStruct();

  if(isDefined(var_1)) {
    childthread _id_10927(var_1, var_7);
  }

  if(isDefined(var_2)) {
    childthread _id_10927(var_2, var_7);
  }

  if(isDefined(var_3)) {
    childthread _id_10927(var_3, var_7);
  }

  if(isDefined(var_4)) {
    childthread _id_10927(var_4, var_7);
  }

  if(isDefined(var_5)) {
    childthread _id_10927(var_5, var_7);
  }

  var_7 childthread _id_0D95(var_0);
  var_7 waittill("returned", var_8);
  var_7 notify("die");
  return var_8;
}

_id_108AC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if((!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death") && (!isDefined(var_6) || var_6 != "death")) {
    self endon("death");
  }

  var_8 = spawnStruct();

  if(isDefined(var_1)) {
    childthread _id_10927(var_1, var_8);
  }

  if(isDefined(var_2)) {
    childthread _id_10927(var_2, var_8);
  }

  if(isDefined(var_3)) {
    childthread _id_10927(var_3, var_8);
  }

  if(isDefined(var_4)) {
    childthread _id_10927(var_4, var_8);
  }

  if(isDefined(var_5)) {
    childthread _id_10927(var_5, var_8);
  }

  if(isDefined(var_6)) {
    childthread _id_10927(var_6, var_8);
  }

  var_8 childthread _id_0D95(var_0);
  var_8 waittill("returned", var_9);
  var_8 notify("die");
  return var_9;
}

_id_108A6(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if((!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death") && (!isDefined(var_6) || var_6 != "death")) {
    self endon("death");
  }

  var_7 = spawnStruct();

  if(isDefined(var_1)) {
    childthread _id_10927(var_1, var_7);
  }

  if(isDefined(var_2)) {
    childthread _id_10927(var_2, var_7);
  }

  if(isDefined(var_3)) {
    childthread _id_10927(var_3, var_7);
  }

  if(isDefined(var_4)) {
    childthread _id_10927(var_4, var_7);
  }

  if(isDefined(var_5)) {
    childthread _id_10927(var_5, var_7);
  }

  if(isDefined(var_6)) {
    childthread _id_10927(var_6, var_7);
  }

  var_7 childthread _id_0D95(var_0);
  var_7 waittill("returned", var_8);
  var_7 notify("die");
  return var_8;
}

_id_0D95(var_0) {
  self endon("die");
  wait(var_0);
  self notify("returned", "timeout");
}

_id_108AE(var_0, var_1, var_2) {
  var_3 = spawnStruct();

  if(isDefined(var_1)) {
    childthread _id_10928(var_1, var_3);
  }

  var_3 childthread _id_0D95(var_0);
  var_3 waittill("returned", var_4);
  var_3 notify("die");
  return var_4;
}

_id_108AF(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();

  if(isDefined(var_1)) {
    childthread _id_10928(var_1, var_4);
  }

  if(isDefined(var_2)) {
    childthread _id_10928(var_2, var_4);
  }

  var_4 childthread _id_0D95(var_0);
  var_4 waittill("returned", var_5);
  var_4 notify("die");
  return var_5;
}

_id_108B0(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();

  if(isDefined(var_1)) {
    childthread _id_10928(var_1, var_5);
  }

  if(isDefined(var_2)) {
    childthread _id_10928(var_2, var_5);
  }

  if(isDefined(var_3)) {
    childthread _id_10928(var_3, var_5);
  }

  var_5 childthread _id_0D95(var_0);
  var_5 waittill("returned", var_6);
  var_5 notify("die");
  return var_6;
}

_id_108B1(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();

  if(isDefined(var_1)) {
    childthread _id_10928(var_1, var_6);
  }

  if(isDefined(var_2)) {
    childthread _id_10928(var_2, var_6);
  }

  if(isDefined(var_3)) {
    childthread _id_10928(var_3, var_6);
  }

  if(isDefined(var_4)) {
    childthread _id_10928(var_4, var_6);
  }

  var_6 childthread _id_0D95(var_0);
  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

_id_108B2(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();

  if(isDefined(var_1)) {
    childthread _id_10928(var_1, var_7);
  }

  if(isDefined(var_2)) {
    childthread _id_10928(var_2, var_7);
  }

  if(isDefined(var_3)) {
    childthread _id_10928(var_3, var_7);
  }

  if(isDefined(var_4)) {
    childthread _id_10928(var_4, var_7);
  }

  if(isDefined(var_5)) {
    childthread _id_10928(var_5, var_7);
  }

  var_7 childthread _id_0D95(var_0);
  var_7 waittill("returned", var_8);
  var_7 notify("die");
  return var_8;
}

_id_108AD(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();

  if(isDefined(var_1)) {
    childthread _id_10928(var_1, var_6);
  }

  if(isDefined(var_2)) {
    childthread _id_10928(var_2, var_6);
  }

  if(isDefined(var_3)) {
    childthread _id_10928(var_3, var_6);
  }

  if(isDefined(var_4)) {
    childthread _id_10928(var_4, var_6);
  }

  if(isDefined(var_5)) {
    childthread _id_10928(var_5, var_6);
  }

  var_6 childthread _id_0D95(var_0);
  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

waittill_any_2(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  self waittill(var_0);
}

waittill_any_3(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  self waittill(var_0);
}

_id_10882(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  if(isDefined(var_3)) {
    self endon(var_3);
  }

  self waittill(var_0);
}

_id_10883(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  if(isDefined(var_3)) {
    self endon(var_3);
  }

  if(isDefined(var_4)) {
    self endon(var_4);
  }

  self waittill(var_0);
}

_id_10884(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  if(isDefined(var_3)) {
    self endon(var_3);
  }

  if(isDefined(var_4)) {
    self endon(var_4);
  }

  if(isDefined(var_5)) {
    self endon(var_5);
  }

  self waittill(var_0);
}

_id_10885(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  if(isDefined(var_3)) {
    self endon(var_3);
  }

  if(isDefined(var_4)) {
    self endon(var_4);
  }

  if(isDefined(var_5)) {
    self endon(var_5);
  }

  if(isDefined(var_6)) {
    self endon(var_6);
  }

  self waittill(var_0);
}

_id_10886(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  if(isDefined(var_3)) {
    self endon(var_3);
  }

  if(isDefined(var_4)) {
    self endon(var_4);
  }

  if(isDefined(var_5)) {
    self endon(var_5);
  }

  if(isDefined(var_6)) {
    self endon(var_6);
  }

  if(isDefined(var_7)) {
    self endon(var_7);
  }

  self waittill(var_0);
}

_id_1087F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  if(isDefined(var_3)) {
    self endon(var_3);
  }

  if(isDefined(var_4)) {
    self endon(var_4);
  }

  if(isDefined(var_5)) {
    self endon(var_5);
  }

  if(isDefined(var_6)) {
    self endon(var_6);
  }

  if(isDefined(var_7)) {
    self endon(var_7);
  }

  self waittill(var_0);
}

_id_108B4(var_0, var_1) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  self waittill(var_0);
}

_id_10888(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(isDefined(var_2) && isDefined(var_3)) {
    var_2 endon(var_3);
  }

  if(isDefined(var_4) && isDefined(var_5)) {
    var_4 endon(var_5);
  }

  if(isDefined(var_6) && isDefined(var_7)) {
    var_6 endon(var_7);
  }

  if(isDefined(var_8) && isDefined(var_9)) {
    var_8 endon(var_9);
  }

  if(isDefined(var_10) && isDefined(var_11)) {
    var_10 endon(var_11);
  }

  if(isDefined(var_12) && isDefined(var_13)) {
    var_12 endon(var_13);
  }

  var_0 waittill(var_1);
}

_id_1088C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  self endon("death");
  var_14 = spawnStruct();
  var_0 childthread _id_10927(var_1, var_14);

  if(isDefined(var_2) && isDefined(var_3)) {
    var_2 childthread _id_10927(var_3, var_14);
  }

  if(isDefined(var_4) && isDefined(var_5)) {
    var_4 childthread _id_10927(var_5, var_14);
  }

  if(isDefined(var_6) && isDefined(var_7)) {
    var_6 childthread _id_10927(var_7, var_14);
  }

  if(isDefined(var_8) && isDefined(var_9)) {
    var_8 childthread _id_10927(var_9, var_14);
  }

  if(isDefined(var_10) && isDefined(var_11)) {
    var_10 childthread _id_10927(var_11, var_14);
  }

  if(isDefined(var_12) && isDefined(var_13)) {
    var_12 childthread _id_10927(var_13, var_14);
  }

  var_14 waittill("returned", var_15);
  var_14 notify("die");
  return var_15;
}

_id_10889(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  foreach(var_9 in var_0) {
    if(var_9 != var_0[0]) {
      var_9 endon(var_1);
    }

    if(isDefined(var_2)) {
      var_9 endon(var_2);
    }

    if(isDefined(var_3)) {
      var_9 endon(var_3);
    }

    if(isDefined(var_4)) {
      var_9 endon(var_4);
    }

    if(isDefined(var_5)) {
      var_9 endon(var_5);
    }

    if(isDefined(var_6)) {
      var_9 endon(var_6);
    }

    if(isDefined(var_7)) {
      var_9 endon(var_7);
    }
  }

  var_0[0] waittill(var_1);
}

_id_1088A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = spawnStruct();

  foreach(var_10 in var_0) {
    var_10 childthread _id_10927(var_1, var_8);

    if(isDefined(var_2)) {
      var_10 childthread _id_10927(var_2, var_8);
    }

    if(isDefined(var_3)) {
      var_10 childthread _id_10927(var_3, var_8);
    }

    if(isDefined(var_4)) {
      var_10 childthread _id_10927(var_4, var_8);
    }

    if(isDefined(var_5)) {
      var_10 childthread _id_10927(var_5, var_8);
    }

    if(isDefined(var_6)) {
      var_10 childthread _id_10927(var_6, var_8);
    }

    if(isDefined(var_7)) {
      var_10 childthread _id_10927(var_7, var_8);
    }
  }

  var_8 waittill("returned", var_12, var_13);
  var_8 notify("die");
  return [var_13, var_12];
}

_id_108A4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death") && (!isDefined(var_6) || var_6 != "death") && (!isDefined(var_7) || var_7 != "death")) {
    self endon("death");
  }

  var_8 = spawnStruct();

  if(isDefined(var_0)) {
    childthread _id_10929(var_0, var_8);
  }

  if(isDefined(var_1)) {
    childthread _id_10929(var_1, var_8);
  }

  if(isDefined(var_2)) {
    childthread _id_10929(var_2, var_8);
  }

  if(isDefined(var_3)) {
    childthread _id_10929(var_3, var_8);
  }

  if(isDefined(var_4)) {
    childthread _id_10929(var_4, var_8);
  }

  if(isDefined(var_5)) {
    childthread _id_10929(var_5, var_8);
  }

  if(isDefined(var_6)) {
    childthread _id_10929(var_6, var_8);
  }

  if(isDefined(var_7)) {
    childthread _id_10929(var_7, var_8);
  }

  var_8 waittill("returned", var_9);
  var_8 notify("struct_delete");
  return var_9;
}

_id_108A5(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if((!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death") && (!isDefined(var_6) || var_6 != "death") && (!isDefined(var_7) || var_7 != "death") && (!isDefined(var_8) || var_8 != "death")) {
    self endon("death");
  }

  var_9 = spawnStruct();

  if(isDefined(var_1)) {
    childthread _id_10929(var_1, var_9);
  }

  if(isDefined(var_2)) {
    childthread _id_10929(var_2, var_9);
  }

  if(isDefined(var_3)) {
    childthread _id_10929(var_3, var_9);
  }

  if(isDefined(var_4)) {
    childthread _id_10929(var_4, var_9);
  }

  if(isDefined(var_5)) {
    childthread _id_10929(var_5, var_9);
  }

  if(isDefined(var_6)) {
    childthread _id_10929(var_6, var_9);
  }

  if(isDefined(var_7)) {
    childthread _id_10929(var_7, var_9);
  }

  if(isDefined(var_8)) {
    childthread _id_10929(var_8, var_9);
  }

  if(var_0 > 0) {
    childthread _id_10935(var_9, "returned", var_0);
  }

  var_9 waittill("returned", var_10);
  var_9 notify("struct_delete");
  return var_10;
}

_id_1088D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15) {
  var_18 = spawnStruct();

  if(isDefined(var_0) && isDefined(var_1)) {
    var_0 childthread _id_10929(var_1, var_18);
  }

  if(isDefined(var_2) && isDefined(var_3)) {
    var_2 childthread _id_10929(var_3, var_18);
  }

  if(isDefined(var_4) && isDefined(var_5)) {
    var_4 childthread _id_10929(var_5, var_18);
  }

  if(isDefined(var_6) && isDefined(var_7)) {
    var_6 childthread _id_10929(var_7, var_18);
  }

  if(isDefined(var_8) && isDefined(var_9)) {
    var_8 childthread _id_10929(var_9, var_18);
  }

  if(isDefined(var_10) && isDefined(var_11)) {
    var_10 childthread _id_10929(var_11, var_18);
  }

  if(isDefined(var_12) && isDefined(var_13)) {
    var_12 childthread _id_10929(var_13, var_18);
  }

  if(isDefined(var_14) && isDefined(var_15)) {
    var_14 childthread _id_10929(var_15, var_18);
  }

  var_18 waittill("returned", var_19);
  var_18 notify("struct_delete");
  return var_19;
}

_id_1088E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16) {
  var_19 = spawnStruct();

  if((!isDefined(var_2) || var_2 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_6) || var_6 != "death") && (!isDefined(var_8) || var_8 != "death") && (!isDefined(var_10) || var_10 != "death") && (!isDefined(var_12) || var_12 != "death") && (!isDefined(var_14) || var_14 != "death") && (!isDefined(var_16) || var_16 != "death")) {
    self endon("death");
  }

  if(isDefined(var_1) && isDefined(var_2)) {
    var_1 childthread _id_10929(var_2, var_19);
  }

  if(isDefined(var_3) && isDefined(var_4)) {
    var_3 childthread _id_10929(var_4, var_19);
  }

  if(isDefined(var_5) && isDefined(var_6)) {
    var_5 childthread _id_10929(var_6, var_19);
  }

  if(isDefined(var_7) && isDefined(var_8)) {
    var_7 childthread _id_10929(var_8, var_19);
  }

  if(isDefined(var_9) && isDefined(var_10)) {
    var_9 childthread _id_10929(var_10, var_19);
  }

  if(isDefined(var_11) && isDefined(var_12)) {
    var_11 childthread _id_10929(var_12, var_19);
  }

  if(isDefined(var_13) && isDefined(var_14)) {
    var_13 childthread _id_10929(var_14, var_19);
  }

  if(isDefined(var_15) && isDefined(var_16)) {
    var_15 childthread _id_10929(var_16, var_19);
  }

  if(var_0 > 0) {
    level childthread _id_10935(var_19, "returned", var_0);
  }

  var_19 waittill("returned", var_20);
  var_19 notify("struct_delete");
  return var_20;
}

_id_10935(var_0, var_1, var_2) {
  self endon(var_1);
  wait(var_2);
  var_3 = [];
  var_3["ent"] = undefined;
  var_3["message"] = "timeout";
  var_0 notify("returned", var_3);
}

_id_10929(var_0, var_1) {
  if(var_0 != "death") {
    self endon("death");
  }

  var_1 endon("struct_delete");
  self waittill(var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  var_12 = [];

  if(isDefined(var_2)) {
    var_12[0] = var_2;
  }

  if(isDefined(var_3)) {
    var_12[1] = var_3;
  }

  if(isDefined(var_4)) {
    var_12[2] = var_4;
  }

  if(isDefined(var_5)) {
    var_12[3] = var_5;
  }

  if(isDefined(var_6)) {
    var_12[4] = var_6;
  }

  if(isDefined(var_7)) {
    var_12[5] = var_7;
  }

  if(isDefined(var_8)) {
    var_12[6] = var_8;
  }

  if(isDefined(var_9)) {
    var_12[7] = var_9;
  }

  if(isDefined(var_10)) {
    var_12[8] = var_10;
  }

  if(isDefined(var_11)) {
    var_12[9] = var_11;
  }

  var_12["ent"] = self;
  var_12["message"] = var_0;
  var_1 notify("returned", var_12);
}

_id_107AE(var_0) {
  var_1 = gettime() + var_0;

  while(gettime() < var_1) {
    waitframe();
  }
}

_id_0393() {
  if(isDefined(self._id_0393)) {
    wait(self._id_0393);
    return 1;
  } else if(isDefined(self._id_CCFD) && isDefined(self._id_CCFB)) {
    wait(randomfloatrange(self._id_CCFD, self._id_CCFB));
    return 1;
  }

  return 0;
}

_id_CEB7() {
  var_0 = gettime();

  if(isDefined(self._id_CEB7)) {
    wait(self._id_CEB7);

    if(isDefined(self._id_CEBD)) {
      self._id_CEB7 = self._id_CEB7 + self._id_CEBD;
    }
  } else if(isDefined(self._id_CEBF) && isDefined(self._id_CEBE)) {
    wait(randomfloatrange(self._id_CEBF, self._id_CEBE));

    if(isDefined(self._id_CEBD)) {
      self._id_CEBF = self._id_CEBF + self._id_CEBD;
      self._id_CEBE = self._id_CEBE + self._id_CEBD;
    }
  }

  return gettime() - var_0;
}

_id_8862() {
  if(!isDefined(self._id_5CA2)) {
    return 0;
  }

  return gettime() < self._id_5CA2;
}

_id_5C0C(var_0) {
  if(!isDefined(level._id_5C00)) {
    return 0;
  }

  return isDefined(level._id_5C00[var_0]);
}

_id_5C00(var_0) {
  return _id_5C0C(var_0) && level._id_5C00[var_0];
}

_id_5C11(var_0) {
  if(!isDefined(level._id_5C00)) {
    _id_079E::_id_7F83();
  }

  level._id_5C00[var_0] = 0;
  _id_80E1();

  if(!isDefined(level._id_F5B2[var_0])) {
    level._id_F5B2[var_0] = [];
  }
}

_id_51C7(var_0) {}

_id_5C1B(var_0, var_1) {
  if(!_id_5C0C(var_0)) {
    _id_5C11(var_0);
  }

  level._id_5C00[var_0] = 1;
  _id_D3F0(var_0);

  if(isDefined(var_1)) {
    level notify(var_0, var_1);
  } else {
    level notify(var_0);
  }
}

_id_5C24(var_0) {
  var_1 = undefined;

  while(!_id_5C00(var_0)) {
    var_1 = undefined;
    level waittill(var_0, var_1);
  }

  if(isDefined(var_1)) {
    return var_1;
  }
}

_id_5C21(var_0) {
  if(_id_5C00(var_0)) {
    _id_5C04(var_0);
  } else {
    _id_5C1B(var_0);
  }
}

_id_5C04(var_0) {
  if(!_id_5C00(var_0)) {
    return;
  }
  level._id_5C00[var_0] = 0;
  _id_D3F0(var_0);
  level notify(var_0);
}

_id_5C30(var_0) {
  while(_id_5C00(var_0)) {
    level waittill(var_0);
  }
}

_id_108C5(var_0, var_1) {
  self endon(var_0);
  self waittill(var_1);
  return var_1;
}

_id_F5E2(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = getEntArray(var_0, var_1);
    _id_1BE2(var_2, ::_id_F5E3);
  } else
    _id_F5E3();
}

_id_F5E3() {
  self _meth_840E();
  self._id_F5E0 = undefined;
}

_id_F5E0(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = getEntArray(var_0, var_1);
    _id_1BE2(var_2, ::_id_F5E1);
  } else
    _id_F5E1();
}

_id_F5E1() {
  self _meth_840F();
  self._id_F5E0 = 1;
  self notify("trigger_off");
}

_id_D3F0(var_0) {
  if(!isDefined(level._id_F5B2)) {
    return;
  }
  level._id_F5B2[var_0] = _id_1BD1(level._id_F5B2[var_0]);
  _id_1BE2(level._id_F5B2[var_0], ::_id_FBE0);
}

_id_FBE0() {
  var_0 = 1;

  if(isDefined(self._id_CD4A)) {
    var_0 = 0;
    var_1 = _id_3F17(self._id_CD4A);

    foreach(var_3 in var_1) {
      if(_id_5C00(var_3)) {
        var_0 = 1;
        break;
      }
    }
  }

  var_5 = 1;

  if(isDefined(self._id_CD47)) {
    var_1 = _id_3F17(self._id_CD47);

    foreach(var_3 in var_1) {
      if(_id_5C00(var_3)) {
        var_5 = 0;
        break;
      }
    }
  }

  [[level._id_F5B5[var_0 && var_5]]]();
}

_id_3F17(var_0) {
  var_1 = strtok(var_0, " ");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isDefined(level._id_5C00[var_1[var_2]])) {
      _id_5C11(var_1[var_2]);
    }
  }

  return var_1;
}

_id_80E1() {
  if(!_id_0FE2("trigger_flags", ::_id_80E1)) {
    return;
  }
  level._id_F5B2 = [];
  level._id_F5B5[1] = ::_id_F5E2;
  level._id_F5B5[0] = ::_id_F5E0;
}

getstruct(var_0, var_1) {
  var_2 = level._id_EA70[var_1][var_0];

  if(!isDefined(var_2)) {
    return undefined;
  }

  if(var_2.size > 1) {
    return undefined;
  }

  return var_2[0];
}

getStructArray(var_0, var_1) {
  var_2 = level._id_EA70[var_1][var_0];

  if(!isDefined(var_2)) {
    return [];
  }

  return var_2;
}

_id_1019(var_0) {
  if(!isDefined(anim._id_DE28)) {
    anim._id_DE28 = [];
  }

  anim._id_DE28[anim._id_DE28.size] = var_0;
}

_id_E9B4() {
  if(!isDefined(anim._id_DE28)) {
    return;
  }
  foreach(var_1 in anim._id_DE28) {
    if(isDefined(var_1._id_0399)) {
      var_2 = var_1 _id_655C();

      foreach(var_4 in var_2) {
        if(var_4 == var_1) {
          continue;
        }
        if(!isDefined(var_4._id_CE48)) {
          continue;
        }
        if(!isDefined(var_1._id_950A)) {
          var_1._id_950A = [];
        }

        var_1._id_950A[var_1._id_950A.size] = var_4;
      }
    }
  }
}

_id_80CB() {
  if(!_id_0FE2("struct_classes", ::_id_80CB)) {
    return;
  }
  level._id_EA70 = [];
  level._id_EA70["target"] = [];
  level._id_EA70["targetname"] = [];
  level._id_EA70["script_noteworthy"] = [];
  level._id_EA70["script_linkname"] = [];
  level._id_EA70["variantname"] = [];

  foreach(var_3, var_1 in level._id_EA6A) {
    if(isDefined(var_1._id_CE48)) {
      _id_1019(var_1);
    }

    if(isDefined(var_1._id_0481)) {
      if(var_1._id_0481 == "delete_on_load") {
        level._id_EA6A[var_3] = undefined;
        continue;
      }

      if(isDefined(level._id_EA71)) {
        if(![[level._id_EA71]](var_1)) {
          level._id_EA6A[var_3] = undefined;
          continue;
        }
      }

      if(!isDefined(level._id_EA70["targetname"][var_1._id_0481])) {
        level._id_EA70["targetname"][var_1._id_0481] = [];
      }

      var_2 = level._id_EA70["targetname"][var_1._id_0481].size;
      level._id_EA70["targetname"][var_1._id_0481][var_2] = var_1;
    }

    if(isDefined(var_1.target)) {
      if(!isDefined(level._id_EA70["target"][var_1.target])) {
        level._id_EA70["target"][var_1.target] = [];
      }

      var_2 = level._id_EA70["target"][var_1.target].size;
      level._id_EA70["target"][var_1.target][var_2] = var_1;
    }

    if(isDefined(var_1._id_039B)) {
      if(!isDefined(level._id_EA70["script_noteworthy"][var_1._id_039B])) {
        level._id_EA70["script_noteworthy"][var_1._id_039B] = [];
      }

      var_2 = level._id_EA70["script_noteworthy"][var_1._id_039B].size;
      level._id_EA70["script_noteworthy"][var_1._id_039B][var_2] = var_1;
    }

    if(isDefined(var_1._id_0398)) {
      if(!isDefined(level._id_EA70["script_linkname"][var_1._id_0398])) {
        level._id_EA70["script_linkname"][var_1._id_0398] = [];
      }

      var_2 = level._id_EA70["script_linkname"][var_1._id_0398].size;
      level._id_EA70["script_linkname"][var_1._id_0398][var_2] = var_1;
    }

    if(isDefined(var_1._id_FFC5)) {
      if(!isDefined(level._id_EA70["variantname"][var_1._id_FFC5])) {
        level._id_EA70["variantname"][var_1._id_FFC5] = [];
      }

      var_2 = level._id_EA70["variantname"][var_1._id_FFC5].size;
      level._id_EA70["variantname"][var_1._id_FFC5][var_2] = var_1;
    }
  }

  _id_E9B4();
}

_id_113D(var_0) {
  if(isDefined(level._id_EA6A)) {
    level._id_EA6A = _id_1B8D(level._id_EA6A, var_0);
  }

  if(isDefined(var_0._id_CE48)) {
    _id_1019(var_0);
  }

  if(isDefined(var_0._id_0481)) {
    if(!isDefined(level._id_EA70["targetname"][var_0._id_0481])) {
      level._id_EA70["targetname"][var_0._id_0481] = [];
    }

    var_1 = level._id_EA70["targetname"][var_0._id_0481].size;
    level._id_EA70["targetname"][var_0._id_0481][var_1] = var_0;
  }

  if(isDefined(var_0.target)) {
    if(!isDefined(level._id_EA70["target"][var_0.target])) {
      level._id_EA70["target"][var_0.target] = [];
    }

    var_1 = level._id_EA70["target"][var_0.target].size;
    level._id_EA70["target"][var_0.target][var_1] = var_0;
  }

  if(isDefined(var_0._id_039B)) {
    if(!isDefined(level._id_EA70["script_noteworthy"][var_0._id_039B])) {
      level._id_EA70["script_noteworthy"][var_0._id_039B] = [];
    }

    var_1 = level._id_EA70["script_noteworthy"][var_0._id_039B].size;
    level._id_EA70["script_noteworthy"][var_0._id_039B][var_1] = var_0;
  }

  if(isDefined(var_0._id_0398)) {
    if(!isDefined(level._id_EA70["script_linkname"][var_0._id_0398])) {
      level._id_EA70["script_linkname"][var_0._id_0398] = [];
    }

    var_1 = level._id_EA70["script_linkname"][var_0._id_0398].size;
    level._id_EA70["script_linkname"][var_0._id_0398][var_1] = var_0;
  }
}

_id_4795(var_0, var_1, var_2) {
  var_3 = getStructArray(var_0, var_1);
  _id_4796(var_3, var_2);
}

_id_4794(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0._id_0398;

  if(isDefined(var_1) && isDefined(level._id_EA70["script_linkname"]) && isDefined(level._id_EA70["script_linkname"][var_1])) {
    foreach(var_4, var_3 in level._id_EA70["script_linkname"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3) {
        level._id_EA70["script_linkname"][var_1][var_4] = undefined;
      }
    }

    if(level._id_EA70["script_linkname"][var_1].size == 0) {
      level._id_EA70["script_linkname"][var_1] = undefined;
    }
  }

  var_1 = var_0._id_039B;

  if(isDefined(var_1) && isDefined(level._id_EA70["script_noteworthy"]) && isDefined(level._id_EA70["script_noteworthy"][var_1])) {
    foreach(var_4, var_3 in level._id_EA70["script_noteworthy"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3) {
        level._id_EA70["script_noteworthy"][var_1][var_4] = undefined;
      }
    }

    if(level._id_EA70["script_noteworthy"][var_1].size == 0) {
      level._id_EA70["script_noteworthy"][var_1] = undefined;
    }
  }

  var_1 = var_0.target;

  if(isDefined(var_1) && isDefined(level._id_EA70["target"]) && isDefined(level._id_EA70["target"][var_1])) {
    foreach(var_4, var_3 in level._id_EA70["target"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3) {
        level._id_EA70["target"][var_1][var_4] = undefined;
      }
    }

    if(level._id_EA70["target"][var_1].size == 0) {
      level._id_EA70["target"][var_1] = undefined;
    }
  }

  var_1 = var_0._id_0481;

  if(isDefined(var_1) && isDefined(level._id_EA70["targetname"]) && isDefined(level._id_EA70["targetname"][var_1])) {
    foreach(var_4, var_3 in level._id_EA70["targetname"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3) {
        level._id_EA70["targetname"][var_1][var_4] = undefined;
      }
    }

    if(level._id_EA70["targetname"][var_1].size == 0) {
      level._id_EA70["targetname"][var_1] = undefined;
    }
  }

  if(isDefined(level._id_EA6A)) {
    foreach(var_4, var_3 in level._id_EA6A) {
      if(var_0 == var_3) {
        level._id_EA6A[var_4] = undefined;
      }
    }
  }
}

_id_4796(var_0, var_1) {
  if(!isDefined(var_0) || !_func_0107(var_0) || var_0.size == 0) {
    return;
  }
  var_1 = ter_op(isDefined(var_1), var_1, 0);
  var_1 = ter_op(var_1 > 0, var_1, 0);

  if(var_1 > 0) {
    foreach(var_3 in var_0) {
      _id_4794(var_3);
      wait(var_1);
    }
  } else {
    foreach(var_3 in var_0) {
      _id_4794(var_3);
    }
  }
}

_id_6D99(var_0, var_1) {
  var_2 = getstruct(var_0, var_1);
  _id_4794(var_2);
  return var_2;
}

_id_6D9B(var_0, var_1, var_2) {
  var_3 = getStructArray(var_0, var_1);
  _id_4796(var_3, var_2);
  return var_3;
}

_id_6A02(var_0, var_1) {
  var_2 = getent(var_0, var_1);

  if(isDefined(var_2)) {
    return var_2;
  }

  return getstruct(var_0, var_1);
}

_id_5A3A(var_0) {}

_id_5A38() {}

_id_5A36(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }
}

_id_5A37(var_0, var_1) {}

_id_5A35() {}

_id_5A34() {}

_id_5A39(var_0) {}

_id_2F17(var_0, var_1, var_2, var_3) {
  childthread _id_2F19(var_0, var_1, var_2, var_3);
}

_id_2F16(var_0, var_1, var_2, var_3) {
  self endon("death");
  childthread _id_2F19(var_0, var_1, var_2, var_3);
}

_id_2F19(var_0, var_1, var_2, var_3) {
  self waittill(var_0);

  if(isDefined(var_3)) {
    self call[[var_1]](var_2, var_3);
  } else if(isDefined(var_2)) {
    self call[[var_1]](var_2);
  } else {
    self call[[var_1]]();
  }
}

_id_F126(var_0, var_1, var_2, var_3, var_4) {
  childthread _id_F127(var_0, var_1, var_2, var_3, var_4);
}

_id_F125(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");

  if(isDefined(var_5) && isDefined(var_6)) {
    if(!_func_0107(var_5)) {
      var_5 = [var_5];
    }

    if(!_func_0107(var_6)) {
      var_6 = [var_6];
    }

    foreach(var_8 in var_5) {
      foreach(var_10 in var_6) {
        var_8 endon(var_10);
      }
    }
  }

  childthread _id_F127(var_0, var_1, var_2, var_3, var_4);
}

_id_F127(var_0, var_1, var_2, var_3, var_4) {
  self waittill(var_0);

  if(!isDefined(var_4)) {
    var_4 = self;
  }

  if(isDefined(var_3)) {
    var_4 thread[[var_1]](var_2, var_3);
  } else if(isDefined(var_2)) {
    var_4 thread[[var_1]](var_2);
  } else {
    var_4 thread[[var_1]]();
  }
}

_id_46A5(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  thread _id_46A6(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
}

_id_46A8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  thread _id_46A7(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
}

_id_46A7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  self endon("disconnect");
  self endon("death");
  _id_46A6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
}

_id_46A6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(scripts\common\utility::issp()) {
    self endon("death");
    self endon("stop_delay_call");
  }

  wait(var_1);

  if(isDefined(var_13)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
  } else if(isDefined(var_12)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
  } else if(isDefined(var_11)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  } else if(isDefined(var_10)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  } else if(isDefined(var_9)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  } else if(isDefined(var_8)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  } else if(isDefined(var_7)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
  } else if(isDefined(var_6)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6);
  } else if(isDefined(var_5)) {
    self call[[var_0]](var_2, var_3, var_4, var_5);
  } else if(isDefined(var_4)) {
    self call[[var_0]](var_2, var_3, var_4);
  } else if(isDefined(var_3)) {
    self call[[var_0]](var_2, var_3);
  } else if(isDefined(var_2)) {
    self call[[var_0]](var_2);
  } else {
    self call[[var_0]]();
  }
}

string_starts_with(var_0, var_1) {
  if(var_0.size < var_1.size) {
    return 0;
  }

  var_2 = _func_00D6(var_0, 0, var_1.size);

  if(var_2 == var_1) {
    return 1;
  }

  return 0;
}

_id_B927(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0[0];

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(!isDefined(var_4)) {
    var_4 = 0.05;
  }

  for(var_6 = 1; var_6 < var_0.size; var_6++) {
    thread _id_4F13(var_5, var_0[var_6], var_1, var_2, var_3, var_4);
    var_5 = var_0[var_6];
  }
}

_id_4F13(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_5 = gettime() + var_5 * 1000;

  while(gettime() < var_5) {
    waitframe();
  }
}

draw_path_for_time(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");
  var_6 = var_5 * 1000;
  var_7 = gettime();
  var_5 = var_7 + var_5 * 1000;

  while(gettime() < var_5) {
    var_8 = var_0.origin;
    wait(var_1);
    thread _id_4F13(var_8, var_0.origin, var_2, var_3, var_4, (var_6 - (gettime() - var_7)) / 1000);
  }
}

_id_4EF6(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 16;
  var_7 = 360 / var_6;
  var_8 = [];

  for(var_9 = 0; var_9 < var_6; var_9++) {
    var_10 = var_7 * var_9;
    var_11 = cos(var_10) * var_1;
    var_12 = sin(var_10) * var_1;
    var_13 = var_0[0] + var_11;
    var_14 = var_0[1] + var_12;
    var_15 = var_0[2];
    var_8[var_8.size] = (var_13, var_14, var_15);
  }

  for(var_9 = 0; var_9 < var_8.size; var_9++) {
    var_16 = var_8[var_9];

    if(var_9 + 1 >= var_8.size) {
      var_17 = var_8[0];
      continue;
    }

    var_17 = var_8[var_9 + 1];
  }
}

array_add(var_0, var_1) {
  var_0[var_0.size] = var_1;
  return var_0;
}

_id_1B8D(var_0, var_1) {
  if(!isDefined(var_1)) {
    return var_0;
  }

  if(!isDefined(var_0)) {
    var_0[0] = var_1;
  } else {
    var_0[var_0.size] = var_1;
  }

  return var_0;
}

_id_1BA4(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2 delete();
    }
  }
}

_id_1BB3(var_0, var_1, var_2) {
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

array_combine(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];

  if(isDefined(var_0)) {
    foreach(var_7 in var_0) {
      var_5[var_5.size] = var_7;
    }
  }

  if(isDefined(var_1)) {
    foreach(var_7 in var_1) {
      var_5[var_5.size] = var_7;
    }
  }

  if(isDefined(var_2)) {
    foreach(var_7 in var_2) {
      var_5[var_5.size] = var_7;
    }
  }

  if(isDefined(var_3)) {
    foreach(var_7 in var_3) {
      var_5[var_5.size] = var_7;
    }
  }

  if(isDefined(var_4)) {
    foreach(var_7 in var_4) {
      var_5[var_5.size] = var_7;
    }
  }

  return var_5;
}

_id_1B9B(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    foreach(var_5 in var_3) {
      var_1[var_1.size] = var_5;
    }
  }

  return var_1;
}

_id_1B9D(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    var_2[var_2.size] = var_4;
  }

  foreach(var_4 in var_1) {
    if(array_contains(var_2, var_4)) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_1B9E(var_0, var_1) {
  foreach(var_4, var_3 in var_1) {
    if(!isDefined(var_0[var_4])) {
      var_0[var_4] = var_3;
    }
  }

  return var_0;
}

_id_1B9C(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_0) {
    var_2[var_5] = var_4;
  }

  foreach(var_5, var_4 in var_1) {
    var_2[var_5] = var_4;
  }

  return var_2;
}

_id_1BB4(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(array_contains(var_1, var_4)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_1BA6(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(!array_contains(var_1, var_4)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_1BA2(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

array_random(var_0) {
  if(var_0.size > 0) {
    var_1 = randomint(var_0.size);
    return var_0[var_1];
  }

  return undefined;
}

array_randomize(var_0) {
  for(var_1 = 0; var_1 < var_0.size - 1; var_1++) {
    var_2 = randomintrange(var_1, var_0.size);
    var_3 = var_0[var_1];
    var_0[var_1] = var_0[var_2];
    var_0[var_2] = var_3;
  }

  return var_0;
}

_id_1BBD(var_0) {
  var_1 = [];

  for(var_2 = var_0; var_2.size > 0; var_2 = var_4) {
    var_3 = randomintrange(0, var_2.size);
    var_4 = [];
    var_5 = 0;

    foreach(var_8, var_7 in var_2) {
      if(var_5 == var_3) {
        var_1[ter_op(_func_0121(var_8), var_8, var_1.size)] = var_7;
      } else {
        var_4[ter_op(_func_0121(var_8), var_8, var_4.size)] = var_7;
      }

      var_5++;
    }
  }

  return var_1;
}

_id_1BD2(var_0) {
  var_1 = [];

  for(var_2 = var_0.size - 1; var_2 >= 0; var_2--) {
    var_1[var_1.size] = var_0[var_2];
  }

  return var_1;
}

_id_1BD4(var_0, var_1, var_2) {
  if(var_0.size <= 0) {
    return [];
  }

  if(!isDefined(var_2) || var_2 > var_0.size) {
    var_2 = var_0.size;
  }

  if(var_1 == 0 && var_2 == var_0.size) {
    return var_0;
  }

  var_3 = [];

  for(var_4 = var_1; var_4 < var_2; var_4++) {
    var_3[var_3.size] = var_0[var_4];
  }

  return var_3;
}

array_contains(var_0, var_1) {
  if(var_0.size <= 0) {
    return 0;
  }

  foreach(var_3 in var_0) {
    if(var_3 == var_1) {
      return 1;
    }
  }

  return 0;
}

_id_1BA1(var_0, var_1) {
  foreach(var_4, var_3 in var_0) {
    if(var_4 == var_1) {
      return 1;
    }
  }

  return 0;
}

_id_1BAB(var_0, var_1) {
  foreach(var_4, var_3 in var_0) {
    if(var_3 == var_1) {
      return var_4;
    }
  }

  return undefined;
}

array_remove(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(var_4 != var_1) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_1BBF(var_0, var_1) {
  foreach(var_3 in var_1) {
    var_0 = array_remove(var_0, var_3);
  }

  return var_0;
}

array_remove_index(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_7, var_5 in var_0) {
    if(var_7 == var_1) {
      continue;
    }
    if(istrue(var_2)) {
      var_6 = var_7;
    } else {
      var_6 = var_3.size;
    }

    var_3[var_6] = var_5;
  }

  return var_3;
}

_id_1BD1(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_0) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(istrue(var_1)) {
      var_2[var_5] = var_4;
      continue;
    }

    var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_1BCA(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isalive(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_1BD0(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isPlayer(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_1BC6(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_0) {
    if(var_1 == var_5) {
      continue;
    }
    var_2[var_5] = var_4;
  }

  return var_2;
}

_id_1BC1(var_0) {
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

    if(var_4) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_1BAC(var_0) {
  foreach(var_2 in var_0) {
    return var_2;
  }

  return undefined;
}

_id_1BAD(var_0) {
  var_1 = undefined;

  foreach(var_3 in var_0) {
    var_1 = var_3;
  }

  return var_1;
}

_id_1BC8(var_0, var_1) {
  var_2 = [];
  var_3 = 0;

  foreach(var_5 in _id_1BD2(var_0)) {
    if(!var_3 && var_5 == var_1) {
      var_3 = 1;
      continue;
    }

    var_2[var_2.size] = var_5;
  }

  return _id_1BD2(var_2);
}

_id_1BB7(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    foreach(var_6 in var_0) {
      thread[[var_1]](var_6, var_2, var_3, var_4);
    }

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_6 in var_0) {
      thread[[var_1]](var_6, var_2, var_3);
    }

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_6 in var_0) {
      thread[[var_1]](var_6, var_2);
    }

    return;
  }

  foreach(var_6 in var_0) {
    thread[[var_1]](var_6);
  }
}

_id_1BB6(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    foreach(var_6 in var_0) {
      call[[var_1]](var_6, var_2, var_3, var_4);
    }

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_6 in var_0) {
      call[[var_1]](var_6, var_2, var_3);
    }

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_6 in var_0) {
      call[[var_1]](var_6, var_2);
    }

    return;
  }

  foreach(var_6 in var_0) {
    call[[var_1]](var_6);
  }
}

_id_1BD6(var_0, var_1) {
  for(var_2 = 1; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    for(var_4 = var_2 - 1; var_4 >= 0 && ![[var_1]](var_0[var_4], var_3); var_4--) {
      var_0[var_4 + 1] = var_0[var_4];
    }

    var_0[var_4 + 1] = var_3;
  }

  return var_0;
}

_id_1B97(var_0) {
  return _id_1BE1(var_0) / var_0.size;
}

_id_1BE1(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0) {
    var_1 = var_1 + var_3;
  }

  return var_1;
}

_id_1BA7(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_0[var_2] = var_0[var_2] / var_1;
  }

  return var_0;
}

random(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    var_1[var_1.size] = var_3;
  }

  if(!var_1.size) {
    return undefined;
  }

  return var_1[randomint(var_1.size)];
}

_id_BFF2(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    var_1[var_1.size] = var_3;
  }

  if(!var_1.size) {
    return undefined;
  }

  var_5 = randomint(var_1.size * var_1.size);
  return var_1[var_1.size - 1 - int(_func_0218(var_5))];
}

_id_163E(var_0) {
  if(var_0.size <= 1) {
    return var_0;
  }

  var_1 = 0;

  for(var_2 = var_0.size - 1; var_2 >= 1; var_2--) {
    var_3 = var_0[var_2];
    var_4 = var_2;

    for(var_5 = 0; var_5 < var_2; var_5++) {
      var_6 = var_0[var_5];

      if(_func_021E(var_6, var_3) > 0) {
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

_id_1BE3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(var_3)) {
    foreach(var_13 in var_0) {
      var_13 thread[[var_1]]();
      wait(var_2);
    }
  } else {
    if(!isDefined(var_4)) {
      foreach(var_13 in var_0) {
        var_13 thread[[var_1]](var_3);
        wait(var_2);
      }

      return;
    }

    if(!isDefined(var_5)) {
      foreach(var_13 in var_0) {
        var_13 thread[[var_1]](var_3, var_4);
        wait(var_2);
      }

      return;
    }

    if(!isDefined(var_6)) {
      foreach(var_13 in var_0) {
        var_13 thread[[var_1]](var_3, var_4, var_5);
        wait(var_2);
      }

      return;
    }

    if(!isDefined(var_7)) {
      foreach(var_13 in var_0) {
        var_13 thread[[var_1]](var_3, var_4, var_5, var_6);
        wait(var_2);
      }

      return;
    }

    if(!isDefined(var_8)) {
      foreach(var_13 in var_0) {
        var_13 thread[[var_1]](var_3, var_4, var_5, var_6, var_7);
        wait(var_2);
      }

      return;
    }

    if(!isDefined(var_9)) {
      foreach(var_13 in var_0) {
        var_13 thread[[var_1]](var_3, var_4, var_5, var_6, var_7, var_8);
        wait(var_2);
      }

      return;
    }

    if(!isDefined(var_10)) {
      foreach(var_13 in var_0) {
        var_13 thread[[var_1]](var_3, var_4, var_5, var_6, var_7, var_8, var_9);
        wait(var_2);
      }

      return;
    }

    if(!isDefined(var_11)) {
      foreach(var_13 in var_0) {
        var_13 thread[[var_1]](var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
        wait(var_2);
      }

      return;
    }

    foreach(var_13 in var_0) {
      var_13 thread[[var_1]](var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
      wait(var_2);
    }
  }
}

_id_1BE2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(var_10)) {
    foreach(var_12 in var_0) {
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    }

    return;
  }

  if(isDefined(var_9)) {
    foreach(var_12 in var_0) {
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    }

    return;
  }

  if(isDefined(var_8)) {
    foreach(var_12 in var_0) {
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    }

    return;
  }

  if(isDefined(var_7)) {
    foreach(var_12 in var_0) {
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7);
    }

    return;
  }

  if(isDefined(var_6)) {
    foreach(var_12 in var_0) {
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6);
    }

    return;
  }

  if(isDefined(var_5)) {
    foreach(var_12 in var_0) {
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5);
    }

    return;
  }

  if(isDefined(var_4)) {
    foreach(var_12 in var_0) {
      var_12 thread[[var_1]](var_2, var_3, var_4);
    }

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_12 in var_0) {
      var_12 thread[[var_1]](var_2, var_3);
    }

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_12 in var_0) {
      var_12 thread[[var_1]](var_2);
    }

    return;
  }

  foreach(var_12 in var_0) {
    var_12 thread[[var_1]]();
  }
}

_id_1B98(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_9)) {
    foreach(var_11 in var_0) {
      var_11 call[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    }

    return;
  }

  if(isDefined(var_8)) {
    foreach(var_11 in var_0) {
      var_11 call[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    }

    return;
  }

  if(isDefined(var_7)) {
    foreach(var_11 in var_0) {
      var_11 call[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7);
    }

    return;
  }

  if(isDefined(var_6)) {
    foreach(var_11 in var_0) {
      var_11 call[[var_1]](var_2, var_3, var_4, var_5, var_6);
    }

    return;
  }

  if(isDefined(var_5)) {
    foreach(var_11 in var_0) {
      var_11 call[[var_1]](var_2, var_3, var_4, var_5);
    }

    return;
  }

  if(isDefined(var_4)) {
    foreach(var_11 in var_0) {
      var_11 call[[var_1]](var_2, var_3, var_4);
    }

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_11 in var_0) {
      var_11 call[[var_1]](var_2, var_3);
    }

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_11 in var_0) {
      var_11 call[[var_1]](var_2);
    }

    return;
  }

  foreach(var_11 in var_0) {
    var_11 call[[var_1]]();
  }
}

_id_5CD9(var_0) {
  var_1 = (0, var_0[1], 0);
  return var_1;
}

_id_5CDA(var_0) {
  var_1 = (var_0[0], var_0[1], 0);
  return var_1;
}

_id_5CDB(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 1);
  }

  var_2 = vectornormalize(var_0 - vectordot(var_1, var_0) * var_1);
  return var_2;
}

_id_4EEF(var_0, var_1, var_2, var_3) {
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
  _id_B927(var_10, var_12, var_13, var_14, var_3);
}

_id_4EED(var_0, var_1, var_2) {
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

    if(var_11 >= 4) {
      var_11 = 0;
    }
  }
}

_id_4EF3(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = var_4;
  var_8 = var_4;
  var_9 = var_4;

  if(_func_0107(var_4)) {
    var_9 = var_4[0];
    var_8 = var_4[1];
    var_7 = var_4[2];
  }

  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!isDefined(var_6)) {
    var_6 = 1;
  }

  var_10 = anglesToForward(var_3);
  var_11 = anglestoright(var_3);
  var_12 = anglestoup(var_3);
  var_13 = var_0 + var_12 * var_1;
  var_14 = var_0 + var_12 * var_2;
  var_14 = var_14 - var_12 * var_1;
  var_15 = var_13 + var_10 * var_1;
  var_16 = var_14 + var_10 * var_1;
  var_17 = var_13 - var_10 * var_1;
  var_18 = var_14 - var_10 * var_1;
  var_19 = var_13 + var_11 * var_1;
  var_20 = var_14 + var_11 * var_1;
  var_21 = var_13 - var_11 * var_1;
  var_22 = var_14 - var_11 * var_1;
}

_id_4EF5(var_0, var_1, var_2) {
  var_3 = self _meth_8487();
  _id_4EF3(self _meth_8169(), var_3["radius"], var_3["half_height"] * 2, self.angles, var_0, var_1, var_2);
}

_id_4F23(var_0, var_1, var_2) {
  var_3 = self _meth_8487();
  _id_4EF3(self _meth_8169(), var_3["radius"], var_3["half_height"] * 2, self getplayerangles(), var_0, var_1, var_2);
}

_id_4F0D(var_0, var_1) {
  self endon("stop_drawing_axis");
  self endon("death");

  for(;;) {
    var_2 = self gettagorigin(var_0);
    var_3 = self gettagangles(var_0);
    _id_4EEA(var_3, var_2, var_1);
    waitframe();
  }
}

_id_4F0C(var_0, var_1) {
  self endon("stop_drawing_axis");
  self endon("death");

  for(;;) {
    _id_4F0B(var_0, undefined, var_1);
    waitframe();
  }
}

_id_4F2B(var_0, var_1, var_2) {
  self endon("stop_drawing_axis");
  self endon("death");

  for(;;) {
    _id_4F2A(var_0, var_1, undefined, var_2);
    waitframe();
  }
}

_id_4F0B(var_0, var_1, var_2) {
  waittillframeend;

  if(isDefined(self.angles)) {
    var_3 = self.angles;
  } else {
    var_3 = (0, 0, 0);
  }

  _id_4EEA(var_3, self.origin, var_0, var_1, var_2);
}

_id_4F2A(var_0, var_1, var_2, var_3) {
  waittillframeend;
  var_4 = self gettagangles(var_0);
  var_5 = self gettagorigin(var_0);
  _id_4EEA(var_4, var_5, var_1, var_2, var_3);
}

_id_4EEA(var_0, var_1, var_2, var_3, var_4) {
  waittillframeend;
  var_5 = anglesToForward(var_0);
  var_6 = anglestoright(var_0);
  var_7 = anglestoup(var_0);

  if(!isDefined(var_2)) {
    var_2 = (1, 0, 1);
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(!isDefined(var_4)) {
    var_4 = 10;
  }
}

_id_4F0E(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = (0, 1, 0);
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0.05;
  }

  if(var_3) {
    var_5 = int(var_4 / 0.05);
  } else {
    var_5 = int(var_1 / 0.05);
  }

  var_6 = [];
  var_7 = [];
  var_8 = gettime();

  for(var_9 = var_8 + var_1 * 1000; var_8 < var_9 && isDefined(var_0); var_8 = gettime()) {
    var_6[0] = var_0 _meth_8174(1, 1, 1);
    var_6[1] = var_0 _meth_8174(1, 1, -1);
    var_6[2] = var_0 _meth_8174(-1, 1, -1);
    var_6[3] = var_0 _meth_8174(-1, 1, 1);
    var_7[0] = var_0 _meth_8174(1, -1, 1);
    var_7[1] = var_0 _meth_8174(1, -1, -1);
    var_7[2] = var_0 _meth_8174(-1, -1, -1);
    var_7[3] = var_0 _meth_8174(-1, -1, 1);

    for(var_10 = 0; var_10 < 4; var_10++) {
      var_11 = var_10 + 1;

      if(var_11 == 4) {
        var_11 = 0;
      }
    }

    if(!var_3) {
      return;
    }
    wait(var_4);
  }
}

_id_4EEC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_3)) {
    var_3 = 180;
  }

  if(!isDefined(var_2)) {
    var_2 = 100;
  }

  if(!isDefined(var_1) && isDefined(self.angles)) {
    var_1 = self.angles;
  }

  if(!isDefined(var_0) && isDefined(self.origin)) {
    var_0 = self.origin;
  }

  var_8 = 16;
  var_9 = 360 / var_8;
  var_10 = var_3;
  var_11 = var_10 - var_3 * 2.0;
  var_12 = var_10;
  var_13 = [];
  var_13[var_13.size] = var_0;
  var_13[var_13.size] = var_0 + anglesToForward(_func_0047(var_1, (0, var_12, 0))) * var_2;

  for(var_13[var_13.size] = var_0; var_12 > var_11; var_13[var_13.size - 2] = var_0 + anglesToForward(_func_0047(var_1, (0, var_12, 0))) * var_2) {
    var_12 = max(var_11, var_12 - var_9);
    var_13[var_13.size] = var_13[var_13.size - 1];
  }

  thread _id_4EF9(var_13, var_4, var_5, var_6, var_7);
}

_id_4EF7(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 16;
  var_7 = 360 / var_6;
  var_8 = [];

  for(var_9 = 0; var_9 < var_6; var_9++) {
    var_10 = var_7 * var_9;
    var_11 = cos(var_10) * var_1;
    var_12 = sin(var_10) * var_1;
    var_13 = var_0[0] + var_11;
    var_14 = var_0[1] + var_12;
    var_15 = var_0[2];
    var_8[var_8.size] = (var_13, var_14, var_15);
  }

  thread _id_4EF9(var_8, var_2, var_3, var_4, var_5);
}

_id_4EF9(var_0, var_1, var_2, var_3, var_4) {
  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = var_0[var_5];

    if(var_5 + 1 >= var_0.size) {
      var_7 = var_0[0];
    } else {
      var_7 = var_0[var_5 + 1];
    }

    thread _id_4F13(var_6, var_7, var_1, var_2, var_3, var_4);
  }
}

_id_4EF8(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 16;
  var_6 = 360 / var_5;
  var_7 = [];

  for(var_8 = 0; var_8 < var_5; var_8++) {
    var_9 = anglesToForward(var_2);
    var_10 = _func_025B(var_9, (0, 0, 1));
    var_11 = _func_025B(var_10, var_9);
    var_12 = var_6 * var_8;
    var_13 = cos(var_12) * var_1;
    var_14 = sin(var_12) * var_1;
    var_7[var_7.size] = var_0 + var_10 * var_13 + var_11 * var_14;
  }

  thread _id_4EF9(var_7, var_3[0], var_3[1], var_3[2], var_4);
}

_id_4EFF(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_4)) {
    var_4 = (1, 1, 1);
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  var_6 = 1;
  var_7 = 0;
  var_1 = vectornormalize(var_1);

  if(var_1 == (0, 0, 1)) {
    var_8 = (1, 0, 0);
  }

  var_8 = vectornormalize(_func_025B(var_1, (0, 0, 1)));
  var_9 = _func_025B(var_1, var_8);
  var_10 = var_1 * var_3 * cos(var_2);
  var_11 = var_3 * sin(var_2);
  var_12 = (0, 0, 0);
  var_13 = int(20 * var_5);
  var_14 = 16;

  for(var_15 = 0; var_15 <= var_14; var_15++) {
    var_16 = var_15 / var_14 * 360;
    var_17 = var_0 + var_10 + var_11 * (var_8 * cos(var_16) + var_9 * sin(var_16));

    if(var_15 > 0) {}

    var_12 = var_17;
  }
}

getfx(var_0) {
  return level._effect[var_0];
}

_id_608B(var_0) {
  return isDefined(level._effect[var_0]);
}

_id_B808() {}

spawn_tag_origin(var_0, var_1) {
  if(!isDefined(var_1) && isDefined(self.angles)) {
    var_1 = self.angles;
  }

  if(!isDefined(var_0) && isDefined(self.origin)) {
    var_0 = self.origin;
  } else if(!isDefined(var_0)) {
    var_0 = (0, 0, 0);
  }

  var_2 = spawn("script_model", var_0);
  var_2 setModel("tag_origin");
  var_2 hide();

  if(isDefined(var_1)) {
    var_2.angles = var_1;
  }

  return var_2;
}

_id_108F5(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

_id_108F7(var_0, var_1) {
  var_2 = spawnStruct();
  thread _id_108F8(var_2, var_0);
  thread _id_10934(var_2, var_1);
  var_2 waittill("waittill_proc", var_3);
  return var_3;
}

_id_108F8(var_0, var_1) {
  var_0 endon("waittill_proc");
  self waittill(var_1);
  var_0 notify("waittill_proc", var_1);
}

_id_10934(var_0, var_1) {
  var_0 endon("waittill_proc");
  wait(var_1);
  var_0 notify("waittill_proc", "timeout");
}

_id_108F4(var_0, var_1) {
  var_2 = gettime();
  self waittill(var_0);
  var_3 = var_2 + var_1 * 1000;
  var_4 = var_3 - var_2;

  if(var_4 > 0) {
    var_5 = var_4 / 1000.0;
    wait(var_5);
  }
}

_id_1BE7(var_0, var_1, var_2) {
  var_3 = spawnStruct();

  if(istrue(var_2)) {
    thread _id_1BEB(var_3, var_2);
    var_3 endon("array_wait_timeout");
  }

  foreach(var_5 in var_0) {
    thread _id_1BEA(var_3, var_5, var_1);
  }

  for(var_7 = 0; var_7 < var_0.size; var_7++) {
    var_3 waittill("array_wait_proc");
  }

  var_3 notify("array_wait_success");
}

_id_1BEA(var_0, var_1, var_2) {
  var_0 endon("array_wait_success");
  var_1 waittill_any_2(var_2, "death");
  var_0 notify("array_wait_proc");
}

_id_1BEB(var_0, var_1) {
  var_0 endon("array_wait_success");
  wait(var_1);
  var_0 notify("array_wait_timeout");
}

_id_1B8F(var_0, var_1) {
  var_2 = spawnStruct();

  foreach(var_4 in var_0) {
    thread _id_1B92(var_2, var_4, var_1);
  }

  var_2 waittill("array_wait_proc", var_6);
  return var_6;
}

_id_1B95(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  thread _id_1B96(var_3, var_2);

  foreach(var_5 in var_0) {
    thread _id_1B92(var_3, var_5, var_1);
  }

  var_3 waittill("array_wait_proc", var_7);
  return var_7;
}

_id_1B92(var_0, var_1, var_2) {
  var_3 = var_1 _id_1089D(var_2, "death");
  var_0 notify("array_wait_proc", var_3);
}

_id_1B96(var_0, var_1) {
  var_0 endon("array_wait_proc");
  wait(var_1);
  var_0 notify("array_wait_proc", "timeout");
}

_id_1B93(var_0, var_1) {
  var_2 = spawnStruct();

  foreach(var_4 in var_0) {
    thread _id_1B94(var_2, var_4, var_1);
  }

  var_2 waittill("array_wait_proc", var_4);
  return var_4;
}

_id_1B94(var_0, var_1, var_2) {
  var_3 = var_1 _id_10897(var_2, "death");
  var_0 notify("array_wait_proc", var_1);
}

_id_5A33() {
  level._id_5A3B = 0;
  level._id_5A31 = 1;
  _id_5A31("GAMEPRINTSTARTFILE:");
}

_id_5A31(var_0) {
  level._id_5A3B++;

  if(level._id_5A3B > 200) {
    wait 0.05;
    level._id_5A3B = 0;
  }
}

_id_5A32(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_1) {
    _id_5A31("GAMEPRINTENDFILE:GAMEPRINTP4ENABLED:" + var_0);
  } else {
    _id_5A31("GAMEPRINTENDFILE:" + var_0);
  }

  var_2 = gettime() + 4000;

  while(getdvarint("#x3afb6d52ca49edc9c") == 0 && getDvar("#x34043b5f8f93fdc71") == "0" && gettime() < var_2) {
    wait 0.05;
  }

  if(!(gettime() < var_2)) {
    iprintlnbold("LAUNCHER_PRINT_FAIL:( TIMEOUT ): launcherconflict? restart launcher and try again? ");
    level._id_5A31 = undefined;
    return 0;
  }

  var_3 = getDvar("#x34043b5f8f93fdc71");

  if(var_3 != "0") {
    iprintlnbold("LAUNCHER_PRINT_FAIL:( " + var_3 + " ): launcherconflict? restart launcher and try again? ");
    level._id_5A31 = undefined;
    return 0;
  }

  iprintlnbold("Launcher write to file successful!");
  level._id_5A31 = undefined;
  return 1;
}

_id_90F3(var_0) {
  level._id_5A3B = 0;
  _id_5A31("LAUNCHER_CLIP:" + var_0);
}

_id_0EB3() {
  _id_06D4::_id_0EB4();
}

_id_67AA(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self.target;
  }

  var_1 = getent(var_0, "targetname");

  if(isDefined(var_1)) {
    return var_1;
  }

  if(scripts\common\utility::issp()) {
    var_1 = call[[level._id_6B9F]](var_0, "targetname");

    if(isDefined(var_1)) {
      return var_1;
    }

    var_1 = call[[level._id_6016["getspawner"]]](var_0, "targetname");

    if(isDefined(var_1)) {
      return var_1;
    }
  }

  var_1 = getstruct(var_0, "targetname");

  if(isDefined(var_1)) {
    return var_1;
  }

  var_1 = _func_00E5(var_0, "targetname");

  if(isDefined(var_1)) {
    return var_1;
  }
}

_id_6562() {
  return strtok(self._id_0399, " ");
}

_id_6556() {
  var_0 = [];

  if(isDefined(self._id_0399)) {
    var_1 = _id_6562();

    foreach(var_3 in var_1) {
      var_4 = getEntArray(var_3, "script_linkname");

      if(var_4.size > 0) {
        var_0 = array_combine(var_0, var_4);
      }
    }
  }

  return var_0;
}

_id_6555() {
  var_0 = _id_6556();
  return var_0[0];
}

_id_6557() {
  var_0 = [];

  if(isDefined(self._id_0399)) {
    var_1 = _id_6562();

    foreach(var_3 in var_1) {
      var_4 = _func_00B3(var_3, "script_linkname");

      if(var_4.size > 0) {
        var_0 = array_combine(var_0, var_4);
      }
    }
  }

  return var_0;
}

_id_4BF4(var_0, var_1) {
  var_2 = level._id_50EC[var_0];
  earthquake(var_2["magnitude"], var_2["duration"], var_1, var_2["radius"]);

  if(_func_03AC(level.earthquake_func)) {
    level thread[[level.earthquake_func]](var_0, var_1, var_2["magnitude"], var_2["duration"], var_2["radius"]);
  }
}

_id_B27F(var_0, var_1) {
  var_2 = spawn("script_origin", (0, 0, 0));

  if(!isDefined(var_1)) {
    var_1 = self.origin;
  }

  var_2.origin = var_1;
  var_2 playLoopSound(var_0);

  if(!_func_0205(var_0)) {
    var_2 delete();
  }

  return var_2;
}

_id_B2DC(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_origin", (0, 0, 1));

  if(!isDefined(var_1)) {
    var_1 = self.origin;
  }

  var_5.origin = var_1;
  var_5.angles = var_2;

  if(isDefined(var_4)) {
    var_5 linkto(var_4);
  }

  if(scripts\common\utility::issp()) {
    var_5 playSound(var_0, "sounddone");

    if(!_func_0205(var_0)) {
      var_5 delete();
      return;
    }

    var_5 waittill("sounddone");
  } else
    var_5 playSound(var_0);

  var_5 delete();
}

_id_B2DA(var_0, var_1, var_2, var_3) {
  _id_B2DC(var_0, var_1, (0, 0, 0), var_2, var_3);
}

_id_9820(var_0, var_1, var_2, var_3, var_4) {
  _id_9823(var_0, var_1, (0, 0, 0), var_2, var_3, var_4);
}

_id_9823(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(istrue(var_3)) {
    if(!isDefined(level._id_5BAF) || level._id_5BAF == 1) {
      _func_020F(var_0, var_1, var_2);
    }
  } else {
    var_7 = 0;

    if(level._id_3FD9 && isDefined(var_5._id_9845)) {
      var_8 = var_5._id_9845;
    } else {
      var_7 = 1;
      var_8 = spawn("script_origin", (0, 0, 0));
    }

    if(isDefined(var_4)) {
      thread _id_982A(var_4, var_8);
      self endon(var_4);
    }

    var_8.origin = var_1;
    var_8.angles = var_2;
    var_8 playLoopSound(var_0);

    if(!_func_0205(var_0) && var_7) {
      var_8 delete();
    } else {
      if(level._id_3FD9) {
        var_5._id_9845 = var_8;
        return;
      }

      var_8 _meth_845D();
    }
  }
}

_id_9821(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_9822(var_0, var_1, (0, 0, 0), var_2, var_3, var_4, var_5);
}

_id_9822(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self.origin = var_1;
  self.angles = var_2;

  if(isDefined(var_3)) {
    self endon(var_3);
  }

  if(var_5 >= var_6) {
    for(;;) {
      wait 0.05;
    }
  }

  if(!_func_0205(var_0)) {
    for(;;) {
      wait 0.05;
    }
  }

  for(;;) {
    wait(randomfloatrange(var_5, var_6));
    _id_96E1("createfx_looper");
    thread _id_B2DC(var_0, self.origin, self.angles, undefined);
    _id_F981("createfx_looper");
  }
}

_id_982A(var_0, var_1) {
  var_1 endon("death");
  self waittill(var_0);
  var_1 delete();
}

_id_400E(var_0) {
  var_1 = _id_06CE::_id_3FC5("loopfx", var_0);
  var_1.v["delay"] = _id_06CE::_id_6B1F();
  return var_1;
}

_id_4027(var_0) {
  var_1 = _id_06CE::_id_3FC5("oneshotfx", var_0);
  var_1.v["delay"] = _id_06CE::_id_6BCD();
  return var_1;
}

_id_3FC9(var_0, var_1) {
  var_2 = _id_06CE::_id_3FC5("exploder", var_0, var_1);
  var_2.v["delay"] = _id_06CE::_id_6A22();
  var_2.v["exploder_type"] = "normal";
  return var_2;
}

_id_B278(var_0, var_1) {
  var_2 = spawn("script_origin", (0, 0, 0));
  var_2 endon("death");
  thread _id_472E(var_2);

  if(isDefined(var_1)) {
    var_2.origin = self.origin + var_1;
    var_2.angles = self.angles;
    var_2 linkto(self);
  } else {
    var_2.origin = self.origin;
    var_2.angles = self.angles;
    var_2 linkto(self);
  }

  var_2 playLoopSound(var_0);

  if(!_func_0205(var_0)) {
    var_2 delete();
    return;
  }

  self waittill("stop sound" + var_0);
  var_2 stoploopsound(var_0);
  var_2 delete();
}

_id_E8B5(var_0) {
  self notify("stop sound" + var_0);
}

_id_472E(var_0) {
  var_0 endon("death");
  self waittill("death");

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_4739() {
  self waittill("sounddone");
  self delete();
}

_id_4736(var_0) {
  self waittill(var_0);
  self delete();
}

_id_5598(var_0) {
  waitframe();
}

_id_57BA(var_0, var_1, var_2) {
  [[level._id_0BF2._id_57CA]](var_0, var_1, var_2);
}

_id_4711(var_0) {
  _id_06D4::_id_4712(var_0);
}

_id_78AC(var_0) {
  _id_06D4::_id_78AD(var_0);
}

_id_DC3B(var_0) {
  _id_06D4::_id_DC3C(var_0);
}

_id_E893(var_0, var_1) {
  _id_06D4::_id_E894(var_0, var_1, 0);
}

_id_8D1F(var_0, var_1) {
  _id_06D4::_id_E894(var_0, var_1, 1);
}

_id_6493(var_0) {
  return _id_06D4::_id_6494(var_0);
}

ter_op(var_0, var_1, var_2) {
  if(var_0) {
    return var_1;
  }

  return var_2;
}

_id_3F35(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(level._id_96E1)) {
    level._id_96E1 = [];
  }

  var_2 = spawnStruct();
  var_2._id_9C0E = var_1;
  var_2._id_011A = 0;
  level._id_96E1[var_0] = var_2;
}

_id_96E1(var_0) {
  var_1 = level._id_96E1[var_0];

  while(var_1._id_011A >= var_1._id_9C0E) {
    var_1 waittill("unlocked");
  }

  var_1._id_011A++;
}

_id_F981(var_0) {
  thread _id_F987(var_0);
}

_id_F987(var_0) {
  wait 0.05;
  var_1 = level._id_96E1[var_0];
  var_1._id_011A--;
  var_1 notify("unlocked");
}

_id_F98A(var_0) {
  thread _id_F987(var_0);
  wait 0.05;
}

is_player_gamepad_enabled() {
  var_0 = self usinggamepad();

  if(isDefined(var_0)) {
    return var_0;
  } else if(self _meth_8685()) {
    return 0;
  } else {
    return 1;
  }
}

_id_4B8C(var_0, var_1) {
  return _func_0134(var_0 - var_1);
}

_id_636A(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_6369(var_0, var_1, var_2, var_3, var_4, var_5);
  var_6 = _id_1BD2(var_6);
  return var_6;
}

_id_6369(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_3)) {
    var_3 = var_1.size;
  }

  if(!isDefined(var_2)) {
    var_2 = [];
  }

  var_6 = undefined;

  if(isDefined(var_4)) {
    var_6 = var_4 * var_4;
  }

  var_7 = 0;

  if(isDefined(var_5)) {
    var_7 = var_5 * var_5;
  }

  if(var_2.size == 0 && var_3 >= var_1.size && var_7 == 0 && !isDefined(var_6)) {
    return _func_0204(var_1, var_0);
  }

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

  var_8 = _func_0204(var_8, var_0);

  if(var_3 >= var_8.size) {
    return var_8;
  }

  var_17 = [];

  for(var_18 = 0; var_18 < var_3; var_18++) {
    var_17[var_18] = var_8[var_18];
  }

  return var_17;
}

_id_E026(var_0, var_1) {
  for(var_2 = 1; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    for(var_4 = var_2 - 1; var_4 >= 0 && distancesquared(var_1, var_0[var_4]) >= distancesquared(var_1, var_3); var_4--) {
      var_0[var_4 + 1] = var_0[var_4];
    }

    var_0[var_4 + 1] = var_3;
  }

  return var_0;
}

_id_5000(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    var_1 = 1500;
  }

  if(!isDefined(var_2)) {
    var_2 = -12000;
  }

  if(!isDefined(var_4)) {
    var_4 = scripts\engine\trace::_id_3F70(1);
  }

  if(isDefined(var_3)) {
    return scripts\engine\trace::ray_trace(var_0 + var_1 * var_3, var_0 + var_2 * var_3, undefined, var_4)["position"];
  } else {
    return scripts\engine\trace::ray_trace(var_0 + (0, 0, var_1), var_0 + (0, 0, var_2), undefined, var_4)["position"];
  }
}

_id_B433(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = 1500;
  }

  if(!isDefined(var_3)) {
    var_3 = -12000;
  }

  var_5 = scripts\engine\trace::_id_3F70(1);

  if(isDefined(var_4)) {
    return scripts\engine\trace::_id_E409(var_0 + var_2 * var_4, var_0 + var_3 * var_4, var_1, undefined, var_5)["position"];
  } else {
    return scripts\engine\trace::_id_E409(var_0 + (0, 0, var_2), var_0 + (0, 0, var_3), var_1, undefined, var_5)["position"];
  }
}

_id_10E76(var_0, var_1, var_2, var_3) {
  var_4 = vectornormalize(var_2 - var_0);
  var_5 = anglesToForward(var_1);
  var_6 = vectordot(var_5, var_4);
  return var_6 >= var_3;
}

_id_122D(var_0) {
  if(isDefined(level._id_279D) && isDefined(level._id_279D["ai_3d_sighting_model"])) {
    return self[[level._id_279D["ai_3d_sighting_model"]]](var_0);
  }
}

_id_6969(var_0, var_1, var_2) {
  if(var_1.size == 0) {
    return undefined;
  }

  var_3 = _func_0204(var_1, var_0)[0];

  if(isDefined(var_2) && distancesquared(var_0, var_3.origin) > _func_0219(var_2)) {
    return undefined;
  }

  return var_3;
}

_id_9F67(var_0, var_1, var_2) {
  var_2 = ter_op(isDefined(var_2), var_2, (0, 0, 0));
  self missile_settargetent(var_0, var_2);

  switch (var_1) {
    case "direct":
      self _meth_8231();
      break;
    case "top":
      self _meth_8232();
      break;
  }
}

_id_0FDC(var_0, var_1) {
  if(!isDefined(level._effect)) {
    level._effect = [];
  }

  level._effect[var_0] = loadfx(var_1);
}

_id_3F1B(var_0, var_1) {
  if(!isDefined(level._id_6016)) {
    level._id_6016 = [];
  }

  level._id_6016[var_0] = var_1;
}

_id_3F04(var_0) {
  if(!isDefined(level._id_6016)) {
    level._id_6016 = [];
  }

  if(!isDefined(level._id_6016[var_0])) {
    _id_3F1B(var_0, ::_id_51C7);
  }
}

_id_602B(var_0) {
  return isDefined(level._id_6016) && isDefined(level._id_6016[var_0]);
}

_id_0FE2(var_0, var_1) {
  if(!isDefined(level._id_809F)) {
    level._id_809F = [];
  }

  if(isDefined(level._id_809F[var_0])) {
    return 0;
  }

  level._id_809F[var_0] = var_1;
  return 1;
}

_id_0FDA(var_0) {
  if(!isDefined(self._id_5F37)) {
    self._id_5F37 = [var_0];
    thread _id_BD4E();
  } else
    self._id_5F37[self._id_5F37.size] = var_0;
}

_id_BD4E() {
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    foreach(var_1 in self._id_5F37) {
      self thread[[var_1]]();
    }

    waitframe();
  }
}

delaythread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  thread _id_46E5(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

_id_46E5(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("stop_delay_thread");

  if(isent(self) && isPlayer(self)) {
    self endon("death_or_disconnect");
  } else {
    self endon("death");
  }

  wait(var_1);

  if(isDefined(var_8)) {
    thread[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  } else if(isDefined(var_7)) {
    thread[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
  } else if(isDefined(var_6)) {
    thread[[var_0]](var_2, var_3, var_4, var_5, var_6);
  } else if(isDefined(var_5)) {
    thread[[var_0]](var_2, var_3, var_4, var_5);
  } else if(isDefined(var_4)) {
    thread[[var_0]](var_2, var_3, var_4);
  } else if(isDefined(var_3)) {
    thread[[var_0]](var_2, var_3);
  } else if(isDefined(var_2)) {
    thread[[var_0]](var_2);
  } else {
    thread[[var_0]]();
  }
}

_id_430E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(self._id_0148)) {
    if(!isDefined(var_0)) {
      return 0;
    }

    if(self._id_0148 == var_0) {
      return 1;
    }

    if(!isDefined(var_1)) {
      return 0;
    }

    if(self._id_0148 == var_1) {
      return 1;
    }

    if(!isDefined(var_2)) {
      return 0;
    }

    if(self._id_0148 == var_2) {
      return 1;
    }

    if(!isDefined(var_3)) {
      return 0;
    }

    if(self._id_0148 == var_3) {
      return 1;
    }

    if(!isDefined(var_4)) {
      return 0;
    }

    if(self._id_0148 == var_4) {
      return 1;
    }

    if(!isDefined(var_5)) {
      return 0;
    }

    if(self._id_0148 == var_5) {
      return 1;
    }

    if(!isDefined(var_6)) {
      return 0;
    }

    if(self._id_0148 == var_6) {
      return 1;
    }

    if(!isDefined(var_7)) {
      return 0;
    }

    if(self._id_0148 == var_7) {
      return 1;
    }

    if(!isDefined(var_8)) {
      return 0;
    }

    if(self._id_0148 == var_8) {
      return 1;
    }

    if(!isDefined(var_9)) {
      return 0;
    }

    if(self._id_0148 == var_9) {
      return 1;
    }

    if(!isDefined(var_10)) {
      return 0;
    }

    if(self._id_0148 == var_10) {
      return 1;
    }
  }

  return _id_432E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

_id_432E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(self._id_42F8)) {
    return 0;
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  if(self._id_42F8 == var_0) {
    return 1;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  if(self._id_42F8 == var_1) {
    return 1;
  }

  if(!isDefined(var_2)) {
    return 0;
  }

  if(self._id_42F8 == var_2) {
    return 1;
  }

  if(!isDefined(var_3)) {
    return 0;
  }

  if(self._id_42F8 == var_3) {
    return 1;
  }

  if(!isDefined(var_4)) {
    return 0;
  }

  if(self._id_42F8 == var_4) {
    return 1;
  }

  if(!isDefined(var_5)) {
    return 0;
  }

  if(self._id_42F8 == var_5) {
    return 1;
  }

  if(!isDefined(var_6)) {
    return 0;
  }

  if(self._id_42F8 == var_6) {
    return 1;
  }

  if(!isDefined(var_7)) {
    return 0;
  }

  if(self._id_42F8 == var_7) {
    return 1;
  }

  if(!isDefined(var_8)) {
    return 0;
  }

  if(self._id_42F8 == var_8) {
    return 1;
  }

  if(!isDefined(var_9)) {
    return 0;
  }

  if(self._id_42F8 == var_9) {
    return 1;
  }

  if(!isDefined(var_10)) {
    return 0;
  }

  if(self._id_42F8 == var_10) {
    return 1;
  }

  return 0;
}

_id_8794(var_0) {
  switch (var_0) {
    case "MOD_HEAD_SHOT":
    case "MOD_PISTOL_BULLET":
    case "MOD_RIFLE_BULLET":
      return 1;
    default:
      return 0;
  }
}

_id_8AE7(var_0) {
  var_1 = self;
  var_2 = var_1 _meth_8186();

  foreach(var_4 in var_2) {
    if(var_4 == var_0) {
      return 1;
    }
  }

  return 0;
}

_id_690C(var_0) {
  var_1 = var_0 _meth_8187();

  if(var_1.size <= 0) {
    return undefined;
  }

  var_2 = 0;

  if(isDefined(self._id_0192)) {
    var_3 = self._id_0192.origin;

    if(_func_011D(self._id_0192) && self _meth_8205(self._id_0192) > 0) {
      var_3 = self _meth_8204(self._id_0192);
    }

    var_4 = vectortoangles(var_3 - var_0.origin);
    var_2 = _func_000B(var_4[1] - var_0.angles[1]);
  }

  foreach(var_6 in var_1) {
    switch (var_6) {
      case "Cover Stand":
      case "Cover Crouch":
        if(abs(var_2) < 30) {
          return var_6;
        }

        break;
      case "Cover Left Crouch":
      case "Cover Left":
        if(var_2 > 30) {
          return "Cover Left";
        }

        break;
      case "Cover Right Crouch":
      case "Cover Right":
        if(var_2 < -30) {
          return "Cover Right";
        }

        break;
      default:
    }
  }

  var_8 = var_1[0];

  switch (var_8) {
    case "Cover Left Crouch":
      return "Cover Left";
    case "Cover Right Crouch":
      return "Cover Right";
  }

  return var_8;
}

_id_8946(var_0) {
  return var_0.type == "Cover Left";
}

_id_8948(var_0) {
  return var_0.type == "Cover Right";
}

_id_8945(var_0, var_1) {
  if(var_0.type == "Cover Crouch" && isDefined(self._id_0B67._id_012D)) {
    return self._id_0B67._id_012D == var_1;
  }

  return 0;
}

_id_8942(var_0) {
  return _id_8943(var_0) || _id_8949(var_0);
}

_id_8943(var_0) {
  return var_0.type == "Cover Stand 3D" || var_0.type == "Cover 3D";
}

_id_8949(var_0) {
  return var_0.type == "Exposed 3D" || var_0.type == "Path 3D";
}

_id_8944(var_0) {
  return var_0.type == "Cover Crouch" || var_0.type == "Cover Crouch Window" || var_0.type == "Conceal Crouch";
}

_id_6896(var_0) {
  var_1 = _id_6EA0(var_0);
  var_2 = distance(self.origin, var_0);

  if(var_2 > 3) {
    var_3 = _func_0013(-3 / var_2);
    var_1 = var_1 - var_3;
  }

  var_1 = _func_000B(var_1);
  return var_1;
}

_id_6EA0(var_0) {
  if(_id_0F78()) {
    var_1 = anglesToForward(self.angles);
    var_2 = _func_01C6(var_1, var_0 - self.origin, self.angles[2] * -1);
    var_0 = var_2 + self.origin;
  }

  var_3 = _id_6E9B(var_0) - self.angles[1];
  var_3 = _func_000B(var_3);
  return var_3;
}

_id_6E9B(var_0) {
  return _func_0261(var_0 - self.origin);
}

_id_6897(var_0) {
  var_1 = _id_6EA1(var_0);
  var_2 = distance(self.origin, var_0);

  if(var_2 > 3) {
    var_3 = _func_0013(-3 / var_2);
    var_1 = var_1 - var_3;
  }

  var_1 = _func_000B(var_1);
  return var_1;
}

_id_6EA1(var_0) {
  var_1 = var_0 - self.origin;
  var_2 = _func_01C8(var_1, self.angles);
  var_3 = _func_0261(var_2);
  var_4 = _func_000B(var_3);
  return var_4;
}

_id_6894(var_0) {
  var_1 = _id_6C2E(var_0);
  var_2 = distance(self.origin, var_0);

  if(var_2 > 3) {
    var_3 = _func_0013(-3 / var_2);
    var_1 = var_1 - var_3;
  }

  var_1 = _func_000B(var_1);
  return var_1;
}

_id_6C2E(var_0) {
  var_1 = var_0 - self.origin;
  var_2 = _func_01C8(var_1, self.angles);
  var_3 = _func_0304(var_2);
  var_4 = _func_000B(var_3);
  return var_4;
}

_id_6C59(var_0) {
  var_1 = var_0 getplayerangles();
  return (var_1[0] + 360) % 360;
}

_id_6C72(var_0) {
  var_1 = var_0 getplayerangles();
  return (var_1[1] + 360) % 360;
}

_id_0F79() {
  return istrue(self._id_03E7);
}

_id_0F78() {
  return _id_0F79();
}

_id_6C82(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    if(!isDefined(var_2)) {
      return 0;
    }

    return _id_6896(var_2);
  }

  var_3 = (0, 0, 0);

  if(isPlayer(var_1)) {
    var_3 = var_1 getvelocity();
  } else if(isai(var_1)) {
    var_3 = var_1._id_04DF;
  }

  var_4 = var_1.origin + var_3 * var_0;
  return _id_6896(var_4);
}

_id_6C83(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    if(!isDefined(var_2)) {
      return 0;
    }

    return _id_6897(var_2);
  }

  var_3 = (0, 0, 0);

  if(isPlayer(var_1)) {
    var_3 = var_1 getvelocity();
  } else if(isai(var_1)) {
    var_3 = var_1._id_04DF;
  }

  var_4 = var_1.origin + var_3 * var_0;
  return _id_6897(var_4);
}

_id_6C81(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    if(!isDefined(var_2)) {
      return 0;
    }

    return _id_6894(var_2);
  }

  var_3 = (0, 0, 0);

  if(isPlayer(var_1)) {
    var_3 = var_1 getvelocity();
  } else if(isai(var_1)) {
    var_3 = var_1._id_04DF;
  }

  var_4 = var_1.origin + var_3 * var_0;
  return _id_6894(var_4);
}

is_equal(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1) && var_0 == var_1) {
    return 1;
  }

  return 0;
}

_id_B511() {
  return 0;
}

_id_D19F() {
  if(!isDefined(level._id_3FD9)) {
    level._id_3FD9 = getDvar("#x3ae2cde154e196de") != "";
  }
}

_id_5C1C(var_0, var_1, var_2) {
  wait(var_1);
  _id_5C1B(var_0, var_2);
}

_id_A5D6(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    foreach(var_6 in var_0) {
      call[[var_1]](var_6, var_2, var_3, var_4);
    }

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_6 in var_0) {
      call[[var_1]](var_6, var_2, var_3);
    }

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_6 in var_0) {
      call[[var_1]](var_6, var_2);
    }

    return;
  }

  foreach(var_6 in var_0) {
    call[[var_1]](var_6);
  }
}

_id_5C02(var_0) {}

_id_5C2B(var_0, var_1) {
  for(;;) {
    if(_id_5C00(var_0)) {
      return;
    }
    if(_id_5C00(var_1)) {
      return;
    }
    level _id_108C5(var_0, var_1);
  }
}

_id_5C2D(var_0, var_1) {
  for(;;) {
    if(_id_5C00(var_0)) {
      return var_0;
    }

    if(_id_5C00(var_1)) {
      return var_1;
    }

    var_2 = level _id_10897(var_0, var_1);
    return var_2;
  }
}

_id_5C27(var_0, var_1, var_2, var_3, var_4, var_5) {
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
    _id_5C2B(var_0, var_1);
    return;
  } else
    return;

  for(;;) {
    for(var_7 = 0; var_7 < var_6.size; var_7++) {
      if(_id_5C00(var_6[var_7])) {
        return;
      }
    }

    level _id_1087F(var_0, var_1, var_2, var_3, var_4, var_5);
  }
}

_id_5C32(var_0, var_1, var_2, var_3, var_4, var_5) {
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
    _id_5C34(var_0, var_1);
    return;
  } else
    return;

  for(;;) {
    for(var_7 = 0; var_7 < var_6.size; var_7++) {
      if(!_id_5C00(var_6[var_7])) {
        return;
      }
    }

    level _id_1087F(var_0, var_1, var_2, var_3, var_4, var_5);
  }
}

_id_5C2A(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = var_0 * 1000;
  var_8 = gettime();
  var_9 = [];

  if(isDefined(var_6)) {
    var_9[var_9.size] = var_1;
    var_9[var_9.size] = var_2;
    var_9[var_9.size] = var_3;
    var_9[var_9.size] = var_4;
    var_9[var_9.size] = var_5;
    var_9[var_9.size] = var_6;
  } else if(isDefined(var_5)) {
    var_9[var_9.size] = var_1;
    var_9[var_9.size] = var_2;
    var_9[var_9.size] = var_3;
    var_9[var_9.size] = var_4;
    var_9[var_9.size] = var_5;
  } else if(isDefined(var_4)) {
    var_9[var_9.size] = var_1;
    var_9[var_9.size] = var_2;
    var_9[var_9.size] = var_3;
    var_9[var_9.size] = var_4;
  } else if(isDefined(var_3)) {
    var_9[var_9.size] = var_1;
    var_9[var_9.size] = var_2;
    var_9[var_9.size] = var_3;
  } else if(isDefined(var_2)) {
    var_9[var_9.size] = var_1;
    var_9[var_9.size] = var_2;
  } else
    return;

  for(;;) {
    foreach(var_11 in var_9) {
      if(_id_5C00(var_11)) {
        return;
      }
    }

    var_13 = gettime();

    if(var_13 >= var_8 + var_7) {
      break;
    }

    var_14 = var_7 - (var_13 - var_8);
    var_15 = var_14 / 1000;
    _id_83DF(var_9, var_15);
  }
}

_id_83DF(var_0, var_1) {
  foreach(var_3 in var_0) {
    level endon(var_3);
  }

  wait(var_1);
}

_id_5C29(var_0, var_1, var_2, var_3, var_4) {
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
    var_6 = _id_5C2D(var_0, var_1);
    return var_6;
  } else
    return;

  for(;;) {
    for(var_7 = 0; var_7 < var_5.size; var_7++) {
      if(_id_5C00(var_5[var_7])) {
        return var_5[var_7];
      }
    }

    var_6 = level _id_1089A(var_0, var_1, var_2, var_3, var_4);
    return var_6;
  }
}

_id_5C28(var_0) {
  foreach(var_2 in var_0) {
    if(_id_5C00(var_2)) {
      return var_2;
    }
  }

  return level _id_10892(var_0);
}

_id_5C33(var_0) {
  foreach(var_2 in var_0) {
    if(!_id_5C00(var_2)) {
      return;
    }
  }

  for(;;) {
    foreach(var_2 in var_0) {
      if(!_id_5C00(var_2)) {
        return;
      }
    }

    level _id_10892(var_0);
  }

  return;
}

_id_5C25(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    _id_5C24(var_0);
  }

  if(isDefined(var_1)) {
    _id_5C24(var_1);
  }

  if(isDefined(var_2)) {
    _id_5C24(var_2);
  }

  if(isDefined(var_3)) {
    _id_5C24(var_3);
  }
}

_id_5C26(var_0) {
  var_0 = _id_1BD1(var_0);

  for(;;) {
    foreach(var_2 in var_0) {
      _id_5C24(var_2);
    }

    var_4 = 0;

    foreach(var_2 in var_0) {
      if(_id_5C00(var_2)) {
        var_4++;
      }
    }

    if(var_4 == var_0.size) {
      break;
    }
  }
}

_id_5C31(var_0) {
  var_0 = _id_1BD1(var_0);

  for(;;) {
    foreach(var_2 in var_0) {
      _id_5C30(var_2);
    }

    var_4 = 0;

    foreach(var_2 in var_0) {
      if(!_id_5C00(var_2)) {
        var_4++;
      }
    }

    if(var_4 == var_0.size) {
      break;
    }
  }
}

_id_5C2E(var_0, var_1) {
  var_2 = var_1 * 1000;
  var_3 = gettime();

  for(;;) {
    if(_id_5C00(var_0)) {
      break;
    }

    if(gettime() >= var_3 + var_2) {
      break;
    }

    var_4 = var_2 - (gettime() - var_3);
    var_5 = var_4 / 1000;
    _id_1070F(var_0, var_5);
  }
}

_id_5C2F(var_0, var_1) {
  var_2 = var_1 * 1000;
  var_3 = gettime();

  for(;;) {
    if(_id_5C00(var_0)) {
      return var_0;
    }

    if(gettime() >= var_3 + var_2) {
      return "timeout";
    }

    var_4 = var_2 - (gettime() - var_3);
    var_5 = var_4 / 1000;
    _id_1070F(var_0, var_5);
  }
}

_id_5C36(var_0, var_1) {
  var_2 = gettime();

  for(;;) {
    if(!_id_5C00(var_0)) {
      break;
    }

    if(gettime() >= var_2 + var_1 * 1000) {
      break;
    }

    _id_1070F(var_0, var_1);
  }
}

_id_5C37(var_0, var_1) {
  var_2 = gettime();

  for(;;) {
    if(!_id_5C00(var_0)) {
      return var_0;
    }

    if(gettime() >= var_2 + var_1 * 1000) {
      return "timeout";
    }

    _id_1070F(var_0, var_1);
  }
}

_id_1070F(var_0, var_1) {
  level endon(var_0);
  wait(var_1);
}

_id_5C34(var_0, var_1) {
  for(;;) {
    if(!_id_5C00(var_0)) {
      return var_0;
    }

    if(!_id_5C00(var_1)) {
      return var_1;
    }

    level _id_108C5(var_0, var_1);
  }
}

_id_5C35(var_0, var_1) {
  return _id_5C34(var_0, var_1);
}

_id_5C13(var_0, var_1) {
  level thread _id_83D4(var_0, var_1);
}

_id_83D4(var_0, var_1) {
  if(_func_0107(var_0)) {
    _id_5C26(var_0);
  } else {
    _id_5C24(var_0);
  }

  _id_5C1B(var_1);
}

_id_A5D7(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread _id_A5D8(var_1, var_0, var_2, var_3, var_4, var_5);
}

_id_A5D8(var_0, var_1, var_2, var_3, var_4, var_5) {
  wait(var_1);

  if(isDefined(var_5)) {
    call[[var_0]](var_2, var_3, var_4, var_5);
  } else if(isDefined(var_4)) {
    call[[var_0]](var_2, var_3, var_4);
  } else if(isDefined(var_3)) {
    call[[var_0]](var_2, var_3);
  } else if(isDefined(var_2)) {
    call[[var_0]](var_2);
  } else {
    call[[var_0]]();
  }
}

_id_67A9(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self.target;
  }

  var_1 = getEntArray(var_0, "targetname");

  if(var_1.size > 0) {
    return var_1;
  }

  if(scripts\common\utility::issp()) {
    var_1 = call[[level._id_6B9A]](var_0, "targetname");

    if(var_1.size > 0) {
      return var_1;
    }
  }

  var_1 = getStructArray(var_0, "targetname");

  if(var_1.size > 0) {
    return var_1;
  }

  var_1 = _func_00E6(var_0, "targetname");

  if(var_1.size > 0) {
    return var_1;
  }
}

_id_AF6A() {
  _id_06CE::_id_E89E();
}

_id_E1E9(var_0, var_1) {
  if(!isDefined(var_1) && isDefined(self.angles)) {
    var_1 = self.angles;
  }

  if(!isDefined(var_0) && isDefined(self.origin)) {
    var_0 = self.origin;
  } else if(!isDefined(var_0)) {
    var_0 = (0, 0, 0);
  }

  var_2 = spawn("script_origin", var_0);

  if(isDefined(var_1)) {
    var_2.angles = var_1;
  }

  return var_2;
}

_id_65F2(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");

  if(var_1.size > 0) {
    return var_1;
  }

  if(scripts\common\utility::issp()) {
    var_1 = call[[level._id_6B9A]](var_0, "script_noteworthy");

    if(var_1.size > 0) {
      return var_1;
    }
  }

  var_1 = getStructArray(var_0, "script_noteworthy");

  if(var_1.size > 0) {
    return var_1;
  }

  var_1 = _func_00E6(var_0, "script_noteworthy");

  if(var_1.size > 0) {
    return var_1;
  }
}

_id_6420(var_0) {
  var_1 = [];
  var_2 = 0;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_2 = var_2 + var_0[var_3];
    var_1[var_3] = var_2;
  }

  return var_1;
}

_id_10699() {}

_id_68BF(var_0) {
  return level._id_CC31[self._id_18AF][var_0];
}

_id_7535(var_0) {
  return isDefined(level._id_CC31[self._id_18AF][var_0]);
}

_id_68C0(var_0, var_1) {
  return level._id_CC31[var_1][var_0];
}

_id_68C1(var_0) {
  return level._id_CC31["generic"][var_0];
}

_id_7536(var_0) {
  return isDefined(level._id_CC31["generic"][var_0]);
}

_id_108E4(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3 endon("complete");
  var_3 delaythread(var_2, ::_id_D0AE, "complete");
  self waittillmatch(var_0, var_1);
}

_id_108E5(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3 endon("complete");
  var_3 delaythread(var_2, ::_id_D0AE, "complete");
  self waittill(var_0, var_1);
  return var_1;
}

_id_D0AE(var_0, var_1) {
  if(isDefined(var_1)) {
    self notify(var_0, var_1);
  } else {
    self notify(var_0);
  }
}

_id_65F1(var_0, var_1) {
  var_2 = _func_00BB(var_0, var_1);
  var_3 = _func_0079(var_0);
  return var_2[0] * var_3;
}

_id_A2AF(var_0) {
  return var_0 * 17.6;
}

_id_853A(var_0) {
  return var_0 * 0.056818;
}

_id_0FB8(var_0, var_1, var_2) {
  if(getdvarint("#x35daa86ede44c096", 0)) {
    return;
  }
  if(!isDefined(level._id_492F)) {
    level._id_492F = [];
  }

  if(level._id_492F.size == 5) {
    var_3 = level._id_492F[0];
    level._id_492F = array_remove_index(level._id_492F, 0);
    _id_FB5C();
    var_3 thread _id_4830();
  }

  var_4 = "^3";

  if(isDefined(var_2)) {
    switch (var_2) {
      case "red":
      case "r":
        var_4 = "^1";
        break;
      case "green":
      case "g":
        var_4 = "^2";
        break;
      case "yellow":
      case "y":
        var_4 = "^3";
        break;
      case "blue":
      case "b":
        var_4 = "^4";
        break;
      case "cyan":
      case "c":
        var_4 = "^5";
        break;
      case "purple":
      case "p":
        var_4 = "^6";
        break;
      case "white":
      case "w":
        var_4 = "^7";
        break;
      case "black":
      case "bl":
        var_4 = "^8";
        break;
    }
  }

  var_5 = 1;

  if(isDefined(level._id_4963)) {
    var_5 = level._id_4963;
  }

  var_6 = newhudelem();
  var_6.elemtype = "font";
  var_6.font = "default";
  var_6.fontscale = var_5;
  var_6.x = 0;
  var_6.y = 0;
  var_6.width = 0;
  var_6.height = int(level.fontheight * var_5);
  var_6.xoffset = 0;
  var_6.yoffset = 0;
  var_7 = level._id_492F.size;
  level._id_492F[var_7] = var_6;
  var_6._id_01D6 = 1;
  var_6.sort = 20;
  var_6.x = 40;
  var_6.y = 260 + var_7 * (12 * var_5);
  var_6.label = "" + var_4 + var_0 + ": ^7" + var_1;
  var_6.alpha = 0;
  var_6 fadeovertime(0.2);
  var_6.alpha = 1;
  var_6 endon("death");
  wait 8;
  level._id_492F = array_remove(level._id_492F, var_6);
  _id_FB5C();
  var_6 thread _id_4830();
}

_id_4830() {
  var_0 = 1;

  if(isDefined(level._id_4963)) {
    var_0 = level._id_4963;
  }

  self endon("death");
  self fadeovertime(0.2);
  self moveovertime(0.2);
  self.y = self.y - 12 * var_0;
  self.alpha = 0;
  wait 0.2;
  self destroy();
}

_id_FB5C() {
  var_0 = 1;

  if(isDefined(level._id_4963)) {
    var_0 = level._id_4963;
  }

  level._id_492F = _id_1BD1(level._id_492F);

  foreach(var_3, var_2 in level._id_492F) {
    var_2 moveovertime(0.2);
    var_2.y = 260 + var_3 * 12 * var_0;
  }
}

_id_39ED(var_0, var_1, var_2, var_3) {
  var_4 = var_0 - var_2;
  var_5 = var_3 - var_2;

  if(abs(var_5[0]) < 0.000001 && abs(var_5[1]) < 0.000001 && abs(var_5[2]) < 0.000001) {
    return undefined;
  }

  var_6 = var_1 - var_0;

  if(abs(var_6[0]) < 0.000001 && abs(var_6[1]) < 0.000001 && abs(var_6[2]) < 0.000001) {
    return undefined;
  }

  var_7 = var_4[0] * var_5[0] + var_4[1] * var_5[1] + var_4[2] * var_5[2];
  var_8 = var_5[0] * var_6[0] + var_5[1] * var_6[1] + var_5[2] * var_6[2];
  var_9 = var_4[0] * var_6[0] + var_4[1] * var_6[1] + var_4[2] * var_6[2];
  var_10 = var_5[0] * var_5[0] + var_5[1] * var_5[1] + var_5[2] * var_5[2];
  var_11 = var_6[0] * var_6[0] + var_6[1] * var_6[1] + var_6[2] * var_6[2];
  var_12 = var_11 * var_10 - var_8 * var_8;

  if(abs(var_12) < 0.000001) {
    return undefined;
  }

  var_13 = var_7 * var_8 - var_9 * var_10;
  var_14 = var_13 / var_12;
  var_15 = (var_7 + var_8 * var_14) / var_10;
  var_16 = var_0 + var_14 * var_6;
  var_17 = var_2 + var_15 * var_5;
  var_18 = [var_16, var_17, distance(var_16, var_17)];
  return var_18;
}

_id_39EE(var_0, var_1, var_2, var_3) {
  var_4 = var_1 - var_0;
  var_5 = var_3 - var_2;
  var_6 = var_0 - var_2;
  var_7 = vectordot(var_4, var_4);
  var_8 = vectordot(var_4, var_5);
  var_9 = vectordot(var_5, var_5);
  var_10 = vectordot(var_4, var_6);
  var_11 = vectordot(var_5, var_6);
  var_12 = var_7 * var_9 - var_8 * var_8;
  var_13 = var_12;
  var_14 = var_12;
  var_15 = 0;
  var_16 = 0;
  var_17 = 0;
  var_18 = 0;

  if(var_12 < 0.00000001) {
    var_16 = 0;
    var_13 = 1;
    var_18 = var_11;
    var_14 = var_9;
  } else {
    var_16 = var_8 * var_11 - var_9 * var_10;
    var_18 = var_7 * var_11 - var_8 * var_10;

    if(var_16 < 0.0) {
      var_16 = 0;
      var_18 = var_11;
      var_14 = var_9;
    } else if(var_16 > var_13) {
      var_16 = var_13;
      var_18 = var_11 + var_8;
      var_14 = var_9;
    }
  }

  if(var_18 < 0.0) {
    var_18 = 0.0;

    if(var_10 * -1 < 0.0) {
      var_16 = 0.0;
    } else if(var_10 * -1 > var_7) {
      var_16 = var_13;
    } else {
      var_16 = var_10 * -1;
      var_13 = var_7;
    }
  } else if(var_18 > var_14) {
    var_18 = var_14;

    if(var_8 - var_10 < 0.0) {
      var_16 = 0;
    } else if(var_8 - var_10 > var_7) {
      var_16 = var_13;
    } else {
      var_16 = var_8 - var_10;
      var_13 = var_7;
    }
  }

  if(abs(var_16) > 0.00000001) {
    var_15 = var_16 / var_13;
  }

  if(abs(var_18) > 0.00000001) {
    var_17 = var_18 / var_14;
  }

  var_19 = var_0 + var_15 * var_4;
  var_20 = var_2 + var_17 * var_5;
  var_21 = [var_19, var_20, distance(var_19, var_20)];
  return var_21;
}

_id_8599() {
  return _func_011D(self) && !isalive(self);
}

hastag(var_0, var_1) {
  if(!isDefined(var_0) || var_0 == "") {
    return 0;
  }

  if(!isDefined(level._id_7526)) {
    level._id_7526 = [];
  }

  var_2 = var_0 + "_" + var_1;

  if(isDefined(level._id_7526[var_2])) {
    return level._id_7526[var_2];
  }

  var_3 = _func_00BC(var_0);

  if(var_3 > 0) {
    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = tolower(_func_00BF(var_0, var_4));

      if(var_5 == tolower(var_1)) {
        level._id_7526[var_2] = 1;
        return 1;
      }
    }

    level._id_7526[var_2] = 0;
  }

  return 0;
}

_id_5C98() {
  var_0 = self._id_5CA2 - gettime();

  if(var_0 < 0) {
    return 0;
  }

  return var_0 * 0.001;
}

_id_5C9B() {
  return _id_5C98() > 0;
}

_id_B414() {
  return getdvarint("#x3fa9da971d3f2a35d", "0");
}

_id_EA52(var_0) {
  return "" + var_0;
}

_id_B8F2(var_0, var_1, var_2, var_3, var_4) {
  [[level._id_5DB4]](var_0, var_1, var_2, var_3, var_4);
}

_id_B8F0(var_0, var_1) {
  [[level._id_5DB2]](var_0, var_1);
}

set_movement_speed(var_0) {
  self._id_0B67._id_C573 = var_0;
  self _meth_85E2(var_0);
}

_id_D181(var_0) {
  self._id_00DD = var_0;
}

_id_D17A(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "cover_bounding_overwatch";
  }

  self._id_009F = var_0;
  self._id_0159 = var_1;
}

_id_A1BC(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_3)) {
    var_7 = _func_00BB(var_0, var_3)[0];

    if(!isDefined(var_7)) {
      var_7 = 0;
    }
  } else
    var_7 = 0;

  if(isDefined(var_4)) {
    var_8 = _func_00BB(var_0, var_4)[0];

    if(!isDefined(var_8)) {
      var_8 = 1;
    }
  } else
    var_8 = 1;

  return _id_A1BD(var_0, var_1, var_2, var_7, var_8, var_5, var_6);
}

_id_A1BD(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_6)) {
    var_6 = 1;
  }

  var_7 = _func_0077(var_0, var_3, var_4);
  var_8 = _func_00B0(var_0, var_3, var_4);
  var_8 = rotatevector(var_8, (0, var_2[1] - var_7, 0));
  var_9 = var_1 - var_8;
  var_10 = var_2[1] - var_7;
  var_11 = (var_2[0], var_10, var_2[2]);
  var_12 = 1.0;
  var_13 = length(var_1 - self.origin);

  if(var_6 && var_13 > 0) {
    var_12 = length(var_8) / var_13;
    var_12 = clamp(var_12, 0.8, 2.0);

    if(isai(self)) {
      self _meth_85F5(var_0, var_12);
    } else {
      self _meth_82E8(var_0, var_12);
    }
  }

  if(!isDefined(var_5)) {
    var_14 = _func_0079(var_0) / var_12;
    var_5 = int((var_4 - var_3) * var_14 * 1000);
  }

  if(var_5 < 50) {
    var_5 = 50;
  }

  self _meth_85FB(var_9, var_11, var_1, var_2, var_5);
  return var_12;
}

_id_1088B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16) {
  self endon("death");
  var_17 = spawnStruct();
  var_1 childthread _id_10927(var_2, var_17);

  if(isDefined(var_3) && isDefined(var_4)) {
    var_3 childthread _id_10927(var_4, var_17);
  }

  if(isDefined(var_5) && isDefined(var_6)) {
    var_5 childthread _id_10927(var_6, var_17);
  }

  if(isDefined(var_7) && isDefined(var_8)) {
    var_7 childthread _id_10927(var_8, var_17);
  }

  if(isDefined(var_9) && isDefined(var_10)) {
    var_9 childthread _id_10927(var_10, var_17);
  }

  if(isDefined(var_11) && isDefined(var_12)) {
    var_11 childthread _id_10927(var_12, var_17);
  }

  if(isDefined(var_13) && isDefined(var_14)) {
    var_13 childthread _id_10927(var_14, var_17);
  }

  if(isDefined(var_15) && isDefined(var_16)) {
    var_15 childthread _id_10927(var_16, var_17);
  }

  var_17 childthread _id_0D95(var_0);
  var_17 waittill("returned", var_18);
  var_17 notify("die");
  return var_18;
}

_id_F1EB(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return gettime() - var_0 >= var_1 * 1000;
}

_id_C09C(var_0) {
  self._id_9499 = var_0;
  self._id_949A = gettime();
}

_id_D4E9(var_0) {
  switch (var_0) {
    case "right":
      self._id_3DD8 = "Cover Right Crouch";
      break;
    case "left":
      self._id_3DD8 = "Cover Left Crouch";
      break;
    case "crouch":
    default:
      self._id_3DD8 = "Cover Crouch";
  }
}

_id_D4E5(var_0) {
  self._id_3D76 = var_0;
}

_id_6984() {
  if(isDefined(self._id_3D76)) {
    return self._id_3D76;
  }

  return 0;
}

_id_30FE(var_0, var_1, var_2, var_3) {
  if(isent(self) || isai(self)) {
    var_4 = [self, var_1];
  } else {
    var_4 = [var_1];
  }

  if(isDefined(var_2)) {
    var_4 = array_combine(var_4, var_2);
  }

  if(scripts\engine\trace::ray_trace_passed(var_0, var_1.origin, var_4, var_3)) {
    return 1;
  }

  if(scripts\engine\trace::ray_trace_passed(var_0, var_1 gettagorigin("j_spine4"), var_4, var_3)) {
    return 1;
  }

  if(scripts\engine\trace::ray_trace_passed(var_0, var_1 getEye(), var_4, var_3)) {
    return 1;
  }

  return 0;
}

_id_1BCC(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = [];

  foreach(var_4 in var_0) {
    if(!isalive(var_4)) {
      continue;
    }
    if(isai(var_4) && var_1 && var_4._id_017C) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_1BCE(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = [];

  foreach(var_4 in var_0) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(!isalive(var_4)) {
      continue;
    }
    if(isai(var_4) && var_1 && var_4._id_017C) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_4A32() {
  self._id_0DDF._id_4AD8 = 1;
  self._id_0043 = 0;
}

_id_5212() {
  self._id_0DDF._id_4AD8 = 0;
  self._id_0043 = 1;
}

_id_6312() {
  if(!isDefined(self._id_F94F)) {
    _id_D13A();
  }

  return self._id_F94F;
}

_id_D13A() {
  if(!isDefined(level._id_12BD)) {
    level._id_12BD = 0;
  }

  self._id_F94F = "ai" + level._id_12BD;
  level._id_12BD++;
}

_id_5476(var_0) {
  while(isDefined(self) && !_id_546E(var_0)) {
    self waittill(var_0);
  }
}

_id_1BA8(var_0, var_1) {
  var_2 = spawnStruct();

  foreach(var_4 in var_0) {
    if(var_4 _id_546E(var_1)) {
      var_0 = array_remove(var_0, var_4);
    }
  }

  _id_1BE2(var_0, ::_id_1BA9, var_2, var_1);

  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    var_2 waittill("notify");
  }
}

_id_1BA9(var_0, var_1) {
  _id_5476(var_1);
  var_0 notify("notify");
}

_id_547A(var_0) {
  while(isDefined(self) && !_id_546E(var_0)) {
    self waittill(var_0);
  }
}

_id_5478(var_0, var_1) {
  while(isDefined(self)) {
    if(_id_546E(var_0)) {
      return;
    }
    if(_id_546E(var_1)) {
      return;
    }
    _id_108C5(var_0, var_1);
  }
}

_id_5477(var_0) {
  var_0 = _id_1BD1(var_0);

  for(;;) {
    foreach(var_2 in var_0) {
      _id_5476(var_2);
    }

    var_4 = 0;

    foreach(var_2 in var_0) {
      if(_id_546E(var_2)) {
        var_4++;
      }
    }

    if(var_4 == var_0.size) {
      break;
    }
  }
}

_id_547C(var_0) {
  var_0 = _id_1BD1(var_0);

  for(;;) {
    foreach(var_2 in var_0) {
      _id_547B(var_2);
    }

    var_4 = 0;

    foreach(var_2 in var_0) {
      if(!_id_546E(var_2)) {
        var_4++;
      }
    }

    if(var_4 == var_0.size) {
      break;
    }
  }
}

_id_547D(var_0) {
  var_0 = _id_1BD1(var_0);

  while(isDefined(self)) {
    foreach(var_2 in var_0) {
      if(!_id_546E(var_2)) {
        return;
      }
    }

    _id_10892(var_0);
  }
}

_id_5479(var_0, var_1) {
  var_2 = gettime();

  while(isDefined(self)) {
    if(_id_546E(var_0)) {
      break;
    }

    if(gettime() >= var_2 + var_1 * 1000) {
      break;
    }

    _id_5484(var_0, var_1);
  }
}

_id_5484(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

_id_547B(var_0) {
  while(isDefined(self) && _id_546E(var_0)) {
    self waittill(var_0);
  }
}

_id_546F(var_0) {}

_id_547E(var_0, var_1) {
  while(isDefined(self)) {
    if(!_id_546E(var_0)) {
      return;
    }
    if(!_id_546E(var_1)) {
      return;
    }
    _id_108C5(var_0, var_1);
  }
}

_id_5473(var_0) {
  if(!isDefined(self._id_546E)) {
    self._id_546E = [];
    self._id_547F = [];
  }

  self._id_546E[var_0] = 0;
}

_id_5472(var_0) {
  if(isDefined(self._id_546E) && isDefined(self._id_546E[var_0])) {
    return 1;
  }

  return 0;
}

_id_5475(var_0, var_1) {
  self endon("death");
  wait(var_1);
  _id_5474(var_0);
}

_id_5474(var_0) {
  if(!_id_5472(var_0)) {
    _id_5473(var_0);
  }

  self._id_546E[var_0] = 1;
  self notify(var_0);
}

_id_5470(var_0, var_1) {
  if(_id_546E(var_0)) {
    self._id_546E[var_0] = 0;
    self notify(var_0);
  }

  if(_id_5472(var_0) && istrue(var_1)) {
    self._id_546E[var_0] = undefined;
  }
}

_id_5471(var_0, var_1) {
  wait(var_1);

  if(isDefined(self)) {
    _id_5470(var_0);
  }
}

_id_546E(var_0) {
  return _id_5472(var_0) && self._id_546E[var_0];
}

_id_655C() {
  var_0 = [];

  if(isDefined(self._id_0399)) {
    var_1 = _id_6562();

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = getStructArray(var_1[var_2], "script_linkname");

      if(var_3.size > 0) {
        var_0 = array_combine(var_0, var_3);
      }
    }
  }

  return var_0;
}

_id_89BA(var_0, var_1, var_2) {
  if(_func_0219(var_0[0] - var_1[0]) + _func_0219(var_0[1] - var_1[1]) <= _func_0219(var_2)) {
    return 1;
  }

  return 0;
}

_id_C578(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self _meth_87A0(var_0);

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 == "gamerprofile_request") {
      return var_2;
    }
  }
}

_id_8936() {
  var_0 = 1;
  var_1 = 0;

  if(is_player_gamepad_enabled()) {
    var_1 = _id_C578("mountButtonConfig");
  } else {
    var_1 = _id_C578("mountButtonConfigKBM");
  }

  return var_1 != var_0;
}

_id_6AC7(var_0) {
  if(_func_02B7(var_0)) {
    return int(var_0);
  } else {
    return 0;
  }
}

_id_EA60(var_0) {
  var_1 = (0, 0, 0);
  var_2 = strtok(var_0, " ");

  if(var_2.size == 3) {
    var_1 = (float(var_2[0]), float(var_2[1]), float(var_2[2]));
  }

  return var_1;
}

_id_5AB3(var_0, var_1, var_2, var_3) {
  var_4 = "";

  if(!issubstr(var_0, var_2)) {
    return var_0;
  }

  if(!issubstr(var_0, var_1)) {
    return var_0;
  }

  var_5 = strtok(var_0, var_1);

  if(var_5.size == 1) {
    return var_0;
  }

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    if(var_5[var_6] == var_2) {
      var_4 = var_4 + var_3;
    } else {
      var_4 = var_4 + var_5[var_6];
    }

    if(isDefined(var_5[var_6 + 1])) {
      var_4 = var_4 + var_1;
    }
  }

  return var_4;
}

_id_636C(var_0) {
  if(!isDefined(var_0)) {
    return [];
  }

  var_1 = [];
  var_2 = strtok(var_0, ",", 1);
  var_1 = var_2;

  if(var_2.size > 0) {
    foreach(var_5, var_4 in var_2) {
      if(isDefined(var_4)) {
        if(_id_86D6(var_4)) {
          var_1[var_5] = float(var_4);
          continue;
        }

        var_1[var_5] = undefined;
      }
    }
  }

  return var_1;
}

_id_86D6(var_0) {
  var_1 = float(var_0);

  if(_func_010D(var_0, " ")) {
    while(_func_010D(var_0, " ")) {
      var_0 = _func_0442(var_0, " ");
    }
  }

  if(_func_010C(var_0, " ")) {
    while(_func_010C(var_0, " ")) {
      var_0 = _func_0441(var_0, " ");
    }
  }

  if(_func_010D(var_0, ".")) {
    var_0 = "0" + var_0;
  }

  if(_func_010D(var_0, "-.")) {
    var_0 = _func_0442(var_0, "-.");
    var_0 = "-0." + _id_EA52(var_0);
  }

  if(issubstr(var_0, ".")) {
    while(_func_010C(var_0, "0")) {
      var_0 = _func_0441(var_0, "0");
    }
  }

  if(_func_010C(var_0, ".")) {
    var_0 = _func_0441(var_0, ".");
  } else {
    var_0 = _id_EA52(var_0);
  }

  return _id_EA52(var_1) == var_0;
}

_id_BCEA(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");

  if(isDefined(var_3)) {
    self endon(var_3);
    level endon(var_3);
  } else
    self endon("print3d_end");

  if(!isDefined(var_4)) {
    var_4 = 64;
  }

  if(!isDefined(var_5)) {
    var_5 = 0.75;
  }

  var_6 = 0;

  if(isDefined(var_2)) {
    var_6 = var_2 * 1000;
  }

  var_7 = gettime();

  for(;;) {
    var_8 = gettime();

    if(isDefined(var_2) && var_8 - var_7 >= var_6) {
      break;
    }

    waitframe();
  }
}

_id_5097(var_0, var_1) {
  var_0 = tolower(var_0);
  setdvarifuninitialized(var_0, var_1);
}

_id_DD5B(var_0, var_1, var_2) {
  _id_0CFF(var_0, var_1, undefined, undefined, var_2);
}

_id_DD5C(var_0, var_1, var_2, var_3) {
  _id_0CFF(var_0, var_1, var_2, undefined, var_3);
}

_id_DD5D(var_0, var_1, var_2, var_3, var_4) {
  _id_0CFF(var_0, var_1, var_2, var_3, var_4);
}

_id_0CFF(var_0, var_1, var_2, var_3, var_4) {
  var_4 = _id_0B99(var_4);

  if(!_func_03AC(var_1)) {
    return;
  }
  if(isDefined(var_3)) {
    switch (var_4.size) {
      case 8:
        var_0 thread[[var_1]](var_2, var_3, var_4[0], var_4[1], var_4[2], var_4[3], var_4[4], var_4[5], var_4[6], var_4[7]);
        break;
      case 7:
        var_0 thread[[var_1]](var_2, var_3, var_4[0], var_4[1], var_4[2], var_4[3], var_4[4], var_4[5], var_4[6]);
        break;
      case 6:
        var_0 thread[[var_1]](var_2, var_3, var_4[0], var_4[1], var_4[2], var_4[3], var_4[4], var_4[5]);
        break;
      case 5:
        var_0 thread[[var_1]](var_2, var_3, var_4[0], var_4[1], var_4[2], var_4[3], var_4[4]);
        break;
      case 4:
        var_0 thread[[var_1]](var_2, var_3, var_4[0], var_4[1], var_4[2], var_4[3]);
        break;
      case 3:
        var_0 thread[[var_1]](var_2, var_3, var_4[0], var_4[1], var_4[2]);
        break;
      case 2:
        var_0 thread[[var_1]](var_2, var_3, var_4[0], var_4[1]);
        break;
      case 1:
        var_0 thread[[var_1]](var_2, var_3, var_4[0]);
        break;
      case 0:
        var_0 thread[[var_1]](var_2, var_3);
        break;
      default:
    }
  } else if(isDefined(var_2)) {
    switch (var_4.size) {
      case 8:
        var_0 thread[[var_1]](var_2, var_4[0], var_4[1], var_4[2], var_4[3], var_4[4], var_4[5], var_4[6], var_4[7]);
        break;
      case 7:
        var_0 thread[[var_1]](var_2, var_4[0], var_4[1], var_4[2], var_4[3], var_4[4], var_4[5], var_4[6]);
        break;
      case 6:
        var_0 thread[[var_1]](var_2, var_4[0], var_4[1], var_4[2], var_4[3], var_4[4], var_4[5]);
        break;
      case 5:
        var_0 thread[[var_1]](var_2, var_4[0], var_4[1], var_4[2], var_4[3], var_4[4]);
        break;
      case 4:
        var_0 thread[[var_1]](var_2, var_4[0], var_4[1], var_4[2], var_4[3]);
        break;
      case 3:
        var_0 thread[[var_1]](var_2, var_4[0], var_4[1], var_4[2]);
        break;
      case 2:
        var_0 thread[[var_1]](var_2, var_4[0], var_4[1]);
        break;
      case 1:
        var_0 thread[[var_1]](var_2, var_4[0]);
        break;
      case 0:
        var_0 thread[[var_1]](var_2);
        break;
      default:
    }
  } else {
    switch (var_4.size) {
      case 8:
        var_0 thread[[var_1]](var_4[0], var_4[1], var_4[2], var_4[3], var_4[4], var_4[5], var_4[6], var_4[7]);
        break;
      case 7:
        var_0 thread[[var_1]](var_4[0], var_4[1], var_4[2], var_4[3], var_4[4], var_4[5], var_4[6]);
        break;
      case 6:
        var_0 thread[[var_1]](var_4[0], var_4[1], var_4[2], var_4[3], var_4[4], var_4[5]);
        break;
      case 5:
        var_0 thread[[var_1]](var_4[0], var_4[1], var_4[2], var_4[3], var_4[4]);
        break;
      case 4:
        var_0 thread[[var_1]](var_4[0], var_4[1], var_4[2], var_4[3]);
        break;
      case 3:
        var_0 thread[[var_1]](var_4[0], var_4[1], var_4[2]);
        break;
      case 2:
        var_0 thread[[var_1]](var_4[0], var_4[1]);
        break;
      case 1:
        var_0 thread[[var_1]](var_4[0]);
        break;
      case 0:
        var_0 thread[[var_1]]();
        break;
      default:
    }
  }
}

_id_DD57(var_0, var_1, var_2) {
  return _id_0CFE(var_0, var_1, var_2);
}

_id_0CFE(var_0, var_1, var_2) {
  var_2 = _id_0B99(var_2);

  switch (var_2.size) {
    case 8:
      if(isDefined(var_0)) {
        return var_0[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6], var_2[7]);
      } else {
        return [[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6], var_2[7]);
      }

      break;
    case 7:
      if(isDefined(var_0)) {
        return var_0[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6]);
      } else {
        return [[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6]);
      }

      break;
    case 6:
      if(isDefined(var_0)) {
        return var_0[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5]);
      } else {
        return [[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5]);
      }

      break;
    case 5:
      if(isDefined(var_0)) {
        return var_0[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
      } else {
        return [[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
      }

      break;
    case 4:
      if(isDefined(var_0)) {
        return var_0[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3]);
      } else {
        return [[var_1]](var_2[0], var_2[1], var_2[2], var_2[3]);
      }

      break;
    case 3:
      if(isDefined(var_0)) {
        return var_0[[var_1]](var_2[0], var_2[1], var_2[2]);
      } else {
        return [[var_1]](var_2[0], var_2[1], var_2[2]);
      }

      break;
    case 2:
      if(isDefined(var_0)) {
        return var_0[[var_1]](var_2[0], var_2[1]);
      } else {
        return [[var_1]](var_2[0], var_2[1]);
      }

      break;
    case 1:
      if(isDefined(var_0)) {
        return var_0[[var_1]](var_2[0]);
      } else {
        return [[var_1]](var_2[0]);
      }

      break;
    case 0:
      if(isDefined(var_0)) {
        return var_0[[var_1]]();
      } else {
        return [[var_1]]();
      }

      break;
    default:
  }
}

_id_0B99(var_0) {
  var_1 = -1;

  for(var_2 = var_0.size - 1; var_2 >= 0; var_2--) {
    if(!isDefined(var_0[var_2])) {
      var_1 = var_2;
      continue;
    }

    break;
  }

  if(var_1 == -1) {
    return var_0;
  }

  var_3 = [];

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3[var_2] = var_0[var_2];
  }

  return var_3;
}

vtos(var_0) {
  return "(" + int(var_0[0]) + " " + int(var_0[1]) + " " + int(var_0[2]) + ")";
}

_id_FF6C(var_0, var_1) {
  if(isDefined(var_0) == 1) {
    return var_0;
  }

  return var_1;
}

_id_BD12(var_0, var_1) {
  if(_func_0121(var_0)) {
    return var_0;
  }

  var_1 = _id_FF6C(var_1, 0);
  var_1 = int(min(var_1, 6));
  var_2 = int(var_0 + 0.0001);
  var_3 = _func_0438(var_0 - var_2, 0.0001);

  switch (var_1) {
    case 0:
      return "" + var_2;
    case 1:
      var_3 = int(var_3 * 10);
      break;
    case 2:
      var_3 = int(var_3 * 100);
      break;
    case 3:
      var_3 = int(var_3 * 1000);
      break;
    case 4:
      var_3 = int(var_3 * 10000);
      break;
    case 5:
      var_3 = int(var_3 * 10000);
      break;
    case 6:
    default:
      var_3 = int(var_3 * 100000);
      break;
  }

  var_4 = var_3 + "";
  var_5 = var_1 - var_4.size;

  if(var_5 >= 1) {
    for(var_6 = var_5; var_6 > 0; var_6--) {
      var_4 = var_4 + "0";
    }
  }

  var_7 = var_2 + "." + var_4;
  return var_7;
}