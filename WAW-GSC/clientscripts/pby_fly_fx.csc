/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\pby_fly_fx.csc
****************************************/

#include clientscripts\_utility;

precache_util_fx() {}

precache_scripted_fx() {
  loadfx("trail/fx_trail_plane_smoke_damage");

  level._effect["ambient_clouds"] = loadfx("maps/fly/fx_pby_clouds");
  level._effect["pby_wake"] = loadfx("maps/fly/fx_splash_pby_land_ctr");

  level._effect["oil_small"] = loadfx("maps/fly/fx_fire_oil_md_short");
  level._effect["oil_medium"] = loadfx("env/fire/fx_fire_oil_md");
  level._effect["oil_large"] = loadfx("env/fire/fx_fire_oil_lg");

  level._effect["oil_spill_large"] = loadfx("env/water/fx_water_oil_spill_lg");

  level._effect["cargo_1"] = loadfx("maps/fly/fx_dmg_merch_cargo1");
  level._effect["cargo_2"] = loadfx("maps/fly/fx_dmg_merch_cargo2");
  level._effect["cargo_3"] = loadfx("maps/fly/fx_dmg_merch_cargo3");
  level._effect["cargo_4"] = loadfx("maps/fly/fx_dmg_merch_cargo4");
  level._effect["merchant_light"] = loadfx("env/light/fx_ray_spotlight_lg_dlight");
  level._effect["ship_wake"] = loadfx("maps/fly/fx_wake_merch");

  level._effect["zero_wing_dmg1"] = loadfx("maps/fly/fx_dmg_zero_wing1");
  level._effect["zero_wing_dmg2"] = loadfx("maps/fly/fx_dmg_zero_wing2");
  level._effect["zero_wing_dmg3"] = loadfx("maps/fly/fx_dmg_zero_wing3");

  level._effect["pt_churn"] = loadfx("maps/fly/fx_churn_ptboat");
  level._effect["pt_wake"] = loadfx("maps/fly/fx_wake_ptboat");
  level._effect["pt_damage1"] = loadfx("maps/fly/fx_exp_ptboat_main1");
  level._effect["pt_damage2"] = loadfx("maps/fly/fx_exp_ptboat_main2");
  level._effect["pt_damage3"] = loadfx("maps/fly/fx_exp_ptboat_main3");
  level._effect["pt_torpedo"] = loadfx("maps/fly/fx_exp_ptboat_torp");

  level._effect["splash_land_center"] = loadfx("maps/fly/fx_splash_pby_land_ctr");
  level._effect["splash_land_wing"] = loadfx("maps/fly/fx_splash_pby_land_wng");
  level._effect["splash_takeoff_center"] = loadfx("maps/fly/fx_splash_pby_takeoff_ctr");
  level._effect["splash_takeoff_wing"] = loadfx("maps/fly/fx_splash_pby_takeoff_wng");
  level._effect["pby_wake_wing"] = loadfx("maps/fly/fx_wake_pby_wng");
  level._effect["pby_wake_center"] = loadfx("maps/fly/fx_spray_pby_taxi_view");
  level._effect["pby_spray_wing"] = loadfx("maps/fly/fx_spray_pby_taxi_wng");
  level._effect["pby_spray_center"] = loadfx("maps/fly/fx_spray_pby_taxi_ctr");

  level._effect["zero_kamikaze"] = loadfx("maps/fly/fx_exp_kamikaze");
  level._effect["zero_kamikaze_water"] = loadfx("maps/fly/fx_splash_kamikaze_crash");
  level._effect["zero_post_kamikaze"] = loadfx("maps/fly/fx_fire_water_postkamikaze");
  level._effect["post_kami"] = loadfx("maps/fly/fx_exp_deck_postkamikaze");
}
precache_createfx_fx() {
  level._effect["cloud_layer"] = loadfx("maps/fly/fx_cloud_layer");

  level._effect["cloud_layer_os"] = loadfx("maps/fly/fx_cloud_layer_os");
  level._effect["cloud_layer_fill_os"] = loadfx("maps/fly/fx_cloud_layer_fill_os");
  level._effect["cloud_layer_dist"] = loadfx("maps/fly/fx_cloud_plane");
  level._effect["cloud_layer_start"] = loadfx("maps/fly/fx_cloud_layer_start");
  level._effect["3dclouds_20k_runner"] = loadfx("env/weather/fx_cloud3d_cmls_20k_runner");
  level._effect["3dclouds_50k_runner"] = loadfx("env/weather/fx_cloud3d_cmls_50k_runner");
  level._effect["3dclouds_cmls_lg4"] = loadfx("env/weather/fx_cloud3d_cmls_lg4");

  level._effect["sinking_lci_md"] = loadfx("maps/fly/fx_sinking_lci_md");
  level._effect["light_fire_oil_md"] = loadfx("maps/fly/fx_light_fire_oil_md");
  level._effect["fire_oil_low_lg"] = loadfx("env/fire/fx_fire_oil_low_lg");
  level._effect["a_fire_oil_low_sm"] = loadfx("maps/fly/fx_fire_oil_low_sm");
  level._effect["a_fire_oil_xlg"] = loadfx("env/fire/fx_fire_oil_xlg_dist");
  level._effect["a_fire_oil_xlg_slow"] = loadfx("env/fire/fx_fire_oil_xlg_dist_slow");
  level._effect["a_fletcher_fire_md"] = loadfx("maps/fly/fx_fire_deck_md");
  level._effect["a_fletcher_fire_lg"] = loadfx("maps/fly/fx_fire_deck_lg");
  level._effect["a_fletcher_fire_xlg"] = loadfx("maps/fly/fx_fire_deck_xlg_distant");
  level._effect["a_fire_spread_sm_600"] = loadfx("env/fire/fx_fire_line_spread_sm_600");

  level._effect["cloud_lightning_lg"] = loadfx("maps/fly/fx_lightning_cloud_plane_01");
  level._effect["lightning_burst_high"] = loadfx("maps/fly/fx_lightning_clouds_high");
  level._effect["lightning_burst_low"] = loadfx("maps/fly/fx_lightning_clouds_low");

  level._effect["a_smokebank_rescue"] = loadfx("maps/fly/fx_smkbank_water_lg");
  level._effect["a_light_merchantship_mast_thick"] = loadfx("maps/fly/fx_light_merchantship_mast_thick");
  level._effect["a_light_merchantship_mast_mid"] = loadfx("maps/fly/fx_light_merchantship_mast_mid");
  level._effect["a_light_merchantship_mast_thin"] = loadfx("maps/fly/fx_light_merchantship_mast_thin");
}

main() {
  clientscripts\createfx\pby_fly_fx::main();
  clientscripts\_fx::reportNumEffects();

  precache_util_fx();
  precache_createfx_fx();

  disableFX = GetDvarInt("disable_fx");
  if(!isDefined(disableFX) || disableFX <= 0) {
    precache_scripted_fx();
  }
}