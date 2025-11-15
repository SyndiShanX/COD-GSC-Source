/********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\debug.gsc
********************************/

func_6636() {}

func_6639() {}

func_7D0D(param_00) {}

func_1876() {}

func_F390(param_00, param_01, param_02) {}

func_6638(param_00, param_01) {}

func_1877(param_00) {}

func_7997(param_00, param_01) {
  var_02 = getEntArray();
  var_03 = [];
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  foreach(var_05 in var_02) {
    if(!isDefined(var_05.classname)) {
      var_06 = "UNKNOWN?";
    } else {
      var_06 = var_05.classname;
    }

    if(param_00) {
      if(isai(var_05)) {
        var_06 = "actors";
      } else if(isspawner(var_05)) {
        var_07 = getsubstr(var_06, 0, 5);
        if(var_07 == "actor") {
          var_06 = "AI_spawners";
        } else {
          var_06 = "vehicle_spawners";
        }
      } else if(isDefined(var_05.var_49BD)) {
        var_06 = var_05.classname + " CREATEFX";
      } else if(!isDefined(var_05.var_9F)) {} else if(var_05.var_9F == "script_model") {
        if(var_05.model == "tag_origin") {
          var_06 = "script_model TAG_ORIGIN";
        }
      } else if(var_05.var_9F == "trigger_multiple") {
        var_07 = getsubstr(var_06, 0, 22);
        if(var_07 == "trigger_multiple_bcs_") {
          var_06 = "trigger_multiple_bcs";
        } else {
          var_06 = "trigger_multiple";
        }
      } else {
        var_07 = getsubstr(var_06.var_9F, 0, 10);
        if(var_07 == "weapon_iw7") {
          var_06 = "weapons";
        }

        var_07 = getsubstr(var_05.var_9F, 0, 5);
        if(var_07 == "actor") {
          var_06 = "drones";
        }
      }
    } else {
      if(isDefined(var_05.var_49BD)) {
        var_06 = "CREATEFX " + var_05.classname;
      }

      if(var_06 == "script_model") {
        var_06 = var_06 + " " + var_05.model;
      }
    }

    if(!isDefined(var_03[var_06])) {
      var_03[var_06] = 0;
    }

    var_03[var_06]++;
  }

  if(!isDefined(param_01) || !param_01) {
    var_03 = func_10418(var_03);
  }

  return var_03;
}

func_10418(param_00) {
  var_01 = getarraykeys(param_00);
  for(var_02 = 0; var_02 < var_01.size - 1; var_02++) {
    for(var_03 = var_02 + 1; var_03 < var_01.size; var_03++) {
      if(stricmp(var_01[var_02], var_01[var_03]) > 0) {
        var_04 = var_01[var_03];
        var_01[var_03] = var_01[var_02];
        var_01[var_02] = var_04;
      }
    }
  }

  var_05 = [];
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    var_05[var_01[var_02]] = param_00[var_01[var_02]];
  }

  return var_05;
}

func_4ED2(param_00) {
  var_01 = getaiarray();
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    if(var_01[var_02] getentitynumber() != param_00) {
      continue;
    }

    var_01[var_02] thread func_4ED3();
    break;
  }
}

func_4F22(param_00) {
  var_01 = getaiarray();
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    if(var_01[var_02] getentitynumber() != param_00) {
      continue;
    }

    var_01[var_02] notify("stop_drawing_enemy_pos");
    break;
  }
}

func_4ED3() {
  self endon("death");
  self endon("stop_drawing_enemy_pos");
  for(;;) {
    wait(0.05);
    if(isalive(self.isnodeoccupied)) {}

    if(!scripts\anim\utility::func_8BED()) {
      continue;
    }

    var_00 = scripts\anim\utility::func_7E90();
  }
}

func_4ED4() {
  var_00 = getaiarray();
  var_01 = undefined;
  for(var_02 = 0; var_02 < var_00.size; var_02++) {
    var_01 = var_00[var_02];
    if(!isalive(var_01)) {
      continue;
    }

    if(isDefined(var_01.setignoremegroup)) {}

    if(isDefined(var_01.goodshootpos)) {
      if(var_01 gettargetchargepos()) {
        var_03 = (1, 0, 0);
      } else {
        var_03 = (0, 0, 1);
      }

      var_04 = var_01.origin + (0, 0, 54);
      if(isDefined(var_01.target_getindexoftarget)) {
        if(var_01.target_getindexoftarget.type == "Cover Left") {
          var_05 = 1;
          var_04 = anglestoright(var_01.target_getindexoftarget.angles);
          var_04 = var_04 * -32;
          var_04 = (var_04[0], var_04[1], 64);
          var_04 = var_01.target_getindexoftarget.origin + var_04;
        } else if(var_01.target_getindexoftarget.type == "Cover Right") {
          var_05 = 1;
          var_04 = anglestoright(var_01.target_getindexoftarget.angles);
          var_04 = var_04 * 32;
          var_04 = (var_04[0], var_04[1], 64);
          var_04 = var_01.target_getindexoftarget.origin + var_04;
        }
      }

      scripts\engine\utility::draw_arrow(var_04, var_01.goodshootpos, var_03);
    }
  }

  if(1) {
    return;
  }

  if(!isalive(var_01)) {
    return;
  }

  if(isalive(var_01.isnodeoccupied)) {}

  if(isDefined(var_01.setignoremegroup)) {}

  if(isalive(var_01._meth_8450)) {}

  if(!var_01 scripts\anim\utility::func_8BED()) {
    return;
  }

  var_06 = var_01 scripts\anim\utility::func_7E90();
  if(isDefined(var_01.goodshootpos)) {}
}

func_5B76(param_00) {}

func_5B88(param_00, param_01, param_02) {
  if(isDefined(self.model) && scripts\sp\utility::hastag(self.model, param_00)) {
    var_03 = self gettagorigin(param_00);
    var_04 = self gettagangles(param_00);
    func_5B6D(var_03, var_04, param_01, param_02);
  }
}

func_5B6D(param_00, param_01, param_02, param_03) {
  var_04 = 10;
  var_05 = anglesToForward(param_01);
  var_06 = var_05 * var_04;
  var_07 = var_05 * var_04 * 0.8;
  var_08 = anglestoright(param_01);
  var_09 = var_08 * var_04 * -0.2;
  var_0A = var_08 * var_04 * 0.2;
  var_0B = anglestoup(param_01);
  var_08 = var_08 * var_04;
  var_0B = var_0B * var_04;
  var_0C = (0.9, 0.2, 0.2);
  var_0D = (0.2, 0.9, 0.2);
  var_0E = (0.2, 0.2, 0.9);
  if(isDefined(param_02)) {
    var_0C = param_02;
    var_0D = param_02;
    var_0E = param_02;
  }

  if(!isDefined(param_03)) {
    param_03 = 1;
  }
}

func_5B89(param_00, param_01) {
  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    func_5B88(param_00, param_01);
    wait(0.05);
  }
}

func_5B1D(param_00, param_01) {
  self endon("death");
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(!isDefined(self.origin)) {
      break;
    }

    func_5B88(param_00, param_01);
    wait(0.05);
  }
}

func_133A3(param_00, param_01) {
  if(param_00 == "ai") {
    var_02 = getaiarray();
    for(var_03 = 0; var_03 < var_02.size; var_03++) {
      var_02[var_03] func_5B88(param_01);
    }
  }
}

func_4EC1() {
  level.player.ignoreme = 1;
  var_00 = getallnodes();
  var_01 = [];
  for(var_02 = 0; var_02 < var_00.size; var_02++) {
    if(var_00[var_02].type == "Cover Left") {
      var_01[var_01.size] = var_00[var_02];
    }

    if(var_00[var_02].type == "Cover Right") {
      var_01[var_01.size] = var_00[var_02];
    }
  }

  var_03 = getaiarray();
  for(var_02 = 0; var_02 < var_03.size; var_02++) {
    var_03[var_02] delete();
  }

  level.var_4F54 = getspawnerarray();
  level.var_1658 = [];
  level.var_4484 = [];
  for(var_02 = 0; var_02 < level.var_4F54.size; var_02++) {
    level.var_4F54[var_02].var_336 = "blah";
  }

  var_04 = 0;
  for(var_02 = 0; var_02 < 30; var_02++) {
    if(var_02 >= var_01.size) {
      break;
    }

    var_01[var_02] thread func_474E();
    var_04++;
  }

  if(var_01.size <= 30) {
    return;
  }

  for(;;) {
    level waittill("debug_next_corner");
    if(var_04 >= var_01.size) {
      var_04 = 0;
    }

    var_01[var_04] thread func_474E();
    var_04++;
  }
}

func_474E() {
  func_4747();
}

func_4747() {
  var_00 = undefined;
  var_01 = undefined;
  for(;;) {
    for(var_02 = 0; var_02 < level.var_4F54.size; var_02++) {
      wait(0.05);
      var_01 = level.var_4F54[var_02];
      var_03 = 0;
      for(var_04 = 0; var_04 < level.var_1658.size; var_04++) {
        if(distance(level.var_1658[var_04].origin, self.origin) > 250) {
          continue;
        }

        var_03 = 1;
        break;
      }

      if(var_03) {
        continue;
      }

      var_05 = 0;
      for(var_04 = 0; var_04 < level.var_4484.size; var_04++) {
        if(level.var_4484[var_04] != self) {
          continue;
        }

        var_05 = 1;
        break;
      }

      if(var_05) {
        continue;
      }

      level.var_1658[level.var_1658.size] = self;
      var_01.origin = self.origin;
      var_01.angles = self.angles;
      var_01.var_C1 = 1;
      var_00 = var_01 _meth_8393();
      if(scripts\sp\utility::func_106ED(var_00)) {
        func_E0C0(self);
        continue;
      }

      break;
    }

    if(isalive(var_00)) {
      break;
    }
  }

  wait(1);
  if(isalive(var_00)) {
    var_00.ignoreme = 1;
    var_00.team = "neutral";
    var_00 give_mp_super_weapon(var_00.origin);
    thread func_49E3(self.origin);
    var_00 thread scripts\sp\utility::func_4F4B();
    thread func_49E4(var_00);
    var_00 waittill("death");
  }

  func_E0C0(self);
  level.var_4484[level.var_4484.size] = self;
}

func_E0C0(param_00) {
  var_01 = [];
  for(var_02 = 0; var_02 < level.var_1658.size; var_02++) {
    if(level.var_1658[var_02] == param_00) {
      continue;
    }

    var_01[var_01.size] = level.var_1658[var_02];
  }

  level.var_1658 = var_01;
}

func_49E3(param_00) {
  wait(0.05);
}

func_49E4(param_00) {
  var_01 = undefined;
  while(isalive(param_00)) {
    var_01 = param_00.origin;
    wait(0.05);
  }

  wait(0.05);
}

func_4F49() {
  self notify("stopdebugmisstime");
  self endon("stopdebugmisstime");
  self endon("death");
  for(;;) {
    if(self.a.var_B8D6 <= 0) {} else {}

    wait(0.05);
  }
}

func_4F4A() {
  self notify("stopdebugmisstime");
}

func_4F46(param_00) {}

func_4F41() {}

func_E02E() {}

func_48F2() {}

func_CD1E() {}

func_4EDC() {}

func_4EDD() {}

func_1011D() {
  var_00 = undefined;
  var_01 = undefined;
  var_00 = (15.1859, -12.2822, 4.071);
  var_01 = (947.2, -10918, 64.9514);
  for(;;) {
    wait(0.05);
    var_02 = var_00;
    var_03 = var_01;
    if(!isDefined(var_00)) {
      var_02 = level.var_11A8E;
    }

    if(!isDefined(var_01)) {
      var_03 = level.player getEye();
    }

    var_04 = bulletTrace(var_02, var_03, 0, undefined);
  }
}

func_4EBB() {
  var_00 = newhudelem();
  var_00.alignx = "left";
  var_00.aligny = "middle";
  var_00.x = 10;
  var_00.y = 100;
  var_00.label = & "DEBUG_DRONES";
  var_00.alpha = 0;
  var_01 = newhudelem();
  var_01.alignx = "left";
  var_01.aligny = "middle";
  var_01.x = 10;
  var_01.y = 115;
  var_01.label = & "DEBUG_ALLIES";
  var_01.alpha = 0;
  var_02 = newhudelem();
  var_02.alignx = "left";
  var_02.aligny = "middle";
  var_02.x = 10;
  var_02.y = 130;
  var_02.label = & "DEBUG_AXIS";
  var_02.alpha = 0;
  var_03 = newhudelem();
  var_03.alignx = "left";
  var_03.aligny = "middle";
  var_03.x = 10;
  var_03.y = 145;
  var_03.label = & "DEBUG_VEHICLES";
  var_03.alpha = 0;
  var_04 = newhudelem();
  var_04.alignx = "left";
  var_04.aligny = "middle";
  var_04.x = 10;
  var_04.y = 160;
  var_04.label = & "DEBUG_TOTAL";
  var_04.alpha = 0;
  var_05 = "off";
  for(;;) {
    var_06 = getdvar("debug_character_count");
    if(var_06 == "off") {
      if(var_06 != var_05) {
        var_00.alpha = 0;
        var_01.alpha = 0;
        var_02.alpha = 0;
        var_03.alpha = 0;
        var_04.alpha = 0;
        var_05 = var_06;
      }

      wait(0.25);
      continue;
    } else if(var_06 != var_05) {
      var_00.alpha = 1;
      var_01.alpha = 1;
      var_02.alpha = 1;
      var_03.alpha = 1;
      var_04.alpha = 1;
      var_05 = var_06;
    }

    var_07 = getEntArray("drone", "targetname").size;
    var_00 setvalue(var_07);
    var_08 = getaiarray("allies").size;
    var_01 setvalue(var_08);
    var_09 = getaiarray("bad_guys").size;
    var_02 setvalue(var_09);
    var_03 setvalue(getEntArray("script_vehicle", "classname").size);
    var_04 setvalue(var_07 + var_08 + var_09);
    wait(0.25);
  }
}

func_C1A6() {
  if(!self.var_E0) {
    if(isDefined(self.unittype) && self.unittype == "c12") {
      self _meth_81D0((0, 0, -500), level.player);
      return;
    }

    self _meth_81D0((0, 0, -500), level.player, level.player);
  }
}

func_4EFD() {}

func_37A5() {
  wait(0.05);
  var_00 = getEntArray("camera", "targetname");
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    var_02 = getent(var_00[var_01].target, "targetname");
    var_00[var_01].var_C712 = var_02.origin;
    var_00[var_01].angles = vectortoangles(var_02.origin - var_00[var_01].origin);
  }

  for(;;) {
    var_03 = getaiarray("axis");
    if(!var_03.size) {
      func_7370();
      wait(0.5);
      continue;
    }

    var_04 = [];
    for(var_01 = 0; var_01 < var_00.size; var_01++) {
      for(var_05 = 0; var_05 < var_03.size; var_05++) {
        if(distance(var_00[var_01].origin, var_03[var_05].origin) > 256) {
          continue;
        }

        var_04[var_04.size] = var_00[var_01];
        break;
      }
    }

    if(!var_04.size) {
      func_7370();
      wait(0.5);
      continue;
    }

    var_06 = [];
    for(var_01 = 0; var_01 < var_04.size; var_01++) {
      var_07 = var_04[var_01];
      var_08 = var_07.var_C712;
      var_09 = var_07.origin;
      var_0A = vectortoangles((var_09[0], var_09[1], var_09[2]) - (var_08[0], var_08[1], var_08[2]));
      var_0B = (0, var_0A[1], 0);
      var_0C = anglesToForward(var_0B);
      var_0A = vectornormalize(var_09 - level.player.origin);
      var_0D = vectordot(var_0C, var_0A);
      if(var_0D < 0.85) {
        continue;
      }

      var_06[var_06.size] = var_07;
    }

    if(!var_06.size) {
      func_7370();
      wait(0.5);
      continue;
    }

    var_0E = distance(level.player.origin, var_06[0].origin);
    var_0F = var_06[0];
    for(var_01 = 1; var_01 < var_06.size; var_01++) {
      var_10 = distance(level.player.origin, var_06[var_01].origin);
      if(var_10 > var_0E) {
        continue;
      }

      var_0F = var_06[var_01];
      var_0E = var_10;
    }

    func_F7FD(var_0F);
    wait(3);
  }
}

func_7370() {
  setdvar("cl_freemove", "0");
}

func_F7FD(param_00) {
  setdvar("cl_freemove", "2");
}

func_4E6B() {
  waittillframeend;
  for(var_00 = 0; var_00 < 50; var_00++) {
    if(!isDefined(level.var_4E6A[var_00])) {
      continue;
    }

    var_01 = level.var_4E6A[var_00];
    for(var_02 = 0; var_02 < var_01.size; var_02++) {
      var_03 = var_01[var_02];
      if(isDefined(var_03.var_12844)) {
        continue;
      }
    }
  }
}

func_A9EF() {}

func_13ACF() {
  for(;;) {
    func_12ED1();
    wait(0.25);
  }
}

func_12ED1() {
  var_00 = getdvarfloat("scr_requiredMapAspectRatio", 1);
  if(!isDefined(level.var_B7AF)) {
    setdvar("scr_minimap_corner_targetname", "minimap_corner");
    level.var_B7AF = "minimap_corner";
  }

  if(!isDefined(level.var_B7B1)) {
    setdvar("scr_minimap_height", "0");
    level.var_B7B1 = 0;
  }

  var_01 = getdvarfloat("scr_minimap_height");
  var_02 = getdvar("scr_minimap_corner_targetname");
  if(var_01 != level.var_B7B1 || var_02 != level.var_B7AF) {
    if(isDefined(level.var_B7B2)) {
      level.var_B7B3 unlink();
      level.var_B7B2 delete();
      level notify("end_draw_map_bounds");
    }

    if(var_01 > 0) {
      level.var_B7B1 = var_01;
      level.var_B7AF = var_02;
      var_03 = level.player;
      var_04 = getEntArray(var_02, "targetname");
      if(var_04.size == 2) {
        var_05 = var_04[0].origin + var_04[1].origin;
        var_05 = (var_05[0] * 0.5, var_05[1] * 0.5, var_05[2] * 0.5);
        var_06 = (var_04[0].origin[0], var_04[0].origin[1], var_05[2]);
        var_07 = (var_04[0].origin[0], var_04[0].origin[1], var_05[2]);
        if(var_04[1].origin[0] > var_04[0].origin[0]) {
          var_06 = (var_04[1].origin[0], var_06[1], var_06[2]);
        } else {
          var_07 = (var_04[1].origin[0], var_07[1], var_07[2]);
        }

        if(var_04[1].origin[1] > var_04[0].origin[1]) {
          var_06 = (var_06[0], var_04[1].origin[1], var_06[2]);
        } else {
          var_07 = (var_07[0], var_04[1].origin[1], var_07[2]);
        }

        var_08 = var_06 - var_05;
        var_05 = (var_05[0], var_05[1], var_05[2] + var_01);
        var_09 = spawn("script_origin", var_03.origin);
        var_0A = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
        var_0B = (var_0A[1], 0 - var_0A[0], 0);
        var_0C = vectordot(var_0A, var_08);
        if(var_0C < 0) {
          var_0C = 0 - var_0C;
        }

        var_0D = vectordot(var_0B, var_08);
        if(var_0D < 0) {
          var_0D = 0 - var_0D;
        }

        if(var_00 > 0) {
          var_0E = var_0D / var_0C;
          if(var_0E < var_00) {
            var_0F = var_00 / var_0E;
            var_0D = var_0D * var_0F;
            var_10 = vecscale(var_0B, vectordot(var_0B, var_06 - var_05) * var_0F - 1);
            var_07 = var_07 - var_10;
            var_06 = var_06 + var_10;
          } else {
            var_0F = var_10 / var_02;
            var_0D = var_0D * var_10;
            var_10 = vecscale(var_0B, vectordot(var_0B, var_07 - var_06) * var_10 - 1);
            var_07 = var_07 - var_10;
            var_06 = var_06 + var_10;
          }
        }

        if(level.console) {
          var_11 = 1.777778;
          var_12 = 2 * atan(var_0D * 0.8 / var_01);
          var_13 = 2 * atan(var_0C * var_11 * 0.8 / var_01);
        } else {
          var_11 = 1.333333;
          var_12 = 2 * atan(var_12 * 1.05 / var_03);
          var_13 = 2 * atan(var_0D * var_12 * 1.05 / var_02);
        }

        if(var_12 > var_13) {
          var_14 = var_12;
        } else {
          var_14 = var_14;
        }

        var_15 = var_01 - 1000;
        if(var_15 < 16) {
          var_15 = 16;
        }

        if(var_15 > 10000) {
          var_15 = 10000;
        }

        var_03 playerlinktoabsolute(var_09);
        var_09.origin = var_05 + (0, 0, -62);
        var_09.angles = (90, getnorthyaw(), 0);
        var_03 giveweapon("defaultweapon");
        setsaveddvar("cg_fov", var_14);
        level.var_B7B3 = var_03;
        level.var_B7B2 = var_09;
        thread func_5B7E(var_05, var_07, var_06);
        return;
      }

      return;
    }
  }
}

func_7E1F() {
  var_00 = [];
  var_00 = getEntArray("minimap_line", "script_noteworthy");
  var_01 = [];
  for(var_02 = 0; var_02 < var_00.size; var_02++) {
    var_01[var_02] = var_00[var_02] func_7E1E();
  }

  return var_01;
}

func_7E1E() {
  var_00 = [];
  var_01 = self;
  while(isDefined(var_01)) {
    var_00[var_00.size] = var_01;
    if(!isDefined(var_01) || !isDefined(var_01.target)) {
      break;
    }

    var_01 = getent(var_01.target, "targetname");
    if(isDefined(var_01) && var_01 == var_00[0]) {
      var_00[var_00.size] = var_01;
      break;
    }
  }

  var_02 = [];
  for(var_03 = 0; var_03 < var_00.size; var_03++) {
    var_02[var_03] = var_00[var_03].origin;
  }

  return var_02;
}

vecscale(param_00, param_01) {
  return (param_00[0] * param_01, param_00[1] * param_01, param_00[2] * param_01);
}

func_5B7E(param_00, param_01, param_02) {
  level notify("end_draw_map_bounds");
  level endon("end_draw_map_bounds");
  var_03 = param_00[2] - param_02[2];
  var_04 = length(param_01 - param_02);
  var_05 = param_01 - param_00;
  var_05 = vectornormalize((var_05[0], var_05[1], 0));
  param_01 = param_01 + vecscale(var_05, var_04 * 1 / 800 * 0);
  var_06 = param_02 - param_00;
  var_06 = vectornormalize((var_06[0], var_06[1], 0));
  param_02 = param_02 + vecscale(var_06, var_04 * 1 / 800 * 0);
  var_07 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  var_08 = param_02 - param_01;
  var_09 = vecscale(var_07, vectordot(var_08, var_07));
  var_0A = vecscale(var_07, abs(vectordot(var_08, var_07)));
  var_0B = param_01;
  var_0C = param_01 + var_09;
  var_0D = param_02;
  var_0E = param_02 - var_09;
  var_0F = vecscale(param_01 + param_02, 0.5) + vecscale(var_0A, 0.51);
  var_10 = var_04 * 0.003;
  var_11 = func_7E1F();
  for(;;) {
    scripts\engine\utility::array_levelthread(var_11, ::scripts\engine\utility::plot_points);
    wait(0.05);
  }
}

func_4EC0() {
  wait(0.05);
  var_00 = getaiarray();
  var_01 = [];
  var_01["axis"] = [];
  var_01["allies"] = [];
  var_01["neutral"] = [];
  for(var_02 = 0; var_02 < var_00.size; var_02++) {
    var_03 = var_00[var_02];
    if(!isDefined(var_03.var_4BDF)) {
      continue;
    }

    var_01[var_03.team][var_03.var_4BDF] = 1;
    var_04 = (1, 1, 1);
    if(isDefined(var_03.var_EDAD)) {
      var_04 = level.var_4391[var_03.var_EDAD];
    }

    if(var_03.team == "axis") {
      continue;
    }

    var_03 func_12879();
  }

  draw_colornodes(var_01, "allies");
  draw_colornodes(var_01, "axis");
}

draw_colornodes(param_00, param_01) {
  var_02 = getarraykeys(param_00[param_01]);
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    var_04 = (1, 1, 1);
    var_04 = level.var_4391[getsubstr(var_02[var_03], 0, 1)];
    if(isDefined(level.var_43AD[param_01][var_02[var_03]])) {
      var_05 = level.var_43AD[param_01][var_02[var_03]];
      for(var_06 = 0; var_06 < var_05.size; var_06++) {}
    }
  }
}

func_7CE8() {
  if(self.team == "allies") {
    if(!isDefined(self.target_getindexoftarget.var_ED33)) {
      return;
    }

    return self.target_getindexoftarget.var_ED33;
  }

  if(self.team == "axis") {
    if(!isDefined(self.target_getindexoftarget.var_ED34)) {
      return;
    }

    return self.target_getindexoftarget.var_ED34;
  }
}

func_12879() {
  if(!isDefined(self.target_getindexoftarget)) {
    return;
  }

  if(!isDefined(self.var_EDAD)) {
    return;
  }

  var_00 = func_7CE8();
  if(!isDefined(var_00)) {
    return;
  }

  if(!issubstr(var_00, self.var_EDAD)) {}
}

func_4F55() {
  level.var_A91E = gettime();
  thread func_4F56();
}

func_4F56() {}

func_56E2(param_00, param_01) {
  if(self.team == param_00.team) {
    return;
  }

  var_02 = 0;
  var_02 = var_02 + self.var_33F;
  var_03 = 0;
  var_03 = var_03 + param_00.var_33F;
  var_04 = undefined;
  if(isDefined(param_01)) {
    var_04 = self getthreatbiasgroup();
    if(isDefined(var_04)) {
      var_03 = var_03 + getthreatbias(param_01, var_04);
      var_02 = var_02 + getthreatbias(var_04, param_01);
    }
  }

  if(param_00.ignoreme || var_03 < -900000) {
    var_03 = "Ignore";
  }

  if(self.ignoreme || var_02 < -900000) {
    var_02 = "Ignore";
  }

  var_05 = 20;
  var_06 = (1, 0.5, 0.2);
  var_07 = (0.2, 0.5, 1);
  var_08 = !isplayer(self) && self.triggeroneoffradarsweep;
  for(var_09 = 0; var_09 <= var_05; var_09++) {
    if(isDefined(param_01)) {}

    if(isDefined(var_04)) {}

    if(var_08) {}

    wait(0.05);
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
  var_00 = [];
  var_00["r"] = (1, 0, 0);
  var_00["o"] = (1, 0.5, 0);
  var_00["y"] = (1, 1, 0);
  var_00["g"] = (0, 1, 0);
  var_00["c"] = (0, 1, 1);
  var_00["b"] = (0, 0, 1);
  var_00["p"] = (1, 0, 1);
  return var_00;
}

draw_closest_wall_points() {
  level endon("updated_color_friendlies");
  var_00 = getarraykeys(level.var_4EBE);
  var_01 = [];
  var_02 = [];
  var_02[var_02.size] = "r";
  var_02[var_02.size] = "o";
  var_02[var_02.size] = "y";
  var_02[var_02.size] = "g";
  var_02[var_02.size] = "c";
  var_02[var_02.size] = "b";
  var_02[var_02.size] = "p";
  var_03 = func_7C31();
  for(var_04 = 0; var_04 < var_02.size; var_04++) {
    var_01[var_02[var_04]] = 0;
  }

  for(var_04 = 0; var_04 < var_00.size; var_04++) {
    var_05 = level.var_4EBE[var_00[var_04]];
    var_01[var_05]++;
  }

  for(var_04 = 0; var_04 < level.var_4EBF.size; var_04++) {
    level.var_4EBF[var_04] destroy();
  }

  level.var_4EBF = [];
  var_06 = 15;
  var_07 = 365;
  var_08 = 25;
  var_09 = 25;
  for(var_04 = 0; var_04 < var_02.size; var_04++) {
    if(var_01[var_02[var_04]] <= 0) {
      continue;
    }

    for(var_0A = 0; var_0A < var_01[var_02[var_04]]; var_0A++) {
      var_0B = newhudelem();
      var_0B.x = var_06 + 25 * var_0A;
      var_0B.y = var_07;
      var_0B setshader("white", 16, 16);
      var_0B.alignx = "left";
      var_0B.aligny = "bottom";
      var_0B.alpha = 1;
      var_0B.color = var_03[var_02[var_04]];
      level.var_4EBF[level.var_4EBF.size] = var_0B;
    }

    var_07 = var_07 + var_09;
  }
}

func_77F0(param_00) {
  if(!isDefined(level.var_1FD4[param_00.var_1FBB])) {
    return;
  }

  if(!isDefined(level.var_1FD4[param_00.var_1FBB][param_00.var_1FAF])) {
    return;
  }

  if(!isDefined(level.var_1FD4[param_00.var_1FBB][param_00.var_1FAF][param_00.var_C0C2])) {
    return;
  }

  return level.var_1FD4[param_00.var_1FBB][param_00.var_1FAF][param_00.var_C0C2]["soundalias"];
}

func_9BEC(param_00, param_01, param_02) {
  return isDefined(level.var_1FD4[param_00][param_01][param_02]["created_by_animSound"]);
}

func_4EA9(param_00) {}

func_4EAA() {}

func_113E6(param_00, param_01) {
  if(!isDefined(level.var_1FDA)) {
    return;
  }

  if(!isDefined(level.var_1FDA.var_1FDC[param_01])) {
    return;
  }

  var_02 = level.var_1FDA.var_1FDC[param_01];
  var_03 = func_77F0(var_02);
  if(!isDefined(var_03) || func_9BEC(var_02.var_1FBB, var_02.var_1FAF, var_02.var_C0C2)) {
    level.var_1FD4[var_02.var_1FBB][var_02.var_1FAF][var_02.var_C0C2]["soundalias"] = param_00;
    level.var_1FD4[var_02.var_1FBB][var_02.var_1FAF][var_02.var_C0C2]["created_by_animSound"] = 1;
  }
}

func_6C96(param_00) {}

func_3D44(param_00) {
  if(!isDefined(level.var_3D30)) {
    level.var_3D30 = -1;
  }

  if(level.var_3D30 == param_00) {
    return;
  }

  func_6C96(param_00);
  if(!isDefined(level.var_3D31)) {
    return;
  }

  level.var_3D30 = param_00;
  if(!isDefined(level.var_3D2F)) {
    level.var_3D2F = level.var_3D31 scripts\engine\utility::spawn_tag_origin();
  }

  thread func_3D45(level.var_3D31);
}

func_3D45(param_00) {
  level notify("new_chasecam");
  level endon("new_chasecam");
  param_00 endon("death");
  level.player unlink();
  level.player playerlinktoblend(level.var_3D2F, "tag_origin", 2, 0.5, 0.5);
  wait(2);
  level.player playerlinktodelta(level.var_3D2F, "tag_origin", 1, 180, 180, 180, 180);
  for(;;) {
    wait(0.2);
    if(!isDefined(level.var_3D31)) {
      return;
    }

    var_01 = level.var_3D31.origin;
    var_02 = level.var_3D31.angles;
    var_03 = anglesToForward(var_02);
    var_03 = var_03 * 200;
    var_01 = var_01 + var_03;
    var_02 = level.player getplayerangles();
    var_03 = anglesToForward(var_02);
    var_03 = var_03 * -200;
    level.var_3D2F moveto(var_01 + var_03, 0.2);
  }
}

func_13399() {
  foreach(var_01 in level.createfxent) {
    if(isDefined(var_01.looper)) {}
  }
}

func_1705(param_00, param_01) {}

func_D908(param_00) {
  if(!isDefined(level.var_134AD)) {
    level.var_134AD = 9500;
  }

  level.var_134AD++;
  var_01 = "bridge_helpers";
  func_1705("origin", self.origin[0] + " " + self.origin[1] + " " + self.origin[2]);
  func_1705("angles", self.angles[0] + " " + self.angles[1] + " " + self.angles[2]);
  func_1705("targetname", "helper_model");
  func_1705("model", self.model);
  func_1705("classname", "script_model");
  func_1705("spawnflags", "4");
  func_1705("_color", "0.443137 0.443137 1.000000");
  if(isDefined(param_00)) {
    func_1705("script_noteworthy", param_00);
  }
}

draw_dot_for_ent(param_00) {}

draw_dot_for_guy() {
  var_00 = level.player getplayerangles();
  var_01 = anglesToForward(var_00);
  var_02 = level.player getEye();
  var_03 = self getEye();
  var_04 = vectortoangles(var_03 - var_02);
  var_05 = anglesToForward(var_04);
  var_06 = vectordot(var_05, var_01);
}

func_13C26() {
  setdvarifuninitialized("weaponlist", "0");
  if(!getdvarint("weaponlist")) {
    return;
  }

  var_00 = getEntArray();
  var_01 = [];
  foreach(var_03 in var_00) {
    if(!isDefined(var_03.var_9F)) {
      continue;
    }

    if(issubstr(var_03.var_9F, "weapon")) {
      var_01[var_03.classname] = 1;
    }
  }

  foreach(var_06 in var_01) {}

  var_08 = getspawnerarray();
  var_09 = [];
  foreach(var_0B in var_08) {
    var_09[var_0B.var_9F] = 1;
  }

  foreach(var_06 in var_09) {}
}

func_B514() {
  thread func_4EC2();
  setdvar("debug_measure", 2);
  var_00 = [];
  var_01 = 0;
  while(getdvarint("debug_measure")) {
    if(level.player usebuttonpressed() && gettime() > var_01) {
      if(var_00.size == 2) {
        var_00 = [];
      } else {
        var_02 = level.var_4EA1.var_4C23;
        var_00[var_00.size] = var_02;
      }

      var_01 = gettime() + 500;
    }

    foreach(var_07, var_02 in var_00) {
      func_5B38(var_02);
      if(var_07 > 0) {
        var_04 = distance(var_02, var_00[var_07 - 1]);
        var_05 = vectornormalize(var_00[var_07 - 1] - var_02);
        var_06 = var_02 + var_05 * var_04 * 0.5;
      }
    }

    if(var_00.size == 2) {
      var_08 = (1, 0, 0);
      var_08 = (0, 1, 0);
      var_08 = (0.2, 0.2, 1);
      var_09 = var_00;
      if(var_00[1][2] > var_09[0][2]) {
        var_09 = [var_00[1], var_00[0]];
      }

      var_0A = var_09[0];
      var_0B = (var_0A[0], var_0A[1], var_09[1][2]);
      var_04 = distance(var_0A, var_0B);
      var_05 = vectornormalize(var_0B - var_0A);
      var_0C = var_0A + var_05 * var_04 * 0.6;
    }

    wait(0.05);
  }

  level notify("stop_debug_cursor");
}

func_4EC2() {
  level.var_4EA1.var_4C23 = (0, 0, 0);
  level notify("stop_debug_cursor");
  level endon("stop_debug_cursor");
  for(;;) {
    var_00 = level.player getEye();
    var_01 = anglesToForward(level.player getplayerangles());
    var_02 = var_00 + var_01 * 10000;
    var_03 = bulletTrace(var_00, var_02, 0);
    level.var_4EA1.var_4C23 = var_03["position"];
    func_5B38(level.var_4EA1.var_4C23);
    wait(0.05);
  }
}

func_5B38(param_00) {
  level endon("stop_debug_cursor");
  var_01 = 4;
  var_02 = (1, 1, 1);
  var_03 = 1;
  var_04 = 1;
}

func_5B54(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_01)) {
    param_01 = (0, 0, 0);
  }

  if(!isDefined(param_03)) {
    param_03 = 32;
  }

  if(!isDefined(param_04)) {
    param_04 = 1;
  }

  if(!isDefined(param_05)) {
    param_05 = 0;
  }

  var_06 = anglestoup(param_01);
  var_07 = anglesToForward(param_01);
  var_08 = param_00 + var_06 * param_03 * 0.5;
  var_09 = var_08 + var_07 * param_03;
  func_5B5D(var_08, var_09, param_02, param_04, param_05);
  func_5B24(param_00, param_02, param_01, param_03, param_04, param_05);
}

func_5B5D(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_03)) {
    param_03 = 1;
  }

  if(!isDefined(param_04)) {
    param_04 = 0;
  }

  var_05 = vectortoangles(param_01 - param_00);
  var_06 = length(param_01 - param_00);
  var_07 = anglesToForward(var_05);
  var_08 = var_07 * var_06;
  var_09 = 5;
  var_0A = var_07 * var_06 - var_09;
  var_0B = anglestoright(var_05);
  var_0C = var_0B * var_09 * -1;
  var_0D = var_0B * var_09;
}

func_5B24(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_03)) {
    param_03 = 32;
  }

  if(!isDefined(param_02)) {
    param_02 = (0, 0, 0);
  }

  if(!isDefined(param_04)) {
    param_04 = 1;
  }

  if(!isDefined(param_05)) {
    param_05 = 0;
  }

  var_06 = anglesToForward(param_02);
  var_07 = anglestoright(param_02);
  var_08 = anglestoup(param_02);
  var_09 = param_00 + var_06 * param_03 * 0.5;
  var_09 = var_09 + var_07 * param_03 * 0.5;
  var_0A = [];
  var_0A[var_0A.size] = var_09;
  var_0A[var_0A.size] = var_0A[var_0A.size - 1] + var_06 * param_03 * -1;
  var_0A[var_0A.size] = var_0A[var_0A.size - 1] + var_07 * param_03 * -1;
  var_0A[var_0A.size] = var_0A[var_0A.size - 1] + var_06 * param_03;
  var_0B = param_03 * var_08;
  for(var_0C = 0; var_0C < var_0A.size; var_0C++) {
    if(var_0C == var_0A.size - 1) {
      continue;
    }
  }
}