/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_gamescore_armory.gsc
***********************************************/

init_armory_eog_score_components(var_0) {
  foreach(var_2 in var_0) {
    switch (var_2) {
      case "spider":
        maps\mp\alien\_gamescore::register_eog_score_component("spider", 12);
        break;
      case "relics":
        maps\mp\alien\_gamescore::register_eog_score_component("relics", 5);
        break;
      default:
    }
  }
}

init_armory_encounter_score_components(var_0) {
  foreach(var_2 in var_0) {
    switch (var_2) {
      case "first_spider":
        init_first_spider_score_component();
        break;
      case "final_spider":
        init_final_spider_score_component();
        break;
      case "spider_challenge":
        init_spider_challenge_score_component();
        break;
      case "spider_team":
        init_spider_teamwork_score_component();
        break;
      case "spider_personal":
        init_spider_personal_score_component();
        break;
      default:
    }
  }
}

init_first_spider_score_component() {
  maps\mp\alien\_gamescore::register_encounter_score_component("first_spider", ::init_first_spider_score, ::reset_team_spider_performance, undefined, ::calculate_spider_score, 12, "spider");
}

init_first_spider_score(var_0) {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    var_0.max_score_spider = 4500;
  }
  else {
    var_0.max_score_spider = 3500;
  }

  var_0.battle_time_limit = 600000;
  return var_0;
}

reset_team_spider_performance(var_0) {
  var_0.team_encounter_performance["spider_battle_time"] = 0;
  return var_0;
}

calculate_spider_score(var_0, var_1) {
  var_2 = maps\mp\alien\_gamescore::get_team_encounter_performance(var_1, "spider_battle_time");
  var_3 = max(0, var_1.battle_time_limit - var_2);
  var_4 = var_1.max_score_spider * (var_3 / var_1.battle_time_limit);
  return int(var_4);
}

calculate_and_show_first_spider_score() {
  var_0 = get_first_spider_score_component_name_list();
  maps\mp\alien\_gamescore::calculate_and_show_encounter_scores(level.players, var_0);

  foreach(var_2 in level.players) {
  var_2 thread maps\mp\alien\_hive::wait_to_give_rewards();
  }
}

get_first_spider_score_component_name_list() {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    return ["first_spider", "spider_personal", "spider_challenge"];
  }
  else {
    return ["first_spider", "spider_team", "spider_personal", "spider_challenge"];
  }
}

init_final_spider_score_component() {
  maps\mp\alien\_gamescore::register_encounter_score_component("final_spider", ::init_final_spider_score, ::reset_team_spider_performance, undefined, ::calculate_spider_score, 12, "spider");
}

init_final_spider_score(var_0) {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    var_0.max_score_spider = 4500;
  }
  else {
    var_0.max_score_spider = 3500;
  }

  var_0.battle_time_limit = 900000;
  return var_0;
}

calculate_final_spider_score() {
  var_0 = get_final_spider_score_component_name_list();
  maps\mp\alien\_gamescore::calculate_encounter_scores(level.players, var_0);
}

get_final_spider_score_component_name_list() {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    return ["first_spider", "spider_personal"];
  }
  else {
    return ["first_spider", "spider_team", "spider_personal"];
  }
}

init_spider_challenge_score_component() {
  maps\mp\alien\_gamescore::register_encounter_score_component("spider_challenge", ::init_spider_challenge_score, undefined, maps\mp\alien\_gamescore::reset_player_challenge_performance, maps\mp\alien\_gamescore::calculate_challenge_score, 4, "spider");
}

init_spider_challenge_score(var_0) {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    var_0.max_score = 1500;
  }
  else {
    var_0.max_score = 1000;
  }

  return var_0;
}

init_spider_teamwork_score_component() {
  maps\mp\alien\_gamescore::register_encounter_score_component("spider_team", maps\mp\alien\_gamescore::init_teamwork_score, maps\mp\alien\_gamescore::reset_team_score_performance, maps\mp\alien\_gamescore::reset_player_teamwork_score_performance, maps\mp\alien\_gamescore::calculate_teamwork_score, 2, "spider");
}

init_spider_personal_score_component() {
  maps\mp\alien\_gamescore::register_encounter_score_component("spider_personal", ::init_spider_personal_score, undefined, maps\mp\alien\_gamescore::reset_player_personal_score_performance, maps\mp\alien\_gamescore::calculate_personal_skill_score, 3, "spider");
}

init_spider_personal_score(var_0) {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    var_0.max_score_damage_taken = 2500;
    var_0.max_score_accuracy = 1500;
  } else {
    var_0.max_score_damage_taken = 1500;
    var_0.max_score_accuracy = 1000;
  }

  return var_0;
}