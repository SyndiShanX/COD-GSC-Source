/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1570.gsc
**************************************/

main() {
  if(isDefined(level._id_3E86)) {
    level._effect["air_support_marker"] = loadfx("smoke/signal_smoke_air_support_paris_ac130");
  } else {
    level._effect["air_support_marker"] = loadfx("smoke/signal_smoke_air_support");
  }
  level._effect["air_support_trail"] = loadfx("smoke/smoke_geotrail_air_support");

  if(isDefined(level.air_support_sticky_marker_fx)) {
    level._effect["air_support_sticky_marker"] = level.air_support_sticky_marker_fx;
  }
  if(isDefined(level.enemy_air_support_marker_fx)) {
    level._effect["air_support_marker_enemy"] = level.enemy_air_support_marker_fx;
  }
  if(isDefined(level.enemy_air_support_trail_fx)) {
    level._effect["air_support_trail_enemy"] = level.enemy_air_support_trail_fx;
  }
  level.air_support_weapon = "ac130_40mm_air_support_strobe";
  precacheitem(level.air_support_weapon);
  precacheitem("air_support_strobe");
  precacherumble("ac130_artillery_rumble");
  common_scripts\utility::flag_init("flag_strobes_in_use");
  level._id_3E8B = [];
  level.air_support_strobe_count = 0;
  thread air_support_loop();

  foreach(var_1 in level.players) {
    var_1 maps\_utility::ent_flag_init("flag_strobe_ready");
    var_1 thread monitor_last_weapon();
  }

  maps\_utility::add_extra_autosave_check("autosave_check_air_support_strobe_not_in_use", ::autosave_check_air_support_strobe_not_in_use, "Can't save because an air support strobe is in use");
}

autosave_check_air_support_strobe_not_in_use() {
  return level.air_support_strobe_count == 0;
}

fake_strobe(var_0) {
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = var_0;
  thread notify_strobe_thrown(var_1);
  air_support_enqueue(var_1);
}

strobe_tracking() {
  self notify("stop_strobe_tracking");
  self endon("stop_strobe_tracking");
  self giveweapon("air_support_strobe");
  self setweaponammoclip("air_support_strobe", 99);
  self setactionslot(4, "weapon", "air_support_strobe");
  maps\_utility::ent_flag_set("flag_strobe_ready");
  var_0 = 18;

  if(isDefined(level._id_3E8E)) {
    var_0 = level._id_3E8E;
  }
  var_1 = weaponfiretime("air_support_strobe") - 0.05;

  for(;;) {
    self waittill("grenade_fire", var_2, var_3);
    var_2.owner = self;

    if(var_3 == "air_support_strobe") {
      var_2 thread strobe_think();
      wait(var_1);
      maps\_utility::ent_flag_clear("flag_strobe_ready");
      self takeweapon("air_support_strobe");
      ensure_player_has_weapon_selected();
      wait(var_0 - var_1);
      self giveweapon("air_support_strobe");
      self setweaponammoclip("air_support_strobe", 99);
      self setactionslot(4, "weapon", "air_support_strobe");
      refreshhudammocounter();
      maps\_utility::ent_flag_set("flag_strobe_ready");
      level notify("air_support_strobe_ready");
    }
  }
}

disable_strobes_for_player() {
  self takeweapon("air_support_strobe");
  ensure_player_has_weapon_selected();
  self notify("stop_strobe_tracking");
  maps\_utility::ent_flag_clear("flag_strobe_ready");
}

enable_strobes_for_player() {
  thread strobe_tracking();
}

air_support_loop() {
  var_0 = 2.5;

  if(isDefined(level._id_3E92)) {
    var_0 = level._id_3E92;
  }
  for(;;) {
    var_1 = air_support_dequeue();

    if(var_1 strobe_can_see_targets() || isDefined(level._id_3E93) && level._id_3E93) {
      level notify("air_suport_strobe_fired_upon", var_1);
      thread count_strobe_kills(8);

      if(!isDefined(level._id_3E94) || !level._id_3E94) {
        var_1 thread strobe_enemy_badplace();
      }
      wait(var_0);
      var_1 strobe_fire();
      continue;
    }

    level notify("air_support_strobe_no_targets");
    wait 1;
  }
}

notify_strobe_thrown(var_0) {
  level notify("air_support_strobe_thrown", var_0);
  level endon("air_support_strobe_thrown");
  common_scripts\utility::flag_set("flag_strobes_in_use");
  wait 5;

  for(;;) {
    while(!air_support_queue_empty()) {
      wait 1;
    }
    wait 10;

    if(air_support_queue_empty()) {
      break;
    }
  }

  common_scripts\utility::flag_clear("flag_strobes_in_use");
}

strobe_enemy_badplace() {
  self endon("death");
  var_0 = 5.8;

  if(isDefined(level._id_3E97)) {
    var_0 = 3;
  }
  wait(var_0);
  var_1 = 512;
  var_2 = 400;
  var_3 = 11 - var_0;
  badplace_cylinder("", var_3, self.origin - (0, 0, var_1 / 2), var_2, var_1, "axis");
  level._id_3E97 = 1;
}

strobe_think(var_0) {
  self endon("death");
  thread monitor_strobe_count();
  thread notify_strobe_thrown(self);
  self.fx_origin = common_scripts\utility::spawn_tag_origin();
  self.fx_origin linkTo(self);
  wait 0.1;

  if(isDefined(var_0) && var_0) {
    playFXOnTag(common_scripts\utility::getfx("air_support_trail_enemy"), self.fx_origin, "tag_origin");
    self._id_3E9A = 1;
  } else {
    playFXOnTag(common_scripts\utility::getfx("air_support_trail"), self.fx_origin, "tag_origin");
  }
  wait 2.35;
  var_1 = 0.5;
  var_2 = gettime() + var_1 * 1000;
  var_3 = self.origin;

  while(gettime() < var_2) {
    common_scripts\utility::waitframe();
    var_4 = (self.origin - var_3) * 20;
    var_3 = self.origin;

    if(var_4[2] >= 0) {
      break;
    }
  }

  var_5 = bulletTrace(self.origin, self.origin + (0, 0, -1024), 1, undefined, 1);

  if(isDefined(var_5["position"])) {
    self.origin = var_5["position"];
  }
  if(isDefined(self._id_3E9B) && self._id_3E9B) {
    thread marker_pulse();
  } else if(isDefined(var_0) && var_0) {
    playFX(common_scripts\utility::getfx("air_support_marker_enemy"), self.origin);
  } else {
    playFX(common_scripts\utility::getfx("air_support_marker"), self.origin);
  }
  air_support_enqueue(self);
  var_6 = 512;
  var_7 = 650;
  badplace_cylinder("", 9.5, self.origin - (0, 0, var_6 / 2), var_7, var_6, "allies");
  wait 15;

  if(isDefined(self.fx_origin)) {
    if(isDefined(var_0) && var_0) {
      stopFXOnTag(common_scripts\utility::getfx("air_support_marker_enemy"), self.fx_origin, "tag_origin");
    } else {
      stopFXOnTag(common_scripts\utility::getfx("air_support_marker"), self.fx_origin, "tag_origin");
    }
    self.fx_origin delete();
  }

  self delete();
}

monitor_strobe_count() {
  if(!isDefined(self)) {
    return;
  }
  level.air_support_strobe_count++;
  self waittill("death");
  wait 4;
  level.air_support_strobe_count--;
}

marker_pulse() {
  self endon("death");
  var_0 = 5;
  var_1 = 0.3;

  for(var_2 = 0; var_2 <= var_0 / var_1; var_2++) {
    if(isDefined(self.fx_origin)) {
      playFXOnTag(common_scripts\utility::getfx("air_support_sticky_marker"), self.fx_origin, "tag_origin");
      wait(var_1);
      continue;
    }

    break;
  }

  wait 1;
  stopFXOnTag(common_scripts\utility::getfx("air_support_sticky_marker"), self.fx_origin, "tag_origin");
}

linkto_without_angles(var_0) {
  self endon("death");
  self unlink();
  self rotateTo((0, 0, 90), 0.05);

  while(isDefined(var_0) && isDefined(var_0.origin)) {
    self moveTo(var_0.origin, 0.05);
    common_scripts\utility::waitframe();
  }
}

air_support_enqueue(var_0) {
  level._id_3E8B[level._id_3E8B.size] = var_0;
  level notify("air_support_strobe_popped", var_0);
}

air_support_dequeue() {
  for(level._id_3E8B = common_scripts\utility::array_removeundefined(level._id_3E8B); level._id_3E8B.size == 0; level._id_3E8B = common_scripts\utility::array_removeundefined(level._id_3E8B)) {
    level waittill("air_support_strobe_popped", var_0);
  }
  return level._id_3E8B[0];
}

air_support_queue_empty() {
  return level._id_3E8B.size == 0;
}

set_aircraft(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    level._id_3EA2 = var_1;
  }
  if(isDefined(var_2)) {
    level._id_3EA3 = var_2;
  }
  level.air_support_aircraft = var_0;
}

get_gun_pos() {
  if(isDefined(level.air_support_aircraft) && isalive(level.air_support_aircraft)) {
    var_0 = level.air_support_aircraft.origin;

    if(isDefined(level._id_3EA3)) {
      var_0 = level.air_support_aircraft gettagorigin(level._id_3EA3);
    }
    if(isDefined(level._id_3EA2)) {
      var_1 = level.player getEye();

      if(var_0[2] > level._id_3EA2 && var_1[2] < level._id_3EA2) {
        var_2 = (level._id_3EA2 - var_1[2]) / (var_0[2] - var_1[2]);
        var_0 = maps\_utility::linear_interpolate(var_2, level.player.origin, var_0);
      }
    }

    return var_0;
  } else {
    return self.origin + (30, 15, 12000);
  }
}

get_gun_test_pos() {
  return get_gun_pos();
}

strobe_can_see_targets() {
  var_0 = compute_targets(self.origin, get_gun_pos());
  var_0 = filter_visible_targets(var_0, get_gun_test_pos());
  return var_0.size > 0;
}

strobe_fire() {
  self endon("death");

  if(!isDefined(self)) {
    return;
  }
  var_0 = 10;
  var_1 = 200;
  var_2 = 60 / var_1;
  maps\_audio::aud_send_msg("ac130_prepare_inc");

  for(var_3 = 0; var_3 < var_0; var_3++) {
    var_4 = get_gun_pos();
    var_5 = get_gun_test_pos();
    var_6 = compute_targets(self.origin, var_4);
    var_6 = filter_visible_targets(var_6, var_5);
    var_7 = get_best_target(var_6, var_3, var_0);

    if(!isDefined(var_7)) {
      var_7 = self.origin + noise_vector(32);
    }
    if(isDefined(self._id_3E9A)) {
      var_8 = magicbullet(level.air_support_weapon, var_4, var_7);
    } else {
      var_8 = magicbullet(level.air_support_weapon, var_4, var_7, self.owner);
    }
    var_8 thread projectile_impact_earthquake(0.3, 0.5, 1200);
    var_9 = spawnStruct();
    var_9._id_3EA9 = var_7;
    var_9._id_3EAA = var_2;
    var_9._id_3EAB = var_8;
    maps\_audio::aud_send_msg("aud_ac130_bullet", var_9);
    wait(var_2);
  }

  if(isDefined(self.fx_origin)) {
    stopFXOnTag(common_scripts\utility::getfx("air_support_marker"), self.fx_origin, "tag_origin");
    self.fx_origin delete();
  }

  self delete();
}

projectile_impact_earthquake(var_0, var_1, var_2) {
  var_3 = self.origin;

  while(isDefined(self)) {
    var_3 = self.origin;
    wait 0.1;
  }

  earthquake(var_0, var_1, var_3, var_2);
  playrumbleonposition("ac130_artillery_rumble", var_3);
}

compute_targets(var_0, var_1) {
  var_2 = 512;
  var_3 = 32;
  var_4 = 64;
  var_5 = 7500;
  var_6 = 1.1;
  var_7 = distance(var_0, var_1) / var_5 * var_6;
  var_8 = [];
  var_8[var_8.size] = var_0 + noise_vector(var_4);

  foreach(var_10 in vehicle_getarray()) {
    if(!isDefined(var_10._id_3EAE) && distance2d(var_10.origin, var_0) < var_2) {
      var_8[var_8.size] = var_10.origin + var_10 vehicle_getvelocity() * var_7 + noise_vector(var_3);
    }
  }

  foreach(var_13 in getaiarray("axis", "neutral")) {
    if(isalive(var_13) && !isDefined(var_13._id_3EAE) && distance(var_13.origin, var_0) < var_2) {
      var_8[var_8.size] = var_13.origin + noise_vector(var_3);
    }
  }

  return var_8;
}

get_best_target(var_0, var_1, var_2) {
  var_3 = 512;
  var_4 = self.origin + vectorNormalize(self.origin - level.player.origin) * var_3;
  var_5 = self.origin + vectorNormalize(level.player.origin - self.origin) * var_3;
  var_6 = vectorlerp(var_4, var_5, var_1 / var_2);
  var_7 = 9999999;
  var_8 = undefined;

  foreach(var_10 in var_0) {
    var_11 = distance2d(var_6, var_10);

    if(var_11 < var_7) {
      var_7 = var_11;
      var_8 = var_10;
    }
  }

  return var_8;
}

filter_visible_targets(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(visibility_check(var_1, var_4)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

noise_vector(var_0) {
  return common_scripts\utility::randomvectorrange(0, var_0) * (1, 1, 0);
}

visibility_check(var_0, var_1) {
  return bullettracepassed(var_0, var_1 + (0, 0, 128), 0, undefined);
}

count_strobe_kills(var_0) {
  level notify("air_support_strobe_stop_damage_watcher");
  level.air_support_strobe_num_killed = 0;
  level._id_3EB5 = 0;

  foreach(var_2 in getaiarray("axis")) {}
  var_2 thread damage_watcher();

  foreach(var_5 in vehicle_getarray()) {
    if(isDefined(var_5.script_team) && var_5.script_team == "axis") {
      var_5 thread damage_watcher();
    }
  }

  wait(var_0);
  level notify("air_support_strobe_stop_damage_watcher");
  level notify("air_support_strobe_killed", level.air_support_strobe_num_killed);
}

get_num_kills() {
  return level.air_support_strobe_num_killed;
}

damage_watcher() {
  level endon("air_support_strobe_stop_damage_watcher");

  if(self.health <= 0) {
    return;
  }
  while(isDefined(self)) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    var_10 = 0;

    if(isDefined(self.healthbuffer)) {
      var_10 = self.healthbuffer;
    }
    if(isDefined(var_9) && var_9 == level.air_support_weapon && (isDefined(self) && isDefined(self.health) && self.health <= var_10 && self.health + var_0 > var_10) && !maps\_vehicle::is_godmode()) {
      level.air_support_strobe_num_killed++;

      if(isDefined(level.btr_courtyard) && self == level.btr_courtyard) {
        level._id_3EB5 = 1;
      }
      return;
    } else if(!isDefined(self) || !isDefined(self.health) || self.health <= var_10) {
      return;
    }
  }
}

monitor_last_weapon() {
  self endon("death");
  var_0 = self getcurrentweapon();
  self.last_weapon = var_0;

  for(;;) {
    var_0 = self getcurrentweapon();
    self waittill("weapon_change", var_1);
    self.last_weapon = var_0;
    var_0 = var_1;
  }
}

ensure_player_has_weapon_selected() {
  if(self getcurrentweapon() == "none") {
    var_0 = 0;

    if(isDefined(self.last_weapon) && self.last_weapon != "none" && self hasweapon(self.last_weapon)) {
      var_0 = self switchtoweapon(self.last_weapon);
    } else {
      var_1 = self getweaponslistprimaries();

      if(var_1.size > 0) {
        var_0 = self switchtoweapon(var_1[0]);
      }
    }
  }
}