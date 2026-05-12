/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: common_scripts\_bcs_location_trigs.gsc
**************************************************/

func_1671() {
  if(isDefined(level.var_2A3D) && isDefined(level.var_1672)) {
    return;
  }

  level.var_166F = [];
  func_1670();
  func_1674();
  level.var_166F = undefined;
  anim.var_5E5E = [];
}

func_1674() {
  anim.var_1672 = [];
  var_00 = getEntArray();
  var_01 = [];
  foreach(var_03 in var_00) {
    if(isDefined(var_03.var_003A) && issubstr(var_03.var_003A, "trigger_multiple_bcs")) {
      var_01[var_01.size] = var_03;
    }
  }

  foreach(var_03 in var_01) {
    if(!isDefined(level.var_166F[var_03.var_003A])) {
      continue;
    }

    var_06 = func_6E89(level.var_166F[var_03.var_003A]);
    if(var_06.size > 1) {
      var_06 = common_scripts\utility::func_0F92(var_06);
    }

    var_03.var_5E5C = var_06;
  }

  anim.var_1672 = var_01;
}

func_6E89(param_00) {
  var_01 = strtok(param_00, " ");
  return var_01;
}

func_0903(param_00, param_01) {
  if(isDefined(level.var_166F[param_00])) {
    var_02 = level.var_166F[param_00];
    var_03 = func_6E89(var_02);
    var_04 = func_6E89(param_01);
    foreach(var_06 in var_04) {
      foreach(var_08 in var_03) {
        if(var_06 == var_08) {
          return;
        }
      }
    }

    var_02 = var_02 + " " + param_01;
    level.var_166F[param_00] = var_02;
    return;
  }

  level.var_166F[param_00] = param_01;
}

func_1670() {
  if(common_scripts\utility::func_57D7()) {
    func_6004();
    func_1D72();
    func_7C4F();
    func_674C();
    func_2483();
    func_9C1A();
    func_0812();
    func_4FF1();
    func_4D5F();
    func_95E3();
    func_6E81();
    func_402C();
    func_3F2C();
    return;
  }

  func_6506();
  func_64F6();
  func_64F2();
  func_64F5();
  func_64FC();
  func_6503();
  func_6505();
  func_64F4();
  func_64FB();
  func_64FA();
  func_64F9();
  func_A7FB();
  func_A7FA();
  func_5B06();
}

func_6004() {
  func_0903("trigger_multiple_bcs_mar_altar", "mar_altar");
  func_0903("trigger_multiple_bcs_mar_balcony", "mar_balcony");
  func_0903("trigger_multiple_bcs_mar_barrels", "mar_barrels");
  func_0903("trigger_multiple_bcs_mar_black_car", "mar_black_car");
  func_0903("trigger_multiple_bcs_mar_blue_car", "mar_blue_car");
  func_0903("trigger_multiple_mar_broken_roof", "mar_broken_roof");
  func_0903("trigger_multiple_bcs_mar_burning_wagon", "mar_burning_wagon");
  func_0903("trigger_multiple_bcs_mar_cart", "mar_cart");
  func_0903("trigger_multiple_bcs_mar_couch", "mar_couch");
  func_0903("trigger_multiple_bcs_mar_crate_stack", "mar_crate_stack");
  func_0903("trigger_multiple_bcs_mar_crater", "mar_crater");
  func_0903("trigger_multiple_bcs_mar_debris", "mar_debris");
  func_0903("trigger_multiple_bcs_mar_doorway", "mar_doorway");
  func_0903("trigger_multiple_bcs_mar_fallen_pillars", "mar_fallen_pillars");
  func_0903("trigger_multiple_bcs_mar_fallen_statues", "mar_fallen_statues");
  func_0903("trigger_multiple_bcs_mar_half_wall", "mar_half_wall");
  func_0903("trigger_multiple_bcs_mar_halftrack", "mar_halftrack");
  func_0903("trigger_multiple_bcs_mar_hedges", "mar_hedges");
  func_0903("trigger_multiple_bcs_mar_kubelwagon", "mar_kubelwagon");
  func_0903("trigger_multiple_bcs_mar_metal_gate", "mar_metal_gate");
  func_0903("trigger_multiple_bcs_mar_motorcycle", "mar_motorcycle");
  func_0903("trigger_multiple_bcs_mar_organ", "mar_organ");
  func_0903("trigger_multiple_bcs_mar_pews", "mar_pews");
  func_0903("trigger_multiple_bcs_mar_piano", "mar_piano");
  func_0903("trigger_multiple_bcs_mar_pillar", "mar_pillar");
  func_0903("trigger_multiple_bcs_mar_pillars", "mar_pillars");
  func_0903("trigger_multiple_bcs_mar_plane_wreckage", "mar_plane_wreckage");
  func_0903("trigger_multiple_bcs_mar_pulpit", "mar_pulpit");
  func_0903("trigger_multiple_bcs_mar_red_car", "mar_red_car");
  func_0903("trigger_multiple_bcs_mar_rubble", "mar_rubble");
  func_0903("trigger_multiple_bcs_mar_sandbags", "mar_sandbags");
  func_0903("trigger_multiple_bcs_mar_second_floor", "mar_second_floor");
  func_0903("trigger_multiple_bcs_mar_stairs", "mar_stairs");
  func_0903("trigger_multiple_bcs_mar_stone_wall", "mar_stone_wall");
  func_0903("trigger_multiple_bcs_mar_street", "mar_street");
  func_0903("trigger_multiple_bcs_mar_street_lamps", "mar_street_lamps");
  func_0903("trigger_multiple_bcs_mar_supply_crates", "mar_supply_crates");
  func_0903("trigger_multiple_bcs_mar_table", "mar_table");
  func_0903("trigger_multiple_bcs_mar_tree", "mar_tree");
  func_0903("trigger_multiple_bcs_mar_truck", "mar_truck");
  func_0903("trigger_multiple_bcs_mar_windows", "mar_windows");
  func_0903("trigger_multiple_bcs_mar_windows_second_floor", "mar_windows_second_floor");
  func_0903("trigger_multiple_bcs_mar_wooden_fence", "mar_wooden_fence");
  func_0903("trigger_multiple_bcs_mar_on_left", "mar_on_left");
  func_0903("trigger_multiple_bcs_mar_on_right", "mar_on_right");
}

func_1D72() {
  func_0903("trigger_multiple_bcs_bul_bush", "bul_bush");
  func_0903("trigger_multiple_bcs_bul_haybale", "bul_haybale");
  func_0903("trigger_multiple_bcs_bul_hedgerow", "bul_hedgerow");
  func_0903("trigger_multiple_bcs_bul_log", "bul_log");
  func_0903("trigger_multiple_bcs_bul_rock", "bul_rock");
  func_0903("trigger_multiple_bcs_bul_snowburm", "bul_snowburm");
  func_0903("trigger_multiple_bcs_bul_tree", "bul_tree");
  func_0903("trigger_multiple_bcs_bul_treeline", "bul_treeline");
}

func_7C4F() {
  func_0903("trigger_multiple_bcs_rem_arch", "rem_arch");
  func_0903("trigger_multiple_bcs_rem_barrels", "rem_barrels");
  func_0903("trigger_multiple_bcs_rem_cart", "rem_cart");
  func_0903("trigger_multiple_bcs_rem_column", "rem_column");
  func_0903("trigger_multiple_bcs_rem_crates", "rem_crates");
  func_0903("trigger_multiple_bcs_rem_generator", "rem_generator");
  func_0903("trigger_multiple_bcs_rem_gun", "rem_gun");
  func_0903("trigger_multiple_bcs_rem_jeep", "rem_jeep");
  func_0903("trigger_multiple_bcs_rem_motorcycle", "rem_motorcycle");
  func_0903("trigger_multiple_bcs_rem_rocks", "rem_rocks");
  func_0903("trigger_multiple_bcs_rem_sandbags", "rem_sandbags");
  func_0903("trigger_multiple_bcs_rem_switchboard", "rem_switchboard");
  func_0903("trigger_multiple_bcs_rem_table", "rem_table");
  func_0903("trigger_multiple_bcs_rem_tank", "rem_tank");
  func_0903("trigger_multiple_bcs_rem_wagon", "rem_wagon");
  func_0903("trigger_multiple_bcs_rem_woodpile", "rem_woodpile");
}

func_674C() {
  func_0903("trigger_multiple_bcs_ndy_above_bunker", "ndy_above_bunker");
  func_0903("trigger_multiple_bcs_ndy_barbed_wire", "ndy_barbed_wire");
  func_0903("trigger_multiple_bcs_ndy_barn_doors", "ndy_barn_doors");
  func_0903("trigger_multiple_bcs_ndy_barrel", "ndy_barrel");
  func_0903("trigger_multiple_bcs_ndy_burning_cart", "ndy_burning_cart");
  func_0903("trigger_multiple_bcs_ndy_bushes", "ndy_bushes");
  func_0903("trigger_multiple_bcs_ndy_pipes", "ndy_pipes");
  func_0903("trigger_multiple_bcs_ndy_radio_equipment", "ndy_radio_equipment");
  func_0903("trigger_multiple_bcs_ndy_artillery_gun", "ndy_artillery_gun");
  func_0903("trigger_multiple_bcs_ndy_mortar", "ndy_mortar");
  func_0903("trigger_multiple_bcs_ndy_wire_poles", "ndy_wire_poles");
  func_0903("trigger_multiple_bcs_ndy_crates", "ndy_crates");
  func_0903("trigger_multiple_bcs_ndy_haystack", "ndy_haystack");
  func_0903("trigger_multiple_bcs_ndy_alcove", "ndy_alcove");
  func_0903("trigger_multiple_bcs_ndy_stables", "ndy_stables");
  func_0903("trigger_multiple_bcs_ndy_metal_door", "ndy_metal_door");
  func_0903("trigger_multiple_bcs_ndy_murder_hole", "ndy_murder_hole");
  func_0903("trigger_multiple_bcs_ndy_plateau", "ndy_plateau");
  func_0903("trigger_multiple_bcs_ndy_pillar", "ndy_pillar");
  func_0903("trigger_multiple_bcs_ndy_sandbags", "ndy_sandbags");
  func_0903("trigger_multiple_bcs_ndy_shelves", "ndy_shelves");
  func_0903("trigger_multiple_bcs_ndy_table", "ndy_table");
  func_0903("trigger_multiple_bcs_ndy_trenches", "ndy_trenches");
  func_0903("trigger_multiple_bcs_ndy_upstairs_hole_in_barn", "ndy_upstairs_hole_in_barn");
  func_0903("trigger_multiple_bcs_ndy_wagon", "ndy_wagon");
  func_0903("trigger_multiple_bcs_ndy_wheelbarrow", "ndy_wheelbarrow");
  func_0903("trigger_multiple_bcs_ndy_barn_second_floor", "ndy_barn_second_floor");
  func_0903("trigger_multiple_bcs_ndy_beds", "ndy_beds");
  func_0903("trigger_multiple_bcs_ndy_black_car", "ndy_black_car");
  func_0903("trigger_multiple_bcs_ndy_brick_wall", "ndy_brick_wall");
  func_0903("trigger_multiple_bcs_ndy_bunker_entrance", "ndy_bunker_entrance");
  func_0903("trigger_multiple_bcs_ndy_generator", "ndy_generator");
  func_0903("trigger_multiple_bcs_ndy_lockers", "ndy_lockers");
  func_0903("trigger_multiple_bcs_ndy_logs", "ndy_logs");
  func_0903("trigger_multiple_bcs_ndy_outhouse", "ndy_outhouse");
  func_0903("trigger_multiple_bcs_ndy_red_car", "ndy_red_car");
  func_0903("trigger_multiple_bcs_ndy_tractor", "ndy_tractor");
  func_0903("trigger_multiple_bcs_ndy_white_car", "ndy_white_car");
}

func_2483() {
  func_0903("trigger_multiple_bcs_cob_barn_door", "cob_barn_door");
  func_0903("trigger_multiple_bcs_cob_barrel", "cob_near_barrel");
  func_0903("trigger_multiple_bcs_cob_troughs", "cob_troughs");
  func_0903("trigger_multiple_bcs_cob_wagon_wheel", "cob_wagon_wheel");
  func_0903("trigger_multiple_bcs_cob_car", "cob_car");
  func_0903("trigger_multiple_bcs_cob_crates", "cob_crates");
  func_0903("trigger_multiple_bcs_cob_flak_gun", "cob_flak_gun");
  func_0903("trigger_multiple_bcs_cob_haystack", "cob_haystack");
  func_0903("trigger_multiple_bcs_cob_crater", "cob_crater");
  func_0903("trigger_multiple_bcs_cob_jeep", "cob_jeep");
  func_0903("trigger_multiple_bcs_cob_log_pile", "cob_log_pile");
  func_0903("trigger_multiple_bcs_cob_milk_cans", "cob_milk_cans");
  func_0903("trigger_multiple_bcs_cob_wagon", "cob_wagon");
  func_0903("trigger_multiple_bcs_cob_sandbags", "cob_sandbags");
  func_0903("trigger_multiple_bcs_cob_shed", "cob_shed");
  func_0903("trigger_multiple_bcs_cob_tent", "cob_tent");
  func_0903("trigger_multiple_bcs_cob_tractor", "cob_tractor");
  func_0903("trigger_multiple_bcs_cob_windows", "cob_windows");
  func_0903("trigger_multiple_bcs_cob_large_haystack", "cob_large_haystack");
  func_0903("trigger_multiple_bcs_cob_small_haystack", "cob_small_haystack");
  func_0903("trigger_multiple_bcs_cob_shack", "cob_shack");
  func_0903("trigger_multiple_bcs_cob_stone_wall", "cob_stone_wall");
  func_0903("trigger_multiple_bcs_cob_destroyed_tractor", "cob_destroyed_tractor");
  func_0903("trigger_multiple_bcs_cob_barrels", "cob_barrels");
  func_0903("trigger_multiple_bcs_cob_blue_barrel", "cob_blue_barrel");
  func_0903("trigger_multiple_bcs_cob_burning_truck", "cob_burning_truck");
  func_0903("trigger_multiple_bcs_cob_destroyed_truck", "cob_destroyed_truck");
  func_0903("trigger_multiple_bcs_cob_sandbags", "cob_sandbags");
  func_0903("trigger_multiple_bcs_cob_on_aa_gun", "cob_on_aa_gun");
  func_0903("trigger_multiple_bcs_cob_pillboxes", "cob_pillboxes");
  func_0903("trigger_multiple_bcs_cob_barn_second_floor", "cob_barn_second_floor");
  func_0903("trigger_multiple_bcs_cob_hedgehogs", "cob_hedgehogs");
  func_0903("trigger_multiple_bcs_cob_gate", "cob_gate");
  func_0903("trigger_multiple_bcs_cob_cart", "cob_cart");
  func_0903("trigger_multiple_bcs_cob_field", "cob_field");
}

func_9C1A() {
  func_0903("trigger_multiple_bcs_tra_fuel_tank", "tra_fuel_tank");
  func_0903("trigger_multiple_bcs_tra_halftrack", "tra_halftrack");
  func_0903("trigger_multiple_bcs_tra_rocket", "tra_rocket");
  func_0903("trigger_multiple_bcs_tra_rocket_parts", "tra_rocket_parts");
  func_0903("trigger_multiple_bcs_tra_spotlight", "tra_spotlight");
  func_0903("trigger_multiple_bcs_tra_stairs", "tra_stairs");
  func_0903("trigger_multiple_bcs_tra_tank", "tra_tank");
  func_0903("trigger_multiple_bcs_tra_second_floor_balcony", "tra_second_floor_balcony");
  func_0903("trigger_multiple_bcs_tra_second_floor_catwalk", "tra_second_floor_catwalk");
  func_0903("trigger_multiple_bcs_tra_third_floor_balcony", "tra_third_floor_balcony");
  func_0903("trigger_multiple_bcs_tra_watch_tower", "tra_watch_tower");
  func_0903("trigger_multiple_bcs_tra_barrels", "tra_barrels");
  func_0903("trigger_multiple_bcs_tra_benches", "tra_benches");
  func_0903("trigger_multiple_bcs_tra_columns", "tra_columns");
  func_0903("trigger_multiple_bcs_tra_crane", "tra_crane");
  func_0903("trigger_multiple_bcs_tra_ditch", "tra_ditch");
  func_0903("trigger_multiple_bcs_tra_kubelwagon", "tra_kubelwagon");
  func_0903("trigger_multiple_bcs_tra_lumber", "tra_lumber");
  func_0903("trigger_multiple_bcs_tra_post_office", "tra_post_office");
  func_0903("trigger_multiple_bcs_tra_on_ramp", "tra_on_ramp");
  func_0903("trigger_multiple_bcs_tra_stone_wall", "tra_stone_wall");
  func_0903("trigger_multiple_bcs_tra_on_tracks", "tra_on_tracks");
  func_0903("trigger_multiple_bcs_tra_in_train_car", "tra_in_train_car");
  func_0903("trigger_multiple_bcs_tra_on_train_cars", "tra_on_train_cars");
  func_0903("trigger_multiple_bcs_tra_water_tower", "tra_water_tower");
  func_0903("trigger_multiple_bcs_tra_truck", "tra_truck");
  func_0903("trigger_multiple_bcs_tra_ridge", "tra_ridge");
}

func_0812() {
  func_0903("trigger_multiple_bcs_aac_above_across", "aac_above_across");
  func_0903("trigger_multiple_bcs_aac_apartments_left", "aac_apartments_left");
  func_0903("trigger_multiple_bcs_aac_apartments_right", "aac_apartments_right");
  func_0903("trigger_multiple_bcs_aac_at_bar", "aac_at_bar");
  func_0903("trigger_multiple_bcs_aac_main_staircase_bottom", "aac_main_staircase_bottom");
  func_0903("trigger_multiple_bcs_aac_side_staircase_bottom", "aac_side_staircase_bottom");
  func_0903("trigger_multiple_bcs_aac_main_staircase_top", "aac_main_staircase_top");
  func_0903("trigger_multiple_bcs_aac_back_of_garden", "aac_back_of_garden");
  func_0903("trigger_multiple_bcs_aac_couch", "aac_couch");
  func_0903("trigger_multiple_bcs_aac_stairs_bottom", "aac_stairs_bottom");
  func_0903("trigger_multiple_bcs_aac_by_bar", "aac_by_bar");
  func_0903("trigger_multiple_bcs_aac_fountain", "aac_fountain");
  func_0903("trigger_multiple_bcs_aac_mg_second_story", "aac_mg_second_story");
  func_0903("trigger_multiple_bcs_aac_statue", "aac_statue");
  func_0903("trigger_multiple_bcs_aac_down_street", "aac_down_street");
  func_0903("trigger_multiple_bcs_aac_hallway_door", "aac_hallway_door");
  func_0903("trigger_multiple_bcs_aac_apartments_across", "aac_apartments_across");
  func_0903("trigger_multiple_bcs_aac_back_hallway", "aac_back_hallway");
  func_0903("trigger_multiple_bcs_aac_back_street_left", "aac_back_street_left");
  func_0903("trigger_multiple_bcs_aac_back_street_right", "aac_back_street_right");
  func_0903("trigger_multiple_bcs_aac_buildings_across", "aac_buildings_across");
  func_0903("trigger_multiple_bcs_aac_in_garden", "aac_in_garden");
  func_0903("trigger_multiple_bcs_aac_hole_right", "aac_hole_right");
  func_0903("trigger_multiple_bcs_aac_kitchen_left", "aac_kitchen_left");
  func_0903("trigger_multiple_bcs_aac_in_street", "aac_in_street");
  func_0903("trigger_multiple_bcs_aac_in_apartments", "aac_in_apartments");
  func_0903("trigger_multiple_bcs_aac_left_of_plane", "aac_left_of_plane");
  func_0903("trigger_multiple_bcs_aac_near_back_hallway", "aac_near_back_hallway");
  func_0903("trigger_multiple_bcs_aac_on_main_staircase", "aac_on_main_staircase");
  func_0903("trigger_multiple_bcs_aac_on_the_right", "aac_on_the_right");
  func_0903("trigger_multiple_bcs_aac_on_side_staircase", "aac_on_side_staircase");
  func_0903("trigger_multiple_bcs_aac_right_of_plane", "aac_right_of_plane");
  func_0903("trigger_multiple_bcs_aac_second_story", "aac_second_story");
  func_0903("trigger_multiple_bcs_aac_straight_across", "aac_straight_across");
  func_0903("trigger_multiple_bcs_aac_third_story", "aac_third_story");
  func_0903("trigger_multiple_bcs_aac_under_plane_wing", "aac_under_plane_wing");
  func_0903("trigger_multiple_bcs_aac_under_side_staircase", "aac_under_side_staircase");
  func_0903("trigger_multiple_bcs_aac_up_in_building", "aac_up_in_building");
  func_0903("trigger_multiple_bcs_aac_upper_story", "aac_upper_story");
}

func_4FF1() {
  func_0903("trigger_multiple_bcs_hur_barbed_wire", "hur_barbed_wire");
  func_0903("trigger_multiple_bcs_hur_barn_doors", "hur_barn_doors");
  func_0903("trigger_multiple_bcs_hur_barn_windows", "hur_barn_windows");
  func_0903("trigger_multiple_bcs_hur_barrels", "hur_barrels");
  func_0903("trigger_multiple_bcs_hur_cabinets", "hur_cabinets");
  func_0903("trigger_multiple_bcs_hur_crates", "hur_crates");
  func_0903("trigger_multiple_bcs_hur_halftrack", "hur_halftrack");
  func_0903("trigger_multiple_bcs_hur_in_river", "hur_in_river");
  func_0903("trigger_multiple_bcs_hur_jeep", "hur_jeep");
  func_0903("trigger_multiple_bcs_hur_log", "hur_log");
  func_0903("trigger_multiple_bcs_hur_plateau", "hur_plateau");
  func_0903("trigger_multiple_bcs_hur_rocks_in_river", "hur_rocks_in_river");
  func_0903("trigger_multiple_bcs_hur_sandbags", "hur_sandbags");
  func_0903("trigger_multiple_bcs_hur_stables", "hur_stables");
  func_0903("trigger_multiple_bcs_hur_stacked_logs", "hur_stacked_logs");
  func_0903("trigger_multiple_bcs_hur_stairs", "hur_stairs");
  func_0903("trigger_multiple_bcs_hur_stump", "hur_stump");
  func_0903("trigger_multiple_bcs_hur_tables", "hur_tables");
  func_0903("trigger_multiple_bcs_hur_dragons_teeth", "hur_dragons_teeth");
  func_0903("trigger_multiple_bcs_hur_road", "hur_road");
  func_0903("trigger_multiple_bcs_hur_trenches_left", "hur_trenches_left");
  func_0903("trigger_multiple_bcs_hur_trenches_right", "hur_trenches_right");
  func_0903("trigger_multiple_bcs_hur_at_bridge", "hur_at_bridge");
  func_0903("trigger_multiple_bcs_hur_by_bridge", "hur_by_bridge");
  func_0903("trigger_multiple_bcs_hur_under_bridge", "hur_under_bridge");
  func_0903("trigger_multiple_bcs_hur_trucks", "hur_trucks");
  func_0903("trigger_multiple_bcs_hur_cliff", "hur_cliff");
  func_0903("trigger_multiple_bcs_hur_sawmill_second_floor_window", "hur_sawmill_second_floor_window");
  func_0903("trigger_multiple_bcs_hur_sawmill", "hur_sawmill");
  func_0903("trigger_multiple_bcs_hur_woodshed", "hur_woodshed");
  func_0903("trigger_multiple_bcs_hur_artillery_gun", "hur_artillery_gun");
  func_0903("trigger_multiple_bcs_hur_bottom_artillery_gun", "hur_bottom_artillery_gun");
  func_0903("trigger_multiple_bcs_hur_bunker", "hur_bunker");
  func_0903("trigger_multiple_bcs_hur_left_trench_top", "hur_left_trench_top");
  func_0903("trigger_multiple_bcs_hur_top_artillery_gun", "hur_top_artillery_gun");
  func_0903("trigger_multiple_bcs_hur_treeline", "hur_treeline");
  func_0903("trigger_multiple_bcs_hur_trench_bunker_in_back", "hur_trench_bunker_in_back");
  func_0903("trigger_multiple_bcs_hur_trenches", "hur_trenches");
}

func_4D5F() {
  func_0903("trigger_multiple_bcs_hil_alcove", "hil_alcove");
  func_0903("trigger_multiple_bcs_hil_barbed_wire", "hil_barbed_wire");
  func_0903("trigger_multiple_bcs_hil_barrel", "hil_barrel");
  func_0903("trigger_multiple_bcs_hil_boulder", "hil_boulder");
  func_0903("trigger_multiple_bcs_hil_bushes", "hil_bushes");
  func_0903("trigger_multiple_bcs_hil_broken_tree", "hil_broken_tree");
  func_0903("trigger_multiple_bcs_hil_windows", "hil_windows");
  func_0903("trigger_multiple_bcs_hil_crate", "hil_crate");
  func_0903("trigger_multiple_bcs_hil_doorway", "hil_doorway");
  func_0903("trigger_multiple_bcs_hil_log", "hil_log");
  func_0903("trigger_multiple_bcs_hil_stump", "hil_stump");
  func_0903("trigger_multiple_bcs_hil_ridge", "hil_ridge");
  func_0903("trigger_multiple_bcs_hil_artillery", "hil_artillery");
  func_0903("trigger_multiple_bcs_hil_artillery_bottom", "hil_artillery_bottom");
  func_0903("trigger_multiple_bcs_hil_bunker", "hil_bunker");
  func_0903("trigger_multiple_bcs_hil_left_trench_top", "hil_left_trench_top");
  func_0903("trigger_multiple_bcs_hil_artillery_top", "hil_artillery_top");
  func_0903("trigger_multiple_bcs_hil_treeline", "hil_treeline");
  func_0903("trigger_multiple_bcs_hil_trench_bunker_in_back", "hil_trench_bunker_in_back");
  func_0903("trigger_multiple_bcs_hil_trenches", "hil_trenches");
}

func_95E3() {
  func_0903("trigger_multiple_bcs_tak_aa_gun", "tak_aa_gun");
  func_0903("trigger_multiple_bcs_tak_ammo_boxes", "tak_ammo_boxes");
  func_0903("trigger_multiple_bcs_tak_balcony", "tak_balcony");
  func_0903("trigger_multiple_bcs_tak_barrel", "tak_barrel");
  func_0903("trigger_multiple_bcs_tak_bed", "tak_bed");
  func_0903("trigger_multiple_bcs_tak_bridge", "tak_bridge");
  func_0903("trigger_multiple_bcs_tak_closet", "tak_closet");
  func_0903("trigger_multiple_bcs_tak_crates", "tak_crates");
  func_0903("trigger_multiple_bcs_tak_doghouse", "tak_doghouse");
  func_0903("trigger_multiple_bcs_tak_dynamite", "tak_dynamite");
  func_0903("trigger_multiple_bcs_tak_fence", "tak_fence");
  func_0903("trigger_multiple_bcs_tak_generator", "tak_generator");
  func_0903("trigger_multiple_bcs_tak_guardhouse", "tak_guardhouse");
  func_0903("trigger_multiple_bcs_tak_halftrack", "tak_halftrack");
  func_0903("trigger_multiple_bcs_tak_hangar", "tak_hangar");
  func_0903("trigger_multiple_bcs_tak_kubelwagon", "tak_kubelwagon");
  func_0903("trigger_multiple_bcs_tak_oil_drum", "tak_oil_drum");
  func_0903("trigger_multiple_bcs_tak_plane", "tak_plane");
  func_0903("trigger_multiple_bcs_tak_plow", "tak_plow");
  func_0903("trigger_multiple_bcs_tak_post", "tak_post");
  func_0903("trigger_multiple_bcs_tak_riverbed", "tak_riverbed");
  func_0903("trigger_multiple_bcs_tak_rock", "tak_rock");
  func_0903("trigger_multiple_bcs_tak_shack", "tak_shack");
  func_0903("trigger_multiple_bcs_tak_sign", "tak_sign");
  func_0903("trigger_multiple_bcs_tak_snow_pile", "tak_snow_pile");
  func_0903("trigger_multiple_bcs_tak_stove", "tak_stove");
  func_0903("trigger_multiple_bcs_tak_tire_pile", "tak_tire_pile");
  func_0903("trigger_multiple_bcs_tak_tower", "tak_tower");
  func_0903("trigger_multiple_bcs_tak_tree", "tak_tree");
  func_0903("trigger_multiple_bcs_tak_truck", "tak_truck");
}

func_6E81() {
  func_0903("trigger_multiple_bcs_par_apc", "par_apc");
  func_0903("trigger_multiple_bcs_par_balcony", "par_balcony");
  func_0903("trigger_multiple_bcs_par_barrels", "par_barrels");
  func_0903("trigger_multiple_bcs_par_barricade", "par_barricade");
  func_0903("trigger_multiple_bcs_par_bridge", "par_bridge");
  func_0903("trigger_multiple_bcs_par_cafe", "par_cafe");
  func_0903("trigger_multiple_bcs_par_car", "par_car");
  func_0903("trigger_multiple_bcs_par_cart", "par_cart");
  func_0903("trigger_multiple_bcs_par_chair", "par_chair");
  func_0903("trigger_multiple_bcs_par_couch", "par_couch");
  func_0903("trigger_multiple_bcs_par_crates", "par_crates");
  func_0903("trigger_multiple_bcs_par_desk", "par_desk");
  func_0903("trigger_multiple_bcs_par_doorway", "par_doorway");
  func_0903("trigger_multiple_bcs_par_fence", "par_fence");
  func_0903("trigger_multiple_bcs_par_fountain", "par_fountain");
  func_0903("trigger_multiple_bcs_par_garrison", "par_garrison");
  func_0903("trigger_multiple_bcs_par_garrison_second_story", "par_garrison_second_story");
  func_0903("trigger_multiple_bcs_par_gate", "par_gate");
  func_0903("trigger_multiple_bcs_par_halftrack", "par_halftrack");
  func_0903("trigger_multiple_bcs_par_half_wall", "par_half_wall");
  func_0903("trigger_multiple_bcs_par_intersection", "par_intersection");
  func_0903("trigger_multiple_bcs_par_kubelwagon", "par_kubelwagon");
  func_0903("trigger_multiple_bcs_par_newsstand", "par_newsstand");
  func_0903("trigger_multiple_bcs_par_office", "par_office");
  func_0903("trigger_multiple_bcs_par_pillar", "par_pillar");
  func_0903("trigger_multiple_bcs_par_planter", "par_planter");
  func_0903("trigger_multiple_bcs_par_railing", "par_railing");
  func_0903("trigger_multiple_bcs_par_sandbags", "par_sandbags");
  func_0903("trigger_multiple_bcs_par_second_story", "par_second_story");
  func_0903("trigger_multiple_bcs_par_sidewalk", "par_sidewalk");
  func_0903("trigger_multiple_bcs_par_stairs", "par_stairs");
  func_0903("trigger_multiple_bcs_par_storage_tanks", "par_storage_tanks");
  func_0903("trigger_multiple_bcs_par_street", "par_street");
  func_0903("trigger_multiple_bcs_par_table", "par_table");
  func_0903("trigger_multiple_bcs_par_tent", "par_tent");
  func_0903("trigger_multiple_bcs_par_transport", "par_transport");
  func_0903("trigger_multiple_bcs_par_truck", "par_truck");
  func_0903("trigger_multiple_bcs_par_window", "par_window");
}

func_6506() {
  func_0903("trigger_multiple_bcs_mp_wolf_command_bunker", "mp_wolf_command_bunker");
  func_0903("trigger_multiple_bcs_mp_wolf_cabin", "mp_wolf_cabin");
  func_0903("trigger_multiple_bcs_mp_wolf_garage", "mp_wolf_garage");
  func_0903("trigger_multiple_bcs_mp_wolf_generator", "mp_wolf_generator");
  func_0903("trigger_multiple_bcs_mp_wolf_construction_site", "mp_wolf_construction_site");
  func_0903("trigger_multiple_bcs_mp_wolf_storage_bunker", "mp_wolf_storage_bunker");
  func_0903("trigger_multiple_bcs_mp_wolf_collapsed_bunker", "mp_wolf_collapsed_bunker");
  func_0903("trigger_multiple_bcs_mp_wolf_swamp", "mp_wolf_swamp");
  func_0903("trigger_multiple_bcs_mp_wolf_smokestack", "mp_wolf_smokestack");
  func_0903("trigger_multiple_bcs_mp_wolf_generator", "mp_wolf_generator");
  func_0903("trigger_multiple_bcs_mp_wolf_camo_netting", "mp_wolf_camo_netting");
  func_0903("trigger_multiple_bcs_mp_wolf_loading_dock", "mp_wolf_loading_dock");
  func_0903("trigger_multiple_bcs_mp_wolf_vehicles", "mp_wolf_vehicles");
  func_0903("trigger_multiple_bcs_mp_wolf_crater", "mp_wolf_crater");
  func_0903("trigger_multiple_bcs_mp_wolf_truck", "mp_wolf_truck");
  func_0903("trigger_multiple_bcs_mp_wolf_mg_nest", "mp_wolf_mg_nest");
  func_0903("trigger_multiple_bcs_mp_wolf_alley", "mp_wolf_alley");
}

func_64F6() {
  func_0903("trigger_multiple_bcs_mp_car_fence", "mp_car_fence");
  func_0903("trigger_multiple_bcs_mp_car_tavern", "mp_car_tavern");
  func_0903("trigger_multiple_bcs_mp_car_store", "mp_car_store");
  func_0903("trigger_multiple_bcs_mp_car_cafe", "mp_car_cafe");
  func_0903("trigger_multiple_bcs_mp_car_bombed_house", "mp_car_bombed_house");
  func_0903("trigger_multiple_bcs_mp_car_dirt_road", "mp_car_dirt_road");
  func_0903("trigger_multiple_bcs_mp_car_house", "mp_car_house");
  func_0903("trigger_multiple_bcs_mp_car_farm_house", "mp_car_farm_house");
  func_0903("trigger_multiple_bcs_mp_car_butcher_shop", "mp_car_butcher_shop");
  func_0903("trigger_multiple_bcs_mp_car_hay_bales", "mp_car_hay_bales");
  func_0903("trigger_multiple_bcs_mp_car_tow_truck", "mp_car_tow_truck");
  func_0903("trigger_multiple_bcs_mp_car_cart", "mp_car_cart");
  func_0903("trigger_multiple_bcs_mp_car_crater", "mp_car_crater");
  func_0903("trigger_multiple_bcs_mp_car_archway", "mp_car_archway");
  func_0903("trigger_multiple_bcs_mp_car_tank", "mp_car_tank");
  func_0903("trigger_multiple_bcs_mp_car_crates", "mp_car_crates");
  func_0903("trigger_multiple_bcs_mp_car_garden", "mp_car_garden");
  func_0903("trigger_multiple_bcs_mp_car_shed", "mp_car_shed");
  func_0903("trigger_multiple_bcs_mp_car_greenhouse", "mp_car_greenhouse");
  func_0903("trigger_multiple_bcs_mp_car_tree", "mp_car_tree");
  func_0903("trigger_multiple_bcs_mp_car_roadblock", "mp_car_roadblock");
  func_0903("trigger_multiple_bcs_mp_car_dresser", "mp_car_dresser");
  func_0903("trigger_multiple_bcs_mp_car_gate", "mp_car_gate");
  func_0903("trigger_multiple_bcs_mp_car_chicken_coop", "mp_car_chicken_coop");
  func_0903("trigger_multiple_bcs_mp_car_truck", "mp_car_truck");
  func_0903("trigger_multiple_bcs_mp_car_street", "mp_car_street");
}

func_64F2() {
  func_0903("trigger_multiple_bcs_mp_aac_apartments", "mp_aac_apartments");
  func_0903("trigger_multiple_bcs_mp_aac_bar", "mp_aac_bar");
  func_0903("trigger_multiple_bcs_mp_aac_theater", "mp_aac_theater");
  func_0903("trigger_multiple_bcs_mp_aac_trolley", "mp_aac_trolley");
  func_0903("trigger_multiple_bcs_mp_aac_sherman", "mp_aac_sherman");
  func_0903("trigger_multiple_bcs_mp_aac_truck", "mp_aac_truck");
  func_0903("trigger_multiple_bcs_mp_aac_halftrack", "mp_aac_halftrack");
  func_0903("trigger_multiple_bcs_mp_aac_motorcycle", "mp_aac_motorcycle");
  func_0903("trigger_multiple_bcs_mp_aac_sedan", "mp_aac_sedan");
  func_0903("trigger_multiple_bcs_mp_aac_upstairs_window", "mp_aac_upstairs_window");
  func_0903("trigger_multiple_bcs_mp_aac_downstairs_window", "mp_aac_downstairs_window");
  func_0903("trigger_multiple_bcs_mp_aac_window", "mp_aac_window");
  func_0903("trigger_multiple_bcs_mp_aac_library", "mp_aac_library");
  func_0903("trigger_multiple_bcs_mp_aac_tanks", "mp_aac_tanks");
  func_0903("trigger_multiple_bcs_mp_aac_stairwell", "mp_aac_stairwell");
  func_0903("trigger_multiple_bcs_mp_aac_columns", "mp_aac_columns");
  func_0903("trigger_multiple_bcs_mp_aac_couch", "mp_aac_couch");
  func_0903("trigger_multiple_bcs_mp_aac_crater", "mp_aac_crater");
  func_0903("trigger_multiple_bcs_mp_aac_sandbags", "mp_aac_sandbags");
}

func_64F5() {
  func_0903("trigger_multiple_bcs_mp_can_farm", "mp_can_farm");
  func_0903("trigger_multiple_bcs_mp_can_truck", "mp_can_truck");
  func_0903("trigger_multiple_bcs_mp_can_stables", "mp_can_stables");
  func_0903("trigger_multiple_bcs_mp_can_farmhouse", "mp_can_farmhouse");
  func_0903("trigger_multiple_bcs_mp_can_window", "mp_can_window");
  func_0903("trigger_multiple_bcs_mp_can_supply_road", "mp_can_supply_road");
  func_0903("trigger_multiple_bcs_mp_can_tractor", "mp_can_tractor");
  func_0903("trigger_multiple_bcs_mp_can_storeroom", "mp_can_storeroom");
  func_0903("trigger_multiple_bcs_mp_can_windmill", "mp_can_windmill");
  func_0903("trigger_multiple_bcs_mp_can_crane", "mp_can_crane");
  func_0903("trigger_multiple_bcs_mp_can_trains", "mp_can_trains");
  func_0903("trigger_multiple_bcs_mp_can_tunnel", "mp_can_tunnel");
  func_0903("trigger_multiple_bcs_mp_can_cannon_rear", "mp_can_cannon_rear");
  func_0903("trigger_multiple_bcs_mp_can_top_deck", "mp_can_top_deck");
  func_0903("trigger_multiple_bcs_mp_can_under_cannon", "mp_can_under_cannon");
  func_0903("trigger_multiple_bcs_mp_can_cannon_front", "mp_can_cannon_front");
  func_0903("trigger_multiple_bcs_mp_can_church", "mp_can_church");
  func_0903("trigger_multiple_bcs_mp_can_lumber_pile", "mp_can_lumber_pile");
  func_0903("trigger_multiple_bcs_mp_can_shack", "mp_can_shack");
  func_0903("trigger_multiple_bcs_mp_can_barnyard", "mp_can_barnyard");
  func_0903("trigger_multiple_bcs_mp_can_barn", "mp_can_barn");
}

func_64FC() {
  func_0903("trigger_multiple_bcs_mp_gib_high_ground", "mp_gib_high_ground");
  func_0903("trigger_multiple_bcs_mp_gib_security_station", "mp_gib_security_station");
  func_0903("trigger_multiple_bcs_mp_gib_cliff_bridge", "mp_gib_cliff_bridge");
  func_0903("trigger_multiple_bcs_mp_gib_upper_battery", "mp_gib_upper_battery");
  func_0903("trigger_multiple_bcs_mp_gib_cliff_rocks", "mp_gib_cliff_rocks");
  func_0903("trigger_multiple_bcs_mp_gib_tank", "mp_gib_tank");
  func_0903("trigger_multiple_bcs_mp_gib_platform", "mp_gib_platform");
  func_0903("trigger_multiple_bcs_mp_gib_tunnel", "mp_gib_tunnel");
  func_0903("trigger_multiple_bcs_mp_gib_com_trailer", "mp_gib_com_trailer");
  func_0903("trigger_multiple_bcs_mp_gib_garbage", "mp_gib_garbage");
  func_0903("trigger_multiple_bcs_mp_gib_window", "mp_gib_window");
  func_0903("trigger_multiple_bcs_mp_gib_checkpoint", "mp_gib_checkpoint");
  func_0903("trigger_multiple_bcs_mp_gib_balcony", "mp_gib_balcony");
  func_0903("trigger_multiple_bcs_mp_gib_tower_balcony", "mp_gib_tower_balcony");
  func_0903("trigger_multiple_bcs_mp_gib_fort_balcony", "mp_gib_fort_balcony");
  func_0903("trigger_multiple_bcs_mp_gib_center_bridge", "mp_gib_center_bridge");
  func_0903("trigger_multiple_bcs_mp_gib_under_bridge", "mp_gib_under_bridge");
  func_0903("trigger_multiple_bcs_mp_gib_stairs", "mp_gib_stairs");
  func_0903("trigger_multiple_bcs_mp_gib_shed", "mp_gib_shed");
  func_0903("trigger_multiple_bcs_mp_gib_com_room", "mp_gib_com_room");
  func_0903("trigger_multiple_bcs_mp_gib_courtyard", "mp_gib_courtyard");
  func_0903("trigger_multiple_bcs_mp_gib_turret", "mp_gib_turret");
  func_0903("trigger_multiple_bcs_mp_gib_boulder", "mp_gib_boulder");
}

func_6503() {
  func_0903("trigger_multiple_bcs_mp_lon_dock_gate", "mp_lon_dock_gate");
  func_0903("trigger_multiple_bcs_mp_lon_wrecked_crane", "mp_lon_wrecked_crane");
  func_0903("trigger_multiple_bcs_mp_lon_underground", "mp_lon_underground");
  func_0903("trigger_multiple_bcs_mp_lon_office", "mp_lon_office");
  func_0903("trigger_multiple_bcs_mp_lon_station", "mp_lon_station");
  func_0903("trigger_multiple_bcs_mp_lon_dock_house", "mp_lon_dock_house");
  func_0903("trigger_multiple_bcs_mp_lon_barges", "mp_lon_barges");
  func_0903("trigger_multiple_bcs_mp_lon_statue", "mp_lon_statue");
  func_0903("trigger_multiple_bcs_mp_lon_street", "mp_lon_street");
  func_0903("trigger_multiple_bcs_mp_lon_warehouse", "mp_lon_warehouse");
  func_0903("trigger_multiple_bcs_mp_lon_bus", "mp_lon_bus");
  func_0903("trigger_multiple_bcs_mp_lon_courtyard", "mp_lon_courtyard");
  func_0903("trigger_multiple_bcs_mp_lon_crane", "mp_lon_crane");
  func_0903("trigger_multiple_bcs_mp_lon_collapsed_building", "mp_lon_collapsed_building");
  func_0903("trigger_multiple_bcs_mp_lon_ramp", "mp_lon_ramp");
  func_0903("trigger_multiple_bcs_mp_lon_garage", "mp_lon_garage");
  func_0903("trigger_multiple_bcs_mp_lon_storeroom", "mp_lon_storeroom");
  func_0903("trigger_multiple_bcs_mp_lon_cargo", "mp_lon_cargo");
  func_0903("trigger_multiple_bcs_mp_lon_window", "mp_lon_window");
  func_0903("trigger_multiple_bcs_mp_lon_truck", "mp_lon_truck");
  func_0903("trigger_multiple_bcs_mp_lon_gate", "mp_lon_gate");
  func_0903("trigger_multiple_bcs_mp_lon_hallway", "mp_lon_hallway");
  func_0903("trigger_multiple_bcs_mp_lon_ambulance", "mp_lon_ambulance");
  func_0903("trigger_multiple_bcs_mp_lon_barrels", "mp_lon_barrels");
}

func_6505() {
  func_0903("trigger_multiple_bcs_mp_vil_crash_site", "mp_vil_crash_site");
  func_0903("trigger_multiple_bcs_mp_vil_glider", "mp_vil_glider");
  func_0903("trigger_multiple_bcs_mp_vil_jeep", "mp_vil_jeep");
  func_0903("trigger_multiple_bcs_mp_vil_barrels", "mp_vil_barrels");
  func_0903("trigger_multiple_bcs_mp_vil_hay_bales", "mp_vil_hay_bales");
  func_0903("trigger_multiple_bcs_mp_vil_wall", "mp_vil_wall");
  func_0903("trigger_multiple_bcs_mp_vil_supply_crates", "mp_vil_supply_crates");
  func_0903("trigger_multiple_bcs_mp_vil_treeline", "mp_vil_treeline");
  func_0903("trigger_multiple_bcs_mp_vil_tractor", "mp_vil_tractor");
  func_0903("trigger_multiple_bcs_mp_vil_stables", "mp_vil_stables");
  func_0903("trigger_multiple_bcs_mp_vil_map_room", "mp_vil_map_room");
  func_0903("trigger_multiple_bcs_mp_vil_near_map_room", "mp_vil_near_map_room");
  func_0903("trigger_multiple_bcs_mp_vil_north_road", "mp_vil_north_road");
  func_0903("trigger_multiple_bcs_mp_vil_headquarters", "mp_vil_headquarters");
  func_0903("trigger_multiple_bcs_mp_vil_bar", "mp_vil_bar");
  func_0903("trigger_multiple_bcs_mp_vil_city_hall", "mp_vil_city_hall");
  func_0903("trigger_multiple_bcs_mp_vil_trenches", "mp_vil_trenches");
  func_0903("trigger_multiple_bcs_mp_vil_backlot", "mp_vil_backlot");
  func_0903("trigger_multiple_bcs_mp_vil_restaurant", "mp_vil_restaurant");
  func_0903("trigger_multiple_bcs_mp_vil_south_road", "mp_vil_south_road");
  func_0903("trigger_multiple_bcs_mp_vil_butcher", "mp_vil_butcher");
  func_0903("trigger_multiple_bcs_mp_vil_pastry", "mp_vil_pastry");
  func_0903("trigger_multiple_bcs_mp_vil_cafe", "mp_vil_cafe");
  func_0903("trigger_multiple_bcs_mp_vil_barracks", "mp_vil_barracks");
  func_0903("trigger_multiple_bcs_mp_vil_munitions_storage", "mp_vil_munitions_storage");
  func_0903("trigger_multiple_bcs_mp_vil_officers_quarters", "mp_vil_officers_quarters");
  func_0903("trigger_multiple_bcs_mp_vil_small_lot", "mp_vil_small_lot");
  func_0903("trigger_multiple_bcs_mp_vil_artillery_gun_north", "mp_vil_artillery_gun_north");
  func_0903("trigger_multiple_bcs_mp_vil_artillery_gun_south", "mp_vil_artillery_gun_south");
  func_0903("trigger_multiple_bcs_mp_vil_ruins", "mp_vil_ruins");
  func_0903("trigger_multiple_bcs_mp_vil_tank", "mp_vil_tank");
  func_0903("trigger_multiple_bcs_mp_vil_courtyard", "mp_vil_courtyard");
  func_0903("trigger_multiple_bcs_mp_vil_creperie", "mp_vil_creperie");
  func_0903("trigger_multiple_bcs_mp_vil_south_avenue", "mp_vil_south_avenue");
  func_0903("trigger_multiple_bcs_mp_vil_avenue_north", "mp_vil_avenue_north");
  func_0903("trigger_multiple_bcs_mp_vil_bakery", "mp_vil_bakery");
  func_0903("trigger_multiple_bcs_mp_vil_car_lot", "mp_vil_car_lot");
  func_0903("trigger_multiple_bcs_mp_vil_shed", "mp_vil_shed");
}

func_64F4() {
  func_0903("trigger_multiple_bcs_mp_bat_port_deck", "mp_bat_port_deck");
  func_0903("trigger_multiple_bcs_mp_bat_stairs", "mp_bat_stairs");
  func_0903("trigger_multiple_bcs_mp_bat_upper_deck", "mp_bat_upper_deck");
  func_0903("trigger_multiple_bcs_mp_bat_stern", "mp_bat_stern");
  func_0903("trigger_multiple_bcs_mp_bat_tower", "mp_bat_tower");
  func_0903("trigger_multiple_bcs_mp_bat_smoke_stack", "mp_bat_smoke_stack");
  func_0903("trigger_multiple_bcs_mp_bat_porthole", "mp_bat_porthole");
  func_0903("trigger_multiple_bcs_mp_bat_bridge", "mp_bat_bridge");
  func_0903("trigger_multiple_bcs_mp_bat_galley", "mp_bat_galley");
  func_0903("trigger_multiple_bcs_mp_bat_forward_turret", "mp_bat_forward_turret");
  func_0903("trigger_multiple_bcs_mp_bat_anchor_room", "mp_bat_anchor_room");
  func_0903("trigger_multiple_bcs_mp_bat_bow", "mp_bat_bow");
  func_0903("trigger_multiple_bcs_mp_bat_starboard_deck", "mp_bat_starboard_deck");
  func_0903("trigger_multiple_bcs_mp_bat_winch", "mp_bat_winch");
  func_0903("trigger_multiple_bcs_mp_bat_lifeboats", "mp_bat_lifeboats");
  func_0903("trigger_multiple_bcs_mp_bat_aa_gun", "mp_bat_aa_gun");
}

func_64FB() {
  func_0903("trigger_multiple_bcs_mp_for_bunker", "mp_for_bunker");
  func_0903("trigger_multiple_bcs_mp_for_window", "mp_for_window");
  func_0903("trigger_multiple_bcs_mp_for_creek", "mp_for_creek");
  func_0903("trigger_multiple_bcs_mp_for_cabin", "mp_for_cabin");
  func_0903("trigger_multiple_bcs_mp_for_log_wall", "mp_for_log_wall");
  func_0903("trigger_multiple_bcs_mp_for_armory", "mp_for_armory");
  func_0903("trigger_multiple_bcs_mp_for_tank", "mp_for_tank");
  func_0903("trigger_multiple_bcs_mp_for_bell", "mp_for_bell");
  func_0903("trigger_multiple_bcs_mp_for_road", "mp_for_road");
  func_0903("trigger_multiple_bcs_mp_for_tank_fire", "mp_for_tank_fire");
  func_0903("trigger_multiple_bcs_mp_for_truck", "mp_for_truck");
  func_0903("trigger_multiple_bcs_mp_for_on_bridge", "mp_for_on_bridge");
  func_0903("trigger_multiple_bcs_mp_for_under_bridge", "mp_for_under_bridge");
  func_0903("trigger_multiple_bcs_mp_for_halftack", "mp_for_halftack");
  func_0903("trigger_multiple_bcs_mp_for_ruins", "mp_for_ruins");
  func_0903("trigger_multiple_bcs_mp_for_arch", "mp_for_arch");
  func_0903("trigger_multiple_bcs_mp_for_fallen_pillar", "mp_for_fallen_pillar");
  func_0903("trigger_multiple_bcs_mp_for_balcony", "mp_for_balcony");
  func_0903("trigger_multiple_bcs_mp_for_statue", "mp_for_statue");
}

func_64FA() {
  func_0903("trigger_multiple_bcs_mp_flak_aa_gun", "mp_flak_aa_gun");
  func_0903("trigger_multiple_bcs_mp_flak_aid_station", "mp_flak_aid_station");
  func_0903("trigger_multiple_bcs_mp_flak_tunnel", "mp_flak_tunnel");
  func_0903("trigger_multiple_bcs_mp_flak_radio_room", "mp_flak_radio_room");
  func_0903("trigger_multiple_bcs_mp_flak_searchlight", "mp_flak_searchlight");
  func_0903("trigger_multiple_bcs_mp_flak_elevator", "mp_flak_elevator");
  func_0903("trigger_multiple_bcs_mp_flak_electrical_box", "mp_flak_electrical_box");
  func_0903("trigger_multiple_bcs_mp_flak_window", "mp_flak_window");
  func_0903("trigger_multiple_bcs_mp_flak_center_elevator", "mp_flak_center_elevator");
  func_0903("trigger_multiple_bcs_mp_flak_lumber_pile", "mp_flak_lumber_pile");
  func_0903("trigger_multiple_bcs_mp_flak_signals_office", "mp_flak_signals_office");
  func_0903("trigger_multiple_bcs_mp_flak_antenna", "mp_flak_antenna");
  func_0903("trigger_multiple_bcs_mp_flak_armory", "mp_flak_armory");
  func_0903("trigger_multiple_bcs_mp_flak_overlook", "mp_flak_overlook");
  func_0903("trigger_multiple_bcs_mp_flak_scaffold", "mp_flak_scaffold");
  func_0903("trigger_multiple_bcs_mp_flak_crane", "mp_flak_crane");
  func_0903("trigger_multiple_bcs_mp_flak_engine_room", "mp_flak_engine_room");
}

func_64F9() {
  func_0903("trigger_multiple_bcs_mp_dday_barn", "mp_dday_barn");
  func_0903("trigger_multiple_bcs_mp_dday_hay_bale", "mp_dday_hay_bale");
  func_0903("trigger_multiple_bcs_mp_dday_hay_stack", "mp_dday_hay_stack");
  func_0903("trigger_multiple_bcs_mp_dday_window", "mp_dday_window");
  func_0903("trigger_multiple_bcs_mp_dday_farmhouse", "mp_dday_farmhouse");
  func_0903("trigger_multiple_bcs_mp_dday_window_upstairs", "mp_dday_window_upstairs");
  func_0903("trigger_multiple_bcs_mp_dday_window_downstairs", "mp_dday_window_downstairs");
  func_0903("trigger_multiple_bcs_mp_dday_wagon", "mp_dday_wagon");
  func_0903("trigger_multiple_bcs_mp_dday_trench", "mp_dday_trench");
  func_0903("trigger_multiple_bcs_mp_dday_bunker", "mp_dday_bunker");
  func_0903("trigger_multiple_bcs_mp_dday_crater", "mp_dday_crater");
  func_0903("trigger_multiple_bcs_mp_dday_plane_wreck", "mp_dday_plane_wreck");
  func_0903("trigger_multiple_bcs_mp_dday_pillboxes", "mp_dday_pillboxes");
  func_0903("trigger_multiple_bcs_mp_dday_metal_bunker", "mp_dday_metal_bunker");
  func_0903("trigger_multiple_bcs_mp_dday_radar_bunker", "mp_dday_radar_bunker");
  func_0903("trigger_multiple_bcs_mp_dday_balcony", "mp_dday_balcony");
  func_0903("trigger_multiple_bcs_mp_dday_aa_gun", "mp_dday_aa_gun");
  func_0903("trigger_multiple_bcs_mp_dday_east_bunker", "mp_dday_east_bunker");
  func_0903("trigger_multiple_bcs_mp_dday_armory", "mp_dday_armory");
}

func_A7FB() {
  func_0903("trigger_multiple_bcs_war_cob_command_post", "mp_war_cobra_command_post");
  func_0903("trigger_multiple_bcs_war_cob_barn", "mp_war_cobra_barn");
  func_0903("trigger_multiple_bcs_war_cob_trench", "mp_war_cobra_trenches");
  func_0903("trigger_multiple_bcs_war_cob_creek", "mp_war_cobra_creek");
  func_0903("trigger_multiple_bcs_war_cob_bridge", "mp_war_cobra_bridge");
  func_0903("trigger_multiple_bcs_war_cob_ammo_dump", "mp_war_cobra_ammo_dump");
  func_0903("trigger_multiple_bcs_war_cob_radar_station", "mp_war_cobra_radar");
  func_0903("trigger_multiple_bcs_war_cob_church", "mp_war_cobra_church");
  func_0903("trigger_multiple_bcs_war_cob_stables", "mp_war_cobra_stables");
  func_0903("trigger_multiple_bcs_war_cob_courtyard", "mp_war_cobra_courtyard");
  func_0903("trigger_multiple_bcs_war_cob_road", "mp_war_cobra_road");
  func_0903("trigger_multiple_bcs_war_cob_house_overwatch", "mp_war_cobra_overwatch");
  func_0903("trigger_multiple_bcs_war_cob_alley", "mp_war_cobra_alley");
  func_0903("trigger_multiple_bcs_war_cob_garden", "mp_war_cobra_garden");
  func_0903("trigger_multiple_bcs_war_cob_warehouse", "mp_war_cobra_warehouse");
  func_0903("trigger_multiple_bcs_war_cob_garage", "mp_war_cobra_garage");
  func_0903("trigger_multiple_bcs_war_cob_field", "mp_war_cobra_field");
  func_0903("trigger_multiple_bcs_war_cob_pasture", "mp_war_cobra_pasture");
}

func_A7FA() {
  func_0903("trigger_multiple_bcs_war_bul_allied_camp", "mp_war_bulge_allied_camp");
  func_0903("trigger_multiple_bcs_war_bul_allied_trucks", "mp_war_bulge_allied_trucks");
  func_0903("trigger_multiple_bcs_war_bul_bridge", "mp_war_bulge_bridge");
  func_0903("trigger_multiple_bcs_war_bul_camp_houses", "mp_war_bulge_camp_houses");
  func_0903("trigger_multiple_bcs_war_bul_castle_arch", "mp_war_bulge_castle_arch");
  func_0903("trigger_multiple_bcs_war_bul_castle_ruins", "mp_war_bulge_castle_ruins");
  func_0903("trigger_multiple_bcs_war_bul_castle_turret", "mp_war_bulge_castle_turret");
  func_0903("trigger_multiple_bcs_war_bul_embankment", "mp_war_bulge_embankment");
  func_0903("trigger_multiple_bcs_war_bul_fuel_truck", "mp_war_bulge_fuel_truck");
  func_0903("trigger_multiple_bcs_war_bul_log_walls", "mp_war_bulge_log_walls");
  func_0903("trigger_multiple_bcs_war_bul_panzer", "mp_war_bulge_panzer");
  func_0903("trigger_multiple_bcs_war_bul_quonset_huts", "mp_war_bulge_quonset_huts");
  func_0903("trigger_multiple_bcs_war_bul_road", "mp_war_bulge_road");
  func_0903("trigger_multiple_bcs_war_bul_rocks", "mp_war_bulge_rocks");
  func_0903("trigger_multiple_bcs_war_bul_sherman_tanks", "mp_war_bulge_sherman_tanks");
  func_0903("trigger_multiple_bcs_war_bul_trees", "mp_war_bulge_trees");
  func_0903("trigger_multiple_bcs_war_bul_trenches", "mp_war_bulge_trenches");
  func_0903("trigger_multiple_bcs_war_bul_watch_tower", "mp_war_bulge_watch_tower");
}

func_402C() {
  func_0903("trigger_multiple_bcs_generic_doorway_generic", "doorway_generic");
  func_0903("trigger_multiple_bcs_generic_window_generic", "window_generic");
  func_0903("trigger_multiple_bcs_generic_1stfloor_generic", "1stfloor_generic");
  func_0903("trigger_multiple_bcs_generic_1stfloor_doorway", "1stfloor_doorway");
  func_0903("trigger_multiple_bcs_generic_1stfloor_window", "1stfloor_window");
  func_0903("trigger_multiple_bcs_generic_2ndfloor_generic", "2ndfloor_generic");
  func_0903("trigger_multiple_bcs_generic_2ndfloor_window", "2ndfloor_window");
  func_0903("trigger_multiple_bcs_generic_rooftop", "rooftop");
  func_0903("trigger_multiple_bcs_generic_2ndfloor_balcony", "2ndfloor_balcony");
}

func_3F2C() {
  func_0903("trigger_multiple_bcs_fus_truck", "fus_truck");
  func_0903("trigger_multiple_bcs_fus_tower", "fus_tower");
  func_0903("trigger_multiple_bcs_fus_generator", "fus_generator");
  func_0903("trigger_multiple_bcs_fus_mt", "fus_mt");
  func_0903("trigger_multiple_bcs_fus_titan", "fus_titan");
  func_0903("trigger_multiple_bcs_fus_hill", "fus_hill");
  func_0903("trigger_multiple_bcs_fus_garage", "fus_garage");
  func_0903("trigger_multiple_bcs_fus_crane", "fus_crane");
  func_0903("trigger_multiple_bcs_fus_forklift", "fus_forklift");
  func_0903("trigger_multiple_bcs_fus_pillar", "fus_pillar");
  func_0903("trigger_multiple_bcs_fus_pipes", "fus_pipes");
  func_0903("trigger_multiple_bcs_fus_balcony", "fus_balcony");
  func_0903("trigger_multiple_bcs_fus_catwalk", "fus_catwalk");
  func_0903("trigger_multiple_bcs_fus_fueltrucks", "fus_fueltrucks");
  func_0903("trigger_multiple_bcs_fus_walkway", "fus_walkway");
  func_0903("trigger_multiple_bcs_fus_stairs", "fus_stairs");
}

func_5B06() {
  func_0903("trigger_multiple_bcs_mp_lsr_radardish", "lsr_radardish");
  func_0903("trigger_multiple_bcs_mp_lsr_laserairdefensegun", "lsr_laserairdefensegun");
  func_0903("trigger_multiple_bcs_mp_lsr_razorback", "lsr_razorback");
  func_0903("trigger_multiple_bcs_mp_lsr_underhelipad", "lsr_underhelipad");
  func_0903("trigger_multiple_bcs_mp_lsr_bunkerlookout", "lsr_bunkerlookout");
  func_0903("trigger_multiple_bcs_mp_lsr_inradartower", "lsr_inradartower");
  func_0903("trigger_multiple_bcs_mp_lsr_byradartower", "lsr_byradartower");
  func_0903("trigger_multiple_bcs_mp_lsr_shippingcontainer", "lsr_shippingcontainer");
  func_0903("trigger_multiple_bcs_mp_lsr_onhelipad", "lsr_onhelipad");
  func_0903("trigger_multiple_bcs_mp_lsr_onbeach", "lsr_onbeach");
  func_0903("trigger_multiple_bcs_mp_lsr_onbeach", "lsr_bybridge");
  func_0903("trigger_multiple_bcs_mp_lsr_bylasergenerator", "lsr_bylasergenerator");
  func_0903("trigger_multiple_bcs_mp_lsr_underlaser", "lsr_underlaser");
  func_0903("trigger_multiple_bcs_mp_lsr_byhelipad", "lsr_byhelipad");
  func_0903("trigger_multiple_bcs_mp_lsr_electricalroom", "lsr_electricalroom");
  func_0903("trigger_multiple_bcs_mp_lsr_piperoom", "lsr_piperoom");
  func_0903("trigger_multiple_bcs_mp_lsr_bybuoy", "lsr_bybuoy");
  func_0903("trigger_multiple_bcs_mp_lsr_bygenerator", "lsr_bygenerator");
  func_0903("trigger_multiple_bcs_mp_lsr_offswitch", "lsr_offswitch");
  func_0903("trigger_multiple_bcs_mp_lsr_missilerack", "lsr_missilerack");
  func_0903("trigger_multiple_bcs_mp_lsr_underchains", "lsr_underchains");
  func_0903("trigger_multiple_bcs_mp_lsr_beachbunkerrooftop", "lsr_beachbunkerrooftop");
  func_0903("trigger_multiple_bcs_mp_lsr_bunkerrooftop", "lsr_bunkerrooftop");
  func_0903("trigger_multiple_bcs_mp_lsr_nettedcargo", "lsr_nettedcargo");
  func_0903("trigger_multiple_bcs_mp_lsr_cagedcargo", "lsr_cagedcargo");
  func_0903("trigger_multiple_bcs_mp_lsr_overturnedcar", "lsr_overturnedcar");
  func_0903("trigger_multiple_bcs_mp_lsr_bridgebase", "lsr_bridgebase");
  func_0903("trigger_multiple_bcs_mp_lsr_cornerbunker", "lsr_cornerbunker");
}