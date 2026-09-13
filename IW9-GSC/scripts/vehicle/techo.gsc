/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\techo.gsc
***********************************************/

#using_animtree("vehicles");

main(model, type, classname) {
  scripts\common\vehicle_build::build_template("truck", model, type, classname);
  scripts\common\vehicle_build::build_localinit(::init_local);
  deathmodel = "veh8_civ_lnd_techo_static_dst";

  if(issubstr(model, "black"))
    deathmodel = deathmodel + "_black";
  else if(issubstr(model, "blue"))
    deathmodel = deathmodel + "_blue";
  else if(issubstr(model, "grey"))
    deathmodel = deathmodel + "_grey";
  else if(issubstr(model, "red"))
    deathmodel = deathmodel + "_red";
  else if(issubstr(model, "tan"))
    deathmodel = deathmodel + "_tan";
  else if(issubstr(model, "rebel"))
    deathmodel = "veh8_civ_lnd_techo_rebel_static_dst";

  if(isendstr(model, "_physics") && !issubstr(model, "rebel"))
    deathmodel = deathmodel + "_physics";

  scripts\common\vehicle_build::build_deathmodel(model, deathmodel);
  scripts\common\vehicle_build::build_deathfx("vfx/iw8_mp/vehicle/vfx_pickup_mp_death_exp.vfx", undefined, "veh9_dmg_generic_explode");
  scripts\common\vehicle_build::build_deathquake(1, 1.6, 500);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_deathanimations(%veh8_common_pickup_expl_lf, %veh8_common_pickup_expl_rf, %veh8_common_pickup_expl_lb, %veh8_common_pickup_expl_rb);
  scripts\common\vehicle_build::build_drive(%veh8_common_pickup_driving_idle_forward, %veh8_common_pickup_driving_idle_backward, 10);
  scripts\common\vehicle_build::build_treadfx(classname, "sand", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dust.vfx");
  scripts\common\vehicle_build::build_treadfx(classname, "dirt", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dirt.vfx");
  scripts\common\vehicle_build::build_treadfx(classname, "mud", "vfx/iw8/level/highway/vfx_vehicle_treadfx_mud.vfx");
  scripts\common\vehicle_build::build_treadfx(classname, "default", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dirt.vfx");
  scripts\common\vehicle_build::build_life(2000);
  scripts\common\vehicle_build::build_team("axis");
  scripts\common\vehicle_build::build_aianims(::setanims, ::set_vehicle_anims, "techo");
  scripts\common\vehicle_build::build_unload_groups(::unload_groups);
  scripts\common\vehicle_build::build_light(classname, "headlight_truck_left", "tag_light_front_left", "vfx/iw8/veh/system/vfx_veh_sys_headlight_techo_left", "headlights");
  scripts\common\vehicle_build::build_light(classname, "headlight_truck_right", "tag_light_front_right", "vfx/iw8/veh/system/vfx_veh_sys_headlight_techo_right", "headlights");
  scripts\common\vehicle_build::build_light(classname, "taillight_truck_right", "tag_light_back_right", "vfx/iw8/veh/system/vfx_veh_sys_taillight_techo_right", "brakelights");
  scripts\common\vehicle_build::build_light(classname, "taillight_truck_left", "tag_light_back_left", "vfx/iw8/veh/system/vfx_veh_sys_taillight_techo_left", "brakelights");
  scripts\common\vehicle_build::build_light(classname, "brakelight_truck_right", "tag_light_back_right", "vfx/misc/car_brakelight_truck_R", "brakelights");
  scripts\common\vehicle_build::build_light(classname, "brakelight_truck_left", "tag_light_back_left", "vfx/misc/car_brakelight_truck_L", "brakelights");
}

init_local() {
  self.script_badplace = 1;
  self.vehicleanimalias = "techo";

  if(scripts\common\utility::iscp())
    self.vehicleanimalias = self.vehicleanimalias + "_cp";
}

#using_animtree("generic_human");

setanims() {
  _id_E4B7E99A96C8829F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 7; _id_AC0E594AC96AA3A8++)
    _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8] = spawnStruct();

  _id_E4B7E99A96C8829F[0].bhasgunwhileriding = 0;
  _id_E4B7E99A96C8829F[0].sittag = "TAG_DRIVER";
  _id_E4B7E99A96C8829F[1].sittag = "TAG_PASSENGER";
  _id_E4B7E99A96C8829F[2].sittag = "TAG_CAB1";
  _id_E4B7E99A96C8829F[3].sittag = "TAG_CAB2";
  _id_E4B7E99A96C8829F[4].sittag = "TAG_BED2";
  _id_E4B7E99A96C8829F[5].sittag = "TAG_BED1";
  _id_E4B7E99A96C8829F[6].sittag = "TAG_BED_CENTER";
  _id_E4B7E99A96C8829F[0].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[1].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[2].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[3].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[4].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[5].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[6].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[0].getin = % sdr_com_veh8_techo_driver_in;
  _id_E4B7E99A96C8829F[1].getin = % sdr_com_veh8_techo_passenger_in;
  _id_E4B7E99A96C8829F[2].getin = % sdr_com_veh8_techo_back_1_in;
  _id_E4B7E99A96C8829F[3].getin = % sdr_com_veh8_techo_back_2_in;
  _id_E4B7E99A96C8829F[4].getin = % sdr_com_veh8_techo_bed_1_in;
  _id_E4B7E99A96C8829F[5].getin = % sdr_com_veh8_techo_bed_2_in;
  _id_E4B7E99A96C8829F[6].getin = % sdr_com_veh8_techo_bed_3_in;
  _id_E4B7E99A96C8829F[0].idle_anim = "sdr_com_veh8_techo_driver_idle";
  _id_E4B7E99A96C8829F[0].idle = % sdr_com_veh8_techo_driver_idle;
  _id_E4B7E99A96C8829F[1].idle_anim = "sdr_com_veh8_techo_passenger_idle";
  _id_E4B7E99A96C8829F[1].idle = % sdr_com_veh8_techo_passenger_idle;
  _id_E4B7E99A96C8829F[2].idle = % sdr_com_veh8_techo_back_1_idle;
  _id_E4B7E99A96C8829F[3].idle = % sdr_com_veh8_techo_back_2_idle;
  _id_E4B7E99A96C8829F[4].idle = % sdr_com_veh8_techo_bed_1_idle;
  _id_E4B7E99A96C8829F[5].idle = % sdr_com_veh8_techo_bed_2_idle;
  _id_E4B7E99A96C8829F[6].idle = % emb_def_truck_idle_aq01;
  _id_E4B7E99A96C8829F[0].getout = % sdr_com_veh8_techo_driver_out;
  _id_E4B7E99A96C8829F[1].getout = % sdr_com_veh8_techo_passenger_out;
  _id_E4B7E99A96C8829F[2].getout = % sdr_com_veh8_techo_back_1_out;
  _id_E4B7E99A96C8829F[3].getout = % sdr_com_veh8_techo_back_2_out;
  _id_E4B7E99A96C8829F[4].getout = % sdr_com_veh8_techo_bed_1_out;
  _id_E4B7E99A96C8829F[5].getout = % sdr_com_veh8_techo_bed_2_out;
  _id_E4B7E99A96C8829F[6].getout = % sdr_com_veh8_techo_bed_3_out;
  _id_E4B7E99A96C8829F[0].death = % emb_def_truck_driver_death;
  _id_E4B7E99A96C8829F[1].death = % emb_def_truck_driver_death;
  _id_E4B7E99A96C8829F[2].death = % emb_def_truck_driver_death;
  _id_E4B7E99A96C8829F[3].death = % emb_def_truck_driver_death;
  _id_E4B7E99A96C8829F[4].death = % emb_def_truck_driver_death;
  _id_E4B7E99A96C8829F[5].death = % emb_def_truck_driver_death;
  _id_E4B7E99A96C8829F[6].death = % emb_def_truck_driver_death;
  _id_E4B7E99A96C8829F[0].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[1].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[2].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[3].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[4].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[5].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[6].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[0].death_impulse = 0;
  _id_E4B7E99A96C8829F[1].death_impulse = 1;
  _id_E4B7E99A96C8829F[2].death_impulse = 1;
  _id_E4B7E99A96C8829F[3].death_impulse = 1;
  _id_E4B7E99A96C8829F[4].death_impulse = 1;
  _id_E4B7E99A96C8829F[5].death_impulse = 1;
  _id_E4B7E99A96C8829F[6].death_impulse = 1;
  return _id_E4B7E99A96C8829F;
}

unload_groups() {
  unload_groups = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 7; _id_AC0E594AC96AA3A8++)
    unload_groups["default"][_id_AC0E594AC96AA3A8] = _id_AC0E594AC96AA3A8;

  unload_groups["passengers"] = [1, 2, 3, 4, 5, 6];
  unload_groups["backseats"] = [2, 3];
  unload_groups["entirecab"] = [0, 1, 2, 3];
  return unload_groups;
}

#using_animtree("vehicles");

set_vehicle_anims(_id_E4B7E99A96C8829F) {
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim = % vh_techo_driver_exit_patrol;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat = % vh_techo_driver_exit_combat_idle;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat_clear = 0;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat_run = % vh_techo_driver_exit_combat_run;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat_run_clear = 0;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim = % vh_techo_pass_exit_patrol;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim_combat = % vh_techo_pass_exit_combat_idle;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim_combat_clear = 0;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim_combat_run = % vh_techo_pass_exit_combat_run;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim_combat_run_clear = 0;
  _id_E4B7E99A96C8829F[2].vehicle_getoutanim = % vh_techo_cab2_exit_patrol;
  _id_E4B7E99A96C8829F[2].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[2].vehicle_getoutanim_combat = % vh_techo_cab2_exit_combat_idle;
  _id_E4B7E99A96C8829F[2].vehicle_getoutanim_combat_clear = 0;
  _id_E4B7E99A96C8829F[2].vehicle_getoutanim_combat_run = % vh_techo_cab2_exit_combat_run;
  _id_E4B7E99A96C8829F[2].vehicle_getoutanim_combat_run_clear = 0;
  _id_E4B7E99A96C8829F[3].vehicle_getoutanim = % vh_techo_cab1_exit_patrol;
  _id_E4B7E99A96C8829F[3].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[3].vehicle_getoutanim_combat = % vh_techo_cab1_exit_combat_idle;
  _id_E4B7E99A96C8829F[3].vehicle_getoutanim_combat_clear = 0;
  _id_E4B7E99A96C8829F[3].vehicle_getoutanim_combat_run = % vh_techo_cab1_exit_combat_run;
  _id_E4B7E99A96C8829F[3].vehicle_getoutanim_combat_run_clear = 0;
  _id_E4B7E99A96C8829F[0].vehicle_getinanim = % reb_com_veh8_techo_fl_door_close;
  _id_E4B7E99A96C8829F[0].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[1].vehicle_getinanim = % reb_com_veh8_techo_fr_door_close;
  _id_E4B7E99A96C8829F[1].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[2].vehicle_getinanim = % reb_com_veh8_techo_bl_door_close;
  _id_E4B7E99A96C8829F[2].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[3].vehicle_getinanim = % reb_com_veh8_techo_br_door_close;
  _id_E4B7E99A96C8829F[3].vehicle_getinanim_clear = 0;
  return _id_E4B7E99A96C8829F;
}