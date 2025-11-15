/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_sovereign_fx.gsc
***************************************/

main() {
  level._effect["vfx_halon_gas_screen"] = loadfx("vfx/ambient/smoke/vfx_halon_gas_screen");
  level._effect["vfx_halon_exp"] = loadfx("vfx/moments/mp_sovereign/vfx_halon_exp");
  level._effect["vfx_walkway_impact_sov"] = loadfx("vfx/moments/mp_sovereign/vfx_walkway_impact_sov");
  level._effect["vfx_steam_railgun"] = loadfx("vfx/moments/mp_sovereign/vfx_steam_railgun");
  level._effect["vfx_sparks_door_ch"] = loadfx("vfx/ambient/sparks/vfx_sparks_door_ch");
  level._effect["vfx_smk_glassplume_sov_short"] = loadfx("vfx/ambient/smoke/vfx_smk_glassplume_sov_short");
  level._effect["vfx_sov_int_haze_uv2"] = loadfx("vfx/ambient/atmospheric/vfx_sov_int_haze_uv2");
  level._effect["red_light_30_nolight_1s"] = loadfx("vfx/ambient/lights/red_light_30_nolight_1s");
  level._effect["vfx_sov_railgun"] = loadfx("vfx/moments/mp_sovereign/vfx_sov_railgun");
  level._effect["vfx_halon_canister"] = loadfx("vfx/ambient/smoke/vfx_halon_canister");
  level._effect["vfx_halon_gas_playspace"] = loadfx("vfx/ambient/smoke/vfx_halon_gas_playspace");
  level._effect["vfx_screen_warning"] = loadfx("vfx/moments/mp_sovereign/vfx_screen_warning");
  level._effect["vfx_screen_master"] = loadfx("vfx/moments/mp_sovereign/vfx_screen_master");
  level._effect["vfx_walkway_impact_spark"] = loadfx("vfx/moments/mp_sovereign/vfx_walkway_impact_spark");
  level._effect["halon_gas_jet"] = loadfx("vfx/ambient/smoke/vfx_halon_gas");
  level._effect["vfx_sparks_tank_sov"] = loadfx("vfx/ambient/sparks/vfx_sparks_tank_sov");
  level._effect["vfx_dust_impact_sov"] = loadfx("vfx/moments/mp_sovereign/vfx_dust_impact_sov");
  level._effect["vfx_hologram_sov"] = loadfx("vfx/ambient/misc/vfx_hologram_sov");
  level._effect["vfx_security_monitor_large"] = loadfx("vfx/ambient/misc/vfx_security_monitor_large");
  level._effect["vfx_security_monitors"] = loadfx("vfx/ambient/misc/vfx_security_monitors");
  level._effect["vfx_steam_jet_pipes_runner"] = loadfx("vfx/ambient/steam/vfx_steam_jet_pipes_runner");
  level._effect["drip_5x5_mp"] = loadfx("vfx/ambient/water/drip_5x5_mp");
  level._effect["vfx_sov_hall_haze_uv1"] = loadfx("vfx/ambient/atmospheric/vfx_sov_hall_haze_uv1");
  level._effect["vfx_sov_assembly_haze_uv"] = loadfx("vfx/ambient/atmospheric/vfx_sov_assembly_haze_uv");
  level._effect["vfx_smoky_flourescent_sov"] = loadfx("vfx/ambient/lights/vfx_smoky_flourescent_sov");
  level._effect["vfx_glow_ceil_light_sov"] = loadfx("vfx/ambient/lights/vfx_glow_ceil_light_sov");
  level._effect["vfx_sov_int_haze_uv1"] = loadfx("vfx/ambient/atmospheric/vfx_sov_int_haze_uv1");
  level._effect["vfx_fire_server_glass_sov"] = loadfx("vfx/ambient/fire/electrical/vfx_fire_server_glass_sov");
  level._effect["vfx_smk_glassplume_sov"] = loadfx("vfx/ambient/smoke/vfx_smk_glassplume_sov");
  level._effect["vfx_sparks_server_sov"] = loadfx("vfx/ambient/sparks/vfx_sparks_server_sov");
  level._effect["vfx_steam_vent_sov"] = loadfx("vfx/ambient/steam/vfx_steam_vent_sov");
  level._effect["vfx_fire_server_sov"] = loadfx("vfx/ambient/fire/electrical/vfx_fire_server_sov");
  level._effect["vfx_serverfire_side_ov"] = loadfx("vfx/moments/mp_sovereign/vfx_serverfire_side_ov");
  level._effect["vfx_steam_fan"] = loadfx("vfx/moments/mp_sovereign/vfx_steam_fan");
  level._effect["vfx_steam_sidevents"] = loadfx("vfx/moments/mp_sovereign/vfx_steam_sidevents");
  level._effect["vfx_steamwide_sov"] = loadfx("vfx/moments/mp_sovereign/vfx_steamwide_sov");
  level._effect["vfx_steamescape_sov"] = loadfx("vfx/moments/mp_sovereign/vfx_steamescape_sov");
  level._effect["vfx_smk_glassplume_side_sov"] = loadfx("vfx/ambient/smoke/vfx_smk_glassplume_side_sov");
  level._effect["vfx_flare_small_red_sov"] = loadfx("vfx/ambient/lights/vfx_flare_small_red_sov");
  level._effect["vfx_condensation_pcloud"] = loadfx("vfx/moments/mp_sovereign/vfx_condensation_pcloud");
  level._effect["drips_slow_wide_sov"] = loadfx("fx/misc/drips_slow_wide_sov");
  level._effect["vfx_steam_basement_sov"] = loadfx("vfx/moments/mp_sovereign/vfx_steam_basement_sov");
  level._effect["vfx_steam_linepipes"] = loadfx("vfx/moments/mp_sovereign/vfx_steam_linepipes");
  level._effect["vfx_volume_table"] = loadfx("vfx/moments/mp_sovereign/vfx_volume_table");
  level._effect["vfx_sov_hall_haze_uv_wet"] = loadfx("vfx/ambient/atmospheric/vfx_sov_hall_haze_uv_wet");
  level._effect["vfx_flourescent_smoky"] = loadfx("vfx/moments/mp_sovereign/vfx_flourescent_smoky");
  level._effect["vfx_sparks_door_sov"] = loadfx("vfx/ambient/sparks/vfx_sparks_door_sov");
  level._effect["vfx_can_afterleak"] = loadfx("vfx/moments/mp_sovereign/vfx_can_afterleak");
  level._effect["vfx_can_jet"] = loadfx("vfx/moments/mp_sovereign/vfx_can_jet");
}