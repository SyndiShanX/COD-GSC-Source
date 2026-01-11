/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\prone.gsc
*****************************************************/

#include animscripts\Combat_Utility;
#include animscripts\Utility;
#include animscripts\SetPoseMovement;
#using_animtree("generic_human");

ProneRangeCombat(changeReason) {
  self trackScriptState("ProneRangeCombat", changeReason);
  self endon("killanimscript");
  assertEX(isDefined(changeReason), "Script state called without reason.");
  self thread ProneTurningThread(::ProneCombatThread, "kill ProneRangeCombat");
  timer = gettime();
  self waittill("kill ProneRangeCombat");
  if(gettime() == timer) {
    wait(0.05);
  }
  self thread animscripts\combat::main();
}

Set3FlaggedAnimKnobs(animFlag, animArray, weight, blendTime, rate) {
  self SetAnimKnob(animArray["left"], weight, blendTime, rate);
  self SetFlaggedAnimKnob(animFlag, animArray["middle"], weight, blendTime, rate);
  self SetAnimKnob(animArray["right"], weight, blendTime, rate);
}

ProneTurningThread(threadToSpawn, killmeString) {
  self endon("killanimscript");
  self endon("death");
  self endon(killmeString);
  self.a.usingProneLeftAndRight = false;
  if(isDefined(threadToSpawn)) {
    self thread[[threadToSpawn]]("kill ProneTurningThread children");
  }
  for(;;) {
    if(self.a.pose != "prone") {
      self OrientMode("face default");
    } else {
      self OrientMode("face enemy");
      attackYaw = self.angles[1];
      if(hasEnemySightPos()) {
        pos = getEnemySightPos();
        attackYaw = animscripts\utility::GetYaw(pos);
      }
      yawDelta = self.angles[1] - attackYaw;
      yawDelta = int(yawDelta + 360) % 360;
      if(yawDelta > 180) {
        yawDelta -= 360;
      }
      if(yawDelta > 0) {
        if(self.a.usingProneLeftAndRight) {
          amount = yawDelta / 45.0;
          if(amount < 0.01) {
            amount = 0.01;
          } else if(amount > 0.99) {
            amount = 0.99;
          }
          self SetAnimKnob( % prone_straight, 1.0 - amount, 0.1, 1);
          self SetAnim( % prone_right45, amount, 0.1, 1);
          self SetAnim( % prone_left45, 0.01, 0.1, 1);
        }
        if(yawDelta > 45) {
          self notify("kill ProneTurningThread children");
          self setFlaggedAnimKnobRestart("turn anim", % prone_turn_right, 1, 0.1, 1);
          self animscripts\shared::DoNoteTracks("turn anim");
          self UpdateProne( % prone_shootfeet_straight45up, % prone_shootfeet_straight45down, 1, 0.1, 1);
          if(isDefined(threadToSpawn)) {
            self thread[[threadToSpawn]]("kill ProneTurningThread children");
          }
        }
      } else {
        if(self.a.usingProneLeftAndRight) {
          amount = yawDelta / -45;
          if(amount < 0.01) {
            amount = 0.01;
          } else if(amount > 0.99) {
            amount = 0.99;
          }
          self SetAnimKnob( % prone_straight, 1.0 - amount, 0.1, 1);
          self SetAnim( % prone_left45, amount, 0.1, 1);
          self SetAnim( % prone_right45, 0.01, 0.1, 1);
        }
        if(yawDelta < -45) {
          self notify("kill ProneTurningThread children");
          self setFlaggedAnimKnobRestart("turn anim", % prone_turn_left, 1, 0.1, 1);
          self animscripts\shared::DoNoteTracks("turn anim");
          self UpdateProne( % prone_shootfeet_straight45up, % prone_shootfeet_straight45down, 1, 0.1, 1);
          if(isDefined(threadToSpawn)) {
            self thread[[threadToSpawn]]("kill ProneTurningThread children");
          }
        }
      }
    }
    self thread WaitForNotify("Update prone aim", "Prone aim done waiting", "Prone aim done waiting");
    self thread WaitForTime(0.3, "Prone aim done waiting", "Prone aim done waiting");
    waittillframeend;
    self waittill("Prone aim done waiting");
    lookForBetterCover();
  }
}

ProneCombatThread(killmeString) {
  self endon("killanimscript");
  self endon(killmeString);
  wait 0;
  for(;;) {
    if(!self isStanceAllowedWrapper("prone")) {
      self notify("kill ProneRangeCombat");
      break;
    }
    isProne = self.a.pose == "prone";
    canShootFromProne = animscripts\utility::canShootEnemyFromPose("prone", undefined, !isProne);
    canGoProne = CanGoProneHere(self.origin, self.angles[1]);
    if(!canGoProne) {
      self notify("kill ProneRangeCombat");
      break;
    }
    if(canShootFromProne) {
      ProneShootVolley();
      Reload(0);
    } else {
      Reload(.999);
      wait .05;
    }
    self.enemyDistanceSq = self GetClosestEnemySqDist();
    if(animscripts\utility::GetNodeType() != "Cover Prone" && self.enemyDistanceSq < anim.proneRangeSq) {
      self notify("kill ProneRangeCombat");
      break;
    }
  }
  scriptChange();
}

WaitForNotify(waitForString, notifyString, killmeString) {
  self endon("killanimscript");
  self endon("death");
  self endon(killmeString);
  self waittill(waitForString);
  self notify(notifyString);
}

WaitForTime(time, notifyString, killmeString) {
  self endon("killanimscript");
  self endon("death");
  self endon(killmeString);
  wait(time);
  self notify(notifyString);
}

CanDoProneCombat(origin, yaw) {
  if(!self isStanceAllowedWrapper("prone")) {
    return false;
  }
  if(weaponAnims() == "pistol") {
    return false;
  }
  if(MyGetEnemySqDist() < anim.proneRangeSq) {
    return 0;
  }
  canShootProne = animscripts\utility::canShootEnemyFromPose("prone");
  if(!canShootProne) {
    return 0;
  }
  return CanGoProneHere(origin, yaw);
}

CanGoProneHere(origin, yaw) {
  alreadyProne = (self.a.pose == "prone");
  canFitProne = self checkProne(origin, yaw, alreadyProne);
  return canFitProne;
}

ProneShootVolley() {
  self SetPoseMovement("prone", "stop");
  shootanims["middle"] = % prone_shoot_straight;
  shootanims["left"] = % prone_shoot_left;
  shootanims["right"] = % prone_shoot_right;
  autoshootanims["middle"] = % prone_shoot_auto_straight;
  autoshootanims["left"] = % prone_shoot_auto_left;
  autoshootanims["right"] = % prone_shoot_auto_right;
  self animscripts\face::SetIdleFace(anim.aimface);
  self.a.usingProneLeftAndRight = true;
  self notify("Update prone aim");
  self setanimknob( % prone, 1, 0.15, 1);
  rand = randomfloat(1);
  self Set3FlaggedAnimKnobs("shootanim", shootanims, 1, 0.15, 0);
  wait rand;
  self updatePlayerSightAccuracy();
  if(animscripts\weaponList::usingAutomaticWeapon()) {
    self animscripts\face::SetIdleFace(anim.autofireface);
    self Set3FlaggedAnimKnobs("shootanim", autoshootanims, 1, 0.15, 0);
    wait 0.2;
    animRate = animscripts\weaponList::autoShootAnimRate();
    self Set3FlaggedAnimKnobs("shootanim", autoshootanims, 1, 0.05, animRate);
    rand = randomint(8) + 6;
    for(i = 0; i < rand; i++) {
      self waittillmatch("shootanim", "fire");
      self shootEnemyWrapper();
      self decrementBulletsInClip();
    }
  } else if(animscripts\weaponList::usingSemiAutoWeapon()) {
    self Set3FlaggedAnimKnobs("shootanim", shootanims, 1, 0.2, 0);
    wait 0.2;
    rand = randomint(3) + 2;
    for(i = 0; i < rand; i++) {
      self Set3FlaggedAnimKnobs("shootanim", shootanims, 1, 0, 1);
      self shootEnemyWrapper();
      self decrementBulletsInClip();
      shootTime = animscripts\weaponList::shootAnimTime();
      quickTime = animscripts\weaponList::waitAfterShot();
      wait quickTime;
      if(i < rand - 1 && shootTime > quickTime) {
        wait shootTime - quickTime;
      }
    }
  } else {
    self Set3FlaggedAnimKnobs("shootanim", shootanims, 1, 0.2, 0);
    wait 0.2;
    self Set3FlaggedAnimKnobs("shootanim", shootanims, 1, 0, 1);
    self shootEnemyWrapper();
    self decrementBulletsInClip();
    self.a.needsToRechamber = 1;
    quickTime = animscripts\weaponList::waitAfterShot();
    wait quickTime;
  }
  self.a.usingProneLeftAndRight = false;
}