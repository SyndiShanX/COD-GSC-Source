/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\_alien_traverse.gsc
****************************************************/

#include maps\mp\agents\_scriptedAgents;

main() {
  self endon("killanimscript");

  self.bLockGoalPos = true;

  startNode = self GetNegotiationStartNode();
  endNode = self GetNegotiationEndNode();
  assert(isDefined(startNode) && isDefined(endNode));

  if(startNode.type == "Jump" || startNode.type == "Jump Attack") {
    nextNode = self GetNegotiationNextNode();

    if(isDefined(startNode.target) && isDefined(endNode.targetname) && startNode.target == endNode.targetname) {
      self.traverseType = "canned";
      self DoTraverse(startNode, endNode);
      return;
    }

    attackableEnemy = find_attackable_enemy_at_node(endNode);
    if(isDefined(attackableEnemy)) {
      self.traverseType = "jump_attack";
      self.leapEndPos = endNode.origin;

      self maps\mp\agents\alien\_alien_melee::melee_leap(attackableEnemy);
    } else {
      self.traverseType = "jump";
      self Jump(startNode, endNode, nextNode);
    }
  } else {
    self.traverseType = "canned";
    self doTraverse(startNode, endNode);
  }
}

find_attackable_enemy_at_node(nodeToCheck) {
  if((self maps\mp\alien\_utility::get_alien_type() == "spitter") ||
    (self maps\mp\alien\_utility::get_alien_type() == "seeder"))
    return undefined;

  CLOSE_PLAYER_DIST_SQ = 128 * 128;
  COS_45 = 0.707;
  foreach(player in level.players) {
    if(DistanceSquared(player.origin, nodeToCheck.origin) > CLOSE_PLAYER_DIST_SQ) {
      continue;
    }
    playerToNode = VectorNormalize(nodeToCheck.origin - player.origin);
    playerForward = anglesToForward(player.angles);
    forwardDot = VectorDot(playerToNode, playerForward);

    if(forwardDot > COS_45)
      return player;
  }

  return undefined;
}

end_script() {
  self.bLockGoalPos = false;
  if(self.traverseType == "jump") {
    self.previousAnimState = "traverse_jump";
  } else if(self.traverseType == "jump_attack") {
    self.previousAnimState = "traverse_jump_attack";
  } else {
    self.previousAnimState = "traverse_canned";
  }
  self.traverseType = undefined;
}

Jump(startNode, endNode, nextNode) {
  nextPos = undefined;
  if(isDefined(nextNode))
    nextPos = nextNode.origin;

  if(isDefined(level.dlc_alien_jump_override)) {
    [
      [level.dlc_alien_jump_override]
    ](startNode, endNode, nextNode, nextPos);
    return;
  }

  self maps\mp\agents\alien\_alien_jump::Jump(startNode.origin, startNode.angles, endNode.origin, endNode.angles, nextPos, undefined, endNode.script_noteworthy);
}

doTraverse(startNode, endNode) {
  traverseData = level.alienAnimData.cannedTraverseAnims[startNode.animscript];
  AssertEx(isDefined(traverseData), "Traversal '" + startNode.animscript + "' is not supported");

  animState = traverseData["animState"];
  AssertEx(isDefined(animState), "No animState specified for traversal '" + startNode.animscript + "'");

  self.startNode = startNode;
  self.endNode = endNode;

  self ScrAgentSetPhysicsMode("noclip");
  self ScrAgentSetOrientMode("face angle abs", startNode.angles);
  self ScrAgentSetAnimMode("anim deltas");
  self ScrAgentSetAnimScale(1.0, 1.0);

  if(isDefined(traverseData["traverseSound"]))
    self thread maps\mp\_utility::play_sound_on_tag(traverseData["traverseSound"]);

  if(isDefined(traverseData["traverseAnimScale"]))
    self ScrAgentSetAnimScale(traverseData["traverseAnimScale"], traverseData["traverseAnimScale"]);

  switch (animState) {
    case "traverse_climb_up":
      alienClimbUp(startNode, endNode, "traverse_climb_up", self GetAnimEntry("traverse_climb_up", 4));
      break;

    case "traverse_climb_up_over_56":
      alienClimbUp(startNode, endNode, "traverse_climb_up_over_56");
      break;

    case "traverse_climb_up_ledge_18_run":
      alienClimbUp(startNode, endNode, "traverse_climb_up_ledge_18_run");
      break;

    case "traverse_climb_up_ledge_18_idle":
      alienClimbUp(startNode, endNode, "traverse_climb_up_ledge_18_idle");
      break;

    case "climb_up_end_jump_side_l":
      alienClimbUp(startNode, endNode, "climb_up_end_jump_side_l");
      break;

    case "climb_up_end_jump_side_r":
      alienClimbUp(startNode, endNode, "climb_up_end_jump_side_r");
      break;

    case "traverse_climb_down":
      alienClimbDown(startNode, endNode, "traverse_climb_down");
      break;

    case "traverse_climb_over_56_down":
      alienClimbDown(startNode, endNode, "traverse_climb_over_56_down");
      break;
    case "run":
      alienWallRun(startNode, endNode, "run");
      break;

    default:
      alienRegularTraversal(startNode, animState, traverseData["animIndexArray"], traverseData["endInOriented"], traverseData["flexHeightEndAtTraverseEnd"]);
      break;
  }

  self.startNode = undefined;
  self.endNode = undefined;
  self ScrAgentSetAnimScale(1, 1);
}

alienRegularTraversal(startNode, animState, animIndexArray, endInOriented, flexHeightEndAtTraverseEnd) {
  animIndex = animIndexArray[RandomInt(animIndexArray.size)];
  animEntry = self GetAnimEntry(animState, animIndex);
  result = needFlexibleHeightSupport(animEntry);
  animTime = GetAnimLength(animEntry);

  self traverseAnimLerp(animEntry, startNode);

  if(AnimHasNotetrack(animEntry, "highest_point"))
    self.apexTraversalDeathVector = VectorNormalize(self.startNode.origin - self.endNode.origin);

  scriptable = GetEnt(startnode.target, "targetname");
  if(isDefined(scriptable)) {
    scriptable thread runScriptableTraverse(animTime);
  }

  if(result.need_support)
    doTraversalWithFlexibleHeight(animState, animIndex, animEntry, result.start_notetrack, result.end_notetrack, flexHeightEndAtTraverseEnd, ::alienTraverseNotetrackHandler);
  else
    PlayAnimNUntilNotetrack(animState, animIndex, "canned_traverse", "end", ::alienTraverseNotetrackHandler);

  endRegularTraversal(endInOriented);
}

runScriptableTraverse(animTime) {
  self notify("stop_previous_traversal");
  self endon("stop_previous_traversal");
  self SetScriptablePartState(0, 1);
  wait animTime;
  self SetScriptablePartState(0, 0);
}

endRegularTraversal(endInOriented) {
  if(endInOriented) {
    self ScrAgentSetPhysicsMode("noclip");
    self.oriented = true;
    self.ignoreme = true;
  } else {
    self ScrAgentSetPhysicsMode("gravity");
    self.oriented = false;
    self.ignoreme = false;
  }
}

needFlexibleHeightSupport(animEntry) {
  result = spawnStruct();

  if(AnimHasNotetrack(animEntry, "traverse_up")) {
    result.need_support = true;
    result.start_notetrack = "traverse_up";
    result.end_notetrack = "traverse_up_end";
    return result;
  }

  if(AnimHasNotetrack(animEntry, "traverse_drop")) {
    result.need_support = true;
    result.start_notetrack = "traverse_drop";
    result.end_notetrack = "traverse_drop_end";
    return result;
  }

  result.need_support = false;
  return result;
}

doTraversalWithFlexibleHeight(animState, animIndex, animEntry, startNotetrack, endNotetrack, flexHeightEndAtTraverseEnd, notetrackHandlerFunc) {
  CONST_TRAVERSAL_ANIM_LABEL = "canned_traverse";

  PlayAnimNUntilNotetrack(animState, animIndex, CONST_TRAVERSAL_ANIM_LABEL, startNotetrack, notetrackHandlerFunc);

  if(flexHeightEndAtTraverseEnd) {
    flex_height_end_pos = self.endNode.origin;
    flex_height_anim_end_time = 1;
  } else {
    AssertEx(isDefined(self.endNode.target), "Traversal " + animState + " " + animIndex + " at " + self.origin + ". Need to link a script struct from the traversal end point to mark the apex point for the animation");
    flex_height_end_pos = common_scripts\utility::getstruct(self.endNode.target, "targetname");
    AssertEx(isDefined(flex_height_end_pos), "Traversal " + animState + " " + animIndex + " at " + self.origin + ". Unable to find the apex point struct");
    flex_height_end_pos = flex_height_end_pos.origin;
    apexNotetrackTimes = GetNotetrackTimes(animEntry, "highest_point");
    flex_height_anim_end_time = apexNotetrackTimes[0];
    AssertEx(isDefined(flex_height_anim_end_time), "Traversal " + animState + " " + animIndex + " at " + self.origin + ". Missing 'highest_point' notetrack");
  }

  doTraversalWithFlexibleHeight_internal(animState, animIndex, CONST_TRAVERSAL_ANIM_LABEL, animEntry, startNotetrack, endNotetrack, flex_height_end_pos, flex_height_anim_end_time, notetrackHandlerFunc);
}

doTraversalWithFlexibleHeight_internal(animState, animIndex, animLabel, animEntry, startNotetrack, endNotetrack, flexHeightEndPos, flexHeightAnimEndTime, notetrackHandlerFunc) {
  remaining_height = abs(self.origin[2] - flexHeightEndPos[2]);

  startNotetrackTimes = GetNotetrackTimes(animEntry, startNotetrack);
  start_time = startNotetrackTimes[0];

  endNotetrackTimes = GetNotetrackTimes(animEntry, endNotetrack);
  end_time = endNotetrackTimes[0];
  AssertEx(end_time > start_time, "Traversal " + animState + " " + animIndex + " has incorrectly placed flexible height notetracks.");

  remaining_anim_delta = GetMoveDelta(animEntry, start_time, flexHeightAnimEndTime);
  remaining_anim_height = abs(remaining_anim_delta[2]);

  anim_delta_between = GetMoveDelta(animEntry, start_time, end_time);
  scaled_anim_height = abs(anim_delta_between[2]);
  AssertEx(scaled_anim_height > 0.0, "Traversal " + animState + " " + animIndex + " has bad traverse notetracks.");
  not_scaled_anim_height = remaining_anim_height - scaled_anim_height;

  if(remaining_height <= not_scaled_anim_height)
    anim_scale = 1;
  else
    anim_scale = (remaining_height - not_scaled_anim_height) / scaled_anim_height;

  anim_rate = 1 / anim_scale;

  self ScrAgentSetAnimScale(1.0, anim_scale);
  PlayAnimNAtRateUntilNotetrack(animState, animIndex, anim_rate, animLabel, endNotetrack, notetrackHandlerFunc);

  self ScrAgentSetAnimScale(1.0, 1.0);
  PlayAnimNUntilNotetrack(animState, animIndex, animLabel, "end", notetrackHandlerFunc);

  self.apexTraversalDeathVector = undefined;
}

alienTraverseNotetrackHandler(note, animState, animIndex, animTime) {
  switch (note) {
    case "apply_physics":
      self ScrAgentSetPhysicsMode("gravity");
      break;

    case "highest_point":
      if(isDefined(self.apexTraversalDeathVector))
        self.apexTraversalDeathVector *= -1;
      break;

    default:
      break;
  }
}

alienClimbUp(startNode, endNode, animState, longerEndAnim) {
  startAnim = self GetAnimEntry(animState, 0);
  scrabbleAnim = self GetAnimEntry(animState, 1);
  loopAnim = self GetAnimEntry(animState, 2);
  endAnim = self GetAnimEntry(animState, 3);

  totalHeight = endNode.origin[2] - startnode.origin[2];
  startAnimHeight = GetMoveDelta(startAnim, 0, 1)[2];
  scrabbleAnimHeight = GetMoveDelta(scrabbleAnim, 0, 1)[2];
  loopAnimHeight = GetMoveDelta(loopAnim, 0, 1)[2];
  endAnimHeight = GetMoveDelta(endAnim, 0, 1)[2];
  longerEndAnimHeight = undefined;

  climbUpNotetrackTime = getNoteTrackTimes(startAnim, "climb_up_teleport")[0];
  climbUpAnimDeltaBeforeNotetrack = GetMoveDelta(startAnim, 0, climbUpNotetrackTime);
  climbUpAnimDeltaAfterNotetrack = GetMoveDelta(startAnim, climbUpNotetrackTime, 1);
  startAnimHeightAfterNotetrack = climbUpAnimDeltaAfterNotetrack[2];

  if(totalHeight < (startAnimHeight + endAnimHeight))
    Println("ERROR: Height is too short for " + animState + ".Modify the geo or use another traversal.");

  distForScrabbleAndLoop = totalHeight - (startAnimHeight + endAnimHeight);
  canDoScrabble = false;
  numOfLoop = 0;
  if(distForScrabbleAndLoop > 0) {
    canDoScrabble = (distForScrabbleAndLoop - scrabbleAnimHeight) > 0;
    numOfLoop = max(0, floor((distForScrabbleAndLoop - canDoScrabble * scrabbleAnimHeight) / loopAnimHeight));
  }

  teleportAnimHeight = canDoScrabble * scrabbleAnimHeight + numOfLoop * loopAnimHeight + startAnimHeightAfterNotetrack;
  teleportRealHeight = totalHeight - endAnimHeight - (startAnimHeight - startAnimHeightAfterNotetrack);
  animScalerZ = teleportRealHeight / teleportAnimHeight;

  canDoLongerEndAnim = false;
  if(isDefined(longerEndAnim)) {
    longerEndAnimHeight = GetMoveDelta(longerEndAnim, 0, 1)[2];
    endAnimHeightDiff = longerEndAnimHeight - endAnimHeight;
    canDoLongerEndAnim = (teleportRealHeight - teleportAnimHeight) > endAnimHeightDiff;
    animScalerZ = (teleportRealHeight - canDoLongerEndAnim * endAnimHeightDiff) / teleportAnimHeight;
  }

  selectedEndAnim = endAnim;
  if(canDoLongerEndAnim)
    selectedEndAnim = longerEndAnim;

  stopTeleportNotetrack = getNoteTrackTimes(selectedEndAnim, "stop_teleport")[0];
  endAnimHeightBeforeNotetrack = GetMoveDelta(selectedEndAnim, 0, stopTeleportNotetrack)[2];
  stopToEndAnimDelta = GetMoveDelta(selectedEndAnim, stopTeleportNotetrack, 1);
  stopToEndAnimDeltaXY = length(stopToEndAnimDelta * (1, 1, 0));

  self ScrAgentSetAnimScale(1, 1);

  self traverseClimbUpLerp(startAnim, startNode);

  PlayAnimNUntilNotetrack(animState, 0, "canned_traverse", "climb_up_teleport");

  self ScrAgentSetAnimScale(1, animScalerZ);
  self WaitUntilNotetrack("canned_traverse", "end");

  self ScrAgentSetAnimScale(1, animScalerZ);
  if(canDoScrabble)
    PlayAnimNUntilNotetrack(animState, 1, "canned_traverse", "finish");

  for(i = 0; i < numOfLoop; i++) {
    PlayAnimNUntilNotetrack(animState, 2, "canned_traverse", "end");
  }

  selfToEndHeight = endNode.origin[2] - self.origin[2] - stopToEndAnimDelta[2];
  animScalerZ = 1.0;
  if(selfToEndHeight > endAnimHeightBeforeNotetrack)
    animScalerZ = selfToEndHeight / endAnimHeightBeforeNotetrack;

  self ScrAgentSetAnimScale(1, animScalerZ);

  if(canDoLongerEndAnim)
    PlayAnimNUntilNotetrack(animState, 4, "canned_traverse", "stop_teleport", ::alienTraverseNotetrackHandler);
  else
    PlayAnimNUntilNotetrack(animState, 3, "canned_traverse", "stop_teleport", ::alienTraverseNotetrackHandler);

  selfToEndXY = distance2D(self.origin, endNode.origin);
  animScalerXY = selfToEndXY / stopToEndAnimDeltaXY;

  self ScrAgentSetAnimScale(animScalerXY, 1);
  self WaitUntilNotetrack("canned_traverse", "end");
}

alienClimbDown(startNode, endNode, animState) {
  startAnim = self GetAnimEntry(animState, 0);
  loopAnim = self GetAnimEntry(animState, 1);
  slideAnim = self GetAnimEntry(animState, 2);
  endAnim = self GetAnimEntry(animState, 3);
  jumpOffEndAnim = self GetAnimEntry(animState, 4);

  totalHeight = startNode.origin[2] - endNode.origin[2];
  startAnimHeight = -1 * GetMoveDelta(startAnim, 0, 1)[2];
  slideAnimHeight = -1 * GetMoveDelta(slideAnim, 0, 1)[2];
  loopAnimHeight = -1 * GetMoveDelta(loopAnim, 0, 1)[2];
  endAnimHeight = -1 * GetMoveDelta(endAnim, 0, 1)[2];
  jumpOffEndAnimHeight = -1 * GetMoveDelta(jumpOffEndAnim, 0, 1)[2];

  if(totalHeight < (startAnimHeight + endAnimHeight))
    Println("ERROR: Height is too short for " + animState + ".Modify the geo or use another traversal.");

  endAnimToPlay = endAnim;
  endAnimToPlayHeight = endAnimHeight;
  canDoJump = false;

  if(self canDoJumpForEnd(startnode, endNode, startAnim, jumpOffEndAnim)) {
    endAnimToPlay = jumpOffEndAnim;
    endAnimToPlayHeight = jumpOffEndAnimHeight;
    canDoJump = true;
  }

  distForSlideAndLoop = totalHeight - (startAnimHeight + endAnimToPlayHeight);
  canDoSlide = false;
  numOfLoop = 0;
  if(distForSlideAndLoop > 0) {
    canDoSlide = (distForSlideAndLoop - slideAnimHeight) > 0;
    numOfLoop = max(0, floor((distForSlideAndLoop - canDoSlide * slideAnimHeight) / loopAnimHeight));
  }

  self ScrAgentSetAnimScale(1, 1);

  self traverseClimbDownLerp(startAnim, startNode);

  PlayAnimNUntilNotetrack(animState, 0, "canned_traverse", "end");

  slideAndLoopAnimHeight = canDoSlide * slideAnimHeight + numOfLoop * loopAnimHeight;
  if(slideAndLoopAnimHeight > 0) {
    animScaler = abs((distForSlideAndLoop) / slideAndLoopAnimHeight);
    self ScrAgentSetAnimScale(1, animScaler);
  }

  for(i = 0; i < numOfLoop; i++) {
    PlayAnimNUntilNotetrack("traverse_climb_down_loop", 0, "traverse_climb_down_loop", "end");
  }
  if(canDoSlide)
    PlayAnimNUntilNotetrack("traverse_climb_down_slide", 0, "traverse_climb_down_slide", "end");

  teleportStartTime = getNoteTrackTimes(endAnimToPlay, "climb_down_teleport")[0];
  teleportEndTime = getNoteTrackTimes(endAnimToPlay, "stop_teleport")[0];
  animHeightAfterNotetrack = -1 * GetMoveDelta(endAnimToPlay, teleportStartTime, teleportEndTime)[2];
  heightAdjustment = abs(self.origin[2] - endNode.origin[2] - abs(GetMoveDelta(endAnimToPlay, teleportEndTime, 1)[2]));
  animScaler = heightAdjustment / animHeightAfterNotetrack;

  self ScrAgentSetAnimScale(1, animScaler);

  if(canDoJump)
    PlayAnimNUntilNotetrack(animState, 4, "canned_traverse", "stop_teleport");
  else
    PlayAnimNUntilNotetrack(animState, 3, "canned_traverse", "stop_teleport");

  self ScrAgentSetAnimScale(1, 1);
  self ScrAgentSetPhysicsMode("gravity");
  self WaitUntilNotetrack("canned_traverse", "end");
}

traverseAnimLerp(startAnim, startNode) {
  lerp_time = maps\mp\agents\alien\_alien_anim_utils::getLerpTime(startAnim);
  lerp_target_pos = maps\mp\agents\alien\_alien_anim_utils::getPosInSpaceAtAnimTime(startAnim, startNode.origin, startNode.angles, lerp_time);

  thread maps\mp\agents\alien\_alien_anim_utils::doLerp(lerp_target_pos, lerp_time);
}

traverseClimbDownLerp(startAnim, startNode) {
  VERTICAL_DROP = -30;
  HORIZONTAL_EXTENSION = 60;

  doTraverseClimbLerp(startAnim, startNode, VERTICAL_DROP, HORIZONTAL_EXTENSION, true);
}

traverseClimbUpLerp(startAnim, startNode) {
  VERTICAL_RAISE = 0;
  HORIZONTAL_EXTENSION = 50;

  doTraverseClimbLerp(startAnim, startNode, VERTICAL_RAISE, HORIZONTAL_EXTENSION, false);
}

doTraverseClimbLerp(startAnim, startNode, verticalProbeDis, horizontalProbeDis, probeForward) {
  lerp_time = maps\mp\agents\alien\_alien_anim_utils::getLerpTime(startAnim);
  lerp_target_pos = maps\mp\agents\alien\_alien_anim_utils::getPosInSpaceAtAnimTime(startAnim, startNode.origin, startNode.angles, lerp_time);

  if(probeForward)
    horizontal_probe_direction = (lerp_target_pos - startNode.origin) * (1, 1, 0);
  else
    horizontal_probe_direction = (startNode.origin - lerp_target_pos) * (1, 1, 0);

  horizontal_offset = vectorNormalize(horizontal_probe_direction);
  horizontal_offset *= horizontalProbeDis;

  anim_end_pos = maps\mp\agents\alien\_alien_anim_utils::getPosInSpaceAtAnimTime(startAnim, startNode.origin, startNode.angles, GetAnimLength(startAnim));
  end_pos_aligned = alignToVerticalEdge(anim_end_pos, verticalProbeDis, horizontal_offset);

  xy_displacement = end_pos_aligned - anim_end_pos;
  lerp_target_pos += xy_displacement;

  thread maps\mp\agents\alien\_alien_anim_utils::doLerp(lerp_target_pos, lerp_time);
}

alignToVerticalEdge(lerp_target_pos, vertical_displacement, horizontal_offset) {
  BACKWARD_SCALAR = 3.0;

  lerp_target_pos += horizontal_offset;
  lerp_target_pos += (0, 0, vertical_displacement);

  trace_end_pos = lerp_target_pos - horizontal_offset * BACKWARD_SCALAR;
  trace = bulletTrace(lerp_target_pos, trace_end_pos, false);
  lerp_target_pos = trace["position"];
  lerp_target_pos += (0, 0, -1 * vertical_displacement);

  return lerp_target_pos;
}

canDoJumpForEnd(startnode, endNode, startAnim, jumpAnim) {
  TRACE_START_FORWARD_PADDING = 10;
  TRACE_END_UP_PADDING = (0, 0, 10);
  TRACE_CAPSULE_RADIUS = 5;
  TRACE_CAPSULE_HEIGHT = self.height;

  startAnimDelta = GetMoveDelta(startAnim, 0, 1);
  startAnimDeltaXY = Length2D(startAnimDelta);
  startAnimDeltaZ = startAnimDelta[2] * -1;

  jumpAnimDelta = GetMoveDelta(jumpAnim, 0, 1);
  jumpAnimDeltaXY = Length2D(jumpAnimDelta);
  jumpAnimDeltaZ = jumpAnimDelta[2] * -1;

  startToEndXY = VectorNormalize((endNode.origin - startnode.origin) * (1, 1, 0));
  startAnimEndPos = startnode.origin + startToEndXY * startAnimDeltaXY - (0, 0, startAnimDeltaZ);

  startAnimEndGroundPos = PhysicsTrace(startAnimEndPos, startAnimEndPos + (0, 0, -2000));
  startAnimEndAboveGround = (startAnimEndPos - startAnimEndGroundPos)[2];

  if(startAnimEndAboveGround < jumpAnimDeltaZ)
    return false;

  jumpStartPos = startAnimEndGroundPos + (0, 0, jumpAnimDeltaZ);
  jumpEndPos = startAnimEndGroundPos + startToEndXY * jumpAnimDeltaXY;

  traceStartPos = jumpStartPos + startToEndXY * TRACE_START_FORWARD_PADDING;
  traceEndPos = jumpEndPos + TRACE_END_UP_PADDING;

  return (self AIPhysicsTracePassed(traceStartPos, traceEndPos, TRACE_CAPSULE_RADIUS, TRACE_CAPSULE_HEIGHT, false));
}

alienWallRun(startNode, endNode, animState) {
  self.oriented = true;

  startToEnd = endNode.origin - startNode.origin;
  up = AnglesToUp(endNode.angles);
  forward = VectorNormalize(startToEnd);
  left = VectorCross(up, forward);
  forward = VectorCross(left, up);
  right = (0, 0, 0) - left;

  startToEndAngles = AxisToAngles(forward, right, up);

  self ScrAgentSetOrientMode("face angle abs", startToEndAngles);

  animEntry = self GetAnimEntry(animState, 0);
  time = GetAnimLength(animEntry);
  moveDelta = GetMoveDelta(animEntry);
  dist = Length(moveDelta);
  distToEnd = Length(endNode.origin - self.origin);
  lerpTime = time * (distToEnd / dist);
  self ScrAgentDoAnimLerp(self.origin, endNode.origin, lerpTime);

  self SetAnimState(animState, 0);

  wait(lerpTime);

  self alienWallRun_WaitForAngles(startToEndAngles);
}

alienWallRun_AnglesAlmostEqual(angles1, angles2, diff) {
  if(abs(angleClamp180(angles2[0] - angles1[0]) > diff))
    return false;
  if(abs(angleClamp180(angles2[1] - angles1[1]) > diff))
    return false;
  if(abs(angleClamp180(angles2[2] - angles1[2]) > diff))
    return false;
  return true;
}

alienWallRun_WaitForAngles(desiredAngles) {
  previousDiff = 360;
  waitTime = 0.5;

  while(waitTime > 0) {
    if(alienWallRun_AnglesAlmostEqual(self.angles, desiredAngles, 1)) {
      break;
    }

    diff = AnglesDelta(desiredAngles, self.angles);
    if(diff < 5 || diff >= previousDiff) {
      break;
    }
    previousDiff = diff;
    wait(0.05);
    waitTime -= 0.05;
  }
}