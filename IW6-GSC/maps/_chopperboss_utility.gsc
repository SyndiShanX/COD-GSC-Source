/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_chopperboss_utility.gsc
*****************************************/

build_data_override(var_0, var_1) {
  level.chopperboss_const[self.classname][var_0] = var_1;
}

get_chopperboss_data(var_0) {
  var_1 = self.classname;

  if(!isDefined(level.chopperboss_const[var_1]) || !isDefined(level.chopperboss_const[var_1][var_0])) {
    var_1 = "default";
  }

  return level.chopperboss_const[var_1][var_0];
}

build_chopperboss_defaults() {
  if(isDefined(level.chopperboss_const)) {
    return;
  }
  level.chopperboss_const = [];
  level.chopperboss_const["default"] = [];
  level.chopperboss_const["default"]["shot_count"] = 20;
  level.chopperboss_const["default"]["shot_count_long"] = 60;
  level.chopperboss_const["default"]["heli_shoot_limit"] = 1;
  level.chopperboss_const["default"]["windup_time"] = 2.0;
  level.chopperboss_const["default"]["weapon_cooldown_time"] = 1.0;
  level.chopperboss_const["default"]["face_target_timeout"] = 5.0;
  level.chopperboss_const["default"]["min_target_dist2d"] = 384;
  level.chopperboss_const["default"]["max_target_dist2d"] = 3072;
  level.chopperboss_const["default"]["get_targets_func"] = ::chopper_boss_gather_targets;
  level.chopperboss_const["default"]["tracecheck_func"] = ::chopper_boss_can_hit_from_mgturret;
  level.chopperboss_const["default"]["fire_func"] = ::chopper_boss_fire_mgturrets;
  level.chopperboss_const["default"]["pre_move_func"] = ::chopper_boss_pre_move_func;
  level.chopperboss_const["default"]["post_move_func"] = ::chopper_boss_post_move_func;
  level.chopperboss_const["default"]["next_loc_func"] = maps\_chopperboss::chopper_boss_get_best_location_and_target_proc;
  level.chopperboss_const["default"]["stop_func"] = ::chopper_boss_stop_func;
}

chopper_boss_locs_monitor_disable(var_0) {
  self endon("death");
  self notify("chopper_boss_locs_monitor_disable_turn_off");
  self endon("chopper_boss_locs_monitor_disable_turn_off");
  self.chopper_boss_locs_disabled = [];
  var_1 = squared(var_0);

  for(;;) {
    if(isDefined(level.chopper_boss_locs) && level.chopper_boss_locs.size) {
      chopper_boss_locs_monitor_disable_reset();
      var_2 = (self.origin[0], self.origin[1], 0);

      foreach(var_4 in level.chopper_boss_locs) {
        var_5 = (var_4.origin[0], var_4.origin[1], 0);

        if(distancesquared(var_2, var_5) <= var_1) {
          var_4 chopper_boss_loc_disable();
          self.chopper_boss_locs_disabled[self.chopper_boss_locs_disabled.size] = var_4;
        }
      }
    }

    wait 0.05;
  }
}

chopper_boss_locs_monitor_disable_turn_off() {
  self notify("chopper_boss_locs_monitor_disable_turn_off");
  chopper_boss_locs_monitor_disable_reset();
  self.chopper_boss_locs_disabled = undefined;
}

chopper_boss_locs_monitor_disable_clean_up() {
  self endon("chopper_boss_locs_monitor_disable_turn_off");
  self waittill("death");
  chopper_boss_locs_monitor_disable_reset();
}

chopper_boss_locs_monitor_disable_reset() {
  if(isDefined(self.chopper_boss_locs_disabled) && self.chopper_boss_locs_disabled.size) {
    foreach(var_1 in self.chopper_boss_locs_disabled) {
    var_1 chopper_boss_loc_enable();
    }
  }

  self.chopper_boss_locs_disabled = [];
}

chopper_boss_loc_disable() {
  if(!isDefined(self.disabled)) {
    self.disabled = 0;
  }

  self.disabled++;
}

chopper_boss_loc_enable() {
  if(isDefined(self.disabled)) {
    self.disabled--;

    if(self.disabled <= 0) {
      self.disabled = undefined;
    }
  }
}

chopper_boss_forced_target_set(var_0) {
  self.heli_target_forced = var_0;
}

chopper_boss_forced_target_clear() {
  self.heli_target_forced = undefined;
}

chopper_boss_forced_target_get() {
  var_0 = undefined;

  if(isDefined(self.heli_target_forced)) {
    var_0 = self.heli_target_forced;
  }

  return var_0;
}

chopper_boss_set_hangout_volume(var_0) {
  var_1 = [];

  foreach(var_3 in level.chopper_boss_locs) {
    if(ispointinvolume(var_3.origin, var_0)) {
      var_1[var_1.size] = var_3;
    }
  }

  level.chopper_boss_hangout = var_1;
}

chopper_boss_clear_hangout_volume() {
  level.chopper_boss_hangout = undefined;
}

chopper_boss_wait_populate() {
  while(!isDefined(level.chopper_boss_locs_populated)) {
    wait 0.05;
  }
}

chopper_boss_get_closest_available_path_struct_2d(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = level.chopper_boss_locs;

  if(isDefined(level.chopper_boss_hangout)) {
    var_3 = level.chopper_boss_hangout;
  }

  foreach(var_5 in var_3) {
    if(isDefined(var_5.in_use) || isDefined(var_5.disabled)) {
      continue;
    }
    var_6 = common_scripts\utility::distance_2d_squared(var_0, var_5.origin);

    if(!isDefined(var_1) || var_6 < var_1) {
      var_1 = var_6;
      var_2 = var_5;
    }
  }

  return var_2;
}

chopper_boss_gather_targets() {
  var_0 = [];

  if(self.script_team == "allies") {
    var_1 = getaiarray("axis");

    foreach(var_3 in var_1) {
      if(!isDefined(var_3.ignoreme) || var_3.ignoreme == 0) {
        var_0[var_0.size] = var_3;
      }
    }

    var_1 = getaiarray("team3");

    foreach(var_3 in var_1) {
      if(!isDefined(var_3.ignoreme) || var_3.ignoreme == 0) {
        var_0[var_0.size] = var_3;
      }
    }
  } else {
    foreach(var_8 in level.players) {
      if(!maps\_utility::is_player_down(var_8) && (!isDefined(var_8.ignoreme) || var_8.ignoreme == 0)) {
        var_0[var_0.size] = var_8;
      }
    }

    var_10 = getaiarray("allies");

    foreach(var_12 in var_10) {
      if(!isDefined(var_12.ignoreme) || var_12.ignoreme == 0) {
        var_0[var_0.size] = var_12;
      }
    }

    if(!var_0.size) {
      foreach(var_8 in level.players) {
        if(!maps\_utility::is_player_down_and_out(var_8) && (!isDefined(var_8.ignoreme) || var_8.ignoreme == 0)) {
          var_0[var_0.size] = var_8;
        }
      }
    }
  }

  return var_0;
}

chopper_boss_can_hit_from_mgturret(var_0, var_1) {
  var_2 = self.mgturret[0].origin[2] - self.origin[2];
  return bullettracepassed(var_0 + (0, 0, var_2), var_1, 0, self);
}

get_boundry_radius() {
  if(isDefined(self.boundryradius)) {
    return self.boundryradius;
  }

  if(get_model_boundry_radius()) {
    return self.boundryradius;
  }

  if(!isDefined(level.boundry_radius_cache)) {
    level.boundry_radius_cache = [];
  }

  self.boundryradius = distance(self.origin, self getpointinbounds(1, 1, 1)) + 10;
  level.boundry_radius_cache[self.model] = self.boundryradius;
  return self.boundryradius;
}

get_model_boundry_radius() {
  if(!isDefined(level.boundry_radius_cache)) {
    return 0;
  }

  if(!isDefined(level.boundry_radius_cache[self.model])) {
    return 0;
  }

  self.boundryradius = level.boundry_radius_cache[self.model];
  return 1;
}

draw_boundry_sphere() {
  self notify("draw_boundry_sphere");
  self endon("draw_boundry_sphere");
  self endon("death");

  for(;;) {
    wait 0.05;
  }
}

chopper_boss_can_hit_from_tag_turret(var_0, var_1) {
  var_2 = self gettagorigin("tag_flash");
  var_3 = var_2[2] - self.origin[2];
  return bullettracepassed(var_0 + (0, 0, var_3), var_1, 0, self);
}

chopper_boss_fire_mgturrets(var_0) {
  self endon("deathspin");
  self endon("death");
  var_0 endon("death");
  var_1 = get_chopperboss_data("shot_count");

  foreach(var_3 in self.mgturret) {
    if(isai(var_0)) {
      var_3 settargetentity(var_0, (var_0 getEye() - var_0.origin) * 0.7);
    }
    else if(isplayer(var_0)) {
      if(maps\_utility::is_player_down(var_0)) {
        var_1 = get_chopperboss_data("shot_count_long");
        var_3 settargetentity(var_0);
      } else
        var_3 settargetentity(var_0, var_0 getEye() - var_0.origin);
    } else
      var_3 settargetentity(var_0, (0, 0, 32));

    var_3 startbarrelspin();
  }

  wait(get_chopperboss_data("windup_time"));
  var_5 = 0;

  for(var_6 = 0; var_6 < var_1; var_6++) {
    var_7 = level.vehicle_mgturret[self.classname][var_5];
    var_8 = weaponfiretime(var_7.info);
    self.mgturret[var_5] shootturret();
    var_5++;

    if(var_5 >= self.mgturret.size) {
      var_5 = 0;
    }

    wait(var_8 + 0.05);
  }

  wait(get_chopperboss_data("weapon_cooldown_time"));

  foreach(var_3 in self.mgturret) {
  var_3 stopbarrelspin();
  }
}

chopper_boss_fire_weapon(var_0) {
  self endon("deathspin");
  self endon("death");
  var_0 endon("death");
  var_1 = get_chopperboss_data("shot_count");

  if(isai(var_0)) {
    self setturrettargetent(var_0, var_0 getEye() - var_0.origin);
  }
  else if(isplayer(var_0)) {
    if(maps\_utility::is_player_down(var_0)) {
      var_1 = get_chopperboss_data("shot_count_long");
      self setturrettargetent(var_0);
    } else
      self setturrettargetent(var_0, var_0 getEye() - var_0.origin);
  } else
    self setturrettargetent(var_0, (0, 0, 32));

  wait(get_chopperboss_data("windup_time"));
  var_2 = 0;

  for(var_3 = 0; var_3 < var_1; var_3++) {
    if(isDefined(self.weapon)) {
      var_4 = weaponfiretime(self.weapon);
    }
    else {
      var_4 = 0.65;
    }

    self fireweapon();
    var_2++;
    wait(var_4 + 0.05);
  }

  wait(get_chopperboss_data("weapon_cooldown_time"));
}

chopper_boss_pre_move_func() {
  if(isDefined(chopper_boss_forced_target_get())) {
    self setlookatent(chopper_boss_forced_target_get());
  }
  else if(isDefined(self.heli_target)) {
    self setlookatent(self.heli_target);
  }
  else {
    var_0 = common_scripts\utility::getclosest(self.origin, level.players);

    if(isDefined(var_0)) {
      self setlookatent(var_0);
    }
  }
}

chopper_boss_post_move_func() {}

chopper_boss_stop_func() {
  if(isDefined(self.heli_target)) {
    self.fired_weapons = maps\_chopperboss::chopper_boss_attempt_firing(self.heli_target);
  }
  else {
    self.fired_weapons = 0;
  }
}