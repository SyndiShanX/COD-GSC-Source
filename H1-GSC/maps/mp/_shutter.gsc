/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_shutter.gsc
********************************/

main() {
  level.inc = 0;
  common_scripts\utility::array_levelthread(getentarray("wire", "targetname"), ::wirewander);
  var_0 = getentarray("shutter_left", "targetname");
  var_1 = getentarray("shutter_right_open", "targetname");

  for (var_2 = 0; var_2 < var_1.size; var_2++)
    var_0[var_0.size] = var_1[var_2];

  var_1 = getentarray("shutter_left_closed", "targetname");

  for (var_2 = 0; var_2 < var_1.size; var_2++)
    var_0[var_0.size] = var_1[var_2];

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_3 rotateto((var_3.angles[0], var_3.angles[1] + 180, var_3.angles[2]), 0.1);
  }

  wait 0.2;

  for (var_2 = 0; var_2 < var_0.size; var_2++)
    var_0[var_2].startyaw = var_0[var_2].angles[1];

  var_4 = getentarray("shutter_right", "targetname");
  var_1 = getentarray("shutter_left_open", "targetname");

  for (var_2 = 0; var_2 < var_1.size; var_2++)
    var_4[var_4.size] = var_1[var_2];

  var_1 = getentarray("shutter_right_closed", "targetname");

  for (var_2 = 0; var_2 < var_1.size; var_2++)
    var_4[var_4.size] = var_1[var_2];

  for (var_2 = 0; var_2 < var_4.size; var_2++)
    var_4[var_2].startyaw = var_4[var_2].angles[1];

  var_1 = undefined;
  var_5 = "left";

  for (;;) {
    common_scripts\utility::array_levelthread(var_0, ::shutterwanderleft, var_5);
    common_scripts\utility::array_levelthread(var_4, ::shutterwanderright, var_5);
    level waittill("wind blows", var_5);
  }
}

windcontroller() {
  for (;;) {
    var_0 = "left";

    if(randomint(100) > 50)
      var_0 = "right";

    level notify("wind blows", var_0);
    wait(2 + randomfloat(10));
  }
}

shutterwanderleft(var_0, var_1) {
  level.inc++;
  level endon("wind blows");
  var_2 = var_0.startyaw;

  if(var_1 == "left")
    var_2 = var_2 + 179.9;

  var_3 = 0.2;
  var_0 rotateto((var_0.angles[0], var_2, var_0.angles[2]), var_3);
  wait(var_3 + 0.1);

  for (;;) {
    var_4 = randomint(80);

    if(randomint(100) > 50)
      var_4 = var_4 * -1;

    var_2 = var_0.angles[1] + var_4;
    var_5 = var_0.angles[1] + var_4 * -1;

    if(var_2 < var_0.startyaw || var_2 > var_0.startyaw + 179)
      var_2 = var_5;

    var_6 = abs(var_0.angles[1] - var_2);
    var_3 = var_6 * 0.02 + randomfloat(2);

    if(var_3 < 0.3)
      var_3 = 0.3;

    var_0 rotateto((var_0.angles[0], var_2, var_0.angles[2]), var_3, var_3 * 0.5, var_3 * 0.5);
    wait(var_3);
  }
}

shutterwanderright(var_0, var_1) {
  level.inc++;
  level endon("wind blows");
  var_2 = var_0.startyaw;

  if(var_1 == "left")
    var_2 = var_2 + 179.9;

  var_3 = 0.2;
  var_0 rotateto((var_0.angles[0], var_2, var_0.angles[2]), var_3);
  wait(var_3 + 0.1);

  for (;;) {
    var_4 = randomint(80);

    if(randomint(100) > 50)
      var_4 = var_4 * -1;

    var_2 = var_0.angles[1] + var_4;
    var_5 = var_0.angles[1] + var_4 * -1;

    if(var_2 < var_0.startyaw || var_2 > var_0.startyaw + 179)
      var_2 = var_5;

    var_6 = abs(var_0.angles[1] - var_2);
    var_3 = var_6 * 0.02 + randomfloat(2);

    if(var_3 < 0.3)
      var_3 = 0.3;

    var_0 rotateto((var_0.angles[0], var_2, var_0.angles[2]), var_3, var_3 * 0.5, var_3 * 0.5);
    wait(var_3);
  }
}

wirewander(var_0) {
  var_1 = getentarray(var_0.target, "targetname");
  var_2 = var_1[0].origin;
  var_3 = var_1[1].origin;
  var_4 = vectortoangles(var_2 - var_3);
  var_5 = spawn("script_model", (0, 0, 0));
  var_5.origin = var_2 * 0.5 + var_3 * 0.5;
  var_5.angles = var_4;
  var_0 linkto(var_5);
  var_6 = 2;
  var_7 = 0.9;
  var_8 = 4 + randomfloat(2);
  var_5 rotateroll(var_8 * 0.5, 0.2);
  wait 0.2;

  for (;;) {
    var_9 = var_6 + randomfloat(var_7) - var_7 * 0.5;
    var_5 rotateroll(var_8, var_9, var_9 * 0.5, var_9 * 0.5);
    wait(var_9);
    var_5 rotateroll(var_8 * -1, var_9, var_9 * 0.5, var_9 * 0.5);
    wait(var_9);
  }
}