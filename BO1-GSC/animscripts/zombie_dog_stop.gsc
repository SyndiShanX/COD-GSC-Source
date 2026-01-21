/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\zombie_dog_stop.gsc
*******************************************/

#include animscripts\zombie_utility;
#include animscripts\weaponList;
#include common_scripts\utility;
#include animscripts\Combat_Utility;
#include maps\_utility;
#using_animtree("zombie_dog");
main() {
  self endon("killanimscript");
  self ClearAnim(%root, 0.2);
  self ClearAnim(anim.dogAnims[self.animSet].idle, 0.2);
  self ClearAnim(anim.dogAnims[self.animSet].attack["attackidle_knob"], 0.2);
  self thread lookAtTarget("attackIdle");
  while(1) {
    if(shouldAttackIdle()) {
      self ClearAnim(anim.dogAnims[self.animSet].idle, 0.2);
      self randomAttackIdle();
    } else {
      self OrientMode("face current");
      self ClearAnim(anim.dogAnims[self.animSet].attack["attackidle_knob"], 0.2);
      self SetFlaggedAnimRestart("dog_idle", anim.dogAnims[self.animSet].idle, 1, 0.2, self.animplaybackrate);
    }
    animscripts\zombie_shared::DoNoteTracks("dog_idle", ::dogIdleNotetracks);
  }
}

dogIdleNotetracks(note) {
  if(note == "breathe_fire") {
    if(isDefined(level._effect["dog_breath"])) {
      self.breath_fx = spawn("script_model", self GetTagOrigin("TAG_MOUTH_FX"));
      self.breath_fx.angles = self GetTagAngles("TAG_MOUTH_FX");
      self.breath_fx setModel("tag_origin");
      self.breath_fx LinkTo(self, "TAG_MOUTH_FX");
      playFXOnTag(level._effect["dog_breath"], self.breath_fx, "tag_origin");
    }
  }
}

isFacingEnemy(toleranceCosAngle) {
  assert(isDefined(self.enemy));
  vecToEnemy = self.enemy.origin - self.origin;
  distToEnemy = length(vecToEnemy);
  if(distToEnemy < 1) {
    return true;
  }
  forward = anglesToForward(self.angles);
  return ((forward[0] * vecToEnemy[0]) + (forward[1] * vecToEnemy[1])) / distToEnemy > toleranceCosAngle;
}

randomAttackIdle() {
  if(isFacingEnemy(-0.5)) {
    self OrientMode("face current");
  } else {
    self OrientMode("face enemy");
  }
  self ClearAnim(anim.dogAnims[self.animSet].attack["attackidle_knob"], 0.1);
  if(isDefined(self.enemy) && IsPlayer(self.enemy) && IsAlive(self.enemy)) {
    range = GetDvarFloat("ai_meleeRange");
    distance_ok = distanceSquared(self.origin, self.enemy.origin) < (range * range);
    if(distance_ok == true) {
      self notify("dog_combat");
      self animscripts\zombie_dog_combat::meleeBiteAttackPlayer(self.enemy);
      return;
    }
  }
  if(should_growl()) {
    self SetFlaggedAnimRestart("dog_idle", anim.dogAnims[self.animSet].combatIdle["attackidle_growl"], 1, 0.2, 1);
    return;
  }
  idleChance = 33;
  barkChance = 66;
  if(isDefined(self.mode)) {
    if(self.mode == "growl") {
      idleChance = 15;
      barkChance = 30;
    } else if(self.mode == "bark") {
      idleChance = 15;
      barkChance = 85;
    }
  }
  rand = randomInt(100);
  if(rand < idleChance) {
    self SetFlaggedAnimRestart("dog_idle", anim.dogAnims[self.animSet].combatIdle["attackidle_growl"], 1, 0.2, self.animplaybackrate);
  } else if(rand < barkChance) {
    self SetFlaggedAnimRestart("dog_idle", anim.dogAnims[self.animSet].combatIdle["attackidle_bark"], 1, 0.2, self.animplaybackrate);
  } else {
    self SetFlaggedAnimRestart("dog_idle", anim.dogAnims[self.animSet].combatIdle["attackidle_growl"], 1, 0.2, self.animplaybackrate);
  }
}

shouldAttackIdle() {
  return (isDefined(self.enemy) && IsAlive(self.enemy) && distanceSquared(self.origin, self.enemy.origin) < 1000000);
}

should_growl() {
  if(isDefined(self.script_growl)) {
    return true;
  }
  if(!IsAlive(self.enemy)) {
    return true;
  }
  return !(self cansee(self.enemy));
}

lookAtTarget(lookPoseSet) {
  self endon("killanimscript");
  self endon("stop tracking");
  self ClearAnim(anim.dogAnims[self.animSet].lookKnob[2], 0);
  self ClearAnim(anim.dogAnims[self.animSet].lookKnob[4], 0);
  self ClearAnim(anim.dogAnims[self.animSet].lookKnob[6], 0);
  self ClearAnim(anim.dogAnims[self.animSet].lookKnob[8], 0);
  self.rightLookLimit = 90;
  self.leftLookLimit = -90;
  self.upLookLimit = 45;
  self.downLookLimit = -45;
  self SetAnimLimited(anim.dogAnims[self.animSet].look[lookPoseSet][2], 1, 0);
  self SetAnimLimited(anim.dogAnims[self.animSet].look[lookPoseSet][4], 1, 0);
  self SetAnimLimited(anim.dogAnims[self.animSet].look[lookPoseSet][6], 1, 0);
  self SetAnimLimited(anim.dogAnims[self.animSet].look[lookPoseSet][8], 1, 0);
  self setAnimLookWeight(1, 0.2);
  self trackLoop(anim.dogAnims[self.animSet].lookKnob[2], anim.dogAnims[self.animSet].lookKnob[4], anim.dogAnims[self.animSet].lookKnob[6], anim.dogAnims[self.animSet].lookKnob[8]);
}

trackLoop(look2, look4, look6, look8) {
  players = GetPlayers();
  deltaChangePerFrame = 5;
  lookBlendTime = .05;
  prevYawDelta = 0;
  prevPitchDelta = 0;
  maxYawDeltaChange = 5;
  maxPitchDeltaChange = 5;
  pitchAdd = 0;
  yawAdd = 0;
  doMaxAngleCheck = false;
  self.lookEnt = self.enemy;
  yawDelta = 0;
  pitchDelta = 0;
  firstFrame = true;
  for(;;) {
    rightLookLimit = self.rightLookLimit;
    leftLookLimit = self.leftLookLimit;
    upLookLimit = self.upLookLimit;
    downLookLimit = self.downLookLimit;
    if(prevYawDelta > rightLookLimit) {
      prevYawDelta = rightLookLimit;
    } else if(prevYawDelta < leftLookLimit) {
      prevYawDelta = leftLookLimit;
    }
    if(prevPitchDelta > upLookLimit) {
      prevPitchDelta = upLookLimit;
    } else if(prevPitchDelta < downLookLimit) {
      prevPitchDelta = downLookLimit;
    }
    incrAnimLookWeight();
    selfLookAtPos = (self.origin[0], self.origin[1], self geteyeapprox()[2]);
    lookPos = self.lookPos;
    if(isDefined(self.lookEnt)) {
      lookPos = self.lookEnt GetLookAtPos();
    }
    if(!isDefined(lookPos)) {
      assert(!isDefined(self.lookEnt));
      if(isDefined(self.node) && self.node.type == "Guard" && distanceSquared(self.origin, self.node.origin) < 16) {
        yawDelta = AngleClamp180(self.angles[1] - self.node.angles[1]);
        pitchDelta = 0;
      } else {
        likelyEnemyDir = self getAnglesToLikelyEnemyPath();
        if(isDefined(likelyEnemyDir)) {
          yawDelta = AngleClamp180(self.angles[1] - likelyEnemyDir[1]);
          pitchDelta = AngleClamp180(360 - likelyEnemyDir[0]);
        } else {
          yawDelta = 0;
          pitchDelta = 0;
        }
      }
    } else {
      vectorToLookPos = lookPos - selfLookAtPos;
      anglesToLookPos = VectorToAngles(vectorToLookPos);
      pitchDelta = 360 - anglesToLookPos[0];
      pitchDelta = AngleClamp180(pitchDelta + pitchAdd);
      yawDelta = self.angles[1] - anglesToLookPos[1];
      yawDelta = AngleClamp180(yawDelta + yawAdd);
    }
    if(doMaxAngleCheck && (abs(yawDelta) > 60 || abs(pitchDelta) > 60)) {
      yawDelta = 0;
      pitchDelta = 0;
    } else {
      if(yawDelta > rightLookLimit) {
        yawDelta = rightLookLimit;
      } else if(yawDelta < leftLookLimit) {
        yawDelta = leftLookLimit;
      }
      if(pitchDelta > upLookLimit) {
        pitchDelta = upLookLimit;
      } else if(pitchDelta < downLookLimit) {
        pitchDelta = downLookLimit;
      }
    }
    if(firstFrame) {
      firstFrame = false;
    } else {
      yawDeltaChange = yawDelta - prevYawDelta;
      if(abs(yawDeltaChange) > maxYawDeltaChange)
        yawDelta = prevYawDelta + maxYawDeltaChange * sign(yawDeltaChange);
      pitchDeltaChange = pitchDelta - prevPitchDelta;
      if(abs(pitchDeltaChange) > maxPitchDeltaChange)
        pitchDelta = prevPitchDelta + maxPitchDeltaChange * sign(pitchDeltaChange);
    }
    prevYawDelta = yawDelta;
    prevPitchDelta = pitchDelta;
    if(yawDelta > 0) {
      assert(yawDelta <= rightLookLimit);
      weight = yawDelta / rightLookLimit * self.a.lookweight;
      self SetAnimLimited(look4, 0, lookBlendTime);
      self SetAnimLimited(look6, weight, lookBlendTime);
    } else if(yawDelta < 0) {
      assert(yawDelta >= leftLookLimit);
      weight = yawDelta / leftLookLimit * self.a.lookweight;
      self SetAnimLimited(look6, 0, lookBlendTime);
      self SetAnimLimited(look4, weight, lookBlendTime);
    }
    if(pitchDelta > 0) {
      assert(pitchDelta <= upLookLimit);
      weight = pitchDelta / upLookLimit * self.a.lookweight;
      self SetAnimLimited(look2, 0, lookBlendTime);
      self SetAnimLimited(look8, weight, lookBlendTime);
    } else if(pitchDelta < 0) {
      assert(pitchDelta >= downLookLimit);
      weight = pitchDelta / downLookLimit * self.a.lookweight;
      self SetAnimLimited(look8, 0, lookBlendTime);
      self SetAnimLimited(look2, weight, lookBlendTime);
    }
    if(players.size == 1) {
      wait(0.2);
    } else {
      wait(1);
    }
  }
}

setAnimLookWeight(goalweight, goaltime) {
  if(!isDefined(goaltime) || goaltime <= 0) {
    self.a.lookweight = goalweight;
    self.a.lookweight_start = goalweight;
    self.a.lookweight_end = goalweight;
    self.a.lookweight_transframes = 0;
  } else {
    self.a.lookweight = goalweight;
    self.a.lookweight_start = self.a.lookweight;
    self.a.lookweight_end = goalweight;
    self.a.lookweight_transframes = int(goaltime * 20);
  }
  self.a.lookweight_t = 0;
}

incrAnimLookWeight() {
  if(self.a.lookweight_t < self.a.lookweight_transframes) {
    self.a.lookweight_t++;
    t = 1.0 * self.a.lookweight_t / self.a.lookweight_transframes;
    self.a.lookweight = self.a.lookweight_start * (1 - t) + self.a.lookweight_end * t;
  }
}

getPitchToLookEntOrPos() {
  pitch = getPitchToLookEntOrPos();
  if(self.a.script == "cover_crouch" && isDefined(self.a.coverMode) && self.a.coverMode == "lean") {
    pitch -= anim.coverCrouchLeanPitch;
  }
  return pitch;
}

getLookYawToPoint(point) {
  yaw = GetYawToSpot(point);
  dist = distance(self.origin, point);
  if(dist > 3) {
    angleFudge = asin(-3 / dist);
    yaw += angleFudge;
  }
  yaw = AngleClamp180(yaw);
  return yaw;
}

GetLookAtPos() {
  return self GetShootAtPos();
}