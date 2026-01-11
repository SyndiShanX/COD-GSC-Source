/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\combat_utility.gsc
*****************************************************/

#include animscripts\Utility;
#include maps\_gameskill;
#include maps\_utility;
#include common_scripts\utility;
#include animscripts\SetPoseMovement;
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
  pos = self getshootatpos() + (0, 0, -3);
  dir = (pos[0] - target[0], pos[1] - target[1], pos[2] - target[2]);
  dir = VectorNormalize(dir);
  fact = dir[2] * -1;
  return fact;
}

getSniperBurstDelayTime() {
  return randomFloatRange(anim.min_sniper_burst_delay_time, anim.max_sniper_burst_delay_time);
}

getRemainingBurstDelayTime() {
  timeSoFar = (gettime() - self.a.lastShootTime) / 1000;
  delayTime = getBurstDelayTime();
  if(delayTime > timeSoFar) {
    return delayTime - timeSoFar;
  }
  return 0;
}

getBurstDelayTime() {
  if(self usingSidearm()) {
    return randomFloatRange(.15, .55);
  } else if(self usingShotgun()) {
    return randomFloatRange(1.0, 1.7);
  } else if(self isSniper()) {
    return getSniperBurstDelayTime();
  } else if(self.fastBurst) {
    return randomFloatRange(.1, .35);
  } else if(self usingBoltActionWeapon()) {
    return randomFloatRange(1.0, 1.5);
  } else {
    return randomFloatRange(.2, .7);
  }
}

burstDelay() {
  if(self.bulletsInClip) {
    if(self.shootStyle == "full" && !self.fastBurst) {
      if(self.a.lastShootTime == gettime()) {
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
  if(isDefined(self.nextCheatTime) && gettime() < self.nextCheatTime) {
    return false;
  }
  if(!self canSee(self.enemy)) {
    return false;
  }
  if(self isCQBWalking()) {
    self.bulletsInClip = weaponClipSize(self.weapon);
  } else if(self is_banzai()) {
    self.bulletsInClip = weaponClipSize(self.weapon);
  } else if(isDefined(self.cheatammo_override) && (self.cheatammo_override == true)) {
    return false;
  } else {
    self.bulletsInClip = 10;
  }
  if(self.bulletsInClip > weaponClipSize(self.weapon)) {
    self.bulletsInClip = weaponClipSize(self.weapon);
  }
  self.nextCheatTime = gettime() + 4000;
  return true;
}

shootUntilShootBehaviorChange() {
  self endon("shoot_behavior_change");
  self endon("stopShooting");
  if(self weaponAnims() == "rocketlauncher" || self isSniper()) {
    players = GetPlayers();
    if(isDefined(players) && players.size > 0) {
      if(isDefined(self.enemy) && !IsPlayer(self.enemy) && isSentient(self.enemy)) {
        if(DistanceSquared(players[0].origin, self.enemy.origin) < 384 * 384) {
          self.enemy animscripts\battlechatter_ai::addThreatEvent("infantry", self, 1.0);
        }
      }
    }
    if(self weaponAnims() == "rocketlauncher" && isSentient(self.enemy)) {
      wait(randomFloat(2.0));
    }
  }
  while(1) {
    burstDelay();
    if(self.shootStyle == "full") {
      self FireUntilOutOfAmmo(animArray("fire"), false, animscripts\shared::decideNumShotsForFull());
    } else if(self.shootStyle == "burst" || self.shootStyle == "single" || self.shootStyle == "semi") {
      numShots = 1;
      if(self.shootStyle == "burst" || self.shootStyle == "semi") {
        numShots = animscripts\shared::decideNumShotsForBurst();
      }
      if(numShots == 1) {
        self FireUntilOutOfAmmo(animArrayPickRandom("single"), true, numShots);
      } else {
        self FireUntilOutOfAmmo(animArray(self.shootStyle + numShots), true, numShots);
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
  self setAnim( % add_fire, 1, .1, 1);
  rate = randomfloatrange(0.3, 2.0);
  if(self.shootStyle == "full" || self.shootStyle == "burst") {
    rate = animscripts\weaponList::autoShootAnimRate();
    if(rate > 1.999) {
      rate = 1.999;
    }
  } else if(isDefined(self.shootEnt) && isDefined(self.shootEnt.magic_bullet_shield)) {
    rate = 0.25;
  }
  if(self usingBoltActionWeapon()) {
    rate = 1.0;
  }
  if(self usingGasWeapon()) {
    rate = 1.0;
  }
  self setFlaggedAnimKnobRestart(animName, fireAnim, 1, .2, rate);
  self updatePlayerSightAccuracy();
  FireUntilOutOfAmmoInternal(animName, fireAnim, stopOnAnimationEnd, maxshots);
  self clearAnim( % add_fire, .2);
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
    if(aimedAtShootEntOrPos() && gettime() > self.a.lastShootTime) {
      self shootAtShootEntOrPos();
      assertex(self.bulletsInClip >= 0, self.bulletsInClip);
      if(isPlayer(self.enemy) && flag("player_is_invulnerable")) {
        if(randomint(3) == 0) {
          self.bulletsInClip--;
        }
      } else {
        self.bulletsInClip--;
      }
      if(usingRocketLauncher) {
        self.a.rockets--;
        if(self.weapon == "rpg") {
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
  if(!isDefined(self.shootPos)) {
    assert(!isDefined(self.shootEnt));
    return true;
  }
  weaponAngles = self gettagangles("tag_weapon");
  anglesToShootPos = vectorToAngles(self.shootPos - self gettagorigin("tag_weapon"));
  absyawdiff = AbsAngleClamp180(weaponAngles[1] - anglesToShootPos[1]);
  if(absyawdiff > self.aimThresholdYaw) {
    if(distanceSquared(self getShootAtPos(), self.shootPos) > 64 * 64 || absyawdiff > 45) {
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
  if(self.weapon != "rpg") {
    return;
  }
  self.a.rocketVisible = true;
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
  self playSound("ai_shotgun_pump");
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

tryWeaponThrowDown() {
  if(1) {
    return false;
  }
  if(anim.noWeaponToss) {
    return false;
  }
  if(weaponAnims() == "pistol") {
    return false;
  }
  if(self.team != "axis") {
    return false;
  }
  if(self.a.pose != "stand") {
    return false;
  }
  if(!isalive(self.enemy)) {
    return false;
  }
  if(self.a.script != "combat") {
    return false;
  }
  players = GetPlayers();
  if(players.size > 0 && distance(players[0].origin, self.origin) > 350) {
    return false;
  }
  if(!self cansee(self.enemy)) {
    return false;
  }
  tossrand = randomint(3) + 1;
  tossanim = undefined;
  assertmsg("these pistol anims don't exist yet");
  self setFlaggedAnimKnobAllRestart("pistol pullout", tossanim, % body, 1, .1, 1);
  self waittill("pistol pullout", notetrack);
  weaponClass = "weapon_" + self.weapon;
  if(self.classname == "actor_axis_ramboguytest2") {
    weapon = spawn(weaponClass, self getTagOrigin("TAG_WEAPON_PRIMARY"));
    weapon.angles = self getTagAngles("TAG_WEAPON_PRIMARY");
  } else {
    weapon = spawn(weaponClass, self getTagOrigin("tag_weapon_right"));
    weapon.angles = self getTagAngles("tag_weapon_right");
  }
  if(self.secondaryweapon == "") {
    self.weapon = "walther";
  } else {
    self.weapon = self.secondaryweapon;
  }
  self thread putGunBackInHandOnKillAnimScript();
  self waittill("pistol pullout", notetrack);
  self notify("weapon_throw_down_done");
  self.a.combatrunanim = % combat_run_fast_pistol;
  self animscripts\weaponList::RefillClip();
  self waittillmatch("pistol pullout", "end");
  self clearanim( % upperbody, .1);
  return true;
}

putGunBackInHandOnKillAnimScript() {
  self endon("weapon_switch_done");
  self endon("death");
  self notify("put gun back in hand end unique");
  self endon("put gun back in hand end unique");
  self waittill("killanimscript");
  animscripts\shared::placeWeaponOn(self.primaryweapon, "right");
}

putGunBackInHandOnKillAnimScriptRechamber() {
  self endon("weapon_rechamber_done");
  self endon("death");
  self waittill("killanimscript");
  self clearanim( % rechamber, 0);
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
  if(isDefined(optionalAnimation)) {
    self clearAnim( % body, .1);
    self setFlaggedAnimKnobAll("reloadanim", optionalAnimation, % body, 1, .1, 1);
    animscripts\shared::DoNoteTracks("reloadanim");
    self animscripts\weaponList::RefillClip();
  } else {
    if(self.a.pose == "prone") {
      self setFlaggedAnimKnobAll("reloadanim", % reload_prone_rifle, % body, 1, .1, 1);
      self UpdateProne( % prone_legs_up, % prone_legs_down, 1, 0.1, 1);
    } else {
      println("Bad anim_pose in combat::Reload");
      wait 2;
      return;
    }
    animscripts\shared::DoNoteTracks("reloadanim");
    animscripts\weaponList::RefillClip();
    self clearanim( % upperbody, .1);
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
    else if(throwAnim == % exposed2_grenadethrowb) offset = (41.5391, 7.28883, 72.2128);
    else if(throwAnim == % exposed2_grenadethrowc) offset = (34.8849, -4.77048, 74.0488);
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
  enemies = getaiarray("axis");
  if(enemies.size == 0) {
    return;
  }
  numwithgrenades = 0;
  for(i = 0; i < enemies.size; i++) {
    if(enemies[i].grenadeammo > 0) {
      return;
    }
  }
  println("^1Warning: called ThrowGrenadeAtPlayerASAP, but no enemies have any grenadeammo!");
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
      if(gettime() < anim.grenadeTimers[self.activeGrenadeTimer]) {
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
    nextGrenadeTimeToUse = gettime() + anim.playerGrenadeBaseTime + randomint(anim.playerGrenadeRangeTime);
  } else {
    nextGrenadeTimeToUse = gettime() + 40000 + randomint(60000);
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
  if(gettime() < anim.grenadeTimers["player_double_grenade"]) {
    return false;
  }
  if(gettime() > anim.lastFragGrenadeToPlayerStart + 3000) {
    return false;
  }
  return anim.numGrenadesInProgressTowardsPlayer < 2;
}

myGrenadeCoolDownElapsed() {
  if(player_died_recently()) {
    return false;
  }
  return (gettime() >= self.a.nextGrenadeTryTime);
}

grenadeCoolDownElapsed() {
  if(self.script_forcegrenade == 1) {
    return true;
  }
  if(!myGrenadeCoolDownElapsed()) {
    return false;
  }
  if(gettime() >= anim.grenadeTimers[self.activeGrenadeTimer]) {
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
    if(!isalive(self.squad.members[i])) {
      continue;
    }
    dist = distanceSquared(self.squad.members[i].origin, destination);
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

printGrenadeTimers() {
  level notify("stop_printing_grenade_timers");
  level endon("stop_printing_grenade_timers");
  x = 40;
  y = 40;
  level.grenadeTimerHudElem = [];
  keys = getArrayKeys(anim.grenadeTimers);
  for(i = 0; i < keys.size; i++) {
    textelem = newHudElem();
    textelem.x = x;
    textelem.y = y;
    textelem.alignX = "left";
    textelem.alignY = "top";
    textelem.horzAlign = "fullscreen";
    textelem.vertAlign = "fullscreen";
    textelem setText(keys[i]);
    bar = newHudElem();
    bar.x = x + 110;
    bar.y = y + 2;
    bar.alignX = "left";
    bar.alignY = "top";
    bar.horzAlign = "fullscreen";
    bar.vertAlign = "fullscreen";
    bar setshader("black", 1, 8);
    textelem.bar = bar;
    textelem.key = keys[i];
    y += 10;
    level.grenadeTimerHudElem[keys[i]] = textelem;
  }
  while(1) {
    wait .05;
    for(i = 0; i < keys.size; i++) {
      timeleft = (anim.grenadeTimers[keys[i]] - gettime()) / 1000;
      width = max(timeleft * 4, 1);
      width = int(width);
      bar = level.grenadeTimerHudElem[keys[i]].bar;
      bar setShader("black", width, 8);
    }
  }
}

destroyGrenadeTimers() {
  if(!isDefined(level.grenadeTimerHudElem)) {
    return;
  }
  keys = getArrayKeys(anim.grenadeTimers);
  for(i = 0; i < keys.size; i++) {
    level.grenadeTimerHudElem[keys[i]].bar destroy();
    level.grenadeTimerHudElem[keys[i]] destroy();
  }
}

grenadeTimerDebug() {
  if(getdvar("scr_grenade_debug") == "") {
    setdvar("scr_grenade_debug", "0");
  }
  while(1) {
    while(1) {
      if(getdebugdvar("scr_grenade_debug") != "0") {
        break;
      }
      wait .5;
    }
    thread printGrenadeTimers();
    while(1) {
      if(getdebugdvar("scr_grenade_debug") == "0") {
        break;
      }
      wait .5;
    }
    level notify("stop_printing_grenade_timers");
    destroyGrenadeTimers();
  }
}

grenadeDebug(state, duration, showMissReason) {
  if(getdebugdvar("scr_grenade_debug") == "0") {
    return;
  }
  self notify("grenade_debug");
  self endon("grenade_debug");
  self endon("killanimscript");
  self endon("death");
  endtime = gettime() + 1000 * duration;
  while(gettime() < endtime) {
    print3d(self getShootAtPos() + (0, 0, 10), state);
    if(isDefined(showMissReason) && isDefined(self.grenadeMissReason)) {
      print3d(self getShootAtPos() + (0, 0, 0), "Failed: " + self.grenadeMissReason);
    } else if(isDefined(self.activeGrenadeTimer)) {
      print3d(self getShootAtPos() + (0, 0, 0), "Timer: " + self.activeGrenadeTimer);
    }
    wait .05;
  }
}

setGrenadeMissReason(reason) {
  if(getdebugdvar("scr_grenade_debug") == "0") {
    return;
  }
  self.grenadeMissReason = reason;
}

TryGrenadePosProc(throwingAt, destination, optionalAnimation, armOffset) {
  if(!isGrenadePosSafe(throwingAt, destination)) {
    return false;
  } else if(distanceSquared(self.origin, destination) < 200 * 200) {
    return false;
  }
  trace = physicsTrace(destination + (0, 0, 1), destination + (0, 0, -500));
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
  self thread grenadeDebug("Tried grenade throw", 4, true);
  armOffset = getGrenadeThrowOffset(optionalAnimation);
  if(isDefined(self.enemy) && throwingAt == self.enemy) {
    if(self.grenadeWeapon == "flash_grenade" && !shouldThrowFlashBangAtEnemy()) {
      return false;
    }
    if(self canSeeEnemyFromExposed()) {
      if(!isGrenadePosSafe(throwingAt, throwingAt.origin)) {
        self setGrenadeMissReason("Teammates near target");
        return false;
      }
      return TryGrenadeThrow(throwingAt, undefined, optionalAnimation, armOffset);
    } else if(self canSuppressEnemyFromExposed()) {
      return TryGrenadePosProc(throwingAt, self getEnemySightPos(), optionalAnimation, armOffset);
    } else {
      if(!isGrenadePosSafe(throwingAt, throwingAt.origin)) {
        self setGrenadeMissReason("Teammates near target");
        return false;
      }
      return TryGrenadeThrow(throwingAt, undefined, optionalAnimation, armOffset);
    }
    self setGrenadeMissReason("Don't know where to throw");
    return false;
  } else {
    return TryGrenadePosProc(throwingAt, throwingAt.origin, optionalAnimation, armOffset);
  }
}

TryGrenadeThrow(throwingAt, destination, optionalAnimation, armOffset) {
  if(self usingGasWeapon()) {
    return false;
  }
  if(gettime() < 10000) {
    self setGrenadeMissReason("First 10 seconds of game");
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
          throw_anim = % stand_grenade_throw;
        } else {
          armOffset = (0, 0, 65);
          throw_anim = % crouch_grenade_throw;
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
  self.a.nextGrenadeTryTime = gettime() + randomintrange(1000, 2000);
  if(isDefined(throwvel)) {
    if(!isDefined(self.oldGrenAwareness)) {
      self.oldGrenAwareness = self.grenadeawareness;
    }
    self.grenadeawareness = 0;
    if(getdebugdvar("anim_debug") == "1") {
      thread animscripts\utility::debugPos(destination, "O");
    }
    nextGrenadeTimeToUse = self getDesiredGrenadeTimerValue();
    setGrenadeTimer(self.activeGrenadeTimer, min(gettime() + 3000, nextGrenadeTimeToUse));
    secondGrenadeOfDouble = false;
    if(self usingPlayerGrenadeTimer()) {
      anim.numGrenadesInProgressTowardsPlayer++;
      self thread reduceGIPTPOnKillanimscript();
      if(anim.numGrenadesInProgressTowardsPlayer > 1) {
        secondGrenadeOfDouble = true;
      }
    }
    if(self.activeGrenadeTimer == "player_fraggrenade" && anim.numGrenadesInProgressTowardsPlayer <= 1) {
      anim.lastFragGrenadeToPlayerStart = gettime();
    }
    if(getdvar("grenade_spam") == "on") {
      nextGrenadeTimeToUse = 0;
    }
    DoGrenadeThrow(throw_anim, nextGrenadeTimeToUse, secondGrenadeOfDouble);
    return true;
  } else {
    self setGrenadeMissReason("Couldn't find trajectory");
    if(getdebugdvar("debug_grenademiss") == "on" && isDefined(destination)) {
      thread grenadeLine(armoffset, destination);
    }
  }
  return false;
}

reduceGIPTPOnKillanimscript() {
  self endon("dont_reduce_giptp_on_killanimscript");
  self waittill("killanimscript");
  anim.numGrenadesInProgressTowardsPlayer--;
}

DoGrenadeThrow(throw_anim, nextGrenadeTimeToUse, secondGrenadeOfDouble) {
  self thread grenadeDebug("Starting throw", 3);
  self animscripts\battleChatter_ai::evaluateAttackEvent("grenade");
  self notify("stop_aiming_at_enemy");
  self SetFlaggedAnimKnobAllRestart("throwanim", throw_anim, % body, 1, 0.1, 1);
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
  if(getdebugdvar("debug_grenadehand") == "on") {
    tags = [];
    numTags = self getAttachSize();
    emptySlot = [];
    for(i = 0; i < numTags; i++) {
      name = self getAttachModelName(i);
      if(issubstr(name, "weapon")) {
        tagName = self getAttachTagname(i);
        emptySlot[tagname] = 0;
        tags[tags.size] = tagName;
      }
    }
    for(i = 0; i < tags.size; i++) {
      emptySlot[tags[i]]++;
      if(emptySlot[tags[i]] < 2) {
        continue;
      }
      iprintlnbold("Grenade throw needs fixing (check console)");
      println("Grenade throw animation ", throw_anim, " has multiple weapons attached to ", tags[i]);
      break;
    }
  }
  self thread grenadeDebug("Threw", 5);
  self notify("dont_reduce_giptp_on_killanimscript");
  if(self usingPlayerGrenadeTimer()) {
    self thread watchGrenadeTowardsPlayer(nextGrenadeTimeToUse);
  }
  self throwGrenade();
  if(!self usingPlayerGrenadeTimer()) {
    setGrenadeTimer(self.activeGrenadeTimer, nextGrenadeTimeToUse);
  }
  if(secondGrenadeOfDouble) {
    if(anim.numGrenadesInProgressTowardsPlayer > 1 || gettime() - anim.lastGrenadeLandedNearPlayerTime < 2000) {
      anim.grenadeTimers["player_double_grenade"] = gettime() + min(5000, anim.playerDoubleGrenadeTime);
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
  self setanim( % exposed_modern, 1, .2);
  self setanim( % exposed_aiming, 1);
  self clearanim(throw_anim, .2);
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
  setGrenadeTimer(activeGrenadeTimer, min(gettime() + 5000, nextGrenadeTimeToUse));
  grenade thread grenadeDebug("Incoming", 5);
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
      if(distanceSquared(grenade.origin, players[0].origin) < goodRadiusSqrd || distanceSquared(grenade.origin, players[0].origin) > giveUpRadiusSqrd) {
        break;
      }
    }
    prevorigin = grenade.origin;
  }
  grenadeorigin = prevorigin;
  if(isDefined(grenade)) {
    grenadeorigin = grenade.origin;
  }
  if(distanceSquared(grenadeorigin, players[0].origin) < goodRadiusSqrd) {
    if(isDefined(grenade)) {
      grenade thread grenadeDebug("Landed near player", 5);
    }
    level notify("threw_grenade_at_player");
    anim.throwGrenadeAtPlayerASAP = undefined;
    if(gettime() - anim.lastGrenadeLandedNearPlayerTime < 3000) {
      anim.grenadeTimers["player_double_grenade"] = gettime() + anim.playerDoubleGrenadeTime;
    }
    anim.lastGrenadeLandedNearPlayerTime = gettime();
    setGrenadeTimer(activeGrenadeTimer, nextGrenadeTimeToUse);
  } else {
    if(isDefined(grenade)) {
      grenade thread grenadeDebug("Missed", 5);
    }
  }
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
  right = anglestoright(self.angles);
  up = anglestoup(self.angles);
  forward = vectorScale(forward, start[0]);
  right = vectorScale(right, start[1]);
  up = vectorScale(up, start[2]);
  return (forward + right + up);
}

grenadeLine(start, end) {
  level notify("armoffset");
  level endon("armoffset");
  start = self.origin + offsetToOrigin(start);
  for(;;) {
    line(start, end, (1, 0, 1));
    print3d(start, start, (0.2, 0.5, 1.0), 1, 1);
    print3d(end, end, (0.2, 0.5, 1.0), 1, 1);
    wait(0.05);
  }
}

getGrenadeDropVelocity() {
  yaw = randomFloat(360);
  pitch = randomFloatRange(30, 75);
  amntz = sin(pitch);
  cospitch = cos(pitch);
  amntx = cos(yaw) * cospitch;
  amnty = sin(yaw) * cospitch;
  speed = randomFloatRange(100, 200);
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
    if(isDefined(self.enemy)) {
      self animscripts\shared::LookAtEntity(self.enemy, 2, "alert", "eyes only", "don't interrupt");
    }
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
    if(self.a.script != "combat" || animscripts\combat::shouldGoToNode(node)) {
      if(self UseCoverNode(node)) {
        return true;
      } else {
        self thread DebugFailedCoverUsage(node);
      }
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
  if(self.a.script == "combat" && !animscripts\combat::shouldGoToNode(node)) {
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
  } else {
    self thread DebugFailedCoverUsage(node);
  }
  self.keepClaimedNodeInGoal = oldKeepNodeInGoal;
  self.keepClaimedNode = oldKeepNode;
  return false;
}

DebugFailedCoverUsage(node) {
  if(getdvar("scr_debugfailedcover") == "") {
    setdvar("scr_debugfailedcover", "0");
  }
  if(getdebugdvarint("scr_debugfailedcover") == 1) {
    self endon("death");
    for(i = 0; i < 20; i++) {
      line(self.origin, node.origin);
      print3d(node.origin, "failed");
      wait .05;
    }
  }
}

tryRunningToEnemy(ignoreSuppression) {
  if(!isValidEnemy(self.enemy)) {
    return false;
  }
  if(self.fixedNode) {
    return false;
  }
  if(self isingoal(self.enemy.origin)) {
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
delayedBadplace(org) {
  self endon("death");
  wait(0.5);
  if(getdebugdvar("debug_displace") == "on") {
    thread badplacer(5, org, 16);
  }
  string = "" + anim.badPlaceInt;
  badplace_cylinder(string, 5, org, 16, 64, self.team);
  anim.badPlaces[anim.badPlaces.size] = string;
  if(anim.badPlaces.size >= 10) {
    newArray = [];
    for(i = 1; i < anim.badPlaces.size; i++) {
      newArray[newArray.size] = anim.badPlaces[i];
    }
    badplace_delete(anim.badPlaces[0]);
    anim.badPlaces = newArray;
  }
  anim.badPlaceInt++;
  if(anim.badPlaceInt > 10) {
    anim.badPlaceInt -= 20;
  }
}

valueIsWithin(value, min, max) {
  if(value > min && value < max) {
    return true;
  }
  return false;
}

getGunYawToShootEntOrPos() {
  if(!isDefined(self.shootPos)) {
    assert(!isDefined(self.shootEnt));
    return 0;
  }
  yaw = self gettagangles("tag_weapon")[1] - GetYaw(self.shootPos);
  yaw = AngleClamp180(yaw);
  return yaw;
}

getGunPitchToShootEntOrPos() {
  if(!isDefined(self.shootPos)) {
    assert(!isDefined(self.shootEnt));
    return 0;
  }
  pitch = self gettagangles("tag_weapon")[0] - VectorToAngles(self.shootPos - self gettagorigin("tag_weapon"))[0];
  pitch = AngleClamp180(pitch);
  return pitch;
}

getPitchToEnemy() {
  if(!isDefined(self.enemy)) {
    return 0;
  }
  vectorToEnemy = self.enemy getshootatpos() - self getshootatpos();
  vectorToEnemy = vectornormalize(vectortoenemy);
  pitchDelta = 360 - vectortoangles(vectorToEnemy)[0];
  return AngleClamp180(pitchDelta);
}

getPitchToSpot(spot) {
  if(!isDefined(spot)) {
    return 0;
  }
  vectorToEnemy = spot - self getshootatpos();
  vectorToEnemy = vectornormalize(vectortoenemy);
  pitchDelta = 360 - vectortoangles(vectorToEnemy)[0];
  return AngleClamp180(pitchDelta);
}

anim_set_next_move_to_new_cover() {
  self.a.next_move_to_new_cover = randomintrange(1, 4);
}

watchReloading() {
  self.isreloading = false;
  while(1) {
    self waittill("reload_start");
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
    if(!isDefined(self.enemy) || !isalive(self.enemy) || !isSentient(self.enemy)) {
      self waittill("enemy");
      continue;
    }
    attackSpecificEnemyWhenFlashed();
  }
}

attackSpecificEnemyWhenFlashed() {
  self endon("enemy");
  self.enemy endon("death");
  if(isDefined(self.enemy.flashendtime) && gettime() < self.enemy.flashendtime) {
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
  if(distanceSquared(self.origin, self.enemy.origin) > 1024 * 1024) {
    return;
  }
  while(gettime() < self.enemy.flashendtime - 500) {
    if(!self cansee(self.enemy) && distanceSquared(self.origin, self.enemy.origin) < 800 * 800) {
      tryRunningToEnemy(true);
    }
    wait .05;
  }
}

shouldThrowFlashBangAtEnemy() {
  if(distanceSquared(self.origin, self.enemy.origin) > 768 * 768) {
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
  self.flashendtime = gettime() + duration;
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
    self setFlashBanged(true, duration);
    self notify("doFlashBanged", attacker);
  }
}

isSniper() {
  return self.isSniper;
}

isSniperRifle(weapon) {
  return isDefined(anim.sniperRifles[weapon]);
}

Rechamber(optionalAnimation) {
  self endon("killanimscript");
  if(!NeedToRechamber()) {
    return false;
  }
  self thread putGunBackInHandOnKillAnimScript();
  if(isDefined(optionalAnimation)) {
    self setAnim( % rechamber);
    self setFlaggedAnimKnobLimitedRestart("rechamberanim", optionalAnimation, 1, .2, 1);
    animscripts\shared::DoNoteTracks("rechamberanim");
  } else {
    if(self.a.pose == "prone") {
      self setFlaggedAnimKnobAllRestart("reloadanim", % reload_prone_rifle, % body, 1, .1, 1);
      self UpdateProne( % prone_legs_up, % prone_legs_down, 1, 0.1, 1);
    } else {
      println("Bad anim_pose in combat::Rechamber");
      wait 2;
      return;
    }
  }
  self clearanim( % rechamber, 0.3);
  wait(0.3);
  return true;
}

NeedToRechamber() {
  if(self usingBoltActionWeapon() && self.bulletsInClip) {
    return true;
  }
  return false;
}