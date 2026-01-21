/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\setposemovement.gsc
*****************************************************/

#include animscripts\Utility;
#include maps\_Utility;
#include common_scripts\utility;
#using_animtree("generic_human");

SetPoseMovement(desiredPose, desiredMovement) {
  if(desiredPose == "") {
    if((self.a.pose == "prone") && ((desiredMovement == "walk") || (desiredMovement == "run")))
      desiredPose = "crouch";
    else
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
  anim.SetPoseMovementFnArray["prone"]["stop"] = ::BeginProneStop;
  anim.SetPoseMovementFnArray["prone"]["walk"] = ::BeginProneWalk;
  anim.SetPoseMovementFnArray["prone"]["run"] = ::BeginProneRun;
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
      assert(self.a.pose == "prone");
      switch (self.a.movement) {
        case "stop":
          ProneToStand();
          break;
        default:
          assert(self.a.movement == "walk" || self.a.movement == "run");
          ProneToStand();
          break;
      }
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
      assert(self.a.pose == "prone");
      ProneToStandWalk();
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
      assert(self.a.pose == "prone");
      ProneToStandRun();
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
    case "prone":
      ProneToCrouch();
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
      assert(self.a.pose == "prone");
      ProneToCrouchWalk();
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
      assert(self.a.pose == "prone");
      ProneToCrouchRun();
      break;
  }
  return true;
}

BeginProneStop() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          StandToProne();
          break;
        case "walk":
          StandToProne();
          break;
        case "run":
          CrouchRunToProne();
          break;
        default:
          assertEX(0, "SetPoseMovement::BeginCrouchRun " + self.a.pose + " " + self.a.movement);
      }
      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          CrouchToProne();
          break;
        case "walk":
          CrouchToProne();
          break;
        case "run":
          CrouchRunToProne();
          break;
        default:
          assertEX(0, "SetPoseMovement::BeginCrouchRun " + self.a.pose + " " + self.a.movement);
      }
      break;
    case "prone":
      switch (self.a.movement) {
        case "stop":
          break;
        case "walk":
        case "run":
          ProneCrawlToProne();
          break;
        default:
          assertEX(0, "SetPoseMovement::BeginCrouchRun " + self.a.pose + " " + self.a.movement);
      }
      break;
    default:
      assertEX(0, "SetPoseMovement::BeginCrouchRun " + self.a.pose + " " + self.a.movement);
  }
}

BeginProneWalk() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          StandToProneWalk();
          break;
        default:
          assert(self.a.movement == "run" || self.a.movement == "walk");
          CrouchRunToProneWalk();
          break;
      }
      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          CrouchToProneWalk();
          break;
        default:
          assert(self.a.movement == "run" || self.a.movement == "walk");
          CrouchRunToProneWalk();
          break;
      }
      break;
    default:
      assert(self.a.pose == "prone");
      switch (self.a.movement) {
        case "stop":
          ProneToProneRun();
          break;
        default:
          assert(self.a.movement == "run" || self.a.movement == "walk");
          self.a.movement = "walk";
          return false;
      }
      break;
  }
  return true;
}

BeginProneRun() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          StandToProneRun();
          break;
        default:
          assert(self.a.movement == "run" || self.a.movement == "walk");
          CrouchRunToProneRun();
          break;
      }
      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          CrouchToProneRun();
          break;
        default:
          assert(self.a.movement == "run" || self.a.movement == "walk");
          CrouchRunToProneRun();
          break;
      }
      break;
    default:
      assert(self.a.pose == "prone");
      switch (self.a.movement) {
        case "stop":
          assert(self.a.movement == "stop");
          ProneToProneRun();
          break;
        default:
          assert(self.a.movement == "run" || self.a.movement == "walk");
          self.a.movement = "run";
          return false;
      }
      break;
  }
  return true;
}

PlayBlendTransition(transAnim, crossblendTime, endPose, endMovement, endAiming) {
  endTime = gettime() + crossblendTime * 1000;
  self setflaggedanimknoball("blendTransition", transAnim, %body, 1, crossblendTime, 1);
  wait crossblendTime / 2;
  self.a.pose = endPose;
  self.a.movement = endMovement;
  if(endAiming)
    self.a.alertness = "aiming";
  else
    self.a.alertness = "casual";
  waittime = (endTime - gettime()) / 1000;
  if(waittime < 0.05)
    waittime = 0.05;
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
  transtime = 0.3;
  if(self.a.movement != "stop") {
    self endon("movemode");
    transtime = 1.0;
  }
  PlayBlendTransition(animname, transtime, "stand", "run", 0);
}

BlendIntoStandRun() {
  if(self animscripts\utility::IsInCombat()) {
    if(isDefined(self.run_combatanim)) {
      PlayBlendTransitionStandRun(self.run_combatanim);
    } else {
      runAnimTransTime = 0.0;
      if(self.a.movement != "stop")
        runAnimTransTime = 0.5;
      self setAnimKnobLimited(animscripts\run::GetRunAnim(), 1, runAnimTransTime, 1);
      self thread animscripts\run::UpdateRunWeights("BlendIntoStandRun", %combatrun_forward, %run_lowready_B, %run_lowready_L, %run_lowready_R);
      PlayBlendTransitionStandRun(%combatrun);
    }
  } else {
    if(isDefined(self.run_noncombatanim)) {
      PlayBlendTransitionStandRun(self.run_noncombatanim);
    } else {
      runAnimTransTime = 0.0;
      if(self.a.movement != "stop")
        runAnimTransTime = 0.5;
      self setAnimKnobLimited(animscripts\run::GetRunAnim(), 1, runAnimTransTime, 1);
      self thread animscripts\run::UpdateRunWeights("BlendIntoStandRun", %combatrun_forward, %run_lowready_B, %run_lowready_L, %run_lowready_R);
      PlayBlendTransitionStandRun(%combatrun);
    }
  }
  self notify("BlendIntoStandRun");
}

PlayBlendTransitionStandWalk(animname) {
  if(self.a.movement != "stop")
    self endon("movemode");
  PlayBlendTransition(animname, 0.6, "stand", "walk", 1);
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
  if((self animscripts\utility::weaponAnims() == "pistol") || (self animscripts\utility::weaponAnims() == "none")) {
    PlayTransitionAnimation(%pistol_crouchaimstraight2stand, "stand", "stop", standSpeed);
  } else {
    self randomizeIdleSet();
    PlayTransitionAnimation(%crouch2stand, "stand", "stop", standSpeed);
  }
  self clearanim(%shoot, 0);
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
    self setanimknoball(self.crouchrun_combatanim, %body, 1, 0.4);
    PlayBlendTransition(self.crouchrun_combatanim, 0.6, "crouch", "run", 0);
    self notify("BlendIntoCrouchRun");
  } else {
    self setanimknob(animscripts\run::GetCrouchRunAnim(), 1, 0.4);
    self thread animscripts\run::UpdateRunWeights("BlendIntoCrouchRun", %crouch_fastwalk_F, %crouch_fastwalk_B, %crouch_fastwalk_L, %crouch_fastwalk_R);
    PlayBlendTransition(%crouchrun, 0.6, "crouch", "run", 0);
    self notify("BlendIntoCrouchRun");
  }
}

ProneToCrouchRun() {
  assertEX(self.a.pose == "prone", "SetPoseMovement::ProneToCrouchRun " + self.a.pose);
  self OrientMode("face current");
  self ExitProneWrapper(1.0);
  ProneLegsStraightTree(0.2);
  self animscripts\cover_prone::UpdateProneWrapper(0.1);
  PlayTransitionAnimation(%prone2crouchrun_straight, "crouch", "run", 0, %crouch_fastwalk_F);
}

ProneToStandRun() {
  ProneToCrouchRun();
  BlendIntoStandRun();
}

ProneToCrouchWalk() {
  ProneToCrouchRun();
  BlendIntoCrouchWalk();
}

BlendIntoCrouchWalk() {
  if(isDefined(self.crouchrun_combatanim)) {
    self setanimknoball(self.crouchrun_combatanim, %body, 1, 0.4);
    PlayBlendTransition(self.crouchrun_combatanim, 0.6, "crouch", "walk", 0);
    self notify("BlendIntoCrouchWalk");
  } else {
    PlayBlendTransition(%crouch_fastwalk_F, 0.8, "crouch", "walk", 1);
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
    self clearanim(%shoot, 0);
    return;
  }
  if(!isDefined(self.exposedSet) || self.exposedSet == 0) {
    PlayTransitionAnimation(%exposed_stand_2_crouch, "crouch", "stop", 1, undefined, crouchspeed);
  } else {
    PlayTransitionAnimation(%exposed2_stand_2_crouch, "crouch", "stop", 1, undefined, crouchspeed);
  }
  self clearanim(%shoot, 0);
}

ProneToCrouch() {
  assertEX(self.a.pose == "prone", "SetPoseMovement::StandToCrouch " + self.a.pose);
  self randomizeIdleSet();
  self OrientMode("face current");
  self ExitProneWrapper(1.0);
  ProneLegsStraightTree(0.1);
  self animscripts\cover_prone::UpdateProneWrapper(0.1);
  PlayTransitionAnimation(%prone_2_crouch, "crouch", "stop", 1);
}

ProneToStand() {
  assertEx(self.a.pose == "prone", self.a.pose);
  self OrientMode("face current");
  self ExitProneWrapper(1.0);
  ProneLegsStraightTree(0.1);
  self animscripts\cover_prone::UpdateProneWrapper(0.1);
  PlayTransitionAnimation(%prone_2_stand, "stand", "stop", 1);
}

ProneToStandWalk() {
  ProneToCrouch();
  CrouchToCrouchWalk();
  BlendIntoStandWalk();
}

ProneToProneMove(movement) {
  assertEX(self.a.pose == "prone", "SetPoseMovement::ProneToProneMove " + self.a.pose);
  assertEX(self.a.movement == "stop", "SetPoseMovement::ProneToProneMove " + self.a.movement);
  assertEX((movement == "walk" || movement == "run"), "SetPoseMovement::ProneToProneMove got bad parameter " + movement);
  ProneLegsStraightTree(0.1);
  PlayTransitionAnimation(%prone_aim2crawl, "prone", movement, 0, %prone_crawl);
  self animscripts\cover_prone::UpdateProneWrapper(0.1);
}

ProneToProneRun() {
  ProneToProneMove("run");
}

ProneCrawlToProne() {
  assertEX(self.a.pose == "prone", "SetPoseMovement::ProneCrawlToProne " + self.a.pose);
  assertEX((self.a.movement == "walk" || self.a.movement == "run"), "SetPoseMovement::ProneCrawlToProne " + self.a.movement);
  ProneLegsStraightTree(0.1);
  self animscripts\cover_prone::UpdateProneWrapper(0.1);
  PlayTransitionAnimation(%prone_crawl2aim, "prone", "stop", 1);
}

CrouchToProne() {
  assertEX(self.a.pose == "crouch", "SetPoseMovement::CrouchToProne " + self.a.pose);
  self setProneAnimNodes(-45, 45, %prone_legs_down, %exposed_aiming, %prone_legs_up);
  self EnterProneWrapper(1.0);
  ProneLegsStraightTree(0.3);
  self animscripts\cover_prone::UpdateProneWrapper(0.1);
  PlayTransitionAnimation(%crouch_2_prone, "prone", "stop", 1);
}

CrouchToProneWalk() {
  CrouchToProne();
  ProneToProneRun();
}

CrouchToProneRun() {
  CrouchToProne();
  ProneToProneRun();
}

StandToProne() {
  assertEX(self.a.pose == "stand", "SetPoseMovement::StandToProne " + self.a.pose);
  self endon("entered_pose" + "prone");
  proneTime = 0.5;
  thread PlayTransitionAnimationThread_WithoutWaitSetStates(%stand2prone_onehand, "prone", "stop", proneTime);
  self waittillmatch("transAnimDone2", "anim_pose = \"crouch\"");
  waittillframeend;
  self setProneAnimNodes(-45, 45, %prone_legs_down, %exposed_aiming, %prone_legs_up);
  self EnterProneWrapper(proneTime);
  self.a.movement = "stop";
  ProneLegsStraightTree(0.2);
  self animscripts\cover_prone::UpdateProneWrapper(0.1);
  self waittillmatch("transAnimDone2", "end");
}

StandToProneWalk() {
  StandToProne();
  ProneToProneRun();
}

StandToProneRun() {
  StandToProne();
  ProneToProneRun();
}

CrouchRunToProne() {
  assertEX((self.a.pose == "crouch") || (self.a.pose == "stand"), "SetPoseMovement::CrouchRunToProne " + self.a.pose);
  assertEX((self.a.movement == "run" || self.a.movement == "walk"), "SetPoseMovement::CrouchRunToProne " + self.a.movement);
  pronetime = 0.5;
  self setProneAnimNodes(-45, 45, %prone_legs_down, %exposed_aiming, %prone_legs_up);
  self EnterProneWrapper(proneTime);
  ProneLegsStraightTree(0.2);
  self animscripts\cover_prone::UpdateProneWrapper(0.1);
  runDirection = animscripts\utility::getQuadrant(self getMotionAngle());
  diveanim = % crouch_2_prone;
  localDeltaVector = GetMoveDelta(diveanim, 0, 1);
  endPoint = self LocalToWorldCoords(localDeltaVector);
  if(self maymovetopoint(endPoint)) {
    PlayTransitionAnimation(diveanim, "prone", "stop", pronetime);
  } else {
    PlayTransitionAnimation(%crouch2prone_gunsupport, "prone", "stop", pronetime);
  }
}

CrouchRunToProneWalk() {
  CrouchRunToProne();
  ProneToProneRun();
}

CrouchRunToProneRun() {
  CrouchRunToProne();
  ProneToProneRun();
}

PlayTransitionAnimation2(transAnim, endPose, endMovement, endAiming, finalAnim) {
  self setflaggedanimknoball("transAnimDone1", transAnim, %body, 1, .05, 1);
  if(!isDefined(self.a.pose))
    self.pose = "undefined";
  if(!isDefined(self.a.movement))
    self.movement = "undefined";
  debugIdentifier = self.a.pose + " to " + endPose + ", " + self.a.movement + " to " + endMovement;
  self animscripts\shared::DoNoteTracks("transAnimDone1", undefined, debugIdentifier);
  self.a.pose = endPose;
  self.a.movement = endMovement;
  if(endAiming)
    self.a.alertness = "aiming";
  else
    self.a.alertness = "casual";
  if(isDefined(finalAnim)) {
    self setanimknoball(finalAnim, %body, 1, 0, 1);
  }
}

PlayTransitionAnimationThread_WithoutWaitSetStates(transAnim, endPose, endMovement, endAiming, finalAnim, rate) {
  self endon("killanimscript");
  self endon("entered_pose" + endPose);
  PlayTransitionAnimationFunc(transAnim, endPose, endMovement, endAiming, finalAnim, rate, false);
}

PlayTransitionAnimation(transAnim, endPose, endMovement, endAiming, finalAnim, rate) {
  PlayTransitionAnimationFunc(transAnim, endPose, endMovement, endAiming, finalAnim, rate, true);
}

PlayTransitionAnimationFunc(transAnim, endPose, endMovement, endAiming, finalAnim, rate, waitSetStatesEnabled) {
  if(!isDefined(rate))
    rate = 1;
  if(getdebugdvar("debug_grenadehand") == "on") {
    if(endPose != self.a.pose) {
      if(!animhasnotetrack(transAnim, "anim_pose = \"" + endPose + "\"")) {
        println("Animation ", transAnim, " lacks an endpose notetrack of ", endPose);
        assertEx(0, "A transition animation is missing a pose notetrack (see the line above)");
      }
    }
    if(endMovement != self.a.movement) {
      if(!animhasnotetrack(transAnim, "anim_movement = \"" + endMovement + "\"")) {
        println("Animation ", transAnim, " lacks an endmovement notetrack of ", endMovement);
        assertEx(0, "A transition animation is missing a movement notetrack (see the line above)");
      }
    }
  }
  if(waitSetStatesEnabled)
    self thread waitSetStates(getanimlength(transAnim) / 2.0, "killtimerscript", endPose);
  self setflaggedanimknoballrestart("transAnimDone2", transAnim, %body, 1, .2, rate);
  if(!isDefined(self.a.pose))
    self.pose = "undefined";
  if(!isDefined(self.a.movement))
    self.movement = "undefined";
  debugIdentifier = "";
  debugIdentifier = self.a.script + ", " + self.a.pose + " to " + endPose + ", " + self.a.movement + " to " + endMovement;
  self animscripts\shared::DoNoteTracks("transAnimDone2", undefined, debugIdentifier);
  self notify("killtimerscript");
  self.a.pose = endPose;
  self notify("entered_pose" + endPose);
  self.a.movement = endMovement;
  if(endAiming)
    self.a.alertness = "aiming";
  else
    self.a.alertness = "casual";
  if(isDefined(finalAnim)) {
    self setanimknoball(finalAnim, %body, 1, 0.3, rate);
  }
}

waitSetStates(timetowait, killmestring, endPose) {
  self endon("killanimscript");
  self endon("death");
  self endon(killmestring);
  oldpose = self.a.pose;
  wait timetowait;
  if(oldpose != "prone" && endPose == "prone") {
    self animscripts\cover_prone::UpdateProneWrapper(0.1);
    self EnterProneWrapper(1.0);
  } else
  if(oldpose == "prone" && endPose != "prone") {
    self ExitProneWrapper(1.0);
    self OrientMode("face default");
  }
}

ProneLegsStraightTree(blendtime) {
  self setanimknoball(%prone_legsstraight, %body, 1, blendtime, 1);
}