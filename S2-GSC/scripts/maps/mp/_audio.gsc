/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_audio.gsc
**************************************/

_id_5163() {
  if(!isDefined(level._id_1355))
    level._id_1355 = spawnStruct();

  _id_5255();
  _id_5286();
  level._id_6B6D = ::_id_6B6D;
}

_id_6B6D() {
  _id_0F2B("default");
}

_id_5255() {
  _id_095A("default", "generic", 0.15, 0.9, 2);
}

_id_095A(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  _id_55FC(var_1);
  var_5["roomtype"] = var_1;
  var_5["wetlevel"] = var_2;
  var_5["drylevel"] = var_3;
  var_5["fadetime"] = var_4;
  level._id_1355._id_7E43[var_0] = var_5;
}

_id_55FC(var_0) {}

_id_0F2B(var_0) {
  if(!isDefined(level._id_1355._id_7E43[var_0]))
    var_1 = level._id_1355._id_7E43["default"];
  else
    var_1 = level._id_1355._id_7E43[var_0];

  self _meth_8631("snd_enveffectsprio_level", var_1["roomtype"], var_1["drylevel"], var_1["wetlevel"], var_1["fadetime"]);
}

_id_5286() {
  level._id_1355._id_AA1C = [];
  _id_85F5(15.0, 30.0, 50.0);
  _id_85F6(150.0, 250.0, 350.0);
}

_id_85F5(var_0, var_1, var_2) {
  level._id_1355._id_AA1C["radius"] = [var_0, var_1, var_2];
}

_id_85F6(var_0, var_1, var_2) {
  level._id_1355._id_AA1C["spread"] = [var_0, var_1, var_2];
}

_id_0F2E() {
  var_0 = level._id_1355._id_AA1C;
  var_1 = var_0["spread"];
  var_2 = var_0["radius"];
  self _meth_8333(0, var_1[0], var_1[1], var_1[2]);
  self _meth_8334(0, var_2[0], var_2[1], var_2[2]);
}

_id_8D29(var_0, var_1) {
  if(!isDefined(level._id_11CB._id_7A31)) {
    level._id_11CB._id_7A31 = spawnStruct();
    level._id_11CB._id_7A31._id_94D7 = var_0;
    level._id_11CB._id_7A31._id_7A30 = 0;
  }

  var_2 = [var_0, var_1];

  foreach(var_4 in var_2) {
    if(var_4 > 100)
      var_4 = 100;

    if(var_4 < 1)
      var_4 = 1;
  }

  var_6 = _func_0A4(1, 100);
  var_7 = level._id_11CB._id_7A31._id_94D7 + level._id_11CB._id_7A31._id_7A30;

  if(var_6 <= var_7) {
    level._id_11CB._id_7A31._id_7A30 = 0;
    return 1;
  }

  if(var_6 >= var_7) {
    level._id_11CB._id_7A31._id_7A30 = level._id_11CB._id_7A31._id_7A30 + var_1;
    return 0;
  }
}

_id_8DAE(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = "null";

  if(!isDefined(var_1))
    var_1 = "null";

  if(level.teambased) {
    foreach(var_3 in level.players) {
      if(isDefined(var_3) && _func_0C3(var_3) && _func_0C3(self) && var_3.team != self.team) {
        if(_func_344(var_1))
          var_3 playlocalsound(var_1);

        continue;
      }

      if(isDefined(var_3) && _func_0C3(var_3) && _func_0C3(self) && var_3.team == self.team) {
        if(_func_344(var_0))
          var_3 playlocalsound(var_0);
      }
    }
  }
}

_id_8DAC(var_0, var_1, var_2, var_3) {}

_id_8DAB(var_0, var_1, var_2) {
  self endon("stop_sequencing_notetracks");
  self endon("death");
  _id_8E8B(var_0, var_1, var_2);
}

_id_8E8B(var_0, var_1, var_2) {
  for(;;) {
    self waittill(var_1, var_3);

    if(isDefined(var_3) && var_3 != "end") {
      if(_func_0C0(var_0)) {
        var_4 = var_0[var_3];

        if(isDefined(var_4))
          self playSound(var_4);

        continue;
      }

      if(var_1 == var_3)
        self playSound(var_0);
    }
  }
}

_id_831E(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_4))
    level endon(var_4);

  var_0 _meth_8278(var_1, var_2);
  thread _id_831F(var_0, var_2, var_3, var_4, var_5, var_6);
}

_id_831F(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_3))
    level endon(var_3);

  if(isDefined(var_4))
    var_0 endon(var_4);

  if(isDefined(var_5))
    var_0 endon(var_5);

  var_0 endon("death");

  for(;;) {
    var_0 waittill(var_1, var_6);

    if(isDefined(var_6) && var_6 == var_1)
      var_0 playSound(var_2);
  }
}

_id_8321(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_5))
    level endon(var_5);

  var_0 _meth_8278(var_1, var_2);
  thread _id_8320(var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_8320(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_4))
    level endon(var_4);

  if(isDefined(var_5))
    var_0 endon(var_5);

  if(isDefined(var_6))
    var_0 endon(var_6);

  var_0 endon("death");

  if(_func_0C0(var_2)) {
    var_7 = var_2.size;

    for(;;) {
      var_0 waittill(var_1, var_8);

      if(isDefined(var_8)) {
        for(var_9 = 0; var_9 < var_7; var_9++) {
          if(var_8 == var_2[var_9])
            var_0 playSound(var_3[var_9]);
        }
      }
    }
  } else {
    for(;;) {
      var_0 waittill(var_1, var_8);

      if(isDefined(var_8) && var_8 == var_2)
        var_0 playSound(var_3);
    }
  }
}

_id_8DF9(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = [var_0, var_1, var_2];
  var_5[0] = spawn("script_origin", var_3.origin);
  var_5[0] linktosynchronizedparent(var_3);
  var_5[0] _meth_861D(var_0);
  var_5[1] = spawn("script_origin", var_3.origin);
  var_5[1] linktosynchronizedparent(var_3);
  var_5[1] _meth_861D(var_1);
  var_5[2] = spawn("script_origin", var_3.origin);
  var_5[2] linktosynchronizedparent(var_3);
  var_5[2] _meth_861D(var_2);
  var_3 waittill("death");

  foreach(var_7 in var_5) {
    if(isDefined(var_7)) {
      wait 0.06;
      var_7 delete();
    }
  }
}

_id_2D76(var_0, var_1) {
  var_2 = 0.0;
  var_3 = var_1.size;
  var_4 = var_1[0];

  for(var_5 = 1; var_5 < var_1.size; var_5++) {
    var_6 = var_1[var_5];

    if(var_0 >= var_4[0] && var_0 <= var_6[0]) {
      var_7 = var_4[0];
      var_8 = var_6[0];
      var_9 = var_4[1];
      var_10 = var_6[1];
      var_11 = (var_0 - var_7) / (var_8 - var_7);
      var_2 = var_9 + var_11 * (var_10 - var_9);
      break;
    } else
      var_4 = var_6;
  }

  return var_2;
}

_id_8DA8(var_0, var_1, var_2, var_3) {
  var_4 = 0.2;

  if(isDefined(var_3))
    var_4 = var_3;

  var_5 = spawn("script_origin", var_1);
  var_5 _meth_861D(var_0);
  thread _id_8E89(var_5, var_2, var_4);
  return var_5;
}

_id_8E89(var_0, var_1, var_2) {
  level waittill(var_1);

  if(isDefined(var_0)) {
    var_0 _meth_861B(0, var_2);
    wait(var_2 + 0.05);
    var_0 delete();
  }
}

_id_8DCD(var_0) {
  level._id_9A0E = 0;

  if(!isDefined(var_0))
    var_0 = 0.1;

  for(;;) {
    _func_18B(level._id_9A0E);
    wait(var_0);
    level._id_9A0E = level._id_9A0E + var_0;
  }
}

_id_8DA0(var_0, var_1, var_2, var_3) {
  playsoundatpos(var_1, var_0);
}

_id_8DA1(var_0, var_1, var_2, var_3, var_4) {
  thread _id_8E87(var_1, var_0, var_2);
}

_id_8E87(var_0, var_1, var_2) {
  wait(var_2);
  playsoundatpos(var_0, var_1);
}

_id_8DA2(var_0, var_1, var_2, var_3) {
  var_4 = _func_351(var_0, var_1, undefined, undefined, undefined, "hard", undefined, var_3);
}

_id_8DA4(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0.05;

  var_3 = _func_351(var_0, var_1, undefined, undefined, undefined, "hard", undefined, var_2);
}

_id_12A4(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  thread _id_136C(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_136C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(self)) {
    var_7 = (1, 1, 1);
    var_8 = (1, 0, 0);
    var_9 = (0, 1, 0);
    var_10 = (0, 1, 1);
    var_11 = 5;
    var_12 = var_7;
    var_13 = 0;

    if(isDefined(var_1))
      var_11 = var_1;

    if(isDefined(var_5))
      var_13 = var_5;

    var_11 = var_11 * -1;

    if(isDefined(var_2)) {
      var_12 = var_2;

      switch (var_12) {
        case "red":
          var_12 = var_8;
          break;
        case "white":
          var_12 = var_7;
          break;
        case "blue":
          var_12 = var_10;
          break;
        case "green":
          var_12 = var_9;
          break;
        default:
          var_12 = var_7;
      }
    }

    if(isDefined(var_4))
      thread _id_136D(var_4);

    if(!isDefined(var_6))
      var_6 = 0.05;

    self endon("death");
    self endon("aud_stop_3D_print");
    var_14 = var_6 / 0.05;

    while(isDefined(self)) {
      var_16 = var_0;

      if(isDefined(var_3))
        var_16 = var_16 + self[[var_3]]();

      wait(var_6);
    }
  }
}

_id_136D(var_0) {
  self endon("death");
  wait(var_0);

  if(isDefined(self))
    self notify("aud_stop_3D_print");
}

_id_8DFA() {}