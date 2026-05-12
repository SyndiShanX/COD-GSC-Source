/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_art.gsc
*********************************************/

func_00F9() {
  if(!isDefined(level.var_3189)) {
    level.var_3189["nearStart"] = 0;
    level.var_3189["nearEnd"] = 0;
    level.var_3189["farStart"] = 0;
    level.var_3189["farEnd"] = 0;
    level.var_3189["nearBlur"] = 6;
    level.var_3189["farBlur"] = 1.8;
  }
}

func_882C() {}

func_5365() {}

func_9FC8() {}

func_9FC6() {}

func_3E57() {}

func_2597() {
  if(!isDefined(level.var_A565)) {
    level.var_A565 = [];
  }

  var_00 = getEntArray("trigger_multiple_light_visionset", "classname");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.var_82E2)) {
      func_2598(var_02.var_82E2);
    }

    if(isDefined(var_02.var_82E4)) {
      func_2598(var_02.var_82E4);
    }

    if(isDefined(var_02.var_82E3)) {
      func_2598(var_02.var_82E3);
    }
  }
}

func_2598(param_00) {
  if(isDefined(level.var_A565[param_00])) {
    return;
  }

  func_278D(param_00);
  func_27C7(param_00);
  iprintlnbold("new vision: " + param_00);
}

func_27C7(param_00) {
  if(!isDefined(level.var_A56A)) {
    level.var_A56A = [];
  }

  var_01 = spawnStruct();
  var_01.var_0109 = param_00;
  level.var_A56A[param_00] = var_01;
  return var_01;
}

func_0988() {}

func_0987(param_00) {}

func_278D(param_00) {
  var_01 = func_27C6(param_00);
  var_01.var_92C6 = 3764.17;
  var_01.var_497B = 19391;
  var_01.var_7B4C = 0.661137;
  var_01.var_4848 = 0.554261;
  var_01.var_180C = 0.454014;
  var_01.var_608F = 0.7;
  var_01.var_9C83 = 0;
  var_01.var_8C98 = 0;
  var_01.var_8C9A = 0;
  var_01.var_8C99 = 0;
  var_01.var_4C37 = 0;
  var_01.var_4C36 = 0;
  var_01.var_4C38 = 1000;
}

func_27C6(param_00) {
  if(!isDefined(level.var_A565)) {
    level.var_A565 = [];
  }

  var_01 = spawnStruct();
  var_01.var_0109 = param_00;
  var_01.var_8C98 = 0;
  var_01.var_8C9A = 0;
  var_01.var_8C99 = 0;
  var_01.var_4C37 = 0;
  var_01.var_4C36 = 0;
  var_01.var_4C38 = 1000;
  var_01.var_1105 = 0;
  var_01.var_110E = 0;
  var_01.var_110F = 0;
  var_01.var_1104 = 1;
  var_01.var_10FF = 0;
  var_01.var_1100 = 1;
  var_01.var_1101 = 0;
  var_01.var_111F = 0;
  var_01.var_1115 = 0;
  var_01.var_1116 = 0;
  var_01.var_1117 = 0;
  var_01.var_1120 = 0;
  var_01.var_111C = 0;
  var_01.var_111D = 0;
  var_01.var_111E = 0;
  var_01.var_1122 = 0;
  var_01.var_1125 = 0;
  var_01.var_1123 = (0, 0, 0);
  var_01.var_111B = 0;
  var_01.var_1124 = 0;
  var_01.var_1118 = 0;
  var_01.var_1119 = 0;
  var_01.var_111A = 0;
  var_01.var_1121 = 0;
  level.var_A565[tolower(param_00)] = var_01;
  return var_01;
}

func_849E(param_00, param_01) {
  level.var_A569.var_A563 = param_00;
  level.var_A569.var_99DA = param_01;
  var_02 = func_419B(param_00);
  if(getdvarint("scr_art_tweak") != 0) {
    func_9C8B(var_02);
    param_01 = 0;
  }

  common_scripts\utility::func_84A0(var_02, param_01);
}

func_9C8B(param_00) {}

func_4F63() {
  var_00 = 7;
  var_01 = [];
  var_02 = 15;
  var_03 = int(var_00 / 2);
  var_04 = 240 + var_03 * var_02;
  var_05 = 0.5 / var_03;
  var_06 = var_05;
  for(var_07 = 0; var_07 < var_00; var_07++) {
    var_01[var_07] = func_0681();
    var_01[var_07].var_5E55 = 0;
    var_01[var_07].var_0010 = "left";
    var_01[var_07].var_0011 = "middle";
    var_01[var_07].var_00A0 = 1;
    var_01[var_07].var_009B = 2;
    var_01[var_07].var_0184 = 20;
    if(var_07 == var_03) {
      var_01[var_07].var_0018 = 1;
    } else {
      var_01[var_07].var_0018 = var_06;
    }

    var_01[var_07].var_01D3 = 20;
    var_01[var_07].var_01D7 = var_04;
    var_01[var_07] func_06DC(".");
    if(var_07 == var_03) {
      var_05 = var_05 * -1;
    }

    var_06 = var_06 + var_05;
    var_04 = var_04 - var_02;
  }

  level.var_8F65 = var_01;
}

func_0681() {
  if(!isDefined(level.var_8309)) {
    level.var_8309 = [];
  }

  var_00 = newhudelem();
  level.var_8309[level.var_8309.size] = var_00;
  return var_00;
}

func_06DC(param_00) {
  self.var_7AC5 = param_00;
  self settext("_");
  thread func_05E3();
  var_01 = 0;
  foreach(var_03 in level.var_8309) {
    if(isDefined(var_03.var_7AC5)) {
      var_01 = var_01 + var_03.var_7AC5.size;
      var_03 settext(var_03.var_7AC5);
    }
  }
}

func_05E3() {
  if(getDvar("netconststrings_enabled") != "0") {
    return;
  }

  if(level.var_05E3) {
    return;
  }

  level.var_05E3 = 1;
  self clearalltextafterhudelem();
  wait 0.05;
  level.var_05E3 = 0;
}

func_869A() {
  func_7D2D();
  var_00 = undefined;
  var_01 = getarraykeys(level.var_A565);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    if(var_01[var_02] == level.var_A569.var_A563) {
      var_00 = var_02 + 1;
      break;
    }
  }

  if(var_00 == var_01.size) {
    return;
  }

  func_8659(var_01[var_00]);
}

func_8699() {
  func_7D2D();
  var_00 = undefined;
  var_01 = getarraykeys(level.var_A565);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    if(var_01[var_02] == level.var_A569.var_A563) {
      var_00 = var_02 - 1;
      break;
    }
  }

  if(var_00 < 0) {
    return;
  }

  func_8659(var_01[var_00]);
}

func_7D2D() {}

func_A567(param_00, param_01) {
  foreach(var_03 in level.var_744A) {
    var_03 visionsetnakedforplayer(param_00, param_01);
    function_0226(&"dev_vision_exec");
    wait 0.05;
  }

  func_849E(param_00, param_01);
}

func_8659(param_00) {
  var_01 = getarraykeys(level.var_A565);
  level.var_8F66 = param_00;
  var_02 = 0;
  var_03 = int(level.var_8F65.size / 2);
  for(var_04 = 0; var_04 < var_01.size; var_04++) {
    if(var_01[var_04] == param_00) {
      var_02 = var_04;
      break;
    }
  }

  level.var_8F65[var_03] func_06DC(var_01[var_02]);
  for(var_04 = 1; var_04 < level.var_8F65.size - var_03; var_04++) {
    if(var_02 - var_04 < 0) {
      level.var_8F65[var_03 + var_04] func_06DC(".");
      continue;
    }

    level.var_8F65[var_03 + var_04] func_06DC(var_01[var_02 - var_04]);
  }

  for(var_04 = 1; var_04 < level.var_8F65.size - var_03; var_04++) {
    if(var_02 + var_04 > var_01.size - 1) {
      level.var_8F65[var_03 - var_04] func_06DC(".");
      continue;
    }

    level.var_8F65[var_03 - var_04] func_06DC(var_01[var_02 + var_04]);
  }

  func_A567(var_01[var_02], 0);
}

func_419B(param_00) {
  if(!isDefined(level.var_A565)) {
    level.var_A565 = [];
  }

  var_01 = level.var_A565[param_00];
  return var_01;
}

func_51D3() {
  if(!isDefined(level.var_3DA9)) {
    level.var_3DA9 = spawnStruct();
    level.var_3DA9.var_3DAC = "";
    level.var_3DA9.var_99DA = 0;
  }
}

func_7406() {
  var_00 = level.var_A569.var_A563;
  level.var_A569.var_A563 = "";
  level.var_A569.var_99DA = "";
  func_51D3();
  level.var_3DA9.var_3DAC = "";
  level.var_3DA9.var_99DA = "";
  func_8659(var_00);
}

func_1DCA(param_00, param_01) {
  var_02 = level.var_721C buttonpresseddevonly(param_00);
  if(!var_02) {
    var_02 = level.var_721C buttonpresseddevonly(param_01);
  }

  if(!isDefined(level.var_1DDF[param_00])) {
    level.var_1DDF[param_00] = 0;
  }

  if(gettime() < level.var_1DDF[param_00]) {
    return 0;
  }

  level.var_1DDF[param_00] = gettime() + 400;
  return var_02;
}

func_34DB() {}

func_1002() {
  common_scripts\utility::func_3AB5();
}

func_0FD0() {
  return common_scripts\utility::func_3AB4("\\share\\raw\\vision\\" + level.var_015D + ".vision", 1);
}

func_1001() {
  common_scripts\utility::func_3AB5();
}

func_0FCF() {
  return common_scripts\utility::func_3AB4("\\share\\raw\\maps\\createart\\" + level.var_015D + "_art.gsc", 1);
}

func_0FD1() {
    common_scripts\utility::func_3AB3("");
    common_scripts\utility::func_3AB3("\t
      common_scripts\utility::func_3AB3(""); common_scripts\utility::func_3AB3("\tsetDevDvar( \"scr_fog_disable\", \" + getdvarint("scr_fog_disable ") + "\" + ");
      ");
      common_scripts\utility::func_3AB3(""); common_scripts\utility::func_3AB3("\t/$"); common_scripts\utility::func_3AB3("\tlevel._art_fog_setup = maps\\createart\\" + level.var_015D + "_fog_hdr::main;"); common_scripts\utility::func_3AB3("\t$/");
    }

    func_0FCE() {}

    func_27A5(param_00) {
      if(!isDefined(level.var_5D21)) {
        level.var_5D21 = [];
      }

      var_01 = spawnStruct();
      var_01.var_0109 = param_00;
      level.var_5D21[param_00] = var_01;
      return var_01;
    }

    getvisionsetindexfromname(param_00) {
      if(!isDefined(level.var_A565)) {
        return;
      }

      var_01 = 0;
      foreach(var_04, var_03 in level.var_A565) {
        if(var_04 == param_00) {
          return var_01;
        }

        var_01++;
      }

      var_05 = "";
      foreach(var_04, var_03 in level.var_A565) {
        var_05 = var_05 + "\'" + var_04 + "\'";
      }
    }