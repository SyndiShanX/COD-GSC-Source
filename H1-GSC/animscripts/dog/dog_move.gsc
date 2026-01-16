/****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\dog\dog_move.gsc
****************************************/

#using_animtree("dog");

main() {
  self endon("killanimscript");
  self clearanim( % root, 0.2);
  self clearanim( % german_shepherd_run_stop, 0);

  if(!isdefined(self.traversecomplete) && !isdefined(self.skipstartmove) && self.a.movement == "run" && (!isdefined(self.disableexits) || self.disableexits == 0))
    startmove();

  thread randomsoundduringrunloop();
  self.traversecomplete = undefined;
  self.skipstartmove = undefined;

  if(self.a.movement == "run") {
    var_0 = undefined;
    var_0 = getrunanimweights();
    self setanimrestart( % german_shepherd_run, var_0["center"], 0.2, 1);
    self setanimrestart( % german_shepherd_run_lean_l, var_0["left"], 0.1, 1);
    self setanimrestart( % german_shepherd_run_lean_r, var_0["right"], 0.1, 1);
    self setflaggedanimknob("dog_run", % german_shepherd_run_knob, 1, 0.2, self.moveplaybackrate);
    animscripts\notetracks::donotetracksfortime(0.1, "dog_run");
  } else
    self setflaggedanimrestart("dog_walk", % german_shepherd_walk, 1, 0.2, self.moveplaybackrate);

  thread animscripts\dog\dog_stop::lookattarget("normal");

  for (;;) {
    moveloop();

    if(self.a.movement == "run") {
      if(self.disablearrivals == 0)
        thread stopmove();

      common_scripts\utility::waittill_any("run", "path_set");
      self clearanim( % german_shepherd_run_stop, 0.1);
    }
  }
}

moveloop() {
  self endon("killanimscript");
  self endon("stop_soon");
  self.moveloopcleanupfunc = undefined;

  for (;;) {
    if(self.disablearrivals)
      self.stopanimdistsq = 0;
    else
      self.stopanimdistsq = anim.dogstoppingdistsq;

    if(isdefined(self.moveloopcleanupfunc)) {
      self[[self.moveloopcleanupfunc]]();
      self.moveloopcleanupfunc = undefined;
    }

    if(isdefined(self.moveloopoverridefunc)) {
      self[[self.moveloopoverridefunc]]();
      continue;
    }

    moveloopstep();
  }
}

moveloopstep() {
  self endon("move_loop_restart");

  if(self.a.movement == "run") {
    var_0 = getrunanimweights();
    self clearanim( % german_shepherd_walk, 0.3);
    self setanim( % german_shepherd_run, var_0["center"], 0.2, 1);
    self setanim( % german_shepherd_run_lean_l, var_0["left"], 0.1, 1);
    self setanim( % german_shepherd_run_lean_r, var_0["right"], 0.1, 1);
    self setflaggedanimknob("dog_run", % german_shepherd_run_knob, 1, 0.2, self.moveplaybackrate);
    animscripts\notetracks::donotetracksfortime(0.2, "dog_run");
  } else {
    self clearanim( % german_shepherd_run_knob, 0.3);
    self setflaggedanim("dog_walk", % german_shepherd_walk, 1, 0.2, self.moveplaybackrate);
    animscripts\notetracks::donotetracksfortime(0.2, "dog_walk");
  }
}

pathchangecheck() {
  self endon("killanimscript");
  self.ignorepathchange = undefined;

  for (;;) {
    self waittill("path_changed", var_0, var_1);

    if(isdefined(self.ignorepathchange) || isdefined(self.noturnanims)) {
      continue;
    }
    if(self.a.movement != "run") {
      continue;
    }
    var_2 = angleclamp180(self.angles[1] - vectortoyaw(var_1));
    var_3 = pathchange_getdogturnanim(var_2);

    if(isdefined(var_3)) {
      self.turnanim = var_3;
      self.turntime = gettime();
      self.moveloopoverridefunc = ::pathchange_dodogturnanim;
      self notify("move_loop_restart");
    }
  }
}

pathchangecheck2() {
  self endon("killanimscript");
  self.ignorepathchange = undefined;

  for (;;) {
    if(self.lookaheaddist > 40 && !isdefined(self.moveloopoverridefunc) && !isdefined(self.ignorepathchange) && !isdefined(self.noturnanims) && self.a.movement == "run") {
      var_0 = vectortoyaw(self.lookaheaddir);
      var_1 = angleclamp180(self.angles[1] - var_0);
      var_2 = pathchange_getdogturnanim(var_1);

      if(isdefined(var_2)) {
        self.turnanim = var_2;
        self.turntime = gettime();
        self.moveloopoverridefunc = ::pathchange_dodogturnanim;
        self notify("move_loop_restart");
      }
    }

    wait 0.05;
  }
}

pathchange_getdogturnanim(var_0) {
  var_1 = undefined;

  if(var_0 < -135)
    var_1 = % german_shepherd_run_start_180_l;
  else if(var_0 > 135)
    var_1 = % german_shepherd_run_start_180_r;
  else if(var_0 < -60)
    var_1 = % german_shepherd_run_start_l;
  else if(var_0 > 60)
    var_1 = % german_shepherd_run_start_r;

  return var_1;
}

pathchange_dodogturnanim() {
  self endon("killanimscript");
  self.moveloopoverridefunc = undefined;
  var_0 = self.turnanim;

  if(gettime() > self.turntime + 50) {
    return;
  }
  self animmode("zonly_physics", 0);
  self clearanim( % root, 0.2);
  self.moveloopcleanupfunc = ::pathchange_cleanupdogturnanim;
  self.ignorepathchange = 1;
  self setflaggedanimrestart("turnAnim", var_0, 1, 0.2, self.moveplaybackrate);
  self orientmode("face current");
  var_1 = getanimlength(var_0) * self.moveplaybackrate;
  animscripts\notetracks::donotetracksfortime(var_1 * 0.2, "turnAnim");
  self orientmode("face motion");
  self animmode("none", 0);
  var_2 = self.turnrate;
  self.turnrate = 0.4;
  animscripts\notetracks::donotetracksfortime(var_1 * 0.65, "turnAnim");
  self.turnrate = var_2;
  self.ignorepathchange = undefined;
}

pathchange_cleanupdogturnanim() {
  self.ignorepathchange = undefined;
  self orientmode("face default");
  self clearanim( % root, 0.2);
  self animmode("none", 0);
}

startmovetracklookahead() {
  self endon("killanimscript");

  for (var_0 = 0; var_0 < 2; var_0++) {
    var_1 = vectortoangles(self.lookaheaddir);
    self orientmode("face angle", var_1);
  }
}

playmovestartanim() {
  self endon("move_loop_restart");

  if(self.lookaheaddist == 0)
    thread pathchangecheck2();
  else {
    var_0 = self.origin;
    var_1 = anim.dogstartmovedist * 0.6;
    var_0 = var_0 + self.lookaheaddir * var_1;
    var_2 = distancesquared(self.origin, self.pathgoalpos) < var_1 * var_1;
    var_3 = vectortoangles(self.lookaheaddir);

    if(!var_2 && self maymovetopoint(var_0)) {
      var_4 = angleclamp180(var_3[1] - self.angles[1]);

      if(var_4 >= 0) {
        if(var_4 < 45)
          var_5 = 8;
        else if(var_4 < 135)
          var_5 = 6;
        else
          var_5 = 3;
      } else if(var_4 > -45)
        var_5 = 8;
      else if(var_4 > -135)
        var_5 = 4;
      else
        var_5 = 1;

      self setanimrestart(anim.dogstartmoveanim[var_5], 1, 0.2, 1);
      var_6 = self.angles[1] + anim.dogstartmoveangles[var_5];
      var_7 = angleclamp180(var_3[1] - var_6);
      self orientmode("face angle", self.angles[1] + var_7);
      self animmode("zonly_physics", 0);
      var_8 = getanimlength(anim.dogstartmoveanim[var_5]) * self.moveplaybackrate;
      animscripts\notetracks::donotetracksfortime(var_8 * 0.6, "turnAnim");
      self orientmode("face motion");
      self animmode("none", 0);
      thread pathchangecheck2();
      animscripts\notetracks::donotetracksfortime(var_8 * 0.25, "turnAnim");
      return;
    }

    self orientmode("face angle", var_3[1]);
    self animmode("none");
    self.prevturnrate = self.turnrate;
    self.turnrate = 0.5;
    var_9 = angleclamp180(var_3[1] - self.angles[1]);

    if(abs(var_9) > 20) {
      if(var_9 > 0)
        var_10 = % german_shepherd_rotate_ccw;
      else
        var_10 = % german_shepherd_rotate_cw;

      self setflaggedanimrestart("dog_turn", var_10, 1, 0.2, 1.0);
      animscripts\shared::donotetracks("dog_turn");
      self clearanim( % german_shepherd_rotate_cw, 0.2);
      self clearanim( % german_shepherd_rotate_ccw, 0.2);
    }

    thread pathchangecheck2();
    self.turnrate = self.prevturnrate;
    self.prevturnrate = undefined;
    self orientmode("face motion");
  }
}

startmove() {
  if(isdefined(self.pathgoalpos)) {
    if(isdefined(self.pathgoalpos)) {
      playmovestartanim();
      self clearanim( % root, 0.2);
      return;
    }
  }

  self orientmode("face default");
  self setflaggedanimknobrestart("dog_prerun", % german_shepherd_run_start, 1, 0.2, self.moveplaybackrate);
  animscripts\shared::donotetracks("dog_prerun");
  self animmode("none", 0);
  self clearanim( % root, 0.2);
}

stopmove() {
  self endon("killanimscript");
  self endon("run");
  self clearanim( % german_shepherd_run_knob, 0.1);
  self setflaggedanimrestart("stop_anim", % german_shepherd_run_stop, 1, 0.2, 1);
  animscripts\shared::donotetracks("stop_anim");
}

dogplaysoundandnotify(var_0, var_1) {
  maps\_utility::play_sound_on_tag_endon_death(var_0, "tag_eye");

  if(isalive(self))
    self notify(var_1);
}

randomsoundduringrunloop() {
  self endon("killanimscript");
  wait 0.2;

  for (;;) {
    var_0 = undefined;

    if(isdefined(self.script_growl))
      var_0 = "anml_dog_growl";
    else if(!isdefined(self.script_nobark))
      var_0 = "anml_dog_bark";

    if(!isdefined(var_0)) {
      break;
    }

    thread dogplaysoundandnotify(var_0, "randomRunSound");
    self waittill("randomRunSound");
    wait(randomfloatrange(0.1, 0.3));
  }
}

getrunanimweights() {
  var_0 = [];
  var_0["center"] = 0;
  var_0["left"] = 0;
  var_0["right"] = 0;

  if(self.leanamount > 0) {
    if(self.leanamount < 0.95)
      self.leanamount = 0.95;

    var_0["left"] = 0;
    var_0["right"] = (1 - self.leanamount) * 20;

    if(var_0["right"] > 1)
      var_0["right"] = 1;
    else if(var_0["right"] < 0)
      var_0["right"] = 0;

    var_0["center"] = 1 - var_0["right"];
  } else if(self.leanamount < 0) {
    if(self.leanamount > -0.95)
      self.leanamount = -0.95;

    var_0["right"] = 0;
    var_0["left"] = (1 + self.leanamount) * 20;

    if(var_0["left"] > 1)
      var_0["left"] = 1;

    if(var_0["left"] < 0)
      var_0["left"] = 0;

    var_0["center"] = 1 - var_0["left"];
  } else {
    var_0["left"] = 0;
    var_0["right"] = 0;
    var_0["center"] = 1;
  }

  return var_0;
}