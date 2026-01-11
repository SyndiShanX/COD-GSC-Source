/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_gamescore_last.gsc
*********************************************/

init_last_eog_score_components(var_0) {
  foreach(var_2 in var_0) {
    switch (var_2) {
      case "street":
        maps\mp\alien\_gamescore::register_eog_score_component("street", 24);
        break;
      case "relics":
        maps\mp\alien\_gamescore::register_eog_score_component("relics", 5);
        break;
      case "generator":
        maps\mp\alien\_gamescore::register_eog_score_component("generator", 25);
        break;
      case "cortex":
        maps\mp\alien\_gamescore::register_eog_score_component("cortex", 29);
        break;
      case "item_crafting":
        maps\mp\alien\_gamescore::register_eog_score_component("item_crafting", 27);
        break;
      case "ancestor_bonus":
        maps\mp\alien\_gamescore::register_eog_score_component("ancestor_bonus", 28);
        break;
      default:
    }
  }
}

init_last_encounter_score_components(var_0) {
  foreach(var_2 in var_0) {
    switch (var_2) {
      case "street_personal":
        init_street_personal_score_component();
        break;
      case "street_team":
        init_street_team_score_component();
        break;
      case "street_challenge":
        init_street_challenge_score_component();
        break;
      case "generator":
        init_generator_score_component();
        break;
      case "generator_personal":
        init_generator_personal_score_component();
        break;
      case "generator_team":
        init_generator_team_score_component();
        break;
      case "generator_challenge":
        init_generator_challenge_score_component();
        break;
      case "item_crafting":
        init_item_crafting_score_component();
        break;
      case "ancestor_bonus":
        init_ancestor_bonus_score_component();
        break;
      case "cortex":
        init_cortex_score_component();
        break;
      default:
    }
  }
}

init_street_personal_score_component() {
  maps\mp\alien\_gamescore::register_encounter_score_component("street_personal", ::init_street_personal_score, undefined, maps\mp\alien\_gamescore::reset_player_personal_score_performance, maps\mp\alien\_gamescore::calculate_personal_skill_score, 3, "street");
}

init_street_personal_score(var_0) {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    var_0.max_score_damage_taken = 5000;
    var_0.max_score_accuracy = 3500;
  } else {
    var_0.max_score_damage_taken = 2200;
    var_0.max_score_accuracy = 1700;
  }

  return var_0;
}

init_street_team_score_component() {
  maps\mp\alien\_gamescore::register_encounter_score_component("street_team", ::init_street_teamwork_score, maps\mp\alien\_gamescore::reset_team_score_performance, maps\mp\alien\_gamescore::reset_player_teamwork_score_performance, maps\mp\alien\_gamescore::calculate_teamwork_score, 2, "street");
}

init_street_teamwork_score(var_0) {
  var_0.max_score_deploy = 1700;
  var_0.max_score_revive = 1700;
  var_0.max_score_damage = 1700;
  maps\mp\alien\_gamescore::reset_team_score_performance(var_0);
  return var_0;
}

init_street_challenge_score_component() {
  maps\mp\alien\_gamescore::register_encounter_score_component("street_challenge", maps\mp\alien\_gamescore::init_challenge_score, undefined, maps\mp\alien\_gamescore::reset_player_challenge_performance, maps\mp\alien\_gamescore::calculate_challenge_score, 4, "street");
}

init_generator_score_component() {
  maps\mp\alien\_gamescore::register_encounter_score_component("generator", maps\mp\alien\_gamescore::init_drill_score, maps\mp\alien\_gamescore::reset_team_drill_performance, undefined, maps\mp\alien\_gamescore::calculate_drill_protection_score, 26, "generator");
}

init_generator_personal_score_component() {
  maps\mp\alien\_gamescore::register_encounter_score_component("generator_personal", maps\mp\alien\_gamescore::init_personal_score, undefined, maps\mp\alien\_gamescore::reset_player_personal_score_performance, maps\mp\alien\_gamescore::calculate_personal_skill_score, 3, "generator");
}

init_generator_team_score_component() {
  maps\mp\alien\_gamescore::register_encounter_score_component("generator_team", maps\mp\alien\_gamescore::init_teamwork_score, maps\mp\alien\_gamescore::reset_team_score_performance, maps\mp\alien\_gamescore::reset_player_teamwork_score_performance, maps\mp\alien\_gamescore::calculate_teamwork_score, 2, "generator");
}

init_generator_challenge_score_component() {
  maps\mp\alien\_gamescore::register_encounter_score_component("generator_challenge", maps\mp\alien\_gamescore::init_challenge_score, undefined, maps\mp\alien\_gamescore::reset_player_challenge_performance, maps\mp\alien\_gamescore::calculate_challenge_score, 4, "generator");
}

init_item_crafting_score_component() {
  maps\mp\alien\_gamescore::register_encounter_score_component("item_crafting", ::blank_score_component_init, maps\mp\alien\_globallogic::blank, undefined, ::calculate_item_crafting_score, 27, "item_crafting");
}

calculate_item_crafting_score(var_0, var_1) {
  var_2 = int(500 / level.cycle_score_scalar);
  var_3 = get_total_item_crafting_score(var_0, var_1);
  return min(var_2, 5000 - var_3);
}

get_total_item_crafting_score(var_0, var_1) {
  return var_0.end_game_score[var_1.end_game_score_component_ref];
}

init_ancestor_bonus_score_component() {
  maps\mp\alien\_gamescore::register_encounter_score_component("ancestor_bonus", ::blank_score_component_init, ::reset_team_ancestor_bonus_performance, undefined, ::calculate_ancestor_bonus_score, 28, "ancestor_bonus");
}

reset_team_ancestor_bonus_performance(var_0) {
  var_0.team_encounter_performance["num_ancestor_killed"] = 0;
  var_0.team_encounter_performance["encounter_start_time"] = gettime();
  return var_0;
}

calculate_ancestor_bonus_score(var_0, var_1) {
  var_2 = gettime() - var_1.team_encounter_performance["encounter_start_time"];
  return maps\mp\alien\_gamescore::calculate_under_max_score(var_2, 300000, 10000);
}

init_cortex_score_component() {
  maps\mp\alien\_gamescore::register_encounter_score_component("cortex", ::init_cortex_score, ::reset_team_cortex_performance, undefined, ::calculate_cortex_score, 29, "cortex");
}

init_cortex_score(var_0) {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    var_0.max_cortex_damage_limit = 1200;
  } else {
    var_0.max_cortex_damage_limit = 750;
  }

  return var_0;
}

reset_team_cortex_performance(var_0) {
  var_0.team_encounter_performance["damage_done_on_cortex"] = 0;
  var_0.team_encounter_performance["reach_charge_goal"] = 0;
  return var_0;
}

calculate_cortex_score(var_0, var_1) {
  var_2 = maps\mp\alien\_gamescore::get_team_encounter_performance(var_1, "damage_done_on_cortex");
  var_3 = maps\mp\alien\_gamescore::calculate_under_max_score(var_2, var_1.max_cortex_damage_limit, 8000);
  var_4 = maps\mp\alien\_gamescore::get_team_encounter_performance(var_1, "reach_charge_goal") * 2000;
  return int(var_3 + var_4);
}

update_cortex_charge_bonus(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0 * 25;

  if(maps\mp\mp_alien_last_final_battle::get_cortex_charge_percent() >= var_1) {
    maps\mp\alien\_gamescore::update_team_encounter_performance("cortex", "reach_charge_goal");
  }
}

init_partial_hive_score_component_list_func() {
  level.partial_hive_score_component_list_func = ::last_partial_hive_score_component_list;
}

last_partial_hive_score_component_list() {
  return ["street_challenge", "street_team"];
}

update_generator_score_component_name() {
  maps\mp\alien\_gamescore::set_challenge_score_component_name("generator_challenge");
  maps\mp\alien\_gamescore::set_personal_score_component_name("generator_personal");
  maps\mp\alien\_gamescore::set_team_score_component_name("generator_team");
}

update_street_score_component_name() {
  maps\mp\alien\_gamescore::set_challenge_score_component_name("street_challenge");
  maps\mp\alien\_gamescore::set_personal_score_component_name("street_personal");
  maps\mp\alien\_gamescore::set_team_score_component_name("street_team");
}

blank_score_component_init(var_0) {
  return var_0;
}