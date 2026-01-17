/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\utility.gsc
**************************************/

#include animscripts\SetPoseMovement;
#include animscripts\combat_utility;
#include animscripts\debug;
#include animscripts\anims;
#include common_scripts\utility;
#include maps\_utility;
#using_animtree("generic_human");
initAnimTree(animscript) {
  if(isValidEnemy(self.a.personImMeleeing)) {
    ImNotMeleeing(self.a.personImMeleeing);
  }
  self ClearAnim( % body, 0.3);
  self SetAnim( % body, 1, 0);
  if(animscript != "pain" && animscript != "death" && animscript != "react") {
    self.a.special = "none";
  }
  self.missedSightChecks = 0;
  self.a.aimweight = 1.0;
  self.a.aimweight_start = 1.0;
  self.a.aimweight_end = 1.0;
  self.a.aimweight_transframes = 0;
  self.a.aimweight_t = 0;
  self.a.isAiming = false;
  self SetAnim( % shoot, 0, 0.2, 1);
  IsInCombat();
  assertEX(isDefined(animscript), "Animscript not specified in initAnimTree");
  self.a.prevScript = self.a.script;
  self.a.script = animscript;
  self.a.script_suffix = undefined;
  self animscripts\anims::clearAnimCache();
  [[self.a.StopCowering]]();
}

UpdateAnimPose() {
  assertEX(self.a.movement == "stop" || self.a.movement == "walk" || self.a.movement == "run", "UpdateAnimPose " + self.a.pose + " " + self.a.movement);
  if(isDefined(self.desired_anim_pose) && self.desired_anim_pose != self.a.pose) {
    if(self.a.pose == "prone") {
      self ExitProneWrapper(0.5);
    }
    if(self.desired_anim_pose == "prone") {
      self SetProneAnimNodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
      self EnterProneWrapper(0.5);
      self SetAnimKnobAll(animArray("straight_level", "combat"), % body, 1, 0.1, 1);
    }
  }
  self.desired_anim_pose = undefined;
}

initialize(animscript) {
  if(isDefined(self.longDeathStarting)) {
    if(animscript != "pain" && animscript != "death") {
      self DoDamage(self.health + 100, self.origin);
    }
    if(animscript != "pain") {
      self.longDeathStarting = undefined;
      self notify("kill_long_death");
    }
  }
  if(isDefined(self.a.mayOnlyDie) && animscript != "death") {
    self DoDamage(self.health + 100, self.origin);
  }
  if(isDefined(self.a.postScriptFunc)) {
    scriptFunc = self.a.postScriptFunc;
    self.a.postScriptFunc = undefined;
    [[scriptFunc]](animscript);
  }
  if(animscript != "combat" && animscript != "pain" && animscript != "death" && usingSidearm() && (!isDefined(self.forceSideArm) || !self.forceSideArm)) {
    self animscripts\shared::placeWeaponOn(self.primaryweapon, "right");
  }
  if(animscript != "combat" && animscript != "move" && animscript != "pain") {
    self.a.magicReloadWhenReachEnemy = false;
  }
  if(animscript != "death") {
    self.a.nodeath = false;
  }
  if(isDefined(self.isHoldingGrenade) && (animscript == "pain" || animscript == "death" || animscript == "flashed")) {
    self dropGrenade();
  }
  self.isHoldingGrenade = undefined;
  self animscripts\squadmanager::aiUpdateAnimState(animscript);
  self.coverNode = undefined;
  self.suppressed = false;
  self.isReloading = false;
  self.changingCoverPos = false;
  self.a.scriptStartTime = GetTime();
  self.a.atConcealmentNode = false;
  self.a.atPillarNode = false;
  if(isDefined(self.node)) {
    if(self.node.type == "Conceal Prone" || self.node.type == "Conceal Crouch" || self.node.type == "Conceal Stand") {
      self.a.atConcealmentNode = true;
    } else if(self.node.type == "Cover Pillar") {
      self.a.atPillarNode = true;
    }
  }
  initAnimTree(animscript);
  UpdateAnimPose();
}

getPreferredWeapon() {
  if(isDefined(self.wantshotgun) && self.wantshotgun) {
    if(weaponclass(self.primaryweapon) == "spread") {
      return self.primaryweapon;
    } else if(weaponclass(self.secondaryweapon) == "spread") {
      return self.secondaryweapon;
    }
  }
  return self.primaryweapon;
}

badplacer(time, org, radius) {
  for(i = 0; i < time * 20; i++) {
    for(p = 0; p < 10; p++) {
      angles = (0, randomInt(360), 0);
      forward = anglesToForward(angles);
      scale = vector_scale(forward, radius);
      line(org, org + scale, (1, 0.3, 0.3));
    }
    wait(0.05);
  }
}

getOldRadius() {
  self notify("newOldradius");
  self endon("newOldradius");
  self endon("death");
  wait(6);
  self.goalradius = self.a.oldgoalradius;
}

sightCheckNodeProc(invalidateNode, viewOffset) {
  if(!isDefined(self.missedSightChecks)) {
    self.missedSightChecks = 0;
  }
  if(!isDefined(invalidateNode)) {
    invalidateNode = 1;
  }
  if(isDefined(viewOffset)) {
    canShootAt = canShootEnemyFrom(viewOffset);
  } else {
    canShootAt = self canShootEnemy();
  }
  if(!canShootAt) {
    if(invalidateNode) {
      self.missedSightChecks++;
    }
  } else {
    self.missedSightChecks = 0;
  }
  if(self.missedSightChecks > 4) {
    self lookForBetterCover();
    self.missedSightChecks = 0;
  }
  return canShootAt;
}

sightCheckNode_invalidate(viewOffset) {
  return sightCheckNodeProc(true, viewOffset);
}

sightCheckNode(viewOffset) {
  return sightCheckNodeProc(false, viewOffset);
}

IsInCombat() {
  if(isValidEnemy(self.enemy)) {
    self.a.combatEndTime = GetTime() + anim.combatMemoryTimeConst + randomInt(anim.combatMemoryTimeRand);
    return true;
  }
  return (self.a.combatEndTime > GetTime());
}

holdingWeapon() {
  if(self.a.weaponPos["right"] == "none" && self.a.weaponPos["left"] == "none") {
    return (false);
  }
  if(!isDefined(self.holdingWeapon)) {
    return (true);
  }
  return (self.holdingWeapon);
}

canShootEnemyFromPose(pose, offset, useSightCheck) {
  if(self.weapon == "mg42") {
    return false;
  }
  switch (pose) {
    case "stand":
      if(self.a.pose == "stand") {
        poseOffset = (0, 0, 0);
      } else if(self.a.pose == "crouch") {
        poseOffset = (0, 0, 20);
      } else if(self.a.pose == "prone") {
        poseOffset = (0, 0, 55);
      } else {
        assertEX(0, "init::canShootEnemyFromPose " + self.a.pose);
        poseOffset = (0, 0, 0);
      }
      break;
    case "crouch":
      if(self.a.pose == "stand") {
        poseOffset = (0, 0, -20);
      } else if(self.a.pose == "crouch") {
        poseOffset = (0, 0, 0);
      } else if(self.a.pose == "prone") {
        poseOffset = (0, 0, 35);
      } else {
        assertEX(0, "init::canShootEnemyFromPose " + self.a.pose);
        poseOffset = (0, 0, 0);
      }
      break;
    case "prone":
      if(self.a.pose == "stand") {
        poseOffset = (0, 0, -55);
      } else if(self.a.pose == "crouch") {
        poseOffset = (0, 0, -35);
      } else if(self.a.pose == "prone") {
        poseOffset = (0, 0, 0);
      } else {
        assertEX(0, "init::canShootEnemyFromPose " + self.a.pose);
        poseOffset = (0, 0, 0);
      }
      break;
    default:
      assertEX(0, "init::canShootEnemyFromPose - bad supplied pose: " + pose);
      poseOffset = (0, 0, 0);
      break;
  }
  if(isDefined(offset)) {
    poseOffset = poseOffset + self LocalToWorldCoords(offset) - self.origin;
  }
  return canShootEnemyFrom(poseOffset, undefined, useSightCheck);
}

canShootEnemy(posOverrideEntity, useSightCheck) {
  return canShootEnemyFrom((0, 0, 0), posOverrideEntity, useSightCheck);
}

canShootEnemyPos(posOverrideOrigin) {
  return canShootEnemyFrom((0, 0, 0), undefined, true, posOverrideOrigin);
}

canShootEnemyFrom(offset, posOverrideEntity, useSightCheck, posOverrideOrigin) {
  if(!isValidEnemy(self.enemy) && !isValidEnemy(posOverrideEntity)) {
    return false;
  }
  if(!holdingWeapon()) {
    return false;
  }
  if(isDefined(posOverrideEntity)) {
    if(IsSentient(posOverrideEntity)) {
      eye = posOverrideEntity getEye();
      chest = eye + (0, 0, -20);
    } else {
      eye = posOverrideEntity.origin;
      chest = eye;
    }
  } else if(isDefined(posOverrideOrigin)) {
    eye = posOverrideOrigin;
    chest = eye + (0, 0, -20);
  } else {
    eye = GetEnemyEyePos();
    chest = eye + (0, 0, -20);
  }
  myGunPos = self GetTagOrigin("tag_flash");
  if(!isDefined(useSightCheck)) {
    useSightCheck = true;
  }
  if(useSightCheck) {
    myEyeOffset = (self GetShootAtPos() - myGunPos);
    canSee = self canshoot(eye, myEyeOffset + offset);
  } else {
    canSee = true;
  }
  if(!canSee) {
    return false;
  }
  canShoot = self canshoot(eye, offset) || self canshoot(chest, offset);
  return (canShoot);
}

GetEnemyEyePos() {
  if(isValidEnemy(self.enemy)) {
    self.a.lastEnemyPos = self.enemy GetShootAtPos();
    self.a.lastEnemyTime = GetTime();
    return self.a.lastEnemyPos;
  } else if(isDefined(self.a.lastEnemyTime) &&
    isDefined(self.a.lastEnemyPos) &&
    (self.a.lastEnemyTime + 3000) < GetTime()) {
    return self.a.lastEnemyPos;
  } else {
    targetPos = self GetShootAtPos();
    targetPos = targetPos + (196 * self.lookforward[0], 196 * self.lookforward[1], 196 * self.lookforward[2]);
    return targetPos;
  }
}

GetNodeYawToOrigin(pos) {
  if(isDefined(self.node)) {
    yaw = self.node.angles[1] - GetYaw(pos);
  } else {
    yaw = self.angles[1] - GetYaw(pos);
  }
  yaw = AngleClamp180(yaw);
  return yaw;
}

GetNodeYawToEnemy() {
  pos = undefined;
  if(isValidEnemy(self.enemy)) {
    pos = self.enemy.origin;
  } else {
    if(isDefined(self.node)) {
      forward = anglesToForward(self.node.angles);
    } else {
      forward = anglesToForward(self.angles);
    }
    forward = vector_scale(forward, 150);
    pos = self.origin + forward;
  }
  if(isDefined(self.node)) {
    yaw = self.node.angles[1] - GetYaw(pos);
  } else {
    yaw = self.angles[1] - GetYaw(pos);
  }
  yaw = AngleClamp180(yaw);
  return yaw;
}

GetCoverNodeYawToEnemy() {
  pos = undefined;
  if(isValidEnemy(self.enemy)) {
    pos = self.enemy.origin;
  } else {
    forward = anglesToForward(self.coverNode.angles + self.animarray["angle_step_out"][self.a.cornerMode]);
    forward = vector_scale(forward, 150);
    pos = self.origin + forward;
  }
  yaw = self.CoverNode.angles[1] + self.animarray["angle_step_out"][self.a.cornerMode] - GetYaw(pos);
  yaw = AngleClamp180(yaw);
  return yaw;
}

GetYawToSpot(spot) {
  pos = spot;
  yaw = self.angles[1] - GetYaw(pos);
  yaw = AngleClamp180(yaw);
  return yaw;
}

GetYawToEnemy() {
  pos = undefined;
  if(isValidEnemy(self.enemy)) {
    pos = self.enemy.origin;
  } else {
    forward = anglesToForward(self.angles);
    forward = vector_scale(forward, 150);
    pos = self.origin + forward;
  }
  yaw = self.angles[1] - GetYaw(pos);
  yaw = AngleClamp180(yaw);
  return yaw;
}

GetYaw(org) {
  angles = VectorToAngles(org - self.origin);
  return angles[1];
}

GetPitch(org) {
  angles = VectorToAngles(org - self.origin);
  return angles[0];
}

GetYaw2d(org) {
  angles = VectorToAngles((org[0], org[1], 0) - (self.origin[0], self.origin[1], 0));
  return angles[1];
}

AbsYawToEnemy() {
  assert(isValidEnemy(self.enemy));
  yaw = self.angles[1] - GetYaw(self.enemy.origin);
  yaw = AngleClamp180(yaw);
  if(yaw < 0) {
    yaw = -1 * yaw;
  }
  return yaw;
}

AbsYawToEnemy2d() {
  assert(isValidEnemy(self.enemy));
  yaw = self.angles[1] - GetYaw2d(self.enemy.origin);
  yaw = AngleClamp180(yaw);
  if(yaw < 0) {
    yaw = -1 * yaw;
  }
  return yaw;
}

AbsYawToOrigin(org) {
  yaw = self.angles[1] - GetYaw(org);
  yaw = AngleClamp180(yaw);
  if(yaw < 0) {
    yaw = -1 * yaw;
  }
  return yaw;
}

AbsYawToAngles(angles) {
  yaw = self.angles[1] - angles;
  yaw = AngleClamp180(yaw);
  if(yaw < 0) {
    yaw = -1 * yaw;
  }
  return yaw;
}

GetYawFromOrigin(org, start) {
  angles = VectorToAngles(org - start);
  return angles[1];
}

GetYawToTag(tag, org) {
  yaw = self GetTagAngles(tag)[1] - GetYawFromOrigin(org, self GetTagOrigin(tag));
  yaw = AngleClamp180(yaw);
  return yaw;
}

GetYawToOrigin(org) {
  yaw = self.angles[1] - GetYaw(org);
  yaw = AngleClamp180(yaw);
  return yaw;
}

GetEyeYawToOrigin(org) {
  yaw = self GetTagAngles("TAG_EYE")[1] - GetYaw(org);
  yaw = AngleClamp180(yaw);
  return yaw;
}

GetCoverNodeYawToOrigin(org) {
  yaw = self.coverNode.angles[1] + self.animarray["angle_step_out"][self.a.cornerMode] - GetYaw(org);
  yaw = AngleClamp180(yaw);
  return yaw;
}

GetPitchToOrigin(org) {
  pitch = self.angles[0] - GetPitch(org);
  pitch = AngleClamp180(pitch);
  return pitch;
}

isStanceAllowedWrapper(stance) {
  if(isDefined(self.coverNode)) {
    return self.coverNode doesNodeAllowStance(stance);
  }
  return self IsStanceAllowed(stance);
}

choosePose(preferredPose) {
  if(!isDefined(preferredPose)) {
    preferredPose = self.a.pose;
  }
  if(EnemiesWithinStandingRange()) {
    preferredPose = "stand";
  }
  switch (preferredPose) {
    case "stand":
      if(self isStanceAllowedWrapper("stand")) {
        resultPose = "stand";
      } else if(self isStanceAllowedWrapper("crouch")) {
        resultPose = "crouch";
      } else if(self isStanceAllowedWrapper("prone")) {
        resultPose = "prone";
      } else {
        println("No stance allowed!Remaining standing.");
        resultPose = "stand";
      }
      break;
    case "crouch":
      if(self isStanceAllowedWrapper("crouch")) {
        resultPose = "crouch";
      } else if(self isStanceAllowedWrapper("stand")) {
        resultPose = "stand";
      } else if(self isStanceAllowedWrapper("prone")) {
        resultPose = "prone";
      } else {
        println("No stance allowed!Remaining crouched.");
        resultPose = "crouch";
      }
      break;
    case "prone":
      if(self isStanceAllowedWrapper("prone")) {
        resultPose = "prone";
      } else if(self isStanceAllowedWrapper("crouch")) {
        resultPose = "crouch";
      } else if(self isStanceAllowedWrapper("stand")) {
        resultPose = "stand";
      } else {
        println("No stance allowed!Remaining prone.");
        resultPose = "prone";
      }
      break;
    default:
      println("utility::choosePose, called in " + self.a.script + " script: Unhandled anim_pose " + self.a.pose + " - using stand.");
      resultPose = "stand";
      break;
  }
  return resultPose;
}

okToMelee(person) {
  assert(isDefined(person));
  if(isDefined(self.a.personImMeleeing)) {
    ImNotMeleeing(self.a.personImMeleeing);
    assert(!isDefined(self.a.personImMeleeing));
  }
  if(isDefined(person.a.personMeleeingMe)) {
    oldAttacker = person.a.personMeleeingMe;
    if(isDefined(oldAttacker.a.personImMeleeing) && oldAttacker.a.personImMeleeing == person) {
      return false;
    }
    println("okToMelee - Shouldn't get to here");
    person.a.personMeleeingMe = undefined;
    assert(!isDefined(self.a.personImMeleeing));
    assert(!isDefined(person.a.personMeleeingMe));
    return true;
  }
  assert(!isDefined(self.a.personImMeleeing));
  assert(!isDefined(person.a.personMeleeingMe));
  return true;
}

IAmMeleeing(person) {
  assert(isDefined(person));
  assert(!isDefined(person.a.personMeleeingMe));
  assert(!isDefined(self.a.personImMeleeing));
  person.a.personMeleeingMe = self;
  self.a.personImMeleeing = person;
}

ImNotMeleeing(person) {
  if((isDefined(person)) && (isDefined(self.a.personImMeleeing)) && (self.a.personImMeleeing == person)) {
    assert(isDefined(person.a.personMeleeingMe));
    assert(person.a.personMeleeingMe == self);
  }
  if(!isDefined(person)) {
    self.a.personImMeleeing = undefined;
  } else if((isDefined(person.a.personMeleeingMe)) && (person.a.personMeleeingMe == self)) {
    person.a.personMeleeingMe = undefined;
    assert(self.a.personImMeleeing == person);
    self.a.personImMeleeing = undefined;
  }
  assert(!isDefined(person) || !isDefined(self.a.personImMeleeing) || (self.a.personImMeleeing != person));
  assert(!isDefined(person) || !isDefined(person.a.personMeleeingMe) || (person.a.personMeleeingMe != self));
}

WeaponAnims() {
  weaponModel = getWeaponModel(self.weapon);
  if((isDefined(self.holdingWeapon) && !self.holdingWeapon) || weaponModel == "") {
    return "none";
  }
  class = weaponClass(self.weapon);
  switch (class) {
    case "smg":
      if(is_true(level.supportsPistolAnimations) && self holdingWeapon())
        return "pistol";
      return "rifle";
    case "mg":
    case "rifle":
    case "pistol":
    case "rocketlauncher":
    case "spread":
    case "gas":
    case "grenade":
      return class;
    default:
      return "rifle";
  }
}

GetClaimedNode() {
  myNode = self.node;
  if(isDefined(myNode) && (self nearNode(myNode) || (isDefined(self.coverNode) && myNode == self.coverNode))) {
    return myNode;
  }
  return undefined;
}

GetNodeType() {
  myNode = GetClaimedNode();
  if(isDefined(myNode)) {
    return myNode.type;
  }
  return "none";
}

GetNodeDirection() {
  myNode = GetClaimedNode();
  if(isDefined(myNode)) {
    return myNode.angles[1];
  }
  return self.desiredAngle;
}

GetNodeForward() {
  myNode = GetClaimedNode();
  if(isDefined(myNode)) {
    return anglesToForward(myNode.angles);
  }
  return anglesToForward(self.angles);
}

GetNodeOrigin() {
  myNode = GetClaimedNode();
  if(isDefined(myNode)) {
    return myNode.origin;
  }
  return self.origin;
}

safemod(a, b) {
  result = int(a) % b;
  result += b;
  return result % b;
}

AngleClamp(angle) {
  angleFrac = angle / 360.0;
  angle = (angleFrac - floor(angleFrac)) * 360.0;
  return angle;
}

QuadrantAnimWeights(yaw) {
  forwardWeight = (90 - abs(yaw)) / 90;
  leftWeight = (90 - AbsAngleClamp180(abs(yaw - 90))) / 90;
  result["front"] = 0;
  result["right"] = 0;
  result["back"] = 0;
  result["left"] = 0;
  if(isDefined(self.alwaysRunForward)) {
    assert(self.alwaysRunForward);
    result["front"] = 1;
    return result;
  }
  useLeans = true;
  if(forwardWeight > 0) {
    result["front"] = forwardWeight;
    if(leftWeight > 0) {
      result["left"] = leftWeight;
    } else {
      result["right"] = -1 * leftWeight;
    }
  } else if(useLeans) {
    result["back"] = -1 * forwardWeight;
    if(leftWeight > 0) {
      result["left"] = leftWeight;
    } else {
      result["right"] = -1 * leftWeight;
    }
  } else {
    backWeight = -1 * forwardWeight;
    if(leftWeight > backWeight) {
      result["left"] = 1;
    } else if(leftWeight < forwardWeight) {
      result["right"] = 1;
    } else {
      result["back"] = 1;
    }
  }
  return result;
}

getQuadrant(angle) {
  angle = AngleClamp(angle);
  if(angle < 45 || angle > 315) {
    quadrant = "front";
  } else if(angle < 135) {
    quadrant = "left";
  } else if(angle < 225) {
    quadrant = "back";
  } else {
    quadrant = "right";
  }
  return quadrant;
}

NotifyAfterTime(notifyString, killmestring, time) {
  self endon("death");
  self endon(killmestring);
  wait time;
  self notify(notifyString);
}

drawString(stringtodraw) {
  self endon("killanimscript");
  self endon("enddrawstring");
  for(;;) {
    wait .05;
    Print3d((self GetDebugEye()) + (0, 0, 8), stringtodraw, (1, 1, 1), 1, 0.2);
  }
}

drawStringTime(msg, org, color, timer) {
  maxtime = timer * 20;
  for(i = 0; i < maxtime; i++) {
    Print3d(org, msg, color, 1, 1);
    wait .05;
  }
}

hasEnemySightPos() {
  if(isDefined(self.node)) {
    return (canSeeEnemyFromExposed() || canSuppressEnemyFromExposed());
  } else {
    return (canSeeEnemy() || canSuppressEnemy());
  }
}

getEnemySightPos() {
  assert(self.goodShootPosValid);
  return self.goodShootPos;
}

canShootPos(pos) {
  myGunPos = self GetTagOrigin("tag_flash");
  myEyeOffset = (self GetShootAtPos() - myGunPos);
  return (self canshoot(pos, myEyeOffset));
}

debugTimeout() {
  wait(5);
  self notify("timeout");
}

debugPosInternal(org, string, size) {
  self endon("death");
  self notify("stop debug " + org);
  self endon("stop debug " + org);
  ent = spawnStruct();
  ent thread debugTimeout();
  ent endon("timeout");
  if(self.enemy.team == "allies") {
    color = (0.4, 0.7, 1);
  } else {
    color = (1, 0.7, 0.4);
  }
  while(1) {
    wait(0.05);
    Print3d(org, string, color, 1, size);
  }
}

debugPos(org, string) {
  thread debugPosInternal(org, string, 2.15);
}

debugPosSize(org, string, size) {
  thread debugPosInternal(org, string, size);
}

printShootProc() {
  self endon("death");
  self notify("stop shoot " + self.export);
  self endon("stop shoot " + self.export);
  printTime = 0.25;
  timer = printTime * 20;
  for(i = 0; i < timer; i += 1) {
    wait(0.05);
    Print3d(self.origin + (0, 0, 70), "Shoot", (1, 0, 0), 1, 1);
  }
}

showDebugProc(fromPoint, toPoint, color, printTime) {
  self endon("death");
  timer = printTime * 20;
  for(i = 0; i < timer; i += 1) {
    wait(0.05);
    line(fromPoint, toPoint, color);
  }
}

showDebugLine(fromPoint, toPoint, color, printTime) {
  self thread showDebugProc(fromPoint, toPoint + (0, 0, -5), color, printTime);
}

shootEnemyWrapper() {
  if(self usingGasWeapon()) {
    [[anim.shootFlameThrowerWrapper_func]]();
  } else {
    [[anim.shootEnemyWrapper_func]]();
  }
}

shootEnemyWrapper_normal() {
  self.a.lastShootTime = GetTime();
  maps\_gameskill::set_accuracy_based_on_situation();
  self shoot(self.script_accuracy);
}

shootFlameThrowerWrapper_normal() {
  self.a.lastShootTime = GetTime();
  maps\_gameskill::set_accuracy_based_on_situation();
  if(!self.a.flamethrowerShootSwitch && self.a.lastShootTime > self.a.flamethrowerShootSwitchTimer) {
    self.a.flamethrowerShootSwitch = true;
    self.a.flamethrowerShootSwitchTimer = self.a.lastShootTime + RandomIntRange(self.a.flamethrowerShootTime_min, self.a.flamethrowerShootTime_max);
    self shoot(self.script_accuracy);
  } else if(self.a.flamethrowerShootSwitch && self.a.lastShootTime > self.a.flamethrowerShootSwitchTimer) {
    self.a.flamethrowerShootSwitch = false;
    flamethrower_stop_shoot();
    self.a.flamethrowerShootSwitchTimer = self.a.lastShootTime + RandomIntRange(self.a.flamethrowerShootDelay_min, self.a.flamethrowerShootDelay_max);
  }
}

flamethrower_stop_shoot(set_switch_timer) {
  if(self usingGasWeapon()) {
    if(isDefined(set_switch_timer)) {
      self.a.flamethrowerShootSwitchTimer = GetTime() + set_switch_timer;
      self.a.flamethrowerShootSwitch = false;
    }
    self notify("flame stop shoot");
    self StopShoot();
  }
}

shootPosWrapper(shootPos) {
  endpos = bulletSpread(self GetTagOrigin("tag_flash"), shootPos, 4);
  self.a.lastShootTime = GetTime();
  self shoot(1, endpos);
}

getAimDelay() {
  return 0.001;
}

setEnv(env) {
  if(env == "cold") {
    array_thread(GetAIArray(), ::PersonalColdBreath);
    array_thread(getspawnerarray(), ::PersonalColdBreathSpawner);
  }
}

PersonalColdBreath() {
  tag = "TAG_EYE";
  self endon("death");
  self notify("stop personal effect");
  self endon("stop personal effect");
  for(;;) {
    if(self.a.movement != "run") {
      playFXOnTag(level._effect["cold_breath"], self, tag);
      wait(2.5 + RandomFloat(3));
    } else {
      wait(0.5);
    }
  }
}

PersonalColdBreathSpawner() {
  self endon("death");
  self notify("stop personal effect");
  self endon("stop personal effect");
  for(;;) {
    self waittill("spawned", Spawn);
    if(maps\_utility::spawn_failed(Spawn)) {
      continue;
    }
    Spawn thread PersonalColdBreath();
  }
}

isSuppressedWrapper() {
  if(forcedCover("Show")) {
    return false;
  }
  if(forcedCover("Hide")) {
    return true;
  }
  if(isDefined(self.coverNode) && isDefined(self.playerAimSuppression) && self.playerAimSuppression) {
    return true;
  }
  if(self.suppressionMeter <= self.suppressionThreshold) {
    return false;
  }
  return self issuppressed();
}

isPartiallySuppressedWrapper() {
  if(forcedCover("Show")) {
    return false;
  }
  if(isDefined(self.coverNode) && isDefined(self.playerAimSuppression) && self.playerAimSuppression) {
    return true;
  }
  if(self.suppressionMeter <= self.suppressionThreshold * 0.25) {
    return false;
  }
  return (self issuppressed());
}

getNodeOffset(node) {
  if(isDefined(node.offset)) {
    return node.offset;
  }
  cover_left_crouch_offset = (-26, .4, 36);
  cover_left_stand_offset = (-32, 7, 63);
  cover_right_crouch_offset = (43.5, 11, 36);
  cover_right_stand_offset = (36, 8.3, 63);
  cover_crouch_offset = (3.5, -12.5, 45);
  cover_stand_offset = (-3.7, -22, 63);
  cornernode = false;
  nodeOffset = (0, 0, 0);
  right = AnglesToRight(node.angles);
  forward = anglesToForward(node.angles);
  switch (node.type) {
    case "Cover Left":
    case "Cover Left Wide":
      if(node isNodeDontStand() && !node isNodeDontCrouch()) {
        nodeOffset = calculateNodeOffset(right, forward, cover_left_crouch_offset);
      } else {
        nodeOffset = calculateNodeOffset(right, forward, cover_left_stand_offset);
      }
      break;
    case "Cover Right":
    case "Cover Right Wide":
      if(node isNodeDontStand() && !node isNodeDontCrouch()) {
        nodeOffset = calculateNodeOffset(right, forward, cover_right_crouch_offset);
      } else {
        nodeOffset = calculateNodeOffset(right, forward, cover_right_stand_offset);
      }
      break;
    case "Cover Stand":
    case "Conceal Stand":
    case "Turret":
      nodeOffset = calculateNodeOffset(right, forward, cover_stand_offset);
      break;
    case "Cover Crouch":
    case "Cover Crouch Window":
    case "Conceal Crouch":
      nodeOffset = calculateNodeOffset(right, forward, cover_crouch_offset);
      break;
  }
  node.offset = nodeOffset;
  return node.offset;
}

calculateNodeOffset(right, forward, baseoffset) {
  return vector_scale(right, baseoffset[0]) + vector_scale(forward, baseoffset[1]) + (0, 0, baseoffset[2]);
}

canSeeEnemy() {
  if(!isValidEnemy(self.enemy)) {
    return false;
  }
  if((self canSee(self.enemy) && checkPitchVisibility(self getEye(), self.enemy GetShootAtPos())) ||
    (isDefined(self.cansee_override) && self.cansee_override)) {
    self.goodShootPosValid = true;
    self.goodShootPos = GetEnemyEyePos();
    dontGiveUpOnSuppressionYet();
    return true;
  }
  return false;
}

canSeeEnemyFromExposed() {
  if(!isValidEnemy(self.enemy)) {
    self.goodShootPosValid = false;
    return false;
  }
  enemyEye = GetEnemyEyePos();
  if(!isDefined(self.node)) {
    result = self canSee(self.enemy);
  } else {
    result = canSeePointFromExposedAtNode(enemyEye, self.node);
  }
  if(result) {
    self.goodShootPosValid = true;
    self.goodShootPos = enemyEye;
    dontGiveUpOnSuppressionYet();
  } else {}
  return result;
}

canSeePointFromExposedAtNode(point, node) {
  if(node.type == "Cover Left" || node.type == "Cover Right" || node.type == "Cover Left Wide" || node.type == "Cover Right Wide" || node.type == "Cover Pillar") {
    if(!self call_overloaded_func("animscripts\corner", "canSeePointFromExposedAtCorner", point, node)) {
      return false;
    }
  }
  nodeOffset = getNodeOffset(node);
  lookFromPoint = node.origin + nodeOffset;
  if(node.type == "Cover Pillar") {
    nodeOffsets = [];
    if(node isNodeDontStand()) {
      if(!node IsNodeDontRight()) {
        nodeOffsets[nodeOffsets.size] = (32, -10, 30);
      }
      if(!node IsNodeDontLeft()) {
        nodeOffsets[nodeOffsets.size] = (-28, -10, 30);
      }
    } else {
      if(!node IsNodeDontRight()) {
        nodeOffsets[nodeOffsets.size] = (34, 0.2, 60);
      }
      if(!node IsNodeDontLeft()) {
        nodeOffsets[nodeOffsets.size] = (-32, 3.7, 60);
      }
    }
    if(nodeOffsets.size > 1 && isDefined(node.desiredCornerDirection) && node.desiredCornerDirection == "left") {
      nodeOffsets = array_swap(nodeOffsets, 0, 1);
    }
    right = AnglesToRight(node.angles);
    forward = anglesToForward(node.angles);
    for(i = 0; i < nodeOffsets.size; i++) {
      nodeOffset = calculateNodeOffset(right, forward, nodeOffsets[i]);
      lookFromPoint = node.origin + nodeOffset;
      if(canSeePointFromExposedAtNodeWithOffset(point, node, lookFromPoint)) {
        if(nodeOffsets[i][0] < 0) {
          node.desiredCornerDirection = "left";
        } else {
          node.desiredCornerDirection = "right";
        }
        node.offset = nodeOffset;
        return true;
      }
    }
    return false;
  } else if(!canSeePointFromExposedAtNodeWithOffset(point, node, lookFromPoint)) {
    return false;
  }
  return true;
}

canSeePointFromExposedAtNodeWithOffset(point, node, lookFromPoint) {
  if(!checkPitchVisibility(lookFromPoint, point, node)) {
    return false;
  }
  if(!sightTracePassed(lookFromPoint, point, false, undefined)) {
    if(node.type == "Cover Crouch" || node.type == "Conceal Crouch") {
      lookFromPoint = (0, 0, 64) + node.origin;
      return sightTracePassed(lookFromPoint, point, false, undefined);
    }
    return false;
  }
  return true;
}

checkPitchVisibility(fromPoint, toPoint, atNode) {
  pitch = AngleClamp180(VectorToAngles(toPoint - fromPoint)[0]);
  if(abs(pitch) > 45) {
    if(isDefined(atNode) && atNode.type != "Cover Crouch" && atNode.type != "Conceal Crouch") {
      return false;
    }
    if(pitch > 45 || pitch < anim.coverCrouchLeanPitch - 45) {
      dist = distanceSquared(fromPoint, toPoint);
      if(pitch < 75 && dist < 64 * 64) {
        return true;
      }
      return false;
    }
  }
  return true;
}

dontGiveUpOnSuppressionYet() {
  self.a.shouldResetGiveUpOnSuppressionTimer = true;
}

updateGiveUpOnSuppressionTimer() {
  if(!isDefined(self.a.shouldResetGiveUpOnSuppressionTimer)) {
    self.a.shouldResetGiveUpOnSuppressionTimer = true;
  }
  if(self.a.shouldResetGiveUpOnSuppressionTimer) {
    self.a.giveUpOnSuppressionTime = GetTime() + randomintrange(15000, 30000);
    self.a.shouldResetGiveUpOnSuppressionTimer = false;
  }
}

aiSuppressAI() {
  if(!self canAttackEnemyNode()) {
    return false;
  }
  shootPos = undefined;
  if(isDefined(self.enemy.node)) {
    nodeOffset = getNodeOffset(self.enemy.node);
    shootPos = self.enemy.node.origin + nodeOffset;
  } else {
    shootPos = self.enemy GetShootAtPos();
  }
  if(!self canShoot(shootPos)) {
    return false;
  }
  if(self.a.script == "combat") {
    if(!sighttracepassed(self getEye(), self GetTagOrigin("tag_flash"), false, undefined)) {
      return false;
    }
  }
  self.goodShootPosValid = true;
  self.goodShootPos = shootPos;
  return true;
}

canSuppressEnemyFromExposed() {
  if(!hasSuppressableEnemy()) {
    self.goodShootPosValid = false;
    return false;
  }
  if(!IsPlayer(self.enemy)) {
    return aiSuppressAI();
  }
  if(isDefined(self.node)) {
    if(self.node.type == "Cover Left" || self.node.type == "Cover Right" || self.node.type == "Cover Left Wide" || self.node.type == "Cover Right Wide") {
      if(!self call_overloaded_func("animscripts\corner", "canSeePointFromExposedAtCorner", self GetEnemyEyePos(), self.node)) {
        return false;
      }
    }
    nodeOffset = getNodeOffset(self.node);
    startOffset = self.node.origin + nodeOffset;
  } else {
    startOffset = self GetTagOrigin("tag_flash");
  }
  if(!checkPitchVisibility(startOffset, self.lastEnemySightPos)) {
    return false;
  }
  return findGoodSuppressSpot(startOffset);
}

canSuppressEnemy() {
  if(!hasSuppressableEnemy()) {
    self.goodShootPosValid = false;
    return false;
  }
  hasTagFlash = self GetTagOrigin("tag_flash");
  if(!isDefined(hasTagFlash))
    return false;
  if(!IsPlayer(self.enemy)) {
    return aiSuppressAI();
  }
  startOffset = self GetTagOrigin("tag_flash");
  if(!checkPitchVisibility(startOffset, self.lastEnemySightPos)) {
    return false;
  }
  return findGoodSuppressSpot(startOffset);
}

hasSuppressableEnemy() {
  if(!isValidEnemy(self.enemy)) {
    return false;
  }
  if(!isDefined(self.lastEnemySightPos)) {
    return false;
  }
  updateGiveUpOnSuppressionTimer();
  if(GetTime() > self.a.giveUpOnSuppressionTime) {
    return false;
  }
  if(!needRecalculateSuppressSpot()) {
    return self.goodShootPosValid;
  }
  return true;
}

canSeeAndShootPoint(point) {
  if(!sightTracePassed(self GetShootAtPos(), point, false, undefined)) {
    return false;
  }
  if(self.a.weaponPos["right"] == "none") {
    return false;
  }
  gunpoint = self GetTagOrigin("tag_flash");
  return sightTracePassed(gunpoint, point, false, undefined);
}

needRecalculateSuppressSpot() {
  if(self.goodShootPosValid && !self canSeeAndShootPoint(self.goodShootPos)) {
    return true;
  }
  return (
    !isDefined(self.lastEnemySightPosOld) ||
    self.lastEnemySightPosOld != self.lastEnemySightPos ||
    distanceSquared(self.lastEnemySightPosSelfOrigin, self.origin) > 1024
  );
}

findGoodSuppressSpot(startOffset) {
  if(!needRecalculateSuppressSpot()) {
    return self.goodShootPosValid;
  }
  if(!sightTracePassed(self GetShootAtPos(), startOffset, false, undefined)) {
    self.goodShootPosValid = false;
    return false;
  }
  self.lastEnemySightPosSelfOrigin = self.origin;
  self.lastEnemySightPosOld = self.lastEnemySightPos;
  currentEnemyPos = GetEnemyEyePos();
  trace = bulletTrace(self.lastEnemySightPos, currentEnemyPos, false, undefined);
  startTracesAt = trace["position"];
  percievedMovementVector = self.lastEnemySightPos - startTracesAt;
  lookVector = VectorNormalize(self.lastEnemySightPos - startOffset);
  percievedMovementVector = percievedMovementVector - vector_scale(lookVector, vectorDot(percievedMovementVector, lookVector));
  idealTraceInterval = 20.0;
  numTraces = int(Length(percievedMovementVector) / idealTraceInterval + 0.5);
  if(numTraces < 1) {
    numTraces = 1;
  }
  if(numTraces > 20) {
    numTraces = 20;
  }
  vectorDif = self.lastEnemySightPos - startTracesAt;
  vectorDif = (vectorDif[0] / numTraces, vectorDif[1] / numTraces, vectorDif[2] / numTraces);
  numTraces++;
  traceTo = startTracesAt;
  self.goodShootPosValid = false;
  goodTraces = 0;
  neededGoodTraces = 2;
  for(i = 0; i < numTraces + neededGoodTraces; i++) {
    tracePassed = sightTracePassed(startOffset, traceTo, false, undefined);
    thisTraceTo = traceTo;
    if(i == numTraces - 1) {
      vectorDif = vectorDif - vector_scale(lookVector, vectorDot(vectorDif, lookVector));
    }
    traceTo += vectorDif;
    if(tracePassed) {
      goodTraces++;
      self.goodShootPosValid = true;
      self.goodShootPos = thisTraceTo;
      if(i > 0 && goodTraces < neededGoodTraces && i < numTraces + neededGoodTraces - 1) {
        continue;
      }
      return true;
    } else {
      goodTraces = 0;
    }
  }
  return self.goodShootPosValid;
}

anim_array(animArray, animWeights) {
  total_anims = animArray.size;
  idleanim = randomInt(total_anims);
  assert(total_anims);
  assert(animArray.size == animWeights.size);
  if(total_anims == 1) {
    return animArray[0];
  }
  weights = 0;
  total_weight = 0;
  for(i = 0; i < total_anims; i++) {
    total_weight += animWeights[i];
  }
  anim_play = RandomFloat(total_weight);
  current_weight = 0;
  for(i = 0; i < total_anims; i++) {
    current_weight += animWeights[i];
    if(anim_play >= current_weight) {
      continue;
    }
    idleanim = i;
    break;
  }
  return animArray[idleanim];
}

forcedCover(msg) {
  return isDefined(self.a.forced_cover) && (self.a.forced_cover == msg);
}

print3dtime(timer, org, msg, color, alpha, scale) {
  newtime = timer / 0.05;
  for(i = 0; i < newtime; i++) {
    Print3d(org, msg, color, alpha, scale);
    wait(0.05);
  }
}

crossproduct(vec1, vec2) {
  return (vec1[0] * vec2[1] - vec1[1] * vec2[0] > 0);
}

scriptChange() {
  self.a.current_script = "none";
  self notify(anim.scriptChange);
}

getGrenadeModel() {
  return getWeaponModel(self.grenadeweapon);
}

canThrowGrenade() {
  if(!self.grenadeAmmo) {
    return false;
  }
  if(self.script_forceGrenade) {
    return true;
  }
  return (IsPlayer(self.enemy));
}

usingBoltActionWeapon() {
  if(!isDefined(self.weapon) || self.weapon == "none" || self usingShotgun()) {
    return false;
  }
  return (weaponIsBoltAction(self.weapon));
}

usingGasWeapon() {
  return (weaponIsGasWeapon(self.weapon));
}

metalHat() {
  if(!isDefined(self.hatmodel)) {
    return false;
  }
  return (isDefined(anim.metalHat[self.model]));
}

setFootstepEffect(name, fx) {
  assertEx(isDefined(name), "Need to define the footstep surface type.");
  assertEx(isDefined(fx), "Need to define the mud footstep effect.");
  if(!isDefined(anim.optionalStepEffects)) {
    anim.optionalStepEffects = [];
  }
  anim.optionalStepEffects[anim.optionalStepEffects.size] = name;
  level._effect["step_" + name] = fx;
  anim.optionalStepEffectFunction = animscripts\shared::playFootStepEffect;
}

persistentDebugLine(start, end) {
  self endon("death");
  level notify("newdebugline");
  level endon("newdebugline");
  for(;;) {
    line(start, end, (0.3, 1, 0), 1);
    wait(0.05);
  }
}

EnterProneWrapper(timer) {
  thread enterProneWrapperProc(timer);
}

enterProneWrapperProc(timer) {
  self endon("death");
  self notify("anim_prone_change");
  self endon("anim_prone_change");
  self EnterProne(timer);
  self waittill("killanimscript");
  if(self.a.pose != "prone") {
    self.a.pose = "prone";
  }
}

ExitProneWrapper(timer) {
  thread ExitProneWrapperProc(timer);
}

ExitProneWrapperProc(timer) {
  self endon("death");
  self notify("anim_prone_change");
  self endon("anim_prone_change");
  self ExitProne(timer);
  self waittill("killanimscript");
  if(self.a.pose == "prone") {
    self.a.pose = "crouch";
  }
}

canBlindfire() {
  if(self.a.atConcealmentNode) {
    return false;
  }
  if(!animscripts\weaponList::usingAutomaticWeapon() && !usingPistol()) {
    return false;
  }
  if(weaponClass(self.weapon) == "mg") {
    return false;
  }
  if(isDefined(self.disable_blindfire) && self.disable_blindfire == true) {
    return false;
  }
  return true;
}

canSwitchSides() {
  if(!self.a.atPillarNode) {
    return false;
  }
  if(GetTime() < self.a.nextAllowedSwitchSidesTime) {
    return false;
  }
  if(self usingPistol()) {
    return false;
  }
  return true;
}

canHitSuppressSpot() {
  if(!hasEnemySightPos()) {
    return false;
  }
  myGunPos = self GetTagOrigin("tag_flash");
  return (sightTracePassed(myGunPos, getEnemySightPos(), false, undefined));
}

isNodeDontStand() {
  return (self has_spawnflag(level.SPAWNFLAG_PATH_DONT_STAND));
}

isNodeDontCrouch() {
  return (self has_spawnflag(level.SPAWNFLAG_PATH_DONT_CROUCH));
}

isNodeDontProne() {
  return (self has_spawnflag(level.SPAWNFLAG_PATH_DONT_PRONE));
}

doesNodeAllowStance(stance) {
  if(stance == "stand") {
    return !self isNodeDontStand();
  } else if(stance == "crouch") {
    return !self isNodeDontCrouch();
  } else {
    assert(stance == "prone");
    return !self isNodeDontProne();
  }
}

isNodeDontLeft() {
  return (self has_spawnflag(level.SPAWNFLAG_PATH_DONT_LEFT));
}

isNodeDontRight() {
  return (self has_spawnflag(level.SPAWNFLAG_PATH_DONT_RIGHT));
}

getAIPrimaryWeapon() {
  return self.primaryweapon;
}

getAISecondaryWeapon() {
  return self.secondaryweapon;
}

getAISidearmWeapon() {
  return self.sidearm;
}

getAICurrentWeapon() {
  return self.weapon;
}

usingSecondary() {
  return (self.weapon == self.secondaryweapon);
}

usingSidearm() {
  return (self.weapon == self.sidearm);
}

getAICurrentWeaponSlot() {
  if(self.weapon == self.primaryweapon) {
    return "primary";
  } else if(self.weapon == self.secondaryweapon) {
    return "secondary";
  } else if(self.weapon == self.sidearm) {
    return "sidearm";
  } else {
    assertMsg("self.weapon does not match any known slot");
  }
}

AIhasWeapon(weapon) {
  if(isDefined(weapon) && weapon != "" && isDefined(self.weaponInfo[weapon])) {
    return true;
  }
  return false;
}

AIHasPrimaryWeapon() {
  return (self.primaryweapon != "" && self.primaryweapon != "none");
}

AIHasSecondaryWeapon() {
  return (self.secondaryweapon != "" && self.secondaryweapon != "none");
}

AIHasSidearm() {
  return (self.sidearm != "" && self.sidearm != "none");
}

AIHasOnlyPistol() {
  return (self.primaryweapon == self.weapon && usingPistol());
}

getAnimEndPos(theanim) {
  moveDelta = GetMoveDelta(theanim, 0, 1);
  return self localToWorldCoords(moveDelta);
}

isValidEnemy(enemy) {
  if(!isDefined(enemy)) {
    return false;
  }
  return true;
}

damageLocationIsAny(a, b, c, d, e, f, g, h, i, j, k, ovr) {
  if(!isDefined(self.damageLocation)) {
    return false;
  }
  if(!isDefined(a)) return false;
  if(self.damageLocation == a) return true;
  if(!isDefined(b)) return false;
  if(self.damageLocation == b) return true;
  if(!isDefined(c)) return false;
  if(self.damageLocation == c) return true;
  if(!isDefined(d)) return false;
  if(self.damageLocation == d) return true;
  if(!isDefined(e)) return false;
  if(self.damageLocation == e) return true;
  if(!isDefined(f)) return false;
  if(self.damageLocation == f) return true;
  if(!isDefined(g)) return false;
  if(self.damageLocation == g) return true;
  if(!isDefined(h)) return false;
  if(self.damageLocation == h) return true;
  if(!isDefined(i)) return false;
  if(self.damageLocation == i) return true;
  if(!isDefined(j)) return false;
  if(self.damageLocation == j) return true;
  if(!isDefined(k)) return false;
  if(self.damageLocation == k) return true;
  AssertEx(!isDefined(ovr), "Too many parameters");
  return false;
}

usingRifle() {
  return weaponClass(self.weapon) == "rifle";
}

usingShotgun() {
  return weaponClass(self.weapon) == "spread";
}

usingRocketLauncher() {
  return weaponClass(self.weapon) == "rocketlauncher";
}

usingGrenadeLauncher() {
  return weaponClass(self.weapon) == "grenade";
}

usingPistol() {
  return (self WeaponAnims()) == "pistol";
}

ragdollDeath(moveAnim) {
  self endon("killanimscript");
  lastOrg = self.origin;
  moveVec = (0, 0, 0);
  for(;;) {
    wait(0.05);
    force = distance(self.origin, lastOrg);
    lastOrg = self.origin;
    if(self.health == 1) {
      self.a.nodeath = true;
      self startRagdoll();
      self ClearAnim(moveAnim, 0.1);
      wait(0.05);
      physicsExplosionSphere(lastOrg, 600, 0, force * 0.1);
      self notify("killanimscript");
      return;
    }
  }
}

isCQBWalking() {
  return isDefined(self.cqbwalking) && self.cqbwalking && !usingPistol();
}

squared(value) {
  return value * value;
}

randomizeIdleSet() {
  idleAnimArray = animArray("idle", "stop");
  self.a.idleSet = randomInt(idleAnimArray.size);
}

weapon_spread() {
  return weaponclass(self.weapon) == "spread";
}

getRandomIntFromSeed(intSeed, intMax) {
  assert(intMax > 0);
  index = intSeed % anim.randomIntTableSize;
  return anim.randomIntTable[index] % intMax;
}

is_banzai() {
  return isDefined(self.banzai) && self.banzai;
}

is_rusher() {
  return isDefined(self.rusher) && self.rusher;
}

is_heavy_machine_gun() {
  return isDefined(self.heavy_machine_gunner) && self.heavy_machine_gunner;
}

is_zombie() {
  if(isDefined(self.is_zombie) && self.is_zombie) {
    return true;
  }
  return false;
}

is_civilian() {
  if(isDefined(self.is_civilian) && self.is_civilian) {
    return true;
  }
  return false;
}

is_zombie_gibbed() {
  return (self is_zombie() && self.gibbed);
}

set_zombie_gibbed() {
  if(self is_zombie()) {
    self.gibbed = true;
  }
}

is_skeleton(skeleton) {
  if((skeleton == "base") && IsSubStr(get_skeleton(), "scaled")) {
    return true;
  }
  return (get_skeleton() == skeleton);
}

get_skeleton() {
  if(isDefined(self.skeleton)) {
    return self.skeleton;
  } else {
    return "base";
  }
}

isBalconyNode(node) {
  return ((isDefined(anim.balcony_node_types[node.type])) &&
    (node has_spawnflag(level.SPAWNFLAG_PATH_BALCONY) || node has_spawnflag(level.SPAWNFLAG_PATH_BALCONY_NORAILING))
  );
}

isBalconyNodeNoRailing(node) {
  return ((isBalconyNode(node)) &&
    node has_spawnflag(level.SPAWNFLAG_PATH_BALCONY_NORAILING)
  );
}

do_ragdoll_death() {
  AssertEx(!is_true(self.magic_bullet_shield), "Cannot ragdoll death on guy with magic bullet shield.");
  self Unlink();
  self StartRagdoll();
  self call_overloaded_func("animscripts\death", "PlayDeathSound");
  if(IsAI(self)) {
    self.a.doingRagdollDeath = true;
  }
  wait(0.1);
  if(IsAlive(self)) {
    if(IsAI(self)) {
      self.a.nodeath = true;
      self.a.doingRagdollDeath = true;
      self animscripts\shared::DropAllAIWeapons();
    }
    self BloodImpact("none");
    self.allowdeath = true;
    self DoDamage(self.health + 100, self.origin, self.attacker);
  }
}

LookingAtEntity() {
  return self.looking_at_entity;
}

SetLookAtEntity(ent) {
  self LookAtEntity(ent);
  self.looking_at_entity = true;
}

StopLookingAtEntity() {
  if(!(isDefined(self.lookat_set_in_anim) && self.lookat_set_in_anim)) {
    self LookAtEntity();
  }
  self.looking_at_entity = false;
}

idleLookatBehaviorTidyup() {
  self waittill_either("killanimscript", "newLookAtBehavior");
  if(isDefined(self)) {
    self StopLookingAtEntity();
  }
}

IsOkToLookAtEntity() {
  if(isDefined(level._dont_look_at_player) && level._dont_look_at_player) {
    return false;
  }
  if(isDefined(self.lookat_set_in_anim) && self.lookat_set_in_anim) {
    return false;
  }
  if(isDefined(self.coverNode) && isDefined(self.coverNode.script_dont_look)) {
    return false;
  }
  if(isDefined(self.coverNode) && isDefined(self.a.script) && (self.a.script == "cover_right" || self.a.script == "cover_left") && self.a.pose == "crouch") {
    return false;
  }
  return true;
}

entityInFront(origin) {
  forward = anglesToForward(self.angles);
  dot = VectorDot(forward, VectorNormalize(origin - self.origin));
  return (dot > 0.3);
}

idleLookatBehavior(dist_thresh, dot_check) {
  self notify("newLookAtBehavior");
  self endon("newLookAtBehavior");
  if(self.team == "axis") {
    return;
  }
  self endon("killanimscript");
  self thread idleLookatBehaviorTidyup();
  dist_thresh *= dist_thresh;
  looking = false;
  flag_wait("all_players_connected");
  wait(RandomFloatRange(0.05, 0.1));
  while(1) {
    if(self animscripts\utility::IsInCombat() || !IsOkToLookAtEntity()) {
      self StopLookingAtEntity();
    }
    dot_check_passed = true;
    player = get_players()[0];
    if(isDefined(dot_check) && dot_check && !self entityInFront(player.origin)) {
      dot_check_passed = false;
    }
    player_dist = distanceSquared(self.origin, player.origin);
    if(((player_dist > dist_thresh) || (!dot_check_passed)) && looking) {
      self StopLookingAtEntity();
      looking = false;
    } else if((player_dist < dist_thresh) && !looking && dot_check_passed) {
      self SetLookAtEntity(player);
      looking = true;
    }
    wait(1.0);
  }
}