/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_persistence.gsc
***********************************************/

set_perk(var_0) {
  self[[level.coop_perk_callbacks[var_0].set]]();
}

unset_perk(var_0) {
  self[[level.coop_perk_callbacks[var_0].unset]]();
}

quickdropremovearmorfrominventory() {
  return self getplayerdata("_encstr_850703B7D9", "_encstr_B864100E38A8A0F877252F274D36D3E9D803", "_encstr_A19B0973B543C35FDDE063");
}

get_player_currency() {
  return self getplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_A19B0973B543C35FDDE063");
}

get_player_max_currency() {
  return self.maxcurrency;
}

take_all_currency() {
  set_player_currency(0);
}

get_starting_currency() {
  var_0 = getdvarint("_encstr_B64113D6B64BD70B14DFC0E83F5B83C5335FC05688", 0);

  if(var_0 != 0)
    return var_0;

  if(isDefined(level.starting_currency))
    return level.starting_currency;

  return 0;
}

wait_to_set_player_currency(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 1.0;
  set_player_currency(var_0);
}

_id_130AA(var_0) {
  self setplayerdata("_encstr_850703B7D9", "_encstr_B864100E38A8A0F877252F274D36D3E9D803", "_encstr_A19B0973B543C35FDDE063", int(var_0));
}

set_player_currency(var_0) {
  if(level.gametype != "_encstr_B1BC09D6E3C9BBA3EFB318") {
    self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_A19B0973B543C35FDDE063", int(var_0));
    eog_player_update_stat("_encstr_A19B0973B543C35FDDE063", int(var_0), 1);
  }
}

give_player_currency(var_0, var_1, var_2, var_3, var_4, var_5) {
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

  if(isDefined(level.currency_scale_func))
    var_0 = [[level.currency_scale_func]](self, var_0);

  var_6 = get_player_currency();
  var_7 = get_player_max_currency();
  var_8 = var_6 + var_0;
  var_8 = min(var_8, var_7);

  if(!isDefined(self.total_currency_earned))
    self.total_currency_earned = var_0;

  if(is_valid_give_type(var_4)) {
    self.total_currency_earned = self.total_currency_earned + (var_8 - var_6);
    self notify("_encstr_9612128A50880F9BA013BA8C230926ABA76B4212", var_0 * 0.5);
  }

  level notify("_encstr_8E1811B37583039F1DA02359B849D63B99D53C");
  eog_player_update_stat("_encstr_BD3B0E501BD2B5F9E303DB551753A141", int(self.total_currency_earned), 1);

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    set_player_currency(var_8);
    thread scripts\cp\drone\emp_drone::scorepointspopup(var_0, 1);
  } else
    return;

  if(isDefined(level.update_money_performance))
    [[level.update_money_performance]](self, var_0);

  var_9 = 30000;
  var_10 = gettime();

  if(var_8 >= var_7) {
    if(!isDefined(self.next_maxmoney_hint_time))
      self.next_maxmoney_hint_time = var_10 + var_9;
    else if(var_10 < self.next_maxmoney_hint_time) {
      return;
    }
    if(!level.gameended) {
      scripts\cp\utility::setlowermessage("_encstr_AC5B09374343AA1773C138", &"_encstr_A72719349E9E28EB7428D48AEB4113142BF2A9F4275156AF9A05C2", 4);
      self.next_maxmoney_hint_time = var_10 + var_9;
    }
  }

  if(is_valid_give_type(var_4))
    thread scripts\cp\utility::add_to_notify_queue("_encstr_BEEF14E84190C0379E46E2AA8BF84FFF09DB7F4EFB88", var_0);

  self notify("_encstr_B46E10418BBE95276B2AC97E479AB848876A", var_0);
}

is_valid_give_type(var_0) {
  if(!isDefined(var_0))
    return 1;

  switch (var_0) {
    case "_encstr_8458086ACFA239A864AD":
    case "_encstr_8A091118A22F1BB073C8535BE4EA58548FAAB1":
    case "_encstr_B25C08A0DB7AF28BFB04":
    case "_encstr_ABD30A38F72030BBA82907BA":
    case "_encstr_B2B20686D0C0C3EB":
    case "_encstr_961904BF13DA":
    case "_encstr_B8BA05F06B9785":
      return 0;
    default:
      return 1;
  }

  return 1;
}

take_player_currency(var_0, var_1, var_2, var_3) {
  if(scripts\cp\utility::isnmlactive()) {
    return;
  }
  var_4 = get_player_currency();
  var_5 = max(0, var_4 - var_0);
  var_6 = int(var_4 - var_5);

  if(getDvar("_encstr_ADE50BEB2F7C519F9918E82B68") != "_encstr_BACB074025B01AAA28") {
    set_player_currency(var_5);
    return;
  }

  if(isDefined(level.chaos_update_spending_currency_event))
    [[level.chaos_update_spending_currency_event]](self, var_2, var_3);

  if(scripts\cp\utility::is_consumable_active("_encstr_96CD13B92B3C1DFAC1D527B186C2DC2BF599279559") && var_0 >= 1 && var_2 != "_encstr_961904BF13DA" && var_2 != "_encstr_A5510A30AA778D28B3C97D51" && var_2 != "_encstr_AC9A102A7B4018BDA0E56029F28E5F5D6380")
    scripts\cp\utility::notify_used_consumable("_encstr_96CD13B92B3C1DFAC1D527B186C2DC2BF599279559");
  else
    set_player_currency(var_5);

  if(var_6 < 1) {
    return;
  }
  if(isDefined(var_2))
    scripts\cp\cp_analytics::update_spending_type(var_6, var_2);

  eog_player_update_stat("_encstr_8A200E1BAB274E2B37B1CBDC38569B47", var_6);

  if(scripts\cp\utility::is_consumable_active("_encstr_851110790F428E41A29BE23E428DC045EA8B") && var_0 > 0) {
    if(var_2 != "_encstr_961904BF13DA" && var_2 != "_encstr_A5510A30AA778D28B3C97D51" && var_2 != "_encstr_AC9A102A7B4018BDA0E56029F28E5F5D6380") {
      give_player_currency(int(var_6 * 0.3), undefined, undefined, 1, "_encstr_B2B20686D0C0C3EB");
      scripts\cp\utility::notify_used_consumable("_encstr_851110790F428E41A29BE23E428DC045EA8B");
    }
  }

  if(scripts\cp\cp_interaction::should_interaction_fill_consumable_meter(var_2))
    self notify("_encstr_9612128A50880F9BA013BA8C230926ABA76B4212", var_0 * 0.07);

  if(isDefined(var_1) && var_1)
    return;
}

player_has_enough_currency(var_0, var_1) {
  if(scripts\cp\utility::isnmlactive())
    return 1;

  if(!isDefined(var_1) || isDefined(var_1) && var_1 != "_encstr_961904BF13DA" && var_1 != "_encstr_A5510A30AA778D28B3C97D51" && var_1 != "_encstr_AC9A102A7B4018BDA0E56029F28E5F5D6380") {
    if(scripts\cp\utility::is_consumable_active("_encstr_96CD13B92B3C1DFAC1D527B186C2DC2BF599279559"))
      var_0 = 0;
  }

  var_2 = get_player_currency();
  return var_2 >= var_0;
}

try_take_player_currency(var_0) {
  if(player_has_enough_currency(var_0)) {
    take_player_currency(var_0);
    return 1;
  } else
    return 0;
}

is_unlocked(var_0) {
  var_1 = undefined;
  var_1 = strtok(var_0, "_encstr_BA4C02DF")[0];
  var_2 = level.combat_resource[var_0].unlock;
  var_3 = get_player_rank();
  return var_3 >= var_2;
}

player_persistence_init() {
  level.zombie_xp = undefined;
  set_player_session_xp(0);
  set_player_session_rankup(0);
}

setcoopplayerdata_for_everyone(var_0, var_1, var_2, var_3, var_4) {
  foreach(var_7, var_6 in level.players) {
    if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2) && isDefined(var_3) && isDefined(var_4)) {
      var_6 setplayerdata("_encstr_850703B7D9", var_0, var_1, var_2, var_3, var_4);
      continue;
    }

    if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2) && isDefined(var_3) && !isDefined(var_4)) {
      var_6 setplayerdata("_encstr_850703B7D9", var_0, var_1, var_2, var_3);
      continue;
    }

    if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2) && !isDefined(var_3) && !isDefined(var_4)) {
      var_6 setplayerdata("_encstr_850703B7D9", var_0, var_1, var_2);
      continue;
    }

    if(isDefined(var_0) && isDefined(var_1) && !isDefined(var_2) && !isDefined(var_3) && !isDefined(var_4)) {
      var_6 setplayerdata("_encstr_850703B7D9", var_0, var_1);
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
  var_0 = "_encstr_B1D11D8D1C971BC17D567B76BE474E0BB1DA2DDC3B7DA35E382B6E5CC6E667";
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow(var_0, var_1, 0);

    if(var_2 == "_encstr_B40101") {
      break;
    }

    level.eogtracking[var_1] = tablelookup(var_0, 0, var_1, 1);
    var_1++;
  }
}

eog_player_tracking_init() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait 0.5;
  var_0 = self getentitynumber();
  var_1 = "_encstr_AABB0EF8B28C85B0BF064741E16F3945";

  if(isDefined(self.name))
    var_1 = self.name;

  if(self isconsoleplayer()) {
    if(have_clan_tag(var_1))
      var_1 = remove_clan_tag(var_1);
  }

  var_2 = 8;

  for(var_3 = 0; var_3 < var_2; var_3++)
    self setplayerdata("_encstr_850703B7D9", "_encstr_A74B0A55CF2902ABAF0A7A13", var_3, "_encstr_AA940A6CB7DC9B2B6C3ACA91", 0);

  foreach(var_5 in level.players) {
    var_5 reset_eog_stats(var_0);
    var_5 setplayerdata("_encstr_850703B7D9", "_encstr_A74B0A55CF2902ABAF0A7A13", var_0, "_encstr_AA940A6CB7DC9B2B6C3ACA91", 1);
    var_5 setplayerdata("_encstr_850703B7D9", "_encstr_A74B0A55CF2902ABAF0A7A13", var_0, "_encstr_84BA05A8CA852B", var_1);
    var_5 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_AA36085CF78876831B33", 0);
  }

  var_7 = [0, 0, 0, 0];

  foreach(var_9 in level.players) {
    var_10 = var_9 getentitynumber();
    var_7[int(var_10)] = 1;

    if(var_9 == self) {
      continue;
    }
    var_0 = var_9 getentitynumber();
    var_11 = var_9 getplayerdata("_encstr_850703B7D9", "_encstr_A74B0A55CF2902ABAF0A7A13", var_0, "_encstr_AA940A6CB7DC9B2B6C3ACA91");
    self setplayerdata("_encstr_850703B7D9", "_encstr_A74B0A55CF2902ABAF0A7A13", var_0, "_encstr_AA940A6CB7DC9B2B6C3ACA91", var_11);

    for(var_3 = 0; var_3 < level.eogtracking.size; var_3++) {
      var_12 = var_9 getplayerdata("_encstr_850703B7D9", "_encstr_A74B0A55CF2902ABAF0A7A13", var_0, level.eogtracking[var_3]);

      if(level.eogtracking[var_3] != "_encstr_A19B0973B543C35FDDE063" && getDvar("_encstr_ADE50BEB2F7C519F9918E82B68") != "_encstr_B1BC09D6E3C9BBA3EFB318")
        self setplayerdata("_encstr_850703B7D9", "_encstr_A74B0A55CF2902ABAF0A7A13", var_0, level.eogtracking[var_3], var_12);
    }
  }

  foreach(var_16, var_15 in var_7) {
    if(!var_15)
      reset_eog_stats(var_16);
  }
}

reset_eog_stats(var_0) {
  for(var_1 = 0; var_1 < level.eogtracking.size; var_1++) {
    if(level.eogtracking[var_1] == "_encstr_84BA05A8CA852B") {
      self setplayerdata("_encstr_850703B7D9", "_encstr_A74B0A55CF2902ABAF0A7A13", var_0, level.eogtracking[var_1], "_encstr_B40101");
      continue;
    }

    self setplayerdata("_encstr_850703B7D9", "_encstr_A74B0A55CF2902ABAF0A7A13", var_0, level.eogtracking[var_1], 0);
  }
}

eog_setup_track_items() {
  if(!isDefined(level.eogscoreboard))
    level.eogscoreboard = ["_encstr_A19B0973B543C35FDDE063", "_encstr_8E8D0697EB01F243", "_encstr_96D30A3468575BA7C307A128", "_encstr_A9AB06297DDFD816", "_encstr_B642089B65A658E8F597"];

  clear_eog_tracking_types();

  for(var_0 = 0; var_0 < level.eogscoreboard.size; var_0++) {
    var_1 = int(get_eog_tracking_idx(level.eogscoreboard[var_0]));
    self setplayerdata("_encstr_850703B7D9", "_encstr_8AC50A4D327B2B96039F9F95", "_encstr_A3B10F07E8AF211A4168D727F879E9EA49", var_0, var_1);
  }
}

clear_eog_tracking_types() {
  for(var_0 = 0; var_0 < 7; var_0++)
    self setplayerdata("_encstr_850703B7D9", "_encstr_8AC50A4D327B2B96039F9F95", "_encstr_A3B10F07E8AF211A4168D727F879E9EA49", var_0, 99);
}

get_eog_tracking_idx(var_0) {
  return tablelookup("_encstr_B1D11D8D1C971BC17D567B76BE474E0BB1DA2DDC3B7DA35E382B6E5CC6E667", 1, var_0, 0);
}

eog_update_on_player_disconnect(var_0) {
  if(scripts\cp\cp_endgame::gamealreadyended()) {
    return;
  }
  var_1 = var_0 getentitynumber();
  setcoopplayerdata_for_everyone("_encstr_A74B0A55CF2902ABAF0A7A13", var_1, "_encstr_AA940A6CB7DC9B2B6C3ACA91", 0);
}

eog_player_update_stat(var_0, var_1, var_2) {
  var_3 = self getentitynumber();
  var_4 = var_1;

  if(!isDefined(var_2) || !var_2) {
    var_5 = self getplayerdata("_encstr_850703B7D9", "_encstr_A74B0A55CF2902ABAF0A7A13", var_3, var_0);
    var_4 = int(var_5) + int(var_1);
  }

  try_update_lb_playerdata(var_0, var_4, 1);
  setcoopplayerdata_for_everyone("_encstr_A74B0A55CF2902ABAF0A7A13", var_3, var_0, var_4);

  if(isDefined(level.eogscoringtable))
    update_eog_totals_for_stat_ref(var_0, var_4);
}

update_eog_totals_for_stat_ref(var_0, var_1) {
  for(var_2 = 0; var_2 < level.eogscoringtable.size; var_2++) {
    if(level.eogscoringtable[var_2].ref == var_0)
      level.eogscoringtable[var_2].curamount = var_1;
  }
}

eog_player_update_pvpve_downs(var_0, var_1) {
  var_2 = self getentitynumber();
  setcoopplayerdata_for_everyone("_encstr_A74B0A55CF2902ABAF0A7A13", var_2, var_0, var_1);
}

try_update_lb_playerdata(var_0, var_1, var_2) {
  var_3 = get_mapped_lb_ref_from_eog_ref(var_0);

  if(!isDefined(var_3)) {
    return;
  }
  lb_player_update_stat(var_3, var_1, var_2);
}

lb_player_update_stat(var_0, var_1, var_2) {
  if(istrue(var_2))
    var_3 = var_1;
  else {
    var_4 = self getplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", var_0);
    var_3 = var_4 + var_1;
  }

  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", var_0, var_3);
}

weapons_tracking_init() {
  self.persistence_weaponstats = [];

  foreach(var_3, var_1 in level.collectibles) {
    if(strtok(var_3, "_encstr_BA4C02DF")[0] == "_encstr_AC20072B9FA9487832") {
      var_2 = get_base_weapon_name(var_3);
      self.persistence_weaponstats[var_2] = 1;
    }
  }

  thread player_weaponstats_track_shots();
}

get_base_weapon_name(var_0) {
  var_1 = "_encstr_B40101";
  var_2 = undefined;

  if(issameweapon(var_0))
    var_2 = var_0.basename;
  else
    var_2 = var_0;

  var_3 = strtok(var_2, "_encstr_BA4C02DF");

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];

    if(var_5 == "_encstr_AC20072B9FA9487832" && var_4 == 0) {
      continue;
    }
    if(var_5 == "_encstr_8A0703FA62") {
      var_1 = var_1 + "_encstr_8A0703FA62";
      break;
    }

    if(var_4 < var_3.size - 1) {
      var_1 = var_1 + (var_5 + "_encstr_BA4C02DF");
      continue;
    }

    var_1 = var_1 + var_5;
    break;
  }

  if(var_1 == "_encstr_B40101")
    return "_encstr_8BBA05185F8B99";

  return var_1;
}

weaponstats_reset(var_0, var_1) {
  self setplayerdata("_encstr_850703B7D9", var_0, var_1, "_encstr_88CC0521F3A13B", 0);
  self setplayerdata("_encstr_850703B7D9", var_0, var_1, "_encstr_884806B91ADEE8CD", 0);
  self setplayerdata("_encstr_850703B7D9", var_0, var_1, "_encstr_8E8D0697EB01F243", 0);
}

update_weaponstats_hits(var_0, var_1, var_2) {
  if(!is_valid_weapon_hit(var_0, var_2)) {
    return;
  }
  update_weaponstats("_encstr_8DA90CCB79020F88735B8D023998", var_0, "_encstr_88CC0521F3A13B", var_1);
  var_3 = "_encstr_8D2509C1CAC9B9DEDC16B1";

  if(isDefined(level.personal_score_component_name))
    var_3 = level.personal_score_component_name;

  scripts\cp\cp_gamescore::update_personal_encounter_performance(var_3, "_encstr_BD480A9BA018636A4111A1A4", var_1);
}

is_valid_weapon_hit(var_0, var_1) {
  if(var_0 == "_encstr_8BBA05185F8B99")
    return 0;

  if(var_1 == "_encstr_8DED0A21C79B660BC7588981")
    return 0;

  if(no_weapon_fired_notify(var_0))
    return 0;

  return 1;
}

no_weapon_fired_notify(var_0) {
  switch (var_0) {
    case "_encstr_A33717FB032ED7B7D02D9FC0CFEF298B409E508F91101ED0BF":
    case "_encstr_AC37175AEE6E7D3707965B5919BE13583AFAD3B57DC12CE013":
    case "_encstr_B2EA121238EFA9B77BDB030565A6CB6EC1E1AB2A":
    case "_encstr_8D6814D2EE6EBE6B2C8DA1AC3A957DD3DAF50E2C3823":
    case "_encstr_A56814E7F4DC3E1DE73ED0E86B8F99120B0F12F6FBB7":
    case "_encstr_B49B0F2DEE73EBDA2C6C0D568E59AF4F6B":
    case "_encstr_8E59164B3B83EFB9E70C54C01B33235D7113A829E3AEE95B":
    case "_encstr_9159162DEEB9BE3B7B3633F58D63EA31AFD36BFA380B3898":
    case "_encstr_A67511EB17BE8EA7B5B24879BA8D4BE1C7B261":
    case "_encstr_84391B8C3B6A8F8B7C1FC713632FD2ED5886065091D162D24039476BF5":
    case "_encstr_AD391B5A2354AFCB603FB7983308178F15DE52D3C9D863C54929818873":
    case "_encstr_A763165A776EBE47BB7BFA86560B8CCA8CEBB0F059BE9ED6":
    case "_encstr_95A9135ADDDCBE6D0B47C2B92CFA4FB6FA8385388C":
    case "_encstr_BAA91358AB4F81CA925B534527598AA88FC2C1F342":
    case "_encstr_8BB7168017FF2E1DEB2D1E93C3A25F132F8B38B9F341039D":
    case "_encstr_99B71651D782E9FBFD8062DACBDED75A6955DD9F31E8EACE":
    case "_encstr_A9210EC85FB796AF6273D7680EB9B598":
    case "_encstr_AF5711D3773301C0270A89D083470A2871E253":
    case "_encstr_A20A1003CF665603D89A290832391929D312":
    case "_encstr_A90A1071F7A2C9A71B81C19BE8E09B3EF0E3":
    case "_encstr_8B060B2DDDE6BE0B0F95FAD3D6":
      return 1;
    default:
      return 0;
  }
}

update_weaponstats_shots(var_0, var_1) {
  if(!self.should_track_weapon_fired) {
    return;
  }
  update_weaponstats("_encstr_8DA90CCB79020F88735B8D023998", var_0, "_encstr_884806B91ADEE8CD", var_1);
  var_2 = "_encstr_8D2509C1CAC9B9DEDC16B1";

  if(isDefined(level.personal_score_component_name))
    var_2 = level.personal_score_component_name;

  scripts\cp\cp_gamescore::update_personal_encounter_performance(var_2, "_encstr_A2E60C1B2098E3EAC18D21229340", var_1);
}

update_weaponstats_kills(var_0, var_1) {
  update_weaponstats("_encstr_8DA90CCB79020F88735B8D023998", var_0, "_encstr_8E8D0697EB01F243", var_1);
}

update_weaponstats(var_0, var_1, var_2, var_3) {
  if(!isPlayer(self)) {
    return;
  }
  var_4 = get_base_weapon_name(var_1);

  if(!isDefined(var_4) || !isDefined(self.persistence_weaponstats[var_4])) {
    return;
  }
  if(isDefined(level.weapon_stats_override_name_func))
    var_4 = [[level.weapon_stats_override_name_func]](var_4);

  if(issubstr(var_4, "_encstr_8A1804EAC86F")) {
    var_5 = strtok(var_4, "_encstr_A14C02D1");
    var_4 = var_5[0] + "_encstr_8A1804E8C92F";
    var_5 = strtok(var_5[1], "_encstr_834C02D8");
    var_4 = var_4 + var_5[1];
  }

  var_6 = int(self getplayerdata("_encstr_850703B7D9", var_0, var_4, var_2));
  var_7 = var_6 + int(var_3);
  self setplayerdata("_encstr_850703B7D9", var_0, var_4, var_2, var_7);
}

player_weaponstats_track_shots() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_BEEA18EF5390821F90C3F3AA4B76A7FB60C3734B8FD84CD745FB");
  self endon("_encstr_BEEA18EF5390821F90C3F3AA4B76A7FB60C3734B8FD84CD745FB");

  for(;;) {
    self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", var_0);

    if(!isDefined(var_0)) {
      continue;
    }
    var_1 = undefined;

    if(isDefined(var_0))
      var_1 = createheadicon(var_0);

    var_2 = 1;
    update_weaponstats_shots(var_1, var_2);
  }
}

rank_init() {
  if(!isDefined(level.zombie_ranks_table))
    level.zombie_ranks_table = "_encstr_925B1902B06FB097882E7175BE183BBE0590F9BA88512FDA218E56";

  level.zombie_ranks = [];
  level.zombie_max_rank = int(tablelookup(level.zombie_ranks_table, 0, "_encstr_ADF308608F704BC31A2C", 1));

  for(var_0 = 0; var_0 <= level.zombie_max_rank; var_0++) {
    var_1 = get_ref_by_id(var_0);

    if(var_1 == "_encstr_B40101") {
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
      var_2.xp["_encstr_8719046B4BB9"] = get_minxp_by_id(var_0);
      var_2.xp["_encstr_99BA051555C8D3"] = get_nextxp_by_id(var_0);
      var_2.xp["_encstr_B81904B62CC3"] = get_maxxp_by_id(var_0);
      var_2.name = [];
      var_2.name["_encstr_8C4806EBD0682BFB"] = get_shortrank_by_id(var_0);
      var_2.name["_encstr_997805335763B1"] = get_fullrank_by_id(var_0);
      var_2.name["_encstr_BAEC07439667D1DB5F"] = get_ingamerank_by_id(var_0);
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
  return self getplayerdata("_encstr_850703B7D9", "_encstr_81F20CA34DEDEF635F1296D1C755", "_encstr_95A30C63C089D1FA5591E75B7D01", "_encstr_A51F05CB11A052");
}

get_player_xp() {
  return self getplayerdata("_encstr_850703B7D9", "_encstr_81F20CA34DEDEF635F1296D1C755", "_encstr_95A30C63C089D1FA5591E75B7D01", "_encstr_B607032B8B");
}

get_player_prestige() {
  return self getplayerdata("_encstr_850703B7D9", "_encstr_81F20CA34DEDEF635F1296D1C755", "_encstr_95A30C63C089D1FA5591E75B7D01", "_encstr_A1ED09400BA5D351227715");
}

get_player_session_xp() {
  return self getplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_BE520B0A80CBA382E968707FFB");
}

set_player_session_xp(var_0) {
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_BE520B0A80CBA382E968707FFB", var_0);
}

give_player_session_xp(var_0) {
  var_1 = get_player_session_xp();
  var_2 = var_0 + var_1;
  set_player_session_xp(var_2);
}

get_player_session_tokens() {
  return self getplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_884806B91ADEE8CD");
}

set_player_session_tokens(var_0) {
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_884806B91ADEE8CD", var_0);
}

give_player_session_tokens(var_0) {
  var_1 = get_player_session_tokens();
  var_2 = var_0 + var_1;
  set_player_session_tokens(var_2);
}

set_player_session_rankup(var_0) {
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_BE9F0ACEAE1227418C9F7050", int(var_0));
}

get_player_session_rankup() {
  return self getplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_BE9F0ACEAE1227418C9F7050");
}

update_player_session_rankup(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  var_1 = get_player_session_rankup();
  var_2 = var_0 + var_1;
  set_player_session_rankup(var_2);
}

set_player_rank(var_0) {
  self setplayerdata("_encstr_850703B7D9", "_encstr_81F20CA34DEDEF635F1296D1C755", "_encstr_95A30C63C089D1FA5591E75B7D01", "_encstr_A51F05CB11A052", var_0);
}

set_player_xp(var_0) {
  self setplayerdata("_encstr_850703B7D9", "_encstr_81F20CA34DEDEF635F1296D1C755", "_encstr_95A30C63C089D1FA5591E75B7D01", "_encstr_B607032B8B", var_0);

  if(isDefined(self.totalxpearned))
    self setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_AA36085CF78876831B33", self.totalxpearned);
}

set_player_prestige(var_0) {
  self setplayerdata("_encstr_850703B7D9", "_encstr_81F20CA34DEDEF635F1296D1C755", "_encstr_95A30C63C089D1FA5591E75B7D01", "_encstr_A1ED09400BA5D351227715", var_0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_81F20CA34DEDEF635F1296D1C755", "_encstr_95A30C63C089D1FA5591E75B7D01", "_encstr_B607032B8B", 0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_81F20CA34DEDEF635F1296D1C755", "_encstr_95A30C63C089D1FA5591E75B7D01", "_encstr_A51F05CB11A052", 0);
}

get_rank_by_xp(var_0) {
  var_1 = 0;

  if(var_0 >= level.zombie_ranks[level.zombie_max_rank].xp["_encstr_B81904B62CC3"])
    return level.zombie_max_rank;

  if(isDefined(level.zombie_ranks)) {
    for(var_2 = 0; var_2 < level.zombie_ranks.size; var_2++) {
      if(var_0 >= level.zombie_ranks[var_2].xp["_encstr_8719046B4BB9"]) {
        if(var_0 < level.zombie_ranks[var_2].xp["_encstr_B81904B62CC3"]) {
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
  if(isDefined(var_0.xpscale))
    return var_0.xpscale;
  else
    return 1;
}

wait_and_give_player_xp(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(var_1);
  give_player_xp(var_0);
}

get_weapon_passive_xp_scale(var_0) {
  if(isDefined(var_0.weapon_passive_xp_multiplier) && istrue(var_0.kill_with_extra_xp_passive)) {
    var_0.kill_with_extra_xp_passive = 0;
    return var_0.weapon_passive_xp_multiplier;
  } else
    return 1;
}

give_player_xp(var_0, var_1) {
  var_0 = get_scaled_xp(self, var_0);

  if(isDefined(self.totalxpearned))
    self.totalxpearned = self.totalxpearned + var_0;

  thread give_player_session_xp(var_0);
  var_2 = 0;
  var_3 = get_player_rank();
  var_4 = get_player_xp();
  var_5 = var_4 + var_0;
  set_player_xp(var_5);

  if(istrue(var_1) && var_0 > 0 && !scripts\cp\utility::turn_off_sniper_laser()) {
    self setclientomnvar("_encstr_92400E851F35915BA3A91BE133BF1623", var_0);
    self setclientomnvar("_encstr_86100EC388D11770F0C7EEE779D03F57", gettime());
  }

  var_6 = get_rank_by_xp(var_5);

  if(var_6 > var_3) {
    if(var_6 == level.zombie_max_rank + 1)
      var_2 = 1;

    set_player_rank(var_6);

    if(var_2 == 0) {
      var_7 = var_6 + 1;
      var_8 = get_splash_by_id(var_6);
      self notify("_encstr_BE9F0ACEAE1227418C9F7050", var_6);
      update_player_session_rankup();
    }

    process_rank_merits(var_6);
  }
}

process_rank_merits(var_0) {
  scripts\cp\cp_merits::processmerit("_encstr_BE610E1FB140CF9B107B9BFF6F3851E9");

  if(var_0 >= 40)
    scripts\cp\cp_merits::processmerit("_encstr_AC610EE05BD78B652AAA55D38702F77B");

  if(var_0 >= 60)
    scripts\cp\cp_merits::processmerit("_encstr_B8610E8D5B29A0EB75276B17672D61BB");

  if(var_0 >= 80)
    scripts\cp\cp_merits::processmerit("_encstr_8F610ED0FB69218B5FA3ED6B8F671661");

  if(var_0 >= 100)
    scripts\cp\cp_merits::processmerit("_encstr_91610E1513FF9A1B5D6F1361C750F075");

  if(var_0 >= 120)
    scripts\cp\cp_merits::processmerit("_encstr_93610ED899FF035AC5D71D89AF40E74F");

  if(var_0 >= 140)
    scripts\cp\cp_merits::processmerit("_encstr_A3610E5BF4A9F84EE75BEB7022DF908A");

  if(var_0 >= 160)
    scripts\cp\cp_merits::processmerit("_encstr_A7610E5B47BEE0272B9BA396762BEB70");

  if(var_0 >= 180)
    scripts\cp\cp_merits::processmerit("_encstr_A1610E9B34E9B80EA71BAB30629F503A");

  if(var_0 >= 200)
    scripts\cp\cp_merits::processmerit("_encstr_AC7B0F18A32F638D32826DFB9F6A8F0328");
}

inc_stat(var_0, var_1, var_2) {
  var_3 = self getplayerdata("_encstr_850703B7D9", var_0, var_1);
  var_4 = var_3 + var_2;
  self setplayerdata("_encstr_850703B7D9", var_0, var_1, var_4);
}

inc_session_stat(var_0, var_1) {
  inc_stat("_encstr_8D720DB1E3340748613532E3D0F095", var_0, var_1);
}

get_hives_destroyed_stat() {
  return get_aliensession_stat("_encstr_AF0C0FB3E153217787CA380893653B7973");
}

get_aliensession_stat(var_0) {
  return self getplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", var_0);
}

set_aliensession_stat(var_0, var_1) {
  self setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", var_0, var_1);
}

update_deployable_box_performance(var_0) {
  if(isDefined(level.update_deployable_box_performance_func))
    var_0[[level.update_deployable_box_performance_func]]();
  else
    var_0 scripts\cp\cp_gamescore::update_personal_encounter_performance(scripts\cp\cp_gamescore::get_team_score_component_name(), "_encstr_87CF14D195C26BF56EAE1C387BE447BE32B20763EDF2");
}

update_lb_aliensession_challenge(var_0) {
  foreach(var_2 in level.players) {
    var_2 lb_player_update_stat("_encstr_ADAE14CB90A6D88185C07001D33714DC098F73C87DA9", 1);

    if(var_0)
      var_2 lb_player_update_stat("_encstr_911F1446D019B0116FD0FA15CB6EAD6BF1691D551D5F", 1);
  }
}

update_lb_aliensession_wave(var_0) {
  foreach(var_2 in level.players)
  var_2 lb_player_update_stat("_encstr_838808DBB7E55A5EBB70", var_0, 1);
}

update_lb_aliensession_escape(var_0, var_1) {
  var_2 = get_lb_escape_rank(var_1);

  foreach(var_4 in var_0) {
    var_4 lb_player_update_stat("_encstr_85EE0C1D9F6026433501B18A681A" + var_2, 1, 1);
    var_4 lb_player_update_stat("_encstr_88CC0521F3A13B", 1, 1);
  }
}

update_alien_kill_sessionstats(var_0, var_1) {
  if(!isDefined(var_1) || !isPlayer(var_1)) {
    return;
  }
  if(scripts\cp\utility::is_trap(var_0))
    var_1 lb_player_update_stat("_encstr_8A8C0A89AB725F31196DF0EB", 1);
}

register_lb_escape_rank(var_0) {
  level.escape_rank_array = var_0;
}

get_lb_escape_rank(var_0) {
  for(var_1 = 0; var_1 < level.escape_rank_array.size - 1; var_1++) {
    if(var_0 >= level.escape_rank_array[var_1] && var_0 < level.escape_rank_array[var_1 + 1])
      return var_1;
  }
}

have_clan_tag(var_0) {
  return issubstr(var_0, "_encstr_B44C0203") && issubstr(var_0, "_encstr_8C4C0209");
}

remove_clan_tag(var_0) {
  var_1 = strtok(var_0, "_encstr_8C4C0209");
  return var_1[1];
}

register_eog_to_lb_playerdata_mapping() {
  var_0 = [];
  var_1["_encstr_8E8D0697EB01F243"] = "_encstr_8E8D0697EB01F243";
  var_1["_encstr_921F0C32951CB1DBF22C26B1B29B"] = "_encstr_921F0C32951CB1DBF22C26B1B29B";
  var_1["_encstr_910F0CF942744811E3DA39C04337"] = "_encstr_910F0CF94274481163DA39C04337";
  var_1["_encstr_B642089B65A658E8F597"] = "_encstr_B642089B65A658E8F597";
  var_1["_encstr_A9AB06297DDFD816"] = "_encstr_8FAE0723DEEECDCA19";
  var_1["_encstr_B8590EB51A1259F00AE7F0C0DF22CBDF"] = "_encstr_8F14087D0F9B2FE8DA72";
  var_1["_encstr_82FB06EB26785BD7"] = "_encstr_82FB06EB26785BD7";
  var_1["_encstr_8A200E1BAB274E2B37B1CBDC38569B47"] = "_encstr_8A200E1BAB274E2B37B1CBD438569B47";
  var_1["_encstr_BD3B0E501BD2B5F9E303DB551753A141"] = "_encstr_BD3B0E501BD2B5F9E303DB451753A141";
  var_1["_encstr_AF0C0FB3E15321778FCA380893653B7973"] = "_encstr_AF0C0FB3E153217787CA380893653B7973";
  var_1["_encstr_838808DBB7E55A5EBB70"] = "_encstr_838808DBB7E55A5EBB70";
  level.eog_to_lb_playerdata_mapping = var_1;
}

get_mapped_lb_ref_from_eog_ref(var_0) {
  return level.eog_to_lb_playerdata_mapping[var_0];
}

play_time_monitor() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    wait 1;
    lb_player_update_stat("_encstr_84EF055338A18F", 1);
  }
}

record_player_kills(var_0, var_1, var_2, var_3) {
  if(scripts\cp\utility::isheadshot(var_0, var_1, var_2, var_3)) {
    increment_player_career_headshot_kills(var_3);
    var_3 eog_player_update_stat("_encstr_96D30A3468575BA7C307A128", 1);
  }

  var_3 increment_player_career_kills(var_3);
  var_3 eog_player_update_stat("_encstr_8E8D0697EB01F243", 1);
  var_3 scripts\cp\cp_analytics::log_event("_encstr_82470DF0B83BAAB09D966F23813C01", 1, [var_3.clientid], [var_3.clientid], [var_3.clientid]);
}

increment_player_career_total_waves(var_0) {
  if(isDefined(var_0.wave_num_when_joined))
    increment_zombiecareerstats(var_0, "_encstr_84BE0C792AC3236897A747C46DDF", level.wave_num - var_0.wave_num_when_joined);
  else
    increment_zombiecareerstats(var_0, "_encstr_84BE0C792AC3236897A747C46DDF", level.wave_num);
}

increment_player_career_total_score(var_0) {
  increment_zombiecareerstats(var_0, "_encstr_84850C4BC72D027CF16F262DA3C8", var_0.score_earned);
}

increment_player_career_shots_fired(var_0) {
  increment_zombiecareerstats(var_0, "_encstr_A2E60C192098E3EAC1CD21229340", 1);
}

increment_player_career_shots_on_target(var_0) {
  increment_zombiecareerstats(var_0, "_encstr_84851057C9A05363F1E8652167E8AABA0D59", 1);
}

increment_player_career_explosive_kills(var_0) {
  increment_zombiecareerstats(var_0, "_encstr_830D10A8F08363B7DC966756BEA55AD8C6B9", 1);
}

increment_player_career_doors_opened(var_0) {
  increment_zombiecareerstats(var_0, "_encstr_88130D83E878EAAB1FA7B2EF880392", 1);
}

increment_player_career_perks_used(var_0) {
  increment_zombiecareerstats(var_0, "_encstr_8F180BF815EB0F422739BBD258", 1);
}

increment_player_career_kills(var_0) {
  increment_zombiecareerstats(var_0, "_encstr_8E8D0617EB01F243", 1);

  if(should_update_leaderboard_stats())
    updateleaderboardstats(var_0, "_encstr_8E8D0617EB01F243", 1, level.script, level.players.size, 1);
}

increment_player_career_headshot_kills(var_0) {
  var_0 increment_zombiecareerstats(var_0, "_encstr_B24E0F81FB60E50231478BE767CCEC2BAA", 1);

  if(should_update_leaderboard_stats())
    updateleaderboardstats(var_0, "_encstr_96D30A3C68575BA3C307A128", 1, level.script, level.players.size, 1);
}

increment_player_career_revives(var_0) {
  var_0 increment_zombiecareerstats(var_0, "_encstr_B642081B65A658E8F597", 1);

  if(should_update_leaderboard_stats())
    updateleaderboardstats(var_0, "_encstr_B642081B65A658E8F597", 1, level.script, level.players.size, 1);
}

increment_player_career_downs(var_0) {
  var_0 increment_zombiecareerstats(var_0, "_encstr_A9AB062D7DDFD816", 1);

  if(should_update_leaderboard_stats())
    updateleaderboardstats(var_0, "_encstr_A9AB062D7DDFD816", 1, level.script, level.players.size, 1);
}

mortars_get_player_targeted() {
  level.watchtrigger = 1;
}

should_update_leaderboard_stats() {
  return istrue(level.watchtrigger);
}

update_players_career_highest_wave(var_0, var_1) {
  foreach(var_3 in level.players)
  update_player_career_highest_wave(var_3, var_0, var_1, level.players.size);
}

update_player_career_highest_wave(var_0, var_1, var_2) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    updateifgreaterthan_zombiecareerstats(var_0, "_encstr_825C0D1C828F3B20DA74475F8943F8", var_1);
    check_and_update_best_stats(var_0, var_1, "_encstr_825C0D1C828F3B20DA74475F8943F8", level.script, var_2);
    updateleaderboardstats(var_0, "_encstr_97010743D7BDE26460", var_1, level.script, var_2, 1);
  }
}

increment_zombiecareerstats(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 1;

  var_3 = var_0 getplayerdata("_encstr_850703B7D9", "_encstr_B864100E38A8A0F877252F274D36D3E9D803", var_1);
  var_4 = var_3 + var_2;
  var_0 setplayerdata("_encstr_850703B7D9", "_encstr_B864100E38A8A0F877252F274D36D3E9D803", var_1, int(var_4));
}

updateifgreaterthan_zombiecareerstats(var_0, var_1, var_2) {
  var_3 = var_0 getplayerdata("_encstr_850703B7D9", "_encstr_B864100E38A8A0F877252F274D36D3E9D803", var_1);

  if(var_2 > var_3)
    var_0 setplayerdata("_encstr_850703B7D9", "_encstr_B864100E38A8A0F877252F274D36D3E9D803", var_1, var_2);
}

update_highest_wave_lb(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0 getplayerdata("_encstr_850703B7D9", "_encstr_BD6C108AE1FFC30FC8A507119DA0971F9D99", var_3, "_encstr_85411675C1600C32669DEFCFA5056841B029E2BF9BA9D19B", var_4, var_2);

  if(var_1 > var_5)
    var_0 setplayerdata("_encstr_850703B7D9", "_encstr_BD6C108AE1FFC30FC8A507119DA0971F9D99", var_3, "_encstr_85411675C1600C32669DEFCFA5056841B029E2BF9BA9D19B", var_4, var_2, var_1);
}

check_and_update_best_stats(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(should_update_leaderboard_stats()) {
    var_6 = var_0 getplayerdata("_encstr_850703B7D9", "_encstr_BD6C108AE1FFC30FC8A507119DA0971F9D99", var_3, "_encstr_85411675C1600C32669DEFCFA5056841B029E2BF9BA9D19B", var_4, var_2);

    if(!istrue(var_5)) {
      if(var_1 > var_6)
        var_0 setplayerdata("_encstr_850703B7D9", "_encstr_BD6C108AE1FFC30FC8A507119DA0971F9D99", var_3, "_encstr_85411675C1600C32669DEFCFA5056841B029E2BF9BA9D19B", var_4, var_2, var_1);
    } else if(var_1 < var_6)
      var_0 setplayerdata("_encstr_850703B7D9", "_encstr_BD6C108AE1FFC30FC8A507119DA0971F9D99", var_3, "_encstr_85411675C1600C32669DEFCFA5056841B029E2BF9BA9D19B", var_4, var_2, var_1);
  }
}

updateleaderboardstats(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(should_update_leaderboard_stats()) {
    if(!isDefined(var_5))
      var_5 = 1;

    var_6 = var_0 getplayerdata("_encstr_850703B7D9", "_encstr_BD6C108AE1FFC30FC8A507119DA0971F9D99", var_3, "_encstr_85411675C1600C32669DEFCFA5056841B029E2BF9BA9D19B", var_4, var_1);
    var_2 = var_6 + var_5;

    if(var_2 > var_6)
      var_0 setplayerdata("_encstr_850703B7D9", "_encstr_BD6C108AE1FFC30FC8A507119DA0971F9D99", var_3, "_encstr_85411675C1600C32669DEFCFA5056841B029E2BF9BA9D19B", var_4, var_1, var_2);
  }
}