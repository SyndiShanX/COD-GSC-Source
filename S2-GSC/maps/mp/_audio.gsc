/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_audio.gsc
*********************************************/

func_5163() {
  if(!isDefined(level.var_1355)) {
    level.var_1355 = spawnStruct();
  }

  func_5255();
  func_5286();
  level.var_6B6D = ::func_6B6D;
}

func_6B6D() {
  func_0F2B("default");
}

func_5255() {
  func_095A("default", "generic", 0.15, 0.9, 2);
}

func_095A(param_00, param_01, param_02, param_03, param_04) {
  var_05 = [];
  func_55FC(param_01);
  var_05["roomtype"] = param_01;
  var_05["wetlevel"] = param_02;
  var_05["drylevel"] = param_03;
  var_05["fadetime"] = param_04;
  level.var_1355.var_7E43[param_00] = var_05;
}

func_55FC(param_00) {}

func_0F2B(param_00) {
  if(!isDefined(level.var_1355.var_7E43[param_00])) {
    var_01 = level.var_1355.var_7E43["default"];
  } else {
    var_01 = level.var_1355.var_7E43[var_01];
  }

  self method_8631("snd_enveffectsprio_level", var_01["roomtype"], var_01["drylevel"], var_01["wetlevel"], var_01["fadetime"]);
}

func_5286() {
  level.var_1355.var_AA1C = [];
  func_85F5(15, 30, 50);
  func_85F6(150, 250, 350);
}

func_85F5(param_00, param_01, param_02) {
  level.var_1355.var_AA1C["radius"] = [param_00, param_01, param_02];
}

func_85F6(param_00, param_01, param_02) {
  level.var_1355.var_AA1C["spread"] = [param_00, param_01, param_02];
}

func_0F2E() {
  var_00 = level.var_1355.var_AA1C;
  var_01 = var_00["spread"];
  var_02 = var_00["radius"];
  self setwhizbyspreads(0, var_01[0], var_01[1], var_01[2]);
  self setwhizbyradii(0, var_02[0], var_02[1], var_02[2]);
}

func_8D29(param_00, param_01) {
  if(!isDefined(level.var_11CB.var_7A31)) {
    level.var_11CB.var_7A31 = spawnStruct();
    level.var_11CB.var_7A31.var_94D7 = param_00;
    level.var_11CB.var_7A31.var_7A30 = 0;
  }

  var_02 = [param_00, param_01];
  foreach(var_04 in var_02) {
    if(var_04 > 100) {
      var_04 = 100;
    }

    if(var_04 < 1) {
      var_04 = 1;
    }
  }

  var_06 = randomintrange(1, 100);
  var_07 = level.var_11CB.var_7A31.var_94D7 + level.var_11CB.var_7A31.var_7A30;
  if(var_06 <= var_07) {
    level.var_11CB.var_7A31.var_7A30 = 0;
    return 1;
  }

  if(var_06 >= var_07) {
    level.var_11CB.var_7A31.var_7A30 = level.var_11CB.var_7A31.var_7A30 + param_01;
    return 0;
  }
}

func_8DAE(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = "null";
  }

  if(!isDefined(param_01)) {
    param_01 = "null";
  }

  if(level.var_984D) {
    foreach(var_03 in level.var_744A) {
      if(isDefined(var_03) && issentient(var_03) && issentient(self) && var_03.var_01A7 != self.var_01A7) {
        if(function_0344(param_01)) {
          var_03 method_8615(param_01);
        }

        continue;
      }

      if(isDefined(var_03) && issentient(var_03) && issentient(self) && var_03.var_01A7 == self.var_01A7) {
        if(function_0344(param_00)) {
          var_03 method_8615(param_00);
        }
      }
    }
  }
}

func_8DAC(param_00, param_01, param_02, param_03) {}

func_8DAB(param_00, param_01, param_02) {
  self endon("stop_sequencing_notetracks");
  self endon("death");
  func_8E8B(param_00, param_01, param_02);
}

func_8E8B(param_00, param_01, param_02) {
  for(;;) {
    self waittill(param_01, var_03);
    if(isDefined(var_03) && var_03 != "end") {
      if(isarray(param_00)) {
        var_04 = param_00[var_03];
        if(isDefined(var_04)) {
          self method_8617(var_04);
        }

        continue;
      }

      if(param_01 == var_03) {
        self method_8617(param_00);
      }
    }
  }
}

func_831E(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(isDefined(param_04)) {
    level endon(param_04);
  }

  param_00 method_8278(param_01, param_02);
  thread func_831F(param_00, param_02, param_03, param_04, param_05, param_06);
}

func_831F(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(isDefined(param_03)) {
    level endon(param_03);
  }

  if(isDefined(param_04)) {
    param_00 endon(param_04);
  }

  if(isDefined(param_05)) {
    param_00 endon(param_05);
  }

  param_00 endon("death");
  for(;;) {
    param_00 waittill(param_01, var_06);
    if(isDefined(var_06) && var_06 == param_01) {
      param_00 method_8617(param_02);
    }
  }
}

func_8321(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(isDefined(param_05)) {
    level endon(param_05);
  }

  param_00 method_8278(param_01, param_02);
  thread func_8320(param_00, param_02, param_03, param_04, param_05, param_06, param_07);
}

func_8320(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(isDefined(param_04)) {
    level endon(param_04);
  }

  if(isDefined(param_05)) {
    param_00 endon(param_05);
  }

  if(isDefined(param_06)) {
    param_00 endon(param_06);
  }

  param_00 endon("death");
  if(isarray(param_02)) {
    var_07 = param_02.size;
    for(;;) {
      param_00 waittill(param_01, var_08);
      if(isDefined(var_08)) {
        for(var_09 = 0; var_09 < var_07; var_09++) {
          if(var_08 == param_02[var_09]) {
            param_00 method_8617(param_03[var_09]);
          }
        }
      }
    }

    return;
  }

  for(;;) {
    param_00 waittill(param_01, var_08);
    if(isDefined(var_08) && var_08 == param_02) {
      param_00 method_8617(param_03);
    }
  }
}

func_8DF9(param_00, param_01, param_02) {
  var_03 = self;
  var_04 = [param_00, param_01, param_02];
  var_05[0] = spawn("script_origin", var_03.var_0116);
  var_05[0] method_8449(var_03);
  var_05[0] method_861D(param_00);
  var_05[1] = spawn("script_origin", var_03.var_0116);
  var_05[1] method_8449(var_03);
  var_05[1] method_861D(param_01);
  var_05[2] = spawn("script_origin", var_03.var_0116);
  var_05[2] method_8449(var_03);
  var_05[2] method_861D(param_02);
  var_03 waittill("death");
  foreach(var_07 in var_05) {
    if(isDefined(var_07)) {
      wait(0.06);
      var_07 delete();
    }
  }
}

func_2D76(param_00, param_01) {
  var_02 = 0;
  var_03 = param_01.size;
  var_04 = param_01[0];
  for(var_05 = 1; var_05 < param_01.size; var_05++) {
    var_06 = param_01[var_05];
    if(param_00 >= var_04[0] && param_00 <= var_06[0]) {
      var_07 = var_04[0];
      var_08 = var_06[0];
      var_09 = var_04[1];
      var_0A = var_06[1];
      var_0B = param_00 - var_07 / var_08 - var_07;
      var_02 = var_09 + var_0B * var_0A - var_09;
      break;
    } else {
      var_04 = var_06;
    }
  }

  return var_02;
}

func_8DA8(param_00, param_01, param_02, param_03) {
  var_04 = 0.2;
  if(isDefined(param_03)) {
    var_04 = param_03;
  }

  var_05 = spawn("script_origin", param_01);
  var_05 method_861D(param_00);
  thread func_8E89(var_05, param_02, var_04);
  return var_05;
}

func_8E89(param_00, param_01, param_02) {
  level waittill(param_01);
  if(isDefined(param_00)) {
    param_00 method_861B(0, param_02);
    wait(param_02 + 0.05);
    param_00 delete();
  }
}

func_8DCD(param_00) {
  level.var_9A0E = 0;
  if(!isDefined(param_00)) {
    param_00 = 0.1;
  }

  for(;;) {
    iprintln(level.var_9A0E);
    wait(param_00);
    level.var_9A0E = level.var_9A0E + param_00;
  }
}

func_8DA0(param_00, param_01, param_02, param_03) {
  playsoundatpos(param_01, param_00);
}

func_8DA1(param_00, param_01, param_02, param_03, param_04) {
  thread func_8E87(param_01, param_00, param_02);
}

func_8E87(param_00, param_01, param_02) {
  wait(param_02);
  playsoundatpos(param_00, param_01);
}

func_8DA2(param_00, param_01, param_02, param_03) {
  var_04 = playclientsound(param_00, param_01, undefined, undefined, undefined, "hard", undefined, param_03);
}

func_8DA4(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 0.05;
  }

  var_03 = playclientsound(param_00, param_01, undefined, undefined, undefined, "hard", undefined, param_02);
}

func_12A4(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  thread func_136C(param_00, param_01, param_02, param_03, param_04, param_05, param_06);
}

func_136C(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(isDefined(self)) {
    var_07 = (1, 1, 1);
    var_08 = (1, 0, 0);
    var_09 = (0, 1, 0);
    var_0A = (0, 1, 1);
    var_0B = 5;
    var_0C = var_07;
    var_0D = 0;
    if(isDefined(param_01)) {
      var_0B = param_01;
    }

    if(isDefined(param_05)) {
      var_0D = param_05;
    }

    var_0B = var_0B * -1;
    if(isDefined(param_02)) {
      var_0C = param_02;
      switch (var_0C) {
        case "red":
          var_0C = var_08;
          break;

        case "white":
          var_0C = var_07;
          break;

        case "blue":
          var_0C = var_0A;
          break;

        case "green":
          var_0C = var_09;
          break;

        default:
          var_0C = var_07;
          break;
      }
    }

    if(isDefined(param_04)) {
      thread func_136D(param_04);
    }

    if(!isDefined(param_06)) {
      param_06 = 0.05;
    }

    self endon("death");
    self endon("aud_stop_3D_print");
    var_0E = param_06 / 0.05;
    while(isDefined(self)) {
      var_10 = param_00;
      if(isDefined(param_03)) {
        var_10 = var_10 + self[[param_03]]();
      }

      wait(param_06);
    }
  }
}

func_136D(param_00) {
  self endon("death");
  wait(param_00);
  if(isDefined(self)) {
    self notify("aud_stop_3D_print");
  }
}

func_8DFA() {}