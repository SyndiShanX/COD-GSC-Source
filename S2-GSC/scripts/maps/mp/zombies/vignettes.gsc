/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\vignettes.gsc
*************************************************/

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

  while(!isDefined(level.players) || level.players.size == 0)
    waitframe();

  foreach(var_1 in level._id_AC80._id_ACB3)
  var_1 thread vignette_listen_when_zone_activated();

  level thread vignette_get_remaining_wave_count();
  var_3 = common_scripts\utility::_id_46B7("vignette_groundkill_org", "targetname");

  foreach(var_5 in var_3)
  var_5 thread vignette_handler("groundkill");

  var_7 = common_scripts\utility::_id_46B7("vignette_wallkill_org", "targetname");

  foreach(var_5 in var_7)
  var_5 thread vignette_handler("wallkill");
}

vignette_handler(var_0) {
  var_1 = spawnStruct();
  var_1.origin = self.origin;
  var_1 thread vignette_monitor_last_seen();
  var_1 thread vignette_watch_zone_expire();
  level.vignettes_all[level.vignettes_all.size] = var_1;

  for(;;) {
    switch (var_0) {
      case "groundkill":
        thread vignette_start_listener(var_1, self.origin, level.vignette_groundkill_dist, level.vignette_groundkill_chance, 1);
        break;
      case "wallkill":
        thread vignette_start_listener(var_1, self.origin, level.vignette_wallkill_dist, level.vignette_wallkill_chance, 1);
        break;
      case "solodeath":
        thread vignette_start_listener(var_1, self.origin, level.vignette_solodeath_dist, level.vignette_solodeath_chance, 0);
        break;
      default:
        break;
    }

    var_1 waittill("vignette_start");

    switch (var_0) {
      case "groundkill":
        vignette_run(var_1, undefined, undefined, "scripted_vignette_z_groundkill_loop", "scripted_vignette_groundkill_loop", "scripted_vignette_z_groundkill_exit", "scripted_vignette_groundkill_exit");
        break;
      case "wallkill":
        vignette_run(var_1, "scripted_vignette_z_wallkill_intro", "scripted_vignette_wallkill_intro", "scripted_vignette_z_wallkill_loop", "scripted_vignette_wallkill_loop", "scripted_vignette_z_wallkill_exit", "scripted_vignette_wallkill_exit");
        break;
      case "solodeath":
        vignette_run(var_1, undefined, undefined, undefined, undefined, undefined, undefined, "scripted_vignette_solodeath_loop");
        break;
      default:
        break;
    }

    return;
  }
}

vignette_start_listener(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("vignette_start");
  var_0 endon("vignette_cleanup");

  while(!isDefined(level.players) || level.players.size == 0)
    waitframe();

  var_5 = undefined;

  while(!common_scripts\utility::_id_562E(level._id_AC80._id_08A9))
    waitframe();

  var_6 = 50;
  var_7 = self.origin + (0, 0, var_6);
  var_5 = _id_055A::_id_578B(var_7, 0);
  var_0.ent_zone_name = var_5;

  for(;;) {
    var_8 = _id_0547::_id_408F();
    var_0.is_in_player_zone = 0;

    if(isDefined(var_5)) {
      var_9 = _id_055A::_id_4626(var_5, 0, 0);
      var_0.is_in_player_zone = var_9.size > 0;
    }

    var_0.is_in_recently_enabled_zone = 0;

    if(isDefined(var_5) && isDefined(level._id_AC80._id_ACB3[var_5].was_unlocked_on_wave) && level._id_AC80._id_ACB3[var_5].was_unlocked_on_wave > level._id_A980 - level.vignette_recent_wave_buffer)
      var_0.is_in_recently_enabled_zone = 1;

    var_0.radial_cooldown_is_safe = 1;

    if(isDefined(level.vignette_radial_cooldown_loc))
      var_0.radial_cooldown_is_safe = distance(level.vignette_radial_cooldown_loc, self.origin) > level.vignette_radial_cooldown_dist;

    var_0.not_over_zombie_limit = var_8.size < level.vignette_max_level_zombies_allowed;
    var_0.wave_isnt_over = !_id_056D::_id_584C(level._id_A980);
    var_0.limit_not_reached = level.vignettes_occurred_in_current_wave < level.vignettes_total_per_wave_allowed;
    var_0.players_not_seen_for_time = var_0.time_since_loc_seen >= level.vignette_spawn_cant_be_seen_for_time;
    var_0.req_zombs_remaining = level.vignette_req_remaining_zombies_to_spawn < level.remaining_zomb_count;

    if(var_0.not_over_zombie_limit && var_0.wave_isnt_over && var_0.is_in_player_zone && var_0.is_in_recently_enabled_zone && level._id_A980 != 0 && level._id_7F2A != "zombie_dog" && level.vignette_cooldown_current <= 0 && var_0.limit_not_reached && var_0.radial_cooldown_is_safe && var_0.players_not_seen_for_time && var_0.req_zombs_remaining) {
      var_10 = [];
      var_11 = [];

      foreach(var_13 in level.players) {
        var_14 = 0;

        if(isDefined(self._id_0165))
          var_14 = common_scripts\utility::stringtofloat(self._id_0165);

        var_15 = common_scripts\utility::within_fov(var_13 getEye(), var_13.angles, var_7, _cos(32.5));
        var_16 = distance(var_7, var_13.origin) < var_2;
        var_17 = distance(var_7, var_13.origin) < level.vignette_min_dist;
        var_18 = 0;

        if(_abs(var_13.origin[2] - self.origin[2]) < 150)
          var_18 = 1;

        if(var_15) {
          break;
        }

        if(!var_16)
          var_10[var_10.size] = var_13;

        var_19 = common_scripts\utility::within_fov(self.origin, self.angles + (0, var_14, 0), var_13.origin, _cos(60));
        var_20 = 1;

        if(var_4 && !var_19)
          var_20 = 0;

        if(!var_17 && var_16 && var_20)
          var_11[var_11.size] = var_13;
      }

      if(var_11.size > 0 && var_11.size + var_10.size == level.players.size)
        var_0 notify("vignette_start");

      wait(_randomfloatrange(1.5, 3));
      continue;
    }

    wait(_randomfloatrange(2, 5));
  }
}

vignette_run(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level thread vignette_cooldown_run();
  thread vignette_radial_cooldown_run();
  var_8 = ["soldier_rus"];
  var_9 = 1;
  var_10 = _id_054D::_id_90BA("zombie_generic", self, "vignette", 0, var_9, 0, common_scripts\utility::random(var_8));

  if(isDefined(var_10)) {
    var_10.health = 1;
    var_10.is_fellow_human = 1;
    var_10.not_valid_sacrifice = 1;
    var_10 _id_0547::disableoffhandsecondaryweapons();
  }

  level.vignettes_active[level.vignettes_active.size] = self;
  var_11 = _id_054D::_id_90BA("zombie_generic", self, "vignette", 0, var_9, 0);

  if(isDefined(var_11)) {
    var_11.vignette_interrupted = 0;
    var_11._id_6941 = 1;
    var_11 _id_0547::disableoffhandsecondaryweapons();
  }

  level.vignettes_occurred_in_current_wave = level.vignettes_occurred_in_current_wave + 1;

  if(isalive(var_11) && isalive(var_10))
    thread vignette_gunshots(var_11, var_10);

  if(isDefined(var_7) && isalive(var_10)) {
    var_12 = var_10 maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_7);
    var_13 = var_10 getanimentry(var_12, 0);
    var_14 = _getstartorigin(self.origin, self.angles, var_13);
    var_15 = _getstartangles(self.origin, self.angles, var_13);
    var_10 vignette_actor_enter_safe_state();
    var_10 vignette_actor_run_anim_entry(var_14, var_15, var_12, 30);
  } else {
    var_11.vignettepartner = var_10;
    var_10.vignettepartner = var_11;
    var_11 vignette_actor_enter_safe_state();
    var_10 vignette_actor_enter_safe_state();

    if(isDefined(var_1) && isDefined(var_2) && isDefined(var_11) && isalive(var_11) && isDefined(var_10) && isalive(var_10) && !common_scripts\utility::_id_562E(var_11.vignette_interrupted))
      vignette_execute_paired_scene(var_11, var_10, var_1, var_2, 0);
    else if(isalive(var_10))
      _id_0378::_id_8D74("play_vignette_victim_hurt_vo", var_10);

    if(isDefined(var_3) && isDefined(var_4) && isDefined(var_11) && isalive(var_11) && isDefined(var_10) && isalive(var_10) && !common_scripts\utility::_id_562E(var_11.vignette_interrupted))
      vignette_execute_paired_scene(var_11, var_10, var_3, var_4, 1);

    if(isDefined(var_5) && isDefined(var_6) && isDefined(var_11) && isalive(var_11) && isDefined(var_10) && isalive(var_10) && !common_scripts\utility::_id_562E(var_11.vignette_interrupted))
      vignette_execute_paired_scene(var_11, var_10, var_5, var_6, 0);

    var_11 vignette_actor_leave_safe_state();
    var_10 vignette_actor_leave_safe_state();
  }

  var_10._id_78D2 = 1;
  var_10 dodamage(1000, var_10.origin);
  var_0 notify("vignette_end");
  level.vignettes_active = common_scripts\utility::_id_0F93(level.vignettes_active, self);
  level.vignettes_all = common_scripts\utility::_id_0F93(level.vignettes_all, var_0);
}

vignette_execute_paired_scene(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0 maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_2);
  var_6 = var_0 getanimentry(var_5, 0);
  var_7 = _getstartorigin(self.origin, self.angles, var_6);
  var_8 = _getstartangles(self.origin, self.angles, var_6);
  var_9 = _getanimlength(var_6);
  var_10 = var_0 maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_3);
  var_11 = var_0 getanimentry(var_10, 0);
  var_12 = _getstartorigin(self.origin, self.angles, var_11);
  var_13 = _getstartangles(self.origin, self.angles, var_11);
  var_14 = undefined;

  if(var_4)
    var_14 = _randomfloatrange(level.vignette_loop_min_timeout, level.vignette_loop_max_timeout);

  var_1 thread vignette_actor_run_anim_entry(var_12, var_13, var_10, var_14);
  var_0 thread vignette_actor_run_anim_entry(var_7, var_8, var_5, var_14);
  wait(var_9);
}

vignette_actor_run_anim_entry(var_0, var_1, var_2, var_3) {
  self endon("damage");
  self endon("death");
  self setOrigin(var_0, 0);
  self.angles = var_1;
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", var_1);
  self scragentsetanimscale(1, 1);
  self scragentsetphysicsmode("noclip");

  if(isDefined(var_3))
    vignette_zombie_run_loop(var_2, var_3);
  else
    maps\mp\agents\_scripted_agent_anim_util::_id_71FD(var_2, 0, "scripted_anim");
}

vignette_zombie_run_loop(var_0, var_1) {
  self endon("loop_end");

  if(isDefined(var_1))
    thread vignette_loop_timeout_or_timeout_notify("loop_end", var_1);

  maps\mp\agents\_scripted_agent_anim_util::_id_71FD(var_0, 0, "scripted_anim");
}

vignette_actor_enter_safe_state() {
  if(!isalive(self)) {
    return;
  }
  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "vignette spawn");
  self._id_509A = 1;
  thread vignette_damage_listener();
}

vignette_actor_leave_safe_state() {
  if(!isalive(self)) {
    return;
  }
  if(isDefined(self.vignettepartner))
    self.vignettepartner = undefined;

  self scragentsetscripted(0);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "vignette spawn");
}

vignette_damage_listener() {
  self endon("vignette_end");
  self endon("death");
  self waittill("damage", var_0, var_1);
  self.vignette_interrupted = 1;
  vignette_actor_leave_safe_state();
}

vignette_loop_timeout_or_timeout_notify(var_0, var_1) {
  childthread vignette_loop_player_close_notify(self, "player_nearby");
  common_scripts\utility::_id_A71A(var_1, "damage", "bulletwhizby", "player_nearby");
  self notify(var_0);
}

vignette_loop_player_close_notify(var_0, var_1) {
  for(;;) {
    foreach(var_3 in level.players) {
      if(distance(var_3.origin, var_0.origin) < level.vignette_loop_interrupt_radius)
        var_0 notify(var_1);
    }

    wait 0.25;
  }
}

vignette_cooldown_run() {
  if(level.vignette_cooldown_current > 0) {
    return;
  }
  level.vignette_cooldown_current = level.vignette_cooldown_time;

  while(level.vignette_cooldown_current > 0) {
    level.vignette_cooldown_current = level.vignette_cooldown_current - 0.1;
    wait 0.1;
  }
}

vignette_radial_cooldown_run() {
  level.vignette_radial_cooldown_loc = self.origin;
  var_0 = level.vignette_radial_cooldown_time;

  while(var_0 > 0) {
    var_0 = var_0 - 0.1;
    wait 0.1;
  }

  level.vignette_radial_cooldown_loc = undefined;
}

vignette_monitor_last_seen() {
  var_0 = self;
  var_0 endon("vignette_start");
  var_0 endon("vignette_cleanup");
  var_0.time_since_loc_seen = 0;

  while(!isDefined(var_0.ent_zone_name))
    waitframe();

  var_0 thread vignette_monitor_last_seen_ticker();

  for(;;) {
    wait(_randomfloatrange(0.25, 0.5));

    if(level.vignette_cooldown_current > level.vignette_spawn_cant_be_seen_for_time) {
      self.time_since_loc_seen = 0;
      continue;
    }

    var_1 = _id_055A::_id_4626(var_0.ent_zone_name, 1, 0);

    foreach(var_3 in var_1) {
      var_4 = common_scripts\utility::within_fov(var_3 getEye(), var_3.angles, var_0.origin, _cos(32.5));
      var_5 = var_4 && _sighttracepassed(var_3 getEye(), var_0.origin + (0, 0, 36), 0, 0);

      if(var_5) {
        self.time_since_loc_seen = 0;
        break;
      }
    }
  }
}

vignette_watch_zone_expire() {
  self endon("vignette_start");

  while(!isDefined(self.ent_zone_name))
    waitframe();

  level waittillmatch("zone_vignette_cleanup", self.ent_zone_name);
  self notify("vignette_cleanup");
}

vignette_monitor_last_seen_ticker() {
  self endon("vignette_start");
  self endon("vignette_cleanup");

  for(;;) {
    if(self.time_since_loc_seen >= level.vignette_spawn_cant_be_seen_for_time) {
      waitframe();
      continue;
    } else
      self.time_since_loc_seen = self.time_since_loc_seen + 0.1;

    waitframe();
  }
}

vignette_gunshots(var_0, var_1) {
  var_0 endon("death");
  var_1 endon("death");
  var_2 = _randomfloatrange(0, 1);
  var_3 = ["mp40_zm", "type100_zm", "stg44_zm", "ppsh41_zm", "kar98_zm", "luger_zm", "m712_zm"];
  var_4 = var_3[randomint(var_3.size - 1)];

  if(var_2 <= level.vignette_gunshot_chance) {
    var_5 = _randomintrange(1, 3);

    if(var_4 == "kar98_zm")
      var_5 = 1;

    for(var_6 = 0; var_6 < var_5; var_6++) {
      _magicbullet(var_4, var_1.origin, var_1.origin - (0, 0, 10));
      wait(_randomfloatrange(0.15, 0.4));
    }
  }
}

vignette_wave_count_reset() {
  var_0 = 1;
  wait 2;

  for(;;) {
    if(_id_056D::_id_584C(level._id_A980) && !var_0) {
      if(level.vignettes_total_per_wave_allowed < level.vignettes_total_per_wave_max)
        level.vignettes_total_per_wave_allowed++;

      level.vignettes_occurred_in_current_wave = 0;
      var_0 = 1;
    }

    if(!_id_056D::_id_584C(level._id_A980) && var_0)
      var_0 = 0;

    wait 0.1;
  }
}

vignette_get_remaining_wave_count() {
  for(;;) {
    level waittill("zombie_wave_started");
    level.wave_start_intended_spawn_count = level._id_AC12 maps\mp\_utility::_id_5DCB();
    vignette_get_remaining_wave_count_checked();
    waitframe();
  }
}

vignette_get_remaining_wave_count_checked() {
  level endon("zombie_wave_ended");

  for(;;) {
    var_0 = _id_0547::_id_408F().size;
    var_1 = level._id_ABEC maps\mp\_utility::_id_5DCB();
    var_2 = level._id_ABED maps\mp\_utility::_id_5DCB();
    var_3 = level._id_AC12 maps\mp\_utility::_id_5DCB();

    if(var_3 > level.wave_start_intended_spawn_count)
      var_3 = 0;

    level.remaining_zomb_count = var_3 + var_0 + var_1 + var_2;
    wait 0.25;
  }
}

vignette_listen_when_zone_activated() {
  while(!self._id_556E)
    wait 0.5;

  if(level._id_A980 == 0)
    self.was_unlocked_on_wave = 1;
  else
    self.was_unlocked_on_wave = level._id_A980;

  while(level._id_A980 <= self.was_unlocked_on_wave + level.vignette_recent_wave_buffer)
    level waittill("zombie_wave_started");

  level notify("zone_vignette_cleanup", self._id_AC8A);
}

vignette_is_not_near_zombies() {
  var_0 = _id_0547::_id_408F();

  foreach(var_2 in var_0) {
    if(distance(var_2.origin, self.origin) < level.vignette_min_dist_from_other_zombies)
      return 0;
  }

  return 1;
}

_id_5718(var_0, var_1) {
  if(isDefined(var_0)) {
    foreach(var_3 in var_0) {
      if(var_3 == var_1)
        return 1;
    }
  }

  return 0;
}

__debug_funcs() {}