/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_shipment\mp_shipment_fx.gsc
**********************************************************/

function main() {
  level._effect["vfx_shipment_knee_high_mist"] = loadfx("vfx/iw8_mp/level/shipment/vfx_shipment_knee_high_mist.vfx");
  level._effect["vfx_shipment_boat_exhaust"] = loadfx("vfx/iw8_mp/level/shipment/vfx_shipment_boat_exhaust.vfx");
  level._effect["vfx_shipment_core_vapor_sml"] = loadfx("vfx/iw8_mp/level/shipment/vfx_shipment_core_vapor_sml.vfx");
  level._effect["vfx_shipment_core_vapor"] = loadfx("vfx/iw8_mp/level/shipment/vfx_shipment_core_vapor.vfx");
  level._effect["vfx_petrograd_gas_cloud_linger"] = loadfx("vfx/iw8_mp/level/petrograd/vfx_petrograd_gas_cloud_linger.vfx");
  level._effect["vfx_shipment_smoke_stack"] = loadfx("vfx/iw8_mp/level/shipment/vfx_shipment_smoke_stack.vfx");
  level._effect["vfx_shipment_bulb_light_flare"] = loadfx("vfx/iw8_mp/level/shipment/vfx_shipment_bulb_light_flare.vfx");
  level._effect["vfx_shipment_forklift_light"] = loadfx("vfx/iw8_mp/level/shipment/vfx_shipment_forklift_light.vfx");
  level._effect["vfx_shipment_cont_edge_drips"] = loadfx("vfx/iw8_mp/level/shipment/vfx_shipment_cont_edge_drips.vfx");
  level._effect["vfx_shipment_distant_fog"] = loadfx("vfx/iw8_mp/level/shipment/vfx_shipment_distant_fog.vfx");
  level._effect["vfx_shipment_cam_rain"] = loadfx("vfx/iw8_mp/level/shipment/vfx_shipment_cam_rain.vfx");
  level._effect["vfx_cont_splashes"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_cont_splashes.vfx");
  level._effect["vfx_shipment_sunflare"] = loadfx("vfx/iw8_mp/level/shipment/vfx_shipment_sunflare.vfx");
  level._effect["vfx_rain_infil"] = loadfx("vfx/iw8/level/townhouse/vfx_rain_infil.vfx");
  level._effect["vfx_rain_edge_runoff"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_rain_edge_runoff.vfx");
  level._effect["vfx_rain_edge_drips"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_rain_edge_drips.vfx");
  level._effect["vfx_rain_splashes_a"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_rain_splashes_a.vfx");
  level._effect["vfx_mp_shipment_sunflare"] = loadfx("vfx/iw8_mp/level/shipment/vfx_shipment_sunflare.vfx");
  level._effect["vfx_birds_circling_seagulls"] = loadfx("vfx/iw8/level/gen_amb/vfx_birds_circling_seagulls.vfx");
  level._effect["vfx_emp_main_blast"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_main_blast.vfx");
  level._effect["vfx_emp_secondary_posx"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_secondary_posx.vfx");
  level._effect["vfx_emp_secondary_omni"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_secondary_omni.vfx");
  level._effect["vfx_trash_drift_hack"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_trash_drift_hack.vfx");
  level._effect["vfx_trash_flys"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_trash_flys.vfx");
  level._effect["vfx_drifting_ivy"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_drifting_ivy.vfx");
  level._effect["vfx_scrn_lookup_drops"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_scrn_lookup_drops.vfx");
  level._effect["vfx_knee_high_mist"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_knee_high_mist.vfx");
  level._effect["vfx_moths"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_moths.vfx");
  level._effect["vfx_train_sparks_falling"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_train_sparks_falling.vfx");
  level._effect["vfx_train_sparks_runner"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_train_sparks_runner.vfx");
  level._effect["vfx_flip_light_red"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_flip_light_red.vfx");
  level._effect["vfx_flip_light_yellow"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_flip_light_yellow.vfx");
  level._effect["vfx_wall_vent_steam"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_wall_vent_steam.vfx");
  level._effect["vfx_grnd_vent_steam"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_grnd_vent_steam.vfx");
  level._effect["vfx_vista_mist_thick"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_vista_mist_thick.vfx");
  level._effect["vfx_runoff_imp"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_runoff_imp.vfx");
  level._effect["vfx_hack_cloud_flash_vista_01"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_hack_cloud_flash_vista_01.vfx");
  level._effect["vfx_rat_hackney_runner"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_rat_hackney_runner.vfx");
  level._effect["vfx_vista_mist_hackney"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_vista_mist_hackney.vfx");
  level._effect["vfx_cloud_sweep_hack"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_cloud_sweep_hack.vfx");
  level._effect["vfx_vent_steam_windy"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_vent_steam_windy.vfx");
  level._effect["vfx_smoke_stack"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_smoke_stack.vfx");
  level._effect["vfx_mist_ground_drift_ng"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_mist_ground_drift_ng.vfx");
  level._effect["vfx_mist_large_gust"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_mist_large_gust.vfx");
  level._effect["vfx_mist_ground_drift"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_mist_ground_drift.vfx");
}