/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\safehouse\safehouse_fx.gsc
***********************************************/

main() {
  level._effect["vfx_safehouse_godray_sml_2"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_godray_sml_2.vfx");
  level._effect["vfx_safehouse_farah_blood_neck_stab"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_farah_blood_neck_stab.vfx");
  level._effect["vfx_safehouse_farah_blood_stab"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_farah_blood_stab.vfx");
  init_create_fx();
  init_footstep_fx();
  init_scripted_fx();

  if(!getdvarint("LLQQOPKTKM")) {
    scripts\sp\maps\safehouse\gen\safehouse_fx.gsc::main();
    scripts\sp\maps\safehouse\gen\safehouse_sound.gsc::main();
  }
}

init_create_fx() {
  level._effect["vfx_safehouse_roof_dust_01"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_roof_dust_01.vfx");
  level._effect["vfx_safehouse_door_dust_01"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_door_dust_01.vfx");
  level._effect["vfx_dust_swirl_sml"] = loadfx("vfx/iw8/level/safehouse/vfx_dust_swirl_sml.vfx");
  level._effect["vfx_safehouse_thick_dust_01"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_thick_dust_01.vfx");
  level._effect["vfx_blowing_dust_ledge"] = loadfx("vfx/iw8/level/safehouse/vfx_blowing_dust_ledge.vfx");
  level._effect["vfx_safehouse_dust_wind_a"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_dust_wind_a.vfx");
  level._effect["vfx_safehouse_swirling_dust"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_swirling_dust.vfx");
  level._effect["vfx_safehouse_amb_dustdevil_sml"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_amb_dustdevil_sml.vfx");
  level._effect["vfx_safehouse_town_fog"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_town_fog.vfx");
  level._effect["vfx_safehouse_town_dust"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_town_dust.vfx");
  level._effect["vfx_safehouse_sunflare"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_sunflare.vfx");
  level._effect["vfx_spr_light_flare"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_light_flare.vfx");
  level._effect["vfx_wind_global_dummy"] = loadfx("vfx/iw8/wind/vfx_wind_global_dummy.vfx");
  level._effect["vfx_fire_sml"] = loadfx("vfx/iw8_mp/gen_amb/vfx_fire_sml.vfx");
  level._effect["vfx_water_drips_line_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_water_drips_line_1.vfx");
  level._effect["vfx_blowing_sand_low"] = loadfx("vfx/iw8_mp/level/faridah/vfx_blowing_sand_low.vfx");
  level._effect["vfx_spr_water_pour_sm"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_water_pour_sm.vfx");
  level._effect["vfx_spr_mist_fast"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_mist_fast.vfx");
  level._effect["vfx_spr_water_pour_gd"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_water_pour_gd.vfx");
  level._effect["vfx_spr_water_pour"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_water_pour.vfx");
  level._effect["vfx_spr_falling_dust_ceiling_s"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_falling_dust_ceiling_s.vfx");
  level._effect["vfx_spr_mosc_water"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_mosc_water.vfx");
  level._effect["vfx_spr_fire_sm"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_fire_sm.vfx");
  level._effect["vfx_spr_bird_sky_a"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_bird_sky_a.vfx");
  level._effect["vfx_spr_bird_sky_a"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_bird_sky_a.vfx");
  level._effect["vfx_spr_window_smoke_3"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_window_smoke_3.vfx");
  level._effect["vfx_spr_blowing_leaf_c"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_blowing_leaf_c.vfx");
  level._effect["vfx_spr_blowing_leaf_b"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_blowing_leaf_b.vfx");
  level._effect["vfx_spr_car_far"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_car_far.vfx");
  level._effect["vfx_spr_flys_a"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_flys_a.vfx");
  level._effect["vfx_spr_falling_dust_ceiling"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_falling_dust_ceiling.vfx");
  level._effect["vfx_spr_trash_circle"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_trash_circle.vfx");
  level._effect["vfx_spr_trash_slow"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_trash_slow.vfx");
  level._effect["vfx_spr_moth_b"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_moth_b.vfx");
  level._effect["vfx_spr_gd_steam_a"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_gd_steam_a.vfx");
  level._effect["vfx_spr_blowing_leaf"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_blowing_leaf.vfx");
  level._effect["vfx_spr_indoor_motes_wrap"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_indoor_motes_wrap.vfx");
  level._effect["vfx_spr_indoor_motes_wrap"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_indoor_motes_wrap.vfx");
  level._effect["vfx_spr_dust_move_slow"] = loadfx("vfx/iw8_mp/level/spear/vfx_spr_dust_move_slow.vfx");
  level._effect["vfx_swirling_dust"] = loadfx("vfx/iw8_mp/level/faridah/vfx_swirling_dust.vfx");
  level._effect["vfx_safehouse_farahbomb"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_farahbomb.vfx");
  level._effect["vfx_gen_fluorescent_lf"] = loadfx("vfx/iw8/level/gen_amb/vfx_gen_fluorescent_lf.vfx");
  level._effect["vfx_safehouse_farah_knife_impact"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_farah_knife_impact.vfx");
  level._effect["vfx_imp_flesh_fatal"] = loadfx("vfx/iw8/weap/_impact/flesh/vfx_imp_flesh_fatal_med.vfx");
  level._effect["vfx_safehouse_electrical_sparks_1"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_electrical_sparks_1.vfx");
  level._effect["vfx_safehouse_heli_dust_window_explo"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_heli_dust_window_explo.vfx");
  level._effect["vfx_ambulance_tire_dust"] = loadfx("vfx/iw8/level/safehouse/vfx_ambulance_tire_dust.vfx");
  level._effect["vfx_safehouse_alley_cinderblock_takedown_blood_rus_02"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_alley_cinderblock_takedown_blood_rus_02.vfx");
  level._effect["vfx_safehouse_carnage_rus_stab_1_neck_2"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_carnage_rus_stab_1_neck_2.vfx");
  level._effect["vfx_safehouse_carnage_rus_stab_1_neck"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_carnage_rus_stab_1_neck.vfx");
  level._effect["vfx_safehouse_carnage_rus_stab_1"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_carnage_rus_stab_1.vfx");
  level._effect["vfx_safehouse_guarded_rus_stab_2"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_guarded_rus_stab_2.vfx");
  level._effect["vfx_safehouse_guarded_rus_stab_3"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_guarded_rus_stab_3.vfx");
  level._effect["vfx_safehouse_guarded_rus_stab_1"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_guarded_rus_stab_1.vfx");
  level._effect["vfx_safehouse_throw_knife_imp_rus"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_throw_knife_imp_rus.vfx");
  level._effect["vfx_safehouse_farah_takedown_dust_fall"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_farah_takedown_dust_fall.vfx");
  level._effect["vfx_safehouse_farah_crawl_foot"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_farah_crawl_foot.vfx");
  level._effect["vfx_safehouse_farah_takedown_dust_door"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_farah_takedown_dust_door.vfx");
  level._effect["vfx_safehouse_rus_stab_alley_b_3"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_rus_stab_alley_b_3.vfx");
  level._effect["vfx_safehouse_rus_stab_alley_b_2"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_rus_stab_alley_b_2.vfx");
  level._effect["vfx_safehouse_rus_stab_alley_b"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_rus_stab_alley_b.vfx");
  level._effect["vfx_safehouse_rus_alley_blood_smears"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_rus_alley_blood_smears.vfx");
  level._effect["vfx_safehouse_farah_knife_impact_decal"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_farah_knife_impact_decal.vfx");
  level._effect["vfx_safehouse_rus_stab_alley_a_2"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_rus_stab_alley_a_2.vfx");
  level._effect["vfx_safehouse_chimney_smoke_blowing"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_chimney_smoke_blowing.vfx");
  level._effect["vfx_safehouse_rus_stab_alley_a"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_rus_stab_alley_a.vfx");
  level._effect["vfx_safehouse_windfield_med_x"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_windfield_med_x.vfx");
  level._effect["vfx_safehouse_debris_explo"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_debris_explo.vfx");
  level._effect["vfx_safehouse_gaz_splash"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_gaz_splash.vfx");
  level._effect["vfx_safehouse_gaz_pour"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_gaz_pour.vfx");
  level._effect["vfx_safehouse_oil_filter_raise_drips"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_oil_filter_raise_drips.vfx");
  level._effect["vfx_safehouse_oil_decal"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_oil_decal.vfx");
  level._effect["vfx_safehouse_oil_stream"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_oil_stream.vfx");
  level._effect["vfx_safehouse_flying_debris"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_flying_debris.vfx");
  level._effect["vfx_blowing_sand_openings_01"] = loadfx("vfx/iw8/level/safehouse/vfx_blowing_sand_openings_01.vfx");
  level._effect["vfx_safehouse_billow_mist_a"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_billow_mist_a.vfx");
  level._effect["vfx_door_dust_01"] = loadfx("vfx/iw8/level/safehouse/vfx_door_dust_01.vfx");
  level._effect["vfx_safehouse_blowing_sand_flat_heavy"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_blowing_sand_flat_heavy.vfx");
  level._effect["vfx_trash_flys"] = loadfx("vfx/iw8_mp/level/hackyard/vfx_trash_flys.vfx");
  level._effect["vfx_safehouse_umike_am"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_umike_am.vfx");
  level._effect["vfx_safehouse_heli_rotor_model"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_heli_rotor_model.vfx");
  level._effect["vfx_hit_damage_spark"] = loadfx("vfx/iw8/level/safehouse/vfx_hit_damage_spark.vfx");
  level._effect["vfx_safehouse_fire_mid"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_fire_mid.vfx");
  level._effect["vfx_safehouse_tunnel_flare_smoke_hadir"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_tunnel_flare_smoke_hadir.vfx");
  level._effect["vfx_safehouse_tunnel_flare_smoke_walk"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_tunnel_flare_smoke_walk.vfx");
  level._effect["vfx_safehouse_tunnel_flare_smoke"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_tunnel_flare_smoke.vfx");
  level._effect["vfx_safehouse_flare_tunnel"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_flare_tunnel.vfx");
  level._effect["vfx_safehouse_ground_dust_imp"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_ground_dust_imp.vfx");
  level._effect["vfx_safehouse_dust_fast_lrg"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_dust_fast_lrg.vfx");
  level._effect["vfx_safehouse_sandstorm_close_01"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_sandstorm_close_01.vfx");
  level._effect["vfx_veh_headlight_umike_right_run"] = loadfx("vfx/iw8/level/safehouse/vfx_veh_headlight_umike_right_run.vfx");
  level._effect["vfx_veh_headlight_umike_left_run"] = loadfx("vfx/iw8/level/safehouse/vfx_veh_headlight_umike_left_run.vfx");
  level._effect["vfx_veh_headlight_vindia_left_run"] = loadfx("vfx/iw8/level/safehouse/vfx_veh_headlight_vindia_left_run.vfx");
  level._effect["vfx_veh_headlight_vindia_right_run"] = loadfx("vfx/iw8/level/safehouse/vfx_veh_headlight_vindia_right_run.vfx");
  level._effect["vfx_safehouse_blowing_sand_flat_thick"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_blowing_sand_flat_thick.vfx");
  level._effect["vfx_safehouse_debris_ground_01"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_debris_ground_01.vfx");
  level._effect["vfx_safehouse_dust_swirl_tunnel"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_dust_swirl_tunnel.vfx");
  level._effect["vfx_safehouse_godray_top"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_godray_top.vfx");
  level._effect["vfx_safehouse_godray"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_godray.vfx");
  level._effect["vfx_safehouse_farah_backpack_bomb"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_farah_backpack_bomb.vfx");
  level._effect["vfx_light_moths"] = loadfx("vfx/iw8/prop/scriptables/shared/vfx_light_moths.vfx");
  level._effect["vfx_safehouse_sandstorm_01"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_sandstorm_01.vfx");
  level._effect["vfx_safehouse_periph_dust"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_periph_dust.vfx");
  level._effect["vfx_safehouse_tunnel_constant_motes"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_tunnel_constant_motes.vfx");
  level._effect["vfx_safehouse_fire_big"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_fire_big.vfx");
  level._effect["vfx_safehouse_tunnel_flare_smoke_hadir_02"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_tunnel_flare_smoke_hadir_02.vfx");
  level._effect["vfx_safehouse_tunnel_flare_smoke_hadir_up"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_tunnel_flare_smoke_hadir_up.vfx");
}

init_footstep_fx() {
  scripts\anim\utility.gsc::setfootstepeffect("soldier", "default", loadfx("vfx/iw8/level/safehouse/vfx_safehouse_footstep_dust.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect("soldier", "dirt", loadfx("vfx/iw8/level/safehouse/vfx_safehouse_footstep_dust.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect("soldier", "concrete_dry", loadfx("vfx/iw8/level/safehouse/vfx_safehouse_footstep_dust.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect("soldier", "asphalt_dry", loadfx("vfx/iw8/level/safehouse/vfx_safehouse_footstep_dust.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect("soldier", "concrete_wet", loadfx("vfx/iw8/level/safehouse/vfx_safehouse_footstep_dust.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect("soldier", "asphalt_wet", loadfx("vfx/iw8/level/safehouse/vfx_safehouse_footstep_dust.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect("soldier", "sand", loadfx("vfx/iw8/level/safehouse/vfx_safehouse_footstep_dust.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect("soldier", "mud", loadfx("vfx/iw8/level/safehouse/vfx_safehouse_footstep_dust.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect("soldier", "rock", loadfx("vfx/iw8/level/safehouse/vfx_safehouse_footstep_dust.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect("soldier", "water", loadfx("vfx/iw8/level/safehouse/vfx_safehouse_footstep_dust.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall("soldier", "default", loadfx("vfx/iw8/level/safehouse/vfx_safehouse_footstep_dust.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall("soldier", "mud", loadfx("vfx/iw8/level/safehouse/vfx_safehouse_footstep_dust.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall("soldier", "dirt", loadfx("vfx/iw8/level/safehouse/vfx_safehouse_footstep_dust.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall("soldier", "sand", loadfx("vfx/iw8/level/safehouse/vfx_safehouse_footstep_dust.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall("soldier", "rock", loadfx("vfx/iw8/level/safehouse/vfx_safehouse_footstep_dust.vfx"));
}

init_scripted_fx() {
  level._effect["level_farahKnifeTrail"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_throwingknife_geotrail.vfx");
  level._effect["level_farahKnifeImpact"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_throwingknife_impact_flesh.vfx");
  level._effect["intro_flare"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_emergency_flare.vfx");
}