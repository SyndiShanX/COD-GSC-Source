/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\cover_arrival.gsc
*****************************************************/

#include animscripts\SetPoseMovement;
#include animscripts\combat_utility;
#include animscripts\utility;
#include common_scripts\utility;
#include maps\_utility;
#using_animtree("generic_human");

main() {
  self endon("killanimscript");
  if(isDefined(self.doMiniArrival)) {
    self.doMiniArrival = undefined;
    node = self.miniArrivalNode;
    self.miniArrivalNode = undefined;
    self DoMiniArrival(node);
    return;
  }
  approachnumber = self.approachNumber;
  newstance = undefined;
  assert(isDefined(self.approachtype));
  arrivalAnim = anim.coverTrans[self.approachtype][approachnumber];
  assert(isDefined(arrivalAnim));
  switch (self.approachtype) {
    case "left":
    case "right":
    case "stand":
    case "stand_saw":
    case "exposed":
    case "custom_exposed":
      newstance = "stand";
      break;
    case "left_crouch":
    case "right_crouch":
    case "crouch_saw":
    case "crouch":
    case "exposed_crouch":
    case "custom_exposed_crouch":
      newstance = "crouch";
      break;
    case "prone_saw":
      newstance = "prone";
      break;
    default:
      assertmsg("bad node approach type: " + self.approachtype);
      return;
  }
  rate = 1;
  if(isDefined(self.custom_approachanimrate)) {
    rate = self.custom_approachanimrate;
  }
  self clearAnim( % walk_and_run_loops, 0.3);
  self setFlaggedAnimKnobAllRestart("coverArrival", arrivalAnim, % body, 1, 0.3, rate);
  self animscripts\shared::DoNoteTracks("coverArrival");
  if(isDefined(newstance))
    self.a.pose = newstance;
  self.a.movement = "stop";
  self.a.arrivalType = self.approachType;
  self clearanim( % root, .3);
}

getNodeStanceYawOffset(approachtype) {
  if(approachtype == "left" || approachtype == "left_crouch")
    return 90.0;
  else if(approachtype == "right" || approachtype == "right_crouch")
    return -90.0;
  return 0;
}

canUseSawApproach(node) {
  if(self.weapon != "saw" && self.weapon != "rpd" &&
    self.weapon != "dp28" && self.weapon != "dp28_bipod" &&
    self.weapon != "bren" && self.weapon != "bren_bipod" &&
    self.weapon != "30cal" && self.weapon != "30cal_bipod" &&
    self.weapon != "bar" && self.weapon != "bar_bipod" &&
    self.weapon != "mg42" && self.weapon != "mg42_bipod" &&
    self.weapon != "fg42" && self.weapon != "fg42_bipod" &&
    self.weapon != "type99_lmg" && self.weapon != "type99_lmg_bipod")
    return false;
  if(!isDefined(node.turretInfo))
    return false;
  if(node.type != "Cover Stand" && node.type != "Cover Prone" && node.type != "Cover Crouch")
    return false;
  if(isDefined(self.enemy) && distanceSquared(self.enemy.origin, node.origin) < 256 * 256)
    return false;
  if(GetNodeYawToEnemy() > 40 || GetNodeYawToEnemy() < -40)
    return false;
  return true;
}

determineNodeApproachType(node) {
  if(canUseSawApproach(node)) {
    if(node.type == "Cover Stand")
      node.approachtype = "stand_saw";
    if(node.type == "Cover Crouch")
      node.approachtype = "crouch_saw";
    else if(node.type == "Cover Prone")
      node.approachtype = "prone_saw";
    assert(isDefined(node.approachtype));
    return;
  }
  if(self is_heavy_machine_gun()) {
    if(node.type == "Path") {
      self.disablearrivals = true;
    } else {
      self.disablearrivals = false;
    }
  }
  if(!isDefined(anim.approach_types[node.type])) {
    return;
  }
  stance = node isNodeDontStand() && !node isNodeDontCrouch();
  node.approachtype = anim.approach_types[node.type][stance];
}

getMaxDirectionsAndExcludeDirFromApproachType(approachtype) {
  returnobj = spawnstruct();
  if(approachtype == "left" || approachtype == "left_crouch") {
    returnobj.maxDirections = 9;
    returnobj.excludeDir = 9;
  } else if(approachtype == "right" || approachtype == "right_crouch") {
    returnobj.maxDirections = 9;
    returnobj.excludeDir = 7;
  } else if(approachtype == "stand" || approachtype == "crouch" || approachtype == "stand_saw" || approachType == "crouch_saw") {
    returnobj.maxDirections = 6;
    returnobj.excludeDir = -1;
  } else if(approachtype == "exposed" || approachtype == "exposed_crouch") {
    returnobj.maxDirections = 9;
    returnobj.excludeDir = -1;
  } else if(approachtype == "prone_saw") {
    returnobj.maxDirections = 3;
    returnobj.excludeDir = -1;
  } else {
    assertmsg("unsupported approach type " + approachtype);
  }
  return returnobj;
}

shouldApproachToExposed() {
  if(!isValidEnemy(self.enemy))
    return false;
  if(self NeedToReload(0.5))
    return false;
  if(self isSuppressedWrapper())
    return false;
  if(self.node.approachtype == "exposed" || self.node.approachtype == "exposed_crouch")
    return false;
  if(self.node.approachtype == "left_crouch" || self.node.approachtype == "right_crouch")
    return false;
  return canSeePointFromExposedAtNode(self.enemy getShootAtPos(), self.node);
}

calculateNodeOffsetFromAnimationDelta(nodeAngles, delta) {
  right = anglestoright(nodeAngles);
  forward = anglestoforward(nodeAngles);
  return vectorScale(forward, delta[0]) + vectorScale(right, 0 - delta[1]);
}

setupApproachNode(firstTime) {
  self endon("killanimscript");
  if(firstTime)
    self.requestArrivalNotify = true;
  self.a.arrivalType = undefined;
  self thread doLastMinuteExposedApproachWrapper();
  self waittill("corner_approach", approach_dir);
  if(isDefined(self getnegotiationstartnode())) {
    debug_arrival("Not doing approach: path has negotiation start node");
    return;
  }
  if(isDefined(self.disableArrivals) && self.disableArrivals) {
    debug_arrival("Not doing approach: self.disableArrivals is true");
    return;
  }
  self thread setupApproachNode(false);
  approachType = "exposed";
  approachPoint = self.pathGoalPos;
  approachNodeYaw = vectorToAngles(approach_dir)[1];
  approachFinalYaw = approachNodeYaw;
  if(isDefined(self.node)) {
    determineNodeApproachType(self.node);
    if(isDefined(self.node.approachtype) && self.node.approachtype != "exposed") {
      approachType = self.node.approachtype;
      if(approachType == "stand_saw") {
        approachPoint = (self.node.turretInfo.origin[0], self.node.turretInfo.origin[1], self.node.origin[2]);
        forward = anglesToForward((0, self.node.turretInfo.angles[1], 0));
        right = anglesToRight((0, self.node.turretInfo.angles[1], 0));
        approachPoint = approachPoint + vectorScale(forward, -32.545) - vectorScale(right, 6.899);
      } else if(approachType == "crouch_saw") {
        approachPoint = (self.node.turretInfo.origin[0], self.node.turretInfo.origin[1], self.node.origin[2]);
        forward = anglesToForward((0, self.node.turretInfo.angles[1], 0));
        right = anglesToRight((0, self.node.turretInfo.angles[1], 0));
        approachPoint = approachPoint + vectorScale(forward, -32.545) - vectorScale(right, 6.899);
      } else if(approachType == "prone_saw") {
        approachPoint = (self.node.turretInfo.origin[0], self.node.turretInfo.origin[1], self.node.origin[2]);
        forward = anglesToForward((0, self.node.turretInfo.angles[1], 0));
        right = anglesToRight((0, self.node.turretInfo.angles[1], 0));
        approachPoint = approachPoint + vectorScale(forward, -37.36) - vectorScale(right, 13.279);
      } else {
        approachPoint = self.node.origin;
      }
      approachNodeYaw = self.node.angles[1];
      approachFinalYaw = approachNodeYaw + getNodeStanceYawOffset(approachType);
    }
    if(isDefined(level.testingApproaches) && approachType == "exposed") {
      approachNodeYaw = self.node.angles[1];
      approachFinalYaw = approachNodeYaw;
    }
  }
  if(debug_arrivals_on_actor()) {
    println("^5approaching cover (ent " + self getentnum() + ", type \"" + approachType + "\"):");
    println(" approach_dir = (" + approach_dir[0] + ", " + approach_dir[1] + ", " + approach_dir[2] + ")");
    angle = AngleClamp180(vectortoangles(approach_dir)[1] - approachNodeYaw + 180);
    if(angle < 0)
      println(" (Angle of " + (0 - angle) + " right from node forward.)");
    else
      println(" (Angle of " + angle + " left from node forward.)");
  }
  if(approachType == "exposed") {
    if(isDefined(self.node)) {
      if(isDefined(self.node.approachtype))
        debug_arrival("Aborting cover approach: node approach type was " + self.node.approachtype);
      else
        debug_arrival("Aborting cover approach: node approach type was undefined");
    } else {
      debug_arrival("Aborting cover approach: self.node is undefined");
    }
    return;
  }
  if(debug_arrivals_on_actor()) {
    thread drawApproachVec(approach_dir);
  }
  startCornerApproach(approachType, approachPoint, approachNodeYaw, approachFinalYaw, approach_dir);
}

startCornerApproach(approachType, approachPoint, approachNodeYaw, approachFinalYaw, approach_dir) {
  self endon("killanimscript");
  self endon("corner_approach");
  assert(isDefined(approachType));
  if(approachType == "stand" || approachType == "crouch") {
    assert(isDefined(self.node));
    if(AbsAngleClamp180(vectorToAngles(approach_dir)[1] - self.node.angles[1] + 180) < 60) {
      debug_arrival("approach aborted: approach_dir is too far forward for node type " + self.node.type);
      return;
    }
  }
  result = getMaxDirectionsAndExcludeDirFromApproachType(approachType);
  maxDirections = result.maxDirections;
  excludeDir = result.excludeDir;
  approachNumber = -1;
  approachYaw = undefined;
  finalPositionYawOffset = 0;
  if(approachType == "exposed") {
    result = self CheckArrivalEnterPositions(approachPoint, approachFinalYaw, approachType, approach_dir, maxDirections, excludeDir);
    for (i = 0; i < result.data.size; i++)
      debug_arrival(result.data[i]);
    if(result.approachNumber < 0) {
      debug_arrival("approach aborted: " + result.failure);
      return;
    }
    approachNumber = result.approachNumber;
  } else {
    tryNormalApproach = true;
    if(tryNormalApproach) {
      result = self CheckArrivalEnterPositions(approachPoint, approachFinalYaw, approachType, approach_dir, maxDirections, excludeDir);
      for (i = 0; i < result.data.size; i++)
        debug_arrival(result.data[i]);
      if(result.approachNumber < 0) {
        debug_arrival("approach aborted: " + result.failure);
        return;
      }
      approachNumber = result.approachNumber;
    }
  }
  debug_arrival("approach success: dir " + approachNumber);
  self setRunToPos(self.coverEnterPos);
  self waittill("runto_arrived");
  if(isDefined(self.disableArrivals) && self.disableArrivals) {
    debug_arrival("approach aborted at last minute: self.disableArrivals is true");
    return;
  }
  if(abs(self getMotionAngle()) > 45 && isDefined(self.enemy) && vectorDot(anglesToForward(self.angles), vectorNormalize(self.enemy.origin - self.origin)) > .8) {
    debug_arrival("approach aborted at last minute: facing enemy instead of current motion angle");
    return;
  }
  if(self.a.pose != "stand" || (self.a.movement != "run" && !(self isCQBWalking()))) {
    debug_arrival("approach aborted at last minute: not standing and running");
    return;
  }
  if(self.a.pose != "stand" || (self.a.movement != "run" && !(self is_banzai()))) {
    debug_arrival("approach aborted at last minute: not standing and running");
    return;
  }
  requiredYaw = approachFinalYaw - anim.coverTransAngles[approachType][approachNumber];
  if(AbsAngleClamp180(requiredYaw - self.angles[1]) > 30) {
    if(isValidEnemy(self.enemy) && self canSee(self.enemy) && distanceSquared(self.origin, self.enemy.origin) < 256 * 256) {
      if(vectorDot(anglesToForward(self.angles), self.enemy.origin - self.origin) > 0) {
        debug_arrival("aborting approach at last minute: don't want to turn back to nearby enemy");
        return;
      }
    }
  }
  if(!checkCoverEnterPos(approachPoint, approachFinalYaw, approachType, approachNumber)) {
    debug_arrival("approach blocked at last minute");
    return;
  }
  self.approachNumber = approachNumber;
  self.approachType = approachType;
  self.doMiniArrival = undefined;
  self startcoverarrival(self.coverEnterPos, requiredYaw);
}

CheckArrivalEnterPositions(approachpoint, approachYaw, approachtype, approach_dir, maxDirections, excludeDir) {
  angleDataObj = spawnstruct();
  calculateNodeTransitionAngles(angleDataObj, approachtype, true, approachYaw, approach_dir, maxDirections, excludeDir);
  sortNodeTransitionAngles(angleDataObj, maxDirections);
  resultobj = spawnstruct();
  resultobj.data = [];
  arrivalPos = (0, 0, 0);
  resultobj.approachNumber = -1;
  numAttempts = 2;
  if(approachtype == "exposed")
    numAttempts = 1;
  for (i = 1; i <= numAttempts; i++) {
    assert(angleDataObj.transIndex[i] != excludeDir);
    resultobj.approachNumber = angleDataObj.transIndex[i];
    if(!self checkCoverEnterPos(approachpoint, approachYaw, approachtype, resultobj.approachNumber)) {
      resultobj.data[resultobj.data.size] = "approach blocked: dir " + resultobj.approachNumber;
      continue;
    }
    break;
  }
  if(i > numAttempts) {
    resultobj.failure = numAttempts + " direction attempts failed";
    resultobj.approachNumber = -1;
    return resultobj;
  }
  distToApproachPoint = distanceSquared(approachpoint, self.origin);
  distToAnimStart = distanceSquared(approachpoint, self.coverEnterPos);
  if(distToApproachPoint < distToAnimStart * 2 * 2) {
    if(distToApproachPoint < distToAnimStart) {
      resultobj.failure = "too close to destination";
      resultobj.approachNumber = -1;
      return resultobj;
    }
    selfToAnimStart = vectorNormalize(self.coverEnterPos - self.origin);
    AnimStartToNode = vectorNormalize(approachpoint - self.coverEnterPos);
    cosAngle = vectorDot(selfToAnimStart, AnimStartToNode);
    if(cosAngle < 0.819) {
      resultobj.failure = "angle to start of animation is too great (angle of " + acos(cosAngle) + " > 35)";
      resultobj.approachNumber = -1;
      return resultobj;
    }
  }
  return resultobj;
}

doLastMinuteExposedApproachWrapper() {
  self endon("killanimscript");
  self notify("doing_last_minute_exposed_approach");
  self endon("doing_last_minute_exposed_approach");
  self thread watchGoalChanged();
  while (1) {
    doLastMinuteExposedApproach();
    while (1) {
      self waittill_any("goal_changed", "goal_changed_previous_frame");
      if(isDefined(self.coverEnterPos) && isDefined(self.pathGoalPos) && distanceSquared(self.coverEnterPos, self.pathGoalPos) < 1)
        continue;
      break;
    }
  }
}

watchGoalChanged() {
  self endon("killanimscript");
  self endon("doing_last_minute_exposed_approach");
  while (1) {
    self waittill("goal_changed");
    wait .05;
    self notify("goal_changed_previous_frame");
  }
}

doLastMinuteExposedApproach() {
  self endon("goal_changed");
  if(isDefined(self getnegotiationstartnode())) {
    return;
  }
  maxSpeed = 200;
  allowedError = 6;
  while (1) {
    if(!isDefined(self.pathGoalPos))
      self waitForPathGoalPos();
    dist = distance(self.origin, self.pathGoalPos);
    if(dist <= anim.longestExposedApproachDist + allowedError) {
      break;
    }
    waittime = (dist - anim.longestExposedApproachDist) / maxSpeed - .1;
    if(waittime < .05)
      waittime = .05;
    wait waittime;
  }
  if(isDefined(self.grenade) && isDefined(self.grenade.activator) && self.grenade.activator == self) {
    return;
  }
  if(!self maymovetopoint(self.pathGoalPos)) {
    debug_arrival("Aborting exposed approach: maymove check failed");
    return;
  }
  approachType = "exposed";
  if(isDefined(self.node) && isDefined(self.pathGoalPos) && distanceSquared(self.pathGoalPos, self.node.origin) < 1) {
    determineNodeApproachType(self.node);
    if(isDefined(self.node.approachtype) && (self.node.approachtype == "exposed" || self.node.approachtype == "exposed_crouch")) {
      approachType = self.node.approachtype;
    }
    self thread alignToNodeAngles();
  }
  approachDir = VectorNormalize(self.pathGoalPos - self.origin);
  desiredFacingYaw = vectorToAngles(approachDir)[1];
  if(isValidEnemy(self.enemy) && sightTracePassed(self.enemy getShootAtPos(), self.pathGoalPos + (0, 0, 60), false, undefined)) {
    desiredFacingYaw = vectorToAngles(self.enemy.origin - self.pathGoalPos)[1];
  } else if(isDefined(self.node) && (self.node.type == "Guard") && self.node.origin == self.pathGoalPos) {
    desiredFacingYaw = self.node.angles[1];
  } else if(self.goalangle != (0, 0, 0)) {
    desiredFacingYaw = self.goalangle[1];
  } else {
    likelyEnemyDir = self getAnglesToLikelyEnemyPath();
    if(isDefined(likelyEnemyDir))
      desiredFacingYaw = likelyEnemyDir[1];
  }
  angleDataObj = spawnstruct();
  calculateNodeTransitionAngles(angleDataObj, approachType, true, desiredFacingYaw, approachDir, 9, -1);
  best = 1;
  for (i = 2; i < 9; i++) {
    if(angleDataObj.transitions[i] > angleDataObj.transitions[best])
      best = i;
  }
  self.approachNumber = angleDataObj.transIndex[best];
  self.approachType = approachType;
  custom_approach = false;
  if(isDefined(self.custom_approachType) && isDefined(self.custom_approachNumber)) {
    approachNumber = self.custom_approachNumber;
    approachType = self.custom_approachType;
    self.approachNumber = approachNumber;
    self.approachType = approachType;
    custom_approach = true;
  }
  debug_arrival("Doing exposed approach in direction " + self.approachNumber);
  approachAnim = anim.coverTrans[approachType][self.approachNumber];
  animDist = length(anim.coverTransDist[approachType][self.approachNumber]);
  requiredDistSq = animDist + allowedError;
  requiredDistSq = requiredDistSq * requiredDistSq;
  while (isDefined(self.pathGoalPos) && distanceSquared(self.origin, self.pathGoalPos) > requiredDistSq)
    wait .05;
  if(!isDefined(self.pathGoalPos)) {
    debug_arrival("Aborting exposed approach because I have no path");
    return;
  }
  if(isDefined(self.node) && distanceSquared(self.pathGoalPos, self.node.origin) < 1) {
    if(self.node.type != "Guard" && self.node.type != "Path" && self.node.type != "Cover Prone" && self.node.type != "Conceal Prone") {
      debug_arrival("Aborting exposed approach because we're going to a cover node");
      return;
    }
  }
  if(isDefined(self.disableArrivals) && self.disableArrivals) {
    debug_arrival("Aborting exposed approach because self.disableArrivals is true");
    return;
  }
  if(self isCQBWalking() && (!isDefined(self.node) || self.node.type == "Path")) {
    debug_arrival("Aborting exposed approach because self.cqbwalking is true and not going to a node");
    return;
  }
  if(self is_banzai() && (!isDefined(self.node) || self.node.type == "Path")) {
    debug_arrival("Aborting exposed approach because self.banzai is true and not going to a node");
    return;
  }
  if(self.a.pose != "stand" || self.a.movement != "run") {
    debug_arrival("approach aborted at last minute: not standing and running");
    return;
  }
  dist = distance(self.origin, self.pathGoalPos);
  if(!custom_approach && abs(dist - animDist) > allowedError) {
    debug_arrival("Aborting exposed approach because distance difference exceeded allowed error: " + dist + " more than " + allowedError + " from " + animDist);
    return;
  }
  facingYaw = vectorToAngles(self.pathGoalPos - self.origin)[1];
  delta = anim.coverTransDist[approachType][self.approachNumber];
  assert(delta[0] != 0);
  yawToMakeDeltaMatchUp = atan(delta[1] / delta[0]);
  requiredYaw = facingYaw - yawToMakeDeltaMatchUp;
  if(AbsAngleClamp180(requiredYaw - self.angles[1]) > 30) {
    debug_arrival("Aborting exposed approach because angle change was too great");
    return;
  }
  closerDist = dist - animDist;
  idealStartPos = self.origin + VectorScale(vectorNormalize(self.pathGoalPos - self.origin), closerDist);
  self notify("dont_align_to_node_angles");
  self startcoverarrival(idealStartPos, requiredYaw);
}

waitForPathGoalPos() {
  while (1) {
    if(isDefined(self.pathgoalpos)) {
      return;
    }
    wait 1;
  }
}

alignToGoalAngle() {
  self endon("killanimscript");
  self endon("goal_changed");
  self endon("dont_align_to_node_angles");
  self endon("doing_last_minute_exposed_approach");
  waittillframeend;
  maxdist = 80;
  while (1) {
    if(distanceSquared(self.origin, self.goalPos) > maxdist * maxdist) {
      wait .05;
      continue;
    }
    if(isDefined(self.coverEnterPos) && isDefined(self.pathGoalPos) && distanceSquared(self.coverEnterPos, self.pathGoalPos) < 1) {
      wait .1;
      continue;
    }
    break;
  }
  if(isDefined(self.disableArrivals) && self.disableArrivals) {
    return;
  }
  startdist = distance(self.origin, self.goalPos);
  if(startdist <= 0) {
    return;
  }
  startYaw = self.angles[1];
  targetYaw = self.goalangle[1];
  targetYaw = startYaw + AngleClamp180(targetYaw - startYaw);
  self thread resetOrientModeOnGoalChange();
  while (1) {
    dist = distance(self.origin, self.goalPos);
    if(dist > startdist * 1.1) {
      self orientMode("face default");
      return;
    } else {
      if(dist < 5) {
        self orientMode("face default");
        return;
      }
    }
    distfrac = 1.0 - (dist / startdist);
    currentYaw = startYaw + distfrac * (targetYaw - startYaw);
    self orientMode("face angle", currentYaw);
    wait .05;
  }
}

alignToNodeAngles() {
  self endon("killanimscript");
  self endon("goal_changed");
  self endon("dont_align_to_node_angles");
  self endon("doing_last_minute_exposed_approach");
  waittillframeend;
  maxdist = 80;
  while (1) {
    if(!isDefined(self.node) || self.node.type == "Path" || self.node.type == "Guard" || !isDefined(self.pathGoalPos) || distanceSquared(self.node.origin, self.pathGoalPos) > 1) {
      return;
    }
    if(distanceSquared(self.origin, self.node.origin) > maxdist * maxdist) {
      wait .05;
      continue;
    }
    if(isDefined(self.coverEnterPos) && isDefined(self.pathGoalPos) && distanceSquared(self.coverEnterPos, self.pathGoalPos) < 1) {
      wait .1;
      continue;
    }
    break;
  }
  if(isDefined(self.disableArrivals) && self.disableArrivals) {
    return;
  }
  startdist = distance(self.origin, self.node.origin);
  if(startdist <= 0) {
    return;
  }
  determineNodeApproachType(self.node);
  startYaw = self.angles[1];
  targetYaw = self.node.angles[1];
  if(isDefined(self.node.approachtype))
    targetYaw += getNodeStanceYawOffset(self.node.approachtype);
  targetYaw = startYaw + AngleClamp180(targetYaw - startYaw);
  self thread resetOrientModeOnGoalChange();
  while (1) {
    if(!isDefined(self.node)) {
      self orientMode("face default");
      return;
    }
    if(self ShouldDoMiniArrival()) {
      self StartMiniArrival();
      return;
    }
    dist = distance(self.origin, self.node.origin);
    if(dist > startdist * 1.1) {
      self orientMode("face default");
      return;
    }
    distfrac = 1.0 - (dist / startdist);
    currentYaw = startYaw + distfrac * (targetYaw - startYaw);
    self orientMode("face angle", currentYaw);
    wait .05;
  }
}

resetOrientModeOnGoalChange() {
  self endon("killanimscript");
  self waittill_any("goal_changed", "dont_align_to_node_angles");
  self orientMode("face default");
}

startMoveTransition() {
  self endon("killanimscript");
  self.exitingCover = false;
  if(!isDefined(self.pathGoalPos)) {
    debug_arrival("not exiting cover (ent " + self getentnum() + "): self.pathGoalPos is undefined");
    return;
  }
  if(self.a.pose == "prone") {
    debug_arrival("not exiting cover (ent " + self getentnum() + "): self.a.pose is \"prone\"");
    return;
  }
  if(isDefined(self.disableExits) && self.disableExits) {
    debug_arrival("not exiting cover (ent " + self getentnum() + "): self.disableExits is true");
    return;
  }
  if(!self isStanceAllowed("stand")) {
    debug_arrival("not exiting cover (ent " + self getentnum() + "): not allowed to stand");
    return;
  }
  exitpos = self.origin;
  exityaw = self.angles[1];
  exittype = "exposed";
  exitNode = undefined;
  if(isDefined(self.node) && (distanceSquared(self.origin, self.node.origin) < 225))
    exitNode = self.node;
  else if(isDefined(self.prevNode))
    exitNode = self.prevNode;
  if(isDefined(exitNode)) {
    determineNodeApproachType(exitNode);
    if(isDefined(exitNode.approachtype) && exitNode.approachtype != "exposed" && exitNode.approachtype != "stand_saw" && exitNode.approachType != "crouch_saw") {
      distancesq = distancesquared(exitNode.origin, self.origin);
      anglediff = AbsAngleClamp180(self.angles[1] - exitNode.angles[1] - getNodeStanceYawOffset(exitNode.approachtype));
      if(distancesq < 225 && anglediff < 5) {
        exitpos = exitNode.origin;
        exityaw = exitNode.angles[1];
        exittype = exitNode.approachtype;
      }
    }
  }
  if(debug_arrivals_on_actor()) {
    println("^3exiting cover (ent " + self getentnum() + ", type \"" + exittype + "\"):");
    println(" lookaheaddir = (" + self.lookaheaddir[0] + ", " + self.lookaheaddir[1] + ", " + self.lookaheaddir[2] + ")");
    angle = AngleClamp180(vectortoangles(self.lookaheaddir)[1] - exityaw);
    if(angle < 0)
      println(" (Angle of " + (0 - angle) + " right from node forward.)");
    else
      println(" (Angle of " + angle + " left from node forward.)");
  }
  if(!isDefined(exittype)) {
    debug_arrival("aborting exit: not supported for node type " + exitNode.type);
    return;
  }
  if(exittype == "exposed") {
    if(self.a.pose != "stand" && self.a.pose != "crouch") {
      debug_arrival("exposed exit aborted because anim_pose is not \"stand\" or \"crouch\"");
      return;
    }
    if(self.a.movement != "stop") {
      debug_arrival("exposed exit aborted because anim_movement is not \"stop\"");
      return;
    }
    if(self.a.pose == "crouch")
      exittype = "exposed_crouch";
  }
  if(isValidEnemy(self.enemy) && vectorDot(self.lookaheaddir, self.enemy.origin - self.origin) < 0) {
    if(self canSeeEnemyFromExposed() && distanceSquared(self.origin, self.enemy.origin) < 300 * 300) {
      debug_arrival("aborting exit: don't want to turn back to nearby enemy");
      return;
    }
  }
  leaveDir = (-1 * self.lookaheaddir[0], -1 * self.lookaheaddir[1], 0);
  result = getMaxDirectionsAndExcludeDirFromApproachType(exittype);
  maxDirections = result.maxDirections;
  excludeDir = result.excludeDir;
  exityaw = exityaw + getNodeStanceYawOffset(exittype);
  angleDataObj = spawnstruct();
  calculateNodeTransitionAngles(angleDataObj, exittype, false, exityaw, leaveDir, maxDirections, excludeDir);
  sortNodeTransitionAngles(angleDataObj, maxDirections);
  approachnumber = -1;
  numAttempts = 3;
  if(exittype == "exposed" || exittype == "exposed_crouch")
    numAttempts = 1;
  for (i = 1; i <= numAttempts; i++) {
    assert(angleDataObj.transIndex[i] != excludeDir);
    approachNumber = angleDataObj.transIndex[i];
    if(self checkCoverExitPos(exitpos, exityaw, exittype, approachNumber)) {
      break;
    }
    debug_arrival("exit blocked: dir " + approachNumber);
  }
  if(i > numAttempts) {
    debug_arrival("aborting exit: too many exit directions blocked");
    return;
  }
  allowedDistSq = distanceSquared(self.origin, self.coverExitPos) * 1.25 * 1.25;
  if(distanceSquared(self.origin, self.pathgoalpos) < allowedDistSq) {
    debug_arrival("exit failed, too close to destination");
    return;
  }
  debug_arrival("exit success: dir " + approachNumber);
  self doCoverExitAnimation(exittype, approachNumber);
}

str(val) {
  if(!isDefined(val))
    return "{undefined}";
  return val;
}

doCoverExitAnimation(exittype, approachNumber) {
  assert(isDefined(approachNumber));
  assert(approachnumber > 0);
  assert(isDefined(exittype));
  if(isDefined(self.custom_exitType) && isDefined(self.custom_exitNumber)) {
    approachnumber = self.custom_exitNumber;
    exittype = self.custom_exitType;
  }
  leaveAnim = anim.coverExit[exittype][approachnumber];
  assert(isDefined(leaveAnim));
  lookaheadAngles = vectortoangles(self.lookaheaddir);
  if(debug_arrivals_on_actor()) {
    endpos = self.origin + vectorscale(self.lookaheaddir, 100);
    thread debugLine(self.origin, endpos, (1, 0, 0), 1.5);
  }
  if(self.a.pose == "prone") {
    return;
  }
  transTime = 0.2;
  self animMode("zonly_physics", false);
  self OrientMode("face angle", self.angles[1]);
  rate = 1;
  if(isDefined(self.custom_exitanimrate)) {
    rate = self.custom_exitanimrate;
  }
  self setFlaggedAnimKnobAllRestart("coverexit", leaveAnim, % body, 1, transTime, rate);
  blendOutDuration = 0.15;
  self thread coverexit_blend_out(leaveAnim, rate, blendOutDuration);
  hasExitAlign = animHasNotetrack(leaveAnim, "exit_align");
  if(!hasExitAlign)
    println("^1Animation anim.coverExit[\"" + exittype + "\"][" + approachnumber + "] has no \"exit_align\" notetrack");
  self thread DoNoteTracksForExit("coverexit", hasExitAlign);
  self waittillmatch("coverexit", "exit_align");
  self.exitingCover = true;
  self.a.pose = "stand";
  self.a.movement = "run";
  hasCodeMoveNoteTrack = animHasNotetrack(leaveAnim, "code_move");
  while (1) {
    curfrac = self getAnimTime(leaveAnim);
    remainingMoveDelta = getMoveDelta(leaveAnim, curfrac, 1);
    remainingAngleDelta = getAngleDelta(leaveAnim, curfrac, 1);
    faceYaw = lookaheadAngles[1] - remainingAngleDelta;
    forward = anglesToForward((0, faceYaw, 0));
    right = anglesToRight((0, faceYaw, 0));
    endPoint = self.origin + vectorScale(forward, remainingMoveDelta[0]) - vectorScale(right, remainingMoveDelta[1]);
    if(self mayMoveToPoint(endPoint)) {
      self OrientMode("face angle", faceYaw);
      break;
    }
    if(hasCodeMoveNoteTrack) {
      break;
    }
    timeLeft = getAnimLength(leaveAnim) * (1 - curfrac) - blendOutDuration - .05;
    if(timeLeft < .05) {
      break;
    }
    if(timeLeft > .4)
      timeleft = .4;
    wait timeleft;
  }
  if(hasCodeMoveNoteTrack) {
    self waittillmatch("coverexit", "code_move");
    self OrientMode("face default");
    self animmode("none", false);
  }
  animFractionCompleted = self getAnimTime(leaveAnim);
  timeLeft = getAnimLength(leaveAnim) * (1 - animFractionCompleted) - blendOutDuration;
  if(timeLeft > 0) {
    wait timeLeft;
  }
}

coverexit_blend_out(leaveAnim, playSpeed, blendOutTime) {
  self endon("killanimscript");
  playLength = GetAnimLength(leaveAnim) / playSpeed;
  timeTilBlendOut = playLength - blendOutTime;
  wait(timeTilBlendOut);
  self ClearAnim( % root, blendOutTime);
  self setAnimRestart( % run_lowready_F, 1, blendOutTime);
  wait(blendOutTime);
  self OrientMode("face motion");
  self thread faceEnemyOrMotionAfterABit();
  self animMode("normal", false);
}

faceEnemyOrMotionAfterABit() {
  self endon("killanimscript");
  wait 1.0;
  while (isDefined(self.pathGoalPos) && distanceSquared(self.origin, self.pathGoalPos) < 200 * 200)
    wait .25;
  self OrientMode("face default");
}

DoNoteTracksForExit(animname, hasExitAlign) {
  self endon("killanimscript");
  self animscripts\shared::DoNoteTracks(animname);
  if(!hasExitAlign)
    self notify(animname, "exit_align");
}

drawVec(start, end, duration, color) {
  for (i = 0; i < duration * 100; i++) {
    line(start + (0, 0, 30), end + (0, 0, 30), color);
    wait 0.05;
  }
}

drawApproachVec(approach_dir) {
  self endon("killanimscript");
  for (;;) {
    if(!isDefined(self.node)) {
      break;
    }
    line(self.node.origin + (0, 0, 20), (self.node.origin - vectorscale(approach_dir, 64)) + (0, 0, 20));
    wait(0.05);
  }
}

calculateNodeTransitionAngles(angleDataObj, approachtype, isarrival, arrivalYaw, approach_dir, maxDirections, excludeDir) {
  angleDataObj.transitions = [];
  angleDataObj.transIndex = [];
  anglearray = undefined;
  sign = 1;
  offset = 0;
  if(isarrival) {
    anglearray = anim.coverTransAngles[approachtype];
    sign = -1;
    offset = 0;
  } else {
    anglearray = anim.coverExitAngles[approachtype];
    sign = 1;
    offset = 180;
  }
  for (i = 1; i <= maxDirections; i++) {
    angleDataObj.transIndex[i] = i;
    if(i == 5 || i == excludeDir || !isDefined(anglearray[i])) {
      angleDataObj.transitions[i] = -1.0003;
      continue;
    }
    angles = (0, arrivalYaw + sign * anglearray[i] + offset, 0);
    dir = vectornormalize(anglestoforward(angles));
    angleDataObj.transitions[i] = vectordot(approach_dir, dir);
  }
}

printdebug(pos, offset, text, color, linecolor) {
  for (i = 0; i < 20 * 5; i++) {
    line(pos, pos + offset, linecolor);
    print3d(pos + offset, text, (color, color, color));
    wait .05;
  }
}

sortNodeTransitionAngles(angleDataObj, maxDirections) {
  for (i = 2; i <= maxDirections; i++) {
    currentValue = angleDataObj.transitions[angleDataObj.transIndex[i]];
    currentIndex = angleDataObj.transIndex[i];
    for (j = i - 1; j >= 1; j--) {
      if(currentValue < angleDataObj.transitions[angleDataObj.transIndex[j]]) {
        break;
      }
      angleDataObj.transIndex[j + 1] = angleDataObj.transIndex[j];
    }
    angleDataObj.transIndex[j + 1] = currentIndex;
  }
}
checkCoverExitPos(exitpoint, exityaw, exittype, approachNumber) {
  angle = (0, exityaw, 0);
  forwardDir = anglestoforward(angle);
  rightDir = anglestoright(angle);
  forward = vectorscale(forwardDir, anim.coverExitDist[exittype][approachNumber][0]);
  right = vectorscale(rightDir, anim.coverExitDist[exittype][approachNumber][1]);
  exitPos = exitpoint + forward - right;
  self.coverExitPos = exitPos;
  isExposedApproach = (exittype == "exposed" || exittype == "exposed_crouch");
  if(debug_arrivals_on_actor())
    thread debugLine(self.origin, exitpos, (1, .5, .5), 1.5);
  if(!isExposedApproach && !(self checkCoverExitPosWithPath(exitPos))) {
    debug_arrival("cover exit " + approachNumber + " path check failed");
    return false;
  }
  if(!(self maymovefrompointtopoint(self.origin, exitPos)))
    return false;
  if(approachNumber <= 6 || isExposedApproach)
    return true;
  assert(exittype == "left" || exittype == "left_crouch" || exittype == "right" || exittype == "right_crouch");
  forward = vectorscale(forwardDir, anim.coverExitPostDist[exittype][approachNumber][0]);
  right = vectorscale(rightDir, anim.coverExitPostDist[exittype][approachNumber][1]);
  finalExitPos = exitPos + forward - right;
  self.coverExitPos = finalExitPos;
  if(debug_arrivals_on_actor())
    thread debugLine(exitpos, finalExitPos, (1, .5, .5), 1.5);
  return (self maymovefrompointtopoint(exitPos, finalExitPos));
}

checkCoverEnterPos(arrivalpoint, arrivalYaw, approachtype, approachNumber) {
  angle = (0, arrivalYaw - anim.coverTransAngles[approachtype][approachNumber], 0);
  forwardDir = anglestoforward(angle);
  rightDir = anglestoright(angle);
  forward = vectorscale(forwardDir, anim.coverTransDist[approachtype][approachNumber][0]);
  right = vectorscale(rightDir, anim.coverTransDist[approachtype][approachNumber][1]);
  enterPos = arrivalpoint - forward + right;
  self.coverEnterPos = enterPos;
  if(debug_arrivals_on_actor())
    thread debugLine(enterPos, arrivalpoint, (1, .5, .5), 1.5);
  if(!(self maymovefrompointtopoint(enterPos, arrivalpoint)))
    return false;
  if(approachNumber <= 6 || approachtype == "exposed" || approachtype == "exposed_crouch")
    return true;
  assert(approachtype == "left" || approachtype == "left_crouch" || approachtype == "right" || approachtype == "right_crouch");
  forward = vectorscale(forwardDir, anim.coverTransPreDist[approachtype][approachNumber][0]);
  right = vectorscale(rightDir, anim.coverTransPreDist[approachtype][approachNumber][1]);
  originalEnterPos = enterPos - forward + right;
  self.coverEnterPos = originalEnterPos;
  if(debug_arrivals_on_actor())
    thread debugLine(originalEnterPos, enterPos, (1, .5, .5), 1.5);
  return (self maymovefrompointtopoint(originalEnterPos, enterPos));
}

ShouldDoMiniArrival() {
  node = self.node;
  assert(isDefined(node));
  if(getdvar("scr_miniarrivals") != "1" && getdvar("scr_miniarrivals") != "on")
    return false;
  if(distanceSquared(self.origin, node.origin) > 40 * 40)
    return false;
  determineNodeApproachType(node);
  if(!isDefined(node.approachtype) || node.approachtype != "stand")
    return false;
  if(!self mayMoveToPoint(node.origin))
    return false;
  return true;
}

StartMiniArrival() {
  self.doMiniArrival = true;
  assert(isDefined(self.node));
  self.miniArrivalNode = self.node;
  self startcoverarrival(self.origin, self.angles[1]);
}

DoMiniArrival(node) {
  arrivalanim = decideMiniArrivalAnim(node, self.origin);
  animtime = getAnimLength(arrivalanim);
  transTime = 0.2;
  if(self.a.movement != "stop")
    transTime = animtime * 0.65;
  self setAnimKnobAllRestart(arrivalAnim, % body, 1, transTime);
  totalAnimDist = length(getMoveDelta(arrivalAnim, 0, 1));
  if(totalAnimDist <= 0)
    totalAnimDist = 0.5;
  numFrames = floor(animtime * 20);
  startPos = self.origin;
  targetPos = node.origin;
  startYaw = self.angles[1];
  targetYaw = node.angles[1];
  if(isDefined(node.approachtype))
    targetYaw += getNodeStanceYawOffset(node.approachtype);
  targetYaw = startYaw + AngleClamp180(targetYaw - startYaw);
  for (i = 0; i < numFrames; i++) {
    timefrac = (i + 1) / numFrames;
    frac = length(getMoveDelta(arrivalAnim, 0, timefrac)) / totalAnimDist;
    currentYaw = startYaw + frac * (targetYaw - startYaw);
    currentPos = startPos + frac * (targetPos - startPos);
    self orientMode("face angle", currentYaw);
    self teleport(currentPos);
    wait .05;
  }
  return true;
}

decideMiniArrivalAnim(node, pos) {
  dirToNode = pos - node.origin;
  angle = AngleClamp180(vectorToAngles(dirToNode)[1] - node.angles[1]);
  dir = -1;
  if(angle < -180 + 22.5)
    dir = 2;
  else if(angle < -180 + 67.5)
    dir = 3;
  else if(angle < 0)
    dir = 6;
  else if(angle < 180 - 67.5)
    dir = 4;
  else if(angle < 180 - 22.5)
    dir = 1;
  else
    dir = 2;
  anims = [];
  anims[1] = % coverstand_mini_approach_1;
  anims[2] = % coverstand_mini_approach_2;
  anims[3] = % coverstand_mini_approach_3;
  anims[4] = % coverstand_mini_approach_4;
  anims[6] = % coverstand_mini_approach_6;
  assertex(isDefined(anims[dir]), dir);
  return anims[dir];
}

debug_arrivals_on_actor() {
  dvar = getdebugdvar("debug_arrivals");
  if(dvar == "off")
    return false;
  if(dvar == "on")
    return true;
  if(int(dvar) == self getentnum())
    return true;
  return false;
}

debug_arrival(msg) {
  if(!debug_arrivals_on_actor())
    return;
  println(msg);
}