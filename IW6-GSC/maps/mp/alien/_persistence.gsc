/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_persistence.gsc
******************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\agents\_agent_utility;
#include maps\mp\alien\_utility;
#include maps\mp\alien\_perk_utility;

CURRENCY_START = 500;
CURRENCY_UPGRADE_START = 1500;
CURRENCY_MAX = 6000;
POINTS_MAX = 255;
MAX_PRESTIGE = 25;
FREE_SKILL_POINTS = 1;
CHAOS_START_SKILL_POINTS = 50;

set_game_state(state) {
  allowed_states = ["pregame", "prehive", "progressing", "escaping", "ended"];
  state_allowed = array_contains(allowed_states, state);

  assertex(state_allowed, "State: " + state + " is not allowed");

  self SetCoopPlayerData("alienSession", "game_state", state);
}

get_selected_perk_0() {
  if(is_chaos_mode()) {
    return "perk_none";
  }
  return self getcoopplayerdata("alienPlayerLoadout", "perks", 0);
}
get_selected_perk_0_secondary() {
  secondaryClass = "perk_none";

  if(self is_upgrade_enabled("multi_class") && !is_chaos_mode()) {
    secondaryClassIndex = self GetCoopPlayerDataReservedInt("secondary_class");
    keys = getArrayKeys(level.alien_perks["perk_0"]);
    foreach(key in keys) {
      if(level.alien_perks["perk_0"][key].baseIdx == secondaryClassIndex) {
        secondaryClass = key;
      }
    }
  }
  return secondaryClass;
}
get_selected_perk_1() {
  return self getcoopplayerdata("alienPlayerLoadout", "perks", 1);
}

get_perk_0_level() {
  return self getcoopplayerdata("alienSession", "perk_0_level");
}
get_perk_1_level() {
  return self getcoopplayerdata("alienSession", "perk_1_level");
}

set_perk_0_level(upgrade_level) {
  self setcoopplayerdata("alienSession", "perk_0_level", upgrade_level);
}
set_perk_1_level(upgrade_level) {
  self setcoopplayerdata("alienSession", "perk_1_level", upgrade_level);
}

set_perk(perk_ref) {
  self[[level.alien_perk_callbacks[perk_ref].Set]]();
}
unset_perk(perk_ref) {
  self[[level.alien_perk_callbacks[perk_ref].unSet]]();
}

init_perk_level() {
  self set_perk_0_level(0);
  self set_perk_1_level(0);
}

give_initial_perks() {
  self set_perk(self get_selected_perk_0());
  self set_perk(self get_selected_perk_1());

  if(self is_upgrade_enabled("multi_class")) {
    self set_perk(self get_selected_perk_0_secondary());
  }
}

get_selected_dpad_up() {
  return self getcoopplayerdata("alienPlayerLoadout", "munition");
}
get_selected_dpad_down() {
  return self getcoopplayerdata("alienPlayerLoadout", "support");
}

get_selected_dpad_left() {
  defense = self getcoopplayerdata("alienPlayerLoadout", "defense");
  if(defense == "dpad_placeholder_def_1" && maps\mp\alien\_utility::is_chaos_mode()) {
    return "dpad_minigun_turret";
  }
  else {
    return defense;
  }
}

get_selected_dpad_right() {
  offense = self getcoopplayerdata("alienPlayerLoadout", "offense");
  if(offense == "dpad_placeholder_off_1" && maps\mp\alien\_utility::is_chaos_mode()) {
    return "dpad_ims";
  }
  else {
    return offense;
  }
}

get_dpad_up_level() {
  return self getcoopplayerdata("alienSession", "munition_level");
}
get_dpad_down_level() {
  return self getcoopplayerdata("alienSession", "support_level");
}
get_dpad_left_level() {
  return self getcoopplayerdata("alienSession", "defense_level");
}
get_dpad_right_level() {
  return self getcoopplayerdata("alienSession", "offense_level");
}

get_upgrade_level(type) {
  return self getcoopplayerdata("alienSession", type + "_level");
}
set_upgrade_level(type, upgrade_level) {
  self setcoopplayerdata("alienSession", type + "_level", upgrade_level);

  loadout_ref = "LoadoutPlayer" + (self GetEntityNumber());
  setcoopplayerdata_for_everyone(loadout_ref, type + "_level", upgrade_level);
}

set_dpad_up_level(upgrade_level) {
  self setcoopplayerdata("alienSession", "munition_level", upgrade_level);
}
set_dpad_down_level(upgrade_level) {
  self setcoopplayerdata("alienSession", "support_level", upgrade_level);
}
set_dpad_left_level(upgrade_level) {
  self setcoopplayerdata("alienSession", "defense_level", upgrade_level);
}
set_dpad_right_level(upgrade_level) {
  self setcoopplayerdata("alienSession", "offense_level", upgrade_level);
}

init_combat_resource_level() {
  self set_dpad_up_level(0);
  self set_dpad_down_level(0);
  self set_dpad_left_level(0);
  self set_dpad_right_level(0);
}

get_player_currency() {
  return self getcoopplayerdata("alienSession", "currency");
}
get_player_max_currency() {
  return self.maxCurrency;
}

wait_to_set_player_currency(amount) {
  self endon("disconnect");
  level endon("game_ended");

  wait(0.5);
  if(self is_upgrade_enabled("more_cash_upgrade")) {
    set_player_currency(CURRENCY_UPGRADE_START);
  }
  else {
    set_player_currency(amount);
  }
}

set_player_currency(amount) {
  self setcoopplayerdata("alienSession", "currency", int(amount));

  self eog_player_update_stat("currency", int(amount), true);
}

get_player_points() {
  return self getcoopplayerdata("alienSession", "skill_points");
}
set_player_points(amount) {
  self setcoopplayerdata("alienSession", "skill_points", int(amount));
}

set_player_max_currency(amount) {
  amount = int(amount);
  self SetClientOmnvar("ui_alien_max_currency", amount);
  self.maxCurrency = amount;
}

give_player_currency(amount, font_size, sHitloc, skip_prestige_scalar) {
  assert(amount >= 0);

  if(!is_true(skip_prestige_scalar)) {
    amount = int(amount * self maps\mp\alien\_prestige::prestige_getMoneyEarnedScalar());
    amount = maps\mp\alien\_gamescore::round_up_to_nearest(amount, 5);
  }

  if(is_chaos_mode() && is_true(self.chaosinthemoney)) {
    amount = int(amount * 1.5);
    amount = maps\mp\alien\_gamescore::round_up_to_nearest(amount, 5);
  }

  current_amount = self get_player_currency();
  max_amount = self get_player_max_currency();
  new_amount = current_amount + amount;
  new_amount = min(new_amount, max_amount);

  if(!isDefined(self.total_currency_earned)) {
    self.total_currency_earned = amount;
  }
  else {
    self.total_currency_earned += (new_amount - current_amount);
  }

  self eog_player_update_stat("currencytotal", int(self.total_currency_earned), true);

  self notify("loot_pickup");

  self set_player_currency(new_amount);

  MAX_CASH_COOL_DOWN_TIME = 30000;
  current_time = getTime();

  if(current_amount == max_amount) {
    self setclientomnvar("ui_alien_cash_overflow", true);
  }

  if(new_amount >= max_amount) {
    if(!isDefined(self.next_maxmoney_hint_time)) {
      self.next_maxmoney_hint_time = current_time + MAX_CASH_COOL_DOWN_TIME;
    } else if(current_time < self.next_maxmoney_hint_time) {
      return;
    }
    if(!level.gameEnded) {
      self maps\mp\_utility::setLowerMessage("maxmoney", &"ALIEN_COLLECTIBLES_MONEY_MAX", 4);
      self.next_maxmoney_hint_time = current_time + MAX_CASH_COOL_DOWN_TIME;
    }
  }
}

take_player_currency(amount, dont_update_challenge, spending_type, weapon_ref) {
  assert(amount >= 0);
  current_amount = self get_player_currency();
  new_amount = max(0, current_amount - amount);
  amount_spent = int(current_amount - new_amount);

  maps\mp\alien\_chaos::update_spending_currency_event(self, spending_type, weapon_ref);

  self notify("loot_removed");

  self set_player_currency(new_amount);

  if(isDefined(spending_type)) {
    maps\mp\alien\_alien_matchdata::update_spending_type(amount_spent, spending_type);
  }

  if(isDefined(dont_update_challenge) && dont_update_challenge) {
    return;
  }
  self eog_player_update_stat("currencyspent", amount_spent);

  if(amount_spent < 1) {
    return;
  }
  maps\mp\alien\_challenge::update_challenge("spend_10k", amount);
  maps\mp\alien\_challenge::update_challenge("spend_20k", amount);
  maps\mp\alien\_challenge::update_challenge("spend_no_money");
}

take_all_currency() {
  self set_player_currency(0);
}

player_has_enough_currency(amount) {
  assert(amount >= 0);
  currency = self get_player_currency();
  return (currency >= amount);
}

try_take_player_currency(amount) {
  if(self player_has_enough_currency(amount)) {
    self take_player_currency(amount);
    return true;
  } else {
    return false;
  }
}

give_player_points(amount) {
  assert(amount >= 0);
  current_amount = self get_player_points();
  new_amount = current_amount + amount;
  new_amount = min(new_amount, POINTS_MAX);

  self set_player_points(new_amount);
}

take_player_points(amount) {
  assert(amount >= 0);
  current_amount = self get_player_points();
  new_amount = max(0, current_amount - amount);

  self notify("points_removed");

  self set_player_points(new_amount);
}

player_has_enough_points(amount) {
  assert(amount >= 0);
  points = self get_player_points();
  return (points >= amount);
}

try_take_player_points(amount) {
  if(self player_has_enough_points(amount)) {
    self take_player_points(amount);
    return true;
  } else {
    return false;
  }
}

is_unlocked(item_ref) {
  item_type = undefined;
  item_type = strtok(item_ref, "_")[0];

  item_unlock_rank = level.combat_resource[item_ref].unlock;
  player_rank = self get_player_rank();

  return player_rank >= item_unlock_rank;
}

player_persistence_init() {
  level.alien_xp = true;

  self init_combat_resource_level();
  self init_perk_level();

  self init_each_perk();
  self give_initial_perks();

  starting_currency = get_starting_currency();
  self thread wait_to_set_player_currency(starting_currency);
  self set_player_max_currency(CURRENCY_MAX * maps\mp\alien\_prestige::prestige_getWalletSizeScalar());

  starting_skill_point = get_starting_skill_point();
  self set_player_points(starting_skill_point);
  self set_player_session_xp(0);
  self set_player_session_rankup(0);

  self SetRank(self get_player_rank(), self get_player_prestige());

  self session_stats_init();

  num_nerf_selected = maps\mp\alien\_prestige::get_num_nerf_selected();
  self LB_player_update_stat("prestigenerfs", num_nerf_selected, true);

  self thread update_loadout_for_everyone();
}

get_starting_currency() {
  if(isDefined(level.debug_starting_currency)) {
    return level.debug_starting_currency;
  }

  return CURRENCY_START;
}

get_starting_skill_point() {
  if(isDefined(level.debug_starting_skill_point)) {
    return level.debug_starting_skill_point;
  }

  if(is_chaos_mode()) {
    return CHAOS_START_SKILL_POINTS;
  }

  if(self is_upgrade_enabled("free_skill_points_upgrade")) {
    return FREE_SKILL_POINTS;
  }
  else {
    return 0;
  }
}

update_loadout_for_everyone() {
  level notify("updating_player_loadout_data");
  level endon("updating_player_loadout_data");

  if(!isDefined(level.players) || level.players.size == 0) {
    wait 0.5;
  }

  wait 1;

  foreach(p in level.players) {
    loadout_ref = "LoadoutPlayer" + (p GetEntityNumber());

    perk_0 = p get_selected_perk_0();
    perk_1 = p get_selected_perk_1();
    dpad_up = p get_selected_dpad_up();
    dpad_down = p get_selected_dpad_down();
    dpad_left = p get_selected_dpad_left();
    dpad_right = p get_selected_dpad_right();

    perk_0_level = p get_perk_0_level();
    perk_1_level = p get_perk_1_level();
    dpad_up_level = p get_dpad_up_level();
    dpad_down_level = p get_dpad_down_level();
    dpad_left_level = p get_dpad_left_level();
    dpad_right_level = p get_dpad_right_level();

    foreach(player in level.players) {
      player setcoopplayerdata(loadout_ref, "perks", 0, perk_0);
      player setcoopplayerdata(loadout_ref, "perks", 1, perk_1);
      player setcoopplayerdata(loadout_ref, "munition", dpad_up);
      player setcoopplayerdata(loadout_ref, "support", dpad_down);
      player setcoopplayerdata(loadout_ref, "defense", dpad_left);
      player setcoopplayerdata(loadout_ref, "offense", dpad_right);
      player setcoopplayerdata(loadout_ref, "perk_0_level", perk_0_level);
      player setcoopplayerdata(loadout_ref, "perk_1_level", perk_1_level);
      player setcoopplayerdata(loadout_ref, "munition_level", dpad_up_level);
      player setcoopplayerdata(loadout_ref, "support_level", dpad_down_level);
      player setcoopplayerdata(loadout_ref, "defense_level", dpad_left_level);
      player setcoopplayerdata(loadout_ref, "offense_level", dpad_right_level);
    }

    if(!isDefined(p.bbprint_loadout)) {
      p.bbprint_loadout = true;

      playername = "";
      if(isDefined(self.name)) {
        playername = self.name;
      }

      playerrank = self get_player_rank();
      playerxp = self get_player_xp();
      playerprestige = self get_player_prestige();
      playerescaped = self get_player_escaped();
      connecttime = gettime();

      cyclenum = 0;
      if(isDefined(level.current_cycle_num)) {
        cyclenum = level.current_cycle_num;
      }

      if(GetDvarInt("alien_bbprint_debug") > 0) {
        IPrintLnBold("^8bbprint: alienplayerloadout (1/2)\n" +
          " playername=" + playername +
          " playerrank=" + playerrank +
          " playerxp=" + playerxp +
          " playerprestige=" + playerprestige +
          " playerescaped=" + playerescaped +
          " connecttime=" + connecttime +
          " cyclenum=" + cyclenum);

        IPrintLnBold("^8bbprint: alienplayerloadout (2/2)\n" +
          " perk0=" + perk_0 +
          " perk1=" + perk_1 +
          " dpadup=" + dpad_up +
          " dpaddown=" + dpad_down +
          " dpadleft=" + dpad_left +
          " dpadright=" + dpad_right);
      }

      bbprint("alienplayerloadout",
        "playername %s playerrank %i playerxp %i playerprestige %i playerescaped %i connecttime %i cyclenum %i perk0 %s perk1 %s dpadup %s dpaddown %s dpadleft %s dpadright %s ",
        playername,
        playerrank,
        playerxp,
        playerprestige,
        playerescaped,
        connecttime,
        cyclenum,
        perk_0,
        perk_1,
        dpad_up,
        dpad_down,
        dpad_left,
        dpad_right);
    }
  }
}

setcoopplayerdata_for_everyone(param0, param1, param2, param3, param4) {
  assertex(level.players.size > 0, "setting player data when level.players array is not yet populated");

  foreach(player in level.players) {
    if(isDefined(param0) && isDefined(param1) && isDefined(param2) && isDefined(param3) && isDefined(param4)) {
      player setcoopplayerdata(param0, param1, param2, param3, param4);
      continue;
    }

    if(isDefined(param0) && isDefined(param1) && isDefined(param2) && isDefined(param3) && !isDefined(param4)) {
      player setcoopplayerdata(param0, param1, param2, param3);
      continue;
    }

    if(isDefined(param0) && isDefined(param1) && isDefined(param2) && !isDefined(param3) && !isDefined(param4)) {
      player setcoopplayerdata(param0, param1, param2);
      continue;
    }

    if(isDefined(param0) && isDefined(param1) && !isDefined(param2) && !isDefined(param3) && !isDefined(param4)) {
      player setcoopplayerdata(param0, param1);
      continue;
    }
  }
}

get_token_bonus_flag(bonusNum) {
  flagNum = 4;
  if(bonusNum < 28) {
    flagNum += bonusNum;
  }

  return flagNum;
}

is_valid_bonus_flag(flag) {
  return (flag >= 4 && flag < 32);
}

wait_then_try_give_one_shot_token_bonus(bonusFlag, numTokens) {
  self endon("disconnect");
  level endon("game_ended");

  if(!is_valid_bonus_flag(bonusFlag)) {
    return;
  }
  level waittill("regular_hive_destroyed");

  try_give_one_shot_token_bonus(bonusFlag, numTokens);
}

try_give_one_shot_token_bonus(bonusFlag, numTokens) {
  if(!is_using_extinction_tokens()) {
    return;
  }
  if(!level.onlineGame) {
    return;
  }
  if(!is_valid_bonus_flag(bonusFlag)) {
    return;
  }
  eggstra_award_flags = self GetCoopPlayerDataReservedInt("eggstra_award_flags");
  value = (eggstra_award_flags >> bonusFlag) & 1;

  if(value == 1) {
    return;
  }
  eggstra_award_flags |= (1 << bonusFlag);
  self SetCoopPlayerDataReservedInt("eggstra_award_flags", eggstra_award_flags);

  give_player_tokens(numTokens, true);
}

is_using_extinction_tokens() {
  if(GetDvarInt("extinction_tokens_enabled") > 0) {
    return true;
  }

  return false;
}

give_player_tokens(numTokens, showSplash) {
  if(!is_using_extinction_tokens()) {
    return;
  }

  if(is_true(showSplash)) {
    self setclientomnvar("ui_alien_award_token", numTokens);
  }

  currTokens = self GetCoopPlayerDataReservedInt("extinction_tokens");
  self SetCoopPlayerDataReservedInt("extinction_tokens", currTokens + numTokens);
  self give_player_session_tokens(numTokens);
}

try_award_bonus_pool_token() {
  if(!is_using_extinction_tokens()) {
    return;
  }
  if(!level.onlineGame) {
    return;
  }
  if(isDefined(self.pers["hasEarnedBonusToken"])) {
    return;
  }
  self.pers["hasEarnedBonusToken"] = true;

  numInBonusPool = self GetCoopPlayerDataReservedInt("bonus_pool_size");
  if(numInBonusPool > 0) {
    self SetCoopPlayerDataReservedInt("bonus_pool_size", numInBonusPool - 1);
    give_player_tokens(1, true);
  }
}

award_rank_up_tokens(oldRank) {
  prestigeLevel = self get_player_prestige();
  if(oldRank < level.alien_ranks.size && prestigeLevel == 0) {
    numAwarded = level.alien_ranks[oldRank].tokenReward;
    if(numAwarded > 0) {
      give_player_tokens(numAwarded, true);
    }
  }
}

award_completion_tokens() {
  if(is_casual_mode()) {
    return;
  }
  numAwarded = get_scaled_xp(5);

  if(is_hardcore_mode()) {
    numAwarded = numAwarded + 3;

    if(getDvar("alien_debug_eog") == "1") {
      iprintln("Hardcore Bonus Token Awarded!");
    }

  }

  if(level.all_challenge_completed) {
    numAwarded = numAwarded + 4;
  }

  num_active_relics = self maps\mp\alien\_prestige::get_num_nerf_selected();
  if(num_active_relics > 0 && !is_true(self.pers["hotjoined"])) {
    if(num_active_relics == 1) {
      numAwarded = numAwarded + 1;
    }
    else if(num_active_relics == 2) {
      numAwarded = numAwarded + 2;
    }
    else if(num_active_relics >= 3) {
      numAwarded = numAwarded + 3;
    }

    if(getDvar("alien_debug_eog") == "1") {
      iprintln("Active Relics Bonus Token Awarded!");
    }

  }

  if(1 < self get_player_escaped()) {
    foreach(player in level.players) {
      if(player != self && 1 == player get_player_escaped()) {
        numAwarded++;

        if(getDvar("alien_debug_eog") == "1") {
          iprintln("New Player Assist Bonus Token Awarded!");
        }

      }
    }
  }

  give_player_tokens(numAwarded);
}

is_upgrade_enabled(itemRef) {
  if(is_chaos_mode()) {
    return false;
  }

  if(!is_using_extinction_tokens()) {
    return false;
  }

  if(GetDvarInt("EnableExtinctionPurchasables")) {
    return true;
  }

  if(GetDvarInt("DisableExtinctionPurchasables")) {
    return false;
  }

  if(self alienscheckisupgradeenabled(itemRef)) {
    return true;
  } else {
    return false;
  }
}

is_upgrade_purchased(itemRef) {
  if(!is_using_extinction_tokens()) {
    return false;
  }

  if(self alienscheckisitempurchased(itemRef)) {
    return true;
  } else {
    return false;
  }
}

session_stats_init() {
  self SetCoopPlayerData("alienSession", "team_shots", 0);
  self SetCoopPlayerData("alienSession", "team_kills", 0);
  self SetCoopPlayerData("alienSession", "team_hives", 0);
  self SetCoopPlayerData("alienSession", "downed", 0);
  self SetCoopPlayerData("alienSession", "hivesDestroyed", 0);
  self SetCoopPlayerData("alienSession", "prestigenerfs", 0);
  self SetCoopPlayerData("alienSession", "repairs", 0);
  self SetCoopPlayerData("alienSession", "drillPlants", 0);
  self SetCoopPlayerData("alienSession", "deployables", 0);
  self SetCoopPlayerData("alienSession", "challengesCompleted", 0);
  self SetCoopPlayerData("alienSession", "challengesAttempted", 0);
  self SetCoopPlayerData("alienSession", "trapKills", 0);
  self SetCoopPlayerData("alienSession", "currencyTotal", 0);
  self SetCoopPlayerData("alienSession", "currencySpent", 0);
  self SetCoopPlayerData("alienSession", "escapedRank0", 0);
  self SetCoopPlayerData("alienSession", "escapedRank1", 0);
  self SetCoopPlayerData("alienSession", "escapedRank2", 0);
  self SetCoopPlayerData("alienSession", "escapedRank3", 0);
  self SetCoopPlayerData("alienSession", "kills", 0);
  self SetCoopPlayerData("alienSession", "revives", 0);
  self SetCoopPlayerData("alienSession", "time", 0);
  self SetCoopPlayerData("alienSession", "score", 0);
  self SetCoopPlayerData("alienSession", "shots", 0);
  self SetCoopPlayerData("alienSession", "last_stand_count", 0);

  self SetCoopPlayerData("alienSession", "deaths", 0);
  self SetCoopPlayerData("alienSession", "headShots", 0);
  self SetCoopPlayerData("alienSession", "hits", 0);

  self thread weapons_tracking_init();
  self thread resource_tracking_init();

  self thread eog_player_tracking_init();
}

eog_player_tracking_init() {
  wait 0.5;

  player_ref = self get_player_ref();
  foreach(player in level.players) {
    if(getDvar("alien_debug_eog") == "1") {
      iprintln("^6[EOG STAT] " + player_ref + " updated for " + " player_" + player GetEntityNumber());
    }

    player reset_EoG_stats(player_ref);

    player_name = "unknownPlayer";
    if(isDefined(self.name)) {
      player_name = self.name;
    }

    if(!level.console) {
      player_name = GetSubStr(player_name, 0, 19);
    } else {
      if(have_clan_tag(player_name)) {
        player_name = remove_clan_tag(player_name);
      }
    }

    player setcoopplayerdata(player_ref, "name", player_name);
  }

  players_eog_updated = [false, false, false, false];

  foreach(p in level.players) {
    players_eog_updated[int(p GetEntityNumber())] = true;

    if(p == self) {
      continue;
    }
    player_ref = p get_player_ref();

    if(getDvar("alien_debug_eog") == "1") {
      iprintln("^6[EOG STAT] player_" + self GetEntityNumber() + " grabbed " + player_ref);
    }

    name = p getcoopplayerdata(player_ref, "name");
    kills = p getcoopplayerdata(player_ref, "kills");
    score = p getcoopplayerdata(player_ref, "score");
    assists = p getcoopplayerdata(player_ref, "assists");
    revives = p getcoopplayerdata(player_ref, "revives");
    drillrestarts = p getcoopplayerdata(player_ref, "drillrestarts");
    drillplants = p getcoopplayerdata(player_ref, "drillplants");
    downs = p getcoopplayerdata(player_ref, "downs");
    deaths = p getcoopplayerdata(player_ref, "deaths");
    hivesdestroyed = p getcoopplayerdata(player_ref, "hivesdestroyed");
    currency = p getcoopplayerdata(player_ref, "currency");
    currencyspent = p getcoopplayerdata(player_ref, "currencyspent");
    currencytotal = p getcoopplayerdata(player_ref, "currencytotal");
    traps = p getcoopplayerdata(player_ref, "traps");
    deployables = p getcoopplayerdata(player_ref, "deployables");
    deployablesused = p getcoopplayerdata(player_ref, "deployablesused");

    self setcoopplayerdata(player_ref, "name", name);
    self setcoopplayerdata(player_ref, "kills", kills);
    self setcoopplayerdata(player_ref, "score", score);
    self setcoopplayerdata(player_ref, "assists", assists);
    self setcoopplayerdata(player_ref, "revives", revives);
    self setcoopplayerdata(player_ref, "drillrestarts", drillrestarts);
    self setcoopplayerdata(player_ref, "drillplants", drillplants);
    self setcoopplayerdata(player_ref, "downs", downs);
    self setcoopplayerdata(player_ref, "deaths", deaths);
    self setcoopplayerdata(player_ref, "hivesdestroyed", hivesdestroyed);
    self setcoopplayerdata(player_ref, "currency", currency);
    self setcoopplayerdata(player_ref, "currencyspent", currencyspent);
    self setcoopplayerdata(player_ref, "currencytotal", currencytotal);
    self setcoopplayerdata(player_ref, "traps", traps);
    self setcoopplayerdata(player_ref, "deployables", deployables);
    self setcoopplayerdata(player_ref, "deployablesused", deployablesused);
  }

  foreach(index, result in players_eog_updated) {
    if(!result) {
      if(getDvar("alien_debug_eog") == "1") {
        iprintln("^6[EOG STAT] player_" + self GetEntityNumber() + " reset EoGPlayer" + index);
      }

      self reset_EoG_stats("EoGPlayer" + index);
    }
  }
}

reset_EoG_stats(EoGPlayer_ref) {
  self setcoopplayerdata(EoGPlayer_ref, "name", "");
  self setcoopplayerdata(EoGPlayer_ref, "kills", 0);
  self setcoopplayerdata(EoGPlayer_ref, "score", 0);
  self setcoopplayerdata(EoGPlayer_ref, "assists", 0);
  self setcoopplayerdata(EoGPlayer_ref, "revives", 0);
  self setcoopplayerdata(EoGPlayer_ref, "drillrestarts", 0);
  self setcoopplayerdata(EoGPlayer_ref, "drillplants", 0);
  self setcoopplayerdata(EoGPlayer_ref, "downs", 0);
  self setcoopplayerdata(EoGPlayer_ref, "deaths", 0);
  self setcoopplayerdata(EoGPlayer_ref, "hivesdestroyed", 0);
  self setcoopplayerdata(EoGPlayer_ref, "currency", 0);
  self setcoopplayerdata(EoGPlayer_ref, "currencyspent", 0);
  self setcoopplayerdata(EoGPlayer_ref, "currencytotal", 0);
  self setcoopplayerdata(EoGPlayer_ref, "traps", 0);
  self setcoopplayerdata(EoGPlayer_ref, "deployables", 0);
  self setcoopplayerdata(EoGPlayer_ref, "deployablesused", 0);
}

eog_player_update_stat(stat_ref, amount, override_value) {
  player_ref = get_player_ref();

  new_amount = amount;
  if(!isDefined(override_value) || !override_value) {
    old_amount = self GetCoopPlayerData(player_ref, stat_ref);
    new_amount = int(old_amount) + int(amount);
  }

  try_update_LB_playerdata(stat_ref, new_amount, true);

  setcoopplayerdata_for_everyone(player_ref, stat_ref, new_amount);
}

try_update_LB_playerdata(EoG_ref, new_amount, override_value) {
  LB_ref = get_mapped_LB_ref_from_EoG_ref(EoG_ref);

  if(!isDefined(LB_ref)) {
    return;
  }
  LB_player_update_stat(LB_ref, new_amount, override_value);
}

LB_player_update_stat(alienSession_ref, amount, override_value) {
  if(is_true(override_value)) {
    new_value = amount;
  } else {
    old_value = self GetCoopPlayerData("alienSession", alienSession_ref);
    new_value = old_value + amount;
  }

  self SetCoopPlayerData("alienSession", alienSession_ref, new_value);
}

weapons_tracking_init() {
  assertex(isDefined(level.collectibles), "level.collectibles not yet setup");

  self.persistence_weaponstats = [];
  foreach(weapon_ref, item in level.collectibles) {
    if(StrTok(weapon_ref, "_")[0] == "weapon") {
      base_weapon = get_base_weapon_name(weapon_ref);

      self.persistence_weaponstats[base_weapon] = true;

    }
  }

  self thread player_weaponstats_track_shots();
}

get_base_weapon_name(weapon_ref) {
  base_weapon = "";

  tokenized = StrTok(weapon_ref, "_");

  for(i = 0; i < tokenized.size; i++) {
    token = tokenized[i];

    if(token == "weapon" && i == 0) {
      continue;
    }
    if(token == "mp") {
      base_weapon += "mp";
      break;
    }

    if(i < tokenized.size - 1) {
      base_weapon += token + "_";
    } else {
      base_weapon += token;
      break;
    }
  }

  if(base_weapon == "") {
    return "none";
  }

  return base_weapon;
}

weaponstats_reset(stat_type, weapon_ref) {
  self setcoopplayerdata(stat_type, weapon_ref, "hits", 0);

  self setcoopplayerdata(stat_type, weapon_ref, "shots", 0);

  self setcoopplayerdata(stat_type, weapon_ref, "kills", 0);
}

update_weaponstats_hits(weapon_ref, hits, sMeansOfDeath) {
  maps\mp\alien\_debug::debug_print_weapon_hits(weapon_ref, sMeansOfDeath);

  if(!is_valid_weapon_hit(weapon_ref, sMeansOfDeath)) {
    return;
  }
  assertex(isDefined(hits) && hits >= 0, "value not accepted as hits for weapon stats tracking");

  self update_weaponstats("weaponStats", weapon_ref, "hits", hits);

  self maps\mp\alien\_gamescore::update_personal_encounter_performance(maps\mp\alien\_gamescore::get_personal_score_component_name(), "shots_hit", hits);
}

is_valid_weapon_hit(weapon_ref, sMeansOfDeath) {
  if(weapon_ref == "none") {
    return false;
  }

  if(sMeansOfDeath == "MOD_MELEE") {
    return false;
  }

  if(no_weapon_fired_notify(weapon_ref)) {
    return false;
  }

  return true;
}

no_weapon_fired_notify(weapon_ref) {
  switch (weapon_ref) {
    case "turret_minigun_alien":
    case "alien_manned_gl_turret_mp":
    case "alien_manned_gl_turret1_mp":
    case "alien_manned_gl_turret2_mp":
    case "alien_manned_gl_turret3_mp":
    case "alien_manned_gl_turret4_mp":
    case "alien_manned_minigun_turret_mp":
    case "alien_manned_minigun_turret1_mp":
    case "alien_manned_minigun_turret2_mp":
    case "alien_manned_minigun_turret3_mp":
    case "alien_manned_minigun_turret4_mp":
    case "switchblade_rocket_mp":
    case "alienmortar_strike_mp":
    case "aliensemtex_mp":
    case "alien_sentry_minigun_1_mp":
    case "alien_sentry_minigun_2_mp":
    case "alien_sentry_minigun_3_mp":
    case "alien_sentry_minigun_4_mp":
    case "aliensoflam_missle_mp":
    case "alienthrowingknife_mp":
    case "alienims_projectile_mp":
    case "alienclaymore_mp":
    case "alienmortar_shell_mp":
    case "alien_ball_drone_gun_mp":
    case "alien_ball_drone_gun1_mp":
    case "alien_ball_drone_gun2_mp":
    case "alien_ball_drone_gun3_mp":
    case "alien_ball_drone_gun4_mp":
    case "alienvulture_mp":
    case "alienbetty_mp":
    case "turret_minigun_alien_railgun":
    case "turret_minigun_alien_grenade":
    case "alientank_turret_mp":
    case "alientank_rigger_turret_mp":
      return true;

    default:
      return false;
  }
}

update_weaponstats_shots(weapon_ref, shots) {
  maps\mp\alien\_debug::debug_print_weapon_shots(weapon_ref);

  assertex(isDefined(shots) && shots >= 0, "value not accepted as shots for weapon stats tracking");

  if(!self.should_track_weapon_fired) {
    return;
  }
  level.alienBBData["bullets_shot"] += shots;

  self update_weaponstats("weaponStats", weapon_ref, "shots", shots);

  self maps\mp\alien\_gamescore::update_personal_encounter_performance(maps\mp\alien\_gamescore::get_personal_score_component_name(), "shots_fired", shots);
}

update_weaponstats_kills(weapon_ref, kills) {
  assertex(isDefined(kills) && kills >= 0, "value not accepted as kills for weapon stats tracking");

  self update_weaponstats("weaponStats", weapon_ref, "kills", kills);
}

update_weaponstats(stat_type, weapon_ref, stat, value) {
  if(!isplayer(self)) {
    return;
  }
  base_weapon = get_base_weapon_name(weapon_ref);

  if(!isDefined(base_weapon) || !isDefined(self.persistence_weaponstats[base_weapon])) {
    return;
  }
  if(isDefined(level.weapon_stats_override_name_func)) {
    base_weapon = [[level.weapon_stats_override_name_func]](base_weapon);
  }

  if(IsSubStr(base_weapon, "dlc")) {
    tokens = StrTok(base_weapon, "d");

    base_weapon = tokens[0] + "DLC";
    tokens = StrTok(tokens[1], "c");

    base_weapon = base_weapon + tokens[1];
  }

  old_value = int(self getcoopplayerdata(stat_type, base_weapon, stat));
  new_value = old_value + int(value);
  self setcoopplayerdata(stat_type, base_weapon, stat, new_value);
}

player_weaponstats_track_shots() {
  self endon("disconnect");

  self notify("weaponstats_track_shots");
  self endon("weaponstats_track_shots");

  while(1) {
    self waittill("weapon_fired", weapon_ref);
    if(!isDefined(weapon_ref)) {
      continue;
    }
    shotsFired = 1;
    self update_weaponstats_shots(weapon_ref, shotsFired);
  }
}

resource_tracking_init() {
  foreach(combat_resources in level.alien_combat_resources) {
    foreach(resource, resource_struct in combat_resources) {
      self setcoopplayerdata("resourceStatsSession", resource, "purchase", 0);
      self setcoopplayerdata("resourceStatsSession", resource, "upgrade", 0);
      self setcoopplayerdata("resourceStatsSession", resource, "used", 0);
    }
  }
  foreach(perk in level.alien_perks["perk_0"]) {
    self setcoopplayerdata("resourceStatsSession", perk.ref, "purchase", 0);
    self setcoopplayerdata("resourceStatsSession", perk.ref, "upgrade", 0);
  }
  foreach(perk in level.alien_perks["perk_1"]) {
    self setcoopplayerdata("resourceStatsSession", perk.ref, "purchase", 0);
    self setcoopplayerdata("resourceStatsSession", perk.ref, "upgrade", 0);
  }
}

update_resource_stats(track_type, resource, count) {
  if(!isplayer(self)) {
    return;
  }
  assertex(isDefined(resource), "resource reference string invalid");

  self thread update_resource_stats_raw("resourceStats", track_type, resource, count);
  self thread update_resource_stats_raw("resourceStatsSession", track_type, resource, count);
}

update_resource_stats_raw(stat_type, track_type, resource, count) {
  old_value = int(self getcoopplayerdata(stat_type, resource, track_type));
  new_value = old_value + int(count);
  self setcoopplayerdata(stat_type, resource, track_type, new_value);
}

RANK_TABLE = "mp/alien/rankTable.csv";

TABLE_ID = 0;
TABLE_REF = 1;
TABLE_XP_MIN = 2;
TABLE_XP_NEXT = 3;
TABLE_RANK_SHORT = 4;
TABLE_RANK_FULL = 5;
TABLE_ICON = 6;
TABLE_XP_MAX = 7;
TABLE_WEAPON_UNLOCK = 8;
TABLE_PERK_UNLOCK = 9;
TABLE_CHALLENGE = 10;
TABLE_CAMO = 11;
TABLE_ATTACHMENT = 12;
TABLE_LEVEL = 13;
TABLE_DISPLAY_LEVEL = 14;
TABLE_FEATURE_UNLOCK = 15;
TABLE_RANK_INGAME = 16;
TABLE_UNLOCK_STRING = 17;
TABLE_TOKEN_REWARD = 18;

rank_init() {
  if(!isDefined(level.alien_ranks_table)) {
    level.alien_ranks_table = RANK_TABLE;
  }

  level.alien_ranks = [];

  level.alien_max_rank = int(tablelookup(level.alien_ranks_table, TABLE_ID, "maxrank", TABLE_REF));
  assertex(isDefined(level.alien_max_rank) && level.alien_max_rank);

  for(i = 0; i <= level.alien_max_rank; i++) {
    rank_ref = get_ref_by_id(i);
    if(rank_ref == "") {
      break;
    }

    if(!isDefined(level.alien_ranks[i])) {
      rank = spawnStruct();
      rank.id = i;
      rank.ref = rank_ref;
      rank.lvl = get_level_by_id(i);
      rank.icon = get_icon_by_id(i);
      rank.tokenReward = get_token_reward_by_id(i);
      rank.xp = [];
      rank.xp["min"] = get_minxp_by_id(i);
      rank.xp["next"] = get_nextxp_by_id(i);
      rank.xp["max"] = get_maxxp_by_id(i);

      rank.name = [];
      rank.name["short"] = get_shortrank_by_id(i);
      rank.name["full"] = get_fullrank_by_id(i);
      rank.name["ingame"] = get_ingamerank_by_id(i);

      level.alien_ranks[i] = rank;
    }
  }
}

get_ref_by_id(id) {
  return tablelookup(level.alien_ranks_table, TABLE_ID, id, TABLE_REF);
}

get_minxp_by_id(id) {
  return int(tablelookup(level.alien_ranks_table, TABLE_ID, id, TABLE_XP_MIN));
}

get_maxxp_by_id(id) {
  return int(tablelookup(level.alien_ranks_table, TABLE_ID, id, TABLE_XP_MAX));
}

get_nextxp_by_id(id) {
  return int(tablelookup(level.alien_ranks_table, TABLE_ID, id, TABLE_XP_NEXT));
}

get_level_by_id(id) {
  return int(tablelookup(level.alien_ranks_table, TABLE_ID, id, TABLE_LEVEL));
}

get_shortrank_by_id(id) {
  return tablelookup(level.alien_ranks_table, TABLE_ID, id, TABLE_RANK_SHORT);
}

get_fullrank_by_id(id) {
  return tablelookup(level.alien_ranks_table, TABLE_ID, id, TABLE_RANK_FULL);
}

get_ingamerank_by_id(id) {
  return tablelookup(level.alien_ranks_table, TABLE_ID, id, TABLE_RANK_INGAME);
}

get_icon_by_id(id) {
  return tablelookup(level.alien_ranks_table, TABLE_ID, id, TABLE_ICON);
}

get_token_reward_by_id(id) {
  return int(tablelookup(level.alien_ranks_table, TABLE_ID, id, TABLE_TOKEN_REWARD));
}

get_player_rank() {
  return self getcoopplayerdata("alienPlayerStats", "rank");
}
get_player_xp() {
  return self getcoopplayerdata("alienPlayerStats", "experience");
}
get_player_prestige() {
  return self getcoopplayerdata("alienPlayerStats", "prestige");
}
get_player_escaped() {
  return self getcoopplayerdata("alienPlayerStats", "escaped");
}
get_player_kills() {
  return self getcoopplayerdata("alienPlayerStats", "kills");
}
get_player_revives() {
  return self getcoopplayerdata("alienPlayerStats", "revives");
}
get_player_highest_nerf_escape_count() {
  return self getcoopplayerdata("alienPlayerStats", "headShots");
}

get_player_session_xp() {
  return self getcoopplayerdata("alienSession", "experience");
}

set_player_session_xp(experience) {
  self setcoopplayerdata("alienSession", "experience", experience);
}

give_player_session_xp(amount) {
  old_session_xp = self get_player_session_xp();
  new_session_xp = amount + old_session_xp;
  self set_player_session_xp(new_session_xp);
}

get_player_session_tokens() {
  return self getcoopplayerdata("alienSession", "shots");
}

set_player_session_tokens(tokens) {
  self setcoopplayerdata("alienSession", "shots", tokens);
}

give_player_session_tokens(amount) {
  old_session_tokens = self get_player_session_tokens();
  new_session_tokens = amount + old_session_tokens;
  self set_player_session_tokens(new_session_tokens);
}

set_player_session_rankup(ranked_up_times) {
  self setcoopplayerdata("alienSession", "ranked_up", int(ranked_up_times));
}

get_player_session_rankup() {
  return self getcoopplayerdata("alienSession", "ranked_up");
}

update_player_session_rankup(ranked_up_times) {
  if(!isDefined(ranked_up_times)) {
    ranked_up_times = 1;
  }

  old_ranked_up_times = self get_player_session_rankup();
  new_ranked_up_times = ranked_up_times + old_ranked_up_times;
  self set_player_session_rankup(new_ranked_up_times);
}

set_player_rank(rank) {
  self setcoopplayerdata("alienPlayerStats", "rank", rank);
}

set_player_xp(xp) {
  self setcoopplayerdata("alienPlayerStats", "experience", xp);
}

set_player_kills() {
  old_kills = get_player_kills();
  new_kills = old_kills + 1;
  self setcoopplayerdata("alienPlayerStats", "kills", new_kills);
}

set_player_revives() {
  old_revives = get_player_revives();
  new_revives = old_revives + 1;
  self setcoopplayerdata("alienPlayerStats", "revives", new_revives);
}

set_player_escaped() {
  old_escaped = get_player_escaped();
  new_escaped = old_escaped + 1;
  self setcoopplayerdata("alienPlayerStats", "escaped", new_escaped);
}

set_player_prestige(prestige) {
  self setcoopplayerdata("alienPlayerStats", "prestige", prestige);

  self setcoopplayerdata("alienPlayerStats", "experience", 0);
  self setcoopplayerdata("alienPlayerStats", "rank", 0);
}

get_rank_by_xp(xp) {
  rank = 0;

  for(i = 0; i < level.alien_ranks.size; i++) {
    if(xp >= level.alien_ranks[i].xp["min"]) {
      if(xp < level.alien_ranks[i].xp["max"]) {
        rank = level.alien_ranks[i].id;
        break;
      }
    }
  }

  return (rank);
}

get_scaled_xp(xp) {
  if(is_chaos_mode()) {
    xp = int(0.66 * xp);
  }
  return int(xp * level.xpScale);
}

wait_and_give_player_xp(xp, waitTime) {
  self endon("disconnect");
  level endon("game_ended");

  wait waitTime;
  give_player_xp(xp);
}

give_player_xp(xp) {
  xp = get_scaled_xp(xp);

  if(xp > 90000) {
    xp = 90000;
  }

  self thread give_player_session_xp(xp);
  at_max_rank = false;
  old_rank = self get_player_rank();
  old_xp = self get_player_xp();

  old_prestige = self GetCoopPlayerData("alienPlayerStats", "prestige");

  if((old_prestige == 5 || old_prestige == 10 || old_prestige == 15 || old_prestige == 20) && old_xp >= level.alien_ranks[29].xp["max"]) {
    old_xp = level.alien_ranks[29].xp["max"] - 1;
    old_rank = 29;
  }
  new_xp = old_xp + xp;
  new_prestige = 0;

  /#	
  if(getDvar("alien_debug_xp") == "1") {
    IPrintLn("+" + xp + "xp [" + new_xp + "]");
  }

  self set_player_xp(new_xp);

  new_rank = self get_rank_by_xp(new_xp);

  if(new_rank > old_rank) {
    if(new_rank == level.alien_max_rank) {
      prestige = self GetCoopPlayerData("alienPlayerStats", "prestige");
      new_prestige = prestige;
      if(prestige < MAX_PRESTIGE) {
        set_player_prestige(prestige + 1);
        new_prestige = prestige + 1;
        give_player_tokens(1, true);
      } else {
        at_max_rank = true;
        self set_player_rank(new_rank);
      }
    } else {
      self set_player_rank(new_rank);
    }

    if(at_max_rank == false) {
      if(new_rank == 30) {
        display_rank = 1;
      }
      else {
        display_rank = new_rank + 1;
      }

      self setclientomnvar("ui_alien_rankup", display_rank);
      self notify("ranked_up", new_rank);
      self update_player_session_rankup();

      /#		if( getDvar( "alien_debug_xp" ) == "1" )
      IPrintLnbold("Ranked up: Lv." + new_rank + " [XP: " + new_xp + "]");

      self award_rank_up_tokens(old_rank);

    }

    self SetRank(self get_player_rank(), self get_player_prestige());
  }
}

inc_stat(ref_name, stat_name, value) {
  old_value = self getcoopplayerdata(ref_name, stat_name);
  new_value = old_value + value;

  self setcoopplayerdata(ref_name, stat_name, new_value);
}

inc_session_stat(stat_name, value) {
  inc_stat("alienSession", stat_name, value);
}

get_hives_destroyed_stat() {
  return get_alienSession_stat("hivesDestroyed");
}

get_alienSession_stat(field) {
  return (self getcoopplayerdata("alienSession", field));
}

set_alienSession_stat(field, value) {
  self setcoopplayerdata("alienSession", field, value);
}

BBData_init() {
  level.alienBBData = [];

  level.alienBBData["times_downed"] = 0;
  level.alienBBData["times_died"] = 0;
  level.alienBBData["times_drill_stuck"] = 0;
  level.alienBBData["aliens_killed"] = 0;
  level.alienBBData["team_item_deployed"] = 0;
  level.alienBBData["team_item_used"] = 0;
  level.alienBBData["bullets_shot"] = 0;
  level.alienBBData["damage_taken"] = 0;
  level.alienBBData["damage_done"] = 0;
  level.alienBBData["traps_used"] = 0;

  level notify("BBData_initialized");
}

deployablebox_used_track(boxEnt) {
  itemname = boxEnt.boxType;
  if(isDefined(boxEnt.dpadName)) {
    itemname = boxEnt.dpadName;
  }

  self thread maps\mp\alien\_persistence::update_resource_stats("used", itemname, 1);

  self maps\mp\alien\_gamescore::update_personal_encounter_performance(maps\mp\alien\_gamescore::get_team_score_component_name(), "team_support_deploy");

  level.alienBBData["team_item_used"]++;
  self eog_player_update_stat("deployablesused", 1);

  username = "";
  if(isDefined(self.name)) {
    username = self.name;
  }

  if(GetDvarInt("alien_bbprint_debug") > 0) {
    IPrintLnBold("^8bbprint: aliendeployableused \n" +
      " itemname=" + itemname +
      " itemlevel=" + boxEnt.upgrade_rank +
      " itemx,y,z=" + boxEnt.origin +
      " username=" + username);
  }

  bbprint("aliendeployableused",
    "itemname %s itemlevel %i itemx %f itemy %f itemz %f username %s ",
    boxEnt.boxType,
    boxEnt.upgrade_rank,
    boxEnt.origin[0],
    boxEnt.origin[1],
    boxEnt.origin[2],
    username);
}

get_player_ref() {
  return ("EoGPlayer" + (self GetEntityNumber()));
}

update_LB_alienSession_challenge(challenge_succeed) {
  foreach(player in level.players) {
    player LB_player_update_stat("challengesAttempted", 1);

    if(challenge_succeed) {
      player LB_player_update_stat("challengesCompleted", 1);
    }
  }
}

update_LB_alienSession_escape(players_escaped, escape_time_remains) {
  LB_escape_rank = get_LB_escape_rank(escape_time_remains);

  foreach(player in players_escaped) {
    player LB_player_update_stat("escapedRank" + LB_escape_rank, 1, true);
    player LB_player_update_stat("hits", 1, true);
  }
}

update_alien_kill_sessionStats(eInflictor, eAttacker) {
  if(!isDefined(eAttacker) || !isPlayer(eAttacker)) {
    return;
  }
  if(maps\mp\alien\_utility::is_trap(eInflictor)) {
    eAttacker LB_player_update_stat("trapKills", 1);
  }
}

register_LB_escape_rank(escape_rank_array) {
  level.escape_rank_array = escape_rank_array;
}

get_LB_escape_rank(escape_time_remains) {
  for(i = 0; i < level.escape_rank_array.size - 1; i++) {
    if(escape_time_remains >= level.escape_rank_array[i] && escape_time_remains < level.escape_rank_array[i + 1]) {
      return i;
    }
  }
}

have_clan_tag(player_name) {
  return (IsSubStr(player_name, "[") && IsSubStr(player_name, "]"));
}

remove_clan_tag(player_name) {
  name_tokenized = StrToK(player_name, "]");
  return name_tokenized[1];
}

register_EoG_to_LB_playerdata_mapping() {
  alienSession_to_EoG_mapping = [];

  EoG_to_LB_playerdata_mapping["kills"] = "kills";
  EoG_to_LB_playerdata_mapping["deployables"] = "deployables";
  EoG_to_LB_playerdata_mapping["drillplants"] = "drillPlants";
  EoG_to_LB_playerdata_mapping["revives"] = "revives";
  EoG_to_LB_playerdata_mapping["downs"] = "downed";
  EoG_to_LB_playerdata_mapping["drillrestarts"] = "repairs";
  EoG_to_LB_playerdata_mapping["score"] = "score";
  EoG_to_LB_playerdata_mapping["currencyspent"] = "currencySpent";
  EoG_to_LB_playerdata_mapping["currencytotal"] = "currencyTotal";
  EoG_to_LB_playerdata_mapping["hivesdestroyed"] = "hivesDestroyed";

  level.EoG_to_LB_playerdata_mapping = EoG_to_LB_playerdata_mapping;
}

get_mapped_LB_ref_from_EoG_ref(EoG_ref) {
  return level.EoG_to_LB_playerdata_mapping[EoG_ref];
}

play_time_monitor() {
  self endon("disconnect");

  while(true) {
    wait(1);
    self LB_player_update_stat("time", 1);
  }
}