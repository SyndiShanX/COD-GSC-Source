/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\zombie_dog_move.gsc
*******************************************/

#include maps\_utility;
#include animscripts\zombie_utility;
#include common_scripts\utility;
#using_animtree("zombie_dog");
main() {
  self endon("killanimscript");
  self ClearAnim(%root, 0.2);
  self ClearAnim(anim.dogAnims[self.animSet].move["run_stop"], 0);
  if(!isDefined(self.traverseComplete) && !isDefined(self.skipStartMove) && self.a.movement == "run") {
    self startMove();
    blendTime = 0;
  } else {
    blendTime = 0.2;
  }
  self.traverseComplete = undefined;
  self.skipStartMove = undefined;
  self ClearAnim(anim.dogAnims[self.animSet].move["run_start"], 0);
  if(self.a.movement == "run") {
    weights = undefined;
    weights = self getRunAnimWeights();
    self SetAnimRestart(anim.dogAnims[self.animSet].move["run"], weights["center"], blendTime, 1);
    self SetAnimRestart(anim.dogAnims[self.animSet].move["run_lean_L"], weights["left"], blendTime, 1);
    self SetAnimRestart(anim.dogAnims[self.animSet].move["run_lean_R"], weights["right"], blendTime, 1);
    self SetFlaggedAnimKnob("dog_run", anim.dogAnims[self.animSet].move["run_knob"], 1, blendTime, self.moveplaybackrate);
    animscripts\zombie_shared::DoNoteTracksForTime(0.1, "dog_run");
  } else {
    self SetFlaggedAnimRestart("dog_walk", anim.dogAnims[self.animSet].move["walk"], 1, 0.2, self.moveplaybackrate);
  }
  while(1) {
    self moveLoop();
    if(self.a.movement == "run") {
      if(self.disableArrivals == false) {
        self thread stopMove();
      }
      self waittill("run");
      self ClearAnim(anim.dogAnims[self.animSet].move["run_stop"], 0.1);
    }
  }
}
moveLoop() {
  self endon("killanimscript");
  self endon("stop_soon");
  while(1) {
    if(self.disableArrivals) {
      self.stopAnimDistSq = 0;
    } else {
      self.stopAnimDistSq = anim.dogAnims[self.animSet].dogStoppingDistSq;
    }
    if(self.a.movement == "run") {
      weights = self getRunAnimWeights();
      self ClearAnim(anim.dogAnims[self.animSet].move["walk"], 0.3);
      self SetAnim(anim.dogAnims[self.animSet].move["run"], weights["center"], 0.2, 1);
      self SetAnim(anim.dogAnims[self.animSet].move["run_lean_L"], weights["left"], 0.2, 1);
      self SetAnim(anim.dogAnims[self.animSet].move["run_lean_R"], weights["right"], 0.2, 1);
      self SetFlaggedAnimKnob("dog_run", anim.dogAnims[self.animSet].move["run_knob"], 1, 0.2, self.moveplaybackrate);
      animscripts\zombie_shared::DoNoteTracksForTime(0.2, "dog_run");
    } else {
      assert(self.a.movement == "walk");
      self ClearAnim(anim.dogAnims[self.animSet].move["run_knob"], 0.3);
      self setflaggedanim("dog_walk", anim.dogAnims[self.animSet].move["walk"], 1, 0.2, self.moveplaybackrate);
      animscripts\zombie_shared::DoNoteTracksForTime(0.2, "dog_walk");
      if(self need_to_run()) {
        self.a.movement = "run";
        self notify("dog_running");
      }
    }
  }
}
startMoveTrackLookAhead() {
  self endon("killanimscript");
  for(i = 0; i < 2; i++) {
    lookaheadAngle = VectorToAngles(self.lookaheaddir);
    self OrientMode("face angle", lookaheadAngle);
  }
}
startMove() {
  {
    self SetAnimRestart(anim.dogAnims[self.animSet].move["run_start"], 1, 0.2, 1);
  }
  self SetFlaggedAnimKnobRestart("dog_prerun", anim.dogAnims[self.animSet].move["run_start_knob"], 1, 0.2, self.moveplaybackrate);
  self animscripts\zombie_shared::DoNoteTracks("dog_prerun");
  self AnimMode("none");
  self OrientMode("face motion");
}
stopMove() {
  self endon("killanimscript");
  self endon("run");
  self ClearAnim(anim.dogAnims[self.animSet].move["run_knob"], 0.1);
  self SetFlaggedAnimRestart("stop_anim", anim.dogAnims[self.animSet].move["run_stop"], 1, 0.2, 1);
  self animscripts\zombie_shared::DoNoteTracks("stop_anim");
}
wait_for_play_sound_on_tag(alias, tag) {
  self play_sound_on_tag(alias, tag);
  self notify("growl_bark_done");
}
randomSoundDuringRunLoop() {
  self endon("killanimscript");
  while(1) {
    if(isDefined(self.script_growl)) {
      self thread wait_for_play_sound_on_tag("aml_dog_growl", "tag_eye");
    } else {
      self thread wait_for_play_sound_on_tag("aml_dog_bark", "tag_eye");
    }
    self waittill("growl_bark_done");
    wait(RandomFloatRange(0.1, 0.3));
  }
}
getRunAnimWeights() {
  weights = [];
  weights["center"] = 0;
  weights["left"] = 0;
  weights["right"] = 0;
  if(self.leanAmount > 0) {
    if(self.leanAmount < 0.95) {
      self.leanAmount = 0.95;
    }
    weights["left"] = 0;
    weights["right"] = (1 - self.leanAmount) * 20;
    if(weights["right"] > 1) {
      weights["right"] = 1;
    } else if(weights["right"] < 0) {
      weights["right"] = 0;
    }
    weights["center"] = 1 - weights["right"];
  } else if(self.leanAmount < 0) {
    if(self.leanAmount > -0.95) {
      self.leanAmount = -0.95;
    }
    weights["right"] = 0;
    weights["left"] = (1 + self.leanAmount) * 20;
    if(weights["left"] > 1) {
      weights["left"] = 1;
    }
    if(weights["left"] < 0) {
      weights["left"] = 0;
    }
    weights["center"] = 1 - weights["left"];
  } else {
    weights["left"] = 0;
    weights["right"] = 0;
    weights["center"] = 1;
  }
  return weights;
}
need_to_run() {
  run_dist_squared = 384 * 384;
  if(getDvar("scr_dog_run_distance") != "") {
    dist = GetDvarInt("scr_dog_run_distance");
    run_dist_squared = dist * dist;
  }
  run_yaw = 20;
  run_pitch = 30;
  run_height = 64;
  if(self.a.movement != "walk") {
    return false;
  }
  if(self.health < self.maxhealth) {
    return true;
  }
  if(!isDefined(self.enemy) || !IsAlive(self.enemy)) {
    return false;
  }
  if(!self CanSee(self.enemy)) {
    return false;
  }
  dist = DistanceSquared(self.origin, self.enemy.origin);
  if(dist > run_dist_squared) {
    return false;
  }
  height = self.origin[2] - self.enemy.origin[2];
  if(abs(height) > run_height) {
    return false;
  }
  yaw = self AbsYawToEnemy();
  if(yaw > run_yaw) {
    return false;
  }
  pitch = AngleClamp180(VectorToAngles(self.origin - self.enemy.origin)[0]);
  if(abs(pitch) > run_pitch) {
    return false;
  }
  return true;
}