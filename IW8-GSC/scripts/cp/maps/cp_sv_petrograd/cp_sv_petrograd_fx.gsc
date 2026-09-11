/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sv_petrograd\cp_sv_petrograd_fx.gsc
******************************************************************/

function main() {
  scripts\cp\helicopter\cp_helicopter::heli_precache();
  level._effect["vfx_petrograd_moving_fog_exterior"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_moving_fog_exterior.vfx");
  level._effect["vfx_petrograd_electrical_sparks"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_electrical_sparks.vfx");
  level._effect["vfx_br_electrical_transformer_sparks"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_electrical_transformer_sparks.vfx");
  level._effect["vfx_petrograd_train_flare"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_train_flare.vfx");
  level._effect["vfx_petrograd_water_drips_sml_3"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_water_drips_sml_3.vfx");
  level._effect["vfx_petrograd_sunflare"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_sunflare.vfx");
  level._effect["vfx_petrograd_fluorescent_flare"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_fluorescent_flare.vfx");
  level._effect["vfx_petrograd_bulb_light_flare"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_bulb_light_flare.vfx");
  level._effect["vfx_petrograd_ground_fog_slow"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_ground_fog_slow.vfx");
  level._effect["vfx_petrograd_streetlight_flare"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_streetlight_flare.vfx");
  level._effect["vfx_petrograd_flood_light_flare"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_flood_light_flare.vfx");
  level._effect["vfx_petrograd_lantern_lensflare"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_lantern_lensflare.vfx");
  level._effect["vfx_petrograd_skilo_police_lights"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_skilo_police_lights.vfx");
  level._effect["vfx_petrograd_gas_air_duct_straight"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_gas_air_duct_straight.vfx");
  level._effect["vfx_petrograd_ambulance_lights"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_ambulance_lights.vfx");
  level._effect["vfx_petrograd_gas_ground_smk"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_gas_ground_smk.vfx");
  level._effect["vfx_petrograd_gas_air_duct"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_gas_air_duct.vfx");
  level._effect["vfx_petrograd_sewer_cap_steam"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_sewer_cap_steam.vfx");
  level._effect["vfx_petrograd_wall_vent_steam_sml"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_wall_vent_steam_sml.vfx");
  level._effect["vfx_petrograd_stove_heat"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_stove_heat.vfx");
  level._effect["vfx_petrograd_heater_heat_dist"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_heater_heat_dist.vfx");
  level._effect["vfx_petrograd_sparks_01"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_sparks_01.vfx");
  level._effect["vfx_petrograd_water_drips_sml_2"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_water_drips_sml_2.vfx");
  level._effect["vfx_petrograd_water_drips_sml"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_water_drips_sml.vfx");
  level._effect["vfx_petrograd_interior_dust_motes_med"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_interior_dust_motes_med.vfx");
  level._effect["vfx_petrograd_gas_cloud_linger"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_gas_cloud_linger.vfx");
  level._effect["vfx_billow_mist_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_billow_mist_1.vfx");
  level._effect["vfx_petrograd_blowing_mist_light_1"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_blowing_mist_light_1.vfx");
  level._effect["vfx_petrograd_town_fog"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_town_fog.vfx");
  level._effect["vfx_moths_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_moths_1.vfx");
  level._effect["vfx_gnat_swarm_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_gnat_swarm_1.vfx");
  level._effect["vfx_petrograd_traffic_light_red_2"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_traffic_light_red_2.vfx");
  level._effect["vfx_petrograd_traffic_light_red_2"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_traffic_light_red_2.vfx");
  level._effect["vfx_petrograd_traffic_light_red"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_traffic_light_red.vfx");
  level._effect["vfx_dust_motes_med"] = loadfx("vfx/iw8_mp/gen_amb/vfx_dust_motes_med.vfx");
  level._effect["vfx_petrograd_chimney_smoke"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_chimney_smoke.vfx");
  level._effect["vfx_petrograd_chimney_smoke_2"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_chimney_smoke_2.vfx");
  level._effect["vfx_leaves_falling_olive"] = loadfx("vfx/iw8/level/gen_amb/vfx_leaves_falling_olive.vfx");
  level._effect["vfx_trash_flies"] = loadfx("vfx/iw8_mp/gen_amb/vfx_trash_flies.vfx");
}