/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_persistence.gsc
***********************************************/

function set_perk(var0) {
  self[[level.coop_perk_callbacks[var0].set]]();
}

function unset_perk(var0) {
  self[[level.coop_perk_callbacks[var0].unset]]();
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
  var0 = getdvarint("scr_start_currency", 0);

  if(var0 != 0) {
    return var0;
  }

  if(isDefined(level.starting_currency)) {
    return level.starting_currency;
  }

  return 0;
}

function wait_to_set_player_currency(var0) {
  self endon("disconnect");
  level endon("game_ended");
  wait 1;
  set_player_currency(var0);
}

function ref_130aa(var0) {
  self setplayerdata("cp", "coopCareerStats", "currency", int(var0));
}

function set_player_currency(var0) {
  if(level.gametype != "cp_pvpve") {
    self setplayerdata("cp", "alienSession", "currency", int(var0));
    eog_player_update_stat("currency", int(var0), 1);
    return;
  }
}

function give_player_currency(var0, var1, var2, var3, var4, var5) {
  if(!isPlayer(self)) {
    return;
  }

  if(scripts\cp\utility::isnmlactive() && !istrue(var5)) {
    return;
  }

  if(scripts\cp\utility::tryingtoleave()) {
    return;
  }

  if(!istrue(var3)) {
    var0 = int(var0 * scripts\cp\perks\cp_prestige::prestige_getmoneyearnedscalar());
    var0 = scripts\cp\cp_gamescore::round_up_to_nearest(var0, 5);
  }

  if(isDefined(level.currency_scale_func)) {
    var0 = [[level.currency_scale_func]](self, var0);
  }

  var6 = get_player_currency();
  var7 = get_player_max_currency();
  var8 = var6 + var0;
  var8 = min(var8, var7);

  if(!isDefined(self.total_currency_earned)) {
    self.total_currency_earned = var0;
  }

  if(is_valid_give_type(var4)) {
    self.total_currency_earned += var8 - var6;
    self notify("consumable_charge", var0 * 0.5);
  }

  level notify("currency_changed");
  eog_player_update_stat("currencytotal", int(self.total_currency_earned), 1);

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    set_player_currency(var8);
    thread scripts\cp\drone\emp_drone::scorepointspopup(var0, 1);
  } else {
    return;
  }

  if(isDefined(level.update_money_performance)) {
    [[level.update_money_performance]](self, var0);
  }

  var9 = 30000;
  var10 = gettime();

  if(var8 >= var7) {
    if(!isDefined(self.next_maxmoney_hint_time)) {
      self.next_maxmoney_hint_time = var10 + var9;
    } else if(var10 < self.next_maxmoney_hint_time) {
      return;
    }

    if(!level.gameended) {
      scripts\cp\utility::setlowermessage("maxmoney", &"COOP_GAME_PLAY/MONEY_MAX", 4);
      self.next_maxmoney_hint_time = var10 + var9;
    }
  }

  if(is_valid_give_type(var4)) {
    thread scripts\cp\utility::add_to_notify_queue("player_earned_money", var0);
  }

  self notify("currency_earned", var0);
}

function is_valid_give_type(var0) {
  if(!isDefined(var0)) {
    return true;
  }

  switch (var0) {
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

function take_player_currency(var0, var1, var2, var3) {
  if(scripts\cp\utility::isnmlactive()) {
    return;
  }

  var4 = get_player_currency();
  var5 = max(0, var4 - var0);
  var6 = int(var4 - var5);

  if(getDvar("MOLPOSLOMO") != "zombie") {
    set_player_currency(var5);
    return;
  }

  if(isDefined(level.chaos_update_spending_currency_event)) {
    [[level.chaos_update_spending_currency_event]](self, var2, var3);
  }

  if(scripts\cp\utility::is_consumable_active("next_purchase_free") && var0 >= 1 && var2 != "atm" && var2 != "laststand" && var2 != "bleedoutPenalty") {
    scripts\cp\utility::notify_used_consumable("next_purchase_free");
  } else {
    set_player_currency(var5);
  }

  if(var6 < 1) {
    return;
  }

  if(isDefined(var2)) {
    scripts\cp\cp_analytics::update_spending_type(var6, var2);
  }

  eog_player_update_stat("currencyspent", var6);

  if(scripts\cp\utility::is_consumable_active("door_buy_refund") && var0 > 0) {
    if(var2 != "atm" && var2 != "laststand" && var2 != "bleedoutPenalty") {
      give_player_currency(int(var6 * 0.3), undefined, undefined, 1, "bonus");
      scripts\cp\utility::notify_used_consumable("door_buy_refund");
    }
  }

  if(scripts\cp\cp_interaction::should_interaction_fill_consumable_meter(var2)) {
    self notify("consumable_charge", var0 * 0.07);
  }

  if(isDefined(var1) && var1) {
    return;
  }
}

function player_has_enough_currency(var0, var1) {
  if(scripts\cp\utility::isnmlactive()) {
    return true;
  }

  if(!isDefined(var1) || isDefined(var1) && var1 != "atm" && var1 != "laststand" && var1 != "bleedoutPenalty") {
    if(scripts\cp\utility::is_consumable_active("next_purchase_free")) {
      var0 = 0;
    }
  }

  var2 = get_player_currency();
  return var2 >= var0;
}

function try_take_player_currency(var0) {
  if(player_has_enough_currency(var0)) {
    take_player_currency(var0);
    return 1;
  }

  return 0;
}

function is_unlocked(var0) {
  var1 = undefined;
  var1 = strtok(var0, "_")[0];
  var2 = level.combat_resource[var0].unlock;
  var3 = get_player_rank();
  return var3 >= var2;
}

function player_persistence_init() {
  level.zombie_xp = undefined;
  set_player_session_xp(0);
  set_player_session_rankup(0);
}

function setcoopplayerdata_for_everyone(var0, var1, var2, var3, var4) {
  foreach(var6 in level.players) {
    if(isDefined(var0) && isDefined(var1) && isDefined(var2) && isDefined(var3) && isDefined(var4)) {
      var6 setplayerdata("cp", var0, var1, var2, var3, var4);
      continue;
    }

    if(isDefined(var0) && isDefined(var1) && isDefined(var2) && isDefined(var3) && !isDefined(var4)) {
      var6 setplayerdata("cp", var0, var1, var2, var3);
      continue;
    }

    if(isDefined(var0) && isDefined(var1) && isDefined(var2) && !isDefined(var3) && !isDefined(var4)) {
      var6 setplayerdata("cp", var0, var1, var2);
      continue;
    }

    if(isDefined(var0) && isDefined(var1) && !isDefined(var2) && !isDefined(var3) && !isDefined(var4)) {
      var6 setplayerdata("cp", var0, var1);
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
  var0 = "cp/cp_eog_tracking_types.csv";

  for(var1 = 0;; var1++) {
    var2 = tablelookupbyrow(var0, var1, 0);

    if(var2 == "") {
      break;
    }

    level.eogtracking[var1] = tablelookup(var0, 0, var1, 1);
  }
}

function eog_player_tracking_init() {
  self endon("disconnect");
  wait 0.5;
  var0 = self getentitynumber();
  var1 = "unknownPlayer";

  if(isDefined(self.name)) {
    var1 = self.name;
  }

  if(self isconsoleplayer()) {
    if(have_clan_tag(var1)) {
      var1 = remove_clan_tag(var1);
    }
  }

  var2 = 8;

  for(var3 = 0; var3 < var2; var3++) {
    self setplayerdata("cp", "EoGPlayer", var3, "connected", 0);
  }

  foreach(var5 in level.players) {
    reset_eog_stats(var5, var0);
    var5 setplayerdata("cp", "EoGPlayer", var0, "connected", 1);
    var5 setplayerdata("cp", "EoGPlayer", var0, "name", var1);
    var5 setplayerdata("common", "round", "totalXp", 0);
  }

  var7 = [0, 0, 0, 0];

  foreach(var9 in level.players) {
    var10 = var9 getentitynumber();
    var7 = 1;

    if(var9 == self) {
      continue;
    }

    var0 = var9 getentitynumber();
    var11 = var9 getplayerdata("cp", "EoGPlayer", var0, "connected");
    self setplayerdata("cp", "EoGPlayer", var0, "connected", var11);

    for(var3 = 0; var3 < level.eogtracking.size; var3++) {
      var12 = var9 getplayerdata("cp", "EoGPlayer", var0, level.eogtracking[var3]);

      if(level.eogtracking[var3] != "currency" && getDvar("MOLPOSLOMO") != "cp_pvpve") {
        self setplayerdata("cp", "EoGPlayer", var0, level.eogtracking[var3], var12);
      }
    }
  }

  foreach(var15 in var7) {
    if(!var15) {
      reset_eog_stats(var16);
    }
  }
}

function reset_eog_stats(var0) {
  for(var1 = 0; var1 < level.eogtracking.size; var1++) {
    if(level.eogtracking[var1] == "name") {
      self setplayerdata("cp", "EoGPlayer", var0, level.eogtracking[var1], "");
      continue;
    }

    self setplayerdata("cp", "EoGPlayer", var0, level.eogtracking[var1], 0);
  }
}

function eog_setup_track_items() {
  if(!isDefined(level.eogscoreboard)) {
    level.eogscoreboard = ["currency", "kills", "headShots", "downs", "revives"];
  }

  clear_eog_tracking_types();

  for(var0 = 0; var0 < level.eogscoreboard.size; var0++) {
    var1 = int(get_eog_tracking_idx(level.eogscoreboard[var0]));
    self setplayerdata("cp", "CPSession", "eogTrackingIdx", var0, var1);
  }
}

function clear_eog_tracking_types() {
  for(var0 = 0; var0 < 7; var0++) {
    self setplayerdata("cp", "CPSession", "eogTrackingIdx", var0, 99);
  }
}

function get_eog_tracking_idx(var0) {
  return tablelookup("cp/cp_eog_tracking_types.csv", 1, var0, 0);
}

function eog_update_on_player_disconnect(var0) {
  if(scripts\cp\cp_endgame::gamealreadyended()) {
    return;
  }

  var1 = var0 getentitynumber();
  setcoopplayerdata_for_everyone("EoGPlayer", var1, "connected", 0);
}

function eog_player_update_stat(var0, var1, var2) {
  var3 = self getentitynumber();
  var4 = var1;

  if(!isDefined(var2) || !var2) {
    var5 = self getplayerdata("cp", "EoGPlayer", var3, var0);
    var4 = int(var5) + int(var1);
  }

  try_update_lb_playerdata(var0, var4, 1);
  setcoopplayerdata_for_everyone("EoGPlayer", var3, var0, var4);

  if(isDefined(level.eogscoringtable)) {
    update_eog_totals_for_stat_ref(var0, var4);
    return;
  }
}

function update_eog_totals_for_stat_ref(var0, var1) {
  for(var2 = 0; var2 < level.eogscoringtable.size; var2++) {
    if(level.eogscoringtable[var2].ref == var0) {
      level.eogscoringtable[var2].curamount = var1;
    }
  }
}

function eog_player_update_pvpve_downs(var0, var1) {
  var2 = self getentitynumber();
  setcoopplayerdata_for_everyone("EoGPlayer", var2, var0, var1);
}

function try_update_lb_playerdata(var0, var1, var2) {
  var3 = get_mapped_lb_ref_from_eog_ref(var0);

  if(!isDefined(var3)) {
    return;
  }

  lb_player_update_stat(var3, var1, var2);
}

function lb_player_update_stat(var0, var1, var2) {
  jumpiffalse(istrue(var2)) LOC_00000012;
  var3 = var1;
  goto LOC_0000002c;
}

function weapons_tracking_init() {
  self.persistence_weaponstats = [];

  foreach(var1 in level.collectibles) {
    if(strtok(var3, "_")[0] == "weapon") {
      var2 = get_base_weapon_name(var3);
      self.persistence_weaponstats[var2] = 1;
    }
  }

  thread player_weaponstats_track_shots();
}

function get_base_weapon_name(var0) {
  var1 = "";
  var2 = undefined;

  if(issameweapon(var0)) {
    var2 = var0.basename;
  } else {
    var2 = var0;
  }

  var3 = strtok(var2, "_");

  for(var4 = 0; var4 < var3.size; var4++) {
    var5 = var3[var4];

    if(var5 == "weapon" && var4 == 0) {
      continue;
    }

    if(var5 == "zm") {
      var1 += "zm";
      break;
    }

    if(var4 < var3.size - 1) {
      var1 += var5 + "_";
      continue;
    }

    var1 += var5;
    break;
  }

  if(var1 == "") {
    return "none";
  }

  return var1;
}

function weaponstats_reset(var0, var1) {
  self setplayerdata("cp", var0, var1, "hits", 0);
  self setplayerdata("cp", var0, var1, "shots", 0);
  self setplayerdata("cp", var0, var1, "kills", 0);
}

function update_weaponstats_hits(var0, var1, var2) {
  if(!is_valid_weapon_hit(var0, var2)) {
    return;
  }

  update_weaponstats("weaponStats", var0, "hits", var1);
  var3 = "personal";

  if(isDefined(level.personal_score_component_name)) {
    var3 = level.personal_score_component_name;
  }

  scripts\cp\cp_gamescore::update_personal_encounter_performance(var3, "shots_hit", var1);
}

function is_valid_weapon_hit(var0, var1) {
  if(var0 == "none") {
    return false;
  }

  if(var1 == "MOD_MELEE") {
    return false;
  }

  if(no_weapon_fired_notify(var0)) {
    return false;
  }

  return true;
}

function no_weapon_fired_notify(var0) {
  switch (var0) {
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

function update_weaponstats_shots(var0, var1) {
  if(!self.should_track_weapon_fired) {
    return;
  }

  update_weaponstats("weaponStats", var0, "shots", var1);
  var2 = "personal";

  if(isDefined(level.personal_score_component_name)) {
    var2 = level.personal_score_component_name;
  }

  scripts\cp\cp_gamescore::update_personal_encounter_performance(var2, "shots_fired", var1);
}

function update_weaponstats_kills(var0, var1) {
  update_weaponstats("weaponStats", var0, "kills", var1);
}

function update_weaponstats(var0, var1, var2, var3) {
  if(!isPlayer(self)) {
    return;
  }

  var4 = get_base_weapon_name(var1);

  if(!isDefined(var4) || !isDefined(self.persistence_weaponstats[var4])) {
    return;
  }

  if(isDefined(level.weapon_stats_override_name_func)) {
    var4 = [[level.weapon_stats_override_name_func]](var4);
  }

  if(issubstr(var4, "dlc")) {
    var5 = strtok(var4, "d");
    var4 = var5[0] + "DLC";
    var5 = strtok(var5[1], "c");
    var4 += var5[1];
  }

  var6 = int(self getplayerdata("cp", var0, var4, var2));
  var7 = var6 + int(var3);
  self setplayerdata("cp", var0, var4, var2, var7);
}

function player_weaponstats_track_shots() {
  self endon("disconnect");
  self notify("weaponstats_track_shots");
  self endon("weaponstats_track_shots");

  for(;;) {
    self waittill("weapon_fired", var0);

    if(!isDefined(var0)) {
      continue;
    }

    var1 = undefined;

    if(isDefined(var0)) {
      var1 = createheadicon(var0);
    }

    var2 = 1;
    update_weaponstats_shots(var1, var2);
  }
}

function rank_init() {
  if(!isDefined(level.zombie_ranks_table)) {
    level.zombie_ranks_table = "cp/zombies/rankTable.csv";
  }

  level.zombie_ranks = [];
  level.zombie_max_rank = int(tablelookup(level.zombie_ranks_table, 0, "maxrank", 1));

  for(var0 = 0; var0 <= level.zombie_max_rank; var0++) {
    var1 = get_ref_by_id(var0);

    if(var1 == "") {
      break;
    }

    if(!isDefined(level.zombie_ranks[var0])) {
      var2 = spawnStruct();
      var2.id = var0;
      var2.ref = var1;
      var2.lvl = get_level_by_id(var0);
      var2.icon = get_icon_by_id(var0);
      var2.tokenreward = get_token_reward_by_id(var0);
      var2.xp = [];
      var2.xp["min"] = get_minxp_by_id(var0);
      var2.xp["next"] = get_nextxp_by_id(var0);
      var2.xp["max"] = get_maxxp_by_id(var0);
      var2.name = [];
      var2.name["short"] = get_shortrank_by_id(var0);
      var2.name["full"] = get_fullrank_by_id(var0);
      var2.name["ingame"] = get_ingamerank_by_id(var0);
      level.zombie_ranks[var0] = var2;
    }
  }
}

function get_ref_by_id(var0) {
  return tablelookup(level.zombie_ranks_table, 0, var0, 1);
}

function get_minxp_by_id(var0) {
  return int(tablelookup(level.zombie_ranks_table, 0, var0, 2));
}

function get_maxxp_by_id(var0) {
  return int(tablelookup(level.zombie_ranks_table, 0, var0, 7));
}

function get_nextxp_by_id(var0) {
  return int(tablelookup(level.zombie_ranks_table, 0, var0, 3));
}

function get_level_by_id(var0) {
  return int(tablelookup(level.zombie_ranks_table, 0, var0, 14));
}

function get_shortrank_by_id(var0) {
  return tablelookup(level.zombie_ranks_table, 0, var0, 4);
}

function get_fullrank_by_id(var0) {
  return tablelookup(level.zombie_ranks_table, 0, var0, 5);
}

function get_ingamerank_by_id(var0) {
  return tablelookup(level.zombie_ranks_table, 0, var0, 17);
}

function get_icon_by_id(var0) {
  return tablelookup(level.zombie_ranks_table, 0, var0, 6);
}

function get_token_reward_by_id(var0) {
  return int(tablelookup(level.zombie_ranks_table, 0, var0, 19));
}

function get_splash_by_id(var0) {
  return tablelookup(level.zombie_ranks_table, 0, var0, 8);
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

function set_player_session_xp(var0) {
  self setplayerdata("cp", "alienSession", "experience", var0);
}

function give_player_session_xp(var0) {
  var1 = get_player_session_xp();
  var2 = var0 + var1;
  set_player_session_xp(var2);
}

function get_player_session_tokens() {
  return self getplayerdata("cp", "alienSession", "shots");
}

function set_player_session_tokens(var0) {
  self setplayerdata("cp", "alienSession", "shots", var0);
}

function give_player_session_tokens(var0) {
  var1 = get_player_session_tokens();
  var2 = var0 + var1;
  set_player_session_tokens(var2);
}

function set_player_session_rankup(var0) {
  self setplayerdata("cp", "alienSession", "ranked_up", int(var0));
}

function get_player_session_rankup() {
  return self getplayerdata("cp", "alienSession", "ranked_up");
}

function update_player_session_rankup(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  var1 = get_player_session_rankup();
  var2 = var0 + var1;
  set_player_session_rankup(var2);
}

function set_player_rank(var0) {
  self setplayerdata("cp", "progression", "playerLevel", "rank", var0);
}

function set_player_xp(var0) {
  self setplayerdata("cp", "progression", "playerLevel", "xp", var0);

  if(isDefined(self.totalxpearned)) {
    self setplayerdata("common", "round", "totalXp", self.totalxpearned);
    return;
  }
}

function set_player_prestige(var0) {
  self setplayerdata("cp", "progression", "playerLevel", "prestige", var0);
  self setplayerdata("cp", "progression", "playerLevel", "xp", 0);
  self setplayerdata("cp", "progression", "playerLevel", "rank", 0);
}

function get_rank_by_xp(var0) {
  var1 = 0;

  if(var0 >= level.zombie_ranks[level.zombie_max_rank].xp["max"]) {
    return level.zombie_max_rank;
  }

  if(isDefined(level.zombie_ranks)) {
    for(var2 = 0; var2 < level.zombie_ranks.size; var2++) {
      if(var0 >= level.zombie_ranks[var2].xp["min"]) {
        if(var0 < level.zombie_ranks[var2].xp["max"]) {
          var1 = level.zombie_ranks[var2].id;
          break;
        }
      }
    }
  }

  return var1;
}

function get_scaled_xp(var0, var1) {
  return int(var1 * get_level_xp_scale(var0) * get_weapon_passive_xp_scale(var0));
}

function get_level_xp_scale(var0) {
  if(isDefined(var0.xpscale)) {
    return var0.xpscale;
  }

  return 1;
}

function wait_and_give_player_xp(var0, var1) {
  self endon("disconnect");
  level endon("game_ended");
  wait var1;
  give_player_xp(var0);
}

function get_weapon_passive_xp_scale(var0) {
  if(isDefined(var0.weapon_passive_xp_multiplier) && istrue(var0.kill_with_extra_xp_passive)) {
    var0.kill_with_extra_xp_passive = 0;
    return var0.weapon_passive_xp_multiplier;
  }

  return 1;
}

function give_player_xp(var0, var1) {
  var0 = get_scaled_xp(self, var0);

  if(isDefined(self.totalxpearned)) {
    self.totalxpearned += var0;
  }

  thread give_player_session_xp(var0);
  var2 = 0;
  var3 = get_player_rank();
  var4 = get_player_xp();
  var5 = var4 + var0;
  set_player_xp(var5);

  if(istrue(var1) && var0 > 0 && !scripts\cp\utility::turn_off_sniper_laser()) {
    self setclientomnvar("zom_xp_reward", var0);
    self setclientomnvar("zom_xp_notify", gettime());
  }

  var6 = get_rank_by_xp(var5);

  if(var6 > var3) {
    if(var6 == level.zombie_max_rank + 1) {
      var2 = 1;
    }

    set_player_rank(var6);

    if(var2 == 0) {
      var7 = var6 + 1;
      var8 = get_splash_by_id(var6);
      self notify("ranked_up", var6);
      update_player_session_rankup();
    }

    process_rank_merits(var6);
    return;
  }
}

function process_rank_merits(var0) {
  scripts\cp\cp_merits::processmerit("mt_prestige_1");

  if(var0 >= 40) {
    scripts\cp\cp_merits::processmerit("mt_prestige_2");
  }

  if(var0 >= 60) {
    scripts\cp\cp_merits::processmerit("mt_prestige_3");
  }

  if(var0 >= 80) {
    scripts\cp\cp_merits::processmerit("mt_prestige_4");
  }

  if(var0 >= 100) {
    scripts\cp\cp_merits::processmerit("mt_prestige_5");
  }

  if(var0 >= 120) {
    scripts\cp\cp_merits::processmerit("mt_prestige_6");
  }

  if(var0 >= 140) {
    scripts\cp\cp_merits::processmerit("mt_prestige_7");
  }

  if(var0 >= 160) {
    scripts\cp\cp_merits::processmerit("mt_prestige_8");
  }

  if(var0 >= 180) {
    scripts\cp\cp_merits::processmerit("mt_prestige_9");
  }

  if(var0 >= 200) {
    scripts\cp\cp_merits::processmerit("mt_prestige_10");
    return;
  }
}

function inc_stat(var0, var1, var2) {
  var3 = self getplayerdata("cp", var0, var1);
  var4 = var3 + var2;
  self setplayerdata("cp", var0, var1, var4);
}

function inc_session_stat(var0, var1) {
  inc_stat("alienSession", var0, var1);
}

function get_hives_destroyed_stat() {
  return get_aliensession_stat("hivesDestroyed");
}

function get_aliensession_stat(var0) {
  return self getplayerdata("cp", "alienSession", var0);
}

function set_aliensession_stat(var0, var1) {
  self setplayerdata("cp", "alienSession", var0, var1);
}

function update_deployable_box_performance(var0) {
  if(isDefined(level.update_deployable_box_performance_func)) {
    var0[[level.update_deployable_box_performance_func]]();
    return;
  }

  var0 scripts\cp\cp_gamescore::update_personal_encounter_performance(scripts\cp\cp_gamescore::get_team_score_component_name(), "team_support_deploy");
}

function update_lb_aliensession_challenge(var0) {
  foreach(var2 in level.players) {
    lb_player_update_stat(var2, "challengesAttempted", 1);

    if(var0) {
      lb_player_update_stat(var2, "challengesCompleted", 1);
    }
  }
}

function update_lb_aliensession_wave(var0) {
  foreach(var2 in level.players) {
    lb_player_update_stat(var2, "waveNum", var0, 1);
  }
}

function update_lb_aliensession_escape(var0, var1) {
  var2 = get_lb_escape_rank(var1);

  foreach(var4 in var0) {
    lb_player_update_stat(var4, "escapedRank" + var2, 1, 1);
    lb_player_update_stat(var4, "hits", 1, 1);
  }
}

function update_alien_kill_sessionstats(var0, var1) {
  if(!isDefined(var1) || !isPlayer(var1)) {
    return;
  }

  if(scripts\cp\utility::is_trap(var0)) {
    lb_player_update_stat(var1, "trapKills", 1);
    return;
  }
}

function register_lb_escape_rank(var0) {
  level.escape_rank_array = var0;
}

function get_lb_escape_rank(var0) {
  for(var1 = 0; var1 < level.escape_rank_array.size - 1; var1++) {
    if(var0 >= level.escape_rank_array[var1] && var0 < level.escape_rank_array[var1 + 1]) {
      return var1;
    }
  }
}

function have_clan_tag(var0) {
  return issubstr(var0, "[") && issubstr(var0, "]");
}

function remove_clan_tag(var0) {
  var1 = strtok(var0, "]");
  return var1[1];
}

function register_eog_to_lb_playerdata_mapping() {
  var0 = [];
  GscBinSkip1(0x45, "kills", "kills");
}

function get_mapped_lb_ref_from_eog_ref(var0) {
  return level.eog_to_lb_playerdata_mapping[var0];
}

function play_time_monitor() {
  self endon("disconnect");

  for(;;) {
    wait 1;
    lb_player_update_stat("time", 1);
  }
}

function record_player_kills(var0, var1, var2, var3) {
  if(scripts\cp\utility::isheadshot(var0, var1, var2, var3)) {
    increment_player_career_headshot_kills(var3);
    eog_player_update_stat(var3, "headShots", 1);
  }

  increment_player_career_kills(var3, var3);
  eog_player_update_stat(var3, "kills", 1);
  var3 scripts\cp\cp_analytics::log_event("zombie_death", 1, [var3.clientid], [var3.clientid], [var3.clientid]);
}

function increment_player_career_total_waves(var0) {
  if(isDefined(var0.wave_num_when_joined)) {
    increment_zombiecareerstats(var0, "Total_Waves", level.wave_num - var0.wave_num_when_joined);
    return;
  }

  increment_zombiecareerstats(var0, "Total_Waves", level.wave_num);
}

function increment_player_career_total_score(var0) {
  increment_zombiecareerstats(var0, "Total_Score", var0.score_earned);
}

function increment_player_career_shots_fired(var0) {
  increment_zombiecareerstats(var0, "Shots_Fired", 1);
}

function increment_player_career_shots_on_target(var0) {
  increment_zombiecareerstats(var0, "Shots_on_Target", 1);
}

function increment_player_career_explosive_kills(var0) {
  increment_zombiecareerstats(var0, "Explosive_Kills", 1);
}

function increment_player_career_doors_opened(var0) {
  increment_zombiecareerstats(var0, "Doors_Opened", 1);
}

function increment_player_career_perks_used(var0) {
  increment_zombiecareerstats(var0, "Perks_Used", 1);
}

function increment_player_career_kills(var0) {
  increment_zombiecareerstats(var0, "Kills", 1);

  if(should_update_leaderboard_stats()) {
    updateleaderboardstats(var0, "Kills", 1, level.script, level.players.size, 1);
    return;
  }
}

function increment_player_career_headshot_kills(var0) {
  increment_zombiecareerstats(var0, var0, "Headshot_Kills", 1);

  if(should_update_leaderboard_stats()) {
    updateleaderboardstats(var0, "Headshots", 1, level.script, level.players.size, 1);
    return;
  }
}

function increment_player_career_revives(var0) {
  increment_zombiecareerstats(var0, var0, "Revives", 1);

  if(should_update_leaderboard_stats()) {
    updateleaderboardstats(var0, "Revives", 1, level.script, level.players.size, 1);
    return;
  }
}

function increment_player_career_downs(var0) {
  increment_zombiecareerstats(var0, var0, "Downs", 1);

  if(should_update_leaderboard_stats()) {
    updateleaderboardstats(var0, "Downs", 1, level.script, level.players.size, 1);
    return;
  }
}

function mortars_get_player_targeted() {
  level.watchtrigger = 1;
}

function should_update_leaderboard_stats() {
  return istrue(level.watchtrigger);
}

function update_players_career_highest_wave(var0, var1) {
  foreach(var3 in level.players) {
    update_player_career_highest_wave(var3, var0, var1, level.players.size);
  }
}

function update_player_career_highest_wave(var0, var1, var2) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    updateifgreaterthan_zombiecareerstats(var0, "Highest_Wave", var1);
    check_and_update_best_stats(var0, var1, "Highest_Wave", level.script, var2);
    updateleaderboardstats(var0, "Rounds", var1, level.script, var2, 1);
    return;
  }
}

function increment_zombiecareerstats(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 1;
  }

  var3 = var0 getplayerdata("cp", "coopCareerStats", var1);
  var4 = var3 + var2;
  var0 setplayerdata("cp", "coopCareerStats", var1, int(var4));
}

function updateifgreaterthan_zombiecareerstats(var0, var1, var2) {
  var3 = var0 getplayerdata("cp", "coopCareerStats", var1);

  if(var2 > var3) {
    var0 setplayerdata("cp", "coopCareerStats", var1, var2);
    return;
  }
}

function update_highest_wave_lb(var0, var1, var2, var3, var4) {
  var5 = var0 getplayerdata("cp", "leaderboarddata", var3, "leaderboardDataPerMap", var4, var2);

  if(var1 > var5) {
    var0 setplayerdata("cp", "leaderboarddata", var3, "leaderboardDataPerMap", var4, var2, var1);
    return;
  }
}

function check_and_update_best_stats(var0, var1, var2, var3, var4, var5) {
  if(should_update_leaderboard_stats()) {
    var6 = var0 getplayerdata("cp", "leaderboarddata", var3, "leaderboardDataPerMap", var4, var2);

    if(!istrue(var5)) {
      if(var1 > var6) {
        var0 setplayerdata("cp", "leaderboarddata", var3, "leaderboardDataPerMap", var4, var2, var1);
        return;
      }

      return;
    }

    if(var1 < var6) {
      var0 setplayerdata("cp", "leaderboarddata", var3, "leaderboardDataPerMap", var4, var2, var1);
      return;
    }

    return;
  }
}

function updateleaderboardstats(var0, var1, var2, var3, var4, var5) {
  if(should_update_leaderboard_stats()) {
    if(!isDefined(var5)) {
      var5 = 1;
    }

    var6 = var0 getplayerdata("cp", "leaderboarddata", var3, "leaderboardDataPerMap", var4, var1);
    var2 = var6 + var5;

    if(var2 > var6) {
      var0 setplayerdata("cp", "leaderboarddata", var3, "leaderboardDataPerMap", var4, var1, var2);
      return;
    }

    return;
  }
}