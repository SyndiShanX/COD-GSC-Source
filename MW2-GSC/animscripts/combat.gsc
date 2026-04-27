/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: animscripts\combat.gsc
********************************************************/

#include animscripts\Utility;
#include animscripts\SetPoseMovement;
#include animscripts\Combat_utility;
#include animscripts\shared;
#include animscripts\animset;
#include common_scripts\Utility;
#using_animtree("generic_human");

sqr512 = 512 * 512;
sqr285 = 285 * 285;
sqr100 = 100 * 100;

pistolPullOutDistSq = sqr512 * 0.64;
pistolPutBackDistSq = sqr512;

main() {
  if(isDefined(self.no_ai)) {
    return;
  }
  if(isDefined(self.onSnowMobile)) {
    animscripts\snowmobile::main();
    return;
  }

  self endon("killanimscript");

  [[self.exception["exposed"]]]();

  animscripts\utility::initialize("combat");
  self.a.arrivalType = undefined;

  if(isDefined(self.node) && self.node.type == "Ambush" && self nearNode(self.node))
    self.ambushNode = self.node;

  if(getDvar("scr_testgrenadethrows") == "on")
    testGrenadeThrowAnimOffsets();

  self transitionToCombat();

  self do_friendly_fire_reaction();

  animscripts\stop::specialIdleLoop();

  self setup();

  self exposedCombatMainLoop();

  self notify("stop_deciding_how_to_shoot");
}

end_script() {
  self.ambushNode = undefined;
}

do_friendly_fire_reaction() {
  if(self.team != "allies") {
    return;
  }
  if(self IsMoveSuppressed() && self.prevScript == "move" && self.a.pose == "stand" && !isDefined(self.disableFriendlyFireReaction)) {
    if(isDefined(self.enemy) && distanceSquared(self.origin, self.enemy.origin) < squared(128)) {
      return;
    }
    self animmode("zonly_physics");
    self setFlaggedAnimKnobAllRestart("react", %surprise_stop_v1, %root, 1, 0.2, self.animplaybackrate);
    self animscripts\shared::DoNoteTracks("react");
  }
}

transitionToCombat() {
  if(isDefined(self.specialIdleAnim) || isDefined(self.customIdleAnimSet)) {
    return;
  }
  if(isDefined(self.enemy) && distanceSquared(self.origin, self.enemy.origin) < 512 * 512) {
    return;
  }
  if(self.prevScript == "stop" && !self isCQBWalking() && self.a.pose == "stand") {
    self animmode("zonly_physics");
    self setFlaggedAnimKnobAllRestart("transition", %casual_stand_idle_trans_out, %root, 1, 0.2, 1.2 * self.animplaybackrate);
    self animscripts\shared::DoNoteTracks("transition");
  }
}

testGrenadeThrowAnimOffsets() {
  model = getGrenadeModel();

  self animmode("zonly_physics");
  self OrientMode("face angle", self.angles[1]);
  self.keepClaimedNodeIfValid = true;
  foreach(throwAnim in anim.grenadeThrowAnims) {
    forward = anglesToForward(self.angles);
    right = anglestoright(self.angles);
    startpos = self.origin;

    tag = "TAG_INHAND";

    self setFlaggedAnimKnobAllRestart("grenadetest", throwAnim, %root, 1, 0, 1);
    for(;;) {
      self waittill("grenadetest", notetrack);
      if(notetrack == "grenade_left" || notetrack == "grenade_right")
        self attach(model, tag);
      if(notetrack == "grenade_throw" || notetrack == "grenade throw") {
        break;
      }
      assert(notetrack != "end");
      if(notetrack == "end") {
        break;
      }
    }

    pos = self getTagOrigin(tag);
    baseoffset = pos - startpos;

    offset = (vectordot(baseoffset, forward), -1 * vectordot(baseoffset, right), baseoffset[2]);

    endpos = startpos + forward * offset[0] - right * offset[1] + (0, 0, 1) * offset[2];
    thread debugLine(startpos, endpos, (1, 1, 1), 20);

    println("addGrenadeThrowAnimOffset(%", throwAnim, ", ", offset, " );");

    self detach(model, tag);

    wait 1;
  }
  self.keepClaimedNodeIfValid = false;
}

setup_anim_array() {
  if(self.a.pose == "stand") {
    self set_animarray_standing();
  } else if(self.a.pose == "crouch") {
    self set_animarray_crouching();
  } else if(self.a.pose == "prone") {
    self set_animarray_prone();
  } else {
    assertMsg("Unsupported self.a.pose: " + self.a.pose);
  }
}
setup() {
  if(usingSidearm() && self isStanceAllowed("stand"))
    transitionTo("stand");

  setup_anim_array();

  set_aim_and_turn_limits();

  self thread stopShortly();
  self.previousPitchDelta = 0.0;

  self clearAnim(%root, .2);

  setupAim(.2);

  self thread aimIdleThread();

  self.a.meleeState = "aim";

  self delayStandardMelee();
}

stopShortly() {
  self endon("killanimscript");

  wait .2;
  self.a.movement = "stop";
}

set_aim_and_turn_limits() {
  self setDefaultAimLimits();

  if(self.a.pose == "stand") {
    self.upAimLimit = 60;
    self.downAimLimit = -60;
  }

  self.turnThreshold = self.defaultTurnThreshold;
}

setupExposedCombatLoop() {
  self thread trackShootEntOrPos();
  self thread ReacquireWhenNecessary();
  self thread animscripts\shoot_behavior::decideWhatAndHowToShoot("normal");
  self thread watchShootEntVelocity();

  self resetGiveUpOnEnemyTime();

  if(isDefined(self.a.magicReloadWhenReachEnemy)) {
    self animscripts\weaponList::RefillClip();
    self.a.magicReloadWhenReachEnemy = undefined;
  }

  self.a.dontCrouchTime = gettime() + randomintrange(500, 1500);
}

exposedCombatStopUsingRPGCheck(distSqToShootPos) {
  if(usingRocketLauncher() && (distSqToShootPos < sqr512 || self.a.rockets < 1)) {
    if(self.a.pose != "stand" && self.a.pose != "crouch")
      transitionTo("crouch");

    if(self.a.pose == "stand")
      animscripts\shared::throwDownWeapon(%RPG_stand_throw);
    else
      animscripts\shared::throwDownWeapon(%RPG_crouch_throw);

    self clearAnim(%root, 0.2);

    self endFireAndAnimIdleThread();
    self setup_anim_array();
    self startFireAndAimIdleThread();
    return true;
  }

  return false;
}

exposedCombatCheckStance(distSqToShootPos) {
  if(self.a.pose != "stand" && self isStanceAllowed("stand")) {
    if(distSqToShootPos < sqr285) {
      transitionTo("stand");
      return true;
    }
    if(standIfMakesEnemyVisible())
      return true;
  }

  if(distSqToShootPos > sqr512 && self.a.pose != "crouch" && self isStanceAllowed("crouch") && !usingSidearm() && !isDefined(self.heat) && gettime() >= self.a.dontCrouchTime && lengthSquared(self.shootEntVelocity) < sqr100) {
    if(!isDefined(self.shootPos) || sightTracePassed(self.origin + (0, 0, 36), self.shootPos, false, undefined)) {
      transitionTo("crouch");
      return true;
    }
  }

  return false;
}

exposedCombatCheckReloadOrUsePistol(distSqToShootPos) {
  if(!usingSidearm()) {
    if(isDefined(self.forceSideArm) && self.a.pose == "stand") {
      if(self tryUsingSidearm())
        return true;
    }

    if(isSniper() && distSqToShootPos < pistolPullOutDistSq) {
      if(self tryUsingSidearm())
        return true;
    }
  }

  if(NeedToReload(0)) {
    if(!usingSidearm() && cointoss() && !usingRocketLauncher() && usingPrimary() && distSqToShootPos < pistolPullOutDistSq && self isStanceAllowed("stand")) {
      if(self.a.pose != "stand") {
        transitionTo("stand");
        return true;
      }

      if(self tryUsingSidearm())
        return true;
    }

    if(self exposedReload(0))
      return true;
  }

  return false;
}

exposedCombatCheckPutAwayPistol(distSqToShootPos) {
  if(usingSidearm() && self.a.pose == "stand" && !isDefined(self.forceSideArm))
    if((distSqToShootPos > pistolPutBackDistSq) || (self.combatMode == "ambush_nodes_only" && (!isDefined(self.enemy) || !self cansee(self.enemy))))
      switchToLastWeapon(%pistol_stand_switch);
}

exposedCombatPositionAdjust() {
  if(isDefined(self.heat) && self nearClaimNodeAndAngle()) {
    assert(isDefined(self.node));
    self safeTeleport(self.nodeoffsetpos, self.node.angles);
  }
}

exposedCombatNeedToTurn() {
  if(needToTurn()) {
    predictTime = 0.25;
    if(isDefined(self.shootEnt) && !isSentient(self.shootEnt))
      predictTime = 1.5;
    yawToShootEntOrPos = getPredictedAimYawToShootEntOrPos(predictTime);
    if(TurnToFaceRelativeYaw(yawToShootEntOrPos))
      return true;
  }

  return false;
}

exposedCombatMainLoop() {
  self endon("killanimscript");
  self endon("combat_restart");

  self setupExposedCombatLoop();

  self animMode("zonly_physics", false);
  self OrientMode("face angle", self.angles[1]);

  for(;;) {
    if(usingRocketLauncher())
      self.deathFunction = undefined;

    self IsInCombat();

    if(WaitForStanceChange()) {
      continue;
    }
    tryMelee();

    exposedCombatPositionAdjust();

    if(!isDefined(self.shootPos)) {
      assert(!isDefined(self.shootEnt));
      cantSeeEnemyBehavior();

      if(!isDefined(self.enemy))
        justWaited = true;
      continue;
    }

    assert(isDefined(self.shootPos));
    self resetGiveUpOnEnemyTime();

    distSqToShootPos = lengthsquared(self.origin - self.shootPos);

    if(exposedCombatStopUsingRPGCheck(distSqToShootPos)) {
      continue;
    }
    if(exposedCombatNeedToTurn()) {
      continue;
    }
    if(considerThrowGrenade()) {
      continue;
    }
    if(exposedCombatCheckReloadOrUsePistol(distSqToShootPos)) {
      continue;
    }
    if(usingRocketLauncher() && self.a.pose != "crouch" && randomFloat(1) > 0.65)
      self.deathFunction = ::rpgDeath;

    exposedCombatCheckPutAwayPistol(distSqToShootPos);

    if(exposedCombatCheckStance(distSqToShootPos)) {
      continue;
    }
    if(aimedAtShootEntOrPos()) {
      self shootUntilNeedToTurn();
      self hideFireShowAimIdle();
      continue;
    }

    exposedWait();
  }
}

exposedWait() {
  if(!isDefined(self.enemy) || !self cansee(self.enemy)) {
    self endon("enemy");
    self endon("shoot_behavior_change");

    wait 0.2 + randomfloat(0.1);
    self waittill("do_slow_things");
  } else {
    wait 0.05;
  }
}

standIfMakesEnemyVisible() {
  assert(self.a.pose != "stand");
  assert(self isStanceAllowed("stand"));
  if(isDefined(self.enemy) && (!self cansee(self.enemy) || !self canShootEnemy()) && sightTracePassed(self.origin + (0, 0, 64), self.enemy getShootAtPos(), false, undefined)) {
    self.a.dontCrouchTime = gettime() + 3000;
    transitionTo("stand");
    return true;
  }
  return false;
}

needToTurn() {
  point = self.shootPos;
  if(!isDefined(point))
    return false;

  yaw = self.angles[1] - VectorToYaw(point - self.origin);

  distsq = distanceSquared(self.origin, point);
  if(distsq < 256 * 256) {
    dist = sqrt(distsq);
    if(dist > 3)
      yaw += asin(-3 / dist);
  }
  return AbsAngleClamp180(yaw) > self.turnThreshold;
}

WaitForStanceChange() {
  curstance = self.a.pose;

  if(isDefined(self.a.onback)) {
    wait 0.1;
    return true;
  }

  if(curstance == "stand" && isDefined(self.heat))
    return false;

  if(!self isStanceAllowed(curstance)) {
    assert(curstance == "stand" || curstance == "crouch" || curstance == "prone");

    otherstance = "crouch";
    if(curstance == "crouch")
      otherstance = "stand";

    if(self isStanceAllowed(otherstance)) {
      if(curstance == "stand" && usingSidearm())
        return false;

      transitionTo(otherstance);
      return true;
    }
  }
  return false;
}

cantSeeEnemyBehavior() {
  if(self.a.pose != "stand" && self isStanceAllowed("stand") && standIfMakesEnemyVisible())
    return true;

  time = gettime();

  self.a.dontCrouchTime = time + 1500;

  if(isDefined(self.group) && isDefined(self.group.forward)) {
    relYaw = AngleClamp180(self.angles[1] - vectorToYaw(self.group.forward));
    if(self TurnToFaceRelativeYaw(relYaw))
      return true;
  }

  if(isDefined(self.node) && isDefined(anim.isCombatScriptNode[self.node.type])) {
    relYaw = AngleClamp180(self.angles[1] - self.node.angles[1]);
    if(self TurnToFaceRelativeYaw(relYaw))
      return true;
  } else if((isDefined(self.enemy) && self seeRecently(self.enemy, 2)) || time > self.a.scriptStartTime + 1200) {
    relYaw = undefined;
    likelyEnemyDir = self getAnglesToLikelyEnemyPath();
    if(isDefined(likelyEnemyDir)) {
      relYaw = AngleClamp180(self.angles[1] - likelyEnemyDir[1]);
    } else if(isDefined(self.node)) {
      relYaw = AngleClamp180(self.angles[1] - self.node.angles[1]);
    } else if(isDefined(self.enemy)) {
      likelyEnemyDir = vectorToAngles(self lastKnownPos(self.enemy) - self.origin);
      relYaw = AngleClamp180(self.angles[1] - likelyEnemyDir[1]);
    }

    if(isDefined(relYaw) && self TurnToFaceRelativeYaw(relYaw))
      return true;
  } else if(isDefined(self.heat) && self nearClaimNode()) {
    relYaw = AngleClamp180(self.angles[1] - self.node.angles[1]);
    if(self TurnToFaceRelativeYaw(relYaw))
      return true;
  }

  if(considerThrowGrenade())
    return true;

  givenUpOnEnemy = (self.a.nextGiveUpOnEnemyTime < time);

  threshold = 0;
  if(givenUpOnEnemy)
    threshold = 0.99999;

  if(self exposedReload(threshold))
    return true;

  if(givenUpOnEnemy && usingSidearm()) {
    switchToLastWeapon(%pistol_stand_switch);
    return true;
  }

  cantSeeEnemyWait();
  return true;
}

cantSeeEnemyWait() {
  self endon("shoot_behavior_change");

  wait 0.4 + randomfloat(0.4);
  self waittill("do_slow_things");
}

resetGiveUpOnEnemyTime() {
  self.a.nextGiveUpOnEnemyTime = gettime() + randomintrange(2000, 4000);
}

TurnToFaceRelativeYaw(faceYaw) {
  if(faceYaw < 0 - self.turnThreshold) {
    if(self.a.pose == "prone") {
      self animscripts\cover_prone::proneTo("crouch");
      self set_animarray_crouching();
    }

    self doTurn("left", 0 - faceYaw);
    self maps\_gameskill::didSomethingOtherThanShooting();
    return true;
  }
  if(faceYaw > self.turnThreshold) {
    if(self.a.pose == "prone") {
      self animscripts\cover_prone::proneTo("crouch");
      self set_animarray_crouching();
    }

    self doTurn("right", faceYaw);
    self maps\_gameskill::didSomethingOtherThanShooting();
    return true;
  }
  return false;
}

watchShootEntVelocity() {
  self endon("killanimscript");

  self.shootEntVelocity = (0, 0, 0);

  prevshootent = undefined;
  prevpos = self.origin;

  interval = .15;

  while(1) {
    if(isDefined(self.shootEnt) && isDefined(prevshootent) && self.shootEnt == prevshootent) {
      curpos = self.shootEnt.origin;
      self.shootEntVelocity = vector_multiply(curpos - prevpos, 1 / interval);
      prevpos = curpos;
    } else {
      if(isDefined(self.shootEnt))
        prevpos = self.shootEnt.origin;
      else
        prevpos = self.origin;
      prevshootent = self.shootEnt;

      self.shootEntVelocity = (0, 0, 0);
    }

    wait interval;
  }
}

shouldSwapShotgun() {
  return false;
}

DoNoteTracksWithEndon(animname) {
  self endon("killanimscript");
  self animscripts\shared::DoNoteTracks(animname);
}
faceEnemyImmediately() {
  self endon("killanimscript");
  self notify("facing_enemy_immediately");
  self endon("facing_enemy_immediately");

  maxYawChange = 5;

  while(1) {
    yawChange = 0 - GetYawToEnemy();

    if(abs(yawChange) < 2) {
      break;
    }

    if(abs(yawChange) > maxYawChange)
      yawChange = maxYawChange * sign(yawChange);

    self OrientMode("face angle", self.angles[1] + yawChange);

    wait .05;
  }

  self OrientMode("face current");

  self notify("can_stop_turning");
}

isDeltaAllowed(theanim) {
  delta = getMoveDelta(theanim, 0, 1);
  endPoint = self localToWorldCoords(delta);

  return self isInGoal(endPoint) && self mayMoveToPoint(endPoint);
}

isAnimDeltaInGoal(theanim) {
  delta = getMoveDelta(theanim, 0, 1);
  endPoint = self localToWorldCoords(delta);

  return self isInGoal(endPoint);
}

doTurn(direction, amount) {
  knowWhereToShoot = isDefined(self.shootPos);
  rate = 1;
  transTime = 0.2;
  mustFaceEnemy = (isDefined(self.enemy) && !isDefined(self.turnToMatchNode) && self seeRecently(self.enemy, 2) && distanceSquared(self.enemy.origin, self.origin) < sqr512);
  if(self.a.scriptStartTime + 500 > gettime()) {
    transTime = 0.25;
    if(mustFaceEnemy)
      self thread faceEnemyImmediately();
  } else if(mustFaceEnemy) {
    urgency = 1.0 - (distance(self.enemy.origin, self.origin) / 512);
    rate = 1 + urgency * 1;

    if(rate > 2)
      transTime = .05;
    else if(rate > 1.3)
      transTime = .1;
    else
      transTime = .15;
  }

  angle = 0;
  if(amount > 157.5)
    angle = 180;
  else if(amount > 112.5)
    angle = 135;
  else if(amount > 67.5)
    angle = 90;
  else
    angle = 45;

  animname = "turn_" + direction + "_" + angle;
  turnanim = animarray(animname);

  if(isDefined(self.turnToMatchNode))
    self animmode("angle deltas", false);
  else if(isDefined(self.node) && isDefined(anim.isCombatPathNode[self.node.type]) && distanceSquared(self.origin, self.node.origin) < 16 * 16)
    self animmode("angle deltas", false);
  else if(isAnimDeltaInGoal(turnanim))
    self animMode("zonly_physics", false);
  else
    self animmode("angle deltas", false);

  self setAnimKnobAll(%exposed_aiming, %body, 1, transTime);

  if(!isDefined(self.turnToMatchNode))
    self TurningAimingOn(transTime);

  self setAnimLimited(%turn, 1, transTime);

  if(isDefined(self.heat))
    rate = min(1.0, rate);
  else if(isDefined(self.turnToMatchNode))
    rate = max(1.5, rate);

  self setFlaggedAnimKnobLimitedRestart("turn", turnanim, 1, transTime, rate);
  self notify("turning");

  if(knowWhereToShoot && !isDefined(self.turnToMatchNode) && !isDefined(self.heat))
    self thread shootWhileTurning();

  doTurnNotetracks();

  self setanimlimited(%turn, 0, .2);

  if(!isDefined(self.turnToMatchNode))
    self TurningAimingOff(.2);

  if(!isDefined(self.turnToMatchNode)) {
    self clearanim(%turn, .2);
    self setanimknob(%exposed_aiming, 1, .2, 1);
  } else {
    self clearanim(%exposed_modern, .3);
  }

  if(isDefined(self.turnLastResort)) {
    self.turnLastResort = undefined;
    self thread faceEnemyImmediately();
  }

  self animMode("zonly_physics", false);

  self notify("done turning");
}

doTurnNotetracks() {
  self endon("can_stop_turning");

  self animscripts\shared::DoNoteTracks("turn");
}

makeSureTurnWorks() {
  self endon("killanimscript");
  self endon("done turning");

  startAngle = self.angles[1];

  wait .3;

  if(self.angles[1] == startAngle) {
    self notify("turning_isnt_working");
    self.turnLastResort = true;
  }
}

TurningAimingOn(transTime) {
  self setAnimLimited(animarray("straight_level"), 0, transTime);
  self setAnim(%add_idle, 0, transTime);

  if(!weapon_pump_action_shotgun())
    self clearAnim(%add_fire, .2);
}

TurningAimingOff(transTime) {
  self setAnimLimited(animarray("straight_level"), 1, transTime);
  self setAnim(%add_idle, 1, transTime);
}

shootWhileTurning() {
  self endon("killanimscript");
  self endon("done turning");

  if(usingRocketLauncher()) {
    return;
  }
  shootUntilShootBehaviorChange();

  self clearAnim(%add_fire, .2);
}

shootUntilNeedToTurn() {
  self thread watchForNeedToTurnOrTimeout();
  self endon("need_to_turn");

  self thread keepTryingToMelee();

  shootUntilShootBehaviorChange();

  self notify("stop_watching_for_need_to_turn");
  self notify("stop_trying_to_melee");
}

watchForNeedToTurnOrTimeout() {
  self endon("killanimscript");
  self endon("stop_watching_for_need_to_turn");

  endtime = gettime() + 4000 + randomint(2000);

  while(1) {
    if(gettime() > endtime || needToTurn()) {
      self notify("need_to_turn");
      break;
    }
    wait .1;
  }
}

considerThrowGrenade() {
  if(!myGrenadeCoolDownElapsed())
    return false;

  if(isDefined(anim.throwGrenadeAtPlayerASAP) && isAlive(level.player)) {
    if(tryExposedThrowGrenade(level.player, 200))
      return true;
  }

  if(isDefined(self.enemy) && tryExposedThrowGrenade(self.enemy, self.minExposedGrenadeDist))
    return true;

  self.a.nextGrenadeTryTime = gettime() + 500;

  return false;
}

tryExposedThrowGrenade(throwAt, minDist) {
  threw = false;

  if(isDefined(self.dontEverShoot) || isDefined(throwAt.dontAttackMe))
    return false;

  if(!isDefined(self.a.array["exposed_grenade"]))
    return false;

  throwSpot = throwAt.origin;
  if(!self canSee(throwAt)) {
    if(isDefined(self.enemy) && throwAt == self.enemy && isDefined(self.shootPos))
      throwSpot = self.shootPos;
  }

  if(!self canSee(throwAt))
    minDist = 100;

  if(distanceSquared(self.origin, throwSpot) > minDist * minDist && self.a.pose == self.a.grenadeThrowPose) {
    self setActiveGrenadeTimer(throwAt);

    if(!grenadeCoolDownElapsed(throwAt))
      return false;

    yaw = GetYawToSpot(throwSpot);
    if(abs(yaw) < 60) {
      throwAnims = [];

      foreach(throwAnim in (self.a.array["exposed_grenade"])) {
        if(isDeltaAllowed(throwAnim))
          throwAnims[throwAnims.size] = throwAnim;
      }

      if(throwAnims.size > 0) {
        self setanim(%exposed_aiming, 0, .1);
        self animMode("zonly_physics");

        setAnimAimWeight(0, 0);

        threw = TryGrenade(throwAt, throwAnims[randomint(throwAnims.size)]);

        self setanim(%exposed_aiming, 1, .1);

        if(threw)
          setAnimAimWeight(1, .5);
        else
          setAnimAimWeight(1, 0);
      }
    }
  }

  if(threw)
    self maps\_gameskill::didSomethingOtherThanShooting();

  return threw;
}

transitionTo(newPose) {
  if(newPose == self.a.pose) {
    return;
  }

  transAnimName = self.a.pose + "_2_" + newPose;

  if(!isDefined(self.a.array)) {
    return;
  }
  transAnim = self.a.array[transAnimName];

  if(!isDefined(transAnim)) {
    return;
  }
  self clearanim(%root, .3);

  self endFireAndAnimIdleThread();

  if(newPose == "stand")
    rate = 2;
  else
    rate = 1.5;

  if(!animHasNoteTrack(transAnim, "anim_pose = \"" + newPose + "\"")) {
    println("error: " + self.a.pose + "_2_" + newPose + " missing notetrack to set pose!");
  }

  self setFlaggedAnimKnobAllRestart("trans", transanim, %body, 1, .2, rate);
  transTime = getAnimLength(transanim) / rate;
  playTime = transTime - 0.3;
  if(playTime < 0.2)
    playTime = 0.2;
  self animscripts\shared::DoNoteTracksForTime(playTime, "trans");

  self.a.pose = newPose;

  setup_anim_array();

  self startFireAndAimIdleThread();

  self maps\_gameskill::didSomethingOtherThanShooting();
}

keepTryingToMelee() {
  self endon("killanimscript");
  self endon("stop_trying_to_melee");
  self endon("done turning");
  self endon("need_to_turn");
  self endon("shoot_behavior_change");

  while(1) {
    wait .2 + randomfloat(.3);

    if(isDefined(self.enemy)) {
      if(isPlayer(self.enemy))
        checkDistSq = 200 * 200;
      else
        checkDistSq = 100 * 100;

      if(distanceSquared(self.enemy.origin, self.origin) < checkDistSq)
        tryMelee();
    }
  }
}

tryMelee() {
  animscripts\melee::Melee_TryExecuting();
}

delayStandardMelee() {
  if(isDefined(self.noMeleeChargeDelay)) {
    return;
  }
  if(isPlayer(self.enemy)) {
    return;
  }

  animscripts\melee::Melee_Standard_DelayStandardCharge(self.enemy);
}

exposedReload(threshold) {
  if(NeedToReload(threshold)) {
    self.a.exposedReloading = true;
    self endFireAndAnimIdleThread();

    reloadAnim = undefined;
    if(isDefined(self.specialReloadAnimFunc)) {
      reloadAnim = self[[self.specialReloadAnimFunc]]();
      self.keepClaimedNode = true;
    } else {
      reloadAnim = animArrayPickRandom("reload");

      if(self.a.pose == "stand" && animArrayAnyExist("reload_crouchhide") && cointoss())
        reloadAnim = animArrayPickRandom("reload_crouchhide");
    }

    self thread keepTryingToMelee();

    self.finishedReload = false;

    if(weaponClass(self.weapon) == "pistol")
      self orientmode("face default");

    self doReloadAnim(reloadAnim, threshold > .05);
    self notify("abort_reload");
    self orientmode("face current");

    if(self.finishedReload)
      self animscripts\weaponList::RefillClip();

    self clearanim(%reload, .2);
    self.keepClaimedNode = false;

    self notify("stop_trying_to_melee");

    self.a.exposedReloading = false;

    self maps\_gameskill::didSomethingOtherThanShooting();

    self startFireAndAimIdleThread();

    return true;
  }

  return false;
}

doReloadAnim(reloadAnim, stopWhenCanShoot) {
  self endon("abort_reload");
  if(stopWhenCanShoot)
    self thread abortReloadWhenCanShoot();

  animRate = 1;

  if(!self usingSidearm() && !isShotgun(self.weapon) && isDefined(self.enemy) && self canSee(self.enemy) && distanceSquared(self.enemy.origin, self.origin) < 1024 * 1024)
    animRate = 1.2;

  flagName = "reload_" + getUniqueFlagNameIndex();

  self clearanim(%root, 0.2);
  self setflaggedanimrestart(flagName, reloadAnim, 1, .2, animRate);
  self thread notifyOnStartAim("abort_reload", flagName);
  self endon("start_aim");
  self animscripts\shared::DoNoteTracks(flagName);

  self.finishedReload = true;
}

abortReloadWhenCanShoot() {
  self endon("abort_reload");
  self endon("killanimscript");
  while(1) {
    if(isDefined(self.shootEnt) && self canSee(self.shootEnt)) {
      break;
    }
    wait .05;
  }
  self notify("abort_reload");
}

notifyOnStartAim(endonStr, flagName) {
  self endon(endonStr);
  self waittillmatch(flagName, "start_aim");
  self.finishedReload = true;
  self notify("start_aim");
}

finishNoteTracks(animname) {
  self endon("killanimscript");
  animscripts\shared::DoNoteTracks(animname);
}

drop_turret() {
  maps\_mgturret::dropTurret();

  self animscripts\weaponList::RefillClip();
  self.a.needsToRechamber = 0;
  self notify("dropped_gun");
  maps\_mgturret::restoreDefaults();
}

exception_exposed_mg42_portable() {
  drop_turret();
}

tryUsingSidearm() {
  if(isDefined(self.secondaryWeapon) && isShotgun(self.secondaryweapon))
    return false;

  if(isDefined(self.no_pistol_switch))
    return false;

  self.a.pose = "stand";

  switchToSidearm(%pistol_stand_pullout);

  return true;
}

switchToSidearm(swapAnim) {
  self endon("killanimscript");
  assert(self.sidearm != "");

  self thread putGunBackInHandOnKillAnimScript();
  self endFireAndAnimIdleThread();

  self.swapAnim = swapAnim;
  self setFlaggedAnimKnobAllRestart("weapon swap", swapAnim, %body, 1, .2, fasterAnimSpeed());
  self DoNoteTracksPostCallbackWithEndon("weapon swap", ::handlePickup, "end_weapon_swap");
  self clearAnim(self.swapAnim, 0.2);

  self notify("facing_enemy_immediately");

  self notify("switched_to_sidearm");
  self maps\_gameskill::didSomethingOtherThanShooting();
}

DoNoteTracksPostCallbackWithEndon(flagName, interceptFunction, endonMsg) {
  self endon(endonMsg);
  self animscripts\shared::DoNoteTracksPostCallback(flagName, interceptFunction);
}

faceEnemyDelay(delay) {
  self endon("killanimscript");
  wait delay;
  self faceEnemyImmediately();
}

handlePickup(notetrack) {
  if(notetrack == "pistol_pickup") {
    self clearAnim(animarray("straight_level"), 0);
    self set_animarray_standing();

    self thread faceEnemyDelay(0.25);
  } else if(notetrack == "start_aim") {
    startFireAndAimIdleThread();

    if(self needToTurn())
      self notify("end_weapon_swap");
  }
}
switchToLastWeapon(swapAnim, cleanUp) {
  self endon("killanimscript");

  assertex(self.lastWeapon != getAISidearmWeapon() || self.lastWeapon == "none", "AI \"" + self.classname + "\" using sidearm trying to switch back to sidearm. lastweapon = \"" + self.lastWeapon + "\", primaryweapon = \"" + self.primaryweapon + "\"");
  assertex(self.lastWeapon == getAIPrimaryWeapon() || self.lastWeapon == getAISecondaryWeapon());

  self endFireAndAnimIdleThread();

  self.swapAnim = swapAnim;
  self setFlaggedAnimKnobAllRestart("weapon swap", swapAnim, %body, 1, .1, 1);

  if(isDefined(cleanUp))
    self DoNoteTracksPostCallbackWithEndon("weapon swap", ::handleCleanUpPutaway, "end_weapon_swap");
  else
    self DoNoteTracksPostCallbackWithEndon("weapon swap", ::handlePutaway, "end_weapon_swap");
  self clearanim(self.swapAnim, 0.2);

  self notify("switched_to_lastweapon");
  self maps\_gameskill::didSomethingOtherThanShooting();
}

handlePutaway(notetrack) {
  if(notetrack == "pistol_putaway") {
    self clearAnim(animarray("straight_level"), 0);
    self set_animarray_standing();

    self thread putGunBackInHandOnKillAnimScript();
  } else if(notetrack == "start_aim") {
    startFireAndAimIdleThread();

    if(self needToTurn())
      self notify("end_weapon_swap");
  }
}

handleCleanUpPutaway(notetrack) {
  if(notetrack == "pistol_putaway")
    self thread putGunBackInHandOnKillAnimScript();
  else if(issubstr(notetrack, "anim_gunhand"))
    self notify("end_weapon_swap");
}

rpgDeath() {
  if(!usingRocketLauncher() || self.bulletsInClip == 0)
    return false;

  if(randomFloat(1) > 0.5)
    self SetFlaggedAnimKnobAll("deathanim", %RPG_stand_death, %root, 1, .05, 1);
  else
    self SetFlaggedAnimKnobAll("deathanim", %RPG_stand_death_stagger, %root, 1, .05, 1);

  self animscripts\shared::DoNoteTracks("deathanim");
  self animscripts\shared::DropAllAIWeapons();
  return;
}

ReacquireWhenNecessary() {
  self endon("killanimscript");

  self.a.exposedReloading = false;

  while(1) {
    wait .2;

    if(isDefined(self.enemy) && !self seeRecently(self.enemy, 2)) {
      if(self.combatMode == "ambush" || self.combatMode == "ambush_nodes_only")
        continue;
    }

    TryExposedReacquire();
  }
}
TryExposedReacquire() {
  if(self.fixedNode) {
    return;
  }

  if(!isDefined(self.enemy)) {
    self.reacquire_state = 0;
    return;
  }

  if(gettime() < self.teamMoveWaitTime) {
    self.reacquire_state = 0;
    return;
  }

  if(isDefined(self.prevEnemy) && self.prevEnemy != self.enemy) {
    self.reacquire_state = 0;
    self.prevEnemy = undefined;
    return;
  }
  self.prevEnemy = self.enemy;

  if(self canSee(self.enemy) && self canShootEnemy()) {
    self.reacquire_state = 0;
    return;
  }

  if(isDefined(self.finishedReload) && !self.finishedReload) {
    self.reacquire_state = 0;
    return;
  }

  dirToEnemy = vectornormalize(self.enemy.origin - self.origin);
  forward = anglesToForward(self.angles);

  if(vectordot(dirToEnemy, forward) < 0.5) {
    self.reacquire_state = 0;
    return;
  }

  if(self.a.exposedReloading && NeedToReload(.25) && self.enemy.health > self.enemy.maxhealth * .5) {
    self.reacquire_state = 0;
    return;
  }

  if(shouldHelpAdvancingTeammate() && self.reacquire_state < 3)
    self.reacquire_state = 3;

  switch (self.reacquire_state) {
    case 0:
      if(self ReacquireStep(32))
        return;
      break;

    case 1:
      if(self ReacquireStep(64)) {
        self.reacquire_state = 0;
        return;
      }
      break;

    case 2:
      if(self ReacquireStep(96)) {
        self.reacquire_state = 0;
        return;
      }
      break;

    case 3:
      if(tryRunningToEnemy(false)) {
        self.reacquire_state = 0;
        return;
      }
      break;

    case 4:
      if(!(self canSee(self.enemy)) || !(self canShootEnemy()))
        self FlagEnemyUnattackable();
      break;

    default:

      if(self.reacquire_state > 15) {
        self.reacquire_state = 0;
        return;
      }
      break;
  }

  self.reacquire_state++;
}