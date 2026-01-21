/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\_alien_move.gsc
************************************************/

#include common_scripts\utility;
#include maps\mp\agents\_scriptedAgents;
#include maps\mp\_utility;

ALLOW_SLIDE_DIST_SQR = 20.0 * 20.0;
DODGE_CHANCE_ENEMY_FACING_TOLERANCE = 0.985;
DODGE_CHANCE_ALIEN_FACING_TOLERANCE = 0.766;
DODGE_CHANCE_LOOK_AT_TIME_MIN = 1000;
DODGE_CHANCE_LOOK_AT_TIME_MAX = 2000;

DODGE_CHANCE_MAX_DISTANCE_SQ = 640000.0;
MIN_DODGE_DIST_SQUARED = 65536.0;

main() {
  self endon("killanimscript");

  self EnterMove();
  self StartMove();
  self ContinueMovement();
}

EnterMove() {
  self.bLockGoalPos = false;
  self.playing_pain_animation = false;
  self ScrAgentSetPhysicsMode("gravity");
  self ScrAgentSetAnimMode("code_move");
}

StartMove() {
  if(canDoStartMove()) {
    switch (getStartMoveType()) {
      case "run-start":
        self doRunStart();
        break;
      case "walk-start":
        self doWalkStart();
        break;
      case "leap-to-run":
        self doLeapToRunStart();
        break;
      default:
        break;
    }
  }
}

end_script() {
  self.bLockGoalPos = false;
  self.playing_pain_animation = false;
  self CancelAllBut(undefined);
  self ScrAgentSetAnimScale(1, 1);
  self.previousAnimState = "move";
}

SetupMovement() {
  self.enableStop = true;
  self thread WaitForMovemodeChange();
  self thread WaitForJumpSoon();
  self thread WaitForSharpTurn();
  self thread WaitForStop();
  self thread WaitForStuck();

  if(self canDodge()) {
    self thread WaitForNearMiss();
    self thread WaitForDodgeChance();
  }
}

ContinueMovement() {
  self SetupMovement();

  if(self.oriented) {
    forward = self GetLookaheadDir();
    up = AnglesToUp(self.angles);
    left = VectorCross(up, forward);
    forward = VectorCross(left, up);
    right = (0, 0, 0) - left;
    anglesToFace = AxisToAngles(forward, right, up);
    self ScrAgentSetOrientMode("face angle abs", anglesToFace);
    self ScrAgentSetAnimMode("code_move_slide");
  } else {
    self ScrAgentSetOrientMode("face motion");
    self ScrAgentSetAnimMode("code_move");
  }

  self ScrAgentSetAnimScale(self.xyanimscale, 1.0);
  self SetMoveAnim(self.moveMode);
}

WaitForMovemodeChange() {
  self endon("killanimscript");
  self endon("alienmove_endwait_runwalk");
  curMovement = self.moveMode;
  while(true) {
    if(curMovement != self.moveMode) {
      self SetMoveAnim(self.moveMode);
      curMovement = self.moveMode;
    }
    wait(0.1);
  }
}

WaitForSharpTurn() {
  self endon("killanimscript");
  self endon("alienmove_endwait_sharpturn");

  self waittill("path_dir_change", newDir);

  angleIndex = GetAngleIndexFromSelfYaw(newDir);

  if(angleIndex == 4) {
    self thread WaitForSharpTurn();
    return;
  }

  shouldMoveStraightAhead = !(self should_do_sharp_turn());

  if(shouldMoveStraightAhead)
    angleIndex = 0;

  animState = "run_turn";
  turnAnim = self GetAnimEntry(animState, angleIndex);
  canDoTurn = shouldMoveStraightAhead || CanDoTurnAnim(turnAnim);

  if(!canDoTurn) {
    self thread WaitForSharpTurn();
    return;
  }

  self CancelAllBut("sharpturn");

  self.bLockGoalPos = true;
  self.enableStop = false;

  if(shouldMoveStraightAhead)
    self maps\mp\agents\alien\_alien_anim_utils::turnTowardsVector(self GetLookaheadDir());

  self ScrAgentSetAnimMode("anim deltas");
  self ScrAgentSetOrientMode("face angle abs", self.angles);

  self PlayAnimNAtRateUntilNotetrack(animState, angleIndex, self.moveplaybackrate, animState, "code_move");
  self ScrAgentSetOrientMode("face motion");
  self.bLockGoalPos = false;

  self ContinueMovement();
}

WaitForStop() {
  self endon("killanimscript");
  self endon("alienmove_endwait_stop");

  self waittill("stop_soon");

  if(!self shouldDoStopAnim() || self.movemode == "walk") {
    self thread WaitForStop();
    return;
  }

  goalPos = self GetPathGoalPos();

  if(!isDefined(goalPos)) {
    self thread WaitForStop();
    return;
  }

  meToStop = goalPos - self.origin;
  finalFaceDir = getStopEndFaceDir(goalPos);

  animState = getStopAnimState();

  if(self should_move_straight_ahead()) {
    animIndex = 0;
  } else {
    animIndex = getStopAnimIndex(animState, finalFaceDir);
  }

  stopAnim = self GetAnimEntry(animState, animIndex);
  stopDelta = GetMoveDelta(stopAnim);
  stopAngleDelta = GetAngleDelta(stopAnim);

  if(Length(meToStop) + 48 < Length(stopDelta)) {
    self thread WaitForStop();
    return;
  }

  stopData = self GetStopData(goalPos);
  stopStartPos = self CalcAnimStartPos(stopData.pos, stopData.angles[1], stopDelta, stopAngleDelta);
  stopStartPosDropped = self DropPosToGround(stopStartPos);

  if(!isDefined(stopStartPosDropped)) {
    self thread WaitForStop();
    return;
  }

  if(!self CanMovePointToPoint(stopData.pos, stopStartPosDropped)) {
    self thread WaitForStop();
    return;
  }

  self CancelAllBut("stop", "sharpturn");

  self thread WaitForPathSet("alienmove_endwait_pathsetwhilestopping", "alienmove_endwait_stop");

  scaleFactors = GetAnimScaleFactors(goalPos - self.origin, stopDelta);

  self ScrAgentSetAnimMode("anim deltas");
  self ScrAgentSetOrientMode("face angle abs", VectorToAngles(meToStop));
  self ScrAgentSetAnimScale(scaleFactors.xy, scaleFactors.z);
  self PlayAnimNUntilNotetrack(animState, animIndex, animState, "end");
  self ScrAgentSetAnimScale(1.0, 1.0);

  if(self should_move_straight_ahead())
    self maps\mp\agents\alien\_alien_anim_utils::turnTowardsVector(self GetLookaheadDir());

  goalPos = self GetPathGoalPos();
  if(DistanceSquared(self.origin, goalPos) < ALLOW_SLIDE_DIST_SQR) {
    self ScrAgentSetAnimMode("code_move_slide");
    self SetAnimState("idle");
    return;
  } else {
    StartMove();
    ContinueMovement();
  }
}

getStopEndFaceDir(goalPos) {
  if(isDefined(self.enemy))
    return (self.enemy.origin - goalPos);

  return (goalPos - self.origin);
}

getStopAnimState() {
  switch (self.movemode) {
    case "run":
    case "jog":
      return "run_stop";
    case "walk":
      return "walk_stop";
    default:
      AssertMsg("Trying to get stop animState for unknown movemode: " + self.movemode);
  }
}

getStopAnimIndex(animState, meToStop) {
  switch (animState) {
    case "walk_stop":
      return 0;
    case "run_stop":
      return GetAngleIndexFromSelfYaw(meToStop);
  }
}

WaitForPathSet(endOnNotify, killParentNotify) {
  self endon("killanimscript");
  self endon(endOnNotify);

  oldGoalPos = self ScrAgentGetGoalPos();

  self waittill("path_set");

  newGoalPos = self ScrAgentGetGoalPos();

  if(DistanceSquared(oldGoalPos, newGoalPos) < 1) {
    self thread WaitForPathSet(endOnNotify, killParentNotify);
    return;
  }

  self notify(killParentNotify);

  self ContinueMovement();
}

WaitForJumpSoon() {
  self endon("killanimscript");
  self endon("alienmove_endwait_jumpsoon");

  self waittill("traverse_soon");
  self CancelAllBut("jumpsoon");

  startNode = self GetNegotiationStartNode();
  endNode = self GetNegotiationEndNode();

  targetVector = endNode.origin - startNode.origin;
  angleIndex = GetAngleIndexFromSelfYaw(endNode.origin - startNode.origin);
  if(!shouldDoLeapArrivalAnim(startNode, angleIndex)) {
    self ContinueMovement();
    return;
  }

  arrivalAnimState = "jump_launch_arrival";
  arrivalAnim = self GetAnimEntry(arrivalAnimState, angleIndex);
  moveDelta = GetMoveDelta(arrivalAnim);
  angleYawDelta = GetAngleDelta(arrivalAnim);
  if(!self CanMovePointToPoint(self.origin, startNode.origin) && !self.oriented) {
    self ContinueMovement();
    return;
  }

  self thread WaitForPathSet("alienmove_endwait_pathsetwhilejumping", "alienmove_endwait_jumpsoon");

  self ScrAgentSetAnimMode("anim deltas");
  self ScrAgentSetOrientMode("face angle abs", self.angles);

  scaleFactors = GetAnimScaleFactors(startNode.origin - self.origin, moveDelta);
  self ScrAgentSetAnimScale(scaleFactors.xy, scaleFactors.z);
  self PlayAnimNAtRateUntilNotetrack(arrivalAnimState, angleIndex, self.moveplaybackrate, "jump_launch_arrival", "anim_will_finish");

  forward = targetVector;
  up = AnglesToUp(self.angles);
  left = VectorCross(up, forward);
  forward = VectorCross(left, up);
  right = (0, 0, 0) - left;
  anglesToFace = AxisToAngles(forward, right, up);
  self ScrAgentSetOrientMode("face angle abs", anglesToFace);
  self ScrAgentSetAnimScale(1.0, 1.0);

  startNode = self GetNegotiationStartNode();
  if(isDefined(startNode) && distanceSquared(self.origin, startNode.origin) < ALLOW_SLIDE_DIST_SQR || self.oriented)
    self ScrAgentSetAnimMode("code_move_slide");
  else
    self ContinueMovement();
}

SetMoveAnim(moveMode) {
  if(moveMode == "run") {
    nEntries = self GetAnimEntryCount("run");
    animWeights = [20, 80];
    assert(animWeights.size == nEntries);
    randIndex = maps\mp\alien\_utility::GetRandomIndex(animWeights);
    assert(randIndex < nEntries);
    self SetAnimState("run", randIndex, self.moveplaybackrate);
  } else if(moveMode == "jog") {
    self SetAnimState("jog", undefined, self.moveplaybackrate);
  } else if(moveMode == "walk") {
    self SetAnimState("walk", undefined, self.moveplaybackrate);
  } else {
    assertmsg("unimplemented move mode " + moveMode);
  }
}

CancelAllBut(doNotCancel, doNotCancel2) {
  cleanups = ["runwalk", "sharpturn", "stop", "pathsetwhilestopping", "jumpsoon", "pathsetwhilejumping", "pathset", "nearmiss", "dodgechance", "stuck"];

  bCheckDoNotCancel = isDefined(doNotCancel);
  bCheckDoNotCancel2 = isDefined(doNotCancel2);

  foreach(cleanup in cleanups) {
    if(bCheckDoNotCancel && cleanup == doNotCancel)
      continue;
    if(bCheckDoNotCancel2 && cleanup == doNotCancel2)
      continue;
    self notify("alienmove_endwait_" + cleanup);
  }
}

GetStopData(goalPos) {
  stopData = spawnStruct();

  if(isDefined(self.node)) {
    stopData.pos = self.node.origin;
    stopData.angles = self.node.angles;
  } else if(isDefined(self.enemy)) {
    stopData.pos = goalPos;
    stopData.angles = vectorToAngles(self.enemy.origin - goalPos);
  } else {
    stopData.pos = goalPos;
    stopData.angles = self.angles;
  }

  return stopData;
}

CalcAnimStartPos(stopPos, stopAngle, animDelta, animAngleDelta) {
  dAngle = stopAngle - animAngleDelta;
  angles = (0, dAngle, 0);
  vForward = anglesToForward(angles);
  vRight = AnglesToRight(angles);

  forward = vForward * animDelta[0];
  right = vRight * animDelta[1];

  return stopPos - forward + right;
}

onFlashbanged() {
  self DoStumble();
}

onDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset) {
  if(isDefined(level.dlc_can_do_pain_override_func)) {
    painAllowed = [[level.dlc_can_do_pain_override_func]]("move");
    if(!painAllowed)
      return;
  }

  if(maps\mp\alien\_utility::is_pain_available(eAttacker, sMeansOfDeath))
    self DoStumble(iDFlags, vDir, sHitLoc, iDamage, sMeansOfDeath, eAttacker);
}

DoStumble(iDFlags, damageDirection, hitLocation, iDamage, sMeansOfDeath, eAttacker) {
  self endon("killanimscript");

  if(self.playing_pain_animation) {
    return;
  }
  self CancelAllBut(undefined);
  self.stateLocked = true;
  self.playing_pain_animation = true;

  is_stun = (iDFlags &level.iDFLAGS_STUN);

  if(sMeansOfDeath == "MOD_MELEE" || is_stun) {
    animState = "pain_pushback";
    animIndex = maps\mp\agents\alien\_alien_anim_utils::getPainAnimIndex("push_back", damageDirection);
    pain_notify = "pain_pushback";
  } else {
    animState = self maps\mp\agents\alien\_alien_anim_utils::getPainAnimState("run_stumble", iDamage, is_stun);
    animIndex = maps\mp\agents\alien\_alien_anim_utils::getPainAnimIndex("run", damageDirection, hitLocation);
    pain_notify = "run_stumble";
  }

  anime = self GetAnimEntry(animState, animIndex);
  self maps\mp\alien\_utility::always_play_pain_sound(anime);
  self maps\mp\alien\_utility::register_pain(anime);

  self ScrAgentSetOrientMode("face angle abs", self.angles);
  self ScrAgentSetAnimMode("anim deltas");
  self PlayAnimNAtRateUntilNotetrack(animState, animIndex, self.movePlaybackRate, pain_notify, "code_move");

  self.playing_pain_animation = false;
  self.stateLocked = false;

  if(shouldStartMove())
    self StartMove();

  self ContinueMovement();
}

WaitForNearMiss(enemy) {
  self endon("killanimscript");
  self endon("alienmove_endwait_nearmiss");

  DODGE_CHANCE = 0.5;

  while(true) {
    self waittill_any("bulletwhizby", "damage");

    if(RandomFloat(1.0) < DODGE_CHANCE) {
      continue;
    }
    if(!self.playing_pain_animation) {
      DoDodge();
    }
  }
}

WaitForDodgeChance() {
  self endon("killanimscript");
  self endon("alienmove_endwait_dodgechance");

  currentLookAtDuration = 0.0;
  currentDodgeTime = RandomIntRange(DODGE_CHANCE_LOOK_AT_TIME_MIN, DODGE_CHANCE_LOOK_AT_TIME_MAX);
  lastTimeStamp = GetTime();

  while(true) {
    wait 0.1;

    if(IsAlive(self.enemy)) {
      currentTime = GetTime();
      enemyToMe = VectorNormalize(self.origin - self.enemy.origin);
      enemyFacing = anglesToForward(self.enemy.angles);

      if(VectorDot(enemytoMe, enemyFacing) < DODGE_CHANCE_ENEMY_FACING_TOLERANCE) {
        currentLookAtDuration = 0.0;
        continue;
      }

      currentLookAtDuration += currentTime - lastTimeStamp;

      if(DistanceSquared(self.origin, self.enemy.origin) > DODGE_CHANCE_MAX_DISTANCE_SQ) {
        continue;
      }

      meToEnemy = enemyToMe * -1.0;
      myFacing = anglesToForward(self.angles);
      if(VectorDot(meToEnemy, myFacing) < DODGE_CHANCE_ALIEN_FACING_TOLERANCE) {
        continue;
      }

      if(currentLookAtDuration >= currentDodgeTime && !self.playing_pain_animation) {
        DoDodge("dodgechance");
        currentLookAtDuration = 0.0;
        currentDodgeTime = RandomIntRange(DODGE_CHANCE_LOOK_AT_TIME_MIN, DODGE_CHANCE_LOOK_AT_TIME_MAX);
      }

      lastTimeStamp = currentTime;
    }
  }
}

canDodge() {
  switch (self maps\mp\alien\_utility::get_alien_type()) {
    case "elite":
    case "mammoth":
    case "spitter":
    case "seeder":
      return false;

    default:
      return true;
  }
}

DoDodge(endwait) {
  self endon("killanimscript");
  DODGE_FREQUENCY = 1000;

  if(isDefined(self.last_dodge_time) && GetTime() - self.last_dodge_time < DODGE_FREQUENCY) {
    return;
  }
  if(IsAlive(self.enemy) && DistanceSquared(self.origin, self.enemy.origin) < MIN_DODGE_DIST_SQUARED) {
    return;
  }
  primary_dodge_anim_state = get_primary_dodge_anim_state();

  if(cointoss()) {
    if(!TryDodge(primary_dodge_anim_state + "_left", endwait))
      TryDodge(primary_dodge_anim_state + "_right", endwait);
  } else {
    if(!TryDodge(primary_dodge_anim_state + "_right", endwait))
      TryDodge(primary_dodge_anim_state + "_left", endwait);
  }
}

get_primary_dodge_anim_state() {
  switch (self.movemode) {
    case "jog":
      return "jog_dodge";

    default:
      return "run_dodge";
  }
}

TryDodge(dodgeState, endwait) {
  MIN_DODGE_SCALE = 0.5;

  dodgeEntry = self GetRandomAnimEntry(dodgeState);
  dodgeAnim = self GetAnimEntry(dodgeState, dodgeEntry);
  moveScale = GetSafeAnimMoveDeltaPercentage(dodgeAnim);
  moveScale = min(moveScale, self.xyanimscale);

  if(moveScale < MIN_DODGE_SCALE)
    return false;

  self.last_dodge_time = GetTime();

  self CancelAllBut(endwait);
  self ScrAgentSetAnimMode("anim deltas");
  self ScrAgentSetOrientMode("face angle abs", self.angles);
  self ScrAgentSetAnimScale(moveScale, 1.0);
  self PlayAnimUntilNotetrack(dodgeState, dodgeState, "end");
  self ScrAgentSetAnimScale(1, 1);
  self ContinueMovement();

  return true;
}

WaitForStuck() {
  self endon("killanimscript");
  self endon("alienmove_endwait_stuck");

  STUCK_DURATION = 2000.0;
  nextStuckTime = GetTime() + STUCK_DURATION;
  lastPos = self.origin;
  STUCK_TOLERANCE = 1.0;

  while(true) {
    currentTime = GetTime();
    LastDistance = Length(self.origin - lastPos);
    if(LastDistance > STUCK_TOLERANCE)
      nextStuckTime = currentTime + STUCK_DURATION;

    if(nextStuckTime <= currentTime) {
      stuckLerp();
      nextStuckTime = currentTime + STUCK_DURATION;
      break;
    }

    lastPos = self.origin;
    wait 0.1;
  }

  self ContinueMovement();
}

stuckLerp() {
  self endon("killanimscript");
  self endon("alienmove_endwait_stuck");
  self endon("death");

  LERP_TIME = 0.2;

  CancelAllBut("stuck");

  currentAnim = self GetAnimEntry();
  currentAnimLength = GetAnimLength(currentAnim);
  currentAnimDistance = Length(GetMoveDelta(currentAnim));
  lerpDistance = (LERP_TIME / currentAnimLength) * currentAnimDistance;

  lerpDirection = self GetLookaheadDir();
  endPos = self.origin + lerpDirection * lerpDistance;

  self ScrAgentSetPhysicsMode("noclip");
  self ScrAgentSetOrientMode("face angle abs", VectorToAngles(lerpDirection));
  self ScrAgentDoAnimLerp(self.origin, endPos, LERP_TIME);
  wait LERP_TIME;

  self SetOrigin(self.origin);
}

doWalkStart() {
  animState = "walk_start";
  animIndex = GetRandomAnimEntry(animState);

  self ScrAgentSetAnimMode("anim deltas");
  self ScrAgentSetOrientMode("face angle abs", self.angles);

  self.bLockGoalPos = true;

  self PlayAnimNAtRateUntilNotetrack(animState, animIndex, self.movePlaybackRate, animState, "code_move");
  self ScrAgentSetOrientMode("face motion");

  self.bLockGoalPos = false;
}

doRunStart() {
  negStartNode = self GetNegotiationStartNode();
  if(isDefined(negStartNode))
    goalPos = negStartNode.origin;
  else
    goalPos = self GetPathGoalPos();

  if(!isDefined(goalPos)) {
    return;
  }
  if(DistanceSquared(goalPos, self.origin) < 100 * 100) {
    return;
  }
  lookaheadDir = self GetLookaheadDir();

  myVelocity = self GetVelocity();
  if(LengthSquared(myVelocity) > 16) {
    myUp = AnglesToUp(self.angles);
    if(VectorDot(myUp, (0, 0, 1)) < 0.707) {
      angleCos = VectorDot(myUp, lookaheadDir);
      if(angleCos > 0.707 || angleCos < -0.707)
        return;
    }
  }

  self doStartMoveAnim("run_start");
}

doLeapToRunStart() {
  self doStartMoveAnim("leap_to_run_start");
}

should_move_straight_ahead() {
  switch (self maps\mp\alien\_utility::get_alien_type()) {
    case "spitter":
    case "seeder":
    case "minion":
      return true;
    default:
      return false;
  }
}

should_do_sharp_turn() {
  switch (self maps\mp\alien\_utility::get_alien_type()) {
    case "spitter":
    case "seeder":
    case "minion":
    case "elite":
    case "mammoth":
      return false;
    default:
      return true;
  }
}

doStartMoveAnim(animState) {
  if(self should_move_straight_ahead()) {
    angleIndex = 0;
    self maps\mp\agents\alien\_alien_anim_utils::turnTowardsVector(self GetLookaheadDir());
  } else {
    angleIndex = getStartMoveAngleIndex();
  }

  self ScrAgentSetAnimMode("anim deltas");
  self ScrAgentSetOrientMode("face angle abs", self.angles);

  self.bLockGoalPos = true;

  self PlayAnimNAtRateUntilNotetrack(animState, angleIndex, self.movePlaybackRate, animState, "code_move");
  self ScrAgentSetOrientMode("face motion");

  self.bLockGoalPos = false;
}

canDoStartMove() {
  if(!isDefined(self.traverseComplete) && !isDefined(self.skipStartMove) && (!isDefined(self.disableExits) || self.disableExits == false)) {
    return true;
  } else {
    return false;
  }
}

getStartMoveType() {
  previousAnimState = self.previousAnimState;
  switch (previousAnimState) {
    case "traverse_jump":
      return "leap-to-run";
    default:
      switch (self.movemode) {
        case "run":
          return "run-start";
        case "walk":
          return "walk-start";
        default:
          return "run-start";
      }
  }
}

shouldDoStopAnim() {
  return (isDefined(self.enableStop) && self.enableStop == true);
}

shouldDoLeapArrivalAnim(startNode, angleIndex) {
  if(startNode.type == "Jump" || startNode.type == "Jump Attack")
    return true;
  else if(traversalStartFromIdle(startNode.animscript))
    return true;
  else if(incomingAngleStraightAhead(self maps\mp\alien\_utility::get_alien_type(), angleIndex))
    return false;
  else
    return true;
}

incomingAngleStraightAhead(alienType, angleIndex) {
  switch (alienType) {
    case "elite":
    case "mammoth":
      return (angleIndex == 4);

    default:
      return (angleIndex == 3 || angleIndex == 4 || angleIndex == 5);
  }
}

traversalStartFromIdle(anim_script) {
  switch (anim_script) {
    case "alien_climb_up":
    case "alien_climb_up_over_56":
    case "climb_up_end_jump_side_l":
    case "climb_up_end_jump_side_r":
    case "alien_climb_up_ledge_18_run":
    case "alien_climb_up_ledge_18_idle":
      return true;
    default:
      return false;
  }
}

CanDoTurnAnim(turnAnim) {
  HEIGHT_OFFSET = 16;
  RADIUS_OFFSET = 10;
  HEIGHT_OFFSET_COOR = (0, 0, 16);

  if(!isDefined(self GetPathGoalPos()))
    return false;

  assert(isDefined(turnAnim));

  codeMoveTimes = GetNotetrackTimes(turnAnim, "code_move");
  assert(codeMoveTimes.size == 1);

  codeMoveTime = codeMoveTimes[0];
  assert(codeMoveTime <= 1);

  moveDelta = GetMoveDelta(turnAnim, 0, codeMoveTime);
  codeMovePoint = self LocalToWorldCoords(moveDelta);
  codeMovePoint = GetGroundPosition(codeMovePoint, self.radius);
  if(!isDefined(codeMovePoint))
    return false;

  trace_passed = self AIPhysicsTracePassed(self.origin + HEIGHT_OFFSET_COOR, codeMovePoint + HEIGHT_OFFSET_COOR, self.radius - RADIUS_OFFSET, self.height - HEIGHT_OFFSET);
  if(trace_passed)
    return true;
  else
    return false;
}

shouldStartMove() {
  angleIndex = getStartMoveAngleIndex();

  return (angleIndex < 3 || angleIndex > 5);
}

getStartMoveAngleIndex() {
  return GetAngleIndexFromSelfYaw(self GetLookaheadDir());
}