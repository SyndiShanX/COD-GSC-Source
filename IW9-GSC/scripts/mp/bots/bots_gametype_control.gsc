/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_control.gsc
*****************************************************/

main() {
  if(scripts\common\utility::is_map_using_locales_only()) {
    return;
  }
  level.bot_ignore_precalc_paths = 0;
  setup_callbacks();
  _id_161AA7AAD2DB33E2(2, 5);
  level thread scripts\mp\bots\bots_util::bot_monitor_enemy_camp_spots(scripts\mp\bots\bots_util::bot_valid_camp_assassin);
}

setup_callbacks() {
  level.bot_funcs["crate_can_use"] = ::crate_can_use;
  level.bot_funcs["gametype_think"] = ::_id_C74EC79728B3617B;
  level.bot_funcs["should_start_cautious_approach"] = ::_id_4D2BDE6F9DBB3C5A;
  level.bot_funcs["leader_dialog"] = ::_id_655F3CBE5E705AE5;

  if(!level.bot_ignore_precalc_paths)
    level.bot_funcs["get_watch_node_chance"] = ::_id_683A18BBD644237D;
}

_id_C74EC79728B3617B() {
  self notify("bot_control_think");
  self endon("bot_control_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self.force_new_goal = 0;
  self.new_goal_time = 0;
  self.next_strat_level_check = 0;
  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  self botsetflag("use_obj_path_style", 1);

  for(;;) {
    scripts\mp\bots\bots_util::bot_update_camp_assassin();
    _id_4FB72B720667636B = gettime();

    if(_id_4FB72B720667636B > self.next_strat_level_check) {
      self.next_strat_level_check = gettime() + 10000;
      self.strategy_level = self botgetdifficultysetting("strategyLevel");
    }

    if(_id_4FB72B720667636B > self.new_goal_time || self.force_new_goal) {
      if(should_delay_flag_decision())
        self.new_goal_time = _id_4FB72B720667636B + 5000;
      else {
        self.force_new_goal = 0;
        bot_choose_flag();
        self.new_goal_time = _id_4FB72B720667636B + randomintrange(30000, 45000);
      }
    }

    scripts\engine\utility::waittill_notify_or_timeout("needs_new_flag_goal", 1.0);
  }
}

crate_can_use(crate) {
  if(isagent(self) && !isDefined(crate.boxtype))
    return 0;

  if(!scripts\mp\utility\entity::isteamparticipant(self))
    return 1;

  return scripts\mp\bots\bots_util::bot_is_protecting();
}

monitor_flag_control() {
  self notify("monitor_flag_control");
  self endon("monitor_flag_control");
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 1;
    team = _id_108FAF3DABBC3E99::getflagteam();

    if(team != "neutral") {
      if(!isDefined(self.trigger)) {
        break;
      }

      zone = getzonenearest(self.trigger.origin);

      if(isDefined(zone))
        botzonesetteam(zone, team);
    }
  }
}

monitor_flag_ownership() {
  self notify("monitor_flag_ownership");
  self endon("monitor_flag_ownership");
  self endon("death");
  level endon("game_ended");
  _id_D0C86817AD6633C8 = _id_108FAF3DABBC3E99::getflagteam();

  for(;;) {
    _id_5A0FC1D304E970EA = _id_108FAF3DABBC3E99::getflagteam();

    if(_id_5A0FC1D304E970EA != _id_D0C86817AD6633C8)
      level notify("flag_changed_ownership");

    _id_D0C86817AD6633C8 = _id_5A0FC1D304E970EA;
    wait 0.05;
  }
}

_id_161AA7AAD2DB33E2(_id_C09EFFE906C04618, _id_C9D880AC3D2F2D31) {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();

  while(!isDefined(level.objectives) || level.objectives.size != 2)
    wait 0.5;

  objectives = bot_get_all_possible_flags();
  _id_7F989E71B934C9FC::bot_cache_entrances_to_gametype_array(objectives, "flag", level.bot_ignore_precalc_paths);
  bot_cache_flag_distances(objectives);

  foreach(flag in objectives) {
    flag thread monitor_flag_control();
    flag thread monitor_flag_ownership();

    if(flag.objectivekey != "_a" && flag.objectivekey != "_b") {}

    flag.nodes = _id_7F989E71B934C9FC::bot_get_valid_nodes_in_trigger(flag.trigger);
    flag.last_time_secured["allies"] = 0;
    flag.last_time_secured["axis"] = 0;
  }

  level._id_BBD2674F59FC7FF1 = [];
  level._id_BBD2674F59FC7FF1["axis"] = [];
  level._id_BBD2674F59FC7FF1["allies"] = [];
  level.bot_gametype_precaching_done = 1;
}

bot_get_all_possible_flags() {
  _id_A553D01644108B64 = [];

  foreach(flag in level.objectives) {
    if(isDefined(flag.trigger))
      _id_A553D01644108B64 = scripts\engine\utility::array_add(_id_A553D01644108B64, flag);
  }

  return _id_A553D01644108B64;
}

bot_cache_flag_distances(flags) {
  if(!isDefined(level.flag_distances))
    level.flag_distances = [];

  _id_DEA51D2A009AC6E7 = [];
  _id_AC0E594AC96AA3A8 = 0;

  foreach(flag in flags) {
    _id_DEA51D2A009AC6E7[_id_AC0E594AC96AA3A8] = flag;
    _id_AC0E594AC96AA3A8++;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_DEA51D2A009AC6E7.size - 1; _id_AC0E594AC96AA3A8++) {
    for(_id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8 + 1; _id_AC0E5C4AC96AAA41 < _id_DEA51D2A009AC6E7.size; _id_AC0E5C4AC96AAA41++) {
      _id_A5B88C96222E6A1B = distance(_id_DEA51D2A009AC6E7[_id_AC0E594AC96AA3A8].trigger.origin, _id_DEA51D2A009AC6E7[_id_AC0E5C4AC96AAA41].trigger.origin);
      _id_CC343FC5C37710ED = get_flag_label(_id_DEA51D2A009AC6E7[_id_AC0E594AC96AA3A8]);
      _id_E141E4DE30BD4300 = get_flag_label(_id_DEA51D2A009AC6E7[_id_AC0E5C4AC96AAA41]);
      level.flag_distances[_id_CC343FC5C37710ED][_id_E141E4DE30BD4300] = _id_A5B88C96222E6A1B;
      level.flag_distances[_id_E141E4DE30BD4300][_id_CC343FC5C37710ED] = _id_A5B88C96222E6A1B;
    }
  }
}

_id_4D2BDE6F9DBB3C5A(_id_44770B14726E7A47) {
  if(_id_44770B14726E7A47) {
    if(self.current_flag _id_108FAF3DABBC3E99::getflagteam() == "neutral" && flag_has_never_been_captured(self.current_flag)) {
      _id_75EE0B273DD2EC6A = get_closest_flag(self.lastspawnpoint.origin);

      if(_id_75EE0B273DD2EC6A == self.current_flag)
        return 0;
      else {
        _id_7D6C59551603A4F2 = get_other_flag(_id_75EE0B273DD2EC6A, self.current_flag);
        _id_146177C4671F2F2D = distancesquared(_id_75EE0B273DD2EC6A.trigger.origin, self.current_flag.trigger.origin);
        _id_D886E066E440ED6F = distancesquared(_id_7D6C59551603A4F2.trigger.origin, self.current_flag.trigger.origin);

        if(_id_146177C4671F2F2D < _id_D886E066E440ED6F)
          return 0;
      }
    }
  }

  return scripts\mp\bots\bots_strategy::should_start_cautious_approach_default(_id_44770B14726E7A47);
}

_id_39E20401248B86AB() {
  return 0;
}

_id_4646FCBE22380B06() {
  return 0;
}

should_delay_flag_decision() {
  if(self.force_new_goal)
    return 0;

  if(!scripts\mp\bots\bots_util::bot_is_capturing())
    return 0;

  if(self.current_flag _id_108FAF3DABBC3E99::getflagteam() == self.team)
    return 0;

  _id_3498229C5A4F8731 = get_flag_capture_radius();

  if(isDefined(self.current_flag.trigger) && distancesquared(self.origin, self.current_flag.trigger.origin) < _id_3498229C5A4F8731 * 2 * (_id_3498229C5A4F8731 * 2)) {
    _id_0F54364C67CFABC7 = get_ally_flags(self.team);

    if(_id_0F54364C67CFABC7.size == 2 && !scripts\engine\utility::array_contains(_id_0F54364C67CFABC7, self.current_flag) && !bot_allowed_to_3_cap())
      return 0;

    return 1;
  }

  return 0;
}

get_override_flag_targets() {
  return level._id_BBD2674F59FC7FF1[self.team];
}

has_override_flag_targets() {
  _id_88619EBFA03B1898 = get_override_flag_targets();
  return _id_88619EBFA03B1898.size > 0;
}

flag_has_been_captured_before(flag) {
  return !flag_has_never_been_captured(flag);
}

flag_has_never_been_captured(flag) {
  return flag.firstcapture;
}

bot_choose_flag() {
  flag = undefined;
  isattacker = game["attackers"] == self.team;
  _id_39C262926FFA6A00 = !istrue(level.precappoints);
  _id_88619EBFA03B1898 = get_override_flag_targets();

  if(_id_88619EBFA03B1898.size > 0)
    _id_A9DDBDF62EA00196 = _id_88619EBFA03B1898;
  else
    _id_A9DDBDF62EA00196 = bot_get_all_possible_flags();

  if(_id_A9DDBDF62EA00196.size == 0)
    return undefined;

  foreach(flag in _id_A9DDBDF62EA00196) {
    team = flag _id_108FAF3DABBC3E99::getflagteam();

    if(_id_39C262926FFA6A00) {
      if(flag_has_been_captured_before(flag))
        _id_39C262926FFA6A00 = 0;
    }
  }

  if(isattacker) {
    if(_id_A9DDBDF62EA00196.size > 1) {
      triggers = [];

      foreach(_id_38A5994C0CEC51CD in _id_A9DDBDF62EA00196)
      triggers[triggers.size] = _id_38A5994C0CEC51CD.trigger;

      _id_7727A8A4F4A2E7FE = scripts\engine\utility::get_array_of_closest(self.origin, triggers);
      _id_4A204FFC32301EF9 = [];

      foreach(_id_8000A8C17C21D1DE in _id_7727A8A4F4A2E7FE) {
        foreach(objective in level.objectives) {
          if(objective.trigger == _id_8000A8C17C21D1DE)
            _id_4A204FFC32301EF9[_id_4A204FFC32301EF9.size] = objective;
        }
      }

      _id_7727A8A4F4A2E7FE = _id_4A204FFC32301EF9;
    } else
      _id_7727A8A4F4A2E7FE = _id_A9DDBDF62EA00196;

    if(_id_39C262926FFA6A00 && !has_override_flag_targets()) {
      _id_09685536CE2CEDA1 = get_num_allies_capturing_flag(_id_7727A8A4F4A2E7FE[0], 1);

      if(_id_09685536CE2CEDA1 < min_num_bots_assaulting_first_flag())
        _id_01912D561A938BFC = 0;
      else {
        _id_BE069DE8AD079303 = 40;
        _id_C21FF692C3731F37 = 60;

        if(self.strategy_level == 0) {
          _id_BE069DE8AD079303 = 75;
          _id_C21FF692C3731F37 = 25;
        } else if(self.strategy_level == 1) {
          _id_BE069DE8AD079303 = 60;
          _id_C21FF692C3731F37 = 40;
        }

        _id_BE27BAFF78D0797C = randomint(100);

        if(_id_BE27BAFF78D0797C < _id_BE069DE8AD079303)
          _id_01912D561A938BFC = 0;
        else
          _id_01912D561A938BFC = 1;
      }

      goal_type = undefined;

      if(_id_01912D561A938BFC == 0)
        goal_type = "critical";

      capture_flag(_id_7727A8A4F4A2E7FE[_id_01912D561A938BFC], goal_type);
      return;
    }

    if(_id_7727A8A4F4A2E7FE.size == 1)
      flag = _id_7727A8A4F4A2E7FE[0];
    else if(distancesquared(_id_7727A8A4F4A2E7FE[0].trigger.origin, self.origin) < 102400)
      flag = _id_7727A8A4F4A2E7FE[0];
    else {
      _id_168860C6FED89EC2 = [];
      _id_51EED82F15A0C64C = [];
      _id_5EB2D3DB89E5673B = [];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_7727A8A4F4A2E7FE.size; _id_AC0E594AC96AA3A8++) {
        dist = distance(_id_7727A8A4F4A2E7FE[_id_AC0E594AC96AA3A8].trigger.origin, self.origin);
        _id_5EB2D3DB89E5673B[_id_AC0E594AC96AA3A8] = dist;
        _id_51EED82F15A0C64C[_id_AC0E594AC96AA3A8] = dist;
      }

      if(self.strategy_level == 0) {
        _id_BE27BAFF78D0797C = randomint(100);

        if(_id_BE27BAFF78D0797C < 50)
          flag = _id_7727A8A4F4A2E7FE[0];
        else if(_id_BE27BAFF78D0797C < 50 + 50 / (_id_7727A8A4F4A2E7FE.size - 1))
          flag = _id_7727A8A4F4A2E7FE[1];
        else
          flag = _id_7727A8A4F4A2E7FE[2];
      } else if(_id_51EED82F15A0C64C.size == 2) {
        _id_168860C6FED89EC2[0] = 50;
        _id_168860C6FED89EC2[1] = 50;

        if(_id_51EED82F15A0C64C[0] < _id_51EED82F15A0C64C[1]) {
          _id_168860C6FED89EC2[0] = _id_168860C6FED89EC2[0] + 20;
          _id_168860C6FED89EC2[1] = _id_168860C6FED89EC2[1] - 20;
        } else {
          _id_168860C6FED89EC2[0] = _id_168860C6FED89EC2[0] - 20;
          _id_168860C6FED89EC2[1] = _id_168860C6FED89EC2[1] + 20;
        }

        if(_id_5EB2D3DB89E5673B[0] < 640) {
          _id_168860C6FED89EC2[0] = _id_168860C6FED89EC2[0] + 15;
          _id_168860C6FED89EC2[1] = _id_168860C6FED89EC2[1] - 15;
        } else {
          _id_168860C6FED89EC2[0] = _id_168860C6FED89EC2[0] - 15;
          _id_168860C6FED89EC2[1] = _id_168860C6FED89EC2[1] + 15;
        }

        if(self.strategy_level > 0) {
          if(_id_7727A8A4F4A2E7FE[0].curprogress == 1) {
            _id_168860C6FED89EC2[0] = _id_168860C6FED89EC2[0] + 15;
            _id_168860C6FED89EC2[1] = _id_168860C6FED89EC2[1] - 15;
          } else if(_id_7727A8A4F4A2E7FE[0].curprogress == 2) {
            _id_168860C6FED89EC2[0] = _id_168860C6FED89EC2[0] + 20;
            _id_168860C6FED89EC2[1] = _id_168860C6FED89EC2[1] - 20;
          }

          if(_id_7727A8A4F4A2E7FE[1].curprogress == 1) {
            _id_168860C6FED89EC2[0] = _id_168860C6FED89EC2[0] - 15;
            _id_168860C6FED89EC2[1] = _id_168860C6FED89EC2[1] + 15;
          } else if(_id_7727A8A4F4A2E7FE[1].curprogress == 2) {
            _id_168860C6FED89EC2[0] = _id_168860C6FED89EC2[0] - 20;
            _id_168860C6FED89EC2[1] = _id_168860C6FED89EC2[1] + 20;
          }
        }

        _id_BE27BAFF78D0797C = randomint(100);

        if(_id_BE27BAFF78D0797C < _id_168860C6FED89EC2[0])
          flag = _id_7727A8A4F4A2E7FE[0];
        else
          flag = _id_7727A8A4F4A2E7FE[1];
      }
    }
  } else {
    if(_id_A9DDBDF62EA00196.size > 1) {
      triggers = [];

      foreach(_id_8FED5911F92E3192 in _id_A9DDBDF62EA00196)
      triggers[triggers.size] = _id_8FED5911F92E3192.trigger;

      _id_F9E86F3C87AB9F97 = scripts\engine\utility::get_array_of_closest(self.origin, triggers);
      _id_4A204FFC32301EF9 = [];

      foreach(_id_8000A8C17C21D1DE in _id_F9E86F3C87AB9F97) {
        foreach(objective in level.objectives) {
          if(objective.trigger == _id_8000A8C17C21D1DE)
            _id_4A204FFC32301EF9[_id_4A204FFC32301EF9.size] = objective;
        }
      }

      _id_F9E86F3C87AB9F97 = _id_4A204FFC32301EF9;
    } else
      _id_F9E86F3C87AB9F97 = _id_A9DDBDF62EA00196;

    foreach(_id_D0076018172F593C in _id_F9E86F3C87AB9F97) {
      if(bot_should_defend_flag(_id_D0076018172F593C, _id_F9E86F3C87AB9F97.size)) {
        flag = _id_D0076018172F593C;
        break;
      }
    }

    if(!isDefined(flag))
      flag = _id_F9E86F3C87AB9F97[0];
  }

  if(isattacker)
    capture_flag(flag);
  else
    defend_flag(flag);
}

min_num_bots_assaulting_first_flag() {
  _id_6ACE8681F94CDC7C = scripts\mp\bots\bots_util::bot_get_max_players_on_team(self.team);
  return ceil(_id_6ACE8681F94CDC7C / 3);
}

bot_allowed_to_3_cap() {
  if(self.strategy_level == 0)
    return 1;

  _id_88619EBFA03B1898 = get_override_flag_targets();

  if(_id_88619EBFA03B1898.size == 3)
    return 1;

  _id_5A293D5E08A8B462 = scripts\mp\gamescore::_getteamscore(scripts\engine\utility::get_enemy_team(self.team));
  _id_CD5052914E11EB6A = scripts\mp\gamescore::_getteamscore(self.team);
  _id_8F891CBCD9FA1DD1 = 200 - _id_5A293D5E08A8B462;
  _id_30A11EA937E7F319 = 200 - _id_CD5052914E11EB6A;
  _id_D8A3AA3A65A5B213 = _id_30A11EA937E7F319 * 0.5 > _id_8F891CBCD9FA1DD1;
  return _id_D8A3AA3A65A5B213;
}

bot_should_defend(_id_E8D030A9FA5114EE) {
  if(randomfloat(1) < _id_E8D030A9FA5114EE)
    return 1;

  _id_30F9CA2FA8449648 = level.bot_personality_type[self.personality];

  if(_id_30F9CA2FA8449648 == "stationary")
    return 1;
  else if(_id_30F9CA2FA8449648 == "active")
    return 0;
}

capture_flag(_id_F0B1A2262B2F7DFC, _id_1FCE7EA6F52B937E, _id_119041CDA5E9ADF2) {
  self.current_flag = _id_F0B1A2262B2F7DFC;

  if(_id_4646FCBE22380B06()) {
    optional_params["override_goal_type"] = _id_1FCE7EA6F52B937E;
    optional_params["entrance_points_index"] = get_flag_label(_id_F0B1A2262B2F7DFC);
    scripts\mp\bots\bots_strategy::bot_protect_point(_id_F0B1A2262B2F7DFC.trigger.origin, get_flag_protect_radius(), optional_params);
  } else {
    optional_params["override_goal_type"] = _id_1FCE7EA6F52B937E;
    optional_params["entrance_points_index"] = get_flag_label(_id_F0B1A2262B2F7DFC);
    scripts\mp\bots\bots_strategy::bot_capture_zone(_id_F0B1A2262B2F7DFC.trigger.origin, _id_F0B1A2262B2F7DFC.nodes, _id_F0B1A2262B2F7DFC.trigger, optional_params);
  }

  if(!isDefined(_id_119041CDA5E9ADF2) || !_id_119041CDA5E9ADF2)
    thread monitor_flag_status(_id_F0B1A2262B2F7DFC);
}

defend_flag(_id_3E376080E8DC9E3A) {
  self.current_flag = _id_3E376080E8DC9E3A;

  if(_id_39E20401248B86AB()) {
    optional_params["entrance_points_index"] = get_flag_label(_id_3E376080E8DC9E3A);
    scripts\mp\bots\bots_strategy::bot_capture_zone(_id_3E376080E8DC9E3A.trigger.origin, _id_3E376080E8DC9E3A.nodes, _id_3E376080E8DC9E3A.trigger, optional_params);
  } else {
    optional_params["entrance_points_index"] = get_flag_label(_id_3E376080E8DC9E3A);
    optional_params["nearest_node_to_center"] = _id_3E376080E8DC9E3A.nearest_node;
    scripts\mp\bots\bots_strategy::bot_protect_point(_id_3E376080E8DC9E3A.trigger.origin, get_flag_protect_radius(), optional_params);
  }

  thread monitor_flag_status(_id_3E376080E8DC9E3A);
}

get_flag_capture_radius() {
  if(!isDefined(level.capture_radius))
    level.capture_radius = 158;

  return level.capture_radius;
}

get_flag_protect_radius() {
  if(!isDefined(level.protect_radius)) {
    _id_FA52693CF4679C62 = self botgetworldsize();
    _id_DD6786927BDE6332 = (_id_FA52693CF4679C62[0] + _id_FA52693CF4679C62[1]) / 2;
    level.protect_radius = min(1000, _id_DD6786927BDE6332 / 3.5);
  }

  return level.protect_radius;
}

_id_655F3CBE5E705AE5(dialog, location) {
  if(issubstr(dialog, "losing") && dialog != "losing_score" && dialog != "losing_time" && dialog != "gamestate_domlosing") {
    _id_F666BE4A2ABC34F6 = getsubstr(dialog, dialog.size - 2);
    _id_9460C9E466ED3306 = get_specific_flag_by_label(_id_F666BE4A2ABC34F6);

    if(isDefined(_id_9460C9E466ED3306) && bot_allow_to_capture_flag(_id_9460C9E466ED3306)) {
      self botmemoryevent("known_enemy", undefined, _id_9460C9E466ED3306.trigger.origin);

      if(!isDefined(self.last_losing_flag_react) || gettime() - self.last_losing_flag_react > 10000) {
        if(scripts\mp\bots\bots_util::bot_is_protecting()) {
          _id_D493BD9F5A8ADF45 = distancesquared(self.origin, _id_9460C9E466ED3306.trigger.origin) < 490000;
          _id_CBA76C2FA6170699 = bot_is_protecting_flag(_id_9460C9E466ED3306);

          if(_id_D493BD9F5A8ADF45 || _id_CBA76C2FA6170699) {
            capture_flag(_id_9460C9E466ED3306);
            self.last_losing_flag_react = gettime();
          }
        }
      }
    }
  } else if(issubstr(dialog, "secured")) {
    _id_F666BE4A2ABC34F6 = getsubstr(dialog, dialog.size - 2);
    _id_88AC1AB3287F7093 = get_specific_flag_by_label(_id_F666BE4A2ABC34F6);
    _id_88AC1AB3287F7093.last_time_secured[self.team] = gettime();
  }

  scripts\mp\bots\bots_util::bot_leader_dialog(dialog, location);
}

bot_allow_to_capture_flag(flag) {
  _id_88619EBFA03B1898 = get_override_flag_targets();

  if(_id_88619EBFA03B1898.size == 0)
    return 1;

  if(scripts\engine\utility::array_contains(_id_88619EBFA03B1898, flag))
    return 1;

  return 0;
}

monitor_flag_status(flag) {
  self notify("monitor_flag_status");
  self endon("monitor_flag_status");
  self endon("death_or_disconnect");
  level endon("game_ended");
  _id_F2B47E412166C272 = get_num_ally_flags(self.team);
  _id_82FE1C44F0E59DD5 = get_flag_capture_radius() * get_flag_capture_radius();
  _id_9A86288B6E984514 = get_flag_capture_radius() * 3 * (get_flag_capture_radius() * 3);
  _id_278595174C3B888B = 1;

  while(_id_278595174C3B888B) {
    _id_6E24445AC4C031BF = 0;
    _id_A78B2B0EBF2F977F = flag _id_108FAF3DABBC3E99::getflagteam();
    _id_0877F0C734271995 = get_num_ally_flags(self.team);
    _id_EB9BB8ACEEDA2DA3 = get_enemy_flags(self.team);

    if(scripts\mp\bots\bots_util::bot_is_capturing()) {
      if(_id_A78B2B0EBF2F977F == self.team && flag.claimteam == "none") {
        if(!_id_39E20401248B86AB())
          _id_6E24445AC4C031BF = 1;
      }

      if(_id_0877F0C734271995 == 2 && _id_A78B2B0EBF2F977F != self.team && !bot_allowed_to_3_cap()) {
        if(distancesquared(self.origin, flag.trigger.origin) > _id_82FE1C44F0E59DD5)
          _id_6E24445AC4C031BF = 1;
      }

      foreach(_id_5607F7513EB816A2 in _id_EB9BB8ACEEDA2DA3) {
        if(_id_5607F7513EB816A2 != flag && bot_allow_to_capture_flag(_id_5607F7513EB816A2)) {
          if(isDefined(_id_5607F7513EB816A2.trigger) && distancesquared(self.origin, _id_5607F7513EB816A2.trigger.origin) < _id_9A86288B6E984514)
            _id_6E24445AC4C031BF = 1;
        }
      }

      if(isDefined(flag.trigger) && self istouching(flag.trigger) && flag.userate <= 0) {
        if(self bothasscriptgoal()) {
          _id_4CBD8AE83804749C = self botgetscriptgoal();
          script_goal_radius = self botgetscriptgoalRadius();

          if(distancesquared(self.origin, _id_4CBD8AE83804749C) < squared(script_goal_radius)) {
            _id_B6F1DEB8E946E67C = self getnearestnode();

            if(isDefined(_id_B6F1DEB8E946E67C)) {
              _id_1AAF2917E47371A3 = undefined;

              foreach(_id_72F9A5CA05BB7422 in flag.nodes) {
                if(!nodesvisible(_id_72F9A5CA05BB7422, _id_B6F1DEB8E946E67C, 1)) {
                  _id_1AAF2917E47371A3 = _id_72F9A5CA05BB7422.origin;
                  break;
                }
              }

              if(isDefined(_id_1AAF2917E47371A3)) {
                self.defense_investigate_specific_point = _id_1AAF2917E47371A3;
                self notify("defend_force_node_recalculation");
              }
            }
          }
        }
      }
    }

    if(scripts\mp\bots\bots_util::bot_is_protecting()) {
      if(_id_A78B2B0EBF2F977F != self.team) {
        if(!_id_4646FCBE22380B06())
          _id_6E24445AC4C031BF = 1;
      } else if(_id_0877F0C734271995 == 1 && _id_F2B47E412166C272 > 1)
        _id_6E24445AC4C031BF = 1;
    }

    _id_F2B47E412166C272 = _id_0877F0C734271995;

    if(_id_6E24445AC4C031BF) {
      self.force_new_goal = 1;
      _id_278595174C3B888B = 0;
      self notify("needs_new_flag_goal");
      continue;
    }

    result = level scripts\engine\utility::waittill_notify_or_timeout_return("flag_changed_ownership", 1 + randomfloatrange(0, 2));
    _id_A862627B64E75A21 = isDefined(result) && result == "timeout";

    if(!_id_A862627B64E75A21) {
      wait_time = max((3 - self.strategy_level) * 1.0 + randomfloatrange(-0.5, 0.5), 0);
      wait(wait_time);
    }
  }
}

_id_683A18BBD644237D(node) {
  if(node == self.node_closest_to_defend_center)
    return 1.0;

  if(!isDefined(self.current_flag))
    return 1.0;

  _id_F43FB0E14CCFB9E1 = 0;
  _id_A7FF1FE77B4291E1 = get_flag_label(self.current_flag);
  _id_0F54364C67CFABC7 = get_ally_flags(self.team);

  foreach(_id_61733D6E2CBEE46E in _id_0F54364C67CFABC7) {
    if(_id_61733D6E2CBEE46E != self.current_flag)
      _id_F43FB0E14CCFB9E1 = node scripts\mp\bots\bots_util::node_is_on_path_from_labels(_id_A7FF1FE77B4291E1, get_flag_label(_id_61733D6E2CBEE46E));
  }

  if(_id_F43FB0E14CCFB9E1)
    return 0.2;

  return 1.0;
}

get_flag_label(flag) {
  _id_043EF966DEAAD58A = "";

  if(isDefined(flag.teleport_zone))
    _id_043EF966DEAAD58A = _id_043EF966DEAAD58A + (flag.teleport_zone + "_");

  _id_043EF966DEAAD58A = _id_043EF966DEAAD58A + ("flag" + flag.objectivekey);
  return _id_043EF966DEAAD58A;
}

get_other_flag(flag1, _id_5228090A1CF6F05B) {
  foreach(objective in level.objectives) {
    if(objective != flag1 && objective != _id_5228090A1CF6F05B)
      return objective;
  }
}

get_specific_flag_by_letter(_id_607390FDA882B564) {
  _id_043EF966DEAAD58A = "_" + tolower(_id_607390FDA882B564);
  return get_specific_flag_by_label(_id_043EF966DEAAD58A);
}

get_specific_flag_by_label(_id_043EF966DEAAD58A) {
  foreach(objective in level.objectives) {
    if(objective.objectivekey == _id_043EF966DEAAD58A)
      return objective;
  }
}

get_closest_flag(origin) {
  _id_345442A441F6669F = undefined;
  _id_D7E79A673C0D8D21 = undefined;

  foreach(objective in level.objectives) {
    _id_4EA84B05D2E463A4 = distancesquared(objective.trigger.origin, origin);

    if(!isDefined(_id_D7E79A673C0D8D21) || _id_4EA84B05D2E463A4 < _id_D7E79A673C0D8D21) {
      _id_345442A441F6669F = objective;
      _id_D7E79A673C0D8D21 = _id_4EA84B05D2E463A4;
    }
  }

  return _id_345442A441F6669F;
}

get_num_allies_capturing_flag(flag, _id_38C7DA45D31E930E) {
  _id_6FD52C0A557B6A40 = 0;
  _id_3498229C5A4F8731 = get_flag_capture_radius();

  foreach(_id_5ECABDFE40A96663 in level.participants) {
    if(!isDefined(_id_5ECABDFE40A96663.team)) {
      continue;
    }
    if(_id_5ECABDFE40A96663.team == self.team && _id_5ECABDFE40A96663 != self && scripts\mp\utility\entity::isteamparticipant(_id_5ECABDFE40A96663)) {
      if(isai(_id_5ECABDFE40A96663)) {
        if(_id_5ECABDFE40A96663 bot_is_capturing_flag(flag))
          _id_6FD52C0A557B6A40++;

        continue;
      }

      if(!isDefined(_id_38C7DA45D31E930E) || !_id_38C7DA45D31E930E) {
        if(_id_5ECABDFE40A96663 istouching(flag))
          _id_6FD52C0A557B6A40++;
      }
    }
  }

  return _id_6FD52C0A557B6A40;
}

bot_is_capturing_flag(flag) {
  if(!scripts\mp\bots\bots_util::bot_is_capturing())
    return 0;

  return bot_target_is_flag(flag);
}

bot_is_protecting_flag(flag) {
  if(!scripts\mp\bots\bots_util::bot_is_protecting())
    return 0;

  return bot_target_is_flag(flag);
}

bot_target_is_flag(flag) {
  return self.current_flag == flag;
}

get_num_ally_flags(team) {
  count = 0;

  foreach(objective in level.objectives) {
    _id_ECEBC47387DC7C2D = objective _id_108FAF3DABBC3E99::getflagteam();

    if(_id_ECEBC47387DC7C2D == team)
      count++;
  }

  return count;
}

get_enemy_flags(team) {
  flags = [];

  foreach(objective in level.objectives) {
    _id_ECEBC47387DC7C2D = objective _id_108FAF3DABBC3E99::getflagteam();

    if(_id_ECEBC47387DC7C2D == scripts\engine\utility::get_enemy_team(team))
      flags = scripts\engine\utility::array_add(flags, objective);
  }

  return flags;
}

get_ally_flags(team) {
  flags = [];

  foreach(objective in level.objectives) {
    _id_ECEBC47387DC7C2D = objective _id_108FAF3DABBC3E99::getflagteam();

    if(_id_ECEBC47387DC7C2D == team)
      flags = scripts\engine\utility::array_add(flags, objective);
  }

  return flags;
}

bot_should_defend_flag(_id_4A39DA8BBB554C2C, _id_2D7337CDF8F706C0) {
  _id_26D0FE30296086C4 = get_max_num_defenders_wanted_per_flag(_id_2D7337CDF8F706C0);
  _id_89D5717BF18A21ED = get_players_defending_flag(_id_4A39DA8BBB554C2C);
  return _id_89D5717BF18A21ED.size < _id_26D0FE30296086C4;
}

get_max_num_defenders_wanted_per_flag(_id_2D7337CDF8F706C0) {
  _id_6ACE8681F94CDC7C = scripts\mp\bots\bots_util::bot_get_max_players_on_team(self.team);

  if(_id_2D7337CDF8F706C0 == 1)
    return ceil(_id_6ACE8681F94CDC7C);
  else if(_id_2D7337CDF8F706C0 == 2)
    return ceil(_id_6ACE8681F94CDC7C / 2);
  else {}
}

get_players_defending_flag(_id_4A39DA8BBB554C2C) {
  _id_20B890E2DD5949FA = get_flag_protect_radius();
  _id_017C8F3BCDA25F80 = [];

  foreach(_id_5ECABDFE40A96663 in level.participants) {
    if(!isDefined(_id_5ECABDFE40A96663.team)) {
      continue;
    }
    if(_id_5ECABDFE40A96663.team == self.team && _id_5ECABDFE40A96663 != self && scripts\mp\utility\entity::isteamparticipant(_id_5ECABDFE40A96663)) {
      if(isai(_id_5ECABDFE40A96663)) {
        if(_id_5ECABDFE40A96663 bot_is_protecting_flag(_id_4A39DA8BBB554C2C))
          _id_017C8F3BCDA25F80 = scripts\engine\utility::array_add(_id_017C8F3BCDA25F80, _id_5ECABDFE40A96663);

        continue;
      }

      _id_C3D8550CA7E24E40 = gettime() - _id_4A39DA8BBB554C2C.last_time_secured[self.team];

      if(_id_C3D8550CA7E24E40 < 10000) {
        continue;
      }
      if(distancesquared(_id_4A39DA8BBB554C2C.trigger.origin, _id_5ECABDFE40A96663.origin) < _id_20B890E2DD5949FA * _id_20B890E2DD5949FA)
        _id_017C8F3BCDA25F80 = scripts\engine\utility::array_add(_id_017C8F3BCDA25F80, _id_5ECABDFE40A96663);
    }
  }

  return _id_017C8F3BCDA25F80;
}