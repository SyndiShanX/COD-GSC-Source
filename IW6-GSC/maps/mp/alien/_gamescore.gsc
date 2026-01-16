/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_gamescore.gsc
****************************************/

#include maps\mp\alien\_utility;

SCORE_TO_CASH_CONVERSION = 0.1;
PRESTIGE_RELIC_SCORE_BONUS = 0.2;

CONST_UI_STRING_INDEX_DRILL_PROTECT = 1;
CONST_UI_STRING_INDEX_TEAMWORK = 2;
CONST_UI_STRING_INDEX_PERSONAL_SKILL = 3;
CONST_UI_STRING_INDEX_CHALLENGE = 4;
CONST_UI_STRING_INDEX_RELIC_BONUS = 5;
CONST_UI_STRING_INDEX_TOTAL_SCORE = 6;
CONST_UI_STRING_INDEX_BONUS_MONEY = 7;
CONST_UI_STRING_INDEX_HIVE = 8;
CONST_UI_STRING_INDEX_ESCAPE = 9;
CONST_UI_STRING_INDEX_EOG_TOTAL_SCORE = 10;

CONST_NAME_REF_CHALLENGE = "challenge";
CONST_NAME_REF_DRILL = "drill";
CONST_NAME_REF_TEAM = "team";
CONST_NAME_REF_PERSONAL = "personal";
CONST_NAME_REF_ESCAPE = "escape";
CONST_NAME_REF_TEAM_BLK = "team_blocker";
CONST_NAME_REF_PERSONAL_BLK = "personal_blocker";

CONST_NAME_REF_EOG_HIVE = "hive";
CONST_NAME_REF_EOG_ESCAPE = "escape";
CONST_NAME_REF_EOG_RELICS = "relics";

init_gamescore() {
  register_scoring_mode();
}

init_eog_score_components(component_name_list) {
  level.eog_score_components = [];

  foreach(component_name in component_name_list) {
    switch (component_name) {
      case CONST_NAME_REF_EOG_HIVE:
        register_eog_score_component(CONST_NAME_REF_EOG_HIVE, CONST_UI_STRING_INDEX_HIVE);
        break;

      case CONST_NAME_REF_EOG_ESCAPE:
        register_eog_score_component(CONST_NAME_REF_EOG_ESCAPE, CONST_UI_STRING_INDEX_ESCAPE);
        break;

      case CONST_NAME_REF_EOG_RELICS:
        register_eog_score_component(CONST_NAME_REF_EOG_RELICS, CONST_UI_STRING_INDEX_RELIC_BONUS);
        break;

      default:
        AssertMsg("'" + component_name + "' is not a supported end-of-game score component.");
    }
  }
}

init_encounter_score_components(component_name_list) {
  level.encounter_score_components = [];

  foreach(component_name in component_name_list) {
    switch (component_name) {
      case CONST_NAME_REF_CHALLENGE:
        init_challenge_score_component();
        break;

      case CONST_NAME_REF_DRILL:
        init_drill_score_component();
        break;

      case CONST_NAME_REF_TEAM:
        init_teamwork_score_component();
        break;

      case CONST_NAME_REF_TEAM_BLK:
        init_blocker_hive_teamwork_score_component();
        break;

      case CONST_NAME_REF_PERSONAL:
        init_personal_score_component();
        break;

      case CONST_NAME_REF_PERSONAL_BLK:
        init_blocker_hive_personal_score_component();
        break;

      case CONST_NAME_REF_ESCAPE:
        init_escape_score_component();
        break;

      default:
        AssertMsg("'" + component_name + "' is not a supported round score component.");
    }
  }
}

init_player_score() {
  if(is_scoring_disabled()) {
    return;
  }
  self.encounter_performance = [];
  self.end_game_score = [];

  component_specific_init(self);
  reset_player_encounter_performance(self);
  reset_end_game_score();
}

reset_encounter_performance() {
  foreach(component_name, score_component in level.encounter_score_components) {
    if(isDefined(score_component.reset_team_performance_func))
      [[score_component.reset_team_performance_func]](score_component);
  }

  reset_players_encounter_performance_and_LUA();
}

reset_players_encounter_performance_and_LUA() {
  foreach(player in level.players) {
    reset_player_encounter_performance(player);
    maps\mp\alien\_hud::reset_player_encounter_LUA_omnvars(player);
  }
}

component_specific_init(player) {
  foreach(component_name, score_component in level.encounter_score_components) {
    if(isDefined(score_component.player_init_func))
      [[score_component.player_init_func]](player);
  }
}

reset_player_encounter_performance(player) {
  foreach(component_name, score_component in level.encounter_score_components) {
    if(isDefined(score_component.reset_player_performance_func))
      [[score_component.reset_player_performance_func]](player);
  }
}

reset_end_game_score() {
  foreach(eog_component_name, score_component in level.eog_score_components)
  self.end_game_score[eog_component_name] = 0;
}

calculate_total_end_game_score(player) {
  row_number = 1;
  total_end_game_score = 0;

  foreach(eog_score_name, eog_score_component_struct in level.eog_score_components) {
    eog_score_value = player.end_game_score[eog_score_name];
    maps\mp\alien\_hud::set_LUA_EoG_score_row(player, row_number, eog_score_component_struct.lua_string_index, eog_score_value);
    row_number++;

    total_end_game_score += eog_score_value;
  }

  maps\mp\alien\_hud::set_LUA_EoG_score_row(player, row_number, CONST_UI_STRING_INDEX_EOG_TOTAL_SCORE, total_end_game_score);
}

calculate_players_total_end_game_score() {
  if(is_scoring_disabled()) {
    return;
  }
  if(common_scripts\utility::flag_exist("drill_drilling") && common_scripts\utility::flag("drill_drilling"))
    calculate_encounter_scores(level.players, get_partial_hive_score_component_list());

  foreach(player in level.players)
  calculate_total_end_game_score(player);
}

get_partial_hive_score_component_list() {
  if(isDefined(level.partial_hive_score_component_list_func))
    return [
      [level.partial_hive_score_component_list_func]
    ]();

  return [CONST_NAME_REF_CHALLENGE, CONST_NAME_REF_TEAM];
}

update_players_encounter_performance(score_component_name, performance_type, amount) {
  foreach(player in level.players)
  player update_personal_encounter_performance(score_component_name, performance_type, amount);
}

calculate_and_show_encounter_scores(players_list, score_component_name_list) {
  calculate_encounter_scores(players_list, score_component_name_list);

  maps\mp\alien\_hud::show_encounter_scores();
}

calculate_encounter_scores(players_list, score_component_name_list) {
  foreach(player in players_list)
  calculate_player_encounter_scores(player, score_component_name_list);
}

calculate_player_encounter_scores(player, score_component_name_list) {
  /#	
  maps\mp\alien\_debug::debug_print_encounter_performance(player);

  row_number = 1;
  total_score = 0;

  foreach(score_component_name in score_component_name_list) {
    AssertEx(isDefined(level.encounter_score_components[score_component_name]), "'" + score_component_name + "' is not a initialized score component");
    score_component_struct = level.encounter_score_components[score_component_name];

    encounter_score = [
      [score_component_struct.calculate_func]
    ](player, score_component_struct);
    encounter_score *= level.cycle_score_scalar;
    encounter_score = int(encounter_score);
    player.end_game_score[score_component_struct.end_game_score_component_ref] += encounter_score;
    maps\mp\alien\_hud::set_LUA_encounter_score_row(player, row_number, score_component_struct.lua_string_index, encounter_score);

    total_score += encounter_score;
    row_number++;
  }

  num_relic_selected = player maps\mp\alien\_prestige::get_num_nerf_selected();
  relics_bonus_score = int(total_score * num_relic_selected * PRESTIGE_RELIC_SCORE_BONUS);
  AssertEx(has_eog_score_component(CONST_NAME_REF_EOG_RELICS), "'relics' needs to be initialized as one of the end-of-game score components");
  player.end_game_score["relics"] += relics_bonus_score;
  maps\mp\alien\_hud::set_LUA_encounter_score_row(player, row_number, CONST_UI_STRING_INDEX_RELIC_BONUS, relics_bonus_score);
  row_number++;

  total_score += relics_bonus_score;
  player maps\mp\alien\_persistence::eog_player_update_stat("score", total_score);
  maps\mp\alien\_hud::set_LUA_encounter_score_row(player, row_number, CONST_UI_STRING_INDEX_TOTAL_SCORE, total_score);
  row_number++;

  perk_currency_scalar = player maps\mp\alien\_perk_utility::perk_GetCurrencyScalePerHive();
  prestige_currency_scalar = player maps\mp\alien\_prestige::prestige_getMoneyEarnedScalar();
  bonus_cash_earned = int(total_score * perk_currency_scalar * prestige_currency_scalar * SCORE_TO_CASH_CONVERSION / level.cycle_score_scalar);
  bonus_cash_earned = round_up_to_nearest(bonus_cash_earned, 10);
  maps\mp\alien\_hud::set_LUA_encounter_score_row(player, row_number, CONST_UI_STRING_INDEX_BONUS_MONEY, bonus_cash_earned);

  player.encounter_score_earned = total_score;
  player.encounter_cash_earned = bonus_cash_earned;
}

COOP_CONST_MAX_SCORE_COMPLETE_CHALLENGE = 1000;
SOLO_CONST_MAX_SCORE_COMPLETE_CHALLENGE = 1500;

CONST_DEFAULT_CHALLENGE_COMPONENT_NAME = "challenge";

init_challenge_score_component() {
  register_encounter_score_component(CONST_NAME_REF_CHALLENGE, ::init_challenge_score,
    undefined, ::reset_player_challenge_performance, ::calculate_challenge_score,
    CONST_UI_STRING_INDEX_CHALLENGE,
    CONST_NAME_REF_EOG_HIVE);
}

init_challenge_score(score_component_struct) {
  if(isPlayingSolo())
    score_component_struct.max_score = SOLO_CONST_MAX_SCORE_COMPLETE_CHALLENGE;
  else
    score_component_struct.max_score = COOP_CONST_MAX_SCORE_COMPLETE_CHALLENGE;

  return score_component_struct;
}

reset_player_challenge_performance(player) {
  player.encounter_performance["challenge_complete"] = 0;
}

calculate_challenge_score(player, score_component_struct) {
  return int(player.encounter_performance["challenge_complete"] * score_component_struct.max_score);
}

get_challenge_score_component_name() {
  return common_scripts\utility::ter_op(isDefined(level.challenge_score_component_name), level.challenge_score_component_name, CONST_DEFAULT_CHALLENGE_COMPONENT_NAME);
}
set_challenge_score_component_name(challenge_score_component_name) {
  level.challenge_score_component_name = challenge_score_component_name;
}

COOP_CONST_MAX_SCORE_DRILL_DAMAGE = 3500;
SOLO_CONST_MAX_SCORE_DRILL_DAMAGE = 4500;

COOP_CONST_DRILL_DAMAGE_LIMIT = 750;
SOLO_CONST_DRILL_DAMAGE_LIMIT = 1200;

CONST_DEFAULT_DRILL_COMPONENT_NAME = "drill";

init_drill_score_component() {
  register_encounter_score_component(CONST_NAME_REF_DRILL, ::init_drill_score, ::reset_team_drill_performance,
    undefined, ::calculate_drill_protection_score,
    CONST_UI_STRING_INDEX_DRILL_PROTECT,
    CONST_NAME_REF_EOG_HIVE);
}

init_drill_score(score_component_struct) {
  if(isPlayingSolo()) {
    score_component_struct.max_score_damage_damage = SOLO_CONST_MAX_SCORE_DRILL_DAMAGE;
    score_component_struct.max_drill_damage_limit = SOLO_CONST_DRILL_DAMAGE_LIMIT;
  } else {
    score_component_struct.max_score_damage_damage = COOP_CONST_MAX_SCORE_DRILL_DAMAGE;
    score_component_struct.max_drill_damage_limit = COOP_CONST_DRILL_DAMAGE_LIMIT;
  }

  return score_component_struct;
}

reset_team_drill_performance(score_component_struct) {
  score_component_struct.team_encounter_performance["drill_damage_taken"] = 0;

  return score_component_struct;
}

calculate_drill_protection_score(player, score_component_struct) {
  damage_penalty = get_team_encounter_performance(score_component_struct, "drill_damage_taken") / score_component_struct.max_drill_damage_limit;
  damage_score_percent_earned = max(0, 1 - damage_penalty);
  max_score_drill_damage = score_component_struct.max_score_damage_damage;
  damage_score_earned = max_score_drill_damage * damage_score_percent_earned;

  maps\mp\alien\_debug::debug_print_drill_protection_score(damage_score_earned);

  return int(damage_score_earned);
}

get_drill_score_component_name() {
  return common_scripts\utility::ter_op(isDefined(level.drill_score_component_name), level.drill_score_component_name, CONST_DEFAULT_DRILL_COMPONENT_NAME);
}
set_drill_score_component_name(drill_score_component_name) {
  level.drill_score_component_name = drill_score_component_name;
}

COOP_CONST_MAX_SCORE_DEPLOY_SUPPORT = 1000;
COOP_CONST_MAX_SCORE_REVIVE_TEAMMATE = 1000;
COOP_CONST_MAX_SCORE_DAMAGE_DONE = 1000;
COOP_CONST_DEPLOY_SUPPORT = 100;
COOP_CONST_PENALTY_PER_DOWN = 200;

CONST_DEFAULT_TEAM_COMPONENT_NAME = "team";

init_teamwork_score_component() {
  register_encounter_score_component(CONST_NAME_REF_TEAM, ::init_teamwork_score, ::reset_team_score_performance, ::reset_player_teamwork_score_performance, ::calculate_teamwork_score,
    CONST_UI_STRING_INDEX_TEAMWORK,
    CONST_NAME_REF_EOG_HIVE);
}

init_teamwork_score(score_component_struct) {
  score_component_struct.max_score_deploy = COOP_CONST_MAX_SCORE_DEPLOY_SUPPORT;
  score_component_struct.max_score_revive = COOP_CONST_MAX_SCORE_REVIVE_TEAMMATE;
  score_component_struct.max_score_damage = COOP_CONST_MAX_SCORE_DAMAGE_DONE;

  reset_team_score_performance(score_component_struct);

  return score_component_struct;
}

reset_team_score_performance(score_component_struct) {
  score_component_struct.team_encounter_performance["damage_done_on_alien"] = 0;
  score_component_struct.team_encounter_performance["num_players_enter_laststand"] = 0;
  score_component_struct.team_encounter_performance["num_players_bleed_out"] = 0;

  return score_component_struct;
}

reset_player_teamwork_score_performance(player) {
  player.encounter_performance["damage_done_on_alien"] = 0;
  player.encounter_performance["team_support_deploy"] = 0;
}

calculate_teamwork_score(player, score_component_struct) {
  max_score_deploy_support = score_component_struct.max_score_deploy;
  deploy_supply_score_earned = min(max_score_deploy_support, get_player_encounter_performance(player, "team_support_deploy") * COOP_CONST_DEPLOY_SUPPORT);

  if(get_team_encounter_performance(score_component_struct, "num_players_bleed_out")) {
    revive_teammate_score_earned = 0;
  } else {
    max_score_revive = score_component_struct.max_score_revive;
    total_penalty = get_team_encounter_performance(score_component_struct, "num_players_enter_laststand") * COOP_CONST_PENALTY_PER_DOWN;
    revive_teammate_score_earned = max(0, (max_score_revive - total_penalty));
  }

  team_damage_done_on_alien = get_team_encounter_performance(score_component_struct, "damage_done_on_alien");
  if(team_damage_done_on_alien == 0)
    team_damage_done_on_alien = 1;

  damage_done_ratio = get_player_encounter_performance(player, "damage_done_on_alien") / team_damage_done_on_alien;
  max_score_damage_done = score_component_struct.max_score_damage;
  damage_score_team_pool = max_score_damage_done * level.players.size;
  damage_done_score_earned = min(max_score_damage_done, damage_done_ratio * damage_score_team_pool);

  maps\mp\alien\_debug::debug_print_teamwork_score(deploy_supply_score_earned, revive_teammate_score_earned, damage_done_score_earned);

  return int(deploy_supply_score_earned + revive_teammate_score_earned + damage_done_score_earned);
}

get_team_score_component_name() {
  return common_scripts\utility::ter_op(isDefined(level.team_score_component_name), level.team_score_component_name, CONST_DEFAULT_TEAM_COMPONENT_NAME);
}
set_team_score_component_name(team_score_component_name) {
  level.team_score_component_name = team_score_component_name;
}

COOP_CONST_MAX_BLOCKER_SCORE_DEPLOY_SUPPORT = 2000;
COOP_CONST_MAX_BLOCKER_SCORE_REVIVE_TEAMMATE = 1000;
COOP_CONST_MAX_BLOCKER_SCORE_DAMAGE_DONE = 2500;

init_blocker_hive_teamwork_score_component() {
  register_encounter_score_component(CONST_NAME_REF_TEAM_BLK, ::init_blocker_teamwork_score, ::reset_team_score_performance, ::reset_player_teamwork_score_performance, ::calculate_teamwork_score,
    CONST_UI_STRING_INDEX_TEAMWORK,
    CONST_NAME_REF_EOG_HIVE);
}

init_blocker_teamwork_score(score_component_struct) {
  score_component_struct.max_score_deploy = COOP_CONST_MAX_BLOCKER_SCORE_DEPLOY_SUPPORT;
  score_component_struct.max_score_revive = COOP_CONST_MAX_BLOCKER_SCORE_REVIVE_TEAMMATE;
  score_component_struct.max_score_damage = COOP_CONST_MAX_BLOCKER_SCORE_DAMAGE_DONE;

  reset_team_score_performance(score_component_struct);

  return score_component_struct;
}

COOP_CONST_MAX_SCORE_DAMAGE_TAKEN = 1500;
COOP_CONST_MAX_SCORE_ACCURACY = 1000;

SOLO_CONST_MAX_SCORE_DAMAGE_TAKEN = 2500;
SOLO_CONST_MAX_SCORE_ACCURACY = 1500;

CONST_PLAYER_DAMAGE_LIMIT = 500;

CONST_DEFAULT_PERSONAL_COMPONENT_NAME = "personal";

init_personal_score_component() {
  register_encounter_score_component(CONST_NAME_REF_PERSONAL, ::init_personal_score,
    undefined, ::reset_player_personal_score_performance, ::calculate_personal_skill_score,
    CONST_UI_STRING_INDEX_PERSONAL_SKILL,
    CONST_NAME_REF_EOG_HIVE);
}

init_personal_score(score_component_struct) {
  if(isPlayingSolo()) {
    score_component_struct.max_score_damage_taken = SOLO_CONST_MAX_SCORE_DAMAGE_TAKEN;
    score_component_struct.max_score_accuracy = SOLO_CONST_MAX_SCORE_ACCURACY;
  } else {
    score_component_struct.max_score_damage_taken = COOP_CONST_MAX_SCORE_DAMAGE_TAKEN;
    score_component_struct.max_score_accuracy = COOP_CONST_MAX_SCORE_ACCURACY;
  }

  return score_component_struct;
}

reset_player_personal_score_performance(player) {
  player.encounter_performance["damage_taken"] = 0;
  player.encounter_performance["shots_hit"] = 0;
  player.encounter_performance["shots_fired"] = 0;
}

calculate_personal_skill_score(player, score_component_struct) {
  damage_penalty = get_player_encounter_performance(player, "damage_taken") / CONST_PLAYER_DAMAGE_LIMIT;
  damage_score_percent_earned = max(0, 1 - damage_penalty);
  max_score_demage_taken = score_component_struct.max_score_damage_taken;
  damage_score_earned = max_score_demage_taken * damage_score_percent_earned;

  if(get_player_encounter_performance(player, "shots_fired") == 0)
    accuracy_ratio = 1.0;
  else
    accuracy_ratio = get_player_encounter_performance(player, "shots_hit") / get_player_encounter_performance(player, "shots_fired");

  accuracy_ratio = min(1.0, accuracy_ratio);
  max_score_accuracy = score_component_struct.max_score_accuracy;
  accuracy_score_earned = max_score_accuracy * accuracy_ratio;

  maps\mp\alien\_debug::debug_print_personal_skill_score(damage_score_earned, accuracy_score_earned);

  return int(damage_score_earned + accuracy_score_earned);
}

get_personal_score_component_name() {
  return common_scripts\utility::ter_op(isDefined(level.personal_score_component_name), level.personal_score_component_name, CONST_DEFAULT_PERSONAL_COMPONENT_NAME);
}
set_personal_score_component_name(personal_score_component_name) {
  level.personal_score_component_name = personal_score_component_name;
}

COOP_CONST_MAX_BLOCKER_SCORE_DAMAGE_TAKEN = 2500;
COOP_CONST_MAX_BLOCKER_SCORE_ACCURACY = 2000;

SOLO_CONST_MAX_BLOCKER_SCORE_DAMAGE_TAKEN = 5500;
SOLO_CONST_MAX_BLOCKER_SCORE_ACCURACY = 4500;

init_blocker_hive_personal_score_component() {
  register_encounter_score_component(CONST_NAME_REF_PERSONAL_BLK, ::init_blocker_personal_score,
    undefined, ::reset_player_personal_score_performance, ::calculate_personal_skill_score,
    CONST_UI_STRING_INDEX_PERSONAL_SKILL,
    CONST_NAME_REF_EOG_HIVE);
}

init_blocker_personal_score(score_component_struct) {
  if(isPlayingSolo()) {
    score_component_struct.max_score_damage_taken = SOLO_CONST_MAX_BLOCKER_SCORE_DAMAGE_TAKEN;
    score_component_struct.max_score_accuracy = SOLO_CONST_MAX_BLOCKER_SCORE_ACCURACY;
  } else {
    score_component_struct.max_score_damage_taken = COOP_CONST_MAX_BLOCKER_SCORE_DAMAGE_TAKEN;
    score_component_struct.max_score_accuracy = COOP_CONST_MAX_BLOCKER_SCORE_ACCURACY;
  }

  return score_component_struct;
}

CONST_TOTAL_ESCAPE_TIME_IN_MS = 240000;
CONST_MAX_ESCAPE_SCORE = 15000;
CONST_ESCAPE_BASE_BONUS = 15000;

init_escape_score_component() {
  register_encounter_score_component(CONST_NAME_REF_ESCAPE, ::init_escape_score,
    undefined,
    undefined, ::calculate_escape_score,
    CONST_UI_STRING_INDEX_ESCAPE,
    CONST_NAME_REF_EOG_ESCAPE);
}

init_escape_score(score_component_struct) {
  score_component_struct.team_encounter_performance["time_remain_ms"] = 0;
  score_component_struct.team_encounter_performance["escape_player_ratio"] = 0;

  return score_component_struct;
}

calculate_escape_score(player, score_component_struct) {
  time_left_as_total_time = get_team_encounter_performance(score_component_struct, "time_remain_ms") / CONST_TOTAL_ESCAPE_TIME_IN_MS;
  prestige_score_buff_scalar = 1 + (player maps\mp\alien\_prestige::get_num_nerf_selected() + 1) * PRESTIGE_RELIC_SCORE_BONUS;
  escape_time_score = int(CONST_ESCAPE_BASE_BONUS + CONST_MAX_ESCAPE_SCORE * time_left_as_total_time * get_team_encounter_performance(score_component_struct, "escape_player_ratio") * prestige_score_buff_scalar);

  return escape_time_score;
}

process_end_game_score_escaped(escape_time_remains, players_escaped) {
  escape_player_ratio = players_escaped.size / level.players.size;

  update_team_encounter_performance("escape", "time_remain_ms", escape_time_remains);
  update_team_encounter_performance("escape", "escape_player_ratio", escape_player_ratio);

  calculate_encounter_scores(players_escaped, [CONST_NAME_REF_ESCAPE]);
}

update_personal_encounter_performance(score_component_name, performance_type, amount) {
  if(!has_encounter_score_component(score_component_name)) {
    return;
  }
  if(!isPlayer(self)) {
    return;
  }
  self.encounter_performance = update_encounter_performance_internal(self.encounter_performance, performance_type, amount);
}

update_team_encounter_performance(score_component_name, performance_type, amount) {
  if(!has_encounter_score_component(score_component_name)) {
    return;
  }
  if(!isDefined(amount))
    amount = 1;

  level.encounter_score_components[score_component_name].team_encounter_performance[performance_type] += amount;
}

update_encounter_performance_internal(performance_list, performance_type, amount) {
  AssertEx(isDefined(performance_list), "Performance list is not defined");
  AssertEx(isDefined(performance_list[performance_type]), "Unknown performance type: " + performance_type);

  if(!isDefined(amount))
    amount = 1;

  performance_list[performance_type] += amount;

  return performance_list;
}

register_scoring_mode() {
  if(isPlayingSolo())
    SetOmnvar("ui_alien_is_solo", true);
  else
    SetOmnvar("ui_alien_is_solo", false);
}

get_team_encounter_performance(score_component_struct, performance_type) {
  return score_component_struct.team_encounter_performance[performance_type];
}

get_player_encounter_performance(player, performance_type) {
  return player.encounter_performance[performance_type];
}

has_encounter_score_component(score_component_name) {
  return has_score_component_internal(level.encounter_score_components, score_component_name);
}

has_eog_score_component(score_component_name) {
  return has_score_component_internal(level.eog_score_components, score_component_name);
}

has_score_component_internal(score_component_list, score_component_name) {
  if(is_scoring_disabled())
    return false;

  return isDefined(score_component_list[score_component_name]);
}

register_eog_score_component(name_ref, lua_string_index) {
  score_component = spawnStruct();

  score_component.lua_string_index = lua_string_index;

  level.eog_score_components[name_ref] = score_component;
}

register_encounter_score_component(name_ref, init_func, reset_team_performance_func, reset_player_performance_func, calculate_func, lua_string_index, end_game_score_component_ref, player_init_func) {
  AssertEx(has_eog_score_component(end_game_score_component_ref), "'" + end_game_score_component_ref + "' eog game component has not been registered.");

  score_component = spawnStruct();

  score_component = [[init_func]](score_component);
  score_component.reset_team_performance_func = reset_team_performance_func;
  score_component.reset_player_performance_func = reset_player_performance_func;
  score_component.calculate_func = calculate_func;
  score_component.lua_string_index = lua_string_index;
  score_component.end_game_score_component_ref = end_game_score_component_ref;

  if(isDefined(player_init_func))
    score_component.player_init_func = player_init_func;

  level.encounter_score_components[name_ref] = score_component;
}

update_performance_alien_damage(eAttacker, iDamage, sMeansOfDeath) {
  if(!isDefined(eAttacker)) {
    return;
  }
  if(isDefined(eAttacker.classname) && eAttacker.classname == "script_vehicle") {
    return;
  }
  if(sMeansOfDeath == "MOD_TRIGGER_HURT") {
    return;
  }
  update_team_encounter_performance(get_team_score_component_name(), "damage_done_on_alien", iDamage);

  personal_score_component_name = get_personal_score_component_name();

  if(isPlayer(eAttacker))
    eAttacker update_personal_encounter_performance(personal_score_component_name, "damage_done_on_alien", iDamage);
  else if(isDefined(eAttacker.owner))
    eAttacker.owner update_personal_encounter_performance(personal_score_component_name, "damage_done_on_alien", iDamage);
}

give_attacker_kill_rewards(attacker, sHitloc) {
  if(self.agentteam == "allies") {
    return;
  }
  if(self get_alien_type() == "elite" || self get_alien_type() == "mammoth") {
    reward_point = get_reward_point_for_kill();
    foreach(player in level.players) {
      self giveKillReward(player, reward_point, "large");
    }
    return;
  }

  if(isDefined(self.attacker_damage)) {
    MIN_ASSIST_BONUS_DAMAGE_RATIO = 0.1;
    min_assist_damage = self.max_health * MIN_ASSIST_BONUS_DAMAGE_RATIO;
    assist_bonus_amount = self getAssistBonusAmount();
    foreach(attacker_struct in self.attacker_damage) {
      if(attacker_struct.player == attacker || (isDefined(attacker.owner) && attacker_struct.player == attacker.owner)) {
        continue;
      }
      if(attacker_struct.damage >= min_assist_damage) {
        if(isDefined(attacker_struct.player) && attacker_struct.player != attacker) {
          assertex(isplayer(attacker_struct.player), "Tried to give non-player rewards");

          attacker_struct.player maps\mp\alien\_persistence::eog_player_update_stat("assists", 1);

          self giveKillReward(attacker_struct.player, assist_bonus_amount);
        }
      }
    }
  }

  if(!isDefined(attacker)) {
    return;
  }
  if(!isPlayer(attacker) && (!isDefined(attacker.owner) || !isPlayer(attacker.owner))) {
    return;
  }
  isEquipmentKill = false;
  if(isDefined(attacker.owner)) {
    attacker = attacker.owner;
    isEquipmentKill = true;
  }
  reward_point = get_reward_point_for_kill();
  if(isDefined(sHitloc) && sHitloc == "soft" && !isEquipmentKill)
    reward_point = int(reward_point * 1.5);
  giveKillReward(attacker, reward_point, "large", sHitloc);
}

giveKillReward(attacker, amount, size, sHitloc) {
  currency_reward = amount * level.cycle_reward_scalar;
  attacker maps\mp\alien\_persistence::give_player_currency(currency_reward, size, sHitloc);

  if(isDefined(level.alien_xp)) {
    attacker maps\mp\alien\_persistence::give_player_xp(int(currency_reward));
  }

  if(common_scripts\utility::flag_exist("cortex_started") && common_scripts\utility::flag("cortex_started")) {
    if(isDefined(level.add_cortex_charge_func)) {
      [
        [level.add_cortex_charge_func]
      ](amount);
    }
  }
}

giveAssistBonus(attacker, damage) {
  if(!isDefined(attacker)) {
    return;
  }
  if(!isPlayer(attacker) && (!isDefined(attacker.owner) || !isPlayer(attacker.owner))) {
    return;
  }
  if(isDefined(attacker.owner))
    attacker = attacker.owner;

  if(!isDefined(self.attacker_damage)) {
    self.attacker_damage = [];
  }

  foreach(attacker_struct in self.attacker_damage) {
    if(attacker_struct.player == attacker) {
      attacker_struct.damage += damage;
      return;
    }
  }

  new_attacker_struct = spawnStruct();
  new_attacker_struct.player = attacker;
  new_attacker_struct.damage = damage;
  self.attacker_damage[self.attacker_damage.size] = new_attacker_struct;
}

getAssistBonusAmount() {
  return level.alien_types[self get_alien_type()].attributes["reward"] * 0.5;
}

get_reward_point_for_kill() {
  return level.alien_types[self get_alien_type()].attributes["reward"];
}

round_up_to_nearest(cash_amount, base) {
  temp_value = cash_amount / base;
  temp_value = ceil(temp_value);
  return int(temp_value * base);
}

is_scoring_disabled() {
  if(alien_mode_has("nogame"))
    return true;

  if(maps\mp\alien\_debug::spawn_test_enable())
    return true;

  if(is_chaos_mode())
    return true;

  return false;
}

calculate_under_max_score(performance, max_limit, max_score) {
  under_max_limit = clamp(max_limit - performance, 0, max_limit);
  return int(under_max_limit / max_limit * max_score);
}