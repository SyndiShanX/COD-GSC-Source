/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\dog_move.gsc
**************************************/

#include maps\_utility;
#include animscripts\utility;
#include common_scripts\utility;
#include animscripts\shared;
#using_animtree("dog");

main() {
  self endon("killanimscript");
  self clearanim( % root, 0.2);
  self clearanim( % german_shepherd_run_stop, 0);
  self thread randomsoundduringrunloop();

  if(!isDefined(self.traversecomplete) && !isDefined(self.skipstartmove) && self.a.movement == "run") {
    self startmove();
    blendtime = 0;
  } else
    blendtime = 0.2;

  self.traversecomplete = undefined;
  self.skipstartmove = undefined;
  self clearanim( % german_shepherd_run_start, 0);

  if(self.a.movement == "run") {
    weights = undefined;
    weights = self getrunanimweights();
    self setanimrestart( % german_shepherd_run, weights["center"], blendtime, 1);
    self setanimrestart( % german_shepherd_run_lean_l, weights["left"], 0.1, 1);
    self setanimrestart( % german_shepherd_run_lean_r, weights["right"], 0.1, 1);
    self setflaggedanimknob("dog_run", % german_shepherd_run_knob, 1, blendtime, self.moveplaybackrate);
    animscripts\shared::donotetracksfortime(0.1, "dog_run");
  } else
    self setflaggedanimrestart("dog_walk", % german_shepherd_walk, 1, 0.2, self.moveplaybackrate);

  while(true) {
    self moveloop();

    if(self.a.movement == "run") {
      if(self.disablearrivals == 0)
        self thread stopmove();

      self waittill("run");
      self clearanim( % german_shepherd_run_stop, 0.1);
    }
  }
}

moveloop() {
  self endon("killanimscript");
  self endon("stop_soon");

  while(true) {
    if(self.disablearrivals)
      self.stopanimdistsq = 0;
    else
      self.stopanimdistsq = anim.dogstoppingdistsq;

    if(self.a.movement == "run") {
      weights = self getrunanimweights();
      self clearanim( % german_shepherd_walk, 0.3);
      self setanim( % german_shepherd_run, weights["center"], 0.2, 1);
      self setanim( % german_shepherd_run_lean_l, weights["left"], 0.2, 1);
      self setanim( % german_shepherd_run_lean_r, weights["right"], 0.2, 1);
      self setflaggedanimknob("dog_run", % german_shepherd_run_knob, 1, 0.2, self.moveplaybackrate);
      animscripts\shared::donotetracksfortime(0.2, "dog_run");
    } else {
      assert(self.a.movement == "walk");
      self clearanim( % german_shepherd_run_knob, 0.3);
      self setflaggedanim("dog_walk", % german_shepherd_walk, 1, 0.2, self.moveplaybackrate);
      animscripts\shared::donotetracksfortime(0.2, "dog_walk");
    }
  }
}

startmovetracklookahead() {
  self endon("killanimscript");

  for(i = 0; i < 2; i++) {
    lookaheadangle = vectortoangles(self.lookaheaddir);
    self orientmode("face angle", lookaheadangle);
  }
}

startmove() {
  self setanimrestart( % german_shepherd_run_start, 1, 0.2, 1);
  self setflaggedanimknobrestart("dog_prerun", % german_shepherd_run_start_knob, 1, 0.2, self.moveplaybackrate);
  self animscripts\shared::donotetracks("dog_prerun");
  self animmode("none");
  self orientmode("face motion");
}

stopmove() {
  self endon("killanimscript");
  self endon("run");
  self clearanim( % german_shepherd_run_knob, 0.1);
  self setflaggedanimrestart("stop_anim", % german_shepherd_run_stop, 1, 0.2, 1);
  self animscripts\shared::donotetracks("stop_anim");
}

randomsoundduringrunloop() {
  self endon("killanimscript");

  while(true) {
    if(getdebugdvar("debug_dog_sound") != "")
      iprintln("dog " + self getentnum() + " bark start " + gettime());

    if(isDefined(self.script_growl))
      self play_sound_on_tag("aml_dog_growl", "tag_eye");
    else
      self play_sound_on_tag("aml_dog_bark", "tag_eye");

    if(getdebugdvar("debug_dog_sound") != "")
      iprintln("dog " + self getentnum() + " bark end " + gettime());

    wait(randomfloatrange(0.1, 0.3));
  }
}

getrunanimweights() {
  weights = [];
  weights["center"] = 0;
  weights["left"] = 0;
  weights["right"] = 0;

  if(self.leanamount > 0) {
    if(self.leanamount < 0.95)
      self.leanamount = 0.95;

    weights["left"] = 0;
    weights["right"] = (1 - self.leanamount) * 20;

    if(weights["right"] > 1)
      weights["right"] = 1;
    else if(weights["right"] < 0)
      weights["right"] = 0;

    weights["center"] = 1 - weights["right"];
  } else if(self.leanamount < 0) {
    if(self.leanamount > -0.95)
      self.leanamount = -0.95;

    weights["right"] = 0;
    weights["left"] = (1 + self.leanamount) * 20;

    if(weights["left"] > 1)
      weights["left"] = 1;

    if(weights["left"] < 0)
      weights["left"] = 0;

    weights["center"] = 1 - weights["left"];
  } else {
    weights["left"] = 0;
    weights["right"] = 0;
    weights["center"] = 1;
  }

  return weights;
}