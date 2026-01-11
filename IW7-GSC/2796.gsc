/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2796.gsc
***************************************/

main() {
  level.func_93BC = 0;
  scripts\engine\utility::array_levelthread(getEntArray("wire", "targetname"), ::func_13D8E);
  var_00 = getEntArray("shutter_left", "targetname");
  var_01 = getEntArray("shutter_right_open", "targetname");

  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    var_0[var_0.size] = var_1[var_02];
  }

  var_01 = getEntArray("shutter_left_closed", "targetname");

  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    var_0[var_0.size] = var_1[var_02];
  }

  for(var_02 = 0; var_02 < var_0.size; var_2++) {
    var_03 = var_0[var_02];
    var_03 rotateto((var_3.angles[0], var_3.angles[1] + 180, var_3.angles[2]), 0.1);
  }

  wait 0.2;

  for(var_02 = 0; var_02 < var_0.size; var_2++) {
    var_0[var_02].func_10E0E = var_0[var_02].angles[1];
  }

  var_04 = getEntArray("shutter_right", "targetname");
  var_01 = getEntArray("shutter_left_open", "targetname");

  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    var_4[var_4.size] = var_1[var_02];
  }

  var_01 = getEntArray("shutter_right_closed", "targetname");

  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    var_4[var_4.size] = var_1[var_02];
  }

  for(var_02 = 0; var_02 < var_4.size; var_2++) {
    var_4[var_02].func_10E0E = var_4[var_02].angles[1];
  }

  var_01 = undefined;
  var_05 = "left";

  for(;;) {
    scripts\engine\utility::array_levelthread(var_00, ::func_101A1, var_05);
    scripts\engine\utility::array_levelthread(var_04, ::func_101A2, var_05);
    level waittill("wind blows", var_05);
  }
}

func_13D32() {
  for(;;) {
    var_00 = "left";

    if(randomint(100) > 50) {
      var_00 = "right";
    }

    level notify("wind blows", var_00);
    wait(2 + randomfloat(10));
  }
}

func_101A1(var_00, var_01) {
  level.func_93BC++;
  level endon("wind blows");
  var_02 = var_0.func_10E0E;

  if(var_01 == "left") {
    var_02 = var_02 + 179.9;
  }

  var_03 = 0.2;
  var_00 rotateto((var_0.angles[0], var_02, var_0.angles[2]), var_03);
  wait(var_03 + 0.1);

  for(;;) {
    var_04 = randomint(80);

    if(randomint(100) > 50) {
      var_04 = var_04 * -1;
    }

    var_02 = var_0.angles[1] + var_04;
    var_05 = var_0.angles[1] + var_04 * -1;

    if(var_02 < var_0.func_10E0E || var_02 > var_0.func_10E0E + 179) {
      var_02 = var_05;
    }

    var_06 = abs(var_0.angles[1] - var_02);
    var_03 = var_06 * 0.02 + randomfloat(2);

    if(var_03 < 0.3) {
      var_03 = 0.3;
    }

    var_00 rotateto((var_0.angles[0], var_02, var_0.angles[2]), var_03, var_03 * 0.5, var_03 * 0.5);
    wait(var_03);
  }
}

func_101A2(var_00, var_01) {
  level.func_93BC++;
  level endon("wind blows");
  var_02 = var_0.func_10E0E;

  if(var_01 == "left") {
    var_02 = var_02 + 179.9;
  }

  var_03 = 0.2;
  var_00 rotateto((var_0.angles[0], var_02, var_0.angles[2]), var_03);
  wait(var_03 + 0.1);

  for(;;) {
    var_04 = randomint(80);

    if(randomint(100) > 50) {
      var_04 = var_04 * -1;
    }

    var_02 = var_0.angles[1] + var_04;
    var_05 = var_0.angles[1] + var_04 * -1;

    if(var_02 < var_0.func_10E0E || var_02 > var_0.func_10E0E + 179) {
      var_02 = var_05;
    }

    var_06 = abs(var_0.angles[1] - var_02);
    var_03 = var_06 * 0.02 + randomfloat(2);

    if(var_03 < 0.3) {
      var_03 = 0.3;
    }

    var_00 rotateto((var_0.angles[0], var_02, var_0.angles[2]), var_03, var_03 * 0.5, var_03 * 0.5);
    wait(var_03);
  }
}

func_13D8E(var_00) {
  var_01 = getEntArray(var_0.target, "targetname");
  var_02 = var_1[0].origin;
  var_03 = var_1[1].origin;
  var_04 = vectortoangles(var_02 - var_03);
  var_05 = spawn("script_model", (0, 0, 0));
  var_5.origin = var_02 * 0.5 + var_03 * 0.5;
  var_5.angles = var_04;
  var_00 linkto(var_05);
  var_06 = 2;
  var_07 = 0.9;
  var_08 = 4 + randomfloat(2);
  var_05 ghost_portal_vfx(var_08 * 0.5, 0.2);
  wait 0.2;

  for(;;) {
    var_09 = var_06 + randomfloat(var_07) - var_07 * 0.5;
    var_05 ghost_portal_vfx(var_08, var_09, var_09 * 0.5, var_09 * 0.5);
    wait(var_09);
    var_05 ghost_portal_vfx(var_08 * -1, var_09, var_09 * 0.5, var_09 * 0.5);
    wait(var_09);
  }
}