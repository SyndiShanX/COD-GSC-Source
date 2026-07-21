/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_dom.gsc
***********************************************/

main() {
  if(scripts\common\utility::is_map_using_locales_only()) {
    return;
  }
  level.bot_ignore_precalc_paths = 0;
  setup_callbacks();
  setup_bot_dom(3, 5);
  level thread scripts\mp\bots\bots_util::bot_monitor_enemy_camp_spots(scripts\mp\bots\bots_util::bot_valid_camp_assassin);
}

setup_callbacks() {
  level.bot_funcs["_encstr_99EB0E12DB5279E596CEBBD2C11B30F8"] = ::crate_can_use;
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::bot_dom_think;
  level.bot_funcs["_encstr_AA071F6E347B5DD832FA6E4716C9D1EB36B05D3A4BB7EAE6BE16070EE4DBB0D80D"] = ::should_start_cautious_approach_dom;
  level.bot_funcs["_encstr_92C10E1BAC8546599CBE8C2D0B8DEDCE"] = ::bot_dom_leader_dialog;

  if(!level.bot_ignore_precalc_paths)
    level.bot_funcs["_encstr_B2E0163B56A3BEEE2CE88DD07D37B7462BF58DA12CB9D8AC"] = ::bot_dom_get_node_chance;
}

crate_can_use(var_0) {
  if(isagent(self) && !isDefined(var_0.boxtype))
    return 0;

  if(!scripts\mp\utility\entity::isteamparticipant(self))
    return 1;

  return scripts\mp\bots\bots_util::bot_is_protecting();
}

monitor_flag_control() {
  self notify("_encstr_93D715284F837F1B7888E6A19CF94CC7B0C72BF8430F03");
  self endon("_encstr_93D715284F837F1B7888E6A19CF94CC7B0C72BF8430F03");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait 1;
    var_0 = _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getflagteam();

    if(var_0 != "_encstr_A7A408B9CA5D1D4E2C63") {
      var_1 = getzonenearest(self.trigger.origin);

      if(isDefined(var_1))
        botzonesetteam(var_1, var_0);
    }
  }
}

monitor_flag_ownership() {
  self notify("_encstr_A184177A0A68E8ABDF7397E359E05851509F46FFF210D05C23");
  self endon("_encstr_A184177A0A68E8ABDF7397E359E05851509F46FFF210D05C23");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getflagteam();

  for(;;) {
    var_1 = _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getflagteam();

    if(var_1 != var_0)
      level notify("_encstr_8A7D175CB1488CF9B0D0E043426FDD099F73FAE1F372F84BB3");

    var_0 = var_1;
    wait 0.05;
  }
}

setup_bot_dom(var_0, var_1) {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();
  var_2 = bot_get_all_possible_flags();

  if(var_2.size > 3) {
    while(!isDefined(level.teleport_dom_finished_initializing))
      wait 0.05;

    var_3 = [];

    foreach(var_5 in var_2) {
      if(!isDefined(var_3[var_5.teleport_zone]))
        var_3[var_5.teleport_zone] = [];

      var_3[var_5.teleport_zone] = scripts\engine\utility::array_add(var_3[var_5.teleport_zone], var_5);
    }

    foreach(var_9, var_8 in var_3) {
      level.entrance_points_finished_caching = 0;
      bot_cache_flag_distances(var_8);
      _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::bot_cache_entrances_to_gametype_array(var_8, var_9 + "_encstr_97B606DF9028C9DA", level.bot_ignore_precalc_paths);
    }
  } else {
    _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::bot_cache_entrances_to_gametype_array(var_2, "_encstr_8F7905C4EDE23F", level.bot_ignore_precalc_paths);
    bot_cache_flag_distances(var_2);
    thread bot_wait_for_event_flag_swap(var_2);
  }

  foreach(var_5 in var_2) {
    var_5 thread monitor_flag_control();
    var_5 thread monitor_flag_ownership();

    if(var_5.objectivekey != "_encstr_B20703DFCF" && var_5.objectivekey != "_encstr_B40703E96D" && var_5.objectivekey != "_encstr_B6070359BA") {}

    var_5.nodes = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::bot_get_valid_nodes_in_trigger(var_5.trigger);
    var_5.last_time_secured["_encstr_9A8507BA4040188D08"] = 0;
    var_5.last_time_secured["_encstr_8E8405EA382B2A"] = 0;
  }

  level.bot_dom_override_flag_targets = [];
  level.bot_dom_override_flag_targets["_encstr_8E8405EA382B2A"] = [];
  level.bot_dom_override_flag_targets["_encstr_9A8507BA4040188D08"] = [];
  level.bot_gametype_precaching_done = 1;
}

bot_wait_for_event_flag_swap(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_BEA510108F5DC6E5E246A4B6D12A2F2BBD5B");
  _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::bot_cache_entrances_to_gametype_array(var_0, "_encstr_8F7905C4EDE23F", level.bot_ignore_precalc_paths, 1);
  bot_cache_flag_distances(var_0);

  foreach(var_2 in var_0)
  var_2.nodes = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::bot_get_valid_nodes_in_trigger(var_2);

  foreach(var_5 in level.participants) {
    if(scripts\mp\utility\entity::isaiteamparticipant(var_5))
      var_5.force_new_goal = 1;
  }
}

bot_get_all_possible_flags() {
  if(isDefined(level.all_dom_flags))
    return level.all_dom_flags;
  else
    return level.objectives;
}

bot_cache_flag_distances(var_0) {
  if(!isDefined(level.flag_distances))
    level.flag_distances = [];

  var_1 = [];
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_1[var_2] = var_4;
    var_2++;
  }

  for(var_2 = 0; var_2 < var_1.size - 1; var_2++) {
    for(var_6 = var_2 + 1; var_6 < var_1.size; var_6++) {
      var_7 = distance(var_1[var_2].trigger.origin, var_1[var_6].trigger.origin);
      var_8 = get_flag_label(var_1[var_2]);
      var_9 = get_flag_label(var_1[var_6]);
      level.flag_distances[var_8][var_9] = var_7;
      level.flag_distances[var_9][var_8] = var_7;
    }
  }
}

should_start_cautious_approach_dom(var_0) {
  if(var_0) {
    if(self.current_flag _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getflagteam() == "_encstr_A7A408B9CA5D1D4E2C63" && flag_has_never_been_captured(self.current_flag)) {
      var_1 = get_closest_flag(self.lastspawnpoint.origin);

      if(var_1 == self.current_flag)
        return 0;
      else {
        var_2 = get_other_flag(var_1, self.current_flag);
        var_3 = distancesquared(var_1.trigger.origin, self.current_flag.trigger.origin);
        var_4 = distancesquared(var_2.trigger.origin, self.current_flag.trigger.origin);

        if(var_3 < var_4)
          return 0;
      }
    }
  }

  return scripts\mp\bots\bots_strategy::should_start_cautious_approach_default(var_0);
}

bot_dom_debug_should_capture_all() {
  return 0;
}

bot_dom_debug_should_protect_all() {
  return 0;
}

bot_dom_think() {
  self notify("_encstr_8FFE0E33587C49D7A863062B184FD683");
  self endon("_encstr_8FFE0E33587C49D7A863062B184FD683");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self.force_new_goal = 0;
  self.new_goal_time = 0;
  self.next_strat_level_check = 0;
  self botsetflag("_encstr_ABF30BBF587B195B43BDD44DA8", 0);
  self botsetflag("_encstr_B68D13D9272BDC16C856AFBD264D951B474B3BB2CD", 1);
  self botsetflag("_encstr_8D1813AECD95D7B731A9BE83C21D0DAF9B8EBC6395", 1);

  for(;;) {
    scripts\mp\bots\bots_util::bot_update_camp_assassin();
    var_0 = gettime();

    if(var_0 > self.next_strat_level_check) {
      self.next_strat_level_check = gettime() + 10000;
      self.strategy_level = self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592");
    }

    if(var_0 > self.new_goal_time || self.force_new_goal) {
      if(should_delay_flag_decision())
        self.new_goal_time = var_0 + 5000;
      else {
        self.force_new_goal = 0;
        bot_choose_flag();
        self.new_goal_time = var_0 + randomintrange(30000, 45000);
      }
    }

    scripts\engine\utility::waittill_notify_or_timeout("_encstr_AD9914B9AC95469BFAB959DDEBCC632C3BF5D9B758D8", 1.0);
  }
}

should_delay_flag_decision() {
  if(self.force_new_goal)
    return 0;

  if(!scripts\mp\bots\bots_util::bot_is_capturing())
    return 0;

  if(self.current_flag _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getflagteam() == self.team)
    return 0;

  var_0 = get_flag_capture_radius();

  if(distancesquared(self.origin, self.current_flag.trigger.origin) < var_0 * 2 * (var_0 * 2)) {
    var_1 = get_ally_flags(self.team);

    if(var_1.size == 2 && !scripts\engine\utility::array_contains(var_1, self.current_flag) && !bot_allowed_to_3_cap())
      return 0;

    return 1;
  }

  return 0;
}

get_override_flag_targets() {
  return level.bot_dom_override_flag_targets[self.team];
}

has_override_flag_targets() {
  var_0 = get_override_flag_targets();
  return var_0.size > 0;
}

flag_has_been_captured_before(var_0) {
  return !flag_has_never_been_captured(var_0);
}

flag_has_never_been_captured(var_0) {
  return var_0.firstcapture;
}

bot_choose_flag() {
  var_0 = undefined;
  var_1 = [];
  var_2 = [];
  var_3 = !istrue(level.precappoints);
  var_4 = get_override_flag_targets();

  if(var_4.size > 0)
    var_5 = var_4;
  else
    var_5 = level.objectives;

  foreach(var_0 in var_5) {
    var_7 = var_0 _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getflagteam();

    if(var_3) {
      if(flag_has_been_captured_before(var_0))
        var_3 = 0;
      else {}
    }

    if(var_7 != self.team) {
      var_1[var_1.size] = var_0;
      continue;
    }

    var_2[var_2.size] = var_0;
  }

  var_9 = undefined;

  if(var_1.size == 3)
    var_9 = 1;
  else if(var_1.size == 2) {
    if(var_2.size == 1) {
      if(!bot_should_defend_flag(var_2[0], 1))
        var_9 = 1;
      else
        var_9 = !bot_should_defend(0.34);

      if(scripts\mp\bots\bots_util::bot_get_max_players_on_team(self.team) == 1)
        var_9 = 1;
    } else if(var_2.size == 0)
      var_9 = 1;
  } else if(var_1.size == 1) {
    if(var_2.size == 2) {
      if(bot_allowed_to_3_cap()) {
        if(!bot_should_defend_flag(var_2[0], 2) && !bot_should_defend_flag(var_2[1], 2))
          var_9 = 1;
        else if(self.strategy_level == 0)
          var_9 = !bot_should_defend(0.34);
        else
          var_9 = !bot_should_defend(0.5);
      } else
        var_9 = 0;
    } else if(var_2.size == 1) {
      if(!bot_should_defend_flag(var_2[0], 1))
        var_9 = 1;
      else
        var_9 = !bot_should_defend(0.34);
    } else if(var_2.size == 0)
      var_9 = 1;
  } else if(var_1.size == 0)
    var_9 = 0;

  if(var_9) {
    if(var_1.size > 1) {
      var_10 = [];

      foreach(var_12 in var_1)
      var_10[var_10.size] = var_12.trigger;

      var_14 = scripts\engine\utility::get_array_of_closest(self.origin, var_10);
      var_15 = [];

      foreach(var_17 in var_14) {
        foreach(var_19 in level.objectives) {
          if(var_19.trigger == var_17)
            var_15[var_15.size] = var_19;
        }
      }

      var_14 = var_15;
    } else
      var_14 = var_1;

    if(var_3 && !has_override_flag_targets()) {
      var_22 = get_num_allies_capturing_flag(var_14[0], 1);

      if(var_22 < min_num_bots_assaulting_first_flag())
        var_23 = 0;
      else {
        var_24 = 20;
        var_25 = 65;
        var_26 = 15;

        if(self.strategy_level == 0) {
          var_24 = 50;
          var_25 = 25;
          var_26 = 25;
        } else if(self.strategy_level == 1) {
          var_24 = 40;
          var_25 = 40;
          var_26 = 20;
        }

        var_27 = randomint(100);

        if(var_27 < var_24)
          var_23 = 0;
        else if(var_27 < var_24 + var_25)
          var_23 = 1;
        else
          var_23 = 2;
      }

      var_28 = undefined;

      if(var_23 == 0)
        var_28 = "_encstr_99CC09DA9020C4ECD149AD";

      capture_flag(var_14[var_23], var_28);
      return;
    }

    if(var_14.size == 1)
      var_0 = var_14[0];
    else if(distancesquared(var_14[0].trigger.origin, self.origin) < 102400)
      var_0 = var_14[0];
    else {
      var_29 = [];
      var_30 = [];

      for(var_31 = 0; var_31 < var_14.size; var_31++) {
        var_32 = distance(var_14[var_31].trigger.origin, self.origin);
        var_30[var_31] = var_32;
        var_29[var_31] = var_32;
      }

      if(var_2.size == 1) {
        var_33 = 1.5;

        for(var_31 = 0; var_31 < var_29.size; var_31++)
          var_29[var_31] = var_29[var_31] + level.flag_distances[get_flag_label(var_14[var_31])][get_flag_label(var_2[0])] * var_33;
      }

      if(self.strategy_level == 0) {
        var_27 = randomint(100);

        if(var_27 < 50)
          var_0 = var_14[0];
        else if(var_27 < 50 + 50 / (var_14.size - 1))
          var_0 = var_14[1];
        else
          var_0 = var_14[2];
      } else if(var_29.size == 2) {
        var_34[0] = 50;
        var_34[1] = 50;

        for(var_31 = 0; var_31 < var_14.size; var_31++) {
          if(var_29[var_31] < var_29[1 - var_31]) {
            var_34[var_31] = var_34[var_31] + 20;
            var_34[1 - var_31] = var_34[1 - var_31] - 20;
          }

          if(var_30[var_31] < 640) {
            var_34[var_31] = var_34[var_31] + 15;
            var_34[1 - var_31] = var_34[1 - var_31] - 15;
          }

          if(var_14[var_31] _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getflagteam() == "_encstr_A7A408B9CA5D1D4E2C63") {
            var_34[var_31] = var_34[var_31] + 15;
            var_34[1 - var_31] = var_34[1 - var_31] - 15;
          }
        }

        var_27 = randomint(100);

        if(var_27 < var_34[0])
          var_0 = var_14[0];
        else
          var_0 = var_14[1];
      } else if(var_29.size == 3) {
        var_34[0] = 34;
        var_34[1] = 33;
        var_34[2] = 33;

        for(var_31 = 0; var_31 < var_14.size; var_31++) {
          var_35 = (var_31 + 1) % 3;
          var_36 = (var_31 + 2) % 3;

          if(var_29[var_31] < var_29[var_35] && var_29[var_31] < var_29[var_36]) {
            var_34[var_31] = var_34[var_31] + 36;
            var_34[var_35] = var_34[var_35] - 18;
            var_34[var_36] = var_34[var_36] - 18;
          }

          if(var_30[var_31] < 640) {
            var_34[var_31] = var_34[var_31] + 15;
            var_34[var_35] = var_34[var_35] - 7;
            var_34[var_36] = var_34[var_36] - 8;
          }

          if(var_14[var_31] _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getflagteam() == "_encstr_A7A408B9CA5D1D4E2C63") {
            var_34[var_31] = var_34[var_31] + 15;
            var_34[var_35] = var_34[var_35] - 7;
            var_34[var_36] = var_34[var_36] - 8;
          }
        }

        var_27 = randomint(100);

        if(var_27 < var_34[0])
          var_0 = var_14[0];
        else if(var_27 < var_34[0] + var_34[1])
          var_0 = var_14[1];
        else
          var_0 = var_14[2];
      }
    }
  } else {
    if(var_2.size > 1) {
      var_10 = [];

      foreach(var_38 in var_2)
      var_10[var_10.size] = var_38.trigger;

      var_40 = scripts\engine\utility::get_array_of_closest(self.origin, var_10);
      var_15 = [];

      foreach(var_17 in var_40) {
        foreach(var_19 in level.objectives) {
          if(var_19.trigger == var_17)
            var_15[var_15.size] = var_19;
        }
      }

      var_40 = var_15;
    } else
      var_40 = var_2;

    foreach(var_46 in var_40) {
      if(bot_should_defend_flag(var_46, var_2.size)) {
        var_0 = var_46;
        break;
      }
    }

    if(!isDefined(var_0)) {
      if(self.strategy_level == 0)
        var_0 = var_2[0];
      else if(var_40.size == 2) {
        var_48 = get_other_flag(var_40[0], var_40[1]);
        var_10 = [];

        foreach(var_50 in var_40)
        var_10[var_10.size] = var_50.trigger;

        var_52 = scripts\engine\utility::get_array_of_closest(var_48.trigger.origin, var_10);
        var_15 = [];

        foreach(var_17 in var_52) {
          foreach(var_19 in level.objectives) {
            if(var_19.trigger == var_17)
              var_15[var_15.size] = var_19;
          }
        }

        var_52 = var_15;
        var_27 = randomint(100);

        if(var_27 < 70)
          var_0 = var_52[0];
        else
          var_0 = var_52[1];
      } else
        var_0 = var_40[0];
    }
  }

  if(var_9)
    capture_flag(var_0);
  else
    defend_flag(var_0);
}

min_num_bots_assaulting_first_flag() {
  var_0 = scripts\mp\bots\bots_util::bot_get_max_players_on_team(self.team);
  return ceil(var_0 / 3);
}

bot_allowed_to_3_cap() {
  if(self.strategy_level == 0)
    return 1;

  var_0 = get_override_flag_targets();

  if(var_0.size == 3)
    return 1;

  var_1 = scripts\mp\gamescore::_getteamscore(scripts\engine\utility::get_enemy_team(self.team));
  var_2 = scripts\mp\gamescore::_getteamscore(self.team);
  var_3 = 200 - var_1;
  var_4 = 200 - var_2;
  var_5 = var_4 * 0.5 > var_3;
  return var_5;
}

bot_should_defend(var_0) {
  if(randomfloat(1) < var_0)
    return 1;

  var_1 = level.bot_personality_type[self.personality];

  if(var_1 == "_encstr_88FA0B7271CF407FE86D0FEBE3")
    return 1;
  else if(var_1 == "_encstr_930B07BB1B6B3854FF")
    return 0;
}

capture_flag(var_0, var_1, var_2) {
  self.current_flag = var_0;

  if(bot_dom_debug_should_protect_all()) {
    var_3["_encstr_A105137B6759274EB4C8B2AFECB78536D7A32F382B"] = var_1;
    var_3["_encstr_A136168FEA0B6BCBE09EF96870352B232BE7CEA3D8D0F2E0"] = get_flag_label(var_0);
    scripts\mp\bots\bots_strategy::bot_protect_point(var_0.trigger.origin, get_flag_protect_radius(), var_3);
  } else {
    var_3["_encstr_A105137B6759274EB4C8B2AFECB78536D7A32F382B"] = var_1;
    var_3["_encstr_A136168FEA0B6BCBE09EF96870352B232BE7CEA3D8D0F2E0"] = get_flag_label(var_0);
    scripts\mp\bots\bots_strategy::bot_capture_zone(var_0.trigger.origin, var_0.nodes, var_0.trigger, var_3);
  }

  if(!isDefined(var_2) || !var_2)
    thread monitor_flag_status(var_0);
}

defend_flag(var_0) {
  self.current_flag = var_0;

  if(bot_dom_debug_should_capture_all()) {
    var_1["_encstr_A136168FEA0B6BCBE09EF96870352B232BE7CEA3D8D0F2E0"] = get_flag_label(var_0);
    scripts\mp\bots\bots_strategy::bot_capture_zone(var_0.trigger.origin, var_0.nodes, var_0.trigger, var_1);
  } else {
    var_1["_encstr_A136168FEA0B6BCBE09EF96870352B232BE7CEA3D8D0F2E0"] = get_flag_label(var_0);
    var_1["_encstr_856A173AF01B4A47A3FD9FD618290F596908916268ED039FBB"] = var_0.nearest_node;
    scripts\mp\bots\bots_strategy::bot_protect_point(var_0.trigger.origin, get_flag_protect_radius(), var_1);
  }

  thread monitor_flag_status(var_0);
}

get_flag_capture_radius() {
  if(!isDefined(level.capture_radius))
    level.capture_radius = 158;

  return level.capture_radius;
}

get_flag_protect_radius() {
  if(!isDefined(level.protect_radius)) {
    var_0 = self botgetworldsize();
    var_1 = (var_0[0] + var_0[1]) / 2;
    level.protect_radius = min(1000, var_1 / 3.5);
  }

  return level.protect_radius;
}

bot_dom_leader_dialog(var_0, var_1) {
  if(issubstr(var_0, "_encstr_8267076C10DBE8B6E0") && var_0 != "_encstr_8D7C0DF02FE3A055F2A9CEDEBD7B9B" && var_0 != "_encstr_ACB10CD3D712C70844B1E3415195" && var_0 != "_encstr_8CC614AFA733EA82D5BE6CA57961A80533B86897A391") {
    var_2 = getsubstr(var_0, var_0.size - 2);
    var_3 = get_specific_flag_by_label(var_2);

    if(isDefined(var_3) && bot_allow_to_capture_flag(var_3)) {
      self botmemoryevent("_encstr_BD560CF2309FE383DE9D4645A122", undefined, var_3.trigger.origin);

      if(!isDefined(self.last_losing_flag_react) || gettime() - self.last_losing_flag_react > 10000) {
        if(scripts\mp\bots\bots_util::bot_is_protecting()) {
          var_4 = distancesquared(self.origin, var_3.trigger.origin) < 490000;
          var_5 = bot_is_protecting_flag(var_3);

          if(var_4 || var_5) {
            capture_flag(var_3);
            self.last_losing_flag_react = gettime();
          }
        }
      }
    }
  } else if(issubstr(var_0, "_encstr_AAE70838F27E43E327DC")) {
    var_2 = getsubstr(var_0, var_0.size - 2);
    var_6 = get_specific_flag_by_label(var_2);
    var_6.last_time_secured[self.team] = gettime();
  }

  scripts\mp\bots\bots_util::bot_leader_dialog(var_0, var_1);
}

bot_allow_to_capture_flag(var_0) {
  var_1 = get_override_flag_targets();

  if(var_1.size == 0)
    return 1;

  if(scripts\engine\utility::array_contains(var_1, var_0))
    return 1;

  return 0;
}

monitor_flag_status(var_0) {
  self notify("_encstr_A3A914059848D2D1C2564F88E28F1AD788F313637B1F");
  self endon("_encstr_A3A914059848D2D1C2564F88E28F1AD788F313637B1F");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = get_num_ally_flags(self.team);
  var_2 = get_flag_capture_radius() * get_flag_capture_radius();
  var_3 = get_flag_capture_radius() * 3 * (get_flag_capture_radius() * 3);
  var_4 = 1;

  while(var_4) {
    var_5 = 0;
    var_6 = var_0 _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getflagteam();
    var_7 = get_num_ally_flags(self.team);
    var_8 = get_enemy_flags(self.team);

    if(scripts\mp\bots\bots_util::bot_is_capturing()) {
      if(var_6 == self.team && var_0.claimteam == "_encstr_8BBA05185F8B99") {
        if(!bot_dom_debug_should_capture_all())
          var_5 = 1;
      }

      if(var_7 == 2 && var_6 != self.team && !bot_allowed_to_3_cap()) {
        if(distancesquared(self.origin, var_0.trigger.origin) > var_2)
          var_5 = 1;
      }

      foreach(var_10 in var_8) {
        if(var_10 != var_0 && bot_allow_to_capture_flag(var_10)) {
          if(distancesquared(self.origin, var_10.trigger.origin) < var_3)
            var_5 = 1;
        }
      }

      if(self istouching(var_0.trigger) && var_0.userate <= 0) {
        if(self bothasscriptgoal()) {
          var_12 = self botgetscriptgoal();
          var_13 = self botgetscriptgoalRadius();

          if(distancesquared(self.origin, var_12) < squared(var_13)) {
            var_14 = self getnearestnode();

            if(isDefined(var_14)) {
              var_15 = undefined;

              foreach(var_17 in var_0.nodes) {
                if(!nodesvisible(var_17, var_14, 1)) {
                  var_15 = var_17.origin;
                  break;
                }
              }

              if(isDefined(var_15)) {
                self.defense_investigate_specific_point = var_15;
                self notify("_encstr_9ABE20A97F4E2B1872478D979B6AD589EE55110169A2C8461A93FFBBDB92A5F0B76D");
              }
            }
          }
        }
      }
    }

    if(scripts\mp\bots\bots_util::bot_is_protecting()) {
      if(var_6 != self.team) {
        if(!bot_dom_debug_should_protect_all())
          var_5 = 1;
      } else if(var_7 == 1 && var_1 > 1)
        var_5 = 1;
    }

    var_1 = var_7;

    if(var_5) {
      self.force_new_goal = 1;
      var_4 = 0;
      self notify("_encstr_AD9914B9AC95469BFAB959DDEBCC632C3BF5D9B758D8");
      continue;
    }

    var_19 = level scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_8A7D175CB1488CF9B0D0E043426FDD099F73FAE1F372F84BB3", 1 + randomfloatrange(0, 2));
    var_20 = isDefined(var_19) && var_19 == "_encstr_995408F398012F656821";

    if(!var_20) {
      var_21 = max((3 - self.strategy_level) * 1.0 + randomfloatrange(-0.5, 0.5), 0);
      wait(var_21);
    }
  }
}

bot_dom_get_node_chance(var_0) {
  if(var_0 == self.node_closest_to_defend_center)
    return 1.0;

  if(!isDefined(self.current_flag))
    return 1.0;

  var_1 = 0;
  var_2 = get_flag_label(self.current_flag);
  var_3 = get_ally_flags(self.team);

  foreach(var_5 in var_3) {
    if(var_5 != self.current_flag) {
      var_1 = var_0 scripts\mp\bots\bots_util::node_is_on_path_from_labels(var_2, get_flag_label(var_5));

      if(var_1) {
        var_6 = get_other_flag(self.current_flag, var_5);
        var_7 = var_6 _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getflagteam();

        if(var_7 != self.team) {
          if(var_0 scripts\mp\bots\bots_util::node_is_on_path_from_labels(var_2, get_flag_label(var_6)))
            var_1 = 0;
        }
      }
    }
  }

  if(var_1)
    return 0.2;

  return 1.0;
}

get_flag_label(var_0) {
  var_1 = "_encstr_B40101";

  if(isDefined(var_0.teleport_zone))
    var_1 = var_1 + (var_0.teleport_zone + "_encstr_BA4C02DF");

  var_1 = var_1 + ("_encstr_8F7905C4EDE23F" + var_0.objectivekey);
  return var_1;
}

get_other_flag(var_0, var_1) {
  foreach(var_3 in level.objectives) {
    if(var_3 != var_0 && var_3 != var_1)
      return var_3;
  }
}

get_specific_flag_by_letter(var_0) {
  var_1 = "_encstr_BA4C02DF" + tolower(var_0);
  return get_specific_flag_by_label(var_1);
}

get_specific_flag_by_label(var_0) {
  foreach(var_2 in level.objectives) {
    if(var_2.objectivekey == var_0)
      return var_2;
  }
}

get_closest_flag(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in level.objectives) {
    var_5 = distancesquared(var_4.trigger.origin, var_0);

    if(!isDefined(var_2) || var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

get_num_allies_capturing_flag(var_0, var_1) {
  var_2 = 0;
  var_3 = get_flag_capture_radius();

  foreach(var_5 in level.participants) {
    if(!isDefined(var_5.team)) {
      continue;
    }
    if(var_5.team == self.team && var_5 != self && scripts\mp\utility\entity::isteamparticipant(var_5)) {
      if(isai(var_5)) {
        if(var_5 bot_is_capturing_flag(var_0))
          var_2++;

        continue;
      }

      if(!isDefined(var_1) || !var_1) {
        if(var_5 istouching(var_0))
          var_2++;
      }
    }
  }

  return var_2;
}

bot_is_capturing_flag(var_0) {
  if(!scripts\mp\bots\bots_util::bot_is_capturing())
    return 0;

  return bot_target_is_flag(var_0);
}

bot_is_protecting_flag(var_0) {
  if(!scripts\mp\bots\bots_util::bot_is_protecting())
    return 0;

  return bot_target_is_flag(var_0);
}

bot_target_is_flag(var_0) {
  return self.current_flag == var_0;
}

get_num_ally_flags(var_0) {
  var_1 = 0;

  foreach(var_3 in level.objectives) {
    var_4 = var_3 _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getflagteam();

    if(var_4 == var_0)
      var_1++;
  }

  return var_1;
}

get_enemy_flags(var_0) {
  var_1 = [];

  foreach(var_3 in level.objectives) {
    var_4 = var_3 _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getflagteam();

    if(var_4 == scripts\engine\utility::get_enemy_team(var_0))
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
  }

  return var_1;
}

get_ally_flags(var_0) {
  var_1 = [];

  foreach(var_3 in level.objectives) {
    var_4 = var_3 _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getflagteam();

    if(var_4 == var_0)
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
  }

  return var_1;
}

bot_should_defend_flag(var_0, var_1) {
  var_2 = get_max_num_defenders_wanted_per_flag(var_1);
  var_3 = get_players_defending_flag(var_0);
  return var_3.size < var_2;
}

get_max_num_defenders_wanted_per_flag(var_0) {
  var_1 = scripts\mp\bots\bots_util::bot_get_max_players_on_team(self.team);

  if(var_0 == 1)
    return ceil(var_1 / 6);
  else
    return ceil(var_1 / 3);
}

get_players_defending_flag(var_0) {
  var_1 = get_flag_protect_radius();
  var_2 = [];

  foreach(var_4 in level.participants) {
    if(!isDefined(var_4.team)) {
      continue;
    }
    if(var_4.team == self.team && var_4 != self && scripts\mp\utility\entity::isteamparticipant(var_4)) {
      if(isai(var_4)) {
        if(var_4 bot_is_protecting_flag(var_0))
          var_2 = scripts\engine\utility::array_add(var_2, var_4);

        continue;
      }

      var_5 = gettime() - var_0.last_time_secured[self.team];

      if(var_5 < 10000) {
        continue;
      }
      if(distancesquared(var_0.trigger.origin, var_4.origin) < var_1 * var_1)
        var_2 = scripts\engine\utility::array_add(var_2, var_4);
    }
  }

  return var_2;
}