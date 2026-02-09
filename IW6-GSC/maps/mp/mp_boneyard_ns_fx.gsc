/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_boneyard_ns_fx.gsc
*****************************************/

main() {
  level._effect["vfx_tanker_embers_by"] = loadfx("vfx/ambient/fire/vfx_tanker_embers_by");
  level._effect["fire_ceiling_large_fade_01"] = loadfx("vfx/ambient/fire/wall/vfx_fire_wall_lg_nofog_ae_fade_ornt");
  level._effect["vfx_floodlight_flare_small"] = loadfx("vfx/ambient/lights/vfx_floodlight_flare_small");
  level._effect["vfx_mp_boneyard_ns_vert_post"] = loadfx("vfx/moments/mp_boneyard_ns/vfx_mp_boneyard_ns_vert_post");
  level._effect["vfx_mp_boneyard_ns_vert_pre"] = loadfx("vfx/moments/mp_boneyard_ns/vfx_mp_boneyard_ns_vert_pre");
  level._effect["vfx_mp_boneyard_ns_horz_pre"] = loadfx("vfx/moments/mp_boneyard_ns/vfx_mp_boneyard_ns_horz_pre");
  level._effect["vfx_mp_boneyard_ns_horz_post"] = loadfx("vfx/moments/mp_boneyard_ns/vfx_mp_boneyard_ns_horz_post");
  level._effect["vfx_scrnfx_heat_extreme_sml"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_heat_extreme_sml");
  level._effect["flocking_birds_mp_runner"] = loadfx("fx/misc/flocking_birds_mp_runner");
  level._effect["drips_slow_dark"] = loadfx("fx/misc/drips_slow_dark");
  level._effect["vfx_horz_smk_linger"] = loadfx("vfx/moments/mp_boneyard_ns/vfx_horz_smk_linger");
  level._effect["vfx_horz_fire_amber_light"] = loadfx("vfx/moments/mp_boneyard_ns/vfx_horz_fire_amber_light");
  level._effect["vfx_horz_fire_red_light"] = loadfx("vfx/moments/mp_boneyard_ns/vfx_horz_fire_red_light");
  level._effect["vfx_embers_oriented_small_02"] = loadfx("vfx/ambient/sparks/vfx_embers_oriented_small_02");
  level._effect["vfx_smk_f15_booster_prelaunch"] = loadfx("vfx/ambient/smoke/vfx_smk_f15_booster_prelaunch");
  level._effect["vfx_vert_fire_lights_red"] = loadfx("vfx/moments/mp_boneyard_ns/vfx_vert_fire_lights_red");
  level._effect["vfx_vert_fire_lights_blue"] = loadfx("vfx/moments/mp_boneyard_ns/vfx_vert_fire_lights_blue");
  level._effect["vfx_launch_warning_lights"] = loadfx("vfx/moments/mp_boneyard_ns/vfx_launch_warning_lights");
  level._effect["vfx_debris_impact_med"] = loadfx("vfx/moments/mp_boneyard_ns/vfx_debris_impact_med");
  level._effect["vfx_dust_wind_fast"] = loadfx("vfx/ambient/dust/vfx_dust_wind_fast");
  level._effect["vfx_mp_boneyard_ns_bhit_small"] = loadfx("vfx/moments/mp_boneyard_ns/vfx_mp_boneyard_ns_bhit_small");
  level._effect["vfx_mp_boneyard_rocket_spot"] = loadfx("vfx/moments/mp_boneyard_ns/vfx_mp_boneyard_rocket_spot");
  level._effect["vfx_mp_boneyard_ns_building_hit"] = loadfx("vfx/moments/mp_boneyard_ns/vfx_mp_boneyard_ns_building_hit");
  level._effect["vfx_jungle_pollen_coverage_02"] = loadfx("vfx/ambient/atmospheric/vfx_jungle_pollen_coverage_02");
  level._effect["vfx_firelp_small_pm_25sec"] = loadfx("vfx/ambient/fire/vfx_firelp_small_pm_25sec");
  level._effect["vfx_mp_boneyard_ns_rs_linger"] = loadfx("vfx/moments/mp_boneyard_ns/vfx_mp_boneyard_ns_rs_linger");
  level._effect["vfx_floodlight_flare_med_flare"] = loadfx("vfx/ambient/lights/vfx_floodlight_flare_med_flare");
  level._effect["vfx_floodlight_flare_med"] = loadfx("vfx/ambient/lights/vfx_floodlight_flare_med");
  level._effect["vfx_debris_impact_lrg"] = loadfx("vfx/moments/mp_boneyard_ns/vfx_debris_impact_lrg");
  level._effect["vfx_firelp_small_am"] = loadfx("vfx/ambient/fire/vfx_firelp_small_am");
  level._effect["vfx_exp_rocket_shuttle_aerial"] = loadfx("vfx/moments/mp_boneyard_ns/vfx_exp_rocket_shuttle_aerial");
  level._effect["vfx_rocket_shuttle_smoke_geotrail_xlarge"] = loadfx("vfx/moments/mp_boneyard_ns/vfx_rocket_smoke_geotrail_xlarge");
  level._effect["vfx_debris_trail_xlarge"] = loadfx("vfx/moments/mp_boneyard_ns/vfx_debris_trail_xlarge");
  level._effect["fire_ceiling_large_fade_01_old"] = loadfx("vfx/ambient/fire/wall/vfx_fire_wall_lg_nofog_ae_fade_noglow");
  level._effect["vfx_mp_boneyard_rocket_flame_begin"] = loadfx("vfx/test/vfx_mp_boneyard_rocket_flame_begin");
  level._effect["vfx_digital_timer_stopped"] = loadfx("vfx/moments/mp_boneyard_ns/vfx_digital_timer_stopped");
  level._effect["vfx_tanker_embers_old"] = loadfx("vfx/ambient/fire/vfx_tanker_embers");
  level._effect["vfx_rog_byard_hit_runner"] = loadfx("vfx/moments/mp_boneyard_ns/vfx_rog_byard_hit_runner");
  level._effect["vfx_rog_perif_byard_1_runner"] = loadfx("vfx/moments/mp_boneyard_ns/vfx_rog_perif_byard_1_runner");
  level._effect["vfx_mp_boneyard_ns_vert_rocket"] = loadfx("vfx/_requests/mp_boneyard_ns/vfx_mp_boneyard_ns_vert_rocket");
  level._effect["vfx_mp_boneyard_ns_horz_rocket"] = loadfx("vfx/_requests/mp_boneyard_ns/vfx_mp_boneyard_ns_horz_rocket");
  level._effect["vfx_mp_boneyard_ns_rs_end"] = loadfx("vfx/_requests/mp_boneyard_ns/vfx_mp_boneyard_ns_rs_end");
  level.explo_nums = [];
  level.explo_nums["rocket_explo"] = [];
  level.explo_nums["rocket_explo"]["crash_01"] = 1;
  level.explo_nums["rocket_explo"]["crash_02"] = 2;
  level.explo_nums["rocket_explo"]["crash_03a"] = 3;
  level.explo_nums["rocket_explo"]["crash_03b"] = undefined;
  level.explo_nums["rocket_explo"]["crash_04"] = 4;
  setDvar("r_specularColorScale", 3.05);
}