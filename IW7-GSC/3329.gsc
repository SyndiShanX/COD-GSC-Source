/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3329.gsc
***************************************/

init_armageddon() {
  scripts\engine\utility::flag_init("armageddon_active");
  reset_armageddon_time();
  init_armageddon_areas();
  level.min_wait_between_metors = 0.2;
  level.max_wait_between_metors = 0.4;
  level.earthquake_time_extension = 10.0;
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

add_to_armageddon_time(var_00) {
  level.armageddon_time_remaining = level.armageddon_time_remaining + var_00;
}

armageddon_timer() {
  level endon("game_ended");

  while(level.armageddon_time_remaining > 0) {
    wait 1;
    level.armageddon_time_remaining--;
  }

  reset_armageddon_time();
  scripts\engine\utility::flag_clear("armageddon_active");
  level notify("armageddon_timeout");
}

start_armageddon(var_00) {
  level endon("game_ended");
  level endon("armageddon_timeout");

  for(;;) {
    var_01 = randomize_areas();

    foreach(var_03 in var_01) {
      drop_meteor_in_area(var_03, var_00);
      wait(randomfloatrange(level.min_wait_between_metors, level.max_wait_between_metors));
    }
  }
}

randomize_areas() {
  var_00 = scripts\engine\utility::array_randomize(level.armageddon_areas);
  var_01 = [];
  var_02 = [];

  foreach(var_04 in var_00) {
    if(area_has_enemies(var_04)) {
      var_1[var_1.size] = var_04;
      continue;
    }

    var_2[var_2.size] = var_04;
  }

  var_00 = scripts\engine\utility::array_combine(var_01, var_02);
  return var_00;
}

area_has_enemies(var_00) {
  var_01 = min(var_0[0][0], var_0[1][0]);
  var_02 = max(var_0[0][0], var_0[1][0]);
  var_03 = min(var_0[0][1], var_0[1][1]);
  var_04 = max(var_0[0][1], var_0[1][1]);

  foreach(var_06 in level.spawned_enemies) {
    if(var_01 <= var_6.origin[0] && var_6.origin[0] <= var_02 && (var_03 <= var_6.origin[1] && var_6.origin[1] <= var_04))
      return 1;
  }

  return 0;
}

drop_meteor_in_area(var_00, var_01) {
  var_02 = get_drop_pos(var_00);

  if(isDefined(var_01) && isplayer(var_01))
    magicbullet("iw7_armageddonmeteor_mp", var_2.start, var_2.end, var_01);
  else
    magicbullet("iw7_armageddonmeteor_mp", var_2.start, var_2.end, level.players[0]);
}

get_drop_pos(var_00) {
  if(area_has_enemies(var_00))
    return get_enemy_pos(var_00);
  else
    return get_random_drop_pos(var_00);
}

get_enemy_pos(var_00) {
  var_01 = spawnStruct();
  var_02 = min(var_0[0][0], var_0[1][0]);
  var_03 = max(var_0[0][0], var_0[1][0]);
  var_04 = min(var_0[0][1], var_0[1][1]);
  var_05 = max(var_0[0][1], var_0[1][1]);

  foreach(var_07 in level.spawned_enemies) {
    if(var_02 <= var_7.origin[0] && var_7.origin[0] <= var_03 && (var_04 <= var_7.origin[1] && var_7.origin[1] <= var_05)) {
      var_1.start = (var_7.origin[0] + randomfloatrange(-2000, 2000), var_7.origin[1] + randomfloatrange(-2000, 2000), 8000 + randomfloatrange(-1000, 1000));
      var_1.end = var_7.origin;
      return var_01;
    }
  }
}

get_random_drop_pos(var_00) {
  var_01 = spawnStruct();
  var_02 = min(var_0[0][0], var_0[1][0]);
  var_03 = max(var_0[0][0], var_0[1][0]);
  var_04 = min(var_0[0][1], var_0[1][1]);
  var_05 = max(var_0[0][1], var_0[1][1]);
  var_06 = randomfloatrange(var_02, var_03);
  var_07 = randomfloatrange(var_04, var_05);
  var_1.start = (var_06, var_07, 8000 + randomfloatrange(-1000, 1000));
  var_1.end = scripts\engine\utility::drop_to_ground((var_06 + randomfloatrange(-2000, 2000), var_07 + randomfloatrange(-2000, 2000), -8000), 72, -100) + (0, 0, 16);
  return var_01;
}

reset_armageddon_time() {
  level.armageddon_time_remaining = 0;
}

isfirstarmageddonmeteorhit(var_00) {
  if(!(isDefined(var_00) && var_00 == "iw7_armageddonmeteor_mp"))
    return 0;

  return !scripts\engine\utility::is_true(self.fling_from_meteor);
}

fling_zombie_from_meteor(var_00, var_01, var_02) {
  if(scripts\engine\utility::is_true(self.fling_from_meteor)) {
    return;
  }
  self endon("death");
  self.fling_from_meteor = 1;
  self.do_immediate_ragdoll = 1;
  self.customdeath = 1;
  var_03 = (self.origin - var_00) * (1, 1, 0);
  var_03 = vectornormalize(var_03);
  var_03 = vectornormalize(var_03 + (0, 0, 1)) * 600;
  self giveflagcapturexp(var_03);
  wait 0.5;
  self.fling_from_meteor = 0;
  self getrandomarmkillstreak(self.maxhealth + 10000, var_01);
}

do_armageddon_earthquake(var_00) {
  wait 1.5;
  earthquake(level.armageddon_earthquake_scale, var_00 + level.earthquake_time_extension, (742, -853, -85), 5000);
}

init_armageddon_areas() {
  level.armageddon_areas = [];
  var_00 = scripts\engine\utility::getstructarray("armageddon_area_marker", "targetname");

  foreach(var_02 in var_00) {
    var_03 = [];
    var_04 = scripts\engine\utility::getstruct(var_2.target, "targetname");
    var_3[var_3.size] = var_2.origin;
    var_3[var_3.size] = var_4.origin;
    level.armageddon_areas[level.armageddon_areas.size] = var_03;
  }
}