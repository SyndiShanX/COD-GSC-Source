/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\mindia8.gsc
***********************************************/

#using_animtree("vehicles");

main(model, type, classname) {
  scripts\common\vehicle_build::build_template("mindia8", model, type, classname);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_deathmodel("veh8_mil_air_mindia8_open_back_wm_x");
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/grenadeexp_default", "tag_engine_left", "veh_veh9_mil_air_heli_palfa_explode", undefined, undefined, undefined, 0.2, 1, undefined);

  if(scripts\common\utility::iscp() && isDefined(level.rocket_death_fx))
    scripts\common\vehicle_build::build_rocket_deathfx(level.rocket_death_fx, "tag_origin", "exp_helicopter_fuel", undefined, undefined, 0, 0, 1, undefined);

  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/grenadeexp_default", "tail_rotor_jnt", "veh9_mil_air_heli_palfa_helicopter_secondary_exp", undefined, undefined, undefined, 0.5, 1, undefined);
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/fire_smoke_trail_l", "tag_engine_left", "veh9_mil_air_heli_palfa_helicopter_dying_loop", undefined, 0.05, 1, 0.5, 1, undefined);
  scripts\common\vehicle_build::build_treadfx();
  scripts\common\vehicle_build::build_treadfx(classname, "default", "vfx/code/tread/heli_dust_default.vfx", 1);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_life(3000, 2800, 3100);
  scripts\common\vehicle_build::build_team("axis");
  scripts\common\vehicle_build::build_aianims(::setanims, ::set_vehicle_anims, "blima");
  scripts\common\vehicle_build::build_attach_models(::set_attached_models);
  scripts\common\vehicle_build::build_unload_groups(::unload_groups);
  scripts\common\vehicle_build::build_bulletshield(1);
  scripts\common\vehicle_build::build_is_helicopter();
  scripts\common\vehicle_build::build_drive(%mi28_rotors, undefined, 0, 3.0);
}

init_local() {
  if(scripts\common\utility::iscp())
    self.unload_hover_offset = 692;
  else
    self.unload_hover_offset = 710;

  self.script_badplace = 0;
  scripts\common\vehicle::vehicle_lights_on("running");
  thread handle_scriptable_vfx();
  self.vehicleanimalias = "mindia8";
  self.script_disconnectpaths = 0;
}

handle_scriptable_vfx() {
  self endon("death");

  if(scripts\common\utility::issp() || scripts\common\utility::iscp()) {
    scripts\engine\utility::flag_wait("scriptables_ready");
    self setscriptablepartstate("engine", "on");

    if(self getscriptablehaspart("vector_field"))
      self setscriptablepartstate("vector_field", "on");
  }
}

#using_animtree("generic_human");

setanims() {
  _id_E4B7E99A96C8829F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 14; _id_AC0E594AC96AA3A8++)
    _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8] = spawnStruct();

  _id_E4B7E99A96C8829F[0].idle = % vh_mindia8_pilot_idle;
  _id_E4B7E99A96C8829F[0].idle_anim = "vh_mindia8_pilot_idle";
  _id_E4B7E99A96C8829F[1].idle = % vh_mindia8_copilot_idle;
  _id_E4B7E99A96C8829F[1].idle_anim = "vh_mindia8_copilot_idle";
  _id_E4B7E99A96C8829F[2].idle = % vh_mindia8_rear_l_1_idle;
  _id_E4B7E99A96C8829F[3].idle = % vh_mindia8_rear_l_2_idle;
  _id_E4B7E99A96C8829F[4].idle = % vh_mindia8_rear_l_3_idle;
  _id_E4B7E99A96C8829F[5].idle = % vh_mindia8_rear_r_1_idle;
  _id_E4B7E99A96C8829F[6].idle = % vh_mindia8_rear_r_2_idle;
  _id_E4B7E99A96C8829F[7].idle = % vh_mindia8_rear_r_3_idle;
  _id_E4B7E99A96C8829F[8].idle = % vh_mindia8_front_l_1_idle;
  _id_E4B7E99A96C8829F[9].idle = % vh_mindia8_front_l_2_idle;
  _id_E4B7E99A96C8829F[10].idle = % vh_mindia8_front_l_3_idle;
  _id_E4B7E99A96C8829F[11].idle = % vh_mindia8_front_r_1_idle;
  _id_E4B7E99A96C8829F[12].idle = % vh_mindia8_front_r_2_idle;
  _id_E4B7E99A96C8829F[13].idle = % vh_mindia8_front_r_3_idle;
  _id_E4B7E99A96C8829F[0].sittag = "body_animate_jnt";
  _id_E4B7E99A96C8829F[1].sittag = "body_animate_jnt";
  _id_E4B7E99A96C8829F[2].sittag = "body_animate_jnt";
  _id_E4B7E99A96C8829F[3].sittag = "body_animate_jnt";
  _id_E4B7E99A96C8829F[4].sittag = "body_animate_jnt";
  _id_E4B7E99A96C8829F[5].sittag = "body_animate_jnt";
  _id_E4B7E99A96C8829F[6].sittag = "body_animate_jnt";
  _id_E4B7E99A96C8829F[7].sittag = "body_animate_jnt";
  _id_E4B7E99A96C8829F[8].sittag = "body_animate_jnt";
  _id_E4B7E99A96C8829F[9].sittag = "body_animate_jnt";
  _id_E4B7E99A96C8829F[10].sittag = "body_animate_jnt";
  _id_E4B7E99A96C8829F[11].sittag = "body_animate_jnt";
  _id_E4B7E99A96C8829F[12].sittag = "body_animate_jnt";
  _id_E4B7E99A96C8829F[13].sittag = "body_animate_jnt";
  _id_E4B7E99A96C8829F[0].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[1].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[2].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[3].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[4].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[5].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[6].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[7].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[8].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[9].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[10].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[11].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[12].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[13].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[2].getout = % vh_mindia8_rear_l_1_exit;
  _id_E4B7E99A96C8829F[3].getout = % vh_mindia8_rear_l_2_exit;
  _id_E4B7E99A96C8829F[4].getout = % vh_mindia8_rear_l_3_exit;
  _id_E4B7E99A96C8829F[5].getout = % vh_mindia8_rear_r_1_exit;
  _id_E4B7E99A96C8829F[6].getout = % vh_mindia8_rear_r_2_exit;
  _id_E4B7E99A96C8829F[7].getout = % vh_mindia8_rear_r_3_exit;
  _id_E4B7E99A96C8829F[8].getout = % vh_mindia8_front_l_1_exit;
  _id_E4B7E99A96C8829F[9].getout = % vh_mindia8_front_l_2_exit;
  _id_E4B7E99A96C8829F[10].getout = % vh_mindia8_front_l_3_exit;
  _id_E4B7E99A96C8829F[11].getout = % vh_mindia8_front_r_1_exit;
  _id_E4B7E99A96C8829F[12].getout = % vh_mindia8_front_r_2_exit;
  _id_E4B7E99A96C8829F[13].getout = % vh_mindia8_front_r_3_exit;
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
  _id_E4B7E99A96C8829F[2].fastroperig = "TAG_FastRope_front_LE";
  _id_E4B7E99A96C8829F[3].fastroperig = "TAG_FastRope_front_LE";
  _id_E4B7E99A96C8829F[4].fastroperig = "TAG_FastRope_front_LE";
  _id_E4B7E99A96C8829F[5].fastroperig = "TAG_FastRope_front_RI";
  _id_E4B7E99A96C8829F[6].fastroperig = "TAG_FastRope_front_RI";
  _id_E4B7E99A96C8829F[7].fastroperig = "TAG_FastRope_front_RI";
  _id_E4B7E99A96C8829F[8].fastroperig = "TAG_FastRope_back_LE";
  _id_E4B7E99A96C8829F[9].fastroperig = "TAG_FastRope_back_LE";
  _id_E4B7E99A96C8829F[10].fastroperig = "TAG_FastRope_back_LE";
  _id_E4B7E99A96C8829F[11].fastroperig = "TAG_FastRope_back_RI";
  _id_E4B7E99A96C8829F[12].fastroperig = "TAG_FastRope_back_RI";
  _id_E4B7E99A96C8829F[13].fastroperig = "TAG_FastRope_back_RI";
  return _id_E4B7E99A96C8829F;
}

set_vehicle_anims(_id_E4B7E99A96C8829F) {
  if(!scripts\common\utility::issp()) {
    if(isDefined(level._id_B7229E2DCB171037) && isDefined(level._id_B7229E2DCB171037["mindia8"]))
      return [[level._id_B7229E2DCB171037["mindia8"]]](_id_E4B7E99A96C8829F);
  }

  return _id_7E79F1B51303070F(_id_E4B7E99A96C8829F);
}

#using_animtree("vehicles");

_id_7E79F1B51303070F(_id_E4B7E99A96C8829F) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E4B7E99A96C8829F.size; _id_AC0E594AC96AA3A8++)
    _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8].vehicle_getoutanim = % vh_blima_rappel_heli_drop;

  return _id_E4B7E99A96C8829F;
}

unload_groups() {
  unload_groups = [];
  unload_groups["rear_left"] = [2, 3, 4];
  unload_groups["rear_right"] = [5, 6, 7];
  unload_groups["front_left"] = [8, 9, 10];
  unload_groups["front_right"] = [11, 12, 13];
  unload_groups["all"] = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14];
  unload_groups["default"] = unload_groups["all"];
  return unload_groups;
}

#using_animtree("script_model");

set_attached_models() {
  array = [];
  array["TAG_FastRope_front_LE"] = spawnStruct();
  array["TAG_FastRope_front_LE"].model = "equipment_fast_rope_sim";
  array["TAG_FastRope_front_LE"].tag = "TAG_FastRope_front_LE";
  array["TAG_FastRope_front_LE"].idleanim = % vh_mindia8_front_l_rope_exit;
  array["TAG_FastRope_front_LE"].dropanim = % vh_mindia8_front_l_rope_fall;
  array["TAG_FastRope_front_LE"].dropusestraceorigin = 1;
  array["TAG_FastRope_back_LE"] = spawnStruct();
  array["TAG_FastRope_back_LE"].model = "equipment_fast_rope_sim";
  array["TAG_FastRope_back_LE"].tag = "TAG_FastRope_back_LE";
  array["TAG_FastRope_back_LE"].idleanim = % vh_mindia8_rear_l_rope_exit;
  array["TAG_FastRope_back_LE"].dropanim = % vh_mindia8_rear_l_rope_fall;
  array["TAG_FastRope_back_LE"].dropusestraceorigin = 1;
  array["TAG_FastRope_front_RI"] = spawnStruct();
  array["TAG_FastRope_front_RI"].model = "equipment_fast_rope_sim";
  array["TAG_FastRope_front_RI"].tag = "TAG_FastRope_front_RI";
  array["TAG_FastRope_front_RI"].idleanim = % vh_mindia8_front_r_rope_exit;
  array["TAG_FastRope_front_RI"].dropanim = % vh_mindia8_front_r_rope_fall;
  array["TAG_FastRope_front_RI"].dropusestraceorigin = 1;
  array["TAG_FastRope_back_RI"] = spawnStruct();
  array["TAG_FastRope_back_RI"].model = "equipment_fast_rope_sim";
  array["TAG_FastRope_back_RI"].tag = "TAG_FastRope_back_RI";
  array["TAG_FastRope_back_RI"].idleanim = % vh_mindia8_rear_r_rope_exit;
  array["TAG_FastRope_back_RI"].dropanim = % vh_mindia8_rear_r_rope_fall;
  array["TAG_FastRope_back_RI"].dropusestraceorigin = 1;
  strings = getarraykeys(array);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < strings.size; _id_AC0E594AC96AA3A8++)
    precachemodel(array[strings[_id_AC0E594AC96AA3A8]].model);

  return array;
}