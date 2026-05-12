/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\vignettes.gsc
*********************************************/

vignette_init() {
  level.vignettes_active = [];
  level.vignettes_all = [];
  level.vignettes_total_per_wave_allowed = 2;
  level.vignettes_total_per_wave_max = 2;
  level.vignettes_occurred_in_current_wave = 0;
  level.remaining_zomb_count = 0;
  level thread vignette_wave_count_reset();
  level.vignette_min_dist = 200;
  level.vignette_spawn_cant_be_seen_for_time = 7;
  level.vignette_max_level_zombies_allowed = 14;
  level.vignette_req_remaining_zombies_to_spawn = 4;
  level.vignette_min_dist_from_other_zombies = 300;
  level.vignette_gunshot_chance = 0.2;
  level.vignette_recent_wave_buffer = 1;
  level.vignette_radial_cooldown_loc = undefined;
  level.vignette_radial_cooldown_dist = 600;
  level.vignette_radial_cooldown_time = 20;
  level.vignette_cooldown_time = 60;
  level.vignette_cooldown_current = 0;
  level.vignette_cooldown_per_instance = 1000;
  level.vignette_loop_min_timeout = 10;
  level.vignette_loop_max_timeout = 20;
  level.vignette_loop_interrupt_radius = 75;
  level.vignette_groundkill_dist = 800;
  level.vignette_groundkill_chance = 1;
  level.vignette_wallkill_dist = 800;
  level.vignette_wallkill_chance = 1;
  level.vignette_solodeath_dist = 1000;
  level.vignette_solodeath_time_min = 15;
  level.vignette_solodeath_time_max = 30;
  level.vignette_solodeath_chance = 1;
  while(!isDefined(level.var_744A) || level.var_744A.size == 0) {
    wait 0.05;
  }

  foreach(var_01 in level.var_AC80.var_ACB3) {
    var_01 thread vignette_listen_when_zone_activated();
  }

  level thread vignette_get_remaining_wave_count();
  var_03 = common_scripts\utility::func_46B7("vignette_groundkill_org", "targetname");
  foreach(var_05 in var_03) {
    var_05 thread vignette_handler("groundkill");
  }

  var_07 = common_scripts\utility::func_46B7("vignette_wallkill_org", "targetname");
  foreach(var_05 in var_07) {
    var_05 thread vignette_handler("wallkill");
  }
}

vignette_handler(param_00) {
  var_01 = spawnStruct();
  var_01.var_116 = self.var_116;
  var_01 thread vignette_monitor_last_seen();
  var_01 thread vignette_watch_zone_expire();
  level.vignettes_all[level.vignettes_all.size] = var_01;
  for(;;) {
    switch (param_00) {
      case "groundkill":
        thread vignette_start_listener(var_01, self.var_116, level.vignette_groundkill_dist, level.vignette_groundkill_chance, 1);
        break;

      case "wallkill":
        thread vignette_start_listener(var_01, self.var_116, level.vignette_wallkill_dist, level.vignette_wallkill_chance, 1);
        break;

      case "solodeath":
        thread vignette_start_listener(var_01, self.var_116, level.vignette_solodeath_dist, level.vignette_solodeath_chance, 0);
        break;

      default:
        break;
    }

    var_01 waittill("vignette_start");
    switch (param_00) {
      case "groundkill":
        vignette_run(var_01, undefined, undefined, "scripted_vignette_z_groundkill_loop", "scripted_vignette_groundkill_loop", "scripted_vignette_z_groundkill_exit", "scripted_vignette_groundkill_exit");
        break;

      case "wallkill":
        vignette_run(var_01, "scripted_vignette_z_wallkill_intro", "scripted_vignette_wallkill_intro", "scripted_vignette_z_wallkill_loop", "scripted_vignette_wallkill_loop", "scripted_vignette_z_wallkill_exit", "scripted_vignette_wallkill_exit");
        break;

      case "solodeath":
        vignette_run(var_01, undefined, undefined, undefined, undefined, undefined, undefined, "scripted_vignette_solodeath_loop");
        break;

      default:
        break;
    }
  }
}

vignette_start_listener(param_00, param_01, param_02, param_03, param_04) {
  param_00 endon("vignette_start");
  param_00 endon("vignette_cleanup");
  while(!isDefined(level.var_744A) || level.var_744A.size == 0) {
    wait 0.05;
  }

  var_05 = undefined;
  while(!common_scripts\utility::func_562E(level.var_AC80.var_8A9)) {
    wait 0.05;
  }

  var_06 = 50;
  var_07 = self.var_116 + (0, 0, var_06);
  var_05 = lib_055A::func_578B(var_07, 0);
  param_00.ent_zone_name = var_05;
  for(;;) {
    var_08 = lib_0547::func_408F();
    param_00.is_in_player_zone = 0;
    if(isDefined(var_05)) {
      var_09 = lib_055A::func_4626(var_05, 0, 0);
      param_00.is_in_player_zone = var_09.size > 0;
    }

    param_00.is_in_recently_enabled_zone = 0;
    if(isDefined(var_05) && isDefined(level.var_AC80.var_ACB3[var_05].was_unlocked_on_wave) && level.var_AC80.var_ACB3[var_05].was_unlocked_on_wave > level.var_A980 - level.vignette_recent_wave_buffer) {
      param_00.is_in_recently_enabled_zone = 1;
    }

    param_00.radial_cooldown_is_safe = 1;
    if(isDefined(level.vignette_radial_cooldown_loc)) {
      param_00.radial_cooldown_is_safe = distance(level.vignette_radial_cooldown_loc, self.var_116) > level.vignette_radial_cooldown_dist;
    }

    param_00.not_over_zombie_limit = var_08.size < level.vignette_max_level_zombies_allowed;
    param_00.wave_isnt_over = !lib_056D::func_584C(level.var_A980);
    param_00.limit_not_reached = level.vignettes_occurred_in_current_wave < level.vignettes_total_per_wave_allowed;
    param_00.players_not_seen_for_time = param_00.time_since_loc_seen >= level.vignette_spawn_cant_be_seen_for_time;
    param_00.req_zombs_remaining = level.vignette_req_remaining_zombies_to_spawn < level.remaining_zomb_count;
    if(param_00.not_over_zombie_limit && param_00.wave_isnt_over && param_00.is_in_player_zone && param_00.is_in_recently_enabled_zone && level.var_A980 != 0 && level.var_7F2A != "zombie_dog" && level.vignette_cooldown_current <= 0 && param_00.limit_not_reached && param_00.radial_cooldown_is_safe && param_00.players_not_seen_for_time && param_00.req_zombs_remaining) {
      var_0A = [];
      var_0B = [];
      foreach(var_0D in level.var_744A) {
        var_0E = 0;
        if(isDefined(self.var_165)) {
          var_0E = common_scripts\utility::func_9468(self.var_165);
        }

        var_0F = common_scripts\utility::func_AA4A(var_0D getEye(), var_0D.var_1D, var_07, cos(32.5));
        var_10 = distance(var_07, var_0D.var_116) < param_02;
        var_11 = distance(var_07, var_0D.var_116) < level.vignette_min_dist;
        var_12 = 0;
        if(abs(var_0D.var_116[2] - self.var_116[2]) < 150) {
          var_12 = 1;
        }

        if(var_0F) {
          break;
        }

        if(!var_10) {
          var_0A[var_0A.size] = var_0D;
        }

        var_13 = common_scripts\utility::func_AA4A(self.var_116, self.var_1D + (0, var_0E, 0), var_0D.var_116, cos(60));
        var_14 = 1;
        if(param_04 && !var_13) {
          var_14 = 0;
        }

        if(!var_11 && var_10 && var_14) {
          var_0B[var_0B.size] = var_0D;
        }
      }

      if(var_0B.size > 0 && var_0B.size + var_0A.size == level.var_744A.size) {
        param_00 notify("vignette_start");
      }

      wait(randomfloatrange(1.5, 3));
      continue;
    }

    wait(randomfloatrange(2, 5));
  }
}

vignette_run(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  level thread vignette_cooldown_run();
  thread vignette_radial_cooldown_run();
  var_08 = ["soldier_rus"];
  var_09 = 1;
  var_0A = lib_054D::func_90BA("zombie_generic", self, "vignette", 0, var_09, 0, common_scripts\utility::func_7A33(var_08));
  if(isDefined(var_0A)) {
    var_0A.var_BC = 1;
    var_0A.is_fellow_human = 1;
    var_0A.not_valid_sacrifice = 1;
    var_0A lib_0547::func_84CB();
  }

  level.vignettes_active[level.vignettes_active.size] = self;
  var_0B = lib_054D::func_90BA("zombie_generic", self, "vignette", 0, var_09, 0);
  if(isDefined(var_0B)) {
    var_0B.vignette_interrupted = 0;
    var_0B.var_6941 = 1;
    var_0B lib_0547::func_84CB();
  }

  level.vignettes_occurred_in_current_wave = level.vignettes_occurred_in_current_wave + 1;
  if(isalive(var_0B) && isalive(var_0A)) {
    thread vignette_gunshots(var_0B, var_0A);
  }

  if(isDefined(param_07) && isalive(var_0A)) {
    var_0C = var_0A maps\mp\agents\_scripted_agent_anim_util::func_434D(param_07);
    var_0D = var_0A method_83D8(var_0C, 0);
    var_0E = getstartorigin(self.var_116, self.var_1D, var_0D);
    var_0F = getstartangles(self.var_116, self.var_1D, var_0D);
    var_0A vignette_actor_enter_safe_state();
    var_0A vignette_actor_run_anim_entry(var_0E, var_0F, var_0C, 30);
  } else {
    var_0B.vignettepartner = var_0A;
    var_0A.vignettepartner = var_0B;
    var_0B vignette_actor_enter_safe_state();
    var_0A vignette_actor_enter_safe_state();
    if(isDefined(param_01) && isDefined(param_02) && isDefined(var_0B) && isalive(var_0B) && isDefined(var_0A) && isalive(var_0A) && !common_scripts\utility::func_562E(var_0B.vignette_interrupted)) {
      vignette_execute_paired_scene(var_0B, var_0A, param_01, param_02, 0);
    } else if(isalive(var_0A)) {
      lib_0378::func_8D74("play_vignette_victim_hurt_vo", var_0A);
    }

    if(isDefined(param_03) && isDefined(param_04) && isDefined(var_0B) && isalive(var_0B) && isDefined(var_0A) && isalive(var_0A) && !common_scripts\utility::func_562E(var_0B.vignette_interrupted)) {
      vignette_execute_paired_scene(var_0B, var_0A, param_03, param_04, 1);
    }

    if(isDefined(param_05) && isDefined(param_06) && isDefined(var_0B) && isalive(var_0B) && isDefined(var_0A) && isalive(var_0A) && !common_scripts\utility::func_562E(var_0B.vignette_interrupted)) {
      vignette_execute_paired_scene(var_0B, var_0A, param_05, param_06, 0);
    }

    var_0B vignette_actor_leave_safe_state();
    var_0A vignette_actor_leave_safe_state();
  }

  var_0A.var_78D2 = 1;
  var_0A dodamage(1000, var_0A.var_116);
  param_00 notify("vignette_end");
  level.vignettes_active = common_scripts\utility::func_F93(level.vignettes_active, self);
  level.vignettes_all = common_scripts\utility::func_F93(level.vignettes_all, param_00);
}

vignette_execute_paired_scene(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_00 maps\mp\agents\_scripted_agent_anim_util::func_434D(param_02);
  var_06 = param_00 method_83D8(var_05, 0);
  var_07 = getstartorigin(self.var_116, self.var_1D, var_06);
  var_08 = getstartangles(self.var_116, self.var_1D, var_06);
  var_09 = getanimlength(var_06);
  var_0A = param_00 maps\mp\agents\_scripted_agent_anim_util::func_434D(param_03);
  var_0B = param_00 method_83D8(var_0A, 0);
  var_0C = getstartorigin(self.var_116, self.var_1D, var_0B);
  var_0D = getstartangles(self.var_116, self.var_1D, var_0B);
  var_0E = undefined;
  if(param_04) {
    var_0E = randomfloatrange(level.vignette_loop_min_timeout, level.vignette_loop_max_timeout);
  }

  param_01 thread vignette_actor_run_anim_entry(var_0C, var_0D, var_0A, var_0E);
  param_00 thread vignette_actor_run_anim_entry(var_07, var_08, var_05, var_0E);
  wait(var_09);
}

vignette_actor_run_anim_entry(param_00, param_01, param_02, param_03) {
  self endon("damage");
  self endon("death");
  self setorigin(param_00, 0);
  self.var_1D = param_01;
  self method_839C("anim deltas");
  self scragentsetorientmode("face angle abs", param_01);
  self method_839A(1, 1);
  self method_839D("noclip");
  if(isDefined(param_03)) {
    vignette_zombie_run_loop(param_02, param_03);
    return;
  }

  maps\mp\agents\_scripted_agent_anim_util::func_71FD(param_02, 0, "scripted_anim");
}

vignette_zombie_run_loop(param_00, param_01) {
  self endon("loop_end");
  if(isDefined(param_01)) {
    thread vignette_loop_timeout_or_timeout_notify("loop_end", param_01);
  }

  maps\mp\agents\_scripted_agent_anim_util::func_71FD(param_00, 0, "scripted_anim");
}

vignette_actor_enter_safe_state() {
  if(!isalive(self)) {
    return;
  }

  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "vignette spawn");
  self.var_509A = 1;
  thread vignette_damage_listener();
}

vignette_actor_leave_safe_state() {
  if(!isalive(self)) {
    return;
  }

  if(isDefined(self.vignettepartner)) {
    self.vignettepartner = undefined;
  }

  self scragentsetscripted(0);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(0, "vignette spawn");
}

vignette_damage_listener() {
  self endon("vignette_end");
  self endon("death");
  self waittill("damage", var_00, var_01);
  self.vignette_interrupted = 1;
  vignette_actor_leave_safe_state();
}

vignette_loop_timeout_or_timeout_notify(param_00, param_01) {
  childthread vignette_loop_player_close_notify(self, "player_nearby");
  common_scripts\utility::func_A71A(param_01, "damage", "bulletwhizby", "player_nearby");
  self notify(param_00);
}

vignette_loop_player_close_notify(param_00, param_01) {
  for(;;) {
    foreach(var_03 in level.var_744A) {
      if(distance(var_03.var_116, param_00.var_116) < level.vignette_loop_interrupt_radius) {
        param_00 notify(param_01);
      }
    }

    wait(0.25);
  }
}

vignette_cooldown_run() {
  if(level.vignette_cooldown_current > 0) {
    return;
  }

  level.vignette_cooldown_current = level.vignette_cooldown_time;
  while(level.vignette_cooldown_current > 0) {
    level.vignette_cooldown_current = level.vignette_cooldown_current - 0.1;
    wait(0.1);
  }
}

vignette_radial_cooldown_run() {
  level.vignette_radial_cooldown_loc = self.var_116;
  var_00 = level.vignette_radial_cooldown_time;
  while(var_00 > 0) {
    var_00 = var_00 - 0.1;
    wait(0.1);
  }

  level.vignette_radial_cooldown_loc = undefined;
}

vignette_monitor_last_seen() {
  var_00 = self;
  var_00 endon("vignette_start");
  var_00 endon("vignette_cleanup");
  var_00.time_since_loc_seen = 0;
  while(!isDefined(var_00.ent_zone_name)) {
    wait 0.05;
  }

  var_00 thread vignette_monitor_last_seen_ticker();
  for(;;) {
    wait(randomfloatrange(0.25, 0.5));
    if(level.vignette_cooldown_current > level.vignette_spawn_cant_be_seen_for_time) {
      self.time_since_loc_seen = 0;
      continue;
    }

    var_01 = lib_055A::func_4626(var_00.ent_zone_name, 1, 0);
    foreach(var_03 in var_01) {
      var_04 = common_scripts\utility::func_AA4A(var_03 getEye(), var_03.var_1D, var_00.var_116, cos(32.5));
      var_05 = var_04 && sighttracepassed(var_03 getEye(), var_00.var_116 + (0, 0, 36), 0, 0);
      if(var_05) {
        self.time_since_loc_seen = 0;
        break;
      }
    }
  }
}

vignette_watch_zone_expire() {
  self endon("vignette_start");
  while(!isDefined(self.ent_zone_name)) {
    wait 0.05;
  }

  level waittillmatch(self.ent_zone_name, "zone_vignette_cleanup");
  self notify("vignette_cleanup");
}

vignette_monitor_last_seen_ticker() {
  self endon("vignette_start");
  self endon("vignette_cleanup");
  for(;;) {
    if(self.time_since_loc_seen >= level.vignette_spawn_cant_be_seen_for_time) {
      wait 0.05;
      continue;
    } else {
      self.time_since_loc_seen = self.time_since_loc_seen + 0.1;
    }

    wait 0.05;
  }
}

vignette_gunshots(param_00, param_01) {
  param_00 endon("death");
  param_01 endon("death");
  var_02 = randomfloatrange(0, 1);
  var_03 = ["mp40_zm", "type100_zm", "stg44_zm", "ppsh41_zm", "kar98_zm", "luger_zm", "m712_zm"];
  var_04 = var_03[randomint(var_03.size - 1)];
  if(var_02 <= level.vignette_gunshot_chance) {
    var_05 = randomintrange(1, 3);
    if(var_04 == "kar98_zm") {
      var_05 = 1;
    }

    for(var_06 = 0; var_06 < var_05; var_06++) {
      magicbullet(var_04, param_01.var_116, param_01.var_116 - (0, 0, 10));
      wait(randomfloatrange(0.15, 0.4));
    }
  }
}

vignette_wave_count_reset() {
  var_00 = 1;
  wait(2);
  for(;;) {
    if(lib_056D::func_584C(level.var_A980) && !var_00) {
      if(level.vignettes_total_per_wave_allowed < level.vignettes_total_per_wave_max) {
        level.vignettes_total_per_wave_allowed++;
      }

      level.vignettes_occurred_in_current_wave = 0;
      var_00 = 1;
    }

    if(!lib_056D::func_584C(level.var_A980) && var_00) {
      var_00 = 0;
    }

    wait(0.1);
  }
}

vignette_get_remaining_wave_count() {
  for(;;) {
    level waittill("zombie_wave_started");
    level.wave_start_intended_spawn_count = level.var_AC12 maps\mp\_utility::func_5DCB();
    vignette_get_remaining_wave_count_checked();
    wait 0.05;
  }
}

vignette_get_remaining_wave_count_checked() {
  level endon("zombie_wave_ended");
  for(;;) {
    var_00 = lib_0547::func_408F().size;
    var_01 = level.var_ABEC maps\mp\_utility::func_5DCB();
    var_02 = level.var_ABED maps\mp\_utility::func_5DCB();
    var_03 = level.var_AC12 maps\mp\_utility::func_5DCB();
    if(var_03 > level.wave_start_intended_spawn_count) {
      var_03 = 0;
    }

    level.remaining_zomb_count = var_03 + var_00 + var_01 + var_02;
    wait(0.25);
  }
}

vignette_listen_when_zone_activated() {
  while(!self.var_556E) {
    wait(0.5);
  }

  if(level.var_A980 == 0) {
    self.was_unlocked_on_wave = 1;
  } else {
    self.was_unlocked_on_wave = level.var_A980;
  }

  while(level.var_A980 <= self.was_unlocked_on_wave + level.vignette_recent_wave_buffer) {
    level waittill("zombie_wave_started");
  }

  level notify("zone_vignette_cleanup", self.var_AC8A);
}

vignette_is_not_near_zombies() {
  var_00 = lib_0547::func_408F();
  foreach(var_02 in var_00) {
    if(distance(var_02.var_116, self.var_116) < level.vignette_min_dist_from_other_zombies) {
      return 0;
    }
  }

  return 1;
}

func_5718(param_00, param_01) {
  if(isDefined(param_00)) {
    foreach(var_03 in param_00) {
      if(var_03 == param_01) {
        return 1;
      }
    }
  }

  return 0;
}

__debug_funcs() {}