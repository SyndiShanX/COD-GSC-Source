/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: vehicle\blima.gsc
***********************************************/

main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("blima", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_deathmodel("veh8_mil_air_blima");
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/grenadeexp_default.vfx", "tag_engine_left", "hind_helicopter_hit", undefined, undefined, undefined, 0.2, 1, undefined);
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/grenadeexp_default.vfx", "tail_rotor_jnt", undefined, undefined, undefined, undefined, 0.5, 1, undefined);
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/fire_smoke_trail_l.vfx", "tag_engine_left", undefined, undefined, undefined, 1, 0.5, 1, undefined);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_treadfx();
  scripts\common\vehicle_build::build_treadfx(var_2, "default", "vfx/code/tread/heli_dust_default.vfx", 1);
  scripts\common\vehicle_build::build_life(3000, 2800, 3100);
  scripts\common\vehicle_build::build_team("allies");
  scripts\common\vehicle_build::build_aianims(::setanims, ::set_vehicle_anims, "blima");
  scripts\common\vehicle_build::build_attach_models(::set_attached_models);
  var_3 = randomfloatrange(0, 1);
  scripts\common\vehicle_build::build_light(var_2, "cockpit_red_cargo01", "tag_light_cargo01", "vfx/misc/aircraft_light_cockpit_red", "interior", 0.0);
  scripts\common\vehicle_build::build_light(var_2, "cockpit_red_cargo02", "tag_light_cargo02", "vfx/misc/aircraft_light_cockpit_red", "interior", 0.0);
  scripts\common\vehicle_build::build_light(var_2, "cockpit_blue_cockpit01", "tag_light_cockpit01", "vfx/misc/aircraft_light_cockpit_blue", "interior", 0.1);
  scripts\common\vehicle_build::build_light(var_2, "white_blink_belly", "tag_light_belly", "vfx/core/vehicles/aircraft_light_white_blink_lit", "running", var_3);
  scripts\common\vehicle_build::build_light(var_2, "red_blink_tail", "tag_light_tail", "vfx/core/vehicles/aircraft_light_red_blink_lit", "running", var_3);
  scripts\common\vehicle_build::build_light(var_2, "wingtip_green", "tag_light_L_wing", "vfx/core/vehicles/aircraft_light_wingtip_red_lit", "running", var_3);
  scripts\common\vehicle_build::build_light(var_2, "wingtip_red", "tag_light_R_wing", "vfx/core/vehicles/aircraft_light_wingtip_green_lit", "running", var_3);
  scripts\common\vehicle_build::build_light(var_2, "spot", "tag_passenger", "vfx/misc/aircraft_light_hindspot", "spot", 0.0);
  scripts\common\vehicle_build::build_unload_groups(::unload_groups);
  scripts\common\vehicle_build::build_bulletshield(1);
  scripts\common\vehicle_build::build_is_helicopter();
}

setup_lights(var_0) {}

init_local() {
  self.unload_hover_offset = 570;
  self.script_badplace = 0;

  if(!scripts\engine\utility::is_equal(self.script_vehicle_lights_off, "running"))
    scripts\common\vehicle::vehicle_lights_on("running");

  self.vehicleanimalias = "blima";
  self.vehiclesetuprope = 1;
  thread handle_scriptable_vfx();

  if(self.classname == "script_vehicle_blima_hi_res")
    self attach("veh8_mil_air_blima_interior_vm");
}

handle_scriptable_vfx() {
  self endon("death");

  if(scripts\common\utility::issp() || scripts\common\utility::iscp()) {
    scripts\engine\utility::flag_wait("scriptables_ready");
    self setscriptablepartstate("engine", "on");
    self setscriptablepartstate("vector_field", "on");
  }
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 10; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].idle = % vh_blima_rappel_pilot;
  var_0[1].idle = % vh_blima_rappel_copilot;
  var_0[2].idle = % vh_blima_rappel_soldier0_idle;
  var_0[3].idle = % vh_blima_rappel_soldier1_idle;
  var_0[4].idle = % vh_blima_rappel_soldier2_idle;
  var_0[5].idle = % vh_blima_rappel_soldier3_idle;
  var_0[6].idle = % vh_blima_rappel_soldier4_idle;
  var_0[7].idle = % vh_blima_rappel_soldier6_idle;
  var_0[8].idle = % vh_blima_rappel_soldier8_idle;
  var_0[9].idle = % vh_blima_rappel_soldier9_idle;
  var_0[0].sittag = "tag_pilot1";
  var_0[1].sittag = "tag_pilot2";
  var_0[2].sittag = "tag_guy0";
  var_0[3].sittag = "tag_guy2";
  var_0[4].sittag = "tag_guy4";
  var_0[5].sittag = "tag_guy9";
  var_0[6].sittag = "tag_guy9";
  var_0[7].sittag = "tag_guy1";
  var_0[8].sittag = "tag_guy3";
  var_0[9].sittag = "tag_guy2";
  var_0[2].getout = % vh_blima_rappel_soldier0_drop;
  var_0[3].getout = % vh_blima_rappel_soldier1_drop;
  var_0[4].getout = % vh_blima_rappel_soldier2_drop;
  var_0[7].getout = % vh_blima_rappel_soldier6_drop;
  var_0[8].getout = % vh_blima_rappel_soldier8_drop;
  var_0[9].getout = % vh_blima_rappel_soldier9_drop;
  var_0[0].death_no_ragdoll = 1;
  var_0[1].death_no_ragdoll = 1;
  var_0[2].ragdoll_getout_death = 1;
  var_0[3].ragdoll_getout_death = 1;
  var_0[4].ragdoll_getout_death = 1;
  var_0[5].ragdoll_getout_death = 1;
  var_0[6].ragdoll_getout_death = 1;
  var_0[7].ragdoll_getout_death = 1;
  var_0[8].ragdoll_getout_death = 1;
  var_0[9].ragdoll_getout_death = 1;
  var_0[2].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  var_0[3].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  var_0[4].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  var_0[5].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  var_0[6].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  var_0[7].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  var_0[8].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  var_0[9].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  var_0[2].fastroperig = "TAG_FastRope_LE";
  var_0[3].fastroperig = "TAG_FastRope_LE";
  var_0[4].fastroperig = "TAG_FastRope_LE";
  var_0[5].fastroperig = "TAG_FastRope_LE";
  var_0[6].fastroperig = "TAG_FastRope_RI";
  var_0[7].fastroperig = "TAG_FastRope_RI";
  var_0[8].fastroperig = "TAG_FastRope_RI";
  var_0[9].fastroperig = "TAG_FastRope_RI";
  var_0[5].setuprope = 1;
  var_0[6].setuprope = 1;
  return var_0;
}

#using_animtree("vehicles");

set_vehicle_anims(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1].vehicle_getoutanim = % vh_blima_rappel_heli_drop;

  return var_0;
}

unload_groups() {
  var_0 = [];
  var_0["left"] = [];
  var_0["right"] = [];
  var_0["both"] = [];
  var_0["left"][var_0["left"].size] = 3;
  var_0["left"][var_0["left"].size] = 6;
  var_0["left"][var_0["left"].size] = 8;
  var_0["left"][var_0["left"].size] = 9;
  var_0["right"][var_0["right"].size] = 2;
  var_0["right"][var_0["right"].size] = 4;
  var_0["right"][var_0["right"].size] = 5;
  var_0["right"][var_0["right"].size] = 7;
  var_0["both"][var_0["both"].size] = 2;
  var_0["both"][var_0["both"].size] = 3;
  var_0["both"][var_0["both"].size] = 4;
  var_0["both"][var_0["both"].size] = 5;
  var_0["both"][var_0["both"].size] = 6;
  var_0["both"][var_0["both"].size] = 7;
  var_0["both"][var_0["both"].size] = 8;
  var_0["both"][var_0["both"].size] = 9;
  var_0["default"] = var_0["both"];
  return var_0;
}

#using_animtree("script_model");

set_attached_models() {
  var_0 = [];
  var_0["TAG_FastRope_LE"] = spawnStruct();
  var_0["TAG_FastRope_LE"].model = "equipment_fast_rope_wm_01_infil_heli_l";
  var_0["TAG_FastRope_LE"].tag = "origin_animate_jnt";
  var_0["TAG_FastRope_LE"].idleanim = % equipment_fast_rope_wm_01_infil_heli_l;
  var_0["TAG_FastRope_LE"].dropanim = % equipment_fast_rope_wm_01_infil_heli_l_fall;
  var_0["TAG_FastRope_LE"].unloaddelay = 0;
  var_0["TAG_FastRope_RI"] = spawnStruct();
  var_0["TAG_FastRope_RI"].model = "equipment_fast_rope_wm_01_infil_heli_l";
  var_0["TAG_FastRope_RI"].tag = "origin_animate_jnt";
  var_0["TAG_FastRope_RI"].idleanim = % equipment_fast_rope_wm_01_infil_heli_r;
  var_0["TAG_FastRope_RI"].dropanim = % equipment_fast_rope_wm_01_infil_heli_r_fall;
  var_0["TAG_FastRope_RI"].unloaddelay = 0;
  var_1 = getarraykeys(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    precachemodel(var_0[var_1[var_2]].model);

  return var_0;
}