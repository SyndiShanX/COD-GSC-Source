/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\_scriptedagents.gsc
**********************************************/

OnEnterState(prevState, nextState) {
  if(isDefined(self.OnEnterAnimState)) {
    self[[self.OnEnterAnimState]](prevState, nextState);
  }
}

OnDeactivate() {
  self notify("killanimscript");
}

PlayAnimUntilNotetrack(animState, animLabel, notetrack, customFunction) {
  PlayAnimNUntilNotetrack(animState, 0, animLabel, notetrack, customFunction);
}

PlayAnimNUntilNotetrack(animState, animIndex, animLabel, notetrack, customFunction) {
  self SetAnimState(animState, animIndex);

  if(!isDefined(notetrack)) {
    notetrack = "end";
  }

  WaitUntilNotetrack(animLabel, notetrack, animState, animIndex, customFunction);
}

PlayAnimNAtRateUntilNotetrack(animState, animIndex, animRate, animLabel, notetrack, customFunction) {
  self SetAnimState(animState, animIndex, animRate);

  if(!isDefined(notetrack)) {
    notetrack = "end";
  }

  WaitUntilNotetrack(animLabel, notetrack, animState, animIndex, customFunction);
}

WaitUntilNotetrack(animLabel, notetrack, animState, animIndex, customFunction) {
  startTime = getTime();
  animTime = undefined;
  animLength = undefined;

  if(isDefined(animState) && isDefined(animIndex)) {
    animLength = getAnimLength(self GetAnimEntry(animState, animIndex));
  }

  while(true) {
    self waittill(animLabel, note);

    if(isDefined(animLength)) {
      animTime = (getTime() - startTime) * 0.001 / animLength;
    }

    if(!isDefined(animLength) || animTime > 0) {
      if(note == notetrack || note == "end" || note == "anim_will_finish" || note == "finish") {
        break;
      }
    }

    if(isDefined(customFunction)) {
      [
        [customFunction]
      ](note, animState, animIndex, animTime);
    }
  }
}

PlayAnimForTime(animState, time) {
  PlayAnimNForTime(animState, 0, time);
}

PlayAnimNForTime(animState, animIndex, time) {
  self SetAnimState(animState, animIndex);
  wait(time);
}

PlayAnimNAtRateForTime(animState, animIndex, animRate, time) {
  self SetAnimState(animState, animIndex, animRate);
  wait(time);
}

GetAnimScaleFactors(delta, animDelta, bAnimInWorldSpace) {
  distXY = Length2D(delta);
  distZ = delta[2];
  animXY = Length2D(animDelta);
  animZ = animDelta[2];

  scaleXY = 1;
  scaleZ = 1;
  if(isDefined(bAnimInWorldSpace) && bAnimInWorldSpace) {
    animDelta2D = (animDelta[0], animDelta[1], 0);
    animDeltaDir = VectorNormalize(animDelta2D);
    if(VectorDot(animDeltaDir, delta) < 0) {
      scaleXY = 0;
    } else if(animXY > 0) {
      scaleXY = distXY / animXY;
    }
  } else if(animXY > 0)
    scaleXY = distXY / animXY;

  assert(scaleXY >= 0);

  if(abs(animZ) > 0.001 && animZ * distZ >= 0) {
    scaleZ = distZ / animZ;
  }

  assert(scaleZ >= 0);

  scaleFactors = spawnStruct();
  scaleFactors.xy = scaleXY;
  scaleFactors.z = scaleZ;

  return scaleFactors;
}

GetAngleIndex(angle, threshold) {
  if(!isDefined(threshold)) {
    threshold = 10;
  }

  if(angle < 0) {
    return int(ceil((180 + angle - threshold) / 45));
  } else {
    return int(floor((180 + angle + threshold) / 45));
  }
}

DropPosToGround(position, drop_distance) {
  assert(isDefined(self.radius) && isDefined(self.height));
  if(!isDefined(drop_distance)) {
    drop_distance = 18;
  }

  startPos = position + (0, 0, drop_distance);
  endPos = position + (0, 0, drop_distance * -1);

  droppedPos = self AIPhysicsTrace(startPos, endPos, self.radius, self.height, true);

  if(abs(droppedPos[2] - startPos[2]) < 0.1) {
    return undefined;
  }

  if(abs(droppedPos[2] - endPos[2]) < 0.1) {
    return undefined;
  }

  return droppedPos;
}

TRACE_RADIUS_BUFFER = 4;
CanMovePointToPoint(startPos, endPos, stepSize) {
  if(!isDefined(stepSize)) {
    stepSize = 6;
  }

  step_offset = (0, 0, 1) * stepSize;
  startPosRaised = startPos + step_offset;
  endPosRaised = endPos + step_offset;

  assert(isDefined(self.radius) && isDefined(self.height));
  assert(stepSize < self.height);

  return self AIPhysicsTracePassed(startPosRaised, endPosRaised, self.radius, self.height - stepSize, true);
}

GetValidPointToPointMoveLocation(startPos, endPos, stepSize) {
  if(!isDefined(stepSize)) {
    stepSize = 6;
  }

  step_offset = (0, 0, 1) * stepSize;
  startPosRaised = startPos + step_offset;
  endPosRaised = endPos + step_offset;

  assert(isDefined(self.radius) && isDefined(self.height));
  assert(stepSize < self.height);

  return self AIPhysicsTrace(startPosRaised, endPosRaised, self.radius + TRACE_RADIUS_BUFFER, self.height - stepSize, true);
}

GetSafeAnimMoveDeltaPercentage(moveAnim) {
  animTranslation = GetMoveDelta(moveAnim);
  endPos = self LocalToWorldCoords(animTranslation);
  validMovePosition = GetValidPointToPointMoveLocation(self.origin, endPos);
  validMoveDistance = Distance(self.origin, validMovePosition);
  desiredMoveDistance = Distance(self.origin, endPos);

  return Min(1.0, validMoveDistance / desiredMoveDistance);
}

SafelyPlayAnimUntilNotetrack(animState, animLabel, notetrack, customFunction) {
  animIndex = GetRandomAnimEntry(animState);
  SafelyPlayAnimNUntilNotetrack(animState, animIndex, animLabel, notetrack, customFunction);
}

SafelyPlayAnimAtRateUntilNotetrack(animState, animRate, animLabel, notetrack, customFunction) {
  animIndex = GetRandomAnimEntry(animState);
  SafelyPlayAnimNAtRateUntilNotetrack(animState, animIndex, animRate, animLabel, notetrack, customFunction);
}

SafelyPlayAnimNAtRateUntilNotetrack(animState, animIndex, animRate, animLabel, notetrack, customFunction) {
  self SetAnimState(animState, animIndex, animRate);
  SafelyPlayAnimNUntilNotetrack(animState, animIndex, animLabel, notetrack, customFunction);
}

SafelyPlayAnimNUntilNotetrack(animState, animIndex, animLabel, notetrack, customFunction) {
  animToPlay = self GetAnimEntry(animState, animIndex);
  moveScale = GetSafeAnimMoveDeltaPercentage(animToPlay);
  self ScrAgentSetAnimScale(moveScale, 1.0);
  self PlayAnimNUntilNotetrack(animState, animIndex, animLabel, notetrack, customFunction);
  self ScrAgentSetAnimScale(1.0, 1.0);
}

GetRandomAnimEntry(state) {
  count = self GetAnimEntryCount(state);
  return RandomInt(count);
}

GetAngleIndexFromSelfYaw(targetVector) {
  targetAngles = VectorToAngles(targetVector);
  angleDiff = AngleClamp180(targetAngles[1] - self.angles[1]);
  return GetAngleIndex(angleDiff);
}