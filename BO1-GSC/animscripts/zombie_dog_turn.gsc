/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\zombie_dog_turn.gsc
*******************************************/

#include animscripts\zombie_utility;
#include animscripts\zombie_shared;
#using_animtree("zombie_dog");
main() {
  self endon("killanimscript");
  debug_anim_print("dog_turn::main()");
  self.safeToChangeScript = false;
  deltaYaw = self GetDeltaTurnYaw();
  if(need_to_turn_around(deltaYaw)) {
    turn_180(deltaYaw);
  } else {
    turn_90(deltaYaw);
  }
  move_out_of_turn();
  self.skipStartMove = true;
  self.safeToChangeScript = true;
}

need_to_turn_around(deltaYaw) {
  angle = GetDvarFloat(#"dog_turn180_angle");
  if((deltaYaw > angle) || (deltaYaw < (-1 * angle))) {
    debug_turn_print("need_to_turn_around: " + deltaYaw + " YES");
    return true;
  }
  debug_turn_print("need_to_turn_around: " + deltaYaw + " NO");
  return false;
}

clear_turn_anims() {
  debug_anim_print("dog_move::clear_turn_anims()");
  self ClearAnim(anim.dogAnims[self.animSet].turn["turn_knob"], 0.0);
}

get_anim_string(animation) {
  anim_str = "unknown";
  if(animation == % zombie_dog_turn_90_left)
    anim_str = "zombie_dog_turn_90_left";
  else if(animation == % zombie_dog_run_turn_90_left)
    anim_str = "zombie_dog_run_turn_90_left";
  else if(animation == % zombie_dog_turn_90_right)
    anim_str = "zombie_dog_turn_90_right";
  else if(animation == % zombie_dog_run_turn_90_right)
    anim_str = "zombie_dog_run_turn_90_right";
  else if(animation == % zombie_dog_turn_180_left)
    anim_str = "zombie_dog_turn_180_left";
  else if(animation == % zombie_dog_run_turn_180_left)
    anim_str = "zombie_dog_run_turn_180_left";
  else if(animation == % zombie_dog_turn_180_right)
    anim_str = "zombie_dog_turn_180_right";
  else if(animation == % zombie_dog_run_turn_180_right)
    anim_str = "zombie_dog_run_turn_180_right";
  return anim_str;
}

do_turn_anim(stopped_anim, run_anim, wait_time, run_wait_time) {
  speed = length(self getaivelocity());
  do_anim = stopped_anim;
  if(level.dogRunTurnSpeed < speed) {
    do_anim = run_anim;
    wait_time = run_wait_time;
  }
  anim_str = get_anim_string(do_anim);
  self ClearAnim( % root, 0.2);
  self ClearAnim(anim.dogAnims[self.animSet].move["run_stop"], 0.2);
  clear_turn_anims();
  debug_anim_print("dog_move::do_turn_anim() - Setting " + anim_str);
  self SetFlaggedAnim("turn", do_anim, 1.0, 0.2, 1.0);
  self animscripts\shared::DoNoteTracks("turn");
  debug_anim_print("dog_move::turn_around_right() - done with " + anim_str + " wait time " + wait_time);
}

turn_left() {
  self do_turn_anim(anim.dogAnims[self.animSet].turn["90_left"], anim.dogAnims[self.animSet].runTurn["90_left"], 0.5, 0.5);
}

turn_right() {
  self do_turn_anim(anim.dogAnims[self.animSet].turn["90_right"], anim.dogAnims[self.animSet].runTurn["90_right"], 0.5, 0.5);
}

turn_180_left() {
  self do_turn_anim(anim.dogAnims[self.animSet].turn["180_left"], anim.dogAnims[self.animSet].runTurn["180_left"], 0.5, 0.7);
}

turn_180_right() {
  self do_turn_anim(anim.dogAnims[self.animSet].turn["180_right"], anim.dogAnims[self.animSet].runTurn["180_right"], 0.5, 0.7);
}

move_out_of_turn() {
  if(self.a.movement == "run") {
    weights = undefined;
    weights = self animscripts\zombie_dog_move::getRunAnimWeights();
    blendTime = 0.2;
    debug_anim_print("dog_move::move_out_of_turn() - Setting move_run");
    debug_anim_print("dog_move::move_out_of_turn() - blendTime: " + blendTime);
    debug_anim_print("dog_move::move_out_of_turn() - weights[ 'center' ]:	" + weights["center"]);
    debug_anim_print("dog_move::move_out_of_turn() - weights[ 'left' ]:	" + weights["left"]);
    debug_anim_print("dog_move::move_out_of_turn() - weights[ 'right' ]:	" + weights["right"]);
    self setanimrestart(anim.dogAnims[self.animSet].move["run"], weights["center"], blendTime, 1);
    self setanimrestart(anim.dogAnims[self.animSet].move["run_lean_L"], weights["left"], blendTime, 1);
    self setanimrestart(anim.dogAnims[self.animSet].move["run_lean_R"], weights["right"], blendTime, 1);
    self setflaggedanimknob("dog_run", anim.dogAnims[self.animSet].move["run_knob"], 1, blendTime, self.moveplaybackrate);
    animscripts\shared::DoNoteTracksForTime(0.1, "done");
    debug_anim_print("dog_move::move_out_of_turn() - move_run wait 0.1 done ");
  } else {
    debug_anim_print("dog_move::move_out_of_turn() - Setting move_start");
    self setflaggedanimrestart("dog_walk", anim.dogAnims[self.animSet].move["walk"], 1, 0.2, self.moveplaybackrate);
  }
}

turn_90(deltaYaw) {
  self animMode("zonly_physics");
  debug_turn_print("turn_90 deltaYaw: " + deltaYaw);
  if(deltaYaw > GetDvarFloat(#"dog_turn90_angle")) {
    debug_turn_print("turn_90 left", true);
    self turn_left();
  } else {
    debug_turn_print("turn_90 right", true);
    self turn_right();
  }
}

turn_180(deltaYaw) {
  self animMode("zonly_physics");
  debug_turn_print("turn_180 deltaYaw: " + deltaYaw);
  if(deltaYaw > 177 || deltaYaw < -177) {
    if(randomInt(2) == 0) {
      debug_turn_print("turn_around random right", true);
      self turn_180_right();
    } else {
      debug_turn_print("turn_around random left", true);
      self turn_180_left();
    }
  } else if(deltaYaw > GetDvarFloat(#"dog_turn180_angle")) {
    debug_turn_print("turn_around left", true);
    self turn_180_left();
  } else {
    debug_turn_print("turn_around right", true);
    self turn_180_right();
  }
}