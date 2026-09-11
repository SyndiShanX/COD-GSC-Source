/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_cave_am\mp_cave_am_fx.gsc
********************************************************/

function main() {
  level._effect["vfx_caveam_headlight_lensflare"] = loadfx("vfx/iw8_mp/level/cave/am/vfx_caveam_headlight_lensflare.vfx");
  level._effect["vfx_caveam_dust_motes_med"] = loadfx("vfx/iw8_mp/level/cave/am/vfx_caveam_dust_motes_med.vfx");
  level._effect["vfx_cave_smoke_hole_ceiling"] = loadfx("vfx/iw8_mp/level/cave/vfx_cave_smoke_hole_ceiling.vfx");
  level._effect["vfx_caveam_sand_blow_low"] = loadfx("vfx/iw8_mp/level/cave/am/vfx_caveam_sand_blow_low.vfx");
  level._effect["vfx_caveam_bulb_light_flare"] = loadfx("vfx/iw8_mp/level/cave/am/vfx_caveam_bulb_light_flare.vfx");
  level._effect["vfx_caveam_lantern_lensflare"] = loadfx("vfx/iw8_mp/level/cave/am/vfx_caveam_lantern_lensflare.vfx");
  level._effect["vfx_caveam_flood_light_flare"] = loadfx("vfx/iw8_mp/level/cave/am/vfx_caveam_flood_light_flare.vfx");
  level._effect["vfx_emp_secondary_omni"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_secondary_omni.vfx");
  level._effect["vfx_emp_secondary_posx"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_secondary_posx.vfx");
  level._effect["vfx_cave_smoke_2"] = loadfx("vfx/iw8_mp/level/cave/am/vfx_cave_smoke_2.vfx");
  level._effect["vfx_cave_smoke_2_ch"] = loadfx("vfx/iw8_mp/level/cave/am/vfx_cave_smoke_2_ch.vfx");
  level._effect["vfx_cave_smoke_1"] = loadfx("vfx/iw8_mp/level/cave/vfx_cave_smoke_1.vfx");
  level._effect["vfx_caveam_sunflare"] = loadfx("vfx/iw8_mp/level/cave/am/vfx_caveam_sunflare.vfx");
  level._effect["vfx_cave_headlight_lensflare"] = loadfx("vfx/iw8_mp/level/cave/vfx_cave_headlight_lensflare.vfx");
  level._effect["vfx_caveam_distant_fog"] = loadfx("vfx/iw8_mp/level/cave/am/vfx_caveam_distant_fog.vfx");
  level._effect["vfx_blowing_sandgrass_pile"] = loadfx("vfx/iw8_mp/level/faridah/vfx_blowing_sandgrass_pile.vfx");
  level._effect["vfx_swirling_dust"] = loadfx("vfx/iw8_mp/level/faridah/vfx_swirling_dust.vfx");
  level._effect["vfx_leaves_falling_olive"] = loadfx("vfx/iw8_mp/gen_amb/vfx_leaves_falling_olive.vfx");
  level._effect["vfx_blowing_sand_low"] = loadfx("vfx/iw8_mp/level/faridah/vfx_blowing_sand_low.vfx");
  level._effect["vfx_cave_lingering_smoke"] = loadfx("vfx/iw8_mp/level/cave/am/vfx_cave_lingering_smoke.vfx");
  level._effect["vfx_cave_drone_smoke_2"] = loadfx("vfx/iw8_mp/level/cave/am/vfx_cave_drone_smoke_2.vfx");
  level._effect["vfx_cave_drone_smoke_1"] = loadfx("vfx/iw8_mp/level/cave/am/vfx_cave_drone_smoke_1.vfx");
  level._effect["vfx_emp_secondary_posx"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_secondary_posx.vfx");
  level._effect["vfx_emp_secondary_omni"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_secondary_omni.vfx");
  level._effect["vfx_cave_gd_steam_b"] = loadfx("vfx/iw8_mp/level/cave/vfx_cave_gd_steam_b.vfx");
  level._effect["vfx_cave_gd_steam_a"] = loadfx("vfx/iw8_mp/level/cave/vfx_cave_gd_steam_a.vfx");
  level._effect["vfx_cave_falling_dust_ceiling"] = loadfx("vfx/iw8_mp/level/cave/vfx_cave_falling_dust_ceiling.vfx");
  level._effect["vfx_cave_water_pour_sm"] = loadfx("vfx/iw8_mp/level/cave/vfx_cave_water_pour_sm.vfx");
  level._effect["vfx_cave_fireplace_fire"] = loadfx("vfx/iw8_mp/level/cave/vfx_cave_fireplace_fire.vfx");
  level._effect["vfx_cave_moth_a"] = loadfx("vfx/iw8_mp/level/cave/vfx_cave_moth_a.vfx");
  level._effect["vfx_cave_chimney_smoke_1"] = loadfx("vfx/iw8_mp/level/cave/vfx_cave_chimney_smoke_1.vfx");
  level._effect["vfx_cave_chimney_smoke_2"] = loadfx("vfx/iw8_mp/level/cave/vfx_cave_chimney_smoke_2.vfx");
  level._effect["vfx_cave_constant_motes"] = loadfx("vfx/iw8_mp/level/cave/vfx_cave_constant_motes.vfx");
  level._effect["vfx_dust_motes_med"] = loadfx("vfx/iw8_mp/gen_amb/vfx_dust_motes_med.vfx");
  level._effect["vfx_cave_dust_pocket_sm"] = loadfx("vfx/iw8_mp/level/cave/vfx_cave_dust_pocket_sm.vfx");
  level._effect["vfx_moths"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_moths.vfx");
  level._effect["vfx_gnat_swarm_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_gnat_swarm_1.vfx");
}