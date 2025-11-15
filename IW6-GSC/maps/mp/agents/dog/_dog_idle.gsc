/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\dog\_dog_idle.gsc
********************************************/

#include maps\mp\agents\_scriptedAgents;
#include common_scripts\utility;

main() {
  self.animSubstate = "none";

  self SetTimeOfNextSound();
  self.timeOfNextSound += 2000;

  self.bIdleHitReaction = false;

  self ScrAgentSetGoalPos(self.origin);

  self ScrAgentSetOrientMode("face angle abs", self.angles);
  self ScrAgentSetAnimMode("anim deltas");
  self ScrAgentSetPhysicsMode("gravity");

  self UpdateState();
}

end_script() {
  if(isDefined(self.prevTurnRate)) {
    self ScrAgentSetMaxTurnSpeed(self.prevTurnRate);
    self.prevTurnRate = undefined;
  }
}

UpdateState() {
  self endon("killanimscript");
  self endon("cancelidleloop");

  while(true) {
    prevState = self.animSubstate;
    nextState = self DetermineState();
    if(nextState != self.animSubstate)
      self EnterState(nextState);

    self UpdateAngle();

    switch (self.animSubstate) {
      case "idle_combat":
        wait(0.2);
        break;
      case "idle_noncombat":
        if(prevState == "none") {
          if(self.moveMode == "run" || self.moveMode == "sprint")
            self PlaySoundOnMovingEnt(ter_op(self.bIsWolf, "anml_wolf_pants_mp_fast", "anml_dog_pants_mp_fast"));
          else
            self PlaySoundOnMovingEnt(ter_op(self.bIsWolf, "anml_wolf_pants_mp_med", "anml_dog_pants_mp_med"));
        } else {
          if(GetTime() > self.timeOfNextSound) {
            if(RandomInt(10) < 4)
              self PlaySoundOnMovingEnt(ter_op(self.bIsWolf, "anml_wolf_whine", "anml_dog_whine"));
            else
              self PlaySoundOnMovingEnt(ter_op(self.bIsWolf, "anml_wolf_pants_mp_med", "anml_dog_pants_mp_med"));
            self SetTimeOfNextSound();
          }
        }
        wait(0.5);
        break;
      default:
        assertmsg("unknown dog stop state " + self.animSubstate);
        wait(1);
        break;
    }
  }
}

DetermineState() {
  if(ShouldAttackIdle())
    return "idle_combat";
  else
    return "idle_noncombat";
}

EnterState(state) {
  self ExitState(self.animSubstate);
  self.animSubstate = state;

  PlayIdleAnim();
}

ExitState(prevState) {
  if(isDefined(self.prevTurnRate)) {
    self ScrAgentSetMaxTurnSpeed(self.prevTurnRate);
    self.prevTurnRate = undefined;
  }
}

PlayIdleAnim() {
  if(self.animSubstate == "idle_combat")
    self SetAnimState("attack_idle");
  else
    self SetAnimState("casual_idle");
}

UpdateAngle() {
  faceTarget = undefined;
  if(isDefined(self.enemy) && DistanceSquared(self.enemy.origin, self.origin) < 1024 * 1024)
    faceTarget = self.enemy;
  else if(isDefined(self.owner) && DistanceSquared(self.owner.origin, self.origin) > 24 * 24)
    faceTarget = self.owner;

  if(isDefined(faceTarget)) {
    meToTarget = faceTarget.origin - self.origin;
    meToTargetAngles = VectorToAngles(meToTarget);

    if(abs(AngleClamp180(meToTargetAngles[1] - self.angles[1])) > 1)
      self TurnToAngle(meToTargetAngles[1]);
  }
}

ShouldAttackIdle() {
  return isDefined(self.enemy) &&
    maps\mp\_utility::IsReallyAlive(self.enemy) &&
    distanceSquared(self.origin, self.enemy.origin) < 1000000;
}

GetTurnAnimState(angleDiff) {
  if(self ShouldAttackIdle()) {
    if(angleDiff < -135 || angleDiff > 135)
      return "attack_turn_180";
    else if(angleDiff < 0)
      return "attack_turn_right_90";
    else
      return "attack_turn_left_90";
  } else {
    if(angleDiff < -135 || angleDiff > 135)
      return "casual_turn_180";
    else if(angleDiff < 0)
      return "casual_turn_right_90";
    else
      return "casual_turn_left_90";
  }
}

TurnToAngle(desiredAngle) {
  currentAngle = self.angles[1];
  angleDiff = AngleClamp180(desiredAngle - currentAngle);

  if(-0.5 < angleDiff && angleDiff < 0.5) {
    return;
  }
  if(-10 < angleDiff && angleDiff < 10) {
    RotateToAngle(desiredAngle, 2);
    return;
  }

  animState = GetTurnAnimState(angleDiff);

  turnAnim = self GetAnimEntry(animState, 0);

  animLength = GetAnimLength(turnAnim);
  animAngleDelta = GetAngleDelta3D(turnAnim);

  self ScrAgentSetAnimMode("anim angle delta");

  if(AnimHasNotetrack(turnAnim, "turn_begin") && AnimHasNotetrack(turnAnim, "turn_end")) {
    self PlayAnimNUntilNotetrack(animState, 0, "turn_in_place");

    beginTimes = GetNotetrackTimes(turnAnim, "turn_begin");
    endTimes = GetNotetrackTimes(turnAnim, "turn_end");
    turnTime = (endTimes[0] - beginTimes[0]) * animLength;

    turnAdjust = AngleClamp180(angleDiff - animAngleDelta[1]);

    turnSpeed = abs(turnAdjust) / turnTime / 20;
    turnSpeed = turnSpeed * 3.14159 / 180;

    angles = (0, AngleClamp180(self.angles[1] + turnAdjust), 0);

    self.prevTurnRate = self ScrAgentGetMaxTurnSpeed();

    self ScrAgentSetMaxTurnSpeed(turnSpeed);
    self ScrAgentSetOrientMode("face angle abs", angles);

    self WaitUntilNotetrack("turn_in_place", "turn_end");

    self ScrAgentSetMaxTurnSpeed(self.prevTurnRate);
    self.prevTurnRate = undefined;

    self WaitUntilNotetrack("turn_in_place", "end");
  } else {
    self.prevTurnRate = self ScrAgentGetMaxTurnSpeed();

    turnSpeed = abs(AngleClamp180(angleDiff - animAngleDelta[1])) / animLength / 20;
    turnSpeed = turnSpeed * 3.14159 / 180;
    self ScrAgentSetMaxTurnSpeed(turnSpeed);

    angles = (0, AngleClamp180(desiredAngle - animAngleDelta[1]), 0);
    self ScrAgentSetOrientMode("face angle abs", angles);

    self PlayAnimNUntilNotetrack(animState, 0, "turn_in_place");

    self ScrAgentSetMaxTurnSpeed(self.prevTurnRate);
    self.prevTurnRate = undefined;
  }

  self ScrAgentSetAnimMode("anim deltas");

  self PlayIdleAnim();
}

RotateToAngle(desiredAngle, tolerance) {
  if(abs(AngleClamp180(desiredAngle - self.angles[1])) <= tolerance) {
    return;
  }
  angles = (0, desiredAngle, 0);

  self ScrAgentSetOrientMode("face angle abs", angles);

  while(AngleClamp180(desiredAngle - self.angles[1]) > tolerance)
    wait(0.1);
}

SetTimeOfNextSound() {
  self.timeOfNextSound = GetTime() + 8000 + RandomInt(5000);
}

DoHitReaction(hitAngle) {
  self.bLockGoalPos = true;
  self.stateLocked = true;
  self.bIdleHitReaction = true;

  angleDiff = AngleClamp180(hitAngle - self.angles[1]);

  if(angleDiff > 0)
    animIndex = 1;
  else
    animIndex = 0;

  self notify("cancelidleloop");

  self ScrAgentSetAnimMode("anim deltas");
  self ScrAgentSetOrientMode("face angle abs", self.angles);

  self PlayAnimNUntilNotetrack("stand_pain", animIndex, "stand_pain");

  self.bLockGoalPos = false;
  self.stateLocked = false;
  self.bIdleHitReaction = false;

  self ScrAgentSetOrientMode("face angle abs", self.angles);

  self.animSubstate = "none";
  self thread UpdateState();
}

OnDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset) {
  if(self.bIdleHitReaction) {
    return;
  }
  hitDirToAngles = VectorToAngles(vDir);
  hitAngle = hitDirToAngles[1] - 180;

  self DoHitReaction(hitAngle);
}

OnFlashbanged(origin, percent_distance, percent_angle, attacker, teamName, extraDuration) {
  if(self.bIdleHitReaction) {
    return;
  }
  DoHitReaction(self.angles[1] + 180);
}