/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\powers\coop_armageddon.gsc
*************************************************/

init_armageddon() {
  scripts\engine\utility::flag_init("armageddon_active");
  reset_armageddon_time();
  init_armageddon_areas();
  level.min_wait_between_metors = 0.2;
  level.max_wait_between_metors = 0.4;
  level.earthquake_time_extension = 10;
  level.armageddon_duration = 20;
  level.armageddon_earthquake_scale = 0.15;
}

armageddon_use() {
  add_to_armageddon_time(level.armageddon_duration);
  level thread do_armageddon_earthquake(level.armageddon_duration);
  if(scripts\engine\utility::flag("armageddon_active")) {
    return;
  }

  scripts\engine\utility::flag_set("armageddon_active");
  level thread armageddon_timer();
  level thread start_armageddon(self);
}

add_to_armageddon_time(var_0) {
  level.armageddon_time_remaining = level.armageddon_time_remaining + var_0;
}

armageddon_timer() {
  level endon("game_ended");
  while(level.armageddon_time_remaining > 0) {
    wait(1);
    level.armageddon_time_remaining--;
  }

  reset_armageddon_time();
  scripts\engine\utility::flag_clear("armageddon_active");
  level notify("armageddon_timeout");
}

start_armageddon(var_0) {
  level endon("game_ended");
  level endon("armageddon_timeout");
  for(;;) {
    var_1 = randomize_areas();
    foreach(var_3 in var_1) {
      drop_meteor_in_area(var_3, var_0);
      wait(randomfloatrange(level.min_wait_between_metors, level.max_wait_between_metors));
    }
  }
}

randomize_areas() {
  var_0 = scripts\engine\utility::array_randomize(level.armageddon_areas);
  var_1 = [];
  var_2 = [];
  foreach(var_4 in var_0) {
    if(area_has_enemies(var_4)) {
      var_1[var_1.size] = var_4;
      continue;
    }

    var_2[var_2.size] = var_4;
  }

  var_0 = scripts\engine\utility::array_combine(var_1, var_2);
  return var_0;
}

area_has_enemies(var_0) {
  var_1 = min(var_0[0][0], var_0[1][0]);
  var_2 = max(var_0[0][0], var_0[1][0]);
  var_3 = min(var_0[0][1], var_0[1][1]);
  var_4 = max(var_0[0][1], var_0[1][1]);
  foreach(var_6 in level.spawned_enemies) {
    if(var_1 <= var_6.origin[0] && var_6.origin[0] <= var_2 && var_3 <= var_6.origin[1] && var_6.origin[1] <= var_4) {
      return 1;
    }
  }

  return 0;
}

drop_meteor_in_area(var_0, var_1) {
  var_2 = get_drop_pos(var_0);
  if(isDefined(var_1) && isplayer(var_1)) {
    magicbullet("iw7_armageddonmeteor_mp", var_2.start, var_2.end, var_1);
    return;
  }

  magicbullet("iw7_armageddonmeteor_mp", var_2.start, var_2.end, level.players[0]);
}

get_drop_pos(var_0) {
  if(area_has_enemies(var_0)) {
    return get_enemy_pos(var_0);
  }

  return get_random_drop_pos(var_0);
}

get_enemy_pos(var_0) {
  var_1 = spawnStruct();
  var_2 = min(var_0[0][0], var_0[1][0]);
  var_3 = max(var_0[0][0], var_0[1][0]);
  var_4 = min(var_0[0][1], var_0[1][1]);
  var_5 = max(var_0[0][1], var_0[1][1]);
  foreach(var_7 in level.spawned_enemies) {
    if(var_2 <= var_7.origin[0] && var_7.origin[0] <= var_3 && var_4 <= var_7.origin[1] && var_7.origin[1] <= var_5) {
      var_1.start = (var_7.origin[0] + randomfloatrange(-2000, 2000), var_7.origin[1] + randomfloatrange(-2000, 2000), 8000 + randomfloatrange(-1000, 1000));
      var_1.end = var_7.origin;
      return var_1;
    }
  }
}

get_random_drop_pos(var_0) {
  var_1 = spawnStruct();
  var_2 = min(var_0[0][0], var_0[1][0]);
  var_3 = max(var_0[0][0], var_0[1][0]);
  var_4 = min(var_0[0][1], var_0[1][1]);
  var_5 = max(var_0[0][1], var_0[1][1]);
  var_6 = randomfloatrange(var_2, var_3);
  var_7 = randomfloatrange(var_4, var_5);
  var_1.start = (var_6, var_7, 8000 + randomfloatrange(-1000, 1000));
  var_1.end = scripts\engine\utility::drop_to_ground((var_6 + randomfloatrange(-2000, 2000), var_7 + randomfloatrange(-2000, 2000), -8000), 72, -100) + (0, 0, 16);
  return var_1;
}

reset_armageddon_time() {
  level.armageddon_time_remaining = 0;
}

isfirstarmageddonmeteorhit(var_0) {
  if(!isDefined(var_0) && var_0 == "iw7_armageddonmeteor_mp") {
    return 0;
  }

  return !scripts\engine\utility::istrue(self.fling_from_meteor);
}

fling_zombie_from_meteor(var_0, var_1, var_2) {
  if(scripts\engine\utility::istrue(self.fling_from_meteor)) {
    return;
  }

  self endon("death");
  self.fling_from_meteor = 1;
  self.do_immediate_ragdoll = 1;
  self.customdeath = 1;
  var_3 = self.origin - var_0 * (1, 1, 0);
  var_3 = vectornormalize(var_3);
  var_3 = vectornormalize(var_3 + (0, 0, 1)) * 600;
  self setvelocity(var_3);
  wait(0.5);
  self.fling_from_meteor = 0;
  self dodamage(self.maxhealth + 10000, var_1);
}

do_armageddon_earthquake(var_0) {
  wait(1.5);
  earthquake(level.armageddon_earthquake_scale, var_0 + level.earthquake_time_extension, (742, -853, -85), 5000);
}

init_armageddon_areas() {
  level.armageddon_areas = [];
  var_0 = scripts\engine\utility::getstructarray("armageddon_area_marker", "targetname");
  foreach(var_2 in var_0) {
    var_3 = [];
    var_4 = scripts\engine\utility::getstruct(var_2.target, "targetname");
    var_3[var_3.size] = var_2.origin;
    var_3[var_3.size] = var_4.origin;
    level.armageddon_areas[level.armageddon_areas.size] = var_3;
  }
}