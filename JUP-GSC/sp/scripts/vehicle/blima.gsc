/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\blima.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_build;
#using scripts\engine\utility;
#namespace blima;

function main(model, type, classname) {
  build_template("blima", model, type, classname);
  build_localinit(&init_local);
  build_deathmodel("veh8_mil_air_blima");
  build_deathfx("vfx/core/expl/grenadeexp_default.vfx", "tag_engine_left", "veh9_dmg_mil_air_heli_palfa_explode", undefined, undefined, undefined, 0.2, 1, undefined);
  build_deathfx("vfx/core/expl/grenadeexp_default.vfx", "tail_rotor_jnt", undefined, undefined, undefined, undefined, 0.5, 1, undefined);
  build_deathfx("vfx/core/expl/fire_smoke_trail_l.vfx", "tag_engine_left", undefined, undefined, undefined, 1, 0.5, 1, undefined);
  build_radiusdamage((0, 0, 0), 500, 120, 20);
  build_treadfx();
  build_treadfx(classname, "default", "vfx/code/tread/heli_dust_default.vfx", 1);
  build_life(3000, 2800, 3100);
  build_team("allies");
  build_aianims(&setanims, &set_vehicle_anims, "blima");
  build_attach_models(&set_attached_models);
  randomstartdelay = randomfloatrange(0, 1);
  build_light(classname, "cockpit_red_cargo01", "tag_light_cargo01", "vfx/misc/aircraft_light_cockpit_red", "interior", 0);
  build_light(classname, "cockpit_red_cargo02", "tag_light_cargo02", "vfx/misc/aircraft_light_cockpit_red", "interior", 0);
  build_light(classname, "cockpit_blue_cockpit01", "tag_light_cockpit01", "vfx/misc/aircraft_light_cockpit_blue", "interior", 0.1);
  build_light(classname, "white_blink_belly", "tag_light_belly", "vfx/core/vehicles/aircraft_light_white_blink_lit", "running", randomstartdelay);
  build_light(classname, "red_blink_tail", "tag_light_tail", "vfx/core/vehicles/aircraft_light_red_blink_lit", "running", randomstartdelay);
  build_light(classname, "wingtip_green", "tag_light_L_wing", "vfx/core/vehicles/aircraft_light_wingtip_red_lit", "running", randomstartdelay);
  build_light(classname, "wingtip_red", "tag_light_R_wing", "vfx/core/vehicles/aircraft_light_wingtip_green_lit", "running", randomstartdelay);
  build_light(classname, "spot", "tag_passenger", "vfx/misc/aircraft_light_hindspot", "spot", 0);
  build_unload_groups(&unload_groups);
  build_bulletshield(1);
  build_is_helicopter();
}

function setup_lights(classname) {}

function init_local() {
  self.unload_hover_offset = 570;
  self.unload_land_offset = 165;
  self.script_badplace = 0;

  if(!scripts\engine\utility::is_equal(self.script_vehicle_lights_off, "running")) {
    scripts\common\vehicle::vehicle_lights_on("running");
  }

  self.vehicleanimalias = "blima";
  self.vehiclesetuprope = 1;
  thread handle_scriptable_vfx();

  if(self.classname == "script_vehicle_blima_hi_res") {
    self attach("veh8_mil_air_blima_interior_vm");
  }
}

function handle_scriptable_vfx() {
  self endon("death");

  if(utility::issp() || utility::iscp()) {
    scripts\engine\utility::flag_wait("scriptables_ready");
    self setscriptablepartstate("engine", "on");
    self setscriptablepartstate("vector_field", "on");
  }
}

#using_animtree("generic_human");

function setanims() {
  positions = [];

  for(i = 0; i < 10; i++) {
    positions[i] = spawnStruct();
  }

  positions[0].idle = % vh_blima_rappel_pilot;
  positions[1].idle = % vh_blima_rappel_copilot;
  positions[2].idle = % vh_blima_rappel_soldier0_idle;
  positions[3].idle = % vh_blima_rappel_soldier1_idle;
  positions[4].idle = % vh_blima_rappel_soldier2_idle;
  positions[5].idle = % vh_blima_rappel_soldier3_idle;
  positions[6].idle = % vh_blima_rappel_soldier4_idle;
  positions[7].idle = % vh_blima_rappel_soldier6_idle;
  positions[8].idle = % vh_blima_rappel_soldier8_idle;
  positions[9].idle = % vh_blima_rappel_soldier9_idle;
  positions[0].sittag = "tag_pilot1";
  positions[1].sittag = "tag_pilot2";
  positions[2].sittag = "tag_guy0";
  positions[3].sittag = "tag_guy2";
  positions[4].sittag = "tag_guy4";
  positions[5].sittag = "tag_guy9";
  positions[6].sittag = "tag_guy9";
  positions[7].sittag = "tag_guy1";
  positions[8].sittag = "tag_guy3";
  positions[9].sittag = "tag_guy2";
  positions[0].canshootinvehicle = 0;
  positions[1].canshootinvehicle = 0;
  positions[2].canshootinvehicle = 0;
  positions[3].canshootinvehicle = 1;
  positions[4].canshootinvehicle = 1;
  positions[5].canshootinvehicle = 1;
  positions[6].canshootinvehicle = 1;
  positions[7].canshootinvehicle = 1;
  positions[8].canshootinvehicle = 1;
  positions[9].canshootinvehicle = 1;
  positions[2].getout = % vh_blima_rappel_soldier0_drop;
  positions[3].getout = % vh_blima_rappel_soldier1_drop;
  positions[4].getout = % vh_blima_rappel_soldier2_drop;
  positions[7].getout = % vh_blima_rappel_soldier6_drop;
  positions[8].getout = % vh_blima_rappel_soldier8_drop;
  positions[9].getout = % vh_blima_rappel_soldier9_drop;
  positions[2].ragdoll_getout_death = 1;
  positions[3].ragdoll_getout_death = 1;
  positions[4].ragdoll_getout_death = 1;
  positions[5].ragdoll_getout_death = 1;
  positions[6].ragdoll_getout_death = 1;
  positions[7].ragdoll_getout_death = 1;
  positions[8].ragdoll_getout_death = 1;
  positions[9].ragdoll_getout_death = 1;
  positions[2].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  positions[3].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  positions[4].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  positions[5].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  positions[6].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  positions[7].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  positions[8].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  positions[9].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  positions[2].fastroperig = "TAG_FastRope_LE";
  positions[3].fastroperig = "TAG_FastRope_LE";
  positions[4].fastroperig = "TAG_FastRope_LE";
  positions[5].fastroperig = "TAG_FastRope_LE";
  positions[6].fastroperig = "TAG_FastRope_RI";
  positions[7].fastroperig = "TAG_FastRope_RI";
  positions[8].fastroperig = "TAG_FastRope_RI";
  positions[9].fastroperig = "TAG_FastRope_RI";
  positions[5].setuprope = 1;
  positions[6].setuprope = 1;
  return positions;
}

function set_vehicle_anims(positions) {
  if(!utility::issp()) {
    return function_d9744c54ebc367f5(positions);
  }

  return function_7e79f1b51303070f(positions);
}

#using_animtree("mp_vehicles_always_loaded");

function function_d9744c54ebc367f5(positions) {
  for(i = 0; i < positions.size; i++) {
    positions[i].vehicle_getoutanim = % vh_blima_rappel_heli_drop;
  }

  return positions;
}

#using_animtree("vehicles");

function function_7e79f1b51303070f(positions) {
  for(i = 0; i < positions.size; i++) {
    positions[i].vehicle_getoutanim = % vh_blima_rappel_heli_drop;
  }

  return positions;
}

function unload_groups() {
  unload_groups = [];
  unload_groups["left"] = [];
  unload_groups["right"] = [];
  unload_groups["both"] = [];
  unload_groups["left"][unload_groups["left"].size] = 3;
  unload_groups["left"][unload_groups["left"].size] = 6;
  unload_groups["left"][unload_groups["left"].size] = 8;
  unload_groups["left"][unload_groups["left"].size] = 9;
  unload_groups["right"][unload_groups["right"].size] = 2;
  unload_groups["right"][unload_groups["right"].size] = 4;
  unload_groups["right"][unload_groups["right"].size] = 5;
  unload_groups["right"][unload_groups["right"].size] = 7;
  unload_groups["both"][unload_groups["both"].size] = 2;
  unload_groups["both"][unload_groups["both"].size] = 3;
  unload_groups["both"][unload_groups["both"].size] = 4;
  unload_groups["both"][unload_groups["both"].size] = 5;
  unload_groups["both"][unload_groups["both"].size] = 6;
  unload_groups["both"][unload_groups["both"].size] = 7;
  unload_groups["both"][unload_groups["both"].size] = 8;
  unload_groups["both"][unload_groups["both"].size] = 9;
  unload_groups["default"] = unload_groups["both"];
  return unload_groups;
}

#using_animtree("script_model");

function set_attached_models() {
  array = [];
  array["TAG_FastRope_LE"] = spawnStruct();
  array["TAG_FastRope_LE"].model = "equipment_fast_rope_wm_01_infil_heli_l";
  array["TAG_FastRope_LE"].tag = "origin_animate_jnt";
  array["TAG_FastRope_LE"].idleanim = % equipment_fast_rope_wm_01_infil_heli_l;
  array["TAG_FastRope_LE"].dropanim = % equipment_fast_rope_wm_01_infil_heli_l_fall;
  array["TAG_FastRope_RI"] = spawnStruct();
  array["TAG_FastRope_RI"].model = "equipment_fast_rope_wm_01_infil_heli_l";
  array["TAG_FastRope_RI"].tag = "origin_animate_jnt";
  array["TAG_FastRope_RI"].idleanim = % equipment_fast_rope_wm_01_infil_heli_r;
  array["TAG_FastRope_RI"].dropanim = % equipment_fast_rope_wm_01_infil_heli_r_fall;
  strings = getarraykeys(array);

  for(i = 0; i < strings.size; i++) {
    precachemodel(array[strings[i]].model);
  }

  return array;
}