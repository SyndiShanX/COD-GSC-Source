/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\tromeo.gsc
***********************************************/

#using_animtree("vehicles");

main(model, type, classname) {
  scripts\common\vehicle_build::build_template("truck", model, type, classname);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_deathmodel("veh8_mil_lnd_tromeo", "veh8_mil_lnd_tromeo_static_dst");
  scripts\common\vehicle_build::build_deathmodel("veh8_mil_lnd_tromeo_black", "veh8_mil_lnd_tromeo_static_dst_black");
  scripts\common\vehicle_build::build_deathmodel("veh8_mil_lnd_tromeo_green", "veh8_mil_lnd_tromeo_static_dst_green");
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/large_vehicle_explosion.vfx", undefined, "veh_gen_mtl_expl_small");
  scripts\common\vehicle_build::build_deathquake(1, 1.6, 500);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_drive(%veh8_common_pickup_driving_idle_forward, %veh8_common_pickup_driving_idle_backward, 10);
  scripts\common\vehicle_build::build_treadfx(classname, "sand", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dust.vfx");
  scripts\common\vehicle_build::build_treadfx(classname, "dirt", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dirt.vfx");
  scripts\common\vehicle_build::build_treadfx(classname, "mud", "vfx/iw8/level/highway/vfx_vehicle_treadfx_mud.vfx");
  scripts\common\vehicle_build::build_deathanimations(%veh8_common_pickup_expl_lf, %veh8_common_pickup_expl_rf, %veh8_common_pickup_expl_lb, %veh8_common_pickup_expl_rb);
  scripts\common\vehicle_build::build_life(2000);
  scripts\common\vehicle_build::build_team("allies");
  scripts\common\vehicle_build::build_aianims(::setanims, ::set_vehicle_anims, "tromeo");
  scripts\common\vehicle_build::build_unload_groups(::unload_groups);
  scripts\common\vehicle_build::build_light(classname, "headlight_truck_left", "tag_light_front_left", "vfx/misc/car_headlight_truck_L", "headlights");
  scripts\common\vehicle_build::build_light(classname, "headlight_truck_right", "tag_light_front_right", "vfx/misc/car_headlight_truck_R", "headlights");
  scripts\common\vehicle_build::build_light(classname, "taillight_truck_right", "tag_light_back_right", "vfx/misc/car_taillight_truck_R", "headlights");
  scripts\common\vehicle_build::build_light(classname, "taillight_truck_left", "tag_light_back_left", "vfx/misc/car_taillight_truck_L", "headlights");
  scripts\common\vehicle_build::build_light(classname, "brakelight_truck_right", "tag_light_back_right", "vfx/misc/car_brakelight_truck_R", "brakelights");
  scripts\common\vehicle_build::build_light(classname, "brakelight_truck_left", "tag_light_back_left", "vfx/misc/car_brakelight_truck_L", "brakelights");
}

init_local() {
  self.script_badplace = 1;
  self.vehicleanimalias = "tromeo";
  self.vehicledisableturningwhileshooting = 1;
}

setanims() {
  _id_E4B7E99A96C8829F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++)
    _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8] = spawnStruct();

  _id_E4B7E99A96C8829F[0].bhasgunwhileriding = 0;
  _id_E4B7E99A96C8829F[0].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[1].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[2].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[3].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[0].sittag = "TAG_DRIVER";
  _id_E4B7E99A96C8829F[1].sittag = "TAG_PASSENGER";
  _id_E4B7E99A96C8829F[2].sittag = "TAG_PASSENGER2";
  _id_E4B7E99A96C8829F[3].sittag = "TAG_PASSENGER3";
  _id_E4B7E99A96C8829F[0].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[1].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[2].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[3].death_no_ragdoll = 1;
  return _id_E4B7E99A96C8829F;
}

unload_groups() {
  unload_groups = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++)
    unload_groups["default"][_id_AC0E594AC96AA3A8] = _id_AC0E594AC96AA3A8;

  return unload_groups;
}

set_vehicle_anims(_id_E4B7E99A96C8829F) {
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim = % vh_tromeo_front_exit_patrol;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat = % vh_tromeo_front_exit_combat_idle;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat_clear = 0;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat_run = % vh_tromeo_front_exit_combat_run;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat_run_clear = 0;
  _id_E4B7E99A96C8829F[2].vehicle_getoutanim = % reb_com_veh8_techo_br_door_open;
  _id_E4B7E99A96C8829F[2].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[3].vehicle_getoutanim = % reb_com_veh8_techo_bl_door_open;
  _id_E4B7E99A96C8829F[3].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[0].vehicle_getinanim = % reb_com_veh8_techo_fl_door_close;
  _id_E4B7E99A96C8829F[0].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[1].vehicle_getinanim = % reb_com_veh8_techo_fr_door_close;
  _id_E4B7E99A96C8829F[1].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[2].vehicle_getinanim = % reb_com_veh8_techo_br_door_close;
  _id_E4B7E99A96C8829F[2].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[3].vehicle_getinanim = % reb_com_veh8_techo_bl_door_close;
  _id_E4B7E99A96C8829F[3].vehicle_getinanim_clear = 0;
  return _id_E4B7E99A96C8829F;
}