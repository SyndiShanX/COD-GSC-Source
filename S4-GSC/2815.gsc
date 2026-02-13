/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2815.gsc
*************************************************/

main() {
  self endon("killanimscript");
  self._id_2596 = 0;
  self _meth_82C2("gravity");
  _id_E6F8();
  _id_3C5B();
}

_id_0191() {
  self._id_2596 = 0;
  _id_3156(undefined);
  self _meth_82BA(1, 1);
}

_id_D893() {
  thread _id_10824();
  thread _id_10826();
  thread _id_1082C();
}

_id_3C5B() {
  _id_D893();
  self _meth_82B9("code_move");
  self _meth_82C1("face motion");
  self _meth_82BA(1, 1);
  _id_D601(self._id_02D6);
}

_id_D601(var_0) {
  self _meth_82E6(var_0);
}

_id_10824() {
  self endon("dogmove_endwait_runwalk");
  var_0 = self._id_02D6;

  for(;;) {
    if(var_0 != self._id_02D6) {
      _id_D601(self._id_02D6);
      var_0 = self._id_02D6;
    }

    wait 0.1;
  }
}

_id_4E6F(var_0) {
  var_1 = vectortoangles(var_0);
  var_2 = _func_000B(var_1[1] - self.angles[1]);
  var_3 = _func_0326(var_2);

  if(var_3 == 4) {
    _id_3C5B();
    return;
  }

  var_4 = "sharp_turn";
  var_5 = self _meth_810C(var_4, var_3);
  var_6 = _func_0077(var_5);
  self _meth_82B9("anim deltas");
  self _meth_82C1("face angle abs", (0, _func_000B(var_1[1] - var_6), 0));
  _id_0017::_id_B356(var_4, var_3, "sharp_turn");
  _id_3C5B();
}

_id_10826() {
  self endon("dogmove_endwait_sharpturn");
  self waittill("path_dir_change", var_0);
  _id_3156("sharpturn");
  _id_4E6F(var_0);
}

_id_1082C() {
  self endon("dogmove_endwait_stop");
  self waittill("stop_soon");

  if(isDefined(self._id_2297) && !self._id_2297) {
    thread _id_1082C();
    return;
  }

  var_0 = _id_6D91();
  var_1 = self _meth_810C(var_0._id_E747, var_0.index);
  var_2 = _func_00B0(var_1);
  var_3 = _func_0077(var_1);
  var_4 = self _meth_816A();
  var_5 = var_4 - self.origin;

  if(length(var_5) + 12 < length(var_2)) {
    thread _id_1082C();
    return;
  }

  var_6 = _id_6D92();
  var_7 = _id_2EB1(var_6._id_B9FE, var_6.angles[1], var_2, var_3);
  var_8 = _id_06E0::_id_5056(var_7);

  if(!isDefined(var_8)) {
    thread _id_1082C();
    return;
  }

  if(!_id_06E0::_id_3199(var_6._id_B9FE, var_8)) {
    thread _id_1082C();
    return;
  }

  _id_3156("stop");
  thread _id_1081A();
  thread _id_10828();

  if(distancesquared(var_7, self.origin) > 4) {
    self _meth_82C7(var_7);
    thread _id_107F8();
    self waittill("waypoint_reached");
    self notify("dogmove_endwait_blockedwhilestopping");
  }

  var_9 = var_4 - self.origin;
  var_10 = vectortoangles(var_9);
  var_11 = (0, var_10[1] - var_3, 0);
  var_12 = _id_0017::_id_68C5(var_4 - self.origin, var_2);
  self _meth_82B9("anim deltas");
  self _meth_82C1("face angle abs", var_11, (0, var_10[1], 0));
  self _meth_82BA(var_12._id_10FDD, var_12._id_050C);
  _id_0017::_id_B356(var_0._id_E747, var_0.index, "move_stop");
  self _meth_82BE(self.origin);
}

_id_1081A() {
  self endon("killanimscript");
  self endon("dogmove_endwait_pathsetwhilestopping");
  var_0 = self _meth_82B6();
  self waittill("path_set");
  var_1 = self _meth_82B6();

  if(distancesquared(var_0, var_1) < 1) {
    thread _id_1081A();
    return;
  }

  self notify("dogmove_endwait_stop");
  self notify("dogmove_endwait_sharpturnwhilestopping");
  _id_3C5B();
}

_id_10828() {
  self endon("killanimscript");
  self endon("dogmove_endwait_sharpturnwhilestopping");
  self waittill("path_dir_change", var_0);
  self notify("dogmove_endwait_pathsetwhilestopping");
  self notify("dogmove_endwait_stop");
  _id_4E6F(var_0);
}

_id_107F8() {
  self endon("killanimscript");
  self endon("dogmove_endwait_blockedwhilestopping");
  self waittill("path_blocked");
  self notify("dogmove_endwait_stop");
  self _meth_82C7(undefined);
}

_id_1082D() {
  self endon("killanimscript");
  self endon("dogmove_endwait_stopearly");
  var_0 = self _meth_810C("move_stop_4", 0);
  var_1 = _func_00B0(var_0);
  var_2 = length(var_1);
  var_3 = self._id_BB8D + var_2;
  var_4 = var_3 * var_3;

  if(distancesquared(self.origin, self.owner.origin) <= var_4) {
    return;
  }
  for(;;) {
    if(!isDefined(self.owner)) {
      break;
    }

    if(distancesquared(self.origin, self.owner.origin) < var_4) {
      var_5 = self _meth_8216(var_1);
      self _meth_82BE(var_5);
      break;
    }

    wait 0.1;
  }
}

_id_3156(var_0) {
  var_1 = ["runwalk", "sharpturn", "stop", "pathsetwhilestopping", "blockedwhilestopping", "sharpturnwhilestopping", "stopearly"];
  var_2 = isDefined(var_0);

  foreach(var_4 in var_1) {
    if(var_2 && var_4 == var_0) {
      continue;
    }
    self notify("dogmove_endwait_" + var_4);
  }
}

_id_E6F8() {
  var_0 = self _meth_8161();

  if(isDefined(var_0)) {
    var_1 = var_0.origin;
  } else {
    var_1 = self _meth_816A();
  }

  if(distancesquared(var_1, self.origin) < 10000) {
    return;
  }
  var_2 = self _meth_8153();
  var_3 = vectortoangles(var_2);
  var_4 = self getvelocity();

  if(_func_0134(var_4) > 16) {
    var_4 = vectornormalize(var_4);

    if(vectordot(var_4, var_2) > 0.707) {
      return;
    }
  }

  var_5 = _func_000B(var_3[1] - self.angles[1]);
  var_6 = _func_0326(var_5);
  var_7 = self _meth_810C("move_start", var_6);
  var_8 = _func_00B0(var_7);
  var_9 = rotatevector(var_8, self.angles) + self.origin;

  if(!_id_06E0::_id_3199(self.origin, var_9)) {
    return;
  }
  var_10 = _func_0078(var_7);
  self _meth_82B9("anim deltas");

  if(3 <= var_6 && var_6 <= 5) {
    self _meth_82C1("face angle abs", (0, _func_000B(var_3[1] - var_10[1]), 0));
  } else {
    self _meth_82C1("face angle abs", self.angles);
  }

  self._id_2596 = 1;
  _id_0017::_id_B356("move_start", var_6, "move_start");
  self._id_2596 = 0;
}

_id_6D92() {
  var_0 = spawnStruct();

  if(isDefined(self._id_02ED)) {
    var_0._id_B9FE = self._id_02ED.origin;
    var_0.angles = self._id_02ED.angles;
  } else {
    var_1 = self _meth_816A();
    var_0._id_B9FE = var_1;
    var_0.angles = vectortoangles(self _meth_8153());
  }

  return var_0;
}

_id_6D91(var_0) {
  if(isDefined(self._id_02ED)) {
    var_1 = self._id_02ED.angles[1] - self.angles[1];
    var_2 = _func_0326(var_1);
  } else
    var_2 = 4;

  var_3 = spawnStruct();
  var_3._id_E747 = "move_stop";
  var_3.index = var_2;
  return var_3;
}

_id_2EB1(var_0, var_1, var_2, var_3) {
  var_4 = var_1 - var_3;
  var_5 = (0, var_4, 0);
  var_6 = anglesToForward(var_5);
  var_7 = anglestoright(var_5);
  var_8 = var_6 * var_2[0];
  var_9 = var_7 * var_2[1];
  return var_0 - var_8 + var_9;
}

_id_4CB3() {
  var_0 = clamp(self._id_9147 / 25.0, -1, 1);

  if(var_0 > 0) {
    return;
  }
  return;
}

_id_744A(var_0, var_1, var_2, var_3) {
  if(1) {
    return 0;
  }

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

      if(isDefined(self._id_0422)) {
        var_4 = self._id_0422;
        self._id_9099 = var_4;
      } else if(isDefined(self._id_9099))
        var_4 = self._id_9099;
      else {
        var_4 = "dirt";
      }

      if(var_4 != "dirt" && var_4 != "concrete" && var_4 != "wood" && var_4 != "metal") {
        var_4 = "dirt";
      }

      if(var_4 == "concrete") {
        var_4 = "cement";
      }

      if(self._id_13E7 == "traverse") {
        var_5 = "land";
      } else if(self._id_02D6 == "sprint") {
        var_5 = "sprint";
      } else if(self._id_02D6 == "fastwalk") {
        var_5 = "walk";
      } else {
        var_5 = "run";
      }

      self _meth_827E("dogstep_" + var_5 + "_" + var_4);

      if(issubstr(var_0, "front_left")) {
        var_6 = "anml_dog_mvmt_accent";
        var_7 = "anml_dog_mvmt_vest";

        if(var_5 == "walk") {
          var_8 = "_npc";
        } else {
          var_8 = "_run_npc";
        }

        self _meth_827E(var_6 + var_8);
        self _meth_827E(var_7 + var_8);
      }

      return 1;
  }

  return 0;
}

_id_4CF2(var_0) {
  _id_3156(undefined);
  self._id_2596 = 1;
  self._id_0406 = 1;
  var_1 = _func_000B(var_0 - self.angles[1]);

  if(var_1 > 0) {
    var_2 = 1;
  } else {
    var_2 = 0;
  }

  self _meth_82B9("anim deltas");
  self _meth_82C1("face angle abs", self.angles);
  _id_0017::_id_B356("run_pain", var_2, "run_pain");
  self._id_2596 = 0;
  self._id_0406 = 0;
  _id_3C5B();
}

_id_AA9A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(self._id_0406) {
    return;
  }
  var_10 = vectortoangles(var_7);
  var_11 = var_10[1] - 180;
  _id_4CF2(var_11);
}

_id_AAF0(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(self._id_0406) {
    return;
  }
  _id_4CF2(self.angles[1] + 180);
}