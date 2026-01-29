/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\67.gsc
**************************************/

_id_0B4F() {
  level._id_0B50 = [];
  _id_0B57();
  _id_0B51();
  level._id_0B50 = undefined;
}

_id_0B51() {
  anim._id_0B52 = [];
  var_0 = getEntArray();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3.classname) && issubstr(var_3.classname, "trigger_multiple_bcs")) {
      var_1[var_1.size] = var_3;
    }
  }

  foreach(var_3 in var_1) {
    var_6 = _id_0B55(level._id_0B50[var_3.classname]);

    if(var_6.size > 1) {
      var_6 = maps\_utility::_id_0B53(var_6);

    }
    var_3._id_0B54 = var_6;
  }

  anim._id_0B52 = var_1;
}

_id_0B55(var_0) {
  var_1 = strtok(var_0, " ");
  return var_1;
}

_id_0B56(var_0, var_1) {
  if(isDefined(level._id_0B50[var_0])) {
    var_2 = level._id_0B50[var_0];
    var_3 = _id_0B55(var_2);
    var_4 = _id_0B55(var_1);

    foreach(var_6 in var_4) {
      foreach(var_8 in var_3) {
        if(var_6 == var_8) {
          return;
        }
      }
    }

    var_2 = var_2 + (" " + var_1);
    level._id_0B50[var_0] = var_2;
    return;
  }

  level._id_0B50[var_0] = var_1;
}

_id_0B57() {
  _id_0B58();
  _id_0B5A();
  _id_0B59();
  _id_0B5B();
  _id_0B5C();
  _id_0B5D();
  _id_0B5E();
  _id_0B5F();
  _id_0B60();
  _id_0B61();
  _id_0B62();
  _id_0B63();
  _id_0B64();
  _id_0B65();
  _id_0B66();
  _id_0B67();
  _id_0B6A();
}

_id_0B58() {
  _id_0B56("trigger_multiple_bcs_uk_building_1stfloor", "loc_1st_report");
  _id_0B56("trigger_multiple_bcs_uk_building_2ndfloor", "loc_2nd_report");
  _id_0B56("trigger_multiple_bcs_uk_building_1stfloor_door_left", "loc_door_1st_left_report");
  _id_0B56("trigger_multiple_bcs_uk_building_1stfloor_door", "loc_door_1st_report");
  _id_0B56("trigger_multiple_bcs_uk_building_1stfloor_door_right", "loc_door_1st_right_report");
  _id_0B56("trigger_multiple_bcs_uk_building_2ndfloor_door", "loc_door_2nd_report");
  _id_0B56("trigger_multiple_bcs_uk_building_door", "loc_door_report");
  _id_0B56("trigger_multiple_bcs_uk_building_1stfloor_window_left", "loc_wndw_1st_left_report");
  _id_0B56("trigger_multiple_bcs_uk_building_1stfloor_window", "loc_wndw_1st_report");
  _id_0B56("trigger_multiple_bcs_uk_building_1stfloor_window_right", "loc_wndw_1st_right_report");
  _id_0B56("trigger_multiple_bcs_uk_building_2ndfloor_window_left", "loc_wndw_2nd_left_report");
  _id_0B56("trigger_multiple_bcs_uk_building_2ndfloor_window", "loc_wndw_2nd_report");
  _id_0B56("trigger_multiple_bcs_uk_building_2ndfloor_window_right", "loc_wndw_2nd_right_report");
  _id_0B56("trigger_multiple_bcs_df_generic_callout_loc_door", "callout_loc_door_report");
  _id_0B56("trigger_multiple_bcs_df_generic_callout_loc_door_1st", "callout_loc_door_1st_report");
  _id_0B56("trigger_multiple_bcs_df_generic_callout_loc_door_1st_right", "callout_loc_door_1st_right_report");
  _id_0B56("trigger_multiple_bcs_df_generic_callout_loc_door_1st_left", "callout_loc_door_1st_left_report");
  _id_0B56("trigger_multiple_bcs_df_generic_callout_loc_door_2nd", "callout_loc_door_2nd_report");
  _id_0B56("trigger_multiple_bcs_df_generic_callout_loc_wndw_1st", "callout_loc_wndw_1st_report");
  _id_0B56("trigger_multiple_bcs_df_generic_callout_loc_wndw_1st_left", "callout_loc_wndw_1st_left_report");
  _id_0B56("trigger_multiple_bcs_df_generic_callout_loc_wndw_1st_right", "callout_loc_wndw_1st_right_report");
  _id_0B56("trigger_multiple_bcs_df_generic_callout_loc_1st", "callout_loc_1st_report");
  _id_0B56("trigger_multiple_bcs_df_generic_callout_loc_2nd", "callout_loc_2nd_report");
  _id_0B56("trigger_multiple_bcs_df_generic_callout_loc_wndw_2nd", "callout_loc_wndw_2nd_report");
  _id_0B56("trigger_multiple_bcs_df_generic_callout_loc_wndw_2nd_left", "callout_loc_wndw_2nd_left_report");
  _id_0B56("trigger_multiple_bcs_df_generic_callout_loc_wndw_2nd_right", "callout_loc_wndw_2nd_right_report");
  _id_0B56("trigger_multiple_bcs_df_generic_callout_loc_wndw_3rd", "callout_loc_wndw_3rd_report");
}

_id_0B59() {
  _id_0B56("trigger_multiple_bcs_df_generic_loc_ac_generic", "loc_ac_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_airdrop_generic", "loc_airdrop_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_alley_generic", "loc_alley_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_balcony_2nd", "loc_balcony_2nd");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_balcony_3rd", "loc_balcony_3rd");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_bank_generic", "loc_bank_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_bar_generic", "loc_bar_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_barrels_generic", "loc_barrels_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_barricade_generic", "loc_barricade_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_barrier_hesco", "loc_barrier_hesco");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_barrier_orange", "loc_barrier_orange");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_bin_recycle", "loc_bin_recycle");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_bookcase_generic", "loc_bookcase_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_building_red", "loc_building_red");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_bulkhead_generic", "loc_bulkhead_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_bunk_generic", "loc_bunk_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_bus_generic", "loc_bus_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_bus_inside", "loc_bus_inside");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_car_blue", "loc_car_blue");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_car_burning", "loc_car_burning");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_car_destroyed", "loc_car_destroyed");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_car_generic", "loc_car_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_car_green", "loc_car_green");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_car_overturned", "loc_car_overturned");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_car_parked", "loc_car_parked");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_car_police", "loc_car_police");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_car_yellow", "loc_car_yellow");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_catwalk_generic", "loc_catwalk_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_chair_blue", "loc_chair_blue");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_column_generic", "loc_column_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_console_generic", "loc_console_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_container_generic", "loc_container_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_container_red", "loc_container_red");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_couch_blue", "loc_couch_blue");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_couch_generic", "loc_couch_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_crates_ammo", "loc_crates_ammo");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_crates_generic", "loc_crates_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_cubicles_left", "loc_cubicles_left");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_cubicles_right", "loc_cubicles_right");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_deck_generic", "loc_deck_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_door_back", "loc_door_back");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_door_front", "loc_door_front");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_dumpster_generic", "loc_dumpster_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_embassy_1st", "loc_embassy_1st");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_embassy_3rd", "loc_embassy_3rd");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_engine_generic", "loc_engine_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_fan_exhaust", "loc_fan_exhaust");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_gate_generic", "loc_gate_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_hill_generic", "loc_hill_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_machine_copy", "loc_machine_copy");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_mg_generic", "loc_mg_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_patio_generic", "loc_patio_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_pipe_generic", "loc_pipe_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_planter_generic", "loc_planter_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_rack_bike", "loc_rack_bike");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_railing_generic", "loc_railing_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_ramp_down", "loc_ramp_down");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_rooftop_generic", "loc_rooftop_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_room_conf", "loc_room_conf");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_room_middle", "loc_room_middle");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_rubble_generic", "loc_rubble_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_sandbags_generic", "loc_sandbags_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_scaffolding_generic", "loc_scaffolding_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_car_black", "loc_car_black");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_shop_book", "loc_shop_book");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_shop_cafe", "loc_shop_cafe");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_shop_coffee", "loc_shop_coffee");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_shop_restaurant", "loc_shop_restaurant");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_shop_souvenir", "loc_shop_souvenir");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_staircase_generic", "loc_staircase_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_stairs_bottom", "loc_stairs_bottom");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_stairs_generic", "loc_stairs_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_stairs_top", "loc_stairs_top");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_stand_hotdog", "loc_stand_hotdog");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_stand_news", "loc_stand_news");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_stand_trading", "loc_stand_trading");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_statue_generic", "loc_statue_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_stryker_destroyed", "loc_stryker_destroyed");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_subway_entrance", "loc_subway_entrance");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_table_computer", "loc_table_computer");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_table_generic", "loc_table_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_tanks_generic", "loc_tanks_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_taxi_destroyed", "loc_taxi_destroyed");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_taxi_generic", "loc_taxi_generic");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_tires_large", "loc_tires_large");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_tower_jamming", "loc_tower_jamming");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_truck_white", "loc_truck_white");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_van_blue", "loc_van_blue");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_vehicle_btr", "loc_vehicle_btr");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_vehicle_dumptruck", "loc_vehicle_dumptruck");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_vehicle_gaz", "loc_vehicle_gaz");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_vehicle_hind", "loc_vehicle_hind");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_vehicle_snowcat", "loc_vehicle_snowcat");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_vehicle_snowmobile", "loc_vehicle_snowmobile");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_wall_low", "loc_wall_low");
  _id_0B56("trigger_multiple_bcs_df_generic_loc_water_cooler", "loc_water_cooler");
  _id_0B56("trigger_multiple_bcs_pc_generic_wndw_3rd", "callout_loc_wndw_3rd");
  _id_0B56("trigger_multiple_bcs_pc_generic_alley_generic", "loc_alley_generic");
  _id_0B56("trigger_multiple_bcs_pc_generic_arch_generic", "loc_arch_generic");
  _id_0B56("trigger_multiple_bcs_pc_generic_balcony_2nd", "loc_balcony_2nd");
  _id_0B56("trigger_multiple_bcs_pc_generic_balcony_3rd", "loc_balcony_3rd");
  _id_0B56("trigger_multiple_bcs_pc_generic_balcony_generic", "loc_balcony_generic");
  _id_0B56("trigger_multiple_bcs_pc_generic_barrels_generic", "loc_barrels_generic");
  _id_0B56("trigger_multiple_bcs_pc_generic_boat_wooden", "loc_boat_wooden");
  _id_0B56("trigger_multiple_bcs_pc_generic_car_burning", "loc_car_burning");
  _id_0B56("trigger_multiple_bcs_pc_generic_car_generic", "loc_car_generic");
  _id_0B56("trigger_multiple_bcs_pc_generic_car_green", "loc_car_green");
  _id_0B56("trigger_multiple_bcs_pc_generic_car_overturned", "loc_car_overturned");
  _id_0B56("trigger_multiple_bcs_pc_generic_car_yellow", "loc_car_yellow");
  _id_0B56("trigger_multiple_bcs_pc_generic_carport_generic", "loc_carport_generic");
  _id_0B56("trigger_multiple_bcs_pc_generic_cart_generic", "loc_cart_generic");
  _id_0B56("trigger_multiple_bcs_pc_generic_catwalk_generic", "loc_catwalk_generic");
  _id_0B56("trigger_multiple_bcs_pc_generic_container_cargo", "loc_container_cargo");
  _id_0B56("trigger_multiple_bcs_pc_generic_couch_generic", "loc_couch_generic");
  _id_0B56("trigger_multiple_bcs_pc_generic_counter_generic", "loc_counter_generic");
  _id_0B56("trigger_multiple_bcs_pc_generic_crates_ammo", "loc_crates_ammo");
  _id_0B56("trigger_multiple_bcs_pc_generic_crates_generic", "loc_crates_generic");
  _id_0B56("trigger_multiple_bcs_pc_generic_door_back", "loc_door_back");
  _id_0B56("trigger_multiple_bcs_pc_generic_door_front", "loc_door_front");
  _id_0B56("trigger_multiple_bcs_pc_generic_hull_3rd", "loc_hull_3rd");
  _id_0B56("trigger_multiple_bcs_pc_generic_market_stalls", "loc_market_stalls");
  _id_0B56("trigger_multiple_bcs_pc_generic_pier_far", "loc_pier_far");
  _id_0B56("trigger_multiple_bcs_pc_generic_pier_generic", "loc_pier_generic");
  _id_0B56("trigger_multiple_bcs_pc_generic_rock_big", "loc_rock_big");
  _id_0B56("trigger_multiple_bcs_pc_generic_rooftop_generic", "loc_rooftop_generic");
  _id_0B56("trigger_multiple_bcs_pc_generic_stairs_bottom", "loc_stairs_bottom");
  _id_0B56("trigger_multiple_bcs_pc_generic_stairs_generic", "loc_stairs_generic");
  _id_0B56("trigger_multiple_bcs_pc_generic_stairs_top", "loc_stairs_top");
  _id_0B56("trigger_multiple_bcs_pc_generic_tank_welding", "loc_tank_welding");
  _id_0B56("trigger_multiple_bcs_pc_generic_truck_white", "loc_truck_white");
  _id_0B56("trigger_multiple_bcs_pc_generic_wall_broken", "loc_wall_broken");
  _id_0B56("trigger_multiple_bcs_pc_generic_wall_generic", "loc_wall_generic");
  _id_0B56("trigger_multiple_bcs_tf_generic_1st", "callout_loc_1st");
  _id_0B56("trigger_multiple_bcs_tf_generic_2nd", "callout_loc_2nd");
  _id_0B56("trigger_multiple_bcs_tf_generic_door_1st_left", "callout_loc_door_1st_left");
  _id_0B56("trigger_multiple_bcs_tf_generic_door_1st_right", "callout_loc_door_1st_right");
  _id_0B56("trigger_multiple_bcs_tf_generic_door_1st", "callout_loc_door_1st");
  _id_0B56("trigger_multiple_bcs_tf_generic_door_2nd", "callout_loc_door_2nd");
  _id_0B56("trigger_multiple_bcs_tf_generic_door", "callout_loc_door");
  _id_0B56("trigger_multiple_bcs_tf_generic_wndw_1st_left", "callout_loc_wndw_1st_left");
  _id_0B56("trigger_multiple_bcs_tf_generic_wndw_1st_right", "callout_loc_wndw_1st_right");
  _id_0B56("trigger_multiple_bcs_tf_generic_wndw_1st", "callout_loc_wndw_1st");
  _id_0B56("trigger_multiple_bcs_tf_generic_wndw_2nd_left", "callout_loc_wndw_2nd_left");
  _id_0B56("trigger_multiple_bcs_tf_generic_wndw_2nd_right", "callout_loc_wndw_2nd_right");
  _id_0B56("trigger_multiple_bcs_tf_generic_wndw_2nd", "callout_loc_wndw_2nd");
  _id_0B56("trigger_multiple_bcs_tf_generic_container_cargo", "loc_container_cargo");
  _id_0B56("trigger_multiple_bcs_tf_generic_balcony_generic", "loc_balcony_generic");
  _id_0B56("trigger_multiple_bcs_tf_generic_boat_wooden", "loc_boat_wooden");
  _id_0B56("trigger_multiple_bcs_tf_generic_tanks_welding", "loc_tanks_welding");
  _id_0B56("trigger_multiple_bcs_tf_generic_carport_generic", "loc_carport_generic");
  _id_0B56("trigger_multiple_bcs_tf_generic_rock_big", "loc_rock_big");
  _id_0B56("trigger_multiple_bcs_tf_generic_wall_broken", "loc_wall_broken");
  _id_0B56("trigger_multiple_bcs_tf_generic_bin_trash", "loc_bin_trash");
  _id_0B56("trigger_multiple_bcs_tf_generic_fridge_generic", "loc_fridge_generic");
  _id_0B56("trigger_multiple_bcs_tf_generic_washing_machine", "loc_washing_machine");
  _id_0B56("trigger_multiple_bcs_tf_generic_tire_stack", "loc_tire_stack");
  _id_0B56("trigger_multiple_bcs_tf_generic_mattress_generic", "loc_mattress_generic");
  _id_0B56("trigger_multiple_bcs_tf_generic_umbrella_generic", "loc_umbrella_generic");
}

_id_0B5A() {}

_id_0B5B() {}

_id_0B5C() {
  _id_0B56("trigger_multiple_bcs_df_ny_manhattan_lm_memorial_building", "lm_memorial_building");
  _id_0B56("trigger_multiple_bcs_df_ny_manhattan_loc_cases_generic", "loc_cases_generic");
  _id_0B56("trigger_multiple_bcs_df_ny_manhattan_loc_cases_left", "loc_cases_left");
  _id_0B56("trigger_multiple_bcs_df_ny_manhattan_loc_cases_right", "loc_cases_right");
}

_id_0B5D() {
  _id_0B56("trigger_multiple_bcs_df_ny_harbor_loc_reactor_generic", "loc_reactor_generic");
}

_id_0B5E() {}

_id_0B5F() {
  _id_0B56("trigger_multiple_bcs_tf_warlord_church_generic", "loc_church_generic");
  _id_0B56("trigger_multiple_bcs_tf_warlord_shop_butcher", "loc_shop_butcher");
  _id_0B56("trigger_multiple_bcs_tf_warlord_shop_pharmacy", "loc_shop_pharmacy");
}

_id_0B60() {
  _id_0B56("trigger_multiple_bcs_uk_landmark_barrels", "loc_barrels_generic");
  _id_0B56("trigger_multiple_bcs_uk_landmark_barrier", "loc_barrier_generic");
  _id_0B56("trigger_multiple_bcs_uk_landmark_bulldozer", "loc_bulldozer_generic");
  _id_0B56("trigger_multiple_bcs_uk_vehicle_car_black", "loc_car_black");
  _id_0B56("trigger_multiple_bcs_uk_landmark_catwalk", "loc_catwalk_generic");
  _id_0B56("trigger_multiple_bcs_uk_landmark_cinder_blocks", "loc_cinder_blocks");
  _id_0B56("trigger_multiple_bcs_uk_landmark_container", "loc_container_generic");
  _id_0B56("trigger_multiple_bcs_uk_landmark_container_open", "loc_container_open");
  _id_0B56("trigger_multiple_bcs_uk_landmark_container_small", "loc_container_small");
  _id_0B56("trigger_multiple_bcs_uk_landmark_crate_blue", "loc_crate_blue");
  _id_0B56("trigger_multiple_bcs_uk_landmark_crate", "loc_crate_generic");
  _id_0B56("trigger_multiple_bcs_uk_landmark_dumpster_red", "loc_dumpster_red");
  _id_0B56("trigger_multiple_bcs_uk_landmark_flatbed", "loc_flatbed_generic");
  _id_0B56("trigger_multiple_bcs_uk_landmark_loading_bay", "loc_loading_bay");
  _id_0B56("trigger_multiple_bcs_uk_landmark_pipe_cement", "loc_pipe_cement");
  _id_0B56("trigger_multiple_bcs_uk_landmark_platform_left", "loc_platform_left");
  _id_0B56("trigger_multiple_bcs_uk_landmark_porta_john", "loc_porta_john");
  _id_0B56("trigger_multiple_bcs_uk_landmark_scaffolding", "loc_scaffolding_generic");
  _id_0B56("trigger_multiple_bcs_uk_landmark_stairs_down", "loc_stairs_down");
  _id_0B56("trigger_multiple_bcs_uk_landmark_stairs", "loc_stairs_generic");
  _id_0B56("trigger_multiple_bcs_uk_landmark_stairs_top", "loc_stairs_top");
  _id_0B56("trigger_multiple_bcs_uk_vehicle_truck_charity", "loc_truck_charity");
  _id_0B56("trigger_multiple_bcs_uk_vehicle_truck", "loc_truck_generic");
  _id_0B56("trigger_multiple_bcs_uk_vehicle_target", "loc_vehicle_target");
  _id_0B56("trigger_multiple_bcs_uk_landmark_wall_low", "loc_wall_low");
  _id_0B56("trigger_multiple_bcs_uk_landmark_warehouse", "loc_warehouse_generic");
  _id_0B56("trigger_multiple_bcs_uk_landmark_warehouse_south", "loc_warehouse_south");
  _id_0B56("trigger_multiple_bcs_uk_landmark_warehouse_west", "loc_warehouse_west");
}

_id_0B61() {
  _id_0B56("trigger_multiple_bcs_pc_payback_lm_building_tall", "lm_building_tall");
  _id_0B56("trigger_multiple_bcs_pc_payback_lm_building_white", "lm_building_white");
  _id_0B56("trigger_multiple_bcs_pc_payback_ship_cargo", "loc_ship_cargo");
  _id_0B56("trigger_multiple_bcs_pc_payback_shipwreck_generic", "loc_shipwreck_generic");
}

_id_0B62() {}

_id_0B63() {}

_id_0B64() {}

_id_0B65() {
  _id_0B56("trigger_multiple_bcs_df_parisAC130_lm_embassy", "lm_embassy");
  _id_0B56("trigger_multiple_bcs_df_parisAC130_lm_monument_courtyard", "lm_monument_courtyard");
  _id_0B56("trigger_multiple_bcs_df_parisAC130_loc_monument_top", "loc_monument_top");
}

_id_0B66() {
  _id_0B56("trigger_multiple_bcs_tf_prague_sign_large", "loc_sign_large");
  _id_0B56("trigger_multiple_bcs_tf_prague_car_white", "loc_car_white");
  _id_0B56("trigger_multiple_bcs_tf_prague_shops_east", "loc_shops_east");
  _id_0B56("trigger_multiple_bcs_tf_prague_btr_crashed", "loc_btr_crashed");
  _id_0B56("trigger_multiple_bcs_tf_prague_bldg_west", "loc_bldg_west");
  _id_0B56("trigger_multiple_bcs_tf_prague_cafe_tables", "loc_cafe_tables");
  _id_0B56("trigger_multiple_bcs_tf_prague_bldg_north", "loc_bldg_north");
  _id_0B56("trigger_multiple_bcs_tf_prague_antique_shop", "loc_antique_shop");
  _id_0B56("trigger_multiple_bcs_tf_prague_pillars", "loc_pillars");
  _id_0B56("trigger_multiple_bcs_tf_prague_barricades", "loc_barricades");
}

_id_0B67() {
  _id_0B56("trigger_multiple_bcs_df_berlin_lm_kitchen_back", "lm_kitchen_back");
}

_id_0B68() {}

_id_0B69() {
  _id_0B56("trigger_multiple_bcs_tf_rescue_snowcat_generic", "loc_snowcat_generic");
  _id_0B56("trigger_multiple_bcs_tf_rescue_dumptruck_generic", "loc_dumptruck_generic");
  _id_0B56("trigger_multiple_bcs_tf_rescue_building_red", "loc_building_red");
  _id_0B56("trigger_multiple_bcs_tf_rescue_snowmobile_generic", "loc_snowmobile_generic");
  _id_0B56("trigger_multiple_bcs_tf_rescue_scaffolding_generic", "loc_scaffolding_generic");
  _id_0B56("trigger_multiple_bcs_tf_rescue_container_red", "loc_container_red");
  _id_0B56("trigger_multiple_bcs_tf_rescue_tires_large", "loc_tires_large");
}

_id_0B6A() {
  _id_0B56("trigger_multiple_bcs_tf_dubai_arch_generic", "loc_arch_generic");
  _id_0B56("trigger_multiple_bcs_tf_dubai_bar", "loc_bar");
  _id_0B56("trigger_multiple_bcs_tf_dubai_barricades", "loc_barricades");
  _id_0B56("trigger_multiple_bcs_tf_dubai_car_generic", "loc_car_generic");
  _id_0B56("trigger_multiple_bcs_tf_dubai_chair_generic", "loc_chair_generic");
  _id_0B56("trigger_multiple_bcs_tf_dubai_couch_generic", "loc_couch_generic");
  _id_0B56("trigger_multiple_bcs_tf_dubai_counter_generic", "loc_counter_generic");
  _id_0B56("trigger_multiple_bcs_tf_dubai_doorway", "loc_doorway");
  _id_0B56("trigger_multiple_bcs_tf_dubai_escalator_coming_down", "loc_escalator_coming_down");
  _id_0B56("trigger_multiple_bcs_tf_dubai_escalator_near_right", "loc_escalator_near_right");
  _id_0B56("trigger_multiple_bcs_tf_dubai_escalator_near_left", "loc_escalator_near_left");
  _id_0B56("trigger_multiple_bcs_tf_dubai_escalator_top", "loc_escalator_top");
  _id_0B56("trigger_multiple_bcs_tf_dubai_fountain_generic", "loc_fountain_generic");
  _id_0B56("trigger_multiple_bcs_tf_dubai_lamppost_generic", "loc_lamppost_generic");
  _id_0B56("trigger_multiple_bcs_tf_dubai_pillar_generic", "loc_pillar_generic");
  _id_0B56("trigger_multiple_bcs_tf_dubai_pillar_left", "loc_pillar_left");
  _id_0B56("trigger_multiple_bcs_tf_dubai_pillar_right", "loc_pillar_right");
  _id_0B56("trigger_multiple_bcs_tf_dubai_planter_generic", "loc_planter_generic");
  _id_0B56("trigger_multiple_bcs_tf_dubai_sedan_generic", "loc_sedan_generic");
  _id_0B56("trigger_multiple_bcs_tf_dubai_suv_generic", "loc_suv_generic");
}