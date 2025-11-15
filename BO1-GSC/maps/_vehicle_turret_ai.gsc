/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_vehicle_turret_ai.gsc
***************************************/

#include maps\_utility;
#include common_scripts\utility;

enable_turret(turret_index, weapon_type, enemy_team, optional_wait_min, optional_wait_max, forced_targets) {
  if(!isDefined(self.turret_ai_array)) {
    init_turret_info();
  }
  if(!isDefined(weapon_type)) {
    weapon_type = "mg";
  }
  if(!isDefined(enemy_team)) {
    enemy_team = "axis";
  }
  if(isDefined(forced_targets)) {
    self set_forced_target(forced_targets);
  }
  self thread turret_ai_thread(turret_index, weapon_type, enemy_team, optional_wait_min, optional_wait_max);
}

disable_turret(turret_index) {
  if(!isDefined(self.turret_ai_array)) {
    init_turret_info();
  }
  if(!isDefined(turret_index)) {
    PrintLn("turret index missing! disable_turret returning");
    return;
  }
  self.turret_ai_array[turret_index].enabled = false;
  self clearGunnerTarget(turret_index);
}

init_turret_info() {
  self.turret_ai_array = [];
  for(i = 0; i < 4; i++) {
    self.turret_ai_array[i] = spawnStruct();
    self.turret_ai_array[i].enabled = false;
    self.turret_ai_array[i].target_ent = undefined;
    fire_angles = undefined;
    weapon = self SeatGetWeapon(i + 1);
    if(isDefined(weapon)) {
      fire_angles = self GetSeatFiringAngles(i + 1);
    }
    if(!isDefined(fire_angles)) {
      fire_angles = (0, 0, 0);
    }
    self.turret_ai_array[i].rest_angle = AngleClamp180(fire_angles[1] - self.angles[1]);
  }
}

fire_turret_for_time(turret_index, time) {
  if(!isDefined(self.turret_ai_array)) {
    init_turret_info();
  }
  weapon = self SeatGetWeapon(turret_index + 1);
  firetime = WeaponFireTime(weapon);
  assert(time > firetime);
  num_shots = time / firetime;
  alias = undefined;
  alias2 = undefined;
  for(i = 0; i < num_shots; i++) {
    self fireGunnerWeapon(turret_index);
    if(isDefined(self.turret_audio_override)) {
      if(!isDefined(self.sound_ent)) {
        self.sound_ent = spawn("script_origin", self.origin);
        self.sound_ent LinkTo(self);
        self thread kill_audio_ent(self.sound_ent);
      }
      if(isDefined(self.turret_audio_override_alias)) {
        alias = self.turret_audio_override_alias;
      }
      if(isDefined(self.turret_audio_ring_override_alias)) {
        alias2 = self.turret_audio_ring_override_alias;
      } else {
        alias = "wpn_gaz_quad50_turret_loop_npc";
      }
      self.sound_ent playLoopSound(alias);
    }
    wait firetime;
  }
  if(isDefined(self.sound_ent)) {
    self.sound_ent Delete();
    self notify("stop_audio_delete");
    if(isDefined(alias2)) {
      self playSound(alias2);
    }
  }
}

kill_audio_ent(audio_ent) {
  self endon("stop_audio_delete");
  self waittill("death");
  wait 2;
  if(isDefined(audio_ent)) {
    audio_ent Delete();
  }
}

turret_ai_thread(turret_index, weapon_type, enemy_team, optional_wait_min, optional_wait_max) {
  self endon("death");
  weapon = self SeatGetWeapon(turret_index + 1);
  if(!isDefined(weapon)) {
    println("Failed to start gunner turret ai for " + turret_index + " " + self.vehicletype + ". No weapon.");
    return;
  }
  if(isDefined(self.turret_ai_array[turret_index]) && self.turret_ai_array[turret_index].enabled == true) {
    println("Failed to start gunner turret ai for " + turret_index + " " + self.vehicletype + ". Already started.");
    return;
  }
  self.turret_ai_array[turret_index].enabled = true;
  while(self.turret_ai_array[turret_index].enabled) {
    if((isDefined(self.player_controlled_heli) && self.player_controlled_heli == true) || choose_target(turret_index, enemy_team)) {
      if(weapon_type == "mg") {
        fire_turret_for_time(turret_index, .6);
        wait 1;
        fire_turret_for_time(turret_index, .6);
        wait 1;
      } else if(weapon_type == "slow_mg") {
        burst_fire(turret_index, 3, 0.25);
        wait 1;
        burst_fire(turret_index, 3, 0.25);
        wait 1;
      } else if(weapon_type == "fast_mg") {
        fire_turret_for_time(turret_index, 1.75);
      } else if(weapon_type == "huey_minigun") {
        burst_fire(turret_index, 0.5, 0.1);
      } else if(weapon_type == "huey_spotlight") {
        wait RandomFloat(1, 4);
      } else if(weapon_type == "target_finder_only") {
        wait 1;
      } else if(weapon_type == "flame") {
        flame_fire(turret_index, 2);
      } else if(weapon_type == "grenade") {
        burst_fire(turret_index, 2, 1.5);
      } else if(weapon_type == "grenade_btr") {
        burst_fire_rebirthbtr(turret_index, 2, 1.5);
      }
      if(isDefined(optional_wait_min) && isDefined(optional_wait_max)) {
        wait(RandomFloatRange(optional_wait_min, optional_wait_max));
      }
    } else {
      wait 2;
    }
  }
}

score_angle(target_ent, turret_index) {
  return (score_angle_position(target_ent.origin, turret_index));
}

score_angle_position(origin, turret_index) {
  if(!isDefined(self.turret_ai_array)) {
    init_turret_info();
  }
  angles_to_target = VectorToAngles(origin - self.origin);
  rest_angle = self.turret_ai_array[turret_index].rest_angle + self.angles[1];
  angle_diff = AngleClamp180(angles_to_target[1] - rest_angle);
  angle_diff = abs(angle_diff);
  if(angle_diff < 90) {
    return (angle_diff / 90) * 50;
  }
  return -1000;
}

score_distance(target_ent) {
  max_range = 3000 * 3000;
  dist2 = distanceSquared(target_ent.origin, self.origin);
  if(dist2 < max_range) {
    return (dist2 / max_range) * 100;
  }
  return -1000;
}

score_special(target_ent, turret_index) {
  for(i = 0; i < 4; i++) {
    if(isDefined(self.turret_ai_array[i].target_ent) && i != turret_index) {
      if(self.turret_ai_array[i].target_ent == target_ent) {
        return -50;
      }
    }
  }
  return 0;
}

choose_target(turret_index, enemy_team) {
  if(!isDefined(self.turret_ai_array)) {
    init_turret_info();
  }
  player = self getseatoccupant(turret_index + 1);
  if(isDefined(player)) {
    self ClearGunnerTarget(turret_index);
    return false;
  }
  if(isDefined(self._forced_target_ent_array)) {
    self update_forced_gunner_targets();
    if(self._forced_target_ent_array.size == 0) {
      self ClearGunnerTarget(turret_index);
      return false;
    } else {
      best_target = score_target(self._forced_target_ent_array, turret_index);
      if(isDefined(best_target)) {
        self setGunnerTargetEnt(best_target, (0, 0, 30), turret_index);
        return true;
      } else {
        self ClearGunnerTarget(turret_index);
        return false;
      }
    }
  } else {
    ai = getaiarray(enemy_team);
    if(isDefined(level.heli_attack_drone_targets_func)) {
      ai = [
        [level.heli_attack_drone_targets_func]
      ](ai, enemy_team);
    }
    best_target = score_target(ai, turret_index);
    self.turret_ai_array[turret_index].target_ent = best_target;
    if(isDefined(best_target)) {
      self setGunnerTargetEnt(best_target, (0, 0, 30), turret_index);
      return true;
    }
    self ClearGunnerTarget(turret_index);
    return false;
  }
}

burst_fire(turret_index, bullet_count, interval) {
  for(i = 0; i < bullet_count; i++) {
    self fireGunnerWeapon(turret_index);
    wait interval;
  }
}

burst_fire_rebirthbtr(turret_index, bullet_count, interval) {
  for(i = 0; i < bullet_count; i++) {
    self fireGunnerWeapon(turret_index);
    self playSound("wpn_china_lake_fire_npc");
    wait interval;
  }
}

flame_fire(turret_index, interval) {
  while(interval > 0) {
    self fireGunnerWeapon(turret_index);
    wait(0.05);
    interval -= 0.05;
  }
  self StopFireWeapon(turret_index);
}

score_target(target_array, turret_index) {
  if(!isDefined(target_array) || !isDefined(turret_index)) {
    return;
  } else {
    best_score = 0;
    best_target = undefined;
    for(i = 0; i < target_array.size; i++) {
      score = score_distance(target_array[i]);
      score += score_angle(target_array[i], turret_index);
      score += score_special(target_array[i], turret_index);
      if(score > best_score) {
        best_score = score;
        best_target = target_array[i];
      }
    }
    return best_target;
  }
}

setup_driver_turret_aim_assist(driver_turret, target_radius, target_offset) {
  self endon("death");
  if(!isDefined(target_radius)) {
    target_radius = 60;
  }
  if(!isDefined(target_offset)) {
    target_offset = (0, 0, 30);
  }
  while(1) {
    driver = self getseatoccupant(0);
    if(isDefined(driver)) {
      ai = getaiarray("axis");
      best_target = undefined;
      fov = GetDvarFloat(#"cg_fov");
      for(i = 0; i < ai.size; i++) {
        if(target_isincircle(ai[i], driver, fov, target_radius))
          best_target = ai[i];
      }
      if(isDefined(driver_turret)) {
        if(isDefined(best_target)) {
          self setGunnerTargetEnt(best_target, target_offset, driver_turret);
        } else {
          self clearGunnerTarget(driver_turret);
        }
      } else {
        if(isDefined(best_target)) {
          self SetTurretTargetEnt(best_target, target_offset, driver_turret);
        } else {
          self ClearTurretTarget(driver_turret);
        }
      }
      wait 0.05;
    } else {
      wait 1;
    }
  }
}

update_forced_gunner_targets() {
  if(isDefined(self._forced_target_ent_array)) {
    self._forced_target_ent_array = remove_dead_from_array(self._forced_target_ent_array);
  } else {
    turret_debug_message("_vehicle_turret_ai couldn't update_forced_gunner_targets since none exist. ");
  }
}

set_forced_target(target_array) {
  if(isDefined(target_array)) {
    forced_targets = [];
    if(!IsArray(target_array)) {
      forced_targets[forced_targets.size] = target_array;
    } else {
      forced_targets = target_array;
    }
    if(!isDefined(self._forced_target_ent_array) || (self._forced_target_ent_array.size == 0)) {
      self._forced_target_ent_array = forced_targets;
    } else {
      for(i = 0; i < forced_targets.size; i++) {
        self._forced_target_ent_array = array_add(self._forced_target_ent_array, forced_targets[i]);
      }
    }
  } else {
    if(isDefined(self._forced_target_ent_array)) {
      turret_debug_message("_vehicle_turret_ai tried to set_forced_target without any targets.");
    } else {
      self._forced_target_ent_array = [];
    }
  }
}

clear_forced_target(target_to_remove) {
  if(isDefined(self._forced_target_ent_array)) {
    if(isDefined(target_to_remove)) {
      if(IsArray(target_to_remove)) {
        for(i = 0; i < target_to_remove.size; i++) {
          self._forced_target_ent_array = array_remove(self._forced_target_ent_array, target_to_remove[i]);
        }
      } else {
        self._forced_target_ent_array = array_remove(self._forced_target_ent_array, target_to_remove);
      }
    } else {
      self._forced_target_ent_array = undefined;
    }
  } else {
    turret_debug_message("_vehicle_turret_ai tried to clear_forced_target, but no targets existed. ");
  }
}

turret_debug_message(debug_string) {}