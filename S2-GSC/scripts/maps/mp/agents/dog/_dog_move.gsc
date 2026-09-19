/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\dog\_dog_move.gsc
****************************************************/

main() {
  self endon("killanimscript");
  self._id_17E8 = 0;
  self scragentsetphysicsmode("gravity");
  _id_92E9();
  _id_2603();
}

_id_0085() {
  self._id_17E8 = 0;
  _id_1F39(undefined);
  self scragentsetanimscale(1, 1);
}

_id_8A30() {
  thread _id_A6C2();
  thread _id_A6C4();
  thread _id_A6C7();
}

_id_2603() {
  _id_8A30();
  self scragentsetanimmode("code_move");
  self scragentsetorientmode("face motion");
  self scragentsetanimscale(1, 1);
  _id_86CF(self._id_0108);
}

_id_86CF(var_0) {
  self setanimstate(var_0);
}

_id_A6C2() {
  self endon("dogmove_endwait_runwalk");
  self endon("death");
  var_0 = self._id_0108;

  for(;;) {
    if(var_0 != self._id_0108) {
      _id_86CF(self._id_0108);
      var_0 = self._id_0108;
    }

    wait 0.1;
  }
}

_id_32A8(var_0) {
  var_1 = vectortoangles(var_0);
  var_2 = _angleclamp180(var_1[1] - self.angles[1]);
  var_3 = maps\mp\agents\_scriptedagents::_id_4414(var_2);

  if(var_3 == 4) {
    _id_2603();
    return;
  }

  var_4 = "sharp_turn";
  var_5 = self getanimentry(var_4, var_3);
  var_6 = _getangledelta(var_5);
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", (0, _angleclamp180(var_1[1] - var_6), 0));
  maps\mp\agents\_scriptedagents::_id_71FC(var_4, var_3, "sharp_turn");
  _id_2603();
}

_id_A6C4() {
  self endon("dogmove_endwait_sharpturn");
  self endon("death");
  self waittill("path_dir_change", var_0);
  _id_1F39("sharpturn");
  _id_32A8(var_0);
}

_id_A6C7() {
  self endon("dogmove_endwait_stop");
  self endon("death");
  self waittill("stop_soon");

  if(isDefined(self._id_15E1) && !self._id_15E1) {
    thread _id_A6C7();
    return;
  }

  var_0 = _id_46B1();
  var_1 = self getanimentry(var_0._id_931A, var_0._id_00D4);
  var_2 = _getmovedelta(var_1);
  var_3 = _getangledelta(var_1);
  var_4 = self getpathgoalpos();
  var_5 = var_4 - self.origin;

  if(length(var_5) + 12 < length(var_2)) {
    thread _id_A6C7();
    return;
  }

  var_6 = _id_46B2();
  var_7 = _id_1E40(var_6._id_7584, var_6.angles[1], var_2, var_3);
  var_8 = maps\mp\agents\_scriptedagents::_id_34A6(var_7);

  if(!isDefined(var_8)) {
    thread _id_A6C7();
    return;
  }

  if(!maps\mp\agents\_scriptedagents::_id_1F5B(var_6._id_7584, var_8)) {
    thread _id_A6C7();
    return;
  }

  _id_1F39("stop");
  thread _id_A6B2();
  thread _id_A6C5();

  if(distancesquared(var_7, self.origin) > 4) {
    self scragentsetwaypoint(var_7);
    thread _id_A693();
    self waittill("waypoint_reached");
    self notify("dogmove_endwait_blockedwhilestopping");
  }

  var_9 = var_4 - self.origin;
  var_10 = vectortoangles(var_9);
  var_11 = (0, var_10[1] - var_3, 0);
  var_12 = maps\mp\agents\_scriptedagents::_id_441C(var_4 - self.origin, var_2);
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", var_11, (0, var_10[1], 0));
  self scragentsetanimscale(var_12._id_AAE3, var_12._id_01D9);
  maps\mp\agents\_scriptedagents::_id_71FC(var_0._id_931A, var_0._id_00D4, "move_stop");
  self scragentsetgoalpos(self.origin);
}

_id_A6B2() {
  self endon("killanimscript");
  self endon("dogmove_endwait_pathsetwhilestopping");
  var_0 = self scragentgetgoalpos();
  self waittill("path_set");
  var_1 = self scragentgetgoalpos();

  if(distancesquared(var_0, var_1) < 1) {
    thread _id_A6B2();
    return;
  }

  self notify("dogmove_endwait_stop");
  self notify("dogmove_endwait_sharpturnwhilestopping");
  _id_2603();
}

_id_A6C5() {
  self endon("killanimscript");
  self endon("dogmove_endwait_sharpturnwhilestopping");
  self waittill("path_dir_change", var_0);
  self notify("dogmove_endwait_pathsetwhilestopping");
  self notify("dogmove_endwait_stop");
  _id_32A8(var_0);
}

_id_A693() {
  self endon("killanimscript");
  self endon("dogmove_endwait_blockedwhilestopping");
  self waittill("path_blocked");
  self notify("dogmove_endwait_stop");
  self scragentsetwaypoint(undefined);
}

_id_A6C8() {
  self endon("killanimscript");
  self endon("dogmove_endwait_stopearly");
  var_0 = self getanimentry("move_stop_4", 0);
  var_1 = _getmovedelta(var_0);
  var_2 = length(var_1);
  var_3 = self._id_7673 + var_2;
  var_4 = var_3 * var_3;

  if(distancesquared(self.origin, self._id_0117.origin) <= var_4) {
    return;
  }
  for(;;) {
    if(!isDefined(self._id_0117)) {
      break;
    }

    if(distancesquared(self.origin, self._id_0117.origin) < var_4) {
      var_5 = self localtoworldcoords(var_1);
      self scragentsetgoalpos(var_5);
      break;
    }

    wait 0.1;
  }
}

_id_1F39(var_0) {
  var_1 = ["runwalk", "sharpturn", "stop", "pathsetwhilestopping", "blockedwhilestopping", "sharpturnwhilestopping", "stopearly"];
  var_2 = isDefined(var_0);

  foreach(var_4 in var_1) {
    if(var_2 && var_4 == var_0) {
      continue;
    }
    self notify("dogmove_endwait_" + var_4);
  }
}

_id_92E9() {
  var_0 = self getnegotiationstartnode();

  if(isDefined(var_0))
    var_1 = var_0.origin;
  else
    var_1 = self getpathgoalpos();

  if(distancesquared(var_1, self.origin) < 10000) {
    return;
  }
  var_2 = self getlookaheaddir();
  var_3 = vectortoangles(var_2);
  var_4 = self getvelocity();

  if(_length2dsquared(var_4) > 16) {
    var_4 = vectorNormalize(var_4);

    if(vectordot(var_4, var_2) > 0.707)
      return;
  }

  var_5 = _angleclamp180(var_3[1] - self.angles[1]);
  var_6 = maps\mp\agents\_scriptedagents::_id_4414(var_5);
  var_7 = self getanimentry("move_start", var_6);
  var_8 = _getmovedelta(var_7);
  var_9 = _rotatevector(var_8, self.angles) + self.origin;

  if(!maps\mp\agents\_scriptedagents::_id_1F5B(self.origin, var_9)) {
    return;
  }
  var_10 = _getangledelta3d(var_7);
  self scragentsetanimmode("anim deltas");

  if(3 <= var_6 && var_6 <= 5)
    self scragentsetorientmode("face angle abs", (0, _angleclamp180(var_3[1] - var_10[1]), 0));
  else
    self scragentsetorientmode("face angle abs", self.angles);

  self._id_17E8 = 1;
  maps\mp\agents\_scriptedagents::_id_71FC("move_start", var_6, "move_start");
  self._id_17E8 = 0;
}

_id_46B2() {
  var_0 = spawnStruct();

  if(isDefined(self._id_010D)) {
    var_0._id_7584 = self._id_010D.origin;
    var_0.angles = self._id_010D.angles;
  } else {
    var_1 = self getpathgoalpos();
    var_0._id_7584 = var_1;
    var_0.angles = vectortoangles(self getlookaheaddir());
  }

  return var_0;
}

_id_46B1(var_0) {
  if(isDefined(self._id_010D)) {
    var_1 = self._id_010D.angles[1] - self.angles[1];
    var_2 = maps\mp\agents\_scriptedagents::_id_4414(var_1);
  } else
    var_2 = 4;

  var_3 = spawnStruct();
  var_3._id_931A = "move_stop";
  var_3._id_00D4 = var_2;
  return var_3;
}

_id_1E40(var_0, var_1, var_2, var_3) {
  var_4 = var_1 - var_3;
  var_5 = (0, var_4, 0);
  var_6 = anglesToForward(var_5);
  var_7 = anglestoright(var_5);
  var_8 = var_6 * var_2[0];
  var_9 = var_7 * var_2[1];
  return var_0 - var_8 + var_9;
}

_id_3191() {
  var_0 = clamp(self._id_00E9 / 25.0, -1, 1);

  if(var_0 > 0) {
    return;
  }
  return;
}

_id_4AC2(var_0, var_1, var_2, var_3) {
  if(1)
    return 0;

  switch (var_0) {
    case "footstep_back_right_large":
    case "footstep_back_left_large":
    case "footstep_front_right_large":
    case "footstep_front_left_large":
    case "footstep_back_right_small":
    case "footstep_back_left_small":
    case "footstep_front_right_small":
    case "footstep_front_left_small":
      var_4 = undefined;

      if(isDefined(self._id_019C)) {
        var_4 = self._id_019C;
        self._id_5C01 = var_4;
      } else if(isDefined(self._id_5C01))
        var_4 = self._id_5C01;
      else
        var_4 = "dirt";

      if(var_4 != "dirt" && var_4 != "concrete" && var_4 != "wood" && var_4 != "metal")
        var_4 = "dirt";

      if(var_4 == "concrete")
        var_4 = "cement";

      if(self._id_0BA4 == "traverse")
        var_5 = "land";
      else if(self._id_0108 == "sprint")
        var_5 = "sprint";
      else if(self._id_0108 == "fastwalk")
        var_5 = "walk";
      else
        var_5 = "run";

      self playsoundonmovingent("dogstep_" + var_5 + "_" + var_4);

      if(issubstr(var_0, "front_left")) {
        var_6 = "anml_dog_mvmt_accent";
        var_7 = "anml_dog_mvmt_vest";

        if(var_5 == "walk")
          var_8 = "_npc";
        else
          var_8 = "_run_npc";

        self playsoundonmovingent(var_6 + var_8);
        self playsoundonmovingent(var_7 + var_8);
      }

      return 1;
  }

  return 0;
}

_id_31FC(var_0) {
  _id_1F39(undefined);
  self._id_17E8 = 1;
  self._id_018F = 1;
  var_1 = _angleclamp180(var_0 - self.angles[1]);

  if(var_1 > 0)
    var_2 = 1;
  else
    var_2 = 0;

  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  maps\mp\agents\_scriptedagents::_id_71FC("run_pain", var_2, "run_pain");
  self._id_17E8 = 0;
  self._id_018F = 0;
  _id_2603();
}

_id_6ADB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(self._id_018F) {
    return;
  }
  var_10 = vectortoangles(var_7);
  var_11 = var_10[1] - 180;
  _id_31FC(var_11);
}

_id_6B3B(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(self._id_018F) {
    return;
  }
  _id_31FC(self.angles[1] + 180);
}