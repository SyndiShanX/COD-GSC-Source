/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_apache_player_difficulty.gsc
*********************************************************/

difficulty() {
  var_0 = spawnStruct();
  var_0.dmg_bullet_delay_between_msec = 350;
  var_0.dmg_bullet_pct = 0.08;
  var_0.dmg_projectile_pct = 0.76;
  var_0.dmg_player_health_adjust_chance = 0.45;
  var_0.dmg_player_speed_evade_min_pct = 0.5;
  var_0.dmg_player_speed_evade_max_pct = 0.2;
  var_0.dmg_bullet_chance_player_static = 0.55;
  var_0.dmg_bullet_chance_player_evade = 0.1;
  var_0.in_range_for_homing_missile_sqrd = squared(24000);

  switch (level.gameskill) {
    case 0:
      var_0.dmg_bullet_delay_between_msec = 450;
      var_0.dmg_bullet_pct = 0.02;
      var_0.dmg_bullet_chance_player_evade = 0.05;
      break;
    case 1:
      var_0.dmg_bullet_delay_between_msec = 350;
      var_0.dmg_bullet_pct = 0.04;
      break;
    case 2:
      var_0.dmg_bullet_delay_between_msec = 350;
      var_0.dmg_bullet_pct = 0.06;
      break;
    case 3:
      break;
    default:
      var_0.flares_auto = 1;
      break;
  }

  level.apache_player_difficulty = var_0;
}