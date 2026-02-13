/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1964.gsc
*************************************************/

_id_189E() {
  while(!istrue(game["gamestarted"])) {
    waitframe();
  }

  var_0 = getEntArray("animObj", "targetname");
  var_1 = _id_6211(var_0);
  _id_D8BF(var_0);
  _id_D8AF(var_0);

  foreach(var_3 in var_0) {
    if(isDefined(var_3._id_CC9F)) {
      switch (var_3._id_CC9F) {
        case "rotation_pingpong":
        case "rotation_continuous":
          var_3 thread _id_18EC(var_3._id_CC9F);
          break;
        case "translation_once":
        case "translation_pingpong":
          var_3 thread _id_18EF(var_3._id_CC9F);
          break;
      }
    }
  }
}

_id_D8BF(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_039B) && scripts\engine\utility::string_starts_with(var_2._id_039B, "vfx_")) {
      var_3 = var_2 scripts\engine\utility::spawn_tag_origin();
      var_3 show();
      var_3 linkto(var_2);
      waitframe();

      if(!_id_8ADC("setupVFXObjs(): obj", var_2)) {
        continue;
      }
      if(!_id_8ADC("setupVFXObjs(): model", var_3)) {
        continue;
      }
      thread _id_46CA(scripts\engine\utility::getfx(var_2._id_039B), var_3, "tag_origin");
    }
  }
}

_id_46CA(var_0, var_1, var_2) {
  wait 5;

  if(!_id_8ADC("delayFXCall()", var_1)) {
    return;
  }
  playFXOnTag(var_0, var_1, var_2);
}

_id_D8AF(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_039B) && scripts\engine\utility::string_starts_with(var_2._id_039B, "sfx_")) {
      var_2 setModel("tag_origin");
      var_2 thread scripts\engine\utility::_id_B278("mp_quarry_lg_crane_loop");
    }
  }
}

_id_44A3() {
  for(;;) {
    scripts\mp\utility\debug::_id_4F48(self.origin, 32, 0.1, (0, 0, 255));
    wait 0.1;
  }
}

_id_6211(var_0) {
  var_1 = [];
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(var_4._id_039B) && issubstr(var_4._id_039B, "group")) {
      var_1 = scripts\engine\utility::array_add(var_1, var_4);
    }
  }

  foreach(var_7 in var_1) {
    if(!isDefined(var_2[var_7._id_039B])) {
      var_2[var_7._id_039B] = [var_7];
      continue;
    }

    var_2[var_7._id_039B] = ::scripts\engine\utility::array_add(var_2[var_7._id_039B], var_7);
  }

  foreach(var_10 in var_2) {
    var_11 = _id_18E9(var_10);
    _id_18EA(var_11, var_10);
  }

  return var_2;
}

_id_18E9(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_0398)) {
      return var_2;
    }
  }
}

_id_18EA(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(var_3 == var_0) {
        continue;
      }
      var_3 linkto(var_0);
    }
  }
}

_id_18EF(var_0) {
  if(issubstr(var_0, "pingpong")) {
    thread _id_18F1();
  }

  if(issubstr(var_0, "once")) {
    thread _id_18F0();
  }
}

_id_18F1() {
  level endon("game_ended");
  var_0 = (0, 90, 0);
  var_1 = 5;
  var_2 = 0.5;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(self._id_CE90)) {
    var_0 = self._id_CE90;
  }

  if(isDefined(self._id_CE91)) {
    var_1 = self._id_CE91;
  }

  if(isDefined(self._id_CCAF)) {
    if(issubstr(self._id_CCAF, "start")) {
      var_3 = "mp_quarry_lg_crane_start";
    }

    if(issubstr(self._id_CCAF, "stop")) {
      var_4 = "mp_quarry_lg_crane_stop";
    }

    if(issubstr(self._id_CCAF, "loop")) {
      var_5 = "mp_quarry_lg_crane_loop";
    }
  }

  for(;;) {
    var_6 = self.origin;
    self moveto(self.origin + var_0, var_1[0], var_1[1], var_1[2]);

    if(isDefined(var_4)) {
      thread _id_18EB(var_1[0], var_4);
    }

    wait(var_1[0] + var_2);

    if(!_id_8ADC("animSuite_Translation_PingPong()", self)) {
      return;
    }
    if(isDefined(var_3)) {
      playsoundatpos(self.origin, var_3);
    }

    self moveto(var_6, var_1[0], var_1[1], var_1[2]);

    if(isDefined(var_4)) {
      thread _id_18EB(var_1[0], var_4);
    }

    wait(var_1[0] + var_2);

    if(!_id_8ADC("animSuite_Translation_PingPong()", self)) {
      return;
    }
    if(isDefined(var_3)) {
      playsoundatpos(self.origin, var_3);
    }
  }
}

_id_18EB(var_0, var_1) {
  wait(var_0);

  if(!_id_8ADC("animSuite_playThreadedSound()", self)) {
    return;
  }
  playsoundatpos(self.origin, var_1);
}

_id_18F0() {
  level endon("game_ended");
  var_0 = (0, 90, 0);
  var_1 = 5;

  if(isDefined(self._id_CE90)) {
    var_0 = self._id_CE90;
  }

  if(isDefined(self._id_CE91)) {
    var_1 = length(self._id_CE91);
  }

  for(;;) {
    self _meth_82A1(var_0, var_1, 0, 0);
    wait(var_1);

    if(!_id_8ADC("animSuite_Translation_Once()", self)) {
      return;
    }
  }
}

_id_18EC(var_0) {
  if(issubstr(var_0, "pingpong")) {
    thread _id_18EE();
  }

  if(issubstr(var_0, "continuous")) {
    thread _id_18ED();
  }
}

_id_18EE() {
  level endon("game_ended");
  var_0 = (0, 90, 0);
  var_1 = (5, 0, 0);
  var_2 = 0;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(self._id_CE37)) {
    var_0 = self._id_CE37;
  }

  if(isDefined(self._id_CE3A)) {
    var_1 = self._id_CE3A;
  }

  for(;;) {
    self _meth_82A1(var_0, var_1[0], var_1[1], var_1[2]);

    if(isDefined(var_4)) {
      thread _id_18EB(var_1[0] * 0.9, var_4);
    }

    wait(var_1[0] + var_2);

    if(!_id_8ADC("animSuite_Rotation_PingPong()", self)) {
      return;
    }
    if(isDefined(var_3)) {
      playsoundatpos(self.origin, var_3);
    }

    self _meth_82A1(var_0 * -1, var_1[0], var_1[1], var_1[2]);

    if(isDefined(var_4)) {
      thread _id_18EB(var_1[0] * 0.9, var_4);
    }

    wait(var_1[0] + var_2);

    if(!_id_8ADC("animSuite_Rotation_PingPong()", self)) {
      return;
    }
    if(isDefined(var_3)) {
      playsoundatpos(self.origin, var_3);
    }
  }
}

_id_18ED() {
  level endon("game_ended");
  var_0 = (0, 90, 0);
  var_1 = (5, 0, 0);
  var_2 = 0.5;

  if(isDefined(self._id_CE37)) {
    var_0 = self._id_CE37;
  }

  if(isDefined(self._id_CE3A)) {
    var_1 = self._id_CE3A;
  }

  for(;;) {
    self _meth_82A1(var_0, var_1[0], var_1[1], var_1[2]);
    wait(var_1[0]);

    if(!_id_8ADC("animSuite_Rotation_Continuous()", self)) {
      return;
    }
  }
}

_id_8ADC(var_0, var_1) {
  if(!isDefined(var_1)) {
    return 0;
  }

  return 1;
}