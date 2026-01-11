/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\_alien_jump.gsc
************************************************/

#include maps\mp\agents\_scriptedAgents;

Jump(startPos, startAngles, endPos, endAngles, nextPos, jumpCBs, scriptableName) {
  maps\mp\agents\alien\_alien_anim_utils::turnTowardsVector(endPos - startPos);
  oldTurnRate = self ScrAgentGetMaxTurnSpeed();
  self thread JumpInternal(startPos, startAngles, endPos, endAngles, nextPos, jumpCBs, scriptableName);
  self waittill("jump_finished");
  self JumpCleanup(oldTurnRate, endAngles);
}

JumpCleanup(oldTurnRate, endAngles) {
  self ScrAgentSetAnimScale(1.0, 1.0);
  self ScrAgentSetMaxTurnSpeed(oldTurnRate);
  if(self maps\mp\alien\_utility::is_normal_upright(AnglesToUp(endAngles))) {
    self ScrAgentSetPhysicsMode("gravity");
    self.oriented = false;
    self.ignoreme = false;
  } else {
    self ScrAgentSetPhysicsMode("noclip");
    self.oriented = true;
    self.ignoreme = true;
  }

}

JumpInternal(startPos, startAngles, endPos, endAngles, nextPos, jumpCBs, scriptableName) {
  self endon("death");
  self endon("killanimscript");

  self maps\mp\agents\alien\_alien_anim_utils::turnTowardsVector(endPos - startPos);

  if(isDefined(scriptableName)) {
    maps\mp\agents\alien\_alien_anim_utils::resetScriptable(scriptableName, endPos);
  }

  self.trajectoryActive = false;

  jumpAnimStates = spawnStruct();

  jumpInfo = self GetJumpInfo(startPos, startAngles, endPos, endAngles, nextPos);

  self GetJumpAnimStates(jumpInfo, jumpAnimStates);

  if(isDefined(jumpCBs) && isDefined(jumpCBs.fnSetAnimStates)) {
    self[[jumpCBs.fnSetAnimStates]](jumpInfo, jumpAnimStates);
  }

  anglesToEnd = GetJumpStartAngles(startPos, startAngles, endPos);

  self ScrAgentSetPhysicsMode("noclip");
  self ScrAgentSetOrientMode("face angle abs", anglesToEnd);

  t = 0;

  beginAnim = self GetAnimEntry(jumpAnimStates.launchAnimState, jumpAnimStates.launchAnimEntry);

  endAnim = self GetAnimEntry(jumpAnimStates.landAnimState, jumpAnimStates.landAnimEntry);

  endFinish = GetNotetrackTimes(endAnim, "finish");
  if(endFinish.size > 0) {
    endAnimLength = endFinish[0] * GetAnimLength(endAnim);
  } else {
    endAnimLength = GetAnimLength(endAnim);
  }

  endAnimTime = endAnimLength / jumpAnimStates.playbackRate;

  endLandMoveFrame = floor(endAnimTime * 20.0);
  endLandMoveTime = (endLandMoveFrame / 20.0) / endAnimTime;

  endLand = GetNotetrackTimes(endAnim, "stop_teleport");
  if(endLand.size > 0) {
    endLandTime = endLand[0] * endAnimTime;
    beginLandMoveFrame = ceil(endLandTime * 20.0);
    beginLandMoveTime = (beginLandMoveFrame / 20.0) / endAnimTime;

    endLandMove = GetMoveDelta(endAnim, beginLandMoveTime, endLandMoveTime);
  } else {
    endLandTime = 0.8 * endAnimTime;
    beginLandMoveFrame = ceil(endLandTime * 20.0);
    beginLandMoveTime = (beginLandMoveFrame / 20.0) / endAnimTime;

    endLandMove = GetMoveDelta(endAnim, beginLandMoveTime, endLandMoveTime);
  }

  endAngles = GetJumpEndAngles(startPos, endPos, endAngles);
  endLandMoveRot = RotateVector(endLandMove, endAngles);
  endLandOrigin = endPos - endLandMoveRot;

  self ScrAgentSetAnimMode("anim deltas");
  self PlaySoundOnMovingEnt(get_jump_SFX_alias());

  if(AnimHasNotetrack(beginAnim, "start_teleport")) {
    self PlayAnimNAtRateUntilNotetrack(jumpAnimStates.launchAnimState,
      jumpAnimStates.launchAnimEntry,
      jumpAnimStates.playbackRate,
      "jump_launch",
      "start_teleport");
  } else {
    self PlayAnimNAtRateForTime(jumpAnimStates.launchAnimState,
      jumpAnimStates.launchAnimEntry,
      jumpAnimStates.playabackRate,
      0.5 * GetAnimLength(beginAnim) / jumpAnimStates.playbackRate);
  }

  startTime = gettime();
  t = self ScrAgentDoTrajectory(self.origin, endLandOrigin, jumpInfo.jumpSpeed2D);
  self.trajectoryActive = true;

  self endon("jump_pain_interrupt");
  self thread JumpPain(t, endPos);

  self notify("jump_launching");

  oldTurnRate = self ScrAgentGetMaxTurnSpeed();
  self thread jumpOrient(jumpInfo, endAngles, oldTurnRate, t);

  self WaitUntilNotetrack("jump_launch", "end");
  beginTime = (gettime() - startTime) / 1000;

  loopTime = t - beginTime - endLandTime;

  if(loopTime > 0) {
    self PlayAnimNAtRateForTime(jumpAnimStates.inAirAnimState,
      jumpAnimStates.inAirAnimEntry,
      jumpAnimStates.playbackRate,
      loopTime);
  }

  if(isDefined(jumpCBs) && isDefined(jumpCBs.fnLandAnimStateChoice)) {
    self[[jumpCBs.fnLandAnimStateChoice]](jumpInfo, jumpAnimStates);
  }

  self SetAnimState(jumpAnimStates.landAnimState, jumpAnimStates.landAnimEntry, jumpAnimStates.playbackRate);
  self waittill("traverse_complete");
  self.trajectoryActive = false;

  if(isDefined(scriptableName)) {
    maps\mp\agents\alien\_alien_anim_utils::playAnimOnScriptable(scriptableName, endPos);
  }

  self ScrAgentSetAnimScale(1.0, 0.0);

  self ScrAgentSetMaxTurnSpeed(20.28318);
  self ScrAgentSetAnimMode("anim deltas");

  self ScrAgentSetOrientMode("face angle abs", endAngles);

  self thread waitForLandImpact("jump_land");
  self WaitUntilNotetrack("jump_land", "end");

  self ScrAgentSetAnimScale(1.0, 1.0);

  self SetOrigin(endPos, false);

  self notify("jump_finished");
}

waitForLandImpact(animName) {
  alienType = self maps\mp\alien\_utility::get_alien_type();

  switch (alienType) {
    case "elite":
      self WaitUntilNotetrack(animName, "jump_land_impact");
      maps\mp\agents\alien\_alien_elite::on_jump_impact();
      break;

    default:
      break;
  }
}

jumpOrient(jumpInfo, endAngles, oldTurnRate, timeInAir) {
  self endon("death");
  UPRIGHT_VECTOR = (0, 0, 1);
  UPRIGHT_DOT = 0.85;
  startUpright = maps\mp\alien\_utility::is_normal_upright(jumpInfo.startUpVector);
  endUpright = maps\mp\alien\_utility::is_normal_upright(jumpInfo.endUpVector);

  if(startUpright && !endUpright) {
    start_orient_time = 0.5;
    end_orient_time = 1.0;
  } else if(!startUpright && endUpright) {
    start_orient_time = 0.0;
    end_orient_time = 0.5;
  } else {
    start_orient_time = 0.0;
    end_orient_time = 1.0;
  }

  total_orient_time = end_orient_time - start_orient_time;

  if(start_orient_time > 0) {
    wait(timeInAir * start_orient_time);
  }

  threshold = 1.0;
  if(DistanceSquared(self.angles, endAngles) > threshold) {
    anglesDelta = AnglesDelta(self.angles, endAngles);

    turnRate = anglesDelta / (timeInAir * total_orient_time);
    turnRate = turnRate * 3.1415926 / 180.0;
    turnRate = turnRate / 20;
    self ScrAgentSetMaxTurnSpeed(turnRate);
  }
  self ScrAgentSetOrientMode("face angle abs", endAngles);
}

GetJumpInfo(startPos, startAngles, endPos, endAngles, nextPos) {
  jumpInfo = spawnStruct();

  startToEnd = endPos - startPos;
  startToEnd2D = startToEnd * (1, 1, 0);
  startToEnd2D = VectorNormalize(startToEnd2D);

  AssertEx(isDefined(level.alienAnimData.jumpLaunchGroundDelta), "Jump launch table has not been initialized");

  jumpInfo.launchOrigin = startPos + startToEnd2D * level.alienAnimData.jumpLaunchGroundDelta;
  jumpInfo.landOrigin = endPos;

  jumpInfo.jumpVector = jumpInfo.landOrigin - jumpInfo.launchOrigin;
  jumpInfo.jumpVector2D = jumpInfo.jumpVector * (1, 1, 0);
  jumpInfo.jumpDistance2D = Length(jumpInfo.jumpVector2D);
  AssertEx(jumpInfo.jumpDistance2D != 0, "Trying to jump vertically. This is not handled.");

  jumpInfo.jumpDirection2D = jumpInfo.jumpVector2D / jumpInfo.jumpDistance2D;

  if(isDefined(nextPos)) {
    jumpInfo.landVector = nextPos - endPos;
  }
  else if(isDefined(self.enemy)) {
    jumpInfo.landVector = self.enemy.origin - endPos;
  }
  else {
    jumpInfo.landVector = anglesToForward(self.angles);
  }

  jumpInfo.startAngles = GetJumpAngles(jumpInfo.jumpVector, AnglesToUp(startAngles));
  jumpInfo.endAngles = GetJumpAngles(jumpInfo.jumpVector, AnglesToUp(endAngles));

  jumpInfo.startUpVector = AnglesToUp(jumpInfo.startAngles);
  jumpInfo.endUpVector = AnglesToUp(jumpInfo.endAngles);

  GetJumpVelocity(jumpInfo);

  return jumpInfo;
}

GetJumpAngles(jumpVector, vUp) {
  forwardVector = maps\mp\agents\alien\_alien_anim_utils::ProjectVectorToPlane(jumpVector, vUp);
  right = VectorCross(forwardVector, vUp);
  angles = AxisToAngles(forwardVector, right, vUp);
  return angles;
}

GetJumpVelocity(jumpInfo) {
  x = jumpInfo.jumpDistance2D;
  y = jumpInfo.jumpVector[2];
  isWallJump = !maps\mp\alien\_utility::is_normal_upright(jumpInfo.endUpVector);
  g = GetJumpGravity(isWallJump);
  MIN_JUMP_SPEED_MULTIPLIER = 1.01;

  minJumpSpeed = TrajectoryCalculateMinimumVelocity(jumpInfo.launchOrigin, jumpInfo.landOrigin, g);
  jumpSpeedMultiplier = GetJumpSpeedMultiplier(isWallJump);
  jumpSpeed = minJumpSpeed * MIN_JUMP_SPEED_MULTIPLIER * jumpSpeedMultiplier;
  AssertEx(jumpSpeed != 0, "Trying to jump but the jump doesn't go anywhere.");

  jumpAngle = TrajectoryCalculateExitAngle(jumpSpeed, g, x, y);

  jumpAngleCos = Cos(jumpAngle);
  AssertEx(jumpAngleCos != 0, "Trying to jump vertically. This is not handled.");

  jumpInfo.jumpTime = jumpInfo.jumpDistance2D / (jumpSpeed * jumpAngleCos);

  gravityVector = g * (0, 0, -1);
  jumpInfo.launchVelocity = TrajectoryCalculateInitialVelocity(jumpInfo.launchOrigin, jumpInfo.landOrigin, gravityVector, jumpInfo.jumpTime);
  jumpInfo.launchVelocity2D = jumpInfo.launchVelocity * (1, 1, 0);
  jumpInfo.jumpSpeed2D = Length(jumpInfo.launchVelocity2D);
}

GetJumpSpeedMultiplier(is_wall_jump) {
  if(isDefined(self.melee_jumping) && self.melee_jumping) {
    AssertEx(isDefined(level.alien_jump_melee_speed, "Alien jump speed is not defined"));
    return level.alien_jump_melee_speed;
  } else if(is_wall_jump) {
    return GetDvarFloat("agent_jumpWallSpeed");
  } else {
    return GetDvarFloat("agent_jumpSpeed");
  }
}

GetJumpGravity(is_wall_jump) {
  if(isDefined(self.melee_jumping) && self.melee_jumping) {
    AssertEx(isDefined(level.alien_jump_melee_gravity, "Alien jump gravity is not defined"));
    return level.alien_jump_melee_gravity;
  } else if(is_wall_jump) {
    return GetDvarFloat("agent_jumpWallGravity");
  } else {
    return GetDvarFloat("agent_jumpGravity");
  }
}

GetJumpPlaybackRate(jumpInfo, animStates) {
  AssertEx(jumpInfo.jumpTime != 0);

  launchAnim = self GetAnimEntry(animStates.launchAnimState, animStates.launchAnimEntry);
  inAirAnim = self GetAnimEntry(animStates.inAirAnimState, animStates.inAirAnimEntry);
  landAnim = self GetAnimEntry(animStates.landAnimState, animStates.landAnimEntry);

  launchAnimLength = GetAnimLength(launchAnim);
  launchAnimInAirTime = launchAnimLength * 0.5;

  launchAnimTakeoff = GetNotetrackTimes(launchAnim, "start_teleport");
  if(isDefined(launchAnimTakeoff) && launchAnimTakeoff.size > 0) {
    launchAnimInAirTime = launchAnimLength - launchAnimTakeoff[0] * launchAnimLength;
  }
  Assert(launchAnimInAirTime < launchAnimLength);

  landAnimLength = GetAnimLength(landAnim);
  landAnimInAirTime = landAnimLength * 0.5;

  landAnimArrive = GetNotetrackTimes(landAnim, "stop_teleport");
  if(isDefined(landAnimArrive) && landAnimArrive.size > 0) {
    landAnimInAirTime = landAnimArrive[0] * landAnimLength;
  }
  Assert(landAnimInAirTime < landAnimLength);

  inAirAnimLength = GetAnimLength(inAirAnim);
  Assert(inAirAnimLength > 0);

  trajectoryFrameCount = ceil(jumpInfo.jumpTime * 20.0);
  trajectoryPhysicsTime = trajectoryFrameCount / 20.0;

  trajectoryAnimTime = inAirAnimLength + launchAnimInAirTime + landAnimInAirTime;
  trajectoryAnimScale = trajectoryAnimTime / trajectoryPhysicsTime;

  inAirAnimTime = inAirAnimLength / trajectoryAnimScale + 0.1;
  inAirAnimScale = inAirAnimLength / inAirAnimTime;

  return inAirAnimScale;
}

GetJumpAnimStates(jumpInfo, animStates) {
  animStates.launchAnimState = GetLaunchAnimState(jumpInfo);
  animStates.launchAnimEntry = GetLaunchAnimEntry(jumpInfo, animStates.launchAnimState);

  animStates.landAnimState = GetLandAnimState(jumpInfo);
  animStates.landAnimEntry = GetLandAnimEntry(jumpInfo, animStates.landAnimState);

  animStates.inAirAnimState = GetInAirAnimState(jumpInfo, animStates.launchAnimState, animStates.landAnimState);
  animStates.inAirAnimEntry = GetInAirAnimEntry(jumpInfo, animStates.launchAnimState, animStates.landAnimState);

  animStates.playbackRate = self GetJumpPlaybackRate(jumpInfo, animStates);
}

GetJumpStartAngles(startPos, startAngles, endPos) {
  startUp = AnglesToUp(startAngles);
  startForward = VectorNormalize(endPos - startPos);
  if(VectorDot(startUp, startForward) > 0.98) {
    startForward = (0, 0, 1);
  }
  startLeft = VectorCross(startUp, startForward);
  startForward = VectorCross(startLeft, startUp);
  return AxisToAngles(startForward, -1 * startLeft, startUp);
}

GetLaunchAnimState(jumpInfo) {
  LEVEL_DEGREE_RANGE = 20;
  cosLimitForLevel = Cos(90 - LEVEL_DEGREE_RANGE);

  startToEnd = VectorNormalize(jumpInfo.jumpVector);
  startToEndDotUp = VectorDot(startToEnd, jumpInfo.startUpVector);

  if(abs(startToEndDotUp) <= cosLimitForLevel) {
    return "jump_launch_level";
  } else if(startToEndDotUp > 0) {
    return "jump_launch_up";
  } else if(startToEndDotUp < 0) {
    return "jump_launch_down";
  }
}

GetLaunchAnimEntry(jumpInfo, launchAnimState) {
  launchDirection = VectorNormalize(jumpInfo.launchVelocity);
  launchDirection = RotateVector(launchDirection, jumpInfo.startAngles);

  AssertEx(isDefined(level.alienAnimData.jumpLaunchDirection), "Alien jump table has not been initialized");
  AssertEx(isDefined(level.alienAnimData.jumpLaunchDirection[launchAnimState]),
    "Alien jump table has not been initialized for launch state " + launchAnimState);

  launchEntryCount = self GetAnimEntryCount(launchAnimState);
  AssertEx(launchEntryCount > 0, "Alien launch state " + launchAnimState + " as no animations.");

  launchEntry = 0;
  AssertEx(isDefined(level.alienAnimData.jumpLaunchDirection[launchAnimState][launchEntry]),
    "Alien launch entry " + launchEntry + " for state " + launchAnimState + " has no direction.");

  launchEntryDot = VectorDot(level.alienAnimData.jumpLaunchDirection[launchAnimState][launchEntry], launchDirection);

  for(nextLaunchEntry = 1; nextLaunchEntry < launchEntryCount; nextLaunchEntry++) {
    AssertEx(isDefined(level.alienAnimData.jumpLaunchDirection[launchAnimState][nextLaunchEntry]),
      "Alien launch entry " + nextLaunchEntry + " for state " + launchAnimState + " has no direction.");

    nextLaunchEntryDot = VectorDot(level.alienAnimData.jumpLaunchDirection[launchAnimState][nextLaunchEntry], launchDirection);
    if(nextLaunchEntryDot > launchEntryDot) {
      launchEntry = nextLaunchEntry;
      launchEntryDot = nextLaunchEntryDot;
    }
  }

  return launchEntry;
}

GetInAirAnimState(jumpInfo, launchAnimState, landAnimState) {
  return "jump_in_air";
}

GetInAirAnimEntry(jumpInfo, launchAnimState, landAnimState) {
  AssertEx(isDefined(level.alienAnimData.inAirAnimEntry), "Alien in air table has not been initialized");
  AssertEx(isDefined(level.alienAnimData.inAirAnimEntry[launchAnimState]),
    "Alien in air table has not been initialized for launch state " + launchAnimState);
  AssertEx(isDefined(level.alienAnimData.inAirAnimEntry[launchAnimState][landAnimState]),
    "Alien in air table has not been initialized for launch state " + launchAnimState + " and land anim state " + landAnimState);

  return level.alienAnimData.inAirAnimEntry[launchAnimState][landAnimState];
}

GetJumpEndAngles(startPos, endPos, endAngles) {
  endUp = AnglesToUp(endAngles);
  endForward = VectorNormalize(endPos - startPos);
  if(VectorDot(endUp, endForward) > 0.98) {
    endForward = (0, 0, 1);
  }
  endLeft = VectorCross(endUp, endForward);
  endForward = VectorCross(endLeft, endUp);
  return AxisToAngles(endForward, -1 * endLeft, endUp);
}

GetLandAnimState(jumpInfo) {
  jumpVectorLength = length(jumpInfo.jumpVector);
  PITCH_THRESHOLD = 0.342;

  if(!maps\mp\alien\_utility::is_normal_upright(jumpInfo.endUpVector)) {
    WORLD_UP = (0, 0, 1);
    pitch = VectorDot(jumpInfo.jumpVector, WORLD_UP) / jumpVectorLength;

    if(pitch > PITCH_THRESHOLD) {
      return "jump_land_sidewall_low";
    } else {
      return "jump_land_sidewall_high";
    }
  }

  pitch = VectorDot(jumpInfo.jumpVector, jumpInfo.endUpVector) / jumpVectorLength;

  if(pitch > PITCH_THRESHOLD) {
    return "jump_land_down";
  } else if(pitch < (PITCH_THRESHOLD * -1)) {
    return "jump_land_up";
  } else {
    return "jump_land_level";
  }
}

GetLandAnimEntry(jumpInfo, landAnimState) {
  incomingVectorWithoutNormal = maps\mp\agents\alien\_alien_anim_utils::ProjectVectorToPlane(jumpInfo.jumpVector, jumpInfo.endUpVector);
  outgoingVectorWithoutNormal = maps\mp\agents\alien\_alien_anim_utils::ProjectVectorToPlane(jumpInfo.landVector, jumpInfo.endUpVector);
  thirdVector = incomingVectorWithoutNormal - outgoingVectorWithoutNormal;

  outgoingRightVector = VectorCross(outgoingVectorWithoutNormal, jumpInfo.endUpVector);
  outgoingRightVectorWithoutNormal = VectorNormalize(maps\mp\agents\alien\_alien_anim_utils::ProjectVectorToPlane(outgoingRightVector, jumpInfo.endUpVector)) * 100;

  projectionIncomingToOutgoingRight = VectorDot(incomingVectorWithoutNormal * -1, outgoingRightVectorWithoutNormal);

  a = Length(incomingVectorWithoutNormal);
  b = Length(outgoingVectorWithoutNormal);
  c = Length(thirdVector);

  MIN_LENGTH = 0.001;

  if(a < MIN_LENGTH || b < MIN_LENGTH) {
    return 1;
  }

  ratio = (a * a + b * b - c * c) / (2 * a * b);
  if(ratio <= -1) {
    return 6;
  } else if(ratio >= 1) {
    return 1;
  } else {
    rotatedYaw = Acos(ratio);
    if(projectionIncomingToOutgoingRight > 0) {
      if(0 <= rotatedYaw && rotatedYaw < 22.5) {
        return 1;
      } else if(22.5 <= rotatedYaw && rotatedYaw < 67.5) {
        return 2;
      } else if(67.5 <= rotatedYaw && rotatedYaw < 112.5) {
        return 4;
      } else if(112.5 <= rotatedYaw && rotatedYaw < 157.5) {
        return 7;
      } else {
        return 6;
      }
    } else {
      if(0 <= rotatedYaw && rotatedYaw < 22.5) {
        return 1;
      } else if(22.5 <= rotatedYaw && rotatedYaw < 67.5) {
        return 0;
      } else if(67.5 <= rotatedYaw && rotatedYaw < 112.5) {
        return 3;
      } else if(112.5 <= rotatedYaw && rotatedYaw < 157.5) {
        return 5;
      } else {
        return 6;
      }
    }
  }
}

JumpPain(duration, endPos) {
  self endon("death");
  self endon("killanimscript");
  self endon("jump_finished");

  start_time = gettime();
  duration_msec = duration * 1000;
  self waittill("jump_pain", damageDirection, hitLocation, iDamage, stun);

  if(!self.trajectoryActive) {
    return;
  }

  self notify("jump_pain_interrupt");

  jump_pain_state = self maps\mp\agents\alien\_alien_anim_utils::getPainAnimState("jump_pain", iDamage, stun);
  jump_pain_index = self maps\mp\agents\alien\_alien_anim_utils::getPainAnimIndex("jump", damageDirection, hitLocation);
  damage_degree = self maps\mp\agents\alien\_alien_anim_utils::getDamageDegree(iDamage, stun);
  jump_end_time_sec = start_time * 0.001 + duration;
  PlayInAirJumpPainAnims(jump_pain_state, jump_pain_index, jump_end_time_sec, damage_degree);

  self ScrAgentSetAnimScale(1.0, 0.0);
  self ScrAgentSetAnimMode("anim deltas");

  self ScrAgentSetOrientMode("face angle abs", self.angles);

  impact_pain_anim = self GetImpactPainAnimState(damage_degree);
  impact_pain_index = self maps\mp\agents\alien\_alien_anim_utils::GetImpactPainAnimIndex(jump_pain_index);
  self SetAnimState(impact_pain_anim, impact_pain_index, 1.0);
  self WaitUntilNotetrack(impact_pain_anim, "code_move");

  self notify("jump_finished");
}

PlayInAirJumpPainAnims(jump_pain_state, jump_pain_entry, jump_end_time_sec, damage_degree) {
  self endon("death");
  self endon("killanimscript");
  self endon("jump_finished");

  self SetAnimState(jump_pain_state, jump_pain_entry, 1.0);
  msg = self common_scripts\utility::waittill_any_return("jump_pain", "traverse_complete");
  if(msg == "traverse_complete") {
    return;
  }
  idle_time_remaining = jump_end_time_sec - GetTime() * 0.001;

  if(idle_time_remaining > 0) {
    MAX_RATE_SCALE = 2.0;
    jump_pain_idle_state = self GetJumpPainIdleAnimState(damage_degree);
    jump_pain_idle_anim = self GetAnimEntry(jump_pain_idle_state, jump_pain_entry);
    jump_pain_idle_anim_length = GetAnimLength(jump_pain_idle_anim);
    jump_pain_idle_rate = Min(MAX_RATE_SCALE, jump_pain_idle_anim_length / idle_time_remaining);

    self SetAnimState(jump_pain_idle_state, jump_pain_entry, jump_pain_idle_rate);
  }

  self waittill("traverse_complete");
}

GetJumpPainIdleAnimState(damage_degree) {
  return ("jump_pain_idle_" + damage_degree);
}

GetImpactPainAnimState(damage_degree) {
  return ("jump_impact_pain_" + damage_degree);
}

get_jump_SFX_alias() {
  switch (maps\mp\alien\_utility::get_alien_type()) {
    case "elite":
      return "null";

    case "spitter":
      return "spitter_jump";

    case "seeder":
      return "seed_jump";

    case "gargoyle":
      return "gg_jump";

    default:
      return "alien_jump";
  }
}