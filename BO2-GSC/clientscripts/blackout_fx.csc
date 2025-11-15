/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\blackout_fx.csc
*****************************************/

#include clientscripts\_utility;
#include clientscripts\createfx\blackout_fx;
#include clientscripts\_fx;

precache_scripted_fx() {
}

precache_createfx_fx() {
  level._effect["fx_com_sparks_slow"] = loadfx("maps/command_center/fx_com_sparks_slow");
  level._effect["fx_com_sparks"] = loadfx("maps/command_center/fx_com_sparks");
  level._effect["fx_com_water_drips"] = loadfx("maps/command_center/fx_com_water_drips");
  level._effect["fx_com_pipe_water"] = loadfx("maps/command_center/fx_com_pipe_water");
  level._effect["fx_com_pipe_steam"] = loadfx("maps/command_center/fx_com_pipe_steam");
  level._effect["fx_com_pipe_steam_slow"] = loadfx("maps/command_center/fx_com_pipe_steam_slow");
  level._effect["fx_com_distant_exp_1"] = loadfx("maps/command_center/fx_com_distant_exp_1");
  level._effect["fx_com_distant_exp_2"] = loadfx("maps/command_center/fx_com_distant_exp_2");
  level._effect["fx_com_pipe_steam_exp_3"] = loadfx("maps/command_center/fx_com_pipe_steam_exp_3");
  level._effect["fx_com_stairwell_lrg"] = loadfx("maps/command_center/fx_com_stairwell_lrg");
  level._effect["fx_com_vent_steam"] = loadfx("maps/command_center/fx_com_vent_steam");
  level._effect["fx_com_distant_exp_water"] = loadfx("maps/command_center/fx_com_distant_exp_water");
  level._effect["fx_com_distant_exp_flak"] = loadfx("maps/command_center/fx_com_distant_exp_flak");
  level._effect["fx_com_distant_smoke"] = loadfx("maps/command_center/fx_com_distant_smoke");
  level._effect["fx_com_distant_smoke_2"] = loadfx("maps/command_center/fx_com_distant_smoke_2");
  level._effect["fx_com_distant_smoke_sml"] = loadfx("maps/command_center/fx_com_distant_smoke_sml");
  level._effect["fx_com_deck_fire_lrg"] = loadfx("maps/command_center/fx_com_deck_fire_lrg");
  level._effect["fx_com_deck_fire_sml"] = loadfx("maps/command_center/fx_com_deck_fire_sml");
  level._effect["fx_com_int_fire_sml"] = loadfx("maps/command_center/fx_com_int_fire_sml");
  level._effect["fx_com_int_fire_sml_2"] = loadfx("maps/command_center/fx_com_int_fire_sml_2");
  level._effect["fx_com_deck_ember_sml"] = loadfx("maps/command_center/fx_com_deck_ember_sml");
  level._effect["fx_com_deck_takeoff_steam"] = loadfx("maps/command_center/fx_com_deck_takeoff_steam");
  level._effect["fx_com_carrier_runner"] = loadfx("maps/command_center/fx_com_carrier_runner");
  level._effect["fx_com_menendez_spotlight"] = loadfx("maps/command_center/fx_com_menendez_spotlight");
  level._effect["fx_com_oil_drips"] = loadfx("maps/command_center/fx_com_oil_drips");
  level._effect["fx_com_steam_debri"] = loadfx("maps/command_center/fx_com_steam_debri");
  level._effect["fx_com_deck_oil_fire"] = loadfx("maps/command_center/fx_com_deck_oil_fire");
  level._effect["fx_com_deck_exp_vtol"] = loadfx("maps/command_center/fx_com_deck_exp_vtol");
  level._effect["fx_com_deck_exp_f38"] = loadfx("maps/command_center/fx_com_deck_exp_f38");
  level._effect["fx_com_deck_exp_f38_sml"] = loadfx("maps/command_center/fx_com_deck_exp_f38_sml");
  level._effect["fx_com_deck_dust"] = loadfx("maps/command_center/fx_com_deck_dust");
  level._effect["fx_com_water_leak"] = loadfx("maps/command_center/fx_com_water_leak");
  level._effect["fx_com_exp_sparks"] = loadfx("maps/command_center/fx_com_exp_sparks");
  level._effect["fx_com_glass_shatter"] = loadfx("maps/command_center/fx_com_glass_shatter");
  level._effect["fx_com_glass_shatter_f38"] = loadfx("maps/command_center/fx_com_glass_shatter_f38");
  level._effect["fx_com_pipe_steam_exp_1"] = loadfx("maps/command_center/fx_com_pipe_steam_exp_1");
  level._effect["fx_com_pipe_steam_exp_2"] = loadfx("maps/command_center/fx_com_pipe_steam_exp_2");
  level._effect["fx_com_ceiling_collapse"] = loadfx("maps/command_center/fx_com_ceiling_collapse");
  level._effect["fx_com_water_ship_sink"] = loadfx("maps/command_center/fx_com_water_ship_sink");
  level._effect["fx_com_distant_ship_exp"] = loadfx("maps/command_center/fx_com_distant_ship_exp");
  level._effect["fx_com_window_break_paper"] = loadfx("maps/command_center/fx_com_window_break_paper");
  level._effect["fx_com_elev_fa38_impact"] = loadfx("maps/command_center/fx_com_elev_fa38_impact");
  level._effect["fx_com_elev_fa38_exp"] = loadfx("maps/command_center/fx_com_elev_fa38_exp");
  level._effect["fx_com_elev_fa38_debri_trail"] = loadfx("maps/command_center/fx_com_elev_fa38_debri_trail");
  level._effect["fx_com_elev_fa38_debri_trail_2"] = loadfx("maps/command_center/fx_com_elev_fa38_debri_trail_2");
  level._effect["fx_com_elev_fa38_debri_trail_3"] = loadfx("maps/command_center/fx_com_elev_fa38_debri_trail_3");
  level._effect["fx_com_elev_fa38_water_impact"] = loadfx("maps/command_center/fx_com_elev_fa38_water_impact");
  level._effect["fx_com_f38_slide"] = loadfx("maps/command_center/fx_com_f38_slide");
  level._effect["fx_com_drone_slide"] = loadfx("maps/command_center/fx_com_drone_slide");
  level._effect["fx_com_drone_slide_2"] = loadfx("maps/command_center/fx_com_drone_slide_2");
  level._effect["fx_com_drone_slide_3"] = loadfx("maps/command_center/fx_com_drone_slide_3");
  level._effect["fx_com_light_beam"] = loadfx("maps/command_center/fx_com_light_beam");
  level._effect["fx_com_emergency_lights"] = loadfx("maps/command_center/fx_com_emergency_lights");
  level._effect["fx_com_emergency_lights_2"] = loadfx("maps/command_center/fx_com_emergency_lights_2");
  level._effect["fx_com_hanger_godray"] = loadfx("maps/command_center/fx_com_hanger_godray");
  level._effect["fx_com_flourescent_glow_white"] = loadfx("maps/command_center/fx_com_flourescent_glow_white");
  level._effect["fx_com_flourescent_glow_warm"] = loadfx("maps/command_center/fx_com_flourescent_glow_warm");
  level._effect["fx_com_flourescent_glow_green"] = loadfx("maps/command_center/fx_com_flourescent_glow_green");
  level._effect["fx_com_intro_glow"] = loadfx("maps/command_center/fx_com_intro_glow");
  level._effect["fx_com_ceiling_smoke"] = loadfx("maps/command_center/fx_com_ceiling_smoke");
  level._effect["fx_com_hangar_smoke"] = loadfx("maps/command_center/fx_com_hangar_smoke");
  level._effect["fx_com_int_water_splash"] = loadfx("maps/command_center/fx_com_int_water_splash");
  level._effect["fx_com_oil_spill"] = loadfx("maps/command_center/fx_com_oil_spill");
  level._effect["fx_com_oil_spill_fire"] = loadfx("maps/command_center/fx_com_oil_spill_fire");
  level._effect["fx_com_ground_steam_2"] = loadfx("maps/command_center/fx_com_ground_steam_2");
  level._effect["fx_com_ceiling_steam"] = loadfx("maps/command_center/fx_com_ceiling_steam");
  level._effect["fx_com_ground_steam"] = loadfx("maps/command_center/fx_com_ground_steam");
  level._effect["fx_com_light_ray_grill"] = loadfx("maps/command_center/fx_com_light_ray_grill");
  level._effect["fx_com_large_ship_wake"] = loadfx("maps/command_center/fx_com_large_ship_wake");
  level._effect["fx_com_exp_f38_balcony"] = loadfx("maps/command_center/fx_com_exp_f38_balcony");
  level._effect["fx_com_blood_drips"] = loadfx("maps/command_center/fx_com_blood_drips");
  level._effect["fx_com_eye_scanner"] = loadfx("maps/command_center/fx_com_eye_scanner");
  level._effect["fx_com_salazar_bloodpool"] = loadfx("maps/command_center/fx_com_salazar_bloodpool");
  level._effect["fx_com_flourescent_glow_cool"] = loadfx("maps/command_center/fx_com_flourescent_glow_cool");
  level._effect["fx_com_flourescent_glow_cool_sm"] = loadfx("maps/command_center/fx_com_flourescent_glow_cool_sm");
  level._effect["fx_lf_commandcenter_light1"] = loadfx("lens_flares/fx_lf_commandcenter_light1");
  level._effect["fx_lf_commandcenter_light2"] = loadfx("lens_flares/fx_lf_commandcenter_light2");
  level._effect["fx_lf_commandcenter_light3"] = loadfx("lens_flares/fx_lf_commandcenter_light3");
  level._effect["fx_lf_commandcenter_light4"] = loadfx("lens_flares/fx_lf_commandcenter_light4");
  level._effect["fx_lf_commandcenter_light1_cic"] = loadfx("lens_flares/fx_lf_commandcenter_light1_cic");
  level._effect["fx_lf_commandcenter_sun1"] = loadfx("lens_flares/fx_lf_commandcenter_sun1");
  level._effect["fx_lf_commandcenter_small_light"] = loadfx("lens_flares/fx_lf_commandcenter_small_light");
  level._effect["fx_lf_commandcenter_beam_light"] = loadfx("lens_flares/fx_lf_commandcenter_beam_light");
  level._effect["fx_com_dust_superkill"] = loadfx("maps/command_center/fx_com_dust_superkill");
  level._effect["fx_com_glow_sml_blue"] = loadfx("maps/command_center/fx_com_glow_sml_blue");
  level._effect["fx_com_hologram_glow"] = loadfx("maps/command_center/fx_com_hologram_glow");
  level._effect["fx_com_hologram_static"] = loadfx("maps/command_center/fx_com_hologram_static");
  level._effect["fx_com_superkill_decal"] = loadfx("maps/command_center/fx_com_superkill_decal");
}

main() {
  clientscripts\createfx\blackout_fx::main();
  clientscripts\_fx::reportnumeffects();
  precache_createfx_fx();
  disablefx = getdvarint(#"_id_C9B177D6");

  if(!isDefined(disablefx) || disablefx <= 0)
    precache_scripted_fx();
}