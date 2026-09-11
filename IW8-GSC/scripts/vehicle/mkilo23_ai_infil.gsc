/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\mkilo23_ai_infil.gsc
************************************************/

function main(var0, var1, var2) {
  scripts\common\vehicle_build::build_template("truck", var0, var1, var2);
  scripts\common\vehicle_build::build_localinit(&init_local);

  if(!isendstr(var2, "_physics")) {
    scripts\common\vehicle_build::build_deathmodel(var0, "veh8_mil_lnd_mkilo23_static_dst_drone");
  }

  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/large_vehicle_explosion.vfx", undefined, "veh_gen_armored_expl_destr");
  scripts\common\vehicle_build::build_deathquake(1, 1.6, 500);
  scripts\common\vehicle_build::build_treadfx(var2, "sand", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dust.vfx");
  scripts\common\vehicle_build::build_treadfx(var2, "dirt", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dirt.vfx");
  scripts\common\vehicle_build::build_life(1500, 1499, 1500);
  scripts\common\vehicle_build::build_team("axis");
  scripts\common\vehicle_build::build_aianims(&setanims, &set_vehicle_anims, "mkilo23_ai_infil");
  scripts\common\vehicle_build::build_unload_groups(&unload_groups);
  scripts\common\vehicle_build::build_light(var2, "headlight_truck_left", "tag_light_front_left", "vfx/misc/car_headlight_truck_L", "headlights");
  scripts\common\vehicle_build::build_light(var2, "headlight_truck_right", "tag_light_front_right", "vfx/misc/car_headlight_truck_R", "headlights");
  scripts\common\vehicle_build::build_light(var2, "taillight_truck_right", "tag_light_back_right", "vfx/misc/car_taillight_truck_R", "headlights");
  scripts\common\vehicle_build::build_light(var2, "taillight_truck_left", "tag_light_back_left", "vfx/misc/car_taillight_truck_L", "headlights");
  scripts\common\vehicle_build::build_light(var2, "brakelight_truck_right", "tag_light_back_right", "vfx/misc/car_brakelight_truck_R", "brakelights");
  scripts\common\vehicle_build::build_light(var2, "brakelight_truck_left", "tag_light_back_left", "vfx/misc/car_brakelight_truck_L", "brakelights");
}

function init_local() {
  self.script_badplace = 0;
  self.vehicleanimalias = "mkilo23_ai_infil";
}

#using_animtree("");

function setanims() {
  var0 = [];

  for(var1 = 0; var1 < 14; var1++) {
    var0 = spawnStruct();
  }

  var0[0].bhasgunwhileriding = 0;
  var0[1].bhasgunwhileriding = 0;
  var0[0].canshootinvehicle = 0;
  var0[1].canshootinvehicle = 0;
  var0[2].canshootinvehicle = 1;
  var0[3].canshootinvehicle = 1;
  var0[4].canshootinvehicle = 1;
  var0[5].canshootinvehicle = 1;
  var0[6].canshootinvehicle = 1;
  var0[7].canshootinvehicle = 1;
  var0[8].canshootinvehicle = 1;
  var0[9].canshootinvehicle = 1;
  var0[10].canshootinvehicle = 1;
  var0[11].canshootinvehicle = 1;
  var0[12].canshootinvehicle = 1;
  var0[13].canshootinvehicle = 1;
  var0[0].sittag = "TAG_DRIVER";
  var0[1].sittag = "TAG_PASSENGER";
  var0[2].sittag = "tag_detach";
  var0[3].sittag = "tag_detach";
  var0[4].sittag = "tag_detach";
  var0[5].sittag = "tag_detach";
  var0[6].sittag = "tag_detach";
  var0[7].sittag = "tag_detach";
  var0[8].sittag = "tag_detach";
  var0[9].sittag = "tag_detach";
  var0[10].sittag = "tag_detach";
  var0[11].sittag = "tag_detach";
  var0[12].sittag = "tag_detach";
  var0[13].sittag = "tag_detach";
  var0[0].getin = % reb_vh_mkilo_driver_get_in;
  var0[1].getin = $reb_vh_mkilo_pass_get_in;
  var0[0].idle_anim = "reb_vh_mkilo_driver_idle_search01";
  var0[0].idle = % reb_vh_mkilo_driver_idle_search01;
  var0[1].idle_anim = "reb_vh_mkilo_pass_idle_search01";
  var0[1].idle = % reb_vh_mkilo_pass_idle_search01;
  var0[2].idle = % sdr_mp_veh_mkilo23_01_idle;
  var0[3].idle = % sdr_mp_veh_mkilo23_02_idle;
  var0[4].idle = % sdr_mp_veh_mkilo23_03_idle;
  var0[5].idle = % sdr_mp_veh_mkilo23_04_idle;
  var0[6].idle = % sdr_mp_veh_mkilo23_05_idle;
  var0[7].idle = % sdr_mp_veh_mkilo23_06_idle;
  var0[8].idle = % sdr_mp_veh_mkilo23_07_idle;
  var0[9].idle = % sdr_mp_veh_mkilo23_08_idle;
  var0[10].idle = % sdr_mp_veh_mkilo23_09_idle;
  var0[11].idle = % sdr_mp_veh_mkilo23_10_idle;
  var0[12].idle = % sdr_mp_veh_mkilo23_11_idle;
  var0[13].idle = % sdr_mp_veh_mkilo23_12_idle;
  var0[0].getout = % reb_vh_mkilo_driver_exit_combat_idle;
  var0[1].getout = % reb_vh_mkilo_pass_exit_combat_idle;
  var0[2].getout = % sdr_mp_veh_mkilo23_01_exit;
  var0[3].getout = % sdr_mp_veh_mkilo23_02_exit;
  var0[4].getout = % sdr_mp_veh_mkilo23_03_exit;
  var0[5].getout = % sdr_mp_veh_mkilo23_04_exit;
  var0[6].getout = % sdr_mp_veh_mkilo23_05_exit;
  var0[7].getout = % sdr_mp_veh_mkilo23_06_exit;
  var0[8].getout = % sdr_mp_veh_mkilo23_07_exit;
  var0[9].getout = % sdr_mp_veh_mkilo23_08_exit;
  var0[10].getout = % sdr_mp_veh_mkilo23_09_exit;
  var0[11].getout = % sdr_mp_veh_mkilo23_10_exit;
  var0[12].getout = % sdr_mp_veh_mkilo23_11_exit;
  var0[13].getout = % sdr_mp_veh_mkilo23_12_exit;
  return var0;
}

function unload_groups() {
  var0 = [];

  for(var1 = 0; var1 < 14; var1++) {
    var0[var1] = var1;
  }

  return var0;
}

function set_vehicle_anims(var0) {
  var0[0].vehicle_getoutanim = % vh_mkilo_driver_exit_patrol;
  var0[0].vehicle_getoutanim_clear = 0;
  var0[0].vehicle_getoutanim_combat = $vh_mkilo_driver_exit_combat_idle;
  var0[0].vehicle_getoutanim_combat_clear = 0;
  var0[0].vehicle_getoutanim_combat_run = % vh_mkilo_driver_exit_combat_run;
  var0[0].vehicle_getoutanim_combat_run_clear = 0;
  var0[1].vehicle_getoutanim = % vh_mkilo_pass_exit_patrol;
  var0[1].vehicle_getoutanim_clear = 0;
  var0[1].vehicle_getoutanim_combat = % vh_mkilo_pass_exit_combat_idle;
  var0[1].vehicle_getoutanim_combat_clear = 0;
  var0[1].vehicle_getoutanim_combat_run = % vh_mkilo_pass_exit_combat_run;
  var0[1].vehicle_getoutanim_combat_run_clear = 0;
  var0[2].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var0[2].vehicle_getoutanim_clear = 0;
  var0[3].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var0[3].vehicle_getoutanim_clear = 0;
  var0[4].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var0[4].vehicle_getoutanim_clear = 0;
  var0[5].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var0[5].vehicle_getoutanim_clear = 0;
  var0[6].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var0[6].vehicle_getoutanim_clear = 0;
  var0[7].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var0[7].vehicle_getoutanim_clear = 0;
  var0[8].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var0[8].vehicle_getoutanim_clear = 0;
  var0[9].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var0[9].vehicle_getoutanim_clear = 0;
  var0[10].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var0[10].vehicle_getoutanim_clear = 0;
  var0[11].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var0[11].vehicle_getoutanim_clear = 0;
  var0[12].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var0[12].vehicle_getoutanim_clear = 0;
  var0[13].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var0[13].vehicle_getoutanim_clear = 0;
  return var0;
}