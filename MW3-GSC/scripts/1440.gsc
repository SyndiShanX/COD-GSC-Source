/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1440.gsc
**************************************/

main() {
  maps\_utility::precache("woodgib_medium");
  maps\_utility::precache("woodgib_big");
  maps\_utility::precache("woodgib_small1");
  maps\_utility::precache("woodgib_small2");
  maps\_utility::precache("wood_plank2");
  maps\_utility::precache("gib_woodplank");
  var_0 = getEntArray("wood_splinter", "targetname");
  maps\_utility::array_thread(var_0, ::_id_43FA);
}

_id_43FA() {
  if(!isDefined(self.target)) {
    return;
  }
  var_0 = getEntArray(self.target, "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1].script_noteworthy) && var_0[var_1].script_noteworthy == "notsolid") {
      var_0[var_1] notsolid();
    }
    if(!isDefined(var_0[var_1].target)) {
      continue;
    }
    var_0[var_1]._id_43FB = getEntArray(var_0[var_1].target, "targetname");

    for(var_2 = 0; var_2 < var_0[var_1]._id_43FB.size; var_2++) {
      if(isDefined(var_0[var_1]._id_43FB[var_2])) {
        var_0[var_1]._id_43FB[var_2] hide();
      }
    }
  }

  if(isDefined(self.script_noteworthy)) {
    level waittill(self.script_noteworthy);
  }
  self waittill("trigger", var_3);

  if(isPlayer(var_3)) {
    var_4 = var_3 getorigin();
  } else {
    var_4 = var_3.origin;
  }
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(!isDefined(var_0[var_1].target)) {
      continue;
    }
    var_0[var_1]._id_43FB = getEntArray(var_0[var_1].target, "targetname");

    for(var_2 = 0; var_2 < var_0[var_1]._id_43FB.size; var_2++) {
      if(isDefined(var_0[var_1]._id_43FB[var_2])) {
        var_0[var_1]._id_43FB[var_2] show();
      }
    }
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(!isDefined(var_0[var_1])) {
      continue;
    }
    var_0[var_1] playSound("wood_break");
    var_0[var_1] thread _id_43FC(var_4);
    var_0[var_1] delete();
  }
}

_id_43FC(var_0) {
  var_1 = spawn("script_model", (0, 0, 0));

  if(randomint(100) > 25) {
    if(isDefined(self.script_noteworthy) && self.script_noteworthy == "dark") {
      if(randomint(100) > 50) {
        var_1 setModel("wood_plank2");
      } else {
        var_1 setModel("gib_woodplank");
      }
    } else if(randomint(100) > 50) {
      var_1 setModel("woodgib_big");
    } else {
      var_1 setModel("woodgib_medium");
    }
  }

  var_1.origin = self getorigin();
  var_1 thread _id_43FD(var_0);

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "dark") {
    return;
  }
  _id_43FE(var_1.origin, var_0);
}

_id_43FD(var_0) {
  var_1 = vectornormalize(self.origin - var_0);
  var_1 = var_1 * (250 + randomint(100));
  var_2 = var_1[0];
  var_3 = var_1[1];
  var_4 = 200 + randomint(100);

  if(var_2 > 0) {
    self rotateroll((1500 + randomfloat(2500)) * -1, 5, 0, 0);
  } else {
    self rotateroll(1500 + randomfloat(2500), 5, 0, 0);
  }
  self movegravity((var_2, var_3, var_4), 12);
  wait 6;
  self delete();
}

_id_43FE(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < randomint(6) + 1; var_3++) {
    var_2[var_3] = spawn("script_model", var_0);
    var_2[var_3].origin = var_2[var_3].origin + (randomfloat(10) - 5, 0, randomfloat(30) - 15);

    if(randomint(100) > 50) {
      var_2[var_3] setModel("woodgib_small1");
    } else {
      var_2[var_3] setModel("woodgib_small2");
    }
    var_1 = var_1 + (50 - randomint(100), 50 - randomint(100), 0);
    var_4 = vectornormalize(var_0 - var_1);
    var_4 = var_4 * (300 + randomint(150));
    var_5 = var_4[0];
    var_6 = var_4[1];
    var_7 = 120 + randomint(200);
    var_2[var_3] movegravity((var_5, var_6, var_7), 12);

    if(var_5 > 0) {
      var_2[var_3] rotateroll((1500 + randomfloat(2500)) * -1, 5, 0, 0);
      continue;
    }

    var_2[var_3] rotateroll(1500 + randomfloat(2500), 5, 0, 0);
  }

  wait 6;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_2[var_3] delete();
  }
}