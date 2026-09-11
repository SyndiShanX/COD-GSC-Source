/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58294.gsc
***********************************************/

function switcharray() {
  level.ref_13d57 = 0;
  var_0 = level.trial["missionID"];
  precachemodel("tag_origin");
  precachemodel("highway_flag0");
  precachemodel("military_carepackage_01_uk");
  precachemodel("me_window_frame_wood_single_01_white_opaque");
  precachemodel("veh8_civ_lnd_malfa_wheel_front_lm");
  precachemodel("veh8_civ_lnd_malfa_wheel_back_lm");
  precachemodel("veh8_civ_lnd_malfa_right_door_blue");
  precachemodel("veh8_civ_lnd_malfa_left_door_blue");
  precachemodel("veh8_civ_lnd_malfa_door_front_right_lm_blue");
  precachemodel("veh8_civ_lnd_malfa_door_front_left_lm_blue");
  precachemodel("veh8_civ_lnd_malfa_lm_alt_blue");
  precachemodel("bog_b_cinderblock_clutter");
  precachemodel("ee_manmade_wood_planks_shaft_collapse_01");
  precachemodel("storage_shelf_beam_wood_plank");
  precachemodel("uk_gas_tank_thin_cylinder_2_destr");
  precachemodel("uk_gas_tank_thin_cylinder_2_cracked");
  var_1 = getEnt("trigger_on_ground", "script_noteworthy");
  var_1.origin = (var_1.origin[0], var_1.origin[1], var_1.origin[2] + 8);
  var_2 = [];
  GscBinSkip0(0x2e, 0, (1480, 3033, 152));
}

function ref_135a4(var_0) {
  var_1 = (0, 0, 0);
  var_2 = (0, 0, 0);
  var_3 = spawn("script_origin", var_1);
  var_3.angles = var_2;
  var_3.targetname = "trial_weapon";
  var_3.script_noteworthy = "trial_starting_weapon";

  switch (level.trial["variant"]) {
    case "knife":
      var_3.script_parameters = "iw8_knife";
      break;
    case "shield":
      var_3.script_parameters = "iw8_me_riotshield";
      break;
    case "pistol":
      var_3.script_parameters = "iw8_pi_decho";
      break;
    case "free":
      var_3.script_parameters = "iw8_knife";
      break;
    default:
      var_4 = "iw8_pi_golf21";
      break;
  }

  var_5 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (1592, 2922, 196), (0, 187, 0));
  scripts\mp\spawnlogic::bdiedonce([var_5]);
  level.ref_126a5 = spawnStruct();
  level.ref_126a5.origin = (1592, 2922, 196);
  level.ref_126a5.angles = (0, 187, 0);
  var_6 = getEnt("care_package_col", "targetname");
  var_7 = getEnt("clip64x64x8", "targetname");
  var_8 = getEnt("clip64x64x64", "targetname");
  var_9 = getEnt("mantle64", "targetname");
  var_10 = getEnt("mantle128", "targetname");
  var_11 = [];
  GscBinSkip0(0x2e, 0, spawn("script_origin", (0, 0, 0)));
}