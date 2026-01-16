/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\zombie_dog_combat.gsc
*********************************************/

#include common_scripts\utility;
#include animscripts\zombie_utility;
#include maps\_utility;
#using_animtree("zombie_dog");
main() {
  self endon("killanimscript");
  assert(isDefined(self.enemy));
  if(!IsAlive(self.enemy)) {
    combatIdle();
    return;
  }
  assert(IsPlayer(self.enemy));
  self notify("dog_combat");
  if(IsPlayer(self.enemy)) {
    self meleeBiteAttackPlayer(self.enemy);
  }
}

handleMeleeBiteAttackNoteTracks(note) {
  if(!isDefined(self.enemy))
    return;
  assert(IsPlayer(self.enemy));
  if(!IsAlive(self.enemy))
    return;
  player = self.enemy;
  switch (note) {
    case "dog_melee": {
      if(getDvar(#"zombietron") == "1") {
        if(isDefined(self.enemy.dog_damage_func)) {
          self.enemy[[self.enemy.dog_damage_func]]();
        } else {
          self.enemy DoDamage(self.enemy.health + 666, self.origin, self, undefined, "impact", "torso_upper");
        }
        return true;
      }
      if(!isDefined(level.dogMeleeBiteAttackTime)) {
        level.dogMeleeBiteAttackTime = GetTime() - level.dogMeleeBiteAttackTimeStart;
        level.dogMeleeBiteAttackTime += 50;
      }
      hitEnt = self melee(AnglesToForward(self.angles));
      if(isDefined(hitEnt)) {
        if(IsPlayer(hitEnt)) {
          hitEnt ShellShock("dog_bite", 0.35);
        }
      } else {
        return true;
      }
    }
    break;
    case "stop_tracking": {
      melee_time = 200;
      if(!isDefined(level.dogMeleeBiteAttackTime)) {
        level.dogMeleeBiteAttackTimeStart = GetTime();
      } else {
        melee_time = level.dogMeleeBiteAttackTime;
      }
      self thread orientToPlayerDeadReckoning(player, melee_time);
    }
    break;
  }
}

orientToPlayerDeadReckoning(player, time_till_bite) {
  enemy_attack_current_origin = player.origin;
  enemy_attack_current_time = GetTime();
  enemy_motion_time_delta = enemy_attack_current_time - self.enemy_attack_start_time;
  enemy_motion_direction = enemy_attack_current_origin - self.enemy_attack_start_origin;
  if(enemy_motion_time_delta == 0) {
    enemy_predicted_position = player.origin;
  } else {
    enemy_velocity = enemy_motion_direction / enemy_motion_time_delta;
    enemy_predicted_position = player.origin + (enemy_velocity * time_till_bite);
  }
  self OrientMode("face point", enemy_predicted_position);
}

meleeBiteAttackPlayer(player) {
  attackRangeBuffer = 30;
  meleeRange = self.meleeAttackDist + attackRangeBuffer;
  for(;;) {
    if(!IsAlive(self.enemy)) {
      break;
    }
    if((isDefined(player.syncedMeleeTarget) && player.syncedMeleeTarget != self)) {
      if(checkEndCombat(meleeRange)) {
        break;
      } else {
        combatIdle();
        continue;
      }
    }
    if(self shouldWaitInCombatIdle()) {
      combatIdle();
      continue;
    }
    self OrientMode("face enemy");
    self AnimMode("gravity");
    self.safeToChangeScript = false;
    prepareAttackPlayer(player);
    player setNextDogAttackAllowTime(200);
    if(dog_cant_kill_in_one_hit(player)) {
      level.lastDogMeleePlayerTime = getTime();
      if(use_low_attack()) {
        self animMode("angle deltas");
        self ClearAnim( % root, 0.1);
        self SetAnimRestart(anim.dogAnims[self.animSet].move["run_attack_low"], 1.0, 0.2, 1.0);
        doMeleeAfterWait(0.1);
        self animscripts\zombie_shared::DoNoteTracksForTime(1.4, "done");
        self animMode("gravity");
      } else {
        attack_time = 1.2 + randomfloat(0.4);
        self ClearAnim( % root, 0.1);
        self SetFlaggedAnimRestart("meleeanim", anim.dogAnims[self.animSet].attack["run_attack"], 1.0, 0.2, 1.0);
        self animscripts\zombie_shared::DoNoteTracksForTime(attack_time, "meleeanim", ::handleMeleeBiteAttackNoteTracks);
      }
    }
    self.safeToChangeScript = true;
    if(checkEndCombat(meleeRange)) {
      break;
    }
  }
  self.safeToChangeScript = true;
  self AnimMode("none");
}

doMeleeAfterWait(time) {
  self endon("death");
  wait(time);
  hitEnt = self melee();
  if(isDefined(hitEnt)) {
    if(isplayer(hitEnt))
      hitEnt shellshock("dog_bite", 0.35);
  }
}

dog_cant_kill_in_one_hit(player) {
  return true;
  if(isDefined(player.dogs_dont_instant_kill)) {
    assertex(player.dogs_dont_instant_kill, "Dont set player.dogs_dont_instant_kill to false, set to undefined");
    return true;
  }
  if(getTime() - level.lastDogMeleePlayerTime > 8000)
    level.dogMeleePlayerCounter = 0;
  return level.dogMeleePlayerCounter < level.dog_hits_before_kill &&
    player.health > 25;
}

shouldWaitInCombatIdle() {
  assert(isDefined(self.enemy) && IsAlive(self.enemy));
  return isDefined(self.enemy.dogAttackAllowTime) && (GetTime() < self.enemy.dogAttackAllowTime);
}

setNextDogAttackAllowTime(time) {
  self.dogAttackAllowTime = GetTime() + time;
}

combatIdle() {
  self OrientMode("face enemy");
  self ClearAnim( % root, 0.1);
  self AnimMode("zonly_physics");
  keys = GetArrayKeys(anim.dogAnims[self.animSet].combatIdle);
  idleAnim = anim.dogAnims[self.animSet].combatIdle[random(keys)];
  self SetFlaggedAnimRestart("combat_idle", idleAnim, 1, 0.2, 1);
  self animscripts\zombie_shared::DoNoteTracks("combat_idle");
  self notify("combatIdleEnd");
}

checkEndCombat(meleeRange) {
  if(!isDefined(self.enemy)) {
    return false;
  }
  distToTargetSq = distanceSquared(self.origin, self.enemy.origin);
  melee_origin = (self.origin[0], self.origin[1], self.origin[2] + 65);
  enemy_origin = (self.enemy.origin[0], self.enemy.origin[1], self.enemy.origin[2] + 32);
  if(!BulletTracePassed(melee_origin, enemy_origin, false, self)) {
    return true;
  }
  return (distToTargetSq > meleeRange * meleeRange);
}

use_low_attack(player) {
  height_diff = self.enemy_attack_start_origin[2] - self.origin[2];
  low_enough = 30.0;
  if(height_diff < low_enough && self.enemy_attack_start_stance == "prone") {
    return true;
  }
  melee_origin = (self.origin[0], self.origin[1], self.origin[2] + 65);
  enemy_origin = (self.enemy.origin[0], self.enemy.origin[1], self.enemy.origin[2] + 32);
  if(!BulletTracePassed(melee_origin, enemy_origin, false, self)) {
    return true;
  }
  return false;
}

prepareAttackPlayer(player) {
  level.dog_death_quote = & "SCRIPT_PLATFORM_DOG_DEATH_DO_NOTHING";
  distanceToTarget = distance(self.origin, self.enemy.origin);
  targetHeight = Abs(self.enemy.origin[2] - self.origin[2]);
  self.enemy_attack_start_distance = distanceToTarget;
  self.enemy_attack_start_origin = player.origin;
  self.enemy_attack_start_time = GetTime();
  self.enemy_attack_start_stance = player getStance();
  distance_ok = ((distanceToTarget > self.meleeAttackDist) && (targetHeight < (self.meleeAttackDist * 0.5)));
  if(distance_ok && !use_low_attack()) {
    offset = self.enemy.origin - self.origin;
    length = (distanceToTarget - self.meleeAttackDist) / distanceToTarget;
    offset = (offset[0] * length, offset[1] * length, offset[2] * length);
  }
}