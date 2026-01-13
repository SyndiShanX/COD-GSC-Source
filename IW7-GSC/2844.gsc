/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2844.gsc
**************************************/

func_6636() {}

func_6639() {}

func_7D0D(var_0) {}

func_1876() {}

func_F390(var_0, var_1, var_2) {}

func_6638(var_0, var_1) {}

func_1877(var_0) {}

func_7997(var_0, var_1) {
  var_2 = getEntArray();
  var_3 = [];

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  foreach(var_5 in var_2) {
    if(!isDefined(var_5.classname)) {
      var_6 = "UNKNOWN?";
    } else {
      var_6 = var_5.classname;
    }

    if(var_0) {
      if(isai(var_5)) {
        var_6 = "actors";
      } else if(_isspawner(var_5)) {
        var_7 = getsubstr(var_6, 0, 5);

        if(var_7 == "actor") {
          var_6 = "AI_spawners";
        } else {
          var_6 = "vehicle_spawners";
        }
      } else if(isDefined(var_5.var_49BD))
        var_6 = var_5.classname + " CREATEFX";
      else if(!isDefined(var_5.code_classname)) {} else if(var_5.code_classname == "script_model") {
        if(var_5.model == "tag_origin") {
          var_6 = "script_model TAG_ORIGIN";
        }
      } else if(var_5.code_classname == "trigger_multiple") {
        var_7 = getsubstr(var_6, 0, 22);

        if(var_7 == "trigger_multiple_bcs_") {
          var_6 = "trigger_multiple_bcs";
        } else {
          var_6 = "trigger_multiple";
        }
      } else {
        var_7 = getsubstr(var_5.code_classname, 0, 10);

        if(var_7 == "weapon_iw7") {
          var_6 = "weapons";
        }

        var_7 = getsubstr(var_5.code_classname, 0, 5);

        if(var_7 == "actor") {
          var_6 = "drones";
        }
      }
    } else {
      if(isDefined(var_5.var_49BD)) {
        var_6 = "CREATEFX " + var_5.classname;
      }

      if(var_6 == "script_model") {
        var_6 = var_6 + (" " + var_5.model);
      }
    }

    if(!isDefined(var_3[var_6])) {
      var_3[var_6] = 0;
    }

    var_3[var_6]++;
  }

  if(!isDefined(var_1) || !var_1) {
    var_3 = func_10418(var_3);
  }

  return var_3;
}

func_10418(var_0) {
  var_1 = getarraykeys(var_0);

  for(var_2 = 0; var_2 < var_1.size - 1; var_2++) {
    for(var_3 = var_2 + 1; var_3 < var_1.size; var_3++) {
      if(stricmp(var_1[var_2], var_1[var_3]) > 0) {
        var_4 = var_1[var_3];
        var_1[var_3] = var_1[var_2];
        var_1[var_2] = var_4;
      }
    }
  }

  var_5 = [];

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_5[var_1[var_2]] = var_0[var_1[var_2]];
  }

  return var_5;
}

func_4ED2(var_0) {
  var_1 = _getaiarray();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] getentitynumber() != var_0) {
      continue;
    }
    var_1[var_2] thread func_4ED3();
    break;
  }
}

func_4F22(var_0) {
  var_1 = _getaiarray();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] getentitynumber() != var_0) {
      continue;
    }
    var_1[var_2] notify("stop_drawing_enemy_pos");
    break;
  }
}

func_4ED3() {
  self endon("death");
  self endon("stop_drawing_enemy_pos");

  for(;;) {
    wait 0.05;

    if(isalive(self.enemy)) {}

    if(!scripts\anim\utility::func_8BED()) {
      continue;
    }
    var_0 = scripts\anim\utility::func_7E90();
  }
}

func_4ED4() {
  var_0 = _getaiarray();
  var_1 = undefined;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1 = var_0[var_2];

    if(!isalive(var_1)) {
      continue;
    }
    if(isDefined(var_1.lastenemysightpos)) {}

    if(isDefined(var_1.goodshootpos)) {
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

      scripts\engine\utility::draw_arrow(var_4, var_1.goodshootpos, var_3);
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

  if(isalive(var_1._meth_8450)) {}

  if(!var_1 scripts\anim\utility::func_8BED()) {
    return;
  }
  var_6 = var_1 scripts\anim\utility::func_7E90();

  if(isDefined(var_1.goodshootpos)) {
    return;
  }
}

func_5B76(var_0) {}

func_5B88(var_0, var_1, var_2) {
  if(isDefined(self.model) && scripts\sp\utility::hastag(self.model, var_0)) {
    var_3 = self gettagorigin(var_0);
    var_4 = self gettagangles(var_0);
    func_5B6D(var_3, var_4, var_1, var_2);
  }
}

func_5B6D(var_0, var_1, var_2, var_3) {
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

func_5B89(var_0, var_1) {
  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    func_5B88(var_0, var_1);
    wait 0.05;
  }
}

func_5B1D(var_0, var_1) {
  self endon("death");

  for(;;) {
    if(!isDefined(self)) {
      break;
    }
    if(!isDefined(self.origin)) {
      break;
    }
    func_5B88(var_0, var_1);
    wait 0.05;
  }
}

func_133A3(var_0, var_1) {
  if(var_0 == "ai") {
    var_2 = _getaiarray();

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_2[var_3] func_5B88(var_1);
    }
  }
}

func_4EC1() {
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

  var_3 = _getaiarray();

  for(var_2 = 0; var_2 < var_3.size; var_2++) {
    var_3[var_2] delete();
  }

  level.var_4F54 = _getspawnerarray();
  level.var_1658 = [];
  level.var_4484 = [];

  for(var_2 = 0; var_2 < level.var_4F54.size; var_2++) {
    level.var_4F54[var_2].targetname = "blah";
  }

  var_4 = 0;

  for(var_2 = 0; var_2 < 30; var_2++) {
    if(var_2 >= var_1.size) {
      break;
    }
    var_1[var_2] thread func_474E();
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

    var_1[var_4] thread func_474E();
    var_4++;
  }
}

func_474E() {
  func_4747();
}

func_4747() {
  var_0 = undefined;
  var_1 = undefined;

  for(;;) {
    for(var_2 = 0; var_2 < level.var_4F54.size; var_2++) {
      wait 0.05;
      var_1 = level.var_4F54[var_2];
      var_3 = 0;

      for(var_4 = 0; var_4 < level.var_1658.size; var_4++) {
        if(distance(level.var_1658[var_4].origin, self.origin) > 250) {
          continue;
        }
        var_3 = 1;
        break;
      }

      if(var_3) {
        continue;
      }
      var_5 = 0;

      for(var_4 = 0; var_4 < level.var_4484.size; var_4++) {
        if(level.var_4484[var_4] != self) {
          continue;
        }
        var_5 = 1;
        break;
      }

      if(var_5) {
        continue;
      }
      level.var_1658[level.var_1658.size] = self;
      var_1.origin = self.origin;
      var_1.angles = self.angles;
      var_1.count = 1;
      var_0 = var_1 _meth_8393();

      if(scripts\sp\utility::func_106ED(var_0)) {
        func_E0C0(self);
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
    var_0 give_mp_super_weapon(var_0.origin);
    thread func_49E3(self.origin);
    var_0 thread scripts\sp\utility::func_4F4B();
    thread func_49E4(var_0);
    var_0 waittill("death");
  }

  func_E0C0(self);
  level.var_4484[level.var_4484.size] = self;
}

func_E0C0(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < level.var_1658.size; var_2++) {
    if(level.var_1658[var_2] == var_0) {
      continue;
    }
    var_1[var_1.size] = level.var_1658[var_2];
  }

  level.var_1658 = var_1;
}

func_49E3(var_0) {
  for(;;) {
    wait 0.05;
  }
}

func_49E4(var_0) {
  var_1 = undefined;

  while(isalive(var_0)) {
    var_1 = var_0.origin;
    wait 0.05;
  }

  for(;;) {
    wait 0.05;
  }
}

func_4F49() {
  self notify("stopdebugmisstime");
  self endon("stopdebugmisstime");
  self endon("death");

  for(;;) {
    if(self.a.var_B8D6 <= 0) {}

    wait 0.05;
  }
}

func_4F4A() {
  self notify("stopdebugmisstime");
}

func_4F46(var_0) {}

func_4F41() {}

func_E02E() {}

func_48F2() {}

func_CD1E() {}

func_4EDC() {}

func_4EDD() {}

func_1011D() {
  var_0 = undefined;
  var_1 = undefined;
  var_0 = (15.1859, -12.2822, 4.071);
  var_1 = (947.2, -10918, 64.9514);

  for(;;) {
    wait 0.05;
    var_2 = var_0;
    var_3 = var_1;

    if(!isDefined(var_0)) {
      var_2 = level.var_11A8E;
    }

    if(!isDefined(var_1)) {
      var_3 = level.player getEye();
    }

    var_4 = bulletTrace(var_2, var_3, 0, undefined);
  }
}

func_4EBB() {
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
    var_6 = getdvar("debug_character_count");

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
    var_8 = _getaiarray("allies").size;
    var_1 setvalue(var_8);
    var_9 = _getaiarray("bad_guys").size;
    var_2 setvalue(var_9);
    var_3 setvalue(getEntArray("script_vehicle", "classname").size);
    var_4 setvalue(var_7 + var_8 + var_9);
    wait 0.25;
  }
}

func_C1A6() {
  if(!self.damageshield) {
    if(isDefined(self.unittype) && self.unittype == "c12") {
      self _meth_81D0((0, 0, -500), level.player);
    } else {
      self _meth_81D0((0, 0, -500), level.player, level.player);
    }
  }
}

func_4EFD() {}

func_37A5() {
  wait 0.05;
  var_0 = getEntArray("camera", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = getent(var_0[var_1].target, "targetname");
    var_0[var_1].var_C712 = var_2.origin;
    var_0[var_1].angles = vectortoangles(var_2.origin - var_0[var_1].origin);
  }

  for(;;) {
    var_3 = _getaiarray("axis");

    if(!var_3.size) {
      func_7370();
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
      func_7370();
      wait 0.5;
      continue;
    }

    var_6 = [];

    for(var_1 = 0; var_1 < var_4.size; var_1++) {
      var_7 = var_4[var_1];
      var_8 = var_7.var_C712;
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
      func_7370();
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

    func_F7FD(var_15);
    wait 3;
  }
}

func_7370() {
  setdvar("cl_freemove", "0");
}

func_F7FD(var_0) {
  setdvar("cl_freemove", "2");
}

func_4E6B() {
  waittillframeend;

  for(var_0 = 0; var_0 < 50; var_0++) {
    if(!isDefined(level.var_4E6A[var_0])) {
      continue;
    }
    var_1 = level.var_4E6A[var_0];

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = var_1[var_2];

      if(isDefined(var_3.var_12844)) {
        continue;
      }
    }
  }
}

func_A9EF() {}

func_13ACF() {
  for(;;) {
    func_12ED1();
    wait 0.25;
  }
}

func_12ED1() {
  var_0 = getdvarfloat("scr_requiredMapAspectRatio", 1);

  if(!isDefined(level.var_B7AF)) {
    setdvar("scr_minimap_corner_targetname", "minimap_corner");
    level.var_B7AF = "minimap_corner";
  }

  if(!isDefined(level.var_B7B1)) {
    setdvar("scr_minimap_height", "0");
    level.var_B7B1 = 0;
  }

  var_1 = getdvarfloat("scr_minimap_height");
  var_2 = getdvar("scr_minimap_corner_targetname");

  if(var_1 != level.var_B7B1 || var_2 != level.var_B7AF) {
    if(isDefined(level.var_B7B2)) {
      level.var_B7B3 unlink();
      level.var_B7B2 delete();
      level notify("end_draw_map_bounds");
    }

    if(var_1 > 0) {
      level.var_B7B1 = var_1;
      level.var_B7AF = var_2;
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
          var_18 = 2 * _atan(var_13 * 0.8 / var_1);
          var_19 = 2 * _atan(var_12 * var_17 * 0.8 / var_1);
        } else {
          var_17 = 1.33333;
          var_18 = 2 * _atan(var_13 * 1.05 / var_1);
          var_19 = 2 * _atan(var_12 * var_17 * 1.05 / var_1);
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

        var_3 getweaponvarianttablename(var_9);
        var_9.origin = var_5 + (0, 0, -62);
        var_9.angles = (90, getnorthyaw(), 0);
        var_3 giveweapon("defaultweapon");
        _setsaveddvar("cg_fov", var_20);
        level.var_B7B3 = var_3;
        level.var_B7B2 = var_9;
        thread func_5B7E(var_5, var_7, var_6);
      }
    }
  }
}

func_7E1F() {
  var_0 = [];
  var_0 = getEntArray("minimap_line", "script_noteworthy");
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1[var_2] = var_0[var_2] func_7E1E();
  }

  return var_1;
}

func_7E1E() {
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

func_5B7E(var_0, var_1, var_2) {
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
  var_17 = func_7E1F();

  for(;;) {
    scripts\engine\utility::array_levelthread(var_17, scripts\engine\utility::plot_points);
    wait 0.05;
  }
}

func_4EC0() {
  wait 0.05;
  var_0 = _getaiarray();
  var_1 = [];
  var_1["axis"] = [];
  var_1["allies"] = [];
  var_1["neutral"] = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(!isDefined(var_3.var_4BDF)) {
      continue;
    }
    var_1[var_3.team][var_3.var_4BDF] = 1;
    var_4 = (1, 1, 1);

    if(isDefined(var_3.var_EDAD)) {
      var_4 = level.var_4391[var_3.var_EDAD];
    }

    if(var_3.team == "axis") {
      continue;
    }
    var_3 func_12879();
  }

  draw_colornodes(var_1, "allies");
  draw_colornodes(var_1, "axis");
}

draw_colornodes(var_0, var_1) {
  var_2 = getarraykeys(var_0[var_1]);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = (1, 1, 1);
    var_4 = level.var_4391[getsubstr(var_2[var_3], 0, 1)];

    if(isDefined(level.var_43AD[var_1][var_2[var_3]])) {
      var_5 = level.var_43AD[var_1][var_2[var_3]];

      for(var_6 = 0; var_6 < var_5.size; var_6++) {}
    }
  }
}

func_7CE8() {
  if(self.team == "allies") {
    if(!isDefined(self.node.var_ED33)) {
      return;
    }
    return self.node.var_ED33;
  }

  if(self.team == "axis") {
    if(!isDefined(self.node.var_ED34)) {
      return;
    }
    return self.node.var_ED34;
  }
}

func_12879() {
  if(!isDefined(self.node)) {
    return;
  }
  if(!isDefined(self.var_EDAD)) {
    return;
  }
  var_0 = func_7CE8();

  if(!isDefined(var_0)) {
    return;
  }
  if(!issubstr(var_0, self.var_EDAD)) {
    return;
  }
}

func_4F55() {
  level.var_A91E = gettime();
  thread func_4F56();
}

func_4F56() {}

func_56E2(var_0, var_1) {
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
  var_8 = !isplayer(self) && self.pacifist;

  for(var_9 = 0; var_9 <= var_5; var_9++) {
    if(isDefined(var_1)) {}

    if(isDefined(var_4)) {}

    if(var_8) {}

    wait 0.05;
  }
}

func_4F3B() {
  level.var_4EBE = [];
  level.var_4EBF = [];

  for(;;) {
    level waittill("updated_color_friendlies");
    draw_closest_wall_points();
  }
}

func_7C31() {
  var_0 = [];
  var_0["r"] = (1, 0, 0);
  var_0["o"] = (1, 0.5, 0);
  var_0["y"] = (1, 1, 0);
  var_0["g"] = (0, 1, 0);
  var_0["c"] = (0, 1, 1);
  var_0["b"] = (0, 0, 1);
  var_0["p"] = (1, 0, 1);
  return var_0;
}

draw_closest_wall_points() {
  level endon("updated_color_friendlies");
  var_0 = getarraykeys(level.var_4EBE);
  var_1 = [];
  var_2 = [];
  var_2[var_2.size] = "r";
  var_2[var_2.size] = "o";
  var_2[var_2.size] = "y";
  var_2[var_2.size] = "g";
  var_2[var_2.size] = "c";
  var_2[var_2.size] = "b";
  var_2[var_2.size] = "p";
  var_3 = func_7C31();

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_1[var_2[var_4]] = 0;
  }

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = level.var_4EBE[var_0[var_4]];
    var_1[var_5]++;
  }

  for(var_4 = 0; var_4 < level.var_4EBF.size; var_4++) {
    level.var_4EBF[var_4] destroy();
  }

  level.var_4EBF = [];
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
      level.var_4EBF[level.var_4EBF.size] = var_11;
    }

    var_7 = var_7 + var_9;
  }
}

func_77F0(var_0) {
  if(!isDefined(level.var_1FD4[var_0.var_1FBB])) {
    return;
  }
  if(!isDefined(level.var_1FD4[var_0.var_1FBB][var_0.var_1FAF])) {
    return;
  }
  if(!isDefined(level.var_1FD4[var_0.var_1FBB][var_0.var_1FAF][var_0.var_C0C2])) {
    return;
  }
  return level.var_1FD4[var_0.var_1FBB][var_0.var_1FAF][var_0.var_C0C2]["soundalias"];
}

func_9BEC(var_0, var_1, var_2) {
  return isDefined(level.var_1FD4[var_0][var_1][var_2]["created_by_animSound"]);
}

func_4EA9(var_0) {}

func_4EAA() {}

func_113E6(var_0, var_1) {
  if(!isDefined(level.var_1FDA)) {
    return;
  }
  if(!isDefined(level.var_1FDA.var_1FDC[var_1])) {
    return;
  }
  var_2 = level.var_1FDA.var_1FDC[var_1];
  var_3 = func_77F0(var_2);

  if(!isDefined(var_3) || func_9BEC(var_2.var_1FBB, var_2.var_1FAF, var_2.var_C0C2)) {
    level.var_1FD4[var_2.var_1FBB][var_2.var_1FAF][var_2.var_C0C2]["soundalias"] = var_0;
    level.var_1FD4[var_2.var_1FBB][var_2.var_1FAF][var_2.var_C0C2]["created_by_animSound"] = 1;
  }
}

func_6C96(var_0) {}

func_3D44(var_0) {
  if(!isDefined(level.var_3D30)) {
    level.var_3D30 = -1;
  }

  if(level.var_3D30 == var_0) {
    return;
  }
  func_6C96(var_0);

  if(!isDefined(level.var_3D31)) {
    return;
  }
  level.var_3D30 = var_0;

  if(!isDefined(level.var_3D2F)) {
    level.var_3D2F = level.var_3D31 scripts\engine\utility::spawn_tag_origin();
  }

  thread func_3D45(level.var_3D31);
}

func_3D45(var_0) {
  level notify("new_chasecam");
  level endon("new_chasecam");
  var_0 endon("death");
  level.player unlink();
  level.player getweaponweight(level.var_3D2F, "tag_origin", 2, 0.5, 0.5);
  wait 2;
  level.player getweightedchanceroll(level.var_3D2F, "tag_origin", 1, 180, 180, 180, 180);

  for(;;) {
    wait 0.2;

    if(!isDefined(level.var_3D31)) {
      return;
    }
    var_1 = level.var_3D31.origin;
    var_2 = level.var_3D31.angles;
    var_3 = anglesToForward(var_2);
    var_3 = var_3 * 200;
    var_1 = var_1 + var_3;
    var_2 = level.player getplayerangles();
    var_3 = anglesToForward(var_2);
    var_3 = var_3 * -200;
    level.var_3D2F moveto(var_1 + var_3, 0.2);
  }
}

func_13399() {
  foreach(var_1 in level.createfxent) {
    if(isDefined(var_1.looper)) {}
  }
}

func_1705(var_0, var_1) {}

func_D908(var_0) {
  if(!isDefined(level.var_134AD)) {
    level.var_134AD = 9500;
  }

  level.var_134AD++;
  var_1 = "bridge_helpers";
  func_1705("origin", self.origin[0] + " " + self.origin[1] + " " + self.origin[2]);
  func_1705("angles", self.angles[0] + " " + self.angles[1] + " " + self.angles[2]);
  func_1705("targetname", "helper_model");
  func_1705("model", self.model);
  func_1705("classname", "script_model");
  func_1705("spawnflags", "4");
  func_1705("_color", "0.443137 0.443137 1.000000");

  if(isDefined(var_0)) {
    func_1705("script_noteworthy", var_0);
  }
}

draw_dot_for_ent(var_0) {}

draw_dot_for_guy() {
  var_0 = level.player getplayerangles();
  var_1 = anglesToForward(var_0);
  var_2 = level.player getEye();
  var_3 = self getEye();
  var_4 = vectortoangles(var_3 - var_2);
  var_5 = anglesToForward(var_4);
  var_6 = vectordot(var_5, var_1);
}

func_13C26() {
  setdvarifuninitialized("weaponlist", "0");

  if(!getdvarint("weaponlist")) {
    return;
  }
  var_0 = getEntArray();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3.code_classname)) {
      continue;
    }
    if(issubstr(var_3.code_classname, "weapon")) {
      var_1[var_3.classname] = 1;
    }
  }

  foreach(var_7, var_6 in var_1) {}

  var_8 = _getspawnerarray();
  var_9 = [];

  foreach(var_11 in var_8) {
    var_9[var_11.code_classname] = 1;
  }

  foreach(var_14, var_6 in var_9) {}
}

func_B514() {
  thread func_4EC2();
  setdvar("debug_measure", 2);
  var_0 = [];
  var_1 = 0;

  while(getdvarint("debug_measure")) {
    if(level.player usebuttonpressed() && gettime() > var_1) {
      if(var_0.size == 2) {
        var_0 = [];
      } else {
        var_2 = level.var_4EA1.var_4C23;
        var_0[var_0.size] = var_2;
      }

      var_1 = gettime() + 500;
    }

    foreach(var_7, var_2 in var_0) {
      func_5B38(var_2);

      if(var_7 > 0) {
        var_4 = distance(var_2, var_0[var_7 - 1]);
        var_5 = vectornormalize(var_0[var_7 - 1] - var_2);
        var_6 = var_2 + var_5 * var_4 * 0.5;
      }
    }

    if(var_0.size == 2) {
      var_8 = (1, 0, 0);
      var_8 = (0, 1, 0);
      var_8 = (0.2, 0.2, 1);
      var_9 = var_0;

      if(var_0[1][2] > var_9[0][2]) {
        var_9 = [var_0[1], var_0[0]];
      }

      var_10 = var_9[0];
      var_11 = (var_10[0], var_10[1], var_9[1][2]);
      var_4 = distance(var_10, var_11);
      var_5 = vectornormalize(var_11 - var_10);
      var_12 = var_10 + var_5 * var_4 * 0.6;
    }

    wait 0.05;
  }

  level notify("stop_debug_cursor");
}

func_4EC2() {
  level.var_4EA1.var_4C23 = (0, 0, 0);
  level notify("stop_debug_cursor");
  level endon("stop_debug_cursor");

  for(;;) {
    var_0 = level.player getEye();
    var_1 = anglesToForward(level.player getplayerangles());
    var_2 = var_0 + var_1 * 10000;
    var_3 = bulletTrace(var_0, var_2, 0);
    level.var_4EA1.var_4C23 = var_3["position"];
    func_5B38(level.var_4EA1.var_4C23);
    wait 0.05;
  }
}

func_5B38(var_0) {
  level endon("stop_debug_cursor");
  var_1 = 4;
  var_2 = (1, 1, 1);
  var_3 = 1;
  var_4 = 1;
}

func_5B54(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  if(!isDefined(var_3)) {
    var_3 = 32;
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  var_6 = anglestoup(var_1);
  var_7 = anglesToForward(var_1);
  var_8 = var_0 + var_6 * var_3 * 0.5;
  var_9 = var_8 + var_7 * var_3;
  func_5B5D(var_8, var_9, var_2, var_4, var_5);
  func_5B24(var_0, var_2, var_1, var_3, var_4, var_5);
}

func_5B5D(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  var_5 = vectortoangles(var_1 - var_0);
  var_6 = length(var_1 - var_0);
  var_7 = anglesToForward(var_5);
  var_8 = var_7 * var_6;
  var_9 = 5;
  var_10 = var_7 * (var_6 - var_9);
  var_11 = anglestoright(var_5);
  var_12 = var_11 * (var_9 * -1);
  var_13 = var_11 * var_9;
}

func_5B24(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_3)) {
    var_3 = 32;
  }

  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  var_6 = anglesToForward(var_2);
  var_7 = anglestoright(var_2);
  var_8 = anglestoup(var_2);
  var_9 = var_0 + var_6 * var_3 * 0.5;
  var_9 = var_9 + var_7 * var_3 * 0.5;
  var_10 = [];
  var_10[var_10.size] = var_9;
  var_10[var_10.size] = var_10[var_10.size - 1] + var_6 * var_3 * -1;
  var_10[var_10.size] = var_10[var_10.size - 1] + var_7 * var_3 * -1;
  var_10[var_10.size] = var_10[var_10.size - 1] + var_6 * var_3;
  var_11 = var_3 * var_8;

  for(var_12 = 0; var_12 < var_10.size; var_12++) {
    if(var_12 == var_10.size - 1) {
      continue;
    }
  }
}