/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1368.gsc
**************************************/

main() {
  level._id_41A5 = 1;
  level._id_41A6 = getent("sea", "targetname");
  level._id_41A7 = spawn("script_origin", level._id_41A6.origin);
  level._id_41A7.offset = level._id_41A6.origin * -1;
  level._id_41A7._id_41A8 = "sway2";
  level._id_41A9 = spawn("script_origin", level._id_41A6.origin);
  level._id_41A9.offset = level._id_41A7.offset;
  level._id_41A6 linkto(level._id_41A9);
  level._id_41AA = getent("sea_foam", "targetname");

  if(isDefined(level._id_41AA)) {
    level._id_41AA linkto(level._id_41A9);
    level._id_41AA hide();
  }

  level._id_41AB = getent("sea_black", "targetname");

  if(isDefined(level._id_41AB)) {
    level._id_41AB linkto(level._id_41A9);

  }
  common_scripts\utility::flag_init("_sea_waves");
  common_scripts\utility::flag_init("_sea_viewbob");
  common_scripts\utility::flag_init("_sea_bob");
  common_scripts\utility::flag_set("_sea_bob");
  common_scripts\utility::flag_set("_sea_viewbob");
  var_0 = getEntArray("boat_sway", "script_noteworthy");

  if(isDefined(var_0)) {
    common_scripts\utility::array_thread(var_0, ::_id_41B8, level._id_41A7);

  }
  thread _id_41AC();
  return;
}

_id_41AC() {
  wait 0.05;
  var_0 = getmapsundirection();
  setsundirection(var_0);
  level._id_41AD = vectortoangles(var_0);
  level._id_41AE = level._id_41AD;
  level._id_41A7 thread _id_41BD();
  level._id_41A7 thread _id_41C0();
  level._id_41A7 thread _id_41CA();
}

_id_41AF(var_0, var_1) {
  self.waittime = randomfloatrange(0.5, 1);

  if(isDefined(self._id_41B0)) {
    self.scale = self._id_41B0;
  } else {
    self.scale = randomfloatrange(2, 3);

  }
  var_2 = 0;
  var_3 = 0;

  switch (var_1) {
    case "sway1":
      var_2 = self._id_41B1;
      break;
    case "sway2":
      var_2 = self._id_41B2;
      break;
  }

  if(self._id_41B3) {
    var_4 = var_0._id_41B4[0] * self._id_41B5 * self.scale + var_0._id_41B4[2] * self._id_41B6 * self.scale;

    if(var_2 < abs(var_4)) {
      if(var_4 < 1) {
        var_3 = var_2 * -1;
      } else {
        var_3 = var_2;
      }
    } else {
      var_3 = var_4;

    }
    self._id_41B7 = (self.angles[0], self.angles[1], var_3);
  } else {
    self._id_41B7 = var_0._id_41B4 * self.scale;
  }
}

_id_41B8(var_0) {
  if(isDefined(self.targetname)) {
    var_1 = getEntArray(self.targetname, "target");

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_1[var_2] linkto(self);
    }
  }

  var_3 = common_scripts\utility::getstructarray(self.target, "targetname");
  var_4 = var_3[0].origin;
  var_5 = undefined;
  var_6 = spawn("script_origin", (0, 0, 0));
  var_6._id_41B3 = 0;

  if(isDefined(var_3[1])) {
    var_5 = var_3[1].origin;
    var_6._id_41B3 = 1;
  } else {
    var_7 = anglestoup(var_3[0].angles);
    var_7 = var_7 * 10;
    var_5 = var_4 + var_7;
  }

  var_6.origin = var_4;
  var_6.angles = vectortoangles(var_5 - var_4);
  var_6._id_41B5 = 1;
  var_6._id_41B6 = 1;
  var_6._id_41B1 = 100;
  var_6._id_41B2 = 100;
  var_6._id_41B0 = undefined;

  if(isDefined(var_3[0]._id_164F)) {
    var_8 = strtok(var_3[0]._id_164F, ":;, ");

    for(var_2 = 0; var_2 < var_8.size; var_2++) {
      switch (var_8[var_2]) {
        case "axial":
          var_6._id_41B3 = 1;
          break;
        case "sway1":
          var_2++;
          var_6._id_41B1 = int(var_8[var_2]);
          break;
        case "sway2":
          var_2++;
          var_6._id_41B2 = int(var_8[var_2]);
          break;
        case "setscale":
          var_2++;

          if(var_8[var_2] == "randomrange") {
            var_2++;
            var_9 = int(var_8[var_2]);
            var_2++;
            var_10 = int(var_8[var_2]);
            var_6._id_41B0 = randomfloatrange(var_9, var_10);
          } else {
            var_6._id_41B0 = int(var_8[var_2]);

          }
          break;
      }
    }
  }

  if(var_6._id_41B3) {
    var_11 = undefined;
    var_12 = (0, 360, 0);

    if(!isDefined(var_3[1])) {
      var_11 = var_3[0].angles;
    } else {
      var_11 = vectortoangles(var_5 - var_4);

    }
    var_6._id_41B6 = vectordot(anglestoright(var_11), anglestoright(var_12));
    var_6._id_41B5 = vectordot(anglestoright(var_11), anglesToForward(var_12));
  }

  self._id_41B9 = var_6;
  self notify("got_link");

  for(var_2 = 0; var_2 < var_3.size; var_2++) {
    var_3[var_2] thread _id_41BC(var_6, var_0);

  }
  wait 0.05;
  self linkto(var_6);

  if(isDefined(self._id_164F)) {}

  thread _id_41BA(var_0, var_6);
}

_id_41BA(var_0, var_1) {
  for(;;) {
    if(var_0._id_41A8 == "sway2") {
      var_0 waittill("sway1");

    }
    var_1 _id_41AF(var_0, "sway1");
    var_1 notify("precalcdone1");

    if(!isDefined(var_1.parent)) {
      wait(var_1.waittime);

    }
    var_1 rotateto(var_1._id_41B7, var_0.time, var_0.time * 0.5, var_0.time * 0.5);

    if(var_0._id_41A8 == "sway1") {
      var_0 waittill("sway2");

    }
    var_1 _id_41AF(var_0, "sway2");
    var_1 notify("precalcdone2");

    if(!isDefined(var_1.parent)) {
      wait(var_1.waittime);

    }
    var_1 rotateto(var_1._id_41B7, var_0.time, var_0.time * 0.5, var_0.time * 0.5);
  }
}

_id_41BB(var_0) {
  for(;;) {
    self moveto(var_0.origin, 0.1);
    wait 0.1;
  }
}

_id_41BC(var_0, var_1) {
  if(!isDefined(self.target)) {
    return;
  }
  var_0.parent = getent(self.target, "targetname");

  if(!isDefined(var_0.parent._id_41B9)) {
    var_0.parent waittill("got_link");

  }
  var_2 = var_0.parent._id_41B9;
  var_3 = var_0.origin;
  var_4 = spawn("script_origin", var_2.origin);
  var_4.angles = var_2.angles;
  var_5 = spawn("script_origin", var_0.origin);
  var_5.angles = var_0.angles;
  var_5 linkto(var_4);
  var_0 thread _id_41BB(var_5);

  for(;;) {
    var_2 waittill("precalcdone1");
    wait(var_2.waittime - 0.05);
    var_4 rotateto(var_2._id_41B7, var_1.time, var_1.time * 0.5, var_1.time * 0.5);
    var_2 waittill("precalcdone2");
    wait(var_2.waittime - 0.05);
    var_4 rotateto(var_2._id_41B7, var_1.time, var_1.time * 0.5, var_1.time * 0.5);
  }
}

_id_41BD() {
  self endon("manual_override");
  common_scripts\utility::flag_wait("_sea_bob");
  thread _id_41BF();
  wait 0.05;

  for(;;) {
    var_0 = 0;
    var_1 = 0;
    var_2 = randomfloatrange(2, 4) * level._id_41A5;
    self.time = randomfloatrange(3, 4);
    self._id_41B4 = (var_1, var_0, var_2);
    self._id_41A8 = "sway1";
    self notify("sway1");

    if(common_scripts\utility::flag("_sea_bob")) {
      level._id_41A9 rotateto(self._id_41B4, self.time, self.time * 0.5, self.time * 0.5);

    }
    self rotateto(self._id_41B4, self.time, self.time * 0.5, self.time * 0.5);
    wait(self.time);
    self._id_41B4 = self._id_41B4 * -1;
    self._id_41A8 = "sway2";
    self notify("sway2");

    if(common_scripts\utility::flag("_sea_bob")) {
      level._id_41A9 rotateto(self._id_41B4, self.time, self.time * 0.5, self.time * 0.5);

    }
    self rotateto(self._id_41B4, self.time, self.time * 0.5, self.time * 0.5);
    wait(self.time);
  }
}

_id_41BE() {
  self endon("manual_override");
  common_scripts\utility::flag_wait("_sea_bob");
  thread _id_41BF();
}

_id_41BF() {
  self endon("manual_override");
  level waittill("_sea_bob");
  thread _id_41BE();
  level endon("_sea_bob");
  var_0 = 1.5;
  var_1 = (0, 0, 0);
  level._id_41A9 rotateto(var_1, var_0, var_0 * 0.5, var_0 * 0.5);
  wait(var_0);
  wait 0.05;
  level._id_41AE = level._id_41AD;
  level._id_41A9.angles = (0, 0, 0);
}

_id_41C0() {
  var_0 = _id_41C7();

  if(!isDefined(var_0)) {
    return;
  }
  self._id_41C1 = [];

  for(;;) {
    common_scripts\utility::flag_wait("_sea_waves");
    self waittill("sway1");
    thread _id_41C2(var_0, "right");
    common_scripts\utility::flag_wait("_sea_waves");
    self waittill("sway2");
    thread _id_41C2(var_0, "left");
  }
}

_id_41C2(var_0, var_1) {
  wait(self.time * 0.5);
  var_2 = 2;
  var_3 = common_scripts\utility::random(_id_41C4(var_0[var_1], var_2));

  if(!isDefined(self._id_41C1[var_1])) {
    self._id_41C1[var_1] = var_3;

  }
  while(self._id_41C1[var_1] == var_3) {
    wait 0.05;
    var_3 = common_scripts\utility::random(_id_41C4(var_0[var_1], var_2));
  }

  self._id_41C1[var_1] = var_3;
  var_3 thread _id_41C3();
  thread common_scripts\utility::play_sound_in_space("elm_wave_crash_ext", var_3.origin);
}

_id_41C3() {
  wait(randomfloat(0.15));
  common_scripts\utility::exploder(self.exploder.v["exploder"]);
}

_id_41C4(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_0[var_3]._id_41C5 = distancesquared(var_0[var_3].origin, level.player.origin);

  }
  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_2 = _id_41C6(var_2, var_0[var_3]);

  }
  var_4 = [];

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_4[var_3] = var_2[var_3];

  }
  return var_4;
}

_id_41C6(var_0, var_1) {
  if(!var_0.size) {
    var_0[0] = var_1;
    return var_0;
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2]._id_41C5 > var_1._id_41C5) {
      var_0 = maps\_utility::_id_2673(var_0, var_1, var_2);
      break;
    }
  }

  if(var_2 == var_0.size) {
    var_0 = maps\_utility::_id_0BC3(var_0, var_1);

  }
  return var_0;
}

_id_41C7() {
  var_0 = common_scripts\utility::getstructarray("wave_fx", "targetname");
  var_1 = common_scripts\utility::getstruct("wave_fx_center", "targetname");

  if(!var_0.size) {
    return undefined;

  }
  var_2 = anglesToForward(var_1.angles);
  var_3 = anglestoright(var_1.angles);
  var_4 = [];
  var_4["right"] = [];
  var_4["left"] = [];

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_0[var_5].forward = anglesToForward(var_0[var_5].angles);
    var_0[var_5].up = anglestoup(var_0[var_5].angles);
    var_0[var_5].right = anglestoright(var_0[var_5].angles);
  }

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    if(vectordot(var_0[var_5].forward, var_3) > 0) {
      var_4["right"][var_4["right"].size] = var_0[var_5];
      continue;
    }

    var_4["left"][var_4["left"].size] = var_0[var_5];
  }

  var_6 = level._id_41C8;

  for(var_5 = 0; var_5 < var_6.size; var_5++) {
    var_6[var_5].origin = var_6[var_5].v["origin"];

  }
  for(var_5 = 0; var_5 < var_4["right"].size; var_5++) {
    var_7 = maps\_utility::_id_0AE9(var_4["right"][var_5].origin, var_6, 64);
    var_6 = common_scripts\utility::array_remove(var_6, var_7);

    if(isDefined(var_4["right"][var_5].angles)) {
      var_7.v["forward"] = anglestoup(var_4["right"][var_5].angles);

    }
    var_4["right"][var_5].exploder = var_7;
  }

  for(var_5 = 0; var_5 < var_4["left"].size; var_5++) {
    var_7 = maps\_utility::_id_0AE9(var_4["left"][var_5].origin, var_6, 64);
    var_6 = common_scripts\utility::array_remove(var_6, var_7);

    if(isDefined(var_4["left"][var_5].angles)) {
      var_7.v["forward"] = anglestoup(var_4["left"][var_5].angles);

    }
    var_4["left"][var_5].exploder = var_7;
  }

  return var_4;
}

_id_41C9() {
  for(;;) {
    wait 0.2;
    var_0 = self.angles * 2;
    var_0 = (var_0[0], var_0[1], var_0[2]);
    var_1 = level._id_41AE;
    level._id_41AE = combineangles(var_0, level._id_41AD);
    var_2 = level._id_41AE;
    var_3 = anglesToForward(var_1);
    var_4 = anglesToForward(var_2);
    lerpsundirection(var_3, var_4, 0.2);
  }
}

_id_41CA() {
  for(;;) {
    common_scripts\utility::flag_wait("_sea_viewbob");
    level.player playersetgroundreferenceent(self);

    if(common_scripts\utility::flag("_sea_viewbob")) {
      level waittill("_sea_viewbob");

    }
    level.player playersetgroundreferenceent(undefined);
  }
}