/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\zombie_melee.gsc
****************************************/

#include maps\_utility;
#include animscripts\zombie_utility;
#include animscripts\zombie_SetPoseMovement;
#include animscripts\Combat_Utility;
#include animscripts\Debug;
#include common_scripts\utility;
#using_animtree("generic_human");
MeleeCombat() {
  self endon("end_melee");
  self endon("killanimscript");
  self melee_notify_wrapper();
  assert(CanMeleeAnyRange());
  if(isDefined(level.allow_ai_vs_ai_melee)) {
    doingAIMelee = (isAI(self.enemy) && self.enemy.type == "human");
  } else {
    doingAIMelee = false;
  }
  if(doingAiMelee) {
    assert(animscripts\zombie_utility::okToMelee(self.enemy));
    animscripts\zombie_utility::IAmMeleeing(self.enemy);
    AiVsAiMeleeCombat();
    animscripts\zombie_utility::ImNotMeleeing(self.enemy);
    scriptChange();
    return;
  }
  realMelee = true;
  if(animscripts\zombie_utility::okToMelee(self.enemy)) {
    animscripts\zombie_utility::IAmMeleeing(self.enemy);
  } else {
    realMelee = false;
  }
  self thread EyesAtEnemy();
  self OrientMode("face enemy");
  meleeDebugPrint("Melee begin");
  self AnimMode("zonly_physics");
  resetGiveUpTime();
  for(;;) {
    if(isDefined(self.marked_for_death)) {
      return;
    }
    meleeDebugPrint("Melee main loop" + randomInt(100));
    if(!realMelee && animscripts\zombie_utility::okToMelee(self.enemy)) {
      realMelee = true;
      animscripts\zombie_utility::IAmMeleeing(self.enemy);
    }
    self thread EyesAtEnemy();
    self animscripts\battleChatter_ai::evaluateMeleeEvent();
    if(isDefined(self.enemy)) {
      angles = VectorToAngles(self.enemy.origin - self.origin);
      self OrientMode("face angle", angles[1]);
    }
    if(!isDefined(level.zombietron_mode)) {
      switch (self.animname) {
        case "zombie":
          self playSound("zmb_vocals_zombie_attack");
          break;
        case "quad_zombie":
          self playSound("zmb_vocals_quad_attack");
          break;
        case "boss_zombie":
          self playSound("zmb_vocals_boss_attack");
          break;
        case "napalm_zombie":
          self playSound("zmb_vocals_napalm_attack");
          break;
        case "sonic_zombie":
          self playSound("zmb_vocals_sonic_attack");
          break;
      }
    }
    if(is_true(self.noChangeDuringMelee)) {
      self.safeToChangeScript = false;
    }
    zombie_attack = pick_zombie_melee_anim(self);
    if(isDefined(self.melee_anim_func)) {
      self thread[[self.melee_anim_func]](zombie_attack);
    }
    self SetFlaggedAnimKnobAllRestart("meleeanim", zombie_attack, %body, 1, .2, 1);
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
        } else {
          if(isDefined(self.melee_miss_func)) {
            self[[self.melee_miss_func]]();
          } else if(isDefined(level.melee_miss_func)) {
            self[[level.melee_miss_func]]();
          }
        }
      } else if(note == "stop") {
        if(!CanContinueToMelee()) {
          break;
        }
      }
    }
    self OrientMode("face default");
    if(is_true(self.noChangeDuringMelee)) {
      if(isDefined(self.enemy)) {
        dist_sq = distanceSquared(self.origin, self.enemy.origin);
        if(dist_sq > self.meleeAttackDist * self.meleeAttackDist) {
          self.safeToChangeScript = true;
          wait_network_frame();
          break;
        }
      } else {
        self.safeToChangeScript = true;
        wait_network_frame();
        break;
      }
    }
  }
  if(realMelee) {
    animscripts\zombie_utility::ImNotMeleeing(self.enemy);
  }
  self AnimMode("none");
  self thread animscripts\zombie_combat::main();
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

debug_melee(msg) {
  if(!debug_melee_on_actor()) {
    return;
  }
  PrintLn(msg);
}

debug_melee_line(start, end, color, duration) {}
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
  yaw = abs(getYawToEnemy());
  if((yaw > 60 && state != "already started") || yaw > 110) {
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
    if(!animscripts\zombie_utility::okToMelee(self.enemy)) {
      debug_melee("Not doing melee - Enemy is already being meleed.");
      return false;
    }
    if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield && isDefined(self.enemy.magic_bullet_shield) && self.enemy.magic_bullet_shield) {
      debug_melee("Not doing melee - Enemy has magic bullet shield.");
      return false;
    }
    if(!isMeleePathClear(vecToEnemy, enemyPoint)) {
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
    if((!self is_banzai() || IsPlayer(self.enemy)) && isDefined(self.lastMeleeGiveUpTime) && GetTime() - self.lastMeleeGiveUpTime < 3000) {
      debug_melee("Not doing melee - Recently meleed someone and missed.");
      return false;
    }
    if(!animscripts\zombie_utility::okToMelee(self.enemy)) {
      debug_melee("Not doing melee - Enemy is being meleed.");
      return false;
    }
    if(is_true(self.check_melee_path)) {
      if(!isMeleePathClear(vecToEnemy, enemyPoint)) {
        self notify("melee_path_blocked");
        return false;
      }
    }
  }
  return true;
}

isMeleePathClear(vecToEnemy, enemyPoint) {
  dirToEnemy = VectorNormalize((vecToEnemy[0], vecToEnemy[1], 0));
  meleePoint = enemyPoint - (dirToEnemy[0] * 28, dirToEnemy[1] * 28, 0);
  thread debug_melee_line(self.origin, meleePoint, (1, 0, 0), 1.5);
  if(!self IsInGoal(meleePoint)) {
    debug_melee("Not doing melee - Enemy is outside not in goal.");
    return false;
  }
  if(self maymovetopoint(meleePoint)) {
    return true;
  }
  trace1 = bulletTrace(self.origin + (0, 0, 20), meleePoint + (0, 0, 20), true, self);
  trace2 = bulletTrace(self.origin + (0, 0, 72), meleePoint + (0, 0, 72), true, self);
  if(isDefined(trace1["fraction"]) && trace1["fraction"] == 1 && isDefined(trace2["fraction"]) && trace2["fraction"] == 1) {
    return true;
  }
  if(isDefined(trace1["entity"]) && trace1["entity"] == self.enemy && isDefined(trace2["entity"]) && trace2["entity"] == self.enemy) {
    return true;
  }
  if(is_true(level.zombie_melee_in_water)) {
    if(isDefined(trace1["surfacetype"]) && trace1["surfacetype"] == "water" && isDefined(trace2["fraction"]) && trace2["fraction"] == 1) {
      return true;
    }
  }
  debug_melee("Not doing melee - Can not move to the melee point, MayMoveToPoint failed.");
  return false;
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
  self ClearAnim(%root, 0.3);
  IWin = (randomInt(10) < 8);
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
  giveUpTime = GetTime() + 2500;
  self SetAnimKnobAll(animscripts\zombie_run::GetRunAnim(), %body, 1, 0.2);
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
  self SetFlaggedAnimKnobAllRestart("meleeAnim", myAnim, %body, 1, 0.2);
  self animscripts\zombie_shared::DoNoteTracks("meleeAnim");
  self notify("end_melee");
}

endMeleeOnKillanimscript() {
  self endon("end_melee");
  self waittill("killanimscript");
  self.meleePartner notify("end_melee");
}

pick_zombie_melee_anim(zombie_guy) {
  melee_anim = undefined;
  if(zombie_guy.has_legs) {
    switch (zombie_guy.zombie_move_speed) {
      case "walk":
        anims = array_combine(level._zombie_melee[zombie_guy.animname], level._zombie_walk_melee[zombie_guy.animname]);
        melee_anim = random(anims);
        break;
      case "run":
      case "sprint":
        anims = array_combine(level._zombie_melee[zombie_guy.animname], level._zombie_run_melee[zombie_guy.animname]);
        melee_anim = random(anims);
        break;
    }
  } else if(zombie_guy.a.gib_ref == "no_legs") {
    melee_anim = random(level._zombie_stumpy_melee[zombie_guy.animname]);
  } else {
    melee_anim = random(level._zombie_melee_crawl[zombie_guy.animname]);
  }
  return melee_anim;
}