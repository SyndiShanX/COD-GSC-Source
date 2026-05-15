/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: animscripts\melee.gsc
********************************************************/

#include animscripts\Utility;
#include animscripts\SetPoseMovement;
#include animscripts\Combat_Utility;
#include common_scripts\Utility;
#include maps\_utility;
#using_animtree("generic_human");

sqr8 = 8 * 8;
sqr16 = 16 * 16;
sqr32 = 32 * 32;
sqr36 = 36 * 36;
sqr64 = 64 * 64;

MELEE_RANGE = 64;
MELEE_RANGE_SQ = sqr64;
MELEE_ACTOR_BOUNDS_RADIUS = 32;
MELEE_ACTOR_BOUNDS_RADIUS_MINUS_EPSILON = (MELEE_ACTOR_BOUNDS_RADIUS - 0.1);

CHARGE_RANGE_SQ = 160 * 160;
CHARGE_RANGE_SQ_VS_PLAYER = 200 * 200;

FAILED_INIT_NEXT_MELEE_TIME = 150;
FAILED_CHARGE_NEXT_MELEE_TIME = 1500;
FAILED_STANDARD_NEXT_MELEE_TIME = 2500;

NOTETRACK_SYNC = "sync";
NOTETRACK_UNSYNC = "unsync";
NOTETRACK_ATTACHKNIFE = "attach_knife";
NOTETRACK_DETACTKNIFE = "detach_knife";
NOTETRACK_STAB = "stab";
NOTETRACK_DEATH = "melee_death";
NOTETRACK_INTERACT = "melee_interact";

KNIFE_ATTACK_MODEL = "weapon_parabolic_knife";
KNIFE_ATTACK_TAG = "TAG_INHAND";
KNIFE_ATTACK_SOUND = "melee_knife_hit_body";
KNIFE_ATTACK_FX_NAME = "melee_knife_ai";
KNIFE_ATTACK_FX_PATH = "impacts/flesh_hit_knife";
KNIFE_ATTACK_FX_TAG = "TAG_KNIFE_FX";

Melee_Init() {
  precacheModel(KNIFE_ATTACK_MODEL);
  level._effect[KNIFE_ATTACK_FX_NAME] = loadfx(KNIFE_ATTACK_FX_PATH);
}

Melee_StealthCheck() {
  if(!isDefined(self._stealth)) {
    return false;
  }

  if(isDefined(self.ent_flag) && isDefined(self.ent_flag["_stealth_enabled"]) && self.ent_flag["_stealth_enabled"]) {
    if(isDefined(self.ent_flag["_stealth_attack"]) && !self.ent_flag["_stealth_attack"]) {
      return true;
    }
  }
  return false;
}

Melee_TryExecuting() {
  if(!isDefined(self.enemy)) {
    return false;
  }

  if(isDefined(self.dontmelee)) {
    return false;
  }

  if(Melee_StealthCheck()) {
    return false;
  }

  if(!Melee_AcquireMutex(self.enemy)) {
    return false;
  }

  Melee_ResetAction();
  if(!Melee_ChooseAction()) {
    Melee_ReleaseMutex(self.enemy);
    return false;
  }

  self animcustom(::Melee_MainLoop, ::Melee_EndScript);
}
Melee_ResetAction() {
  assert(isDefined(self.melee));
  assert(isDefined(self.enemy.melee));

  self.melee.target = self.enemy;
  self.melee.initiated = false;
  self.melee.inProgress = false;
}
Melee_ChooseAction() {
  if(!Melee_isValid()) {
    return false;
  }

  self.melee.initiated = true;

  if(Melee_AIvsAI_ChooseAction()) {
    self.melee.func = ::Melee_AIvsAI_Main;
    return true;
  }

  if(Melee_Standard_ChooseAction()) {
    if(isDefined(self.specialMelee_Standard)) {
      self.melee.func = self.specialMelee_Standard;
    } else {
      self.melee.func = ::Melee_Standard_Main;
    }
    return true;
  }

  self.melee.func = undefined;
  self.nextMeleeCheckTime = gettime() + FAILED_INIT_NEXT_MELEE_TIME;
  self.nextMeleeCheckTarget = self.melee.target;
  return false;
}

Melee_UpdateAndValidateStartPos() {
  assert(isDefined(self));
  assert(isDefined(self.melee));
  assert(isDefined(self.melee.startPos));
  assert(isDefined(self.melee.target));

  ignoreActors = true;

  distFromTarget2d = distance2d(self.melee.startPos, self.melee.target.origin);
  if(distFromTarget2d < MELEE_ACTOR_BOUNDS_RADIUS) {
    dirToStartPos2d = vectorNormalize((self.melee.startPos[0] - self.melee.target.origin[0], self.melee.startPos[1] - self.melee.target.origin[1], 0));
    self.melee.startPos += dirToStartPos2d * (MELEE_ACTOR_BOUNDS_RADIUS - distFromTarget2d);
    assertex(distance2d(self.melee.startPos, self.melee.target.origin) >= (MELEE_ACTOR_BOUNDS_RADIUS_MINUS_EPSILON), "Invalid distance to target: " + distance2d(self.melee.startPos, self.melee.target.origin) + ", should be more than " + (MELEE_ACTOR_BOUNDS_RADIUS_MINUS_EPSILON));
    ignoreActors = false;
  }

  floorPos = self getDropToFloorPosition(self.melee.startPos);
  if(!isDefined(floorPos)) {
    return false;
  }

  if(abs(self.melee.startPos[2] - floorPos[2]) > (MELEE_RANGE * 0.80)) {
    return false;
  }

  if(abs(self.origin[2] - floorPos[2]) > (MELEE_RANGE * 0.80)) {
    return false;
  }

  self.melee.startPos = floorPos;
  assertex(distance2d(self.melee.startPos, self.melee.target.origin) >= (MELEE_ACTOR_BOUNDS_RADIUS_MINUS_EPSILON), "Invalid distance to target: " + distance2d(self.melee.startPos, self.melee.target.origin) + ", should be more than " + (MELEE_ACTOR_BOUNDS_RADIUS_MINUS_EPSILON));

  if(!self mayMoveToPoint(self.melee.startPos, true, ignoreActors)) {
    return false;
  }

  if(isDefined(self.melee.startToTargetCornerAngles)) {
    targetToStartPos = self.melee.startPos - self.melee.target.origin;
    cornerDir = anglesToForward(self.melee.startToTargetCornerAngles);
    cornerDirLen = vectorDot(cornerDir, targetToStartPos);
    mayMoveTargetOrigin = self.melee.startPos - (cornerDir * cornerDirLen);

    cornerToTarget = self.melee.target.origin - mayMoveTargetOrigin;
    cornerToTargetLen = distance2d(self.melee.target.origin, mayMoveTargetOrigin);
    if(cornerToTargetLen < MELEE_ACTOR_BOUNDS_RADIUS) {
      mayMoveTargetOrigin -= cornerToTarget * ((MELEE_ACTOR_BOUNDS_RADIUS - cornerToTargetLen) / MELEE_ACTOR_BOUNDS_RADIUS);
    }
  } else {
    dirToStartPos2d = vectorNormalize((self.melee.startPos[0] - self.melee.target.origin[0], self.melee.startPos[1] - self.melee.target.origin[1], 0));
    mayMoveTargetOrigin = self.melee.target.origin + dirToStartPos2d * MELEE_ACTOR_BOUNDS_RADIUS;
  }

  assert(isDefined(mayMoveTargetOrigin));

  if(!self mayMoveFromPointToPoint(self.melee.startPos, mayMoveTargetOrigin, true, false)) {
    return false;
  }

  if(!self mayMoveFromPointToPoint(mayMoveTargetOrigin, self.melee.target.origin, true, true)) {
    return false;
  }

  return true;
}
Melee_isValid() {
  if(!isDefined(self.melee.target)) {
    return false;
  }

  target = self.melee.target;

  if(isDefined(target.dontMelee)) {
    return false;
  }

  enemyDistanceSq = distanceSquared(self.origin, target.origin);

  if(isDefined(self.meleeChargeDistSq)) {
    chargeDistSq = self.meleeChargeDistSq;
  } else if(isPlayer(target)) {
    chargeDistSq = CHARGE_RANGE_SQ_VS_PLAYER;
  } else {
    chargeDistSq = CHARGE_RANGE_SQ;
  }

  if(!self.melee.initiated && (enemyDistanceSq > chargeDistSq)) {
    return false;
  }

  if(!isAlive(self)) {
    return false;
  }

  if(isDefined(self.a.noFirstFrameMelee) && (self.a.scriptStartTime >= gettime() + 50)) {
    return false;
  }

  if(isDefined(self.nextMeleeCheckTime) && isDefined(self.nextMeleeCheckTarget) && (gettime() < self.nextMeleeCheckTime) && (self.nextMeleeCheckTarget == target)) {
    return false;
  }

  if(isDefined(self.a.onback) || (self.a.pose == "prone")) {
    return false;
  }

  if(usingSidearm()) {
    return false;
  }

  if(isDefined(self.grenade) && (self.frontShieldAngleCos == 1)) {
    return false;
  }

  if(!isAlive(target)) {
    return false;
  }

  if(isDefined(target.dontAttackMe) || (isDefined(target.ignoreMe) && target.ignoreMe)) {
    return false;
  }

  if(!isAI(target) && !isPlayer(target)) {
    return false;
  }

  if(isAI(target)) {
    if(target isInScriptedState()) {
      return false;
    }

    if(target doingLongDeath() || target.delayedDeath) {
      return false;
    }
  }

  if(isPlayer(target)) {
    enemyPose = target getStance();
  } else {
    enemyPose = target.a.pose;
  }

  if((enemyPose != "stand") && (enemyPose != "crouch")) {
    return false;
  }

  if(isDefined(self.magic_bullet_shield) && isDefined(target.magic_bullet_shield)) {
    return false;
  }

  if(isDefined(target.grenade)) {
    return false;
  }

  if(self.melee.inProgress) {
    yawThreshold = 110;
  } else {
    yawThreshold = 60;
  }

  yawToEnemy = AngleClamp180(self.angles[1] - GetYaw(target.origin));
  if(abs(yawToEnemy) > yawThreshold) {
    return false;
  }

  if(enemyDistanceSq <= MELEE_RANGE_SQ) {
    return true;
  }

  if(self.melee.inProgress) {
    return false;
  }

  if(isDefined(self.nextMeleeChargeTime) && isDefined(self.nextMeleeChargeTarget) && (gettime() < self.nextMeleeChargeTime) && (self.nextMeleeChargeTarget == target)) {
    return false;
  }

  return true;
}

Melee_StartMovement() {
  self.melee.playingMovementAnim = true;
  self.a.movement = "run";
}

Melee_StopMovement() {
  self clearanim(%body, 0.2);
  self.melee.playingMovementAnim = undefined;
  self.a.movement = "stop";
  self orientMode("face default");
}

Melee_MainLoop() {
  self endon("killanimscript");
  self endon("end_melee");

  assert(isDefined(self));
  assert(isDefined(self.melee));
  assert(isDefined(self.melee.func));

  while(true) {
    prevFunc = self.melee.func;

    [[self.melee.func]]();

    if(!isDefined(self.melee.func) || (prevFunc == self.melee.func)) {
      break;
    }
  }
}

Melee_Standard_DelayStandardCharge(target) {
  if(!isDefined(target)) {
    return;
  }
  self.nextMeleeStandardChargeTime = getTime() + FAILED_STANDARD_NEXT_MELEE_TIME;
  self.nextMeleeStandardChargeTarget = target;
}

Melee_Standard_CheckTimeConstraints() {
  assert(isDefined(self));
  assert(isDefined(self.melee));
  assert(isDefined(self.melee.target));

  targetDistSq = distanceSquared(self.melee.target.origin, self.origin);
  if((targetDistSq > MELEE_RANGE_SQ) && isDefined(self.nextMeleeStandardChargeTime) && isDefined(self.nextMeleeStandardChargeTarget) && (getTime() < self.nextMeleeStandardChargeTime) && (self.nextMeleeStandardChargeTarget == self.melee.target)) {
    return false;
  }

  return true;
}

Melee_Standard_ChooseAction() {
  assert(isDefined(self));
  assert(isDefined(self.melee));
  assert(isDefined(self.melee.target));

  if(isDefined(self.melee.target.magic_bullet_shield)) {
    return false;
  }

  if(!Melee_Standard_CheckTimeConstraints()) {
    return false;
  }

  if(isDefined(self.melee.target.specialMeleeChooseAction)) {
    return false;
  }

  return Melee_Standard_UpdateAndValidateTarget();
}

Melee_Standard_ResetGiveUpTime() {
  if(isDefined(self.meleeChargeDistSq)) {
    chargeDistSq = self.meleeChargeDistSq;
  } else if(isPlayer(self.melee.target)) {
    chargeDistSq = CHARGE_RANGE_SQ_VS_PLAYER;
  } else {
    chargeDistSq = CHARGE_RANGE_SQ;
  }

  if(distanceSquared(self.origin, self.melee.target.origin) > chargeDistSq) {
    self.melee.giveUpTime = gettime() + 3000;
  } else {
    self.melee.giveUpTime = gettime() + 1000;
  }
}

Melee_Standard_Main() {
  self animMode("zonly_physics");

  Melee_Standard_ResetGiveUpTime();

  while(true) {
    assert(isDefined(self.melee.target));

    if(!Melee_Standard_GetInPosition()) {
      self.nextMeleeChargeTime = getTime() + FAILED_CHARGE_NEXT_MELEE_TIME;
      self.nextMeleeChargeTarget = self.melee.target;
      break;
    }

    if(!isDefined(self.melee.target)) {
      break;
    }

    assert((self.a.pose == "stand") || (self.a.pose == "crouch"));

    self animscripts\battleChatter_ai::evaluateMeleeEvent();

    self orientMode("face point", self.melee.target.origin);
    self setflaggedanimknoballrestart("meleeanim", %melee_1, %body, 1, .2, 1);
    self.melee.inProgress = true;

    if(!Melee_Standard_PlayAttackLoop()) {
      Melee_Standard_DelayStandardCharge(self.melee.target);
      break;
    }
  }

  self animMode("none");
}

Melee_Standard_PlayAttackLoop() {
  while(true) {
    self waittill("meleeanim", note);

    if(note == "end") {
      return true;
    }

    if(note == "stop") {
      if(!Melee_ChooseAction()) {
        return false;
      }

      assert(isDefined(self.melee.func));
      if(self.melee.func != ::Melee_Standard_Main) {
        return true;
      }
    }

    if(note == "fire") {
      if(isDefined(self.melee.target)) {
        oldhealth = self.melee.target.health;
        self melee();
        if(isDefined(self.melee.target) && (self.melee.target.health < oldhealth)) {
          Melee_Standard_ResetGiveUpTime();
        }
      }
    }
  }
}
Melee_Standard_UpdateAndValidateTarget() {
  assert(isDefined(self));
  assert(isDefined(self.melee));

  if(!isDefined(self.melee.target)) {
    return false;
  }

  if(!Melee_isValid()) {
    return false;
  }

  dirToTarget = vectorNormalize(self.melee.target.origin - self.origin);
  self.melee.startPos = self.melee.target.origin - 40.0 * dirToTarget;

  return Melee_UpdateAndValidateStartPos();
}

distance2dSquared(a, b) {
  diff = (a[0] - b[0], a[1] - b[1], 0);
  return lengthSquared(diff);
}
Melee_Standard_GetInPosition() {
  if(!Melee_Standard_UpdateAndValidateTarget()) {
    return false;
  }

  enemyDistanceSq = distance2dSquared(self.origin, self.melee.target.origin);

  if(enemyDistanceSq <= MELEE_RANGE_SQ) {
    self SetFlaggedAnimKnobAll("readyanim", %stand_2_melee_1, %body, 1, .3, 1);
    self animscripts\shared::DoNoteTracks("readyanim");
    return true;
  }

  self Melee_PlayChargeSound();

  prevEnemyPos = self.melee.target.origin;

  sampleTime = 0.1;

  raiseGunAnimTravelDist = length(getmovedelta(%run_2_melee_charge, 0, 1));
  meleeAnimTravelDist = 32;
  shouldRaiseGunDist = MELEE_RANGE * 0.75 + meleeAnimTravelDist + raiseGunAnimTravelDist;
  shouldRaiseGunDistSq = shouldRaiseGunDist * shouldRaiseGunDist;

  shouldMeleeDist = MELEE_RANGE + meleeAnimTravelDist;
  shouldMeleeDistSq = shouldMeleeDist * shouldMeleeDist;

  raiseGunFullDuration = getanimlength(%run_2_melee_charge) * 1000;
  raiseGunFinishDuration = raiseGunFullDuration - 100;
  raiseGunPredictDuration = raiseGunFullDuration - 200;
  raiseGunStartTime = 0;

  predictedEnemyDistSqAfterRaiseGun = undefined;

  runAnim = % run_lowready_F;

  if(isPlayer(self.melee.target) && self.melee.target == self.enemy) {
    self orientMode("face enemy");
  } else {
    self orientMode("face point", self.melee.target.origin);
  }

  self SetFlaggedAnimKnobAll("chargeanim", runAnim, %body, 1, .3, 1);
  raisingGun = false;

  while(1) {
    time = gettime();

    willBeWithinRangeWhenGunIsRaised = (isDefined(predictedEnemyDistSqAfterRaiseGun) && predictedEnemyDistSqAfterRaiseGun <= shouldRaiseGunDistSq);

    if(!raisingGun) {
      if(willBeWithinRangeWhenGunIsRaised) {
        Melee_StartMovement();
        self SetFlaggedAnimKnobAllRestart("chargeanim", %run_2_melee_charge, %body, 1, .2, 1);
        raiseGunStartTime = time;
        raisingGun = true;
      }
    } else {
      withinRangeNow = enemyDistanceSq <= shouldRaiseGunDistSq;
      if(time - raiseGunStartTime >= raiseGunFinishDuration || (!willBeWithinRangeWhenGunIsRaised && !withinRangeNow)) {
        Melee_StartMovement();
        self SetFlaggedAnimKnobAll("chargeanim", runAnim, %body, 1, .3, 1);
        raisingGun = false;
      }
    }
    self animscripts\shared::DoNoteTracksForTime(sampleTime, "chargeanim");

    if(!Melee_Standard_UpdateAndValidateTarget()) {
      Melee_StopMovement();
      return false;
    }

    enemyDistanceSq = distance2dSquared(self.origin, self.melee.target.origin);
    enemyVel = vector_multiply(self.melee.target.origin - prevEnemyPos, 1 / (gettime() - time));
    prevEnemyPos = self.melee.target.origin;

    predictedEnemyPosAfterRaiseGun = self.melee.target.origin + vector_multiply(enemyVel, raiseGunPredictDuration);
    predictedEnemyDistSqAfterRaiseGun = distance2dSquared(self.origin, predictedEnemyPosAfterRaiseGun);

    if(raisingGun && (enemyDistanceSq <= shouldMeleeDistSq) && (gettime() - raiseGunStartTime >= raiseGunFinishDuration || !isPlayer(self.melee.target))) {
      break;
    }

    if(!raisingGun && (gettime() >= self.melee.giveUpTime)) {
      Melee_StopMovement();
      return false;
    }
  }

  Melee_StopMovement();
  return true;
}

Melee_PlayChargeSound() {
  if(!isDefined(self.a.nextMeleeChargeSound)) {
    self.a.nextMeleeChargeSound = 0;
  }

  if((isDefined(self.enemy) && isPlayer(self.enemy)) || randomint(3) == 0) {
    if(gettime() > self.a.nextMeleeChargeSound) {
      self animscripts\face::SayGenericDialogue("meleecharge");
      self.a.nextMeleeChargeSound = gettime() + 8000;
    }
  }
}

Melee_AIvsAI_Exposed_ChooseAnimationAndPosition_Flip(angleDiff) {
  flipAngleThreshold = 90;

  if(self.melee.inProgress) {
    flipAngleThreshold += 50;
  }

  if(abs(angleDiff) < flipAngleThreshold) {
    return false;
  }

  target = self.melee.target;
  Melee_Decide_Winner();
  if(self.melee.winner) {
    self.melee.animName = % melee_F_awin_attack;
    target.melee.animName = % melee_F_awin_defend;
    target.melee.surviveAnimName = % melee_F_awin_defend_survive;
  } else {
    self.melee.animName = % melee_F_dwin_attack;
    target.melee.animName = % melee_F_dwin_defend;
  }

  return true;
}

Melee_AIvsAI_Exposed_ChooseAnimationAndPosition_Wrestle(angleDiff) {
  wrestleAngleThreshold = 100;

  if(self.melee.inProgress) {
    wrestleAngleThreshold += 50;
  }

  if(abs(angleDiff) < wrestleAngleThreshold) {
    return false;
  }

  target = self.melee.target;

  if(isDefined(target.magic_bullet_shield)) {
    return false;
  }

  if(isDefined(target.meleeAlwaysWin)) {
    assert(!isDefined(self.magic_bullet_shield));
    return false;
  }

  self.melee.winner = true;
  self.melee.animName = % bog_melee_R_attack;
  target.melee.animName = % bog_melee_R_defend;
  target.melee.surviveAnimName = % bog_melee_R_backdeath2;

  return true;
}

Melee_AIvsAI_Exposed_ChooseAnimationAndPosition_Behind(angleDiff) {
  if((-90 > angleDiff) || (angleDiff > 0)) {
    return false;
  }

  target = self.melee.target;

  if(isDefined(target.magic_bullet_shield)) {
    return false;
  }

  if(isDefined(target.meleeAlwaysWin)) {
    assert(!isDefined(self.magic_bullet_shield));
    return false;
  }

  self.melee.winner = true;
  self.melee.animName = % melee_sync_attack;
  target.melee.animName = % melee_sync_defend;

  return true;
}

Melee_AIvsAI_Exposed_ChooseAnimationAndPosition_BuildExposedList() {
  if(isDefined(self.meleeForcedExposedFlip)) {
    assert(!isDefined(self.meleeForcedExposedWrestle));
    exposedMelees[0] = ::Melee_AIvsAI_Exposed_ChooseAnimationAndPosition_Flip;
  } else if(isDefined(self.meleeForcedExposedWrestle)) {
    exposedMelees[0] = ::Melee_AIvsAI_Exposed_ChooseAnimationAndPosition_Wrestle;
  } else {
    flipIndex = randomInt(2);
    wrestleIndex = 1 - flipIndex;
    behindIndex = 2;

    exposedMelees[flipIndex] = ::Melee_AIvsAI_Exposed_ChooseAnimationAndPosition_Flip;
    exposedMelees[wrestleIndex] = ::Melee_AIvsAI_Exposed_ChooseAnimationAndPosition_Wrestle;
    exposedMelees[behindIndex] = ::Melee_AIvsAI_Exposed_ChooseAnimationAndPosition_Behind;
  }

  return exposedMelees;
}

Melee_AIvsAI_Exposed_ChooseAnimationAndPosition() {
  assert(isDefined(self));
  assert(isDefined(self.melee.target));

  target = self.melee.target;
  angleToEnemy = vectortoangles(target.origin - self.origin);
  angleDiff = AngleClamp180(target.angles[1] - angleToEnemy[1]);

  exposedMelees = Melee_AIvsAI_Exposed_ChooseAnimationAndPosition_BuildExposedList();
  for(i = 0; i < exposedMelees.size; i++) {
    if([[exposedMelees[i]]](angleDiff)) {
      assert(isDefined(self.melee.animName));
      assert(isDefined(target.melee.animName));

      self.melee.startAngles = (0, angleToEnemy[1], 0);
      self.melee.startPos = getStartOrigin(target.origin, target.angles, self.melee.animName);

      if(Melee_UpdateAndValidateStartPos()) {
        return true;
      }
    }
  }

  return false;
}

Melee_Decide_Winner() {
  assert(isDefined(self.melee));
  assert(isDefined(self.melee.target));

  target = self.melee.target;

  if(isDefined(self.meleeAlwaysWin)) {
    assert(!isDefined(target.magic_bullet_shield));
    self.melee.winner = true;
    return;
  } else if(isDefined(target.meleeAlwaysWin)) {
    assert(!isDefined(self.magic_bullet_shield));
    self.melee.winner = false;
    return;
  }

  if(isDefined(self.magic_bullet_shield)) {
    assert(!isDefined(target.magic_bullet_shield));
    self.melee.winner = true;
  } else if(isDefined(target.magic_bullet_shield)) {
    self.melee.winner = false;
  } else {
    self.melee.winner = cointoss();
  }
}

Melee_AIvsAI_SpecialCover_ChooseAnimationAndPosition() {
  assert(isDefined(self));
  assert(isDefined(self.melee.target));
  assert(isDefined(self.melee.target.covernode));

  target = self.melee.target;

  Melee_Decide_Winner();

  if(target.covernode.type == "Cover Left") {
    if(self.melee.winner) {
      self.melee.animName = % cornerSdL_melee_winA_attacker;
      target.melee.animName = % cornerSdL_melee_winA_defender;
      target.melee.surviveAnimName = % cornerSdL_melee_winA_defender_survive;
    } else {
      self.melee.animName = % cornerSdL_melee_winD_attacker;
      self.melee.surviveAnimName = % cornerSdL_melee_winD_attacker_survive;
      target.melee.animName = % cornerSdL_melee_winD_defender;
    }
  } else {
    assert(target.covernode.type == "Cover Right");
    if(self.melee.winner) {
      self.melee.animName = % cornerSdR_melee_winA_attacker;
      target.melee.animName = % cornerSdR_melee_winA_defender;
    } else {
      self.melee.animName = % cornerSdR_melee_winD_attacker;
      target.melee.animName = % cornerSdR_melee_winD_defender;
    }
  }

  self.melee.startPos = getStartOrigin(target.covernode.origin, target.covernode.angles, self.melee.animName);
  self.melee.startAngles = (target.covernode.angles[0], AngleClamp180(target.covernode.angles[1] + 180), target.covernode.angles[2]);

  target.melee.faceYaw = getNodeForwardYaw(target.covernode);

  self.melee.startToTargetCornerAngles = target.covernode.angles;
  if(!Melee_UpdateAndValidateStartPos()) {
    self.melee.startToTargetCornerAngles = undefined;
    return false;
  }

  return true;
}

Melee_AIvsAI_SpecialCover_CanExecute() {
  assert(isDefined(self));
  assert(isDefined(self.melee.target));

  cover = self.melee.target.covernode;
  if(!isDefined(cover)) {
    return false;
  }

  if((distanceSquared(cover.origin, self.melee.target.origin) > 16) && isDefined(self.melee.target.a.coverMode) && ((self.melee.target.a.coverMode != "hide") && (self.melee.target.a.coverMode != "lean"))) {
    return false;
  }

  coverToSelfAngles = vectortoangles(self.origin - cover.origin);
  angleDiff = AngleClamp180(cover.angles[1] - coverToSelfAngles[1]);

  if(cover.type == "Cover Left") {
    if((angleDiff >= -50) && (angleDiff <= 0)) {
      return true;
    }
  } else if(cover.type == "Cover Right") {
    if((angleDiff >= 0) && (angleDiff <= 50)) {
      return true;
    }
  }

  return false;
}

Melee_AIvsAI_ChooseAction() {
  assert(isDefined(self.melee));
  assert(isDefined(self.melee.target));

  target = self.melee.target;

  if(!isAI(target) || (target.type != "human")) {
    return false;
  }

  assert(isDefined(self.stairsState));
  assert(isDefined(target.stairsState));
  if((self.stairsState != "none") || (target.stairsState != "none")) {
    return false;
  }

  assert(!isDefined(self.magic_bullet_shield) || !isDefined(self.melee.target.magic_bullet_shield));

  if(isDefined(self.specialMeleeChooseAction)) {
    if(![[self.specialMeleeChooseAction]]()) {
      return false;
    }
    self.melee.precisePositioning = true;
  } else if(isDefined(target.specialMeleeChooseAction)) {
    return false;
  } else if(Melee_AIvsAI_SpecialCover_CanExecute() && Melee_AIvsAI_SpecialCover_ChooseAnimationAndPosition()) {
    self.melee.precisePositioning = true;
  } else {
    if(!Melee_AIvsAI_Exposed_ChooseAnimationAndPosition()) {
      return false;
    }
    self.melee.precisePositioning = false;
  }

  if(!isDefined(target.melee.faceYaw)) {
    target.melee.faceYaw = target.angles[1];
  }

  self.melee.startPosOffset = (self.melee.startPos - target.origin);

  return true;
}

Melee_AIvsAI_ScheduleNoteTrackLink(target) {
  self.melee.syncNoteTrackEnt = target;
  target.melee.syncNoteTrackEnt = undefined;
}

Melee_AIvsAI_TargetLink(target) {
  assert(isDefined(self));
  assert(isDefined(target));

  if(!isDefined(target.melee)) {
    assert(isDefined(self.melee.survive));
    return;
  }

  self Melee_PlayChargeSound();

  if(!isAlive(target)) {
    return;
  }

  self.syncedMeleeTarget = target;
  target.syncedMeleeTarget = self;

  self.melee.linked = true;
  target.melee.linked = true;
  self linkToBlendToTag(target, "tag_sync", true, true);
}

Melee_AIvsAI_Main() {
  if(!Melee_AIvsAI_GetInPosition()) {
    self.nextMeleeChargeTime = gettime() + FAILED_CHARGE_NEXT_MELEE_TIME;
    self.nextMeleeChargeTarget = self.melee.target;
    return;
  }

  target = self.melee.target;

  assert(isAlive(self) && isAlive(target));

  assert(!isDefined(self.syncedMeleeTarget));
  assert(!isDefined(target.syncedMeleeTarget));

  assert(isDefined(self.melee.animName));
  assert(animHasNotetrack(self.melee.animName, NOTETRACK_SYNC));
  self Melee_AIvsAI_ScheduleNoteTrackLink(target);

  if(self.melee.winner) {
    self.melee.death = undefined;
    target.melee.death = true;
  } else {
    target.melee.death = undefined;
    self.melee.death = true;
  }

  self.melee.partner = target;
  target.melee.partner = self;

  if(self usingSideArm()) {
    self forceUseWeapon(self.primaryWeapon, "primary");
    self.lastWeapon = self.primaryWeapon;
  }
  if(target usingSideArm()) {
    target forceUseWeapon(target.primaryWeapon, "primary");
    target.lastWeapon = target.primaryWeapon;
  }

  self.melee.weapon = self.weapon;
  self.melee.weaponSlot = self getCurrentWeaponSlotName();
  target.melee.weapon = target.weapon;
  target.melee.weaponSlot = target getCurrentWeaponSlotName();

  self.melee.inProgress = true;

  target animcustom(::Melee_AIvsAI_Execute, ::Melee_EndScript);
  target thread Melee_AIvsAI_AnimCustomInterruptionMonitor(self);

  self.melee.target = undefined;

  self Melee_AIvsAI_Execute();
}

Melee_AIvsAI_AnimCustomInterruptionMonitor(attacker) {
  assert(isDefined(attacker));

  self endon("end_melee");
  self endon("melee_aivsai_execute");

  wait 0.1;

  if(isDefined(attacker)) {
    attacker notify("end_melee");
  }

  self notify("end_melee");
}

Melee_AIvsAI_GetInPosition_UpdateAndValidateTarget(initialTargetOrigin, giveUpTime) {
  assert(isDefined(self));
  assert(isDefined(self.melee));
  assert(isDefined(initialTargetOrigin));

  if(isDefined(giveUpTime) && (giveUpTime <= getTime())) {
    return false;
  }

  if(!Melee_isValid()) {
    return false;
  }

  target = self.melee.target;

  positionDelta = distanceSquared(target.origin, initialTargetOrigin);

  assert(isDefined(self.melee.precisePositioning));
  if(self.melee.precisePositioning) {
    positionThreshold = sqr16;
  } else {
    positionThreshold = sqr36;
  }

  if(positionDelta > positionThreshold) {
    return false;
  }

  self.melee.startPos = target.origin + self.melee.startPosOffset;
  if(!Melee_UpdateAndValidateStartPos()) {
    return false;
  }

  return true;
}

Melee_AIvsAI_GetInPosition_IsSuccessful(initialTargetOrigin) {
  assert(isDefined(self));
  assert(isDefined(self.melee));
  assert(isDefined(self.melee.startPos));
  assert(isDefined(self.melee.target));
  assert(isDefined(initialTargetOrigin));

  dist2dToStartPos = distanceSquared((self.origin[0], self.origin[1], 0), (self.melee.startPos[0], self.melee.startPos[1], 0));
  if((dist2dToStartPos < sqr8) && (abs(self.melee.startPos[2] - self.origin[2]) < MELEE_RANGE)) {
    return true;
  }

  dist2dFromStartPosToTargetSq = distanceSquared((initialTargetOrigin[0], initialTargetOrigin[1], 0), (self.melee.startPos[0], self.melee.startPos[1], 0));
  dist2dToTargetSq = distanceSquared((self.origin[0], self.origin[1], 0), (self.melee.target.origin[0], self.melee.target.origin[1], 0));
  if((dist2dFromStartPosToTargetSq > dist2dToTargetSq) && (abs(self.melee.target.origin[2] - self.origin[2]) < MELEE_RANGE)) {
    return true;
  }

  return false;
}

Melee_AIvsAI_GetInPosition_Finalize(initialTargetOrigin) {
  assert(isDefined(self));
  assert(isDefined(self.melee));
  assert(isDefined(self.melee.precisePositioning));
  assert(isDefined(initialTargetOrigin));

  Melee_StopMovement();

  if(self.melee.precisePositioning) {
    assert(isDefined(self.melee.startPos));
    assert(isDefined(self.melee.startAngles));

    self forceTeleport(self.melee.startPos, self.melee.startAngles);
    wait 0.05;
  } else {
    self orientMode("face angle", self.melee.startAngles[1]);
    wait 0.05;
  }

  return Melee_AIvsAI_GetInPosition_UpdateAndValidateTarget(initialTargetOrigin);
}

Melee_AIvsAI_GetInPosition() {
  assert(isDefined(self));
  assert(isDefined(self.melee));

  if(!Melee_isValid()) {
    return false;
  }

  Melee_StartMovement();
  self clearanim(%body, 0.2);
  self setAnimKnobAll(animscripts\run::GetRunAnim(), %body, 1, 0.2);
  self animMode("zonly_physics");
  self.keepClaimedNode = true;

  giveUpTime = getTime() + 1500;

  assert(isDefined(self.melee.target));
  assert(isDefined(self.melee.target.origin));
  initialTargetOrigin = self.melee.target.origin;

  self notify("MDBG_att_getInPosition", self.melee.target);
  self.melee.target notify("MDBG_def_getInPosition", self);

  while(Melee_AIvsAI_GetInPosition_UpdateAndValidateTarget(initialTargetOrigin, giveUpTime)) {
    if(Melee_AIvsAI_GetInPosition_IsSuccessful(initialTargetOrigin)) {
      return Melee_AIvsAI_GetInPosition_Finalize(initialTargetOrigin);
    }

    self orientMode("face point", self.melee.startPos);
    wait .05;
  }

  Melee_StopMovement();
  return false;
}

Melee_AIvsAI_Execute() {
  self endon("killanimscript");
  self endon("end_melee");

  self notify("melee_aivsai_execute");

  assert(isDefined(self));
  assert(isDefined(self.melee));

  self animMode("zonly_physics");
  self.a.special = "none";
  self.specialDeathFunc = undefined;

  self thread Melee_DroppedWeaponMonitorThread();

  self thread Melee_PartnerEndedMeleeMonitorThread();

  if(isDefined(self.melee.faceYaw)) {
    self orientMode("face angle", self.melee.faceYaw);
  } else {
    self orientMode("face current");
  }

  self.a.pose = "stand";
  self clearanim(%body, 0.2);

  if(isDefined(self.melee.death)) {
    self Melee_DisableInterruptions();
  }

  self setFlaggedAnimKnobAllRestart("meleeAnim", self.melee.animName, %body, 1, 0.2);
  endNote = self animscripts\shared::DoNoteTracks("meleeAnim", ::Melee_HandleNoteTracks);

  if((endNote == NOTETRACK_DEATH) && isDefined(self.melee.survive)) {
    Melee_DroppedWeaponRestore();

    self setflaggedanimknoballrestart("meleeAnim", self.melee.surviveAnimName, %body, 1, 0.2);
    endNote = self animscripts\shared::DoNoteTracks("meleeAnim", ::Melee_HandleNoteTracks);
  }

  if(isDefined(self.melee) && isDefined(self.melee.death)) {
    self kill();
  }

  self.keepClaimedNode = false;
}

Melee_DisableInterruptions() {
  self.melee.wasAllowingPain = self.allowPain;
  self.melee.wasFlashbangImmune = self.flashBangImmunity;

  self disable_pain();
  self setFlashbangImmunity(true);
}

Melee_NeedsWeaponSwap() {
  assert(isDefined(self));
  assert(isDefined(self.melee));
  return (isDefined(self.melee.weapon) && (self.melee.weapon != "none") && (self.weapon != self.melee.weapon));
}

Melee_DroppedWeaponRestore() {
  assert(isDefined(self));
  assert(isDefined(self.melee));

  if(self.weapon != "none" && self.lastWeapon != "none") {
    return;
  }

  if(!isDefined(self.melee.weapon) || (self.melee.weapon == "none")) {
    return;
  }

  self forceUseWeapon(self.melee.weapon, self.melee.weaponSlot);

  if(isDefined(self.melee.droppedWeaponEnt)) {
    self.melee.droppedWeaponEnt delete();
    self.melee.droppedWeaponEnt = undefined;
  }
}

Melee_DroppedWeaponMonitorThread() {
  self endon("killanimscript");
  self endon("end_melee");
  assert(isDefined(self.melee));

  self waittill("weapon_dropped", droppedWeapon);

  if(isDefined(droppedWeapon)) {
    assert(isDefined(self.melee));
    self.melee.droppedWeaponEnt = droppedWeapon;
  }
}

Melee_PartnerEndedMeleeMonitorThread_ShouldAnimSurvive() {
  assert(isDefined(self));
  assert(isDefined(self.melee));

  if(!isDefined(self.melee.surviveAnimName)) {
    return false;
  }

  if(!isDefined(self.melee.surviveAnimAllowed)) {
    return false;
  }

  return true;
}

Melee_PartnerEndedMeleeMonitorThread() {
  self endon("killanimscript");
  self endon("end_melee");
  assert(isDefined(self.melee));

  self waittill("partner_end_melee");

  if(isDefined(self.melee.death)) {
    if(isDefined(self.melee.animatedDeath) || isDefined(self.melee.interruptDeath)) {
      self kill();
    } else {
      self.melee.death = undefined;

      if(Melee_PartnerEndedMeleeMonitorThread_ShouldAnimSurvive()) {
        assert(animHasNotetrack(self.melee.animName, NOTETRACK_DEATH));
        self.melee.survive = true;
      } else {
        self notify("end_melee");
      }
    }
  } else {
    if(!isDefined(self.melee.unsyncHappened)) {
      self notify("end_melee");
    }
  }
}

Melee_Unlink() {
  assert(isDefined(self));
  assert(isDefined(self.melee));

  if(!isDefined(self.melee.linked)) {
    return;
  }

  if(isDefined(self.syncedMeleeTarget)) {
    self.syncedMeleeTarget Melee_UnlinkInternal();
  }

  self Melee_UnlinkInternal();
}

Melee_UnlinkInternal() {
  assert(isDefined(self));

  self unlink();
  self.syncedMeleeTarget = undefined;

  if(!isAlive(self)) {
    return;
  }
  assert(isDefined(self.melee));
  assert(isDefined(self.melee.linked));
  self.melee.linked = undefined;

  self animMode("zonly_physics");
  self orientMode("face angle", self.angles[1]);
}

Melee_HandleNoteTracks_Unsync() {
  assert(isDefined(self));
  assert(isDefined(self.melee));

  self Melee_Unlink();

  self.melee.unsyncHappened = true;
  if(isDefined(self.melee.partner) && isDefined(self.melee.partner.melee)) {
    self.melee.partner.melee.unsyncHappened = true;
  }
}

Melee_HandleNoteTracks_ShouldDieAfterUnsync() {
  assert(isDefined(self));
  assert(isDefined(self.melee));

  if(animHasNotetrack(self.melee.animName, NOTETRACK_DEATH)) {
    assert(isDefined(self.melee.surviveAnimName));
    return false;
  }

  return isDefined(self.melee.death);
}

Melee_HandleNoteTracks_Death(interruptAnimation) {
  assert(isDefined(self));
  assert(isDefined(self.melee));
  assert(isDefined(self.melee.death));

  if(isDefined(interruptAnimation) && interruptAnimation) {
    self.melee.interruptDeath = true;
  } else {
    self.melee.animatedDeath = true;
  }
}

Melee_HandleNoteTracks(note) {
  if(isSubStr(note, "ps_")) {
    alias = GetSubStr(note, 3);
    self playSound(alias);
    return;
  }

  if(note == NOTETRACK_SYNC) {
    if(isDefined(self.melee.syncNoteTrackEnt)) {
      self Melee_AIvsAI_TargetLink(self.melee.syncNoteTrackEnt);
      self.melee.syncNoteTrackEnt = undefined;
    }
  } else if(note == NOTETRACK_UNSYNC) {
    self Melee_HandleNoteTracks_Unsync();

    if(Melee_HandleNoteTracks_ShouldDieAfterUnsync()) {
      Melee_HandleNoteTracks_Death();
    }
  } else if(note == NOTETRACK_INTERACT) {
    self.melee.surviveAnimAllowed = true;
  } else if(note == NOTETRACK_DEATH) {
    if(isDefined(self.melee.survive)) {
      assert(!isDefined(self.melee.death));
      assert(isDefined(self.melee.surviveAnimName));

      return note;
    }

    assert(isDefined(self.melee.death));
    Melee_HandleNoteTracks_Death();

    if(isDefined(self.melee.animatedDeath)) {
      return note;
    }
  } else if(note == NOTETRACK_ATTACHKNIFE) {
    self attach(KNIFE_ATTACK_MODEL, KNIFE_ATTACK_TAG, true);
    self.melee.hasKnife = true;
  } else if(note == NOTETRACK_DETACTKNIFE) {
    self detach(KNIFE_ATTACK_MODEL, KNIFE_ATTACK_TAG, true);
    self.melee.hasKnife = undefined;
  } else if(note == NOTETRACK_STAB) {
    assert(isDefined(self.melee.hasKnife));

    self playSound(KNIFE_ATTACK_SOUND);
    playFXOnTag(level._effect[KNIFE_ATTACK_FX_NAME], self, KNIFE_ATTACK_FX_TAG);

    if(isDefined(self.melee.partner) && isDefined(self.melee.partner.melee)) {
      self.melee.partner Melee_HandleNoteTracks_Death(true);
    }
  }
}

Melee_DeathHandler_Regular() {
  self endon("end_melee");
  self animscripts\shared::DropAllAIWeapons();
  return false;
}

Melee_DeathHandler_Delayed() {
  self endon("end_melee");
  self animscripts\shared::DoNoteTracksWithTimeout("meleeAnim", 10.0);
  self animscripts\shared::DropAllAIWeapons();
  self startRagdoll();

  return true;
}

Melee_EndScript_CheckDeath() {
  assert(isDefined(self));
  assert(isDefined(self.melee));

  if(!isAlive(self) && isDefined(self.melee.death)) {
    if(isDefined(self.melee.animatedDeath)) {
      self.deathFunction = ::Melee_DeathHandler_Delayed;
    } else {
      self.deathFunction = ::Melee_DeathHandler_Regular;
    }
  }
}

Melee_EndScript_CheckPositionAndMovement() {
  assert(isDefined(self));
  assert(isDefined(self.melee));

  if(!isAlive(self)) {
    return;
  }

  if(isDefined(self.melee.playingMovementAnim)) {
    Melee_StopMovement();
  }

  newOrigin = self getDropToFloorPosition();
  if(isDefined(newOrigin)) {
    self forceTeleport(newOrigin, self.angles);
  } else {
    println("Warning: Melee animation might have ended up in solid for entity #" + self getentnum());
  }
}

Melee_EndScript_CheckWeapon() {
  assert(isDefined(self));
  assert(isDefined(self.melee));

  if(isDefined(self.melee.hasKnife)) {
    self detach(KNIFE_ATTACK_MODEL, KNIFE_ATTACK_TAG, true);
  }

  if(isAlive(self)) {
    Melee_DroppedWeaponRestore();
  }
}

Melee_EndScript_CheckStateChanges() {
  assert(isDefined(self));
  assert(isDefined(self.melee));

  if(isDefined(self.melee.wasAllowingPain)) {
    if(self.melee.wasAllowingPain) {
      self enable_pain();
    } else {
      self disable_pain();
    }
  }

  if(isDefined(self.melee.wasFlashbangImmune)) {
    self setFlashbangImmunity(self.melee.wasFlashbangImmune);
  }
}

Melee_EndScript() {
  assert(isDefined(self));
  assert(isDefined(self.melee));

  self Melee_Unlink();
  self Melee_EndScript_CheckDeath();
  self Melee_EndScript_CheckPositionAndMovement();
  self Melee_EndScript_CheckWeapon();
  self Melee_EndScript_CheckStateChanges();

  if(isDefined(self.melee.partner)) {
    self.melee.partner notify("partner_end_melee");
  }

  self Melee_ReleaseMutex(self.melee.target);
}

Melee_AcquireMutex(target) {
  assert(isDefined(self));
  assert(isDefined(target));

  if(isDefined(self.melee)) {
    return false;
  }

  if(isDefined(target.melee)) {
    return false;
  }

  self.melee = spawnStruct();
  target.melee = spawnStruct();

  return true;
}

Melee_ReleaseMutex(target) {
  assert(isDefined(self));
  self.melee = undefined;

  if(isDefined(target)) {
    target.melee = undefined;
  }
}