/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42215.gsc
**************************************/

bcs_location_trigs_init() {
  if(isDefined(level.dds) && isDefined(anim.bcs_locations)) {
    return;
  }
  level.bcs_location_mappings = [];
  bcs_location_trigger_mapping();
  bcs_trigs_assign_aliases();
  level.bcs_location_mappings = undefined;
  anim.locationlastcallouttimes = [];
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

    var_3.locationaliases = var_6;
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

bcs_location_trigger_mapping() {
  if(common_scripts\utility::issp()) {
    generic_locations();
    fusion_locations();
    sanfran_locations();
    sanfran_b_locations();
    greece_locations();
    seoul_locations();
    detroit_locations();
    betrayal_locations();
    lab_locations();
    recovery_locations();
    lagos_locations();
    merida();
    old_locations();
  } else {
    laser2_mp();
    lab2_mp();
    mp_refraction();
    mp_prison();
    mp_dam();
    mp_detroit();
    mp_greenband();
    mp_instinct();
    mp_levity();
    mp_recovery();
    mp_solar();
    mp_terrace();
    mp_torqued();
    mp_venus();
    mp_comeback();
    old_locations_mp();
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

fusion_locations() {
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

sanfran_locations() {
  add_bcs_location_mapping("trigger_multiple_bcs_sfa_bus", "sfa_bus");
  add_bcs_location_mapping("trigger_multiple_bcs_sfa_cardoor", "sfa_cardoor");
  add_bcs_location_mapping("trigger_multiple_bcs_sfa_cargovan", "sfa_cargovan");
  add_bcs_location_mapping("trigger_multiple_bcs_sfa_policecar", "sfa_policecar");
  add_bcs_location_mapping("trigger_multiple_bcs_sfa_roadsign", "sfa_roadsign");
  add_bcs_location_mapping("trigger_multiple_bcs_sfa_sidewalk", "sfa_sidewalk");
  add_bcs_location_mapping("trigger_multiple_bcs_sfa_sportscar", "sfa_sportscar");
  add_bcs_location_mapping("trigger_multiple_bcs_sfa_topbus", "sfa_topbus");
  add_bcs_location_mapping("trigger_multiple_bcs_sfa_tower", "sfa_tower");
  add_bcs_location_mapping("trigger_multiple_bcs_sfa_trailer", "sfa_trailer");
  add_bcs_location_mapping("trigger_multiple_bcs_sfa_truck", "sfa_truck");
}

sanfran_b_locations() {
  add_bcs_location_mapping("trigger_multiple_bcs_sfb_above", "above");
  add_bcs_location_mapping("trigger_multiple_bcs_sfb_containers", "sfb_containers");
  add_bcs_location_mapping("trigger_multiple_bcs_sfb_doors", "doors");
  add_bcs_location_mapping("trigger_multiple_bcs_sfb_helipad", "helipad");
  add_bcs_location_mapping("trigger_multiple_bcs_sfb_missileturret", "missileturret");
  add_bcs_location_mapping("trigger_multiple_bcs_sfb_table", "table");
  add_bcs_location_mapping("trigger_multiple_bcs_sfb_truck", "sfb_truck");
  add_bcs_location_mapping("trigger_multiple_bcs_sfb_vtol", "vtol");
  add_bcs_location_mapping("trigger_multiple_bcs_sfb_wreckage", "wreckage");
  add_bcs_location_mapping("trigger_multiple_bcs_sfb_cargocrane", "cargocrane");
  add_bcs_location_mapping("trigger_multiple_bcs_sfb_catwalk", "sfb_catwalk");
  add_bcs_location_mapping("trigger_multiple_bcs_sfb_console", "sfb_console");
  add_bcs_location_mapping("trigger_multiple_bcs_sfb_jammer", "sfb_jammer");
  add_bcs_location_mapping("trigger_multiple_bcs_sfb_launchpad", "sfb_launchpad");
  add_bcs_location_mapping("trigger_multiple_bcs_sfb_jet", "sfb_jet");
}

greece_locations() {
  add_bcs_location_mapping("trigger_multiple_bcs_grk_balcony", "grk_balcony");
  add_bcs_location_mapping("trigger_multiple_bcs_grk_1stfloor_window", "grk_1stfloor_window");
  add_bcs_location_mapping("trigger_multiple_bcs_grk_2ndfloor_window", "grk_2ndfloor_window");
  add_bcs_location_mapping("trigger_multiple_bcs_grk_3rdfloor_window", "grk_3rdfloor_window");
  add_bcs_location_mapping("trigger_multiple_bcs_grk_cafe", "grk_cafe");
  add_bcs_location_mapping("trigger_multiple_bcs_grk_rooftop", "grk_rooftop");
  add_bcs_location_mapping("trigger_multiple_bcs_grk_doorway", "grk_doorway");
  add_bcs_location_mapping("trigger_multiple_bcs_gre_vehic", "gre_vehic");
  add_bcs_location_mapping("trigger_multiple_bcs_gre_statue", "gre_statue");
}

seoul_locations() {
  add_bcs_location_mapping("trigger_multiple_bcs_seo_balcony", "seo_balcony");
  add_bcs_location_mapping("trigger_multiple_bcs_seo_bus", "seo_bus");
  add_bcs_location_mapping("trigger_multiple_bcs_seo_stairs", "seo_stairs");
  add_bcs_location_mapping("trigger_multiple_bcs_seo_2ndwindow", "seo_2ndwindow");
  add_bcs_location_mapping("trigger_multiple_bcs_seo_3rdbalcony", "seo_3rdbalcony");
  add_bcs_location_mapping("trigger_multiple_bcs_seo_sculpture", "seo_sculpture");
  add_bcs_location_mapping("trigger_multiple_bcs_seo_window", "seo_window");
  add_bcs_location_mapping("trigger_multiple_bcs_seo_window", "seo_window");
  add_bcs_location_mapping("trigger_multiple_bcs_seo_cafe", "seo_cafe");
  add_bcs_location_mapping("trigger_multiple_bcs_seo_counter", "seo_counter");
}

detroit_locations() {
  add_bcs_location_mapping("trigger_multiple_bcs_det_bar", "det_bar");
  add_bcs_location_mapping("trigger_multiple_bcs_det_balcony", "det_balcony");
  add_bcs_location_mapping("trigger_multiple_bcs_det_walkway", "det_walkway");
  add_bcs_location_mapping("trigger_multiple_bcs_det_ambulance", "det_ambulance");
}

betrayal_locations() {
  add_bcs_location_mapping("trigger_multiple_bcs_bet_plaza", "bet_plaza");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_way", "bet_way");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_1stfloor", "bet_1stfloor");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_2ndfloor", "bet_2ndfloor");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_3rdfloor", "bet_3rdfloor");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_above", "bet_above");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_balcony", "bet_balcony");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_barge", "bet_barge");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_checkpt", "bet_checkpt");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_doorway", "bet_doorway");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_open", "bet_open");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_patio", "bet_patio");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_rooftop", "bet_rooftop");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_street", "bet_street");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_drones", "bet_drones");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_fountain", "bet_fountain");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_skybridge", "bet_skybridge");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_below", "bet_below");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_bldng", "bet_bldng");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_bridge", "bet_bridge");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_deplycover", "bet_deplycover");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_pallets", "bet_pallets");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_catwalk", "bet_catwalk");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_table", "bet_table");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_crates", "bet_crates");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_dock", "bet_dock");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_leftshore", "bet_leftshore");
  add_bcs_location_mapping("trigger_multiple_bcs_bet_rightshore", "bet_rightshore");
}

lab_locations() {
  add_bcs_location_mapping("trigger_multiple_bcs_lab_canisters", "lab_canisters");
  add_bcs_location_mapping("trigger_multiple_bcs_lab_camera", "lab_camera");
  add_bcs_location_mapping("trigger_multiple_bcs_lab_van", "lab_van");
  add_bcs_location_mapping("trigger_multiple_bcs_lab_lwrcatwalk", "lab_lwrcatwalk");
  add_bcs_location_mapping("trigger_multiple_bcs_lab_uprcatwalk", "lab_uprcatwalk");
  add_bcs_location_mapping("trigger_multiple_bcs_lab_forklift", "lab_forklift");
  add_bcs_location_mapping("trigger_multiple_bcs_lab_rooftop", "lab_rooftop");
}

recovery_locations() {
  add_bcs_location_mapping("trigger_multiple_bcs_rec_firepit", "rec_firepit");
  add_bcs_location_mapping("trigger_multiple_bcs_rec_hill", "rec_hill");
  add_bcs_location_mapping("trigger_multiple_bcs_rec_pool", "rec_pool");
  add_bcs_location_mapping("trigger_multiple_bcs_rec_road", "rec_road");
  add_bcs_location_mapping("trigger_multiple_bcs_rec_patio", "rec_patio");
  add_bcs_location_mapping("trigger_multiple_bcs_rec_table", "rec_table");
  add_bcs_location_mapping("trigger_multiple_bcs_rec_couch", "rec_couch");
}

lagos_locations() {
  add_bcs_location_mapping("trigger_multiple_bcs_lag_street", "lag_street");
  add_bcs_location_mapping("trigger_multiple_bcs_lag_dogs", "lag_dogs");
  add_bcs_location_mapping("trigger_multiple_bcs_lag_median", "lag_median");
  add_bcs_location_mapping("trigger_multiple_bcs_lag_rpgbus", "lag_rpgbus");
  add_bcs_location_mapping("trigger_multiple_bcs_lag_overpass", "lag_overpass");
  add_bcs_location_mapping("trigger_multiple_bcs_lag_suv", "lag_suv");
  add_bcs_location_mapping("trigger_multiple_bcs_lag_suvapproach", "lag_suvapproach");
  add_bcs_location_mapping("trigger_multiple_bcs_lag_topvan", "lag_topvan");
}

merida() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_merida_radiotower", "radiotower");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_merida_embassy_generic", "embassy_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_merida_aaguns", "aaguns");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_merida_tunnel", "tunnel");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_merida_cannons_generic", "cannons_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_merida_pool", "pool");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_merida_embassy_north", "embassy_north");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_merida_embassy_south", "embassy_south");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_merida_embassy_east", "embassy_east");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_merida_embassy_west", "embassy_west");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_merida_cannons_embassy", "cannons_embassy");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_merida_cannons_radiotower", "cannons_radiotower");
}

laser2_mp() {
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

lab2_mp() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lab_parkinglot", "lab_parkinglot");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lab_serverroom", "lab_serverroom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lab_holoroom", "lab_holoroom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lab_dryingroom", "lab_dryingroom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lab_chemvats", "lab_chemvats");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lab_generator", "lab_generator");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lab_lobby", "lab_lobby");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lab_behindcrates", "lab_behindcrates");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lab_scienceroom", "lab_scienceroom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lab_storageroom", "lab_storageroom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lab_trench", "lab_trench");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lab_behindvehicle", "lab_behindvehicle");
}

mp_refraction() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ref_oncrane", "ref_oncrane");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ref_byloadingdocks", "ref_byloadingdocks");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ref_nearelevatorentrance", "ref_nearelevatorentrance");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ref_inelevator", "ref_inelevator");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ref_oncatwalks", "ref_oncatwalks");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ref_seccheckpoint", "ref_seccheckpoint");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ref_helopadentrance", "ref_helopadentracne");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ref_checkinstation", "ref_checkinstation");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ref_maintenceentrance", "ref_maintenceentrance");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ref_insidelounge", "ref_insidelounge");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ref_bylockmechanism", "ref_bylockmechanism");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ref_inelevatorshaft", "ref_inelevatorshaft");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ref_underhelipad", "ref_underhelipad");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ref_bylgcontainers", "ref_bylgcontainers");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ref_bylockers", "ref_bylockers");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ref_abovelockers", "ref_abovelockers");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ref_byadtowers", "ref_byadtowers");
}

mp_prison() {
  add_bcs_location_mapping(" trigger_multiple_bcs_mp_psn_insidecellblock", "psn_insidecellblock");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_psn_psnfrontentrance", "psn_psnfrontentrance");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_psn_insidemaintenancebldg", "psn_insidemaintenancebldg");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_psn_onmaintenancebldgroof", "psn_onmaintenancebldgroof");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_psn_prisonyard", "psn_prisonyard");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_psn_bballcourt", "psn_bballcourt");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_psn_psnbus", "psn_psnbus");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_psn_sectower", "psn_sectower");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_psn_insidegarage", "psn_insidegarage");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_psn_topofgarage", "psn_topofgarage");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_psn_destroyedwall", "psn_destroyedwall");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_psn_cellblockcatwalk", "psn_cellblockcatwalk");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_psn_lobbyentrance", "psn_lobbyentrance");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_psn_electricalbox", "psn_electricalbox");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_psn_policecar", "psn_policecar");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_psn_behinddumpster", "psn_behinddumpster");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_psn_catwalk", "psn_catwalk");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_psn_laundrybin", "psn_laundrybin");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_psn_psnrooftop", "psn_psnrooftop");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_psn_behindac", "psn_behindac");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_psn_insidelockerbldg", "psn_insidelockerbldg");
}

mp_dam() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dam_frontgate", "dam_frontgate");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dam_semitruck", "dam_semitruck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dam_contructionsite", "dam_contructionsite");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dam_insideoffice", "dam_insideoffice");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dam_oncatwalks", "dam_oncatwalks");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dam_centerstreet", "dam_centerstreet");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dam_onminigun", "dam_onminigun");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dam_cranebase", "dam_cranebase");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dam_infactory", "dam_infactory");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dam_inturbinebldg", "dam_inturbinebldg");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dam_movingpipe", "dam_movingpipe");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dam_electricalgrid", "dam_electricalgrid");
  add_bcs_location_mapping("trigger_multiple_bcs_dam_insidelounge", "dam_insidelounge");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dam_inpipes", "dam_inpipes");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dam_underground", "dam_underground");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dam_factoryrooftop", "dam_factoryrooftop");
}

mp_detroit() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_det_inschool", "det_inschool");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_det_bylockers", "det_bylockers");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_det_hospitalentrance", "det_hospitalentrance");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_det_hospitallobby", "det_hospitallobby");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_det_inparkinggarage", "det_inparkinggarage");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_det_garageentrance", "det_garageentrance");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_det_piperoom", "det_piperoom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_det_onramp", "det_onramp");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_det_inalley", "det_inalley");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_det_bytrailers", "det_bytrailers");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_det_ontrailers", "det_ontrailers");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_det_inthepod", "det_inthepod");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_det_throughpark", "det_throughpark");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_det_byplayground", "det_byplayground");
  add_bcs_location_mapping("triger_multiple_bcs_mp_det_garageoverlook", "det_garageoverlook");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_det_backalley", "det_backalley");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_det_parkoffice", "det_parkoffice");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_hospitaloffice", "det_hospitaloffice");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_det_throughstreet", "det_throughstreet");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_det_upperstreet", "det_upperstreet");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_det_lowerstreet", "det_lowerstreet");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_det_bycontainers", "det_bycontainers");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_det_bydiner", "det_bydiner");
}

mp_greenband() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_grn_2ndflooraquarium", "grn_2ndflooraquarium");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_grn_hotelbar", "grn_hotelbar");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_grn_incafe", "grn_incafe");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_grn_behindcherrytree", "grn_behindcherrytree");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_grn_aquariumhallway", "grn_aquariumhallway");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_grn_aquariumpatio", "grn_aquariumpatio");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_grn_inelevator", "grn_inelevator");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_grn_behindaquariumdesk", "grn_behindaquariumdesk");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_grn_inzengarden", "grn_inzengarden");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_grn_topofzengarden", "grn_topofzengarden");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_grn_hotelentrance", "grn_hotelentrance");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_grn_hotellobby", "grn_hotellobby");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_grn_inaquarium", "grn_aquarium");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_grn_inlounge", "grn_inlounge");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_grn_behindstatue", "grn_behindstatue");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_grn_insidewalkway", "grn_insidewalkway");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_grn_underawning", "grn_underawning");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_grn_topofawning", "grn_topofawning");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_grn_behindlargerock", "grn_behindlargerock");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_grn_nearsculpture", "grn_nearsculpture");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_grn_behindsmallplanter", "grn_behindsmallplanter");
}

mp_instinct() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ins_byriverbed", "ins_byriverbed");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ins_underexcavator", "ins_underexcavator");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ins_oncliffs", "ins_oncliffs");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ins_centertemple", "ins_centertemple");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ins_towerofruins", "ins_towerofruins");
  add_bcs_location_mapping("triger_multiple_bcs_mp_ins_nearpryramidhall", "ins_nearpryramidhall");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ins_insidepryramid", "ins_insidepryramid");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ins_behindtrailers", "ins_behindtrailers");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ins_powergenerators", "ins_powergenerators");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_ins_onrubble", "ins_onrubble");
}

mp_levity() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lev_secgates", "lev_secgates");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lev_controlroom", "lev_controlroom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lev_accessroofs", "lev_accessroofs");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lev_mainhangar", "lev_mainhangar");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lev_dronestorage", "lev_dronestorage");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lev_inflightcontrol", "lev_flightcontrol");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lev_flightcontrolroof", "lev_flightcontrolroof");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lev_flightcontrolalley", "lev_flightcontrolalley");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lev_observationdeck", "lev_observationdeck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lev_serveraccessroof", "lev_serveraccessroof");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lev_hangarlounge", "lev_hangarlounge");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lev_powercontrol", "lev_powercontrol");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lev_readyrooms", "lev_readyrooms");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lev_rearhangar", "lev_rearhangar");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lev_serveraccess", "lev_serveraccess");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lev_nearwaterfall", "lev_nearwaterfall");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_lev_nearrockslide", "lev_nearrockslide");
}

mp_recovery() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rec_inobservatory", "rec_inobservatory");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rec_bytram", "rec_bytram");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rec_byskywalk", "rec_byskywalk");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rec_inravine", "rec_inravine");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rec_insiderockhall", "rec_insiderockhall");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rec_byhangardoor", "rec_byhangardoor");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rec_inplaza", "rec_inplaza");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rec_bychopper", "rec_bychopper");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rec_onlaunchdeck", "rec_onlaunchdeck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rec_nearridge", "rec_nearridge");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rec_undercontroltower", "rec_undercontroltower");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rec_gatecontrolroom", "rec_gatecontrolroom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rec_underdeck", "rec_underdeck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rec_observationdeck", "rec_observationdeck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_rec_byrustedvan", "rec_byrustedvan");
}

mp_solar() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_slr_inparkinglot", "slr_inparkinglot");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_slr_bymainentry", "slr_bymainentry");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_slr_atpool", "slr_atpool");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_slr_indraintunnel", "slr_indraintunnel");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_slr_inoffice", "slr_inoffice");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_slr_bysmalltanks", "slr_bysmalltanks");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_slr_intowercontrolroom", "slr_intowercontrolroom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_slr_bytransformers", "slr_bytransformers");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_slr_condensercontrolroom", "slr_condensercontrolroom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_slr_inbacklot", "slr_inbacklot");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_slr_bycyclonetank", "slr_bycyclonetank");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_slr_indrainarea", "slr_indrainarea");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_slr_indriveway", "slr_indriveway");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_slr_visitorcenter", "slr_visitorcenter");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_slr_inpumproom", "slr_inpumproom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_slr_sciencearea", "slr_sciencearea");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_slr_ingarage", "slr_ingarage");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_slr_oncatwalks", "slr_oncatwalks");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_slr_bycondensers", "slr_bycondensers");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_slr_inutilityroom", "slr_inutilityroom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_slr_onutilityroof", "slr_onutilityroof");
}

mp_terrace() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trc_hotellobby", "trc_hotellobby");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trc_atgrotto", "trc_atgrotto");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trc_insaunatunnel", "trc_insaunatunnel");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trc_saunaentrance", "trc_saunaentrance");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trc_inlowerruins", "trc_inlowerruins");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trc_inupperruins", "trc_inupperruins");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trc_onupperterrace", "trc_onupperterrace");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trc_incafe", "trc_incafe");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trc_undertower", "trc_undertower");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trc_nightclubentrance", "trc_nightclubentrance");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trc_yellowroom", "trc_yellowroom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trc_redroom", "trc_redroom");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trc_lowerterrace", "trc_lowerterrace");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trc_atbonfire", "trc_atbonfire");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trc_poseidonspool", "trc_poseidonspool");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trc_saunaroof", "trc_saunaroof");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trc_inshowers", "trc_inshowers");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trc_topofminervamall", "trc_topofminervamall");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trc_sixbellspatio", "trc_sixbellspatio");
}

mp_torqued() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_nearbusstop", "trq_nearbusstop");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_incafe", "trq_incafe");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_chocolateshop", "trq_chocolateshop");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_baseofclocktower", "trq_baseofclocktower");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_inclocktower", "trq_inclocktower");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_nearfountain", "trq_nearfountain");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_outdoorcafe", "trq_outdoorcafe");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_parkinglot", "trq_parkinglot");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_gatedpatio", "trq_gatedpatio");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_nearrestaurant", "trq_nearrestaurant");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_insemi", "trq_insemi");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_nearsnackbar", "trq_nearsnackbar");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_insideticketcounter", "trq_insideticketcounter");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_frontoftrain", "trq_frontoftrain");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_backoftrain", "trq_backoftrain");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_utilitywalkway", "trq_utilitywalkway");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_onskywalk", "trq_onskywalk");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_topofawning", "trq_topofawning");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_behindbearstatue", "trq_behindbearstatue");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_behindcar", "trq_behindcar");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_incoffeeshop", "trq_incoffeeshop");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_inconstructionblgd", "trq_inconstructionblgd");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_inelevator", "trq_inelevator");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_onroof", "trq_onroof");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_behindsecuritytruck", "trq_behindsecuritytruck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_aboveticketcounter", "trq_aboveticketcounter");
}

mp_venus() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_inpool", "vns_inpool");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_bypool", "vns_bypool");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_inlounge", "vns_inlounge");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_inlobby", "vns_inlobby");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_onbalcony", "vns_onbalcony");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_byhelipad", "vns_byhelipad");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_onfountain", "vns_onfountain");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_byfountain", "vns_byfountain");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_onpoolshade", "vns_onpoolshade");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_inzengarden", "vns_inzengarden");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_inbar", "vns_inbar");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_bybar", "vns_bybar");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_onwoodendeck", "vns_onwoodendeck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_inobservationlounge", "vns_inobservationlounge");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_bywaterfall", "vns_bywaterfall");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_incentercourtyard", "vns_incentercourtyard");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_onpatio", "vns_onpatio");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_byfallentree", "vns_byfallentree");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_inbansaigarden", "vns_inbansaigarden");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_bypenthouse", "vns_bypenthouse");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_byhorsestatue", "vns_byhorsestatue");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_bysoliderstatue", "vns_bysoliderstatue");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_onhallwayrooftop", "vns_onhallwayrooftop");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_onbalconystaircase", "vns_onbalconystaircase");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_onoutsidebalconystaircase", "vns_onoutsidebalconystaircase");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_onobservationdeck", "vns_onobservationdeck");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_onobservationrooftop", "vns_onobservationrooftop");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_underwaterfall", "vns_underwaterfall");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_insaunalobby", "vns_insaunalobby");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_underkeyholearchway", "vns_underkeyholearchway");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_onoverhang", "vns_onoverhang");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_bylanterns", "vns_bylanterns");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_vns_onpenthouseroof", "vns_onpenthouseroof");
}

mp_comeback() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_cbk_rearentrancenetcafe", "cbk_rearentrancenetcafe");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_cbk_netcafe", "cbk_netcafe");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_cbk_videostore", "cbk_videostore");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_cbk_videostoreroof", "cbk_videostoreroof");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_cbk_byshanty", "cbk_byshanty");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_cbk_powerstationroof", "cbk_powerstationroof");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_cbk_centercoil", "cbk_centercoil");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_cbk_glassoffices", "cbk_glassoffices");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_cbk_grassybalcony", "cbk_grassybalcony");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_cbk_fabricsshop", "cbk_fabricsshop");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_cbk_fabricsshoproof", "cbk_fabricsshoproof");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_cbk_westcourtyard", "cbk_westcourtyard");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_cbk_nearskywalk", "cbk_nearskywalk");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_cbk_baseofapttower", "cbk_baseofapttower");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_cbk_northcourtyard", "cbk_northcourtyard");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_cbk_atopensewer", "cbk_atopensewer");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_cbk_eastcourtyard", "cbk_eastcourtyard");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_cbk_nearmarket", "cbk_nearmarket");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_cbk_oneonezero", "cbk_oneonezero");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_cbk_southcourtyard", "cbk_southcourtyard");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_cbk_southerncourtyard", "cbk_southerncourtyard");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_cbk_outsideofficebldg", "cbk_outsideofficebldg");
}

old_locations() {
  add_bcs_location_mapping("trigger_multiple_bcs_ns_acrosschasm", "acrosschasm");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_amcrt_stck", "amcrt_stck");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_barr_conc", "barr_conc");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_brls", "brls");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_catwlk", "catwlk");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_cell_l", "cell_l");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_cell_r", "cell_r");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_celldr_endhl", "celldr_endhl");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_corrgatedmtl", "corrgatedmtl");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_cot", "cot");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_crt_stck", "crt_stck");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_crtstk_nrldge", "crtstk_nrldge");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_cv_cent", "cv_cent");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_cv_cent_concsup", "cv_cent_concsup");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_cv_cent_tv", "cv_cent_tv");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_cv_small_l", "cv_small_l");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_cv_wall_inside", "cv_wall_inside");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_cv_wall_outside", "cv_wall_outside");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_dpstr", "dpstr");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_drvwy", "drvwy");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_dsk_lg", "dsk_lg");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_dsk_stck", "dsk_stck");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_fuelcont", "fuelcont");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_fuelconts", "fuelconts");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_gbgcns", "gbgcns");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_hdghog", "hdghog");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_hesco_nrledge", "hesco_nrledge");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_hescobarr", "hescobarr");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_icemach", "icemach");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_intsec_3w", "intsec_3w");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_lckr_cntr", "lckr_cntr");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_lckr_l", "lckr_l");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_lckr_ne", "lckr_ne");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_lckr_r", "lckr_r");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_lckr_sw", "lckr_sw");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_lowwall_bwire", "lowwall_bwire");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_newsbox", "newsbox");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_phnbth", "phnbth");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_pipes_behind", "pipes_behind");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_pipes_nside", "pipes_nside");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_rappel_left", "rappel_left");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_samlnchr", "samlnchr");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_sentrygun", "sentrygun");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_shwr_cntr", "shwr_cntr");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_shwr_ne", "shwr_ne");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_shwr_sw", "shwr_sw");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_sndbgs", "sndbgs");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_stairs_down", "stairs_down");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_stairs_up", "stairs_up");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_stairs_ylw", "stairs_ylw");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_tun_leadoutside", "tun_leadoutside");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_vendmach", "vendmach");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_wirespl_lg", "wirespl_lg");
  add_bcs_location_mapping("trigger_multiple_bcs_ns_wlkwy_abv_archs", "wlkwy_abv_archs");
  add_bcs_location_mapping("trigger_multiple_bcs_df_monument_courtyard", "monument_courtyard");
  add_bcs_location_mapping("trigger_multiple_bcs_df_monument_top", "monument_top");
  add_bcs_location_mapping("trigger_multiple_bcs_df_car_parked", "car_parked");
  add_bcs_location_mapping("trigger_multiple_bcs_df_embassy", "embassy");
  add_bcs_location_mapping("trigger_multiple_bcs_df_embassy_1st", "embassy_1st");
  add_bcs_location_mapping("trigger_multiple_bcs_df_embassy_3rd", "embassy_3rd");
  add_bcs_location_mapping("trigger_multiple_bcs_df_vehicle_snowcat", "vehicle_snowcat");
  add_bcs_location_mapping("trigger_multiple_bcs_df_vehicle_dumptruck", "vehicle_dumptruck");
  add_bcs_location_mapping("trigger_multiple_bcs_df_building_red", "building_red");
  add_bcs_location_mapping("trigger_multiple_bcs_df_vehicle_snowmobile", "vehicle_snowmobile");
  add_bcs_location_mapping("trigger_multiple_bcs_df_scaffolding_generic", "scaffolding_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_container_red", "container_red");
  add_bcs_location_mapping("trigger_multiple_bcs_df_tires_large", "tires_large");
  add_bcs_location_mapping("trigger_multiple_bcs_df_memorial_building", "memorial_building");
  add_bcs_location_mapping("trigger_multiple_bcs_df_stand_hotdog", "stand_hotdog");
  add_bcs_location_mapping("trigger_multiple_bcs_df_stand_trading", "stand_trading");
  add_bcs_location_mapping("trigger_multiple_bcs_df_subway_entrance", "subway_entrance");
  add_bcs_location_mapping("trigger_multiple_bcs_df_rubble_generic", "rubble_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_cases_right", "cases_right");
  add_bcs_location_mapping("trigger_multiple_bcs_df_cases_left", "cases_left");
  add_bcs_location_mapping("trigger_multiple_bcs_df_cases_generic", "cases_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_barrier_orange", "barrier_orange");
  add_bcs_location_mapping("trigger_multiple_bcs_df_barrier_hesco", "barrier_hesco");
  add_bcs_location_mapping("trigger_multiple_bcs_df_stryker_destroyed", "stryker_destroyed");
  add_bcs_location_mapping("trigger_multiple_bcs_df_fan_exhaust", "fan_exhaust");
  add_bcs_location_mapping("trigger_multiple_bcs_df_tower_jamming", "tower_jamming");
  add_bcs_location_mapping("trigger_multiple_bcs_df_ac_generic", "ac_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_table_computer", "table_computer");
  add_bcs_location_mapping("trigger_multiple_bcs_df_bulkhead_generic", "bulkhead_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_bunk_generic", "bunk_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_console_generic", "console_generic");
  add_bcs_location_mapping("trigger_multiple_bcs_df_deck_generic", "deck_generic");
}

old_locations_mp() {
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dome_bunker", "bunker");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dome_bunker_back", "bunker_back");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dome_office", "office");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dome_dome", "dome");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dome_catwalk", "catwalk");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dome_loadingbay", "loadingbay");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dome_hallway", "hallway");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dome_hallway_loadingbay", "hallway_loadingbay");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dome_hallway_office", "hallway_office");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dome_wall_broken", "wall_broken");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dome_tank", "tank");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dome_radar", "radar");
  add_bcs_location_mapping("trigger_multiple_bcs_mp_dome_humvee", "humvee");
}