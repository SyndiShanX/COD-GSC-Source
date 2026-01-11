/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\hind_battle_oilrocks.gsc
****************************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2, var_3) {
  if(var_0 == "vehicle_battle_hind") {
    var_0 = "vehicle_battle_hind_no_mg";
  }

  foreach(var_5 in getEntArray("script_vehicle_hind_battle_oilrocks", "classname")) {
    var_5 setModel("vehicle_battle_hind_no_mg");
  }

  maps\_vehicle::build_template("hind_battle", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_battle_hind_no_mg", "vehicle_battle_hind_destroyed_anim");
  maps\_vehicle::build_drive( % battle_hind_spinning_rotor, undefined, 0);
  maps\_vehicle::build_treadfx(var_2, "default", "fx/treadfx/heli_dust_default", 0);
  maps\_vehicle::build_life(3000, 2800, 3100);
  maps\_vehicle::build_team("axis");
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
  maps\_vehicle::build_light(var_2, "cockpit_blue_cargo01", "tag_light_cargo01", "fx/misc/aircraft_light_cockpit_red", "interior", 0.0);
  maps\_vehicle::build_light(var_2, "cockpit_blue_cockpit01", "tag_light_cockpit01", "fx/misc/aircraft_light_cockpit_blue", "interior", 0.1);
  maps\_vehicle::build_light(var_2, "white_blink", "tag_light_belly", "fx/misc/aircraft_light_white_blink", "running", 0.3);
  maps\_vehicle::build_light(var_2, "white_blink_tail", "tag_light_tail", "fx/misc/aircraft_light_red_blink", "running", 0.3);
  maps\_vehicle::build_light(var_2, "wingtip_green", "tag_light_L_wing", "fx/misc/aircraft_light_wingtip_green", "running", 0.2);
  maps\_vehicle::build_light(var_2, "wingtip_red", "tag_light_R_wing", "fx/misc/aircraft_light_wingtip_red", "running", 0.2);
  maps\_vehicle::build_light(var_2, "spot", "tag_passenger", "fx/misc/aircraft_light_hindspot", "spot", 0.0);
  maps\_vehicle::build_bulletshield(1);
  maps\_vehicle::build_is_helicopter();
  var_7 = (-10, 0, -22);

  if(!isDefined(var_3)) {
    maps\_vehicle::build_turret("hind_turret_oilrocks", "TAG_TURRET_ATTACH", "vehicle_battle_hind_mg", undefined, "auto_nonai", 0.0, 20, -14, var_7);
  } else {
    maps\_vehicle::build_turret(var_3, "TAG_TURRET_ATTACH", "vehicle_battle_hind_mg", undefined, "auto_nonai", 0.0, 20, -14, var_7);
  }

  set_death_anim_scene();
}

init_local() {
  self.alwaysrocketdeath = 1;
  self.enablerocketdeath = 1;
  self.is_anim_based_death = 1;
  self.animname = "battle_hind";
  self.missile_targetoffset = (0, 0, -128);
  self.has_unmatching_deathmodel_rig = 1;
  self.death_fx_on_self = 1;
  self.allowdeath = 0;
  vehicle_scripts\hind::init_local();
}

set_death_anim_scene(var_0) {
  similar_deaths( % battle_hind_explode_a, "battle_hind_explode_singleV1");
  similar_deaths( % battle_hind_explode_b, "battle_hind_explode_singleV2");
  similar_deaths( % battle_hind_explode_d, "battle_hind_explode_singleV4");
  maps\_vehicle::build_deathanim(["battle_hind_explode_singleV1", "battle_hind_explode_singleV2", "battle_hind_explode_singleV4"]);
}

similar_deaths(var_0, var_1) {
  maps\_anim::create_anim_scene(#animtree, var_1, var_0, "battle_hind");
  var_2 = animhasnotetrack(var_0, "battle_hind_explode_fuel");
  maps\_anim::note_track_start_sound("start", "hind_helicopter_spin", 1, "tag_ctrl_body");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_engine", "vfx/gameplay/smoke_trails/vfx_st_heli_small");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_wing_left", "vfx/gameplay/smoke_trails/vfx_st_heli_med");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_tailpiece1", "vfx/gameplay/smoke_trails/vfx_st_heli_small");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_p2", "vfx/gameplay/smoke_trails/vfx_st_heli_small");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_body", "vfx/gameplay/smoke_trails/vfx_st_heli_med");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_expl_missile", "vfx/gameplay/explosions/vehicle/heli/vfx_exp_heli_pr_hind");

  if(var_2) {
    maps\_anim::note_track_start_fx_on_tag("battle_hind_explode_fuel", "tag_fx_expl_fuel", "vfx/gameplay/explosions/vehicle/heli/vfx_exp_heli_secondary");
  }

  if(var_2) {
    maps\_anim::note_track_trace_to_efx("start", "battle_hind_explode_fuel", "tag_ctrl_body", "vfx/gameplay/explosions/vehicle/heli/vfx_exp_heli_pr_hind", "vfx/gameplay/vehicles/heli_global/vfx_heli_s_splash");
  } else {
    maps\_anim::note_track_trace_to_efx("start", undefined, "tag_ctrl_body", "vfx/gameplay/vehicles/hind/hind_body_2s", "vfx/gameplay/vehicles/heli_global/vfx_heli_s_splash");
  }

  var_3 = common_scripts\utility::ter_op(var_2, "battle_hind_explode_fuel", "start");
  maps\_anim::note_track_trace_to_efx(var_3, undefined, "tag_ctrl_body_pc1", "vfx/gameplay/vehicles/hind/hind_bodypiece01_2s", "vfx/gameplay/vehicles/heli_global/vfx_heli_s_splash");
  maps\_anim::note_track_trace_to_efx(var_3, undefined, "tag_ctrl_body_pc2", "vfx/gameplay/vehicles/hind/hind_bodypiece02_2s", "vfx/gameplay/vehicles/heli_global/vfx_heli_s_splash");
  maps\_anim::note_track_trace_to_efx(var_3, undefined, "tag_ctrl_body_pc3", "vfx/gameplay/vehicles/hind/hind_bodypiece03_2s", "vfx/gameplay/vehicles/heli_global/vfx_heli_s_splash");
  maps\_anim::note_track_trace_to_efx(var_3, undefined, "tag_ctrl_body_pc4", "vfx/gameplay/vehicles/hind/hind_bodypiece04_2s", "vfx/gameplay/vehicles/heli_global/vfx_heli_s_splash");
  maps\_anim::note_track_trace_to_efx(var_3, undefined, "tag_ctrl_body_pc5", "vfx/gameplay/vehicles/hind/hind_bodypiece05_2s", "vfx/gameplay/vehicles/heli_global/vfx_heli_s_splash");
  maps\_anim::note_track_trace_to_efx(var_3, undefined, "tag_ctrl_body_pc6", "vfx/gameplay/vehicles/hind/hind_bodypiece06_2s", "vfx/gameplay/vehicles/heli_global/vfx_heli_s_splash");
  maps\_anim::note_track_trace_to_efx(var_3, undefined, "tag_ctrl_body_pc7", "vfx/gameplay/vehicles/hind/hind_bodypiece07_2s", "vfx/gameplay/vehicles/heli_global/vfx_heli_s_splash");
  maps\_anim::note_track_trace_to_efx(var_3, undefined, "tag_ctrl_body_pc8", "vfx/gameplay/vehicles/hind/hind_bodypiece08_2s", "vfx/gameplay/vehicles/heli_global/vfx_heli_s_splash");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_ctrl_blade_b", "vfx/gameplay/vehicles/hind/hind_rotor_lower_2s", "vfx/gameplay/vehicles/heli_global/vfx_heli_s_splash");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_ctrl_blade_u", "vfx/gameplay/vehicles/hind/hind_rotor_upper_2s", "vfx/gameplay/vehicles/heli_global/vfx_heli_s_splash");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_ctrl_tail", "vfx/gameplay/vehicles/hind/hind_tail_1s", "vfx/gameplay/vehicles/heli_global/vfx_heli_s_splash");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_ctrl_tailpiece1", "vfx/gameplay/vehicles/hind/hind_tailpiece1_1s", "vfx/gameplay/vehicles/heli_global/vfx_heli_s_splash");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_ctrl_tailpiece2", "vfx/gameplay/vehicles/hind/hind_tailpiece2_1s", "vfx/gameplay/vehicles/heli_global/vfx_heli_s_splash");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_ctrl_tailpiece3", "vfx/gameplay/vehicles/hind/hind_tailpiece3_1s", "vfx/gameplay/vehicles/heli_global/vfx_heli_s_splash");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_ctrl_wing_left", "vfx/gameplay/vehicles/hind/hind_wing_left_1s", "vfx/gameplay/vehicles/heli_global/vfx_heli_s_splash");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_ctrl_wing_left_pc1", "vfx/gameplay/vehicles/hind/hind_wing_leftpiece1_1s", "vfx/gameplay/vehicles/heli_global/vfx_heli_s_splash");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_ctrl_wing_left_pc2", "vfx/gameplay/vehicles/hind/hind_wing_leftpiece2_1s", "vfx/gameplay/vehicles/heli_global/vfx_heli_s_splash");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_ctrl_wing_left_pc3", "vfx/gameplay/vehicles/hind/hind_wing_leftpiece3_1s", "vfx/gameplay/vehicles/heli_global/vfx_heli_s_splash");
}