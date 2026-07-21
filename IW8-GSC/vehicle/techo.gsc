/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: vehicle\techo.gsc
***********************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("truck", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(::init_local);
  var_3 = "veh8_civ_lnd_techo_static_dst";

  if(issubstr(var_0, "black"))
    var_3 = var_3 + "_black";
  else if(issubstr(var_0, "blue"))
    var_3 = var_3 + "_blue";
  else if(issubstr(var_0, "grey"))
    var_3 = var_3 + "_grey";
  else if(issubstr(var_0, "red"))
    var_3 = var_3 + "_red";
  else if(issubstr(var_0, "tan"))
    var_3 = var_3 + "_tan";
  else if(issubstr(var_0, "rebel"))
    var_3 = "veh8_civ_lnd_techo_rebel_static_dst";

  if(isendstr(var_0, "_physics"))
    var_3 = var_3 + "_physics";

  scripts\common\vehicle_build::build_deathmodel(var_0, var_3);
  scripts\common\vehicle_build::build_deathfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_civ.vfx", undefined, "car_explode");
  scripts\common\vehicle_build::build_deathquake(1, 1.6, 500);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_deathanimations(%veh8_common_pickup_expl_lf, %veh8_common_pickup_expl_rf, %veh8_common_pickup_expl_lb, %veh8_common_pickup_expl_rb);
  scripts\common\vehicle_build::build_drive(%veh8_common_pickup_driving_idle_forward, %veh8_common_pickup_driving_idle_backward, 10);
  scripts\common\vehicle_build::build_treadfx(var_2, "sand", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dust.vfx");
  scripts\common\vehicle_build::build_treadfx(var_2, "dirt", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dirt.vfx");
  scripts\common\vehicle_build::build_treadfx(var_2, "mud", "vfx/iw8/level/highway/vfx_vehicle_treadfx_mud.vfx");
  scripts\common\vehicle_build::build_life(2000);
  scripts\common\vehicle_build::build_team("axis");
  scripts\common\vehicle_build::build_aianims(::setanims, ::set_vehicle_anims, "techo");
  scripts\common\vehicle_build::build_unload_groups(::unload_groups);
  scripts\common\vehicle_build::build_light(var_2, "headlight_truck_left", "tag_light_front_left", "vfx/iw8/veh/system/vfx_veh_sys_headlight_techo_left", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "headlight_truck_right", "tag_light_front_right", "vfx/iw8/veh/system/vfx_veh_sys_headlight_techo_right", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "taillight_truck_right", "tag_light_back_right", "vfx/iw8/veh/system/vfx_veh_sys_taillight_techo_right", "brakelights");
  scripts\common\vehicle_build::build_light(var_2, "taillight_truck_left", "tag_light_back_left", "vfx/iw8/veh/system/vfx_veh_sys_taillight_techo_left", "brakelights");
  scripts\common\vehicle_build::build_light(var_2, "brakelight_truck_right", "tag_light_back_right", "vfx/misc/car_brakelight_truck_R", "brakelights");
  scripts\common\vehicle_build::build_light(var_2, "brakelight_truck_left", "tag_light_back_left", "vfx/misc/car_brakelight_truck_L", "brakelights");
}

init_local() {
  self.script_badplace = 1;
  self.vehicleanimalias = "techo";
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 7; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].bhasgunwhileriding = 0;
  var_0[0].sittag = "TAG_DRIVER";
  var_0[1].sittag = "TAG_PASSENGER";
  var_0[2].sittag = "TAG_CAB1";
  var_0[3].sittag = "TAG_CAB2";
  var_0[4].sittag = "TAG_BED2";
  var_0[5].sittag = "TAG_BED1";
  var_0[6].sittag = "TAG_BED_CENTER";
  var_0[0].canshootinvehicle = 0;
  var_0[1].canshootinvehicle = 0;
  var_0[2].canshootinvehicle = 0;
  var_0[3].canshootinvehicle = 0;
  var_0[4].canshootinvehicle = 1;
  var_0[5].canshootinvehicle = 1;
  var_0[6].canshootinvehicle = 1;
  var_0[0].getin = % sdr_com_veh8_techo_driver_in;
  var_0[1].getin = % sdr_com_veh8_techo_passenger_in;
  var_0[2].getin = % sdr_com_veh8_techo_back_1_in;
  var_0[3].getin = % sdr_com_veh8_techo_back_2_in;
  var_0[4].getin = % sdr_com_veh8_techo_bed_1_in;
  var_0[5].getin = % sdr_com_veh8_techo_bed_2_in;
  var_0[6].getin = % sdr_com_veh8_techo_bed_3_in;
  var_0[0].idle_anim = "sdr_com_veh8_techo_driver_idle";
  var_0[0].idle = % sdr_com_veh8_techo_driver_idle;
  var_0[1].idle_anim = "sdr_com_veh8_techo_passenger_idle";
  var_0[1].idle = % sdr_com_veh8_techo_passenger_idle;
  var_0[2].idle = % sdr_com_veh8_techo_back_1_idle;
  var_0[3].idle = % sdr_com_veh8_techo_back_2_idle;
  var_0[4].idle = % sdr_com_veh8_techo_bed_1_idle;
  var_0[5].idle = % sdr_com_veh8_techo_bed_2_idle;
  var_0[6].idle = % emb_def_truck_idle_aq01;
  var_0[0].getout = % sdr_com_veh8_techo_driver_out;
  var_0[1].getout = % sdr_com_veh8_techo_passenger_out;
  var_0[2].getout = % sdr_com_veh8_techo_back_1_out;
  var_0[3].getout = % sdr_com_veh8_techo_back_2_out;
  var_0[4].getout = % sdr_com_veh8_techo_bed_1_out;
  var_0[5].getout = % sdr_com_veh8_techo_bed_2_out;
  var_0[6].getout = % sdr_com_veh8_techo_bed_3_out;
  var_0[0].death = % emb_def_truck_driver_death;
  var_0[1].death = % emb_def_truck_driver_death;
  var_0[2].death = % emb_def_truck_driver_death;
  var_0[3].death = % emb_def_truck_driver_death;
  var_0[4].death = % emb_def_truck_driver_death;
  var_0[5].death = % emb_def_truck_driver_death;
  var_0[6].death = % emb_def_truck_driver_death;
  var_0[0].death_no_ragdoll = 1;
  var_0[1].death_no_ragdoll = 1;
  var_0[2].death_no_ragdoll = 1;
  var_0[3].death_no_ragdoll = 1;
  var_0[4].death_no_ragdoll = 1;
  var_0[5].death_no_ragdoll = 1;
  var_0[6].death_no_ragdoll = 1;
  return var_0;
}

unload_groups() {
  var_0 = [];

  for(var_1 = 0; var_1 < 7; var_1++)
    var_0["default"][var_1] = var_1;

  var_0["passengers"] = [1, 2, 3, 4, 5, 6];
  return var_0;
}

#using_animtree("vehicles");

set_vehicle_anims(var_0) {
  var_0[0].vehicle_getoutanim = % vh_techo_driver_exit_patrol;
  var_0[0].vehicle_getoutanim_clear = 0;
  var_0[0].vehicle_getoutanim_combat = % vh_techo_driver_exit_combat_idle;
  var_0[0].vehicle_getoutanim_combat_clear = 0;
  var_0[0].vehicle_getoutanim_combat_run = % vh_techo_driver_exit_combat_run;
  var_0[0].vehicle_getoutanim_combat_run_clear = 0;
  var_0[1].vehicle_getoutanim = % vh_techo_pass_exit_patrol;
  var_0[1].vehicle_getoutanim_clear = 0;
  var_0[1].vehicle_getoutanim_combat = % vh_techo_pass_exit_combat_idle;
  var_0[1].vehicle_getoutanim_combat_clear = 0;
  var_0[1].vehicle_getoutanim_combat_run = % vh_techo_pass_exit_combat_run;
  var_0[1].vehicle_getoutanim_combat_run_clear = 0;
  var_0[2].vehicle_getoutanim = % vh_techo_cab2_exit_patrol;
  var_0[2].vehicle_getoutanim_clear = 0;
  var_0[2].vehicle_getoutanim_combat = % vh_techo_cab2_exit_combat_idle;
  var_0[2].vehicle_getoutanim_combat_clear = 0;
  var_0[2].vehicle_getoutanim_combat_run = % vh_techo_cab2_exit_combat_run;
  var_0[2].vehicle_getoutanim_combat_run_clear = 0;
  var_0[3].vehicle_getoutanim = % vh_techo_cab1_exit_patrol;
  var_0[3].vehicle_getoutanim_clear = 0;
  var_0[3].vehicle_getoutanim_combat = % vh_techo_cab1_exit_combat_idle;
  var_0[3].vehicle_getoutanim_combat_clear = 0;
  var_0[3].vehicle_getoutanim_combat_run = % vh_techo_cab1_exit_combat_run;
  var_0[3].vehicle_getoutanim_combat_run_clear = 0;
  var_0[0].vehicle_getinanim = % reb_com_veh8_techo_fl_door_close;
  var_0[0].vehicle_getinanim_clear = 0;
  var_0[1].vehicle_getinanim = % reb_com_veh8_techo_fr_door_close;
  var_0[1].vehicle_getinanim_clear = 0;
  var_0[2].vehicle_getinanim = % reb_com_veh8_techo_bl_door_close;
  var_0[2].vehicle_getinanim_clear = 0;
  var_0[3].vehicle_getinanim = % reb_com_veh8_techo_br_door_close;
  var_0[3].vehicle_getinanim_clear = 0;
  return var_0;
}