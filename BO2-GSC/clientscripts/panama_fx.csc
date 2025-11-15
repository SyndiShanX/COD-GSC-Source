/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\panama_fx.csc
***************************************/

#include clientscripts\_utility;
#include clientscripts\createfx\panama_fx;
#include clientscripts\_fx;

precache_scripted_fx() {
}

precache_createfx_fx() {
  level._effect["fx_prop_beer_open"] = loadfx("maps/panama/fx_prop_beer_open");
  level._effect["fx_tracers_antiair_night"] = loadfx("weapon/antiair/fx_tracers_antiair_night");
  level._effect["fx_flak_field_30k"] = loadfx("explosions/fx_flak_field_30k");
  level._effect["fx_ambient_bombing_10000"] = loadfx("weapon/bomb/fx_ambient_bombing_10000");
  level._effect["fx_seagulls_circle_overhead"] = loadfx("bio/animals/fx_seagulls_circle_overhead");
  level._effect["fx_pan_seagulls_near"] = loadfx("maps/panama/fx_pan_seagulls_near");
  level._effect["fx_pan_seagulls_shore_distant"] = loadfx("maps/panama/fx_pan_seagulls_shore_distant");
  level._effect["fx_pan_exp_condo"] = loadfx("maps/panama/fx_pan_exp_condo");
  level._effect["fx_pan_hotel_blood_decal"] = loadfx("maps/panama/fx_pan_hotel_blood_decal");
  level._effect["fx_pan_hotel_blood_impact"] = loadfx("maps/panama/fx_pan_hotel_blood_impact");
  level._effect["fx_pan_signal_flare"] = loadfx("maps/panama/fx_pan_signal_flare");
  level._effect["fx_pan_signal_flare_falling"] = loadfx("maps/panama/fx_pan_signal_flare_falling");
  level._effect["fx_pan_signal_flare_light"] = loadfx("maps/panama/fx_pan_signal_flare_light");
  level._effect["fx_table_cash_drop_panama"] = loadfx("props/fx_table_cash_drop_panama");
  level._effect["fx_motel_tv_destroyed"] = loadfx("props/fx_tv_motel_destroy");
  level._effect["fx_dest_condo_dust_linger"] = loadfx("maps/panama/fx_dest_condo_dust_linger");
  level._effect["fx_light_runway_line"] = loadfx("env/light/fx_light_runway_line");
  level._effect["fx_spotlight"] = loadfx("maps/panama/fx_pan_spotlight");
  level._effect["fx_shrimp_paratrooper_ambient"] = loadfx("bio/shrimps/fx_shrimp_paratrooper_ambient");
  level._effect["fx_insects_ambient"] = loadfx("bio/insects/fx_insects_ambient");
  level._effect["fx_insects_swarm_less_md_light"] = loadfx("bio/insects/fx_insects_swarm_less_md_light");
  level._effect["fx_insects_fireflies"] = loadfx("bio/insects/fx_insects_fireflies");
  level._effect["fx_smk_linger_lit"] = loadfx("smoke/fx_smk_linger_lit");
  level._effect["fx_smk_smolder_rubble_md"] = loadfx("smoke/fx_smk_smolder_rubble_md");
  level._effect["fx_smk_smolder_rubble_lg"] = loadfx("smoke/fx_smk_smolder_rubble_lg");
  level._effect["fx_pipe_roof_steam_sm"] = loadfx("smoke/fx_pipe_roof_steam_sm");
  level._effect["fx_pan1_vista_smoke_hanging"] = loadfx("smoke/fx_pan1_vista_smoke_hanging");
  level._effect["fx_fire_column_creep_xsm"] = loadfx("env/fire/fx_fire_column_creep_xsm");
  level._effect["fx_fire_line_xsm"] = loadfx("env/fire/fx_fire_line_xsm");
  level._effect["fx_fire_md_smolder"] = loadfx("maps/panama/fx_fire_md_smolder_pan");
  level._effect["fx_ash_embers_heavy"] = loadfx("maps/panama/fx_pan_ash_embers_heavy");
  level._effect["fx_embers_up_dist"] = loadfx("env/fire/fx_embers_up_dist");
  level._effect["fx_debris_papers_fall_burning"] = loadfx("env/debris/fx_debris_papers_fall_burning");
  level._effect["fx_debris_papers_narrow"] = loadfx("env/debris/fx_debris_papers_narrow");
  level._effect["fx_debris_papers_obstructed"] = loadfx("env/debris/fx_debris_papers_obstructed");
  level._effect["fx_debris_papers_windy_slow"] = loadfx("env/debris/fx_debris_papers_windy_slow");
  level._effect["fx_elec_burst_shower_sm_runner"] = loadfx("env/electrical/fx_elec_burst_shower_sm_runner");
  level._effect["fx_fog_lit_overhead_amber"] = loadfx("fog/fx_fog_lit_overhead_amber");
  level._effect["fx_fog_lit_radial_amber"] = loadfx("fog/fx_fog_lit_radial_amber");
  level._effect["fx_fog_thick_800x800"] = loadfx("maps/panama/fx_pan_fog_thick_800x800");
  level._effect["fx_fog_thick_800x800_green"] = loadfx("fog/fx_fog_thick_800x800_green");
  level._effect["fx_smk_pan_hallway_med"] = loadfx("maps/panama/fx_smk_pan_hallway_med");
  level._effect["fx_smk_pan_room_med"] = loadfx("maps/panama/fx_smk_pan_room_med");
  level._effect["fx_pan_powerline_sparks_runner"] = loadfx("maps/panama/fx_pan_powerline_sparks_runner");
  level._effect["fx_pan_shoreline_froth"] = loadfx("maps/panama/fx_pan_shoreline_froth");
  level._effect["fx_pan_rocks_froth"] = loadfx("maps/panama/fx_pan_rocks_froth");
  level._effect["fx_pan_buoy_froth"] = loadfx("maps/panama/fx_pan_buoy_froth");
  level._effect["fx_pan_fog_trench_600x1200"] = loadfx("maps/panama/fx_pan_fog_trench_600x1200");
  level._effect["fx_fire_pan_billow_condo"] = loadfx("maps/panama/fx_fire_pan_billow_condo");
  level._effect["fx_smk_pan_billow_condo"] = loadfx("maps/panama/fx_smk_pan_billow_condo");
  level._effect["fx_pan_truck_smk"] = loadfx("maps/panama/fx_pan_truck_smk");
  level._effect["fx_pan_dust_motes_med"] = loadfx("maps/panama/fx_pan_dust_motes_med");
  level._effect["fx_light_tinhat_cage_white"] = loadfx("env/light/fx_light_tinhat_cage_white");
  level._effect["fx_light_tinhat_cage_yellow"] = loadfx("light/fx_light_tinhat_cage_yellow");
  level._effect["fx_pan_light_overhead"] = loadfx("light/fx_pan_light_overhead_low");
  level._effect["fx_light_floodlight_bright"] = loadfx("maps/panama/fx_pan_light_floodlight_bright");
  level._effect["fx_light_floodlight_dim_sm_amber"] = loadfx("maps/panama/fx_pan_floodlight_dim_sm_amber");
  level._effect["fx_light_flourescent_glow_cool"] = loadfx("light/fx_light_flourescent_glow_cool");
  level._effect["fx_pan_light_flourescent_glow_workshop"] = loadfx("light/fx_pan_light_flourescent_glow_workshop");
  level._effect["fx_pan_streetlight_glow"] = loadfx("light/fx_pan_streetlight_glow");
  level._effect["fx_pan_streetlight_flicker_glow"] = loadfx("light/fx_pan_streetlight_flicker_glow");
  level._effect["fx_pan_light_tower_red_blink"] = loadfx("light/fx_pan_light_tower_red_blink");
  level._effect["fx_light_portable_flood_beam"] = loadfx("light/fx_light_portable_flood_beam");
  level._effect["fx_light_desklamp_glow"] = loadfx("light/fx_light_desklamp_glow");
  level._effect["fx_pan_lightbulb_glow"] = loadfx("light/fx_pan_lightbulb_glow");
  level._effect["fx_pan_hotel_light_glow"] = loadfx("maps/panama/fx_pan_hotel_light_glow");
  level._effect["fx_pan_hotel_light_glow_dim"] = loadfx("maps/panama/fx_pan_hotel_light_glow_dim");
  level._effect["fx_pan_hotel_light_glow_dim_2"] = loadfx("maps/panama/fx_pan_hotel_light_glow_dim_2");
  level._effect["fx_pan_light_el_torito"] = loadfx("maps/panama/fx_pan_light_el_torito");
  level._effect["fx_pan_bbq_fire"] = loadfx("maps/panama/fx_pan_bbq_fire");
  level._effect["fx_pan_buoy_light"] = loadfx("maps/panama/fx_pan_buoy_light");
  level._effect["fx_vlight_brakelight_default"] = loadfx("light/fx_vlight_brakelight_default");
  level._effect["fx_vlight_brakelight_pan"] = loadfx("light/fx_vlight_brakelight_pan");
  level._effect["fx_vlight_headlight_default"] = loadfx("light/fx_vlight_headlight_default");
  level._effect["fx_vlight_headlight_foggy_default"] = loadfx("light/fx_vlight_headlight_foggy_default");
  level._effect["fx_pan_jeep_spot_light"] = loadfx("maps/panama/fx_pan_jeep_spot_light");
  level._effect["fx_pan_fire_med"] = loadfx("maps/panama/fx_pan_fire_med");
  level._effect["fx_pan_fire_lg"] = loadfx("maps/panama/fx_pan_fire_lg");
  level._effect["fx_pan_fire_light"] = loadfx("maps/panama/fx_pan_fire_light");
  level._effect["fx_elec_transformer_exp_huge_bg_ch"] = loadfx("maps/panama/fx_elec_transformer_exp_huge_bg_ch");
  level._effect["fx_pan_shed_godray"] = loadfx("maps/panama/fx_pan_shed_godray");
  level._effect["fx_pan_light_beam_jet"] = loadfx("maps/panama/fx_pan_light_beam_jet");
  level._effect["fx_pan_lock_break"] = loadfx("maps/panama/fx_pan_lock_break");
  level._effect["fx_pan_vista_glow_blue"] = loadfx("maps/panama/fx_pan_vista_glow_blue");
  level._effect["fx_pan_vista_glow_green"] = loadfx("maps/panama/fx_pan_vista_glow_green");
  level._effect["fx_pan_vista_glow_orange"] = loadfx("maps/panama/fx_pan_vista_glow_orange");
  level._effect["fx_pan_light_tinhat_cage_cool"] = loadfx("maps/panama/fx_pan_light_tinhat_cage_cool");
  level._effect["fx_pan_light_tinhat_cage_yellow"] = loadfx("maps/panama/fx_pan_light_tinhat_cage_yellow");
  level._effect["fx_pan_spotlight_table"] = loadfx("maps/panama/fx_pan_spotlight_table");
  level._effect["fx_pan_spotlight_table_2"] = loadfx("maps/panama/fx_pan_spotlight_table_2");
  level._effect["fx_pan_spotlight_garage"] = loadfx("maps/panama/fx_pan_spotlight_garage");
  level._effect["fx_lf_panama_moon1"] = loadfx("lens_flares/fx_lf_panama_moon1");
  level._effect["fx_pan_embers_condo"] = loadfx("maps/panama/fx_pan_embers_condo");
  level._effect["fx_pan_condo_rubble_impact"] = loadfx("maps/panama/fx_pan_condo_rubble_impact");
  level._effect["fx_pan_condo_rubble_collapse"] = loadfx("maps/panama/fx_pan_condo_rubble_collapse");
  level._effect["fx_pan_hangar_godray"] = loadfx("maps/panama/fx_pan_hangar_godray");
  level._effect["fx_pan_ac130_paratroopers"] = loadfx("maps/panama/fx_pan_ac130_paratroopers");
}

main() {
  clientscripts\createfx\panama_fx::main();
  clientscripts\_fx::reportnumeffects();
  precache_createfx_fx();
  disablefx = getdvarint(#"_id_C9B177D6");

  if(!isDefined(disablefx) || disablefx <= 0)
    precache_scripted_fx();
}