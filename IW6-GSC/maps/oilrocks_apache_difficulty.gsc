/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_apache_difficulty.gsc
***********************************************/

apache_mission_difficulty() {
  level.apache_difficulty = spawnStruct();
  var_0 = 0;
  var_1 = 7.0;
  var_2 = 10.5;
  var_3 = 600;
  var_4 = 900;
  var_5 = 19999;
  var_6 = 1999;
  var_7 = 10000;
  var_8 = squared(12000);
  var_9 = squared(12000);
  var_10 = squared(1600);
  var_11 = 700;
  var_12 = 2000;
  var_13 = 1.5;
  var_14 = 4000;
  var_15 = 0.4;
  var_16 = 12;

  switch (level.gameskill) {
    case 0:
      var_1 = 8.0;
      var_2 = 11.5;
      var_3 = 900;
      var_4 = 900;
      var_7 = 8000;
      var_5 = 11999;
      var_6 = 1199;
      var_16 = 5;
      break;
    case 1:
      var_7 = 10000;
      var_16 = 9;
      break;
    case 2:
      var_7 = 12000;
      var_16 = 11;
      break;
    case 3:
      var_7 = 15000;
      var_1 = 6.0;
      var_2 = 9.5;
      break;
    default:
      break;
  }

  level.apache_difficulty.flares_auto = var_0;
  level.apache_difficulty.ai_rpg_attack_delay_min = var_1;
  level.apache_difficulty.ai_rpg_attack_delay_max = var_2;
  level.apache_difficulty.enemy_zpu_health = var_3;
  level.apache_difficulty.enemy_gaz_health = var_4;
  level.apache_difficulty.enemy_m800_health = var_7;
  level.apache_difficulty.enemy_hind_health = var_5;
  level.apache_difficulty.enemy_gunboat_health = var_6;
  level.apache_difficulty.zpu_range_squared = var_8;
  level.apache_difficulty.veh_turret_range_squared = var_9;
  level.apache_difficulty.heli_vs_heli_mg_range_2d_squared = var_10;
  level.apache_difficulty.heli_vs_heli_min_shoot_time_msec = var_11;
  level.apache_difficulty.heli_vs_heli_max_shoot_time_msec = var_12;
  level.apache_difficulty.vehicle_vs_player_lock_on_time = var_13;
  level.apache_difficulty.gunboat_time_between_missiles_msec = var_14;
  level.apache_difficulty.gunboat_chance_fire_missile_at_ai = var_15;
  level.apache_difficulty.zpu_magic_bullets = var_16;
}