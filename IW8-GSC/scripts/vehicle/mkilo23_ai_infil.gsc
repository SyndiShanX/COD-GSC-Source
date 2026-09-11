/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\mkilo23_ai_infil.gsc
************************************************/

function main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("truck", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(&init_local);

  if(!isendstr(var_2, "_physics")) {
    scripts\common\vehicle_build::build_deathmodel(var_0, "veh8_mil_lnd_mkilo23_static_dst_drone");
  }

  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/large_vehicle_explosion.vfx", undefined, "veh_gen_armored_expl_destr");
  scripts\common\vehicle_build::build_deathquake(1, 1.6, 500);
  scripts\common\vehicle_build::build_treadfx(var_2, "sand", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dust.vfx");
  scripts\common\vehicle_build::build_treadfx(var_2, "dirt", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dirt.vfx");
  scripts\common\vehicle_build::build_life(1500, 1499, 1500);
  scripts\common\vehicle_build::build_team("axis");
  scripts\common\vehicle_build::build_aianims(&setanims, &set_vehicle_anims, "mkilo23_ai_infil");
  scripts\common\vehicle_build::build_unload_groups(&unload_groups);
  scripts\common\vehicle_build::build_light(var_2, "headlight_truck_left", "tag_light_front_left", "vfx/misc/car_headlight_truck_L", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "headlight_truck_right", "tag_light_front_right", "vfx/misc/car_headlight_truck_R", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "taillight_truck_right", "tag_light_back_right", "vfx/misc/car_taillight_truck_R", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "taillight_truck_left", "tag_light_back_left", "vfx/misc/car_taillight_truck_L", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "brakelight_truck_right", "tag_light_back_right", "vfx/misc/car_brakelight_truck_R", "brakelights");
  scripts\common\vehicle_build::build_light(var_2, "brakelight_truck_left", "tag_light_back_left", "vfx/misc/car_brakelight_truck_L", "brakelights");
}

function init_local() {
  self.script_badplace = 0;
  self.vehicleanimalias = "mkilo23_ai_infil";
}

#using_animtree("");

function setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 14; var_1++) {
    var_0 = spawnStruct();
  }

  var_0[0].bhasgunwhileriding = 0;
  var_0[1].bhasgunwhileriding = 0;
  var_0[0].canshootinvehicle = 0;
  var_0[1].canshootinvehicle = 0;
  var_0[2].canshootinvehicle = 1;
  var_0[3].canshootinvehicle = 1;
  var_0[4].canshootinvehicle = 1;
  var_0[5].canshootinvehicle = 1;
  var_0[6].canshootinvehicle = 1;
  var_0[7].canshootinvehicle = 1;
  var_0[8].canshootinvehicle = 1;
  var_0[9].canshootinvehicle = 1;
  var_0[10].canshootinvehicle = 1;
  var_0[11].canshootinvehicle = 1;
  var_0[12].canshootinvehicle = 1;
  var_0[13].canshootinvehicle = 1;
  var_0[0].sittag = "TAG_DRIVER";
  var_0[1].sittag = "TAG_PASSENGER";
  var_0[2].sittag = "tag_detach";
  var_0[3].sittag = "tag_detach";
  var_0[4].sittag = "tag_detach";
  var_0[5].sittag = "tag_detach";
  var_0[6].sittag = "tag_detach";
  var_0[7].sittag = "tag_detach";
  var_0[8].sittag = "tag_detach";
  var_0[9].sittag = "tag_detach";
  var_0[10].sittag = "tag_detach";
  var_0[11].sittag = "tag_detach";
  var_0[12].sittag = "tag_detach";
  var_0[13].sittag = "tag_detach";
  var_0[0].getin = % reb_vh_mkilo_driver_get_in;
  var_0[1].getin = $reb_vh_mkilo_pass_get_in;
  var_0[0].idle_anim = "reb_vh_mkilo_driver_idle_search01";
  var_0[0].idle = % reb_vh_mkilo_driver_idle_search01;
  var_0[1].idle_anim = "reb_vh_mkilo_pass_idle_search01";
  var_0[1].idle = % reb_vh_mkilo_pass_idle_search01;
  var_0[2].idle = % sdr_mp_veh_mkilo23_01_idle;
  var_0[3].idle = % sdr_mp_veh_mkilo23_02_idle;
  var_0[4].idle = % sdr_mp_veh_mkilo23_03_idle;
  var_0[5].idle = % sdr_mp_veh_mkilo23_04_idle;
  var_0[6].idle = % sdr_mp_veh_mkilo23_05_idle;
  var_0[7].idle = % sdr_mp_veh_mkilo23_06_idle;
  var_0[8].idle = % sdr_mp_veh_mkilo23_07_idle;
  var_0[9].idle = % sdr_mp_veh_mkilo23_08_idle;
  var_0[10].idle = % sdr_mp_veh_mkilo23_09_idle;
  var_0[11].idle = % sdr_mp_veh_mkilo23_10_idle;
  var_0[12].idle = % sdr_mp_veh_mkilo23_11_idle;
  var_0[13].idle = % sdr_mp_veh_mkilo23_12_idle;
  var_0[0].getout = % reb_vh_mkilo_driver_exit_combat_idle;
  var_0[1].getout = % reb_vh_mkilo_pass_exit_combat_idle;
  var_0[2].getout = % sdr_mp_veh_mkilo23_01_exit;
  var_0[3].getout = % sdr_mp_veh_mkilo23_02_exit;
  var_0[4].getout = % sdr_mp_veh_mkilo23_03_exit;
  var_0[5].getout = % sdr_mp_veh_mkilo23_04_exit;
  var_0[6].getout = % sdr_mp_veh_mkilo23_05_exit;
  var_0[7].getout = % sdr_mp_veh_mkilo23_06_exit;
  var_0[8].getout = % sdr_mp_veh_mkilo23_07_exit;
  var_0[9].getout = % sdr_mp_veh_mkilo23_08_exit;
  var_0[10].getout = % sdr_mp_veh_mkilo23_09_exit;
  var_0[11].getout = % sdr_mp_veh_mkilo23_10_exit;
  var_0[12].getout = % sdr_mp_veh_mkilo23_11_exit;
  var_0[13].getout = % sdr_mp_veh_mkilo23_12_exit;
  return var_0;
}

function unload_groups() {
  var_0 = [];

  for(var_1 = 0; var_1 < 14; var_1++) {
    var_0[var_1] = var_1;
  }

  return var_0;
}

function set_vehicle_anims(var_0) {
  var_0[0].vehicle_getoutanim = % vh_mkilo_driver_exit_patrol;
  var_0[0].vehicle_getoutanim_clear = 0;
  var_0[0].vehicle_getoutanim_combat = $vh_mkilo_driver_exit_combat_idle;
  var_0[0].vehicle_getoutanim_combat_clear = 0;
  var_0[0].vehicle_getoutanim_combat_run = % vh_mkilo_driver_exit_combat_run;
  var_0[0].vehicle_getoutanim_combat_run_clear = 0;
  var_0[1].vehicle_getoutanim = % vh_mkilo_pass_exit_patrol;
  var_0[1].vehicle_getoutanim_clear = 0;
  var_0[1].vehicle_getoutanim_combat = % vh_mkilo_pass_exit_combat_idle;
  var_0[1].vehicle_getoutanim_combat_clear = 0;
  var_0[1].vehicle_getoutanim_combat_run = % vh_mkilo_pass_exit_combat_run;
  var_0[1].vehicle_getoutanim_combat_run_clear = 0;
  var_0[2].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var_0[2].vehicle_getoutanim_clear = 0;
  var_0[3].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var_0[3].vehicle_getoutanim_clear = 0;
  var_0[4].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var_0[4].vehicle_getoutanim_clear = 0;
  var_0[5].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var_0[5].vehicle_getoutanim_clear = 0;
  var_0[6].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var_0[6].vehicle_getoutanim_clear = 0;
  var_0[7].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var_0[7].vehicle_getoutanim_clear = 0;
  var_0[8].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var_0[8].vehicle_getoutanim_clear = 0;
  var_0[9].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var_0[9].vehicle_getoutanim_clear = 0;
  var_0[10].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var_0[10].vehicle_getoutanim_clear = 0;
  var_0[11].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var_0[11].vehicle_getoutanim_clear = 0;
  var_0[12].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var_0[12].vehicle_getoutanim_clear = 0;
  var_0[13].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var_0[13].vehicle_getoutanim_clear = 0;
  return var_0;
}