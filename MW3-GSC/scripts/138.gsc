/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\138.gsc
**************************************/

_id_163F(var_0) {
  return var_0.classname == "light_spot" || var_0.classname == "light_omni" || var_0.classname == "light";
}

_id_1640(var_0, var_1, var_2, var_3) {
  self endon("kill_flicker");
  var_4 = var_0;
  var_5 = 0.0;
  maps\_utility::_id_1402("stop_flicker");

  for(;;) {
    if(maps\_utility::_id_1008("stop_flicker")) {
      wait 0.05;
      continue;
    }

    var_6 = var_4;
    var_4 = var_0 + (var_1 - var_0) * randomfloat(1.0);

    if(var_2 != var_3) {
      var_5 = var_5 + randomfloatrange(var_2, var_3);
    } else {
      var_5 = var_5 + var_2;

    }
    if(var_5 == 0) {
      var_5 = var_5 + 0.0000001;

    }
    for(var_7 = (var_6 - var_4) * (1 / var_5); var_5 > 0 && !maps\_utility::_id_1008("stop_flicker"); var_5 = var_5 - 0.05) {
      self setlightcolor(var_4 + var_7 * var_5);
      wait 0.05;
    }
  }
}

_id_1641(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");
  var_2 = undefined;
  var_3 = 100000000.0;

  foreach(var_5 in var_1) {
    var_6 = distance(self.origin, var_5.origin);

    if(var_6 < var_3) {
      var_2 = var_5;
      var_3 = var_6;
    }
  }

  if(isDefined(var_2)) {
    var_2 waittill("damage", var_8, var_9, var_10, var_11, var_12, var_13, var_14);
    self notify("kill_flicker");
    wait 0.05;
    self setlightcolor((0, 0, 0));
  }
}

_id_1642() {
  if(getdvar("r_reflectionProbeGenerate") == "1") {
    self setlightintensity(0);
    return;
  }

  var_0 = self getlightintensity();
  var_1 = 0.05;
  var_2 = var_0;
  var_3 = 0.3;
  var_4 = 0.6;
  var_5 = (var_0 - var_1) / (var_3 / 0.05);
  var_6 = (var_0 - var_1) / (var_4 / 0.05);

  for(;;) {
    var_7 = 0;

    while(var_7 < var_4) {
      var_2 = var_2 - var_6;
      var_2 = clamp(var_2, 0, 100);
      self setlightintensity(var_2);
      var_7 = var_7 + 0.05;
      wait 0.05;
    }

    wait 1;
    var_7 = 0;

    while(var_7 < var_3) {
      var_2 = var_2 + var_5;
      var_2 = clamp(var_2, 0, 100);
      self setlightintensity(var_2);
      var_7 = var_7 + 0.05;
      wait 0.05;
    }

    wait 0.5;
  }
}

_id_1643() {
  if(getdvar("r_reflectionProbeGenerate") == "1") {
    self setlightintensity(0);
    return;
  }

  var_0 = self getlightintensity();
  var_1 = 0.05;
  var_2 = 0;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = 0;
  var_6 = [];

  if(isDefined(self.script_noteworthy)) {
    var_7 = getEntArray(self.script_noteworthy, "targetname");

    for(var_8 = 0; var_8 < var_7.size; var_8++) {
      if(_id_163F(var_7[var_8])) {
        var_5 = 1;
        var_6[var_6.size] = var_7[var_8];
      }

      if(var_7[var_8].classname == "script_model") {
        var_3 = var_7[var_8];
        var_4 = getent(var_3.target, "targetname");
        var_2 = 1;
      }
    }
  }

  for(;;) {
    self setlightintensity(var_1);

    if(var_2) {
      var_3 hide();
      var_4 show();
    }

    wait 0.8;
    self setlightintensity(var_0);

    if(var_2) {
      var_3 show();
      var_4 hide();
    }

    wait 0.1;
    self setlightintensity(var_1);

    if(var_2) {
      var_3 hide();
      var_4 show();
    }

    wait 0.12;
    self setlightintensity(var_0);

    if(var_2) {
      var_3 show();
      var_4 hide();
    }

    wait 0.1;
  }
}

_id_1644(var_0) {
  var_1 = getEntArray("light_flicker_model", "targetname");
  var_2 = [];
  var_3 = maps\_utility::_id_0AE9(var_0, var_1);

  if(isDefined(var_3)) {
    var_2[0] = var_3;

  }
  return var_2;
}

_id_1645() {
  if(getdvar("r_reflectionProbeGenerate") == "1") {
    self setlightintensity(0);
    return;
  }

  self endon("stop_dynamic_light_behavior");
  self endon("death");
  self._id_1646 = 0;
  self._id_1647 = undefined;
  self._id_1648 = undefined;
  self._id_1649 = 0;
  self._id_164A = [];
  self._id_164B = undefined;
  self._id_164C = [];

  if(isDefined(self.script_linkto)) {
    self._id_164B = common_scripts\utility::get_linked_ents();

    foreach(var_1 in self._id_164B) {
      if(isDefined(var_1.script_noteworthy) && var_1.script_noteworthy == "on") {
        if(!isDefined(self._id_1647)) {
          self._id_1647[0] = var_1;
        } else {
          self._id_1647[self._id_1647.size] = var_1;

        }
        continue;
      }

      if(isDefined(var_1.script_noteworthy) && var_1.script_noteworthy == "off") {
        if(!isDefined(self._id_1648)) {
          self._id_1648[0] = var_1;
        } else {
          self._id_1648[self._id_1648.size] = var_1;

        }
        self._id_164D = var_1;
        continue;
      }

      if(_id_163F(var_1)) {
        self._id_1649 = 1;
        self._id_164A[self._id_164A.size] = var_1;
      }
    }

    self._id_1646 = 1;
  }

  if(isDefined(self.script_noteworthy)) {
    self._id_164C = getEntArray(self.script_noteworthy, "targetname");

  }
  if(!self._id_164C.size && !isDefined(self._id_164B)) {
    self._id_164C = _id_1644(self.origin);

  }
  for(var_3 = 0; var_3 < self._id_164C.size; var_3++) {
    if(_id_163F(self._id_164C[var_3])) {
      self._id_1649 = 1;
      self._id_164A[self._id_164A.size] = self._id_164C[var_3];
    }

    if(self._id_164C[var_3].classname == "script_model") {
      var_4 = self._id_164C[var_3];

      if(!isDefined(self._id_1647)) {
        self._id_1647[0] = var_4;
      } else {
        self._id_1647[self._id_1647.size] = var_4;

      }
      if(!isDefined(self._id_1648)) {
        self._id_1648[0] = getent(var_4.target, "targetname");
      } else {
        self._id_1648[self._id_1648.size] = getent(var_4.target, "targetname");

      }
      self._id_1646 = 1;
    }
  }

  if(isDefined(self._id_1647)) {
    foreach(var_4 in self._id_1647) {
      if(isDefined(var_4) && isDefined(var_4.script_fxid)) {
        var_4._id_164E = common_scripts\utility::createoneshoteffect(var_4.script_fxid);
        var_6 = (0, 0, 0);
        var_7 = (0, 0, 0);

        if(isDefined(var_4._id_164F)) {
          var_8 = strtok(var_4._id_164F, ", ");

          if(var_8.size < 3) {} else if(var_8.size == 6) {
            var_9 = float(var_8[0]);
            var_10 = float(var_8[1]);
            var_11 = float(var_8[2]);
            var_6 = (var_9, var_10, var_11);
            var_9 = float(var_8[3]);
            var_10 = float(var_8[4]);
            var_11 = float(var_8[5]);
            var_7 = (var_9, var_10, var_11);
          } else {
            var_9 = float(var_8[0]);
            var_10 = float(var_8[1]);
            var_11 = float(var_8[2]);
            var_6 = (var_9, var_10, var_11);
          }
        }

        var_4._id_164E.v["origin"] = var_4.origin + var_6;
        var_4._id_164E.v["angles"] = var_4.angles + var_7;
      }
    }
  }

  thread _id_1650();
  thread _id_1656();
}

_id_1650() {
  maps\_utility::_id_1402("flicker_on");

  if(isDefined(self._id_1651) && self._id_1651 != "nil") {
    for(;;) {
      level waittill(self._id_1651);
      maps\_utility::_id_13DC("flicker_on");

      if(isDefined(self._id_1652) && self._id_1652 != "nil") {
        level waittill(self._id_1652);
        maps\_utility::_id_13DE("flicker_on");
      }
    }
  } else {
    maps\_utility::_id_13DC("flicker_on");
  }
}

_id_1653() {
  var_0 = self getlightintensity();

  if(!maps\_utility::_id_1008("flicker_on")) {
    if(self._id_1646) {
      if(isDefined(self._id_1647)) {
        foreach(var_2 in self._id_1647) {
          var_2 hide();

          if(isDefined(var_2._id_164E)) {
            var_2._id_164E common_scripts\utility::pauseeffect();
          }
        }
      }

      if(isDefined(self._id_1648)) {
        foreach(var_5 in self._id_1648) {}
        var_5 show();
      }
    }

    self setlightintensity(0);

    if(self._id_1649) {
      for(var_7 = 0; var_7 < self._id_164A.size; var_7++) {
        self._id_164A[var_7] setlightintensity(0);
      }
    }

    maps\_utility::_id_1654("flicker_on");
    self setlightintensity(var_0);

    if(self._id_1649) {
      for(var_7 = 0; var_7 < self._id_164A.size; var_7++) {
        self._id_164A[var_7] setlightintensity(var_0);
      }
    }

    if(self._id_1646) {
      if(isDefined(self._id_1647)) {
        foreach(var_2 in self._id_1647) {
          var_2 show();

          if(isDefined(var_2._id_164E)) {
            var_2._id_164E maps\_utility::_id_1655();
          }
        }
      }

      if(isDefined(self._id_1648)) {
        foreach(var_5 in self._id_1648) {}
        var_5 hide();
      }
    }
  }
}

_id_1656() {
  self endon("stop_dynamic_light_behavior");
  self endon("death");
  var_0 = 0.2;
  var_1 = 1.5;
  var_2 = self getlightintensity();
  var_3 = 0;
  var_4 = var_2;
  var_5 = 0;

  while(isDefined(self)) {
    _id_1653();

    for(var_5 = randomintrange(1, 10); var_5; var_5--) {
      _id_1653();
      wait(randomfloatrange(0.05, 0.1));

      if(var_4 > 0.2) {
        var_4 = randomfloatrange(0, 0.3);

        if(self._id_1646) {
          foreach(var_7 in self._id_1647) {
            var_7 hide();

            if(isDefined(var_7._id_164E)) {
              var_7._id_164E common_scripts\utility::pauseeffect();
            }
          }
        }

        if(isDefined(self._id_1648)) {
          foreach(var_10 in self._id_1648) {}
          var_10 show();
        }
      } else {
        var_4 = var_2;

        if(self._id_1646) {
          if(isDefined(self._id_1647)) {
            foreach(var_7 in self._id_1647) {
              var_7 show();

              if(isDefined(var_7._id_164E)) {
                var_7._id_164E maps\_utility::_id_1655();
              }
            }
          }

          if(isDefined(self._id_1648)) {
            foreach(var_10 in self._id_1648) {
              var_10 hide();
              maps\_audio::aud_send_msg("light_flicker_on", var_10);
            }
          }
        }
      }

      self setlightintensity(var_4);

      if(self._id_1649) {
        for(var_16 = 0; var_16 < self._id_164A.size; var_16++) {
          self._id_164A[var_16] setlightintensity(var_4);
        }
      }
    }

    _id_1653();
    self setlightintensity(var_2);

    if(self._id_1649) {
      for(var_16 = 0; var_16 < self._id_164A.size; var_16++) {
        self._id_164A[var_16] setlightintensity(var_2);
      }
    }

    if(self._id_1646) {
      if(isDefined(self._id_1647)) {
        foreach(var_7 in self._id_1647) {
          var_7 show();

          if(isDefined(var_7._id_164E)) {
            var_7._id_164E maps\_utility::_id_1655();
          }
        }
      }

      if(isDefined(self._id_1648)) {
        foreach(var_10 in self._id_1648) {}
        var_10 hide();
      }
    }

    wait(randomfloatrange(var_0, var_1));
  }
}

_id_1658() {
  for(;;) {
    level common_scripts\utility::waitframe();
  }
}

_id_1659(var_0, var_1) {
  var_2 = self getlightintensity();
  var_3 = 0;
  var_4 = var_2;
  var_5 = 0;

  for(;;) {
    for(var_5 = randomintrange(1, 10); var_5; var_5--) {
      wait(randomfloatrange(0.05, 0.1));

      if(var_4 > 0.2) {
        var_4 = randomfloatrange(0, 0.3);
      } else {
        var_4 = var_2;

      }
      self setlightintensity(var_4);
    }

    self setlightintensity(var_2);
    wait(randomfloatrange(var_0, var_1));
  }
}

_id_165A() {
  var_0 = self getlightintensity();
  var_1 = var_0;

  for(;;) {
    var_2 = randomfloatrange(var_0 * 0.7, var_0 * 1.2);
    var_3 = randomfloatrange(0.3, 0.6);
    var_3 = var_3 * 20;

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = var_2 * (var_4 / var_3) + var_1 * ((var_3 - var_4) / var_3);
      self setlightintensity(var_5);
      wait 0.05;
    }

    var_1 = var_2;
  }
}

_id_165B(var_0, var_1, var_2, var_3) {
  var_4 = 360 / var_2;
  var_5 = 0;

  for(;;) {
    var_6 = sin(var_5 * var_4) * 0.5 + 0.5;
    self setlightintensity(var_0 + (var_1 - var_0) * var_6);
    wait 0.05;
    var_5 = var_5 + 0.05;

    if(var_5 > var_2) {
      var_5 = var_5 - var_2;

    }
    if(isDefined(var_3)) {
      if(common_scripts\utility::flag(var_3)) {
        return;
      }
    }
  }
}

_id_165C(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 0;

  }
  if(!isDefined(var_3)) {
    var_3 = 0;

  }
  thread _id_165D(var_0, var_1, var_2, var_3);
}

_id_165D(var_0, var_1, var_2, var_3) {
  var_4 = self getlightcolor();
  var_5 = 1 / (var_1 * 2 - (var_2 + var_3));
  var_6 = 0;

  if(var_6 < var_2) {
    for(var_7 = var_5 / var_2; var_6 < var_2; var_6 = var_6 + 0.05) {
      var_8 = var_7 * var_6 * var_6;
      self setlightcolor(vectorlerp(var_4, var_0, var_8));
      wait 0.05;
    }
  }

  while(var_6 < var_1 - var_3) {
    var_8 = var_5 * (2 * var_6 - var_2);
    self setlightcolor(vectorlerp(var_4, var_0, var_8));
    wait 0.05;
    var_6 = var_6 + 0.05;
  }

  var_6 = var_1 - var_6;

  if(var_6 > 0) {
    for(var_7 = var_5 / var_3; var_6 > 0; var_6 = var_6 - 0.05) {
      var_8 = 1 - var_7 * var_6 * var_6;
      self setlightcolor(vectorlerp(var_4, var_0, var_8));
      wait 0.05;
    }
  }

  self setlightcolor(var_0);
}

_id_165E() {
  thread _id_165F();
  thread _id_1660();
}

_id_165F() {
  self endon("light_off");
  var_0 = self getlightintensity();
  var_1 = var_0;

  for(;;) {
    var_2 = randomfloatrange(var_0 * 0.7, var_0 * 1.2);
    var_3 = randomfloatrange(0.3, 1.2);
    var_3 = var_3 * 20;

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = var_2 * (var_4 / var_3) + var_1 * ((var_3 - var_4) / var_3);
      self setlightintensity(var_5);
      wait 0.05;
    }

    var_1 = var_2;
  }
}

_id_1660() {
  self endon("light_off");
  var_0 = 0.5;
  var_1 = 0.5;
  var_2 = [];
  var_3 = [];

  for(var_4 = 0; var_4 < 3; var_4++) {
    var_2[var_4] = 0;
    var_3[var_4] = 0;
  }

  for(;;) {
    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      var_3[var_4] = var_2[var_4];
      var_2[var_4] = randomfloat(var_0) + var_1;
    }

    var_5 = randomfloatrange(0.3, 1.2);
    var_5 = var_5 * 20;

    for(var_4 = 0; var_4 < var_5; var_4++) {
      var_6 = [];

      for(var_7 = 0; var_7 < var_2.size; var_7++) {
        var_6[var_7] = var_2[var_7] * (var_4 / var_5) + var_3[var_7] * ((var_5 - var_4) / var_5);

      }
      self setlightcolor((var_6[0], var_6[1], var_6[2]));
      wait 0.05;
    }
  }
}

_id_1661(var_0) {
  var_1 = 1;

  if(isDefined(var_0._id_1662)) {
    var_1 = var_0._id_1662;

  }
  for(;;) {
    var_0 waittill("trigger", var_2);
    var_0 _id_1663(var_1);
  }
}

_id_1663(var_0) {
  var_1 = getdvarint("sm_sunenable", 1);
  var_2 = getdvarfloat("sm_sunshadowscale", 1.0);
  var_3 = getdvarint("sm_spotlimit", 4);
  var_4 = getdvarfloat("sm_sunsamplesizenear", 0.25);
  var_5 = getdvarfloat("sm_qualityspotshadow", 1.0);

  if(isDefined(self._id_1664)) {
    var_1 = self._id_1664;

  }
  if(isDefined(self._id_1665)) {
    var_2 = self._id_1665;

  }
  if(isDefined(self._id_1666)) {
    var_3 = self._id_1666;

  }
  if(isDefined(self._id_1667)) {
    var_4 = self._id_1667;

  }
  var_4 = min(max(0.016, var_4), 32);

  if(isDefined(self._id_1668)) {
    var_5 = self._id_1668;

  }
  var_6 = getdvarint("sm_sunenable", 1);
  var_7 = getdvarfloat("sm_sunshadowscale", 1.0);
  var_8 = getdvarint("sm_spotlimit", 4);
  var_9 = getdvarint("sm_qualityspotshadow", 1.0);
  setsaveddvar("sm_sunenable", var_1);
  setsaveddvar("sm_sunshadowscale", var_2);
  setsaveddvar("sm_spotlimit", var_3);
  setsaveddvar("sm_qualityspotshadow", var_5);
  _id_1669(var_4, var_0);
}

_id_1669(var_0, var_1) {
  level notify("changing_sunsamplesizenear");
  level endon("changing_sunsamplesizenear");
  var_2 = getdvarfloat("sm_sunSampleSizeNear", 0.25);

  if(var_0 == var_2) {
    return;
  }
  var_3 = var_0 - var_2;
  var_4 = var_1 / 0.05;

  if(var_4 > 0) {
    var_5 = var_3 / var_4;
    var_6 = var_2;

    for(var_7 = 0; var_7 < var_4; var_7++) {
      var_6 = var_6 + var_5;
      setsaveddvar("sm_sunSampleSizeNear", var_6);
      wait 0.05;
    }
  }

  setsaveddvar("sm_sunSampleSizeNear", var_0);
}