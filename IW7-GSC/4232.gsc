/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 4232.gsc
**************************************/

main() {
  level._effect["vfx_sc_epilogue_nebula_ambient"] = loadfx("vfx/iw7/levels/ship_crib/epilogue/vfx_sc_epilogue_nebula_ambient.vfx");
  level._effect["vfx_sc_hallway_light_flare_secondary_3"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_hallway_light_flare_secondary_3.vfx");
  level._effect["vfx_sc_ground_mist_bridge_sml"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_ground_mist_bridge_sml.vfx");
  level._effect["vfx_sc_vent_smoke_extrasmall"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_vent/vfx_sc_vent_smoke_extrasmall.vfx");
  level._effect["vfx_sc_hallway_steam_vent_02_lg"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_hallway_steam_vent_02_lg.vfx");
  level._effect["vfx_sc_hallway_light_flare_secondary_3_blue"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_hallway_light_flare_secondary_3_blue.vfx");
  level._effect["vfx_sc_office_light_flare_secondary_1"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_office_light_flare_secondary_1.vfx");
  level._effect["vfx_sc_hallway_smoke_vent_02"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_hallway_smoke_vent_02.vfx");
  level._effect["vfx_sc_hanging_dust_interior"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_hanging_dust_interior.vfx");
  level._effect["vfx_sc_hallway_steam_vent_02"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_hallway_steam_vent_02.vfx");
  level._effect["vfx_sc_ground_mist_sml"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_ground_mist_sml.vfx");
  level._effect["vfx_sc_nl_smk_ground_pass_s"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_nl_smk_ground_pass_s.vfx");
  level._effect["vfx_sc_light_dust_particulates"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_light_dust_particulates.vfx");
  level._effect["vfx_sc_office_light_mist_2"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_office_light_mist_2.vfx");
  level._effect["vfx_sc_office_light_mist_1"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_office_light_mist_1.vfx");
  level._effect["vfx_sc_dust_particulates_prtcld_sml"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_dust_particulates_prtcld_sml.vfx");
  level._effect["vfx_sc_hallway_smoke_vent_01"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_hallway_smoke_vent_01.vfx");
  level._effect["vfx_sc_hallway_light_flare_secondary_2"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_hallway_light_flare_secondary_2.vfx");
  level._effect["space_particle"] = loadfx("vfx/iw7/levels/ship_crib/epilogue/vfx_sc_end_camera_debris");
  level._effect["space_particle_end"] = loadfx("vfx/iw7/levels/ship_crib/epilogue/vfx_sc_end_camera_debris_end");

  if(!getdvarint("r_reflectionProbeGenerate")) {
    scripts\sp\maps\shipcrib_epilogue\gen\shipcrib_epilogue_fx::main();
    scripts\sp\maps\shipcrib_epilogue\gen\shipcrib_epilogue_sound::main();
  }
}