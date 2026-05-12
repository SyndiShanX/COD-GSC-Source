/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_shutter.gsc
*********************************************/

func_00F9() {
  level.var_50DB = 0;
  common_scripts\utility::func_0F8A(getEntArray("wire", "targetname"), ::func_AA49);
  var_00 = getEntArray("shutter_left", "targetname");
  var_01 = getEntArray("shutter_right_open", "targetname");
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    var_00[var_00.size] = var_01[var_02];
  }

  var_01 = getEntArray("shutter_left_closed", "targetname");
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    var_00[var_00.size] = var_01[var_02];
  }

  for(var_02 = 0; var_02 < var_00.size; var_02++) {
    var_03 = var_00[var_02];
    var_03 rotateto((var_03.var_001D[0], var_03.var_001D[1] + 180, var_03.var_001D[2]), 0.1);
  }

  wait(0.2);
  for(var_02 = 0; var_02 < var_00.size; var_02++) {
    var_00[var_02].var_930E = var_00[var_02].var_001D[1];
  }

  var_04 = getEntArray("shutter_right", "targetname");
  var_01 = getEntArray("shutter_left_open", "targetname");
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    var_04[var_04.size] = var_01[var_02];
  }

  var_01 = getEntArray("shutter_right_closed", "targetname");
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    var_04[var_04.size] = var_01[var_02];
  }

  for(var_02 = 0; var_02 < var_04.size; var_02++) {
    var_04[var_02].var_930E = var_04[var_02].var_001D[1];
  }

  var_01 = undefined;
  var_05 = "left";
  for(;;) {
    common_scripts\utility::func_0F8A(var_00, ::func_8C38, var_05);
    common_scripts\utility::func_0F8A(var_04, ::func_8C39, var_05);
    level waittill("wind blows", var_05);
  }
}

func_AA27() {
  for(;;) {
    var_00 = "left";
    if(randomint(100) > 50) {
      var_00 = "right";
    }

    level notify("wind blows", var_00);
    wait(2 + randomfloat(10));
  }
}

func_8C38(param_00, param_01) {
  level.var_50DB++;
  level endon("wind blows");
  var_02 = param_00.var_930E;
  if(param_01 == "left") {
    var_02 = var_02 + 179.9;
  }

  var_03 = 0.2;
  param_00 rotateto((param_00.var_001D[0], var_02, param_00.var_001D[2]), var_03);
  wait(var_03 + 0.1);
  for(;;) {
    var_04 = randomint(80);
    if(randomint(100) > 50) {
      var_04 = var_04 * -1;
    }

    var_02 = param_00.var_001D[1] + var_04;
    var_05 = param_00.var_001D[1] + var_04 * -1;
    if(var_02 < param_00.var_930E || var_02 > param_00.var_930E + 179) {
      var_02 = var_05;
    }

    var_06 = abs(param_00.var_001D[1] - var_02);
    var_03 = var_06 * 0.02 + randomfloat(2);
    if(var_03 < 0.3) {
      var_03 = 0.3;
    }

    param_00 rotateto((param_00.var_001D[0], var_02, param_00.var_001D[2]), var_03, var_03 * 0.5, var_03 * 0.5);
    wait(var_03);
  }
}

func_8C39(param_00, param_01) {
  level.var_50DB++;
  level endon("wind blows");
  var_02 = param_00.var_930E;
  if(param_01 == "left") {
    var_02 = var_02 + 179.9;
  }

  var_03 = 0.2;
  param_00 rotateto((param_00.var_001D[0], var_02, param_00.var_001D[2]), var_03);
  wait(var_03 + 0.1);
  for(;;) {
    var_04 = randomint(80);
    if(randomint(100) > 50) {
      var_04 = var_04 * -1;
    }

    var_02 = param_00.var_001D[1] + var_04;
    var_05 = param_00.var_001D[1] + var_04 * -1;
    if(var_02 < param_00.var_930E || var_02 > param_00.var_930E + 179) {
      var_02 = var_05;
    }

    var_06 = abs(param_00.var_001D[1] - var_02);
    var_03 = var_06 * 0.02 + randomfloat(2);
    if(var_03 < 0.3) {
      var_03 = 0.3;
    }

    param_00 rotateto((param_00.var_001D[0], var_02, param_00.var_001D[2]), var_03, var_03 * 0.5, var_03 * 0.5);
    wait(var_03);
  }
}

func_AA49(param_00) {
  var_01 = getEntArray(param_00.var_01A2, "targetname");
  var_02 = var_01[0].var_0116;
  var_03 = var_01[1].var_0116;
  var_04 = vectortoangles(var_02 - var_03);
  var_05 = spawn("script_model", (0, 0, 0));
  var_05.var_0116 = var_02 * 0.5 + var_03 * 0.5;
  var_05.var_001D = var_04;
  param_00 linkto(var_05);
  var_06 = 2;
  var_07 = 0.9;
  var_08 = 4 + randomfloat(2);
  var_05 rotateroll(var_08 * 0.5, 0.2);
  wait(0.2);
  for(;;) {
    var_09 = var_06 + randomfloat(var_07) - var_07 * 0.5;
    var_05 rotateroll(var_08, var_09, var_09 * 0.5, var_09 * 0.5);
    wait(var_09);
    var_05 rotateroll(var_08 * -1, var_09, var_09 * 0.5, var_09 * 0.5);
    wait(var_09);
  }
}