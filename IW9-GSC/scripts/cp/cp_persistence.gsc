/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_persistence.gsc
***********************************************/

set_perk(_id_302DA6E689696DB3) {
  self[[level.coop_perk_callbacks[_id_302DA6E689696DB3].set]]();
}

unset_perk(_id_302DA6E689696DB3) {
  self[[level.coop_perk_callbacks[_id_302DA6E689696DB3].unset]]();
}

get_player_munition_currency() {
  return self getplayerdata("cp", "coopCareerStats", "currency");
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
  _id_C7A775AC491B210F = getdvarint("scr_start_currency", 0);

  if(_id_C7A775AC491B210F != 0)
    return _id_C7A775AC491B210F;

  if(isDefined(level.starting_currency))
    return level.starting_currency;

  return 0;
}

wait_to_set_player_currency(amount) {
  self endon("disconnect");
  level endon("game_ended");
  wait 1.0;
  set_player_currency(amount);
}

set_player_munition_currency(amount) {
  self setplayerdata("cp", "coopCareerStats", "currency", int(amount));
}

set_player_currency(amount) {
  self setplayerdata("cp", "alienSession", "currency", int(amount));
  eog_player_update_stat("currency", int(amount), 1);
}

give_player_currency(amount, _id_F0778934C2C7E788, shitloc, _id_04A46DC3F73A35CB, _id_7F71FF0C9FD703C5, _id_1E921A3666F3D7EC) {
  if(!isPlayer(self)) {
    return;
  }
  if(scripts\cp\utility::isnmlactive() && !istrue(_id_1E921A3666F3D7EC)) {
    return;
  }
  if(scripts\cp\utility::is_specops_gametype()) {
    return;
  }
  if(!istrue(_id_04A46DC3F73A35CB)) {
    amount = int(amount * scripts\cp\perks\cp_prestige::prestige_getmoneyearnedscalar());
    amount = scripts\cp\cp_gamescore::round_up_to_nearest(amount, 5);
  }

  if(isDefined(level.currency_scale_func))
    amount = [[level.currency_scale_func]](self, amount);

  _id_8334742FE1363A27 = get_player_currency();
  _id_B4187EC006E2D1E2 = get_player_max_currency();
  _id_98AFD1CE36F4905A = _id_8334742FE1363A27 + amount;
  _id_98AFD1CE36F4905A = min(_id_98AFD1CE36F4905A, _id_B4187EC006E2D1E2);

  if(!isDefined(self.total_currency_earned))
    self.total_currency_earned = amount;

  if(is_valid_give_type(_id_7F71FF0C9FD703C5)) {
    self.total_currency_earned = self.total_currency_earned + (_id_98AFD1CE36F4905A - _id_8334742FE1363A27);
    self notify("consumable_charge", amount * 0.5);
  }

  level notify("currency_changed");
  eog_player_update_stat("currencytotal", int(self.total_currency_earned), 1);

  if(scripts\cp\utility::is_wave_gametype() || isDefined(_id_7F71FF0C9FD703C5) && _id_7F71FF0C9FD703C5 == "cash_pickup") {
    if(!istrue(level._id_8FDE5731BB1BA3BB) || isDefined(_id_7F71FF0C9FD703C5) && _id_7F71FF0C9FD703C5 == "cash_pickup")
      set_player_currency(_id_98AFD1CE36F4905A);

    thread _id_187A04151C40FB72::scorepointspopup(amount, 1);
  } else
    return;

  if(isDefined(level.update_money_performance))
    [[level.update_money_performance]](self, amount);

  _id_118C957144D452A0 = 30000;
  current_time = gettime();

  if(_id_98AFD1CE36F4905A >= _id_B4187EC006E2D1E2) {
    if(!isDefined(self.next_maxmoney_hint_time))
      self.next_maxmoney_hint_time = current_time + _id_118C957144D452A0;
    else if(current_time < self.next_maxmoney_hint_time) {
      return;
    }
    if(!level.gameended) {
      scripts\cp\utility::setlowermessage("maxmoney", &"COOP_GAME_PLAY/MONEY_MAX", 4);
      self.next_maxmoney_hint_time = current_time + _id_118C957144D452A0;
    }
  }

  if(is_valid_give_type(_id_7F71FF0C9FD703C5))
    thread scripts\cp\utility::add_to_notify_queue("player_earned_money", amount);

  self notify("currency_earned", amount);
}

is_valid_give_type(_id_7F71FF0C9FD703C5) {
  if(!isDefined(_id_7F71FF0C9FD703C5))
    return 1;

  switch (_id_7F71FF0C9FD703C5) {
    case "atm":
    case "magicWheelRefund":
    case "pillage":
    case "carpenter":
    case "bonus":
    case "crafted":
    case "nuke":
      return 0;
    default:
      return 1;
  }

  return 1;
}

take_player_currency(amount, _id_268300D5F447C80C, _id_E42F7EB456B932F2, _id_8D74294401BB1C97) {
  if(scripts\cp\utility::isnmlactive()) {
    return;
  }
  _id_8334742FE1363A27 = get_player_currency();
  _id_98AFD1CE36F4905A = max(0, _id_8334742FE1363A27 - amount);
  _id_D5CEA5C370608022 = int(_id_8334742FE1363A27 - _id_98AFD1CE36F4905A);

  if(getDvar("ui_gametype") != "zombie") {
    set_player_currency(_id_98AFD1CE36F4905A);
    return;
  }

  if(isDefined(level.chaos_update_spending_currency_event))
    [[level.chaos_update_spending_currency_event]](self, _id_E42F7EB456B932F2, _id_8D74294401BB1C97);

  if(scripts\cp\utility::is_consumable_active("next_purchase_free") && amount >= 1 && _id_E42F7EB456B932F2 != "atm" && _id_E42F7EB456B932F2 != "laststand" && _id_E42F7EB456B932F2 != "bleedoutPenalty")
    scripts\cp\utility::notify_used_consumable("next_purchase_free");
  else
    set_player_currency(_id_98AFD1CE36F4905A);

  if(_id_D5CEA5C370608022 < 1) {
    return;
  }
  if(isDefined(_id_E42F7EB456B932F2))
    scripts\cp\cp_analytics::update_spending_type(_id_D5CEA5C370608022, _id_E42F7EB456B932F2);

  eog_player_update_stat("currencyspent", _id_D5CEA5C370608022);

  if(scripts\cp\utility::is_consumable_active("door_buy_refund") && amount > 0) {
    if(_id_E42F7EB456B932F2 != "atm" && _id_E42F7EB456B932F2 != "laststand" && _id_E42F7EB456B932F2 != "bleedoutPenalty") {
      give_player_currency(int(_id_D5CEA5C370608022 * 0.3), undefined, undefined, 1, "bonus");
      scripts\cp\utility::notify_used_consumable("door_buy_refund");
    }
  }

  if(_id_71332A5B74214116::should_interaction_fill_consumable_meter(_id_E42F7EB456B932F2))
    self notify("consumable_charge", amount * 0.07);

  if(isDefined(_id_268300D5F447C80C) && _id_268300D5F447C80C)
    return;
}

player_has_enough_currency(amount, spend_type) {
  if(scripts\cp\utility::isnmlactive())
    return 1;

  if(!isDefined(spend_type) || isDefined(spend_type) && spend_type != "atm" && spend_type != "laststand" && spend_type != "bleedoutPenalty") {
    if(scripts\cp\utility::is_consumable_active("next_purchase_free"))
      amount = 0;
  }

  _id_31877A68C46AF8CA = get_player_currency();
  return _id_31877A68C46AF8CA >= amount;
}

try_take_player_currency(amount) {
  if(player_has_enough_currency(amount)) {
    take_player_currency(amount);
    return 1;
  } else
    return 0;
}

is_unlocked(_id_71AB5DE6311EB0C0) {
  item_type = undefined;
  item_type = strtok(_id_71AB5DE6311EB0C0, "_")[0];
  _id_CFEE318CE5BC7E46 = level.combat_resource[_id_71AB5DE6311EB0C0].unlock;
  _id_275FAE4E460FA6A3 = get_player_rank();
  return _id_275FAE4E460FA6A3 >= _id_CFEE318CE5BC7E46;
}

player_persistence_init() {
  level.zombie_xp = undefined;
  set_player_session_xp(0);
  set_player_session_rankup(0);
}

setcoopplayerdata_for_everyone(_id_F3CB1D51D632B4BA, param1, param2, param3, param4) {
  foreach(index, player in level.players) {
    if(isDefined(_id_F3CB1D51D632B4BA) && isDefined(param1) && isDefined(param2) && isDefined(param3) && isDefined(param4)) {
      player setplayerdata("cp", _id_F3CB1D51D632B4BA, param1, param2, param3, param4);
      continue;
    }

    if(isDefined(_id_F3CB1D51D632B4BA) && isDefined(param1) && isDefined(param2) && isDefined(param3) && !isDefined(param4)) {
      player setplayerdata("cp", _id_F3CB1D51D632B4BA, param1, param2, param3);
      continue;
    }

    if(isDefined(_id_F3CB1D51D632B4BA) && isDefined(param1) && isDefined(param2) && !isDefined(param3) && !isDefined(param4)) {
      player setplayerdata("cp", _id_F3CB1D51D632B4BA, param1, param2);
      continue;
    }

    if(isDefined(_id_F3CB1D51D632B4BA) && isDefined(param1) && !isDefined(param2) && !isDefined(param3) && !isDefined(param4)) {
      player setplayerdata("cp", _id_F3CB1D51D632B4BA, param1);
      continue;
    }
  }
}

session_stats_init() {
  parse_eog_tracking_table();
  eog_setup_track_items();
  thread eog_player_tracking_init();
}

parse_eog_tracking_table() {
  level.eogtracking = [];
  table = "cp/cp_eog_tracking_types.csv";
  _id_CB89110314447B2F = 0;

  for(;;) {
    index = tablelookupbyrow(table, _id_CB89110314447B2F, 0);

    if(index == "") {
      break;
    }

    level.eogtracking[_id_CB89110314447B2F] = tablelookup(table, 0, _id_CB89110314447B2F, 1);
    _id_CB89110314447B2F++;
  }
}

eog_player_tracking_init() {
  self endon("disconnect");
  wait 0.5;
  _id_1DAB4A6BAD01C509 = self getentitynumber();
  _id_55BED569A266A992 = "unknownPlayer";

  if(isDefined(self.name))
    _id_55BED569A266A992 = self.name;

  if(self isconsoleplayer()) {
    if(have_clan_tag(_id_55BED569A266A992))
      _id_55BED569A266A992 = remove_clan_tag(_id_55BED569A266A992);
  }

  numplayers = 8;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < numplayers; _id_AC0E594AC96AA3A8++)
    self setplayerdata("cp", "EoGPlayer", _id_AC0E594AC96AA3A8, "connected", 0);

  foreach(player in level.players) {
    player reset_eog_stats(_id_1DAB4A6BAD01C509);
    player setplayerdata("cp", "EoGPlayer", _id_1DAB4A6BAD01C509, "connected", 1);
    player setplayerdata("cp", "EoGPlayer", _id_1DAB4A6BAD01C509, "name", _id_55BED569A266A992);
    player setplayerdata("common", "round", "totalXp", 0);
  }

  _id_F8335A1C04FB409F = [0, 0, 0, 0];

  foreach(_id_AC0E424AC96A7113 in level.players) {
    _id_35162790AACFAF47 = _id_AC0E424AC96A7113 getentitynumber();
    _id_F8335A1C04FB409F[int(_id_35162790AACFAF47)] = 1;

    if(_id_AC0E424AC96A7113 == self) {
      continue;
    }
    _id_1DAB4A6BAD01C509 = _id_AC0E424AC96A7113 getentitynumber();
    connected = _id_AC0E424AC96A7113 getplayerdata("cp", "EoGPlayer", _id_1DAB4A6BAD01C509, "connected");
    self setplayerdata("cp", "EoGPlayer", _id_1DAB4A6BAD01C509, "connected", connected);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.eogtracking.size; _id_AC0E594AC96AA3A8++) {
      value = _id_AC0E424AC96A7113 getplayerdata("cp", "EoGPlayer", _id_1DAB4A6BAD01C509, level.eogtracking[_id_AC0E594AC96AA3A8]);

      if(level.eogtracking[_id_AC0E594AC96AA3A8] != "currency")
        self setplayerdata("cp", "EoGPlayer", _id_1DAB4A6BAD01C509, level.eogtracking[_id_AC0E594AC96AA3A8], value);
    }
  }

  foreach(index, result in _id_F8335A1C04FB409F) {
    if(!result)
      reset_eog_stats(index);
  }
}

reset_eog_stats(clientnum) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.eogtracking.size; _id_AC0E594AC96AA3A8++) {
    if(level.eogtracking[_id_AC0E594AC96AA3A8] == "name") {
      self setplayerdata("cp", "EoGPlayer", clientnum, level.eogtracking[_id_AC0E594AC96AA3A8], "");
      continue;
    }

    self setplayerdata("cp", "EoGPlayer", clientnum, level.eogtracking[_id_AC0E594AC96AA3A8], 0);
  }
}

eog_setup_track_items() {
  if(!isDefined(level.eogscoreboard))
    level.eogscoreboard = ["currency", "kills", "headShots", "downs", "revives"];

  clear_eog_tracking_types();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.eogscoreboard.size; _id_AC0E594AC96AA3A8++) {
    _id_FE8F7703F6313ED4 = int(get_eog_tracking_idx(level.eogscoreboard[_id_AC0E594AC96AA3A8]));
    self setplayerdata("cp", "CPSession", "eogTrackingIdx", _id_AC0E594AC96AA3A8, _id_FE8F7703F6313ED4);
  }
}

clear_eog_tracking_types() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 7; _id_AC0E594AC96AA3A8++)
    self setplayerdata("cp", "CPSession", "eogTrackingIdx", _id_AC0E594AC96AA3A8, 99);
}

get_eog_tracking_idx(ref) {
  return tablelookup("cp/cp_eog_tracking_types.csv", 1, ref, 0);
}

eog_update_on_player_disconnect(_id_2421296BA8CCB5EE) {
  if(_id_467F0FDFDD155A45::gamealreadyended()) {
    return;
  }
  _id_1DAB4A6BAD01C509 = _id_2421296BA8CCB5EE getentitynumber();
  setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "connected", 0);
}

eog_player_update_stat(_id_6BD45B7708CE4099, amount, _id_9E3067E82AD0CAE3) {
  _id_1DAB4A6BAD01C509 = self getentitynumber();
  _id_98AFD1CE36F4905A = amount;

  if(!isDefined(_id_9E3067E82AD0CAE3) || !_id_9E3067E82AD0CAE3) {
    _id_CEC495ACC42B7073 = self getplayerdata("cp", "EoGPlayer", _id_1DAB4A6BAD01C509, _id_6BD45B7708CE4099);
    _id_98AFD1CE36F4905A = int(_id_CEC495ACC42B7073) + int(amount);
  }

  try_update_lb_playerdata(_id_6BD45B7708CE4099, _id_98AFD1CE36F4905A, 1);
  setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, _id_6BD45B7708CE4099, _id_98AFD1CE36F4905A);

  if(isDefined(level.eogscoringtable))
    update_eog_totals_for_stat_ref(_id_6BD45B7708CE4099, _id_98AFD1CE36F4905A);
}

update_eog_totals_for_stat_ref(_id_6BD45B7708CE4099, amount) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.eogscoringtable.size; _id_AC0E594AC96AA3A8++) {
    if(level.eogscoringtable[_id_AC0E594AC96AA3A8].ref == _id_6BD45B7708CE4099)
      level.eogscoringtable[_id_AC0E594AC96AA3A8].curamount = amount;
  }
}

try_update_lb_playerdata(_id_7B71A32FA025F6E0, _id_98AFD1CE36F4905A, _id_9E3067E82AD0CAE3) {
  _id_D5755432FBFACDBD = get_mapped_lb_ref_from_eog_ref(_id_7B71A32FA025F6E0);

  if(!isDefined(_id_D5755432FBFACDBD)) {
    return;
  }
  lb_player_update_stat(_id_D5755432FBFACDBD, _id_98AFD1CE36F4905A, _id_9E3067E82AD0CAE3);
}

lb_player_update_stat(_id_218835B4B69DBD26, amount, _id_9E3067E82AD0CAE3) {
  if(istrue(_id_9E3067E82AD0CAE3))
    _id_6302CA9978061647 = amount;
  else {
    _id_6AEC809BE13C61CC = self getplayerdata("cp", "alienSession", _id_218835B4B69DBD26);
    _id_6302CA9978061647 = _id_6AEC809BE13C61CC + amount;
  }

  self setplayerdata("cp", "alienSession", _id_218835B4B69DBD26, _id_6302CA9978061647);
}

weapons_tracking_init() {
  self.persistence_weaponstats = [];

  foreach(_id_8D74294401BB1C97, item in level.collectibles) {
    if(strtok(_id_8D74294401BB1C97, "_")[0] == "weapon") {
      base_weapon = get_base_weapon_name(_id_8D74294401BB1C97);
      self.persistence_weaponstats[base_weapon] = 1;
    }
  }

  thread player_weaponstats_track_shots();
}

get_base_weapon_name(weapon) {
  base_weapon = "";
  _id_8D74294401BB1C97 = undefined;

  if(isweapon(weapon))
    _id_8D74294401BB1C97 = weapon.basename;
  else
    _id_8D74294401BB1C97 = weapon;

  _id_4E401DFEBA20836C = strtok(_id_8D74294401BB1C97, "_");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_4E401DFEBA20836C.size; _id_AC0E594AC96AA3A8++) {
    _id_E921CD2D3FB29B66 = _id_4E401DFEBA20836C[_id_AC0E594AC96AA3A8];

    if(_id_E921CD2D3FB29B66 == "weapon" && _id_AC0E594AC96AA3A8 == 0) {
      continue;
    }
    if(_id_E921CD2D3FB29B66 == "zm") {
      base_weapon = base_weapon + "zm";
      break;
    }

    if(_id_AC0E594AC96AA3A8 < _id_4E401DFEBA20836C.size - 1) {
      base_weapon = base_weapon + (_id_E921CD2D3FB29B66 + "_");
      continue;
    }

    base_weapon = base_weapon + _id_E921CD2D3FB29B66;
    break;
  }

  if(base_weapon == "")
    return "none";

  return base_weapon;
}

weaponstats_reset(_id_415D8240D8C76BEC, _id_8D74294401BB1C97) {
  self setplayerdata("cp", _id_415D8240D8C76BEC, _id_8D74294401BB1C97, "hits", 0);
  self setplayerdata("cp", _id_415D8240D8C76BEC, _id_8D74294401BB1C97, "shots", 0);
  self setplayerdata("cp", _id_415D8240D8C76BEC, _id_8D74294401BB1C97, "kills", 0);
}

update_weaponstats_hits(_id_8D74294401BB1C97, hits, smeansofdeath) {
  if(!is_valid_weapon_hit(_id_8D74294401BB1C97, smeansofdeath)) {
    return;
  }
  update_weaponstats("weaponStats", _id_8D74294401BB1C97, "hits", hits);
  _id_A475D6DAA5DD7242 = "personal";

  if(isDefined(level.personal_score_component_name))
    _id_A475D6DAA5DD7242 = level.personal_score_component_name;

  scripts\cp\cp_gamescore::update_personal_encounter_performance(_id_A475D6DAA5DD7242, "shots_hit", hits);
}

is_valid_weapon_hit(_id_8D74294401BB1C97, smeansofdeath) {
  if(_id_8D74294401BB1C97 == "none")
    return 0;

  if(smeansofdeath == "MOD_MELEE")
    return 0;

  if(no_weapon_fired_notify(_id_8D74294401BB1C97))
    return 0;

  return 1;
}

no_weapon_fired_notify(_id_8D74294401BB1C97) {
  switch (_id_8D74294401BB1C97) {
    case "iw7_spiked_bat_zm_pap2":
    case "iw7_machete_zm_pap1":
    case "iw7_two_headed_axe_zm_pap2":
    case "iw7_spiked_bat_zm_pap1":
    case "iw7_spiked_bat_zm":
    case "iw7_two_headed_axe_zm":
    case "iw7_katana_zm_pap2":
    case "iw7_katana_zm_pap1":
    case "iw7_nunchucks_zm_pap2":
    case "iw7_nunchucks_zm_pap1":
    case "iw7_katana_zm":
    case "iw7_nunchucks_zm":
    case "iw7_axe_zm_pap2":
    case "iw7_axe_zm_pap1":
    case "iw7_machete_zm":
    case "iw7_golf_club_zm_pap1":
    case "iw7_two_headed_axe_zm_pap1":
    case "iw7_machete_zm_pap2":
    case "iw7_golf_club_zm_pap2":
    case "iw7_golf_club_zm":
    case "iw7_axe_zm":
      return 1;
    default:
      return 0;
  }
}

update_weaponstats_shots(_id_8D74294401BB1C97, _id_58E50AEE46852766) {
  if(!self.should_track_weapon_fired) {
    return;
  }
  update_weaponstats("weaponStats", _id_8D74294401BB1C97, "shots", _id_58E50AEE46852766);
  _id_A475D6DAA5DD7242 = "personal";

  if(isDefined(level.personal_score_component_name))
    _id_A475D6DAA5DD7242 = level.personal_score_component_name;

  scripts\cp\cp_gamescore::update_personal_encounter_performance(_id_A475D6DAA5DD7242, "shots_fired", _id_58E50AEE46852766);
}

update_weaponstats_kills(_id_8D74294401BB1C97, kills) {
  update_weaponstats("weaponStats", _id_8D74294401BB1C97, "kills", kills);
}

update_weaponstats(_id_415D8240D8C76BEC, _id_8D74294401BB1C97, _id_D0F001B1761FBF53, value) {
  if(!isPlayer(self)) {
    return;
  }
  base_weapon = get_base_weapon_name(_id_8D74294401BB1C97);

  if(!isDefined(base_weapon) || !isDefined(self.persistence_weaponstats[base_weapon])) {
    return;
  }
  if(isDefined(level.weapon_stats_override_name_func))
    base_weapon = [[level.weapon_stats_override_name_func]](base_weapon);

  if(issubstr(base_weapon, "dlc")) {
    _id_67F14F8315CB0F2F = strtok(base_weapon, "d");
    base_weapon = _id_67F14F8315CB0F2F[0] + "DLC";
    _id_67F14F8315CB0F2F = strtok(_id_67F14F8315CB0F2F[1], "c");
    base_weapon = base_weapon + _id_67F14F8315CB0F2F[1];
  }

  _id_6AEC809BE13C61CC = int(self getplayerdata("cp", _id_415D8240D8C76BEC, base_weapon, _id_D0F001B1761FBF53));
  _id_6302CA9978061647 = _id_6AEC809BE13C61CC + int(value);
  self setplayerdata("cp", _id_415D8240D8C76BEC, base_weapon, _id_D0F001B1761FBF53, _id_6302CA9978061647);
}

player_weaponstats_track_shots() {
  self endon("disconnect");
  self notify("weaponstats_track_shots");
  self endon("weaponstats_track_shots");

  for(;;) {
    self waittill("weapon_fired", objweapon);

    if(!isDefined(objweapon)) {
      continue;
    }
    sweapon = undefined;

    if(isDefined(objweapon))
      sweapon = getcompleteweaponname(objweapon);

    shotsfired = 1;
    update_weaponstats_shots(sweapon, shotsfired);
  }
}

rank_init() {
  if(!isDefined(level.zombie_ranks_table))
    level.zombie_ranks_table = "cp/zombies/rankTable.csv";

  level.zombie_ranks = [];
  level.zombie_max_rank = int(tablelookup(level.zombie_ranks_table, 0, "maxrank", 1));

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 <= level.zombie_max_rank; _id_AC0E594AC96AA3A8++) {
    _id_BE95E8979646E911 = get_ref_by_id(_id_AC0E594AC96AA3A8);

    if(_id_BE95E8979646E911 == "") {
      break;
    }

    if(!isDefined(level.zombie_ranks[_id_AC0E594AC96AA3A8])) {
      _id_00AE17C5A8B1BC1B = spawnStruct();
      _id_00AE17C5A8B1BC1B.id = _id_AC0E594AC96AA3A8;
      _id_00AE17C5A8B1BC1B.ref = _id_BE95E8979646E911;
      _id_00AE17C5A8B1BC1B.lvl = get_level_by_id(_id_AC0E594AC96AA3A8);
      _id_00AE17C5A8B1BC1B.icon = get_icon_by_id(_id_AC0E594AC96AA3A8);
      _id_00AE17C5A8B1BC1B.tokenreward = get_token_reward_by_id(_id_AC0E594AC96AA3A8);
      _id_00AE17C5A8B1BC1B.xp = [];
      _id_00AE17C5A8B1BC1B.xp["min"] = get_minxp_by_id(_id_AC0E594AC96AA3A8);
      _id_00AE17C5A8B1BC1B.xp["next"] = get_nextxp_by_id(_id_AC0E594AC96AA3A8);
      _id_00AE17C5A8B1BC1B.xp["max"] = get_maxxp_by_id(_id_AC0E594AC96AA3A8);
      _id_00AE17C5A8B1BC1B.name = [];
      _id_00AE17C5A8B1BC1B.name["short"] = get_shortrank_by_id(_id_AC0E594AC96AA3A8);
      _id_00AE17C5A8B1BC1B.name["full"] = get_fullrank_by_id(_id_AC0E594AC96AA3A8);
      _id_00AE17C5A8B1BC1B.name["ingame"] = get_ingamerank_by_id(_id_AC0E594AC96AA3A8);
      level.zombie_ranks[_id_AC0E594AC96AA3A8] = _id_00AE17C5A8B1BC1B;
    }
  }
}

get_ref_by_id(id) {
  return tablelookup(level.zombie_ranks_table, 0, id, 1);
}

get_minxp_by_id(id) {
  return int(tablelookup(level.zombie_ranks_table, 0, id, 2));
}

get_maxxp_by_id(id) {
  return int(tablelookup(level.zombie_ranks_table, 0, id, 7));
}

get_nextxp_by_id(id) {
  return int(tablelookup(level.zombie_ranks_table, 0, id, 3));
}

get_level_by_id(id) {
  return int(tablelookup(level.zombie_ranks_table, 0, id, 14));
}

get_shortrank_by_id(id) {
  return tablelookup(level.zombie_ranks_table, 0, id, 4);
}

get_fullrank_by_id(id) {
  return tablelookup(level.zombie_ranks_table, 0, id, 5);
}

get_ingamerank_by_id(id) {
  return tablelookup(level.zombie_ranks_table, 0, id, 17);
}

get_icon_by_id(id) {
  return tablelookup(level.zombie_ranks_table, 0, id, 6);
}

get_token_reward_by_id(id) {
  return int(tablelookup(level.zombie_ranks_table, 0, id, 19));
}

get_splash_by_id(id) {
  return tablelookup(level.zombie_ranks_table, 0, id, 8);
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

set_player_session_xp(_id_10E595A04A4B748D) {
  self setplayerdata("cp", "alienSession", "experience", _id_10E595A04A4B748D);
}

give_player_session_xp(amount) {
  _id_14DF04841B1B0B82 = get_player_session_xp();
  _id_212F891DEB05826F = amount + _id_14DF04841B1B0B82;
  set_player_session_xp(_id_212F891DEB05826F);
}

get_player_session_tokens() {
  return self getplayerdata("cp", "alienSession", "shots");
}

set_player_session_tokens(_id_67F14F8315CB0F2F) {
  self setplayerdata("cp", "alienSession", "shots", _id_67F14F8315CB0F2F);
}

give_player_session_tokens(amount) {
  _id_51C83856E6C785D4 = get_player_session_tokens();
  _id_FB6FCD4B17DC8245 = amount + _id_51C83856E6C785D4;
  set_player_session_tokens(_id_FB6FCD4B17DC8245);
}

set_player_session_rankup(_id_BCC31A3789B5B577) {
  self setplayerdata("cp", "alienSession", "ranked_up", int(_id_BCC31A3789B5B577));
}

get_player_session_rankup() {
  return self getplayerdata("cp", "alienSession", "ranked_up");
}

update_player_session_rankup(_id_BCC31A3789B5B577) {
  if(!isDefined(_id_BCC31A3789B5B577))
    _id_BCC31A3789B5B577 = 1;

  _id_FE4AAED2E4A534D9 = get_player_session_rankup();
  _id_0E1709EFACF76886 = _id_BCC31A3789B5B577 + _id_FE4AAED2E4A534D9;
  set_player_session_rankup(_id_0E1709EFACF76886);
}

set_player_rank(_id_00AE17C5A8B1BC1B) {
  self setplayerdata("cp", "progression", "playerLevel", "rank", _id_00AE17C5A8B1BC1B);
}

set_player_xp(xp) {
  self setplayerdata("cp", "progression", "playerLevel", "xp", xp);

  if(isDefined(self.totalxpearned))
    self setplayerdata("common", "round", "totalXp", self.totalxpearned);
}

set_player_prestige(_id_C52868E86C820DE4) {
  self setplayerdata("cp", "progression", "playerLevel", "prestige", _id_C52868E86C820DE4);
  self setplayerdata("cp", "progression", "playerLevel", "xp", 0);
  self setplayerdata("cp", "progression", "playerLevel", "rank", 0);
}

get_rank_by_xp(xp) {
  _id_00AE17C5A8B1BC1B = 0;

  if(xp >= level.zombie_ranks[level.zombie_max_rank].xp["max"])
    return level.zombie_max_rank;

  if(isDefined(level.zombie_ranks)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.zombie_ranks.size; _id_AC0E594AC96AA3A8++) {
      if(xp >= level.zombie_ranks[_id_AC0E594AC96AA3A8].xp["min"]) {
        if(xp < level.zombie_ranks[_id_AC0E594AC96AA3A8].xp["max"]) {
          _id_00AE17C5A8B1BC1B = level.zombie_ranks[_id_AC0E594AC96AA3A8].id;
          break;
        }
      }
    }
  }

  return _id_00AE17C5A8B1BC1B;
}

get_scaled_xp(player, xp) {
  return int(xp * get_level_xp_scale(player) * get_weapon_passive_xp_scale(player));
}

get_level_xp_scale(player) {
  if(isDefined(player.xpscale))
    return player.xpscale;
  else
    return 1;
}

wait_and_give_player_xp(xp, waittime) {
  self endon("disconnect");
  level endon("game_ended");
  wait(waittime);
  give_player_xp(xp);
}

get_weapon_passive_xp_scale(player) {
  if(isDefined(player.weapon_passive_xp_multiplier) && istrue(player.kill_with_extra_xp_passive)) {
    player.kill_with_extra_xp_passive = 0;
    return player.weapon_passive_xp_multiplier;
  } else
    return 1;
}

give_player_xp(xp, _id_40C374E7355F9029) {
  xp = get_scaled_xp(self, xp);

  if(isDefined(self.totalxpearned))
    self.totalxpearned = self.totalxpearned + xp;

  thread give_player_session_xp(xp);
  _id_8D8B9714BD8CF0E0 = 0;
  _id_F5C2AFA38C91F575 = get_player_rank();
  _id_510E99BB3BE09F77 = get_player_xp();
  _id_9FA0365AB7BBE59E = _id_510E99BB3BE09F77 + xp;
  set_player_xp(_id_9FA0365AB7BBE59E);

  if(istrue(_id_40C374E7355F9029) && xp > 0 && !scripts\cp\utility::is_wave_gametype()) {
    self setclientomnvar("zom_xp_reward", xp);
    self setclientomnvar("zom_xp_notify", gettime());
  }

  _id_491E3024DC27DDE0 = get_rank_by_xp(_id_9FA0365AB7BBE59E);

  if(_id_491E3024DC27DDE0 > _id_F5C2AFA38C91F575) {
    if(_id_491E3024DC27DDE0 == level.zombie_max_rank + 1)
      _id_8D8B9714BD8CF0E0 = 1;

    set_player_rank(_id_491E3024DC27DDE0);

    if(_id_8D8B9714BD8CF0E0 == 0) {
      _id_ECA9164292A71214 = _id_491E3024DC27DDE0 + 1;
      _id_F7B6CC6C062A7A43 = get_splash_by_id(_id_491E3024DC27DDE0);
      self notify("ranked_up", _id_491E3024DC27DDE0);
      update_player_session_rankup();
    }

    process_rank_merits(_id_491E3024DC27DDE0);
  }
}

process_rank_merits(_id_00AE17C5A8B1BC1B) {
  scripts\cp\cp_merits::processmerit("mt_prestige_1");

  if(_id_00AE17C5A8B1BC1B >= 40)
    scripts\cp\cp_merits::processmerit("mt_prestige_2");

  if(_id_00AE17C5A8B1BC1B >= 60)
    scripts\cp\cp_merits::processmerit("mt_prestige_3");

  if(_id_00AE17C5A8B1BC1B >= 80)
    scripts\cp\cp_merits::processmerit("mt_prestige_4");

  if(_id_00AE17C5A8B1BC1B >= 100)
    scripts\cp\cp_merits::processmerit("mt_prestige_5");

  if(_id_00AE17C5A8B1BC1B >= 120)
    scripts\cp\cp_merits::processmerit("mt_prestige_6");

  if(_id_00AE17C5A8B1BC1B >= 140)
    scripts\cp\cp_merits::processmerit("mt_prestige_7");

  if(_id_00AE17C5A8B1BC1B >= 160)
    scripts\cp\cp_merits::processmerit("mt_prestige_8");

  if(_id_00AE17C5A8B1BC1B >= 180)
    scripts\cp\cp_merits::processmerit("mt_prestige_9");

  if(_id_00AE17C5A8B1BC1B >= 200)
    scripts\cp\cp_merits::processmerit("mt_prestige_10");
}

inc_stat(ref_name, _id_2AF645AF7FFAE65F, value) {
  _id_6AEC809BE13C61CC = self getplayerdata("cp", ref_name, _id_2AF645AF7FFAE65F);
  _id_6302CA9978061647 = _id_6AEC809BE13C61CC + value;
  self setplayerdata("cp", ref_name, _id_2AF645AF7FFAE65F, _id_6302CA9978061647);
}

inc_session_stat(_id_2AF645AF7FFAE65F, value) {
  inc_stat("alienSession", _id_2AF645AF7FFAE65F, value);
}

get_hives_destroyed_stat() {
  return get_aliensession_stat("hivesDestroyed");
}

get_aliensession_stat(_id_BC35CB5830C7F81B) {
  return self getplayerdata("cp", "alienSession", _id_BC35CB5830C7F81B);
}

set_aliensession_stat(_id_BC35CB5830C7F81B, value) {
  self setplayerdata("cp", "alienSession", _id_BC35CB5830C7F81B, value);
}

update_deployable_box_performance(player) {
  if(isDefined(level.update_deployable_box_performance_func))
    player[[level.update_deployable_box_performance_func]]();
  else
    player scripts\cp\cp_gamescore::update_personal_encounter_performance(scripts\cp\cp_gamescore::get_team_score_component_name(), "team_support_deploy");
}

update_lb_aliensession_challenge(_id_4C01B359E65FC13D) {
  foreach(player in level.players) {
    player lb_player_update_stat("challengesAttempted", 1);

    if(_id_4C01B359E65FC13D)
      player lb_player_update_stat("challengesCompleted", 1);
  }
}

update_lb_aliensession_wave(_id_973693D2BB740820) {
  foreach(player in level.players)
  player lb_player_update_stat("waveNum", _id_973693D2BB740820, 1);
}

update_lb_aliensession_escape(_id_90B1193128A4F047, _id_4C180BD3BFE42990) {
  _id_06207F1175348BAA = get_lb_escape_rank(_id_4C180BD3BFE42990);

  foreach(player in _id_90B1193128A4F047) {
    player lb_player_update_stat("escapedRank" + _id_06207F1175348BAA, 1, 1);
    player lb_player_update_stat("hits", 1, 1);
  }
}

update_alien_kill_sessionstats(einflictor, eattacker) {
  if(!isDefined(eattacker) || !isPlayer(eattacker)) {
    return;
  }
  if(scripts\cp\utility::is_trap(einflictor))
    eattacker lb_player_update_stat("trapKills", 1);
}

register_lb_escape_rank(escape_rank_array) {
  level.escape_rank_array = escape_rank_array;
}

get_lb_escape_rank(_id_4C180BD3BFE42990) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.escape_rank_array.size - 1; _id_AC0E594AC96AA3A8++) {
    if(_id_4C180BD3BFE42990 >= level.escape_rank_array[_id_AC0E594AC96AA3A8] && _id_4C180BD3BFE42990 < level.escape_rank_array[_id_AC0E594AC96AA3A8 + 1])
      return _id_AC0E594AC96AA3A8;
  }
}

have_clan_tag(_id_55BED569A266A992) {
  return issubstr(_id_55BED569A266A992, "[") && issubstr(_id_55BED569A266A992, "]");
}

remove_clan_tag(_id_55BED569A266A992) {
  _id_DA6C08CD3D3BF1D6 = strtok(_id_55BED569A266A992, "]");
  return _id_DA6C08CD3D3BF1D6[1];
}

register_eog_to_lb_playerdata_mapping() {
  _id_ED47DF0B615478AF = [];
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

get_mapped_lb_ref_from_eog_ref(_id_7B71A32FA025F6E0) {
  return level.eog_to_lb_playerdata_mapping[_id_7B71A32FA025F6E0];
}

play_time_monitor() {
  self endon("disconnect");

  for(;;) {
    wait 1;
    lb_player_update_stat("time", 1);
  }
}

record_player_kills(sweapon, shitloc, smeansofdeath, player) {
  if(scripts\cp\utility::isheadshot(sweapon, shitloc, smeansofdeath, player)) {
    increment_player_career_headshot_kills(player);
    player eog_player_update_stat("headShots", 1);
  }

  player increment_player_career_kills(player);
  player eog_player_update_stat("kills", 1);
  player scripts\cp\cp_analytics::log_event("zombie_death", 1, [player.clientid], [player.clientid], [player.clientid]);
}

increment_player_career_total_waves(player) {
  if(isDefined(player.wave_num_when_joined))
    increment_zombiecareerstats(player, "Total_Waves", level.wave_num - player.wave_num_when_joined);
  else
    increment_zombiecareerstats(player, "Total_Waves", level.wave_num);
}

increment_player_career_total_score(player) {
  increment_zombiecareerstats(player, "Total_Score", player.score_earned);
}

increment_player_career_kills(player) {
  increment_zombiecareerstats(player, "Kills", 1);

  if(should_update_leaderboard_stats())
    updateleaderboardstats(player, "Kills", 1, level.script, level.players.size, 1);
}

increment_player_career_headshot_kills(player) {
  player increment_zombiecareerstats(player, "Headshot_Kills", 1);

  if(should_update_leaderboard_stats())
    updateleaderboardstats(player, "Headshots", 1, level.script, level.players.size, 1);
}

increment_player_career_revives(player) {
  player increment_zombiecareerstats(player, "Revives", 1);

  if(should_update_leaderboard_stats())
    updateleaderboardstats(player, "Revives", 1, level.script, level.players.size, 1);
}

increment_player_career_downs(player) {
  player increment_zombiecareerstats(player, "Downs", 1);

  if(should_update_leaderboard_stats())
    updateleaderboardstats(player, "Downs", 1, level.script, level.players.size, 1);
}

enable_leaderboard() {
  level.leaderboard_enabled = 1;
}

should_update_leaderboard_stats() {
  return istrue(level.leaderboard_enabled);
}

update_players_career_highest_wave(_id_5675A729BBD6AA36, _id_DDAC31817B064B95) {
  foreach(player in level.players)
  update_player_career_highest_wave(player, _id_5675A729BBD6AA36, _id_DDAC31817B064B95, level.players.size);
}

update_player_career_highest_wave(player, _id_5675A729BBD6AA36, _id_DE7821BC51AB43A0) {
  if(scripts\cp\utility::is_wave_gametype()) {
    updateifgreaterthan_zombiecareerstats(player, "Highest_Wave", _id_5675A729BBD6AA36);
    check_and_update_best_stats(player, _id_5675A729BBD6AA36, "Highest_Wave", level.script, _id_DE7821BC51AB43A0);
    updateleaderboardstats(player, "Rounds", _id_5675A729BBD6AA36, level.script, _id_DE7821BC51AB43A0, 1);
  }
}

increment_zombiecareerstats(player, _id_0BB14A323E2BD7CE, _id_4E71BBAE7E003263) {
  if(!isDefined(_id_4E71BBAE7E003263))
    _id_4E71BBAE7E003263 = 1;

  _id_6AEC809BE13C61CC = player getplayerdata("cp", "coopCareerStats", _id_0BB14A323E2BD7CE);
  _id_6302CA9978061647 = _id_6AEC809BE13C61CC + _id_4E71BBAE7E003263;
  player setplayerdata("cp", "coopCareerStats", _id_0BB14A323E2BD7CE, int(_id_6302CA9978061647));
}

updateifgreaterthan_zombiecareerstats(player, _id_0BB14A323E2BD7CE, _id_6302CA9978061647) {
  _id_6AEC809BE13C61CC = player getplayerdata("cp", "coopCareerStats", _id_0BB14A323E2BD7CE);

  if(_id_6302CA9978061647 > _id_6AEC809BE13C61CC)
    player setplayerdata("cp", "coopCareerStats", _id_0BB14A323E2BD7CE, _id_6302CA9978061647);
}

update_highest_wave_lb(player, _id_6302CA9978061647, _id_0BB14A323E2BD7CE, _id_DDAC31817B064B95, _id_DE7821BC51AB43A0) {
  _id_6AEC809BE13C61CC = player getplayerdata("cp", "leaderboarddata", _id_DDAC31817B064B95, "leaderboardDataPerMap", _id_DE7821BC51AB43A0, _id_0BB14A323E2BD7CE);

  if(_id_6302CA9978061647 > _id_6AEC809BE13C61CC)
    player setplayerdata("cp", "leaderboarddata", _id_DDAC31817B064B95, "leaderboardDataPerMap", _id_DE7821BC51AB43A0, _id_0BB14A323E2BD7CE, _id_6302CA9978061647);
}

check_and_update_best_stats(player, _id_6302CA9978061647, _id_0BB14A323E2BD7CE, _id_DDAC31817B064B95, _id_DE7821BC51AB43A0, reverse) {
  if(should_update_leaderboard_stats()) {
    _id_6AEC809BE13C61CC = player getplayerdata("cp", "leaderboarddata", _id_DDAC31817B064B95, "leaderboardDataPerMap", _id_DE7821BC51AB43A0, _id_0BB14A323E2BD7CE);

    if(!istrue(reverse)) {
      if(_id_6302CA9978061647 > _id_6AEC809BE13C61CC)
        player setplayerdata("cp", "leaderboarddata", _id_DDAC31817B064B95, "leaderboardDataPerMap", _id_DE7821BC51AB43A0, _id_0BB14A323E2BD7CE, _id_6302CA9978061647);
    } else if(_id_6302CA9978061647 < _id_6AEC809BE13C61CC)
      player setplayerdata("cp", "leaderboarddata", _id_DDAC31817B064B95, "leaderboardDataPerMap", _id_DE7821BC51AB43A0, _id_0BB14A323E2BD7CE, _id_6302CA9978061647);
  }
}

updateleaderboardstats(player, _id_0BB14A323E2BD7CE, _id_6302CA9978061647, _id_DDAC31817B064B95, _id_DE7821BC51AB43A0, _id_4E71BBAE7E003263) {
  if(should_update_leaderboard_stats()) {
    if(!isDefined(_id_4E71BBAE7E003263))
      _id_4E71BBAE7E003263 = 1;

    _id_6AEC809BE13C61CC = player getplayerdata("cp", "leaderboarddata", _id_DDAC31817B064B95, "leaderboardDataPerMap", _id_DE7821BC51AB43A0, _id_0BB14A323E2BD7CE);
    _id_6302CA9978061647 = _id_6AEC809BE13C61CC + _id_4E71BBAE7E003263;

    if(_id_6302CA9978061647 > _id_6AEC809BE13C61CC)
      player setplayerdata("cp", "leaderboarddata", _id_DDAC31817B064B95, "leaderboardDataPerMap", _id_DE7821BC51AB43A0, _id_0BB14A323E2BD7CE, _id_6302CA9978061647);
  }
}