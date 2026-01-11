/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\melee.gsc
*****************************************************/

#include animscripts\Utility;
#include animscripts\SetPoseMovement;
#include animscripts\Combat_Utility;
#include common_scripts\Utility;
#include maps\_utility;
#using_animtree("generic_human");

zombMeleeMonitor() {
  level.numZombsMeleeThisFrame = 0;
  while(1) {
    wait_network_frame();
    level.numZombsMeleeThisFrame = 0;
  }
}

MeleeCombat() {
  self endon("killanimscript");
  self notify("melee");
  assert(CanMeleeAnyRange());
  doingAiMelee = false;
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
  MeleeDebugPrint("Melee begin");
  self animMode("zonly_physics");
  resetGiveUpTime();
  for(;;) {
    if(!PrepareToMelee()) {
      self.lastMeleeGiveUpTime = gettime();
      break;
    }
    if(!self is_zombie()) {
      assert(self.a.pose == "stand");
    }
    MeleeDebugPrint("Melee main loop" + randomint(100));
    if(!realMelee && animscripts\utility::okToMelee(self.enemy)) {
      realMelee = true;
      animscripts\utility::IAmMeleeing(self.enemy);
    }
    self thread EyesAtEnemy();
    self animscripts\battleChatter_ai::evaluateMeleeEvent();
    if(self is_zombie()) {
      if(isDefined(self.enemy)) {
        angles = VectorToAngles(self.enemy.origin - self.origin);
        self OrientMode("face angle", angles[1]);
      }
    } else {
      self OrientMode("face current");
    }
    if(self is_zombie()) {
      if(!isDefined(level.numZombsMeleeThisFrame)) {
        level thread zombMeleeMonitor();
      }
      while(level.numZombsMeleeThisFrame > 2) {
        wait_network_frame();
      }
      self animscripts\face::SaySpecificDialogue(undefined, "attack_vocals", 1);
      zombie_attack = pick_zombie_melee_anim(self);
      self setflaggedanimknoballrestart("meleeanim", zombie_attack, % body, 1, .2, 1);
      level.numZombsMeleeThisFrame++;
    } else if(self maps\_bayonet::has_bayonet() && RandomInt(100) < 0) {
      self setflaggedanimknoballrestart("meleeanim", % ai_bayonet_stab_melee, % body, 1, .2, 1);
    } else {
      self setflaggedanimknoballrestart("meleeanim", % melee_1, % body, 1, .2, 1);
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
  self animMode("none");
  self thread animscripts\combat::main();
  self notify("stop EyesAtEnemy");
  self notify("stop_melee_debug_print");
  scriptChange();
}

resetGiveUpTime() {
  if(distanceSquared(self.origin, self.enemy.origin) > anim.chargeRangeSq) {
    self.giveUpOnMeleeTime = gettime() + randomintrange(2700, 3300);
  } else {
    self.giveUpOnMeleeTime = gettime() + randomintrange(1700, 2300);
  }
}

MeleeDebugPrint(text) {
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
    print3d(self.origin + (0, 0, 60), self.meleedebugprint, (1, 1, 1), 1, .1);
    wait .05;
  }
}

getEnemyPose() {
  if(isplayer(self.enemy)) {
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
  if(!isSentient(self.enemy)) {
    return false;
  }
  if(!isAlive(self.enemy)) {
    return false;
  }
  if(isDefined(self.disableMelee)) {
    assert(self.disableMelee);
    return false;
  }
  if(self.a.pose != "stand" && !is_zombie()) {
    return false;
  }
  if(!self is_zombie()) {
    enemypose = getEnemyPose();
    if(enemypose != "stand" && enemypose != "crouch") {
      if(!(self is_banzai() && enemypose == "prone")) {
        return false;
      }
    }
  }
  enemyPoint = self.enemy GetOrigin();
  vecToEnemy = enemyPoint - self.origin;
  self.enemyDistanceSq = lengthSquared(vecToEnemy);
  if(self.enemyDistanceSq > 25) {
    yaw = abs(getYawToEnemy());
    if((yaw > 60 && state != "already started") || yaw > 110) {
      return false;
    }
  }
  nearest_enemy_sqrd_dist = self GetClosestEnemySqDist();
  epsilon = 0.1;
  if(nearest_enemy_sqrd_dist - epsilon > self.enemyDistanceSq) {
    return false;
  }
  doingAIMelee = false;
  if(doingAIMelee) {
    if(!animscripts\utility::okToMelee(self.enemy)) {
      return false;
    }
    if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield && isDefined(self.enemy.magic_bullet_shield) && self.enemy.magic_bullet_shield) {
      return false;
    }
    if(!isMeleePathClear(vecToEnemy, enemyPoint)) {
      return false;
    }
  } else {
    if(isDefined(self.enemy.magic_bullet_shield) && self.enemy.magic_bullet_shield) {
      if(!(self is_banzai())) {
        return false;
      }
    }
    if(self.enemyDistanceSq <= anim.meleeRangeSq) {
      if(!isMeleePathClear(vecToEnemy, enemyPoint)) {
        if(!self is_banzai() && !self is_zombie()) {
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
        return false;
      }
    }
    if(state == "already started") {
      return false;
    }
    if((!self is_banzai() || IsPlayer(self.enemy)) && isDefined(self.lastMeleeGiveUpTime) && gettime() - self.lastMeleeGiveUpTime < 3000) {
      return false;
    }
    if(!animscripts\utility::okToMelee(self.enemy)) {
      return false;
    }
    if(self.enemy animscripts\banzai::in_banzai_attack()) {
      return false;
    }
    if(self animscripts\banzai::in_banzai_attack()) {
      return false;
    }
    if(!self is_zombie() && !isMeleePathClear(vecToEnemy, enemyPoint)) {
      return false;
    }
  }
  return true;
}

isMeleePathClear(vecToEnemy, enemyPoint) {
  dirToEnemy = vectorNormalize((vecToEnemy[0], vecToEnemy[1], 0));
  meleePoint = enemyPoint - (dirToEnemy[0] * 32, dirToEnemy[1] * 32, 0);
  if(!self isInGoal(meleePoint)) {
    return false;
  }
  return self maymovetopoint(meleePoint);
}

PrepareToMelee() {
  if(self is_zombie()) {
    return true;
  }
  if(!CanMeleeAnyRange()) {
    return false;
  }
  if(self.enemyDistanceSq <= anim.meleeRangeSq) {
    self SetFlaggedAnimKnobAll("readyanim", % stand_2_melee_1, % body, 1, .3, 1);
    self animscripts\shared::DoNoteTracks("readyanim");
    return true;
  }
  self PlayMeleeSound();
  prevEnemyPos = self.enemy.origin;
  sampleTime = 0.1;
  raiseGunAnimTravelDist = length(getmovedelta( % run_2_melee_charge, 0, 1));
  meleeAnimTravelDist = 32;
  shouldRaiseGunDist = anim.meleeRange * 0.75 + meleeAnimTravelDist + raiseGunAnimTravelDist;
  shouldRaiseGunDistSq = shouldRaiseGunDist * shouldRaiseGunDist;
  shouldMeleeDist = anim.meleeRange + meleeAnimTravelDist;
  shouldMeleeDistSq = shouldMeleeDist * shouldMeleeDist;
  raiseGunFullDuration = getanimlength( % run_2_melee_charge) * 1000;
  raiseGunFinishDuration = raiseGunFullDuration - 100;
  raiseGunPredictDuration = raiseGunFullDuration - 200;
  raiseGunStartTime = 0;
  predictedEnemyDistSqAfterRaiseGun = undefined;
  runAnim = % run_lowready_F;
  self SetFlaggedAnimKnobAll("chargeanim", runAnim, % body, 1, .3, 1);
  raisingGun = false;
  while(1) {
    MeleeDebugPrint("PrepareToMelee loop" + randomint(100));
    time = gettime();
    willBeWithinRangeWhenGunIsRaised = (isDefined(predictedEnemyDistSqAfterRaiseGun) && predictedEnemyDistSqAfterRaiseGun <= shouldRaiseGunDistSq);
    if(!raisingGun) {
      if(willBeWithinRangeWhenGunIsRaised) {
        self SetFlaggedAnimKnobAllRestart("chargeanim", % run_2_melee_charge, % body, 1, .2, 1);
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
    enemyVel = vectorScale(self.enemy.origin - prevEnemyPos, 1 / (gettime() - time));
    prevEnemyPos = self.enemy.origin;
    predictedEnemyPosAfterRaiseGun = self.enemy.origin + vectorScale(enemyVel, raiseGunPredictDuration);
    predictedEnemyDistSqAfterRaiseGun = distanceSquared(self.origin, predictedEnemyPosAfterRaiseGun);
    if(raisingGun && self.enemyDistanceSq <= shouldMeleeDistSq && gettime() - raiseGunStartTime >= raiseGunFinishDuration) {
      break;
    }
    if(!raisingGun && gettime() >= self.giveUpOnMeleeTime) {
      return false;
    }
  }
  return true;
}

PlayMeleeSound() {
  if(!isDefined(self.a.nextMeleeChargeSound)) {
    self.a.nextMeleeChargeSound = 0;
  }
  if(gettime() > self.a.nextMeleeChargeSound) {
    self animscripts\face::SaySpecificDialogue(undefined, "play_grunt_" + self.voice, 0.3);
    self.a.nextMeleeChargeSound = gettime() + 8000;
  }
}

AiVsAiMeleeCombat() {
  self endon("killanimscript");
  self notify("melee");
  self OrientMode("face enemy");
  self ClearAnim( % root, 0.3);
  IWin = (randomint(10) < 8);
  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield) {
    IWin = true;
  }
  if(isDefined(self.enemy.magic_bullet_shield) && self.enemy.magic_bullet_shield) {
    IWin = false;
  }
  winAnim = % bog_melee_R_attack;
  loseAnim = % bog_melee_R_defend;
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
  giveUpTime = gettime() + 2500;
  self setAnimKnobAll( % run_lowready_F, % body, 1, 0.2);
  while(distanceSquared(self.origin, self.enemy.origin) > desiredDistSqrd && gettime() < giveUpTime) {
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
  self orientMode("face angle", vectorToAngles(partnerDir)[1]);
  self animMode("zonly_physics");
  self setFlaggedAnimKnobAllRestart("meleeAnim", myAnim, % body, 1, 0.2);
  self animscripts\shared::DoNoteTracks("meleeAnim");
  self notify("end_melee");
}

endMeleeOnKillanimscript() {
  self endon("end_melee");
  self waittill("killanimscript");
  self.meleePartner notify("end_melee");
}

meleeLink() {
  self linkto(self.meleePartner);
  self waittill("end_melee");
  self unlink();
}

pick_zombie_melee_anim(zombie_guy) {
  melee_anim = undefined;
  if(zombie_guy.has_legs) {
    switch (zombie_guy.zombie_move_speed) {
      case "walk":
        anims = array_combine(level._zombie_melee, level._zombie_walk_melee);
        melee_anim = random(anims);
        break;
      case "run":
      case "sprint":
        anims = array_combine(level._zombie_melee, level._zombie_run_melee);
        melee_anim = random(anims);
        break;
    }
  } else if(zombie_guy.a.gib_ref == "no_legs") {
    melee_anim = random(level._zombie_stumpy_melee);
  } else {
    melee_anim = random(level._zombie_melee_crawl);
  }
  return melee_anim;
}