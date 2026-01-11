/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\satfarm_code_heli.gsc
**************************************/

chopper_ai_init() {
  maps\_chopperboss::chopper_boss_locs_populate("script_noteworthy", "heli_nav_mesh");
  maps\_chopperboss::init();
  level.missile_lockon_notify_delay = 30;
  level.next_missile_lockon_notify = 0;
}

spawn_hind_enemies(var_0, var_1) {
  if(!isDefined(level.heli_targeting_player)) {
    level.heli_targeting_player = 0;
  }

  var_2 = 0;

  if(!isDefined(var_1)) {
    var_1 = "heli_nav_mesh_start";
  }

  var_3 = common_scripts\utility::getstructarray(var_1, "targetname");
  var_4 = [];

  while(var_2 < var_0) {
    var_5 = undefined;

    foreach(var_7 in var_3) {
      if(!isDefined(var_7.in_use) && !isDefined(var_7.disabled)) {
        var_5 = var_7;
        break;
      }
    }

    if(isDefined(var_5)) {
      var_9 = spawn_hind_enemy(var_5);
      var_9 thread maps\satfarm_code::target_settings();
      var_9 self_make_chopper_boss(var_5, 1);
      var_9 thread maps\satfarm_code::npc_tank_combat_init();
      var_4 = common_scripts\utility::add_to_array(var_4, var_9);
      var_3 = common_scripts\utility::array_remove(var_3, var_5);
      var_3[var_3.size] = var_5;
      var_2++;
    }

    wait 0.05;
  }

  var_10 = getEntArray("lockon_targets", "script_noteworthy");
  return var_4;
}

spawn_hind_enemy(var_0) {
  var_1 = getent("hind_enemy", "targetname");

  while(isDefined(var_1.vehicle_spawned_thisframe)) {
    wait 0.05;
  }

  if(isDefined(var_0)) {
    var_1.origin = var_0.origin;

    if(isDefined(var_0.angles)) {
      var_1.angles = var_0.angles;
    }
  }

  var_2 = maps\_vehicle::vehicle_spawn(var_1);
  var_2.script_noteworthy = "lockon_targets";
  var_2.enablerocketdeath = 1;
  var_2 vehicle_setspeed(85, 35, 35);
  var_2 thread hind_manage_damage_states();
  var_2 heli_ai_collision_cylinder_add();
  return var_2;
}

self_make_chopper_boss(var_0, var_1) {
  self endon("death");

  if(!isDefined(var_0)) {
    for(;;) {
      var_0 = maps\_chopperboss_utility::chopper_boss_get_closest_available_path_struct_2d(self.origin);

      if(isDefined(var_0)) {
        break;
      }

      wait 0.05;
    }
  }

  var_1 = common_scripts\utility::ter_op(isDefined(var_1), var_1, 0);

  if(var_1) {
    var_0.in_use = 1;
    thread maps\_vehicle::vehicle_paths(var_0);
    self waittill("reached_dynamic_path_end");
    var_0.in_use = undefined;
  }

  if(!isDefined(level.chopperboss_const[self.classname])) {
    maps\_chopperboss_utility::build_data_override("min_target_dist2d", 2048);
    maps\_chopperboss_utility::build_data_override("max_target_dist2d", 8192);
    maps\_chopperboss_utility::build_data_override("get_targets_func", ::heli_ai_gather_targets);
    maps\_chopperboss_utility::build_data_override("tracecheck_func", ::heli_ai_can_hit_target);
    maps\_chopperboss_utility::build_data_override("fire_func", ::heli_ai_shoot_target);
    maps\_chopperboss_utility::build_data_override("next_loc_func", ::heli_ai_next_loc_func);
    maps\_chopperboss_utility::build_data_override("pre_move_func", ::heli_ai_pre_move_func);
    maps\_chopperboss_utility::build_data_override("stop_func", ::heli_ai_stop_func);
  }

  thread maps\_chopperboss::chopper_boss_think(var_0, 0);
  thread _heli_ai_pre_move_func_internal();
}

heli_ai_gather_targets() {
  var_0 = [];
  var_0 = common_scripts\utility::array_removeundefined(level.allytanks);
  var_0 = common_scripts\utility::add_to_array(var_0, level.playertank);
  return var_0;
}

heli_ai_can_hit_target(var_0, var_1) {
  return 1;
}

heli_lock_player_target() {
  level.heli_targeting_player = 1;
  common_scripts\utility::waittill_either("heli_fire_complete", "death");
  level.heli_targeting_player = 0;
}

heli_ai_shoot_target(var_0) {
  if(var_0 == level.playertank) {
    thread heli_lock_player_target();
  }

  var_1 = 1;

  if(!self.is_moving) {
    var_1 = randomintrange(1, 4);
  }

  heli_fire_missiles(var_0, var_1);
  self notify("heli_fire_complete");
  return 1;
}

heli_fire_missiles(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("heli_players_dead");

  if(isDefined(self.defaultweapon)) {
    var_5 = self.defaultweapon;
  }
  else {
    var_5 = "minigun_littlebird_quickspin";
  }

  var_6 = "missile_attackheli";

  if(isDefined(var_3) && !(var_3 == "")) {
    var_6 = var_3;
  }

  var_7 = undefined;
  var_8 = [];
  self setvehweapon(var_5);

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(!isDefined(var_0.classname)) {
    if(!isDefined(self.dummytarget)) {
      self.dummytarget = spawn("script_origin", var_0.origin);
      thread common_scripts\utility::delete_on_death(self.dummytarget);
    }

    self.dummytarget.origin = var_0.origin;
    var_0 = self.dummytarget;
  }

  var_8[0] = "tag_missile_left";
  var_8[1] = "tag_missile_right";
  var_9 = -1;

  for(var_10 = 0; var_10 < var_1; var_10++) {
    var_9++;

    if(var_9 >= var_8.size) {
      var_9 = 0;
    }

    self setvehweapon(var_6);
    self.firingmissiles = 1;
    var_11 = var_0;

    if(var_0 == level.playertank) {
      var_11 = _get_player_tank_target();
    }

    var_12 = self fireweapon(var_8[var_9], var_11);
    var_12 thread _missile_earthquake();
    var_12 thread _missile_start_lockon_notify(var_0, var_4);

    if(isDefined(var_0.is_fake) && var_0.is_fake) {
      var_12 thread _missile_cleanup_fake_target(var_0);
    }

    if(isDefined(var_11.is_fake) && var_11.is_fake) {
      var_12 thread _missile_cleanup_fake_target(var_11);
    }

    if(var_10 < var_1 - 1) {
      wait(var_2);
    }
  }

  self.firingmissiles = 0;
  self setvehweapon(var_5);
}

_get_player_tank_target() {
  var_0 = level.playertank vehicle_getspeed();

  if(var_0 == 0) {
    return level.playertank;
  }

  var_1 = level.playertank vehicle_getvelocity();
  var_2 = var_0 * 2;
  var_3 = level.playertank.origin + -1 * vectornormalize(var_1) * var_2;
  var_4 = common_scripts\utility::spawn_tag_origin();
  var_4.is_fake = 1;
  var_4.origin = var_3;
  return var_4;
}

_missile_cleanup_fake_target(var_0) {
  self waittill("death");
  var_0 delete();
}

_missile_start_lockon_notify(var_0, var_1) {
  if(var_0 != level.playertank && !isDefined(var_0.is_fake)) {
    return;
  }
  var_2 = gettime();

  if(var_2 < level.next_missile_lockon_notify) {
    return;
  }
  level.next_missile_lockon_notify = gettime() + level.missile_lockon_notify_delay * 1000;

  if(!isDefined(level.chopper_lockon_vo_num)) {
    level.chopper_lockon_vo_num = 0;
  }

  if(level.chopper_lockon_vo_num > 2) {
    level.chopper_lockon_vo_num = 0;
  }

  var_3 = [];
  var_3[0] = "satfarm_td3_wevegotamissile";
  var_3[1] = "satfarm_td2_missilelocktakeevasive";
  var_3[2] = "satfarm_td1_chopperslockingonus";

  if(!isDefined(var_1)) {
    thread maps\satfarm_code::radio_dialog_add_and_go(var_3[level.chopper_lockon_vo_num]);
    level.chopper_lockon_vo_num++;
  }

  level.player thread common_scripts\utility::play_loop_sound_on_entity("missile_incoming");
  thread maps\satfarm_code::tank_hud_missile_warning();
  self waittill("death");
  level.player thread common_scripts\utility::stop_loop_sound_on_entity("missile_incoming");
  level notify("remove_missile_warning");
}

_missile_earthquake() {
  if(distancesquared(self.origin, level.player.origin) > 9000000) {
    return;
  }
  var_0 = self.origin;

  while(isDefined(self)) {
    var_0 = self.origin;
    wait 0.1;
  }

  earthquake(0.7, 1.5, var_0, 1600);
}

heli_ai_next_loc_func(var_0, var_1, var_2) {
  var_2 = maps\_chopperboss_utility::get_chopperboss_data("tracecheck_func");
  thread maps\_chopperboss::chopper_boss_manage_targeting_flag();
  var_3 = [];
  var_4 = 0;

  foreach(var_6 in var_0) {
    if(var_6 != self.loc_current && isDefined(var_6.in_use)) {
      continue;
    }
    if(isDefined(self.loc_last) && var_6 == self.loc_last) {
      continue;
    }
    if(isDefined(var_6.disabled)) {
      continue;
    }
    var_6.heli_target = undefined;
    var_6.dist2d = undefined;
    var_7 = undefined;
    common_scripts\utility::lock("chopperboss_trace");

    foreach(var_9 in var_1) {
      common_scripts\utility::unlock_wait("chopperboss_trace");
      common_scripts\utility::lock("chopperboss_trace");

      if(!isDefined(var_9)) {
        continue;
      }
      if(maps\_chopperboss::chopper_boss_in_range(var_9.origin, var_6.origin) == 0) {
        continue;
      }
      var_10 = var_9.origin + (0, 0, 64);

      if(isai(var_9) || isplayer(var_9)) {
        var_10 = var_9 getEye();
      }

      if(self[[var_2]](var_6.origin, var_10)) {
        if(!isDefined(var_6.heli_target)) {
          var_3[var_3.size] = var_6;
          var_6.heli_target = var_9;
          var_7 = distance2d(var_6.origin, var_9.origin);
          continue;
        }

        var_11 = distance2d(var_6.origin, var_9.origin);

        if(var_11 < var_7) {
          var_6.heli_target = var_9;
          var_7 = var_11;
        }
      }
    }

    common_scripts\utility::unlock_wait("chopperboss_trace");
  }

  if(var_3.size) {
    var_14 = [];

    foreach(var_6 in var_3) {
      if(isDefined(var_6.heli_target) && !isDefined(var_6.in_use) && !isDefined(var_6.disabled)) {
        var_14[var_14.size] = var_6;
      }
    }

    var_3 = var_14;
  }

  if(!var_3.size) {
    foreach(var_6 in var_0) {
      if(var_6 != self.loc_current && isDefined(var_6.in_use)) {
        continue;
      }
      if(isDefined(var_6.disabled)) {
        continue;
      }
      var_18 = undefined;

      foreach(var_9 in var_1) {
        if(!isDefined(var_9)) {
          continue;
        }
        if(!isDefined(var_18)) {
          var_18 = var_9;
          var_6.dist2d = distance2d(var_6.origin, var_9.origin);
          continue;
        }

        var_20 = distance2d(var_6.origin, var_9.origin);

        if(var_20 < var_6.dist2d) {
          var_18 = var_9;
          var_6.dist2d = var_20;
        }
      }

      if(isDefined(var_6.dist2d)) {
        var_3[var_3.size] = var_6;
      }
    }
  } else {
    foreach(var_6 in var_3) {
    var_6.dist2d = distance2d(var_6.heli_target.origin, var_6.origin);
    }
  }

  var_25 = common_scripts\utility::array_sort_by_handler(var_3, maps\_chopperboss::chopper_boss_loc_compare);
  var_26 = undefined;

  foreach(var_6 in var_25) {
    var_28 = maps\_chopperboss_utility::get_chopperboss_data("min_target_dist2d");
    var_29 = maps\_chopperboss_utility::get_chopperboss_data("max_target_dist2d");

    if(var_6.dist2d >= var_28 && var_6.dist2d <= var_29) {
      var_26 = var_6;
      break;
    }
  }

  if(!isDefined(var_26) && var_25.size) {
    var_26 = var_25[0];
  }

  if(isDefined(var_26) && isDefined(var_26.heli_target)) {
    maps\_chopperboss::chopper_boss_set_target(var_26.heli_target);
  }

  self notify("chopper_done_targeting");

  if(isDefined(var_26) && var_26 != self.loc_current) {
    return var_26;
  }
  else {
    return undefined;
  }
}

heli_ai_pre_move_func() {}

_heli_ai_pre_move_func_internal() {
  self endon("deathspin");
  self endon("death");
  self.is_moving = 1;

  while(self.is_moving) {
    heli_set_look_at_ent();
    heli_attempt_fire();
    var_0 = randomfloatrange(1, 4);
    wait(var_0);
  }
}

heli_set_look_at_ent() {
  if(isDefined(maps\_chopperboss_utility::chopper_boss_forced_target_get())) {
    self setlookatent(maps\_chopperboss_utility::chopper_boss_forced_target_get());
  }
  else if(isDefined(self.heli_target)) {
    self setlookatent(self.heli_target);
  }
  else {
    self clearlookatent();
  }
}

heli_ai_stop_func() {}

heli_attempt_fire() {
  if(isDefined(self.heli_target)) {
    self.fired_weapons = maps\_chopperboss::chopper_boss_attempt_firing(self.heli_target);
  }
  else {
    self.fired_weapons = 0;
  }
}

hind_manage_damage_states() {
  self endon("death");
  self endon("deathspin");
  var_0 = self.health - self.healthbuffer;
  var_1 = 0;

  for(;;) {
    var_2 = self.health - self.healthbuffer;

    if(var_2 <= var_0 * 0.5) {
      playFXOnTag(common_scripts\utility::getfx("tank_heavy_smoke"), self, "tag_deathfx");
      self dodamage(var_2 * 2, self.origin);
    }

    wait 0.05;
  }
}

heli_ai_collision_cylinder_setup() {
  level.heli_collision_ai = getEntArray("heli_collision_ai_mesh", "targetname");

  foreach(var_1 in level.heli_collision_ai) {
    var_1.start_origin = var_1.origin;
    var_1.start_angles = var_1.angles;
    var_1.in_use = 0;
  }
}

heli_ai_collision_cylinder_add() {
  var_0 = undefined;

  foreach(var_2 in level.heli_collision_ai) {
    if(!var_2.in_use) {
      var_0 = var_2;
    }
  }

  if(isDefined(var_0)) {
    var_0.in_use = 1;
    var_0.origin = self.origin;
    var_0.angles = self.angles;
    var_0 linkto(self, "tag_origin");
    thread heli_ai_collision_cylinder_on_death_remove(var_0);
  }
}

heli_ai_collision_cylinder_on_death_remove(var_0) {
  self waittill("death");
  var_0 unlink();
  var_0.origin = var_0.start_origin;
  var_0.angles = var_0.start_angles;
  var_0.in_use = 0;
}