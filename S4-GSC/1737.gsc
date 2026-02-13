/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1737.gsc
*************************************************/

_id_2446() {
  level._id_2444 = [];
  _id_2445();

  if(isDefined(level._id_6018)) {
    [[level._id_6018]]();
  }

  _id_2455();
  level._id_2444 = undefined;
  anim._id_96D9 = [];
}

_id_2455() {
  anim._id_2447 = [];
  var_0 = getEntArray("trigger_multiple", "code_classname");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!issubstr(var_3.classname, "trigger_multiple_bcs")) {
      continue;
    }
    if(isDefined(level.mapname) && level.mapname == "mp_crash2" && var_3.classname == "trigger_multiple_bcs_dronecrash") {
      continue;
    }
    var_1[var_1.size] = var_3;

    if(!isDefined(level._id_2444[var_3.classname])) {
      continue;
    }
    var_4 = _id_AE71(level._id_2444[var_3.classname]);

    if(var_4.size > 1) {
      var_4 = scripts\engine\utility::array_randomize(var_4);
    }

    var_3._id_96D6 = var_4;

    if(var_3._id_03EA & 1) {
      var_3._id_88FB = 1;
    }
  }

  anim._id_2447 = var_1;
}

_id_AE71(var_0) {
  var_1 = strtok(var_0, " ");
  return var_1;
}

_id_0F9F(var_0, var_1) {
  if(isDefined(level._id_2444[var_0])) {
    var_2 = level._id_2444[var_0];
    var_3 = _id_AE71(var_2);
    var_4 = _id_AE71(var_1);

    foreach(var_6 in var_4) {
      foreach(var_8 in var_3) {
        if(var_6 == var_8) {
          return;
        }
      }
    }

    var_2 = var_2 + (" " + var_1);
    level._id_2444[var_0] = var_2;
  } else
    level._id_2444[var_0] = var_1;
}

_id_2445() {
  if(scripts\common\utility::issp()) {
    _id_E074();
    _id_E07C();
    _id_E07F();
  } else
    _id_A291();
}

_id_E074() {
  _id_0F9F("trigger_multiple_bcs_sp_1stfloor", "1stfloor");
  _id_0F9F("trigger_multiple_bcs_sp_2ndfloor", "2ndfloor");
  _id_0F9F("trigger_multiple_bcs_sp_3rdfloor", "3rdfloor");
  _id_0F9F("trigger_multiple_bcs_sp_4thfloor", "4thfloor");
  _id_0F9F("trigger_multiple_bcs_sp_5thfloor", "5thfloor");
  _id_0F9F("trigger_multiple_bcs_sp_alcove", "alcove");
  _id_0F9F("trigger_multiple_bcs_sp_alley", "alley");
  _id_0F9F("trigger_multiple_bcs_sp_balcony", "balcony");
  _id_0F9F("trigger_multiple_bcs_sp_bar", "bar");
  _id_0F9F("trigger_multiple_bcs_sp_barrel", "barrel");
  _id_0F9F("trigger_multiple_bcs_sp_barrels", "barrels");
  _id_0F9F("trigger_multiple_bcs_sp_barrels_blue", "barrelsblue");
  _id_0F9F("trigger_multiple_bcs_sp_barrier", "barrier");
  _id_0F9F("trigger_multiple_bcs_sp_barrier_concrete", "barrierconcrete");
  _id_0F9F("trigger_multiple_bcs_sp_bathroom", "bathroom");
  _id_0F9F("trigger_multiple_bcs_sp_bedroom", "bedroom");
  _id_0F9F("trigger_multiple_bcs_sp_chair", "chair");
  _id_0F9F("trigger_multiple_bcs_sp_couch", "couch");
  _id_0F9F("trigger_multiple_bcs_sp_counter", "counter");
  _id_0F9F("trigger_multiple_bcs_sp_desk", "desk");
  _id_0F9F("trigger_multiple_bcs_sp_doorway", "doorway");
  _id_0F9F("trigger_multiple_bcs_sp_groundfloor", "groundfloor");
  _id_0F9F("trigger_multiple_bcs_sp_stairs", "stairs");
  _id_0F9F("trigger_multiple_bcs_sp_upstairs", "upstairs");
  _id_0F9F("trigger_multiple_bcs_sp_window", "window");
  _id_0F9F("trigger_multiple_bcs_sp_building_top", "buildingtop");
  _id_0F9F("trigger_multiple_bcs_sp_catwalk", "catwalk");
  _id_0F9F("trigger_multiple_bcs_sp_entrance", "entrance");
  _id_0F9F("trigger_multiple_bcs_sp_exterior", "exterior");
  _id_0F9F("trigger_multiple_bcs_sp_frontdoors", "frontdoors");
  _id_0F9F("trigger_multiple_bcs_sp_patio", "patio");
  _id_0F9F("trigger_multiple_bcs_sp_railing", "railing");
  _id_0F9F("trigger_multiple_bcs_sp_roof", "roof");
  _id_0F9F("trigger_multiple_bcs_sp_scaffolding", "scaffolding");
  _id_0F9F("trigger_multiple_bcs_sp_siloontop", "siloontop");
  _id_0F9F("trigger_multiple_bcs_sp_silos", "silos");
  _id_0F9F("trigger_multiple_bcs_sp_closet", "closet");
  _id_0F9F("trigger_multiple_bcs_sp_diningroom", "diningroom");
  _id_0F9F("trigger_multiple_bcs_sp_hallway", "hallway");
  _id_0F9F("trigger_multiple_bcs_sp_interior", "interior");
  _id_0F9F("trigger_multiple_bcs_sp_kitchen", "kitchen");
  _id_0F9F("trigger_multiple_bcs_sp_livingroom", "livingroom");
  _id_0F9F("trigger_multiple_bcs_sp_lobby", "lobby");
  _id_0F9F("trigger_multiple_bcs_sp_room", "room");
  _id_0F9F("trigger_multiple_bcs_sp_waitingroom", "waitingroom");
  _id_0F9F("trigger_multiple_bcs_sp_btwnbuildings", "btwnbuildings");
  _id_0F9F("trigger_multiple_bcs_sp_building", "building");
  _id_0F9F("trigger_multiple_bcs_sp_bunker", "bunker");
  _id_0F9F("trigger_multiple_bcs_sp_cafe", "cafe");
  _id_0F9F("trigger_multiple_bcs_sp_church", "church");
  _id_0F9F("trigger_multiple_bcs_sp_clocktower", "clocktower");
  _id_0F9F("trigger_multiple_bcs_sp_compound", "compound");
  _id_0F9F("trigger_multiple_bcs_sp_container", "container");
  _id_0F9F("trigger_multiple_bcs_sp_container_shipping", "containershipping");
  _id_0F9F("trigger_multiple_bcs_sp_corner", "corner");
  _id_0F9F("trigger_multiple_bcs_sp_corridor", "corridor");
  _id_0F9F("trigger_multiple_bcs_sp_courtyard", "courtyard");
  _id_0F9F("trigger_multiple_bcs_sp_crypt", "crypt");
  _id_0F9F("trigger_multiple_bcs_sp_field", "field");
  _id_0F9F("trigger_multiple_bcs_sp_garage", "garage");
  _id_0F9F("trigger_multiple_bcs_sp_garden", "garden");
  _id_0F9F("trigger_multiple_bcs_sp_grass", "grass");
  _id_0F9F("trigger_multiple_bcs_sp_graveyard", "graveyard");
  _id_0F9F("trigger_multiple_bcs_sp_greenhouse", "greenhouse");
  _id_0F9F("trigger_multiple_bcs_sp_hangar", "hangar");
  _id_0F9F("trigger_multiple_bcs_sp_hospital", "hospital");
  _id_0F9F("trigger_multiple_bcs_sp_house", "house");
  _id_0F9F("trigger_multiple_bcs_sp_lake", "lake");
  _id_0F9F("trigger_multiple_bcs_sp_loadingdock", "loadingdock");
  _id_0F9F("trigger_multiple_bcs_sp_mansion", "mansion");
  _id_0F9F("trigger_multiple_bcs_sp_mgnest", "mgnest");
  _id_0F9F("trigger_multiple_bcs_sp_office", "office");
  _id_0F9F("trigger_multiple_bcs_sp_parkinglot", "parkinglot");
  _id_0F9F("trigger_multiple_bcs_sp_perimeter", "perimeter");
  _id_0F9F("trigger_multiple_bcs_sp_pool", "pool");
  _id_0F9F("trigger_multiple_bcs_sp_poolhouse", "poolhouse");
  _id_0F9F("trigger_multiple_bcs_sp_ridge", "ridge");
  _id_0F9F("trigger_multiple_bcs_sp_road", "road");
  _id_0F9F("trigger_multiple_bcs_sp_sidewalk", "sidewalk");
  _id_0F9F("trigger_multiple_bcs_sp_street", "street");
  _id_0F9F("trigger_multiple_bcs_sp_tarmac", "tarmac");
  _id_0F9F("trigger_multiple_bcs_sp_tower", "tower");
  _id_0F9F("trigger_multiple_bcs_sp_brick_stack", "bricksstack");
  _id_0F9F("trigger_multiple_bcs_sp_bushes", "bushes");
  _id_0F9F("trigger_multiple_bcs_sp_crate", "crate");
  _id_0F9F("trigger_multiple_bcs_sp_crates", "crates");
  _id_0F9F("trigger_multiple_bcs_sp_cratesammo", "cratesammo");
  _id_0F9F("trigger_multiple_bcs_sp_debris", "debris");
  _id_0F9F("trigger_multiple_bcs_sp_dumpster", "dumpster");
  _id_0F9F("trigger_multiple_bcs_sp_fence", "fence");
  _id_0F9F("trigger_multiple_bcs_sp_haybale", "haybale");
  _id_0F9F("trigger_multiple_bcs_sp_hesco", "hesco");
  _id_0F9F("trigger_multiple_bcs_sp_ladder", "ladder");
  _id_0F9F("trigger_multiple_bcs_sp_pillar", "pillar");
  _id_0F9F("trigger_multiple_bcs_sp_planter", "planter");
  _id_0F9F("trigger_multiple_bcs_sp_pooltable", "pooltable");
  _id_0F9F("trigger_multiple_bcs_sp_rubble", "rubble");
  _id_0F9F("trigger_multiple_bcs_sp_sandbags", "sandbags");
  _id_0F9F("trigger_multiple_bcs_sp_shelves", "shelves");
  _id_0F9F("trigger_multiple_bcs_sp_table", "table");
  _id_0F9F("trigger_multiple_bcs_sp_trash", "trash");
  _id_0F9F("trigger_multiple_bcs_sp_trash_can", "trashcan");
  _id_0F9F("trigger_multiple_bcs_sp_tree", "tree");
  _id_0F9F("trigger_multiple_bcs_sp_trees", "trees");
  _id_0F9F("trigger_multiple_bcs_sp_turbine", "turbine");
  _id_0F9F("trigger_multiple_bcs_sp_turbines", "turbines");
  _id_0F9F("trigger_multiple_bcs_sp_wall", "wall");
  _id_0F9F("trigger_multiple_bcs_sp_wall_block", "wallblock");
  _id_0F9F("trigger_multiple_bcs_sp_wall_brick", "wallbrick");
  _id_0F9F("trigger_multiple_bcs_sp_bulldozer", "bulldozer");
  _id_0F9F("trigger_multiple_bcs_sp_bus", "bus");
  _id_0F9F("trigger_multiple_bcs_sp_car", "car");
  _id_0F9F("trigger_multiple_bcs_sp_car_black", "carblack");
  _id_0F9F("trigger_multiple_bcs_sp_car_blue", "carblue");
  _id_0F9F("trigger_multiple_bcs_sp_car_destroyed", "cardestroyed");
  _id_0F9F("trigger_multiple_bcs_sp_car_green", "cargreen");
  _id_0F9F("trigger_multiple_bcs_sp_car_grey", "cargrey");
  _id_0F9F("trigger_multiple_bcs_sp_car_red", "carred");
  _id_0F9F("trigger_multiple_bcs_sp_car_silver", "carsilver");
  _id_0F9F("trigger_multiple_bcs_sp_car_white", "carwhite");
  _id_0F9F("trigger_multiple_bcs_sp_forklift", "forklift");
  _id_0F9F("trigger_multiple_bcs_sp_pickup", "pickup");
  _id_0F9F("trigger_multiple_bcs_sp_policecar", "policecar");
  _id_0F9F("trigger_multiple_bcs_sp_tactical", "tactical");
  _id_0F9F("trigger_multiple_bcs_sp_tank_destroyed", "tankdestroyed");
  _id_0F9F("trigger_multiple_bcs_sp_truck", "truck");
  _id_0F9F("trigger_multiple_bcs_sp_truck_destroyed", "truckdestroyed");
  _id_0F9F("trigger_multiple_bcs_sp_truck_green", "truckgreen");
  _id_0F9F("trigger_multiple_bcs_sp_truck_white", "truckwhite");
  _id_0F9F("trigger_multiple_bcs_sp_van", "van");
}

_id_E07C() {
  _id_0F9F("trigger_multiple_bcs_sp_embassy_compound", "compound");
  _id_0F9F("trigger_multiple_bcs_sp_embassy_dirtmound", "dirtmound");
  _id_0F9F("trigger_multiple_bcs_sp_embassy_metalcart", "metalcart");
  _id_0F9F("trigger_multiple_bcs_sp_embassy_tirestack", "tirestack");
  _id_0F9F("trigger_multiple_bcs_sp_embassy_field", "field");
  _id_0F9F("trigger_multiple_bcs_sp_embassy_pillars", "pillars");
}

_id_E07F() {
  _id_0F9F("trigger_multiple_bcs_sp_lab_object_turbine", "turbine");
  _id_0F9F("trigger_multiple_bcs_sp_lab_area_turbineroom", "turbineroom");
  _id_0F9F("trigger_multiple_bcs_sp_lab_object_gastanks", "gastanks");
}

_id_A291() {
  _id_0F9F("trigger_multiple_bcs_backalley", "backalley");
  _id_0F9F("trigger_multiple_bcs_barbershop", "barbershop");
  _id_0F9F("trigger_multiple_bcs_barn", "barn");
  _id_0F9F("trigger_multiple_bcs_barrel", "barrel");
  _id_0F9F("trigger_multiple_bcs_bazaar", "bazaar");
  _id_0F9F("trigger_multiple_bcs_boilerroom", "boilerroom");
  _id_0F9F("trigger_multiple_bcs_bridge", "bridge");
  _id_0F9F("trigger_multiple_bcs_buses", "buses");
  _id_0F9F("trigger_multiple_bcs_cafe", "cafe");
  _id_0F9F("trigger_multiple_bcs_canalstreete", "canalstreet");
  _id_0F9F("trigger_multiple_bcs_caveentrance", "caveentrance");
  _id_0F9F("trigger_multiple_bcs_center", "center");
  _id_0F9F("trigger_multiple_bcs_checkpoint", "checkpoint");
  _id_0F9F("trigger_multiple_bcs_showers", "showers");
  _id_0F9F("trigger_multiple_bcs_chickens", "chickens");
  _id_0F9F("trigger_multiple_bcs_church", "church");
  _id_0F9F("trigger_multiple_bcs_compound", "compound");
  _id_0F9F("trigger_multiple_bcs_construction", "construction");
  _id_0F9F("trigger_multiple_bcs_containers", "containers");
  _id_0F9F("trigger_multiple_bcs_container", "container");
  _id_0F9F("trigger_multiple_bcs_courtyard", "courtyard");
  _id_0F9F("trigger_multiple_bcs_crossroads", "crossroads");
  _id_0F9F("trigger_multiple_bcs_destroyedbldg", "destroyedbldg");
  _id_0F9F("trigger_multiple_bcs_dronecrash", "dronecrash");
  _id_0F9F("trigger_multiple_bcs_dumpster", "dumpster");
  _id_0F9F("trigger_multiple_bcs_electronicstore", "electronicstore");
  _id_0F9F("trigger_multiple_bcs_elevator", "elevator");
  _id_0F9F("trigger_multiple_bcs_fob", "fob");
  _id_0F9F("trigger_multiple_bcs_forklift", "forklift");
  _id_0F9F("trigger_multiple_bcs_graveyard", "graveyard");
  _id_0F9F("trigger_multiple_bcs_garage", "garage");
  _id_0F9F("trigger_multiple_bcs_gunshop", "gunshop");
  _id_0F9F("trigger_multiple_bcs_hazmatbldg", "hazmatbldg");
  _id_0F9F("trigger_multiple_bcs_hotel", "hotel");
  _id_0F9F("trigger_multiple_bcs_junkyard", "junkyard");
  _id_0F9F("trigger_multiple_bcs_launchers", "launchers");
  _id_0F9F("trigger_multiple_bcs_laundromat", "laundromat");
  _id_0F9F("trigger_multiple_bcs_mainstreet", "mainstreet");
  _id_0F9F("trigger_multiple_bcs_minecarts", "minecarts");
  _id_0F9F("trigger_multiple_bcs_office", "office");
  _id_0F9F("trigger_multiple_bcs_palacedome", "palacedome");
  _id_0F9F("trigger_multiple_bcs_playground", "playground");
  _id_0F9F("trigger_multiple_bcs_poolhall", "poolhall");
  _id_0F9F("trigger_multiple_bcs_restaurant", "restaurant");
  _id_0F9F("trigger_multiple_bcs_riverbed", "riverbed");
  _id_0F9F("trigger_multiple_bcs_rugshop", "rugshop");
  _id_0F9F("trigger_multiple_bcs_scaffold", "scaffold");
  _id_0F9F("trigger_multiple_bcs_school", "school");
  _id_0F9F("trigger_multiple_bcs_shantytown", "shantytown");
  _id_0F9F("trigger_multiple_bcs_shippingarea", "shippingarea");
  _id_0F9F("trigger_multiple_bcs_shops", "shops");
  _id_0F9F("trigger_multiple_bcs_showers", "showers");
  _id_0F9F("trigger_multiple_bcs_smokestack", "smokestack");
  _id_0F9F("trigger_multiple_bcs_soapshop", "soapshop");
  _id_0F9F("trigger_multiple_bcs_stonebridge", "stonebridge");
  _id_0F9F("trigger_multiple_bcs_swimmingpool", "swimmingpool");
  _id_0F9F("trigger_multiple_bcs_taxibldg", "taxibldg");
  _id_0F9F("trigger_multiple_bcs_tireshop", "tireshop");
  _id_0F9F("trigger_multiple_bcs_tower", "tower");
  _id_0F9F("trigger_multiple_bcs_traintracks", "traintracks");
  _id_0F9F("trigger_multiple_bcs_tramstation", "tramstation");
  _id_0F9F("trigger_multiple_bcs_trench", "trench");
  _id_0F9F("trigger_multiple_bcs_warehouse", "warehouse");
  _id_0F9F("trigger_multiple_bcs_watertower", "watertower");
  _id_0F9F("trigger_multiple_bcs_windmill", "windmill");
  _id_0F9F("trigger_multiple_bcs_woods", "woods");
  _id_0F9F("trigger_multiple_bcs_yellowbldg", "yellowbldg");
}