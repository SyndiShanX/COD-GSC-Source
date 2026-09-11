/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sv_backlot\cp_sv_backlot_fx.gsc
**************************************************************/

function main() {
  level._effect["vfx_bl_bulb_light_flare"] = loadfx("vfx/iw8_mp/level/backlot/vfx_bl_bulb_light_flare.vfx");
  level._effect["vfx_bl_fluorescent_lf"] = loadfx("vfx/iw8_mp/level/backlot/vfx_bl_fluorescent_lf.vfx");
  level._effect["vfx_crash_fire_tiny"] = loadfx("vfx/iw8_mp/level/crash/vfx_crash_fire_tiny.vfx");
  level._effect["vfx_crash_fire_sml"] = loadfx("vfx/iw8_mp/level/crash/vfx_crash_fire_sml.vfx");
  level._effect["vfx_bl_fire_crawl_line_wide"] = loadfx("vfx/iw8_mp/level/backlot/vfx_bl_fire_crawl_line_wide.vfx");
  level._effect["vfx_bl_ceiling_fire_flat"] = loadfx("vfx/iw8_mp/level/backlot/vfx_bl_ceiling_fire_flat.vfx");
  level._effect["vfx_bl_vindia_fire"] = loadfx("vfx/iw8_mp/level/backlot/vfx_bl_vindia_fire.vfx");
  level._effect["vfx_bl_chimney_smoke_1"] = loadfx("vfx/iw8_mp/level/backlot/vfx_bl_chimney_smoke_1.vfx");
  level._effect["vfx_bl_dust_move_slow"] = loadfx("vfx/iw8_mp/level/backlot/vfx_bl_dust_move_slow.vfx");
  level._effect["vfx_bl_ceiling_fire_drip"] = loadfx("vfx/iw8_mp/level/backlot/vfx_bl_ceiling_fire_drip.vfx");
  level._effect["vfx_bl_white_smoke"] = loadfx("vfx/iw8_mp/level/backlot/vfx_bl_white_smoke.vfx");
  level._effect["vfx_bl_fire_big_bg"] = loadfx("vfx/iw8_mp/level/backlot/vfx_bl_fire_big_bg.vfx");
  level._effect["vfx_bl_constant_motes"] = loadfx("vfx/iw8_mp/level/backlot/vfx_bl_constant_motes.vfx");
  level._effect["vfx_ani_sunflare"] = loadfx("vfx/iw8_mp/level/aniyah/vfx_ani_sunflare.vfx");
  level._effect["vfx_swirling_dust"] = loadfx("vfx/iw8_mp/level/faridah/vfx_swirling_dust.vfx");
  level._effect["vfx_blowing_sand_low"] = loadfx("vfx/iw8_mp/level/faridah/vfx_blowing_sand_low.vfx");
  level._effect["vfx_ani_town_fog"] = loadfx("vfx/iw8_mp/level/aniyah/vfx_ani_town_fog.vfx");
  level._effect["vfx_ani_sparks_1"] = loadfx("vfx/iw8_mp/level/aniyah/vfx_ani_sparks_1.vfx");
  level._effect["vfx_ani_leaves_falling"] = loadfx("vfx/iw8_mp/level/aniyah/vfx_ani_leaves_falling.vfx");
  level._effect["vfx_ani_mist_ground_01"] = loadfx("vfx/iw8_mp/level/aniyah/vfx_ani_mist_ground_01.vfx");
  level._effect["vfx_ani_billow_mist_1"] = loadfx("vfx/iw8_mp/level/aniyah/vfx_ani_billow_mist_1.vfx");
  level._effect["vfx_ani_sand_flat"] = loadfx("vfx/iw8_mp/level/aniyah/vfx_ani_sand_flat.vfx");
  level._effect["vfx_ani_gd_steam_a"] = loadfx("vfx/iw8_mp/level/aniyah/vfx_ani_gd_steam_a.vfx");
  level._effect["vfx_ani_falling_dust_ceiling"] = loadfx("vfx/iw8_mp/level/aniyah/vfx_ani_falling_dust_ceiling.vfx");
  level._effect["vfx_ani_indoor_motes"] = loadfx("vfx/iw8_mp/level/aniyah/vfx_ani_indoor_motes.vfx");
  level._effect["vfx_butterflies"] = loadfx("vfx/iw8_mp/gen_amb/vfx_butterflies.vfx");
  level._effect["vfx_bee_swarm"] = loadfx("vfx/iw8_mp/gen_amb/vfx_bee_swarm.vfx");
  level._effect["vfx_birds_sparrows_circling"] = loadfx("vfx/iw8_mp/gen_amb/vfx_birds_sparrows_circling.vfx");
  level._effect["vfx_gnat_swarm_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_gnat_swarm_1.vfx");
  level._effect["vfx_car_fire_linger_2"] = loadfx("vfx/iw8_mp/gen_amb/vfx_car_fire_linger_2.vfx");
  level._effect["vfx_dust_motes_med"] = loadfx("vfx/iw8_mp/gen_amb/vfx_dust_motes_med.vfx");
  level._effect["vfx_birds_circling"] = loadfx("vfx/iw8_mp/gen_amb/vfx_birds_circling.vfx");
  level._effect["vfx_dragonflies"] = loadfx("vfx/iw8_mp/gen_amb/vfx_dragonflies.vfx");
  level._effect["vfx_trash_drift_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_trash_drift_1.vfx");
  level._effect["vfx_trash_circle_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_trash_circle_1.vfx");
  level._effect["vfx_mosquitos_over_water_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_mosquitos_over_water_1.vfx");
  level._effect["vfx_moths_2"] = loadfx("vfx/iw8_mp/gen_amb/vfx_moths_2.vfx");
  level._effect["vfx_moths_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_moths_1.vfx");
  level._effect["vfx_gnat_swarm_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_gnat_swarm_1.vfx");
  level._effect["vfx_fire_tiny"] = loadfx("vfx/iw8_mp/gen_amb/vfx_fire_tiny.vfx");
  level._effect["vfx_fire_sml"] = loadfx("vfx/iw8_mp/gen_amb/vfx_fire_sml.vfx");
  level._effect["vfx_rat_p2p"] = loadfx("vfx/iw8_mp/gen_amb/vfx_rat_p2p.vfx");
  level._effect["vfx_birds_sparrow_burst_01"] = loadfx("vfx/iw8_mp/gen_amb/vfx_birds_sparrow_burst_01.vfx");
}