/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\mindia8.gsc
***********************************************/

#using_animtree("vehicles");

function main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("mindia8", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(&init_local);
  scripts\common\vehicle_build::build_deathmodel("veh8_mil_air_mindia8_open_back");
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/grenadeexp_default", "tag_engine_left", "hind_helicopter_hit", undefined, undefined, undefined, 0.2, 1, undefined);
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/grenadeexp_default", "tail_rotor_jnt", "hind_helicopter_secondary_exp", undefined, undefined, undefined, 0.5, 1, undefined);
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/fire_smoke_trail_l", "tag_engine_left", "hind_helicopter_dying_loop", undefined, 0.05, 1, 0.5, 1, undefined);
  scripts\common\vehicle_build::build_treadfx();
  scripts\common\vehicle_build::build_treadfx(var_2, "default", "vfx/code/tread/heli_dust_default.vfx", 1);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_life(3000, 2800, 3100);
  scripts\common\vehicle_build::build_team("axis");
  scripts\common\vehicle_build::build_aianims(&setanims, &set_vehicle_anims, "blima");
  scripts\common\vehicle_build::build_attach_models(&set_attached_models);
  scripts\common\vehicle_build::build_unload_groups(&unload_groups);
  scripts\common\vehicle_build::build_bulletshield(1);
  scripts\common\vehicle_build::build_is_helicopter();
  scripts\common\vehicle_build::build_drive(%mi28_rotors, undefined, 0, 3);
}

function init_local() {
  if(scripts\common\utility::iscp()) {
    self.unload_hover_offset = 630;
  } else {
    self.unload_hover_offset = 710;
  }

  self.script_badplace = 0;
  scripts\common\vehicle::vehicle_lights_on("running");
  thread handle_scriptable_vfx();
  self.vehicleanimalias = "mindia8";
  self.script_disconnectpaths = 0;
}

function handle_scriptable_vfx() {
  self endon("death");

  if(scripts\common\utility::issp() || scripts\common\utility::iscp()) {
    scripts\engine\utility::flag_wait("scriptables_ready");
    self setscriptablepartstate("engine", "on");
    self setscriptablepartstate("vector_field", "on");
    return;
  }
}

#using_animtree("");

function setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 14; var_1++) {
    var_0 = spawnStruct();
  }

  var_0[0].idle = % vh_mindia8_pilot_idle;
  var_0[0].idle_anim = "vh_mindia8_pilot_idle";
  var_0[1].idle = $vh_mindia8_copilot_idle;
  var_0[1].idle_anim = "vh_mindia8_copilot_idle";
  var_0[2].idle = % vh_mindia8_rear_l_1_idle;
  var_0[3].idle = % vh_mindia8_rear_l_2_idle;
  var_0[4].idle = % vh_mindia8_rear_l_3_idle;
  var_0[5].idle = % vh_mindia8_rear_r_1_idle;
  var_0[6].idle = % vh_mindia8_rear_r_2_idle;
  var_0[7].idle = % vh_mindia8_rear_r_3_idle;
  var_0[8].idle = % vh_mindia8_front_l_1_idle;
  var_0[9].idle = % vh_mindia8_front_l_2_idle;
  var_0[10].idle = % vh_mindia8_front_l_3_idle;
  var_0[11].idle = % vh_mindia8_front_r_1_idle;
  var_0[12].idle = % vh_mindia8_front_r_2_idle;
  var_0[13].idle = % vh_mindia8_front_r_3_idle;
  var_0[0].sittag = "body_animate_jnt";
  var_0[1].sittag = "body_animate_jnt";
  var_0[2].sittag = "body_animate_jnt";
  var_0[3].sittag = "body_animate_jnt";
  var_0[4].sittag = "body_animate_jnt";
  var_0[5].sittag = "body_animate_jnt";
  var_0[6].sittag = "body_animate_jnt";
  var_0[7].sittag = "body_animate_jnt";
  var_0[8].sittag = "body_animate_jnt";
  var_0[9].sittag = "body_animate_jnt";
  var_0[10].sittag = "body_animate_jnt";
  var_0[11].sittag = "body_animate_jnt";
  var_0[12].sittag = "body_animate_jnt";
  var_0[13].sittag = "body_animate_jnt";
  var_0[2].getout = % vh_mindia8_rear_l_1_exit;
  var_0[3].getout = % vh_mindia8_rear_l_2_exit;
  var_0[4].getout = % vh_mindia8_rear_l_3_exit;
  var_0[5].getout = % vh_mindia8_rear_r_1_exit;
  var_0[6].getout = % vh_mindia8_rear_r_2_exit;
  var_0[7].getout = % vh_mindia8_rear_r_3_exit;
  var_0[8].getout = % vh_mindia8_front_l_1_exit;
  var_0[9].getout = % vh_mindia8_front_l_2_exit;
  var_0[10].getout = % vh_mindia8_front_l_3_exit;
  var_0[11].getout = % vh_mindia8_front_r_1_exit;
  var_0[12].getout = % vh_mindia8_front_r_2_exit;
  var_0[13].getout = % vh_mindia8_front_r_3_exit;
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
  var_0[2].fastroperig = "TAG_FastRope_front_LE";
  var_0[3].fastroperig = "TAG_FastRope_front_LE";
  var_0[4].fastroperig = "TAG_FastRope_front_LE";
  var_0[5].fastroperig = "TAG_FastRope_front_RI";
  var_0[6].fastroperig = "TAG_FastRope_front_RI";
  var_0[7].fastroperig = "TAG_FastRope_front_RI";
  var_0[8].fastroperig = "TAG_FastRope_back_LE";
  var_0[9].fastroperig = "TAG_FastRope_back_LE";
  var_0[10].fastroperig = "TAG_FastRope_back_LE";
  var_0[11].fastroperig = "TAG_FastRope_back_RI";
  var_0[12].fastroperig = "TAG_FastRope_back_RI";
  var_0[13].fastroperig = "TAG_FastRope_back_RI";
  return var_0;
}

#using_animtree("vehicles");

function set_vehicle_anims(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1].vehicle_getoutanim = % vh_blima_rappel_heli_drop;
  }

  return var_0;
}

function unload_groups() {
  var_0 = [];
  GscBinSkip0(0x2e, "rear_left", [2, 3, 4]);
}

function set_attached_models() {
  var_0 = [];
  GscBinSkip0(0x2e, "TAG_FastRope_front_LE", spawnStruct());
}