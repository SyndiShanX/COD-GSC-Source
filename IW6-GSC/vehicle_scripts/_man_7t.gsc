/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_man_7t.gsc
***************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("man_7t", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_man_7t_iw6", "vehicle_man_7t_destroy_iw6");
  maps\_vehicle::build_deathfx("fx/explosions/large_vehicle_explosion", undefined, "car_explode", undefined, undefined, undefined, 0);
  maps\_vehicle::build_deathquake(1, 1.6, 500);
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("axis");
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_bulletshield(1);
  var_3 = ::setanims;
  var_4 = ::set_vehicle_anims;
  maps\_vehicle::build_aianims(var_3, var_4);
  maps\_vehicle::build_unload_groups(::unload_groups);
  maps\_vehicle::build_light(var_2, "headlight_truck_left", "tag_headlight_left", "fx/misc/lighthaze", "headlights");
  maps\_vehicle::build_light(var_2, "headlight_truck_right", "tag_headlight_right", "fx/misc/lighthaze", "headlights");
  maps\_vehicle::build_drive( % bm21_driving_idle_forward, % bm21_driving_idle_backward, 10);
}

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

  for(var_1 = 0; var_1 < 11; var_1++) {
    var_0[var_1] = spawnStruct();
  }

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
  var_0[2].explosion_death = % death_explosion_up10;
  var_0[3].explosion_death = % death_explosion_up10;
  var_0[4].explosion_death = % death_explosion_up10;
  var_0[5].explosion_death = % death_explosion_up10;
  var_0[6].explosion_death = % death_explosion_up10;
  var_0[7].explosion_death = % death_explosion_up10;
  var_0[8].explosion_death = % death_explosion_up10;
  var_0[9].explosion_death = % death_explosion_up10;
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
  var_0[var_1][var_0[var_1].size] = 10;
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