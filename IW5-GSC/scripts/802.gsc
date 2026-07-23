/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\802.gsc
**************************************/

main() {
  _id_589C::main();

  if(!maps\_utility::_id_0A36()) {
    maps\_blizzard_hijack::_id_566B();
  }
  level thread maps\_shg_fx::_id_4456();
  thread _id_589E();
  level._effect["snow_blowoff_ledge"] = loadfx("snow/snow_blowoff_ledge");
  level._effect["snow_blowoff_ledge_runner"] = loadfx("snow/snow_blowoff_ledge_runner");
  level._effect["snow_spray_detail_oriented_runner_400x400_rvn"] = loadfx("snow/snow_spray_detail_oriented_runner_400x400_rvn");
  level._effect["snow_spray_detail_runner400x400"] = loadfx("snow/snow_spray_detail_runner400x400");
  level._effect["snow_spray_detail_runner0x400"] = loadfx("snow/snow_spray_detail_runner0x400");
  level._effect["snow_spray_detail_runner0x400_far"] = loadfx("snow/snow_spray_detail_runner0x400_far");
  level._effect["snow_spray_detail_runner0x200_far"] = loadfx("snow/snow_spray_detail_runner0x200_far");
  level._effect["snow_spray_detail_runner50x50"] = loadfx("snow/snow_spray_detail_runner50x50");
  level._effect["snow_spray_detail_rvn"] = loadfx("snow/snow_spray_detail_rvn");
  level._effect["snow_spray_detail_dark"] = loadfx("snow/snow_spray_detail_oriented_dark");
  level._effect["lighthaze_snow"] = loadfx("misc/lighthaze_snow");
  level._effect["lighthaze_snow_headlights"] = loadfx("misc/lighthaze_snow_headlights");
  level._effect["cold_breath"] = loadfx("misc/cold_breath_cheap");
  level._effect["Ground snow dark"] = loadfx("maps/hijack/hijack_ground_snow");
  level._effect["Ground snow light"] = loadfx("maps/hijack/hijack_ground_snow_light");
  level._effect["generic_explosions"] = loadfx("explosions/generic_explosion");
  level._effect["big_explosion"] = loadfx("explosions/100ton_bomb");
  level._effect["powerline_runner_cheap"] = loadfx("explosions/powerline_runner_cheap_hijack");
  level._effect["powerline_runner"] = loadfx("explosions/powerline_runner_sound_hijack");
  level._effect["conference_room_breach"] = loadfx("maps/hijack/conference_room_breach");
  level._effect["vehicle_explosion_technical"] = loadfx("explosions/vehicle_explosion_technical");
  level._effect["hijack_crash_fire_embers"] = loadfx("fire/hijack_crash_fire_embers");
  level._effect["hijack_crash_fire_medium"] = loadfx("fire/hijack_crash_fire_medium");
  level._effect["firelp_med_pm"] = loadfx("maps/hijack/hijack_firelp_med_pm");
  level._effect["after_math_embers"] = loadfx("fire/after_math_embers");
  level._effect["banner_fire"] = loadfx("maps/hijack/hijack_banner_fire");
  level._effect["banner_fire_nodrip"] = loadfx("fire/banner_fire_nodrip");
  level._effect["field_fire_distant2"] = loadfx("fire/field_fire_distant2");
  level._effect["airplane_crash_embers"] = loadfx("fire/airplane_crash_embers");
  level._effect["firelp_large_pm_nolight"] = loadfx("fire/firelp_large_pm_nolight");
  level._effect["firelp_med_pm_nolight"] = loadfx("maps/hijack/hijack_firelp_med_pm_cheap_nolight");
  level._effect["firelp_small_pm"] = loadfx("fire/firelp_small_pm");
  level._effect["firelp_small_pm_nolight"] = loadfx("fire/firelp_small_pm_nolight");
  level._effect["firelp_small_pm_a_nolight"] = loadfx("fire/firelp_small_pm_a_nolight");
  level._effect["fire_tree_embers"] = loadfx("fire/fire_tree_embers");
  level._effect["window_fire_large"] = loadfx("fire/window_fire_large");
  level._effect["fire_trail_60"] = loadfx("fire/fire_trail_60");
  level._effect["hijack_megafire"] = loadfx("maps/hijack/hijack_megafire");
  level._effect["hijack_megafire_smokeless"] = loadfx("maps/hijack/hijack_megafire_smokeless");
  level._effect["hijack_firelp_huge_pm_nolight"] = loadfx("maps/hijack/hijack_firelp_huge_pm_nolight");
  level._effect["trench_glow"] = loadfx("maps/hijack/trench_glow");
  level._effect["hijack_engine_trail"] = loadfx("maps/hijack/hijack_engine_trail");
  level._effect["hijack_engine_split"] = loadfx("maps/hijack/hijack_engine_split");
  level._effect["thin_black_smoke_M_rvn"] = loadfx("smoke/thin_black_smoke_M_rvn");
  level._effect["airplane_crash_smoke"] = loadfx("smoke/airplane_crash_smoke");
  level._effect["battlefield_smokebank_s_warm_thick_rvn"] = loadfx("smoke/battlefield_smokebank_s_warm_thick_rvn");
  level._effect["battlefield_smk_directional_yel_xs"] = loadfx("smoke/battlefield_smk_directional_yel_xs");
  level._effect["thick_dark_smoke_giant"] = loadfx("smoke/thick_dark_smoke_giant_nyharbor");
  level._effect["fog_ground_200_red_rvn"] = loadfx("smoke/fog_ground_200_red_rvn");
  level._effect["conference_room_smoke"] = loadfx("maps/hijack/conference_room_smoke");
  level._effect["car_taillight_uaz_l"] = loadfx("misc/car_taillight_uaz_l");
  level._effect["power_tower_light_red_blink"] = loadfx("misc/power_tower_light_red_blink");
  level._effect["power_tower_light_red_blink_large"] = loadfx("misc/power_tower_light_red_blink_large");
  level._effect["light_blink_subway"] = loadfx("lights/light_blink_subway");
  level._effect["window_volumetric"] = loadfx("maps/hijack/window_volumetric");
  level._effect["window_volumetric_long"] = loadfx("maps/hijack/window_volumetric_long");
  level._effect["window_volumetric_open"] = loadfx("maps/hijack/window_volumetric_open");
  level._effect["plane_gash_volumetric"] = loadfx("maps/hijack/plane_gash_volumetric");
  level._effect["plane_gash_volumetric_long"] = loadfx("maps/hijack/plane_gash_volumetric_long");
  level._effect["lights_hjk_int"] = loadfx("maps/hijack/lights_hjk_int");
  level._effect["lights_stadium"] = loadfx("lights/lights_stadium");
  level._effect["hijack_lights_stadium"] = loadfx("maps/hijack/hijack_lights_stadium");
  level._effect["debris_fxlight_flash"] = loadfx("maps/hijack/debris_fxlight_flash");
  level._effect["fxlight_fire_600"] = loadfx("maps/hijack/fxlight_fire_600");
  level._effect["hijack_potlight_volumetric"] = loadfx("maps/hijack/hijack_potlight_volumetric");
  level._effect["hijack_iris_volumetric"] = loadfx("maps/hijack/hijack_iris_volumetric");
  level._effect["hijack_flare_ambient"] = loadfx("maps/hijack/hijack_flare_ambient");
  level._effect["hijack_tarmac_light"] = loadfx("maps/hijack/hijack_tarmac_light");
  level._effect["paper_flutter"] = loadfx("props/paper_text_flutter");
  level._effect["paper_pile_flutter"] = loadfx("props/paper_text_pile_flutter");
  level._effect["zerog_blood"] = loadfx("maps/hijack/zerog_blood");
  level._effect["luggage_1_des"] = loadfx("props/luggage_1_des");
  level._effect["luggage_2_des"] = loadfx("props/luggage_2_des");
  level._effect["luggage_3_des"] = loadfx("props/luggage_3_des");
  level._effect["luggage_4_des"] = loadfx("props/luggage_4_des");
  level._effect["hijack_fx_light_red_blink"] = loadfx("lights/hijack_fxlight_red_blink");
  level._effect["hijack_fxlight_red_blink_emissive"] = loadfx("lights/hijack_fxlight_red_blink_emissive");
  level._effect["hijack_fxlight_red_blink_flicker"] = loadfx("lights/hijack_fxlight_red_blink_flicker");
  level._effect["hijack_fx_light_red_blink_spot"] = loadfx("lights/hijack_fxlight_red_blink_spot");
  level._effect["hijack_fxlight_warm"] = loadfx("lights/hijack_fxlight_warm");
  level._effect["hijack_fxlight_default"] = loadfx("lights/hijack_fxlight_default");
  level._effect["hijack_fxlight_default_tiny"] = loadfx("lights/hijack_fxlight_default_tiny");
  level._effect["hijack_fxlight_default_med_dim"] = loadfx("lights/hijack_fxlight_default_med_dim");
  level._effect["ak47_flash_wv_hijack_crash"] = loadfx("muzzleflashes/ak47_flash_wv_hijack_crash");
  level._effect["beretta_flash_wv"] = loadfx("muzzleflashes/beretta_flash_wv");
  level._effect["flesh_hit_head_fatal_exit"] = loadfx("impacts/flesh_hit_head_fatal_exit");
  level._effect["flesh_hit_body_fatal_exit"] = loadfx("impacts/flesh_hit_body_fatal_exit");
  level._effect["commander_headshot"] = loadfx("maps/hijack/commander_headshot");
  level._effect["crash_snow_trail"] = loadfx("maps/hijack/hijack_tail_trail");
  level._effect["crash_cabin_decompression"] = loadfx("dust/decompression_cabin_dust");
  level._effect["crash_falling_debris"] = loadfx("explosions/hijack_airplane_collapse_debri_blast");
  level._effect["crash_falling_dust"] = loadfx("dust/hijack_plane_dust");
  level._effect["crash_sled_scrape"] = loadfx("misc/hijack_scrape_airplane_world");
  level._effect["hijack_tower_impact"] = loadfx("maps/hijack/hijack_tower_impact");
  level._effect["fuselage_scrape"] = loadfx("maps/hijack/fuselage_scrape");
  level._effect["smoke_trail_black_jet"] = loadfx("smoke/smoke_trail_black_jet");
  level._effect["aircraft_light_wingtip_green"] = loadfx("misc/aircraft_light_wingtip_green");
  level._effect["aircraft_light_wingtip_red"] = loadfx("misc/aircraft_light_wingtip_red");
  level._effect["aircraft_light_white_blink"] = loadfx("misc/aircraft_light_white_blink");
  level._effect["aircraft_light_red_blink"] = loadfx("misc/aircraft_light_red_blink");
  level._effect["tail_wing_impact"] = loadfx("maps/hijack/tail_wing_impact");
  level._effect["hijack_scrape_airplane"] = loadfx("misc/hijack_scrape_airplane");
  level._effect["cliff_explode_cliffhanger"] = loadfx("explosions/cliff_explode_cliffhanger");
  level._effect["smoke_geotrail_debris"] = loadfx("maps/hijack/smoke_geotrail_debris");
  level._effect["reaper_explosion"] = loadfx("explosions/reaper_explosion");
  level._effect["engine_explosion"] = loadfx("maps/hijack/engine_explosion");
  level._effect["hijack_engine_explosion"] = loadfx("maps/hijack/hijack_engine_explosion");
  level._effect["hijack_engine_split"] = loadfx("maps/hijack/hijack_engine_split");
  level._effect["fuselage_break_sparks1"] = loadfx("maps/hijack/fuselage_break_sparks1");
  level._effect["wing_fuel_explosion"] = loadfx("maps/hijack/wing_fuel_explosion");
  level._effect["cloud_tunnel"] = loadfx("maps/hijack/cloud_tunnel");
  level._effect["interior_ceiling_smoke"] = loadfx("maps/hijack/interior_ceiling_smoke");
  level._effect["interior_ceiling_smoke2"] = loadfx("maps/hijack/interior_ceiling_smoke2");
  level._effect["interior_ceiling_smoke3"] = loadfx("maps/hijack/interior_ceiling_smoke3");
  level._effect["horizon_fireglow"] = loadfx("maps/hijack/horizon_fireglow");
  level._effect["heli_spotlight"] = loadfx("misc/docks_heli_spotlight_model");
  level._effect["heli_spotlight_off"] = loadfx("misc/docks_heli_spotlight_off_model");
  level._effect["antenna_light_red_blink"] = loadfx("maps/hijack/antenna_light_red_blink");
  level._effect["tail_ambient_explosion"] = loadfx("maps/hijack/tail_ambient_explosion");
  level._effect["hijack_engine_sputter"] = loadfx("maps/hijack/hijack_engine_sputter");
  level._effect["hijack_crash_papers"] = loadfx("maps/hijack/hijack_crash_papers");
  level._effect["hijack_paper_explosion"] = loadfx("maps/hijack/hijack_paper_explosion");
  level._effect["hijack_crash_window_volumetric"] = loadfx("maps/hijack/hijack_crash_window_volumetric");
  level._effect["hijack_crash_sparks"] = loadfx("maps/hijack/hijack_crash_sparks");
  level._effect["hijack_sparks_int"] = loadfx("maps/hijack/hijack_sparks_int");
  level._effect["heli_snow_hijack"] = loadfx("treadfx/heli_snow_hijack");
  level._effect["hijack_window_glow"] = loadfx("maps/hijack/hijack_window_glow");
  level._effect["hijack_ambient_embers"] = loadfx("maps/hijack/hijack_ambient_embers");
  level._effect["hjk_vent_smk"] = loadfx("maps/hijack/hjk_vent_smk");
  level._effect["makarov_heli_interior_light"] = loadfx("lights/hijack_fxlight_makarov_heli_interior");
  level._effect["hijack_tail_impact"] = loadfx("maps/hijack/hijack_tail_impact");
  level._effect["hijack_tail_spray"] = loadfx("maps/hijack/hijack_tail_spray");
  level._effect["hijack_tail_trail"] = loadfx("maps/hijack/hijack_tail_trail");
  level._effect["snowcat_lights"] = loadfx("misc/snowcat_lights");
  level._effect["commander_blood_pool"] = loadfx("impacts/hjk_commander_blood_pool");
  level._effect["hijack_water_drips_short"] = loadfx("maps/hijack/hijack_water_drips_short");
  level._effect["hijack_water_splash_short"] = loadfx("maps/hijack/hijack_water_splash_short");
}

_id_589E() {
  level._effect["footstep_snow"] = loadfx("impacts/hjk_footstep_snow");
  level._effect["footstep_snow_small"] = loadfx("impacts/hjk_footstep_snow_small");
  level._effect["footstep_ice"] = loadfx("impacts/hjk_footstep_ice");
  level._effect["footstep_dust"] = loadfx("impacts/footstep_dust");
  animscripts\utility::_id_24BB("snow", level._effect["footstep_snow"]);
  animscripts\utility::_id_24BB("ice", level._effect["footstep_ice"]);
  animscripts\utility::_id_24BB("asphalt", level._effect["footstep_dust"]);
  animscripts\utility::_id_24BB("dirt", level._effect["footstep_dust"]);
  animscripts\utility::_id_24BC("snow", level._effect["footstep_snow_small"]);
  animscripts\utility::_id_24BC("ice", level._effect["footstep_ice"]);
  animscripts\utility::_id_24BC("asphalt", level._effect["footstep_dust"]);
  animscripts\utility::_id_24BC("dirt", level._effect["footstep_dust"]);
  level.player thread _id_589F();
}

_id_589F() {
  for(;;) {
    wait(randomfloatrange(0.25, 0.5));
    var_0 = self.origin + (0, 0, 0);
    var_1 = self.origin - (0, 0, 5);
    var_2 = bulletTrace(var_0, var_1, 0, undefined);
    var_3 = anglesToForward(self.angles);
    var_4 = distance(self getvelocity(), (0, 0, 0));

    if(isDefined(self.vehicle)) {
      continue;
    }
    if(var_2["surfacetype"] != "snow") {
      continue;
    }
    if(var_4 <= 10) {
      continue;
    }
    var_5 = "snow_movement";

    if(!common_scripts\utility::flag("hide_player_snow_footprints")) {
      if(distance(self getvelocity(), (0, 0, 0)) <= 154) {
        playFX(common_scripts\utility::getfx("footstep_snow_small"), var_2["position"], var_2["normal"], var_3);
      }
      if(distance(self getvelocity(), (0, 0, 0)) > 154) {
        playFX(common_scripts\utility::getfx("footstep_snow"), var_2["position"], var_2["normal"], var_3);
      }
    }
  }
}