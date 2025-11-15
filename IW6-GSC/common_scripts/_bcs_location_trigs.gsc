/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\_bcs_location_trigs.gsc
**************************************************/

#include common_scripts\utility;

bcs_location_trigs_init() {
  ASSERT(!isDefined(level.bcs_location_mappings));
  level.bcs_location_mappings = [];

  bcs_location_trigger_mapping();
  bcs_trigs_assign_aliases();

  level.bcs_location_mappings = undefined;

  anim.locationLastCalloutTimes = [];
}

bcs_trigs_assign_aliases() {
  ASSERT(!isDefined(anim.bcs_locations));
  anim.bcs_locations = [];

  ents = getEntArray();
  trigs = [];
  foreach(trig in ents) {
    if(isDefined(trig.classname) && IsSubStr(trig.classname, "trigger_multiple_bcs")) {
      trigs[trigs.size] = trig;
    }
  }

  foreach(trig in trigs) {
    if(!isDefined(level.bcs_location_mappings[trig.classname])) {} else {
      aliases = ParseLocationAliases(level.bcs_location_mappings[trig.classname]);
      if(aliases.size > 1) {
        aliases = array_randomize(aliases);
      }

      trig.locationAliases = aliases;
    }
  }

  anim.bcs_locations = trigs;
}

ParseLocationAliases(locationStr) {
  locationAliases = StrTok(locationStr, " ");
  return locationAliases;
}

add_bcs_location_mapping(classname, alias) {
  if(isDefined(level.bcs_location_mappings[classname])) {
    existing = level.bcs_location_mappings[classname];
    existingArr = ParseLocationAliases(existing);
    aliases = ParseLocationAliases(alias);

    foreach(a in aliases) {
      foreach(e in existingArr) {
        if(a == e) {
          return;
        }
      }
    }

    existing += " " + alias;
    level.bcs_location_mappings[classname] = existing;

    return;
  }

  level.bcs_location_mappings[classname] = alias;
}

bcs_location_trigger_mapping() {
  if(isSP()) {
    generic_locations();

    blackice_locations();
    carrier_locations();
    clockwork_locations();
    cornered_locations();
    enemyhq_locations();
    factory_locations();
    flood_locations();
    homecoming_locations();
    jungleghosts_locations();
    nml_locations();
    oilrocks_locations();
    vegas_locations();
  } else {
    prisonbreak();
    chasm();
    dart();
    farenheit();
    flooded();
    frag();
    hashima();
    lonestar();
    skeleton();
    snow();
    sovereign();
    strikezone();
    warhawk();
    zebra();

    red_river();
    rumble();
    swamp();
    boneyard();

    dome();
    impact();
    behemoth();
    battery();

    favela();
    pirate();
    zulu();
    dig();

    shipment();
    conflict();
    zerosub();
    mine();
  }
}

generic_locations() {
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

blackice_locations() {
  add_bcs_location_mapping("trigger_multiple_bcs_blackice_airconditioner_generic", "airconditioner_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_crate_ammo", "crate_ammo");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_bar_generic", "bar_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_barrels_generic", "barrels_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_bookshelf_generic", "bookshelf_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_bridge_generic", "bridge_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_cart_generic", "cart_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_couch_generic", "couch_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_crates_generic", "crates_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_engine_left", "engine_left");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_engine_right", "engine_right");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_fence_generic", "fence_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_forklift_generic", "forklift_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_generator_generic", "generator_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_loadingbay_generic", "loadingbay_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_pipes_generic", "pipes_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_platform_generic", "platform_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_pooltable_generic", "pooltable_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_porch_generic", "porch_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_ramp_generic", "ramp_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_building_red", "building_red");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_snowbank_generic", "snowbank_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_snowmobile_generic", "snowmobile_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_tank_generic", "tank_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_tent_generic", "tent_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_tires_generic", "tires_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_catwalk_upper", "catwalk_upper");

  add_bcs_location_mapping("trigger_multiple_bcs_blackice_deck_upper", "deck_upper");
}

carrier_locations() {
  add_bcs_location_mapping("trigger_multiple_bcs_carrier_plane_jet", "plane_jet");

  add_bcs_location_mapping("trigger_multiple_bcs_carrier_plane_f18", "plane_f18");

  add_bcs_location_mapping("trigger_multiple_bcs_carrier_towcart_generic", "towcart_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_carrier_forklift_generic", "forklift_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_carrier_ohelo_osprey", "ohelo_osprey");

  add_bcs_location_mapping("trigger_multiple_bcs_carrier_plane_generic", "plane_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_carrier_deck_outer", "deck_outer");

  add_bcs_location_mapping("trigger_multiple_bcs_carrier_railing_generic", "railing_generic");
}

clockwork_locations() {
  add_bcs_location_mapping("trigger_multiple_bcs_clockwork_pillar_generic", "pillar_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_clockwork_pool_generic", "pool_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_clockwork_tram_generic", "tram_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_clockwork_platform_generic", "platform_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_clockwork_platform_left", "platform_left");

  add_bcs_location_mapping("trigger_multiple_bcs_clockwork_platform_right", "platform_right");

  add_bcs_location_mapping("trigger_multiple_bcs_clockwork_stairs_left", "stairs_left");

  add_bcs_location_mapping("trigger_multiple_bcs_clockwork_stairs_generic", "stairs_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_clockwork_stairs_right", "stairs_right");

  add_bcs_location_mapping("trigger_multiple_bcs_clockwork_walkway_generic", "walkway_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_clockwork_walkway_left", "walkway_left");

  add_bcs_location_mapping("trigger_multiple_bcs_clockwork_walkway_right", "walkway_right");

  add_bcs_location_mapping("trigger_multiple_bcs_clockwork_ramp_main", "ramp_main");

  add_bcs_location_mapping("trigger_multiple_bcs_clockwork_catwalk_generic", "catwalk_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_clockwork_pool_below", "pool_below");
}

cornered_locations() {
  add_bcs_location_mapping("trigger_multiple_bcs_cornered_balcony_generic", "balcony_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_cornered_windows_generic", "windows_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_cornered_planter_generic", "planter_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_cornered_wall_back", "wall_back");

  add_bcs_location_mapping("trigger_multiple_bcs_cornered_tree_generic", "tree_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_cornered_rocks_generic", "rocks_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_cornered_aquarium_generic", "aquarium_generic");
}

enemyhq_locations() {
  add_bcs_location_mapping("trigger_multiple_bcs_enemyhq_conession_generic", "conession_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_enemyhq_counter_burgertown", "counter_burgertown");

  add_bcs_location_mapping("trigger_multiple_bcs_enemyhq_concession_nate", "concession_nate");

  add_bcs_location_mapping("trigger_multiple_bcs_enemyhq_stairs_top", "stairs_top");

  add_bcs_location_mapping("trigger_multiple_bcs_enemyhq_walkway_generic", "walkway_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_enemyhq_rubble_pile", "rubble_pile");

  add_bcs_location_mapping("trigger_multiple_bcs_enemyhq_statue_generic", "statue_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_enemyhq_counter_generic", "counter_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_enemyhq_pillar_generic", "pillar_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_enemyhq_cart_trash", "cart_trash");
}

factory_locations() {
  add_bcs_location_mapping("trigger_multiple_bcs_factory_lockerroom_generic", "lockerroom_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_factory_server_generic", "server_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_factory_secondfloor_generic", "secondfloor_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_factory_catwalk_generic", "catwalk_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_factory_acunit_generic", "acunit_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_factory_airduct_generic", "airduct_generic");
}

flood_locations() {
  add_bcs_location_mapping("trigger_multiple_bcs_flood_tank_generic", "tank_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_flood_barrier_hesco", "barrier_hesco");

  add_bcs_location_mapping("trigger_multiple_bcs_flood_planter_generic", "planter_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_flood_pillar_generic", "pillar_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_flood_truck_generic", "truck_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_flood_crates_generic", "crates_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_flood_duct_air", "duct_air");

  add_bcs_location_mapping("trigger_multiple_bcs_flood_unit_ac", "unit_ac");

  add_bcs_location_mapping("trigger_multiple_bcs_flood_walkway_generic", "walkway_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_flood_pit_rubble", "pit_rubble");

  add_bcs_location_mapping("trigger_multiple_bcs_flood_car_generic", "car_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_flood_van_generic", "van_generic");
}

homecoming_locations() {
  add_bcs_location_mapping("trigger_multiple_bcs_homecoming_crate_ammo", "crate_ammo");

  add_bcs_location_mapping("trigger_multiple_bcs_homecoming_barrier_hesco", "barrier_hesco");

  add_bcs_location_mapping("trigger_multiple_bcs_homecoming_shack_blue", "shack_blue");

  add_bcs_location_mapping("trigger_multiple_bcs_homecoming_barrier_concrete", "barrier_concrete");

  add_bcs_location_mapping("trigger_multiple_bcs_homecoming_statue_artemis", "statue_artemis");

  add_bcs_location_mapping("trigger_multiple_bcs_homecoming_barrels_generic", "barrels_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_homecoming_crate_generic", "crate_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_homecoming_bulldozer_geenric", "bulldozer_geenric");

  add_bcs_location_mapping("trigger_multiple_bcs_homecoming_towers_hesco", "towers_hesco");

  add_bcs_location_mapping("trigger_multiple_bcs_homecoming_sandbags_generic", "sandbags_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_homecoming_pillar_generic", "pillar_generic");
}

jungleghosts_locations() {
  add_bcs_location_mapping("trigger_multiple_bcs_jungleghosts_rocks_generic", "rocks_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_jungleghosts_bridge_generic", "bridge_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_jungleghosts_fern_generic", "fern_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_jungleghosts_stream_generic", "stream_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_jungleghosts_log_generic", "log_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_jungleghosts_rock_generic", "rock_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_jungleghosts_stump_generic", "stump_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_jungleghosts_tree_generic", "tree_generic");
}

nml_locations() {
  add_bcs_location_mapping("trigger_multiple_bcs_nml_dirt_generic", "dirt_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_nml_trailer_generic", "trailer_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_nml_building_blue", "building_blue");

  add_bcs_location_mapping("trigger_multiple_bcs_nml_bridge_generic", "bridge_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_nml_garage_generic", "garage_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_nml_sandbags_generic", "sandbags_generic");
}

oilrocks_locations() {
  add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_garage_generic", "garage_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_rooftop_generic", "rooftop_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_catwalk_generic", "catwalk_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_trailer_generic", "trailer_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_stairway_generic", "stairway_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_barrels_generic", "barrels_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_crate_generic", "crate_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_can_trash", "can_trash");

  add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_roadblock_generic", "roadblock_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_pillar_generic", "pillar_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_hallway_generic", "hallway_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_forklift_generic", "forklift_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_can_oxygen", "can_oxygen");
}

vegas_locations() {
  add_bcs_location_mapping("trigger_multiple_bcs_vegas_planter_generic", "planter_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_vegas_fountain_generic", "fountain_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_vegas_kiosk_generic", "kiosk_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_vegas_slotmachines_generic", "slotmachines_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_vegas_rubble_generic", "rubble_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_vegas_pokertable_generic", "pokertable_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_vegas_debris_generic", "debris_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_vegas_escalator_generic", "escalator_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_vegas_couch_generic", "couch_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_vegas_statue_generic", "statue_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_vegas_statue_left", "statue_left");

  add_bcs_location_mapping("trigger_multiple_bcs_vegas_statue_right", "statue_right");

  add_bcs_location_mapping("trigger_multiple_bcs_vegas_tram_generic", "tram_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_vegas_wall_left", "wall_left");

  add_bcs_location_mapping("trigger_multiple_bcs_vegas_wall_right", "wall_right");

  add_bcs_location_mapping("trigger_multiple_bcs_vegas_tree_generic", "tree_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_vegas_car_police", "car_police");

  add_bcs_location_mapping("trigger_multiple_bcs_vegas_car_taxi", "car_taxi");

  add_bcs_location_mapping("trigger_multiple_bcs_vegas_car_generic", "car_generic");
}

prisonbreak() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_ridge", "ridge");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_constructionyard", "constructionyard");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_guardtower_generic", "guardtower_generic");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_guardtower_2ndfloor", "guardtower_2ndfloor");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_pipes_blue", "pipes_blue");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_securitystation", "securitystation");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_trailer_red", "trailer_red");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_trailer_blue", "trailer_blue");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_road", "road");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_river", "river");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_loggingcamp", "loggingcamp");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_catwalk", "catwalk");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_logstack", "logstack");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_tirestack", "tirestack");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_loggingtruck", "loggingtruck");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_bridge", "bridge");
}

chasm() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_garage_parking", "garage_parking");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_cubicles", "cubicles");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_kitchen", "kitchen");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_elevator", "elevator");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_stairway", "stairway");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_skybridge", "skybridge");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_diner", "diner");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_road_main", "road_main");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_rubble_pit", "rubble_pit");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_restaurant", "restaurant");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_hotel", "hotel");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_bar_hotel", "bar_hotel");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_underground", "underground");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_subway", "subway");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_waterpump", "waterpump");
}

dart() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_gasstation", "gasstation");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_autoshop_2ndfloor", "autoshop_2ndfloor");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_autoshop", "autoshop");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_pinkeez", "pinkeez");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_pinkeez_2ndfloor", "pinkeez_2ndfloor");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_alley_stripclub", "alley_stripclub");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_pawnshop", "pawnshop");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_shed_blue", "shed_blue");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_motel", "motel");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_bus_stripclub", "bus_stripclub");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_bus_motel", "bus_motel");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_diner", "diner");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_alley_convenience", "alley_convenience");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_intersection", "intersection");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_tank_gasstation", "tank_gasstation");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_tank_motel", "tank_motel");
}

farenheit() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_road_main", "road_main");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_library", "library");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_grass_tall", "grass_tall");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_monument", "monument");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_trailer_red", "trailer_red");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_restaurant", "restaurant");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_underground", "underground");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_garage_parking", "garage_parking");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_bar", "bar");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_escalators", "escalators");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_bridge", "bridge");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_bridge_under", "bridge_under");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_reception", "reception");
}

flooded() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_garage_lower", "garage_lower");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_garage_upper", "garage_upper");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_courtyard", "courtyard");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_patio", "patio");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_restaurant", "restaurant");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_bar", "bar");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_kitchen", "kitchen");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_skybridge", "skybridge");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_storage_downstairs", "storage_downstairs");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_building_office", "building_office");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_breakroom", "breakroom");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_lobby", "lobby");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_newsstation", "newsstation");
}

frag() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_lumberyard", "lumberyard");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_containers", "containers");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_traintracks", "traintracks");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_distillery", "distillery");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_distillery_south", "distillery_south");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_distillery_north", "distillery_north");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_distillery_2ndfloor", "distillery_2ndfloor");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_sign_porter", "sign_porter");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_owens", "owens");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_owens_2ndfloor", "owens_2ndfloor");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_owens_3rdfloor", "owens_3rdfloor");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_pipes_high", "pipes_high");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_junkyard", "junkyard");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_warehouse", "warehouse");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_warehouse_2ndfloor", "warehouse_2ndfloor");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_warehouse_3rdfloor", "warehouse_3rdfloor");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_roof_broken", "roof_broken");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_wall_broken", "wall_broken");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_dumpster_blue", "dumpster_blue");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_dumpster_red", "dumpster_red");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_fence_metal", "fence_metal");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_window_broken", "window_broken");
}

hashima() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_playground", "playground");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_hangar", "hangar");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_sam", "sam");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_mine", "mine");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_controlroom", "controlroom");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_traintracks", "traintracks");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_waterfall", "waterfall");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_docks", "docks");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_basement", "basement");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_tower_water", "tower_water");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_tower", "tower");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_building_redbrick", "building_redbrick");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_building_redbrick_2ndflr", "building_redbrick_2ndflr");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_apartment", "apartment");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_apartment_2ndfloor", "apartment_2ndfloor");
}

lonestar() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_helicopter_crashed", "helicopter_crashed");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_tent_fema", "tent_fema");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_carwash", "carwash");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_gasmain", "gasmain");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_kiosk", "kiosk");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_parking_garage", "parking_garage");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_burned_building", "burned_building");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_gasstation", "gasstation");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_rehab", "rehab");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_rehab_roof", "rehab_roof");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_skybridge", "skybridge");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_office_1stfloor", "office_1stfloor");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_office_2ndfloor", "office_2ndfloor");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_office_roof", "office_roof");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_ambulance_service_1stfloor", "ambulance_service_1stfloor");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_ambulance_service_2ndfloor", "ambulance_service_2ndfloor");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_hospital_collapsed", "hospital_collapsed");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_solarpanels", "solarpanels");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_garage_blue", "garage_blue");
}

skeleton() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_skeleton_castle", "castle");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_skeleton_mansion", "mansion");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_skeleton_well", "well");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_skeleton_hill", "hill");
}

snow() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_crashsite", "crashsite");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_canyon", "canyon");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_sawmill", "sawmill");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_waterwheel", "waterwheel");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_helicopter", "helicopter");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_shipwreck", "shipwreck");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_shipwreck_bow", "shipwreck_bow");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_ridge", "ridge");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_road_main", "road_main");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_totempole", "totempole");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_cabin", "cabin");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_boathouse", "boathouse");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_dock_fishing", "dock_fishing");
}

sovereign() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_catwalk_blue", "catwalk_blue");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_catwalk_yellow", "catwalk_yellow");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_centralcommand", "centralcommand");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_cleanroom", "cleanroom");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_warehouse", "warehouse");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_hologram", "hologram");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_assemblyline", "assemblyline");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_commanddeck", "commanddeck");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_serverroom", "serverroom");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_breakroom", "breakroom");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_shaft", "shaft");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_research", "research");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_office_2ndfloor", "office_2ndfloor");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_warehouse_2ndfloor", "warehouse_2ndfloor");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_crate", "crate");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_halogen", "halogen");
}

strikezone() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_strikezone_bar", "bar");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_strikezone_bar_behind", "bar_behind");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_strikezone_backentrance", "backentrance");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_strikezone_Ronnies_01", "Ronnies_01");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_strikezone_proshop", "proshop");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_strikezone_statue", "statue");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_strikezone_skywalk", "skywalk");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_strikezone_concessions", "concessions");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_strikezone_atrium", "atrium");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_strikezone_concourse_upper", "concourse_upper");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_strikezone_concourse_lower", "concourse_lower");
}

warhawk() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_ambulancebay", "ambulancebay");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_bar", "bar");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_bakery", "bakery");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_loadingdock", "loadingdock");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_granary", "granary");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_icecream", "icecream");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_apartment", "apartment");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_loft", "loft");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_cityhall", "cityhall");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_postoffice", "postoffice");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_alley_fence", "alley_fence");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_backlot", "backlot");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_carport", "carport");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_hardwarestore", "hardwarestore");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_drugstore", "drugstore");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_trailer", "trailer");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_watertower", "watertower");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_repairshop", "repairshop");
}

zebra() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_zebra_sciencelab", "sciencelab");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zebra_radiostation", "radiostation");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zebra_hangar", "hangar");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zebra_guardtower", "guardtower");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zebra_bunker", "bunker");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zebra_solarpanels", "solarpanels");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zebra_hill", "hill");
}

red_river() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_red_river_church", "church");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_red_river_church_tower", "church_tower");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_red_river_pooltables", "pooltables");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_red_river_bar_inside", "bar_inside");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_red_river_autoshop_near", "autoshop_near");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_red_river_autoshop_2ndfloor", "autoshop_2ndfloor_dlc1");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_red_river_grocery", "grocery");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_red_river_roof_bar", "roof_bar");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_red_river_parkinglot", "parkinglot");
}

rumble() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rumble_giftshop", "giftshop");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_rumble_coffeeshop", "coffeeshop");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_rumble_coffeeshop_2ndfloor", "coffeeshop_2ndfloor");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_rumble_lighthouse", "lighthouse");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_rumble_lighthouse_roof", "lighthouse_roof");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_rumble_pier_north", "pier_north");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_rumble_pier_south", "pier_south");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_rumble_aquarium", "aquarium");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_rumble_fishtank", "fishtank");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_rumble_infocenter", "infocenter");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_rumble_museum", "museum");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_rumble_fountain", "fountain");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_rumble_bakery_near", "bakery_near");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_rumble_cablecar", "cablecar");
}

swamp() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_swamp_campsite", "campsite");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_swamp_ruinedhouse", "ruinedhouse");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_swamp_hovercraft", "hovercraft");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_swamp_cave", "cave");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_swamp_granary", "granary_dlc1");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_swamp_granary_2ndfloor", "granary_2ndfloor");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_swamp_treeroots", "treeroots");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_swamp_camper", "camper");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_swamp_camper_2ndfloor", "camper_2ndfloor");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_swamp_backshed", "backshed");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_swamp_marina", "marina");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_swamp_gaspumps", "gaspumps");
}

dome() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dome_digger", "digger");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dome_dig_site", "dig_site");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dome_crane", "crane");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dome_meteor", "meteor");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dome_commandcenter", "commandcenter");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dome_lockerroom", "lockerroom");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dome_fabrictunnel", "fabrictunnel");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dome_spotlight", "spotlight");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dome_scaffolding", "scaffolding");
}

boneyard() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_boneyard_launchpad", "launchpad");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_boneyard_missioncontrol", "missioncontrol");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_boneyard_missioncontrol_2ndfloor", "missioncontrol_2ndfloor");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_boneyard_countdown", "countdown");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_boneyard_fueltank_large", "fueltank_large");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_boneyard_crawler", "crawler");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_boneyard_crawler_2ndfloor", "crawler_2ndfloor");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_boneyard_crawler_3rdfloor", "crawler_3rdfloor");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_boneyard_testplatform", "testplatform");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_boneyard_rockettest", "rockettest");
}

impact() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_impact_bunkroom", "bunkroom");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_impact_kitchen", "kitchen2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_impact_breakroom", "breakroom2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_impact_bridge", "bridge2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_impact_infirmary", "infirmary");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_impact_crane", "crane2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_impact_bridge_under", "bridge_under2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_impact_lowerhold", "lowerhold");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_impact_bathroom", "bathroom2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_impact_portside", "portside");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_impact_starboardside", "starboardside");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_impact_bridge_brooklyn", "bridge_brooklyn");
}

behemoth() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_behemoth_controltower", "controltower");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_behemoth_commandroom", "commandroom");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_behemoth_conveyor_upper", "conveyor_upper");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_behemoth_conveyor_lower", "conveyor_lower");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_behemoth_breakroom", "breakroom2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_behemoth_engineroom", "engineroom");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_behemoth_fueltank", "fueltank");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_behemoth_cargocrates", "cargocrates");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_behemoth_bucketwheel", "bucketwheel");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_behemoth_conveyorcontrol", "conveyorcontrol");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_behemoth_doghouse", "doghouse");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_behemoth_generators", "generators");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_behemoth_turntable_west", "turntable_west");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_behemoth_turntable_east", "turntable_east");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_behemoth_side_north", "side_north");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_behemoth_side_south", "side_south");
}

battery() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_battery_scaffolding", "scaffolding2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_battery_sundial", "sundial");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_battery_statue", "statue2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_battery_stonehead", "stonehead");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_battery_truck", "truck");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_battery_tower", "tower2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_battery_courtyard", "courtyard2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_battery_pyramid", "pyramid");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_battery_crypt", "crypt");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_battery_altar", "altar");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_battery_bridge", "bridge2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_battery_aqueduct", "aqueduct");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_battery_waterfall", "waterfall2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_battery_bathhouse", "bathhouse");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_battery_fountain", "fountain2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_battery_woods", "woods");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_battery_cliff", "cliff");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_battery_tunnels", "tunnels");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_battery_trophyroom", "trophyroom");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_battery_armory", "armory");
}

favela() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_favela_barber_shop", "barber_shop");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_favela_bus_stop", "bus_stop");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_favela_graveyard", "graveyard");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_favela_bar2", "bar2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_favela_bar_rooftop", "bar_rooftop");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_favela_soccer_field", "soccer_field");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_favela_playground2", "playground2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_favela_icecream_shop", "icecream_shop");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_favela_icecream_shop_2ndfloor", "icecream_shop_2ndfloor");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_favela_market", "market");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_favela_market_rooftop", "market_rooftop");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_favela_rooftop_garden", "rooftop_garden");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_favela_sodashop", "sodashop");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_favela_safe_house", "safe_house");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_favela_shanties", "shanties");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_favela_dump_site", "dump_site");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_favela_checkpoint", "checkpoint");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_favela_abandoned_apartments", "abandoned_apartments");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_favela_greenapartment", "greenapartment");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_favela_greenapartment_roof", "greenapartment_roof");
}

dig() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dig_shrine", "shrine");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dig_kingstomb", "kingstomb");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dig_balcony", "balcony");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dig_mummytomb", "mummytomb");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dig_anubishall", "anubishall");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dig_digsite", "digsite");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dig_platform", "platform");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dig_dogstatues", "dogstatues");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dig_courtyard3", "courtyard3");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dig_pharaohsgate", "pharaohsgate");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dig_burialchamber", "burialchamber");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dig_sphinxhead", "sphinxhead");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dig_queenstomb", "queenstomb");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dig_treasureroom", "treasureroom");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dig_heiroglyphhall", "heiroglyphhall");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_dig_oasis", "oasis");
}

pirate() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_pirate_overlook", "overlook");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_pirate_captainsquarters", "captainsquarters");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_pirate_shipprow", "shipprow");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_pirate_tavern", "tavern");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_pirate_cellar", "cellar");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_pirate_drawbridge", "drawbridge");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_pirate_inn", "inn");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_pirate_voodoohouse", "voodoohouse");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_pirate_courtyard3", "courtyard3");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_pirate_prisoncells", "prisoncells");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_pirate_undertakers", "undertakers");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_pirate_gallows", "gallows");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_pirate_brothel", "brothel");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_pirate_loadingdock2", "loadingdock2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_pirate_watchtower", "watchtower");
}

zulu() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_zulu_cemetery", "cemetery");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zulu_statue3", "statue3");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zulu_market", "market");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zulu_apartments", "apartments");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zulu_bar2", "bar2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zulu_church2", "church2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zulu_tire_stack", "tire_stack");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zulu_loading_dock", "loading_dock");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zulu_float", "float");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zulu_scaffolding3", "scaffolding3");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zulu_hotel2", "hotel2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zulu_florist", "florist");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zulu_hearse", "hearse");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zulu_butcher", "butcher");
}

shipment() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_shipment_winnersstage", "winnersstage");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_shipment_broadcasterbooth", "broadcasterbooth");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_shipment_armory", "armory");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_shipment_bettingwindow", "bettingwindow");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_shipment_arena_red", "arena_red");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_shipment_arena_blue", "arena_blue");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_shipment_puzzlebox", "puzzlebox");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_shipment_walkoffame", "walkoffame");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_shipment_walkoffame_near", "walkoffame_near");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_shipment_tower", "tower");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_shipment_display", "display");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_shipment_car_green", "car_green");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_shipment_car_yellow", "car_yellow");
}

conflict() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_conflict_market_old", "market_old");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_conflict_market_new", "market_new");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_conflict_market_east", "market_east");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_conflict_market_west", "market_west");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_conflict_communityhall", "communityhall");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_conflict_fishingpier", "fishingpier");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_conflict_dock", "dock");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_conflict_waterside", "waterside");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_conflict_cliffside", "cliffside");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_conflict_garden", "garden");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_conflict_temple", "temple");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_conflict_mansion2", "mansion2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_conflict_fishinghuts", "fishinghuts");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_conflict_alley", "alley");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_conflict_dragonstatues", "dragonstatues");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_conflict_restaurant2", "restaurant2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_conflict_kitchen3", "kitchen3");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_conflict_dojo", "dojo");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_conflict_greenhouse", "greenhouse");
}

mine() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_mine_train", "train");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_mine_trainstation", "trainstation");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_mine_watertower2", "watertower2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_mine_platform", "platform");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_mine_elevator2", "elevator2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_mine_refinery", "refinery");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_mine_cliffs", "cliffs");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_mine_mine2", "mine2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_mine_refinerystairs", "refinerystairs");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_mine_waterfall3", "waterfall3");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_mine_staircase", "staircase");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_mine_tunnels2", "tunnels2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_mine_hotsprings", "hotsprings");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_mine_car_rusty", "car_rusty");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_mine_redbuilding", "redbuilding");
}

zerosub() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_zerosub_vents", "vents");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zerosub_missilefactory", "missilefactory");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zerosub_offices", "offices");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zerosub_hallway", "hallway");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zerosub_controlroom2", "controlroom2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zerosub_messhall", "messhall");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zerosub_hockeyrink", "hockeyrink");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zerosub_missilestorage", "missilestorage");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zerosub_snowbank", "snowbank");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zerosub_utilityroom", "utilityroom");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zerosub_lab", "lab");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zerosub_tent", "tent");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zerosub_submarine", "submarine");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zerosub_securitytower", "securitytower");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zerosub_crane2", "crane2");

  add_bcs_location_mapping("trigger_multiple_bcs_mp_zerosub_fueltank2", "fueltank2");
}