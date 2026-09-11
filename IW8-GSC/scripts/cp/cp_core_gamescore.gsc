/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_core_gamescore.gsc
***********************************************/

function init_zombie_scoring() {
  init_eog_score_components(["money_earned"]);
  init_encounter_score_components(["money_earned"]);
  set_level_score_data();
  set_level_score_callback_func();
}

function set_level_score_data() {
  level.cycle_score_scalar = 1;
}

function set_level_score_callback_func() {
  level.endgameencounterscorefunc = &zombies_endgameencounterscorefunc;
}

function init_eog_score_components(var_0) {
  foreach(var_2 in var_0) {
    switch (var_2) {
      case "damage":
        scripts\cp\cp_gamescore::register_eog_score_component("damage", 29);
        break;
      case "money_earned":
        scripts\cp\cp_gamescore::register_eog_score_component("money_earned", 30);
        break;
      case "tickets_earned":
        scripts\cp\cp_gamescore::register_eog_score_component("tickets_earned", 31);
        break;
      case "consumables_earned":
        scripts\cp\cp_gamescore::register_eog_score_component("consumables_earned", 32);
        break;
      default:
        break;
    }
  }
}

function init_encounter_score_components(var_0) {
  level.encounter_score_components = [];

  foreach(var_2 in var_0) {
    switch (var_2) {
      case "damage":
        init_damage_score_component();
        break;
      case "money_earned":
        init_money_earned_score_component();
        break;
      case "tickets_earned":
        init_tickets_earned_score_component();
        break;
      case "consumables_earned":
        init_consumables_earned_score_component();
        break;
      default:
        break;
    }
  }
}

function init_damage_score_component() {
  scripts\cp\cp_gamescore::register_encounter_score_component("damage", &init_damage_score, &reset_team_damage_performance, &reset_player_damage_performance, &calculate_damage_score, 29, "damage");
}

function init_money_earned_score_component() {
  scripts\cp\cp_gamescore::register_encounter_score_component("money_earned", &init_money_earned_score, &reset_team_money_earned_performance, &reset_player_money_earned_performance, &calculate_money_earned_score, 30, "money_earned");
}

function init_tickets_earned_score_component() {
  scripts\cp\cp_gamescore::register_encounter_score_component("tickets_earned", &init_tickets_earned_score, &reset_team_tickets_earned_performance, &reset_player_tickets_earned_performance, &calculate_tickets_earned_score, 31, "tickets_earned");
}

function init_consumables_earned_score_component() {
  scripts\cp\cp_gamescore::register_encounter_score_component("consumables_earned", &init_consumables_earned_score, &reset_team_consumables_earned_performance, &reset_player_consumables_earned_performance, &calculate_consumables_earned_score, 32, "consumables_earned");
}

function init_consumables_earned_score(var_0) {
  return var_0;
}

function reset_team_consumables_earned_performance(var_0) {
  return var_0;
}

function reset_player_consumables_earned_performance(var_0) {
  var_0.encounter_performance["total_consumables_earned"] = 0;
}

function calculate_consumables_earned_score(var_0, var_1) {
  var_2 = scripts\cp\cp_gamescore::get_player_encounter_performance(var_0, "total_consumables_earned");
  var_3 = min(50000, var_2 * 10000);
  return int(var_3);
}

function init_tickets_earned_score(var_0) {
  return var_0;
}

function reset_team_tickets_earned_performance(var_0) {
  return var_0;
}

function reset_player_tickets_earned_performance(var_0) {
  var_0.encounter_performance["total_tickets_earned"] = 0;
}

function calculate_tickets_earned_score(var_0, var_1) {
  var_2 = scripts\cp\cp_gamescore::get_player_encounter_performance(var_0, "total_tickets_earned");
  var_3 = min(999999, var_2 * 1);
  return int(var_3);
}

function init_money_earned_score(var_0) {
  return var_0;
}

function reset_team_money_earned_performance(var_0) {
  return var_0;
}

function reset_player_money_earned_performance(var_0) {
  var_0.encounter_performance["total_money_earned"] = 0;
}

function calculate_money_earned_score(var_0, var_1) {
  var_2 = scripts\cp\cp_gamescore::get_player_encounter_performance(var_0, "total_money_earned");
  var_3 = min(999999, var_2 * 1);
  return int(var_3);
}

function init_damage_score(var_0) {
  return var_0;
}

function reset_team_damage_performance(var_0) {
  return var_0;
}

function reset_player_damage_performance(var_0) {
  var_0.encounter_performance["damage_done_on_agent"] = 0;
}

function calculate_damage_score(var_0, var_1) {
  var_2 = scripts\cp\cp_gamescore::get_player_encounter_performance(var_0, "damage_done_on_agent");
  var_3 = min(999999, var_2 * 0.2);
  return int(var_3);
}

function update_agent_damage_performance(var_0, var_1, var_2) {
  if(var_2 == "MOD_TRIGGER_HURT") {
    return;
  }

  var_3 = scripts\cp\utility::get_attacker_as_player(var_0);

  if(!isDefined(var_3)) {
    return;
  }

  var_3 scripts\cp\cp_gamescore::update_personal_encounter_performance("damage", "damage_done_on_agent", var_1);
}

function update_money_earned_performance(var_0, var_1) {
  var_0 scripts\cp\cp_gamescore::update_personal_encounter_performance("money_earned", "total_money_earned", var_1);
}

function update_tickets_earned_performance(var_0, var_1) {
  var_0 scripts\cp\cp_gamescore::update_personal_encounter_performance("tickets_earned", "total_tickets_earned", var_1);
}

function zombies_endgameencounterscorefunc(var_0) {
  scripts\cp\cp_gamescore::calculate_encounter_scores(level.players, ["money_earned"], var_0);
}