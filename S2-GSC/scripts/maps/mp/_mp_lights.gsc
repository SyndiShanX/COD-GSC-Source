/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_mp_lights.gsc
******************************************/

init() {
  if(!isDefined(level._id_94E5))
    level._id_94E5 = getdvarint("1084", 1);

  if(!isDefined(level._id_94EF))
    level._id_94EF = getdvarfloat("3158", 1.0);

  if(!isDefined(level._id_911F))
    level._id_911F = getdvarint("sm_spotlimit", 4);

  if(!isDefined(level._id_94EE))
    level._id_94EE = getdvarfloat("5699", 0.25);

  if(!isDefined(level._id_781B))
    level._id_781B = getdvarfloat("sm_qualityspotshadow", 1.0);

  thread _id_63C5();

  if(!isDefined(level._id_0672)) {
    level._id_0672 = spawnStruct();
    _id_5D25();
    _id_5D11();
  }

  var_0 = getEntArray("trigger_multiple_light_sunshadow", "classname");

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    level thread _id_94E4(var_0[var_1]);
}

_id_8588(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0))
    level._id_94E5 = var_0;

  if(isDefined(var_1))
    level._id_94EF = var_1;

  if(isDefined(var_2))
    level._id_911F = var_2;

  if(isDefined(var_3))
    level._id_94EE = var_3;

  if(isDefined(var_4))
    level._id_781B = var_4;
}

_id_63C5() {
  if(isDefined(level.players)) {
    foreach(var_1 in level.players)
    var_1 _id_5330();
  }

  for(;;) {
    level waittill("connected", var_1);
    var_1 _id_5330();
    var_1 thread _id_6379();
  }
}

_id_5330() {
  self._id_94E5 = level._id_94E5;
  self._id_94EF = level._id_94EF;
  self._id_911F = level._id_911F;
  self._id_94EE = level._id_94EE;
  self._id_781B = level._id_781B;
  self setclientdvars("1084", self._id_94E5, "3158", self._id_94EF, "sm_spotlimit", self._id_911F, "sm_qualityspotshadow", self._id_781B, "5699", self._id_94EE);
}

_id_6379() {
  self waittill("spawned");
  _id_5330();
}

_id_94E4(var_0) {
  var_1 = 1;

  if(isDefined(var_0._id_817A))
    var_1 = var_0._id_817A;

  for(;;) {
    var_0 waittill("trigger", var_2);
    var_0 _id_8599(var_1, var_2);
  }
}

_id_8599(var_0, var_1) {
  var_2 = var_1._id_94E5;
  var_3 = var_1._id_94EF;
  var_4 = var_1._id_911F;
  var_5 = var_1._id_94EE;
  var_6 = var_1._id_781B;

  if(isDefined(self.setperk))
    var_2 = self.setperk;

  if(isDefined(self.clearperks))
    var_3 = self.clearperks;

  if(isDefined(self.setyawspeed))
    var_4 = self.setyawspeed;

  if(isDefined(self.hasperk))
    var_5 = self.hasperk;

  var_5 = _min(max(0.016, var_5), 32);

  if(isDefined(self.clonebrushmodeltoscriptmodel))
    var_6 = self.clonebrushmodeltoscriptmodel;

  var_1 setclientdvars("1084", var_2, "3158", var_3, "sm_spotlimit", var_4, "sm_qualityspotshadow", var_6);
  var_1._id_94E5 = var_2;
  var_1._id_94EF = var_3;
  var_1._id_911F = var_4;
  var_7 = var_1._id_94EE;
  var_1._id_94EE = var_5;
  var_1._id_781B = var_6;
  thread _id_5C9B(var_5, var_7, var_0, var_1);
}

_id_5C9B(var_0, var_1, var_2, var_3) {
  level notify("changing_sunsamplesizenear" + var_3.name);
  level endon("changing_sunsamplesizenear" + var_3.name);

  if(var_0 == var_1) {
    return;
  }
  var_4 = var_0 - var_1;
  var_5 = 0.1;
  var_6 = var_2 / var_5;

  if(var_6 > 0) {
    var_7 = var_4 / var_6;
    var_8 = var_1;

    for(var_9 = 0; var_9 < var_6; var_9++) {
      var_8 = var_8 + var_7;
      var_3 setclientdvar("5699", var_8);
      var_3._id_94EE = var_8;
      wait(var_5);
    }
  }

  var_3 setclientdvar("5699", var_0);
  var_3._id_94EE = var_0;
}

_id_5D25() {
  _id_279A("fire", (0.972549, 0.62451, 0.345098), (0.2, 0.146275, 0.0878432), 0.005, 0.2, 8);
  _id_279A("blue_fire", (0.445098, 0.62451, 0.972549), (0.05, 0.150451, 0.307843), 0.005, 0.2, 8);
  _id_279A("white_fire", (0.972549, 0.972549, 0.972549), (0.2, 0.2, 0.2), 0.005, 0.2, 8);
  _id_279A("pulse", (0, 0, 0), (255, 107, 107), 0.2, 1, 8);
  _id_279A("lightbulb", (0.972549, 0.62451, 0.345098), (0.2, 0.146275, 0.0878432), 0.005, 0.2, 6);
  _id_279A("fluorescent", (0.972549, 0.62451, 0.345098), (0.2, 0.146275, 0.0878432), 0.005, 0.2, 7);
  _id_279A("static_screen", (0.63, 0.72, 0.92), (0.4, 0.43, 0.48), 0.005, 0.2, 7);
}

_id_279A(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level._id_0672._id_3D62))
    level._id_0672._id_3D62 = [];

  var_6 = spawnStruct();
  var_6._id_24F2 = var_1;
  var_6._id_24F4 = var_2;
  var_6._id_61BE = var_3;
  var_6._id_607C = var_4;
  var_6.intensity = var_5;
  level._id_0672._id_3D62[var_0] = var_6;
}

_id_4198(var_0) {
  if(isDefined(level._id_0672._id_3D62) && isDefined(level._id_0672._id_3D62[var_0]))
    return level._id_0672._id_3D62[var_0];

  return undefined;
}

_id_711E(var_0, var_1, var_2) {
  var_3 = _getent(var_1, "targetname");

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = _id_4198(var_0);

  if(!isDefined(var_4)) {
    return;
  }
  if(isDefined(var_2)) {
    if(var_2 < 0)
      var_2 = 0;

    var_4.intensity = var_2;
  }

  var_3 setlightintensity(var_4.intensity);
  var_3._id_5749 = 1;
  var_3._id_574A = 0;
  var_3 thread _id_351B(var_4._id_24F2, var_4._id_24F4, var_4._id_61BE, var_4._id_607C);
  return var_3;
}

_id_93CB(var_0, var_1, var_2) {
  var_3 = _getent(var_1, "targetname");

  if(!isDefined(var_3)) {
    return;
  }
  if(!isDefined(var_3._id_5749)) {
    return;
  }
  if(isDefined(var_2)) {
    if(var_2 < 0)
      var_2 = 0;
  }

  var_3 setlightintensity(var_2);
  var_3 notify("kill_flicker");
  var_3._id_5749 = undefined;
}

_id_6F19(var_0, var_1) {
  var_2 = _getent(var_1, "targetname");

  if(!isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_2._id_5749)) {
    return;
  }
  var_2._id_574A = 1;
}

_id_A03E(var_0, var_1) {
  var_2 = _getent(var_1, "targetname");

  if(!isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_2._id_5749)) {
    return;
  }
  var_2._id_574A = 0;
}

_id_351B(var_0, var_1, var_2, var_3) {
  self endon("kill_flicker");
  var_4 = var_0;
  var_5 = 0.0;

  for(;;) {
    if(self._id_574A) {
      waitframe();
      continue;
    }

    var_6 = var_4;
    var_4 = var_0 + (var_1 - var_0) * _randomfloat(1.0);

    if(var_2 != var_3)
      var_5 = var_5 + _randomfloatrange(var_2, var_3);
    else
      var_5 = var_5 + var_2;

    if(var_5 == 0)
      var_5 = var_5 + 0.0000001;

    for(var_7 = (var_6 - var_4) * (1 / var_5); var_5 > 0 && !self._id_574A; var_5 = var_5 - 0.05) {
      self setlightcolor(var_4 + var_7 * var_5);
      waitframe();
    }
  }
}

_id_6284(var_0, var_1, var_2, var_3) {
  var_4 = getEntArray(var_0, "script_noteworthy");

  if(!isDefined(var_4)) {
    return;
  }
  self endon("death");
  var_5 = 0;
  var_6 = _randomfloatrange(0.1, 0.25);

  if(isDefined(var_2))
    exploder(var_2);

  while(var_5 < var_1) {
    if(isDefined(var_3))
      exploder(var_3);

    foreach(var_8 in var_4)
    var_8 show();

    wait(var_6);

    if(isDefined(var_3))
      _id_93C7(var_3);

    foreach(var_8 in var_4)
    var_8 hide();

    var_5++;
    wait(var_6);
  }
}

_id_5D11() {
  level._id_0672._id_611B = [];
}

_id_5D09() {}

_id_5D1F(var_0, var_1) {
  level._id_0672._id_611B[var_0] = var_1;
}

_id_5D10(var_0, var_1, var_2, var_3) {
  if(isDefined(level._id_0672._id_611B[var_0])) {
    if(isDefined(var_3))
      thread[[level._id_0672._id_611B[var_0]]](var_1, var_2, var_3);
    else if(isDefined(var_2))
      thread[[level._id_0672._id_611B[var_0]]](var_1, var_2);
    else if(isDefined(var_1))
      thread[[level._id_0672._id_611B[var_0]]](var_1);
    else
      thread[[level._id_0672._id_611B[var_0]]]();
  }
}

_id_93C7(var_0) {
  var_0 = var_0 + "";

  if(isDefined(level._id_2807)) {
    var_1 = level._id_2807[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1) {
        if(!isDefined(var_3.looper)) {
          continue;
        }
        var_3.looper delete();
      }

      return;
    }
  } else {
    for(var_5 = 0; var_5 < level.createfxent.size; var_5++) {
      var_3 = level.createfxent[var_5];

      if(!isDefined(var_3)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isDefined(var_3.v["exploder"])) {
        continue;
      }
      if(var_3.v["exploder"] + "" != var_0) {
        continue;
      }
      if(!isDefined(var_3.looper)) {
        continue;
      }
      var_3.looper delete();
    }
  }
}

exploder(var_0) {
  [[level._id_3945]](var_0);
}