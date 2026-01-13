/****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombies_gamescore.gsc
****************************************************/

init_zombie_scoring() {
  func_95CA(["money_earned"]);
  func_95C7(["money_earned"]);
  func_F450();
  func_F44F();
}

func_F450() {
  level.cycle_score_scalar = 1;
}

func_F44F() {
  level.endgameencounterscorefunc = ::func_13FA1;
}

func_95CA(var_0) {
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

func_95C7(var_0) {
  level.encounter_score_components = [];
  foreach(var_2 in var_0) {
    switch (var_2) {
      case "damage":
        func_95A0();
        break;

      case "money_earned":
        func_9683();
        break;

      case "tickets_earned":
        func_9784();
        break;

      case "consumables_earned":
        func_958B();
        break;

      default:
        break;
    }
  }
}

func_95A0() {
  scripts\cp\cp_gamescore::register_encounter_score_component("damage", ::func_959F, ::func_E22D, ::func_E214, ::func_36E5, 29, "damage");
}

func_9683() {
  scripts\cp\cp_gamescore::register_encounter_score_component("money_earned", ::func_9682, ::func_E230, ::func_E218, ::func_36F8, 30, "money_earned");
}

func_9784() {
  scripts\cp\cp_gamescore::register_encounter_score_component("tickets_earned", ::func_9783, ::func_E233, ::func_E220, ::func_3707, 31, "tickets_earned");
}

func_958B() {
  scripts\cp\cp_gamescore::register_encounter_score_component("consumables_earned", ::func_958A, ::func_E22C, ::func_E213, ::func_36E3, 32, "consumables_earned");
}

func_958A(var_0) {
  return var_0;
}

func_E22C(var_0) {
  return var_0;
}

func_E213(var_0) {
  var_0.encounter_performance["total_consumables_earned"] = 0;
}

func_36E3(var_0, var_1) {
  var_2 = scripts\cp\cp_gamescore::get_player_encounter_performance(var_0, "total_consumables_earned");
  var_3 = min(-15536, var_2 * 10000);
  return int(var_3);
}

func_9783(var_0) {
  return var_0;
}

func_E233(var_0) {
  return var_0;
}

func_E220(var_0) {
  var_0.encounter_performance["total_tickets_earned"] = 0;
}

func_3707(var_0, var_1) {
  var_2 = scripts\cp\cp_gamescore::get_player_encounter_performance(var_0, "total_tickets_earned");
  var_3 = min(999999, var_2 * 1);
  return int(var_3);
}

func_9682(var_0) {
  return var_0;
}

func_E230(var_0) {
  return var_0;
}

func_E218(var_0) {
  var_0.encounter_performance["total_money_earned"] = 0;
}

func_36F8(var_0, var_1) {
  var_2 = scripts\cp\cp_gamescore::get_player_encounter_performance(var_0, "total_money_earned");
  var_3 = min(999999, var_2 * 1);
  return int(var_3);
}

func_959F(var_0) {
  return var_0;
}

func_E22D(var_0) {
  return var_0;
}

func_E214(var_0) {
  var_0.encounter_performance["damage_done_on_agent"] = 0;
}

func_36E5(var_0, var_1) {
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
  scripts\cp\zombies\zombie_analytics::func_AF67(var_0, var_1);
}

update_tickets_earned_performance(var_0, var_1) {
  var_0 scripts\cp\cp_gamescore::update_personal_encounter_performance("tickets_earned", "total_tickets_earned", var_1);
}

func_13FA1(var_0) {
  scripts\cp\cp_gamescore::calculate_encounter_scores(level.players, ["money_earned"], var_0);
}