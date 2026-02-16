/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\271.gsc
**************************************/

_id_199A() {
  var_0 = getallnodes();
  var_1 = 0;
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(!(var_0[var_3].spawnflags & 2) && (isDefined(var_0[var_3].target) && getnodearray(var_0[var_3].target, "targetname").size > 0 || isDefined(var_0[var_3].targetname) && getnodearray(var_0[var_3].targetname, "target").size > 0)) {
      var_2[var_1] = var_0[var_3];
      var_1++;
    }
  }

  var_4 = 0;

  for(;;) {
    if(getDvar("chain") == "1") {
      for(var_3 = 0; var_3 < var_2.size; var_3++) {
        if(distance(level.player getorigin(), var_2[var_3].origin) < 1500) {}
      }

      var_5 = getaiarray("allies");

      for(var_3 = 0; var_3 < var_5.size; var_3++) {
        var_6 = var_5[var_3] animscripts\utility::_id_0BEE();

        if(isDefined(var_6)) {}
      }
    }

    common_scripts\utility::waitframe();
  }
}

_id_199B(var_0) {
  var_1 = getaiarray();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] getentitynumber() != var_0) {
      continue;
    }
    var_1[var_2] thread _id_199D();
    break;
  }
}

_id_199C(var_0) {
  var_1 = getaiarray();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] getentitynumber() != var_0) {
      continue;
    }
    var_1[var_2] notify("stop_drawing_enemy_pos");
    break;
  }
}

_id_199D() {
  self endon("death");
  self endon("stop_drawing_enemy_pos");

  for(;;) {
    wait 0.05;

    if(isalive(self.enemy)) {}

    if(!animscripts\utility::_id_0F8C()) {
      continue;
    }
    var_0 = animscripts\utility::_id_0CEE();
  }
}

_id_199E() {
  var_0 = getaiarray();
  var_1 = undefined;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1 = var_0[var_2];

    if(!isalive(var_1)) {
      continue;
    }
    if(isDefined(var_1.lastenemysightpos)) {}

    if(isDefined(var_1._id_199F)) {
      if(var_1 isbadguy()) {
        var_3 = (1, 0, 0);
      } else {
        var_3 = (0, 0, 1);
      }
      var_4 = var_1.origin + (0, 0, 54);

      if(isDefined(var_1.node)) {
        if(var_1.node.type == "Cover Left") {
          var_5 = 1;
          var_4 = anglestoright(var_1.node.angles);
          var_4 = var_4 * -32;
          var_4 = (var_4[0], var_4[1], 64);
          var_4 = var_1.node.origin + var_4;
        } else if(var_1.node.type == "Cover Right") {
          var_5 = 1;
          var_4 = anglestoright(var_1.node.angles);
          var_4 = var_4 * 32;
          var_4 = (var_4[0], var_4[1], 64);
          var_4 = var_1.node.origin + var_4;
        }
      }

      common_scripts\utility::draw_arrow(var_4, var_1._id_199F, var_3);
    }
  }

  if(1) {
    return;
  }
  if(!isalive(var_1)) {
    return;
  }
  if(isalive(var_1.enemy)) {}

  if(isDefined(var_1.lastenemysightpos)) {}

  if(isalive(var_1._id_19A0)) {}

  if(!var_1 animscripts\utility::_id_0F8C()) {
    return;
  }
  var_6 = var_1 animscripts\utility::_id_0CEE();

  if(isDefined(var_1._id_199F)) {
    return;
  }
}

_id_19A1(var_0) {}

_id_19A2(var_0, var_1, var_2) {
  var_3 = self gettagorigin(var_0);
  var_4 = self gettagangles(var_0);
  _id_19A6(var_3, var_4, var_1, var_2);
}

_id_19A3(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  for(;;) {
    if(isDefined(self)) {
      var_1 = self.origin;
      var_2 = self.angles;
    }

    _id_19A6(var_1, var_2, var_0);
    wait 0.05;
  }
}

_id_19A4(var_0, var_1) {
  for(;;) {
    _id_19A6(var_0, var_1);
    wait 0.05;
  }
}

_id_19A5() {
  while(isDefined(self)) {
    _id_19A6(self.origin, self.angles);
    wait 0.05;
  }
}

_id_19A6(var_0, var_1, var_2, var_3) {
  var_4 = 10;
  var_5 = anglesToForward(var_1);
  var_6 = var_5 * var_4;
  var_7 = var_5 * (var_4 * 0.8);
  var_8 = anglestoright(var_1);
  var_9 = var_8 * (var_4 * -0.2);
  var_10 = var_8 * (var_4 * 0.2);
  var_11 = anglestoup(var_1);
  var_8 = var_8 * var_4;
  var_11 = var_11 * var_4;
  var_12 = (0.9, 0.2, 0.2);
  var_13 = (0.2, 0.9, 0.2);
  var_14 = (0.2, 0.2, 0.9);

  if(isDefined(var_2)) {
    var_12 = var_2;
    var_13 = var_2;
    var_14 = var_2;
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  }
}

_id_19A7(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 100;
  }
  if(!isDefined(var_1)) {
    var_1 = (0, 1, 0);
  }
  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    var_2 = anglesToForward(self.angles);
    wait 0.05;
  }
}

_id_19A8() {
  for(;;) {
    _id_19A6(level.player.origin, level.player getplayerangles(), (1, 1, 1));
    wait 0.05;
  }
}

_id_19A9(var_0, var_1) {
  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    _id_19A2(var_0, var_1);
    wait 0.05;
  }
}

_id_19AA(var_0, var_1) {
  for(;;) {
    if(!isDefined(self.origin)) {
      break;
    }

    _id_19A2(var_0, var_1, 1000);
    wait 0.05;
  }
}

_id_19AB(var_0, var_1) {
  self endon("death");

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(!isDefined(self.origin)) {
      break;
    }

    _id_19A2(var_0, var_1);
    wait 0.05;
  }
}

_id_19AC(var_0, var_1) {
  if(var_0 == "ai") {
    var_2 = getaiarray();

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_2[var_3] _id_19A2(var_1);
    }
  }
}

_id_19AD() {
  level.player.ignoreme = 1;
  var_0 = getallnodes();
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2].type == "Cover Left") {
      var_1[var_1.size] = var_0[var_2];
    }
    if(var_0[var_2].type == "Cover Right") {
      var_1[var_1.size] = var_0[var_2];
    }
  }

  var_3 = getaiarray();

  for(var_2 = 0; var_2 < var_3.size; var_2++) {
    var_3[var_2] delete();
  }
  level._id_19AE = getspawnerarray();
  level._id_19AF = [];
  level._id_19B0 = [];

  for(var_2 = 0; var_2 < level._id_19AE.size; var_2++) {
    level._id_19AE[var_2].targetname = "blah";
  }
  var_4 = 0;

  for(var_2 = 0; var_2 < 30; var_2++) {
    if(var_2 >= var_1.size) {
      break;
    }

    var_1[var_2] thread _id_19B1();
    var_4++;
  }

  if(var_1.size <= 30) {
    return;
  }
  for(;;) {
    level waittill("debug_next_corner");

    if(var_4 >= var_1.size) {
      var_4 = 0;
    }
    var_1[var_4] thread _id_19B1();
    var_4++;
  }
}

_id_19B1() {
  _id_19B2();
}

_id_19B2() {
  var_0 = undefined;
  var_1 = undefined;

  for(;;) {
    for(var_2 = 0; var_2 < level._id_19AE.size; var_2++) {
      wait 0.05;
      var_1 = level._id_19AE[var_2];
      var_3 = 0;

      for(var_4 = 0; var_4 < level._id_19AF.size; var_4++) {
        if(distance(level._id_19AF[var_4].origin, self.origin) > 250) {
          continue;
        }
        var_3 = 1;
        break;
      }

      if(var_3) {
        continue;
      }
      var_5 = 0;

      for(var_4 = 0; var_4 < level._id_19B0.size; var_4++) {
        if(level._id_19B0[var_4] != self) {
          continue;
        }
        var_5 = 1;
        break;
      }

      if(var_5) {
        continue;
      }
      level._id_19AF[level._id_19AF.size] = self;
      var_1.origin = self.origin;
      var_1.angles = self.angles;
      var_1.count = 1;
      var_0 = var_1 stalingradspawn();

      if(maps\_utility::_id_13AF(var_0)) {
        _id_19B4(self);
        continue;
      }

      break;
    }

    if(isalive(var_0)) {
      break;
    }
  }

  wait 1;

  if(isalive(var_0)) {
    var_0.ignoreme = 1;
    var_0.team = "neutral";
    var_0 setgoalpos(var_0.origin);
    thread _id_19B5(self.origin);
    var_0 thread maps\_utility::_id_19B3();
    thread _id_19B6(var_0);
    var_0 waittill("death");
  }

  _id_19B4(self);
  level._id_19B0[level._id_19B0.size] = self;
}

_id_19B4(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < level._id_19AF.size; var_2++) {
    if(level._id_19AF[var_2] == var_0) {
      continue;
    }
    var_1[var_1.size] = level._id_19AF[var_2];
  }

  level._id_19AF = var_1;
}

_id_19B5(var_0) {
  for(;;) {
    wait 0.05;
  }
}

_id_19B6(var_0) {
  var_1 = undefined;

  while(isalive(var_0)) {
    var_1 = var_0.origin;
    wait 0.05;
  }

  for(;;) {
    wait 0.05;
  }
}

_id_19B7() {
  self notify("stopdebugmisstime");
  self endon("stopdebugmisstime");
  self endon("death");

  for(;;) {
    if(self.a._id_19B8 <= 0) {} else {}

    wait 0.05;
  }
}

_id_19B9() {
  self notify("stopdebugmisstime");
}

_id_19BA(var_0, var_1) {}

_id_19BB(var_0) {}

_id_19BC() {}

_id_19BD() {}

_id_19BE() {}

_id_19BF() {}

_id_19C0() {}

_id_19C1() {}

_id_19C2() {}

_id_19C3() {}

_id_19C4() {
  self endon("death");

  for(;;) {
    playFXOnTag(common_scripts\utility::getfx("lighting_fraction"), self, "tag_origin");
    wait 0.1;
  }
}

_id_19C5() {}

_id_19C6() {}

_id_19C7() {
  var_0 = undefined;
  var_1 = undefined;
  var_0 = (15.1859, -12.2822, 4.071);
  var_1 = (947.2, -10918, 64.9514);

  for(;;) {
    wait 0.05;
    var_2 = var_0;
    var_3 = var_1;

    if(!isDefined(var_0)) {
      var_2 = level._id_19C8;
    }
    if(!isDefined(var_1)) {
      var_3 = level.player getEye();
    }
    var_4 = bulletTrace(var_2, var_3, 0, undefined);
  }
}

hatmodel() {}

_id_19C9() {
  var_0 = newhudelem();
  var_0.alignx = "left";
  var_0.aligny = "middle";
  var_0.x = 10;
  var_0.y = 100;
  var_0.label = &"DEBUG_DRONES";
  var_0.alpha = 0;
  var_1 = newhudelem();
  var_1.alignx = "left";
  var_1.aligny = "middle";
  var_1.x = 10;
  var_1.y = 115;
  var_1.label = &"DEBUG_ALLIES";
  var_1.alpha = 0;
  var_2 = newhudelem();
  var_2.alignx = "left";
  var_2.aligny = "middle";
  var_2.x = 10;
  var_2.y = 130;
  var_2.label = &"DEBUG_AXIS";
  var_2.alpha = 0;
  var_3 = newhudelem();
  var_3.alignx = "left";
  var_3.aligny = "middle";
  var_3.x = 10;
  var_3.y = 145;
  var_3.label = &"DEBUG_VEHICLES";
  var_3.alpha = 0;
  var_4 = newhudelem();
  var_4.alignx = "left";
  var_4.aligny = "middle";
  var_4.x = 10;
  var_4.y = 160;
  var_4.label = &"DEBUG_TOTAL";
  var_4.alpha = 0;
  var_5 = "off";

  for(;;) {
    var_6 = getDvar("debug_character_count");

    if(var_6 == "off") {
      if(var_6 != var_5) {
        var_0.alpha = 0;
        var_1.alpha = 0;
        var_2.alpha = 0;
        var_3.alpha = 0;
        var_4.alpha = 0;
        var_5 = var_6;
      }

      wait 0.25;
      continue;
    } else if(var_6 != var_5) {
      var_0.alpha = 1;
      var_1.alpha = 1;
      var_2.alpha = 1;
      var_3.alpha = 1;
      var_4.alpha = 1;
      var_5 = var_6;
    }

    var_7 = getEntArray("drone", "targetname").size;
    var_0 setvalue(var_7);
    var_8 = getaiarray("allies").size;
    var_1 setvalue(var_8);
    var_9 = getaiarray("bad_guys").size;
    var_2 setvalue(var_9);
    var_3 setvalue(getEntArray("script_vehicle", "classname").size);
    var_4 setvalue(var_7 + var_8 + var_9);
    wait 0.25;
  }
}

_id_19CA() {
  if(!self.damageshield) {
    self kill((0, 0, -500), level.player, level.player);
  }
}

_id_19CB() {}

_id_19CC() {}

_id_19CD() {
  wait 0.05;
  var_0 = getEntArray("camera", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = getent(var_0[var_1].target, "targetname");
    var_0[var_1]._id_19CE = var_2.origin;
    var_0[var_1].angles = vectortoangles(var_2.origin - var_0[var_1].origin);
  }

  for(;;) {
    var_3 = getaiarray("axis");

    if(!var_3.size) {
      _id_19CF();
      wait 0.5;
      continue;
    }

    var_4 = [];

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      for(var_5 = 0; var_5 < var_3.size; var_5++) {
        if(distance(var_0[var_1].origin, var_3[var_5].origin) > 256) {
          continue;
        }
        var_4[var_4.size] = var_0[var_1];
        break;
      }
    }

    if(!var_4.size) {
      _id_19CF();
      wait 0.5;
      continue;
    }

    var_6 = [];

    for(var_1 = 0; var_1 < var_4.size; var_1++) {
      var_7 = var_4[var_1];
      var_8 = var_7._id_19CE;
      var_9 = var_7.origin;
      var_10 = vectortoangles((var_9[0], var_9[1], var_9[2]) - (var_8[0], var_8[1], var_8[2]));
      var_11 = (0, var_10[1], 0);
      var_12 = anglesToForward(var_11);
      var_10 = vectornormalize(var_9 - level.player.origin);
      var_13 = vectordot(var_12, var_10);

      if(var_13 < 0.85) {
        continue;
      }
      var_6[var_6.size] = var_7;
    }

    if(!var_6.size) {
      _id_19CF();
      wait 0.5;
      continue;
    }

    var_14 = distance(level.player.origin, var_6[0].origin);
    var_15 = var_6[0];

    for(var_1 = 1; var_1 < var_6.size; var_1++) {
      var_16 = distance(level.player.origin, var_6[var_1].origin);

      if(var_16 > var_14) {
        continue;
      }
      var_15 = var_6[var_1];
      var_14 = var_16;
    }

    _id_19D0(var_15);
    wait 3;
  }
}

_id_19CF() {
  setDvar("cl_freemove", "0");
}

_id_19D0(var_0) {
  setDvar("cl_freemove", "2");
}

_id_19D1() {
  for(;;) {
    if(getDvar("angles", "0") == "1") {
      setDvar("angles", "0");
    }
    wait 1;
  }
}

_id_19D2() {
  if(!isDefined(level._id_19D3)) {
    level._id_19D3 = 5;
  }
  setDvar("dolly", "");
  thread _id_19D4();
  thread _id_19D5();
  thread _id_19D6();
}

_id_19D4() {
  for(;;) {
    if(getDvar("dolly") == "start") {
      level._id_19D4 = level.player.origin;
      setDvar("dolly", "");
    }

    wait 1;
  }
}

_id_19D5() {
  for(;;) {
    if(getDvar("dolly") == "end") {
      level._id_19D5 = level.player.origin;
      setDvar("dolly", "");
    }

    wait 1;
  }
}

_id_19D6() {
  for(;;) {
    wait 1;

    if(getDvar("dolly") == "go") {
      setDvar("dolly", "");

      if(!isDefined(level._id_19D4)) {
        continue;
      }
      if(!isDefined(level._id_19D5)) {
        continue;
      }
      var_0 = spawn("script_origin", (0, 0, 0));
      var_0.origin = level._id_19D4;
      level.player setorigin(var_0.origin);
      level.player linkto(var_0);
      var_0 moveto(level._id_19D5, level._id_19D3);
      wait(level._id_19D3);
      var_0 delete();
    }
  }
}

_id_19D7() {
  waittillframeend;

  for(var_0 = 0; var_0 < 50; var_0++) {
    if(!isDefined(level._id_19D8[var_0])) {
      continue;
    }
    var_1 = level._id_19D8[var_0];

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = var_1[var_2];

      if(isDefined(var_3._id_19D9)) {
        continue;
      }
    }
  }
}

_id_19DA() {}

_id_19DB() {
  precacheitem("defaultweapon");

  for(;;) {
    _id_19DC();
    wait 0.25;
  }
}

_id_19DC() {
  var_0 = getdvarfloat("scr_requiredMapAspectRatio", 1);

  if(!isDefined(level._id_19DD)) {
    setDvar("scr_minimap_corner_targetname", "minimap_corner");
    level._id_19DD = "minimap_corner";
  }

  if(!isDefined(level._id_19DE)) {
    setDvar("scr_minimap_height", "0");
    level._id_19DE = 0;
  }

  var_1 = getdvarfloat("scr_minimap_height");
  var_2 = getDvar("scr_minimap_corner_targetname");

  if(var_1 != level._id_19DE || var_2 != level._id_19DD) {
    if(isDefined(level._id_19DF)) {
      level._id_19E0 unlink();
      level._id_19DF delete();
      level notify("end_draw_map_bounds");
    }

    if(var_1 > 0) {
      level._id_19DE = var_1;
      level._id_19DD = var_2;
      var_3 = level.player;
      var_4 = getEntArray(var_2, "targetname");

      if(var_4.size == 2) {
        var_5 = var_4[0].origin + var_4[1].origin;
        var_5 = (var_5[0] * 0.5, var_5[1] * 0.5, var_5[2] * 0.5);
        var_6 = (var_4[0].origin[0], var_4[0].origin[1], var_5[2]);
        var_7 = (var_4[0].origin[0], var_4[0].origin[1], var_5[2]);

        if(var_4[1].origin[0] > var_4[0].origin[0]) {
          var_6 = (var_4[1].origin[0], var_6[1], var_6[2]);
        } else {
          var_7 = (var_4[1].origin[0], var_7[1], var_7[2]);
        }
        if(var_4[1].origin[1] > var_4[0].origin[1]) {
          var_6 = (var_6[0], var_4[1].origin[1], var_6[2]);
        } else {
          var_7 = (var_7[0], var_4[1].origin[1], var_7[2]);
        }
        var_8 = var_6 - var_5;
        var_5 = (var_5[0], var_5[1], var_5[2] + var_1);
        var_9 = spawn("script_origin", var_3.origin);
        var_10 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
        var_11 = (var_10[1], 0 - var_10[0], 0);
        var_12 = vectordot(var_10, var_8);

        if(var_12 < 0) {
          var_12 = 0 - var_12;
        }
        var_13 = vectordot(var_11, var_8);

        if(var_13 < 0) {
          var_13 = 0 - var_13;
        }
        if(var_0 > 0) {
          var_14 = var_13 / var_12;

          if(var_14 < var_0) {
            var_15 = var_0 / var_14;
            var_13 = var_13 * var_15;
            var_16 = vecscale(var_11, vectordot(var_11, var_6 - var_5) * (var_15 - 1));
            var_7 = var_7 - var_16;
            var_6 = var_6 + var_16;
          } else {
            var_15 = var_14 / var_0;
            var_12 = var_12 * var_15;
            var_16 = vecscale(var_10, vectordot(var_10, var_6 - var_5) * (var_15 - 1));
            var_7 = var_7 - var_16;
            var_6 = var_6 + var_16;
          }
        }

        if(level.console) {
          var_17 = 1.77778;
          var_18 = 2 * atan(var_13 * 0.8 / var_1);
          var_19 = 2 * atan(var_12 * var_17 * 0.8 / var_1);
        } else {
          var_17 = 1.33333;
          var_18 = 2 * atan(var_13 * 1.05 / var_1);
          var_19 = 2 * atan(var_12 * var_17 * 1.05 / var_1);
        }

        if(var_18 > var_19) {
          var_20 = var_18;
        } else {
          var_20 = var_19;
        }
        var_21 = var_1 - 1000;

        if(var_21 < 16) {
          var_21 = 16;
        }
        if(var_21 > 10000) {
          var_21 = 10000;
        }
        var_3 playerlinktoabsolute(var_9);
        var_9.origin = var_5 + (0, 0, -62);
        var_9.angles = (90, getnorthyaw(), 0);
        var_3 giveweapon("defaultweapon");
        setsaveddvar("cg_fov", var_20);
        level._id_19E0 = var_3;
        level._id_19DF = var_9;
        thread _id_19E4(var_5, var_7, var_6);
      } else {}
    }
  }
}

_id_19E1() {
  var_0 = [];
  var_0 = getEntArray("minimap_line", "script_noteworthy");
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1[var_2] = var_0[var_2] _id_19E2();
  }
  return var_1;
}

_id_19E2() {
  var_0 = [];
  var_1 = self;

  while(isDefined(var_1)) {
    var_0[var_0.size] = var_1;

    if(!isDefined(var_1) || !isDefined(var_1.target)) {
      break;
    }

    var_1 = getent(var_1.target, "targetname");

    if(isDefined(var_1) && var_1 == var_0[0]) {
      var_0[var_0.size] = var_1;
      break;
    }
  }

  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_2[var_3] = var_0[var_3].origin;
  }
  return var_2;
}

vecscale(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}

_id_19E4(var_0, var_1, var_2) {
  level notify("end_draw_map_bounds");
  level endon("end_draw_map_bounds");
  var_3 = var_0[2] - var_2[2];
  var_4 = length(var_1 - var_2);
  var_5 = var_1 - var_0;
  var_5 = vectornormalize((var_5[0], var_5[1], 0));
  var_1 = var_1 + vecscale(var_5, var_4 * 1 / 800 * 0);
  var_6 = var_2 - var_0;
  var_6 = vectornormalize((var_6[0], var_6[1], 0));
  var_2 = var_2 + vecscale(var_6, var_4 * 1 / 800 * 0);
  var_7 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  var_8 = var_2 - var_1;
  var_9 = vecscale(var_7, vectordot(var_8, var_7));
  var_10 = vecscale(var_7, abs(vectordot(var_8, var_7)));
  var_11 = var_1;
  var_12 = var_1 + var_9;
  var_13 = var_2;
  var_14 = var_2 - var_9;
  var_15 = vecscale(var_1 + var_2, 0.5) + vecscale(var_10, 0.51);
  var_16 = var_4 * 0.003;
  var_17 = _id_19E1();

  for(;;) {
    common_scripts\utility::array_levelthread(var_17, common_scripts\utility::plot_points);
    wait 0.05;
  }
}

_id_19E5(var_0) {
  var_1 = vectornormalize(var_0 - self getshootatpos());
  var_2 = vectornormalize(var_0 - (0, 0, 24) - self getshootatpos());
  var_3 = vectordot(var_1, var_2);
  var_4 = anglesToForward(self getplayerangles());
  var_5 = vectordot(var_4, var_1);

  if(var_5 > var_3) {
    return 1;
  } else {
    return 0;
  }
}

_id_19E6() {
  wait 0.05;
  var_0 = getaiarray();
  var_1 = [];
  var_1["axis"] = [];
  var_1["allies"] = [];
  var_1["neutral"] = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(!isDefined(var_3._id_134D)) {
      continue;
    }
    var_1[var_3.team][var_3._id_134D] = 1;
    var_4 = (1, 1, 1);

    if(isDefined(var_3._id_134B)) {
      var_4 = level._id_19E7[var_3._id_134B];
    }
    if(var_3.team == "axis") {
      continue;
    }
    var_3 _id_19EB();
  }

  _id_19E8(var_1, "allies");
  _id_19E8(var_1, "axis");
}

_id_19E8(var_0, var_1) {
  var_2 = getarraykeys(var_0[var_1]);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = (1, 1, 1);
    var_4 = level._id_19E7[getsubstr(var_2[var_3], 0, 1)];

    if(isDefined(level._id_19E9[var_1][var_2[var_3]])) {
      var_5 = level._id_19E9[var_1][var_2[var_3]];

      for(var_6 = 0; var_6 < var_5.size; var_6++) {}
    }
  }
}

_id_19EA() {
  if(self.team == "allies") {
    if(!isDefined(self.node._id_1341)) {
      return;
    }
    return self.node._id_1341;
  }

  if(self.team == "axis") {
    if(!isDefined(self.node._id_1342)) {
      return;
    }
    return self.node._id_1342;
  }
}

_id_19EB() {
  if(!isDefined(self.node)) {
    return;
  }
  if(!isDefined(self._id_134B)) {
    return;
  }
  var_0 = _id_19EA();

  if(!isDefined(var_0)) {
    return;
  }
  if(!issubstr(var_0, self._id_134B)) {
    return;
  }
}

_id_19EC() {
  if(getDvar("depth_close") == "") {
    setDvar("depth_close", "0");
  }
  if(getDvar("depth_far") == "") {
    setDvar("depth_far", "1500");
  }
  var_0 = getdvarint("depth_close");
  var_1 = getdvarint("depth_far");
  setexpfog(var_0, var_1, 1, 1, 1, 1, 0);
}

_id_19ED() {
  level._id_19EE = gettime();
  thread _id_19EF();
}

_id_19EF() {}

_id_19F0(var_0, var_1) {
  if(self.team == var_0.team) {
    return;
  }
  var_2 = 0;
  var_2 = var_2 + self.threatbias;
  var_3 = 0;
  var_3 = var_3 + var_0.threatbias;
  var_4 = undefined;

  if(isDefined(var_1)) {
    var_4 = self getthreatbiasgroup();

    if(isDefined(var_4)) {
      var_3 = var_3 + getthreatbias(var_1, var_4);
      var_2 = var_2 + getthreatbias(var_4, var_1);
    }
  }

  if(var_0.ignoreme || var_3 < -900000) {
    var_3 = "Ignore";
  }
  if(self.ignoreme || var_2 < -900000) {
    var_2 = "Ignore";
  }
  var_5 = 20;
  var_6 = (1, 0.5, 0.2);
  var_7 = (0.2, 0.5, 1);
  var_8 = !isPlayer(self) && self.pacifist;

  for(var_9 = 0; var_9 <= var_5; var_9++) {
    if(isDefined(var_1)) {}

    if(isDefined(var_4)) {}

    if(var_8) {}

    wait 0.05;
  }
}

_id_19F1() {
  level._id_13CA = [];
  level._id_19F2 = [];

  for(;;) {
    level waittill("updated_color_friendlies");
    _id_19F3();
  }
}

_id_19F3() {
  level endon("updated_color_friendlies");
  var_0 = getarraykeys(level._id_13CA);
  var_1 = [];
  var_2 = [];
  var_2[var_2.size] = "r";
  var_2[var_2.size] = "o";
  var_2[var_2.size] = "y";
  var_2[var_2.size] = "g";
  var_2[var_2.size] = "c";
  var_2[var_2.size] = "b";
  var_2[var_2.size] = "p";
  var_3 = maps\_utility::_id_19F4();

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_1[var_2[var_4]] = 0;
  }
  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = level._id_13CA[var_0[var_4]];
    var_1[var_5]++;
  }

  for(var_4 = 0; var_4 < level._id_19F2.size; var_4++) {
    level._id_19F2[var_4] destroy();
  }
  level._id_19F2 = [];
  var_6 = 15;
  var_7 = 365;
  var_8 = 25;
  var_9 = 25;

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    if(var_1[var_2[var_4]] <= 0) {
      continue;
    }
    for(var_10 = 0; var_10 < var_1[var_2[var_4]]; var_10++) {
      var_11 = newhudelem();
      var_11.x = var_6 + 25 * var_10;
      var_11.y = var_7;
      var_11 setshader("white", 16, 16);
      var_11.alignx = "left";
      var_11.aligny = "bottom";
      var_11.alpha = 1;
      var_11.color = var_3[var_2[var_4]];
      level._id_19F2[level._id_19F2.size] = var_11;
    }

    var_7 = var_7 + var_9;
  }
}

_id_19F5() {
  for(;;) {
    if(isDefined(level.player.node)) {}

    wait 0.05;
  }
}

_id_19F6() {
  if(isalive(self._id_1350)) {
    return;
  }
}

_id_19F7() {
  for(;;) {
    var_0 = getaiarray();
    common_scripts\utility::array_thread(var_0, ::_id_19F8);
    wait 0.05;
  }
}

_id_19F8() {
  if(!isDefined(self.goalpos)) {
    return;
  }
}

_id_19F9() {
  wait 0.5;
  var_0 = [];
  var_0[var_0.size] = "r";
  var_0[var_0.size] = "g";
  var_0[var_0.size] = "b";
  var_0[var_0.size] = "y";
  var_0[var_0.size] = "o";
  var_0[var_0.size] = "p";
  var_0[var_0.size] = "c";

  for(;;) {
    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_2 = level._id_1346["allies"][var_0[var_1]];

      if(isDefined(var_2)) {
        _id_19FA(var_2);
      }
    }

    wait 0.05;
  }
}

_id_19FA(var_0) {
  var_1 = level._id_133E["allies"][var_0];
  common_scripts\utility::array_thread(var_1, ::_id_19F6);
}

_id_19FB() {
  level._id_11E8 = [];
  level._id_19FC = [];
  waittillframeend;
  waittillframeend;
  var_0 = getarraykeys(level._id_11B6);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    _id_19FD(var_0[var_1]);
  }
  var_0 = getarraykeys(level._id_11B9);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    _id_19FE(var_0[var_1]);
  }
}

_id_19FD(var_0) {
  foreach(var_10, var_2 in level._id_11B6[var_0]) {
    foreach(var_9, var_4 in var_2) {
      foreach(var_6 in var_4) {
        var_7 = var_6["sound"];

        if(!isDefined(var_7)) {
          continue;
        }
        level._id_19FC[var_0][var_10][var_9]["soundalias"] = var_7;

        if(isDefined(var_6["created_by_animSound"])) {
          level._id_19FC[var_0][var_10][var_9]["created_by_animSound"] = 1;
        }
      }
    }
  }
}

_id_19FE(var_0) {
  var_1 = getarraykeys(level._id_11B9[var_0]);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_4 = level._id_11B9[var_0][var_3];
    level._id_19FC[var_0][var_3]["#" + var_3]["soundalias"] = var_4;
    level._id_19FC[var_0][var_3]["#" + var_3]["created_by_animSound"] = 1;
  }
}

_id_19FF(var_0, var_1, var_2) {
  var_3 = newhudelem();
  var_3.alignx = "left";
  var_3.aligny = "middle";
  var_3.x = var_0;
  var_3.y = var_1;
  var_3.alpha = 1;
  var_3.fontscale = 1;
  var_3.label = var_2;
  level._id_1A00[level._id_1A00.size] = var_3;
  return var_3;
}

_id_1A01() {}

_id_1A02() {
  var_0 = level._id_1A03;
  var_1 = var_0._id_11E8;
  var_2 = "generic";

  if(isDefined(var_0._id_1032)) {
    var_2 = var_0._id_1032;
  }
  level._id_1A04.label = "Actor: " + var_2;

  if(level.player buttonPressed("f12")) {
    if(!level._id_1A05) {
      level._id_1A06 = !level._id_1A06;
      level._id_1A05 = 1;
    }
  } else {
    level._id_1A05 = 0;
  }
  if(level.player buttonPressed("UPARROW")) {
    if(level._id_1A07 != "up") {
      level._id_1A08--;
    }
    level._id_1A07 = "up";
  } else if(level.player buttonPressed("DOWNARROW")) {
    if(level._id_1A07 != "down") {
      level._id_1A08++;
    }
    level._id_1A07 = "down";
  } else {
    level._id_1A07 = "none";
  }
  for(var_3 = 0; var_3 < level._id_11E7; var_3++) {
    var_4 = level._id_1A09[var_3];
    var_4.label = "";
    var_4.color = (1, 1, 1);
    var_4 = level._id_1A0A[var_3];
    var_4.label = "";
    var_4.color = (1, 1, 1);
    var_4 = level._id_1A0B[var_3];
    var_4.label = "";
    var_4.color = (1, 1, 1);
  }

  var_5 = getarraykeys(var_1);
  var_6 = -1;

  for(var_3 = 0; var_3 < var_5.size; var_3++) {
    if(var_5[var_3] > var_6) {
      var_6 = var_5[var_3];
    }
  }

  if(var_6 == -1) {
    return;
  }
  if(level._id_1A08 > var_6) {
    level._id_1A08 = var_6;
  }
  if(level._id_1A08 < 0) {
    level._id_1A08 = 0;
  }
  for(;;) {
    if(isDefined(var_1[level._id_1A08])) {
      break;
    }

    level._id_1A08--;

    if(level._id_1A08 < 0) {
      level._id_1A08 = var_6;
    }
  }

  level._id_1A0C.label = "Anim: " + var_1[level._id_1A08]._id_11EB;
  level._id_1A09[level._id_1A08].color = (1, 1, 0);
  level._id_1A0A[level._id_1A08].color = (1, 1, 0);
  level._id_1A0B[level._id_1A08].color = (1, 1, 0);
  var_7 = gettime();

  for(var_3 = 0; var_3 < var_5.size; var_3++) {
    var_8 = var_5[var_3];
    var_9 = var_1[var_8];
    var_4 = level._id_1A09[var_8];
    var_10 = _id_1A0D(var_9);
    var_4.label = var_8 + 1 + ". " + var_9._id_11EC;
    var_4 = level._id_1A0A[var_8];
    var_4.label = int((var_7 - (var_9._id_11E9 - 60000)) * 0.001);

    if(isDefined(var_10)) {
      var_4 = level._id_1A0B[var_8];
      var_4.label = var_10;

      if(!_id_1A0E(var_9._id_1032, var_9._id_11EB, var_9._id_11EC)) {
        var_4.color = (0.7, 0.7, 0.7);
      }
    }
  }

  if(level.player buttonPressed("del")) {
    var_9 = var_1[level._id_1A08];
    var_10 = _id_1A0D(var_9);

    if(!isDefined(var_10)) {
      return;
    }
    if(!_id_1A0E(var_9._id_1032, var_9._id_11EB, var_9._id_11EC)) {
      return;
    }
    level._id_19FC[var_9._id_1032][var_9._id_11EB][var_9._id_11EC] = undefined;
    _id_1A14();
  }
}

_id_1A0D(var_0) {
  if(!isDefined(level._id_19FC[var_0._id_1032])) {
    return;
  }
  if(!isDefined(level._id_19FC[var_0._id_1032][var_0._id_11EB])) {
    return;
  }
  if(!isDefined(level._id_19FC[var_0._id_1032][var_0._id_11EB][var_0._id_11EC])) {
    return;
  }
  return level._id_19FC[var_0._id_1032][var_0._id_11EB][var_0._id_11EC]["soundalias"];
}

_id_1A0E(var_0, var_1, var_2) {
  return isDefined(level._id_19FC[var_0][var_1][var_2]["created_by_animSound"]);
}

_id_1A0F() {
  if(distance(level.player.origin, self.origin) > 1500) {
    return;
  }
  level._id_1A10[level._id_1A10.size] = self;
}

_id_1A11(var_0) {}

_id_1A12() {}

_id_1A13(var_0, var_1) {
  if(!isDefined(level._id_1A03)) {
    return;
  }
  if(!isDefined(level._id_1A03._id_11E8[var_1])) {
    return;
  }
  var_2 = level._id_1A03._id_11E8[var_1];
  var_3 = _id_1A0D(var_2);

  if(!isDefined(var_3) || _id_1A0E(var_2._id_1032, var_2._id_11EB, var_2._id_11EC)) {
    level._id_19FC[var_2._id_1032][var_2._id_11EB][var_2._id_11EC]["soundalias"] = var_0;
    level._id_19FC[var_2._id_1032][var_2._id_11EB][var_2._id_11EC]["created_by_animSound"] = 1;
    _id_1A14();
  }
}

_id_1A14() {}

_id_1A15(var_0) {
  var_1 = "";
  var_2 = getarraykeys(level._id_19FC);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = getarraykeys(level._id_19FC[var_2[var_3]]);

    for(var_5 = 0; var_5 < var_4.size; var_5++) {
      var_6 = var_4[var_5];
      var_7 = getarraykeys(level._id_19FC[var_2[var_3]][var_6]);

      for(var_8 = 0; var_8 < var_7.size; var_8++) {
        var_9 = var_7[var_8];

        if(!_id_1A0E(var_2[var_3], var_6, var_9)) {
          continue;
        }
        var_10 = level._id_19FC[var_2[var_3]][var_6][var_9]["soundalias"];

        if(var_9 == "#" + var_6) {
          continue;
        }
      }
    }
  }
}

_id_1A16(var_0) {
  var_1 = "\"";

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] == "\"") {
      var_1 = var_1 + "\\";
      var_1 = var_1 + "\"";
      continue;
    }

    var_1 = var_1 + var_0[var_2];
  }

  var_1 = var_1 + "\"";
  return var_1;
}

_id_1A17(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_2)) {
    var_2 = (1, 1, 1);
  }
  if(isDefined(var_5)) {
    var_5 = var_5 * 20;

    for(var_6 = 0; var_6 < var_5; var_6++) {
      wait 0.05;
    }
  } else {
    for(;;) {
      wait 0.05;
    }
  }
}

_id_1A18(var_0, var_1, var_2) {
  for(;;) {
    wait 0.05;
  }
}

_id_1A19() {
  if(getDvar("credits_active") == "1") {
    wait 7;
    setDvar("credits_active", "0");
    maps\_endmission::_id_198E();
    return;
  }

  wait 7;
  maps\_utility::_id_195A();
}

_id_1A1A(var_0) {}

_id_1A1B(var_0) {
  if(!isDefined(level._id_1A1C)) {
    level._id_1A1C = -1;
  }
  if(level._id_1A1C == var_0) {
    return;
  }
  _id_1A1A(var_0);

  if(!isDefined(level._id_1A1D)) {
    return;
  }
  level._id_1A1C = var_0;

  if(!isDefined(level._id_1A1E)) {
    level._id_1A1E = level._id_1A1D common_scripts\utility::spawn_tag_origin();
  }
  thread _id_1A1F(level._id_1A1D);
}

_id_1A1F(var_0) {
  level notify("new_chasecam");
  level endon("new_chasecam");
  var_0 endon("death");
  level.player unlink();
  level.player playerlinktoblend(level._id_1A1E, "tag_origin", 2, 0.5, 0.5);
  wait 2;
  level.player playerlinktodelta(level._id_1A1E, "tag_origin", 1, 180, 180, 180, 180);

  for(;;) {
    wait 0.2;

    if(!isDefined(level._id_1A1D)) {
      return;
    }
    var_1 = level._id_1A1D.origin;
    var_2 = level._id_1A1D.angles;
    var_3 = anglesToForward(var_2);
    var_3 = var_3 * 200;
    var_1 = var_1 + var_3;
    var_2 = level.player getplayerangles();
    var_3 = anglesToForward(var_2);
    var_3 = var_3 * -200;
    level._id_1A1E moveto(var_1 + var_3, 0.2);
  }
}

_id_1A20() {
  foreach(var_1 in level.createfxent) {
    if(isDefined(var_1.looper)) {}
  }
}

_id_1A21(var_0, var_1) {}

_id_1A22(var_0) {
  if(!isDefined(level._id_1A23)) {
    level._id_1A23 = 9500;
  }
  level._id_1A23++;
  var_1 = "bridge_helpers";
  _id_1A21("origin", self.origin[0] + " " + self.origin[1] + " " + self.origin[2]);
  _id_1A21("angles", self.angles[0] + " " + self.angles[1] + " " + self.angles[2]);
  _id_1A21("targetname", "helper_model");
  _id_1A21("model", self.model);
  _id_1A21("classname", "script_model");
  _id_1A21("spawnflags", "4");
  _id_1A21("_color", "0.443137 0.443137 1.000000");

  if(isDefined(var_0)) {
    _id_1A21("script_noteworthy", var_0);
  }
}

_id_1A24(var_0) {}

_id_1A25() {
  var_0 = level.player getplayerangles();
  var_1 = anglesToForward(var_0);
  var_2 = level.player getEye();
  var_3 = self getEye();
  var_4 = vectortoangles(var_3 - var_2);
  var_5 = anglesToForward(var_4);
  var_6 = vectordot(var_5, var_1);
}