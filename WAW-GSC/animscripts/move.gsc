/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\move.gsc
**************************************/

#include animscripts\SetPoseMovement;
#include animscripts\combat_utility;
#include animscripts\utility;
#include animscripts\shared;
#include common_scripts\utility;
#using_animtree("generic_human");

main() {
  self endon("killanimscript");

  if(getDvar("showlookaheaddir") == "on") {
    self thread drawLookaheadDir();
  }

  [[self.exception["move"]]]();

  self trackScriptState("Move Main", "code");

  self flamethrower_stop_shoot();

  if(self.a.pose == "prone") {
    newPose = self animscripts\utility::choosePose("stand");

    if(newPose != "prone") {
      self animMode("zonly_physics", false);
      rate = 1;
      if(isDefined(self.grenade)) {
        rate = 2;
      }
      self animscripts\cover_prone::proneTo(newPose, rate);
      self animMode("none", false);
      self orientMode("face default");
    }
  }

  previousScript = self.a.script;
  animscripts\utility::initialize("move");
  if(self.moveMode == "run") {
    switch (previousScript) {
      case "combat":
      case "stop":

        self animscripts\battleChatter_ai::evaluateMoveEvent(false);
        break;

      case "cover_crouch":
      case "cover_left":
      case "cover_prone":
      case "cover_right":
      case "cover_stand":
      case "concealment_crouch":
      case "concealment_prone":
      case "concealment_stand":
      case "cover_wide_left":
      case "cover_wide_right":
      case "stalingrad_cover_crouch":
      case "hide":
      case "turret":

        self animscripts\battleChatter_ai::evaluateMoveEvent(true);
        break;

      default:

        self animscripts\battleChatter_ai::evaluateMoveEvent(false);
        break;
    }
  }

  self animscripts\cover_arrival::startMoveTransition();
  self thread animscripts\cover_arrival::setupApproachNode(true);

  self.cqb_track_thread = undefined;
  self.shoot_while_moving_thread = undefined;

  MoveMainLoop();
}

MoveMainLoop() {
  prevLoopTime = self getAnimTime(%walk_and_run_loops);
  self.a.runLoopCount = randomint(10000);

  moveMode = self.moveMode;
  if(isDefined(self.pathGoalPos) && distanceSquared(self.origin, self.pathGoalPos) < 4096) {
    moveMode = "walk";
  }

  for(;;) {
    loopTime = self getAnimTime(%walk_and_run_loops);
    if(loopTime < prevLoopTime) {
      self.a.runLoopCount++;
    }
    prevLoopTime = loopTime;

    self animscripts\face::SetIdleFaceDelayed(anim.alertface);

    if(self is_banzai()) {
      self animscripts\banzai::move_banzai();
    } else if(self animscripts\cqb::shouldCQB()) {
      self animscripts\cqb::MoveCQB();
    } else {
      if(self is_zombie() || movemode != "run") {
        moveMode = "run";
      }

      if(self.moveMode != "run" && !self is_zombie()) {
        moveMode = self.moveMode;
      } else if(moveMode == "walk") {
        if(!isDefined(self.pathGoalPos) || distanceSquared(self.origin, self.pathGoalPos) > 4096) {
          moveMode = self.moveMode;
        }
      }

      if(moveMode == "run") {
        self animscripts\run::MoveRun();
      } else {
        assert(moveMode == "walk");
        self animscripts\walk::MoveWalk();
      }
    }

    self.exitingCover = false;
  }
}

MayShootWhileMoving() {
  if(self.weapon == "none") {
    return false;
  }

  weapclass = weaponClass(self.weapon);
  if(weapclass != "rifle" && weapclass != "smg" && weapclass != "spread" && weapclass != "mg") {
    return false;
  }

  if(self isSniper()) {
    return false;
  }

  if(isDefined(self.dontShootWhileMoving)) {
    assert(self.dontShootWhileMoving);
    return false;
  }

  return true;
}

shootWhileMoving() {
  self endon("killanimscript");

  self notify("doing_shootWhileMoving");
  self endon("doing_shootWhileMoving");

  if(!isDefined(self.exposedSet) || self.exposedSet == 0) {
    self.a.array["fire"] = % exposed_shoot_auto_v3;
    self.a.array["burst2"] = % exposed_shoot_burst3;
    self.a.array["burst3"] = % exposed_shoot_burst3;
    self.a.array["burst4"] = % exposed_shoot_burst4;
    self.a.array["burst5"] = % exposed_shoot_burst5;
    self.a.array["burst6"] = % exposed_shoot_burst6;
    self.a.array["semi2"] = % exposed_shoot_semi2;
    self.a.array["semi3"] = % exposed_shoot_semi3;
    self.a.array["semi4"] = % exposed_shoot_semi4;
    self.a.array["semi5"] = % exposed_shoot_semi5;
    self.a.array["single"] = array(%exposed_shoot_semi1);
  } else {
    self.a.array["fire"] = % exposed2_shoot_auto_v3;
    self.a.array["burst2"] = % exposed2_shoot_burst3;
    self.a.array["burst3"] = % exposed2_shoot_burst3;
    self.a.array["burst4"] = % exposed2_shoot_burst4;
    self.a.array["burst5"] = % exposed2_shoot_burst5;
    self.a.array["burst6"] = % exposed2_shoot_burst6;
    self.a.array["semi2"] = % exposed2_shoot_semi2;
    self.a.array["semi3"] = % exposed2_shoot_semi3;
    self.a.array["semi4"] = % exposed2_shoot_semi4;
    self.a.array["semi5"] = % exposed2_shoot_semi5;
    self.a.array["single"] = array(%exposed2_shoot_semi1);
  }

  if(isDefined(self.weapon) && weaponClass(self.weapon) == "spread") {
    self.a.array["single"] = array(%shotgun_stand_fire_1A, %shotgun_stand_fire_1B);
  }

  while(1) {
    if(!self.bulletsInClip) {
      if(self isCQBWalking()) {
        cheatAmmoIfNecessary();
      }

      if(self is_banzai()) {
        cheatAmmoIfNecessary();
      }

      if(!self.bulletsInClip) {
        wait 0.5;
        continue;
      }
    }

    self shootUntilShootBehaviorChange();

    self clearAnim(%exposed_aiming, 0.2);
  }
}

combatBreaker() {
  self endon("killanimscript");
  while(isalive(self.enemy) && isDefined(self.node) && self canSee(self.enemy)) {
    if(seekingCoverInMyFov()) {
      break;
    }
    wait(0.25);
  }
  self thread moveAgain();
}

moveAgain() {
  self notify("killanimscript");
  animscripts\move::main();
}

seekingCoverInMyFov() {
  if(distance(self.origin, self.node.origin) > self.goalradius) {
    return true;
  }
  if(distance(self.origin, self.node.origin) < 80) {
    return true;
  }
  enemyAngles = vectorToAngles(self.origin - self.enemy.origin);
  enemyForward = anglesToForward(enemyAngles);
  nodeAngles = vectorToAngles(self.origin - self.node.origin);
  nodeForward = anglesToForward(nodeAngles);
  return (vectorDot(enemyForward, nodeforward) > 0.1);
}

RunBreaker() {
  self endon("killanimscript");
  for(;;) {
    if(isalive(self.enemy) && isDefined(self.node) && self canSee(self.enemy)) {
      if(!seekingCoverInMyFov()) {
        break;
      }
    }
    wait(0.25);
  }
  self thread moveAgain();
}

drawLookaheadDir() {
  self endon("killanimscript");
  for(;;) {
    line(self.origin + (0, 0, 20), (self.origin + vectorscale(self.lookaheaddir, 64)) + (0, 0, 20));
    wait(0.05);
  }
}