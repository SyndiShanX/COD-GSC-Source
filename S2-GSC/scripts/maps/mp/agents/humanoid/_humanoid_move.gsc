/**************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\humanoid\_humanoid_move.gsc
**************************************************************/

main() {
  self endon("killanimscript");
  self scragentsetphysicsmode("gravity");
  self._id_5759 = 1;
  _id_92E9();
  _id_2603();
}

_id_0085() {
  self._id_5759 = undefined;
  _id_1F39(undefined);
  self scragentsetanimscale(1, 1);
}

_id_8A30() {
  thread _id_A6C2();
  thread _id_A6D6();
  thread _id_A6C7();
  thread _id_A69C();
  thread _id_A6A9();
}

_id_2603() {
  self notify("humanoidmove_endwait_continuemovement");
  self endon("humanoidmove_endwait_continuemovement");
  self endon("killanimscript");
  _id_8A30();
  _id_86CF(self._id_0108);

  if(isDefined(self._id_9D0C) && self._id_9D0C - gettime() <= 50)
    wait(self._id_9D0B + 0.05);

  self scragentsetanimmode("code_move");
  self scragentsetorientmode("face motion");
  self scragentsetanimscale(1, 1);
}

_id_0E19(var_0) {
  if(isDefined(self._id_6481)) {
    var_1 = self getanimentrycount(var_0);
    return int(clamp(self._id_6481 * var_1, 0, var_1 - 1));
  } else
    return maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_0);
}

_id_86CF(var_0) {
  self notify("humanoidmove_endwait_setmoveanim");
  self endon("humanoidmove_endwait_setmoveanim");
  self endon("killanimscript");
  self._id_5382 = 0;
  self._id_54F4 = 0;
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_0);
  var_2 = _id_0E19(var_1);
  maps\mp\agents\_scripted_agent_anim_util::isenemyaware(var_1, var_2, self._id_64C2);
}

is_passive_exempt() {
  return isDefined(level.zmb_exempt_from_passive_list) && common_scripts\utility::_id_0F79(level.zmb_exempt_from_passive_list, self._id_0A4B) || common_scripts\utility::_id_562E(self.ispassiveexempt);
}

_id_86D0(var_0, var_1, var_2) {
  self notify("humanoidmove_endwait_setmoveanim");
  self endon("humanoidmove_endwait_setmoveanim");
  self endon("killanimscript");

  if(maps\mp\agents\humanoid\_humanoid_util::_id_56BC()) {
    return;
  }
  var_3 = "pain_" + self._id_0108;

  if(var_2)
    var_3 = var_3 + "_lower";

  var_4 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_3);
  var_5 = _angleclamp180(var_0 - self.angles[1]);
  var_6 = self getanimentrycount(var_4);
  var_7 = maps\mp\agents\humanoid\_humanoid_util::_id_45F8(var_5, var_6);
  self._id_5382 = 1;
  self scragentsetanimmode("code_move");
  self scragentsetorientmode("face motion");
  self scragentsetanimscale(1, 1);
  var_8 = self._id_64C2;

  if(self._id_0108 == "walk")
    var_8 = var_8 - 0.2;
  else if(self._id_0108 == "run")
    var_8 = var_8 - 0.1;

  var_8 = max(var_8, 0.01);
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_4, var_7, var_8, "pain_anim");
  thread _id_2603();
}

_id_A6C2() {
  self notify("humanoidmove_endwait_modechange");
  self endon("humanoidmove_endwait_modechange");
  self endon("killanimscript");
  var_0 = self._id_0108;
  var_1 = self._id_64C2;
  var_2 = common_scripts\utility::_id_3794("zombie_passive");

  for(;;) {
    var_3 = 0;

    if(isDefined(self._id_0108) && (!isDefined(var_0) || var_0 != self._id_0108))
      var_3 = 1;

    if(isDefined(self._id_64C2) && (!isDefined(var_1) || var_1 != self._id_64C2))
      var_3 = 1;

    var_4 = common_scripts\utility::_id_3794("zombie_passive");

    if(var_2 != var_4)
      var_3 = 1;

    if(var_3) {
      thread _id_86CF(self._id_0108);
      var_0 = self._id_0108;
      var_1 = self._id_64C2;
      var_2 = var_4;
    }

    waitframe();
  }
}

_id_32B8(var_0) {
  self notify("humanoidmove_DoTurn");
  self endon("humanoidmove_DoTurn");
  self endon("killanimscript");
  _id_1F39("");
  self._id_54F4 = 1;
  self scragentsetanimmode(var_0._id_0EC3);

  if(isDefined(var_0._id_6C39))
    self scragentsetorientmode(var_0._id_6C37, var_0._id_6C38, var_0._id_6C39);
  else if(isDefined(var_0._id_6C38))
    self scragentsetorientmode(var_0._id_6C37, var_0._id_6C38);
  else
    self scragentsetorientmode(var_0._id_6C37);

  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_0._id_0EE8, var_0._id_0EC1, self._id_64C2, "turn");
  thread _id_2603();
}

_id_220E(var_0, var_1, var_2) {
  var_3 = maps\mp\agents\_scripted_agent_anim_util::_id_087C(var_0, var_1);

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = vectortoangles(var_2);
  var_5 = _angleclamp180(var_4[1] - self.angles[1]);
  var_6 = self getanimentrycount(var_3);

  if(var_6 <= 0) {
    return;
  }
  var_7 = maps\mp\agents\_scripted_agent_anim_util::_id_4416(var_5, var_6);

  if(var_7 == int(var_6 * 0.5)) {
    return;
  }
  var_8 = self getanimentry(var_3, var_7);
  var_9 = _getangledelta(var_8);
  var_10 = (0, _angleclamp180(var_4[1] - var_9), 0);

  if(_id_1F4E(var_8, var_10, var_7 == 3 || var_7 == 5, 1)) {
    var_11 = spawnStruct();
    var_11._id_0EE8 = var_3;
    var_11._id_0EC1 = var_7;
    var_11._id_0EC3 = "anim deltas";
    var_11._id_6C37 = "face angle abs";
    var_11._id_6C38 = var_10;
    return var_11;
  }
}

_id_220C(var_0) {
  var_1 = self[[maps\mp\agents\_agent_utility::_id_0A59("get_action_params")]]();
  var_2 = "turn_" + self._id_0108;
  var_3 = _id_220E(var_2, var_1, var_0);

  if(isDefined(var_3))
    return var_3;

  var_2 = var_2 + "_quick";
  var_3 = _id_220E(var_2, var_1, var_0);

  if(isDefined(var_3))
    return var_3;
}

_id_1F4E(var_0, var_1, var_2, var_3) {
  var_4 = 0.5;
  var_5 = _getnotetracktimes(var_0, "turn_extent");

  if(var_5.size == 1)
    var_4 = var_5[0];

  var_6 = 1.0;
  var_7 = _getnotetracktimes(var_0, "finish");

  if(var_7.size == 0)
    var_7 = _getnotetracktimes(var_0, "end");

  if(var_7.size == 1)
    var_6 = var_7[0];

  var_8 = _getmovedelta(var_0, 0.0, var_4);
  var_9 = _getmovedelta(var_0, 0.0, var_6);
  var_10 = self.origin;
  var_11 = _rotatevector(var_8, var_1) + var_10;
  var_12 = _rotatevector(var_9, var_1) + var_10;

  if(!_id_0547::_id_1F5B(var_11, var_12, 0))
    return 0;

  var_13 = self.radius;

  if(!var_2)
    var_13 = self.radius / 2;

  if(!_id_0547::_id_1F5B(var_10, var_11, 0, var_13))
    return 0;

  return 1;
}

_id_5810() {
  return common_scripts\utility::_id_562E(self._id_50D9) || common_scripts\utility::_id_562E(self._id_5382);
}

_id_A6D6() {
  self notify("humanoidmove_endwait_turn");
  self endon("humanoidmove_endwait_turn");
  self endon("killanimscript");

  if(common_scripts\utility::_id_562E(self._id_2FA4)) {
    return;
  }
  var_0 = undefined;

  if(isDefined(self._id_220D))
    var_0 = [[self._id_220D]]();
  else {
    while(!isDefined(var_0)) {
      self waittill("path_dir_change", var_1);

      if(_id_5810()) {
        continue;
      }
      var_0 = _id_220C(var_1);
    }
  }

  thread _id_32B8(var_0);
}

_id_A6C7() {
  self notify("humanoidmove_endwait_stop");
  self endon("humanoidmove_endwait_stop");
  self endon("killanimscript");
  self waittill("stop_soon");

  if(common_scripts\utility::_id_562E(self._id_50D9))
    thread _id_A6C7();

  if(!common_scripts\utility::_id_562E(self._id_15E1)) {
    thread _id_A6C7();
    return;
  }

  var_0 = "stop_" + self._id_0108;
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_0);

  if(!isDefined(var_1)) {
    var_0 = "stop_walk";
    var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_0);
  }

  var_2 = self getanimentrycount(var_1);

  if(var_2 <= 0) {
    thread _id_A6C7();
    return;
  }

  var_3 = 0;

  if(isDefined(self._id_010D))
    var_3 = self._id_010D.angles[1] - self.angles[1];

  var_4 = maps\mp\agents\_scripted_agent_anim_util::_id_4416(var_3, var_2);
  var_5 = self getanimentry(var_1, var_4);
  var_6 = _getmovedelta(var_5);
  var_7 = _getangledelta(var_5);
  var_8 = self getpathgoalpos();
  var_9 = var_8 - self.origin;

  if(length(var_9) + 12 < length(var_6)) {
    thread _id_A6C7();
    return;
  }

  var_10 = _id_46B2();
  var_11 = _id_1E40(var_10._id_7584, var_10.angles[1], var_6, var_7);
  var_12 = _id_0547::_id_34A6(var_11);

  if(!isDefined(var_12)) {
    thread _id_A6C7();
    return;
  }

  if(!_id_0547::_id_1F5B(var_10._id_7584, var_12)) {
    thread _id_A6C7();
    return;
  }

  _id_1F39("stop");
  thread _id_A6B2();
  thread _id_A6D7();

  if(distancesquared(var_11, self.origin) > 25) {
    self scragentsetwaypoint(var_11);
    thread _id_A693();
    self waittill("waypoint_reached");
    self notify("humanoidmove_endwait_blockedwhilestopping");
  }

  var_13 = var_8 - self.origin;
  var_14 = vectortoangles(var_13);
  var_15 = (0, var_14[1] - var_7, 0);
  var_16 = maps\mp\agents\_scripted_agent_anim_util::_id_441C(var_8 - self.origin, var_6);
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", var_15, (0, var_14[1], 0));
  self scragentsetanimscale(var_16._id_AAE3, var_16._id_01D9);
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, var_4, self._id_64C2, "move_stop");
  self scragentsetgoalpos(self.origin);
}

_id_A69C() {
  self notify("humanoidmove_endwait_dodge");
  self endon("humanoidmove_endwait_dodge");
  self endon("killanimscript");
  _id_0547::_id_A737();

  while(isalive(self)) {
    self waittill("damage", var_0, var_1);
    waitframe();

    if(!isalive(self)) {
      return;
    }
    if(!common_scripts\utility::_id_562E(self._id_313E)) {
      return;
    }
    if(maps\mp\agents\_scripted_agent_anim_util::_id_57E2()) {
      continue;
    }
    if(!isDefined(var_1) || !isalive(var_1) || !isPlayer(var_1)) {
      continue;
    }
    var_2 = var_1.origin - self.origin;
    var_3 = anglesToForward(self.angles);

    if(vectordot(vectorNormalize(var_2), var_3) < 0.7) {
      continue;
    }
    var_4 = _lengthsquared(var_2);

    if(var_4 > 1000000 || var_4 < 40000) {
      continue;
    }
    if(isDefined(self._id_313F) && gettime() - self._id_313F < self._id_313B) {
      continue;
    }
    self._id_313F = gettime();

    if(_randomfloat(1.0) < self._id_313A) {
      wait(_randomfloatrange(0.1, 0.3));

      if(!isalive(self)) {
        return;
      }
      if(maps\mp\agents\_scripted_agent_anim_util::_id_57E2()) {
        continue;
      }
      _id_1F39("dodge");
      self._id_5F48 = gettime();
      var_5 = vectorNormalize((var_2[0], var_2[1], 0));
      var_6 = vectortoangles(var_5);
      var_7 = self._id_3139;
      var_8 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_7);
      maps\mp\agents\humanoid\_humanoid_util::_id_70C9(self._id_3138[var_8]);
      self scragentsetanimmode("anim deltas");
      self scragentsetorientmode("face angle abs", var_6, var_6);
      self scragentsetanimscale(1, 1);
      maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_7, var_8, self._id_672D, "dodge");
      self._id_173E = 1;
      thread _id_2603();
    }
  }
}

_id_A6A9() {
  self notify("humanoidmove_endwait_leap");
  self endon("humanoidmove_endwait_leap");
  self endon("killanimscript");
  _id_0547::_id_A737();

  for(;;) {
    waitframe();

    if(!isalive(self)) {
      return;
    }
    if(!common_scripts\utility::_id_562E(self._id_5C53)) {
      return;
    }
    if(maps\mp\agents\_scripted_agent_anim_util::_id_57E2()) {
      continue;
    }
    if(!isDefined(self._id_28D2)) {
      continue;
    }
    if(_issentient(self._id_28D2) && !self agentcanseesentient(self._id_28D2) || !maps\mp\_utility::_id_3B8E(self, self._id_28D2, 25)) {
      continue;
    }
    var_0 = maps\mp\agents\humanoid\_humanoid::_id_457E(self._id_28D2);

    if(!var_0._id_A266) {
      continue;
    }
    var_1 = distancesquared(self._id_28D2.origin, self.origin);

    if(var_1 > self._id_5C58 || var_1 < self._id_5C5A) {
      continue;
    }
    var_2 = gettime();
    var_3 = var_2 - self._id_5C56;

    if(var_3 < self._id_5C50) {
      continue;
    }
    var_4 = var_2 - self._id_5C55;

    if(var_4 < self._id_5C4F) {
      continue;
    }
    self._id_5C55 = var_2;
    var_5 = self._id_5C4E;

    if(_randomfloat(1.0) >= var_5) {
      continue;
    }
    var_7 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(self._id_5C4D);
    var_8 = self getanimentry(self._id_5C4D, var_7);
    var_9 = _getnotetracktimes(var_8, "h_point")[0];
    var_10 = _getmovedelta(var_8, 0, var_9);
    var_11 = self localtoworldcoords(var_10);
    var_12 = _playerphysicstrace(self.origin, var_11, self);

    if(distancesquared(var_12, var_11) > 1) {
      self._id_5C55 = self._id_5C55 + 1000;
      continue;
    }

    var_12 = _playerphysicstrace(var_11, var_0.origin, self);

    if(distancesquared(var_12, var_0.origin) > 1) {
      self._id_5C55 = self._id_5C55 + 1000;
      continue;
    }

    _id_1F39("leap");
    self._id_5C56 = gettime();
    maps\mp\agents\humanoid\_humanoid_util::_id_70C9(self._id_5C54);
    var_13 = _getanimlength(var_8);
    var_14 = _getnotetracktimes(var_8, "land");
    var_14[0] = var_14[0] - 0.1;
    var_15 = var_13 / self._id_672D * var_14[0];
    self scragentsetphysicsmode("noclip");
    self scragentsetorientmode("face angle abs", (0, _vectortoyaw(var_0.origin - self.origin), 0));
    self scragentsetanimmode("anim deltas");
    self scragentsetanimscale(0, 1);
    self scragentdoanimlerp(self.origin, var_0.origin, var_15);
    maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "WaitForLeap");
    self._id_50D9 = 1;
    maps\mp\agents\_scripted_agent_anim_util::isenemyaware(self._id_5C4D, var_7, self._id_672D);
    wait(var_15);
    self notify("cancel_updatelerppos");
    self scragentsetanimmode("anim deltas");
    self scragentsetanimscale(1, 1);
    self scragentsetphysicsmode("gravity");
    maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "WaitForLeap");
    self._id_50D9 = 0;

    if(var_13 - var_15 > 0)
      maps\mp\agents\_scripted_agent_anim_util::_id_A79F("leap", "end", var_13 - var_15);

    thread _id_2603();
  }
}

_id_A6B2() {
  self notify("humanoidmove_endwait_pathsetwhilestopping");
  self endon("humanoidmove_endwait_pathsetwhilestopping");
  self endon("killanimscript");
  var_0 = self scragentgetgoalpos();
  self waittill("path_set");
  var_1 = self scragentgetgoalpos();

  if(distancesquared(var_0, var_1) < 1) {
    thread _id_A6B2();
    return;
  }

  self notify("humanoidmove_endwait_stop");
  self notify("humanoidmove_endwait_turnwhilestopping");
  thread _id_2603();
}

_id_A6D7() {
  self notify("humanoidmove_endwait_turnwhilestopping");
  self endon("humanoidmove_endwait_turnwhilestopping");
  self endon("killanimscript");
  var_0 = undefined;

  if(isDefined(self._id_220D))
    var_0 = [[self._id_220D]]();
  else {
    while(!isDefined(var_0)) {
      self waittill("path_dir_change", var_1);
      var_0 = _id_220C(var_1);
    }
  }

  self notify("humanoidmove_endwait_pathsetwhilestopping");
  self notify("humanoidmove_endwait_stop");
  childthread _id_32B8(var_0);
}

_id_A693() {
  self notify("humanoidmove_endwait_blockedwhilestopping");
  self endon("humanoidmove_endwait_blockedwhilestopping");
  self endon("killanimscript");
  self waittill("path_blocked");
  self notify("humanoidmove_endwait_stop");
  self scragentsetwaypoint(undefined);
}

_id_1F39(var_0) {
  var_1 = ["turn", "stop", "pathsetwhilestopping", "blockedwhilestopping", "turnwhilestopping", "dodge", "setmoveanim", "modechange", "continuemovement"];
  var_2 = isDefined(var_0);

  foreach(var_4 in var_1) {
    if(var_2 && var_4 == var_0) {
      continue;
    }
    self notify("humanoidmove_endwait_" + var_4);
  }
}

_id_92E9() {
  if(isDefined(self._id_9D0C) && self._id_9D0C - gettime() <= 50) {
    return;
  }
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
  var_5 = _length2d(var_4);
  var_6 = self.maxstartmovespeed;

  if(isDefined(var_6) && var_5 > var_6) {
    return;
  }
  if(var_5 > 4) {
    var_4 = vectorNormalize(var_4);

    if(vectordot(var_4, var_2) > 0.707)
      return;
  }

  var_7 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("start_" + self._id_0108);
  var_8 = _angleclamp180(var_3[1] - self.angles[1]);
  var_9 = self getanimentrycount(var_7);

  if(var_9 == 0) {
    return;
  }
  var_10 = maps\mp\agents\_scripted_agent_anim_util::_id_4416(var_8, var_9);
  var_11 = self getanimentry(var_7, var_10);
  var_12 = _getmovedelta(var_11);
  var_13 = _rotatevector(var_12, self.angles) + self.origin;

  if(!_id_0547::_id_1F5B(self.origin, var_13)) {
    return;
  }
  var_14 = _getangledelta3d(var_11);
  self scragentsetanimmode("anim deltas");

  if(_abs(var_10 - int(var_9 * 0.5)) <= 1)
    self scragentsetorientmode("face angle abs", (0, _angleclamp180(var_3[1] - var_14[1]), 0));
  else
    self scragentsetorientmode("face angle abs", self.angles);

  self._id_92EA = gettime() * 0.001 + _getanimlength(var_11);
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_7, var_10, self._id_64C2, "move_start", "code_move");
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

_id_1E40(var_0, var_1, var_2, var_3) {
  var_4 = var_1 - var_3;
  var_5 = (0, var_4, 0);
  var_6 = anglesToForward(var_5);
  var_7 = anglestoright(var_5);
  var_8 = var_6 * var_2[0];
  var_9 = var_7 * var_2[1];
  return var_0 - (var_8 + var_9);
}

_id_574F(var_0) {
  switch (var_0) {
    case "left_foot":
    case "left_leg_lower":
    case "left_leg_upper":
    case "right_foot":
    case "right_leg_lower":
    case "right_leg_upper":
      return 1;
    default:
      return 0;
  }
}

_id_6ADB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!_id_0547::_id_4B2C() || !_id_054D::_id_8B9C()) {
    return;
  }
  if(!maps\mp\agents\_scripted_agent_anim_util::_id_57E2() && !common_scripts\utility::_id_562E(self._id_5382))
    thread _id_86D0(maps\mp\agents\humanoid\_humanoid_util::_id_29CB(var_6, var_7), self._id_0108, _id_574F(var_8));
}