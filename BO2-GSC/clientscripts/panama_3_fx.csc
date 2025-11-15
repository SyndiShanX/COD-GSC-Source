/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\panama_3_fx.csc
*****************************************/

#include clientscripts\_utility;
#include clientscripts\createfx\panama_3_fx;
#include clientscripts\_fx;

precache_scripted_fx() {
}

precache_createfx_fx() {
  level._effect["fx_ac130_dropping_paratroopers"] = loadfx("bio/shrimps/fx_ac130_dropping_paratroopers");
  level._effect["fx_bulletholes"] = loadfx("impacts/fx_bulletholes");
  level._effect["fx_clinic_ceiling_collapse"] = loadfx("maps/panama/fx_clinic_ceiling_collapse");
  level._effect["fx_clinic_ceiling_collapse_impact"] = loadfx("maps/panama/fx_clinic_ceiling_collapse_impact");
  level._effect["fx_digbat_thru_wall"] = loadfx("maps/panama/fx_digbat_thru_wall");
  level._effect["fx_exp_water_tower"] = loadfx("explosions/fx_exp_water_tower");
  level._effect["fx_noriega_thru_wall"] = loadfx("maps/panama/fx_noriega_thru_wall");
  level._effect["fx_noriega_wall_dust"] = loadfx("maps/panama/fx_noriega_wall_dust");
  level._effect["fx_impacts_apache_escape"] = loadfx("maps/panama/fx_impacts_apache_escape");
  level._effect["fx_impacts_apache_escape_tracer"] = loadfx("maps/panama/fx_impacts_apache_escape_tracer");
  level._effect["fx_heli_rotor_wash_finale"] = loadfx("maps/panama/fx_heli_rotor_wash_finale");
  level._effect["fx_vlight_headlight_default"] = loadfx("maps/panama/fx_vlight_headlight_default_pan");
  level._effect["fx_pan_fence_crash"] = loadfx("maps/panama/fx_pan_fence_crash");
  level._effect["fx_shrimp_paratrooper_ambient"] = loadfx("bio/shrimps/fx_shrimp_paratrooper_ambient");
  level._effect["fx_insects_swarm_less_md_light"] = loadfx("bio/insects/fx_insects_swarm_less_md_light");
  level._effect["fx_dust_crumble_sm_runner"] = loadfx("dirt/fx_dust_crumble_sm_runner");
  level._effect["fx_dust_crumble_int_md_gray"] = loadfx("dirt/fx_dust_crumble_int_md_gray");
  level._effect["fx_dust_crumble_int_sm"] = loadfx("env/dirt/fx_dust_crumble_int_sm");
  level._effect["fx_lf_panama_moon1"] = loadfx("lens_flares/fx_lf_panama_moon1");
  level._effect["fx_fog_lit_overhead_amber"] = loadfx("fog/fx_fog_lit_overhead_amber");
  level._effect["fx_pan_fire_sml"] = loadfx("maps/panama/fx_pan_fire_sml");
  level._effect["fx_pan_fire_light"] = loadfx("maps/panama/fx_pan_fire_light");
  level._effect["fx_pan_dust_linger"] = loadfx("maps/panama/fx_pan_dust_linger");
  level._effect["fx_pan_ember_wood"] = loadfx("maps/panama/fx_pan_ember_wood");
  level._effect["fx_pan_light_overhead_indoor"] = loadfx("light/fx_pan_light_overhead_indoor");
  level._effect["fx_pan_light_overhead"] = loadfx("light/fx_pan_light_overhead");
  level._effect["fx_vlight_headlight_foggy_default"] = loadfx("light/fx_vlight_headlight_foggy_default");
  level._effect["fx_light_portable_flood_beam"] = loadfx("light/fx_light_portable_flood_beam");
  level._effect["fx_pan_light_tower_red_blink"] = loadfx("light/fx_pan_light_tower_red_blink");
  level._effect["fx_smk_fire_md_black"] = loadfx("smoke/fx_smk_fire_md_black");
  level._effect["fx_smk_fire_lg_black"] = loadfx("smoke/fx_smk_fire_lg_black");
  level._effect["fx_smk_linger_lit"] = loadfx("smoke/fx_smk_linger_lit");
  level._effect["fx_smk_smolder_rubble_md"] = loadfx("smoke/fx_smk_smolder_rubble_md");
  level._effect["fx_pan_smk_plume_black_bg_xlg"] = loadfx("smoke/fx_pan_smk_plume_black_bg_xlg");
  level._effect["fx_fire_wall_md"] = loadfx("env/fire/fx_fire_wall_md");
  level._effect["fx_fire_ceiling_md"] = loadfx("env/fire/fx_fire_ceiling_md");
  level._effect["fx_fire_line_sm"] = loadfx("env/fire/fx_fire_line_sm");
  level._effect["fx_ash_embers_heavy"] = loadfx("env/fire/fx_ash_embers_heavy");
  level._effect["fx_embers_up_dist"] = loadfx("env/fire/fx_embers_up_dist");
  level._effect["fx_embers_falling_md"] = loadfx("env/fire/fx_embers_falling_md");
  level._effect["fx_debris_papers_fall_burning"] = loadfx("env/debris/fx_debris_papers_fall_burning");
  level._effect["fx_debris_papers_narrow"] = loadfx("env/debris/fx_debris_papers_narrow");
  level._effect["fx_debris_papers_obstructed"] = loadfx("env/debris/fx_debris_papers_obstructed");
  level._effect["fx_cloud_layer_fire_close"] = loadfx("maps/panama/fx_cloud_layer_fire_close");
  level._effect["fx_cloud_layer_rolling_end"] = loadfx("maps/panama/fx_cloud_layer_rolling_end");
  level._effect["fx_flak_field_30k"] = loadfx("explosions/fx_flak_field_30k");
  level._effect["fx_tracers_antiair_night"] = loadfx("weapon/antiair/fx_tracers_antiair_night");
  level._effect["fx_pan_flak_field_flash"] = loadfx("maps/panama/fx_pan_flak_field_flash");
  level._effect["fx_ambient_bombing_10000"] = loadfx("weapon/bomb/fx_ambient_bombing_10000");
  level._effect["fx_water_drip_light_long_noripple"] = loadfx("env/water/fx_water_drip_light_long_noripple");
  level._effect["fx_water_drip_light_long_noripple"] = loadfx("env/water/fx_water_drip_light_long_noripple");
  level._effect["fx_pan_water_tower_impact"] = loadfx("maps/panama/fx_pan_water_tower_impact");
  level._effect["fx_pan_water_tower_collapse"] = loadfx("maps/panama/fx_pan_water_tower_collapse");
  level._effect["fx_clinic_light_godray"] = loadfx("maps/panama/fx_clinic_light_godray");
  level._effect["fx_clinic_light_godray_2"] = loadfx("maps/panama/fx_clinic_light_godray_2");
  level._effect["fx_clinic_light_godray_3"] = loadfx("maps/panama/fx_clinic_light_godray_3");
  level._effect["fx_clinic_spot_light"] = loadfx("maps/panama/fx_clinic_spot_light");
  level._effect["fx_clinic_flourescent_glow"] = loadfx("maps/panama/fx_clinic_flourescent_glow");
  level._effect["fx_clinic_flourescent_glow_2"] = loadfx("maps/panama/fx_clinic_flourescent_glow_2");
  level._effect["fx_clinic_flourescent_sparks"] = loadfx("maps/panama/fx_clinic_flourescent_sparks");
  level._effect["fx_pan_light_bridge_red_blink"] = loadfx("light/fx_pan_light_bridge_red_blink");
  level._effect["fx_pan_light_bridge_traffic"] = loadfx("light/fx_pan_light_bridge_traffic");
  level._effect["fx_pan_light_canal"] = loadfx("maps/panama/fx_pan_light_canal");
  level._effect["fx_pan_light_canal_lensflare"] = loadfx("maps/panama/fx_pan_light_canal_lensflare");
  level._effect["fx_pan_light_docks_tall"] = loadfx("maps/panama/fx_pan_light_docks_tall");
  level._effect["fx_pan_light_docks_short"] = loadfx("maps/panama/fx_pan_light_docks_short");
  level._effect["fx_pan_light_docks_skinny"] = loadfx("maps/panama/fx_pan_light_docks_skinny");
  level._effect["fx_tracer_ac130_fake"] = loadfx("maps/panama/fx_tracer_ac130_fake");
  level._effect["fx_pan_clinic_blinds_dust"] = loadfx("maps/panama/fx_pan_clinic_blinds_dust");
  level._effect["fx_vlight_jeep_headlight"] = loadfx("light/fx_vlight_jeep_headlight");
  level._effect["fx_vlight_jeep_taillight"] = loadfx("light/fx_vlight_jeep_taillight");
  level._effect["fx_vlight_brakelight_pan"] = loadfx("light/fx_vlight_brakelight_pan");
  level._effect["fx_pan_light_elevator"] = loadfx("maps/panama/fx_pan_light_elevator");
  level._effect["fx_clinic_light_foggy"] = loadfx("maps/panama/fx_clinic_light_foggy");
  level._effect["fx_pan_fire_outro"] = loadfx("maps/panama/fx_pan_fire_outro");
  level._effect["fx_pan_fire_outro_godray"] = loadfx("maps/panama/fx_pan_fire_outro_godray");
  level._effect["fx_pan_outro_dust"] = loadfx("maps/panama/fx_pan_outro_dust");
  level._effect["fx_pan_outro_smoke_rolling"] = loadfx("maps/panama/fx_pan_outro_smoke_rolling");
  level._effect["fx_pan_outro_light_godray"] = loadfx("maps/panama/fx_pan_outro_light_godray");
  level._effect["fx_fog_thick_800x800"] = loadfx("maps/panama/fx_pan_fog_thick_800x800");
  level._effect["fx_pan_mason_blood_decal"] = loadfx("maps/panama/fx_pan_mason_blood_decal");
  level._effect["fx_vlight_parked_alley_car"] = loadfx("maps/panama/fx_vlight_parked_alley_car");
  level._effect["fx_alley_fire_ceiling"] = loadfx("maps/panama/fx_alley_fire_ceiling");
  level._effect["fx_pan_lamp_light_sphere"] = loadfx("maps/panama/fx_pan_lamp_light_sphere");
  level._effect["fx_pan_outro_spotlight"] = loadfx("maps/panama/fx_pan_outro_spotlight");
}

main() {
  clientscripts\createfx\panama_3_fx::main();
  clientscripts\_fx::reportnumeffects();
  precache_createfx_fx();
  disablefx = getdvarint(#"_id_C9B177D6");

  if(!isDefined(disablefx) || disablefx <= 0)
    precache_scripted_fx();
}