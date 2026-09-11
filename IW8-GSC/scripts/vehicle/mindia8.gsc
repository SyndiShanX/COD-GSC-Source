/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\mindia8.gsc
***********************************************/

#using_animtree("vehicles");

function main(var0, var1, var2) {
  scripts\common\vehicle_build::build_template("mindia8", var0, var1, var2);
  scripts\common\vehicle_build::build_localinit(&init_local);
  scripts\common\vehicle_build::build_deathmodel("veh8_mil_air_mindia8_open_back");
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/grenadeexp_default", "tag_engine_left", "hind_helicopter_hit", undefined, undefined, undefined, 0.2, 1, undefined);
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/grenadeexp_default", "tail_rotor_jnt", "hind_helicopter_secondary_exp", undefined, undefined, undefined, 0.5, 1, undefined);
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/fire_smoke_trail_l", "tag_engine_left", "hind_helicopter_dying_loop", undefined, 0.05, 1, 0.5, 1, undefined);
  scripts\common\vehicle_build::build_treadfx();
  scripts\common\vehicle_build::build_treadfx(var2, "default", "vfx/code/tread/heli_dust_default.vfx", 1);
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
  var0 = [];

  for(var1 = 0; var1 < 14; var1++) {
    var0 = spawnStruct();
  }

  var0[0].idle = % vh_mindia8_pilot_idle;
  var0[0].idle_anim = "vh_mindia8_pilot_idle";
  var0[1].idle = $vh_mindia8_copilot_idle;
  var0[1].idle_anim = "vh_mindia8_copilot_idle";
  var0[2].idle = % vh_mindia8_rear_l_1_idle;
  var0[3].idle = % vh_mindia8_rear_l_2_idle;
  var0[4].idle = % vh_mindia8_rear_l_3_idle;
  var0[5].idle = % vh_mindia8_rear_r_1_idle;
  var0[6].idle = % vh_mindia8_rear_r_2_idle;
  var0[7].idle = % vh_mindia8_rear_r_3_idle;
  var0[8].idle = % vh_mindia8_front_l_1_idle;
  var0[9].idle = % vh_mindia8_front_l_2_idle;
  var0[10].idle = % vh_mindia8_front_l_3_idle;
  var0[11].idle = % vh_mindia8_front_r_1_idle;
  var0[12].idle = % vh_mindia8_front_r_2_idle;
  var0[13].idle = % vh_mindia8_front_r_3_idle;
  var0[0].sittag = "body_animate_jnt";
  var0[1].sittag = "body_animate_jnt";
  var0[2].sittag = "body_animate_jnt";
  var0[3].sittag = "body_animate_jnt";
  var0[4].sittag = "body_animate_jnt";
  var0[5].sittag = "body_animate_jnt";
  var0[6].sittag = "body_animate_jnt";
  var0[7].sittag = "body_animate_jnt";
  var0[8].sittag = "body_animate_jnt";
  var0[9].sittag = "body_animate_jnt";
  var0[10].sittag = "body_animate_jnt";
  var0[11].sittag = "body_animate_jnt";
  var0[12].sittag = "body_animate_jnt";
  var0[13].sittag = "body_animate_jnt";
  var0[2].getout = % vh_mindia8_rear_l_1_exit;
  var0[3].getout = % vh_mindia8_rear_l_2_exit;
  var0[4].getout = % vh_mindia8_rear_l_3_exit;
  var0[5].getout = % vh_mindia8_rear_r_1_exit;
  var0[6].getout = % vh_mindia8_rear_r_2_exit;
  var0[7].getout = % vh_mindia8_rear_r_3_exit;
  var0[8].getout = % vh_mindia8_front_l_1_exit;
  var0[9].getout = % vh_mindia8_front_l_2_exit;
  var0[10].getout = % vh_mindia8_front_l_3_exit;
  var0[11].getout = % vh_mindia8_front_r_1_exit;
  var0[12].getout = % vh_mindia8_front_r_2_exit;
  var0[13].getout = % vh_mindia8_front_r_3_exit;
  var0[0].death_no_ragdoll = 1;
  var0[1].death_no_ragdoll = 1;
  var0[2].ragdoll_getout_death = 1;
  var0[3].ragdoll_getout_death = 1;
  var0[4].ragdoll_getout_death = 1;
  var0[5].ragdoll_getout_death = 1;
  var0[6].ragdoll_getout_death = 1;
  var0[7].ragdoll_getout_death = 1;
  var0[8].ragdoll_getout_death = 1;
  var0[9].ragdoll_getout_death = 1;
  var0[2].fastroperig = "TAG_FastRope_front_LE";
  var0[3].fastroperig = "TAG_FastRope_front_LE";
  var0[4].fastroperig = "TAG_FastRope_front_LE";
  var0[5].fastroperig = "TAG_FastRope_front_RI";
  var0[6].fastroperig = "TAG_FastRope_front_RI";
  var0[7].fastroperig = "TAG_FastRope_front_RI";
  var0[8].fastroperig = "TAG_FastRope_back_LE";
  var0[9].fastroperig = "TAG_FastRope_back_LE";
  var0[10].fastroperig = "TAG_FastRope_back_LE";
  var0[11].fastroperig = "TAG_FastRope_back_RI";
  var0[12].fastroperig = "TAG_FastRope_back_RI";
  var0[13].fastroperig = "TAG_FastRope_back_RI";
  return var0;
}

#using_animtree("vehicles");

function set_vehicle_anims(var0) {
  for(var1 = 0; var1 < var0.size; var1++) {
    var0[var1].vehicle_getoutanim = % vh_blima_rappel_heli_drop;
  }

  return var0;
}

function unload_groups() {
  var0 = [];
  GscBinSkip0(0x2e, "rear_left", [2, 3, 4]);
}

function set_attached_models() {
  var0 = [];
  GscBinSkip0(0x2e, "TAG_FastRope_front_LE", spawnStruct());
}