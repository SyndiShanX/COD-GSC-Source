/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\aas_72x_destroy.gsc
***********************************************/

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("aas_72x", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_aas_72x", "vehicle_aas72x_destroyed_anim");
  vehicle_scripts\aas_72x::main_common(var_0, var_1, var_2);
  set_death_anim_scene();
  maps\_vehicle::build_rider_death_func(::handle_rider_death);
}

init_local() {
  vehicle_scripts\aas_72x::init_local();
  self.alwaysrocketdeath = 1;
  self.enablerocketdeath = 1;
  self.is_anim_based_death = 1;
  self.animname = "aas_72x";
  self.missile_targetoffset = (0, 0, -128);
  self.has_unmatching_deathmodel_rig = 1;
  self.death_fx_on_self = 1;
  self.allowdeath = 0;
  thread specific_death_explosion();
}

handle_rider_death() {
  foreach(var_1 in self.riders)
  var_1 delete();
}

#using_animtree("vehicles");

set_death_anim_scene(var_0) {
  similar_deaths(%aas_72x_explode_a, "aas_72x_explode_A");
  similar_deaths(%aas_72x_explode_b, "aas_72x_explode_B");
  similar_deaths(%aas_72x_explode_c, "aas_72x_explode_C");
  maps\_vehicle::build_deathanim(["aas_72x_explode_B", "aas_72x_explode_C"]);
}

similar_deaths(var_0, var_1) {
  common_scripts\utility::add_fx("aas_72x_explode_B", "vfx/gameplay/vehicles/aas72x/aas72x_body_1s");
  common_scripts\utility::add_fx("aas_72x_explode_C", "vfx/gameplay/vehicles/aas72x/aas72x_body_exp_1s");
  maps\_anim::create_anim_scene(#animtree, var_1, var_0, "aas_72x");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_expl_missile", "vfx/moments/las_vegas/vfx_heli_exp_vegas_missile");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_engine", "vfx/gameplay/vehicles/aas72x/aas72x_smoke_trail_r");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_wing_left", "vfx/moments/las_vegas/vfx_heli_exp_st_med");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_tailpiece1", "vfx/moments/las_vegas/vfx_heli_exp_st_med");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_tailpiece2", "vfx/moments/las_vegas/vfx_heli_exp_st_med");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_p2", "vfx/moments/las_vegas/vfx_heli_exp_st_med");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_body", "vfx/moments/las_vegas/vfx_heli_exp_st_med");
  maps\_anim::note_track_start_sound("start", "aas72x_helicopter_spin", 1, "tag_aas72x_rotor_main_lod0");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_aas72x_bodypiece01_lod0", "vfx/gameplay/vehicles/aas72x/aas72x_bodypiece01_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_aas72x_bodypiece02_lod0", "vfx/gameplay/vehicles/aas72x/aas72x_bodypiece02_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_aas72x_bodypiece03_lod0", "vfx/gameplay/vehicles/aas72x/aas72x_bodypiece03_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_aas72x_bodypiece04_lod0", "vfx/gameplay/vehicles/aas72x/aas72x_bodypiece04_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_aas72x_bodypiece05_lod0", "vfx/gameplay/vehicles/aas72x/aas72x_bodypiece05_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_aas72x_bodypiece06_lod0", "vfx/gameplay/vehicles/aas72x/aas72x_bodypiece06_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_aas72x_bodypiece07_lod0", "vfx/gameplay/vehicles/aas72x/aas72x_bodypiece07_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_aas72x_bodypiece08_lod0", "vfx/gameplay/vehicles/aas72x/aas72x_bodypiece08_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_aas72x_bodypiece09_lod0", "vfx/gameplay/vehicles/aas72x/aas72x_bodypiece09_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_aas72x_bodypiece10_lod0", "vfx/gameplay/vehicles/aas72x/aas72x_bodypiece10_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_aas72x_bodypiece11_lod0", "vfx/gameplay/vehicles/aas72x/aas72x_bodypiece11_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_aas72x_bodypiece12_lod0", "vfx/gameplay/vehicles/aas72x/aas72x_bodypiece12_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_aas72x_body_lod0", "vfx/gameplay/vehicles/aas72x/aas72x_body_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_aas72x_rotor_main_lod0", "vfx/gameplay/vehicles/aas72x/aas72x_rotor_main_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_aas72x_tail_lod0", "vfx/gameplay/vehicles/aas72x/aas72x_tail_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_aas72x_tailpiece1_lod0", "vfx/gameplay/vehicles/aas72x/aas72x_tailpiece1_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_aas72x_tailpiece2_lod0", "vfx/gameplay/vehicles/aas72x/aas72x_tailpiece2_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_aas72x_tailpiece3_lod0", "vfx/gameplay/vehicles/aas72x/aas72x_tailpiece3_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_aas72x_tailpiece4_lod0", "vfx/gameplay/vehicles/aas72x/aas72x_tailpiece4_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_aas72x_wing_left_lod0", "vfx/gameplay/vehicles/aas72x/aas72x_wing_left_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_aas72x_wing_right_lod0", "vfx/gameplay/vehicles/aas72x/aas72x_wing_right_1s");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_aas72x_wing_right_pc1_lod0", "vfx/gameplay/vehicles/aas72x/aas72x_wing_right_pc1_1s");
}

specific_death_explosion() {
  self waittill("kill_death_anim", var_0);

  if(!isDefined(level._effect[var_0])) {
    return;
  }
  var_1 = "tag_aas72x_body_lod0";
  playFXOnTag(common_scripts\utility::getfx(var_0), self, var_1);
}