/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: vehicle_scripts\_bm21_troops.gsc
********************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("bm21_troops", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_destructible("vehicle_bm21_mobile_bed_destructible", "vehicle_bm21_mobile_bed");
  maps\_vehicle::build_destructible("vehicle_bm21_bed_under_destructible", "vehicle_bm21_bed_under");
  maps\_vehicle::build_destructible("vehicle_bm21_cover_destructible", "vehicle_bm21_cover");
  maps\_vehicle::build_destructible("vehicle_bm21_cover_under_destructible", "vehicle_bm21_cover_under");
  maps\_vehicle::build_deathmodel("vehicle_bm21_mobile", "vehicle_bm21_mobile_dstry");
  maps\_vehicle::build_deathmodel("vehicle_bm21_mobile_cover", "vehicle_bm21_mobile_cover_dstry");
  maps\_vehicle::build_deathmodel("vehicle_bm21_mobile_bed", "vehicle_bm21_mobile_bed_dstry");
  maps\_vehicle::build_deathmodel("vehicle_bm21_mobile_cover_no_bench", "vehicle_bm21_mobile_cover_dstry");
  maps\_vehicle::build_deathfx("fx\explosions\large_vehicle_explosion", undefined, "truck_explode", undefined, undefined, undefined, 0);
  maps\_vehicle::build_deathfx("fx\fire\firelp_med_pm", "tag_fx_tire_right_r", undefined, undefined, undefined, 1, 0);
  maps\_vehicle::build_deathfx("fx\fire\firelp_med_pm", "tag_fx_cab", "fire_metal_medium", undefined, undefined, 1, 0);
  maps\_vehicle::build_deathfx("fx\explosions\small_vehicle_explosion", "tag_fx_tank", "explo_metal_rand", undefined, undefined, undefined, 2);
  maps\_vehicle::build_rumble("pickup_rumble", 0.01, 4.5, 900, 1, 1);
  maps\_vehicle::build_deathquake(1, 1.6, 500);
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("axis");
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_bulletshield(1);
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
  maps\_vehicle::build_unload_groups(::unload_groups);
  maps\_vehicle::build_light(var_2, "headlight_truck_left", "tag_headlight_left", "fx\misc\lighthaze", "headlights");
  maps\_vehicle::build_light(var_2, "headlight_truck_right", "tag_headlight_right", "fx\misc\lighthaze", "headlights");
  maps\_vehicle::build_light(var_2, "headlight_truck_left2", "tag_headlight_left", "fx\misc\car_headlight_bm21", "headlights");
  maps\_vehicle::build_light(var_2, "headlight_truck_right2", "tag_headlight_right", "fx\misc\car_headlight_bm21", "headlights");
  maps\_vehicle::build_light(var_2, "parkinglight_truck_left_f", "tag_parkinglight_left_f", "fx\misc\car_parkinglight_bm21", "headlights");
  maps\_vehicle::build_light(var_2, "parkinglight_truck_right_f", "tag_parkinglight_right_f", "fx\misc\car_parkinglight_bm21", "headlights");
  maps\_vehicle::build_light(var_2, "taillight_truck_right", "tag_taillight_right", "fx\misc\car_taillight_bm21", "headlights");
  maps\_vehicle::build_light(var_2, "taillight_truck_left", "tag_taillight_left", "fx\misc\car_taillight_bm21", "headlights");
  maps\_vehicle::build_light(var_2, "brakelight_troops_right", "tag_taillight_right", "fx\misc\car_taillight_bm21", "brakelights");
  maps\_vehicle::build_light(var_2, "brakelight_troops_left", "tag_taillight_left", "fx\misc\car_taillight_bm21", "brakelights");
  maps\_vehicle::build_drive( % bm21_driving_idle_forward, % bm21_driving_idle_backward, 10);
}

init_local() {}

set_vehicle_anims(var_0) {
  var_0[0].vehicle_getoutanim = % bm21_driver_climbout_door;
  var_0[1].vehicle_getoutanim = % bm21_passenger_climbout_door;
  var_0[2].vehicle_getoutanim = % bm21_guy_climbout_truckdoor;
  var_0[3].vehicle_getoutanim = % bm21_guy_climbout_truckdoor;
  var_0[4].vehicle_getoutanim = % bm21_guy_climbout_truckdoor;
  var_0[5].vehicle_getoutanim = % bm21_guy_climbout_truckdoor;
  var_0[6].vehicle_getoutanim = % bm21_guy_climbout_truckdoor;
  var_0[7].vehicle_getoutanim = % bm21_guy_climbout_truckdoor;
  var_0[8].vehicle_getoutanim = % bm21_guy_climbout_truckdoor;
  var_0[9].vehicle_getoutanim = % bm21_guy_climbout_truckdoor;
  var_0[0].vehicle_getoutsoundtag = "left_door";
  var_0[1].vehicle_getoutsoundtag = "right_door";
  var_0[2].vehicle_getoutsoundtag = "back_board";
  var_0[3].vehicle_getoutsoundtag = "back_board";
  var_0[4].vehicle_getoutsoundtag = "back_board";
  var_0[5].vehicle_getoutsoundtag = "back_board";
  var_0[6].vehicle_getoutsoundtag = "back_board";
  var_0[7].vehicle_getoutsoundtag = "back_board";
  var_0[8].vehicle_getoutsoundtag = "back_board";
  var_0[9].vehicle_getoutsoundtag = "back_board";
  var_0[0].vehicle_getoutsound = "scn_truck_door_open_01";
  var_0[1].vehicle_getoutsound = "scn_truck_door_open_02";
  var_0[0].vehicle_getoutanim_clear = 1;
  var_0[1].vehicle_getoutanim_clear = 1;
  var_0[2].vehicle_getoutanim_clear = 0;
  var_0[3].vehicle_getoutanim_clear = 0;
  var_0[4].vehicle_getoutanim_clear = 0;
  var_0[5].vehicle_getoutanim_clear = 0;
  var_0[6].vehicle_getoutanim_clear = 0;
  var_0[7].vehicle_getoutanim_clear = 0;
  var_0[8].vehicle_getoutanim_clear = 0;
  var_0[9].vehicle_getoutanim_clear = 0;
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for (var_1 = 0; var_1 < 10; var_1++)
    var_0[var_1] = spawnstruct();

  var_0[0].sittag = "tag_driver";
  var_0[1].sittag = "tag_passenger";
  var_0[2].sittag = "tag_detach";
  var_0[3].sittag = "tag_detach";
  var_0[4].sittag = "tag_detach";
  var_0[5].sittag = "tag_detach";
  var_0[6].sittag = "tag_detach";
  var_0[7].sittag = "tag_detach";
  var_0[8].sittag = "tag_detach";
  var_0[9].sittag = "tag_detach";
  var_0[0].idle = % bm21_driver_idle;
  var_0[1].idle = % bm21_passenger_idle;
  var_0[2].idle = % bm21_guy1_idle;
  var_0[3].idle = % bm21_guy2_idle;
  var_0[4].idle = % bm21_guy3_idle;
  var_0[5].idle = % bm21_guy4_idle;
  var_0[6].idle = % bm21_guy5_idle;
  var_0[7].idle = % bm21_guy6_idle;
  var_0[8].idle = % bm21_guy7_idle;
  var_0[9].idle = % bm21_guy8_idle;
  var_0[0].idle_anim = % bm21_driver_driving;
  var_0[0].idle_animstop = % bm21_driver_idle;
  var_0[0].getout = % bm21_driver_climbout;
  var_0[1].getout = % bm21_passenger_climbout;
  var_0[2].getout = % bm21_guy1_climbout;
  var_0[3].getout = % bm21_guy2_climbout;
  var_0[4].getout = % bm21_guy3_climbout;
  var_0[5].getout = % bm21_guy4_climbout;
  var_0[6].getout = % bm21_guy5_climbout;
  var_0[7].getout = % bm21_guy6_climbout;
  var_0[8].getout = % bm21_guy7_climbout;
  var_0[9].getout = % bm21_guy8_climbout;
  var_0[2].getout_secondary = % bm21_guy_climbout_landing;
  var_0[3].getout_secondary = % bm21_guy_climbout_landing;
  var_0[4].getout_secondary = % bm21_guy_climbout_landing;
  var_0[6].getout_secondary = % bm21_guy_climbout_landing;
  var_0[7].getout_secondary = % bm21_guy_climbout_landing;
  var_0[8].getout_secondary = % bm21_guy_climbout_landing;
  return var_0;
}

unload_groups() {
  var_0 = [];
  var_0["passengers"] = [];
  var_0["all"] = [];
  var_1 = "passengers";
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_0[var_1][var_0[var_1].size] = 4;
  var_0[var_1][var_0[var_1].size] = 5;
  var_0[var_1][var_0[var_1].size] = 6;
  var_0[var_1][var_0[var_1].size] = 7;
  var_0[var_1][var_0[var_1].size] = 8;
  var_0[var_1][var_0[var_1].size] = 9;
  var_1 = "all";
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_0[var_1][var_0[var_1].size] = 4;
  var_0[var_1][var_0[var_1].size] = 5;
  var_0[var_1][var_0[var_1].size] = 6;
  var_0[var_1][var_0[var_1].size] = 7;
  var_0[var_1][var_0[var_1].size] = 8;
  var_0[var_1][var_0[var_1].size] = 9;
  var_0["default"] = var_0["all"];
  return var_0;
}