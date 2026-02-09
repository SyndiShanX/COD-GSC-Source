/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2659.gsc
**************************************/

set_perk(var_0) {
  self[[level.coop_perk_callbacks[var_0].set]]();
}

unset_perk(var_0) {
  self[[level.coop_perk_callbacks[var_0].unset]]();
}

get_player_currency() {
  return self getrankedplayerdata("cp", "alienSession", "currency");
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

wait_to_set_player_currency(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  wait 1.0;
  set_player_currency(var_0);
}

set_player_currency(var_0) {
  self setrankedplayerdata("cp", "alienSession", "currency", int(var_0));
  eog_player_update_stat("currency", int(var_0), 1);
}

give_player_currency(var_0, var_1, var_2, var_3, var_4) {
  if(!isPlayer(self)) {
    return;
  }
  if(!scripts\engine\utility::is_true(var_3)) {
    var_0 = int(var_0 * scripts\cp\perks\prestige::prestige_getmoneyearnedscalar());
    var_0 = scripts\cp\cp_gamescore::round_up_to_nearest(var_0, 5);
  }

  if(isDefined(level.currency_scale_func)) {
    var_0 = [[level.currency_scale_func]](self, var_0);
  }

  var_5 = get_player_currency();
  var_6 = get_player_max_currency();
  var_7 = var_5 + var_0;
  var_7 = min(var_7, var_6);

  if(!isDefined(self.total_currency_earned)) {
    self.total_currency_earned = var_0;
  }

  if(is_valid_give_type(var_4)) {
    self.total_currency_earned = self.total_currency_earned + (var_7 - var_5);
    self notify("consumable_charge", var_0 * 0.5);
  }

  level notify("currency_changed");
  eog_player_update_stat("currencytotal", int(self.total_currency_earned), 1);
  set_player_currency(var_7);

  if(isDefined(level.update_money_performance)) {
    [[level.update_money_performance]](self, var_0);
  }

  var_8 = 30000;
  var_9 = gettime();

  if(var_7 >= var_6) {
    if(!isDefined(self.next_maxmoney_hint_time)) {
      self.next_maxmoney_hint_time = var_9 + var_8;
    } else if(var_9 < self.next_maxmoney_hint_time) {
      return;
    }
    if(!level.gameended) {
      scripts\cp\utility::setlowermessage("maxmoney", &"COOP_GAME_PLAY_MONEY_MAX", 4);
      self.next_maxmoney_hint_time = var_9 + var_8;
    }
  }

  if(is_valid_give_type(var_4)) {
    thread scripts\cp\utility::add_to_notify_queue("player_earned_money", var_0);
  }

  self notify("currency_earned", var_0);
  scripts\cp\utility::bufferednotify("currency_earned_buffered", var_0);
  eog_player_update_stat("score", int(self.total_currency_earned), 1);
}

is_valid_give_type(var_0) {
  if(!isDefined(var_0)) {
    return 1;
  }

  switch (var_0) {
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

take_player_currency(var_0, var_1, var_2, var_3) {
  var_4 = get_player_currency();
  var_5 = max(0, var_4 - var_0);
  var_6 = int(var_4 - var_5);

  if(isDefined(level.chaos_update_spending_currency_event)) {
    [[level.chaos_update_spending_currency_event]](self, var_2, var_3);
  }

  if(scripts\cp\utility::is_consumable_active("next_purchase_free") && var_0 >= 1 && var_2 != "atm" && var_2 != "laststand" && var_2 != "bleedoutPenalty") {
    scripts\cp\utility::notify_used_consumable("next_purchase_free");
  } else {
    set_player_currency(var_5);
  }

  if(var_6 < 1) {
    return;
  }
  if(isDefined(var_2)) {
    scripts\cp\cp_analytics::update_spending_type(var_6, var_2);
  }

  eog_player_update_stat("currencyspent", var_6);

  if(scripts\cp\utility::is_consumable_active("door_buy_refund") && var_0 > 0) {
    if(var_2 != "atm" && var_2 != "laststand" && var_2 != "bleedoutPenalty") {
      give_player_currency(int(var_6 * 0.3), undefined, undefined, 1, "bonus");
      scripts\cp\utility::notify_used_consumable("door_buy_refund");
    }
  }

  if(scripts\cp\cp_interaction::should_interaction_fill_consumable_meter(var_2)) {
    self notify("consumable_charge", var_0 * 0.07);
  }

  if(var_2 != "atm" && var_2 != "laststand" && var_2 != "bleedoutPenalty") {
    scripts\cp\utility::bufferednotify("currency_spent_buffered", var_0);
  }

  if(isDefined(var_1) && var_1) {
    return;
  }
}

player_has_enough_currency(var_0, var_1) {
  if(!isDefined(var_1) || isDefined(var_1) && var_1 != "atm" && var_1 != "laststand" && var_1 != "bleedoutPenalty") {
    if(scripts\cp\utility::is_consumable_active("next_purchase_free")) {
      var_0 = 0;
    }
  }

  var_2 = get_player_currency();
  return var_2 >= var_0;
}

try_take_player_currency(var_0) {
  if(player_has_enough_currency(var_0)) {
    take_player_currency(var_0);
    return 1;
  } else {
    return 0;
  }
}

is_unlocked(var_0) {
  var_1 = undefined;
  var_1 = strtok(var_0, "_")[0];
  var_2 = level.combat_resource[var_0].unlock;
  var_3 = get_player_rank();
  return var_3 >= var_2;
}

player_persistence_init() {
  level.zombie_xp = 1;
  set_player_session_xp(0);
  set_player_session_rankup(0);
  self setrank(get_player_rank(), get_player_prestige());
}

setcoopplayerdata_for_everyone(var_0, var_1, var_2, var_3, var_4) {
  foreach(var_7, var_6 in level.players) {
    if(var_7 == 4) {
      continue;
    }
    if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2) && isDefined(var_3) && isDefined(var_4)) {
      var_6 setrankedplayerdata("cp", var_0, var_1, var_2, var_3, var_4);
      continue;
    }

    if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2) && isDefined(var_3) && !isDefined(var_4)) {
      var_6 setrankedplayerdata("cp", var_0, var_1, var_2, var_3);
      continue;
    }

    if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2) && !isDefined(var_3) && !isDefined(var_4)) {
      var_6 setrankedplayerdata("cp", var_0, var_1, var_2);
      continue;
    }

    if(isDefined(var_0) && isDefined(var_1) && !isDefined(var_2) && !isDefined(var_3) && !isDefined(var_4)) {
      var_6 setrankedplayerdata("cp", var_0, var_1);
      continue;
    }
  }
}

session_stats_init() {
  thread eog_player_tracking_init();
}

eog_player_tracking_init() {
  self endon("disconnect");
  wait 0.5;
  var_0 = self getentitynumber();

  if(var_0 == 4) {
    var_0 = 0;
  }

  var_1 = "unknownPlayer";

  if(isDefined(self.name)) {
    var_1 = self.name;
  }

  if(!level.console) {
    var_1 = getsubstr(var_1, 0, 19);
  } else if(have_clan_tag(var_1)) {
    var_1 = remove_clan_tag(var_1);
  }

  for(var_2 = 0; var_2 < 4; var_2++) {
    self setrankedplayerdata("cp", "EoGPlayer", var_2, "connected", 0);
  }

  foreach(var_4 in level.players) {
    var_4 reset_eog_stats(var_0);
    var_4 setrankedplayerdata("cp", "EoGPlayer", var_0, "connected", 1);
    var_4 setrankedplayerdata("cp", "EoGPlayer", var_0, "name", var_1);
    var_4 setrankedplayerdata("common", "round", "totalXp", 0);
    var_4 setrankedplayerdata("common", "aarUnlockCount", 0);
  }

  var_6 = [0, 0, 0, 0];

  foreach(var_8 in level.players) {
    var_9 = var_8 getentitynumber();

    if(var_9 == 4) {
      var_9 = 0;
    }

    var_6[int(var_9)] = 1;

    if(var_8 == self) {
      continue;
    }
    var_0 = var_8 getentitynumber();

    if(var_0 == 4) {
      var_0 = 0;
    }

    var_10 = var_8 getrankedplayerdata("cp", "EoGPlayer", var_0, "name");
    var_11 = var_8 getrankedplayerdata("cp", "EoGPlayer", var_0, "kills");
    var_12 = var_8 getrankedplayerdata("cp", "EoGPlayer", var_0, "score");
    var_13 = var_8 getrankedplayerdata("cp", "EoGPlayer", var_0, "assists");
    var_14 = var_8 getrankedplayerdata("cp", "EoGPlayer", var_0, "revives");
    var_15 = var_8 getrankedplayerdata("cp", "EoGPlayer", var_0, "drillrestarts");
    var_16 = var_8 getrankedplayerdata("cp", "EoGPlayer", var_0, "drillplants");
    var_17 = var_8 getrankedplayerdata("cp", "EoGPlayer", var_0, "downs");
    var_18 = var_8 getrankedplayerdata("cp", "EoGPlayer", var_0, "deaths");
    var_19 = var_8 getrankedplayerdata("cp", "EoGPlayer", var_0, "hivesdestroyed");
    var_20 = var_8 getrankedplayerdata("cp", "EoGPlayer", var_0, "currency");
    var_21 = var_8 getrankedplayerdata("cp", "EoGPlayer", var_0, "currencyspent");
    var_22 = var_8 getrankedplayerdata("cp", "EoGPlayer", var_0, "currencytotal");
    var_23 = var_8 getrankedplayerdata("cp", "EoGPlayer", var_0, "currency");
    var_24 = var_8 getrankedplayerdata("cp", "EoGPlayer", var_0, "currencyspent");
    var_25 = var_8 getrankedplayerdata("cp", "EoGPlayer", var_0, "currencytotal");
    var_26 = var_8 getrankedplayerdata("cp", "EoGPlayer", var_0, "traps");
    var_27 = var_8 getrankedplayerdata("cp", "EoGPlayer", var_0, "deployables");
    var_28 = var_8 getrankedplayerdata("cp", "EoGPlayer", var_0, "deployablesused");
    var_29 = var_8 getrankedplayerdata("cp", "EoGPlayer", var_0, "consumablesearned");
    var_30 = var_8 getrankedplayerdata("cp", "EoGPlayer", var_0, "headShots");
    var_31 = var_8 getrankedplayerdata("cp", "EoGPlayer", var_0, "connected");
    self setrankedplayerdata("cp", "EoGPlayer", var_0, "name", var_10);
    self setrankedplayerdata("cp", "EoGPlayer", var_0, "kills", var_11);
    self setrankedplayerdata("cp", "EoGPlayer", var_0, "score", var_12);
    self setrankedplayerdata("cp", "EoGPlayer", var_0, "assists", var_13);
    self setrankedplayerdata("cp", "EoGPlayer", var_0, "revives", var_14);
    self setrankedplayerdata("cp", "EoGPlayer", var_0, "drillrestarts", var_15);
    self setrankedplayerdata("cp", "EoGPlayer", var_0, "drillplants", var_16);
    self setrankedplayerdata("cp", "EoGPlayer", var_0, "downs", var_17);
    self setrankedplayerdata("cp", "EoGPlayer", var_0, "deaths", var_18);
    self setrankedplayerdata("cp", "EoGPlayer", var_0, "hivesdestroyed", var_19);
    self setrankedplayerdata("cp", "EoGPlayer", var_0, "currency", var_20);
    self setrankedplayerdata("cp", "EoGPlayer", var_0, "currencyspent", var_21);
    self setrankedplayerdata("cp", "EoGPlayer", var_0, "currencytotal", var_22);
    self setrankedplayerdata("cp", "EoGPlayer", var_0, "tickets", var_23);
    self setrankedplayerdata("cp", "EoGPlayer", var_0, "ticketsspent", var_24);
    self setrankedplayerdata("cp", "EoGPlayer", var_0, "tickettotal", var_25);
    self setrankedplayerdata("cp", "EoGPlayer", var_0, "traps", var_26);
    self setrankedplayerdata("cp", "EoGPlayer", var_0, "deployables", var_27);
    self setrankedplayerdata("cp", "EoGPlayer", var_0, "deployablesused", var_28);
    self setrankedplayerdata("cp", "EoGPlayer", var_0, "consumablesearned", var_29);
    self setrankedplayerdata("cp", "EoGPlayer", var_0, "headShots", var_30);
    self setrankedplayerdata("cp", "EoGPlayer", var_0, "connected", var_31);
  }

  foreach(var_35, var_34 in var_6) {
    if(!var_34) {
      reset_eog_stats(var_35);
    }
  }
}

reset_eog_stats(var_0) {
  if(var_0 == 4) {
    var_0 = 0;
  }

  self setrankedplayerdata("cp", "EoGPlayer", var_0, "name", "");
  self setrankedplayerdata("cp", "EoGPlayer", var_0, "kills", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_0, "score", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_0, "assists", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_0, "revives", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_0, "drillrestarts", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_0, "drillplants", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_0, "downs", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_0, "deaths", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_0, "hivesdestroyed", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_0, "currency", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_0, "currencyspent", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_0, "currencytotal", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_0, "tickets", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_0, "ticketsspent", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_0, "tickettotal", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_0, "traps", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_0, "deployables", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_0, "deployablesused", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_0, "consumablesearned", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_0, "headShots", 0);
}

eog_update_on_player_disconnect(var_0) {
  if(scripts\cp\cp_gamelogic::gamealreadyended()) {
    return;
  }
  var_1 = var_0 getentitynumber();
  setcoopplayerdata_for_everyone("EoGPlayer", var_1, "connected", 0);
}

eog_player_update_stat(var_0, var_1, var_2) {
  var_3 = self getentitynumber();
  var_4 = var_1;

  if(!isDefined(var_2) || !var_2) {
    var_5 = self getrankedplayerdata("cp", "EoGPlayer", var_3, var_0);
    var_4 = int(var_5) + int(var_1);
  }

  try_update_lb_playerdata(var_0, var_4, 1);

  if(var_3 == 4) {
    var_3 = 0;
  }

  setcoopplayerdata_for_everyone("EoGPlayer", var_3, var_0, var_4);
}

try_update_lb_playerdata(var_0, var_1, var_2) {
  var_3 = get_mapped_lb_ref_from_eog_ref(var_0);

  if(!isDefined(var_3)) {
    return;
  }
  lb_player_update_stat(var_3, var_1, var_2);
}

lb_player_update_stat(var_0, var_1, var_2) {
  if(scripts\engine\utility::is_true(var_2)) {
    var_3 = var_1;
  } else {
    var_4 = self getrankedplayerdata("cp", "alienSession", var_0);
    var_3 = var_4 + var_1;
  }

  self setrankedplayerdata("cp", "alienSession", var_0, var_3);
}

weapons_tracking_init() {
  self.persistence_weaponstats = [];

  foreach(var_3, var_1 in level.collectibles) {
    if(strtok(var_3, "_")[0] == "weapon") {
      var_2 = get_base_weapon_name(var_3);
      self.persistence_weaponstats[var_2] = 1;
    }
  }

  thread player_weaponstats_track_shots();
}

get_base_weapon_name(var_0) {
  var_1 = "";
  var_2 = strtok(var_0, "_");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(var_4 == "weapon" && var_3 == 0) {
      continue;
    }
    if(var_4 == "zm") {
      var_1 = var_1 + "zm";
      break;
    }

    if(var_3 < var_2.size - 1) {
      var_1 = var_1 + (var_4 + "_");
      continue;
    }

    var_1 = var_1 + var_4;
    break;
  }

  if(var_1 == "") {
    return "none";
  }

  return var_1;
}

weaponstats_reset(var_0, var_1) {
  self setrankedplayerdata("cp", var_0, var_1, "hits", 0);
  self setrankedplayerdata("cp", var_0, var_1, "shots", 0);
  self setrankedplayerdata("cp", var_0, var_1, "kills", 0);
}

update_weaponstats_hits(var_0, var_1, var_2) {
  if(!is_valid_weapon_hit(var_0, var_2)) {
    return;
  }
  update_weaponstats("weaponStats", var_0, "hits", var_1);
  var_3 = "personal";

  if(isDefined(level.personal_score_component_name)) {
    var_3 = level.personal_score_component_name;
  }

  scripts\cp\cp_gamescore::update_personal_encounter_performance(var_3, "shots_hit", var_1);
}

is_valid_weapon_hit(var_0, var_1) {
  if(var_0 == "none") {
    return 0;
  }

  if(var_1 == "MOD_MELEE") {
    return 0;
  }

  if(no_weapon_fired_notify(var_0)) {
    return 0;
  }

  return 1;
}

no_weapon_fired_notify(var_0) {
  switch (var_0) {
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

update_weaponstats_shots(var_0, var_1) {
  if(!self.should_track_weapon_fired) {
    return;
  }
  update_weaponstats("weaponStats", var_0, "shots", var_1);
  var_2 = "personal";

  if(isDefined(level.personal_score_component_name)) {
    var_2 = level.personal_score_component_name;
  }

  scripts\cp\cp_gamescore::update_personal_encounter_performance(var_2, "shots_fired", var_1);
}

update_weaponstats_kills(var_0, var_1) {
  update_weaponstats("weaponStats", var_0, "kills", var_1);
}

update_weaponstats(var_0, var_1, var_2, var_3) {
  if(!isPlayer(self)) {
    return;
  }
  var_4 = get_base_weapon_name(var_1);

  if(!isDefined(var_4) || !isDefined(self.persistence_weaponstats[var_4])) {
    return;
  }
  if(isDefined(level.weapon_stats_override_name_func)) {
    var_4 = [[level.weapon_stats_override_name_func]](var_4);
  }

  if(issubstr(var_4, "dlc")) {
    var_5 = strtok(var_4, "d");
    var_4 = var_5[0] + "DLC";
    var_5 = strtok(var_5[1], "c");
    var_4 = var_4 + var_5[1];
  }

  var_6 = int(self getrankedplayerdata("cp", var_0, var_4, var_2));
  var_7 = var_6 + int(var_3);
  self setrankedplayerdata("cp", var_0, var_4, var_2, var_7);
}

player_weaponstats_track_shots() {
  self endon("disconnect");
  self notify("weaponstats_track_shots");
  self endon("weaponstats_track_shots");

  for(;;) {
    self waittill("weapon_fired", var_0);

    if(!isDefined(var_0)) {
      continue;
    }
    var_1 = 1;
    update_weaponstats_shots(var_0, var_1);
  }
}

rank_init() {
  if(!isDefined(level.zombie_ranks_table)) {
    level.zombie_ranks_table = "cp\zombies\rankTable.csv";
  }

  level.zombie_ranks = [];
  level.zombie_max_rank = int(tablelookup(level.zombie_ranks_table, 0, "maxrank", 1));

  for(var_0 = 0; var_0 <= level.zombie_max_rank; var_0++) {
    var_1 = get_ref_by_id(var_0);

    if(var_1 == "") {
      break;
    }
    if(!isDefined(level.zombie_ranks[var_0])) {
      var_2 = spawnStruct();
      var_2.id = var_0;
      var_2.ref = var_1;
      var_2.lvl = get_level_by_id(var_0);
      var_2.icon = get_icon_by_id(var_0);
      var_2.tokenreward = get_token_reward_by_id(var_0);
      var_2.xp = [];
      var_2.xp["min"] = get_minxp_by_id(var_0);
      var_2.xp["next"] = get_nextxp_by_id(var_0);
      var_2.xp["max"] = get_maxxp_by_id(var_0);
      var_2.name = [];
      var_2.name["short"] = get_shortrank_by_id(var_0);
      var_2.name["full"] = get_fullrank_by_id(var_0);
      var_2.name["ingame"] = get_ingamerank_by_id(var_0);
      level.zombie_ranks[var_0] = var_2;
    }
  }
}

get_ref_by_id(var_0) {
  return tablelookup(level.zombie_ranks_table, 0, var_0, 1);
}

get_minxp_by_id(var_0) {
  return int(tablelookup(level.zombie_ranks_table, 0, var_0, 2));
}

get_maxxp_by_id(var_0) {
  return int(tablelookup(level.zombie_ranks_table, 0, var_0, 7));
}

get_nextxp_by_id(var_0) {
  return int(tablelookup(level.zombie_ranks_table, 0, var_0, 3));
}

get_level_by_id(var_0) {
  return int(tablelookup(level.zombie_ranks_table, 0, var_0, 14));
}

get_shortrank_by_id(var_0) {
  return tablelookup(level.zombie_ranks_table, 0, var_0, 4);
}

get_fullrank_by_id(var_0) {
  return tablelookup(level.zombie_ranks_table, 0, var_0, 5);
}

get_ingamerank_by_id(var_0) {
  return tablelookup(level.zombie_ranks_table, 0, var_0, 17);
}

get_icon_by_id(var_0) {
  return tablelookup(level.zombie_ranks_table, 0, var_0, 6);
}

get_token_reward_by_id(var_0) {
  return int(tablelookup(level.zombie_ranks_table, 0, var_0, 19));
}

get_splash_by_id(var_0) {
  return tablelookup(level.zombie_ranks_table, 0, var_0, 8);
}

get_player_rank() {
  return self getrankedplayerdata("cp", "progression", "playerLevel", "rank");
}

get_player_xp() {
  return self getrankedplayerdata("cp", "progression", "playerLevel", "xp");
}

get_player_prestige() {
  return self getrankedplayerdata("cp", "progression", "playerLevel", "prestige");
}

get_player_session_xp() {
  return self getrankedplayerdata("cp", "alienSession", "experience");
}

set_player_session_xp(var_0) {
  self setrankedplayerdata("cp", "alienSession", "experience", var_0);
}

give_player_session_xp(var_0) {
  var_1 = get_player_session_xp();
  var_2 = var_0 + var_1;
  set_player_session_xp(var_2);
}

get_player_session_tokens() {
  return self getrankedplayerdata("cp", "alienSession", "shots");
}

set_player_session_tokens(var_0) {
  self setrankedplayerdata("cp", "alienSession", "shots", var_0);
}

give_player_session_tokens(var_0) {
  var_1 = get_player_session_tokens();
  var_2 = var_0 + var_1;
  set_player_session_tokens(var_2);
}

set_player_session_rankup(var_0) {
  self setrankedplayerdata("cp", "alienSession", "ranked_up", int(var_0));
}

get_player_session_rankup() {
  return self getrankedplayerdata("cp", "alienSession", "ranked_up");
}

update_player_session_rankup(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  var_1 = get_player_session_rankup();
  var_2 = var_0 + var_1;
  set_player_session_rankup(var_2);
}

set_player_rank(var_0) {
  self setrankedplayerdata("cp", "progression", "playerLevel", "rank", var_0);
}

set_player_xp(var_0) {
  self setrankedplayerdata("cp", "progression", "playerLevel", "xp", var_0);

  if(isDefined(self.totalxpearned)) {
    self setrankedplayerdata("common", "round", "totalXp", self.totalxpearned);
  }
}

set_player_prestige(var_0) {
  self setrankedplayerdata("cp", "progression", "playerLevel", "prestige", var_0);
  self setrankedplayerdata("cp", "progression", "playerLevel", "xp", 0);
  self setrankedplayerdata("cp", "progression", "playerLevel", "rank", 0);
}

get_rank_by_xp(var_0) {
  var_1 = 0;

  if(var_0 >= level.zombie_ranks[level.zombie_max_rank].xp["max"]) {
    return level.zombie_max_rank;
  }

  if(isDefined(level.zombie_ranks)) {
    for(var_2 = 0; var_2 < level.zombie_ranks.size; var_2++) {
      if(var_0 >= level.zombie_ranks[var_2].xp["min"]) {
        if(var_0 < level.zombie_ranks[var_2].xp["max"]) {
          var_1 = level.zombie_ranks[var_2].id;
          break;
        }
      }
    }
  }

  return var_1;
}

get_scaled_xp(var_0, var_1) {
  return int(var_1 * get_level_xp_scale(var_0) * get_weapon_passive_xp_scale(var_0));
}

get_level_xp_scale(var_0) {
  if(isDefined(var_0.xpscale)) {
    return var_0.xpscale;
  } else {
    return 1;
  }
}

wait_and_give_player_xp(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  wait(var_1);
  give_player_xp(var_0);
}

get_weapon_passive_xp_scale(var_0) {
  if(isDefined(var_0.weapon_passive_xp_multiplier) && scripts\engine\utility::is_true(var_0.kill_with_extra_xp_passive)) {
    var_0.kill_with_extra_xp_passive = 0;
    return var_0.weapon_passive_xp_multiplier;
  } else {
    return 1;
  }
}

give_player_xp(var_0, var_1) {
  if(!level.onlinegame) {
    return;
  }
  var_0 = get_scaled_xp(self, var_0);

  if(isDefined(self.totalxpearned)) {
    self.totalxpearned = self.totalxpearned + var_0;
    scripts\cp\zombies\zombie_analytics::log_session_xp_earned(var_0, self.totalxpearned, self, level.wave_num);
  }

  thread give_player_session_xp(var_0);
  var_2 = 0;
  var_3 = get_player_rank();
  var_4 = get_player_xp();
  var_5 = var_4 + var_0;
  set_player_xp(var_5);

  if(scripts\engine\utility::is_true(var_1) && var_0 > 0) {
    self setclientomnvar("zom_xp_reward", var_0);
    self setclientomnvar("zom_xp_notify", gettime());
  }

  var_6 = get_rank_by_xp(var_5);

  if(var_6 > var_3) {
    if(var_6 == level.zombie_max_rank + 1) {
      var_2 = 1;
    }

    set_player_rank(var_6);

    if(var_2 == 0) {
      var_7 = var_6 + 1;
      var_8 = get_splash_by_id(var_6);
      thread scripts\cp\cp_hud_message::showsplash(var_8, var_7);
      self notify("ranked_up", var_6);
      update_player_session_rankup();
    }

    self setrank(get_player_rank(), get_player_prestige());
    process_rank_merits(var_6);
  }
}

process_rank_merits(var_0) {
  scripts\cp\cp_merits::processmerit("mt_prestige_1");

  if(var_0 >= 40) {
    scripts\cp\cp_merits::processmerit("mt_prestige_2");
  }

  if(var_0 >= 60) {
    scripts\cp\cp_merits::processmerit("mt_prestige_3");
  }

  if(var_0 >= 80) {
    scripts\cp\cp_merits::processmerit("mt_prestige_4");
  }

  if(var_0 >= 100) {
    scripts\cp\cp_merits::processmerit("mt_prestige_5");
  }

  if(var_0 >= 120) {
    scripts\cp\cp_merits::processmerit("mt_prestige_6");
  }

  if(var_0 >= 140) {
    scripts\cp\cp_merits::processmerit("mt_prestige_7");
  }

  if(var_0 >= 160) {
    scripts\cp\cp_merits::processmerit("mt_prestige_8");
  }

  if(var_0 >= 180) {
    scripts\cp\cp_merits::processmerit("mt_prestige_9");
  }

  if(var_0 >= 200) {
    scripts\cp\cp_merits::processmerit("mt_prestige_10");
  }
}

inc_stat(var_0, var_1, var_2) {
  var_3 = self getrankedplayerdata("cp", var_0, var_1);
  var_4 = var_3 + var_2;
  self setrankedplayerdata("cp", var_0, var_1, var_4);
}

inc_session_stat(var_0, var_1) {
  inc_stat("alienSession", var_0, var_1);
}

get_hives_destroyed_stat() {
  return get_aliensession_stat("hivesDestroyed");
}

get_aliensession_stat(var_0) {
  return self getrankedplayerdata("cp", "alienSession", var_0);
}

set_aliensession_stat(var_0, var_1) {
  self setrankedplayerdata("cp", "alienSession", var_0, var_1);
}

update_deployable_box_performance(var_0) {
  if(isDefined(level.update_deployable_box_performance_func)) {
    var_0[[level.update_deployable_box_performance_func]]();
  } else {
    var_0 scripts\cp\cp_gamescore::update_personal_encounter_performance(scripts\cp\cp_gamescore::get_team_score_component_name(), "team_support_deploy");
  }
}

update_lb_aliensession_challenge(var_0) {
  foreach(var_2 in level.players) {
    var_2 lb_player_update_stat("challengesAttempted", 1);

    if(var_0) {
      var_2 lb_player_update_stat("challengesCompleted", 1);
    }
  }
}

update_lb_aliensession_wave(var_0) {
  foreach(var_2 in level.players) {
    var_2 lb_player_update_stat("waveNum", var_0, 1);
  }
}

update_lb_aliensession_escape(var_0, var_1) {
  var_2 = get_lb_escape_rank(var_1);

  foreach(var_4 in var_0) {
    var_4 lb_player_update_stat("escapedRank" + var_2, 1, 1);
    var_4 lb_player_update_stat("hits", 1, 1);
  }
}

update_alien_kill_sessionstats(var_0, var_1) {
  if(!isDefined(var_1) || !isPlayer(var_1)) {
    return;
  }
  if(scripts\cp\utility::is_trap(var_0)) {
    var_1 lb_player_update_stat("trapKills", 1);
  }
}

register_lb_escape_rank(var_0) {
  level.escape_rank_array = var_0;
}

get_lb_escape_rank(var_0) {
  for(var_1 = 0; var_1 < level.escape_rank_array.size - 1; var_1++) {
    if(var_0 >= level.escape_rank_array[var_1] && var_0 < level.escape_rank_array[var_1 + 1]) {
      return var_1;
    }
  }
}

have_clan_tag(var_0) {
  return issubstr(var_0, "[") && issubstr(var_0, "]");
}

remove_clan_tag(var_0) {
  var_1 = strtok(var_0, "]");
  return var_1[1];
}

register_eog_to_lb_playerdata_mapping() {
  var_0 = [];
  var_1["kills"] = "kills";
  var_1["deployables"] = "deployables";
  var_1["drillplants"] = "drillPlants";
  var_1["revives"] = "revives";
  var_1["downs"] = "downed";
  var_1["drillrestarts"] = "repairs";
  var_1["score"] = "score";
  var_1["currencyspent"] = "currencySpent";
  var_1["currencytotal"] = "currencyTotal";
  var_1["hivesdestroyed"] = "hivesDestroyed";
  var_1["waveNum"] = "waveNum";
  level.eog_to_lb_playerdata_mapping = var_1;
}

get_mapped_lb_ref_from_eog_ref(var_0) {
  return level.eog_to_lb_playerdata_mapping[var_0];
}

play_time_monitor() {
  self endon("disconnect");

  for(;;) {
    wait 1;
    lb_player_update_stat("time", 1);
  }
}

record_player_kills(var_0, var_1, var_2, var_3) {
  if(scripts\cp\utility::isheadshot(var_0, var_1, var_2, var_3)) {
    increment_player_career_headshot_kills(var_3);
  }

  var_3 increment_player_career_kills(var_3);
  var_3 eog_player_update_stat("kills", 1);
}

increment_player_career_total_waves(var_0) {
  if(isDefined(var_0.wave_num_when_joined)) {
    increment_zombiecareerstats(var_0, "Total_Waves", level.wave_num - var_0.wave_num_when_joined);
  } else {
    increment_zombiecareerstats(var_0, "Total_Waves", level.wave_num);
  }
}

increment_player_career_total_score(var_0) {
  increment_zombiecareerstats(var_0, "Total_Score", var_0.score_earned);
}

increment_player_career_shots_fired(var_0) {
  increment_zombiecareerstats(var_0, "Shots_Fired", 1);
}

increment_player_career_shots_on_target(var_0) {
  increment_zombiecareerstats(var_0, "Shots_on_Target", 1);
}

increment_player_career_explosive_kills(var_0) {
  increment_zombiecareerstats(var_0, "Explosive_Kills", 1);
}

increment_player_career_doors_opened(var_0) {
  increment_zombiecareerstats(var_0, "Doors_Opened", 1);
}

increment_player_career_perks_used(var_0) {
  increment_zombiecareerstats(var_0, "Perks_Used", 1);
}

increment_player_career_kills(var_0) {
  increment_zombiecareerstats(var_0, "Kills", 1);
  updateleaderboardstats(var_0, "Kills", 1, level.script, level.players.size, 1);
}

increment_player_career_headshot_kills(var_0) {
  var_0 increment_zombiecareerstats(var_0, "Headshot_Kills", 1);
  updateleaderboardstats(var_0, "Headshots", 1, level.script, level.players.size, 1);
}

increment_player_career_revives(var_0) {
  var_0 increment_zombiecareerstats(var_0, "Revives", 1);
  updateleaderboardstats(var_0, "Revives", 1, level.script, level.players.size, 1);
}

increment_player_career_downs(var_0) {
  var_0 increment_zombiecareerstats(var_0, "Downs", 1);
  updateleaderboardstats(var_0, "Downs", 1, level.script, level.players.size, 1);
}

update_players_career_highest_wave(var_0, var_1) {
  foreach(var_3 in level.players) {
    update_player_career_highest_wave(var_3, var_0, var_1, level.players.size);
  }
}

update_player_career_highest_wave(var_0, var_1, var_2, var_3) {
  updateifgreaterthan_zombiecareerstats(var_0, "Highest_Wave", var_1);
  update_highest_wave_lb(var_0, var_1, "Highest_Wave", var_2, var_3);
  updateleaderboardstats(var_0, "Rounds", var_1, var_2, var_3, 1);
}

increment_zombiecareerstats(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = var_0 getrankedplayerdata("cp", "coopCareerStats", var_1);
  var_4 = var_3 + var_2;
  var_0 setrankedplayerdata("cp", "coopCareerStats", var_1, int(var_4));
}

updateifgreaterthan_zombiecareerstats(var_0, var_1, var_2) {
  var_3 = var_0 getrankedplayerdata("cp", "coopCareerStats", var_1);

  if(var_2 > var_3) {
    var_0 setrankedplayerdata("cp", "coopCareerStats", var_1, var_2);
  }
}

update_highest_wave_lb(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0 getrankedplayerdata("cp", "leaderboarddata", var_3, "leaderboardDataPerMap", var_4, var_2);

  if(var_1 > var_5) {
    var_0 setrankedplayerdata("cp", "leaderboarddata", var_3, "leaderboardDataPerMap", var_4, var_2, var_1);
  }
}

updateleaderboardstats(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5)) {
    var_5 = 1;
  }

  var_6 = var_0 getrankedplayerdata("cp", "leaderboarddata", var_3, "leaderboardDataPerMap", var_4, var_1);
  var_2 = var_6 + var_5;

  if(var_2 > var_6) {
    var_0 setrankedplayerdata("cp", "leaderboarddata", var_3, "leaderboardDataPerMap", var_4, var_1, var_2);
  }
}