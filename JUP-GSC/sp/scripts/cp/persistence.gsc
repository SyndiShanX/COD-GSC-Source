/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\persistence.gsc
***********************************************/

#using script_3f8889c16399185c;
#using scripts\common\utility;
#using scripts\cp\cp_analytics;
#using scripts\cp\cp_merits;
#using scripts\cp\endgame;
#using scripts\cp\perks\cp_perk_utility;
#using scripts\cp\pickups;
#using scripts\cp\points;
#using scripts\cp\rank;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace persistence;

function get_player_munition_currency() {
  return self getplayerdata("cp", "coopCareerStats", "currency");
}

function get_player_currency() {
  if(isDefined(self.plundercount)) {
    return self.plundercount;
  }

  return self getplayerdata("cp", "alienSession", "currency");
}

function get_player_max_currency() {
  return self.maxcurrency;
}

function take_all_currency() {
  set_player_currency(0);
}

function get_starting_currency() {
  var_c7a775ac491b210f = getdvarint(@ "hash_66d046d1cfe3ecc9", 0);

  if(var_c7a775ac491b210f != 0) {
    return var_c7a775ac491b210f;
  }

  if(isDefined(level.starting_currency)) {
    return level.starting_currency;
  }

  return 0;
}

function wait_to_set_player_currency(amount) {
  self endon("disconnect");
  level endon("game_ended");
  wait 3;
  set_player_currency(amount);
}

function set_player_munition_currency(amount) {
  self setplayerdata("cp", "coopCareerStats", "currency", int(amount));
}

function function_5d7c28c83d8da818(var_6b05369a767e9dbc) {
  current_amount = get_player_currency();
  new_amount = int(max(0, current_amount + var_6b05369a767e9dbc));
  set_player_currency(new_amount);
}

function set_player_currency(amount, var_8e67a20d8e88db4d) {
  self.plundercount = amount;

  if(!istrue(var_8e67a20d8e88db4d)) {
    scripts\cp\pickups::function_46ee9182cf6872d5(amount);
  }

  self setplayerdata("cp", "alienSession", "currency", int(amount));
  eog_player_update_stat("currency", int(amount), 1);
}

function give_player_currency(amount, font_size, shitloc, var_4a46dc3f73a35cb, give_type, var_1e921a3666f3d7ec) {
  if(isDefined(level.gametype) && level.gametype == "dungeons") {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  assert(amount >= 0);

  if(isDefined(level.currency_scale_func)) {
    amount = [[level.currency_scale_func]](self, amount);
  }

  current_amount = get_player_currency();
  max_amount = get_player_max_currency();
  new_amount = current_amount + amount;

  if(!isDefined(max_amount)) {
    assertmsg("give_player_currency is trying to give currency but player(" + self getentitynumber() + ").maxCurrency is undefined");
    max_amount = 0;
  }

  new_amount = min(new_amount, max_amount);

  if(!isDefined(self.total_currency_earned)) {
    self.total_currency_earned = amount;
  }

  if(is_valid_give_type(give_type)) {
    self.total_currency_earned += new_amount - current_amount;
    self notify("consumable_charge", amount * 0.5);
  }

  level notify("currency_changed");
  eog_player_update_stat("currencytotal", int(self.total_currency_earned), 1);

  if(function_f993f83a21fc44b2() && getdvarint(@ "hash_d4ed36d1f90ca352", 0) && (!isDefined(give_type) || give_type == "debug")) {
    set_player_currency(new_amount);
    thread scripts\cp\rank::scorepointspopup(amount, 1);
  } else if(function_f993f83a21fc44b2() && getdvarint(@ "hash_d4ed36d1f90ca352", 0) && isDefined(give_type) && give_type == "bounty") {
    set_player_currency(new_amount);
    thread scripts\cp\points::doscoreevent(#"bounty", undefined, amount);
  } else if(is_wave_gametype() || isDefined(give_type) && give_type == "cash_pickup") {
    if(!istrue(level.var_8fde5731bb1ba3bb) || isDefined(give_type) && give_type == "cash_pickup") {
      set_player_currency(new_amount);
    }

    thread scripts\cp\rank::scorepointspopup(amount, 1);
  } else {
    return;
  }

  if(isDefined(level.update_money_performance)) {
    [[level.update_money_performance]](self, amount);
  }

  current_time = gettime();

  if(new_amount >= max_amount) {
    if(!isDefined(self.next_maxmoney_hint_time)) {
      self.next_maxmoney_hint_time = current_time + 30000;
    } else if(current_time < self.next_maxmoney_hint_time) {
      return;
    }

    if(!level.gameended) {
      setlowermessage("maxmoney", &"COOP_GAME_PLAY/MONEY_MAX", 4);
      self.next_maxmoney_hint_time = current_time + 30000;
    }
  }

  if(is_valid_give_type(give_type)) {
    thread add_to_notify_queue("player_earned_money", amount);
  }

  self notify("currency_earned", amount);
}

function is_valid_give_type(give_type) {
  if(!isDefined(give_type)) {
    return true;
  }

  return true;
}

function take_player_currency(amount, var_268300d5f447c80c, spending_type, weapon_ref) {
  assert(amount >= 0);
  current_amount = get_player_currency();
  new_amount = max(0, current_amount - amount);
  amount_spent = int(current_amount - new_amount);
  set_player_currency(new_amount);
}

function player_has_enough_currency(amount, spend_type) {
  assert(amount >= 0);

  if(!isDefined(spend_type) || isDefined(spend_type) && spend_type != "atm" && spend_type != "laststand" && spend_type != "bleedoutPenalty") {
    if(is_consumable_active("next_purchase_free")) {
      amount = 0;
    }
  }

  currency = get_player_currency();
  return currency >= amount;
}

function try_take_player_currency(amount) {
  if(player_has_enough_currency(amount)) {
    take_player_currency(amount);
    return 1;
  }

  return 0;
}

function player_persistence_init() {
  level.zombie_xp = undefined;
  set_player_session_xp(0);
  set_player_session_rankup(0);
}

function setcoopplayerdata_for_everyone(param0, param1, param2, param3, param4) {
  foreach(player in level.players) {
    if(isDefined(param0) && isDefined(param1) && isDefined(param2) && isDefined(param3) && isDefined(param4)) {
      player setplayerdata("cp", param0, param1, param2, param3, param4);
      continue;
    }

    if(isDefined(param0) && isDefined(param1) && isDefined(param2) && isDefined(param3) && !isDefined(param4)) {
      player setplayerdata("cp", param0, param1, param2, param3);
      continue;
    }

    if(isDefined(param0) && isDefined(param1) && isDefined(param2) && !isDefined(param3) && !isDefined(param4)) {
      player setplayerdata("cp", param0, param1, param2);
      continue;
    }

    if(isDefined(param0) && isDefined(param1) && !isDefined(param2) && !isDefined(param3) && !isDefined(param4)) {
      player setplayerdata("cp", param0, param1);
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
  table = "cp/cp_eog_tracking_types.csv";

  for(row = 0; true; row++) {
    index = tablelookupbyrow(table, row, 0);

    if(index == "") {
      break;
    }

    level.eogtracking[row] = tablelookup(table, 0, row, 1);
  }
}

function eog_player_tracking_init() {
  self endon("disconnect");
  wait 0.5;
  entity_num = self getentitynumber();
  player_name = "unknownPlayer";

  if(isDefined(self.name)) {
    player_name = self.name;
  }

  if(self isconsoleplayer()) {
    if(have_clan_tag(player_name)) {
      player_name = remove_clan_tag(player_name);
    }
  }

  numplayers = 8;

  for(i = 0; i < numplayers; i++) {
    self setplayerdata("cp", "EoGPlayer", i, "connected", 0);
  }

  foreach(player in level.players) {
    if(getdvarint(@ "hash_b4f399ba2ad6131f") == 1) {
      iprintln("<dev string:x1c>" + entity_num + "<dev string:x33>" + "<dev string:x41>" + player getentitynumber());
    }

    player reset_eog_stats(entity_num);
    player setplayerdata("cp", "EoGPlayer", entity_num, "connected", 1);
    player setplayerdata("cp", "EoGPlayer", entity_num, "name", player_name);
    player setplayerdata("common", "round", "totalXp", 0);
  }

  var_f8335a1c04fb409f = [0, 0, 0, 0];

  foreach(p in level.players) {
    p_entnum = p getentitynumber();
    var_f8335a1c04fb409f[int(p_entnum)] = 1;

    if(p == self) {
      continue;
    }

    entity_num = p getentitynumber();
    connected = p getplayerdata("cp", "EoGPlayer", entity_num, "connected");
    self setplayerdata("cp", "EoGPlayer", entity_num, "connected", connected);

    if(getdvarint(@ "hash_25d628943cd6ea20") == 1) {
      iprintln("<dev string:x4a>" + self getentitynumber() + "<dev string:x5f>" + entity_num);
    }

    for(i = 0; i < level.eogtracking.size; i++) {
      value = p getplayerdata("cp", "EoGPlayer", entity_num, level.eogtracking[i]);

      if(level.eogtracking[i] != "currency") {
        self setplayerdata("cp", "EoGPlayer", entity_num, level.eogtracking[i], value);
      }
    }
  }

  foreach(index, result in var_f8335a1c04fb409f) {
    if(!result) {
      if(getdvarint(@ "hash_25d628943cd6ea20") == 1) {
        iprintln("<dev string:x4a>" + self getentitynumber() + "<dev string:x72>" + index);
      }

      reset_eog_stats(index);
    }
  }
}

function reset_eog_stats(clientnum) {
  for(i = 0; i < level.eogtracking.size; i++) {
    if(level.eogtracking[i] == "name") {
      self setplayerdata("cp", "EoGPlayer", clientnum, level.eogtracking[i], "");
      continue;
    }

    value = 0;

    if(isDefined(self.pers["counting_stats"]) && isDefined(self.pers["counting_stats"][level.eogtracking[i]])) {
      value = self.pers["counting_stats"][level.eogtracking[i]];
    }

    self setplayerdata("cp", "EoGPlayer", clientnum, level.eogtracking[i], value);
  }
}

function eog_setup_track_items() {
  if(!isDefined(level.eogscoreboard)) {
    level.eogscoreboard = ["currency", "kills", "headShots", "downs", "revives"];
  }

  clear_eog_tracking_types();

  for(i = 0; i < level.eogscoreboard.size; i++) {
    idx = int(get_eog_tracking_idx(level.eogscoreboard[i]));
    self setplayerdata("cp", "CPSession", "eogTrackingIdx", i, idx);
  }
}

function clear_eog_tracking_types() {
  for(i = 0; i < 7; i++) {
    self setplayerdata("cp", "CPSession", "eogTrackingIdx", i, 99);
  }
}

function get_eog_tracking_idx(ref) {
  return tablelookup("cp/cp_eog_tracking_types.csv", 1, ref, 0);
}

function eog_update_on_player_disconnect(var_2421296ba8ccb5ee) {
  if(scripts\cp\endgame::gamealreadyended()) {
    return;
  }

  entity_num = var_2421296ba8ccb5ee getentitynumber();
  setcoopplayerdata_for_everyone("EoGPlayer", entity_num, "connected", 0);
}

function eog_player_update_stat(stat_ref, amount, override_value) {
  entity_num = self getentitynumber();
  new_amount = amount;

  if(!isDefined(override_value) || !override_value) {
    old_amount = self getplayerdata("cp", "EoGPlayer", entity_num, stat_ref);
    new_amount = int(old_amount) + int(amount);
  }

  try_update_lb_playerdata(stat_ref, new_amount, 1);
  setcoopplayerdata_for_everyone("EoGPlayer", entity_num, stat_ref, new_amount);

  if(isDefined(level.eogscoringtable)) {
    update_eog_totals_for_stat_ref(stat_ref, new_amount);
  }
}

function function_c0480dc3a45ef6(stat_ref) {
  entity_num = self getentitynumber();
  return_value = self getplayerdata("cp", "EoGPlayer", entity_num, stat_ref);
  return return_value;
}

function update_eog_totals_for_stat_ref(stat_ref, amount) {
  for(i = 0; i < level.eogscoringtable.size; i++) {
    if(level.eogscoringtable[i].ref == stat_ref) {
      level.eogscoringtable[i].curamount = amount;
    }
  }
}

function try_update_lb_playerdata(eog_ref, new_amount, override_value) {
  lb_ref = get_mapped_lb_ref_from_eog_ref(eog_ref);

  if(!isDefined(lb_ref)) {
    return;
  }

  lb_player_update_stat(lb_ref, new_amount, override_value);
}

function enable_leaderboard() {
  level.leaderboard_enabled = 1;
}

function increment_player_career_total_waves(player) {
  if(isDefined(player.wave_num_when_joined)) {
    increment_zombiecareerstats(player, "Total_Waves", level.wave_num - player.wave_num_when_joined);
    return;
  }

  increment_zombiecareerstats(player, "Total_Waves", level.wave_num);
}

function increment_player_career_total_score(player) {
  increment_zombiecareerstats(player, "Total_Score", player.score_earned);
}

function lb_player_update_stat(var_218835b4b69dbd26, amount, override_value) {
  if(istrue(override_value)) {
    new_value = amount;
  } else {
    old_value = self getplayerdata("cp", "alienSession", var_218835b4b69dbd26);
    new_value = old_value + amount;
  }

  self setplayerdata("cp", "alienSession", var_218835b4b69dbd26, new_value);
}

function rank_init() {
  ranktablebundle = getranktablebundle();
  level.zombie_ranks = [];
  level.zombie_max_rank = ranktablebundle.maxrank;
  assertex(isDefined(level.zombie_max_rank) && level.zombie_max_rank);

  for(i = 0; i <= level.zombie_max_rank; i++) {
    var_1a9b1fc7643483dc = getrankbundle(ranktablebundle.ranklist[i].rank);

    if(!isDefined(level.zombie_ranks[i])) {
      rank = spawnStruct();
      rank.id = i;
      rank.lvl = var_1a9b1fc7643483dc.ingamerank;
      rank.xp = [];
      rank.xp["min"] = var_1a9b1fc7643483dc.minxp;
      rank.xp["next"] = var_1a9b1fc7643483dc.xptonext;
      rank.xp["max"] = var_1a9b1fc7643483dc.maxxp;
      rank.name = [];
      rank.name["short"] = var_1a9b1fc7643483dc.var_f2837d47b0aa16e8;
      rank.name["full"] = var_1a9b1fc7643483dc.var_bc23bd04c0a75755;
      rank.name["ingame"] = var_1a9b1fc7643483dc.ingamerankname;
      rank.splash = var_1a9b1fc7643483dc.splash;
      level.zombie_ranks[i] = rank;
    }
  }
}

function get_splash_by_id(id) {
  return level.zombie_ranks[id].splash;
}

function get_player_rank() {
  return self getplayerdata("cp", "progression", "playerLevel", "rank");
}

function get_player_xp() {
  return self getplayerdata("cp", "progression", "playerLevel", "xp");
}

function get_player_session_xp() {
  return self getplayerdata("cp", "alienSession", "experience");
}

function set_player_session_xp(experience) {
  self setplayerdata("cp", "alienSession", "experience", experience);
}

function give_player_session_xp(amount) {
  var_14df04841b1b0b82 = get_player_session_xp();
  var_212f891deb05826f = amount + var_14df04841b1b0b82;
  set_player_session_xp(var_212f891deb05826f);
}

function set_player_session_rankup(var_bcc31a3789b5b577) {
  self setplayerdata("cp", "alienSession", "ranked_up", int(var_bcc31a3789b5b577));
}

function get_player_session_rankup() {
  return self getplayerdata("cp", "alienSession", "ranked_up");
}

function update_player_session_rankup(var_bcc31a3789b5b577) {
  if(!isDefined(var_bcc31a3789b5b577)) {
    var_bcc31a3789b5b577 = 1;
  }

  var_fe4aaed2e4a534d9 = get_player_session_rankup();
  var_e1709efacf76886 = var_bcc31a3789b5b577 + var_fe4aaed2e4a534d9;
  set_player_session_rankup(var_e1709efacf76886);
}

function set_player_rank(rank) {
  self setplayerdata("cp", "progression", "playerLevel", "rank", rank);
}

function set_player_xp(xp) {
  self setplayerdata("cp", "progression", "playerLevel", "xp", xp);

  if(isDefined(self.totalxpearned)) {
    self setplayerdata("common", "round", "totalXp", self.totalxpearned);
  }
}

function set_player_prestige(prestige) {
  self setplayerdata("cp", "progression", "playerLevel", "prestige", prestige);
  self setplayerdata("cp", "progression", "playerLevel", "xp", 0);
  self setplayerdata("cp", "progression", "playerLevel", "rank", 0);
}

function get_rank_by_xp(xp) {
  rank = 0;

  if(xp >= level.zombie_ranks[level.zombie_max_rank].xp["max"]) {
    return level.zombie_max_rank;
  }

  if(isDefined(level.zombie_ranks)) {
    for(i = 0; i < level.zombie_ranks.size; i++) {
      if(xp >= level.zombie_ranks[i].xp["min"]) {
        if(xp < level.zombie_ranks[i].xp["max"]) {
          rank = level.zombie_ranks[i].id;
          break;
        }
      }
    }
  }

  return rank;
}

function get_scaled_xp(player, xp) {
  return int(xp * get_level_xp_scale(player) * get_weapon_passive_xp_scale(player));
}

function get_level_xp_scale(player) {
  if(isDefined(player.xpscale)) {
    return player.xpscale;
  }

  return 1;
}

function get_weapon_passive_xp_scale(player) {
  if(isDefined(player.weapon_passive_xp_multiplier) && istrue(player.kill_with_extra_xp_passive)) {
    player.kill_with_extra_xp_passive = 0;
    return player.weapon_passive_xp_multiplier;
  }

  return 1;
}

function give_player_xp(xp, display) {
  xp = get_scaled_xp(self, xp);

  if(isDefined(self.totalxpearned)) {
    self.totalxpearned += xp;
  }

  thread give_player_session_xp(xp);
  var_8d8b9714bd8cf0e0 = 0;
  old_rank = get_player_rank();
  old_xp = get_player_xp();
  new_xp = old_xp + xp;

  if(getdvarint(@ "hash_3f0687e1f394289") == 1) {
    iprintln("<dev string:x83>" + xp + "<dev string:x85>" + new_xp + "<dev string:x8a>");
  }

  set_player_xp(new_xp);

  if(istrue(display) && xp > 0 && !is_wave_gametype()) {
    self setclientomnvar("zom_xp_reward", xp);
    self setclientomnvar("zom_xp_notify", gettime());
  }

  new_rank = get_rank_by_xp(new_xp);

  if(new_rank > old_rank) {
    if(new_rank == level.zombie_max_rank + 1) {
      var_8d8b9714bd8cf0e0 = 1;
    }

    set_player_rank(new_rank);

    if(var_8d8b9714bd8cf0e0 == 0) {
      display_rank = new_rank + 1;
      splashref = get_splash_by_id(new_rank);
      self notify("ranked_up", new_rank);
      update_player_session_rankup();

      if(getdvarint(@ "hash_3f0687e1f394289") == 1) {
        iprintlnbold("<dev string:x8c>" + new_rank + "<dev string:x9b>" + new_xp + "<dev string:x8a>");
      }
    }

    process_rank_merits(new_rank);
  }
}

function process_rank_merits(rank) {
  scripts\cp\cp_merits::processmerit("mt_prestige_1");

  if(rank >= 40) {
    scripts\cp\cp_merits::processmerit("mt_prestige_2");
  }

  if(rank >= 60) {
    scripts\cp\cp_merits::processmerit("mt_prestige_3");
  }

  if(rank >= 80) {
    scripts\cp\cp_merits::processmerit("mt_prestige_4");
  }

  if(rank >= 100) {
    scripts\cp\cp_merits::processmerit("mt_prestige_5");
  }

  if(rank >= 120) {
    scripts\cp\cp_merits::processmerit("mt_prestige_6");
  }

  if(rank >= 140) {
    scripts\cp\cp_merits::processmerit("mt_prestige_7");
  }

  if(rank >= 160) {
    scripts\cp\cp_merits::processmerit("mt_prestige_8");
  }

  if(rank >= 180) {
    scripts\cp\cp_merits::processmerit("mt_prestige_9");
  }

  if(rank >= 200) {
    scripts\cp\cp_merits::processmerit("mt_prestige_10");
  }
}

function have_clan_tag(player_name) {
  return issubstr(player_name, "[") && issubstr(player_name, "]");
}

function remove_clan_tag(player_name) {
  var_da6c08cd3d3bf1d6 = strtok(player_name, "]");
  return var_da6c08cd3d3bf1d6[1];
}

function register_eog_to_lb_playerdata_mapping() {
  var_ed47df0b615478af = [];
  eog_to_lb_playerdata_mapping["kills"] = "kills";
  eog_to_lb_playerdata_mapping["deployables"] = "deployables";
  eog_to_lb_playerdata_mapping["drillplants"] = "drillPlants";
  eog_to_lb_playerdata_mapping["revives"] = "revives";
  eog_to_lb_playerdata_mapping["downs"] = "downed";
  eog_to_lb_playerdata_mapping["drillrestarts"] = "repairs";
  eog_to_lb_playerdata_mapping["score"] = "score";
  eog_to_lb_playerdata_mapping["currencyspent"] = "currencySpent";
  eog_to_lb_playerdata_mapping["currencytotal"] = "currencyTotal";
  eog_to_lb_playerdata_mapping["waveNum"] = "waveNum";
  level.eog_to_lb_playerdata_mapping = eog_to_lb_playerdata_mapping;
}

function get_mapped_lb_ref_from_eog_ref(eog_ref) {
  return level.eog_to_lb_playerdata_mapping[eog_ref];
}

function record_player_kills(sweapon, shitloc, smeansofdeath, player) {
  if(isheadshot(sweapon, shitloc, smeansofdeath, player)) {
    increment_player_career_headshot_kills(player);
    player eog_player_update_stat("headShots", 1);
  }

  player increment_player_career_kills(player);
  player eog_player_update_stat("kills", 1);
  player scripts\cp\cp_analytics::log_event("zombie_death", 1, [player.clientid], [player.clientid], [player.clientid]);
}

function increment_player_career_shots_fired(player) {
  increment_zombiecareerstats(player, "Shots_Fired", 1);
}

function increment_player_career_downs(player) {
  player increment_zombiecareerstats(player, "Downs", 1);

  if(should_update_leaderboard_stats()) {
    updateleaderboardstats(player, "Downs", 1, level.script, level.players.size, 1);
  }
}

function increment_player_career_kills(player) {
  increment_zombiecareerstats(player, "Kills", 1);

  if(should_update_leaderboard_stats()) {
    updateleaderboardstats(player, "Kills", 1, level.script, level.players.size, 1);
  }
}

function increment_player_career_headshot_kills(player) {
  player increment_zombiecareerstats(player, "Headshot_Kills", 1);

  if(should_update_leaderboard_stats()) {
    updateleaderboardstats(player, "Headshots", 1, level.script, level.players.size, 1);
  }
}

function increment_player_career_revives(player) {
  player increment_zombiecareerstats(player, "Revives", 1);

  if(should_update_leaderboard_stats()) {
    updateleaderboardstats(player, "Revives", 1, level.script, level.players.size, 1);
  }
}

function should_update_leaderboard_stats() {
  return istrue(level.leaderboard_enabled);
}

function update_player_career_highest_wave(player, var_5675a729bbd6aa36, var_de7821bc51ab43a0) {
  if(is_wave_gametype()) {
    updateifgreaterthan_zombiecareerstats(player, "Highest_Wave", var_5675a729bbd6aa36);
    check_and_update_best_stats(player, var_5675a729bbd6aa36, "Highest_Wave", level.script, var_de7821bc51ab43a0);
    updateleaderboardstats(player, "Rounds", var_5675a729bbd6aa36, level.script, var_de7821bc51ab43a0, 1);
  }
}

function increment_zombiecareerstats(player, stats_name, increment_amount) {
  if(!isDefined(increment_amount)) {
    increment_amount = 1;
  }

  old_value = player getplayerdata("cp", "coopCareerStats", stats_name);
  new_value = old_value + increment_amount;
  player setplayerdata("cp", "coopCareerStats", stats_name, int(new_value));
}

function updateifgreaterthan_zombiecareerstats(player, stats_name, new_value) {
  old_value = player getplayerdata("cp", "coopCareerStats", stats_name);

  if(new_value > old_value) {
    player setplayerdata("cp", "coopCareerStats", stats_name, new_value);
  }
}

function check_and_update_best_stats(player, new_value, stats_name, map_name, var_de7821bc51ab43a0, reverse) {
  if(should_update_leaderboard_stats()) {
    old_value = player getplayerdata("cp", "leaderboarddata", map_name, "leaderboardDataPerMap", var_de7821bc51ab43a0, stats_name);

    if(!istrue(reverse)) {
      if(new_value > old_value) {
        player setplayerdata("cp", "leaderboarddata", map_name, "leaderboardDataPerMap", var_de7821bc51ab43a0, stats_name, new_value);
      }

      return;
    }

    if(new_value < old_value) {
      player setplayerdata("cp", "leaderboarddata", map_name, "leaderboardDataPerMap", var_de7821bc51ab43a0, stats_name, new_value);
    }
  }
}

function updateleaderboardstats(player, stats_name, new_value, map_name, var_de7821bc51ab43a0, increment_amount) {
  if(should_update_leaderboard_stats()) {
    if(!isDefined(increment_amount)) {
      increment_amount = 1;
    }

    old_value = player getplayerdata("cp", "leaderboarddata", map_name, "leaderboardDataPerMap", var_de7821bc51ab43a0, stats_name);
    new_value = old_value + increment_amount;

    if(new_value > old_value) {
      player setplayerdata("cp", "leaderboarddata", map_name, "leaderboardDataPerMap", var_de7821bc51ab43a0, stats_name, new_value);
    }
  }
}