/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: animscripts\shoot_behavior.gsc
********************************************************/

#include common_scripts\utility;
#include animscripts\combat_utility;
#include animscripts\utility;
#include animscripts\shared;

decideWhatAndHowToShoot(objective) {
  self endon("killanimscript");
  self notify("stop_deciding_how_to_shoot");
  self endon("stop_deciding_how_to_shoot");
  self endon("death");

  assert(isDefined(objective));

  maps\_gameskill::resetMissTime();
  self.shootObjective = objective;

  self.shootPos = undefined;
  self.shootStyle = "none";
  self.fastBurst = false;
  self.shouldReturnToCover = undefined;

  if(!isDefined(self.changingCoverPos)) {
    self.changingCoverPos = false;
  }

  atCover = isDefined(self.coverNode) && self.coverNode.type != "Cover Prone" && self.coverNode.type != "Conceal Prone";

  if(atCover) {
    wait .05;
  }

  prevShootEnt = self.shootEnt;
  prevShootPos = self.shootPos;
  prevShootStyle = self.shootStyle;

  if(!isDefined(self.has_no_ir)) {
    self.a.laserOn = true;
    self animscripts\shared::updateLaserStatus();
  }

  if(self isSniper()) {
    self resetSniperAim();
  }

  if(atCover && (!self.a.atConcealmentNode || !self canSeeEnemy())) {
    thread watchForIncomingFire();
  }
  thread runOnShootBehaviorEnd();

  self.ambushEndTime = undefined;

  prof_begin("decideWhatAndHowToShoot");

  while(1) {
    if(isDefined(self.shootPosOverride)) {
      if(!isDefined(self.enemy)) {
        self.shootPos = self.shootPosOverride;
        self.shootPosOverride = undefined;
        WaitABit();
      } else {
        self.shootPosOverride = undefined;
      }
    }

    assert(self.shootObjective == "normal" || self.shootObjective == "suppress" || self.shootObjective == "ambush");
    assert(!isDefined(self.shootEnt) || isDefined(self.shootPos));

    result = undefined;
    if(self.weapon == "none") {
      noGunShoot();
    } else if(usingRocketLauncher()) {
      result = rpgShoot();
    } else if(usingSidearm()) {
      result = pistolShoot();
    } else {
      result = rifleShoot();
    }

    if(isDefined(self.a.specialShootBehavior)) {
      [[self.a.specialShootBehavior]]();
    }

    if(checkChanged(prevShootEnt, self.shootEnt) || (!isDefined(self.shootEnt) && checkChanged(prevShootPos, self.shootPos)) || checkChanged(prevShootStyle, self.shootStyle)) {
      self notify("shoot_behavior_change");
    }
    prevShootEnt = self.shootEnt;
    prevShootPos = self.shootPos;
    prevShootStyle = self.shootStyle;

    if(!isDefined(result)) {
      WaitABit();
    }
  }

  prof_end("decideWhatAndHowToShoot");
}

WaitABit() {
  self endon("enemy");
  self endon("done_changing_cover_pos");
  self endon("weapon_position_change");
  self endon("enemy_visible");

  if(isDefined(self.shootEnt)) {
    self.shootEnt endon("death");

    self endon("do_slow_things");

    wait .05;
    while(isDefined(self.shootEnt)) {
      self.shootPos = self.shootEnt getShootAtPos();
      wait .05;
    }
  } else {
    self waittill("do_slow_things");
  }
}

noGunShoot() {
  println("^1Warning: AI at " + self.origin + ", entnum " + self getEntNum() + ", export " + self.export+" trying to shoot but has no gun");

  self.shootEnt = undefined;
  self.shootPos = undefined;
  self.shootStyle = "none";
  self.shootObjective = "normal";
}

shouldSuppress() {
  return !self isSniper() && !isShotgun(self.weapon);
}

shouldShootEnemyEnt() {
  assert(isDefined(self));

  if(!self canSeeEnemy()) {
    return false;
  }

  if(!isDefined(self.coverNode) && !self canShootEnemy()) {
    return false;
  }

  return true;
}

rifleShootObjectiveNormal() {
  if(!shouldShootEnemyEnt()) {
    if(self isSniper()) {
      self resetSniperAim();
    }

    if(self.doingAmbush) {
      self.shootObjective = "ambush";
      return "retry";
    }

    if(!isDefined(self.enemy)) {
      haveNothingToShoot();
    } else {
      markEnemyPosInvisible();

      if((self.provideCoveringFire || randomint(5) > 0) && shouldSuppress()) {
        self.shootObjective = "suppress";
      } else {
        self.shootObjective = "ambush";
      }
      return "retry";
    }
  } else {
    setShootEntToEnemy();
    self setShootStyleForVisibleEnemy();
  }
}

rifleShootObjectiveSuppress(enemySuppressable) {
  if(!enemySuppressable) {
    haveNothingToShoot();
  } else {
    self.shootEnt = undefined;
    self.shootPos = getEnemySightPos();

    self setShootStyleForSuppression();
  }
}

rifleShootObjectiveAmbush(enemySuppressable) {
  assert(self.shootObjective == "ambush");

  self.shootStyle = "none";
  self.shootEnt = undefined;

  if(!enemySuppressable) {
    getAmbushShootPos();

    if(shouldStopAmbushing()) {
      self.ambushEndTime = undefined;
      self notify("return_to_cover");
      self.shouldReturnToCover = true;
    }
  } else {
    self.shootPos = getEnemySightPos();

    if(self shouldStopAmbushing()) {
      self.ambushEndTime = undefined;

      if(shouldSuppress()) {
        self.shootObjective = "suppress";
      }

      if(randomint(3) == 0) {
        self notify("return_to_cover");
        self.shouldReturnToCover = true;
      }
      return "retry";
    }
  }
}

getAmbushShootPos() {
  if(isDefined(self.enemy) && self cansee(self.enemy)) {
    setShootEntToEnemy();
    return;
  }

  likelyEnemyDir = self getAnglesToLikelyEnemyPath();

  if(!isDefined(likelyEnemyDir)) {
    if(isDefined(self.coverNode)) {
      likelyEnemyDir = self.coverNode.angles;
    } else if(isDefined(self.ambushNode)) {
      likelyEnemyDir = self.ambushNode.angles;
    } else if(isDefined(self.enemy)) {
      likelyEnemyDir = vectorToAngles(self lastKnownPos(self.enemy) - self.origin);
    } else {
      likelyEnemyDir = self.angles;
    }
  }

  dist = 1024;
  if(isDefined(self.enemy)) {
    dist = distance(self.origin, self.enemy.origin);
  }

  newShootPos = self getEye() + anglesToForward(likelyEnemyDir) * dist;

  if(!isDefined(self.shootPos) || distanceSquared(newShootPos, self.shootPos) > 5 * 5) {
    self.shootPos = newShootPos;
  }
}

rifleShoot() {
  if(self.shootObjective == "normal") {
    rifleShootObjectiveNormal();
  } else {
    if(shouldShootEnemyEnt()) {
      self.shootObjective = "normal";
      self.ambushEndTime = undefined;
      return "retry";
    }

    markEnemyPosInvisible();

    if(self isSniper()) {
      self resetSniperAim();
    }

    enemySuppressable = canSuppressEnemy();

    if(self.shootObjective == "suppress" || (self.team == "allies" && !isDefined(self.enemy) && !enemySuppressable)) {
      rifleShootObjectiveSuppress(enemySuppressable);
    } else {
      rifleShootObjectiveAmbush(enemySuppressable);
    }
  }
}

shouldStopAmbushing() {
  if(!isDefined(self.ambushEndTime)) {
    if(self isBadGuy()) {
      self.ambushEndTime = gettime() + randomintrange(10000, 60000);
    } else {
      self.ambushEndTime = gettime() + randomintrange(4000, 10000);
    }
  }
  return self.ambushEndTime < gettime();
}

rpgShoot() {
  if(!shouldShootEnemyEnt()) {
    markEnemyPosInvisible();

    haveNothingToShoot();
    return;
  }

  setShootEntToEnemy();
  self.shootStyle = "single";

  distSqToShootPos = lengthsquared(self.origin - self.shootPos);

  if(distSqToShootPos < squared(512)) {
    self notify("return_to_cover");
    self.shouldReturnToCover = true;
    return;
  }
}

pistolShoot() {
  if(self.shootObjective == "normal") {
    if(!shouldShootEnemyEnt()) {
      if(!isDefined(self.enemy)) {
        haveNothingToShoot();
        return;
      } else {
        markEnemyPosInvisible();

        self.shootObjective = "ambush";
        return "retry";
      }
    } else {
      setShootEntToEnemy();
      self.shootStyle = "single";
    }
  } else {
    if(shouldShootEnemyEnt()) {
      self.shootObjective = "normal";
      self.ambushEndTime = undefined;
      return "retry";
    }

    markEnemyPosInvisible();

    self.shootEnt = undefined;
    self.shootStyle = "none";
    self.shootPos = getEnemySightPos();

    if(!isDefined(self.ambushEndTime)) {
      self.ambushEndTime = gettime() + randomintrange(4000, 8000);
    }

    if(self.ambushEndTime < gettime()) {
      self.shootObjective = "normal";
      self.ambushEndTime = undefined;
      return "retry";
    }
  }
}

markEnemyPosInvisible() {
  if(isDefined(self.enemy) && !self.changingCoverPos && self.script != "combat") {
    if(isAI(self.enemy) && isDefined(self.enemy.script) && (self.enemy.script == "cover_stand" || self.enemy.script == "cover_crouch")) {
      if(isDefined(self.enemy.a.coverMode) && self.enemy.a.coverMode == "hide") {
        return;
      }
    }

    self.couldntSeeEnemyPos = self.enemy.origin;
  }
}

watchForIncomingFire() {
  self endon("killanimscript");
  self endon("stop_deciding_how_to_shoot");

  while(1) {
    self waittill("suppression");

    if(self.suppressionMeter > self.suppressionThreshold) {
      if(self readyToReturnToCover()) {
        self notify("return_to_cover");
        self.shouldReturnToCover = true;
      }
    }
  }
}

readyToReturnToCover() {
  if(self.changingCoverPos) {
    return false;
  }

  assert(isDefined(self.coverPosEstablishedTime));

  if(!isDefined(self.enemy) || !self canSee(self.enemy)) {
    return true;
  }

  if(gettime() < self.coverPosEstablishedTime + 800) {
    return false;
  }

  if(isPlayer(self.enemy) && self.enemy.health < self.enemy.maxHealth * .5) {
    if(gettime() < self.coverPosEstablishedTime + 3000) {
      return false;
    }
  }

  return true;
}

runOnShootBehaviorEnd() {
  self endon("death");

  self waittill_any("killanimscript", "stop_deciding_how_to_shoot");

  self.a.laserOn = false;
  self animscripts\shared::updateLaserStatus();
}

checkChanged(prevval, newval) {
  if(isDefined(prevval) != isDefined(newval)) {
    return true;
  }
  if(!isDefined(newval)) {
    assert(!isDefined(prevval));
    return false;
  }
  return prevval != newval;
}

setShootEntToEnemy() {
  self.shootEnt = self.enemy;
  self.shootPos = self.shootEnt getShootAtPos();
}

haveNothingToShoot() {
  self.shootEnt = undefined;
  self.shootPos = undefined;
  self.shootStyle = "none";

  if(self.doingAmbush) {
    self.shootObjective = "ambush";
  }

  if(!self.changingCoverPos) {
    self notify("return_to_cover");
    self.shouldReturnToCover = true;
  }
}

shouldBeAJerk() {
  return level.gameskill == 3 && isPlayer(self.enemy);
}

fullAutoRangeSq = 250 * 250;
burstRangeSq = 900 * 900;
singleShotRangeSq = 1600 * 1600;

setShootStyleForVisibleEnemy() {
  assert(isDefined(self.shootPos));
  assert(isDefined(self.shootEnt));

  if(isDefined(self.shootEnt.enemy) && isDefined(self.shootEnt.enemy.syncedMeleeTarget)) {
    return setShootStyle("single", false);
  }

  if(self isSniper()) {
    return setShootStyle("single", false);
  }

  if(isShotgun(self.weapon)) {
    if(weapon_pump_action_shotgun()) {
      return setShootStyle("single", false);
    } else {
      return setShootStyle("semi", false);
    }
  }

  if(weaponBurstCount(self.weapon) > 0) {
    return setShootStyle("burst", false);
  }

  distanceSq = distanceSquared(self getShootAtPos(), self.shootPos);

  isMG = weaponClass(self.weapon) == "mg";

  if(self.provideCoveringFire && isMG) {
    return setShootStyle("full", false);
  }

  if(distanceSq < fullAutoRangeSq) {
    if(isDefined(self.shootEnt) && isDefined(self.shootEnt.magic_bullet_shield)) {
      return setShootStyle("single", false);
    } else {
      return setShootStyle("full", false);
    }
  } else if(distanceSq < burstRangeSq || shouldBeAJerk()) {
    if(weaponIsSemiAuto(self.weapon) || shouldDoSemiForVariety()) {
      return setShootStyle("semi", true);
    } else {
      return setShootStyle("burst", true);
    }
  } else if(self.provideCoveringFire || isMG || distanceSq < singleShotRangeSq) {
    if(shouldDoSemiForVariety()) {
      return setShootStyle("semi", false);
    } else {
      return setShootStyle("burst", false);
    }
  }

  return setShootStyle("single", false);
}

setShootStyleForSuppression() {
  assert(isDefined(self.shootPos));

  distanceSq = distanceSquared(self getShootAtPos(), self.shootPos);

  assert(!self isSniper());
  assert(!isShotgun(self.weapon));

  if(weaponIsSemiAuto(self.weapon)) {
    if(distanceSq < singleShotRangeSq) {
      return setShootStyle("semi", false);
    }
    return setShootStyle("single", false);
  }

  if(weaponClass(self.weapon) == "mg") {
    return setShootStyle("full", false);
  }

  if(self.provideCoveringFire || distanceSq < singleShotRangeSq) {
    if(shouldDoSemiForVariety()) {
      return setShootStyle("semi", false);
    } else {
      return setShootStyle("burst", false);
    }
  }

  return setShootStyle("single", false);
}

setShootStyle(style, fastBurst) {
  self.shootStyle = style;
  self.fastBurst = fastBurst;
}

shouldDoSemiForVariety() {
  if(weaponClass(self.weapon) != "rifle") {
    return false;
  }

  if(self.team != "allies") {
    return false;
  }

  changeFrequency = safemod(int(self.origin[1]), 10000) + 2000;
  fakeTimeValue = int(self.origin[0]) + gettime();

  return fakeTimeValue % (2 * changeFrequency) > changeFrequency;
}

resetSniperAim() {
  assert(self isSniper());
  self.sniperShotCount = 0;
  self.sniperHitCount = 0;

  thread sniper_glint_behavior();
}

sniper_glint_behavior() {
  self endon("killanimscript");
  self endon("enemy");
  self endon("return_to_cover");
  self notify("new_glint_thread");
  self endon("new_glint_thread");

  assertex(self isSniper(), "Not a sniper!");
  if(!isDefined(level._effect["sniper_glint"])) {
    println("^3Warning, sniper glint is not setup for sniper with classname " + self.classname);
    return;
  }

  if(!isAlive(self.enemy)) {
    return;
  }

  fx = getfx("sniper_glint");

  wait 0.2;

  for(;;) {
    if(self.weapon == self.primaryweapon && player_sees_my_scope()) {
      if(distanceSquared(self.origin, self.enemy.origin) > 256 * 256) {
        playFXOnTag(fx, self, "tag_flash");
      }

      timer = randomfloatrange(3, 5);
      wait(timer);
    }
    wait(0.2);
  }
}