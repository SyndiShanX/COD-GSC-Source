/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_stingerm7.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

CONST_stinger_weaponname = "stingerm7";

CONST_lock_require_los = true;
CONST_lock_angle = 5;
CONST_lock_time = 1;
CONST_max_locks = 4;
CONST_nosight_time_limit = 500;

stingerm7_think() {
  self thread stingerm7_targeting();
  self thread stingerm7_monitor_fire();
}

stingerm7_targeting() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("joined_team");

  self.stingerm7_info = spawnStruct();
  self.stingerm7_info.locked_targets = [];
  self.stingerm7_info.locking_time = 0;
  was_ads_stingerm7 = false;

  while(true) {
    if(IsSubStr(self GetCurrentWeapon(), CONST_stinger_weaponname) && self PlayerAds() > .99) {
      was_ads_stingerm7 = true;

      if(self.stingerm7_info.locked_targets.size > 0) {
        self remove_invalid_locks();
      }
      self.stingerm7_info.locked_targets = array_remove_dead(array_removeUndefined(self.stingerm7_info.locked_targets));

      if(isDefined(self.stingerm7_info.locking_target)) {
        if(!locking_target_still_valid(self.stingerm7_info.locking_target)) {
          self.stingerm7_info.locking_target = undefined;
          self notify("stop_javelin_locking_feedback");
        }
      }

      if(isDefined(self.stingerm7_info.locking_target)) {
        self.stingerm7_info.locking_time += .05;
      } else {
        self.stingerm7_info.locking_time = 0;

        if(self.stingerm7_info.locked_targets.size < CONST_max_locks) {
          self.stingerm7_info.locking_target = self get_best_locking_target();
          if(isDefined(self.stingerm7_info.locking_target)) {
            self thread locking_feedback();
          }
        }
      }

      if(self.stingerm7_info.locking_time >= CONST_lock_time && isDefined(self.stingerm7_info.locking_target) && self.stingerm7_info.locked_targets.size < CONST_max_locks) {
        self notify("stop_javelin_locking_feedback");
        self.stingerm7_info.locked_targets[self.stingerm7_info.locked_targets.size] = self.stingerm7_info.locking_target;

        self thread locked_feedback();

        self.stingerm7_info.locking_target = undefined;
      }

      if(self.stingerm7_info.locked_targets.size > 0) {
        self WeaponLockFinalize(self.stingerm7_info.locked_targets[0]);
      } else {
        self WeaponLockFree();
        self notify("stop_javelin_locked_feedback");
      }
    } else {
      if(was_ads_stingerm7 == true) {
        was_ads_stingerm7 = false;
        self WeaponLockFree();
        self notify("stop_javelin_locking_feedback");
        self notify("stop_javelin_locked_feedback");

        self.stingerm7_info.locked_targets = [];

        if(isDefined(self.stingerm7_info.locking_target)) {
          self.stingerm7_info.locking_target = undefined;
        }

        self.stingerm7_info.locking_time = 0;
      }
    }
    wait(0.05);
  }
}

stingerm7_monitor_fire() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("joined_team");

  while(true) {
    self waittill("missile_fire", projectile, weaponName);
    if(IsSubStr(weaponName, CONST_stinger_weaponname)) {
      thread stinger_fire(self, projectile, weaponName);
    }
  }
}

stinger_fire(player, projectile, weapon_name) {
  init_origin = (0, 0, 0);
  init_angles = (0, 0, 0);
  if(isDefined(projectile)) {
    init_origin = projectile.origin;
    init_angles = projectile.angles;
    projectile Delete();
  } else {
    return;
  }

  player.stingerm7_info.locked_targets = array_remove_dead(array_removeUndefined(self.stingerm7_info.locked_targets));

  missiles = [];

  for(i = 0; i < CONST_max_locks; i++) {
    fire_angles = init_angles + random_vector(20, 20, 20);
    fire_direction = anglesToForward(fire_angles);

    new_projectile = MagicBullet(weapon_name, init_origin, init_origin + fire_direction, player);
    new_projectile.owner = player;

    if(player.stingerm7_info.locked_targets.size > 0) {
      target = undefined;
      if(i < player.stingerm7_info.locked_targets.size) {
        target = player.stingerm7_info.locked_targets[i];
      } else {
        target = player.stingerm7_info.locked_targets[RandomInt(player.stingerm7_info.locked_targets.size)];
      }

      new_projectile Missile_SetTargetEnt(target, stingerm7_get_target_offset(target));
      new_projectile.lockedStingerTarget = target;
    }

    missiles[missiles.size] = new_projectile;
  }

  level notify("stinger_fired", player, missiles);

  player SetWeaponAmmoClip(weapon_name, 0);
}

anyStingerMissileLockedOn(missiles, target) {
  foreach(missile in missiles) {
    if(isDefined(missile.lockedStingerTarget) && missile.lockedStingerTarget == target) {
      return true;
    }
  }
  return false;
}

get_best_locking_target() {
  Assert(isPlayer(self));

  enemy_team = getOtherTeam(self.team);
  enemy_players = [];

  foreach(player in level.players) {
    if(level.teamBased && player.team == self.team) {
      continue;
    }

    if(!isReallyAlive(player)) {
      continue;
    }

    enemy_players[enemy_players.size] = player;
  }

  all_vehicles = Vehicle_GetArray();
  enemy_vehicles = [];

  foreach(vehicle in all_vehicles) {
    if(!isDefined(vehicle.owner)) {
      continue;
    }

    if(vehicle maps\mp\killstreaks\_aerial_utility::vehicleIsCloaked()) {
      continue;
    }

    if(level.teamBased && vehicle.owner.team == self.team) {
      continue;
    }

    enemy_vehicles[enemy_vehicles.size] = vehicle;
  }

  if(isDefined(level.isHorde) && level.isHorde) {
    foreach(agent in level.agentarray) {
      if(level.teamBased && agent.team == self.team) {
        continue;
      }

      if(!isReallyAlive(agent)) {
        continue;
      }

      enemy_players[enemy_players.size] = agent;
    }

    foreach(vehicle in all_vehicles) {
      if(vehicle maps\mp\killstreaks\_aerial_utility::vehicleIsCloaked()) {
        continue;
      }

      if(level.teamBased && vehicle.team == self.team) {
        continue;
      }

      enemy_vehicles[enemy_vehicles.size] = vehicle;
    }
  }

  aerialTargets = maps\mp\killstreaks\_killstreaks::getAerialKillstreakArray(enemy_team);

  targets = array_combine(enemy_players, enemy_vehicles);
  targets = array_combine(targets, aerialTargets);
  if(isDefined(level.stingerLockOnEntsFunc)) {
    targets = array_combine(targets, [[level.stingerLockOnEntsFunc]](self));
  }

  eye_origin = self getEye();
  eye_dir = anglesToForward(self GetPlayerAngles());

  best_target = undefined;
  best_target_dot = Cos(CONST_lock_angle);
  foreach(target in targets) {
    if(!array_contains(self.stingerm7_info.locked_targets, target)) {
      target_origin = stingerm7_get_target_pos(target);
      dot = VectorDot(VectorNormalize(target_origin - eye_origin), eye_dir);
      if(dot > best_target_dot) {
        result = undefined;
        can_target = !CONST_lock_require_los;
        if(!can_target) {
          tracePassed = BulletTracePassed(eye_origin, target_origin, false, target);
          if(tracePassed) {
            can_target = true;
          }
        }

        if(can_target) {
          best_target = target;
          best_target_dot = dot;
        }
      }
    }
  }

  return best_target;
}

locking_target_still_valid(target) {
  Assert(isPlayer(self));

  eye_origin = self getEye();
  eye_dir = anglesToForward(self GetPlayerAngles());
  target_origin = stingerm7_get_target_pos(target);

  if((isPlayer(target) || IsBot(target) || (isDefined(level.isHorde) && level.isHorde && IsAgent(target))) && !isReallyAlive(target)) {
    return false;
  }

  if(VectorDot(VectorNormalize(target_origin - eye_origin), eye_dir) > Cos(CONST_lock_angle)) {
    if(!CONST_lock_require_los || BulletTracePassed(eye_origin, target_origin, false, target)) {
      return true;
    }
  }
  return false;
}

remove_invalid_locks() {
  for(i = 0; i <= self.stingerm7_info.locked_targets.size; i++) {
    if(isDefined(self.stingerm7_info.locked_targets[i]) && isDefined(self.stingerm7_info.locked_targets[i].origin)) {
      if(!isDefined(self.stingerm7_info.locked_targets[i].sight_lost_time)) {
        self.stingerm7_info.locked_targets[i].sight_lost_time = -1;
      }

      origin_mod = (0, 0, 0);
      if(isPlayer(self.stingerm7_info.locked_targets[i]) || IsBot(self.stingerm7_info.locked_targets[i])) {
        origin_mod = (0, 0, 64);
      }

      if(self WorldPointInReticle_Rect(self.stingerm7_info.locked_targets[i].origin + origin_mod, 50, 400, 200)) {
        if(BulletTracePassed(self getEye(), self.stingerm7_info.locked_targets[i].origin + origin_mod, false, self.stingerm7_info.locked_targets[i])) {
          self.stingerm7_info.locked_targets[i].sight_lost_time = -1;
          continue;
        }
      }

      if(self.stingerm7_info.locked_targets[i].sight_lost_time == -1) {
        self.stingerm7_info.locked_targets[i].sight_lost_time = GetTime();
      } else if(GetTime() - self.stingerm7_info.locked_targets[i].sight_lost_time >= CONST_nosight_time_limit) {
        self.stingerm7_info.locked_targets[i].sight_lost_time = -1;
        self.stingerm7_info.locked_targets[i] = undefined;
      }
    }
  }
}

stingerm7_get_target_pos(target) {
  if(isDefined(target.getStingerTargetPosFunc)) {
    return target[[target.getStingerTargetPosFunc]]();
  }

  return target GetPointInBounds(0, 0, 0);
}

stingerm7_get_target_offset(target) {
  return stingerm7_get_target_pos(target) - target.origin;
}

locking_feedback() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("joined_team");
  self endon("stop_javelin_locking_feedback");

  for(;;) {
    if(isDefined(level.SpawnedWarbirds)) {
      foreach(warbird in level.SpawnedWarbirds) {
        if(isDefined(warbird.owner) && isDefined(warbird.player) && isDefined(self.stingerm7_info.locking_target) && self.stingerm7_info.locking_target == warbird) {
          warbird.owner playLocalSound("wpn_stingerm7_enemy_locked");
        }
      }
    }

    if(isDefined(level.orbitalsupport_player) && isDefined(self.stingerm7_info.locking_target) && self.stingerm7_info.locking_target == level.orbitalsupport_planeModel) {
      level.orbitalsupport_player playLocalSound("wpn_stingerm7_enemy_locked");
    }

    self playLocalSound("wpn_stingerm7_locking");
    self PlayRumbleOnEntity("heavygun_fire");

    wait 0.6;
  }
}

locked_feedback() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("joined_team");
  self endon("stop_javelin_locked_feedback");

  for(;;) {
    if(isDefined(level.SpawnedWarbirds)) {
      foreach(warbird in level.SpawnedWarbirds) {
        if(isDefined(warbird.owner) && isDefined(warbird.player) && isDefined(self.stingerm7_info.locked_targets) && IsInArray(self.stingerm7_info.locked_targets, warbird)) {
          warbird.owner playLocalSound("wpn_stingerm7_enemy_locked");
        }
      }
    }

    if(isDefined(level.orbitalsupport_player) && isDefined(self.stingerm7_info.locked_targets) && IsInArray(self.stingerm7_info.locked_targets, level.orbitalsupport_planeModel)) {
      level.orbitalsupport_player playLocalSound("wpn_stingerm7_enemy_locked");
    }

    self playLocalSound("wpn_stingerm7_locked");
    self PlayRumbleOnEntity("heavygun_fire");

    wait 0.25;
  }
}

array_remove_dead(array) {
  temp = [];

  foreach(thing in array) {
    if(!isAlive(thing)) {
      continue;
    }

    temp[temp.size] = thing;
  }

  return temp;
}

random_vector(num1, num2, num3) {
  return (RandomFloat(num1) - num1 * 0.5, RandomFloat(num2) - num2 * 0.5, RandomFloat(num3) - num3 * 0.5);
}

IsInArray(array, Ent) {
  if(isDefined(array)) {
    foreach(Index in array) {
      if(Index == Ent) {
        return true;
      }
    }
  }
  return false;
}