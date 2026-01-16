/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\dog\dog_move.gsc
****************************************/

main() {
  if(isDefined(level.shark_functions)) {
    if(issubstr(self.model, "shark")) {
      self[[level.shark_functions["move"]]]();
      return;
    }
  }

  self.sharpturnlookaheaddist = 48;
  self.postsharpturnlookaheaddist = 100;
  self.sharpturntooclosetodestdist = 72;
  self endon("killanimscript");
  thread handlefootstepnotetracks();

  if(self isdogbeingdriven())
    continuedrivenmovement();
  else {
    startmove();
    continuemovement();
  }
}

end_script() {
  if(isDefined(self.prevturnrate)) {
    self.turnrate = self.prevturnrate;
    self.prevturnrate = undefined;
  }

  if(isDefined(self.moveoverridesound)) {
    stopmovesound();
    self.moveoverridesound = undefined;
  }

  self.drivenmovemode = undefined;
  self.bsharpturnduringsharpturn = undefined;
  cancelallbut(undefined);
}

setupmovement() {
  thread waitfordrivenchange();
  thread waitforrunwalkslopechange();
  thread waitforratechange();
  thread waitforbark();
  thread waitforsharpturn();
  thread waitforstop();
  thread waitforfollowspeed();
}

#using_animtree("dog");

continuemovement() {
  self.moveratemultiplier = 1;
  setupmovement();
  self animmode("none");
  self orientmode("face motion");
  self clearanim( % body, 0.2);
  setmoveanim(self.movemode, self.stairsstate, 1);
}

continuedrivenmovement() {
  self clearanim( % body, 0.5);
  self.drivenmovemode = getdesireddrivenmovemode("walk");
  setdrivenanim(self.drivenmovemode, 1);
  thread waitfordrivenchange();
  thread drivenanimupdate();
}

startturntoangle(var_0, var_1) {
  self clearanim( % body, 0.2);
  animscripts\dog\dog_stop::turntoangle(var_0, var_1);
}

startmove() {
  self.bfirstmoveanim = 1;
  var_0 = self getnegotiationstartnode();

  if(isDefined(var_0))
    var_1 = var_0.origin;
  else
    var_1 = self.pathgoalpos;

  if(!isDefined(var_1)) {
    return;
  }
  if(isDefined(self.disableexits) && self.disableexits) {
    return;
  }
  if(self isdogbeingdriven()) {
    return;
  }
  var_2 = vectortoangles(self.lookaheaddir);
  var_3 = angleclamp180(var_2[1] - self.angles[1]);

  if(isDefined(self.bdoturnandmove) && self.bdoturnandmove || isDefined(self.movementtype) && (self.movementtype == "walk" || self.movementtype == "walk_fast" || self.movementtype == "sniff")) {
    if(abs(var_3) > 25)
      startturntoangle(var_2[1], 1);

    return;
  }

  if(length2dsquared(self.velocity) > 16) {
    var_4 = vectortoangles(self.velocity);

    if(abs(angleclamp180(var_4[1] - var_2[1])) < 45)
      return;
  }

  if(distancesquared(var_1, self.origin) < 22500) {
    if(abs(var_3) > 25)
      startturntoangle(var_2[1], 1);

    return;
  }

  var_5 = getdogmoveanim("run_start");
  var_6 = getangleindices(var_3);
  var_7 = undefined;

  for(var_8 = 0; var_8 < var_6.size; var_8++) {
    var_9 = var_6[var_8];
    var_7 = var_5[var_9];
    var_10 = getmovedelta(var_7);
    var_11 = rotatevector(var_10, self.angles) + self.origin;

    if(self maymovefrompointtopoint(self.origin, var_11, 1, 1)) {
      break;
    }
  }

  if(var_8 == var_6.size) {
    if(abs(var_3) > 25)
      startturntoangle(var_2[1], 1);

    return;
  }

  self.moveanimtype = "run";
  var_12 = getnotetracktimes(var_7, "code_move");
  var_13 = 1;

  if(var_12.size > 0)
    var_13 = var_12[0];

  var_14 = getangledelta3d(var_7, 0, var_13);
  self animmode("zonly_physics", 0);
  self orientmode("face angle", angleclamp180(var_2[1] - var_14[1]));
  var_15 = getanimlength(var_7) * var_13;
  var_16 = 0.01 + abs(angleclamp180(var_3 - var_14[1])) / var_15 / 1000;

  if(var_16 < 0.01)
    var_16 = 0.01;

  self.prevturnrate = self.turnrate;
  self.turnrate = var_16;
  var_17 = 0.1;

  if(animscripts\dog\dog_stop::getdefaultidlestate() != "attackidle")
    var_17 = 0.4;

  self setflaggedanimknoballrestart("dog_start_move", var_7, % body, 1, var_17, self.moveplaybackrate);
  thread startmove_updateangle(var_7, var_13, var_15);
  animscripts\shared::donotetracks("dog_start_move");
  self notify("end_startmove_updateangle");
  self.turnrate = self.prevturnrate;
  self.prevturnrate = undefined;
  self animmode("none", 0);
  self orientmode("face motion");
}

startmove_updateangle(var_0, var_1, var_2) {
  self endon("killanimscript");
  self endon("end_startmove_updateangle");
  wait 0.05;

  for(;;) {
    var_3 = self getanimtime(var_0);
    var_4 = vectortoangles(self.lookaheaddir);
    var_5 = getangledelta3d(var_0, var_3, var_1);
    var_6 = angleclamp180(var_4[1] - self.angles[1]);
    self orientmode("face angle", angleclamp180(var_4[1] - var_5[1]));
    self.turnrate = 0.01 + abs(angleclamp180(var_6 - var_5[1])) / var_2 / 1000;

    if(self.turnrate < 0.01)
      self.turnrate = 0.01;

    wait 0.05;
  }
}

startdrivenmovement() {
  var_0 = getdogmoveanim("run_start");
  var_1 = var_0[4];
  self setflaggedanimknoballrestart("dog_start_move", var_1, % body);
  animscripts\shared::donotetracks("dog_start_move");
}

waitfordrivenchange() {
  self endon("dogmove_endwait_drivenchange");
  self endon("killanimscript");
  var_0 = self isdogbeingdriven();

  for(;;) {
    var_1 = self isdogbeingdriven();

    if(var_0 != var_1) {
      cancelallbut("drivenchange");

      if(var_1)
        continuedrivenmovement();
      else
        continuemovement();

      break;
    }

    wait 0.2;
  }
}

waitforrunwalkslopechange() {
  self endon("dogmove_endwait_runwalkslope");
  self endon("killanimscript");
  var_0 = self.movemode;
  var_1 = self.stairsstate;
  var_2 = self.run_overrideanim;
  var_3 = self.walk_overrideanim;
  var_4 = self.movementtype;

  for(;;) {
    if(var_0 != self.movemode || var_1 != self.stairsstate || hasmovementtypechanged(var_4) || hasoverrideanimchanged(var_2, var_3)) {
      self clearanim( % dog_move, 0.2);

      if(isDefined(self.script_nostairs))
        setmoveanim(self.movemode, "none", 1);
      else
        setmoveanim(self.movemode, self.stairsstate, 1);

      var_0 = self.movemode;
      var_1 = self.stairsstate;
      var_2 = self.run_overrideanim;
      var_3 = self.walk_overrideanim;
      var_4 = self.movementtype;
    }

    wait 0.1;
  }
}

waitforratechange() {
  self endon("dogmove_endwait_ratechange");
  self endon("killanimscript");
  var_0 = self.moveplaybackrate;
  var_1 = self.moveratemultiplier;

  for(;;) {
    if(var_0 != self.moveplaybackrate || var_1 != self.moveratemultiplier) {
      setmoveanim(self.movemode, self.stairsstate, 0);
      var_0 = self.moveplaybackrate;
      var_1 = self.moveratemultiplier;
    }

    wait 0.1;
  }
}

waitforsharpturn() {
  self endon("dogmove_endwait_sharpturn");
  self endon("killanimscript");
  self waittill("path_changed", var_0, var_1, var_2);
  var_3 = dosharpturn(var_1, var_2);

  if(!var_3)
    thread waitforsharpturn();
}

shoulddosharpturns() {
  if(isDefined(self.script_noturnanim) || self isdogbeingdriven())
    return 0;

  if(isDefined(self.movementtype) && (self.movementtype == "walk" || self.movementtype == "walk_fast"))
    return 0;

  if(self.stairsstate == "down")
    return 0;

  return 1;
}

dosharpturn(var_0, var_1) {
  if(!shoulddosharpturns())
    return 0;

  var_2 = 10;

  if(var_1)
    var_2 = 30;

  var_3 = vectortoangles(var_0);
  var_4 = angleclamp180(var_3[1] - self.angles[1]);
  var_5 = getangleindex(var_4, var_2);

  if(var_5 == 4)
    return 0;

  cancelallbut("sharpturn");
  thread waitforsharpturnduringsharpturn();

  if(shouldsniff()) {
    var_6 = getdogmoveanim("sniff_turn");

    if(var_5 < 4)
      var_7 = var_6[2];
    else
      var_7 = var_6[6];
  } else
    var_7 = getdogturnanim("quick_sharp_turn", var_5);

  var_8 = getnotetracktimes(var_7, "code_move");
  var_9 = 1;

  if(var_8.size > 0)
    var_9 = var_8[0];

  var_10 = getangledelta(var_7, 0, var_9);
  var_11 = getanimlength(var_7) * var_9;
  var_12 = abs(var_4 - var_10) / var_11 / 1000;

  if(var_12 < 0.01)
    var_12 = 0.01;

  self.prevturnrate = self.turnrate;
  self.turnrate = var_12;
  self clearanim( % dog_move, 0.1);
  self animmode("zonly_physics", 0);
  self orientmode("face angle", angleclamp180(var_3[1] - var_10));
  self setflaggedanimknoballrestart("dog_sharp_turn", var_7, % body, 1, 0.2, self.moveplaybackrate);
  animscripts\shared::donotetracks("dog_sharp_turn");
  self clearanim( % dog_move_turn, 0.2);
  self.turnrate = self.prevturnrate;
  self.prevturnrate = undefined;
  self notify("dogmove_endwait_sharpturnduringsharpturn");

  if(isDefined(self.bsharpturnduringsharpturn)) {
    self.bsharpturnduringsharpturn = undefined;

    if(!dosharpturn(self.lookaheaddir, 1))
      continuemovement();
  } else
    continuemovement();

  return 1;
}

waitforsharpturnduringsharpturn() {
  self endon("dogmove_endwait_sharpturnduringsharpturn");
  self endon("killanimscript");

  for(;;) {
    self waittill("path_changed", var_0, var_1, var_2);

    if(var_2)
      self.bsharpturnduringsharpturn = 1;
  }
}

shoulddoarrivals() {
  if(isDefined(self.disablearrivals) && self.disablearrivals)
    return 0;

  if(self isdogbeingdriven())
    return 0;

  if(isDefined(self.movementtype) && (self.movementtype == "walk" || self.movementtype == "walk_fast"))
    return 0;

  return 1;
}

waitforstop() {
  self endon("dogmove_endwait_stop");
  self endon("killanimscript");
  self.stopanimdistsq = anim.dogstoppingdistsq;
  self waittill("stop_soon");

  if(!shoulddoarrivals()) {
    return;
  }
  var_0 = self.pathgoalpos;

  if(!isDefined(var_0)) {
    thread waitforstop();
    return;
  }

  var_1 = getarrivalnode();

  if(isDefined(var_1) && var_1.type != "Path") {
    var_2 = angleclamp180(var_1.angles[1] - self.angles[1]);
    var_3 = getangleindex(var_2);
  } else {
    var_4 = var_0 - self.origin;
    var_5 = vectortoangles(var_4);
    var_2 = angleclamp180(var_5[1] - self.angles[1]);
    var_3 = getangleindex(var_2);
  }

  var_6 = getdogmoveanim("run_stop");
  var_7 = animscripts\dog\dog_stop::getdefaultidlestate(0);

  if(var_7 == "attackidle")
    var_8 = "attack";
  else if(var_7 == "sneakidle" && var_3 == 4)
    var_8 = "sneak";
  else if(var_7 == "alertidle" || var_7 == "sneakidle")
    var_8 = "alert";
  else
    var_8 = "casual";

  var_9 = var_6[var_8][var_3];

  if(!isDefined(var_9)) {
    thread waitforstop();
    return;
  }

  var_10 = getmovedelta(var_9);
  var_11 = getangledelta(var_9);
  var_12 = var_0 - self.origin;

  if(length(var_12) < length(var_10)) {
    thread waitforstop();
    return;
  }

  var_13 = getstopdata();
  var_14 = calcanimstartpos(var_13.pos, var_13.angles[1], var_10, var_11);
  var_15 = droppostoground(var_14);

  if(!isDefined(var_15)) {
    thread waitforstop();
    return;
  }

  if(!self maymovefrompointtopoint(var_13.pos, var_15)) {
    thread waitforstop();
    return;
  }

  cancelallbut("stop");

  if(distancesquared(var_14, self.origin) > 4) {
    thread waitforpathsetwhilestopping();
    self setruntopos(var_14);
    self waittill("runto_arrived");
    self notify("dogmove_endwait_pathsetwhilestopping");
  }

  if(!shoulddoarrivals()) {
    continuemovement();
    return;
  }

  stopmovesound();

  if(isDefined(var_1) && var_1.type != "Path")
    var_16 = var_1.angles;
  else {
    var_17 = var_0 - self.origin;
    var_16 = vectortoangles(var_17);
  }

  if(var_3 == 0 || var_3 == 1 || var_3 == 7 || var_3 == 8)
    var_18 = (0, var_13.angles[1] - var_11, 0);
  else
    var_18 = (0, var_16[1] - var_11, 0);

  self.dogarrivalanim = var_9;
  self startcoverarrival(var_14, var_18[1], 0);
}

waitforpathsetwhilestopping() {
  self endon("killanimscript");
  self endon("dogmove_endwait_pathsetwhilestopping");
  var_0 = self.goalpos;
  self waittill("path_set");
  var_1 = self.goalpos;

  if(distance2dsquared(var_0, var_1) < 1) {
    thread waitforpathsetwhilestopping();
    return;
  }

  cancelallbut("pathsetwhilestopping");
  continuemovement();
}

waitforbark() {
  self endon("killanimscript");
  self endon("dogmove_endwait_bark");
  var_0 = 0.3;
  var_1 = var_0;

  for(;;) {
    if(isDefined(self.script_nobark) && self.script_nobark)
      var_1 = var_0;
    else if(isDefined(self.enemy)) {
      self playSound("anml_dog_bark");
      var_1 = 2 + randomint(1);
    } else
      var_1 = var_0;

    wait(var_1);
  }
}

waitforfollowspeed() {
  self endon("killanimscript");
  self endon("dogmove_endwait_followspeed");
  var_0 = 128;
  var_1 = 0.6;
  var_2 = -30;
  var_3 = 30;
  self.moveratemultiplier = 1;

  for(;;) {
    var_4 = self.moveratemultiplier;
    self.moveratemultiplier = 1;

    if(self isdogfollowinghandler() && self.movemode == "run") {
      if(isDefined(self.doghandler.pathgoalpos)) {
        var_5 = self.origin - self.doghandler.origin;
        var_6 = lengthsquared(var_5);

        if(var_6 < var_0 * var_0) {
          var_7 = vectordot(self.doghandler.lookaheaddir, var_5);

          if(var_7 > var_3)
            self.moveratemultiplier = lerp(var_1, 1, lerpfraction(var_3, var_0, var_7));
          else if(var_7 > var_2)
            self.moveratemultiplier = var_1;
          else
            self.moveratemultiplier = lerp(var_1, 1, lerpfraction(var_2, -1 * var_0, var_7));
        }
      }
    } else {
      var_8 = 1;
      var_9 = self getdogavoident();

      if(isDefined(var_9)) {
        var_10 = var_9.origin - self.origin;
        var_11 = anglesToForward(self.angles);
        var_12 = vectordot(var_11, var_10);

        if(var_12 > 0) {
          if(isplayer(var_9))
            var_13 = lengthsquared(var_9 getentityvelocity());
          else
            var_13 = lengthsquared(var_9.velocity);

          var_14 = anglesToForward(var_9.angles);
          var_15 = 0.5;

          if(var_13 < 1 || vectordot(var_14, var_11) > var_15)
            var_8 = 0.65;
        }
      }

      if(var_4 < var_8)
        self.moveratemultiplier = min(var_4 + 0.05, var_8);
      else if(var_4 > var_8)
        self.moveratemultiplier = max(var_4 - 0.05, var_8);
    }

    wait 0.1;
  }
}

lerp(var_0, var_1, var_2) {
  return var_0 + (var_1 - var_0) * var_2;
}

lerpfraction(var_0, var_1, var_2) {
  return (var_2 - var_0) / (var_1 - var_0);
}

cancelallbut(var_0, var_1) {
  var_2 = ["runwalkslope", "ratechange", "bark", "sharpturn", "sharpturnduringsharpturn", "stop", "pathsetwhilestopping", "followspeed", "drivenchange", "drivenanim"];
  var_3 = isDefined(var_0);
  var_4 = isDefined(var_1);

  foreach(var_6 in var_2) {
    if(var_3 && var_6 == var_0) {
      continue;
    }
    if(var_4 && var_6 == var_1) {
      continue;
    }
    self notify("dogmove_endwait_" + var_6);
  }
}

getstopdata() {
  var_0 = spawnStruct();
  var_1 = getarrivalnode();

  if(isDefined(var_1) && var_1.type != "Path") {
    var_0.pos = var_1.origin;
    var_0.angles = var_1.angles;
  } else {
    var_0.pos = self.pathgoalpos;

    if(lengthsquared(self.velocity) > 1)
      var_0.angles = self.angles;
    else
      var_0.angles = vectortoangles(self.lookaheaddir);
  }

  return var_0;
}

playmoveanim(var_0, var_1, var_2, var_3) {
  if(var_1)
    self setflaggedanimknoballrestart("dog_move", var_0, % dog_move, 1, var_2, var_3);
  else
    self setflaggedanimknoball("dog_move", var_0, % dog_move, 1, var_2, var_3);
}

playmoveanimknob(var_0, var_1, var_2, var_3) {
  if(var_1)
    self setflaggedanimknoballrestart("dog_move", var_0, % dog_move, 1, var_2, var_3);
  else
    self setflaggedanimknoball("dog_move", var_0, % dog_move, 1, var_2, var_3);
}

setmoveanim(var_0, var_1, var_2) {
  var_3 = !isDefined(var_2) || var_2;
  var_4 = undefined;
  var_5 = isDefined(self.bfirstmoveanim) && self.bfirstmoveanim;
  self.bfirstmoveanim = undefined;

  if(var_0 == "walk") {
    self setanimknob( % dog_walk, 1);

    if(isDefined(self.walk_overrideanim))
      var_6 = self.walk_overrideanim;
    else if(shouldsniff())
      var_6 = getdogmoveanim("sniff");
    else
      var_6 = getdogmoveanim("walk");

    playmoveanim(var_6, var_3, 0.3, self.moveplaybackrate * self.moveratemultiplier);
    self.moveanimtype = "walk";
  } else if(var_0 == "run") {
    if(var_1 == "up") {
      self setanimknob( % dog_slope, 1);
      var_6 = getdogmoveanim("run_up");
      playmoveanimknob(var_6, var_3, 0.5, self.moveplaybackrate * self.moveratemultiplier);
      self.moveanimtype = "run";
    } else if(var_1 == "down") {
      self setanimknob( % dog_slope, 1);
      var_6 = getdogmoveanim("run_down");
      playmoveanimknob(var_6, var_3, 0.5, self.moveplaybackrate * self.moveratemultiplier);
      self.moveanimtype = "run";
    } else if(isDefined(self.sprint) && self.sprint) {
      self setanimknob( % dog_run, 1);
      var_6 = getdogmoveanim("sprint");
      playmoveanim(var_6, var_3, 0.3, self.moveplaybackrate * self.moveratemultiplier);
      self.moveanimtype = "sprint";
    } else {
      self setanimknob( % dog_run, 1);
      self.moveanimtype = "run";
      var_7 = isDefined(self.movementtype);
      var_8 = 0.3;

      if(isDefined(self.run_overrideanim)) {
        var_6 = self.run_overrideanim;

        if(isDefined(self.run_overridesound))
          var_4 = self.run_overridesound;
      } else if(var_7 && self.movementtype == "walk") {
        var_6 = getdogmoveanim("walk");
        self.moveanimtype = "walk";

        if(var_5)
          var_8 = 0.5;
      } else if(var_7 && self.movementtype == "walk_fast") {
        var_6 = getdogmoveanim("walk_fast");
        self.moveanimtype = "walk";

        if(var_5)
          var_8 = 0.5;
      } else if(shouldsniff()) {
        var_6 = getdogmoveanim("sniff");
        var_4 = "anml_dog_sniff_walk";
        self.moveanimtype = "walk";

        if(var_5)
          var_8 = 0.5;
      } else
        var_6 = getdogmoveanim("run");

      playmoveanim(var_6, var_3, var_8, self.moveplaybackrate * self.moveratemultiplier);
    }
  } else {}

  playmovesound(var_4);
}

playmovesound(var_0) {
  var_1 = isDefined(self.moveoverridesound);
  var_2 = isDefined(var_0);

  if(!var_1 && !var_2)
    return;
  else if(var_1 && var_2 && self.moveoverridesound == var_0) {
    return;
  }
  stopmovesound();

  if(var_2)
    thread loopmovesound(var_0);
}

loopmovesound(var_0) {
  self endon("killanimscript");
  var_1 = spawn("script_origin", self.origin);
  var_1.angles = self.angles;
  var_1 linkto(self);
  self.movesoundorigin = var_1;
  self.moveoverridesound = var_0;

  for(;;) {
    var_1 playSound(var_0, "dog_move_sound");
    var_2 = movesound_waitfordoneordeath(var_1, "dog_move_sound");

    if(!isDefined(var_2)) {
      break;
    }
  }
}

movesound_waitfordoneordeath(var_0, var_1) {
  self endon("death");
  var_0 endon("death");
  var_0 waittill(var_1);
  return 1;
}

stopmovesound() {
  if(isDefined(self.movesoundorigin)) {
    if(self.movesoundorigin iswaitingonsound()) {
      self.movesoundorigin stopsounds();
      wait 0.05;
    }

    if(isDefined(self.movesoundorigin))
      self.movesoundorigin delete();

    self.movesoundorigin = undefined;
    self.moveoverridesound = undefined;
  }
}

getdesireddrivenmovemode(var_0) {
  var_1 = 22500;
  var_2 = 10000;
  var_3 = length2dsquared(self.velocity);

  if(var_0 == "walk") {
    if(var_3 > var_1)
      return "run";
  } else if(var_0 == "run") {
    if(var_3 < var_2)
      return "walk";
  }

  return var_0;
}

setdrivenanim(var_0, var_1, var_2) {
  self.bfirstmoveanim = undefined;
  var_3 = 0.5;
  self clearanim( % dog_move, var_3);

  if(!isDefined(var_2))
    var_2 = 1;

  if(var_0 == "walk")
    playmoveanimknob(getdogmoveanim("sneak"), var_1, var_3, var_2);
  else if(var_0 == "run")
    playmoveanimknob(getdogmoveanim("run"), var_1, var_3, var_2);
}

drivenanimupdate() {
  self endon("dogmove_endwait_drivenanim");
  self endon("killanimscript");
  var_0 = 30;
  var_1 = var_0 * var_0;

  for(;;) {
    var_2 = getdesireddrivenmovemode(self.drivenmovemode);

    if(var_2 != self.drivenmovemode) {
      setdrivenanim(var_2, 1);
      self.drivenmovemode = var_2;
    }

    if(self.drivenmovemode == "walk") {
      var_3 = 1;
      var_4 = length2dsquared(self.velocity);

      if(var_4 < var_1)
        var_3 = max(sqrt(var_4) / var_0, 0.15);

      setdrivenanim(var_2, 0, var_3);
    }

    wait 0.1;
  }
}

calcanimstartpos(var_0, var_1, var_2, var_3) {
  var_4 = var_1 - var_3;
  var_5 = (0, var_4, 0);
  var_6 = rotatevector(var_2, var_5);
  return var_0 - var_6;
}

dog_addlean() {
  var_0 = clamp(self.leanamount / 25.0, -1, 1);

  if(var_0 > 0) {
    return;
  }
  return;
}

getangleindex(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 10;

  if(var_0 < 0)
    return int(ceil((180 + var_0 - var_1) / 45));
  else
    return int(floor((180 + var_0 + var_1) / 45));
}

getangleindices(var_0, var_1) {
  var_2 = [-180, -135, -90, -45, 0, 45, 90, 135, 180];
  var_3 = getangleindex(var_0, var_1);
  var_4 = [var_3];

  if(var_0 > var_2[var_3]) {
    if(var_3 + 1 < var_2.size) {
      var_4[var_4.size] = var_3 + 1;

      if(var_0 > (var_2[var_3] + var_2[var_3 + 1]) * 0.5) {
        if(var_3 + 2 < var_2.size)
          var_4[var_4.size] = var_3 + 2;
      } else if(var_3 - 1 >= 0)
        var_4[var_4.size] = var_3 - 1;
    } else {
      if(var_3 - 1 >= 0)
        var_4[var_4.size] = var_3 - 1;

      var_4[var_4.size] = 1;
    }
  } else if(var_3 - 1 >= 0) {
    var_4[var_4.size] = var_3 - 1;

    if(var_0 < (var_2[var_3] + var_2[var_3 - 1]) * 0.5) {
      if(var_3 - 2 >= 0)
        var_4[var_4.size] = var_3 - 2;
    } else if(var_3 + 1 < var_2.size)
      var_4[var_4.size] = var_3 + 1;
  } else {
    if(var_3 + 1 < var_2.size)
      var_4[var_4.size] = var_3 + 1;

    var_4[var_4.size] = var_2.size - 1;
  }

  return var_4;
}

droppostoground(var_0) {
  var_1 = var_0 + (0, 0, 64);
  var_2 = var_0 + (0, 0, -64);
  var_3 = 15;
  var_4 = 45;
  var_5 = self aiphysicstrace(var_1, var_2, var_3, var_4, 1);

  if(abs(var_5[2] - var_1[2]) < 0.5)
    return undefined;

  if(abs(var_5[2] - var_2[2]) < 0.5)
    return undefined;

  return var_5;
}

aredifferent(var_0, var_1) {
  var_2 = isDefined(var_0);
  var_3 = isDefined(var_1);

  if(!var_2 && !var_3)
    return 0;

  if(var_2 && var_3 && var_0 == var_1)
    return 0;

  return 1;
}

hasmovementtypechanged(var_0) {
  return aredifferent(self.movementtype, var_0);
}

hasoverrideanimchanged(var_0, var_1) {
  return aredifferent(self.run_overrideanim, var_0) || aredifferent(self.walk_overrideanim, var_1);
}

getarrivalnode() {
  if(isDefined(self.scriptedarrivalent))
    return self.scriptedarrivalent;

  if(isDefined(self.node))
    return self.node;

  if(isDefined(self.prevnode) && isDefined(self.pathgoalpos) && distance2dsquared(self.prevnode.origin, self.pathgoalpos) < 36)
    return self.prevnode;

  return undefined;
}

shouldsniff() {
  return isDefined(self.movementtype) && self.movementtype == "sniff";
}

getdogmoveanim(var_0) {
  var_1 = animscripts\utility::lookupdoganim("move", var_0);
  return var_1;
}

getdogturnanim(var_0, var_1, var_2) {
  var_3 = getdogmoveanim(var_0);

  if(isDefined(var_3[var_1]))
    return var_3[var_1];

  if(isDefined(var_2)) {
    var_3 = getdogmoveanim(var_2);
    return var_3[var_1];
  }
}

handlefootstepnotetracks() {
  self endon("killanimscript");

  for(;;) {
    self waittill("dog_move", var_0);
    animscripts\notetracks::handlenotetrack(var_0, "dog_move");
  }
}

initdogarchetype_move() {
  var_0 = [];
  var_0["walk"] = % iw6_dog_walk;
  var_0["walk_fast"] = % iw6_dog_fastwalk;
  var_0["run"] = % iw6_dog_run;
  var_0["run_up"] = % iw6_dog_ramp_up_run;
  var_0["run_down"] = % iw6_dog_ramp_down_run;
  var_0["sprint"] = % iw6_dog_sprint;
  var_0["sneak"] = % iw6_dog_sneak_walk_forward;
  var_0["sniff"] = % iw6_dog_sniff_walk;
  var_0["run_start"] = [];
  var_0["run_start"][0] = % iw6_dog_attackidle_runout_2;
  var_0["run_start"][1] = % iw6_dog_attackidle_runout_3;
  var_0["run_start"][2] = % iw6_dog_attackidle_runout_6;
  var_0["run_start"][3] = % iw6_dog_attackidle_runout_9;
  var_0["run_start"][4] = % iw6_dog_attackidle_runout_8;
  var_0["run_start"][5] = % iw6_dog_attackidle_runout_7;
  var_0["run_start"][6] = % iw6_dog_attackidle_runout_4;
  var_0["run_start"][7] = % iw6_dog_attackidle_runout_1;
  var_0["run_start"][8] = % iw6_dog_attackidle_runout_2;
  var_0["run_stop"] = [];
  var_0["run_stop"]["attack"] = [];
  var_0["run_stop"]["attack"][0] = % iw6_dog_attackidle_runin_2;
  var_0["run_stop"]["attack"][1] = % iw6_dog_attackidle_runin_1;
  var_0["run_stop"]["attack"][2] = % iw6_dog_attackidle_runin_4;
  var_0["run_stop"]["attack"][3] = % iw6_dog_attackidle_runin_7;
  var_0["run_stop"]["attack"][4] = % iw6_dog_attackidle_runin_8;
  var_0["run_stop"]["attack"][5] = % iw6_dog_attackidle_runin_9;
  var_0["run_stop"]["attack"][6] = % iw6_dog_attackidle_runin_6;
  var_0["run_stop"]["attack"][7] = % iw6_dog_attackidle_runin_3;
  var_0["run_stop"]["attack"][8] = % iw6_dog_attackidle_runin_2;
  var_0["run_stop"]["alert"] = [];
  var_0["run_stop"]["alert"][0] = % iw6_dog_alertidle_runin_2;
  var_0["run_stop"]["alert"][1] = % iw6_dog_alertidle_runin_1;
  var_0["run_stop"]["alert"][2] = % iw6_dog_alertidle_runin_4;
  var_0["run_stop"]["alert"][3] = % iw6_dog_alertidle_runin_7;
  var_0["run_stop"]["alert"][4] = % iw6_dog_alertidle_runin_8;
  var_0["run_stop"]["alert"][5] = % iw6_dog_alertidle_runin_9;
  var_0["run_stop"]["alert"][6] = % iw6_dog_alertidle_runin_6;
  var_0["run_stop"]["alert"][7] = % iw6_dog_alertidle_runin_3;
  var_0["run_stop"]["alert"][8] = % iw6_dog_alertidle_runin_2;
  var_0["run_stop"]["casual"] = [];
  var_0["run_stop"]["casual"][0] = % iw6_dog_casualidle_runin_2;
  var_0["run_stop"]["casual"][1] = % iw6_dog_casualidle_runin_1;
  var_0["run_stop"]["casual"][2] = % iw6_dog_casualidle_runin_4;
  var_0["run_stop"]["casual"][3] = % iw6_dog_casualidle_runin_7;
  var_0["run_stop"]["casual"][4] = % iw6_dog_casualidle_runin_8;
  var_0["run_stop"]["casual"][5] = % iw6_dog_casualidle_runin_9;
  var_0["run_stop"]["casual"][6] = % iw6_dog_casualidle_runin_6;
  var_0["run_stop"]["casual"][7] = % iw6_dog_casualidle_runin_3;
  var_0["run_stop"]["casual"][8] = % iw6_dog_casualidle_runin_2;
  var_0["run_stop"]["sneak"] = [];
  var_0["run_stop"]["sneak"][4] = % iw6_dog_sneak_runin_8;
  var_0["sharp_turn"] = [];
  var_0["sharp_turn"][0] = % iw6_dog_run_turn_2;
  var_0["sharp_turn"][1] = % iw6_dog_run_turn_3;
  var_0["sharp_turn"][2] = % iw6_dog_run_turn_6;
  var_0["sharp_turn"][3] = % iw6_dog_run_turn_9;
  var_0["sharp_turn"][5] = % iw6_dog_run_turn_7;
  var_0["sharp_turn"][6] = % iw6_dog_run_turn_4;
  var_0["sharp_turn"][7] = % iw6_dog_run_turn_1;
  var_0["sharp_turn"][8] = % iw6_dog_run_turn_2;
  var_0["quick_sharp_turn"] = [];
  var_0["quick_sharp_turn"][0] = % iw6_dog_run_quickturn_2;
  var_0["quick_sharp_turn"][1] = % iw6_dog_run_quickturn_3;
  var_0["quick_sharp_turn"][2] = % iw6_dog_run_quickturn_6;
  var_0["quick_sharp_turn"][3] = % iw6_dog_run_quickturn_9;
  var_0["quick_sharp_turn"][5] = % iw6_dog_run_quickturn_7;
  var_0["quick_sharp_turn"][6] = % iw6_dog_run_quickturn_4;
  var_0["quick_sharp_turn"][7] = % iw6_dog_run_quickturn_1;
  var_0["quick_sharp_turn"][8] = % iw6_dog_run_quickturn_2;
  var_0["sniff_turn"][2] = % iw6_dog_sniff_turn_6;
  var_0["sniff_turn"][6] = % iw6_dog_sniff_turn_4;
  anim.archetypes["dog"]["move"] = var_0;
}