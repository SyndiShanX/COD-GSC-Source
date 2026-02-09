/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\317.gsc
**************************************/

main() {
  if(!isDefined(level._id_1DC1)) {
    level._id_1DC1 = 0.2;
  }
  level._id_1DC2["awning"] = 1.0;
  level._id_1DC2["palm"] = 1.0;
  level._id_1DC3 = level._id_1DC1 - 0.5;
  level._id_1DC4 = level._id_1DC1 + 0.2;

  if(level._id_1DC3 < 0.1) {
    level._id_1DC3 = 0.1;
  }
  if(level._id_1DC4 > 1.0) {
    level._id_1DC4 = 1.0;
  }
  level.inc = 0;
  _id_1DD1();
  _id_1DD3();
  thread _id_1DC8();
  common_scripts\utility::array_levelthread(getEntArray("wire", "targetname"), ::wirewander);
  common_scripts\utility::array_levelthread(getEntArray("awning", "targetname"), ::_id_1DD2);
  common_scripts\utility::array_levelthread(getEntArray("palm", "targetname"), ::_id_1DD4);
  var_0 = [];
  var_1 = getEntArray("shutter_left", "targetname");
  var_0 = common_scripts\utility::array_combine(var_0, var_1);
  var_1 = getEntArray("shutter_right_open", "targetname");
  var_0 = common_scripts\utility::array_combine(var_0, var_1);
  var_1 = getEntArray("shutter_left_closed", "targetname");
  var_0 = common_scripts\utility::array_combine(var_0, var_1);

  foreach(var_3 in var_0) {}
  var_3 addyaw(180);

  var_5 = [];
  var_1 = getEntArray("shutter_right", "targetname");
  var_5 = common_scripts\utility::array_combine(var_5, var_1);
  var_1 = getEntArray("shutter_left_open", "targetname");
  var_5 = common_scripts\utility::array_combine(var_5, var_1);
  var_1 = getEntArray("shutter_right_closed", "targetname");
  var_5 = common_scripts\utility::array_combine(var_5, var_1);
  wait 0.05;
  var_1 = common_scripts\utility::array_combine(var_0, var_5);

  foreach(var_3 in var_1) {
    var_3 thread _id_1DCF();
    var_3.startyaw = var_3.angles[1];
  }

  var_1 = undefined;
  var_8 = "left";
  level endon("stop_shutters");

  for(;;) {
    common_scripts\utility::array_levelthread(var_0, ::shutterwanderleft, var_8);
    common_scripts\utility::array_levelthread(var_5, ::shutterwanderright, var_8);
    level waittill("wind blows", var_8);
  }
}

windcontroller() {
  for(;;) {
    var_0 = "left";

    if(randomint(100) > 50) {
      var_0 = "right";
    }
    level notify("wind blows", var_0);
    wait(2 + randomfloat(10));
  }
}

_id_1DC8() {
  var_0 = getEntArray("shutter", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getent(var_2.target, "targetname");
    var_4 = spawn("script_origin", var_2.origin);
    var_4.angles = var_3.angles;
    var_4.startyaw = var_4.angles[1];
    var_2._id_1DC9 = var_4;
    var_2 linkto(var_4);
    var_4 addyaw(randomfloatrange(-90, 90));
    var_2 thread _id_1DCF();
  }

  level endon("stop_shutters");
  var_6 = "left";

  for(;;) {
    common_scripts\utility::array_levelthread(var_0, ::_id_1DCA, var_6);
    level waittill("wind blows", var_6);
  }
}

_id_1DCA(var_0, var_1) {
  level endon("stop_shutters");
  level endon("wind blows");
  var_2 = var_0._id_1DC9;
  var_3 = randomint(3) + 1;
  var_4 = 1;

  if(common_scripts\utility::cointoss()) {
    var_4 = var_4 * -1;
  }
  var_5 = 80;
  var_6 = 80;

  if(isDefined(var_0._id_1DCB)) {
    var_6 = var_0._id_1DCB;
  }
  if(isDefined(var_0._id_1DCC)) {
    var_5 = var_0._id_1DCC;
  }
  for(;;) {
    var_0 notify("shutterSound");
    var_7 = randomintrange(50, 80);
    var_3--;

    if(!var_3) {
      var_3 = randomint(3) + 1;
      var_4 = var_4 * -1;
    }

    var_7 = var_7 * var_4;

    if(var_4 > 0) {
      if(var_7 > var_5) {
        var_7 = var_5;
      }
    } else if(var_7 > var_6) {
      var_7 = var_6;
    }
    var_8 = var_2.startyaw + var_7;
    var_9 = abs(var_2.angles[1] - var_8);
    var_10 = var_9 * 0.05 + randomfloat(1) + 0.25;

    if(var_10 < 0.25) {
      var_10 = 0.25;
    }
    var_2 rotateto((0, var_8, 0), var_10, var_10 * 0.5, var_10 * 0.5);
    wait(var_10);
  }
}

shutterwanderleft(var_0, var_1) {
  level endon("stop_shutters");
  level.inc++;
  level endon("wind blows");
  var_2 = var_0.startyaw;

  if(var_1 == "left") {
    var_2 = var_2 + 179.9;
  }
  var_3 = 0.2;
  var_0 rotateto((var_0.angles[0], var_2, var_0.angles[2]), var_3);
  wait(var_3 + 0.1);

  for(;;) {
    var_0 notify("shutterSound");
    var_4 = randomint(80);

    if(common_scripts\utility::cointoss()) {
      var_4 = var_4 * -1;
    }
    var_2 = var_0.angles[1] + var_4;
    var_5 = var_0.angles[1] + var_4 * -1;

    if(var_2 < var_0.startyaw || var_2 > var_0.startyaw + 179) {
      var_2 = var_5;
    }
    var_6 = abs(var_0.angles[1] - var_2);
    var_3 = var_6 * 0.02 + randomfloat(2);

    if(var_3 < 0.3) {
      var_3 = 0.3;
    }
    var_0 rotateto((var_0.angles[0], var_2, var_0.angles[2]), var_3, var_3 * 0.5, var_3 * 0.5);
    wait(var_3);
  }
}

shutterwanderright(var_0, var_1) {
  level endon("stop_shutters");
  level.inc++;
  level endon("wind blows");
  var_2 = var_0.startyaw;

  if(var_1 == "left") {
    var_2 = var_2 + 179.9;
  }
  var_3 = 0.2;
  var_0 rotateto((var_0.angles[0], var_2, var_0.angles[2]), var_3);
  wait(var_3 + 0.1);

  for(;;) {
    var_0 notify("shutterSound");
    var_4 = randomint(80);

    if(randomint(100) > 50) {
      var_4 = var_4 * -1;
    }
    var_2 = var_0.angles[1] + var_4;
    var_5 = var_0.angles[1] + var_4 * -1;

    if(var_2 < var_0.startyaw || var_2 > var_0.startyaw + 179) {
      var_2 = var_5;
    }
    var_6 = abs(var_0.angles[1] - var_2);
    var_3 = var_6 * 0.02 + randomfloat(2);

    if(var_3 < 0.3) {
      var_3 = 0.3;
    }
    var_0 rotateto((var_0.angles[0], var_2, var_0.angles[2]), var_3, var_3 * 0.5, var_3 * 0.5);
    wait(var_3);
  }
}

_id_1DCF() {
  for(;;) {
    self waittill("shutterSound");
    self waittill("sounddone");
    wait(randomfloat(2));
  }
}

wirewander(var_0) {
  var_1 = getEntArray(var_0.target, "targetname");
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

  for(;;) {
    var_9 = var_6 + randomfloat(var_7) - var_7 * 0.5;
    var_5 rotateroll(var_8, var_9, var_9 * 0.5, var_9 * 0.5);
    wait(var_9);
    var_5 rotateroll(var_8 * -1, var_9, var_9 * 0.5, var_9 * 0.5);
    wait(var_9);
  }
}

_id_1DD1() {}

_id_1DD2(var_0) {}

_id_1DD3() {
  return;
}

#using_animtree("animated_props");

_id_1DD4(var_0) {
  var_0 useanimtree(#animtree);

  switch (var_0.model) {
    case "tree_desertpalm01":
      var_0._id_1032 = "tree_desertpalm01";
      break;
    case "tree_desertpalm02":
      var_0._id_1032 = "tree_desertpalm02";
      break;
    case "tree_desertpalm03":
      var_0._id_1032 = "tree_desertpalm03";
      break;
  }

  if(!isDefined(var_0._id_1032)) {
    return;
  }
  wait(randomfloat(2));

  for(;;) {
    var_1 = level._id_1DC3 + randomfloat(level._id_1DC4 - level._id_1DC3);
    var_2 = 4;
    var_0 setanim(level._id_0C59[var_0._id_1032]["wind"][0], var_1, var_2, level._id_1DC2["palm"]);
    var_0 setanim(level._id_0C59[var_0._id_1032]["wind"][1], 1 - var_1, var_2, level._id_1DC2["palm"]);
    wait(1 + randomfloat(3));
  }
}