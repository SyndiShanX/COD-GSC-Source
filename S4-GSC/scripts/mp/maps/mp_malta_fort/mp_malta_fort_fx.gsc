/**************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_malta_fort\mp_malta_fort_fx.gsc
**************************************************************/

main() {
  level._effect["mp_mlt_water_dripping"] = loadfx("vfx/s4/level/malta/mp_mlt_water_dripping.vfx");
  level._effect["mp_mlt_blood_drips"] = loadfx("vfx/s4/level/malta/mp_mlt_blood_drips.vfx");
  level._effect["mp_mlt_dust_blowing_med_02"] = loadfx("vfx/s4/level/malta/mp_mlt_dust_blowing_med_02.vfx");
  level._effect["mp_mlt_sand_snakes_vista"] = loadfx("vfx/s4/level/malta/mp_mlt_sand_snakes_vista.vfx");
  level._effect["mp_mlt_leaves_blowing_ledge_01"] = loadfx("vfx/s4/level/malta/mp_mlt_leaves_blowing_ledge_01.vfx");
  level._effect["mp_mlt_generator_buzz"] = loadfx("vfx/s4/level/malta/mp_mlt_generator_buzz.vfx");
  level._effect["mp_mlt_light_white_blink"] = loadfx("vfx/s4/level/malta/mp_mlt_light_white_blink.vfx");
  level._effect["mp_mlt_light_red_blink"] = loadfx("vfx/s4/level/malta/mp_mlt_light_red_blink.vfx");
  level._effect["mp_mlt_crane"] = loadfx("vfx/s4/level/malta/mp_mlt_crane.vfx");
  level._effect["mp_mlt_bigfan_03"] = loadfx("vfx/s4/level/malta/mp_mlt_bigfan_03.vfx");
  level._effect["mp_mlt_bigfan_02"] = loadfx("vfx/s4/level/malta/mp_mlt_bigfan_02.vfx");
  level._effect["mp_mlt_bigfan_01"] = loadfx("vfx/s4/level/malta/mp_mlt_bigfan_01.vfx");
  level._effect["mp_mlt_smk_smolder_sml_02"] = loadfx("vfx/s4/level/malta/mp_mlt_smk_smolder_sml_02.vfx");
  level._effect["mp_mlt_smk_smolder_sml_01"] = loadfx("vfx/s4/level/malta/mp_mlt_smk_smolder_sml_01.vfx");
  level._effect["mp_mlt_candle_flame"] = loadfx("vfx/s4/level/malta/mp_mlt_candle_flame.vfx");
  level._effect["mp_mlt_mayhem_tarp_01"] = loadfx("vfx/s4/level/malta/mp_mlt_mayhem_tarp_01.vfx");
  level._effect["may_cloth_small_05"] = loadfx("vfx/s4/mayhem/may_cloth_small_05.vfx");
  level._effect["may_cloth_small_02"] = loadfx("vfx/s4/mayhem/may_cloth_small_02.vfx");
  level._effect["may_cloth_small_01"] = loadfx("vfx/s4/mayhem/may_cloth_small_01.vfx");
  level._effect["mp_mlt_animals_lizard_01"] = loadfx("vfx/s4/level/malta/mp_mlt_animals_lizard_01.vfx");
  level._effect["mp_mlt_animals_lizard_02"] = loadfx("vfx/s4/level/malta/mp_mlt_animals_lizard_02.vfx");
  level._effect["mp_mlt_bio_butterfly_01"] = loadfx("vfx/s4/level/malta/mp_mlt_bio_butterfly_01.vfx");
  level._effect["mp_mlt_bio_flies_lrg"] = loadfx("vfx/s4/level/malta/mp_mlt_bio_flies_lrg.vfx");
  level._effect["mp_mlt_bio_flies_sml"] = loadfx("vfx/s4/level/malta/mp_mlt_bio_flies_sml.vfx");
  level._effect["mp_mlt_birds_circling_01"] = loadfx("vfx/s4/level/malta/mp_mlt_birds_circling_01.vfx");
  level._effect["mp_mlt_sand_belltower"] = loadfx("vfx/s4/level/malta/mp_mlt_sand_belltower.vfx");
  level._effect["mp_mlt_sand_fall_sml_01"] = loadfx("vfx/s4/level/malta/mp_mlt_sand_fall_sml_01.vfx");
  level._effect["mp_mlt_sand_dustdevil_move"] = loadfx("vfx/s4/level/malta/mp_mlt_sand_dustdevil_move.vfx");
  level._effect["mp_mlt_sand_dustdevil"] = loadfx("vfx/s4/level/malta/mp_mlt_sand_dustdevil.vfx");
  level._effect["mp_mlt_sand_blowing_vista_01"] = loadfx("vfx/s4/level/malta/mp_mlt_sand_blowing_vista_01.vfx");
  level._effect["mp_mlt_dust_fall_med_03"] = loadfx("vfx/s4/level/malta/mp_mlt_dust_fall_med_03.vfx");
  level._effect["mp_mlt_dust_blowing_alley_lrg"] = loadfx("vfx/s4/level/malta/mp_mlt_dust_blowing_alley_lrg.vfx");
  level._effect["mp_mlt_dust_blowing_lrg_02"] = loadfx("vfx/s4/level/malta/mp_mlt_dust_blowing_lrg_02.vfx");
  level._effect["mp_mlt_dust_blowing_lrg_01"] = loadfx("vfx/s4/level/malta/mp_mlt_dust_blowing_lrg_01.vfx");
  level._effect["mp_mlt_dust_breeze_med_01"] = loadfx("vfx/s4/level/malta/mp_mlt_dust_breeze_med_01.vfx");
  level._effect["mp_mlt_dust_fall_med_01"] = loadfx("vfx/s4/level/malta/mp_mlt_dust_fall_med_01.vfx");
  level._effect["mp_mlt_dust_fall_med_02"] = loadfx("vfx/s4/level/malta/mp_mlt_dust_fall_med_02.vfx");
  level._effect["mp_mlt_sand_snakes_gust_03"] = loadfx("vfx/s4/level/malta/mp_mlt_sand_snakes_gust_03.vfx");
  level._effect["mp_mlt_sand_snakes_gust_02"] = loadfx("vfx/s4/level/malta/mp_mlt_sand_snakes_gust_02.vfx");
  level._effect["mp_mlt_sand_snakes_gust"] = loadfx("vfx/s4/level/malta/mp_mlt_sand_snakes_gust.vfx");
  level._effect["mp_mlt_dust_interior_lrg"] = loadfx("vfx/s4/level/malta/mp_mlt_dust_interior_lrg.vfx");
  level._effect["mp_mlt_dust_interior_narrow"] = loadfx("vfx/s4/level/malta/mp_mlt_dust_interior_narrow.vfx");
  level._effect["mp_mlt_dust_interior_swirl_lrg_02"] = loadfx("vfx/s4/level/malta/mp_mlt_dust_interior_swirl_lrg_02.vfx");
  level._effect["mp_mlt_dust_interior_swirl_lrg"] = loadfx("vfx/s4/level/malta/mp_mlt_dust_interior_swirl_lrg.vfx");
  level._effect["mp_mlt_electrical_sparks_burst"] = loadfx("vfx/s4/level/malta/mp_mlt_electrical_sparks_burst.vfx");
  level._effect["mp_mlt_leaves_blowing_palm"] = loadfx("vfx/s4/level/malta/mp_mlt_leaves_blowing_palm.vfx");
  level._effect["mp_mlt_light_flare"] = loadfx("vfx/s4/level/malta/mp_mlt_light_flare.vfx");
  level._effect["mp_mlt_rubble_drop_lrg"] = loadfx("vfx/s4/level/malta/mp_mlt_rubble_drop_lrg.vfx");
  level._effect["mp_mlt_rubble_drop_sml"] = loadfx("vfx/s4/level/malta/mp_mlt_rubble_drop_sml.vfx");
  level._effect["mp_mlt_sand_blowing_ledge"] = loadfx("vfx/s4/level/malta/mp_mlt_sand_blowing_ledge.vfx");
  level._effect["mp_mlt_sand_blowing_ledge_02"] = loadfx("vfx/s4/level/malta/mp_mlt_sand_blowing_ledge_02.vfx");
  level._effect["mp_mlt_sand_particulates_alley_01"] = loadfx("vfx/s4/level/malta/mp_mlt_sand_particulates_alley_01.vfx");
  level._effect["mp_mlt_sand_particulates_lrg_01"] = loadfx("vfx/s4/level/malta/mp_mlt_sand_particulates_lrg_01.vfx");
  level._effect["mp_mlt_sand_surface_med"] = loadfx("vfx/s4/level/malta/mp_mlt_sand_surface_med.vfx");
}