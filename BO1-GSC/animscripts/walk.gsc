/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\walk.gsc
**************************************/

#include animscripts\SetPoseMovement;
#include animscripts\Utility;
#include animscripts\anims;
#include maps\_utility;
#using_animtree("generic_human");
MoveWalk() {
  desiredPose = self animscripts\utility::choosePose();
  switch (desiredPose) {
    case "stand":
      if(BeginStandWalk()) {
        return;
      }
      walkAnim = getStandWalkAnim();
      DoWalkAnim(walkAnim);
      break;
    case "crouch":
      if(BeginCrouchWalk()) {
        return;
      }
      DoWalkAnim(animArray("combat_run_f"));
      break;
    default:
      assert(desiredPose == "prone");
      if(BeginProneWalk()) {
        return;
      }
      self.a.movement = "walk";
      DoWalkAnim(animArray("combat_run_f"));
      break;
  }
}

DoWalkAnim(walkAnim) {
  self endon("movemode");
  self SetFlaggedAnimKnobAll("walkanim", walkAnim, %body, 1, 1.2, 1);
  if(self.a.pose != "prone") {
    self call_overloaded_func("animscripts\run", "UpdateRunWeightsOnce", %combatrun_forward, animArray("walk_b"), animArray("walk_l"), animArray("walk_r"));
  }
  self animscripts\shared::DoNoteTracksForTime(0.2, "walkanim");
}

getStandWalkAnim() {
  if((isDefined(self.walk_combatanim)) && (self animscripts\utility::IsInCombat())) {
    rand = randomInt(10);
    if((rand < 2) && (isDefined(self.walk_combatanim2))) {
      return self.walk_combatanim2;
    } else {
      return self.walk_combatanim;
    }
  } else if((isDefined(self.walk_noncombatanim)) && (!self animscripts\utility::IsInCombat())) {
    rand = randomInt(10);
    if((rand < 2) && (isDefined(self.walk_noncombatanim2))) {
      return self.walk_noncombatanim2;
    } else {
      return self.walk_noncombatanim;
    }
  } else {
    return animArray("walk_f");
  }
}