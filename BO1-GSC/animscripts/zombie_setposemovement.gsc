/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\zombie_setposemovement.gsc
**************************************************/

#include animscripts\zombie_Utility;
#include maps\_Utility;
#include common_scripts\utility;
#using_animtree("generic_human");

SetPoseMovement(desiredPose, desiredMovement) {
  if(desiredPose == "") {
    desiredPose = self.a.pose;
  }
  if(!isDefined(desiredMovement) || desiredMovement == "") {
    desiredMovement = self.a.movement;
  }
  [[anim.SetPoseMovementFnArray[desiredPose][desiredMovement]]]();
}
InitPoseMovementFunctions() {
  anim.SetPoseMovementFnArray["stand"]["stop"] = ::BeginStandStop;
  anim.SetPoseMovementFnArray["stand"]["walk"] = ::BeginStandWalk;
  anim.SetPoseMovementFnArray["stand"]["run"] = ::BeginStandRun;
  anim.SetPoseMovementFnArray["crouch"]["stop"] = ::BeginCrouchStop;
  anim.SetPoseMovementFnArray["crouch"]["walk"] = ::BeginCrouchWalk;
  anim.SetPoseMovementFnArray["crouch"]["run"] = ::BeginCrouchRun;
}
BeginStandStop() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          return false;
        case "walk":
          StandWalkToStand();
          break;
        default:
          assert(self.a.movement == "run");
          StandRunToStand();
          break;
      }
      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          CrouchToStand();
          break;
        case "walk":
          CrouchWalkToStand();
          break;
        default:
          assert(self.a.movement == "run");
          CrouchRunToStand();
          break;
      }
      break;
    default:
      assertEX(0, "SetPoseMovement::BeginStandStop " + self.a.pose + " " + self.a.movement);
      break;
  }
  return true;
}
BeginStandWalk() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          BlendIntoStandWalk();
          break;
        case "walk":
          return false;
        default:
          assert(self.a.movement == "run");
          BlendIntoStandWalk();
          break;
      }
      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          CrouchToStandWalk();
          break;
        case "walk":
          BlendIntoStandWalk();
          break;
        default:
          assert(self.a.movement == "run");
          BlendIntoStandWalk();
          break;
      }
      break;
    default:
      assertEX(0, "SetPoseMovement::BeginStandWalk " + self.a.pose + " " + self.a.movement);
      break;
  }
  return true;
}
BeginStandRun() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          BlendIntoStandRun();
          break;
        case "walk":
          BlendIntoStandRun();
          break;
        default:
          assert(self.a.movement == "run");
          return false;
      }
      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          CrouchToStandRun();
          break;
        default:
          assert(self.a.movement == "run" || self.a.movement == "walk");
          BlendIntoStandRun();
          break;
      }
      break;
    default:
      assertEX(0, "SetPoseMovement::BeginStandRun " + self.a.pose + " " + self.a.movement);
      break;
  }
  return true;
}
BeginCrouchStop() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          StandToCrouch();
          break;
        case "walk":
          StandWalkToCrouch();
          break;
        case "run":
          StandRunToCrouch();
          break;
        default:
          assertEX(0, "SetPoseMovement::BeginCrouchStop " + self.a.pose + " " + self.a.movement);
      }
      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          break;
        case "walk":
          CrouchWalkToCrouch();
          break;
        case "run":
          CrouchRunToCrouch();
          break;
        default:
          assertEX(0, "SetPoseMovement::BeginCrouchStop " + self.a.pose + " " + self.a.movement);
      }
      break;
    default:
      assertEX(0, "SetPoseMovement::BeginCrouchStop " + self.a.pose + " " + self.a.movement);
  }
}
BeginCrouchWalk() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          BlendIntoStandWalk();
          BlendIntoCrouchWalk();
          break;
        case "walk":
          BlendIntoCrouchWalk();
          break;
        default:
          assert(self.a.movement == "run");
          BlendIntoCrouchWalk();
          break;
      }
      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          CrouchToCrouchWalk();
          break;
        case "walk":
          return false;
        default:
          assert(self.a.movement == "run");
          BlendIntoCrouchWalk();
          break;
      }
      break;
    default:
      assertEX(0, "SetPoseMovement::BeginCrouchWalk " + self.a.pose + " " + self.a.movement);
      break;
  }
  return true;
}
BeginCrouchRun() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          BlendIntoStandRun();
          BlendIntoCrouchRun();
          break;
        default:
          assert(self.a.movement == "run" || self.a.movement == "walk");
          BlendIntoCrouchRun();
          break;
      }
      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          CrouchToCrouchRun();
          break;
        case "walk":
          BlendIntoCrouchRun();
          break;
        default:
          assert(self.a.movement == "run");
          return false;
      }
      break;
    default:
      assertEX(0, "SetPoseMovement::BeginCrouchRun " + self.a.pose + " " + self.a.movement);
      break;
  }
  return true;
}
PlayBlendTransition(transAnim, crossblendTime, endPose, endMovement) {
  endTime = GetTime() + crossblendTime * 1000;
  self SetFlaggedAnimKnobAll("blendTransition", transAnim, %body, 1, crossblendTime, 1);
  wait crossblendTime / 2;
  self.a.pose = endPose;
  self.a.movement = endMovement;
  self.a.alertness = "casual";
  waittime = (endTime - GetTime()) / 1000;
  if(waittime < 0.05) {
    waittime = 0.05;
  }
  wait waittime;
}
PlayTransitionStandWalk(transAnim, finalAnim) {
  PlayTransitionAnimation(transAnim, "stand", "walk", 1, finalAnim);
}
StandWalkToStand() {
  assertEX(self.a.pose == "stand", "SetPoseMovement::StandWalkToStand " + self.a.pose);
  assertEX(self.a.movement == "walk", "SetPoseMovement::StandWalkToStand " + self.a.movement);
  self.a.movement = "stop";
}
StandWalkToCrouch() {
  StandWalkToStand();
  StandToCrouch();
}
StandRunToStand() {
  assertEX(self.a.pose == "stand", "SetPoseMovement::StandRunToStand " + self.a.pose);
  assertEX(self.a.movement == "run", "SetPoseMovement::StandRunToStand " + self.a.movement);
  self.a.movement = "stop";
}
StandRunToCrouch() {
  self.a.movement = "stop";
  self.a.pose = "crouch";
}
PlayBlendTransitionStandRun(animname) {
  transtime = 0.2;
  PlayBlendTransition(animname, transtime, "stand", "run");
}
BlendIntoStandRun() {
  if(self animscripts\utility::IsInCombat()) {
    if(isDefined(self.run_combatanim)) {
      PlayBlendTransitionStandRun(self.run_combatanim);
    } else {
      self SetAnimKnobLimited(animscripts\zombie_run::GetRunAnim(), 1, 0.2, 1);
      useLeans = GetDvarInt(#"ai_useLeanRunAnimations");
      if(useLeans && self.isfacingmotion) {
        self thread animscripts\zombie_run::UpdateRunWeights("BlendIntoStandRun", %combatrun_forward, %run_lowready_B, %ai_run_lowready_f_lean_l, %ai_run_lowready_f_lean_r);
      } else {
        self thread animscripts\zombie_run::UpdateRunWeights("BlendIntoStandRun", %combatrun_forward, %run_lowready_B, %run_lowready_L, %run_lowready_R);
      }
      PlayBlendTransitionStandRun(%combatrun);
    }
  } else {
    if(isDefined(self.run_noncombatanim)) {
      PlayBlendTransitionStandRun(self.run_noncombatanim);
    } else {
      self SetAnimKnobLimited(animscripts\zombie_run::GetRunAnim(), 1, 0.2, 1);
      useLeans = GetDvarInt(#"ai_useLeanRunAnimations");
      if(useLeans && self.isfacingmotion) {
        self thread animscripts\zombie_run::UpdateRunWeights("BlendIntoStandRun", %combatrun_forward, %run_lowready_B, %ai_run_lowready_f_lean_l, %ai_run_lowready_f_lean_r);
      } else {
        self thread animscripts\zombie_run::UpdateRunWeights("BlendIntoStandRun", %combatrun_forward, %run_lowready_B, %run_lowready_L, %run_lowready_R);
      }
      PlayBlendTransitionStandRun(%combatrun);
    }
  }
  self notify("BlendIntoStandRun");
}
PlayBlendTransitionStandWalk(animname) {
  if(self.a.movement != "stop") {
    self endon("movemode");
  }
  PlayBlendTransition(animname, 0.2, "stand", "walk");
}
BlendIntoStandWalk() {
  walkanim = animscripts\walk::getStandWalkAnim();
  PlayBlendTransitionStandWalk(walkanim);
}
CrouchToStand() {
  assertEX(self.a.pose == "crouch", "SetPoseMovement::CrouchToStand " + self.a.pose);
  assertEX(self.a.movement == "stop", "SetPoseMovement::CrouchToStand " + self.a.movement);
  standSpeed = 0.5;
  if(isDefined(self.fastStand)) {
    standSpeed = 1.8;
    self.fastStand = undefined;
  }
  self randomizeIdleSet();
  PlayTransitionAnimation(%crouch2stand, "stand", "stop", standSpeed);
}
CrouchToCrouchWalk() {
  assertEX(self.a.pose == "crouch", "SetPoseMovement::CrouchToCrouchWalk " + self.a.pose);
  assertEX(self.a.movement == "stop", "SetPoseMovement::CrouchToCrouchWalk " + self.a.movement);
  BlendIntoCrouchWalk();
}
CrouchToStandWalk() {
  CrouchToCrouchWalk();
  BlendIntoStandWalk();
}
CrouchWalkToCrouch() {
  assertEX(self.a.pose == "crouch", "SetPoseMovement::CrouchWalkToCrouch " + self.a.pose);
  assertEX(self.a.movement == "walk", "SetPoseMovement::CrouchWalkToCrouch " + self.a.movement);
  self.a.movement = "stop";
}
CrouchWalkToStand() {
  CrouchWalkToCrouch();
  CrouchToStand();
}
CrouchRunToCrouch() {
  assertEX(self.a.pose == "crouch", "SetPoseMovement::CrouchRunToCrouch " + self.a.pose);
  assertEX(self.a.movement == "run", "SetPoseMovement::CrouchRunToCrouch " + self.a.movement);
  self.a.movement = "stop";
}
CrouchRunToStand() {
  CrouchRunToCrouch();
  CrouchToStand();
}
CrouchToCrouchRun() {
  assertEX(self.a.pose == "crouch", "SetPoseMovement::CrouchToCrouchRun " + self.a.pose);
  assertEX(self.a.movement == "stop", "SetPoseMovement::CrouchToCrouchRun " + self.a.movement);
  BlendIntoCrouchRun();
}
CrouchToStandRun() {
  BlendIntoStandRun();
}
BlendIntoCrouchRun() {
  if(isDefined(self.crouchrun_combatanim)) {
    self SetAnimKnobAll(self.crouchrun_combatanim, %body, 1, 0.2);
    PlayBlendTransition(self.crouchrun_combatanim, 0.2, "crouch", "run");
    self notify("BlendIntoCrouchRun");
  } else {
    self setanimknob(animscripts\zombie_run::GetCrouchRunAnim(), 1, 0.2);
    self thread animscripts\zombie_run::UpdateRunWeights("BlendIntoCrouchRun", %crouch_fastwalk_F, %crouch_fastwalk_B, %crouch_fastwalk_L, %crouch_fastwalk_R);
    PlayBlendTransition(%combatrun_forward, 0.2, "crouch", "run");
    self notify("BlendIntoCrouchRun");
  }
}
BlendIntoCrouchWalk() {
  if(isDefined(self.crouchrun_combatanim)) {
    self SetAnimKnobAll(self.crouchrun_combatanim, %body, 1, 0.2);
    PlayBlendTransition(self.crouchrun_combatanim, 0.2, "crouch", "walk");
    self notify("BlendIntoCrouchWalk");
  } else {
    PlayBlendTransition(%crouch_fastwalk_F, 0.2, "crouch", "walk");
  }
}
StandToCrouch() {
  assertEX(self.a.pose == "stand", "SetPoseMovement::StandToCrouch " + self.a.pose);
  assertEX(self.a.movement == "stop", "SetPoseMovement::StandToCrouch " + self.a.movement);
  self randomizeIdleSet();
  crouchSpeed = 0.5;
  if(isDefined(self.fastCrouch)) {
    crouchSpeed = 1.8;
    self.fastCrouch = undefined;
  }
  if(self is_zombie()) {
    return;
  }
  PlayTransitionAnimation(%exposed_stand_2_crouch, "crouch", "stop", 1, undefined, crouchspeed);
}
PlayTransitionAnimation2(transAnim, endPose, endMovement, finalAnim) {
  self SetFlaggedAnimKnobAll("transAnimDone1", transAnim, %body, 1, 0.2, 1);
  if(!isDefined(self.a.pose)) {
    self.pose = "undefined";
  }
  if(!isDefined(self.a.movement)) {
    self.movement = "undefined";
  }
  debugIdentifier = self.a.pose + " to " + endPose + ", " + self.a.movement + " to " + endMovement;
  self animscripts\zombie_shared::DoNoteTracks("transAnimDone1", undefined, debugIdentifier);
  self.a.pose = endPose;
  self.a.movement = endMovement;
  self.a.alertness = "casual";
  if(isDefined(finalAnim)) {
    self SetAnimKnobAll(finalAnim, %body, 1, 0.2, 1);
  }
}
PlayTransitionAnimationThread_WithoutWaitSetStates(transAnim, endPose, endMovement, finalAnim, rate) {
  self endon("killanimscript");
  self endon("entered_pose" + endPose);
  PlayTransitionAnimationFunc(transAnim, endPose, endMovement, finalAnim, rate, false);
}
PlayTransitionAnimation(transAnim, endPose, endMovement, finalAnim, rate) {
  PlayTransitionAnimationFunc(transAnim, endPose, endMovement, finalAnim, rate, true);
}
PlayTransitionAnimationFunc(transAnim, endPose, endMovement, finalAnim, rate, waitSetStatesEnabled) {
  if(!isDefined(rate)) {
    rate = 1;
  }
  if(waitSetStatesEnabled) {
    self thread waitSetStates(getanimlength(transAnim) / 2.0, "killtimerscript", endPose);
  }
  self SetFlaggedAnimKnobAllRestart("transAnimDone2", transAnim, %body, 1, .2, rate);
  if(!isDefined(self.a.pose)) {
    self.pose = "undefined";
  }
  if(!isDefined(self.a.movement)) {
    self.movement = "undefined";
  }
  debugIdentifier = "";
  self animscripts\zombie_shared::DoNoteTracks("transAnimDone2", undefined, debugIdentifier);
  self notify("killtimerscript");
  self.a.pose = endPose;
  self notify("entered_pose" + endPose);
  self.a.movement = endMovement;
  self.a.alertness = "casual";
  if(isDefined(finalAnim)) {
    self SetAnimKnobAll(finalAnim, %body, 1, 0.2, rate);
  }
}
waitSetStates(timetowait, killmestring, endPose) {
  self endon("killanimscript");
  self endon("death");
  self endon(killmestring);
  oldpose = self.a.pose;
  wait timetowait;
}