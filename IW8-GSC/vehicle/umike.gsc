/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: vehicle\umike.gsc
***********************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("umike", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_deathmodel(var_0, "veh8_mil_lnd_umike_pickup_static_dst");
  scripts\common\vehicle_build::build_deathfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_truck.vfx", "tag_origin", "veh_gen_armored_expl_destr");
  scripts\common\vehicle_build::build_deathquake(1, 1.6, 500);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_deathanimations(%veh8_common_pickup_expl_lf, %veh8_common_pickup_expl_rf, %veh8_common_pickup_expl_lb, %veh8_common_pickup_expl_rb);
  scripts\common\vehicle_build::build_drive(%veh8_common_pickup_driving_idle_forward, %veh8_common_pickup_driving_idle_backward, 10);
  scripts\common\vehicle_build::build_treadfx(var_2, "sand", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dust.vfx");
  scripts\common\vehicle_build::build_treadfx(var_2, "dirt", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dirt.vfx");
  scripts\common\vehicle_build::build_treadfx(var_2, "mud", "vfx/iw8/level/highway/vfx_vehicle_treadfx_mud.vfx");
  scripts\common\vehicle_build::build_life(1500, 1499, 1500);
  scripts\common\vehicle_build::build_team("allies");
  scripts\common\vehicle_build::build_aianims(::setanims, ::set_vehicle_anims, "umike");
  scripts\common\vehicle_build::build_unload_groups(::unload_groups);
  scripts\common\vehicle_build::build_light(var_2, "headlight_truck_left", "tag_light_front_left", "vfx/misc/car_headlight_truck_L", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "headlight_truck_right", "tag_light_front_right", "vfx/misc/car_headlight_truck_R", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "taillight_truck_right", "tag_light_back_right", "vfx/iw8/veh/scriptables/vfx_veh_taillight_umike_right", "brakelights");
  scripts\common\vehicle_build::build_light(var_2, "taillight_truck_left", "tag_light_back_left", "vfx/iw8/veh/scriptables/vfx_veh_taillight_umike_left", "brakelights");
}

init_local() {
  self.script_badplace = 1;
  self.vehicleanimalias = "umike";
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 8; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].bhasgunwhileriding = 0;
  var_0[0].sittag = "TAG_DRIVER";
  var_0[1].sittag = "TAG_PASSENGER";
  var_0[2].sittag = "TAG_BODY_ANIMATE";
  var_0[3].sittag = "TAG_BODY_ANIMATE";
  var_0[4].sittag = "TAG_BODY_ANIMATE";
  var_0[5].sittag = "TAG_BODY_ANIMATE";
  var_0[6].sittag = "TAG_BODY_ANIMATE";
  var_0[7].sittag = "TAG_BODY_ANIMATE";
  var_0[0].getin = % reb_vh_umike_driver_get_in;
  var_0[1].getin = % reb_vh_umike_passenger_get_in;
  var_0[2].getin = % sdr_com_veh8_techo_back_1_in;
  var_0[3].getin = % sdr_com_veh8_techo_back_2_in;
  var_0[0].idle = % reb_vh_umike_driver_idle_search01;
  var_0[0].idle_anim = "reb_vh_umike_driver_idle_search01";
  var_0[1].idle = % reb_vh_umike_passenger_idle_search01;
  var_0[1].idle_anim = "reb_vh_umike_passenger_idle_search01";
  var_0[2].idle = % reb_vh_umike_bed_guy1_idle_search01;
  var_0[3].idle = % reb_vh_umike_bed_guy2_idle_search01;
  var_0[0].getout = % reb_vh_umike_driver_exit_combat_idle;
  var_0[1].getout = % reb_vh_umike_passenger_exit_combat_idle;
  var_0[2].getout = % reb_vh_umike_bed_guy1_exit_combat_idle;
  var_0[3].getout = % reb_vh_umike_bed_guy2_exit_combat_idle;
  var_0[0].death = % emb_def_truck_driver_death;
  var_0[1].death = % vh_org_4x4_atv_death_front_guy2;
  var_0[2].death = % vh_org_4x4_atv_death_front_guy2;
  var_0[3].death = % vh_org_4x4_atv_death_front_guy2;
  var_0[0].death_no_ragdoll = 1;
  var_0[1].death_no_ragdoll = 1;
  var_0[2].death_no_ragdoll = 1;
  var_0[3].death_no_ragdoll = 1;
  var_0[4].death_no_ragdoll = 1;
  var_0[5].death_no_ragdoll = 1;
  var_0[6].death_no_ragdoll = 1;
  var_0[7].death_no_ragdoll = 1;

  if(getDvar("mapname") == "safehouse_finale") {
    var_0[2].death_no_ragdoll = undefined;
    var_0[3].death_no_ragdoll = undefined;
    var_0[4].death_no_ragdoll = undefined;
    var_0[5].death_no_ragdoll = undefined;
    var_0[6].death_no_ragdoll = undefined;
    var_0[7].death_no_ragdoll = undefined;
  }

  return var_0;
}

#using_animtree("vehicles");

set_vehicle_anims(var_0) {
  var_0[0].vehicle_getoutanim = % vh_umike_driver_exit_patrol;
  var_0[0].vehicle_getoutanim_clear = 0;
  var_0[0].vehicle_getoutanim_combat = % vh_umike_driver_exit_combat_idle;
  var_0[0].vehicle_getoutanim_combat_clear = 0;
  var_0[0].vehicle_getoutanim_combat_run = % vh_umike_driver_exit_combat_run;
  var_0[0].vehicle_getoutanim_combat_run_clear = 0;
  var_0[1].vehicle_getoutanim = % vh_umike_passenger_exit_patrol;
  var_0[1].vehicle_getoutanim_clear = 0;
  var_0[1].vehicle_getoutanim_combat = % vh_umike_passenger_exit_combat_idle;
  var_0[1].vehicle_getoutanim_combat_clear = 0;
  var_0[1].vehicle_getoutanim_combat_run = % vh_umike_passenger_exit_combat_run;
  var_0[1].vehicle_getoutanim_combat_run_clear = 0;
  var_0[2].vehicle_getoutanim = % vh_umike_bed_exit_combat_idle;
  var_0[2].vehicle_getoutanim_clear = 0;
  return var_0;
}

unload_groups() {
  var_0 = [];
  var_0["front"] = [0, 1];

  for(var_1 = 0; var_1 < 8; var_1++)
    var_0["default"][var_1] = var_1;

  return var_0;
}