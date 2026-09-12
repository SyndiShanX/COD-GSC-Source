/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\mindia8_jugg.gsc
***********************************************/

#using_animtree("vehicles");

function main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("mindia8", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(&init_local);
  scripts\common\vehicle_build::build_deathmodel("veh8_mil_air_mindia8_open_back_wm_x");
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/grenadeexp_default", "tag_engine_left", "hind_helicopter_hit", undefined, undefined, undefined, 0.2, 1, undefined);

  if(scripts\common\utility::iscp() && isDefined(level.ref_12D73)) {
    scripts\common\vehicle_build::build_rocket_deathfx(level.ref_12D73, "tag_origin", "exp_helicopter_fuel", undefined, undefined, 0, 0, 1, undefined);
  }

  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/grenadeexp_default", "tail_rotor_jnt", "hind_helicopter_secondary_exp", undefined, undefined, undefined, 0.5, 1, undefined);
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/fire_smoke_trail_l", "tail_rotor_jnt", "hind_helicopter_dying_loop", 1, 0.05, 1, 0.5, 1, undefined);
  scripts\common\vehicle_build::build_treadfx();
  scripts\common\vehicle_build::build_treadfx(var_2, "default", "vfx/code/tread/heli_dust_default.vfx", 1);
  scripts\common\vehicle_build::build_life(3000, 2800, 3100);
  scripts\common\vehicle_build::build_team("axis");
  scripts\common\vehicle_build::build_aianims(&setanims, &set_vehicle_anims, "blima");
  var_3 = randomfloatrange(0, 1);
  scripts\common\vehicle_build::build_unload_groups(&unload_groups);
  scripts\common\vehicle_build::build_bulletshield(1);
  scripts\common\vehicle_build::build_is_helicopter();
  scripts\common\vehicle_build::build_drive(%mi28_rotors, undefined, 0, 3);
}

function init_local() {
  self.vehicleanimalias = "mindia8_jugg";
  self.unload_hover_offset = 170;
  self.skipdeathanim = 1;
  self.script_badplace = 1;
  scripts\common\vehicle::vehicle_lights_on("running");
}

#using_animtree("");

function setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 15; var_1++) {
    var_0 = spawnStruct();
  }

  var_0[0].idle = % vh_mindia8_pilot_idle;
  var_0[0].idle_anim = "vh_mindia8_pilot_idle";
  var_0[1].idle = $vh_mindia8_copilot_idle;
  var_0[1].idle_anim = "vh_mindia8_copilot_idle";
  var_0[2].idle = % sdr_mp_veh_mindia8_ground_fr1_idle;
  var_0[3].idle = % sdr_mp_veh_mindia8_ground_fr2_idle;
  var_0[4].idle = % sdr_mp_veh_mindia8_ground_fr3_idle;
  var_0[5].idle = % sdr_mp_veh_mindia8_ground_rr1_idle;
  var_0[6].idle = % sdr_mp_veh_mindia8_ground_rr2_idle;
  var_0[7].idle = % sdr_mp_veh_mindia8_ground_rr3_idle;
  var_0[8].idle = % sdr_mp_veh_mindia8_ground_fl1_idle;
  var_0[9].idle = % sdr_mp_veh_mindia8_ground_fl2_idle;
  var_0[10].idle = % sdr_mp_veh_mindia8_ground_fl3_idle;
  var_0[11].idle = % sdr_mp_veh_mindia8_ground_rl1_idle;
  var_0[12].idle = % sdr_mp_veh_mindia8_ground_rl2_idle;
  var_0[13].idle = % sdr_mp_veh_mindia8_ground_rl3_idle;
  var_0[14].idle = % sdr_cp_veh_mindia8_ground_jug_idle;
  var_0[0].sittag = "body_animate_jnt";
  var_0[1].sittag = "body_animate_jnt";
  var_0[2].sittag = "tag_guy1";
  var_0[3].sittag = "tag_guy2";
  var_0[4].sittag = "tag_guy3";
  var_0[5].sittag = "tag_guy4";
  var_0[6].sittag = "tag_guy5";
  var_0[7].sittag = "tag_guy6";
  var_0[8].sittag = "tag_guy7";
  var_0[9].sittag = "tag_guy8";
  var_0[10].sittag = "tag_guy9";
  var_0[11].sittag = "tag_guy10";
  var_0[12].sittag = "tag_guy11";
  var_0[13].sittag = "tag_guy12";
  var_0[14].sittag = "body_animate_jnt";
  var_0[2].getout = % sdr_mp_veh_mindia8_ground_fr1_exit;
  var_0[3].getout = % sdr_mp_veh_mindia8_ground_fr2_exit;
  var_0[4].getout = % sdr_mp_veh_mindia8_ground_fr3_exit;
  var_0[5].getout = % sdr_mp_veh_mindia8_ground_rr1_exit;
  var_0[6].getout = % sdr_mp_veh_mindia8_ground_rr2_exit;
  var_0[7].getout = % sdr_mp_veh_mindia8_ground_rr3_exit;
  var_0[8].getout = % sdr_mp_veh_mindia8_ground_fl1_exit;
  var_0[9].getout = % sdr_mp_veh_mindia8_ground_fl2_exit;
  var_0[10].getout = % sdr_mp_veh_mindia8_ground_fl3_exit;
  var_0[11].getout = % sdr_mp_veh_mindia8_ground_rl1_exit;
  var_0[12].getout = % sdr_mp_veh_mindia8_ground_rl2_exit;
  var_0[13].getout = % sdr_mp_veh_mindia8_ground_rl3_exit;
  var_0[14].getout = % sdr_mp_veh_mindia8_ground_jug_exit;
  var_0[2].getoutstance = "crouch";
  var_0[3].getoutstance = "crouch";
  var_0[4].getoutstance = "crouch";
  var_0[5].getoutstance = "crouch";
  var_0[6].getoutstance = "crouch";
  var_0[7].getoutstance = "crouch";
  var_0[8].getoutstance = "crouch";
  var_0[9].getoutstance = "crouch";
  var_0[10].getoutstance = "crouch";
  var_0[11].getoutstance = "crouch";
  var_0[12].getoutstance = "crouch";
  var_0[13].getoutstance = "crouch";
  var_0[14].getoutstance = "stand";
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
  GscBinSkip0(0x2e, "rear_left", [3, 4, 5]);
}