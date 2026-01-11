/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_gamescore_dlc3.gsc
*********************************************/

init_descent_eog_score_components(var_0) {
  foreach(var_2 in var_0) {
    switch (var_2) {
      case "hive":
        maps\mp\alien\_gamescore::register_eog_score_component("hive", 19);
        break;
      case "gryphon":
        maps\mp\alien\_gamescore::register_eog_score_component("gryphon", 20);
        break;
      case "ark":
        maps\mp\alien\_gamescore::register_eog_score_component("ark", 22);
        break;
      case "escape":
        maps\mp\alien\_gamescore::register_eog_score_component("escape", 9);
        break;
      case "relics":
        maps\mp\alien\_gamescore::register_eog_score_component("relics", 5);
        break;
      default:
    }
  }
}

init_encounter_score_components(var_0) {
  foreach(var_2 in var_0) {
    switch (var_2) {
      case "gryphon":
        init_gryphon_score_component();
        break;
      case "gryphon_team":
        init_gryphon_team_score_component();
        break;
      case "gryphon_personal":
        init_gryphon_personal_score_component();
        break;
      case "cortex":
        init_cortex_score_component();
        break;
      case "cortex_team":
        init_cortex_team_component();
        break;
      case "cortex_personal":
        init_cortex_personal_component();
        break;
      case "escape":
        init_escape_component();
        break;
      case "escape_team":
        init_escape_team_component();
        break;
      case "escape_personal":
        init_escape_personal_component();
        break;
      default:
    }
  }
}

init_gryphon_score_component() {
  maps\mp\alien\_gamescore::register_encounter_score_component("gryphon", ::reset_gryphon_score, ::reset_gryphon_score, undefined, ::calculate_gryphon_score, 21, "gryphon");
}

reset_gryphon_score(var_0) {
  var_0.team_encounter_performance["damage_on_gryphon"] = 0;
  var_0.team_encounter_performance["gryphon_encounter_duration"] = 0;
  return var_0;
}

calculate_gryphon_score(var_0, var_1) {
  var_2 = maps\mp\alien\_gamescore::get_team_encounter_performance(var_1, "damage_on_gryphon");
  var_3 = maps\mp\alien\_gamescore::calculate_under_max_score(var_2, 150, 3000);
  var_4 = maps\mp\alien\_gamescore::get_team_encounter_performance(var_1, "gryphon_encounter_duration");
  var_5 = maps\mp\alien\_gamescore::calculate_under_max_score(var_4, 300000, 3000);
  return var_5 + var_3;
}

init_gryphon_team_score_component() {
  maps\mp\alien\_gamescore::register_encounter_score_component("gryphon_team", maps\mp\alien\_gamescore::init_teamwork_score, maps\mp\alien\_gamescore::reset_team_score_performance, maps\mp\alien\_gamescore::reset_player_teamwork_score_performance, maps\mp\alien\_gamescore::calculate_teamwork_score, 2, "gryphon");
}

init_gryphon_personal_score_component() {
  maps\mp\alien\_gamescore::register_encounter_score_component("gryphon_personal", ::init_gryphon_personal_score, undefined, ::reset_player_gryphon_personal_score_performance, ::calculate_rgyphon_personal_skill_score, 3, "gryphon");
}

init_gryphon_personal_score(var_0) {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    var_0.max_score_damage_taken = 4000;
  } else {
    var_0.max_score_damage_taken = 1000;
  }

  return var_0;
}

reset_player_gryphon_personal_score_performance(var_0) {
  var_0.encounter_performance["damage_taken"] = 0;
}

calculate_rgyphon_personal_skill_score(var_0, var_1) {
  var_2 = maps\mp\alien\_gamescore::get_player_encounter_performance(var_0, "damage_taken");
  return maps\mp\alien\_gamescore::calculate_under_max_score(var_2, 500, var_1.max_score_damage_taken);
}

get_gryphon_score_component_list() {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    return ["gryphon", "gryphon_personal"];
  } else {
    return ["gryphon", "gryphon_team", "gryphon_personal"];
  }
}

init_cortex_score_component() {
  maps\mp\alien\_gamescore::register_encounter_score_component("cortex", ::inti_cortex_score, ::reset_cortex_score, undefined, ::calculate_cortex_score, 23, "ark");
}

inti_cortex_score(var_0) {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    var_0.max_cortex_score = 6000;
  } else {
    var_0.max_cortex_score = 4500;
  }

  reset_cortex_score(var_0);
  return var_0;
}

reset_cortex_score(var_0) {
  var_0.team_encounter_performance["times_cortex_activated"] = 0;
  return var_0;
}

calculate_cortex_score(var_0, var_1) {
  var_2 = maps\mp\alien\_gamescore::get_team_encounter_performance(var_1, "times_cortex_activated");
  return int(clamp(var_2 * 500, 0, var_1.max_cortex_score));
}

init_cortex_team_component() {
  maps\mp\alien\_gamescore::register_encounter_score_component("cortex_team", maps\mp\alien\_gamescore::init_teamwork_score, maps\mp\alien\_gamescore::reset_team_score_performance, maps\mp\alien\_gamescore::reset_player_teamwork_score_performance, maps\mp\alien\_gamescore::calculate_teamwork_score, 2, "ark");
}

init_cortex_personal_component() {
  maps\mp\alien\_gamescore::register_encounter_score_component("cortex_personal", maps\mp\alien\_gamescore::init_personal_score, undefined, maps\mp\alien\_gamescore::reset_player_personal_score_performance, maps\mp\alien\_gamescore::calculate_personal_skill_score, 3, "ark");
}

get_ark_score_component_list() {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    return ["cortex", "cortex_personal"];
  } else {
    return ["cortex", "cortex_team", "cortex_personal"];
  }
}

init_escape_component() {
  maps\mp\alien\_gamescore::register_encounter_score_component("escape", ::init_escape_score, ::reset_escape_score, undefined, ::calculate_escape_score, 9, "escape");
}

init_escape_score(var_0) {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    var_0.max_escape_score = 6000;
  } else {
    var_0.max_escape_score = 4500;
  }

  return var_0;
}

reset_escape_score(var_0) {
  var_0.team_encounter_performance["escape_blocker_duration"] = 0;
  return var_0;
}

calculate_escape_score(var_0, var_1) {
  var_2 = maps\mp\alien\_gamescore::get_team_encounter_performance(var_1, "escape_blocker_duration");
  return maps\mp\alien\_gamescore::calculate_under_max_score(var_2, var_1.max_escape_score, 120000);
}

calculate_escape_blocker_score(var_0) {
  maps\mp\alien\_gamescore::update_team_encounter_performance("escape", "escape_blocker_duration", var_0);
  maps\mp\alien\_gamescore::calculate_encounter_scores(level.players, get_escape_blocker_score_component_list());
}

init_escape_team_component() {
  maps\mp\alien\_gamescore::register_encounter_score_component("escape_team", maps\mp\alien\_gamescore::init_teamwork_score, maps\mp\alien\_gamescore::reset_team_score_performance, maps\mp\alien\_gamescore::reset_player_teamwork_score_performance, maps\mp\alien\_gamescore::calculate_teamwork_score, 2, "escape");
}

init_escape_personal_component() {
  maps\mp\alien\_gamescore::register_encounter_score_component("escape_personal", maps\mp\alien\_gamescore::init_personal_score, undefined, maps\mp\alien\_gamescore::reset_player_personal_score_performance, maps\mp\alien\_gamescore::calculate_personal_skill_score, 3, "escape");
}

get_escape_blocker_score_component_list() {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    return ["escape", "escape_personal"];
  } else {
    return ["escape", "escape_team", "escape_personal"];
  }
}