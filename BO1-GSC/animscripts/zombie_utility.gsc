/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\zombie_utility.gsc
******************************************/

#include animscripts\zombie_SetPoseMovement;
#include animscripts\combat_utility;
#include animscripts\debug;
#include common_scripts\utility;
#include maps\_utility;
#using_animtree("generic_human");
initAnimTree(animscript) {
  if(isValidEnemy(self.a.personImMeleeing)) {
    ImNotMeleeing(self.a.personImMeleeing);
  }
  self ClearAnim( % body, 0.2);
  if(animscript != "pain" && animscript != "death") {
    self.a.special = "none";
  }
  self.missedSightChecks = 0;
  IsInCombat();
  assertEX(isDefined(animscript), "Animscript not specified in initAnimTree");
  self.a.script = animscript;
  [[self.a.StopCowering]]();
}

UpdateAnimPose() {
  assertEX(self.a.movement == "stop" || self.a.movement == "walk" || self.a.movement == "run", "UpdateAnimPose " + self.a.pose + " " + self.a.movement);
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
    [
      [scriptFunc]
    ](animscript);
  }
  if(animscript != "death") {
    self.a.nodeath = false;
  }
  if(isDefined(self.isHoldingGrenade) && (animscript == "pain" || animscript == "death" || animscript == "flashed")) {
    self dropGrenade();
  }
  self.isHoldingGrenade = undefined;
  self.coverNode = undefined;
  self.changingCoverPos = false;
  self.a.scriptStartTime = GetTime();
  self.a.atConcealmentNode = false;
  if(isDefined(self.node) && (self.node.type == "Conceal Crouch" || self.node.type == "Conceal Stand")) {
    self.a.atConcealmentNode = true;
  }
  initAnimTree(animscript);
  UpdateAnimPose();
}

should_find_a_new_node() {
  self.a.next_move_to_new_cover--;
  if(self.a.next_move_to_new_cover > 0) {
    return false;
  }
  anim_set_next_move_to_new_cover();
  return true;
}

badplacer(time, org, radius) {
  for(i = 0; i < time * 20; i++) {
    for(p = 0; p < 10; p++) {
      angles = (0, randomInt(360), 0);
      forward = AnglesToForward(angles);
      scale = vector_scale(forward, radius);
      line(org, org + scale, (1, 0.3, 0.3));
    }
    wait(0.05);
  }
}

printDisplaceInfo() {
  self endon("death");
  self notify("displaceprint");
  self endon("displaceprint");
  for(;;) {
    Print3d(self.origin + (0, 0, 60), "displacer", (0, 0.4, 0.7), 0.85, 0.5);
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

IsInCombat() {
  if(isValidEnemy(self.enemy)) {
    self.a.combatEndTime = GetTime() + anim.combatMemoryTimeConst + randomInt(anim.combatMemoryTimeRand);
    return true;
  }
  return (self.a.combatEndTime > GetTime());
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
      forward = AnglesToForward(self.node.angles);
    } else {
      forward = AnglesToForward(self.angles);
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
    forward = AnglesToForward(self.coverNode.angles + self.animarray["angle_step_out"][self.a.cornerMode]);
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
    forward = AnglesToForward(self.angles);
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
      } else {
        println("No stance allowed!Remaining crouched.");
        resultPose = "crouch";
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
    return AnglesToForward(myNode.angles);
  }
  return AnglesToForward(self.angles);
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
  useLeans = GetDvarInt(#"ai_useLeanRunAnimations");
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

IsInSet(input, set) {
  for(i = set.size - 1; i >= 0; i--) {
    if(input == set[i]) {
      return true;
    }
  }
  return false;
}

playAnim(animation) {
  if(isDefined(animation)) {
    println("NOW PLAYING: ", animation);
    self SetFlaggedAnimKnobAllRestart("playAnim", animation, % root, 1, .2, 1);
    timeToWait = getanimlength(animation);
    timeToWait = (3 * timeToWait) + 1;
    self thread NotifyAfterTime("time is up", "time is up", timeToWait);
    self waittill("time is up");
    self notify("enddrawstring");
  }
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

showLastEnemySightPos(string) {
  self notify("got known enemy2");
  self endon("got known enemy2");
  self endon("death");
  if(!isValidEnemy(self.enemy)) {
    return;
  }
  if(self.enemy.team == "allies") {
    color = (0.4, 0.7, 1);
  } else {
    color = (1, 0.7, 0.4);
  }
  while(1) {
    wait(0.05);
    if(!isDefined(self.lastEnemySightPos)) {
      continue;
    }
    Print3d(self.lastEnemySightPos, string, color, 1, 2.15);
  }
}

tryTurret(targetname) {
  turret = getEnt(targetname, "targetname");
  if(!isDefined(turret)) {
    return false;
  }
  if((turret.classname != "misc_mg42") && (turret.classname != "misc_turret")) {
    return false;
  }
  if(!self IsInGoal(self.covernode.origin)) {
    return false;
  }
  canuse = self useturret(turret);
  if(canuse) {
    turret setmode("auto_ai");
    self thread maps\_mgturret::mg42_firing(turret);
    turret notify("startfiring");
    return true;
  } else {
    return false;
  }
}

debugTimeout() {
  wait(5);
  self notify("timeout");
}

debugPosInternal(org, string, size) {
  self endon("death");
  self notify("stop debug " + org);
  self endon("stop debug " + org);
  ent = SpawnStruct();
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

setEnv(env) {
  anim.idleAnimTransition["stand"]["in"] = % casual_stand_idle_trans_in;
  anim.idleAnimArray["stand"][0][0] = % casual_stand_idle;
  anim.idleAnimArray["stand"][0][1] = % casual_stand_idle_twitch;
  anim.idleAnimArray["stand"][0][2] = % casual_stand_idle_twitchB;
  anim.idleAnimWeights["stand"][0][0] = 2;
  anim.idleAnimWeights["stand"][0][1] = 1;
  anim.idleAnimWeights["stand"][0][2] = 1;
  anim.idleAnimArray["stand"][1][0] = % casual_stand_v2_idle;
  anim.idleAnimArray["stand"][1][1] = % casual_stand_v2_twitch_radio;
  anim.idleAnimArray["stand"][1][2] = % casual_stand_v2_twitch_shift;
  anim.idleAnimArray["stand"][1][3] = % casual_stand_v2_twitch_talk;
  anim.idleAnimWeights["stand"][1][0] = 10;
  anim.idleAnimWeights["stand"][1][1] = 4;
  anim.idleAnimWeights["stand"][1][2] = 7;
  anim.idleAnimWeights["stand"][1][3] = 4;
  anim.idleAnimArray["stand_cqb"][0][0] = % cqb_stand_idle;
  anim.idleAnimArray["stand_cqb"][0][1] = % cqb_stand_twitch;
  anim.idleAnimWeights["stand_cqb"][0][0] = 2;
  anim.idleAnimWeights["stand_cqb"][0][1] = 1;
  anim.idleAnimTransition["crouch"]["in"] = % casual_crouch_idle_in;
  anim.idleAnimArray["crouch"][0][0] = % casual_crouch_idle;
  anim.idleAnimArray["crouch"][0][1] = % casual_crouch_twitch;
  anim.idleAnimArray["crouch"][0][2] = % casual_crouch_point;
  anim.idleAnimWeights["crouch"][0][0] = 6;
  anim.idleAnimWeights["crouch"][0][1] = 3;
  anim.idleAnimWeights["crouch"][0][2] = 1;
  anim.idleAnimArray["stand_banzai"][0][0] = % cqb_stand_idle;
  anim.idleAnimArray["stand_banzai"][0][1] = % cqb_stand_twitch;
  anim.idleAnimWeights["stand_banzai"][0][0] = 2;
  anim.idleAnimWeights["stand_banzai"][0][1] = 1;
  anim.idleAnimTransition["stand_hmg"]["in"] = % ai_mg_shoulder_run2stand;
  anim.idleAnimArray["stand_hmg"][0][0] = % ai_mg_shoulder_stand_idle;
  anim.idleAnimWeights["stand_hmg"][0][0] = 1;
  anim.idleAnimTransition["crouch_hmg"]["in"] = % ai_mg_shoulder_run2crouch;
  anim.idleAnimArray["crouch_hmg"][0][0] = % ai_mg_shoulder_crouch_idle;
  anim.idleAnimWeights["crouch_hmg"][0][0] = 1;
  anim.idleAnimArray["stand_flame"][0][0] = % ai_flamethrower_stand_idle_casual_v1;
  anim.idleAnimArray["stand_flame"][0][1] = % ai_flamethrower_stand_twitch;
  anim.idleAnimWeights["stand_flame"][0][0] = 3;
  anim.idleAnimWeights["stand_flame"][0][1] = 1;
  anim.idleAnimArray["crouch_flame"][0][0] = % ai_flamethrower_crouch_idle_a;
  anim.idleAnimArray["crouch_flame"][0][1] = % ai_flamethrower_crouch_idle_b;
  anim.idleAnimArray["crouch_flame"][0][2] = % ai_flamethrower_crouch_twitch;
  anim.idleAnimWeights["crouch_flame"][0][0] = 3;
  anim.idleAnimWeights["crouch_flame"][0][1] = 3;
  anim.idleAnimWeights["crouch_flame"][0][2] = 1;
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
      playfxOnTag(level._effect["cold_breath"], self, tag);
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
  forward = AnglesToForward(node.angles);
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

checkPitchVisibility(fromPoint, toPoint, atNode) {
  pitch = AngleClamp180(VectorToAngles(toPoint - fromPoint)[0]);
  if(abs(pitch) > 45) {
    if(isDefined(atNode) && atNode.type != "Cover Crouch" && atNode.type != "Conceal Crouch") {
      return false;
    }
    if(pitch > 45 || pitch < anim.coverCrouchLeanPitch - 45) {
      return false;
    }
  }
  return true;
}

showLines(start, end, end2) {
  for(;;) {
    line(start, end, (1, 0, 0), 1);
    wait(0.05);
    line(start, end2, (0, 0, 1), 1);
    wait(0.05);
  }
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

notForcedCover() {
  return ((self.a.forced_cover == "none") || (self.a.forced_cover == "Show"));
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

print3drise(org, msg, color, alpha, scale) {
  newtime = 5 / 0.05;
  up = 0;
  org = org + randomvector(30);
  for(i = 0; i < newtime; i++) {
    up += 0.5;
    Print3d(org + (0, 0, up), msg, color, alpha, scale);
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

delayedScriptChange() {
  wait(0.05);
  scriptChange();
}

getGrenadeModel() {
  return getWeaponModel(self.grenadeweapon);
}

sawEnemyMove(timer) {
  if(!isDefined(timer)) {
    timer = 500;
  }
  return (GetTime() - self.personalSightTime < timer);
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

random_weight(array) {
  idleanim = randomInt(array.size);
  if(array.size > 1) {
    anim_weight = 0;
    for(i = 0; i < array.size; i++) {
      anim_weight += array[i];
    }
    anim_play = RandomFloat(anim_weight);
    anim_weight = 0;
    for(i = 0; i < array.size; i++) {
      anim_weight += array[i];
      if(anim_play < anim_weight) {
        idleanim = i;
        break;
      }
    }
  }
  return idleanim;
}

removeableHat() {
  if(!isDefined(self.hatmodel)) {
    return false;
  }
  if(isDefined(anim.noHatClassname[self.classname])) {
    return false;
  }
  return (!isDefined(anim.noHat[self.model]));
}

metalHat() {
  if(!isDefined(self.hatmodel)) {
    return false;
  }
  return (isDefined(anim.metalHat[self.model]));
}

fatGuy() {
  return (isDefined(anim.fatGuy[self.model]));
}

setFootstepEffect(name, fx) {
  assertEx(isDefined(name), "Need to define the footstep surface type.");
  assertEx(isDefined(fx), "Need to define the mud footstep effect.");
  if(!isDefined(anim.optionalStepEffects)) {
    anim.optionalStepEffects = [];
  }
  anim.optionalStepEffects[anim.optionalStepEffects.size] = name;
  level._effect["step_" + name] = fx;
  anim.optionalStepEffectFunction = animscripts\zombie_shared::playFootStepEffect;
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

isNodeDontStand() {
  return (self.spawnflags & 4) == 4;
}

isNodeDontCrouch() {
  return (self.spawnflags & 8) == 8;
}

doesNodeAllowStance(stance) {
  if(stance == "stand") {
    return !self isNodeDontStand();
  } else {
    Assert(stance == "crouch");
    return !self isNodeDontCrouch();
  }
}

animArray(animname) {
  assert(isDefined(self.a.array));
  return self.a.array[animname];
}

animArrayAnyExist(animname) {
  assert(isDefined(self.a.array));
  return self.a.array[animname].size > 0;
}

animArrayPickRandom(animname) {
  assert(isDefined(self.a.array));
  assert(self.a.array[animname].size > 0);
  if(self.a.array[animname].size > 1) {
    index = randomInt(self.a.array[animname].size);
  } else {
    index = 0;
  }
  return self.a.array[animname][index];
}

getAnimEndPos(theanim) {
  moveDelta = getMoveDelta(theanim, 0, 1);
  return self localToWorldCoords(moveDelta);
}

isValidEnemy(enemy) {
  if(!isDefined(enemy)) {
    return false;
  }
  return true;
}

damageLocationIsAny(a, b, c, d, e, f, g, h, i, j, k, ovr) {
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
  assert(!isDefined(ovr));
  return false;
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
  return isDefined(self.cqbwalking) && self.cqbwalking;
}

squared(value) {
  return value * value;
}

randomizeIdleSet() {
  self.a.idleSet = randomInt(2);
}

getRandomIntFromSeed(intSeed, intMax) {
  assert(intMax > 0);
  index = intSeed % anim.randomIntTableSize;
  return anim.randomIntTable[index] % intMax;
}

is_banzai() {
  return isDefined(self.banzai) && self.banzai;
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

debug_anim_print(text) {}
debug_turn_print(text, line) {}