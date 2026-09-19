/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_audio_debug.gsc
********************************************/

main() {}

_id_06EC(var_0) {
  var_1 = getdvarint("snd_debugRavenAudioHUDY");
  var_2 = _id_02EF::_id_4719();
  var_3 = var_2[0];
  var_4 = var_2[1];

  if(var_1 < 0)
    var_1 = var_4 + var_1;

  var_5 = var_1 + 18.0 * var_0;
  return var_5;
}

_id_06ED(var_0, var_1, var_2, var_3) {
  var_4 = getdvarint("snd_debugRavenAudioHUDX");
  var_5 = _id_02EF::_id_4719();
  var_6 = var_5[0];
  var_7 = var_5[1];

  if(isDefined(var_3) == 0)
    var_3 = (1, 1, 1);

  if(var_4 < 0)
    var_4 = var_6 + var_4;

  _id_02EF::_id_8AA0(var_4 + var_0, _id_06EC(var_1), var_2, var_3, 0.75, 1.5);
}

_id_06E9() {
  var_0 = undefined;

  if(isDefined(self.origin) == 1)
    var_0 = self.origin;

  if(isDefined(self.v) == 1) {
    var_0 = self.v["origin"];
    self.origin = var_0;
    self._id_6C3F = 1;
  }

  if(_id_02F0::_id_8006(self) == "clientsnd") {
    if(isDefined(self._id_8F45) == 1) {
      var_0 = self._id_8F45.origin;
      self._id_8F46 = var_0;

      if(isDefined(self._id_8F49) == 1)
        var_0 = var_0 + self._id_8F49;
    } else if(_isremovedentity(self._id_8F45) == 1 && isDefined(self._id_8F46) == 1) {
      var_0 = self._id_8F46;

      if(isDefined(self._id_8F49) == 1)
        var_0 = var_0 + self._id_8F49;
    } else if(isDefined(self._id_8F49) == 1)
      var_0 = self._id_8F49;

    self.origin = var_0;
    self._id_6C3F = 1;
  }

  if(_isremovedentity(self) == 1)
    return undefined;

  return var_0;
}

_id_06EA() {
  var_0 = "unknown";

  if(isDefined(self.v) == 1 && isDefined(self.v["soundalias"]) == 1)
    var_0 = self.v["soundalias"];
  else if(isDefined(self._id_8F3E) == 1)
    var_0 = self._id_8F3E;

  return var_0;
}

_id_06E8(var_0, var_1, var_2, var_3) {
  var_4 = getDvar("snd_debugRavenAudioFilter");
  var_5 = _id_06EA();
  var_6 = undefined;
  var_7 = _getsndaliasvalue(var_5, "spatialize");

  if(isDefined(var_7) == 1 && var_7 == "2d")
    return -1;

  if(isDefined(var_4) == 1 && var_4 != "") {
    if(common_scripts\utility::_id_9462(var_5, var_4) < 0)
      return -1;
  }

  var_6 = _id_06E9();

  if(isDefined(var_6) == 0)
    return -1;

  var_8 = common_scripts\utility::within_fov(var_0, var_1, var_6, var_2);

  if(var_8 == 0)
    return -1;

  var_9 = distance(var_0, var_6);

  if(var_3 > 0 && var_3 < var_9)
    return -1;

  return var_9;
}

_id_06E3(var_0, var_1, var_2, var_3, var_4, var_5) {
  for(var_6 = 0; var_6 < var_1.size; var_6++) {
    var_7 = var_1[var_6];
    var_8 = var_7 _id_06E8(var_2, var_3, var_4, var_5);

    if(var_8 >= 0)
      var_0[var_0.size] = var_7;
  }

  return var_0;
}

_id_06E2(var_0, var_1) {
  var_2 = getdvarfloat("snd_debugRavenAudioDistance");
  var_3 = [];
  var_4 = var_0 getEye();
  var_5 = var_0 _meth_8566();
  var_6 = getdvarfloat("cg_fov", 65);
  var_7 = _cos(var_6);

  if(isDefined(level._id_05B0) == 1 && var_1 >= 3)
    var_3 = _id_06E3(var_3, level._id_05B0, var_4, var_5, var_7, var_2);

  if(isDefined(level._id_071D) == 1 && isDefined(level._id_071D._id_0623) == 1)
    var_3 = _id_06E3(var_3, level._id_071D._id_0623, var_4, var_5, var_7, var_2);

  if(isDefined(level._id_06B2) == 1) {
    if(isDefined(level._id_06B2._id_061A) == 1)
      var_3 = _id_06E3(var_3, level._id_06B2._id_061A, var_4, var_5, var_7, var_2);

    if(isDefined(level._id_06B2._id_0720) == 1)
      var_3 = _id_06E3(var_3, level._id_06B2._id_0720, var_4, var_5, var_7, var_2);

    if(isDefined(level._id_06B2._id_05E5) == 1)
      var_3 = _id_06E3(var_3, level._id_06B2._id_05E5, var_4, var_5, var_7, var_2);
  }

  return var_3;
}

_id_06E6() {
  var_0 = _id_06E9();
  var_1 = (0, 0, 0);
  var_2 = _id_06EA();
  var_3 = getdvarfloat("snd_debugRavenAudioRadius");
  var_4 = var_3;
  var_5 = 0;

  if(isDefined(self.angles) == 1)
    var_1 = self.angles;

  if(var_2 != "unknown") {
    var_6 = _getsndaliasvalue(var_2, "dist_min");

    if(isDefined(var_6) == 1 && var_6 > 0)
      var_4 = var_6;
    else
      var_5 = 1;
  }

  var_7 = 0;

  foreach(var_9 in level.players) {
    var_10 = var_9 getEye();
    var_7 = _id_02EF::_id_578C(var_10, var_0, var_4);

    if(var_7 == 1) {
      var_4 = var_3;
      break;
    }
  }

  var_12 = getdvarfloat("snd_debugRavenAudioColorScale");
  var_13 = _id_02EF::_id_A2BB((1, 1, 1), var_12);
  var_14 = 0.5;

  if(var_7 == 1 || var_5 == 1)
    _id_02EF::_id_28BB(var_0, var_1, var_4, var_13, var_14, 0, 1);
  else {}
}

_id_06E7(var_0, var_1, var_2) {
  var_3 = getdvarfloat("snd_debugRavenAudioCrosshairRadius");
  var_4 = getdvarfloat("cg_fov", 65);
  var_5 = var_0 getEye();
  var_6 = 9999999;
  var_7 = undefined;

  foreach(var_9 in var_1) {
    var_10 = var_9 _id_06E9();
    var_11 = var_0 worldpointinreticle_circle(var_10, var_4, var_3);

    if(var_11 == 1) {
      var_12 = var_0 worldpointtoscreenpos(var_10, var_4);
      var_13 = _distance2d(var_12, common_scripts\utility::_id_A2BE());

      if(var_13 < var_6) {
        var_6 = var_13;
        var_7 = var_9;
      }
    }
  }

  return var_7;
}

_id_06E5(var_0, var_1) {
  var_2 = _getdvarvector("snd_debugRavenAudioColor");
  var_3 = getdvarfloat("snd_debugRavenAudioColorScale");
  var_4 = _id_02EF::_id_A2BD(var_2, var_3 * 10.0);
  var_5 = getdvarfloat("cg_fov", 65);
  var_6 = _id_06E9();
  var_7 = _id_06EA();
  var_8 = "?";
  var_9 = "?";
  var_10 = var_0 getEye();
  var_11 = var_0 _meth_8566();
  var_12 = anglestoright(var_11);

  if(var_7 != "unknown") {
    var_13 = _id_02EF::_id_468E(var_7, "dist_min");
    var_14 = _id_02EF::_id_468D(var_7, "dist_max");

    if(isDefined(var_13) == 1 && var_13 > 0)
      var_8 = var_13;

    if(isDefined(var_14) == 1 && var_14 > 0)
      var_9 = var_14;
  }

  if(isDefined(var_7) == 1) {
    var_15 = getdvarfloat("snd_debugRavenAudioScale");
    var_16 = distance(var_6, var_10);
    var_17 = 1.0;

    if(_isnumber(var_8) == 1 && var_8 > 0 && _isnumber(var_9) == 1 && var_9 > 0)
      _id_02EF::startignoringspotlight(var_16, var_8, var_9, 1.0, 0.5);

    var_18 = var_16 * 0.002;
    var_19 = var_15 * var_18;
    _id_02EF::_id_8AA6(var_6 + (0, 0, -1.5 * var_19 * 12), var_7, var_4, var_17, var_19, 1, var_12);
    var_19 = var_15 * 0.666 * var_18;
    var_20 = "d: " + var_8 + " / " + var_16 + " / " + var_9;
    _id_02EF::_id_8AA6(var_6 + (0, 0, -3.5 * var_19 * 12), var_20, var_4, var_17, var_19, 1, var_12);
  }

  if(isDefined(var_9) == 1 && _isnumber(var_9) == 1 && var_9 > 0) {
    var_21 = 0.25;
    var_22 = var_4;
    var_23 = 1.0;
    var_24 = _id_02EF::_id_A2BB(var_22, var_21) + (1, 0, 0);
    var_25 = _id_02EF::_id_A2BB(var_22, var_21) + (0, 1, 0);
    var_26 = _id_02EF::_id_A2BB(var_22, var_21) + (0, 0, 1);
    var_27 = (0, var_9, 0);
    var_28 = (var_9, 0, 0);
    var_29 = (0, 0, var_9);
  }
}

_id_06E4(var_0) {
  if(var_0 <= 1) {
    return;
  }
  if(isDefined(level.players) == 0) {
    if(isDefined(level.createfx) == 0 || isDefined(level.player) == 0)
      return;
    else {
      level.players = [];
      level.players[level.players.size] = level.player;
    }
  }

  level._id_05B8 = [];

  foreach(var_2 in level.players) {
    var_3 = [];
    var_3 = _id_06E2(var_2, var_0);
    level._id_05B8 = common_scripts\utility::_id_0F73(level._id_05B8, var_3);
  }

  if(level.players.size > 1)
    level._id_05B8 = common_scripts\utility::_id_0F97(level._id_05B8);

  var_5 = getdvarint("snd_debugRavenAudioDrawLimit");
  var_6 = 0;

  if(level._id_05B8.size >= var_5) {
    var_7 = [];

    foreach(var_2 in level.players)
    var_7[var_7.size] = var_2 getEye();

    var_10 = common_scripts\utility::_id_A2B9(var_7);
    level._id_05B8 = _sortbydistance(level._id_05B8, var_10);

    foreach(var_12 in level._id_05B8) {
      if(isDefined(var_12._id_6C3F) == 1) {
        var_12.origin = undefined;
        var_12._id_6C3F = undefined;
      }
    }
  }

  foreach(var_15 in level._id_05B8) {
    if(var_5 > 0 && var_6 >= var_5) {
      _id_06ED(520, 2, "** " + var_5 + " LIMITED **", (1, 0, 0));
      break;
    }

    var_15 _id_06E6();
    var_6 = var_6 + 1;
  }

  var_17 = [];

  foreach(var_2 in level.players) {
    var_19 = _id_06E7(var_2, level._id_05B8, var_0);

    if(isDefined(var_19) == 1) {
      var_19 _id_06E5(var_2, var_0);
      var_17 = common_scripts\utility::_id_0F6F(var_17, var_19);
      var_6 = var_6 + 1;
    }
  }
}

_id_06EB(var_0) {
  var_1 = getDvar("snd_debugRavenAudioFilter");
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = "";
  var_8 = "";
  var_9 = 0;

  if(isDefined(level._id_05B0) == 1) {
    var_2 = level._id_05B2;
    var_3 = level._id_05B1;
  }

  if(isDefined(level._id_071D) == 1 && isDefined(level._id_071D._id_0623) == 1)
    var_4 = level._id_071D._id_0623.size;

  if(isDefined(level._id_06B2) == 1 && isDefined(level._id_06B2._id_061A) == 1)
    var_4 = var_4 + level._id_06B2._id_061A.size;

  if(isDefined(level._id_06B2) == 1 && isDefined(level._id_06B2._id_0720) == 1)
    var_5 = level._id_06B2._id_0720.size;

  if(isDefined(level._id_06B2) == 1 && isDefined(level._id_06B2._id_05E5) == 1)
    var_6 = level._id_06B2._id_05E5.size;

  if(isDefined(level._id_05B8) == 1 && level._id_05B8.size > 0 && var_0 >= 3)
    var_7 = var_7 + (" (" + level._id_05B8.size + " visible)");

  if(isDefined(var_1) == 1 && var_1 != "")
    var_8 = var_8 + ("\"" + var_1 + "\"");

  if(isDefined(level._id_05C5) == 1)
    var_9 = level._id_05C5.size;

  _id_06ED(0, 0, "Audio Entity count: " + var_4);
  _id_06ED(0, 1, "Network Sound Entity count: " + var_5);
  _id_06ED(0, 2, "Client Sound count: " + var_6);
  _id_06ED(0, 3, "Audio Parameter Entity count: " + var_9);

  if(var_0 >= 3) {
    var_10 = 4;
    _id_06ED(0, var_10, " CreateFX sfx (loop) count: " + var_2);
    var_10++;
    _id_06ED(0, var_10, " CreateFX sfx_interval count: " + var_3);
    var_10++;
    var_11 = "";

    if(isDefined(level._id_05B8) == 1 && level._id_05B8.size > 0)
      var_11 = var_11 + level._id_05B8.size;
    else
      var_11 = var_11 + "0";

    if(isDefined(var_1) == 1 && var_1 != "")
      var_11 = var_11 + (" (" + var_8 + ")");

    _id_06ED(0, var_10, " Visible Sound count: " + var_11);
    var_10++;
  }
}

_id_06E1(var_0) {
  var_1 = 0.75;
  var_2 = getdvarint("snd_debugRavenAudioCrosshair");
  var_3 = getdvarfloat("snd_debugRavenAudioCrosshairAlpha");
  var_4 = getdvarfloat("snd_debugRavenAudioCrosshairRadius", "64");

  if(var_2 != 0 && isDefined(level._id_05B4) == 0) {
    var_5 = newhudelem();
    var_5.x = 320;
    var_5.y = 240;
    var_5.alignx = "center";
    var_5.aligny = "middle";
    var_5._id_00C6 = "fullscreen";
    var_5._id_01CA = "fullscreen";
    var_5.foreground = 1;
    var_5.sort = 1;
    level._id_05B4 = var_5;
  }

  if(var_2 != 0 && isDefined(level._id_05B4) == 1) {
    level._id_05B4 setshader("widg_circle", int(var_4 * 2.0 * var_1), int(var_4 * 2.0));
    level._id_05B4.alpha = var_3;
  }

  if(var_2 == 0 && isDefined(level._id_05B4) == 1) {
    level._id_05B4 destroy();
    level._id_05B4 = undefined;
  }
}

_id_06E0(var_0) {
  if(isDefined(var_0) == 1 && var_0 < 1) {
    return;
  }
  if(getDvar("1459") != "on") {
    if(isDefined(level._id_05B0) == 1 && level._id_05B0.size > 0)
      return;
  } else {
    while(isDefined(level.createfx) == 0)
      waitframe();
  }

  while(isDefined(level.createfxent) == 0)
    waitframe();

  level._id_05B0 = [];
  level._id_05B2 = 0;
  level._id_05B1 = 0;

  for(var_1 = 0; var_1 < level.createfxent.size; var_1++) {
    var_2 = level.createfxent[var_1];

    if(isDefined(var_2.v["type"]) == 0) {
      continue;
    }
    if(var_2.v["type"] == "soundfx") {
      level._id_05B2++;
      level._id_05B0[level._id_05B0.size] = var_2;
    }

    if(var_2.v["type"] == "soundfx_interval") {
      level._id_05B1++;
      level._id_05B0[level._id_05B0.size] = var_2;
    }
  }
}

_id_06EE() {}

_id_06EF() {
  level endon("snd_debug_end");

  for(;;) {
    var_0 = getdvarint("snd_debugRavenAudio");

    if(var_0 != 0) {
      _id_06E0(var_0);
      _id_06E4(var_0);
      _id_06E1(var_0);
      _id_06EB(var_0);
    }

    waitframe();
  }
}