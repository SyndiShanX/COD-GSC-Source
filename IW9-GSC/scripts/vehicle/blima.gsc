/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\blima.gsc
***********************************************/

main(model, type, classname) {
  scripts\common\vehicle_build::build_template("blima", model, type, classname);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_deathmodel("veh8_mil_air_blima");
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/grenadeexp_default.vfx", "tag_engine_left", "veh9_mil_air_heli_palfa_helicopter_hit", undefined, undefined, undefined, 0.2, 1, undefined);
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/grenadeexp_default.vfx", "tail_rotor_jnt", undefined, undefined, undefined, undefined, 0.5, 1, undefined);
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/fire_smoke_trail_l.vfx", "tag_engine_left", undefined, undefined, undefined, 1, 0.5, 1, undefined);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_treadfx();
  scripts\common\vehicle_build::build_treadfx(classname, "default", "vfx/code/tread/heli_dust_default.vfx", 1);
  scripts\common\vehicle_build::build_life(3000, 2800, 3100);
  scripts\common\vehicle_build::build_team("allies");
  scripts\common\vehicle_build::build_aianims(::setanims, ::set_vehicle_anims, "blima");
  scripts\common\vehicle_build::build_attach_models(::set_attached_models);
  _id_3CAA669E71B5CD31 = randomfloatrange(0, 1);
  scripts\common\vehicle_build::build_light(classname, "cockpit_red_cargo01", "tag_light_cargo01", "vfx/misc/aircraft_light_cockpit_red", "interior", 0.0);
  scripts\common\vehicle_build::build_light(classname, "cockpit_red_cargo02", "tag_light_cargo02", "vfx/misc/aircraft_light_cockpit_red", "interior", 0.0);
  scripts\common\vehicle_build::build_light(classname, "cockpit_blue_cockpit01", "tag_light_cockpit01", "vfx/misc/aircraft_light_cockpit_blue", "interior", 0.1);
  scripts\common\vehicle_build::build_light(classname, "white_blink_belly", "tag_light_belly", "vfx/core/vehicles/aircraft_light_white_blink_lit", "running", _id_3CAA669E71B5CD31);
  scripts\common\vehicle_build::build_light(classname, "red_blink_tail", "tag_light_tail", "vfx/core/vehicles/aircraft_light_red_blink_lit", "running", _id_3CAA669E71B5CD31);
  scripts\common\vehicle_build::build_light(classname, "wingtip_green", "tag_light_L_wing", "vfx/core/vehicles/aircraft_light_wingtip_red_lit", "running", _id_3CAA669E71B5CD31);
  scripts\common\vehicle_build::build_light(classname, "wingtip_red", "tag_light_R_wing", "vfx/core/vehicles/aircraft_light_wingtip_green_lit", "running", _id_3CAA669E71B5CD31);
  scripts\common\vehicle_build::build_light(classname, "spot", "tag_passenger", "vfx/misc/aircraft_light_hindspot", "spot", 0.0);
  scripts\common\vehicle_build::build_unload_groups(::unload_groups);
  scripts\common\vehicle_build::build_bulletshield(1);
  scripts\common\vehicle_build::build_is_helicopter();
}

setup_lights(classname) {}

init_local() {
  self.unload_hover_offset = 570;
  self.unload_land_offset = 165;
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
  _id_E4B7E99A96C8829F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++)
    _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8] = spawnStruct();

  _id_E4B7E99A96C8829F[0].idle = % vh_blima_rappel_pilot;
  _id_E4B7E99A96C8829F[1].idle = % vh_blima_rappel_copilot;
  _id_E4B7E99A96C8829F[2].idle = % vh_blima_rappel_soldier0_idle;
  _id_E4B7E99A96C8829F[3].idle = % vh_blima_rappel_soldier1_idle;
  _id_E4B7E99A96C8829F[4].idle = % vh_blima_rappel_soldier2_idle;
  _id_E4B7E99A96C8829F[5].idle = % vh_blima_rappel_soldier3_idle;
  _id_E4B7E99A96C8829F[6].idle = % vh_blima_rappel_soldier4_idle;
  _id_E4B7E99A96C8829F[7].idle = % vh_blima_rappel_soldier6_idle;
  _id_E4B7E99A96C8829F[8].idle = % vh_blima_rappel_soldier8_idle;
  _id_E4B7E99A96C8829F[9].idle = % vh_blima_rappel_soldier9_idle;
  _id_E4B7E99A96C8829F[0].sittag = "tag_pilot1";
  _id_E4B7E99A96C8829F[1].sittag = "tag_pilot2";
  _id_E4B7E99A96C8829F[2].sittag = "tag_guy0";
  _id_E4B7E99A96C8829F[3].sittag = "tag_guy2";
  _id_E4B7E99A96C8829F[4].sittag = "tag_guy4";
  _id_E4B7E99A96C8829F[5].sittag = "tag_guy9";
  _id_E4B7E99A96C8829F[6].sittag = "tag_guy9";
  _id_E4B7E99A96C8829F[7].sittag = "tag_guy1";
  _id_E4B7E99A96C8829F[8].sittag = "tag_guy3";
  _id_E4B7E99A96C8829F[9].sittag = "tag_guy2";
  _id_E4B7E99A96C8829F[0].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[1].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[2].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[3].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[4].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[5].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[6].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[7].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[8].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[9].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[2].getout = % vh_blima_rappel_soldier0_drop;
  _id_E4B7E99A96C8829F[3].getout = % vh_blima_rappel_soldier1_drop;
  _id_E4B7E99A96C8829F[4].getout = % vh_blima_rappel_soldier2_drop;
  _id_E4B7E99A96C8829F[7].getout = % vh_blima_rappel_soldier6_drop;
  _id_E4B7E99A96C8829F[8].getout = % vh_blima_rappel_soldier8_drop;
  _id_E4B7E99A96C8829F[9].getout = % vh_blima_rappel_soldier9_drop;
  _id_E4B7E99A96C8829F[0].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[1].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[2].ragdoll_getout_death = 1;
  _id_E4B7E99A96C8829F[3].ragdoll_getout_death = 1;
  _id_E4B7E99A96C8829F[4].ragdoll_getout_death = 1;
  _id_E4B7E99A96C8829F[5].ragdoll_getout_death = 1;
  _id_E4B7E99A96C8829F[6].ragdoll_getout_death = 1;
  _id_E4B7E99A96C8829F[7].ragdoll_getout_death = 1;
  _id_E4B7E99A96C8829F[8].ragdoll_getout_death = 1;
  _id_E4B7E99A96C8829F[9].ragdoll_getout_death = 1;
  _id_E4B7E99A96C8829F[2].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  _id_E4B7E99A96C8829F[3].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  _id_E4B7E99A96C8829F[4].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  _id_E4B7E99A96C8829F[5].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  _id_E4B7E99A96C8829F[6].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  _id_E4B7E99A96C8829F[7].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  _id_E4B7E99A96C8829F[8].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  _id_E4B7E99A96C8829F[9].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  _id_E4B7E99A96C8829F[2].fastroperig = "TAG_FastRope_LE";
  _id_E4B7E99A96C8829F[3].fastroperig = "TAG_FastRope_LE";
  _id_E4B7E99A96C8829F[4].fastroperig = "TAG_FastRope_LE";
  _id_E4B7E99A96C8829F[5].fastroperig = "TAG_FastRope_LE";
  _id_E4B7E99A96C8829F[6].fastroperig = "TAG_FastRope_RI";
  _id_E4B7E99A96C8829F[7].fastroperig = "TAG_FastRope_RI";
  _id_E4B7E99A96C8829F[8].fastroperig = "TAG_FastRope_RI";
  _id_E4B7E99A96C8829F[9].fastroperig = "TAG_FastRope_RI";
  _id_E4B7E99A96C8829F[5].setuprope = 1;
  _id_E4B7E99A96C8829F[6].setuprope = 1;
  return _id_E4B7E99A96C8829F;
}

set_vehicle_anims(_id_E4B7E99A96C8829F) {
  if(!scripts\common\utility::issp())
    return _id_D9744C54EBC367F5(_id_E4B7E99A96C8829F);
  else
    return _id_7E79F1B51303070F(_id_E4B7E99A96C8829F);
}

#using_animtree("mp_vehicles_always_loaded");

_id_D9744C54EBC367F5(_id_E4B7E99A96C8829F) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E4B7E99A96C8829F.size; _id_AC0E594AC96AA3A8++)
    _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8].vehicle_getoutanim = % vh_blima_rappel_heli_drop;

  return _id_E4B7E99A96C8829F;
}

#using_animtree("vehicles");

_id_7E79F1B51303070F(_id_E4B7E99A96C8829F) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E4B7E99A96C8829F.size; _id_AC0E594AC96AA3A8++)
    _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8].vehicle_getoutanim = % vh_blima_rappel_heli_drop;

  return _id_E4B7E99A96C8829F;
}

unload_groups() {
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

set_attached_models() {
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

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < strings.size; _id_AC0E594AC96AA3A8++)
    precachemodel(array[strings[_id_AC0E594AC96AA3A8]].model);

  return array;
}