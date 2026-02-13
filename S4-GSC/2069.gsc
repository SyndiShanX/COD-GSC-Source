/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2069.gsc
*************************************************/

init() {
  if(!isDefined(level._id_4AE7)) {
    level._id_4AE7 = getdvarint("#x341f25c791e305774", 0) == 1;
  }

  level._id_DEC6 = getdvarint("#x3ac6e820187d28f75", 1) == 1;
  level._id_5671 = getdvarint("#x35c5201b4d43386ca", 0) == 1;
  level._id_5678 = getdvarint("#x3e7c1e3c78ab47416", 1) == 1;
  level._id_FC4D = ::_id_253C;
  level._id_FC76 = ::_id_253C;

  if(!istrue(level._id_4AE7)) {
    _id_815B();
  }
}

_id_253C() {}

_id_815B() {
  level._id_E278 = [];
  level._id_41B5 = [];

  foreach(var_1 in level._id_EF89) {
    level._id_41B5[var_1] = "default";
  }

  var_3 = scripts\engine\utility::getstructarray("spawn_selection_camera", "targetname");

  if(var_3.size == 0) {
    _id_3FBB();
    return;
  }

  foreach(var_5 in var_3) {
    var_6 = var_5._id_CD99;

    if(!isDefined(var_6) || var_6 == "spawn_selection_camera") {
      var_6 = var_5._id_039B;
    }

    if(isDefined(scripts\cp_mp\utility\game_utility::_id_6B18())) {
      var_7 = var_5._id_039B;

      if(!isDefined(var_7) || isDefined(var_7) && var_7 != level._id_96CC) {
        continue;
      }
    }

    if(!isDefined(level._id_E278[var_6])) {
      level._id_E278[var_6] = [];
    }

    var_8 = var_5._id_CE7D;

    if(var_8 == "all" || scripts\mp\utility\game::getgametype() == "base") {
      foreach(var_1 in level._id_EF89) {
        level._id_E278[var_6][var_1] = var_5;
      }

      continue;
    }

    if(istrue(level._id_FED7)) {
      var_11 = _id_0819::_id_6D8C(var_8);
      var_5.origin = var_11.origin;
      var_5.angles = var_11.angles;
    }

    level._id_E278[var_6][var_8] = var_5;
  }

  _id_3FBB();
}

_id_3FBB() {
  if(isDefined(level._id_E278["default"])) {
    var_0 = 1;

    foreach(var_2 in level._id_EF89) {
      if(!isDefined(level._id_E278["default"][var_2])) {
        var_0 = 0;
        break;
      }
    }

    if(var_0) {
      return;
    }
  } else
    level._id_E278["default"] = [];

  var_4 = (0, 0, 0);

  if(isDefined(level._id_9AB1) && isDefined(level._id_9AB1[0]) && isDefined(level._id_9AB1[1])) {
    level._id_9AB2 = level._id_9AB1[1].origin - level._id_9AB1[0].origin;
    level._id_9AB0 = level._id_9AB1[0].origin + level._id_9AB2 * 0.5;
  }

  foreach(var_2 in level._id_EF89) {
    if(isDefined(level._id_E278["default"][var_2])) {
      level._id_E278["default"][var_2]._id_BF1C = 1;
      continue;
    }

    var_6 = spawnStruct();
    var_6.origin = (0, 0, 0);
    var_6.angles = (0, 0, 0);
    level._id_E278["default"][var_2] = var_6;
  }

  level._id_E27B = _id_6D88("allies");
  level._id_E27D = _id_6D88("axis");
  level._id_E27E = scripts\engine\utility::ter_op(distancesquared(level._id_E27D, level._id_9AB1[0].origin) < distancesquared(level._id_E27D, level._id_9AB1[1].origin), level._id_9AB1[0].angles, level._id_9AB1[1].angles);
  var_8 = level._id_E27D - level._id_E27B;
  var_9 = level._id_E27B + var_8 * 0.5;

  if(distancesquared(level._id_E27B, level._id_9AB1[0].origin) < distancesquared(level._id_E27B, level._id_9AB1[1].origin)) {
    var_10 = anglesToForward(level._id_9AB1[0].angles);
    var_11 = anglestoright(level._id_9AB1[0].angles);

    if(abs(vectordot(var_8, var_10)) > abs(vectordot(var_8, var_11))) {
      level._id_E27C = var_10;
    } else {
      level._id_E27C = var_11;
    }
  } else {
    var_10 = anglesToForward(level._id_9AB1[1].angles);
    var_11 = anglestoright(level._id_9AB1[1].angles);

    if(abs(vectordot(var_8, var_10)) > abs(vectordot(var_8, var_11))) {
      level._id_E27C = var_10;
    } else {
      level._id_E27C = var_11;
    }
  }

  if(distancesquared(level._id_E27D, level._id_9AB1[0].origin) < distancesquared(level._id_E27D, level._id_9AB1[1].origin)) {
    var_10 = anglesToForward(level._id_9AB1[0].angles);
    var_11 = anglestoright(level._id_9AB1[0].angles);

    if(abs(vectordot(var_8, var_10)) > abs(vectordot(var_8, var_11))) {
      level._id_E27F = var_10;
    } else {
      level._id_E27F = var_11;
    }
  } else {
    var_10 = anglesToForward(level._id_9AB1[1].angles);
    var_11 = anglestoright(level._id_9AB1[1].angles);

    if(abs(vectordot(var_8, var_10)) > abs(vectordot(var_8, var_11))) {
      level._id_E27F = var_10;
    } else {
      level._id_E27F = var_11;
    }
  }

  var_12 = distance(level._id_E27B, level._id_E27D);
  level._id_E275 = var_12;
  _id_AC6E();
}

_id_404E() {
  if(isDefined(level._id_FC4D)) {
    [[level._id_FC4D]]();
  }

  if(isDefined(level._id_FC76)) {
    self[[level._id_FC76]]();
  }

  var_0 = self.origin + (0, 0, 60);
  var_1 = self.angles;

  if(isDefined(self._id_E4AF)) {
    self._id_4411 = self._id_E4AF;
    self._id_4410 = self._id_E4AE;
  } else {
    self._id_4411 = var_0;
    self._id_4410 = var_1;
  }

  if(!isDefined(self._id_E277)) {
    var_2 = spawn("script_model", self._id_4411);
    var_2 _id_078E::_id_C2B6(1);
    var_2 setModel("tag_origin");
    var_2.angles = self._id_4410;
    self._id_E277 = var_2;
  } else {
    self._id_E277.origin = self._id_4411;
    self._id_E277.angles = self._id_4410;
  }
}

_id_E722(var_0, var_1, var_2) {
  self endon("disconnect");
  scripts\mp\utility\player::_id_BD21("spawnCamera::startSpawnCamera() START");
  scripts\mp\utility\player::_id_7908(1);
  _id_404E();

  if(!isDefined(self._id_E277)) {
    scripts\mp\utility\player::_id_BD21("spawnCamera::startSpawnCamera() UNDEFINED SPAWNCAMERAENT!!!");
    thread _id_B8DB(0.0, _id_6D42(), 0.5);
    return;
  }

  if(istrue(level._id_4AE7) && scripts\mp\utility\game::getgametype() != "arm" && scripts\mp\utility\game::getgametype() != "base") {
    return;
  }
  if(isai(self)) {
    return;
  }
  if(istrue(self._id_82F0)) {
    return;
  }
  if(istrue(level.gameended)) {
    return;
  }
  if(isDefined(self._id_D6DA) && !istrue(self._id_B072)) {
    return;
  }
  self._id_82F0 = 1;
  scripts\mp\utility\player::_id_D51E();
  waitframe();
  _id_081A::_id_D512();
  scripts\mp\utility\player::_id_FD26("spectator");
  self setclientomnvar("ui_in_spawn_camera", 1);

  if(!isDefined(var_0)) {
    var_0 = 0.0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0.25;
  }

  if(!isDefined(var_2)) {
    var_2 = 0.25;
  }

  thread _id_B8DB(var_0, var_1, var_2);
  scripts\engine\utility::_id_108AE(0.1, "force_spawn");
  thread _id_C481(self._id_E277);
  self cameralinkto(self._id_E277, "tag_origin", 1, 1);
  scripts\mp\utility\player::_id_BD21("spawnCamera::startSpawnCamera() CameraLinkTo()");
  self _meth_86A4();
  thread _id_DEC6();
}

_id_6D42() {
  if(isDefined(self._id_E282)) {
    return self._id_E282;
  } else if(istrue(self._id_E4AA) || !istrue(level._id_DEC6) && (istrue(self._id_DDC1) || !isDefined(self._id_8D6D) || self._id_8D6D < 2.0)) {
    return 2.5;
  } else {
    return 1.5;
  }
}

_id_6D41() {
  return 1.0;
}

_id_6D40() {
  var_0 = undefined;

  if(istrue(level._id_8885)) {
    self._id_5E98 = "default";
  }

  if(isDefined(self._id_5E98)) {
    if(isDefined(level._id_E278[self._id_5E98])) {
      var_0 = level._id_E278[self._id_5E98][self.team];
    } else if(scripts\mp\utility\game::getgametype() == "base" && getdvarint("#x332c8a7db9737b21b", 1) == 1) {
      var_1 = level._id_E371["gw_fob_03"][self.team]._id_1782.origin;
      var_2 = var_1 + (0, 0, 17000);
      var_3 = (90, 0, -90);
      var_0 = spawnStruct();
      var_0.origin = var_2;
      var_0.angles = var_3;
    } else if(issubstr(self._id_5E98, "squad")) {
      var_4 = self._id_5E98;

      if(var_4 == "squad_leader") {
        var_5 = level._id_E48E[self.team][self._id_E496]._id_E49C;
      } else {
        var_5 = int(_func_00D6(var_4, var_4.size - 1, var_4.size));
      }

      var_6 = undefined;

      if(isDefined(level._id_E48E[self.team]) && isDefined(level._id_E48E[self.team][self._id_E496]) && isDefined(level._id_E48E[self.team][self._id_E496].players[var_5])) {
        var_6 = level._id_E48E[self.team][self._id_E496].players[var_5];
      }

      if(isDefined(var_6)) {
        var_7 = level._id_E377[self.team];
        var_2 = var_6.origin + var_7 * -8500 + (0, 0, 7000);
        var_8 = vectornormalize(var_6.origin - var_2);
        var_3 = scripts\mp\utility\script::_id_FFE3(var_8, (0, 0, 1));

        if(istrue(level._id_FEF0)) {
          var_9 = _id_0819::_id_6E1F();
          var_2 = (var_2[0], var_2[1], var_9);
        }

        var_2 = var_2 + scripts\mp\gametypes\arm::_id_2EE0(self.team, var_6.origin);
        var_0 = spawnStruct();
        var_0.origin = var_2;
        var_0.angles = var_3;
      }
    } else if(issubstr(self._id_5E98, "vehicle")) {
      var_4 = self._id_5E98;
      var_10 = undefined;

      if(isDefined(level._id_E371[var_4]) && isDefined(level._id_E371[var_4][self.team])) {
        var_10 = level._id_E371[var_4][self.team]._id_50B4;
      }

      var_7 = level._id_E377[self.team];

      if(isDefined(var_10) && !istrue(var_10._id_87FB)) {
        var_2 = [];
        var_3 = [];

        if(istrue(level._id_FED7)) {
          var_11 = _id_0819::_id_6D8C(self.team);
          var_2 = var_11.origin;
          var_3 = var_11.angles;
        } else {
          var_2 = var_10.origin + var_7 * -8500 + (0, 0, 7000);

          if(istrue(level._id_FEF0)) {
            var_9 = _id_0819::_id_6E1F();
            var_2 = (var_2[0], var_2[1], var_9);
          }

          var_1 = level._id_E371[var_4][self.team]._id_1782.origin;
          var_12 = var_1 + var_7 * -8500 + (0, 0, 7000);
          var_13 = vectornormalize(var_1 - var_12);
          var_3 = scripts\mp\utility\script::_id_FFE3(var_13, (0, 0, 1));
          var_2 = var_2 + scripts\mp\gametypes\arm::_id_2EE0(self.team, var_1);
        }

        var_0 = spawnStruct();
        var_0.origin = var_2;
        var_0.angles = var_3;
      }
    }
  } else if(istrue(level._id_5678) && isDefined(level._id_904D) && isDefined(level._id_904D[self.team])) {
    var_14 = level._id_904D[self.team];
    var_15 = undefined;
    var_16 = undefined;

    foreach(var_20, var_18 in level._id_E278[level._id_41B5[self.team]]) {
      var_19 = distancesquared(var_18.origin, var_14);

      if(!isDefined(var_16) || var_19 < var_15) {
        var_16 = var_18;
        var_15 = var_19;
      }
    }

    var_0 = var_16;
  } else if(istrue(level._id_5671)) {
    var_21 = _id_2FDE();
    var_15 = undefined;
    var_16 = undefined;

    foreach(var_20, var_18 in level._id_E278[level._id_41B5[self.team]]) {
      var_23 = distancesquared(var_18.origin, var_21._id_EF62[self.team]);
      var_24 = distancesquared(var_18.origin, var_21.origin);

      if(!isDefined(var_16) || var_23 < var_24) {
        var_16 = var_18;
        var_15 = var_23;
      }
    }

    var_0 = var_16;
  } else {
    if(istrue(level._id_FE2D)) {
      while(!isDefined(level._id_41B5[self.team])) {
        waitframe();
      }
    }

    if(!_func_0121(level._id_41B5[self.team])) {
      var_0 = spawnStruct();
      var_0.origin = level._id_41B5[self.team].origin;
      var_0.angles = level._id_41B5[self.team].angles;
      var_0._id_FF0E = 1;
    } else
      var_0 = level._id_E278[level._id_41B5[self.team]][self.team];
  }

  if(!isDefined(var_0)) {
    if(isDefined(level._id_1F95) && isDefined(level._id_1F95[self.team])) {
      level._id_41B5[self.team] = level._id_1F95[self.team][0];
      var_0 = level._id_E278[level._id_41B5[self.team]][self.team];
    } else {
      level._id_41B5[self.team] = "default";
      var_0 = level._id_E278[level._id_41B5[self.team]][self.team];
    }
  }

  return var_0;
}

_id_A275() {
  self endon("disconnect");
  self notify("newMoveToSpawnCameraInitiated");
  self endon("newMoveToSpawnCameraInitiated");
  self endon("tac_ops_spawn_focus_changed");
  self endon("slamZoomInitiated");
  var_0 = _id_6D40();
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = self._id_E277.origin;
  var_4 = vectornormalize(var_3 - var_0.origin);
  var_5 = scripts\mp\utility\script::_id_FFE3(var_4, (0, 0, 1));
  self._id_E277.angles = var_5;
  var_6 = distance(var_3, var_1);
  var_7 = var_6 / 3520;
  var_7 = clamp(var_7, 1.5, 3.0);
  self._id_E281 = var_1;
  self._id_E280 = var_2;
  self._id_E282 = var_7;
  self._id_E276 = gettime() + var_7 * 1000;

  if(!istrue(var_0._id_FF0E)) {
    self._id_E277 moveto(var_1, var_7, var_7 * 0.3, var_7 * 0.4);
    self._id_E277 rotateto(var_2, var_7, var_7 * 0.3, var_7 * 0.4);
    wait 1.0;
  } else {
    self._id_E277.origin = var_1;
    self._id_E277.angles = var_2;
    self._id_4411 = var_1;
  }

  _id_19EE();
  thread _id_E705();

  if(isDefined(self) && isDefined(self._id_E277) && !istrue(self._id_82F2)) {
    var_8 = anglesToForward(var_2) * 300;
    var_8 = var_8 * (1, 1, 0);
    self earthquakeforplayer(0.03, 15.0, var_1, 1000);
  }

  self notify("spawn_camera_idle");
}

_id_A274(var_0) {
  self endon("disconnect");
  self notify("newMoveToSpawnCameraInitiated");
  self endon("newMoveToSpawnCameraInitiated");
  self endon("tac_ops_map_selection_valid");
  self endon("tac_ops_spawn_focus_changed");
  self endon("slamZoomInitiated");
  var_1 = _id_6D40();
  var_2 = var_1.origin;
  var_3 = var_1.angles;

  if(isDefined(self._id_E281) && isDefined(self._id_E280) && self._id_E281 == var_2 && self._id_E280 == var_3) {
    return;
  }
  var_4 = self._id_E277.origin;
  var_5 = vectornormalize(var_4 - var_1.origin);
  self._id_E281 = var_2;
  self._id_E280 = var_3;
  self._id_E277 moveto(var_2, 1.0, 0.25, 0.75);
  self._id_E277 rotateto(var_3, 1.0, 0.25, 0.75);
  wait 1.0;

  if(isDefined(self) && isDefined(self._id_E277) && !istrue(self._id_82F2)) {
    var_6 = anglesToForward(var_3) * 300;
    var_6 = var_6 * (1, 1, 0);
    self._id_E277 moveto(var_2 + var_6, 15.0, 1.0, 1.0);
    self earthquakeforplayer(0.03, 15.0, var_2, 1000);
  }

  self notify("spawn_camera_idle");
}

_id_DEC6() {
  self endon("disconnect");

  while(!istrue(self._id_31DA)) {
    waitframe();
  }

  var_0 = _id_6D40();
  self._id_E277 dontinterpolate();
  self._id_E277.origin = var_0.origin;
  self._id_E277.angles = var_0.angles;
  scripts\mp\utility\player::_id_BD21("spawnCamera::snapToSpawnCamera()");

  if(!istrue(level._id_A731)) {
    self visionsetnakedforplayer("", 0);
  }

  _id_19EE();
  thread _id_E705();

  if(isDefined(self) && isDefined(self._id_E277) && !istrue(self._id_82F2)) {
    var_1 = anglesToForward(self._id_E277.angles) * 300;
    var_1 = var_1 * (1, 1, 0);
    self._id_E277 moveto(self._id_E277.origin + var_1, 15.0, 1.0, 1.0);
    self earthquakeforplayer(0.03, 15.0, self._id_E277.origin, 1000);
  }

  self notify("spawn_camera_idle");
}

_id_534A() {
  if(isDefined(self._id_AC43)) {
    self _meth_8680("mp_spawn_camera");
    self._id_AC43 stoploopsound(self._id_AC44);
    self._id_AC43 delete();
    self._id_AC43 = undefined;
    self._id_AC44 = undefined;
  }

  if(!isDefined(self._id_E277)) {
    return;
  }
  if(istrue(level.gameended)) {
    return;
  }
  scripts\mp\utility\player::_id_7908(1);
  thread _id_EA1B();
  _id_CA72();
  self notify("end_spawn_cam_finished");
}

_id_4790() {
  self _meth_8060();

  if(!isDefined(self._id_E277)) {
    return;
  }
  self._id_E277 _id_078E::_id_4807();
  self._id_E277 delete();
  self._id_E277 = undefined;
  self._id_8AD5 = undefined;
  self._id_82F0 = 0;
  self notify("spawn_camera_deleted");
}

_id_C481(var_0) {
  self endon("spawn_camera_deleted");
  self waittill("disconnect");

  if(isDefined(var_0)) {
    var_0 _id_078E::_id_4807();
    var_0 delete();
  }
}

_id_EA1B() {
  self endon("disconnect");
  self waittill("spawncamera_start");
  self _meth_8282(self getEye());
  self waittill("spawn_camera_complete");
  self _meth_8283();
}

_id_CA72(var_0) {
  self endon("disconnect");
  scripts\mp\utility\player::_id_BD21("spawnCamera::runSlamZoomOnspawn() START");
  self waittill("spawncamera_start");
  scripts\mp\utility\player::_id_BD21("spawnCamera::runSlamZoomOnspawn() spawncamera_start PASSED");
  self notify("slamZoomInitiated");
  scripts\mp\utility\player::_freezecontrols(1);
  self playerhide();
  self _meth_8774(1);
  self._id_B928 = 1;
  scripts\common\utility::_id_158B(0);
  _id_081A::_id_D512();
  scripts\mp\utility\player::_id_FD26("spectator");
  self cameralinkto(self._id_E277, "tag_origin", 1);
  scripts\mp\utility\player::_id_BD21("spawnCamera::runSlamZoomOnspawn() CameraLinkTo()");
  _id_746F();
  _id_4790();

  if(self.team == "spectator") {
    scripts\mp\playerlogic::_id_C4A4();
    self setclientomnvar("ui_in_spawn_camera", 0);

    if(!istrue(level._id_A731)) {
      self visionsetnakedforplayer("", 0);
    }

    scripts\mp\utility\player::_freezecontrols(0);
    self _meth_8774(0);
    self._id_B928 = 0;
    thread _id_081A::_id_D6E2();
    return;
  }

  scripts\mp\utility\player::_id_FD26("playing");

  if(istrue(self._id_DB64)) {
    self._id_E293 = scripts\mp\playerlogic::_id_6D4A();
    self setorigin(self._id_E293._id_E332);
    self setplayerangles(self._id_E293._id_E267);
    _id_0817::_id_5AA0(self._id_E293._id_E342);
    self._id_DB64 = undefined;
    self._id_D066 = undefined;
  }

  self setclientomnvar("ui_in_spawn_camera", 0);

  if(!istrue(level._id_A731)) {
    self visionsetnakedforplayer("", 0);
  }

  scripts\mp\utility\player::_freezecontrols(0);
  self setplayerangles(self._id_E293._id_E267);
  self playershow();
  self _meth_8774(0);
  self._id_B928 = 0;
  scripts\common\utility::_id_158B(1);
  self notify("spawned_player");
  level notify("player_spawned", self, self._id_10A1E);
  thread scripts\mp\playerlogic::_id_D6D9();
  self._id_10A1E = undefined;
  self._id_46C3 = undefined;
  self._id_E293 = undefined;
  scripts\mp\utility\player::_id_BD21("spawnCamera::runSlamZoomOnspawn() COMPLETE");
}

_id_746E(var_0) {
  self endon("disconnect");
  var_1 = self getEye();
  var_2 = self.angles;
  var_3 = (var_1[0], var_1[1], self._id_E277.origin[2]);
  var_3 = var_3 + anglesToForward(var_2) * -480;
  self._id_E277 moveto(var_3, 0.75, 0.25, 0.25);
  var_4 = vectornormalize(var_1 - var_3);
  var_5 = scripts\mp\utility\script::_id_FFE3(var_4, (0, 0, 1));
  self._id_E277 rotateto(var_5, 0.75, 0.25, 0.25);
  wait 0.75;
  self visionsetnakedforplayer("tac_ops_slamzoom", 0.2);
  var_6 = var_1 + anglesToForward(var_2) * -60;
  self._id_E277 moveto(var_6, 0.5, 0.1, 0.4);
  self._id_E277 rotateto(var_2, 0.7, 0.45, 0.05);
  wait 0.5;
  thread _id_B8DB();
  self._id_E277 moveto(var_1, 0.6, 0.1, 0.1);
  wait 0.2;
  self visionsetnakedforplayer("", 0);
}

_id_746F(var_0, var_1) {
  self endon("disconnect");
  self endon("kill_handle_move_to_blended");
  scripts\mp\utility\player::_id_BD21("spawnCamera::handleMoveTo() START");

  if(!isDefined(var_0)) {
    var_0 = self._id_E293._id_E332 + (0, 0, 60);
  }

  if(!isDefined(var_1)) {
    var_1 = self._id_E293._id_E267;
  }

  if(isDefined(self._id_5EC4)) {
    var_0 = self._id_5EC4;
    var_1 = self._id_5EC3;
    self._id_5EC4 = undefined;
    self._id_5EC3 = undefined;
  }

  var_2 = _id_1785(self._id_E277.angles[1], var_1[1]) < 45;
  var_3 = distance2dsquared(self._id_E277.origin, var_0) > 1000000;
  thread _id_58B2(var_0);

  if(!var_2 || !var_3) {
    if(!istrue(level._id_A731)) {
      if(!scripts\cp_mp\utility\game_utility::isnightmap()) {
        _id_C533();
        self visionsetnakedforplayer("", 0);
      } else {}
    }

    wait 0.05;
    self._id_E277 moveto(var_0, 1.0, 0.1, 0.9);
    self._id_E277 rotateto(var_1, 1.0, 0.9, 0.1);
    scripts\mp\utility\player::_id_BD21("spawnCamera::handleMoveTo() FULL Blend Set");

    if(!istrue(level._id_A731)) {
      if(!scripts\cp_mp\utility\game_utility::isnightmap()) {
        self visionsetnakedforplayer("tac_ops_slamzoom", 0.8);
      }
    }

    wait 0.8;

    if(!istrue(level._id_A731)) {
      self visionsetnakedforplayer("", 0.2);
    }

    wait 0.2;
  } else {
    var_4 = vectornormalize(var_0 - self._id_E277.origin);
    var_5 = scripts\mp\utility\script::_id_FFE3(var_4, (0, 0, 1));
    self._id_E277 rotateto(var_5, 0.7, 0.2, 0.2);
    scripts\mp\utility\player::_id_BD21("spawnCamera::handleMoveTo() FIRST HALF Blend Set");

    if(!istrue(level._id_A731)) {
      if(!scripts\cp_mp\utility\game_utility::isnightmap()) {
        _id_C533();
        self visionsetnakedforplayer("", 0);
      } else {}
    }

    wait 0.05;
    self._id_E277 moveto(var_0, 1.0, 0.1, 0.9);

    if(!istrue(level._id_A731)) {
      if(!scripts\cp_mp\utility\game_utility::isnightmap()) {
        self visionsetnakedforplayer("tac_ops_slamzoom", 0.8);
      }
    }

    wait 0.5;
    self._id_E277 rotateto(var_1, 0.5, 0.2, 0.1);
    scripts\mp\utility\player::_id_BD21("spawnCamera::handleMoveTo() SECOND HALF Blend Set");
    wait 0.3;

    if(!istrue(level._id_A731)) {
      self visionsetnakedforplayer("", 0.2);
    }

    wait 0.2;
  }

  if(!istrue(level._id_A731)) {
    self visionsetnakedforplayer("", 0);
  }

  scripts\mp\utility\player::_id_BD21("spawnCamera::handleMoveTo() COMPLETE");
  self notify("spawn_camera_complete");
}

_id_58B2(var_0) {
  var_1 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip"];
  var_2 = physics_createcontents(var_1);
  var_3 = scripts\engine\trace::ray_trace(self._id_E277.origin, var_0, undefined, var_2);
  var_4 = scripts\engine\trace::ray_trace(var_0, self._id_E277.origin, undefined, var_2);
  var_5 = var_3["fraction"];
  var_6 = var_4["fraction"];
  var_7 = 0.11;

  if(istrue(self._id_E309)) {
    self _meth_867F("iw8_mp_vehicle_spawn", 0.1);
    thread _id_38F6();
  }

  if(istrue(self._id_E309) || scripts\cp_mp\utility\game_utility::isnightmap()) {
    self._id_E309 = undefined;

    if(isDefined(self._id_10351) && self._id_10351 == "light_tank") {
      var_5 = min(var_5, 0.95);
      var_6 = 0.0;
      var_7 = 0.75;
    } else {
      var_5 = min(var_5, 0.95);
      var_6 = 0.0;
    }
  }

  if(istrue(self._id_DB64)) {
    var_5 = min(var_5, 0.5);
    var_6 = 0.0;
    thread _id_107D8();
  }

  if(var_5 < 1.0) {
    if(var_5 - 0.22 > 0.0) {
      wait(var_5 - 0.22);
    }

    thread _id_B8DB(0.1, 1.0 - var_5 - var_6 + var_7, 0.25);
  }
}

_id_107D8() {
  self endon("disconnect");
  self waittill("fadeUp_start");
  self notify("kill_handle_move_to_blended");
}

_id_38F6() {
  wait 2.5;
  self _meth_8680("iw8_mp_vehicle_spawn", 1);
}

_id_B8DB(var_0, var_1, var_2) {
  self notify("play_slam_zoom");
  self endon("disconnect");
  self endon("play_slam_zoom");
  self._id_31DA = 0;

  if(!isDefined(var_2)) {
    var_2 = 0.5;
  }

  self notify("fadeDown_start");

  if(isDefined(var_0) && var_0 > 0) {
    var_3 = 0.0;
    var_4 = var_0 / level._id_5F3A;
    var_5 = 1.0 / var_4;
    var_6 = 0;

    while(var_6 < var_4) {
      var_6++;
      var_3 = var_3 + var_5;
      var_3 = clamp(var_3, 0.0, 1.0);
      self setclientomnvar("ui_world_fade", var_3);
      waitframe();
    }
  } else
    self setclientomnvar("ui_world_fade", 1.0);

  self notify("fadeDown_complete");
  self._id_31DA = 1;

  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);
  }

  self notify("fadeUp_start");

  if(isDefined(var_2) && var_2 > 0) {
    var_3 = 1.0;
    var_4 = var_2 / level._id_5F3A;
    var_5 = 1.0 / var_4;
    var_6 = 0;

    while(var_6 < var_4) {
      var_6++;
      var_3 = var_3 - var_5;
      var_3 = clamp(var_3, 0.0, 1.0);
      self setclientomnvar("ui_world_fade", var_3);
      waitframe();
    }
  } else
    self setclientomnvar("ui_world_fade", 0.0);

  self notify("fadeUp_complete");
}

_id_A227(var_0, var_1, var_2) {
  self moveto(var_1, 1.0, 0.5, 0.5);
  self rotateto(var_2, 1.0, 0.5, 0.5);
  var_0 thread _id_E705();
  wait 1.1;
}

_id_19EE() {
  if(istrue(self._id_E27A)) {
    self._id_E27A = 0;
    return;
  }

  if(istrue(self._id_E279)) {
    return;
  }
  if(!istrue(level._id_A731)) {
    return;
  }
}

_id_C533() {}

_id_E705() {
  self endon("disconnect");
  self endon("game_ended");

  if(isDefined(self._id_AC43)) {
    return;
  }
  if(istrue(level._id_A737)) {
    return;
  }
  self._id_AC43 = spawn("script_origin", (0, 0, 0));
  self._id_AC43 _meth_83CA(self);
  self _meth_867F("mp_spawn_camera");
  var_0 = scripts\mp\utility\teams::_id_6DDF(self.team);
  var_1 = "dx_mpo_" + var_0 + "op_drone_deathchatter";

  if(!_func_0205(var_1)) {
    var_1 = "dx_mpo_usop_drone_deathchatter";
  }

  self._id_AC44 = var_1;
  thread _id_533B();
}

_id_533B() {
  self endon("spawned_player");
  var_0 = self._id_AC43;
  var_1 = self._id_AC44;
  self waittill("disconnect");

  if(isDefined(var_0)) {
    var_0 stoploopsound(var_1);
    var_0 delete();
  }
}

_id_D572(var_0, var_1) {
  level._id_E278["gamemode"][var_0] = var_1;
  _id_D6D5(var_0, "gamemode");
}

_id_D6D5(var_0, var_1) {
  level._id_41B5[var_0] = var_1;
}

_id_AC6E() {
  if(!istrue(level._id_E278["default"]["allies"]._id_BF1C)) {
    var_0 = level._id_9AB0 + level._id_E27C * level._id_E275 * -0.85 + (0, 0, 1) * level._id_E275 * 0.45;
    var_1 = vectornormalize(level._id_9AB0 - var_0);
    var_2 = scripts\mp\utility\script::_id_FFE3(var_1, (0, 0, 1));
    level._id_E278["default"]["allies"].origin = var_0;
    level._id_E278["default"]["allies"].angles = var_2;
  }

  if(!istrue(level._id_E278["default"]["axis"]._id_BF1C)) {
    var_3 = level._id_9AB0 + level._id_E27F * level._id_E275 * -0.85 + (0, 0, 1) * level._id_E275 * 0.45;
    var_1 = vectornormalize(level._id_9AB0 - var_3);
    var_4 = scripts\mp\utility\script::_id_FFE3(var_1, (0, 0, 1));
    level._id_E278["default"]["axis"].origin = var_3;
    level._id_E278["default"]["axis"].angles = var_4;
  }
}

_id_AC6D() {
  var_0 = scripts\mp\utility\teams::_id_6A59("allies", 1);
  var_1 = level._id_E27B;

  if(var_0.size > 0) {
    var_1 = (0, 0, 0);

    foreach(var_3 in var_0) {
      var_1 = var_1 + var_3.origin;
    }

    var_1 = var_1 / var_0.size;
  }

  var_5 = scripts\mp\utility\teams::_id_6A59("axis", 1);
  var_6 = level._id_E27D;

  if(var_5.size > 0) {
    var_6 = (0, 0, 0);

    foreach(var_3 in var_5) {
      var_6 = var_6 + var_3.origin;
    }

    var_6 = var_6 / var_5.size;
  }

  var_9 = var_6 - var_1;
  var_10 = vectornormalize(var_9);
  var_11 = vectordot(var_9, var_9);

  if(var_11 < 1048576) {
    return;
  }
  var_12 = level._id_9AB0 + var_10 * level._id_E275 * -0.5 + (0, 0, 1) * level._id_E275 * 0.2;
  var_13 = vectornormalize(level._id_9AB0 - var_12);
  var_14 = scripts\mp\utility\script::_id_FFE3(var_13, (0, 0, 1));
  level._id_E278["default"]["allies"].origin = var_12;
  level._id_E278["default"]["allies"].angles = var_14;
  var_15 = level._id_9AB0 + var_10 * level._id_E275 * 0.5 + (0, 0, 1) * level._id_E275 * 0.2;
  var_13 = vectornormalize(level._id_9AB0 - var_15);
  var_16 = scripts\mp\utility\script::_id_FFE3(var_13, (0, 0, 1));
  level._id_E278["default"]["axis"].origin = var_15;
  level._id_E278["default"]["axis"].angles = var_16;
  thread scripts\mp\utility\debug::_id_4F43(var_12, level._id_9AB0, 60.0, (0, 0, 1));
  thread scripts\mp\utility\debug::_id_4F43(var_15, level._id_9AB0, 60.0, (1, 0, 0));
}

_id_2FDE() {
  var_0 = scripts\mp\utility\teams::_id_6A59("allies", 1);
  var_1 = _id_6D88("allies");

  if(var_0.size > 0) {
    var_1 = (0, 0, 0);

    foreach(var_3 in var_0) {
      var_1 = var_1 + var_3.origin;
    }

    var_1 = var_1 / var_0.size;
  }

  var_5 = scripts\mp\utility\teams::_id_6A59("axis", 1);
  var_6 = _id_6D88("axis");

  if(var_5.size > 0) {
    var_6 = (0, 0, 0);

    foreach(var_3 in var_5) {
      var_6 = var_6 + var_3.origin;
    }

    var_6 = var_6 / var_5.size;
  }

  var_9 = var_6 - var_1;
  var_10 = vectornormalize(var_9);
  var_11 = spawnStruct();
  var_11.origin = (var_1 + var_6) * 0.5;
  var_11.angles = _func_025B(var_10, (0, 0, 1));
  var_11._id_EF62 = [];
  var_11._id_EF62["allies"] = var_1;
  var_11._id_EF62["axis"] = var_6;
  return var_11;
}

_id_6D88(var_0) {
  if(isDefined(level._id_E721) && isDefined(level._id_E721[var_0])) {
    return level._id_E721[var_0];
  }

  if(!isDefined(level._id_E721)) {
    level._id_E721 = [];
  }

  level._id_E721[var_0] = (0, 0, 0);
  var_1 = _id_0817::_id_6D4E("mp_tdm_spawn_" + var_0 + "_start");
  var_2 = (0, 0, 0);

  foreach(var_4 in var_1) {
    var_2 = var_2 + var_4.origin;
  }

  if(var_1.size > 0) {
    var_2 = var_2 / var_1.size;
  }

  level._id_E721[var_0] = var_2;
  return level._id_E721[var_0];
}

_id_1785(var_0, var_1) {
  return 180 - abs(abs(var_0 - var_1) - 180);
}