/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 17.gsc
*************************************************/

_id_0106() {
  if(getDvar("#x3a8fb0620196c6263") == "1") {
    level waittill("eternity");
  }

  if(!isDefined(level._id_60F6) || !level._id_60F6) {
    [[level._id_2F59]]();
    level._id_60F6 = 1;
  }
}

_id_00F9() {
  if(getDvar("#x3a8fb0620196c6263") == "1") {
    level waittill("eternity");
  }

  self endon("disconnect");

  if(isDefined(level._id_2F4A)) {
    [[level._id_2F4A]]();
  }
}

_id_00FA() {
  if(getDvar("#x3a8fb0620196c6263") == "1") {
    level waittill("eternity");
  }

  self endon("disconnect");
  [[level._id_2F4B]]();
}

_id_00FC(var_0) {
  self notify("disconnect");
  self notify("death_or_disconnect");
  self._id_8801 = 1;
  [[level._id_2F4D]](var_0);
}

_id_00FB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  self endon("disconnect");

  if(isDefined(level._id_10DB1)) {
    var_5 = [[level._id_10DB1]](var_5, var_0);
  }

  [[level._id_2F4C]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
}

_id_00FD(var_0, var_1) {
  self endon("disconnect");

  if(isDefined(level._id_10DB1)) {
    [[level._id_10DB1]](var_0);
    [[level._id_10DB1]](var_1);
  }

  if(isDefined(level._id_2F46)) {
    [[level._id_2F46]](var_1, var_0, var_1._id_0245, var_0._id_0245);
  }
}

_id_00FE(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("disconnect");

  if(isDefined(level._id_10DB1)) {
    [[level._id_10DB1]](var_1);
  }

  [[level._id_2F4E]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_00FF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self endon("disconnect");

  if(isDefined(level._id_10DB1)) {
    [[level._id_10DB1]](var_5, var_0);
  }

  [[level._id_2F4F]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

_id_0107(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(isDefined(self._id_A74B)) {
    var_14 = [[self._id_A74B]](var_1);

    if(isDefined(var_14) && var_14) {
      return;
    }
  }

  if(isDefined(level._id_10DB1)) {
    var_5 = [[level._id_10DB1]](var_5, var_0);
  }

  if(isDefined(self._id_42E9)) {
    self[[self._id_42E9]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
  } else if(isDefined(level._id_1032B) && isDefined(level._id_1032B._id_42E9) && isDefined(self._id_1031E)) {
    self[[level._id_1032B._id_42E9]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
  } else {
    self _meth_842C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  }
}

_id_0100(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("disconnect");

  if(isDefined(level._id_10DB1)) {
    [[level._id_10DB1]](var_4, var_0);
  }

  return [[level._id_2F50]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

_id_0105(var_0) {
  if(isDefined(level._id_2F57)) {
    [[level._id_2F57]](var_0);
  }
}

_id_0104(var_0, var_1, var_2) {
  if(isDefined(level._id_2F58)) {
    return var_0[[level._id_2F58]](var_1, var_2);
  }

  return 0.0;
}

_id_0103(var_0, var_1, var_2) {
  var_3 = "primary";

  if(isDefined(level._id_2F56)) {
    var_3 = var_0[[level._id_2F56]](var_1, var_2);
  }

  if(var_3 == "primary") {
    return 100.0;
  } else if(var_3 == "secondary") {
    return 50.0;
  }

  return 0.0;
}

_id_0101() {
  self endon("disconnect");
  [[level._id_2F51]]();
}

_id_00F6() {
  [[level._id_2F48]]();
}

_id_D85E() {
  level._id_7CA2 = 1;
  level._id_7C9B = 2;
  level._id_7C9D = 4;
  level._id_7CA1 = 8;
  level._id_7CA8 = 16;
  level._id_7CA4 = 32;
  level._id_7CA5 = 64;
  level._id_7CA6 = 128;
  level._id_7CA3 = 256;
  level._id_7C98 = 512;
  level._id_7C99 = 1024;
  level._id_7CA7 = 2048;
  level._id_7C9C = 4096;
  level._id_7C9F = 8192;
  level._id_7C9E = 16384;
  level._id_7CA0 = 32768;
}

_id_0E0B() {
  level._id_2F59 = ::_id_2F5B;
  level._id_2F4A = ::_id_2F5B;
  level._id_2F4B = ::_id_2F5B;
  level._id_2F4D = ::_id_2F5B;
  level._id_2F4C = ::_id_2F5B;
  level._id_2F4E = ::_id_2F5B;
  level._id_2F4F = ::_id_2F5B;
  level._id_2F50 = ::_id_2F5B;
  level._id_2F51 = ::_id_2F5B;
  level._id_2F48 = ::_id_2F5B;
  setDvar("#x315af23e89f368200", "dm");
  exitlevel(0);
}

_id_2F5B() {}