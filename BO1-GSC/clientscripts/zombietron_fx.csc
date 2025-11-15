/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\zombietron_fx.csc
*******************************************/

#include clientscripts\_utility;
#include clientscripts\_fx;

main() {
  clientscripts\createfx\zombietron_fx::main();
  clientscripts\_fx::reportNumEffects();
  footsteps();
  precache_scripted_fx();
  precache_util_fx();
  precache_createfx_fx();
  disableFX = GetDvarInt(#"disable_fx");
  if(!isDefined(disableFX) || disableFX <= 0) {
    precache_scripted_fx();
  }
}
footsteps() {}
precache_util_fx() {}
precache_scripted_fx() {
  level._effect["eye_glow"] = LoadFx("misc/fx_zombie_eye_single_zt");
  level._effect["gib_death"] = loadfx("weapon/thunder_gun/fx_thundergun_exp");
  level._effect["big_blood"] = loadfx("weapon/thunder_gun/fx_thundergun_gib_dissolve");
  level._effect["nuke_dust"] = loadfx("maps/zombie/fx_zombie_body_nuke_dust");
  level._effect["powerup_on"] = loadfx("misc/fx_zombie_powerup_on_zt");
  level._effect["powerup_on_red"] = loadfx("misc/fx_zombie_powerup_on_red_zt");
  level._effect["powerup_on_silver"] = loadfx("misc/fx_zombie_powerup_on_silver_zt");
  level._effect["powerup_grabbed"] = loadfx("misc/fx_zombie_powerup_grab");
  level._effect["powerup_grabbed_wave"] = loadfx("misc/fx_zombie_powerup_wave");
  level._effect["spot_light"] = loadfx("maps/zombietron/fx_zmbtron_pandoras_light");
  level._effect["torch_light"] = LoadFX("env/fire/fx_fire_sm");
  level._effect["electric_trap"] = loadfx("maps/zombie/fx_zombie_theater_electric_trap");
  level._effect["bomb"] = loadfx("explosions/fx_exp_rocket_aerial");
  level._effect["character_fire_pain_sm"] = LoadFX("env/fire/fx_fire_player_sm_1sec");
  level._effect["character_fire_death_sm"] = LoadFX("env/fire/fx_fire_player_md");
  level._effect["character_fire_death_torso"] = LoadFX("env/fire/fx_fire_player_torso");
  level._effect["trap_red"] = loadfx("maps/zombie/fx_zmbtron_elec_trap_light_red");
  level._effect["trap_green"] = loadfx("maps/zombie/fx_zmbtron_elec_trap_light_grn");
  level._effect["animscript_gib_fx"] = LoadFx("weapon/bullet/fx_flesh_gib_fatal_01");
  level._effect["animscript_gibtrail_fx"] = LoadFx("trail/fx_trail_blood_streak");
}
precache_createfx_fx() {
  level._effect["fx_rain_sys_heavy_windy_1"] = LoadFx("env/weather/fx_rain_sys_heavy_windy_1");
  level._effect["fx_fog_low"] = loadfx("env/smoke/fx_fog_low");
  level._effect["fx_fog_low_sm"] = loadfx("env/smoke/fx_fog_low_sm");
  level._effect["fx_water_wake_creek"] = loadfx("env/water/fx_water_wake_creek");
  level._effect["fx_water_wake_creek_mouth"] = loadfx("env/water/fx_water_wake_creek_mouth");
  level._effect["fx_water_wake_creek_mouth_froth"] = loadfx("env/water/fx_water_wake_creek_mouth_froth");
  level._effect["fx_water_splash_creek_rocks"] = loadfx("maps/creek/fx_water_splash_creek_rocks");
  level._effect["fx_water_splash_creek_rocks_sm"] = loadfx("maps/creek/fx_water_splash_creek_rocks_sm");
  level._effect["fx_water_fall_sm"] = loadfx("maps/creek/fx_water_fall_sm");
  level._effect["fx_water_fall_xsm"] = loadfx("maps/creek/fx_water_fall_xsm");
  level._effect["fx_pow_cave_water_fall"] = loadfx("maps/pow/fx_pow_cave_water_fall");
  level._effect["fx_light_incandescent"] = loadfx("env/light/fx_light_incandescent");
  level._effect["fx_light_kow_ray_street"] = LoadFx("maps/kowloon/fx_light_kow_ray_street");
  level._effect["fx_zombie_light_glow_green"] = loadfx("maps/zombie/fx_zombie_light_glow_green");
  level._effect["fx_search_light_tower"] = loadfx("env/light/fx_search_light_tower");
  level._effect["fx_ray_lampost_white"] = loadfx("env/light/fx_ray_lampost_white");
  level._effect["fx_light_fluorescent_tubes"] = loadfx("env/light/fx_light_fluorescent_tubes");
  level._effect["fx_zmbtron_god_ray_lrg"] = loadfx("maps/zombietron/fx_zmbtron_god_ray_lrg");
  level._effect["fx_smk_plume_xsm_blk"] = LoadFx("env/smoke/fx_smk_plume_xsm_blk");
  level._effect["fx_smk_smolder_rubble_md"] = LoadFx("env/smoke/fx_smk_smolder_rubble_md");
  level._effect["fx_smk_smolder_rubble_lg"] = LoadFx("env/smoke/fx_smk_smolder_rubble_lg");
  level._effect["fx_fire_ember_column_lg"] = loadfx("env/fire/fx_fire_ember_column_lg");
  level._effect["fx_ash_embers_light"] = loadfx("env/fire/fx_ash_embers_light");
  level._effect["fx_fire_column_creep_xsm"] = loadfx("env/fire/fx_fire_column_creep_xsm");
  level._effect["fx_fire_column_xsm_thin"] = loadfx("env/fire/fx_fire_column_xsm_thin");
  level._effect["fx_fire_line_xsm_thin"] = loadfx("env/fire/fx_fire_line_xsm_thin");
  level._effect["fx_fire_wall_back_sm"] = loadfx("env/fire/fx_fire_wall_back_sm");
  level._effect["fx_fire_md"] = loadfx("env/fire/fx_fire_md");
  level._effect["fx_elec_short_random"] = loadfx("env/electrical/fx_elec_short_random");
  level._effect["fx_snow_wall_avalanche"] = loadfx("env/weather/fx_snow_wall_avalanche");
}
trap_fx_monitor(name, id, trap_type) {
  while(1) {
    level waittill(id + "1");
    points = getstructarray(name, "targetname");
    for(i = 0; i < points.size; i++) {
      points[i] thread electric_trap_fx(name, id, trap_type);
    }
  }
}
electric_trap_fx(name, id, trap_type) {
  ang = self.angles;
  forward = anglesToForward(ang);
  up = anglestoup(ang);
  if(isDefined(self.loopFX)) {
    for(i = 0; i < self.loopFX.size; i++) {
      self.loopFX[i] delete();
    }
    self.loopFX = [];
  }
  if(!isDefined(self.loopFX)) {
    self.loopFX = [];
  }
  players = getlocalplayers();
  for(i = 0; i < players.size; i++) {
    switch (trap_type) {
      case "electric":
        self.loopFX[i] = SpawnFx(i, level._effect["zapper"], self.origin, 0, forward, up);
        break;
      default:
      case "fire":
        self.loopFX[i] = SpawnFx(i, level._effect["fire_trap_med"], self.origin, 0, forward, up);
        break;
    }
    triggerfx(self.loopFX[i]);
  }
  level waittill(id + "0");
  for(i = 0; i < self.loopFX.size; i++) {
    self.loopFX[i] delete();
  }
  self.loopFX = [];
}