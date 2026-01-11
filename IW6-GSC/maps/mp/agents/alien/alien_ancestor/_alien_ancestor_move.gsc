/************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\alien_ancestor\_alien_ancestor_move.gsc
************************************************************************/

main() {
  self endon("killanimscript");
  entermove();
  startmove();
  continuemovement();
}

entermove() {
  self.blockgoalpos = 0;
  self.playing_pain_animation = 0;
  self.is_moving = 1;
  self scragentsetphysicsmode("gravity");
  self scragentsetanimmode("code_move");
}

startmove() {
  if(candostartmove()) {
    switch (getstartmovetype()) {
      case "run-start":
        dorunstart();
        break;
      case "walk-start":
        dowalkstart();
        break;
      default:
        break;
    }
  }
}

end_script() {
  self.blockgoalpos = 0;
  self.playing_pain_animation = 0;
  cancelallbut(undefined);
  self scragentsetanimscale(1, 1);
  self.previousanimstate = "move";
}

setupmovement() {
  self.enablestop = 1;
  thread waitformovemodechange();
  thread waitforsharpturn();
  thread waitforstop();
  thread waitforstuck();
}

continuemovement() {
  self scragentsetorientmode("face motion");
  self scragentsetanimmode("code_move");
  self scragentsetanimscale(self.xyanimscale, 1.0);
  setupmovement();
  setmoveanim(self.movemode);
}

waitformovemodechange() {
  self endon("killanimscript");
  self endon("alienmove_endwait_runwalk");
  var_0 = self.movemode;

  for(;;) {
    if(var_0 != self.movemode) {
      setmoveanim(self.movemode);
      var_0 = self.movemode;
    }

    wait 0.1;
  }
}

waitforsharpturn() {
  self endon("killanimscript");
  self endon("alienmove_endwait_sharpturn");
  self waittill("path_dir_change", var_0);
  var_1 = maps\mp\agents\_scriptedagents::getangleindexfromselfyaw(var_0);

  if(var_1 == 4) {
    thread waitforsharpturn();
    return;
  }

  var_2 = 0;

  if(var_2) {
    var_1 = 0;
  }

  var_3 = "run_turn";
  var_4 = self getanimentry(var_3, var_1);
  var_5 = var_2 || candoturnanim(var_4);

  if(!var_5) {
    thread waitforsharpturn();
    return;
  }

  cancelallbut("sharpturn");
  self.blockgoalpos = 1;
  self.enablestop = 0;

  if(var_2) {
    maps\mp\agents\alien\_alien_anim_utils::turntowardsvector(self getlookaheaddir());
  }

  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack(var_3, var_1, self.moveplaybackrate, var_3, "code_move");
  self scragentsetorientmode("face motion");
  self.blockgoalpos = 0;
  thread continuemovement();
}

waitforstop() {
  self endon("killanimscript");
  self endon("alienmove_endwait_stop");
  self waittill("stop_soon");

  if(!shoulddostopanim()) {
    thread waitforstop();
  }
  else {
    var_0 = self getpathgoalpos();
    playstopanimation(var_0, 1);
    maps\mp\agents\alien\_alien_anim_utils::turntowardsvector(self getlookaheaddir());
    var_0 = self getpathgoalpos();

    if(distancesquared(self.origin, var_0) < 400.0) {
      self.is_moving = 0;
      self scragentsetanimmode("code_move_slide");
      return;
      return;
    }

    startmove();
    continuemovement();
  }
}

shouldrestartstop() {
  return self.currentanimstate == "move";
}

playstopanimation(var_0, var_1) {
  var_2 = shouldrestartstop();

  if(!isDefined(var_0)) {
    if(shouldrestartstop()) {
      thread waitforstop();
    }

    return;
  }

  var_3 = var_0 - self.origin;
  var_4 = getstopendfacedir(var_0);
  var_5 = getstopanimstate();
  var_6 = getstopanimindex(var_5, var_4);
  var_7 = self getanimentry(var_5, var_6);
  var_8 = getmovedelta(var_7);
  var_9 = getangledelta(var_7);

  if(length(var_3) + 48 < length(var_8)) {
    if(var_2) {
      thread waitforstop();
    }

    return;
  }

  var_10 = getstopdata(var_0);
  var_11 = calcanimstartpos(var_10.pos, var_10.angles[1], var_8, var_9);
  var_12 = maps\mp\agents\_scriptedagents::droppostoground(var_11);

  if(!isDefined(var_12)) {
    if(var_2) {
      thread waitforstop();
    }

    return;
  }

  if(!maps\mp\agents\_scriptedagents::canmovepointtopoint(var_10.pos, var_12)) {
    if(var_2) {
      thread waitforstop();
    }

    return;
  }

  if(var_2) {
    cancelallbut("stop", "sharpturn");
    thread waitforpathset("alienmove_endwait_pathsetwhilestopping", "alienmove_endwait_stop");
  }

  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", vectortoangles(var_3));

  if(var_1) {
    var_13 = maps\mp\agents\_scriptedagents::getanimscalefactors(var_0 - self.origin, var_8);
    self scragentsetanimscale(var_13.xy, var_13.z);
  }

  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_5, var_6, var_5, "end");
  self scragentsetanimscale(1.0, 1.0);
}

getstopendfacedir(var_0) {
  if(isDefined(self.enemy)) {
    return self.enemy.origin - var_0;
  }

  return var_0 - self.origin;
}

getstopanimstate() {
  switch (self.movemode) {
    case "jog":
    case "run":
      return "run_stop";
    case "walk":
      return "walk_stop";
    default:
  }
}

getstopanimindex(var_0, var_1) {
  switch (var_0) {
    case "walk_stop":
      return 0;
    case "run_stop":
      return maps\mp\agents\_scriptedagents::getangleindexfromselfyaw(var_1);
  }
}

waitforpathset(var_0, var_1) {
  self endon("killanimscript");
  self endon(var_0);
  var_2 = self scragentgetgoalpos();
  self waittill("path_set");
  var_3 = self scragentgetgoalpos();

  if(distancesquared(var_2, var_3) < 1) {
    thread waitforpathset(var_0, var_1);
    return;
  }

  self notify(var_1);
  continuemovement();
}

setmoveanim(var_0) {
  if(var_0 == "run") {
    var_1 = self getanimentrycount("run");
    var_2 = [20, 80];
    var_3 = maps\mp\alien\_utility::getrandomindex(var_2);
    self setanimstate("run", var_3, self.moveplaybackrate);
  } else if(var_0 == "walk") {
    var_4 = undefined;
    self setanimstate("walk", var_4, self.moveplaybackrate);
  } else {}
}

cancelallbut(var_0, var_1) {
  var_2 = ["runwalk", "sharpturn", "stop", "pathsetwhilestopping", "jumpsoon", "pathsetwhilejumping", "pathset", "nearmiss", "dodgechance", "stuck"];
  var_3 = isDefined(var_0);
  var_4 = isDefined(var_1);

  foreach(var_6 in var_2) {
    if(var_3 && var_6 == var_0) {
      continue;
    }
    if(var_4 && var_6 == var_1) {
      continue;
    }
    self notify("alienmove_endwait_" + var_6);
  }
}

getstopdata(var_0) {
  var_1 = spawnStruct();

  if(isDefined(self.node)) {
    var_1.pos = self.node.origin;
    var_1.angles = self.node.angles;
  } else if(isDefined(self.enemy)) {
    var_1.pos = var_0;
    var_1.angles = vectortoangles(self.enemy.origin - var_0);
  } else {
    var_1.pos = var_0;
    var_1.angles = self.angles;
  }

  return var_1;
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

onflashbanged() {
  dostumble();
}

ondamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(maps\mp\alien\_utility::is_pain_available(var_1, var_4)) {
    dostumble(var_3, var_7, var_8, var_2, var_4, var_1);
  }
}

dostumble(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("killanimscript");

  if(self.playing_pain_animation) {
    return;
  }
  cancelallbut(undefined);
  self.statelocked = 1;
  self.playing_pain_animation = 1;
  var_6 = "move_pain";
  var_7 = randomint(self getanimentrycount(var_6));
  var_8 = self getanimentry(var_6, var_7);
  maps\mp\alien\_utility::always_play_pain_sound(var_8);
  maps\mp\alien\_utility::register_pain(var_8);
  self scragentsetorientmode("face angle abs", self.angles);
  self scragentsetanimmode("anim deltas");
  maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack(var_6, var_7, self.moveplaybackrate, var_6, "code_move");
  self.playing_pain_animation = 0;
  self.statelocked = 0;

  if(shouldstartmove()) {
    startmove();
  }

  continuemovement();
}

waitforstuck() {
  self endon("killanimscript");
  self endon("alienmove_endwait_stuck");
  var_0 = 2000.0;
  var_1 = gettime() + var_0;
  var_2 = self.origin;
  var_3 = 1.0;

  for(;;) {
    var_4 = gettime();
    var_5 = length(self.origin - var_2);

    if(var_5 > var_3) {
      var_1 = var_4 + var_0;
    }

    if(var_1 <= var_4) {
      stucklerp();
      var_1 = var_4 + var_0;
      break;
    }

    var_2 = self.origin;
    wait 0.1;
  }

  continuemovement();
}

stucklerp() {
  self endon("killanimscript");
  self endon("alienmove_endwait_stuck");
  self endon("death");
  var_0 = 0.2;
  cancelallbut("stuck");
  var_1 = self getanimentry();
  var_2 = getanimlength(var_1);
  var_3 = length(getmovedelta(var_1));
  var_4 = var_0 / var_2 * var_3;
  var_5 = self getlookaheaddir();
  var_6 = self.origin + var_5 * var_4;
  self scragentsetphysicsmode("noclip");
  self scragentsetorientmode("face angle abs", vectortoangles(var_5));
  self scragentdoanimlerp(self.origin, var_6, var_0);
  wait(var_0);
  self setorigin(self.origin);
}

dowalkstart() {
  var_0 = "walk_start";
  var_1 = maps\mp\agents\_scriptedagents::getrandomanimentry(var_0);
  var_2 = self getlookaheaddir();

  if(isDefined(self.pathnode)) {
    var_2 = vectornormalize(self.pathnode.origin - self.origin);
  }

  maps\mp\agents\alien\_alien_anim_utils::turntowardsvector(var_2);
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  self.blockgoalpos = 1;
  maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack(var_0, var_1, self.moveplaybackrate, var_0, "code_move");
  self scragentsetorientmode("face motion");
  self.blockgoalpos = 0;
}

dorunstart() {
  var_0 = self getnegotiationstartnode();

  if(isDefined(var_0)) {
    var_1 = var_0.origin;
  }
  else {
    var_1 = self getpathgoalpos();
  }

  if(!isDefined(var_1)) {
    return;
  }
  if(distancesquared(var_1, self.origin) < 10000) {
    return;
  }
  dostartmoveanim("run_start");
}

dostartmoveanim(var_0) {
  var_1 = 0;
  maps\mp\agents\alien\_alien_anim_utils::turntowardsvector(self getlookaheaddir());
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  self.blockgoalpos = 1;
  maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack(var_0, var_1, self.moveplaybackrate, var_0, "code_move");
  self scragentsetorientmode("face motion");
  self.blockgoalpos = 0;
}

candostartmove() {
  if(!isDefined(self.skipstartmove)) {
    return 1;
  }
  else {
    return 0;
  }
}

getstartmovetype() {
  switch (self.movemode) {
    case "run":
      return "run-start";
    case "walk":
      return "walk-start";
    default:
      return "run-start";
  }
}

shoulddostopanim() {
  return isDefined(self.enablestop) && self.enablestop == 1;
}

candoturnanim(var_0) {
  var_1 = 16;
  var_2 = 10;
  var_3 = (0, 0, 16);

  if(!isDefined(self getpathgoalpos())) {
    return 0;
  }

  var_4 = getnotetracktimes(var_0, "code_move");
  var_5 = var_4[0];
  var_6 = getmovedelta(var_0, 0, var_5);
  var_7 = self localtoworldcoords(var_6);
  var_7 = getgroundposition(var_7, self.radius);

  if(!isDefined(var_7)) {
    return 0;
  }

  var_8 = self aiphysicstracepassed(self.origin + var_3, var_7 + var_3, self.radius - var_2, self.height - var_1);

  if(var_8) {
    return 1;
  }
  else {
    return 0;
  }
}

shouldstartmove() {
  var_0 = getstartmoveangleindex();
  return var_0 < 3 || var_0 > 5;
}

getstartmoveangleindex() {
  return maps\mp\agents\_scriptedagents::getangleindexfromselfyaw(self getlookaheaddir());
}