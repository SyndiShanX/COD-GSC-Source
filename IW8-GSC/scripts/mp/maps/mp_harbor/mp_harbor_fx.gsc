/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_harbor\mp_harbor_fx.gsc
******************************************************/

function main() {
  level._effect["vfx_harbor_vent_vapor"] = loadfx("vfx/iw8_mp/level/harbor/vfx_harbor_vent_vapor.vfx");
  level._effect["vfx_swirling_dust"] = loadfx("vfx/iw8_mp/level/faridah/vfx_swirling_dust.vfx");
  level._effect["vfx_harbor_lantern_lensflare"] = loadfx("vfx/iw8_mp/level/harbor/vfx_harbor_lantern_lensflare.vfx");
  level._effect["vfx_harbor_distant_fog"] = loadfx("vfx/iw8_mp/level/harbor/vfx_harbor_distant_fog.vfx");
  level._effect["vfx_harbor_bulb_light_flare"] = loadfx("vfx/iw8_mp/level/harbor/vfx_harbor_bulb_light_flare.vfx");
  level._effect["vfx_harbor_fluorescent_lf"] = loadfx("vfx/iw8_mp/level/harbor/vfx_harbor_fluorescent_lf.vfx");
  level._effect["vfx_oil_vent_steam_windy"] = loadfx("vfx/iw8_mp/level/oil/vfx_oil_vent_steam_windy.vfx");
  level._effect["vfx_harbor_dust_move_slow"] = loadfx("vfx/iw8_mp/level/harbor/vfx_harbor_dust_move_slow.vfx");
  level._effect["vfx_water_drips_line_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_water_drips_line_1.vfx");
  level._effect["vfx_br_ambient_smk_lg"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_ambient_smk_lg.vfx");
  level._effect["vfx_br_ambient_smk"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_ambient_smk.vfx");
  level._effect["vfx_trash_flies"] = loadfx("vfx/iw8_mp/gen_amb/vfx_trash_flies.vfx");
  level._effect["vfx_car_smolder_lrg"] = loadfx("vfx/iw8_mp/gen_amb/vfx_car_smolder_lrg.vfx");
  level._effect["vfx_harbor_chimney_smoke_1"] = loadfx("vfx/iw8_mp/level/harbor/vfx_harbor_chimney_smoke_1.vfx");
  level._effect["vfx_harbor_constant_motes"] = loadfx("vfx/iw8_mp/level/harbor/vfx_harbor_constant_motes.vfx");
  level._effect["vfx_harbor_sunflare"] = loadfx("vfx/iw8_mp/level/harbor/vfx_harbor_sunflare.vfx");
  level._effect["vfx_birds_circling"] = loadfx("vfx/iw8_mp/gen_amb/vfx_birds_circling.vfx");
  level._effect["vfx_raid_car_fire_1"] = loadfx("vfx/iw8_mp/level/raid/vfx_raid_car_fire_1.vfx");
  level._effect["vfx_car_fire_linger_2"] = loadfx("vfx/iw8_mp/gen_amb/vfx_car_fire_linger_2.vfx");
  level._effect["vfx_raid_town_fog"] = loadfx("vfx/iw8_mp/level/raid/vfx_raid_town_fog.vfx");
  level._effect["vfx_gnat_swarm_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_gnat_swarm_1.vfx");
  level._effect["vfx_raid_smoke_a"] = loadfx("vfx/iw8_mp/level/raid/vfx_raid_smoke_a.vfx");
  level._effect["vfx_raid_ac_smk"] = loadfx("vfx/iw8_mp/level/raid/vfx_raid_ac_smk.vfx");
  level._effect["vfx_raid_water_pour_sm"] = loadfx("vfx/iw8_mp/level/raid/vfx_raid_water_pour_sm.vfx");
  level._effect["vfx_raid_rat_emit"] = loadfx("vfx/iw8_mp/level/raid/vfx_raid_rat_emit.vfx");
  level._effect["vfx_raid_spark_a"] = loadfx("vfx/iw8_mp/level/raid/vfx_raid_spark_a.vfx");
  level._effect["vfx_billow_mist_1"] = loadfx("vfx/iw8_mp/level/raid/vfx_billow_mist_1.vfx");
  level._effect["vfx_raid_blowing_leaf_d"] = loadfx("vfx/iw8_mp/level/raid/vfx_raid_blowing_leaf_d.vfx");
  level._effect["vfx_raid_leaves_falling"] = loadfx("vfx/iw8_mp/level/raid/vfx_raid_leaves_falling.vfx");
  level._effect["vfx_raid_billow_mist_a"] = loadfx("vfx/iw8_mp/level/raid/vfx_raid_billow_mist_a.vfx");
  level._effect["vfx_raid_mist_ground_01"] = loadfx("vfx/iw8_mp/level/raid/vfx_raid_mist_ground_01.vfx");
  level._effect["vfx_fire_tiny"] = loadfx("vfx/iw8_mp/gen_amb/vfx_fire_tiny.vfx");
  level._effect["vfx_fire_med"] = loadfx("vfx/iw8_mp/gen_amb/vfx_fire_med.vfx");
  level._effect["vfx_fire_sml"] = loadfx("vfx/iw8_mp/gen_amb/vfx_fire_sml.vfx");
  level._effect["vfx_raid_gd_steam_a"] = loadfx("vfx/iw8_mp/level/raid/vfx_raid_gd_steam_a.vfx");
  level._effect["vfx_trash_circle_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_trash_circle_1.vfx");
  level._effect["vfx_butterflies"] = loadfx("vfx/iw8_mp/gen_amb/vfx_butterflies.vfx");
  level._effect["vfx_mosquitos_over_water_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_mosquitos_over_water_1.vfx");
  level._effect["vfx_moths_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_moths_1.vfx");
  level._effect["vfx_falling_dust_ceiling"] = loadfx("vfx/iw8_mp/gen_amb/vfx_falling_dust_ceiling.vfx");
}