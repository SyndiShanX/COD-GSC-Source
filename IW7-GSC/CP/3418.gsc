/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3418.gsc
**************************************/

init_zombie_scoring() {
  _id_95CA(["money_earned"]);
  _id_95C7(["money_earned"]);
  _id_F450();
  _id_F44F();
}

_id_F450() {
  level.cycle_score_scalar = 1;
}

_id_F44F() {
  level.endgameencounterscorefunc = ::_id_13FA1;
}

_id_95CA(var_0) {
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
    }
  }
}

_id_95C7(var_0) {
  level.encounter_score_components = [];

  foreach(var_2 in var_0) {
    switch (var_2) {
      case "damage":
        _id_95A0();
        break;
      case "money_earned":
        _id_9683();
        break;
      case "tickets_earned":
        _id_9784();
        break;
      case "consumables_earned":
        _id_958B();
        break;
      default:
    }
  }
}

_id_95A0() {
  scripts\cp\cp_gamescore::register_encounter_score_component("damage", ::_id_959F, ::_id_E22D, ::_id_E214, ::_id_36E5, 29, "damage");
}

_id_9683() {
  scripts\cp\cp_gamescore::register_encounter_score_component("money_earned", ::_id_9682, ::_id_E230, ::_id_E218, ::_id_36F8, 30, "money_earned");
}

_id_9784() {
  scripts\cp\cp_gamescore::register_encounter_score_component("tickets_earned", ::_id_9783, ::_id_E233, ::_id_E220, ::_id_3707, 31, "tickets_earned");
}

_id_958B() {
  scripts\cp\cp_gamescore::register_encounter_score_component("consumables_earned", ::_id_958A, ::_id_E22C, ::_id_E213, ::_id_36E3, 32, "consumables_earned");
}

_id_958A(var_0) {
  return var_0;
}

_id_E22C(var_0) {
  return var_0;
}

_id_E213(var_0) {
  var_0.encounter_performance["total_consumables_earned"] = 0;
}

_id_36E3(var_0, var_1) {
  var_2 = scripts\cp\cp_gamescore::get_player_encounter_performance(var_0, "total_consumables_earned");
  var_3 = min(50000, var_2 * 10000);
  return int(var_3);
}

_id_9783(var_0) {
  return var_0;
}

_id_E233(var_0) {
  return var_0;
}

_id_E220(var_0) {
  var_0.encounter_performance["total_tickets_earned"] = 0;
}

_id_3707(var_0, var_1) {
  var_2 = scripts\cp\cp_gamescore::get_player_encounter_performance(var_0, "total_tickets_earned");
  var_3 = min(999999, var_2 * 1);
  return int(var_3);
}

_id_9682(var_0) {
  return var_0;
}

_id_E230(var_0) {
  return var_0;
}

_id_E218(var_0) {
  var_0.encounter_performance["total_money_earned"] = 0;
}

_id_36F8(var_0, var_1) {
  var_2 = scripts\cp\cp_gamescore::get_player_encounter_performance(var_0, "total_money_earned");
  var_3 = min(999999, var_2 * 1);
  return int(var_3);
}

_id_959F(var_0) {
  return var_0;
}

_id_E22D(var_0) {
  return var_0;
}

_id_E214(var_0) {
  var_0.encounter_performance["damage_done_on_agent"] = 0;
}

_id_36E5(var_0, var_1) {
  var_2 = scripts\cp\cp_gamescore::get_player_encounter_performance(var_0, "damage_done_on_agent");
  var_3 = min(999999, var_2 * 0.2);
  return int(var_3);
}

update_agent_damage_performance(var_0, var_1, var_2) {
  if(var_2 == "MOD_TRIGGER_HURT") {
    return;
  }
  var_3 = scripts\cp\utility::get_attacker_as_player(var_0);

  if(!isDefined(var_3)) {
    return;
  }
  var_3 scripts\cp\cp_gamescore::update_personal_encounter_performance("damage", "damage_done_on_agent", var_1);
}

update_money_earned_performance(var_0, var_1) {
  var_0 scripts\cp\cp_gamescore::update_personal_encounter_performance("money_earned", "total_money_earned", var_1);
  scripts\cp\zombies\zombie_analytics::_id_AF67(var_0, var_1);
}

update_tickets_earned_performance(var_0, var_1) {
  var_0 scripts\cp\cp_gamescore::update_personal_encounter_performance("tickets_earned", "total_tickets_earned", var_1);
}

_id_13FA1(var_0) {
  scripts\cp\cp_gamescore::calculate_encounter_scores(level.players, ["money_earned"], var_0);
}