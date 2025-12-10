/*****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\cp_persistence.gsc
*****************************************/

set_perk(param_00) {
  self[[level.coop_perk_callbacks[param_00].set]]();
}

unset_perk(param_00) {
  self[[level.coop_perk_callbacks[param_00].unset]]();
}

get_player_currency() {
  return self getplayerdata("cp", "alienSession", "currency");
}

get_player_max_currency() {
  return self.maxcurrency;
}

take_all_currency() {
  set_player_currency(0);
}

get_starting_currency() {
  if(isDefined(level.starting_currency)) {
    return level.starting_currency;
  }

  return 500;
}

wait_to_set_player_currency(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  wait(1);
  set_player_currency(param_00);
}

set_player_currency(param_00) {
  self setplayerdata("cp", "alienSession", "currency", int(param_00));
  eog_player_update_stat("currency", int(param_00), 1);
}

give_player_currency(param_00, param_01, param_02, param_03, param_04) {
  if(!isplayer(self)) {
    return;
  }

  if(!scripts\engine\utility::istrue(param_03)) {
    param_00 = int(param_00 * scripts\cp\perks\prestige::prestige_getmoneyearnedscalar());
    param_00 = scripts\cp\cp_gamescore::round_up_to_nearest(param_00, 5);
  }

  if(isDefined(level.currency_scale_func)) {
    param_00 = [[level.currency_scale_func]](self, param_00);
  }

  var_05 = get_player_currency();
  var_06 = get_player_max_currency();
  var_07 = var_05 + param_00;
  var_07 = min(var_07, var_06);
  if(!isDefined(self.total_currency_earned)) {
    self.total_currency_earned = param_00;
  }

  if(is_valid_give_type(param_04)) {
    self.total_currency_earned = self.total_currency_earned + var_07 - var_05;
    self notify("consumable_charge", param_00 * 0.5);
  }

  level notify("currency_changed");
  eog_player_update_stat("currencytotal", int(self.total_currency_earned), 1);
  set_player_currency(var_07);
  if(isDefined(level.update_money_performance)) {
    [[level.update_money_performance]](self, param_00);
  }

  var_08 = 30000;
  var_09 = gettime();
  if(var_07 >= var_06) {
    if(!isDefined(self.next_maxmoney_hint_time)) {
      self.next_maxmoney_hint_time = var_09 + var_08;
    } else if(var_09 < self.next_maxmoney_hint_time) {
      return;
    }

    if(!level.gameended) {
      scripts\cp\utility::setlowermessage("maxmoney", &"COOP_GAME_PLAY_MONEY_MAX", 4);
      self.next_maxmoney_hint_time = var_09 + var_08;
    }
  }

  if(is_valid_give_type(param_04)) {
    thread scripts\cp\utility::add_to_notify_queue("player_earned_money", param_00);
  }

  self notify("currency_earned", param_00);
  if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    scripts\cp\utility::bufferednotify("currency_earned_buffered", param_00);
  }

  eog_player_update_stat("score", int(self.total_currency_earned), 1);
}

is_valid_give_type(param_00) {
  if(!isDefined(param_00)) {
    return 1;
  }

  switch (param_00) {
    case "pillage":
    case "nuke":
    case "magicWheelRefund":
    case "crafted":
    case "carpenter":
    case "bonus":
    case "atm":
      return 0;

    default:
      return 1;
  }

  return 1;
}

take_player_currency(param_00, param_01, param_02, param_03) {
  var_04 = get_player_currency();
  var_05 = max(0, var_04 - param_00);
  var_06 = int(var_04 - var_05);
  if(isDefined(level.chaos_update_spending_currency_event)) {
    [[level.chaos_update_spending_currency_event]](self, param_02, param_03);
  }

  if(scripts\cp\utility::is_consumable_active("next_purchase_free") && param_00 >= 1 && param_02 != "atm" && param_02 != "laststand" && param_02 != "bleedoutPenalty") {
    scripts\cp\utility::notify_used_consumable("next_purchase_free");
  } else {
    set_player_currency(var_05);
  }

  if(var_06 < 1) {
    return;
  }

  if(isDefined(param_02)) {
    scripts\cp\cp_analytics::update_spending_type(var_06, param_02);
  }

  eog_player_update_stat("currencyspent", var_06);
  if(scripts\cp\utility::is_consumable_active("door_buy_refund") && param_00 > 0) {
    if(param_02 != "atm" && param_02 != "laststand" && param_02 != "bleedoutPenalty") {
      give_player_currency(int(var_06 * 0.3), undefined, undefined, 1, "bonus");
      scripts\cp\utility::notify_used_consumable("door_buy_refund");
    }
  }

  if(scripts\cp\cp_interaction::should_interaction_fill_consumable_meter(param_02)) {
    self notify("consumable_charge", param_00 * 0.07);
  }

  if(param_02 != "atm" && param_02 != "laststand" && param_02 != "bleedoutPenalty") {
    scripts\cp\utility::bufferednotify("currency_spent_buffered", param_00);
  }

  if(isDefined(param_01) && param_01) {}
}

player_has_enough_currency(param_00, param_01) {
  if(!isDefined(param_01) || isDefined(param_01) && param_01 != "atm" && param_01 != "laststand" && param_01 != "bleedoutPenalty") {
    if(scripts\cp\utility::is_consumable_active("next_purchase_free")) {
      param_00 = 0;
    }
  }

  var_02 = get_player_currency();
  return var_02 >= param_00;
}

try_take_player_currency(param_00) {
  if(player_has_enough_currency(param_00)) {
    take_player_currency(param_00);
    return 1;
  }

  return 0;
}

is_unlocked(param_00) {
  var_01 = undefined;
  var_01 = strtok(param_00, "_")[0];
  var_02 = level.combat_resource[param_00].unlock;
  var_03 = get_player_rank();
  return var_03 >= var_02;
}

player_persistence_init() {
  level.zombie_xp = 1;
  set_player_session_xp(0);
  set_player_session_rankup(0);
  self setrank(get_player_rank(), get_player_prestige());
}

setcoopplayerdata_for_everyone(param_00, param_01, param_02, param_03, param_04) {
  foreach(var_07, var_06 in level.players) {
    if(var_07 == 4) {
      continue;
    }

    if(isDefined(param_00) && isDefined(param_01) && isDefined(param_02) && isDefined(param_03) && isDefined(param_04)) {
      var_06 setplayerdata("cp", param_00, param_01, param_02, param_03, param_04);
      continue;
    }

    if(isDefined(param_00) && isDefined(param_01) && isDefined(param_02) && isDefined(param_03) && !isDefined(param_04)) {
      var_06 setplayerdata("cp", param_00, param_01, param_02, param_03);
      continue;
    }

    if(isDefined(param_00) && isDefined(param_01) && isDefined(param_02) && !isDefined(param_03) && !isDefined(param_04)) {
      var_06 setplayerdata("cp", param_00, param_01, param_02);
      continue;
    }

    if(isDefined(param_00) && isDefined(param_01) && !isDefined(param_02) && !isDefined(param_03) && !isDefined(param_04)) {
      var_06 setplayerdata("cp", param_00, param_01);
      continue;
    }
  }
}

session_stats_init() {
  thread eog_player_tracking_init();
}

eog_player_tracking_init() {
  self endon("disconnect");
  wait(0.5);
  var_00 = self getentitynumber();
  if(var_00 == 4) {
    var_00 = 0;
  }

  var_01 = "unknownPlayer";
  if(isDefined(self.name)) {
    var_01 = self.name;
  }

  if(!level.console) {
    var_01 = getsubstr(var_01, 0, 19);
  } else if(have_clan_tag(var_01)) {
    var_01 = remove_clan_tag(var_01);
  }

  for(var_02 = 0; var_02 < 4; var_02++) {
    self setplayerdata("cp", "EoGPlayer", var_02, "connected", 0);
  }

  foreach(var_04 in level.players) {
    var_04 reset_eog_stats(var_00);
    var_04 setplayerdata("cp", "EoGPlayer", var_00, "connected", 1);
    var_04 setplayerdata("cp", "EoGPlayer", var_00, "name", var_01);
    var_04 setplayerdata("common", "round", "totalXp", 0);
    var_04 setplayerdata("common", "aarUnlockCount", 0);
  }

  var_06 = [0, 0, 0, 0];
  foreach(var_08 in level.players) {
    var_09 = var_08 getentitynumber();
    if(var_09 == 4) {
      var_09 = 0;
    }

    var_06[int(var_09)] = 1;
    if(var_08 == self) {
      continue;
    }

    var_00 = var_08 getentitynumber();
    if(var_00 == 4) {
      var_00 = 0;
    }

    var_0A = var_08 getplayerdata("cp", "EoGPlayer", var_00, "name");
    var_0B = var_08 getplayerdata("cp", "EoGPlayer", var_00, "kills");
    var_0C = var_08 getplayerdata("cp", "EoGPlayer", var_00, "score");
    var_0D = var_08 getplayerdata("cp", "EoGPlayer", var_00, "assists");
    var_0E = var_08 getplayerdata("cp", "EoGPlayer", var_00, "revives");
    var_0F = var_08 getplayerdata("cp", "EoGPlayer", var_00, "drillrestarts");
    var_10 = var_08 getplayerdata("cp", "EoGPlayer", var_00, "drillplants");
    var_11 = var_08 getplayerdata("cp", "EoGPlayer", var_00, "downs");
    var_12 = var_08 getplayerdata("cp", "EoGPlayer", var_00, "deaths");
    var_13 = var_08 getplayerdata("cp", "EoGPlayer", var_00, "hivesdestroyed");
    var_14 = var_08 getplayerdata("cp", "EoGPlayer", var_00, "currency");
    var_15 = var_08 getplayerdata("cp", "EoGPlayer", var_00, "currencyspent");
    var_16 = var_08 getplayerdata("cp", "EoGPlayer", var_00, "currencytotal");
    var_17 = var_08 getplayerdata("cp", "EoGPlayer", var_00, "currency");
    var_18 = var_08 getplayerdata("cp", "EoGPlayer", var_00, "currencyspent");
    var_19 = var_08 getplayerdata("cp", "EoGPlayer", var_00, "currencytotal");
    var_1A = var_08 getplayerdata("cp", "EoGPlayer", var_00, "traps");
    var_1B = var_08 getplayerdata("cp", "EoGPlayer", var_00, "deployables");
    var_1C = var_08 getplayerdata("cp", "EoGPlayer", var_00, "deployablesused");
    var_1D = var_08 getplayerdata("cp", "EoGPlayer", var_00, "consumablesearned");
    var_1E = var_08 getplayerdata("cp", "EoGPlayer", var_00, "headShots");
    var_1F = var_08 getplayerdata("cp", "EoGPlayer", var_00, "connected");
    self setplayerdata("cp", "EoGPlayer", var_00, "name", var_0A);
    self setplayerdata("cp", "EoGPlayer", var_00, "kills", var_0B);
    self setplayerdata("cp", "EoGPlayer", var_00, "score", var_0C);
    self setplayerdata("cp", "EoGPlayer", var_00, "assists", var_0D);
    self setplayerdata("cp", "EoGPlayer", var_00, "revives", var_0E);
    self setplayerdata("cp", "EoGPlayer", var_00, "drillrestarts", var_0F);
    self setplayerdata("cp", "EoGPlayer", var_00, "drillplants", var_10);
    self setplayerdata("cp", "EoGPlayer", var_00, "downs", var_11);
    self setplayerdata("cp", "EoGPlayer", var_00, "deaths", var_12);
    self setplayerdata("cp", "EoGPlayer", var_00, "hivesdestroyed", var_13);
    self setplayerdata("cp", "EoGPlayer", var_00, "currency", var_14);
    self setplayerdata("cp", "EoGPlayer", var_00, "currencyspent", var_15);
    self setplayerdata("cp", "EoGPlayer", var_00, "currencytotal", var_16);
    self setplayerdata("cp", "EoGPlayer", var_00, "tickets", var_17);
    self setplayerdata("cp", "EoGPlayer", var_00, "ticketsspent", var_18);
    self setplayerdata("cp", "EoGPlayer", var_00, "tickettotal", var_19);
    self setplayerdata("cp", "EoGPlayer", var_00, "traps", var_1A);
    self setplayerdata("cp", "EoGPlayer", var_00, "deployables", var_1B);
    self setplayerdata("cp", "EoGPlayer", var_00, "deployablesused", var_1C);
    self setplayerdata("cp", "EoGPlayer", var_00, "consumablesearned", var_1D);
    self setplayerdata("cp", "EoGPlayer", var_00, "headShots", var_1E);
    self setplayerdata("cp", "EoGPlayer", var_00, "connected", var_1F);
  }

  foreach(var_23, var_22 in var_06) {
    if(!var_22) {
      reset_eog_stats(var_23);
    }
  }
}

reset_eog_stats(param_00) {
  if(param_00 == 4) {
    param_00 = 0;
  }

  self setplayerdata("cp", "EoGPlayer", param_00, "name", "");
  self setplayerdata("cp", "EoGPlayer", param_00, "kills", 0);
  self setplayerdata("cp", "EoGPlayer", param_00, "score", 0);
  self setplayerdata("cp", "EoGPlayer", param_00, "assists", 0);
  self setplayerdata("cp", "EoGPlayer", param_00, "revives", 0);
  self setplayerdata("cp", "EoGPlayer", param_00, "drillrestarts", 0);
  self setplayerdata("cp", "EoGPlayer", param_00, "drillplants", 0);
  self setplayerdata("cp", "EoGPlayer", param_00, "downs", 0);
  self setplayerdata("cp", "EoGPlayer", param_00, "deaths", 0);
  self setplayerdata("cp", "EoGPlayer", param_00, "hivesdestroyed", 0);
  self setplayerdata("cp", "EoGPlayer", param_00, "currency", 0);
  self setplayerdata("cp", "EoGPlayer", param_00, "currencyspent", 0);
  self setplayerdata("cp", "EoGPlayer", param_00, "currencytotal", 0);
  self setplayerdata("cp", "EoGPlayer", param_00, "tickets", 0);
  self setplayerdata("cp", "EoGPlayer", param_00, "ticketsspent", 0);
  self setplayerdata("cp", "EoGPlayer", param_00, "tickettotal", 0);
  self setplayerdata("cp", "EoGPlayer", param_00, "traps", 0);
  self setplayerdata("cp", "EoGPlayer", param_00, "deployables", 0);
  self setplayerdata("cp", "EoGPlayer", param_00, "deployablesused", 0);
  self setplayerdata("cp", "EoGPlayer", param_00, "consumablesearned", 0);
  self setplayerdata("cp", "EoGPlayer", param_00, "headShots", 0);
}

eog_update_on_player_disconnect(param_00) {
  if(scripts\cp\cp_endgame::gamealreadyended()) {
    return;
  }

  var_01 = param_00 getentitynumber();
  setcoopplayerdata_for_everyone("EoGPlayer", var_01, "connected", 0);
}

eog_player_update_stat(param_00, param_01, param_02) {
  var_03 = self getentitynumber();
  var_04 = param_01;
  if(!isDefined(param_02) || !param_02) {
    var_05 = self getplayerdata("cp", "EoGPlayer", var_03, param_00);
    var_04 = int(var_05) + int(param_01);
  }

  try_update_lb_playerdata(param_00, var_04, 1);
  if(var_03 == 4) {
    var_03 = 0;
  }

  setcoopplayerdata_for_everyone("EoGPlayer", var_03, param_00, var_04);
}

try_update_lb_playerdata(param_00, param_01, param_02) {
  var_03 = get_mapped_lb_ref_from_eog_ref(param_00);
  if(!isDefined(var_03)) {
    return;
  }

  lb_player_update_stat(var_03, param_01, param_02);
}

lb_player_update_stat(param_00, param_01, param_02) {
  if(scripts\engine\utility::istrue(param_02)) {
    var_03 = param_01;
  } else {
    var_04 = self getplayerdata("cp", "alienSession", param_01);
    var_03 = var_04 + param_01;
  }

  self setplayerdata("cp", "alienSession", param_00, var_03);
}

weapons_tracking_init() {
  self.persistence_weaponstats = [];
  foreach(var_03, var_01 in level.collectibles) {
    if(strtok(var_03, "_")[0] == "weapon") {
      var_02 = get_base_weapon_name(var_03);
      self.persistence_weaponstats[var_02] = 1;
    }
  }

  thread player_weaponstats_track_shots();
}

get_base_weapon_name(param_00) {
  var_01 = "";
  var_02 = strtok(param_00, "_");
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    var_04 = var_02[var_03];
    if(var_04 == "weapon" && var_03 == 0) {
      continue;
    }

    if(var_04 == "zm") {
      var_01 = var_01 + "zm";
      break;
    }

    if(var_03 < var_02.size - 1) {
      var_01 = var_01 + var_04 + "_";
      continue;
    }

    var_01 = var_01 + var_04;
    break;
  }

  if(var_01 == "") {
    return "none";
  }

  return var_01;
}

weaponstats_reset(param_00, param_01) {
  self setplayerdata("cp", param_00, param_01, "hits", 0);
  self setplayerdata("cp", param_00, param_01, "shots", 0);
  self setplayerdata("cp", param_00, param_01, "kills", 0);
}

update_weaponstats_hits(param_00, param_01, param_02) {
  if(!is_valid_weapon_hit(param_00, param_02)) {
    return;
  }

  update_weaponstats("weaponStats", param_00, "hits", param_01);
  var_03 = "personal";
  if(isDefined(level.personal_score_component_name)) {
    var_03 = level.personal_score_component_name;
  }

  scripts\cp\cp_gamescore::update_personal_encounter_performance(var_03, "shots_hit", param_01);
}

is_valid_weapon_hit(param_00, param_01) {
  if(param_00 == "none") {
    return 0;
  }

  if(param_01 == "MOD_MELEE") {
    return 0;
  }

  if(no_weapon_fired_notify(param_00)) {
    return 0;
  }

  return 1;
}

no_weapon_fired_notify(param_00) {
  switch (param_00) {
    case "iw7_spiked_bat_zm_pap2":
    case "iw7_spiked_bat_zm_pap1":
    case "iw7_spiked_bat_zm":
    case "iw7_machete_zm_pap2":
    case "iw7_machete_zm_pap1":
    case "iw7_machete_zm":
    case "iw7_golf_club_zm_pap2":
    case "iw7_golf_club_zm_pap1":
    case "iw7_golf_club_zm":
    case "iw7_two_headed_axe_zm_pap2":
    case "iw7_two_headed_axe_zm_pap1":
    case "iw7_two_headed_axe_zm":
    case "iw7_katana_zm_pap2":
    case "iw7_katana_zm_pap1":
    case "iw7_nunchucks_zm_pap2":
    case "iw7_nunchucks_zm_pap1":
    case "iw7_katana_zm":
    case "iw7_nunchucks_zm":
    case "iw7_axe_zm_pap2":
    case "iw7_axe_zm_pap1":
    case "iw7_axe_zm":
      return 1;

    default:
      return 0;
  }
}

update_weaponstats_shots(param_00, param_01) {
  if(!self.should_track_weapon_fired) {
    return;
  }

  update_weaponstats("weaponStats", param_00, "shots", param_01);
  var_02 = "personal";
  if(isDefined(level.personal_score_component_name)) {
    var_02 = level.personal_score_component_name;
  }

  scripts\cp\cp_gamescore::update_personal_encounter_performance(var_02, "shots_fired", param_01);
}

update_weaponstats_kills(param_00, param_01) {
  update_weaponstats("weaponStats", param_00, "kills", param_01);
}

update_weaponstats(param_00, param_01, param_02, param_03) {
  if(!isplayer(self)) {
    return;
  }

  var_04 = get_base_weapon_name(param_01);
  if(!isDefined(var_04) || !isDefined(self.persistence_weaponstats[var_04])) {
    return;
  }

  if(isDefined(level.weapon_stats_override_name_func)) {
    var_04 = [[level.weapon_stats_override_name_func]](var_04);
  }

  if(issubstr(var_04, "dlc")) {
    var_05 = strtok(var_04, "d");
    var_04 = var_05[0] + "DLC";
    var_05 = strtok(var_05[1], "c");
    var_04 = var_04 + var_05[1];
  }

  var_06 = int(self getplayerdata("cp", param_00, var_04, param_02));
  var_07 = var_06 + int(param_03);
  self setplayerdata("cp", param_00, var_04, param_02, var_07);
}

player_weaponstats_track_shots() {
  self endon("disconnect");
  self notify("weaponstats_track_shots");
  self endon("weaponstats_track_shots");
  for(;;) {
    self waittill("weapon_fired", var_00);
    if(!isDefined(var_00)) {
      continue;
    }

    var_01 = 1;
    update_weaponstats_shots(var_00, var_01);
  }
}

rank_init() {
  if(!isDefined(level.zombie_ranks_table)) {
    level.zombie_ranks_table = "cp\zombies\rankTable.csv";
  }

  level.zombie_ranks = [];
  level.zombie_max_rank = int(tablelookup(level.zombie_ranks_table, 0, "maxrank", 1));
  for(var_00 = 0; var_00 <= level.zombie_max_rank; var_00++) {
    var_01 = get_ref_by_id(var_00);
    if(var_01 == "") {
      break;
    }

    if(!isDefined(level.zombie_ranks[var_00])) {
      var_02 = spawnStruct();
      var_02.id = var_00;
      var_02.ref = var_01;
      var_02.lvl = get_level_by_id(var_00);
      var_02.icon = get_icon_by_id(var_00);
      var_02.tokenreward = get_token_reward_by_id(var_00);
      var_02.xp = [];
      var_02.xp["min"] = get_minxp_by_id(var_00);
      var_02.xp["next"] = get_nextxp_by_id(var_00);
      var_02.xp["max"] = get_maxxp_by_id(var_00);
      var_02.name = [];
      var_02.name["short"] = get_shortrank_by_id(var_00);
      var_02.name["full"] = get_fullrank_by_id(var_00);
      var_02.name["ingame"] = get_ingamerank_by_id(var_00);
      level.zombie_ranks[var_00] = var_02;
    }
  }
}

get_ref_by_id(param_00) {
  return tablelookup(level.zombie_ranks_table, 0, param_00, 1);
}

get_minxp_by_id(param_00) {
  return int(tablelookup(level.zombie_ranks_table, 0, param_00, 2));
}

get_maxxp_by_id(param_00) {
  return int(tablelookup(level.zombie_ranks_table, 0, param_00, 7));
}

get_nextxp_by_id(param_00) {
  return int(tablelookup(level.zombie_ranks_table, 0, param_00, 3));
}

get_level_by_id(param_00) {
  return int(tablelookup(level.zombie_ranks_table, 0, param_00, 14));
}

get_shortrank_by_id(param_00) {
  return tablelookup(level.zombie_ranks_table, 0, param_00, 4);
}

get_fullrank_by_id(param_00) {
  return tablelookup(level.zombie_ranks_table, 0, param_00, 5);
}

get_ingamerank_by_id(param_00) {
  return tablelookup(level.zombie_ranks_table, 0, param_00, 17);
}

get_icon_by_id(param_00) {
  return tablelookup(level.zombie_ranks_table, 0, param_00, 6);
}

get_token_reward_by_id(param_00) {
  return int(tablelookup(level.zombie_ranks_table, 0, param_00, 19));
}

get_splash_by_id(param_00) {
  return tablelookup(level.zombie_ranks_table, 0, param_00, 8);
}

get_player_rank() {
  return self getplayerdata("cp", "progression", "playerLevel", "rank");
}

get_player_xp() {
  return self getplayerdata("cp", "progression", "playerLevel", "xp");
}

get_player_prestige() {
  return self getplayerdata("cp", "progression", "playerLevel", "prestige");
}

get_player_session_xp() {
  return self getplayerdata("cp", "alienSession", "experience");
}

set_player_session_xp(param_00) {
  self setplayerdata("cp", "alienSession", "experience", param_00);
}

give_player_session_xp(param_00) {
  var_01 = get_player_session_xp();
  var_02 = param_00 + var_01;
  set_player_session_xp(var_02);
}

get_player_session_tokens() {
  return self getplayerdata("cp", "alienSession", "shots");
}

set_player_session_tokens(param_00) {
  self setplayerdata("cp", "alienSession", "shots", param_00);
}

give_player_session_tokens(param_00) {
  var_01 = get_player_session_tokens();
  var_02 = param_00 + var_01;
  set_player_session_tokens(var_02);
}

set_player_session_rankup(param_00) {
  self setplayerdata("cp", "alienSession", "ranked_up", int(param_00));
}

get_player_session_rankup() {
  return self getplayerdata("cp", "alienSession", "ranked_up");
}

update_player_session_rankup(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  var_01 = get_player_session_rankup();
  var_02 = param_00 + var_01;
  set_player_session_rankup(var_02);
}

set_player_rank(param_00) {
  self setplayerdata("cp", "progression", "playerLevel", "rank", param_00);
}

set_player_xp(param_00) {
  self setplayerdata("cp", "progression", "playerLevel", "xp", param_00);
  if(isDefined(self.totalxpearned)) {
    self setplayerdata("common", "round", "totalXp", self.totalxpearned);
  }
}

set_player_prestige(param_00) {
  self setplayerdata("cp", "progression", "playerLevel", "prestige", param_00);
  self setplayerdata("cp", "progression", "playerLevel", "xp", 0);
  self setplayerdata("cp", "progression", "playerLevel", "rank", 0);
}

get_rank_by_xp(param_00) {
  var_01 = 0;
  if(param_00 >= level.zombie_ranks[level.zombie_max_rank].xp["max"]) {
    return level.zombie_max_rank;
  }

  if(isDefined(level.zombie_ranks)) {
    for(var_02 = 0; var_02 < level.zombie_ranks.size; var_02++) {
      if(param_00 >= level.zombie_ranks[var_02].xp["min"]) {
        if(param_00 < level.zombie_ranks[var_02].xp["max"]) {
          var_01 = level.zombie_ranks[var_02].id;
          break;
        }
      }
    }
  }

  return var_01;
}

get_scaled_xp(param_00, param_01) {
  return int(param_01 * get_level_xp_scale(param_00) * get_weapon_passive_xp_scale(param_00));
}

get_level_xp_scale(param_00) {
  if(isDefined(param_00.xpscale)) {
    return param_00.xpscale;
  }

  return 1;
}

wait_and_give_player_xp(param_00, param_01) {
  self endon("disconnect");
  level endon("game_ended");
  wait(param_01);
  give_player_xp(param_00);
}

get_weapon_passive_xp_scale(param_00) {
  if(isDefined(param_00.weapon_passive_xp_multiplier) && scripts\engine\utility::istrue(param_00.kill_with_extra_xp_passive)) {
    param_00.kill_with_extra_xp_passive = 0;
    return param_00.weapon_passive_xp_multiplier;
  }

  return 1;
}

give_player_xp(param_00, param_01) {
  if(!level.onlinegame) {
    return;
  }

  param_00 = get_scaled_xp(self, param_00);
  if(isDefined(self.totalxpearned)) {
    self.totalxpearned = self.totalxpearned + param_00;
    scripts\cp\zombies\zombie_analytics::log_session_xp_earned(param_00, self.totalxpearned, self, level.wave_num);
  }

  thread give_player_session_xp(param_00);
  var_02 = 0;
  var_03 = get_player_rank();
  var_04 = get_player_xp();
  var_05 = var_04 + param_00;
  set_player_xp(var_05);
  if(scripts\engine\utility::istrue(param_01) && param_00 > 0) {
    self setclientomnvar("zom_xp_reward", param_00);
    self setclientomnvar("zom_xp_notify", gettime());
  }

  var_06 = get_rank_by_xp(var_05);
  if(var_06 > var_03) {
    if(var_06 == level.zombie_max_rank + 1) {
      var_02 = 1;
    }

    set_player_rank(var_06);
    if(var_02 == 0) {
      var_07 = var_06 + 1;
      var_08 = get_splash_by_id(var_06);
      thread scripts\cp\cp_hud_message::showsplash(var_08, var_07);
      self notify("ranked_up", var_06);
      update_player_session_rankup();
    }

    self setrank(get_player_rank(), get_player_prestige());
    process_rank_merits(var_06);
  }
}

process_rank_merits(param_00) {
  scripts\cp\cp_merits::processmerit("mt_prestige_1");
  if(param_00 >= 40) {
    scripts\cp\cp_merits::processmerit("mt_prestige_2");
  }

  if(param_00 >= 60) {
    scripts\cp\cp_merits::processmerit("mt_prestige_3");
  }

  if(param_00 >= 80) {
    scripts\cp\cp_merits::processmerit("mt_prestige_4");
  }

  if(param_00 >= 100) {
    scripts\cp\cp_merits::processmerit("mt_prestige_5");
  }

  if(param_00 >= 120) {
    scripts\cp\cp_merits::processmerit("mt_prestige_6");
  }

  if(param_00 >= 140) {
    scripts\cp\cp_merits::processmerit("mt_prestige_7");
  }

  if(param_00 >= 160) {
    scripts\cp\cp_merits::processmerit("mt_prestige_8");
  }

  if(param_00 >= 180) {
    scripts\cp\cp_merits::processmerit("mt_prestige_9");
  }

  if(param_00 >= 200) {
    scripts\cp\cp_merits::processmerit("mt_prestige_10");
  }
}

inc_stat(param_00, param_01, param_02) {
  var_03 = self getplayerdata("cp", param_00, param_01);
  var_04 = var_03 + param_02;
  self setplayerdata("cp", param_00, param_01, var_04);
}

inc_session_stat(param_00, param_01) {
  inc_stat("alienSession", param_00, param_01);
}

get_hives_destroyed_stat() {
  return get_aliensession_stat("hivesDestroyed");
}

get_aliensession_stat(param_00) {
  return self getplayerdata("cp", "alienSession", param_00);
}

set_aliensession_stat(param_00, param_01) {
  self setplayerdata("cp", "alienSession", param_00, param_01);
}

update_deployable_box_performance(param_00) {
  if(isDefined(level.update_deployable_box_performance_func)) {
    param_00[[level.update_deployable_box_performance_func]]();
    return;
  }

  param_00 scripts\cp\cp_gamescore::update_personal_encounter_performance(scripts\cp\cp_gamescore::get_team_score_component_name(), "team_support_deploy");
}

update_lb_aliensession_challenge(param_00) {
  foreach(var_02 in level.players) {
    var_02 lb_player_update_stat("challengesAttempted", 1);
    if(param_00) {
      var_02 lb_player_update_stat("challengesCompleted", 1);
    }
  }
}

update_lb_aliensession_wave(param_00) {
  foreach(var_02 in level.players) {
    var_02 lb_player_update_stat("waveNum", param_00, 1);
  }
}

update_lb_aliensession_escape(param_00, param_01) {
  var_02 = get_lb_escape_rank(param_01);
  foreach(var_04 in param_00) {
    var_04 lb_player_update_stat("escapedRank" + var_02, 1, 1);
    var_04 lb_player_update_stat("hits", 1, 1);
  }
}

update_alien_kill_sessionstats(param_00, param_01) {
  if(!isDefined(param_01) || !isplayer(param_01)) {
    return;
  }

  if(scripts\cp\utility::is_trap(param_00)) {
    param_01 lb_player_update_stat("trapKills", 1);
  }
}

register_lb_escape_rank(param_00) {
  level.escape_rank_array = param_00;
}

get_lb_escape_rank(param_00) {
  for(var_01 = 0; var_01 < level.escape_rank_array.size - 1; var_01++) {
    if(param_00 >= level.escape_rank_array[var_01] && param_00 < level.escape_rank_array[var_01 + 1]) {
      return var_01;
    }
  }
}

have_clan_tag(param_00) {
  return issubstr(param_00, "[") && issubstr(param_00, "]");
}

remove_clan_tag(param_00) {
  var_01 = strtok(param_00, "]");
  return var_01[1];
}

register_eog_to_lb_playerdata_mapping() {
  var_00 = [];
  var_01["kills"] = "kills";
  var_01["deployables"] = "deployables";
  var_01["drillplants"] = "drillPlants";
  var_01["revives"] = "revives";
  var_01["downs"] = "downed";
  var_01["drillrestarts"] = "repairs";
  var_01["score"] = "score";
  var_01["currencyspent"] = "currencySpent";
  var_01["currencytotal"] = "currencyTotal";
  var_01["hivesdestroyed"] = "hivesDestroyed";
  var_01["waveNum"] = "waveNum";
  level.eog_to_lb_playerdata_mapping = var_01;
}

get_mapped_lb_ref_from_eog_ref(param_00) {
  return level.eog_to_lb_playerdata_mapping[param_00];
}

play_time_monitor() {
  self endon("disconnect");
  for(;;) {
    wait(1);
    lb_player_update_stat("time", 1);
  }
}

record_player_kills(param_00, param_01, param_02, param_03) {
  if(scripts\cp\utility::isheadshot(param_00, param_01, param_02, param_03)) {
    increment_player_career_headshot_kills(param_03);
  }

  param_03 increment_player_career_kills(param_03);
  param_03 eog_player_update_stat("kills", 1);
}

increment_player_career_total_waves(param_00) {
  if(isDefined(param_00.wave_num_when_joined)) {
    increment_zombiecareerstats(param_00, "Total_Waves", level.wave_num - param_00.wave_num_when_joined);
    return;
  }

  increment_zombiecareerstats(param_00, "Total_Waves", level.wave_num);
}

increment_player_career_total_score(param_00) {
  increment_zombiecareerstats(param_00, "Total_Score", param_00.score_earned);
}

increment_player_career_shots_fired(param_00) {
  increment_zombiecareerstats(param_00, "Shots_Fired", 1);
}

increment_player_career_shots_on_target(param_00) {
  increment_zombiecareerstats(param_00, "Shots_on_Target", 1);
}

increment_player_career_explosive_kills(param_00) {
  increment_zombiecareerstats(param_00, "Explosive_Kills", 1);
}

increment_player_career_doors_opened(param_00) {
  increment_zombiecareerstats(param_00, "Doors_Opened", 1);
}

increment_player_career_perks_used(param_00) {
  increment_zombiecareerstats(param_00, "Perks_Used", 1);
}

increment_player_career_kills(param_00) {
  increment_zombiecareerstats(param_00, "Kills", 1);
  updateleaderboardstats(param_00, "Kills", 1, level.script, level.players.size, 1);
}

increment_player_career_headshot_kills(param_00) {
  param_00 increment_zombiecareerstats(param_00, "Headshot_Kills", 1);
  updateleaderboardstats(param_00, "Headshots", 1, level.script, level.players.size, 1);
}

increment_player_career_revives(param_00) {
  param_00 increment_zombiecareerstats(param_00, "Revives", 1);
  updateleaderboardstats(param_00, "Revives", 1, level.script, level.players.size, 1);
}

increment_player_career_downs(param_00) {
  param_00 increment_zombiecareerstats(param_00, "Downs", 1);
  updateleaderboardstats(param_00, "Downs", 1, level.script, level.players.size, 1);
}

update_players_career_highest_wave(param_00, param_01) {
  foreach(var_03 in level.players) {
    update_player_career_highest_wave(var_03, param_00, param_01, level.players.size);
  }
}

update_player_career_highest_wave(param_00, param_01, param_02, param_03) {
  updateifgreaterthan_zombiecareerstats(param_00, "Highest_Wave", param_01);
  update_highest_wave_lb(param_00, param_01, "Highest_Wave", param_02, param_03);
  updateleaderboardstats(param_00, "Rounds", param_01, param_02, param_03, 1);
}

increment_zombiecareerstats(param_00, param_01, param_02) {
  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    return;
  }

  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  var_03 = param_00 getplayerdata("cp", "coopCareerStats", param_01);
  var_04 = var_03 + param_02;
  param_00 setplayerdata("cp", "coopCareerStats", param_01, int(var_04));
}

updateifgreaterthan_zombiecareerstats(param_00, param_01, param_02) {
  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    return;
  }

  var_03 = param_00 getplayerdata("cp", "coopCareerStats", param_01);
  if(param_02 > var_03) {
    param_00 setplayerdata("cp", "coopCareerStats", param_01, param_02);
  }
}

update_highest_wave_lb(param_00, param_01, param_02, param_03, param_04) {
  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    return;
  }

  var_05 = param_00 getplayerdata("cp", "leaderboarddata", param_03, "leaderboardDataPerMap", param_04, param_02);
  if(param_01 > var_05) {
    param_00 setplayerdata("cp", "leaderboarddata", param_03, "leaderboardDataPerMap", param_04, param_02, param_01);
  }
}

updateleaderboardstats(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    return;
  }

  if(!isDefined(param_05)) {
    param_05 = 1;
  }

  var_06 = param_00 getplayerdata("cp", "leaderboarddata", param_03, "leaderboardDataPerMap", param_04, param_01);
  param_02 = var_06 + param_05;
  if(param_02 > var_06) {
    param_00 setplayerdata("cp", "leaderboarddata", param_03, "leaderboardDataPerMap", param_04, param_01, param_02);
  }
}