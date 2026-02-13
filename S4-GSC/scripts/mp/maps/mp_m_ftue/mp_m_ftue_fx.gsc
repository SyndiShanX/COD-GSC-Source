/******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_ftue\mp_m_ftue_fx.gsc
******************************************************/

main() {
  level._effect["mp_ftue_distortion_heat_haze"] = loadfx("vfx/s4/level/ftue/mp_ftue_distortion_heat_haze.vfx");
  level._effect["mp_ftue_debris_leaves_falling_ambient"] = loadfx("vfx/s4/level/ftue/mp_ftue_debris_leaves_falling_ambient.vfx");
  level._effect["mp_ftue_debris_leaves_falling"] = loadfx("vfx/s4/level/ftue/mp_ftue_debris_leaves_falling.vfx");
  level._effect["mp_ftue_bio_rat_run_a"] = loadfx("vfx/s4/level/ftue/mp_ftue_bio_rat_run_a.vfx");
  level._effect["mp_ftue_dust_indoor_motes_local"] = loadfx("vfx/s4/level/ftue/mp_ftue_dust_indoor_motes_local.vfx");
  level._effect["mp_ftue_debris_dust_wind_gpu_spray_wide"] = loadfx("vfx/s4/level/ftue/mp_ftue_debris_dust_wind_gpu_spray_wide.vfx");
  level._effect["mp_ftue_debris_dust_wind_gpu_master_lg"] = loadfx("vfx/s4/level/ftue/mp_ftue_debris_dust_wind_gpu_master_lg.vfx");
  level._effect["mp_ftue_debris_dust_wind_gpu_master"] = loadfx("vfx/s4/level/ftue/mp_ftue_debris_dust_wind_gpu_master.vfx");
  level._effect["mp_ftue_dust_swirl_vista"] = loadfx("vfx/s4/level/ftue/mp_ftue_dust_swirl_vista.vfx");
  level._effect["mp_ftue_dust_swirl_play"] = loadfx("vfx/s4/level/ftue/mp_ftue_dust_swirl_play.vfx");
  level._effect["mp_ftue_bio_moths_calm"] = loadfx("vfx/s4/level/ftue/mp_ftue_bio_moths_calm.vfx");
  level._effect["mp_ftue_cloth_small_05"] = loadfx("vfx/s4/level/ftue/mp_ftue_cloth_small_05.vfx");
  level._effect["mp_ftue_cloth_large_02"] = loadfx("vfx/s4/level/ftue/mp_ftue_cloth_large_02.vfx");
  level._effect["mp_ftue_cloth_large_03"] = loadfx("vfx/s4/level/ftue/mp_ftue_cloth_large_03.vfx");
  level._effect["mp_ftue_cloth_large_01"] = loadfx("vfx/s4/level/ftue/mp_ftue_cloth_large_01.vfx");
  level._effect["mp_ftue_cloth_small_01"] = loadfx("vfx/s4/level/ftue/mp_ftue_cloth_small_01.vfx");
  level._effect["mp_ftue_cloth_small_02"] = loadfx("vfx/s4/level/ftue/mp_ftue_cloth_small_02.vfx");
  level._effect["mp_ftue_cloth_small_03"] = loadfx("vfx/s4/level/ftue/mp_ftue_cloth_small_03.vfx");
  level._effect["mp_ftue_cloth_small_04"] = loadfx("vfx/s4/level/ftue/mp_ftue_cloth_small_04.vfx");
  level._effect["mp_ftue_mayhem_ger_reichstag_tarp_05"] = loadfx("vfx/s4/level/ftue/mp_ftue_mayhem_ger_reichstag_tarp_05.vfx");
  level._effect["mp_ftue_mayhem_ger_reichstag_tarp_02"] = loadfx("vfx/s4/level/ftue/mp_ftue_mayhem_ger_reichstag_tarp_02.vfx");
  level._effect["mp_ftue_mayhem_ger_reichstag_tarp_04"] = loadfx("vfx/s4/level/ftue/mp_ftue_mayhem_ger_reichstag_tarp_04.vfx");
  level._effect["mp_ftue_mayhem_ger_reichstag_tarp_01"] = loadfx("vfx/s4/level/ftue/mp_ftue_mayhem_ger_reichstag_tarp_01.vfx");
  level._effect["mp_ftue_debris_trash_window_rnr"] = loadfx("vfx/s4/level/ftue/mp_ftue_debris_trash_window_rnr.vfx");
  level._effect["mp_ftue_bio_mosquitoes"] = loadfx("vfx/s4/level/ftue/mp_ftue_bio_mosquitoes.vfx");
  level._effect["mp_ftue_birds_burst_01"] = loadfx("vfx/s4/level/ftue/mp_ftue_birds_burst_01.vfx");
  level._effect["mp_ftue_birds_circling"] = loadfx("vfx/s4/level/ftue/mp_ftue_birds_circling.vfx");
  level._effect["mp_ftue_birds_perched_rnr_a"] = loadfx("vfx/s4/level/ftue/mp_ftue_birds_perched_rnr_a.vfx");
  level._effect["mp_ftue_birds_perched_rnr_b"] = loadfx("vfx/s4/level/ftue/mp_ftue_birds_perched_rnr_b.vfx");
  level._effect["mp_ftue_birds_perched_rnr_c"] = loadfx("vfx/s4/level/ftue/mp_ftue_birds_perched_rnr_c.vfx");
  level._effect["mp_ftue_clutter_birds_sparrow_burst_01"] = loadfx("vfx/s4/level/ftue/mp_ftue_clutter_birds_sparrow_burst_01.vfx");
  level._effect["mp_ftue_debris_dust_streaks_rnr"] = loadfx("vfx/s4/level/ftue/mp_ftue_debris_dust_streaks_rnr.vfx");
  level._effect["mp_ftue_debris_sand_blowing_rnr"] = loadfx("vfx/s4/level/ftue/mp_ftue_debris_sand_blowing_rnr.vfx");
  level._effect["mp_ftue_debris_sand_drifting_rnr"] = loadfx("vfx/s4/level/ftue/mp_ftue_debris_sand_drifting_rnr.vfx");
  level._effect["mp_ftue_debris_trash_drifting_rnr"] = loadfx("vfx/s4/level/ftue/mp_ftue_debris_trash_drifting_rnr.vfx");
  level._effect["mp_ftue_debris_trash_tornado_rnr"] = loadfx("vfx/s4/level/ftue/mp_ftue_debris_trash_tornado_rnr.vfx");
  level._effect["mp_ftue_bio_flies_sm"] = loadfx("vfx/s4/level/ftue/mp_ftue_bio_flies_sm.vfx");
  level._effect["mp_ftue_bio_flies_lrg"] = loadfx("vfx/s4/level/ftue/mp_ftue_bio_flies_lrg.vfx");
}