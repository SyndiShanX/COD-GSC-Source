/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_threatdetection.gsc
************************************************/

init() {
  level._id_072E = spawnStruct();
  level._id_072E._id_2BBA = "stencil_outline";
  level._id_072E._id_08E4 = getDvar("threat_detection_highlight_style", level._id_072E._id_2BBA);
  level thread onplayerconnect();
  level thread _id_A8EA();
}

_id_20CA(var_0) {
  if(var_0 == level._id_072E._id_08E4) {
    return;
  }
  foreach(var_2 in level.players) {
    if(isDefined(var_2._id_072E._id_6008)) {
      var_2._id_072E._id_6008 delete();
    }

    if(isDefined(var_2._id_072E._id_6009)) {
      var_2._id_072E._id_6009 delete();
    }

    if(isDefined(var_2._id_600A) && isDefined(var_2._id_600A._id_3F3F)) {
      foreach(var_5, var_4 in var_2._id_600A._id_3F3F) {
        if(isDefined(var_4._id_376D)) {
          var_4._id_376D delete();
        }

        if(isDefined(var_4._id_3EE0)) {
          var_4._id_3EE0 delete();
        }

        if(isDefined(var_4._id_376C)) {
          var_4._id_376C delete();
        }

        if(isDefined(var_4._id_3EDF)) {
          var_4._id_3EDF delete();
        }
      }
    }
  }

  foreach(var_2 in level.players) {
    var_2 _id_9976(var_0);
  }

  level._id_072E._id_08E4 = var_0;
}

_id_46DD() {
  var_0 = getDvar("threat_detection_highlight_style", level._id_072E._id_2BBA);

  if(var_0 != level._id_072E._id_08E4) {
    _id_20CA(var_0);
  }

  return var_0;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
  }
}

_id_A8EA() {
  for(;;) {
    level waittill("spawned_agent", var_0);
    var_0._id_072E = spawnStruct();
    var_0._id_072E._id_8C07 = [];
    var_0 thread _id_6AB6();
  }
}

_id_6AB6() {
  self endon("death");
  childthread _id_63EC();
  childthread _id_238E();
}

onplayerspawned() {
  self endon("disconnect");
  self._id_072E = spawnStruct();
  self._id_072E._id_8C07 = [];
  self waittill("spawned_player");
  childthread _id_63EC();
  childthread _id_238E();
  childthread _id_63ED();

  for(;;) {
    self waittill("spawned_player");
    var_0 = _id_46DD();

    if(var_0 == "attached_glow") {
      _id_A573(::_id_A576, ::_id_4513, undefined);
    }
  }
}

_id_63ED() {
  var_0 = _newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0._id_00C6 = "fullscreen";
  var_0._id_01CA = "fullscreen";
  var_0 setshader("paint_overlay", 640, 480);
  var_0.alpha = 0.0;
  var_0.color = (0, 0, 0);
  var_0.sort = -3;
  var_0._id_4CC7 = 1;
  var_1 = 0.5;
  var_2 = 0.3;

  for(;;) {
    if(self._id_072E._id_8C07.size != 0) {
      if(var_0._id_4CC7) {
        var_0._id_4CC7 = 0;
        var_0 childthread _id_9991(var_1, var_2);
      }
    } else if(!var_0._id_4CC7) {
      var_0._id_4CC7 = 1;
      var_0 notify("stop_overlay_flash");

      if(var_0.alpha > 0.0) {
        var_0 fadeovertime(var_2);
        var_0.color = (0, 0, 0);
        var_0.alpha = 0.0;
        wait(var_2);
      }
    }

    waitframe();
  }
}

_id_9991(var_0, var_1) {
  self endon("stop_overlay_flash");
  self fadeovertime(var_0);
  self.color = (1, 1, 1);
  self.alpha = 1.0;
}

_id_2B54() {
  for(;;) {
    var_0 = distance(self.origin, level.players[0].origin);
    thread common_scripts\utility::_id_33BA(level.players[0].origin, self.origin, 1, 1, 1, 0.3);

    if(isDefined(self._id_072E._id_6008)) {
      thread common_scripts\utility::_id_33BA(level.players[0].origin, self._id_072E._id_6008.origin, 1, 1, 1, 0.3);
    }

    wait 0.3;
  }
}

_id_238E() {
  self endon("disconnect");

  for(;;) {
    self waittill("death");
    _id_7CFE();
  }
}

_id_7CFE() {
  foreach(var_1 in level.players) {
    foreach(var_3 in var_1._id_072E._id_8C07) {
      if(var_3.player == self) {
        var_3._id_36ED = 0;
      }
    }
  }

  var_6 = _id_46DD();

  if(var_6 == "attached_glow") {
    _id_A573(::_id_A575, ::_id_4513, undefined);
  }
}

_id_2E59(var_0, var_1, var_2) {
  var_3 = _newclienthudelem(var_0);

  if(isDefined(var_2) && var_2) {
    var_3.color = (0.1, 0.0015, 0.0015);
  } else {
    var_3.color = (1, 0.015, 0.015);
  }

  var_3.alpha = 1.0;
  var_3 setradarhighlight(var_1);
  return var_3;
}

_id_2E58(var_0) {
  if(isDefined(var_0)) {
    var_0 destroy();
  }
}

_id_2E57(var_0, var_1, var_2, var_3) {
  var_4 = _id_2E59(var_0, var_1, var_2);

  if(isDefined(var_3)) {
    var_0 common_scripts\utility::waittill_notify_or_timeout(var_3, var_1);
  } else {
    wait(var_1);
  }

  _id_2E58(var_4);
}

_id_2E56(var_0, var_1, var_2, var_3) {
  var_4 = newhudelem();
  var_4.x = var_1[0];
  var_4.y = var_1[1];
  var_4._id_01D9 = var_1[2];
  var_4.color = (getdvarfloat("scr_paintexplosionred"), getdvarfloat("scr_paintexplosiongreen"), getdvarfloat("scr_paintexplosionblue"));
  var_4.alpha = getdvarfloat("scr_paintexplosionalpha");
  var_5 = getdvarint("paintexplosionwidth");
  var_4 setradarping(int(var_3 + var_5 / 2), int(var_5), var_2 + 0.05);
  wait(var_2);

  if(isDefined(var_4)) {
    var_4 destroy();
  }
}

_id_3902(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;

  if(isDefined(var_3)) {
    var_5 = _newclienthudelem(var_3);
  } else {
    var_5 = newhudelem();
  }

  var_5.x = var_0[0];
  var_5.y = var_0[1];
  var_5._id_01D9 = var_0[2];

  if(isDefined(var_4) && var_4) {
    var_5.color = (0.05, 0.05, 0.05);
  } else {
    var_5.color = (0.8, 0.8, 0.8);
  }

  var_5.alpha = 0.05;
  var_6 = getdvarint("scr_exopingwidth", 100);
  var_5 setradarping(int(var_2), int(var_6), var_1 + 0.05);
  wait(var_1);

  if(isDefined(var_5)) {
    var_5 destroy();
  }
}

_id_09F5(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isalive(self)) {
    return;
  }
  var_6 = gettime();
  var_7 = var_6 + var_1 * 1000;
  var_8 = var_7 - 9 * (var_1 * 1000) / 10;
  var_9 = _id_46DD();

  if(var_7 - var_8 < 250) {
    var_8 = 250 + var_6;
  }

  if(var_9 == "model") {
    var_8 = var_6;
  } else if(var_9 == "vfx_model") {
    var_8 = var_6;
  } else if(var_9 == "attached_glow") {
    var_8 = var_7;
  } else if(var_9 == "stencil_outline") {
    var_8 = var_7;
  }

  foreach(var_11 in var_0) {
    var_12 = 0;

    foreach(var_14 in self._id_072E._id_8C07) {
      if(var_14.player == var_11) {
        if(var_7 > var_14._id_36ED) {
          var_14._id_36ED = var_7;
          var_14._id_5F17 = var_8;
          var_14._id_38C5 = var_2;
        }

        var_12 = 1;
        break;
      }
    }

    if(!var_12) {
      var_16 = self._id_072E._id_8C07.size;
      self._id_072E._id_8C07[var_16] = spawnStruct();
      self._id_072E._id_8C07[var_16].player = var_11;
      self._id_072E._id_8C07[var_16]._id_36ED = var_7;
      self._id_072E._id_8C07[var_16]._id_5F17 = var_8;
      self._id_072E._id_8C07[var_16]._id_38C5 = var_2;

      if(isPlayer(self)) {
        if(!isDefined(var_5) || var_5) {
          self playlocalsound("flag_spawned");
        }
      }
    }
  }

  if(isPlayer(self)) {
    if(var_4) {
      _id_A573(::_id_A57A, ::_id_44F0, undefined);
    }

    if(var_3) {
      _id_A573(::_id_A57A, ::_id_4513, undefined);
    }
  }
}

_id_9414(var_0) {
  foreach(var_2 in self._id_072E._id_8C07) {
    if(var_2._id_38C5 == var_0) {
      var_2._id_36ED = 0;
    }
  }

  var_4 = _id_46DD();

  if(var_4 == "attached_glow") {
    _id_A573(::_id_A575, ::_id_4513, undefined);
  }
}

_id_A573(var_0, var_1, var_2) {
  var_3 = _id_46DD();

  if(var_3 == "glow") {
    foreach(var_6, var_5 in self._id_600A._id_3F3F)[[var_0]]([[var_1]](var_5), var_2, level._id_072E._id_3F3D[var_6][0]);
  } else if(var_3 == "model")
    [[var_0]]([[var_1]](self._id_072E), var_2, "tag_origin");
  else if(var_3 == "vfx_model") {
    [[var_0]]([[var_1]](self._id_072E), var_2, "tag_origin");
  } else if(var_3 == "attached_glow") {
    foreach(var_6, var_5 in self._id_600A._id_3F3F)[[var_0]]([[var_1]](var_5), var_2, level._id_072E._id_3F3D[var_6][0]);
  } else if(var_3 == "stencil_outline")
    [[var_0]](self, var_2, "tag_origin");
  else {}
}

_id_A576(var_0, var_1, var_2) {
  var_0 unlink();
  var_0.origin = self gettagorigin(var_2);
  var_0.angles = self gettagangles(var_2);
  var_0 linkTo(self, var_2);
  waitframe();
  _playFXOnTag(var_0.fx, var_0, "tag_origin");
}

_id_A575(var_0, var_1, var_2) {
  var_3 = _id_46DD();

  if(var_3 == "attached_glow") {
    _stopFXOnTag(var_0.fx, var_0, "tag_origin");
  }
}

_id_A57A(var_0, var_1, var_2) {
  var_3 = _id_46DD();
  var_0.origin = self gettagorigin(var_2);
  var_0.angles = self gettagangles(var_2);

  if(var_3 == "glow") {
    _triggerfx(var_0);
  } else if(var_3 == "model") {
    var_4 = "mp_hud_" + self getstance() + "_char";
    var_5 = var_0 != self._id_072E._id_6009;

    if(var_5) {
      var_4 = var_4 + "_hostile";
    }

    var_6 = var_0.model;

    if(var_4 != var_6) {
      var_0 setModel(var_4);
      return;
    }
  } else if(var_3 == "vfx_model") {
    switch (self getstance()) {
      case "prone":
        var_4 = "threat_detect_model_prone";
        break;
      case "crouch":
        var_4 = "threat_detect_model_crouch";
        break;
      case "stand":
      default:
        var_4 = "threat_detect_model_stand";
        break;
    }

    var_5 = var_0 != self._id_072E._id_6009;
    var_6 = self._id_072E._id_3EB9;

    if(var_5) {
      var_4 = var_4 + "_hostile";
      var_6 = self._id_072E._id_4E01;
    }

    if(var_6 != var_4) {
      var_7 = anglesToForward(self.angles);
      var_8 = anglestoup(self.angles);

      if(var_5) {
        self._id_072E._id_6008 delete();
        self._id_072E._id_6008 = _spawnfx(common_scripts\utility::_id_44F5(var_4), self.origin, var_7, var_8);
        self._id_072E._id_6008 hide();
        self._id_072E._id_4E01 = var_4;
      } else {
        self._id_072E._id_6009 delete();
        self._id_072E._id_6009 = _spawnfx(common_scripts\utility::_id_44F5(var_4), self.origin, var_7, var_8);
        self._id_072E._id_6009 hide();
        self._id_072E._id_3EB9 = var_4;
      }
    }

    if(var_5) {
      _triggerfx(self._id_072E._id_6008);
      return;
    }

    _triggerfx(self._id_072E._id_6009);
    return;
  } else {
    if(var_3 == "attached_glow") {
      return;
    }
    if(var_3 == "stencil_outline") {
      return;
    }
    return;
    return;
  }
}

_id_4513(var_0) {
  var_1 = _id_46DD();

  if(var_1 == "glow") {
    return var_0._id_376D;
  } else if(var_1 == "model") {
    return var_0._id_6008;
  } else if(var_1 == "vfx_model") {
    return var_0._id_6008;
  } else if(var_1 == "attached_glow") {
    return var_0;
  } else if(var_1 == "stencil_outline") {
    return var_0;
  } else {}
}

_id_44F0(var_0) {
  var_1 = _id_46DD();

  if(var_1 == "glow") {
    return var_0._id_3EE0;
  } else if(var_1 == "model") {
    return var_0._id_6009;
  } else if(var_1 == "vfx_model") {
    return var_0._id_6009;
  } else {}
}

_id_44EF(var_0) {
  var_1 = _id_46DD();

  if(var_1 == "glow") {
    return var_0._id_3EDF;
  } else if(var_1 == "model") {
    return var_0._id_6009;
  } else if(var_1 == "vfx_model") {
    return var_0._id_6009;
  } else {}
}

_id_4512(var_0) {
  var_1 = _id_46DD();

  if(var_1 == "glow") {
    return var_0._id_376C;
  } else if(var_1 == "model") {
    return var_0._id_6008;
  } else if(var_1 == "vfx_model") {
    return var_0._id_6008;
  } else if(var_1 == "attached_glow") {
    return var_0;
  } else if(var_1 == "stencil_outline") {
    return var_0;
  } else {}
}

_id_A574(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    var_4 hide();
  }
}

_id_0850(var_0) {
  return [var_0._id_3EE0, var_0._id_376D, var_0._id_3EDF, var_0._id_376C];
}

_id_45B7(var_0) {
  return vectorNormalize(common_scripts\utility::_id_3D5D(var_0));
}

_id_63EC() {
  _id_9976(_id_46DD());
  var_0 = (0, 0, 32);
  var_1 = 0;

  for(;;) {
    waitframe();
    var_2 = gettime();
    var_3 = 0;

    foreach(var_5 in self._id_072E._id_8C07) {
      if(var_5._id_36ED >= var_2) {
        if(!isDefined(var_5.player)) {
          self._id_072E._id_8C07 = common_scripts\utility::_id_0F93(self._id_072E._id_8C07, var_5);
          continue;
        }

        var_5._id_5F14 = 0;
        var_6 = _id_45B7(anglesToForward(var_5.player.angles));
        var_7 = _id_45B7(self.origin - var_5.player.origin);
        var_8 = vectordot(var_7, var_6);

        if(var_8 < 0) {
          continue;
        }
        if(_id_217C(var_5)) {
          var_5._id_5F14 = 1;

          if(var_5._id_5F17 <= var_2) {
            self._id_072E._id_8C07 = common_scripts\utility::_id_0F93(self._id_072E._id_8C07, var_5);
            continue;
          }
        }

        var_3 = 1;
        continue;
      }

      self._id_072E._id_8C07 = common_scripts\utility::_id_0F93(self._id_072E._id_8C07, var_5);
    }

    var_10 = _id_46DD();

    if(!var_1) {
      var_1 = 1;

      if(var_10 == "glow") {
        foreach(var_13, var_12 in self._id_600A._id_3F3F) {
          var_12._id_376D hide();
          var_12._id_3EE0 hide();
          var_12._id_376C hide();
          var_12._id_3EDF hide();
        }
      } else if(var_10 == "model") {
        self._id_072E._id_6009 hide();
        self._id_072E._id_6008 hide();
      } else if(var_10 == "vfx_model") {
        self._id_072E._id_6009 hide();
        self._id_072E._id_6008 hide();
      } else if(var_10 == "attached_glow") {
        foreach(var_13, var_5 in self._id_600A._id_3F3F) {
          _stopFXOnTag(var_5.fx, var_5, "tag_origin");
          var_5 hide();
        }
      } else {}
    }

    if(!var_3) {
      continue;
    }
    foreach(var_16 in self._id_072E._id_8C07) {
      if(var_16._id_5F14) {
        _id_8C1D(var_16.player, ::_id_44EF, ::_id_4512, ::_id_A579);
        _id_76A0(var_1, var_10, var_16.player);
        var_1 = 0;
        continue;
      }

      var_17 = bulletTrace(var_16.player.origin + var_0, self.origin + var_0, 1, var_16.player);

      if(var_17["fraction"] < 1 && !isPlayer(var_17["entity"])) {
        _id_8C1D(var_16.player, ::_id_44F0, ::_id_4513, ::_id_A578);
        _id_76A0(var_1, var_10, var_16.player);
        var_1 = 0;
      }
    }
  }
}

_id_76A0(var_0, var_1, var_2) {
  if(var_0) {
    if(var_1 == "attached_glow") {
      _id_8C1D(var_2, ::_id_44EF, ::_id_4512, ::_id_A577);
    }
  }
}

_id_A577(var_0, var_1, var_2) {
  _playFXOnTag(var_0.fx, var_0, "tag_origin");
}

_id_217C(var_0) {
  if(_bullettracepassed(var_0.player getEye(), self getEye(), 0, var_0.player)) {
    return 1;
  }

  return 0;
}

_id_9976(var_0) {
  var_1 = spawnStruct();
  var_1._id_3F3F = [];

  if(var_0 == "glow") {
    foreach(var_5, var_3 in level._id_072E._id_3F3D) {
      var_4 = spawnStruct();
      var_4.origin = self gettagorigin(var_3[0]);
      var_4.angles = self gettagangles(var_3[0]);
      var_4._id_376D = _spawnfx(var_3[1], var_4.origin);
      _triggerfx(var_4._id_376D);
      var_4._id_376D hide();
      var_4._id_376C = _spawnfx(var_3[3], var_4.origin);
      _triggerfx(var_4._id_376C);
      var_4._id_376C hide();
      var_4._id_3EE0 = _spawnfx(var_3[2], var_4.origin);
      _triggerfx(var_4._id_3EE0);
      var_4._id_3EE0 hide();
      var_4._id_3EDF = _spawnfx(var_3[4], var_4.origin);
      _triggerfx(var_4._id_3EDF);
      var_4._id_3EDF hide();
      var_1._id_3F3F[var_5] = var_4;
    }

    self._id_600A = var_1;
  } else if(var_0 == "model") {
    var_6 = spawn("script_model", self.origin);
    var_6.origin = self.origin;
    var_6.angles = self.angles;
    var_6 setModel(level._id_072E._id_3EE1);
    var_6 _meth_80B1();
    self._id_072E._id_6009 = var_6;
    var_6 = spawn("script_model", self.origin);
    var_6.origin = self.origin;
    var_6.angles = self.angles;
    var_6 setModel(level._id_072E._id_4E02);
    var_6 _meth_80B1();
    self._id_072E._id_6008 = var_6;
  } else if(var_0 == "vfx_model") {
    self._id_072E._id_6009 = spawnStruct();
    self._id_072E._id_6009 = _spawnfx(common_scripts\utility::_id_44F5("threat_detect_model_stand"), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    self._id_072E._id_3EB9 = "threat_detect_model_stand";
    self._id_072E._id_6008 = spawnStruct();
    self._id_072E._id_6008 = _spawnfx(common_scripts\utility::_id_44F5("threat_detect_model_stand_hostile"), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    self._id_072E._id_4E01 = "threat_detect_model_stand_hostile";
  } else if(var_0 == "attached_glow") {
    foreach(var_5, var_3 in level._id_072E._id_3F3D) {
      var_8 = common_scripts\utility::_id_8FFC();
      var_8 show();
      var_8.origin = self gettagorigin(var_3[0]);
      var_8.angles = self gettagangles(var_3[0]);
      var_8 linkTo(self, var_3[0]);
      var_8.fx = var_3[1];
      var_1._id_3F3F[var_5] = var_8;
    }

    self._id_600A = var_1;
  } else {
    if(var_0 == "stencil_outline") {
      return;
    }
    return;
  }
}

_id_A579(var_0, var_1, var_2) {
  _id_A57A(var_0, var_1, var_2);
  _id_A578(var_0, var_1, var_2);
}

_id_A578(var_0, var_1, var_2) {
  var_0 showtoplayer(var_1);
}

_id_8C1D(var_0, var_1, var_2, var_3) {
  if(var_0 == self) {
    return;
  }
  var_4 = var_2;

  if((level.teambased || level._id_6520) && var_0.team == self.team) {
    var_4 = var_1;
  } else if(var_0 == self) {
    var_4 = var_1;
  }

  _id_A573(var_3, var_4, var_0);
}