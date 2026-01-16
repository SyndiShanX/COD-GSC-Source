/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\yemen_fx.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\createfx\yemen_fx;
#include clientscripts\_fx;

precache_util_fx() {
}

precache_scripted_fx() {
}

precache_createfx_fx() {
  level._effect["fx_balcony_explosion"] = loadfx("maps/yemen/fx_balcony_explosion01");
  level._effect["fx_bridge_explosion01"] = loadfx("maps/yemen/fx_bridge_explosion01");
  level._effect["fx_wall_explosion01"] = loadfx("maps/yemen/fx_wall_explosion01");
  level._effect["fx_wall_explosion02"] = loadfx("maps/yemen/fx_wall_explosion02");
  level._effect["fx_ceiling_collapse01"] = loadfx("maps/yemen/fx_ceiling_collapse01");
  level._effect["fx_ceiling_collapse02"] = loadfx("maps/yemen/fx_ceiling_collapse02");
  level._effect["fx_shockwave01"] = loadfx("maps/yemen/fx_shockwave01");
  level._effect["fx_yemen_rockpuff02_custom"] = loadfx("maps/yemen/fx_yemen_rockpuff02_custom");
  level._effect["fx_yemen_rockpuff02"] = loadfx("maps/yemen/fx_yemen_rockpuff02");
  level._effect["fx_yem_gascan_explo"] = loadfx("maps/yemen/fx_yem_gascan_explo");
  level._effect["fx_yem_elec_burst_fire_sm"] = loadfx("maps/yemen/fx_yem_elec_burst_fire_sm");
  level._effect["fx_yem_elec_burst_xsm"] = loadfx("maps/yemen/fx_yem_elec_burst_xsm");
  level._effect["fx_yem_dest_roof_impact"] = loadfx("maps/yemen/fx_yem_dest_roof_impact");
  level._effect["fx_yem_dest_wall_impact"] = loadfx("maps/yemen/fx_yem_dest_wall_impact");
  level._effect["fx_yem_dest_wall_vtol_tall"] = loadfx("maps/yemen/fx_yem_dest_wall_vtol_tall");
  level._effect["fx_yem_vtol_ground_impact"] = loadfx("maps/yemen/fx_yem_vtol_ground_impact");
  level._effect["fx_yem_fire_column_lg"] = loadfx("maps/yemen/fx_yem_fire_column_lg");
  level._effect["fx_yem_vfire_car_compact"] = loadfx("maps/yemen/fx_yem_vfire_civ_car_compact");
  level._effect["fx_yemen_car_exp_custom"] = loadfx("maps/yemen/fx_yemen_car_exp_custom");
  level._effect["fx_vfire_t6_civ_car_compact"] = loadfx("maps/yemen/fx_yem_vfire_civ_car_compact");
  level._effect["fx_yem_dust_windy_sm"] = loadfx("maps/yemen/fx_yem_dust_windy_sm");
  level._effect["fx_lensflare_exp_hexes_lg_red"] = loadfx("light/fx_lensflare_exp_hexes_lg_red");
  level._effect["fx_heathaze_md"] = loadfx("maps/yemen/fx_heathaze_md");
  level._effect["fx_yemen_lights_warm"] = loadfx("maps/yemen/fx_yemen_lights_warm");
  level._effect["fx_yemen_smoke_column_distant2"] = loadfx("maps/yemen/fx_yemen_smoke_column_distant2");
  level._effect["fx_harper_headshot_decal"] = loadfx("maps/yemen/fx_harper_headshot_decal");
  level._effect["fx_fireplace01"] = loadfx("maps/yemen/fx_fireplace01");
  level._effect["fx_yem_fire_detail"] = loadfx("maps/yemen/fx_yem_fire_detail");
  level._effect["fx_yem_god_ray_med_thin"] = loadfx("maps/yemen/fx_yem_god_ray_med_thin");
  level._effect["fx_yem_god_ray_xlg"] = loadfx("maps/yemen/fx_yem_god_ray_xlg");
  level._effect["fx_yem_god_ray_stained"] = loadfx("maps/yemen/fx_yem_god_ray_stained");
  level._effect["fx_yemen_dust01"] = loadfx("maps/yemen/fx_yemen_dust01");
  level._effect["fx_light_spot_yemen1"] = loadfx("maps/yemen/fx_light_spot_yemen1");
  level._effect["fx_light_spot_yemen2"] = loadfx("maps/yemen/fx_light_spot_yemen2");
  level._effect["fx_light_spot_yemen_morals1"] = loadfx("maps/yemen/fx_light_spot_yemen_morals1");
  level._effect["fx_light_spot_yemen_morals2"] = loadfx("maps/yemen/fx_light_spot_yemen_morals2");
  level._effect["fx_light_spot_yemen_morals3"] = loadfx("maps/yemen/fx_light_spot_yemen_morals3");
  level._effect["fx_light_spot_yemen_morals_shot1"] = loadfx("maps/yemen/fx_light_spot_yemen_morals_shot1");
  level._effect["fx_vtol_moral_fire1"] = loadfx("maps/yemen/fx_vtol_moral_fire1");
  level._effect["fx_moral_fire1"] = loadfx("maps/yemen/fx_moral_fire1");
  level._effect["fx_vtol_moral_thruster_fire"] = loadfx("maps/yemen/fx_vtol_moral_thruster_fire");
  level._effect["fx_yemen_dustwind01"] = loadfx("maps/yemen/fx_yemen_dustwind01");
  level._effect["fx_yemen_smokewind01"] = loadfx("maps/yemen/fx_yemen_smokewind01");
  level._effect["fx_yemen_burningdrone02"] = loadfx("maps/yemen/fx_yemen_burningdrone02");
  level._effect["fx_yemen_burningfoliage_custom01"] = loadfx("maps/yemen/fx_yemen_burningfoliage_custom01");
  level._effect["fx_yemen_rotorwash01"] = loadfx("maps/yemen/fx_yemen_rotorwash01");
  level._effect["fx_yemen_ash01"] = loadfx("maps/yemen/fx_yemen_ash01");
  level._effect["fx_yemen_dustyledge01"] = loadfx("maps/yemen/fx_yemen_dustyledge01");
  level._effect["fx_yemen_dustyledge03"] = loadfx("maps/yemen/fx_yemen_dustyledge03");
  level._effect["fx_yemen_dustyledge04"] = loadfx("maps/yemen/fx_yemen_dustyledge04_parent");
  level._effect["fx_yemen_dustyledge06"] = loadfx("maps/yemen/fx_yemen_dustyledge06_parent");
  level._effect["fx_yemen_leaves_blow01"] = loadfx("maps/yemen/fx_yemen_leaves_blow01");
  level._effect["fx_yemen_leaves_blow02"] = loadfx("maps/yemen/fx_yemen_leaves_blow02");
  level._effect["fx_yemen_mist01"] = loadfx("maps/yemen/fx_yemen_mist01");
  level._effect["fx_yemen_mist02"] = loadfx("maps/yemen/fx_yemen_mist02");
  level._effect["fx_yemen_pcloud_dustfast01"] = loadfx("maps/yemen/fx_yemen_pcloud_dustfast01");
  level._effect["fx_yemen_pcloud_dustfast02"] = loadfx("maps/yemen/fx_yemen_pcloud_dustfast02");
  level._effect["fx_yemen_vistamist01"] = loadfx("maps/yemen/fx_yemen_vistamist01");
  level._effect["fx_yemen_vistamist02"] = loadfx("maps/yemen/fx_yemen_vistamist02");
  level._effect["fx_yemen_wake01"] = loadfx("maps/yemen/fx_yemen_wake01");
  level._effect["fx_yemen_smoldering01"] = loadfx("maps/yemen/fx_yemen_smoldering01");
  level._effect["fx_yemen_smoldering02"] = loadfx("maps/yemen/fx_yemen_smoldering02");
  level._effect["fx_yemen_crepuscular01"] = loadfx("maps/yemen/fx_yemen_crepuscular01");
  level._effect["fx_yemen_smokeflare01"] = loadfx("maps/yemen/fx_yemen_smokeflare01");
  level._effect["fx_firetorch01"] = loadfx("maps/yemen/fx_firetorch01");
  level._effect["fx_yem_smoke_pile"] = loadfx("maps/yemen/fx_yem_smoke_pile");
  level._effect["fx_insects_swarm_md_light"] = loadfx("bio/insects/fx_insects_swarm_md_light");
  level._effect["fx_seagulls_circle_overhead"] = loadfx("maps/yemen/fx_overhead_seagulls");
  level._effect["fx_insects_swarm_md_light"] = loadfx("bio/insects/fx_insects_swarm_md_light");
  level._effect["fx_debris_papers"] = loadfx("maps/yemen/fx_yemen_debris_papers");
  level._effect["fx_vtol_engine_burn2"] = loadfx("maps/yemen/fx_vtol_engine_burn2");
  level._effect["fx_vtol_engine_burn1"] = loadfx("maps/yemen/fx_vtol_engine_burn1");
  level._effect["fx_god_ray_vtol"] = loadfx("maps/yemen/fx_yem_god_ray_vtol");
  level._effect["fx_lf_yemen_sun1"] = loadfx("lens_flares/fx_lf_yemen_sun1");
  level._effect["fx_yemen_light1"] = loadfx("maps/yemen/fx_yemen_light1");
  level._effect["fx_vtol_crash_impact1"] = loadfx("maps/yemen/fx_vtol_crash_impact1");
  level._effect["fx_vtol_crash_impact2"] = loadfx("maps/yemen/fx_vtol_crash_impact2");
  level._effect["fx_vtol_crash_dust1"] = loadfx("maps/yemen/fx_vtol_crash_dust1");
  level._effect["fx_yem_rotor_wash_morals"] = loadfx("maps/yemen/fx_yem_rotor_wash_morals");
  level._effect["fx_yem_vtol_ground_impact_sm"] = loadfx("maps/yemen/fx_yem_vtol_ground_impact_sm");
  level._effect["fx_yem_explo_window"] = loadfx("maps/yemen/fx_yem_explo_window");
  level._effect["fx_fire_line_xsm_thin"] = loadfx("env/fire/fx_fire_line_xsm_thin");
  level._effect["fx_snow_windy_heavy_md_slow"] = loadfx("env/weather/fx_snow_windy_heavy_md_slow");
  level._effect["fx_yemen_rotorwash_market1"] = loadfx("maps/yemen/fx_yemen_rotorwash_market1");
  level._effect["fx_yemen_paratroopers"] = loadfx("maps/yemen/fx_yemen_paratroopers");
  level._effect["fx_yemen_paratroopers_parent"] = loadfx("maps/yemen/fx_yemen_paratroopers_parent");
  level._effect["fx_yemen_vtols"] = loadfx("maps/yemen/fx_yemen_vtols");
  level._effect["fx_yemen_vtols_parent"] = loadfx("maps/yemen/fx_yemen_vtols_parent");
  level._effect["fx_yemen_vtols_death"] = loadfx("maps/yemen/fx_yemen_vtols_death");
  level._effect["fx_yemen_vtols_death_parent"] = loadfx("maps/yemen/fx_yemen_vtols_death_parent");
}

main() {
  clientscripts\createfx\yemen_fx::main();
  clientscripts\_fx::reportnumeffects();
  precache_util_fx();
  precache_createfx_fx();
  disablefx = getdvarint(#"_id_C9B177D6");

  if(!isDefined(disablefx) || disablefx <= 0)
    precache_scripted_fx();
}