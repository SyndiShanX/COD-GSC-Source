/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_16ea79836916888c.gsc
*************************************************/

#using script_5e60754c97311cd;
#using scripts\common\exploder;
#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace namespace_2406d9351f9f8dcd;

function main() {
  level._effect["vfx_apt_water_drips_line_01"] = loadfx("vfx/jup/level/cp_jup_apartment/vfx_apt_water_drips_line_01.vfx");
  level._effect["vfx_apt_drippingwater_medium_anim_01"] = loadfx("vfx/jup/level/cp_jup_apartment/vfx_apt_drippingwater_medium_anim_01.vfx");
  level._effect["vfx_apt_rain_cam_rooftop"] = loadfx("vfx/jup/level/cp_jup_apartment/vfx_apt_rain_cam_rooftop.vfx");
  level._effect["vfx_apt_blood_decal_price_shot"] = loadfx("vfx/jup/level/cp_jup_apartment/vfx_apt_blood_decal_price_shot.vfx");
  level._effect["vfx_apt_price_shot_light_flash"] = loadfx("vfx/jup/level/cp_jup_apartment/vfx_apt_price_shot_light_flash.vfx");
  level._effect["vfx_apt_blood_spurt_price_shot"] = loadfx("vfx/jup/level/cp_jup_apartment/vfx_apt_blood_spurt_price_shot.vfx");
  level._effect["vfx_explo_rpg"] = loadfx("vfx/iw9/core/explosions/vfx_explo_rpg.vfx");
  level._effect["vfx_apt_intro_splash_screen"] = loadfx("vfx/jup/level/cp_jup_apartment/vfx_apt_intro_splash_screen.vfx");
  level._effect["vfx_apt_water_drips_shipping_crate_02"] = loadfx("vfx/jup/level/cp_jup_apartment/vfx_apt_water_drips_shipping_crate_02.vfx");
  level._effect["vfx_apt_water_drips_shipping_crate"] = loadfx("vfx/jup/level/cp_jup_apartment/vfx_apt_water_drips_shipping_crate.vfx");
  level._effect["vfx_apt_water_drips_shipping_crate_01"] = loadfx("vfx/jup/level/cp_jup_apartment/vfx_apt_water_drips_shipping_crate_01.vfx");
  level._effect["vfx_apt_birds_flying_away_flock"] = loadfx("vfx/jup/level/cp_jup_apartment/vfx_apt_birds_flying_away_flock.vfx");
  level._effect["vfx_apt_broken_window_glass_falling"] = loadfx("vfx/jup/level/cp_jup_apartment/vfx_apt_broken_window_glass_falling.vfx");
  level._effect["vfx_apt_glow_red_01"] = loadfx("vfx/jup/level/cp_jup_apartment/vfx_apt_glow_red_01.vfx");
  level._effect["vfx_flashlight_npc_perf"] = loadfx("vfx/jup/lighting/vfx_flashlight_npc_perf.vfx");
  level._effect["vfx_flashlight_npc_perf_dim"] = loadfx("vfx/jup/lighting/vfx_flashlight_npc_perf_dim.vfx");
  level._effect["vfx_apt_flare_gun"] = loadfx("vfx/jup/level/cp_jup_apt/vfx_apt_flare_gun.vfx");
  level._effect["npc_flashlight"] = loadfx("vfx/iw9/core/flashlight/vfx_flashlight_npc_nolight.vfx");
  level._effect["apt_npc_flashlight"] = loadfx("vfx/jup/level/cp_jup_apt/vfx_flashlight_npc.vfx");
  level._effect["smokey_room"] = loadfx("vfx/jup/level/cp_jup_apt/vfx_smokey_room.vfx");
  thread function_b9e130d444d299c9("basement_exploder", "basement_zone");
  thread function_b9e130d444d299c9("floor_01_exploder", "floor_01_zone");
  thread function_b9e130d444d299c9("floor_02_exploder", "floor_02_zone");
  thread function_b9e130d444d299c9("building_02_exploder", "building_02_zone");
  thread function_b9e130d444d299c9("floor_03_exploder", "floor_03_zone");
  thread function_b9e130d444d299c9("rooftop_exploder", "rooftop_zone");
  thread function_b9e130d444d299c9("courtyard_exploder", "courtyard_zone");
  thread function_b9e130d444d299c9("crane_cloth_def", "rooftop_mayhem_zone");
  load_vfx();

  if(getDvar(@ "clientsideeffects") != "<dev string:x1c>") {}

  thread trigger_flag();
  thread birds_flock();
}

function load_vfx() {
  level._effect["combat_vfx_particulates"] = loadfx("vfx/jup/level/cp_jup_apartment/vfx_apt_combat_particulates_stage1.vfx");
  level._effect["combat_vfx_particulates"] = loadfx("vfx/jup/level/cp_jup_apartment/vfx_apt_combat_particulates_stage2.vfx");
  level._effect["combat_vfx_particulates"] = loadfx("vfx/jup/level/cp_jup_apartment/vfx_apt_combat_particulates_stage3.vfx");
  level._effect["combat_vfx_particulates"] = loadfx("vfx/jup/level/cp_jup_apartment/vfx_apt_combat_vfx_stage1.vfx");
  level._effect["combat_vfx_particulates"] = loadfx("vfx/jup/level/cp_jup_apartment/vfx_apt_combat_vfx_stage2.vfx");
  level._effect["combat_vfx_particulates"] = loadfx("vfx/jup/level/cp_jup_apartment/vfx_apt_combat_vfx_stage2_ceiling.vfx");
  level._effect["combat_vfx_particulates"] = loadfx("vfx/jup/level/cp_jup_apartment/vfx_apt_combat_vfx_stage3.vfx");
}

function trigger_flag() {
  wait 1;
  flag_wait("glass");
  exploder("glass");
}

function birds_flock() {
  wait 1;
  flag_wait("birds_flock");
  exploder("birds_flock");
}

function function_4b3dd7591cd996c6() {
  wait 9;
  exploder("crane_cloth_detach");
}

function function_e5c064a85a2d7cd1() {
  wait 9;
  stop_exploder("crane_cloth_def");
}

function function_994fff22d37ba53d(fx, pos, trigger_dist, var_f6b832edb7626d84) {
  flag_wait("level_ready_for_script");
  flag_wait("player_spawned_with_loadout");
  wait 1;

  iprintlnbold("<dev string:x1e>");

  origin = level.player getEye();
  angles = level.player getgunangles();
  infov = within_fov(origin, angles, pos, cos(var_f6b832edb7626d84));
  dist = distance(origin, pos);

  while(!infov || dist > trigger_dist) {
    origin = level.player getEye();
    angles = level.player getgunangles();
    infov = within_fov(origin, angles, pos, cos(var_f6b832edb7626d84));
    dist = distance(origin, pos);

    debugstar(pos);

    waitframe();
  }

  exploder(fx);
}

function function_2e86b24381537aed() {
  wait 0.1;
  level thread function_994fff22d37ba53d("eyetrigger", (1785, 1871, 1100), 100, 60);

  iprintlnbold("<dev string:x30>");
}