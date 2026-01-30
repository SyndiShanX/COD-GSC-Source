/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\dog\_zombie_dog_move.gsc
***************************************************/

main() {
  self endon("killanimscript");
  self scragentsetphysicsmode("gravity");
  self.ismoving = 1;
  startmove();
  continuemovement();
}

end_script() {
  self.ismoving = undefined;
  cancelallbut(undefined);
  self scragentsetanimscale(1, 1);
}

setupmovement() {
  thread maps\mp\agents\humanoid\_humanoid_move::waitforrunwalkchange();
  thread waitforturn();
  thread waitforstop();
}

continuemovement() {
  setupmovement();
  self scragentsetanimmode("code_move");
  self scragentsetorientmode("face motion");
  self scragentsetanimscale(1, 1);
  setmoveanim(self.movemode);
}

setmoveanim(var_0) {
  self notify("zombiedogmove_endwait_setmoveanim");
  self endon("zombiedogmove_endwait_setmoveanim");
  self endon("killanimscript");
  var_1 = randomint(self getanimentrycount(var_0));
  maps\mp\agents\_scripted_agent_anim_util::set_anim_state(var_0, var_1, self.moveratescale);
}

doturn(var_0) {
  self notify("zombiedogmove_DoTurn");
  self endon("zombiedogmove_DoTurn");
  self endon("killanimscript");
  var_1 = "turn_" + self.movemode;
  var_2 = vectortoangles(var_0);
  var_3 = angleclamp180(var_2[1] - self.angles[1]);
  var_4 = self getanimentrycount(var_1);

  if(var_4 <= 0) {
    thread waitforturn();
    return;
  }

  var_5 = maps\mp\agents\_scripted_agent_anim_util::getangleindexvariable(var_3, var_4);

  if(var_5 == int(var_4 * 0.5)) {
    thread waitforturn();
    return;
  }

  var_6 = self getanimentry(var_1, var_5);
  var_7 = getangledelta(var_6);
  var_8 = (0, angleclamp180(var_2[1] - var_7), 0);

  if(!maps\mp\agents\humanoid\_humanoid_move::candoturnanim(var_6, var_8, var_5 == 3 || var_5 == 5, 1)) {
    thread waitforturn();
    return;
  }

  cancelallbut("turn");
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", var_8);
  maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_1, var_5, self.moveratescale, "turn");
  thread continuemovement();
}

waitforturn() {
  self notify("zombiedogmove_endwait_turn");
  self endon("zombiedogmove_endwait_turn");
  self waittill("path_dir_change", var_0);
  childthread doturn(var_0);
}

waitforstop() {
  self notify("zombiedogmove_endwait_stop");
  self endon("zombiedogmove_endwait_stop");
  self endon("killanimscript");
  self waittill("stop_soon");

  if(!maps\mp\zombies\_util::is_true(self.barrivalsenabled)) {
    thread waitforstop();
    return;
  }

  var_0 = "stop_" + self.movemode;
  var_1 = self getanimentrycount(var_0);

  if(var_1 <= 0) {
    thread waitforstop();
    return;
  }

  var_2 = 0;

  if(isDefined(self.node)) {
    var_2 = self.node.angles[1] - self.angles[1];
  }

  var_3 = maps\mp\agents\_scripted_agent_anim_util::getangleindexvariable(var_2, var_1);
  var_4 = self getanimentry(var_0, var_3);
  var_5 = getmovedelta(var_4);
  var_6 = getangledelta(var_4);
  var_7 = self getpathgoalpos();
  var_8 = var_7 - self.origin;

  if(length(var_8) + 12 < length(var_5)) {
    thread waitforstop();
    return;
  }

  var_9 = getstopdata();
  var_10 = calcanimstartpos(var_9.pos, var_9.angles[1], var_5, var_6);
  var_11 = maps\mp\zombies\_util::droppostoground(var_10);

  if(!isDefined(var_11)) {
    thread waitforstop();
    return;
  }

  if(!maps\mp\zombies\_util::canmovepointtopoint(var_9.pos, var_11)) {
    thread waitforstop();
    return;
  }

  cancelallbut("stop");
  thread waitforpathsetwhilestopping();
  thread waitforturnwhilestopping();

  if(distancesquared(var_10, self.origin) > 4) {
    self scragentsetwaypoint(var_10);
    thread waitforblockedwhilestopping();
    self waittill("waypoint_reached");
    self notify("zombiedogmove_endwait_blockedwhilestopping");
  }

  var_12 = var_7 - self.origin;
  var_13 = vectortoangles(var_12);
  var_14 = (0, var_13[1] - var_6, 0);
  var_15 = maps\mp\agents\_scripted_agent_anim_util::getanimscalefactors(var_7 - self.origin, var_5);
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", var_14, (0, var_13[1], 0));
  self scragentsetanimscale(var_15.xy, var_15.z);
  maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_0, var_3, self.moveratescale, "move_stop");
  self scragentsetgoalpos(self.origin);
}

waitforpathsetwhilestopping() {
  self notify("zombiedogmove_endwait_pathsetwhilestopping");
  self endon("zombiedogmove_endwait_pathsetwhilestopping");
  self endon("killanimscript");
  var_0 = self scragentgetgoalpos();
  self waittill("path_set");
  var_1 = self scragentgetgoalpos();

  if(distancesquared(var_0, var_1) < 1) {
    thread waitforpathsetwhilestopping();
    return;
  }

  self notify("zombiedogmove_endwait_stop");
  self notify("zombiedogmove_endwait_turnwhilestopping");
  thread continuemovement();
}

waitforturnwhilestopping() {
  self notify("zombiedogmove_endwait_turnwhilestopping");
  self endon("zombiedogmove_endwait_turnwhilestopping");
  self endon("killanimscript");
  self waittill("path_dir_change", var_0);
  self notify("zombiedogmove_endwait_pathsetwhilestopping");
  self notify("zombiedogmove_endwait_stop");
  thread doturn(var_0);
}

waitforblockedwhilestopping() {
  self notify("zombiedogmove_endwait_blockedwhilestopping");
  self endon("zombiedogmove_endwait_blockedwhilestopping");
  self endon("killanimscript");
  self waittill("path_blocked");
  self notify("zombiedogmove_endwait_stop");
  self scragentsetwaypoint(undefined);
}

cancelallbut(var_0) {
  var_1 = ["turn", "stop", "pathsetwhilestopping", "blockedwhilestopping", "turnwhilestopping", "setmoveanim", "modechange"];
  var_2 = isDefined(var_0);

  foreach(var_4 in var_1) {
    if(var_2 && var_4 == var_0) {
      continue;
    }
    self notify("zombiedogmove_endwait_" + var_4);
  }
}

startmove() {
  var_0 = self getnegotiationstartnode();

  if(isDefined(var_0)) {
    var_1 = var_0.origin;
  } else {
    var_1 = self getpathgoalpos();
  }

  if(distancesquared(var_1, self.origin) < 10000) {
    return;
  }
  var_2 = self getlookaheaddir();
  var_3 = vectortoangles(var_2);
  var_4 = self getvelocity();

  if(length2dsquared(var_4) > 16) {
    var_4 = vectornormalize(var_4);

    if(vectordot(var_4, var_2) > 0.707) {
      return;
    }
  }

  var_5 = "move_start";
  var_6 = angleclamp180(var_3[1] - self.angles[1]);
  var_7 = self getanimentrycount(var_5);

  if(var_7 == 0) {
    return;
  }
  var_8 = maps\mp\agents\_scripted_agent_anim_util::getangleindexvariable(var_6, var_7);
  var_9 = self getanimentry(var_5, var_8);
  var_10 = getmovedelta(var_9);
  var_11 = rotatevector(var_10, self.angles) + self.origin;

  if(!maps\mp\zombies\_util::canmovepointtopoint(self.origin, var_11, 0)) {
    return;
  }
  var_12 = getangledelta3d(var_9);
  self scragentsetanimmode("anim deltas");

  if(abs(var_8 - int(var_7 * 0.5)) <= 1) {
    self scragentsetorientmode("face angle abs", (0, angleclamp180(var_3[1] - var_12[1]), 0));
  } else {
    self scragentsetorientmode("face angle abs", self.angles);
  }

  maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_5, var_8, self.moveratescale, "move_start", "code_move");
}

getstopdata() {
  var_0 = spawnStruct();

  if(isDefined(self.node)) {
    var_0.pos = self.node.origin;
    var_0.angles = self.node.angles;
  } else {
    var_1 = self getpathgoalpos();
    var_0.pos = var_1;
    var_0.angles = vectortoangles(self getlookaheaddir());
  }

  return var_0;
}

calcanimstartpos(var_0, var_1, var_2, var_3) {
  var_4 = var_1 - var_3;
  var_5 = (0, var_4, 0);
  var_6 = anglesToForward(var_5);
  var_7 = anglestoright(var_5);
  var_8 = var_6 * var_2[0];
  var_9 = var_7 * var_2[1];
  return var_0 - var_8 + var_9;
}

dohitreaction(var_0, var_1) {
  cancelallbut(undefined);
  maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1, "DoHitReaction");
  var_2 = angleclamp180(var_0 - self.angles[1]);
  var_3 = "";
  var_4 = 0;

  if(isDefined(var_1) && var_1 == "boost_slam_mp" && var_2 < 45 && randomfloat(1) < 0.4) {
    var_3 = "pain_knockback_front";
    var_4 = 0;
  } else {
    var_3 = "run_pain";

    if(var_2 > 0) {
      var_4 = 1;
    } else {
      var_4 = 0;
    }
  }

  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack(var_3, var_4, self.nonmoveratescale, "pain_anim");
  maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "DoHitReaction");
  continuemovement();
}

ondamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(maps\mp\agents\_scripted_agent_anim_util::isstatelocked()) {
    return;
  }
  if(isDefined(var_7)) {
    var_10 = vectortoangles(var_7);
    var_11 = var_10[1] - 180;
    thread dohitreaction(var_11, var_5);
  }
}

onflashbanged(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(maps\mp\agents\_scripted_agent_anim_util::isstatelocked()) {
    return;
  }
  dohitreaction(self.angles[1] + 180);
}