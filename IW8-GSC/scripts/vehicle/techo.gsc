/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\techo.gsc
***********************************************/

#using_animtree("");

function main(var0, var1, var2) {
  scripts\common\vehicle_build::build_template("truck", var0, var1, var2);
  scripts\common\vehicle_build::build_localinit(&init_local);
  var3 = "veh8_civ_lnd_techo_static_dst";

  if(issubstr(var0, "black")) {
    var3 += "_black";
  } else if(issubstr(var0, "blue")) {
    var3 += "_blue";
  } else if(issubstr(var0, "grey")) {
    var3 += "_grey";
  } else if(issubstr(var0, "red")) {
    var3 += "_red";
  } else if(issubstr(var0, "tan")) {
    var3 += "_tan";
  } else if(issubstr(var0, "rebel")) {
    var3 = "veh8_civ_lnd_techo_rebel_static_dst";
  }

  if(isendstr(var0, "_physics")) {
    var3 += "_physics";
  }

  scripts\common\vehicle_build::build_deathmodel(var0, var3);
  scripts\common\vehicle_build::build_deathfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_civ.vfx", undefined, "car_explode");
  scripts\common\vehicle_build::build_deathquake(1, 1.6, 500);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_deathanimations(%veh8_common_pickup_expl_lf, %veh8_common_pickup_expl_rf, $veh8_common_pickup_expl_lb, %veh8_common_pickup_expl_rb);
  scripts\common\vehicle_build::build_drive(%veh8_common_pickup_driving_idle_forward, %veh8_common_pickup_driving_idle_backward, 10);
  scripts\common\vehicle_build::build_treadfx(var2, "sand", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dust.vfx");
  scripts\common\vehicle_build::build_treadfx(var2, "dirt", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dirt.vfx");
  scripts\common\vehicle_build::build_treadfx(var2, "mud", "vfx/iw8/level/highway/vfx_vehicle_treadfx_mud.vfx");
  scripts\common\vehicle_build::build_life(2000);
  scripts\common\vehicle_build::build_team("axis");
  scripts\common\vehicle_build::build_aianims(&setanims, &set_vehicle_anims, "techo");
  scripts\common\vehicle_build::build_unload_groups(&unload_groups);
  scripts\common\vehicle_build::build_light(var2, "headlight_truck_left", "tag_light_front_left", "vfx/iw8/veh/system/vfx_veh_sys_headlight_techo_left", "headlights");
  scripts\common\vehicle_build::build_light(var2, "headlight_truck_right", "tag_light_front_right", "vfx/iw8/veh/system/vfx_veh_sys_headlight_techo_right", "headlights");
  scripts\common\vehicle_build::build_light(var2, "taillight_truck_right", "tag_light_back_right", "vfx/iw8/veh/system/vfx_veh_sys_taillight_techo_right", "brakelights");
  scripts\common\vehicle_build::build_light(var2, "taillight_truck_left", "tag_light_back_left", "vfx/iw8/veh/system/vfx_veh_sys_taillight_techo_left", "brakelights");
  scripts\common\vehicle_build::build_light(var2, "brakelight_truck_right", "tag_light_back_right", "vfx/misc/car_brakelight_truck_R", "brakelights");
  scripts\common\vehicle_build::build_light(var2, "brakelight_truck_left", "tag_light_back_left", "vfx/misc/car_brakelight_truck_L", "brakelights");
}

function init_local() {
  self.script_badplace = 1;
  self.vehicleanimalias = "techo";
}

function setanims() {
  var0 = [];

  for(var1 = 0; var1 < 7; var1++) {
    var0 = spawnStruct();
  }

  var0[0].bhasgunwhileriding = 0;
  var0[0].sittag = "TAG_DRIVER";
  var0[1].sittag = "TAG_PASSENGER";
  var0[2].sittag = "TAG_CAB1";
  var0[3].sittag = "TAG_CAB2";
  var0[4].sittag = "TAG_BED2";
  var0[5].sittag = "TAG_BED1";
  var0[6].sittag = "TAG_BED_CENTER";
  var0[0].canshootinvehicle = 0;
  var0[1].canshootinvehicle = 0;
  var0[2].canshootinvehicle = 0;
  var0[3].canshootinvehicle = 0;
  var0[4].canshootinvehicle = 1;
  var0[5].canshootinvehicle = 1;
  var0[6].canshootinvehicle = 1;
  var0[0].getin = % sdr_com_veh8_techo_driver_in;
  var0[1].getin = $sdr_com_veh8_techo_passenger_in;
  var0[2].getin = % sdr_com_veh8_techo_back_1_in;
  var0[3].getin = % sdr_com_veh8_techo_back_2_in;
  var0[4].getin = % sdr_com_veh8_techo_bed_1_in;
  var0[5].getin = % sdr_com_veh8_techo_bed_2_in;
  var0[6].getin = % sdr_com_veh8_techo_bed_3_in;
  var0[0].idle_anim = "sdr_com_veh8_techo_driver_idle";
  var0[0].idle = % sdr_com_veh8_techo_driver_idle;
  var0[1].idle_anim = "sdr_com_veh8_techo_passenger_idle";
  var0[1].idle = % sdr_com_veh8_techo_passenger_idle;
  var0[2].idle = % sdr_com_veh8_techo_back_1_idle;
  var0[3].idle = % sdr_com_veh8_techo_back_2_idle;
  var0[4].idle = % sdr_com_veh8_techo_bed_1_idle;
  var0[5].idle = % sdr_com_veh8_techo_bed_2_idle;
  var0[6].idle = % emb_def_truck_idle_aq01;
  var0[0].getout = % sdr_com_veh8_techo_driver_out;
  var0[1].getout = % sdr_com_veh8_techo_passenger_out;
  var0[2].getout = % sdr_com_veh8_techo_back_1_out;
  var0[3].getout = % sdr_com_veh8_techo_back_2_out;
  var0[4].getout = % sdr_com_veh8_techo_bed_1_out;
  var0[5].getout = % sdr_com_veh8_techo_bed_2_out;
  var0[6].getout = % sdr_com_veh8_techo_bed_3_out;
  var0[0].death = % emb_def_truck_driver_death;
  var0[1].death = % emb_def_truck_driver_death;
  var0[2].death = % emb_def_truck_driver_death;
  var0[3].death = % emb_def_truck_driver_death;
  var0[4].death = % emb_def_truck_driver_death;
  var0[5].death = % emb_def_truck_driver_death;
  var0[6].death = % emb_def_truck_driver_death;
  var0[0].death_no_ragdoll = 1;
  var0[1].death_no_ragdoll = 1;
  var0[2].death_no_ragdoll = 1;
  var0[3].death_no_ragdoll = 1;
  var0[4].death_no_ragdoll = 1;
  var0[5].death_no_ragdoll = 1;
  var0[6].death_no_ragdoll = 1;
  return var0;
}

function unload_groups() {
  var0 = [];

  for(var1 = 0; var1 < 7; var1++) {
    var0[var1] = var1;
  }

  var0 = [1, 2, 3, 4, 5, 6];
  return var0;
}

function set_vehicle_anims(var0) {
  var0[0].vehicle_getoutanim = % vh_techo_driver_exit_patrol;
  var0[0].vehicle_getoutanim_clear = 0;
  var0[0].vehicle_getoutanim_combat = $vh_techo_driver_exit_combat_idle;
  var0[0].vehicle_getoutanim_combat_clear = 0;
  var0[0].vehicle_getoutanim_combat_run = % vh_techo_driver_exit_combat_run;
  var0[0].vehicle_getoutanim_combat_run_clear = 0;
  var0[1].vehicle_getoutanim = % vh_techo_pass_exit_patrol;
  var0[1].vehicle_getoutanim_clear = 0;
  var0[1].vehicle_getoutanim_combat = % vh_techo_pass_exit_combat_idle;
  var0[1].vehicle_getoutanim_combat_clear = 0;
  var0[1].vehicle_getoutanim_combat_run = % vh_techo_pass_exit_combat_run;
  var0[1].vehicle_getoutanim_combat_run_clear = 0;
  var0[2].vehicle_getoutanim = % vh_techo_cab2_exit_patrol;
  var0[2].vehicle_getoutanim_clear = 0;
  var0[2].vehicle_getoutanim_combat = % vh_techo_cab2_exit_combat_idle;
  var0[2].vehicle_getoutanim_combat_clear = 0;
  var0[2].vehicle_getoutanim_combat_run = % vh_techo_cab2_exit_combat_run;
  var0[2].vehicle_getoutanim_combat_run_clear = 0;
  var0[3].vehicle_getoutanim = % vh_techo_cab1_exit_patrol;
  var0[3].vehicle_getoutanim_clear = 0;
  var0[3].vehicle_getoutanim_combat = % vh_techo_cab1_exit_combat_idle;
  var0[3].vehicle_getoutanim_combat_clear = 0;
  var0[3].vehicle_getoutanim_combat_run = % vh_techo_cab1_exit_combat_run;
  var0[3].vehicle_getoutanim_combat_run_clear = 0;
  var0[0].vehicle_getinanim = % reb_com_veh8_techo_fl_door_close;
  var0[0].vehicle_getinanim_clear = 0;
  var0[1].vehicle_getinanim = % reb_com_veh8_techo_fr_door_close;
  var0[1].vehicle_getinanim_clear = 0;
  var0[2].vehicle_getinanim = % reb_com_veh8_techo_bl_door_close;
  var0[2].vehicle_getinanim_clear = 0;
  var0[3].vehicle_getinanim = % reb_com_veh8_techo_br_door_close;
  var0[3].vehicle_getinanim_clear = 0;
  return var0;
}