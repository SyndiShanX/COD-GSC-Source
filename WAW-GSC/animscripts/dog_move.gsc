/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\dog_move.gsc
**************************************/

#include maps\_utility;
#include animscripts\utility;
#include common_scripts\utility;
#using_animtree("dog");

main() {
  self endon("killanimscript");

  self clearanim(%root, 0.2);
  self clearanim(%german_shepherd_run_stop, 0);

  self thread randomSoundDuringRunLoop();

  if(!isDefined(self.traverseComplete) && !isDefined(self.skipStartMove) && self.a.movement == "run") {
    self startMove();
    blendTime = 0;
  } else {
    blendTime = 0.2;
  }

  self.traverseComplete = undefined;
  self.skipStartMove = undefined;

  self clearanim(%german_shepherd_run_start, 0);

  if(self.a.movement == "run") {
    weights = undefined;
    weights = self getRunAnimWeights();

    self setanimrestart(%german_shepherd_run, weights["center"], blendTime, 1);
    self setanimrestart(%german_shepherd_run_lean_L, weights["left"], 0.1, 1);
    self setanimrestart(%german_shepherd_run_lean_R, weights["right"], 0.1, 1);
    self setflaggedanimknob("dog_run", %german_shepherd_run_knob, 1, blendTime, self.moveplaybackrate);
    animscripts\shared::DoNoteTracksForTime(0.1, "dog_run");
  } else {
    self setflaggedanimrestart("dog_walk", %german_shepherd_walk, 1, 0.2, self.moveplaybackrate);
  }

  while(1) {
    self moveLoop();

    if(self.a.movement == "run") {
      if(self.disableArrivals == false)
        self thread stopMove();

      self waittill("run");
      self clearanim(%german_shepherd_run_stop, 0.1);
    }
  }
}

moveLoop() {
  self endon("killanimscript");
  self endon("stop_soon");

  while(1) {
    if(self.disableArrivals)
      self.stopAnimDistSq = 0;
    else
      self.stopAnimDistSq = anim.dogStoppingDistSq;

    if(self.a.movement == "run") {
      weights = self getRunAnimWeights();

      self clearanim(%german_shepherd_walk, 0.3);

      self setanim(%german_shepherd_run, weights["center"], 0.2, 1);
      self setanim(%german_shepherd_run_lean_L, weights["left"], 0.2, 1);
      self setanim(%german_shepherd_run_lean_R, weights["right"], 0.2, 1);
      self setflaggedanimknob("dog_run", %german_shepherd_run_knob, 1, 0.2, self.moveplaybackrate);

      animscripts\shared::DoNoteTracksForTime(0.2, "dog_run");
    } else {
      assert(self.a.movement == "walk");

      self clearanim(%german_shepherd_run_knob, 0.3);
      self setflaggedanim("dog_walk", %german_shepherd_walk, 1, 0.2, self.moveplaybackrate);
      animscripts\shared::DoNoteTracksForTime(0.2, "dog_walk");
    }
  }
}

startMoveTrackLookAhead() {
  self endon("killanimscript");
  for(i = 0; i < 2; i++) {
    lookaheadAngle = vectortoangles(self.lookaheaddir);
    self OrientMode("face angle", lookaheadAngle);
  }
}

startMove() {
  {
    self setanimrestart(%german_shepherd_run_start, 1, 0.2, 1);
  }

  self setflaggedanimknobrestart("dog_prerun", %german_shepherd_run_start_knob, 1, 0.2, self.moveplaybackrate);

  self animscripts\shared::DoNoteTracks("dog_prerun");

  self animMode("none");
  self OrientMode("face motion");
}

stopMove() {
  self endon("killanimscript");
  self endon("run");

  self clearanim(%german_shepherd_run_knob, 0.1);
  self setflaggedanimrestart("stop_anim", %german_shepherd_run_stop, 1, 0.2, 1);
  self animscripts\shared::DoNoteTracks("stop_anim");
}

randomSoundDuringRunLoop() {
  self endon("killanimscript");
  while(1) {
    if(getdebugdvar("debug_dog_sound") != "")
      iprintln("dog " + (self getentnum()) + " bark start " + getTime());

    if(isDefined(self.script_growl))
      self play_sound_on_tag("anml_dog_growl", "tag_eye");
    else
      self play_sound_on_tag("anml_dog_bark", "tag_eye");

    if(getdebugdvar("debug_dog_sound") != "")
      iprintln("dog " + (self getentnum()) + " bark end " + getTime());

    wait(randomfloatrange(0.1, 0.3));
  }
}

getRunAnimWeights() {
  weights = [];
  weights["center"] = 0;
  weights["left"] = 0;
  weights["right"] = 0;

  if(self.leanAmount > 0) {
    if(self.leanAmount < 0.95)
      self.leanAmount = 0.95;

    weights["left"] = 0;
    weights["right"] = (1 - self.leanAmount) * 20;

    if(weights["right"] > 1)
      weights["right"] = 1;
    else if(weights["right"] < 0)
      weights["right"] = 0;

    weights["center"] = 1 - weights["right"];
  } else if(self.leanAmount < 0) {
    if(self.leanAmount > -0.95)
      self.leanAmount = -0.95;

    weights["right"] = 0;
    weights["left"] = (1 + self.leanAmount) * 20;

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