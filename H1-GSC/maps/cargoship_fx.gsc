/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\cargoship_fx.gsc
********************************/

main() {
  level.can_change_vision_set_function = ::cargoship_can_change_vision_set;
  level.pre_set_vision_set_function = ::cargoship_pre_set_vision_set;
  level.can_change_light_set_function = ::cargoship_can_change_light_set;
  level.pre_set_light_set_function = ::cargoship_pre_set_light_set;
  level.truecolor = getmapsunlight();
  level.orgsuncolor = [];

  if(level.jumpto == "start") {
    level.orgsuncolor[0] = 0.0;
    level.orgsuncolor[1] = 0.0;
    level.orgsuncolor[2] = 0.0;
  } else
    level.orgsuncolor = getmapsunlight();

  common_scripts\utility::flag_init("cargoship_lighting_off");
  common_scripts\utility::flag_init("cargoship_rain_off");
  common_scripts\utility::flag_init("cargoship_rain_on");
  common_scripts\utility::flag_init("cargoship_ocean_scenario_start");
  common_scripts\utility::flag_init("cargoship_ocean_scenario_end");
  level._effect["sinking_explosion"] = loadfx("vfx\explosion\cargoship_escape_explosion_indoor");
  level._effect["sinking_explosion_leftovers"] = loadfx("vfx\explosion\cargoship_escape_explosion_indoor_leftovers");
  level._effect["cargoship_fire_hold_1"] = loadfx("vfx\fire\cargoship_fire_hold_1");
  level._effect["cargoship_fire_hold_2"] = loadfx("vfx\fire\cargoship_fire_hold_2");
  level._effect["cargoship_fire_hold_3"] = loadfx("vfx\fire\cargoship_fire_hold_3");
  level._effect["cargoship_fire_staged"] = loadfx("vfx\fire\cargoship_fire_staged");
  level._effect["event_waterleak"] = loadfx("fx\misc\cargoship_sinking_leak_med");
  level._effect["event_waterleak_corridor"] = loadfx("fx\misc\cargoship_sinking_leak_corridor");
  level._effect["event_waterleak_corridor_impact"] = loadfx("fx\misc\cargoship_sinking_leak_corridor_impact");
  level._effect["event_waterleak_corridor_wall"] = loadfx("fx\misc\cargoship_sinking_leak_corridor_wall");
  level._effect["event_waterleak_current"] = loadfx("fx\misc\cargoship_sinking_current_recoil");
  level._effect["event_waterleak_current2"] = loadfx("fx\misc\cargoship_sinking_current_recoil2");
  level._effect["event_waterleak_current_left"] = loadfx("fx\misc\cargoship_sinking_current_recoil_left");
  level._effect["event_waterleak_current_left2"] = loadfx("fx\misc\cargoship_sinking_current_recoil_left2");
  level._effect["event_waterleak_current_right"] = loadfx("fx\misc\cargoship_sinking_current_recoil_right");
  level._effect["event_waterleak_current_right2"] = loadfx("fx\misc\cargoship_sinking_current_recoil_right2");
  level._effect["event_waterleak_impact"] = loadfx("fx\misc\cargoship_sinking_leak_impact");
  level._effect["event_waterleak_impact_2"] = loadfx("fx\misc\cargoship_sinking_leak_impact_2");
  level._effect["event_waterleak_puddle"] = loadfx("fx\misc\cargoship_sinking_leak_puddle");
  level._effect["event_waterleak_puddle_sml"] = loadfx("fx\misc\cargoship_sinking_leak_puddle_sml");
  level._effect["event_waterleak_puddle_slow"] = loadfx("fx\misc\cargoship_sinking_leak_puddle_slow");
  level._effect["event_waterleak_recoil_a"] = loadfx("fx\misc\cargoship_sinking_leak_recoil_a");
  level._effect["event_waterleak_recoil_b"] = loadfx("fx\misc\cargoship_sinking_leak_recoil_b");
  level._effect["event_steamleak"] = loadfx("fx\misc\cargoship_sinking_steam_leak");
  level._effect["sparks_runner"] = loadfx("fx\explosions\cgoshp_sparks_runner");
  level._effect["emergency_light"] = loadfx("vfx\lights\cgoshp_emergency_light");
  level._effect["sinking_stair"] = loadfx("fx\misc\cargoship_sinking_stair");
  level._effect["sinking_decal_catwalk"] = loadfx("fx\misc\cargoship_sinking_decal_catwalk");
  level._effect["sinking_decal_hold"] = loadfx("fx\misc\cargoship_sinking_decal_hold");
  level._effect["sinking_water_path"] = loadfx("fx\misc\cargoship_sinking_water_path");
  level._effect["sinking_water_path_outdoor"] = loadfx("fx\misc\cargoship_sinking_water_path_outdoor");
  level._effect["sinking_water_path_outdoor2"] = loadfx("fx\misc\cargoship_sinking_water_path_outdoor2");
  level._effect["sinking_water_plane_floor"] = loadfx("fx\misc\cargoship_sinking_water_plane_floor");
  level._effect["sinking_water_plane_floor_soft"] = loadfx("fx\misc\cargoship_sinking_water_plane_floor_soft");
  level._effect["sinking_water_plane_1"] = loadfx("fx\misc\cargoship_sinking_water_plane_1");
  level._effect["sinking_water_plane_2"] = loadfx("fx\misc\cargoship_sinking_water_plane_2");
  level._effect["sinking_water_plane_3"] = loadfx("fx\misc\cargoship_sinking_water_plane_3");
  level._effect["sinking_water_plane_gaz"] = loadfx("fx\misc\cargoship_sinking_water_plane_gaz");
  level._effect["sinking_water_corridor"] = loadfx("fx\misc\cargoship_sinking_water_plane_corridor");
  level._effect["sinking_explosion_end"] = loadfx("fx\misc\cargoship_sinking_explosion_end");
  level._effect["sinking_explosion_end_sml"] = loadfx("fx\misc\cargoship_sinking_explosion_end_sml");
  level._effect["sinking_explosion_end_lrg"] = loadfx("fx\misc\cargoship_sinking_explosion_end_lrg");
  level._effect["sinking_explosion_end_lrg2"] = loadfx("fx\misc\cargoship_sinking_explosion_end_lrg2");
  level._effect["sinking_foam"] = loadfx("fx\misc\cargoship_sinking_foam_final");
  level._effect["sinking_smoke_column"] = loadfx("fx\misc\cargoship_sinking_smoke_column");
  level._effect["sinking_waterfall_column"] = loadfx("fx\misc\cargoship_sinking_waterfall_column");
  level._effect["sinking_wave_pole"] = loadfx("fx\misc\cargoship_sinking_wave_pole");
  level._effect["sinking_wave_scenario"] = loadfx("fx\misc\cargoship_sinking_wave_scenario");
  level._effect["sinking_wave_scenario_2"] = loadfx("fx\misc\cargoship_sinking_wave_scenario_2");
  level._effect["escape_waterdrips"] = loadfx("fx\misc\cgoshp_drips_a");
  level._effect["escape_waterdrips_exterior"] = loadfx("fx\misc\cgoshp_drips_a");
  level._effect["escape_water_drip_stairs"] = loadfx("fx\misc\water_drip_stairs");
  level._effect["escape_water_nodrip_stairs"] = loadfx("fx\misc\water_nodrip_stairs");
  level._effect["escape_water_side_stairs"] = loadfx("fx\misc\water_side_stairs");
  level._effect["escape_water_gush_stairs"] = loadfx("fx\misc\water_gush_stairs");
  level._effect["escape_caustics"] = loadfx("fx\misc\caustics");
  level._effect["spotlight_floodlight_cgoshp"] = loadfx("vfx\lights\spotlight_floodlight_cgoshp");
  level._effect["spotlight_floodlight_cgoshp_manifest"] = loadfx("vfx\lights\spotlight_floodlight_cgoshp_manifest");
  level._effect["spotlight_floodlight_2_cgoshp"] = loadfx("vfx\lights\spotlight_floodlight_2_cgoshp");
  level._effect["spotlight_floodlight_3_cgoshp"] = loadfx("vfx\lights\spotlight_floodlight_3_cgoshp");
  level._effect["cargoship_light_ammocrate_white"] = loadfx("fx\misc\cargoship_light_ammocrate_white");
  level._effect["helicopter_minigun"] = loadfx("vfx\weaponimpact\helicopter_minigun_impact_cgoshp");
  level._effect["helicopter_minigun_bomb"] = loadfx("vfx\weaponimpact\helicopter_minigun_impact_cgoshp_bomb");
  level._effect["tv_explosion_light_beam_cargohold"] = loadfx("vfx\lights\tv_explosion_light_beam_cargohold");
  level._effect["tv_explosion_light_beam"] = loadfx("vfx\lights\tv_explosion_light_beam");
  level._effect["cargo_door_grays_white_stairs_cgoshp"] = loadfx("vfx\lights\cargo_door_grays_white_stairs_cgoshp");
  level._effect["cargo_door_grays_white_cgoshp"] = loadfx("vfx\lights\cargo_door_grays_white_cgoshp");
  level._effect["cgoshp_lights_cr_rain"] = loadfx("fx\misc\cgoshp_lights_cr_rain");
  level._effect["vodka_bottle"] = loadfx("fx\props\vodka_bottle");
  level._effect["coffee_mug"] = loadfx("fx\misc\coffee_mug_cargoship");
  level._effect["cargo_vl_red_thin"] = loadfx("fx\misc\cargo_vl_red_thin");
  level._effect["cargo_vl_white"] = loadfx("fx\misc\cargo_vl_white");
  level._effect["cargo_vl_white_soft"] = loadfx("fx\misc\cargo_vl_white_soft");
  level._effect["cargo_vl_white_eql"] = loadfx("fx\misc\cargo_vl_white_eql");
  level._effect["cargo_vl_white_eql_flare"] = loadfx("fx\misc\cargo_vl_white_eql_flare");
  level._effect["cargo_vl_red_lrg"] = loadfx("fx\misc\cargo_vl_red_lrg");
  level._effect["cargo_vl_beam_white"] = loadfx("fx\misc\cargo_vl_beam_white");
  level._effect["cargo_steam"] = loadfx("fx\smoke\cargo_steam");
  level._effect["cargo_steam_single"] = loadfx("fx\smoke\cargo_steam_single");
  level._effect["cargo_steam_single_2"] = loadfx("fx\smoke\cargo_steam_single");
  level._effect["cargo_steam_single_strong"] = loadfx("fx\smoke\cargo_steam_single_strong");
  level._effect["water_pipe_leak_interior_loop"] = loadfx("vfx\water\water_pipe_leak_interior_loop");
  level._effect["water_pipe_leak_interior_loop_cgoshp"] = loadfx("vfx\water\water_pipe_leak_interior_loop_cgoshp");
  level._effect["steam_pipe_leak_interior_loop_sml"] = loadfx("vfx\steam\steam_pipe_leak_interior_loop_sml");
  level._effect["steam_pipe_leak_interior_loop_med"] = loadfx("vfx\steam\steam_pipe_leak_interior_loop_med");
  level._effect["steam_pipe_leak_interior_loop_lrg"] = loadfx("vfx\steam\steam_pipe_leak_interior_loop_lrg");
  level._effect["steam_pipe_leak_interior_loop_cgoshp_red"] = loadfx("vfx\steam\steam_pipe_leak_interior_loop_cgoshp_red");
  level._effect["amb_dust_indoor_slw_mote_cgoshp"] = loadfx("vfx\dust\amb_dust_indoor_slw_mote_cgoshp");
  level._effect["cgoshp_drips_b"] = loadfx("fx\misc\cgoshp_drips_b");
  level._effect["heli_spotlight"] = loadfx("fx\misc\spotlight_medium_cargoship");
  level._effect["heli_spotlight_noshadow"] = loadfx("fx\misc\spotlight_medium_noshadow_cargoship");
  level._effect["spotlight_dlight"] = loadfx("fx\misc\spotlight_dlight");
  level._effect["cigar_glow"] = loadfx("fx\fire\cigar_glow");
  level._effect["cigar_glow_puff"] = loadfx("fx\fire\cigar_glow_puff");
  level._effect["cigar_smoke_puff"] = loadfx("fx\smoke\cigarsmoke_puff");
  level._effect["cigar_exhale"] = loadfx("fx\smoke\cigarsmoke_exhale");
  level._effect["cigarsmoke_exhale_nose"] = loadfx("fx\smoke\cigarsmoke_exhale_nose");
  level._effect["cigar_embers_burst"] = loadfx("fx\fire\cigar_embers_burst");
  level._effect["cigar_embers_wind"] = loadfx("fx\fire\cigar_embers_wind");
  level._effect["heli_minigun_shells"] = loadfx("vfx\map\cargoship\20mm_cargoship_faked");
  level._effect["heli_minigun_muzzleflash"] = loadfx("vfx\map\cargoship\blackhawk_flash_cargoship_faked");
  level._effect["cigarsmoke_wind_vf"] = loadfx("fx\smoke\cigarsmoke_wind_vf");
  level._effect["cigarsmoke_exhale_thin"] = loadfx("fx\smoke\cigarsmoke_exhale_thin");
  level._effect["aircraft_light_cockpit_red"] = loadfx("fx\misc\aircraft_light_cockpit_red_powerfull");
  level._effect["aircraft_light_cockpit_green"] = loadfx("fx\misc\aircraft_light_cockpit_green_powerfull");
  level._effect["aircraft_light_cockpit_blue"] = loadfx("fx\misc\aircraft_light_cockpit_blue");
  level._effect["aircraft_light_red_blink"] = loadfx("fx\misc\aircraft_light_red_blink");
  level._effect["aircraft_light_white_blink"] = loadfx("fx\misc\aircraft_light_white_blink");
  level._effect["aircraft_light_wingtip_green"] = loadfx("fx\misc\aircraft_light_wingtip_green");
  level._effect["aircraft_light_wingtip_red"] = loadfx("fx\misc\aircraft_light_wingtip_red");
  level._effect["aircraft_light_escape_cargoship"] = loadfx("fx\misc\aircraft_light_escape_cargoship");
  level._effect["aircraft_light_escape_cargoship_2"] = loadfx("fx\misc\aircraft_light_escape_cargoship_2");
  level._effect["aircraft__spot_light_escape_cargoship"] = loadfx("fx\misc\aircraft__spot_light_escape_cargoship");
  level._effect["cgoshp_lights_cr"] = loadfx("fx\misc\cgoshp_lights_cr");
  level._effect["cgoshp_lights_cr_fly"] = loadfx("fx\misc\cgoshp_lights_cr_fly");
  level._effect["cgoshp_lights_cr_fly_light"] = loadfx("fx\misc\cgoshp_lights_cr_fly_light");
  level._effect["cgoshp_lights_cr_high"] = loadfx("fx\misc\cgoshp_lights_cr_high");
  level._effect["cgoshp_lights_cr_low"] = loadfx("fx\misc\cgoshp_lights_cr_low");
  level._effect["flashlight"] = loadfx("fx\misc\flashlight_cargoship");
  level._effect["cgoshp_light_tip_red"] = loadfx("fx\misc\cargoship_light_tip_red");
  level._effect["cgoshp_light_tip_green"] = loadfx("fx\misc\cargoship_light_tip_green");
  level._effect["cgoshp_light_tip_white"] = loadfx("fx\misc\cargoship_light_tip_white");
  level._effect["watersplash"] = loadfx("fx\misc\cargoship_splash");
  level._effect["watersplash_2"] = loadfx("fx\misc\cargoship_splash_2");
  level._effect["cgoshp_drips_a"] = loadfx("fx\misc\cgoshp_drips_a");
  level._effect["water_gush"] = loadfx("fx\misc\water_gush");
  level._effect["water_gush_sml"] = loadfx("fx\misc\water_gush_sml");
  level._effect["water_gush_recoil"] = loadfx("fx\misc\water_gush_recoil");
  level._effect["steam"] = loadfx("fx\impacts\pipe_steam");
  level._effect["falling_drip_faucet"] = loadfx("vfx\water\falling_drip_faucet");
  level._effect["light_mist_ceiling_cgoshp"] = loadfx("vfx\water\light_mist_ceiling_cgoshp");
  level._effect["light_mist_wall_cgoshp"] = loadfx("vfx\water\light_mist_wall_cgoshp");
  level._effect["water_sweeping_cgoshp"] = loadfx("vfx\water\water_sweeping_cgoshp");
  level._effect["water_sweeping_cgoshp_sml"] = loadfx("vfx\water\water_sweeping_cgoshp_sml");
  level._effect["falling_drip_ceil_cgoshp"] = loadfx("vfx\water\falling_drip_ceil_cgoshp");
  level._effect["falling_water_heavydoor_cgoshp"] = loadfx("vfx\water\falling_water_heavydoor_cgoshp");
  level._effect["falling_water_heavydoor_cgoshp_noripple"] = loadfx("vfx\water\falling_water_heavydoor_cgoshp_noripple");
  level._effect["falling_water_sidedoor_cgoshp"] = loadfx("vfx\water\falling_water_sidedoor_cgoshp");
  level._effect["falling_water_sidedoor_cgoshp_noripple"] = loadfx("vfx\water\falling_water_sidedoor_cgoshp_noripple");
  level._effect["steam_ambient_cgoshp"] = loadfx("vfx\steam\steam_ambient_cgoshp");
  level._effect["steam_ambient_corridor_cgoshp"] = loadfx("vfx\steam\steam_ambient_corridor_cgoshp");
  level._effect["steam_ambient_corridor_light_cgoshp"] = loadfx("vfx\steam\steam_ambient_corridor_light_cgoshp");
  level._effect["motor_heat_distorsion_cgoshp"] = loadfx("vfx\distortion\motor_heat_distorsion_cgoshp");
  level._effect["canister_steam"] = loadfx("vfx\props\canister_steam");
  level._effect["cin_idle_wavebreak_cgoshp"] = loadfx("vfx\water\cin_idle_wavebreak_cgoshp");
  level._effect["water_edge_foam_cgoshp"] = loadfx("fx\water\water_edge_foam_cgoshp");
  level._effect["cin_idle_wavebreak_cgoshp_massive"] = loadfx("vfx\water\cin_idle_wavebreak_cgoshp_massive");
  level._effect["cin_idle_motor_wave_cgoshp"] = loadfx("fx\water\cin_idle_motor_wave_cgoshp");
  level._effect["waterfall_border_cgoshp_child"] = loadfx("vfx\water\waterfall_border_cgoshp_child");
  animscripts\utility::setfootstepeffect("mud", loadfx("fx\impacts\footstep_water_dark"));
  animscripts\utility::setfootstepeffect("grass", loadfx("fx\impacts\footstep_water_dark"));
  animscripts\utility::setfootstepeffect("dirt", loadfx("fx\impacts\footstep_water_dark"));
  animscripts\utility::setfootstepeffect("concrete", loadfx("fx\impacts\footstep_water_dark"));
  animscripts\utility::setfootstepeffect("rock", loadfx("fx\impacts\footstep_water_dark"));
  animscripts\utility::setfootstepeffect("asphalt", loadfx("fx\impacts\footstep_water_dark"));
  animscripts\utility::setfootstepeffect("wood", loadfx("fx\impacts\footstep_water_dark"));
  animscripts\utility::setfootstepeffect("metal", loadfx("fx\impacts\footstep_water_dark"));
  level._effect["heavy_mist_cgoshp"] = loadfx("fx\weather\heavy_mist_cgoshp");
  level._effect["rain_heavy_mist_heli_hack"] = loadfx("fx\weather\rain_heavy_mist_heli_hack");
  level._effect["rain_heavy_mist_heli_hack_2"] = loadfx("fx\weather\rain_heavy_mist_heli_hack_2");
  level._effect["rain_drops_fastrope"] = loadfx("fx\weather\rain_drops_fastrope");
  level._effect["rain_heavy_cloudtype"] = loadfx("fx\weather\rain_heavy_cloudtype");
  level._effect["screen_heavy_rain_cgoshp"] = loadfx("vfx\rain\screen_heavy_rain_cgoshp");
  level._effect["rain_10"] = loadfx("fx\weather\rain_heavy_mist");
  level._effect["rain_9"] = loadfx("fx\weather\rain_heavy_mist");
  level._effect["rain_8"] = loadfx("fx\weather\rain_heavy_mist");
  level._effect["rain_7"] = loadfx("fx\weather\rain_heavy_mist");
  level._effect["rain_6"] = loadfx("fx\weather\rain_heavy_mist");
  level._effect["rain_5"] = loadfx("fx\weather\rain_heavy_mist");
  level._effect["rain_4"] = loadfx("fx\weather\rain_heavy_mist");
  level._effect["rain_3"] = loadfx("fx\weather\rain_heavy_mist");
  level._effect["rain_2"] = loadfx("fx\weather\rain_heavy_mist");
  level._effect["rain_1"] = loadfx("fx\weather\rain_heavy_mist");
  level._effect["rain_0"] = loadfx("fx\weather\rain_heavy_mist");
  level._effect["tv_explosion"] = loadfx("fx\explosions\tv_explosion");
  level._effect["goggles_cracks"] = loadfx("vfx\ui\goggles_cracks");
  level._effect["goggles_breath"] = loadfx("vfx\unique\breath_sas_goggles");
  level._effect["lightning"] = loadfx("fx\weather\lightning");
  level._effect["lightning_bolt"] = loadfx("fx\weather\cin_lightning_bolt");
  level._effect["destp_office_paper_stack_cgoshp"] = loadfx("vfx\destructible\destp_office_paper_stack_01_dyndst");
  maps\_weather::addlightningexploder(10);
  maps\_weather::addlightningexploder(11);
  maps\_weather::addlightningexploder(12);
  level.nextlightning = gettime() + 1;
  thread raincontrol();
  thread maps\_weather::playerweather();
  thread treadfx_override();
  thread init_exploders();
  thread rampupsun();
  thread rainmask();
  thread ocean_scenario_vfx();
  common_scripts\utility::array_thread(getentarray("interactive_tv", "targetname"), ::tv_fx);
  level.facemaskfx = undefined;
}

tv_fx() {
  while (!isdefined(self.onmodel) && !isdefined(self.onmodel)) {
    wait 0.1;
    continue;
  }

  if(self.model == self.offmodel && !isdefined(self.usetrig)) {
    return;
  }
  var_0 = undefined;

  if(isdefined(self.script_noteworthy)) {
    switch (self.script_noteworthy) {
      case "quarters_tv":
      case "bridge_tv":
        var_0 = level._effect["tv_explosion_light_beam"];
        break;
      case "hallways_tv":
        var_0 = level._effect["tv_explosion_light_beam_cargohold"];
        break;
    }
  }

  if(isdefined(var_0)) {
    for (;;) {
      var_1 = spawnfx(var_0, self.origin, anglestoforward(self.angles), anglestoup(self.angles));
      triggerfx(var_1);
      self waittill("off");
      var_1 delete();
      self.usetrig waittill("trigger");
    }
  }
}

is_interior_vision_set(var_0) {
  return var_0 == "cargoship_alert" || issubstr(var_0, "interior") || issubstr(var_0, "cargoship_intro") || issubstr(var_0, "cargoship_exterior_container");
}

is_lightning_vision_set(var_0) {
  return issubstr(var_0, "lightning");
}

cargoship_can_change_anyset(var_0, var_1) {
  var_2 = isdefined(var_0) && is_interior_vision_set(var_0);
  var_3 = is_interior_vision_set(var_1);

  if(var_3)
    return 1;

  var_4 = 1;
  var_5 = is_lightning_vision_set(var_1);

  if(var_2)
    var_4 = !var_5;
  else
    var_4 = !isdefined(var_0) || !is_lightning_vision_set(var_0) || var_5;

  return var_4;
}

cargoship_can_change_vision_set(var_0) {
  return cargoship_can_change_anyset(level.lvl_visionset, var_0);
}

cargoship_pre_set_vision_set(var_0) {
  if(!is_lightning_vision_set(var_0))
    level.lvl_visionset_wanted = var_0;
}

cargoship_can_change_light_set(var_0) {
  return cargoship_can_change_anyset(self.current_lightset, var_0);
}

cargoship_pre_set_light_set(var_0) {
  if(!is_lightning_vision_set(var_0))
    level.wanted_lightset = var_0;
}

treadfx_override() {
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "brick", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "bark", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "carpet", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "cloth", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "concrete", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "dirt", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "flesh", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "foliage", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "glass", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "grass", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "gravel", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "ice", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "metal", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "mud", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "paper", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "plaster", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "rock", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "sand", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "snow", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "water", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "wood", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "asphalt", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "ceramic", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "plastic", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "rubber", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "cushion", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "fruit", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "painted metal", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "default", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_blackhawk", "none", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "brick", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "bark", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "carpet", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "cloth", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "concrete", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "dirt", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "flesh", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "foliage", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "glass", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "grass", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "gravel", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "ice", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "metal", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "mud", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "paper", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "plaster", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "rock", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "sand", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "snow", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "water", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "wood", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "asphalt", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "ceramic", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "plastic", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "rubber", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "cushion", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "fruit", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "painted metal", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "default", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_treadfx::setvehiclefx("script_vehicle_seaknight", "none", "fx\treadfx\heli_dust_cargoship_outdoor_only", "h1r_cargoship_helicopter_wind");
  maps\_vehicle::add_vehicle_fx_to_bank("fx\treadfx\heli_dust_cargoship");
  maps\_vehicle::add_vehicle_fx_to_bank("fx\treadfx\heli_dust_cargoship_shooting");
}

raincontrol() {
  maps\_weather::raininit("hard");

  if(level.jumpto == "start")
    wait 40;

  thread maps\_weather::lightning(::normal, ::flash);
}

rampupsun() {
  var_0 = level.truecolor;
  var_1 = 10;
  var_2 = [];
  var_2[0] = var_0[0] - level.orgsuncolor[0];
  var_2[1] = var_0[1] - level.orgsuncolor[1];
  var_2[2] = var_0[2] - level.orgsuncolor[2];
  var_3 = var_1 * 5;
  var_4 = [];
  var_4[0] = var_2[0] / var_3;
  var_4[1] = var_2[1] / var_3;
  var_4[2] = var_2[2] / var_3;
  wait 12;

  while (var_3) {
    level.orgsuncolor[0] = level.orgsuncolor[0] + var_4[0];
    level.orgsuncolor[1] = level.orgsuncolor[1] + var_4[1];
    level.orgsuncolor[2] = level.orgsuncolor[2] + var_4[2];
    wait 0.2;
    var_3--;
  }
}

normal() {
  level.sea_foam hide();
  resetsunlight();
  level.fogvalue["near"] = 100;
  level.fogvalue["half"] = 4000;
  common_scripts\utility::flag_set("cargoship_lighting_off");

  if(common_scripts\utility::flag("cargohold_fx")) {
    level.sea_black hide();
    level.sea_foam hide();
    setsunlight(0.001, 0.001, 0.001);
    return;
  }

  level.sea_black show();
}

show_water() {
  level.fogvalue["near"] = 100;
  level.fogvalue["half"] = 7000;

  if(common_scripts\utility::flag("cargohold_fx")) {
    level.sea_black hide();
    level.sea_foam hide();
    return;
  }

  level.sea_foam show();
  level.sea_black hide();
}

init_exploders() {
  waittillframeend;
  level._waves_exploders = maps\_utility::getfxarraybyid("watersplash");
  level._waves_exploders = common_scripts\utility::array_combine(level._waves_exploders, maps\_utility::getfxarraybyid("watersplash_2"));
  level._lighting_exploders = maps\_utility::getfxarraybyid("lightning");

  for (var_0 = 0; var_0 < level._lighting_exploders.size; var_0++) {
    var_1 = level._lighting_exploders[var_0];
    var_1.v["cargoship_origin"] = var_1.v["origin"];
    var_1.tagorigin = common_scripts\utility::spawn_tag_origin();
    var_1.tagorigin.origin = var_1.v["origin"];
    var_1.tagorigin.angles = var_1.v["angles"];
    var_1.v["cannon_spawn_func"] = ::cargoship_cannon_spawnfx;
  }
}

cargoship_cannon_spawnfx() {
  playfxontag(common_scripts\utility::getfx(self.v["fxid"]), self.tagorigin, "tag_origin");
}

rainmask() {
  for (;;) {
    common_scripts\utility::flag_wait("cargoship_rain_on");
    common_scripts\utility::flag_clear("cargoship_rain_off");
    thread rainmaskcheck();
    common_scripts\utility::flag_wait("cargoship_rain_off");
    common_scripts\utility::flag_clear("cargoship_rain_on");
    self notify("stopRainCheck");

    if(isdefined(level.facemaskfx))
      level.facemaskfx delete();
  }
}

rainmaskcheck() {
  self endon("stopRainCheck");
  level.player endon("death");

  for (;;) {
    var_0 = level.player getplayerangles()[0];

    if(var_0 < 50 && !isdefined(level.facemaskfx)) {
      level.facemaskfx = spawnfx(level._effect["screen_heavy_rain_cgoshp"], level.player.origin);
      triggerfx(level.facemaskfx);
    } else if(isdefined(level.facemaskfx))
      level.facemaskfx delete();

    wait 0.1;
  }
}

ocean_scenario_vfx() {
  for (;;) {
    common_scripts\utility::flag_wait("cargoship_ocean_scenario_start");
    common_scripts\utility::flag_clear("cargoship_ocean_scenario_end");
    common_scripts\_exploder::exploder("501");
    common_scripts\utility::flag_wait("cargoship_ocean_scenario_end");
    common_scripts\utility::flag_clear("cargoship_ocean_scenario_start");
    maps\_utility::stop_exploder("501");
  }
}

update_exploders() {
  for (var_0 = 0; var_0 < level._lighting_exploders.size; var_0++)
    level._lighting_exploders[var_0].v["origin"] = level._sea_org localtoworldcoords(level._lighting_exploders[var_0].v["cargoship_origin"]);
}

flash(var_0, var_1, var_2, var_3, var_4) {
  level notify("CS_lighting_flash");
  level endon("CS_lighting_flash");
  var_5 = 0.4;
  var_6 = 0.6;
  var_7 = 1.0;

  if(level.createfx_enabled) {
    return;
  }
  if(common_scripts\utility::flag("cargohold_fx")) {
    normal();
    return;
  }

  var_8 = undefined;

  if(isdefined(var_4))
    var_8 = var_4;
  else
    var_8 = (randomfloatrange(20, 30) * -1, randomfloatrange(20, 25), 0);

  var_9 = 1;
  var_10 = 4;

  if(isdefined(var_0))
    var_9 = var_0;

  if(isdefined(var_1) && var_1 < var_10)
    var_10 = var_1;

  var_11 = randomintrange(var_9, var_10);
  var_9 = 0;
  var_10 = 3;

  if(isdefined(var_2))
    var_9 = var_2;

  if(isdefined(var_3) && var_3 < var_10)
    var_10 = var_3;

  var_12 = randomfloatrange(0.01, 0.04);
  var_13 = randomfloatrange(0.01, 0.04);

  for (var_14 = 0; var_14 < var_11; var_14++) {
    var_15 = randomintrange(var_9, var_10);

    switch (var_15) {
      case 0:
        do_flash(var_12, var_13, "cargoship_lighting_off", (var_5, var_6, var_7), 2);
        break;
      case 1:
        do_flash(var_12, var_13, "cargoship_lighting_off", (var_5, var_6, var_7), 3);
        break;
      case 2:
        do_flash(var_12, var_13, "cargoship_lighting_off", (var_5, var_6, var_7), 4);
        break;
    }

    wait(randomfloatrange(0.01, 0.04));
    normal();
  }

  normal();
}

do_flash(var_0, var_1, var_2, var_3, var_4) {
  wait(var_0);

  if(isdefined(var_2))
    common_scripts\utility::flag_clear(var_2);

  for (var_5 = 0; var_5 < var_4; var_5++) {
    var_6 = randomfloatrange(1.4, 6.5);
    var_7 = (var_3[0] * var_6, var_3[1] * var_6, var_3[2] * var_6);
    do_flash_loop(var_1, var_7, var_5 == 0);
  }

  level.player maps\_utility::set_light_set_player(level.wanted_lightset, 1);
}

do_flash_loop(var_0, var_1, var_2) {
  update_exploders();
  setsunlight(var_1[0], var_1[1], var_1[2]);
  level.player maps\_utility::set_light_set_player("cargoship_lightning");

  if(var_2)
    show_water();

  wait(var_0);
  level.player maps\_utility::set_light_set_player("cargoship_lightning_soft");
  wait(var_0);
}