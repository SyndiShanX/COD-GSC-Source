/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_core_gamescore.gsc
***********************************************/

init_zombie_scoring() {
  init_eog_score_components(["_encstr_937B0DDAEDCD95E5F5CA5893DC2B23"]);
  init_encounter_score_components(["_encstr_937B0DDAEDCD95E5F5CA5893DC2B23"]);
  set_level_score_data();
  set_level_score_callback_func();
}

set_level_score_data() {
  level.cycle_score_scalar = 1;
}

set_level_score_callback_func() {
  level.endgameencounterscorefunc = ::zombies_endgameencounterscorefunc;
}

init_eog_score_components(var_0) {
  foreach(var_2 in var_0) {
    switch (var_2) {
      case "_encstr_B2BE0788BAF573592F":
        scripts\cp\cp_gamescore::register_eog_score_component("_encstr_B2BE0788BAF573592F", 29);
        break;
      case "_encstr_937B0DDAEDCD95E5F5CA5893DC2B23":
        scripts\cp\cp_gamescore::register_eog_score_component("_encstr_937B0DDAEDCD95E5F5CA5893DC2B23", 30);
        break;
      case "_encstr_87330F9BF06E4FBF4817A765CB8085BF05":
        scripts\cp\cp_gamescore::register_eog_score_component("_encstr_87330F9BF06E4FBF4817A765CB8085BF05", 31);
        break;
      case "_encstr_872613A7F71013557039961D5168B78A7F250B3759":
        scripts\cp\cp_gamescore::register_eog_score_component("_encstr_872613A7F71013557039961D5168B78A7F250B3759", 32);
        break;
      default:
    }
  }
}

init_encounter_score_components(var_0) {
  level.encounter_score_components = [];

  foreach(var_2 in var_0) {
    switch (var_2) {
      case "_encstr_B2BE0788BAF573592F":
        init_damage_score_component();
        break;
      case "_encstr_937B0DDAEDCD95E5F5CA5893DC2B23":
        init_money_earned_score_component();
        break;
      case "_encstr_87330F9BF06E4FBF4817A765CB8085BF05":
        init_tickets_earned_score_component();
        break;
      case "_encstr_872613A7F71013557039961D5168B78A7F250B3759":
        init_consumables_earned_score_component();
        break;
      default:
    }
  }
}

init_damage_score_component() {
  scripts\cp\cp_gamescore::register_encounter_score_component("_encstr_B2BE0788BAF573592F", ::init_damage_score, ::reset_team_damage_performance, ::reset_player_damage_performance, ::calculate_damage_score, 29, "_encstr_B2BE0788BAF573592F");
}

init_money_earned_score_component() {
  scripts\cp\cp_gamescore::register_encounter_score_component("_encstr_937B0DDAEDCD95E5F5CA5893DC2B23", ::init_money_earned_score, ::reset_team_money_earned_performance, ::reset_player_money_earned_performance, ::calculate_money_earned_score, 30, "_encstr_937B0DDAEDCD95E5F5CA5893DC2B23");
}

init_tickets_earned_score_component() {
  scripts\cp\cp_gamescore::register_encounter_score_component("_encstr_87330F9BF06E4FBF4817A765CB8085BF05", ::init_tickets_earned_score, ::reset_team_tickets_earned_performance, ::reset_player_tickets_earned_performance, ::calculate_tickets_earned_score, 31, "_encstr_87330F9BF06E4FBF4817A765CB8085BF05");
}

init_consumables_earned_score_component() {
  scripts\cp\cp_gamescore::register_encounter_score_component("_encstr_872613A7F71013557039961D5168B78A7F250B3759", ::init_consumables_earned_score, ::reset_team_consumables_earned_performance, ::reset_player_consumables_earned_performance, ::calculate_consumables_earned_score, 32, "_encstr_872613A7F71013557039961D5168B78A7F250B3759");
}

init_consumables_earned_score(var_0) {
  return var_0;
}

reset_team_consumables_earned_performance(var_0) {
  return var_0;
}

reset_player_consumables_earned_performance(var_0) {
  var_0.encounter_performance["_encstr_995E19A37B4716D87DC6DB73CDD5AD2C89B1CAE6D7592C3937B246"] = 0;
}

calculate_consumables_earned_score(var_0, var_1) {
  var_2 = scripts\cp\cp_gamescore::get_player_encounter_performance(var_0, "_encstr_995E19A37B4716D87DC6DB73CDD5AD2C89B1CAE6D7592C3937B246");
  var_3 = min(50000, var_2 * 10000);
  return int(var_3);
}

init_tickets_earned_score(var_0) {
  return var_0;
}

reset_team_tickets_earned_performance(var_0) {
  return var_0;
}

reset_player_tickets_earned_performance(var_0) {
  var_0.encounter_performance["_encstr_BED415FD1D830330E763E0B837F50B9F9907FF06B54AC1"] = 0;
}

calculate_tickets_earned_score(var_0, var_1) {
  var_2 = scripts\cp\cp_gamescore::get_player_encounter_performance(var_0, "_encstr_BED415FD1D830330E763E0B837F50B9F9907FF06B54AC1");
  var_3 = min(999999, var_2 * 1);
  return int(var_3);
}

init_money_earned_score(var_0) {
  return var_0;
}

reset_team_money_earned_performance(var_0) {
  return var_0;
}

reset_player_money_earned_performance(var_0) {
  var_0.encounter_performance["_encstr_BD7C1395904D4B19897D4F10A718AE0D6B72E04D21"] = 0;
}

calculate_money_earned_score(var_0, var_1) {
  var_2 = scripts\cp\cp_gamescore::get_player_encounter_performance(var_0, "_encstr_BD7C1395904D4B19897D4F10A718AE0D6B72E04D21");
  var_3 = min(999999, var_2 * 1);
  return int(var_3);
}

init_damage_score(var_0) {
  return var_0;
}

reset_team_damage_performance(var_0) {
  return var_0;
}

reset_player_damage_performance(var_0) {
  var_0.encounter_performance["_encstr_81D2158C2C6BB076567D23DB73B2EBBD377D0B3B599BA3"] = 0;
}

calculate_damage_score(var_0, var_1) {
  var_2 = scripts\cp\cp_gamescore::get_player_encounter_performance(var_0, "_encstr_81D2158C2C6BB076567D23DB73B2EBBD377D0B3B599BA3");
  var_3 = min(999999, var_2 * 0.2);
  return int(var_3);
}

update_agent_damage_performance(var_0, var_1, var_2) {
  if(var_2 == "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3") {
    return;
  }
  var_3 = scripts\cp\utility::get_attacker_as_player(var_0);

  if(!isDefined(var_3)) {
    return;
  }
  var_3 scripts\cp\cp_gamescore::update_personal_encounter_performance("_encstr_B2BE0788BAF573592F", "_encstr_81D2158C2C6BB076567D23DB73B2EBBD377D0B3B599BA3", var_1);
}

update_money_earned_performance(var_0, var_1) {
  var_0 scripts\cp\cp_gamescore::update_personal_encounter_performance("_encstr_937B0DDAEDCD95E5F5CA5893DC2B23", "_encstr_BD7C1395904D4B19897D4F10A718AE0D6B72E04D21", var_1);
}

update_tickets_earned_performance(var_0, var_1) {
  var_0 scripts\cp\cp_gamescore::update_personal_encounter_performance("_encstr_87330F9BF06E4FBF4817A765CB8085BF05", "_encstr_BED415FD1D830330E763E0B837F50B9F9907FF06B54AC1", var_1);
}

zombies_endgameencounterscorefunc(var_0) {
  scripts\cp\cp_gamescore::calculate_encounter_scores(level.players, ["_encstr_937B0DDAEDCD95E5F5CA5893DC2B23"], var_0);
}