/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\dog\_dog_melee.gsc
*********************************************/

#include maps\mp\agents\_scriptedAgents;
#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  self endon("death");
  self endon("killanimscript");

  assert(isDefined(self.curMeleeTarget));

  self.curMeleeTarget endon("disconnect");

  meToTarget = self.curMeleeTarget.origin - self.origin;
  distMeToTarget = Length(meToTarget);

  bTestCanMove = true;
  if(distMeToTarget < self.attackOffset) {
    attackPos = self.origin;
    bTestCanMove = false;
  } else {
    meToTarget = meToTarget / distMeToTarget;
    attackPos = self.curMeleeTarget.origin - meToTarget * self.attackOffset;
  }

  bLerp = false;

  startPos = self.origin + (0, 0, 30);
  endPos = self.curMeleeTarget.origin + (0, 0, 30);
  hitPos = PhysicsTrace(startPos, endPos);
  if(DistanceSquared(hitPos, endPos) > 1) {
    self MeleeFailed();
    return;
  }

  if(bTestCanMove) {
    bCanMoveToAttackPos = self CanMovePointToPoint(self.origin, attackPos);
  } else {
    bCanMoveToAttackPos = true;
  }

  animEntry = undefined;
  if(!bCanMoveToAttackPos) {
    bShouldDoExtendedKill = false;
  } else {
    animEntry = self ShouldDoExtendedKill(self.curMeleeTarget);
    bShouldDoExtendedKill = isDefined(animEntry);
  }

  self.bLockGoalPos = true;

  if(bShouldDoExtendedKill) {
    assert(isDefined(animEntry));
    self DoExtendedKill(animEntry);
  } else {
    self DoStandardKill(attackPos, bCanMoveToAttackPos);
  }
}

end_script() {
  self ScrAgentSetAnimScale(1, 1);
  self.bLockGoalPos = false;
}

GetMeleeAnimState() {
  return "attack_run_and_jump";
}

ShouldDoExtendedKill(victim) {
  if(!self.enableExtendedKill) {
    return undefined;
  }

  cMaxHeightDiff = 4;

  if(!IsGameParticipant(victim)) {
    return undefined;
  }
  if(self IsProtectedByRiotshield(victim)) {
    return undefined;
  }
  if(victim IsJuggernaut()) {
    return undefined;
  }

  victimToMe = self.origin - victim.origin;
  if(abs(victimToMe[2]) > cMaxHeightDiff) {
    return undefined;
  }

  victimToMe2D = VectorNormalize((victimToMe[0], victimToMe[1], 0));
  victimFacing = anglesToForward(victim.angles);
  angleToMe = VectorDot(victimFacing, victimToMe2D);

  if(angleToMe > 0.707) {
    animEntry = 0;
    snappedVictimToMe = RotateVector((1, 0, 0), victim.angles);
  } else if(angleToMe < -0.707) {
    animEntry = 1;
    snappedVictimToMe = RotateVector((-1, 0, 0), victim.angles);
  } else {
    cross = maps\mp\agents\dog\_dog_think::cross2D(victimToMe, victimFacing);
    if(cross > 0) {
      animEntry = 3;
      snappedVictimToMe = RotateVector((0, -1, 0), victim.angles);
    } else {
      animEntry = 2;
      snappedVictimToMe = RotateVector((0, 1, 0), victim.angles);
    }
  }

  if(animEntry == 1) {
    cClearanceRequired = 128;
  } else {
    cClearanceRequired = 96;
  }
  landPos = victim.origin - cClearanceRequired * snappedVictimToMe;

  landPosDropped = self DropPosToGround(landPos);
  if(!isDefined(landPosDropped)) {
    return undefined;
  }

  if(abs(landPosDropped[2] - landPos[2]) > cMaxHeightDiff) {
    return undefined;
  }

  if(!self AIPhysicsTracePassed(victim.origin + (0, 0, 4), landPosDropped + (0, 0, 4), self.radius, self.height)) {
    return undefined;
  }

  return animEntry;
}

DoExtendedKill(animEntry) {
  meleeAnimState = "attack_extended";

  self DoMeleeDamage(self.curMeleeTarget, self.curMeleeTarget.health, "MOD_MELEE_DOG");

  attackAnim = self GetAnimEntry(meleeAnimState, animEntry);
  self thread ExtendedKill_StickToVictim(attackAnim, self.curMeleeTarget.origin, self.curMeleeTarget.angles);

  if(animEntry == 1) {
    self PlaySoundOnMovingEnt(ter_op(self.bIsWolf, "mp_wolf_attack_quick_back_npc", "mp_dog_attack_quick_back_npc"));
  } else {
    self PlaySoundOnMovingEnt(ter_op(self.bIsWolf, "mp_wolf_attack_short_npc", "mp_dog_attack_short_npc"));
  }

  self PlayAnimNUntilNotetrack(meleeAnimState, animEntry, "attack", "end");

  self notify("kill_stick");
  self.curMeleeTarget = undefined;

  self ScrAgentSetAnimMode("anim deltas");
  self Unlink();
}

ExtendedKill_StickToVictim(attackAnim, targetOrigin, targetAngles) {
  self endon("death");
  self endon("killanimscript");
  self endon("kill_stick");

  wait(0.05);
  assert(isDefined(self.curMeleeTarget));

  if(IsAlive(self.curMeleeTarget)) {
    return;
  }
  corpse = self.curMeleeTarget GetCorpseEntity();
  assert(isDefined(corpse));
  self LinkTo(corpse);

  self ScrAgentDoAnimRelative(attackAnim, targetOrigin, targetAngles);
}

DoStandardKill(attackPos, bCanMoveToAttackPos) {
  meleeAnimState = self GetMeleeAnimState();

  bLerp = false;

  if(!bCanMoveToAttackPos) {
    if(self AgentCanSeeSentient(self.curMeleeTarget)) {
      groundPos = self DropPosToGround(self.curMeleeTarget.origin);
      if(isDefined(groundPos)) {
        bLerp = true;
        attackPos = groundPos;
      } else {
        self MeleeFailed();
        return;
      }
    } else {
      self MeleeFailed();
      return;
    }
  }

  self.lastMeleeFailedMyPos = undefined;
  self.lastMeleeFailedPos = undefined;

  attackAnim = self GetAnimEntry(meleeAnimState, 0);
  animLength = GetAnimLength(attackAnim);
  meleeNotetracks = GetNotetrackTimes(attackAnim, "dog_melee");
  if(meleeNotetracks.size > 0) {
    lerpTime = meleeNotetracks[0] * animLength;
  } else {
    lerpTime = animLength;
  }

  self ScrAgentDoAnimLerp(self.origin, attackPos, lerpTime);

  self thread UpdateLerpPos(self.curMeleeTarget, lerpTime, bCanMoveToAttackPos);

  self PlayAnimNUntilNotetrack(meleeAnimState, 0, "attack", "dog_melee");

  self notify("cancel_updatelerppos");

  damageDealt = 0;
  if(isDefined(self.curMeleeTarget)) {
    damageDealt = self.curMeleeTarget.health;
  }
  if(isDefined(self.meleeDamage)) {
    damageDealt = self.meleeDamage;
  }

  if(isDefined(self.curMeleeTarget)) {
    self DoMeleeDamage(self.curMeleeTarget, damageDealt, "MOD_IMPACT");
  }

  self.curMeleeTarget = undefined;

  if(bLerp) {
    self ScrAgentSetAnimScale(0, 1);
  } else {
    self ScrAgentSetAnimScale(1, 1);
  }

  self ScrAgentSetPhysicsMode("gravity");
  self ScrAgentSetAnimMode("anim deltas");

  self WaitUntilNotetrack("attack", "end");
}

UpdateLerpPos(enemy, lerpTime, bCanMoveToAttackPos) {
  self endon("killanimscript");
  self endon("death");
  self endon("cancel_updatelerppos");
  enemy endon("disconnect");
  enemy endon("death");

  timeRemaining = lerpTime;
  interval = 0.05;
  while(true) {
    wait(interval);
    timeRemaining -= interval;

    if(timeRemaining <= 0) {
      break;
    }

    attackPos = GetUpdatedAttackPos(enemy, bCanMoveToAttackPos);
    if(!isDefined(attackPos)) {
      break;
    }

    self ScrAgentDoAnimLerp(self.origin, attackPos, timeRemaining);
  }
}

GetUpdatedAttackPos(enemy, bCanMove) {
  if(!bCanMove) {
    droppedPos = self DropPosToGround(enemy.origin);
    return droppedPos;
  } else {
    meToTarget = enemy.origin - self.origin;
    distMeToTarget = Length(meToTarget);

    if(distMeToTarget < self.attackOffset) {
      return self.origin;
    } else {
      meToTarget = meToTarget / distMeToTarget;
      attackPos = enemy.origin - meToTarget * self.attackOffset;
      if(self CanMovePointToPoint(self.origin, attackPos)) {
        return attackPos;
      } else {
        return undefined;
      }
    }
  }
}

IsProtectedByRiotshield(enemy) {
  if(isDefined(enemy.hasRiotShield) && enemy.hasRiotShield) {
    enemyToMe = self.origin - enemy.origin;
    meToEnemy = VectorNormalize((enemyToMe[0], enemyToMe[1], 0));

    enemyFacing = anglesToForward(enemy.angles);
    angleToMe = VectorDot(enemyFacing, enemyToMe);

    if(enemy.hasRiotShieldEquipped) {
      if(angleToMe > 0.766) {
        return true;
      }
    } else {
      if(angleToMe < -0.766) {
        return true;
      }
    }
  }

  return false;
}

DoMeleeDamage(enemy, damage, meansOfDeath) {
  if(self IsProtectedByRiotshield(enemy)) {
    return;
  }
  enemy DoDamage(damage, self.origin, self, self, meansOfDeath);
}

MeleeFailed() {
  self.lastMeleeFailedMyPos = self.origin;
  self.lastMeleeFailedPos = self.curMeleeTarget.origin;
}