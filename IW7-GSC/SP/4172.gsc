/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 4172.gsc
**************************************/

main() {
  level._effect["vfx_marscrib_light_blue_elevator_vista_runner"] = loadfx("vfx/iw7/levels/mars/vfx_marscrib_light_blue_elevator_vista_runner.vfx");
  level._effect["vfx_marscrib_fire_crash_site"] = loadfx("vfx/iw7/levels/mars/vfx_marscrib_fire_crash_site.vfx");
  level._effect["vfx_marscrib_fire_crash_site"] = loadfx("vfx/iw7/levels/mars/vfx_marscrib_fire_crash_site.vfx");
  level._effect["vfx_marscrib_dust_player_start_impact"] = loadfx("vfx/iw7/levels/mars/vfx_marscrib_dust_player_start_impact.vfx");
  level._effect["vfx_marscrib_dropship_landing_dust_01"] = loadfx("vfx/iw7/levels/mars/vfx_marscrib_dropship_landing_dust_01.vfx");
  level._effect["vfx_marscrib_vista_large_dust"] = loadfx("vfx/iw7/levels/mars/vfx_marscrib_vista_large_dust.vfx");
  level._effect["vfx_marscrib_crash_site_fire_large"] = loadfx("vfx/iw7/levels/mars/vfx_marscrib_crash_site_fire_large.vfx");
  level._effect["vfx_marscrib_dropship_landing_dust_01"] = loadfx("vfx/iw7/levels/mars/vfx_marscrib_dropship_landing_dust_01.vfx");
  level._effect["vfx_marscrib_dust_wisp_lg"] = loadfx("vfx/iw7/levels/mars/vfx_marscrib_dust_wisp_lg.vfx");
  level._effect["vfx_mars_dust_ground_streaks"] = loadfx("vfx/iw7/levels/mars/vfx_mars_dust_ground_streaks.vfx");
  level._effect["vfx_mars_dust_ground_wisp"] = loadfx("vfx/iw7/levels/mars/vfx_mars_dust_ground_wisp.vfx");
  level._effect["vfx_mars_dust_wisp_lg"] = loadfx("vfx/iw7/levels/mars/vfx_mars_dust_wisp_lg.vfx");
  level._effect["vfx_mars_dust_rock_wisp"] = loadfx("vfx/iw7/levels/mars/vfx_mars_dust_rock_wisp.vfx");
  level._effect["vfx_mars_cliff_edge_blow_off"] = loadfx("vfx/iw7/levels/mars/vfx_mars_cliff_edge_blow_off.vfx");
  level._effect["vfx_mars_ash_hanging_prtcld"] = loadfx("vfx/iw7/levels/mars/vfx_mars_ash_hanging_prtcld.vfx");
  level._effect["vfx_marscrib_retribution_smolder_smoke"] = loadfx("vfx/iw7/levels/mars/vfx_marscrib_retribution_smolder_smoke.vfx");
  level._effect["vfx_marscrib_retribution_falling_sparks_sm"] = loadfx("vfx/iw7/levels/mars/vfx_marscrib_retribution_falling_sparks_sm.vfx");
  level._effect["vfx_marscrib_retribution_falling_sparks"] = loadfx("vfx/iw7/levels/mars/vfx_marscrib_retribution_falling_sparks.vfx");
  level._effect["vfx_marscrib_fire_crash_site_licks_vista"] = loadfx("vfx/iw7/levels/mars/vfx_marscrib_fire_crash_site_licks_vista.vfx");
  level._effect["vfx_marscrib_fire_spot_vista"] = loadfx("vfx/iw7/levels/mars/vfx_marscrib_fire_spot_vista.vfx");
  level._effect["vfx_marscrib_embers_crash_site"] = loadfx("vfx/iw7/levels/mars/vfx_marscrib_embers_crash_site.vfx");
  level._effect["vfx_moon_building_fire_far"] = loadfx("vfx/iw7/levels/moon/vfx_moon_building_fire_far.vfx");
  level._effect["vfx_sc_gun_rack_opening"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_gun_rack_opening.vfx");
  level._effect["vfx_sc_gun_rack_open"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_gun_rack_open.vfx");
  level._effect["vfx_light_green"] = loadfx("vfx/iw7/_requests/airlock/vfx_light_green.vfx");
  level._effect["vfx_light_blink_red"] = loadfx("vfx/iw7/_requests/mp/vfx_light_blink_red.vfx");
  level._effect["blood_spurt_large"] = loadfx("vfx/iw7/_requests/mars/blood_spurt_large.vfx");
  level._effect["vfx_pr_fire_small"] = loadfx("vfx/iw7/levels/prisoner/vfx_pr_fire_small.vfx");
  level._effect["vfx_ph_fire_medium"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_fire_medium.vfx");
  level._effect["vfx_pr_fire_medium"] = loadfx("vfx/iw7/levels/prisoner/vfx_pr_fire_medium.vfx");
  level._effect["vfx_pmd_hanging_smoke"] = loadfx("vfx/iw7/levels/titan/scripted/vfx_pmd_hanging_smoke.vfx");
  level._effect["vfx_pcr_lingering_smoke_rise"] = loadfx("vfx/iw7/levels/titan/scripted/pipes_chain_react/vfx_pcr_lingering_smoke_rise.vfx");
  level._effect["vfx_ph_fire_medium"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_fire_medium.vfx");
  level._effect["breath_fog"] = loadfx("vfx/iw7/levels/mars/vfx_marscrib_NPC_mask_breath.vfx");
  level._effect["vfx_klaxon_flare"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_klaxon_flare.vfx");

  if(!getdvarint("r_reflectionProbeGenerate")) {
    scripts\sp\maps\marscrib\gen\marscrib_fx::main();
    scripts\sp\maps\marscrib\gen\marscrib_sound::main();
  }

  level._effect["allies_winglight"] = loadfx("vfx/iw7/core/vehicle/global/vfx_acraft_light_wingtip_blue_blink.vfx");
}