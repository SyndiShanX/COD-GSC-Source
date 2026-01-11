/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\zombie_move.gsc
***************************************/

#include animscripts\zombie_SetPoseMovement;
#include animscripts\combat_utility;
#include animscripts\zombie_utility;
#include animscripts\zombie_shared;
#include common_scripts\utility;
#using_animtree("generic_human");
main() {
  self endon("killanimscript");
  [[self.exception["move"]]]();
  previousScript = self.a.script;
  animscripts\zombie_utility::initialize("zombie_move");
  if(self.moveMode == "run") {
    switch (previousScript) {
      case "combat":
      case "stop":
        self animscripts\battleChatter_ai::evaluateMoveEvent(false);
        break;
      case "cover_crouch":
      case "cover_left":
      case "cover_right":
      case "cover_stand":
      case "concealment_crouch":
      case "concealment_stand":
      case "cover_wide_left":
      case "cover_wide_right":
      case "stalingrad_cover_crouch":
      case "Hide":
      case "turret":
        self animscripts\battleChatter_ai::evaluateMoveEvent(true);
        break;
      default:
        self animscripts\battleChatter_ai::evaluateMoveEvent(false);
        break;
    }
  }
  MoveMainLoop();
}

MoveMainLoop() {
  prevLoopTime = self getAnimTime( % walk_and_run_loops);
  self.a.runLoopCount = randomInt(10000);
  moveMode = self.moveMode;
  if(isDefined(self.pathGoalPos) && distanceSquared(self.origin, self.pathGoalPos) < 4096) {
    moveMode = "walk";
  }
  self.needs_run_update = true;
  self sideStepInit();
  for(;;) {
    loopTime = self getAnimTime( % walk_and_run_loops);
    if(loopTime < prevLoopTime) {
      self.a.runLoopCount++;
    }
    prevLoopTime = loopTime;
    self animscripts\face::SetIdleFaceDelayed(anim.alertface);
    self animscripts\zombie_run::MoveRun();
    self.exitingCover = false;
    self trySideStep();
  }
}

moveAgain() {
  self notify("killanimscript");
  animscripts\zombie_move::main();
}

sideStepInit() {
  self.a.steppedDir = 0;
  self.a.lastSideStepTime = GetTime();
  if(!isDefined(level.sideStepAnims)) {
    level.MIN_REACTION_DIST_SQ = 64 * 64;
    level.MAX_REACTION_DIST_SQ = 1000 * 1000;
    level.REACTION_INTERVAL = 2000;
    level.SIDE_STEP_CHANCE = 0.7;
    level.RIGHT_STEP_CHANCE = 0.5;
    level.FORWARD_REACTION_INTERVAL = 2000;
    level.FORWARD_MIN_REACTION_DIST_SQ = 120 * 120;
    level.FORWARD_MAX_REACTION_DIST_SQ = 2400 * 2400;
    level.sideStepAnims = [];
    level.sideStepAnims["step_left"] = array( % ai_zombie_spets_sidestep_left_a, % ai_zombie_spets_sidestep_left_b);
    level.sideStepAnims["step_right"] = array( % ai_zombie_spets_sidestep_right_a, % ai_zombie_spets_sidestep_right_b);
    level.sideStepAnims["roll_forward"] = array( % ai_zombie_spets_roll_a, % ai_zombie_spets_roll_b, % ai_zombie_spets_roll_c);
  }
}

trySideStep() {
  if(isDefined(self.shouldSideStepFunc)) {
    self.sideStepType = self[[self.shouldSideStepFunc]]();
  } else {
    self.sideStepType = shouldSideStep();
  }
  if(self.sideStepType == "none") {
    if(is_true(self.zombie_can_forwardstep)) {
      self.sideStepType = shouldForwardStep();
    }
  }
  if(self.sideStepType == "none") {
    return false;
  }
  self.desiredStepDir = getDesiredSideStepDir(self.sideStepType);
  animName = self.sideStepType + "_" + self.desiredStepDir;
  sideStepAnims = level.sideStepAnims;
  if(isDefined(self.sideStepAnims)) {
    sideStepAnims = self.sideStepAnims;
  }
  self.stepAnim = sideStepAnims[animName][randomInt(sideStepAnims[animName].size)];
  assertex(isDefined(self.stepAnim), "Sidestep anim " + animName + " not found");
  if(!self checkRoomForAnim(self.stepAnim)) {
    hasRoom = false;
    if(self.sideStepType == "roll" && self.desiredStepDir != "forward") {
      self.desiredStepDir = "forward";
      animName = self.sideStepType + "_" + self.desiredStepDir;
      self.stepAnim = sideStepAnims[animName][randomInt(sideStepAnims[animName].size)];
      assertex(isDefined(self.stepAnim), "Sidestep anim " + animName + " not found");
      hasRoom = self checkRoomForAnim(self.stepAnim);
    }
    if(!hasRoom) {
      return false;
    }
  }
  self AnimCustom(::doSideStep);
}

getDesiredSideStepDir(sideStepType) {
  if(sideStepType == "roll" || sideStepType == "phase") {
    self.desiredStepDir = "forward";
    return self.desiredStepDir;
  }
  AssertEx(sideStepType == "step", "Unsupported SideStepType");
  randomRoll = RandomFloat(1);
  if(self.a.steppedDir < 0) {
    self.desiredStepDir = "right";
  } else if(self.a.steppedDir > 0) {
    self.desiredStepDir = "left";
  } else if(randomRoll < level.RIGHT_STEP_CHANCE) {
    self.desiredStepDir = "right";
  } else if(randomRoll < level.RIGHT_STEP_CHANCE * 2) {
    self.desiredStepDir = "left";
  }
  return self.desiredStepDir;
}

checkRoomForAnim(stepAnim) {
  if(!self MayMoveFromPointToPoint(self.origin, getAnimEndPos(stepAnim))) {
    return false;
  }
  return true;
}

shouldSideStep() {
  if(canSideStep() && IsPlayer(self.enemy) && self.enemy IsLookingAt(self)) {
    if(self.zombie_move_speed != "sprint" || RandomFloat(1) < level.SIDE_STEP_CHANCE) {
      return "step";
    }
    else {
      return "roll";
    }
  }
  return "none";
}

canSideStep() {
  if(!isDefined(self.zombie_can_sidestep) || !self.zombie_can_sidestep) {
    if(!issubstr(self.classname, "zombie_spetznaz")) {
      return false;
    }
  }
  if(GetTime() - self.a.lastSideStepTime < level.REACTION_INTERVAL) {
    return false;
  }
  if(!isDefined(self.enemy)) {
    return false;
  }
  if(self.a.pose != "stand") {
    return false;
  }
  distSqFromEnemy = distanceSquared(self.origin, self.enemy.origin);
  if(distSqFromEnemy < level.MIN_REACTION_DIST_SQ) {
    return false;
  }
  if(distSqFromEnemy > level.MAX_REACTION_DIST_SQ) {
    return false;
  }
  if(!isDefined(self.pathgoalpos) || distanceSquared(self.origin, self.pathgoalpos) < level.MIN_REACTION_DIST_SQ) {
    return false;
  }
  if(abs(self GetMotionAngle()) > 15) {
    return false;
  }
  yaw = GetYawToOrigin(self.enemy.origin);
  if(abs(yaw) > 45) {
    return false;
  }
  return true;
}

shouldForwardStep() {
  if(canForwardStep() && IsPlayer(self.enemy)) {
    return "phase";
  }
  return "none";
}

canForwardStep() {
  if(!isDefined(self.zombie_can_forwardstep) || !self.zombie_can_forwardstep) {
    return false;
  }
  if(GetTime() - self.a.lastSideStepTime < level.FORWARD_REACTION_INTERVAL) {
    return false;
  }
  if(!isDefined(self.enemy)) {
    return false;
  }
  if(self.a.pose != "stand") {
    return false;
  }
  distSqFromEnemy = distanceSquared(self.origin, self.enemy.origin);
  if(distSqFromEnemy < level.FORWARD_MIN_REACTION_DIST_SQ) {
    return false;
  }
  if(distSqFromEnemy > level.FORWARD_MAX_REACTION_DIST_SQ) {
    return false;
  }
  if(!isDefined(self.pathgoalpos) || distanceSquared(self.origin, self.pathgoalpos) < level.MIN_REACTION_DIST_SQ) {
    return false;
  }
  if(abs(self GetMotionAngle()) > 15) {
    return false;
  }
  yaw = GetYawToOrigin(self.enemy.origin);
  if(abs(yaw) > 45) {
    return false;
  }
  return true;
}

doSideStep() {
  self endon("death");
  self endon("killanimscript");
  playSideStepAnim(self.stepAnim, self.sideStepType);
  if(self.desiredStepDir == "left") {
    self.a.steppedDir--;
  } else {
    self.a.steppedDir++;
  }
  self.a.lastSideStepTime = GetTime();
  return true;
}

playSideStepAnim(stepAnim, sideStepType) {
  self AnimMode("gravity", false);
  self OrientMode("face angle", self.angles[1]);
  runBlendOutTime = 0.20;
  if(isDefined(self.sideStepFunc)) {
    self thread[[self.sideStepFunc]]("stepAnim", stepAnim);
  }
  self ClearAnim( % body, runBlendOutTime);
  self SetFlaggedAnimRestart("stepAnim", stepAnim, 1, runBlendOutTime, self.moveplaybackrate);
  animStartTime = GetTime();
  animLength = GetAnimLength(stepAnim);
  hasExitAlign = animHasNotetrack(stepAnim, "exit_align");
  if(!hasExitAlign) {
    println("^1Side step animation has no \"exit_align\" notetrack");
  }
  self thread animscripts\shared::DoNoteTracks("stepAnim");
  self thread sideStepBlendOut(animLength, "stepAnim", hasExitAlign);
  self.exit_align = false;
  self waittillmatch("stepAnim", "exit_align");
  self.exit_align = true;
  elapsed = (getTime() - animStartTime) / 1000.0;
  timeLeft = animLength - elapsed;
  hasCodeMoveNoteTrack = animHasNotetrack(stepAnim, "code_move");
  if(hasCodeMoveNoteTrack) {
    times = getNotetrackTimes(stepAnim, "code_move");
    assertEx(times.size == 1, "More than one code_move notetrack found");
    timeLeft = times[0] * animLength - elapsed;
  }
  self AnimMode("pos deltas", false);
  maxYawDelta = 2;
  timer = 0;
  while(timer < timeLeft) {
    lookaheadAngles = VectorToAngles(self.lookaheaddir);
    yawDelta = AngleClamp180(lookaheadAngles[1] - self.angles[1]);
    if(yawDelta > maxYawDelta) {
      yawDelta = maxYawDelta;
    } else if(yawDelta < maxYawDelta * -1) {
      yawDelta = maxYawDelta * -1;
    }
    newAngles = (self.angles[0], self.angles[1] + yawDelta, self.angles[2]);
    self Teleport(self.origin, newAngles);
    timer += 0.05 * self.moveplaybackrate;
    wait(0.05);
  }
  self OrientMode("face angle", self.angles[1]);
  elapsed = (getTime() - animStartTime) / 1000.0;
  timeLeft = animLength - elapsed;
  if(timeLeft > 0) {
    wait(timeLeft / self.moveplaybackrate);
  }
  if(IsAlive(self)) {
    self thread faceLookaheadForABit();
    restorePain();
    self.deathFunction = maps\_zombiemode_spawner::zombie_death_animscript;
  }
}

faceLookaheadForABit() {
  self endon("death");
  self endon("killanimscript");
  lookaheadAngles = VectorToAngles(self.lookaheaddir);
  self OrientMode("face angle", lookaheadAngles[1]);
  wait(0.2);
  self AnimMode("normal", false);
  self OrientMode("face default");
}

sideStepBlendOut(animLength, animName, hasExitAlign) {
  self endon("killanimscript");
  self endon("death");
  self endon("stopTurnBlendOut");
  runBlendInTime = 0.2;
  assert(animLength > runBlendInTime);
  wait((animLength - runBlendInTime) / self.moveplaybackrate);
  if(!hasExitAlign) {
    self notify(animName, "exit_align");
  }
  self ClearAnim( % exposed_modern, 0);
  self SetFlaggedAnimKnobAllRestart("run_anim", animscripts\zombie_run::GetRunAnim(), % body, 1, runBlendInTime, self.moveplaybackrate);
}

restorePainOnKillanimscript() {
  self waittill("killanimscript");
  if(isDefined(self) && IsAlive(self)) {
    restorePain();
    self.deathFunction = undefined;
  }
}

disablePain() {
  self.a.storedDisablePain = self.a.disablePain;
  self.a.storedAllowPain = self.a.allowPain;
  self.a.disablePain = true;
  self.allowPain = false;
}

restorePain() {
  if(isDefined(self.a.storedDisablePain) && isDefined(self.a.storedAllowPain)) {
    self.a.disablePain = self.a.storedDisablePain;
    self.allowPain = self.a.storedAllowPain;
  }
}