/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_alien_armory_fx.gsc
******************************************/

main() {
  level._effect["spider_emerge_snow_puffs"] = loadfx("vfx/moments/alien/spider_emerge_snow_puffs");
  level._effect["spider_emerge_snow_burst"] = loadfx("vfx/moments/alien/spider_emerge_snow_burst");
  level._effect["blood_window_splat"] = loadfx("vfx/moments/alien/vfx_blood_hit_oriented_armory");
  level._effect["muzzleflash_01"] = loadfx("vfx/moments/alien/vfx_muz_pis_w_huge");
  level._effect["light_emergency_blinking_01"] = loadfx("vfx/moments/alien/vfx_light_emergency_100_blinker_rnnr");
  level._effect["muzzleflash_01_dlight"] = loadfx("vfx/moments/alien/vfx_muzzleflash_dlight");
  level._effect["snow_drift_down"] = loadfx("vfx/ambient/weather/snow/snow_drift_down");
  level._effect["snow_ground_oriented_drift_heavy"] = loadfx("vfx/moments/black_ice/snow_ground_oriented_drift_heavy");
  level._effect["snow_ground_oriented_drift_light"] = loadfx("vfx/ambient/weather/snow/snow_ground_oriented_drift_light");
  level._effect["snow_heavy_mp_alien_armory_nfg_1000"] = loadfx("fx/maps/mp_alien_armory/snow_heavy_mp_alien_armory_nfg_1000");
  level._effect["alien_arm_hive_steam_yellow"] = loadfx("vfx/ambient/alien/vfx_alien_arm_hive_steam_yellow");
  level._effect["alien_arm_snow_ground_gale_1"] = loadfx("vfx/moments/alien/vfx_alien_arm_snow_ground_gale_1");
  level._effect["alien_arm_snow_ground_gale_2"] = loadfx("vfx/moments/alien/vfx_alien_arm_snow_ground_gale_2");
  level._effect["alien_arm_snow_ground_gale_3"] = loadfx("vfx/moments/alien/vfx_alien_arm_snow_ground_gale_3");
  level._effect["alien_arm_intro_fall_dust"] = loadfx("vfx/moments/alien/vfx_alien_arm_intro_fall_dust");
  level._effect["alien_arm_intro_falling_snow"] = loadfx("vfx/moments/alien/vfx_alien_arm_intro_falling_snow");
  level._effect["alien_arm_intro_falling_snow_2"] = loadfx("vfx/moments/alien/vfx_alien_arm_intro_falling_snow_2");
  level._effect["alien_arm_intro_stab_blood_runner"] = loadfx("vfx/moments/alien/vfx_alien_arm_intro_stab_blood_rnnr");
  level._effect["alien_arm_intro_tun_snow"] = loadfx("vfx/moments/alien/vfx_alien_arm_intro_tun_snow");
  level._effect["alien_snow_ground_gale"] = loadfx("vfx/ambient/weather/snow/vfx_alien_snow_ground_gale");
  level._effect["alien_snow_ground_heavy"] = loadfx("vfx/ambient/weather/snow/vfx_alien_snow_ground_heavy");
  level._effect["alien_snow_ground_light"] = loadfx("vfx/ambient/weather/snow/vfx_alien_snow_ground_light");
  level._effect["alien_snow_roof_gale"] = loadfx("vfx/ambient/weather/snow/vfx_alien_snow_roof_gale");
  level._effect["alien_snow_roof_heavy"] = loadfx("vfx/ambient/weather/snow/vfx_alien_snow_roof_heavy");
  level._effect["dust_motes_int_snow"] = loadfx("vfx/ambient/dust/vfx_dust_motes_int_snow");
  level._effect["godray_spread_200_warm"] = loadfx("vfx/ambient/lights/godray_spread_200_warm");
  level._effect["red_light_100_soft_blinker_oriented"] = loadfx("vfx/ambient/lights/red_light_100_soft_blinker_oriented");
  level._effect["skyanim_snowysky"] = loadfx("vfx/clouds/vfx_skyanim_alien_armory");
  level._effect["white_light_120_rect_mist"] = loadfx("vfx/ambient/lights/white_light_120_rect_mist");
  level._effect["white_light_60_mist"] = loadfx("vfx/ambient/lights/white_light_60_mist");
  level._effect["spider_impact_snow_big"] = loadfx("vfx/moments/alien/vfx_alien_spider_big_impact_snow");
  level._effect["monitor_black_flicker_01"] = loadfx("vfx/moments/alien/vfx_black_mon_overlay_flicker_01");
  level._effect["monitor_black_flicker_02"] = loadfx("vfx/moments/alien/vfx_black_mon_overlay_flicker_02");
  level._effect["alien_arm_boss2_impact_dust"] = loadfx("vfx/moments/alien/vfx_alien_arm_boss2_impact_dust");
  level._effect["alien_arm_boss2_rail_dust"] = loadfx("vfx/moments/alien/vfx_alien_arm_boss2_rail_dust");
  level._effect["alien_propane_tank_explosion_snow"] = loadfx("vfx/gameplay/alien/vfx_alien_propane_tank_explosion_snow");
  level._effect["electrical_sparks_nocol_3mit"] = loadfx("vfx/ambient/sparks/electrical_sparks_nocol_runner_3mit");
  level._effect["transformer_exp_snow"] = loadfx("vfx/gameplay/explosions/vfx_transformer_exp_snow");
  level._effect["light_amber_small_01"] = loadfx("vfx/ambient/lights/amber_light_45_flare_100");
  level._effect["light_white_cone_01"] = loadfx("vfx/ambient/lights/white_light_cone_300");
  level._effect["light_white_cone_02"] = loadfx("vfx/ambient/lights/white_light_cone_301");
  level._effect["alien_cloaking"] = loadfx("vfx/gameplay/alien/vfx_alien_tele_trail_01");
  level._effect["alien_uncloaking"] = loadfx("vfx/gameplay/alien/vfx_alien_tele_trail_02");
  level._effect["spitter_ammo"] = loadfx("vfx/_requests/mp_alien_armory/spitter_ammo");
  level._effect["challenge_ring"] = loadfx("vfx/gameplay/alien/vfx_alien_chopper_escape_ring");
  level._effect["alien_ark_gib"] = loadfx("vfx/gameplay/alien/vfx_alien_ark_gib_01");
}

fx_intro_tunnel_stab() {
  common_scripts\utility::exploder(100);
  wait 13.2;
  common_scripts\utility::exploder(125);
  wait 2.4;
  playFXOnTag(level._effect["alien_arm_intro_stab_blood_runner"], self, "j_wrist_r");
  wait 2.6;
  common_scripts\utility::exploder(110);
}

fx_spider_entrance_b() {
  wait 6.3;
  common_scripts\utility::exploder(221);
  wait 0.2;
  common_scripts\utility::exploder(220);
  wait 0.3;
  wait 0.1;
  common_scripts\utility::exploder(223);
  wait 0.1;
  common_scripts\utility::exploder(222);
  wait 0.4;
  wait 0.3;
  wait 0.6;
}

fx_spider_exit_b() {
  wait 4.2;
  common_scripts\utility::exploder(222);
  var_0 = getscriptablearray("armory_alien_rail_b", "targetname");
  var_0[0] setscriptablepartstate(0, 3);
  wait 0.6;
  common_scripts\utility::exploder(240);
  var_1 = getscriptablearray("spider_retreat_b_tank", "targetname");

  if(isDefined(var_1[0]))
    var_1[0] setscriptablepartstate(0, 2);
}

fx_cross_lab_light_on() {
  var_0 = getent("lab_light_01", "targetname");
  var_0 setscriptablepartstate("armory_light", "light_on");
}

fx_cross_lab_light_off() {
  var_0 = getent("lab_light_01", "targetname");
  var_0 setscriptablepartstate("armory_light", "light_off");
}

fx_cross_lab_light_flicker() {
  wait 11.0;
  var_0 = getent("lab_light_01", "targetname");
  var_0 setscriptablepartstate("armory_light", "light_flicker");
  common_scripts\utility::exploder(55);
  wait 1;
  common_scripts\utility::exploder(56);
  wait 1;
  common_scripts\utility::exploder(57);
}

fx_archer_shoots() {
  thread fx_cross_lab_light_on();
  playFXOnTag(level._effect["muzzleflash_01"], self, "tag_flash");
  playFXOnTag(level._effect["muzzleflash_01_dlight"], self, "tag_flash");
  common_scripts\utility::exploder(51);
  wait 10.8;
  thread maps\mp\mp_alien_armory_vignettes::lab_alarm1();
  common_scripts\utility::exploder(52);
  thread fx_cross_lab_light_off();
  wait 0.3;
  common_scripts\utility::exploder(53);
}

fx_spider_impact_big() {
  level.spider maps\mp\alien\_utility::set_alien_emissive(1.2, 1.0);
  wait 1;
  level.spider setscriptablepartstate("body", "vulnerable");
  wait 0.1;
  level.spider setscriptablepartstate("body", "normal");
  wait 6.15;
  playFXOnTag(level._effect["spider_impact_snow_big"], level.spider, "tag_belly_end_f");
}

fx_snow_watcher() {
  level thread fx_snow_watcher_medium();
  level thread fx_snow_watcher_heavy();
}

fx_snow_watcher_medium() {
  level endon("game_ended");
  level endon("final_spider_fight");
  var_0 = getent("fxt_medium_snow", "targetname");
  var_0 waittill("trigger");
  fx_snow("medium_snow");
}

fx_snow_watcher_heavy() {
  level endon("game_ended");
  var_0 = getent("fxt_heavy_snow", "targetname");
  var_0 waittill("trigger");
  fx_set_spider_fog_3();
  fx_snow("heavy_snow_no_fog");
}

fx_snow(var_0) {
  while(!isDefined(level.snow)) {
    wait 0.2;
    level.snow = getent("scriptable_snow", "targetname");
  }

  level.snow setscriptablepartstate("alien_armory_snow", var_0);
}

fx_set_spider_fog(var_0) {
  if(!isDefined(level.spider_fog_setting)) {
    return;
  }
  var_1 = level.spider_fog_setting;
  self playersetexpfog(var_1.startdist, var_1.halfwaydist, var_1.red, var_1.green, var_1.blue, var_1.hdrcolorintensity, var_1.maxopacity, var_0, var_1.sunred, var_1.sungreen, var_1.sunblue, var_1.hdrsuncolorintensity, var_1.sundir, var_1.sunbeginfadeangle, var_1.sunendfadeangle, var_1.normalfogscale, var_1.skyfogintensity, var_1.skyfogminangle, var_1.skyfogmaxangle);
}

fx_set_spider_fog_1() {
  var_0 = spawnStruct();

  if(maps\mp\_utility::is_gen4()) {
    var_0.startdist = 10;
    var_0.halfwaydist = 800;
    var_0.red = 0.5;
    var_0.green = 0.56;
    var_0.blue = 0.605;
    var_0.maxopacity = 0.88;
    var_0.transitiontime = 0;
    var_0.hdrcolorintensity = 1.75;
    var_0.sunfogenabled = 1;
    var_0.sunred = 0.476;
    var_0.sungreen = 0.52;
    var_0.sunblue = 0.607;
    var_0.sundir = (-35, -111, 0);
    var_0.sunbeginfadeangle = 20;
    var_0.sunendfadeangle = 120;
    var_0.normalfogscale = 0.9;
    var_0.hdrsuncolorintensity = 1;
    var_0.skyfogintensity = 0.88;
    var_0.skyfogminangle = -90;
    var_0.skyfogmaxangle = -54.73;
  } else {
    var_0.startdist = 10;
    var_0.halfwaydist = 800;
    var_0.red = 0.44;
    var_0.green = 0.48;
    var_0.blue = 0.56;
    var_0.maxopacity = 0.9;
    var_0.transitiontime = 3;
    var_0.sunfogenabled = 1;
    var_0.sunred = 0.348;
    var_0.sungreen = 0.38;
    var_0.sunblue = 0.443;
    var_0.sundir = (-35, -111, 0);
    var_0.sunbeginfadeangle = 0;
    var_0.sunendfadeangle = 79;
    var_0.normalfogscale = 0.33;
    var_0.skyfogintensity = 1;
    var_0.skyfogminangle = -90;
    var_0.skyfogmaxangle = -54.73;
  }

  level.spider_fog_setting = var_0;

  foreach(var_2 in level.players)
  var_2 fx_set_spider_fog(3);
}

fx_set_spider_fog_3() {
  var_0 = spawnStruct();

  if(maps\mp\_utility::is_gen4()) {
    var_0.startdist = 10;
    var_0.halfwaydist = 1000;
    var_0.red = 0.5;
    var_0.green = 0.56;
    var_0.blue = 0.605;
    var_0.maxopacity = 0.88;
    var_0.transitiontime = 0;
    var_0.hdrcolorintensity = 1.75;
    var_0.sunfogenabled = 1;
    var_0.sunred = 0.476;
    var_0.sungreen = 0.52;
    var_0.sunblue = 0.607;
    var_0.sundir = (-35, -111, 0);
    var_0.sunbeginfadeangle = 20;
    var_0.sunendfadeangle = 120;
    var_0.normalfogscale = 0.9;
    var_0.hdrsuncolorintensity = 1;
    var_0.skyfogintensity = 0.88;
    var_0.skyfogminangle = -90;
    var_0.skyfogmaxangle = -54.73;
  } else {
    var_0.startdist = 10;
    var_0.halfwaydist = 1000;
    var_0.red = 0.44;
    var_0.green = 0.48;
    var_0.blue = 0.56;
    var_0.maxopacity = 0.9;
    var_0.transitiontime = 3;
    var_0.sunfogenabled = 1;
    var_0.sunred = 0.348;
    var_0.sungreen = 0.38;
    var_0.sunblue = 0.443;
    var_0.sundir = (-35, -111, 0);
    var_0.sunbeginfadeangle = 0;
    var_0.sunendfadeangle = 79;
    var_0.normalfogscale = 0.33;
    var_0.skyfogintensity = 1;
    var_0.skyfogminangle = -90;
    var_0.skyfogmaxangle = -54.73;
  }

  level.spider_fog_setting = var_0;

  foreach(var_2 in level.players)
  var_2 fx_set_spider_fog(6);
}