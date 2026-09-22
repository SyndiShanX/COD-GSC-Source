/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_shutter.gsc
****************************************/

main() {
  level._id_50DB = 0;
  common_scripts\utility::_id_0F8A(getEntArray("wire", "targetname"), ::_id_AA49);
  var_0 = getEntArray("shutter_left", "targetname");
  var_1 = getEntArray("shutter_right_open", "targetname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_0[var_0.size] = var_1[var_2];
  }

  var_1 = getEntArray("shutter_left_closed", "targetname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_0[var_0.size] = var_1[var_2];
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_3 rotateTo((var_3.angles[0], var_3.angles[1] + 180, var_3.angles[2]), 0.1);
  }

  wait 0.2;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_0[var_2]._id_930E = var_0[var_2].angles[1];
  }

  var_4 = getEntArray("shutter_right", "targetname");
  var_1 = getEntArray("shutter_left_open", "targetname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_4[var_4.size] = var_1[var_2];
  }

  var_1 = getEntArray("shutter_right_closed", "targetname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_4[var_4.size] = var_1[var_2];
  }

  for(var_2 = 0; var_2 < var_4.size; var_2++) {
    var_4[var_2]._id_930E = var_4[var_2].angles[1];
  }

  var_1 = undefined;
  var_5 = "left";

  for(;;) {
    common_scripts\utility::_id_0F8A(var_0, ::_id_8C38, var_5);
    common_scripts\utility::_id_0F8A(var_4, ::_id_8C39, var_5);
    level waittill("wind blows", var_5);
  }
}

_id_AA27() {
  for(;;) {
    var_0 = "left";

    if(randomint(100) > 50) {
      var_0 = "right";
    }

    level notify("wind blows", var_0);
    wait(2 + _randomfloat(10));
  }
}

_id_8C38(var_0, var_1) {
  level._id_50DB++;
  level endon("wind blows");
  var_2 = var_0._id_930E;

  if(var_1 == "left") {
    var_2 = var_2 + 179.9;
  }

  var_3 = 0.2;
  var_0 rotateTo((var_0.angles[0], var_2, var_0.angles[2]), var_3);
  wait(var_3 + 0.1);

  for(;;) {
    var_4 = randomint(80);

    if(randomint(100) > 50) {
      var_4 = var_4 * -1;
    }

    var_2 = var_0.angles[1] + var_4;
    var_5 = var_0.angles[1] + var_4 * -1;

    if(var_2 < var_0._id_930E || var_2 > var_0._id_930E + 179) {
      var_2 = var_5;
    }

    var_6 = _abs(var_0.angles[1] - var_2);
    var_3 = var_6 * 0.02 + _randomfloat(2);

    if(var_3 < 0.3) {
      var_3 = 0.3;
    }

    var_0 rotateTo((var_0.angles[0], var_2, var_0.angles[2]), var_3, var_3 * 0.5, var_3 * 0.5);
    wait(var_3);
  }
}

_id_8C39(var_0, var_1) {
  level._id_50DB++;
  level endon("wind blows");
  var_2 = var_0._id_930E;

  if(var_1 == "left") {
    var_2 = var_2 + 179.9;
  }

  var_3 = 0.2;
  var_0 rotateTo((var_0.angles[0], var_2, var_0.angles[2]), var_3);
  wait(var_3 + 0.1);

  for(;;) {
    var_4 = randomint(80);

    if(randomint(100) > 50) {
      var_4 = var_4 * -1;
    }

    var_2 = var_0.angles[1] + var_4;
    var_5 = var_0.angles[1] + var_4 * -1;

    if(var_2 < var_0._id_930E || var_2 > var_0._id_930E + 179) {
      var_2 = var_5;
    }

    var_6 = _abs(var_0.angles[1] - var_2);
    var_3 = var_6 * 0.02 + _randomfloat(2);

    if(var_3 < 0.3) {
      var_3 = 0.3;
    }

    var_0 rotateTo((var_0.angles[0], var_2, var_0.angles[2]), var_3, var_3 * 0.5, var_3 * 0.5);
    wait(var_3);
  }
}

_id_AA49(var_0) {
  var_1 = getEntArray(var_0.target, "targetname");
  var_2 = var_1[0].origin;
  var_3 = var_1[1].origin;
  var_4 = vectortoangles(var_2 - var_3);
  var_5 = spawn("script_model", (0, 0, 0));
  var_5.origin = var_2 * 0.5 + var_3 * 0.5;
  var_5.angles = var_4;
  var_0 linkTo(var_5);
  var_6 = 2;
  var_7 = 0.9;
  var_8 = 4 + _randomfloat(2);
  var_5 rotateroll(var_8 * 0.5, 0.2);
  wait 0.2;

  for(;;) {
    var_9 = var_6 + _randomfloat(var_7) - var_7 * 0.5;
    var_5 rotateroll(var_8, var_9, var_9 * 0.5, var_9 * 0.5);
    wait(var_9);
    var_5 rotateroll(var_8 * -1, var_9, var_9 * 0.5, var_9 * 0.5);
    wait(var_9);
  }
}