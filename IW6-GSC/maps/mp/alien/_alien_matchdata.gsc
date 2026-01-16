/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_alien_matchdata.gsc
**********************************************/

MAX_NUM_ALIEN_HIVES = 25;
MAX_NUM_PERKS_BOUGHT = 50;
MAX_NUM_UPGRADES = 32;

CONST_MAX_BYTE = 127;
CONST_MAX_SHORT = 32767;
CONST_MAX_INT = 2147483647;

start_game_type() {
  init();

  set_is_private_match();

  override_gametype();

  register_upgrade_types();

  level thread wait_set_initial_player_count();
}

set_is_private_match() {
  setMatchData("aliensIsPrivateMatch", getDvarInt("xblive_privatematch"));
}

override_gametype() {
  setMatchData("gametype", get_alien_game_type());
}

get_alien_game_type() {
  CONST_CHAOS_MODE = "aliens ch";
  CONST_HARDCORE_MODE = "aliens hc";
  CONST_CASUAL_MODE = "aliens ca";
  CONST_NORMAL_MODE = "aliens";

  if(maps\mp\alien\_utility::is_chaos_mode())
    return CONST_CHAOS_MODE;

  if(maps\mp\alien\_utility::is_hardcore_mode())
    return CONST_HARDCORE_MODE;
  else if(maps\mp\alien\_utility::is_casual_mode())
    return CONST_CASUAL_MODE;
  else
    return CONST_NORMAL_MODE;
}

init() {
  alien_matchData = spawnStruct();

  single_value_stats = [];
  single_value_stats["aliensTotalDrillDamage"] = get_single_value_struct(0, "short");
  alien_matchData.single_value_stats = single_value_stats;

  challenge_results = [];
  alien_matchData.challenge_results = challenge_results;

  level.alien_matchData = alien_matchData;
}

wait_set_initial_player_count() {
  level endon("gameEnded");
  level waittill("prematch_over");
  setMatchData("aliensInitialPlayerCount", validate_byte(level.players.size));
}

on_player_connect() {
  player_init();

  set_max_player_count();
  set_split_screen();
  set_alien_loadout();
  set_join_in_progress();
  set_relics_selected();
  set_upgrades_purchased();
  set_upgrades_enabled();
}

player_init() {
  alien_matchData = spawnStruct();

  single_value_stats = [];
  single_value_stats["aliensCashSpentOnWeapon"] = get_single_value_struct(0, "int");
  single_value_stats["aliensCashSpentOnAbility"] = get_single_value_struct(0, "int");
  single_value_stats["aliensCashSpentOnTrap"] = get_single_value_struct(0, "int");
  alien_matchData.single_value_stats = single_value_stats;

  perk_upgraded = [];
  alien_matchData.perk_upgraded = perk_upgraded;

  lastStand_record = [];
  lastStand_record["aliensTimesDowned"] = [];
  lastStand_record["aliensTimesRevived"] = [];
  lastStand_record["aliensTimesBledOut"] = [];
  alien_matchData.lastStand_record = lastStand_record;

  self.alien_matchData = alien_matchData;
}

set_max_player_count() {
  if(!isDefined(level.max_player_count))
    level.max_player_count = 0;

  if((level.players.size + 1) > level.max_player_count) {
    level.max_player_count++;
    setMatchData("aliensMaxPlayerCount", validate_byte(level.max_player_count));
  }
}

set_split_screen() {
  setMatchData("players", self.clientid, "isSplitscreen", self isSplitscreenPlayer());
}

set_join_in_progress() {
  if(prematch_over())
    setMatchData("players", self.clientid, "aliensJIP", true);
}

prematch_over() {
  if(isDefined(level.startTime))
    return true;

  return false;
}

set_alien_loadout() {
  setMatchData("players", self.clientid, "aliensLoadOut", 0, maps\mp\alien\_persistence::get_selected_perk_0());
  setMatchData("players", self.clientid, "aliensLoadOut", 1, maps\mp\alien\_persistence::get_selected_perk_1());
  setMatchData("players", self.clientid, "aliensLoadOut", 2, maps\mp\alien\_persistence::get_selected_dpad_up());
  setMatchData("players", self.clientid, "aliensLoadOut", 3, maps\mp\alien\_persistence::get_selected_dpad_down());
  setMatchData("players", self.clientid, "aliensLoadOut", 4, maps\mp\alien\_persistence::get_selected_dpad_left());
  setMatchData("players", self.clientid, "aliensLoadOut", 5, maps\mp\alien\_persistence::get_selected_dpad_right());
}

set_relics_selected() {
  num_enabled_nerfs = 0;

  foreach(nerf in level.nerf_list) {
    if(self alienscheckisrelicenabled(nerf)) {
      setMatchData("players", self.clientid, "aliensRelics", num_enabled_nerfs, nerf);
      num_enabled_nerfs++;
    }
  }

  for(i = num_enabled_nerfs; i < level.nerf_list.size; i++)
    setMatchData("players", self.clientid, "aliensRelics", i, "none");
}

set_upgrades_purchased() {
  num_upgrade_purchased = 0;

  foreach(upgrade_ref in level.alien_upgrades) {
    if(self maps\mp\alien\_persistence::is_upgrade_purchased(upgrade_ref)) {
      setMatchData("players", self.clientid, "aliensUpgradePurchased", num_upgrade_purchased, upgrade_ref);
      num_upgrade_purchased++;
    }
  }

  for(index = num_upgrade_purchased; index < MAX_NUM_UPGRADES; index++)
    setMatchData("players", self.clientid, "aliensUpgradePurchased", index, "none");
}

set_upgrades_enabled() {
  num_upgrade_enabled = 0;

  foreach(upgrade_ref in level.alien_upgrades) {
    if(self maps\mp\alien\_persistence::is_upgrade_enabled(upgrade_ref)) {
      setMatchData("players", self.clientid, "aliensUpgradeEnabled", num_upgrade_enabled, upgrade_ref);
      num_upgrade_enabled++;
    }
  }

  for(index = num_upgrade_enabled; index < MAX_NUM_UPGRADES; index++)
    setMatchData("players", self.clientid, "aliensUpgradeEnabled", index, "none");
}

inc_drill_heli_damages(damage_amt) {
  level.alien_matchData.single_value_stats["aliensTotalDrillDamage"].value += damage_amt;
}

set_escape_time_remaining(escape_time_remains) {
  setMatchData("aliensEscapeTimeRemaining", validate_int(escape_time_remains));
}

update_challenges_status(challenge_name, result) {
  if(level.alien_matchData.challenge_results.size > MAX_NUM_ALIEN_HIVES) {
    return;
  }
  challenge_status = spawnStruct();
  challenge_status.challenge_name = challenge_name;
  challenge_status.result = result;

  level.alien_matchData.challenge_results[level.alien_matchData.challenge_results.size] = challenge_status;
}

record_perk_upgrade(perk_name) {
  if(self.alien_matchData.perk_upgraded.size > MAX_NUM_PERKS_BOUGHT) {
    return;
  }
  self.alien_matchData.perk_upgraded[self.alien_matchData.perk_upgraded.size] = perk_name;
}

inc_downed_counts() {
  inc_lastStand_record("aliensTimesDowned");
}

inc_revived_counts() {
  inc_lastStand_record("aliensTimesRevived");
}

inc_bleedout_counts() {
  inc_lastStand_record("aliensTimesBledOut");
}

inc_lastStand_record(field_name) {
  if(!isDefined(self.alien_matchData.lastStand_record[field_name][level.num_hive_destroyed]))
    self.alien_matchData.lastStand_record[field_name][level.num_hive_destroyed] = 0;

  self.alien_matchData.lastStand_record[field_name][level.num_hive_destroyed]++;
}

update_spending_type(amount_spent, spending_type) {
  switch (spending_type) {
    case "weapon":
      self.alien_matchData.single_value_stats["aliensCashSpentOnWeapon"].value += amount_spent;
      break;

    case "ability":
      self.alien_matchData.single_value_stats["aliensCashSpentOnAbility"].value += amount_spent;
      break;

    case "trap":
      self.alien_matchData.single_value_stats["aliensCashSpentOnTrap"].value += amount_spent;
      break;

    default:
      AssertMsg("Spending type: " + spending_type + " is not recognized.");
      break;
  }
}

EndGame(end_condition, play_time) {
  set_game_data(end_condition, play_time);

  foreach(player in level.players)
  player set_player_game_data();

  sendMatchData();
}

set_game_data(end_condition, play_time) {
  CONST_CHALLENGES_COMPLETED = "aliensChallengesCompleted";

  setMatchData("aliensFinalPlayerCount", validate_byte(level.players.size));
  setMatchData("aliensHivesDestroyed", validate_byte(level.num_hive_destroyed));
  setMatchData("aliensGameOverCondition", end_condition);
  setMatchData("aliensTotalTimeElapsed", validate_int(play_time));

  alien_matchData = level.alien_matchData;

  foreach(matchData_field, value_struct in alien_matchData.single_value_stats) {
    value = validate_value(value_struct.value, value_struct.value_type);
    setMatchData(matchData_field, value);
  }

  foreach(index, challenge_status in alien_matchData.challenge_results) {
    setMatchData(CONST_CHALLENGES_COMPLETED, index, "challengeId", challenge_status.challenge_name);
    setMatchData(CONST_CHALLENGES_COMPLETED, index, "success", challenge_status.result);
  }
}

set_player_game_data() {
  copy_from_playerData();
  set_perk_upgraded();
  set_lastStand_stats();
  set_single_value_stats();
}

copy_from_playerData() {
  setMatchData("players", self.clientid, "aliensFinalScore", validate_int(self GetCoopPlayerData("alienSession", "score")));
  setMatchData("players", self.clientid, "aliensDrillRepairs", validate_byte(self GetCoopPlayerData("alienSession", "repairs")));
  setMatchData("players", self.clientid, "aliensXpEarned", validate_int(self GetCoopPlayerData("alienSession", "experience")));
}

set_perk_upgraded() {
  foreach(index, perk_name in self.alien_matchData.perk_upgraded)
  setMatchData("players", self.clientid, "aliensPerksBought", index, perk_name);
}

set_lastStand_stats() {
  foreach(stat_type, info_array in self.alien_matchData.lastStand_record) {
    foreach(hive_index, counts in info_array)
    setMatchData("players", self.clientid, stat_type, hive_index, validate_byte(counts));
  }
}

set_single_value_stats() {
  foreach(field_name, value_struct in self.alien_matchData.single_value_stats) {
    value = validate_value(value_struct.value, value_struct.value_type);
    setMatchData("players", self.clientid, field_name, value);
  }
}

validate_value(value, data_type) {
  switch (data_type) {
    case "byte":
      return validate_byte(value);

    case "short":
      return validate_short(value);

    case "int":
      return validate_int(value);

    default:
      AssertMsg("Value type: " + data_type + " is not supported");
  }
}

validate_byte(value) {
  return int(min(value, CONST_MAX_BYTE));
}

validate_short(value) {
  return int(min(value, CONST_MAX_SHORT));
}

validate_int(value) {
  return int(min(value, CONST_MAX_INT));
}

get_single_value_struct(initial_value, value_type) {
  value_struct = spawnStruct();
  value_struct.value = initial_value;
  value_struct.value_type = value_type;

  return value_struct;
}

register_upgrade_types() {
  UPGRADE_TABLE = "mp/alien/alien_purchasable_items.csv";
  TABLE_INDEX_COLUMN = 0;
  UPGRADE_REF_COLUMN = 1;

  upgrades = [];
  for(index = 0; index < MAX_NUM_UPGRADES; index++) {
    upgrade_ref = tablelookup(UPGRADE_TABLE, TABLE_INDEX_COLUMN, index, UPGRADE_REF_COLUMN);
    if(maps\mp\agents\alien\_alien_agents::is_empty_string(upgrade_ref)) {
      break;
    }

    upgrades[upgrades.size] = upgrade_ref;
  }

  level.alien_upgrades = upgrades;
}