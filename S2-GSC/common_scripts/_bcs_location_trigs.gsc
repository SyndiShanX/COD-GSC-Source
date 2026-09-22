/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\_bcs_location_trigs.gsc
**************************************************/

_id_1671() {
  if(isDefined(level._id_2A3D) && isDefined(anim.bcs_locations)) {
    return;
  }
  level.bcs_location_mappings = [];
  bcs_location_trigs_do_mappings();
  bcs_trigs_assign_aliases();
  level.bcs_location_mappings = undefined;
  anim._id_5E5E = [];
}

bcs_trigs_assign_aliases() {
  anim.bcs_locations = [];
  var_0 = getEntArray();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3.classname) && issubstr(var_3.classname, "trigger_multiple_bcs")) {
      var_1[var_1.size] = var_3;
    }
  }

  foreach(var_3 in var_1) {
    if(!isDefined(level.bcs_location_mappings[var_3.classname])) {
      continue;
    }
    var_6 = parselocationaliases(level.bcs_location_mappings[var_3.classname]);

    if(var_6.size > 1) {
      var_6 = common_scripts\utility::array_randomize(var_6);
    }

    var_3._id_5E5C = var_6;
  }

  anim.bcs_locations = var_1;
}

parselocationaliases(var_0) {
  var_1 = strtok(var_0, " ");
  return var_1;
}

add_bcs_location_mapping(var_0, var_1) {
  if(isDefined(level.bcs_location_mappings[var_0])) {
    var_2 = level.bcs_location_mappings[var_0];
    var_3 = parselocationaliases(var_2);
    var_4 = parselocationaliases(var_1);

    foreach(var_6 in var_4) {
      foreach(var_8 in var_3) {
        if(var_6 == var_8) {
          return;
        }
      }
    }

    var_2 = var_2 + (" " + var_1);
    level.bcs_location_mappings[var_0] = var_2;
    return;
  }

  level.bcs_location_mappings[var_0] = var_1;
}

bcs_location_trigs_do_mappings() {
  if(common_scripts\utility::issp()) {
    _id_6004();
    _id_1D72();
    _id_7C4F();
    _id_674C();
    _id_2483();
    _id_9C1A();
    _id_0812();
    _id_4FF1();
    _id_4D5F();
    _id_95E3();
    _id_6E81();
    _id_402C();
    _id_3F2C();
  } else {
    _id_6506();
    _id_64F6();
    _id_64F2();
    _id_64F5();
    _id_64FC();
    _id_6503();
    _id_6505();
    _id_64F4();
    _id_64FB();
    _id_64FA();
    _id_64F9();
    _id_A7FB();
    _id_A7FA();
    _id_5B06();
  }
}

_id_6004() {
  add_bcs_location_mapping("trigger_multiple_bcs_mar_altar", "mar_altar");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_balcony", "mar_balcony");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_barrels", "mar_barrels");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_black_car", "mar_black_car");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_blue_car", "mar_blue_car");
  add_bcs_location_mapping("trigger_multiple_mar_broken_roof", "mar_broken_roof");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_burning_wagon", "mar_burning_wagon");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_cart", "mar_cart");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_couch", "mar_couch");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_crate_stack", "mar_crate_stack");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_crater", "mar_crater");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_debris", "mar_debris");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_doorway", "mar_doorway");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_fallen_pillars", "mar_fallen_pillars");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_fallen_statues", "mar_fallen_statues");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_half_wall", "mar_half_wall");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_halftrack", "mar_halftrack");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_hedges", "mar_hedges");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_kubelwagon", "mar_kubelwagon");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_metal_gate", "mar_metal_gate");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_motorcycle", "mar_motorcycle");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_organ", "mar_organ");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_pews", "mar_pews");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_piano", "mar_piano");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_pillar", "mar_pillar");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_pillars", "mar_pillars");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_plane_wreckage", "mar_plane_wreckage");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_pulpit", "mar_pulpit");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_red_car", "mar_red_car");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_rubble", "mar_rubble");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_sandbags", "mar_sandbags");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_second_floor", "mar_second_floor");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_stairs", "mar_stairs");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_stone_wall", "mar_stone_wall");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_street", "mar_street");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_street_lamps", "mar_street_lamps");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_supply_crates", "mar_supply_crates");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_table", "mar_table");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_tree", "mar_tree");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_truck", "mar_truck");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_windows", "mar_windows");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_windows_second_floor", "mar_windows_second_floor");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_wooden_fence", "mar_wooden_fence");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_on_left", "mar_on_left");
  add_bcs_location_mapping("trigger_multiple_bcs_mar_on_right", "mar_on_right");
}

_id_1D72() {
  add_bcs_location_mapping("trigger_multiple_bcs_bul_bush", "bul_bush");
  add_bcs_location_mapping("trigger_multiple_bcs_bul_haybale", "bul_haybale");
  add_bcs_location_mapping("trigger_multiple_bcs_bul_hedgerow", "bul_hedgerow");
  add_bcs_location_mapping("trigger_multiple_bcs_bul_log", "bul_log");
  add_bcs_location_mapping("trigger_multiple_bcs_bul_rock", "bul_rock");
  add_bcs_location_mapping("trigger_multiple_bcs_bul_snowburm", "bul_snowburm");
  add_bcs_location_mapping("trigger_multiple_bcs_bul_tree", "bul_tree");
  add_bcs_location_mapping("trigger_multiple_bcs_bul_treeline", "bul_treeline");
}

_id_7C4F() {
  add_bcs_location_mapping("trigger_multiple_bcs_rem_arch", "rem_arch");
  add_bcs_location_mapping("trigger_multiple_bcs_rem_barrels", "rem_barrels");
  add_bcs_location_mapping("trigger_multiple_bcs_rem_cart", "rem_cart");
  add_bcs_location_mapping("trigger_multiple_bcs_rem_column", "rem_column");
  add_bcs_location_mapping("trigger_multiple_bcs_rem_crates", "rem_crates");
  add_bcs_location_mapping("trigger_multiple_bcs_rem_generator", "rem_generator");
  add_bcs_location_mapping("trigger_multiple_bcs_rem_gun", "rem_gun");
  add_bcs_location_mapping("trigger_multiple_bcs_rem_jeep", "rem_jeep");
  add_bcs_location_mapping("trigger_multiple_bcs_rem_motorcycle", "rem_motorcycle");
  add_bcs_location_mapping("trigger_multiple_bcs_rem_rocks", "rem_rocks");
  add_bcs_location_mapping("trigger_multiple_bcs_rem_sandbags", "rem_sandbags");
  add_bcs_location_mapping("trigger_multiple_bcs_rem_switchboard", "rem_switchboard");
  add_bcs_location_mapping("trigger_multiple_bcs_rem_table", "rem_table");
  add_bcs_location_mapping("trigger_multiple_bcs_rem_tank", "rem_tank");
  add_bcs_location_mapping("trigger_multiple_bcs_rem_wagon", "rem_wagon");
  add_bcs_location_mapping("trigger_multiple_bcs_rem_woodpile", "rem_woodpile");
}

_id_674C() {
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_above_bunker", "ndy_above_bunker");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_barbed_wire", "ndy_barbed_wire");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_barn_doors", "ndy_barn_doors");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_barrel", "ndy_barrel");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_burning_cart", "ndy_burning_cart");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_bushes", "ndy_bushes");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_pipes", "ndy_pipes");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_radio_equipment", "ndy_radio_equipment");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_artillery_gun", "ndy_artillery_gun");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_mortar", "ndy_mortar");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_wire_poles", "ndy_wire_poles");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_crates", "ndy_crates");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_haystack", "ndy_haystack");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_alcove", "ndy_alcove");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_stables", "ndy_stables");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_metal_door", "ndy_metal_door");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_murder_hole", "ndy_murder_hole");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_plateau", "ndy_plateau");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_pillar", "ndy_pillar");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_sandbags", "ndy_sandbags");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_shelves", "ndy_shelves");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_table", "ndy_table");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_trenches", "ndy_trenches");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_upstairs_hole_in_barn", "ndy_upstairs_hole_in_barn");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_wagon", "ndy_wagon");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_wheelbarrow", "ndy_wheelbarrow");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_barn_second_floor", "ndy_barn_second_floor");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_beds", "ndy_beds");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_black_car", "ndy_black_car");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_brick_wall", "ndy_brick_wall");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_bunker_entrance", "ndy_bunker_entrance");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_generator", "ndy_generator");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_lockers", "ndy_lockers");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_logs", "ndy_logs");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_outhouse", "ndy_outhouse");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_red_car", "ndy_red_car");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_tractor", "ndy_tractor");
  add_bcs_location_mapping("trigger_multiple_bcs_ndy_white_car", "ndy_white_car");
}

_id_2483() {
  add_bcs_location_mapping("trigger_multiple_bcs_cob_barn_door", "cob_barn_door");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_barrel", "cob_near_barrel");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_troughs", "cob_troughs");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_wagon_wheel", "cob_wagon_wheel");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_car", "cob_car");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_crates", "cob_crates");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_flak_gun", "cob_flak_gun");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_haystack", "cob_haystack");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_crater", "cob_crater");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_jeep", "cob_jeep");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_log_pile", "cob_log_pile");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_milk_cans", "cob_milk_cans");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_wagon", "cob_wagon");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_sandbags", "cob_sandbags");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_shed", "cob_shed");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_tent", "cob_tent");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_tractor", "cob_tractor");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_windows", "cob_windows");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_large_haystack", "cob_large_haystack");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_small_haystack", "cob_small_haystack");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_shack", "cob_shack");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_stone_wall", "cob_stone_wall");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_destroyed_tractor", "cob_destroyed_tractor");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_barrels", "cob_barrels");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_blue_barrel", "cob_blue_barrel");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_burning_truck", "cob_burning_truck");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_destroyed_truck", "cob_destroyed_truck");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_sandbags", "cob_sandbags");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_on_aa_gun", "cob_on_aa_gun");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_pillboxes", "cob_pillboxes");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_barn_second_floor", "cob_barn_second_floor");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_hedgehogs", "cob_hedgehogs");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_gate", "cob_gate");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_cart", "cob_cart");
  add_bcs_location_mapping("trigger_multiple_bcs_cob_field", "cob_field");
}

_id_9C1A() {
  add_bcs_location_mapping("trigger_multiple_bcs_tra_fuel_tank", "tra_fuel_tank");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_halftrack", "tra_halftrack");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_rocket", "tra_rocket");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_rocket_parts", "tra_rocket_parts");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_spotlight", "tra_spotlight");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_stairs", "tra_stairs");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_tank", "tra_tank");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_second_floor_balcony", "tra_second_floor_balcony");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_second_floor_catwalk", "tra_second_floor_catwalk");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_third_floor_balcony", "tra_third_floor_balcony");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_watch_tower", "tra_watch_tower");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_barrels", "tra_barrels");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_benches", "tra_benches");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_columns", "tra_columns");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_crane", "tra_crane");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_ditch", "tra_ditch");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_kubelwagon", "tra_kubelwagon");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_lumber", "tra_lumber");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_post_office", "tra_post_office");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_on_ramp", "tra_on_ramp");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_stone_wall", "tra_stone_wall");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_on_tracks", "tra_on_tracks");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_in_train_car", "tra_in_train_car");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_on_train_cars", "tra_on_train_cars");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_water_tower", "tra_water_tower");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_truck", "tra_truck");
  add_bcs_location_mapping("trigger_multiple_bcs_tra_ridge", "tra_ridge");
}

_id_0812() {
  add_bcs_location_mapping("trigger_multiple_bcs_aac_above_across", "aac_above_across");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_apartments_left", "aac_apartments_left");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_apartments_right", "aac_apartments_right");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_at_bar", "aac_at_bar");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_main_staircase_bottom", "aac_main_staircase_bottom");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_side_staircase_bottom", "aac_side_staircase_bottom");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_main_staircase_top", "aac_main_staircase_top");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_back_of_garden", "aac_back_of_garden");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_couch", "aac_couch");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_stairs_bottom", "aac_stairs_bottom");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_by_bar", "aac_by_bar");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_fountain", "aac_fountain");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_mg_second_story", "aac_mg_second_story");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_statue", "aac_statue");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_down_street", "aac_down_street");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_hallway_door", "aac_hallway_door");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_apartments_across", "aac_apartments_across");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_back_hallway", "aac_back_hallway");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_back_street_left", "aac_back_street_left");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_back_street_right", "aac_back_street_right");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_buildings_across", "aac_buildings_across");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_in_garden", "aac_in_garden");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_hole_right", "aac_hole_right");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_kitchen_left", "aac_kitchen_left");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_in_street", "aac_in_street");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_in_apartments", "aac_in_apartments");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_left_of_plane", "aac_left_of_plane");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_near_back_hallway", "aac_near_back_hallway");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_on_main_staircase", "aac_on_main_staircase");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_on_the_right", "aac_on_the_right");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_on_side_staircase", "aac_on_side_staircase");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_right_of_plane", "aac_right_of_plane");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_second_story", "aac_second_story");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_straight_across", "aac_straight_across");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_third_story", "aac_third_story");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_under_plane_wing", "aac_under_plane_wing");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_under_side_staircase", "aac_under_side_staircase");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_up_in_building", "aac_up_in_building");
  add_bcs_location_mapping("trigger_multiple_bcs_aac_upper_story", "aac_upper_story");
}

_id_4FF1() {
  add_bcs_location_mapping("trigger_multiple_bcs_hur_barbed_wire", "hur_barbed_wire");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_barn_doors", "hur_barn_doors");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_barn_windows", "hur_barn_windows");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_barrels", "hur_barrels");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_cabinets", "hur_cabinets");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_crates", "hur_crates");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_halftrack", "hur_halftrack");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_in_river", "hur_in_river");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_jeep", "hur_jeep");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_log", "hur_log");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_plateau", "hur_plateau");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_rocks_in_river", "hur_rocks_in_river");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_sandbags", "hur_sandbags");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_stables", "hur_stables");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_stacked_logs", "hur_stacked_logs");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_stairs", "hur_stairs");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_stump", "hur_stump");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_tables", "hur_tables");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_dragons_teeth", "hur_dragons_teeth");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_road", "hur_road");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_trenches_left", "hur_trenches_left");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_trenches_right", "hur_trenches_right");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_at_bridge", "hur_at_bridge");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_by_bridge", "hur_by_bridge");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_under_bridge", "hur_under_bridge");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_trucks", "hur_trucks");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_cliff", "hur_cliff");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_sawmill_second_floor_window", "hur_sawmill_second_floor_window");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_sawmill", "hur_sawmill");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_woodshed", "hur_woodshed");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_artillery_gun", "hur_artillery_gun");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_bottom_artillery_gun", "hur_bottom_artillery_gun");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_bunker", "hur_bunker");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_left_trench_top", "hur_left_trench_top");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_top_artillery_gun", "hur_top_artillery_gun");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_treeline", "hur_treeline");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_trench_bunker_in_back", "hur_trench_bunker_in_back");
  add_bcs_location_mapping("trigger_multiple_bcs_hur_trenches", "hur_trenches");
}

_id_4D5F() {
  add_bcs_location_mapping("trigger_multiple_bcs_hil_alcove", "hil_alcove");
  add_bcs_location_mapping("trigger_multiple_bcs_hil_barbed_wire", "hil_barbed_wire");
  add_bcs_location_mapping("trigger_multiple_bcs_hil_barrel", "hil_barrel");
  add_bcs_location_mapping("trigger_multiple_bcs_hil_boulder", "hil_boulder");
  add_bcs_location_mapping("trigger_multiple_bcs_hil_bushes", "hil_bushes");
  add_bcs_location_mapping("trigger_multiple_bcs_hil_broken_tree", "hil_broken_tree");
  add_bcs_location_mapping("trigger_multiple_bcs_hil_windows", "hil_windows");
  add_bcs_location_mapping("trigger_multiple_bcs_hil_crate", "hil_crate");
  add_bcs_location_mapping("trigger_multiple_bcs_hil_doorway", "hil_doorway");
  add_bcs_location_mapping("trigger_multiple_bcs_hil_log", "hil_log");
  add_bcs_location_mapping("trigger_multiple_bcs_hil_stump", "hil_stump");
  add_bcs_location_mapping("trigger_multiple_bcs_hil_ridge", "hil_ridge");
  add_bcs_location_mapping("trigger_multiple_bcs_hil_artillery", "hil_artillery");
  add_bcs_location_mapping("trigger_multiple_bcs_hil_artillery_bottom", "hil_artillery_bottom");
  add_bcs_location_mapping("trigger_multiple_bcs_hil_bunker", "hil_bunker");
  add_bcs_location_mapping("trigger_multiple_bcs_hil_left_trench_top", "hil_left_trench_top");
  add_bcs_location_mapping("trigger_multiple_bcs_hil_artillery_top", "hil_artillery_top");
  add_bcs_location_mapping("trigger_multiple_bcs_hil_treeline", "hil_treeline");
  add_bcs_location_mapping("trigger_multiple_bcs_hil_trench_bunker_in_back", "hil_trench_bunker_in_back");
  add_bcs_location_mapping("trigger_multiple_bcs_hil_trenches", "hil_trenches");
}

_id_95E3() {
  add_bcs_location_mapping("trigger_multiple_bcs_tak_aa_gun", "tak_aa_gun");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_ammo_boxes", "tak_ammo_boxes");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_balcony", "tak_balcony");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_barrel", "tak_barrel");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_bed", "tak_bed");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_bridge", "tak_bridge");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_closet", "tak_closet");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_crates", "tak_crates");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_doghouse", "tak_doghouse");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_dynamite", "tak_dynamite");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_fence", "tak_fence");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_generator", "tak_generator");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_guardhouse", "tak_guardhouse");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_halftrack", "tak_halftrack");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_hangar", "tak_hangar");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_kubelwagon", "tak_kubelwagon");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_oil_drum", "tak_oil_drum");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_plane", "tak_plane");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_plow", "tak_plow");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_post", "tak_post");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_riverbed", "tak_riverbed");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_rock", "tak_rock");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_shack", "tak_shack");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_sign", "tak_sign");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_snow_pile", "tak_snow_pile");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_stove", "tak_stove");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_tire_pile", "tak_tire_pile");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_tower", "tak_tower");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_tree", "tak_tree");
  add_bcs_location_mapping("trigger_multiple_bcs_tak_truck", "tak_truck");
}

_id_6E81() {
  add_bcs_location_mapping("trigger_multiple_bcs_par_apc", "par_apc");
  add_bcs_location_mapping("trigger_multiple_bcs_par_balcony", "par_balcony");
  add_bcs_location_mapping("trigger_multiple_bcs_par_barrels", "par_barrels");
  add_bcs_location_mapping("trigger_multiple_bcs_par_barricade", "par_barricade");
  add_bcs_location_mapping("trigger_multiple_bcs_par_bridge", "par_bridge");
  add_bcs_location_mapping("trigger_multiple_bcs_par_cafe", "par_cafe");
  add_bcs_location_mapping("trigger_multiple_bcs_par_car", "par_car");
  add_bcs_location_mapping("trigger_multiple_bcs_par_cart", "par_cart");
  add_bcs_location_mapping("trigger_multiple_bcs_par_chair", "par_chair");
  add_bcs_location_mapping("trigger_multiple_bcs_par_couch", "par_couch");
  add_bcs_location_mapping("trigger_multiple_bcs_par_crates", "par_crates");
  add_bcs_location_mapping("trigger_multiple_bcs_par_desk", "par_desk");
  add_bcs_location_mapping("trigger_multiple_bcs_par_doorway", "par_doorway");
  add_bcs_location_mapping("trigger_multiple_bcs_par_fence", "par_fence");
  add_bcs_location_mapping("trigger_multiple_bcs_par_fountain", "par_fountain");
  add_bcs_location_mapping("trigger_multiple_bcs_par_garrison", "par_garrison");
  add_bcs_location_mapping("trigger_multiple_bcs_par_garrison_second_story", "par_garrison_second_story");
  add_bcs_location_mapping("trigger_multiple_bcs_par_gate", "par_gate");
  add_bcs_location_mapping("trigger_multiple_bcs_par_halftrack", "par_halftrack");
  add_bcs_location_mapping("trigger_multiple_bcs_par_half_wall", "par_half_wall");
  add_bcs_location_mapping("trigger_multiple_bcs_par_intersection", "par_intersection");
  add_bcs_location_mapping("trigger_multiple_bcs_par_kubelwagon", "par_kubelwagon");
  add_bcs_location_mapping("trigger_multiple_bcs_par_newsstand", "par_newsstand");
  add_bcs_location_mapping("trigger_multiple_bcs_par_office", "par_office");
  add_bcs_location_mapping("trigger_multiple_bcs_par_pillar", "par_pillar");
  add_bcs_location_mapping("trigger_multiple_bcs_par_planter", "par_planter");
  add_bcs_location_mapping("trigger_multiple_bcs_par_railing", "par_railing");
  add_bcs_location_mapping("trigger_multiple_bcs_par_sandbags", "par_sandbags");
  add_bcs_location_mapping("trigger_multiple_bcs_par_second_story", "par_second_story");
  add_bcs_location_mapping("trigger_multiple_bcs_par_sidewalk", "par_sidewalk");
  add_bcs_location_mapping("trigger_multiple_bcs_par_stairs", "par_stairs");
  add_bcs_location_mapping("trigger_multiple_bcs_par_storage_tanks", "par_storage_tanks");
  add_bcs_location_mapping("trigger_multiple_bcs_par_street", "par_street");
  add_bcs_location_mapping("trigger_multiple_bcs_par_table", "par_table");
  add_bcs_location_mapping("trigger_multiple_bcs_par_tent", "par_tent");
  add_bcs_location_mapping("trigger_multiple_bcs_par_transport", "par_transport");
  add_bcs_location_mapping("trigger_multiple_bcs_par_truck", "par_truck");
  add_bcs_location_mapping("trigger_multiple_bcs_par_window", "par_window");
}

_id_6506() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_wolf_command_bunker", "mp_wolf_command_bunker");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_wolf_cabin", "mp_wolf_cabin");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_wolf_garage", "mp_wolf_garage");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_wolf_generator", "mp_wolf_generator");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_wolf_construction_site", "mp_wolf_construction_site");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_wolf_storage_bunker", "mp_wolf_storage_bunker");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_wolf_collapsed_bunker", "mp_wolf_collapsed_bunker");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_wolf_swamp", "mp_wolf_swamp");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_wolf_smokestack", "mp_wolf_smokestack");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_wolf_generator", "mp_wolf_generator");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_wolf_camo_netting", "mp_wolf_camo_netting");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_wolf_loading_dock", "mp_wolf_loading_dock");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_wolf_vehicles", "mp_wolf_vehicles");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_wolf_crater", "mp_wolf_crater");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_wolf_truck", "mp_wolf_truck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_wolf_mg_nest", "mp_wolf_mg_nest");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_wolf_alley", "mp_wolf_alley");
}

_id_64F6() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_fence", "mp_car_fence");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_tavern", "mp_car_tavern");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_store", "mp_car_store");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_cafe", "mp_car_cafe");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_bombed_house", "mp_car_bombed_house");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_dirt_road", "mp_car_dirt_road");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_house", "mp_car_house");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_farm_house", "mp_car_farm_house");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_butcher_shop", "mp_car_butcher_shop");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_hay_bales", "mp_car_hay_bales");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_tow_truck", "mp_car_tow_truck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_cart", "mp_car_cart");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_crater", "mp_car_crater");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_archway", "mp_car_archway");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_tank", "mp_car_tank");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_crates", "mp_car_crates");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_garden", "mp_car_garden");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_shed", "mp_car_shed");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_greenhouse", "mp_car_greenhouse");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_tree", "mp_car_tree");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_roadblock", "mp_car_roadblock");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_dresser", "mp_car_dresser");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_gate", "mp_car_gate");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_chicken_coop", "mp_car_chicken_coop");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_truck", "mp_car_truck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_car_street", "mp_car_street");
}

_id_64F2() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_aac_apartments", "mp_aac_apartments");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_aac_bar", "mp_aac_bar");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_aac_theater", "mp_aac_theater");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_aac_trolley", "mp_aac_trolley");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_aac_sherman", "mp_aac_sherman");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_aac_truck", "mp_aac_truck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_aac_halftrack", "mp_aac_halftrack");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_aac_motorcycle", "mp_aac_motorcycle");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_aac_sedan", "mp_aac_sedan");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_aac_upstairs_window", "mp_aac_upstairs_window");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_aac_downstairs_window", "mp_aac_downstairs_window");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_aac_window", "mp_aac_window");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_aac_library", "mp_aac_library");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_aac_tanks", "mp_aac_tanks");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_aac_stairwell", "mp_aac_stairwell");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_aac_columns", "mp_aac_columns");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_aac_couch", "mp_aac_couch");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_aac_crater", "mp_aac_crater");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_aac_sandbags", "mp_aac_sandbags");
}

_id_64F5() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_can_farm", "mp_can_farm");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_can_truck", "mp_can_truck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_can_stables", "mp_can_stables");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_can_farmhouse", "mp_can_farmhouse");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_can_window", "mp_can_window");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_can_supply_road", "mp_can_supply_road");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_can_tractor", "mp_can_tractor");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_can_storeroom", "mp_can_storeroom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_can_windmill", "mp_can_windmill");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_can_crane", "mp_can_crane");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_can_trains", "mp_can_trains");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_can_tunnel", "mp_can_tunnel");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_can_cannon_rear", "mp_can_cannon_rear");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_can_top_deck", "mp_can_top_deck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_can_under_cannon", "mp_can_under_cannon");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_can_cannon_front", "mp_can_cannon_front");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_can_church", "mp_can_church");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_can_lumber_pile", "mp_can_lumber_pile");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_can_shack", "mp_can_shack");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_can_barnyard", "mp_can_barnyard");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_can_barn", "mp_can_barn");
}

_id_64FC() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_gib_high_ground", "mp_gib_high_ground");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_gib_security_station", "mp_gib_security_station");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_gib_cliff_bridge", "mp_gib_cliff_bridge");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_gib_upper_battery", "mp_gib_upper_battery");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_gib_cliff_rocks", "mp_gib_cliff_rocks");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_gib_tank", "mp_gib_tank");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_gib_platform", "mp_gib_platform");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_gib_tunnel", "mp_gib_tunnel");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_gib_com_trailer", "mp_gib_com_trailer");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_gib_garbage", "mp_gib_garbage");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_gib_window", "mp_gib_window");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_gib_checkpoint", "mp_gib_checkpoint");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_gib_balcony", "mp_gib_balcony");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_gib_tower_balcony", "mp_gib_tower_balcony");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_gib_fort_balcony", "mp_gib_fort_balcony");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_gib_center_bridge", "mp_gib_center_bridge");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_gib_under_bridge", "mp_gib_under_bridge");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_gib_stairs", "mp_gib_stairs");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_gib_shed", "mp_gib_shed");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_gib_com_room", "mp_gib_com_room");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_gib_courtyard", "mp_gib_courtyard");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_gib_turret", "mp_gib_turret");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_gib_boulder", "mp_gib_boulder");
}

_id_6503() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lon_dock_gate", "mp_lon_dock_gate");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lon_wrecked_crane", "mp_lon_wrecked_crane");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lon_underground", "mp_lon_underground");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lon_office", "mp_lon_office");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lon_station", "mp_lon_station");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lon_dock_house", "mp_lon_dock_house");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lon_barges", "mp_lon_barges");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lon_statue", "mp_lon_statue");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lon_street", "mp_lon_street");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lon_warehouse", "mp_lon_warehouse");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lon_bus", "mp_lon_bus");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lon_courtyard", "mp_lon_courtyard");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lon_crane", "mp_lon_crane");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lon_collapsed_building", "mp_lon_collapsed_building");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lon_ramp", "mp_lon_ramp");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lon_garage", "mp_lon_garage");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lon_storeroom", "mp_lon_storeroom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lon_cargo", "mp_lon_cargo");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lon_window", "mp_lon_window");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lon_truck", "mp_lon_truck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lon_gate", "mp_lon_gate");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lon_hallway", "mp_lon_hallway");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lon_ambulance", "mp_lon_ambulance");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lon_barrels", "mp_lon_barrels");
}

_id_6505() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_crash_site", "mp_vil_crash_site");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_glider", "mp_vil_glider");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_jeep", "mp_vil_jeep");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_barrels", "mp_vil_barrels");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_hay_bales", "mp_vil_hay_bales");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_wall", "mp_vil_wall");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_supply_crates", "mp_vil_supply_crates");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_treeline", "mp_vil_treeline");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_tractor", "mp_vil_tractor");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_stables", "mp_vil_stables");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_map_room", "mp_vil_map_room");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_near_map_room", "mp_vil_near_map_room");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_north_road", "mp_vil_north_road");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_headquarters", "mp_vil_headquarters");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_bar", "mp_vil_bar");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_city_hall", "mp_vil_city_hall");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_trenches", "mp_vil_trenches");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_backlot", "mp_vil_backlot");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_restaurant", "mp_vil_restaurant");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_south_road", "mp_vil_south_road");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_butcher", "mp_vil_butcher");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_pastry", "mp_vil_pastry");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_cafe", "mp_vil_cafe");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_barracks", "mp_vil_barracks");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_munitions_storage", "mp_vil_munitions_storage");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_officers_quarters", "mp_vil_officers_quarters");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_small_lot", "mp_vil_small_lot");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_artillery_gun_north", "mp_vil_artillery_gun_north");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_artillery_gun_south", "mp_vil_artillery_gun_south");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_ruins", "mp_vil_ruins");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_tank", "mp_vil_tank");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_courtyard", "mp_vil_courtyard");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_creperie", "mp_vil_creperie");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_south_avenue", "mp_vil_south_avenue");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_avenue_north", "mp_vil_avenue_north");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_bakery", "mp_vil_bakery");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_car_lot", "mp_vil_car_lot");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vil_shed", "mp_vil_shed");
}

_id_64F4() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_bat_port_deck", "mp_bat_port_deck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_bat_stairs", "mp_bat_stairs");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_bat_upper_deck", "mp_bat_upper_deck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_bat_stern", "mp_bat_stern");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_bat_tower", "mp_bat_tower");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_bat_smoke_stack", "mp_bat_smoke_stack");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_bat_porthole", "mp_bat_porthole");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_bat_bridge", "mp_bat_bridge");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_bat_galley", "mp_bat_galley");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_bat_forward_turret", "mp_bat_forward_turret");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_bat_anchor_room", "mp_bat_anchor_room");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_bat_bow", "mp_bat_bow");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_bat_starboard_deck", "mp_bat_starboard_deck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_bat_winch", "mp_bat_winch");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_bat_lifeboats", "mp_bat_lifeboats");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_bat_aa_gun", "mp_bat_aa_gun");
}

_id_64FB() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_for_bunker", "mp_for_bunker");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_for_window", "mp_for_window");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_for_creek", "mp_for_creek");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_for_cabin", "mp_for_cabin");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_for_log_wall", "mp_for_log_wall");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_for_armory", "mp_for_armory");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_for_tank", "mp_for_tank");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_for_bell", "mp_for_bell");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_for_road", "mp_for_road");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_for_tank_fire", "mp_for_tank_fire");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_for_truck", "mp_for_truck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_for_on_bridge", "mp_for_on_bridge");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_for_under_bridge", "mp_for_under_bridge");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_for_halftack", "mp_for_halftack");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_for_ruins", "mp_for_ruins");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_for_arch", "mp_for_arch");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_for_fallen_pillar", "mp_for_fallen_pillar");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_for_balcony", "mp_for_balcony");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_for_statue", "mp_for_statue");
}

_id_64FA() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flak_aa_gun", "mp_flak_aa_gun");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flak_aid_station", "mp_flak_aid_station");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flak_tunnel", "mp_flak_tunnel");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flak_radio_room", "mp_flak_radio_room");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flak_searchlight", "mp_flak_searchlight");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flak_elevator", "mp_flak_elevator");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flak_electrical_box", "mp_flak_electrical_box");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flak_window", "mp_flak_window");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flak_center_elevator", "mp_flak_center_elevator");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flak_lumber_pile", "mp_flak_lumber_pile");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flak_signals_office", "mp_flak_signals_office");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flak_antenna", "mp_flak_antenna");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flak_armory", "mp_flak_armory");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flak_overlook", "mp_flak_overlook");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flak_scaffold", "mp_flak_scaffold");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flak_crane", "mp_flak_crane");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flak_engine_room", "mp_flak_engine_room");
}

_id_64F9() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dday_barn", "mp_dday_barn");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dday_hay_bale", "mp_dday_hay_bale");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dday_hay_stack", "mp_dday_hay_stack");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dday_window", "mp_dday_window");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dday_farmhouse", "mp_dday_farmhouse");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dday_window_upstairs", "mp_dday_window_upstairs");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dday_window_downstairs", "mp_dday_window_downstairs");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dday_wagon", "mp_dday_wagon");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dday_trench", "mp_dday_trench");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dday_bunker", "mp_dday_bunker");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dday_crater", "mp_dday_crater");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dday_plane_wreck", "mp_dday_plane_wreck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dday_pillboxes", "mp_dday_pillboxes");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dday_metal_bunker", "mp_dday_metal_bunker");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dday_radar_bunker", "mp_dday_radar_bunker");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dday_balcony", "mp_dday_balcony");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dday_aa_gun", "mp_dday_aa_gun");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dday_east_bunker", "mp_dday_east_bunker");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dday_armory", "mp_dday_armory");
}

_id_A7FB() {
  add_bcs_location_mapping("trigger_multiple_bcs_war_cob_command_post", "mp_war_cobra_command_post");
  add_bcs_location_mapping("trigger_multiple_bcs_war_cob_barn", "mp_war_cobra_barn");
  add_bcs_location_mapping("trigger_multiple_bcs_war_cob_trench", "mp_war_cobra_trenches");
  add_bcs_location_mapping("trigger_multiple_bcs_war_cob_creek", "mp_war_cobra_creek");
  add_bcs_location_mapping("trigger_multiple_bcs_war_cob_bridge", "mp_war_cobra_bridge");
  add_bcs_location_mapping("trigger_multiple_bcs_war_cob_ammo_dump", "mp_war_cobra_ammo_dump");
  add_bcs_location_mapping("trigger_multiple_bcs_war_cob_radar_station", "mp_war_cobra_radar");
  add_bcs_location_mapping("trigger_multiple_bcs_war_cob_church", "mp_war_cobra_church");
  add_bcs_location_mapping("trigger_multiple_bcs_war_cob_stables", "mp_war_cobra_stables");
  add_bcs_location_mapping("trigger_multiple_bcs_war_cob_courtyard", "mp_war_cobra_courtyard");
  add_bcs_location_mapping("trigger_multiple_bcs_war_cob_road", "mp_war_cobra_road");
  add_bcs_location_mapping("trigger_multiple_bcs_war_cob_house_overwatch", "mp_war_cobra_overwatch");
  add_bcs_location_mapping("trigger_multiple_bcs_war_cob_alley", "mp_war_cobra_alley");
  add_bcs_location_mapping("trigger_multiple_bcs_war_cob_garden", "mp_war_cobra_garden");
  add_bcs_location_mapping("trigger_multiple_bcs_war_cob_warehouse", "mp_war_cobra_warehouse");
  add_bcs_location_mapping("trigger_multiple_bcs_war_cob_garage", "mp_war_cobra_garage");
  add_bcs_location_mapping("trigger_multiple_bcs_war_cob_field", "mp_war_cobra_field");
  add_bcs_location_mapping("trigger_multiple_bcs_war_cob_pasture", "mp_war_cobra_pasture");
}

_id_A7FA() {
  add_bcs_location_mapping("trigger_multiple_bcs_war_bul_allied_camp", "mp_war_bulge_allied_camp");
  add_bcs_location_mapping("trigger_multiple_bcs_war_bul_allied_trucks", "mp_war_bulge_allied_trucks");
  add_bcs_location_mapping("trigger_multiple_bcs_war_bul_bridge", "mp_war_bulge_bridge");
  add_bcs_location_mapping("trigger_multiple_bcs_war_bul_camp_houses", "mp_war_bulge_camp_houses");
  add_bcs_location_mapping("trigger_multiple_bcs_war_bul_castle_arch", "mp_war_bulge_castle_arch");
  add_bcs_location_mapping("trigger_multiple_bcs_war_bul_castle_ruins", "mp_war_bulge_castle_ruins");
  add_bcs_location_mapping("trigger_multiple_bcs_war_bul_castle_turret", "mp_war_bulge_castle_turret");
  add_bcs_location_mapping("trigger_multiple_bcs_war_bul_embankment", "mp_war_bulge_embankment");
  add_bcs_location_mapping("trigger_multiple_bcs_war_bul_fuel_truck", "mp_war_bulge_fuel_truck");
  add_bcs_location_mapping("trigger_multiple_bcs_war_bul_log_walls", "mp_war_bulge_log_walls");
  add_bcs_location_mapping("trigger_multiple_bcs_war_bul_panzer", "mp_war_bulge_panzer");
  add_bcs_location_mapping("trigger_multiple_bcs_war_bul_quonset_huts", "mp_war_bulge_quonset_huts");
  add_bcs_location_mapping("trigger_multiple_bcs_war_bul_road", "mp_war_bulge_road");
  add_bcs_location_mapping("trigger_multiple_bcs_war_bul_rocks", "mp_war_bulge_rocks");
  add_bcs_location_mapping("trigger_multiple_bcs_war_bul_sherman_tanks", "mp_war_bulge_sherman_tanks");
  add_bcs_location_mapping("trigger_multiple_bcs_war_bul_trees", "mp_war_bulge_trees");
  add_bcs_location_mapping("trigger_multiple_bcs_war_bul_trenches", "mp_war_bulge_trenches");
  add_bcs_location_mapping("trigger_multiple_bcs_war_bul_watch_tower", "mp_war_bulge_watch_tower");
}

_id_402C() {
  add_bcs_location_mapping("trigger_multiple_bcs_generic_doorway_generic", "doorway_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_generic_window_generic", "window_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_generic_1stfloor_generic", "1stfloor_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_generic_1stfloor_doorway", "1stfloor_doorway");
  add_bcs_location_mapping("trigger_multiple_bcs_generic_1stfloor_window", "1stfloor_window");
  add_bcs_location_mapping("trigger_multiple_bcs_generic_2ndfloor_generic", "2ndfloor_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_generic_2ndfloor_window", "2ndfloor_window");
  add_bcs_location_mapping("trigger_multiple_bcs_generic_rooftop", "rooftop");
  add_bcs_location_mapping("trigger_multiple_bcs_generic_2ndfloor_balcony", "2ndfloor_balcony");
}

_id_3F2C() {
  add_bcs_location_mapping("trigger_multiple_bcs_fus_truck", "fus_truck");
  add_bcs_location_mapping("trigger_multiple_bcs_fus_tower", "fus_tower");
  add_bcs_location_mapping("trigger_multiple_bcs_fus_generator", "fus_generator");
  add_bcs_location_mapping("trigger_multiple_bcs_fus_mt", "fus_mt");
  add_bcs_location_mapping("trigger_multiple_bcs_fus_titan", "fus_titan");
  add_bcs_location_mapping("trigger_multiple_bcs_fus_hill", "fus_hill");
  add_bcs_location_mapping("trigger_multiple_bcs_fus_garage", "fus_garage");
  add_bcs_location_mapping("trigger_multiple_bcs_fus_crane", "fus_crane");
  add_bcs_location_mapping("trigger_multiple_bcs_fus_forklift", "fus_forklift");
  add_bcs_location_mapping("trigger_multiple_bcs_fus_pillar", "fus_pillar");
  add_bcs_location_mapping("trigger_multiple_bcs_fus_pipes", "fus_pipes");
  add_bcs_location_mapping("trigger_multiple_bcs_fus_balcony", "fus_balcony");
  add_bcs_location_mapping("trigger_multiple_bcs_fus_catwalk", "fus_catwalk");
  add_bcs_location_mapping("trigger_multiple_bcs_fus_fueltrucks", "fus_fueltrucks");
  add_bcs_location_mapping("trigger_multiple_bcs_fus_walkway", "fus_walkway");
  add_bcs_location_mapping("trigger_multiple_bcs_fus_stairs", "fus_stairs");
}

_id_5B06() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_radardish", "lsr_radardish");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_laserairdefensegun", "lsr_laserairdefensegun");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_razorback", "lsr_razorback");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_underhelipad", "lsr_underhelipad");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_bunkerlookout", "lsr_bunkerlookout");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_inradartower", "lsr_inradartower");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_byradartower", "lsr_byradartower");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_shippingcontainer", "lsr_shippingcontainer");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_onhelipad", "lsr_onhelipad");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_onbeach", "lsr_onbeach");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_onbeach", "lsr_bybridge");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_bylasergenerator", "lsr_bylasergenerator");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_underlaser", "lsr_underlaser");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_byhelipad", "lsr_byhelipad");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_electricalroom", "lsr_electricalroom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_piperoom", "lsr_piperoom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_bybuoy", "lsr_bybuoy");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_bygenerator", "lsr_bygenerator");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_offswitch", "lsr_offswitch");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_missilerack", "lsr_missilerack");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_underchains", "lsr_underchains");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_beachbunkerrooftop", "lsr_beachbunkerrooftop");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_bunkerrooftop", "lsr_bunkerrooftop");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_nettedcargo", "lsr_nettedcargo");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_cagedcargo", "lsr_cagedcargo");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_overturnedcar", "lsr_overturnedcar");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_bridgebase", "lsr_bridgebase");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lsr_cornerbunker", "lsr_cornerbunker");
}