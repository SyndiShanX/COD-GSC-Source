/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_ca_red_river_fx.gsc
******************************************/

main() {
  level._effect["vfx_explosion_bkg_fx_runner"] = loadfx("vfx/moments/mp_redriver/vfx_explosion_bkg_fx_runner");
  level._effect["vfx_lizard_walk_randcirc_dwn_r"] = loadfx("vfx/moments/mp_redriver/vfx_lizard_walk_randcirc_dwn_r");
  level._effect["vfx_lizard_walk_spread_dwn_r"] = loadfx("vfx/moments/mp_redriver/vfx_lizard_walk_spread_dwn_r");
  level._effect["vfx_lizard_walk_randcirc_up_r"] = loadfx("vfx/moments/mp_redriver/vfx_lizard_walk_randcirc_up_r");
  level._effect["vfx_lizard_walk_spread_up_r"] = loadfx("vfx/moments/mp_redriver/vfx_lizard_walk_spread_up_r");
  level._effect["vfx_lizard_walk_straight_r"] = loadfx("vfx/moments/mp_redriver/vfx_lizard_walk_straight_r");
  level._effect["vfx_falling_dust_r"] = loadfx("vfx/moments/mp_redriver/vfx_falling_dust_r");
  level._effect["vfx_falling_dust"] = loadfx("vfx/moments/mp_redriver/vfx_falling_dust");
  level._effect["vfx_pipe_pour_r"] = loadfx("vfx/moments/mp_redriver/vfx_pipe_pour_r");
  level._effect["vfx_insects"] = loadfx("vfx/moments/mp_redriver/vfx_insects");
  level._effect["vfx_paper_blow_runner"] = loadfx("vfx/moments/mp_redriver/vfx_paper_blow_runner");
  level._effect["vfx_spark_drip_r"] = loadfx("vfx/moments/mp_redriver/vfx_spark_drip_r");
  level._effect["vfx_dust_wind"] = loadfx("vfx/moments/mp_redriver/vfx_dust_wind");
  level._effect["vfx_dust_vortex_r"] = loadfx("vfx/moments/mp_redriver/vfx_dust_vortex_r");
  level._effect["vfx_explosion_center_lg"] = loadfx("vfx/moments/mp_redriver/vfx_explosion_center_lg");
  level._effect["vfx_leaf_burst"] = loadfx("vfx/moments/mp_redriver/vfx_leaf_burst");
  level._effect["vfx_dust_blast_long"] = loadfx("vfx/moments/mp_redriver/vfx_dust_blast_long");
  level._effect["vfx_dust_blast_impact"] = loadfx("vfx/moments/mp_redriver/vfx_dust_blast_impact");
  level._effect["vfx_bird_flock_left"] = loadfx("vfx/moments/mp_redriver/vfx_bird_flock_left");
  level._effect["vfx_ceiling_dust"] = loadfx("vfx/moments/mp_redriver/vfx_ceiling_dust");
  level._effect["vfx_ceiling_dust_sm"] = loadfx("vfx/moments/mp_redriver/vfx_ceiling_dust_sm");
  level._effect["vfx_ceiling_dust_wood"] = loadfx("vfx/moments/mp_redriver/vfx_ceiling_dust_wood");
  level._effect["vfx_fly_volume"] = loadfx("vfx/moments/mp_redriver/vfx_fly_volume");
  level._effect["vfx_fire_sm"] = loadfx("vfx/moments/mp_redriver/vfx_fire_sm");
  level._effect["vfx_fire_lg"] = loadfx("vfx/moments/mp_redriver/vfx_fire_lg");
  level._effect["vfx_plume_lg"] = loadfx("vfx/moments/mp_redriver/vfx_plume_lg");
  level._effect["vfx_vol_light_warm"] = loadfx("vfx/moments/mp_redriver/vfx_vol_light_warm");
  level._effect["vfx_vol_light_warm_sm"] = loadfx("vfx/moments/mp_redriver/vfx_vol_light_warm_sm");
  level._effect["vfx_vol_light_warm_sm_wide"] = loadfx("vfx/moments/mp_redriver/vfx_vol_light_warm_sm_wide");
  level._effect["vfx_ash_rain"] = loadfx("vfx/moments/mp_redriver/vfx_ash_rain");
  level._effect["vfx_esparks_loop"] = loadfx("vfx/moments/mp_redriver/vfx_esparks_loop");
  level._effect["vfx_pole_fire"] = loadfx("vfx/moments/mp_redriver/vfx_pole_fire");
  level._effect["vfx_godray_rr"] = loadfx("vfx/moments/mp_redriver/vfx_godray_rr");
  level._effect["vfx_firelight_soft_glow_med"] = loadfx("vfx/moments/mp_redriver/vfx_firelight_soft_glow_med");
  level._effect["mp_ca_red_river_pinata"] = loadfx("vfx/ambient/sparks/mp_ca_red_river_pinata");
  level._effect["mp_ca_red_river_pinata_boom"] = loadfx("vfx/ambient/sparks/mp_ca_red_river_pinata_boom");
  level._effect["mp_ca_red_river_pinata_boom_lg"] = loadfx("vfx/ambient/sparks/mp_ca_red_river_pinata_boom_lg");
  level._effect["vfx_breach_wood"] = loadfx("vfx/moments/mp_redriver/vfx_breach_wood");
  level._effect["vfx_breach_metal"] = loadfx("vfx/moments/mp_redriver/vfx_breach_metal");
  level._effect["vfx_ground_dust_a"] = loadfx("vfx/moments/mp_redriver/vfx_ground_dust_a");
  level._effect["vfx_ground_dust_b"] = loadfx("vfx/moments/mp_redriver/vfx_ground_dust_b");
  level._effect["vfx_butterflies_b"] = loadfx("vfx/moments/mp_redriver/vfx_butterflies_b");
  level._effect["vfx_trash_loop"] = loadfx("vfx/moments/mp_redriver/vfx_trash_loop");
  level._effect["vfx_redriver_sunflare"] = loadfx("vfx/moments/mp_redriver/vfx_redriver_sunflare");
  level._effect["explode"] = loadfx("vfx/moments/mp_redriver/mortar_impact");
  level._effect["random_mortars_impact"] = loadfx("vfx/moments/mp_redriver/mortar_impact");
  level._effect["random_mortars_trail"] = loadfx("vfx/moments/mp_redriver/mortar_trail");
  level._effect["mortar_impact_04"] = loadfx("vfx/moments/mp_redriver/mortar_impact_00_rr");
  level._effect["mortar_impact_01"] = loadfx("vfx/moments/mp_redriver/mortar_impact_01_rr");
  level._effect["mortar_impact_00"] = loadfx("vfx/moments/mp_redriver/mortar_impact_04_rr");
}