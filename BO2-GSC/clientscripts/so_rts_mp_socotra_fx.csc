/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\so_rts_mp_socotra_fx.csc
**************************************************/

#include clientscripts\_utility;
#include clientscripts\createfx\so_rts_mp_socotra_fx;
#include clientscripts\_fx;

precache_util_fx() {
}

precache_scripted_fx() {
}

#using_animtree("fxanim_props");

precache_fxanim_props() {
  level.scr_anim["fxanim_props"]["rope_toggle"] = % fxanim_gp_rope_toggle_anim;
  level.scr_anim["fxanim_props"]["ropes_hang"] = % fxanim_gp_ropes_hang_01_anim;
  level.scr_anim["fxanim_props"]["rope_arch"] = % fxanim_mp_socotra_rope_arch_anim;
  level.scr_anim["fxanim_props"]["wire_coil"] = % fxanim_gp_wire_coil_01_anim;
  level.scr_anim["fxanim_props"]["wirespark_long"] = % fxanim_gp_wirespark_long_anim;
  level.scr_anim["fxanim_props"]["wirespark_med"] = % fxanim_gp_wirespark_med_anim;
  level.scr_anim["fxanim_props"]["yemen_pent_long"] = % fxanim_gp_flag_yemen_pent_long_anim;
  level.scr_anim["fxanim_props"]["roaches"] = % fxanim_gp_roaches_anim;
  level.scr_anim["fxanim_props"]["cloth_sheet_med"] = % fxanim_gp_cloth_sheet_med_anim;
  level.scr_anim["fxanim_props"]["rope_coil"] = % fxanim_gp_rope_coil_anim;
  level.fx_anim_level_init = ::fxanim_init;
}

precache_createfx_fx() {
  level._effect["fx_war_soc_gas_fog_thick_lg"] = loadfx("smoke/fx_war_soc_gas_fog_thick_lg");
  level._effect["fx_war_soc_gas_fog_thick"] = loadfx("smoke/fx_war_soc_gas_fog_thick");
  level._effect["fx_war_muz_ship_cruiser_3p"] = loadfx("weapon/muzzleflashes/fx_war_muz_ship_cruiser_3p");
  level._effect["fx_war_soc_gas_linger_slow"] = loadfx("smoke/fx_war_soc_gas_linger_slow");
  level._effect["fx_rts_vtol_socotra_dust_kickup"] = loadfx("vehicle/treadfx/fx_rts_vtol_socotra_dust_kickup");
  level._effect["fx_mp_steam_pipe_roof_lg"] = loadfx("maps/mp_maps/fx_mp_steam_pipe_roof_lg");
  level._effect["fx_mp_light_dust_motes_md"] = loadfx("maps/mp_maps/fx_mp_light_dust_motes_md");
  level._effect["fx_light_gray_stain_glss_blue"] = loadfx("light/fx_light_gray_stain_glss_blue");
  level._effect["fx_light_gray_stain_glss_purple"] = loadfx("light/fx_light_gray_stain_glss_purple");
  level._effect["fx_light_gray_stain_glss_warm_sm"] = loadfx("light/fx_light_gray_stain_glss_warm_sm");
  level._effect["fx_mp_sun_flare_socotra"] = loadfx("maps/mp_maps/fx_mp_sun_flare_socotra");
  level._effect["fx_light_gray_blue_ribbon"] = loadfx("light/fx_light_gray_blue_ribbon");
  level._effect["fx_insects_butterfly_flutter"] = loadfx("bio/insects/fx_insects_butterfly_flutter");
  level._effect["fx_insects_butterfly_static_prnt"] = loadfx("bio/insects/fx_insects_butterfly_static_prnt");
  level._effect["fx_insects_roaches_short"] = loadfx("bio/insects/fx_insects_roaches_short");
  level._effect["fx_insects_fly_swarm_lng"] = loadfx("bio/insects/fx_insects_fly_swarm_lng");
  level._effect["fx_insects_fly_swarm"] = loadfx("bio/insects/fx_insects_fly_swarm");
  level._effect["fx_insects_swarm_md_light"] = loadfx("bio/insects/fx_insects_swarm_md_light");
  level._effect["fx_seagulls_circle_below"] = loadfx("bio/animals/fx_seagulls_circle_below");
  level._effect["fx_seagulls_circle_swarm"] = loadfx("bio/animals/fx_seagulls_circle_swarm");
  level._effect["fx_leaves_falling_lite_sm"] = loadfx("foliage/fx_leaves_falling_lite_sm");
  level._effect["fx_debris_papers"] = loadfx("env/debris/fx_debris_papers");
  level._effect["fx_debris_papers_narrow"] = loadfx("env/debris/fx_debris_papers_narrow");
  level._effect["fx_mp_smk_plume_sm_blk"] = loadfx("maps/mp_maps/fx_mp_smk_plume_sm_blk");
  level._effect["fx_mp_smk_plume_md_blk"] = loadfx("maps/mp_maps/fx_mp_smk_plume_md_blk");
  level._effect["fx_smk_cigarette_room_amb"] = loadfx("smoke/fx_smk_cigarette_room_amb");
  level._effect["fx_smk_smolder_gray_slow_shrt"] = loadfx("smoke/fx_smk_smolder_gray_slow_shrt");
  level._effect["fx_fire_fuel_sm"] = loadfx("fire/fx_fire_fuel_sm");
  level._effect["fx_mp_water_drip_light_long"] = loadfx("maps/mp_maps/fx_mp_water_drip_light_long");
  level._effect["fx_mp_water_drip_light_shrt"] = loadfx("maps/mp_maps/fx_mp_water_drip_light_shrt");
  level._effect["fx_water_faucet_on"] = loadfx("water/fx_water_faucet_on");
  level._effect["fx_water_faucet_splash"] = loadfx("water/fx_water_faucet_splash");
  level._effect["fx_mp_waves_shorebreak_socotra"] = loadfx("maps/mp_maps/fx_mp_waves_shorebreak_socotra");
  level._effect["fx_mp_water_shoreline_socotra"] = loadfx("maps/mp_maps/fx_mp_water_shoreline_socotra");
  level._effect["fx_mp_sand_kickup_md"] = loadfx("maps/mp_maps/fx_mp_sand_kickup_md");
  level._effect["fx_mp_sand_kickup_thin"] = loadfx("maps/mp_maps/fx_mp_sand_kickup_thin");
  level._effect["fx_mp_sand_windy_heavy_sm_slow"] = loadfx("maps/mp_maps/fx_mp_sand_windy_heavy_sm_slow");
  level._effect["fx_sand_ledge"] = loadfx("dirt/fx_sand_ledge");
  level._effect["fx_sand_ledge_sml"] = loadfx("dirt/fx_sand_ledge_sml");
  level._effect["fx_sand_ledge_md"] = loadfx("dirt/fx_sand_ledge_md");
  level._effect["fx_sand_ledge_wide_distant"] = loadfx("dirt/fx_sand_ledge_wide_distant");
  level._effect["fx_sand_windy_heavy_md"] = loadfx("dirt/fx_sand_windy_heavy_md");
  level._effect["fx_sand_swirl_sm_runner"] = loadfx("dirt/fx_sand_swirl_sm_runner");
  level._effect["fx_sand_moving_in_air_md"] = loadfx("dirt/fx_sand_moving_in_air_md");
  level._effect["fx_sand_moving_in_air_pcloud"] = loadfx("dirt/fx_sand_moving_in_air_pcloud");
  level._effect["fx_mp_elec_spark_burst_xsm_thin"] = loadfx("maps/mp_maps/fx_mp_elec_spark_burst_xsm_thin");
}

fxanim_init(localclientnum) {
  fxanims = getentarray(localclientnum, "fxanim_level", "targetname");

  if(!isDefined(level.fxanim_waits)) {
    level.fxanim_waits = [];
    level.fxanim_speeds = [];

    for(i = 0; i < fxanims.size; i++) {
      level.fxanim_waits[i] = randomfloatrange(0.1, 1.5);
      level.fxanim_speeds[i] = randomfloatrange(0.75, 1.4);
    }
  }

  for(i = 0; i < fxanims.size; i++) {
    assert(isDefined(fxanims[i].fxanim_scene_1));

    switch (fxanims[i].fxanim_scene_1) {
      case "sparking_wires_med":
      case "wirespark_med":
        fxanims[i] thread fxanim_wire_think(localclientnum, i, "med_spark_06_jnt");
        break;
      case "sparking_wires_long":
      case "wirespark_long":
        fxanims[i] thread fxanim_wire_think(localclientnum, i, "long_spark_06_jnt");
        break;
    }
  }
}

fxanim_wire_think(localclientnum, index, bone) {
  self endon("death");
  self endon("entityshutdown");
  self endon("delete");
  wait 0.3;
  self useanimtree(#animtree);
  wait(level.fxanim_waits[index]);
  self setflaggedanim("wire_fx", level.scr_anim["fxanim_props"][self.fxanim_scene_1], 1.0, 0.0, level.fxanim_speeds[index]);

  for(;;) {
    self waittill("wire_fx", note);
    playfxontag(localclientnum, level._effect["fx_mp_elec_spark_burst_xsm_thin"], self, bone);
  }
}

main() {
  clientscripts\createfx\so_rts_mp_socotra_fx::main();
  clientscripts\_fx::reportnumeffects();
  precache_util_fx();
  precache_createfx_fx();
  precache_fxanim_props();
  wind_initial_setting();
  disablefx = getdvarint(#"_id_C9B177D6");

  if(!isDefined(disablefx) || disablefx <= 0)
    precache_scripted_fx();
}

wind_initial_setting() {
  setsaveddvar("enable_global_wind", 1);
  setsaveddvar("wind_global_vector", "-120 -115 -120");
  setsaveddvar("wind_global_low_altitude", -175);
  setsaveddvar("wind_global_hi_altitude", 4000);
  setsaveddvar("wind_global_low_strength_percent", 0.5);
}