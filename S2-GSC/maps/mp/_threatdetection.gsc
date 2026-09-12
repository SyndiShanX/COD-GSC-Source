/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_threatdetection.gsc
*********************************************/

init() {
  level.var_72E = spawnStruct();
  level.var_72E.var_2BBA = "stencil_outline";
  level.var_72E.var_8E4 = getDvar("threat_detection_highlight_style", level.var_72E.var_2BBA);
  level thread onplayerconnect();
  level thread func_A8EA();
}

func_20CA(param_00) {
  if(param_00 == level.var_72E.var_8E4) {
    return;
  }

  foreach(var_02 in level.players) {
    if(isDefined(var_02.var_72E.var_6008)) {
      var_02.var_72E.var_6008 delete();
    }

    if(isDefined(var_02.var_72E.var_6009)) {
      var_02.var_72E.var_6009 delete();
    }

    if(isDefined(var_02.var_600A) && isDefined(var_02.var_600A.var_3F3F)) {
      foreach(var_04 in var_02.var_600A.var_3F3F) {
        if(isDefined(var_04.var_376D)) {
          var_04.var_376D delete();
        }

        if(isDefined(var_04.var_3EE0)) {
          var_04.var_3EE0 delete();
        }

        if(isDefined(var_04.var_376C)) {
          var_04.var_376C delete();
        }

        if(isDefined(var_04.var_3EDF)) {
          var_04.var_3EDF delete();
        }
      }
    }
  }

  foreach(var_02 in level.players) {
    var_02 func_9976(param_00);
  }

  level.var_72E.var_8E4 = param_00;
}

func_46DD() {
  var_00 = getDvar("threat_detection_highlight_style", level.var_72E.var_2BBA);
  if(var_00 != level.var_72E.var_8E4) {
    func_20CA(var_00);
  }

  return var_00;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread onplayerspawned();
  }
}

func_A8EA() {
  for(;;) {
    level waittill("spawned_agent", var_00);
    var_00.var_72E = spawnStruct();
    var_00.var_72E.var_8C07 = [];
    var_00 thread func_6AB6();
  }
}

func_6AB6() {
  self endon("death");
  childthread func_63EC();
  childthread func_238E();
}

onplayerspawned() {
  self endon("disconnect");
  self.var_72E = spawnStruct();
  self.var_72E.var_8C07 = [];
  self waittill("spawned_player");
  childthread func_63EC();
  childthread func_238E();
  childthread func_63ED();
  for(;;) {
    self waittill("spawned_player");
    var_00 = func_46DD();
    if(var_00 == "attached_glow") {
      func_A573(::func_A576, ::func_4513, undefined);
    }
  }
}

func_63ED() {
  var_00 = newclienthudelem(self);
  var_00.x = 0;
  var_00.y = 0;
  var_00.alignx = "left";
  var_00.aligny = "top";
  var_00.horzalign = "fullscreen";
  var_00.vertalign = "fullscreen";
  var_00 setshader("paint_overlay", 640, 480);
  var_00.alpha = 0;
  var_00.color = (0, 0, 0);
  var_00.sort = -3;
  var_00.hidden = 1;
  var_01 = 0.5;
  var_02 = 0.3;
  for(;;) {
    if(self.var_72E.var_8C07.size != 0) {
      if(var_00.hidden) {
        var_00.hidden = 0;
        var_00 childthread func_9991(var_01, var_02);
      }
    } else if(!var_00.hidden) {
      var_00.hidden = 1;
      var_00 notify("stop_overlay_flash");
      if(var_00.alpha > 0) {
        var_00 fadeovertime(var_02);
        var_00.color = (0, 0, 0);
        var_00.alpha = 0;
        wait(var_02);
      }
    }

    wait 0.05;
  }
}

func_9991(param_00, param_01) {
  self endon("stop_overlay_flash");
  self fadeovertime(param_00);
  self.color = (1, 1, 1);
  self.alpha = 1;
}

createprimaryprogressbar() {
  for(;;) {
    var_00 = distance(self.origin, level.players[0].origin);
    thread common_scripts\utility::func_33BA(level.players[0].origin, self.origin, 1, 1, 1, 0.3);
    if(isDefined(self.var_72E.var_6008)) {
      thread common_scripts\utility::func_33BA(level.players[0].origin, self.var_72E.var_6008.origin, 1, 1, 1, 0.3);
    }

    wait(0.3);
  }
}

func_238E() {
  self endon("disconnect");
  for(;;) {
    self waittill("death");
    func_7CFE();
  }
}

func_7CFE() {
  foreach(var_01 in level.players) {
    foreach(var_03 in var_01.var_72E.var_8C07) {
      if(var_03.player == self) {
        var_03.var_36ED = 0;
      }
    }
  }

  var_06 = func_46DD();
  if(var_06 == "attached_glow") {
    func_A573(::func_A575, ::func_4513, undefined);
  }
}

func_2E59(param_00, param_01, param_02) {
  var_03 = newclienthudelem(param_00);
  if(isDefined(param_02) && param_02) {
    var_03.color = (0.1, 0.0015, 0.0015);
  } else {
    var_03.color = (1, 0.015, 0.015);
  }

  var_03.alpha = 1;
  var_03 method_83A9(param_01);
  return var_03;
}

func_2E58(param_00) {
  if(isDefined(param_00)) {
    param_00 destroy();
  }
}

func_2E57(param_00, param_01, param_02, param_03) {
  var_04 = func_2E59(param_00, param_01, param_02);
  if(isDefined(param_03)) {
    param_00 common_scripts\utility::waittill_notify_or_timeout(param_03, param_01);
  } else {
    wait(param_01);
  }

  func_2E58(var_04);
}

func_2E56(param_00, param_01, param_02, param_03) {
  var_04 = newhudelem();
  var_04.x = param_01[0];
  var_04.y = param_01[1];
  var_04.z = param_01[2];
  var_04.color = (getdvarfloat("scr_paintexplosionred"), getdvarfloat("scr_paintexplosiongreen"), getdvarfloat("scr_paintexplosionblue"));
  var_04.alpha = getdvarfloat("scr_paintexplosionalpha");
  var_05 = getdvarint("paintexplosionwidth");
  var_04 method_83A8(int(param_03 + var_05 / 2), int(var_05), param_02 + 0.05);
  wait(param_02);
  if(isDefined(var_04)) {
    var_04 destroy();
  }
}

func_3902(param_00, param_01, param_02, param_03, param_04) {
  var_05 = undefined;
  if(isDefined(param_03)) {
    var_05 = newclienthudelem(param_03);
  } else {
    var_05 = newhudelem();
  }

  var_05.x = param_00[0];
  var_05.y = param_00[1];
  var_05.z = param_00[2];
  if(isDefined(param_04) && param_04) {
    var_05.color = (0.05, 0.05, 0.05);
  } else {
    var_05.color = (0.8, 0.8, 0.8);
  }

  var_05.alpha = 0.05;
  var_06 = getdvarint("scr_exopingwidth", 100);
  var_05 method_83A8(int(param_02), int(var_06), param_01 + 0.05);
  wait(param_01);
  if(isDefined(var_05)) {
    var_05 destroy();
  }
}

func_09F5(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isalive(self)) {
    return;
  }

  var_06 = gettime();
  var_07 = var_06 + param_01 * 1000;
  var_08 = var_07 - 9 * param_01 * 1000 / 10;
  var_09 = func_46DD();
  if(var_07 - var_08 < 250) {
    var_08 = 250 + var_06;
  }

  if(var_09 == "model") {
    var_08 = var_06;
  } else if(var_09 == "vfx_model") {
    var_08 = var_06;
  } else if(var_09 == "attached_glow") {
    var_08 = var_07;
  } else if(var_09 == "stencil_outline") {
    var_08 = var_07;
  }

  foreach(var_0B in param_00) {
    var_0C = 0;
    foreach(var_0E in self.var_72E.var_8C07) {
      if(var_0E.player == var_0B) {
        if(var_07 > var_0E.var_36ED) {
          var_0E.var_36ED = var_07;
          var_0E.var_5F17 = var_08;
          var_0E.var_38C5 = param_02;
        }

        var_0C = 1;
        break;
      }
    }

    if(!var_0C) {
      var_10 = self.var_72E.var_8C07.size;
      self.var_72E.var_8C07[var_10] = spawnStruct();
      self.var_72E.var_8C07[var_10].player = var_0B;
      self.var_72E.var_8C07[var_10].var_36ED = var_07;
      self.var_72E.var_8C07[var_10].var_5F17 = var_08;
      self.var_72E.var_8C07[var_10].var_38C5 = param_02;
      if(isPlayer(self)) {
        if(!isDefined(param_05) || param_05) {
          self playlocalsound("flag_spawned");
        }
      }
    }
  }

  if(isPlayer(self)) {
    if(param_04) {
      func_A573(::func_A57A, ::func_44F0, undefined);
    }

    if(param_03) {
      func_A573(::func_A57A, ::func_4513, undefined);
    }
  }
}

func_9414(param_00) {
  foreach(var_02 in self.var_72E.var_8C07) {
    if(var_02.var_38C5 == param_00) {
      var_02.var_36ED = 0;
    }
  }

  var_04 = func_46DD();
  if(var_04 == "attached_glow") {
    func_A573(::func_A575, ::func_4513, undefined);
  }
}

func_A573(param_00, param_01, param_02) {
  var_03 = func_46DD();
  if(var_03 == "glow") {
    foreach(var_06, var_05 in self.var_600A.var_3F3F) {
      [[param_00]]([[param_01]](var_05), param_02, level.var_72E.var_3F3D[var_06][0]);
    }

    return;
  }

  if(var_03 == "model") {
    [[param_00]]([[param_01]](self.var_72E), param_02, "tag_origin");
    return;
  }

  if(var_03 == "vfx_model") {
    [[param_00]]([[param_01]](self.var_72E), param_02, "tag_origin");
    return;
  }

  if(var_03 == "attached_glow") {
    foreach(var_06, var_05 in self.var_600A.var_3F3F) {
      [[param_00]]([[param_01]](var_05), param_02, level.var_72E.var_3F3D[var_06][0]);
    }

    return;
  }

  if(var_03 == "stencil_outline") {
    [[param_00]](self, param_02, "tag_origin");
    return;
  }
}

func_A576(param_00, param_01, param_02) {
  param_00 unlink();
  param_00.origin = self gettagorigin(param_02);
  param_00.angles = self gettagangles(param_02);
  param_00 linkTo(self, param_02);
  wait 0.05;
  playFXOnTag(param_00.var_3F2F, param_00, "tag_origin");
}

func_A575(param_00, param_01, param_02) {
  var_03 = func_46DD();
  if(var_03 == "attached_glow") {
    stopFXOnTag(param_00.var_3F2F, param_00, "tag_origin");
  }
}

func_A57A(param_00, param_01, param_02) {
  var_03 = func_46DD();
  param_00.origin = self gettagorigin(param_02);
  param_00.angles = self gettagangles(param_02);
  if(var_03 == "glow") {
    triggerfx(param_00);
    return;
  }

  if(var_03 == "model") {
    var_04 = "mp_hud_" + self getstance() + "_char";
    var_05 = param_00 != self.var_72E.var_6009;
    if(var_05) {
      var_04 = var_04 + "_hostile";
    }

    var_06 = param_00.model;
    if(var_04 != var_06) {
      param_00 setModel(var_04);
      return;
    }

    return;
  }

  if(var_03 == "vfx_model") {
    switch (self getstance()) {
      case "prone":
        var_04 = "threat_detect_model_prone";
        break;

      case "crouch":
        var_04 = "threat_detect_model_crouch";
        break;

      case "stand":
      default:
        var_04 = "threat_detect_model_stand";
        break;
    }

    var_05 = param_00 != self.var_72E.var_6009;
    var_06 = self.var_72E.var_3EB9;
    if(var_05) {
      var_04 = var_04 + "_hostile";
      var_06 = self.var_72E.var_4E01;
    }

    if(var_06 != var_04) {
      var_07 = anglesToForward(self.angles);
      var_08 = anglestoup(self.angles);
      if(var_05) {
        self.var_72E.var_6008 delete();
        self.var_72E.var_6008 = spawnfx(common_scripts\utility::func_44F5(var_04), self.origin, var_07, var_08);
        self.var_72E.var_6008 hide();
        self.var_72E.var_4E01 = var_04;
      } else {
        self.var_72E.var_6009 delete();
        self.var_72E.var_6009 = spawnfx(common_scripts\utility::func_44F5(var_04), self.origin, var_07, var_08);
        self.var_72E.var_6009 hide();
        self.var_72E.var_3EB9 = var_04;
      }
    }

    if(var_05) {
      triggerfx(self.var_72E.var_6008);
      return;
    }

    triggerfx(self.var_72E.var_6009);
    return;
  }

  if(var_03 == "attached_glow") {
    return;
  }

  if(var_03 == "stencil_outline") {
    return;
  }
}

func_4513(param_00) {
  var_01 = func_46DD();
  if(var_01 == "glow") {
    return param_00.var_376D;
  }

  if(var_01 == "model") {
    return param_00.var_6008;
  }

  if(var_01 == "vfx_model") {
    return param_00.var_6008;
  }

  if(var_01 == "attached_glow") {
    return param_00;
  }

  if(var_01 == "stencil_outline") {
    return param_00;
  }
}

func_44F0(param_00) {
  var_01 = func_46DD();
  if(var_01 == "glow") {
    return param_00.var_3EE0;
  }

  if(var_01 == "model") {
    return param_00.var_6009;
  }

  if(var_01 == "vfx_model") {
    return param_00.var_6009;
  }
}

func_44EF(param_00) {
  var_01 = func_46DD();
  if(var_01 == "glow") {
    return param_00.var_3EDF;
  }

  if(var_01 == "model") {
    return param_00.var_6009;
  }

  if(var_01 == "vfx_model") {
    return param_00.var_6009;
  }
}

func_4512(param_00) {
  var_01 = func_46DD();
  if(var_01 == "glow") {
    return param_00.var_376C;
  }

  if(var_01 == "model") {
    return param_00.var_6008;
  }

  if(var_01 == "vfx_model") {
    return param_00.var_6008;
  }

  if(var_01 == "attached_glow") {
    return param_00;
  }

  if(var_01 == "stencil_outline") {
    return param_00;
  }
}

func_A574(param_00, param_01, param_02) {
  foreach(var_04 in param_00) {
    var_04 hide();
  }
}

func_0850(param_00) {
  return [param_00.var_3EE0, param_00.var_376D, param_00.var_3EDF, param_00.var_376C];
}

func_45B7(param_00) {
  return vectorNormalize(common_scripts\utility::func_3D5D(param_00));
}

func_63EC() {
  func_9976(func_46DD());
  var_00 = (0, 0, 32);
  var_01 = 0;
  for(;;) {
    wait 0.05;
    var_02 = gettime();
    var_03 = 0;
    foreach(var_05 in self.var_72E.var_8C07) {
      if(var_05.var_36ED >= var_02) {
        if(!isDefined(var_05.player)) {
          self.var_72E.var_8C07 = common_scripts\utility::func_F93(self.var_72E.var_8C07, var_05);
          continue;
        }

        var_05.var_5F14 = 0;
        var_06 = func_45B7(anglesToForward(var_05.player.angles));
        var_07 = func_45B7(self.origin - var_05.player.origin);
        var_08 = vectordot(var_07, var_06);
        if(var_08 < 0) {
          continue;
        }

        if(func_217C(var_05)) {
          var_05.var_5F14 = 1;
          if(var_05.var_5F17 <= var_02) {
            self.var_72E.var_8C07 = common_scripts\utility::func_F93(self.var_72E.var_8C07, var_05);
            continue;
          }
        }

        var_03 = 1;
        continue;
      }

      self.var_72E.var_8C07 = common_scripts\utility::func_F93(self.var_72E.var_8C07, var_05);
    }

    var_0A = func_46DD();
    if(!var_01) {
      var_01 = 1;
      if(var_0A == "glow") {
        foreach(var_0C in self.var_600A.var_3F3F) {
          var_0C.var_376D hide();
          var_0C.var_3EE0 hide();
          var_0C.var_376C hide();
          var_0C.var_3EDF hide();
        }
      } else if(var_0A == "model") {
        self.var_72E.var_6009 hide();
        self.var_72E.var_6008 hide();
      } else if(var_0A == "vfx_model") {
        self.var_72E.var_6009 hide();
        self.var_72E.var_6008 hide();
      } else if(var_0A == "attached_glow") {
        foreach(var_05 in self.var_600A.var_3F3F) {
          stopFXOnTag(var_05.var_3F2F, var_05, "tag_origin");
          var_05 hide();
        }
      } else {}
    }

    if(!var_03) {
      continue;
    }

    foreach(var_10 in self.var_72E.var_8C07) {
      if(var_10.var_5F14) {
        func_8C1D(var_10.player, ::func_44EF, ::func_4512, ::func_A579);
        func_76A0(var_01, var_0A, var_10.player);
        var_01 = 0;
        continue;
      }

      var_11 = bulletTrace(var_10.player.origin + var_00, self.origin + var_00, 1, var_10.player);
      if(var_11["fraction"] < 1 && !isPlayer(var_11["entity"])) {
        func_8C1D(var_10.player, ::func_44F0, ::func_4513, ::func_A578);
        func_76A0(var_01, var_0A, var_10.player);
        var_01 = 0;
      }
    }
  }
}

func_76A0(param_00, param_01, param_02) {
  if(param_00) {
    if(param_01 == "attached_glow") {
      func_8C1D(param_02, ::func_44EF, ::func_4512, ::func_A577);
    }
  }
}

func_A577(param_00, param_01, param_02) {
  playFXOnTag(param_00.var_3F2F, param_00, "tag_origin");
}

func_217C(param_00) {
  if(bullettracepassed(param_00.player getEye(), self getEye(), 0, param_00.player)) {
    return 1;
  }

  return 0;
}

func_9976(param_00) {
  var_01 = spawnStruct();
  var_01.var_3F3F = [];
  if(param_00 == "glow") {
    foreach(var_05, var_03 in level.var_72E.var_3F3D) {
      var_04 = spawnStruct();
      var_04.origin = self gettagorigin(var_03[0]);
      var_04.angles = self gettagangles(var_03[0]);
      var_04.var_376D = spawnfx(var_03[1], var_04.origin);
      triggerfx(var_04.var_376D);
      var_04.var_376D hide();
      var_04.var_376C = spawnfx(var_03[3], var_04.origin);
      triggerfx(var_04.var_376C);
      var_04.var_376C hide();
      var_04.var_3EE0 = spawnfx(var_03[2], var_04.origin);
      triggerfx(var_04.var_3EE0);
      var_04.var_3EE0 hide();
      var_04.var_3EDF = spawnfx(var_03[4], var_04.origin);
      triggerfx(var_04.var_3EDF);
      var_04.var_3EDF hide();
      var_01.var_3F3F[var_05] = var_04;
    }

    self.var_600A = var_01;
    return;
  }

  if(param_00 == "model") {
    var_06 = spawn("script_model", self.origin);
    var_06.origin = self.origin;
    var_06.angles = self.angles;
    var_06 setModel(level.var_72E.var_3EE1);
    var_06 method_80B1();
    self.var_72E.var_6009 = var_06;
    var_06 = spawn("script_model", self.origin);
    var_06.origin = self.origin;
    var_06.angles = self.angles;
    var_06 setModel(level.var_72E.var_4E02);
    var_06 method_80B1();
    self.var_72E.var_6008 = var_06;
    return;
  }

  if(param_00 == "vfx_model") {
    self.var_72E.var_6009 = spawnStruct();
    self.var_72E.var_6009 = spawnfx(common_scripts\utility::func_44F5("threat_detect_model_stand"), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    self.var_72E.var_3EB9 = "threat_detect_model_stand";
    self.var_72E.var_6008 = spawnStruct();
    self.var_72E.var_6008 = spawnfx(common_scripts\utility::func_44F5("threat_detect_model_stand_hostile"), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    self.var_72E.var_4E01 = "threat_detect_model_stand_hostile";
    return;
  }

  if(param_00 == "attached_glow") {
    foreach(var_05, var_03 in level.var_72E.var_3F3D) {
      var_08 = common_scripts\utility::func_8FFC();
      var_08 show();
      var_08.origin = self gettagorigin(var_03[0]);
      var_08.angles = self gettagangles(var_03[0]);
      var_08 linkTo(self, var_03[0]);
      var_08.var_3F2F = var_03[1];
      var_01.var_3F3F[var_05] = var_08;
    }

    self.var_600A = var_01;
    return;
  }

  if(param_00 == "stencil_outline") {
    return;
  }
}

func_A579(param_00, param_01, param_02) {
  func_A57A(param_00, param_01, param_02);
  func_A578(param_00, param_01, param_02);
}

func_A578(param_00, param_01, param_02) {
  param_00 showtoclient(param_01);
}

func_8C1D(param_00, param_01, param_02, param_03) {
  if(param_00 == self) {
    return;
  }

  var_04 = param_02;
  if((level.teambased || level.multiteambased) && param_00.team == self.team) {
    var_04 = param_01;
  } else if(param_00 == self) {
    var_04 = param_01;
  }

  func_A573(param_03, var_04, param_00);
}