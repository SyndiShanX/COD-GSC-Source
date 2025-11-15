/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\flood_fx.gsc
*****************************************************/

main() {
  level._effect["infil_ground_smk_plume_thin"] = loadfx("vfx/moments/flood/infil_ground_smk_plume_thin");
  level._effect["flood_birds_takeoff"] = loadfx("fx/misc/flood_birds_takeoff");
  level._effect["warehouse_doorbreach_smoke_bright"] = loadfx("vfx/moments/flood/warehouse_doorbreach_smoke_bright");
  level._effect["vfx_imp_lar_water_02"] = loadfx("vfx/gameplay/impacts/large/vfx_imp_lar_water_02");
  level._effect["vfx_fire_wall_small_02"] = loadfx("vfx/ambient/fire/wall/vfx_fire_wall_small_02");
  level._effect["vfx_underwater_froth_dense"] = loadfx("vfx/ambient/water/vfx_underwater_froth_dense");
  level._effect["no_effect"] = loadfx("vfx/ambient/misc/no_effect");
  level._effect["flood_lit_smoke"] = loadfx("vfx/moments/flood/flood_lit_smoke");
  level._effect["swept_underwater_fx_st"] = loadfx("vfx/moments/flood/swept_underwater_fx_st");
  level._effect["swept_underwater_fx"] = loadfx("vfx/moments/flood/swept_underwater_fx");
  level._effect["vfx_imp_sml_water_02"] = loadfx("vfx/gameplay/impacts/small/vfx_imp_sml_water_02");
  level._effect["flood_db_foam_allie_ch"] = loadfx("vfx/moments/flood/flood_db_foam_allie_ch");
  level._effect["flood_db_foam_allie_ch_med"] = loadfx("vfx/moments/flood/flood_db_foam_allie_ch_med");
  level._effect["flood_db_foam_allie_ch_fast"] = loadfx("vfx/moments/flood/flood_db_foam_allie_ch_fast");
  level._effect["flood_ground_smoke_drk_thick"] = loadfx("vfx/moments/flood/flood_ground_smoke_drk_thick");
  level._effect["vfx_dam_mist_smaller"] = loadfx("vfx/ambient/water/vfx_dam_mist_smaller");
  level._effect["vfx_dam_side_impact"] = loadfx("vfx/ambient/water/vfx_dam_side_impact");
  level._effect["vfx_dam_mist_sml"] = loadfx("vfx/ambient/water/vfx_dam_mist_sml");
  level._effect["vfx_dam_mist_lrg"] = loadfx("vfx/ambient/water/vfx_dam_mist_lrg");
  level._effect["vfx_splash_small_02"] = loadfx("vfx/ambient/water/vfx_splash_small_02");
  level._effect["flood_underwater_godrays_small"] = loadfx("vfx/moments/flood/flood_underwater_godrays_small");
  level._effect["stealth_tussle_splashes"] = loadfx("vfx/moments/flood/stealth_tussle_splashes");
  level._effect["stealth_tussle_splashes_sml"] = loadfx("vfx/moments/flood/stealth_tussle_splashes_sml");
  level._effect["tussle_splash_run"] = loadfx("vfx/moments/flood/tussle_splash_run");
  level._effect["tussle_splash_sml_run"] = loadfx("vfx/moments/flood/tussle_splash_sml_run");
  level._effect["tussle_bubbles_emit"] = loadfx("vfx/moments/flood/tussle_bubbles_emit");
  level._effect["bubbles_stealth_emit"] = loadfx("vfx/moments/flood/bubbles_stealth_emit");
  level._effect["bubbles_stealth_ch"] = loadfx("vfx/moments/flood/bubbles_stealth_ch");
  level._effect["vfx_flesh_knife_hit"] = loadfx("vfx/gameplay/impacts/flesh/vfx_flesh_knife_hit");
  level._effect["vfx_flesh_knife_hit_underwater"] = loadfx("vfx/gameplay/impacts/flesh/vfx_flesh_knife_hit_underwater");
  level._effect["bubbles_stealth_runner"] = loadfx("vfx/moments/flood/bubbles_stealth_runner");
  level._effect["flood_grenadeexp_water"] = loadfx("vfx/moments/flood/flood_grenadeexp_water");
  level._effect["rorke_hand_dunk_foam"] = loadfx("vfx/moments/flood/rorke_hand_dunk_foam");
  level._effect["rorke_hand_bubbles_runner"] = loadfx("vfx/moments/flood/rorke_hand_bubbles_runner");
  level._effect["flood_integration_db_bus_emit"] = loadfx("vfx/moments/flood/flood_integration_db_bus_emit");
  level._effect["vfx_blood_impact_almagro"] = loadfx("vfx/moments/flood/vfx_blood_impact_almagro");
  level._effect["vfx_water_spray_strong"] = loadfx("vfx/ambient/water/vfx_water_spray_strong");
  level._effect["water_waterline_plunge_a"] = loadfx("vfx/moments/flood/water_waterline_plunge_a");
  level._effect["water_waterline_plunge_b"] = loadfx("vfx/moments/flood/water_waterline_plunge_b");
  level._effect["water_waterline_plunge_runner"] = loadfx("vfx/moments/flood/water_waterline_plunge_runner");
  level._effect["vfx_water_mist_lrg"] = loadfx("vfx/ambient/water/vfx_water_mist_lrg");
  level._effect["vfx_warehouse_lip_froth_dark"] = loadfx("vfx/moments/flood/vfx_warehouse_lip_froth_dark");
  level._effect["flood_db_foam_allie_emit_med"] = loadfx("vfx/moments/flood/flood_db_foam_allie_emit_med");
  level._effect["flood_db_foam_allie_emit_fast"] = loadfx("vfx/moments/flood/flood_db_foam_allie_emit_fast");
  level._effect["flood_db_foam_allie_emit"] = loadfx("vfx/moments/flood/flood_db_foam_allie_emit");
  level._effect["vfx_jetscrape_short_runner"] = loadfx("vfx/moments/carrier/vfx_jetscrape_short_runner");
  level._effect["glass_crack_oriented"] = loadfx("fx/misc/glass_crack_oriented");
  level._effect["vfx_debris_wall_impact"] = loadfx("vfx/gameplay/explosions/impacts/vfx_debris_wall_impact");
  level._effect["vfx_splash_medium_02"] = loadfx("vfx/ambient/water/vfx_splash_medium_02");
  level._effect["flood_integration_db_emit"] = loadfx("vfx/moments/flood/flood_integration_db_emit");
  level._effect["flood_integration_foamsplash_db"] = loadfx("vfx/moments/flood/flood_integration_foamsplash_db");
  level._effect["vfx_blood_hit_oriented"] = loadfx("vfx/gameplay/blood/vfx_blood_hit_oriented");
  level._effect["vfx_sparks_blown_slow"] = loadfx("vfx/ambient/sparks/vfx_sparks_blown_slow");
  level._effect["flood_underwater_debris"] = loadfx("vfx/moments/flood/flood_underwater_debris");
  level._effect["vfx_nh90_water_impact_spash"] = loadfx("vfx/moments/flood/vfx_nh90_water_impact_spash");
  level._effect["blood_smear_oriented"] = loadfx("fx/misc/blood_smear_oriented");
  level._effect["vfx_nh90_sml_smk_fall_emit"] = loadfx("vfx/moments/flood/vfx_nh90_sml_smk_fall_emit");
  level._effect["vfx_nh90_dstry_smk_fall_emit"] = loadfx("vfx/moments/flood/vfx_nh90_dstry_smk_fall_emit");
  level._effect["vfx_nh90_impact_smoke"] = loadfx("vfx/moments/flood/vfx_nh90_impact_smoke");
  level._effect["vfx_flood_window_break"] = loadfx("vfx/moments/flood/vfx_flood_window_break");
  level._effect["vfx_debris_fall_heli"] = loadfx("vfx/moments/flood/vfx_debris_fall_heli");
  level._effect["vfx_nh90_dstry_smk_02"] = loadfx("vfx/moments/flood/vfx_nh90_dstry_smk_02");
  level._effect["vfx_sparks_sign_ch_02"] = loadfx("vfx/ambient/sparks/vfx_sparks_sign_ch_02");
  level._effect["vfx_nh90_dstry_smk_fall"] = loadfx("vfx/moments/flood/vfx_nh90_dstry_smk_fall");
  level._effect["vfx_nh90_dstry_smk_break"] = loadfx("vfx/moments/flood/vfx_nh90_dstry_smk_break");
  level._effect["vfx_nh90_dstry_smk_fiery"] = loadfx("vfx/moments/flood/vfx_nh90_dstry_smk_fiery");
  level._effect["vfx_nh90_dstry_smk_01"] = loadfx("vfx/moments/flood/vfx_nh90_dstry_smk_01");
  level._effect["vfx_lens_flare_sun"] = loadfx("vfx/ambient/lights/vfx_lens_flare_sun");
  level._effect["vfx_parking_garage_collapse_sm"] = loadfx("vfx/moments/flood/vfx_parking_garage_collapse_sm");
  level._effect["vfx_parking_garage_collapse"] = loadfx("vfx/moments/flood/vfx_parking_garage_collapse");
  level._effect["vfx_warehouse_mist"] = loadfx("vfx/moments/flood/vfx_warehouse_mist");
  level._effect["vfx_sparks_sign_02"] = loadfx("vfx/ambient/sparks/vfx_sparks_sign_02");
  level._effect["vfx_smolder_fire_sm"] = loadfx("vfx/moments/flood/vfx_smolder_fire_sm");
  level._effect["vfx_smk_rubble_ember"] = loadfx("vfx/ambient/smoke/vfx_smk_rubble_ember");
  level._effect["flood_ground_smoke_drk"] = loadfx("vfx/moments/flood/flood_ground_smoke_drk");
  level._effect["vfx_tank_fireball_smk"] = loadfx("vfx/moments/flood/vfx_tank_fireball_smk");
  level._effect["vfx_flesh_flood_exit"] = loadfx("vfx/moments/flood/vfx_flesh_flood_exit");
  level._effect["flood_nh90_cabin_crash_smk"] = loadfx("vfx/moments/flood/flood_nh90_cabin_crash_smk");
  level._effect["flood_glass_shatter_small"] = loadfx("vfx/moments/flood/flood_glass_shatter_small");
  level._effect["flood_moving_cabin_dust"] = loadfx("vfx/moments/flood/flood_moving_cabin_dust");
  level._effect["vfx_nh90_cabin_smoke"] = loadfx("vfx/ambient/smoke/vfx_nh90_cabin_smoke");
  level._effect["small_metalhit_1_efx_now"] = loadfx("fx/impacts/small_metalhit_1_efx_now");
  level._effect["vfx_flesh_head_spawn"] = loadfx("vfx/moments/flood/vfx_flesh_head_spawn");
  level._effect["vfx_muz_pis_w"] = loadfx("vfx/gameplay/muzzle_flashes/pis/vfx_muz_pis_w");
  level._effect["vfx_muz_ar_v"] = loadfx("vfx/gameplay/muzzle_flashes/ar/vfx_muz_ar_v");
  level._effect["dust_puff_light_fast_16_03"] = loadfx("vfx/ambient/dust/dust_puff_light_fast_16_03");
  level._effect["flood_m880_afterburn_smkfix"] = loadfx("vfx/moments/flood/flood_m880_afterburn_smkfix");
  level._effect["flood_m880_afterburn_tip"] = loadfx("vfx/moments/flood/flood_m880_afterburn_tip");
  level._effect["flood_m880_ground_debris_emit"] = loadfx("vfx/moments/flood/flood_m880_ground_debris_emit");
  level._effect["flood_m880_ground_debris"] = loadfx("vfx/moments/flood/flood_m880_ground_debris");
  level._effect["vfx_scrnfx_fiery_bokeh_flash_01"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_fiery_bokeh_flash_01");
  level._effect["m880_exhaust_smk_wisp"] = loadfx("vfx/moments/flood/m880_exhaust_smk_wisp");
  level._effect["flood_integration_foamsplash_bc"] = loadfx("vfx/moments/flood/flood_integration_foamsplash_bc");
  level._effect["flood_integration_foamsplash_man7t"] = loadfx("vfx/moments/flood/flood_integration_foamsplash_man7t");
  level._effect["flood_water_sidewalk_splash"] = loadfx("vfx/moments/flood/flood_water_sidewalk_splash");
  level._effect["flood_hand_outsplash"] = loadfx("vfx/moments/flood/flood_hand_outsplash");
  level._effect["scrnfx_water_splash_high_02"] = loadfx("vfx/gameplay/screen_effects/scrnfx_water_splash_high_02");
  level._effect["water_waterline_emerge_01"] = loadfx("vfx/moments/flood/water_waterline_emerge_01");
  level._effect["flood_water_alley_wallsplash_lrg"] = loadfx("vfx/moments/flood/flood_water_alley_wallsplash_lrg");
  level._effect["mall_floating_debri_med2"] = loadfx("vfx/moments/flood/mall_floating_debri_med2");
  level._effect["mall_floating_debri_med"] = loadfx("vfx/moments/flood/mall_floating_debri_med");
  level._effect["splash_line_runner"] = loadfx("vfx/moments/flood/splash_line_runner");
  level._effect["edge_splashes_line"] = loadfx("vfx/moments/flood/edge_splashes_line");
  level._effect["flood_drips_big"] = loadfx("vfx/moments/flood/flood_drips_big");
  level._effect["flood_character_drips_big_pool"] = loadfx("vfx/moments/flood/flood_character_drips_big_pool");
  level._effect["flood_character_drips_child"] = loadfx("vfx/moments/flood/flood_character_drips_child");
  level._effect["floodwater_splash_small_01"] = loadfx("vfx/ambient/water/floodwater_splash_small_01");
  level._effect["edge_splashes_roil_left"] = loadfx("vfx/ambient/water/edge_splashes_roil_left");
  level._effect["floodwater_splash_large_02"] = loadfx("vfx/ambient/water/floodwater_splash_large_02");
  level._effect["edge_splashes_roil"] = loadfx("vfx/ambient/water/edge_splashes_roil");
  level._effect["flood_particulate_in_light_large"] = loadfx("fx/water/flood_particulate_in_light_large");
  level._effect["bubbles_stream_large_slow"] = loadfx("vfx/ambient/water/bubbles_stream_large_slow");
  level._effect["swept_floating_debri_large"] = loadfx("vfx/moments/flood/swept_floating_debri_large");
  level._effect["dunk_bubbles_runner"] = loadfx("vfx/moments/flood/dunk_bubbles_runner");
  level._effect["flood_mr_falling_dust_debri_nosmk"] = loadfx("vfx/moments/flood/flood_mr_falling_dust_debri_nosmk");
  level._effect["flood_mr_falling_dust_debri_slight"] = loadfx("vfx/moments/flood/flood_mr_falling_dust_debri_slight");
  level._effect["bubbles_leak_vent_02"] = loadfx("vfx/ambient/water/bubbles_leak_vent_02");
  level._effect["bubbles_stream_large"] = loadfx("vfx/ambient/water/bubbles_stream_large");
  level._effect["surface_bubble_sheet"] = loadfx("vfx/test/surface_bubble_sheet");
  level._effect["vfx_warehouse_door_splashes_lrg_dark"] = loadfx("vfx/moments/flood/vfx_warehouse_door_splashes_lrg_dark");
  level._effect["vfx_warehouse_water_burst_02"] = loadfx("vfx/moments/flood/vfx_warehouse_water_burst_02");
  level._effect["vfx_warehouse_water_stream_sml"] = loadfx("vfx/moments/flood/vfx_warehouse_water_stream_sml");
  level._effect["vfx_warehouse_water_burst_01"] = loadfx("vfx/moments/flood/vfx_warehouse_water_burst_01");
  level._effect["flood_water_alley_fill_shallow"] = loadfx("vfx/moments/flood/flood_water_alley_fill_shallow");
  level._effect["flood_water_alley_fill_shallow_left"] = loadfx("vfx/moments/flood/flood_water_alley_fill_shallow_left");
  level._effect["flood_dam_water_pre_fall"] = loadfx("vfx/moments/flood/flood_dam_water_pre_fall");
  level._effect["flood_warehouse_lip_cascade_debris"] = loadfx("vfx/moments/flood/flood_warehouse_lip_cascade_debris");
  level._effect["flood_warehouse_floating_debri_03"] = loadfx("vfx/moments/flood/flood_warehouse_floating_debri_03");
  level._effect["flood_warehouse_floating_debri_03_top"] = loadfx("vfx/moments/flood/flood_warehouse_floating_debri_03_top");
  level._effect["flood_floating_paper_slow2"] = loadfx("vfx/moments/flood/flood_floating_paper_slow2");
  level._effect["flood_particlulates_03"] = loadfx("vfx/moments/flood/flood_particlulates_03");
  level._effect["flood_warehouse_floating_debri_02"] = loadfx("vfx/moments/flood/flood_warehouse_floating_debri_02");
  level._effect["flood_warehouse_floating_debri_02_top"] = loadfx("vfx/moments/flood/flood_warehouse_floating_debri_02_top");
  level._effect["flood_warehouse_floating_debri_01"] = loadfx("vfx/moments/flood/flood_warehouse_floating_debri_01");
  level._effect["flood_warehouse_floating_debri_01_top"] = loadfx("vfx/moments/flood/flood_warehouse_floating_debri_01_top");
  level._effect["vfx_warehouse_big_door_steam_01"] = loadfx("vfx/moments/flood/vfx_warehouse_big_door_steam_01");
  level._effect["vfx_warehouse_door_splashes_sml"] = loadfx("vfx/moments/flood/vfx_warehouse_door_splashes_sml");
  level._effect["vfx_warehouse_door_splashes_lrg"] = loadfx("vfx/moments/flood/vfx_warehouse_door_splashes_lrg");
  level._effect["vfx_warehouse_lip_froth_01"] = loadfx("vfx/moments/flood/vfx_warehouse_lip_froth_01");
  level._effect["vfx_warehouse_lip_water"] = loadfx("vfx/moments/flood/vfx_warehouse_lip_water");
  level._effect["mall_rooftop_updust_01_runner"] = loadfx("vfx/moments/flood/mall_rooftop_updust_01_runner");
  level._effect["flood_mr_debri_explosion_small"] = loadfx("vfx/moments/flood/flood_mr_debri_explosion_small");
  level._effect["flood_mr_opfor_splashes_runner"] = loadfx("vfx/moments/flood/flood_mr_opfor_splashes_runner");
  level._effect["flood_mr_opfor_splashes"] = loadfx("vfx/moments/flood/flood_mr_opfor_splashes");
  level._effect["flood_mr_splash_med"] = loadfx("vfx/moments/flood/flood_mr_splash_med");
  level._effect["big_sparks_no_col"] = loadfx("vfx/moments/big_sparks_no_col");
  level._effect["big_sparks"] = loadfx("vfx/moments/big_sparks");
  level._effect["flood_dust_debri_frequent_runner"] = loadfx("vfx/moments/flood/flood_dust_debri_frequent_runner");
  level._effect["flood_dust_debri_slight_runner"] = loadfx("vfx/moments/flood/flood_dust_debri_slight_runner");
  level._effect["flood_mr_dust_runner"] = loadfx("vfx/moments/flood/flood_mr_dust_runner");
  level._effect["flood_mr_falling_dust_debri"] = loadfx("vfx/moments/flood/flood_mr_falling_dust_debri");
  level._effect["flood_integration_foamsplash_med_dropper"] = loadfx("vfx/moments/flood/flood_integration_foam_med_dropper");
  level._effect["flood_small_sparks_runner_frequent"] = loadfx("vfx/moments/flood/flood_small_sparks_runner_frequent");
  level._effect["skybridge_crush_dust_emit"] = loadfx("vfx/moments/flood/skybridge_crush_dust_emit");
  level._effect["flood_small_sparks_runner"] = loadfx("vfx/moments/flood/flood_small_sparks_runner");
  level._effect["small_sparks"] = loadfx("vfx/moments/flood/small_sparks");
  level._effect["flood_glass_shatter"] = loadfx("vfx/moments/flood/flood_glass_shatter");
  level._effect["flood_dust_hit_medium_glass"] = loadfx("vfx/moments/flood/flood_dust_hit_medium_glass");
  level._effect["flood_dust_hit_medium"] = loadfx("vfx/moments/flood/flood_dust_hit_medium");
  level._effect["flood_dust_hit_large"] = loadfx("vfx/moments/flood/flood_dust_hit_large");
  level._effect["flood_falling_debri_splash_med"] = loadfx("vfx/moments/flood/flood_falling_debri_splash_med");
  level._effect["flood_integration_foam_med_dropper"] = loadfx("vfx/moments/flood/flood_integration_foamsplash_med_dropper");
  level._effect["flood_integration_foam_bus_dropper"] = loadfx("vfx/moments/flood/flood_integration_foam_bus_dropper");
  level._effect["flood_integration_foam_dropper"] = loadfx("vfx/moments/flood/flood_integration_foam_dropper");
  level._effect["flood_integration_foam_small"] = loadfx("vfx/moments/flood/flood_integration_foam_small");
  level._effect["flood_dam_hit_smoke"] = loadfx("vfx/moments/flood/flood_dam_hit_smoke");
  level._effect["flood_m880_low_smk"] = loadfx("vfx/moments/flood/flood_m880_low_smk");
  level._effect["flesh_hit_knife"] = loadfx("fx/impacts/flesh_hit_knife");
  level._effect["m880_exp_up"] = loadfx("vfx/moments/flood/m880_exp_up");
  level._effect["flood_dust_hit"] = loadfx("vfx/moments/flood/flood_dust_hit");
  level._effect["flood_flare_outdoor_small"] = loadfx("vfx/moments/flood/flood_flare_outdoor_small");
  level._effect["flood_flare_wh_emergency"] = loadfx("vfx/moments/flood/flood_flare_wh_emergency");
  level._effect["flood_flare_wh_doorbreak"] = loadfx("vfx/moments/flood/flood_flare_wh_doorbreak");
  level._effect["vfx_fire_wall_small"] = loadfx("vfx/ambient/fire/wall/vfx_fire_wall_small");
  level._effect["tank_exp_compressed"] = loadfx("vfx/moments/flood/tank_exp_compressed");
  level._effect["transformer_explosion"] = loadfx("fx/explosions/transformer_explosion");
  level._effect["flood_pole_hit"] = loadfx("vfx/moments/flood/flood_pole_hit");
  level._effect["flood_vignette_dust_runner"] = loadfx("vfx/moments/flood/flood_vignette_dust_runner");
  level._effect["flood_vignette_dust"] = loadfx("vfx/moments/flood/flood_vignette_dust");
  level._effect["flood_vignette_sparks_runner"] = loadfx("vfx/moments/flood/flood_vignette_sparks_runner");
  level._effect["flood_m880_tire_dust"] = loadfx("vfx/moments/flood/flood_m880_tire_dust");
  level._effect["amb_dust_light_small_mixlit"] = loadfx("fx/dust/amb_dust_light_small_mixlit");
  level._effect["flood_falling_sparks_runner"] = loadfx("vfx/moments/flood/flood_falling_sparks_runner");
  level._effect["flood_water_ceiling_pour_lrg"] = loadfx("vfx/moments/flood/flood_water_ceiling_pour_lrg");
  level._effect["flood_water_ceiling_pour_sm"] = loadfx("vfx/moments/flood/flood_water_ceiling_pour_sm");
  level._effect["flood_water_ceiling_pour_medium"] = loadfx("vfx/moments/flood/flood_water_ceiling_pour_medium");
  level._effect["flood_ground_smoke"] = loadfx("vfx/moments/flood/flood_ground_smoke");
  level._effect["vfx_crater_dust_medium"] = loadfx("vfx/ambient/atmospheric/vfx_crater_dust_medium");
  level._effect["flood_tank_window_break"] = loadfx("vfx/moments/flood/flood_tank_window_break");
  level._effect["planter_explode"] = loadfx("vfx/moments/flood/planter_explode");
  level._effect["streetlight_flare_yellow"] = loadfx("vfx/ambient/props/streetlight_flare_yellow");
  level._effect["flood_tank_tank_crush"] = loadfx("vfx/moments/flood/flood_tank_tank_crush");
  level._effect["tank_fire_ground_dust"] = loadfx("vfx/moments/flood/tank_fire_ground_dust");
  level._effect["flood_infil_heli_dust_large"] = loadfx("vfx/moments/flood/flood_infil_heli_dust_large");
  level._effect["flood_intro_heli_smoke"] = loadfx("vfx/moments/flood/flood_intro_heli_smoke");
  level._effect["light_car_wide_underwater"] = loadfx("vfx/ambient/lights/light_car_wide_underwater");
  level._effect["lynx_brakelight"] = loadfx("vfx/moments/flood/lynx_brakelight");
  level._effect["flood_floating_bottles_slow"] = loadfx("vfx/moments/flood/flood_floating_bottles_slow");
  level._effect["flood_floating_paper_slow"] = loadfx("vfx/moments/flood/flood_floating_paper_slow");
  level._effect["flood_underwater_godrays"] = loadfx("vfx/moments/flood/flood_underwater_godrays");
  level._effect["flood_particlulates_light_02"] = loadfx("vfx/moments/flood/flood_particlulates_light_02");
  level._effect["flood_particlulates_02"] = loadfx("vfx/moments/flood/flood_particlulates_02");
  level._effect["vfx_fire_wall_medium"] = loadfx("vfx/ambient/fire/wall/vfx_fire_wall_medium");
  level._effect["flood_steam_floor_vent_low"] = loadfx("vfx/moments/flood/flood_steam_floor_vent_low");
  level._effect["smk_perif_oriented_smaller_02"] = loadfx("vfx/ambient/smoke/smk_perif_oriented_smaller_02");
  level._effect["vfx_embers_oriented_small"] = loadfx("vfx/ambient/sparks/vfx_embers_oriented_small");
  level._effect["flood_bomb_flash_large"] = loadfx("vfx/moments/flood/flood_bomb_flash_large");
  level._effect["flood_bombing_run_dist_runner"] = loadfx("vfx/moments/flood/flood_bombing_run_dist_runner");
  level._effect["flood_periph_plumes"] = loadfx("vfx/moments/flood/flood_periph_plumes");
  level._effect["flood_periph_plume"] = loadfx("vfx/moments/flood/flood_periph_plume");
  level._effect["flash_large"] = loadfx("vfx/moments/flood/flash_large");
  level._effect["tank_concrete_explosion_omni"] = loadfx("vfx/gameplay/explosions/tank_concrete_explosion_omni");
  level._effect["garage_explosion_flash"] = loadfx("vfx/moments/flood/flash_large");
  level._effect["smk_perif_oriented_small_obscure"] = loadfx("vfx/ambient/smoke/smk_perif_oriented_small_obscure");
  level._effect["cloud_ash_lite_flood"] = loadfx("vfx/moments/flood/cloud_ash_lite_flood");
  level._effect["vfx_fire_burning_fuel_tank_nosmk"] = loadfx("vfx/ambient/fire/fuel/vfx_fire_burning_fuel_tank_nosmk");
  level._effect["smk_perif_oriented_smaller_01"] = loadfx("vfx/ambient/smoke/smk_perif_oriented_smaller_01");
  level._effect["battle_dust_fast_small"] = loadfx("fx/dust/battle_dust_fast_small");
  level._effect["smk_perif_oriented_small_01"] = loadfx("vfx/ambient/smoke/smk_perif_oriented_small_01");
  level._effect["vfx_fire_wall_lg_far"] = loadfx("vfx/ambient/fire/wall/vfx_fire_wall_lg_far");
  level._effect["infil_ground_smk_plume"] = loadfx("vfx/moments/flood/infil_ground_smk_plume");
  level._effect["infil_building_smoke"] = loadfx("vfx/moments/flood/infil_building_smoke");
  level._effect["smk_street_fog_low"] = loadfx("vfx/ambient/smoke/smk_street_fog_low");
  level._effect["battle_dust_medium"] = loadfx("fx/dust/battle_dust_medium");
  level._effect["rooftop1_stairwell_dust"] = loadfx("vfx/moments/flood/rooftop1_stairwell_dust");
  level._effect["flood_skybridge_build_fallingdust_runner"] = loadfx("vfx/moments/flood/flood_skybridge_build_fallingdust_runner");
  level._effect["amb_dust_dark_building_smolder_small"] = loadfx("fx/dust/amb_dust_dark_building_smolder_small");
  level._effect["amb_dust_dark_building_smolder"] = loadfx("fx/dust/amb_dust_dark_building_smolder");
  level._effect["rooftop1_heli_dust_kickup"] = loadfx("vfx/moments/flood/rooftop1_heli_dust_kickup");
  level._effect["area_splash_20x20_runner"] = loadfx("vfx/ambient/weather/rain/area_splash_20x20_runner");
  level._effect["flood_mist_static_sparkle"] = loadfx("vfx/moments/flood/flood_mist_static_sparkle");
  level._effect["sunglow_huge"] = loadfx("vfx/ambient/lights/sunglow_huge");
  level._effect["rapids_splash_lg_flood"] = loadfx("vfx/moments/flood/rapids_splash_lg_flood");
  level._effect["flood_mist_low_01"] = loadfx("vfx/moments/flood/flood_mist_low_01");
  level._effect["rooftop1_heli_debris_kickup"] = loadfx("vfx/moments/flood/rooftop1_heli_debris_kickup");
  level._effect["gust_debris_pieces"] = loadfx("vfx/ambient/misc/gust_debris_pieces");
  level._effect["rooftop_1_wall_kick_dust"] = loadfx("vfx/moments/flood/rooftop_1_wall_kick_dust");
  level._effect["flood_rooftops_fallingdust_runner"] = loadfx("vfx/moments/flood/flood_rooftops_fallingdust_runner");
  level._effect["blood_stealth_hatchet"] = loadfx("vfx/moments/flood/blood_stealth_hatchet");
  level._effect["intro_blood_throat_stab"] = loadfx("fx/maps/warlord/intro_blood_throat_stab");
  level._effect["flood_swept_body_bubbles"] = loadfx("vfx/moments/flood/flood_swept_body_bubbles");
  level._effect["bubbles_player_hand"] = loadfx("vfx/moments/flood/flood_swept_body_bubbles");
  level._effect["flood_swept_flashlight"] = loadfx("vfx/moments/flood/flood_swept_flashlight");
  level._effect["debri_bubbles_emit"] = loadfx("vfx/moments/flood/debri_bubbles_emit");
  level._effect["debri_bubbles"] = loadfx("vfx/moments/flood/debri_bubbles");
  level._effect["flood_splash_lg_r"] = loadfx("vfx/moments/flood/flood_splash_lg_r");
  level._effect["flood_mr_debri_explosion_up"] = loadfx("vfx/moments/flood/flood_mr_debri_explosion_up");
  level._effect["flood_hand_bubbles"] = loadfx("vfx/moments/flood/flood_hand_bubbles");
  level._effect["warehouse_doorbreach_cover_splashes"] = loadfx("vfx/moments/flood/warehouse_doorbreach_cover_splashes");
  level._effect["flood_mr_debri_explosion"] = loadfx("vfx/moments/flood/flood_mr_debri_explosion");
  level._effect["mall_rooftop_door_glow"] = loadfx("vfx/moments/flood/mall_rooftop_door_glow");
  level._effect["mall_rooftop_door_godray"] = loadfx("vfx/moments/flood/mall_rooftop_door_godray");
  level._effect["mall_rooftop_updust_01"] = loadfx("vfx/moments/flood/mall_rooftop_updust_01");
  level._effect["mall_rooftop_collapse_dust_huge_01"] = loadfx("vfx/moments/flood/mall_rooftop_collapse_dust_huge_01");
  level._effect["mall_rooftop_crack_splash_runner"] = loadfx("vfx/moments/flood/mall_rooftop_crack_splash_runner");
  level._effect["warehouse_doorbreach_splash"] = loadfx("vfx/moments/flood/warehouse_doorbreach_splash");
  level._effect["warehouse_doorbreach_smoke"] = loadfx("vfx/moments/flood/warehouse_doorbreach_smoke");
  level._effect["smk_wispy_thin_low_short"] = loadfx("vfx/moments/flood/smk_wispy_thin_low_short");
  level._effect["smk_wispy_thin"] = loadfx("vfx/moments/flood/smk_wispy_thin");
  level._effect["mall_rooftop_steam"] = loadfx("vfx/moments/flood/mall_rooftop_steam");
  level._effect["m880_red_glow"] = loadfx("vfx/moments/flood/m880_red_glow");
  level._effect["mall_rooftop_rapids_splashes"] = loadfx("vfx/moments/flood/mall_rooftop_rapids_splashes");
  level._effect["mall_rooftop_rumble_smoke"] = loadfx("vfx/moments/flood/mall_rooftop_rumble_smoke");
  level._effect["mall_rooftop_collapse_dust_medium"] = loadfx("vfx/moments/flood/mall_rooftop_collapse_dust_medium");
  level._effect["mall_rooftop_crush_dust_emit"] = loadfx("vfx/moments/flood/mall_rooftop_crush_dust_emit");
  level._effect["mall_rooftop_dust_linger"] = loadfx("vfx/moments/flood/mall_rooftop_dust_linger");
  level._effect["flood_stairwell_falling_dust"] = loadfx("vfx/moments/flood/flood_stairwell_falling_dust");
  level._effect["mall_rooftop_crush_dust"] = loadfx("vfx/moments/flood/mall_rooftop_crush_dust");
  level._effect["flood_m880_hand_dust"] = loadfx("vfx/moments/flood/flood_m880_hand_dust");
  level._effect["randomfan_small"] = loadfx("vfx/ambient/lights/randomfan_small");
  level._effect["warmglow"] = loadfx("vfx/ambient/lights/warmglow");
  level._effect["drips_fast"] = loadfx("vfx/moments/flood/flood_drips_fast");
  level._effect["drips_slow_infrequent"] = loadfx("vfx/moments/flood/flood_drips_slow_infrequent");
  level._effect["flood_dam_water_falling_02"] = loadfx("vfx/moments/flood/flood_dam_water_falling_02");
  level._effect["flood_dam_water_explosion"] = loadfx("vfx/moments/flood/flood_dam_water_explosion");
  level._effect["birds_flood_street_birds_01"] = loadfx("vfx/moments/flood/birds_flood_street_birds_01");
  level._effect["flood_m880_missile_begin"] = loadfx("vfx/moments/flood/flood_m880_missile_begin");
  level._effect["flood_dam_hit_explosion_cheap"] = loadfx("vfx/moments/flood/flood_dam_hit_explosion_cheap");
  level._effect["flood_dam_hit_explosion"] = loadfx("vfx/moments/flood/flood_dam_hit_explosion");
  level._effect["flood_m880_launch_falling_dust_02"] = loadfx("vfx/moments/flood/flood_m880_launch_falling_dust_02");
  level._effect["flood_m880_launch_dust_linger"] = loadfx("vfx/moments/flood/flood_m880_launch_dust_linger");
  level._effect["flood_m880_exhaust_02"] = loadfx("vfx/moments/flood/flood_m880_exhaust_02");
  level._effect["small_water_splash"] = loadfx("fx/water/flood_splash_small");
  level._effect["small_water_splash_fast"] = loadfx("fx/water/flood_splash_small_fast");
  level._effect["medium_water_splash"] = loadfx("fx/water/flood_splash_medium");
  level._effect["giant_water_splash"] = loadfx("vfx/moments/flood/flood_street_giant_water_splash");
  level._effect["flood_m880_exhaust"] = loadfx("vfx/moments/flood/flood_m880_exhaust");
  level._effect["flood_m880_dust"] = loadfx("vfx/moments/flood/flood_m880_dust");
  level._effect["flood_m880_launch_falling_dust"] = loadfx("vfx/moments/flood/flood_m880_launch_falling_dust");
  level._effect["godray_large_01"] = loadfx("vfx/ambient/misc/godray_large_01");
  level._effect["flood_m880_missile_trail_01"] = loadfx("vfx/moments/flood/flood_m880_missile_trail_01");
  level._effect["flood_m880_afterburn_ignite"] = loadfx("vfx/moments/flood/flood_m880_afterburn_ignite");
  level._effect["flood_dam_event_base_mist"] = loadfx("fx/water/flood_dam_event_base_mist");
  level._effect["flood_dam_event_alley_mist"] = loadfx("fx/water/flood_dam_event_alley_mist");
  level._effect["flood_dam_event_street_mist2"] = loadfx("fx/water/flood_dam_event_street_mist2");
  level._effect["flood_dam_event_street_splash_lp"] = loadfx("fx/water/flood_dam_event_street_splash_lp");
  level._effect["flood_dam_event_street_splash_shadow_lp"] = loadfx("fx/water/flood_dam_event_street_splash_shadow_lp");
  level._effect["flood_dam_event_bigwave_splash_lp"] = loadfx("fx/water/flood_dam_event_bigwave_splash_lp");
  level._effect["flood_street_splash_large_01"] = loadfx("vfx/moments/flood/flood_street_splash_large_01");
  level._effect["flood_street_splash_front_rolling"] = loadfx("vfx/moments/flood/flood_street_splash_front_rolling");
  level._effect["flood_alley_splash_front_rolling"] = loadfx("vfx/moments/flood/flood_alley_splash_front_rolling");
  level._effect["flood_splash_small_lp"] = loadfx("fx/water/flood_splash_small_lp");
  level._effect["flood_paper_blowing_cards"] = loadfx("vfx/moments/flood/flood_paper_blowing_cards");
  level._effect["flood_warehouse_ally_mantle"] = loadfx("vfx/moments/flood/flood_warehouse_ally_mantle");
  level._effect["flood_splash_alley_front"] = loadfx("fx/water/flood_splash_alley_front");
  level._effect["flood_splash_alley_reverse"] = loadfx("fx/water/flood_splash_alley_reverse");
  level._effect["water_emerge_weapon"] = loadfx("vfx/moments/flood/flood_water_emerge_weapon");
  level._effect["character_drips"] = loadfx("vfx/moments/flood/flood_character_drips");
  level._effect["antiair_runner_flak"] = loadfx("fx/misc/antiair_runner_flak");
  level._effect["rpg_trail"] = loadfx("fx/smoke/smoke_geotrail_rpg");
  level._effect["car_glass_large"] = loadfx("fx/props/car_glass_large");
  level._effect["pipe_steam"] = loadfx("fx/impacts/pipe_steam");
  level._effect["battle_dust_huge_01"] = loadfx("fx/dust/battle_dust_huge_01");
  level._effect["amb_dust_light_large_mixlit"] = loadfx("fx/dust/amb_dust_light_large_mixlit");
  level._effect["flesh_hit"] = loadfx("fx/impacts/flesh_hit");
  level._effect["tank_concrete_explosion"] = loadfx("vfx/gameplay/explosions/impacts/vfx_tank_concrete_explosion");
  level._effect["flooded_player_bubbles"] = loadfx("fx/water/flooded_player_bubbles");
  level._effect["flashlight"] = loadfx("fx/misc/flashlight");
  level._effect["building_collapse_smoke_lg"] = loadfx("fx/smoke/building_collapse_smoke_lg");
  level._effect["sparks_runner"] = loadfx("fx/explosions/sparks_runner");
  level._effect["bokehdots_far"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_bokehdots_inst_far");
  level._effect["bokehdots_close"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_bokehdots_inst_close");
  level._effect["bokehdots_16"] = loadfx("vfx/gameplay/screen_effects/scrnfx_water_bokeh_dots_inst_16");
  level._effect["bokehdots_32"] = loadfx("vfx/gameplay/screen_effects/scrnfx_water_bokeh_dots_inst_32");
  level._effect["bokehdots_64"] = loadfx("vfx/gameplay/screen_effects/scrnfx_water_bokeh_dots_inst_64");
  level._effect["waterdrops_3"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_waterdrops_3");
  level._effect["waterdrops_20_inst"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_waterdrops_20_inst");
  level._effect["bokehdots_and_waterdrops_heavy"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_bokehwater_heavy");
  level._effect["chopper_countermeasure"] = loadfx("vfx/moments/flood/flood_m880_missile_trail_01");
  level.playangryfloodvfx = 1;
  maps\_utility::set_vision_set("flood", 0);
  maps\_utility::fog_set_changes("flood", 0);
  level.cw_bloom_above = "flood_bloom";
  level.cw_vision_above = "flood";
  level.cw_fog_above = "flood";

  if(!getdvarint("r_reflectionProbeGenerate")) {
    maps\createfx\flood_fx::main();
    maps\createfx\flood_sound::main();
  }

  thread fx_vision_fog_init();
  thread fx_mall_roof_water_hide();
  thread fx_rooftops_water_hide();
  thread fx_swept_water_hide();
  thread fx_dam_waterfall_hide();
  thread set_enter_skybridge_room_vf();
  thread freon_leak_fx_turn_off_damage();
  thread rooftop_01_misc_fx();
  thread fx_skybridge_room_bokeh_01();
  thread fx_skybridge_room_bokeh_02();
  thread fx_retarget_warehouse_waters_lighting();
  thread fx_retarget_rooftop_water_lighting();
  thread trigger_debris_bridge_water();
  thread fx_set_alpha_threshold();
  thread fx_create_sunflare_source();
  thread fx_parking_garage_hide_godrays();
  thread fx_lens_drops_01();
  thread fx_lens_drops_02();
  thread fx_lens_drops_03();
  thread fx_lens_drops_04();
  thread fx_lens_drops_05();
  thread fx_footstep_override();
  setup_flood_water_anims();
}

fx_footstep_override() {
  animscripts\utility::setfootstepeffect("snow", loadfx("vfx/ambient/misc/no_effect"));
  animscripts\utility::setfootstepeffectsmall("snow", loadfx("vfx/ambient/misc/no_effect"));
}

flood_amb_fx() {
  common_scripts\utility::exploder("10523");
  common_scripts\utility::exploder("infil_smoke");
}

fx_set_alpha_threshold() {
  if(maps\_utility::is_gen4())
    setsaveddvar("fx_alphathreshold", 2);
  else
    setsaveddvar("fx_alphathreshold", 9);
}

freon_leak_fx_turn_off_damage() {
  level.pipesdamage = 0;
}

fx_checkpoint_states() {
  waittillframeend;
  var_0 = level.start_point;

  if(maps\_utility::is_default_start()) {
    thread infil_explosions();
    common_scripts\utility::exploder("flak");
    maps\_utility::stop_exploder("ending_smk_plume");
    return;
  }

  if(var_0 == "streets") {
    thread infil_explosions();
    common_scripts\utility::exploder("flak");
    maps\_utility::stop_exploder("ending_smk_plume");
    maps\_utility::stop_exploder("dam_pre_waterfall");
    return;
  }

  if(var_0 == "streets_to_dam") {
    thread infil_explosions();
    common_scripts\utility::exploder("flak");
    maps\_utility::stop_exploder("ending_smk_plume");
    common_scripts\utility::exploder("dam_pre_waterfall");
    return;
  }

  if(var_0 == "streets_to_dam_2") {
    common_scripts\utility::exploder("flak");
    common_scripts\utility::exploder("m880_crash_fx");
    maps\_utility::stop_exploder("ending_smk_plume");
    common_scripts\utility::exploder("dam_pre_waterfall");
    return;
  }

  if(var_0 == "dam") {
    maps\_utility::stop_exploder("flak");
    maps\_utility::stop_exploder("ending_smk_plume");
    common_scripts\utility::exploder("intro_amb_fx");
    common_scripts\utility::exploder("dam_pre_waterfall");
    return;
  }

  if(var_0 == "flooding_ext") {
    maps\_utility::stop_exploder("flak");
    maps\_utility::stop_exploder("intro_amb_fx");
    maps\_utility::stop_exploder("ending_smk_plume");
    maps\_utility::stop_exploder("dam_pre_waterfall");
    return;
  }

  if(var_0 == "flooding_int") {
    maps\_utility::stop_exploder("flak");
    maps\_utility::stop_exploder("intro_amb_fx");
    maps\_utility::stop_exploder("dam_pre_waterfall");
    maps\_utility::stop_exploder("ending_smk_plume");
    maps\_utility::set_vision_set("flood_warehouse", 0);
    thread fx_retarget_warehouse_waters_lighting();
    return;
  }

  if(var_0 == "mall") {
    maps\_utility::stop_exploder("flak");
    maps\_utility::stop_exploder("intro_amb_fx");
    maps\_utility::stop_exploder("dam_pre_waterfall");
    maps\_utility::stop_exploder("ending_smk_plume");
    maps\_utility::set_vision_set("flood_stairs", 0);
    return;
  }

  if(var_0 == "swept") {
    maps\_utility::stop_exploder("flak");
    maps\_utility::stop_exploder("intro_amb_fx");
    maps\_utility::stop_exploder("dam_pre_waterfall");
    maps\_utility::stop_exploder("ending_smk_plume");
    maps\_utility::stop_exploder("huge_plume");
    common_scripts\utility::exploder("huge_plume_swept");
    common_scripts\utility::exploder("swept_under_fx");
    common_scripts\utility::exploder("rooftops_amb_fx");
    maps\_utility::set_vision_set("flood_two", 0);
    return;
  }

  if(var_0 == "roof_stealth") {
    maps\_utility::stop_exploder("flak");
    maps\_utility::stop_exploder("intro_amb_fx");
    maps\_utility::stop_exploder("dam_pre_waterfall");
    maps\_utility::stop_exploder("ending_smk_plume");
    maps\_utility::stop_exploder("huge_plume");
    maps\_utility::stop_exploder("swept_under_fx");
    maps\_utility::set_vision_set("flood_stealth", 0);
    return;
  }

  if(var_0 == "skybridge") {
    maps\_utility::stop_exploder("flak");
    maps\_utility::stop_exploder("dam_pre_waterfall");
    maps\_utility::stop_exploder("intro_amb_fx");
    maps\_utility::stop_exploder("ending_smk_plume");
    maps\_utility::stop_exploder("huge_plume");
    maps\_utility::stop_exploder("swept_under_fx");
    common_scripts\utility::exploder("rooftops_amb_fx");
    exit_stealth_misc_fx();
    maps\_utility::set_vision_set("flood_two", 0);
    return;
  }

  if(var_0 == "rooftops") {
    maps\_utility::stop_exploder("flak");
    maps\_utility::stop_exploder("dam_pre_waterfall");
    maps\_utility::stop_exploder("intro_amb_fx");
    common_scripts\utility::exploder("ending_smk_plume");
    common_scripts\utility::exploder("rooftops_amb_fx");
    maps\_utility::stop_exploder("huge_plume");
    maps\_utility::stop_exploder("swept_under_fx");
    exit_stealth_misc_fx();
    thread maps\flood_anim::building_01_debri_anim_spawn();
    return;
  }

  if(var_0 == "rooftop_water") {
    maps\_utility::stop_exploder("flak");
    maps\_utility::stop_exploder("dam_pre_waterfall");
    maps\_utility::stop_exploder("intro_amb_fx");
    common_scripts\utility::exploder("ending_smk_plume");
    common_scripts\utility::exploder("rooftops_amb_fx");
    maps\_utility::stop_exploder("huge_plume");
    maps\_utility::stop_exploder("swept_under_fx");
    exit_stealth_misc_fx();
    return;
  }

  if(var_0 == "debrisbridge") {
    maps\_utility::stop_exploder("flak");
    maps\_utility::stop_exploder("dam_pre_waterfall");
    maps\_utility::stop_exploder("intro_amb_fx");
    common_scripts\utility::exploder("ending_smk_plume");
    common_scripts\utility::exploder("rooftops_amb_fx");
    maps\_utility::stop_exploder("huge_plume");
    maps\_utility::stop_exploder("swept_under_fx");
    return;
  }

  if(var_0 == "garage") {
    maps\_utility::stop_exploder("flak");
    maps\_utility::stop_exploder("dam_pre_waterfall");
    maps\_utility::stop_exploder("intro_amb_fx");
    common_scripts\utility::exploder("ending_smk_plume");
    maps\_utility::stop_exploder("huge_plume");
    maps\_utility::set_vision_set("flood_garage2", 0);
    maps\_utility::stop_exploder("swept_under_fx");
    return;
  }
}

fx_heli_land() {}

infil_explosions() {
  wait 10;
  wait 1;
  wait 2;
  wait 1;
  wait 2;
  wait 1;
  wait 2;
  wait 1;
  wait 2;
  common_scripts\utility::exploder("1");
  wait 1;
  wait 2;
  wait 1;
  wait 2;
  common_scripts\utility::exploder("1");
  wait 3;
  wait 2;
  wait 3;
  wait 2;
  common_scripts\utility::exploder("1");
  wait 1;
  wait 2;
  wait 1;
  wait 5;
  common_scripts\utility::exploder("1");
  wait 12;
  common_scripts\utility::exploder("1");
  wait 12;
  common_scripts\utility::exploder("1");
  wait 12;
  common_scripts\utility::exploder("1");
  wait 12;
  common_scripts\utility::exploder("1");
  wait 12;
  common_scripts\utility::exploder("1");
  wait 12;
  common_scripts\utility::exploder("1");
  wait 12;
  common_scripts\utility::exploder("1");
  wait 12;
  common_scripts\utility::exploder("1");
  wait 12;
  common_scripts\utility::exploder("1");
  wait 12;
  common_scripts\utility::exploder("1");
  wait 12;
  common_scripts\utility::exploder("1");
  wait 12;
  common_scripts\utility::exploder("1");
  wait 12;
  common_scripts\utility::exploder("1");
  wait 12;
  common_scripts\utility::exploder("1");
  wait 12;
  common_scripts\utility::exploder("1");
  wait 12;
  common_scripts\utility::exploder("1");
}

fx_lynx_sparks(var_0) {
  iprintlnbold("got lynx fx");
  common_scripts\utility::exploder("barrel_explosion");
}

fx_tank_window_break() {
  wait 1;
  common_scripts\utility::exploder("tank_window_break");
}

fx_dam_missile_launch_01() {
  maps\_utility::stop_exploder("m880_redlight");
}

fx_dam_missile_afterburn_01() {
  level.player thread maps\_gameskill::grenade_dirt_on_screen("bottom");
  playFXOnTag(common_scripts\utility::getfx("vfx_scrnfx_fiery_bokeh_flash_01"), level.cw_player_view_fx_source, "tag_origin");
}

fx_dam_missile_launch_02() {
  wait 0.5;
  var_0 = level._effect["flood_m880_afterburn_ignite"];
  playFXOnTag(var_0, level.dam_break_m880, "tag_guy01");
}

fx_dam_missile_launch_03() {
  wait 0.5;
  var_0 = level._effect["flood_m880_afterburn_ignite"];
  playFXOnTag(var_0, level.dam_break_m880, "tag_guy03");
}

fx_dam_missile_launch_04() {
  wait 0.5;
  var_0 = level._effect["flood_m880_afterburn_ignite"];
  playFXOnTag(var_0, level.dam_break_m880, "tag_guy02");
}

fx_dam_missile_dust() {
  wait 0.5;
  common_scripts\utility::exploder("m880_dust_linger");
  common_scripts\utility::exploder("m880_dust");
  wait 2;
  common_scripts\utility::exploder("m880_fallingdust");
  common_scripts\utility::exploder("m880_hand_dust");
}

fx_dam_explosion() {
  wait 5.3;
  common_scripts\utility::exploder("dam_hit_explosion");
  maps\_utility::stop_exploder("dam_pre_waterfall");
  wait 3;
  common_scripts\utility::exploder("dam_water_burst");
  wait 2.0;
  wait 0.9;
  var_0 = getent("dam_waterfall", "targetname");
  var_0 show();
  wait 1.5;
  wait 0.5;
  common_scripts\utility::exploder("dam_water_falling");
  common_scripts\utility::exploder("dam_birds_01");
  common_scripts\utility::exploder("dam_mist");
}

fx_dam_waterfall_hide() {
  var_0 = getent("dam_waterfall", "targetname");
  var_0 hide();
}

fx_dam_waterfall_show() {
  var_0 = getent("dam_waterfall", "targetname");
  var_0 show();
}

#using_animtree("script_model");

setup_flood_water_anims() {
  level.scr_animtree["alley_water"] = #animtree;
  level.scr_model["alley_water"] = "flood_alley_flood_water_contig0";
  level.scr_anim["alley_water"]["flood_alleyflood_contig_waterflow0"] = % flood_alleyflood_contig_waterflow0;
  level.scr_animtree["angry_water"] = #animtree;
  level.scr_model["angry_water"] = "flood_angryflood_contig0";
  level.scr_anim["angry_water"]["flood_angryflood_contig_waterflow0"] = % flood_angryflood_contig_waterflow0;
  maps\_anim::addnotetrack_notify("angry_water", "flood_shake_tree_right_1", "flood_shake_tree_right_1", "flood_angryflood_contig_waterflow0");
  maps\_anim::addnotetrack_notify("angry_water", "flood_shake_tree_right_2", "flood_shake_tree_right_2", "flood_angryflood_contig_waterflow0");
  maps\_anim::addnotetrack_notify("angry_water", "flood_shake_tree_right_3", "flood_shake_tree_right_3", "flood_angryflood_contig_waterflow0");
  maps\_anim::addnotetrack_notify("angry_water", "flood_shake_tree_right_4", "flood_shake_tree_right_4", "flood_angryflood_contig_waterflow0");
  maps\_anim::addnotetrack_notify("angry_water", "flood_shake_tree_right_5", "flood_shake_tree_right_5", "flood_angryflood_contig_waterflow0");
  maps\_anim::addnotetrack_notify("angry_water", "flood_shake_tree_right_6", "flood_shake_tree_right_6", "flood_angryflood_contig_waterflow0");
  maps\_anim::addnotetrack_notify("angry_water", "flood_shake_tree_left_1", "flood_shake_tree_left_1", "flood_angryflood_contig_waterflow0");
  maps\_anim::addnotetrack_notify("angry_water", "flood_shake_tree_left_2", "flood_shake_tree_left_2", "flood_angryflood_contig_waterflow0");
  maps\_anim::addnotetrack_notify("angry_water", "flood_shake_tree_left_3", "flood_shake_tree_left_3", "flood_angryflood_contig_waterflow0");
  maps\_anim::addnotetrack_notify("angry_water", "flood_shake_tree_left_4", "flood_shake_tree_left_4", "flood_angryflood_contig_waterflow0");
  maps\_anim::addnotetrack_notify("angry_water", "flood_shake_tree_left_5", "flood_shake_tree_left_5", "flood_angryflood_contig_waterflow0");
  level.scr_animtree["angry_water_leading_edge"] = #animtree;
  level.scr_model["angry_water_leading_edge"] = "flood_angryflood_contig0";
  level.scr_anim["angry_water_leading_edge"]["flood_angryflood_edge_tracker0"] = % flood_angryflood_edge_tracker0;
  level.scr_animtree["angry_water_bigwave_0"] = #animtree;
  level.scr_model["angry_water_bigwave_0"] = "flood_angryflood_edge_tracker_0";
  level.scr_anim["angry_water_bigwave_0"]["flood_angry_flood_bigwave0"] = % flood_angry_flood_bigwave0;
  level.scr_animtree["angry_water_bigwave_1"] = #animtree;
  level.scr_model["angry_water_bigwave_1"] = "flood_angryflood_big_wave_1";
  level.scr_anim["angry_water_bigwave_1"]["flood_angry_flood_bigwave1"] = % flood_angry_flood_bigwave1;
  level.scr_animtree["alley_water_near_trackers"] = #animtree;
  level.scr_model["alley_water_near_trackers"] = "flood_alley_flood_near_trackers";
  level.scr_anim["alley_water_near_trackers"]["flood_alley_flood_near_trackers_anim"] = % flood_alley_flood_near_trackers_anim;
  level.scr_animtree["alley_water_far_trackers"] = #animtree;
  level.scr_model["alley_water_far_trackers"] = "flood_alley_flood_far_trackers";
  level.scr_anim["alley_water_far_trackers"]["flood_alley_flood_far_trackers_anim"] = % flood_alley_flood_far_trackers_anim;
  level.scr_animtree["alley_water_far_water"] = #animtree;
  level.scr_model["alley_water_far_water"] = "flood_alley_flood_far_water";
  level.scr_anim["alley_water_far_water"]["flood_alley_flood_far_water_anim"] = % flood_alley_flood_far_water_anim;
  level.scr_animtree["alley_water_near_water"] = #animtree;
  level.scr_model["alley_water_near_water"] = "flood_alley_flood_near_water";
  level.scr_anim["alley_water_near_water"]["flood_alley_flood_near_water_anim"] = % flood_alley_flood_near_water_anim;
  level.scr_animtree["mall_rooftop_debris"] = #animtree;
  level.scr_model["mall_rooftop_debris"] = "flood_mall_rooftop_wh_debri";
  level.scr_anim["mall_rooftop_debris"]["flood_mall_rooftop_wh_debri0_anim"] = % flood_mall_rooftop_wh_debri0_anim;
  var_0 = getent("angry_flood_water_model", "targetname");
  var_0 hide();
  var_1 = getent("alley_flood_water_model", "targetname");
  var_1 hide();
  var_2 = getent("angry_flood_big_wave_water_model", "targetname");
  var_2 hide();
}

attach_fx_anim_model_street_flood(var_0, var_1, var_2, var_3) {
  var_4 = var_0 gettagorigin(var_2);
  var_5 = var_0 gettagangles(var_2) + (randomint(360), randomint(360), randomint(360));
  var_6 = spawn("script_model", var_4);
  var_6.angles = var_5;
  var_6 setModel(var_1);
  var_6 linkto(var_0, var_2);
  var_6 common_scripts\utility::delaycall(var_3, ::delete);
}

attach_fx_anim_model_mall_debris(var_0, var_1, var_2, var_3, var_4) {
  var_5 = (1235, -839, 115);
  var_6 = var_1 gettagorigin(var_3);
  var_7 = var_1 gettagangles(var_3);
  var_8 = spawn("script_model", var_6);
  var_8.angles = var_7;
  var_8.origin = var_8.origin + (0, 0, var_0);
  var_8 setModel(var_2);
  var_8 linkto(var_1, var_3);

  for(var_9 = 0; var_9 <= var_4; var_9++) {
    if(distance2d(var_5, var_8.origin) >= 2176) {
      var_8 delete();
      break;
    }

    if(var_9 == var_4 && isDefined(var_8))
      var_8 delete();

    wait 1;
  }
}

attach_fx_anim_model_alley_flood(var_0, var_1, var_2, var_3) {
  var_4 = var_0 gettagorigin(var_2);
  var_5 = var_0 gettagangles(var_2) + (randomint(360), randomint(360), randomint(360));
  var_6 = spawn("script_model", var_4);
  var_6.angles = var_5;
  var_6.origin = var_6.origin + (-20, 0, 20);
  var_6 setModel(var_1);
  var_6 linkto(var_0, var_2);
  var_6 common_scripts\utility::delaycall(var_3, ::delete);
}

dam_street_flood_church_hits() {
  wait 2.5;
  common_scripts\utility::exploder("street_flood_big_splash_church_1");
  wait 0.33;
  common_scripts\utility::exploder("street_flood_big_splash_church_1a");
  wait 0.3;
  common_scripts\utility::exploder("street_flood_big_splash_church_1b");
  wait 0.3;
  common_scripts\utility::exploder("street_flood_big_splash_church_1c");
  wait 0.3;
  common_scripts\utility::exploder("street_flood_big_splash_church_2");
  common_scripts\utility::exploder("street_flood_big_splash_church_top_fall_1");
}

dam_street_flood_big_splashes_fx() {}

flood_onscreen_timer() {
  var_0 = 0.0;

  for(;;) {
    iprintln(var_0);
    var_0 = var_0 + 0.05;
    wait 0.05;
  }
}

dam_street_flood_fx() {
  thread dam_street_flood_big_splashes_fx();
  wait 1.75;
  common_scripts\utility::exploder("flood_dam_event_street_flood_mist_1");
  wait 0.5;
  common_scripts\utility::exploder("flood_dam_event_street_flood_mist_2");
  wait 0.5;
  common_scripts\utility::exploder("flood_dam_event_street_flood_mist_3");
}

dam_flood_fx() {
  wait 11.5;
  thread dam_street_flood_fx();
}

alley_flood_fx() {
  common_scripts\utility::exploder("flood_dam_event_alley_mist_1");
  wait 0.25;
  maps\_utility::stop_exploder("flood_dam_event_street_flood_mist_1");
  maps\_utility::stop_exploder("flood_dam_event_street_flood_mist_2");
  maps\_utility::stop_exploder("flood_dam_event_street_flood_mist_3");
  maps\_utility::stop_exploder("flood_dam_event_street_mist_1a");
  maps\_utility::stop_exploder("flood_dam_event_street_mist_1b");
  maps\_utility::stop_exploder("flood_dam_event_street_mist_1c");
}

alley_end_of_alley_fx() {
  common_scripts\utility::flag_wait("alley_move_toend");
  common_scripts\utility::exploder("flood_alley_paper");
  wait 0.5;
  common_scripts\utility::exploder("flood_alley_paper");
  wait 0.25;
  common_scripts\utility::exploder("alley_splashes");
  wait 3;
  common_scripts\utility::exploder("alley_wallsplash_lrg");
  common_scripts\utility::flag_wait("player_doing_warehouse_mantle");
  maps\_utility::delete_exploder("alley_splashes");
  maps\_utility::delete_exploder("flood_alley_paper");
  maps\_utility::delete_exploder("flood_splash_alley_reverse");
  maps\_utility::delete_exploder("flood_splash_alley_front");
}

alley_flood_water() {
  var_0 = common_scripts\utility::getstruct("alley_flood_script", "script_noteworthy");
  var_0.angles = (0, 0, 0);
  var_1 = spawn("script_model", var_0.origin);
  var_1 hide();
  var_1 setModel("flood_alley_flood_near_trackers");
  var_1.animname = "alley_water_near_trackers";
  var_1 maps\_utility::assign_animtree();
  var_2 = spawn("script_model", var_0.origin);
  var_2 hide();
  var_2 setModel("flood_alley_flood_far_trackers");
  var_2.animname = "alley_water_far_trackers";
  var_2 maps\_utility::assign_animtree();
  var_3 = spawn("script_model", var_0.origin);
  var_3 hide();
  var_3 setModel("flood_alley_flood_far_water");
  var_3.animname = "alley_water_far_water";
  var_3 maps\_utility::assign_animtree();
  var_4 = spawn("script_model", var_0.origin);
  var_4 hide();
  var_4 setModel("flood_alley_flood_near_water");
  var_4.animname = "alley_water_near_water";
  var_4 maps\_utility::assign_animtree();
  var_5 = [];
  var_5["alley_water_near_trackers"] = var_1;
  var_6 = [];
  var_6["alley_water_far_trackers"] = var_2;
  var_7 = [];
  var_7["alley_water_far_water"] = var_3;
  var_8 = [];
  var_8["alley_water_near_water"] = var_4;
  common_scripts\utility::exploder("flood_splash_alley_reverse");
  var_0 thread maps\_anim::anim_single(var_5, "flood_alley_flood_near_trackers_anim");
  var_0 thread maps\_anim::anim_single(var_6, "flood_alley_flood_far_trackers_anim");
  wait 0.45;
  var_0 thread maps\_anim::anim_single(var_8, "flood_alley_flood_near_water_anim");
  var_1 thread alley_flood_near_vfx_attachments();
  thread alley_froth_vfx(var_1);
  wait 1;
  thread alley_fill_shallow("alley_fill_shallow_end", "alley_rising_water_end", (500, -4104, -58), 6, "flood_water_alley_fill_shallow");
  common_scripts\utility::flag_wait("player_at_stairs_stop_nag");
  var_1 delete();
  var_2 delete();
  var_3 delete();
  var_4 delete();
}

alley_fill_shallow(var_0, var_1, var_2, var_3, var_4) {
  foreach(var_6 in level.allies) {
    if(!isDefined(var_6.is_running_alley_stuff)) {
      var_6.is_running_alley_stuff = 1;
      var_6 thread maps\flood_coverwater::entity_fx_and_anims_think("stop_alley_wakes", (0, 0, 0), 0, 1);
    }
  }

  var_8 = getent(var_1, "targetname");
  var_8 moveto(var_2, var_3);
  var_9 = common_scripts\utility::getstruct(var_0, "targetname");
  var_10 = spawn("script_model", var_9.origin);
  var_10 setModel("tag_origin");
  var_10.angles = var_9.angles;
  playFXOnTag(level._effect[var_4], var_10, "tag_origin");
  common_scripts\utility::flag_wait("player_at_stairs_stop_nag");
  killfxontag(level._effect[var_4], var_10, "tag_origin");
  var_10 delete();
}

alley_froth_vfx(var_0) {
  wait 5;
  level.froth_vfx = [];
  level.froth_vfx[level.froth_vfx.size] = playfxontagspecial(level._effect["flood_alley_splash_front_rolling"], var_0, "j_near_34");
  level.froth_vfx[level.froth_vfx.size] = playfxontagspecial(level._effect["flood_alley_splash_front_rolling"], var_0, "j_near_33");
  level.froth_vfx[level.froth_vfx.size] = playfxontagspecial(level._effect["flood_alley_splash_front_rolling"], var_0, "j_near_32");
  level.froth_vfx[level.froth_vfx.size] = playfxontagspecial(level._effect["flood_alley_splash_front_rolling"], var_0, "j_near_21");
  common_scripts\utility::waitframe();
  level.froth_vfx[level.froth_vfx.size] = playfxontagspecial(level._effect["flood_alley_splash_front_rolling"], var_0, "j_near_18");
  level.froth_vfx[level.froth_vfx.size] = playfxontagspecial(level._effect["flood_alley_splash_front_rolling"], var_0, "j_near_16");
  level.froth_vfx[level.froth_vfx.size] = playfxontagspecial(level._effect["flood_alley_splash_front_rolling"], var_0, "j_near_10");
  level.froth_vfx[level.froth_vfx.size] = playfxontagspecial(level._effect["flood_alley_splash_front_rolling"], var_0, "j_near_8");
  common_scripts\utility::waitframe();
  level.froth_vfx[level.froth_vfx.size] = playfxontagspecial(level._effect["flood_alley_splash_front_rolling"], var_0, "j_near_19");
  level.froth_vfx[level.froth_vfx.size] = playfxontagspecial(level._effect["flood_alley_splash_front_rolling"], var_0, "j_near_43");
  level.froth_vfx[level.froth_vfx.size] = playfxontagspecial(level._effect["flood_alley_splash_front_rolling"], var_0, "j_near_46");
  level.froth_vfx[level.froth_vfx.size] = playfxontagspecial(level._effect["flood_alley_splash_front_rolling"], var_0, "j_near_48");
  wait 20;

  foreach(var_2 in level.froth_vfx) {
    stopFXOnTag(var_2[1], var_2[0], "tag_origin");
    var_2[0] delete();
  }
}

alley_flood_far_vfx_attachments() {
  var_0 = ["flood_crate_plastic_single02", "com_pallet_2", "com_pallet_2", "com_trafficcone02"];
  level.alley_far = [];
  wait 1.5;
  var_1 = 0;

  for(var_2 = 0; var_2 < 52; var_2 = var_2 + 3) {
    var_3 = "j_far_" + var_2;
    level.alley_far[var_2] = playfxontagspecial(level._effect["flood_splash_small_lp"], self, var_3);

    if(var_2 > 0) {
      if(randomfloat(1.0) > 0.5) {
        var_3 = "j_far_" + (var_2 - 1);

        if(randomfloat(1.0) > 0.4)
          attach_fx_anim_model_alley_flood(self, var_0[randomint(var_0.size)], var_3, 12.0);
      }
    }

    var_1 = var_1 + 1;

    if(var_1 == 3) {
      common_scripts\utility::waitframe();
      var_1 = 0;
    }
  }

  wait 6.67;
  var_1 = 0;

  for(var_2 = 0; var_2 < 52; var_2 = var_2 + 3) {
    var_3 = "j_far_" + var_2;
    stopFXOnTag(level.alley_far[var_2][1], level.alley_far[var_2][0], "tag_origin");
    level.alley_far[var_2][0] delete();
    var_1 = var_1 + 1;

    if(var_1 == 3) {
      common_scripts\utility::waitframe();
      var_1 = 0;
    }
  }
}

alley_flood_near_vfx_attachments() {
  var_0 = ["intro_wood_floorboard_piece02", "intro_wood_floorboard_piece03", "intro_wood_floorboard_piece01", "cardboard_box02_iw6", "road_barrier_post", "com_trafficcone01", "com_trafficcone01", "com_trafficcone02", "flood_crate_plastic_single02"];
  level.alley_near = [];
  wait 1.5;
  var_1 = 0;

  for(var_2 = 0; var_2 < 75; var_2 = var_2 + 5) {
    var_3 = "j_near_" + var_2;
    level.alley_near[var_2] = playfxontagspecial(level._effect["flood_splash_small_lp"], self, var_3);
    var_1 = var_1 + 1;

    if(var_1 == 3) {
      common_scripts\utility::waitframe();
      var_1 = 0;
    }
  }

  wait 6;
  var_1 = 0;

  for(var_2 = 0; var_2 < 75; var_2 = var_2 + 5) {
    var_3 = "j_near_" + var_2;
    stopFXOnTag(level.alley_near[var_2][1], level.alley_near[var_2][0], "tag_origin");
    level.alley_near[var_2][0] delete();
    var_1 = var_1 + 1;

    if(var_1 == 3) {
      common_scripts\utility::waitframe();
      var_1 = 0;
    }
  }
}

playfxontagspecial(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_1.origin);
  var_3 setModel("tag_origin");
  var_3.targetname = "DELETEME";
  var_3 linkto(var_1, var_2, (0, 0, 0), (0, 0, 0));
  playFXOnTag(var_0, var_3, "tag_origin");
  return [var_3, var_0];
}

angry_flood_water() {
  var_0 = common_scripts\utility::getstruct("angry_flood_script", "script_noteworthy");
  var_1 = getent("angry_flood_water_model", "targetname");
  var_1.animname = "angry_water";
  var_1 maps\_utility::assign_animtree();
  var_2 = spawn("script_model", (-1677, -3443.8, 42.3));
  var_1 retargetscriptmodellighting(var_2);
  var_3 = spawn("script_model", var_0.origin);
  var_3 setModel("flood_angryflood_edge_tracker_0");
  var_3.animname = "angry_water_leading_edge";
  var_3 maps\_utility::assign_animtree();
  var_4 = [];
  var_4["angry_water"] = var_1;
  var_5 = [];
  var_5["angry_water_leading_edge"] = var_3;
  var_1 show();
  var_3 hide();

  if(level.playangryfloodvfx) {
    thread angry_flood_splash_sequencing_lf();
    thread angry_flood_splash_sequencing_rt();
  }

  thread angry_flood_big_wave_water();
  var_0 maps\_anim::anim_first_frame(var_5, "flood_angryflood_edge_tracker0");

  if(maps\_utility::is_gen4()) {
    var_6 = level._effect["flood_street_splash_front_rolling"];
    var_7 = level._effect["flood_street_splash_front_rolling"];
  } else {
    var_6 = level._effect["flood_street_splash_front_rolling"];
    var_7 = level._effect["flood_street_splash_front_rolling"];
  }

  var_8 = [];

  if(level.playangryfloodvfx) {
    var_8[var_8.size] = playfxontagspecial(var_7, var_3, "j_wave_front_0");
    var_8[var_8.size] = playfxontagspecial(var_7, var_3, "j_wave_front_001");
    var_8[var_8.size] = playfxontagspecial(var_6, var_3, "j_wave_front_002");
    var_8[var_8.size] = playfxontagspecial(var_7, var_3, "j_wave_front_003");
    common_scripts\utility::waitframe();
    var_8[var_8.size] = playfxontagspecial(var_7, var_3, "j_wave_front_004");
    var_8[var_8.size] = playfxontagspecial(var_7, var_3, "j_wave_front_007");
    var_8[var_8.size] = playfxontagspecial(var_7, var_3, "j_wave_front_008");
    var_8[var_8.size] = playfxontagspecial(var_6, var_3, "j_wave_front_014");
    common_scripts\utility::waitframe();
    var_8[var_8.size] = playfxontagspecial(var_7, var_3, "j_wave_front_013");
    var_8[var_8.size] = playfxontagspecial(var_7, var_3, "j_wave_front_012");
    var_8[var_8.size] = playfxontagspecial(var_7, var_3, "j_wave_front_010");
    var_8[var_8.size] = playfxontagspecial(var_7, var_3, "j_wave_front_011");
    common_scripts\utility::waitframe();
    var_8[var_8.size] = playfxontagspecial(var_7, var_3, "j_wave_front_001");
    var_8[var_8.size] = playfxontagspecial(var_7, var_3, "j_wave_front_009");
    var_8[var_8.size] = playfxontagspecial(var_7, var_3, "j_wave_front_015");
  }

  var_0 thread maps\_anim::anim_single(var_5, "flood_angryflood_edge_tracker0");
  var_0 thread maps\_anim::anim_single(var_4, "flood_angryflood_contig_waterflow0");
  thread angry_flood_street_mist();
  wait 15;

  if(level.playangryfloodvfx) {
    var_9 = 0;

    for(var_10 = var_8.size - 1; var_10 >= 0; var_10--) {
      stopFXOnTag(var_8[var_10][1], var_8[var_10][0], "tag_origin");
      var_8[var_10][0] delete();
      var_9++;

      if(var_9 == 4) {
        var_9 = 0;
        common_scripts\utility::waitframe();
      }
    }
  }

  var_3 delete();
  stop_looping_splashes();
}

angry_flood_street_mist() {
  wait 2;
  common_scripts\utility::exploder("flood_dam_event_street_mist_1a");
  wait 1;
  common_scripts\utility::exploder("flood_dam_event_street_mist_1b");
  wait 1;
  common_scripts\utility::exploder("flood_dam_event_street_mist_1c");
}

angry_flood_big_wave_water() {
  var_0 = common_scripts\utility::getstruct("angry_flood_big_wave_script", "script_noteworthy");
  var_1 = getent("angry_flood_big_wave_water_model", "targetname");
  var_1.animname = "angry_water_bigwave_0";
  var_1 maps\_utility::assign_animtree();
  var_2 = [];
  var_2["angry_water_bigwave_0"] = var_1;
  var_0 maps\_anim::anim_first_frame(var_2, "flood_angry_flood_bigwave0");
  var_1 hide();
  thread big_wave_2();
  wait 3.5;
  var_3 = level._effect["flood_dam_event_bigwave_splash_lp"];
  var_4 = [];

  if(level.playangryfloodvfx) {
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_18");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_00");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_01");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_02");
    common_scripts\utility::waitframe();
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_03");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_04");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_05");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_06");
    common_scripts\utility::waitframe();
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_08");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_10");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_11");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_12");
    common_scripts\utility::waitframe();
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_13");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_14");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_16");
    common_scripts\utility::waitframe();
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_17");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_19");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_21");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_22");
    common_scripts\utility::waitframe();
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_23");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_24");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_26");
    common_scripts\utility::waitframe();
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_27");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_28");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_29");
    common_scripts\utility::waitframe();
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_31");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_35");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_37");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_38");
    common_scripts\utility::waitframe();
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_39");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave_41");
  }

  if(level.playangryfloodvfx)
    thread big_wave_addl_effects();

  var_0 thread maps\_anim::anim_single(var_2, "flood_angry_flood_bigwave0");
  wait 6.3;

  if(level.playangryfloodvfx) {
    var_5 = 0;

    for(var_6 = var_4.size - 1; var_6 >= 0; var_6--) {
      stopFXOnTag(var_4[var_6][1], var_4[var_6][0], "tag_origin");
      var_4[var_6][0] delete();
      var_5++;

      if(var_5 == 4) {
        var_5 = 0;
        common_scripts\utility::waitframe();
      }
    }
  }

  var_1 delete();
}

big_wave_2() {
  wait 8.2;
  var_0 = common_scripts\utility::getstruct("angry_flood_big_wave_script", "script_noteworthy");
  var_1 = spawn("script_model", var_0.origin);
  var_1 hide();
  var_1 setModel("flood_angryflood_big_wave_1");
  var_1.animname = "angry_water_bigwave_1";
  var_1 maps\_utility::assign_animtree();
  var_2 = [];
  var_2["angry_water_bigwave_1"] = var_1;
  var_3 = level._effect["flood_dam_event_bigwave_splash_lp"];
  var_0 maps\_anim::anim_first_frame(var_2, "flood_angry_flood_bigwave1");
  attach_fx_anim_model_street_flood(var_1, "road_barrier_post", "j_bigwave2_18", 4.0);
  attach_fx_anim_model_street_flood(var_1, "flood_crate_plastic_single02", "j_bigwave2_21", 4.0);
  attach_fx_anim_model_street_flood(var_1, "com_pallet_2", "j_bigwave2_01", 4.0);
  attach_fx_anim_model_street_flood(var_1, "com_coffee_machine_destroyed", "j_bigwave2_15", 4.0);
  attach_fx_anim_model_street_flood(var_1, "com_trafficcone02", "j_bigwave2_10", 4.0);
  var_4 = [];

  if(level.playangryfloodvfx) {
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave2_10");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave2_14");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave2_19");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave2_18");
    common_scripts\utility::waitframe();
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave2_17");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave2_01");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave2_03");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave2_21");
    common_scripts\utility::waitframe();
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave2_12");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave2_11");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave2_13");
    common_scripts\utility::waitframe();
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave2_09");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave2_08");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave2_07");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave2_06");
    common_scripts\utility::waitframe();
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave2_05");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave2_15");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave2_02");
    common_scripts\utility::waitframe();
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave2_16");
    var_4[var_4.size] = playfxontagspecial(var_3, var_1, "j_bigwave2_00");
  }

  var_5 = [];
  var_5[0] = "j_bigwave2_16";
  var_5[1] = "j_bigwave2_11";
  var_5[2] = "j_bigwave2_13";
  var_5[3] = "j_bigwave2_03";

  foreach(var_7 in var_5) {
    var_8 = spawn("trigger_radius", var_1 gettagorigin(var_7), 0, 256, 256);
    var_8 enablelinkto();
    var_8 linkto(var_1, var_7);
    var_8 thread fx_angry_flood_nearmiss(1);
  }

  var_0 maps\_anim::anim_single(var_2, "flood_angry_flood_bigwave1");

  if(level.playangryfloodvfx) {
    var_10 = 0;

    for(var_11 = var_4.size - 1; var_11 >= 0; var_11--) {
      stopFXOnTag(var_4[var_11][1], var_4[var_11][0], "tag_origin");
      var_4[var_11][0] delete();
      var_10++;

      if(var_10 == 4) {
        var_10 = 0;
        common_scripts\utility::waitframe();
      }
    }
  }

  var_1 delete();
}

big_wave_addl_effects() {}

angry_flood_splash_sequencing_rt() {
  common_scripts\utility::exploder("flood_street_paper");
  wait 2.5;
  common_scripts\utility::exploder("angry_flood_lp_scrrt_1");
  wait 1.5;
  common_scripts\utility::exploder("angry_flood_lp_scrrt_2");
  wait 1.1;
  common_scripts\utility::exploder("angry_flood_lp_scrrt_3");
  wait 1.5;
  common_scripts\utility::exploder("angry_flood_lp_scrrt_4a");
  wait 0.1;
  common_scripts\utility::exploder("angry_flood_lp_scrrt_4b");
  wait 1.3;
  common_scripts\utility::exploder("angry_flood_lp_scrrt_5");
  wait 2.5;
  common_scripts\utility::exploder("angry_flood_lp_scrrt_6");
  wait 1.5;
  common_scripts\utility::exploder("angry_flood_lp_scrrt_7a");
  wait 0.5;
  common_scripts\utility::exploder("angry_flood_lp_scrrt_7b");
  wait 0.1;
  common_scripts\utility::exploder("angry_flood_lp_scrrt_8");
  wait 1.5;
  common_scripts\utility::exploder("angry_flood_lp_scrrt_9");
  wait 0.5;
  common_scripts\utility::exploder("angry_flood_lp_scrrt_10");
  wait 0.75;
  common_scripts\utility::exploder("angry_flood_lp_scrrt_11");
}

angry_flood_splash_sequencing_lf() {
  wait 2.83;
  common_scripts\utility::exploder("angry_flood_lp_scrlf_1");
  wait 1.5;
  common_scripts\utility::exploder("angry_flood_lp_scrlf_2");
  wait 1.116;
  common_scripts\utility::exploder("angry_flood_lp_scrlf_3");
  wait 0.51;
  common_scripts\utility::exploder("angry_flood_lp_scrlf_4a");
  common_scripts\utility::exploder("angry_flood_lp_scrlf_4b");
  wait 1.38;
  common_scripts\utility::exploder("angry_flood_lp_scrlf_5");
  wait 2.03;
  common_scripts\utility::exploder("angry_flood_lp_scrlf_6");
  wait 1.06;
  common_scripts\utility::exploder("angry_flood_lp_scrlf_8");
  wait 0.2;
  common_scripts\utility::exploder("angry_flood_lp_scrlf_7a");
  wait 0.1;
  common_scripts\utility::exploder("angry_flood_lp_scrlf_7b");
  wait 0.1;
  common_scripts\utility::exploder("angry_flood_lp_scrlf_7c");
}

stop_looping_splashes() {
  wait 30.0;
  maps\_utility::stop_exploder("angry_flood_lp_scrrt_1");
  maps\_utility::stop_exploder("angry_flood_lp_scrrt_2");
  maps\_utility::stop_exploder("angry_flood_lp_scrrt_3");
  maps\_utility::stop_exploder("angry_flood_lp_scrrt_4a");
  maps\_utility::stop_exploder("angry_flood_lp_scrrt_4b");
  maps\_utility::stop_exploder("angry_flood_lp_scrrt_5");
  maps\_utility::stop_exploder("angry_flood_lp_scrrt_6");
  maps\_utility::stop_exploder("angry_flood_lp_scrrt_7a");
  maps\_utility::stop_exploder("angry_flood_lp_scrrt_7b");
  maps\_utility::stop_exploder("angry_flood_lp_scrrt_8");
  maps\_utility::stop_exploder("angry_flood_lp_scrrt_9");
  maps\_utility::stop_exploder("angry_flood_lp_scrrt_10");
  maps\_utility::stop_exploder("angry_flood_lp_scrrt_11");
  maps\_utility::stop_exploder("angry_flood_lp_scrlf_1");
  maps\_utility::stop_exploder("angry_flood_lp_scrlf_2");
  maps\_utility::stop_exploder("angry_flood_lp_scrlf_3");
  maps\_utility::stop_exploder("angry_flood_lp_scrlf_4a");
  maps\_utility::stop_exploder("angry_flood_lp_scrlf_4b");
  maps\_utility::stop_exploder("angry_flood_lp_scrlf_5");
  maps\_utility::stop_exploder("angry_flood_lp_scrlf_6");
  maps\_utility::stop_exploder("angry_flood_lp_scrlf_8");
  maps\_utility::stop_exploder("angry_flood_lp_scrlf_7a");
  maps\_utility::stop_exploder("angry_flood_lp_scrlf_7b");
  maps\_utility::stop_exploder("angry_flood_lp_scrlf_7c");
}

fx_mall_rooftop_debris() {
  common_scripts\utility::flag_wait("breach_door_open");
  var_0 = common_scripts\utility::getstruct("mall_rooftop_wh_debri_01", "script_noteworthy");
  var_0.angles = (0, 0, 0);
  var_0.origin = var_0.origin + (-5, -5, -32);
  var_1 = spawn("script_model", var_0.origin);
  var_1 hide();
  var_1 setModel("flood_mall_rooftop_wh_debri");
  var_1.animname = "mall_rooftop_debris";
  var_1 maps\_utility::assign_animtree();
  var_2 = [];
  var_2["mall_rooftop_debris"] = var_1;
  var_0 thread maps\_anim::anim_first_frame(var_2, "flood_mall_rooftop_wh_debri0_anim");
  var_3 = 50;
  var_4 = [25, 20, 15, 10, 5];
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_barrel_green", "j_com_barrel_green_00", var_3 - var_4[1]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_barrel_green", "j_com_barrel_green_01", var_3 - var_4[2]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_barrel_green", "j_com_barrel_green_03", var_3 - var_4[3]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_barrel_green", "j_com_barrel_green_04", var_3 - var_4[0]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_barrel_green", "j_com_barrel_green_05", var_3 - var_4[3]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_barrel_green", "j_com_barrel_green_06", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_barrel_green", "j_com_barrel_green_07", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_barrel_green", "j_com_barrel_green_08", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_barrel_green", "j_com_barrel_green_09", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_folding_chair", "j_com_folding_chair_50_00", var_3 - var_4[4]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_folding_chair", "j_com_folding_chair_50_01", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_folding_chair", "j_com_folding_chair_50_02", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_folding_chair", "j_com_folding_chair_50_03", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_folding_chair", "j_com_folding_chair_50_04", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_folding_chair", "j_com_folding_chair_50_05", var_3 - var_4[1]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_folding_chair", "j_com_folding_chair_50_06", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_folding_chair", "j_com_folding_chair_50_07", var_3 - var_4[2]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_folding_chair", "j_com_folding_chair_50_08", var_3 - var_4[0]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_folding_chair", "j_com_folding_chair_50_09", var_3 - var_4[0]);
  level thread attach_fx_anim_model_mall_debris(-12, var_1, "com_pallet_2", "j_com_pallet_2_55_00", var_3);
  level thread attach_fx_anim_model_mall_debris(-12, var_1, "com_pallet_2", "j_com_pallet_2_55_01", var_3 - var_4[2]);
  level thread attach_fx_anim_model_mall_debris(-12, var_1, "com_pallet_2", "j_com_pallet_2_55_02", var_3);
  level thread attach_fx_anim_model_mall_debris(-12, var_1, "com_pallet_2", "j_com_pallet_2_55_03", var_3);
  level thread attach_fx_anim_model_mall_debris(-12, var_1, "com_pallet_2", "j_com_pallet_2_55_05", var_3 - var_4[4]);
  level thread attach_fx_anim_model_mall_debris(-12, var_1, "com_pallet_2", "j_com_pallet_2_55_06", var_3 - var_4[0]);
  level thread attach_fx_anim_model_mall_debris(-12, var_1, "com_pallet_2", "j_com_pallet_2_55_07", var_3 - var_4[3]);
  level thread attach_fx_anim_model_mall_debris(-12, var_1, "com_pallet_2", "j_com_pallet_2_55_08", var_3 - var_4[1]);
  level thread attach_fx_anim_model_mall_debris(-12, var_1, "com_pallet_2", "j_com_pallet_2_55_09", var_3);
  level thread attach_fx_anim_model_mall_debris(-12, var_1, "com_plastic_crate_pallet", "j_com_plastic_crate_pallet_57_00", var_3);
  level thread attach_fx_anim_model_mall_debris(-12, var_1, "com_plastic_crate_pallet", "j_com_plastic_crate_pallet_57_01", var_3 - var_4[0]);
  level thread attach_fx_anim_model_mall_debris(-12, var_1, "com_plastic_crate_pallet", "j_com_plastic_crate_pallet_57_02", var_3 - var_4[4]);
  level thread attach_fx_anim_model_mall_debris(-12, var_1, "com_plastic_crate_pallet", "j_com_plastic_crate_pallet_57_03", var_3);
  level thread attach_fx_anim_model_mall_debris(-12, var_1, "com_plastic_crate_pallet", "j_com_plastic_crate_pallet_57_04", var_3 - var_4[2]);
  level thread attach_fx_anim_model_mall_debris(-12, var_1, "com_plastic_crate_pallet", "j_com_plastic_crate_pallet_57_05", var_3 - var_4[1]);
  level thread attach_fx_anim_model_mall_debris(-12, var_1, "com_plastic_crate_pallet", "j_com_plastic_crate_pallet_57_06", var_3);
  level thread attach_fx_anim_model_mall_debris(-12, var_1, "com_plastic_crate_pallet", "j_com_plastic_crate_pallet_57_07", var_3);
  level thread attach_fx_anim_model_mall_debris(-12, var_1, "com_plastic_crate_pallet", "j_com_plastic_crate_pallet_57_08", var_3);
  level thread attach_fx_anim_model_mall_debris(-12, var_1, "com_plastic_crate_pallet", "j_com_plastic_crate_pallet_57_09", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_trashbin01", "j_com_trashbin_56_00", var_3 - var_4[3]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_trashbin01", "j_com_trashbin_56_01", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_trashbin01", "j_com_trashbin_56_02", var_3 - var_4[4]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_trashbin01", "j_com_trashbin_56_03", var_3 - var_4[0]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_trashbin01", "j_com_trashbin_56_04", var_3 - var_4[2]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_trashbin01", "j_com_trashbin_56_05", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_trashbin01", "j_com_trashbin_56_06", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_trashbin01", "j_com_trashbin_56_07", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_trashbin01", "j_com_trashbin_56_08", var_3 - var_4[0]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_trashbin01", "j_com_trashbin_56_09", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "street_trashcan_open_iw6", "j_com_trashcan_metal_with_trash_56_00", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "street_trashcan_open_iw6", "j_com_trashcan_metal_with_trash_56_01", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "street_trashcan_open_iw6", "j_com_trashcan_metal_with_trash_56_02", var_3 - var_4[0]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "street_trashcan_open_iw6", "j_com_trashcan_metal_with_trash_56_03", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "street_trashcan_open_iw6", "j_com_trashcan_metal_with_trash_56_04", var_3 - var_4[1]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "street_trashcan_open_iw6", "j_com_trashcan_metal_with_trash_56_05", var_3 - var_4[0]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "street_trashcan_open_iw6", "j_com_trashcan_metal_with_trash_56_06", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "street_trashcan_open_iw6", "j_com_trashcan_metal_with_trash_56_07", var_3 - var_4[0]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "street_trashcan_open_iw6", "j_com_trashcan_metal_with_trash_56_08", var_3 - var_4[3]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "street_trashcan_open_iw6", "j_com_trashcan_metal_with_trash_56_09", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_plasticcase_beige_big_iw6", "j_pb_weaponscase_57_00", var_3 - var_4[3]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_plasticcase_beige_big_iw6", "j_pb_weaponscase_57_01", var_3 - var_4[1]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_plasticcase_beige_big_iw6", "j_pb_weaponscase_57_02", var_3 - var_4[0]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_plasticcase_beige_big_iw6", "j_pb_weaponscase_57_03", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_plasticcase_beige_big_iw6", "j_pb_weaponscase_57_04", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_plasticcase_beige_big_iw6", "j_pb_weaponscase_57_05", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_plasticcase_beige_big_iw6", "j_pb_weaponscase_57_06", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_plasticcase_beige_big_iw6", "j_pb_weaponscase_57_07", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_plasticcase_beige_big_iw6", "j_pb_weaponscase_57_08", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "com_plasticcase_beige_big_iw6", "j_pb_weaponscase_57_09", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "vehicle_civilian_sedan_red_destroy_iw6", "j_vehicle_coupe_green_destroyed_00", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "vehicle_civilian_sedan_bronze_iw6", "j_vehicle_coupe_green_destroyed_01", var_3 - var_4[0]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "vehicle_civilian_sedan_gray_destroy_iw6", "j_vehicle_coupe_green_destroyed_02", var_3 - var_4[0]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "vehicle_civilian_sedan_bronze_iw6", "j_vehicle_coupe_green_destroyed_03", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "vehicle_civilian_sedan_red_destroy_iw6", "j_vehicle_coupe_green_destroyed_04", var_3 - var_4[0]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "vehicle_civilian_sedan_gray_destroy_iw6", "j_vehicle_coupe_green_destroyed_05", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "vehicle_civilian_sedan_red_destroy_iw6", "j_vehicle_coupe_green_destroyed_06", var_3 - var_4[0]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "vehicle_civilian_sedan_bronze_iw6", "j_vehicle_coupe_green_destroyed_07", var_3 - var_4[4]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "vehicle_civilian_sedan_gray_destroy_iw6", "j_vehicle_coupe_green_destroyed_08", var_3 - var_4[0]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "vehicle_civilian_sedan_bronze_iw6", "j_vehicle_coupe_green_destroyed_09", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "vehicle_civilian_sedan_red_destroy_iw6", "j_vehicle_coupe_green_destroyed_10", var_3 - var_4[3]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "vehicle_city_car_blue", "j_vehicle_van_mica_destroyed_00", var_3 - var_4[0]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "vehicle_city_car_silver", "j_vehicle_van_mica_destroyed_01", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "vehicle_city_car_blue", "j_vehicle_van_mica_destroyed_02", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "vehicle_city_car_red", "j_vehicle_van_mica_destroyed_03", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "vehicle_city_car_silver", "j_vehicle_van_mica_destroyed_04", var_3 - var_4[4]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "vehicle_city_car_blue", "j_vehicle_van_mica_destroyed_05", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "vehicle_city_car_red", "j_vehicle_van_mica_destroyed_06", var_3);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "vehicle_city_car_blue", "j_vehicle_van_mica_destroyed_07", var_3 - var_4[0]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "vehicle_city_car_silver", "j_vehicle_van_mica_destroyed_08", var_3 - var_4[0]);
  level thread attach_fx_anim_model_mall_debris(0, var_1, "vehicle_city_car_red", "j_vehicle_van_mica_destroyed_09", var_3);
  var_0 thread maps\_anim::anim_single(var_2, "flood_mall_rooftop_wh_debri0_anim");
}

fx_warehouse_ally_mantle(var_0, var_1) {
  var_2 = getEntArray("coverwater_warehouse_premantle", "targetname");
  wait(var_0);
  var_3 = var_2[0].origin[2];
  var_4 = self gettagorigin("J_Knee_RI");
  var_4 = (var_4[0], var_4[1], var_3);
  playFX(level._effect["flood_warehouse_ally_mantle"], var_4, (0, 1, 0), (0, 0, 1));
  wait 0.1;
  var_3 = var_2[0].origin[2];
  var_4 = self gettagorigin("J_Knee_LE");
  var_4 = (var_4[0], var_4[1], var_3);
  playFX(level._effect["flood_warehouse_ally_mantle"], var_4, (0, 1, 0), (0, 0, 1));
  wait(var_1);
  var_3 = var_2[0].origin[2];
  var_5 = self gettagorigin("J_Ankle_RI");
  var_5 = (var_5[0], var_5[1], var_3);
  playFX(level._effect["flood_warehouse_ally_mantle"], var_5, (0, 1, 0), (0, 0, 1));
  wait 0.1;
  var_3 = var_2[0].origin[2];
  var_5 = self gettagorigin("J_Ankle_LE");
  var_5 = (var_5[0], var_5[1], var_3);
  playFX(level._effect["flood_warehouse_ally_mantle"], var_5, (0, 1, 0), (0, 0, 1));
}

fx_warehouse_door_burst() {
  var_0 = getent("wh_splashes_upper", "targetname");
  level.door_burst_splashes = [];
  common_scripts\utility::exploder("warehouse_doorbreak");
  wait 0.3;
  level.door_burst_splashes[level.door_burst_splashes.size] = playfxontagspecial(common_scripts\utility::getfx("vfx_warehouse_door_splashes_lrg"), var_0, "tag_fx_big_door_splash_001");
  level.door_burst_splashes[level.door_burst_splashes.size] = playfxontagspecial(common_scripts\utility::getfx("vfx_warehouse_door_splashes_lrg"), var_0, "tag_fx_big_door_splash_002");
  wait 10;

  foreach(var_2 in level.door_burst_splashes) {
    killfxontag(var_2[1], var_2[0], "tag_origin");
    var_2[0] delete();
  }
}

fx_wh_splashes() {
  var_0 = getent("wh_splashes_lower", "targetname");
  var_1 = getent("wh_splashes_upper", "targetname");
  level.wh_amb_fx = [];
  level.wh_amb_fx[level.wh_amb_fx.size] = playfxontagspecial(common_scripts\utility::getfx("vfx_warehouse_door_splashes_lrg_dark"), var_0, "tag_fx_big_door_splash_001");
  level.wh_amb_fx[level.wh_amb_fx.size] = playfxontagspecial(common_scripts\utility::getfx("vfx_warehouse_lip_froth_01"), var_0, "tag_fx_lip_splash_001");
  level.wh_amb_fx[level.wh_amb_fx.size] = playfxontagspecial(common_scripts\utility::getfx("vfx_warehouse_lip_froth_dark"), var_0, "tag_fx_lip_splash_002");
  common_scripts\utility::waitframe();
  level.wh_amb_fx[level.wh_amb_fx.size] = playfxontagspecial(common_scripts\utility::getfx("vfx_warehouse_door_splashes_sml"), var_1, "tag_fx_small_door_splash_004");
  level.wh_amb_fx[level.wh_amb_fx.size] = playfxontagspecial(common_scripts\utility::getfx("vfx_warehouse_door_splashes_sml"), var_1, "tag_fx_small_door_splash_003");
  wait 30;

  foreach(var_3 in level.wh_amb_fx) {
    killfxontag(var_3[1], var_3[0], "tag_origin");
    var_3[0] delete();
  }
}

fx_warehouse_door_burst_02() {
  var_0 = getent("wh_splashes_upper", "targetname");
  common_scripts\utility::exploder("wh_thick");
  playFXOnTag(common_scripts\utility::getfx("vfx_warehouse_door_splashes_lrg"), var_0, "tag_fx_small_door_splash_002");
  wait 15;
  killfxontag(common_scripts\utility::getfx("vfx_warehouse_door_splashes_lrg"), var_0, "tag_fx_small_door_splash_002");
}

fx_warehouse_amb_fx() {
  common_scripts\utility::exploder("wh_drips");
  common_scripts\utility::exploder("wh_doorsprays");
  common_scripts\utility::exploder("wh_abovewater_fx");
  common_scripts\utility::exploder("stairwell_flare_01_01");
  maps\_utility::stop_exploder("dam_water_falling");

  for(;;) {
    common_scripts\utility::flag_wait("cw_player_underwater");
    maps\_utility::stop_exploder("wh_drips");
    maps\_utility::stop_exploder("wh_abovewater_fx");
    maps\_utility::stop_exploder("wh_doorsprays");
    maps\_utility::stop_exploder("stairwell_flare_01_01");
    common_scripts\utility::flag_wait("cw_player_abovewater");
    common_scripts\utility::exploder("wh_drips");
    common_scripts\utility::exploder("wh_abovewater_fx");
    common_scripts\utility::exploder("wh_doorsprays");
    common_scripts\utility::exploder("stairwell_flare_01_01");
  }
}

fx_warehouse_underwater_fx_on() {
  level.already_checking_udwfx = 1;
  level endon("player_on_mall_roof");

  for(;;) {
    common_scripts\utility::flag_wait("cw_player_underwater");

    if(isDefined(level.wh_debris_01_vfx)) {
      foreach(var_1 in level.wh_debris_01_vfx) {
        playFXOnTag(var_1[1], var_1[0], "tag_origin");
        common_scripts\utility::waitframe();
      }
    }

    if(isDefined(level.wh_debris_02_vfx)) {
      foreach(var_1 in level.wh_debris_02_vfx) {
        playFXOnTag(var_1[1], var_1[0], "tag_origin");
        common_scripts\utility::waitframe();
      }
    }

    if(isDefined(level.wh_debris_03_vfx)) {
      foreach(var_1 in level.wh_debris_03_vfx) {
        playFXOnTag(var_1[1], var_1[0], "tag_origin");
        common_scripts\utility::waitframe();
      }
    }

    common_scripts\utility::flag_wait("cw_player_abovewater");
  }
}

fx_warehouse_underwater_fx_off() {
  level endon("player_on_mall_roof");

  for(;;) {
    common_scripts\utility::flag_wait("cw_player_abovewater");
    var_0 = 0;

    if(isDefined(level.wh_debris_01_vfx)) {
      foreach(var_2 in level.wh_debris_01_vfx) {
        killfxontag(var_2[1], var_2[0], "tag_origin");
        var_0++;

        if(var_0 == 28) {
          var_0 = 0;
          wait 0.05;
        }
      }
    }

    if(isDefined(level.wh_debris_02_vfx)) {
      foreach(var_2 in level.wh_debris_02_vfx) {
        killfxontag(var_2[1], var_2[0], "tag_origin");
        var_0++;

        if(var_0 == 28) {
          var_0 = 0;
          wait 0.05;
        }
      }
    }

    if(isDefined(level.wh_debris_03_vfx)) {
      foreach(var_2 in level.wh_debris_03_vfx) {
        killfxontag(var_2[1], var_2[0], "tag_origin");
        var_0++;

        if(var_0 == 28) {
          var_0 = 0;
          wait 0.05;
        }
      }
    }

    wait 1;
  }
}

destroy_fx_warehouse_floating_debris() {
  var_0 = getent("warehouse_upper_floating_debris", "script_noteworthy");
  var_1 = getent("coverwater_warehouse_premantle_debris", "script_noteworthy");

  if(isDefined(level.wh_debris_01_vfx)) {
    foreach(var_3 in level.wh_debris_01_vfx) {
      killfxontag(var_3[1], var_3[0], "tag_origin");
      common_scripts\utility::waitframe();
    }
  }

  if(isDefined(level.wh_debris_02_vfx)) {
    foreach(var_3 in level.wh_debris_02_vfx) {
      killfxontag(var_3[1], var_3[0], "tag_origin");
      common_scripts\utility::waitframe();
    }
  }

  if(isDefined(level.wh_debris_03_vfx)) {
    foreach(var_3 in level.wh_debris_03_vfx) {
      killfxontag(var_3[1], var_3[0], "tag_origin");
      common_scripts\utility::waitframe();
    }
  }

  if(isDefined(level.wh_debris_01_top_vfx)) {
    foreach(var_3 in level.wh_debris_01_top_vfx) {
      killfxontag(var_3[1], var_3[0], "tag_origin");
      common_scripts\utility::waitframe();
    }
  }

  if(isDefined(level.wh_debris_02_top_vfx)) {
    foreach(var_3 in level.wh_debris_02_top_vfx) {
      killfxontag(var_3[1], var_3[0], "tag_origin");
      common_scripts\utility::waitframe();
    }
  }

  if(isDefined(level.wh_debris_03_top_vfx)) {
    foreach(var_3 in level.wh_debris_03_top_vfx) {
      killfxontag(var_3[1], var_3[0], "tag_origin");
      common_scripts\utility::waitframe();
    }
  }

  if(isDefined(level.wh_debris_01_vfx)) {
    foreach(var_3 in level.wh_debris_01_vfx) {
      if(isDefined(var_3[0]))
        var_3[0] delete();
    }
  }

  if(isDefined(level.wh_debris_02_vfx)) {
    foreach(var_3 in level.wh_debris_02_vfx) {
      if(isDefined(var_3[0]))
        var_3[0] delete();
    }
  }

  if(isDefined(level.wh_debris_03_vfx)) {
    foreach(var_3 in level.wh_debris_03_vfx) {
      if(isDefined(var_3[0]))
        var_3[0] delete();
    }
  }

  if(isDefined(level.wh_debris_01_top_vfx)) {
    foreach(var_3 in level.wh_debris_01_vfx) {
      if(isDefined(var_3[0]))
        var_3[0] delete();
    }
  }

  if(isDefined(level.wh_debris_02_top_vfx)) {
    foreach(var_3 in level.wh_debris_02_top_vfx) {
      if(isDefined(var_3[0]))
        var_3[0] delete();
    }
  }

  if(isDefined(level.wh_debris_03_top_vfx)) {
    foreach(var_3 in level.wh_debris_03_top_vfx) {
      if(isDefined(var_3[0]))
        var_3[0] delete();
    }
  }

  if(isDefined(var_0) && isDefined(var_1)) {
    var_0 delete();
    var_1 delete();
  }
}

destroy_lip_debris_fx() {
  stopFXOnTag(common_scripts\utility::getfx("flood_warehouse_lip_cascade_debris"), level.lip_cascade_vfx[0], "tag_origin");
}

fx_warehouse_floating_debris() {
  level.wh_debris_01_vfx = [];
  level.wh_debris_02_vfx = [];
  level.wh_debris_03_vfx = [];
  level.wh_debris_01_top_vfx = [];
  level.wh_debris_02_top_vfx = [];
  level.wh_debris_03_top_vfx = [];
  var_0 = getent("warehouse_upper_floating_debris", "script_noteworthy");
  var_1 = getent("coverwater_warehouse_premantle_debris", "script_noteworthy");
  level.lip_cascade_vfx = playfxontagspecial(common_scripts\utility::getfx("flood_warehouse_lip_cascade_debris"), var_1, "tag_fx_debri_lip");

  for(var_2 = 1; var_2 <= 2; var_2++) {
    var_3 = "tag_fx_debri_3_00" + var_2;
    level.wh_debris_03_vfx[level.wh_debris_03_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("flood_warehouse_floating_debri_03"), var_0, var_3);
    level.wh_debris_03_top_vfx[level.wh_debris_03_top_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("flood_warehouse_floating_debri_03_top"), var_0, var_3);
    common_scripts\utility::waitframe();
  }

  for(var_4 = 1; var_4 <= 10; var_4++) {
    if(var_4 < 10)
      var_5 = "tag_fx_debri_2_00" + var_4;
    else
      var_5 = "tag_fx_debri_2_0" + var_4;

    level.wh_debris_02_vfx[level.wh_debris_02_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("flood_warehouse_floating_debri_02"), var_0, var_5);
    level.wh_debris_02_top_vfx[level.wh_debris_02_top_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("flood_warehouse_floating_debri_02_top"), var_0, var_5);
    common_scripts\utility::waitframe();
  }

  for(var_6 = 1; var_6 <= 3; var_6++) {
    var_7 = "tag_fx_debri_1_00" + var_6;
    level.wh_debris_01_vfx[level.wh_debris_01_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("flood_warehouse_floating_debri_01"), var_0, var_7);
    level.wh_debris_01_top_vfx[level.wh_debris_01_top_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("flood_warehouse_floating_debri_01_top"), var_0, var_7);
    common_scripts\utility::waitframe();
  }

  for(var_8 = 1; var_8 <= 8; var_8++) {
    var_9 = "tag_fx_particulates_02_00" + var_8;
    level.wh_debris_03_vfx[level.wh_debris_03_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("flood_particlulates_03"), var_0, var_9);
    common_scripts\utility::waitframe();
  }

  for(var_10 = 1; var_10 <= 5; var_10++) {
    var_11 = "tag_fx_flood_floating_paper_slow_00" + var_10;
    level.wh_debris_03_vfx[level.wh_debris_03_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("flood_floating_paper_slow2"), var_0, var_11);
    common_scripts\utility::waitframe();
  }

  for(var_12 = 1; var_12 <= 3; var_12++) {
    var_13 = "tag_fx_debri_1_00" + var_12;
    playFXOnTag(common_scripts\utility::getfx("flood_warehouse_floating_debri_01"), var_1, var_13);

    if(var_4 != 3)
      level.wh_debris_02_vfx[level.wh_debris_02_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("flood_warehouse_floating_debri_02"), var_1, var_13);
    else
      level.wh_debris_03_vfx[level.wh_debris_03_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("flood_warehouse_floating_debri_03"), var_1, var_13);

    common_scripts\utility::waitframe();
  }

  self.already_spawned = 1;
}

fx_warehouse_floating_debris_int() {
  if(!isDefined(self.already_spawned) || isDefined(self.already_spawned) && !self.already_spawned)
    thread fx_warehouse_floating_debris();
}

fx_warehouse_door_breach() {
  common_scripts\utility::exploder("wh_doorbreach");
}

fx_warehouse_stop_cover_water() {
  wait 4;
  maps\_utility::stop_exploder("wh_coverplashes");
}

fx_rooftop_crush_dust() {
  wait 3;
  playFXOnTag(common_scripts\utility::getfx("mall_rooftop_crush_dust_emit"), level.mallroof_impact, "j_bone01");
}

fx_rooftop_collapse_fx() {
  wait 2;
  common_scripts\utility::exploder("roofcollapse_medium_dust_01");
  wait 1;
  common_scripts\utility::exploder("mr_updust");
  common_scripts\utility::exploder("roofcollapse_bigsplash_01");
  wait 1;
  common_scripts\utility::exploder("mr_bigdust");
  wait 1;
  common_scripts\utility::exploder("mr_bigsplashes");
  common_scripts\utility::exploder("mr_debri_explosions");
}

rooftop_01_misc_fx() {
  common_scripts\utility::flag_init("rooftop_01_misc_fx");
  common_scripts\utility::flag_wait("rooftop_01_misc_fx");
  common_scripts\utility::exploder("rooftop1_misc_fx");
  thread maps\flood_audio::sfx_stairwell_wind();
  common_scripts\utility::exploder("rooftop_stairwell_dust");
}

trigger_debris_bridge_water() {
  common_scripts\utility::flag_init("trigger_debris_bridge_water");
  common_scripts\utility::flag_wait("trigger_debris_bridge_water");
  var_0 = getent("debri_bridge_water", "targetname");
  var_1 = getEntArray("swept_water_swim", "targetname");
  var_0 show();

  foreach(var_3 in var_1)
  var_3 hide();
}

exit_stealth_misc_fx() {
  fx_dam_waterfall_show();
  common_scripts\utility::exploder("dam_water_falling");
}

fx_mall_rooftop_hide_shadow_geo() {
  var_0 = getent("mall_rooftop_water_shadow_geo", "targetname");
  var_1 = getent("mall_rooftop_water_geo_chunk", "targetname");
  var_0 hide();
  var_1 hide();
}

fx_rooftops_water_hide() {
  var_0 = getent("debri_bridge_water", "targetname");
  var_0 hide();
}

fx_swept_water_hide() {
  var_0 = getEntArray("swept_water_swim", "targetname");

  foreach(var_2 in var_0)
  var_2 hide();
}

fx_mall_roof_water_hide() {
  var_0 = getent("mall_roof_water", "targetname");
  var_0 hide();
  var_0 notsolid();
  var_1 = getent("mall_roof_water_geo", "targetname");
  var_1 hide();
  var_1 notsolid();
}

fx_mall_roof_water_show() {
  var_0 = getent("mall_roof_water", "targetname");
  var_1 = getent("mall_roof_water_geo", "targetname");
  var_2 = getent("mall_rooftop_water_target", "targetname");
  var_1 retargetscriptmodellighting(var_2);
  var_0 show();
  var_0 solid();
  var_1 show();
  var_1 solid();
}

fx_retarget_warehouse_waters_lighting() {
  var_0 = getent("warehouse_waters_retarget", "targetname");
  var_1 = getent("warehouse_waters_foam_retarget", "targetname");
  var_2 = getent("coverwater_warehouse_above", "targetname");
  var_3 = getent("coverwater_warehouse_postmantle_above", "targetname");
  var_4 = getent("coverwater_warehouse_premantle_above", "targetname");
  var_5 = getent("coverwater_warehouse_foam", "targetname");
  var_2 retargetscriptmodellighting(var_0);
  var_3 retargetscriptmodellighting(var_0);
  var_4 retargetscriptmodellighting(var_0);

  if(isDefined(var_5) && isDefined(var_1))
    var_5 retargetscriptmodellighting(var_1);
}

fx_retarget_rooftop_water_lighting() {
  var_0 = getent("rooftops_water_retarget", "targetname");
  var_1 = getent("debri_bridge_water", "targetname");
  var_2 = getent("ending_water", "targetname");
  var_3 = getEntArray("swept_water_swim", "targetname");
  var_4 = getent("rooftop2_water", "script_noteworthy");

  foreach(var_6 in var_3)
  var_6 retargetscriptmodellighting(var_0);

  var_1 retargetscriptmodellighting(var_0);
  var_2 retargetscriptmodellighting(var_0);
  var_4 retargetscriptmodellighting(var_0);
}

fx_alley_froth() {
  wait 3;
  common_scripts\utility::exploder("alley_froth");
  wait 15;
  maps\_utility::stop_exploder("alley_froth");
}

fx_mall_roof_amb_fx() {
  common_scripts\utility::exploder("huge_plume");
  common_scripts\utility::exploder("mall_rooftop_amb");
  common_scripts\utility::exploder("mall_rooftop_rapid_splash");
  common_scripts\utility::exploder("mall_floating_debri_med");
  maps\_utility::stop_exploder("wh_drips");
  maps\_utility::stop_exploder("wh_doorsprays");
  maps\_utility::stop_exploder("warehouse_doorbreak");
  maps\_utility::stop_exploder("wh_thick");
}

fx_swept_amb_fx() {
  maps\_utility::stop_exploder("mall_rooftop_amb");
  common_scripts\utility::exploder("huge_plume_swept");
}

swept_fall_dunk(var_0) {
  thread maps\flood_swept::swept_underwater();
  playFXOnTag(common_scripts\utility::getfx("swept_underwater_fx_st"), level.cw_player_view_fx_source, "tag_origin");
  wait 0.3;
  playFXOnTag(common_scripts\utility::getfx("dunk_bubbles_runner"), level.cw_player_view_fx_source, "tag_origin");
}

fx_swept_dunk_bubbles() {}

swept_coming_out_01(var_0) {
  setblur(3, 0.1);
  playFXOnTag(common_scripts\utility::getfx("water_waterline_emerge_01"), level.cw_player_view_fx_source, "tag_origin");
  wait 0.3;
  wait 0.2;
  playFXOnTag(common_scripts\utility::getfx("scrnfx_water_splash_high_02"), level.cw_player_view_fx_source, "tag_origin");
  thread maps\flood_swept::swept_abovewater();
  wait 0.2;
  wait 0.3;
  setblur(0, 0.2);
}

quick_dunk(var_0) {
  playFXOnTag(common_scripts\utility::getfx("scrnfx_water_splash_high_02"), level.cw_player_view_fx_source, "tag_origin");
  setblur(3, 0.1);
  wait 0.3;
  setblur(0, 0.2);
}

swept_plunge_01(var_0) {
  playFXOnTag(common_scripts\utility::getfx("swept_underwater_fx"), level.cw_player_view_fx_source, "tag_origin");
  thread maps\flood_swept::swept_underwater();
}

swept_emerge_02(var_0) {
  playFXOnTag(common_scripts\utility::getfx("water_waterline_emerge_01"), level.cw_player_view_fx_source, "tag_origin");
  wait 0.3;
  killfxontag(common_scripts\utility::getfx("swept_underwater_fx"), level.cw_player_view_fx_source, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("scrnfx_water_splash_high_02"), level.cw_player_view_fx_source, "tag_origin");
  thread maps\flood_swept::swept_abovewater();
  setblur(3, 0.1);
  wait 0.5;
  setblur(0, 0.2);
}

swept_plunge_02(var_0) {
  playFXOnTag(common_scripts\utility::getfx("swept_underwater_fx"), level.cw_player_view_fx_source, "tag_origin");
  thread maps\flood_swept::swept_underwater();
}

swept_plunge_2_5(var_0) {
  playFXOnTag(common_scripts\utility::getfx("swept_underwater_fx"), level.cw_player_view_fx_source, "tag_origin");
  thread maps\flood_swept::swept_underwater();
  common_scripts\utility::waitframe();
  killfxontag(common_scripts\utility::getfx("scrnfx_water_splash_high_02"), level.cw_player_view_fx_source, "tag_origin");
  setblur(4, 0.1);
  wait 1.2;
  setblur(0, 0.4);
  wait 0.2;
  playFXOnTag(common_scripts\utility::getfx("water_waterline_emerge_01"), level.cw_player_view_fx_source, "tag_origin");
  wait 0.08;
  playFXOnTag(common_scripts\utility::getfx("scrnfx_water_splash_high_02"), level.cw_player_view_fx_source, "tag_origin");
  thread maps\flood_swept::swept_abovewater();
  wait 0.25;
  playFXOnTag(common_scripts\utility::getfx("swept_underwater_fx"), level.cw_player_view_fx_source, "tag_origin");
  thread maps\flood_swept::swept_underwater();
}

swept_blur(var_0) {
  killfxontag(common_scripts\utility::getfx("swept_underwater_fx"), level.cw_player_view_fx_source, "tag_origin");
  thread maps\flood_swept::swept_abovewater();
  setblur(4, 0.1);
  wait 1;
  setblur(0, 0.3);
}

swept_emerge_03(var_0) {
  killfxontag(common_scripts\utility::getfx("swept_underwater_fx"), level.cw_player_view_fx_source, "tag_origin");
  wait 1.2;
  playFXOnTag(common_scripts\utility::getfx("scrnfx_water_splash_high_02"), level.cw_player_view_fx_source, "tag_origin");
  thread maps\flood_swept::swept_abovewater();
  setblur(3, 0.1);
  wait 0.9;
  setblur(0, 0.3);
  wait 3;
  level.player setwatersheeting(1, 1);
  thread fx_bokehdots_close();
  common_scripts\utility::waitframe();
  thread fx_turn_on_bokehdots_64_player();
}

swept_plunge_03(var_0) {
  playFXOnTag(common_scripts\utility::getfx("swept_underwater_fx_st"), level.cw_player_view_fx_source, "tag_origin");
  thread maps\flood_swept::swept_underwater();
  thread dof_swept_plunge_03();
  setblur(4, 0.1);
  wait 0.25;
  setblur(0, 0.1);
  wait 6.5;
  thread maps\flood_swept::swept_abovewater();
  playFXOnTag(common_scripts\utility::getfx("scrnfx_water_splash_high_02"), level.cw_player_view_fx_source, "tag_origin");
  wait 2.75;
  thread maps\flood_swept::swept_underwater();
  playFXOnTag(common_scripts\utility::getfx("swept_underwater_fx"), level.cw_player_view_fx_source, "tag_origin");
  setblur(4, 0.1);
  wait 1.25;
  killfxontag(common_scripts\utility::getfx("swept_underwater_fx"), level.cw_player_view_fx_source, "tag_origin");
  thread maps\flood_swept::swept_abovewater();
  playFXOnTag(common_scripts\utility::getfx("scrnfx_water_splash_high_02"), level.cw_player_view_fx_source, "tag_origin");
  setblur(0, 0.6);
}

rorke_hand_bubbles(var_0) {
  common_scripts\utility::exploder("rorke_hand_dunk_foam");
  playFXOnTag(common_scripts\utility::getfx("rorke_hand_bubbles_runner"), var_0, "J_Mid_RI_2");
  wait 1;
  killfxontag(common_scripts\utility::getfx("rorke_hand_bubbles_runner"), var_0, "J_Mid_RI_2");
}

fx_skybridge_event() {
  common_scripts\utility::exploder("skybridge_building_smoke_02");
}

fx_vision_fog_init() {
  common_scripts\utility::flag_init("garage_mall_light");
  thread gamestart_light_fix();
  thread set_enter_flood_road();
  thread set_enter_loadingdocks_vf();
  thread set_enter_rooftop_1_vf();
  thread set_enter_stairwell();
  thread set_enter_stealth_vf();
  thread set_enter_garage2_vf();
  thread set_enter_garage_mall_vf();
  thread set_warelights_off();
  thread set_stairs_hall_vf();
  thread set_enter_rooftop_water();
  thread set_mall_lights_off();
}

dof_dam_break() {
  maps\_art::dof_enable_script(0, 184, 4, 777, 11650, 0, 0.25);
  maps\_utility::vision_set_fog_changes("flood_dam", 1.75);

  if(maps\_utility::is_gen4()) {
    maps\_utility::lerp_saveddvar("r_diffuseColorScale", 1.2, 0.5);
    maps\_utility::lerp_saveddvar("sm_sunSampleSizeNear", 0.15, 0.5);
  } else
    maps\_utility::lerp_saveddvar("sm_sunSampleSizeNear", 0.16, 0.5);

  wait 5;
  maps\_art::dof_disable_script(1.5);
  wait 1.5;
  visionsetnaked("flood", 4.0);

  if(maps\_utility::is_gen4()) {
    maps\_utility::lerp_saveddvar("r_diffuseColorScale", 4.6, 4);
    wait 3;
    maps\_utility::lerp_saveddvar("sm_sunSampleSizeNear", 0.2, 4);
  } else
    maps\_utility::lerp_saveddvar("sm_sunSampleSizeNear", 0.21, 0.5);
}

dof_swept_away() {
  setblur(2, 0.1);
  level.player maps\_utility::vision_set_changes("flood_underwater_swept", 0);
  level.player maps\_utility::fog_set_changes("flood_underwater_swept", 0);
}

dof_swept_plunge_03() {
  setsaveddvar("sm_sunSampleSizeNear", 0.2);
  maps\_art::dof_enable_script(10, 30, 6, 0, 600, 4, 0.01);
  level.player maps\_utility::vision_set_changes("flood_underwater_murky", 0);
  wait 4.75;
  level.player maps\_utility::vision_set_changes("flood_underwater_murky_hand", 1);
  setblur(1.5, 0.5);
}

dof_underwater_general() {
  if(common_scripts\utility::flag("cw_player_underwater")) {
    if(maps\_utility::is_gen4()) {
      setsaveddvar("r_materialBloomHQFalloffScale1", (0, 0.1, 0.2));
      setsaveddvar("r_materialBloomHQFalloffScale2", (0.2, 0.4, 0.6));
      setsaveddvar("r_materialBloomHQRadius", 0.4);
      setsaveddvar("r_materialBloomHQSensitivity", "2.5 2.6 1 2");
    }
  }
}

dof_outro_pt2(var_0) {
  maps\_art::dof_enable_script(0, 21, 10, 776, 11649, 0, 0.25);
  wait 7.8;
  maps\_art::dof_enable_script(0, 30, 10, 776, 11649, 0, 0.25);
  wait 7.6;
  maps\_art::dof_disable_script(1.5);
}

gamestart_light_fix() {
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 9.01);
  maps\_utility::setsaveddvar_cg_ng("r_diffuseColorScale", 1.4, 4.6);
  maps\_utility::setsaveddvar_cg_ng("r_lightGridIntensity", 0, 0);
  var_0 = getent("skybridge_room_light", "targetname");
  var_1 = getent("warehouse_door_int_l_lock", "targetname");
  var_2 = getent("warehouse_door_int_r_lock", "targetname");
  var_3 = getEntArray("door1_target_from", "script_noteworthy");
  var_4 = getent("garage_door_light_target", "targetname");
  var_5 = getent("magnetic_door_light_target", "targetname");
  var_1 retargetscriptmodellighting(var_5);
  var_2 retargetscriptmodellighting(var_5);

  foreach(var_7 in var_3)
  var_7 retargetscriptmodellighting(var_4);

  if(isDefined(var_0))
    var_0 setlightradius(13);
}

set_enter_flood_road() {
  common_scripts\utility::flag_init("flood_road_trigger");

  for(;;) {
    common_scripts\utility::flag_wait("flood_road_trigger");
    maps\_utility::vision_set_changes("flood_road", 3);
    maps\_utility::lerp_saveddvar("sm_sunSampleSizeNear", 0.45, 1);

    while(common_scripts\utility::flag("flood_road_trigger"))
      common_scripts\utility::waitframe();

    maps\_utility::vision_set_fog_changes("", 0);
  }
}

set_enter_garage_mall_vf() {
  common_scripts\utility::flag_init("vs_garage1_trigger");

  for(;;) {
    common_scripts\utility::flag_wait("vs_garage1_trigger");
    setsaveddvar("sm_sunSampleSizeNear", 0.15);

    while(common_scripts\utility::flag("vs_garage1_trigger"))
      common_scripts\utility::waitframe();

    maps\_utility::vision_set_fog_changes("flood", 2);
    thread garage_malllight_off();
  }
}

garage_malllight_off() {
  var_0 = getEntArray("garage_mall_light", "targetname");

  foreach(var_2 in var_0)
  var_2 setlightradius(13);
}

set_mall_lights_off() {
  common_scripts\utility::flag_wait("garage_mall_light");
  setsaveddvar("sm_sunSampleSizeNear", 0.25);
}

set_warelights_off() {
  var_0 = getent("mall_light_off_trig", "targetname");

  if(isDefined(var_0)) {
    var_0 waittill("trigger");
    thread warelights_off();
  }
}

warelights_off() {
  var_0 = getEntArray("mall_light", "targetname");

  foreach(var_2 in var_0)
  var_2 setlightradius(13);
}

set_enter_canope_vf() {
  common_scripts\utility::flag_init("vs_canope_trigger");

  for(;;) {
    common_scripts\utility::flag_wait("vs_canope_trigger");
    visionsetnaked("flood", 4);
    level.cw_vision_above = "flood";

    while(common_scripts\utility::flag("vs_canope_trigger"))
      common_scripts\utility::waitframe();

    visionsetnaked("flood", 2.5);
    level.cw_vision_above = "flood";
  }
}

set_enter_loadingdocks_vf() {
  var_0 = getent("inside_loadingdocks_vf", "targetname");
  level.player maps\flood_util::set_water_fog("flood_underwater");
  level.player visionsetwaterforplayer("flood_underwater", 0);

  if(isDefined(var_0)) {
    var_0 waittill("trigger");
    setsaveddvar("sm_sunSampleSizeNear", 0.015);
    setsaveddvar("sm_sunshadowscale", 0.25);
    visionsetnaked("flood_warehouse", 0.75);
    maps\_utility::fog_set_changes("flood_warehouse", 0.25);
    level.player maps\flood_util::set_water_fog("flood_underwater");
    level.player visionsetwaterforplayer("flood_underwater", 0);
    level.cw_vision_above = "flood_warehouse";
    level.cw_fog_above = "flood_warehouse";
  }
}

set_enter_stairwell() {
  var_0 = getEntArray("lgt_off", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_0))
      var_2 hide();
  }

  var_4 = getent("enter_stairwell", "targetname");

  if(isDefined(var_4)) {
    var_4 waittill("trigger");

    if(!common_scripts\utility::flag("cw_player_underwater")) {
      visionsetnaked("flood_stairs", 5);
      maps\_utility::fog_set_changes("flood_stairs", 5);
      setsaveddvar("sm_sunSampleSizeNear", 0.2);
    }

    thread mall_light_cleanup();
    level.cw_vision_above = "flood_stairs";
    level.cw_fog_above = "flood_stairs";
  }
}

mall_light_cleanup() {
  var_0 = getEntArray("warevolumes", "targetname");
  var_1 = getEntArray("warelights", "targetname");
  var_2 = getent("punchLight", "targetname");
  var_3 = getent("upperFill", "targetname");
  setsaveddvar("sm_sunSampleSizeNear", 0.25);
  setsaveddvar("sm_sunshadowscale", 1);

  foreach(var_5 in var_0)
  var_5 delete();

  foreach(var_5 in var_1) {
    var_5 setlightintensity(0.15);
    var_5 setlightradius(13);
  }

  level.cw_vision_above = "flood_stairs";
  level.cw_fog_above = "flood_stairs";

  if(isDefined(var_2)) {
    var_2 setlightintensity(0.15);
    var_2 setlightradius(13);
  }

  if(isDefined(var_3))
    var_3 setlightintensity(0.4);

  if(maps\_utility::is_gen4()) {
    var_5 = maps\_utility::create_sunflare_setting("default");
    var_5.position = (-36.4966, -72.1857, 0);
    maps\_art::sunflare_changes("default", 0);
  }
}

light_flicker(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(maps\_utility::is_gen4()) {
    foreach(var_3 in var_1)
    var_3 thread flicker();
  } else {
    foreach(var_3 in var_1)
    var_3 thread flicker_cg();
  }
}

flicker() {
  change_light(0);
  maps\_utility::stop_exploder("stairwell_flare_01_01");
  wait 0.22;
  change_light(3);
  common_scripts\utility::exploder("stairwell_flare_01_01");
  wait 0.16;
  change_light(0);
  maps\_utility::stop_exploder("stairwell_flare_01_01");
  wait 0.1;
  change_light(4);
  common_scripts\utility::exploder("stairwell_flare_01_01");
  wait 0.19;
  change_light(0);
  maps\_utility::stop_exploder("stairwell_flare_01_01");
  wait 0.15;
  change_light(4);
  common_scripts\utility::exploder("stairwell_flare_01_01");
  wait 0.11;
  change_light(0);
  maps\_utility::stop_exploder("stairwell_flare_01_01");
  wait 0.19;
  change_light(4);
  common_scripts\utility::exploder("stairwell_flare_01_01");
}

flicker_cg() {
  change_light(0);
  maps\_utility::stop_exploder("stairwell_flare_01_01");
  wait 0.22;
  change_light(1);
  common_scripts\utility::exploder("stairwell_flare_01_01");
  wait 0.16;
  change_light(0);
  maps\_utility::stop_exploder("stairwell_flare_01_01");
  wait 0.1;
  change_light(2);
  common_scripts\utility::exploder("stairwell_flare_01_01");
  wait 0.19;
  change_light(0);
  maps\_utility::stop_exploder("stairwell_flare_01_01");
  wait 0.15;
  change_light(2);
  common_scripts\utility::exploder("stairwell_flare_01_01");
  wait 0.11;
  change_light(0);
  maps\_utility::stop_exploder("stairwell_flare_01_01");
  wait 0.19;
  change_light(2);
  common_scripts\utility::exploder("stairwell_flare_01_01");
}

change_light(var_0) {
  if(self.classname == "light_spot" || self.classname == "light_omni")
    self setlightintensity(var_0);

  if(self.classname == "script_model") {
    if(isDefined(self.script_noteworthy) && self.script_noteworthy == "lgt_on") {
      if(var_0 > 0)
        self show();
      else
        self hide();
    } else if(var_0 > 0)
      self hide();
    else
      self show();
  }
}

set_stairs_hall_vf() {
  var_0 = getent("stairwell_hall_vs", "script_noteworthy");

  if(isDefined(var_0)) {
    var_0 waittill("trigger");
    maps\_utility::vision_set_fog_changes("flood_stairs_hall", 3.5);
  }
}

set_enter_rooftop_1_vf() {
  var_0 = getent("fx_mall_rooftop", "targetname");

  if(isDefined(var_0)) {
    var_0 waittill("trigger");
    visionsetnaked("flood_rooftop_1", 7.35);
    maps\_utility::fog_set_changes("flood_rooftop_1", 0.5);
    setsaveddvar("sm_sunSampleSizeNear", 0.3);
    level.cw_vision_above = "flood";
    level.cw_fog_above = "flood_rooftop_1";
  }
}

set_enter_swept_vf() {
  setsaveddvar("sm_sunSampleSizeNear", 0.65);
  level.cw_vision_above = "flood_two";
  level.cw_fog_above = "flood_warehouse_lightson";

  if(maps\_utility::is_gen4()) {
    var_0 = maps\_utility::create_sunflare_setting("default");
    var_0.position = (-17, -114, 0);
    maps\_art::sunflare_changes("default", 0);
  }
}

set_enter_stealth_vf() {
  common_scripts\utility::flag_init("stealth_vs_trigger");

  for(;;) {
    common_scripts\utility::flag_wait("stealth_vs_trigger");
    maps\_utility::vision_set_fog_changes("flood_stealth", 1);
    level.cw_vision_above = "flood_stealth";
    level.cw_fog_above = "flood_stealth";
    level.player maps\flood_util::set_water_fog("flood_underwater_stealth");
    level.player visionsetwaterforplayer("flood_underwater_stealth", 0);

    while(common_scripts\utility::flag("stealth_vs_trigger"))
      common_scripts\utility::waitframe();

    setsaveddvar("sm_sunSampleSizeNear", 0.65);
    maps\_utility::vision_set_fog_changes("flood_two", 3);
    level.cw_vision_above = "flood_two";
    level.cw_fog_above = "flood_two";
    var_0 = getent("underwater_light", "targetname");

    if(isDefined(var_0)) {
      var_0 setlightintensity(0.15);
      var_0 setlightradius(13);
    }
  }
}

set_enter_rooftop_water() {
  var_0 = getent("flood_rooftop_water_vs", "targetname");

  if(isDefined(var_0)) {
    var_0 waittill("trigger");
    level.player maps\flood_util::set_water_fog("flood_underwater_rooftop");
    level.player visionsetwaterforplayer("flood_underwater_rooftop", 0);
    setsaveddvar("sm_sunSampleSizeNear", 0.2);
    level.cw_vision_above = "flood_two";
    level.cw_fog_above = "flood_two";
  }
}

set_enter_garage2_vf() {
  common_scripts\utility::flag_init("garage2_vs_trigger");

  for(;;) {
    common_scripts\utility::flag_wait("garage2_vs_trigger");

    if(!common_scripts\utility::flag("cw_player_underwater")) {
      visionsetnaked("flood_garage2", 3);
      maps\_utility::fog_set_changes("flood_garage2", 1);
      level.cw_vision_above = "flood_garage2";
      level.cw_fog_above = "flood_garage2";
      level.player maps\flood_util::set_water_fog("flood_underwater_dark");
      level.player visionsetwaterforplayer("flood_underwater_dark", 0);
    }

    while(common_scripts\utility::flag("garage2_vs_trigger") || common_scripts\utility::flag("cw_player_underwater"))
      common_scripts\utility::waitframe();

    maps\_utility::set_vision_set("flood_two");
    maps\_utility::vision_set_fog_changes("flood_two", 3);
    level.cw_vision_above = "flood_two";
    level.cw_fog_above = "flood_two";
  }
}

set_enter_skybridge_room_vf() {
  common_scripts\utility::flag_init("vs_skybridge_room_trigger");

  for(;;) {
    common_scripts\utility::flag_wait("vs_skybridge_room_trigger");
    maps\_utility::vision_set_changes("flood_skybridge_room", 3);
    maps\_utility::fog_set_changes("flood_two", 3);
    enableforcedsunshadows();
    var_0 = getent("skybridge_room_light", "targetname");

    if(isDefined(var_0))
      var_0 setlightradius(800);

    if(maps\_utility::is_gen4()) {
      var_1 = maps\_utility::create_sunflare_setting("default");
      var_1.position = (-48.0103, -49.9438, 0);
      maps\_art::sunflare_changes("default", 0);
    }

    setsaveddvar("sm_sunSampleSizeNear", 0.25);

    while(common_scripts\utility::flag("vs_skybridge_room_trigger"))
      common_scripts\utility::waitframe();

    visionsetnaked("flood_two", 3);
    maps\_utility::fog_set_changes("flood_two", 3);
    level.cw_vision_above = "flood_two";
    level.cw_fog_above = "flood_two";
    disableforcedsunshadows();

    if(maps\_utility::is_gen4()) {
      var_1 = maps\_utility::create_sunflare_setting("default");
      var_1.position = (-40, -71.5, 0);
      maps\_art::sunflare_changes("default", 0);
    }
  }
}

set_vf_end1() {
  maps\_utility::vision_set_fog_changes("flood_end1", 0.25);
  setsaveddvar("sm_sunSampleSizeNear", 0.15);
}

set_vf_end2() {
  maps\_utility::vision_set_fog_changes("flood_end2", 0.25);
  setsaveddvar("sm_sunSampleSizeNear", 0.16);
}

fx_create_bokehdots_source() {
  if(!isDefined(level.player.flood_bokehdot))
    level.player.flood_bokehdot = 0;

  if(!isDefined(level.flood_source_bokehdots)) {
    level.flood_source_bokehdots = spawn("script_model", (0, 0, 0));
    level.flood_source_bokehdots setModel("tag_origin");
    level.flood_source_bokehdots linktoplayerview(level.player, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
  }
}

fx_bokehdots_far() {
  fx_create_bokehdots_source();

  if(!common_scripts\utility::flag("cw_player_underwater")) {
    thread maps\_utility::delaythread(0.05, ::fx_waterdrops_3);

    if(level.player.flood_bokehdot <= 5) {
      level.player.flood_bokehdot++;
      playFXOnTag(common_scripts\utility::getfx("bokehdots_far"), level.flood_source_bokehdots, "tag_origin");
      wait 5;
      stopFXOnTag(common_scripts\utility::getfx("bokehdots_far"), level.flood_source_bokehdots, "tag_origin");
      level.player.flood_bokehdot--;
    }
  }
}

fx_bokehdots_close() {
  fx_create_bokehdots_source();

  if(!common_scripts\utility::flag("cw_player_underwater")) {
    thread maps\_utility::delaythread(0.05, ::fx_waterdrops_3);
    thread maps\_utility::delaythread(0.1, ::fx_waterdrops_3);

    if(level.player.flood_bokehdot <= 5) {
      level.player.flood_bokehdot++;
      playFXOnTag(common_scripts\utility::getfx("bokehdots_close"), level.flood_source_bokehdots, "tag_origin");
      wait 3;
      stopFXOnTag(common_scripts\utility::getfx("bokehdots_close"), level.flood_source_bokehdots, "tag_origin");
      level.player.flood_bokehdot--;
    }
  }
}

fx_turn_on_bokehdots_16_player() {
  fx_create_bokehdots_source();

  if(!common_scripts\utility::flag("cw_player_underwater"))
    playFXOnTag(common_scripts\utility::getfx("bokehdots_16"), level.flood_source_bokehdots, "tag_origin");
}

fx_turn_on_bokehdots_16_player_kill() {
  fx_create_bokehdots_source();

  if(common_scripts\utility::flag("cw_player_underwater"))
    killfxontag(common_scripts\utility::getfx("bokehdots_16"), level.flood_source_bokehdots, "tag_origin");
}

fx_turn_on_bokehdots_32_player() {
  fx_create_bokehdots_source();

  if(!common_scripts\utility::flag("cw_player_underwater"))
    playFXOnTag(common_scripts\utility::getfx("bokehdots_32"), level.flood_source_bokehdots, "tag_origin");
}

fx_turn_on_bokehdots_64_player() {
  fx_create_bokehdots_source();

  if(!common_scripts\utility::flag("cw_player_underwater"))
    playFXOnTag(common_scripts\utility::getfx("bokehdots_64"), level.flood_source_bokehdots, "tag_origin");
}

fx_waterdrops_3() {
  fx_create_bokehdots_source();

  if(!common_scripts\utility::flag("cw_player_underwater"))
    playFXOnTag(common_scripts\utility::getfx("waterdrops_3"), level.flood_source_bokehdots, "tag_origin");
}

fx_waterdrops_20_inst() {
  fx_create_bokehdots_source();

  if(!common_scripts\utility::flag("cw_player_underwater"))
    playFXOnTag(common_scripts\utility::getfx("waterdrops_20_inst"), level.flood_source_bokehdots, "tag_origin");
}

fx_waterdrops_20_inst_kill() {
  fx_create_bokehdots_source();

  if(common_scripts\utility::flag("cw_player_underwater"))
    killfxontag(common_scripts\utility::getfx("waterdrops_20_inst"), level.flood_source_bokehdots, "tag_origin");
}

fx_bokehdots_and_waterdrops_heavy(var_0) {
  fx_create_bokehdots_source();

  if(!isDefined(var_0))
    var_0 = 5;

  if(!common_scripts\utility::flag("cw_player_underwater") && level.player.flood_bokehdot <= 5) {
    level.player.flood_bokehdot++;
    playFXOnTag(common_scripts\utility::getfx("bokehdots_and_waterdrops_heavy"), level.flood_source_bokehdots, "tag_origin");
    wait(var_0);
    stopFXOnTag(common_scripts\utility::getfx("bokehdots_and_waterdrops_heavy"), level.flood_source_bokehdots, "tag_origin");
    level.player.flood_bokehdot--;
  }
}

bokehdots_audition_test() {
  self endon("death");
  self notify("stop raining_bokeh");
  self endon("stop raining_bokeh");
  self.has_raining_bokeh = 1;

  while(isDefined(self)) {
    wait 0.05;

    if(!isDefined(self)) {
      break;
    }

    thread fx_turn_on_bokehdots_16_player();
    wait 5;
    thread fx_turn_on_bokehdots_32_player();
    wait 5;
    thread fx_turn_on_bokehdots_64_player();
    wait 5;
  }
}

fx_angry_flood_nearmiss(var_0) {
  self waittill("trigger");

  if(!isDefined(level.flood_near_miss))
    level.flood_near_miss = 0;

  if(!level.flood_near_miss) {
    level.flood_near_miss = 1;
    thread fx_turn_on_bokehdots_16_player();
    thread fx_waterdrops_20_inst();
    level.player setwatersheeting(1, 1.5);
    wait(randomfloatrange(0.7, 1.1));
    level.flood_near_miss = 0;
  } else if(isDefined(var_0) && var_0)
    self delete();
}

fx_stealth_ambient() {
  level endon("skybridge_done");
  common_scripts\utility::exploder("stealth_abovewater_fx");
  var_0 = getent("stealth_fx", "targetname");
  var_1 = spawn("script_model", (4305.04, -2671.81, 10.0624));
  var_1 setModel("tag_origin");
  var_1.angles = (9.20515, 151.609, 176.876);

  for(;;) {
    common_scripts\utility::flag_wait("cw_player_underwater");
    maps\_utility::stop_exploder("stealth_abovewater_fx");
    playFXOnTag(level._effect["flood_underwater_godrays_small"], var_1, "tag_origin");
    playFXOnTag(common_scripts\utility::getfx("flood_particlulates_light_02"), var_0, "parts_light_02_01");
    playFXOnTag(common_scripts\utility::getfx("flood_floating_paper_slow"), var_0, "float_paper_slow_01");
    playFXOnTag(common_scripts\utility::getfx("flood_particlulates_02"), var_0, "parts_02_01");
    common_scripts\utility::waitframe();
    playFXOnTag(common_scripts\utility::getfx("flood_floating_bottles_slow"), var_0, "float_bottles_slow_01");
    playFXOnTag(common_scripts\utility::getfx("flood_particlulates_02"), var_0, "parts_02_02");
    playFXOnTag(common_scripts\utility::getfx("flood_floating_paper_slow"), var_0, "float_paper_slow_02");
    common_scripts\utility::waitframe();
    playFXOnTag(common_scripts\utility::getfx("flood_floating_bottles_slow"), var_0, "float_bottles_slow_02");
    playFXOnTag(common_scripts\utility::getfx("flood_particlulates_02"), var_0, "parts_02_04");
    playFXOnTag(common_scripts\utility::getfx("flood_particlulates_02"), var_0, "parts_02_03");
    common_scripts\utility::waitframe();
    playFXOnTag(common_scripts\utility::getfx("flood_particlulates_light_02"), var_0, "parts_light_02_02");
    common_scripts\utility::flag_wait("cw_player_abovewater");
    killfxontag(level._effect["flood_underwater_godrays_small"], var_1, "tag_origin");
    common_scripts\utility::exploder("stealth_abovewater_fx");
    killfxontag(common_scripts\utility::getfx("flood_particlulates_light_02"), var_0, "parts_light_02_01");
    killfxontag(common_scripts\utility::getfx("flood_floating_paper_slow"), var_0, "float_paper_slow_01");
    killfxontag(common_scripts\utility::getfx("flood_particlulates_02"), var_0, "parts_02_01");
    common_scripts\utility::waitframe();
    killfxontag(common_scripts\utility::getfx("flood_floating_bottles_slow"), var_0, "float_bottles_slow_01");
    killfxontag(common_scripts\utility::getfx("flood_particlulates_02"), var_0, "parts_02_02");
    killfxontag(common_scripts\utility::getfx("flood_floating_paper_slow"), var_0, "float_paper_slow_02");
    common_scripts\utility::waitframe();
    killfxontag(common_scripts\utility::getfx("flood_floating_bottles_slow"), var_0, "float_bottles_slow_02");
    killfxontag(common_scripts\utility::getfx("flood_particlulates_02"), var_0, "parts_02_04");
    killfxontag(common_scripts\utility::getfx("flood_particlulates_02"), var_0, "parts_02_03");
    common_scripts\utility::waitframe();
    killfxontag(common_scripts\utility::getfx("flood_particlulates_light_02"), var_0, "parts_light_02_02");
  }
}

start_ally1_bubbles(var_0) {
  for(;;) {
    common_scripts\utility::flag_wait("cw_player_underwater");
    playFXOnTag(common_scripts\utility::getfx("bubbles_stealth_runner"), var_0, "J_Ankle_LE");
    playFXOnTag(common_scripts\utility::getfx("bubbles_stealth_runner"), var_0, "J_Ankle_RI");
    common_scripts\utility::waitframe();
    playFXOnTag(common_scripts\utility::getfx("bubbles_stealth_runner"), var_0, "J_Knee_RI");
    common_scripts\utility::waitframe();
    playFXOnTag(common_scripts\utility::getfx("bubbles_stealth_runner"), var_0, "J_Knee_LE");
    common_scripts\utility::flag_wait("cw_player_abovewater");
    killfxontag(common_scripts\utility::getfx("bubbles_stealth_runner"), var_0, "J_Ankle_LE");
    killfxontag(common_scripts\utility::getfx("bubbles_stealth_runner"), var_0, "J_Ankle_RI");
    common_scripts\utility::waitframe();
    killfxontag(common_scripts\utility::getfx("bubbles_stealth_runner"), var_0, "J_Knee_RI");
    killfxontag(common_scripts\utility::getfx("bubbles_stealth_runner"), var_0, "J_Knee_LE");
  }
}

start_ally1_submerge_bubbles(var_0) {
  for(;;) {
    common_scripts\utility::flag_wait("cw_player_underwater");
    playFXOnTag(common_scripts\utility::getfx("bubbles_stealth_emit"), var_0, "J_Ankle_LE");
    common_scripts\utility::waitframe();
    playFXOnTag(common_scripts\utility::getfx("bubbles_stealth_emit"), var_0, "J_Ankle_RI");
    common_scripts\utility::waitframe();
    playFXOnTag(common_scripts\utility::getfx("bubbles_stealth_emit"), var_0, "J_Knee_RI");
    common_scripts\utility::waitframe();
    playFXOnTag(common_scripts\utility::getfx("bubbles_stealth_emit"), var_0, "J_Knee_LE");
    common_scripts\utility::flag_wait("cw_player_abovewater");
    killfxontag(common_scripts\utility::getfx("bubbles_stealth_emit"), var_0, "J_Ankle_LE");
    common_scripts\utility::waitframe();
    killfxontag(common_scripts\utility::getfx("bubbles_stealth_emit"), var_0, "J_Ankle_RI");
    common_scripts\utility::waitframe();
    killfxontag(common_scripts\utility::getfx("bubbles_stealth_emit"), var_0, "J_Knee_RI");
    common_scripts\utility::waitframe();
    killfxontag(common_scripts\utility::getfx("bubbles_stealth_emit"), var_0, "J_Knee_LE");
    common_scripts\utility::waitframe();
  }
}

kill_ally1_submerge_bubbles(var_0) {
  stopFXOnTag(common_scripts\utility::getfx("bubbles_stealth_emit"), var_0, "J_Ankle_LE");
  common_scripts\utility::waitframe();
  stopFXOnTag(common_scripts\utility::getfx("bubbles_stealth_emit"), var_0, "J_Ankle_RI");
  common_scripts\utility::waitframe();
  stopFXOnTag(common_scripts\utility::getfx("bubbles_stealth_emit"), var_0, "J_Knee_RI");
  common_scripts\utility::waitframe();
  stopFXOnTag(common_scripts\utility::getfx("bubbles_stealth_emit"), var_0, "J_Knee_LE");
}

ally1_emerge_splash(var_0) {
  iprintln("ally1_emerge_splash");
}

allie1_tussbubbs(var_0) {
  for(var_1 = 0; var_1 < 100; var_1++) {
    if(common_scripts\utility::flag("cw_player_underwater"))
      playFXOnTag(common_scripts\utility::getfx("tussle_bubbles_emit"), var_0, "J_Knee_RI");
    else if(common_scripts\utility::flag("cw_player_abovewater"))
      killfxontag(common_scripts\utility::getfx("tussle_bubbles_emit"), var_0, "J_Knee_RI");

    common_scripts\utility::waitframe();
  }

  killfxontag(common_scripts\utility::getfx("tussle_bubbles_emit"), var_0, "J_Knee_RI");
}

opfor3_tussbubbs(var_0) {
  for(var_1 = 0; var_1 < 100; var_1++) {
    if(common_scripts\utility::flag("cw_player_underwater"))
      playFXOnTag(common_scripts\utility::getfx("tussle_bubbles_emit"), var_0, "J_Knee_LE");
    else if(common_scripts\utility::flag("cw_player_abovewater"))
      killfxontag(common_scripts\utility::getfx("tussle_bubbles_emit"), var_0, "J_Knee_LE");

    common_scripts\utility::waitframe();
  }

  killfxontag(common_scripts\utility::getfx("tussle_bubbles_emit"), var_0, "J_Knee_LE");
}

fx_ally1_kill_upper_bubbles(var_0) {}

fx_opfor3_tussle_bubbles(var_0) {
  for(;;) {
    common_scripts\utility::flag_wait("cw_player_underwater");
    playFXOnTag(common_scripts\utility::getfx("bubbles_stealth_runner"), var_0, "J_Ankle_LE");
    playFXOnTag(common_scripts\utility::getfx("bubbles_stealth_runner"), var_0, "J_Ankle_RI");
    common_scripts\utility::waitframe();
    playFXOnTag(common_scripts\utility::getfx("bubbles_stealth_runner"), var_0, "J_Knee_RI");
    common_scripts\utility::waitframe();
    playFXOnTag(common_scripts\utility::getfx("bubbles_stealth_runner"), var_0, "J_Knee_LE");
    common_scripts\utility::flag_wait("cw_player_abovewater");
    killfxontag(common_scripts\utility::getfx("bubbles_stealth_runner"), var_0, "J_Ankle_LE");
    killfxontag(common_scripts\utility::getfx("bubbles_stealth_runner"), var_0, "J_Ankle_RI");
    common_scripts\utility::waitframe();
    killfxontag(common_scripts\utility::getfx("bubbles_stealth_runner"), var_0, "J_Knee_RI");
    killfxontag(common_scripts\utility::getfx("bubbles_stealth_runner"), var_0, "J_Knee_LE");
  }
}

fx_opfor3_pushdown_bubbles(var_0) {
  for(;;) {
    common_scripts\utility::flag_wait("cw_player_underwater");
    playFXOnTag(common_scripts\utility::getfx("bubbles_stealth_runner"), var_0, "J_Elbow_LE");
    common_scripts\utility::waitframe();
    playFXOnTag(common_scripts\utility::getfx("bubbles_stealth_runner"), var_0, "J_Elbow_RI");
    common_scripts\utility::waitframe();
    playFXOnTag(common_scripts\utility::getfx("bubbles_stealth_runner"), var_0, "J_Mid_RI_1");
    common_scripts\utility::waitframe();
    playFXOnTag(common_scripts\utility::getfx("bubbles_stealth_runner"), var_0, "J_Mid_LE_1");
    common_scripts\utility::flag_wait("cw_player_abovewater");
    killfxontag(common_scripts\utility::getfx("bubbles_stealth_runner"), var_0, "J_Elbow_LE");
    common_scripts\utility::waitframe();
    killfxontag(common_scripts\utility::getfx("bubbles_stealth_runner"), var_0, "J_Elbow_RI");
    common_scripts\utility::waitframe();
    killfxontag(common_scripts\utility::getfx("bubbles_stealth_runner"), var_0, "J_Mid_RI_1");
    common_scripts\utility::waitframe();
    killfxontag(common_scripts\utility::getfx("bubbles_stealth_runner"), var_0, "J_Mid_LE_1");
    common_scripts\utility::waitframe();
  }
}

fx_ally1_kill_tussle_bubbles_02(var_0) {}

fx_stealthkill_02_blood_01(var_0) {
  playFXOnTag(common_scripts\utility::getfx("vfx_flesh_knife_hit_underwater"), var_0, "J_Index_RI_1");
}

fx_stealthkill_02_blood_02(var_0) {
  playFXOnTag(common_scripts\utility::getfx("vfx_flesh_knife_hit"), var_0, "J_Clavicle_RI");
}

fx_stealthkill_02_opfor2_blood_01(var_0) {
  playFXOnTag(common_scripts\utility::getfx("vfx_flesh_flood_exit"), var_0, "TAG_EYE");
}

fx_stealthkill_02_opfor2_blood_02(var_0) {
  playFXOnTag(common_scripts\utility::getfx("vfx_flesh_flood_exit"), var_0, "TAG_EYE");
  common_scripts\utility::waitframe();
}

fx_hatchet_face_1(var_0) {
  playFXOnTag(common_scripts\utility::getfx("blood_stealth_hatchet"), var_0, "TAG_INHAND");
  wait 0.5;
  stopFXOnTag(common_scripts\utility::getfx("blood_stealth_hatchet"), var_0, "TAG_INHAND");
}

fx_rooftops_wall_kick() {
  wait 13.08;
  common_scripts\utility::exploder("rooftop1_wall_kick_dust");
}

fx_infil_heli_smoke() {
  playFXOnTag(common_scripts\utility::getfx("flood_intro_heli_smoke"), level.cw_player_view_fx_source, "tag_origin");
}

fx_lens_drops_01() {
  common_scripts\utility::flag_init("lens_drops_01");
  common_scripts\utility::flag_wait("lens_drops_01");
  fx_create_bokehdots_source();
  playFXOnTag(common_scripts\utility::getfx("bokehdots_close"), level.flood_source_bokehdots, "tag_origin");
  wait 5;
  playFXOnTag(common_scripts\utility::getfx("bokehdots_16"), level.flood_source_bokehdots, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("bokehdots_close"), level.flood_source_bokehdots, "tag_origin");
  wait 2;
  playFXOnTag(common_scripts\utility::getfx("bokehdots_16"), level.flood_source_bokehdots, "tag_origin");
}

fx_lens_drops_02() {
  common_scripts\utility::flag_init("lens_drops_02");
  common_scripts\utility::flag_wait("lens_drops_02");
  fx_create_bokehdots_source();
  playFXOnTag(common_scripts\utility::getfx("bokehdots_close"), level.flood_source_bokehdots, "tag_origin");
  wait 1.5;
  playFXOnTag(common_scripts\utility::getfx("bokehdots_16"), level.flood_source_bokehdots, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("bokehdots_close"), level.flood_source_bokehdots, "tag_origin");
}

fx_lens_drops_03() {
  common_scripts\utility::flag_init("lens_drops_03");
  common_scripts\utility::flag_wait("lens_drops_03");
  fx_create_bokehdots_source();
  playFXOnTag(common_scripts\utility::getfx("bokehdots_close"), level.flood_source_bokehdots, "tag_origin");
  wait 1.5;
  playFXOnTag(common_scripts\utility::getfx("bokehdots_16"), level.flood_source_bokehdots, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("bokehdots_close"), level.flood_source_bokehdots, "tag_origin");
  wait 2.5;
  playFXOnTag(common_scripts\utility::getfx("bokehdots_64"), level.flood_source_bokehdots, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("bokehdots_close"), level.flood_source_bokehdots, "tag_origin");
}

fx_lens_drops_04() {
  common_scripts\utility::flag_init("lens_drops_04");
  common_scripts\utility::flag_wait("lens_drops_04");
  fx_create_bokehdots_source();
  playFXOnTag(common_scripts\utility::getfx("bokehdots_close"), level.flood_source_bokehdots, "tag_origin");
  wait 1.5;
  playFXOnTag(common_scripts\utility::getfx("bokehdots_16"), level.flood_source_bokehdots, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("bokehdots_close"), level.flood_source_bokehdots, "tag_origin");
}

fx_lens_drops_05() {
  common_scripts\utility::flag_init("lens_drops_05");
  common_scripts\utility::flag_wait("lens_drops_05");
  fx_create_bokehdots_source();
  playFXOnTag(common_scripts\utility::getfx("bokehdots_close"), level.flood_source_bokehdots, "tag_origin");
  wait 1.5;
  playFXOnTag(common_scripts\utility::getfx("bokehdots_16"), level.flood_source_bokehdots, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("bokehdots_close"), level.flood_source_bokehdots, "tag_origin");
}

fx_lens_drops_06() {
  common_scripts\utility::flag_init("lens_drops_06");
  common_scripts\utility::flag_wait("lens_drops_06");
  fx_create_bokehdots_source();
  playFXOnTag(common_scripts\utility::getfx("bokehdots_close"), level.flood_source_bokehdots, "tag_origin");
  wait 3;
  playFXOnTag(common_scripts\utility::getfx("bokehdots_16"), level.flood_source_bokehdots, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("bokehdots_close"), level.flood_source_bokehdots, "tag_origin");
}

fx_skybridge_room_bokeh_01() {
  common_scripts\utility::flag_init("skybridge_room_bokeh_01");
  common_scripts\utility::flag_wait("skybridge_room_bokeh_01");
  fx_create_bokehdots_source();
  playFXOnTag(common_scripts\utility::getfx("bokehdots_64"), level.flood_source_bokehdots, "tag_origin");
  wait 0.5;
  playFXOnTag(common_scripts\utility::getfx("bokehdots_64"), level.flood_source_bokehdots, "tag_origin");
}

fx_skybridge_room_bokeh_02() {
  common_scripts\utility::flag_init("skybridge_room_bokeh_02");
  common_scripts\utility::flag_wait("skybridge_room_bokeh_02");
  fx_create_bokehdots_source();
  playFXOnTag(common_scripts\utility::getfx("bokehdots_64"), level.flood_source_bokehdots, "tag_origin");
  wait 0.5;
  playFXOnTag(common_scripts\utility::getfx("bokehdots_64"), level.flood_source_bokehdots, "tag_origin");
  wait 0.5;
  playFXOnTag(common_scripts\utility::getfx("bokehdots_64"), level.flood_source_bokehdots, "tag_origin");
}

fx_rooftop2_ambient() {
  level endon("garage_done");
  var_0 = (6594.5, 1166.99, 88.4814);
  var_1 = (275.918, 149.516, 122.354);
  var_2 = anglestoup(var_1);
  var_3 = anglesToForward(var_1);
  var_4 = spawnfx(level._effect["rapids_splash_lg_flood"], var_0, var_3, var_2);
  triggerfx(var_4, -10);
  var_5 = (8911.14, 5420.6, 676.794);
  var_6 = (271, 89.9991, 15.0009);
  var_7 = anglestoup(var_6);
  var_8 = anglesToForward(var_6);
  var_9 = spawnfx(level._effect["infil_building_smoke"], var_5, var_8, var_7);
  triggerfx(var_9, -10);
  wait 0.5;
  var_4 delete();
  var_9 delete();
  var_10 = spawn("script_model", (6594.5, 1166.99, 88.4814));
  var_10 setModel("tag_origin");
  var_10.angles = (275.918, 149.516, 122.354);
  playFXOnTag(level._effect["rapids_splash_lg_flood"], var_10, "tag_origin");
  var_11 = spawn("script_model", (8911.14, 5420.6, 676.794));
  var_11 setModel("tag_origin");
  var_11.angles = (271, 89.9991, 15.0009);
  playFXOnTag(level._effect["infil_building_smoke"], var_11, "tag_origin");
  var_12 = spawn("script_model", (5747.79, 2465.89, 572.248));
  var_12 setModel("tag_origin");
  var_12.angles = (270, 0, 85);
  playFXOnTag(level._effect["amb_dust_dark_building_smolder"], var_12, "tag_origin");
  var_13 = spawn("script_model", (5999.97, 941.621, 120.763));
  var_13 setModel("tag_origin");
  var_13.angles = (357, 160, 34.0001);
  playFXOnTag(level._effect["amb_dust_dark_building_smolder_small"], var_13, "tag_origin");
  var_14 = spawn("script_model", (4670.23, 1203.72, 191.125));
  var_14 setModel("tag_origin");
  var_14.angles = (271, 89.9999, 103);
  playFXOnTag(level._effect["infil_ground_smk_plume"], var_14, "tag_origin");
  var_15 = spawn("script_model", (6068.62, 988.48, 41.5316));
  var_15 setModel("tag_origin");
  var_16 = spawn("script_model", (6143.24, 1244.93, 41.5316));
  var_16 setModel("tag_origin");
  var_17 = spawn("script_model", (5860.72, 1216.7, 41.5316));
  var_17 setModel("tag_origin");
  var_18 = spawn("script_model", (5897.89, 745.63, 41.5316));
  var_18 setModel("tag_origin");
  var_19 = [];
  var_19[0] = spawn("script_model", (4520.26, 1723, 189.237));
  var_19[0] setModel("tag_origin");
  var_19[0].angles = (270, 0, 0);
  var_19[0].fx = spawnfx(level._effect["amb_dust_light_large_mixlit"], var_19[0].origin, anglesToForward(var_19[0].angles), anglestoup(var_19[0].angles));
  playFXOnTag(level._effect["amb_dust_light_large_mixlit"], var_19[0], "tag_origin");
  var_19[1] = spawn("script_model", (4878.89, 2534.12, 296.628));
  var_19[1] setModel("tag_origin");
  var_19[1].angles = (270, 0, 0);
  var_19[1].fx = spawnfx(level._effect["amb_dust_light_large_mixlit"], var_19[1].origin, anglesToForward(var_19[1].angles), anglestoup(var_19[1].angles));
  playFXOnTag(level._effect["amb_dust_light_large_mixlit"], var_19[1], "tag_origin");
  var_19[2] = spawn("script_model", (7730.65, 420.492, 178.282));
  var_19[2] setModel("tag_origin");
  var_19[2].angles = (270, 0, 0);
  var_19[2].fx = spawnfx(level._effect["amb_dust_light_large_mixlit"], var_19[2].origin, anglesToForward(var_19[2].angles), anglestoup(var_19[2].angles));
  playFXOnTag(level._effect["amb_dust_light_large_mixlit"], var_19[2], "tag_origin");
  var_19[3] = spawn("script_model", (6625.54, 2302.83, 111.438));
  var_19[3] setModel("tag_origin");
  var_19[3].angles = (270, 0, 0);
  var_19[3].fx = spawnfx(level._effect["amb_dust_light_large_mixlit"], var_19[3].origin, anglesToForward(var_19[3].angles), anglestoup(var_19[3].angles));
  playFXOnTag(level._effect["amb_dust_light_large_mixlit"], var_19[3], "tag_origin");
  var_19[4] = spawn("script_model", (8295, 1863.22, 60.4229));
  var_19[4] setModel("tag_origin");
  var_19[4].angles = (270, 0, 0);
  var_19[4].fx = spawnfx(level._effect["amb_dust_light_large_mixlit"], var_19[4].origin, anglesToForward(var_19[4].angles), anglestoup(var_19[4].angles));
  playFXOnTag(level._effect["amb_dust_light_large_mixlit"], var_19[4], "tag_origin");
  var_19[5] = spawn("script_model", (9254.78, 3518.53, 305.243));
  var_19[5] setModel("tag_origin");
  var_19[5].angles = (270, 0, 0);
  var_19[5].fx = spawnfx(level._effect["amb_dust_light_large_mixlit"], var_19[5].origin, anglesToForward(var_19[5].angles), anglestoup(var_19[5].angles));
  playFXOnTag(level._effect["amb_dust_light_large_mixlit"], var_19[5], "tag_origin");
  var_19[6] = spawn("script_model", (4267.69, -729.585, -68.4832));
  var_19[6] setModel("tag_origin");
  var_19[6].angles = (270, 0, 0);
  var_19[6].fx = spawnfx(level._effect["amb_dust_light_large_mixlit"], var_19[6].origin, anglesToForward(var_19[6].angles), anglestoup(var_19[6].angles));
  playFXOnTag(level._effect["amb_dust_light_large_mixlit"], var_19[6], "tag_origin");
  var_19[7] = spawn("script_model", (4433.89, 158.192, 117.025));
  var_19[7] setModel("tag_origin");
  var_19[7].angles = (270, 0, 0);
  var_19[7].fx = spawnfx(level._effect["amb_dust_light_large_mixlit"], var_19[7].origin, anglesToForward(var_19[7].angles), anglestoup(var_19[7].angles));
  playFXOnTag(level._effect["amb_dust_light_large_mixlit"], var_19[7], "tag_origin");

  for(;;) {
    common_scripts\utility::flag_wait("cw_player_underwater");
    maps\_utility::stop_exploder("rooftop2_abovewater_fx");

    foreach(var_21 in var_19) {
      killfxontag(level._effect["amb_dust_light_large_mixlit"], var_21, "tag_origin");
      var_21.fx delete();
      var_21.fx = spawnfx(level._effect["amb_dust_light_large_mixlit"], var_21.origin, anglesToForward(var_19[0].angles), anglestoup(var_19[0].angles));
    }

    playFXOnTag(common_scripts\utility::getfx("flood_underwater_debris"), var_15, "tag_origin");
    playFXOnTag(common_scripts\utility::getfx("flood_underwater_debris"), var_16, "tag_origin");
    playFXOnTag(common_scripts\utility::getfx("flood_underwater_debris"), var_17, "tag_origin");
    playFXOnTag(common_scripts\utility::getfx("flood_underwater_debris"), var_18, "tag_origin");
    killfxontag(level._effect["rapids_splash_lg_flood"], var_10, "tag_origin");
    killfxontag(level._effect["infil_building_smoke"], var_11, "tag_origin");
    killfxontag(level._effect["amb_dust_dark_building_smolder"], var_12, "tag_origin");
    killfxontag(level._effect["amb_dust_dark_building_smolder_small"], var_13, "tag_origin");
    killfxontag(level._effect["infil_ground_smk_plume"], var_14, "tag_origin");
    common_scripts\utility::flag_wait("cw_player_abovewater");
    common_scripts\utility::exploder("rooftop2_abovewater_fx");

    foreach(var_21 in var_19) {
      playFXOnTag(level._effect["amb_dust_light_large_mixlit"], var_21, "tag_origin");
      triggerfx(var_21.fx, -15);
    }

    killfxontag(common_scripts\utility::getfx("flood_underwater_debris"), var_15, "tag_origin");
    killfxontag(common_scripts\utility::getfx("flood_underwater_debris"), var_16, "tag_origin");
    killfxontag(common_scripts\utility::getfx("flood_underwater_debris"), var_17, "tag_origin");
    killfxontag(common_scripts\utility::getfx("flood_underwater_debris"), var_18, "tag_origin");
    playFXOnTag(level._effect["rapids_splash_lg_flood"], var_10, "tag_origin");
    playFXOnTag(level._effect["infil_building_smoke"], var_11, "tag_origin");
    playFXOnTag(level._effect["amb_dust_dark_building_smolder"], var_12, "tag_origin");
    playFXOnTag(level._effect["amb_dust_dark_building_smolder_small"], var_13, "tag_origin");
    playFXOnTag(level._effect["infil_ground_smk_plume"], var_14, "tag_origin");
    wait 0.5;

    foreach(var_21 in var_19) {
      var_21.fx delete();
      var_21.fx = spawnfx(level._effect["amb_dust_light_large_mixlit"], var_21.origin, anglesToForward(var_19[0].angles), anglestoup(var_19[0].angles));
    }
  }
}

fx_parking_garage_hide_godrays() {
  var_0 = getent("garage_godrays", "targetname");
  var_0 hide();
}

fx_parking_garage_ambient() {
  var_0 = getent("garage_godrays", "targetname");
  var_0 show();
  var_1 = spawn("script_model", (5632.1, 3284.31, 112.468));
  var_1 setModel("tag_origin");
  var_1.angles = (0, 132, 0);
  playFXOnTag(level._effect["amb_dust_dark_building_smolder_small"], var_1, "tag_origin");
  var_2 = spawn("script_model", (5605.39, 3306.96, 146.095));
  var_2 setModel("tag_origin");
  var_2.angles = (358.715, 245.017, 178.467);
  playFXOnTag(level._effect["vfx_sparks_blown_slow"], var_2, "tag_origin");
  var_3 = spawn("script_model", (5590.92, 3297.94, 125.009));
  var_3 setModel("tag_origin");
  playFXOnTag(level._effect["vfx_fire_wall_small"], var_3, "tag_origin");
  var_4 = spawn("script_model", (5334.24, 2730.68, 13.7302));
  var_4 setModel("tag_origin");
  var_5 = spawn("script_model", (5339.51, 3015.52, 13.7302));
  var_5 setModel("tag_origin");
  var_6 = spawn("script_model", (5271.96, 3285.41, 13.7302));
  var_6 setModel("tag_origin");
  var_7 = spawn("script_model", (5629.7, 3160.47, 13.7302));
  var_7 setModel("tag_origin");
  var_8 = spawn("script_model", (5858.21, 3390.74, 13.7302));
  var_8 setModel("tag_origin");
  var_9 = spawn("script_model", (5718.31, 3637.66, 13.7302));
  var_9 setModel("tag_origin");
  var_10 = spawn("script_model", (6064.32, 3601.74, 13.7302));
  var_10 setModel("tag_origin");
  var_11 = spawn("script_model", (5916.76, 3884.32, 13.7302));
  var_11 setModel("tag_origin");
  var_12 = spawn("script_model", (6292.98, 3830.39, 13.7302));
  var_12 setModel("tag_origin");

  for(;;) {
    common_scripts\utility::flag_wait("cw_player_underwater");
    var_0 hide();
    playFXOnTag(common_scripts\utility::getfx("flood_underwater_debris"), var_4, "tag_origin");
    playFXOnTag(common_scripts\utility::getfx("flood_underwater_debris"), var_5, "tag_origin");
    playFXOnTag(common_scripts\utility::getfx("flood_underwater_debris"), var_6, "tag_origin");
    playFXOnTag(common_scripts\utility::getfx("flood_underwater_debris"), var_7, "tag_origin");
    playFXOnTag(common_scripts\utility::getfx("flood_underwater_debris"), var_8, "tag_origin");
    playFXOnTag(common_scripts\utility::getfx("flood_underwater_debris"), var_9, "tag_origin");
    playFXOnTag(common_scripts\utility::getfx("flood_underwater_debris"), var_10, "tag_origin");
    playFXOnTag(common_scripts\utility::getfx("flood_underwater_debris"), var_11, "tag_origin");
    playFXOnTag(common_scripts\utility::getfx("flood_underwater_debris"), var_12, "tag_origin");
    killfxontag(level._effect["amb_dust_dark_building_smolder_small"], var_1, "tag_origin");
    killfxontag(level._effect["vfx_sparks_blown_slow"], var_2, "tag_origin");
    killfxontag(level._effect["vfx_fire_wall_small"], var_3, "tag_origin");
    common_scripts\utility::flag_wait("cw_player_abovewater");
    var_0 show();
    killfxontag(common_scripts\utility::getfx("flood_underwater_debris"), var_4, "tag_origin");
    killfxontag(common_scripts\utility::getfx("flood_underwater_debris"), var_5, "tag_origin");
    killfxontag(common_scripts\utility::getfx("flood_underwater_debris"), var_6, "tag_origin");
    killfxontag(common_scripts\utility::getfx("flood_underwater_debris"), var_7, "tag_origin");
    killfxontag(common_scripts\utility::getfx("flood_underwater_debris"), var_8, "tag_origin");
    killfxontag(common_scripts\utility::getfx("flood_underwater_debris"), var_9, "tag_origin");
    killfxontag(common_scripts\utility::getfx("flood_underwater_debris"), var_10, "tag_origin");
    killfxontag(common_scripts\utility::getfx("flood_underwater_debris"), var_11, "tag_origin");
    killfxontag(common_scripts\utility::getfx("flood_underwater_debris"), var_12, "tag_origin");
    playFXOnTag(level._effect["amb_dust_dark_building_smolder_small"], var_1, "tag_origin");
    playFXOnTag(level._effect["vfx_sparks_blown_slow"], var_2, "tag_origin");
    playFXOnTag(level._effect["vfx_fire_wall_small"], var_3, "tag_origin");
  }
}

treadfx_override() {
  var_0 = "vfx/moments/flood/rooftop1_heli_dust_kickup";
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "brick", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "bark", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "carpet", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "cloth", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "concrete", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "dirt", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "flesh", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "foliage", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "glass", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "grass", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "gravel", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "ice", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "metal", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "mud", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "paper", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "plaster", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "rock", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "sand", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "snow", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "water", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "wood", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "asphalt", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "ceramic", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "plastic", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "rubber", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "cushion", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "fruit", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "painted metal", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "default", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "none", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "brick", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "bark", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "carpet", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "cloth", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "concrete", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "dirt", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "flesh", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "foliage", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "glass", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "grass", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "gravel", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "ice", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "metal", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "mud", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "paper", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "plaster", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "rock", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "sand", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "snow", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "water", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "wood", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "asphalt", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "ceramic", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "plastic", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "rubber", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "cushion", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "fruit", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "painted metal", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "default", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "none", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "brick", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "bark", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "carpet", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "cloth", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "concrete", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "dirt", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "flesh", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "foliage", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "glass", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "grass", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "gravel", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "ice", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "metal", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "mud", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "paper", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "plaster", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "rock", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "sand", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "snow", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "water", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "wood", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "asphalt", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "ceramic", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "plastic", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "rubber", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "cushion", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "fruit", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "painted metal", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "default", var_0);
  maps\_treadfx::setvehiclefx("script_vehicle_nh90 ", "none", var_0);
}

character_make_wet(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = [];
  var_2[0] = "J_Elbow_LE";
  var_2[1] = "J_Elbow_RI";
  var_2[2] = "J_Wrist_LE";
  var_2[3] = "J_Wrist_RI";
  var_2[4] = "TAG_STOWED_BACK";
  var_2[5] = "J_Neck";

  if(var_1)
    playFXOnTag(common_scripts\utility::getfx("water_emerge_weapon"), self, "TAG_FLASH");

  var_3 = gettime() + var_0 * 1000;
  var_4 = gettime();

  while(var_4 < var_3) {
    foreach(var_6 in var_2) {
      var_7 = self gettagorigin(var_6) + (randomfloatrange(-2, 2), randomfloatrange(-2, 2), randomfloatrange(-2, 2));
      playFX(common_scripts\utility::getfx("character_drips"), var_7);
      wait(randomfloatrange(0.03, 0.09));
    }

    wait(randomfloatrange(0.05, 0.2));
    var_4 = gettime();
    thread fx_drip_switcher();
  }
}

fx_drip_switcher() {
  if(common_scripts\utility::flag("ally0_stair_ready") || common_scripts\utility::flag("ally1_stair_ready")) {
    level._effect["character_drips"] = loadfx("vfx/moments/flood/flood_character_drips_child");
    wait 1;

    if(!isDefined(self.drip_already_played)) {
      playFXOnTag(common_scripts\utility::getfx("flood_drips_big"), self, "TAG_STOWED_BACK");
      self.drip_already_played = 1;
    }
  }

  if(common_scripts\utility::flag("moving_to_mall"))
    level._effect["character_drips"] = loadfx("vfx/moments/flood/flood_character_drips");
}

debris_bridge_ally_waterfx(var_0) {
  self endon("death");
  var_1 = 35;
  var_2 = 1;

  while(!common_scripts\utility::flag(var_0)) {
    if(distance(self.velocity, (0, 0, 0)) > var_1) {
      playFXOnTag(level._effect["flood_db_foam_allie_emit_fast"], self, "tag_origin");

      while(distance(self.velocity, (0, 0, 0)) > var_1)
        common_scripts\utility::waitframe();

      stopFXOnTag(level._effect["flood_db_foam_allie_emit_fast"], self, "tag_origin");
    } else if(distance(self.velocity, (0, 0, 0)) > var_2) {
      playFXOnTag(level._effect["flood_db_foam_allie_emit_med"], self, "tag_origin");

      while(distance(self.velocity, (0, 0, 0)) > var_2)
        common_scripts\utility::waitframe();

      stopFXOnTag(level._effect["flood_db_foam_allie_emit_med"], self, "tag_origin");
    } else {
      playFXOnTag(level._effect["flood_db_foam_allie_emit"], self, "tag_origin");

      while(distance(self.velocity, (0, 0, 0)) < var_2)
        common_scripts\utility::waitframe();

      stopFXOnTag(level._effect["flood_db_foam_allie_emit"], self, "tag_origin");
    }

    common_scripts\utility::waitframe();
  }

  maps\flood_util::jkuprint(self.animname + " stopping db fx");
  common_scripts\utility::waitframe();
  stopFXOnTag(level._effect["flood_db_foam_allie_emit_fast"], self, "tag_origin");
  common_scripts\utility::waitframe();
  stopFXOnTag(level._effect["flood_db_foam_allie_emit_med"], self, "tag_origin");
  common_scripts\utility::waitframe();
  stopFXOnTag(level._effect["flood_db_foam_allie_emit"], self, "tag_origin");
}

debris_bridge_fx(var_0) {
  playFXOnTag(common_scripts\utility::getfx("flood_integration_db_emit"), level.debris_props[3], "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("flood_integration_db_emit"), level.debris_props[5], "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("flood_integration_db_emit"), level.debris_props[7], "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("flood_integration_db_emit"), level.debris_props[8], "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("flood_integration_db_emit"), level.debris_props[9], "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("flood_integration_db_emit"), level.debris_props[10], "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("flood_integration_db_emit"), level.debris_props[11], "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("flood_integration_db_emit"), level.debris_props[12], "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("flood_integration_db_emit"), level.debris_props[13], "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("flood_integration_db_emit"), level.debris_props[14], "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("flood_integration_db_emit"), level.debris_props[15], "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("flood_integration_foamsplash_db"), level.debris_props[18], "tag_origin_02");
  wait 12;
  wait 11.5;
  common_scripts\utility::exploder("db_wall_impact");
  wait 1;
  common_scripts\utility::exploder("db_bussplash");
  common_scripts\utility::exploder("db_sprays");
}

debris_bridge_bus_sparks(var_0) {
  var_1 = spawn("script_model", (5893.46, 2462.16, 56.2248));
  var_1 setModel("tag_origin");
  playFXOnTag(level._effect["vfx_jetscrape_short_runner"], var_1, "tag_origin");
  var_1 moveto((5831.19, 2383.35, 56.2248), 2);
  wait 3;
  stopFXOnTag(level._effect["vfx_jetscrape_short_runner"], var_1, "tag_origin");
}

ending_dof_01(var_0) {
  maps\_art::dof_enable_script(0, 70, 6, 100, 500, 8, 0.3);
}

ending_dof_02(var_0) {
  maps\_art::dof_enable_script(0, 18, 6, 40, 300, 8, 1.0);
}

ending_dof_03(var_0) {
  maps\_art::dof_enable_script(0, 5, 3, 30, 200, 6, 0.5);
}

ending_dof_04(var_0) {
  maps\_art::dof_enable_script(0, 185, 6, 300, 2500, 4, 1);
}

ending_dof_05(var_0) {
  maps\_art::dof_enable_script(0, 120, 6, 210, 2500, 4, 1);
}

ending_dof_06(var_0) {
  maps\_art::dof_enable_script(0, 8, 6, 25, 550, 5, 1.5);
}

ending_dof_07(var_0) {
  maps\_art::dof_enable_script(0, 8, 6, 20, 185, 5, 1);
}

ending_dof_08(var_0) {
  maps\_art::dof_enable_script(0, 8, 6, 25, 550, 5, 1.5);
}

ending_blood_wall(var_0) {
  playFXOnTag(common_scripts\utility::getfx("vfx_blood_hit_oriented"), level.ending_heli, "tag_fx_030");
}

end_heli_treadfx() {
  for(var_0 = 0; var_0 < 350; var_0++) {
    common_scripts\utility::exploder("end_heli_dust");
    wait 0.01;
  }
}

ending_fx_land_dust(var_0) {
  level.land_vfx = [];
  level.land_vfx[level.land_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("dust_puff_light_fast_16_03"), level.ending_heli, "tag_fx_001");
  level.land_vfx[level.land_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("vfx_nh90_cabin_smoke"), level.ending_heli, "tag_fx_015");
  common_scripts\utility::waitframe();
}

ending_fx_opfor01_headblood(var_0) {
  playFXOnTag(common_scripts\utility::getfx("vfx_flesh_flood_exit"), level.ending_heli, "tag_fx_002");
}

screen_shock(var_0) {
  level.player shellshock("flood_helicopter", 3.0);
}

ending_white_fade(var_0, var_1, var_2) {
  var_3 = maps\_hud_util::create_client_overlay("white", 0, level.player);

  if(var_0 > 0)
    var_3 fadeovertime(var_0);

  var_3.alpha = 0.75;
  wait(var_0);
  wait(var_1);

  if(var_2 > 0)
    var_3 fadeovertime(var_2);

  var_3.alpha = 0;
  wait(var_2);
  var_3 destroy();
}

ending_fx_fiery_smoke(var_0) {
  playFXOnTag(common_scripts\utility::getfx("flood_nh90_cabin_crash_smk"), level.ending_heli, "tag_fx_015");
}

ending_fx_opfor03_fire_pilot(var_0) {
  level.shootpilot_vfx = [];
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("vfx_muz_ar_v"), var_0, "tag_flash");
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("small_metalhit_1_efx_now"), level.ending_heli, "tag_fx_003");
  common_scripts\utility::waitframe();
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("vfx_muz_ar_v"), var_0, "tag_flash");
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("small_metalhit_1_efx_now"), level.ending_heli, "tag_fx_004");
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("flood_glass_shatter_small"), level.ending_heli, "tag_fx_016");
  common_scripts\utility::waitframe();
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("vfx_muz_ar_v"), var_0, "tag_flash");
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("small_metalhit_1_efx_now"), level.ending_heli, "tag_fx_005");
  wait 0.1;
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("vfx_muz_ar_v"), var_0, "tag_flash");
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("small_metalhit_1_efx_now"), level.ending_heli, "tag_fx_006");
  wait 0.1;
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("vfx_muz_ar_v"), var_0, "tag_flash");
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("small_metalhit_1_efx_now"), level.ending_heli, "tag_fx_007");
  wait 0.1;
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("vfx_muz_ar_v"), var_0, "tag_flash");
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("small_metalhit_1_efx_now"), level.ending_heli, "tag_fx_008");
  common_scripts\utility::waitframe();
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("vfx_muz_ar_v"), var_0, "tag_flash");
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("small_metalhit_1_efx_now"), level.ending_heli, "tag_fx_009");
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("flood_glass_shatter_small"), level.ending_heli, "tag_fx_017");
  common_scripts\utility::waitframe();
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("vfx_muz_ar_v"), var_0, "tag_flash");
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("small_metalhit_1_efx_now"), level.ending_heli, "tag_fx_010");
  common_scripts\utility::waitframe();
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("vfx_muz_ar_v"), var_0, "tag_flash");
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("small_metalhit_1_efx_now"), level.ending_heli, "tag_fx_011");
  common_scripts\utility::waitframe();
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("vfx_muz_ar_v"), var_0, "tag_flash");
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("small_metalhit_1_efx_now"), level.ending_heli, "tag_fx_012");
  common_scripts\utility::waitframe();
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("vfx_muz_ar_v"), var_0, "tag_flash");
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("small_metalhit_1_efx_now"), level.ending_heli, "tag_fx_013");
  common_scripts\utility::waitframe();
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("vfx_muz_ar_v"), var_0, "tag_flash");
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("small_metalhit_1_efx_now"), level.ending_heli, "tag_fx_014");
  common_scripts\utility::waitframe();
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("vfx_muz_ar_v"), var_0, "tag_flash");
  common_scripts\utility::waitframe();
  level.shootpilot_vfx[level.shootpilot_vfx.size] = playfxontagspecial(common_scripts\utility::getfx("vfx_muz_ar_v"), var_0, "tag_flash");

  foreach(var_2 in level.shootpilot_vfx) {
    killfxontag(var_2[1], var_2[0], "tag_origin");
    var_2[0] delete();
  }
}

ending2_dof_01(var_0) {
  maps\_art::dof_enable_script(0, 8, 0, 400, 1000, 0, 0.01);
}

ending2_impact_break_01(var_0) {
  playFXOnTag(common_scripts\utility::getfx("vfx_nh90_impact_smoke"), level.outro_heli_front, "tag_fx_front_00");
  playFXOnTag(common_scripts\utility::getfx("vfx_nh90_dstry_smk_break"), level.outro_heli_mid, "tag_fx_002");
  wait 0.2;
  playFXOnTag(common_scripts\utility::getfx("vfx_nh90_dstry_smk_break"), level.outro_heli_mid, "tag_fx_003");
}

ending2_window_break(var_0) {
  playFXOnTag(common_scripts\utility::getfx("vfx_flood_window_break"), level.outro_heli_mid, "tag_fx_006");
}

ending2_debri_fall(var_0) {
  playFXOnTag(common_scripts\utility::getfx("vfx_debris_fall_heli"), level.outro_heli_mid, "tag_fx_004");
}

ending2_fall_sparks(var_0) {
  playFXOnTag(common_scripts\utility::getfx("vfx_sparks_sign_ch_02"), level.outro_heli_mid, "tag_fx_005");
}

kill_ending_heli_fx(var_0) {
  killfxontag(common_scripts\utility::getfx("vfx_nh90_sml_smk_fall_emit"), level.outro_heli_rear, "jet_02_jnt");
  killfxontag(common_scripts\utility::getfx("vfx_nh90_sml_smk_fall_emit"), level.outro_heli_rear, "jet_01_jnt");
  killfxontag(common_scripts\utility::getfx("vfx_nh90_dstry_smk_fall_emit"), level.outro_heli_rear, "tag_fx_003");
  common_scripts\utility::waitframe();
  killfxontag(common_scripts\utility::getfx("vfx_nh90_dstry_smk_fall_emit"), level.outro_heli_rear, "tag_fx_004");
  killfxontag(common_scripts\utility::getfx("vfx_nh90_dstry_smk_fall_emit"), level.outro_heli_rear, "tag_fx_002");
  killfxontag(common_scripts\utility::getfx("vfx_sparks_sign_ch_02"), level.outro_heli_rear, "mid_wires");
  common_scripts\utility::waitframe();
  killfxontag(common_scripts\utility::getfx("vfx_fire_wall_small_02"), level.outro_heli_rear, "tag_fx_005");
  killfxontag(common_scripts\utility::getfx("flood_small_sparks_runner"), level.outro_heli_rear, "tag_fx_006");
  killfxontag(common_scripts\utility::getfx("flood_small_sparks_runner"), level.outro_heli_rear, "tag_fx_006");
}

water_death_fx() {
  maps\flood_coverwater::player_make_bubbles();
  thread maps\flood_coverwater::create_player_going_underwater_effects();
  level.player thread maps\_utility::vision_set_changes("flood_underwater_murky", 0);
  level.player thread maps\_utility::fog_set_changes("flood_underwater_murky", 0);
  playFXOnTag(common_scripts\utility::getfx("player_water_surface_plunge"), level.cw_player_view_fx_source, "tag_origin");
}

fx_create_sunflare_source() {
  if(!isDefined(level.sunflare)) {
    level.sunflare = spawn("script_model", (0, 0, 0));
    level.sunflare setModel("tag_origin");
    playFXOnTag(common_scripts\utility::getfx("vfx_lens_flare_sun"), level.sunflare, "tag_origin");
    var_0 = (-48.0103, -49.9438, 0);
    var_1 = (-40, -71.5, 0);
    var_2 = (-17, -114, 0);
    var_3 = (-40, -71.5, 0);
    var_4 = anglesToForward(var_1);

    for(;;) {
      level.sunflare.origin = level.player.origin + var_4 * 100000;
      wait 0.2;
    }
  }
}

spawnfx_test() {
  wait 5;

  for(;;) {
    common_scripts\utility::flag_wait("cw_player_abovewater");
    var_0 = (6594.5, 1166.99, 88.4814);
    var_1 = (275.918, 149.516, 122.354);
    var_2 = anglestoup(var_1);
    var_3 = anglesToForward(var_1);
    var_4 = spawnfx(level._effect["rapids_splash_lg_flood"], var_0, var_3, var_2);
    triggerfx(var_4, -10);
    var_5 = (8911.14, 5420.6, 676.794);
    var_6 = (271, 89.9991, 15.0009);
    var_7 = anglestoup(var_6);
    var_8 = anglesToForward(var_6);
    var_9 = spawnfx(level._effect["infil_building_smoke"], var_5, var_8, var_7);
    triggerfx(var_9, -10);
    wait 0.5;
    var_4 delete();
    var_9 delete();
    var_10 = spawn("script_model", (6594.5, 1166.99, 88.4814));
    var_10 setModel("tag_origin");
    var_10.angles = (275.918, 149.516, 122.354);
    playFXOnTag(level._effect["rapids_splash_lg_flood"], var_10, "tag_origin");
    var_11 = spawn("script_model", (8911.14, 5420.6, 676.794));
    var_11 setModel("tag_origin");
    var_11.angles = (271, 89.9991, 15.0009);
    playFXOnTag(level._effect["infil_building_smoke"], var_11, "tag_origin");
    common_scripts\utility::flag_wait("cw_player_underwater");
    killfxontag(level._effect["rapids_splash_lg_flood"], var_10, "tag_origin");
    killfxontag(level._effect["infil_building_smoke"], var_11, "tag_origin");
  }
}