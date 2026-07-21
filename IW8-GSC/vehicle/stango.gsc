/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: vehicle\stango.gsc
***********************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("apc", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_deathmodel(var_0, "veh8_mil_lnd_stango");
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/large_vehicle_explosion.vfx", undefined, "veh_gen_armored_expl_destr");
  scripts\common\vehicle_build::build_deathquake(1, 1.6, 500);
  scripts\common\vehicle_build::build_deathanimations(%veh8_common_pickup_expl_lf, %veh8_common_pickup_expl_rf, %veh8_common_pickup_expl_lb, %veh8_common_pickup_expl_rb);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_drive(%vh_stango_driving_idle_forward, %vh_stango_driving_idle_backward, 10);
  scripts\common\vehicle_build::build_treadfx(var_2, "sand", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dust.vfx");
  scripts\common\vehicle_build::build_treadfx(var_2, "dirt", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dirt.vfx");
  scripts\common\vehicle_build::build_life(1500, 1499, 1500);
  scripts\common\vehicle_build::build_team("allies");
  scripts\common\vehicle_build::build_aianims(::setanims, ::set_vehicle_anims, "apc");
  scripts\common\vehicle_build::build_unload_groups(::unload_groups);
  scripts\common\vehicle_build::build_light(var_2, "headlight_L", "tag_light_front_left", "vfx/misc/car_headlight_truck_L", "headlights", 0.0);
  scripts\common\vehicle_build::build_light(var_2, "headlight_R", "tag_light_front_right", "vfx/misc/car_headlight_truck_R", "headlights", 0.0);
  scripts\common\vehicle_build::build_light(var_2, "brakelight_L", "tag_light_back_left", "vfx/misc/car_brakelight_truck_L", "headlights", 0.0);
  scripts\common\vehicle_build::build_light(var_2, "brakelight_R", "tag_light_back_right", "vfx/misc/car_brakelight_truck_R", "headlights", 0.0);
}

init_local() {
  self.script_badplace = 1;
  scripts\engine\utility::ent_flag_init("no_riders_until_unload");
  self.vehicleanimalias = "stango";
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 10; var_1++) {
    var_0[var_1] = spawnStruct();
    var_0[var_1].sittag = "tag_detach";
  }

  var_0[0].idle = % vh_apc_org_idle_door_left_guy1;
  var_0[1].idle = % vh_apc_org_idle_door_left_guy2;
  var_0[2].idle = % vh_apc_org_idle_door_right_guy3;
  var_0[3].idle = % vh_apc_org_idle_door_right_guy4;
  var_0[4].idle = % vh_apc_org_idle_door_back_guy5;
  var_0[5].idle = % vh_apc_org_idle_door_back_guy6;
  var_0[6].idle = % vh_apc_org_idle_door_back_guy7;
  var_0[7].idle = % vh_apc_org_idle_door_back_guy8;
  var_0[8].idle = % vh_apc_org_idle_door_back_guy8;
  var_0[9].idle = % vh_apc_org_idle_door_back_guy8;
  var_0[0].getout = % vh_apc_org_unload_door_left_guy1;
  var_0[1].getout = % vh_apc_org_unload_door_left_guy2;
  var_0[2].getout = % vh_apc_org_unload_door_right_guy3;
  var_0[3].getout = % vh_apc_org_unload_door_right_guy4;
  var_0[4].getout = % vh_apc_org_unload_door_back_guy5;
  var_0[5].getout = % vh_apc_org_unload_door_back_guy6;
  var_0[6].getout = % vh_apc_org_unload_door_back_guy7;
  var_0[7].getout = % vh_apc_org_unload_door_back_guy8;
  var_0[8].getout = % vh_apc_org_unload_door_back_guy7;
  var_0[9].getout = % vh_apc_org_unload_door_back_guy8;
  return var_0;
}

unload_groups() {
  var_0 = [];

  for(var_1 = 0; var_1 < 10; var_1++)
    var_0["default"][var_1] = var_1;

  return var_0;
}

#using_animtree("vehicles");

set_vehicle_anims(var_0) {
  var_0[0].vehicle_getoutanim = % vh_apc_org_unload_door_l;
  var_0[0].vehicle_getoutanim_clear = 0;
  var_0[2].vehicle_getoutanim = % vh_apc_org_unload_door_r;
  var_0[2].vehicle_getoutanim_clear = 0;
  var_0[4].vehicle_getoutanim = % vh_apc_org_unload_door_back;
  var_0[4].vehicle_getoutanim_clear = 0;
  return var_0;
}