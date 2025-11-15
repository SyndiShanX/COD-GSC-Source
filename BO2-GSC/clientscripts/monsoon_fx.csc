/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\monsoon_fx.csc
****************************************/

#include clientscripts\_utility;
#include clientscripts\createfx\monsoon_fx;
#include clientscripts\_fx;

precache_scripted_fx() {
  level._effect["fx_com_emergency_lights"] = loadfx("maps/command_center/fx_com_emergency_lights");
  level._effect["harper_swing_trail"] = loadfx("maps/monsoon/fx_mon_water_rope_swing_trail");
}

precache_createfx_fx() {
  level._effect["fx_mon_lightning_flash_cliff"] = loadfx("maps/monsoon/fx_mon_lightning_flash_cliff");
  level._effect["fx_lightning_flash_single_lg"] = loadfx("weather/fx_lightning_flash_single_lg");
  level._effect["fx_lightning_bolt_single_streak"] = loadfx("weather/fx_lightning_bolt_single_streak");
  level._effect["fx_lightning_tree_hit"] = loadfx("maps/monsoon/fx_mon_tree_lightning_hit");
  level._effect["fx_mon_heli_blade_sparks_sm"] = loadfx("maps/monsoon/fx_mon_heli_blade_sparks_sm");
  level._effect["fx_mon_heli_blade_sparks"] = loadfx("maps/monsoon/fx_mon_heli_blade_sparks");
  level._effect["fx_mon_exp_lion_statue_a"] = loadfx("maps/monsoon/fx_mon_exp_lion_statue_a");
  level._effect["fx_mon_mud_stream_xlg"] = loadfx("dirt/fx_mon_mud_stream_xlg");
  level._effect["fx_mon_mud_stream_lg"] = loadfx("dirt/fx_mon_mud_stream_lg");
  level._effect["fx_exp_gate_entrance"] = loadfx("maps/monsoon/fx_exp_gate_entrance");
  level._effect["fx_exp_glass_window_shatter_lg"] = loadfx("maps/monsoon/fx_exp_glass_window_shatter_lg");
  level._effect["fx_mon_steam_burst_lg"] = loadfx("maps/monsoon/fx_mon_steam_burst_lg");
  level._effect["fx_smoke_breach_room_filler"] = loadfx("maps/monsoon/fx_smoke_breach_room_filler");
  level._effect["fx_exp_int_truck_bash"] = loadfx("maps/monsoon/fx_exp_int_truck_bash");
  level._effect["fx_mon_mud_stream_xlg"] = loadfx("dirt/fx_mon_mud_stream_xlg");
  level._effect["fx_mon_sld_lft_mud_froth"] = loadfx("maps/monsoon/fx_mon_sld_lft_mud_froth");
  level._effect["fx_mon_sld_lft_tower_hit_top"] = loadfx("maps/monsoon/fx_mon_sld_lft_tower_hit_top");
  level._effect["fx_mon_sld_lft_tower_hit"] = loadfx("maps/monsoon/fx_mon_sld_lft_tower_hit");
  level._effect["fx_mon_sld_lft_tower_hit"] = loadfx("maps/monsoon/fx_mon_sld_lft_tower_hit");
  level._effect["fx_mon_sld_lft_tree_hit"] = loadfx("maps/monsoon/fx_mon_sld_lft_tree_hit");
  level._effect["fx_mon_sld_foam"] = loadfx("maps/monsoon/fx_mon_sld_foam");
  level._effect["fx_mon_chamber_wall_glow"] = loadfx("maps/monsoon/fx_mon_chamber_wall_glow");
  level._effect["fx_fog_crate_exit"] = loadfx("maps/monsoon/fx_fog_crate_exit");
  level._effect["fx_exp_chamber_pillar_exp"] = loadfx("explosions/fx_mon_exp_concrete_pillar_md");
  level._effect["fx_elec_short_sparks"] = loadfx("electrical/fx_mon_elec_tv_mount_sparks");
  level._effect["fx_mon_tv_shake_dust"] = loadfx("maps/monsoon/fx_mon_tv_shake_dust");
  level._effect["fx_mon_gate_bash_dust"] = loadfx("maps/monsoon/fx_mon_gate_bash_dust");
  level._effect["fx_fire_sm_smolder"] = loadfx("env/fire/fx_fire_sm_smolder");
  level._effect["fx_fire_md_smolder"] = loadfx("env/fire/fx_fire_md_smolder");
  level._effect["fx_mon_light_short_pop"] = loadfx("electrical/fx_mon_light_short_pop");
  level._effect["fx_mon_crate_fall_mud_splat"] = loadfx("dirt/fx_mon_crate_fall_mud_splat");
  level._effect["fx_mon_chamber_blue_beam"] = loadfx("maps/monsoon/fx_mon_chamber_blue_beam");
  level._effect["fx_mon_chamber_fog_dropdown"] = loadfx("maps/monsoon/fx_mon_chamber_fog_dropdown");
  level._effect["fx_mon_chamber_spot_blue"] = loadfx("light/fx_mon_chamber_spot_blue");
  level._effect["fx_mon_mud_stream_froth"] = loadfx("dirt/fx_mon_mud_stream_froth");
  level._effect["fx_mon_mud_stream_wide"] = loadfx("dirt/fx_mon_mud_stream_wide");
  level._effect["fx_mon_mud_stream_md"] = loadfx("dirt/fx_mon_mud_stream_md");
  level._effect["fx_light_dist_base_white"] = loadfx("light/fx_mon_light_dist_base_white");
  level._effect["fx_light_dist_base_red"] = loadfx("light/fx_mon_light_dist_base_red");
  level._effect["fx_waterfall01"] = loadfx("maps/monsoon/fx_waterfall01");
  level._effect["fx_water_spill_sm_splash"] = loadfx("water/fx_water_spill_sm_splash");
  level._effect["fx_water_roof_spill_lg_hvy"] = loadfx("water/fx_water_roof_spill_lg_hvy");
  level._effect["fx_water_sheeting_lg_hvy"] = loadfx("water/fx_water_sheeting_lg_hvy");
  level._effect["fx_water_splash_detail"] = loadfx("water/fx_water_splash_detail");
  level._effect["fx_water_splash_detail_lg"] = loadfx("water/fx_water_splash_detail_lg");
  level._effect["fx_water_spill_splash_wide"] = loadfx("water/fx_water_spill_splash_wide");
  level._effect["fx_water_drips_hvy_120"] = loadfx("water/fx_water_drips_hvy_120");
  level._effect["fx_water_drips_hvy_200"] = loadfx("water/fx_water_drips_hvy_200");
  level._effect["fx_mon_vent_cleanroom_slow"] = loadfx("maps/monsoon/fx_mon_vent_cleanroom_slow");
  level._effect["fx_mon_vent_roof_steam_lg"] = loadfx("smoke/fx_mon_vent_roof_steam_lg");
  level._effect["fx_mon_vent_roof_steam_wide"] = loadfx("smoke/fx_mon_vent_roof_steam_wide");
  level._effect["fx_mon_steam_lab_rising"] = loadfx("smoke/fx_mon_steam_lab_rising");
  level._effect["fx_mon_fog_temple_shaft"] = loadfx("maps/monsoon/fx_mon_fog_temple_shaft");
  level._effect["fx_mon_fog_temple_ground"] = loadfx("maps/monsoon/fx_mon_fog_temple_ground");
  level._effect["fx_mon_godray_temple_shaft"] = loadfx("maps/monsoon/fx_mon_godray_temple_shaft");
  level._effect["fx_mon_cloud_cover_volume"] = loadfx("maps/monsoon/fx_mon_cloud_cover_volume");
  level._effect["fx_cloud_cover_volume_sm"] = loadfx("weather/fx_cloud_cover_volume_sm");
  level._effect["fx_mon_cloud_cover_flat"] = loadfx("maps/monsoon/fx_mon_cloud_cover_flat");
  level._effect["fx_mon_fog_rising_tall_xlg"] = loadfx("fog/fx_mon_fog_rising_tall_xlg");
  level._effect["fx_rain_ground_gusts_fast_sm"] = loadfx("maps/monsoon/fx_rain_ground_gusts_fast_sm");
  level._effect["fx_rain_ground_gusts_fast_lg"] = loadfx("maps/monsoon/fx_rain_ground_gusts_fast_lg");
  level._effect["fx_mon_leaves_gust_fast_lg"] = loadfx("foliage/fx_mon_leaves_gust_fast_lg");
  level._effect["fx_mon_branch_fall_lg"] = loadfx("foliage/fx_mon_branch_fall_lg");
  level._effect["fx_mon_branch_gust_fast_lg"] = loadfx("foliage/fx_mon_branch_gust_fast_lg");
  level._effect["fx_lf_karma_light_plain1"] = loadfx("lens_flares/fx_lf_karma_light_plain1");
  level._effect["fx_lf_karma_light_plain1_white"] = loadfx("lens_flares/fx_lf_monsoon_light_plain");
  level._effect["fx_kar_flare01"] = loadfx("maps/karma/fx_kar_flare01");
  level._effect["fx_mon_lab_steam_vent"] = loadfx("maps/monsoon/fx_mon_lab_steam_vent");
  level._effect["fx_mon_lab_steam_room"] = loadfx("maps/monsoon/fx_mon_lab_steam_room");
  level._effect["fx_mon_light_overhead_rain"] = loadfx("light/fx_mon_light_overhead_rain");
  level._effect["fx_mon_wtr_rain_light_fill"] = loadfx("water/fx_mon_wtr_rain_light_fill");
  level._effect["fx_wtr_spill_sm_thin_gusty"] = loadfx("water/fx_wtr_spill_sm_thin_gusty");
  level._effect["fx_water_pipe_spill_sm_thin_tall_gusty"] = loadfx("water/fx_water_pipe_spill_sm_thin_tall_gusty");
  level._effect["fx_water_spill_sm_gusty"] = loadfx("water/fx_water_spill_sm_gusty");
  level._effect["fx_water_roof_spill_md_gusty"] = loadfx("water/fx_water_roof_spill_md_gusty");
  level._effect["fx_water_roof_spill_md_hvy_gusty"] = loadfx("water/fx_water_roof_spill_md_hvy_gusty");
  level._effect["fx_water_roof_spill_lg_gusty"] = loadfx("water/fx_water_roof_spill_lg_gusty");
  level._effect["fx_water_roof_spill_lg_hvy_gusty"] = loadfx("water/fx_water_roof_spill_lg_hvy_gusty");
  level._effect["fx_water_roof_spill_sngl_tall_gusty"] = loadfx("water/fx_water_roof_spill_sngl_tall_gusty");
  level._effect["fx_mon_lab_ceiling_flat_lg_warm"] = loadfx("light/fx_mon_lab_ceiling_flat_lg_warm");
  level._effect["fx_mon_lab_ceiling_led_cool"] = loadfx("light/fx_mon_lab_ceiling_led_cool");
  level._effect["fx_mon_lab_ceiling_led_cool_x2"] = loadfx("light/fx_mon_lab_ceiling_led_cool_x2");
  level._effect["fx_mon_lab_ceiling_led_cool_x9"] = loadfx("light/fx_mon_lab_ceiling_led_cool_x9");
  level._effect["fx_mon_ending_spotlight"] = loadfx("maps/monsoon/fx_mon_ending_spotlight");
  level._effect["fx_com_emergency_lights"] = loadfx("maps/command_center/fx_com_emergency_lights");
  level._effect["fx_com_flourescent_glow_white"] = loadfx("maps/command_center/fx_com_flourescent_glow_white");
  level._effect["fx_com_flourescent_glow_warm"] = loadfx("maps/command_center/fx_com_flourescent_glow_warm");
  level._effect["fx_com_flourescent_glow_green"] = loadfx("maps/command_center/fx_com_flourescent_glow_green");
  level._effect["fx_com_flourescent_glow_cool"] = loadfx("maps/command_center/fx_com_flourescent_glow_cool");
  level._effect["fx_com_flourescent_glow_cool_sm"] = loadfx("maps/command_center/fx_com_flourescent_glow_cool_sm");
  level._effect["fx_com_tv_glow_blue"] = loadfx("maps/command_center/fx_com_tv_glow_blue");
  level._effect["fx_com_tv_glow_green"] = loadfx("maps/command_center/fx_com_tv_glow_green");
  level._effect["fx_com_tv_glow_yellow"] = loadfx("maps/command_center/fx_com_tv_glow_yellow");
  level._effect["fx_com_tv_glow_yellow_sml"] = loadfx("maps/command_center/fx_com_tv_glow_yellow_sml");
  level._effect["fx_com_light_glow_white"] = loadfx("maps/command_center/fx_com_light_glow_white");
  level._effect["fx_lf_commandcenter_light1"] = loadfx("lens_flares/fx_lf_commandcenter_light1");
  level._effect["fx_lf_commandcenter_light2"] = loadfx("lens_flares/fx_lf_commandcenter_light2");
  level._effect["fx_lf_commandcenter_light3"] = loadfx("lens_flares/fx_lf_commandcenter_light3");
  level._effect["fx_com_glow_sml_blue"] = loadfx("maps/command_center/fx_com_glow_sml_blue");
}

main() {
  clientscripts\createfx\monsoon_fx::main();
  clientscripts\_fx::reportnumeffects();
  precache_createfx_fx();
  disablefx = getdvarint(#"_id_C9B177D6");

  if(!isDefined(disablefx) || disablefx <= 0)
    precache_scripted_fx();
}