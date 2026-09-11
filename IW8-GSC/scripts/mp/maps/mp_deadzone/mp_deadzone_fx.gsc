/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_deadzone\mp_deadzone_fx.gsc
**********************************************************/

function main() {
  level._effect["vfx_dzone_mountain_fog"] = loadfx("vfx/iw8_mp/level/deadzone/vfx_dzone_mountain_fog.vfx");
  level._effect["vfx_emp_secondary_omni"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_secondary_omni.vfx");
  level._effect["vfx_emp_secondary_posx"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_secondary_posx.vfx");
  level._effect["vfx_dzone_vector"] = loadfx("vfx/iw8_mp/level/deadzone/vfx_dzone_vector.vfx");
  level._effect["vfx_fire_sml"] = loadfx("vfx/iw8_mp/gen_amb/vfx_fire_sml.vfx");
  level._effect["vfx_dzone_spark_a"] = loadfx("vfx/iw8_mp/level/deadzone/vfx_dzone_spark_a.vfx");
  level._effect["vfx_dzone_machine_error_code"] = loadfx("vfx/iw8_mp/level/deadzone/vfx_dzone_machine_error_code.vfx");
  level._effect["vfx_dzone_electrical_sparks"] = loadfx("vfx/iw8_mp/level/deadzone/vfx_dzone_electrical_sparks.vfx");
  level._effect["vfx_dzone_drip_water"] = loadfx("vfx/iw8_mp/level/deadzone/vfx_dzone_drip_water.vfx");
  level._effect["vfx_dzone_chimney_smoke_3"] = loadfx("vfx/iw8_mp/level/deadzone/vfx_dzone_chimney_smoke_3.vfx");
  level._effect["vfx_dzone_chimney_smoke_2"] = loadfx("vfx/iw8_mp/level/deadzone/vfx_dzone_chimney_smoke_2.vfx");
  level._effect["vfx_dzone_lake_fog"] = loadfx("vfx/iw8_mp/level/deadzone/vfx_dzone_lake_fog.vfx");
  level._effect["vfx_dzone_falling_dust_house"] = loadfx("vfx/iw8_mp/level/deadzone/vfx_dzone_falling_dust_house.vfx");
  level._effect["vfx_dzone_stove_heat"] = loadfx("vfx/iw8_mp/level/deadzone/vfx_dzone_stove_heat.vfx");
  level._effect["vfx_dzone_tea_steam"] = loadfx("vfx/iw8_mp/level/deadzone/vfx_dzone_tea_steam.vfx");
  level._effect["vfx_dzone_fireplace_fire"] = loadfx("vfx/iw8_mp/level/deadzone/vfx_dzone_fireplace_fire.vfx");
  level._effect["vfx_candle_flame"] = loadfx("vfx/iw8/level/townhouse/vfx_candle_flame.vfx");
  level._effect["vfx_dzone_incandescent_lf"] = loadfx("vfx/iw8_mp/level/deadzone/vfx_dzone_incandescent_lf.vfx");
  level._effect["vfx_dzone_fluorescent_lf"] = loadfx("vfx/iw8_mp/level/deadzone/vfx_dzone_fluorescent_lf.vfx");
  level._effect["vfx_dzone_light_snow"] = loadfx("vfx/iw8_mp/level/deadzone/vfx_dzone_light_snow.vfx");
  level._effect["vfx_dzone_maggots"] = loadfx("vfx/iw8_mp/level/deadzone/vfx_dzone_maggots.vfx");
  level._effect["vfx_dzone_steaming_haystack"] = loadfx("vfx/iw8_mp/level/deadzone/vfx_dzone_steaming_haystack.vfx");
  level._effect["vfx_dzone_blowing_haystack"] = loadfx("vfx/iw8_mp/level/deadzone/vfx_dzone_blowing_haystack.vfx");
  level._effect["vfx_dragonflies"] = loadfx("vfx/iw8_mp/gen_amb/vfx_dragonflies.vfx");
  level._effect["vfx_chimney_smoke_3"] = loadfx("vfx/iw8_mp/level/faridah/vfx_chimney_smoke_3.vfx");
  level._effect["vfx_chimney_smoke_2"] = loadfx("vfx/iw8_mp/level/faridah/vfx_chimney_smoke_2.vfx");
  level._effect["vfx_electrical_sparks_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_electrical_sparks_1.vfx");
  level._effect["vfx_blowing_snow_ledge"] = loadfx("vfx/iw8/level/lab/vfx_blowing_snow_ledge.vfx");
  level._effect["vfx_lab_blowing_mist_light_1"] = loadfx("vfx/iw8/level/lab/vfx_lab_blowing_mist_light_1.vfx");
  level._effect["vfx_billow_mist_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_billow_mist_1.vfx");
  level._effect["vfx_dzone_tower_birds"] = loadfx("vfx/iw8_mp/level/deadzone/vfx_dzone_tower_birds.vfx");
  level._effect["vfx_dzone_town_fog"] = loadfx("vfx/iw8_mp/level/deadzone/vfx_dzone_town_fog.vfx");
  level._effect["vfx_gnat_swarm_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_gnat_swarm_1.vfx");
  level._effect["vfx_trash_flies"] = loadfx("vfx/iw8_mp/gen_amb/vfx_trash_flies.vfx");
  level._effect["vfx_falling_dust_ceiling"] = loadfx("vfx/iw8_mp/gen_amb/vfx_falling_dust_ceiling.vfx");
  level._effect["vfx_dust_motes_med"] = loadfx("vfx/iw8_mp/gen_amb/vfx_dust_motes_med.vfx");
  level._effect["vfx_ph_hill_drk_smoke_01"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_hill_drk_smoke_01.vfx");
  level._effect["vfx_knee_high_fog_bright"] = loadfx("vfx/iw7/core/zombie/environment/vfx_knee_high_fog_bright.vfx");
  level._effect["vfx_zmb_grd_fog_bri"] = loadfx("vfx/iw7/_requests/coop/vfx_zmb_grd_fog_bri.vfx");
  level._effect["vfx_safehouse_dust_pocket_sm"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_dust_pocket_sm.vfx");
  level._effect["vfx_dust_trickle"] = loadfx("vfx/iw8_mp/level/faridah/vfx_dust_trickle.vfx");
  level._effect["vfx_safehouse_low_slow_dust"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_low_slow_dust.vfx");
  level._effect["vfx_dzone_sunflare"] = loadfx("vfx/iw8_mp/level/deadzone/vfx_dzone_sunflare.vfx");
}