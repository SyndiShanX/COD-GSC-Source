/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\apache.gsc
**************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("apache", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_apache_iw6", "vehicle_apache_iw6_destroyed_anim");
  maps\_vehicle::build_drive(%bh_rotors, undefined, 0);
  maps\_vehicle::build_deathfx("fx/explosions/helicopter_explosion_secondary_small", "tag_engine_left", "apache_helicopter_secondary_exp", undefined, undefined, undefined, 0.0, 1, undefined);
  maps\_vehicle::build_deathfx("fx/fire/fire_smoke_trail_L", "tag_engine_left", "apache_helicopter_dying_loop", 1, 0.05, 1, 0.5, 1, undefined);
  maps\_vehicle::build_deathfx("fx/explosions/helicopter_explosion_secondary_small", "tag_engine_left", "apache_helicopter_secondary_exp", undefined, undefined, undefined, 2.5, 1, undefined);
  maps\_vehicle::build_deathfx("fx/explosions/helicopter_explosion_hind_oilrocks_primary", undefined, "apache_helicopter_crash", undefined, undefined, undefined, -1, undefined, "stop_crash_loop_sound");
  maps\_vehicle::build_rocket_deathfx("fx/explosions/helicopter_explosion_hind_oilrocks_primary", "tag_deathfx", "apache_helicopter_crash", undefined, undefined, undefined, undefined, 1, undefined, 0, 5);
  maps\_vehicle::build_light(var_2, "wingtip_green", "tag_light_L_wing", "fx/misc/aircraft_light_wingtip_green", "running", 0);
  maps\_vehicle::build_light(var_2, "wingtip_red", "tag_light_R_wing", "fx/misc/aircraft_light_wingtip_red", "running", 0.05);
  maps\_vehicle::build_light(var_2, "white_blink", "tag_light_belly", "fx/misc/aircraft_light_white_blink", "running", 0.1);
  maps\_vehicle::build_light(var_2, "white_blink_tail", "tag_light_tail", "fx/misc/aircraft_light_red_blink", "running", 0.25);
  maps\_vehicle::build_light(var_2, "cockpit", "tag_light_cockpit01", "fx/misc/aircraft_light_wingtip_green", "running", 0.1);
  maps\_vehicle::build_light(var_2, "cargo_1", "tag_light_cargo01", "fx/misc/aircraft_light_red_blink", "running", 0.25);
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_treadfx(var_2, "default", "fx/treadfx/heli_dust_default", 0);
  maps\_vehicle::build_team("allies");
  var_3 = (0, 0, 10);
  maps\_vehicle::build_turret("apache_turret", "turret_animate_jt", "vehicle_apache_iw6_mg", undefined, "auto_nonai", 0.0, 20, -14, var_3);
  precacheitem("zippy_rockets_apache");
  precacheitem("zippy_rockets_apache_nodamage");
  maps\_vehicle::build_is_helicopter();
  set_death_anim_scene();
}

set_death_anim_scene(var_0) {
  similar_deaths(%apache_iw6_explode_a, "apache_explode_V1");
  similar_deaths(%apache_iw6_explode_b, "apache_explode_V2");
  similar_deaths(%apache_iw6_explode_c, "apache_explode_V3");
  maps\_vehicle::build_deathanim(["apache_explode_V1", "apache_explode_V2", "apache_explode_V3"]);
}

similar_deaths(var_0, var_1) {
  maps\_anim::create_anim_scene(#animtree, var_1, var_0, "apache_iw6");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_engine", "vfx/gameplay/smoke_trails/vfx_st_heli_small");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_wing_left", "vfx/gameplay/smoke_trails/vfx_st_heli_med");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_tailpiece1", "vfx/gameplay/smoke_trails/vfx_st_heli_small");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_p2", "vfx/gameplay/smoke_trails/vfx_st_heli_small");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_body", "vfx/gameplay/smoke_trails/vfx_st_heli_med");
  maps\_anim::note_track_start_sound("start", "apache_helicopter_spin", 1, "tag_apache_rotor_main_lod0");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_expl_missile", "vfx/gameplay/explosions/vehicle/heli/vfx_exp_heli_pr_apa");

  if(animhasnotetrack(var_0, "apache_explode_fuel"))
    maps\_anim::note_track_start_fx_on_tag("apache_explode_fuel", "tag_fx_expl_fuel", "vfx/gameplay/explosions/vehicle/heli/vfx_exp_heli_secondary");

  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_apache_body_lod0", "vfx/gameplay/vehicles/apache/apache_body_1s", "vfx/gameplay/vehicles/apache/apache_body_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_apache_bodypiece01_lod0", "vfx/gameplay/vehicles/apache/apache_bodypiece01_1s", "vfx/gameplay/vehicles/apache/apache_bodypiece01_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_apache_bodypiece02_lod0", "vfx/gameplay/vehicles/apache/apache_bodypiece02_1s", "vfx/gameplay/vehicles/apache/apache_bodypiece02_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_apache_bodypiece03_lod0", "vfx/gameplay/vehicles/apache/apache_bodypiece03_1s", "vfx/gameplay/vehicles/apache/apache_bodypiece03_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_apache_bodypiece04_lod0", "vfx/gameplay/vehicles/apache/apache_bodypiece04_1s", "vfx/gameplay/vehicles/apache/apache_bodypiece04_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_apache_bodypiece05_lod0", "vfx/gameplay/vehicles/apache/apache_bodypiece05_1s", "vfx/gameplay/vehicles/apache/apache_bodypiece05_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_apache_bodypiece06_lod0", "vfx/gameplay/vehicles/apache/apache_bodypiece06_1s", "vfx/gameplay/vehicles/apache/apache_bodypiece06_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_apache_bodypiece07_lod0", "vfx/gameplay/vehicles/apache/apache_bodypiece07_1s", "vfx/gameplay/vehicles/apache/apache_bodypiece07_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_apache_bodypiece08_lod0", "vfx/gameplay/vehicles/apache/apache_bodypiece08_1s", "vfx/gameplay/vehicles/apache/apache_bodypiece08_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_apache_bodypiece09_lod0", "vfx/gameplay/vehicles/apache/apache_bodypiece09_1s", "vfx/gameplay/vehicles/apache/apache_bodypiece09_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_apache_bodypiece11_lod0", "vfx/gameplay/vehicles/apache/apache_bodypiece11_1s", "vfx/gameplay/vehicles/apache/apache_bodypiece11_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_apache_bodypiece12_lod0", "vfx/gameplay/vehicles/apache/apache_bodypiece12_1s", "vfx/gameplay/vehicles/apache/apache_bodypiece12_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_apache_rotor_main_lod0", "vfx/gameplay/vehicles/apache/apache_rotor_main_1s", "vfx/gameplay/vehicles/apache/apache_rotor_main_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_apache_rotor_tail_lod0", "vfx/gameplay/vehicles/apache/apache_rotor_tail_1s", "vfx/gameplay/vehicles/apache/apache_rotor_tail_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_apache_tailpiece1_lod0", "vfx/gameplay/vehicles/apache/apache_tailpiece1_1s", "vfx/gameplay/vehicles/apache/apache_tailpiece1_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_apache_tailpiece2_lod0", "vfx/gameplay/vehicles/apache/apache_tailpiece2_1s", "vfx/gameplay/vehicles/apache/apache_tailpiece2_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_apache_tailpiece3_lod0", "vfx/gameplay/vehicles/apache/apache_tailpiece3_1s", "vfx/gameplay/vehicles/apache/apache_tailpiece3_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_apache_tailpiece4_lod0", "vfx/gameplay/vehicles/apache/apache_tailpiece4_1s", "vfx/gameplay/vehicles/apache/apache_tailpiece4_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_apache_tailpiece5_lod0", "vfx/gameplay/vehicles/apache/apache_tailpiece5_1s", "vfx/gameplay/vehicles/apache/apache_tailpiece5_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_apache_wing_left_lod0", "vfx/gameplay/vehicles/apache/apache_wing_left_1s", "vfx/gameplay/vehicles/apache/apache_wing_left_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_apache_wing_left_pc1_lod0", "vfx/gameplay/vehicles/apache/apache_wing_left_pc1_1s", "vfx/gameplay/vehicles/apache/apache_wing_left_pc1_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_apache_wing_right_lod0", "vfx/gameplay/vehicles/apache/apache_wing_right_1s", "vfx/gameplay/vehicles/apache/apache_wing_right_1s");
}

init_local() {
  self.alwaysrocketdeath = 1;
  self.enablerocketdeath = 1;
  self.is_anim_based_death = 1;
  self.animname = "apache_iw6";
  self.missile_targetoffset = (0, 0, -128);
  self.has_unmatching_deathmodel_rig = 1;
  self.death_fx_on_self = 1;
  self.allowdeath = 0;
  self.script_badplace = 0;
  maps\_vehicle::vehicle_lights_on("running");
  self.boundryradius = 466;
  self hidepart("turret_animate_jt");
  self hidepart("tag_flash");
  self hidepart("tag_barrel");
  self hidepart("barrel_animate_jnt");
}