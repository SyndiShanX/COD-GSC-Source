/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\shoot_behavior.gsc
*****************************************************/

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
  self.shootEnt = undefined;
  self.shootPos = undefined;
  self.shootStyle = "none";
  self.fastBurst = false;
  self.shouldReturnToCover = false;
  if(!isDefined(self.changingCoverPos))
    self.changingCoverPos = false;
  atCover = isDefined(self.coverNode) && self.coverNode.type != "Cover Prone" && self.coverNode.type != "Conceal Prone";
  if(atCover) {
    wait .05;
  }
  prevShootEnt = self.shootEnt;
  prevShootPos = self.shootPos;
  prevShootStyle = self.shootStyle;
  if(self isSniper())
    self resetSniperAim(true);
  if(atCover && (!self.a.atConcealmentNode || !self canSeeEnemy()))
    thread watchForIncomingFire();
  thread runOnShootBehaviorEnd();
  self.ambushEndTime = undefined;
  prof_begin("decideWhatAndHowToShoot");
  while(1) {
    assert(self.shootObjective == "normal" || self.shootObjective == "suppress" || self.shootObjective == "ambush");
    assert(!isDefined(self.shootEnt) || isDefined(self.shootPos));
    result = undefined;
    if(self.weapon == "none")
      noGunShoot();
    else if(self weaponAnims() == "rocketlauncher")
      result = rpgShoot();
    else if(usingSidearm())
      result = pistolShoot();
    else if(weaponclass(self.weapon) == "spread") {
      result = shotgunshoot();
    } else if(WeaponClass(self.weapon) == "gas") {
      result = flamethrower_shoot();
    } else if(self is_zombie()) {
      WaitABit();
    } else {
      result = rifleShoot();
    }
    if(checkChanged(prevShootEnt, self.shootEnt) || (!isDefined(self.shootEnt) && checkChanged(prevShootPos, self.shootPos)) || checkChanged(prevShootStyle, self.shootStyle)) {
      self notify("shoot_behavior_change");
    }
    prevShootEnt = self.shootEnt;
    prevShootPos = self.shootPos;
    prevShootStyle = self.shootStyle;
    if(!isDefined(result))
      WaitABit();
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
  return !self isSniper() && !weapon_spread();
}

rifleShoot() {
  if(self.shootObjective == "normal") {
    if(!canSeeEnemy()) {
      if(self isSniper())
        self resetSniperAim();
      if(!isDefined(self.enemy)) {
        haveNothingToShoot();
      } else {
        markEnemyPosInvisible();
        if((self.provideCoveringFire || randomint(5) > 0) && shouldSuppress())
          self.shootObjective = "suppress";
        else
          self.shootObjective = "ambush";
        return "retry";
      }
    } else {
      setShootEnt(self.enemy);
      self setShootStyleForVisibleEnemy();
    }
  } else {
    if(canSeeEnemy()) {
      self.shootObjective = "normal";
      self.ambushEndTime = undefined;
      return "retry";
    }
    markEnemyPosInvisible();
    if(self isSniper())
      self resetSniperAim();
    if(!canSuppressEnemy()) {
      if(self.shootObjective == "suppress" || (self.team == "allies" && !isValidEnemy(self.enemy))) {
        haveNothingToShoot();
      } else {
        assert(self.shootObjective == "ambush");
        self.shootStyle = "none";
        likelyEnemyDir = self getAnglesToLikelyEnemyPath();
        if(!isDefined(likelyEnemyDir)) {
          if(isDefined(self.coverNode))
            likelyEnemyDir = self.coverNode.angles;
          else
            likelyEnemyDir = self.angles;
        }
        self.shootEnt = undefined;
        dist = 1024;
        if(isDefined(self.enemy))
          dist = distance(self.origin, self.enemy.origin);
        newShootPos = self getEye() + anglesToForward(likelyEnemyDir) * dist;
        if(!isDefined(self.shootPos) || distanceSquared(newShootPos, self.shootPos) > 5 * 5)
          self.shootPos = newShootPos;
        if(shouldStopAmbushing()) {
          self.ambushEndTime = undefined;
          self notify("return_to_cover");
          self.shouldReturnToCover = true;
        }
      }
    } else {
      self.shootEnt = undefined;
      self.shootPos = getEnemySightPos();
      if(self.shootObjective == "suppress") {
        self setShootStyleForSuppression();
      } else {
        assert(self.shootObjective == "ambush");
        self.shootStyle = "none";
        if(self shouldStopAmbushing()) {
          if(shouldSuppress())
            self.shootObjective = "suppress";
          self.ambushEndTime = undefined;
          if(randomint(3) == 0) {
            self notify("return_to_cover");
            self.shouldReturnToCover = true;
          }
          return "retry";
        }
      }
    }
  }
}

shouldStopAmbushing() {
  if(!isDefined(self.ambushEndTime)) {
    if(self.team == "axis")
      self.ambushEndTime = gettime() + randomintrange(40000, 60000);
    else
      self.ambushEndTime = gettime() + randomintrange(4000, 10000);
  }
  return self.ambushEndTime < gettime();
}

rpgShoot() {
  if(!canSeeEnemy()) {
    markEnemyPosInvisible();
    haveNothingToShoot();
    return;
  }
  setShootEnt(self.enemy);
  self.shootStyle = "single";
  distSqToShootPos = lengthsquared(self.origin - self.shootPos);
  if(distSqToShootPos < squared(512)) {
    self notify("return_to_cover");
    self.shouldReturnToCover = true;
    return;
  }
}

shotgunShoot() {
  if(!canSeeEnemy()) {
    haveNothingToShoot();
    return;
  }
  setShootEnt(self.enemy);
  self.shootStyle = "single";
}

flamethrower_shoot() {
  if(!canSeeEnemy()) {
    haveNothingToShoot();
    return;
  }
  setShootEnt(self.enemy);
  self.shootStyle = "full";
}

pistolShoot() {
  if(self.shootObjective == "normal") {
    if(!canSeeEnemy()) {
      if(!isDefined(self.enemy)) {
        haveNothingToShoot();
        return;
      } else {
        markEnemyPosInvisible();
        self.shootObjective = "ambush";
        return "retry";
      }
    } else {
      setShootEnt(self.enemy);
      self.shootStyle = "single";
    }
  } else {
    if(canSeeEnemy()) {
      self.shootObjective = "normal";
      self.ambushEndTime = undefined;
      return "retry";
    }
    markEnemyPosInvisible();
    if(canSuppressEnemy()) {
      self.shootEnt = undefined;
      self.shootPos = getEnemySightPos();
    }
    self.shootStyle = "none";
    if(!isDefined(self.ambushEndTime))
      self.ambushEndTime = gettime() + randomintrange(4000, 8000);
    if(self.ambushEndTime < gettime()) {
      self.shootObjective = "normal";
      self.ambushEndTime = undefined;
      return "retry";
    }
  }
}

markEnemyPosInvisible() {
  if(isDefined(self.enemy) && !self.changingCoverPos && self.a.script != "combat") {
    if(isAI(self.enemy) && isDefined(self.enemy.a.script) && (self.enemy.a.script == "cover_stand" || self.enemy.a.script == "cover_crouch")) {
      if(isDefined(self.enemy.a.coverMode) && self.enemy.a.coverMode == "hide")
        return;
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
  if(self.changingCoverPos)
    return false;
  assert(isDefined(self.coverPosEstablishedTime));
  if(!isValidEnemy(self.enemy) || !self canSee(self.enemy))
    return true;
  if(gettime() < self.coverPosEstablishedTime + 800) {
    return false;
  }
  if(isPlayer(self.enemy) && self.enemy.health < self.enemy.maxHealth * .5) {
    if(gettime() < self.coverPosEstablishedTime + 3000)
      return false;
  }
  return true;
}

runOnShootBehaviorEnd() {
  self endon("death");
  self waittill_any("killanimscript", "stop_deciding_how_to_shoot");
}

checkChanged(prevval, newval) {
  if(isDefined(prevval) != isDefined(newval))
    return true;
  if(!isDefined(newval)) {
    assert(!isDefined(prevval));
    return false;
  }
  return prevval != newval;
}

setShootEnt(ent) {
  self.shootEnt = ent;
  self.shootPos = self.shootEnt getShootAtPos();
}

haveNothingToShoot() {
  self.shootEnt = undefined;
  self.shootPos = undefined;
  self.shootStyle = "none";
  if(!self.changingCoverPos) {
    self notify("return_to_cover");
    self.shouldReturnToCover = true;
  }
}

shouldBeAJerk() {
  return level.gameskill == 3 && isPlayer(self.enemy);
}

setShootStyleForVisibleEnemy() {
  assert(isDefined(self.shootPos));
  assert(isDefined(self.shootEnt));
  if(isDefined(self.shootEnt.enemy) && isDefined(self.shootEnt.enemy.syncedMeleeTarget))
    return setShootStyle("single", false);
  if(self isSniper() || self weapon_spread())
    return setShootStyle("single", false);
  if(weaponClass(self.weapon) == "rifle") {
    return setShootStyle("single", false);
  }
  distanceSq = distanceSquared(self getShootAtPos(), self.shootPos);
  if(weaponIsSemiAuto(self.weapon)) {
    if(distanceSq < 1600 * 1600 || shouldBeAJerk())
      return setShootStyle("semi", false);
    return setShootStyle("single", false);
  }
  if(weaponClass(self.weapon) == "mg")
    return setShootStyle("full", false);
  if(distanceSq < 300 * 300) {
    if(isDefined(self.shootEnt) && isDefined(self.shootEnt.magic_bullet_shield))
      return setShootStyle("single", false);
    else
      return setShootStyle("full", false);
  } else if(distanceSq < 900 * 900 || shouldBeAJerk()) {
    return setShootStyle("burst", true);
  }
  if(self.provideCoveringFire || distanceSq < 1600 * 1600) {
    if(shouldDoSemiForVariety())
      return setShootStyle("semi", false);
    else
      return setShootStyle("burst", false);
  }
  return setShootStyle("single", false);
}

setShootStyleForSuppression() {
  assert(isDefined(self.shootPos));
  distanceSq = distanceSquared(self getShootAtPos(), self.shootPos);
  if(weaponClass(self.weapon) == "rifle") {
    return setShootStyle("single", false);
  }
  assert(!self isSniper());
  assert(!self weapon_spread());
  if(weaponIsSemiAuto(self.weapon)) {
    if(distanceSq < 1600 * 1600)
      return setShootStyle("semi", false);
    return setShootStyle("single", false);
  }
  if(weaponClass(self.weapon) == "mg")
    return setShootStyle("full", false);
  if(self.provideCoveringFire || distanceSq < 1300 * 1300) {
    if(shouldDoSemiForVariety())
      return setShootStyle("semi", false);
    else
      return setShootStyle("burst", false);
  }
  return setShootStyle("single", false);
}

setShootStyle(style, fastBurst) {
  self.shootStyle = style;
  self.fastBurst = fastBurst;
}

shouldDoSemiForVariety() {
  if(weaponClass(self.weapon) != "rifle")
    return false;
  if(self.team != "allies")
    return false;
  changeFrequency = safemod(int(self.origin[1]), 10000) + 2000;
  fakeTimeValue = int(self.origin[0]) + gettime();
  return fakeTimeValue % (2 * changeFrequency) > changeFrequency;
}

resetSniperAim(considerMissing) {
  assert(self isSniper());
  self.sniperShotCount = 0;
  self.sniperHitCount = 0;
  if(isDefined(considerMissing))
    self.lastMissedEnemy = undefined;
}