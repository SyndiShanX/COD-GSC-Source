/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_bcs_location_trigs.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_utility;

bcs_location_trigs_init() {
  ASSERT(!isDefined(level.bcs_location_mappings));
  level.bcs_location_mappings = [];

  bcs_location_trigs_do_mappings();

  bcs_trigs_assign_aliases();

  level.bcs_location_mappings = undefined;
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
    ASSERT(isDefined(level.bcs_location_mappings[trig.classname]), "Couldn't find bcs location mapping for battlechatter trigger with classname " + trig.classname);

    aliases = ParseLocationAliases(level.bcs_location_mappings[trig.classname]);
    if(aliases.size > 1) {
      aliases = array_randomize(aliases);
    }

    trig.locationAliases = aliases;
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
bcs_location_trigs_do_mappings() {
  defaulttexture = "bcs" * /
  add_bcs_location_mapping("trigger_multiple_bcs_us_building_1stfloor_window", "blg_1f_wndw callout_loc_wndw_1st_report");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_1stfloor_window", "blg_1f_wndw callout_loc_wndw_1st_report");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_1stfloor_window", "blg_1f_wndw callout_loc_wndw_1st_report");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_1stfloor_door", "blg_1f_door callout_loc_door_1st_report");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_1stfloor_door", "blg_1f_door callout_loc_door_1st_report");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_1stfloor_door", "blg_1f_door callout_loc_door_1st_report");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_1stfloor_yellow", "blg_1f_ylw");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_1stfloor_yellow", "blg_1f_ylw");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_1stfloor_yellow", "blg_1f_ylw");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_2ndfloor_window_arched", "blg_1f_wndw_arch");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_2ndfloor_window_arched", "blg_1f_wndw_arch");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_2ndfloor_window_arched", "blg_1f_wndw_arch");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_2ndfloor_balcony", "blg_2f_blc");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_2ndfloor_balcony", "blg_2f_blc");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_2ndfloor_balcony", "blg_2f_blc");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_2ndfloor_balcony_brick", "blg_2f_blc_brk");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_2ndfloor_balcony_brick", "blg_2f_blc_brk");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_2ndfloor_balcony_brick", "blg_2f_blc_brk");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_2ndfloor_balcony_south", "blg_2f_s");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_2ndfloor_balcony_south", "blg_2f_s");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_2ndfloor_balcony_south", "blg_2f_s");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_2ndfloor_balcony_behindmetalsheets", "blg_2f_mtlshts");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_2ndfloor_balcony_behindmetalsheets", "blg_2f_mtlshts");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_2ndfloor_balcony_behindmetalsheets", "blg_2f_mtlshts");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_2ndfloor_balcony_behindsandbags", "blg_2f_sndbgs");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_2ndfloor_balcony_behindsandbags", "blg_2f_sndbgs");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_2ndfloor_balcony_behindsandbags", "blg_2f_sndbgs");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_2ndfloor_balcony_corrugatedmetal", "blg_2f_crgmtl");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_2ndfloor_balcony_corrugatedmetal", "blg_2f_crgmtl");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_2ndfloor_balcony_corrugatedmetal", "blg_2f_crgmtl");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_1story_grey", "blg_1s_gry");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_1story_grey", "blg_1s_gry");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_1story_grey", "blg_1s_gry");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_2story_roof", "blg_2s_rf");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_2story_roof", "blg_2s_rf");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_2story_roof", "blg_2s_rf");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_2story_roof_leftmost", "blg_2s_rf_left");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_2story_roof_leftmost", "blg_2s_rf_left");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_2story_roof_leftmost", "blg_2s_rf_left");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_2story_yellow_roof", "blg_2s_ylw_rf");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_2story_yellow_roof", "blg_2s_ylw_rf");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_2story_yellow_roof", "blg_2s_ylw_rf");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_2story_white_roof", "blg_2s_wht_rf");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_2story_white_roof", "blg_2s_wht_rf");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_2story_white_roof", "blg_2s_wht_rf");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_inside_frontdoor", "blg_ins_door_frnt");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_inside_frontdoor", "blg_ins_door_frnt");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_inside_frontdoor", "blg_ins_door_frnt");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_inside_backdoor", "blg_ins_door_bck");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_inside_backdoor", "blg_ins_door_bck");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_inside_backdoor", "blg_ins_door_bck");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_inside_stairs", "blg_ins_stairs");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_inside_stairs", "blg_ins_stairs");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_inside_stairs", "blg_ins_stairs");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_inside_bathroom", "blg_ins_bthrm");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_inside_bathroom", "blg_ins_bthrm");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_inside_bathroom", "blg_ins_bthrm");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_inside_livingroom", "blg_ins_lvgrm");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_inside_livingroom", "blg_ins_lvgrm");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_inside_livingroom", "blg_ins_lvgrm");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_inside_upstairs", "blg_ins_upstrs");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_inside_upstairs", "blg_ins_upstrs");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_inside_upstairs", "blg_ins_upstrs");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_inside_garage", "blg_ins_grge");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_inside_garage", "blg_ins_grge");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_inside_garage", "blg_ins_grge");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_inside_basement", "blg_ins_bsmt");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_inside_basement", "blg_ins_bsmt");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_inside_basement", "blg_ins_bsmt");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_inside_balcony", "blg_ins_balc");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_inside_balcony", "blg_ins_balc");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_inside_balcony", "blg_ins_balc");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_inside_cubicles", "blg_ins_cubes");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_inside_cubicles", "blg_ins_cubes");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_inside_cubicles", "blg_ins_cubes");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_inside_office_eastcorner", "blg_ins_offce_cnr_e");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_inside_office_eastcorner", "blg_ins_offce_cnr_e");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_inside_office_eastcorner", "blg_ins_offce_cnr_e");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_shed", "blg_shed");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_shed", "blg_shed");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_shed", "blg_shed");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_roof", "blg_shed");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_roof", "blg_roof");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_roof", "blg_roof");

  defaulttexture = "bcs" * /
  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_desk_large", "lm_dsk_lg");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_desk_large", "lm_dsk_lg");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_desk_large", "lm_dsk_lg");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_desks_stacked", "lm_dsk_stck");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_desks_stacked", "lm_dsk_stck");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_desks_stacked", "lm_dsk_stck");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_ammocrates_stacked", "lm_amcrt_stck");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_ammocrates_stacked", "lm_amcrt_stck");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_ammocrates_stacked", "lm_amcrt_stck");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_crates_stacked", "lm_crt_stck");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_crates_stacked", "lm_crt_stck");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_crates_stacked", "lm_crt_stck");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_fuelcontainer", "lm_fuelcont");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_fuelcontainer", "lm_fuelcont");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_fuelcontainer", "lm_fuelcont");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_fuelcontainers", "lm_fuelconts");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_fuelcontainers", "lm_fuelconts");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_fuelcontainers", "lm_fuelconts");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_garbagecans", "lm_gbgcns");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_garbagecans", "lm_gbgcns");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_garbagecans", "lm_gbgcns");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_barrels", "lm_brls");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_barrels", "lm_brls");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_barrels", "lm_brls");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_dumpster", "lm_dpstr");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_dumpster", "lm_dpstr");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_dumpster", "lm_dpstr");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_driveway", "lm_drvwy");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_driveway", "lm_drvwy");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_driveway", "lm_drvwy");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_intersection_threeway", "lm_intsec_3w");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_intersection_threeway", "lm_intsec_3w");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_intersection_threeway", "lm_intsec_3w");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_phonebooth", "lm_phnbth");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_phonebooth", "lm_phnbth");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_phonebooth", "lm_phnbth");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_vendingmachine", "lm_vendmach");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_vendingmachine", "lm_vendmach");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_vendingmachine", "lm_vendmach");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_icemachine", "lm_icemach");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_icemachine", "lm_icemach");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_icemachine", "lm_icemach");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_newspaperbox", "lm_newsbox");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_newspaperbox", "lm_newsbox");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_newspaperbox", "lm_newsbox");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_sandbags", "lm_sndbgs");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_sandbags", "lm_sndbgs");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_sandbags", "lm_sndbgs");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_barricade_concrete", "lm_barr_conc");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_barricade_concrete", "lm_barr_conc");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_barricade_concrete", "lm_barr_conc");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_hescobarrier", "lm_hescobarr");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_hescobarrier", "lm_hescobarr");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_hescobarrier", "lm_hescobarr");

  defaulttexture = "bcs" * /
  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_humvee_parked", "vh_hmv_pkd");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_humvee_parked", "vh_hmv_pkd");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_vehicle_humvee_parked", "vh_hmv_pkd");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_humvee_parked_left", "vh_hmv_pkd_l");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_humvee_parked_left", "vh_hmv_pkd_l");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_vehicle_humvee_parked_left", "vh_hmv_pkd_l");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_humvee_parked_right", "vh_hmv_pkd_r");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_humvee_parked_right", "vh_hmv_pkd_r");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_vehicle_humvee_parked_right", "vh_hmv_pkd_r");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_car_taxi", "vh_car_taxi");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_car_taxi", "vh_car_taxi");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_vehicle_car_taxi", "vh_car_taxi");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_car_black", "vh_car_blk");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_car_black", "vh_car_blk");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_vehicle_car_black", "vh_car_blk");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_car_grey", "vh_car_gry");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_car_grey", "vh_car_gry");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_vehicle_car_grey", "vh_car_gry");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_van_white", "vh_van_wht");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_van_white", "vh_van_wht");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_vehicle_van_white", "vh_van_wht");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_car_hatchback_blue", "vh_car_hb_blu");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_car_hatchback_blue", "vh_car_hb_blu");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_vehicle_car_hatchback_blue", "vh_car_hb_blu");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_car_hatchback_green", "vh_car_hb_grn");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_car_hatchback_green", "vh_car_hb_grn");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_vehicle_car_hatchback_green", "vh_car_hb_grn");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_car_hatchback_black", "vh_car_hb_blk");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_car_hatchback_black", "vh_car_hb_blk");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_vehicle_car_hatchback_black", "vh_car_hb_blk");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_car_stationwagon_yellow", "vh_car_sw_ylw");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_car_stationwagon_yellow", "vh_car_sw_ylw");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_vehicle_car_stationwagon_yellow", "vh_car_sw_ylw");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_car_police", "vh_car_pol");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_car_police", "vh_car_pol");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_vehicle_car_police", "vh_car_pol");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_car_police_destroyed", "vh_car_pol_dst");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_car_police_destroyed", "vh_car_pol_dst");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_vehicle_car_police_destroyed", "vh_car_pol_dst");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_truck_white", "vh_trk_wht");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_truck_white", "vh_trk_wht");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_vehicle_truck_white", "vh_trk_wht");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_truck_white_destroyed", "vh_trk_wht_dst");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_truck_white_destroyed", "vh_trk_wht_dst");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_vehicle_truck_white_destroyed", "vh_trk_wht_dst");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_truck_black", "vh_trk_blk");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_truck_black", "vh_trk_blk");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_vehicle_truck_black", "vh_trk_blk");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_truck_destroyed", "vh_trk_dst");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_truck_destroyed", "vh_trk_dst");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_vehicle_truck_destroyed", "vh_trk_dst");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_suv_black", "vh_suv_blk");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_suv_black", "vh_suv_blk");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_vehicle_suv_black", "vh_suv_blk");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_suv_black_overturned", "vh_suv_blk_ovrtnd");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_suv_black_overturned", "vh_suv_blk_ovrtnd");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_vehicle_suv_black_overturned", "vh_suv_blk_ovrtnd");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_tankertruck", "vh_trk_tnk");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_tankertruck", "vh_trk_tnk");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_vehicle_tankertruck", "vh_trk_tnk");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_uaz", "vh_uaz");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_uaz", "vh_uaz");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_vehicle_uaz", "vh_uaz");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_bus", "vh_bus");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_bus", "vh_bus");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_vehicle_bus", "vh_bus");

  defaulttexture = "bcs" * /
  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_2ndfloor_windows", "blg_2f_wndws");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_rappelling_leftside", "lm_rappel_left");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_stairs_down", "lm_stairs_down");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_stairs_up", "lm_stairs_up");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_stairs_yellow", "lm_stairs_ylw");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_catwalk_yellow_small", "lm_ctwlk_ylw_sml");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_catwalk_yellow_large", "lm_ctwlk_ylw_lg");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_catwalk_yellow_behindgirderstack", "lm_ctwlk_ylw_grdr");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_corrugatedmetal", "lm_corrgatedmtl");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_dumpster_red_long", "lm_dmpstr_red_lng");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_wirespool_large", "lm_wirespl_lg");

  defaulttexture = "bcs" * /
  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_lowwall_underbarbedwire", "lm_lowwall_bwire");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_celldoor_endofhall", "lm_celldr_endhl");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_cell_left", "lm_cell_l");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_cell_right", "lm_cell_r");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_pipes_behind", "lm_pipes_behind");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_showers_center", "lm_shwr_cntr");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_showers_SWside", "lm_shwr_sw");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_showers_NEside", "lm_shwr_ne");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_lockers_center", "lm_lckr_cntr");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_lockers_left", "lm_lckr_l");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_lockers_right", "lm_lckr_r");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_arches_above", "lm_wlkwy_abv_archs");

  defaulttexture = "bcs" * /
  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_shack_left", "blg_shack_left");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_icecreamstore_balcony", "blg_icecrm_balc");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_rooftops_ahead", "blg_rftop_ahead");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_market_alleyway_shotgunner", "lm_mrkt_alley_shgn");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_awning_green_marketcenter", "lm_awn_grn_mrktcntr");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_awning_redwhitestriped", "lm_awn_rdwhtstripe");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_vista_bigtree", "lm_vst_bigtree");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_lowwall_betweentwobldgs_right", "lm_wall_bt2bldgs_r");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_fence_white_atopridge", "lm_fence_wht_ridge");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_refrigerator", "lm_fridge");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_tirestack", "lm_tirestk");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_car_stationwagon_black", "vh_stwag_blk");

  defaulttexture = "bcs" * /
  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_haybale", "lm_haybale");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_logstack", "lm_logstack");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_tractor", "vh_tractor");

  defaulttexture = "bcs" * /
  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_wall_barbwire", "lm_wall_barbwire");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_stairs_behindstairs", "lm_stairs_behind");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_refuelingstation", "lm_fuelstation");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_hangar_num1", "blg_hngr_num1");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_hangar_num2", "blg_hngr_num2");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_cargocontainer", "lm_crgocont");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_cargocontainer_2stack", "lm_crgocont_2stack");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_cargocontainer_3stack", "lm_crgocont_3stack");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_cargocontainer_4stack", "lm_crgocont_4stack");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_cargocontainer_between", "lm_crgocont_between");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_helipad", "lm_helipad");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_railing", "lm_railing");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_wall_concrete_tall", "lm_wall_conc_tall");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_submarine_nextto", "lm_sub_nextto");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_forklift", "vh_forklift");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_vehicle_snowcat", "vh_snowcat");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_crane_beneath", "lm_crane_beneath");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_stairs_on", "lm_stairs_on");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_landmark_stairs_nextto", "lm_stairs_nextto");

  defaulttexture = "bcs" * /
  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_guardtower", "blg_grdtwr");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_cave_center", "lm_cv_cent");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_cave_center_tv", "lm_cv_cent_tv");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_cave_center_concretesupport", "lm_cv_cent_concsup");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_cave_outsidewall", "lm_cv_wall_outside");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_cave_insidewall", "lm_cv_wall_inside");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_tunnel_leadingoutside", "lm_tun_leadoutside");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_cave_small_left", "lm_cv_small_l");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_cratestack_nearledge", "lm_crtstk_nrldge");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_hescobarrier_nearledge", "lm_hesco_nrldge");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_pipes_northside", "lm_pipes_nside");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_catwalk", "lm_catwlk");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_across_chasm", "lm_acrosschasm");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_SAMlauncher", "lm_samlnchr");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_hedgehog", "lm_hdghog");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_cot", "lm_cot");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_landmark_sentrygun", "lm_sentrygun");

  defaulttexture = "bcs" * /
  add_bcs_location_mapping("trigger_multiple_bcs_us_building_diner_inside", "blg_diner_ins");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_diner_behindcounter", "blg_diner_bhcntr");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_burgertown_inside", "blg_bgrtwn_ins");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_burgertown_roof", "blg_bgrtwn_roof");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_burgertown_backdoor", "blg_bgrtwn_bkdr");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_burgertown_kitchen", "blg_bgrtwn_kchn");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_burgertown_diningarea", "blg_bgrtwn_tbls");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_burgertown_parkinglot", "blg_bgrtwn_prklt");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_crbfinancial_inside", "blg_crb_ins");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_crbfinancial_nextto", "blg_crb_nextto");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_conveniencestore_nextto", "blg_cnvstr_nextto");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_novastarstation_inside", "blg_nova_ins");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_gaspumps_between", "lm_pmps_btwn");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_helicopter_crashed", "vh_heli_crsh");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_natesrestaurant_nextto", "blg_nates_nextto");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_natesrestaurant_inside", "blg_nates_ins");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_natesrestaurant_roof", "blg_nates_roof");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_tacotogo_inside", "blg_tcotgo_ins");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_tacotogo_nextto", "blg_tcotgo_nextto");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_tacotogo_parkinglot", "blg_tcotgo_prklt");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_burgertown_sign", "lm_bgrtwn_roof");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_van_blue", "vh_van_blue");

  defaulttexture = "bcs" * /
  add_bcs_location_mapping("trigger_multiple_bcs_us_building_apartments_office", "blg_apt_office");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_apartments_3rdfloor", "blg_apt_3f");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_mansion_grey_frontsteps", "blg_mn_stps");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_archway_right", "blg_arch_right");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_archway_left", "blg_arch_left");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_mansion_whitestripe_east", "blg_mn_whtstrp_e");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_mansion_fountainfrontyard_east", "blg_mn_ftn_e");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_mansion_lightbrown_west", "blg_mn_ltbrwn_w");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_mansion_brickwhitetrim_west", "blg_mn_bkwtrm_w");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_median", "lm_med");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_parkinglot_eastside", "lm_parkinglot_e");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_sign_arcadia", "lm_sign_arc");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_archway_large", "lm_arch_lg");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_golfcourse_green", "lm_golfcourse_green");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_barricade_police", "lm_barr_police");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_guardhouse", "lm_guardhouse");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_planecrash_tailsection", "lm_plane_tailsec");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_planecrash_engine", "lm_plane_engine");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_firetruck", "vh_firetruck");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_house_red_porch", "blg_house_rd_prch");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_house_grey_patio", "blg_house_gry_ptio");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_inside_pooltable", "blg_ins_pooltbl");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_inside_minibar", "blg_ins_minibar");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_inside_winecellar", "blg_ins_winecllr");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_inside_diningroom", "blg_ins_dngrm");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_inside_kitchen", "blg_ins_ktchn");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_apartments_sign", "lm_apt_sign");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_fence_white", "lm_fence_wht");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_wall_stone", "lm_wall_stn");

  defaulttexture = "bcs" * /
  add_bcs_location_mapping("trigger_multiple_bcs_us_building_inside_balcony_south", "blg_ins_bal_s");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_inside_balcony_farside", "blg_ins_bal_far");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_copymachine", "lm_copymach");

  defaulttexture = "bcs" * /
  add_bcs_location_mapping("trigger_multiple_bcs_us_building_inside_windows_rightside", "blg_ins_wndws_rside");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_inside_office_glass_right", "blg_ins_off_gls_rside");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_inside_office_glass_left", "blg_ins_off_gls_lside");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_inside_cubicles_middle", "blg_ins_cubes_mid");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_inside_cubicles_right", "blg_ins_cubes_rside");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_inside_cubicles_left", "blg_ins_cubes_lside");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_shelves_middle", "lm_shlvs_mid");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_shelves_left", "lm_shlvs_lside");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_shelves_right", "lm_shlvs_rside");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_car_burning", "vh_car_brng");

  add_bcs_location_mapping("trigger_multiple_bcs_us_vehicle_tank", "vh_tank");

  defaulttexture = "bcs" * /
  add_bcs_location_mapping("trigger_multiple_bcs_us_building_airport_terminal_2ndfloor", "blg_airport_term_2f");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_supportbeams_orange", "lm_sprtbms_orange");

  add_bcs_location_mapping("trigger_multiple_bcs_us_landmark_luggagecart", "lm_lugcrt_long");

  defaulttexture = "bcs" * /
  add_bcs_location_mapping("trigger_multiple_bcs_us_building_door", "callout_loc_door_report");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_door", "callout_loc_door_report");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_door", "callout_loc_door_report");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_1stfloor", "callout_loc_1st_report");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_1stfloor", "callout_loc_1st_report");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_1stfloor", "callout_loc_1st_report");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_1stfloor_door_leftside", "callout_loc_door_1st_left_report");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_1stfloor_door_leftside", "callout_loc_door_1st_left_report");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_1stfloor_door_leftside", "callout_loc_door_1st_left_report");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_1stfloor_door_rightside", "callout_loc_door_1st_right_report");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_1stfloor_door_rightside", "callout_loc_door_1st_right_report");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_1stfloor_door_rightside", "callout_loc_door_1st_right_report");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_1stfloor_window_leftside", "callout_loc_wndw_1st_left_report");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_1stfloor_window_leftside", "callout_loc_wndw_1st_left_report");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_1stfloor_window_leftside", "callout_loc_wndw_1st_left_report");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_1stfloor_window_rightside", "callout_loc_wndw_1st_right_report");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_1stfloor_window_rightside", "callout_loc_wndw_1st_right_report");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_1stfloor_window_rightside", "callout_loc_wndw_1st_right_report");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_2ndfloor", "callout_loc_2nd_report");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_2ndfloor", "callout_loc_2nd_report");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_2ndfloor", "callout_loc_2nd_report");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_2ndfloor_door", "callout_loc_door_2nd_report");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_2ndfloor_door", "callout_loc_door_2nd_report");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_2ndfloor_door", "callout_loc_door_2nd_report");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_2ndfloor_window", "callout_loc_wndw_2nd_report");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_2ndfloor_window", "callout_loc_wndw_2nd_report");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_2ndfloor_window", "callout_loc_wndw_2nd_report");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_2ndfloor_window_leftside", "callout_loc_wndw_2nd_left_report");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_2ndfloor_window_leftside", "callout_loc_wndw_2nd_left_report");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_2ndfloor_window_leftside", "callout_loc_wndw_2nd_left_report");

  add_bcs_location_mapping("trigger_multiple_bcs_us_building_2ndfloor_window_rightside", "callout_loc_wndw_2nd_right_report");

  add_bcs_location_mapping("trigger_multiple_bcs_taskforce_building_2ndfloor_window_rightside", "callout_loc_wndw_2nd_right_report");

  add_bcs_location_mapping("trigger_multiple_bcs_tfstealth_building_2ndfloor_window_rightside", "callout_loc_wndw_2nd_right_report");
}