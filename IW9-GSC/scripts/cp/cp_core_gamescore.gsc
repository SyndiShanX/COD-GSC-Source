/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_core_gamescore.gsc
***********************************************/

init_zombie_scoring() {
  init_eog_score_components(["money_earned"]);
  init_encounter_score_components(["money_earned"]);
  set_level_score_data();
  set_level_score_callback_func();
}

set_level_score_data() {
  level.cycle_score_scalar = 1;
}

set_level_score_callback_func() {
  level.endgameencounterscorefunc = ::zombies_endgameencounterscorefunc;
}

init_eog_score_components(_id_BEF62E0AD2260FAF) {
  foreach(_id_A475D6DAA5DD7242 in _id_BEF62E0AD2260FAF) {
    switch (_id_A475D6DAA5DD7242) {
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
    }
  }
}

init_encounter_score_components(_id_BEF62E0AD2260FAF) {
  level.encounter_score_components = [];

  foreach(_id_A475D6DAA5DD7242 in _id_BEF62E0AD2260FAF) {
    switch (_id_A475D6DAA5DD7242) {
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
    }
  }
}

init_damage_score_component() {
  scripts\cp\cp_gamescore::register_encounter_score_component("damage", ::init_damage_score, ::reset_team_damage_performance, ::reset_player_damage_performance, ::calculate_damage_score, 29, "damage");
}

init_money_earned_score_component() {
  scripts\cp\cp_gamescore::register_encounter_score_component("money_earned", ::init_money_earned_score, ::reset_team_money_earned_performance, ::reset_player_money_earned_performance, ::calculate_money_earned_score, 30, "money_earned");
}

init_tickets_earned_score_component() {
  scripts\cp\cp_gamescore::register_encounter_score_component("tickets_earned", ::init_tickets_earned_score, ::reset_team_tickets_earned_performance, ::reset_player_tickets_earned_performance, ::calculate_tickets_earned_score, 31, "tickets_earned");
}

init_consumables_earned_score_component() {
  scripts\cp\cp_gamescore::register_encounter_score_component("consumables_earned", ::init_consumables_earned_score, ::reset_team_consumables_earned_performance, ::reset_player_consumables_earned_performance, ::calculate_consumables_earned_score, 32, "consumables_earned");
}

init_consumables_earned_score(_id_41A9C90605002D6F) {
  return _id_41A9C90605002D6F;
}

reset_team_consumables_earned_performance(_id_41A9C90605002D6F) {
  return _id_41A9C90605002D6F;
}

reset_player_consumables_earned_performance(player) {
  player.encounter_performance["total_consumables_earned"] = 0;
}

calculate_consumables_earned_score(player, _id_41A9C90605002D6F) {
  _id_8A33C022619D498C = scripts\cp\cp_gamescore::get_player_encounter_performance(player, "total_consumables_earned");
  _id_9569B1B99ABF90C6 = min(50000, _id_8A33C022619D498C * 10000);
  return int(_id_9569B1B99ABF90C6);
}

init_tickets_earned_score(_id_41A9C90605002D6F) {
  return _id_41A9C90605002D6F;
}

reset_team_tickets_earned_performance(_id_41A9C90605002D6F) {
  return _id_41A9C90605002D6F;
}

reset_player_tickets_earned_performance(player) {
  player.encounter_performance["total_tickets_earned"] = 0;
}

calculate_tickets_earned_score(player, _id_41A9C90605002D6F) {
  _id_78A8533212B63DC3 = scripts\cp\cp_gamescore::get_player_encounter_performance(player, "total_tickets_earned");
  _id_26219AB0863D9D40 = min(999999, _id_78A8533212B63DC3 * 1);
  return int(_id_26219AB0863D9D40);
}

init_money_earned_score(_id_41A9C90605002D6F) {
  return _id_41A9C90605002D6F;
}

reset_team_money_earned_performance(_id_41A9C90605002D6F) {
  return _id_41A9C90605002D6F;
}

reset_player_money_earned_performance(player) {
  player.encounter_performance["total_money_earned"] = 0;
}

calculate_money_earned_score(player, _id_41A9C90605002D6F) {
  _id_A97B8220053AB0E0 = scripts\cp\cp_gamescore::get_player_encounter_performance(player, "total_money_earned");
  _id_387AFE16B0C786AF = min(999999, _id_A97B8220053AB0E0 * 1);
  return int(_id_387AFE16B0C786AF);
}

init_damage_score(_id_41A9C90605002D6F) {
  return _id_41A9C90605002D6F;
}

reset_team_damage_performance(_id_41A9C90605002D6F) {
  return _id_41A9C90605002D6F;
}

reset_player_damage_performance(player) {
  player.encounter_performance["damage_done_on_agent"] = 0;
}

calculate_damage_score(player, _id_41A9C90605002D6F) {
  _id_AF7452D5C3C28DA1 = scripts\cp\cp_gamescore::get_player_encounter_performance(player, "damage_done_on_agent");
  _id_5665F99B8D71126A = min(999999, _id_AF7452D5C3C28DA1 * 0.2);
  return int(_id_5665F99B8D71126A);
}

update_agent_damage_performance(eattacker, idamage, smeansofdeath) {
  if(smeansofdeath == "MOD_TRIGGER_HURT") {
    return;
  }
  _id_FE62B570456AEFB9 = scripts\cp\utility::get_attacker_as_player(eattacker);

  if(!isDefined(_id_FE62B570456AEFB9)) {
    return;
  }
  _id_FE62B570456AEFB9 scripts\cp\cp_gamescore::update_personal_encounter_performance("damage", "damage_done_on_agent", idamage);
}

update_money_earned_performance(player, amount) {
  player scripts\cp\cp_gamescore::update_personal_encounter_performance("money_earned", "total_money_earned", amount);
}

update_tickets_earned_performance(player, amount) {
  player scripts\cp\cp_gamescore::update_personal_encounter_performance("tickets_earned", "total_tickets_earned", amount);
}

zombies_endgameencounterscorefunc(override) {
  scripts\cp\cp_gamescore::calculate_encounter_scores(level.players, ["money_earned"], override);
}