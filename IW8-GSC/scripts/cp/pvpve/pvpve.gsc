/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\pvpve\pvpve.gsc
***********************************************/

function init_pvpve() {
  level.dogtag_revive = 1;
  setup_play_test_name_to_team_id_mapping();
}

function getassignedspawnpointbasedonteam(var_0) {
  var_1 = get_spawn_point_targetname(var_0);
  var_2 = scripts\engine\utility::getStructArray(var_1, "targetname");
  var_3 = var_2[var_0.slot_number];
  return var_3;
}

function get_spawn_point_targetname(var_0) {
  switch (var_0.team_number) {
    case 0:
      return "pvpve_team_A";
    case 1:
      return "pvpve_team_B";
    case 2:
      return "pvpve_team_C";
    case 3:
      return "pvpve_team_D";
    default:
      break;
  }
}

function initialize_player_team_slot_assignment() {
  level.team_id_slot_index_list = [];
  level.team_id_num_slot_filled = [];

  for(var_0 = 0; var_0 < 4; var_0++) {
    level.team_id_slot_index_list[level.team_id_slot_index_list.size] = make_randomized_slot_index_list();
  }

  for(var_1 = 0; var_1 < 4; var_1++) {
    level.team_id_num_slot_filled[var_1] = 0;
  }
}

function get_available_slot_index_for_team_id(var_0) {}

function make_randomized_slot_index_list() {
  var_0 = [];

  for(var_1 = 0; var_1 < 4; var_1++) {
    var_0 = var_1;
  }

  for(var_2 = 0; var_2 < 5; var_2++) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}

function pvpve_enabled() {
  return getdvarint("enable_pvpve", 0) != 0;
}

function setup_play_test_name_to_team_id_mapping() {
  game["name_to_team_id_mapping"] = [];
  game["name_to_team_id_mapping"][tolower("James_C")] = 0;
  game["name_to_team_id_mapping"][tolower("IW_James_Chen_2")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP6_Golf1")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6_Juliet1")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6_Kilo1")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6_Mike1")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6_Hotel1")] = 1;
  game["name_to_team_id_mapping"][tolower("IWCP6_1")] = 1;
  game["name_to_team_id_mapping"][tolower("IWCP6_2")] = 1;
  game["name_to_team_id_mapping"][tolower("IWCP6_3")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP6_India1")] = 2;
  game["name_to_team_id_mapping"][tolower("IWMP6_Echo1")] = 2;
  game["name_to_team_id_mapping"][tolower("IWMP6_Charlie1")] = 2;
  game["name_to_team_id_mapping"][tolower("IWMP6_Romeo1")] = 2;
  game["name_to_team_id_mapping"][tolower("IWMP6_Oscar1")] = 3;
  game["name_to_team_id_mapping"][tolower("IWMP6_Papa1")] = 3;
  game["name_to_team_id_mapping"][tolower("IWCP6_4")] = 3;
  game["name_to_team_id_mapping"][tolower("IWMP6_FoxTrot1")] = 3;
}