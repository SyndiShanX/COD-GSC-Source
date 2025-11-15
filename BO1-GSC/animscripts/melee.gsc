/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\melee.gsc
**************************************/

#include maps\_utility;
#include animscripts\Utility;
#include animscripts\SetPoseMovement;
#include animscripts\Combat_Utility;
#include animscripts\Debug;
#include animscripts\anims;
#include common_scripts\Utility;
#using_animtree("generic_human");
MeleeCombat() {
  self endon("killanimscript");
  self melee_notify_wrapper();
  assert(CanMeleeAnyRange());
  if(isDefined(level.allow_ai_vs_ai_melee)) {
    doingAIMelee = (isAI(self.enemy) && self.enemy.type == "human");
  } else {
    doingAIMelee = false;
  }
  if(doingAiMelee) {
    assert(animscripts\utility::okToMelee(self.enemy));
    animscripts\utility::IAmMeleeing(self.enemy);
    AiVsAiMeleeCombat();
    animscripts\utility::ImNotMeleeing(self.enemy);
    scriptChange();
    return;
  }
  realMelee = true;
  if(animscripts\utility::okToMelee(self.enemy)) {
    animscripts\utility::IAmMeleeing(self.enemy);
  } else {
    realMelee = false;
  }
  self thread EyesAtEnemy();
  self OrientMode("face enemy");
  meleeDebugPrint("Melee begin");
  self AnimMode("zonly_physics");
  resetGiveUpTime();
  first_time = true;
  for(;;) {
    if(!PrepareToMelee(first_time)) {
      self.lastMeleeGiveUpTime = GetTime();
      break;
    }
    first_time = false;
    assert(self.a.pose == "stand");
    meleeDebugPrint("Melee main loop" + randomInt(100));
    if(!realMelee && animscripts\utility::okToMelee(self.enemy)) {
      realMelee = true;
      animscripts\utility::IAmMeleeing(self.enemy);
    }
    self thread EyesAtEnemy();
    self OrientMode("face current");
    if(self maps\_bayonet::has_bayonet() && randomInt(100) < 0) {
      self SetFlaggedAnimKnobAllRestart("meleeanim", animArray("bayonet"), % body, 1, .2, 1);
    } else {
      self SetFlaggedAnimKnobAllRestart("meleeanim", animArray("melee"), % body, 1, .2, 1);
    }
    while(1) {
      self waittill("meleeanim", note);
      if(note == "end") {
        break;
      } else if(note == "fire") {
        if(!isDefined(self.enemy)) {
          break;
        }
        oldhealth = self.enemy.health;
        self melee();
        if(self.enemy.health < oldhealth) {
          resetGiveUpTime();
        }
      } else if(note == "stop") {
        if(!CanContinueToMelee()) {
          break;
        }
      }
    }
    self OrientMode("face default");
  }
  if(realMelee) {
    animscripts\utility::ImNotMeleeing(self.enemy);
  }
  self AnimMode("none");
  self thread backToCombat();
}

backToCombat() {
  self notify("killanimscript");
  waittillframeend;
  self thread animscripts\combat::main();
  self notify("stop EyesAtEnemy");
  self notify("stop_melee_debug_print");
  scriptChange();
}

resetGiveUpTime() {
  if(distanceSquared(self.origin, self.enemy.origin) > anim.chargeRangeSq) {
    self.giveUpOnMeleeTime = GetTime() + randomintrange(2700, 3300);
  } else {
    self.giveUpOnMeleeTime = GetTime() + randomintrange(1700, 2300);
  }
}

meleeDebugPrint(text) {
  return;
  self.meleedebugprint = text;
  self thread meleeDebugPrintThreadWrapper();
}

meleeDebugPrintThreadWrapper() {
  if(!isDefined(self.meleedebugthread)) {
    self.meleedebugthread = true;
    self meleeDebugPrintThread();
    self.meleedebugthread = undefined;
  }
}

meleeDebugPrintThread() {
  self endon("death");
  self endon("killanimscript");
  self endon("stop_melee_debug_print");
  while(1) {
    Print3d(self.origin + (0, 0, 60), self.meleedebugprint, (1, 1, 1), 1, .1);
    wait .05;
  }
}

debug_melee_on_actor() {
  return false;
}

debug_melee(msg) {}
debug_melee_line(start, end, color, duration) {}
getEnemyPose() {
  if(IsPlayer(self.enemy)) {
    return self.enemy getStance();
  } else {
    return self.enemy.a.pose;
  }
}

CanContinueToMelee() {
  return CanMeleeInternal("already started");
}

CanMeleeAnyRange() {
  return CanMeleeInternal("any range");
}

CanMeleeDesperate() {
  return CanMeleeInternal("long range");
}

CanMelee() {
  return CanMeleeInternal("normal");
}

CanMeleeInternal(state) {
  if(!IsSentient(self.enemy)) {
    debug_melee("Not doing melee - Does not have a valid target.");
    return false;
  }
  if(!IsAlive(self.enemy)) {
    return false;
  }
  if(isDefined(self.disableMelee)) {
    assert(self.disableMelee);
    debug_melee("Not doing melee - Melee is disabled, self.disableMelee is set to true.");
    return false;
  }
  if(self.a.pose != "stand") {
    debug_melee("Not doing melee - Cant melee in " + self.a.pose);
    return false;
  }
  enemypose = getEnemyPose();
  if(!IsPlayer(self.enemy) && enemypose != "stand" && enemypose != "crouch") {
    if(!(self is_banzai() && enemypose == "prone")) {
      debug_melee("Not doing melee - Enemy is in prone.");
      return false;
    }
  }
  yaw = abs(getYawToEnemy());
  if(self.a.allow_shooting && ((yaw > 60 && state != "already started") || yaw > 110)) {
    debug_melee("Not doing melee - Not facing the enemy.");
    return false;
  }
  enemyPoint = self.enemy GetOrigin();
  vecToEnemy = enemyPoint - self.origin;
  self.enemyDistanceSq = lengthSquared(vecToEnemy);
  nearest_enemy_sqrd_dist = self GetClosestEnemySqDist();
  epsilon = 0.1;
  if(isDefined(nearest_enemy_sqrd_dist) && (nearest_enemy_sqrd_dist - epsilon > self.enemyDistanceSq)) {
    debug_melee("Not doing melee - Entity " + self getEntityNumber() + " can't melee entity " + self.enemy getEntityNumber() + " at distSq " + self.enemyDistanceSq + " because there is a closer enemy at distSq " + nearest_enemy_sqrd_dist + ".");
    return false;
  }
  if(isDefined(level.allow_ai_vs_ai_melee)) {
    doingAIMelee = (isAI(self.enemy) && self.enemy.type == "human");
  } else {
    doingAIMelee = false;
  }
  if(doingAIMelee) {
    if(!animscripts\utility::okToMelee(self.enemy)) {
      debug_melee("Not doing melee - Enemy is already being meleed.");
      return false;
    }
    if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield && isDefined(self.enemy.magic_bullet_shield) && self.enemy.magic_bullet_shield) {
      debug_melee("Not doing melee - Enemy has magic bullet shield.");
      return false;
    }
    if(!isMeleePathClear(vecToEnemy, enemyPoint)) {
      self notify("melee_path_blocked");
      return false;
    }
  } else {
    if(isDefined(self.enemy.magic_bullet_shield) && self.enemy.magic_bullet_shield) {
      if(!(self is_banzai())) {
        debug_melee("Not doing melee - Enemy has magic bullet shield.");
        return false;
      }
    }
    if(self.enemyDistanceSq <= anim.meleeRangeSq) {
      if(!isMeleePathClear(vecToEnemy, enemyPoint)) {
        if(!self is_banzai()) {
          self notify("melee_path_blocked");
          return false;
        }
      }
      return true;
    } else if(self is_banzai()) {
      return false;
    }
    if(state != "any range") {
      chargeRangeSq = anim.chargeRangeSq;
      if(state == "long range") {
        chargeRangeSq = anim.chargeLongRangeSq;
      }
      if(self.enemyDistanceSq > chargeRangeSq) {
        debug_melee("Not doing melee - Enemy is not close enough to charge.");
        return false;
      }
    }
    if(state == "already started") {
      return false;
    }
    if((!self is_banzai() || IsPlayer(self.enemy)) && self.a.allow_shooting && isDefined(self.lastMeleeGiveUpTime) && GetTime() - self.lastMeleeGiveUpTime < 3000) {
      debug_melee("Not doing melee - Recently meleed someone and missed.");
      return false;
    }
    if(!animscripts\utility::okToMelee(self.enemy)) {
      debug_melee("Not doing melee - Enemy is being meleed.");
      return false;
    }
    if(self.enemy animscripts\banzai::in_banzai_attack()) {
      return false;
    }
    if(self animscripts\banzai::in_banzai_attack()) {
      return false;
    }
    if(!isMeleePathClear(vecToEnemy, enemyPoint)) {
      self notify("melee_path_blocked");
      return false;
    }
  }
  return true;
}

isMeleePathClear(vecToEnemy, enemyPoint) {
  dirToEnemy = VectorNormalize((vecToEnemy[0], vecToEnemy[1], 0));
  meleePoint = enemyPoint - (dirToEnemy[0] * 32, dirToEnemy[1] * 32, 0);
  thread debug_melee_line(self.origin, meleePoint, (1, 0, 0), 1.5);
  if(!self IsInGoal(meleePoint)) {
    debug_melee("Not doing melee - Enemy is outside not in goal.");
    return false;
  }
  if(self maymovetopoint(meleePoint)) {
    return true;
  }
  debug_melee("Not doing melee - Can not move to the melee point, MayMoveToPoint failed.");
  return false;
}

PrepareToMelee(first_time) {
  if(!CanMeleeAnyRange()) {
    return false;
  }
  if(self.enemyDistanceSq <= anim.meleeRangeSq) {
    isBatonGuard = isDefined(self.baton_guard) && self.baton_guard;
    isRegularAi = self.animType != "spetsnaz" && !isBatonGuard;
    if(first_time || isRegularAi) {
      self SetFlaggedAnimKnobAll("readyanim", animArray("stand_2_melee"), % body, 1, .3, 1);
      self animscripts\shared::DoNoteTracks("readyanim");
    }
    return true;
  }
  self PlayMeleeSound();
  prevEnemyPos = self.enemy.origin;
  sampleTime = 0.1;
  runToMeleeAnim = animArray("run_2_melee");
  raiseGunAnimTravelDist = length(getmovedelta(runToMeleeAnim, 0, 1));
  meleeAnimTravelDist = 32;
  shouldRaiseGunDist = anim.meleeRange * 0.75 + meleeAnimTravelDist + raiseGunAnimTravelDist;
  shouldRaiseGunDistSq = shouldRaiseGunDist * shouldRaiseGunDist;
  shouldMeleeDist = anim.meleeRange + meleeAnimTravelDist;
  shouldMeleeDistSq = shouldMeleeDist * shouldMeleeDist;
  raiseGunFullDuration = getanimlength(runToMeleeAnim) * 1000;
  raiseGunFinishDuration = raiseGunFullDuration - 100;
  raiseGunPredictDuration = raiseGunFullDuration - 200;
  raiseGunStartTime = 0;
  predictedEnemyDistSqAfterRaiseGun = undefined;
  runAnim = animscripts\run::GetRunAnim();
  self SetFlaggedAnimKnobAll("chargeanim", runAnim, % body, 1, .3, 1);
  raisingGun = false;
  while(1) {
    meleeDebugPrint("PrepareToMelee loop" + randomInt(100));
    time = GetTime();
    willBeWithinRangeWhenGunIsRaised = (isDefined(predictedEnemyDistSqAfterRaiseGun) && predictedEnemyDistSqAfterRaiseGun <= shouldRaiseGunDistSq);
    if(!raisingGun) {
      if(willBeWithinRangeWhenGunIsRaised) {
        self SetFlaggedAnimKnobAllRestart("chargeanim", runToMeleeAnim, % body, 1, .2, 1);
        raiseGunStartTime = time;
        raisingGun = true;
      }
    } else {
      withinRangeNow = self.enemyDistanceSq <= shouldRaiseGunDistSq;
      if(time - raiseGunStartTime >= raiseGunFinishDuration || (!willBeWithinRangeWhenGunIsRaised && !withinRangeNow)) {
        self SetFlaggedAnimKnobAll("chargeanim", runAnim, % body, 1, .3, 1);
        raisingGun = false;
      }
    }
    self animscripts\shared::DoNoteTracksForTime(sampleTime, "chargeanim");
    if(!CanMeleeAnyRange()) {
      return false;
    }
    assert(isDefined(self.enemyDistanceSq));
    enemyVel = vector_scale(self.enemy.origin - prevEnemyPos, 1 / (GetTime() - time));
    prevEnemyPos = self.enemy.origin;
    predictedEnemyPosAfterRaiseGun = self.enemy.origin + vector_scale(enemyVel, raiseGunPredictDuration);
    predictedEnemyDistSqAfterRaiseGun = distanceSquared(self.origin, predictedEnemyPosAfterRaiseGun);
    if(raisingGun && self.enemyDistanceSq <= shouldMeleeDistSq && GetTime() - raiseGunStartTime >= raiseGunFinishDuration) {
      break;
    }
    if(!raisingGun && GetTime() >= self.giveUpOnMeleeTime) {
      return false;
    }
  }
  return true;
}

PlayMeleeSound() {
  if(!isDefined(self.a.nextMeleeChargeSound)) {
    self.a.nextMeleeChargeSound = 0;
  }
  if(GetTime() > self.a.nextMeleeChargeSound) {
    self animscripts\face::SaySpecificDialogue(undefined, "chr_play_grunt_" + self.voice, 0.3);
    self.a.nextMeleeChargeSound = GetTime() + 8000;
  }
}

AiVsAiMeleeCombat() {
  self endon("killanimscript");
  self melee_notify_wrapper();
  self OrientMode("face enemy");
  self ClearAnim( % root, 0.3);
  IWin = (randomInt(10) < 8);
  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield) {
    IWin = true;
  }
  if(isDefined(self.enemy.magic_bullet_shield) && self.enemy.magic_bullet_shield) {
    IWin = false;
  }
  winAnim = animArray("ai_vs_ai_win");
  loseAnim = animArray("ai_vs_ai_lose");
  if(IWin) {
    myAnim = winAnim;
    theirAnim = loseAnim;
  } else {
    myAnim = loseAnim;
    theirAnim = winAnim;
  }
  desiredDistSqrd = 72 * 72;
  self PlayMeleeSound();
  AiVsAiMeleeCharge(desiredDistSqrd);
  if(distanceSquared(self.origin, self.enemy.origin) > desiredDistSqrd) {
    return false;
  }
  self.meleePartner = self.enemy;
  self.enemy.meleePartner = self;
  self.enemy.meleeAnim = theirAnim;
  self.enemy animcustom(::AiVsAiAnimCustom);
  self.meleeAnim = myAnim;
  self animcustom(::AiVsAiAnimCustom);
}

AiVsAiMeleeCharge(desiredDistSqrd) {
  giveUpTime = GetTime() + 2500;
  self SetAnimKnobAll(animscripts\run::GetRunAnim(), % body, 1, 0.2);
  while(distanceSquared(self.origin, self.enemy.origin) > desiredDistSqrd && GetTime() < giveUpTime) {
    wait .05;
  }
}

AiVsAiAnimCustom() {
  self endon("killanimscript");
  self AiVsAiMeleeAnim(self.meleeAnim);
}

AiVsAiMeleeAnim(myAnim) {
  self endon("end_melee");
  self thread endMeleeOnKillanimscript();
  partnerDir = self.meleePartner.origin - self.origin;
  self OrientMode("face angle", VectorToAngles(partnerDir)[1]);
  self AnimMode("zonly_physics");
  self SetFlaggedAnimKnobAllRestart("meleeAnim", myAnim, % body, 1, 0.2);
  self animscripts\shared::DoNoteTracks("meleeAnim");
  self notify("end_melee");
}

endMeleeOnKillanimscript() {
  self endon("end_melee");
  self waittill("killanimscript");
  self.meleePartner notify("end_melee");
}