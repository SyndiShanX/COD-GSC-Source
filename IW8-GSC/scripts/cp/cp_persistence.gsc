/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_persistence.gsc
***********************************************/

function set_perk(var_0) {
  self[[level.coop_perk_callbacks[var_0].set]]();
}

function unset_perk(var_0) {
  self[[level.coop_perk_callbacks[var_0].unset]]();
}

function quickdropremovearmorfrominventory() {
  return self getplayerdata("cp", "coopCareerStats", "currency");
}

function get_player_currency() {
  return self getplayerdata("cp", "alienSession", "currency");
}

function get_player_max_currency() {
  return self.maxcurrency;
}

function take_all_currency() {
  set_player_currency(0);
}

function get_starting_currency() {
  var_0 = getdvarint("scr_start_currency", 0);

  if(var_0 != 0) {
    return var_0;
  }

  if(isDefined(level.starting_currency)) {
    return level.starting_currency;
  }

  return 0;
}

function wait_to_set_player_currency(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  wait 1;
  set_player_currency(var_0);
}

function ref_130aa(var_0) {
  self setplayerdata("cp", "coopCareerStats", "currency", int(var_0));
}

function set_player_currency(var_0) {
  if(level.gametype != "cp_pvpve") {
    self setplayerdata("cp", "alienSession", "currency", int(var_0));
    eog_player_update_stat("currency", int(var_0), 1);
    return;
  }
}

function give_player_currency(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isPlayer(self)) {
    return;
  }

  if(scripts\cp\utility::isnmlactive() && !istrue(var_5)) {
    return;
  }

  if(scripts\cp\utility::tryingtoleave()) {
    return;
  }

  if(!istrue(var_3)) {
    var_0 = int(var_0 * scripts\cp\perks\cp_prestige::prestige_getmoneyearnedscalar());
    var_0 = scripts\cp\cp_gamescore::round_up_to_nearest(var_0, 5);
  }

  if(isDefined(level.currency_scale_func)) {
    var_0 = [[level.currency_scale_func]](self, var_0);
  }

  var_6 = get_player_currency();
  var_7 = get_player_max_currency();
  var_8 = var_6 + var_0;
  var_8 = min(var_8, var_7);

  if(!isDefined(self.total_currency_earned)) {
    self.total_currency_earned = var_0;
  }

  if(is_valid_give_type(var_4)) {
    self.total_currency_earned += var_8 - var_6;
    self notify("consumable_charge", var_0 * 0.5);
  }

  level notify("currency_changed");
  eog_player_update_stat("currencytotal", int(self.total_currency_earned), 1);

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    set_player_currency(var_8);
    thread scripts\cp\drone\emp_drone::scorepointspopup(var_0, 1);
  } else {
    return;
  }

  if(isDefined(level.update_money_performance)) {
    [[level.update_money_performance]](self, var_0);
  }

  var_9 = 30000;
  var_10 = gettime();

  if(var_8 >= var_7) {
    if(!isDefined(self.next_maxmoney_hint_time)) {
      self.next_maxmoney_hint_time = var_10 + var_9;
    } else if(var_10 < self.next_maxmoney_hint_time) {
      return;
    }

    if(!level.gameended) {
      scripts\cp\utility::setlowermessage("maxmoney", &"COOP_GAME_PLAY/MONEY_MAX", 4);
      self.next_maxmoney_hint_time = var_10 + var_9;
    }
  }

  if(is_valid_give_type(var_4)) {
    thread scripts\cp\utility::add_to_notify_queue("player_earned_money", var_0);
  }

  self notify("currency_earned", var_0);
}

function is_valid_give_type(var_0) {
  if(!isDefined(var_0)) {
    return true;
  }

  switch (var_0) {
    case "pillage":
    case "magicWheelRefund":
    case "crafted":
    case "carpenter":
    case "bonus":
    case "atm":
    case "nuke":
      return false;
    default:
      return true;
  }

  return true;
}

function take_player_currency(var_0, var_1, var_2, var_3) {
  if(scripts\cp\utility::isnmlactive()) {
    return;
  }

  var_4 = get_player_currency();
  var_5 = max(0, var_4 - var_0);
  var_6 = int(var_4 - var_5);

  if(getDvar("MOLPOSLOMO") != "zombie") {
    set_player_currency(var_5);
    return;
  }

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

  if(isDefined(var_1) && var_1) {
    return;
  }
}

function player_has_enough_currency(var_0, var_1) {
  if(scripts\cp\utility::isnmlactive()) {
    return true;
  }

  if(!isDefined(var_1) || isDefined(var_1) && var_1 != "atm" && var_1 != "laststand" && var_1 != "bleedoutPenalty") {
    if(scripts\cp\utility::is_consumable_active("next_purchase_free")) {
      var_0 = 0;
    }
  }

  var_2 = get_player_currency();
  return var_2 >= var_0;
}

function try_take_player_currency(var_0) {
  if(player_has_enough_currency(var_0)) {
    take_player_currency(var_0);
    return 1;
  }

  return 0;
}

function is_unlocked(var_0) {
  var_1 = undefined;
  var_1 = strtok(var_0, "_")[0];
  var_2 = level.combat_resource[var_0].unlock;
  var_3 = get_player_rank();
  return var_3 >= var_2;
}

function player_persistence_init() {
  level.zombie_xp = undefined;
  set_player_session_xp(0);
  set_player_session_rankup(0);
}

function setcoopplayerdata_for_everyone(var_0, var_1, var_2, var_3, var_4) {
  foreach(var_6 in level.players) {
    if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2) && isDefined(var_3) && isDefined(var_4)) {
      var_6 setplayerdata("cp", var_0, var_1, var_2, var_3, var_4);
      continue;
    }

    if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2) && isDefined(var_3) && !isDefined(var_4)) {
      var_6 setplayerdata("cp", var_0, var_1, var_2, var_3);
      continue;
    }

    if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2) && !isDefined(var_3) && !isDefined(var_4)) {
      var_6 setplayerdata("cp", var_0, var_1, var_2);
      continue;
    }

    if(isDefined(var_0) && isDefined(var_1) && !isDefined(var_2) && !isDefined(var_3) && !isDefined(var_4)) {
      var_6 setplayerdata("cp", var_0, var_1);
    }
  }
}

function session_stats_init() {
  parse_eog_tracking_table();
  eog_setup_track_items();
  thread eog_player_tracking_init();
}

function parse_eog_tracking_table() {
  level.eogtracking = [];
  var_0 = "cp/cp_eog_tracking_types.csv";

  for(var_1 = 0;; var_1++) {
    var_2 = tablelookupbyrow(var_0, var_1, 0);

    if(var_2 == "") {
      break;
    }

    level.eogtracking[var_1] = tablelookup(var_0, 0, var_1, 1);
  }
}

function eog_player_tracking_init() {
  self endon("disconnect");
  wait 0.5;
  var_0 = self getentitynumber();
  var_1 = "unknownPlayer";

  if(isDefined(self.name)) {
    var_1 = self.name;
  }

  if(self isconsoleplayer()) {
    if(have_clan_tag(var_1)) {
      var_1 = remove_clan_tag(var_1);
    }
  }

  var_2 = 8;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    self setplayerdata("cp", "EoGPlayer", var_3, "connected", 0);
  }

  foreach(var_5 in level.players) {
    reset_eog_stats(var_5, var_0);
    var_5 setplayerdata("cp", "EoGPlayer", var_0, "connected", 1);
    var_5 setplayerdata("cp", "EoGPlayer", var_0, "name", var_1);
    var_5 setplayerdata("common", "round", "totalXp", 0);
  }

  var_7 = [0, 0, 0, 0];

  foreach(var_9 in level.players) {
    var_10 = var_9 getentitynumber();
    var_7 = 1;

    if(var_9 == self) {
      continue;
    }

    var_0 = var_9 getentitynumber();
    var_11 = var_9 getplayerdata("cp", "EoGPlayer", var_0, "connected");
    self setplayerdata("cp", "EoGPlayer", var_0, "connected", var_11);

    for(var_3 = 0; var_3 < level.eogtracking.size; var_3++) {
      var_12 = var_9 getplayerdata("cp", "EoGPlayer", var_0, level.eogtracking[var_3]);

      if(level.eogtracking[var_3] != "currency" && getDvar("MOLPOSLOMO") != "cp_pvpve") {
        self setplayerdata("cp", "EoGPlayer", var_0, level.eogtracking[var_3], var_12);
      }
    }
  }

  foreach(var_15 in var_7) {
    if(!var_15) {
      reset_eog_stats(var_16);
    }
  }
}

function reset_eog_stats(var_0) {
  for(var_1 = 0; var_1 < level.eogtracking.size; var_1++) {
    if(level.eogtracking[var_1] == "name") {
      self setplayerdata("cp", "EoGPlayer", var_0, level.eogtracking[var_1], "");
      continue;
    }

    self setplayerdata("cp", "EoGPlayer", var_0, level.eogtracking[var_1], 0);
  }
}

function eog_setup_track_items() {
  if(!isDefined(level.eogscoreboard)) {
    level.eogscoreboard = ["currency", "kills", "headShots", "downs", "revives"];
  }

  clear_eog_tracking_types();

  for(var_0 = 0; var_0 < level.eogscoreboard.size; var_0++) {
    var_1 = int(get_eog_tracking_idx(level.eogscoreboard[var_0]));
    self setplayerdata("cp", "CPSession", "eogTrackingIdx", var_0, var_1);
  }
}

function clear_eog_tracking_types() {
  for(var_0 = 0; var_0 < 7; var_0++) {
    self setplayerdata("cp", "CPSession", "eogTrackingIdx", var_0, 99);
  }
}

function get_eog_tracking_idx(var_0) {
  return tablelookup("cp/cp_eog_tracking_types.csv", 1, var_0, 0);
}

function eog_update_on_player_disconnect(var_0) {
  if(scripts\cp\cp_endgame::gamealreadyended()) {
    return;
  }

  var_1 = var_0 getentitynumber();
  setcoopplayerdata_for_everyone("EoGPlayer", var_1, "connected", 0);
}

function eog_player_update_stat(var_0, var_1, var_2) {
  var_3 = self getentitynumber();
  var_4 = var_1;

  if(!isDefined(var_2) || !var_2) {
    var_5 = self getplayerdata("cp", "EoGPlayer", var_3, var_0);
    var_4 = int(var_5) + int(var_1);
  }

  try_update_lb_playerdata(var_0, var_4, 1);
  setcoopplayerdata_for_everyone("EoGPlayer", var_3, var_0, var_4);

  if(isDefined(level.eogscoringtable)) {
    update_eog_totals_for_stat_ref(var_0, var_4);
    return;
  }
}

function update_eog_totals_for_stat_ref(var_0, var_1) {
  for(var_2 = 0; var_2 < level.eogscoringtable.size; var_2++) {
    if(level.eogscoringtable[var_2].ref == var_0) {
      level.eogscoringtable[var_2].curamount = var_1;
    }
  }
}

function eog_player_update_pvpve_downs(var_0, var_1) {
  var_2 = self getentitynumber();
  setcoopplayerdata_for_everyone("EoGPlayer", var_2, var_0, var_1);
}

function try_update_lb_playerdata(var_0, var_1, var_2) {
  var_3 = get_mapped_lb_ref_from_eog_ref(var_0);

  if(!isDefined(var_3)) {
    return;
  }

  lb_player_update_stat(var_3, var_1, var_2);
}

function lb_player_update_stat(var_0, var_1, var_2) {
  jumpiffalse(istrue(var_2)) LOC_00000012;
  var_3 = var_1;
  goto LOC_0000002c;
}

function weapons_tracking_init() {
  self.persistence_weaponstats = [];

  foreach(var_1 in level.collectibles) {
    if(strtok(var_3, "_")[0] == "weapon") {
      var_2 = get_base_weapon_name(var_3);
      self.persistence_weaponstats[var_2] = 1;
    }
  }

  thread player_weaponstats_track_shots();
}

function get_base_weapon_name(var_0) {
  var_1 = "";
  var_2 = undefined;

  if(issameweapon(var_0)) {
    var_2 = var_0.basename;
  } else {
    var_2 = var_0;
  }

  var_3 = strtok(var_2, "_");

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];

    if(var_5 == "weapon" && var_4 == 0) {
      continue;
    }

    if(var_5 == "zm") {
      var_1 += "zm";
      break;
    }

    if(var_4 < var_3.size - 1) {
      var_1 += var_5 + "_";
      continue;
    }

    var_1 += var_5;
    break;
  }

  if(var_1 == "") {
    return "none";
  }

  return var_1;
}

function weaponstats_reset(var_0, var_1) {
  self setplayerdata("cp", var_0, var_1, "hits", 0);
  self setplayerdata("cp", var_0, var_1, "shots", 0);
  self setplayerdata("cp", var_0, var_1, "kills", 0);
}

function update_weaponstats_hits(var_0, var_1, var_2) {
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

function is_valid_weapon_hit(var_0, var_1) {
  if(var_0 == "none") {
    return false;
  }

  if(var_1 == "MOD_MELEE") {
    return false;
  }

  if(no_weapon_fired_notify(var_0)) {
    return false;
  }

  return true;
}

function no_weapon_fired_notify(var_0) {
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

function update_weaponstats_shots(var_0, var_1) {
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

function update_weaponstats_kills(var_0, var_1) {
  update_weaponstats("weaponStats", var_0, "kills", var_1);
}

function update_weaponstats(var_0, var_1, var_2, var_3) {
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
    var_4 += var_5[1];
  }

  var_6 = int(self getplayerdata("cp", var_0, var_4, var_2));
  var_7 = var_6 + int(var_3);
  self setplayerdata("cp", var_0, var_4, var_2, var_7);
}

function player_weaponstats_track_shots() {
  self endon("disconnect");
  self notify("weaponstats_track_shots");
  self endon("weaponstats_track_shots");

  for(;;) {
    self waittill("weapon_fired", var_0);

    if(!isDefined(var_0)) {
      continue;
    }

    var_1 = undefined;

    if(isDefined(var_0)) {
      var_1 = createheadicon(var_0);
    }

    var_2 = 1;
    update_weaponstats_shots(var_1, var_2);
  }
}

function rank_init() {
  if(!isDefined(level.zombie_ranks_table)) {
    level.zombie_ranks_table = "cp/zombies/rankTable.csv";
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

function get_ref_by_id(var_0) {
  return tablelookup(level.zombie_ranks_table, 0, var_0, 1);
}

function get_minxp_by_id(var_0) {
  return int(tablelookup(level.zombie_ranks_table, 0, var_0, 2));
}

function get_maxxp_by_id(var_0) {
  return int(tablelookup(level.zombie_ranks_table, 0, var_0, 7));
}

function get_nextxp_by_id(var_0) {
  return int(tablelookup(level.zombie_ranks_table, 0, var_0, 3));
}

function get_level_by_id(var_0) {
  return int(tablelookup(level.zombie_ranks_table, 0, var_0, 14));
}

function get_shortrank_by_id(var_0) {
  return tablelookup(level.zombie_ranks_table, 0, var_0, 4);
}

function get_fullrank_by_id(var_0) {
  return tablelookup(level.zombie_ranks_table, 0, var_0, 5);
}

function get_ingamerank_by_id(var_0) {
  return tablelookup(level.zombie_ranks_table, 0, var_0, 17);
}

function get_icon_by_id(var_0) {
  return tablelookup(level.zombie_ranks_table, 0, var_0, 6);
}

function get_token_reward_by_id(var_0) {
  return int(tablelookup(level.zombie_ranks_table, 0, var_0, 19));
}

function get_splash_by_id(var_0) {
  return tablelookup(level.zombie_ranks_table, 0, var_0, 8);
}

function get_player_rank() {
  return self getplayerdata("cp", "progression", "playerLevel", "rank");
}

function get_player_xp() {
  return self getplayerdata("cp", "progression", "playerLevel", "xp");
}

function get_player_prestige() {
  return self getplayerdata("cp", "progression", "playerLevel", "prestige");
}

function get_player_session_xp() {
  return self getplayerdata("cp", "alienSession", "experience");
}

function set_player_session_xp(var_0) {
  self setplayerdata("cp", "alienSession", "experience", var_0);
}

function give_player_session_xp(var_0) {
  var_1 = get_player_session_xp();
  var_2 = var_0 + var_1;
  set_player_session_xp(var_2);
}

function get_player_session_tokens() {
  return self getplayerdata("cp", "alienSession", "shots");
}

function set_player_session_tokens(var_0) {
  self setplayerdata("cp", "alienSession", "shots", var_0);
}

function give_player_session_tokens(var_0) {
  var_1 = get_player_session_tokens();
  var_2 = var_0 + var_1;
  set_player_session_tokens(var_2);
}

function set_player_session_rankup(var_0) {
  self setplayerdata("cp", "alienSession", "ranked_up", int(var_0));
}

function get_player_session_rankup() {
  return self getplayerdata("cp", "alienSession", "ranked_up");
}

function update_player_session_rankup(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  var_1 = get_player_session_rankup();
  var_2 = var_0 + var_1;
  set_player_session_rankup(var_2);
}

function set_player_rank(var_0) {
  self setplayerdata("cp", "progression", "playerLevel", "rank", var_0);
}

function set_player_xp(var_0) {
  self setplayerdata("cp", "progression", "playerLevel", "xp", var_0);

  if(isDefined(self.totalxpearned)) {
    self setplayerdata("common", "round", "totalXp", self.totalxpearned);
    return;
  }
}

function set_player_prestige(var_0) {
  self setplayerdata("cp", "progression", "playerLevel", "prestige", var_0);
  self setplayerdata("cp", "progression", "playerLevel", "xp", 0);
  self setplayerdata("cp", "progression", "playerLevel", "rank", 0);
}

function get_rank_by_xp(var_0) {
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

function get_scaled_xp(var_0, var_1) {
  return int(var_1 * get_level_xp_scale(var_0) * get_weapon_passive_xp_scale(var_0));
}

function get_level_xp_scale(var_0) {
  if(isDefined(var_0.xpscale)) {
    return var_0.xpscale;
  }

  return 1;
}

function wait_and_give_player_xp(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  wait var_1;
  give_player_xp(var_0);
}

function get_weapon_passive_xp_scale(var_0) {
  if(isDefined(var_0.weapon_passive_xp_multiplier) && istrue(var_0.kill_with_extra_xp_passive)) {
    var_0.kill_with_extra_xp_passive = 0;
    return var_0.weapon_passive_xp_multiplier;
  }

  return 1;
}

function give_player_xp(var_0, var_1) {
  var_0 = get_scaled_xp(self, var_0);

  if(isDefined(self.totalxpearned)) {
    self.totalxpearned += var_0;
  }

  thread give_player_session_xp(var_0);
  var_2 = 0;
  var_3 = get_player_rank();
  var_4 = get_player_xp();
  var_5 = var_4 + var_0;
  set_player_xp(var_5);

  if(istrue(var_1) && var_0 > 0 && !scripts\cp\utility::turn_off_sniper_laser()) {
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
      self notify("ranked_up", var_6);
      update_player_session_rankup();
    }

    process_rank_merits(var_6);
    return;
  }
}

function process_rank_merits(var_0) {
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
    return;
  }
}

function inc_stat(var_0, var_1, var_2) {
  var_3 = self getplayerdata("cp", var_0, var_1);
  var_4 = var_3 + var_2;
  self setplayerdata("cp", var_0, var_1, var_4);
}

function inc_session_stat(var_0, var_1) {
  inc_stat("alienSession", var_0, var_1);
}

function get_hives_destroyed_stat() {
  return get_aliensession_stat("hivesDestroyed");
}

function get_aliensession_stat(var_0) {
  return self getplayerdata("cp", "alienSession", var_0);
}

function set_aliensession_stat(var_0, var_1) {
  self setplayerdata("cp", "alienSession", var_0, var_1);
}

function update_deployable_box_performance(var_0) {
  if(isDefined(level.update_deployable_box_performance_func)) {
    var_0[[level.update_deployable_box_performance_func]]();
    return;
  }

  var_0 scripts\cp\cp_gamescore::update_personal_encounter_performance(scripts\cp\cp_gamescore::get_team_score_component_name(), "team_support_deploy");
}

function update_lb_aliensession_challenge(var_0) {
  foreach(var_2 in level.players) {
    lb_player_update_stat(var_2, "challengesAttempted", 1);

    if(var_0) {
      lb_player_update_stat(var_2, "challengesCompleted", 1);
    }
  }
}

function update_lb_aliensession_wave(var_0) {
  foreach(var_2 in level.players) {
    lb_player_update_stat(var_2, "waveNum", var_0, 1);
  }
}

function update_lb_aliensession_escape(var_0, var_1) {
  var_2 = get_lb_escape_rank(var_1);

  foreach(var_4 in var_0) {
    lb_player_update_stat(var_4, "escapedRank" + var_2, 1, 1);
    lb_player_update_stat(var_4, "hits", 1, 1);
  }
}

function update_alien_kill_sessionstats(var_0, var_1) {
  if(!isDefined(var_1) || !isPlayer(var_1)) {
    return;
  }

  if(scripts\cp\utility::is_trap(var_0)) {
    lb_player_update_stat(var_1, "trapKills", 1);
    return;
  }
}

function register_lb_escape_rank(var_0) {
  level.escape_rank_array = var_0;
}

function get_lb_escape_rank(var_0) {
  for(var_1 = 0; var_1 < level.escape_rank_array.size - 1; var_1++) {
    if(var_0 >= level.escape_rank_array[var_1] && var_0 < level.escape_rank_array[var_1 + 1]) {
      return var_1;
    }
  }
}

function have_clan_tag(var_0) {
  return issubstr(var_0, "[") && issubstr(var_0, "]");
}

function remove_clan_tag(var_0) {
  var_1 = strtok(var_0, "]");
  return var_1[1];
}

function register_eog_to_lb_playerdata_mapping() {
  var_0 = [];
  GscBinSkip1(0x45, "kills", "kills");
}

function get_mapped_lb_ref_from_eog_ref(var_0) {
  return level.eog_to_lb_playerdata_mapping[var_0];
}

function play_time_monitor() {
  self endon("disconnect");

  for(;;) {
    wait 1;
    lb_player_update_stat("time", 1);
  }
}

function record_player_kills(var_0, var_1, var_2, var_3) {
  if(scripts\cp\utility::isheadshot(var_0, var_1, var_2, var_3)) {
    increment_player_career_headshot_kills(var_3);
    eog_player_update_stat(var_3, "headShots", 1);
  }

  increment_player_career_kills(var_3, var_3);
  eog_player_update_stat(var_3, "kills", 1);
  var_3 scripts\cp\cp_analytics::log_event("zombie_death", 1, [var_3.clientid], [var_3.clientid], [var_3.clientid]);
}

function increment_player_career_total_waves(var_0) {
  if(isDefined(var_0.wave_num_when_joined)) {
    increment_zombiecareerstats(var_0, "Total_Waves", level.wave_num - var_0.wave_num_when_joined);
    return;
  }

  increment_zombiecareerstats(var_0, "Total_Waves", level.wave_num);
}

function increment_player_career_total_score(var_0) {
  increment_zombiecareerstats(var_0, "Total_Score", var_0.score_earned);
}

function increment_player_career_shots_fired(var_0) {
  increment_zombiecareerstats(var_0, "Shots_Fired", 1);
}

function increment_player_career_shots_on_target(var_0) {
  increment_zombiecareerstats(var_0, "Shots_on_Target", 1);
}

function increment_player_career_explosive_kills(var_0) {
  increment_zombiecareerstats(var_0, "Explosive_Kills", 1);
}

function increment_player_career_doors_opened(var_0) {
  increment_zombiecareerstats(var_0, "Doors_Opened", 1);
}

function increment_player_career_perks_used(var_0) {
  increment_zombiecareerstats(var_0, "Perks_Used", 1);
}

function increment_player_career_kills(var_0) {
  increment_zombiecareerstats(var_0, "Kills", 1);

  if(should_update_leaderboard_stats()) {
    updateleaderboardstats(var_0, "Kills", 1, level.script, level.players.size, 1);
    return;
  }
}

function increment_player_career_headshot_kills(var_0) {
  increment_zombiecareerstats(var_0, var_0, "Headshot_Kills", 1);

  if(should_update_leaderboard_stats()) {
    updateleaderboardstats(var_0, "Headshots", 1, level.script, level.players.size, 1);
    return;
  }
}

function increment_player_career_revives(var_0) {
  increment_zombiecareerstats(var_0, var_0, "Revives", 1);

  if(should_update_leaderboard_stats()) {
    updateleaderboardstats(var_0, "Revives", 1, level.script, level.players.size, 1);
    return;
  }
}

function increment_player_career_downs(var_0) {
  increment_zombiecareerstats(var_0, var_0, "Downs", 1);

  if(should_update_leaderboard_stats()) {
    updateleaderboardstats(var_0, "Downs", 1, level.script, level.players.size, 1);
    return;
  }
}

function mortars_get_player_targeted() {
  level.watchtrigger = 1;
}

function should_update_leaderboard_stats() {
  return istrue(level.watchtrigger);
}

function update_players_career_highest_wave(var_0, var_1) {
  foreach(var_3 in level.players) {
    update_player_career_highest_wave(var_3, var_0, var_1, level.players.size);
  }
}

function update_player_career_highest_wave(var_0, var_1, var_2) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    updateifgreaterthan_zombiecareerstats(var_0, "Highest_Wave", var_1);
    check_and_update_best_stats(var_0, var_1, "Highest_Wave", level.script, var_2);
    updateleaderboardstats(var_0, "Rounds", var_1, level.script, var_2, 1);
    return;
  }
}

function increment_zombiecareerstats(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = var_0 getplayerdata("cp", "coopCareerStats", var_1);
  var_4 = var_3 + var_2;
  var_0 setplayerdata("cp", "coopCareerStats", var_1, int(var_4));
}

function updateifgreaterthan_zombiecareerstats(var_0, var_1, var_2) {
  var_3 = var_0 getplayerdata("cp", "coopCareerStats", var_1);

  if(var_2 > var_3) {
    var_0 setplayerdata("cp", "coopCareerStats", var_1, var_2);
    return;
  }
}

function update_highest_wave_lb(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0 getplayerdata("cp", "leaderboarddata", var_3, "leaderboardDataPerMap", var_4, var_2);

  if(var_1 > var_5) {
    var_0 setplayerdata("cp", "leaderboarddata", var_3, "leaderboardDataPerMap", var_4, var_2, var_1);
    return;
  }
}

function check_and_update_best_stats(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(should_update_leaderboard_stats()) {
    var_6 = var_0 getplayerdata("cp", "leaderboarddata", var_3, "leaderboardDataPerMap", var_4, var_2);

    if(!istrue(var_5)) {
      if(var_1 > var_6) {
        var_0 setplayerdata("cp", "leaderboarddata", var_3, "leaderboardDataPerMap", var_4, var_2, var_1);
        return;
      }

      return;
    }

    if(var_1 < var_6) {
      var_0 setplayerdata("cp", "leaderboarddata", var_3, "leaderboardDataPerMap", var_4, var_2, var_1);
      return;
    }

    return;
  }
}

function updateleaderboardstats(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(should_update_leaderboard_stats()) {
    if(!isDefined(var_5)) {
      var_5 = 1;
    }

    var_6 = var_0 getplayerdata("cp", "leaderboarddata", var_3, "leaderboardDataPerMap", var_4, var_1);
    var_2 = var_6 + var_5;

    if(var_2 > var_6) {
      var_0 setplayerdata("cp", "leaderboarddata", var_3, "leaderboardDataPerMap", var_4, var_1, var_2);
      return;
    }

    return;
  }
}