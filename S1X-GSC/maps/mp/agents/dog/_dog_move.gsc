/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\dog\_dog_move.gsc
********************************************/

main() {
  self endon("killanimscript");
  self.blockgoalpos = 0;
  self scragentsetphysicsmode("gravity");
  startmove();
  continuemovement();
}

end_script() {
  self.blockgoalpos = 0;
  cancelallbut(undefined);
  self scragentsetanimscale(1, 1);
}

setupmovement() {
  thread waitforrunwalkchange();
  thread waitforsharpturn();
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
  self setanimstate(var_0);
}

waitforrunwalkchange() {
  self endon("dogmove_endwait_runwalk");
  var_0 = self.movemode;

  for(;;) {
    if(var_0 != self.movemode) {
      setmoveanim(self.movemode);
      var_0 = self.movemode;
    }

    wait 0.1;
  }
}

dosharpturn(var_0) {
  var_1 = vectortoangles(var_0);
  var_2 = angleclamp180(var_1[1] - self.angles[1]);
  var_3 = maps\mp\agents\_scriptedagents::getangleindex(var_2);

  if(var_3 == 4) {
    continuemovement();
    return;
  }

  var_4 = "sharp_turn";
  var_5 = self getanimentry(var_4, var_3);
  var_6 = getangledelta(var_5);
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", (0, angleclamp180(var_1[1] - var_6), 0));
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_4, var_3, "sharp_turn");
  continuemovement();
}

waitforsharpturn() {
  self endon("dogmove_endwait_sharpturn");
  self waittill("path_dir_change", var_0);
  cancelallbut("sharpturn");
  dosharpturn(var_0);
}

waitforstop() {
  self endon("dogmove_endwait_stop");
  self waittill("stop_soon");

  if(isDefined(self.barrivalsenabled) && !self.barrivalsenabled) {
    thread waitforstop();
    return;
  }

  var_0 = getstopanimstate();
  var_1 = self getanimentry(var_0.state, var_0.index);
  var_2 = getmovedelta(var_1);
  var_3 = getangledelta(var_1);
  var_4 = self getpathgoalpos();
  var_5 = var_4 - self.origin;

  if(length(var_5) + 12 < length(var_2)) {
    thread waitforstop();
    return;
  }

  var_6 = getstopdata();
  var_7 = calcanimstartpos(var_6.pos, var_6.angles[1], var_2, var_3);
  var_8 = maps\mp\agents\_scriptedagents::droppostoground(var_7);

  if(!isDefined(var_8)) {
    thread waitforstop();
    return;
  }

  if(!maps\mp\agents\_scriptedagents::canmovepointtopoint(var_6.pos, var_8)) {
    thread waitforstop();
    return;
  }

  cancelallbut("stop");
  thread waitforpathsetwhilestopping();
  thread waitforsharpturnwhilestopping();

  if(distancesquared(var_7, self.origin) > 4) {
    self scragentsetwaypoint(var_7);
    thread waitforblockedwhilestopping();
    self waittill("waypoint_reached");
    self notify("dogmove_endwait_blockedwhilestopping");
  }

  var_9 = var_4 - self.origin;
  var_10 = vectortoangles(var_9);
  var_11 = (0, var_10[1] - var_3, 0);
  var_12 = maps\mp\agents\_scriptedagents::getanimscalefactors(var_4 - self.origin, var_2);
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", var_11, (0, var_10[1], 0));
  self scragentsetanimscale(var_12.xy, var_12.z);
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_0.state, var_0.index, "move_stop");
  self scragentsetgoalpos(self.origin);
}

waitforpathsetwhilestopping() {
  self endon("killanimscript");
  self endon("dogmove_endwait_pathsetwhilestopping");
  var_0 = self scragentgetgoalpos();
  self waittill("path_set");
  var_1 = self scragentgetgoalpos();

  if(distancesquared(var_0, var_1) < 1) {
    thread waitforpathsetwhilestopping();
    return;
  }

  self notify("dogmove_endwait_stop");
  self notify("dogmove_endwait_sharpturnwhilestopping");
  continuemovement();
}

waitforsharpturnwhilestopping() {
  self endon("killanimscript");
  self endon("dogmove_endwait_sharpturnwhilestopping");
  self waittill("path_dir_change", var_0);
  self notify("dogmove_endwait_pathsetwhilestopping");
  self notify("dogmove_endwait_stop");
  dosharpturn(var_0);
}

waitforblockedwhilestopping() {
  self endon("killanimscript");
  self endon("dogmove_endwait_blockedwhilestopping");
  self waittill("path_blocked");
  self notify("dogmove_endwait_stop");
  self scragentsetwaypoint(undefined);
}

waitforstopearly() {
  self endon("killanimscript");
  self endon("dogmove_endwait_stopearly");
  var_0 = self getanimentry("move_stop_4", 0);
  var_1 = getmovedelta(var_0);
  var_2 = length(var_1);
  var_3 = self.preferredoffsetfromowner + var_2;
  var_4 = var_3 * var_3;

  if(distancesquared(self.origin, self.owner.origin) <= var_4) {
    return;
  }
  for(;;) {
    if(!isDefined(self.owner)) {
      break;
    }

    if(distancesquared(self.origin, self.owner.origin) < var_4) {
      var_5 = self localtoworldcoords(var_1);
      self scragentsetgoalpos(var_5);
      break;
    }

    wait 0.1;
  }
}

cancelallbut(var_0) {
  var_1 = ["runwalk", "sharpturn", "stop", "pathsetwhilestopping", "blockedwhilestopping", "sharpturnwhilestopping", "stopearly"];
  var_2 = isDefined(var_0);

  foreach(var_4 in var_1) {
    if(var_2 && var_4 == var_0) {
      continue;
    }
    self notify("dogmove_endwait_" + var_4);
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

  var_5 = angleclamp180(var_3[1] - self.angles[1]);
  var_6 = maps\mp\agents\_scriptedagents::getangleindex(var_5);
  var_7 = self getanimentry("move_start", var_6);
  var_8 = getmovedelta(var_7);
  var_9 = rotatevector(var_8, self.angles) + self.origin;

  if(!maps\mp\agents\_scriptedagents::canmovepointtopoint(self.origin, var_9)) {
    return;
  }
  var_10 = getangledelta3d(var_7);
  self scragentsetanimmode("anim deltas");

  if(3 <= var_6 && var_6 <= 5) {
    self scragentsetorientmode("face angle abs", (0, angleclamp180(var_3[1] - var_10[1]), 0));
  } else {
    self scragentsetorientmode("face angle abs", self.angles);
  }

  self.blockgoalpos = 1;
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("move_start", var_6, "move_start");
  self.blockgoalpos = 0;
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

getstopanimstate(var_0) {
  if(isDefined(self.node)) {
    var_1 = self.node.angles[1] - self.angles[1];
    var_2 = maps\mp\agents\_scriptedagents::getangleindex(var_1);
  } else {
    var_2 = 4;
  }

  var_3 = spawnStruct();
  var_3.state = "move_stop";
  var_3.index = var_2;
  return var_3;
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

dog_addlean() {
  var_0 = clamp(self.leanamount / 25.0, -1, 1);

  if(var_0 > 0) {
    return;
  }
  return;
}

handlefootstepnotetracks(var_0, var_1, var_2, var_3) {
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

      if(isDefined(self.surfacetype)) {
        var_4 = self.surfacetype;
        self.lastsurfacetype = var_4;
      } else if(isDefined(self.lastsurfacetype)) {
        var_4 = self.lastsurfacetype;
      } else {
        var_4 = "dirt";
      }

      if(var_4 != "dirt" && var_4 != "concrete" && var_4 != "wood" && var_4 != "metal") {
        var_4 = "dirt";
      }

      if(var_4 == "concrete") {
        var_4 = "cement";
      }

      if(self.aistate == "traverse") {
        var_5 = "land";
      } else if(self.movemode == "sprint") {
        var_5 = "sprint";
      } else if(self.movemode == "fastwalk") {
        var_5 = "walk";
      } else {
        var_5 = "run";
      }

      self playsoundonmovingent("dogstep_" + var_5 + "_" + var_4);

      if(issubstr(var_0, "front_left")) {
        var_6 = "anml_dog_mvmt_accent";
        var_7 = "anml_dog_mvmt_vest";

        if(var_5 == "walk") {
          var_8 = "_npc";
        } else {
          var_8 = "_run_npc";
        }

        self playsoundonmovingent(var_6 + var_8);
        self playsoundonmovingent(var_7 + var_8);
      }

      return 1;
  }

  return 0;
}

dohitreaction(var_0) {
  cancelallbut(undefined);
  self.blockgoalpos = 1;
  self.statelocked = 1;
  var_1 = angleclamp180(var_0 - self.angles[1]);

  if(var_1 > 0) {
    var_2 = 1;
  } else {
    var_2 = 0;
  }

  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("run_pain", var_2, "run_pain");
  self.blockgoalpos = 0;
  self.statelocked = 0;
  continuemovement();
}

ondamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(self.statelocked) {
    return;
  }
  var_10 = vectortoangles(var_7);
  var_11 = var_10[1] - 180;
  dohitreaction(var_11);
}

onflashbanged(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(self.statelocked) {
    return;
  }
  dohitreaction(self.angles[1] + 180);
}