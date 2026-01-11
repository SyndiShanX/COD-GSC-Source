/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2659.gsc
***************************************/

set_perk(var_00) {
  self[[level.coop_perk_callbacks[var_00].set]]();
}

unset_perk(var_00) {
  self[[level.coop_perk_callbacks[var_00].unset]]();
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

wait_to_set_player_currency(var_00) {
  self endon("disconnect");
  level endon("game_ended");
  wait 1.0;
  set_player_currency(var_00);
}

set_player_currency(var_00) {
  self setrankedplayerdata("cp", "alienSession", "currency", int(var_00));
  eog_player_update_stat("currency", int(var_00), 1);
}

give_player_currency(var_00, var_01, var_02, var_03, var_04) {
  if(!isplayer(self)) {
    return;
  }
  if(!scripts\engine\utility::is_true(var_03)) {
    var_00 = int(var_00 * scripts\cp\perks\prestige::prestige_getmoneyearnedscalar());
    var_00 = scripts\cp\cp_gamescore::round_up_to_nearest(var_00, 5);
  }

  if(isDefined(level.currency_scale_func)) {
    var_00 = [[level.currency_scale_func]](self, var_00);
  }

  var_05 = get_player_currency();
  var_06 = get_player_max_currency();
  var_07 = var_05 + var_00;
  var_07 = min(var_07, var_06);

  if(!isDefined(self.total_currency_earned)) {
    self.total_currency_earned = var_00;
  }

  if(is_valid_give_type(var_04)) {
    self.total_currency_earned = self.total_currency_earned + (var_07 - var_05);
    self notify("consumable_charge", var_00 * 0.5);
  }

  level notify("currency_changed");
  eog_player_update_stat("currencytotal", int(self.total_currency_earned), 1);
  set_player_currency(var_07);

  if(isDefined(level.update_money_performance)) {
    [[level.update_money_performance]](self, var_00);
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

  if(is_valid_give_type(var_04)) {
    thread scripts\cp\utility::add_to_notify_queue("player_earned_money", var_00);
  }

  self notify("currency_earned", var_00);
  scripts\cp\utility::bufferednotify("currency_earned_buffered", var_00);
  eog_player_update_stat("score", int(self.total_currency_earned), 1);
}

is_valid_give_type(var_00) {
  if(!isDefined(var_00)) {
    return 1;
  }

  switch (var_00) {
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

take_player_currency(var_00, var_01, var_02, var_03) {
  var_04 = get_player_currency();
  var_05 = max(0, var_04 - var_00);
  var_06 = int(var_04 - var_05);

  if(isDefined(level.chaos_update_spending_currency_event)) {
    [[level.chaos_update_spending_currency_event]](self, var_02, var_03);
  }

  if(scripts\cp\utility::is_consumable_active("next_purchase_free") && var_00 >= 1 && var_02 != "atm" && var_02 != "laststand" && var_02 != "bleedoutPenalty") {
    scripts\cp\utility::notify_used_consumable("next_purchase_free");
  } else {
    set_player_currency(var_05);
  }

  if(var_06 < 1) {
    return;
  }
  if(isDefined(var_02)) {
    scripts\cp\cp_analytics::update_spending_type(var_06, var_02);
  }

  eog_player_update_stat("currencyspent", var_06);

  if(scripts\cp\utility::is_consumable_active("door_buy_refund") && var_00 > 0) {
    if(var_02 != "atm" && var_02 != "laststand" && var_02 != "bleedoutPenalty") {
      give_player_currency(int(var_06 * 0.3), undefined, undefined, 1, "bonus");
      scripts\cp\utility::notify_used_consumable("door_buy_refund");
    }
  }

  if(scripts\cp\cp_interaction::should_interaction_fill_consumable_meter(var_02)) {
    self notify("consumable_charge", var_00 * 0.07);
  }

  if(var_02 != "atm" && var_02 != "laststand" && var_02 != "bleedoutPenalty") {
    scripts\cp\utility::bufferednotify("currency_spent_buffered", var_00);
  }

  if(isDefined(var_01) && var_01) {
    return;
  }
}

player_has_enough_currency(var_00, var_01) {
  if(!isDefined(var_01) || isDefined(var_01) && var_01 != "atm" && var_01 != "laststand" && var_01 != "bleedoutPenalty") {
    if(scripts\cp\utility::is_consumable_active("next_purchase_free")) {
      var_00 = 0;
    }
  }

  var_02 = get_player_currency();
  return var_02 >= var_00;
}

try_take_player_currency(var_00) {
  if(player_has_enough_currency(var_00)) {
    take_player_currency(var_00);
    return 1;
  } else
    return 0;
}

is_unlocked(var_00) {
  var_01 = undefined;
  var_01 = strtok(var_00, "_")[0];
  var_02 = level.combat_resource[var_00].unlock;
  var_03 = get_player_rank();
  return var_03 >= var_02;
}

player_persistence_init() {
  level.zombie_xp = 1;
  set_player_session_xp(0);
  set_player_session_rankup(0);
  self setrank(get_player_rank(), get_player_prestige());
}

setcoopplayerdata_for_everyone(var_00, var_01, var_02, var_03, var_04) {
  foreach(var_07, var_06 in level.players) {
    if(var_07 == 4) {
      continue;
    }
    if(isDefined(var_00) && isDefined(var_01) && isDefined(var_02) && isDefined(var_03) && isDefined(var_04)) {
      var_06 setrankedplayerdata("cp", var_00, var_01, var_02, var_03, var_04);
      continue;
    }

    if(isDefined(var_00) && isDefined(var_01) && isDefined(var_02) && isDefined(var_03) && !isDefined(var_04)) {
      var_06 setrankedplayerdata("cp", var_00, var_01, var_02, var_03);
      continue;
    }

    if(isDefined(var_00) && isDefined(var_01) && isDefined(var_02) && !isDefined(var_03) && !isDefined(var_04)) {
      var_06 setrankedplayerdata("cp", var_00, var_01, var_02);
      continue;
    }

    if(isDefined(var_00) && isDefined(var_01) && !isDefined(var_02) && !isDefined(var_03) && !isDefined(var_04)) {
      var_06 setrankedplayerdata("cp", var_00, var_01);
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

  for(var_02 = 0; var_02 < 4; var_2++) {
    self setrankedplayerdata("cp", "EoGPlayer", var_02, "connected", 0);
  }

  foreach(var_04 in level.players) {
    var_04 reset_eog_stats(var_00);
    var_04 setrankedplayerdata("cp", "EoGPlayer", var_00, "connected", 1);
    var_04 setrankedplayerdata("cp", "EoGPlayer", var_00, "name", var_01);
    var_04 setrankedplayerdata("common", "round", "totalXp", 0);
    var_04 setrankedplayerdata("common", "aarUnlockCount", 0);
  }

  var_06 = [0, 0, 0, 0];

  foreach(var_08 in level.players) {
    var_09 = var_08 getentitynumber();

    if(var_09 == 4) {
      var_09 = 0;
    }

    var_6[int(var_09)] = 1;

    if(var_08 == self) {
      continue;
    }
    var_00 = var_08 getentitynumber();

    if(var_00 == 4) {
      var_00 = 0;
    }

    var_10 = var_08 getrankedplayerdata("cp", "EoGPlayer", var_00, "name");
    var_11 = var_08 getrankedplayerdata("cp", "EoGPlayer", var_00, "kills");
    var_12 = var_08 getrankedplayerdata("cp", "EoGPlayer", var_00, "score");
    var_13 = var_08 getrankedplayerdata("cp", "EoGPlayer", var_00, "assists");
    var_14 = var_08 getrankedplayerdata("cp", "EoGPlayer", var_00, "revives");
    var_15 = var_08 getrankedplayerdata("cp", "EoGPlayer", var_00, "drillrestarts");
    var_16 = var_08 getrankedplayerdata("cp", "EoGPlayer", var_00, "drillplants");
    var_17 = var_08 getrankedplayerdata("cp", "EoGPlayer", var_00, "downs");
    var_18 = var_08 getrankedplayerdata("cp", "EoGPlayer", var_00, "deaths");
    var_19 = var_08 getrankedplayerdata("cp", "EoGPlayer", var_00, "hivesdestroyed");
    var_20 = var_08 getrankedplayerdata("cp", "EoGPlayer", var_00, "currency");
    var_21 = var_08 getrankedplayerdata("cp", "EoGPlayer", var_00, "currencyspent");
    var_22 = var_08 getrankedplayerdata("cp", "EoGPlayer", var_00, "currencytotal");
    var_23 = var_08 getrankedplayerdata("cp", "EoGPlayer", var_00, "currency");
    var_24 = var_08 getrankedplayerdata("cp", "EoGPlayer", var_00, "currencyspent");
    var_25 = var_08 getrankedplayerdata("cp", "EoGPlayer", var_00, "currencytotal");
    var_26 = var_08 getrankedplayerdata("cp", "EoGPlayer", var_00, "traps");
    var_27 = var_08 getrankedplayerdata("cp", "EoGPlayer", var_00, "deployables");
    var_28 = var_08 getrankedplayerdata("cp", "EoGPlayer", var_00, "deployablesused");
    var_29 = var_08 getrankedplayerdata("cp", "EoGPlayer", var_00, "consumablesearned");
    var_30 = var_08 getrankedplayerdata("cp", "EoGPlayer", var_00, "headShots");
    var_31 = var_08 getrankedplayerdata("cp", "EoGPlayer", var_00, "connected");
    self setrankedplayerdata("cp", "EoGPlayer", var_00, "name", var_10);
    self setrankedplayerdata("cp", "EoGPlayer", var_00, "kills", var_11);
    self setrankedplayerdata("cp", "EoGPlayer", var_00, "score", var_12);
    self setrankedplayerdata("cp", "EoGPlayer", var_00, "assists", var_13);
    self setrankedplayerdata("cp", "EoGPlayer", var_00, "revives", var_14);
    self setrankedplayerdata("cp", "EoGPlayer", var_00, "drillrestarts", var_15);
    self setrankedplayerdata("cp", "EoGPlayer", var_00, "drillplants", var_16);
    self setrankedplayerdata("cp", "EoGPlayer", var_00, "downs", var_17);
    self setrankedplayerdata("cp", "EoGPlayer", var_00, "deaths", var_18);
    self setrankedplayerdata("cp", "EoGPlayer", var_00, "hivesdestroyed", var_19);
    self setrankedplayerdata("cp", "EoGPlayer", var_00, "currency", var_20);
    self setrankedplayerdata("cp", "EoGPlayer", var_00, "currencyspent", var_21);
    self setrankedplayerdata("cp", "EoGPlayer", var_00, "currencytotal", var_22);
    self setrankedplayerdata("cp", "EoGPlayer", var_00, "tickets", var_23);
    self setrankedplayerdata("cp", "EoGPlayer", var_00, "ticketsspent", var_24);
    self setrankedplayerdata("cp", "EoGPlayer", var_00, "tickettotal", var_25);
    self setrankedplayerdata("cp", "EoGPlayer", var_00, "traps", var_26);
    self setrankedplayerdata("cp", "EoGPlayer", var_00, "deployables", var_27);
    self setrankedplayerdata("cp", "EoGPlayer", var_00, "deployablesused", var_28);
    self setrankedplayerdata("cp", "EoGPlayer", var_00, "consumablesearned", var_29);
    self setrankedplayerdata("cp", "EoGPlayer", var_00, "headShots", var_30);
    self setrankedplayerdata("cp", "EoGPlayer", var_00, "connected", var_31);
  }

  foreach(var_35, var_34 in var_06) {
    if(!var_34) {
      reset_eog_stats(var_35);
    }
  }
}

reset_eog_stats(var_00) {
  if(var_00 == 4) {
    var_00 = 0;
  }

  self setrankedplayerdata("cp", "EoGPlayer", var_00, "name", "");
  self setrankedplayerdata("cp", "EoGPlayer", var_00, "kills", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_00, "score", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_00, "assists", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_00, "revives", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_00, "drillrestarts", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_00, "drillplants", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_00, "downs", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_00, "deaths", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_00, "hivesdestroyed", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_00, "currency", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_00, "currencyspent", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_00, "currencytotal", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_00, "tickets", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_00, "ticketsspent", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_00, "tickettotal", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_00, "traps", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_00, "deployables", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_00, "deployablesused", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_00, "consumablesearned", 0);
  self setrankedplayerdata("cp", "EoGPlayer", var_00, "headShots", 0);
}

eog_update_on_player_disconnect(var_00) {
  if(scripts\cp\cp_gamelogic::gamealreadyended()) {
    return;
  }
  var_01 = var_00 getentitynumber();
  setcoopplayerdata_for_everyone("EoGPlayer", var_01, "connected", 0);
}

eog_player_update_stat(var_00, var_01, var_02) {
  var_03 = self getentitynumber();
  var_04 = var_01;

  if(!isDefined(var_02) || !var_02) {
    var_05 = self getrankedplayerdata("cp", "EoGPlayer", var_03, var_00);
    var_04 = int(var_05) + int(var_01);
  }

  try_update_lb_playerdata(var_00, var_04, 1);

  if(var_03 == 4) {
    var_03 = 0;
  }

  setcoopplayerdata_for_everyone("EoGPlayer", var_03, var_00, var_04);
}

try_update_lb_playerdata(var_00, var_01, var_02) {
  var_03 = get_mapped_lb_ref_from_eog_ref(var_00);

  if(!isDefined(var_03)) {
    return;
  }
  lb_player_update_stat(var_03, var_01, var_02);
}

lb_player_update_stat(var_00, var_01, var_02) {
  if(scripts\engine\utility::is_true(var_02)) {
    var_03 = var_01;
  } else {
    var_04 = self getrankedplayerdata("cp", "alienSession", var_00);
    var_03 = var_04 + var_01;
  }

  self setrankedplayerdata("cp", "alienSession", var_00, var_03);
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

get_base_weapon_name(var_00) {
  var_01 = "";
  var_02 = strtok(var_00, "_");

  for(var_03 = 0; var_03 < var_2.size; var_3++) {
    var_04 = var_2[var_03];

    if(var_04 == "weapon" && var_03 == 0) {
      continue;
    }
    if(var_04 == "zm") {
      var_01 = var_01 + "zm";
      break;
    }

    if(var_03 < var_2.size - 1) {
      var_01 = var_01 + (var_04 + "_");
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

weaponstats_reset(var_00, var_01) {
  self setrankedplayerdata("cp", var_00, var_01, "hits", 0);
  self setrankedplayerdata("cp", var_00, var_01, "shots", 0);
  self setrankedplayerdata("cp", var_00, var_01, "kills", 0);
}

update_weaponstats_hits(var_00, var_01, var_02) {
  if(!is_valid_weapon_hit(var_00, var_02)) {
    return;
  }
  update_weaponstats("weaponStats", var_00, "hits", var_01);
  var_03 = "personal";

  if(isDefined(level.personal_score_component_name)) {
    var_03 = level.personal_score_component_name;
  }

  scripts\cp\cp_gamescore::update_personal_encounter_performance(var_03, "shots_hit", var_01);
}

is_valid_weapon_hit(var_00, var_01) {
  if(var_00 == "none") {
    return 0;
  }

  if(var_01 == "MOD_MELEE") {
    return 0;
  }

  if(no_weapon_fired_notify(var_00)) {
    return 0;
  }

  return 1;
}

no_weapon_fired_notify(var_00) {
  switch (var_00) {
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

update_weaponstats_shots(var_00, var_01) {
  if(!self.should_track_weapon_fired) {
    return;
  }
  update_weaponstats("weaponStats", var_00, "shots", var_01);
  var_02 = "personal";

  if(isDefined(level.personal_score_component_name)) {
    var_02 = level.personal_score_component_name;
  }

  scripts\cp\cp_gamescore::update_personal_encounter_performance(var_02, "shots_fired", var_01);
}

update_weaponstats_kills(var_00, var_01) {
  update_weaponstats("weaponStats", var_00, "kills", var_01);
}

update_weaponstats(var_00, var_01, var_02, var_03) {
  if(!isplayer(self)) {
    return;
  }
  var_04 = get_base_weapon_name(var_01);

  if(!isDefined(var_04) || !isDefined(self.persistence_weaponstats[var_04])) {
    return;
  }
  if(isDefined(level.weapon_stats_override_name_func)) {
    var_04 = [[level.weapon_stats_override_name_func]](var_04);
  }

  if(issubstr(var_04, "dlc")) {
    var_05 = strtok(var_04, "d");
    var_04 = var_5[0] + "DLC";
    var_05 = strtok(var_5[1], "c");
    var_04 = var_04 + var_5[1];
  }

  var_06 = int(self getrankedplayerdata("cp", var_00, var_04, var_02));
  var_07 = var_06 + int(var_03);
  self setrankedplayerdata("cp", var_00, var_04, var_02, var_07);
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

  for(var_00 = 0; var_00 <= level.zombie_max_rank; var_0++) {
    var_01 = get_ref_by_id(var_00);

    if(var_01 == "") {
      break;
    }
    if(!isDefined(level.zombie_ranks[var_00])) {
      var_02 = spawnStruct();
      var_2.id = var_00;
      var_2.ref = var_01;
      var_2.lvl = get_level_by_id(var_00);
      var_2.icon = get_icon_by_id(var_00);
      var_2.tokenreward = get_token_reward_by_id(var_00);
      var_2.xp = [];
      var_2.xp["min"] = get_minxp_by_id(var_00);
      var_2.xp["next"] = get_nextxp_by_id(var_00);
      var_2.xp["max"] = get_maxxp_by_id(var_00);
      var_2.name = [];
      var_2.name["short"] = get_shortrank_by_id(var_00);
      var_2.name["full"] = get_fullrank_by_id(var_00);
      var_2.name["ingame"] = get_ingamerank_by_id(var_00);
      level.zombie_ranks[var_00] = var_02;
    }
  }
}

get_ref_by_id(var_00) {
  return tablelookup(level.zombie_ranks_table, 0, var_00, 1);
}

get_minxp_by_id(var_00) {
  return int(tablelookup(level.zombie_ranks_table, 0, var_00, 2));
}

get_maxxp_by_id(var_00) {
  return int(tablelookup(level.zombie_ranks_table, 0, var_00, 7));
}

get_nextxp_by_id(var_00) {
  return int(tablelookup(level.zombie_ranks_table, 0, var_00, 3));
}

get_level_by_id(var_00) {
  return int(tablelookup(level.zombie_ranks_table, 0, var_00, 14));
}

get_shortrank_by_id(var_00) {
  return tablelookup(level.zombie_ranks_table, 0, var_00, 4);
}

get_fullrank_by_id(var_00) {
  return tablelookup(level.zombie_ranks_table, 0, var_00, 5);
}

get_ingamerank_by_id(var_00) {
  return tablelookup(level.zombie_ranks_table, 0, var_00, 17);
}

get_icon_by_id(var_00) {
  return tablelookup(level.zombie_ranks_table, 0, var_00, 6);
}

get_token_reward_by_id(var_00) {
  return int(tablelookup(level.zombie_ranks_table, 0, var_00, 19));
}

get_splash_by_id(var_00) {
  return tablelookup(level.zombie_ranks_table, 0, var_00, 8);
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

set_player_session_xp(var_00) {
  self setrankedplayerdata("cp", "alienSession", "experience", var_00);
}

give_player_session_xp(var_00) {
  var_01 = get_player_session_xp();
  var_02 = var_00 + var_01;
  set_player_session_xp(var_02);
}

get_player_session_tokens() {
  return self getrankedplayerdata("cp", "alienSession", "shots");
}

set_player_session_tokens(var_00) {
  self setrankedplayerdata("cp", "alienSession", "shots", var_00);
}

give_player_session_tokens(var_00) {
  var_01 = get_player_session_tokens();
  var_02 = var_00 + var_01;
  set_player_session_tokens(var_02);
}

set_player_session_rankup(var_00) {
  self setrankedplayerdata("cp", "alienSession", "ranked_up", int(var_00));
}

get_player_session_rankup() {
  return self getrankedplayerdata("cp", "alienSession", "ranked_up");
}

update_player_session_rankup(var_00) {
  if(!isDefined(var_00)) {
    var_00 = 1;
  }

  var_01 = get_player_session_rankup();
  var_02 = var_00 + var_01;
  set_player_session_rankup(var_02);
}

set_player_rank(var_00) {
  self setrankedplayerdata("cp", "progression", "playerLevel", "rank", var_00);
}

set_player_xp(var_00) {
  self setrankedplayerdata("cp", "progression", "playerLevel", "xp", var_00);

  if(isDefined(self.totalxpearned)) {
    self setrankedplayerdata("common", "round", "totalXp", self.totalxpearned);
  }
}

set_player_prestige(var_00) {
  self setrankedplayerdata("cp", "progression", "playerLevel", "prestige", var_00);
  self setrankedplayerdata("cp", "progression", "playerLevel", "xp", 0);
  self setrankedplayerdata("cp", "progression", "playerLevel", "rank", 0);
}

get_rank_by_xp(var_00) {
  var_01 = 0;

  if(var_00 >= level.zombie_ranks[level.zombie_max_rank].xp["max"]) {
    return level.zombie_max_rank;
  }

  if(isDefined(level.zombie_ranks)) {
    for(var_02 = 0; var_02 < level.zombie_ranks.size; var_2++) {
      if(var_00 >= level.zombie_ranks[var_02].xp["min"]) {
        if(var_00 < level.zombie_ranks[var_02].xp["max"]) {
          var_01 = level.zombie_ranks[var_02].id;
          break;
        }
      }
    }
  }

  return var_01;
}

get_scaled_xp(var_00, var_01) {
  return int(var_01 * get_level_xp_scale(var_00) * get_weapon_passive_xp_scale(var_00));
}

get_level_xp_scale(var_00) {
  if(isDefined(var_0.xpscale)) {
    return var_0.xpscale;
  } else {
    return 1;
  }
}

wait_and_give_player_xp(var_00, var_01) {
  self endon("disconnect");
  level endon("game_ended");
  wait(var_01);
  give_player_xp(var_00);
}

get_weapon_passive_xp_scale(var_00) {
  if(isDefined(var_0.weapon_passive_xp_multiplier) && scripts\engine\utility::is_true(var_0.kill_with_extra_xp_passive)) {
    var_0.kill_with_extra_xp_passive = 0;
    return var_0.weapon_passive_xp_multiplier;
  } else
    return 1;
}

give_player_xp(var_00, var_01) {
  if(!level.onlinegame) {
    return;
  }
  var_00 = get_scaled_xp(self, var_00);

  if(isDefined(self.totalxpearned)) {
    self.totalxpearned = self.totalxpearned + var_00;
    scripts\cp\zombies\zombie_analytics::log_session_xp_earned(var_00, self.totalxpearned, self, level.wave_num);
  }

  thread give_player_session_xp(var_00);
  var_02 = 0;
  var_03 = get_player_rank();
  var_04 = get_player_xp();
  var_05 = var_04 + var_00;
  set_player_xp(var_05);

  if(scripts\engine\utility::is_true(var_01) && var_00 > 0) {
    self setclientomnvar("zom_xp_reward", var_00);
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

process_rank_merits(var_00) {
  scripts\cp\cp_merits::processmerit("mt_prestige_1");

  if(var_00 >= 40) {
    scripts\cp\cp_merits::processmerit("mt_prestige_2");
  }

  if(var_00 >= 60) {
    scripts\cp\cp_merits::processmerit("mt_prestige_3");
  }

  if(var_00 >= 80) {
    scripts\cp\cp_merits::processmerit("mt_prestige_4");
  }

  if(var_00 >= 100) {
    scripts\cp\cp_merits::processmerit("mt_prestige_5");
  }

  if(var_00 >= 120) {
    scripts\cp\cp_merits::processmerit("mt_prestige_6");
  }

  if(var_00 >= 140) {
    scripts\cp\cp_merits::processmerit("mt_prestige_7");
  }

  if(var_00 >= 160) {
    scripts\cp\cp_merits::processmerit("mt_prestige_8");
  }

  if(var_00 >= 180) {
    scripts\cp\cp_merits::processmerit("mt_prestige_9");
  }

  if(var_00 >= 200) {
    scripts\cp\cp_merits::processmerit("mt_prestige_10");
  }
}

inc_stat(var_00, var_01, var_02) {
  var_03 = self getrankedplayerdata("cp", var_00, var_01);
  var_04 = var_03 + var_02;
  self setrankedplayerdata("cp", var_00, var_01, var_04);
}

inc_session_stat(var_00, var_01) {
  inc_stat("alienSession", var_00, var_01);
}

get_hives_destroyed_stat() {
  return get_aliensession_stat("hivesDestroyed");
}

get_aliensession_stat(var_00) {
  return self getrankedplayerdata("cp", "alienSession", var_00);
}

set_aliensession_stat(var_00, var_01) {
  self setrankedplayerdata("cp", "alienSession", var_00, var_01);
}

update_deployable_box_performance(var_00) {
  if(isDefined(level.update_deployable_box_performance_func)) {
    var_00[[level.update_deployable_box_performance_func]]();
  } else {
    var_00 scripts\cp\cp_gamescore::update_personal_encounter_performance(scripts\cp\cp_gamescore::get_team_score_component_name(), "team_support_deploy");
  }
}

update_lb_aliensession_challenge(var_00) {
  foreach(var_02 in level.players) {
    var_02 lb_player_update_stat("challengesAttempted", 1);

    if(var_00) {
      var_02 lb_player_update_stat("challengesCompleted", 1);
    }
  }
}

update_lb_aliensession_wave(var_00) {
  foreach(var_02 in level.players) {
    var_02 lb_player_update_stat("waveNum", var_00, 1);
  }
}

update_lb_aliensession_escape(var_00, var_01) {
  var_02 = get_lb_escape_rank(var_01);

  foreach(var_04 in var_00) {
    var_04 lb_player_update_stat("escapedRank" + var_02, 1, 1);
    var_04 lb_player_update_stat("hits", 1, 1);
  }
}

update_alien_kill_sessionstats(var_00, var_01) {
  if(!isDefined(var_01) || !isplayer(var_01)) {
    return;
  }
  if(scripts\cp\utility::is_trap(var_00)) {
    var_01 lb_player_update_stat("trapKills", 1);
  }
}

register_lb_escape_rank(var_00) {
  level.escape_rank_array = var_00;
}

get_lb_escape_rank(var_00) {
  for(var_01 = 0; var_01 < level.escape_rank_array.size - 1; var_1++) {
    if(var_00 >= level.escape_rank_array[var_01] && var_00 < level.escape_rank_array[var_01 + 1]) {
      return var_01;
    }
  }
}

have_clan_tag(var_00) {
  return issubstr(var_00, "[") && issubstr(var_00, "]");
}

remove_clan_tag(var_00) {
  var_01 = strtok(var_00, "]");
  return var_1[1];
}

register_eog_to_lb_playerdata_mapping() {
  var_00 = [];
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
  level.eog_to_lb_playerdata_mapping = var_01;
}

get_mapped_lb_ref_from_eog_ref(var_00) {
  return level.eog_to_lb_playerdata_mapping[var_00];
}

play_time_monitor() {
  self endon("disconnect");

  for(;;) {
    wait 1;
    lb_player_update_stat("time", 1);
  }
}

record_player_kills(var_00, var_01, var_02, var_03) {
  if(scripts\cp\utility::isheadshot(var_00, var_01, var_02, var_03)) {
    increment_player_career_headshot_kills(var_03);
  }

  var_03 increment_player_career_kills(var_03);
  var_03 eog_player_update_stat("kills", 1);
}

increment_player_career_total_waves(var_00) {
  if(isDefined(var_0.wave_num_when_joined)) {
    increment_zombiecareerstats(var_00, "Total_Waves", level.wave_num - var_0.wave_num_when_joined);
  } else {
    increment_zombiecareerstats(var_00, "Total_Waves", level.wave_num);
  }
}

increment_player_career_total_score(var_00) {
  increment_zombiecareerstats(var_00, "Total_Score", var_0.score_earned);
}

increment_player_career_shots_fired(var_00) {
  increment_zombiecareerstats(var_00, "Shots_Fired", 1);
}

increment_player_career_shots_on_target(var_00) {
  increment_zombiecareerstats(var_00, "Shots_on_Target", 1);
}

increment_player_career_explosive_kills(var_00) {
  increment_zombiecareerstats(var_00, "Explosive_Kills", 1);
}

increment_player_career_doors_opened(var_00) {
  increment_zombiecareerstats(var_00, "Doors_Opened", 1);
}

increment_player_career_perks_used(var_00) {
  increment_zombiecareerstats(var_00, "Perks_Used", 1);
}

increment_player_career_kills(var_00) {
  increment_zombiecareerstats(var_00, "Kills", 1);
  updateleaderboardstats(var_00, "Kills", 1, level.script, level.players.size, 1);
}

increment_player_career_headshot_kills(var_00) {
  var_00 increment_zombiecareerstats(var_00, "Headshot_Kills", 1);
  updateleaderboardstats(var_00, "Headshots", 1, level.script, level.players.size, 1);
}

increment_player_career_revives(var_00) {
  var_00 increment_zombiecareerstats(var_00, "Revives", 1);
  updateleaderboardstats(var_00, "Revives", 1, level.script, level.players.size, 1);
}

increment_player_career_downs(var_00) {
  var_00 increment_zombiecareerstats(var_00, "Downs", 1);
  updateleaderboardstats(var_00, "Downs", 1, level.script, level.players.size, 1);
}

update_players_career_highest_wave(var_00, var_01) {
  foreach(var_03 in level.players) {
    update_player_career_highest_wave(var_03, var_00, var_01, level.players.size);
  }
}

update_player_career_highest_wave(var_00, var_01, var_02, var_03) {
  updateifgreaterthan_zombiecareerstats(var_00, "Highest_Wave", var_01);
  update_highest_wave_lb(var_00, var_01, "Highest_Wave", var_02, var_03);
  updateleaderboardstats(var_00, "Rounds", var_01, var_02, var_03, 1);
}

increment_zombiecareerstats(var_00, var_01, var_02) {
  if(!isDefined(var_02)) {
    var_02 = 1;
  }

  var_03 = var_00 getrankedplayerdata("cp", "coopCareerStats", var_01);
  var_04 = var_03 + var_02;
  var_00 setrankedplayerdata("cp", "coopCareerStats", var_01, int(var_04));
}

updateifgreaterthan_zombiecareerstats(var_00, var_01, var_02) {
  var_03 = var_00 getrankedplayerdata("cp", "coopCareerStats", var_01);

  if(var_02 > var_03) {
    var_00 setrankedplayerdata("cp", "coopCareerStats", var_01, var_02);
  }
}

update_highest_wave_lb(var_00, var_01, var_02, var_03, var_04) {
  var_05 = var_00 getrankedplayerdata("cp", "leaderboarddata", var_03, "leaderboardDataPerMap", var_04, var_02);

  if(var_01 > var_05) {
    var_00 setrankedplayerdata("cp", "leaderboarddata", var_03, "leaderboardDataPerMap", var_04, var_02, var_01);
  }
}

updateleaderboardstats(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!isDefined(var_05)) {
    var_05 = 1;
  }

  var_06 = var_00 getrankedplayerdata("cp", "leaderboarddata", var_03, "leaderboardDataPerMap", var_04, var_01);
  var_02 = var_06 + var_05;

  if(var_02 > var_06) {
    var_00 setrankedplayerdata("cp", "leaderboarddata", var_03, "leaderboardDataPerMap", var_04, var_01, var_02);
  }
}