/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\combat_utility.gsc
******************************************/

#include animscripts\Utility;
#include animscripts\Debug;
#include animscripts\SetPoseMovement;
#include animscripts\anims;
#include common_scripts\utility;
#include maps\_gameskill;
#include maps\_utility;
#using_animtree("generic_human");

player_init() {}
EnemiesWithinStandingRange() {
  enemyDistanceSq = self MyGetEnemySqDist();
  return (enemyDistanceSq < anim.standRangeSq);
}
MyGetEnemySqDist() {
  dist = self GetClosestEnemySqDist();
  if(!isDefined(dist)) {
    dist = 100000000000;
  }
  return dist;
}
getTargetAngleOffset(target) {
  pos = self GetShootAtPos() + (0, 0, -3);
  dir = (pos[0] - target[0], pos[1] - target[1], pos[2] - target[2]);
  dir = VectorNormalize(dir);
  fact = dir[2] * -1;
  return fact;
}
getSniperBurstDelayTime() {
  return RandomFloatRange(anim.min_sniper_burst_delay_time, anim.max_sniper_burst_delay_time);
}
getRemainingBurstDelayTime() {
  timeSoFar = (GetTime() - self.a.lastShootTime) / 1000;
  delayTime = getBurstDelayTime();
  if(delayTime > timeSoFar) {
    return delayTime - timeSoFar;
  }
  return 0;
}
getBurstDelayTime() {
  if(self usingSidearm()) {
    return RandomFloatRange(.15, .55);
  } else if(self usingShotgun()) {
    return RandomFloatRange(1.0, 1.7);
  } else if(self isSniper()) {
    return getSniperBurstDelayTime();
  } else if(self.fastBurst) {
    return RandomFloatRange(.1, .35);
  } else if(self usingBoltActionWeapon()) {
    return RandomFloatRange(1.0, 1.5);
  } else if(self usingGrenadeLauncher()) {
    return RandomFloatRange(1.5, 2.0);
  } else if(is_rusher() && self.rusherType == "pistol") {
    return RandomFloatRange(.1, .3);
  } else {
    return RandomFloatRange(.4, .9);
  }
}
burstDelay() {
  if(self.bulletsInClip) {
    if(self.shootStyle == "full" && !self.fastBurst) {
      if(self.a.lastShootTime == GetTime()) {
        wait .05;
      }
      return;
    }
    delayTime = getRemainingBurstDelayTime();
    if(delayTime) {
      wait delayTime;
    }
  }
}
cheatAmmoIfNecessary() {
  assert(!self.bulletsInClip);
  if(!isDefined(self.enemy)) {
    return false;
  }
  if(self is_rusher()) {
    self.bulletsInClip = weaponClipSize(self.weapon);
    return true;
  }
  if(self.a.idleStrafing) {
    self.bulletsInClip = int(min(10, weaponClipSize(self.weapon)));
    self.nextCheatTime = GetTime() + 8000;
    return true;
  }
  if(self is_banzai()) {
    self.bulletsInClip = weaponClipSize(self.weapon);
    return true;
  }
  if(self.team == "allies") {
    return false;
  }
  if(!isPlayer(self.enemy)) {
    return false;
  }
  if(weaponClipSize(self.weapon) < 15) {
    return false;
  }
  if(flag("player_is_invulnerable")) {
    return false;
  }
  if(self weaponAnims() == "pistol") {
    return false;
  }
  if(self weaponAnims() == "rocketlauncher") {
    return false;
  }
  if(self weaponAnims() == "grenade") {
    return false;
  }
  if(isDefined(self.nextCheatTime) && GetTime() < self.nextCheatTime) {
    return false;
  }
  if(!self canSee(self.enemy)) {
    return false;
  }
  if(isDefined(self.cheatammo_override) && (self.cheatammo_override == true)) {
    return false;
  } else {
    self.bulletsInClip = 10;
  }
  if(self.bulletsInClip > weaponClipSize(self.weapon)) {
    self.bulletsInClip = weaponClipSize(self.weapon);
  }
  self.nextCheatTime = GetTime() + 8000;
  return true;
}
shootUntilShootBehaviorChange() {
  self endon("shoot_behavior_change");
  self endon("stopShooting");
  if(self weaponAnims() == "rocketlauncher" || self isSniper()) {
    players = GetPlayers();
    if(isDefined(players) && players.size > 0) {
      if(isDefined(self.enemy) && !isPlayer(self.enemy) && IsSentient(self.enemy)) {
        if(DistanceSquared(players[0].origin, self.enemy.origin) < 384 * 384) {
          self.enemy animscripts\battlechatter_ai::addThreatEvent("infantry", self, 1.0);
        }
      }
    }
    if(self weaponAnims() == "rocketlauncher" && IsSentient(self.enemy)) {
      wait(RandomFloat(2.0));
    }
  }
  if(isDefined(self.enemy) && DistanceSquared(self.origin, self.enemy.origin) > 400 * 400) {
    burstCount = RandomIntRange(1, 5);
  } else {
    burstCount = 10;
  }
  while(1) {
    burstDelay();
    animPrefix = getShootAnimPrefix();
    if(self.shootStyle == "full") {
      self FireUntilOutOfAmmo(animArray(animPrefix + "fire"), false, animscripts\shared::decideNumShotsForFull());
    } else if(self.shootStyle == "burst" || self.shootStyle == "single" || self.shootStyle == "semi") {
      numShots = 1;
      if(self.shootStyle == "burst" || self.shootStyle == "semi") {
        numShots = animscripts\shared::decideNumShotsForBurst();
      }
      if(numShots == 1) {
        self FireUntilOutOfAmmo(animArrayPickRandom(animPrefix + "single"), true, numShots);
      } else {
        self FireUntilOutOfAmmo(animArray(animPrefix + self.shootStyle + numShots), true, numShots);
      }
    } else {
      assert(self.shootStyle == "none");
      self waittill("hell freezes over");
    }
    if(!self.bulletsInClip) {
      break;
    }
    if(self usingBoltActionWeapon()) {
      break;
    }
    if(animscripts\shared::shouldSwitchWeapons()) {
      self notify("need_to_switch_weapons");
      break;
    }
    burstCount--;
    if(burstCount < 0) {
      self.shouldReturnToCover = true;
      break;
    }
  }
}
getUniqueFlagNameIndex() {
  anim.animFlagNameIndex++;
  return anim.animFlagNameIndex;
}
FireUntilOutOfAmmo(fireAnim, stopOnAnimationEnd, maxshots) {
  animName = "fireAnim_" + getUniqueFlagNameIndex();
  maps\_gameskill::resetMissTime();
  while(!aimedAtShootEntOrPos()) {
    wait .05;
  }
  self SetAnim(%add_fire, 1, .1, 1);
  rate = RandomFloatRange(0.3, 2.0);
  if(self.shootStyle == "full" || self.shootStyle == "burst") {
    rate = animscripts\weaponList::autoShootAnimRate();
    if(rate > 1.999) {
      rate = 1.999;
    }
  } else if(isDefined(self.shootEnt) && isDefined(self.shootEnt.magic_bullet_shield)) {
    rate = 0.25;
  } else if(is_rusher() && self.rusherType == "pistol") {
    rate = 2.0;
  }
  if(self usingBoltActionWeapon()) {
    rate = 1.0;
  } else if(self usingGasWeapon()) {
    rate = 1.0;
  } else if(self usingShotgun()) {
    rate = 1.0;
  } else if(self usingRocketLauncher()) {
    rate = 1.0;
  }
  self SetFlaggedAnimKnobRestart(animName, fireAnim, 1, .2, rate);
  self updatePlayerSightAccuracy();
  FireUntilOutOfAmmoInternal(animName, fireAnim, stopOnAnimationEnd, maxshots);
  self ClearAnim(%add_fire, .2);
}
FireUntilOutOfAmmoInternal(animName, fireAnim, stopOnAnimationEnd, maxshots) {
  self endon("enemy");
  if(isPlayer(self.enemy) && (self.shootStyle == "full" || self.shootStyle == "semi")) {
    level endon("player_becoming_invulnerable");
  }
  if(stopOnAnimationEnd) {
    self thread NotifyOnAnimEnd(animName, "fireAnimEnd");
    self endon("fireAnimEnd");
  }
  if(!isDefined(maxshots)) {
    maxshots = -1;
  }
  numshots = 0;
  hasFireNotetrack = animHasNoteTrack(fireAnim, "fire");
  usingRocketLauncher = (weaponClass(self.weapon) == "rocketlauncher");
  while(1) {
    if(hasFireNotetrack) {
      if(self usingBoltActionWeapon() && numshots > 0) {
        break;
      }
      self waittillmatch(animName, "fire");
      if(self usingBoltActionWeapon()) {
        self.a.needsToRechamber = 1;
      }
    }
    if(numshots == maxshots) {
      break;
    }
    if(!self.bulletsInClip) {
      if(!cheatAmmoIfNecessary()) {
        break;
      }
    }
    if(aimedAtShootEntOrPos() && GetTime() > self.a.lastShootTime) {
      self shootAtShootEntOrPos();
      assertex(self.bulletsInClip >= 0, self.bulletsInClip);
      if(isPlayer(self.enemy) && flag("player_is_invulnerable")) {
        if(RandomInt(3) == 0) {
          self.bulletsInClip--;
        }
      } else {
        self.bulletsInClip--;
      }
      if(usingRocketLauncher) {
        self.a.rockets--;
        if(isSubStr(self.weapon, "rpg")) {
          self hidepart("tag_rocket");
          self.a.rocketVisible = false;
        }
      }
    }
    numshots++;
    self thread shotgunPumpSound(animName);
    if(self.fastBurst && numshots == maxshots) {
      break;
    }
    if(!hasFireNotetrack) {
      self waittillmatch(animName, "end");
    }
    if(self usingBoltActionWeapon()) {
      wait 0.5;
    }
  }
  if(stopOnAnimationEnd) {
    self notify("fireAnimEnd");
  }
}
aimedAtShootEntOrPos() {
  tag_weapon = self gettagorigin("tag_weapon");
  if(!isDefined(tag_weapon)) {
    return false;
  }
  if(!isDefined(self.shootPos)) {
    assert(!isDefined(self.shootEnt));
    return true;
  }
  weaponAngles = self GetTagAngles("tag_weapon");
  anglesToShootPos = VectorToAngles(self.shootPos - tag_weapon);
  absyawdiff = AbsAngleClamp180(weaponAngles[1] - anglesToShootPos[1]);
  if(absyawdiff > self.aimThresholdYaw) {
    if(DistanceSquared(self GetShootAtPos(), self.shootPos) > 64 * 64 || absyawdiff > 45) {
      return false;
    }
  }
  return AbsAngleClamp180(weaponAngles[0] - anglesToShootPos[0]) <= self.aimThresholdPitch;
}
NotifyOnAnimEnd(animNotify, endNotify) {
  self endon("killanimscript");
  self endon(endNotify);
  self waittillmatch(animNotify, "end");
  self notify(endNotify);
}
shootAtShootEntOrPos() {
  if(isDefined(self.shoot_notify)) {
    self notify(self.shoot_notify);
  }
  self shoot_notify_wrapper();
  if(isDefined(self.shootEnt)) {
    if(isDefined(self.enemy) && self.shootEnt == self.enemy) {
      self shootEnemyWrapper();
    }
  } else {
    assert(isDefined(self.shootPos));
    self shootPosWrapper(self.shootPos);
  }
}
showRocket() {
  if(!isSubStr(self.weapon, "rpg")) {
    return;
  }
  self.a.rocketVisible = true;
  self showpart("tag_rocket");
  self notify("showing_rocket");
}
showRocketWhenReloadIsDone() {
  if(self.weapon != "rpg") {
    return;
  }
  self endon("death");
  self endon("showing_rocket");
  self waittill("killanimscript");
  self showRocket();
}
decrementBulletsInClip() {
  if(self.bulletsInClip) {
    self.bulletsInClip--;
  }
}
shotgunPumpSound(animName) {
  if(!self usingShotgun()) {
    return;
  }
  self endon("killanimscript");
  self notify("shotgun_pump_sound_end");
  self endon("shotgun_pump_sound_end");
  self thread stopShotgunPumpAfterTime(2.0);
  self waittillmatch(animName, "rechamber");
  self playSound("wpn_shotgun_pump");
  self notify("shotgun_pump_sound_end");
}
stopShotgunPumpAfterTime(timer) {
  self endon("killanimscript");
  self endon("shotgun_pump_sound_end");
  wait timer;
  self notify("shotgun_pump_sound_end");
}
NeedToReload(thresholdFraction) {
  if(isDefined(self.noreload)) {
    assertex(self.noreload, ".noreload must be true or undefined");
    if(self.bulletsinclip < weaponClipSize(self.weapon) * 0.5) {
      self.bulletsinclip = int(weaponClipSize(self.weapon) * 0.5);
    }
    return false;
  }
  if(self.weapon == "none") {
    return false;
  }
  if(self.bulletsInClip <= weaponClipSize(self.weapon) * thresholdFraction) {
    if(thresholdFraction == 0) {
      if(cheatAmmoIfNecessary()) {
        return false;
      }
    }
    return true;
  }
  return false;
}
putGunBackInHandOnKillAnimScript() {
  self endon("weapon_switch_done");
  self endon("death");
  self notify("put gun back in hand end unique");
  self endon("put gun back in hand end unique");
  self waittill("killanimscript");
  animscripts\shared::placeWeaponOn(self.primaryweapon, "right");
}
Reload(thresholdFraction, optionalAnimation) {
  if(self usingGasWeapon()) {
    return flamethrower_reload();
  }
  self endon("killanimscript");
  if(!NeedToReload(thresholdFraction)) {
    return false;
  }
  self.a.Alertness = "casual";
  self animscripts\battleChatter_ai::evaluateReloadEvent();
  self maps\_dds::dds_notify_reload(undefined, (self.team == "allies"));
  if(isDefined(optionalAnimation)) {
    self ClearAnim(%body, .1);
    self SetFlaggedAnimKnobAll("reloadanim", optionalAnimation, %body, 1, .1, 1);
    animscripts\shared::DoNoteTracks("reloadanim");
    self animscripts\weaponList::RefillClip();
  } else {
    if(self.a.pose == "prone") {
      self SetFlaggedAnimKnobAll("reloadanim", animArrayPickRandom("reload"), %body, 1, .1, 1);
      self UpdateProne(%prone_legs_up, %prone_legs_down, 1, 0.1, 1);
    } else {
      println("Bad anim_pose in combat::Reload");
      wait 2;
      return;
    }
    animscripts\shared::DoNoteTracks("reloadanim");
    animscripts\weaponList::RefillClip();
    self ClearAnim(%upperbody, .1);
  }
  return true;
}
flamethrower_reload() {
  wait(0.05);
  self animscripts\weaponList::RefillClip();
  return true;
}
getGrenadeThrowOffset(throwAnim) {
  offset = (0, 0, 64);
  if(isDefined(throwAnim)) {
    if(throwAnim == % exposed_grenadethrowb) offset = (41.5391, 7.28883, 72.2128);
    else if(throwAnim == % exposed_grenadethrowc) offset = (34.8849, -4.77048, 74.0488);
    else if(throwAnim == % exposed_grenadethrowb) offset = (41.5391, 7.28883, 72.2128);
    else if(throwAnim == % exposed_grenadethrowc) offset = (34.8849, -4.77048, 74.0488);
    else if(throwAnim == % corner_standl_grenade_a) offset = (41.605, 6.80107, 81.4785);
    else if(throwAnim == % corner_standl_grenade_b) offset = (24.1585, -14.7221, 29.2992);
    else if(throwAnim == % cornercrl_grenadea) offset = (25.8988, -10.2811, 30.4813);
    else if(throwAnim == % cornercrl_grenadeb) offset = (24.688, 45.0702, 64.377);
    else if(throwAnim == % corner_standr_grenade_a) offset = (37.1254, -32.7053, 76.5745);
    else if(throwAnim == % corner_standr_grenade_b) offset = (19.356, 15.5341, 16.5036);
    else if(throwAnim == % cornercrr_grenadea) offset = (39.8857, 5.92472, 24.5878);
    else if(throwAnim == % covercrouch_grenadea) offset = (-1.6363, -0.693674, 60.1009);
    else if(throwAnim == % covercrouch_grenadeb) offset = (-1.6363, -0.693674, 60.1009);
    else if(throwAnim == % coverstand_grenadea) offset = (10.8573, 7.12614, 77.2356);
    else if(throwAnim == % coverstand_grenadeb) offset = (19.1804, 5.68214, 73.2278);
    else if(throwAnim == % prone_grenade_a) offset = (12.2859, -1.3019, 33.4307);
    else if(throwAnim == % ai_pillar_stand_grenade_throw_01) offset = (3.33533, 25.1428, 33.6935);
    else if(throwAnim == % ai_pillar_stand_grenade_throw_02) offset = (15.8536, -12.6112, 66.6897);
    else if(throwAnim == % ai_pillar_stand_grenade_throw_03) offset = (25.7513, -19.2158, 23.2601);
    else if(throwAnim == % ai_pillar_crouch_grenade_throw_01) offset = (13.3738, -22.7841, 44.6094);
    else if(throwAnim == % ai_pillar_crouch_grenade_throw_02) offset = (19.3524, -16.1327, 18.6373);
    else if(throwAnim == % ai_pillar_crouch_grenade_throw_03) offset = (18.614, 19.1907, 15.9741);
  }
  if(offset[2] == 64) {
    if(isDefined(throwAnim)) {
      println("^1Warning: undefined grenade throw animation used; hand offset unknown");
    } else {
      println("^1Warning: grenade throw animation ", throwAnim, " has no recorded hand offset");
    }
  }
  return offset;
}
ThrowGrenadeAtPlayerASAP_combat_utility() {
  if(anim.numGrenadesInProgressTowardsPlayer == 0) {
    anim.grenadeTimers["player_fraggrenade"] = 0;
    anim.grenadeTimers["player_flash_grenade"] = 0;
  }
  anim.throwGrenadeAtPlayerASAP = true;
}
setActiveGrenadeTimer(throwingAt) {
  if(isPlayer(throwingAt)) {
    self.activeGrenadeTimer = "player_" + self.grenadeWeapon;
  } else {
    self.activeGrenadeTimer = "AI_" + self.grenadeWeapon;
  }
  if(!isDefined(anim.grenadeTimers[self.activeGrenadeTimer])) {
    anim.grenadeTimers[self.activeGrenadeTimer] = randomIntRange(1000, 20000);
  }
}
considerChangingTarget(throwingAt) {
  if(!isPlayer(throwingAt) && self.team == "axis") {
    players = GetPlayers();
    for(i = 0; i < players.size; i++) {
      player = players[i];
      if(GetTime() < anim.grenadeTimers[self.activeGrenadeTimer]) {
        if(player.ignoreme) {
          return throwingAt;
        }
        myGroup = self getthreatbiasgroup();
        playerGroup = player getthreatbiasgroup();
        if(myGroup != "" && playerGroup != "" && getThreatBias(playerGroup, myGroup) < -10000) {
          return throwingAt;
        }
        if(self canSee(player) || (isAI(throwingAt) && throwingAt canSee(player))) {
          if(isDefined(self.covernode)) {
            angles = VectorToAngles(player.origin - self.origin);
            yawDiff = AngleClamp180(self.covernode.angles[1] - angles[1]);
          } else {
            yawDiff = self GetYawToSpot(player.origin);
          }
          if(abs(yawDiff) < 60) {
            throwingAt = player;
            self setActiveGrenadeTimer(throwingAt);
          }
        }
      }
    }
  }
  return throwingAt;
}
usingPlayerGrenadeTimer() {
  return self.activeGrenadeTimer == "player_" + self.grenadeWeapon;
}
setGrenadeTimer(grenadeTimer, newValue) {
  oldValue = anim.grenadeTimers[grenadeTimer];
  anim.grenadeTimers[grenadeTimer] = max(newValue, oldValue);
}
getDesiredGrenadeTimerValue() {
  nextGrenadeTimeToUse = undefined;
  if(self usingPlayerGrenadeTimer()) {
    nextGrenadeTimeToUse = GetTime() + anim.playerGrenadeBaseTime + RandomInt(anim.playerGrenadeRangeTime);
  } else {
    nextGrenadeTimeToUse = GetTime() + 40000 + RandomInt(60000);
  }
  return nextGrenadeTimeToUse;
}
mayThrowDoubleGrenade() {
  assert(self.activeGrenadeTimer == "player_fraggrenade");
  if(player_died_recently()) {
    return false;
  }
  if(!anim.double_grenades_allowed) {
    return false;
  }
  if(GetTime() < anim.grenadeTimers["player_double_grenade"]) {
    return false;
  }
  if(GetTime() > anim.lastFragGrenadeToPlayerStart + 3000) {
    return false;
  }
  return anim.numGrenadesInProgressTowardsPlayer < 2;
}
myGrenadeCoolDownElapsed() {
  if(player_died_recently()) {
    return false;
  }
  return (GetTime() >= self.a.nextGrenadeTryTime);
}
grenadeCoolDownElapsed() {
  if(self.script_forcegrenade == 1) {
    return true;
  }
  if(!myGrenadeCoolDownElapsed()) {
    return false;
  }
  if(GetTime() >= anim.grenadeTimers[self.activeGrenadeTimer]) {
    return true;
  }
  if(self.activeGrenadeTimer == "player_fraggrenade") {
    return mayThrowDoubleGrenade();
  }
  return false;
}
isGrenadePosSafe(throwingAt, destination) {
  if(isDefined(anim.throwGrenadeAtPlayerASAP) && self usingPlayerGrenadeTimer()) {
    return true;
  }
  distanceThreshold = 200;
  if(self.grenadeWeapon == "flash_grenade") {
    distanceThreshold = 512;
  }
  distanceThresholdSq = distanceThreshold * distanceThreshold;
  closest = undefined;
  closestdist = 100000000;
  secondclosest = undefined;
  secondclosestdist = 100000000;
  for(i = 0; i < self.squad.members.size; i++) {
    if(!IsAlive(self.squad.members[i])) {
      continue;
    }
    dist = DistanceSquared(self.squad.members[i].origin, destination);
    if(dist > distanceThresholdSq) {
      continue;
    }
    if(dist < closestdist) {
      secondclosestdist = closestdist;
      secondclosest = closest;
      closestdist = dist;
      closest = self.squad.members[i];
    } else if(dist < secondclosestdist) {
      secondclosestdist = dist;
      secondclosest = self.squad.members[i];
    }
  }
  if(isDefined(closest) && sightTracePassed(closest getEye(), destination, false, undefined)) {
    return false;
  }
  if(isDefined(secondclosest) && sightTracePassed(closest getEye(), destination, false, undefined)) {
    return false;
  }
  return true;
}
TryGrenadePosProc(throwingAt, destination, optionalAnimation, armOffset) {
  if(!isGrenadePosSafe(throwingAt, destination)) {
    return false;
  } else if(DistanceSquared(self.origin, destination) < 200 * 200) {
    return false;
  }
  trace = PhysicsTrace(destination + (0, 0, 1), destination + (0, 0, -500));
  if(trace == destination + (0, 0, -500)) {
    return false;
  }
  trace += (0, 0, .1);
  return TryGrenadeThrow(throwingAt, trace, optionalAnimation, armOffset);
}
TryGrenade(throwingAt, optionalAnimation) {
  if(self usingGasWeapon()) {
    return false;
  }
  if(self.weapon == "mg42" || self.grenadeammo <= 0) {
    return false;
  }
  self setActiveGrenadeTimer(throwingAt);
  throwingAt = considerChangingTarget(throwingAt);
  if(!grenadeCoolDownElapsed()) {
    return false;
  }
  armOffset = getGrenadeThrowOffset(optionalAnimation);
  if(isDefined(self.enemy) && throwingAt == self.enemy) {
    if(self.grenadeWeapon == "flash_grenade" && !shouldThrowFlashBangAtEnemy()) {
      return false;
    }
    if(self canSeeEnemyFromExposed()) {
      if(!isGrenadePosSafe(throwingAt, throwingAt.origin)) {
        return false;
      }
      return TryGrenadeThrow(throwingAt, undefined, optionalAnimation, armOffset);
    } else if(self canSuppressEnemyFromExposed()) {
      return TryGrenadePosProc(throwingAt, self getEnemySightPos(), optionalAnimation, armOffset);
    } else {
      if(!isGrenadePosSafe(throwingAt, throwingAt.origin)) {
        return false;
      }
      return TryGrenadeThrow(throwingAt, undefined, optionalAnimation, armOffset);
    }
    return false;
  } else {
    return TryGrenadePosProc(throwingAt, throwingAt.origin, optionalAnimation, armOffset);
  }
}
TryGrenadeThrow(throwingAt, destination, optionalAnimation, armOffset) {
  if(self usingGasWeapon()) {
    return false;
  }
  if(GetTime() < 10000) {
    return false;
  }
  if(isDefined(optionalAnimation)) {
    throw_anim = optionalAnimation;
    gunHand = self.a.gunHand;
  } else {
    switch (self.a.special) {
      case "cover_crouch":
      case "none":
        if(self.a.pose == "stand") {
          armOffset = (0, 0, 80);
          throw_anim = animArray("grenade_throw");
        } else {
          armOffset = (0, 0, 65);
          throw_anim = animArray("grenade_throw");
        }
        gunHand = "left";
        break;
      default:
        throw_anim = undefined;
        gunHand = undefined;
        break;
    }
  }
  if(!isDefined(throw_anim)) {
    return (false);
  }
  if(isDefined(destination)) {
    throwvel = self checkGrenadeThrowPos(armOffset, "min energy", destination);
    if(!isDefined(throwvel)) {
      throwvel = self checkGrenadeThrowPos(armOffset, "min time", destination);
    }
    if(!isDefined(throwvel)) {
      throwvel = self checkGrenadeThrowPos(armOffset, "max time", destination);
    }
  } else {
    throwvel = self checkGrenadeThrow(armOffset, "min energy", self.randomGrenadeRange);
    if(!isDefined(throwvel)) {
      throwvel = self checkGrenadeThrow(armOffset, "min time", self.randomGrenadeRange);
    }
    if(!isDefined(throwvel)) {
      throwvel = self checkGrenadeThrow(armOffset, "max time", self.randomGrenadeRange);
    }
  }
  self.a.nextGrenadeTryTime = GetTime() + randomintrange(1000, 2000);
  if(isDefined(throwvel)) {
    if(!isDefined(self.oldGrenAwareness)) {
      self.oldGrenAwareness = self.grenadeawareness;
    }
    self.grenadeawareness = 0;
    nextGrenadeTimeToUse = self getDesiredGrenadeTimerValue();
    setGrenadeTimer(self.activeGrenadeTimer, min(GetTime() + 3000, nextGrenadeTimeToUse));
    secondGrenadeOfDouble = false;
    if(self usingPlayerGrenadeTimer()) {
      anim.numGrenadesInProgressTowardsPlayer++;
      self thread reduceGIPTPOnKillanimscript();
      if(anim.numGrenadesInProgressTowardsPlayer > 1) {
        secondGrenadeOfDouble = true;
      }
    }
    if(self.activeGrenadeTimer == "player_fraggrenade" && anim.numGrenadesInProgressTowardsPlayer <= 1) {
      anim.lastFragGrenadeToPlayerStart = GetTime();
    }
    DoGrenadeThrow(throw_anim, nextGrenadeTimeToUse, secondGrenadeOfDouble);
    return true;
  } else {}
  return false;
}
reduceGIPTPOnKillanimscript() {
  self endon("dont_reduce_giptp_on_killanimscript");
  self waittill("killanimscript");
  anim.numGrenadesInProgressTowardsPlayer--;
}
DoGrenadeThrow(throw_anim, nextGrenadeTimeToUse, secondGrenadeOfDouble) {
  self animscripts\battleChatter_ai::evaluateAttackEvent("grenade");
  self notify("stop_aiming_at_enemy");
  self SetFlaggedAnimKnobAllRestart("throwanim", throw_anim, %body, 1, 0.1, 1);
  self thread animscripts\shared::DoNoteTracksForever("throwanim", "killanimscript");
  model = getGrenadeModel();
  attachside = "none";
  for(;;) {
    self waittill("throwanim", notetrack);
    if(notetrack == "grenade_left" || notetrack == "grenade_right") {
      attachside = attachGrenadeModel(model, "TAG_INHAND");
      self.isHoldingGrenade = true;
    }
    if(notetrack == "grenade_throw" || notetrack == "grenade throw") {
      break;
    }
    assert(notetrack != "end");
    if(notetrack == "end") {
      anim.numGrenadesInProgressTowardsPlayer--;
      self notify("dont_reduce_giptp_on_killanimscript");
      return false;
    }
  }
  self notify("dont_reduce_giptp_on_killanimscript");
  if(self usingPlayerGrenadeTimer()) {
    self thread watchGrenadeTowardsPlayer(nextGrenadeTimeToUse);
  }
  self maps\_dds::dds_notify_grenade(self.grenadeweapon, (self.team == "allies"), false);
  self throwGrenade();
  if(!self usingPlayerGrenadeTimer()) {
    setGrenadeTimer(self.activeGrenadeTimer, nextGrenadeTimeToUse);
  }
  if(secondGrenadeOfDouble) {
    if(anim.numGrenadesInProgressTowardsPlayer > 1 || GetTime() - anim.lastGrenadeLandedNearPlayerTime < 2000) {
      anim.grenadeTimers["player_double_grenade"] = GetTime() + min(5000, anim.playerDoubleGrenadeTime);
    }
  }
  self notify("stop grenade check");
  if(attachSide != "none") {
    self detach(model, attachside);
  } else {
    print("No grenade hand set: ");
    println(throw_anim);
    println("animation in console does not specify grenade hand");
  }
  self.isHoldingGrenade = undefined;
  self.grenadeawareness = self.oldGrenAwareness;
  self.oldGrenAwareness = undefined;
  self waittillmatch("throwanim", "end");
  self SetAnim(%exposed_modern, 1, .2);
  self SetAnim(%exposed_aiming, 1);
  self ClearAnim(throw_anim, .2);
}
watchGrenadeTowardsPlayer(nextGrenadeTimeToUse) {
  watchGrenadeTowardsPlayerInternal(nextGrenadeTimeToUse);
  anim.numGrenadesInProgressTowardsPlayer--;
}
watchGrenadeTowardsPlayerInternal(nextGrenadeTimeToUse) {
  activeGrenadeTimer = self.activeGrenadeTimer;
  timeoutObj = spawnStruct();
  timeoutObj thread watchGrenadeTowardsPlayerTimeout(5);
  timeoutObj endon("watchGrenadeTowardsPlayerTimeout");
  type = self.grenadeWeapon;
  grenade = self getGrenadeIThrew();
  if(!isDefined(grenade)) {
    return;
  }
  setGrenadeTimer(activeGrenadeTimer, min(GetTime() + 5000, nextGrenadeTimeToUse));
  goodRadiusSqrd = 250 * 250;
  giveUpRadiusSqrd = 400 * 400;
  if(type == "flash_grenade") {
    goodRadiusSqrd = 900 * 900;
    giveUpRadiusSqrd = 1300 * 1300;
  }
  players = GetPlayers();
  prevorigin = grenade.origin;
  while(1) {
    wait .1;
    if(!isDefined(grenade)) {
      break;
    }
    if(grenade.origin == prevorigin) {
      if(DistanceSquared(grenade.origin, players[0].origin) < goodRadiusSqrd || DistanceSquared(grenade.origin, players[0].origin) > giveUpRadiusSqrd) {
        break;
      }
    }
    prevorigin = grenade.origin;
  }
  grenadeorigin = prevorigin;
  if(isDefined(grenade)) {
    grenadeorigin = grenade.origin;
  }
  if(DistanceSquared(grenadeorigin, players[0].origin) < goodRadiusSqrd) {
    level notify("threw_grenade_at_player");
    anim.throwGrenadeAtPlayerASAP = undefined;
    if(GetTime() - anim.lastGrenadeLandedNearPlayerTime < 3000) {
      anim.grenadeTimers["player_double_grenade"] = GetTime() + anim.playerDoubleGrenadeTime;
    }
    anim.lastGrenadeLandedNearPlayerTime = GetTime();
    setGrenadeTimer(activeGrenadeTimer, nextGrenadeTimeToUse);
  } else {}
}
getGrenadeIThrew() {
  self endon("killanimscript");
  self waittill("grenade_fire", grenade);
  return grenade;
}
watchGrenadeTowardsPlayerTimeout(timerlength) {
  wait timerlength;
  self notify("watchGrenadeTowardsPlayerTimeout");
}
attachGrenadeModel(model, tag) {
  self attach(model, tag);
  thread detachGrenadeOnScriptChange(model, tag);
  return tag;
}
detachGrenadeOnScriptChange(model, tag) {
  self endon("stop grenade check");
  self waittill("killanimscript");
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.oldGrenAwareness)) {
    self.grenadeawareness = self.oldGrenAwareness;
    self.oldGrenAwareness = undefined;
  }
  self detach(model, tag);
}
offsetToOrigin(start) {
  forward = anglesToForward(self.angles);
  right = AnglesToRight(self.angles);
  up = anglestoup(self.angles);
  forward = vector_scale(forward, start[0]);
  right = vector_scale(right, start[1]);
  up = vector_scale(up, start[2]);
  return (forward + right + up);
}
grenadeLine(start, end) {
  level notify("armoffset");
  level endon("armoffset");
  start = self.origin + offsetToOrigin(start);
  for(;;) {
    line(start, end, (1, 0, 1));
    Print3d(start, start, (0.2, 0.5, 1.0), 1, 1);
    Print3d(end, end, (0.2, 0.5, 1.0), 1, 1);
    wait(0.05);
  }
}
getGrenadeDropVelocity() {
  yaw = RandomFloat(360);
  pitch = RandomFloatRange(30, 75);
  amntz = sin(pitch);
  cospitch = cos(pitch);
  amntx = cos(yaw) * cospitch;
  amnty = sin(yaw) * cospitch;
  speed = RandomFloatRange(100, 200);
  velocity = (amntx, amnty, amntz) * speed;
  return velocity;
}
dropGrenade() {
  grenadeOrigin = self GetTagOrigin("tag_inhand");
  velocity = getGrenadeDropVelocity();
  self MagicGrenadeManual(grenadeOrigin, velocity, 3);
}
EyesAtEnemy() {
  self notify("stop EyesAtEnemy internal");
  self endon("death");
  self endon("stop EyesAtEnemy internal");
  for(;;) {
    if(isDefined(self.enemy)) {}
    wait 2;
  }
}
FindCoverNearSelf() {
  oldKeepNodeInGoal = self.keepClaimedNodeInGoal;
  oldKeepNode = self.keepClaimedNode;
  self.keepClaimedNodeInGoal = false;
  self.keepClaimedNode = false;
  node = self FindBestCoverNode();
  if(isDefined(node)) {
    if(self.a.script != "combat") {
      if(self UseCoverNode(node)) {
        return true;
      } else {}
    }
  }
  self.keepClaimedNodeInGoal = oldKeepNodeInGoal;
  self.keepClaimedNode = oldKeepNode;
  return false;
}
lookForBetterCover() {
  if(!isValidEnemy(self.enemy)) {
    return false;
  }
  if(self.fixedNode) {
    return false;
  }
  node = self getBestCoverNodeIfAvailable();
  if(isDefined(node)) {
    return useCoverNodeIfPossible(node);
  }
  return false;
}
getBestCoverNodeIfAvailable() {
  node = self FindBestCoverNode();
  if(!isDefined(node)) {
    return undefined;
  }
  currentNode = self GetClaimedNode();
  if(isDefined(currentNode) && node == currentNode) {
    return undefined;
  }
  if(isDefined(self.coverNode) && node == self.coverNode) {
    return undefined;
  }
  return node;
}
useCoverNodeIfPossible(node) {
  oldKeepNodeInGoal = self.keepClaimedNodeInGoal;
  oldKeepNode = self.keepClaimedNode;
  self.keepClaimedNodeInGoal = false;
  self.keepClaimedNode = false;
  if(self UseCoverNode(node)) {
    return true;
  } else {}
  self.keepClaimedNodeInGoal = oldKeepNodeInGoal;
  self.keepClaimedNode = oldKeepNode;
  return false;
}
tryRunningToEnemy(ignoreSuppression) {
  if(!isValidEnemy(self.enemy)) {
    return false;
  }
  if(self.fixedNode) {
    return false;
  }
  if(self IsInGoal(self.enemy.origin)) {
    self FindReacquireDirectPath(ignoreSuppression);
  } else {
    self FindReacquireProximatePath(ignoreSuppression);
  }
  if(self ReacquireMove()) {
    self.keepClaimedNodeInGoal = false;
    self.keepClaimedNode = false;
    self.a.magicReloadWhenReachEnemy = true;
    return true;
  }
  return false;
}
getGunYawToShootEntOrPos() {
  if(!isDefined(self.shootPos)) {
    assert(!isDefined(self.shootEnt));
    return 0;
  }
  yaw = self GetTagAngles("tag_weapon")[1] - GetYaw(self.shootPos);
  yaw = AngleClamp180(yaw);
  return yaw;
}
getGunPitchToShootEntOrPos() {
  if(!isDefined(self.shootPos)) {
    assert(!isDefined(self.shootEnt));
    return 0;
  }
  pitch = self GetTagAngles("tag_weapon")[0] - VectorToAngles(self.shootPos - self gettagorigin("tag_weapon"))[0];
  pitch = AngleClamp180(pitch);
  return pitch;
}
getPitchToEnemy() {
  if(!isDefined(self.enemy)) {
    return 0;
  }
  vectorToEnemy = self.enemy GetShootAtPos() - self GetShootAtPos();
  vectorToEnemy = VectorNormalize(vectortoenemy);
  pitchDelta = 360 - VectorToAngles(vectorToEnemy)[0];
  return AngleClamp180(pitchDelta);
}
getPitchToSpot(spot) {
  if(!isDefined(spot)) {
    return 0;
  }
  vectorToEnemy = spot - self GetShootAtPos();
  vectorToEnemy = VectorNormalize(vectortoenemy);
  pitchDelta = 360 - VectorToAngles(vectorToEnemy)[0];
  return AngleClamp180(pitchDelta);
}
anim_set_next_move_to_new_cover() {
  self.a.next_move_to_new_cover = randomintrange(1, 4);
}
watchReloading() {
  self.isreloading = false;
  while(1) {
    self waittill("reload_start");
    self maps\_dds::dds_notify_reload(self GetCurrentWeapon(), (self.team == "allies"));
    self.isreloading = true;
    self waittillreloadfinished();
    self.isreloading = false;
  }
}
waittillReloadFinished() {
  self thread timedNotify(4, "reloadtimeout");
  self endon("reloadtimeout");
  while(1) {
    self waittill("reload");
    weap = self getCurrentWeapon();
    if(weap == "none") {
      break;
    }
    if(self getCurrentWeaponClipAmmo() >= weaponClipSize(weap)) {
      break;
    }
  }
  self notify("reloadtimeout");
}
timedNotify(time, msg) {
  self endon(msg);
  wait time;
  self notify(msg);
}
attackEnemyWhenFlashed() {
  self endon("killanimscript");
  while(1) {
    if(!isDefined(self.enemy) || !IsAlive(self.enemy) || !IsSentient(self.enemy)) {
      self waittill("enemy");
      continue;
    }
    attackSpecificEnemyWhenFlashed();
  }
}
attackSpecificEnemyWhenFlashed() {
  self endon("enemy");
  self.enemy endon("death");
  if(isDefined(self.enemy.flashendtime) && GetTime() < self.enemy.flashendtime) {
    tryToAttackFlashedEnemy();
  }
  while(1) {
    self.enemy waittill("flashed");
    tryToAttackFlashedEnemy();
  }
}
tryToAttackFlashedEnemy() {
  if(self.enemy.flashingTeam != self.team) {
    return;
  }
  if(DistanceSquared(self.origin, self.enemy.origin) > 1024 * 1024) {
    return;
  }
  while(GetTime() < self.enemy.flashendtime - 500) {
    if(!self cansee(self.enemy) && DistanceSquared(self.origin, self.enemy.origin) < 800 * 800) {
      tryRunningToEnemy(true);
    }
    wait .05;
  }
}
shouldThrowFlashBangAtEnemy() {
  if(DistanceSquared(self.origin, self.enemy.origin) > 768 * 768) {
    return false;
  }
  return true;
}
startFlashBanged() {
  if(isDefined(self.flashduration)) {
    duration = self.flashduration;
  } else {
    duration = self getFlashBangedStrength() * 1000;
  }
  self.flashendtime = GetTime() + duration;
  self notify("flashed");
  return duration;
}
monitorFlash() {
  self endon("death");
  self endon("stop_monitoring_flash");
  while(1) {
    self waittill("flashbang", amount_distance, amount_angle, attacker, attackerteam);
    if(self.flashbangImmunity) {
      continue;
    }
    if(isDefined(self.script_immunetoflash) && self.script_immunetoflash != 0) {
      continue;
    }
    if(isDefined(self.team) && isDefined(attackerteam) && self.team == attackerteam) {
      amount_distance = 3 * (amount_distance - .75);
      if(amount_distance < 0) {
        continue;
      }
    }
    minamountdist = 0.2;
    if(amount_distance > 1 - minamountdist) {
      amount_distance = 1.0;
    } else {
      amount_distance = amount_distance / (1 - minamountdist);
    }
    duration = 4.5 * amount_distance;
    if(duration < 0.25) {
      continue;
    }
    self.flashingTeam = attackerteam;
    self SetFlashBanged(true, duration);
    self notify("doFlashBanged", attacker);
  }
}
isSniper() {
  return self.isSniper;
}
isSniperRifle(weapon) {
  return WeaponClass(weapon) == "rifle" && WeaponIsSemiAuto(weapon) && WeaponFireTime(weapon) > 0.2;
}
isCrossbow(weapon) {
  return (IsSubstr(weapon, "crossbow") && !IsSubstr(weapon, "explosive"));
}
NeedToRechamber() {
  if(self usingBoltActionWeapon() && self.bulletsInClip && self.a.needsToRechamber) {
    return true;
  }
  return false;
}
getShootAnimPrefix() {
  if(self.a.script == "cover_left" || self.a.script == "cover_right" || self.a.script == "cover_pillar") {
    if(isDefined(self.cornerAiming) && self.cornerAiming && isDefined(self.a.cornerMode) && self.a.cornerMode == "lean") {
      return "lean_";
    }
  }
  return "";
}