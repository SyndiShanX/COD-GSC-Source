/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2844.gsc
***************************************/

func_6636() {}

func_6639() {}

func_7D0D(var_00) {}

func_1876() {}

func_F390(var_00, var_01, var_02) {}

func_6638(var_00, var_01) {}

func_1877(var_00) {}

func_7997(var_00, var_01) {
  var_02 = getEntArray();
  var_03 = [];

  if(!isDefined(var_00))
    var_00 = 0;

  foreach(var_05 in var_02) {
    if(!isDefined(var_5.classname))
      var_06 = "UNKNOWN?";
    else
      var_06 = var_5.classname;

    if(var_00) {
      if(isai(var_05))
        var_06 = "actors";
      else if(_isspawner(var_05)) {
        var_07 = getsubstr(var_06, 0, 5);

        if(var_07 == "actor")
          var_06 = "AI_spawners";
        else
          var_06 = "vehicle_spawners";
      } else if(isDefined(var_5.func_49BD))
        var_06 = var_5.classname + " CREATEFX";
      else if(!isDefined(var_5.code_classname)) {} else if(var_5.code_classname == "script_model") {
        if(var_5.model == "tag_origin")
          var_06 = "script_model TAG_ORIGIN";
      } else if(var_5.code_classname == "trigger_multiple") {
        var_07 = getsubstr(var_06, 0, 22);

        if(var_07 == "trigger_multiple_bcs_")
          var_06 = "trigger_multiple_bcs";
        else
          var_06 = "trigger_multiple";
      } else {
        var_07 = getsubstr(var_5.code_classname, 0, 10);

        if(var_07 == "weapon_iw7")
          var_06 = "weapons";

        var_07 = getsubstr(var_5.code_classname, 0, 5);

        if(var_07 == "actor")
          var_06 = "drones";
      }
    } else {
      if(isDefined(var_5.func_49BD))
        var_06 = "CREATEFX " + var_5.classname;

      if(var_06 == "script_model")
        var_06 = var_06 + (" " + var_5.model);
    }

    if(!isDefined(var_3[var_06]))
      var_3[var_06] = 0;

    var_3[var_06]++;
  }

  if(!isDefined(var_01) || !var_01)
    var_03 = func_10418(var_03);

  return var_03;
}

func_10418(var_00) {
  var_01 = getarraykeys(var_00);

  for(var_02 = 0; var_02 < var_1.size - 1; var_2++) {
    for(var_03 = var_02 + 1; var_03 < var_1.size; var_3++) {
      if(stricmp(var_1[var_02], var_1[var_03]) > 0) {
        var_04 = var_1[var_03];
        var_1[var_03] = var_1[var_02];
        var_1[var_02] = var_04;
      }
    }
  }

  var_05 = [];

  for(var_02 = 0; var_02 < var_1.size; var_2++)
    var_5[var_1[var_02]] = var_0[var_1[var_02]];

  return var_05;
}

func_4ED2(var_00) {
  var_01 = _getaiarray();

  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    if(var_1[var_02] getentitynumber() != var_00) {
      continue;
    }
    var_1[var_02] thread func_4ED3();
    break;
  }
}

func_4F22(var_00) {
  var_01 = _getaiarray();

  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    if(var_1[var_02] getentitynumber() != var_00) {
      continue;
    }
    var_1[var_02] notify("stop_drawing_enemy_pos");
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
    var_00 = scripts\anim\utility::func_7E90();
  }
}

func_4ED4() {
  var_00 = _getaiarray();
  var_01 = undefined;

  for(var_02 = 0; var_02 < var_0.size; var_2++) {
    var_01 = var_0[var_02];

    if(!isalive(var_01)) {
      continue;
    }
    if(isDefined(var_1.lastenemysightpos)) {}

    if(isDefined(var_1.goodshootpos)) {
      if(var_01 isbadguy())
        var_03 = (1, 0, 0);
      else
        var_03 = (0, 0, 1);

      var_04 = var_1.origin + (0, 0, 54);

      if(isDefined(var_1.node)) {
        if(var_1.node.type == "Cover Left") {
          var_05 = 1;
          var_04 = anglestoright(var_1.node.angles);
          var_04 = var_04 * -32;
          var_04 = (var_4[0], var_4[1], 64);
          var_04 = var_1.node.origin + var_04;
        } else if(var_1.node.type == "Cover Right") {
          var_05 = 1;
          var_04 = anglestoright(var_1.node.angles);
          var_04 = var_04 * 32;
          var_04 = (var_4[0], var_4[1], 64);
          var_04 = var_1.node.origin + var_04;
        }
      }

      scripts\engine\utility::draw_arrow(var_04, var_1.goodshootpos, var_03);
    }
  }

  if(1) {
    return;
  }
  if(!isalive(var_01)) {
    return;
  }
  if(isalive(var_1.enemy)) {}

  if(isDefined(var_1.lastenemysightpos)) {}

  if(isalive(var_1._meth_8450)) {}

  if(!var_01 scripts\anim\utility::func_8BED()) {
    return;
  }
  var_06 = var_01 scripts\anim\utility::func_7E90();

  if(isDefined(var_1.goodshootpos))
    return;
}

func_5B76(var_00) {}

func_5B88(var_00, var_01, var_02) {
  if(isDefined(self.model) && scripts\sp\utility::hastag(self.model, var_00)) {
    var_03 = self gettagorigin(var_00);
    var_04 = self gettagangles(var_00);
    func_5B6D(var_03, var_04, var_01, var_02);
  }
}

func_5B6D(var_00, var_01, var_02, var_03) {
  var_04 = 10;
  var_05 = anglesToForward(var_01);
  var_06 = var_05 * var_04;
  var_07 = var_05 * (var_04 * 0.8);
  var_08 = anglestoright(var_01);
  var_09 = var_08 * (var_04 * -0.2);
  var_10 = var_08 * (var_04 * 0.2);
  var_11 = anglestoup(var_01);
  var_08 = var_08 * var_04;
  var_11 = var_11 * var_04;
  var_12 = (0.9, 0.2, 0.2);
  var_13 = (0.2, 0.9, 0.2);
  var_14 = (0.2, 0.2, 0.9);

  if(isDefined(var_02)) {
    var_12 = var_02;
    var_13 = var_02;
    var_14 = var_02;
  }

  if(!isDefined(var_03))
    var_03 = 1;
}

func_5B89(var_00, var_01) {
  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    func_5B88(var_00, var_01);
    wait 0.05;
  }
}

func_5B1D(var_00, var_01) {
  self endon("death");

  for(;;) {
    if(!isDefined(self)) {
      break;
    }
    if(!isDefined(self.origin)) {
      break;
    }
    func_5B88(var_00, var_01);
    wait 0.05;
  }
}

func_133A3(var_00, var_01) {
  if(var_00 == "ai") {
    var_02 = _getaiarray();

    for(var_03 = 0; var_03 < var_2.size; var_3++)
      var_2[var_03] func_5B88(var_01);
  }
}

func_4EC1() {
  level.player.ignoreme = 1;
  var_00 = getallnodes();
  var_01 = [];

  for(var_02 = 0; var_02 < var_0.size; var_2++) {
    if(var_0[var_02].type == "Cover Left")
      var_1[var_1.size] = var_0[var_02];

    if(var_0[var_02].type == "Cover Right")
      var_1[var_1.size] = var_0[var_02];
  }

  var_03 = _getaiarray();

  for(var_02 = 0; var_02 < var_3.size; var_2++)
    var_3[var_02] delete();

  level.func_4F54 = _getspawnerarray();
  level.func_1658 = [];
  level.func_4484 = [];

  for(var_02 = 0; var_02 < level.func_4F54.size; var_2++)
    level.func_4F54[var_02].targetname = "blah";

  var_04 = 0;

  for(var_02 = 0; var_02 < 30; var_2++) {
    if(var_02 >= var_1.size) {
      break;
    }
    var_1[var_02] thread func_474E();
    var_4++;
  }

  if(var_1.size <= 30) {
    return;
  }
  for(;;) {
    level waittill("debug_next_corner");

    if(var_04 >= var_1.size)
      var_04 = 0;

    var_1[var_04] thread func_474E();
    var_4++;
  }
}

func_474E() {
  func_4747();
}

func_4747() {
  var_00 = undefined;
  var_01 = undefined;

  for(;;) {
    for(var_02 = 0; var_02 < level.func_4F54.size; var_2++) {
      wait 0.05;
      var_01 = level.func_4F54[var_02];
      var_03 = 0;

      for(var_04 = 0; var_04 < level.func_1658.size; var_4++) {
        if(distance(level.func_1658[var_04].origin, self.origin) > 250) {
          continue;
        }
        var_03 = 1;
        break;
      }

      if(var_03) {
        continue;
      }
      var_05 = 0;

      for(var_04 = 0; var_04 < level.func_4484.size; var_4++) {
        if(level.func_4484[var_04] != self) {
          continue;
        }
        var_05 = 1;
        break;
      }

      if(var_05) {
        continue;
      }
      level.func_1658[level.func_1658.size] = self;
      var_1.origin = self.origin;
      var_1.angles = self.angles;
      var_1.count = 1;
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

  wait 1;

  if(isalive(var_00)) {
    var_0.ignoreme = 1;
    var_0.team = "neutral";
    var_00 give_mp_super_weapon(var_0.origin);
    thread func_49E3(self.origin);
    var_00 thread scripts\sp\utility::func_4F4B();
    thread func_49E4(var_00);
    var_00 waittill("death");
  }

  func_E0C0(self);
  level.func_4484[level.func_4484.size] = self;
}

func_E0C0(var_00) {
  var_01 = [];

  for(var_02 = 0; var_02 < level.func_1658.size; var_2++) {
    if(level.func_1658[var_02] == var_00) {
      continue;
    }
    var_1[var_1.size] = level.func_1658[var_02];
  }

  level.func_1658 = var_01;
}

func_49E3(var_00) {
  for(;;)
    wait 0.05;
}

func_49E4(var_00) {
  var_01 = undefined;

  while(isalive(var_00)) {
    var_01 = var_0.origin;
    wait 0.05;
  }

  for(;;)
    wait 0.05;
}

func_4F49() {
  self notify("stopdebugmisstime");
  self endon("stopdebugmisstime");
  self endon("death");

  for(;;) {
    if(self.a.func_B8D6 <= 0) {} else {}

    wait 0.05;
  }
}

func_4F4A() {
  self notify("stopdebugmisstime");
}

func_4F46(var_00) {}

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
    wait 0.05;
    var_02 = var_00;
    var_03 = var_01;

    if(!isDefined(var_00))
      var_02 = level.func_11A8E;

    if(!isDefined(var_01))
      var_03 = level.player getEye();

    var_04 = bulletTrace(var_02, var_03, 0, undefined);
  }
}

func_4EBB() {
  var_00 = newhudelem();
  var_0.alignx = "left";
  var_0.aligny = "middle";
  var_0.x = 10;
  var_0.y = 100;
  var_0.label = &"DEBUG_DRONES";
  var_0.alpha = 0;
  var_01 = newhudelem();
  var_1.alignx = "left";
  var_1.aligny = "middle";
  var_1.x = 10;
  var_1.y = 115;
  var_1.label = &"DEBUG_ALLIES";
  var_1.alpha = 0;
  var_02 = newhudelem();
  var_2.alignx = "left";
  var_2.aligny = "middle";
  var_2.x = 10;
  var_2.y = 130;
  var_2.label = &"DEBUG_AXIS";
  var_2.alpha = 0;
  var_03 = newhudelem();
  var_3.alignx = "left";
  var_3.aligny = "middle";
  var_3.x = 10;
  var_3.y = 145;
  var_3.label = &"DEBUG_VEHICLES";
  var_3.alpha = 0;
  var_04 = newhudelem();
  var_4.alignx = "left";
  var_4.aligny = "middle";
  var_4.x = 10;
  var_4.y = 160;
  var_4.label = &"DEBUG_TOTAL";
  var_4.alpha = 0;
  var_05 = "off";

  for(;;) {
    var_06 = getdvar("debug_character_count");

    if(var_06 == "off") {
      if(var_06 != var_05) {
        var_0.alpha = 0;
        var_1.alpha = 0;
        var_2.alpha = 0;
        var_3.alpha = 0;
        var_4.alpha = 0;
        var_05 = var_06;
      }

      wait 0.25;
      continue;
    } else if(var_06 != var_05) {
      var_0.alpha = 1;
      var_1.alpha = 1;
      var_2.alpha = 1;
      var_3.alpha = 1;
      var_4.alpha = 1;
      var_05 = var_06;
    }

    var_07 = getEntArray("drone", "targetname").size;
    var_00 setvalue(var_07);
    var_08 = _getaiarray("allies").size;
    var_01 setvalue(var_08);
    var_09 = _getaiarray("bad_guys").size;
    var_02 setvalue(var_09);
    var_03 setvalue(getEntArray("script_vehicle", "classname").size);
    var_04 setvalue(var_07 + var_08 + var_09);
    wait 0.25;
  }
}

func_C1A6() {
  if(!self.damageshield) {
    if(isDefined(self.unittype) && self.unittype == "c12")
      self _meth_81D0((0, 0, -500), level.player);
    else
      self _meth_81D0((0, 0, -500), level.player, level.player);
  }
}

func_4EFD() {}

func_37A5() {
  wait 0.05;
  var_00 = getEntArray("camera", "targetname");

  for(var_01 = 0; var_01 < var_0.size; var_1++) {
    var_02 = getent(var_0[var_01].target, "targetname");
    var_0[var_01].func_C712 = var_2.origin;
    var_0[var_01].angles = vectortoangles(var_2.origin - var_0[var_01].origin);
  }

  for(;;) {
    var_03 = _getaiarray("axis");

    if(!var_3.size) {
      func_7370();
      wait 0.5;
      continue;
    }

    var_04 = [];

    for(var_01 = 0; var_01 < var_0.size; var_1++) {
      for(var_05 = 0; var_05 < var_3.size; var_5++) {
        if(distance(var_0[var_01].origin, var_3[var_05].origin) > 256) {
          continue;
        }
        var_4[var_4.size] = var_0[var_01];
        break;
      }
    }

    if(!var_4.size) {
      func_7370();
      wait 0.5;
      continue;
    }

    var_06 = [];

    for(var_01 = 0; var_01 < var_4.size; var_1++) {
      var_07 = var_4[var_01];
      var_08 = var_7.func_C712;
      var_09 = var_7.origin;
      var_10 = vectortoangles((var_9[0], var_9[1], var_9[2]) - (var_8[0], var_8[1], var_8[2]));
      var_11 = (0, var_10[1], 0);
      var_12 = anglesToForward(var_11);
      var_10 = vectornormalize(var_09 - level.player.origin);
      var_13 = vectordot(var_12, var_10);

      if(var_13 < 0.85) {
        continue;
      }
      var_6[var_6.size] = var_07;
    }

    if(!var_6.size) {
      func_7370();
      wait 0.5;
      continue;
    }

    var_14 = distance(level.player.origin, var_6[0].origin);
    var_15 = var_6[0];

    for(var_01 = 1; var_01 < var_6.size; var_1++) {
      var_16 = distance(level.player.origin, var_6[var_01].origin);

      if(var_16 > var_14) {
        continue;
      }
      var_15 = var_6[var_01];
      var_14 = var_16;
    }

    func_F7FD(var_15);
    wait 3;
  }
}

func_7370() {
  setdvar("cl_freemove", "0");
}

func_F7FD(var_00) {
  setdvar("cl_freemove", "2");
}

func_4E6B() {
  waittillframeend;

  for(var_00 = 0; var_00 < 50; var_0++) {
    if(!isDefined(level.func_4E6A[var_00])) {
      continue;
    }
    var_01 = level.func_4E6A[var_00];

    for(var_02 = 0; var_02 < var_1.size; var_2++) {
      var_03 = var_1[var_02];

      if(isDefined(var_3.func_12844))
        continue;
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
  var_00 = getdvarfloat("scr_requiredMapAspectRatio", 1);

  if(!isDefined(level.func_B7AF)) {
    setdvar("scr_minimap_corner_targetname", "minimap_corner");
    level.func_B7AF = "minimap_corner";
  }

  if(!isDefined(level.func_B7B1)) {
    setdvar("scr_minimap_height", "0");
    level.func_B7B1 = 0;
  }

  var_01 = getdvarfloat("scr_minimap_height");
  var_02 = getdvar("scr_minimap_corner_targetname");

  if(var_01 != level.func_B7B1 || var_02 != level.func_B7AF) {
    if(isDefined(level.func_B7B2)) {
      level.func_B7B3 unlink();
      level.func_B7B2 delete();
      level notify("end_draw_map_bounds");
    }

    if(var_01 > 0) {
      level.func_B7B1 = var_01;
      level.func_B7AF = var_02;
      var_03 = level.player;
      var_04 = getEntArray(var_02, "targetname");

      if(var_4.size == 2) {
        var_05 = var_4[0].origin + var_4[1].origin;
        var_05 = (var_5[0] * 0.5, var_5[1] * 0.5, var_5[2] * 0.5);
        var_06 = (var_4[0].origin[0], var_4[0].origin[1], var_5[2]);
        var_07 = (var_4[0].origin[0], var_4[0].origin[1], var_5[2]);

        if(var_4[1].origin[0] > var_4[0].origin[0])
          var_06 = (var_4[1].origin[0], var_6[1], var_6[2]);
        else
          var_07 = (var_4[1].origin[0], var_7[1], var_7[2]);

        if(var_4[1].origin[1] > var_4[0].origin[1])
          var_06 = (var_6[0], var_4[1].origin[1], var_6[2]);
        else
          var_07 = (var_7[0], var_4[1].origin[1], var_7[2]);

        var_08 = var_06 - var_05;
        var_05 = (var_5[0], var_5[1], var_5[2] + var_01);
        var_09 = spawn("script_origin", var_3.origin);
        var_10 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
        var_11 = (var_10[1], 0 - var_10[0], 0);
        var_12 = vectordot(var_10, var_08);

        if(var_12 < 0)
          var_12 = 0 - var_12;

        var_13 = vectordot(var_11, var_08);

        if(var_13 < 0)
          var_13 = 0 - var_13;

        if(var_00 > 0) {
          var_14 = var_13 / var_12;

          if(var_14 < var_00) {
            var_15 = var_00 / var_14;
            var_13 = var_13 * var_15;
            var_16 = vecscale(var_11, vectordot(var_11, var_06 - var_05) * (var_15 - 1));
            var_07 = var_07 - var_16;
            var_06 = var_06 + var_16;
          } else {
            var_15 = var_14 / var_00;
            var_12 = var_12 * var_15;
            var_16 = vecscale(var_10, vectordot(var_10, var_06 - var_05) * (var_15 - 1));
            var_07 = var_07 - var_16;
            var_06 = var_06 + var_16;
          }
        }

        if(level.console) {
          var_17 = 1.77778;
          var_18 = 2 * _atan(var_13 * 0.8 / var_01);
          var_19 = 2 * _atan(var_12 * var_17 * 0.8 / var_01);
        } else {
          var_17 = 1.33333;
          var_18 = 2 * _atan(var_13 * 1.05 / var_01);
          var_19 = 2 * _atan(var_12 * var_17 * 1.05 / var_01);
        }

        if(var_18 > var_19)
          var_20 = var_18;
        else
          var_20 = var_19;

        var_21 = var_01 - 1000;

        if(var_21 < 16)
          var_21 = 16;

        if(var_21 > 10000)
          var_21 = 10000;

        var_03 getweaponvarianttablename(var_09);
        var_9.origin = var_05 + (0, 0, -62);
        var_9.angles = (90, getnorthyaw(), 0);
        var_03 giveweapon("defaultweapon");
        _setsaveddvar("cg_fov", var_20);
        level.func_B7B3 = var_03;
        level.func_B7B2 = var_09;
        thread func_5B7E(var_05, var_07, var_06);
      } else {}
    }
  }
}

func_7E1F() {
  var_00 = [];
  var_00 = getEntArray("minimap_line", "script_noteworthy");
  var_01 = [];

  for(var_02 = 0; var_02 < var_0.size; var_2++)
    var_1[var_02] = var_0[var_02] func_7E1E();

  return var_01;
}

func_7E1E() {
  var_00 = [];
  var_01 = self;

  while(isDefined(var_01)) {
    var_0[var_0.size] = var_01;

    if(!isDefined(var_01) || !isDefined(var_1.target)) {
      break;
    }
    var_01 = getent(var_1.target, "targetname");

    if(isDefined(var_01) && var_01 == var_0[0]) {
      var_0[var_0.size] = var_01;
      break;
    }
  }

  var_02 = [];

  for(var_03 = 0; var_03 < var_0.size; var_3++)
    var_2[var_03] = var_0[var_03].origin;

  return var_02;
}

vecscale(var_00, var_01) {
  return (var_0[0] * var_01, var_0[1] * var_01, var_0[2] * var_01);
}

func_5B7E(var_00, var_01, var_02) {
  level notify("end_draw_map_bounds");
  level endon("end_draw_map_bounds");
  var_03 = var_0[2] - var_2[2];
  var_04 = length(var_01 - var_02);
  var_05 = var_01 - var_00;
  var_05 = vectornormalize((var_5[0], var_5[1], 0));
  var_01 = var_01 + vecscale(var_05, var_04 * 1 / 800 * 0);
  var_06 = var_02 - var_00;
  var_06 = vectornormalize((var_6[0], var_6[1], 0));
  var_02 = var_02 + vecscale(var_06, var_04 * 1 / 800 * 0);
  var_07 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  var_08 = var_02 - var_01;
  var_09 = vecscale(var_07, vectordot(var_08, var_07));
  var_10 = vecscale(var_07, abs(vectordot(var_08, var_07)));
  var_11 = var_01;
  var_12 = var_01 + var_09;
  var_13 = var_02;
  var_14 = var_02 - var_09;
  var_15 = vecscale(var_01 + var_02, 0.5) + vecscale(var_10, 0.51);
  var_16 = var_04 * 0.003;
  var_17 = func_7E1F();

  for(;;) {
    scripts\engine\utility::array_levelthread(var_17, scripts\engine\utility::plot_points);
    wait 0.05;
  }
}

func_4EC0() {
  wait 0.05;
  var_00 = _getaiarray();
  var_01 = [];
  var_1["axis"] = [];
  var_1["allies"] = [];
  var_1["neutral"] = [];

  for(var_02 = 0; var_02 < var_0.size; var_2++) {
    var_03 = var_0[var_02];

    if(!isDefined(var_3.func_4BDF)) {
      continue;
    }
    var_1[var_3.team][var_3.func_4BDF] = 1;
    var_04 = (1, 1, 1);

    if(isDefined(var_3.func_EDAD))
      var_04 = level.func_4391[var_3.func_EDAD];

    if(var_3.team == "axis") {
      continue;
    }
    var_03 func_12879();
  }

  draw_colornodes(var_01, "allies");
  draw_colornodes(var_01, "axis");
}

draw_colornodes(var_00, var_01) {
  var_02 = getarraykeys(var_0[var_01]);

  for(var_03 = 0; var_03 < var_2.size; var_3++) {
    var_04 = (1, 1, 1);
    var_04 = level.func_4391[getsubstr(var_2[var_03], 0, 1)];

    if(isDefined(level.func_43AD[var_01][var_2[var_03]])) {
      var_05 = level.func_43AD[var_01][var_2[var_03]];

      for(var_06 = 0; var_06 < var_5.size; var_6++) {}
    }
  }
}

func_7CE8() {
  if(self.team == "allies") {
    if(!isDefined(self.node.func_ED33)) {
      return;
    }
    return self.node.func_ED33;
  }

  if(self.team == "axis") {
    if(!isDefined(self.node.func_ED34)) {
      return;
    }
    return self.node.func_ED34;
  }
}

func_12879() {
  if(!isDefined(self.node)) {
    return;
  }
  if(!isDefined(self.func_EDAD)) {
    return;
  }
  var_00 = func_7CE8();

  if(!isDefined(var_00)) {
    return;
  }
  if(!issubstr(var_00, self.func_EDAD))
    return;
}

func_4F55() {
  level.func_A91E = gettime();
  thread func_4F56();
}

func_4F56() {}

func_56E2(var_00, var_01) {
  if(self.team == var_0.team) {
    return;
  }
  var_02 = 0;
  var_02 = var_02 + self.threatbias;
  var_03 = 0;
  var_03 = var_03 + var_0.threatbias;
  var_04 = undefined;

  if(isDefined(var_01)) {
    var_04 = self getthreatbiasgroup();

    if(isDefined(var_04)) {
      var_03 = var_03 + getthreatbias(var_01, var_04);
      var_02 = var_02 + getthreatbias(var_04, var_01);
    }
  }

  if(var_0.ignoreme || var_03 < -900000)
    var_03 = "Ignore";

  if(self.ignoreme || var_02 < -900000)
    var_02 = "Ignore";

  var_05 = 20;
  var_06 = (1, 0.5, 0.2);
  var_07 = (0.2, 0.5, 1);
  var_08 = !isplayer(self) && self.pacifist;

  for(var_09 = 0; var_09 <= var_05; var_9++) {
    if(isDefined(var_01)) {}

    if(isDefined(var_04)) {}

    if(var_08) {}

    wait 0.05;
  }
}

func_4F3B() {
  level.func_4EBE = [];
  level.func_4EBF = [];

  for(;;) {
    level waittill("updated_color_friendlies");
    draw_closest_wall_points();
  }
}

func_7C31() {
  var_00 = [];
  var_0["r"] = (1, 0, 0);
  var_0["o"] = (1, 0.5, 0);
  var_0["y"] = (1, 1, 0);
  var_0["g"] = (0, 1, 0);
  var_0["c"] = (0, 1, 1);
  var_0["b"] = (0, 0, 1);
  var_0["p"] = (1, 0, 1);
  return var_00;
}

draw_closest_wall_points() {
  level endon("updated_color_friendlies");
  var_00 = getarraykeys(level.func_4EBE);
  var_01 = [];
  var_02 = [];
  var_2[var_2.size] = "r";
  var_2[var_2.size] = "o";
  var_2[var_2.size] = "y";
  var_2[var_2.size] = "g";
  var_2[var_2.size] = "c";
  var_2[var_2.size] = "b";
  var_2[var_2.size] = "p";
  var_03 = func_7C31();

  for(var_04 = 0; var_04 < var_2.size; var_4++)
    var_1[var_2[var_04]] = 0;

  for(var_04 = 0; var_04 < var_0.size; var_4++) {
    var_05 = level.func_4EBE[var_0[var_04]];
    var_1[var_05]++;
  }

  for(var_04 = 0; var_04 < level.func_4EBF.size; var_4++)
    level.func_4EBF[var_04] destroy();

  level.func_4EBF = [];
  var_06 = 15;
  var_07 = 365;
  var_08 = 25;
  var_09 = 25;

  for(var_04 = 0; var_04 < var_2.size; var_4++) {
    if(var_1[var_2[var_04]] <= 0) {
      continue;
    }
    for(var_10 = 0; var_10 < var_1[var_2[var_04]]; var_10++) {
      var_11 = newhudelem();
      var_11.x = var_06 + 25 * var_10;
      var_11.y = var_07;
      var_11 setshader("white", 16, 16);
      var_11.alignx = "left";
      var_11.aligny = "bottom";
      var_11.alpha = 1;
      var_11.color = var_3[var_2[var_04]];
      level.func_4EBF[level.func_4EBF.size] = var_11;
    }

    var_07 = var_07 + var_09;
  }
}

func_77F0(var_00) {
  if(!isDefined(level.func_1FD4[var_0.func_1FBB])) {
    return;
  }
  if(!isDefined(level.func_1FD4[var_0.func_1FBB][var_0.func_1FAF])) {
    return;
  }
  if(!isDefined(level.func_1FD4[var_0.func_1FBB][var_0.func_1FAF][var_0.func_C0C2])) {
    return;
  }
  return level.func_1FD4[var_0.func_1FBB][var_0.func_1FAF][var_0.func_C0C2]["soundalias"];
}

func_9BEC(var_00, var_01, var_02) {
  return isDefined(level.func_1FD4[var_00][var_01][var_02]["created_by_animSound"]);
}

func_4EA9(var_00) {}

func_4EAA() {}

func_113E6(var_00, var_01) {
  if(!isDefined(level.func_1FDA)) {
    return;
  }
  if(!isDefined(level.func_1FDA.func_1FDC[var_01])) {
    return;
  }
  var_02 = level.func_1FDA.func_1FDC[var_01];
  var_03 = func_77F0(var_02);

  if(!isDefined(var_03) || func_9BEC(var_2.func_1FBB, var_2.func_1FAF, var_2.func_C0C2)) {
    level.func_1FD4[var_2.func_1FBB][var_2.func_1FAF][var_2.func_C0C2]["soundalias"] = var_00;
    level.func_1FD4[var_2.func_1FBB][var_2.func_1FAF][var_2.func_C0C2]["created_by_animSound"] = 1;
  }
}

func_6C96(var_00) {}

func_3D44(var_00) {
  if(!isDefined(level.func_3D30))
    level.func_3D30 = -1;

  if(level.func_3D30 == var_00) {
    return;
  }
  func_6C96(var_00);

  if(!isDefined(level.func_3D31)) {
    return;
  }
  level.func_3D30 = var_00;

  if(!isDefined(level.func_3D2F))
    level.func_3D2F = level.func_3D31 scripts\engine\utility::spawn_tag_origin();

  thread func_3D45(level.func_3D31);
}

func_3D45(var_00) {
  level notify("new_chasecam");
  level endon("new_chasecam");
  var_00 endon("death");
  level.player unlink();
  level.player getweaponweight(level.func_3D2F, "tag_origin", 2, 0.5, 0.5);
  wait 2;
  level.player getweightedchanceroll(level.func_3D2F, "tag_origin", 1, 180, 180, 180, 180);

  for(;;) {
    wait 0.2;

    if(!isDefined(level.func_3D31)) {
      return;
    }
    var_01 = level.func_3D31.origin;
    var_02 = level.func_3D31.angles;
    var_03 = anglesToForward(var_02);
    var_03 = var_03 * 200;
    var_01 = var_01 + var_03;
    var_02 = level.player getplayerangles();
    var_03 = anglesToForward(var_02);
    var_03 = var_03 * -200;
    level.func_3D2F moveto(var_01 + var_03, 0.2);
  }
}

func_13399() {
  foreach(var_01 in level.createfxent) {
    if(isDefined(var_1.looper)) {}
  }
}

func_1705(var_00, var_01) {}

func_D908(var_00) {
  if(!isDefined(level.func_134AD))
    level.func_134AD = 9500;

  level.func_134AD++;
  var_01 = "bridge_helpers";
  func_1705("origin", self.origin[0] + " " + self.origin[1] + " " + self.origin[2]);
  func_1705("angles", self.angles[0] + " " + self.angles[1] + " " + self.angles[2]);
  func_1705("targetname", "helper_model");
  func_1705("model", self.model);
  func_1705("classname", "script_model");
  func_1705("spawnflags", "4");
  func_1705("_color", "0.443137 0.443137 1.000000");

  if(isDefined(var_00))
    func_1705("script_noteworthy", var_00);
}

draw_dot_for_ent(var_00) {}

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
    if(!isDefined(var_3.code_classname)) {
      continue;
    }
    if(issubstr(var_3.code_classname, "weapon"))
      var_1[var_3.classname] = 1;
  }

  foreach(var_07, var_06 in var_01) {}

  var_08 = _getspawnerarray();
  var_09 = [];

  foreach(var_11 in var_08)
  var_9[var_11.code_classname] = 1;

  foreach(var_14, var_06 in var_09) {}
}

func_B514() {
  thread func_4EC2();
  setdvar("debug_measure", 2);
  var_00 = [];
  var_01 = 0;

  while(getdvarint("debug_measure")) {
    if(level.player usebuttonpressed() && gettime() > var_01) {
      if(var_0.size == 2)
        var_00 = [];
      else {
        var_02 = level.func_4EA1.func_4C23;
        var_0[var_0.size] = var_02;
      }

      var_01 = gettime() + 500;
    }

    foreach(var_07, var_02 in var_00) {
      func_5B38(var_02);

      if(var_07 > 0) {
        var_04 = distance(var_02, var_0[var_07 - 1]);
        var_05 = vectornormalize(var_0[var_07 - 1] - var_02);
        var_06 = var_02 + var_05 * var_04 * 0.5;
      }
    }

    if(var_0.size == 2) {
      var_08 = (1, 0, 0);
      var_08 = (0, 1, 0);
      var_08 = (0.2, 0.2, 1);
      var_09 = var_00;

      if(var_0[1][2] > var_9[0][2])
        var_09 = [var_0[1], var_0[0]];

      var_10 = var_9[0];
      var_11 = (var_10[0], var_10[1], var_9[1][2]);
      var_04 = distance(var_10, var_11);
      var_05 = vectornormalize(var_11 - var_10);
      var_12 = var_10 + var_05 * var_04 * 0.6;
    }

    wait 0.05;
  }

  level notify("stop_debug_cursor");
}

func_4EC2() {
  level.func_4EA1.func_4C23 = (0, 0, 0);
  level notify("stop_debug_cursor");
  level endon("stop_debug_cursor");

  for(;;) {
    var_00 = level.player getEye();
    var_01 = anglesToForward(level.player getplayerangles());
    var_02 = var_00 + var_01 * 10000;
    var_03 = bulletTrace(var_00, var_02, 0);
    level.func_4EA1.func_4C23 = var_3["position"];
    func_5B38(level.func_4EA1.func_4C23);
    wait 0.05;
  }
}

func_5B38(var_00) {
  level endon("stop_debug_cursor");
  var_01 = 4;
  var_02 = (1, 1, 1);
  var_03 = 1;
  var_04 = 1;
}

func_5B54(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!isDefined(var_01))
    var_01 = (0, 0, 0);

  if(!isDefined(var_03))
    var_03 = 32;

  if(!isDefined(var_04))
    var_04 = 1;

  if(!isDefined(var_05))
    var_05 = 0;

  var_06 = anglestoup(var_01);
  var_07 = anglesToForward(var_01);
  var_08 = var_00 + var_06 * var_03 * 0.5;
  var_09 = var_08 + var_07 * var_03;
  func_5B5D(var_08, var_09, var_02, var_04, var_05);
  func_5B24(var_00, var_02, var_01, var_03, var_04, var_05);
}

func_5B5D(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_03))
    var_03 = 1;

  if(!isDefined(var_04))
    var_04 = 0;

  var_05 = vectortoangles(var_01 - var_00);
  var_06 = length(var_01 - var_00);
  var_07 = anglesToForward(var_05);
  var_08 = var_07 * var_06;
  var_09 = 5;
  var_10 = var_07 * (var_06 - var_09);
  var_11 = anglestoright(var_05);
  var_12 = var_11 * (var_09 * -1);
  var_13 = var_11 * var_09;
}

func_5B24(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!isDefined(var_03))
    var_03 = 32;

  if(!isDefined(var_02))
    var_02 = (0, 0, 0);

  if(!isDefined(var_04))
    var_04 = 1;

  if(!isDefined(var_05))
    var_05 = 0;

  var_06 = anglesToForward(var_02);
  var_07 = anglestoright(var_02);
  var_08 = anglestoup(var_02);
  var_09 = var_00 + var_06 * var_03 * 0.5;
  var_09 = var_09 + var_07 * var_03 * 0.5;
  var_10 = [];
  var_10[var_10.size] = var_09;
  var_10[var_10.size] = var_10[var_10.size - 1] + var_06 * var_03 * -1;
  var_10[var_10.size] = var_10[var_10.size - 1] + var_07 * var_03 * -1;
  var_10[var_10.size] = var_10[var_10.size - 1] + var_06 * var_03;
  var_11 = var_03 * var_08;

  for(var_12 = 0; var_12 < var_10.size; var_12++) {
    if(var_12 == var_10.size - 1)
      continue;
  }
}