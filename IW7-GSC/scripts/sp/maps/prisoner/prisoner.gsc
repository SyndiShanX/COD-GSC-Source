/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\prisoner\prisoner.gsc
*************************************************/

main() {
  scripts\sp\utility::_id_116CB("prisoner");
  scripts\sp\utility::_id_F305();

  if(getdvarint("greenlight") == 0) {
    scripts\sp\utility::_id_F343("collapse_dropship");
  } else {
    scripts\sp\utility::_id_F343("alleys");
  }

  level._id_12499 = ["prisoner_pre_church_tr", "prisoner_periph_ground_tr", "pnr_ground_fcollapse_pristine_tr", "pnr_ground_start_alleys_a_tr", "pnr_old_town_first_street_b_tr", "pnr_old_town_first_street_a_tr", "pnr_ground_courtyard_leftside_01_tr", "pnr_ground_courtyard_rightside_01_tr", "pnr_ground_courtyard_top_01_tr"];
  level._id_1249A = ["prisoner_pre_church_tr", "prisoner_periph_ground_tr", "pnr_ground_start_alleys_a_tr", "pnr_old_town_first_street_b_tr", "pnr_old_town_first_street_a_tr", "pnr_ground_courtyard_leftside_01_tr", "pnr_ground_courtyard_rightside_01_tr", "pnr_ground_courtyard_middle_01_tr", "pnr_ground_courtyard_top_01_tr"];
  level._id_1249B = ["prisoner_pre_church_tr", "prisoner_periph_ground_tr", "pnr_old_town_first_street_b_tr", "pnr_old_town_first_street_a_tr", "pnr_ground_courtyard_leftside_01_tr", "pnr_ground_courtyard_rightside_01_tr", "pnr_ground_courtyard_middle_01_tr", "pnr_cathedral_upper_sec_b_exterior_tr", "pnr_ground_courtyard_top_01_tr", "pnr_ground_courtyard_top_03_tr"];
  level._id_1249C = ["prisoner_pre_church_tr", "prisoner_periph_ground_tr", "pnr_old_town_first_street_b_tr", "pnr_old_town_first_street_a_tr", "pnr_ground_courtyard_leftside_01_tr", "pnr_ground_courtyard_rightside_01_tr", "pnr_ground_courtyard_middle_01_tr", "pnr_cathedral_upper_sec_b_exterior_tr", "pnr_ground_courtyard_top_01_tr", "pnr_ground_courtyard_top_03_tr", "prisoner_church_interior_start_tr"];
  level._id_1249D = ["prisoner_church_interior_tr", "prisoner_church_interior_start_tr", "pnr_cathedral_upper_sec_b_exterior_tr", "pnr_ground_courtyard_top_01_tr", "pnr_ground_courtyard_top_03_tr"];
  level._id_1249E = ["prisoner_church_interior_tr", "prisoner_church_interior_start_tr", "pnr_cathedral_upper_sec_b_exterior_tr", "pnr_ground_courtyard_top_01_tr", "pnr_ground_courtyard_top_03_tr"];
  level._id_125D6 = ["prisoner_pre_church_tr", "pnr_ground_courtyard_rightside_01_tr", "pnr_ground_courtyard_middle_01_tr", "pnr_ground_courtyard_leftside_01_tr", "pnr_old_town_first_street_b_tr", "pnr_old_town_first_street_a_tr", "prisoner_periph_ground_tr"];
  scripts\sp\utility::_id_1749("collapse_dropship", scripts\sp\maps\prisoner\prisoner_streets::_id_10BF2, "Collapse In Dropship", scripts\sp\maps\prisoner\prisoner_streets::_id_B1AC, level._id_12499, scripts\sp\maps\prisoner\prisoner_streets::_id_10BF3);
  scripts\sp\utility::_id_1749("collapse_smoke", scripts\sp\maps\prisoner\prisoner_streets::_id_10BF5, "Collapse Smoke", scripts\sp\maps\prisoner\prisoner_streets::_id_B1AE, level._id_12499, undefined);
  scripts\sp\utility::_id_1749("collapse_truck", scripts\sp\maps\prisoner\prisoner_streets::_id_10BF6, "Collapse Truck", scripts\sp\maps\prisoner\prisoner_streets::_id_B1AF, level._id_12499, undefined);
  scripts\sp\utility::_id_1749("collapse_post_truck", scripts\sp\maps\prisoner\prisoner_streets::_id_10BF4, "Collapse Post-Truck", scripts\sp\maps\prisoner\prisoner_streets::_id_B1AD, level._id_12499, undefined);
  scripts\sp\utility::_id_1749("alleys", scripts\sp\maps\prisoner\prisoner_streets::_id_10B9A, "Alleys", scripts\sp\maps\prisoner\prisoner_streets::_id_B183, level._id_1249A, undefined);
  scripts\sp\utility::_id_1749("street", scripts\sp\maps\prisoner\prisoner_streets::_id_10D34, "Street", scripts\sp\maps\prisoner\prisoner_streets::_id_B239, level._id_1249A, undefined);
  scripts\sp\utility::_id_1749("bikeshop", scripts\sp\maps\prisoner\prisoner_streets::_id_10BBC, "Bike Shop", scripts\sp\maps\prisoner\prisoner_streets::_id_B192, level._id_1249A, undefined);
  scripts\sp\utility::_id_1749("courtyard", scripts\sp\maps\prisoner\prisoner_courtyard::_id_10C05, "Courtyard", scripts\sp\maps\prisoner\prisoner_courtyard::_id_B1BD, level._id_1249B, undefined);
  scripts\sp\utility::_id_1749("terrace", scripts\sp\maps\prisoner\prisoner_courtyard::_id_10D41, "terrace", scripts\sp\maps\prisoner\prisoner_courtyard::_id_B23D, level._id_1249B, undefined);
  scripts\sp\utility::_id_1749("church_road", scripts\sp\maps\prisoner\prisoner_courtyard::_id_10BEB, "Church Road", scripts\sp\maps\prisoner\prisoner_courtyard::_id_B1AA, level._id_1249C, undefined);
  scripts\sp\utility::_id_1749("church_road_end", scripts\sp\maps\prisoner\prisoner_courtyard::_id_10BEC, "Church Road End", scripts\sp\maps\prisoner\prisoner_courtyard::_id_B1AB, level._id_1249C, undefined);
  scripts\sp\utility::_id_1749("church_outside", scripts\sp\maps\prisoner\prisoner_church::_id_10BE8, "Church Outside", scripts\sp\maps\prisoner\prisoner_church::_id_B1A7, level._id_1249C, undefined);
  scripts\sp\utility::_id_1749("church", scripts\sp\maps\prisoner\prisoner_church::_id_10BE3, "Church", scripts\sp\maps\prisoner\prisoner_church::_id_B1A2, level._id_1249D, undefined);
  scripts\sp\utility::_id_1749("church_rafters", scripts\sp\maps\prisoner\prisoner_church::_id_10BEA, "Church Rafters", scripts\sp\maps\prisoner\prisoner_church::_id_B1A9, level._id_1249E, undefined);
  scripts\sp\utility::_id_1749("church_finale1", scripts\sp\maps\prisoner\prisoner_church::_id_10BE5, "Church Finale 1", scripts\sp\maps\prisoner\prisoner_church::_id_B1A4, level._id_1249E, undefined);
  setsaveddvar("r_tessellationOverride", 0);
  setdvarifuninitialized("disable_floodlight_scripts", 0);
  setdvarifuninitialized("dropship_lighting", 0);
  _id_D83F();
  scripts\sp\load::main();
  _id_D704();
  level thread _id_0A2F::_id_3D61();
}

_id_D83F() {
  scripts\engine\utility::flag_init("flag_scriptables_ready");
  scripts\engine\scriptable::_id_EF33(::_id_EF2E);
  scripts\sp\utility::_id_1263F("prisoner_transient_ignore_tr");
  scripts\sp\utility::_id_1263F("prisoner_periph_ground_tr");
  scripts\sp\utility::_id_1263F("prisoner_church_interior_tr");
  scripts\sp\utility::_id_1263F("prisoner_church_interior_start_tr");
  scripts\sp\utility::_id_1263F("prisoner_pre_church_tr");
  scripts\sp\utility::_id_1263F("pnr_ground_courtyard_top_01_tr");
  scripts\sp\utility::_id_1263F("pnr_ground_courtyard_rightside_01_tr");
  scripts\sp\utility::_id_1263F("pnr_ground_courtyard_middle_01_tr");
  scripts\sp\utility::_id_1263F("pnr_ground_courtyard_leftside_01_tr");
  scripts\sp\utility::_id_1263F("pnr_cathedral_upper_sec_b_exterior_tr");
  scripts\sp\utility::_id_1263F("pnr_ground_courtyard_top_03_tr");
  scripts\sp\utility::_id_1263F("pnr_ground_fcollapse_pristine_tr");
  scripts\sp\utility::_id_1263F("pnr_ground_start_alleys_a_tr");
  scripts\sp\utility::_id_1263F("pnr_old_town_first_street_b_tr");
  scripts\sp\utility::_id_1263F("pnr_old_town_first_street_a_tr");
  scripts\sp\maps\prisoner\prisoner_precache::main();
  scripts\sp\maps\prisoner\gen\prisoner_art::main();
  scripts\sp\maps\prisoner\prisoner_fx::main();
  scripts\sp\maps\prisoner\prisoner_anim::main();
  scripts\sp\maps\prisoner\prisoner_streets::_id_D83F();
  scripts\sp\maps\prisoner\prisoner_courtyard::_id_D83F();
  scripts\sp\maps\prisoner\prisoner_church::_id_D83F();
  scripts\sp\maps\prisoner\prisoner_hvt_scene::_id_924A();
  precacheturret("dropship_turret");
  precachemodel("veh_civ_lnd_utility_van_drive");
  precachemodel("veh_civ_lnd_cube_truck_food");
  precachemodel("equipment_industrial_weapon_mount_01");
  precacherumble("subtle_tank_rumble");
  scripts\sp\utility::_id_16CC("small_long", 0.15, 10, 2048);
  scripts\sp\utility::_id_16CC("small_med", 0.1, 5, 2048);
  scripts\sp\utility::_id_16CC("small_short", 0.15, 1, 2048);
  scripts\sp\utility::_id_16CC("medium_medium", 0.25, 3, 2048);
  scripts\sp\utility::_id_16CC("large_short", 0.45, 1, 2048);
  scripts\sp\utility::_id_16CC("large_medium_constant", 0.45, 2, 2048);
  scripts\engine\utility::flag_init("flag_convoy_spawned");
}

_id_D704() {
  level._id_125F = [];
  level._id_1447 = [];
  createthreatbiasgroup("player");
  level.player setthreatbiasgroup("player");
  scripts\engine\utility::array_call(getEntArray("collapse_remove", "script_noteworthy"), ::delete);
  scripts\sp\vehicle_build::_id_31A4("van", "headlight_L", "tag_light_front_left", "vfx/iw7/core/vehicle/cars/veh_civ_lnd_utility_van_light_lft_frt.vfx", "running", 0.0);
  scripts\sp\vehicle_build::_id_31A4("van", "headlight_R", "tag_light_front_right", "vfx/iw7/core/vehicle/cars/veh_civ_lnd_utility_van_light_rgt_frt.vfx", "running", 0.0);
  scripts\sp\vehicle_build::_id_31A4("van", "taillight_L", "tag_light_back_left", "vfx/iw7/core/vehicle/cars/veh_civ_lnd_utility_van_light_lft_bck_no_blink.vfx", "running", 0.0);
  scripts\sp\vehicle_build::_id_31A4("van", "taillight_R", "tag_light_back_right", "vfx/iw7/core/vehicle/cars/veh_civ_lnd_utility_van_light_rgt_bck_no_blink.vfx", "running", 0.0);
  scripts\sp\vehicle_build::_id_31A4("van", "taillight_M", "tag_light_back_mid", "vfx/iw7/core/vehicle/cars/veh_civ_lnd_utility_van_light_bck_mid_no_blink.vfx", "running", 0.0);
  scripts\sp\maps\prisoner\prisoner_streets::_id_D704();
  scripts\sp\maps\prisoner\prisoner_courtyard::_id_D704();
  scripts\sp\maps\prisoner\prisoner_church::_id_D704();
  scripts\engine\utility::array_call(getEntArray("model_bridge", "targetname"), ::delete);

  if(scripts\sp\utility::_id_D0CA("iw7_kbs")) {
    level.player takeweapon("iw7_kbs");
    level.player giveweapon("iw7_kbs+kbsscope");
  }

  thread _id_ABE0();
}

_id_EF2E() {
  scripts\engine\utility::waitframe();
  scripts\engine\utility::flag_set("flag_scriptables_ready");
}

_id_12647() {
  switch (level._id_10CDA) {
    case "church_finale1":
    case "church_rafters":
    case "church":
    case "church_outside":
    case "church_road_end":
    case "church_road":
    case "terrace":
    case "courtyard":
    case "bikeshop":
    case "street":
    case "collapse_post_truck":
    case "collapse_truck":
    case "collapse_smoke":
    case "alleys":
    case "collapse_dropship":
    default:
  }
}

_id_1723(var_0, var_1, var_2, var_3) {
  if(!scripts\sp\utility::_id_C268(var_0)) {
    objective_add(scripts\sp\utility::_id_C264(var_0), var_1, var_2);
  }
}

_id_ABE0() {
  _id_1723("OBJECTIVE_TRUCK", "current", &"PRISONER_OBJECTIVE_TRUCK");
  scripts\engine\utility::flag_wait("august_door_open");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_TRUCK"));
  _id_1723("OBJECTIVE_RIAH", "current", &"PRISONER_OBJECTIVE_RIAH");
}